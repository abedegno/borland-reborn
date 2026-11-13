/* tolower.c: TOLOWER, from bcc20/src/rtl/TOLOWER.C: tolower through Turbo C's ctype table.
   The argument is taken as an unsigned char, so EOF (-1) becomes 255. */
#include "port.h"
#include "data.h"
#include "rtl.h"

u16 TOLOWER(i16 value)
{
    u8 c = (u8)value;
    if (CTYPE(c) & 4)
        return c + 32;
    return c;
}
