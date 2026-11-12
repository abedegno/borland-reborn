/* target: HPMAINHD */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPMAINHD (image 0x222C..0x22AE, 0054:1CEC..0054:1D6E): the first
   functions of the BCC.EXE reconstruction's HEAPMAIN.C
   (bcc20/src/heap/HEAPMAIN.C): HANDLE_ITEM_POINTER, CONV_FIND_FREE_NODE
   and RH_ROUND_REQUEST, with their comments and with CPP.EXE's edits marked
   "CPP.EXE edit"; PIN_SEGMENT and UNPIN_SEGMENT, which CPP.EXE does not have, are left
   out.  In CPP.EXE they stand in front of the empty stub at image 0x22AE (HPSTUBMV.C,
   a BC 2.0 object), and the rest of HEAPMAIN.C follows the stub, so the stub splits
   BCC's HEAPMAIN.C in two here; this file holds the part in front of it (the name
   HPMAINHD is new).  Role: far-memory heap: a handle's output pointer, bank 0's
   free-space hook, and request rounding.  HANDLE_ITEM_POINTER has no caller in
   CPP.EXE's sources.
   Compiled by Turbo C 2.01 through TASM (-B, for RH_ROUND_REQUEST's asm), with
   register variables on: CONV_FIND_FREE_NODE keeps node in SI (BCC: -r-).
   CRLF line ends, CPPHEAP.H. */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,unsigned int far *offset);
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);

/* Return the output pointer of the node behind handle: the far address of
   the word where the heap keeps that block's handle (the owner's handle word
   or a heap item).  DS is switched to the node's bank only for the lookup;
   the DGROUP load of the huge function's frame restores it.
   CPP.EXE edit: huge in place of _loadds (Turbo C 2.01 has none).  The
   offset and the bank are kept in one small struct: both stay on the stack
   (bank stored at [bp-2] and used from AX), where Turbo C 2.01 puts a plain
   int bank in SI and a volatile one is read back from the stack.  The
   struct is a stand-in for whatever kept bank out of a register. */
unsigned int far * huge pascal HANDLE_ITEM_POINTER(unsigned int handle)
{
    struct { unsigned int node_offset; int bank; } where;
    where.bank=BCC_POOL_RESOLVE_WORD(handle,(unsigned int far *)&where.node_offset);
    _DS=HEAP_DESCRIPTOR_SEGMENTS[where.bank];
    return ((struct HeapOutputNodeView near *)where.node_offset)->output;
}

/* Bank 0's hook_26: find a free node of at least size paragraphs.  No free
   node gives 0; a single free node is returned when big enough; otherwise
   the movable blocks are compacted to gather the free space at the high end
   (GATHER_FREE_AT_HIGH_END from end back to head), which returns the gathered
   node or 0. */
HeapNode near * near pascal CONV_FIND_FREE_NODE(unsigned int size)
{
    HeapNode near *node;
    node=ACTIVE_HEAP.free_head->next_free;  /* CPP.EXE edit: cmp si,bx */
    if(node==ACTIVE_HEAP.free_head) return 0;
    if(node->next_free==ACTIVE_HEAP.free_head) {
        if(node->size>=size) return node;
        return 0;
    }
    return GATHER_FREE_AT_HIGH_END(size,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
}

/* Convert a byte count to the active bank's units: (request + field6) /
   field8, with the add done in 32 bits so a request near FFFFh does not
   wrap.  Bank 0 uses (request + 13h) / 10h, paragraphs with room to spare
   (probably for the node back-pointer word kept below each block); the other
   banks use field8 = their unit and field6 = unit - 1.  The quotient is left
   in AX by the div (fall-off-end, as the original). */
unsigned int near pascal RH_ROUND_REQUEST(unsigned int request)
{
    asm mov ax,request;
    asm xor dx,dx;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP.field6;
    asm adc dx,0;
    asm div word ptr DGROUP:ACTIVE_HEAP.field8;
}
