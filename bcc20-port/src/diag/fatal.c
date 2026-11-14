/* fatal.c: from bcc20/src/diag/FATAL.C: REPORT_FATAL prints a fatal error and gives up on
   the file.  REPORT_DIAGNOSTIC_AT (diag.c) sends message numbers below 10 here; other code
   calls it directly (for example "Out of memory" in BEGIN_SESSION).  It prints the line
   through BCC_FORMAT_DIAGNOSTIC (diagfmt.c), counts it as an error and long-jumps with code
   2 to ERROR_JUMP_BUFFER, set by COMPILE_ONE_FILE (options.c), which then gives up on the
   file.  The prefix is "Fatal" for message numbers 1 to 3 (internal failures such as
   "Register allocation failure") and "Error" for all others.  The printf arguments are the
   block at arguments (variadic.h). */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "variadic.h"

#define ERROR_COUNT W(ERROR_COUNT_P)
#define DIAGNOSTIC_COUNT W(DIAGNOSTIC_COUNT_P)

void REPORT_FATAL_ARGS(i16 error, farptr arguments)
{
    BCC_FORMAT_DIAGNOSTIC(error < 4 ? STR_FATAL_P : STR_ERROR_P, arguments, (u16)error);
    ++ERROR_COUNT;
    ++DIAGNOSTIC_COUNT;
    C45_LONGJUMP(ERROR_JUMP_BUFFER_P, 2);
}

void report_fatal_v(i16 error, const DosArg *args)
{
    u16 mark = scratch_mark();
    REPORT_FATAL_ARGS(error, dos_argument_block(args));
    scratch_release(mark);
}
