/* target: CODE_4_R5B44 */
/* opts: -mm -G -O -Z -p -B */
/* Role: diagnostics: REPORT_FATAL, prints a fatal message and ends the compilation. Entry
   points: REPORT_FATAL. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: REPORT_FATAL is the printer for messages that end the compile of the current
   file. REPORT_DIAGNOSTIC_AT (DIAG.C) sends message numbers below 10 here; other code
   calls it directly (for example "Out of memory" in BEGIN_SESSION). It prints the line
   through BCC_FORMAT_DIAGNOSTIC (DIAGFMT.C), counts it as an error and long-jumps with
   code 2 to ERROR_JUMP_BUFFER, set by COMPILE_ONE_FILE (OPTIONS.C), which then gives up
   on the file. It never returns. */
#include "DATA.H"
extern unsigned int ERROR_COUNT,DIAGNOSTIC_COUNT;
extern unsigned char ERROR_JUMP_BUFFER[];
extern void near pascal BCC_FORMAT_DIAGNOSTIC(char far *,char far *,unsigned int);
extern void far pascal C45_LONGJUMP(void far *,int);
/* error: message number (MSG.H); the printf arguments follow it on the stack, and
   arguments points at them (the cdecl varargs layout, without <stdarg.h>). The prefix is
   "Fatal" for message numbers 1 to 3 (internal failures such as "Register allocation
   failure") and "Error" for all others, as the code reads. */
void far cdecl REPORT_FATAL(int error,...)
{
    register int code=error;
    char far *arguments=(char far *)&error+sizeof(error);
    BCC_FORMAT_DIAGNOSTIC(code<4?STR_FATAL:STR_ERROR,arguments,code);
    ++ERROR_COUNT;
    ++DIAGNOSTIC_COUNT;
    C45_LONGJUMP(ERROR_JUMP_BUFFER,2);
}
