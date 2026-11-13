/* rtoupper.c: RTL_TOUPPER, from bcc20/src/rtl/RTOUPPER.C: toupper through the ctype table. */
#include "port.h"
#include "data.h"
#include "protos.h"

u16 RTL_TOUPPER(i16 value)
{
    u8 c = (u8)value;
    if (CTYPE(c) & 8)
        return (u16)(c - 32);
    return c;
}
