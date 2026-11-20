// modtest: -ml -w
// Diagnostics in C++: calls with no matching or ambiguous overload, access to private
// members, conversions between classes, wrong member functions, const objects; the
// messages spell out types, members and call signatures.
class A { int secret; public: A(int); void m(int); void m(char *); int c() const; };
class B { public: B(const A &); operator int(); };
class C : private A { public: C(); };
int f(int, long);
int f(char *, A &);
int f(double, double);
void test(A &a, const A &ca, B &b, C &c, int *ip)
{
    f(ip, 1);
    f(1L, 2L);
    f("x", b);
    a.secret = 1;
    a.m(2.5);
    a.m(ip);
    a.missing();
    ca.m(1);
    A *pa = &c;
    B b2 = 5;
    int i = a;
    char *s = b;
    A a2;
    a.A::c(1);
    int (A::*pm)(int) const = &A::c;
}
