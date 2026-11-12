/* target: CODE_2_RG2B */
/* opts: -mm -G -O -Z -p -r- -a */
/* Role: far-memory heap: RH_HEAP_DISPATCH calls a bank's operation, RH_UPDATE_NODE_ADDRESS
   reports a node's address, BCC_POOL_RESOLVE_WORD finds a handle's node and bank. Entry
   points: RH_HEAP_DISPATCH, RH_UPDATE_NODE_ADDRESS, BCC_POOL_RESOLVE_WORD. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: the three low-level links between handles, nodes and banks (see
   HEAPMAIN.C's overview), used all over the heap.  A handle word is either a
   block's segment (bank 0, block in conventional memory) or a descriptor
   index (any bank).  RH_UPDATE_NODE_ADDRESS writes a node's current handle
   into the owner's word; BCC_POOL_RESOLVE_WORD reads a handle back into a
   bank number and a node offset valid in that bank's DS; RH_HEAP_DISPATCH
   calls a hook of another bank and returns to the caller's bank.  The
   detailed notes follow. */
/* CODE_2:2DDE..2F09: three small heap helpers, BC 2.0 C with register
   pseudo-variables and inline asm (written in the run-time's .CAS style).
   -a word-aligns the dispatcher's jump table with a 0 byte, as the original.
   RH_HEAP_DISPATCH(bank, operation, first, second), cdecl: calls one of the
     hooks of descriptor bank `bank' (0: +22h, 1: +24h, which takes a node,
     2 and 3: the (node, key) hooks +28h and +2Ah) with that bank in DS, and
     returns the hook's result for 0 and 1, else 0.  A bank whose segment is
     0 returns 0 without calling anything.  DS is put back to the caller's
     bank (ACTIVE_HEAP.field4 at entry) or left at DGROUP.  Cases 2 and 3 set
     result=0 themselves; BCC tail-merges those stores into the original's
     jumps.  FP_SEG(&SWAP_GROW_FILE_ALLOWED) is DGROUP as an immediate.
   RH_UPDATE_NODE_ADDRESS(node, mode), pascal: stores the node's handle at
     its output pointer: with mode & 2 the descriptor index
     (node - ACTIVE_HEAP.field30) / 22, else the node's segment (its key),
     and then the node's offset at +0Eh of the paragraph below that segment.
   BCC_POOL_RESOLVE_WORD(handle, far *offset), pascal: the reverse.  A handle
     of 1000h or more is a segment: its node offset is at +0Eh of the
     paragraph below, in bank 0.  A smaller handle indexes the 22-byte
     descriptors of bank 0 from 1E0h; byte +13h of the descriptor gives the
     bank (low 3 bits), whose offset is 50h less per bank.  Returns the bank
     (left in AX: documented fall-off-end) and stores the node offset.
   The register pseudo-variable reads are documented exceptions. */
#include <dos.h>
#include "RHHEAP.H"
#include "RHOUT.H"
#include "DATA.H"
extern unsigned char far SWAP_GROW_FILE_ALLOWED;

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
    if((_AX=_DS)!=FP_SEG(&SWAP_GROW_FILE_ALLOWED)) {
        caller=ACTIVE_HEAP.field4;
        _DS=FP_SEG(&SWAP_GROW_FILE_ALLOWED);
    }
    if(HEAP_DESCRIPTOR_SEGMENTS[bank]) {
        _DS=HEAP_DESCRIPTOR_SEGMENTS[bank];
        switch(operation) {
        case 0: result=ACTIVE_HEAP.hook_22(first); goto restore;
        case 1: result=ACTIVE_HEAP.hook_24((HeapNode near *)first); goto restore;
        case 2: ACTIVE_HEAP.hook_28((HeapNode near *)first,second); result=0; goto restore;
        case 3: ACTIVE_HEAP.hook_2a((HeapNode near *)first,second); result=0; goto restore;
        }
        result=0;
    }
restore:
    _DS=FP_SEG(&SWAP_GROW_FILE_ALLOWED);
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
        _CX=22;
        _AX/=_CX;
        *((struct HeapOutputNodeView near *)_BX)->output=_AX;
    }
    else {
        *((struct HeapOutputNodeView near *)node)->output=node->key;
        _CX=_AX;
        _ES=--_CX;
        *(unsigned int far *)MK_FP(_ES,0x0E)=(unsigned int)node;
    }
}

/* Resolve a handle: store the node's offset (valid with DS = that bank's
   HEAP_DESCRIPTOR_SEGMENTS entry) through offset and return the bank. */
unsigned int near pascal BCC_POOL_RESOLVE_WORD(unsigned int handle,unsigned int far *offset)
{
    if(handle>=0x1000) {
        _CX=*(unsigned int far *)MK_FP(handle-1,0x0E);
        asm mov ax,0
    } else {
        _AX=handle;
        _DX=22;
        asm mul dx
        _AX+=0x1E0;
        _BX=_AX;
        _ES=HEAP_DESCRIPTOR_SEGMENTS[0];
        asm mov al,es:[bx+13h]
        _AX&=7;
        _CX=_AX;
        _DX=0x50;
        asm mul dx
        _BX-=_AX;
        _AX=_BX;
        asm xchg cx,ax
    }
    *offset=_CX;
}
