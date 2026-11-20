/* target: RWRITE */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RWRITE (11AD:0004..0024): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RWRITE.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: RTL_WRITE. */
/* Overview: the C library's _write: writes count bytes to a DOS handle
   with function 40h.  A count smaller than asked for means the disk is
   full; the output file code (RFILEIO.C) treats that as an error.  Also
   used by WRITE_STDOUT_STRING, which CPP.EXE has in driver/CPPMAIN.C
   (BCC.EXE has it in RPUTS.C, and its precompiled-header writer also
   calls RTL_WRITE). */
/* Borland run-time library _write with pascal calling:
   DOS 40h; returns the byte count, or -1 with errno set.
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
extern int errno;                       /* DS:0000 */

int far pascal RTL_WRITE(int handle,void far *buffer,unsigned count)
{
    asm mov cx,count
    asm mov bx,handle
    asm mov ah,40h
    asm push ds
    asm lds dx,buffer
    asm int 21h
    asm pop ds
    asm jc failed
    return _AX;     /* the count DOS returned (documented pseudo-register read) */
failed:
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1;
}
