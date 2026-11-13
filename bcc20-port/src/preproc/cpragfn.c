/* cpragfn.c: from bcc20/src/preproc/CPRAGFN.C: the C front end's #if evaluator and
   #pragma startup/exit lookup, reached through function pointers. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"

/* the #if expression, parsed by the C front end's constant-expression parser (5 is
   probably the expected type, TK_INT).  The original is declared void and leaves
   PARSE_CONSTANT_EXPR's result in AX for its caller through EVAL_EXPRESSION; the port
   returns it (genadapters.py, RETURN_OVERRIDES). */
i16 PARSE_PP_IF_EXPRESSION(void)
{
    return (i16)PARSE_CONSTANT_EXPR(5);
}

/* the function named in #pragma startup or exit, among the C symbols (C_DECL_SCOPE):
   FFFFh if undefined (reported), else the symbol if it is a function, 0 if not.  The
   original also tests "required or it has a parameter list", but on the path where that
   fails it returns what is left in AX, which is the symbol: the test changes nothing
   (probably a bug: a function with parameters was meant to be refused; replay shows the
   symbol returned). */
u16 FIND_NAMED_FUNCTION(u16 required)
{
    (void)required;
    u16 node = LOOKUP_SYMBOL(BCC_SYMBOL_CREATE(NAME_BUFFER_P, 0), C_DECL_SCOPE, 0);
    if (!node) {
        REPORT_PRAGMA_ERROR(MSG_UNDEFINED_SYMBOL, NAME_BUFFER_P);
        return 0xFFFF;
    }
    return TYPE_B(CSYM_W(node, CSYM_TYPE), TYPE_KIND) == 18 ? node : 0;
}
