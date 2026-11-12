/* target: HPRCLNOD */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPRCLNOD (0054:086F, image 0xDAF): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPRCLNOD.C), with one CPP.EXE edit
   (marked); compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: RH_RECLAIM_NODE decides whether a node can be given up to make
   room, moving it to another bank (flag 20h) or discarding it (flag 40h). Entry points:
   RH_RECLAIM_NODE. */
/* Overview: one step of reclaiming bank-0 space (called by
   RECLAIM_FOR_SPACE in HPRCLSPC.C).  A node flagged 20h is first moved to
   another bank (RH_TRY_FLAG20); failing that, a node flagged 40h is
   discarded (RH_TRY_FLAG40); see HPEVICT.C.  Returns 0 when the node was
   given up, else 1002h.  (BCC.EXE's version first spares overlay-code nodes,
   flag 400h, within their reserve; CPP.EXE has no overlays.) */
#include "CPPHEAP.H"
extern unsigned int near pascal RH_TRY_FLAG20(HeapNode near *node);
extern unsigned int near pascal RH_TRY_FLAG40(HeapNode near *node);
unsigned int near pascal RH_RECLAIM_NODE(HeapNode near *node)
{
    /* CPP.EXE edit: no test of the overlay-code reserve (ACTIVE_HEAP.field5
       and flag 400h); CPP.EXE's code starts with the flag 20h test. */
    if((node->flags&0x20) && !RH_TRY_FLAG20(node))
        return 0;
    if((node->flags&0x40) && !RH_TRY_FLAG40(node))
        return 0;
    return 0x1002;
}
