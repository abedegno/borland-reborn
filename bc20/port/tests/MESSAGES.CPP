// modtest: -ml
// modes: -c
// Messages that spell a linkage or a required kind of type.
extern "C" int f(int);
int f(int);
extern "Pascal" { int g(void); }
struct S { int a; } s, t;
int use(int *p, double d)
{
    s++;
    ~d;
    p % 2;
    s << 1;
    !s;
    return d & 1;
}
