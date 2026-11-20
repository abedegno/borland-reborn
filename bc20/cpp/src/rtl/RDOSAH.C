/* target: RDOSAH */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RDOSAH (114A:000F..001B): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RDOSAH.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: DOS_CALL_AH. */
/* Overview: DOS_CALL_AH is a bare int 21h with AH set and the result left
   in AX, roughly the C library's bdos without the DX and AL arguments.
   Callers: CONFIG calls it with 30h to read the DOS version, and DRVLINK
   with 0Bh (check input status, which probably lets DOS notice a pending
   Ctrl-Break). */
/* Borland run-time library: a far pascal
   DOS call with only AH set from the
   first of three word parameters; the other two are not used.  It falls off
   its end with AX as int 21h left it (documented fall-off-end); CONFIG
   calls DOS_CALL_AH(30h,0,0) for the DOS version.
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
int far pascal DOS_CALL_AH(int function,int unused1,int unused2)
{
    asm mov ah,byte ptr function
    asm int 21h
}
