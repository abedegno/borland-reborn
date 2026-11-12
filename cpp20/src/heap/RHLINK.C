/* target: RHLINK */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RHLINK (0054:0450, image 0x990): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/RHLINK.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: inserts a node into the active bank's address-ordered node
   chain. */
/* Overview: RHLINK inserts node into the active bank's address-ordered node
   chain right after `after' (see HEAPMAIN.C's overview).  It does not set
   the node's key or size and does not touch the free list. */
#include "CPPHEAP.H"
/* link: RHLINK is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void near pascal RHLINK(HeapNode near *after, HeapNode near *node)
{
    node->next=after->next;
    node->previous=after;
    node->next->previous=node;
    after->next=node;
}
