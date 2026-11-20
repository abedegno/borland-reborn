/* target: ovr118_TASSERT */
/* opts: -mm -G- -O -Z -p */
/* Role: parser: accepts a comma separator, or the given closing token, else reports ",
   expected". Map of all sources: docs/SOURCE-MAP.md. */

/* Overview: one small helper used by the list parsers (argument lists,
   declarator lists, initializer lists) to step over the separator between
   items.  It looks only at CURRENT_TOKEN: a comma is consumed; the closing
   token the caller names (for example ')') is left for the caller to
   consume; anything else gets the error MSG_EXPECTED_202 (", expected").
   The function is static but far: it is linked into the CO03D overlay
   group, whose assembly stub (linkgroups/CO03D.ASM, BCC_TREE_ASSERT) is
   what other modules call. */

#include "DATA.H"
#include "MSG.H"
#include "TOKEN.H"
extern void far ADVANCE_TOKEN(void);
extern void far REPORT_CURRENT_TOKEN(int error);

/* The parameter context is the token that closes the list.  Consumes a ',' if present;
   otherwise, unless the closing token is current, reports ", expected"
   against the current token.  The closing token itself is not consumed. */
static void far pascal TREE_ASSERT(unsigned int context)
{
    if (CURRENT_TOKEN == TOK_COMMA)
        ADVANCE_TOKEN();
    else if (CURRENT_TOKEN != context)
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
}
