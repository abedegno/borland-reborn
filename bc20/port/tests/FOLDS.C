/* modtest: -ml -O -G */
/* Constant folding inside code: signed and unsigned division, remainder and subtraction,
   long exclusive or, negation and complement of constants, floating operators that have
   no floating fold. */
int r[12];
long l[4];
void f(int x, long y, double d)
{
    r[0] = -7 / 2 + x;
    r[1] = -7 % 3 + x;
    r[2] = 7u % 3u + x;
    r[3] = 5 - 9 + x;
    r[4] = 5u - 9u + x;
    r[5] = -(3 + 4) + x;
    r[6] = ~(1 << 3) + x;
    r[7] = (x * 0) + (x - x);
    l[0] = (0x12345678L ^ 0x0F0F0F0FL) + y;
    l[1] = -100000L / 7L + y;
    l[2] = -100000L % 7L + y;
    l[3] = (3L - 9L) * y;
    d = d + (1.5 * 2.0);
    r[8] = (int)(2.5 / 0.5) % 2;
}
