/* ld2ulong.c: from bcc20/src/float/LD2ULONG.ASM (Borland run-time library, hand-written
   assembly): the long double at source truncated through RTL_LDOUBLE_TO_INT64; when the
   high 32 bits of the result are not 0 the value is FFFFFFFFh (so negative values give it
   too). */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

u32 RTL_LDOUBLE_TO_ULONG(farptr source)
{
    u16 mark = scratch_mark();
    farptr wide = scratch_alloc(8);
    RTL_LDOUBLE_TO_INT64(source, wide);
    u64 value = ld_read64(wide);
    scratch_release(mark);
    return value >> 32 ? 0xFFFFFFFFu : (u32)value;
}
