/* target: CODE_31_RREAD */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_READ. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C library's _read: reads up to count bytes from a DOS
   handle with function 3Fh.  A return value of 0 means end of file.  Used
   by the source input code (lexer/INPUT.C), precompiled headers and the
   configuration file reader. */
/* CODE_31:0000..0020, Borland run-time library _read with pascal calling:
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
