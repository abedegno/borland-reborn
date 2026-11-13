/* ratol.c: RTL_ATOL, from bcc20/src/rtl/RATOL.C: atol.  RTL_ATOI (atoi) is left out:
   nothing in BCC calls it.

   Skips spaces and tabs (only those), takes one minus sign and decimal digits.  The value
   wraps at 32 bits as the 8086's long arithmetic does. */
#include "port.h"
#include "protos.h"

i32 RTL_ATOL(farptr string)
{
    int negative = 0;
    u32 value = 0;
    while (SB(string) == ' ' || SB(string) == '\t')
        string = fp_add(string, 1);
    if (SB(string) == '-') {
        negative = 1;
        string = fp_add(string, 1);
    }
    while (SB(string) >= '0' && SB(string) <= '9') {
        value = value * 10 + (u32)(i32)SB(string) - '0';
        string = fp_add(string, 1);
    }
    if (negative)
        value = 0 - value;
    return (i32)value;
}

