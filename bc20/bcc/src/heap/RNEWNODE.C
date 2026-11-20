/* target: CODE_2_RNEWNODE */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: takes a descriptor from the shared free-descriptor list. Map of
   all sources: docs/SOURCE-MAP.md. */
/* Overview: RNEWNODE takes a descriptor from the shared free-descriptor
   list (see HPDESC.C), which is kept in bank 0's record: DS is switched to
   bank 0 through the program DS for the list update.  The returned offset is
   adjusted by the caller's bank_adjustment so that it is valid in the
   caller's bank DS.  There is no test for an empty list: callers make room
   first with RH_PREPARE_DESCRIPTORS. */
#include "RHHEAP.H"
#include "DATA.H"
extern unsigned int far HEAP_PROGRAM_DS;
static HeapNode near * near pascal RNEWNODE(void)
{
    HeapNode near *node;
    asm push ds;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm mov ds,word ptr HEAP_DESCRIPTOR_SEGMENTS;
    node=ACTIVE_HEAP.descriptor_head;
    ACTIVE_HEAP.descriptor_head=node->next_free;
    node->next_free=0;
    --ACTIVE_HEAP.descriptor_count;
    asm pop ds;
    return (HeapNode near *)((unsigned int)node-ACTIVE_HEAP.bank_adjustment);
}
