/* target: UNARYOP */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module UNARYOP (image 0x3FF6..0x4314, frame 03FFh): source taken from the
   BCC.EXE reconstruction (bcc20/src/expr/UNARYOP.C). CPP.EXE has only
   some of its functions, in the same order; left out here: BUILD_DEREF, C6PRED, C6KIND,
   BUILD_ADDRESS_OF, BUILD_INCDEC.  C6PRE and BUILD_LOGICAL_NOT have no C++-mode code in
   CPP.EXE (marked "CPP.EXE edit"); C6PRE keeps its unused context and operation
   parameters, which its callers still pass. */
/* Role: unary-operator expression builders for #if expressions. Entry points:
   BUILD_UNARY_ARITH, BUILD_COMPLEMENT, BUILD_LOGICAL_NOT. */
/* Overview: semantic analysis of the unary operators that can appear in an #if
   expression: unary + and -, ~ and !. The expression analyser (expr/EXPRDISP.C) calls
   the BUILD_* function for a node whose operand has not been analysed yet; each one
   analyses the operand, checks it, sets the node's result type and marks it analysed
   (EXPR_NODE_FLAGS bit 1), or replaces the node by an error node through
   REPORT_EXPR_ERROR_PLAIN (message 0 when the operand already carried an error).
   C6PRE is the common first step. Its "operation" argument is an EXPR_FLAGS mask of
   the operand types the operator accepts (3 arithmetic, 1 integral, 7 scalar); in BCC
   it was handed on to the C++ user-defined conversion search. "hint" is the type the
   result is wanted in, if known. BCC's version also built *p, &x and ++/--, and in C++
   mode looked for overloaded operators; CPP.EXE has none of that. INT_TYPE is the int
   type. */
#include <dos.h>
#include "BUILD6.H"
#include "MSG.H"
#include "POOL.H"

/* C6PRE: analyses and converts to an rvalue the operand of the unary node *output
   (hint: wanted type, VOID_TYPE treated as none), rejects error and void operands, tries
   (in BCC) a user-defined operator or conversion in C++, and turns an enum operand into int.
   Returns 1 when *output has been replaced (error node or operator call) and the caller
   must return it as it is; 0 to continue. */
static unsigned char near pascal C6PRE(unsigned int far *output,
    unsigned int context,register unsigned int hint,unsigned int operation)
{
    register unsigned int node=*output;

    if(hint==VOID_TYPE)
        hint=0;
    EXPR_W(node,EXPR_LEFT)=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),hint,0));
    if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==0) {
        *output=REPORT_EXPR_ERROR_PLAIN(0,*output);
        return 1;
    }
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_VOID) {
        *output=REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,*output);
        return 1;
    }
    /* CPP.EXE edit: BCC's C++-mode block (TRY_UNARY_OPERATOR_CALL, then
       APPLY_CONVERSION_FUNCTION for a class operand) is absent; CPP.EXE's code goes from
       the void check straight to NODE_ENUM_TO_INT (image 0x406E). */
    EXPR_W(node,EXPR_LEFT)=NODE_ENUM_TO_INT(EXPR_W(*output,EXPR_LEFT));
    return 0;
}





#include "TAIL6.H"


/* BUILD_UNARY_ARITH: analyses unary + and -: the operand must be arithmetic. A small
   integer operand is promoted to int unless the wanted type (hint) is itself smaller
   than int and the operand is signed, probably so char arithmetic can stay narrow. */
unsigned int far pascal BUILD_UNARY_ARITH(unsigned int expression,unsigned int context,
    register unsigned int hint)
{
    register unsigned int node;

    if(C6PRE(&expression,context,hint,3))
        return expression;
    node=EXPR_W(expression,EXPR_LEFT);
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&3))
        return REPORT_EXPR_ERROR_PLAIN((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x40)?MSG_ILLEGAL_STRUCTURE:MSG_EXPRESSION_ARITHMETIC,expression);
    if(TYPE_SIZE(EXPR_W(node,EXPR_TYPE))<(long)INT_TYPE_SIZE &&
            ((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x20) ||
             !hint || TYPE_SIZE(hint)>=(long)INT_TYPE_SIZE)) {
        EXPR_W(expression,EXPR_LEFT)=node=CONVERT_EXPR_TO_TYPE(INT_TYPE,node,0);
    }
    EXPR_W(expression,EXPR_TYPE)=EXPR_W(node,EXPR_TYPE);
    return expression;
}

/* BUILD_COMPLEMENT: analyses ~x: the operand must be integral; it is widened to the
   wanted integer type (hint, default int) when that is larger. */
unsigned int far pascal BUILD_COMPLEMENT(unsigned int expression,unsigned int context,
    register unsigned int hint)
{
    if(!hint || !(EXPR_FLAGS[TYPE_W(hint,TYPE_KIND)]&1))
        hint=INT_TYPE;
    if(C6PRE(&expression,context,hint,1))
        return expression;
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&1))
        return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_INTEGRAL,expression);
    if(TYPE_SIZE(hint)>TYPE_SIZE(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE)))
        EXPR_W(expression,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(hint,EXPR_W(expression,EXPR_LEFT),0);
    EXPR_W(expression,EXPR_TYPE)=EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE);
    return expression;
}

/* BUILD_LOGICAL_NOT: analyses !x: the operand must be scalar (in BCC's C++ mode a class
   may convert to one); operands smaller than int get a cast to int, and the result is int. */
unsigned int far pascal BUILD_LOGICAL_NOT(unsigned int expression,unsigned int context)
{
    if(C6PRE(&expression,context,CHAR_TYPE,7))
        return expression;
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&7))
        return REPORT_EXPR_ERROR_PLAIN((EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x40)?MSG_ILLEGAL_STRUCTURE:MSG_EXPRESSION_SCALAR_TYPE,expression);
    /* CPP.EXE edit: BCC's C++-mode CONVERT_CLASS_TO_SCALAR call is absent (CPP image 0x42AB
       goes from the scalar check to the TK_INT test). */
    if((int)TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)<TK_INT &&
            TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)!=TK_UNDEFINED) {
        EXPR_W(expression,EXPR_LEFT)=MAKE_CAST_NODE(INT_TYPE,EXPR_W(expression,EXPR_LEFT));
        EXPR_B(EXPR_W(expression,EXPR_LEFT),EXPR_NODE_FLAGS)|=1;
    }
    EXPR_W(expression,EXPR_TYPE)=INT_TYPE;
    return expression;
}
