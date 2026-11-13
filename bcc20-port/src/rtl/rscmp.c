/* rscmp.c: COMPARE_NAME, from bcc20/src/rtl/RSCMP.C.

   The C library's strcmp on far strings, as BCC's run-time library has it (Turbo C 2.01,
   C with inline assembly, pascal calling).  It is used all over the compiler to compare
   identifier names and option strings.

   It returns the difference of the first bytes that differ (or 0), computed in 8 bits and
   sign-extended: the original subtracts in AL and widens with CBW, so the sign is wrong
   when the two bytes differ by more than 127 (docs/FINDINGS.md).  Kept: callers only test
   for zero, and replay compares the exact value. */
#include "port.h"
#include "protos.h"

i16 COMPARE_NAME(farptr a, farptr b)
{
    u8 x, y;
    do {
        x = B(a);
        y = B(b);
        a = fp_add(a, 1);
        b = fp_add(b, 1);
    } while (x == y && x != 0);
    return (i8)(u8)(x - y);
}
