// modtest: -ml -O
// Inline functions with if, blocks and early returns expanded where they are called; an
// inline destructor with bases and members; arrays of classes copied by a compiler-made
// operator=; a file-scope variable with a non-constant initialiser.
struct M { M(); M(const M &); M &operator=(const M &); ~M(); };
struct B { virtual ~B(); };
struct D : B { M m; inline ~D() { } };
struct Holder { M items[4]; int n; };
inline int pick(int a, int b)
{
    if (a > b) return a;
    else if (a == b) { int t = a * 2; return t; }
    if (b > 10) return 10;
    return b;
}
inline int clamp(int v) { if (v < 0) { return 0; } { v = v + 1; } return v; }
int g(int);
int initial = g(3);
static int other = pick(initial, 2);
int use(int x, int y)
{
    Holder a, b;
    a = b;
    D *d = new D;
    delete d;
    return pick(x, y) + clamp(x - y);
}
