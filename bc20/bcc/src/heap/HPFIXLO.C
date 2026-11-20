/* target: CODE_2_RH1222 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: ALLOC_FIXED_LOW allocates a node fixed at the low end of the heap,
   reclaiming and gathering free space as needed. Entry points: ALLOC_FIXED_LOW. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: ALLOC_FIXED_LOW allocates a block that will never move, at the
   low end of bank 0 (see HEAPMAIN.C's overview: the fixed-low blocks lie
   between chain_head and head).  A free hole of the right size among them
   is used first; otherwise space is reclaimed if needed, free space is
   gathered at the low end of the movable area, and head moves past the new
   block so it joins the fixed region.  The caller sets flag 8.  Used by
   RH_NEWPAGE and ALLOC_BANK0_NODE.  Returns the node, or 0. */
/* Complete zero-build proposal for original resident0094:1222..12D3.
   Caller-selected heap DS; observed leading views, not owned storage.
   No target/match/strict or historical source/name claim. */
#include "RHHEAP.H"
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,
    HeapNode near *first,HeapNode near *restart,HeapNode near *stop);
extern HeapNode near * near pascal GATHER_FREE_AT_LOW_END(unsigned int needed,
    HeapNode near *start,HeapNode near *stop);
extern HeapNode near * near pascal RHSLICE(HeapNode near *node,
    unsigned int size,unsigned char mode);
extern void near pascal RHSETCUR(HeapNode near *node);

HeapNode near * near pascal ALLOC_FIXED_LOW(unsigned int request)
{
    HeapNode near *node=
        ACTIVE_HEAP.chain_head->next;
    unsigned int needed=RH_ROUND_REQUEST(request);
    for(;node!=ACTIVE_HEAP.head;node=node->next) {
        if((node->flags&4) && node->size>=needed) {
            RHSLICE(node,needed,0x18);
            goto allocated;
        }
    }
    if(RH_AVAILABLE_SPACE()<needed &&
       RECLAIM_FOR_SPACE(needed,ACTIVE_HEAP.head,ACTIVE_HEAP.head,ACTIVE_HEAP.end))
        return 0;
    if((node=GATHER_FREE_AT_LOW_END(needed,ACTIVE_HEAP.head,ACTIVE_HEAP.end))) {
        RHSLICE(node,needed,0);
        ACTIVE_HEAP.head=node->next;
allocated:
        node->field8=request;
        RHSETCUR(node);
    }
    return node;
}
