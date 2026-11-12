/* target: CODE_2_RH19BD */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: NEW_BANK5_NODE allocates a node in bank 5. Entry points:
   NEW_BANK5_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: bank 5's allocate hook (hook_22): bank 5 has no memory, so a
   "block" there is just a descriptor that remembers a discarded block.
   NEW_BANK5_NODE links a new node after chain_head with field8 = request,
   bank 5 in field19 and owner tag 0.  Used by RH_TRY_FLAG40 (through
   RH_HEAP_DISPATCH) and ALLOC_BANK5_NODE. */
/* Unbuilt ordinary-C proposal for resident0094:19BD..19EC, full47 bytes. */
#include "RHHEAP.H"
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);

HeapNode near * near pascal NEW_BANK5_NODE(unsigned int request)
{
    HeapNode near *node=RNEWNODE();
    RHLINK(ACTIVE_HEAP.chain_head,node);
    node->field8=request;
    node->field19=5;
    node->field12=0;
    return node;
}
