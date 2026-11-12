/* target: CODE_2_RG2A8 */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: the 256-slot handle ring; RING_PUSH_NODE records a node as newest
   and tags or untags older ones, RING_ADVANCE_CURSOR moves the tag cursor. Entry points:
   RING_PUSH_NODE, RING_ADVANCE_CURSOR. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the handle ring, the heap's record of which reclaimable bank-0
   blocks were used most recently (see HEAPMAIN.C's overview for nodes and
   flags).  HANDLE_RING_NODES holds 256 node offsets in the program's DS; a
   node in it has flag 1000h and its slot number in field13.  Each push
   moves the newest cursor down one slot, so slot numbers counted up from
   HANDLE_RING_NEWEST give a node's age; the slot being reused is cleared.
   The tag cursor marks where tagging starts: TAG_NODE flags 800h, adds the
   node to tagged_size and switches its handle to the descriptor-index form,
   probably so that the next use of the block goes through the heap and can
   be seen; a used block is then moved back to the newest slot (MOVE_NODE_TO_RING_HEAD,
   CHANGE_HEAP_NODE_MODE).  RECLAIM_FOR_SPACE leaves ring nodes newer than
   the tag cursor alone.  This is probably the same idea as the overlay
   manager's probation area.  The third cursor untags (UNTAG_NODE) the node
   it reaches.  Callers: CHANGE_HEAP_NODE_MODE and ADOPT_EXTERNAL_REGIONS
   (RHAPI.C) push nodes; RH_TRY_FLAG20/40 (HPEVICT.C) advance the cursor. */
/* CODE_2:0CCC..0D8E: the program's 256-slot handle ring (HANDLE_RING_NODES,
   indexed by bytes in program DS).  Three byte cursors trail each other:
   HANDLE_RING_NEWEST (newest), HANDLE_RING_TAG_CURSOR and HANDLE_RING_UNTAG_CURSOR.
   RING_PUSH_NODE(node, force) steps each cursor back one slot, handing the node it
   lands on to RH_CLEAR_TAG_ENTRY, TAG_NODE and UNTAG_NODE respectively (the 06C7
   step only when force is set or 06C8 is within 3 slots of 06C7).  It then
   stores node at the newest slot, records the slot in node->field13 and
   sets flag 1000h.  RING_ADVANCE_CURSOR steps HANDLE_RING_TAG_CURSOR back one slot when it is 3 or
   more slots ahead of the newest cursor.

   Inline asm (compiled through TASM, -B): the ring lives in the program's
   DS, reached through ES = ACTIVE_HEAP.program_segment (C assignments to
   _ES, as in HPALLOCH).  The asm is for what BCC does not generate: the byte
   cursor arithmetic in BL, jcxz on the slot, and the node carried in CX into
   push cx / call, with ES reloaded after each call.
   Documented exception (pseudo-register read): _CL at 0D53, the slot index
   the asm left in CL. */
#include <dos.h>
#include "RHHEAP.H"
#include "DATA.H"
extern HeapNode near *HANDLE_RING_NODES[];
extern void near pascal RH_CLEAR_TAG_ENTRY(HeapNode near *node);
extern void near pascal TAG_NODE(HeapNode near *node);
extern void near pascal UNTAG_NODE(HeapNode near *node);

void near pascal RING_PUSH_NODE(HeapNode near *node,unsigned char force)
{
    _ES=ACTIVE_HEAP.program_segment;
    /* 1. New newest slot: clear the node still in it (the oldest entry). */
    asm dec byte ptr es:[offset DGROUP:HANDLE_RING_NEWEST];
    asm mov bl,es:[offset DGROUP:HANDLE_RING_NEWEST];
    asm xor bh,bh;
    asm shl bx,1;
    asm mov cx,es:[bx+offset DGROUP:HANDLE_RING_NODES];
    asm jcxz second;
    asm push cx;
    asm call RH_CLEAR_TAG_ENTRY;
    _ES=ACTIVE_HEAP.program_segment;
    /* 2. Step the tag cursor and tag the node there, unless force is 0 and
       the untag cursor is more than 3 slots past it. */
second:
    asm cmp byte ptr force,0;
    asm jne advance;
    asm mov al,es:[offset DGROUP:HANDLE_RING_UNTAG_CURSOR];
    asm sub al,es:[offset DGROUP:HANDLE_RING_TAG_CURSOR];
    asm cmp al,3;
    asm ja third;
advance:
    asm dec byte ptr es:[offset DGROUP:HANDLE_RING_TAG_CURSOR];
    asm mov bl,es:[offset DGROUP:HANDLE_RING_TAG_CURSOR];
    asm xor bh,bh;
    asm shl bx,1;
    asm mov cx,es:[bx+offset DGROUP:HANDLE_RING_NODES];
    asm jcxz third;
    asm push cx;
    asm call TAG_NODE;
    _ES=ACTIVE_HEAP.program_segment;
    /* 3. Step the untag cursor and untag the node there. */
third:
    asm dec byte ptr es:[offset DGROUP:HANDLE_RING_UNTAG_CURSOR];
    asm mov bl,es:[offset DGROUP:HANDLE_RING_UNTAG_CURSOR];
    asm xor bh,bh;
    asm shl bx,1;
    asm mov cx,es:[bx+offset DGROUP:HANDLE_RING_NODES];
    asm jcxz store;
    asm push cx;
    asm call UNTAG_NODE;
    _ES=ACTIVE_HEAP.program_segment;
    /* 4. Store node in the newest slot. */
store:
    asm mov bl,es:[offset DGROUP:HANDLE_RING_NEWEST];
    asm mov cl,bl;
    asm xor bh,bh;
    asm shl bx,1;
    asm mov ax,node;
    asm mov es:[bx+offset DGROUP:HANDLE_RING_NODES],ax;
    node->field13=_CL;
    node->flags|=0x1000;
}

void near pascal RING_ADVANCE_CURSOR(void)
{
    _ES=ACTIVE_HEAP.program_segment;
    asm mov al,es:[offset DGROUP:HANDLE_RING_TAG_CURSOR];
    asm sub al,es:[offset DGROUP:HANDLE_RING_NEWEST];
    asm cmp al,3;
    asm jb done;
    asm dec byte ptr es:[offset DGROUP:HANDLE_RING_TAG_CURSOR];
    asm mov bl,es:[offset DGROUP:HANDLE_RING_TAG_CURSOR];
    asm xor bh,bh;
    asm shl bx,1;
    asm mov cx,es:[bx+offset DGROUP:HANDLE_RING_NODES];
    asm jcxz done;
    asm push cx;
    asm call TAG_NODE;
done: ;
}
