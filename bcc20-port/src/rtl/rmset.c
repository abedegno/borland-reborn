/* rmset.c: RTL_MEMSET, from bcc20/src/rtl/RMSET.C: memset on a far pointer, returning it. */
#include "port.h"
#include "protos.h"

farptr RTL_MEMSET(farptr destination, i16 c, u16 count)
{
    for (u16 i = 0; i < count; i++)
        B(fp_add(destination, i)) = (u8)c;
    return destination;
}
