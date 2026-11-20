/* target: CODE_18_RDOSPTR */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_DOS_CALL_PTR. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: RTL_DOS_CALL_PTR calls any DOS function that takes a far
   pointer in DS:DX (roughly the C library's bdosptr, without AL).  Callers:
   DELETE_FILE (RUNLINK.C, function 41h) and FINDFIRST and FINDNEXT
   (RFFIND.C, function 1Ah to set the DTA).  The third parameter is not
   used.  The ";" after the done label is an empty statement that only
   carries the label. */
/* Segment 0A45:000B..0024 (CODE_18), Borland run-time library:
   int pascal RTL_DOS_CALL_PTR(int function, void far *pointer, int unused): DOS function AH with DS:DX = pointer; returns AX, or -1 with
   errno set when DOS reports carry.  The error path is inline assembly too
   (no jump to the exit after it; a C return followed by a label
   compiles with a redundant jmp short under Turbo C 2.01, compare ROPEN), and the function
   falls off its end with the result in AX (documented fall-off-end).
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
extern int errno;                       /* DS:0000 */

int far pascal RTL_DOS_CALL_PTR(int function,void far *pointer,int unused)
{
    asm mov ah,byte ptr function
    asm push ds
    asm lds dx,pointer
    asm clc
    asm int 21h
    asm pop ds
    asm jnc done
    asm mov word ptr DGROUP:errno,ax
    asm mov ax,-1
done:
    ;
}
