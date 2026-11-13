// modtest: -ml -w
// More C++ diagnostics: redeclarations with other types, pure virtual classes made, bad
// initialisers, references and constructors.
class Abstract { public: virtual int f() = 0; virtual void g(long, char *) = 0; };
class Concrete : public Abstract { public: int f(); };
struct S { S(int, int); int x; };
int over(int);
long over(int);
void use()
{
    Abstract a;
    Concrete c;
    S s1;
    S s2 = 1;
    S s3(1, 2, 3);
    int &r = 5;
    const int k;
    int &&bad;
    Concrete *pc = new Abstract;
    s1.y = 2;
    over(1);
}
