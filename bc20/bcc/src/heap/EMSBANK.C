/* target: CODE_2_RG2BEND */
/* opts: -mm -G -O -Z -p -r- -B */
/* Role: far-memory heap: the EMS bank; read, write and move nodes and find free space in
   EMS pages, INIT_EMS_BANK, and the empty null bank. Entry points: INIT_NULL_BANK,
   CALL_SELF_FOREVER_RG2BEND, EMS_READ_NODE, EMS_WRITE_NODE, EMS_MOVE_NODE,
   EMS_FIND_FREE_NODE, INIT_EMS_BANK. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: bank 3, the EMS bank, and bank 5, the null bank (see HEAPMAIN.C's
   overview for banks, nodes and hooks).  INIT_EMS_EXT_BANKS (BANKINIT.C) calls
   INIT_EMS_BANK when the EMS page limit allows it; INIT_HEAP (RHINIT.C) calls
   INIT_NULL_BANK.
   The EMS bank holds blocks moved out of conventional memory.  Its keys are
   units of field8 bytes counted from start, a byte offset within the EMS
   handle's pages.  Its record has extra fields (struct EmsControl): the EMS
   handle at +32h, the page-frame segment at +34h, 400h at +36h (the paragraph
   offset of physical page 1) and start at +38h; the asm reads them as
   ACTIVE_HEAP+32h and so on.  Transfers map one 16K logical page at a time
   into the page frame (int 67h AX=4400h) and copy with rep movsw, saving and
   restoring the page map (AH=47h/48h), probably so the overlay manager, which shares
   the frame, finds its own mapping intact.  The handle and frame come from
   the overlay manager (OVR_EMS_HANDLE, OVR_EMS_FRAME_SEG).
   Bank 5 has no memory: it only keeps the descriptors of discarded blocks,
   so its allocate hook (NEW_BANK5_NODE) makes a bare node and its move hooks
   do nothing. */
#include <dos.h>
#include "RHHEAP.H"
#include "RHHOOK.H"
#include "DATA.H"
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned int far OVR_EMS_FRAME_SEG;
extern unsigned int far OVR_EMS_HANDLE;
extern unsigned int far OVR_EMS_PAGE_COUNT;
extern unsigned int near pascal RH_GROW_DESCRIPTORS(unsigned int count);
extern unsigned int far pascal DETECT_EMS(void);
extern unsigned int far pascal ALLOCATE_EMS_PAGES(unsigned int handle,unsigned int first,
    unsigned int pages);
extern void near pascal INIT_BANK(unsigned int first_key,unsigned int size,
    int bank,unsigned int field6,unsigned int field8);
extern HeapNode near * near pascal NEW_BANK5_NODE(unsigned int request);
extern unsigned int near pascal BCC_RESIDENT_RELEASE_CALLBACK(HeapNode near *node);
extern void near pascal BANK5_NOOP_NODE_HOOK(HeapNode near *node,unsigned int value);
extern void near pascal BANK5_NOOP_REQUEST_HOOK(unsigned int request);
extern HeapNode near * near pascal GATHER_FREE_AT_HIGH_END(unsigned int needed,
    HeapNode near *stop,HeapNode near *start);
/* EMS bank fields (INIT_EMS_BANK). */
struct EmsControl {
    unsigned char preceding_fields[0x30];
    unsigned int field30;       /* +30h: set to FFFFh, no reader seen */
    unsigned int handle;        /* +32h: EMS handle */
    unsigned int frame;         /* +34h: page frame segment */
    unsigned int frame_size;    /* +36h: 400h paragraphs (16K): physical page 1 of the frame */
    unsigned long start;        /* +38h: first byte within the handle */
};

/* Bank 5: an empty range (INIT_BANK with size 0) and no-op move hooks. */
unsigned int near pascal INIT_NULL_BANK(void)
{
    asm push ds;
    INIT_BANK(0,0,5,0,0);
    ACTIVE_HEAP.hook_22=(HeapWordHook)NEW_BANK5_NODE;
    ACTIVE_HEAP.hook_24=BCC_RESIDENT_RELEASE_CALLBACK;
    ACTIVE_HEAP.hook_28=BANK5_NOOP_NODE_HOOK;
    ACTIVE_HEAP.hook_2a=BANK5_NOOP_NODE_HOOK;
    ACTIVE_HEAP.move_node_2c=BANK5_NOOP_NODE_HOOK;
    ACTIVE_HEAP.hook_26=(HeapHook)BANK5_NOOP_REQUEST_HOOK;
    asm pop ds;
    return 0;
}

/* Calls itself; nothing references it (RH_SELF_CALL_AFTER_EMS_BANK has the same pattern). */
void near pascal CALL_SELF_FOREVER_RG2BEND(void)
{
    CALL_SELF_FOREVER_RG2BEND();
}

/* EMS transfers through the page frame, 16K pages.  3955 copies the
   node's block from EMS to paragraph target, saving and restoring the page
   map (int 67h AH=47h/48h).  3A04 copies from source to EMS through the
   same code: it sets its own to_ems byte and calls ems_copy (3961), whose
   pop ax discards 3A04's return address, so the code finishes in 3955's
   epilogue and returns straight to 3A04's caller (on 3955's own path the
   push ax before it balances that pop).  This needs both frames laid out
   alike (to_ems at bp-1, SI and DI saved); 3A04's mov si,2 / mov di,2 and
   its epilogue are dead code.  3A20 moves a block within EMS to a new key
   (source mapped to pages 1-3, copied from frame+400h) without saving the
   map; 3B23 saves it around its search.  An EMS error goes to the status
   hook (1, E010h). */
void near pascal EMS_READ_NODE(HeapNode near *node,unsigned int target)
{
    unsigned char to_ems;
    to_ems=0;
    asm push ax;
    asm ems_copy label near;
    asm pop ax;
    asm mov di,node;
    asm mov dx,word ptr DGROUP:ACTIVE_HEAP+32h;
    asm mov ah,47h;
    asm int 67h;
    asm shl ah,1;
    asm jb ems_error;
    /* Byte address within the handle = key * unit + start; split into the
       logical page (BX) and the word offset in it (SI); DX = words to copy,
       (field8 + 1) / 2.  Each round maps page BX at physical page 0 and
       copies up to the end of that page. */
    asm mov ax,[di];
    asm mul word ptr DGROUP:ACTIVE_HEAP.field8;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP+38h;
    asm adc dx,word ptr DGROUP:ACTIVE_HEAP+3Ah;
    asm mov bx,4000h;
    asm div bx;
    asm mov bx,ax;
    asm mov si,dx;
    asm shr si,1;
    asm mov dx,[di+8];
    asm add dx,1;
    asm rcr dx,1;
    asm xor di,di;
next_page:
    asm mov cx,2000h;
    asm sub cx,si;
    asm cmp cx,dx;
    asm jb whole;
    asm mov cx,dx;
whole:
    asm sub dx,cx;
    asm push dx;
    asm mov dx,word ptr DGROUP:ACTIVE_HEAP+32h;
    asm mov ax,4400h;
    asm int 67h;
    asm pop dx;
    asm shl ah,1;
    asm jb restore;
    asm shl si,1;
    asm push ds;
    asm push bx;
    asm mov ax,target;
    asm mov bx,word ptr DGROUP:ACTIVE_HEAP+34h;
    asm cmp byte ptr to_ems,0;
    asm je copy_from;
    asm xchg bx,ax;
    asm xchg si,di;
copy_from:
    asm mov es,ax;
    asm mov ds,bx;
    asm pop bx;
    asm cld;
    asm rep movsw;
    asm pop ds;
    asm inc bx;
    asm cmp byte ptr to_ems,0;
    asm je copied;
    asm xchg si,di;
copied:
    asm xor si,si;
    asm or dx,dx;
    asm jne next_page;
    asm clc;
restore:
    asm pushf;
    asm mov dx,word ptr DGROUP:ACTIVE_HEAP+32h;
    asm mov ah,48h;
    asm int 67h;
    asm popf;
    asm jae done;
ems_error:
    asm push ds;
    asm mov ax,1;
    asm push ax;
    asm mov ax,0E010h;
    asm push ax;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm call dword ptr DGROUP:HEAP_HOOK_CALLSITE;
    asm pop ds;
done: ;
}

/* The EMS bank's hook_28: copy a block from paragraph source into EMS at
   the node's key, through EMS_READ_NODE's code (see above). */
void near pascal EMS_WRITE_NODE(HeapNode near *node,unsigned int source)
{
    unsigned char to_ems;
    to_ems=1;
    asm mov si,2;
    asm mov di,2;
    asm call ems_copy;
}

/* The EMS bank's move_node_2c: move a block within EMS to key (see above). */
void near pascal EMS_MOVE_NODE(HeapNode near *node,unsigned int key)
{
    unsigned int remaining;
    /* Destination page and word offset are pushed for the copy loop.  Each
       round maps up to three source pages at physical pages 1 to 3 (AX =
       4401h, 4402h, 4403h), advances node->key past the part mapped, then
       copies it from frame+400h into destination pages mapped one at a
       time at physical page 0.  The page map is not saved here (callers
       such as EMS_FIND_FREE_NODE save it).  node->key is set to key at the
       end. */
    remaining=node->field8;
    asm mov ax,key;
    asm mul word ptr DGROUP:ACTIVE_HEAP.field8;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP+38h;
    asm adc dx,word ptr DGROUP:ACTIVE_HEAP+3Ah;
    asm mov bx,4000h;
    asm div bx;
    asm push ax;
    asm shr dx,1;
    asm push dx;
move_again:
    asm mov si,node;
    asm mov ax,[si];
    asm mul word ptr DGROUP:ACTIVE_HEAP.field8;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP+38h;
    asm adc dx,word ptr DGROUP:ACTIVE_HEAP+3Ah;
    asm mov bx,4000h;
    asm div bx;
    asm mov bx,ax;
    asm push dx;
    asm mov di,dx;
    asm shr di,1;
    asm mov dx,remaining;
    asm add dx,1;
    asm rcr dx,1;
    asm mov ax,4401h;
    asm xor si,si;
map_source:
    asm push ax;
    asm push dx;
    asm mov dx,word ptr DGROUP:ACTIVE_HEAP+32h;
    asm int 67h;
    asm pop dx;
    asm shl ah,1;
    asm jb move_error;
    asm mov cx,2000h;
    asm sub cx,di;
    asm cmp cx,dx;
    asm jb source_page;
    asm mov cx,dx;
source_page:
    asm add si,cx;
    asm inc bx;
    asm xor di,di;
    asm sub dx,cx;
    asm pop ax;
    asm je mapped;
    asm inc al;
    asm cmp al,4;
    asm jb map_source;
mapped:
    asm shl dx,1;
    asm mov remaining,dx;
    asm mov dx,si;
    asm shl si,1;
    asm mov ax,si;
    asm mov si,node;
    asm push dx;
    asm xor dx,dx;
    asm div word ptr DGROUP:ACTIVE_HEAP.field8;
    asm add [si],ax;
    asm pop dx;
    asm pop si;
    asm pop di;
    asm pop bx;
move_page:
    asm mov cx,2000h;
    asm sub cx,di;
    asm cmp cx,dx;
    asm jb target_page;
    asm mov cx,dx;
target_page:
    asm sub dx,cx;
    asm push dx;
    asm mov dx,word ptr DGROUP:ACTIVE_HEAP+32h;
    asm mov ax,4400h;
    asm int 67h;
    asm pop dx;
    asm shl ah,1;
    asm jb move_error;
    asm shl di,1;
    asm push ds;
    asm mov ax,word ptr DGROUP:ACTIVE_HEAP+34h;
    asm mov es,ax;
    asm add ax,word ptr DGROUP:ACTIVE_HEAP+36h;
    asm mov ds,ax;
    asm cld;
    asm rep movsw;
    asm pop ds;
    asm cmp di,4000h;
    asm jne same_page;
    asm inc bx;
    asm xor di,di;
same_page:
    asm or dx,dx;
    asm jne move_page;
    asm cmp remaining,0;
    asm je moved;
    asm push bx;
    asm shr di,1;
    asm push di;
    asm jmp move_again;
move_error:
    asm add sp,8;
    asm push ds;
    asm mov ax,1;
    asm push ax;
    asm mov ax,0E010h;
    asm push ax;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm call dword ptr DGROUP:HEAP_HOOK_CALLSITE;
    asm pop ds;
moved:
    node->key=key;
}

/* The EMS bank's hook_26, as CONV_FIND_FREE_NODE in HEAPMAIN.C: no free node
   gives 0, one free node is returned when big enough, otherwise the bank is
   compacted (GATHER_FREE_AT_HIGH_END), with the page map saved around the
   moves.  An EMS error goes to the status hook (1, E010h). */
HeapNode near * near pascal EMS_FIND_FREE_NODE(unsigned int size)
{
    HeapNode near *node;
    if((node=ACTIVE_HEAP.free_head->next_free)==ACTIVE_HEAP.free_head) return 0;
    if(node->next_free==ACTIVE_HEAP.free_head) {
        if(node->size>=size) goto done;
        return 0;
    }
    asm mov es,word ptr DGROUP:ACTIVE_HEAP.program_segment;
    asm mov dx,word ptr DGROUP:ACTIVE_HEAP+32h;
    asm mov ah,47h;
    asm int 67h;
    asm shl ah,1;
    asm jb map_error;
    node=GATHER_FREE_AT_HIGH_END(size,ACTIVE_HEAP.head,ACTIVE_HEAP.end);
    asm mov dx,word ptr DGROUP:ACTIVE_HEAP+32h;
    asm mov ah,48h;
    asm int 67h;
    asm shl ah,1;
    asm jae done;
map_error:
    asm push ds;
    asm mov ax,1;
    asm push ax;
    asm mov ax,0E010h;
    asm push ax;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm call dword ptr DGROUP:HEAP_HOOK_CALLSITE;
    asm pop ds;
done:
    return node;
}

/* Set up descriptor bank 3 over EMS.  With handle 0, EMS is detected
   (DETECT_EMS) and pages from first are allocated (ALLOCATE_EMS_PAGES),
   clipped to OVR_EMS_PAGE_COUNT.  With any other handle the argument is not
   stored or checked: the bank uses whatever OVR_EMS_HANDLE already holds.
   At least 4 pages.  The unit is computed as in EXTBANK (smallest power of
   two above size/64K); INIT_BANK gets (0, size/unit, 3, unit-1, unit).
   Returns the bytes used, or 0. */
long far pascal _loadds INIT_EMS_BANK(unsigned int handle,unsigned int first,
    unsigned int pages)
{
    unsigned long start;
    unsigned long size;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    if(RH_GROW_DESCRIPTORS(20)) return 0;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    if(handle==0) {
        if(!DETECT_EMS()) return 0;
        if(OVR_EMS_PAGE_COUNT<=first) return 0;
        if(!pages || OVR_EMS_PAGE_COUNT-first<pages) pages=OVR_EMS_PAGE_COUNT-first;
        if(pages<4) return 0;
        if(ALLOCATE_EMS_PAGES(handle,first,pages)) return 0;
    } else if(pages<4) return 0;
    asm mov ax,4000h;
    asm mul first;
    asm mov word ptr start,ax;
    asm mov word ptr start+2,dx;
    asm mov ax,4000h;
    asm mul pages;
    asm mov word ptr size,ax;
    asm mov word ptr size+2,dx;
    asm mov cx,dx;
    asm mov bx,1;
    asm jmp short unit_test;
unit_shift:
    asm ror bx,1;
unit_test:
    asm shl cx,1;
    asm jae unit_shift;
    asm div bx;
    asm xor cx,cx;
    asm push cx;
    asm push ax;
    asm mov ax,3;
    asm push ax;
    asm dec bx;
    asm push bx;
    asm inc bx;
    asm push bx;
    asm call INIT_BANK;
    ((struct EmsControl near *)&ACTIVE_HEAP)->handle=OVR_EMS_HANDLE;
    ((struct EmsControl near *)&ACTIVE_HEAP)->frame=OVR_EMS_FRAME_SEG;
    ((struct EmsControl near *)&ACTIVE_HEAP)->start=start;
    ((struct EmsControl near *)&ACTIVE_HEAP)->field30=0xffff;
    ((struct EmsControl near *)&ACTIVE_HEAP)->frame_size=0x400;
    ACTIVE_HEAP.hook_28=EMS_WRITE_NODE;
    ACTIVE_HEAP.hook_2a=EMS_READ_NODE;
    ACTIVE_HEAP.move_node_2c=EMS_MOVE_NODE;
    ACTIVE_HEAP.hook_26=(HeapHook)EMS_FIND_FREE_NODE;
    return size;
}
