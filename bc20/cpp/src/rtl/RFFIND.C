/* target: RFFIND */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module RFFIND (117C:0004..005E): source taken unchanged from the BCC.EXE
   reconstruction (src/rtl/RFFIND.C); its code is the same in both programs. */
/* Role: run-time library. Entry points: FINDFIRST, FINDNEXT. */
/* Overview: the C library's findfirst and findnext (dir.h).  DOS writes
   each match into the current disk transfer area, so both first point the
   DTA at the caller's ffblk.  findfirst takes a path that may contain
   wildcards and an attribute mask; findnext continues the search recorded
   in the ffblk.  Callers in CPP.EXE: CONFIG (FINDFIRST) and DRVLINK (both);
   BCC.EXE's FILE_TIME (FILETIME.C) is not in CPP.EXE. */
/* Borland run-time library findfirst and findnext
   with pascal calling.  Each sets the DTA to the ffblk through RTL_DOS_CALL_PTR
   (RDOSPTR, DOS 1Ah), then calls DOS 4Eh / 4Fh; returns 0, or -1 with
   errno set.
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
struct ffblk;                           /* DOS find record (dir.h) */
extern int errno;                       /* DS:0000 */
extern int far pascal RTL_DOS_CALL_PTR(int function,void far *pointer,int unused);

int far pascal FINDFIRST(char far *path,struct ffblk far *ffblk,int attrib)
{
    RTL_DOS_CALL_PTR(0x1A,ffblk,0);
    asm push ds
    asm lds dx,path
    asm mov cx,attrib
    asm mov ah,4Eh
    asm int 21h
    asm pop ds
    asm jae found
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1;
found:
    return 0;
}

int far pascal FINDNEXT(struct ffblk far *ffblk)
{
    RTL_DOS_CALL_PTR(0x1A,ffblk,0);
    asm mov ah,4Fh
    asm int 21h
    asm jae found
    errno=_AX;      /* DOS error code (documented pseudo-register read) */
    return -1;
found:
    return 0;
}
