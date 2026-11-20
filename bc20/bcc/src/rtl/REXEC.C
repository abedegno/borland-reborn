/* target: CODE_24_REXEC */
/* compiler: TC201 */
/* opts: -mm -G -Z -p */
/* Role: run-time library. Entry points: RTL_EXEC. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C library's internal _exec, the DOS "load and execute"
   call behind spawnl and friends.  mode is the DOS 4Bh subfunction (0 =
   load and run) and parameters the DOS parameter block (environment
   segment, command tail and FCBs).  BCC's only caller is RUN_PROGRAM in
   driver/RDRV388.C, which finds TASM or TLINK with RTL_SEARCHPATH, shrinks
   memory (EXECMEM.C) and restores the original interrupt vectors around
   this call.  The path is copied into the PSP's command-tail area at
   offset 80h, so it must fit in the 128 bytes there. */
/* Segment 0A80:0001..0061 (CODE_24 through CODE_25:0001), Borland run-time library: load and run a
   program through DOS 4Bh.
     int pascal _exec(char far *path, char mode, void far *parameters)
   The program path is copied (STRING_COPY) to PSP:80h and passed to DOS as
   DS:DX.  SS:SP (taken after push bp) is saved in DGROUP across the call,
   because DOS 2.x destroys all registers in function 4Bh (Ralf Brown's
   Interrupt List); mov bp,sp then rebuilds the frame.
   Returns -1 with errno set, the child's return code (DOS 4Dh) for mode 0,
   or 0.  Compiled without -O: its returns keep their jumps to the exit.
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
#include <dos.h>
extern int errno;                       /* DS:0000 */
extern unsigned int _psp;               /* DS:0012, program segment prefix */
extern unsigned int SAVE_SS;            /* DS:8B4A */
extern unsigned int SAVE_SP;            /* DS:8B4C */
extern char far * far pascal STRING_COPY(char far *,char far *);

int far pascal RTL_EXEC(char far *path,char mode,void far *parameters)
{
    /* Save SS:SP in DGROUP: DOS 2.x loses every register in function 4Bh. */
    asm mov ax,sp
    asm mov word ptr DGROUP:SAVE_SP,ax
    asm mov ax,ss
    asm mov word ptr DGROUP:SAVE_SS,ax
    STRING_COPY(MK_FP(_psp,0x80),path);
    /* ES:BX = parameter block, DS:DX = PSP:80h (the path), AL = mode. */
    asm les bx,parameters
    asm mov ds,word ptr DGROUP:_psp
    asm mov dx,80h
    asm mov ah,4Bh
    asm mov al,mode
    asm int 21h
    /* Back from the child: reload DS, then SS:SP with interrupts off, and
       rebuild BP.  The jae tests the carry flag from int 21h, which these
       moves leave alone. */
    asm mov dx,DGROUP
    asm mov ds,dx
    asm cli
    asm mov ss,word ptr DGROUP:SAVE_SS
    asm mov sp,word ptr DGROUP:SAVE_SP
    asm sti
    asm mov bp,sp
    asm jae loaded
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1;
loaded:
    /* After a load-and-run, DOS 4Dh returns the child's exit code in AL and
       how it ended in AH (1 = Ctrl-C, which RUN_PROGRAM checks). */
    if(mode==0) {
        asm mov ah,4Dh
        asm int 21h
        return _AX; /* the child's return code (documented pseudo-register read) */
    }
    return 0;
}
