typedef struct { int a, b, c; double d; } V;
@interface Base { int bias; }
- (V) result:(int)v;
- (double) dbl;
+ (id) make;
@end
@implementation Base
- (V) result:(int)v { V r; r.a = bias; r.b = v; r.c = bias + v; r.d = 3.25; return r; }
- (double) dbl { return 3.25; }
+ (id) make { return self; }
@end
@interface Kid : Base
- (V) result:(int)v;
@end
@implementation Kid
- (V) result:(int)v { V r = [super result:v]; r.c += 100; return r; }
@end
V go(Base *b) { return [b result:11]; }
double go2(Base *b) { return [b dbl]; }
const char *str(void) { return "x"; }
