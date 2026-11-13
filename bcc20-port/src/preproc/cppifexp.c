/* cppifexp.c: from bcc20/src/preproc/CPPIFEXP.C: the C++ front end's #if evaluator and
   #pragma startup/exit lookup, reached through function pointers (EVAL_EXPRESSION,
   PRAGMA_FUNC_LOOKUP_HOOK). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"

#define TOKEN_SIZE 19
#define TOKEN_CONST_VALUE SD(TOKEN_CONST_VALUE_P)

/* 1 with the value in TOKEN_CONST_VALUE if the expression, converted to long, folds to a
   constant (an EOP_CONST node, its long value at offset 10); else "constant expression
   required" and 0.  Token recording is off while the directive is read, so its tokens
   never enter a token stream. */
i16 EVAL_CONSTANT_CONDITION(void)
{
    u8 saved[TOKEN_SIZE];
    u8 saved_mode = RECORDING_TOKENS;
    MACRO_MODE = 1;
    LEX_NEXT_TOKEN();
    for (int i = 0; i < TOKEN_SIZE; i++) {
        saved[i] = B(fp_add(CURRENT_TOKEN_RECORD_P, i));
        B(fp_add(CURRENT_TOKEN_RECORD_P, i)) = B(fp_add(TOKEN_TYPE_P, i));
    }
    RECORDING_TOKENS = 0;
    CURRENT_TOKEN = W(CURRENT_TOKEN_RECORD_P);
    W(TOKEN_TYPE_P) = 0x82;
    u16 expression = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(PARSE_ASSIGNMENT_EXPR(10), LONG_TYPE), 0);
    MACRO_MODE = 0;
    for (int i = 0; i < TOKEN_SIZE; i++)
        B(fp_add(CURRENT_TOKEN_RECORD_P, i)) = saved[i];
    CURRENT_TOKEN = W(CURRENT_TOKEN_RECORD_P);
    RECORDING_TOKENS = saved_mode;
    if (AT_W(EXPR_POOL_SEG, expression) == 2) {
        TOKEN_CONST_VALUE = AT_L(EXPR_POOL_SEG, expression + 10);
        FREE_EXPR_TREE(expression);
        return 1;
    }
    REPORT_ERROR(MSG_CONSTANT_EXPRESSION);
    FREE_EXPR_TREE(expression);
    return 0;
}

/* the name in NAME_BUFFER: FFFFh if undefined (reported), the prepared symbol if it is a
   function (TK_FUNCTION) taking no parameters (any function with allow_parameters), else 0 */
u16 FIND_NAMED_FUNCTION_PREPARED(u16 allow_parameters)
{
    u16 symbol = LOOKUP_NAME(BCC_SYMBOL_CREATE(NAME_BUFFER_P, 0));
    if (!symbol) {
        REPORT_PRAGMA_ERROR(MSG_UNDEFINED_SYMBOL, NAME_BUFFER_P);
        return 0xFFFF;
    }
    u16 type = AT_W(SYMBOL_POOL_SEG, symbol + 4);
    if (AT_W(TYPE_POOL, type) == 0x12 && (allow_parameters || !AT_W(TYPE_POOL, type + 9)))
        return PREPARE_SYMBOL(symbol);
    return 0;
}
