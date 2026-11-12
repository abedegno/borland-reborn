/* target: CPPIFEXP */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module CPPIFEXP (image 0xB39D..0xB465, frame 0B39h): source taken unchanged
   from the BCC.EXE reconstruction (bcc20/src/preproc/CPPIFEXP.C), less
   one function (see the end); the code of the rest is the same in both programs. */
/* Role: preprocessor: evaluates the constant expression of #if and #elif. Entry point:
   EVAL_CONSTANT_CONDITION. */
/* Overview: EVAL_CONSTANT_CONDITION evaluates the expression of an #if or #elif with
   the expression parser (PARSE_ASSIGNMENT_EXPR, OPPREC.C), so #if accepts what a
   constant expression in the language accepts; with MACRO_MODE set the lexer returns
   token 10 at the end of the directive line, which ends the expression. The token
   state is saved around it, because a directive can occur while a lookahead token is
   held. In CPP.EXE PREPROC.C calls it directly; BCC reached it (or the C front end's
   version) through the pointer EVAL_EXPRESSION. The E, EL, S and T macros read words
   and longs of expression, symbol and type records at raw offsets. */
#include <dos.h>
#include "CPPIFEXP.H"
#include "MSG.H"
#include "POOL.H"
#define E(n,o) AT_W(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define EL(n,o) AT_L(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))

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

/* CPP.EXE edit: BCC's FIND_NAMED_FUNCTION_PREPARED (#pragma startup/exit lookup) is not in
   CPP.EXE, whose module ends with EVAL_CONSTANT_CONDITION (the next segment, SIMPLIFY,
   starts right after it at image 0xB465); a preprocessor has no functions to look up. */
