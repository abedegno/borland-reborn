/* target: CODE_22_RCLOSE */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_CLOSE. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C library's _close (or close): closes a DOS file handle.
   Used by the output file code (RFILEIO.C) and by the input and driver
   code to close files opened with RTL_OPEN or RTL_CREAT. */
/* CODE_22:0004..0022, Borland run-time library _close with pascal calling:
   DOS 3Eh; returns 0, or -1 with errno set.  handle is a register
   parameter, which is why SI is saved and BX is loaded through SI.
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
extern int errno;                       /* DS:0000 */

int far pascal RTL_CLOSE(register int handle)
{
    asm mov bx,handle
    asm mov ah,3Eh
    asm int 21h
    asm jnc closed
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1;
closed:
    return 0;
}
