/* target: CODE_2_RHLINK */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: inserts a node into the active bank's address-ordered node chain.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RHLINK inserts node into the active bank's address-ordered node
   chain right after `after' (see HEAPMAIN.C's overview).  It does not set
   the node's key or size and does not touch the free list. */
#include "RHHEAP.H"
static void near pascal RHLINK(HeapNode near *after, HeapNode near *node)
{
    node->next=after->next;
    node->previous=after;
    node->next->previous=node;
    after->next=node;
}
