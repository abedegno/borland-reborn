/* target: RHSWAP */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RHSWAP (0054:036D, image 0x8AD): source taken unchanged from the
   BCC.EXE reconstruction (bcc20/src/heap/RHSWAP.C); compiled by
   Turbo C 2.01 (see CPPHEAP.H). */
/* Role: far-memory heap: exchanges a node with the next one in the address chain. */
/* Overview: RHSWAP exchanges node with the node after it in the address
   chain: the next node takes node's key and node moves up past it.  Only the
   bookkeeping changes; callers move the block's contents themselves (with
   move_node_2c/2e) when needed, which is free when the other node is a free
   one. */
#include "CPPHEAP.H"
/* link: RHSWAP is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void near pascal RHSWAP(HeapNode near *node)
{
    HeapNode near *after=node->next;
    after->next->previous=node;
    node->previous->next=after;
    after->previous=node->previous;
    node->next=after->next;
    after->next=node;
    node->previous=after;
    after->key=node->key;
    node->key+=after->size;
}
