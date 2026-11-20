/* target: ovr118_TCHECK */
/* opts: -mm -G- -O -Z -p */
/* Role: parser: requires the current token to be the expected one and advances, otherwise
   reports the given error. Map of all sources: docs/SOURCE-MAP.md. */

/* Overview: the plain "expect this token" helper of the parser.  If
   CURRENT_TOKEN is the expected token it is consumed with ADVANCE_TOKEN,
   otherwise the given message is reported against the current token
   (REPORT_CURRENT_TOKEN quotes its spelling).  Unlike TREE_INVOKE
   (TCALL.C) it does not set IN_ERROR_RECOVERY.  symbols.tsv knows the exported
   entry as REQUIRE_TOKEN_ELSE_ERROR; this file holds its body. */

#include "DATA.H"
extern void far ADVANCE_TOKEN(void);
extern void far REPORT_CURRENT_TOKEN(int error);

/* Parameters: context is the expected token; error is the message number
   to report if the current token is something else.  The token is not
   skipped on error. */
static void far pascal REQUIRE_TOKEN_BODY(unsigned int context, int error)
{
    if (CURRENT_TOKEN == context)
        ADVANCE_TOKEN();
    else
        REPORT_CURRENT_TOKEN(error);
}
