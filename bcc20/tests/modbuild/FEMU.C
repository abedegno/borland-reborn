/* modtest: -ms -O -f */
/* Floating point with emulation: arithmetic on float, double and long double, constant
   folding of conversions and comparisons, and calls. */
float f1 = 1.5f;
double d1 = 2.0 / 3.0;
long double ld1 = 1.0L / 7.0L;
int folded_int = (int)3.75;
long folded_long = (long)-123456.75;
unsigned long folded_ulong = (unsigned long)4000000000.0;
int folded_cmp = 1.5L > 1.25L;
int folded_eq = 2.0L == 2.0;
double folded_from_long = (double)123456789L;
long double folded_ld = (long double)3 * 2.5L;

double calc(double a, float b, long double c, int i, long l)
{
    double r = a * b + c / i - l;
    r += (float)i;
    r -= (long double)l;
    if (a < b || c >= a) r = -r;
    i = (int)r;
    l = (long)c;
    return r + i + l + (unsigned)a;
}
long double ldcalc(long double x) { return x * x - 1.0L; }
float fneg(float x) { return -x; }
int fcmp(double a, double b) { return a == b ? 0 : a < b ? -1 : 1; }
/* operations in place whose result is used again, and floats in registers' place */
double inplace(double a, double b, float f)
{
    double t = (a += b) * 2;
    double u = (a *= f) - (b -= 1.0);
    float g = f++;
    float h = --f;
    return t + u + g + h + (a /= 3);
}
