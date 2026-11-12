/* target: ovr060_C120UNIT */
/* Role: expression semantic checks (subscripts, pointers, integral operands). Entry points:
   ELIDE_COPY_ASSIGN, CHECK_ASSIGNMENT, CHECK_INITIALIZATION, CHECK_COMPOUND_ASSIGNMENT,
   CHECK_RETURN_VALUE, CHECK_MULTIPLICATIVE_OP, CHECK_INTEGRAL_OP, CHECK_SUBSCRIPT (+6
   more). Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO004 (ovr_1bb7_52dd) 0000..19FF as one source; COMMAEXP (19FF..) is a separate -G source. */
/* opts: -mm -O -Z -p -Y -y */
/* Overview: the checkers for binary operators, assignments, initialisation, return
   values, subscripts and member selection in the C++-mode front end. ANALYZE_EXPRESSION
   (expr/EXPRDISP.C) calls the CHECK_* function for a node; it analyses both operands,
   converts them, sets the node's type, and returns the node, a rewritten tree or an
   error node (REPORT_EXPR_ERROR_PLAIN; message 0 means "already reported").
   PREPARE_BINARY_OPERANDS is the common first step for most binary operators. Its
   parameters, and those of the checkers that pass them on, do not mean what their names
   say: "mode" is ANALYZE_EXPRESSION's context argument passed through, "scope" (and
   "type" or "kind" in some checkers) is the wanted result type, and "mask" (or "hint")
   is the EXPR_FLAGS mask of operand types the operator accepts: 1 integral, 3
   arithmetic, 7 scalar, 0x17 scalar or pointer (EXPR_FLAGS: 1 integral, 2 floating, 4
   and 0x10 pointer kinds, 0x40 struct/union, 0x20 unsigned).
   Pointer arithmetic is made explicit here: p + i becomes p + i * sizeof(*p)
   (SCALE_POINTER_OPERAND), p - q becomes (p - q) / sizeof(*p), and a[i] becomes *(a + i).
   Operator 0x2D, unnamed in EXPROP.H, is used for adding an offset to a _seg pointer,
   giving a far pointer. In C++ mode (CPP_MODE) each checker first tries a
   user-defined operator (TRY_BINARY_OPERATOR_CALL) and the conversion functions of
   class operands, and assignment, initialisation and return go to their C++ versions
   (CHECK_CPP_ASSIGNMENT and friends). INT_TYPE is the int type;
   NOT_ANSI_FLAG is set when not in strict ANSI mode. The listing headers
   ("---- name (listing ...) ----") mark where each function sat in the original. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- SCALE_BY_ELEMENT_SIZE (listing 2DD0) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal USUAL_ARITHMETIC_CONVERSIONS(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
struct Triple { unsigned int word[3]; };
#define T(n,o) (*(struct Triple far *)MK_FP(EXPR_POOL_SEG,(n)+(o)))

/* SCALE_BY_ELEMENT_SIZE: builds node <token kind> value (value an int constant of type
   other), e.g. kind 0x18 TOK_STAR for i * size and 0x19 (probably '/') for a pointer
   difference, gives it node's source position, and converts the result to type other. */
static unsigned int near pascal SCALE_BY_ELEMENT_SIZE(unsigned int kind,long value,unsigned int node,unsigned int other)
{
    register unsigned int result;

    result=MAKE_BINARY_NODE(kind,node,MAKE_INT_CONSTANT(other,value));
    T(result,0x14)=T(node,0x14);
    T(EXPR_W(result,EXPR_RIGHT),0x14)=T(result,0x14);
    result=CONVERT_EXPR_TO_TYPE(other,USUAL_ARITHMETIC_CONVERSIONS(other,result),0);
    EXPR_B(result,EXPR_NODE_FLAGS)|=1;
    return result;
}
#undef T

/* ---- CHECK_OPERAND_KINDS (listing 2E53) ---- */
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

/* ---- PREPARE_BINARY_OPERANDS (listing 2F37) ---- */
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
   replaced) when an operand is in error or void, when a C++ operator function was
   called instead, or when an operand fails the mask; 0 to go on. */
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
    if(CPP_MODE) {
        if(TRY_BINARY_OPERATOR_CALL(output,mask,mode))
            return 1;
        if(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x40)
            EXPR_W(node,EXPR_LEFT)=APPLY_CONVERSION_FUNCTION(EXPR_W(node,EXPR_LEFT),mask,0);
        if(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&0x40)
            EXPR_W(node,EXPR_RIGHT)=APPLY_CONVERSION_FUNCTION(EXPR_W(node,EXPR_RIGHT),mask,0);
    }
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

/* ---- SCALE_POINTER_OPERAND (listing 30B8) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);

/* SCALE_POINTER_OPERAND: for pointer +/- integer (pointer on the left): the node takes
   the pointer's type and the integer is multiplied by the element size (as long for huge
   pointers). An unknown element size is an error. A _seg pointer plus offset becomes
   operator 0x2D with a far pointer type. */
static unsigned int near pascal SCALE_POINTER_OPERAND(unsigned int node)
{
    long size;

    EXPR_W(node,EXPR_TYPE)=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    size=TYPE_SIZE(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET));
    if(size==0)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION,node);
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_SEG_PTR) {
        EXPR_W(node,EXPR_OP)=0x2D;
        EXPR_W(node,EXPR_TYPE)=MAKE_POINTER_TYPE(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_TARGET),0x0F,0);
    }
    EXPR_W(node,EXPR_RIGHT)=SCALE_BY_ELEMENT_SIZE(0x18,size,EXPR_W(node,EXPR_RIGHT),
        TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_HUGE_PTR?LONG_TYPE:INT_TYPE);
    return node;
}

/* ---- ELIDE_COPY_ASSIGN (listing 3174) ---- */
#include <dos.h>
extern unsigned char far pascal EXPRESSIONS_EQUAL(unsigned int,unsigned int,unsigned char);
extern void far pascal FREE_EXPR_TREE(unsigned int);

/* ELIDE_COPY_ASSIGN: removes a useless copy. When the right side of the assignment-like
   node *output is a comma expression whose value is the left side itself (possibly as
   *&x and through casts), probably a constructor call that already built the object in
   place, the assignment is dropped and *output becomes the right side. Returns 1 when
   it did so. */
unsigned char far pascal ELIDE_COPY_ASSIGN(unsigned int far *output)
{
    unsigned char wrapped;
    unsigned char chain;
    register unsigned int node;
    register unsigned int previous;

    if(!EXPR_W(*output,EXPR_LEFT) || !EXPR_W(*output,EXPR_RIGHT))
        return 0;
    node=EXPR_W(*output,EXPR_RIGHT);
    wrapped=0;
    if(EXPR_W(node,EXPR_OP)==EOP_DEREF) {
        for(node=EXPR_W(node,EXPR_LEFT);EXPR_W(node,EXPR_OP)==0x35;node=EXPR_W(node,EXPR_LEFT)) ;
        wrapped=1;
    }
    chain=0;
    if(node && EXPR_W(node,EXPR_OP)==EOP_COMMA) {
        chain=1;
        node=EXPR_W(node,EXPR_RIGHT);
        while(EXPR_W(node,EXPR_OP)==0x35)
            node=EXPR_W(node,EXPR_LEFT);
    }
    if(wrapped && node) {
        if(EXPR_W(node,EXPR_OP)==EOP_ADDR)
            node=EXPR_W(node,EXPR_LEFT);
        else
            return 0;
    }
    if(chain && EXPRESSIONS_EQUAL(EXPR_W(*output,EXPR_LEFT),node,0)) {
        previous=*output;
        *output=EXPR_W(*output,EXPR_RIGHT);
        EXPR_W(previous,EXPR_RIGHT)=0;
        FREE_EXPR_TREE(previous);
        return 1;
    }
    return 0;
}

/* ---- CHECK_ASSIGNMENT (listing 3270) ---- */
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

/* CHECK_ASSIGNMENT: analyses left = right. The right side is analysed with the left
   type wanted and, unless the class has special members (TYPE_ATTRS 0x18), with the left
   side as destination (context). Then: copy elision, C++ operator=, lvalue and const
   checks, no void values and no arrays; null constants become pointers; in C the types
   must be assignment-compatible (C7_TYPE_COMPAT) and the right side is converted to
   the left type. */
unsigned int far pascal CHECK_ASSIGNMENT(unsigned int node)
{
    unsigned int scope;
    register unsigned int type;

    EXPR_W(node,EXPR_LEFT)=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0));
    type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    EXPR_W(node,EXPR_TYPE)=type;
    scope=(TYPE_B(type,TYPE_ATTRS)&0x18)?0:EXPR_W(node,EXPR_LEFT);
    EXPR_W(node,EXPR_RIGHT)=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),type,scope));
    if(ELIDE_COPY_ASSIGN(&node))
        return node;
    if(CPP_MODE && TRY_BINARY_OPERATOR_CALL(&node,0,0))
        return node;
    EXPR_B(node,EXPR_NODE_FLAGS)|=1;
    if(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==0 || EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_OP)==0)
        return REPORT_EXPR_ERROR_PLAIN(0,node);
    if(CPP_MODE)
        EXPR_W(node,EXPR_LEFT)=REWRITE_FOR_REFERENCE_BIND(EXPR_W(node,EXPR_LEFT));
    if(!IS_LVALUE(EXPR_W(node,EXPR_LEFT)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_LVALUE_REQUIRED,node);
    if(!IS_MODIFIABLE_NODE(EXPR_W(node,EXPR_LEFT)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_CANNOT_MODIFY_CONST,node);
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    if(TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)==TK_ARRAY)
        return REPORT_EXPR_ERROR(MSG_CANNOT_ASSIGN,FORMAT_TYPE(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE)),FORMAT_TYPE(EXPR_W(node,EXPR_TYPE)),node);
    EXPR_W(node,EXPR_RIGHT)=NULL_CONSTANT_TO_POINTER(type,EXPR_W(node,EXPR_RIGHT));
    if(CPP_MODE)
        return CHECK_CPP_ASSIGNMENT(node);
    if(!C7_TYPE_COMPAT(type,EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),NOT_ANSI_FLAG))
        return REPORT_EXPR_ERROR(MSG_CANNOT_ASSIGN,FORMAT_TYPE(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE)),FORMAT_TYPE(EXPR_W(node,EXPR_TYPE)),node);
    EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(type,NODE_ENUM_TO_INT(EXPR_W(node,EXPR_RIGHT)),EXPR_W(node,EXPR_LEFT));
    return node;
}

/* ---- CHECK_INITIALIZATION (listing 3491) ---- */
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
/* unnamed stub 0C08:0034 */
extern unsigned int far pascal CHECK_CPP_INITIALIZATION(unsigned int);
unsigned char far pascal ELIDE_COPY_ASSIGN(unsigned int far *);

/* CHECK_INITIALIZATION: analyses an initialisation (operator 0x47: object = value in a
   declaration). Like CHECK_ASSIGNMENT but without the lvalue/const checks, and arrays
   or references are not decayed; on success the node becomes a plain EOP_ASSIGN. */
unsigned int far pascal CHECK_INITIALIZATION(unsigned int node)
{
    register unsigned int type;
    register unsigned int right_type;

    EXPR_W(node,EXPR_LEFT)=ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0);
    EXPR_W(node,EXPR_TYPE)=type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    EXPR_W(node,EXPR_RIGHT)=ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),type,EXPR_W(node,EXPR_LEFT));
    if(ELIDE_COPY_ASSIGN(&node))
        return node;
    EXPR_B(node,EXPR_NODE_FLAGS)|=1;
    if(TYPE_W(type,TYPE_KIND)!=TK_ARRAY &&
       !((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && (TYPE_B(type,TYPE_ATTRS)&0x20)))
        EXPR_W(node,EXPR_RIGHT)=DECAY_TO_POINTER(EXPR_W(node,EXPR_RIGHT));
    right_type=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    if(TYPE_W(right_type,TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    EXPR_W(node,EXPR_RIGHT)=NULL_CONSTANT_TO_POINTER(type,EXPR_W(node,EXPR_RIGHT));
    if(CPP_MODE)
        return CHECK_CPP_INITIALIZATION(node);
    if(TYPE_W(type,TYPE_KIND)==TK_FUNCTION ||
       !C7_TYPE_COMPAT(type,EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),NOT_ANSI_FLAG&!CPP_MODE))
        return REPORT_EXPR_ERROR(MSG_CANNOT_INITIALIZE,FORMAT_TYPE(type),FORMAT_TYPE(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE)),node);
    EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(type,NODE_ENUM_TO_INT(EXPR_W(node,EXPR_RIGHT)),EXPR_W(node,EXPR_LEFT));
    EXPR_W(node,EXPR_OP)=EOP_ASSIGN;
    return node;
}

/* ---- CHECK_COMPOUND_ASSIGNMENT (listing 3624) ---- */
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
/* unnamed stub 0C43:0020 */
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

/* CHECK_COMPOUND_ASSIGNMENT: analyses x op= y. hint is the operand mask (7 for += -= *=
   /=, 1 for the integer-only ones). A pointer on the right is an error (messages 82/83
   for += and -=), a pointer on the left only allows += / -= with an integer, which is
   scaled. Shifts convert the count to BCC_TYPE_PTR[2] (unsigned char). For other
   arithmetic, when the right type is wider than the left, x op= y is rewritten as
   x = (wide)x op y with x saved in a temporary if needed, so the arithmetic is done in
   the wider type. */
unsigned int far pascal CHECK_COMPOUND_ASSIGNMENT(unsigned int node,unsigned int mode,unsigned int hint)
{
    unsigned int left;
    unsigned int right;
    unsigned int op;
    unsigned int code;
    register unsigned int left_type;
    register unsigned int right_type;

    EXPR_W(node,EXPR_LEFT)=left=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0));
    EXPR_W(node,EXPR_TYPE)=left_type=EXPR_W(left,EXPR_TYPE);
    EXPR_W(node,EXPR_RIGHT)=right=NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),left_type,0)));
    op=EXPR_W(node,EXPR_OP);
    right_type=EXPR_W(right,EXPR_TYPE);
    if(CPP_MODE) {
        if(TRY_BINARY_OPERATOR_CALL(&node,0,mode))
            return node;
        if(TYPE_W(left_type,TYPE_KIND)==TK_ENUM)
            REPORT_DIAGNOSTIC_AT(MSG_ASSIGNING,FORMAT_TYPE(right_type),FORMAT_TYPE(left_type),
                EXPR_W(node,EXPR_SRC_LINE),EXPR_W(node,EXPR_SRC_WORD3));
        left=REWRITE_FOR_REFERENCE_BIND(left);
    }
    EXPR_W(node,EXPR_LEFT)=left=NODE_ENUM_TO_INT(left);
    if(!IS_LVALUE(left))
        return REPORT_EXPR_ERROR_PLAIN(MSG_LVALUE_REQUIRED,node);
    if(!IS_MODIFIABLE_NODE(left))
        return REPORT_EXPR_ERROR_PLAIN(MSG_CANNOT_MODIFY_CONST,node);
    if(CPP_MODE && (EXPR_FLAGS[TYPE_W(right_type,TYPE_KIND)]&0x40)) {
        EXPR_W(node,EXPR_RIGHT)=right=APPLY_CONVERSION_FUNCTION(right,hint,0);
        right_type=EXPR_W(right,EXPR_TYPE);
    }
    if(EXPR_FLAGS[TYPE_W(right_type,TYPE_KIND)]&0x14) {
        code=0x13;
        if(op==0x13)
            code=0x52;
        else if(op==0x14)
            code=0x53;
        return REPORT_EXPR_ERROR_PLAIN(code,node);
    }
    if((EXPR_FLAGS[TYPE_W(left_type,TYPE_KIND)]&0x14) &&
       ((op!=0x13 && op!=0x14) || !(EXPR_FLAGS[TYPE_W(right_type,TYPE_KIND)]&1)))
        return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_USE_POINTER,node);
    if(!CHECK_OPERAND_KINDS(node,hint))
        return REPORT_EXPR_ERROR_PLAIN(0,node);
    if(TYPE_W(right_type,TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    if(EXPR_FLAGS[TYPE_W(left_type,TYPE_KIND)]&0x14)
        return SCALE_POINTER_OPERAND(node);
    if(EXPR_W(node,EXPR_OP)==EOP_SHL_ASSIGN || EXPR_W(node,EXPR_OP)==EOP_SHR_ASSIGN)
        EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(BCC_TYPE_PTR[2],right,0);
    else {
        if(!C7_TYPE_COMPAT(left_type,right_type,NOT_ANSI_FLAG))
            return REPORT_EXPR_ERROR(MSG_CANNOT_ASSIGN,FORMAT_TYPE(right_type),FORMAT_TYPE(left_type),node);
        if((EXPR_W(node,EXPR_OP)==EOP_MOD_ASSIGN || EXPR_W(node,EXPR_OP)==EOP_DIV_ASSIGN || EXPR_W(node,EXPR_OP)==EOP_MUL_ASSIGN) && TK(left_type)<=2)
            left_type=INT_TYPE;
        if((EXPR_FLAGS[TYPE_W(left_type,TYPE_KIND)]&1) && (EXPR_FLAGS[TYPE_W(right_type,TYPE_KIND)]&1) &&
           op!=0x15 && op!=0x16 && op!=0x17) {
            EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(left_type,right,0);
            return node;
        }
        left_type=PICK_WIDER_TYPE(left_type,right_type);
        EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(left_type,right,0);
        /* right side wider than x: compute x = (T)x op y in the wider type T, evaluating
           x only once (SAVE_EXPR_IN_TEMP); op + (0x08 - 0x13) turns e.g. += into + */
        if(TK(EXPR_W(left,EXPR_TYPE))<TK(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE))) {
            code=0;
            SAVE_EXPR_IN_TEMP(&left,&code);
            EXPR_W(node,EXPR_LEFT)=left;
            EXPR_W(node,EXPR_OP)=op+(0x08-0x13);
            left=COPY_EXPR_TREE(left);
            EXPR_W(node,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(left_type,EXPR_W(node,EXPR_LEFT),0);
            node=MAKE_BINARY_NODE(0x0B,left,node);
            node=ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(code,node),0,0);
        }
    }
    return node;
}
#undef TK

/* ---- CHECK_RETURN_VALUE (listing 39B1) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal NULL_CONSTANT_TO_POINTER(unsigned int,unsigned int);
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
/* unnamed stub 0C08:003E */
extern unsigned int far pascal CHECK_CPP_RETURN_VALUE(unsigned int,unsigned int);
unsigned char far pascal ELIDE_COPY_ASSIGN(unsigned int far *);

/* CHECK_RETURN_VALUE: analyses a return-value node (operator 0x46: EXPR_TYPE is the
   function's return type, EXPR_RIGHT the value, EXPR_LEFT an optional destination such
   as the hidden return slot). The value is checked against the return type and
   converted; without a destination the node is replaced by the value, otherwise it
   becomes an assignment to the destination. */
unsigned int far pascal CHECK_RETURN_VALUE(unsigned int node)
{
    unsigned int old;
    unsigned int scope;
    register unsigned int type;
    register unsigned int right_type;

    type=EXPR_W(node,EXPR_TYPE);
    scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    if(EXPR_W(node,EXPR_LEFT))
        EXPR_W(node,EXPR_LEFT)=ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),type,0);
    EXPR_W(node,EXPR_RIGHT)=ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),type,EXPR_W(node,EXPR_LEFT));
    if(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_OP)==0)
        return REPORT_EXPR_ERROR_PLAIN(0,node);
    EXPR_W(node,EXPR_RIGHT)=NULL_CONSTANT_TO_POINTER(type,EXPR_W(node,EXPR_RIGHT));
    right_type=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    if(TYPE_W(right_type,TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    if(CPP_MODE)
        return CHECK_CPP_RETURN_VALUE(node,scope);
    if(ELIDE_COPY_ASSIGN(&node))
        return node;
    EXPR_W(node,EXPR_RIGHT)=CONVERT_TO_RVALUE(EXPR_W(node,EXPR_RIGHT));
    right_type=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    if(TYPE_W(type,TYPE_KIND)!=TK_VOID) {
        if(!C7_TYPE_COMPAT(type,right_type,NOT_ANSI_FLAG))
            return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_TYPE_DOES,node);
        EXPR_W(node,EXPR_RIGHT)=CONVERT_EXPR_TO_TYPE(type,EXPR_W(node,EXPR_RIGHT),EXPR_W(node,EXPR_LEFT));
    }
    if(EXPR_W(node,EXPR_LEFT)==0) {
        old=node;
        node=EXPR_W(node,EXPR_RIGHT);
        FREE_EXPR_NODE(old);
    } else
        EXPR_W(node,EXPR_OP)=EOP_ASSIGN;
    return node;
}

/* ---- CHECK_MULTIPLICATIVE_OP (listing 3B28) ---- */
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

/* ---- CHECK_INTEGRAL_OP (listing 3C2D) ---- */
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

/* ---- CHECK_SUBSCRIPT (listing 3CE3) ---- */
unsigned int far pascal CHECK_ADDITION(unsigned int node,unsigned int mode,unsigned int kind);
#include <dos.h>
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
unsigned int far pascal CHECK_ADDITION(unsigned int,unsigned int,unsigned int);

/* CHECK_SUBSCRIPT: analyses a[i] as *(a + i) (token 0x18, TOK_STAR, makes the *). */
unsigned int far pascal CHECK_SUBSCRIPT(unsigned int node,unsigned int mode)
{
    if(CPP_MODE && PREPARE_BINARY_OPERANDS(&node,mode,0,0x17)) return node;
    EXPR_W(node,EXPR_OP)=EOP_ADD;
    node=CHECK_ADDITION(node,mode,0);
    EXPR_B(node,EXPR_NODE_FLAGS)|=1;
    node=ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x18,node),0,0);
    return node;
}

/* ---- BUILD_MEMBER_ACCESS (listing 3D4F) ---- */
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

/* BUILD_MEMBER_ACCESS: (C mode) completes object.member: finds the member by name
   (operator 0x38 node) or takes it from a member reference (0x4A), replaces the right
   operand with a member node, and types the result as the member type with the
   object's const/volatile added. A bitfield wider than unsigned int (long bitfields) is
   read as int / unsigned int and converted. */
static unsigned int near pascal BUILD_MEMBER_ACCESS(unsigned int node)
{
    unsigned int member;
    unsigned int type;
    unsigned int result_type;
    unsigned int right;

    member=0;
    type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    right=EXPR_W(node,EXPR_RIGHT);
    if(EXPR_W(right,EXPR_OP)==0) return REPORT_EXPR_ERROR_PLAIN(0,node);
    if(EXPR_W(right,EXPR_OP)==0x38) {
        member=FIND_MEMBER_BY_NAME(EXPR_W(right,EXPR_LEFT),type);
        if(member==0)
            return REPORT_EXPR_ERROR(MSG_NOT_MEMBER,NAME_TEXT_COPY(EXPR_W(right,EXPR_LEFT)),FORMAT_TYPE(type),node);
    } else if(EXPR_W(right,EXPR_OP)==0x4A)
        member=EXPR_W(right,EXPR_LEFT);
    FREE_EXPR_NODE(right);
    EXPR_W(node,EXPR_RIGHT)=MAKE_MEMBER_NODE(member,LOCATION(right));
    EXPR_W(node,EXPR_TYPE)=ADD_CV_QUALIFIERS(MEMBER_W(member,MEMB_TYPE),(TYPE_B(type,TYPE_ATTRS)&2)!=0,(TYPE_B(type,TYPE_ATTRS)&1)!=0);
    if((MEMBER_B(member,MEMB_FLAGS)&0x40) && TYPE_I(EXPR_W(node,EXPR_TYPE),TYPE_KIND)>TK_UINT) {
        result_type=EXPR_W(node,EXPR_TYPE);
        EXPR_W(node,EXPR_TYPE)=(EXPR_FLAGS[TYPE_W(result_type,TYPE_KIND)]&0x20)?BCC_TYPE_PTR[6]:INT_TYPE;
        EXPR_B(node,EXPR_NODE_FLAGS)|=1;
        return CONVERT_EXPR_TO_TYPE(result_type,node,0);
    }
    EXPR_B(node,EXPR_NODE_FLAGS)|=1;
    return node;
}
#undef LOCATION

/* ---- CHECK_DOT_MEMBER (listing 3EBE) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal ANALYZE_MEMBER_SELECT(unsigned int,unsigned char);

/* CHECK_DOT_MEMBER: analyses object.member: the left side must be a struct or union;
   C++ goes to ANALYZE_MEMBER_SELECT (mode passed on), C to BUILD_MEMBER_ACCESS. */
unsigned int far pascal CHECK_DOT_MEMBER(unsigned int node,unsigned char mode)
{
    unsigned int child;

    child=EXPR_W(node,EXPR_LEFT)=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0));
    if(EXPR_W(child,EXPR_OP)==0) return REPORT_EXPR_ERROR_PLAIN(0,node);
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(child,EXPR_TYPE),TYPE_KIND)]&0x40)) return REPORT_EXPR_ERROR_PLAIN(MSG_LEFT_SIDE_MUST,node);
    if(CPP_MODE) return ANALYZE_MEMBER_SELECT(node,mode);
    return BUILD_MEMBER_ACCESS(node);
}

/* ---- CHECK_POINTER_INDIRECTION (listing 3F34) ---- */
#include <dos.h>
#include "EXPRC4.H"

/* CHECK_POINTER_INDIRECTION: analyses p->m and p->*m by turning them into (*p).m and
   (*p).*m: "kind" is the operator to use afterwards (0x3B EOP_DOT or 0x3C EOP_DOT_STAR).
   A based pointer is made a normal pointer first. In C++ a class on the left of -> is
   passed through operator-> (token 0x30) as long as one applies, and ->* may be an
   overloaded operator. */
unsigned int far pascal CHECK_POINTER_INDIRECTION(unsigned int node,unsigned int mode,unsigned int kind)
{
    unsigned int temporary;
    register unsigned int child;

    EXPR_W(node,EXPR_LEFT)=child=CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(EXPR_W(node,EXPR_LEFT),0,0));
    if(EXPR_W(child,EXPR_OP)==0) return REPORT_EXPR_ERROR_PLAIN(0,node);
    if(TYPE_W(EXPR_W(child,EXPR_TYPE),TYPE_KIND)==TK_NEAR_PTR && TYPE_W(EXPR_W(child,EXPR_TYPE),TYPE_PTR_BASE)!=0)
        child=ANALYZE_EXPRESSION(APPLY_BASED_POINTER(child),0,0);
    if(CPP_MODE && (EXPR_FLAGS[TYPE_W(EXPR_W(child,EXPR_TYPE),TYPE_KIND)]&0x40)) {
        if(EXPR_W(node,EXPR_OP)==EOP_ARROW) {
            while(EXPR_FLAGS[TYPE_W(EXPR_W(child,EXPR_TYPE),TYPE_KIND)]&0x40) {
                temporary=MAKE_UNARY_NODE(0x30,child);
                if(TRY_UNARY_OPERATOR_CALL(&temporary,0,0))
                    child=temporary;
                else {
                    FREE_EXPR_NODE(temporary);
                    break;
                }
            }
        } else {
            EXPR_W(node,EXPR_RIGHT)=ANALYZE_EXPRESSION(EXPR_W(node,EXPR_RIGHT),0,0);
            if(TRY_BINARY_OPERATOR_CALL(&node,0,mode)) return node;
        }
    }
    if(EXPR_W(child,EXPR_OP)==0) return REPORT_EXPR_ERROR_PLAIN(0,node);
    EXPR_W(node,EXPR_LEFT)=child;
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(child,EXPR_TYPE),TYPE_KIND)]&0x14))
        return REPORT_EXPR_ERROR_PLAIN(MSG_POINTER_REQUIRED_LEFT,node);
    if((EXPR_FLAGS[TYPE_W(EXPR_W(child,EXPR_TYPE),TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(EXPR_W(child,EXPR_TYPE),TYPE_TARGET),TYPE_KIND)==TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT,node);
    EXPR_W(node,EXPR_LEFT)=MAKE_DEREFERENCE(child);
    EXPR_W(node,EXPR_OP)=kind;
    node=ANALYZE_EXPRESSION(node,0,0);
    return node;
}

/* ---- CHECK_ADDITION (listing 40F4) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal SWAP_OPERANDS(unsigned int);
extern unsigned int far pascal USUAL_ARITHMETIC_CONVERSIONS(unsigned int,unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
#define VOID_POINTER(t) ((EXPR_FLAGS[TYPE_W(t,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(t,TYPE_TARGET),TYPE_KIND)==TK_VOID)

/* CHECK_ADDITION: analyses a + b; "kind" is the wanted type. A pointer operand is moved
   to the left. Arithmetic: usual conversions. Pointer + integer: scaled. Pointer +
   pointer is only allowed as _seg pointer + near pointer to compatible types, giving a
   far pointer (operator 0x2D); otherwise MSG_INVALID_POINTER. */
unsigned int far pascal CHECK_ADDITION(unsigned int node,unsigned int mode,unsigned int kind)
{
    unsigned int temporary;
    register unsigned int right_type;
    register unsigned int left_type;

    if(PREPARE_BINARY_OPERANDS(&node,mode,kind,0x17)) return node;
    if(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)!=TK_SEG_PTR && (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&0x14))
        node=SWAP_OPERANDS(node);
    left_type=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    if(!(EXPR_FLAGS[TYPE_W(left_type,TYPE_KIND)]&0x14))
        return USUAL_ARITHMETIC_CONVERSIONS(kind,node);
    right_type=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    if(EXPR_FLAGS[TYPE_W(right_type,TYPE_KIND)]&1)
        return SCALE_POINTER_OPERAND(node);
    if(!(EXPR_FLAGS[TYPE_W(right_type,TYPE_KIND)]&0x14))
        return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING,node);
    if(TYPE_W(right_type,TYPE_KIND)==TK_SEG_PTR) {
        temporary=right_type;
        right_type=left_type;
        left_type=temporary;
        node=SWAP_OPERANDS(node);
    }
    if(TYPE_W(left_type,TYPE_KIND)!=TK_SEG_PTR || TYPE_W(right_type,TYPE_KIND)==TK_SEG_PTR || TYPE_W(right_type,TYPE_KIND)==TK_FAR_PTR ||
       TYPES_COMPATIBLE(TYPE_W(left_type,TYPE_TARGET),TYPE_W(right_type,TYPE_TARGET),0)==0 &&
       !VOID_POINTER(left_type) && !VOID_POINTER(right_type))
        return REPORT_EXPR_ERROR_PLAIN(MSG_INVALID_POINTER,node);
    EXPR_W(node,EXPR_OP)=0x2D;
    EXPR_W(node,EXPR_TYPE)=MAKE_POINTER_TYPE(TYPE_W(VOID_POINTER(left_type)?right_type:left_type,TYPE_TARGET),0x0F,0);
    return node;
}
#undef VOID_POINTER

/* ---- CHECK_SUBTRACTION (listing 429D) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal BALANCE_BINARY_OPERANDS(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal USUAL_ARITHMETIC_CONVERSIONS(unsigned int,unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);


/* CHECK_SUBTRACTION: analyses a - b; "type" is the wanted type. Pointer - pointer needs
   compatible pointers (or, outside strict ANSI, equal element sizes) and gives
   (p - q) / sizeof(*p) as int (long unless near pointers), converted to PTRDIFF_TYPE when a
   wider result is wanted. Pointer - integer is scaled; integer - pointer is an error. */
unsigned int far pascal CHECK_SUBTRACTION(unsigned int node,unsigned int mode,unsigned int type)
{
    unsigned int size;

    if(PREPARE_BINARY_OPERANDS(&node,mode,type,7)) return node;
    if(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&0x14) {
        if(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&0x14) {
            BALANCE_BINARY_OPERANDS(type,node);
            size=TYPE_SIZE(TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_TARGET));
            if(TYPES_COMPATIBLE(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),2) ||
               NOT_ANSI_FLAG && TYPE_SIZE(TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_TARGET))==size) {
                EXPR_W(node,EXPR_LEFT)=CONVERT_EXPR_TO_TYPE(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),EXPR_W(node,EXPR_LEFT),0);
                if(size==0) return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION,node);
                EXPR_B(node,EXPR_NODE_FLAGS)|=1;
                EXPR_W(node,EXPR_TYPE)=TYPE_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)==TK_NEAR_PTR?INT_TYPE:LONG_TYPE;
                node=SCALE_BY_ELEMENT_SIZE(0x19,(long)size,node,EXPR_W(node,EXPR_TYPE));
                if(TYPE_I(type,TYPE_KIND)>=TYPE_I(PTRDIFF_TYPE,TYPE_KIND) && TYPE_I(PTRDIFF_TYPE,TYPE_KIND)>TYPE_I(EXPR_W(node,EXPR_TYPE),TYPE_KIND))
                    node=CONVERT_EXPR_TO_TYPE(PTRDIFF_TYPE,node,0);
                return node;
            }
            return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING,node);
        } else if(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&1)
            return SCALE_POINTER_OPERAND(node);
        return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING,node);
    }
    if(EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE),TYPE_KIND)]&0x14) return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_POINTER,node);
    return USUAL_ARITHMETIC_CONVERSIONS(type,node);
}

/* ---- CHECK_LOGICAL_OP (listing 44A1) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_CLASS_TO_SCALAR(unsigned int);
extern unsigned int far pascal APPEND_TEMP_DESTRUCTORS(unsigned int,unsigned int);

/* CHECK_LOGICAL_OP: analyses && and ||: both operands scalar, result int. In C++ the
   temporaries made by the right operand are destroyed inside it (APPEND_TEMP_DESTRUCTORS),
   since the right operand may not be evaluated at all. */
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
    if(CPP_MODE) {
        if(TRY_BINARY_OPERATOR_CALL(&node,7,mode))
            return node;
        EXPR_W(node,EXPR_RIGHT)=CONVERT_CLASS_TO_SCALAR(EXPR_W(node,EXPR_RIGHT));
        EXPR_W(node,EXPR_RIGHT)=APPEND_TEMP_DESTRUCTORS(EXPR_W(node,EXPR_RIGHT),saved);
        EXPR_W(node,EXPR_LEFT)=CONVERT_CLASS_TO_SCALAR(EXPR_W(node,EXPR_LEFT));
    }
    if(!CHECK_OPERAND_KINDS(node,7))
        return REPORT_EXPR_ERROR_PLAIN(0,node);
    EXPR_W(node,EXPR_TYPE)=INT_TYPE;
    return node;
}

/* ---- CHECK_COMPARISON (listing 4610) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal BALANCE_BINARY_OPERANDS(unsigned int,unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern void far pascal REPORT_DIAGNOSTIC_AT(int,char far *,char far *,unsigned int,unsigned int);
extern unsigned int far pascal COMPARE_MEMBER_POINTERS(unsigned int);

/* CHECK_COMPARISON: analyses == != < > <= >=: the operands are balanced (with char as
   wanted type, so byte compares stay possible) and the result is int. Member function
   pointers in C++ go to COMPARE_MEMBER_POINTERS. In C, mismatched pointers or pointer
   vs integer only warn ("mixing pointers to signed and unsigned char", "nonportable
   pointer comparison"); C does not balance two function pointers for < > <= >=.
   Other mismatches are MSG_OPERANDS_ARE_DIFFERING. */
unsigned int far pascal CHECK_COMPARISON(unsigned int node,unsigned int mode)
{
    register unsigned int left;
    register unsigned int right;

    if(PREPARE_BINARY_OPERANDS(&node,mode,INT_TYPE,7))
        return node;
    left=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
    right=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
    if(CPP_MODE
       || (EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14)==0 || TYPE_W(TYPE_W(left,TYPE_TARGET),TYPE_KIND)!=TK_FUNCTION
       || (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14)==0 || TYPE_W(TYPE_W(right,TYPE_TARGET),TYPE_KIND)!=TK_FUNCTION
       || EXPR_W(node,EXPR_OP)==EOP_EQ || EXPR_W(node,EXPR_OP)==EOP_NE) {
        node=BALANCE_BINARY_OPERANDS(CHAR_TYPE,node);
        EXPR_W(node,EXPR_TYPE)=INT_TYPE;
        left=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_TYPE);
        right=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
        if(TYPES_COMPATIBLE(left,right,2)) {
            if(CPP_MODE && TYPE_W(left,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(left,TYPE_PTR_MODE)==0x0B
               && (EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(left,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION)
                return COMPARE_MEMBER_POINTERS(node);
            return node;
        }
    }
    if(!CPP_MODE
       && ((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) || (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14))) {
        if((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) && (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14)
           && ((TYPE_W(TYPE_W(left,TYPE_TARGET),TYPE_KIND)==TK_UCHAR && TYPE_W(TYPE_W(right,TYPE_TARGET),TYPE_KIND)==TK_CHAR)
               || (TYPE_W(TYPE_W(left,TYPE_TARGET),TYPE_KIND)==TK_CHAR && TYPE_W(TYPE_W(right,TYPE_TARGET),TYPE_KIND)==TK_UCHAR))) {
            REPORT_DIAGNOSTIC_AT(MSG_MIXING_POINTERS_SIGNED,(char far *)0,(char far *)0,EXPR_W(node,EXPR_SRC_LINE),EXPR_W(node,EXPR_SRC_WORD3));
            return node;
        }
        REPORT_DIAGNOSTIC_AT(MSG_NONPORTABLE_POINTER_362,(char far *)0,(char far *)0,EXPR_W(node,EXPR_SRC_LINE),EXPR_W(node,EXPR_SRC_WORD3));
    } else
        node=REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING,node);
    return node;
}
