/* target: CODE_2_RRETNDES */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: unlinks a node from the address chain and gives back its
   descriptor. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RRETNDES unlinks a node from the active bank's address chain and
   gives its descriptor back to the shared free list in bank 0's record (see
   HPDESC.C); the counterpart of RNEWNODE.  Other heap files call it as
   UNLINK_HEAP_NODE (symbols.tsv puts that name at 0094:0266,
   which is probably this function's address).  It clears the node's
   previous link (and previous_free) but keeps next: node walkers that may
   release nodes test previous == 0 to see that a node was released and
   follow next to a live one (FREE_TAG_NODES, CHANGE_TAG_NODES_MODE,
   RECLAIM_FOR_SPACE). */
#include "RHHEAP.H"
#include "DATA.H"
extern unsigned int far HEAP_PROGRAM_DS;
static void near pascal RRETNDES(unsigned char near *node)
{
    ((HeapNode near *)node)->next->previous=((HeapNode near *)node)->previous;
    ((HeapNode near *)node)->previous->next=((HeapNode near *)node)->next;
    asm push ds;
    node+=ACTIVE_HEAP.bank_adjustment;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm mov ds,word ptr HEAP_DESCRIPTOR_SEGMENTS;
    ((HeapNode near *)node)->previous=((HeapNode near *)node)->previous_free=0;
    ((HeapNode near *)node)->next_free=ACTIVE_HEAP.descriptor_head;
    ACTIVE_HEAP.descriptor_head=(HeapNode near *)node;
    ++ACTIVE_HEAP.descriptor_count;
    asm pop ds;
}
