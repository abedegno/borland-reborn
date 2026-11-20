/* target: ovr065_C9INIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: basic types and token tables initialisation. Entry points: INIT_PARSER. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: per-compile start of the parser. INIT_PARSER is called once per source file
   from the external-declaration parser (parser/EXTDECL.C) before the first token is
   read. It copies option bytes into parser flags, then:
   - C9BANKS / INITTYPE create the parser's pools (symbols, storage records, types, tag
     bodies, list cells, members, formals, labels; in C++ also the temporaries,
     destructor and base-class pools) and the global scope. Many pools get a dummy
     record 0 allocated at once, so that offset 0 can mean "none".
   - C9TYPES builds the basic types: C9_TYPE_GRID[v][c][kind] holds every scalar kind
     1..12 in four variants (v=0 volatile, c=0 const; [1][1] is the plain type, which
     BCC_TYPE_PTR points at). Then the common derived types (char *, void *, default
     function types), the hidden return-value parameter, the start-up helpers
     _setargv/_setenvp, and for C++ the operator new/delete and vector helpers and two
     built-in classes: the virtual-table entry and the pointer-to-member layout.
   - C9TOKENS declares the pseudo-register variables _AX, _DX ... (from PSEUDO_REGISTER_TABLE)
     and C9INTRINSICS the intrinsic functions such as __abs__ and __emit__ (from
     INTRINSIC_TABLE).
   Names to trip over: CPP_MODE is the C++ mode flag (OPTION_FLAGS bit 0);
   NOT_ANSI_FLAG is set when the language mode (LANGUAGE_MODE, set by -A) is not
   ANSI, and enables the pseudo-registers; GLOBAL_SCOPE_NAMES and GLOBAL_SCOPE_TAGS are the heads of
   the global name and tag lists, not types; INT_TYPE is the type int; TYPE_LOCAL is
   a char pointer type chosen together with VTABLE_ENTRY_PTR_TYPE (far in the huge model or when
   OPTION_FLAG is set). MODEL_FAR_DATA set
   means data pointers are far by default, MODEL_FAR_CODE that functions are far. Type
   kinds 13 and 15 are TK_NEAR_PTR and TK_FAR_PTR (KIND.H). */
#include <dos.h>
#include "INITTYPE.H"
#include "POOL.H"

#define BANK(name) (*(struct C9Bank near *)&(name))
#define FIRST(segment) (*(unsigned int far *)MK_FP((segment),0))

/* Original0000..0182: private, no-argument, near Pascal initializer. */
/* Creates the parser's basic pools, each with its growth step, and allocates the dummy
   record 0 in most of them (symbol entry, type, cons cell, member, formal, label). */
static void near pascal INITTYPE(void)
{
    BANK(CSYM_POOL_SEG).used=BANK(CSYM_POOL_SEG).spare=10;
    BANK(CSYM_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(CSYM_POOL_SEG),10);
    STORAGE_RECORD_COUNT=0;

    BANK(STORAGE_POOL_SEG).used=BANK(STORAGE_POOL_SEG).spare=2;
    BANK(STORAGE_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(STORAGE_POOL_SEG),2);

    BANK(SYMBOL_POOL_SEG).used=BANK(SYMBOL_POOL_SEG).spare=0;
    BANK(SYMBOL_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(SYMBOL_POOL_SEG),0);
    ALLOC_SYMBOL_ENTRY(0,0);

    BANK(TYPE_POOL).used=BANK(TYPE_POOL).spare=0;
    BANK(TYPE_POOL).limit=0;
    POOL_INIT((unsigned int far *)&BANK(TYPE_POOL),0);
    DUPLICATE_TYPE_FREE_LIST=0;
    CREATE_TYPE(0);

    BANK(TAG_BODY_POOL_SEG).used=BANK(TAG_BODY_POOL_SEG).spare=2;
    BANK(TAG_BODY_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(TAG_BODY_POOL_SEG),2);

    BANK(CONS_CELL_POOL_SEG).used=BANK(CONS_CELL_POOL_SEG).spare=0;
    BANK(CONS_CELL_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(CONS_CELL_POOL_SEG),0);
    LIST_CONS(0,0);
    FIRST(CONS_CELL_POOL_SEG)=0;

    BANK(MEMBER_SEGMENT).used=BANK(MEMBER_SEGMENT).spare=0;
    BANK(MEMBER_SEGMENT).limit=0;
    POOL_INIT((unsigned int far *)&BANK(MEMBER_SEGMENT),0);
    C9_ALLOC_MEMBER(0);
    C9_CLEAR_MEMBER_TABLES();

    BANK(LIST_CELL_POOL_SEG).used=BANK(LIST_CELL_POOL_SEG).spare=0;
    BANK(LIST_CELL_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(LIST_CELL_POOL_SEG),0);
    LIST_CONS_ALT(0,0);

    BANK(FORMAL_POOL_SEG).used=BANK(FORMAL_POOL_SEG).spare=0;
    BANK(FORMAL_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(FORMAL_POOL_SEG),0);
    ALLOC_FORMAL_RECORD();
    FIRST(FORMAL_POOL_SEG)=0;

    BANK(LABEL_POOL_SEG).used=BANK(LABEL_POOL_SEG).spare=0;
    BANK(LABEL_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(LABEL_POOL_SEG),0);
    ALLOC_LABEL_RECORD();
    FIRST(LABEL_POOL_SEG)=0;
}


/* 0182 */
/* Creates the pools (INITTYPE), the global scope with its name list (GLOBAL_SCOPE_NAMES) and
   tag list (GLOBAL_SCOPE_TAGS), the C++-only pools (temporaries, base paths, destructor
   entries, cache, initializer records, base-class list with its record 0 = a public
   non-virtual base), and resets parser state counters. */
static void near pascal C9BANKS(void)
{
    INITTYPE();
    CURRENT_SCOPE=GLOBAL_SCOPE=ALLOC_SCOPE();
    SCOPE_W(CURRENT_SCOPE,SCOPE_NEST_LEVEL)=0;
    SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES)=ALLOC_SYMBOL_ENTRY(0,0);
    GLOBAL_SCOPE_NAMES=SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES);
    SCOPE_W(CURRENT_SCOPE,SCOPE_TAGS)=ALLOC_SYMBOL_ENTRY(0,0);
    GLOBAL_SCOPE_TAGS=SCOPE_W(CURRENT_SCOPE,SCOPE_TAGS);
    SCOPE_B(CURRENT_SCOPE,SCOPE_IS_FUNCTION)=0;
    if(CPP_MODE) {
        BANK(PACKED_EXPR_POOL_SEG).used=BANK(PACKED_EXPR_POOL_SEG).spare=2;
        BANK(PACKED_EXPR_POOL_SEG).limit=0;
        POOL_INIT((unsigned int far *)&BANK(PACKED_EXPR_POOL_SEG),2);
        BANK(BASE_PATH_POOL_SEG).used=BANK(BASE_PATH_POOL_SEG).spare=2;
        BANK(BASE_PATH_POOL_SEG).limit=0;
        POOL_INIT((unsigned int far *)&BANK(BASE_PATH_POOL_SEG),2);
        BANK(TEMP_ENTRY_POOL_SEG).used=BANK(TEMP_ENTRY_POOL_SEG).spare=0;
        BANK(TEMP_ENTRY_POOL_SEG).limit=0;
        POOL_INIT((unsigned int far *)&BANK(TEMP_ENTRY_POOL_SEG),0);
        SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS)=ALLOC_TEMP_ENTRY();
        TDTOR_W(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),TDTOR_NEXT)=0;
        TDTOR_W(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),TDTOR_SERIAL)=0;
        TDTOR_W(SCOPE_W(CURRENT_SCOPE,SCOPE_TEMPS),TDTOR_EXPR)=0;
        DESTRUCTOR_ENTRY_SERIAL=1;
        BANK(CACHE_POOL).used=BANK(CACHE_POOL).spare=2;
        BANK(CACHE_POOL).limit=0;
        POOL_INIT((unsigned int far *)&BANK(CACHE_POOL),2);
        CACHE_HEAD=0;
    }
    TEMP_NAME_COUNTER=0;
    DIAG_FUNC_NAME_HIGH=0;
    FUNCTION_NAME_TEXT=0;
    CURRENT_LINKAGE=0;
    BANK(LINKAGE_STACK_POOL_SEG).used=BANK(LINKAGE_STACK_POOL_SEG).spare=2;
    BANK(LINKAGE_STACK_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(LINKAGE_STACK_POOL_SEG),2);
    LINKAGE_STACK=0;
    CURRENT_CLASS_TYPE=0;
    BCC_TREE_FLAG=0;
    PARAM_LIST_DEPTH=0;
    INLINE_BODY_QUEUE=0;
    FUNCTION_BODY_DEPTH=0;
    RTL_MEMSET((void far *)&BCC_TREE_SPECIAL,0,0x50);
    LOOP_NEST_FACTOR=1;
    CTOR_DTOR_MODE=0;
    if(CPP_MODE) {
        SWITCH_STATE_SCOPE=SCOPE_W(GLOBAL_SCOPE,SCOPE_TEMPS);
        LOOP_CONTEXT=SCOPE_W(GLOBAL_SCOPE,SCOPE_TEMPS);
        LOOP_BREAK_SCOPE=SCOPE_W(GLOBAL_SCOPE,SCOPE_TEMPS);
    }
    STMT_NO_GOTO_OR_LABEL_FLAG=1;
    LOOP_NEST_FACTOR=1;
    if(CPP_MODE) {
        BANK(INIT_RECORD_POOL_SEG).used=BANK(INIT_RECORD_POOL_SEG).spare=2;
        BANK(INIT_RECORD_POOL_SEG).limit=0;
        POOL_INIT((unsigned int far *)&BANK(INIT_RECORD_POOL_SEG),2);
        BANK(BASE_LIST_SEG).used=BANK(BASE_LIST_SEG).spare=0;
        BANK(BASE_LIST_SEG).limit=0;
        POOL_INIT((unsigned int far *)&BANK(BASE_LIST_SEG),0);
        POOL_ALLOC_REUSE((unsigned int far *)&BASE_LIST_SEG,9);
        BASE_W(0,BASE_NEXT)=0;
        BASE_W(0,BASE_TYPE)=0;
        BASE_W(0,BASE_OFFSET)=0;
        BASE_B(0,BASE_PUBLIC)=1;
        BASE_B(0,BASE_VIRTUAL)=0;
    }
}

/* 03CB */
/* Creates the scalar type of kind with its debugger type id. second==0 makes it const
   (TYPE_ATTRS |= 1), first==0 volatile (TYPE_ATTRS |= 2). */
static unsigned int near pascal C9SCALAR(register unsigned int kind,
    unsigned int first,unsigned int second)
{
    register unsigned int type;

    type=CREATE_TYPE(kind);
    SET_TYPE_DEBUG_ID(type,(unsigned int)C9_TYPE_SIZES[kind]);
    if(!second)
        TYPE_B(type,TYPE_ATTRS)|=1;
    if(!first)
        TYPE_B(type,TYPE_ATTRS)|=2;
    return type;
}

/* 0410 */
/* Returns the pointer-to-type type of pointer kind kind (13 near, 15 far). kind 0 means
   the model's default: for a function, far if MODEL_FAR_CODE; for data, far if
   MODEL_FAR_DATA. FIND_EQUIVALENT_TYPE returns an existing identical type if one exists. */
static unsigned int near pascal C9POINTER(register unsigned int type,
    unsigned int kind)
{
    unsigned char flag;
    register unsigned int result;

    if(!kind) {
        flag=TYPE_W(type,TYPE_KIND)==TK_FUNCTION?MODEL_FAR_CODE:MODEL_FAR_DATA;
        kind=flag?15:13;
    }
    result=CREATE_TYPE(kind);
    TYPE_W(result,TYPE_TARGET)=type;
    TYPE_B(result,TYPE_PTR_MODE)=TYPE_W(type,TYPE_KIND)==TK_FUNCTION?2:4;
    TYPE_W(result,TYPE_PARAMS)=0;
    return FIND_EQUIVALENT_TYPE(result);
}

/* 0482 */
/* Allocates a formal-parameter record of type type in front of the list next. */
static unsigned int near pascal C9PARAMETER(unsigned int next,unsigned int type)
{
    register unsigned int result;
    result=ALLOC_FORMAL_RECORD();
    FORMAL_W(result,FORMAL_NEXT)=next;
    FORMAL_W(result,FORMAL_TYPE)=type;
    return result;
}

/* 04A7 */
/* Creates a function type returning result with parameter list parameters, calling
   convention convention (1 cdecl, 2 pascal, 3 the third convention option) and the
   TYPE_FUNC_FLAGS byte flags: 1 far, 0x40 near; if neither is given the model decides.
   Flag 8 is set for functions declared without parameters here, probably meaning
   "no prototype". */
static unsigned int near pascal C9FUNCTION(unsigned int result,
    unsigned int parameters,unsigned int flags,unsigned int convention)
{
    register unsigned int type;
    type=CREATE_TYPE(0x12);
    TYPE_W(type,TYPE_TARGET)=result;
    TYPE_W(type,TYPE_PARAMS)=parameters;
    TYPE_B(type,TYPE_FUNC_FLAGS)=flags;
    if(!(flags&0x41))
        TYPE_B(type,TYPE_FUNC_FLAGS)|=MODEL_FAR_CODE?1:0x40;
    TYPE_B(type,TYPE_CALL_CONV)=convention;
    return type;
}

/* 04FF */
/* Declares a global function name used by generated code (start-up helpers, new,
   delete, vector helpers) with up to two parameter types first, second, result type
   result and function flags flags. In C++ source is stored as the symbol's linkage. */
static unsigned int near pascal C9BUILTIN(char far *name,unsigned int category,
    unsigned int source,unsigned int flags,unsigned int result,
    unsigned int first,unsigned int second)
{
    unsigned int type;
    register unsigned int parameters;
    register unsigned int symbol;

    parameters=0;
    if(second)
        parameters=C9PARAMETER(parameters,second);
    if(first)
        parameters=C9PARAMETER(parameters,first);
    type=C9FUNCTION(result,parameters,flags|(first==0?8:0),1);
    symbol=DECLARE_GLOBAL_SYMBOL(name,type,0,category);
    SYM_B(symbol,SYM_FLAGS)|=(TYPE_B(type,TYPE_FUNC_FLAGS)&1)?0x80:0;
    if(CPP_MODE)
        SYM_W(symbol,SYM_LINKAGE)=source;
    return symbol;
}

/* 0593 */
/* Creates an empty struct type for a built-in class and makes it STRUCT_BODY_TYPE, the
   class C9MEMBER adds to. In C++ the class gets flag 2 and a far (8) or near (0x10)
   flag after the data model. */
static unsigned int near pascal C9CLASS(void)
{
    register unsigned int type;
    STRUCT_BODY_TYPE=type=CREATE_TYPE(0x13);
    SCOPE_STATE=0;
    if(CPP_MODE) {
        TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)|=2;
        TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)|=MODEL_FAR_DATA?8:0x10;
    }
    return type;
}

/* 05EA */
/* Returns the global symbol called name, creating it with type type if it does not
   exist yet. Used for the pseudo-registers and the string-literal symbol. */
static unsigned int near pascal C9NAMED(char near *name,unsigned int type)
{
    register unsigned int symbol;
    register unsigned int key;

    key=BCC_SYMBOL_CREATE((char far *)name,0);
    symbol=FIND_NAME_IN_LIST(key,SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES));
    if(symbol)
        return symbol;
    symbol=ALLOC_SYMBOL_ENTRY(key,5);
    SYM_W(symbol,SYM_TYPE)=type;
    SYM_W(symbol,SYM_NEXT)=NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS);
    NAME_W(SYM_W(symbol,SYM_NAME),NAME_SYMBOLS)=symbol;
    SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&7)|0x18;
    SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&0xF8)|1;
    SYM_B(symbol,SYM_FLAGS)=7;
    return symbol;
}

/* 0676 */
/* Appends member name of type type at the end of STRUCT_BODY_TYPE and grows the class
   size. Callers move some members back afterwards to make unions (see C9TYPES). */
static unsigned int near pascal C9MEMBER(unsigned int type,char far *name)
{
    register unsigned int member;
    register unsigned int actual;

    actual=type;
    member=DECLARE_MEMBER(BCC_SYMBOL_CREATE(name,0),0);
    MEMBER_W(member,MEMB_TYPE)=actual;
    MEMBER_W(member,MEMB_VALUE)=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_SIZE);
    MEMBER_W(member,MEMB_CLASS)=STRUCT_BODY_TYPE;
    TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_SIZE)+=(unsigned int)TYPE_SIZE(actual);
    TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_OWN_SIZE)=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_SIZE);
    return member;
}

/* 070E */
/* Declares each pseudo-register variable of PSEUDO_REGISTER_TABLE (the table of
   _AX, _DX, ...) as a register-class symbol of its type; entry->flags is the register
   number, given to the back end as the symbol's offset. */
static void near pascal C9TOKENS(void)
{
    struct C9Token far *entry=PSEUDO_REGISTER_TABLE;
    register unsigned int symbol;
    register unsigned int expression;

    while(entry->name) {
        if(entry->name) {
            symbol=C9NAMED(entry->name,BCC_TYPE_PTR[entry->type]);
            SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&7)|0x38;
            SYM_B(symbol,SYM_FLAGS)=0x0E;
            expression=PREPARE_SYMBOL(symbol);
            SET_SYMBOL_SEGMENT_HOOK(expression,0);
            SET_SYMBOL_OFFSET_HOOK(expression,entry->flags);
        }
        ++entry;
    }
}

/* 0787 */
/* Declares each intrinsic function of INTRINSIC_TABLE that the program has not already
   declared; SYM_INTRINSIC_NUM is its index in the table. __emit__ gets a void function
   type and is remembered in EMIT_INTRINSIC_SYMBOL. Pointer parameter and result kinds
   in the table are replaced by the model's default data pointer kind. */
static void near pascal C9INTRINSICS(void)
{
    struct C9Intrinsic far *entry=INTRINSIC_TABLE;
    int number=0;
    char far *name;
    unsigned int key;
    register unsigned int symbol;
    register int parameter;

    while(entry->name) {
        name=(char far *)entry->name;
        key=BCC_SYMBOL_CREATE(name,0);
        if(!FIND_NAME_IN_LIST(key,SCOPE_W(CURRENT_SCOPE,SCOPE_NAMES))) {
            symbol=BCC_TYPE_CREATE(key,7);
            SYM_B(symbol,SYM_STORAGE_CLASS)=(SYM_B(symbol,SYM_STORAGE_CLASS)&7)|0x50;
            SYM_B(symbol,SYM_INLINE_ACCESS)=(SYM_B(symbol,SYM_INLINE_ACCESS)&0xFC)|3;
            SYM_W(symbol,SYM_INTRINSIC_NUM)=number;
            if(COMPARE_NAME(name,(char far *)STR___EMIT__)==0) {
                EMIT_INTRINSIC_SYMBOL=symbol;
                SYM_W(symbol,SYM_TYPE)=C9FUNCTION(VOID_TYPE,0,4,1);
            }
            parameter=0;
            while(parameter<entry->count) {
                if(EXPR_FLAGS[(int)entry->parameters[parameter]]&0x14)
                    entry->parameters[parameter]=MODEL_FAR_DATA?15:13;
                ++parameter;
            }
            if(EXPR_FLAGS[(int)entry->result]&0x14)
                entry->result=MODEL_FAR_DATA?15:13;
        }
        ++entry;
        ++number;
    }
}

/* 08AD */
/* Builds the basic and derived types and the built-in symbols (see the overview). In
   the middle it loads the precompiled header if any (TRY_PCH_LOAD), reads the first
   token and starts the back end's output (BEGIN_BACKEND_OUTPUT_HOOK), so the types
   after that point see what the header defined. */
static void near pascal C9TYPES(void)
{
    int kind;
    register int first;
    register int second;

    INT_TYPE_SIZE=2;
    BCC_TYPE_PTR=C9_TYPE_GRID[1][1];
    first=0;
    while(first<=1) {
        second=0;
        while(second<=1) {
            C9_TYPE_GRID[first][second][0]=0;
            kind=1;
            while(kind<=12) {
                C9_TYPE_GRID[first][second][kind]=C9SCALAR(kind,first,second);
                ++kind;
            }
            ++second;
        }
        ++first;
    }
    PLAIN_CHAR_KIND=UNSIGNED_CHAR?2:1;
    PLAIN_CHAR_TYPE=CHAR_TYPE=BCC_TYPE_PTR[PLAIN_CHAR_KIND];
    INT_TYPE=BCC_TYPE_PTR[5];
    INT_TYPE_SIZE=TYPE_SIZE(INT_TYPE);
    LONG_TYPE=BCC_TYPE_PTR[7];
    SHORT_TYPE=BCC_TYPE_PTR[3];
    DOUBLE_TYPE=BCC_TYPE_PTR[10];
    DOUBLE_TYPE_SIZE=TYPE_SIZE(DOUBLE_TYPE);
    VOID_TYPE=BCC_TYPE_PTR[12];
    SIZE_T_TYPE=UNSIGNED_INT_TYPE;
    TRY_PCH_LOAD();
    LEX_NEXT_TOKEN();
    BEGIN_BACKEND_OUTPUT_HOOK();
    PTRDIFF_TYPE=MODEL_FAR_DATA?LONG_TYPE:INT_TYPE;
    CHAR_POINTER_TYPE=C9POINTER(CHAR_TYPE,0);
    STRING_LITERAL_SYMBOL=C9NAMED(STR_S_2,INT_TYPE);
    PREPARE_SYMBOL(STRING_LITERAL_SYMBOL);
    if(OPTION_CALLING_CONVENTION==1)
        DEFAULT_CALL_CONVENTION=2;
    else if(OPTION_CALLING_CONVENTION==2)
        DEFAULT_CALL_CONVENTION=3;
    else
        DEFAULT_CALL_CONVENTION=1;
    HIDDEN_RETURN_PARAM_RECORD=ALLOC_FORMAL_RECORD();
    FORMAL_W(HIDDEN_RETURN_PARAM_RECORD,FORMAL_NEXT)=0;
    FORMAL_W(HIDDEN_RETURN_PARAM_RECORD,FORMAL_TYPE)=0;
    FORMAL_W(HIDDEN_RETURN_PARAM_RECORD,FORMAL_NAME)=HIDDEN_RETURN_PARAM_NAME;
    FORMAL_B(HIDDEN_RETURN_PARAM_RECORD,FORMAL_IMPLICIT)=0;
    VOID_POINTER_TYPE=C9POINTER(VOID_TYPE,0);
    FAR_VOID_PTR_TYPE=C9POINTER(VOID_TYPE,15);
    IMPLICIT_FUNC_TYPE=C9FUNCTION(INT_TYPE,0,8,DEFAULT_CALL_CONVENTION);
    INT_FAR_FUNC_TYPE=C9FUNCTION(INT_TYPE,0,1,DEFAULT_CALL_CONVENTION);
    INT_NEAR_FUNC_TYPE=C9FUNCTION(INT_TYPE,0,0x40,DEFAULT_CALL_CONVENTION);
    VOID_NOARG_FUNC_TYPE=C9FUNCTION(VOID_TYPE,0,8,DEFAULT_CALL_CONVENTION);
    RUNTIME_HELPER_FUNC_TYPE=C9FUNCTION(INT_TYPE,0,8|(NEAR_HELPER_CALLS?0x40:1),DEFAULT_CALL_CONVENTION);
    IMPLICIT_FUNC_PTR_TYPE=C9POINTER(IMPLICIT_FUNC_TYPE,0);
    INT_NEAR_FUNC_PTR_TYPE=C9POINTER(INT_NEAR_FUNC_TYPE,13);
    INT_FAR_FUNC_PTR_TYPE=C9POINTER(INT_FAR_FUNC_TYPE,15);
    MAIN_SYMBOL=BCC_SYMBOL_CREATE((char far *)STR_MAIN_2,0x31);
    SETARGV_SYMBOL=C9BUILTIN((char far *)(OPTION_UNDERSCORES?STR__SETARGV__:STR___SETARGV__),0,2,0,VOID_TYPE,0,0);
    SETENVP_SYMBOL=C9BUILTIN((char far *)(OPTION_UNDERSCORES?STR__SETENVP__:STR___SETENVP__),0,2,0,VOID_TYPE,0,0);
    if(CPP_MODE) {
        NEW_OPERATOR_SYMBOL=C9BUILTIN((char far *)STR_NEW,1,1,0,VOID_POINTER_TYPE,SIZE_T_TYPE,0);
        VECTOR_NEW_SYMBOL=C9BUILTIN((char far *)STR__VECTOR_NEW_,0,2,0,FAR_VOID_PTR_TYPE,0,0);
        VECTOR_VNEW_SYMBOL=C9BUILTIN((char far *)STR__VECTOR_VNEW_,0,2,0,FAR_VOID_PTR_TYPE,0,0);
        DELETE_OPERATOR_SYMBOL=C9BUILTIN((char far *)STR_DELETE,1,1,0,VOID_TYPE,VOID_POINTER_TYPE,0);
        VECTOR_DELETE_SYMBOL=C9BUILTIN((char far *)STR__VECTOR_DELETE_,0,2,0,VOID_TYPE,0,0);
        VECTOR_APPLY_SYMBOL=C9BUILTIN((char far *)STR__VECTOR_APPLY_,0,2,0,VOID_TYPE,0,0);
        VECTOR_VAPPLY_SYMBOL=C9BUILTIN((char far *)STR__VECTOR_VAPPLY_,0,2,0,VOID_TYPE,0,0);
        FAR_PURE_ERROR_SYMBOL=C9BUILTIN((char far *)STR__FPURE_ERROR_,0,2,1,VOID_TYPE,0,0);
        NEAR_PURE_ERROR_SYMBOL=C9BUILTIN((char far *)STR__NPURE_ERROR_,0,2,0x40,VOID_TYPE,0,0);
        /* Virtual-table entry: a far and a near function pointer at the same offset
           (a union), sized as the far one. */
        VTABLE_ENTRY_CLASS_TYPE=C9CLASS();
        VTABLE_FAR_FUNC_MEMBER=C9MEMBER(INT_FAR_FUNC_PTR_TYPE,(char far *)STR_FAR_FUNC);
        VTABLE_NEAR_FUNC_MEMBER=C9MEMBER(INT_NEAR_FUNC_PTR_TYPE,(char far *)STR_NEAR_FUNC);
        MEMBER_W(VTABLE_NEAR_FUNC_MEMBER,MEMB_VALUE)=MEMBER_W(VTABLE_FAR_FUNC_MEMBER,MEMB_VALUE);
        TAG_W(TYPE_W(VTABLE_ENTRY_CLASS_TYPE,TYPE_TAG_BODY),TAG_SIZE)-=(unsigned int)TYPE_SIZE(INT_NEAR_FUNC_PTR_TYPE);
        TAG_W(TYPE_W(VTABLE_ENTRY_CLASS_TYPE,TYPE_TAG_BODY),TAG_OWN_SIZE)=TAG_W(TYPE_W(VTABLE_ENTRY_CLASS_TYPE,TYPE_TAG_BODY),TAG_SIZE);
        /* Pointer-to-member layout: delta, vindex, then a function pointer (far or
           near) overlaid on offset/pad. */
        MEMBER_PTR_CLASS_TYPE=C9CLASS();
        MEMBER_PTR_DELTA_MEMBER=C9MEMBER(INT_TYPE,(char far *)STR_DELTA);
        MEMBER_PTR_VINDEX_MEMBER=C9MEMBER(INT_TYPE,(char far *)STR_VINDEX);
        MEMBER_PTR_OFFSET_MEMBER=C9MEMBER(SHORT_TYPE,(char far *)STR_OFFSET);
        MEMBER_PTR_PAD_MEMBER=C9MEMBER(SHORT_TYPE,(char far *)STR_PAD);
        MEMBER_PTR_FAR_FUNC_MEMBER=C9MEMBER(INT_FAR_FUNC_PTR_TYPE,(char far *)STR_FAR_FUNC);
        MEMBER_W(MEMBER_PTR_FAR_FUNC_MEMBER,MEMB_VALUE)=MEMBER_W(MEMBER_PTR_OFFSET_MEMBER,MEMB_VALUE);
        TAG_W(TYPE_W(MEMBER_PTR_CLASS_TYPE,TYPE_TAG_BODY),TAG_SIZE)-=(unsigned int)TYPE_SIZE(INT_FAR_FUNC_PTR_TYPE);
        MEMBER_PTR_NEAR_FUNC_MEMBER=C9MEMBER(INT_NEAR_FUNC_PTR_TYPE,(char far *)STR_NEAR_FUNC);
        MEMBER_W(MEMBER_PTR_NEAR_FUNC_MEMBER,MEMB_VALUE)=MEMBER_W(MEMBER_PTR_OFFSET_MEMBER,MEMB_VALUE);
        TAG_W(TYPE_W(MEMBER_PTR_CLASS_TYPE,TYPE_TAG_BODY),TAG_SIZE)-=(unsigned int)TYPE_SIZE(INT_NEAR_FUNC_PTR_TYPE);
        TAG_W(TYPE_W(MEMBER_PTR_CLASS_TYPE,TYPE_TAG_BODY),TAG_OWN_SIZE)=TAG_W(TYPE_W(MEMBER_PTR_CLASS_TYPE,TYPE_TAG_BODY),TAG_SIZE);
        FAR_CHAR_POINTER_TYPE=C9POINTER(CHAR_TYPE,15);
        FAR_VTABLE_ENTRY_PTR_TYPE=C9POINTER(VTABLE_ENTRY_CLASS_TYPE,15);
        if(OPTION_MEMORY_MODEL==5 || OPTION_FLAG) {
            TYPE_LOCAL=FAR_CHAR_POINTER_TYPE;
            VTABLE_ENTRY_PTR_TYPE=FAR_VTABLE_ENTRY_PTR_TYPE;
        } else {
            TYPE_LOCAL=C9POINTER(CHAR_TYPE,13);
            VTABLE_ENTRY_PTR_TYPE=C9POINTER(VTABLE_ENTRY_CLASS_TYPE,13);
        }
    } else {
        NEW_OPERATOR_SYMBOL=0;
        VECTOR_NEW_SYMBOL=0;
        DELETE_OPERATOR_SYMBOL=0;
        VECTOR_DELETE_SYMBOL=0;
        VTABLE_ENTRY_CLASS_TYPE=0;
        NON_CPP_CLEARED_WORD_A=0;
        NON_CPP_CLEARED_WORD_B=0;
        VTABLE_FAR_FUNC_MEMBER=0;
        MEMBER_PTR_CLASS_TYPE=0;
        MEMBER_PTR_OFFSET_MEMBER=0;
        MEMBER_PTR_VINDEX_MEMBER=0;
        MEMBER_PTR_FAR_FUNC_MEMBER=0;
        MEMBER_PTR_DELTA_MEMBER=0;
    }
    if(CPP_MODE || NOT_ANSI_FLAG)
        C9TOKENS();
    EMIT_INTRINSIC_SYMBOL=0;
    C9INTRINSICS();
}

/* 0E75: sole actual overlay export. */
/* The file's only exported entry; see the overview. Ends by reading the first token
   (ADVANCE_TOKEN), so the parser can start. */
void far pascal INIT_PARSER(void)
{
    struct C9TokenName far *entry;

    PARSER_INIT_MARK_A5=0xA5;
    CPP_MODE=OPTION_FLAGS&1;
    NOT_ANSI_FLAG=LANGUAGE_MODE!=1;
    PARSER_RESET_BYTE_A=0;
    CPU_LEVEL_1_FLAG=VTABLE_MODE==1;
    CPU_IS_286=VTABLE_MODE==2;
    EXPAND_INLINES_FLAG=OPTION_EXPAND_INLINES;
    INLINE_OPTION_BLOCK_FLAG=OPTION_BLOCK;
    PARSER_RESET_BYTE_B=0;
    ENUMS_AS_INT_FLAG=OPTION_ENUMS_AS_INT;
    IN_ERROR_RECOVERY=0;
    SUPPRESS_WARNINGS_DEPTH=0;
    CONDITIONAL_ARM_DEPTH=0;
    EXPR_START_FLAG_MASK=0x40;
    TOKEN_MASK=0x18;
    if(CPP_MODE) {
        EXPR_START_FLAG_MASK|=4;
        TOKEN_MASK|=0x20;
    }
    C9BANKS();
    BANK(TOKEN_STREAM_POOL_SEG).used=BANK(TOKEN_STREAM_POOL_SEG).spare=0;
    BANK(TOKEN_STREAM_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(TOKEN_STREAM_POOL_SEG),0);
    if(CPP_MODE) {
        STREAM_CREATE((unsigned int far *)&REPLAY_STREAM_1,0);
        STREAM_CREATE((unsigned int far *)&REPLAY_STREAM_2,0);
        STREAM_CREATE((unsigned int far *)&REPLAY_STREAM_3,0);
        STREAM_CREATE((unsigned int far *)&REPLAY_STREAM_4,0);
        STREAM_CREATE((unsigned int far *)&TOKEN_STREAM_HANDLE,0);
        STREAM_CREATE((unsigned int far *)&INLINE_TOKEN_STREAM,TOKEN_STREAM_HANDLE);
        TOKEN_STREAM_POS=0;
            /* Fill each entry's name with the name record of its token (from
               TOKEN_NAMES), walking down from the end; the first entry is left out. */
        for(entry=C9_TOKEN_END;entry!=(struct C9TokenName far *)C9_TOKEN_NAMES;--entry)
            entry->name=TOKEN_NAMES[entry->token];
    }
    RECORDING_TOKENS=0;
    SCOPE_STACK_DEPTH=0;
    TOKEN_RECORD_STREAM=0;
    PENDING_DEFINITION_LIST=0;
    INLINE_FUNCTION_STACK=0;
    INLINE_EXPANSION_DEPTH=0;
    VTABLE_CLASS_LIST=0;
    TOKEN_STREAM_POS=0;
    FILE_INIT_EXPR_QUEUE=0;
    TEMP_DESTRUCTOR_LIST=0;
    PENDING_INIT_LIST=0;
    TYPE_DEBUG_ID_COUNTER=0x18;
    DEBUG_CLASS_INDEX_NEXT=1;
    DEBUG_MEMBER_COUNTER=0;
    RESET_EXPR_PARSER();
    DIAG_NAME_BUFFER=0;
    CURRENT_TOKEN=0x82;
    END_OF_INPUT_SEEN=0;
    C9TYPES();
    NO_ERRORS_YET=1;
    ENUM_BODY_TREE_FLAG=0;
    ADVANCE_TOKEN();
}
