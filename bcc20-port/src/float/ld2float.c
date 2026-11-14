/* ld2float.c: from bcc20/src/float/LD2FLOAT.ASM (Borland run-time library, hand-written
   assembly): the long double at source to a float at target.  A copy is rounded to float
   precision (RTL_LDOUBLE_ROUND_TO_FLOAT), its exponent rebiased by -3F80h; too small gives
   a signed 0, too large a signed infinity, and an exponent of 7FFFh keeps the top 7
   mantissa bits (infinity or NaN). */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

static void to_float(farptr copy, farptr target)
{
    RTL_LDOUBLE_ROUND_TO_FLOAT(copy);
    u16 sign = W(fp_add(copy, 8)) >> 15;
    u16 bx = W(fp_add(copy, 8)) & 0x7FFF, ax = 0;
    if (bx == 0x7FFF)
        bx = (u16)(0xFF00 | (u8)(B(fp_add(copy, 7)) << 1));
    else if ((i16)(bx = (u16)(bx + 0xC080)) <= 0)
        bx = 0;
    else if ((i16)bx >= 0xFF)
        bx = 0xFF00;
    else {
        ax = W(fp_add(copy, 5));
        bx = (u16)((bx & 0xFF) << 8 | (u8)(B(fp_add(copy, 7)) << 1));
    }
    W(target) = ax;
    W(fp_add(target, 2)) = (u16)(sign << 15 | bx >> 1);
}

void RTL_LDOUBLE_TO_FLOAT(farptr source, farptr target)
{
    u16 mark = scratch_mark();
    farptr copy = scratch_alloc(10);
    memmove(at(copy), at(source), 10);
    to_float(copy, target);
    scratch_release(mark);
}
