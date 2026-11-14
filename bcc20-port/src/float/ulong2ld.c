/* ulong2ld.c: from bcc20/src/float/ULONG2LD.ASM (Borland run-time library, hand-written
   assembly): an unsigned long to a long double at target, zero-extended to 64 bits and
   converted by RTL_INT64_TO_LDOUBLE. */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

void RTL_ULONG_TO_LDOUBLE(u32 value, farptr target)
{
    u16 mark = scratch_mark();
    farptr wide = scratch_alloc(8);
    ld_write64(wide, value);
    RTL_INT64_TO_LDOUBLE(wide, target);
    scratch_release(mark);
}
