/* target: CODE_1_RVECSET */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RVECSET sets an interrupt vector, like the C library's
   setvect.  Under plain DOS (DOS_HOST_MODE not 8) it calls RTL_SETVECT
   (RVECT.C); under the DOS extender it calls DOS function 25h inline,
   keeping the caller's AX, DX and DS.  It is the setter used for BCC's
   handlers: RMAIN13C installs them, RUN_PROGRAM (RDRV388.C) swaps the
   original vectors back in around TASM and TLINK, and the Ctrl-C cleanup
   (RCTRL23.C) and EXIT (REXIT09F.C) restore the originals.  It is static;
   those files are built with this one through their context lines. */
#include <dos.h>
#include "DATA.H"
extern void far pascal RTL_SETVECT(unsigned int,void far *);
static void far pascal RVECSET(unsigned int vector,void far *address)
{
    if(DOS_HOST_MODE!=8) RTL_SETVECT(vector,address);
    else {
        /* DOS AH25 consumes AL and DS:DX; preserve caller AX/DX/DS. */
        asm push ax;
        asm push dx;
        asm mov ax,ds;
        asm push ds;
        asm mov dx,word ptr address;
        asm mov ds,word ptr address+2;
        asm mov al,byte ptr vector;
        asm mov ah,25h;
        geninterrupt(0x21);
        asm pop ax;
        asm mov ds,ax;
        asm pop dx;
        asm pop ax;
    }
}
