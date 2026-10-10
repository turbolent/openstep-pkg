/* data directives: common, local, initialised data of every size, strings */
int common_int;
double common_dbl[3];
static int local_zero[10];
static char local_byte;
char buf[100] = { 1, 2, 3 };
short shorts[4] = { 1, -2, 3, -4 };
int ints[4] = { 1, -2, 3, -4 };
long long quads[2] = { 0x1122334455667788LL, -1 };
float flts[2] = { 1.5f, -2.25f };
double dbls[2] = { 3.14159, -1e100 };
long double ld = 2.5L;
char *strs[3] = { "alpha", "beta\n", "gamma\t\"quoted\"" };
const char msg[] = "hello, world";
int *ptrs[3] = { &common_int, ints, &ints[2] };
struct pk { char c; int i; short s; } __attribute__ ((packed));
struct pk packed_val = { 1, 0x01020304, 5 };
struct pk packed_arr[2] = { { 1, 2, 3 }, { 4, 5, 6 } };
struct bf { unsigned a : 3, b : 5, c : 24; } bits = { 1, 2, 3 };
int uninit_big[1000];
extern int ext_sym;
int *ext_ptr = &ext_sym;
int use(void) { return local_zero[1] + local_byte + common_int; }
