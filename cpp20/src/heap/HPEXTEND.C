/* target: HPEXTEND */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPEXTEND (0054:0F91, image 0x14D1): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPEXTEND.C), with one CPP.EXE edit
   (marked); compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: EXTEND_HEAP grows the heap by an amount and returns the new free
   node. Entry points: EXTEND_HEAP. */
/* Overview: EXTEND_HEAP adds amount units at the top of the active bank:
   a new node from the old top, the chain_tail sentinel and the bank size
   (leading_fields[1]) move up.  With no blocks fixed at the high end
   (end == chain_tail) the new space joins the free list and merges with free
   space below it; otherwise it merges outside the movable area.  Returns the
   free node now at the top.  In CPP.EXE only GROW_HEAP_TO (HPGROW.C) calls
   it; BCC.EXE's swap banks also call it after growing their file. */
#include "CPPHEAP.H"
extern HeapNode near * near pascal RNEWNODE(void);
extern void near pascal RHLINK(HeapNode near *after,HeapNode near *node);
extern void near pascal ADD_FREE_NODE(HeapNode near *node);
extern void near pascal RH_COALESCE_FREE(HeapNode near *node);
extern void near pascal RH_MARK_FREE_AND_MERGE(HeapNode near *node);

/* CPP.EXE edit: node is a register variable (SI) and amount stays on the
   stack.  Turbo C 2.01 would put amount in DI by itself; volatile is a
   stand-in for whatever kept it out of a register in the original. */
HeapNode near * near pascal EXTEND_HEAP(volatile unsigned int amount)
{
    register HeapNode near *node=RNEWNODE();
    node->key=ACTIVE_HEAP.chain_tail->key;
    node->size=amount;
    RHLINK(ACTIVE_HEAP.chain_tail->previous,node);
    ACTIVE_HEAP.leading_fields[1]+=amount;
    ACTIVE_HEAP.chain_tail->key+=amount;
    if(ACTIVE_HEAP.end==ACTIVE_HEAP.chain_tail) {
        ADD_FREE_NODE(node);
        RH_COALESCE_FREE(node);
        node=ACTIVE_HEAP.chain_tail->previous;
        if(node->size>ACTIVE_HEAP.free_cursor->size)
            ACTIVE_HEAP.free_cursor=node;
    } else {
        RH_MARK_FREE_AND_MERGE(node);
        node=ACTIVE_HEAP.chain_tail->previous;
    }
    return node;
}
