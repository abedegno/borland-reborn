/* target: CODE_5_R5SETBLK */
/* opts: -mm -G -O -Z -p -Y */
/* Role: run-time library: SET_PROGRAM_TOP resizes BCC's memory block (DOS 4Ah, or the DOS
   extender's call) so the program ends at a paragraph. Entry points: SET_PROGRAM_TOP. Map
   of all sources: docs/SOURCE-MAP.md. */
/* Overview: SET_PROGRAM_TOP is the memory-resize step behind EXECMEM.C,
   roughly the C library's setblock on BCC's own block.  top is an absolute
   paragraph address; the DOS path turns it into a size from PROGRAM_PSP,
   the extender path into a byte count from EXTENDER_BASE.  A failed resize
   is how callers find out how much memory there is: RESTORE_MEMORY_AFTER_EXEC
   asks for top FFFFh on purpose and uses the answer. */
/* Segment 05C5:0170..01D1 (CODE_5, through CODE_6:0001), BCC's own C with
   inline assembly (BC 2.0, -Y like the overlay modules: hence the
   inc bp / dec bp around the frame), called near by EXECMEM.C:
     unsigned near pascal SET_PROGRAM_TOP(unsigned top)
   Resizes the program's memory so it ends at paragraph top.  Under DOS (the
   byte at DS:001A is not 8) it uses DOS 4Ah on the PSP and on failure
   returns the largest possible top (PSP + the size DOS offers).  Under the
   DOS extender it uses int 21h AX=E905h (handle DS:001B, size in bytes in
   CX:DX from the base paragraph DS:001D) and on failure returns the size it
   offers in paragraphs.  0 means success; both successes share one
   `xor ax,ax` through -O's tail merging. */
#include "DATA.H"
#pragma inline

unsigned int near pascal SET_PROGRAM_TOP(unsigned int top)
{
    if(DOS_HOST_MODE!=8) {
        asm mov es,word ptr DGROUP:PROGRAM_PSP
        asm mov ax,top
        asm sub ax,word ptr DGROUP:PROGRAM_PSP
        asm mov bx,ax
        asm mov ah,4Ah
        asm int 21h
        asm jnc dos_ok
        return _BX+PROGRAM_PSP; /* DOS offers BX paragraphs (documented pseudo-register read) */
dos_ok:
        return 0;
    }
    /* DOS extender: size in bytes = (top - EXTENDER_BASE) * 16, in CX:DX. */
    asm mov ax,top
    asm mov dx,word ptr DGROUP:EXTENDER_BASE
    asm sub ax,dx
    asm xor dx,dx
    asm mov cx,10h
    asm mul cx
    asm mov cx,dx
    asm mov dx,ax
    asm mov bx,word ptr DGROUP:EXTENDER_HEAP_TOP
    asm mov ax,0E905h
    asm int 21h
    asm jnc extender_ok
    /* Failed: CX:DX holds the size on offer in bytes; four 32-bit shifts
       right turn it into paragraphs in DX. */
    asm shr cx,1
    asm rcr dx,1
    asm shr cx,1
    asm rcr dx,1
    asm shr cx,1
    asm rcr dx,1
    asm shr cx,1
    asm rcr dx,1
    return _DX;     /* offered size in paragraphs (documented pseudo-register read) */
extender_ok:
    return 0;
}
