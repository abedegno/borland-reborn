/* target: CODE_2_RH12D3 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: ALLOC_FIXED_HIGH allocates a node fixed at the high end of the
   heap, reclaiming and gathering free space as needed. Entry points: ALLOC_FIXED_HIGH. Map
   of all sources: docs/SOURCE-MAP.md. */
/* Overview: ALLOC_FIXED_HIGH, the counterpart of ALLOC_FIXED_LOW at the high
   end of bank 0 (fixed-high blocks lie from end to chain_tail).  A free hole
   among them is used first; otherwise free space is gathered at the top of
   the movable area, the used part is swapped above the leftover (RHSWAP) so
   it sits at the very top, and end moves down to it.  The caller sets flag
   10h.  Used by ALLOC_BANK0_NODE.  Returns the node, or 0. */
/* Complete zero-build proposal for original resident0094:12D3..1399.
   Caller-selected heap DS; observed views, not owned storage or full sizes. */
#include "RHHEAP.H"
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,
    HeapNode near *first,HeapNode near *restart,HeapNode near *stop);
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);
extern HeapNode near * near pascal RHSLICE(HeapNode near *node,
    unsigned int size,unsigned char mode);
extern void near pascal RHSWAP(HeapNode near *node);
extern void near pascal RHSETCUR(HeapNode near *node);

HeapNode near * near pascal ALLOC_FIXED_HIGH(unsigned int request)
{
    HeapNode near *node=ACTIVE_HEAP.chain_tail;
    unsigned int needed=RH_ROUND_REQUEST(request);
    HeapNode near *split;
    while(node!=ACTIVE_HEAP.end) {
        node=node->previous;
        if((node->flags&4) && node->size>=needed) {
            RHSLICE(node,needed,0x18);
            goto allocated;
        }
    }
    if(RH_AVAILABLE_SPACE()<needed &&
       RECLAIM_FOR_SPACE(needed,ACTIVE_HEAP.head,ACTIVE_HEAP.head,ACTIVE_HEAP.end))
        return 0;
    if((node=GATHER_FREE_AT_HIGH_END(needed,ACTIVE_HEAP.head,ACTIVE_HEAP.end))) {
        split=RHSLICE(node,needed,0);
        if(split!=node) {
            RHSWAP(node);
            if(ACTIVE_HEAP.head==node)
                ACTIVE_HEAP.head=split;
        }
        ACTIVE_HEAP.end=node;
allocated:
        node->field8=request;
        RHSETCUR(node);
    }
    return node;
}
