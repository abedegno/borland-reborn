/* target: CODE_2_RH077F */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: UNFIX_LOW_NODE releases a node that was fixed at the low end of
   the heap. Entry points: UNFIX_LOW_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: UNFIX_LOW_NODE clears a node's fixed-low flag (8).  When the
   node is the innermost fixed-low block (its next is head), head moves down
   over it and over any free or unfixed nodes below it, up to the next fixed
   block or chain_head, and the free ones go on the free list; returns 1.
   Otherwise the node stays where it is inside the fixed region; returns 0. */
#include "RHHEAP.H"
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
unsigned int near pascal UNFIX_LOW_NODE(HeapNode near *node)
{
    node->flags &= ~8;
    if(node->next==ACTIVE_HEAP.head) {
        while(node!=ACTIVE_HEAP.chain_head
            && !(node->flags & 0x18)) {
            if(node->flags & 4)
                ADD_FREE_NODE(node);
            node=node->previous;
        }
        ACTIVE_HEAP.head=node->next;
        return 1;
    }
    return 0;
}
