/* target: ovr080_C24UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: preprocessor (C++ mode): evaluates a #if constant condition, and looks up the
   function named in #pragma startup/exit. Entry points: EVAL_CONSTANT_CONDITION,
   FIND_NAMED_FUNCTION_PREPARED. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: two services the C++ front end provides to the preprocessor.
   EVAL_CONSTANT_CONDITION evaluates the expression of an #if or #elif with
   the compiler's own expression parser (PARSE_ASSIGNMENT_EXPR), so #if
   accepts what a constant expression in the language accepts; with
   MACRO_MODE set the lexer returns token 10 at the end of the directive
   line, which ends the expression.  The parser's token state is saved
   around it, because a directive can occur while the parser holds a
   lookahead token.  FIND_NAMED_FUNCTION_PREPARED looks up the function
   named in #pragma startup or #pragma exit.  The C front end has its own
   versions in CPRAGFN.C; PREPROC.C reaches the right one through function
   pointers (EVAL_EXPRESSION, PRAGMA_FUNC_LOOKUP_HOOK).  The E, EL, S and T
   macros read words and longs of expression, symbol and type records at
   raw offsets. */
#include <dos.h>
#include "CPPIFEXP.H"
#include "MSG.H"
#include "POOL.H"
#define E(n,o) AT_W(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define EL(n,o) AT_L(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))

/* 0000: full token snapshots; restore parser mode before testing the result. */
/* Returns 1 with the value in TOKEN_CONST_VALUE if the expression folds to a
   constant (an EOP_CONST node, whose long value is at offset 10), else
   reports "constant expression required" and returns 0.  The expression is
   converted to long first.  Recording of tokens is switched off while the
   directive is read, so directive tokens never enter a token stream. */
int far pascal EVAL_CONSTANT_CONDITION(void)
{
    unsigned char saved_mode;
    struct C24Token saved;
    register unsigned int expression;
    saved_mode=RECORDING_TOKENS;
    MACRO_MODE=1;
    LEX_NEXT_TOKEN();
    saved=CURRENT_TOKEN_RECORD;
    CURRENT_TOKEN_RECORD=TOKEN_TYPE;
    RECORDING_TOKENS=0;
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    TOKEN_TYPE.kind=0x82;
    expression=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(PARSE_ASSIGNMENT_EXPR(10),LONG_TYPE),0);
    MACRO_MODE=0;
    CURRENT_TOKEN_RECORD=saved;
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    RECORDING_TOKENS=saved_mode;
    if(E(expression,0)==2) {
        TOKEN_CONST_VALUE=EL(expression,10);
        FREE_EXPR_TREE(expression);
        return 1;
    }
    REPORT_ERROR(MSG_CONSTANT_EXPRESSION);
    FREE_EXPR_TREE(expression);
    return 0;
}

/* 00C8: missing symbol returns FFFF, valid function returns prepared handle. */
/* Looks up the name in NAME_BUFFER.  Returns 0xFFFF if it is undefined
   (reported), the prepared symbol if it is a function (TK_FUNCTION) that
   takes no parameters (or any function if allow_parameters), else 0. */
unsigned int far pascal FIND_NAMED_FUNCTION_PREPARED(unsigned int allow_parameters)
{
    register unsigned int symbol;
    symbol=LOOKUP_NAME(BCC_SYMBOL_CREATE(NAME_BUFFER,0));
    if(!symbol) {
        REPORT_PRAGMA_ERROR(MSG_UNDEFINED_SYMBOL,NAME_BUFFER);
        return 0xFFFF;
    }
    if(T(S(symbol,4),0)==0x12 &&
       (allow_parameters || !T(S(symbol,4),9)))
        return PREPARE_SYMBOL(symbol);
    return 0;
}
