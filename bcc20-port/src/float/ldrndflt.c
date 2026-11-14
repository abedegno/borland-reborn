/* ldrndflt.c: from bcc20/src/float/LDRNDFLT.ASM (Borland run-time library, hand-written
   assembly): rounds the long double at value to float precision (24 mantissa bits), to
   nearest even, in place: the low 40 bits are cleared after adding the round bit (bit 39)
   when the bits below the unit are not exactly half or the unit's bit is set.  A carry out
   of the mantissa shifts it right (leading bit set again) and adds 1 to the exponent word;
   when that makes the exponent 7FFFh the value becomes infinity. */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

void RTL_LDOUBLE_ROUND_TO_FLOAT(farptr value)
{
    u16 ax = W(fp_add(value, 4)), dx = W(fp_add(value, 6));
    if (W(value) != 0 || W(fp_add(value, 2)) != 0 || (ax & 0x7F) || (ax & 0x100)) {
        u32 top = ((u32)dx << 8 | ax >> 8) + (ax >> 7 & 1);     /* add AL,AL / adc AH / adc DX */
        u16 al = (u16)((ax << 1) & 0xFF);
        ax = (u16)((top & 0xFF) << 8 | al);
        dx = (u16)(top >> 8);
        if (top >> 24) {
            /* rcr DX / rcr AX with the carry */
            u16 low = dx & 1;
            dx = (u16)(0x8000 | dx >> 1);
            ax = (u16)(low << 15 | ax >> 1);
            W(fp_add(value, 8))++;
            if ((W(fp_add(value, 8)) & 0x7FFF) == 0x7FFF) {
                ax = 0;
                dx = 0x8000;
            }
        }
    }
    W(value) = 0;
    W(fp_add(value, 2)) = 0;
    W(fp_add(value, 4)) = ax & 0xFF00;
    W(fp_add(value, 6)) = dx;
}
