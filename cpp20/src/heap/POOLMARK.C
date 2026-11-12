/* target: POOLMARK */
/* opts: -mm -G -O -Z -p -zCCODE5 */
/* link: -zCCODE5 gives this file the code segment it shares with the other files of frame 0485h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module POOLMARK (0485:0081..0485:009D, image 0x48D1..0x48ED): source taken
   unchanged from the BCC.EXE reconstruction (bcc20/src/heap/POOLMARK.C);
   its code is the same in both programs.  SAVE_MALLOC_POOL_MARK's target row is still
   named SAVE_MALLOC_POOL_MARK_BODY (BCC's overlay-stub name). */
/* Role: far-memory heap: saves and restores the length mark of the malloc pool (mark and
   release).  Called from OPTIONS.C and INITPOOL.C. */
/* Overview: mark and release for the malloc pool.  The malloc pool is a
   POOLS.C pool of four words: MALLOC_POOL_SEG (segment, the heap handle
   word), the capacity, MALLOC_POOL_LENGTH (bytes used) and MALLOC_POOL_WORD6
   (its free-list head).  SAVE_MALLOC_POOL_MARK remembers the used length
   in MALLOC_POOL_LENGTH_MARK; RESTORE_MALLOC_POOL_MARK sets it back and
   empties the free list, which drops everything allocated since the mark. */
#include "DATA.H"
/* link: SAVE_MALLOC_POOL_MARK is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
unsigned int far pascal SAVE_MALLOC_POOL_MARK(void)
{
    return MALLOC_POOL_LENGTH_MARK=MALLOC_POOL_LENGTH;
}
/* link: RESTORE_MALLOC_POOL_MARK is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
unsigned int far pascal RESTORE_MALLOC_POOL_MARK(void)
{
    MALLOC_POOL_WORD6=0;
    return MALLOC_POOL_LENGTH=MALLOC_POOL_LENGTH_MARK;
}
