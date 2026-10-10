/*
 * roboclient - a small IPv4 DHCP client for OPENSTEP 4.2.
 *
 * OPENSTEP has no BPF, no routing sockets and no way to read an interface's
 * hardware address with an ioctl, so this client uses a plain UDP socket bound
 * to port 68 and asks servers to answer by broadcast (RFC 2131, section 4.1,
 * the BROADCAST flag).  Addresses and routes are applied by a script; see
 * roboclient.script.  Written in conservative C for the old NeXT libc (no snprintf,
 * no stdint.h, no poll).
 *
 * Usage: roboclient [-fqn] [-m mac] [-h hostname] [-s script] [-p pidfile]
 *              [-t tries] interface
 *
 * Public domain.
 */
#include <sys/types.h>
#include <sys/time.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>

#ifndef ROBOCLIENT_PREFIX
#define ROBOCLIENT_PREFIX "/usr/local"
#endif
#ifndef ROBOCLIENT_ARP
#define ROBOCLIENT_ARP "/usr/etc/arp -a"
#endif

#ifndef IFNAMSIZ
#define IFNAMSIZ 16
#endif

#define DHCPDISCOVER 1
#define DHCPOFFER    2
#define DHCPREQUEST  3
#define DHCPDECLINE  4
#define DHCPACK      5
#define DHCPNAK      6

#define OPT_PAD      0
#define OPT_SUBNET   1
#define OPT_ROUTER   3
#define OPT_DNS      6
#define OPT_HOSTNAME 12
#define OPT_DOMAIN   15
#define OPT_BCAST    28
#define OPT_NTP      42
#define OPT_REQIP    50
#define OPT_LEASE    51
#define OPT_MSGTYPE  53
#define OPT_SERVERID 54
#define OPT_PARAMREQ 55
#define OPT_MAXSIZE  57
#define OPT_T1       58
#define OPT_T2       59
#define OPT_CLIENTID 61
#define OPT_END      255

#define HDRLEN 240		/* fixed header (236) plus magic cookie */
#define MAXPKT 1500

typedef unsigned char u8;
typedef unsigned long u32;	/* 32 bits on every OPENSTEP target */

struct lease {
    u32 ip, server, mask, bcast, lease, t1, t2;
    char router[64], dns[128], ntp[128], domain[256], hostname[128];
    int have_t1, have_t2, have_bcast;
};

static char *ifname;
static char *scriptpath;
static char *pidfile;
static char hostname_opt[128];
static u8 mac[6];
static int have_mac;
static int sock = -1;
static int foreground, quit_after_lease, no_preinit, daemonized;
static int tries = 3;
static u32 xid;
static int cport = 68, sport = 67;
static char *server_dest = "255.255.255.255";
static char *test_dest;
static volatile int got_term, got_renew;

static void
logmsg(int pri, const char *fmt, const char *arg)
{
    char line[512];

    if (arg != 0)
	sprintf(line, fmt, arg);
    else
	strcpy(line, fmt);
    if (daemonized)
	syslog(pri, "%s", line);
    else
	fprintf(stderr, "roboclient: %s\n", line);
}

static void
die(const char *msg)
{
    char line[512];

    sprintf(line, "%s: %s", msg, strerror(errno));
    logmsg(LOG_ERR, line, 0);
    exit(1);
}

static void
on_term(int sig)
{
    got_term = 1;
}

static void
on_usr1(int sig)
{
    got_renew = 1;
}

static u32
now(void)
{
    struct timeval tv;

    gettimeofday(&tv, 0);
    return (u32) tv.tv_sec;
}

static void
put32(u8 *p, u32 v)
{
    p[0] = (u8) (v >> 24);
    p[1] = (u8) (v >> 16);
    p[2] = (u8) (v >> 8);
    p[3] = (u8) v;
}

static u32
get32(const u8 *p)
{
    return ((u32) p[0] << 24) | ((u32) p[1] << 16) | ((u32) p[2] << 8) | p[3];
}

/* "a:b:c:d:e:f" with 1 or 2 hex digits per octet. */
static int
parse_mac(const char *s, u8 *out)
{
    int i, v, d, n;
    char c;

    for (i = 0; i < 6; i++) {
	v = 0;
	n = 0;
	while ((c = *s) != 0 && c != ':' && c != '-' && n < 2) {
	    if (c >= '0' && c <= '9')
		d = c - '0';
	    else if (c >= 'a' && c <= 'f')
		d = c - 'a' + 10;
	    else if (c >= 'A' && c <= 'F')
		d = c - 'A' + 10;
	    else
		return 0;
	    v = v * 16 + d;
	    n++;
	    s++;
	}
	if (n == 0)
	    return 0;
	out[i] = (u8) v;
	if (i < 5) {
	    if (*s != ':' && *s != '-')
		return 0;
	    s++;
	}
    }
    return *s == 0 || *s == ' ' || *s == '\t' || *s == '\n';
}

static void
trim(char *s)
{
    size_t n = strlen(s);

    while (n > 0 && (s[n - 1] == '\n' || s[n - 1] == ' ' || s[n - 1] == '\t' ||
		     s[n - 1] == '\r'))
	s[--n] = 0;
}

/* Read KEY=value lines from roboclient.conf (the same file the script sources). */
static int
conf_lookup(const char *key, char *out, size_t outlen)
{
    FILE *f;
    char line[256], *p, *v;
    size_t kl = strlen(key);
    int found = 0;

    f = fopen(ROBOCLIENT_PREFIX "/etc/roboclient.conf", "r");
    if (f == 0)
	return 0;
    while (fgets(line, sizeof line, f) != 0) {
	p = line;
	while (*p == ' ' || *p == '\t')
	    p++;
	if (strncmp(p, key, kl) != 0 || p[kl] != '=')
	    continue;
	v = p + kl + 1;
	trim(v);
	if (*v == '"' || *v == '\'') {
	    char q = *v++;
	    char *e = strchr(v, q);
	    if (e != 0)
		*e = 0;
	}
	if (strlen(v) < outlen) {
	    strcpy(out, v);
	    found = 1;
	}
    }
    fclose(f);
    return found;
}

static u32
iface_addr(void)
{
    struct ifreq ifr;
    struct sockaddr_in *sin;
    int s;
    u32 a = 0;

    s = socket(AF_INET, SOCK_DGRAM, 0);
    if (s < 0)
	return 0;
    memset(&ifr, 0, sizeof ifr);
    strncpy(ifr.ifr_name, ifname, sizeof ifr.ifr_name - 1);
    if (ioctl(s, SIOCGIFADDR, (char *) &ifr) == 0) {
	sin = (struct sockaddr_in *) &ifr.ifr_addr;
	a = ntohl(sin->sin_addr.s_addr);
    }
    close(s);
    return a;
}

/* Best effort: find "(ip) at aa:bb:..." for the interface's own address. */
static int
mac_from_arp(u8 *out)
{
    FILE *p;
    char line[512], key[64], *at, *tok;
    u32 a = iface_addr();
    struct in_addr ia;
    int ok = 0;

    if (a == 0)
	return 0;
    ia.s_addr = htonl(a);
    sprintf(key, "(%s)", inet_ntoa(ia));
    p = popen(ROBOCLIENT_ARP, "r");
    if (p == 0)
	return 0;
    while (!ok && fgets(line, sizeof line, p) != 0) {
	if (strstr(line, key) == 0)
	    continue;
	at = strstr(line, " at ");
	if (at == 0)
	    continue;
	tok = at + 4;
	ok = parse_mac(tok, out);
    }
    pclose(p);
    return ok;
}

static void
find_mac(void)
{
    char key[64], val[64];

    if (have_mac)
	return;
    sprintf(key, "MAC_%s", ifname);
    if ((conf_lookup(key, val, sizeof val) || conf_lookup("MAC", val, sizeof val))
	&& parse_mac(val, mac)) {
	have_mac = 1;
	return;
    }
    if (mac_from_arp(mac)) {
	have_mac = 1;
	return;
    }
    logmsg(LOG_ERR,
	   "cannot determine the hardware address of %s; use -m or set MAC_%s in roboclient.conf",
	   ifname);
    exit(1);
}

/* ---- packet construction ---- */

static u8 *
addopt(u8 *p, int code, int len, const void *data)
{
    *p++ = (u8) code;
    *p++ = (u8) len;
    memcpy(p, data, len);
    return p + len;
}

static int
build(u8 *buf, int type, u32 ciaddr, u32 reqip, u32 serverid, int bcastflag)
{
    u8 *p;
    u8 t = (u8) type, cid[7];
    static const u8 params[] = { OPT_SUBNET, OPT_ROUTER, OPT_DNS, OPT_HOSTNAME,
				 OPT_DOMAIN, OPT_BCAST, OPT_NTP, OPT_T1, OPT_T2 };
    u8 tmp[4];
    u8 size[2];

    memset(buf, 0, HDRLEN);
    buf[0] = 1;			/* BOOTREQUEST */
    buf[1] = 1;			/* Ethernet */
    buf[2] = 6;
    put32(buf + 4, xid);
    if (bcastflag)
	buf[10] = 0x80;
    put32(buf + 12, ciaddr);
    memcpy(buf + 28, mac, 6);
    buf[236] = 99; buf[237] = 130; buf[238] = 83; buf[239] = 99;
    p = buf + HDRLEN;
    p = addopt(p, OPT_MSGTYPE, 1, &t);
    cid[0] = 1;
    memcpy(cid + 1, mac, 6);
    p = addopt(p, OPT_CLIENTID, 7, cid);
    if (hostname_opt[0] != 0)
	p = addopt(p, OPT_HOSTNAME, (int) strlen(hostname_opt), hostname_opt);
    if (reqip != 0) {
	put32(tmp, reqip);
	p = addopt(p, OPT_REQIP, 4, tmp);
    }
    if (serverid != 0) {
	put32(tmp, serverid);
	p = addopt(p, OPT_SERVERID, 4, tmp);
    }
    size[0] = (u8) (MAXPKT >> 8);
    size[1] = (u8) (MAXPKT & 0xff);
    p = addopt(p, OPT_MAXSIZE, 2, size);
    p = addopt(p, OPT_PARAMREQ, sizeof params, params);
    *p++ = OPT_END;
    while (p - buf < 300)	/* old BOOTP relays want a minimum size */
	*p++ = 0;
    return (int) (p - buf);
}

static void
send_to(const u8 *buf, int len, const char *dest)
{
    struct sockaddr_in to;

    memset(&to, 0, sizeof to);
    to.sin_family = AF_INET;
    to.sin_port = htons((unsigned short) sport);
    to.sin_addr.s_addr = inet_addr(dest);
    if (sendto(sock, (char *) buf, len, 0, (struct sockaddr *) &to, sizeof to) < 0)
	logmsg(LOG_WARNING, "sendto failed", 0);
}

static void
ipstr(u32 a, char *out)
{
    struct in_addr ia;

    ia.s_addr = htonl(a);
    strcpy(out, inet_ntoa(ia));
}

static void
addlist(char *dst, size_t dstlen, const u8 *v, int len)
{
    int i;
    char one[32];

    dst[0] = 0;
    for (i = 0; i + 4 <= len; i += 4) {
	ipstr(get32(v + i), one);
	if (strlen(dst) + strlen(one) + 2 >= dstlen)
	    break;
	if (dst[0] != 0)
	    strcat(dst, " ");
	strcat(dst, one);
    }
}

static void
copystr(char *dst, size_t dstlen, const u8 *v, int len)
{
    if ((size_t) len >= dstlen)
	len = (int) dstlen - 1;
    memcpy(dst, v, len);
    dst[len] = 0;
    /* NUL-terminated by some servers; also drop anything unprintable. */
    {
	int i;
	for (i = 0; dst[i] != 0; i++)
	    if (dst[i] < ' ' || dst[i] > '~' || dst[i] == '\'' || dst[i] == '`'
		|| dst[i] == '$' || dst[i] == '\\' || dst[i] == '"')
		dst[i] = '_';
    }
}

/*
 * Parse a reply.  Returns the DHCP message type, or -1 if it is not a reply
 * for us.  Fills in *l with whatever the reply carries.
 */
static int
parse(const u8 *buf, int len, struct lease *l)
{
    const u8 *p, *end;
    int type = -1, code, olen;

    memset(l, 0, sizeof *l);
    if (len < HDRLEN + 3 || buf[0] != 2 || get32(buf + 4) != xid)
	return -1;
    if (memcmp(buf + 28, mac, 6) != 0)
	return -1;
    if (buf[236] != 99 || buf[237] != 130 || buf[238] != 83 || buf[239] != 99)
	return -1;
    l->ip = get32(buf + 16);
    p = buf + HDRLEN;
    end = buf + len;
    while (p < end) {
	code = *p++;
	if (code == OPT_PAD)
	    continue;
	if (code == OPT_END)
	    break;
	if (p >= end)
	    break;
	olen = *p++;
	if (p + olen > end)
	    break;
	switch (code) {
	case OPT_MSGTYPE:
	    if (olen == 1)
		type = p[0];
	    break;
	case OPT_SERVERID:
	    if (olen == 4)
		l->server = get32(p);
	    break;
	case OPT_SUBNET:
	    if (olen == 4)
		l->mask = get32(p);
	    break;
	case OPT_BCAST:
	    if (olen == 4) {
		l->bcast = get32(p);
		l->have_bcast = 1;
	    }
	    break;
	case OPT_LEASE:
	    if (olen == 4)
		l->lease = get32(p);
	    break;
	case OPT_T1:
	    if (olen == 4) {
		l->t1 = get32(p);
		l->have_t1 = 1;
	    }
	    break;
	case OPT_T2:
	    if (olen == 4) {
		l->t2 = get32(p);
		l->have_t2 = 1;
	    }
	    break;
	case OPT_ROUTER:
	    addlist(l->router, sizeof l->router, p, olen);
	    break;
	case OPT_DNS:
	    addlist(l->dns, sizeof l->dns, p, olen);
	    break;
	case OPT_NTP:
	    addlist(l->ntp, sizeof l->ntp, p, olen);
	    break;
	case OPT_DOMAIN:
	    copystr(l->domain, sizeof l->domain, p, olen);
	    break;
	case OPT_HOSTNAME:
	    copystr(l->hostname, sizeof l->hostname, p, olen);
	    break;
	}
	p += olen;
    }
    return type;
}

/*
 * Wait up to `secs` seconds for a reply of type `want1` or `want2`.  Returns
 * the type received (filling *l), 0 on timeout, -2 if a signal wants attention.
 */
static int
wait_reply(int secs, int want1, int want2, struct lease *l)
{
    u8 buf[MAXPKT + 64];
    fd_set rfds;
    struct timeval tv;
    u32 deadline = now() + secs, t;
    int n, type;

    for (;;) {
	if (got_term || got_renew)
	    return -2;
	t = now();
	if (t >= deadline)
	    return 0;
	tv.tv_sec = deadline - t;
	tv.tv_usec = 0;
	FD_ZERO(&rfds);
	FD_SET(sock, &rfds);
	n = select(sock + 1, &rfds, 0, 0, &tv);
	if (n < 0) {
	    if (errno == EINTR)
		continue;
	    die("select");
	}
	if (n == 0)
	    return 0;
	n = recv(sock, (char *) buf, sizeof buf, 0);
	if (n <= 0)
	    continue;
	type = parse(buf, n, l);
	if (type == want1 || type == want2)
	    return type;
    }
}

/* ---- running the script ---- */

extern char **environ;

#define MAXENV 64
static char *envv[MAXENV];
static int envn;

static void
addenv(const char *name, const char *value)
{
    char *s;

    if (envn >= MAXENV - 1)
	return;
    s = (char *) malloc(strlen(name) + strlen(value) + 2);
    if (s == 0)
	return;
    sprintf(s, "%s=%s", name, value);
    envv[envn++] = s;
}

static void
run_script(const char *reason, const struct lease *l)
{
    char tmp[64];
    char *args[4];
    int pid, i, rv;

    for (i = 0; i < envn; i++)
	free(envv[i]);
    envn = 0;
    addenv("PATH", ROBOCLIENT_PREFIX "/bin:/usr/ucb:/bin:/usr/bin:/usr/etc:/etc");
    addenv("interface", ifname);
    addenv("reason", reason);
    if (l != 0 && l->ip != 0) {
	ipstr(l->ip, tmp); addenv("ip", tmp);
	if (l->mask != 0) {
	    ipstr(l->mask, tmp); addenv("subnet", tmp);
	}
	if (l->have_bcast) {
	    ipstr(l->bcast, tmp); addenv("broadcast", tmp);
	}
	ipstr(l->server, tmp); addenv("serverid", tmp);
	addenv("router", l->router);
	addenv("dns", l->dns);
	addenv("ntpsrv", l->ntp);
	addenv("domain", l->domain);
	addenv("hostname", l->hostname);
	sprintf(tmp, "%lu", l->lease); addenv("lease", tmp);
    }
    envv[envn] = 0;
    args[0] = "sh";
    args[1] = scriptpath;
    args[2] = (char *) reason;
    args[3] = 0;
    pid = fork();
    if (pid == 0) {
	execve("/bin/sh", args, envv);
	_exit(127);
    }
    if (pid > 0) {
	while ((rv = wait((void *) 0)) != pid && !(rv < 0 && errno != EINTR))
	    ;
    }
}

/* ---- the state machine ---- */

static u32
mask_to_bcast(u32 ip, u32 mask)
{
    return (ip & mask) | ~mask;
}

static void
finish_lease(struct lease *l)
{
    if (l->mask == 0) {
	if ((l->ip >> 24) < 128)
	    l->mask = 0xff000000UL;
	else if ((l->ip >> 24) < 192)
	    l->mask = 0xffff0000UL;
	else
	    l->mask = 0xffffff00UL;
    }
    if (!l->have_bcast) {
	l->bcast = mask_to_bcast(l->ip, l->mask) & 0xffffffffUL;
	l->have_bcast = 1;
    }
    if (l->lease == 0)
	l->lease = 3600;
    if (!l->have_t1 || l->t1 == 0 || l->t1 >= l->lease)
	l->t1 = l->lease / 2;
    if (!l->have_t2 || l->t2 == 0 || l->t2 <= l->t1 || l->t2 >= l->lease)
	l->t2 = l->lease - l->lease / 8;
}

static void
new_xid(void)
{
    struct timeval tv;

    gettimeofday(&tv, 0);
    xid = ((u32) tv.tv_usec * 2654435761UL) ^ (u32) tv.tv_sec ^
	((u32) getpid() << 16) ^ get32(mac + 2);
    xid &= 0xffffffffUL;
}

/* Broadcast DISCOVER until an OFFER arrives.  Returns 1 on success. */
static int
discover(struct lease *offer)
{
    u8 pkt[MAXPKT];
    int len, i, r, wait = 4;

    new_xid();
    for (i = 0; tries == 0 || i < tries; i++) {
	len = build(pkt, DHCPDISCOVER, 0, 0, 0, 1);
	send_to(pkt, len, server_dest);
	r = wait_reply(wait, DHCPOFFER, DHCPOFFER, offer);
	if (r == DHCPOFFER && offer->ip != 0)
	    return 1;
	if (r == -2)
	    return 0;
	if (wait < 32)
	    wait *= 2;
    }
    return 0;
}

/* Returns DHCPACK, DHCPNAK, or 0 (no answer). */
static int
request_lease(const struct lease *offer, struct lease *got)
{
    u8 pkt[MAXPKT];
    int len, i, r;

    for (i = 0; i < 3; i++) {
	len = build(pkt, DHCPREQUEST, 0, offer->ip, offer->server, 1);
	send_to(pkt, len, server_dest);
	r = wait_reply(4 << i, DHCPACK, DHCPNAK, got);
	if (r == DHCPACK || r == DHCPNAK)
	    return r;
	if (r == -2)
	    return 0;
    }
    return 0;
}

/* Renew or rebind: the request carries ciaddr and no server-id. */
static int
renew_lease(const struct lease *cur, const char *dest, int secs, struct lease *got)
{
    u8 pkt[MAXPKT];
    int len, r;

    got_renew = 0;
    new_xid();
    len = build(pkt, DHCPREQUEST, cur->ip, 0, 0, 0);
    send_to(pkt, len, dest);
    r = wait_reply(secs, DHCPACK, DHCPNAK, got);
    return (r == DHCPACK || r == DHCPNAK) ? r : 0;
}

/* How long to wait for an answer before retrying: half the time left, at
 * least 4 and at most 60 seconds (RFC 2131, section 4.4.5). */
static int
retry_wait(u32 deadline)
{
    u32 t = now();
    long left = deadline > t ? (long) (deadline - t) : 0;
    long w = left / 2;

    if (w < 4)
	w = 4;
    if (w > 60)
	w = 60;
    if (w > left && left > 0)
	w = left;
    return (int) w;
}

static void
write_pid(void)
{
    FILE *f;

    if (pidfile == 0)
	return;
    f = fopen(pidfile, "w");
    if (f != 0) {
	fprintf(f, "%d\n", (int) getpid());
	fclose(f);
    }
}

static void
go_background(void)
{
    int pid;

    if (foreground || daemonized)
	return;
    fflush(stdout);
    fflush(stderr);
    pid = fork();
    if (pid < 0)
	die("fork");
    if (pid > 0)
	_exit(0);
    close(0);
    close(1);
    close(2);
    open("/dev/null", 2);
    dup(0);
    dup(0);
    signal(SIGHUP, SIG_IGN);
    openlog("roboclient", LOG_PID, LOG_DAEMON);
    daemonized = 1;
    write_pid();
}

static void
usage(void)
{
    fprintf(stderr,
	    "usage: roboclient [-fqn] [-m mac] [-h hostname] [-s script] [-p pidfile]"
	    " [-t tries] interface\n"
	    "  -f  stay in the foreground     -q  quit once a lease is obtained\n"
	    "  -n  never reconfigure the interface before the lease is bound\n"
	    "  -t  DISCOVER attempts before giving up (0 = forever, default 3)\n");
    exit(2);
}

int
main(int argc, char **argv)
{
    struct lease offer, cur, got;
    struct sockaddr_in me;
    int on = 1, r, c;
    u32 bound_at;
    char buf[64], *ep;
    extern char *optarg;
    extern int optind;

    scriptpath = ROBOCLIENT_PREFIX "/share/roboclient/roboclient.script";
    while ((c = getopt(argc, argv, "fqnm:h:s:p:t:")) != EOF) {
	switch (c) {
	case 'f': foreground = 1; break;
	case 'q': quit_after_lease = 1; break;
	case 'n': no_preinit = 1; break;
	case 'm':
	    if (!parse_mac(optarg, mac)) {
		fprintf(stderr, "roboclient: bad hardware address: %s\n", optarg);
		return 2;
	    }
	    have_mac = 1;
	    break;
	case 'h':
	    if (strlen(optarg) >= sizeof hostname_opt)
		usage();
	    strcpy(hostname_opt, optarg);
	    break;
	case 's': scriptpath = optarg; break;
	case 'p': pidfile = optarg; break;
	case 't':
	    tries = (int) strtol(optarg, &ep, 10);
	    if (*ep != 0 || tries < 0)
		usage();
	    break;
	default: usage();
	}
    }
    if (argc - optind != 1)
	usage();
    ifname = argv[optind];
    if (strlen(ifname) >= IFNAMSIZ)
	usage();
    if ((ep = getenv("ROBOCLIENT_SERVER")) != 0) server_dest = test_dest = ep;
    if ((ep = getenv("ROBOCLIENT_SERVER_PORT")) != 0) sport = atoi(ep);
    if ((ep = getenv("ROBOCLIENT_CLIENT_PORT")) != 0) cport = atoi(ep);

    if (getuid() != 0) {
	fprintf(stderr, "roboclient: must be run as root\n");
	return 1;
    }
    find_mac();
    if (hostname_opt[0] == 0)
	conf_lookup("HOSTNAME", hostname_opt, sizeof hostname_opt);

    signal(SIGTERM, on_term);
    signal(SIGINT, on_term);
    signal(SIGUSR1, on_usr1);

    sock = socket(AF_INET, SOCK_DGRAM, 0);
    if (sock < 0)
	die("socket");
    setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, (char *) &on, sizeof on);
    setsockopt(sock, SOL_SOCKET, SO_BROADCAST, (char *) &on, sizeof on);
    memset(&me, 0, sizeof me);
    me.sin_family = AF_INET;
    me.sin_port = htons((unsigned short) cport);
    me.sin_addr.s_addr = htonl(INADDR_ANY);
    if (bind(sock, (struct sockaddr *) &me, sizeof me) < 0)
	die("bind (is another DHCP client running?)");

    for (;;) {
	/* ---- INIT: get a lease ---- */
	if (!no_preinit && iface_addr() == 0)
	    run_script("PREINIT", 0);
	for (;;) {
	    if (got_term)
		goto out;
	    got_renew = 0;
	    if (!discover(&offer)) {
		if (got_term)
		    goto out;
		if (tries != 0 && !got_renew) {
		    logmsg(LOG_ERR, "no DHCP offers received on %s", ifname);
		    run_script("TIMEOUT", 0);
		    if (!daemonized)
			return 1;
		}
		continue;
	    }
	    ipstr(offer.ip, buf);
	    logmsg(LOG_INFO, "offered %s", buf);
	    r = request_lease(&offer, &got);
	    if (r == DHCPACK && got.ip != 0)
		break;
	    if (r == DHCPNAK)
		logmsg(LOG_WARNING, "server declined the request, starting over", 0);
	}
	cur = got;
	if (cur.server == 0)
	    cur.server = offer.server;
	finish_lease(&cur);
	bound_at = now();
	ipstr(cur.ip, buf);
	logmsg(LOG_INFO, "leased %s", buf);
	run_script("BOUND", &cur);
	if (quit_after_lease)
	    goto out;
	go_background();
	if (cur.lease == 0xffffffffUL) {
	    /* infinite lease: nothing to renew; wait for a signal */
	    while (!got_term && !got_renew)
		pause();
	    if (got_term)
		goto out;
	    got_renew = 0;
	}

	/* ---- BOUND/RENEWING/REBINDING ---- */
	for (;;) {
	    /* sleep until T1 */
	    while (!got_term && !got_renew && now() < bound_at + cur.t1) {
		struct timeval tv;
		tv.tv_sec = 1;
		tv.tv_usec = 0;
		select(0, 0, 0, 0, &tv);
	    }
	    if (got_term)
		goto out;
	    got_renew = 0;
	    r = 0;
	    /* RENEWING: unicast to the server until T2 */
	    while (now() < bound_at + cur.t2 && !got_term) {
		ipstr(cur.server, buf);
		if (test_dest != 0)
		    strcpy(buf, test_dest);
		r = renew_lease(&cur, buf, retry_wait(bound_at + cur.t2), &got);
		if (r != 0)
		    break;
	    }
	    if (got_term)
		goto out;
	    if (r == 0) {
		/* REBINDING: broadcast until the lease runs out */
		while (now() < bound_at + cur.lease && !got_term) {
		    r = renew_lease(&cur, server_dest,
				    retry_wait(bound_at + cur.lease), &got);
		    if (r != 0)
			break;
		}
	    }
	    if (got_term)
		goto out;
	    if (r == DHCPACK && got.ip == cur.ip) {
		got.server = got.server ? got.server : cur.server;
		cur = got;
		finish_lease(&cur);
		bound_at = now();
		logmsg(LOG_INFO, "lease renewed", 0);
		run_script("RENEW", &cur);
		continue;
	    }
	    if (r == DHCPACK) {
		/* different address: treat as a new lease */
		got.server = got.server ? got.server : cur.server;
		cur = got;
		finish_lease(&cur);
		bound_at = now();
		run_script("BOUND", &cur);
		continue;
	    }
	    logmsg(r == DHCPNAK ? LOG_WARNING : LOG_ERR,
		   r == DHCPNAK ? "lease refused, starting over"
		   : "lease expired, starting over", 0);
	    run_script("EXPIRE", &cur);
	    break;
	}
    }
out:
    if (pidfile != 0 && daemonized)
	unlink(pidfile);
    return 0;
}
