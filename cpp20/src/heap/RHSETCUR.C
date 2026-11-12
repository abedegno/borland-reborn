/* target: RHSETCUR */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RHSETCUR (0054:0473, image 0x9B3): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/RHSETCUR.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: moves the active bank's roving cursor past the node just
   allocated. */
/* Overview: RHSETCUR moves the active bank's roving cursor
   (ACTIVE_HEAP.current, where reclaim walks start) to the node after the
   one just allocated, or back to head when that node is outside the
   movable area (head to end). */
#include "CPPHEAP.H"
/* link: RHSETCUR is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void near pascal RHSETCUR(HeapNode near *node)
{
    ACTIVE_HEAP.current=node->next;
    if (ACTIVE_HEAP.current->key < ACTIVE_HEAP.head->key ||
        ACTIVE_HEAP.current->key >= ACTIVE_HEAP.end->key)
        ACTIVE_HEAP.current=ACTIVE_HEAP.head;
}
