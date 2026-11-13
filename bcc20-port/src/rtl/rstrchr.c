/* rstrchr.c: STRING_FIND_CHAR, from bcc20/src/rtl/RSTRCHR.C: strrchr on far strings.
   RTL_STRCHR (strchr) is left out: nothing in BCC calls it.

   STRING_FIND_CHAR scans back from the last character; for an empty string it
   reads the byte before the string, as the original does (docs/FINDINGS.md).  Far pointers
   are compared by offset, as Borland C compares them with < and >. */
#include "port.h"
#include "rtl.h"

farptr STRING_FIND_CHAR(farptr string, i8 c)
{
    farptr p = fp_add(string, STRING_LENGTH(string) - 1);
    while (FP_OFF(p) > FP_OFF(string)) {
        if (SB(p) == c)
            return p;
        p = fp_add(p, -1);
    }
    return SB(p) == c ? p : 0;
}
