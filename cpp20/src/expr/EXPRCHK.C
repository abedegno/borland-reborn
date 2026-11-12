/* target: EXPRCHK */
/* CPP.EXE module EXPRCHK (image 0x3A61..0x3FF6, frame 03A6h): source taken from the
   BCC.EXE reconstruction (bcc20/src/expr/EXPRCHK.C). CPP.EXE has only
   some of its functions, in the same order; left out here: SCALE_BY_ELEMENT_SIZE,
   SCALE_POINTER_OPERAND, ELIDE_COPY_ASSIGN, CHECK_ASSIGNMENT, CHECK_INITIALIZATION,
   CHECK_COMPOUND_ASSIGNMENT, CHECK_RETURN_VALUE, CHECK_SUBSCRIPT, BUILD_MEMBER_ACCESS,
   CHECK_DOT_MEMBER, CHECK_POINTER_INDIRECTION (their declarations are left under
   section marks). CPP.EXE's versions of PREPARE_BINARY_OPERANDS, CHECK_ADDITION,
   CHECK_SUBTRACTION, CHECK_LOGICAL_OP and CHECK_COMPARISON have no C++ and no pointer
   cases (marked "CPP.EXE edit"): the #if evaluator needs only integers. */
/* Role: semantic checks of binary operators in #if expressions. Entry points:
   CHECK_MULTIPLICATIVE_OP, CHECK_INTEGRAL_OP, CHECK_ADDITION, CHECK_SUBTRACTION,
   CHECK_LOGICAL_OP, CHECK_COMPARISON. */
/* opts: -mm -O -Z -p -y */
/* Overview: the checkers for binary operators. ANALYZE_EXPRESSION (expr/EXPRDISP.C)
   calls the CHECK_* function for a node; it analyses both operands, converts them, sets
   the node's type, and returns the node, a rewritten tree or an error node
   (REPORT_EXPR_ERROR_PLAIN; message 0 means "already reported").
   PREPARE_BINARY_OPERANDS is the common first step for most binary operators. Its
   parameters, and those of the checkers that pass them on, do not mean what their names
   say: "mode" is ANALYZE_EXPRESSION's context argument passed through, "scope" (and
   "type" or "kind" in some checkers) is the wanted result type, and "mask" (or "hint")
   is the EXPR_FLAGS mask of operand types the operator accepts: 1 integral, 3
   arithmetic, 7 scalar, 0x17 scalar or pointer (EXPR_FLAGS: 1 integral, 2 floating, 4
   and 0x10 pointer kinds, 0x40 struct/union, 0x20 unsigned).
   BCC's version of this file also made pointer arithmetic explicit, checked
   assignments, initialisation, return values, subscripts and member selection, and in
   C++ mode tried user-defined operators first; none of that is in CPP.EXE.
   INT_TYPE is the int type; NOT_ANSI_FLAG is set when not in strict ANSI mode. The
   section marks ("---- name (CPP frame:offset) ----") give each function's address in
   CPP.EXE. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- (BCC's SCALE_BY_ELEMENT_SIZE: not in CPP.EXE) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal USUAL_ARITHMETIC_CONVERSIONS(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
struct Triple { unsigned int word[3]; };
#define T(n,o) (*(struct Triple far *)MK_FP(EXPR_POOL_SEG,(n)+(o)))

#undef T

/* ---- CHECK_OPERAND_KINDS (CPP 03A6:0001) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern void far pascal REPORT_DIAGNOSTIC_AT(int,char far *,char far *,unsigned int,unsigned int);

/* CHECK_OPERAND_KINDS: 1 when both operand types of node are in the EXPR_FLAGS mask;
   otherwise reports, for each bad operand, "illegal use of pointer" (19), "illegal use
   of floating point" (47) or message 106 (no MSG.H name) and returns 0. */
static unsigned char near pascal CHECK_OPERAND_KINDS(unsigned int node,unsigned int mask)
{
    int code;
    register unsigned int left;
    register unsigned int right;

    left=TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND);
    right=TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND);
    if((EXPR_FLAGS[left]&mask) && (EXPR_FLAGS[right]&mask))
        return 1;
    if(!(EXPR_FLAGS[left]&mask)) {
        code=(EXPR_FLAGS[left]&0x14)?0x13:(EXPR_FLAGS[left]&2)?0x2F:0x6A;
        REPORT_DIAGNOSTIC_AT(code,(char far *)0,(char far *)0,EXPR_W(node,EXPR_SRC_LINE),0);
    }
    if(!(EXPR_FLAGS[right]&mask)) {
        code=(EXPR_FLAGS[right]&0x14)?0x13:(EXPR_FLAGS[right]&2)?0x2F:0x6A;
        REPORT_DIAGNOSTIC_AT(code,(char far *)0,(char far *)0,EXPR_W(node,EXPR_SRC_LINE),0);
    }
    return 0;
}

/* ---- PREPARE_BINARY_OPERANDS (CPP 03A6:00E3) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
extern unsigned int far pascal APPLY_CONVERSION_FUNCTION(unsigned int,unsigned int,unsigned int);

/* PREPARE_BINARY_OPERANDS: analyses both operands of *output as rvalues with enums made
   int, and gives the node the left operand's type for now. Returns 1 (with *output
   replaced) when an operand is in error or void, or when an operand fails the mask
   (BCC also when a C++ operator function was called instead); 0 to go on. */
static unsigned char near pascal PREPARE_BINARY_OPERANDS(unsigned int far *output,unsigned int mode,unsigned int scope,unsigned int mask)
{
    register unsigned int node;

    node=*output;
    if(scope==VOID_TYPE)
        scope=0;
    EXPR_W(node,EXPR_LEFT)=NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),scope,0)));
    EXPR_W(node,EXPR_RIGHT)=NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),scope,0)));
    EXPR_W(node,EXPR_TYPE)=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_UNDEFINED || TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)==TK_UNDEFINED) {
        *output=REPORT_EXPR_ERROR_PLAIN(0,node);
        return 1;
    }
    /* CPP.EXE edit: BCC's C++-mode block (TRY_BINARY_OPERATOR_CALL and conversion
       functions) is absent. */
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_VOID || TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)==TK_VOID) {
        *output=REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
        return 1;
    }
    if(!CHECK_OPERAND_KINDS(node,mask)) {
        *output=REPORT_EXPR_ERROR_PLAIN(0,node);
        return 1;
    }
    *output=node;
    return 0;
}

/* ---- (BCC's SCALE_POINTER_OPERAND: not in CPP.EXE) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);


/* ---- (BCC's ELIDE_COPY_ASSIGN: not in CPP.EXE) ---- */
#include <dos.h>
extern unsigned char far pascal EXPRESSIONS_EQUAL(unsigned int,unsigned int,unsigned char);
extern void far pascal FREE_EXPR_TREE(unsigned int);


/* ---- (BCC's CHECK_ASSIGNMENT: not in CPP.EXE) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal IS_MODIFIABLE_NODE(unsigned int);
extern unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal REWRITE_FOR_REFERENCE_BIND(unsigned int);
extern unsigned char far pascal IS_LVALUE(unsigned int);
extern unsigned int far pascal NULL_CONSTANT_TO_POINTER(unsigned int,unsigned int);
extern unsigned int far pascal CHECK_CPP_ASSIGNMENT(unsigned int);
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
extern char far * far pascal FORMAT_TYPE(unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,char far *,char far *,unsigned int);
unsigned char far pascal ELIDE_COPY_ASSIGN(unsigned int far *output);


/* ---- (BCC's CHECK_INITIALIZATION: not in CPP.EXE) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,char far *,char far *,unsigned int);
extern unsigned int far pascal DECAY_TO_POINTER(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NULL_CONSTANT_TO_POINTER(unsigned int,unsigned int);
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
extern char far * far pascal FORMAT_TYPE(unsigned int);
extern unsigned int far pascal CHECK_CPP_INITIALIZATION(unsigned int);
unsigned char far pascal ELIDE_COPY_ASSIGN(unsigned int far *);


/* ---- (BCC's CHECK_COMPOUND_ASSIGNMENT: not in CPP.EXE) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far *BCC_TYPE_PTR;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned char far pascal IS_LVALUE(unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,char far *,char far *,unsigned int);
extern void far pascal SAVE_EXPR_IN_TEMP(unsigned int far *,unsigned int far *);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal PICK_WIDER_TYPE(unsigned int,unsigned int);
extern unsigned char far pascal IS_MODIFIABLE_NODE(unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
extern unsigned int far pascal APPLY_CONVERSION_FUNCTION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REWRITE_FOR_REFERENCE_BIND(unsigned int);
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
extern char far * far pascal FORMAT_TYPE(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC_AT(int,char far *,char far *,unsigned int,unsigned int);
#define TK(n) (*(int far *)MK_FP(TYPE_POOL,(n)))

#undef TK

/* ---- (BCC's CHECK_RETURN_VALUE: not in CPP.EXE) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NULL_CONSTANT_TO_POINTER(unsigned int,unsigned int);
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal CHECK_CPP_RETURN_VALUE(unsigned int,unsigned int);
unsigned char far pascal ELIDE_COPY_ASSIGN(unsigned int far *);


/* ---- CHECK_MULTIPLICATIVE_OP (CPP 03A6:01D4) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal USUAL_ARITHMETIC_CONVERSIONS(unsigned int,unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
#define TK(n) (*(int far *)MK_FP(TYPE_POOL,(n)))
#define KIND(n) TYPE_W(EXPR_W(n,EXPR_TYPE),TYPE_KIND)

/* CHECK_MULTIPLICATIVE_OP: analyses * / % & | ^ (hint 3 for * and /, 1 for the integer
   ones): usual arithmetic conversions toward the wanted type, which is at least int for
   * / %; non-arithmetic operands must be of compatible type, else MSG_OPERANDS_ARE_DIFFERING. */
unsigned int far pascal CHECK_MULTIPLICATIVE_OP(unsigned int node,unsigned int mode,
    register unsigned int type,unsigned int hint)
{
    if(PREPARE_BINARY_OPERANDS(&node,mode,type,hint))
        return node;
    if((EXPR_W(node,EXPR_OP)==EOP_MOD || EXPR_W(node,EXPR_OP)==EOP_DIV || EXPR_W(node,EXPR_OP)==EOP_MUL) && TK(type)<5)
        type=INT_TYPE;
    if(((EXPR_FLAGS[KIND(EXPR_W(node,EXPR_LEFT))]&3) || (EXPR_FLAGS[KIND(EXPR_W(node,EXPR_LEFT))]&0x40)) &&
       ((EXPR_FLAGS[KIND(EXPR_W(node,EXPR_RIGHT))]&3) || (EXPR_FLAGS[KIND(EXPR_W(node,EXPR_RIGHT))]&0x40))) {
        node=USUAL_ARITHMETIC_CONVERSIONS(type,node);
        return node;
    }
    if(TYPES_COMPATIBLE(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),1))
        return node;
    return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING,node);
}
#undef TK
#undef KIND

/* ---- CHECK_INTEGRAL_OP (CPP 03A6:02D9) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ENUM_UNDERLYING_TYPE(unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);

/* CHECK_INTEGRAL_OP: analyses << and >>: the left operand is promoted (to int or
   unsigned int) and gives the result type; the count is converted to BCC_TYPE_PTR[2]
   (unsigned char). */
unsigned int far pascal CHECK_INTEGRAL_OP(unsigned int node,unsigned int mode)
{
    unsigned int type;
    unsigned int child;

    if(PREPARE_BINARY_OPERANDS(&node,mode,0,1)) return node;
    child=EXPR_W(node,EXPR_LEFT);
    if(EXPR_W(child,EXPR_OP)!=0) {
        type=EXPR_W(child,EXPR_TYPE)=ENUM_UNDERLYING_TYPE(EXPR_W(child,EXPR_TYPE));
        if(TYPE_I(type,TYPE_KIND)<TK_USHORT)
            type=INT_TYPE;
        else if(TYPE_I(type,TYPE_KIND)==TK_USHORT)
            type=UNSIGNED_INT_TYPE;
        EXPR_W(node,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(type,child,0);
        EXPR_W(node,EXPR_TYPE)=type;
    }
    if(EXPR_W(node,EXPR_RIGHT)!=0)
        EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(BCC_TYPE_PTR[2],EXPR_W(node,EXPR_RIGHT),0);
    return node;
}

/* ---- (BCC's CHECK_SUBSCRIPT: not in CPP.EXE) ---- */
unsigned int far pascal CHECK_ADDITION(unsigned int node,unsigned int mode,unsigned int kind);
#include <dos.h>
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
unsigned int far pascal CHECK_ADDITION(unsigned int,unsigned int,unsigned int);


/* ---- (BCC's BUILD_MEMBER_ACCESS: not in CPP.EXE) ---- */
#include <dos.h>
struct C21Location { unsigned int first,second,third; };
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal FIND_MEMBER_BY_NAME(unsigned int,unsigned int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern char far * far pascal FORMAT_TYPE(unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,char far *,char far *,unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned int far pascal MAKE_MEMBER_NODE(unsigned int,struct C21Location);
extern unsigned int far pascal ADD_CV_QUALIFIERS(unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
#define LOCATION(n) (*(struct C21Location far *)MK_FP(EXPR_POOL_SEG,(n)+20))

#undef LOCATION

/* ---- (BCC's CHECK_DOT_MEMBER: not in CPP.EXE) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal ANALYZE_MEMBER_SELECT(unsigned int,unsigned char);


/* ---- (BCC's CHECK_POINTER_INDIRECTION: not in CPP.EXE) ---- */
#include <dos.h>
#include "EXPRC4.H"


/* ---- CHECK_ADDITION (CPP 03A6:038F) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal SWAP_OPERANDS(unsigned int);
extern unsigned int far pascal USUAL_ARITHMETIC_CONVERSIONS(unsigned int,unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
#define VOID_POINTER(t) ((EXPR_FLAGS[TYPE_W(t,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(t,TYPE_TARGET),TYPE_KIND)==TK_VOID)

/* CHECK_ADDITION: analyses a + b; "kind" is the wanted type. A pointer operand is moved
   to the left. Arithmetic: usual conversions. (BCC's version also scaled pointer +
   integer and allowed _seg pointer + near pointer; see the CPP.EXE edit below.) */
unsigned int far pascal CHECK_ADDITION(unsigned int node,unsigned int mode,unsigned int kind)
{
    unsigned int left_type; /* CPP.EXE edit: not register (BCC: register, with right_type
                               and temporary); CPP.EXE keeps kind in SI, left_type in DI */

    if(PREPARE_BINARY_OPERANDS(&node,mode,kind,0x17)) return node;
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)!=TK_SEG_PTR && (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&0x14))
        node=SWAP_OPERANDS(node);
    left_type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    if(!(EXPR_FLAGS[TYPE_W(left_type,TYPE_KIND)]&0x14))
        return USUAL_ARITHMETIC_CONVERSIONS(kind,node);
    /* CPP.EXE edit: the pointer cases are absent (CPP image 0x3E7B returns node when the left
       operand is a pointer): no SCALE_POINTER_OPERAND, no _seg + near pointer. */
    return node;
}
#undef VOID_POINTER

/* ---- CHECK_SUBTRACTION (CPP 03A6:0423) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal BALANCE_BINARY_OPERANDS(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal USUAL_ARITHMETIC_CONVERSIONS(unsigned int,unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);


/* CHECK_SUBTRACTION: analyses a - b; "type" is the wanted type: usual conversions. (BCC's
   version also handled pointer - pointer and pointer - integer.) */
unsigned int far pascal CHECK_SUBTRACTION(unsigned int node,unsigned int mode,unsigned int type)
{
    if(PREPARE_BINARY_OPERANDS(&node,mode,type,7)) return node;
    /* CPP.EXE edit: the pointer - pointer and pointer - integer cases are absent; CPP.EXE
       (CPP image 0x3E83) goes from PREPARE_BINARY_OPERANDS straight to the usual conversions. */
    return USUAL_ARITHMETIC_CONVERSIONS(type,node);
}

/* ---- CHECK_LOGICAL_OP (CPP 03A6:0451) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_CLASS_TO_SCALAR(unsigned int);
extern unsigned int far pascal APPEND_TEMP_DESTRUCTORS(unsigned int,unsigned int);

/* CHECK_LOGICAL_OP: analyses && and ||: both operands scalar, result int. (In BCC's C++
   mode the temporaries made by the right operand were destroyed inside it.) */
unsigned int far pascal CHECK_LOGICAL_OP(unsigned int node,unsigned int mode)
{
    unsigned int saved;

    EXPR_W(node,EXPR_LEFT)=NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0)));
    saved=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    EXPR_W(node,EXPR_RIGHT)=NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),0,0)));
    EXPR_W(node,EXPR_TYPE)=INT_TYPE;
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_UNDEFINED || TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)==TK_UNDEFINED)
        return REPORT_EXPR_ERROR_PLAIN(0,node);
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_VOID || TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    /* CPP.EXE edit: BCC's C++-mode block is absent; saved is read above but not used. */
    if(!CHECK_OPERAND_KINDS(node,7))
        return REPORT_EXPR_ERROR_PLAIN(0,node);
    EXPR_W(node,EXPR_TYPE)=INT_TYPE;
    return node;
}

/* ---- CHECK_COMPARISON (CPP 03A6:0542) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal BALANCE_BINARY_OPERANDS(unsigned int,unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern void far pascal REPORT_DIAGNOSTIC_AT(int,char far *,char far *,unsigned int,unsigned int);
extern unsigned int far pascal COMPARE_MEMBER_POINTERS(unsigned int);

/* CHECK_COMPARISON: analyses == != < > <= >=: the operands get the usual arithmetic
   conversions with char as wanted type, so byte compares stay possible. (BCC's version
   also compared pointers and member pointers, with their warnings.) */
unsigned int far pascal CHECK_COMPARISON(unsigned int node,unsigned int mode)
{
    unsigned int left;
    unsigned int right;

    if(PREPARE_BINARY_OPERANDS(&node,mode,INT_TYPE,7))
        return node;
    /* CPP.EXE edit: only the arithmetic case is left (CPP image 0x3FA2): left and right are
       still read (into stack slots, not SI/DI, so not register variables here) but not
       used, and the operands go to USUAL_ARITHMETIC_CONVERSIONS (CPP 0431:0238) with char as
       the wanted type instead of BALANCE_BINARY_OPERANDS; no pointer warnings, and the
       node's type is not set to int here. */
    left=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    right=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    return USUAL_ARITHMETIC_CONVERSIONS(CHAR_TYPE,node);
}
