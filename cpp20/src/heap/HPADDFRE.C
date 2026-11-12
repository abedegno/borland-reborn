/* target: HPADDFRE */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPADDFRE (0054:03F3, image 0x933): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/HPADDFRE.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: ADD_FREE_NODE links a node into the free list. */
/* Overview: ADD_FREE_NODE marks a node free (flags = 4) and puts it at the
   front of the active bank's free list, just after the sentinel
   ACTIVE_HEAP.free_head, counting it in free_nodes and free_size.  The free
   list only holds free nodes inside the movable area (head to end); see
   HEAPMAIN.C's overview.  The node stays in the address chain as it was. */
#include "CPPHEAP.H"
/* link: ADD_FREE_NODE is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void near pascal ADD_FREE_NODE(HeapNode near *node)
{
    HeapNode near *after=ACTIVE_HEAP.free_head;
    node->next_free=after->next_free;
    node->previous_free=after;
    after->next_free=node;
    node->next_free->previous_free=node;
    node->flags=4;
    ++ACTIVE_HEAP.free_nodes;
    ACTIVE_HEAP.free_size+=node->size;
}
