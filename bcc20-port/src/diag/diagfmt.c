/* diagfmt.c: from bcc20/src/diag/DIAGFMT.C and MSGGET.C (one object in the original).
   BCC_FORMAT_DIAGNOSTIC prints one message line through RTL_DPRINTF, in the form
     Error foo.c 12: Undefined symbol 'x' in function main
   format is the prefix ("Fatal", "Error" or "Warning"), then come the current file name
   (CURRENT_FILE_NAME, an offset in the string pool; left out when 0), the line
   (LOGICAL_LINE, left out when 0), ": ", the message text from the message image
   (BCC_MESSAGE_TEXT) formatted with the caller's printf arguments, and " in function name"
   when FUNCTION_NAME_TEXT is set.  Called by REPORT_FATAL, REPORT_ERROR and REPORT_WARNING.
   The message texts live in a separate loadable image (messages, BCC_MESSAGE_IMAGE) that
   the overlay manager brings into memory on demand: OVR_ENSURE_IMAGE_LOADED loads it if
   needed and returns a far pointer to its start, a table of word offsets, one per message
   number. */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "variadic.h"

#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define FUNCTION_NAME_TEXT D(FUNCTION_NAME_TEXT_P)      /* char far * */
/* the message image's overlay stub (load-relative paragraph from symbols.tsv) */
#define BCC_MESSAGE_IMAGE_P MK_FP(0x0C5B + (DGROUP - DGROUP_PARA), 0)

/* a far pointer to the printf format text of message number index; valid while the image
   stays loaded (the caller uses it at once) */
farptr BCC_MESSAGE_TEXT(u16 index)
{
    farptr table = OVR_ENSURE_IMAGE_LOADED(BCC_MESSAGE_IMAGE_P);
    return MK_FP(FP_SEG(table), W(fp_add(table, index * 2)));
}

/* format: the prefix; arguments: the printf arguments (variadic.h); error: the message
   number */
void BCC_FORMAT_DIAGNOSTIC(farptr format, farptr arguments, u16 error)
{
    RTL_DPRINTF(format);
    if (CURRENT_FILE_NAME)
        RTL_DPRINTF(STR_FMT_SPACE_STRING_P, MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME));
    if (LOGICAL_LINE)
        RTL_DPRINTF(STR_FMT_SPACE_LONG_P, (long)LOGICAL_LINE);
    RTL_DPRINTF(STR_COLON_SPACE_P);
    RTL_DVPRINTF(BCC_MESSAGE_TEXT(error), arguments);
    if (FUNCTION_NAME_TEXT)
        RTL_DPRINTF(STR_IN_FUNCTION_P, FUNCTION_NAME_TEXT);
    RTL_DPRINTF(STR_DIAG_NEWLINE_P);
}
