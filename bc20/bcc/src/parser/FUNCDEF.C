/* target: ovr083_C27UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: parser (C++ mode): function definitions: old-style parameters, parameter
   declaration, hidden return parameter, function body begin and end. Entry points:
   COMPILE_FUNCTION_DEFINITION, DECLARE_PARAMETERS, DECLARE_HIDDEN_RETURN_PARAM,
   BEGIN_FUNCTION_BODY, END_FUNCTION_BODY. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: function definitions in the C++ front end (which also compiles
   C when CPP_MODE, the C++ language flag, is clear).  When a
   declaration turns out to be followed by a body, the external
   declaration parser calls COMPILE_FUNCTION_DEFINITION.  It reads old
   style (K&R) parameter declarations if the function type has none
   (PARSE_KR_PARAMETERS), declares or finds the function symbol, and then
   either records the body for later (inline functions) or compiles it:
   BEGIN_FUNCTION_BODY opens the function scope and declares the
   parameters (DECLARE_PARAMETERS, plus a hidden pointer parameter for a
   returned struct, DECLARE_HIDDEN_RETURN_PARAM), the statement parser
   reads the body, and END_FUNCTION_BODY closes it and finishes the
   function (FINISH_FUNCTION_STATE, probably where it goes to the back
   end).
   The macros read records at raw offsets: T/TB type records (0 kind,
   2 attributes, 7 target or return type, 9 parameter list, 12 function
   flags), S/SB symbol records (2 name, 4 type, 6 flags, 7 storage class,
   8 storage), P/PB FORMAL parameter records (0 next, 2 type, 4 name,
   6 register, 7 implicit), CW scope records.  BCC_TREE_SPECIAL is the
   per-function state block cleared at the start of every body. */
#include <dos.h>
#include "FUNCDEF.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"
#define T(n,o) AT_W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) AT_B(TYPE_POOL,(unsigned int)(n)+(o))
#define S(n,o) AT_W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SB(n,o) AT_B(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define P(n,o) AT_W(FORMAL_POOL_SEG,(unsigned int)(n)+(o))
#define PB(n,o) AT_B(FORMAL_POOL_SEG,(unsigned int)(n)+(o))
#define CW(n,o) AT_W(SCOPE_POOL_SEG,(unsigned int)(n)+(o))
#define LINK(n,o) AT_W(TAG_BODY_POOL_SEG,(unsigned int)(n)+(o))
#define CACHE(n,o) AT_W(CACHE_POOL,(unsigned int)(n)+(o))

/* 0000: old-style parameter declarations, including the real name sentinel. */
/* Reads the parameter declarations between an old-style declarator and
   the body ("f(a, b) int a; char *b; {").  Each declared name must be in
   the function type's parameter list; its type is stored there, adjusted
   as C requires (float becomes double, a function or array becomes a
   pointer).  Only register (0x38) and, with relaxed checks, typedef are
   allowed as storage classes.  Parameters never declared get the default
   type INT_TYPE (probably int).  Sets flag 8 in the function flags. */
static void near pascal PARSE_KR_PARAMETERS(unsigned int function)
{
    unsigned int kind;
    unsigned int initial;
    unsigned int type;
    unsigned int name;
    unsigned char named;
    unsigned int scope;
    unsigned int owner;
    struct C27Spec spec;
    struct C27Spec declaration;
    struct C27Spec scratch;
    unsigned char modifier1;
    unsigned char modifier2;
    register unsigned int parameter;
    TB(function,12)|=8;
    while(TOKEN_IS_TYPE_START(&CURRENT_TOKEN_RECORD) &&
          (PEEK_TOKEN(), TOKEN_TYPE.kind)!=0x67) {
        initial=INT_TYPE;
        PARSE_DECL_SPECIFIERS(0,&kind,&modifier1,&modifier2,&initial,&spec,&named);
        if(kind!=0x82 && kind!=0x38 && (!NOT_ANSI_FLAG || kind!=0x37))
            REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,(long)NAME_TEXT_COPY(TOKEN_NAMES[kind]),0L);
        while(TYPE_FLAGS[CURRENT_TOKEN]&0x10) {
            declaration=spec;
            PARSE_DECLARATOR(initial,0,&type,&name,&scope,&owner,&declaration,&scratch);
            if(owner)
                REPORT_NAME_DIAGNOSTIC(MSG_TYPE_QUALIFIER_MUST,name);
            if(!name || scope)
                REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
            else if(kind==0x37)
                DECLARE_TYPEDEF(type,declaration,name);
            else {
                if((EXPR_FLAGS[T(type,0)]&2) && (int)T(type,0)<10)
                    type=DOUBLE_TYPE;
                else if(T(type,0)==0x12)
                    type=MAKE_POINTER_TYPE(type,0,0);
                else if(T(type,0)==0x11)
                    type=MAKE_POINTER_TYPE(T(type,7),(TB(type,2)&0x40)?0x10:0,0);
                /* The record at offset 0 of the pool serves as the list end
                   with the name planted in it, so the search below always
                   stops; reaching it (parameter 0) means "not a parameter". */
                P(0,4)=name;
                parameter=T(function,9);
                while(P(parameter,4)!=name)
                    parameter=P(parameter,0);
                if(!parameter)
                    REPORT_NAME_DIAGNOSTIC(MSG_NOT_PARAMETER,name);
                else {
                    if(!P(parameter,2))
                        P(parameter,2)=type;
                    else
                        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION,name);
                    PB(parameter,6)=kind==0x38;
                }
            }
            if(CURRENT_TOKEN==TOK_COMMA) {
                ADVANCE_TOKEN();
                if(!(TYPE_FLAGS[CURRENT_TOKEN]&0x10)) {
                    REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
                    IN_ERROR_RECOVERY=1;
                    ADVANCE_TOKEN();
                    SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
                }
            } else if(CURRENT_TOKEN!=TOK_SEMICOLON)
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
        }
        REQUIRE_TOKEN_ELSE_ERROR(7,0x1F);
    }
    for(parameter=T(function,9);parameter;parameter=P(parameter,0))
        if(!P(parameter,2))
            P(parameter,2)=INT_TYPE;
}

/* 0294: declare and compile one body, with its actual common cleanup. */
/* Compiles a function definition whose declarator has just been read.
   type: the function type; owner: the class for a member function
   defined outside its class (0 otherwise); name: its name; category:
   function kind (3 constructor, 4 destructor, else ordinary); code: the
   storage class or inline token (0x35 static, 0x6B inline); flag and
   deferred: passed on to BCC_TYPE_NORMALIZE for member functions.  A
   body already defined is an error.  An inline function's body is
   recorded and compiled later by COMPILE_INLINE_BODY; other bodies are
   compiled now, constructors and destructors through their own routines
   (member initializers and implicit base and member calls).  After a
   syntax error inside the body, tokens are skipped up to something that
   can start a declaration. */
void far pascal COMPILE_FUNCTION_DEFINITION(register unsigned int type,register unsigned int owner,
    unsigned int name,unsigned int category,unsigned int code,
    unsigned char flag,unsigned char deferred)
{
    unsigned int symbol;
    unsigned char valid;
    unsigned int saved_pool;
    unsigned int prepared;
    saved_pool=PARAM_SCOPE_MARK;
    if(TB(type,2)&0x40) {
        PARSE_KR_PARAMETERS(type);
        if(CURRENT_TOKEN!=TOK_LBRACE) {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
            IN_ERROR_RECOVERY=1;
            do {
                SKIP_TO_SYNC_TOKEN(TOK_LBRACE);
                if(CURRENT_TOKEN==TOK_SEMICOLON)
                    ADVANCE_TOKEN();
            } while(CURRENT_TOKEN==TOK_SEMICOLON);
        }
    }
    CURRENT_CLASS_TYPE=owner;
    if(owner && !deferred)
        BCC_TYPE_NORMALIZE(owner,type,name,&category,flag);
    if(!CURRENT_CLASS_TYPE)
        symbol=0;
    else {
        if(code==0x35 && !INLINE_FUNCTION_STACK)
            ((void (far pascal *)(int,char far *,long))REPORT_DIAGNOSTIC)
                (0x102,C27_STATIC_TEXT,0L);
        symbol=TYPE_BUILD(CURRENT_CLASS_TYPE,type,name,category);
    }
    if(!symbol)
        DECLARE_FUNCTION(type,name,category,code,&symbol,&valid);
    if(SB(symbol,6)&2)
        REPORT_CURRENT_TOKEN(MSG_BODY_HAS_ALREADY_BEEN);
    DIAG_NAME_BUFFER=0;
    FUNCTION_NAME_TEXT=NAME_TEXT_COPY(S(symbol,2));
    if(NO_ERRORS_YET && PRAGMA_SAVEREGS_PENDING) {
        TB(type,12)|=0x20;
        PRAGMA_SAVEREGS_PENDING=0;
    }
    SB(symbol,6)|=3;
    if((SB(symbol,7)>>3)==2)
        SB(symbol,7)=(SB(symbol,7)&7)|8;
    if(code==0x6B) {
        if(SB(symbol,6)&4)
            REPORT_CURRENT_TOKEN(MSG_FUNCTION_DEFINED);
        RECORD_INLINE_BODY(symbol);
        COMPILE_INLINE_BODY(symbol,0);
    } else {
        if(NO_ERRORS_YET) {
            prepared=PREPARE_SYMBOL(symbol);
            if(VTABLE_MODE!=3 || GET_SYMBOL_SEGMENT_HOOK(prepared)==0xFFFF)
                SET_SYMBOL_SEGMENT_HOOK(prepared,CODE_SEGMENT_ID);
        }
        BEGIN_FUNCTION_BODY(symbol,type);
        CW(CURRENT_SCOPE,2)=BLOCK_NEST_LEVEL+1;
        if(!CURRENT_CLASS_TYPE) {
            if(category==3 && CURRENT_TOKEN==TOK_COLON)
                while(CURRENT_TOKEN!=TOK_LBRACE && CURRENT_TOKEN!=0)
                    ADVANCE_TOKEN();
            PARSE_FUNCTION_BODY();
        } else {
            switch(category) {
            case 3:
                COMPILE_CONSTRUCTOR();
                break;
            case 4:
                COMPILE_DESTRUCTOR();
                break;
            default:
                PARSE_FUNCTION_BODY();
                break;
            }
        }
        END_FUNCTION_BODY();
        if(CURRENT_TOKEN==TOK_RBRACE)
            ADVANCE_TOKEN();
        else {
            REPORT_CURRENT_TOKEN(MSG_COMPOUND_STATEMENT);
            IN_ERROR_RECOVERY=1;
            while(!(TYPE_FLAGS[CURRENT_TOKEN]&8) &&
                  !(TYPE_FLAGS[CURRENT_TOKEN]&0x10) && CURRENT_TOKEN!=0)
                ADVANCE_TOKEN();
        }
    }
    PARAM_SCOPE_MARK_AUX=0;
    PARAM_SCOPE_MARK=saved_pool;
    FUNCTION_NAME_TEXT=0;
}

/* 051A: materialize the parameter list and publish nested aggregate members. */
/* Declares each parameter in the list starting at parameter as a local
   symbol of the function scope (storage class 6 in bits 3-7).  In C a
   parameter without a name is an error.  Parameters of a class type with
   a copy constructor (attribute 4) are passed by address in C++: their
   symbol gets a pointer type and flag 0x20.  #pragma argsused (or a
   compiler-added parameter) marks them used.  existing nonzero skips
   REGISTER_SYMBOL_VARIABLE (probably for a body being compiled again).
   Members of an anonymous union parameter (kind 0x15 with attribute 0x20)
   are entered into the scope as well. */
void far pascal DECLARE_PARAMETERS(unsigned int parameter,unsigned char existing)
{
    unsigned int type;
    int position;
    register unsigned int symbol;
    position=0;
    for(;parameter;parameter=P(parameter,0)) {
        ++position;
        if(!CPP_MODE && !P(parameter,4))
            REPORT_DIAGNOSTIC(MSG_PARAMETER_D_MISSING,(long)position,0L);
        symbol=BCC_TYPE_CREATE(P(parameter,4),5);
        SB(symbol,6)|=2;
        if(PRAGMA_ARGSUSED_PENDING || (CPP_MODE && PB(parameter,7)))
            SB(symbol,6)|=4;
        if(CPP_MODE && (EXPR_FLAGS[T(P(parameter,2),0)]&0x40) &&
           (TB(P(parameter,2),2)&4)) {
            S(symbol,4)=MAKE_POINTER_TYPE(P(parameter,2),0,1);
            SB(symbol,6)|=0x20;
        } else
            S(symbol,4)=P(parameter,2);
        SB(symbol,7)=(SB(symbol,7)&7)|0x30;
        S(symbol,8)=0;
        if(PB(parameter,6))
            SB(symbol,6)|=8;
        if(!existing)
            REGISTER_SYMBOL_VARIABLE(symbol);
        type=P(parameter,2);
        while(EXPR_FLAGS[T(type,0)]&0x14)
            type=T(type,7);
        if(T(type,0)==0x15 && (TB(type,2)&0x20))
            for(symbol=LINK(T(type,5),2);symbol;symbol=S(symbol,10)) {
                S(symbol,0)=CW(CURRENT_SCOPE,4);
                CW(CURRENT_SCOPE,4)=symbol;
            }
    }
}

/* 06BA: actual low-WORD size consumer of the canonical LONG size function. */
/* A function returning a struct gets a hidden first parameter, a far
   pointer to where the result goes, unless the struct is 1, 2 or 4 bytes
   and has no copy constructor (it is then returned in registers).  A
   member pointer (kind 0x0D with byte 13 equal to 0x0B) is treated as the
   class MEMBER_PTR_CLASS_TYPE. */
void far pascal DECLARE_HIDDEN_RETURN_PARAM(register unsigned int type,unsigned char existing)
{
    register unsigned int size;
    if(T(type,0)==0x0D && TB(type,13)==0x0B)
        type=MEMBER_PTR_CLASS_TYPE;
    size=(unsigned int)TYPE_SIZE(T(type,7));
    if(size==1 || size==2 || size==4) {
        if(!(TB(T(type,7),2)&4))
            return;
    }
    P(HIDDEN_RETURN_PARAM_RECORD,2)=MAKE_POINTER_TYPE(T(type,7),0x0F,0);
    DECLARE_PARAMETERS(HIDDEN_RETURN_PARAM_RECORD,existing);
    SB(CW(CURRENT_SCOPE,4),6)|=4;
}

/* 074F: initialize the genuine80-byte context, retaining four overlapping WORDs. */
/* Starts compiling the body of function symbol owner with type function:
   clears the per-function state (keeping the definition's file, line and
   position), opens the function's scope, declares the parameters, and
   for main with parameters marks the start-up helpers SETARGV_SYMBOL (and
   SETENVP_SYMBOL with three parameters) as used so the linker pulls them
   in (not for Windows programs). */
void far pascal BEGIN_FUNCTION_BODY(unsigned int owner,unsigned int function)
{
    unsigned int saved_file;
    unsigned int saved_line;
    long saved_expression;
    register unsigned int type;
    register unsigned int entry;
    saved_file=CURRENT_SOURCE_FILE;
    saved_line=FUNCTION_DEF_LINE;
    saved_expression=FUNCTION_DEF_POSITION;
    RTL_MEMSET(&BCC_TREE_SPECIAL,0,sizeof(BCC_TREE_SPECIAL));
    ++FUNCTION_BODY_DEPTH;
    CURRENT_SOURCE_FILE=saved_file;
    FUNCTION_DEF_LINE=saved_line;
    FUNCTION_DEF_POSITION=saved_expression;
    BCC_TREE_SPECIAL.root=owner;
    LOOP_NEST_FACTOR=1;
    CURRENT_FUNCTION_TYPE=function;
    if(CPP_MODE) {
        SWITCH_STATE_SCOPE=CW(GLOBAL_SCOPE,16);
        LOOP_CONTEXT=CW(GLOBAL_SCOPE,16);
        LOOP_BREAK_SCOPE=CW(GLOBAL_SCOPE,16);
        for(entry=CACHE_HEAD;entry;entry=CACHE(entry,0))
            if(CACHE(entry,2)==BCC_TREE_SPECIAL.root) {
                RETURN_FORM_SEEN=CACHE(entry,4);
                break;
            }
    }
    STMT_NO_GOTO_OR_LABEL_FLAG=1;
    LOOP_NEST_FACTOR=1;
    FNBODY_WORD_A_SAVE=FNBODY_WORD_A;
    FNBODY_WORD_B_SAVE=FNBODY_WORD_B;
    START_FUNCTION_STATE();
    PUSH_SCOPE(1);
    BCC_TREE_LINK=CURRENT_SCOPE;
    APPEND_SCOPE_ENTER_BLOCK();
    type=T(function,7);
    if((EXPR_FLAGS[T(type,0)]&0x40) ||
       ((EXPR_FLAGS[T(type,0)]&0x14) && T(T(type,7),0)==0x12 &&
        T(type,0)==0x0D && TB(type,13)==0x0B))
        DECLARE_HIDDEN_RETURN_PARAM(function,0);
    DECLARE_PARAMETERS(T(function,9),0);
    if(S(owner,2)==MAIN_SYMBOL && !(SB(owner,6)&0x10) &&
       !OPTION_WINDOWS_MODE && T(function,9)) {
        SB(SETARGV_SYMBOL,6)|=4;
        if(P(P(T(function,9),0),0))
            SB(SETENVP_SYMBOL,6)|=4;
    }
    PRAGMA_ARGSUSED_PENDING=0;
}

/* 08EE: normal body cleanup and exact original scope restoration. */
/* Finishes a function body: in C++ calls destructors for objects of the
   outer scope and emits pending static initializers, closes the body
   block, finishes the function (FINISH_FUNCTION_STATE, probably handing
   it to the back end), pops the scope and clears the per-function state. */
void far pascal END_FUNCTION_BODY(void)
{
    if(CPP_MODE) {
        RELEASE_SCOPE_OBJECTS(CW(CW(CURRENT_SCOPE,0),16));
        if(NO_ERRORS_YET)
            FLUSH_PENDING_INITIALIZERS(1);
    }
    APPEND_SCOPE_EXIT_BLOCK();
    FINISH_FUNCTION_STATE();
    POP_SCOPE(0);
    CURRENT_CLASS_TYPE=0;
    --FUNCTION_BODY_DEPTH;
    BCC_TREE_SPECIAL.root=0;
    CTOR_THIS_SYMBOL=0;
    FUNCTION_NAME_TEXT=0;
    FNBODY_CLEARED_WORD_A=0;
    FNBODY_WORD_A=FNBODY_WORD_A_SAVE;
    FNBODY_CLEARED_WORD_B=0;
    FNBODY_WORD_B=FNBODY_WORD_B_SAVE;
}
