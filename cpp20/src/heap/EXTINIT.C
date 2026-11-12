/* target: EXTINIT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module EXTINIT (image 0x29A3..0x2AF4, 0054:2463): INIT_EXT_BANK from the
   BCC.EXE reconstruction (bcc20/src/heap/EXTBANK.C), with CPP.EXE's
   edits marked "CPP.EXE edit".  Role: far-memory heap: sets up the extended-memory
   bank (bank 3 in CPP.EXE, BCC's 4) and installs its hooks.  No caller is known in
   CPP.EXE: INIT_EMS_EXT_BANKS (MEMINIT.C), which calls it in BCC.EXE, is reduced to
   its EMS half here.  A file of its own, apart from the transfers before
   it (EXTBANK.C).  RH_CALL_EXT_RELEASE, which follows it in BCC's order, is a separate
   module (HPEXTREL.C, Borland C++ 2.0).
   Compiler: Turbo C 2.01 (like EXTBANK.C), not Borland C++ 2.0: sub sp,2 for the
   one-byte local (image 29A6; BC 2.0: dec sp; dec sp), or dx,ax for the long tested
   against zero (image 29D4; BC 2.0: or ax,dx) and xor dx,dx; mov ax,dx for return 0L.
   Turbo C 2.01 has no _loadds: the function is huge (no register variables), which
   gives _loadds's prologue (push bp; mov bp,sp; sub sp,2; push ds; mov ax,DGROUP;
   mov ds,ax) and pop ds before the return.
   CRLF line ends, for CPPHEAP.H.  "image" marks a CPP.EXE image offset. */
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
extern void near pascal EXT_READ_NODE(HeapNode near *node,unsigned int target);
extern void near pascal EXT_WRITE_NODE(HeapNode near *node,unsigned int source);
extern void near pascal EXT_MOVE_NODE(HeapNode near *node,unsigned int key);
extern HeapNode near * near pascal EXT_FIND_FREE_NODE(unsigned int size);
struct ExtControl {
    unsigned char preceding_fields[0x30];
    unsigned long base;
};

/* Set up descriptor bank 3 over extended memory from base for size bytes,
   clipped to OVR_EXT_MEMORY_START..OVR_EXT_MEMORY_END.  The unit is 2 to the bit
   length of size>>16, the smallest power of two above size/64K, so that
   size/unit fits in 16 bits (size 10000h gives unit 2); INIT_BANK gets
   (0, size/unit, 3, unit-1, unit).  Returns the size used, or 0. */
/* CPP.EXE edit: huge for BCC's _loadds (Turbo C 2.01: see the top of the file). */
long huge pascal INIT_EXT_BANK(unsigned long base,unsigned long size)
{
    unsigned char tried;
    tried=0;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    _DS=HEAP_DESCRIPTOR_SEGMENTS[0];
    /* CPP.EXE edit: every failure goes to one return 0 (image 2A94: xor dx,dx;
       mov ax,dx), where BCC repeats it. */
    if(RH_GROW_DESCRIPTORS(20)) goto fail;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    if(!DETECT_EXTENDED_MEMORY()) goto fail;
again:
    if(OVR_EXT_MEMORY_START>base) base=OVR_EXT_MEMORY_START;
    if(OVR_EXT_MEMORY_END<=base) goto fail;
    if(!size || OVR_EXT_MEMORY_END-base<size) size=OVR_EXT_MEMORY_END-base;
    if(size<0x10000UL) goto fail;
    /* Claim the range once, then clip again: the claim probably moves
       OVR_EXT_MEMORY_START or OVR_EXT_MEMORY_END. */
    if(tried==0) {
        if(CLAIM_EXTENDED_MEMORY(base,size)) {
fail:
            return 0L;
        }
        tried++;
        goto again;
    }
    /* unit = smallest power of two above size>>16 (shift the high word left
       until a 1 falls out, rotating BX right each time it does not); then
       INIT_BANK(0, size/unit, 3, unit-1, unit). */
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
    asm push 3;        /* CPP.EXE edit: the extended-memory bank is bank 3 (image 2AB9), BCC's 4 */
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
