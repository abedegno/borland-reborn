/* ldcmp.c: from bcc20/src/float/LDCMP.ASM (Borland run-time library, hand-written
   assembly): compares the long doubles at a and b; -1, 0 or 1.  Two values whose exponents
   are both 0 are equal whatever their mantissas and signs; otherwise the signs decide, then
   the exponents and the mantissas from the top word down, the order reversed for negative
   values. */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

i16 RTL_LDOUBLE_COMPARE(farptr a, farptr b)
{
    u16 exponent_a = (u16)(ld_exponent_word(a) << 1), exponent_b = (u16)(ld_exponent_word(b) << 1);
    int negative_a = ld_exponent_word(a) >> 15, negative_b = ld_exponent_word(b) >> 15;
    if ((exponent_a | exponent_b) == 0)
        return 0;
    if (negative_a != negative_b)
        return negative_a ? -1 : 1;
    int greater;
    if (exponent_a != exponent_b)
        greater = exponent_a > exponent_b;
    else {
        u64 mantissa_a = ld_mantissa(a), mantissa_b = ld_mantissa(b);
        if (mantissa_a == mantissa_b)
            return 0;
        greater = mantissa_a > mantissa_b;
    }
    return greater != negative_a ? 1 : -1;
}
