/* target: CODE_26_RDATE */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_GETDATE, RTL_GETTIME. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the C library's getdate and gettime (dos.h).  DOS 2Ah gives
   the year in CX and month:day in DH:DL, which is the layout of
   struct date (da_year, da_day, da_mon); DOS 2Ch gives hour:minute in
   CH:CL and second:hundredths in DH:DL, the layout of struct time
   (ti_min, ti_hour, ti_hund, ti_sec).  RMAIN13C calls both once at start
   up to fill CURRENT_DATE and CURRENT_TIME (probably for __DATE__ and
   __TIME__). */
/* Segment 0A8B:000C..0035 (CODE_26 through CODE_27:0005), Borland run-time library getdate (DOS 2Ah) and
   gettime (DOS 2Ch) with pascal calling; each stores CX and DX from DOS
   into the structure.
   Written the way Borland wrote its DOS-call run-time functions (.CAS
   files): C with inline assembly for the DOS call, compiled by Turbo C 2.01. */
#pragma inline
#include <dos.h>                        /* struct date, struct time */

void far pascal RTL_GETDATE(struct date far *datep)       /* getdate */
{
    asm mov ah,2Ah
    asm int 21h
    asm les bx,datep
    asm mov es:[bx],cx
    asm mov es:[bx+2],dx
}

void far pascal RTL_GETTIME(struct time far *timep)       /* gettime */
{
    asm mov ah,2Ch
    asm int 21h
    asm les bx,timep
    asm mov es:[bx],cx
    asm mov es:[bx+2],dx
}
