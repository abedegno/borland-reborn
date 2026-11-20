/* target: CODE_39_RABBB */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library: dprintf (Turbo C 2.01), builds the argument list by hand and
   passes it to the small console printf RTL_DVPRINTF. Entry points: RTL_DPRINTF. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: the front end of BCC's small console printf.  RTL_DPRINTF is
   the only cdecl, variable-argument function of the pair: it works out
   where the arguments after format start on the stack and passes format
   and that address to RTL_DVPRINTF (DVPRINTF.C), which does all the
   formatting and writes the characters through DOS function 02h.  The
   closest standard functions are printf and vprintf, but only %d, %x, %c
   and %s (with an l prefix for long) are understood and nothing goes
   through stdio.  Callers: the diagnostic printer in diag/DIAGFMT.C (file
   name, line number and message of each error or warning) and the driver
   (DRVLINK prints the error total).  Nothing here has state. */
/* CODE_39:000B..0030, Borland run-time library (Turbo C 2.01):
   void cdecl dprintf(char far *format, ...): passes the argument list to the
   console printf RTL_DVPRINTF (DVPRINTF). */
extern void far pascal RTL_DVPRINTF(char far *format,char far *args);

void far cdecl RTL_DPRINTF(char far *format,...)
{
    char far *args;
    /* va_start by hand: Turbo C 2.01's medium-model va_list is a near
       pointer, but RTL_DVPRINTF takes a far one (ss-relative lea). */
    args=(char far *)(&format+1);
    RTL_DVPRINTF(format,args);
}
