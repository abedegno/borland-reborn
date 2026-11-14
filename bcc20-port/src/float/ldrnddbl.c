/* ldrnddbl.c: from bcc20/src/float/LDRNDDBL.ASM (Borland run-time library, hand-written
   assembly): rounds the long double at value to double precision (53 mantissa bits), to
   nearest even, in place: the low 11 bits are cleared after adding half a unit when the
   bits below the unit are above half, or exactly half with the unit's bit set.  A carry out
   of the mantissa adds 1 to the exponent word and leaves the mantissa's top bits 0 (the
   double conversion drops the leading bit anyway); when that makes the exponent 7FFFh the
   value becomes infinity (mantissa 8000000000000000h). */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

void RTL_LDOUBLE_ROUND_TO_DOUBLE(farptr value)
{
    u16 ax = W(fp_add(value, 1));
    u8 sticky = (u8)((ax & 3) | B(value));
    if (sticky != 0 || (ax & 8)) {
        u32 sum = (u32)ax + 4;
        ax = (u16)sum;
        if (sum >> 16) {
            /* carry into bytes 3..7 */
            u64 high = (u64)W(fp_add(value, 3)) | (u64)W(fp_add(value, 5)) << 16 | (u64)B(fp_add(value, 7)) << 32;
            high++;
            W(fp_add(value, 3)) = (u16)high;
            W(fp_add(value, 5)) = (u16)(high >> 16);
            B(fp_add(value, 7)) = (u8)(high >> 32);
            if (high >> 40) {
                W(fp_add(value, 8))++;
                if ((W(fp_add(value, 8)) & 0x7FFF) == 0x7FFF) {
                    W(value) = 0;
                    W(fp_add(value, 2)) = 0;
                    W(fp_add(value, 4)) = 0;
                    W(fp_add(value, 6)) = 0x8000;
                    return;
                }
            }
        }
    }
    B(value) = 0;
    W(fp_add(value, 1)) = ax & 0xFFF8;
}
