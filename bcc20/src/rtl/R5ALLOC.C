/* target: CODE_5_R5ALLOC */
/* opts: -mm -G -O -Z -p -B */
/* Role: run-time library: MALLOC allocates a word-rounded block from the malloc pool and
   returns a far pointer to it. Entry points: MALLOC. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: BCC's malloc.  MALLOC rounds the size up to an even number of
   bytes, takes the block from the pool whose segment is MALLOC_POOL_SEG
   (POOL_ALLOC in heap/POOLS.C returns the offset inside that segment) and
   builds the far pointer from the two.  Callers are the driver and option
   code (CONFIG, OPTIONS, DRVLINK) and the precompiled-header code (PCH).
   There is no matching free here. */
#include <dos.h>
#include "DATA.H"
#include "OVL.H"
void far * far pascal MALLOC(register unsigned int size)
{
    ++size;
    size&=~1;
    return MK_FP(MALLOC_POOL_SEG,POOL_ALLOC(&MALLOC_POOL_SEG,size));
}
