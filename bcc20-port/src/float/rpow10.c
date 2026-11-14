/* rpow10.c: from bcc20/src/float/RPOW10.ASM (Borland run-time library, hand-written
   assembly): scales the long double at value by 10^power.  |power| is limited to 4999.
   10^(|power| mod 8) comes from POW10_SMALL, a table of unsigned longs (converted by
   RTL_ULONG_TO_LDOUBLE), and is multiplied by the long double powers 10^8, 10^16, ...
   (POW10_LARGE) picked by the remaining bits; value is then multiplied (power > 0) or
   divided (power < 0) by the result. */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "ldouble.h"

#define POW10_SMALL_P DSPTR(0x5AFC)
#define POW10_LARGE_P DSPTR(0x5B1C)

void RTL_LDOUBLE_SCALE_POW10(i16 power, farptr value)
{
    if (power == 0)
        return;
    u16 magnitude = power < 0 ? (u16)(0 - (u16)power) : (u16)power;
    if (magnitude > 4999)
        magnitude = 4999;
    u16 mark = scratch_mark();
    farptr scale = scratch_alloc(10);
    RTL_ULONG_TO_LDOUBLE(D(fp_add(POW10_SMALL_P, (magnitude & 7) * 4)), scale);
    magnitude >>= 3;
    for (farptr large = POW10_LARGE_P; magnitude; large = fp_add(large, 10)) {
        u16 bit = magnitude & 1;
        magnitude >>= 1;
        if (bit)
            RTL_LDOUBLE_MUL(scale, large);
    }
    if (power < 0)
        RTL_LDOUBLE_DIV(value, scale);
    else
        RTL_LDOUBLE_MUL(value, scale);
    scratch_release(mark);
}
