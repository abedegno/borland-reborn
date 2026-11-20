// modtest: -ml -O -G
// SIMPLIFY.C compiled as C++ (the C++ front end's expression analysis), and a function
// first declared with C++ linkage, then with C linkage.
int *g(void);
int idx(void);
int a[10];
struct bits { unsigned b : 3; int c; } *h(void);
long l[4];
int r[16];
void f(int x, long y, double d, unsigned u)
{
    r[0] = x * -1;
    r[1] = x / -1;
    d = d * -1.0;
    d = d / -1.0;
    r[2] = (x * 0 + 7) / -2;
    r[3] = (x * 0 - 9) % 4;
    r[4] = (u * 0 + 7u) % 3u;
    r[5] = (x * 0 + 5) - 9;
    r[6] = (u * 0 + 5u) - 9u;
    l[0] = (y * 0 + 0x1234L) ^ 0x0F0FL;
    r[7] = (x * 0 + 12) / 4 + (x * 0 - 12) / 4;
    *g() += 1;
    a[idx()] *= 3;
    h()->b += 2;
    h()->c -= 4;
    (*g())++;
    a[idx()]--;
    h()->b++;
    l[idx()] /= 3;
    r[8] = (x + 7) - (x + 2);
    r[9] = (u + 7u) - (u - 2u);
    r[10] = 9 - (x + 2);
    r[11] = (x - 3) - (x + 4);
}
int linked(int);
extern "C" int linked(int);
