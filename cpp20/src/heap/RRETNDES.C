/* target: RRETNDES */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RRETNDES (0054:018B, image 0x6CB): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/RRETNDES.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: unlinks a node from the address chain and gives back its
   descriptor. */
/* Overview: UNLINK_HEAP_NODE unlinks a node from the active bank's address chain and
   gives its descriptor back to the shared free list in bank 0's record (see
   HPDESC.C); the counterpart of RNEWNODE.  The module keeps BCC's file name
   RRETNDES; the function is UNLINK_HEAP_NODE (0054:018B), the name its
   callers use.  It clears the node's
   previous link (and previous_free) but keeps next: node walkers that may
   release nodes test previous == 0 to see that a node was released and
   follow next to a live one (FREE_TAG_NODES, RECLAIM_FOR_SPACE). */
#include "CPPHEAP.H"
extern unsigned int far HEAP_PROGRAM_DS;
/* link: UNLINK_HEAP_NODE is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void near pascal UNLINK_HEAP_NODE(unsigned char near *node)
{
    ((HeapNode near *)node)->next->previous=((HeapNode near *)node)->previous;
    ((HeapNode near *)node)->previous->next=((HeapNode near *)node)->next;
    asm push ds;
    node+=ACTIVE_HEAP.bank_adjustment;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm mov ds,word ptr DGROUP:HEAP_DESCRIPTOR_SEGMENTS;
    ((HeapNode near *)node)->previous=((HeapNode near *)node)->previous_free=0;
    ((HeapNode near *)node)->next_free=ACTIVE_HEAP.descriptor_head;
    ACTIVE_HEAP.descriptor_head=(HeapNode near *)node;
    ++ACTIVE_HEAP.descriptor_count;
    asm pop ds;
}
