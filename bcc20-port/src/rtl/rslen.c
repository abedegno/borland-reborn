/* rslen.c: STRING_LENGTH, from bcc20/src/rtl/RSLEN.C: strlen on a far string.

   The original scans with REPNE SCASB from a count of FFFFh, so the offset wraps inside the
   string's segment and the result is the number of bytes before the terminator. */
#include "port.h"
#include "rtl.h"

u16 STRING_LENGTH(farptr string)
{
    u16 n = 0;
    while (B(fp_add(string, n)) != 0)
        n++;
    return n;
}
