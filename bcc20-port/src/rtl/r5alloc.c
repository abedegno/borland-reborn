/* r5alloc.c: from bcc20/src/rtl/R5ALLOC.C: MALLOC, an even number of bytes from the malloc
   pool (POOL_ALLOC on MALLOC_POOL_SEG), as a far pointer.  There is no free; the pool is
   cut back by RESTORE_MALLOC_POOL_MARK. */
#include "port.h"
#include "data.h"
#include "protos.h"

farptr MALLOC(u16 size)
{
    ++size;
    size &= (u16)~1u;
    u16 offset = POOL_ALLOC(MALLOC_POOL_SEG_P, size);
    return MK_FP(MALLOC_POOL_SEG, offset);
}
