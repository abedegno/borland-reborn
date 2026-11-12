/* target: HPUNFXHI */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPUNFXHI (0054:0610, image 0xB50): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/HPUNFXHI.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: UNFIX_HIGH_NODE releases a node that was fixed at the high end of
   the heap. Entry points: UNFIX_HIGH_NODE. */
/* Overview: UNFIX_HIGH_NODE, the mirror of UNFIX_LOW_NODE: clears flag 10h;
   when the node is the innermost fixed-high block (it is end), end moves up
   past it and any free or unfixed nodes above, the free ones going on the
   free list; returns 1, else 0. */
#include "CPPHEAP.H"
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
unsigned int near pascal UNFIX_HIGH_NODE(HeapNode near *node)
{
    node->flags &= ~0x10;
    if(node==ACTIVE_HEAP.end) {
        while(node!=ACTIVE_HEAP.chain_tail
            && !(node->flags&0x18)) {
            if(node->flags&4)
                ADD_FREE_NODE(node);
            node=node->next;
        }
        ACTIVE_HEAP.end=node;
        return 1;
    }
    return 0;
}
