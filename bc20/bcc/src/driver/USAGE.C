/* target: CODE_1_R4F8 */
/* opts: -mm -G -O -Z -p */
/* Role: driver: PRINT_USAGE_AND_EXIT writes the "Syntax is: BCC [options]" usage text to
   stdout and terminates the program. Map of all sources: docs/SOURCE-MAP.md. */
/* context: RPUTS.C */
/* context-call: 0x8 WRITE_STDOUT_STRING RPUTS_BODY */
#include "DATA.H"
/* Overview: called from RMAIN13C when BCC is started with no arguments. It prints the
   long usage text that begins "Syntax is: BCC [ options ] file[s]" (one string,
   STR_SYNTAX_IS_BCC_OPTIONS) and ends the program with exit status 0 through
   C0_TERMINATE. Nothing else in BCC calls it. */
#pragma option -G-
extern void far cdecl C0_TERMINATE(int status);
static void far pascal PRINT_USAGE_AND_EXIT(void)
{
    WRITE_STDOUT_STRING(STR_SYNTAX_IS_BCC_OPTIONS);
    C0_TERMINATE(0);
}
