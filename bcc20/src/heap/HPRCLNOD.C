/* target: CODE_2_RH0DCB */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: RH_RECLAIM_NODE decides whether a node can be given up to make
   room, moving it to another bank (flag 20h) or discarding it (flag 40h). Entry points:
   RH_RECLAIM_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: one step of reclaiming bank-0 space (called by
   RECLAIM_FOR_SPACE in HPRCLSPC.C).  A node flagged 20h is first moved to
   another bank (RH_TRY_FLAG20); failing that, a node flagged 40h is
   discarded (RH_TRY_FLAG40); see HPEVICT.C.  Nodes flagged 400h (probably
   overlay code) are spared while such nodes use less than their reserve
   field54 (field5 & 40h, set by RH_AVAILABLE_SPACE) unless the allocation
   may use the reserve (field5 & 1).  Returns 0 when the node was given up,
   else 1002h. */
#include "RHHEAP.H"
extern unsigned int near pascal RH_TRY_FLAG20(HeapNode near *node);
extern unsigned int near pascal RH_TRY_FLAG40(HeapNode near *node);
unsigned int near pascal RH_RECLAIM_NODE(HeapNode near *node)
{
    if((ACTIVE_HEAP.field5&0x40) && (node->flags&0x400)
       && !(ACTIVE_HEAP.field5&1))
        return 0x1002;
    if((node->flags&0x20) && !RH_TRY_FLAG20(node))
        return 0;
    if((node->flags&0x40) && !RH_TRY_FLAG40(node))
        return 0;
    return 0x1002;
}
