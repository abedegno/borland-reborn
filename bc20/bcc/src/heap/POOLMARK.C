/* target: CODE_5_STPAIR */
/* opts: -mm -G -O -Z -p */
/* Role: far-memory heap: saves and restores the length mark of the malloc pool (mark and
   release). Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: mark and release for the malloc pool.  The malloc pool is a
   POOLS.C pool of four words: MALLOC_POOL_SEG (segment, the heap handle
   word), the capacity, MALLOC_POOL_LENGTH (bytes used) and MALLOC_POOL_WORD6
   (its free-list head).  SAVE_MALLOC_POOL_MARK_BODY remembers the used length
   in MALLOC_POOL_LENGTH_MARK; RESTORE_MALLOC_POOL_MARK sets it back and
   empties the free list, which drops everything allocated since the mark. */
#include "DATA.H"
static unsigned int far pascal SAVE_MALLOC_POOL_MARK_BODY(void)
{
    return MALLOC_POOL_LENGTH_MARK=MALLOC_POOL_LENGTH;
}
static unsigned int far pascal RESTORE_MALLOC_POOL_MARK(void)
{
    MALLOC_POOL_WORD6=0;
    return MALLOC_POOL_LENGTH=MALLOC_POOL_LENGTH_MARK;
}
