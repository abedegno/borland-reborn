/* target: ovr129_C224UNIT */
/* Role: preprocessor (C mode): #if expression parsing hook, and looking up the function
   named in #pragma startup/exit. Entry points: PARSE_PP_IF_EXPRESSION, FIND_NAMED_FUNCTION.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO048 (ovr_1cff_95a9) as one source. */
/* opts: -mm -O -Z -p -Y -y */
/* Overview: the C front end's counterparts of CPPIFEXP.C, two small
   functions the preprocessor reaches through function pointers.
   PARSE_PP_IF_EXPRESSION parses the expression of an #if with the C
   front end's constant-expression parser; FIND_NAMED_FUNCTION looks up the
   function named in #pragma startup or #pragma exit among the C symbols
   (scope C_DECL_SCOPE). */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- STOVR1 (listing ovr_1cff_95a9:5A90) ---- */
extern unsigned int far pascal PARSE_CONSTANT_EXPR(unsigned int);
/* Parses an #if expression; 5 is probably the expected type, TK_INT.
   Declared void, but it probably serves as the int-returning
   EVAL_EXPRESSION hook: PARSE_CONSTANT_EXPR's result is left in AX for the
   caller. */
void far pascal PARSE_PP_IF_EXPRESSION(void)
{
    PARSE_CONSTANT_EXPR(5);
}

/* ---- STOVR2 (listing ovr_1cff_95a9:5A9E) ---- */
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
extern unsigned int far pascal LOOKUP_SYMBOL(unsigned int,unsigned int,unsigned char);
extern void far pascal REPORT_PRAGMA_ERROR(unsigned int,char far *);
/* Looks up the name in NAME_BUFFER.  Returns 0xFFFF if it is undefined
   (reported), the symbol if it is a function (kind 18, TK_FUNCTION) and
   either required is nonzero or the word at offset 5 of its type is
   nonzero, else 0.  Offset 5 is TYPE_C_PARAMS, the parameter list in the C
   front end's type layout (why a
   nonempty list is wanted, the opposite of the C++ version, is not clear
   from this code; probably "()" and "(void)" are stored differently).  The _AX lines reproduce the original's register use:
   on the failing paths AX holds 0 (on the second one, probably the zero
   word just tested). */
unsigned int far pascal FIND_NAMED_FUNCTION(unsigned int required)
{
    register unsigned int node=LOOKUP_SYMBOL(BCC_SYMBOL_CREATE(NAME_BUFFER,0),C_DECL_SCOPE,0);
    if(!node) {
        REPORT_PRAGMA_ERROR(MSG_UNDEFINED_SYMBOL,NAME_BUFFER);
        return 0xFFFF;
    }
    if(TYPE_B(CSYM_W(node,CSYM_TYPE),TYPE_KIND)==18) {
        if(required!=0 || TYPE_W(CSYM_W(node,CSYM_TYPE),TYPE_C_PARAMS)!=0) return node;
    } else _AX=0;
    /* The original guard-only path retains the full node result in AX. */
    return _AX;
}
