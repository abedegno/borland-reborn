/* target: R5ALLOC */
/* opts: -mm -G -O -Z -p -B -zCCODE5 */
/* link: -zCCODE5 gives this file the code segment it shares with the other files of frame 0485h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module R5ALLOC (0485:009D..00BC): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/R5ALLOC.C); its code is the same in both programs. */
/* Role: run-time library: MALLOC allocates a word-rounded block from the malloc pool and
   returns a far pointer to it. Entry points: MALLOC. */
/* Overview: the program's malloc.  MALLOC rounds the size up to an even number of
   bytes, takes the block from the pool whose segment is MALLOC_POOL_SEG
   (POOL_ALLOC in heap/POOLS.C returns the offset inside that segment) and
   builds the far pointer from the two.  Callers in CPP.EXE are the driver and
   option code (CONFIG, OPTIONS, DRVLINK); BCC.EXE's precompiled-header code,
   another caller there, is not in CPP.EXE.  There is no matching free here. */
#include <dos.h>
#include "DATA.H"
#include "OVL.H"
void far * far pascal MALLOC(register unsigned int size)
{
    ++size;
    size&=~1;
    return MK_FP(MALLOC_POOL_SEG,POOL_ALLOC(&MALLOC_POOL_SEG,size));
}
