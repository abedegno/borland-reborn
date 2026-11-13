/* rstricmp.c: STRING_COMPARE, from bcc20/src/rtl/RSTRICMP.C: stricmp on far strings.

   Characters are plain char, which is signed in Borland C: each is sign-extended before
   TOLOWER (which takes it as unsigned char), the lower-cased results are compared as signed
   chars, and when a ends, the sign of b's character decides. */
#include "port.h"
#include "rtl.h"

i16 STRING_COMPARE(farptr a, farptr b)
{
    while (SB(a)) {
        i8 lower_a = (i8)TOLOWER(SB(a));
        i8 lower_b = (i8)TOLOWER(SB(b));
        if (lower_a < lower_b)
            return -1;
        if (lower_a > lower_b)
            return 1;
        a = fp_add(a, 1);
        b = fp_add(b, 1);
    }
    if (SB(b) > 0)
        return -1;
    if (SB(b) < 0)
        return 1;
    return 0;
}
