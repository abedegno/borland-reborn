/* target: CODE_1_RVECGET */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RVECGET returns an interrupt vector, like the C library's
   getvect.  DOS_HOST_MODE is 8 when BCC runs under its DOS extender (see
   SETTOP.C).  Under plain DOS it calls RTL_GETVECT (RVECT.C); under the
   extender it makes the same DOS call, function 35h, inline and builds
   the far pointer from ES:BX.  The reason for the separate path is not
   visible here.  RMAIN13C calls it at start up to save the INT 18h, 23h
   and 1Bh vectors before installing BCC's handlers.  It is static and is
   reached through the build's context mechanism. */
#include <dos.h>
#include "DATA.H"
extern void far *far pascal RTL_GETVECT(unsigned int);
static void far *far pascal RVECGET(unsigned int vector)
{
    unsigned int offset;
    if(DOS_HOST_MODE!=8) return RTL_GETVECT(vector);
    _AL=(unsigned char)vector;
    _AH=0x35;
    geninterrupt(0x21);
    offset=_BX;
    return MK_FP(_ES,offset);
}
