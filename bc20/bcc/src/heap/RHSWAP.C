/* target: CODE_2_RHSWAP */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: exchanges a node with the next one in the address chain. Map of
   all sources: docs/SOURCE-MAP.md. */
/* Overview: RHSWAP exchanges node with the node after it in the address
   chain: the next node takes node's key and node moves up past it.  Only the
   bookkeeping changes; callers move the block's contents themselves (with
   move_node_2c/2e) when needed, which is free when the other node is a free
   one. */
#include "RHHEAP.H"
static void near pascal RHSWAP(HeapNode near *node)
{
    HeapNode near *after=node->next;
    after->next->previous=node;
    node->previous->next=after;
    after->previous=node->previous;
    node->next=after->next;
    after->next=node;
    node->previous=after;
    after->key=node->key;
    node->key+=after->size;
}
