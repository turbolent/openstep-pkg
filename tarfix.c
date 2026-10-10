/* tarfix - copy a tar stream, replacing the uid and gid of every entry with 0.
 *
 * OPENSTEP has a 16-bit uid_t, and gnutar 1.15.1 refuses an archive whose
 * header holds a larger uid or gid ("Archive value 197609 is out of uid_t
 * range").  Many upstream tarballs carry such numbers.  pkg runs this filter
 * between the decompressor and gnutar when a plain extraction fails.
 *
 *     gzip -dc foo.tar.gz | tarfix | gnutar -xf - --no-same-owner
 */
#include <stdio.h>
#include <string.h>

#define BLK 512

static unsigned long octal(const unsigned char *p, int n, int *big)
{
    unsigned long v = 0;
    int i;

    *big = 0;
    if (p[0] & 0x80) {          /* GNU base-256 number */
        *big = 1;
        v = p[0] & 0x7f;
        for (i = 1; i < n; i++)
            v = (v << 8) | p[i];
        return v;
    }
    for (i = 0; i < n && p[i] == ' '; i++)
        ;
    for (; i < n && p[i] >= '0' && p[i] <= '7'; i++)
        v = (v << 3) | (unsigned long) (p[i] - '0');
    return v;
}

static int is_zero(const unsigned char *b)
{
    int i;
    for (i = 0; i < BLK; i++)
        if (b[i])
            return 0;
    return 1;
}

static int copy(FILE *in, unsigned long n)
{
    unsigned char b[BLK];
    while (n > 0) {
        if (fread(b, 1, BLK, in) != BLK)
            return -1;
        if (fwrite(b, 1, BLK, stdout) != BLK)
            return -1;
        n--;
    }
    return 0;
}

int main(void)
{
    unsigned char b[BLK];
    unsigned long sum, size;
    int i, big;
    size_t got;

    for (;;) {
        got = fread(b, 1, BLK, stdin);
        if (got == 0)
            break;
        if (got != BLK) {       /* short trailing data: pass it through */
            fwrite(b, 1, got, stdout);
            break;
        }
        if (!is_zero(b)) {
            memcpy(b + 108, "0000000", 7); b[115] = 0;
            memcpy(b + 116, "0000000", 7); b[123] = 0;
            memset(b + 148, ' ', 8);
            for (sum = 0, i = 0; i < BLK; i++)
                sum += b[i];
            sprintf((char *) b + 148, "%06lo", sum);
            b[154] = 0;
            b[155] = ' ';
        }
        if (fwrite(b, 1, BLK, stdout) != BLK)
            return 1;
        if (is_zero(b))
            continue;
        /* Entries with data: regular files and the GNU/pax extension types.
           Links, symlinks, directories, devices and fifos carry none. */
        if (b[156] == '0' || b[156] == 0 || b[156] == '7' || b[156] == 'L' ||
            b[156] == 'K' || b[156] == 'x' || b[156] == 'g' || b[156] == 'X') {
            size = octal(b + 124, 12, &big);
            if (copy(stdin, (size + BLK - 1) / BLK) != 0)
                return 1;
        }
    }
    return 0;
}
