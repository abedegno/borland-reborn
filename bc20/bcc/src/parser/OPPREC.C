/* target: ovr090_C232UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: operator-precedence expression parser (operator and operand stacks). Entry points:
   BUILD_IDENTIFIER_NODE, PARSE_TYPE_NAME, PARSE_ASSIGNMENT_EXPR, PARSE_COMMA_EXPRESSION,
   PARSE_ARGUMENT_LIST, RESET_EXPR_PARSER. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the expression parser of the C++ front end (it also parses C
   expressions, and #if expressions through EVAL_CONSTANT_CONDITION).  It
   is an operator-precedence parser, not recursive descent: one loop
   (PARSE_EXPRESSION_PREC) reads tokens left to right, pushing operands on
   an operand stack and operators on an operator stack, and before pushing
   an operator it reduces (REDUCE_OPERATOR) every stacked operator that
   binds at least as tightly, building expression nodes.  Smaller
   precedence numbers bind tighter: operands use 2, prefix operators 0x0A,
   and 0x7E means "this token ends the expression".  The tables are
   BINARY_PRECEDENCE_BY_TOKEN and PREFIX_PRECEDENCE_BY_TOKEN (for the
   incoming token) and STACK_PRECEDENCE_BY_OP (for the stacked one).
   Operators on the stack are token codes, plus pseudo-codes for forms the
   token alone does not tell: 0x59 / 0x5A postfix ++ / --, 0x5B unary +,
   0x5C unary & (address), 0x5D unary * (indirection), 0x5E unary -,
   0x5F function call, 0x60 the '[' of delete[], 0x61 cast, 0x63 ::delete.
   The operator stack is an array of 0x80 words in OPERATOR_STACK_POOL;
   the operand stack is a chain of list nodes in the expression pool
   (MAKE_LIST_NODE: EXPR_RIGHT the operand, EXPR_LEFT the next), headed by
   OPERAND_LIST_HEAD down to the sentinel OPERAND_LIST_BASE.  A nested
   expression (an argument list, a subscript inside a cast...) saves and
   restores both stacks, so the parser is re-entrant.
   Errors set IN_ERROR_RECOVERY; the loop then stops and the caller's stop token
   is searched for (see the end of PARSE_EXPRESSION_PREC).  Node flag 8
   (EXPR_NODE_FLAGS) marks a parenthesised subexpression; the "ambiguous
   operators, need parentheses" warnings test it. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"

/* ---- INIT_EXPR_PARSER (listing CCD0) ---- */
#include <dos.h>
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_LIST_NODE(unsigned int,unsigned int);

/* Starts a fresh pair of stacks: a new 0x100-byte operator stack and an
   operand stack holding only a sentinel (an error node in a list node). */
static void near pascal INIT_EXPR_PARSER(void)
{
    OPERATOR_STACK_DEPTH=0;
    OPERATOR_STACK_OFFSET=POOL_ALLOC_REUSE(&OPERATOR_STACK_POOL,0x100);
    OPERAND_LIST_BASE=REPORT_EXPR_ERROR_PLAIN(0,0);
    OPERAND_LIST_HEAD=OPERAND_LIST_BASE=MAKE_LIST_NODE(OPERAND_LIST_BASE,0);
}

/* ---- END_EXPR_PARSER (listing CD0C) ---- */
#include <dos.h>
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);

/* Releases the operator stack.  Returns 1 if both stacks were empty, that
   is the expression was complete with nothing left over. */
static unsigned char near pascal END_EXPR_PARSER(void)
{
    unsigned char empty;

    empty=OPERATOR_STACK_DEPTH==0 && OPERAND_LIST_HEAD==OPERAND_LIST_BASE;
    OPERATOR_STACK_DEPTH=0;
    POOL_FREE_ITEM(&OPERATOR_STACK_POOL,OPERATOR_STACK_OFFSET);
    return empty;
}

/* ---- POP_OPERAND (listing CD48) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern void far pascal FREE_EXPR_NODE(unsigned int);

/* Pops an operand; on an empty stack reports "operand expected" and
   returns an error node. */
static unsigned int near pascal POP_OPERAND(void)
{
    register unsigned int node;
    register unsigned int result;

    node=OPERAND_LIST_HEAD;
    if(node==OPERAND_LIST_BASE) {
        result=REPORT_EXPR_ERROR_PLAIN(MSG_OPERAND_EXPECTED,0);
        IN_ERROR_RECOVERY=1;
    } else {
        result=EXPR_W(node,EXPR_RIGHT);
        OPERAND_LIST_HEAD=EXPR_W(node,EXPR_LEFT);
        FREE_EXPR_NODE(node);
    }
    return result;
}

/* ---- PUSH_OPERATOR (listing CD89) ---- */
#include <dos.h>
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
#define STK(i) (*(unsigned int far *)MK_FP(OPERATOR_STACK_POOL,OPERATOR_STACK_OFFSET+(i)*2))

/* Pushes an operator code; more than 0x80 is "expression too complex". */
static void near pascal PUSH_OPERATOR(unsigned int op)
{
    if(OPERATOR_STACK_DEPTH>=0x80) {
        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_TOO);
        IN_ERROR_RECOVERY=1;
    } else {
        STK(OPERATOR_STACK_DEPTH)=op;
        OPERATOR_STACK_DEPTH++;
    }
}
#undef STK

/* ---- POP_OPERATOR (listing CDC3) ---- */
#include <dos.h>
#define STK(i) (*(unsigned int far *)MK_FP(OPERATOR_STACK_POOL,OPERATOR_STACK_OFFSET+(i)*2))

/* Pops an operator code; 0x82 (and a syntax error) if the stack is empty. */
static unsigned int near pascal POP_OPERATOR(void)
{
    if(OPERATOR_STACK_DEPTH<=0) {
        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
        IN_ERROR_RECOVERY=1;
        return 0x82;
    }
    OPERATOR_STACK_DEPTH--;
    return STK(OPERATOR_STACK_DEPTH);
}
#undef STK

/* ---- REDUCE_OPERATOR (listing CDFA) ---- */
#include <dos.h>
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
#define STK(i) (*(unsigned int far *)MK_FP(OPERATOR_STACK_POOL,OPERATOR_STACK_OFFSET+(i)*2))
#define TOP() (OPERATOR_STACK_DEPTH<=0 ? 0x82 : STK(OPERATOR_STACK_DEPTH-1))
#define FLOATOP(n) ((EXPR_W(n,EXPR_OP)==EOP_SHL || EXPR_W(n,EXPR_OP)==EOP_SHR) && !(EXPR_B(n,EXPR_NODE_FLAGS)&8))
#define MIXED(n) (op!=0x32 && C18_OPERATOR_TOKENS[EXPR_W(n,EXPR_OP)]!=op && \
    BINARY_PRECEDENCE_BY_TOKEN[C18_OPERATOR_TOKENS[EXPR_W(n,EXPR_OP)]]>=BINARY_PRECEDENCE_BY_TOKEN[0x1E] && \
    BINARY_PRECEDENCE_BY_TOKEN[C18_OPERATOR_TOKENS[EXPR_W(n,EXPR_OP)]]<=BINARY_PRECEDENCE_BY_TOKEN[0x1C])

/* Pops the top operator, pops its operands and pushes the node built from
   them.  Special cases: ')' (2) pops its '(' and marks the node
   parenthesised; ']' (4) makes a subscript from '[' (3) or completes a
   delete[]; delete pairs with a following expression; a cast (0x61) gets
   its operand; ':' needs a '?' below it and makes the conditional node.
   For shifts, + and -, and the bitwise and comparison operators, an
   unparenthesised operand built from a confusable operator gives the
   "ambiguous operators" warning (FLOATOP: an unparenthesised shift; MIXED:
   a different operator with precedence between that of token 0x1E and
   token 0x1C).  A '(' , '[' or '?' left over is a missing-partner error. */
static void near pascal REDUCE_OPERATOR(void)
{
    unsigned int op;
    unsigned int next;
    unsigned int third;
    unsigned int left;
    register unsigned int node;
    register unsigned int right;

    op=POP_OPERATOR();
    node=0;
    switch(op) {
    case 2:
        if(TOP()==1) POP_OPERATOR();
        else {
            REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_CHECK);
            IN_ERROR_RECOVERY=1;
        }
        node=POP_OPERAND();
        EXPR_B(node,EXPR_NODE_FLAGS)|=8;
        break;
    case 4:
        next=POP_OPERATOR();
        if(next!=3 && next!=0x60) {
            PUSH_OPERATOR(next);
            REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
            IN_ERROR_RECOVERY=1;
            break;
        }
        node=MAKE_BINARY_NODE(3,0,0);
        if(next==0x60) {
            EXPR_W(node,EXPR_OP)=EOP_DELETE;
            EXPR_W(node,EXPR_LEFT)=POP_OPERAND();
        } else {
            EXPR_W(node,EXPR_RIGHT)=POP_OPERAND();
            EXPR_W(node,EXPR_LEFT)=POP_OPERAND();
        }
        break;
    case 0x63:
    case 0x69:
        node=POP_OPERAND();
        if(EXPR_W(EXPR_W(OPERAND_LIST_HEAD,EXPR_RIGHT),EXPR_OP)==EOP_DELETE) {
            right=node;
            node=POP_OPERAND();
            EXPR_W(node,EXPR_RIGHT)=right;
        } else {
            node=MAKE_BINARY_NODE(0x69,MAKE_INT_CONSTANT(INT_TYPE,1L),node);
        }
        if(op==0x63) EXPR_B(node,EXPR_NODE_FLAGS)&=0xDF;
        break;
    case 0x61:
        third=POP_OPERAND();
        node=POP_OPERAND();
        EXPR_W(node,EXPR_LEFT)=third;
        break;
    case 0x21:
        if(TOP()!=0x20) {
            REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_FOUND);
            IN_ERROR_RECOVERY=1;
        } else {
            POP_OPERATOR();
            right=POP_OPERAND();
            left=POP_OPERAND();
            third=POP_OPERAND();
            node=MAKE_CONDITIONAL_NODE(0x20,third,left,right);
        }
        break;
    case 0x2A:
    case 0x2B:
    case 0x2C:
    case 0x2D:
    case 0x2E:
    case 0x6C:
        node=MAKE_UNARY_NODE(op,POP_OPERAND());
        break;
    case 0x59:
        node=MAKE_UNARY_NODE(0x2D,POP_OPERAND());
        EXPR_B(node,EXPR_NODE_FLAGS)|=2;
        break;
    case 0x5A:
        node=MAKE_UNARY_NODE(0x2E,POP_OPERAND());
        EXPR_B(node,EXPR_NODE_FLAGS)|=2;
        break;
    case 0x5B:
        node=MAKE_UNARY_NODE(0x16,POP_OPERAND());
        break;
    case 0x5C:
        node=MAKE_UNARY_NODE(0x1B,POP_OPERAND());
        break;
    case 0x5D:
        node=MAKE_UNARY_NODE(0x18,POP_OPERAND());
        break;
    case 0x5E:
        node=MAKE_UNARY_NODE(0x17,POP_OPERAND());
        break;
    case 0x5F:
        op=1;
        /* fall through */
    case 0x08:
    case 0x0B:
    case 0x0C:
    case 0x0D:
    case 0x0E:
    case 0x0F:
    case 0x10:
    case 0x11:
    case 0x12:
    case 0x13:
    case 0x14:
    case 0x15:
    case 0x18:
    case 0x19:
    case 0x1A:
    case 0x22:
    case 0x23:
    case 0x2F:
    case 0x30:
    case 0x64:
    case 0x66:
        right=POP_OPERAND();
        left=POP_OPERAND();
        node=MAKE_BINARY_NODE(op,left,right);
        break;
    case 0x16:
    case 0x17:
        right=POP_OPERAND();
        left=POP_OPERAND();
        if(FLOATOP(right) || FLOATOP(left)) REPORT_CURRENT_TOKEN(MSG_AMBIGUOUS_OPERATORS);
        node=MAKE_BINARY_NODE(op,left,right);
        break;
    case 0x1E:
    case 0x1F:
        right=POP_OPERAND();
        left=POP_OPERAND();
        if(((EXPR_W(right,EXPR_OP)==EOP_ADD || EXPR_W(right,EXPR_OP)==EOP_SUB || MIXED(right)) && !(EXPR_B(right,EXPR_NODE_FLAGS)&8)) ||
           ((EXPR_W(left,EXPR_OP)==EOP_ADD || EXPR_W(left,EXPR_OP)==EOP_SUB || MIXED(left)) && !(EXPR_B(left,EXPR_NODE_FLAGS)&8)))
            REPORT_CURRENT_TOKEN(MSG_AMBIGUOUS_OPERATORS);
        node=MAKE_BINARY_NODE(op,left,right);
        break;
    case 0x1B:
    case 0x1C:
    case 0x1D:
    case 0x24:
    case 0x25:
    case 0x26:
    case 0x27:
    case 0x28:
    case 0x29:
        right=POP_OPERAND();
        left=POP_OPERAND();
        if((MIXED(right) && !(EXPR_B(right,EXPR_NODE_FLAGS)&8) && EXPR_W(right,EXPR_OP)!=EOP_ADDR) ||
           (EXPR_W(left,EXPR_OP)!=EOP_ADDR && MIXED(left) && !(EXPR_B(left,EXPR_NODE_FLAGS)&8)))
            REPORT_CURRENT_TOKEN(MSG_AMBIGUOUS_OPERATORS);
        node=MAKE_BINARY_NODE(op,left,right);
        break;
    case 1:
        REPORT_CURRENT_TOKEN(MSG_NO_MATCHING);
        IN_ERROR_RECOVERY=1;
        break;
    case 3:
        REPORT_DIAGNOSTIC(MSG_MISSING,(char far *)STR_SUBSCRIPTING,0L);
        IN_ERROR_RECOVERY=1;
        break;
    case 0x20:
        REPORT_CURRENT_TOKEN(MSG_NO_FOLLOWING);
        IN_ERROR_RECOVERY=1;
        break;
    case 0x82:
        IN_ERROR_RECOVERY=1;
        break;
    default:
        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
        IN_ERROR_RECOVERY=1;
    }
    if(node) OPERAND_LIST_HEAD=MAKE_LIST_NODE(node,OPERAND_LIST_HEAD);
}
#undef STK
#undef TOP
#undef FLOATOP
#undef MIXED

/* ---- PARSE_MEMBER_OPERATOR (listing D33D) ---- */
#include <dos.h>
extern unsigned long  CURRENT_TOKEN_VALUE;
extern void far pascal ADVANCE_TOKEN(void);
extern unsigned int far pascal PARSE_MEMBER_SELECTOR(unsigned int);
extern unsigned int far pascal MAKE_MEMBER_NAME_NODE(unsigned int,unsigned int);

/* Handles '.' or '->' (the current token) after the operand on top of the
   stack: in C++ the member is parsed by PARSE_MEMBER_SELECTOR (it can be
   qualified, a destructor, ...); in C it must be an identifier, kept as a
   member-name node.  Returns the node. */
static unsigned int near pascal PARSE_MEMBER_OPERATOR(void)
{
    register unsigned int node;
    register unsigned int type;

    node=POP_OPERAND();
    node=MAKE_BINARY_NODE(CURRENT_TOKEN,node,0);
    ADVANCE_TOKEN();
    if(CPP_MODE) return PARSE_MEMBER_SELECTOR(node);
    if(CURRENT_TOKEN==TOK_IDENT) type=MAKE_MEMBER_NAME_NODE((unsigned int)CURRENT_TOKEN_VALUE,0);
    else type=REPORT_EXPR_ERROR_PLAIN(MSG_FIELD_IDENTIFIER,0);
    ADVANCE_TOKEN();
    EXPR_W(node,EXPR_RIGHT)=type;
    return node;
}

/* ---- X022_05 (listing D3A2) ---- */
#include <dos.h>
#include "BCCREC6.H"
struct C24Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned int name;
    unsigned char payload[8];
};
extern unsigned int SCOPE_POOL_SEG;
extern unsigned int NAME_POOL_SEG;
extern unsigned char LANGUAGE_MODE;
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal REPORT_TOKEN_DIAGNOSTIC(struct C24Token far *,unsigned int);
extern void far pascal DECLARE_FUNCTION(unsigned int,unsigned int,unsigned int,unsigned int, unsigned int far *,unsigned char far *);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,char far *,long,unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
#define LW(l) (*(unsigned int far *)MK_FP(NAME_POOL_SEG,(l)))
#define LOCATION(n) (*(struct C77Record6 far *)MK_FP(EXPR_POOL_SEG,(n)+20))

/* Makes the expression node for an identifier.  type is the symbol found
   by name lookup (0 if none), token the identifier's token record and
   where its source position.  An undeclared name followed by '(' is a call
   to an undeclared function: it is reported (an error in C++, a warning
   in C), declared as extern "int name()" (IMPLICIT_FUNC_TYPE) and moved
   into the file scope's name chain.  Inside #if (MACRO_MODE) an unknown
   name is 0L (and in strict ANSI mode every name is).  A typedef name is
   an error here. */
unsigned int far pascal BUILD_IDENTIFIER_NODE(unsigned int type,struct C24Token far *token,
    struct C77Record6 where)
{
    unsigned int saved;
    unsigned char created;
    register unsigned int node;

    if(MACRO_MODE && LANGUAGE_MODE) type=0;
    else if(!type && token->kind==0x31 && CURRENT_TOKEN==TOK_LPAREN) {
        REPORT_DIAGNOSTIC(CPP_MODE ? MSG_FUNCTION_SHOULD_HAVE : MSG_NO_DECLARATION,NAME_TEXT_COPY(token->name),0L);
        saved=CURRENT_LINKAGE;
        CURRENT_LINKAGE=2;
        DECLARE_FUNCTION(IMPLICIT_FUNC_TYPE,token->name,0,0x36,&type,&created);
        if(SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES)!=GLOBAL_SCOPE_NAMES) {
            SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES)=SYM_W(type,SYM_NEXT);
            SYM_W(type,SYM_NEXT)=LW(SYM_W(type,SYM_NAME));
            LW(SYM_W(type,SYM_NAME))=type;
        }
        CURRENT_LINKAGE=saved;
    }
    if(!type) {
        if(MACRO_MODE) return MAKE_INT_CONSTANT(LONG_TYPE,0L);
        REPORT_TOKEN_DIAGNOSTIC(token,MSG_UNDEFINED_SYMBOL);
        return REPORT_EXPR_ERROR_PLAIN(0,0);
    }
    if((SYM_B(type,SYM_STORAGE_CLASS)>>3)==8 || (SYM_B(type,SYM_STORAGE_CLASS)>>3)==11) {
        if(!SYM_W(type,SYM_NAME)) return REPORT_EXPR_ERROR_PLAIN(MSG_IMPROPER_USE_TYPEDEF,0);
        return REPORT_EXPR_ERROR(MSG_IMPROPER_USE_TYPEDEF_262,NAME_TEXT_COPY(SYM_W(type,SYM_NAME)),0L,0);
    }
    node=MAKE_SYMBOL_NODE(type);
    LOCATION(node)=where;
    return node;
}
#undef LW
#undef LOCATION

/* ---- PARSE_IDENTIFIER (listing D54F) ---- */
#include <dos.h>
#include "BCCREC6.H"

#define TOKEN (*(struct C24Token near *)&CURRENT_TOKEN_RECORD)
extern unsigned int CURRENT_TOKEN_RECORD;
extern unsigned int far pascal LOOKUP_NAME(unsigned int);
unsigned int far pascal BUILD_IDENTIFIER_NODE(unsigned int,struct C24Token far *,struct C77Record6);

/* C form of a primary identifier: looks up the current name (CURRENT_TOKEN_VALUE
   is the token's value word: the name record), saves the
   token and its position, advances, and builds the node. */
static unsigned int near pascal PARSE_IDENTIFIER(void)
{
    unsigned int type;
    struct C77Record6 where;
    struct C24Token token;

    if(CURRENT_TOKEN!=TOK_IDENT) return REPORT_EXPR_ERROR_PLAIN(MSG_IDENTIFIER_EXPECTED,0);
    type=LOOKUP_NAME((unsigned int)CURRENT_TOKEN_VALUE);
    token=TOKEN;
    where.first=CURRENT_TOKEN_FILE;
    where.second=CURRENT_TOKEN_LINE;
    where.third=CURRENT_TOKEN_LOC_WORD3;
    ADVANCE_TOKEN();
    return BUILD_IDENTIFIER_NODE(type,&token,where);
}
#undef TOKEN

/* ---- MAKE_STRING_TYPE (listing D5BE) ---- */
#include <dos.h>
extern unsigned int far pascal CREATE_TYPE(unsigned int);

/* Returns a new type "array of value chars", the type of a string literal. */
static unsigned int near pascal MAKE_STRING_TYPE(int value)
{
    register unsigned int type;

    type=CREATE_TYPE(0x11);
    TYPE_W(type,TYPE_TARGET)=CHAR_TYPE;
    TYPE_L(type,TYPE_ARRAY_COUNT)=value;
    return type;
}

/* ---- PARSE_LITERAL (listing D5ED) ---- */
#include <dos.h>
typedef struct { unsigned char bytes[10]; } C40RealStorage;
extern unsigned int far *BCC_TYPE_PTR;
extern unsigned int far pascal MAKE_REAL_CONSTANT(unsigned int,C40RealStorage far *);
extern void far pascal COLLECT_STRING_LITERAL(unsigned int far *,unsigned int far *);

/* Builds the node for the current constant token: a character constant
   (char in C++, int in C), an integer or floating constant (its type comes
   from the token's flags byte through BCC_TYPE_PTR), or a string literal:
   adjacent literals are joined into the data pool by
   COLLECT_STRING_LITERAL and the node refers to STRING_LITERAL_SYMBOL with
   the offset in EXPR_RIGHT. */
static unsigned int near pascal PARSE_LITERAL(void)
{
    unsigned int value;
    unsigned int width;
    register unsigned int node;

    switch(CURRENT_TOKEN) {
    case 0x65:
        node=MAKE_INT_CONSTANT(CPP_MODE ? CHAR_TYPE : INT_TYPE,CURRENT_TOKEN_VALUE);
        break;
    case 0x32:
        node=MAKE_INT_CONSTANT(BCC_TYPE_PTR[CURRENT_TOKEN_FLAGS],CURRENT_TOKEN_VALUE);
        break;
    case 0x33:
        /* DS:638B is the token value area (the 10-byte value union of the current token) */
        node=MAKE_REAL_CONSTANT(BCC_TYPE_PTR[CURRENT_TOKEN_FLAGS],(C40RealStorage far *)&CURRENT_TOKEN_VALUE);
        break;
    case 0x34:
        COLLECT_STRING_LITERAL(&value,&width);
        node=MAKE_SYMBOL_NODE(STRING_LITERAL_SYMBOL);
        EXPR_B(node,EXPR_NODE_FLAGS)|=1;
        EXPR_W(node,EXPR_TYPE)=MAKE_STRING_TYPE(width);
        EXPR_W(node,EXPR_RIGHT)=value;
        return node;
    }
    ADVANCE_TOKEN();
    return node;
}

/* ---- X022_04 (listing D6B8) ---- */
#include <dos.h>
struct C16Spec { signed char first,second,third; };
extern void far pascal PARSE_DECL_SPECIFIERS(unsigned int,unsigned int far *,unsigned char far *,unsigned char far *,unsigned int far *,struct C16Spec far *,unsigned char far *);
extern void far pascal PARSE_DECLARATOR(unsigned int,unsigned int,unsigned int far *,unsigned int far *,unsigned int far *,unsigned int far *,struct C16Spec far *,struct C16Spec far *);

/* Parses a type name (specifiers and an abstract declarator, as in a cast
   or sizeof) and returns the type.  Storage classes, friend and virtual
   are not allowed.  mode is passed on to the declaration parsers (3 for a
   type name). */
unsigned int far pascal PARSE_TYPE_NAME(unsigned int mode)
{
    unsigned int context;
    unsigned int value;
    unsigned int code;
    unsigned int second_value;
    unsigned int third_value;
    unsigned int fourth_value;
    struct C16Spec spec;
    unsigned char first;
    unsigned char second;
    unsigned char third;

    context=INT_TYPE;
    PARSE_DECL_SPECIFIERS(mode,&code,&first,&second,&context,&spec,&third);
    if(code!=0x82 || first || second)
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,first ? (char far *)STR_FRIEND_3 :
            second ? (char far *)STR_VIRTUAL_3 : NAME_TEXT_COPY(TOKEN_NAMES[code]),0L);
    PARSE_DECLARATOR(context,mode,&value,&second_value,&third_value,&fourth_value,&spec,&spec);
    return value;
}

/* ---- IS_CONSTRUCTOR_CALL_AHEAD (listing D766) ---- */
#include <dos.h>
extern unsigned int TOKEN_TYPE;
extern void far pascal PEEK_TOKEN(void);
extern unsigned int far pascal TYPE_LOOKUP_FAR(unsigned int);

/* C++: nonzero if the current identifier names a type and is followed by
   '(', an explicit constructor call or functional cast "T(x)". */
static unsigned char near pascal IS_CONSTRUCTOR_CALL_AHEAD(void)
{
    if(CPP_MODE && CURRENT_TOKEN==TOK_IDENT) {
        PEEK_TOKEN();
        if(TOKEN_TYPE==1) return TYPE_LOOKUP_FAR((unsigned int)CURRENT_TOKEN_VALUE)!=0;
    }
    return 0;
}

/* ---- IS_CAST_AHEAD (listing D79F) ---- */
#include <dos.h>
extern unsigned char far pascal TOKEN_IS_TYPE_START(void far *);
extern unsigned char far pascal IS_PAREN_TYPE_NAME(unsigned int);

/* Called at '(' where an operand is expected: nonzero if a cast follows.
   In C a type keyword or type name after '(' is enough; in C++ the whole
   parenthesised part must be a type name (IS_PAREN_TYPE_NAME, LOOKAHD.C).
   '~' is excluded (a destructor call). */
static unsigned char far pascal IS_CAST_AHEAD(void)
{
    PEEK_TOKEN();
    if(!TOKEN_IS_TYPE_START((void far *)&TOKEN_TYPE) || TOKEN_TYPE==0x2B) return 0;
    if(CPP_MODE) return IS_PAREN_TYPE_NAME(3);
    return 1;
}

/* ---- PARSE_CAST_TYPE (listing D7D8) ---- */
#include <dos.h>
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);
unsigned int far pascal PARSE_TYPE_NAME(unsigned int);

/* Reads "(type)" and returns a cast node whose operand is filled in when
   the cast is reduced. */
static unsigned int far pascal PARSE_CAST_TYPE(void)
{
    unsigned int result;

    ADVANCE_TOKEN();
    result=MAKE_CAST_NODE(PARSE_TYPE_NAME(3),0);
    REQUIRE_TOKEN_ELSE_ERROR(2,0xDD);
    return result;
}

/* ---- PARSE_SIZEOF_TYPE (listing D80A) ---- */
#include <dos.h>
extern long (far pascal *TOKEN_CONVERT)(long,int);
extern long far pascal TYPE_SIZE(unsigned int);
unsigned int far pascal PARSE_TYPE_NAME(unsigned int);

/* After sizeof: for "sizeof(type)" returns the size as a size_t constant
   (a reference counts as the referred type; size 0 is an error).
   Otherwise returns 0 and sizeof is treated as a prefix operator on the
   expression that follows. */
static unsigned int near pascal PARSE_SIZEOF_TYPE(void)
{
    register unsigned int type;
    register unsigned int node;

    ADVANCE_TOKEN();
    PEEK_TOKEN();
    if(CURRENT_TOKEN==TOK_LPAREN && TOKEN_IS_TYPE_START((void far *)&TOKEN_TYPE)) {
        ADVANCE_TOKEN();
        type=PARSE_TYPE_NAME(3);
        if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x14) && (TYPE_B(type,TYPE_ATTRS)&0x20)) type=TYPE_W(type,TYPE_TARGET);
        if(!TYPE_SIZE(type)) REPORT_CURRENT_TOKEN(MSG_SIZE_TYPE_UNKNOWN_ZERO);
        node=MAKE_INT_CONSTANT(SIZE_T_TYPE,TOKEN_CONVERT(TYPE_SIZE(type),TYPE_W(SIZE_T_TYPE,TYPE_KIND)));
        REQUIRE_TOKEN_ELSE_ERROR(2,0xE9);
    } else node=0;
    return node;
}

/* ---- PARSE_EXPRESSION_PREC (listing D8A6) ---- */
unsigned int far pascal PARSE_ARGUMENT_LIST(unsigned int flag);
#include <dos.h>
extern unsigned int far pascal MAKE_ADDR_OF_CONTEXT_NODE(void);
extern unsigned int far pascal PARSE_NEW_EXPRESSION(void);
extern unsigned int far pascal PARSE_TYPE_CONSTRUCTOR_CALL(void);
extern unsigned int far pascal PARSE_QUALIFIED_NAME(void);
extern unsigned int far pascal BUILD_THIS_NODE(unsigned int);
extern void far pascal SKIP_TO_SYNC_TOKEN(unsigned int);
#define STK(i) (*(unsigned int far *)MK_FP(OPERATOR_STACK_POOL,OPERATOR_STACK_OFFSET+(i)*2))
#define TOP() (OPERATOR_STACK_DEPTH<=0 ? 0x82 : STK(OPERATOR_STACK_DEPTH-1))

/* Parses one expression and returns its tree.  flag nonzero allows the
   comma operator at the top level (a comma expression); otherwise a comma
   outside parentheses, brackets and ?: ends the expression (as in an
   argument list).  stop is the token the caller expects after the
   expression; it lets an unmatched ')' or ']' end the expression quietly
   (stop 2 or 4) and is the recovery point after an error.
   In the loop, for each token: node is an operand built from it (if any),
   kind says what to do with it (0 push the operand, 1 member operator,
   2 call: push the operator and the argument list, 3 an operator), tok is
   the operator code to push, prec its precedence, expect is 1 while an
   operand is expected next (so '(' groups or casts, '-' is unary, and so
   on), and hold means the current token must not be skipped. */
static unsigned int near pascal PARSE_EXPRESSION_PREC(unsigned char flag,unsigned int stop)
{
    int parens;
    int brackets;
    int questions;
    unsigned char prec;
    unsigned int result;
    int kind;
    unsigned char expect;
    unsigned char hold;
    unsigned int saved_list;
    unsigned int saved_offset;
    unsigned int saved_base;
    int saved_depth;
    unsigned char again;
    register int tok;
    register unsigned int node;

    if(!(TYPE_FLAGS[CURRENT_TOKEN]&EXPR_START_FLAG_MASK)) {
        result=REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_EXPECTED,0);
        IN_ERROR_RECOVERY=1;
    } else {
        saved_offset=OPERATOR_STACK_OFFSET;
        saved_list=OPERAND_LIST_HEAD;
        saved_base=OPERAND_LIST_BASE;
        saved_depth=OPERATOR_STACK_DEPTH;
        INIT_EXPR_PARSER();
        parens=0;
        brackets=0;
        questions=0;
        expect=1;
        do {
            node=0;
            kind=3;
            tok=CURRENT_TOKEN;
            hold=0;
            prec=0x7E;
            switch(tok) {
            case 0x3A:
            case 0x3B:
            case 0x3C:
            case 0x3D:
            case 0x3E:
            case 0x3F:
            case 0x40:
            case 0x41:
            case 0x45:
                if(CPP_MODE && (PEEK_TOKEN(),TOKEN_TYPE)==1) {
                    node=PARSE_TYPE_CONSTRUCTOR_CALL();
                    kind=0;
                    expect=0;
                    prec=2;
                } else {
                    REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
                    ADVANCE_TOKEN();
                    IN_ERROR_RECOVERY=1;
                }
                break;
            /* Token 9 (TOK_ELLIPSIS in TOKEN.H) as an operand: probably the
               address of the variable arguments, built by
               MAKE_ADDR_OF_CONTEXT_NODE. */
            case 0x09:
                node=MAKE_ADDR_OF_CONTEXT_NODE();
                ADVANCE_TOKEN();
                kind=0;
                expect=0;
                prec=2;
                break;
            /* '::' starts ::delete, ::new or a qualified name. */
            case 0x67:
                PEEK_TOKEN();
                if(TOKEN_TYPE==0x69) {
                    ADVANCE_TOKEN();
                    tok=0x63;
                    prec=0x0A;
                    expect=1;
                    break;
                }
                PEEK_TOKEN();
                if(TOKEN_TYPE==0x6C) {
                    node=PARSE_NEW_EXPRESSION();
                    kind=0;
                    prec=2;
                    expect=0;
                    break;
                }
                /* fall through */
            case 0x31:
            case 0x6D:
                if(IS_CONSTRUCTOR_CALL_AHEAD()) node=PARSE_TYPE_CONSTRUCTOR_CALL();
                else node=CPP_MODE ? PARSE_QUALIFIED_NAME() : PARSE_IDENTIFIER();
                kind=0;
                expect=0;
                prec=2;
                break;
            case 0x72:
                kind=0;
                node=CTOR_THIS_SYMBOL==0 ? REPORT_EXPR_ERROR_PLAIN(MSG_THIS_CAN_ONLY_USED,0) : BUILD_THIS_NODE(CTOR_THIS_SYMBOL);
                ADVANCE_TOKEN();
                expect=0;
                prec=2;
                break;
            case 0x32:
            case 0x33:
            case 0x34:
            case 0x65:
                node=PARSE_LITERAL();
                kind=0;
                expect=0;
                prec=2;
                break;
            case 0x6C:
                node=PARSE_NEW_EXPRESSION();
                kind=0;
                expect=0;
                prec=2;
                break;
            case 0x2F:
            case 0x30:
                kind=1;
                expect=0;
                prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                break;
            case 0x64:
            case 0x66:
                prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                if(!CPP_MODE) {
                    REPORT_DIAGNOSTIC(MSG_ONLY_ALLOWED_C,NAME_TEXT_COPY(TOKEN_NAMES[tok]),0L);
                    IN_ERROR_RECOVERY=1;
                    ADVANCE_TOKEN();
                }
                if(expect) {
                    if(CPP_MODE) REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
                    IN_ERROR_RECOVERY=1;
                    ADVANCE_TOKEN();
                }
                expect=1;
                break;
            case 0x69:
                expect=1;
                prec=0x0A;
                break;
            case 0x2C:
                node=PARSE_SIZEOF_TYPE();
                if(node==0) {
                    hold=1;
                    expect=1;
                    prec=0x0A;
                } else {
                    kind=0;
                    expect=0;
                    prec=2;
                }
                break;
            /* ',': falls out with prec 0x7E (end of expression) unless a
               comma operator is allowed here. */
            case 0x08:
                if(flag==0 && parens==0 && brackets==0 && questions==0) break;
                else {
                    expect=1;
                    prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                }
                break;
            case 0x20:
                questions++;
                expect=1;
                prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                break;
            case 0x01:
                if(expect && IS_CAST_AHEAD()) {
                    tok=0x61;
                    node=PARSE_CAST_TYPE();
                    hold=1;
                    prec=0x0A;
                } else if(expect) {
                    tok=1;
                    parens++;
                    prec=BINARY_PRECEDENCE_BY_TOKEN[1];
                } else {
                    tok=0x5F;
                    node=PARSE_ARGUMENT_LIST(1);
                    kind=2;
                    prec=2;
                }
                break;
            case 0x02:
                if(parens==0) {
                    if(stop==2 || stop==4) hold=1;
                    else {
                        REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_CHECK);
                        IN_ERROR_RECOVERY=1;
                    }
                    tok=0x82;
                } else {
                    parens--;
                    expect=0;
                    prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                }
                break;
            case 0x03:
                brackets++;
                if(expect && (TOP()==0x69 || TOP()==0x63)) tok=0x60;
                expect=1;
                prec=BINARY_PRECEDENCE_BY_TOKEN[3];
                break;
            case 0x04:
                if(brackets==0) {
                    if(stop==2 || stop==4) hold=1;
                    else {
                        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
                        IN_ERROR_RECOVERY=1;
                    }
                    tok=0x82;
                } else {
                    brackets--;
                    expect=TOP()==0x60;
                    prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                }
                break;
            case 0x21:
                if(questions==0) {
                    if(stop==0x21) hold=1;
                    else {
                        REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_FOUND);
                        IN_ERROR_RECOVERY=1;
                    }
                } else {
                    questions--;
                    expect=1;
                    prec=BINARY_PRECEDENCE_BY_TOKEN[0x21];
                }
                break;
            case 0x2D:
                if(!expect) {
                    tok=0x59;
                    prec=6;
                } else prec=0x0A;
                break;
            case 0x2E:
                if(!expect) {
                    tok=0x5A;
                    prec=6;
                } else prec=0x0A;
                break;
            case 0x16:
                if(expect) {
                    tok=0x5B;
                    prec=0x0A;
                } else prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                expect=1;
                break;
            case 0x1B:
                if(expect) {
                    tok=0x5C;
                    prec=0x0A;
                } else prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                expect=1;
                break;
            case 0x18:
                if(expect) {
                    tok=0x5D;
                    prec=0x0A;
                } else prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                expect=1;
                break;
            case 0x17:
                if(expect) {
                    tok=0x5E;
                    prec=0x0A;
                } else prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                expect=1;
                break;
            default:
                prec=BINARY_PRECEDENCE_BY_TOKEN[tok];
                if(expect) {
                    prec=PREFIX_PRECEDENCE_BY_TOKEN[tok];
                    if(prec==0x7C) {
                        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_SYNTAX);
                        IN_ERROR_RECOVERY=1;
                        ADVANCE_TOKEN();
                    }
                }
                expect=1;
            }
            /* Reduce what binds tighter, then push this token's part. */
            while(!IN_ERROR_RECOVERY && STACK_PRECEDENCE_BY_OP[TOP()]<=prec) REDUCE_OPERATOR();
            if(IN_ERROR_RECOVERY) prec=0x7E;
            else switch(kind) {
            case 0:
                OPERAND_LIST_HEAD=MAKE_LIST_NODE(node,OPERAND_LIST_HEAD);
                break;
            case 1:
                OPERAND_LIST_HEAD=MAKE_LIST_NODE(PARSE_MEMBER_OPERATOR(),OPERAND_LIST_HEAD);
                break;
            case 2:
                PUSH_OPERATOR(tok);
                OPERAND_LIST_HEAD=MAKE_LIST_NODE(node,OPERAND_LIST_HEAD);
                break;
            default:
                if(prec!=0x7E) {
                    if(tok!=0x82) PUSH_OPERATOR(tok);
                    if(node) OPERAND_LIST_HEAD=MAKE_LIST_NODE(node,OPERAND_LIST_HEAD);
                    if(!hold) ADVANCE_TOKEN();
                }
            }
        } while(prec!=0x7E);
        result=POP_OPERAND();
        if(!END_EXPR_PARSER()) {
            if(EXPR_W(result,EXPR_OP)!=0) result=REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_SYNTAX,result);
            IN_ERROR_RECOVERY=1;
        }
        OPERAND_LIST_BASE=saved_base;
        OPERATOR_STACK_DEPTH=saved_depth;
        OPERATOR_STACK_OFFSET=saved_offset;
        OPERAND_LIST_HEAD=saved_list;
    }
    /* Recovery: skip to the stop token, stepping over the closing parts of
       groups that were open in the failed expression. */
    if(IN_ERROR_RECOVERY) {
        /* parens/brackets may be unset here when the TYPE_FLAGS test failed; the original reads them the same way */
        do {
            SKIP_TO_SYNC_TOKEN(stop);
            if(CURRENT_TOKEN==TOK_RPAREN) parens=parens-1;
            if(CURRENT_TOKEN==TOK_RBRACKET) brackets=brackets-1;
            again=CURRENT_TOKEN==stop &&
                (CURRENT_TOKEN==TOK_RPAREN && parens>0 || CURRENT_TOKEN==TOK_RBRACKET && brackets>0);
            if(again) ADVANCE_TOKEN();
        } while(again);
    }
    return result;
}
#undef STK
#undef TOP

/* ---- X022_00 (listing DF68) ---- */
#include <dos.h>

/* Parses an expression without a top-level comma operator. */
unsigned int far pascal PARSE_ASSIGNMENT_EXPR(unsigned int stop)
{
    return PARSE_EXPRESSION_PREC(0,stop);
}

/* ---- PARSE_COMMA_EXPRESSION (listing DF78) ---- */
#include <dos.h>

/* Parses a full expression, comma operator included. */
unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int stop)
{
    return PARSE_EXPRESSION_PREC(1,stop);
}

/* ---- PARSE_ARGUMENT_LIST (listing DF88) ---- */
#include <dos.h>

/* Parses "(arg, arg, ...)" and returns a chain of list nodes, one per
   argument (EXPR_RIGHT the argument, EXPR_LEFT the next), or 0 for "()".
   flag picks the message for a missing ')': nonzero for a call. */
unsigned int far pascal PARSE_ARGUMENT_LIST(unsigned int flag)
{
    register unsigned int tail;
    register unsigned int head;

    head=0;
    REQUIRE_TOKEN_ELSE_ERROR(1,0xDA);
    if(CURRENT_TOKEN!=TOK_RPAREN) {
        head=MAKE_LIST_NODE(PARSE_EXPRESSION_PREC(0,2),0);
        tail=head;
        while(CURRENT_TOKEN==TOK_COMMA) {
            ADVANCE_TOKEN();
            EXPR_W(tail,EXPR_LEFT)=MAKE_LIST_NODE(PARSE_EXPRESSION_PREC(0,2),0);
            tail=EXPR_W(tail,EXPR_LEFT);
        }
        EXPR_W(tail,EXPR_LEFT)=0;
    }
    REQUIRE_TOKEN_ELSE_ERROR(2,flag ? 0x1A : 0xE9);
    return head;
}

/* ---- RESET_EXPR_PARSER (listing E011) ---- */
#include <dos.h>
struct Pool { unsigned int segment,step,unit,used; };
#define POOL(name) (*(struct Pool near *)&(name))
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);

/* Resets the operator stack pool and both stacks for a new compile
   (called from INIT_PARSER). */
void far pascal RESET_EXPR_PARSER(void)
{
    POOL(OPERATOR_STACK_POOL).unit=POOL(OPERATOR_STACK_POOL).step=0;
    POOL(OPERATOR_STACK_POOL).used=0;
    POOL_INIT(&OPERATOR_STACK_POOL,0);
    OPERATOR_STACK_OFFSET=0;
    OPERAND_LIST_HEAD=0;
    OPERAND_LIST_BASE=0;
}
#undef POOL
