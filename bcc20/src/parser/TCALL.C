/* target: ovr118_TCALL */
/* opts: -mm -G- -O -Z -p */
/* Role: parser: requires the expected token and advances, otherwise reports a
   three-argument diagnostic and sets an error flag. Map of all sources: docs/SOURCE-MAP.md. */

/* Overview: "expect this token" helper whose failure message takes a
   payload.  If CURRENT_TOKEN is the expected token it is consumed;
   otherwise a diagnostic is reported at the current token and IN_ERROR_RECOVERY
   is set.  IN_ERROR_RECOVERY is the parser's "already in error recovery" flag:
   while it is set REPORT_DIAGNOSTIC_AT (DIAG.C) prints only fatal
   messages, so one syntax error does not cascade into many.  Linked into
   the CO03D overlay group (stub BCC_TREE_INVOKE in linkgroups/CO03D.ASM). */

#include "DATA.H"
extern void far ADVANCE_TOKEN(void);
extern void far REPORT_DIAGNOSTIC(unsigned int first, unsigned int second,
                         unsigned int third, long value);

/* Parameters: context is the expected token, first the message number;
   second and third are probably the high and low words of the message's
   first long argument (they are pushed in that order ahead of a 0L second
   argument), so together they form a far pointer such as a name string. */
static void far pascal TREE_INVOKE(unsigned int context, unsigned int first,
                                   unsigned int second, unsigned int third)
{
    if (CURRENT_TOKEN == context) {
        ADVANCE_TOKEN();
    } else {
        REPORT_DIAGNOSTIC(first, second, third, 0L);
        IN_ERROR_RECOVERY = 1;
    }
}
