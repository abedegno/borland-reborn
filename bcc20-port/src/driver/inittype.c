/* inittype.c: from bcc20/src/driver/INITTYPE.C: the per-compile start of the parser.
   INIT_PARSER is called once per source file from the external-declaration parser before
   the first token is read.  It copies option bytes into parser flags, then:
   - C9BANKS / INITTYPE create the parser's pools (symbols, storage records, types, tag
     bodies, list cells, members, formals, labels; in C++ also the temporaries, destructor
     and base-class pools) and the global scope.  Many pools get a dummy record 0 allocated
     at once, so that offset 0 can mean "none".
   - C9TYPES builds the basic types: C9_TYPE_GRID[v][c][kind] holds every scalar kind 1..12
     in four variants (v=0 volatile, c=0 const; [1][1] is the plain type, which BCC_TYPE_PTR
     points at).  Then the common derived types (char *, void *, default function types),
     the hidden return-value parameter, the start-up helpers _setargv/_setenvp, and for C++
     the operator new/delete and vector helpers and two built-in classes: the virtual-table
     entry and the pointer-to-member layout.
   - C9TOKENS declares the pseudo-register variables _AX, _DX ... (from
     PSEUDO_REGISTER_TABLE) and C9INTRINSICS the intrinsic functions such as __abs__ and
     __emit__ (from INTRINSIC_TABLE).
   CPP_MODE is the C++ mode flag (OPTION_FLAGS bit 0); NOT_ANSI_FLAG is set when the
   language mode is not ANSI, and enables the pseudo-registers.  A pool descriptor is
   segment, spare (growth step), used and limit. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "kind.h"

#define OPTION_BLOCK B(OPTION_BLOCK_P)
#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define UNSIGNED_CHAR B(UNSIGNED_CHAR_P)
#define OPTION_CALLING_CONVENTION B(OPTION_CALLING_CONVENTION_P)
#define OPTION_UNDERSCORES B(OPTION_UNDERSCORES_P)
#define OPTION_FLAGS B(OPTION_FLAGS_P)
#define OPTION_ENUMS_AS_INT B(OPTION_ENUMS_AS_INT_P)
#define MODEL_FAR_CODE B(MODEL_FAR_CODE_P)
#define NEAR_HELPER_CALLS B(NEAR_HELPER_CALLS_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define FUNCTION_NAME_TEXT W(FUNCTION_NAME_TEXT_P)
#define REPLAY_STREAM_1 W(REPLAY_STREAM_1_P)
/* words INITTYPE.H names with their DS offsets (no globals.h entry) */
#define DEFAULT_CALL_CONVENTION W(DSPTR(0x5EBC))
#define FUNCTION_BODY_DEPTH W(DSPTR(0x5EC0))
#define LOOP_CONTEXT W(DSPTR(0x5EFD))
#define DIAG_NAME_BUFFER W(DSPTR(0x5F4E))
#define TOKEN_STREAM_POS W(DSPTR(0x617A))
/* the plain scalar types, by kind: C9_TYPE_GRID[1][1] */
#define BCC_TYPE_PTR D(BCC_TYPE_PTR_P)
#define BASIC_TYPE(kind) W(fp_add(BCC_TYPE_PTR, (kind) * 2))
#define GRID(v, c, kind) C9_TYPE_GRID_AT(((v) * 2 + (c)) * 13 + (kind))

/* a pool descriptor set up with growth step amount and its first segment */
static void init_bank(farptr bank, u16 amount)
{
    W(fp_add(bank, 2)) = amount;
    W(fp_add(bank, 4)) = amount;
    W(fp_add(bank, 6)) = 0;
    POOL_INIT(bank, amount);
}

/* creates the parser's basic pools, each with its growth step, and allocates the dummy
   record 0 in most of them (symbol entry, type, cons cell, member, formal, label) */
static void inittype(void)
{
    init_bank(CSYM_POOL_SEG_P, 10);
    STORAGE_RECORD_COUNT = 0;
    init_bank(STORAGE_POOL_SEG_P, 2);
    init_bank(SYMBOL_POOL_SEG_P, 0);
    ALLOC_SYMBOL_ENTRY(0, 0);
    init_bank(TYPE_POOL_P, 0);
    DUPLICATE_TYPE_FREE_LIST = 0;
    CREATE_TYPE(0);
    init_bank(TAG_BODY_POOL_SEG_P, 2);
    init_bank(CONS_CELL_POOL_SEG_P, 0);
    LIST_CONS(0, 0);
    W(MK_FP(CONS_CELL_POOL_SEG, 0)) = 0;
    init_bank(MEMBER_SEGMENT_P, 0);
    C9_ALLOC_MEMBER(0);
    C9_CLEAR_MEMBER_TABLES();
    init_bank(LIST_CELL_POOL_SEG_P, 0);
    LIST_CONS_ALT(0, 0);
    init_bank(FORMAL_POOL_SEG_P, 0);
    ALLOC_FORMAL_RECORD();
    W(MK_FP(FORMAL_POOL_SEG, 0)) = 0;
    init_bank(LABEL_POOL_SEG_P, 0);
    ALLOC_LABEL_RECORD();
    W(MK_FP(LABEL_POOL_SEG, 0)) = 0;
}

/* creates the pools, the global scope with its name list and tag list, the C++-only pools
   (temporaries, base paths, destructor entries, cache, initializer records, base-class list
   with its record 0 = a public non-virtual base), and resets parser state counters */
static void c9banks(void)
{
    inittype();
    u16 scope = ALLOC_SCOPE();
    GLOBAL_SCOPE = scope;
    CURRENT_SCOPE = GLOBAL_SCOPE;
    SCOPE_W(CURRENT_SCOPE, SCOPE_NEST_LEVEL) = 0;
    u16 list = ALLOC_SYMBOL_ENTRY(0, 0);
    SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES) = list;
    GLOBAL_SCOPE_NAMES = SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES);
    list = ALLOC_SYMBOL_ENTRY(0, 0);
    SCOPE_W(CURRENT_SCOPE, SCOPE_TAGS) = list;
    GLOBAL_SCOPE_TAGS = SCOPE_W(CURRENT_SCOPE, SCOPE_TAGS);
    SCOPE_B(CURRENT_SCOPE, SCOPE_IS_FUNCTION) = 0;
    if (CPP_MODE) {
        init_bank(PACKED_EXPR_POOL_SEG_P, 2);
        init_bank(BASE_PATH_POOL_SEG_P, 2);
        init_bank(TEMP_ENTRY_POOL_SEG_P, 0);
        u16 temps = ALLOC_TEMP_ENTRY();
        SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) = temps;
        TDTOR_W(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), TDTOR_NEXT) = 0;
        TDTOR_W(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), TDTOR_SERIAL) = 0;
        TDTOR_W(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), TDTOR_EXPR) = 0;
        DESTRUCTOR_ENTRY_SERIAL = 1;
        init_bank(CACHE_POOL_P, 2);
        CACHE_HEAD = 0;
    }
    TEMP_NAME_COUNTER = 0;
    DIAG_FUNC_NAME_HIGH = 0;
    FUNCTION_NAME_TEXT = 0;
    CURRENT_LINKAGE = 0;
    init_bank(LINKAGE_STACK_POOL_SEG_P, 2);
    LINKAGE_STACK = 0;
    CURRENT_CLASS_TYPE = 0;
    BCC_TREE_FLAG = 0;
    PARAM_LIST_DEPTH = 0;
    INLINE_BODY_QUEUE = 0;
    FUNCTION_BODY_DEPTH = 0;
    RTL_MEMSET(BCC_TREE_SPECIAL_P, 0, 0x50);
    LOOP_NEST_FACTOR = 1;
    CTOR_DTOR_MODE = 0;
    if (CPP_MODE) {
        SWITCH_STATE_SCOPE = SCOPE_W(GLOBAL_SCOPE, SCOPE_TEMPS);
        LOOP_CONTEXT = SCOPE_W(GLOBAL_SCOPE, SCOPE_TEMPS);
        LOOP_BREAK_SCOPE = SCOPE_W(GLOBAL_SCOPE, SCOPE_TEMPS);
    }
    STMT_NO_GOTO_OR_LABEL_FLAG = 1;
    LOOP_NEST_FACTOR = 1;
    if (CPP_MODE) {
        init_bank(INIT_RECORD_POOL_SEG_P, 2);
        init_bank(BASE_LIST_SEG_P, 0);
        POOL_ALLOC_REUSE(BASE_LIST_SEG_P, 9);
        BASE_W(0, BASE_NEXT) = 0;
        BASE_W(0, BASE_TYPE) = 0;
        BASE_W(0, BASE_OFFSET) = 0;
        BASE_B(0, BASE_PUBLIC) = 1;
        BASE_B(0, BASE_VIRTUAL) = 0;
    }
}

/* the scalar type of kind with its debugger type id; constant 0 makes it const
   (TYPE_ATTRS |= 1), changeable 0 volatile (TYPE_ATTRS |= 2) */
static u16 c9scalar(u16 kind, u16 changeable, u16 constant)
{
    u16 type = CREATE_TYPE(kind);
    SET_TYPE_DEBUG_ID(type, C9_TYPE_SIZES_AT(kind));
    if (!constant)
        TYPE_B(type, TYPE_ATTRS) |= 1;
    if (!changeable)
        TYPE_B(type, TYPE_ATTRS) |= 2;
    return type;
}

/* the pointer-to-type type of pointer kind kind (13 near, 15 far).  kind 0 means the
   model's default: for a function, far if MODEL_FAR_CODE; for data, far if MODEL_FAR_DATA.
   FIND_EQUIVALENT_TYPE returns an existing identical type if one exists */
static u16 c9pointer(u16 type, u16 kind)
{
    if (!kind) {
        u8 flag = TYPE_W(type, TYPE_KIND) == TK_FUNCTION ? MODEL_FAR_CODE : MODEL_FAR_DATA;
        kind = flag ? 15 : 13;
    }
    u16 result = CREATE_TYPE(kind);
    TYPE_W(result, TYPE_TARGET) = type;
    TYPE_B(result, TYPE_PTR_MODE) = TYPE_W(type, TYPE_KIND) == TK_FUNCTION ? 2 : 4;
    TYPE_W(result, TYPE_PARAMS) = 0;
    return FIND_EQUIVALENT_TYPE(result);
}

/* a formal-parameter record of type type in front of the list next */
static u16 c9parameter(u16 next, u16 type)
{
    u16 result = ALLOC_FORMAL_RECORD();
    FORMAL_W(result, FORMAL_NEXT) = next;
    FORMAL_W(result, FORMAL_TYPE) = type;
    return result;
}

/* a function type returning result with parameter list parameters, calling convention
   convention (1 cdecl, 2 pascal, 3 the third convention option) and the TYPE_FUNC_FLAGS
   byte flags: 1 far, 40h near; if neither is given the model decides.  Flag 8 marks
   functions declared without parameters here, probably meaning "no prototype" */
static u16 c9function(u16 result, u16 parameters, u16 flags, u16 convention)
{
    u16 type = CREATE_TYPE(0x12);
    TYPE_W(type, TYPE_TARGET) = result;
    TYPE_W(type, TYPE_PARAMS) = parameters;
    TYPE_B(type, TYPE_FUNC_FLAGS) = (u8)flags;
    if (!(flags & 0x41))
        TYPE_B(type, TYPE_FUNC_FLAGS) |= MODEL_FAR_CODE ? 1 : 0x40;
    TYPE_B(type, TYPE_CALL_CONV) = (u8)convention;
    return type;
}

/* declares a global function name used by generated code (start-up helpers, new, delete,
   vector helpers) with up to two parameter types first, second, result type result and
   function flags flags.  In C++ source is stored as the symbol's linkage */
static u16 c9builtin(farptr name, u16 category, u16 source, u16 flags, u16 result, u16 first, u16 second)
{
    u16 parameters = 0;
    if (second)
        parameters = c9parameter(parameters, second);
    if (first)
        parameters = c9parameter(parameters, first);
    u16 type = c9function(result, parameters, flags | (first == 0 ? 8 : 0), 1);
    u16 symbol = DECLARE_GLOBAL_SYMBOL(name, type, 0, category);
    SYM_B(symbol, SYM_FLAGS) |= (TYPE_B(type, TYPE_FUNC_FLAGS) & 1) ? 0x80 : 0;
    if (CPP_MODE)
        SYM_W(symbol, SYM_LINKAGE) = source;
    return symbol;
}

/* an empty struct type for a built-in class, made STRUCT_BODY_TYPE, the class c9member adds
   to.  In C++ the class gets flag 2 and a far (8) or near (10h) flag after the data model */
static u16 c9class(void)
{
    u16 type = CREATE_TYPE(0x13);
    STRUCT_BODY_TYPE = type;
    SCOPE_STATE = 0;
    if (CPP_MODE) {
        TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) |= 2;
        TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) |= MODEL_FAR_DATA ? 8 : 0x10;
    }
    return type;
}

/* the global symbol called name, made with type type if it does not exist yet (the
   pseudo-registers and the string-literal symbol) */
static u16 c9named(u16 name, u16 type)
{
    u16 key = BCC_SYMBOL_CREATE(DSPTR(name), 0);
    u16 symbol = FIND_NAME_IN_LIST(key, SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES));
    if (symbol)
        return symbol;
    symbol = ALLOC_SYMBOL_ENTRY(key, 5);
    SYM_W(symbol, SYM_TYPE) = type;
    SYM_W(symbol, SYM_NEXT) = NAME_W(SYM_W(symbol, SYM_NAME), NAME_SYMBOLS);
    NAME_W(SYM_W(symbol, SYM_NAME), NAME_SYMBOLS) = symbol;
    SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 0x18;
    SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 0xF8) | 1;
    SYM_B(symbol, SYM_FLAGS) = 7;
    return symbol;
}

/* appends member name of type type at the end of STRUCT_BODY_TYPE and grows the class
   size; callers move some members back afterwards to make unions */
static u16 c9member(u16 type, farptr name)
{
    u16 member = DECLARE_MEMBER(BCC_SYMBOL_CREATE(name, 0), 0);
    u16 body = TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY);
    MEMBER_W(member, MEMB_TYPE) = type;
    MEMBER_W(member, MEMB_VALUE) = TAG_W(body, TAG_SIZE);
    MEMBER_W(member, MEMB_CLASS) = STRUCT_BODY_TYPE;
    TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_SIZE) += (u16)TYPE_SIZE(type);
    TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_OWN_SIZE) = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_SIZE);
    return member;
}

/* declares each pseudo-register variable of PSEUDO_REGISTER_TABLE (7-byte entries: near
   name, register number, type kind, debugger code) as a register-class symbol of its type;
   the register number is given to the back end as the symbol's offset */
static void c9tokens(void)
{
    for (farptr entry = PSEUDO_REGISTER_TABLE_P; W(entry); entry = fp_add(entry, 7)) {
        u16 symbol = c9named(W(entry), BASIC_TYPE(SB(fp_add(entry, 4))));
        SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 0x38;
        SYM_B(symbol, SYM_FLAGS) = 0x0E;
        u16 expression = PREPARE_SYMBOL(symbol);
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(expression), A16(0));
        CALL_FAR(SET_SYMBOL_OFFSET_HOOK, A16(expression), A16(W(fp_add(entry, 2))));
    }
}

/* declares each intrinsic function of INTRINSIC_TABLE (10-byte entries: near name, result
   kind, -, parameter count, -, four parameter kinds) that the program has not already
   declared; SYM_INTRINSIC_NUM is its index in the table.  __emit__ gets a void function
   type and is remembered in EMIT_INTRINSIC_SYMBOL.  Pointer parameter and result kinds in
   the table are replaced by the model's default data pointer kind */
static void c9intrinsics(void)
{
    i16 number = 0;
    for (farptr entry = INTRINSIC_TABLE_P; W(entry); entry = fp_add(entry, 10), ++number) {
        farptr name = DSPTR(W(entry));
        u16 key = BCC_SYMBOL_CREATE(name, 0);
        if (FIND_NAME_IN_LIST(key, SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES)))
            continue;
        u16 symbol = BCC_TYPE_CREATE(key, 7);
        SYM_B(symbol, SYM_STORAGE_CLASS) = (SYM_B(symbol, SYM_STORAGE_CLASS) & 7) | 0x50;
        SYM_B(symbol, SYM_INLINE_ACCESS) = (SYM_B(symbol, SYM_INLINE_ACCESS) & 0xFC) | 3;
        SYM_W(symbol, SYM_INTRINSIC_NUM) = number;
        if (COMPARE_NAME(name, STR___EMIT___P) == 0) {
            EMIT_INTRINSIC_SYMBOL = symbol;
            u16 type = c9function(VOID_TYPE, 0, 4, 1);
            SYM_W(symbol, SYM_TYPE) = type;
        }
        for (i16 parameter = 0; parameter < SB(fp_add(entry, 4)); ++parameter)
            if (EXPR_FLAGS_AT(SB(fp_add(entry, 6 + parameter))) & 0x14)
                SB(fp_add(entry, 6 + parameter)) = MODEL_FAR_DATA ? 15 : 13;
        if (EXPR_FLAGS_AT(SB(fp_add(entry, 2))) & 0x14)
            SB(fp_add(entry, 2)) = MODEL_FAR_DATA ? 15 : 13;
    }
}

/* the type size of TYPE_SIZE(type) taken as a word, as the original stores it */
static u16 size16(u16 type) { return (u16)TYPE_SIZE(type); }

/* builds the basic and derived types and the built-in symbols (see the overview).  In the
   middle it loads the precompiled header if any, reads the first token and starts the back
   end's output, so the types after that point see what the header defined */
static void c9types(void)
{
    INT_TYPE_SIZE = 2;
    BCC_TYPE_PTR = fp_add(C9_TYPE_GRID_P, (1 * 2 + 1) * 13 * 2);
    for (i16 first = 0; first <= 1; ++first)
        for (i16 second = 0; second <= 1; ++second) {
            GRID(first, second, 0) = 0;
            for (i16 kind = 1; kind <= 12; ++kind) {
                u16 type = c9scalar(kind, first, second);
                GRID(first, second, kind) = type;
            }
        }
    PLAIN_CHAR_KIND = UNSIGNED_CHAR ? 2 : 1;
    CHAR_TYPE = BASIC_TYPE(PLAIN_CHAR_KIND);
    PLAIN_CHAR_TYPE = CHAR_TYPE;
    INT_TYPE = BASIC_TYPE(5);
    INT_TYPE_SIZE = size16(INT_TYPE);
    LONG_TYPE = BASIC_TYPE(7);
    SHORT_TYPE = BASIC_TYPE(3);
    DOUBLE_TYPE = BASIC_TYPE(10);
    DOUBLE_TYPE_SIZE = size16(DOUBLE_TYPE);
    VOID_TYPE = BASIC_TYPE(12);
    SIZE_T_TYPE = UNSIGNED_INT_TYPE;
    TRY_PCH_LOAD();
    LEX_NEXT_TOKEN();
    CALL_FAR0(BEGIN_BACKEND_OUTPUT_HOOK);
    PTRDIFF_TYPE = MODEL_FAR_DATA ? LONG_TYPE : INT_TYPE;
    CHAR_POINTER_TYPE = c9pointer(CHAR_TYPE, 0);
    STRING_LITERAL_SYMBOL = c9named(FP_OFF(STR_S_2_P), INT_TYPE);
    PREPARE_SYMBOL(STRING_LITERAL_SYMBOL);
    if (OPTION_CALLING_CONVENTION == 1)
        DEFAULT_CALL_CONVENTION = 2;
    else if (OPTION_CALLING_CONVENTION == 2)
        DEFAULT_CALL_CONVENTION = 3;
    else
        DEFAULT_CALL_CONVENTION = 1;
    HIDDEN_RETURN_PARAM_RECORD = ALLOC_FORMAL_RECORD();
    FORMAL_W(HIDDEN_RETURN_PARAM_RECORD, FORMAL_NEXT) = 0;
    FORMAL_W(HIDDEN_RETURN_PARAM_RECORD, FORMAL_TYPE) = 0;
    FORMAL_W(HIDDEN_RETURN_PARAM_RECORD, FORMAL_NAME) = HIDDEN_RETURN_PARAM_NAME;
    FORMAL_B(HIDDEN_RETURN_PARAM_RECORD, FORMAL_IMPLICIT) = 0;
    VOID_POINTER_TYPE = c9pointer(VOID_TYPE, 0);
    FAR_VOID_PTR_TYPE = c9pointer(VOID_TYPE, 15);
    IMPLICIT_FUNC_TYPE = c9function(INT_TYPE, 0, 8, DEFAULT_CALL_CONVENTION);
    INT_FAR_FUNC_TYPE = c9function(INT_TYPE, 0, 1, DEFAULT_CALL_CONVENTION);
    INT_NEAR_FUNC_TYPE = c9function(INT_TYPE, 0, 0x40, DEFAULT_CALL_CONVENTION);
    VOID_NOARG_FUNC_TYPE = c9function(VOID_TYPE, 0, 8, DEFAULT_CALL_CONVENTION);
    RUNTIME_HELPER_FUNC_TYPE = c9function(INT_TYPE, 0, 8 | (NEAR_HELPER_CALLS ? 0x40 : 1), DEFAULT_CALL_CONVENTION);
    IMPLICIT_FUNC_PTR_TYPE = c9pointer(IMPLICIT_FUNC_TYPE, 0);
    INT_NEAR_FUNC_PTR_TYPE = c9pointer(INT_NEAR_FUNC_TYPE, 13);
    INT_FAR_FUNC_PTR_TYPE = c9pointer(INT_FAR_FUNC_TYPE, 15);
    MAIN_SYMBOL = BCC_SYMBOL_CREATE(STR_MAIN_2_P, 0x31);
    SETARGV_SYMBOL = c9builtin(OPTION_UNDERSCORES ? STR__SETARGV___P : STR___SETARGV___P, 0, 2, 0, VOID_TYPE, 0, 0);
    SETENVP_SYMBOL = c9builtin(OPTION_UNDERSCORES ? STR__SETENVP___P : STR___SETENVP___P, 0, 2, 0, VOID_TYPE, 0, 0);
    if (CPP_MODE) {
        NEW_OPERATOR_SYMBOL = c9builtin(STR_NEW_P, 1, 1, 0, VOID_POINTER_TYPE, SIZE_T_TYPE, 0);
        VECTOR_NEW_SYMBOL = c9builtin(STR__VECTOR_NEW__P, 0, 2, 0, FAR_VOID_PTR_TYPE, 0, 0);
        VECTOR_VNEW_SYMBOL = c9builtin(STR__VECTOR_VNEW__P, 0, 2, 0, FAR_VOID_PTR_TYPE, 0, 0);
        DELETE_OPERATOR_SYMBOL = c9builtin(STR_DELETE_P, 1, 1, 0, VOID_TYPE, VOID_POINTER_TYPE, 0);
        VECTOR_DELETE_SYMBOL = c9builtin(STR__VECTOR_DELETE__P, 0, 2, 0, VOID_TYPE, 0, 0);
        VECTOR_APPLY_SYMBOL = c9builtin(STR__VECTOR_APPLY__P, 0, 2, 0, VOID_TYPE, 0, 0);
        VECTOR_VAPPLY_SYMBOL = c9builtin(STR__VECTOR_VAPPLY__P, 0, 2, 0, VOID_TYPE, 0, 0);
        FAR_PURE_ERROR_SYMBOL = c9builtin(STR__FPURE_ERROR__P, 0, 2, 1, VOID_TYPE, 0, 0);
        NEAR_PURE_ERROR_SYMBOL = c9builtin(STR__NPURE_ERROR__P, 0, 2, 0x40, VOID_TYPE, 0, 0);
        /* the virtual-table entry: a far and a near function pointer at the same offset (a
           union), sized as the far one */
        VTABLE_ENTRY_CLASS_TYPE = c9class();
        VTABLE_FAR_FUNC_MEMBER = c9member(INT_FAR_FUNC_PTR_TYPE, STR_FAR_FUNC_P);
        VTABLE_NEAR_FUNC_MEMBER = c9member(INT_NEAR_FUNC_PTR_TYPE, STR_NEAR_FUNC_P);
        MEMBER_W(VTABLE_NEAR_FUNC_MEMBER, MEMB_VALUE) = MEMBER_W(VTABLE_FAR_FUNC_MEMBER, MEMB_VALUE);
        TAG_W(TYPE_W(VTABLE_ENTRY_CLASS_TYPE, TYPE_TAG_BODY), TAG_SIZE) -= size16(INT_NEAR_FUNC_PTR_TYPE);
        TAG_W(TYPE_W(VTABLE_ENTRY_CLASS_TYPE, TYPE_TAG_BODY), TAG_OWN_SIZE) = TAG_W(TYPE_W(VTABLE_ENTRY_CLASS_TYPE, TYPE_TAG_BODY), TAG_SIZE);
        /* the pointer-to-member layout: delta, vindex, then a function pointer (far or
           near) overlaid on offset/pad */
        MEMBER_PTR_CLASS_TYPE = c9class();
        MEMBER_PTR_DELTA_MEMBER = c9member(INT_TYPE, STR_DELTA_P);
        MEMBER_PTR_VINDEX_MEMBER = c9member(INT_TYPE, STR_VINDEX_P);
        MEMBER_PTR_OFFSET_MEMBER = c9member(SHORT_TYPE, STR_OFFSET_P);
        MEMBER_PTR_PAD_MEMBER = c9member(SHORT_TYPE, STR_PAD_P);
        MEMBER_PTR_FAR_FUNC_MEMBER = c9member(INT_FAR_FUNC_PTR_TYPE, STR_FAR_FUNC_P);
        MEMBER_W(MEMBER_PTR_FAR_FUNC_MEMBER, MEMB_VALUE) = MEMBER_W(MEMBER_PTR_OFFSET_MEMBER, MEMB_VALUE);
        TAG_W(TYPE_W(MEMBER_PTR_CLASS_TYPE, TYPE_TAG_BODY), TAG_SIZE) -= size16(INT_FAR_FUNC_PTR_TYPE);
        MEMBER_PTR_NEAR_FUNC_MEMBER = c9member(INT_NEAR_FUNC_PTR_TYPE, STR_NEAR_FUNC_P);
        MEMBER_W(MEMBER_PTR_NEAR_FUNC_MEMBER, MEMB_VALUE) = MEMBER_W(MEMBER_PTR_OFFSET_MEMBER, MEMB_VALUE);
        TAG_W(TYPE_W(MEMBER_PTR_CLASS_TYPE, TYPE_TAG_BODY), TAG_SIZE) -= size16(INT_NEAR_FUNC_PTR_TYPE);
        TAG_W(TYPE_W(MEMBER_PTR_CLASS_TYPE, TYPE_TAG_BODY), TAG_OWN_SIZE) = TAG_W(TYPE_W(MEMBER_PTR_CLASS_TYPE, TYPE_TAG_BODY), TAG_SIZE);
        FAR_CHAR_POINTER_TYPE = c9pointer(CHAR_TYPE, 15);
        FAR_VTABLE_ENTRY_PTR_TYPE = c9pointer(VTABLE_ENTRY_CLASS_TYPE, 15);
        if (OPTION_MEMORY_MODEL == 5 || OPTION_FLAG) {
            TYPE_LOCAL = FAR_CHAR_POINTER_TYPE;
            VTABLE_ENTRY_PTR_TYPE = FAR_VTABLE_ENTRY_PTR_TYPE;
        } else {
            TYPE_LOCAL = c9pointer(CHAR_TYPE, 13);
            VTABLE_ENTRY_PTR_TYPE = c9pointer(VTABLE_ENTRY_CLASS_TYPE, 13);
        }
    } else {
        NEW_OPERATOR_SYMBOL = 0;
        VECTOR_NEW_SYMBOL = 0;
        DELETE_OPERATOR_SYMBOL = 0;
        VECTOR_DELETE_SYMBOL = 0;
        VTABLE_ENTRY_CLASS_TYPE = 0;
        NON_CPP_CLEARED_WORD_A = 0;
        NON_CPP_CLEARED_WORD_B = 0;
        VTABLE_FAR_FUNC_MEMBER = 0;
        MEMBER_PTR_CLASS_TYPE = 0;
        MEMBER_PTR_OFFSET_MEMBER = 0;
        MEMBER_PTR_VINDEX_MEMBER = 0;
        MEMBER_PTR_FAR_FUNC_MEMBER = 0;
        MEMBER_PTR_DELTA_MEMBER = 0;
    }
    if (CPP_MODE || NOT_ANSI_FLAG)
        c9tokens();
    EMIT_INTRINSIC_SYMBOL = 0;
    c9intrinsics();
}

/* the file's only exported entry; see the overview.  Ends by reading the first token, so
   the parser can start */
void INIT_PARSER(void)
{
    PARSER_INIT_MARK_A5 = 0xA5;
    CPP_MODE = OPTION_FLAGS & 1;
    NOT_ANSI_FLAG = LANGUAGE_MODE != 1;
    PARSER_RESET_BYTE_A = 0;
    CPU_LEVEL_1_FLAG = VTABLE_MODE == 1;
    CPU_IS_286 = VTABLE_MODE == 2;
    EXPAND_INLINES_FLAG = OPTION_EXPAND_INLINES;
    INLINE_OPTION_BLOCK_FLAG = OPTION_BLOCK;
    PARSER_RESET_BYTE_B = 0;
    ENUMS_AS_INT_FLAG = OPTION_ENUMS_AS_INT;
    IN_ERROR_RECOVERY = 0;
    SUPPRESS_WARNINGS_DEPTH = 0;
    CONDITIONAL_ARM_DEPTH = 0;
    EXPR_START_FLAG_MASK = 0x40;
    TOKEN_MASK = 0x18;
    if (CPP_MODE) {
        EXPR_START_FLAG_MASK |= 4;
        TOKEN_MASK |= 0x20;
    }
    c9banks();
    init_bank(TOKEN_STREAM_POOL_SEG_P, 0);
    if (CPP_MODE) {
        STREAM_CREATE(REPLAY_STREAM_1_P, 0);
        STREAM_CREATE(REPLAY_STREAM_2_P, 0);
        STREAM_CREATE(REPLAY_STREAM_3_P, 0);
        STREAM_CREATE(REPLAY_STREAM_4_P, 0);
        STREAM_CREATE(TOKEN_STREAM_HANDLE_P, 0);
        STREAM_CREATE(INLINE_TOKEN_STREAM_P, TOKEN_STREAM_HANDLE);
        TOKEN_STREAM_POS = 0;
        /* each entry's name filled with the name record of its token, walking down from the
           end; the first entry is left out */
        for (farptr entry = D(C9_TOKEN_END_P); entry != C9_TOKEN_NAMES_P; entry = fp_add(entry, -4))
            W(entry) = TOKEN_NAMES_AT(W(fp_add(entry, 2)));
    }
    RECORDING_TOKENS = 0;
    SCOPE_STACK_DEPTH = 0;
    TOKEN_RECORD_STREAM = 0;
    PENDING_DEFINITION_LIST = 0;
    INLINE_FUNCTION_STACK = 0;
    INLINE_EXPANSION_DEPTH = 0;
    VTABLE_CLASS_LIST = 0;
    TOKEN_STREAM_POS = 0;
    FILE_INIT_EXPR_QUEUE = 0;
    TEMP_DESTRUCTOR_LIST = 0;
    PENDING_INIT_LIST = 0;
    TYPE_DEBUG_ID_COUNTER = 0x18;
    DEBUG_CLASS_INDEX_NEXT = 1;
    DEBUG_MEMBER_COUNTER = 0;
    RESET_EXPR_PARSER();
    DIAG_NAME_BUFFER = 0;
    CURRENT_TOKEN = 0x82;
    END_OF_INPUT_SEEN = 0;
    c9types();
    NO_ERRORS_YET = 1;
    ENUM_BODY_TREE_FLAG = 0;
    ADVANCE_TOKEN();
}
