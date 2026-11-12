/* target: CODE_4_RG4A */
/* opts: -mm -G- -O -Z -r- -p -Y */
/* Role: diagnostics: BCC_FORMAT_DIAGNOSTIC prints one message line: kind, file name, line
   number, message text with arguments, and the function name. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: BCC_FORMAT_DIAGNOSTIC prints one message line (through RTL_DPRINTF), in the form
     Error foo.c 12: Undefined symbol 'x' in function main
   format is the prefix ("Fatal", "Error" or "Warning"), then come the current file name
   (CURRENT_FILE_NAME, an offset in the string pool; left out when 0), the line
   (LOGICAL_LINE, left out when 0), ": ", the message text from the message image
   (BCC_MESSAGE_TEXT in MSGGET.C, linked into this object) formatted with the caller's
   printf arguments, and " in function name" when FUNCTION_NAME_TEXT is set. Called by
   REPORT_FATAL, REPORT_ERROR and REPORT_WARNING. */
#include <dos.h>
#include "DATA.H"
extern unsigned int STRING_POOL_SEG;
extern char far *FUNCTION_NAME_TEXT;
extern void far cdecl RTL_DPRINTF(char far *,...);
extern void far pascal RTL_DVPRINTF(char far *,char far *);

/* format: the prefix word; arguments: pointer to the printf arguments on the caller's
   stack (a va_list); error: the message number. */
static void near pascal BCC_FORMAT_DIAGNOSTIC(char far *format,char far *arguments,unsigned int error)
{
    RTL_DPRINTF(format);
    if(CURRENT_FILE_NAME) RTL_DPRINTF(STR_FMT_SPACE_STRING,MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME));
    if(LOGICAL_LINE) RTL_DPRINTF(STR_FMT_SPACE_LONG,(long)LOGICAL_LINE);
    RTL_DPRINTF(STR_COLON_SPACE);
    RTL_DVPRINTF(BCC_MESSAGE_TEXT(error),arguments);
    if(FUNCTION_NAME_TEXT) RTL_DPRINTF(STR_IN_FUNCTION,FUNCTION_NAME_TEXT);
    RTL_DPRINTF(STR_DIAG_NEWLINE);
}

/* context: MSGGET.C */
/* context-helper-entry: BCC_MESSAGE_TEXT */
/* context-call: 0x57 BCC_MESSAGE_TEXT BCC_MESSAGE_TEXT_BODY */
