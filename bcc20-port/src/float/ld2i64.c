/* ld2i64.c: from bcc20/src/float/LD2I64.ASM (Borland run-time library, hand-written
   assembly): the long double at source truncated toward zero to a 64-bit signed integer at
   target.  A magnitude below 1 gives 0; an exponent too large for 63 bits gives
   8000000000000000h (without the sign applied). */
#include "port.h"
#include "ldouble.h"

void RTL_LDOUBLE_TO_INT64(farptr source, farptr target)
{
    i16 exponent = (i16)((ld_exponent_word(source) & 0x7FFF) - 0x3FFE);
    u64 value;
    if (exponent > 0x3F)
        value = (u64)1 << 63;
    else if (exponent < 0)
        value = 0;
    else {
        value = exponent == 0 ? 0 : ld_mantissa(source) >> (64 - exponent);
        if (B(fp_add(source, 9)) & 0x80)
            value = 0 - value;
    }
    ld_write64(target, value);
}
