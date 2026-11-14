/* ldisnan.c: from bcc20/src/float/LDISNAN.C: a NaN test for the long double arithmetic in
   ldarith.c, close to C99 isnan; its only caller is the multiply routine, which needs to
   tell a NaN operand from an infinity.  record points at an operand in the unpacked work
   format: the four mantissa words, then the exponent with the sign bit removed.  An
   exponent of 7FFFh with any mantissa other than 8000 0000 0000 0000h (the explicit integer
   bit alone, which is infinity) is a NaN, forms with the integer bit clear included.
   1 for a NaN, else 0. */
#include "port.h"
#include "protos.h"

i16 BCC_EXTENDED_HAS_PAYLOAD(farptr record)
{
    return W(fp_add(record, 8)) == 0x7FFF &&
           (W(fp_add(record, 6)) != 0x8000 || W(record) || W(fp_add(record, 2)) || W(fp_add(record, 4)));
}
