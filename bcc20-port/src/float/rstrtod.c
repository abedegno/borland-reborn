/* rstrtod.c: from bcc20/src/float/RSTRTOD.ASM (Borland run-time library, hand-written
   assembly): the decimal scanner behind strtod/atof, used by the lexer for floating
   constants.  Reads digits into a 64-bit mantissa (multiplying by 10; once the mantissa is
   too large, digits only raise the decimal exponent), an optional '.', and an optional e/E
   exponent with sign (its digits stop counting at 1000).  The mantissa goes to
   RTL_INT64_TO_LDOUBLE and RTL_LDOUBLE_SCALE_POW10 scales the result, in two steps when the
   exponent is below -4096.  The original also returns the number of characters consumed
   in AX; its C declaration (lexer) is void. */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

void RTL_SCAN_LDOUBLE(farptr text, farptr result)
{
    farptr s = text;
    u64 mantissa = 0;
    i16 exponent = 0, step = 0;       /* step: 0 before a '.', -1 after it, per digit */
    u8 c;
    for (;;) {
        c = B(s);
        s = fp_add(s, 1);
        if (c >= '0' && c <= '9') {
            if ((mantissa >> 48) >= 0xCCC) {
                exponent = (i16)(exponent + step + 1);
                continue;
            }
            mantissa = mantissa * 10 + (u64)(c - '0');
            exponent = (i16)(exponent + step);
            continue;
        }
        if (c == '.' && step == 0) {
            step = -1;
            continue;
        }
        break;
    }
    i16 power = exponent;
    if (c == 'E' || c == 'e') {
        u16 value = 0;
        c = B(s);
        s = fp_add(s, 1);
        u8 sign = c;
        if (c == '-' || c == '+') {
            c = B(s);
            s = fp_add(s, 1);
        }
        while (c >= '0' && c <= '9' && value < 1000) {
            value = (u16)(value * 10 + (c - '0'));
            c = B(s);
            s = fp_add(s, 1);
        }
        if (sign == '-')
            value = (u16)(0 - value);
        power = (i16)(power + (i16)value);
    }
    u16 mark = scratch_mark();
    farptr wide = scratch_alloc(8);
    ld_write64(wide, mantissa);
    RTL_INT64_TO_LDOUBLE(wide, result);
    scratch_release(mark);
    if (power < -4096) {
        power = (i16)(power + 4096);
        RTL_LDOUBLE_SCALE_POW10(-4096, result);
    }
    RTL_LDOUBLE_SCALE_POW10(power, result);
}
