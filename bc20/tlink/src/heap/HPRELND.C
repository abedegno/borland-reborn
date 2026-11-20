/* target: H_HPRELND */
/* opts: -mm -G -O -Z -p -r- -zCCODE2 */
/* Role: far-memory heap: RH_RELEASE_DESCRIPTOR frees a node: drops its bank copy and ring
   entry, unfixes it, and returns it to the free list. */
/* Overview: RH_RELEASE_DESCRIPTOR frees a used block in the active bank; it
   is every bank's default release hook (hook_24) and is called directly for
   handle pages.  Despite the name it frees the block, not just the
   descriptor.  It takes the node out of the tracked totals (bank 0), releases
   the copy kept in another bank (flag 2000h), clears its ring slot, releases
   a fixed-low or fixed-high fix, then puts the space on the free list and
   merges it when it lies in the movable area, or merges it outside the list
   when it lies in a fixed region.  Returns 0. */
#include "RHHEAP.H"
extern unsigned int near pascal RH_RELEASE_SPECIAL(HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node);
unsigned int near pascal RH_RELEASE_DESCRIPTOR(HeapNode near *node)
{
    unsigned int result=1;
    if(node->flags&0x18)
        result=RH_RELEASE_SPECIAL(node);
    if(result && node->key>=ACTIVE_HEAP.head->key && node->key<ACTIVE_HEAP.end->key) {
        ADD_FREE_NODE(node);
        RH_COALESCE_FREE(node);
    } else
        RH_MARK_FREE_AND_MERGE(node);
    return 0;
}
