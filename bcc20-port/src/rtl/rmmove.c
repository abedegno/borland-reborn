/* rmmove.c: RTL_MEMMOVE, from bcc20/src/rtl/RMMOVE.C: memmove on far pointers.

   The original copies backward (from the last byte) when the source is below the
   destination, comparing segment first and then offset, and forward otherwise; it moves
   words, with a single byte first to align the destination and one at the end for an odd
   count.  Within one segment that is memmove: overlapping blocks are copied correctly.  A
   byte loop in the same direction gives the same result there. */
#include "port.h"
#include "protos.h"

void RTL_MEMMOVE(farptr destination, farptr source, u16 count)
{
    int backward = FP_SEG(source) < FP_SEG(destination) ||
                   (FP_SEG(source) == FP_SEG(destination) &&
                    FP_OFF(source) < FP_OFF(destination));
    if (backward)
        for (u16 i = count; i-- > 0;)
            B(fp_add(destination, i)) = B(fp_add(source, i));
    else
        for (u16 i = 0; i < count; i++)
            B(fp_add(destination, i)) = B(fp_add(source, i));
}
