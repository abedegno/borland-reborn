/* lmulovf.c: from bcc20/src/float/LMULOVF.ASM (hand-written assembly in the original): the
   signed 32-bit multiply of constant folding (FOLD_CONSTANT_NODE).  The result is
   a.lo * b.lo (unsigned) + ((a.hi * b.lo + b.hi * a.lo) << 16), the product mod 2^32, a
   cross product skipped when its high-word factor is 0.  The original reports overflow in
   OF, which the port gives in lmul_overflow (overflow.h): set when either signed 16-bit
   cross product overflows or their sum does, with a partial value in DX:AX then (the
   caller replaces it with 1); otherwise what the final add of the high words leaves.  The
   check is approximate, as in the original: it misses some overflows (a = b = 10000h gives
   0 with no overflow) and flags some products that fit. */
#include "port.h"
#include "protos.h"
#include "overflow.h"

int lmul_overflow;

/* imul: the signed 16 x 16 product, and OF when it does not fit 16 bits */
static i32 imul16(u16 x, u16 y, int *of)
{
    i32 p = (i32)(i16)x * (i16)y;
    *of = p != (i16)p;
    return p;
}

/* a 16-bit add and its OF */
static u16 add16(u16 x, u16 y, int *of)
{
    u16 r = (u16)(x + y);
    *of = (i16)((x ^ r) & (y ^ r)) < 0;
    return r;
}

i32 LMUL_WITH_OVERFLOW(i32 a, i32 b)
{
    u16 a_lo = (u16)a, a_hi = (u16)((u32)a >> 16), b_lo = (u16)b, b_hi = (u16)((u32)b >> 16);
    u16 ax = a_hi, dx = 0, cx;
    int of = 0;
    if (ax) {
        i32 p = imul16(ax, b_lo, &of);
        ax = (u16)p;
        dx = (u16)((u32)p >> 16);
        if (of)
            goto done;
    }
    cx = ax;                    /* a.hi * b.lo */
    ax = b_hi;
    if (ax) {
        i32 p = imul16(ax, a_lo, &of);
        ax = (u16)p;
        dx = (u16)((u32)p >> 16);
        if (of)
            goto done;
        cx = add16(cx, ax, &of);
        if (of)
            goto done;
    }
    u32 low = (u32)a_lo * b_lo;
    ax = (u16)low;
    dx = add16((u16)(low >> 16), cx, &of);
done:
    lmul_overflow = of;
    return (i32)((u32)dx << 16 | ax);
}
