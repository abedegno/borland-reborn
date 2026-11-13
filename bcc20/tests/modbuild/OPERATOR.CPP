// modtest: -ml -O -G
// C++ operators, references, conversions, member pointers, overloading, inline and friend
// functions, default arguments and casts.  (Borland C++ 2.0 has no postfix operator++(int),
// and overload is still a keyword in it.)
class Complex {
public:
    Complex(double r = 0, double i = 0) : re(r), im(i) {}
    Complex operator+(const Complex &c) const { return Complex(re + c.re, im + c.im); }
    Complex operator-() const { return Complex(-re, -im); }
    Complex &operator+=(const Complex &c) { re += c.re; im += c.im; return *this; }
    int operator==(const Complex &c) const { return re == c.re && im == c.im; }
    double &operator[](int i) { return i ? im : re; }
    operator double() const { return re; }
    friend Complex operator*(const Complex &a, const Complex &b);
private:
    double re, im;
};
Complex operator*(const Complex &a, const Complex &b)
{
    return Complex(a.re * b.re - a.im * b.im, a.re * b.im + a.im * b.re);
}

class Counter {
public:
    Counter(int start = 0) : n(start) {}
    Counter &operator++() { ++n; return *this; }
    int operator()(int a, int b = 2) { return n * a + b; }
    int get() const { return n; }
    int twice() const { return 2 * n; }
    int n;
    void *operator new(unsigned size);
    void operator delete(void *p);
};
static char pool[64];
void *Counter::operator new(unsigned) { return pool; }
void Counter::operator delete(void *) {}

int pick(int a) { return a; }
int pick(long a) { return (int)a + 1; }
int pick(double a) { return (int)a + 2; }
int pick(const char *s, int n = 3) { return s[0] + n; }

int members(Counter &c)
{
    int Counter::*field = &Counter::n;
    int (Counter::*method)() const = &Counter::get;
    Counter *p = &c;
    int r = c.*field + (c.*method)() + p->*field + (p->*method)();
    method = &Counter::twice;
    return r + (p->*method)();
}

int test(int i)
{
    Complex a(1, 2), b = 3.0;
    Complex c = a + b * -a;
    c += 1.5;
    c[1] = 4;
    double d = c;
    Counter k(i);
    ++k; ++k;
    Counter *heap = new Counter(3);
    int r = k(2) + k(3, 4) + members(*heap);
    delete heap;
    int &ref = k.n;
    ref += 2;
    const int &cref = r;
    long l = (long)d;
    char *s = (char *)"text";
    void *v = s;
    s = (char *)v;
    return r + cref + (int)l + pick(1) + pick(2L) + pick(2.5) + pick("x")
        + (a == b) + int(d) + k.get();
}
