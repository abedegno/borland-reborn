/* target: CODE_29_RLSEEK */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_LSEEK. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C library's lseek: moves a file's read/write position
   with DOS function 42h.  whence is SEEK_SET (0), SEEK_CUR (1) or SEEK_END
   (2).  Used by the source input code (lexer/INPUT.C), the precompiled
   header code (PCH) and the driver.  The ";" after the moved label is an
   empty statement that only carries the label. */
/* CODE_29:000E..0031, Borland run-time library lseek with pascal calling:
   DOS 42h; returns the new position, or -1L with errno set.  On success
   the function falls off its end with the position in DX:AX from DOS
   (documented fall-off-end).
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
extern int errno;                       /* DS:0000 */

long far pascal RTL_LSEEK(int handle,long position,int whence)
{
    asm mov al,byte ptr whence
    asm mov cx,word ptr position+2
    asm mov dx,word ptr position
    asm mov bx,handle
    asm mov ah,42h
    asm int 21h
    asm jnc moved
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1L;
moved:
    ;
}
