/* target: HPDISP */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module HPDISP (image 0x20EF..0x2212, 0054:1BAF..0054:1CD2): source taken
   from the BCC.EXE reconstruction (bcc20/src/heap/HPDISP.C), with the
   CPP.EXE edits listed here.
   CPP.EXE edits (HEAP2 agent):
   - Compiled by Turbo C 2.01 through TASM (-B), not BC 2.0, and without -a:
     the dispatcher's switch is TC's (mov ax,op; cmp ax,3; ja; mov bx,ax), and
     its jump table follows the jmp at an odd address (0054:1BF9) with no pad
     byte.  CRLF line ends and CPPHEAP.H, as the other TC heap files.
   - The DGROUP compare and loads are inline asm (mov ax,ds; cmp ax,DGROUP;
     mov ax,DGROUP; mov ds,ax): TC 2.01 gives FP_SEG of a far extern as a
     two-register compare.
   - Cases 2 and 3 share the result=0 after the switch (case 2 jumps there,
     case 3 falls into it), where BCC sets it in each case.
   - Node descriptors are 20 bytes (14h) from 140h, banks 40h apart (CPP's
     five 4-paragraph bank records, see HEAPMAIN.C), where BCC has 22, 1E0h
     and 50h.
   - Two ES stores/loads are asm (mov es:[0Eh],ax; mov cx,es:[0Eh]): TC 2.01
     goes through BX for the MK_FP pointers of BCC's C. */
/* Role: far-memory heap: RH_HEAP_DISPATCH calls a bank's operation, RH_UPDATE_NODE_ADDRESS
   reports a node's address, BCC_POOL_RESOLVE_WORD finds a handle's node and bank. Entry
   points: RH_HEAP_DISPATCH, RH_UPDATE_NODE_ADDRESS, BCC_POOL_RESOLVE_WORD. */
/* Overview: the three low-level links between handles, nodes and banks (see
   HEAPMAIN.C's overview), used all over the heap.  A handle word is either a
   block's segment (bank 0, block in conventional memory) or a descriptor
   index (any bank).  RH_UPDATE_NODE_ADDRESS writes a node's current handle
   into the owner's word; BCC_POOL_RESOLVE_WORD reads a handle back into a
   bank number and a node offset valid in that bank's DS; RH_HEAP_DISPATCH
   calls a hook of another bank and returns to the caller's bank.  The
   detailed notes follow. */
/* Three small heap helpers, C with register pseudo-variables and inline asm
   (written in the run-time's .CAS style).  In BCC.EXE they are BC 2.0 code
   built with -a; in CPP.EXE Turbo C 2.01 without -a (see the edits above).
   RH_HEAP_DISPATCH(bank, operation, first, second), cdecl: calls one of the
     hooks of descriptor bank `bank' (0: +22h, 1: +24h, which takes a node,
     2 and 3: the (node, key) hooks +28h and +2Ah) with that bank in DS, and
     returns the hook's result for 0 and 1, else 0.  A bank whose segment is
     0 returns 0 without calling anything.  DS is put back to the caller's
     bank (ACTIVE_HEAP.field4 at entry) or left at DGROUP.  Cases 2 and 3
     share the result=0 after the switch.
   RH_UPDATE_NODE_ADDRESS(node, mode), pascal: stores the node's handle at
     its output pointer: with mode & 2 the descriptor index
     (node - ACTIVE_HEAP.field30) / 20, else the node's segment (its key),
     and then the node's offset at +0Eh of the paragraph below that segment.
   BCC_POOL_RESOLVE_WORD(handle, far *offset), pascal: the reverse.  A handle
     of 1000h or more is a segment: its node offset is at +0Eh of the
     paragraph below, in bank 0.  A smaller handle indexes the 20-byte
     descriptors of bank 0 from 140h; byte +13h of the descriptor gives the
     bank (low 3 bits), whose offset is 40h less per bank.  Returns the bank
     (left in AX: documented fall-off-end) and stores the node offset.
   The register pseudo-variable reads are documented exceptions. */
#include <dos.h>
#include "CPPHEAP.H"

/* Call hook `operation' (0 allocate, 1 release, 2 write in, 3 read out) of
   bank `bank' with that bank in DS; see the notes above. */
unsigned int near cdecl RH_HEAP_DISPATCH(unsigned int bank,unsigned int operation,
    unsigned int first,unsigned int second)
{
    unsigned int result;
    unsigned int caller;
    result=0;
    /* Remember the caller's bank (FFh: the caller was in DGROUP). */
    caller=0xFF;
    _AX=_DS;
    asm cmp ax,DGROUP;
    asm je in_dgroup;
    caller=ACTIVE_HEAP.field4;
    asm mov ax,DGROUP;
    asm mov ds,ax;
in_dgroup:
    if(HEAP_DESCRIPTOR_SEGMENTS[bank]) {
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        switch(operation) {
        case 0: result=ACTIVE_HEAP.hook_22(first); goto restore;
        case 1: result=ACTIVE_HEAP.hook_24((HeapNode near *)first); goto restore;
        case 2: ACTIVE_HEAP.hook_28((HeapNode near *)first,second); break;
        case 3: ACTIVE_HEAP.hook_2a((HeapNode near *)first,second);
        }
        result=0;
    }
restore:
    asm mov ax,DGROUP;
    asm mov ds,ax;
    if(caller!=0xFF) _DS=HEAP_DESCRIPTOR_SEGMENTS[caller];
    return result;
}

/* Store node's current handle through its output pointer: its descriptor
   index when mode & 2, else its segment (key) plus the node offset at +0Eh
   of the paragraph below.  Callers pass 0, 1 or 4 for the segment form
   and 2 or 3 for the index form. */
void near pascal RH_UPDATE_NODE_ADDRESS(HeapNode near *node,unsigned char mode)
{
    if(mode&2)
    {
        _AX=(unsigned int)node;
        _BX=_AX;
        _AX-=ACTIVE_HEAP.field30;
        _CX=20;
        _AX/=_CX;
        *((struct HeapOutputNodeView near *)_BX)->output=_AX;
    }
    else {
        _CX=node->key;
        *((struct HeapOutputNodeView near *)node)->output=_CX;
        _ES=--_CX;
        _AX=(unsigned int)node;
        asm mov es:[0Eh],ax;
    }
}

/* Resolve a handle: store the node's offset (valid with DS = that bank's
   HEAP_DESCRIPTOR_SEGMENTS entry) through offset and return the bank. */
unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,unsigned int far *offset)
{
    if(handle>=0x1000) {
        _AX=handle-1;
        _ES=_AX;
        asm mov cx,es:[0Eh]
        asm mov ax,0
    } else {
        _AX=handle;
        _DX=20;
        asm mul dx
        _AX+=0x140;
        _BX=_AX;
        _ES=HEAP_DESCRIPTOR_SEGMENTS[0];
        asm mov al,es:[bx+13h]
        _AX&=7;
        _CX=_AX;
        _DX=0x40;
        asm mul dx
        _BX-=_AX;
        _AX=_BX;
        asm xchg cx,ax
    }
    *offset=_CX;
}
