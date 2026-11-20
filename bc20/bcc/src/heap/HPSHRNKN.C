/* target: CODE_2_RH1399 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: SHRINK_NODE shrinks a node and returns the freed tail to the free
   list. Entry points: SHRINK_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: SHRINK_NODE cuts a node down to request bytes; the tail becomes
   a free node right after it, which joins the movable area when the node was
   the last fixed-low block, goes on the free list inside the movable area
   or merges outside it.  field8 gets the new byte size and tracked_size
   drops for a tracked node.  Used by CHANGE_HEAP_NODE_MODE and
   RESIZE_HANDLE_BLOCK; the caller checks that the size really shrinks. */
/* Complete zero-build proposal for original resident0094:1399..1441.
   Current selected heap DS, observed node/control prefixes, no owned DATA. */
#include "RHHEAP.H"
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node);

void near pascal SHRINK_NODE(HeapNode near *node,unsigned int request)
{
    unsigned int needed=RH_ROUND_REQUEST(request);
    unsigned int remainder=node->size-needed;
    HeapNode near *tail=RNEWNODE();
    tail->size=remainder;
    node->size=needed;
    tail->key=node->key+needed;
    RHLINK(node,tail);
    tail->flags=4;
    if(tail->next==ACTIVE_HEAP.head)
        ACTIVE_HEAP.head=tail;
    if(tail->key>=ACTIVE_HEAP.head->key &&
       tail->key<ACTIVE_HEAP.end->key) {
        ADD_FREE_NODE(tail);
        RH_COALESCE_FREE(tail);
    } else
        RH_MARK_FREE_AND_MERGE(tail);
    node->field8=request;
    if(node->flags&0x60)
        ACTIVE_HEAP.tracked_size-=remainder;
}
