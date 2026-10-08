/* Diagnostic, not built by the package.  On the target machine:
     cc -o oidtest oidtest.c -I/usr/local/include -L/usr/local/lib -lcrypto
     ./oidtest
   Linux x86 reports one failure (nid 676, "1.3", which shares its OID with
   another entry); anything more means OBJ_obj2nid() is broken in libcrypto.

   oidtest: for every built-in OID, look it up by its DER bytes (as a parsed
   certificate does) and report the ones OpenSSL cannot map back to its NID. */
#include <stdio.h>
#include <string.h>
#include <openssl/objects.h>
#include <openssl/asn1.h>
#include <openssl/err.h>

int main()
{
    int nid, bad = 0, total = 0, len;
    ASN1_OBJECT *o, *probe;
    const unsigned char *p;
    unsigned char der[64];
    char txt[128];

    for (nid = 1; nid < 1300; nid++) {
        o = OBJ_nid2obj(nid); ERR_clear_error();
        if (o == NULL || OBJ_length(o) == 0 || OBJ_length(o) > 60)
            continue;
        der[0] = 6;
        der[1] = (unsigned char) OBJ_length(o);
        memcpy(der + 2, OBJ_get0_data(o), OBJ_length(o));
        len = OBJ_length(o) + 2;
        p = der;
        probe = d2i_ASN1_OBJECT(NULL, &p, len);   /* nid is 0: forces the search */
        total++;
        if (probe == NULL) {
            printf("nid %d: d2i failed\n", nid);
            bad++;
            continue;
        }
        if (OBJ_obj2nid(probe) != nid) {
            OBJ_obj2txt(txt, sizeof txt, o, 1);
            printf("nid %d (%s %s): lookup gave %d\n", nid, txt, OBJ_nid2sn(nid), OBJ_obj2nid(probe));
            bad++;
        }
        ASN1_OBJECT_free(probe);
    }
    printf("%d of %d built-in OIDs failed the lookup\n", bad, total);
    return bad != 0;
}
