/* target: RHUNLINK */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RHUNLINK (0054:0427, image 0x967): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/RHUNLINK.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: takes a free node off the free list (it stays in the address
   chain). */
/* Overview: RHUNLINK takes a free node off the active bank's free list and
   out of free_nodes and free_size.  Despite the name it leaves the node in
   the address chain; UNLINK_HEAP_NODE is the one that unlinks from the chain. */
#include "CPPHEAP.H"
/* link: RHUNLINK is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void near pascal RHUNLINK(HeapNode near *node)
{
    node->next_free->previous_free=node->previous_free;
    node->previous_free->next_free=node->next_free;
    --ACTIVE_HEAP.free_nodes;
    ACTIVE_HEAP.free_size-=node->size;
}
