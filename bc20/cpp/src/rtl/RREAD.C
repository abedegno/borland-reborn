/* target: RREAD */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RREAD (1191:0009..0029): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RREAD.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: RTL_READ. */
/* Overview: the C library's _read: reads up to count bytes from a DOS
   handle with function 3Fh.  A return value of 0 means end of file.  Used
   in CPP.EXE by the source input code (lexer/INPUT.C), the configuration
   file reader (CONFIG) and the driver (DRVLINK). */
/* Borland run-time library _read with pascal calling:
   DOS 3Fh; returns the byte count, or -1 with errno set.
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
extern int errno;                       /* DS:0000 */

int far pascal RTL_READ(int handle,void far *buffer,unsigned count)
{
    asm mov cx,count
    asm mov bx,handle
    asm mov ah,3Fh
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
