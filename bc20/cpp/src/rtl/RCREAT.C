/* target: RCREAT */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RCREAT (117A:0005..0024): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RCREAT.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: RTL_CREAT. */
/* Overview: the C library's _creat: creates (or truncates) a file with
   DOS function 3Ch and returns its handle.  attrib is the DOS attribute
   word (0 for a normal file).  The only caller in CPP.EXE is
   CREATE_OUTPUT_FILE (RFILEIO.C), which creates the .i output; BCC.EXE's
   precompiled-header writer also calls it there. */
/* Borland run-time library _creat with pascal calling:
   DOS 3Ch with the attributes in CX; returns the handle, or -1 with errno
   set.  The unused register variable fd is why the function saves SI, as
   the original does (documented dummy).
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
extern int errno;                       /* DS:0000 */

int far pascal RTL_CREAT(char far *path,int attrib)
{
    register int fd;
    asm mov cx,attrib
    asm push ds
    asm lds dx,path
    asm mov ah,3Ch
    asm int 21h
    asm pop ds
    asm jnc created
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1;
created:
    return _AX;     /* the handle DOS returned (documented pseudo-register read) */
}
