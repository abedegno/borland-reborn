/* target: HPRCLSPC */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPRCLSPC (0054:08A0, image 0xDE0): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/HPRCLSPC.C); compiled by Turbo C 2.01
   (see CPPHEAP.H), with the CPP.EXE edits marked. */
/* Role: far-memory heap: RECLAIM_FOR_SPACE walks the nodes, giving up reclaimable ones
   until the needed space is free. Entry points: RECLAIM_FOR_SPACE. */
/* Overview: the heap's last step before an allocation fails: reclaim
   blocks (move them to another bank or discard them, RH_RECLAIM_NODE) until
   ACTIVE_HEAP.free_size reaches the amount needed.  HEAP_ALLOC_NODE, the
   fixed allocators, RESIZE_NODE and SHRINK_HEAP_TO call it on bank 0.  Nodes
   that are free, fixed or locked (flags 4, 8, 10h, 8000h) are never taken.
   It walks the node chain from first to stop, then once more from restart
   to stop, and returns 0 once enough space is free, else 1000h.  Reclaiming
   a node may free and merge descriptors, so after each attempt the walk
   checks whether the node was released (previous 0) and steps on from a
   live one.  BCC.EXE's version also skips recently used nodes of its handle
   ring and then walks the ring; CPP.EXE has no handle ring (see the edit
   below). */
#include "CPPHEAP.H"
extern unsigned int near pascal RH_RECLAIM_NODE(HeapNode near *node);

/* CPP.EXE edit: CPP's RECLAIM_FOR_SPACE (image 0xDE0, 0x62 bytes) is only the
   two chain walks.  It has no handle ring: no ring-age test (flag 1000h) and
   no last walk over the ring, so no inline asm.  The space test reads
   ACTIVE_HEAP.free_size (mov ax,ds:[1Ah]) where BCC calls RH_AVAILABLE_SPACE,
   and it returns 1000h after the second walk.  node is a register variable
   (SI) and restart is copied to DI first (push si; push di; mov di,[bp+6]),
   so the file is built with register variables on (BCC: -r-); first_round
   stays on the stack.  The chain step is a statement of its own (BCC's
   while((node=node->next)!=stop) gives mov ax,si; cmp ax,[bp+4]). */
unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,HeapNode near *first,
    HeapNode near *restart,HeapNode near *stop)
{
    register HeapNode near *node;
    register HeapNode near *again=restart;
    unsigned char first_round;
    first_round=1;
    node=first;
    for(;;) {
        do {
            if(!(node->flags&0x801c)) {
                if(!RH_RECLAIM_NODE(node) && ACTIVE_HEAP.free_size>=needed)
                    return 0;
                if(!node->previous) {
                    while(!node->previous) node=node->next;
                    node=node->previous;
                }
            }
            node=node->next;
        } while(node!=stop);
        if(first_round==0) break;
        node=again;
        first_round=0;
    }
    return 0x1000;
}
