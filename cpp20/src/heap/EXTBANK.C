/* target: EXTBANK */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module EXTBANK (0054:2375..0054:2463, image 0x28B5..0x29A3): source taken
   from the BCC.EXE reconstruction (bcc20/src/heap/EXTBANK.C), with
   CPP.EXE's edits marked "CPP.EXE edit".  CPP.EXE has only the four transfer functions
   of that file, in the same order; INIT_EXT_BANK is in EXTINIT.C and
   RH_CALL_EXT_RELEASE in HPEXTREL.C, files of their own.  These four are Turbo C 2.01
   code, compiled through TASM (-B) like HEAPMAIN.C; see CPPHEAP.H.  CRLF line ends. */
/* Role: far-memory heap: the extended-memory bank's hooks; read, write and move nodes
   and find free space there. Entry points: EXT_READ_NODE, EXT_WRITE_NODE,
   EXT_MOVE_NODE, EXT_FIND_FREE_NODE (installed as hooks by INIT_EXT_BANK). */
/* Overview: bank 3, the extended-memory bank (BCC.EXE's bank 4; see HEAPMAIN.C's
   overview for banks, nodes and hooks).  INIT_EXT_BANK (EXTINIT.C) installs these
   hooks.  In BCC.EXE INIT_EMS_EXT_BANKS calls it; in CPP.EXE that function is reduced
   to its EMS half (MEMINIT.C) and no caller of INIT_EXT_BANK is known, so this bank is
   probably never set up.  Blocks moved out of conventional
   memory are kept here; a key is a unit of field8 bytes from the bank's base,
   a linear address above 1M.  The access to extended memory is BCC's overlay
   manager code, which CPP.EXE keeps in OVREXMEM.ASM: DETECT_EXTENDED_MEMORY,
   CLAIM_EXTENDED_MEMORY, the usable range OVR_EXT_MEMORY_START..OVR_EXT_MEMORY_END
   and the block move MOVE_EXTENDED_MEMORY, which the three transfer hooks call with
   register arguments. */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned long far OVR_EXT_MEMORY_START;
extern unsigned long far OVR_EXT_MEMORY_END;
extern unsigned int near pascal RH_GROW_DESCRIPTORS(unsigned int count);
extern unsigned long far pascal DETECT_EXTENDED_MEMORY(void);
extern unsigned int far pascal CLAIM_EXTENDED_MEMORY(unsigned long base,unsigned long size);
extern void near pascal INIT_BANK(unsigned int first_key,unsigned int size,
    int bank,unsigned int field6,unsigned int field8);
extern void near MOVE_EXTENDED_MEMORY(void);
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);
/* The extended-memory bank keeps its base address at +30h. */
struct ExtControl {
    unsigned char preceding_fields[0x30];
    unsigned long base;
};

/* Transfers between conventional memory and the extended-memory bank
   through the block move MOVE_EXTENDED_MEMORY (OVREXMEM.ASM; source DX:AX,
   destination CX:BX, as linear byte addresses; SI bytes; carry set on
   error): EXT_READ_NODE reads the node's block into paragraph target,
   EXT_WRITE_NODE writes it out from there, EXT_MOVE_NODE moves the block to
   a new key.  The bank's base address is the long at ACTIVE_HEAP+30h
   (ExtControl.base; the asm reaches it through the page_segment/page_size
   words at the same offsets).  In BCC.EXE an error goes to the status hook
   (1, E020h). */
/* CPP.EXE edit: no call of the status hook when the move fails; only the jae over
   it is left (0054:23A1: jae to the next instruction). */
#define EXT_MOVE_ERROR \
    asm jae moved; \
moved:

/* hook_2a: copy the node's block from extended memory to paragraph target. */
void near pascal EXT_READ_NODE(HeapNode near *node,unsigned int target)
{
    asm push si;
    asm push di;
    asm mov ax,target;
    asm mov dx,10h;
    asm mul dx;
    asm mov cx,dx;
    asm mov bx,ax;
    asm mov di,node;
    asm mov ax,[di];
    asm mul word ptr DGROUP:ACTIVE_HEAP.field8;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP.page_segment;
    asm adc dx,word ptr DGROUP:ACTIVE_HEAP.page_size;
    asm mov si,[di+8];
    asm xor di,di;
    asm call MOVE_EXTENDED_MEMORY;
    EXT_MOVE_ERROR
    asm pop di;
    asm pop si;
}

/* hook_28: copy a block from paragraph source to the node's place in
   extended memory. */
void near pascal EXT_WRITE_NODE(HeapNode near *node,unsigned int source)
{
    asm push si;
    asm push di;
    asm mov ax,source;
    asm mov dx,10h;
    asm mul dx;
    asm mov di,node;
    asm push dx;
    asm push ax;
    asm mov ax,[di];
    asm mul word ptr DGROUP:ACTIVE_HEAP.field8;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP.page_segment;
    asm adc dx,word ptr DGROUP:ACTIVE_HEAP.page_size;
    asm mov bx,ax;
    asm mov cx,dx;
    asm pop ax;
    asm pop dx;
    asm mov si,[di+8];
    asm xor di,di;
    asm call MOVE_EXTENDED_MEMORY;
    EXT_MOVE_ERROR
    asm pop di;
    asm pop si;
}

/* move_node_2c: move the node's block within extended memory to key. */
void near pascal EXT_MOVE_NODE(HeapNode near *node,unsigned int key)
{
    asm push si;
    asm push di;
    asm mov ax,key;
    asm mul word ptr DGROUP:ACTIVE_HEAP.field8;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP.page_segment;
    asm adc dx,word ptr DGROUP:ACTIVE_HEAP.page_size;
    asm mov bx,ax;
    asm mov cx,dx;
    asm mov di,node;
    asm mov ax,[di];
    asm mul word ptr DGROUP:ACTIVE_HEAP.field8;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP.page_segment;
    asm adc dx,word ptr DGROUP:ACTIVE_HEAP.page_size;
    asm mov si,[di+8];
    asm xor di,di;
    asm call MOVE_EXTENDED_MEMORY;
    EXT_MOVE_ERROR
    asm pop di;
    asm pop si;
    node->key=key;
}

/* The bank's hook_26, as CONV_FIND_FREE_NODE in HEAPMAIN.C: no free node
   gives 0, one free node is returned when big enough, otherwise the bank is
   compacted to gather free space at its high end. */
HeapNode near * near pascal EXT_FIND_FREE_NODE(unsigned int size)
{
    HeapNode near *node;
    /* CPP.EXE edit: the assignment is a statement of its own (0054:2432: the compare
       is on SI, not on a copy in AX). */
    node=ACTIVE_HEAP.free_head->next_free;
    if(node==ACTIVE_HEAP.free_head) return 0;
    if(node->next_free==ACTIVE_HEAP.free_head) {
        if(node->size>=size) return node;
        return 0;
    }
    return GATHER_FREE_AT_HIGH_END(size,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
}

