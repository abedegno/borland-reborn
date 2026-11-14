/* rputs.c: from bcc20/src/rtl/RPUTS.C: a 0-terminated string to DOS handle 1 (standard
   output) with RTL_WRITE, no newline added, errors ignored; roughly fputs(text, stdout)
   without buffering.  Used for the banner, the usage text and driver messages. */
#include "port.h"
#include "protos.h"

void WRITE_STDOUT_STRING(farptr text)
{
    RTL_WRITE(1, text, STRING_LENGTH(text));
}
