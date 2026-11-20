/* target: CODE_2_RHFADD */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: ADD_FREE_NODE links a node into the free list. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: ADD_FREE_NODE marks a node free (flags = 4) and puts it at the
   front of the active bank's free list, just after the sentinel
   ACTIVE_HEAP.free_head, counting it in free_nodes and free_size.  The free
   list only holds free nodes inside the movable area (head to end); see
   HEAPMAIN.C's overview.  The node stays in the address chain as it was. */
#include "RHHEAP.H"
static void near pascal ADD_FREE_NODE(HeapNode near *node)
{
    HeapNode near *after=ACTIVE_HEAP.free_head;
    node->next_free=after->next_free;
    node->previous_free=after;
    after->next_free=node;
    node->next_free->previous_free=node;
    node->flags=4;
    ++ACTIVE_HEAP.free_nodes;
    ACTIVE_HEAP.free_size+=node->size;
}
