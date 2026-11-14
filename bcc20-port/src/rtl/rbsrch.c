/* rbsrch.c: from bcc20/src/rtl/RBSRCH.C: bsearch with pascal calling (Turbo C 2.01 run-time
   library).  key is what to look for, base the sorted table of count elements of width
   bytes each, compare a far pascal function giving <0, 0 or >0 for key against an element.
   Its caller is SCAN_ASM_TOKEN (parser/asmstmt.c), which looks up inline assembler
   mnemonics in ASM_KEYWORD_TABLE.  Returns the matching element or 0. */
#include "port.h"
#include "protos.h"
#include "calls.h"

farptr BCC_BINARY_SEARCH(farptr key, farptr base, i16 count, u16 width, farptr compare)
{
    i16 remaining = count;
    farptr low = base;
    while (remaining > 0) {
        i16 half = remaining >> 1;
        farptr probe = fp_add(low, (u16)(half * width));
        i16 result = (i16)CALL_FAR(compare, A32(key), A32(probe));
        if (result == 0)
            return probe;
        /* key below the probe: keep the elements before it, else those after it */
        if (result < 0)
            remaining = half;
        else {
            low = fp_add(probe, width);
            remaining = remaining - half - 1;
        }
    }
    return 0;
}
