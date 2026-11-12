/* target: CODE_30_ROPEN */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_OPEN. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C library's _open: opens an existing file with DOS
   function 3Dh; mode is the DOS access mode in AL (0 read, 1 write, 2
   both).  Returns the handle.  Used for source and include files
   (lexer/INPUT.C), configuration files (CONFIG), precompiled headers
   (PCH) and the driver. */
/* CODE_30:0001..0020, Borland run-time library _open with pascal calling:
   DOS 3Dh with the access mode in AL; returns the handle, or -1 with errno
   set.  The unused register variable fd is why the function saves SI, as
   the original does (documented dummy).
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
extern int errno;                       /* DS:0000 */

int far pascal RTL_OPEN(char far *path,int mode)
{
    register int fd;
    asm mov al,byte ptr mode
    asm push ds
    asm lds dx,path
    asm mov ah,3Dh
    asm int 21h
    asm pop ds
    asm jnc opened
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1;
opened:
    return _AX;     /* the handle DOS returned (documented pseudo-register read) */
}
