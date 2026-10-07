/*
 * roboclient-testd - a one-shot fake DHCP server used by roboclient's package test.
 * Answers one DISCOVER with an OFFER and one REQUEST with an ACK, always to
 * 127.0.0.1, then exits.  Usage: roboclient-testd server-port client-port
 */
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef unsigned char u8;

static int
msgtype(const u8 *p, int n)
{
    int i = 240;

    while (i + 2 < n && p[i] != 255) {
	if (p[i] == 0) { i++; continue; }
	if (p[i] == 53)
	    return p[i + 2];
	i += 2 + p[i + 1];
    }
    return 0;
}

static int
reply(u8 *out, const u8 *req, int type)
{
    static const u8 opts[] = {
	54, 4, 127, 0, 0, 1,		/* server id */
	51, 4, 0, 0, 14, 16,		/* lease 3600 */
	1, 4, 255, 255, 255, 0,		/* subnet */
	3, 4, 192, 168, 7, 1,		/* router */
	6, 8, 192, 168, 7, 1, 8, 8, 8, 8, /* dns */
	15, 7, 'l', 'a', 'n', '.', 'x', 'y', 'z', 255 };
    u8 *p;

    memset(out, 0, 240);
    out[0] = 2; out[1] = 1; out[2] = 6;
    memcpy(out + 4, req + 4, 4);		/* xid */
    memcpy(out + 10, req + 10, 2);	/* flags */
    out[16] = 192; out[17] = 168; out[18] = 7; out[19] = 50;
    memcpy(out + 28, req + 28, 16);	/* chaddr */
    out[236] = 99; out[237] = 130; out[238] = 83; out[239] = 99;
    p = out + 240;
    *p++ = 53; *p++ = 1; *p++ = (u8) type;
    memcpy(p, opts, sizeof opts);
    return (int) (p - out) + (int) sizeof opts;
}

int
main(int argc, char **argv)
{
    struct sockaddr_in me, from, to;
    int s, n, t, on = 1, done = 0;
    int len;
    u8 buf[1500], out[600];
    int fromlen;

    if (argc != 3)
	return 2;
    s = socket(AF_INET, SOCK_DGRAM, 0);
    setsockopt(s, SOL_SOCKET, SO_REUSEADDR, (char *) &on, sizeof on);
    memset(&me, 0, sizeof me);
    me.sin_family = AF_INET;
    me.sin_port = htons((unsigned short) atoi(argv[1]));
    me.sin_addr.s_addr = inet_addr("127.0.0.1");
    if (bind(s, (struct sockaddr *) &me, sizeof me) < 0) {
	perror("roboclient-testd: bind");
	return 1;
    }
    memset(&to, 0, sizeof to);
    to.sin_family = AF_INET;
    to.sin_port = htons((unsigned short) atoi(argv[2]));
    to.sin_addr.s_addr = inet_addr("127.0.0.1");
    printf("ready\n");
    fflush(stdout);
    while (done < 2) {
	fromlen = sizeof from;
	n = recvfrom(s, (char *) buf, sizeof buf, 0, (struct sockaddr *) &from, &fromlen);
	if (n < 240)
	    continue;
	t = msgtype(buf, n);
	if (t == 1 || t == 3) {
	    len = reply(out, buf, t == 1 ? 2 : 5);
	    sendto(s, (char *) out, len, 0, (struct sockaddr *) &to, sizeof to);
	    done = t == 1 ? 1 : 2;
	}
    }
    return 0;
}
