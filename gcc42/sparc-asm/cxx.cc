struct A { virtual ~A() {} virtual int f() { return 1; } int x; };
struct B : A { int f() { return 2; } };
template <class T> T twice(T v) { return v + v; }
int g(A *a) { try { if (!a) throw 7; return a->f() + twice (3) + (int) twice (2.5); } catch (int i) { return i; } }
static B global_b;
inline int inl(int x) { return x ? inl (x - 1) + 1 : 0; }
int h() { return inl (3) + global_b.f(); }
