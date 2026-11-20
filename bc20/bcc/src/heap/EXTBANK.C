/* target: CODE_2_RG2BMID */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: the extended-memory bank; read, write and move nodes and find free
   space there, and INIT_EXT_BANK sets the bank up. Entry points: EXT_READ_NODE,
   EXT_WRITE_NODE, EXT_MOVE_NODE, EXT_FIND_FREE_NODE, INIT_EXT_BANK. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: bank 4, the extended-memory bank (see HEAPMAIN.C's overview for
   banks, nodes and hooks).  INIT_EMS_EXT_BANKS (BANKINIT.C) calls INIT_EXT_BANK
   when the extended-memory limit allows it.  Blocks moved out of conventional
   memory are kept here; a key is a unit of field8 bytes from the bank's base,
   a linear address above 1M.  The overlay manager owns the access to
   extended memory: DETECT_EXTENDED_MEMORY, CLAIM_EXTENDED_MEMORY, the usable
   range OVR_EXT_MEMORY_START..OVR_EXT_MEMORY_END and the block move
   MOVE_EXTENDED_MEMORY, which the three transfer hooks call with register
   arguments. */
#include <dos.h>
#include "RHHEAP.H"
#include "RHHOOK.H"
#include "DATA.H"
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
   through the block move at 43AE (source DX:AX, destination CX:BX, as
   linear byte addresses; SI bytes; carry set on error): 3CEF reads the
   node's block into paragraph target, 3D35 writes it out from there, 3D7F
   moves the block to a new key.  The bank's base address is the long at
   ACTIVE_HEAP+30h (ExtControl.base; the asm reaches it through the
   page_segment/page_size words at the same offsets).  An error goes to the
   status hook (1, E020h). */
#define EXT_MOVE_ERROR \
    asm jae moved; \
    asm push ds; \
    asm .186; \
    asm push 1; \
    asm push 0E020h; \
    asm .8086; \
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS; \
    asm call dword ptr DGROUP:HEAP_HOOK_CALLSITE; \
    asm pop ds; \
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
    if((node=ACTIVE_HEAP.free_head->next_free)==ACTIVE_HEAP.free_head) return 0;
    if(node->next_free==ACTIVE_HEAP.free_head) {
        if(node->size>=size) return node;
        return 0;
    }
    return GATHER_FREE_AT_HIGH_END(size,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
}

/* Set up descriptor bank 4 over extended memory from base for size bytes,
   clipped to OVR_EXT_MEMORY_START..OVR_EXT_MEMORY_END.  The unit is 2 to the bit
   length of size>>16, the smallest power of two above size/64K, so that
   size/unit fits in 16 bits (size 10000h gives unit 2); INIT_BANK gets
   (0, size/unit, 4, unit-1, unit).  Returns the size used, or 0. */
long far pascal _loadds INIT_EXT_BANK(unsigned long base,unsigned long size)
{
    unsigned char tried;
    tried=0;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(RH_GROW_DESCRIPTORS(20)) return 0;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    if(!DETECT_EXTENDED_MEMORY()) return 0;
again:
    if(OVR_EXT_MEMORY_START>base) base=OVR_EXT_MEMORY_START;
    if(OVR_EXT_MEMORY_END<=base) return 0;
    if(!size || OVR_EXT_MEMORY_END-base<size) size=OVR_EXT_MEMORY_END-base;
    if(size<0x10000UL) return 0;
    /* Claim the range once, then clip again: the claim probably moves
       OVR_EXT_MEMORY_START or OVR_EXT_MEMORY_END. */
    if(tried==0) {
        if(CLAIM_EXTENDED_MEMORY(base,size)) return 0;
        tried++;
        goto again;
    }
    /* unit = smallest power of two above size>>16 (shift the high word left
       until a 1 falls out, rotating BX right each time it does not); then
       INIT_BANK(0, size/unit, 4, unit-1, unit). */
    asm mov ax,word ptr size;
    asm mov dx,word ptr size+2;
    asm mov cx,dx;
    asm mov bx,1;
    asm jmp short unit_test;
unit_shift:
    asm ror bx,1;
unit_test:
    asm shl cx,1;
    asm jae unit_shift;
    asm div bx;
    asm .186;
    asm push 0;
    asm push ax;
    asm push 4;
    asm dec bx;
    asm push bx;
    asm inc bx;
    asm push bx;
    asm .8086;
    asm call INIT_BANK;
    ((struct ExtControl near *)&ACTIVE_HEAP)->base=base;
    ACTIVE_HEAP.hook_28=EXT_WRITE_NODE;
    ACTIVE_HEAP.hook_2a=EXT_READ_NODE;
    ACTIVE_HEAP.move_node_2c=EXT_MOVE_NODE;
    ACTIVE_HEAP.hook_26=(HeapHook)EXT_FIND_FREE_NODE;
    return size;
}
