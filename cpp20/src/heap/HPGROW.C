/* target: HPGROW */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPGROW (0054:1214, image 0x1754): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/HPGROW.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: GROW_HEAP_TO grows the heap up to a requested top.  In
   BCC.EXE it runs after TASM or TLINK; CPP.EXE runs neither, and the function is
   static here with no caller. */
/* Overview: far entry that grows bank 0 back up after it was shrunk with
   SHRINK_HEAP_TO (in BCC.EXE probably around running TASM or TLINK): the
   top is raised to the paragraph request, or to HEAP_SAVED_TOP_KEY (the top
   saved by SHRINK_HEAP_TO) when request is 0, by adding free space with
   EXTEND_HEAP.  HEAP_SAVED_TOP_KEY is read before DS is switched to the
   bank.  The DOS memory block itself is probably resized by the caller. */
#include <dos.h>
#include "CPPHEAP.H"
extern HeapNode near * near pascal EXTEND_HEAP(unsigned int amount);

static void huge pascal GROW_HEAP_TO(unsigned int request)
{
    unsigned int limit=request;
    if(!limit)
        limit=HEAP_SAVED_TOP_KEY;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(ACTIVE_HEAP.chain_tail->key<limit)
        EXTEND_HEAP(limit-ACTIVE_HEAP.chain_tail->key);
}
