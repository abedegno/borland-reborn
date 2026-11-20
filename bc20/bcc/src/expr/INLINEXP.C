/* target: ovr093_C233UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: inline function expansion. Entry points: PARSE_INLINE_STATEMENT,
   PARSE_INLINE_BLOCK, SUBSTITUTE_LVALUE_PARAM, SUBSTITUTE_PARAMETERS, EXPAND_INLINE_CALL.
   Map of all sources: docs/SOURCE-MAP.md. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
/* Overview: expansion of calls to C++ inline functions (and of compiler-generated
   special members) into the calling expression. EXPAND_INLINE_CALL is called by
   CHECK_CALL_ARGUMENTS (expr/CALLCHK.C) for a call that should be expanded. The body of
   an inline function was saved as tokens; REPLAY_FUNCTION_BODY seeks the token stream
   to it (SYM_INLINE_POS) and parses it again, here with a special statement parser that
   turns the body into one expression instead of statements:
     - an expression statement becomes (void)expr, a block a comma list of its items,
       a declaration its initialisation;
     - "return e" becomes a cast of e to the return type (or &e for a reference result)
       and marks the rest of the path as dead (context->returned);
     - "if" becomes cond ? then : else, and when only one branch returns, the
       statements after the if are folded into the other branch;
     - only these statement kinds can be expanded; labels are skipped.
   Then BIND_INLINE_PARAMETERS replaces the parameters by the call's arguments: an
   argument used at most once, or a trivial one, is substituted directly (as a copy);
   otherwise it is first stored in a temporary. Constructors and destructors get extra
   work (member initialisers, the "this" allocation test, the delete flag). All parser
   and class state the expansion changes is saved and restored around it, and
   INLINE_FUNCTION_STACK lists the functions being expanded so a recursive inline call
   is compiled as a normal call instead.
   The "flag" outputs of the PARSE_INLINE_* functions mean "this part contains a
   return". struct C25Context: returned (a return was already seen on this path, so
   what follows is dead and is freed), type (the return type), by_ref (returns a
   reference), temps (list of conditional results that still need the code after them).
   MAKE_UNARY_NODE / MAKE_BINARY_NODE / MAKE_CONDITIONAL_NODE take token codes: 0x18
   TOK_STAR, 0x2A TOK_NOT; 0x6B (named TOK_INLINE in TOKEN.H) as a conditional's operator
   probably maps to operator 0x45, the conditional the compiler builds itself; 5 probably
   maps to the initialisation operator 0x47. */

/* ---- PARSE_INLINE_STATEMENTS (listing 0F60) ---- */
/* 6-byte statement context passed down the inline-body parser. */
struct C25Context {
    unsigned char returned;     /* 0 */
    unsigned int type;          /* 1 */
    unsigned char by_ref;       /* 3 */
    unsigned int temps;         /* 4 */
};
unsigned int far pascal PARSE_INLINE_STATEMENT(unsigned char far *flag,struct C25Context far *context);
struct C233Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned char value[10];
};
extern struct C233Token  CURRENT_TOKEN_RECORD,TOKEN_TYPE;
extern unsigned char far pascal TOKEN_IS_TYPE_START(void far *);
extern void far pascal PEEK_TOKEN(void);
extern unsigned int far pascal PARSE_DECLARATION(unsigned char);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);

/* PARSE_INLINE_STATEMENTS: parses statements and declarations up to the end of the
   current block (while the token can start one, TYPE_FLAGS 0x108) and joins them with
   commas. *flag is set when one of them returns. */
static unsigned int far pascal PARSE_INLINE_STATEMENTS(unsigned char far *flag,struct C25Context far *context)
{
    unsigned char sub;
    register unsigned int list;
    register unsigned int item;

    list=0;
    *flag=0;
    while(TYPE_FLAGS[CURRENT_TOKEN]&0x108) {
        if(TOKEN_IS_TYPE_START(&CURRENT_TOKEN_RECORD) && (PEEK_TOKEN(),TOKEN_TYPE.kind)!=0x67 &&
           (PEEK_TOKEN(),TOKEN_TYPE.kind)!=1) {
            IN_ERROR_RECOVERY=0;
            item=PARSE_DECLARATION(1);
        } else {
            item=PARSE_INLINE_STATEMENT(&sub,context);
            if(sub)
                *flag=1;
        }
        list=JOIN_COMMA_EXPR(list,item);
    }
    return list;
}

/* ---- APPEND_EXPR_CHAIN (listing 0FE9) ---- */
extern unsigned int  EXPR_POOL_SEG;

/* APPEND_EXPR_CHAIN: appends list tail to list head (cells linked through EXPR_LEFT). */
static unsigned int near pascal APPEND_EXPR_CHAIN(register unsigned int head,unsigned int tail)
{
    register unsigned int node;

    node=head;
    if(head==0)
        return tail;
    while(EXPR_W(node,EXPR_LEFT))
        node=EXPR_W(node,EXPR_LEFT);
    EXPR_W(node,EXPR_LEFT)=tail;
    return head;
}

/* ---- APPEND_TAIL_TO_BRANCHES (listing 1021) ---- */
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);

/* APPEND_TAIL_TO_BRANCHES: for each pending conditional in the list "node", appends a
   copy of expr (the statements that follow an if) to the arm that did not return.
   flag set (expr itself returns) removes the entry from the list. */
static void near pascal APPEND_TAIL_TO_BRANCHES(register unsigned int node,unsigned int expr,
    unsigned char flag)
{
    unsigned int inner;
    register unsigned int copy;

    if(expr==0)
        return;
    for(; node; node=EXPR_W(node,EXPR_LEFT)) {
        if(EXPR_W(node,EXPR_RIGHT)==0)
            continue;
        inner=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT);
        copy=COPY_EXPR_TREE(expr);
        EXPR_W(inner,EXPR_RIGHT)=JOIN_COMMA_EXPR(EXPR_W(inner,EXPR_RIGHT),copy);
        if(flag)
            EXPR_W(node,EXPR_RIGHT)=0;
        else if(EXPR_W(copy,EXPR_OP)==0x45)
            EXPR_W(node,EXPR_RIGHT)=copy;
    }
}

/* ---- PARSE_INLINE_IF (listing 10A5) ---- */
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal EXPECT_TOKEN_ELSE_REPORT(unsigned int,unsigned int,char far *);
extern unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern void far pascal FREE_EXPR_TREE(unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_LIST_NODE(unsigned int,unsigned int);

/* PARSE_INLINE_IF: parses "if (cond) stmt [else stmt]" into cond ? then : else (missing
   arms become 0). If only the else arm returns the arms are swapped and the condition
   negated. chained is 1 for a statement-level if, whose following statements may then
   be pulled into the non-returning arm. A dead if (after a return) is parsed and
   dropped. */
static unsigned int far pascal PARSE_INLINE_IF(unsigned char chained,unsigned char far *flag,
    struct C25Context far *context)
{
    unsigned int condition;
    unsigned int then_part;
    unsigned int result;
    unsigned char saved;
    unsigned char then_flag;
    unsigned char else_flag;
    unsigned char any;
    register unsigned int else_part;
    register unsigned int list;

    any=0;
    saved=context->returned;
    then_flag=0;
    else_flag=0;
    *flag=0;
    list=context->temps;
    context->temps=0;
    IN_ERROR_RECOVERY=0;
    ADVANCE_TOKEN();
    EXPECT_TOKEN_ELSE_REPORT(1,0x3E,STR_IF_2);
    condition=PARSE_COMMA_EXPRESSION(2);
    EXPECT_TOKEN_ELSE_REPORT(2,0x3F,STR_IF_2);
    then_part=PARSE_INLINE_STATEMENT(&then_flag,context);
    context->returned=saved;
    any=then_flag && context->temps;
    list=APPEND_EXPR_CHAIN(context->temps,list);
    context->temps=0;
    else_part=0;
    if(CURRENT_TOKEN==TOK_ELSE) {
        ADVANCE_TOKEN();
        IN_ERROR_RECOVERY=0;
        else_part=CURRENT_TOKEN==TOK_IF ? PARSE_INLINE_IF(0,&else_flag,context)
                                   : PARSE_INLINE_STATEMENT(&else_flag,context);
        context->returned=saved;
        any=any || else_flag && context->temps;
        list=APPEND_EXPR_CHAIN(context->temps,list);
        context->temps=0;
    }
    if(else_flag && !then_flag) {
        unsigned int swap;
        swap=then_part;
        then_part=else_part;
        else_part=swap;
        condition=MAKE_UNARY_NODE(0x2A,condition);
        then_flag=1;
        else_flag=0;
    }
    if(chained && (any || then_flag & !else_flag)) {
        unsigned char sub;
        unsigned int item;
        sub=0;
        item=PARSE_INLINE_STATEMENTS(&sub,context);
        APPEND_TAIL_TO_BRANCHES(list,item,sub);
        list=APPEND_EXPR_CHAIN(context->temps,list);
        if(!else_flag)
            else_part=JOIN_COMMA_EXPR(else_part,item);
        else_flag=else_flag || sub;
    }
    context->temps=list;
    if(saved) {
        FREE_EXPR_TREE(condition);
        return 0;
    }
    if(then_part==0)
        then_part=MAKE_INT_CONSTANT(INT_TYPE,0L);
    if(else_part==0)
        else_part=MAKE_INT_CONSTANT(INT_TYPE,0L);
    result=MAKE_CONDITIONAL_NODE(0x6B,condition,then_part,else_part);
    if(else_flag) {
        context->returned=1;
        *flag=1;
    } else if(then_flag) {
        context->temps=MAKE_LIST_NODE(result,context->temps);
        *flag=1;
    }
    return result;
}

/* ---- PARSE_INLINE_STATEMENT (listing 1314) ---- */
unsigned int far pascal PARSE_INLINE_BLOCK(unsigned char far *flag,struct C25Context far *context);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern void far pascal SKIP_TO_SYNC_TOKEN(unsigned int);

/* PARSE_INLINE_STATEMENT: parses one statement of an inline body into an expression
   (see the overview). Labels ("name :" and stray ":") are skipped. For "else" and for
   tokens that cannot start a statement, result is returned without being set, as in the
   original. Returns 0 for dead code (after a return). */
unsigned int far pascal PARSE_INLINE_STATEMENT(unsigned char far *flag,struct C25Context far *context)
{
    unsigned char saved;
    register unsigned int result;

    saved=context->returned;
    while((CURRENT_TOKEN==TOK_IDENT && (PEEK_TOKEN(),TOKEN_TYPE.kind)==0x21) || CURRENT_TOKEN==TOK_COLON) {
        if(CURRENT_TOKEN!=TOK_COLON)
            ADVANCE_TOKEN();
        ADVANCE_TOKEN();
    }
    *flag=0;
    switch(CURRENT_TOKEN) {
    case TOK_SEMICOLON:
        ADVANCE_TOKEN();
        result=MAKE_INT_CONSTANT(INT_TYPE,0L);
        break;
    case TOK_LBRACE:
        result=PARSE_INLINE_BLOCK(flag,context);
        break;
    case TOK_IF:
        result=PARSE_INLINE_IF(1,flag,context);
        break;
    case TOK_ELSE:   /* the original leaves result (SI) unset here and returns it */
        ADVANCE_TOKEN();
        break;
    case TOK_RETURN:
        if((PEEK_TOKEN(),TYPE_FLAGS[TOKEN_TYPE.kind])&EXPR_START_FLAG_MASK) {
            ADVANCE_TOKEN();
            result=PARSE_COMMA_EXPRESSION(7);
        } else {
            result=MAKE_INT_CONSTANT(INT_TYPE,0L);
            ADVANCE_TOKEN();
        }
        REQUIRE_TOKEN_ELSE_ERROR(7,0xEA);
        if(!context->returned) {
            result=context->by_ref ? MAKE_UNARY_NODE(0x1D,result)
                                   : MAKE_CAST_NODE(context->type,result);
            *flag=1;
            context->returned=1;
        }
        break;
    case TOK_LPAREN: case TOK_PLUS: case TOK_MINUS: case TOK_STAR: case TOK_AMPERSAND: case TOK_COLON:
    case TOK_NOT: case TOK_TILDE: case TOK_SIZEOF: case TOK_INC: case TOK_DEC:
    case TOK_IDENT: case 0x32: case 0x33: case 0x34:
    case 0x65: case TOK_SCOPE: case TOK_DELETE: case TOK_NEW: case TOK_OPERATOR: case TOK_THIS:
        result=MAKE_CAST_NODE(VOID_TYPE,PARSE_COMMA_EXPRESSION(7));
        REQUIRE_TOKEN_ELSE_ERROR(7,0xEA);
        break;
    default:   /* the original reports error 7 and, as in case 0x5A, returns result (SI) unset */
        SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
    }
    if(saved) {
        FREE_EXPR_TREE(result);
        return 0;
    }
    return result;
}

/* ---- PARSE_INLINE_BLOCK (listing 14F5) ---- */
extern unsigned int SCOPE_POOL_SEG;
extern void far pascal POP_SCOPE(unsigned char);

/* PARSE_INLINE_BLOCK: parses { ... } as a comma list, closing the block's scope. */
unsigned int far pascal PARSE_INLINE_BLOCK(unsigned char far *flag,struct C25Context far *context)
{
    unsigned int result;

    if(CURRENT_TOKEN==TOK_LBRACE)
        ADVANCE_TOKEN();
    BLOCK_NEST_LEVEL++;
    result=PARSE_INLINE_STATEMENTS(flag,context);
    if(SCOPE_W(CURRENT_SCOPE,SCOPE_NEST_LEVEL)==BLOCK_NEST_LEVEL)
        POP_SCOPE(1);
    if(CURRENT_TOKEN==TOK_RBRACE)
        ADVANCE_TOKEN();
    BLOCK_NEST_LEVEL--;
    return result;
}

/* ---- EXPR_REGISTER_NEED (listing 1550) ---- */
/* 9-byte parameter binding and the 0x9F-byte binding table. */
struct C25Entry {
    unsigned int name;          /* 0 */
    unsigned int type;          /* 2 */
    unsigned int value;         /* 4 */
    unsigned int temp;          /* 6 */
    unsigned char by_ref;       /* 8 */
};
struct C25Map {
    struct C25Entry entry[17];  /* 00 */
    int count;                  /* 99 */
    unsigned int list;          /* 9B */
    unsigned int result;        /* 9D */
};

/* EXPR_REGISTER_NEED: index of the parameter symbol name in the binding table, or -1. */
static int far pascal EXPR_REGISTER_NEED(unsigned int name,struct C25Map far *map)
{
    register int index;

    for(index=0; index<map->count && map->entry[index].name!=name; index++)
        ;
    if(map->count==index)
        index=-1;
    return index;
}

/* ---- SUBSTITUTE_LVALUE_PARAM (listing 1588) ---- */
unsigned int far pascal SUBSTITUTE_PARAMETERS(register unsigned int node,struct C25Map far *map);
extern unsigned char far pascal IS_NAMED_OBJECT_EXPR(unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);

/* SUBSTITUTE_LVALUE_PARAM: substitution where the parameter is used as an lvalue
   (assigned, incremented or has its address taken): reference parameters and named
   object arguments are substituted directly; otherwise the argument is copied once into
   a temporary that is then used, since the function may change its own copy. For the
   first parameter of a member function ("this", index 0) the temporary becomes
   map->result and CTOR_THIS_ASSIGNED records whether it was assigned (flag). */
unsigned int far pascal SUBSTITUTE_LVALUE_PARAM(register unsigned int node,struct C25Map far *map,
    unsigned char flag)
{
    unsigned int declaration;
    unsigned int type;
    struct C25Entry far *entry;
    register int index;

    if(EXPR_W(node,EXPR_OP)==EOP_DOT) {
        EXPR_W(node,EXPR_LEFT)=SUBSTITUTE_LVALUE_PARAM(EXPR_W(node,EXPR_LEFT),map,flag);
    } else if(EXPR_W(node,EXPR_OP)==1) {
        index=EXPR_REGISTER_NEED(EXPR_W(node,EXPR_LEFT),map);
        if(index!=-1) {
            entry=&map->entry[index];
            if((entry->by_ref || IS_NAMED_OBJECT_EXPR(entry->value)) &&
               ((EXPR_B(node,EXPR_NODE_FLAGS)&1)==0 || index || CURRENT_CLASS_TYPE==0)) {
                if(entry->temp)
                    EXPR_W(node,EXPR_LEFT)=entry->temp;
                else {
                    FREE_EXPR_NODE(node);
                    node=COPY_EXPR_TREE(entry->value);
                    if(entry->by_ref)
                        EXPR_W(node,EXPR_TYPE)=entry->type;
                }
            } else {
                if(entry->temp==0) {
                    type=entry->type;
                    entry->temp=CREATE_LOCAL_TEMP(type);
                    declaration=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(entry->temp),COPY_EXPR_TREE(entry->value));
                    map->list=JOIN_COMMA_EXPR(map->list,declaration);
                }
                if(index==0 && CURRENT_CLASS_TYPE) {
                    map->result=entry->temp;
                    CTOR_THIS_ASSIGNED=flag;
                }
                EXPR_W(node,EXPR_LEFT)=entry->temp;
            }
        }
    } else
        node=SUBSTITUTE_PARAMETERS(node,map);
    return node;
}

/* ---- SUBSTITUTE_PARAMETER (listing 1703) ---- */
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal MAKE_ADDRESS_OF(unsigned int);

/* SUBSTITUTE_PARAMETER: replaces one use (a symbol leaf) of a parameter by its
   temporary, or by a copy of the argument expression. A use of "this" as an object in a
   member function is turned back into an address. */
static unsigned int far pascal SUBSTITUTE_PARAMETER(register unsigned int node,struct C25Map far *map)
{
    unsigned char convert;
    struct C25Entry far *entry;
    register int index;

    index=EXPR_REGISTER_NEED(EXPR_W(node,EXPR_LEFT),map);
    if(index==-1)
        return node;
    SYM_B(EXPR_W(node,EXPR_LEFT),SYM_FLAGS)|=4;
    convert=(EXPR_B(node,EXPR_NODE_FLAGS)&1) && index==0 && CURRENT_CLASS_TYPE &&
            ((EXPR_FLAGS[TYPE_W(EXPR_W(node,EXPR_TYPE),TYPE_KIND)]&0x14)==0 || (TYPE_B(EXPR_W(node,EXPR_TYPE),TYPE_ATTRS)&0x20)==0);
    entry=&map->entry[index];
    if(entry->temp) {
        EXPR_W(node,EXPR_LEFT)=entry->temp;
        return node;
    }
    FREE_EXPR_NODE(node);
    node=COPY_EXPR_TREE(entry->value);
    if(entry->by_ref && !convert)
        EXPR_W(node,EXPR_TYPE)=entry->type;
    if(convert)
        node=MAKE_ADDRESS_OF(CONVERT_TO_RVALUE(node));
    return node;
}

/* ---- SUBSTITUTE_PARAMETERS (listing 17FE) ---- */
extern void far cdecl REPORT_FATAL(unsigned int);

/* SUBSTITUTE_PARAMETERS: walks the body and substitutes every parameter use; the
   targets of assignments, ++/-- and & get SUBSTITUTE_LVALUE_PARAM. */
unsigned int far pascal SUBSTITUTE_PARAMETERS(register unsigned int node,struct C25Map far *map)
{
    if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY);
    if(node==0 || EXPR_W(node,EXPR_OP)==0)
        return node;
    if(EXPR_W(node,EXPR_OP)==1)
        return SUBSTITUTE_PARAMETER(node,map);
    if(EXPR_OP_FLAGS[EXPR_W(node,EXPR_OP)]&4)
        return node;
    if(EXPR_W(node,EXPR_OP)==EOP_INC || EXPR_W(node,EXPR_OP)==EOP_DEC || (EXPR_I(node,EXPR_OP)>=EOP_ASSIGN && EXPR_I(node,EXPR_OP)<=EOP_XOR_ASSIGN))
        EXPR_W(node,EXPR_LEFT)=SUBSTITUTE_LVALUE_PARAM(EXPR_W(node,EXPR_LEFT),map,1);
    else if(EXPR_W(node,EXPR_OP)==EOP_ADDR && EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==1)
        EXPR_W(node,EXPR_LEFT)=SUBSTITUTE_LVALUE_PARAM(EXPR_W(node,EXPR_LEFT),map,0);
    else
        EXPR_W(node,EXPR_LEFT)=SUBSTITUTE_PARAMETERS(EXPR_W(node,EXPR_LEFT),map);
    EXPR_W(node,EXPR_RIGHT)=SUBSTITUTE_PARAMETERS(EXPR_W(node,EXPR_RIGHT),map);
    return node;
}

/* ---- FIND_LVALUE_SYMBOL (listing 18DF) ---- */

/* FIND_LVALUE_SYMBOL: the symbol at the bottom of an lvalue expression (following the
   right side of commas and the left side of everything else). */
static unsigned int far pascal FIND_LVALUE_SYMBOL(register unsigned int node)
{
    while(EXPR_W(node,EXPR_OP)!=1) {
        if(EXPR_W(node,EXPR_OP)==EOP_COMMA)
            node=EXPR_W(node,EXPR_RIGHT);
        else
            node=EXPR_W(node,EXPR_LEFT);
    }
    return EXPR_W(node,EXPR_LEFT);
}

/* ---- IS_TRIVIAL_ARGUMENT (listing 1913) ---- */

/* IS_TRIVIAL_ARGUMENT: 1 for arguments cheap enough to repeat: symbols, constants,
   member pointer constants (0x48) and &symbol. */
static unsigned char far pascal IS_TRIVIAL_ARGUMENT(register unsigned int node)
{
    switch(EXPR_W(node,EXPR_OP)) {
    case 1: case EOP_CONST: case 3: case 0x48:
        return 1;
    case EOP_ADDR:
        return EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==1;
    default:
        return 0;
    }
}

/* The 0x9B3 row also holds this function (listing 1976, offset 0xA16). */
/* COUNT_SYMBOL_USES: number of leaves in the tree that name symbol "name". */
static unsigned int far pascal COUNT_SYMBOL_USES(register unsigned int name,register unsigned int node)
{
    if(node==0 || EXPR_W(node,EXPR_OP)==0)
        return 0;
    if(EXPR_W(node,EXPR_OP)==1)
        return EXPR_W(node,EXPR_LEFT)==name;
    if(EXPR_OP_FLAGS[EXPR_W(node,EXPR_OP)]&4)
        return 0;
    return COUNT_SYMBOL_USES(name,EXPR_W(node,EXPR_LEFT))+COUNT_SYMBOL_USES(name,EXPR_W(node,EXPR_RIGHT));
}

/* ---- BIND_INLINE_PARAMETERS (listing 19E2) ---- */
extern unsigned int BCC_TREE_SPECIAL;
extern unsigned int far pascal FIND_NAME_IN_LIST(unsigned int,unsigned int);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);

/* BIND_INLINE_PARAMETERS: builds the binding table from the parameters of the function
   being expanded (BCC_TREE_SPECIAL) and the call's arguments, then substitutes them
   into body. Class arguments passed by value that need construction (TYPE_ATTRS 4) are
   taken by address. Arguments used more than once and not trivial are evaluated first
   into a temporary (or, for a named object, evaluated for side effects and then reused).
   Returns (argument setup, body). Also substitutes into MEMBER_INIT_EXPR when the
   constructor assigned to "this". */
static unsigned int far pascal BIND_INLINE_PARAMETERS(unsigned int call,unsigned int body)
{
    unsigned char reference;
    unsigned int result;
    struct C25Entry far *entry;
    struct C25Map map;
    register unsigned int argument;
    register unsigned int parameter;

    map.list=0;
    argument=EXPR_W(call,EXPR_RIGHT);
    map.count=0;
    map.result=0;
    CTOR_THIS_ASSIGNED=0;
    parameter=TYPE_W(SYM_W(BCC_TREE_SPECIAL,SYM_TYPE),TYPE_PARAMS);
    while(parameter) {
        entry=(struct C25Entry far *)map.entry+map.count++;
        entry->name=FIND_NAME_IN_LIST(FORMAL_W(parameter,FORMAL_NAME),SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
        entry->type=FORMAL_W(parameter,FORMAL_TYPE);
        entry->by_ref=(EXPR_FLAGS[TYPE_W(entry->type,TYPE_KIND)]&0x14) && (TYPE_B(entry->type,TYPE_ATTRS)&0x20);
        reference=(EXPR_FLAGS[TYPE_W(entry->type,TYPE_KIND)]&0x40) && (TYPE_B(entry->type,TYPE_ATTRS)&4);
        if(reference)
            EXPR_W(argument,EXPR_RIGHT)=ANALYZE_AND_DECAY(MAKE_UNARY_NODE(0x18,EXPR_W(argument,EXPR_RIGHT)),0);
        EXPR_W(argument,EXPR_RIGHT)=SIMPLIFY_EXPRESSION(EXPR_W(argument,EXPR_RIGHT),0);
        entry->value=EXPR_W(argument,EXPR_RIGHT);
        if(COUNT_SYMBOL_USES(entry->name,body)>1 && !IS_TRIVIAL_ARGUMENT(entry->value)) {
            if(IS_NAMED_OBJECT_EXPR(entry->value)) {
                entry->temp=FIND_LVALUE_SYMBOL(entry->value);
                map.list=JOIN_COMMA_EXPR(map.list,COPY_EXPR_TREE(entry->value));
            } else {
                entry->temp=CREATE_LOCAL_TEMP(entry->type);
                map.list=JOIN_COMMA_EXPR(map.list,
                    MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(entry->temp),COPY_EXPR_TREE(entry->value)));
            }
        } else
            entry->temp=0;
        argument=EXPR_W(argument,EXPR_LEFT);
        parameter=FORMAL_W(parameter,FORMAL_NEXT);
    }
    if(body)
        body=SUBSTITUTE_PARAMETERS(body,&map);
    result=JOIN_COMMA_EXPR(map.list,body);
    if(CTOR_THIS_ASSIGNED && MEMBER_INIT_EXPR) {
        map.list=0;
        MEMBER_INIT_EXPR=SUBSTITUTE_PARAMETERS(MEMBER_INIT_EXPR,&map);
    }
    return result;
}

/* ---- EXPAND_FUNCTION_BODY (listing 1C20) ---- */

/* EXPAND_FUNCTION_BODY: parses an ordinary inline function body ({ expected) and binds
   the call's arguments into it. */
static unsigned int far pascal EXPAND_FUNCTION_BODY(unsigned int call,struct C25Context far *context)
{
    unsigned char sub;
    register unsigned int body;

    IN_ERROR_RECOVERY=0;
    EXPECT_TOKEN_ELSE_REPORT(5,0xD8,(char far *)0);
    BLOCK_NEST_LEVEL++;
    body=PARSE_INLINE_STATEMENTS(&sub,context);
    if(body==0)
        body=MAKE_INT_CONSTANT(INT_TYPE,0L);
    body=BIND_INLINE_PARAMETERS(call,body);
    return body;
}

/* ---- ASSIGNS_TO_THIS (listing 1C79) ---- */

/* ASSIGNS_TO_THIS: 1 when the tree assigns to the "this" symbol (CTOR_THIS_SYMBOL),
   the old C++ way for a constructor to choose its own storage. */
static unsigned char far pascal ASSIGNS_TO_THIS(register unsigned int node)
{
    if(node==0 || EXPR_W(node,EXPR_OP)==0 || (EXPR_OP_FLAGS[EXPR_W(node,EXPR_OP)]&4))
        return 0;
    if((EXPR_W(node,EXPR_OP)==EOP_ASSIGN || EXPR_W(node,EXPR_OP)==5) && EXPR_W(node,EXPR_LEFT) && EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==1 &&
       (EXPR_B(EXPR_W(node,EXPR_LEFT),EXPR_NODE_FLAGS)&1))
        return EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_LEFT)==CTOR_THIS_SYMBOL;
    return ASSIGNS_TO_THIS(EXPR_W(node,EXPR_LEFT)) || ASSIGNS_TO_THIS(EXPR_W(node,EXPR_RIGHT));
}

/* ---- SAVE_THIS_ARG_IN_TEMP (listing 1D0C) ---- */
extern unsigned int far pascal BUILD_THIS_NODE(unsigned int);

/* SAVE_THIS_ARG_IN_TEMP: for a constructor that assigns to this: stores the call's
   object argument in a new temporary (CTOR_THIS_SYMBOL) and passes *(temp = arg, &this)
   instead, so the assignment can be seen by the caller. */
static unsigned int far pascal SAVE_THIS_ARG_IN_TEMP(register unsigned int node)
{
    unsigned int type;
    register unsigned int list;

    type=EXPR_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT),EXPR_TYPE);
    CTOR_THIS_SYMBOL=CREATE_LOCAL_TEMP(EXPR_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT),EXPR_TYPE));
    list=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL),EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT));
    list=JOIN_COMMA_EXPR(list,MAKE_ADDRESS_OF(BUILD_THIS_NODE(CTOR_THIS_SYMBOL)));
    EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT)=ANALYZE_AND_DECAY(MAKE_UNARY_NODE(0x18,list),0);
    EXPR_W(EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_RIGHT),EXPR_TYPE)=type;
    return node;
}

/* ---- FINISH_CONSTRUCTOR_BODY (listing 1DAE) ---- */
extern unsigned int far pascal CHECK_NULL_CONSTANT(unsigned int,unsigned char far *);
extern unsigned int far pascal BUILD_THIS_ALLOCATION(unsigned int,unsigned int);

/* FINISH_CONSTRUCTOR_BODY: completes an expanded constructor body *list: when the
   object argument is a null pointer (construct on the heap), the body runs only if the
   allocation BUILD_THIS_ALLOCATION succeeds; member initialisers (MEMBER_INIT_EXPR) go
   in front; the value of the whole is "this". flag means the class probably uses
   assignment to this (TAG_CLASS_FLAGS bit 2). */
static void far pascal FINISH_CONSTRUCTOR_BODY(unsigned char flag,unsigned int far *list,
    unsigned int far *call)
{
    unsigned char changed;
    register unsigned int node;

    changed=0;
    node=EXPR_W(EXPR_W(*call,EXPR_RIGHT),EXPR_RIGHT);
    if(EXPR_W(node,EXPR_OP)==0x35)
        EXPR_W(node,EXPR_LEFT)=CHECK_NULL_CONSTANT(EXPR_W(node,EXPR_LEFT),&changed);
    else if(EXPR_W(node,EXPR_OP)==EOP_ADDR && EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_OP)==EOP_DEREF)
        EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_LEFT)=CHECK_NULL_CONSTANT(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_LEFT),&changed);
    if(flag && ASSIGNS_TO_THIS(*list))
        *call=SAVE_THIS_ARG_IN_TEMP(*call);
    else {
        if(changed) {
            node=BUILD_THIS_ALLOCATION(CTOR_THIS_SYMBOL,CURRENT_CLASS_TYPE);
            *list=JOIN_COMMA_EXPR(MEMBER_INIT_EXPR,*list);
            *list=MAKE_CONDITIONAL_NODE(0x6B,node,*list,MAKE_INT_CONSTANT(INT_TYPE,0L));
        } else {
            *list=JOIN_COMMA_EXPR(MEMBER_INIT_EXPR,*list);
            if(flag && ASSIGNS_TO_THIS(MEMBER_INIT_EXPR))
                *call=SAVE_THIS_ARG_IN_TEMP(*call);
        }
        MEMBER_INIT_EXPR=0;
    }
    *list=JOIN_COMMA_EXPR(*list,BUILD_THIS_NODE(CTOR_THIS_SYMBOL));
}

/* ---- EXPAND_CONSTRUCTOR_BODY (listing 1EEC) ---- */
extern unsigned int far pascal PARSE_MEMBER_INITIALIZERS(unsigned char,unsigned int);

/* EXPAND_CONSTRUCTOR_BODY: parses the member initialiser list and body of an inline
   constructor and binds the arguments. */
static unsigned int far pascal EXPAND_CONSTRUCTOR_BODY(unsigned int call,struct C25Context far *context)
{
    unsigned char sub;
    unsigned int body;
    unsigned char member;
    unsigned int name;

    CTOR_DTOR_MODE=1;
    IN_ERROR_RECOVERY=0;
    CTOR_THIS_SYMBOL=FIND_NAME_IN_LIST(THIS_NAME,SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
    member=(TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&2)!=0;
    name=FIND_NAME_IN_LIST(VTABLE_PTR_NAME,SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
    MEMBER_INIT_EXPR=PARSE_MEMBER_INITIALIZERS(member,name);
    EXPECT_TOKEN_ELSE_REPORT(5,0xD8,(char far *)0);
    BLOCK_NEST_LEVEL++;
    body=PARSE_INLINE_STATEMENTS(&sub,context);
    CTOR_THIS_ASSIGNED=0;
    CTOR_CHECK_THIS_ASSIGN=member;
    FINISH_CONSTRUCTOR_BODY(member,&body,&call);
    body=BIND_INLINE_PARAMETERS(call,body);
    return body;
}

/* ---- EXPAND_DESTRUCTOR_BODY (listing 1FB7) ---- */
extern unsigned int far pascal BUILD_DESTRUCTOR_BODY(unsigned int,unsigned int,unsigned char,unsigned int);

/* EXPAND_DESTRUCTOR_BODY: parses an inline destructor body, appends the member and
   base destructor calls (BUILD_DESTRUCTOR_BODY, with the delete flag parameter) and
   guards it all with "this != 0". */
static unsigned int far pascal EXPAND_DESTRUCTOR_BODY(unsigned int call,struct C25Context far *context)
{
    unsigned int value;
    unsigned int name;
    unsigned int alias;
    unsigned char sub;
    register unsigned int body;
    register unsigned int result;

    CTOR_DTOR_MODE=2;
    name=FIND_NAME_IN_LIST(THIS_NAME,SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
    alias=FIND_NAME_IN_LIST(OPERATOR_DELETE_NAME,SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
    IN_ERROR_RECOVERY=0;
    EXPECT_TOKEN_ELSE_REPORT(5,0xD8,(char far *)0);
    BLOCK_NEST_LEVEL++;
    body=PARSE_INLINE_STATEMENTS(&sub,context);
    body=JOIN_COMMA_EXPR(body,BUILD_DESTRUCTOR_BODY(CURRENT_CLASS_TYPE,name,ASSIGNS_TO_THIS(body),alias));
    value=BUILD_THIS_NODE(name);
    result=MAKE_CONDITIONAL_NODE(0x6B,value,body,MAKE_INT_CONSTANT(VOID_TYPE,0L));
    CTOR_CHECK_THIS_ASSIGN=(TAG_W(TYPE_W(CURRENT_CLASS_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&2)!=0;
    result=BIND_INLINE_PARAMETERS(call,result);
    return result;
}

/* ---- MAKE_RVALUE (listing 209E) ---- */
extern unsigned char far pascal IS_LVALUE(unsigned int);

/* MAKE_RVALUE: makes sure the expanded body is not an lvalue (prefixes "0,") so the
   inline call cannot be assigned to. */
static unsigned int far pascal MAKE_RVALUE(register unsigned int list)
{
    if(IS_LVALUE(list))
        list=JOIN_COMMA_EXPR(MAKE_INT_CONSTANT(INT_TYPE,0L),list);
    return list;
}

/* ---- CHECK_RECURSIVE_EXPANSION (listing 20CE) ---- */
extern unsigned char far pascal LIST_CONTAINS_VALUE(unsigned int,unsigned int);
extern unsigned int far pascal LIST_CONS(unsigned int,unsigned int);

/* CHECK_RECURSIVE_EXPANSION: 1 when symbol is already being expanded; otherwise pushes
   it on INLINE_FUNCTION_STACK and returns 0. */
static unsigned char far pascal CHECK_RECURSIVE_EXPANSION(register unsigned int symbol)
{
    if(LIST_CONTAINS_VALUE(symbol,INLINE_FUNCTION_STACK))
        return 1;
    INLINE_FUNCTION_STACK=LIST_CONS(INLINE_FUNCTION_STACK,symbol);
    return 0;
}

/* ---- REPLAY_FUNCTION_BODY (listing 20FB) ---- */
extern void far pascal STREAM_SEEK(unsigned int,int);
extern void far pascal STREAM_GET_TOKEN(unsigned int,struct C233Token far *);
extern unsigned int far pascal EXPR_BANK_MARK(void);
extern unsigned int far pascal PACK_EXPR_TREE(unsigned int);
extern void far pascal EXPR_BANK_RESET(unsigned int);

/* REPLAY_FUNCTION_BODY: saves the lexer state, points it at the saved tokens of the
   called function's body, parses and expands it (constructor, destructor or ordinary
   function), restores the lexer, analyses the result against the function's type
   (CURRENT_FUNCTION_TYPE), and frees packed trees made meanwhile. For a constructor the
   member initialisers are analysed and kept packed in PACKED_INIT_EXPR. */
static unsigned int far pascal REPLAY_FUNCTION_BODY(register unsigned int call,
    struct C25Context far *context)
{
    unsigned int saved_input;
    unsigned int saved_depth;
    unsigned int mark;
    struct C233Token saved_token;
    struct C233Token saved_lookahead;
    register unsigned int result;

    saved_token=CURRENT_TOKEN_RECORD;
    saved_lookahead=TOKEN_TYPE;
    saved_input=CURRENT_FILE_NAME;
    saved_depth=SCOPE_STACK_DEPTH;
    C26_SCOPE_STACK[SCOPE_STACK_DEPTH]=TOKEN_STREAM_HANDLE;
    ++SCOPE_STACK_DEPTH;
    STREAM_SEEK(TOKEN_STREAM_HANDLE,SYM_W(EXPR_W(EXPR_W(call,EXPR_LEFT),EXPR_LEFT),SYM_INLINE_POS));
    STREAM_GET_TOKEN(TOKEN_STREAM_HANDLE,&CURRENT_TOKEN_RECORD);
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    TOKEN_TYPE.kind=0x82;
    context->returned=0;
    mark=EXPR_BANK_MARK();
    result=SYM_W(BCC_TREE_SPECIAL,SYM_FUNC_KIND)==3 ? EXPAND_CONSTRUCTOR_BODY(call,context)
         : SYM_W(BCC_TREE_SPECIAL,SYM_FUNC_KIND)==4 ? EXPAND_DESTRUCTOR_BODY(call,context)
         : EXPAND_FUNCTION_BODY(call,context);
    if(CURRENT_TOKEN==TOK_RBRACE)
        ADVANCE_TOKEN();
    SCOPE_STACK_DEPTH=saved_depth;
    CURRENT_TOKEN_RECORD=saved_token;
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    TOKEN_TYPE=saved_lookahead;
    CURRENT_FILE_NAME=saved_input;
    if(SYM_W(BCC_TREE_SPECIAL,SYM_FUNC_KIND)==3) {
        MEMBER_INIT_EXPR=ANALYZE_AND_DECAY(MEMBER_INIT_EXPR,VOID_TYPE);
        PACKED_INIT_EXPR=PACK_EXPR_TREE(MEMBER_INIT_EXPR);
        FREE_EXPR_TREE(MEMBER_INIT_EXPR);
    }
    result=ANALYZE_AND_DECAY(result,CURRENT_FUNCTION_TYPE);
    EXPR_BANK_RESET(mark);
    POP_SCOPE(1);
    BLOCK_NEST_LEVEL--;
    return result;
}

/* ---- EXPAND_SPECIAL_MEMBER_BODY (listing 2272) ---- */
extern unsigned int far pascal BUILD_SPECIAL_MEMBER_BODY(unsigned int);

/* EXPAND_SPECIAL_MEMBER_BODY: expansion of a compiler-generated special member (its
   body comes from BUILD_SPECIAL_MEMBER_BODY instead of saved tokens). */
static unsigned int far pascal EXPAND_SPECIAL_MEMBER_BODY(unsigned int call)
{
    unsigned int body;

    body=BUILD_SPECIAL_MEMBER_BODY(EXPR_W(EXPR_W(call,EXPR_LEFT),EXPR_LEFT));
    if(SYM_W(EXPR_W(EXPR_W(call,EXPR_LEFT),EXPR_LEFT),SYM_FUNC_KIND)==3)
        FINISH_CONSTRUCTOR_BODY(0,&body,&call);
    body=ANALYZE_AND_DECAY(BIND_INLINE_PARAMETERS(call,body),0);
    POP_SCOPE(1);
    return body;
}

/* ---- EXPAND_INLINE_CALL (listing 22E0) ---- */
extern unsigned int RETURN_FORM_SEEN;
extern void far pascal QUEUE_DEFERRED_SYMBOL(unsigned int);
extern void far pascal PUSH_SCOPE(unsigned char);
extern void far pascal DECLARE_HIDDEN_RETURN_PARAM(unsigned int,unsigned char);
extern void far pascal DECLARE_PARAMETERS(unsigned int,unsigned char);
extern unsigned int far pascal LOOKUP_NAME(unsigned int);
extern void far pascal LIST_CELL_FREE(unsigned int);

/* EXPAND_INLINE_CALL: replaces the call node by the expanded body of the called inline
   function and returns the analysed result. A recursive call is left as a call, the
   function is queued for normal compilation and loses its "expand" flag (SYM_FUNC_FLAGS
   4). Otherwise the current function context (BCC_TREE_SPECIAL, CURRENT_FUNCTION_TYPE,
   CURRENT_CLASS_TYPE, the constructor state) is saved, a scope with the callee's
   parameters is opened, the body is expanded, and everything is restored. */
unsigned int far pascal EXPAND_INLINE_CALL(register unsigned int node)
{
    unsigned int body;
    unsigned int function_type;
    unsigned int pending;
    unsigned char is_inline;
    struct C25Context context;
    unsigned int saved_class_type;
    unsigned int function;      /* the called function, then the saved BCC_TREE_SPECIAL: one stack slot in the original */
    unsigned int saved_root;
    unsigned int saved_ctor_mode;
    unsigned char saved_this_assigned;
    unsigned char saved_check_this;
    unsigned int saved_this_symbol;
    unsigned int saved_packed_init;
    register unsigned int cache;

    function=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_LEFT);
    if(CHECK_RECURSIVE_EXPANSION(function)) {
        QUEUE_DEFERRED_SYMBOL(function);
        SYM_W(function,SYM_FUNC_FLAGS)&=0xFFFB;
        node=ANALYZE_AND_DECAY(node,TYPE_W(SYM_W(function,SYM_TYPE),TYPE_TARGET));
        if(EXPR_W(node,EXPR_OP)==0x36)
            SYM_W(EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_LEFT),SYM_FUNC_FLAGS)|=4;
    } else {
        INLINE_EXPANSION_DEPTH++;
        saved_class_type=CURRENT_CLASS_TYPE;
        function=BCC_TREE_SPECIAL;
        saved_root=CURRENT_FUNCTION_TYPE;
        saved_ctor_mode=CTOR_DTOR_MODE;
        saved_this_symbol=CTOR_THIS_SYMBOL;
        saved_this_assigned=CTOR_THIS_ASSIGNED;
        saved_check_this=CTOR_CHECK_THIS_ASSIGN;
        saved_packed_init=PACKED_INIT_EXPR;
        PUSH_SCOPE(1);
        SCOPE_W(CURRENT_SCOPE,SCOPE_ENTER_BLOCK)=SCOPE_W(SCOPE_W(CURRENT_SCOPE,SCOPE_PARENT),SCOPE_ENTER_BLOCK);
        BCC_TREE_SPECIAL=EXPR_W(EXPR_W(node,EXPR_LEFT),EXPR_LEFT);
        is_inline=(SYM_B(BCC_TREE_SPECIAL,SYM_INLINE_ACCESS)&3)==2;
        CURRENT_CLASS_TYPE=(SYM_B(BCC_TREE_SPECIAL,SYM_FLAGS)&0x10) ? SYM_W(SYM_W(BCC_TREE_SPECIAL,SYM_OWNER_CLASS),SYM_TYPE) : 0;
        CURRENT_FUNCTION_TYPE=SYM_W(BCC_TREE_SPECIAL,SYM_TYPE);
        CTOR_DTOR_MODE=0;
        CTOR_THIS_ASSIGNED=0;
        CTOR_CHECK_THIS_ASSIGN=0;
        PACKED_INIT_EXPR=0;
        cache=CACHE_HEAD;
        while(cache) {
            if(FNCACHE_W(cache,FNCACHE_FUNCTION)==BCC_TREE_SPECIAL) {
                RETURN_FORM_SEEN=FNCACHE_W(cache,FNCACHE_LIST);
                break;
            }
            cache=FNCACHE_W(cache,FNCACHE_NEXT);
        }
        context.type=TYPE_W(CURRENT_FUNCTION_TYPE,TYPE_TARGET);
        function_type=TYPE_W(CURRENT_FUNCTION_TYPE,TYPE_PARAMS);
        if(EXPR_FLAGS[TYPE_W(TYPE_W(CURRENT_FUNCTION_TYPE,TYPE_TARGET),TYPE_KIND)]&0x40)
            DECLARE_HIDDEN_RETURN_PARAM(CURRENT_FUNCTION_TYPE,1);
        DECLARE_PARAMETERS(function_type,1);
        CTOR_THIS_SYMBOL=LOOKUP_NAME(THIS_NAME);
        context.by_ref=(EXPR_FLAGS[TYPE_W(context.type,TYPE_KIND)]&0x14) && (TYPE_B(context.type,TYPE_ATTRS)&0x20);
        if(context.by_ref)
            context.type=TYPE_W(context.type,TYPE_TARGET);
        context.temps=0;
        body=is_inline ? EXPAND_SPECIAL_MEMBER_BODY(node)
             : (SCOPE_W(CURRENT_SCOPE,SCOPE_NEST_LEVEL)++,REPLAY_FUNCTION_BODY(node,&context));
        FREE_EXPR_TREE(node);
        body=context.by_ref ? MAKE_UNARY_NODE(0x18,body) : MAKE_RVALUE(body);
        node=ANALYZE_AND_DECAY(body,0);
        CURRENT_CLASS_TYPE=saved_class_type;
        BCC_TREE_SPECIAL=function;
        CURRENT_FUNCTION_TYPE=saved_root;
        CTOR_DTOR_MODE=saved_ctor_mode;
        CTOR_THIS_SYMBOL=saved_this_symbol;
        CTOR_THIS_ASSIGNED=saved_this_assigned;
        CTOR_CHECK_THIS_ASSIGN=saved_check_this;
        PACKED_INIT_EXPR=saved_packed_init;
        INLINE_EXPANSION_DEPTH--;
        pending=INLINE_FUNCTION_STACK;
        INLINE_FUNCTION_STACK=CONS_W(INLINE_FUNCTION_STACK,CONS_NEXT);
        LIST_CELL_FREE(pending);
    }
    return node;
}
