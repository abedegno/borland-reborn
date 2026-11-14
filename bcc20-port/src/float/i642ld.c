/* i642ld.c: from bcc20/src/float/I642LD.ASM (Borland run-time library, hand-written
   assembly): a 64-bit signed integer at source to a long double at target.  The magnitude
   is normalised (whole words first, then single bits) so the leading bit is set, starting
   from exponent 40h + 3FFEh; 0 gives an all-zero value.  The most negative value converts
   correctly: its negation is itself, read as unsigned. */
#include "port.h"
#include "ldouble.h"

void RTL_INT64_TO_LDOUBLE(farptr source, farptr target)
{
    u64 mantissa = ld_read64(source);
    u16 sign = 0, exponent = 0;
    if (mantissa != 0) {
        if ((i64)mantissa < 0) {
            mantissa = 0 - mantissa;
            sign = 1;
        }
        exponent = 0x40;
        while (!(mantissa >> 48)) {
            mantissa <<= 16;
            exponent -= 16;
        }
        while (!(mantissa >> 63)) {
            mantissa <<= 1;
            exponent--;
        }
        exponent = (u16)(sign << 15 | ((exponent + 0x3FFE) & 0x7FFF));
    }
    ld_store(target, mantissa, exponent);
}
