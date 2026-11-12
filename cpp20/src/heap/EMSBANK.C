/* target: EMSBANK */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module EMSBANK (0054:204A..0054:2246, image 0x258A..0x2786): source taken
   from the BCC.EXE reconstruction (bcc20/src/heap/EMSBANK.C), with
   CPP.EXE's edits marked "CPP.EXE edit".  CPP.EXE has only the four EMS transfer
   functions of that file, in the same order.  The rest of BCC's file is elsewhere here:
   INIT_NULL_BANK in RNOOPS.C, the empty stub CALL_SELF_FOREVER_RG2BEND in HPSTUBEB.C,
   and INIT_EMS_BANK in EMSINIT.C (a file of its own).  The four are Turbo C 2.01 code
   through TASM (-B), as HEAPMAIN.C (see CPPHEAP.H): sub sp,2 for the one-byte local
   (BC 2.0 writes dec sp; dec sp), and register variables on (SI in
   EMS_FIND_FREE_NODE), so no -r-.  CRLF line ends. */
/* Role: far-memory heap: the EMS bank's hooks; read, write and move nodes and find free
   space in EMS pages. Entry points: EMS_READ_NODE, EMS_WRITE_NODE, EMS_MOVE_NODE,
   EMS_FIND_FREE_NODE (installed as hooks by INIT_EMS_BANK). */
/* Overview: bank 2, the EMS bank (BCC.EXE's bank 3; see HEAPMAIN.C's overview for
   banks, nodes and hooks).  INIT_EMS_BANK (EMSINIT.C) installs these four functions
   as the bank's hooks.  Its only caller is INIT_EMS_EXT_BANKS (MEMINIT.C), which is
   static there and has no known caller in CPP.EXE, so the EMS bank is probably never
   set up in CPP.EXE.
   The EMS bank holds blocks moved out of conventional memory.  Its keys are
   units of field8 bytes counted from start, a byte offset within the EMS
   handle's pages.  Its record has extra fields (struct EmsControl): the EMS
   handle at +32h, the page-frame segment at +34h, 400h at +36h (the paragraph
   offset of physical page 1) and start at +38h; the asm reads them as
   ACTIVE_HEAP+32h and so on.  Transfers map one 16K logical page at a time
   into the page frame (int 67h AX=4400h) and copy with rep movsw, saving and
   restoring the page map (AH=47h/48h).  In BCC.EXE that probably keeps the
   overlay manager's own mapping of the shared frame intact; CPP.EXE has no
   overlay manager.  The handle and frame words (OVR_EMS_HANDLE,
   OVR_EMS_FRAME_SEG) are those of BCC's overlay EMS code, which CPP.EXE keeps in
   OVREXMEM.ASM.  CPP.EXE edit: an EMS error does not reach the status hook; the
   transfer just stops. */
#include <dos.h>
#include "CPPHEAP.H"
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



/* EMS transfers through the page frame, 16K pages.  EMS_READ_NODE copies
   the node's block from EMS to paragraph target, saving and restoring the
   page map (int 67h AH=47h/48h).  EMS_WRITE_NODE copies from source to EMS
   through the same code: it sets its own to_ems byte and calls the label
   ems_copy, whose pop ax discards EMS_WRITE_NODE's return address, so the
   code finishes in EMS_READ_NODE's epilogue and returns straight to
   EMS_WRITE_NODE's caller (on EMS_READ_NODE's own path the push ax before it
   balances that pop).  This needs both frames laid out alike (to_ems at
   bp-1, SI and DI saved); EMS_WRITE_NODE's own epilogue is dead code.
   EMS_MOVE_NODE moves a block within EMS to a new key (source mapped to
   pages 1-3, copied from frame+400h) without saving the map;
   EMS_FIND_FREE_NODE saves it around its search.  In BCC.EXE an EMS error
   goes to the status hook (1, E010h); CPP.EXE edit: not here. */
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
/* CPP.EXE edit: no call of the status hook on an EMS error; the error path ends
   here like the good one (0054:20DD: jae to the next instruction). */
ems_error:
done: ;
}

/* The EMS bank's hook_28: copy a block from paragraph source into EMS at
   the node's key, through EMS_READ_NODE's code (see above). */
void near pascal EMS_WRITE_NODE(HeapNode near *node,unsigned int source)
{
    unsigned char to_ems;
    register int keep_si,keep_di;   /* never used: they make SI and DI saved, see below */
    to_ems=1;
    /* CPP.EXE edit: BCC's dead mov si,2 / mov di,2 are not here (0054:20EF..20F3),
       yet SI and DI are still pushed (0054:20ED), which ems_copy's shared epilogue
       needs.  The two unused register variables above give that push; how the
       original got it is not known. */
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
/* CPP.EXE edit: no call of the status hook on an EMS error (0054:21DC). */
move_error:
    asm add sp,8;
moved:
    node->key=key;
}

/* The EMS bank's hook_26, as CONV_FIND_FREE_NODE in HEAPMAIN.C: no free node
   gives 0, one free node is returned when big enough, otherwise the bank is
   compacted (GATHER_FREE_AT_HIGH_END), with the page map saved around the
   moves.  In BCC.EXE an EMS error goes to the status hook (1, E010h); not
   in CPP.EXE (below). */
HeapNode near * near pascal EMS_FIND_FREE_NODE(unsigned int size)
{
    HeapNode near *node;
    /* CPP.EXE edit: the assignment is a statement of its own (the compare
       is on SI, not on a copy in AX; 0054:21F7). */
    node=ACTIVE_HEAP.free_head->next_free;
    if(node==ACTIVE_HEAP.free_head) return 0;
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
/* CPP.EXE edit: no call of the status hook on an EMS error (0054:223D). */
map_error:
done:
    return node;
}
