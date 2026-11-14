// modtest: -ml
// Pointers to members: compared with == and != (and against 0), called through an
// object, and a conversion function named as a member.
struct A {
    int x, y;
    int f(int);
    virtual int g(int);
    operator int() { return x; }
};
int (A::*pf)(int) = &A::f;
int (A::*pg)(int) = &A::g;
int A::*pm = &A::y;
int test(A &a, A *p)
{
    int r = 0;
    if (pf == pg) r++;
    if (pf != 0) r++;
    if (pm == &A::x) r++;
    if (pm != 0) r++;
    if (!pf) r++;
    r += (a.*pf)(1) + (p->*pg)(2);
    r += a.operator int();
    return r;
}
