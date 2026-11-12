/* target: CODE_2_RH19FB */
/* opts: -mm -G -O -Z -p -r- */
/* Role: far-memory heap: GATHER_ALL_FREE_SPACE moves nodes so all free space forms one
   block at the high end. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: far entry that compacts the movable area of bank 0 so that all
   its free space forms one node at the high end; returns that node's offset
   (valid in bank 0's DS) or 0. */
/* Unbuilt hardware-domain wrapper proposal for resident0094:19FB..1A1A.
   WORD result transports the actual AX bank-relative offset; no observed
   consumer establishes a stronger cross-bank pointer/result interpretation. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);

static unsigned int far pascal _loadds GATHER_ALL_FREE_SPACE(void)
{
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    return (unsigned int)GATHER_FREE_AT_HIGH_END(0xffffU,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
}
