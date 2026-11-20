/* target: CODE_2_RH180E */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: EXTEND_HEAP grows the heap by an amount and returns the new free
   node. Entry points: EXTEND_HEAP. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: EXTEND_HEAP adds amount units at the top of the active bank:
   a new node from the old top, the chain_tail sentinel and the bank size
   (leading_fields[1]) move up.  With no blocks fixed at the high end
   (end == chain_tail) the new space joins the free list and merges with free
   space below it; otherwise it merges outside the movable area.  Returns the
   free node now at the top.  Used by GROW_HEAP_TO and by the swap banks after
   growing their file (HEAP_ALLOC_NODE, SWAP_MAKE_ROOM). */
/* Unbuilt ordinary-C proposal for original resident0094:180E..1893.
   Canonical observed unowned current-DS views; no new storage or layout. */
#include "RHHEAP.H"
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node);

HeapNode near * near pascal EXTEND_HEAP(unsigned int amount)
{
    HeapNode near *node=RNEWNODE();
    node->key=ACTIVE_HEAP.chain_tail->key;
    node->size=amount;
    RHLINK(ACTIVE_HEAP.chain_tail->previous,node);
    ACTIVE_HEAP.leading_fields[1]+=amount;
    ACTIVE_HEAP.chain_tail->key+=amount;
    if(ACTIVE_HEAP.end==ACTIVE_HEAP.chain_tail) {
        ADD_FREE_NODE(node);
        RH_COALESCE_FREE(node);
        node=ACTIVE_HEAP.chain_tail->previous;
        if(node->size>ACTIVE_HEAP.free_cursor->size)
            ACTIVE_HEAP.free_cursor=node;
    } else {
        RH_MARK_FREE_AND_MERGE(node);
        node=ACTIVE_HEAP.chain_tail->previous;
    }
    return node;
}
