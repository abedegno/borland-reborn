/* target: ovr091_C234UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: expressions: expression node pool: allocate/free nodes and trees, constants,
   temporaries, null pointer constants, copying and comparing trees. Entry points:
   ALLOC_EXPR_NODE, RESET_EXPR_POOL_ALT, FREE_EXPR_TREE, FREE_EXPR_NODE, MAKE_LIST_NODE,
   MAKE_INT_CONSTANT, MAKE_REAL_CONSTANT, MAKE_SYMBOL_NODE (+29 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the basic toolkit for expression trees in the C++-mode front end (the
   STMTCPP.C side; the C-mode side has its own in expr/EXPRMAKE.C). Expression
   nodes are 0x1A-byte records in EXPR_POOL_SEG (fields EXPR_*: operator, type, flags,
   left and right operand, source position). This file allocates and frees them
   (ALLOC_EXPR_NODE, FREE_EXPR_TREE), builds the common node shapes (constants, symbol
   leaves, unary, binary, cast, call and list nodes), creates compiler temporaries, and
   answers questions about trees: is it an lvalue, free of side effects, a constant, a
   link-time constant, are two trees equal; it also copies trees.
   Things to know:
   - MAKE_UNARY_NODE, MAKE_BINARY_NODE and MAKE_CONDITIONAL_NODE take a token code
     (TOKEN.H, e.g. 0x18 TOK_STAR, 0x0B TOK_ASSIGN, 8 TOK_COMMA), not an operator;
     TOKEN_TO_OPERATOR turns it into an EOP_* operator through TOKEN_OPERATOR_CODE.
     Nodes they make get flag 0x20, "not analysed yet, may be an overloaded operator".
     The other constructors store operator numbers directly.
   - Operators that have no EXPROP.H name are written as numbers: 0 an error node,
     1 a symbol leaf (EXPR_LEFT = symbol), 3 a long double constant (10 bytes at
     EXPR_LEFT), 7 probably the "..." leaf (see MAKE_ADDR_OF_CONTEXT_NODE), 0x2B an
     argument-list cell, 0x35 a cast, 0x36 a call, 0x38 a member-name node, 0x39 a
     member (field) node, 0x4A a field reference; 0x42 and 0x48 also occur.
   - EXPR_OP_FLAGS[op] bits used here: 4 = leaf (its left/right words are data, not
     children), 1 = has a side effect, 2 = commutative.
   - SYM_STORAGE_CLASS >> 3 as used here: < 5 has a static address, 5 automatic, 6
     probably register, 9 a constant (probably an enumerator).
   - CPP_MODE is the C++ mode flag; INT_TYPE is the int type. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"

/* ---- TOKEN_TO_OPERATOR (listing E050) ---- */
/* row TOKEN_TO_OPERATOR (offset 0x0): stub none (static) = TOKEN_TO_OPERATOR */

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

/* ---- ALLOC_EXPR_NODE (listing E0B1) ---- */
/* row ALLOC_EXPR_NODE (offset 0x61): stub 0C43:00A2 = ALLOC_EXPR_NODE */
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

/* ---- RESET_EXPR_POOL_ALT (listing E0F4) ---- */
/* row RESET_EXPR_POOL_ALT (offset 0xA4): stub 0C43:0070 = RESET_EXPR_POOL_ALT */

/* RESET_EXPR_POOL_ALT: empties the whole expression pool at once (same body as
   RESET_EXPR_POOL in expr/EXPRMAKE.C). */
void far pascal RESET_EXPR_POOL_ALT(void)
{
    EXPR_POOL_USED=0;
    EXPR_POOL_UNIT=2;
}

/* ---- X023_20 (listing E105) ---- */
/* row X023_20 (offset 0xB5): stub 0C43:0043 = FREE_EXPR_TREE */
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

/* ---- X023_1D (listing E185) ---- */
/* row X023_1D (offset 0x135): stub 0C43:006B = FREE_EXPR_NODE */

void far pascal FREE_EXPR_NODE(unsigned int node)
{
    POOL_FREE_ITEM(&EXPR_POOL_SEG,node);
}

/* ---- X023_02 (listing E199) ---- */
/* row X023_02 (offset 0x149): stub 0C43:00B6 = MAKE_LIST_NODE */

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

/* ---- FREE_EXPR_TREE (listing E1C8) ---- */
/* row FREE_EXPR_TREE (offset 0x178): stub 0C43:00C5 = MAKE_INT_CONSTANT */

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

/* ---- MAKE_REAL_CONSTANT (listing E1FC) ---- */
/* row MAKE_REAL_CONSTANT (offset 0x1AC): stub 0C43:0098 = MAKE_REAL_CONSTANT */
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

/* ---- X023_17 (listing E23B) ---- */
/* row X023_17 (offset 0x1EB): stub 0C43:0093 = MAKE_SYMBOL_NODE */

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

/* ---- X023_10 (listing E268) ---- */
/* row X023_10 (offset 0x218): stub 0C43:007A = MAKE_MEMBER_NAME_NODE */

/* MAKE_MEMBER_NAME_NODE: operator 0x38 leaf for a member name; extra goes to
   EXPR_NAME_KIND (2 for a conversion operator). */
unsigned int far pascal MAKE_MEMBER_NAME_NODE(unsigned int symbol,unsigned int extra)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=0x38;
    EXPR_W(node,EXPR_LEFT)=symbol;
    EXPR_W(node,EXPR_RIGHT)=0;
    EXPR_W(node,EXPR_SCOPE_CLASS)=0;
    EXPR_W(node,EXPR_NAME_KIND)=extra;
    return node;
}

/* ---- X023_13 (listing E29C) ---- */
/* row X023_13 (offset 0x24C): stub 0C43:007F = MAKE_FIELD_REF_NODE */

/* MAKE_FIELD_REF_NODE: operator 0x4A leaf holding value in EXPR_LEFT. */
unsigned int far pascal MAKE_FIELD_REF_NODE(unsigned int value)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=0x4A;
    EXPR_W(node,EXPR_LEFT)=value;
    EXPR_W(node,EXPR_RIGHT)=0;
    return node;
}

/* ---- MAKE_MEMBER_NODE (listing E2C3) ---- */
/* row MAKE_MEMBER_NODE (offset 0x273): stub 0C43:0052 = MAKE_MEMBER_NODE */
struct C21Location { unsigned int first,second,third; };

/* MAKE_MEMBER_NODE: operator 0x39 node for a class member: type, offset (MEMB_VALUE),
   name and, for a bitfield (MEMB_FLAGS 0x40), the shift and width with node flag 4.
   location is the source position to give the node. */
unsigned int far pascal MAKE_MEMBER_NODE(register unsigned int member,struct C21Location location)
{
    register unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_B(node,EXPR_NODE_FLAGS)=1;
    EXPR_W(node,EXPR_OP)=0x39;
    *(struct C21Location far *)MK_FP(EXPR_POOL_SEG,node+EXPR_SRC_FILE)=location;
    EXPR_W(node,EXPR_TYPE)=MEMBER_W(member,MEMB_TYPE);
    EXPR_W(node,EXPR_LEFT)=MEMBER_W(member,MEMB_VALUE);
    EXPR_B(node,EXPR_MEMB_BIT_SHIFT)=0;
    EXPR_B(node,EXPR_MEMB_BIT_WIDTH)=0;
    EXPR_W(node,EXPR_MEMBER_NAME)=MEMBER_W(member,MEMB_NAME);
    if(MEMBER_B(member,MEMB_FLAGS)&0x40) {
        EXPR_B(node,EXPR_NODE_FLAGS)|=4;
        EXPR_B(node,EXPR_MEMB_BIT_SHIFT)=MEMBER_B(member,MEMB_BITFIELD)&7;
        EXPR_B(node,EXPR_MEMB_BIT_WIDTH)=MEMBER_B(member,MEMB_BITFIELD)>>3;
    }
    EXPR_W(node,EXPR_TYPE)=MEMBER_W(member,MEMB_TYPE);    /* stored a second time, as in the original (031C-0328) */
    return node;
}

/* ---- X023_15 (listing E384) ---- */
/* row X023_15 (offset 0x334): stub 0C43:0089 = MAKE_ADDR_OF_CONTEXT_NODE */
unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);

/* MAKE_ADDR_OF_CONTEXT_NODE: builds "& <operator 7 leaf of type int>" with type
   pointer-to-int, both marked analysed. Operator 7 is probably the "..." leaf that the
   C-mode parser (STUNARY in expr/EXPRPARS.C) builds for the token "..." inside a
   variadic function, as Turbo C's va_start uses it: its address is the start of the
   unnamed arguments. */
unsigned int far pascal MAKE_ADDR_OF_CONTEXT_NODE(void)
{
    unsigned int node;

    node=ALLOC_EXPR_NODE();
    EXPR_W(node,EXPR_OP)=7;
    EXPR_W(node,EXPR_LEFT)=0;
    EXPR_W(node,EXPR_RIGHT)=0;
    EXPR_W(node,EXPR_SCOPE_CLASS)=0;
    EXPR_W(node,EXPR_TYPE)=INT_TYPE;
    EXPR_B(node,EXPR_NODE_FLAGS)=1;
    node=MAKE_UNARY_NODE(0x1B,node);
    EXPR_W(node,EXPR_TYPE)=MAKE_POINTER_TYPE(INT_TYPE,0,0);
    EXPR_B(node,EXPR_NODE_FLAGS)=1;
    return node;
}

/* ---- X023_0E (listing E3E2) ---- */
/* row X023_0E (offset 0x392): stub 0C43:002F = MAKE_UNARY_NODE */

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

/* ---- X023_05 (listing E41A) ---- */
/* row X023_05 (offset 0x3CA): stub 0C43:00BB = MAKE_BINARY_NODE */

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

/* ---- X023_0F (listing E453) ---- */
/* row X023_0F (offset 0x403): stub 0C43:0039 = MAKE_CONDITIONAL_NODE */

/* MAKE_CONDITIONAL_NODE: builds left op (first : second); with op = '?' this is the
   conditional expression (token 0x21 is TOK_COLON). */
unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int op,unsigned int left,
    unsigned int first,unsigned int second)
{
    unsigned int node;

    node=MAKE_BINARY_NODE(0x21,first,second);
    return node=MAKE_BINARY_NODE(op,left,node);
}

/* ---- X023_12 (listing E479) ---- */
/* row X023_12 (offset 0x429): stub 0C43:0084 = MAKE_CAST_NODE */


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

/* ---- X023_14 (listing E4C9) ---- */
/* row X023_14 (offset 0x479): stub 0C43:008E = MAKE_CALL_NODE */

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

/* ---- BUILD_SYMBOL_EXPR (listing E546) ---- */
/* row BUILD_SYMBOL_EXPR (offset 0x4F6): stub 0C43:009D = BUILD_SYMBOL_EXPR */
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern void far pascal QUEUE_DEFERRED_SYMBOL(unsigned int);

/* BUILD_SYMBOL_EXPR: builds, analyses and simplifies the expression for one symbol (with
   token 0x1D as its unary operator), with CURRENT_CLASS_TYPE set to the symbol's class
   for a member. Marks the symbol used (SYM_FLAGS 4); in C++ a function is also queued
   with QUEUE_DEFERRED_SYMBOL, probably so its body is generated later. */
unsigned int far pascal BUILD_SYMBOL_EXPR(register unsigned int symbol)
{
    unsigned int saved;
    unsigned int result;

    saved=CURRENT_CLASS_TYPE;
    CURRENT_CLASS_TYPE=(SYM_B(symbol,SYM_FLAGS)&0x10) ? SYM_W(SYM_W(symbol,SYM_OWNER_CLASS),SYM_TYPE) : 0;
    result=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(MAKE_UNARY_NODE(0x1D,MAKE_SYMBOL_NODE(symbol)),0),0);
    SYM_B(symbol,SYM_FLAGS)|=4;
    if(CPP_MODE && TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_KIND)==TK_FUNCTION)
        QUEUE_DEFERRED_SYMBOL(symbol);
    CURRENT_CLASS_TYPE=saved;
    return result;
}

/* ---- GENERATE_TEMP_NAME (listing E5C6) ---- */
/* row GENERATE_TEMP_NAME (offset 0x576): stub none (static) = GENERATE_TEMP_NAME */
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);

/* GENERATE_TEMP_NAME: invents the next temporary name, "_$" followed by the counter
   TEMP_NAME_COUNTER written in base 26 with letters (A, B, ... least significant
   first), and returns its name record. */
static unsigned int far pascal GENERATE_TEMP_NAME(void)
{
    char name[20];
    /* Initialisers, not statements: the original sets p (057D-0583) before it
       reads and increments TEMP_NAME_COUNTER (0586), and loads the count through AX. */
    char far *p=(char far *)name;
    unsigned int count=TEMP_NAME_COUNTER++;

    *p++='_';
    *p++='$';
    do {
        *p++=count%26+'A';
        count/=26;
    } while(count!=0);
    *p=0;
    return BCC_SYMBOL_CREATE((char far *)name,0);
}

/* ---- X023_0D (listing E630) ---- */
/* row X023_0D (offset 0x5E0): stub 0C43:0034 = CREATE_TEMP_SYMBOL */
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int,unsigned int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void far pascal C0MARK(unsigned char);

/* CREATE_TEMP_SYMBOL: a static temporary of the given type: class 3 at file level, 4
   inside a function; global puts it in the data segment (initialised), otherwise in BSS. */
unsigned int far pascal CREATE_TEMP_SYMBOL(unsigned int type,unsigned char global)
{
    unsigned int symbol;

    symbol=ALLOC_SYMBOL_ENTRY(GENERATE_TEMP_NAME(),5);
    SYM_W(symbol,SYM_TYPE)=type;
    SYM_B(symbol,SYM_FLAGS)=0x22;
    SYM_W(symbol,SYM_STORAGE)=0;
    if(global)
        SYM_B(symbol,SYM_FLAGS)|=5;
    SYM_B(symbol,SYM_STORAGE_CLASS)=SYM_B(symbol,SYM_STORAGE_CLASS)&7|((CURRENT_SCOPE==GLOBAL_SCOPE ? 3 : 4)&0x1F)<<3;
    SET_SYMBOL_SEGMENT_HOOK(PREPARE_SYMBOL(symbol),global ? DATA_SEGMENT_ID : BSS_SEGMENT_ID);
    C0MARK(1);
    return symbol;
}

/* ---- X023_04 (listing E6BB) ---- */
/* row X023_04 (offset 0x66B): stub 0C43:00C0 = CREATE_LOCAL_TEMP */
extern unsigned int SCOPE_POOL_SEG;
extern void far pascal PUSH_SCOPE(unsigned char);
extern void far pascal APPEND_SCOPE_ENTER_BLOCK(void);
extern void far pascal REGISTER_SYMBOL_VARIABLE(unsigned int);

/* CREATE_LOCAL_TEMP: an automatic (class 5) temporary of the given type, registered as a
   variable of the function. When the parser is inside a nested block that has no scope
   of its own yet, a scope is opened first so the temporary lives in that block. */
unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int type)
{
    register unsigned int symbol;

    if (NO_ERRORS_YET && SCOPE_W(CURRENT_SCOPE,SCOPE_NEST_LEVEL)!=BLOCK_NEST_LEVEL) {
        PUSH_SCOPE(0);
        if (INLINE_EXPANSION_DEPTH)
            SCOPE_W(CURRENT_SCOPE,SCOPE_ENTER_BLOCK)=SCOPE_W(SCOPE_W(CURRENT_SCOPE,SCOPE_PARENT),SCOPE_ENTER_BLOCK);
        else
            APPEND_SCOPE_ENTER_BLOCK();
    }
    symbol=ALLOC_SYMBOL_ENTRY(GENERATE_TEMP_NAME(),5);
    SYM_W(symbol,SYM_TYPE)=type;
    SYM_B(symbol,SYM_FLAGS)|=0x26;
    SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&7)|0x28;
    SYM_W(symbol,SYM_STORAGE)=0;
    REGISTER_SYMBOL_VARIABLE(symbol);
    return symbol;
}

/* ---- EXPR_HAS_ERROR (listing E744) ---- */
/* row EXPR_HAS_ERROR (offset 0x6F4): stub none (static) = EXPR_HAS_ERROR */

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

/* ---- X023_21 (listing E79D) ---- */
/* row X023_21 (offset 0x74D): stub 0C43:003E = REPORT_EXPR_ERROR */
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

/* ---- X023_09 (listing E811) ---- */
/* row X023_09 (offset 0x7C1): stub 0C43:00CF = REPORT_EXPR_ERROR_PLAIN */

unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int code,unsigned int node)
{
    return REPORT_EXPR_ERROR(code,(char far *)0,0L,node);
}

/* ---- SWAP_OPERANDS (listing E82A) ---- */
/* row SWAP_OPERANDS (offset 0x7DA): stub 0C43:0048 = SWAP_OPERANDS */

/* SWAP_OPERANDS: exchanges a node's left and right operand and returns it. */
unsigned int far pascal SWAP_OPERANDS(register unsigned int node)
{
    unsigned int left;

    left=EXPR_W(node,EXPR_LEFT);
    EXPR_W(node,EXPR_LEFT)=EXPR_W(node,EXPR_RIGHT);
    EXPR_W(node,EXPR_RIGHT)=left;
    return node;
}

/* ---- X023_0C (listing E856) ---- */
/* row X023_0C (offset 0x806): stub 0C43:0025 = JOIN_COMMA_EXPR */

/* JOIN_COMMA_EXPR: "left, right", or just the one that is not 0. The comma is marked
   as not needing operator lookup (flag 0x20 cleared). */
unsigned int far pascal JOIN_COMMA_EXPR(register unsigned int left,unsigned int right)
{
    register unsigned int result;

    if (left==0)
        result=right;
    else if (right==0)
        result=left;
    else {
        result=MAKE_BINARY_NODE(8,left,right);
        EXPR_B(result,EXPR_NODE_FLAGS)&=~0x20;
    }
    return result;
}

/* ---- NEAR_PTR_BASES_MATCH (listing E890) ---- */
/* row NEAR_PTR_BASES_MATCH (offset 0x840): stub none (static) = NEAR_PTR_BASES_MATCH */

/* NEAR_PTR_BASES_MATCH: 1 when two pointer types may be converted into each other as far
   as their segment is concerned: anything not a near pointer and void pointers pass;
   near pointers need the same TYPE_PTR_MODE (modes 3 and 4 are accepted together
   depending on the DS/SS options, probably when SS equals DS) and the same base name
   for based pointers. */
static unsigned char far pascal NEAR_PTR_BASES_MATCH(register unsigned int left,register unsigned int right)
{
    int lsize,rsize;

    if (TYPE_W(left,TYPE_KIND)!=TK_NEAR_PTR ||
            ((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(left,TYPE_TARGET),TYPE_KIND)==TK_VOID) ||
            ((EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(right,TYPE_TARGET),TYPE_KIND)==TK_VOID))
        return 1;
    lsize=TYPE_SC(left,TYPE_PTR_MODE);
    rsize=TYPE_SC(right,TYPE_PTR_MODE);
    if (lsize!=rsize) {
        if ((lsize==3 && rsize==4) || (lsize==4 && rsize==3))
            /* Bitwise & of a flag and a logical not, as in the original (08C2-08D1:
               cbw, neg/sbb/inc, test ax,dx); the signed char casts give its cbw. */
            return !(OPTION_DS_NOT_SS || ((signed char)MODEL_FAR_DATA & !(signed char)OPTION_SS_EQUALS_DS));
        return 0;
    }
    if (TYPE_W(left,TYPE_PTR_BASE)!=0 || TYPE_W(right,TYPE_PTR_BASE)!=0) {
        if (TYPE_W(left,TYPE_PTR_BASE)==0 || TYPE_W(right,TYPE_PTR_BASE)==0 ||
                COMPARE_NAME(MK_FP(POOL_HASH,TYPE_W(left,TYPE_PTR_BASE)),MK_FP(POOL_HASH,TYPE_W(right,TYPE_PTR_BASE))))
            return 0;
    }
    return 1;
}

/* ---- IS_CONSTANT_EXPR (listing E97B) ---- */
/* row IS_CONSTANT_EXPR (offset 0x92B): stub 0C43:002A = C7_TYPE_COMPAT */
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
extern unsigned char far pascal SAME_SIGNATURE(unsigned int,unsigned int);

/* The early returns share exits in the original: BC cross-jumps the identical
   "return 1" and "return 0" copies onto one mov al,1 (0960) and one mov al,0
   (0C48), and both IS_BASE_CLASS(...,1) tails onto one call (0C3C).  The
   "if (BEC2(...)==0) return 0;" and the "==" test around the inner block keep
   the original's branch shapes (a long-branch label does not reset -Z).  The
   repeated EXPR_FLAGS&0x14 test on the left type is in the original too; it
   reads like an IS_AGGREGATE(t) && TYPE_W(TYPE_W(t,TYPE_TARGET),TYPE_KIND)==TK_VOID idiom
   (IS_AGGREGATE is the macro below, which despite its name tests for a pointer, so the
   idiom means "is a void pointer"). */
/* C7_TYPE_COMPAT: 1 when a value of type right may be assigned to (or initialise) type
   left without a cast. Arithmetic types always mix; with strict also integers and
   pointers (C only, or C++ when no reference is involved). Member pointers need a
   base-class relation and the same target; ordinary pointers: void * on the left takes
   anything (and in C, void * on the right converts to anything), otherwise qualifiers
   may be added but not dropped and the targets must be compatible or, in C++, the right
   target a class derived from the left. In C++ a class object converts to a base class. */
unsigned char far pascal C7_TYPE_COMPAT(register unsigned int left,register unsigned int right,
    unsigned char strict)
{
    unsigned int rbase,lbase;
    unsigned char same;
    unsigned int lsave,rsave;

    if (TYPES_COMPATIBLE(left,right,1) ||
            ((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&3) && (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&3)))
        return 1;
    if (TYPE_W(left,TYPE_KIND)==TK_SEG_PTR && (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14) && TYPE_W(right,TYPE_KIND)!=TK_SEG_PTR)
        return 0;
    if (strict && (EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x15) && (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x15)) {
        if (CPP_MODE==0 ||
                !(((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) && (TYPE_B(left,TYPE_ATTRS)&0x20)) ||
                  ((EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14) && (TYPE_B(right,TYPE_ATTRS)&0x20))))
            return 1;
    }
    if (TYPE_W(left,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(left,TYPE_PTR_MODE)==0x0B && TYPE_W(right,TYPE_KIND)==TK_NEAR_PTR && TYPE_B(right,TYPE_PTR_MODE)==0x0B) {
        lbase=TYPE_W(left,TYPE_TARGET);
        rbase=TYPE_W(right,TYPE_TARGET);
        if (IS_BASE_CLASS(TYPE_W(rbase,TYPE_MEMBER_CLASS),TYPE_W(lbase,TYPE_MEMBER_CLASS),1)==0)
            return 0;
        if (TYPE_W(lbase,TYPE_KIND)==TYPE_W(rbase,TYPE_KIND) && TYPE_W(lbase,TYPE_KIND)==TK_FUNCTION)
            return SAME_SIGNATURE(lbase,rbase);
        lsave=TYPE_W(lbase,TYPE_MEMBER_CLASS);
        rsave=TYPE_W(rbase,TYPE_MEMBER_CLASS);
        TYPE_W(lbase,TYPE_MEMBER_CLASS)=0;
        TYPE_W(rbase,TYPE_MEMBER_CLASS)=0;
        same=TYPES_COMPATIBLE(lbase,rbase,1);
        TYPE_W(lbase,TYPE_MEMBER_CLASS)=lsave;
        TYPE_W(rbase,TYPE_MEMBER_CLASS)=rsave;
        return same;
    }
    if ((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) && (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14) &&
            NEAR_PTR_BASES_MATCH(left,right)) {
        if (((EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(left,TYPE_TARGET),TYPE_KIND)==TK_VOID) ||
                (!CPP_MODE && (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x14) && TYPE_W(TYPE_W(right,TYPE_TARGET),TYPE_KIND)==TK_VOID))
            return 1;
        if ((TYPE_B(left,TYPE_ATTRS)&0x20)==(TYPE_B(right,TYPE_ATTRS)&0x20)) {
            lbase=TYPE_W(left,TYPE_TARGET);
            rbase=TYPE_W(right,TYPE_TARGET);
            if ((TYPE_B(lbase,TYPE_ATTRS)&1)<(TYPE_B(rbase,TYPE_ATTRS)&1) || (TYPE_B(lbase,TYPE_ATTRS)&2)<(TYPE_B(rbase,TYPE_ATTRS)&2))
                return 0;
            if ((TYPE_B(left,TYPE_ATTRS)&0x20) && TYPE_W(lbase,TYPE_KIND)==TK_ARRAY && TYPE_W(rbase,TYPE_KIND)==TK_ARRAY) {
                if (TYPE_L(lbase,TYPE_ARRAY_COUNT)==0 || TYPE_L(rbase,TYPE_ARRAY_COUNT)==TYPE_L(lbase,TYPE_ARRAY_COUNT))
                    return TYPES_COMPATIBLE(TYPE_W(lbase,TYPE_TARGET),TYPE_W(rbase,TYPE_TARGET),1);
                return 0;
            } else {
                if (TYPES_COMPATIBLE(lbase,rbase,1))
                    return 1;
                if (CPP_MODE && (EXPR_FLAGS[TYPE_W(lbase,TYPE_KIND)]&0x40) && (EXPR_FLAGS[TYPE_W(rbase,TYPE_KIND)]&0x40))
                    return IS_BASE_CLASS(lbase,rbase,1);
            }
        }
    } else if (CPP_MODE && (EXPR_FLAGS[TYPE_W(left,TYPE_KIND)]&0x40) && (EXPR_FLAGS[TYPE_W(right,TYPE_KIND)]&0x40))
        return IS_BASE_CLASS(left,right,1);
    return 0;
}

/* ---- X023_0A (listing ECA2) ---- */
/* row X023_0A (offset 0xC52): stub 0C43:0020 = PICK_WIDER_TYPE */

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

/* ---- CHECK_NULL_CONSTANT (listing ECD1) ---- */
unsigned char far pascal IS_LINK_TIME_CONSTANT(unsigned int expression);
/* row CHECK_NULL_CONSTANT (offset 0xC81): stub 0C43:0075 = CHECK_NULL_CONSTANT */

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

/* ---- NULL_CONSTANT_TO_POINTER (listing ED2C) ---- */
/* row NULL_CONSTANT_TO_POINTER (offset 0xCDC): stub 0C43:00D4 = NULL_CONSTANT_TO_POINTER */
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);

/* The test of type!=0 appears twice in the original: the macro repeats it. */
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

/* ---- X023_06 (listing EDB1) ---- */
/* row X023_06 (offset 0xD61): stub 0C43:00CA = IS_LVALUE */

/* IS_LVALUE: 1 for expressions that designate an object: symbols, *p, members, a[i],
   p->m, p->*m, and . / .* when both sides are lvalues. */
unsigned char far pascal IS_LVALUE(register unsigned int expression)
{
    if (expression==0 || EXPR_W(expression,EXPR_OP)==0)
        return 0;
    switch (EXPR_W(expression,EXPR_OP)) {
    case 0x01: case EOP_DEREF: case 0x38: case 0x39: case EOP_INDEX: case EOP_ARROW: case EOP_ARROW_STAR: case 0x4A:
        return 1;
    case EOP_DOT: case EOP_DOT_STAR:
        return IS_LVALUE(EXPR_W(expression,EXPR_LEFT)) && IS_LVALUE(EXPR_W(expression,EXPR_RIGHT));
    }
    return 0;
}

/* ---- X023_00 (listing EE4A) ---- */
/* row X023_00 (offset 0xDFA): stub 0C43:00AC = IS_SIDE_EFFECT_FREE */

/* IS_SIDE_EFFECT_FREE: 1 when evaluating the tree changes nothing (no assignment, call,
   increment...), so it may be evaluated twice or dropped. A null tree counts as free;
   an error node does not. */
unsigned char far pascal IS_SIDE_EFFECT_FREE(register unsigned int expression)
{
    if (expression==0 || EXPR_W(expression,EXPR_OP)==0)
        return expression==0;
    switch (EXPR_W(expression,EXPR_OP)) {
    case 0x01: case EOP_CONST: case 0x03: case 0x07: case 0x39:
        return 1;
    }
    return !(EXPR_OP_FLAGS[EXPR_W(expression,EXPR_OP)]&1) &&
        IS_SIDE_EFFECT_FREE(EXPR_W(expression,EXPR_LEFT)) && IS_SIDE_EFFECT_FREE(EXPR_W(expression,EXPR_RIGHT));
}

/* ---- X023_1C (listing EEE1) ---- */
/* row X023_1C (offset 0xE91): stub 0C43:0057 = IS_CONSTANT_EXPR */

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

/* ---- IS_LINK_TIME_CONSTANT (listing EFEC) ---- */
/* row IS_LINK_TIME_CONSTANT (offset 0xF9C): stub 0C43:004D = IS_LINK_TIME_CONSTANT */

/* IS_LINK_TIME_CONSTANT: 1 when the value is known by link time: constants, addresses of
   static objects and functions (storage class < 5), arrays with static storage, and
   arithmetic on those. Used for static initialisers and by CHECK_NULL_CONSTANT. */
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

/* ---- IS_NAMED_OBJECT_EXPR (listing F197) ---- */
/* row IS_NAMED_OBJECT_EXPR (offset 0x1147): stub 0C43:00A7 = IS_NAMED_OBJECT_EXPR */

/* IS_NAMED_OBJECT_EXPR: 1 when the tree, after removing & and * pairs that cancel and
   the left parts of commas, is just a symbol (SYM_FLAGS 0x20, not class 6) of the same
   type as the whole expression, so it can be reused instead of copied to a temporary. */
unsigned char far pascal IS_NAMED_OBJECT_EXPR(register unsigned int expression)
{
    unsigned int type;
    register int depth=0;
    register unsigned int operation=0x32;

    if (expression==0 || EXPR_W(expression,EXPR_OP)==0)
        return 0;
    type=EXPR_W(expression,EXPR_TYPE);
    for (;;) {
        if (EXPR_W(expression,EXPR_OP)==EOP_DEREF || EXPR_W(expression,EXPR_OP)==0x42 || EXPR_W(expression,EXPR_OP)==EOP_ADDR) {
            operation=EXPR_W(expression,EXPR_OP);
            depth+=EXPR_W(expression,EXPR_OP)==EOP_DEREF?1:-1;
            expression=EXPR_W(expression,EXPR_LEFT);
        } else if (EXPR_W(expression,EXPR_OP)==EOP_COMMA)
            expression=EXPR_W(expression,EXPR_RIGHT);
        else
            break;
    }
    return EXPR_W(expression,EXPR_OP)==1 && (SYM_B(EXPR_W(expression,EXPR_LEFT),SYM_FLAGS)&0x20) &&
        (SYM_B(EXPR_W(expression,EXPR_LEFT),SYM_STORAGE_CLASS)>>3)!=6 && depth==0 && operation==0x32 &&
        SYM_W(EXPR_W(expression,EXPR_LEFT),SYM_TYPE)==type;
}

/* ---- EXPRESSIONS_EQUAL (listing F270) ---- */
/* row EXPRESSIONS_EQUAL (offset 0x1220): stub 0C43:00B1 = EXPRESSIONS_EQUAL */
extern int far pascal RTL_LDOUBLE_COMPARE(void far *,void far *);

/* EXPRESSIONS_EQUAL: 1 when two trees compute the same value: same operators, types and
   leaves (commutative operators may have swapped operands). Without strict, calls and
   other side-effecting operators never compare equal; with strict they are compared
   structurally too. */
unsigned char far pascal EXPRESSIONS_EQUAL(register unsigned int first,register unsigned int second,
    unsigned char strict)
{
    unsigned int left,right;

    if (first==0 || second==0)
        return first==second;
    if (EXPR_W(first,EXPR_TYPE)!=EXPR_W(second,EXPR_TYPE) || EXPR_W(first,EXPR_OP)!=EXPR_W(second,EXPR_OP))
        return 0;
    switch (EXPR_W(first,EXPR_OP)) {
    case 0x36:
        if (!strict)
            return 0;
        if (!EXPRESSIONS_EQUAL(EXPR_W(first,EXPR_LEFT),EXPR_W(second,EXPR_LEFT),1))
            return 0;
        for (left=EXPR_W(first,EXPR_RIGHT),right=EXPR_W(second,EXPR_RIGHT); left && right;
                left=EXPR_W(left,EXPR_LEFT),right=EXPR_W(right,EXPR_LEFT))
            if (!EXPRESSIONS_EQUAL(EXPR_W(left,EXPR_RIGHT),EXPR_W(right,EXPR_RIGHT),1))
                return 0;
        return left==0 && right==0;
    case EOP_INC: case EOP_DEC:
        return strict && (EXPR_B(first,EXPR_NODE_FLAGS)&2)==(EXPR_B(second,EXPR_NODE_FLAGS)&2) &&
            EXPRESSIONS_EQUAL(EXPR_W(first,EXPR_LEFT),EXPR_W(second,EXPR_LEFT),1);
    case EOP_CONST:
        return EXPR_L(first,EXPR_VALUE)==EXPR_L(second,EXPR_VALUE);
    case 0x03: {
        unsigned char one[10],two[10];
        RTL_MEMMOVE(one,MK_FP(EXPR_POOL_SEG,first+EXPR_LEFT),10);
        RTL_MEMMOVE(two,MK_FP(EXPR_POOL_SEG,second+EXPR_LEFT),10);
        return RTL_LDOUBLE_COMPARE(one,two)==0;
    }
    case 0x48:
        return EXPR_W(first,EXPR_LEFT)==EXPR_W(second,EXPR_LEFT) && EXPR_W(first,EXPR_RIGHT)==EXPR_W(second,EXPR_RIGHT) &&
            EXPR_W(first,EXPR_SCOPE_CLASS)==EXPR_W(second,EXPR_SCOPE_CLASS);
    case 0x01:
        return EXPR_W(first,EXPR_LEFT)==EXPR_W(second,EXPR_LEFT) && EXPR_W(first,EXPR_RIGHT)==EXPR_W(second,EXPR_RIGHT);
    case 0x39:
        return EXPR_W(first,EXPR_LEFT)==EXPR_W(second,EXPR_LEFT) && EXPR_B(first,EXPR_MEMB_BIT_SHIFT)==EXPR_B(second,EXPR_MEMB_BIT_SHIFT) &&
            EXPR_B(first,EXPR_MEMB_BIT_WIDTH)==EXPR_B(second,EXPR_MEMB_BIT_WIDTH) && (EXPR_B(first,EXPR_NODE_FLAGS)&6)==(EXPR_B(second,EXPR_NODE_FLAGS)&6);
    case 0x00:
        return 0;
    }
    if ((EXPR_OP_FLAGS[EXPR_W(first,EXPR_OP)]&1) && !strict)
        return 0;
    return (EXPRESSIONS_EQUAL(EXPR_W(first,EXPR_LEFT),EXPR_W(second,EXPR_LEFT),strict) &&
            EXPRESSIONS_EQUAL(EXPR_W(first,EXPR_RIGHT),EXPR_W(second,EXPR_RIGHT),strict)) ||
        ((EXPR_OP_FLAGS[EXPR_W(first,EXPR_OP)]&2) &&
            EXPRESSIONS_EQUAL(EXPR_W(first,EXPR_LEFT),EXPR_W(second,EXPR_RIGHT),strict) &&
            EXPRESSIONS_EQUAL(EXPR_W(first,EXPR_RIGHT),EXPR_W(second,EXPR_LEFT),strict));
}

/* ---- X023_1E (listing F555) ---- */
/* row X023_1E (offset 0x1505): stub 0C43:0066 = COPY_EXPR_TREE */
struct C023Node { unsigned int words[13]; };

/* COPY_EXPR_TREE: deep copy of a tree (leaf nodes are copied whole, including their
   data words). */
unsigned int far pascal COPY_EXPR_TREE(register unsigned int expression)
{
    register unsigned int copy;

    if (expression==0)
        return 0;
    copy=ALLOC_EXPR_NODE();
    *(struct C023Node far *)MK_FP(EXPR_POOL_SEG,copy)=
        *(struct C023Node far *)MK_FP(EXPR_POOL_SEG,expression);
    if (!(EXPR_OP_FLAGS[EXPR_W(copy,EXPR_OP)]&4)) {
        EXPR_W(copy,EXPR_LEFT)=COPY_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        EXPR_W(copy,EXPR_RIGHT)=COPY_EXPR_TREE(EXPR_W(expression,EXPR_RIGHT));
    }
    return copy;
}

/* ---- FIND_BASE_SYMBOL (listing F5B7) ---- */
/* row FIND_BASE_SYMBOL (offset 0x1567): stub none (static) = FIND_BASE_SYMBOL */

/* FIND_BASE_SYMBOL: the symbol at the bottom of a chain of &, * and 0x42 nodes (taking
   the right side of commas), or 0. */
static unsigned int far pascal FIND_BASE_SYMBOL(register unsigned int expression)
{
    while (expression) {
        if (EXPR_W(expression,EXPR_OP)==EOP_ADDR || EXPR_W(expression,EXPR_OP)==0x42 || EXPR_W(expression,EXPR_OP)==EOP_DEREF)
            expression=EXPR_W(expression,EXPR_LEFT);
        else if (EXPR_W(expression,EXPR_OP)==EOP_COMMA)
            expression=EXPR_W(expression,EXPR_RIGHT);
        else if (EXPR_W(expression,EXPR_OP)==1)
            return EXPR_W(expression,EXPR_LEFT);
        else
            return 0;   /* the original jumps from here to the shared xor ax,ax (15B0 jmp 15B6) */
    }
    return 0;
}

/* ---- X023_1B (listing F60D) ---- */
/* row X023_1B (offset 0x15BD): stub 0C43:0061 = SAVE_EXPR_IN_TEMP */
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned int far pascal MAKE_ADDRESS_OF(unsigned int);

/* SAVE_EXPR_IN_TEMP: prepares *expression to be used twice. On return *expression is a
   cheap expression for its value (a symbol, or *temp for an lvalue) and *result an
   assignment that must run first (temp = value, or temp = &lvalue), or 0 when no
   temporary is needed (side-effect free, void, or already a named object). */
void far pascal SAVE_EXPR_IN_TEMP(unsigned int far *expression,unsigned int far *result)
{
    unsigned char wrap;
    unsigned int value;
    register unsigned int node;
    register unsigned int symbol;

    node=*expression;
    if (IS_SIDE_EFFECT_FREE(node) || TYPE_SIZE(EXPR_W(node,EXPR_TYPE))==0)
        value=0;
    else if (IS_LVALUE(node)) {
        wrap=EXPR_W(node,EXPR_OP)==EOP_DEREF && IS_NAMED_OBJECT_EXPR(EXPR_W(node,EXPR_LEFT));
        if (wrap || IS_NAMED_OBJECT_EXPR(node)) {
            symbol=FIND_BASE_SYMBOL(node);
            value=node;
        } else {
            node=MAKE_ADDRESS_OF(node);
            symbol=CREATE_LOCAL_TEMP(EXPR_W(node,EXPR_TYPE));
            wrap=1;
            value=MAKE_BINARY_NODE(0x0B,MAKE_SYMBOL_NODE(symbol),node);
        }
        node=MAKE_SYMBOL_NODE(symbol);
        if (wrap)
            node=MAKE_UNARY_NODE(0x18,node);
    } else {
        symbol=IS_NAMED_OBJECT_EXPR(node)?FIND_BASE_SYMBOL(node):CREATE_LOCAL_TEMP(EXPR_W(node,EXPR_TYPE));
        value=MAKE_BINARY_NODE(0x0B,MAKE_SYMBOL_NODE(symbol),node);
        node=MAKE_SYMBOL_NODE(symbol);
    }
    *expression=node;
    *result=value;
}

/* ---- APPEND_TEMP_DESTRUCTORS (listing F718) ---- */
/* row APPEND_TEMP_DESTRUCTORS (offset 0x16C8): stub 0C43:005C = APPEND_TEMP_DESTRUCTORS */
extern unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern void far pascal FREE_TEMP_ENTRY(unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);

/* APPEND_TEMP_DESTRUCTORS: at the end of a full expression, appends the destructor
   calls for the temporaries created since the scope's SCOPE_TEMPS list stood at
   "scope", frees those list entries, and returns expression, list combined so the value
   of the whole is still the original expression's value (saved in a temporary when it
   is not void). */
unsigned int far pascal APPEND_TEMP_DESTRUCTORS(unsigned int expression,unsigned int scope)
{
    unsigned int extra;
    register unsigned int list;
    register unsigned int entry;

    list=BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),scope);
    while (SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)!=scope) {
        entry=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
        SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)=TDTOR_W(entry,TDTOR_NEXT);
        FREE_TEMP_ENTRY(entry);
    }
    if (list==0)
        return expression;
    if (TYPE_SIZE(EXPR_W(expression,EXPR_TYPE))==0)
        return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(expression,list),0,0);
    extra=0;
    SAVE_EXPR_IN_TEMP(&expression,&extra);
    return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(JOIN_COMMA_EXPR(extra,list),expression),0,0);
}
