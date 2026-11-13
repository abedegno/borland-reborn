// modtest: -ml -O
// modes: -S
// Borland C++ 2.0 rejects an enumeration constant in a C++ asm statement ("Improper use of
// a typedef symbol"), although C takes it and ASMENC2.C has code to write its value.  Both
// compilers must fail alike.
enum Mode { first = 3, second = 7 };
int run(int n)
{
    asm mov cx, second
    asm add cx, first
    return n;
}
