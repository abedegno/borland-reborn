/* target: RNEWNODE */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RNEWNODE (0054:0158, image 0x698): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/RNEWNODE.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: takes a descriptor from the shared free-descriptor list. */
/* Overview: RNEWNODE takes a descriptor from the shared free-descriptor
   list (see HPDESC.C), which is kept in bank 0's record: DS is switched to
   bank 0 through the program DS for the list update.  The returned offset is
   adjusted by the caller's bank_adjustment so that it is valid in the
   caller's bank DS.  There is no test for an empty list: callers make room
   first with RH_PREPARE_DESCRIPTORS. */
#include "CPPHEAP.H"
extern unsigned int far HEAP_PROGRAM_DS;
/* link: RNEWNODE is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
HeapNode near * near pascal RNEWNODE(void)
{
    HeapNode near *node;
    asm push ds;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm mov ds,word ptr DGROUP:HEAP_DESCRIPTOR_SEGMENTS;
    node=ACTIVE_HEAP.descriptor_head;
    ACTIVE_HEAP.descriptor_head=node->next_free;
    node->next_free=0;
    --ACTIVE_HEAP.descriptor_count;
    asm pop ds;
    return (HeapNode near *)((unsigned int)node-ACTIVE_HEAP.bank_adjustment);
}
