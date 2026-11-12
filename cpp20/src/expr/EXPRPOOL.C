/* target: EXPRPOOL */
/* opts: -mm -O -Z -p -y */
/* CPP.EXE module EXPRPOOL (image 0x8744..0x8F97, frame 0874h): source taken from the
   BCC.EXE reconstruction (bcc20/src/expr/EXPRPOOL.C): 23 of BCC's 42
   functions, in BCC's order. Left out here: MAKE_MEMBER_NAME_NODE, MAKE_FIELD_REF_NODE,
   MAKE_MEMBER_NODE, MAKE_ADDR_OF_CONTEXT_NODE, BUILD_SYMBOL_EXPR, GENERATE_TEMP_NAME,
   CREATE_TEMP_SYMBOL, CREATE_LOCAL_TEMP, JOIN_COMMA_EXPR, NEAR_PTR_BASES_MATCH,
   C7_TYPE_COMPAT, IS_LVALUE, IS_SIDE_EFFECT_FREE, IS_NAMED_OBJECT_EXPR,
   EXPRESSIONS_EQUAL, COPY_EXPR_TREE, FIND_BASE_SYMBOL, SAVE_EXPR_IN_TEMP,
   APPEND_TEMP_DESTRUCTORS (their declarations, and some of their comments, are left
   under section marks). */
/* Role: expressions: expression node pool: allocate/free nodes and trees, constants,
   null pointer constants, constant tests. Entry points: ALLOC_EXPR_NODE,
   RESET_EXPR_POOL_ALT, FREE_EXPR_TREE, FREE_EXPR_NODE, MAKE_LIST_NODE,
   MAKE_INT_CONSTANT, MAKE_REAL_CONSTANT, MAKE_SYMBOL_NODE, MAKE_UNARY_NODE,
   MAKE_BINARY_NODE, MAKE_CONDITIONAL_NODE, MAKE_CAST_NODE, MAKE_CALL_NODE,
   EXPR_HAS_ERROR, REPORT_EXPR_ERROR, REPORT_EXPR_ERROR_PLAIN, SWAP_OPERANDS,
   PICK_WIDER_TYPE, CHECK_NULL_CONSTANT, NULL_CONSTANT_TO_POINTER, IS_CONSTANT_EXPR,
   IS_LINK_TIME_CONSTANT. */
/* Overview: the basic toolkit for expression trees, used in CPP.EXE by the #if
   expression parser and its checkers. Expression nodes are 0x1A-byte records in
   EXPR_POOL_SEG (fields EXPR_*: operator, type, flags, left and right operand, source
   position). This file allocates and frees them (ALLOC_EXPR_NODE, FREE_EXPR_TREE),
   builds the common node shapes (constants, symbol leaves, unary, binary, cast, call
   and list nodes), and answers questions about trees: is it a constant, a link-time
   constant. (BCC's version also made temporaries, compared and copied trees.)
   Things to know:
   - MAKE_UNARY_NODE, MAKE_BINARY_NODE and MAKE_CONDITIONAL_NODE take a token code
     (TOKEN.H, e.g. 0x18 TOK_STAR, 0x0B TOK_ASSIGN, 8 TOK_COMMA), not an operator;
     TOKEN_TO_OPERATOR turns it into an EOP_* operator through TOKEN_OPERATOR_CODE.
     Nodes they make get flag 0x20, "not analysed yet, may be an overloaded operator".
     The other constructors store operator numbers directly.
   - Operators that have no EXPROP.H name are written as numbers: 0 an error node,
     1 a symbol leaf (EXPR_LEFT = symbol), 3 a long double constant (10 bytes at
     EXPR_LEFT), 7 probably the "..." leaf, 0x2B an argument-list cell, 0x35 a cast,
     0x36 a call, 0x38 a member-name node, 0x39 a member (field) node, 0x4A a field
     reference; 0x42 and 0x48 also occur.
   - EXPR_OP_FLAGS[op] bits used here: 4 = leaf (its left/right words are data, not
     children), 1 = has a side effect, 2 = commutative.
   - SYM_STORAGE_CLASS >> 3 as used here: < 5 has a static address, 5 automatic, 6
     probably register, 9 a constant (probably an enumerator).
   - CPP_MODE is the C++ mode flag; INT_TYPE is the int type. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"

/* ---- TOKEN_TO_OPERATOR (CPP 0874:0004) ---- */

/* TOKEN_TO_OPERATOR: maps token op to its binary operator, or with flag set to the
   unary operator of the same token: + to 0x49 (unary plus), - to EOP_NEG, * to
   EOP_DEREF, & to EOP_ADDR, and code 17 to 0x42. */
static unsigned int far pascal TOKEN_TO_OPERATOR(register unsigned int op,unsigned char flag)
{
    register unsigned int code;

    code=TOKEN_OPERATOR_CODE[op];
    if(!flag)
        return code;
    switch(code) {
    case 8:
        return 0x49;
    case 9:
        return 0x2E;
    case 10:
        return 0x31;
    case 15:
        return 0x32;
    case 17:
        return 0x42;
    }
    return code;
}

/* ---- ALLOC_EXPR_NODE (CPP 0874:0065) ---- */
extern unsigned int  EXPR_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);

/* ALLOC_EXPR_NODE: returns a new zeroed node stamped with the current token's source
   position (file, line, third word) for later diagnostics. */
unsigned int far pascal ALLOC_EXPR_NODE(void)
{
    unsigned int node;

    node=POOL_ALLOC_REUSE(&EXPR_POOL_SEG,0x1A);
    RTL_MEMSET(MK_FP(EXPR_POOL_SEG,node),0,0x1A);
    EXPR_W(node,EXPR_SRC_FILE)=CURRENT_TOKEN_FILE;
    EXPR_W(node,EXPR_SRC_LINE)=CURRENT_TOKEN_LINE;
    EXPR_W(node,EXPR_SRC_WORD3)=CURRENT_TOKEN_LOC_WORD3;
    return node;
}

/* ---- RESET_EXPR_POOL_ALT (CPP 0874:00A8) ---- */

/* RESET_EXPR_POOL_ALT: empties the whole expression pool at once (same body as
   RESET_EXPR_POOL in expr/EXPRMAKE.C). */
void far pascal RESET_EXPR_POOL_ALT(void)
{
    EXPR_POOL_USED=0;
    EXPR_POOL_UNIT=2;
}

/* ---- FREE_EXPR_TREE (CPP 0874:00B9) ---- */
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);

/* FREE_EXPR_TREE: frees every node of a tree without recursion. A node with a right
   operand is pushed on a stack threaded through its own EXPR_RIGHT word (variable
   stack) while the right subtree is freed; when it is popped its right word is cleared
   and the loop frees it and follows its left operand. Leaf nodes (EXPR_OP_FLAGS bit 4)
   are freed without looking at their operand words. */
void far pascal FREE_EXPR_TREE(register unsigned int node)
{
    register unsigned int stack;
    unsigned int next;

    stack=0;
    for(;;) {
        if(node==0) {
            if(stack==0)
                return;
            node=stack;
            stack=EXPR_W(node,EXPR_RIGHT);
            EXPR_W(node,EXPR_RIGHT)=0;
        }
        if(EXPR_OP_FLAGS[EXPR_W(node,EXPR_OP)]&4) {
            POOL_FREE_ITEM(&EXPR_POOL_SEG,node);
            node=0;
        } else if(EXPR_W(node,EXPR_RIGHT)!=0) {
            next=EXPR_W(node,EXPR_RIGHT);
            EXPR_W(node,EXPR_RIGHT)=stack;
            stack=node;
            node=next;
        } else {
            next=node;
            node=EXPR_W(node,EXPR_LEFT);
            POOL_FREE_ITEM(&EXPR_POOL_SEG,next);
        }
    }
}

/* ---- FREE_EXPR_NODE (CPP 0874:0139) ---- */

void far pascal FREE_EXPR_NODE(unsigned int node)
{
    POOL_FREE_ITEM(&EXPR_POOL_SEG,node);
}

/* ---- MAKE_LIST_NODE (CPP 0874:014D) ---- */

/* MAKE_LIST_NODE: one cell (operator 0x2B, type void) of an argument list: EXPR_RIGHT is
   the item, EXPR_LEFT the next cell. */
unsigned int far pascal MAKE_LIST_NODE(unsigned int item,unsigned int next)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=0x2B;
    EXPR_W(node,EXPR_TYPE)=VOID_TYPE;
    EXPR_W(node,EXPR_RIGHT)=item;
    EXPR_W(node,EXPR_LEFT)=next;
    return node;
}

/* ---- MAKE_INT_CONSTANT (CPP 0874:017C) ---- */

/* MAKE_INT_CONSTANT: integer constant node of the given type and value, already marked
   analysed (flag 1). */
unsigned int far pascal MAKE_INT_CONSTANT(unsigned int type,long value)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=EOP_CONST;
    EXPR_W(node,EXPR_TYPE)=type;
    EXPR_B(node,EXPR_NODE_FLAGS)=1;
    EXPR_L(node,EXPR_VALUE)=value;
    return node;
}

/* ---- MAKE_REAL_CONSTANT (CPP 0874:01B0) ---- */
typedef struct { unsigned char bytes[10]; } C40RealStorage;

/* MAKE_REAL_CONSTANT: floating constant node (operator 3) holding the 10-byte long
   double *value. */
unsigned int far pascal MAKE_REAL_CONSTANT(unsigned int type,C40RealStorage far *value)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=3;
    EXPR_W(node,EXPR_TYPE)=type;
    EXPR_B(node,EXPR_NODE_FLAGS)=1;
    RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,node+EXPR_LEFT),value,10);
    return node;
}

/* ---- MAKE_SYMBOL_NODE (CPP 0874:01EF) ---- */

/* MAKE_SYMBOL_NODE: leaf (operator 1) naming symbol, not yet analysed. */
unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int symbol)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=1;
    EXPR_W(node,EXPR_LEFT)=symbol;
    EXPR_W(node,EXPR_RIGHT)=0;
    EXPR_W(node,EXPR_SCOPE_CLASS)=0;
    return node;
}

/* ---- (BCC's MAKE_MEMBER_NAME_NODE: not in CPP.EXE) ---- */


/* ---- (BCC's MAKE_FIELD_REF_NODE: not in CPP.EXE) ---- */


/* ---- (BCC's MAKE_MEMBER_NODE: not in CPP.EXE) ---- */
struct C21Location { unsigned int first,second,third; };


/* ---- (BCC's MAKE_ADDR_OF_CONTEXT_NODE: not in CPP.EXE) ---- */
unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);


/* ---- MAKE_UNARY_NODE (CPP 0874:021C) ---- */

/* MAKE_UNARY_NODE: unanalysed unary node for token op applied to operand. */
unsigned int far pascal MAKE_UNARY_NODE(unsigned int op,unsigned int operand)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_B(node,EXPR_NODE_FLAGS)=0x20;
    EXPR_W(node,EXPR_OP)=TOKEN_TO_OPERATOR(op,1);
    EXPR_W(node,EXPR_LEFT)=operand;
    EXPR_W(node,EXPR_RIGHT)=0;
    return node;
}

/* ---- MAKE_BINARY_NODE (CPP 0874:0254) ---- */

/* MAKE_BINARY_NODE: unanalysed binary node for token op. */
unsigned int far pascal MAKE_BINARY_NODE(unsigned int op,unsigned int left,unsigned int right)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_B(node,EXPR_NODE_FLAGS)=0x20;
    EXPR_W(node,EXPR_OP)=TOKEN_TO_OPERATOR(op,0);
    EXPR_W(node,EXPR_LEFT)=left;
    EXPR_W(node,EXPR_RIGHT)=right;
    return node;
}

/* ---- MAKE_CONDITIONAL_NODE (CPP 0874:028D) ---- */

/* MAKE_CONDITIONAL_NODE: builds left op (first : second); with op = '?' this is the
   conditional expression (token 0x21 is TOK_COLON). */
unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int op,unsigned int left,
    unsigned int first,unsigned int second)
{
    unsigned int node;

    node=MAKE_BINARY_NODE(0x21,first,second);
    return node=MAKE_BINARY_NODE(op,left,node);
}

/* ---- MAKE_CAST_NODE (CPP 0874:02B3) ---- */


/* MAKE_CAST_NODE: cast (operator 0x35) of operand to type, taking the operand's source
   position. */
unsigned int far pascal MAKE_CAST_NODE(unsigned int type,register unsigned int operand)
{
    register unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=0x35;
    EXPR_W(node,EXPR_LEFT)=operand;
    EXPR_W(node,EXPR_RIGHT)=0;
    EXPR_W(node,EXPR_TYPE)=type;
    if(operand)
        *(struct C21Location far *)MK_FP(EXPR_POOL_SEG,node+EXPR_SRC_FILE)=
            *(struct C21Location far *)MK_FP(EXPR_POOL_SEG,operand+EXPR_SRC_FILE);
    return node;
}

/* ---- MAKE_CALL_NODE (CPP 0874:0303) ---- */

/* MAKE_CALL_NODE: call (operator 0x36) of value with up to five arguments (0 = absent),
   chained into a MAKE_LIST_NODE list in EXPR_RIGHT. Used for calls the compiler
   generates itself. */
unsigned int far pascal MAKE_CALL_NODE(unsigned int value,unsigned int first_arg,unsigned int second_arg,
    unsigned int third_arg,unsigned int fourth_arg,unsigned int fifth_arg)
{
    unsigned int list;
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=0x36;
    EXPR_W(node,EXPR_LEFT)=value;
    list=0;
    if(fifth_arg!=0)
        list=MAKE_LIST_NODE(fifth_arg,list);
    if(fourth_arg!=0)
        list=MAKE_LIST_NODE(fourth_arg,list);
    if(third_arg!=0)
        list=MAKE_LIST_NODE(third_arg,list);
    if(second_arg!=0)
        list=MAKE_LIST_NODE(second_arg,list);
    if(first_arg!=0)
        list=MAKE_LIST_NODE(first_arg,list);
    EXPR_W(node,EXPR_RIGHT)=list;
    return node;
}

/* ---- (BCC's BUILD_SYMBOL_EXPR: not in CPP.EXE) ---- */
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern void far pascal QUEUE_DEFERRED_SYMBOL(unsigned int);


/* ---- (BCC's GENERATE_TEMP_NAME: not in CPP.EXE) ---- */
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);


/* ---- (BCC's CREATE_TEMP_SYMBOL: not in CPP.EXE) ---- */
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int,unsigned int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void far pascal C0MARK(unsigned char);


/* ---- (BCC's CREATE_LOCAL_TEMP: not in CPP.EXE) ---- */
extern unsigned int SCOPE_POOL_SEG;
extern void far pascal PUSH_SCOPE(unsigned char);
extern void far pascal APPEND_SCOPE_ENTER_BLOCK(void);
extern void far pascal REGISTER_SYMBOL_VARIABLE(unsigned int);


/* ---- EXPR_HAS_ERROR (CPP 0874:0380) ---- */

/* EXPR_HAS_ERROR: 1 when the tree contains an error node (operator 0). */
static unsigned char far pascal EXPR_HAS_ERROR(register unsigned int node)
{
    if (node==0)
        return 0;
    if (EXPR_W(node,EXPR_OP)==0)
        return 1;
    if (EXPR_OP_FLAGS[EXPR_W(node,EXPR_OP)]&4)
        return 0;
    return EXPR_HAS_ERROR(EXPR_W(node,EXPR_LEFT)) || EXPR_HAS_ERROR(EXPR_W(node,EXPR_RIGHT));
}

/* ---- REPORT_EXPR_ERROR (CPP 0874:03D9) ---- */
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern void far pascal REPORT_DIAGNOSTIC_AT(unsigned int,char far *,long,unsigned int,unsigned int);

/* REPORT_EXPR_ERROR: reports message code (with arguments first and second) at the
   node's source line, unless code is 0 or the tree already contains an error, which
   was then reported before. Frees the tree and returns a fresh error node (operator 0,
   flag 1), so callers can write "return REPORT_EXPR_ERROR(...)". */
unsigned int far pascal REPORT_EXPR_ERROR(register unsigned int code,char far *first,long second,
    register unsigned int node)
{
    if (code && !EXPR_HAS_ERROR(node)) {
        if (node==0 || EXPR_W(node,EXPR_SRC_LINE)==0)
            REPORT_DIAGNOSTIC(code,first,second);
        else
            REPORT_DIAGNOSTIC_AT(code,first,second,EXPR_W(node,EXPR_SRC_LINE),0);
    }
    FREE_EXPR_TREE(node);
    node=ALLOC_EXPR_NODE();
    EXPR_B(node,EXPR_NODE_FLAGS)=1;
    return node;
}

/* ---- REPORT_EXPR_ERROR_PLAIN (CPP 0874:044D) ---- */

unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int code,unsigned int node)
{
    return REPORT_EXPR_ERROR(code,(char far *)0,0L,node);
}

/* ---- SWAP_OPERANDS (CPP 0874:0466) ---- */

/* SWAP_OPERANDS: exchanges a node's left and right operand and returns it. */
unsigned int far pascal SWAP_OPERANDS(register unsigned int node)
{
    unsigned int left;

    left=EXPR_W(node,EXPR_LEFT);
    EXPR_W(node,EXPR_LEFT)=EXPR_W(node,EXPR_RIGHT);
    EXPR_W(node,EXPR_RIGHT)=left;
    return node;
}

/* ---- (BCC's JOIN_COMMA_EXPR: not in CPP.EXE) ---- */


/* ---- (BCC's NEAR_PTR_BASES_MATCH: not in CPP.EXE) ---- */

/* NEAR_PTR_BASES_MATCH: 1 when two pointer types may be converted into each other as far
   as their segment is concerned: anything not a near pointer and void pointers pass;
   ... (BCC's comment, cut short with the function.) */

/* ---- (BCC's C7_TYPE_COMPAT: not in CPP.EXE) ---- */
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
extern unsigned char far pascal SAME_SIGNATURE(unsigned int,unsigned int);


/* ---- PICK_WIDER_TYPE (CPP 0874:0492) ---- */

/* PICK_WIDER_TYPE: of two arithmetic types, the one with the larger kind number (kinds
   are ordered by rank); 0 if either is missing. */
unsigned int far pascal PICK_WIDER_TYPE(register unsigned int first,register unsigned int second)
{
    if (first==0 || second==0)
        return 0;
    if (TYPE_I(first,TYPE_KIND)>TYPE_I(second,TYPE_KIND))
        return first;
    return second;
}

/* ---- CHECK_NULL_CONSTANT (CPP 0874:04C1) ---- */
unsigned char far pascal IS_LINK_TIME_CONSTANT(unsigned int expression);

/* CHECK_NULL_CONSTANT: simplifies expression if it is a constant expression and sets
   *zero when it is the integer 0, i.e. a null pointer constant. Returns the (possibly
   simplified) expression. */
unsigned int far pascal CHECK_NULL_CONSTANT(register unsigned int expression,unsigned char far *zero)
{
    *zero=0;
    if (IS_LINK_TIME_CONSTANT(expression)) {
        if (EXPR_W(expression,EXPR_OP)!=EOP_CONST && EXPR_W(expression,EXPR_OP)!=3)
            expression=SIMPLIFY_EXPRESSION(expression,0);
        if (EXPR_W(expression,EXPR_OP)==EOP_CONST)
            *zero=EXPR_L(expression,EXPR_VALUE)==0;
    }
    return expression;
}

/* ---- NULL_CONSTANT_TO_POINTER (CPP 0874:051C) ---- */
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);

/* The test of type!=0 appears twice in the code: the macro repeats it. */
/* Despite its name, IS_AGGREGATE tests for a pointer kind (EXPR_FLAGS bits 0x14). */
#define IS_AGGREGATE(t) ((t)!=0 && (EXPR_FLAGS[TYPE_W((t),TYPE_KIND)]&0x14))

/* NULL_CONSTANT_TO_POINTER: when type is a pointer (not a reference) and expression is a
   null pointer constant, gives the constant that pointer type (a member function
   pointer needs a real conversion). Otherwise returns expression unchanged. */
unsigned int far pascal NULL_CONSTANT_TO_POINTER(register unsigned int type,register unsigned int expression)
{
    unsigned char zero;

    if (type!=0 && IS_AGGREGATE(type) && !(TYPE_B(type,TYPE_ATTRS)&0x20)) {
        expression=CHECK_NULL_CONSTANT(expression,&zero);
        if (zero) {
            if (TYPE_W(type,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(type,TYPE_PTR_MODE)==0x0B &&
                    (EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(type,TYPE_TARGET),TYPE_KIND)==TK_FUNCTION)
                expression=CONVERT_EXPR_TO_TYPE(type,expression,0);
            else
                EXPR_W(expression,EXPR_TYPE)=type;
        }
    }
    return expression;
}
#undef IS_AGGREGATE

/* ---- (BCC's IS_LVALUE: not in CPP.EXE) ---- */


/* ---- (BCC's IS_SIDE_EFFECT_FREE: not in CPP.EXE) ---- */

/* IS_SIDE_EFFECT_FREE: 1 when evaluating the tree changes nothing (no assignment, call,
   increment...), so it may be evaluated twice or dropped. A null tree counts as free;
   ... (BCC's comment, cut short with the function.) */

/* ---- IS_CONSTANT_EXPR (CPP 0874:05A1) ---- */

/* IS_CONSTANT_EXPR: 1 when the tree is a compile-time arithmetic constant (sizeof
   counts; anything touching an object or address does not). A cast is constant when it
   converts an arithmetic link-time constant to an integer type. */
char far pascal IS_CONSTANT_EXPR(register unsigned int expression)
{
    if (expression==0 || EXPR_W(expression,EXPR_OP)==0)
        return 1;
    switch (EXPR_W(expression,EXPR_OP)) {
    case 0x35:
        return (EXPR_FLAGS[TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)]&1) &&
            (EXPR_FLAGS[TYPE_W(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_TYPE),TYPE_KIND)]&3) &&
            IS_LINK_TIME_CONSTANT(EXPR_W(expression,EXPR_LEFT));
    case 0x01: case 0x03: case 0x07: case EOP_COMMA: case EOP_DEREF: case EOP_ADDR: case 0x38:
    case 0x39: case EOP_INDEX: case EOP_DOT: case EOP_DOT_STAR: case EOP_ARROW: case EOP_ARROW_STAR: case 0x48:
        return 0;
    case EOP_CONST: case EOP_SIZEOF:
        return 1;
    }
    return !(EXPR_OP_FLAGS[EXPR_W(expression,EXPR_OP)]&1) &&
        IS_CONSTANT_EXPR(EXPR_W(expression,EXPR_LEFT)) && IS_CONSTANT_EXPR(EXPR_W(expression,EXPR_RIGHT));
}

/* ---- IS_LINK_TIME_CONSTANT (CPP 0874:06AC) ---- */

/* IS_LINK_TIME_CONSTANT: 1 when the value is known by link time: constants, addresses of
   static objects and functions (storage class < 5), arrays with static storage, and
   arithmetic on those. Used by CHECK_NULL_CONSTANT (in BCC also for static
   initialisers). */
unsigned char far pascal IS_LINK_TIME_CONSTANT(unsigned int expression)
{
    register unsigned int symbol;

    if (expression==0 || EXPR_W(expression,EXPR_OP)==0)
        return 1;
    switch (EXPR_W(expression,EXPR_OP)) {
    case EOP_ADDR:
        if (EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==EOP_DEREF)
            return IS_LINK_TIME_CONSTANT(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT));
        if (EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==1)
            return (SYM_B(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT),SYM_STORAGE_CLASS)>>3)<5;
        return IS_LINK_TIME_CONSTANT(EXPR_W(expression,EXPR_LEFT));
    case 0x07: case EOP_COMMA: case EOP_DEREF: case 0x38: case 0x39: case EOP_INDEX: case EOP_DOT_STAR:
    case EOP_ARROW: case EOP_ARROW_STAR:
        return 0;
    case EOP_DOT:
        if (EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_OP)==1)
            return (SYM_B(EXPR_W(EXPR_W(expression,EXPR_LEFT),EXPR_LEFT),SYM_STORAGE_CLASS)>>3)<5;
        return IS_LINK_TIME_CONSTANT(EXPR_W(expression,EXPR_LEFT));
    case 0x01:
        symbol=EXPR_W(expression,EXPR_LEFT);
        return (SYM_B(symbol,SYM_STORAGE_CLASS)>>3)==9 || TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_KIND)==TK_FUNCTION ||
            ((SYM_B(symbol,SYM_STORAGE_CLASS)>>3)<5 && TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_KIND)==TK_ARRAY);
    case EOP_CONST: case 0x03: case EOP_SIZEOF: case 0x48:
        return 1;
    }
    return !(EXPR_OP_FLAGS[EXPR_W(expression,EXPR_OP)]&1) &&
        IS_LINK_TIME_CONSTANT(EXPR_W(expression,EXPR_LEFT)) && IS_LINK_TIME_CONSTANT(EXPR_W(expression,EXPR_RIGHT));
}

/* ---- (BCC's IS_NAMED_OBJECT_EXPR: not in CPP.EXE) ---- */


/* ---- (BCC's EXPRESSIONS_EQUAL: not in CPP.EXE) ---- */
extern int far pascal RTL_LDOUBLE_COMPARE(void far *,void far *);


/* ---- (BCC's COPY_EXPR_TREE: not in CPP.EXE) ---- */
struct C023Node { unsigned int words[13]; };


/* ---- (BCC's FIND_BASE_SYMBOL: not in CPP.EXE) ---- */


/* ---- (BCC's SAVE_EXPR_IN_TEMP: not in CPP.EXE) ---- */
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned int far pascal MAKE_ADDRESS_OF(unsigned int);


/* ---- (BCC's APPEND_TEMP_DESTRUCTORS: not in CPP.EXE) ---- */
extern unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern void far pascal FREE_TEMP_ENTRY(unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);

