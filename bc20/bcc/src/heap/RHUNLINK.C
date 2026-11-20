/* target: CODE_2_RHUNLINK */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: takes a free node off the free list (it stays in the address
   chain). Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RHUNLINK takes a free node off the active bank's free list and
   out of free_nodes and free_size.  Despite the name it leaves the node in
   the address chain; RRETNDES is the one that unlinks from the chain. */
#include "RHHEAP.H"
static void near pascal RHUNLINK(HeapNode near *node)
{
    node->next_free->previous_free=node->previous_free;
    node->previous_free->next_free=node->next_free;
    --ACTIVE_HEAP.free_nodes;
    ACTIVE_HEAP.free_size-=node->size;
}
