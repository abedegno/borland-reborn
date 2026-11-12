/* target: CODE_2_RHSETCUR */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: moves the active bank's roving cursor past the node just
   allocated. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RHSETCUR moves the active bank's roving cursor
   (ACTIVE_HEAP.current, where reclaim walks start) to the node after the
   one just allocated, or back to head when that node is outside the
   movable area (head to end). */
#include "RHHEAP.H"
static void near pascal RHSETCUR(HeapNode near *node)
{
    ACTIVE_HEAP.current=node->next;
    if (ACTIVE_HEAP.current->key < ACTIVE_HEAP.head->key ||
        ACTIVE_HEAP.current->key >= ACTIVE_HEAP.end->key)
        ACTIVE_HEAP.current=ACTIVE_HEAP.head;
}
