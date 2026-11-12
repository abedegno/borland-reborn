/* target: CODE_2_RH07D4 */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: UNFIX_HIGH_NODE releases a node that was fixed at the high end of
   the heap. Entry points: UNFIX_HIGH_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: UNFIX_HIGH_NODE, the mirror of UNFIX_LOW_NODE: clears flag 10h;
   when the node is the innermost fixed-high block (it is end), end moves up
   past it and any free or unfixed nodes above, the free ones going on the
   free list; returns 1, else 0. */
#include "RHHEAP.H"
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
