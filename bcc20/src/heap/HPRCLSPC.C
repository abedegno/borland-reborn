/* target: CODE_2_RG2A7 */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: RECLAIM_FOR_SPACE walks the nodes, giving up reclaimable ones
   until the needed space is free. Entry points: RECLAIM_FOR_SPACE. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the heap's last step before an allocation fails: reclaim
   blocks (move them to another bank or discard them, RH_RECLAIM_NODE) until
   RH_AVAILABLE_SPACE reaches the amount needed.  HEAP_ALLOC_NODE, the fixed
   allocators, RESIZE_NODE, SHRINK_HEAP_TO and C31_SET_MEMORY_LIMIT call it on
   bank 0.  Nodes that are free, fixed or locked (flags 4, 8, 10h, 8000h) are
   never taken, and in the first two walks neither are recently used nodes
   (ring entries newer than the tag cursor; see HPRING.C).  Reclaiming a node
   may free and merge descriptors, so after each attempt the walk checks
   whether the node was released (previous 0) and steps on from a live one. */
/* CODE_2:0E22..0F0A, RECLAIM_FOR_SPACE: try to reclaim nodes until RH_AVAILABLE_SPACE
   reaches needed.  It walks the node chain from first to stop, then once
   more from restart to stop, skipping nodes flagged 801Ch and nodes in the
   handle ring that are newer than the HANDLE_RING_TAG_CURSOR cursor.  Then it walks
   the whole handle ring (as HPDESC's RH_RELEASE_FLAGGED does), skipping nodes
   flagged 8018h.  Returns 0 once enough space is free, else 1000h.

   Compiled through TASM (-B).  Inline asm does the ring-age test and the
   ring walk, because the ring is in the program's DS (through ES).
   The age test's "mov al,[bx+0Dh]" reads node->field13 through the BX the
   preceding C test left loaded with node, as the original does (0E43).
   Segment set-up: _ES=ACTIVE_HEAP.program_segment (0E46, 0EB8), as in HPALLOCH.
   Documented exception (pseudo-register read): _CX at 0ED2, the ring slot's
   node the asm loaded. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
extern HeapNode near *HANDLE_RING_NODES[];
extern unsigned int near pascal RH_RECLAIM_NODE(HeapNode near *node);
extern unsigned int near pascal RH_AVAILABLE_SPACE(void);

unsigned int near pascal RECLAIM_FOR_SPACE(unsigned int needed,HeapNode near *first,
    HeapNode near *restart,HeapNode near *stop)
{
    HeapNode near *node;
    unsigned char first_round;
    first_round=1;
    node=first;
    for(;;) {
        do {
            if(!(node->flags&0x801c)) {
                if(node->flags&0x1000) {
                    /* skip if (slot - newest) < (tag cursor - newest): a
                       recently used node */
                    asm mov al,[bx+0Dh];
                    _ES=ACTIVE_HEAP.program_segment;
                    asm sub al,es:[offset DGROUP:HANDLE_RING_NEWEST];
                    asm mov ah,es:[offset DGROUP:HANDLE_RING_TAG_CURSOR];
                    asm sub ah,es:[offset DGROUP:HANDLE_RING_NEWEST];
                    asm cmp al,ah;
                    asm jb next;
                }
                if(!RH_RECLAIM_NODE(node) && RH_AVAILABLE_SPACE()>=needed)
                    return 0;
                if(!node->previous) {
                    while(!node->previous) node=node->next;
                    node=node->previous;
                }
            }
        next: ;
        } while((node=node->next)!=stop);
        if(first_round==0) break;
        node=restart;
        first_round=0;
    }
    _ES=ACTIVE_HEAP.program_segment;
    /* Last walk: every slot of the handle ring, newest first going back
       round, now including the recent ones. */
    asm mov bl,es:[offset DGROUP:HANDLE_RING_NEWEST];
    asm xor bh,bh;
again:
    asm dec bl;
    asm shl bx,1;
    asm mov cx,es:[bx+offset DGROUP:HANDLE_RING_NODES];
    asm shr bx,1;
    asm jcxz skip;
    asm push es;
    asm push bx;
    node=(HeapNode near *)_CX;
    if(!(node->flags&0x8018) && !RH_RECLAIM_NODE(node)
            && RH_AVAILABLE_SPACE()>=needed) {
        asm add sp,4;
        return 0;
    }
    asm pop bx;
    asm pop es;
skip:
    asm cmp bl,es:[offset DGROUP:HANDLE_RING_NEWEST];
    asm jne again;
    return 0x1000;
}
