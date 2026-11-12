/* target: CODE_2_RH0C40 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: TAG_NODE marks a node as tagged, adds its size to the tagged total
   and tells its bank. Entry points: TAG_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: TAG_NODE puts a block on probation in the handle ring (see
   HPRING.C), called from RING_PUSH_NODE and RING_ADVANCE_CURSOR.  Locked
   nodes (8000h) are skipped.  A 400h node (probably overlay code) is first
   reported to its callback (operation 6).  The node is flagged 800h, its
   size added to tagged_size, and its handle switched to the descriptor-index
   form (RH_UPDATE_NODE_ADDRESS mode 2), probably so that the next use of
   the block goes through the heap.  UNTAG_NODE (HPUNTAG.C) undoes it. */
#include <dos.h>
#include "RHHEAP.H"
extern unsigned int near pascal RH_DISPATCH_NODE(HeapNode near *node,
    unsigned int operation,void far *metadata,unsigned int option);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);
void near pascal TAG_NODE(HeapNode near *node)
{
    if(node->flags&0x8000)
        return;
    if(node->flags&0x400)
        RH_DISPATCH_NODE(node,6,
            MK_FP((unsigned int)node->next_free,
                  (unsigned int)node->previous_free),0);
    ACTIVE_HEAP.tagged_size+=node->size;
    node->flags|=0x800;
    RH_UPDATE_NODE_ADDRESS(node,2);
}
