/* target: HPSHRNKN */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPSHRNKN (0054:0C6F, image 0x11AF): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPSHRNKN.C), with one CPP.EXE edit
   (marked); compiled by Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: SHRINK_NODE shrinks a node and returns the freed tail to the free
   list. Entry points: SHRINK_NODE. */
/* Overview: SHRINK_NODE cuts a node down to request bytes; the tail becomes
   a free node right after it, which joins the movable area when the node was
   the last fixed-low block, goes on the free list inside the movable area
   or merges outside it.  field8 gets the new byte size.  Used by RHAPI.C
   (CHANGE_HEAP_NODE_MODE); the caller checks that the size really shrinks.
   Runs with DS = the active bank.  (BCC.EXE's version also lowers
   tracked_size, and RESIZE_HANDLE_BLOCK, not in CPP.EXE, calls it too.) */
#include "CPPHEAP.H"
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
    /* CPP.EXE edit: BCC then takes remainder off ACTIVE_HEAP.tracked_size
       for a node flagged 60h; CPP.EXE's function ends here. */
}
