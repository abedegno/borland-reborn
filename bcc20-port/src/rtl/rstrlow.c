/* rstrlow.c: RTL_STRUPR, from bcc20/src/rtl/RSTRLOW.C: strupr on a far string (a null
   pointer, segment and offset both zero, is left alone). */
#include "port.h"
#include "rtl.h"

void RTL_STRUPR(farptr text)
{
    if (!text)
        return;
    while (SB(text)) {
        B(text) = (u8)RTL_TOUPPER(SB(text));
        text = fp_add(text, 1);
    }
}
