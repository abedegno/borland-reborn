/* target: CODE_21_RCHMOD */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: _chmod. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C library's _chmod (io.h), which reads or sets a file's DOS
   attributes with DOS function 43h.  In BCC its only caller is
   RTL_SEARCHPATH (SEARCHP.C), which calls _chmod(name,0) to see whether a
   file exists.  It is the one cdecl function of these DOS wrappers,
   because of its variable argument list. */
/* Segment 0A79:000A..0033 (CODE_21), Borland run-time library _chmod (cdecl):
   int cdecl _chmod(char far *path, int func, ... int attrib).
   DOS 43h: func 0 returns the attributes (CX), func 1 sets them from attrib
   and returns 0; -1 with errno set on failure.  attrib is the word after
   func on the stack.  SEARCHP calls it with func 0 as an existence test.
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
extern int errno;                       /* DS:0000 */

int cdecl _chmod(char far *path,int func,...)
{
    asm mov cx,word ptr func+2
    asm mov al,byte ptr func
    asm push ds
    asm lds dx,path
    asm mov ah,43h
    asm int 21h
    asm pop ds
    asm jnc done
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1;
done:
    if(func==1) return 0;
    return _CX;     /* the attributes DOS returned (documented pseudo-register read) */
}
