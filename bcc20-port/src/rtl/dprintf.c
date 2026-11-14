/* dprintf.c: from bcc20/src/rtl/DPRINTF.C: the front end of BCC's small console printf
   (Turbo C 2.01 dprintf).  RTL_DPRINTF passes format and the address of the arguments after
   it to RTL_DVPRINTF (rtl/DVPRINTF.C), which does all the formatting and writes the
   characters through DOS function 02h: %d, %x, %c and %s, with l for long.  Callers: the
   diagnostic printer (diagfmt.c) and the driver (drvlink.c prints the error total, rmain13c.c
   the free memory).  Here the arguments are the block variadic.h describes; RTL_DVPRINTF
   itself is console output, the platform's part. */
#include "port.h"
#include "protos.h"
#include "variadic.h"

void RTL_DPRINTF_ARGS(farptr format, farptr arguments)
{
    RTL_DVPRINTF(format, arguments);
}

void rtl_dprintf_v(farptr format, const DosArg *args)
{
    u16 mark = scratch_mark();
    RTL_DPRINTF_ARGS(format, dos_argument_block(args));
    scratch_release(mark);
}
