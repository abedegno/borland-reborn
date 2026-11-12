/* target: CODE_2_RH1A2F */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: shrinks the heap to a given size (SHRINK_HEAP_TO). Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: far entry that lowers the top of bank 0 by up to limit
   paragraphs, probably before TASM or TLINK is run (no C caller names it),
   so that DOS memory can be given back; GROW_HEAP_TO undoes it.  The
   current top is saved in HEAP_SAVED_TOP_KEY (a program-DS word, written
   through ES).  Only when no block is fixed at the high end: blocks are
   reclaimed if needed, free space
   is gathered at the top, and the top free node is cut down (at least one
   paragraph is kept).  Returns the new top paragraph. */
/* Unbuilt complete proposal for resident0094:1A2F..1AE0, 177 bytes.
   Real program/bank DS and program ES domains; no source-state fabrication. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
/* Unowned program-DGROUP WORD at06C4. Only its linked offset is used
   while selected-bank DS is active; the actual store uses selected ES. */
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);
extern unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,
    HeapNode near *first,HeapNode near *restart,HeapNode near *stop);
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);

static unsigned int far pascal _loadds SHRINK_HEAP_TO(unsigned int limit)
{
    HeapNode near *node;
    unsigned int amount=limit;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    _ES=ACTIVE_HEAP.program_segment;
    *(unsigned int _es *)(unsigned int)&HEAP_SAVED_TOP_KEY=
        ACTIVE_HEAP.chain_tail->key;
    if(ACTIVE_HEAP.end==ACTIVE_HEAP.chain_tail) {
        if(RH_AVAILABLE_SPACE()<amount &&
           RECLAIM_FOR_SPACE(amount,ACTIVE_HEAP.current,ACTIVE_HEAP.head,ACTIVE_HEAP.end))
            amount=RH_AVAILABLE_SPACE();
        GATHER_FREE_AT_HIGH_END(amount,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
        node=ACTIVE_HEAP.chain_tail->previous;
        if(node->flags&4) {
            if(node->size<=amount)
                amount=node->size-1;
            ACTIVE_HEAP.free_size-=amount;
            node->size-=amount;
            ACTIVE_HEAP.chain_tail->key=
                node->key+node->size;
            ACTIVE_HEAP.leading_fields[1]=
                ACTIVE_HEAP.chain_tail->key-
                ACTIVE_HEAP.leading_fields[0];
        }
    }
    return ACTIVE_HEAP.leading_fields[0]+ACTIVE_HEAP.leading_fields[1];
}
