/* ld2long.c: from bcc20/src/float/LD2LONG.ASM (Borland run-time library, hand-written
   assembly): the long double at source truncated to a long through RTL_LDOUBLE_TO_INT64;
   a value outside the long range gives 80000000h. */
#include "port.h"
#include "protos.h"
#include "ldouble.h"

i32 RTL_LDOUBLE_TO_LONG(farptr source)
{
    u16 mark = scratch_mark();
    farptr wide = scratch_alloc(8);
    RTL_LDOUBLE_TO_INT64(source, wide);
    i64 value = (i64)ld_read64(wide);
    scratch_release(mark);
    return value == (i32)value ? (i32)value : (i32)0x80000000u;
}
