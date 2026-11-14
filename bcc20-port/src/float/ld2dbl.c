/* ld2dbl.c: from bcc20/src/float/LD2DBL.ASM (Borland run-time library, hand-written
   assembly): the long double at source to a double at target.  A copy is rounded to double
   precision (RTL_LDOUBLE_ROUND_TO_DOUBLE), its exponent rebiased by -3C00h; too small gives
   a signed 0, too large a signed infinity, and an exponent of 7FFFh (infinity or NaN) keeps
   the top mantissa bits.  The original packs the bits with register shifts through the
   carry; the same steps are done here on 16-bit values. */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

/* shr hi / rcr through a, b, c, d: the five words shifted right by one as one value */
static void shift_right(u16 *hi, u16 *a, u16 *b, u16 *c, u16 *d)
{
    u16 carry = *hi & 1;
    *hi >>= 1;
    u16 *chain[4] = {a, b, c, d};
    for (int i = 0; i < 4; i++) {
        u16 out = *chain[i] & 1;
        *chain[i] = (u16)(carry << 15 | *chain[i] >> 1);
        carry = out;
    }
}

static void to_double(farptr copy, farptr target)
{
    RTL_LDOUBLE_ROUND_TO_DOUBLE(copy);
    u16 ax = W(fp_add(copy, 1)), di = W(fp_add(copy, 3)), cx = W(fp_add(copy, 5));
    u8 dl = B(fp_add(copy, 7));
    u16 sign = W(fp_add(copy, 8)) >> 15;
    u16 bx = W(fp_add(copy, 8)) & 0x7FFF, dx;
    if (bx == 0x7FFF)
        dx = (u16)(0xFFE0 | (dl & 0x7F) >> 2);
    else if ((i16)(bx = (u16)(bx + 0xC400)) <= 0)
        dx = 0;
    else if ((i16)bx >= 0x7FF)
        dx = 0xFFE0;
    else {
        dl = (u8)(dl << 1);                         /* shl dl,1: drop the leading bit */
        u16 exponent_low = bx & 1;                  /* shr bx,1 / rcr dl,1 */
        bx >>= 1;
        dl = (u8)(exponent_low << 7 | dl >> 1);
        ax |= bx >> 8;                              /* or al,bh */
        dx = (u16)((bx & 0xFF) << 8 | dl);          /* mov dh,bl */
        bx = di;
        shift_right(&di, &ax, &dx, &cx, &bx);
        shift_right(&di, &ax, &dx, &cx, &bx);
        ax = (u16)((ax & 0xFF00) | ((ax + sign) & 0xFF));   /* shl [bp-2],1 / adc al,0 */
        shift_right(&di, &ax, &dx, &cx, &bx);
        W(target) = ax;
        W(fp_add(target, 2)) = bx;
        W(fp_add(target, 4)) = cx;
        W(fp_add(target, 6)) = dx;
        return;
    }
    W(target) = 0;
    W(fp_add(target, 2)) = 0;
    W(fp_add(target, 4)) = 0;
    W(fp_add(target, 6)) = (u16)(sign << 15 | dx >> 1);
}

void RTL_LDOUBLE_TO_DOUBLE(farptr source, farptr target)
{
    u16 mark = scratch_mark();
    farptr copy = scratch_alloc(10);
    memmove(at(copy), at(source), 10);
    to_double(copy, target);
    scratch_release(mark);
}
