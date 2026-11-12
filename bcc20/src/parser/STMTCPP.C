/* target: ovr064_C121UNIT */
/* Role: statement parser, C++ mode; declarations. Entry points: RELEASE_SCOPE_OBJECTS,
   PARSE_DECLARATION, CHECK_UNDEFINED_LABELS, PARSE_STATEMENT_LIST, PARSE_FUNCTION_BODY. Map
   of all sources: docs/SOURCE-MAP.md. */
/* Original CO008 (ovr_1bcc_571a) as one source. */
/* opts: -mm -O -Z -p -Y -y */
/* Overview: the statement parser of the C++ front end, which also parses C
   when CPP_MODE (the C++ language flag) is clear; every C++-only
   step is guarded by that flag.  PARSE_FUNCTION_BODY is called for each
   function body (from COMPILE_FUNCTION_DEFINITION, FUNCDEF.C);
   PARSE_STATEMENT_CPP dispatches on the current token to PARSE_IF_STATEMENT,
   PARSE_WHILE and so on, which append flow blocks to the function's code
   as they go (APPEND_JUMP_BLOCK, APPEND_JUMP_IF_FALSE_BLOCK, labels from
   NEW_LABEL_IF_ENABLED, expression blocks), much as STMTC.C does for the
   C front end.  Declarations may appear among statements: a type start is
   checked with IS_DECLARATION_AHEAD and parsed by PARSE_DECLARATION.
   State kept while parsing: CODE_UNREACHABLE (set after a jump, cleared by
   labels; a statement that starts while it is set is "unreachable code"),
   CURRENT_SWITCH (struct SwitchState) and LOOP_CONTEXT (struct LoopState)
   for the innermost switch and loop, saved and restored whole around
   nested ones, ENCLOSING_STATEMENT_KIND (1 switch, 2 loop) for break,
   LOOP_NEST_FACTOR (tripled in each loop: a block weight, and 1 means
   "not in a loop"), and CONSTANT_TRUTH_VALUE results (0 always false,
   1 always true, 2 must be tested).
   C++ destructors: each scope keeps a list of objects to destroy
   (SCOPE_TEMPS, TDTOR records holding a packed destructor-call
   expression).  Leaving a scope normally calls them (RELEASE_SCOPE_OBJECTS);
   break, continue, return and goto first emit the destructor calls for
   everything between here and their target (BUILD_TEMP_DESTRUCTORS).
   DECL_INIT_SERIAL counts initialised declarations so that a goto or case
   label that jumps past an initialisation can be reported. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
/* 17-byte switch context at DS:5EEC (saved and restored whole). */
struct SwitchState {
    unsigned int depth;          /* 5EEC */
    unsigned int cases;          /* 5EEE */
    unsigned int default_label;  /* 5EF0 */
    unsigned int scope;          /* 5EF2 */
    unsigned int break_label;    /* 5EF4 */
    unsigned int outer;          /* 5EF6 */
    unsigned int kind;           /* 5EF8 */
    unsigned char active;        /* 5EFA */
    unsigned char has_default;   /* 5EFB */
    unsigned char no_fall;       /* 5EFC */
};
extern struct SwitchState CURRENT_SWITCH;
struct LoopState {
    unsigned int scope;          /* 5EFD */
    unsigned int break_label;    /* 5EFF */
    unsigned int break_scope;    /* 5F01 */
    unsigned int continue_label; /* 5F03 */
    unsigned char continued;     /* 5F05 */
};
extern struct LoopState LOOP_CONTEXT;

/* ---- RELEASE_SCOPE_OBJECTS (listing 71A0) ---- */
#include <dos.h>
#include "CLEAN8.H"

/* Emits destructor calls for the objects registered in the current
   scope's SCOPE_TEMPS list down to marker (an earlier list head), as one
   comma expression, and frees the entries.  Nothing is emitted when the
   point is unreachable. */
void far pascal RELEASE_SCOPE_OBJECTS(unsigned int marker)
{
    unsigned int pending;
    register unsigned int cursor;
    unsigned int node;

    while(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)!=marker) {
        cursor=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
        SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)=marker;
        pending=0;
        while(cursor!=marker) {
            node=cursor;
            if(!CODE_UNREACHABLE)
                pending=JOIN_COMMA_EXPR(pending,UNPACK_EXPR_TREE(TDTOR_W(node,TDTOR_EXPR)));
            cursor=TDTOR_W(node,TDTOR_NEXT);
            FREE_TEMP_ENTRY(node);
        }
        if(!CODE_UNREACHABLE)
            APPEND_ANALYZED_EXPRESSION(pending);
    }
}

/* ---- IS_DECLARATION_AHEAD (listing 7223) ---- */
extern unsigned int TOKEN_TYPE;
extern void far pascal PEEK_TOKEN(void);
extern unsigned char far pascal BCC_PARSE_BEGIN(unsigned int);
extern void far pascal BCC_PARSE_PUSH(unsigned int);
extern void far pascal BCC_PARSE_POP(unsigned int);
extern unsigned char far pascal SCAN_TYPE_SPECIFIERS(void);
extern unsigned char far pascal SCAN_DECLARATOR(unsigned int);

/* Nonzero if the statement starting here is a declaration.  Storage
   classes, struct and similar keywords, const and volatile decide at once;
   otherwise the tokens are scanned with the lookahead functions of
   LOOKAHD.C inside a recording on replay stream 2, then rewound. */
static unsigned char near pascal IS_DECLARATION_AHEAD(void)
{
    unsigned char valid;

    if(CURRENT_TOKEN==TOK_IDENT) {
        PEEK_TOKEN();
        if(TOKEN_TYPE==0x67)
            return 0;
    }
    if((TYPE_FLAGS[CURRENT_TOKEN]&1) || CURRENT_TOKEN==TOK_STRUCT || CURRENT_TOKEN==TOK_UNION ||
       CURRENT_TOKEN==TOK_CLASS || CURRENT_TOKEN==TOK_ENUM || CURRENT_TOKEN==TOK_CONST || CURRENT_TOKEN==TOK_VOLATILE)
        return 1;
    if(!BCC_PARSE_BEGIN(2))
        return 0;
    BCC_PARSE_PUSH(2);
    valid=SCAN_TYPE_SPECIFIERS();
    if(valid)
        valid=SCAN_DECLARATOR(0);
    BCC_PARSE_POP(2);
    return valid;
}

/* ---- CHECK_SWITCH_SELECTOR (listing 72C0) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal CONVERT_CLASS_TO_INTEGRAL(unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);

/* Checks a switch selector: a class object is converted to an integral
   type in C++; the result must have integral type. */
static unsigned int near pascal CHECK_SWITCH_SELECTOR(register unsigned int expression)
{
    if(expression==0)
        return expression;
    if(CPP_MODE)
        expression=CONVERT_CLASS_TO_INTEGRAL(expression);
    expression=SIMPLIFY_EXPRESSION(expression,0);
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)]&1))
        REPORT_CURRENT_TOKEN(MSG_SWITCH_SELECTION);
    return expression;
}

/* ---- CHECK_CONDITION_EXPR (listing 7313) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_CLASS_TO_SCALAR(unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern void far pascal REPORT_DIAGNOSTIC_AT(unsigned int,long,long,unsigned int,unsigned int);

/* Analyses a condition (if, while, for, do): converts a class object to a
   scalar in C++, requires a scalar type, and warns "possibly incorrect
   assignment" for an assignment used as the condition. */
static unsigned int near pascal CHECK_CONDITION_EXPR(register unsigned int expression)
{
    if(expression==0)
        return expression;
    expression=ANALYZE_AND_DECAY(expression,0);
    if(CPP_MODE)
        expression=CONVERT_CLASS_TO_SCALAR(expression);
    expression=SIMPLIFY_EXPRESSION(expression,0);
    if(!(EXPR_FLAGS[TYPE_W(EXPR_W(expression,EXPR_TYPE),TYPE_KIND)]&7))
        return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_SCALAR_TYPE,expression);
    if(EXPR_W(expression,EXPR_OP)==EOP_ASSIGN)
        REPORT_DIAGNOSTIC_AT(MSG_POSSIBLY_INCORRECT,0L,0L,EXPR_W(expression,EXPR_SRC_LINE),0);
    return expression;
}

/* ---- REVERSE_LIST_TO_COMMA (listing 7394) ---- */
#include <dos.h>
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal UNPACK_EXPR_TREE(unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);

/* Unpacks a packed list of expressions (built in reverse order) and joins
   them in source order into one comma expression. */
static unsigned int near pascal REVERSE_LIST_TO_COMMA(unsigned int list)
{
    unsigned int previous;
    register unsigned int node;
    register unsigned int result;

    node=UNPACK_EXPR_TREE(list);
    result=0;
    while(node) {
        result=JOIN_COMMA_EXPR(EXPR_W(node,EXPR_RIGHT),result);
        previous=node;
        node=EXPR_W(node,EXPR_LEFT);
        FREE_EXPR_NODE(previous);
    }
    return result;
}

/* ---- PARSE_INITIALIZER (listing 73DC) ---- */
#include <dos.h>
extern void far pascal ADVANCE_TOKEN(void);
extern unsigned int far pascal PARSE_ASSIGNMENT_EXPR(unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal INIT_DECLARATOR(unsigned int,unsigned int);
extern unsigned int far pascal CREATE_TEMP_SYMBOL(unsigned int,unsigned char);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);

/* Parses the initializer of local variable first of type and returns the
   initialising expression: "(value)" or "= value", a braced scalar, or a
   brace list for an aggregate.  An aggregate list is laid out by
   INIT_DECLARATOR into a temporary static copy (CREATE_TEMP_SYMBOL) that
   is then assigned, or, for a class with constructors (or during inline
   expansion), as the list of member assignments INIT_DECLARATOR queued in
   LOCAL_INIT_EXPR_LIST. */
static unsigned int near pascal PARSE_INITIALIZER(unsigned int first,register unsigned int type)
{
    unsigned int symbol;
    register unsigned int result;

    if(CURRENT_TOKEN==TOK_LPAREN)
        result=PARSE_ASSIGNMENT_EXPR(2);
    else {
        ADVANCE_TOKEN();
        if(CURRENT_TOKEN==TOK_LBRACE || (TYPE_W(type,TYPE_KIND)==TK_ARRAY && (CURRENT_TOKEN==0x34 || (TYPE_B(type,TYPE_ATTRS)&4)))) {
            if((EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&7) && TYPE_W(type,TYPE_KIND)!=TK_UNDEFINED) {
                ADVANCE_TOKEN();
                result=PARSE_ASSIGNMENT_EXPR(7);
                if(CURRENT_TOKEN==TOK_RBRACE)
                    ADVANCE_TOKEN();
                else
                    REPORT_CURRENT_TOKEN(CURRENT_TOKEN==TOK_COMMA?MSG_TOO_MANY_INITIALIZERS:MSG_EXPECTED_230);
            } else if((TYPE_B(type,TYPE_ATTRS)&4) || INLINE_EXPANSION_DEPTH>0) {
                LOCAL_INIT_EXPR_LIST=0;
                INIT_DECLARATOR(first,type);
                return REVERSE_LIST_TO_COMMA(LOCAL_INIT_EXPR_LIST);
            } else {
                symbol=CREATE_TEMP_SYMBOL(type,1);
                LOCAL_INIT_EXPR_LIST=0;
                INIT_DECLARATOR(symbol,type);
                result=MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(first),MAKE_SYMBOL_NODE(symbol));
                return JOIN_COMMA_EXPR(REVERSE_LIST_TO_COMMA(LOCAL_INIT_EXPR_LIST),result);
            }
        } else
            result=PARSE_ASSIGNMENT_EXPR(8);
    }
    return MAKE_BINARY_NODE(5,MAKE_SYMBOL_NODE(first),result);
}

/* ---- GUARD_STATIC_LOCAL_INIT (listing 7501) ---- */
#include <dos.h>
extern unsigned int far pascal CREATE_TEMP_SYMBOL(unsigned int,unsigned char);
extern unsigned int far pascal SELECT_SYMBOL_STREAM(unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern void far pascal EMIT_ZERO_BYTES(unsigned int);
extern void far pascal SET_STREAM(unsigned int);
extern void far pascal C0MARK(unsigned char);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal MAKE_CONDITIONAL_NODE(unsigned int,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal BUILD_DESTRUCTOR_CALL(unsigned int,unsigned int,unsigned int,int);
extern unsigned int far pascal ALLOC_TEMP_ENTRY(void);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern unsigned int far pascal PACK_EXPR_TREE(unsigned int);

/* A static local whose initialisation needs code runs it only the first
   time: builds "flag ? 0 : (flag++, initialisers)" with a hidden int flag
   (a temporary static symbol).  If the type has a destructor, a matching
   "flag ? destructor : 0" is registered on TEMP_DESTRUCTOR_LIST, probably
   to run at program exit. */
static unsigned int near pascal GUARD_STATIC_LOCAL_INIT(unsigned int first,unsigned int type)
{
    unsigned int symbol;
    unsigned int temporary;
    unsigned int saved;
    register unsigned int result;
    register unsigned int link;

    result=REVERSE_LIST_TO_COMMA(LOCAL_INIT_EXPR_LIST);
    symbol=CREATE_TEMP_SYMBOL(INT_TYPE,1);
    saved=SELECT_SYMBOL_STREAM(symbol);
    EMIT_ZERO_BYTES((unsigned int)TYPE_SIZE(INT_TYPE));
    SET_STREAM(saved);
    C0MARK(1);
    result=JOIN_COMMA_EXPR(MAKE_UNARY_NODE(0x2D,MAKE_SYMBOL_NODE(symbol)),result);
    result=MAKE_CONDITIONAL_NODE(0x6B,MAKE_SYMBOL_NODE(symbol),MAKE_INT_CONSTANT(VOID_TYPE,0L),result);
    if(!NO_ERRORS_YET)
        return result;
    temporary=BUILD_DESTRUCTOR_CALL(MAKE_SYMBOL_NODE(first),type,0,2);
    if(temporary==0)
        return result;
    temporary=MAKE_CONDITIONAL_NODE(0x6B,MAKE_SYMBOL_NODE(symbol),temporary,MAKE_INT_CONSTANT(VOID_TYPE,0L));
    DESTRUCTOR_ENTRY_SERIAL++;
    link=ALLOC_TEMP_ENTRY();
    TDTOR_W(link,TDTOR_NEXT)=TEMP_DESTRUCTOR_LIST;
    TDTOR_W(link,TDTOR_SERIAL)=DESTRUCTOR_ENTRY_SERIAL;
    temporary=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(temporary,VOID_TYPE),1);
    TDTOR_W(link,TDTOR_EXPR)=PACK_EXPR_TREE(temporary);
    TEMP_DESTRUCTOR_LIST=link;
    return result;
}

/* ---- PARSE_DECLARATION (listing 7636) ---- */
#include <dos.h>
struct C16Spec { signed char first,second,third; };
#include "BCCREC6.H"
extern unsigned int SCOPE_POOL_SEG; extern unsigned int BCC_TREE_SPECIAL;
extern void far pascal PUSH_SCOPE(unsigned char);
extern void far pascal APPEND_SCOPE_ENTER_BLOCK(void);
extern void far pascal PARSE_DECL_SPECIFIERS(unsigned int,unsigned int far *,unsigned char far *,
    unsigned char far *,unsigned int far *,struct C16Spec far *,unsigned char far *);
extern void far pascal PARSE_DECLARATOR(unsigned int,unsigned int,unsigned int far *,
    unsigned int far *,unsigned int far *,unsigned int far *,struct C16Spec far *,
    struct C16Spec far *);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
extern void far pascal SKIP_TO_SYNC_TOKEN(unsigned int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int);
extern void far pascal DECLARE_MEMBER_ALIAS(unsigned int,unsigned int);
extern void far pascal DECLARE_TYPEDEF(unsigned int,struct C16Spec,unsigned int);
extern void far pascal DECLARE_FUNCTION(unsigned int,unsigned int,unsigned int,unsigned int,
    unsigned int far *,unsigned char far *);
extern void far pascal C0MARK(unsigned char);
extern unsigned int far pascal DECLARE_VARIABLE(unsigned int,unsigned int,unsigned int,unsigned char,struct C16Spec);
extern unsigned int far pascal PARSE_OBJECT_INIT(unsigned int,unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern void far pascal PARSE_DECL_INITIALIZER(unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern void far pascal APPEND_EXPRESSION_BLOCK(unsigned int,struct C77Record6);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal REGISTER_TEMP_DESTRUCTOR(unsigned int,unsigned int,unsigned int);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);


/* Parses a declaration inside a function.  Opens a block scope on the
   first declaration of a block.  nested nonzero (a declaration in a for
   initialiser or similar) returns the initialisation code as an
   expression instead of appending it.  Handles typedefs, function
   declarations, anonymous unions (C++: their members become aliases of a
   hidden object), and variables: auto ones are initialised by code
   (PARSE_INITIALIZER, or PARSE_OBJECT_INIT for class objects with
   constructors) and get destructor entries; statics and externs go through
   PARSE_DECL_INITIALIZER (EXTDECL.C), with GUARD_STATIC_LOCAL_INIT when
   code is needed.  An array of unknown size is declared again after its
   initializer has fixed the size (retry).  Static locals are not allowed
   in functions being expanded inline (INLINE_FUNCTION_STACK). */
unsigned int far pascal PARSE_DECLARATION(unsigned char nested)
{
    unsigned int result;
    unsigned int kind;
    unsigned int type;
    unsigned char created;
    unsigned int decl_type;
    unsigned int name;
    unsigned int scope;
    unsigned int owner;
    unsigned int record;
    unsigned char is_inline;
    unsigned char retry;
    unsigned char needs_init;
    unsigned char defining;
    unsigned char any_defined;
    unsigned char named;
    struct C16Spec spec;
    struct C16Spec decl_spec;
    struct C16Spec scratch;
    unsigned char modifier1;
    unsigned char modifier2;
    struct C77Record6 position;
    unsigned int member;
    register unsigned int token;
    register unsigned int value;

    retry=0;
    result=0;
    if(SCOPE_W(CURRENT_SCOPE,SCOPE_NEST_LEVEL)!=BLOCK_NEST_LEVEL) {
        PUSH_SCOPE(0);
        if(nested)
            SCOPE_W(CURRENT_SCOPE,SCOPE_ENTER_BLOCK)=SCOPE_W(SCOPE_W(CURRENT_SCOPE,SCOPE_PARENT),SCOPE_ENTER_BLOCK);
        else
            APPEND_SCOPE_ENTER_BLOCK();
    }
    position.first=CURRENT_TOKEN_FILE;
    position.second=CURRENT_TOKEN_LINE;
    position.third=CURRENT_TOKEN_LOC_WORD3;
    any_defined=0;
    type=INT_TYPE;
    PARSE_DECL_SPECIFIERS(0,&kind,&modifier1,&modifier2,&type,&spec,&named);
    if(INLINE_FUNCTION_STACK && kind==0x35) {
        REPORT_DIAGNOSTIC(MSG_FUNCTIONS_CONTAINING,(char far *)STR_STATIC_VARIABLES,0L);
        SYM_W(BCC_TREE_SPECIAL,SYM_FUNC_FLAGS)&=~4;
    }
    if(modifier1 || modifier2 ||
       (kind!=0x39 && kind!=0x36 && kind!=0x38 && kind!=0x35 &&
        kind!=0x37 && kind!=0x82))
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,modifier1 ? (char far *)STR_FRIEND :
            modifier2 ? (char far *)STR_VIRTUAL : NAME_TEXT_COPY(TOKEN_NAMES[kind]),0L);
    if(kind==0x82)
        token=0x39;
    else
        token=kind;
    if(!(TYPE_FLAGS[CURRENT_TOKEN]&0x10) && TYPE_W(type,TYPE_KIND)!=TK_ENUM) {
        if(CPP_MODE) {
            if(TYPE_W(type,TYPE_KIND)==TK_UNION && SYM_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME)==0) {
                member=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);
                record=CREATE_LOCAL_TEMP(type);
                while(member!=0) {
                    if((MEMBER_B(member,MEMB_FLAGS)&3)==0)
                        DECLARE_MEMBER_ALIAS(member,record);
                    else
                        REPORT_NAME_DIAGNOSTIC(MSG_CANNOT_DECLARED,MEMBER_W(member,MEMB_NAME));
                    member=MEMBER_W(member,MEMB_NEXT);
                }
            } else if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) {
                if(SYM_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME)==0)
                    REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
                else if(kind==0x36 || kind==0x35)
                    REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,NAME_TEXT_COPY(TOKEN_NAMES[kind]),0L);
            } else
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
        } else if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) {
            if(SYM_W(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),SYM_NAME)==0)
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT_352);
        } else
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
    }
    while(TYPE_FLAGS[CURRENT_TOKEN]&0x10) {
        decl_spec=spec;
        PARSE_DECLARATOR(type,0,&decl_type,&name,&scope,&owner,&decl_spec,&scratch);
        if(name!=0) {
            if(owner!=0)
                REPORT_NAME_DIAGNOSTIC(MSG_IDENTIFIER_CANNOT_HAVE,name);
            if(kind==0x37) {
                if(scope!=0)
                    REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
                else
                    DECLARE_TYPEDEF(decl_type,decl_spec,name);
            } else if(TYPE_W(decl_type,TYPE_KIND)==TK_FUNCTION) {
                if(TYPE_B(decl_type,TYPE_ATTRS)&0x40)
                    REPORT_CURRENT_TOKEN(MSG_PARAMETER_NAMES_ARE);
                if(kind==0x35)
                    REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,TOKEN_NAMES[TOK_STATIC]);
                DECLARE_FUNCTION(decl_type,name,scope,kind,&record,&created);
                C0MARK(1);
            } else if(scope!=0)
                REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
            else {
                if(CPP_MODE && (TYPE_B(decl_type,TYPE_ATTRS)&1) &&
                   (EXPR_FLAGS[TYPE_W(decl_type,TYPE_KIND)]&3) && token==0x39)
                    token=0x35;
                is_inline=kind!=0x36 && (TYPE_B(decl_type,TYPE_ATTRS)&4);
                defining=CURRENT_TOKEN==TOK_ASSIGN || CURRENT_TOKEN==TOK_LPAREN || is_inline;
                position.first=CURRENT_TOKEN_FILE;
                position.second=CURRENT_TOKEN_LINE;
                position.third=CURRENT_TOKEN_LOC_WORD3;
                needs_init=token!=0x36 && token!=0x35;
                any_defined=any_defined || defining;
                if(is_inline && ((EXPR_FLAGS[TYPE_W(decl_type,TYPE_KIND)]&0x40) || CURRENT_TOKEN!=TOK_ASSIGN)) {
                    record=DECLARE_VARIABLE(decl_type,name,token,1,decl_spec);
                    if(needs_init)
                        value=PARSE_OBJECT_INIT(record,decl_type);
                } else {
                    retry=TYPE_SIZE(decl_type)==0L && TYPE_W(decl_type,TYPE_KIND)==TK_ARRAY;
                    record=DECLARE_VARIABLE(decl_type,name,token,defining,decl_spec);
                    if(defining && needs_init)
                        value=PARSE_INITIALIZER(record,decl_type);
                    if(needs_init && retry)
                        record=DECLARE_VARIABLE(decl_type,name,token,defining,decl_spec);
                }
                if(token==0x36 || token==0x35) {
                    if(defining || (CPP_MODE && token==0x35 &&
                                    (TYPE_B(decl_type,TYPE_ATTRS)&8))) {
                        if(token==0x36)
                            REPORT_CURRENT_TOKEN(MSG_EXTERN_VARIABLE_CANNOT);
                        LOCAL_INIT_EXPR_LIST=0;
                        if(defining)
                            PARSE_DECL_INITIALIZER(is_inline,decl_type,record);
                        if(retry)
                            record=DECLARE_VARIABLE(decl_type,name,token,defining,decl_spec);
                        if((SYM_B(record,SYM_STORAGE_CLASS)>>3)==5) {
                            value=REVERSE_LIST_TO_COMMA(LOCAL_INIT_EXPR_LIST);
                            if(!nested) {
                                value=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(value,VOID_TYPE),1);
                                APPEND_EXPRESSION_BLOCK(value,position);
                                SYM_B(record,SYM_FLAGS)&=~4;
                            } else
                                result=JOIN_COMMA_EXPR(result,value);
                        } else if(LOCAL_INIT_EXPR_LIST!=0 || (TYPE_B(decl_type,TYPE_ATTRS)&8)) {
                            value=GUARD_STATIC_LOCAL_INIT(record,decl_type);
                            value=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(value,VOID_TYPE),1);
                            APPEND_EXPRESSION_BLOCK(value,position);
                        }
                    } else if(token==0x35 && CPP_MODE)
                        TEMP_DESTRUCTOR_LIST=REGISTER_TEMP_DESTRUCTOR(MAKE_SYMBOL_NODE(record),decl_type,TEMP_DESTRUCTOR_LIST);
                    else if(token==0x36)
                        C0MARK(1);
                } else {
                    if(defining) {
                        if(!nested) {
                            value=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(value,VOID_TYPE),1);
                            APPEND_EXPRESSION_BLOCK(value,position);
                            SYM_B(record,SYM_FLAGS)&=~4;
                        } else
                            result=JOIN_COMMA_EXPR(result,value);
                    }
                    if(CPP_MODE && (TYPE_B(decl_type,TYPE_ATTRS)&8))
                        SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)=REGISTER_TEMP_DESTRUCTOR(MAKE_SYMBOL_NODE(record),
                            decl_type,SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS));
                }
            }
        } else
            REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
        if(CURRENT_TOKEN==TOK_COMMA) {
            ADVANCE_TOKEN();
            if(!(TYPE_FLAGS[CURRENT_TOKEN]&0x10)) {
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
                SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
            }
        } else if(CURRENT_TOKEN!=TOK_SEMICOLON) {
            REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
            SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
        }
    }
    if(any_defined)
        DECL_INIT_SERIAL++;
    REQUIRE_TOKEN_ELSE_ERROR(7,0x1F);
    return result;
}

/* ---- COPY_NODE_LIST (listing 7DBE) ---- */
#include <dos.h>
extern unsigned int far pascal ALLOC_TEMP_ENTRY(void);
#include "BCCREC6.H"
#define NT(n) (*(struct C77Record6 far *)MK_FP(TEMP_ENTRY_POOL_SEG,(n)))

/* Returns a copy, in the same order, of a list of destructor entries
   (TEMP_ENTRY_POOL_SEG records), so a label or goto can remember which
   objects were alive at that point. */
static unsigned int near pascal COPY_NODE_LIST(unsigned int list)
{
    unsigned int result;
    register unsigned int node;
    register unsigned int reversed;

    reversed=0;
    while(list!=0) {
        node=ALLOC_TEMP_ENTRY();
        NT(node)=NT(list);
        list=TDTOR_W(list,TDTOR_NEXT);
        TDTOR_W(node,TDTOR_NEXT)=reversed;
        reversed=node;
    }
    result=0;
    while(reversed) {
        node=reversed;
        reversed=TDTOR_W(reversed,TDTOR_NEXT);
        TDTOR_W(node,TDTOR_NEXT)=result;
        result=node;
    }
    return result;
}
#undef NT

/* ---- RESOLVE_PENDING_GOTOS (listing 7E26) ---- */
#include <dos.h>
extern unsigned int SCOPE_POOL_SEG;
#include "BCCREC6.H"
extern struct C77Record6 NO_SOURCE_LOCATION;
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern void far pascal APPEND_ANALYZED_EXPRESSION(unsigned int);
extern void far pascal FREE_TEMP_ENTRY(unsigned int);

/* Called when label block key is defined: removes the forward gotos to it
   from PENDING_GOTO_LIST, reporting any that jump past an initialisation.
   In C++, a goto that had to leave objects to destroy jumped to its own
   label (GOTO_TARGET); for each, a stub is placed here that destroys
   those objects and jumps on to the label, with a jump around the stubs. */
static void near pascal RESOLVE_PENDING_GOTOS(unsigned int key,int limit)
{
    unsigned int previous;
    unsigned int removed;
    unsigned char differing;
    unsigned int link;
    unsigned int temporary;
    register unsigned int node;
    register unsigned int current;

    differing=0;
    removed=0;
    previous=0;
    node=PENDING_GOTO_LIST;
    while(node) {
        if(LABEL_W(node,LABEL_BLOCK)==key) {
            if(LABEL_I(node,GOTO_INIT_SERIAL)>limit || LABEL_I(node,GOTO_INIT_SERIAL)<DECL_INIT_SERIAL)
                REPORT_CURRENT_TOKEN(CPP_MODE?MSG_GOTO_BYPASSES:MSG_GOTO_BYPASSES_358);
            current=node;
            node=LABEL_W(node,GOTO_NEXT);
            if(previous==0)
                PENDING_GOTO_LIST=node;
            else
                LABEL_W(previous,GOTO_NEXT)=node;
            LABEL_W(current,GOTO_NEXT)=removed;
            removed=current;
            differing=(differing || LABEL_W(current,GOTO_TARGET)!=key);
        } else {
            previous=node;
            node=LABEL_W(node,GOTO_NEXT);
        }
    }
    if(CPP_MODE) {
        if(differing) {
            APPEND_JUMP_BLOCK(key,NO_SOURCE_LOCATION);
            node=removed;
            while(node) {
                if(LABEL_W(node,GOTO_TARGET)!=key) {
                    APPEND_BLOCK_IF_NONZERO(LABEL_W(node,GOTO_TARGET));
                    temporary=BUILD_TEMP_DESTRUCTORS(LABEL_W(node,GOTO_TEMPS),SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS));
                    APPEND_ANALYZED_EXPRESSION(temporary);
                    APPEND_JUMP_BLOCK(key,NO_SOURCE_LOCATION);
                }
                node=LABEL_W(node,GOTO_NEXT);
            }
        }
        while(removed) {
            current=removed;
            removed=LABEL_W(current,GOTO_NEXT);
            while(LABEL_W(current,GOTO_TEMPS)) {
                link=LABEL_W(current,GOTO_TEMPS);
                LABEL_W(current,GOTO_TEMPS)=TDTOR_W(link,TDTOR_NEXT);
                FREE_TEMP_ENTRY(link);
            }
        }
    }
}

/* ---- CHECK_UNDEFINED_LABELS (listing 7FA8) ---- */
#include <dos.h>
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern void far pascal FREE_TEMP_ENTRY(unsigned int);

/* At the end of a function body: reports labels used but never defined
   and frees the leftover goto records. */
void far pascal CHECK_UNDEFINED_LABELS(void)
{
    unsigned int label;
    unsigned int item;

    for(label=LABEL_LIST_HEAD; label; label=LABEL_W(label,LABEL_NEXT))
        if(!LABEL_B(label,LABEL_DEFINED))
            REPORT_DIAGNOSTIC(MSG_UNDEFINED_LABEL,NAME_TEXT_COPY(LABEL_W(label,LABEL_NAME)),0L);
    if(CPP_MODE) {
        while(PENDING_GOTO_LIST) {
            while(LABEL_W(PENDING_GOTO_LIST,GOTO_TEMPS)) {
                item=LABEL_W(PENDING_GOTO_LIST,GOTO_TEMPS);
                LABEL_W(PENDING_GOTO_LIST,GOTO_TEMPS)=TDTOR_W(item,TDTOR_NEXT);
                FREE_TEMP_ENTRY(item);
            }
            PENDING_GOTO_LIST=LABEL_W(PENDING_GOTO_LIST,GOTO_NEXT);
        }
    }
}

/* ---- PARSE_LABEL (listing 8030) ---- */
#include <dos.h>
extern unsigned int SCOPE_POOL_SEG; extern unsigned int CURRENT_TOKEN_VALUE;
extern unsigned int far pascal ALLOC_LABEL_RECORD(void);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);

/* Defines the label "name:" (labels are found by name in LABEL_LIST_HEAD,
   with LABEL_W(0,2) planted as the search's end marker), records the
   objects alive here (C++), resolves forward gotos and places the label
   block. */
static void near pascal PARSE_LABEL(void)
{
    unsigned int label;

    STMT_NO_GOTO_OR_LABEL_FLAG=0;
    LABEL_W(0,2)=CURRENT_TOKEN_VALUE;
    for(label=LABEL_LIST_HEAD; LABEL_W(label,LABEL_NAME)!=CURRENT_TOKEN_VALUE; label=LABEL_W(label,LABEL_NEXT))
        ;
    if(!label) {
        label=ALLOC_LABEL_RECORD();
        LABEL_W(label,LABEL_NAME)=CURRENT_TOKEN_VALUE;
        LABEL_W(label,LABEL_BLOCK)=NEW_LABEL_IF_ENABLED();
    }
    else if(LABEL_B(label,LABEL_DEFINED)!=0)
        REPORT_CURRENT_TOKEN(MSG_MULTIPLE_DECLARATION);
    LABEL_B(label,LABEL_DEFINED)=1;
    LABEL_W(label,LABEL_SERIAL_HIGH)=0x7FFF;
    if(CPP_MODE)
        LABEL_W(label,LABEL_TEMPS)=COPY_NODE_LIST(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS));
    RESOLVE_PENDING_GOTOS(LABEL_W(label,LABEL_BLOCK),LABEL_W(label,LABEL_SERIAL_HIGH));
    LABEL_W(label,LABEL_SERIAL_LOW)=DECL_INIT_SERIAL;
    APPEND_BLOCK_IF_NONZERO(LABEL_W(label,LABEL_BLOCK));
    ADVANCE_TOKEN();
    REQUIRE_TOKEN_ELSE_ERROR(0x21,0xC8);
}

/* ---- CHECK_CASE_BYPASS (listing 80FF) ---- */
#include <dos.h>
extern unsigned int SCOPE_POOL_SEG;
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);

/* At a case or default label: reports a jump into the switch body past an
   initialisation (or, in C++, past the construction of an object still
   alive), and destroys the objects of the previous case section. */
static void near pascal CHECK_CASE_BYPASS(void)
{
    if(!CODE_UNREACHABLE && CURRENT_SWITCH.outer!=DECL_INIT_SERIAL)
        REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_CASE_BYPASSES : MSG_CASE_BYPASSES_382);
    else if(CPP_MODE && !CODE_UNREACHABLE && SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)!=CURRENT_SWITCH.scope)
        REPORT_CURRENT_TOKEN(MSG_CASE_BYPASSES);
    if(CPP_MODE)
        RELEASE_SCOPE_OBJECTS(CURRENT_SWITCH.scope);
    CURRENT_SWITCH.outer=DECL_INIT_SERIAL;
    CURRENT_SWITCH.has_default=0;
}

/* ---- PARSE_CASE (listing 816E) ---- */
#include <dos.h>
struct Range { long minimum,maximum; };

extern struct Range TYPE_RANGE_TABLE[];
extern long (far pascal *TOKEN_CONVERT)(long,int);
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal PARSE_CONSTANT_EXPR_VALUE(unsigned int,long far *);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);

/* "case constant:": the value is converted to the selector's type, must be
   in its range, and is inserted into the sorted case list
   CURRENT_SWITCH.cases with a new label placed here. */
static void near pascal PARSE_CASE(void)
{
    unsigned int prev;
    long value;
    unsigned int entry;
    unsigned int cur;

    if(CURRENT_SWITCH.active)
        CHECK_CASE_BYPASS();
    ADVANCE_TOKEN();
    PARSE_CONSTANT_EXPR_VALUE(0x21,&value);
    if(EXPR_FLAGS[CURRENT_SWITCH.kind]&0x20)
        value=(*TOKEN_CONVERT)(value,CURRENT_SWITCH.kind);
    if(TYPE_RANGE_TABLE[CURRENT_SWITCH.kind].minimum>value || TYPE_RANGE_TABLE[CURRENT_SWITCH.kind].maximum<value)
        REPORT_CURRENT_TOKEN(MSG_CASE_CONSTANT_OUT);
    entry=POOL_ALLOC_REUSE(&CASE_ENTRY_POOL_SEG,8);
    SWCASE_L(entry,SWCASE_VALUE)=value;
    SWCASE_W(entry,SWCASE_TARGET)=NEW_LABEL_IF_ENABLED();
    APPEND_BLOCK_IF_NONZERO(SWCASE_W(entry,SWCASE_TARGET));
    for(cur=CURRENT_SWITCH.cases,prev=0; cur && SWCASE_L(cur,SWCASE_VALUE)<value; cur=SWCASE_W(cur,SWCASE_NEXT))
        prev=cur;
    if(cur && SWCASE_L(cur,SWCASE_VALUE)==value)
        REPORT_CURRENT_TOKEN(MSG_DUPLICATE_CASE);
    if(prev==0) {
        SWCASE_W(entry,SWCASE_NEXT)=CURRENT_SWITCH.cases;
        CURRENT_SWITCH.cases=entry;
    }
    else {
        SWCASE_W(entry,SWCASE_NEXT)=SWCASE_W(prev,SWCASE_NEXT);
        SWCASE_W(prev,SWCASE_NEXT)=entry;
    }
    REQUIRE_TOKEN_ELSE_ERROR(0x21,0x1B);
}

/* ---- PARSE_DEFAULT (listing 82BE) ---- */

extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);

/* "default:": places the default label (one per switch). */
static void near pascal PARSE_DEFAULT(void)
{
    if(CURRENT_SWITCH.active) {
        if(CURRENT_SWITCH.default_label)
            REPORT_CURRENT_TOKEN(MSG_TOO_MANY_DEFAULT_CASES);
        CHECK_CASE_BYPASS();
        CURRENT_SWITCH.default_label=NEW_LABEL_IF_ENABLED();
        APPEND_BLOCK_IF_NONZERO(CURRENT_SWITCH.default_label);
    }
    ADVANCE_TOKEN();
    REQUIRE_TOKEN_ELSE_ERROR(0x21,0x17);
}

/* ---- PARSE_LABELS (listing 8302) ---- */
extern unsigned int TOKEN_TYPE;
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal PEEK_TOKEN(void);
extern void far pascal ADVANCE_TOKEN(void);

/* Parses any labels, case and default prefixes in front of a statement;
   afterwards the point is reachable again. */
static void near pascal PARSE_LABELS(void)
{
    unsigned char reported;

    reported=0;
    while((CURRENT_TOKEN==TOK_IDENT && (PEEK_TOKEN(),TOKEN_TYPE)==0x21) || CURRENT_TOKEN==TOK_CASE || CURRENT_TOKEN==TOK_DEFAULT || CURRENT_TOKEN==TOK_COLON) {
        if(CURRENT_TOKEN==TOK_COLON) {
            REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_FOUND);
            ADVANCE_TOKEN();
        }
        else if(CURRENT_TOKEN==TOK_IDENT)
            PARSE_LABEL();
        else {
            if(!CURRENT_SWITCH.active && !reported) {
                reported=1;
                REPORT_CURRENT_TOKEN(CURRENT_TOKEN==TOK_CASE ? MSG_CASE_OUTSIDE_SWITCH : MSG_DEFAULT_OUTSIDE_SWITCH);
            }
            if(CURRENT_TOKEN==TOK_CASE)
                PARSE_CASE();
            else
                PARSE_DEFAULT();
        }
    }
    CODE_UNREACHABLE=0;
}

/* ---- PARSE_GOTO (listing 83A0) ---- */
#include <dos.h>
#include "BCCREC6.H"
extern unsigned int SCOPE_POOL_SEG; extern unsigned int CURRENT_TOKEN_VALUE;
extern unsigned int far pascal ALLOC_LABEL_RECORD(void);
extern unsigned int far pascal ALLOC_JUMP_RECORD(void);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_ANALYZED_EXPRESSION(unsigned int);
extern unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern void far pascal ADVANCE_TOKEN(void);

/* goto name;  A backward goto to a defined label checks for jumps past
   initialisations and (C++) destroys the objects that the jump leaves
   behind.  A forward goto is recorded in PENDING_GOTO_LIST with the
   objects alive now, to be finished by RESOLVE_PENDING_GOTOS when the
   label appears. */
static void near pascal PARSE_GOTO(void)
{
    unsigned int target;
    struct C77Record6 where;
    unsigned int label;
    unsigned int jump;

    where.first=CURRENT_TOKEN_FILE;
    where.second=CURRENT_TOKEN_LINE;
    where.third=CURRENT_TOKEN_LOC_WORD3;
    ADVANCE_TOKEN();
    STMT_NO_GOTO_OR_LABEL_FLAG=0;
    if(CURRENT_TOKEN!=TOK_IDENT) {
        REPORT_CURRENT_TOKEN(MSG_GOTO_STATEMENT_MISSING);
        IN_ERROR_RECOVERY=1;
    }
    else {
        IN_ERROR_RECOVERY=0;
        LABEL_W(0,2)=CURRENT_TOKEN_VALUE;
        for(label=LABEL_LIST_HEAD; LABEL_W(label,LABEL_NAME)!=CURRENT_TOKEN_VALUE; label=LABEL_W(label,LABEL_NEXT))
            ;
        if(!label) {
            label=ALLOC_LABEL_RECORD();
            target=NEW_LABEL_IF_ENABLED();
            LABEL_W(label,LABEL_NAME)=CURRENT_TOKEN_VALUE;
            LABEL_W(label,LABEL_BLOCK)=target;
            LABEL_W(label,LABEL_TEMPS)=0;
            LABEL_W(label,LABEL_SERIAL_LOW)=0;
            LABEL_W(label,LABEL_SERIAL_HIGH)=0x7FFF;
        }
        if(!LABEL_B(label,LABEL_DEFINED)) {
            jump=ALLOC_JUMP_RECORD();
            LABEL_W(jump,LABEL_BLOCK)=LABEL_W(label,LABEL_BLOCK);
            target=LABEL_W(jump,LABEL_BLOCK);
            LABEL_W(jump,GOTO_INIT_SERIAL)=DECL_INIT_SERIAL;
            if(CPP_MODE) {
                LABEL_W(jump,GOTO_TEMPS)=COPY_NODE_LIST(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS));
                if(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)!=SCOPE_W(GLOBAL_SCOPE,SCOPE_TEMPS))
                    target=NEW_LABEL_IF_ENABLED();
            }
            LABEL_W(jump,GOTO_TARGET)=target;
        }
        else {
            target=LABEL_W(label,LABEL_BLOCK);
            if(LABEL_I(label,LABEL_SERIAL_HIGH)<DECL_INIT_SERIAL || LABEL_I(label,LABEL_SERIAL_LOW)>DECL_INIT_SERIAL)
                REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_GOTO_BYPASSES : MSG_GOTO_BYPASSES_358);
            if(CPP_MODE)
                APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),LABEL_W(label,LABEL_TEMPS)));
        }
        APPEND_JUMP_BLOCK(target,where);
    }
    ADVANCE_TOKEN();
    if(CURRENT_TOKEN==TOK_SEMICOLON)
        ADVANCE_TOKEN();
    else
        REPORT_DIAGNOSTIC(MSG_STATEMENT_MISSING_64,STR_GOTO,0L);
    CODE_UNREACHABLE=1;
}

/* ---- PARSE_EXPRESSION_STATEMENT (listing 8559) ---- */
#include <dos.h>
#include "BCCREC6.H"
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned char far pascal IS_SIDE_EFFECT_FREE(unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern void far pascal APPEND_EXPRESSION_BLOCK(unsigned int,struct C77Record6);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);

/* An expression statement: warns "code has no effect" when the value is
   unused and the expression has no side effects, then appends it. */
static void near pascal PARSE_EXPRESSION_STATEMENT(void)
{
    struct C77Record6 where;
    unsigned int expr;

    IN_ERROR_RECOVERY=0;
    where.first=CURRENT_TOKEN_FILE;
    where.second=CURRENT_TOKEN_LINE;
    where.third=CURRENT_TOKEN_LOC_WORD3;
    expr=ANALYZE_AND_DECAY(PARSE_COMMA_EXPRESSION(7),VOID_TYPE);
    if(expr && IS_SIDE_EFFECT_FREE(expr) && EXPR_W(expr,EXPR_TYPE)!=VOID_TYPE)
        REPORT_CURRENT_TOKEN(MSG_CODE_HAS_NO_EFFECT);
    expr=SIMPLIFY_EXPRESSION(expr,1);
    APPEND_EXPRESSION_BLOCK(expr,where);
    REQUIRE_TOKEN_ELSE_ERROR(7,0xEA);
}

/* ---- PARSE_IF_STATEMENT (listing 85E3) ---- */
static void near pascal PARSE_STATEMENT_CPP(unsigned char flag);
#include <dos.h>
#include "BCCREC6.H"
extern unsigned int SCOPE_POOL_SEG;
extern void far pascal EXPECT_TOKEN_ELSE_REPORT(unsigned int,unsigned int,char far *);
extern unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int);
extern unsigned int far pascal APPEND_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern unsigned int far pascal CONSTANT_TRUTH_VALUE(unsigned int);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_JUMP_IF_FALSE_BLOCK(unsigned int,unsigned int,struct C77Record6);
extern void far pascal ADVANCE_TOKEN(void);

/* if (condition) statement [else statement].  A constant condition makes
   the branch not taken unreachable (so it gets the warning).  The point
   after the if is unreachable only if both branches end unreachable. */
static void near pascal PARSE_IF_STATEMENT(void)
{
    unsigned char saved_flag;
    unsigned int end_label;
    unsigned int else_label;
    struct C77Record6 where;
    unsigned int truth;
    unsigned char then_flag;
    register unsigned int scope;
    register unsigned int expr;

    IN_ERROR_RECOVERY=0;
    STATEMENT_NEST_DEPTH++;
    where.first=CURRENT_TOKEN_FILE;
    where.second=CURRENT_TOKEN_LINE;
    where.third=CURRENT_TOKEN_LOC_WORD3;
    ADVANCE_TOKEN();
    EXPECT_TOKEN_ELSE_REPORT(1,0x3E,STR_IF);
    if(CPP_MODE)
        scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    expr=CHECK_CONDITION_EXPR(PARSE_COMMA_EXPRESSION(2));
    if(CPP_MODE)
        expr=APPEND_TEMP_DESTRUCTORS(expr,scope);
    truth=CONSTANT_TRUTH_VALUE(expr);
    saved_flag=STMT_NO_GOTO_OR_LABEL_FLAG;
    STMT_NO_GOTO_OR_LABEL_FLAG=LOOP_NEST_FACTOR==1;
    if(CPP_MODE)
        scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    end_label=NEW_LABEL_IF_ENABLED();
    APPEND_JUMP_IF_FALSE_BLOCK(expr,end_label,where);
    EXPECT_TOKEN_ELSE_REPORT(2,0x3F,STR_IF);
    if(truth==0)
        CODE_UNREACHABLE=1;
    PARSE_STATEMENT_CPP(0);
    then_flag=CODE_UNREACHABLE;
    if(CPP_MODE)
        RELEASE_SCOPE_OBJECTS(scope);
    CODE_UNREACHABLE=0;
    if(CURRENT_TOKEN==TOK_ELSE) {
        else_label=NEW_LABEL_IF_ENABLED();
        APPEND_JUMP_BLOCK(else_label,NO_SOURCE_LOCATION);
        APPEND_BLOCK_IF_NONZERO(end_label);
        end_label=else_label;
        ADVANCE_TOKEN();
        if(CPP_MODE)
            scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
        if(truth==1)
            CODE_UNREACHABLE=1;
        PARSE_STATEMENT_CPP(0);
        if(CPP_MODE)
            RELEASE_SCOPE_OBJECTS(scope);
    }
    CODE_UNREACHABLE=CODE_UNREACHABLE && then_flag;
    APPEND_BLOCK_IF_NONZERO(end_label);
    STMT_NO_GOTO_OR_LABEL_FLAG=saved_flag;
    STATEMENT_NEST_DEPTH--;
}

/* ---- REPORT_MISPLACED_ELSE (listing 8772) ---- */
static void near pascal PARSE_STATEMENT_CPP(unsigned char flag);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal ADVANCE_TOKEN(void);

/* An else without an if: reports it and parses the statement after it. */
static void near pascal REPORT_MISPLACED_ELSE(void)
{
    REPORT_CURRENT_TOKEN(MSG_MISPLACED_ELSE_127);
    ADVANCE_TOKEN();
    PARSE_STATEMENT_CPP(0);
}

/* ---- PARSE_SWITCH (listing 878D) ---- */
static void near pascal PARSE_STATEMENT_CPP(unsigned char flag);
#include <dos.h>
#include "BCCREC6.H"
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal EXPECT_TOKEN_ELSE_REPORT(unsigned int,unsigned int,char far *);
extern unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int);
extern unsigned int far pascal APPEND_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern unsigned int far pascal APPEND_SWITCH_BLOCK(unsigned int,struct C77Record6);
extern void far pascal SET_SWITCH_INFO_IF_ENABLED(unsigned int,unsigned int,unsigned int);

/* switch (selector) statement.  An enum selector uses its base type; small
   types are widened to int.  The body is parsed with a fresh
   CURRENT_SWITCH; afterwards a default label is added if there was none,
   and the cases and default are attached to the switch block. */
static void near pascal PARSE_SWITCH(void)
{
    unsigned char saved_no_goto;
    unsigned int saved_enclosing_kind;
    unsigned int body;
    struct C77Record6 location;
    unsigned int scope;
    struct SwitchState saved;
    unsigned int expr;

    IN_ERROR_RECOVERY=0;
    ++STATEMENT_NEST_DEPTH;
    location.first=CURRENT_TOKEN_FILE;
    location.second=CURRENT_TOKEN_LINE;
    location.third=CURRENT_TOKEN_LOC_WORD3;
    ADVANCE_TOKEN();
    EXPECT_TOKEN_ELSE_REPORT(1,0x3E,STR_SWITCH);
    if(CPP_MODE)
        scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    expr=ANALYZE_AND_DECAY(PARSE_COMMA_EXPRESSION(2),INT_TYPE);
    if(CPP_MODE)
        expr=APPEND_TEMP_DESTRUCTORS(expr,scope);
    if(expr && EXPR_W(expr,EXPR_OP)) {
        if(TYPE_I(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)==TK_ENUM)
            EXPR_W(expr,EXPR_TYPE)=TAG_W(TYPE_I(EXPR_W(expr,EXPR_TYPE),TYPE_TAG_BODY),TAG_ENUM_BASE);
        if(TYPE_I(EXPR_W(expr,EXPR_TYPE),TYPE_KIND)<TK_SHORT)
            expr=ANALYZE_AND_DECAY(MAKE_CAST_NODE(INT_TYPE,expr),INT_TYPE);
    }
    saved=CURRENT_SWITCH;
    CURRENT_SWITCH.active=1;
    CURRENT_SWITCH.cases=0;
    CURRENT_SWITCH.default_label=0;
    CURRENT_SWITCH.outer=DECL_INIT_SERIAL;
    CURRENT_SWITCH.has_default=0;
    CURRENT_SWITCH.no_fall=0;
    CURRENT_SWITCH.depth=STATEMENT_NEST_DEPTH;
    if(CPP_MODE)
        CURRENT_SWITCH.scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    CURRENT_SWITCH.break_label=NEW_LABEL_IF_ENABLED();
    expr=CHECK_SWITCH_SELECTOR(expr);
    CURRENT_SWITCH.kind=TYPE_I(EXPR_W(expr,EXPR_TYPE),TYPE_KIND);
    if(CURRENT_SWITCH.kind==0x15)
        CURRENT_SWITCH.kind=TYPE_I(TAG_W(TYPE_I(EXPR_W(expr,EXPR_TYPE),TYPE_TAG_BODY),TAG_ENUM_BASE),TYPE_KIND);
    saved_no_goto=STMT_NO_GOTO_OR_LABEL_FLAG;
    STMT_NO_GOTO_OR_LABEL_FLAG=LOOP_NEST_FACTOR==1;
    body=APPEND_SWITCH_BLOCK(expr,location);
    EXPECT_TOKEN_ELSE_REPORT(2,0x3F,STR_SWITCH);
    saved_enclosing_kind=ENCLOSING_STATEMENT_KIND;
    ENCLOSING_STATEMENT_KIND=1;
    CODE_UNREACHABLE=1;
    PARSE_STATEMENT_CPP(0);
    if(CURRENT_SWITCH.no_fall)
        CODE_UNREACHABLE=0;
    if(CURRENT_SWITCH.default_label==0) {
        CODE_UNREACHABLE=0;
        CURRENT_SWITCH.default_label=NEW_LABEL_IF_ENABLED();
        APPEND_BLOCK_IF_NONZERO(CURRENT_SWITCH.default_label);
    }
    SET_SWITCH_INFO_IF_ENABLED(body,CURRENT_SWITCH.default_label,CURRENT_SWITCH.cases);
    APPEND_BLOCK_IF_NONZERO(CURRENT_SWITCH.break_label);
    CURRENT_SWITCH=saved;
    ENCLOSING_STATEMENT_KIND=saved_enclosing_kind;
    STMT_NO_GOTO_OR_LABEL_FLAG=saved_no_goto;
    --STATEMENT_NEST_DEPTH;
}

/* ---- PARSE_WHILE (listing 89C0) ---- */
static void near pascal PARSE_STATEMENT_CPP(unsigned char flag);
#include <dos.h>
#include "BCCREC6.H"
/* 9-byte loop context at DS:5EFD (saved and restored whole). */
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal EXPECT_TOKEN_ELSE_REPORT(unsigned int,unsigned int,char far *);
extern unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int);
extern unsigned int far pascal APPEND_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern unsigned int far pascal CONSTANT_TRUTH_VALUE(unsigned int);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_BLOCK_AND_MARK(unsigned int);
extern unsigned int far pascal MAKE_JUMP_IF_TRUE_BLOCK(unsigned int,unsigned int,struct C77Record6);

/* while (condition) statement.  Layout: a jump to the test (unless always
   true), top: body, continue label: the test as a branch back to top
   (or a plain jump if always true), break label.  An always-false loop
   body is unreachable. */
static void near pascal PARSE_WHILE(void)
{
    unsigned int saved_enclosing_kind;
    struct LoopState saved;
    struct C77Record6 location;
    unsigned int exit_jump;
    unsigned int top;
    unsigned int scope;
    unsigned int expr;
    unsigned int kind;

    IN_ERROR_RECOVERY=0;
    ++STATEMENT_NEST_DEPTH;
    location.first=CURRENT_TOKEN_FILE;
    location.second=CURRENT_TOKEN_LINE;
    location.third=CURRENT_TOKEN_LOC_WORD3;
    LOOP_NEST_FACTOR*=3;
    saved_enclosing_kind=ENCLOSING_STATEMENT_KIND;
    ENCLOSING_STATEMENT_KIND=2;
    saved=LOOP_CONTEXT;
    LOOP_CONTEXT.break_label=NEW_LABEL_IF_ENABLED();
    LOOP_CONTEXT.continue_label=NEW_LABEL_IF_ENABLED();
    LOOP_CONTEXT.continued=0;
    top=NEW_LABEL_IF_ENABLED();
    ADVANCE_TOKEN();
    EXPECT_TOKEN_ELSE_REPORT(1,0x3E,STR_WHILE);
    if(CPP_MODE)
        scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    expr=CHECK_CONDITION_EXPR(PARSE_COMMA_EXPRESSION(2));
    if(CPP_MODE) {
        expr=APPEND_TEMP_DESTRUCTORS(expr,scope);
        LOOP_CONTEXT.break_scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
        LOOP_CONTEXT.scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    }
    kind=CONSTANT_TRUTH_VALUE(expr);
    exit_jump=kind==2 ? MAKE_JUMP_IF_TRUE_BLOCK(expr,top,location) : 0;
    if(kind!=1)
        APPEND_JUMP_BLOCK(LOOP_CONTEXT.continue_label,NO_SOURCE_LOCATION);
    if(kind)
        APPEND_BLOCK_AND_MARK(top);
    EXPECT_TOKEN_ELSE_REPORT(2,0x3F,STR_WHILE);
    if(!kind)
        CODE_UNREACHABLE=1;
    PARSE_STATEMENT_CPP(0);
    CODE_UNREACHABLE=0;
    if(CPP_MODE)
        RELEASE_SCOPE_OBJECTS(LOOP_CONTEXT.break_scope);
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTEXT.continue_label);
    switch(kind) {
    case 1:
        APPEND_JUMP_BLOCK(top,location);
        CODE_UNREACHABLE=!LOOP_CONTEXT.continued;
        break;
    case 2:
        APPEND_BLOCK_IF_NONZERO(exit_jump);
        break;
    }
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTEXT.break_label);
    LOOP_CONTEXT=saved;
    ENCLOSING_STATEMENT_KIND=saved_enclosing_kind;
    LOOP_NEST_FACTOR/=3;
    --STATEMENT_NEST_DEPTH;
}

/* ---- PARSE_DO (listing 8B90) ---- */
static void near pascal PARSE_STATEMENT_CPP(unsigned char flag);
#include <dos.h>
#include "BCCREC6.H"
/* 9-byte loop context at DS:5EFD (saved and restored whole). */

extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal EXPECT_TOKEN_ELSE_REPORT(unsigned int,unsigned int,char far *);
extern unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int);
extern unsigned int far pascal APPEND_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern unsigned int far pascal CONSTANT_TRUTH_VALUE(unsigned int);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern void far pascal APPEND_BLOCK_AND_MARK(unsigned int);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_JUMP_IF_TRUE_BLOCK(unsigned int,unsigned int,struct C77Record6);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);

/* do statement while (condition);  Layout: top: body, continue label: the
   test branching back to top, break label. */
static void near pascal PARSE_DO(void)
{
    unsigned int saved_enclosing_kind;
    struct LoopState saved;
    struct C77Record6 location;
    unsigned int scope;
    unsigned int expr;
    unsigned int top;

    IN_ERROR_RECOVERY=0;
    ++STATEMENT_NEST_DEPTH;
    saved_enclosing_kind=ENCLOSING_STATEMENT_KIND;
    ENCLOSING_STATEMENT_KIND=2;
    LOOP_NEST_FACTOR*=3;
    saved=LOOP_CONTEXT;
    LOOP_CONTEXT.break_label=NEW_LABEL_IF_ENABLED();
    LOOP_CONTEXT.continue_label=NEW_LABEL_IF_ENABLED();
    LOOP_CONTEXT.continued=0;
    if(CPP_MODE) {
        LOOP_CONTEXT.break_scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
        LOOP_CONTEXT.scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    }
    top=NEW_LABEL_IF_ENABLED();
    APPEND_BLOCK_AND_MARK(top);
    ADVANCE_TOKEN();
    PARSE_STATEMENT_CPP(0);
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTEXT.continue_label);
    if(CPP_MODE)
        RELEASE_SCOPE_OBJECTS(LOOP_CONTEXT.break_scope);
    if(CURRENT_TOKEN==TOK_WHILE) {
        location.first=CURRENT_TOKEN_FILE;
        location.second=CURRENT_TOKEN_LINE;
        location.third=CURRENT_TOKEN_LOC_WORD3;
        ADVANCE_TOKEN();
        EXPECT_TOKEN_ELSE_REPORT(1,0x3E,STR_DO_WHILE);
        if(CPP_MODE)
            scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
        expr=CHECK_CONDITION_EXPR(PARSE_COMMA_EXPRESSION(2));
        if(CPP_MODE)
            expr=APPEND_TEMP_DESTRUCTORS(expr,scope);
        switch(CONSTANT_TRUTH_VALUE(expr)) {
        case 1:
            APPEND_JUMP_BLOCK(top,location);
            CODE_UNREACHABLE=!LOOP_CONTEXT.continued;
            break;
        case 2:
            APPEND_JUMP_IF_TRUE_BLOCK(expr,top,location);
            break;
        }
        EXPECT_TOKEN_ELSE_REPORT(2,0x3F,STR_DO_WHILE);
    } else {
        REPORT_CURRENT_TOKEN(MSG_DO_STATEMENT_MUST_HAVE);
        IN_ERROR_RECOVERY=1;
    }
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTEXT.break_label);
    if(CURRENT_TOKEN==TOK_SEMICOLON)
        ADVANCE_TOKEN();
    else
        REPORT_DIAGNOSTIC(MSG_STATEMENT_MISSING_64,STR_DO_WHILE,0L);
    LOOP_CONTEXT=saved;
    LOOP_NEST_FACTOR/=3;
    ENCLOSING_STATEMENT_KIND=saved_enclosing_kind;
    --STATEMENT_NEST_DEPTH;
}

/* ---- PARSE_FOR (listing 8D5C) ---- */
static void near pascal PARSE_STATEMENT_CPP(unsigned char flag);
#include <dos.h>
#include "BCCREC6.H"
/* 9-byte loop context at DS:5EFD (saved and restored whole). */

extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal EXPECT_TOKEN_ELSE_REPORT(unsigned int,unsigned int,char far *);
extern unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int);
extern unsigned int far pascal APPEND_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern unsigned int far pascal CONSTANT_TRUTH_VALUE(unsigned int);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_BLOCK_AND_MARK(unsigned int);
extern unsigned int CURRENT_TOKEN_RECORD;
extern unsigned int far pascal MAKE_JUMP_IF_TRUE_BLOCK(unsigned int,unsigned int,struct C77Record6);
extern unsigned int far pascal MAKE_EXPRESSION_BLOCK(unsigned int,struct C77Record6);
extern unsigned char far pascal TOKEN_IS_TYPE_START(void far *);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned char far pascal IS_SIDE_EFFECT_FREE(unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);

/* for (init; condition; step) statement.  In C++ init may be a
   declaration.  Layout as for while, with the step block placed after the
   continue label.  token is the statement's declaration permission flag,
   passed on unused here. */
static void near pascal PARSE_FOR(unsigned char token)
{
    unsigned int saved_enclosing_kind;
    unsigned int exit_jump;
    unsigned int step;
    struct LoopState saved;
    unsigned int top;
    unsigned int next;
    struct C77Record6 location;
    unsigned int scope;
    unsigned int expr;
    unsigned int kind;

    IN_ERROR_RECOVERY=0;
    ++STATEMENT_NEST_DEPTH;
    ADVANCE_TOKEN();
    EXPECT_TOKEN_ELSE_REPORT(1,0x3E,STR_FOR);
    saved=LOOP_CONTEXT;
    LOOP_CONTEXT.break_label=NEW_LABEL_IF_ENABLED();
    LOOP_CONTEXT.continue_label=NEW_LABEL_IF_ENABLED();
    LOOP_CONTEXT.continued=0;
    if(CURRENT_TOKEN==TOK_SEMICOLON)
        ADVANCE_TOKEN();
    else if(CPP_MODE && TOKEN_IS_TYPE_START(&CURRENT_TOKEN_RECORD) && IS_DECLARATION_AHEAD()) {
        IN_ERROR_RECOVERY=0;
        PARSE_DECLARATION(0);
    } else
        PARSE_EXPRESSION_STATEMENT();
    LOOP_NEST_FACTOR*=3;
    location.first=CURRENT_TOKEN_FILE;
    location.second=CURRENT_TOKEN_LINE;
    location.third=CURRENT_TOKEN_LOC_WORD3;
    if(CPP_MODE)
        scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    expr=CURRENT_TOKEN==TOK_SEMICOLON ? 0 : CHECK_CONDITION_EXPR(PARSE_COMMA_EXPRESSION(2));
    if(CPP_MODE)
        expr=APPEND_TEMP_DESTRUCTORS(expr,scope);
    top=NEW_LABEL_IF_ENABLED();
    kind=expr==0 ? 1 : CONSTANT_TRUTH_VALUE(expr);
    exit_jump=kind==2 ? MAKE_JUMP_IF_TRUE_BLOCK(expr,top,location) : 0;
    if(CURRENT_TOKEN==TOK_SEMICOLON)
        ADVANCE_TOKEN();
    else
        REPORT_DIAGNOSTIC(MSG_STATEMENT_MISSING_64,STR_FOR,0L);
    location.first=CURRENT_TOKEN_FILE;
    location.second=CURRENT_TOKEN_LINE;
    location.third=CURRENT_TOKEN_LOC_WORD3;
    if(CPP_MODE)
        scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    expr=CURRENT_TOKEN==TOK_RPAREN ? 0 : ANALYZE_AND_DECAY(PARSE_COMMA_EXPRESSION(2),VOID_TYPE);
    if(CPP_MODE)
        expr=APPEND_TEMP_DESTRUCTORS(expr,scope);
    if(expr && IS_SIDE_EFFECT_FREE(expr) && EXPR_W(expr,EXPR_TYPE)!=VOID_TYPE)
        REPORT_CURRENT_TOKEN(MSG_CODE_HAS_NO_EFFECT);
    expr=SIMPLIFY_EXPRESSION(expr,1);
    step=expr==0 ? 0 : MAKE_EXPRESSION_BLOCK(expr,location);
    EXPECT_TOKEN_ELSE_REPORT(2,0x3F,STR_FOR);
    saved_enclosing_kind=ENCLOSING_STATEMENT_KIND;
    ENCLOSING_STATEMENT_KIND=2;
    next=NEW_LABEL_IF_ENABLED();
    if(kind!=1)
        APPEND_JUMP_BLOCK(next,NO_SOURCE_LOCATION);
    if(kind)
        APPEND_BLOCK_AND_MARK(top);
    if(!kind)
        CODE_UNREACHABLE=1;
    if(CPP_MODE) {
        LOOP_CONTEXT.scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
        LOOP_CONTEXT.break_scope=SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS);
    }
    PARSE_STATEMENT_CPP(0);
    CODE_UNREACHABLE=0;
    if(CPP_MODE)
        RELEASE_SCOPE_OBJECTS(LOOP_CONTEXT.break_scope);
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTEXT.continue_label);
    APPEND_BLOCK_IF_NONZERO(step);
    APPEND_BLOCK_IF_NONZERO(next);
    switch(kind) {
    case 1:
        APPEND_JUMP_BLOCK(top,NO_SOURCE_LOCATION);
        CODE_UNREACHABLE=!LOOP_CONTEXT.continued;
        break;
    case 2:
        APPEND_BLOCK_IF_NONZERO(exit_jump);
        break;
    }
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTEXT.break_label);
    LOOP_CONTEXT=saved;
    LOOP_NEST_FACTOR/=3;
    ENCLOSING_STATEMENT_KIND=saved_enclosing_kind;
    --STATEMENT_NEST_DEPTH;
}

/* ---- PARSE_CONTINUE (listing 9065) ---- */
#include <dos.h>
#include "BCCREC6.H"
extern unsigned int SCOPE_POOL_SEG;

extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern void far pascal APPEND_ANALYZED_EXPRESSION(unsigned int);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);

/* continue;  Destroys the objects of the scopes being left (C++) and jumps
   to the loop's continue label; outside a loop it is an error. */
static void near pascal PARSE_CONTINUE(void)
{
    if(LOOP_NEST_FACTOR==1)
        REPORT_CURRENT_TOKEN(MSG_MISPLACED_CONTINUE);
    else
        IN_ERROR_RECOVERY=0;
    if(CPP_MODE & !CODE_UNREACHABLE)
        APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),LOOP_CONTEXT.break_scope));
    APPEND_JUMP_BLOCK(LOOP_CONTEXT.continue_label,NO_SOURCE_LOCATION);
    CODE_UNREACHABLE=1;
    ADVANCE_TOKEN();
    REQUIRE_TOKEN_ELSE_ERROR(7,0xEA);
}

/* ---- PARSE_BREAK (listing 90DF) ---- */
#include <dos.h>
#include "BCCREC6.H"
extern unsigned int SCOPE_POOL_SEG;


extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern void far pascal APPEND_ANALYZED_EXPRESSION(unsigned int);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);

/* break;  Jumps to the break label of the innermost loop or switch
   (ENCLOSING_STATEMENT_KIND), destroying the objects being left first. */
static void near pascal PARSE_BREAK(void)
{
    if(ENCLOSING_STATEMENT_KIND==2) {
        IN_ERROR_RECOVERY=0;
        if(CPP_MODE && !CODE_UNREACHABLE)
            APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),LOOP_CONTEXT.scope));
        APPEND_JUMP_BLOCK(LOOP_CONTEXT.break_label,NO_SOURCE_LOCATION);
        LOOP_CONTEXT.continued=1;
    } else if(ENCLOSING_STATEMENT_KIND==1) {
        IN_ERROR_RECOVERY=0;
        if(CPP_MODE) {
            if(CURRENT_SWITCH.depth==STATEMENT_NEST_DEPTH)
                RELEASE_SCOPE_OBJECTS(CURRENT_SWITCH.scope);
            else if(!CODE_UNREACHABLE)
                APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),CURRENT_SWITCH.scope));
        }
        CURRENT_SWITCH.has_default=1;
        CURRENT_SWITCH.no_fall=1;
        APPEND_JUMP_BLOCK(CURRENT_SWITCH.break_label,NO_SOURCE_LOCATION);
    } else
        REPORT_CURRENT_TOKEN(MSG_MISPLACED_BREAK);
    ADVANCE_TOKEN();
    CODE_UNREACHABLE=1;
    REQUIRE_TOKEN_ELSE_ERROR(7,0xEA);
}

/* ---- PARSE_RETURN (listing 91C6) ---- */
#include <dos.h>
#include "BCCREC6.H"
extern unsigned int BCC_TREE_SPECIAL; extern unsigned int EXPR_POOL_SEG;
extern unsigned int SCOPE_POOL_SEG;
extern unsigned char PRAGMA_NORETVAL_PENDING;
extern void far pascal ADVANCE_TOKEN(void);
extern char far * far pascal FORMAT_SYMBOL(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern unsigned int far pascal PARSE_COMMA_EXPRESSION(unsigned int);
extern unsigned int far pascal BUILD_TEMP_DESTRUCTORS(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_RETURN_SLOT(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern void far pascal APPEND_ANALYZED_EXPRESSION(unsigned int);
extern void far pascal APPEND_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal APPEND_RETURN_JUMP_BLOCK(unsigned int,struct C77Record6);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);

/* return [value];  The value is stored through the function's return
   slot (MAKE_RETURN_SLOT; operator 0x5F builds the store).  When
   destructors must run after the value is computed, a non-class value is
   saved in a temporary first.  In a constructor or destructor (CTOR_DTOR_MODE
   1 or 2) a plain return jumps to CPP_BODY_END_LABEL.  SAW_RETURN_WITH_VALUE
   and SAW_RETURN_WITHOUT_VALUE feed the end-of-function warnings;
   #pragma noretval silences "function should return a value" once. */
static void near pascal PARSE_RETURN(void)
{
    unsigned int temp;
    unsigned int list;
    unsigned int special;
    struct C77Record6 where;
    register unsigned int node;
    register unsigned int type;

    IN_ERROR_RECOVERY=0;
    where.first=CURRENT_TOKEN_FILE;
    where.second=CURRENT_TOKEN_LINE;
    where.third=CURRENT_TOKEN_LOC_WORD3;
    ADVANCE_TOKEN();
    type=TYPE_W(CURRENT_FUNCTION_TYPE,TYPE_TARGET);
    if(TYPE_FLAGS[CURRENT_TOKEN]&EXPR_START_FLAG_MASK) {
        if(type==VOID_TYPE)
            REPORT_DIAGNOSTIC(CPP_MODE?MSG_CANNOT_RETURN_VALUE:MSG_VOID_FUNCTIONS_MAY_NOT,FORMAT_SYMBOL(BCC_TREE_SPECIAL),0L);
        else if(CTOR_DTOR_MODE==1)
            REPORT_DIAGNOSTIC(MSG_CANNOT_RETURN_VALUE,FORMAT_SYMBOL(BCC_TREE_SPECIAL),0L);
        else
            SAW_RETURN_WITH_VALUE=1;
        node=PARSE_COMMA_EXPRESSION(7);
        if(CPP_MODE && !CODE_UNREACHABLE)
            list=BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),SCOPE_W(GLOBAL_SCOPE,SCOPE_TEMPS));
        else
            list=0;
        special=MAKE_RETURN_SLOT(BCC_TREE_SPECIAL);
        if(list) {
            if(EXPR_FLAGS[TYPE_W(type,TYPE_KIND)]&0x40) {
                node=MAKE_BINARY_NODE(0x5F,special,node);
                EXPR_W(node,EXPR_TYPE)=type;
                node=JOIN_COMMA_EXPR(node,list);
            } else {
                temp=MAKE_SYMBOL_NODE(CREATE_LOCAL_TEMP(type));
                node=JOIN_COMMA_EXPR(MAKE_BINARY_NODE(5,temp,node),list);
                temp=MAKE_BINARY_NODE(0x5F,special,COPY_EXPR_TREE(temp));
                EXPR_W(temp,EXPR_TYPE)=type;
                node=JOIN_COMMA_EXPR(node,temp);
            }
        } else {
            node=MAKE_BINARY_NODE(0x5F,special,node);
            EXPR_W(node,EXPR_TYPE)=type;
        }
        node=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node,VOID_TYPE),0);
        APPEND_RETURN_JUMP_BLOCK(node,where);
    } else {
        SAW_RETURN_WITHOUT_VALUE=1;
        /* node=0 is written in each branch: the original keeps the three stores separate (-y). */
        if(CTOR_DTOR_MODE==1 || CTOR_DTOR_MODE==2)
            node=0;
        else if(type!=VOID_TYPE) {
            if(!PRAGMA_NORETVAL_PENDING)
                REPORT_CURRENT_TOKEN(CPP_MODE?MSG_FUNCTION_SHOULD_RETURN:MSG_FUNCTION_SHOULD_RETURN_367);
            node=0;
        } else
            node=0;
        if(CTOR_DTOR_MODE==2 || CTOR_DTOR_MODE==1) {
            APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),SCOPE_W(BCC_TREE_LINK,SCOPE_TEMPS)));
            APPEND_JUMP_BLOCK(CPP_BODY_END_LABEL,NO_SOURCE_LOCATION);
        } else {
            if(CPP_MODE)
                APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),SCOPE_W(GLOBAL_SCOPE,SCOPE_TEMPS)));
            node=SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node,VOID_TYPE),1);
            APPEND_RETURN_JUMP_BLOCK(node,where);
        }
    }
    REQUIRE_TOKEN_ELSE_ERROR(7,0xEA);
    CODE_UNREACHABLE=1;
    PRAGMA_NORETVAL_PENDING=0;
}

/* ---- REPORT_UNREACHABLE_CODE (listing 9439) ---- */
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);

/* Warns once if the statement about to be parsed cannot be reached. */
static void near pascal REPORT_UNREACHABLE_CODE(void)
{
    if(CODE_UNREACHABLE) {
        REPORT_CURRENT_TOKEN(MSG_UNREACHABLE_CODE);
        CODE_UNREACHABLE=0;
    }
}

/* ---- PARSE_STATEMENT_CPP (listing 9455) ---- */
#include <dos.h>
extern unsigned int TOKEN_TYPE; extern unsigned int CURRENT_TOKEN_RECORD; extern unsigned int SCOPE_POOL_SEG;
extern void far pascal PEEK_TOKEN(void);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal SKIP_TO_SYNC_TOKEN(unsigned int);
extern unsigned char far pascal TOKEN_IS_TYPE_START(void far *);
extern void far pascal PARSE_ASM_STATEMENT(void);
static void near pascal PARSE_COMPOUND_STATEMENT(void);

/* Parses one statement (with its labels).  flag nonzero means a
   declaration is allowed here (directly in a block); in C, declarations
   after statements are also reported.  Tokens that can start an
   expression go to PARSE_EXPRESSION_STATEMENT; anything else is "statement
   missing" and skipped to ';'. */
static void near pascal PARSE_STATEMENT_CPP(unsigned char flag)
{
    PARSE_LABELS();
    if(CPP_MODE && CURRENT_TOKEN==TOK_EXTERN) {
        PEEK_TOKEN();
        if(TOKEN_TYPE==0x34) {
            REPORT_CURRENT_TOKEN(MSG_LINKAGE_SPECIFICATION);
            ADVANCE_TOKEN();
            ADVANCE_TOKEN();
        }
    }
    if(TOKEN_IS_TYPE_START(&CURRENT_TOKEN_RECORD) && (!CPP_MODE || IS_DECLARATION_AHEAD())) {
        IN_ERROR_RECOVERY=0;
        if(!flag || !CPP_MODE && SCOPE_W(CURRENT_SCOPE,SCOPE_STMT_LEVEL)>=BLOCK_NEST_LEVEL)
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_NOT);
        PARSE_DECLARATION(0);
        return;
    }
    SCOPE_W(CURRENT_SCOPE,SCOPE_STMT_LEVEL)=BLOCK_NEST_LEVEL;
    switch(CURRENT_TOKEN) {
    case TOK_ASM:
        REPORT_UNREACHABLE_CODE();
        PARSE_ASM_STATEMENT();
        TOKEN_TYPE=0x82;
        ADVANCE_TOKEN();
        break;
    case TOK_SEMICOLON:
        ADVANCE_TOKEN();
        break;
    case TOK_GOTO:
        REPORT_UNREACHABLE_CODE();
        PARSE_GOTO();
        break;
    case TOK_LBRACE:
        PARSE_COMPOUND_STATEMENT();
        break;
    case TOK_IF:
        REPORT_UNREACHABLE_CODE();
        PARSE_IF_STATEMENT();
        break;
    case TOK_ELSE:
        REPORT_MISPLACED_ELSE();
        break;
    case TOK_SWITCH:
        REPORT_UNREACHABLE_CODE();
        PARSE_SWITCH();
        break;
    case TOK_WHILE:
        REPORT_UNREACHABLE_CODE();
        PARSE_WHILE();
        break;
    case TOK_DO:
        REPORT_UNREACHABLE_CODE();
        PARSE_DO();
        break;
    case TOK_FOR:
        REPORT_UNREACHABLE_CODE();
        PARSE_FOR(flag);
        break;
    case TOK_CONTINUE:
        REPORT_UNREACHABLE_CODE();
        PARSE_CONTINUE();
        break;
    case TOK_BREAK:
        REPORT_UNREACHABLE_CODE();
        PARSE_BREAK();
        break;
    case TOK_RETURN:
        REPORT_UNREACHABLE_CODE();
        PARSE_RETURN();
        break;
    case TOK_LPAREN: case TOK_ELLIPSIS: case TOK_PLUS: case TOK_MINUS: case TOK_STAR: case TOK_AMPERSAND:
    case TOK_COLON: case TOK_NOT: case TOK_TILDE: case TOK_SIZEOF: case TOK_INC: case TOK_DEC:
    case TOK_IDENT: case 0x32: case 0x33: case 0x34: case TOK_SHORT: case TOK_INT:
    case TOK_LONG: case TOK_FLOAT: case TOK_DOUBLE: case TOK_DEFAULT: case TOK_CASE: case 0x65:
    case TOK_SCOPE: case TOK_DELETE: case TOK_NEW: case TOK_OPERATOR: case TOK_THIS:
        REPORT_UNREACHABLE_CODE();
        PARSE_EXPRESSION_STATEMENT();
        break;
    default:
        REPORT_CURRENT_TOKEN(MSG_STATEMENT_REQUIRED);
        IN_ERROR_RECOVERY=1;
        ADVANCE_TOKEN();
        SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
        break;
    }
}

/* ---- PARSE_STATEMENT_LIST (listing 967D) ---- */
#include <dos.h>
extern unsigned int SCOPE_POOL_SEG;
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal SKIP_TO_SYNC_TOKEN(unsigned int);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);
extern void far pascal APPEND_SCOPE_EXIT_BLOCK(void);
extern void far pascal POP_SCOPE(unsigned char);

/* Parses statements up to the '}' of the current block (TYPE_FLAGS bits
   0x100 and 8 mark tokens that can start a statement or declaration). */
void far pascal PARSE_STATEMENT_LIST(void)
{
    unsigned int saved;

    saved=CURRENT_SWITCH.outer;
    do {
        while(TYPE_FLAGS[CURRENT_TOKEN]&0x100 || TYPE_FLAGS[CURRENT_TOKEN]&8)
            PARSE_STATEMENT_CPP(1);
        if(TYPE_FLAGS[CURRENT_TOKEN]&0x10) {
            REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            IN_ERROR_RECOVERY=1;
            SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
        } else if(CURRENT_TOKEN!=TOK_RBRACE) {
            REPORT_CURRENT_TOKEN(MSG_COMPOUND_STATEMENT);
            IN_ERROR_RECOVERY=1;
            SKIP_TO_SYNC_TOKEN(TOK_RBRACE);
        }
    } while(TYPE_FLAGS[CURRENT_TOKEN]&0x100 || TYPE_FLAGS[CURRENT_TOKEN]&8);
    CURRENT_SWITCH.outer=saved;
}

/* private near function at unit offset 0x2571, inside PARSE_STATEMENT_LIST's span */
/* { statements }  If declarations opened a scope for this block, its
   objects are destroyed and the scope is closed at the '}'. */
static void near pascal PARSE_COMPOUND_STATEMENT(void)
{
    REQUIRE_TOKEN_ELSE_ERROR(5,0xD8);
    BLOCK_NEST_LEVEL++;
    PARSE_STATEMENT_LIST();
    if(SCOPE_W(CURRENT_SCOPE,SCOPE_NEST_LEVEL)==BLOCK_NEST_LEVEL) {
        if(CPP_MODE)
            RELEASE_SCOPE_OBJECTS(SCOPE_W(SCOPE_W(CURRENT_SCOPE,SCOPE_PARENT),SCOPE_TEMPS));
        APPEND_SCOPE_EXIT_BLOCK();
        POP_SCOPE(0);
    }
    REQUIRE_TOKEN_ELSE_ERROR(6,0x1D);
    BLOCK_NEST_LEVEL--;
}

/* ---- PARSE_FUNCTION_BODY (listing 976F) ---- */
#include <dos.h>
extern unsigned int BCC_TREE_SPECIAL;
extern unsigned char PRAGMA_NORETVAL_PENDING;
extern unsigned int far pascal LOOKUP_NAME(unsigned int);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);
extern unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
extern void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern char far * far pascal FORMAT_SYMBOL(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);

/* Parses a function body.  In C++ CTOR_THIS_SYMBOL is set to the symbol of
   "this" (if any).  Creates and places CPP_BODY_END_LABEL, parses the
   statements, then warns if a non-void function (other than main in C++)
   has no return, or mixes "return;" with "return value;", and reports
   undefined labels. */
void far pascal PARSE_FUNCTION_BODY(void)
{
    if(CPP_MODE)
        CTOR_THIS_SYMBOL=LOOKUP_NAME(THIS_NAME);
    REQUIRE_TOKEN_ELSE_ERROR(5,0xD8);
    BLOCK_NEST_LEVEL++;
    CPP_BODY_END_LABEL=NEW_LABEL_IF_ENABLED();
    APPEND_BLOCK_IF_NONZERO(CPP_BODY_END_LABEL);
    PARSE_STATEMENT_LIST();
    if(!(CPP_MODE && SYM_W(BCC_TREE_SPECIAL,SYM_NAME)==MAIN_SYMBOL && CURRENT_CLASS_TYPE==0)
        && TYPE_W(CURRENT_FUNCTION_TYPE,TYPE_TARGET)!=VOID_TYPE
        && !SAW_RETURN_WITH_VALUE && !SAW_RETURN_WITHOUT_VALUE && !PRAGMA_NORETVAL_PENDING)
        REPORT_CURRENT_TOKEN(CPP_MODE?MSG_FUNCTION_SHOULD_RETURN:MSG_FUNCTION_SHOULD_RETURN_367);
    if(SAW_RETURN_WITH_VALUE && SAW_RETURN_WITHOUT_VALUE)
        REPORT_DIAGNOSTIC(MSG_BOTH_RETURN_RETURN,FORMAT_SYMBOL(BCC_TREE_SPECIAL),0L);
    PRAGMA_NORETVAL_PENDING=0;
    CHECK_UNDEFINED_LABELS();
}
