/* target: CODE_2_RH0C86 */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: UNTAG_NODE clears a node's tagged flag and tells its bank. Entry
   points: UNTAG_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: UNTAG_NODE takes a block off probation (see HPRING.C and
   TAG_NODE in HPTAG.C): when flagged 800h, it clears the flag, gives the
   owner the segment form of the handle again (RH_UPDATE_NODE_ADDRESS mode
   4), reports a 400h node to its callback (operation 7) and takes the size
   out of tagged_size.  Called by RING_PUSH_NODE and before a node is
   re-filed as newest (MOVE_NODE_TO_RING_HEAD, CHANGE_HEAP_NODE_MODE,
   ADOPT_EXTERNAL_REGIONS). */
#include <dos.h>
#include "RHHEAP.H"
extern unsigned int near pascal RH_DISPATCH_NODE(HeapNode near *node,
    unsigned int operation,void far *metadata,unsigned int option);
extern unsigned int near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,
    unsigned char mode);
void near pascal UNTAG_NODE(HeapNode near *node)
{
    if(node->flags&0x800) {
        node->flags&=0xF7FF;
        RH_UPDATE_NODE_ADDRESS(node,4);
        if(node->flags&0x400)
            RH_DISPATCH_NODE(node,7,
                MK_FP((unsigned int)node->next_free,
                      (unsigned int)node->previous_free),0);
        ACTIVE_HEAP.tagged_size-=node->size;
    }
}
