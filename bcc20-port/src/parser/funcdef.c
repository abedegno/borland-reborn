/* funcdef.c: from bcc20/src/parser/FUNCDEF.C: function definitions in the C++ front end
   (which also compiles C when CPP_MODE is clear).  COMPILE_FUNCTION_DEFINITION reads
   old-style (K&R) parameter declarations if the function type has none, declares or
   finds the function symbol, and either records the body for later (inline functions) or
   compiles it: BEGIN_FUNCTION_BODY opens the function scope and declares the parameters
   (with a hidden pointer parameter for a returned struct), the statement parser reads the
   body, and END_FUNCTION_BODY closes it and finishes the function.  BCC_TREE_SPECIAL is
   the 80-byte per-function state (its first word the function symbol), cleared at the
   start of every body.  Declaration specifier triples (struct C27Spec: three signed bytes)
   and the other outputs of the declaration parsers live in the scratch area. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define T(n, o) TYPE_W((n), (o))
#define TB(n, o) TYPE_B((n), (o))
#define SW_(n, o) SYM_W((n), (o))
#define SB_(n, o) SYM_B((n), (o))
#define P(n, o) W(MK_FP(FORMAL_POOL_SEG, (n) + (o)))
#define PB(n, o) B(MK_FP(FORMAL_POOL_SEG, (n) + (o)))
#define CW(n, o) W(MK_FP(SCOPE_POOL_SEG, (n) + (o)))
#define LINK(n, o) W(MK_FP(TAG_BODY_POOL_SEG, (n) + (o)))
#define CACHE(n, o) W(MK_FP(CACHE_POOL, (n) + (o)))
#define FUNCTION_NAME_TEXT D(FUNCTION_NAME_TEXT_P)
#define PRAGMA_SAVEREGS_PENDING B(PRAGMA_SAVEREGS_PENDING_P)
#define PRAGMA_ARGSUSED_PENDING B(PRAGMA_ARGSUSED_PENDING_P)
#define FUNCTION_DEF_POSITION D(FUNCTION_DEF_POSITION_P)
#define FUNCTION_BODY_DEPTH W(FUNCTION_BODY_DEPTH_P)
#define LOOP_CONTEXT W(LOOP_CONTEXT_P)
#define TREE_ROOT W(BCC_TREE_SPECIAL_P)         /* BCC_TREE_SPECIAL's first word: the function */
#define RETURN_FORM_SEEN W(RETURN_FORM_SEEN_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)

static u16 peek_kind(void)
{
    PEEK_TOKEN();
    return W(TOKEN_TYPE_P);
}

static void copy3(farptr to, farptr from)
{
    for (int i = 0; i < 3; i++)
        B(fp_add(to, i)) = B(fp_add(from, i));
}

/* the parameter declarations between an old-style declarator and the body ("f(a, b) int
   a; char *b; {"): each name must be in the function type's parameter list, its type
   stored there and adjusted as C requires (float to double, a function or array to a
   pointer).  Only register (38h) and, with relaxed checks, typedef are allowed as storage
   classes.  Parameters never declared get INT_TYPE.  Function flag 8 is set */
void PARSE_KR_PARAMETERS(u16 function)
{
    /* the locals in the original frame's layout (from BP-1Ch): the replay maps a window
       around each pointer passed, so their relative places must be kept */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x1C);
    farptr modifier2 = v, modifier1 = fp_add(v, 1), scratch = fp_add(v, 2), declaration = fp_add(v, 6);
    farptr spec = fp_add(v, 0x0A), owner = fp_add(v, 0x0E), scope = fp_add(v, 0x10), named = fp_add(v, 0x13);
    farptr name = fp_add(v, 0x14), type = fp_add(v, 0x16), initial = fp_add(v, 0x18), kind = fp_add(v, 0x1A);
    TB(function, 12) |= 8;
    while (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) && peek_kind() != 0x67) {
        W(initial) = INT_TYPE;
        PARSE_DECL_SPECIFIERS(0, kind, modifier1, modifier2, initial, spec, named);
        if (W(kind) != 0x82 && W(kind) != 0x38 && (!NOT_ANSI_FLAG || W(kind) != 0x37))
            REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, (i32)NAME_TEXT_COPY(TOKEN_NAMES_AT(W(kind))), 0);
        while (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) {
            copy3(declaration, spec);
            PARSE_DECLARATOR(W(initial), 0, type, name, scope, owner, declaration, scratch);
            if (W(owner))
                REPORT_NAME_DIAGNOSTIC(MSG_TYPE_QUALIFIER_MUST, W(name));
            if (!W(name) || W(scope))
                REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
            else if (W(kind) == 0x37)
                DECLARE_TYPEDEF(W(type), B(fp_add(declaration, 2)), W(declaration), W(name));
            else {
                u16 t = W(type);
                if ((EXPR_FLAGS_AT(T(t, 0)) & 2) && (i16)T(t, 0) < 10)
                    t = DOUBLE_TYPE;
                else if (T(t, 0) == 0x12)
                    t = MAKE_POINTER_TYPE(t, 0, 0);
                else if (T(t, 0) == 0x11)
                    t = MAKE_POINTER_TYPE(T(t, 7), (TB(t, 2) & 0x40) ? 0x10 : 0, 0);
                /* the record at offset 0 of the pool ends the list with the name planted
                   in it, so the search always stops; reaching it means "no parameter" */
                P(0, 4) = W(name);
                u16 parameter = T(function, 9);
                while (P(parameter, 4) != W(name))
                    parameter = P(parameter, 0);
                if (!parameter)
                    REPORT_NAME_DIAGNOSTIC(MSG_NOT_PARAMETER, W(name));
                else {
                    if (!P(parameter, 2))
                        P(parameter, 2) = t;
                    else
                        REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, W(name));
                    PB(parameter, 6) = W(kind) == 0x38;
                }
            }
            if (CURRENT_TOKEN == TOK_COMMA) {
                ADVANCE_TOKEN();
                if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10)) {
                    REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
                    IN_ERROR_RECOVERY = 1;
                    ADVANCE_TOKEN();
                    SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
                }
            } else if (CURRENT_TOKEN != TOK_SEMICOLON)
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
        }
        REQUIRE_TOKEN_BODY(7, 0x1F);
    }
    scratch_release(mark);
    for (u16 parameter = T(function, 9); parameter; parameter = P(parameter, 0))
        if (!P(parameter, 2))
            P(parameter, 2) = INT_TYPE;
}

/* a function definition whose declarator has just been read.  type the function type;
   owner the class of a member function defined outside its class (else 0); name; category
   (3 constructor, 4 destructor, else ordinary); code the storage class or inline token
   (35h static, 6Bh inline); flag and deferred for BCC_TYPE_NORMALIZE.  A body defined
   twice is an error.  An inline function's body is recorded and compiled later; others
   now, constructors and destructors through their own routines.  After a syntax error in
   the body, tokens are skipped up to something that can start a declaration */
void COMPILE_FUNCTION_DEFINITION(u16 type, u16 owner, u16 name, u16 category, u16 code, u8 flag, u8 deferred)
{
    u16 saved_pool = PARAM_SCOPE_MARK;
    if (TB(type, 2) & 0x40) {
        PARSE_KR_PARAMETERS(type);
        if (CURRENT_TOKEN != TOK_LBRACE) {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
            IN_ERROR_RECOVERY = 1;
            do {
                SKIP_TO_SYNC_TOKEN(TOK_LBRACE);
                if (CURRENT_TOKEN == TOK_SEMICOLON)
                    ADVANCE_TOKEN();
            } while (CURRENT_TOKEN == TOK_SEMICOLON);
        }
    }
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);        /* category, symbol, valid */
    farptr p_category = v, p_symbol = fp_add(v, 2), p_valid = fp_add(v, 4);
    W(p_category) = category;
    CURRENT_CLASS_TYPE = owner;
    if (owner && !deferred)
        BCC_TYPE_NORMALIZE(owner, type, name, p_category, flag);
    category = W(p_category);
    u16 symbol;
    if (!CURRENT_CLASS_TYPE)
        symbol = 0;
    else {
        if (code == 0x35 && !INLINE_FUNCTION_STACK)
            REPORT_DIAGNOSTIC(0x102, (i32)C27_STATIC_TEXT_P, 0);
        symbol = TYPE_BUILD(CURRENT_CLASS_TYPE, type, name, category);
    }
    if (!symbol) {
        W(p_symbol) = symbol;
        DECLARE_FUNCTION(type, name, category, code, p_symbol, p_valid);
        symbol = W(p_symbol);
    }
    scratch_release(mark);
    if (SB_(symbol, 6) & 2)
        REPORT_CURRENT_TOKEN(MSG_BODY_HAS_ALREADY_BEEN);
    W(DIAG_NAME_BUFFER_P) = 0;
    FUNCTION_NAME_TEXT = NAME_TEXT_COPY(SW_(symbol, 2));
    if (NO_ERRORS_YET && PRAGMA_SAVEREGS_PENDING) {
        TB(type, 12) |= 0x20;
        PRAGMA_SAVEREGS_PENDING = 0;
    }
    SB_(symbol, 6) |= 3;
    if ((SB_(symbol, 7) >> 3) == 2)
        SB_(symbol, 7) = (SB_(symbol, 7) & 7) | 8;
    if (code == 0x6B) {
        if (SB_(symbol, 6) & 4)
            REPORT_CURRENT_TOKEN(MSG_FUNCTION_DEFINED);
        RECORD_INLINE_BODY(symbol);
        COMPILE_INLINE_BODY(symbol, 0);
    } else {
        if (NO_ERRORS_YET) {
            u16 prepared = PREPARE_SYMBOL(symbol);
            if (VTABLE_MODE != 3 || (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(prepared)) == 0xFFFF)
                CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(CODE_SEGMENT_ID));
        }
        BEGIN_FUNCTION_BODY(symbol, type);
        CW(CURRENT_SCOPE, 2) = BLOCK_NEST_LEVEL + 1;
        if (!CURRENT_CLASS_TYPE) {
            if (category == 3 && CURRENT_TOKEN == TOK_COLON)
                while (CURRENT_TOKEN != TOK_LBRACE && CURRENT_TOKEN != 0)
                    ADVANCE_TOKEN();
            PARSE_FUNCTION_BODY();
        } else if (category == 3)
            COMPILE_CONSTRUCTOR();
        else if (category == 4)
            COMPILE_DESTRUCTOR();
        else
            PARSE_FUNCTION_BODY();
        END_FUNCTION_BODY();
        if (CURRENT_TOKEN == TOK_RBRACE)
            ADVANCE_TOKEN();
        else {
            REPORT_CURRENT_TOKEN(MSG_COMPOUND_STATEMENT);
            IN_ERROR_RECOVERY = 1;
            while (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 8) && !(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) && CURRENT_TOKEN != 0)
                ADVANCE_TOKEN();
        }
    }
    PARAM_SCOPE_MARK_AUX = 0;
    PARAM_SCOPE_MARK = saved_pool;
    FUNCTION_NAME_TEXT = 0;
}

/* each parameter of the list declared a local of the function scope (storage class 6).
   In C a parameter without a name is an error.  In C++ a parameter of a class type with a
   copy constructor (attribute 4) is passed by address: a pointer type and flag 20h.
   #pragma argsused (or a compiler-added parameter) marks them used.  existing nonzero skips
   REGISTER_SYMBOL_VARIABLE.  The members of an anonymous union parameter go into the scope
   too */
void DECLARE_PARAMETERS(u16 parameter, u8 existing)
{
    i16 position = 0;
    for (; parameter; parameter = P(parameter, 0)) {
        ++position;
        if (!CPP_MODE && !P(parameter, 4))
            REPORT_DIAGNOSTIC(MSG_PARAMETER_D_MISSING, position, 0);
        u16 symbol = BCC_TYPE_CREATE(P(parameter, 4), 5);
        SB_(symbol, 6) |= 2;
        if (PRAGMA_ARGSUSED_PENDING || (CPP_MODE && PB(parameter, 7)))
            SB_(symbol, 6) |= 4;
        if (CPP_MODE && (EXPR_FLAGS_AT(T(P(parameter, 2), 0)) & 0x40) && (TB(P(parameter, 2), 2) & 4)) {
            u16 pointer = MAKE_POINTER_TYPE(P(parameter, 2), 0, 1);
            SW_(symbol, 4) = pointer;
            SB_(symbol, 6) |= 0x20;
        } else
            SW_(symbol, 4) = P(parameter, 2);
        SB_(symbol, 7) = (SB_(symbol, 7) & 7) | 0x30;
        SW_(symbol, 8) = 0;
        if (PB(parameter, 6))
            SB_(symbol, 6) |= 8;
        if (!existing)
            REGISTER_SYMBOL_VARIABLE(symbol);
        u16 type = P(parameter, 2);
        while (EXPR_FLAGS_AT(T(type, 0)) & 0x14)
            type = T(type, 7);
        if (T(type, 0) == 0x15 && (TB(type, 2) & 0x20))
            for (symbol = LINK(T(type, 5), 2); symbol; symbol = SW_(symbol, 10)) {
                SW_(symbol, 0) = CW(CURRENT_SCOPE, 4);
                CW(CURRENT_SCOPE, 4) = symbol;
            }
    }
}

/* a function returning a struct gets a hidden first parameter, a far pointer to where the
   result goes, unless the struct is 1, 2 or 4 bytes without a copy constructor (returned
   in registers).  A member pointer counts as the class MEMBER_PTR_CLASS_TYPE */
void DECLARE_HIDDEN_RETURN_PARAM(u16 type, u8 existing)
{
    if (T(type, 0) == 0x0D && TB(type, 13) == 0x0B)
        type = MEMBER_PTR_CLASS_TYPE;
    u16 size = (u16)TYPE_SIZE(T(type, 7));
    if ((size == 1 || size == 2 || size == 4) && !(TB(T(type, 7), 2) & 4))
        return;
    u16 pointer = MAKE_POINTER_TYPE(T(type, 7), 0x0F, 0);
    P(HIDDEN_RETURN_PARAM_RECORD, 2) = pointer;
    DECLARE_PARAMETERS(HIDDEN_RETURN_PARAM_RECORD, existing);
    SB_(CW(CURRENT_SCOPE, 4), 6) |= 4;
}

/* the body of function symbol owner of type function begun: the per-function state
   cleared (the definition's file, line and position kept), the function's scope opened,
   the parameters declared, and for main with parameters the start-up helpers
   SETARGV_SYMBOL (and SETENVP_SYMBOL with three) marked used (not for Windows programs) */
void BEGIN_FUNCTION_BODY(u16 owner, u16 function)
{
    u16 saved_file = CURRENT_SOURCE_FILE, saved_line = FUNCTION_DEF_LINE;
    u32 saved_expression = FUNCTION_DEF_POSITION;
    RTL_MEMSET(BCC_TREE_SPECIAL_P, 0, 80);
    ++FUNCTION_BODY_DEPTH;
    CURRENT_SOURCE_FILE = saved_file;
    FUNCTION_DEF_LINE = saved_line;
    FUNCTION_DEF_POSITION = saved_expression;
    TREE_ROOT = owner;
    LOOP_NEST_FACTOR = 1;
    CURRENT_FUNCTION_TYPE = function;
    if (CPP_MODE) {
        SWITCH_STATE_SCOPE = CW(GLOBAL_SCOPE, 16);
        LOOP_CONTEXT = CW(GLOBAL_SCOPE, 16);
        LOOP_BREAK_SCOPE = CW(GLOBAL_SCOPE, 16);
        for (u16 entry = CACHE_HEAD; entry; entry = CACHE(entry, 0))
            if (CACHE(entry, 2) == TREE_ROOT) {
                RETURN_FORM_SEEN = CACHE(entry, 4);
                break;
            }
    }
    STMT_NO_GOTO_OR_LABEL_FLAG = 1;
    LOOP_NEST_FACTOR = 1;
    FNBODY_WORD_A_SAVE = FNBODY_WORD_A;
    FNBODY_WORD_B_SAVE = FNBODY_WORD_B;
    START_FUNCTION_STATE();
    PUSH_SCOPE(1);
    BCC_TREE_LINK = CURRENT_SCOPE;
    APPEND_SCOPE_ENTER_BLOCK();
    u16 type = T(function, 7);
    if ((EXPR_FLAGS_AT(T(type, 0)) & 0x40) ||
        ((EXPR_FLAGS_AT(T(type, 0)) & 0x14) && T(T(type, 7), 0) == 0x12 && T(type, 0) == 0x0D && TB(type, 13) == 0x0B))
        DECLARE_HIDDEN_RETURN_PARAM(function, 0);
    DECLARE_PARAMETERS(T(function, 9), 0);
    if (SW_(owner, 2) == MAIN_SYMBOL && !(SB_(owner, 6) & 0x10) && !OPTION_WINDOWS_MODE && T(function, 9)) {
        SB_(SETARGV_SYMBOL, 6) |= 4;
        if (P(P(T(function, 9), 0), 0))
            SB_(SETENVP_SYMBOL, 6) |= 4;
    }
    PRAGMA_ARGSUSED_PENDING = 0;
}

/* a function body finished: in C++ destructors for the outer scope's objects and pending
   static initialisers, the body block closed, the function finished
   (FINISH_FUNCTION_STATE), the scope popped and the per-function state cleared */
void END_FUNCTION_BODY(void)
{
    if (CPP_MODE) {
        RELEASE_SCOPE_OBJECTS(CW(CW(CURRENT_SCOPE, 0), 16));
        if (NO_ERRORS_YET)
            FLUSH_PENDING_INITIALIZERS(1);
    }
    APPEND_SCOPE_EXIT_BLOCK();
    FINISH_FUNCTION_STATE();
    POP_SCOPE(0);
    CURRENT_CLASS_TYPE = 0;
    --FUNCTION_BODY_DEPTH;
    TREE_ROOT = 0;
    CTOR_THIS_SYMBOL = 0;
    FUNCTION_NAME_TEXT = 0;
    FNBODY_CLEARED_WORD_A = 0;
    FNBODY_WORD_A = FNBODY_WORD_A_SAVE;
    FNBODY_CLEARED_WORD_B = 0;
    FNBODY_WORD_B = FNBODY_WORD_B_SAVE;
}
