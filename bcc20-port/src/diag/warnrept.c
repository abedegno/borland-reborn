/* warnrept.c: from bcc20/src/diag/WARNREPT.C: REPORT_WARNING prints a warning like
   REPORT_ERROR prints an error, but only when that warning is switched on
   (WARNING_ENABLED_TABLE, indexed by message number).  Warnings count in DIAGNOSTIC_COUNT
   only, so DIAGNOSTIC_COUNT minus ERROR_COUNT is the number of warnings.  When a warning
   limit is set (OPTION_WARNING_LIMIT, the -g option) and reached, message 61 "Too many
   error or warning messages" is printed as an error and the compile of the file ends
   through a long jump with code 2 to ERROR_JUMP_BUFFER.  The printf arguments are the block
   at arguments (variadic.h). */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "variadic.h"

#define ERROR_COUNT SW(ERROR_COUNT_P)
#define DIAGNOSTIC_COUNT SW(DIAGNOSTIC_COUNT_P)

void REPORT_WARNING_ARGS(u16 error, farptr arguments)
{
    if (!WARNING_ENABLED_TABLE_AT(error))
        return;
    BCC_FORMAT_DIAGNOSTIC(STR_WARNING_P, arguments, error);
    ++DIAGNOSTIC_COUNT;
    if (OPTION_WARNING_LIMIT && (i16)OPTION_WARNING_LIMIT <= (i16)(DIAGNOSTIC_COUNT - ERROR_COUNT)) {
        BCC_FORMAT_DIAGNOSTIC(STR_ERROR_P, arguments, 61);
        ++ERROR_COUNT;
        C45_LONGJUMP(ERROR_JUMP_BUFFER_P, 2);
    }
}

void report_warning_v(u16 error, const DosArg *args)
{
    u16 mark = scratch_mark();
    REPORT_WARNING_ARGS(error, dos_argument_block(args));
    scratch_release(mark);
}
