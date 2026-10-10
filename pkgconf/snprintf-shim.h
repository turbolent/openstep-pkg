/*
 * snprintf() and vsnprintf() for systems whose libc lacks them (OPENSTEP).
 * Integers, strings and characters are formatted here; floating point
 * conversions are handed to the system sprintf() with a bounded spec.
 * Included into every pkgconf source file with -include; the functions are
 * static, so nothing needs linking and nothing leaks into the public API.
 * Public domain.
 */
#ifndef PKGCONF_OPENSTEP_SNPRINTF_H
#define PKGCONF_OPENSTEP_SNPRINTF_H

#include <stdio.h>
#include <stdarg.h>
#include <stddef.h>
#include <string.h>

struct xml_ostep_out {
    char *buf;
    size_t size;	/* room for characters, excluding the terminator */
    size_t len;		/* characters produced so far */
};

static void
xml_ostep_put(struct xml_ostep_out *o, char c)
{
    if (o->len < o->size)
        o->buf[o->len] = c;
    o->len++;
}

static void
xml_ostep_pad(struct xml_ostep_out *o, char c, int n)
{
    while (n-- > 0)
        xml_ostep_put(o, c);
}

static void
xml_ostep_puts(struct xml_ostep_out *o, const char *s, size_t n)
{
    size_t i;

    for (i = 0; i < n; i++)
        xml_ostep_put(o, s[i]);
}

static int
xml_ostep_vsnprintf(char *buf, size_t size, const char *fmt, va_list ap)
{
    struct xml_ostep_out o;
    const char *p = fmt;

    o.buf = buf;
    o.size = size > 0 ? size - 1 : 0;
    o.len = 0;

    while (*p != 0) {
        int left = 0, plus = 0, space = 0, alt = 0, zero = 0;
        int width = 0, prec = -1, lmod = 0, conv, n;
        char digits[80], fspec[40], tmp[4096];
        const char *str;
        size_t slen, dlen;
        int signchar, i;

        if (*p != '%') {
            xml_ostep_put(&o, *p++);
            continue;
        }
        p++;
        for (;; p++) {
            if (*p == '-') left = 1;
            else if (*p == '+') plus = 1;
            else if (*p == ' ') space = 1;
            else if (*p == '#') alt = 1;
            else if (*p == '0') zero = 1;
            else break;
        }
        if (*p == '*') {
            width = va_arg(ap, int);
            if (width < 0) {
                left = 1;
                width = -width;
            }
            p++;
        } else {
            while (*p >= '0' && *p <= '9') {
                if (width < 100000)
                    width = width * 10 + (*p - '0');
                p++;
            }
        }
        if (*p == '.') {
            p++;
            prec = 0;
            if (*p == '*') {
                prec = va_arg(ap, int);
                p++;
            } else {
                while (*p >= '0' && *p <= '9') {
                    if (prec < 100000)
                        prec = prec * 10 + (*p - '0');
                    p++;
                }
            }
        }
        /* lmod: 1 hh, 2 h, 3 l, 4 ll (also q, j), 5 z/t (pointer sized), 6 L */
        for (;; p++) {
            if (*p == 'h') lmod = (lmod == 2) ? 1 : 2;
            else if (*p == 'l') lmod = (lmod == 3) ? 4 : 3;
            else if (*p == 'q' || *p == 'j') lmod = 4;
            else if (*p == 'z' || *p == 't') lmod = 5;
            else if (*p == 'L') lmod = 6;
            else break;
        }
        conv = *p;
        if (conv == 0)
            break;
        p++;

        switch (conv) {
        case '%':
            xml_ostep_put(&o, '%');
            break;
        case 'c':
            n = va_arg(ap, int);
            if (!left)
                xml_ostep_pad(&o, ' ', width - 1);
            xml_ostep_put(&o, (char) n);
            if (left)
                xml_ostep_pad(&o, ' ', width - 1);
            break;
        case 's':
            str = va_arg(ap, const char *);
            if (str == NULL)
                str = "(null)";
            slen = 0;
            while ((prec < 0 || (int) slen < prec) && str[slen] != 0)
                slen++;
            if (!left)
                xml_ostep_pad(&o, ' ', width - (int) slen);
            xml_ostep_puts(&o, str, slen);
            if (left)
                xml_ostep_pad(&o, ' ', width - (int) slen);
            break;
        case 'd': case 'i': case 'u': case 'o': case 'x': case 'X': case 'p': {
            unsigned long long v;
            int neg = 0, base = 10, upper = (conv == 'X');
            int isptr = (conv == 'p');
            int sgn = (conv == 'd' || conv == 'i');

            if (isptr) {
                v = (unsigned long long) (unsigned long) va_arg(ap, void *);
                base = 16;
                alt = 1;
            } else if (sgn) {
                long long sv;
                if (lmod == 4) sv = va_arg(ap, long long);
                else if (lmod == 3 || lmod == 5) sv = va_arg(ap, long);
                else {
                    sv = va_arg(ap, int);
                    if (lmod == 1) sv = (signed char) sv;
                    else if (lmod == 2) sv = (short) sv;
                }
                if (sv < 0) {
                    neg = 1;
                    v = 0ULL - (unsigned long long) sv;
                } else
                    v = (unsigned long long) sv;
            } else {
                if (lmod == 4) v = va_arg(ap, unsigned long long);
                else if (lmod == 3 || lmod == 5) v = va_arg(ap, unsigned long);
                else {
                    v = va_arg(ap, unsigned int);
                    if (lmod == 1) v = (unsigned char) v;
                    else if (lmod == 2) v = (unsigned short) v;
                }
                if (conv == 'o') base = 8;
                else if (conv == 'x' || conv == 'X') base = 16;
            }
            dlen = 0;
            if (v == 0 && prec == 0) {
                /* no digits at all */
            } else {
                do {
                    int d = (int) (v % (unsigned) base);
                    digits[dlen++] = (char) (d < 10 ? '0' + d :
                        (upper ? 'A' : 'a') + d - 10);
                    v /= (unsigned) base;
                } while (v != 0 && dlen < sizeof digits);
            }
            {
                int zeros = 0, prefixlen = 0;
                char prefix[3];

                signchar = 0;
                if (sgn) {
                    if (neg) signchar = '-';
                    else if (plus) signchar = '+';
                    else if (space) signchar = ' ';
                }
                if (alt && base == 16 && (isptr || dlen > 0) &&
                    !(dlen == 1 && digits[0] == '0' && !isptr)) {
                    prefix[prefixlen++] = '0';
                    prefix[prefixlen++] = upper ? 'X' : 'x';
                }
                if (prec >= 0) {
                    if ((int) dlen < prec)
                        zeros = prec - (int) dlen;
                    zero = 0;
                }
                if (alt && base == 8 && zeros == 0 &&
                    (dlen == 0 || digits[dlen - 1] != '0'))
                    zeros = 1;
                n = (int) dlen + zeros + prefixlen + (signchar ? 1 : 0);
                if (zero && !left && width > n) {
                    zeros += width - n;
                    n = width;
                }
                if (!left)
                    xml_ostep_pad(&o, ' ', width - n);
                if (signchar)
                    xml_ostep_put(&o, (char) signchar);
                for (i = 0; i < prefixlen; i++)
                    xml_ostep_put(&o, prefix[i]);
                xml_ostep_pad(&o, '0', zeros);
                for (i = (int) dlen - 1; i >= 0; i--)
                    xml_ostep_put(&o, digits[i]);
                if (left)
                    xml_ostep_pad(&o, ' ', width - n);
            }
            break;
        }
        case 'e': case 'E': case 'f': case 'F': case 'g': case 'G': {
            /* hand floating point to sprintf, with width and precision capped
             * so the result always fits in tmp */
            char *q = fspec;
            int w = width > 1000 ? 1000 : width;
            int pr = prec > 500 ? 500 : prec;
            int fc = conv;

            *q++ = '%';
            if (left) *q++ = '-';
            if (plus) *q++ = '+';
            if (space) *q++ = ' ';
            if (alt) *q++ = '#';
            if (zero) *q++ = '0';
            if (w > 0) { sprintf(q, "%d", w); q += strlen(q); }
            if (pr >= 0) { *q++ = '.'; sprintf(q, "%d", pr); q += strlen(q); }
            if (fc == 'F') fc = 'f';
            if (lmod == 6) {
                long double ld = va_arg(ap, long double);
                *q++ = 'L'; *q++ = (char) fc; *q = 0;
                sprintf(tmp, fspec, ld);
            } else {
                double d = va_arg(ap, double);
                *q++ = (char) fc; *q = 0;
                sprintf(tmp, fspec, d);
            }
            if (conv == 'F') {
                char *t;
                for (t = tmp; *t; t++)
                    if (*t == 'n' || *t == 'i') *t = (char) (*t - 32);
            }
            xml_ostep_puts(&o, tmp, strlen(tmp));
            break;
        }
        default:
            /* unknown conversion: print it verbatim */
            xml_ostep_put(&o, '%');
            xml_ostep_put(&o, (char) conv);
            break;
        }
    }
    if (size > 0)
        buf[o.len < o.size ? o.len : o.size] = 0;
    return (int) o.len;
}

static int
xml_ostep_snprintf(char *buf, size_t size, const char *fmt, ...)
{
    va_list ap;
    int r;

    va_start(ap, fmt);
    r = xml_ostep_vsnprintf(buf, size, fmt, ap);
    va_end(ap);
    return r;
}

#define snprintf xml_ostep_snprintf
#define vsnprintf xml_ostep_vsnprintf

#endif /* PKGCONF_OPENSTEP_SNPRINTF_H */
