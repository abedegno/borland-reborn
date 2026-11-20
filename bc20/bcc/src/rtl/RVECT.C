/* target: CODE_28_RVECT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library: getvect and setvect (DOS functions 35h and 25h). Entry points:
   RTL_SETVECT. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C library's getvect (RTL_GETVECT) and setvect
   (RTL_SETVECT), wrappers for DOS functions 35h and 25h.
   RTL_GETVECT is declared as a function returning a pointer to an
   interrupt function.  They are used through RVECGET and RVECSET (RVECGET.C, RVECSET.C), which
   choose between these and an inline call under the DOS extender. */
/* Segment 0A97:0009..002D (CODE_28 through CODE_29:000D), Borland run-time library getvect (DOS 35h) and
   setvect (DOS 25h) with pascal calling.  getvect falls off its end with
   the vector in DX:AX (documented fall-off-end).
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
void interrupt (far * far pascal RTL_GETVECT(int interruptno))()  /* getvect */
{
    asm mov al,byte ptr interruptno
    asm mov ah,35h
    asm int 21h
    asm mov ax,bx
    asm mov dx,es
}

void far pascal RTL_SETVECT(int interruptno,void interrupt (far *isr)())  /* setvect */
{
    asm push ds
    asm lds dx,isr
    asm mov al,byte ptr interruptno
    asm mov ah,25h
    asm int 21h
    asm pop ds
}
