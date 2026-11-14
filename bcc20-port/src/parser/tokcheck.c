/* tokcheck.c: from bcc20/src/parser/TCHECK.C, TASSERT.C, TYPSTART.C and TCALL.C: the
   parser's small token helpers, one source file each in the original (each reached through
   an overlay stub under another name: REQUIRE_TOKEN_ELSE_ERROR, BCC_TREE_ASSERT,
   TOKEN_IS_TYPE_START, EXPECT_TOKEN_ELSE_REPORT).  The port keeps them together and calls
   them by their definitions' names. */
#include "port.h"
#include "data.h"
#include "msg.h"
#include "token.h"
#include "protos.h"

/* TCHECK.C: the current token consumed if it is the expected one (context), else error
   reported against it; the token is not skipped on error */
void REQUIRE_TOKEN_BODY(u16 context, i16 error)
{
    if (CURRENT_TOKEN == context)
        ADVANCE_TOKEN();
    else
        REPORT_CURRENT_TOKEN(error);
}

/* TASSERT.C: a list separator: a comma consumed; unless context (the token that closes
   the list, left for the caller) is current, ", expected" reported */
void TREE_ASSERT(u16 context)
{
    if (CURRENT_TOKEN == TOK_COMMA)
        ADVANCE_TOKEN();
    else if (CURRENT_TOKEN != context)
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
}

/* TYPSTART.C: nonzero if the token record starts a type name: an identifier (49) whose
   name (the record's word at offset 9) TYPE_LOOKUP finds as a type, a type keyword
   (TYPE_FLAGS bit 8), or in C++ '~' (43, a destructor name).  The last test is a bitwise &
   of the flag and the comparison, as in the original */
i16 TOKEN_IS_TYPE_START_BODY(farptr node)
{
    u16 token = W(node);
    if (token == 49)
        return TYPE_LOOKUP(W(fp_add(node, 9))) != 0;
    return (TYPE_FLAGS_AT(token) & 8) || (CPP_MODE & (token == 43));
}

/* TCALL.C: as REQUIRE_TOKEN_BODY, but the message (first) has a far pointer argument
   given as its high (second) and low (third) words, and an error starts error recovery */
void TREE_INVOKE(u16 context, u16 first, u16 second, u16 third)
{
    if (CURRENT_TOKEN == context)
        ADVANCE_TOKEN();
    else {
        REPORT_DIAGNOSTIC((i16)first, (i32)((u32)second << 16 | third), 0);
        IN_ERROR_RECOVERY = 1;
    }
}
