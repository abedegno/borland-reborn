/* errrept.c: from bcc20/src/diag/ERRREPT.C: REPORT_ERROR prints "Error file line: message"
   for message number error (through BCC_FORMAT_DIAGNOSTIC in diagfmt.c) and counts it in
   ERROR_COUNT and DIAGNOSTIC_COUNT.  When an error limit is set (OPTION_ERROR_LIMIT, the -j
   option) and reached, it also prints message 61 "Too many error or warning messages" and
   long-jumps with code 2 to ERROR_JUMP_BUFFER, which ends the compile of the file
   (COMPILE_ONE_FILE in options.c).  Driver code that must always show a message sets the
   limits to 0 first.  The printf arguments are the block at arguments (variadic.h). */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "variadic.h"

#define ERROR_COUNT SW(ERROR_COUNT_P)
#define DIAGNOSTIC_COUNT SW(DIAGNOSTIC_COUNT_P)

void REPORT_ERROR_ARGS(i16 error, farptr arguments)
{
    BCC_FORMAT_DIAGNOSTIC(STR_ERROR_P, arguments, (u16)error);
    ++ERROR_COUNT;
    ++DIAGNOSTIC_COUNT;
    if (OPTION_ERROR_LIMIT && (i16)OPTION_ERROR_LIMIT <= ERROR_COUNT) {
        BCC_FORMAT_DIAGNOSTIC(STR_ERROR_P, arguments, 61);
        ++ERROR_COUNT;
        C45_LONGJUMP(ERROR_JUMP_BUFFER_P, 2);
    }
}

void report_error_v(i16 error, const DosArg *args)
{
    u16 mark = scratch_mark();
    REPORT_ERROR_ARGS(error, dos_argument_block(args));
    scratch_release(mark);
}
