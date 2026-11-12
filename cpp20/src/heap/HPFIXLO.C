/* target: HPFIXLO */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPFIXLO (0054:0B2D, image 0x106D): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPFIXLO.C), with the CPP.EXE edits
   marked; compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: ALLOC_FIXED_LOW allocates a node fixed at the low end of the heap,
   reclaiming and gathering free space as needed. Entry points: ALLOC_FIXED_LOW. */
/* Overview: ALLOC_FIXED_LOW allocates a block that will never move, at the
   low end of bank 0 (see HEAPMAIN.C's overview: the fixed-low blocks lie
   between chain_head and head).  A free hole of the right size among them
   is used first; otherwise space is reclaimed if needed, free space is
   gathered at the low end of the movable area, and head moves past the new
   block so it joins the fixed region.  The caller sets flag 8.  Used by
   RH_NEWPAGE and ALLOC_BANK0_NODE.  Returns the node, or 0.  Runs with DS
   set to the bank by the caller.  RH_AVAILABLE_SPACE is declared but not
   used in CPP.EXE. */
#include "CPPHEAP.H"
extern unsigned int near pascal RH_ROUND_REQUEST(unsigned int request);
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,
    HeapNode near *first,HeapNode near *restart,HeapNode near *stop);
extern HeapNode near * near pascal GATHER_FREE_AT_LOW_END(unsigned int needed,
    HeapNode near *start,HeapNode near *stop);
extern HeapNode near * near pascal RHSLICE(HeapNode near *node,
    unsigned int size,unsigned char mode);
extern void near pascal RHSETCUR(HeapNode near *node);

HeapNode near * near pascal ALLOC_FIXED_LOW(unsigned int request)
{
    /* CPP.EXE edit: node is a register variable (SI) and needed stays on the
       stack.  Turbo C 2.01 would put needed in DI by itself; volatile is a
       stand-in for whatever kept it out of a register in the original. */
    volatile unsigned int needed;
    register HeapNode near *node=
        ACTIVE_HEAP.chain_head->next;
    needed=RH_ROUND_REQUEST(request);
    for(;node!=ACTIVE_HEAP.head;node=node->next) {
        if((node->flags&4) && node->size>=needed) {
            RHSLICE(node,needed,0x18);
            goto allocated;
        }
    }
    /* CPP.EXE edit: reads ACTIVE_HEAP.free_size where BCC calls
       RH_AVAILABLE_SPACE (not in CPP.EXE). */
    if(ACTIVE_HEAP.free_size<needed &&
       RECLAIM_FOR_SPACE(needed,ACTIVE_HEAP.head,ACTIVE_HEAP.head,ACTIVE_HEAP.end))
        return 0;
    if((node=GATHER_FREE_AT_LOW_END(needed,ACTIVE_HEAP.head,ACTIVE_HEAP.end))) {
        RHSLICE(node,needed,0);
        ACTIVE_HEAP.head=node->next;
allocated:
        node->field8=request;
        RHSETCUR(node);
    }
    return node;
}
