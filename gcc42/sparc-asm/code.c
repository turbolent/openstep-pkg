/* code: switch tables, calls, varargs, long long, float, alloca, function ptrs */
typedef __builtin_va_list va_list;
extern int ext(int), ext2(double);
extern void *alloca(unsigned);
int sw(int x) {
  switch (x) { case 0: return 11; case 1: return 22; case 2: return 33; case 3: return 44;
    case 4: return 55; case 5: return 66; case 6: return 77; case 7: return 88; default: return 0; }
}
long long ll(long long a, long long b, int s) { return (a << s) + (a * b) - (a / b) + (a % b) + (a >> s); }
unsigned long long ull(unsigned long long a, unsigned long long b) { return a / b + a % b; }
double fp(double a, float b, int i) { return a * b + i - (a / b) + (double) (long long) a; }
float fp2(float a, float b) { return a * b + a / b; }
int cmp(double a, double b) { return a < b ? 1 : a == b ? 2 : 3; }
int vsum(int n, ...) { va_list ap; int s = 0; __builtin_va_start (ap, n);
  while (n--) s += __builtin_va_arg (ap, int); __builtin_va_end (ap); return s; }
int (*fptr)(int) = ext;
int callptr(int (*f)(int), int x) { return f(x) + (*fptr)(x); }
int al(int n) { char *p = alloca (n); p[0] = 1; return ext(p[0]); }
int mixed(int a, double b, int c, double d, int e, int f, int g, int h) { return a + c + e + f + g + h + ext2 (b + d); }
struct big { int a[20]; };
struct big retbig(int x) { struct big b; b.a[0] = x; return b; }
int usebig(void) { return retbig(3).a[0]; }
void __attribute__ ((constructor)) ctor(void) { ext(1); }
void __attribute__ ((destructor)) dtor(void) { ext(2); }
int __attribute__ ((weak)) weakfn(void) { return 1; }
int weakref_user(void) { return weakfn(); }
static inline int sq(int x) { return x * x; }
int usesq(int x) { return sq(x) + sq(x + 1); }
int volatile_rw(volatile int *p) { *p = 1; return *p; }
