/* target: RHINIT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p -r- -B -zCCODE2 */
/* link: -zCCODE2 gives this file the code segment it shares with the other files of frame 0054h (one segment, one frame in CPP.EXE; the name itself is not in the EXE). */
/* CPP.EXE module RHINIT (0054:1AE1, image 0x2021): source taken from the BCC.EXE
   reconstruction (bcc20/src/heap/RHINIT.C); with the CPP.EXE edits
   marked "CPP.EXE edit"; compiled by Turbo C 2.01 (les bx / mov [hook+2],es for the
   hook store, BC 2.0 uses DX:AX): huge in place of _loadds, CPPHEAP.H and CRLF line
   ends. */
/* Role: far-memory heap: INIT_HEAP, the heap's start-up entry (CPU probe, bank 0,
   handle-item pages, null bank, status hook). Entry points: INIT_HEAP. */
/* Overview: INIT_HEAP is the far entry that INIT_MEMORY_MANAGER (MEMINIT.C)
   calls once at start-up; see HEAPMAIN.C's overview for the heap itself.
   start_seg..end_seg are the paragraphs given to bank 0, count the size of a
   handle-item page, hook the status hook (OUT_OF_MEMORY_HANDLER), and extra
   is not used in CPP.EXE (in BCC.EXE, when not 0, the path of a swap file
   for bank 1).  60 (3Ch) descriptors are made to begin with.
   INIT_HEAP: heap start-up.  It clears HEAP_DEFAULT_OWNER_TAG, installs the
   caller's status hook (HEAP_HOOK_CALLSITE), records the CPU type in
   HEAP_CPU_TYPE, then sets up the heap in the paragraphs start_seg..end_seg
   with INIT_MAIN_HEAP (HEAPMAIN.C) and INIT_NULL_BANK (RNOOPS.C).  BCC.EXE's
   version also calls INIT_SWAP_BANK and __OVRINIT (the overlay manager's
   start).  Returns 0, or 1002h on failure.

   CPU probe (inline asm): 1 = 8086/88, 80186/188 or V20/V30 (push sp
   pushes the new SP), 2 = 286, 3 = 386 or later.  A 286 is told from a 386 by running "mov eax,ebx"
   with the invalid-opcode vector (int 6) pointed at trap; there, "add sp,6"
   drops the interrupt frame.  On a 386 the instruction runs, CPU_TYPE is
   raised again and "sub sp,6" balances the same add.  DS is CS while the
   handler is installed; the 386 path reloads it from cs:HEAP_PROGRAM_DS,
   the 286 path gets it back from the final pop ds.  The vector is restored
   either way.  The store of 1 is in asm: TASM gives it the nop that follows
   at 0054:1AFF (a forward-referenced extern whose size it does not yet know). */
#include <dos.h>
#include "CPPHEAP.H"
extern unsigned char HEAP_CPU_TYPE;
extern unsigned int far HEAP_PROGRAM_DS;
extern unsigned int near pascal INIT_MAIN_HEAP(unsigned int start_seg,
    unsigned int end_seg,unsigned int descriptors,unsigned int count);
extern void near pascal INIT_NULL_BANK(void);

/* CPP.EXE edit (image 0x2021): no swap bank and no overlay manager, so
   extra is not used and INIT_SWAP_BANK and __OVRINIT are not called; after
   INIT_MAIN_HEAP and INIT_NULL_BANK it returns 0. */
unsigned int huge pascal INIT_HEAP(unsigned int start_seg,
    unsigned int end_seg,unsigned int count,HeapHookCallsite hook,void far *extra)
{
    HEAP_DEFAULT_OWNER_TAG=0;
    HEAP_HOOK_CALLSITE=hook;
    asm mov DGROUP:HEAP_CPU_TYPE,1;
    asm push sp;
    asm pop ax;
    asm cmp ax,sp;
    asm jne probed;
    asm inc byte ptr DGROUP:HEAP_CPU_TYPE;
    asm push ds;
    asm mov ax,3506h;
    asm int 21h;
    asm push es;
    asm push bx;
    asm push cs;
    asm pop ds;
    asm mov dx,offset trap;
    asm mov ax,2506h;
    asm int 21h;
    asm pushf;
    asm .386;               /* for the probe instruction only */
    asm mov eax,ebx;
    asm .8086;
    asm mov ds,word ptr cs:HEAP_PROGRAM_DS;
    asm inc byte ptr DGROUP:HEAP_CPU_TYPE;
    asm sub sp,6;
    asm trap label near;
    asm add sp,6;
    asm popf;
    asm pop dx;
    asm pop ds;
    asm mov ax,2506h;
    asm int 21h;
    asm pop ds;
probed:
    HEAP_STATUS=0x1002;
    if(INIT_MAIN_HEAP(start_seg,end_seg,0x3c,count)) return 0x1002;
    INIT_NULL_BANK();
    return 0;
}
