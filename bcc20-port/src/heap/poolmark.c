/* poolmark.c: from bcc20/src/heap/POOLMARK.C: mark and release for the malloc pool (a pool
   of four words: MALLOC_POOL_SEG, the capacity, MALLOC_POOL_LENGTH, MALLOC_POOL_WORD6, its
   free-list head).  The mark remembers the used length; the release sets it back and
   empties the free list, which drops everything allocated since the mark. */
#include "port.h"
#include "data.h"
#include "protos.h"

u16 SAVE_MALLOC_POOL_MARK_BODY(void)
{
    return MALLOC_POOL_LENGTH_MARK = MALLOC_POOL_LENGTH;
}

u16 RESTORE_MALLOC_POOL_MARK(void)
{
    MALLOC_POOL_WORD6 = 0;
    return MALLOC_POOL_LENGTH = MALLOC_POOL_LENGTH_MARK;
}
