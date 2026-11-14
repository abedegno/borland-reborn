/* long2ld.c: from bcc20/src/float/LONG2LD.ASM (Borland run-time library, hand-written
   assembly): a long to a long double at target, sign-extended to 64 bits in a local and
   converted by RTL_INT64_TO_LDOUBLE. */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

void RTL_LONG_TO_LDOUBLE(i32 value, farptr target)
{
    u16 mark = scratch_mark();
    farptr wide = scratch_alloc(8);
    ld_write64(wide, (u64)(i64)value);
    RTL_INT64_TO_LDOUBLE(wide, target);
    scratch_release(mark);
}
