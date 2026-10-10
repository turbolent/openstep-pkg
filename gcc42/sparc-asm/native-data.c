/* Compile with the NATIVE compiler:  /bin/cc -S -O2 native-data.c
   and look at how it spells 1/2/4/8-byte data, .comm/.lcomm, strings and
   .align.  gcc42's SPARC output must use the same spellings and widths. */
char c = 1;
short s = 2;
int i = 3;
long long q = 0x1122334455667788LL;
float f = 1.5f;
double d = 2.5;
char *p = "str";
int *ptr = &i;
char b[8] = { 1, 2 };
int zeros[10];
static int local_zeros[10];
int common_int;
int use(void) { return local_zeros[1] + common_int; }
int sw(int x)
{
  switch (x) {
  case 0: return 11; case 1: return 22; case 2: return 33; case 3: return 44;
  case 4: return 55; case 5: return 66; case 6: return 77; case 7: return 88;
  default: return 0;
  }
}
