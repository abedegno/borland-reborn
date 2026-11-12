/* target: EMSINIT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module EMSINIT (image 0x2786..0x28A6, 0054:2246): INIT_EMS_BANK from the
   BCC.EXE reconstruction (bcc20/src/heap/EMSBANK.C), with CPP.EXE's
   edits marked "CPP.EXE edit".  Role: far-memory heap: sets up the EMS bank (bank 2 in
   CPP.EXE, BCC's 3) and installs its hooks.  Its only caller, INIT_EMS_EXT_BANKS
   (MEMINIT.C), has no known caller in CPP.EXE.  A file of its own, apart from the EMS transfers
   before it (EMSBANK.C).  RELEASE_EMS_BANK, which follows it in BCC's order, is a
   separate module (HPEMSREL.C, Borland C++ 2.0).
   Compiler: Turbo C 2.01 (like EMSBANK.C), not Borland C++ 2.0: sub sp,8 and the
   other Turbo C shapes: xor dx,dx; mov ax,dx for return 0L (image 2813; BC 2.0: xor
   ax,ax), and jmp short + nop at image 27A6 (TASM's single pass over a forward jmp
   that the compiler wrote without "short"; the Turbo C build gives it too).
   Turbo C 2.01 has no _loadds: the function is huge (no register variables), which
   gives _loadds's prologue (push bp; mov bp,sp; sub sp,8; push ds; mov ax,DGROUP;
   mov ds,ax) and pop ds before the return.
   CRLF line ends, for CPPHEAP.H.  "image" marks a CPP.EXE image offset, 0054:xxxx a
   CPP.EXE address in the heap frame. */
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
extern void near pascal EMS_READ_NODE(HeapNode near *node,unsigned int target);
extern void near pascal EMS_WRITE_NODE(HeapNode near *node,unsigned int source);
extern void near pascal EMS_MOVE_NODE(HeapNode near *node,unsigned int key);
extern HeapNode near * near pascal EMS_FIND_FREE_NODE(unsigned int size);
/* EMS bank fields (INIT_EMS_BANK). */
struct EmsControl {
    unsigned char preceding_fields[0x30];
    unsigned int field30;       /* +30h: set to FFFFh, no reader seen */
    unsigned int handle;        /* +32h: EMS handle */
    unsigned int frame;         /* +34h: page frame segment */
    unsigned int frame_size;    /* +36h: 400h paragraphs (16K): physical page 1 of the frame */
    unsigned long start;        /* +38h: first byte within the handle */
};

/* Set up descriptor bank 2 over EMS.  With handle 0, EMS is detected
   (DETECT_EMS) and pages from first are allocated (ALLOCATE_EMS_PAGES),
   clipped to OVR_EMS_PAGE_COUNT.  With any other handle the argument is not
   stored or checked: the bank uses whatever OVR_EMS_HANDLE already holds.
   At least 4 pages.  The unit is computed as in EXTBANK (smallest power of
   two above size/64K); INIT_BANK gets (0, size/unit, 2, unit-1, unit).
   Returns the bytes used, or 0. */
/* CPP.EXE edit: huge for BCC's _loadds (Turbo C 2.01: see the top of the file). */
long huge pascal INIT_EMS_BANK(unsigned int handle,unsigned int first,
    unsigned int pages)
{
    unsigned long start;
    unsigned long size;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    /* CPP.EXE edit: every failure goes to one return 0 (0054:22D3: xor dx,dx;
       mov ax,dx), where BCC repeats it. */
    if(RH_GROW_DESCRIPTORS(20)) goto fail;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    if(handle==0) {
        if(!DETECT_EMS()) goto fail;
        if(OVR_EMS_PAGE_COUNT<=first) goto fail;
        if(!pages || OVR_EMS_PAGE_COUNT-first<pages) pages=OVR_EMS_PAGE_COUNT-first;
        if(pages<4) goto fail;
        /* CPP.EXE edit: an empty then-branch (image 2805: or ax,ax; je 281Ah;
           jmp short 2813h; jmp short 281Ah, where the plain if(...) goto fail
           gives jne 2813h; jmp short 281Ah).  Odd but plausible code. */
        if(ALLOCATE_EMS_PAGES(handle,first,pages)==0) ; else goto fail;
    } else if(pages<4) {
fail:
        return 0L;
    }
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
    asm mov ax,2;      /* CPP.EXE edit: the EMS bank is bank 2 (0054:2305), BCC's 3 */
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
