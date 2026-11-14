/* stmtcpp.c: from bcc20/src/parser/STMTCPP.C: the statement parser of the C++ front end,
   which also parses C when CPP_MODE is clear (every C++-only step is guarded by it).
   PARSE_FUNCTION_BODY is called for each function body (from COMPILE_FUNCTION_DEFINITION,
   FUNCDEF.C); PARSE_STATEMENT_CPP dispatches on the current token to PARSE_IF_STATEMENT,
   PARSE_WHILE and so on, which append flow blocks to the function's code as they go.
   Declarations may appear among statements: a type start is checked with
   IS_DECLARATION_AHEAD and parsed by PARSE_DECLARATION.

   State kept while parsing: CODE_UNREACHABLE (set after a jump, cleared by labels),
   CURRENT_SWITCH (17 bytes at DS:5EEC: depth, cases, default label, scope, break label,
   outer, kind words; active, has_default, no_fall bytes) and LOOP_CONTEXT (9 bytes at
   DS:5EFD: scope, break label, break scope, continue label words; continued byte) for the
   innermost switch and loop, saved and restored whole around nested ones,
   ENCLOSING_STATEMENT_KIND (1 switch, 2 loop) for break, LOOP_NEST_FACTOR (tripled in each
   loop; 1 means "not in a loop"), and CONSTANT_TRUTH_VALUE results (0 always false, 1
   always true, 2 must be tested).  C++ destructors: each scope keeps a list of objects to
   destroy (SCOPE_TEMPS); leaving a scope normally calls them (RELEASE_SCOPE_OBJECTS);
   break, continue, return and goto first emit the destructor calls for everything between
   here and their target.  DECL_INIT_SERIAL counts initialised declarations so that a goto
   or case label that jumps past an initialisation can be reported.

   A source position (struct C77Record6: file, line, word3) is passed by value as its three
   words, the last first (README, structure arguments). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define CURRENT_TOKEN_VALUE W(CURRENT_TOKEN_VALUE_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define PRAGMA_NORETVAL_PENDING B(PRAGMA_NORETVAL_PENDING_P)
#define TOKEN_CONVERT D(TOKEN_CONVERT_P)
#define RANGE_MIN(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8))
#define RANGE_MAX(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8 + 4))

/* CURRENT_SWITCH's fields */
#define SW_P(o) fp_add(CURRENT_SWITCH_P, (o))
#define SWITCH_DEPTH W(SW_P(0))
#define SWITCH_CASES W(SW_P(2))
#define SWITCH_DEFAULT W(SW_P(4))
#define SWITCH_SCOPE W(SW_P(6))
#define SWITCH_BREAK W(SW_P(8))
#define SWITCH_OUTER W(SW_P(0x0A))
#define SWITCH_KIND W(SW_P(0x0C))
#define SWITCH_ACTIVE B(SW_P(0x0E))
#define SWITCH_HAS_DEFAULT B(SW_P(0x0F))
#define SWITCH_NO_FALL B(SW_P(0x10))
#define SWITCH_SIZE 17
/* LOOP_CONTEXT's fields */
#define LOOP_P(o) fp_add(LOOP_CONTEXT_P, (o))
#define LOOP_SCOPE W(LOOP_P(0))
#define LOOP_BREAK W(LOOP_P(2))
#define LOOP_CONTINUE W(LOOP_P(6))
#define LOOP_CONTINUED B(LOOP_P(8))
#define LOOP_SIZE 9

struct Where { u16 first, second, third; };

static struct Where here(void)
{
    struct Where w = { CURRENT_TOKEN_FILE, CURRENT_TOKEN_LINE, CURRENT_TOKEN_LOC_WORD3 };
    return w;
}

static struct Where nowhere(void)
{
    struct Where w = { W(NO_SOURCE_LOCATION_P), W(fp_add(NO_SOURCE_LOCATION_P, 2)), W(fp_add(NO_SOURCE_LOCATION_P, 4)) };
    return w;
}

static void save_bytes(u8 *to, farptr from, int n)
{
    for (int i = 0; i < n; i++)
        to[i] = B(fp_add(from, i));
}

static void restore_bytes(farptr to, const u8 *from, int n)
{
    for (int i = 0; i < n; i++)
        B(fp_add(to, i)) = from[i];
}

static void jump_block(u16 target, struct Where w) { APPEND_JUMP_BLOCK(target, w.third, w.second, w.first); }
static void expression_block(u16 node, struct Where w) { APPEND_EXPRESSION_BLOCK(node, w.third, w.second, w.first); }

/* the token context, else the message first with the text as its far pointer argument */
static void expect_token(u16 context, u16 first, farptr text)
{
    TREE_INVOKE(context, first, FP_SEG(text), FP_OFF(text));
}

static u16 peek_kind(void)
{
    PEEK_TOKEN();
    return TOKEN_TYPE;
}

/* destructor calls for the objects registered in the current scope's SCOPE_TEMPS list
   down to marker (an earlier list head), as one comma expression; the entries are freed.
   Nothing is emitted when the point is unreachable */
void RELEASE_SCOPE_OBJECTS(u16 marker)
{
    while (SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) != marker) {
        u16 cursor = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
        SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) = marker;
        u16 pending = 0;
        while (cursor != marker) {
            u16 node = cursor;
            if (!CODE_UNREACHABLE)
                pending = JOIN_COMMA_EXPR(pending, UNPACK_EXPR_TREE(TDTOR_W(node, TDTOR_EXPR)));
            cursor = TDTOR_W(node, TDTOR_NEXT);
            FREE_TEMP_ENTRY(node);
        }
        if (!CODE_UNREACHABLE)
            APPEND_ANALYZED_EXPRESSION(pending);
    }
}

/* nonzero if the statement starting here is a declaration.  Storage classes, struct and
   similar keywords, const and volatile decide at once; otherwise the tokens are scanned
   with the look-ahead functions of LOOKAHD.C inside a recording on replay stream 2, then
   rewound */
u8 IS_DECLARATION_AHEAD(void)
{
    if (CURRENT_TOKEN == TOK_IDENT && peek_kind() == 0x67)
        return 0;
    if ((TYPE_FLAGS_AT(CURRENT_TOKEN) & 1) || CURRENT_TOKEN == TOK_STRUCT || CURRENT_TOKEN == TOK_UNION ||
        CURRENT_TOKEN == TOK_CLASS || CURRENT_TOKEN == TOK_ENUM || CURRENT_TOKEN == TOK_CONST || CURRENT_TOKEN == TOK_VOLATILE)
        return 1;
    if (!BCC_PARSE_BEGIN(2))
        return 0;
    BCC_PARSE_PUSH(2);
    u8 valid = SCAN_TYPE_SPECIFIERS();
    if (valid)
        valid = SCAN_DECLARATOR(0);
    BCC_PARSE_POP(2);
    return valid;
}

/* a switch selector: a class object is converted to an integral type in C++; the result
   must be integral */
u16 CHECK_SWITCH_SELECTOR(u16 expression)
{
    if (expression == 0)
        return expression;
    if (CPP_MODE)
        expression = CONVERT_CLASS_TO_INTEGRAL(expression);
    expression = SIMPLIFY_EXPRESSION(expression, 0);
    if (!(EXPR_FLAGS_AT(TYPE_W(EXPR_W(expression, EXPR_TYPE), TYPE_KIND)) & 1))
        REPORT_CURRENT_TOKEN(MSG_SWITCH_SELECTION);
    return expression;
}

/* a condition (if, while, for, do): a class object becomes a scalar in C++, the type must
   be scalar, and an assignment used as the condition is "possibly incorrect" */
u16 CHECK_CONDITION_EXPR(u16 expression)
{
    if (expression == 0)
        return expression;
    expression = ANALYZE_AND_DECAY(expression, 0);
    if (CPP_MODE)
        expression = CONVERT_CLASS_TO_SCALAR(expression);
    expression = SIMPLIFY_EXPRESSION(expression, 0);
    if (!(EXPR_FLAGS_AT(TYPE_W(EXPR_W(expression, EXPR_TYPE), TYPE_KIND)) & 7))
        return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_SCALAR_TYPE, expression);
    if (EXPR_W(expression, EXPR_OP) == EOP_ASSIGN)
        REPORT_DIAGNOSTIC_AT(MSG_POSSIBLY_INCORRECT, 0, 0, EXPR_W(expression, EXPR_SRC_LINE), 0);
    return expression;
}

/* unpacks a packed list of expressions (built in reverse order) and joins them in source
   order into one comma expression */
u16 REVERSE_LIST_TO_COMMA(u16 list)
{
    u16 node = UNPACK_EXPR_TREE(list), result = 0;
    while (node) {
        result = JOIN_COMMA_EXPR(EXPR_W(node, EXPR_RIGHT), result);
        u16 previous = node;
        node = EXPR_W(node, EXPR_LEFT);
        FREE_EXPR_NODE(previous);
    }
    return result;
}

/* "symbol = value" for local variable first */
static u16 assign_to(u16 first, u16 value)
{
    u16 left = MAKE_SYMBOL_NODE(first);
    return MAKE_BINARY_NODE(5, left, value);
}

/* the initializer of local variable first of type, as the initialising expression:
   "(value)" or "= value", a braced scalar, or a brace list for an aggregate.  An aggregate
   list is laid out by INIT_DECLARATOR into a temporary static copy that is then assigned,
   or, for a class with constructors (or during inline expansion), as the list of member
   assignments INIT_DECLARATOR queued in LOCAL_INIT_EXPR_LIST */
u16 PARSE_INITIALIZER(u16 first, u16 type)
{
    u16 result;
    if (CURRENT_TOKEN == TOK_LPAREN)
        result = PARSE_ASSIGNMENT_EXPR(2);
    else {
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN == TOK_LBRACE ||
            (TYPE_W(type, TYPE_KIND) == TK_ARRAY && (CURRENT_TOKEN == 0x34 || (TYPE_B(type, TYPE_ATTRS) & 4)))) {
            if ((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 7) && TYPE_W(type, TYPE_KIND) != TK_UNDEFINED) {
                ADVANCE_TOKEN();
                result = PARSE_ASSIGNMENT_EXPR(7);
                if (CURRENT_TOKEN == TOK_RBRACE)
                    ADVANCE_TOKEN();
                else
                    REPORT_CURRENT_TOKEN(CURRENT_TOKEN == TOK_COMMA ? MSG_TOO_MANY_INITIALIZERS : MSG_EXPECTED_230);
            } else if ((TYPE_B(type, TYPE_ATTRS) & 4) || INLINE_EXPANSION_DEPTH > 0) {
                LOCAL_INIT_EXPR_LIST = 0;
                INIT_DECLARATOR(first, type);
                return REVERSE_LIST_TO_COMMA(LOCAL_INIT_EXPR_LIST);
            } else {
                u16 symbol = CREATE_TEMP_SYMBOL(type, 1);
                LOCAL_INIT_EXPR_LIST = 0;
                INIT_DECLARATOR(symbol, type);
                u16 left = MAKE_SYMBOL_NODE(first);
                u16 right = MAKE_SYMBOL_NODE(symbol);
                result = MAKE_BINARY_NODE(5, left, right);
                return JOIN_COMMA_EXPR(REVERSE_LIST_TO_COMMA(LOCAL_INIT_EXPR_LIST), result);
            }
        } else
            result = PARSE_ASSIGNMENT_EXPR(8);
    }
    return assign_to(first, result);
}

/* a static local whose initialisation needs code runs it only the first time: "flag ? 0 :
   (flag++, initialisers)" with a hidden int flag (a temporary static symbol).  If the type
   has a destructor, a matching "flag ? destructor : 0" is registered on
   TEMP_DESTRUCTOR_LIST */
u16 GUARD_STATIC_LOCAL_INIT(u16 first, u16 type)
{
    u16 result = REVERSE_LIST_TO_COMMA(LOCAL_INIT_EXPR_LIST);
    u16 symbol = CREATE_TEMP_SYMBOL(INT_TYPE, 1);
    u16 saved = SELECT_SYMBOL_STREAM(symbol);
    EMIT_ZERO_BYTES((u16)TYPE_SIZE(INT_TYPE));
    SET_STREAM(saved);
    C0MARK(1);
    u16 increment = MAKE_UNARY_NODE(0x2D, MAKE_SYMBOL_NODE(symbol));
    result = JOIN_COMMA_EXPR(increment, result);
    u16 test = MAKE_SYMBOL_NODE(symbol);
    u16 zero = MAKE_INT_CONSTANT(VOID_TYPE, 0);
    result = MAKE_CONDITIONAL_NODE(0x6B, test, zero, result);
    if (!NO_ERRORS_YET)
        return result;
    u16 temporary = BUILD_DESTRUCTOR_CALL(MAKE_SYMBOL_NODE(first), type, 0, 2);
    if (temporary == 0)
        return result;
    test = MAKE_SYMBOL_NODE(symbol);
    zero = MAKE_INT_CONSTANT(VOID_TYPE, 0);
    temporary = MAKE_CONDITIONAL_NODE(0x6B, test, temporary, zero);
    DESTRUCTOR_ENTRY_SERIAL++;
    u16 link = ALLOC_TEMP_ENTRY();
    TDTOR_W(link, TDTOR_NEXT) = TEMP_DESTRUCTOR_LIST;
    TDTOR_W(link, TDTOR_SERIAL) = DESTRUCTOR_ENTRY_SERIAL;
    temporary = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(temporary, VOID_TYPE), 1);
    u16 packed = PACK_EXPR_TREE(temporary);
    TDTOR_W(link, TDTOR_EXPR) = packed;
    TEMP_DESTRUCTOR_LIST = link;
    return result;
}

static u16 analyzed(u16 value)
{
    return SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(value, VOID_TYPE), 1);
}

/* a declaration inside a function.  Opens a block scope on the first declaration of a
   block.  nested nonzero (a declaration in a for initialiser) returns the initialisation
   code as an expression instead of appending it.  Handles typedefs, function declarations,
   anonymous unions (C++: their members become aliases of a hidden object), and variables:
   auto ones are initialised by code and get destructor entries; statics and externs go
   through PARSE_DECL_INITIALIZER, with GUARD_STATIC_LOCAL_INIT when code is needed.  An
   array of unknown size is declared again after its initializer has fixed the size
   (retry).  Static locals are not allowed in functions expanded inline */
u16 PARSE_DECLARATION(u8 nested)
{
    /* the original frame from BP-26h */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x26);
    farptr modifier2 = v, modifier1 = fp_add(v, 1), scratch = fp_add(v, 2), decl_spec = fp_add(v, 6);
    farptr spec = fp_add(v, 0x0A), named = fp_add(v, 0x0E), record = fp_add(v, 0x14), owner = fp_add(v, 0x16);
    farptr scope = fp_add(v, 0x18), name = fp_add(v, 0x1A), decl_type = fp_add(v, 0x1C), created = fp_add(v, 0x1F);
    farptr type = fp_add(v, 0x20), kind = fp_add(v, 0x22);
    u8 retry = 0, any_defined;
    u16 result = 0, token, value = 0;
    if (SCOPE_W(CURRENT_SCOPE, SCOPE_NEST_LEVEL) != BLOCK_NEST_LEVEL) {
        PUSH_SCOPE(0);
        if (nested)
            SCOPE_W(CURRENT_SCOPE, SCOPE_ENTER_BLOCK) = SCOPE_W(SCOPE_W(CURRENT_SCOPE, SCOPE_PARENT), SCOPE_ENTER_BLOCK);
        else
            APPEND_SCOPE_ENTER_BLOCK();
    }
    struct Where position = here();
    any_defined = 0;
    W(type) = INT_TYPE;
    PARSE_DECL_SPECIFIERS(0, kind, modifier1, modifier2, type, spec, named);
    if (INLINE_FUNCTION_STACK && W(kind) == 0x35) {
        REPORT_DIAGNOSTIC(MSG_FUNCTIONS_CONTAINING, (i32)STR_STATIC_VARIABLES_P, 0);
        SYM_W(BCC_TREE_SPECIAL, SYM_FUNC_FLAGS) &= ~4;
    }
    if (B(modifier1) || B(modifier2) ||
        (W(kind) != 0x39 && W(kind) != 0x36 && W(kind) != 0x38 && W(kind) != 0x35 && W(kind) != 0x37 && W(kind) != 0x82))
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,
                          (i32)(B(modifier1) ? STR_FRIEND_P : B(modifier2) ? STR_VIRTUAL_P : NAME_TEXT_COPY(TOKEN_NAMES_AT(W(kind)))), 0);
    token = W(kind) == 0x82 ? 0x39 : W(kind);
    u16 t = W(type);
    if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) && TYPE_W(t, TYPE_KIND) != TK_ENUM) {
        if (CPP_MODE) {
            if (TYPE_W(t, TYPE_KIND) == TK_UNION && SYM_W(TAG_W(TYPE_W(t, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) == 0) {
                u16 member = TAG_W(TYPE_W(t, TYPE_TAG_BODY), TAG_MEMBERS);
                u16 object = CREATE_LOCAL_TEMP(t);
                while (member != 0) {
                    if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 0)
                        DECLARE_MEMBER_ALIAS(member, object);
                    else
                        REPORT_NAME_DIAGNOSTIC(MSG_CANNOT_DECLARED, MEMBER_W(member, MEMB_NAME));
                    member = MEMBER_W(member, MEMB_NEXT);
                }
            } else if (EXPR_FLAGS_AT(TYPE_W(t, TYPE_KIND)) & 0x40) {
                if (SYM_W(TAG_W(TYPE_W(t, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) == 0)
                    REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
                else if (W(kind) == 0x36 || W(kind) == 0x35)
                    REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, (i32)NAME_TEXT_COPY(TOKEN_NAMES_AT(W(kind))), 0);
            } else
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
        } else if (EXPR_FLAGS_AT(TYPE_W(t, TYPE_KIND)) & 0x40) {
            if (SYM_W(TAG_W(TYPE_W(t, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) == 0)
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT_352);
        } else
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
    }
    while (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) {
        for (int i = 0; i < 3; i++)
            B(fp_add(decl_spec, i)) = B(fp_add(spec, i));
        PARSE_DECLARATOR(W(type), 0, decl_type, name, scope, owner, decl_spec, scratch);
        u16 dt = W(decl_type);
        u8 sq = B(fp_add(decl_spec, 2));
        u16 slow = W(decl_spec);
        if (W(name) != 0) {
            if (W(owner) != 0)
                REPORT_NAME_DIAGNOSTIC(MSG_IDENTIFIER_CANNOT_HAVE, W(name));
            if (W(kind) == 0x37) {
                if (W(scope) != 0)
                    REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
                else
                    DECLARE_TYPEDEF(dt, sq, slow, W(name));
            } else if (TYPE_W(dt, TYPE_KIND) == TK_FUNCTION) {
                if (TYPE_B(dt, TYPE_ATTRS) & 0x40)
                    REPORT_CURRENT_TOKEN(MSG_PARAMETER_NAMES_ARE);
                if (W(kind) == 0x35)
                    REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, TOKEN_NAMES_AT(TOK_STATIC));
                DECLARE_FUNCTION(dt, W(name), W(scope), W(kind), record, created);
                C0MARK(1);
            } else if (W(scope) != 0)
                REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
            else {
                if (CPP_MODE && (TYPE_B(dt, TYPE_ATTRS) & 1) && (EXPR_FLAGS_AT(TYPE_W(dt, TYPE_KIND)) & 3) && token == 0x39)
                    token = 0x35;
                u8 is_inline = W(kind) != 0x36 && (TYPE_B(dt, TYPE_ATTRS) & 4);
                u8 defining = CURRENT_TOKEN == TOK_ASSIGN || CURRENT_TOKEN == TOK_LPAREN || is_inline;
                position = here();
                u8 needs_init = token != 0x36 && token != 0x35;
                any_defined = any_defined || defining;
                if (is_inline && ((EXPR_FLAGS_AT(TYPE_W(dt, TYPE_KIND)) & 0x40) || CURRENT_TOKEN != TOK_ASSIGN)) {
                    W(record) = DECLARE_VARIABLE(dt, W(name), token, 1, sq, slow);
                    if (needs_init)
                        value = PARSE_OBJECT_INIT(W(record), dt);
                } else {
                    retry = TYPE_SIZE(dt) == 0 && TYPE_W(dt, TYPE_KIND) == TK_ARRAY;
                    W(record) = DECLARE_VARIABLE(dt, W(name), token, defining, sq, slow);
                    if (defining && needs_init)
                        value = PARSE_INITIALIZER(W(record), dt);
                    if (needs_init && retry)
                        W(record) = DECLARE_VARIABLE(dt, W(name), token, defining, sq, slow);
                }
                if (token == 0x36 || token == 0x35) {
                    if (defining || (CPP_MODE && token == 0x35 && (TYPE_B(dt, TYPE_ATTRS) & 8))) {
                        if (token == 0x36)
                            REPORT_CURRENT_TOKEN(MSG_EXTERN_VARIABLE_CANNOT);
                        LOCAL_INIT_EXPR_LIST = 0;
                        if (defining)
                            PARSE_DECL_INITIALIZER(is_inline, dt, W(record));
                        if (retry)
                            W(record) = DECLARE_VARIABLE(dt, W(name), token, defining, sq, slow);
                        if ((SYM_B(W(record), SYM_STORAGE_CLASS) >> 3) == 5) {
                            value = REVERSE_LIST_TO_COMMA(LOCAL_INIT_EXPR_LIST);
                            if (!nested) {
                                value = analyzed(value);
                                expression_block(value, position);
                                SYM_B(W(record), SYM_FLAGS) &= ~4;
                            } else
                                result = JOIN_COMMA_EXPR(result, value);
                        } else if (LOCAL_INIT_EXPR_LIST != 0 || (TYPE_B(dt, TYPE_ATTRS) & 8)) {
                            value = GUARD_STATIC_LOCAL_INIT(W(record), dt);
                            value = analyzed(value);
                            expression_block(value, position);
                        }
                    } else if (token == 0x35 && CPP_MODE) {
                        u16 node = MAKE_SYMBOL_NODE(W(record));
                        TEMP_DESTRUCTOR_LIST = REGISTER_TEMP_DESTRUCTOR(node, dt, TEMP_DESTRUCTOR_LIST);
                    } else if (token == 0x36)
                        C0MARK(1);
                } else {
                    if (defining) {
                        if (!nested) {
                            value = analyzed(value);
                            expression_block(value, position);
                            SYM_B(W(record), SYM_FLAGS) &= ~4;
                        } else
                            result = JOIN_COMMA_EXPR(result, value);
                    }
                    if (CPP_MODE && (TYPE_B(dt, TYPE_ATTRS) & 8)) {
                        u16 node = MAKE_SYMBOL_NODE(W(record));
                        u16 list = REGISTER_TEMP_DESTRUCTOR(node, dt, SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS));
                        SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) = list;
                    }
                }
            }
        } else
            REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
        if (CURRENT_TOKEN == TOK_COMMA) {
            ADVANCE_TOKEN();
            if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10)) {
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
                SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
            }
        } else if (CURRENT_TOKEN != TOK_SEMICOLON) {
            REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
            SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
        }
    }
    if (any_defined)
        DECL_INIT_SERIAL++;
    REQUIRE_TOKEN_BODY(7, 0x1F);
    scratch_release(mark);
    return result;
}

/* a copy, in the same order, of a list of destructor entries (TEMP_ENTRY_POOL_SEG records,
   six bytes), so a label or goto can remember which objects were alive at that point */
u16 COPY_NODE_LIST(u16 list)
{
    u16 reversed = 0, node, result = 0;
    while (list != 0) {
        node = ALLOC_TEMP_ENTRY();
        for (int i = 0; i < 6; i += 2)
            TDTOR_W(node, i) = TDTOR_W(list, i);
        list = TDTOR_W(list, TDTOR_NEXT);
        TDTOR_W(node, TDTOR_NEXT) = reversed;
        reversed = node;
    }
    while (reversed) {
        node = reversed;
        reversed = TDTOR_W(reversed, TDTOR_NEXT);
        TDTOR_W(node, TDTOR_NEXT) = result;
        result = node;
    }
    return result;
}

/* when label block key is defined: removes the forward gotos to it from PENDING_GOTO_LIST,
   reporting any that jump past an initialisation.  In C++ a goto that had objects to
   destroy jumped to its own label (GOTO_TARGET); for each, a stub is placed here that
   destroys those objects and jumps on to the label, with a jump around the stubs */
void RESOLVE_PENDING_GOTOS(u16 key, i16 limit)
{
    u8 differing = 0;
    u16 removed = 0, previous = 0, node = PENDING_GOTO_LIST, current;
    while (node) {
        if (LABEL_W(node, LABEL_BLOCK) == key) {
            if (LABEL_I(node, GOTO_INIT_SERIAL) > limit || LABEL_I(node, GOTO_INIT_SERIAL) < (i16)DECL_INIT_SERIAL)
                REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_GOTO_BYPASSES : MSG_GOTO_BYPASSES_358);
            current = node;
            node = LABEL_W(node, GOTO_NEXT);
            if (previous == 0)
                PENDING_GOTO_LIST = node;
            else
                LABEL_W(previous, GOTO_NEXT) = node;
            LABEL_W(current, GOTO_NEXT) = removed;
            removed = current;
            differing = differing || LABEL_W(current, GOTO_TARGET) != key;
        } else {
            previous = node;
            node = LABEL_W(node, GOTO_NEXT);
        }
    }
    if (CPP_MODE) {
        if (differing) {
            jump_block(key, nowhere());
            for (node = removed; node; node = LABEL_W(node, GOTO_NEXT))
                if (LABEL_W(node, GOTO_TARGET) != key) {
                    APPEND_BLOCK_IF_NONZERO(LABEL_W(node, GOTO_TARGET));
                    u16 temporary = BUILD_TEMP_DESTRUCTORS(LABEL_W(node, GOTO_TEMPS), SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS));
                    APPEND_ANALYZED_EXPRESSION(temporary);
                    jump_block(key, nowhere());
                }
        }
        while (removed) {
            current = removed;
            removed = LABEL_W(current, GOTO_NEXT);
            while (LABEL_W(current, GOTO_TEMPS)) {
                u16 link = LABEL_W(current, GOTO_TEMPS);
                LABEL_W(current, GOTO_TEMPS) = TDTOR_W(link, TDTOR_NEXT);
                FREE_TEMP_ENTRY(link);
            }
        }
    }
}

/* at the end of a function body: labels used but never defined, and the leftover goto
   records freed */
void CHECK_UNDEFINED_LABELS(void)
{
    for (u16 label = LABEL_LIST_HEAD; label; label = LABEL_W(label, LABEL_NEXT))
        if (!LABEL_B(label, LABEL_DEFINED))
            REPORT_DIAGNOSTIC(MSG_UNDEFINED_LABEL, (i32)NAME_TEXT_COPY(LABEL_W(label, LABEL_NAME)), 0);
    if (CPP_MODE) {
        while (PENDING_GOTO_LIST) {
            while (LABEL_W(PENDING_GOTO_LIST, GOTO_TEMPS)) {
                u16 item = LABEL_W(PENDING_GOTO_LIST, GOTO_TEMPS);
                LABEL_W(PENDING_GOTO_LIST, GOTO_TEMPS) = TDTOR_W(item, TDTOR_NEXT);
                FREE_TEMP_ENTRY(item);
            }
            PENDING_GOTO_LIST = LABEL_W(PENDING_GOTO_LIST, GOTO_NEXT);
        }
    }
}

/* finds a label by name (the record at offset 0 holds the name as the search's end) */
static u16 find_label(void)
{
    LABEL_W(0, 2) = CURRENT_TOKEN_VALUE;
    u16 label = LABEL_LIST_HEAD;
    while (LABEL_W(label, LABEL_NAME) != CURRENT_TOKEN_VALUE)
        label = LABEL_W(label, LABEL_NEXT);
    return label;
}

/* defines the label "name:", records the objects alive here (C++), resolves forward gotos
   and places the label block */
void PARSE_LABEL(void)
{
    STMT_NO_GOTO_OR_LABEL_FLAG = 0;
    u16 label = find_label();
    if (!label) {
        label = ALLOC_LABEL_RECORD();
        LABEL_W(label, LABEL_NAME) = CURRENT_TOKEN_VALUE;
        u16 block = NEW_LABEL_IF_ENABLED();
        LABEL_W(label, LABEL_BLOCK) = block;
    } else if (LABEL_B(label, LABEL_DEFINED) != 0)
        REPORT_CURRENT_TOKEN(MSG_MULTIPLE_DECLARATION);
    LABEL_B(label, LABEL_DEFINED) = 1;
    LABEL_W(label, LABEL_SERIAL_HIGH) = 0x7FFF;
    if (CPP_MODE) {
        u16 temps = COPY_NODE_LIST(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS));
        LABEL_W(label, LABEL_TEMPS) = temps;
    }
    RESOLVE_PENDING_GOTOS(LABEL_W(label, LABEL_BLOCK), (i16)LABEL_W(label, LABEL_SERIAL_HIGH));
    LABEL_W(label, LABEL_SERIAL_LOW) = DECL_INIT_SERIAL;
    APPEND_BLOCK_IF_NONZERO(LABEL_W(label, LABEL_BLOCK));
    ADVANCE_TOKEN();
    REQUIRE_TOKEN_BODY(0x21, 0xC8);
}

/* at a case or default label: a jump into the switch body past an initialisation (or, in
   C++, past the construction of an object still alive) is reported, and the objects of the
   previous case section are destroyed */
void CHECK_CASE_BYPASS(void)
{
    if (!CODE_UNREACHABLE && SWITCH_OUTER != DECL_INIT_SERIAL)
        REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_CASE_BYPASSES : MSG_CASE_BYPASSES_382);
    else if (CPP_MODE && !CODE_UNREACHABLE && SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) != SWITCH_SCOPE)
        REPORT_CURRENT_TOKEN(MSG_CASE_BYPASSES);
    if (CPP_MODE)
        RELEASE_SCOPE_OBJECTS(SWITCH_SCOPE);
    SWITCH_OUTER = DECL_INIT_SERIAL;
    SWITCH_HAS_DEFAULT = 0;
}

/* "case constant:": the value is converted to the selector's type, must be in its range,
   and is inserted into the sorted case list with a new label placed here */
void PARSE_CASE(void)
{
    u16 mark = scratch_mark();
    farptr value = scratch_alloc(4);
    if (SWITCH_ACTIVE)
        CHECK_CASE_BYPASS();
    ADVANCE_TOKEN();
    CONST_EXPR_VALUE_BODY(0x21, value);
    if (EXPR_FLAGS_AT(SWITCH_KIND) & 0x20)
        SD(value) = (i32)CALL_FAR(TOKEN_CONVERT, A32((u32)SD(value)), A16(SWITCH_KIND));
    if (RANGE_MIN(SWITCH_KIND) > SD(value) || RANGE_MAX(SWITCH_KIND) < SD(value))
        REPORT_CURRENT_TOKEN(MSG_CASE_CONSTANT_OUT);
    u16 entry = POOL_ALLOC_REUSE(CASE_ENTRY_POOL_SEG_P, 8);
    SWCASE_L(entry, SWCASE_VALUE) = SD(value);
    u16 target = NEW_LABEL_IF_ENABLED();
    SWCASE_W(entry, SWCASE_TARGET) = target;
    APPEND_BLOCK_IF_NONZERO(SWCASE_W(entry, SWCASE_TARGET));
    u16 cur, prev;
    for (cur = SWITCH_CASES, prev = 0; cur && SWCASE_L(cur, SWCASE_VALUE) < SD(value); cur = SWCASE_W(cur, SWCASE_NEXT))
        prev = cur;
    if (cur && SWCASE_L(cur, SWCASE_VALUE) == SD(value))
        REPORT_CURRENT_TOKEN(MSG_DUPLICATE_CASE);
    if (prev == 0) {
        SWCASE_W(entry, SWCASE_NEXT) = SWITCH_CASES;
        SWITCH_CASES = entry;
    } else {
        SWCASE_W(entry, SWCASE_NEXT) = SWCASE_W(prev, SWCASE_NEXT);
        SWCASE_W(prev, SWCASE_NEXT) = entry;
    }
    REQUIRE_TOKEN_BODY(0x21, 0x1B);
    scratch_release(mark);
}

/* "default:": places the default label (one per switch) */
void PARSE_DEFAULT(void)
{
    if (SWITCH_ACTIVE) {
        if (SWITCH_DEFAULT)
            REPORT_CURRENT_TOKEN(MSG_TOO_MANY_DEFAULT_CASES);
        CHECK_CASE_BYPASS();
        SWITCH_DEFAULT = NEW_LABEL_IF_ENABLED();
        APPEND_BLOCK_IF_NONZERO(SWITCH_DEFAULT);
    }
    ADVANCE_TOKEN();
    REQUIRE_TOKEN_BODY(0x21, 0x17);
}

/* any labels, case and default prefixes in front of a statement; afterwards the point is
   reachable again */
void PARSE_LABELS(void)
{
    u8 reported = 0;
    while ((CURRENT_TOKEN == TOK_IDENT && peek_kind() == 0x21) || CURRENT_TOKEN == TOK_CASE || CURRENT_TOKEN == TOK_DEFAULT ||
           CURRENT_TOKEN == TOK_COLON) {
        if (CURRENT_TOKEN == TOK_COLON) {
            REPORT_CURRENT_TOKEN(MSG_UNEXPECTED_FOUND);
            ADVANCE_TOKEN();
        } else if (CURRENT_TOKEN == TOK_IDENT)
            PARSE_LABEL();
        else {
            if (!SWITCH_ACTIVE && !reported) {
                reported = 1;
                REPORT_CURRENT_TOKEN(CURRENT_TOKEN == TOK_CASE ? MSG_CASE_OUTSIDE_SWITCH : MSG_DEFAULT_OUTSIDE_SWITCH);
            }
            if (CURRENT_TOKEN == TOK_CASE)
                PARSE_CASE();
            else
                PARSE_DEFAULT();
        }
    }
    CODE_UNREACHABLE = 0;
}

/* goto name;  A backward goto to a defined label checks for jumps past initialisations and
   (C++) destroys the objects the jump leaves behind.  A forward goto is recorded in
   PENDING_GOTO_LIST with the objects alive now, finished by RESOLVE_PENDING_GOTOS when the
   label appears */
void PARSE_GOTO(void)
{
    struct Where where = here();
    ADVANCE_TOKEN();
    STMT_NO_GOTO_OR_LABEL_FLAG = 0;
    if (CURRENT_TOKEN != TOK_IDENT) {
        REPORT_CURRENT_TOKEN(MSG_GOTO_STATEMENT_MISSING);
        IN_ERROR_RECOVERY = 1;
    } else {
        IN_ERROR_RECOVERY = 0;
        u16 target, label = find_label();
        if (!label) {
            label = ALLOC_LABEL_RECORD();
            target = NEW_LABEL_IF_ENABLED();
            LABEL_W(label, LABEL_NAME) = CURRENT_TOKEN_VALUE;
            LABEL_W(label, LABEL_BLOCK) = target;
            LABEL_W(label, LABEL_TEMPS) = 0;
            LABEL_W(label, LABEL_SERIAL_LOW) = 0;
            LABEL_W(label, LABEL_SERIAL_HIGH) = 0x7FFF;
        }
        if (!LABEL_B(label, LABEL_DEFINED)) {
            u16 jump = ALLOC_JUMP_RECORD();
            LABEL_W(jump, LABEL_BLOCK) = LABEL_W(label, LABEL_BLOCK);
            target = LABEL_W(jump, LABEL_BLOCK);
            LABEL_W(jump, GOTO_INIT_SERIAL) = DECL_INIT_SERIAL;
            if (CPP_MODE) {
                u16 temps = COPY_NODE_LIST(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS));
                LABEL_W(jump, GOTO_TEMPS) = temps;
                if (SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) != SCOPE_W(GLOBAL_SCOPE, SCOPE_TEMPS))
                    target = NEW_LABEL_IF_ENABLED();
            }
            LABEL_W(jump, GOTO_TARGET) = target;
        } else {
            target = LABEL_W(label, LABEL_BLOCK);
            if (LABEL_I(label, LABEL_SERIAL_HIGH) < (i16)DECL_INIT_SERIAL || LABEL_I(label, LABEL_SERIAL_LOW) > (i16)DECL_INIT_SERIAL)
                REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_GOTO_BYPASSES : MSG_GOTO_BYPASSES_358);
            if (CPP_MODE)
                APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), LABEL_W(label, LABEL_TEMPS)));
        }
        jump_block(target, where);
    }
    ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_SEMICOLON)
        ADVANCE_TOKEN();
    else
        REPORT_DIAGNOSTIC(MSG_STATEMENT_MISSING_64, (i32)STR_GOTO_P, 0);
    CODE_UNREACHABLE = 1;
}

/* an expression statement: "code has no effect" when the value is unused and the
   expression has no side effects; then appended */
void PARSE_EXPRESSION_STATEMENT(void)
{
    IN_ERROR_RECOVERY = 0;
    struct Where where = here();
    u16 expr = ANALYZE_AND_DECAY(PARSE_COMMA_EXPRESSION(7), VOID_TYPE);
    if (expr && IS_SIDE_EFFECT_FREE(expr) && EXPR_W(expr, EXPR_TYPE) != VOID_TYPE)
        REPORT_CURRENT_TOKEN(MSG_CODE_HAS_NO_EFFECT);
    expr = SIMPLIFY_EXPRESSION(expr, 1);
    expression_block(expr, where);
    REQUIRE_TOKEN_BODY(7, 0xEA);
}

/* if (condition) statement [else statement].  A constant condition makes the branch not
   taken unreachable.  The point after the if is unreachable only if both branches end
   unreachable */
void PARSE_IF_STATEMENT(void)
{
    u16 scope = 0;
    IN_ERROR_RECOVERY = 0;
    STATEMENT_NEST_DEPTH++;
    struct Where where = here();
    ADVANCE_TOKEN();
    expect_token(1, 0x3E, STR_IF_P);
    if (CPP_MODE)
        scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    u16 expr = CHECK_CONDITION_EXPR(PARSE_COMMA_EXPRESSION(2));
    if (CPP_MODE)
        expr = APPEND_TEMP_DESTRUCTORS(expr, scope);
    u16 truth = CONSTANT_TRUTH_VALUE(expr);
    u8 saved_flag = STMT_NO_GOTO_OR_LABEL_FLAG;
    STMT_NO_GOTO_OR_LABEL_FLAG = LOOP_NEST_FACTOR == 1;
    if (CPP_MODE)
        scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    u16 end_label = NEW_LABEL_IF_ENABLED();
    APPEND_JUMP_IF_FALSE_BLOCK(expr, end_label, where.third, where.second, where.first);
    expect_token(2, 0x3F, STR_IF_P);
    if (truth == 0)
        CODE_UNREACHABLE = 1;
    PARSE_STATEMENT_CPP(0);
    u8 then_flag = CODE_UNREACHABLE;
    if (CPP_MODE)
        RELEASE_SCOPE_OBJECTS(scope);
    CODE_UNREACHABLE = 0;
    if (CURRENT_TOKEN == TOK_ELSE) {
        u16 else_label = NEW_LABEL_IF_ENABLED();
        jump_block(else_label, nowhere());
        APPEND_BLOCK_IF_NONZERO(end_label);
        end_label = else_label;
        ADVANCE_TOKEN();
        if (CPP_MODE)
            scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
        if (truth == 1)
            CODE_UNREACHABLE = 1;
        PARSE_STATEMENT_CPP(0);
        if (CPP_MODE)
            RELEASE_SCOPE_OBJECTS(scope);
    }
    CODE_UNREACHABLE = CODE_UNREACHABLE && then_flag;
    APPEND_BLOCK_IF_NONZERO(end_label);
    STMT_NO_GOTO_OR_LABEL_FLAG = saved_flag;
    STATEMENT_NEST_DEPTH--;
}

/* an else without an if: reported, and the statement after it parsed */
void REPORT_MISPLACED_ELSE(void)
{
    REPORT_CURRENT_TOKEN(MSG_MISPLACED_ELSE_127);
    ADVANCE_TOKEN();
    PARSE_STATEMENT_CPP(0);
}

/* switch (selector) statement.  An enum selector uses its base type; small types are
   widened to int.  The body is parsed with a fresh CURRENT_SWITCH; afterwards a default
   label is added if there was none, and the cases and default are attached to the switch
   block */
void PARSE_SWITCH(void)
{
    u8 saved[SWITCH_SIZE];
    u16 scope = 0;
    IN_ERROR_RECOVERY = 0;
    ++STATEMENT_NEST_DEPTH;
    struct Where location = here();
    ADVANCE_TOKEN();
    expect_token(1, 0x3E, STR_SWITCH_P);
    if (CPP_MODE)
        scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    u16 expr = ANALYZE_AND_DECAY(PARSE_COMMA_EXPRESSION(2), INT_TYPE);
    if (CPP_MODE)
        expr = APPEND_TEMP_DESTRUCTORS(expr, scope);
    if (expr && EXPR_W(expr, EXPR_OP)) {
        if (TYPE_I(EXPR_W(expr, EXPR_TYPE), TYPE_KIND) == TK_ENUM)
            EXPR_W(expr, EXPR_TYPE) = TAG_W(TYPE_I(EXPR_W(expr, EXPR_TYPE), TYPE_TAG_BODY), TAG_ENUM_BASE);
        if (TYPE_I(EXPR_W(expr, EXPR_TYPE), TYPE_KIND) < TK_SHORT)
            expr = ANALYZE_AND_DECAY(MAKE_CAST_NODE(INT_TYPE, expr), INT_TYPE);
    }
    save_bytes(saved, CURRENT_SWITCH_P, SWITCH_SIZE);
    SWITCH_ACTIVE = 1;
    SWITCH_CASES = 0;
    SWITCH_DEFAULT = 0;
    SWITCH_OUTER = DECL_INIT_SERIAL;
    SWITCH_HAS_DEFAULT = 0;
    SWITCH_NO_FALL = 0;
    SWITCH_DEPTH = STATEMENT_NEST_DEPTH;
    if (CPP_MODE)
        SWITCH_SCOPE = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    SWITCH_BREAK = NEW_LABEL_IF_ENABLED();
    expr = CHECK_SWITCH_SELECTOR(expr);
    SWITCH_KIND = TYPE_I(EXPR_W(expr, EXPR_TYPE), TYPE_KIND);
    if (SWITCH_KIND == 0x15)
        SWITCH_KIND = TYPE_I(TAG_W(TYPE_I(EXPR_W(expr, EXPR_TYPE), TYPE_TAG_BODY), TAG_ENUM_BASE), TYPE_KIND);
    u8 saved_no_goto = STMT_NO_GOTO_OR_LABEL_FLAG;
    STMT_NO_GOTO_OR_LABEL_FLAG = LOOP_NEST_FACTOR == 1;
    u16 body = APPEND_SWITCH_BLOCK(expr, location.third, location.second, location.first);
    expect_token(2, 0x3F, STR_SWITCH_P);
    u16 saved_enclosing_kind = ENCLOSING_STATEMENT_KIND;
    ENCLOSING_STATEMENT_KIND = 1;
    CODE_UNREACHABLE = 1;
    PARSE_STATEMENT_CPP(0);
    if (SWITCH_NO_FALL)
        CODE_UNREACHABLE = 0;
    if (SWITCH_DEFAULT == 0) {
        CODE_UNREACHABLE = 0;
        SWITCH_DEFAULT = NEW_LABEL_IF_ENABLED();
        APPEND_BLOCK_IF_NONZERO(SWITCH_DEFAULT);
    }
    SET_SWITCH_INFO_IF_ENABLED(body, SWITCH_DEFAULT, SWITCH_CASES);
    APPEND_BLOCK_IF_NONZERO(SWITCH_BREAK);
    restore_bytes(CURRENT_SWITCH_P, saved, SWITCH_SIZE);
    ENCLOSING_STATEMENT_KIND = saved_enclosing_kind;
    STMT_NO_GOTO_OR_LABEL_FLAG = saved_no_goto;
    --STATEMENT_NEST_DEPTH;
}

/* while (condition) statement: a jump to the test (unless always true), top: body,
   continue label: the test as a branch back to top (or a plain jump if always true), break
   label.  An always-false loop body is unreachable */
void PARSE_WHILE(void)
{
    u8 saved[LOOP_SIZE];
    u16 scope = 0;
    IN_ERROR_RECOVERY = 0;
    ++STATEMENT_NEST_DEPTH;
    struct Where location = here();
    LOOP_NEST_FACTOR *= 3;
    u16 saved_enclosing_kind = ENCLOSING_STATEMENT_KIND;
    ENCLOSING_STATEMENT_KIND = 2;
    save_bytes(saved, LOOP_CONTEXT_P, LOOP_SIZE);
    LOOP_BREAK = NEW_LABEL_IF_ENABLED();
    LOOP_CONTINUE = NEW_LABEL_IF_ENABLED();
    LOOP_CONTINUED = 0;
    u16 top = NEW_LABEL_IF_ENABLED();
    ADVANCE_TOKEN();
    expect_token(1, 0x3E, STR_WHILE_P);
    if (CPP_MODE)
        scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    u16 expr = CHECK_CONDITION_EXPR(PARSE_COMMA_EXPRESSION(2));
    if (CPP_MODE) {
        expr = APPEND_TEMP_DESTRUCTORS(expr, scope);
        LOOP_BREAK_SCOPE = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
        LOOP_SCOPE = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    }
    u16 kind = CONSTANT_TRUTH_VALUE(expr);
    u16 exit_jump = kind == 2 ? MAKE_JUMP_IF_TRUE_BLOCK(expr, top, location.third, location.second, location.first) : 0;
    if (kind != 1)
        jump_block(LOOP_CONTINUE, nowhere());
    if (kind)
        APPEND_BLOCK_AND_MARK(top);
    expect_token(2, 0x3F, STR_WHILE_P);
    if (!kind)
        CODE_UNREACHABLE = 1;
    PARSE_STATEMENT_CPP(0);
    CODE_UNREACHABLE = 0;
    if (CPP_MODE)
        RELEASE_SCOPE_OBJECTS(LOOP_BREAK_SCOPE);
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTINUE);
    switch (kind) {
    case 1:
        jump_block(top, location);
        CODE_UNREACHABLE = !LOOP_CONTINUED;
        break;
    case 2:
        APPEND_BLOCK_IF_NONZERO(exit_jump);
        break;
    }
    APPEND_BLOCK_IF_NONZERO(LOOP_BREAK);
    restore_bytes(LOOP_CONTEXT_P, saved, LOOP_SIZE);
    ENCLOSING_STATEMENT_KIND = saved_enclosing_kind;
    LOOP_NEST_FACTOR /= 3;
    --STATEMENT_NEST_DEPTH;
}

/* do statement while (condition);  top: body, continue label: the test branching back to
   top, break label */
void PARSE_DO(void)
{
    u8 saved[LOOP_SIZE];
    u16 scope = 0;
    IN_ERROR_RECOVERY = 0;
    ++STATEMENT_NEST_DEPTH;
    u16 saved_enclosing_kind = ENCLOSING_STATEMENT_KIND;
    ENCLOSING_STATEMENT_KIND = 2;
    LOOP_NEST_FACTOR *= 3;
    save_bytes(saved, LOOP_CONTEXT_P, LOOP_SIZE);
    LOOP_BREAK = NEW_LABEL_IF_ENABLED();
    LOOP_CONTINUE = NEW_LABEL_IF_ENABLED();
    LOOP_CONTINUED = 0;
    if (CPP_MODE) {
        LOOP_BREAK_SCOPE = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
        LOOP_SCOPE = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    }
    u16 top = NEW_LABEL_IF_ENABLED();
    APPEND_BLOCK_AND_MARK(top);
    ADVANCE_TOKEN();
    PARSE_STATEMENT_CPP(0);
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTINUE);
    if (CPP_MODE)
        RELEASE_SCOPE_OBJECTS(LOOP_BREAK_SCOPE);
    if (CURRENT_TOKEN == TOK_WHILE) {
        struct Where location = here();
        ADVANCE_TOKEN();
        expect_token(1, 0x3E, STR_DO_WHILE_P);
        if (CPP_MODE)
            scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
        u16 expr = CHECK_CONDITION_EXPR(PARSE_COMMA_EXPRESSION(2));
        if (CPP_MODE)
            expr = APPEND_TEMP_DESTRUCTORS(expr, scope);
        switch (CONSTANT_TRUTH_VALUE(expr)) {
        case 1:
            jump_block(top, location);
            CODE_UNREACHABLE = !LOOP_CONTINUED;
            break;
        case 2:
            APPEND_JUMP_IF_TRUE_BLOCK(expr, top, location.third, location.second, location.first);
            break;
        }
        expect_token(2, 0x3F, STR_DO_WHILE_P);
    } else {
        REPORT_CURRENT_TOKEN(MSG_DO_STATEMENT_MUST_HAVE);
        IN_ERROR_RECOVERY = 1;
    }
    APPEND_BLOCK_IF_NONZERO(LOOP_BREAK);
    if (CURRENT_TOKEN == TOK_SEMICOLON)
        ADVANCE_TOKEN();
    else
        REPORT_DIAGNOSTIC(MSG_STATEMENT_MISSING_64, (i32)STR_DO_WHILE_P, 0);
    restore_bytes(LOOP_CONTEXT_P, saved, LOOP_SIZE);
    LOOP_NEST_FACTOR /= 3;
    ENCLOSING_STATEMENT_KIND = saved_enclosing_kind;
    --STATEMENT_NEST_DEPTH;
}

/* for (init; condition; step) statement.  In C++ init may be a declaration.  Laid out as
   for while, with the step block after the continue label.  token is the statement's
   declaration permission flag, unused here */
void PARSE_FOR(u8 token)
{
    (void)token;
    u8 saved[LOOP_SIZE];
    u16 scope = 0;
    IN_ERROR_RECOVERY = 0;
    ++STATEMENT_NEST_DEPTH;
    ADVANCE_TOKEN();
    expect_token(1, 0x3E, STR_FOR_P);
    save_bytes(saved, LOOP_CONTEXT_P, LOOP_SIZE);
    LOOP_BREAK = NEW_LABEL_IF_ENABLED();
    LOOP_CONTINUE = NEW_LABEL_IF_ENABLED();
    LOOP_CONTINUED = 0;
    if (CURRENT_TOKEN == TOK_SEMICOLON)
        ADVANCE_TOKEN();
    else if (CPP_MODE && TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) && IS_DECLARATION_AHEAD()) {
        IN_ERROR_RECOVERY = 0;
        PARSE_DECLARATION(0);
    } else
        PARSE_EXPRESSION_STATEMENT();
    LOOP_NEST_FACTOR *= 3;
    struct Where location = here();
    if (CPP_MODE)
        scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    u16 expr = CURRENT_TOKEN == TOK_SEMICOLON ? 0 : CHECK_CONDITION_EXPR(PARSE_COMMA_EXPRESSION(2));
    if (CPP_MODE)
        expr = APPEND_TEMP_DESTRUCTORS(expr, scope);
    u16 top = NEW_LABEL_IF_ENABLED();
    u16 kind = expr == 0 ? 1 : CONSTANT_TRUTH_VALUE(expr);
    u16 exit_jump = kind == 2 ? MAKE_JUMP_IF_TRUE_BLOCK(expr, top, location.third, location.second, location.first) : 0;
    if (CURRENT_TOKEN == TOK_SEMICOLON)
        ADVANCE_TOKEN();
    else
        REPORT_DIAGNOSTIC(MSG_STATEMENT_MISSING_64, (i32)STR_FOR_P, 0);
    location = here();
    if (CPP_MODE)
        scope = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    expr = CURRENT_TOKEN == TOK_RPAREN ? 0 : ANALYZE_AND_DECAY(PARSE_COMMA_EXPRESSION(2), VOID_TYPE);
    if (CPP_MODE)
        expr = APPEND_TEMP_DESTRUCTORS(expr, scope);
    if (expr && IS_SIDE_EFFECT_FREE(expr) && EXPR_W(expr, EXPR_TYPE) != VOID_TYPE)
        REPORT_CURRENT_TOKEN(MSG_CODE_HAS_NO_EFFECT);
    expr = SIMPLIFY_EXPRESSION(expr, 1);
    u16 step = expr == 0 ? 0 : MAKE_EXPRESSION_BLOCK(expr, location.third, location.second, location.first);
    expect_token(2, 0x3F, STR_FOR_P);
    u16 saved_enclosing_kind = ENCLOSING_STATEMENT_KIND;
    ENCLOSING_STATEMENT_KIND = 2;
    u16 next = NEW_LABEL_IF_ENABLED();
    if (kind != 1)
        jump_block(next, nowhere());
    if (kind)
        APPEND_BLOCK_AND_MARK(top);
    if (!kind)
        CODE_UNREACHABLE = 1;
    if (CPP_MODE) {
        LOOP_SCOPE = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
        LOOP_BREAK_SCOPE = SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS);
    }
    PARSE_STATEMENT_CPP(0);
    CODE_UNREACHABLE = 0;
    if (CPP_MODE)
        RELEASE_SCOPE_OBJECTS(LOOP_BREAK_SCOPE);
    APPEND_BLOCK_IF_NONZERO(LOOP_CONTINUE);
    APPEND_BLOCK_IF_NONZERO(step);
    APPEND_BLOCK_IF_NONZERO(next);
    switch (kind) {
    case 1:
        jump_block(top, nowhere());
        CODE_UNREACHABLE = !LOOP_CONTINUED;
        break;
    case 2:
        APPEND_BLOCK_IF_NONZERO(exit_jump);
        break;
    }
    APPEND_BLOCK_IF_NONZERO(LOOP_BREAK);
    restore_bytes(LOOP_CONTEXT_P, saved, LOOP_SIZE);
    LOOP_NEST_FACTOR /= 3;
    ENCLOSING_STATEMENT_KIND = saved_enclosing_kind;
    --STATEMENT_NEST_DEPTH;
}

/* continue;  destroys the objects of the scopes being left (C++) and jumps to the loop's
   continue label; outside a loop it is an error */
void PARSE_CONTINUE(void)
{
    if (LOOP_NEST_FACTOR == 1)
        REPORT_CURRENT_TOKEN(MSG_MISPLACED_CONTINUE);
    else
        IN_ERROR_RECOVERY = 0;
    if (CPP_MODE & !CODE_UNREACHABLE)
        APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), LOOP_BREAK_SCOPE));
    jump_block(LOOP_CONTINUE, nowhere());
    CODE_UNREACHABLE = 1;
    ADVANCE_TOKEN();
    REQUIRE_TOKEN_BODY(7, 0xEA);
}

/* break;  jumps to the break label of the innermost loop or switch, destroying the
   objects being left first */
void PARSE_BREAK(void)
{
    if (ENCLOSING_STATEMENT_KIND == 2) {
        IN_ERROR_RECOVERY = 0;
        if (CPP_MODE && !CODE_UNREACHABLE)
            APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), LOOP_SCOPE));
        jump_block(LOOP_BREAK, nowhere());
        LOOP_CONTINUED = 1;
    } else if (ENCLOSING_STATEMENT_KIND == 1) {
        IN_ERROR_RECOVERY = 0;
        if (CPP_MODE) {
            if (SWITCH_DEPTH == STATEMENT_NEST_DEPTH)
                RELEASE_SCOPE_OBJECTS(SWITCH_SCOPE);
            else if (!CODE_UNREACHABLE)
                APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), SWITCH_SCOPE));
        }
        SWITCH_HAS_DEFAULT = 1;
        SWITCH_NO_FALL = 1;
        jump_block(SWITCH_BREAK, nowhere());
    } else
        REPORT_CURRENT_TOKEN(MSG_MISPLACED_BREAK);
    ADVANCE_TOKEN();
    CODE_UNREACHABLE = 1;
    REQUIRE_TOKEN_BODY(7, 0xEA);
}

/* return [value];  the value is stored through the function's return slot
   (MAKE_RETURN_SLOT; operator 5Fh builds the store).  When destructors must run after the
   value is computed, a non-class value is saved in a temporary first.  In a constructor or
   destructor (CTOR_DTOR_MODE 1 or 2) a plain return jumps to CPP_BODY_END_LABEL.
   SAW_RETURN_WITH_VALUE and SAW_RETURN_WITHOUT_VALUE feed the end-of-function warnings;
   #pragma noretval silences "function should return a value" once */
void PARSE_RETURN(void)
{
    u16 node, list;
    IN_ERROR_RECOVERY = 0;
    struct Where where = here();
    ADVANCE_TOKEN();
    u16 type = TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_TARGET);
    if (TYPE_FLAGS_AT(CURRENT_TOKEN) & EXPR_START_FLAG_MASK) {
        if (type == VOID_TYPE)
            REPORT_DIAGNOSTIC(CPP_MODE ? MSG_CANNOT_RETURN_VALUE : MSG_VOID_FUNCTIONS_MAY_NOT, (i32)FORMAT_SYMBOL(BCC_TREE_SPECIAL), 0);
        else if (CTOR_DTOR_MODE == 1)
            REPORT_DIAGNOSTIC(MSG_CANNOT_RETURN_VALUE, (i32)FORMAT_SYMBOL(BCC_TREE_SPECIAL), 0);
        else
            SAW_RETURN_WITH_VALUE = 1;
        node = PARSE_COMMA_EXPRESSION(7);
        if (CPP_MODE && !CODE_UNREACHABLE)
            list = BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), SCOPE_W(GLOBAL_SCOPE, SCOPE_TEMPS));
        else
            list = 0;
        u16 special = MAKE_RETURN_SLOT(BCC_TREE_SPECIAL);
        if (list) {
            if (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) {
                node = MAKE_BINARY_NODE(0x5F, special, node);
                EXPR_W(node, EXPR_TYPE) = type;
                node = JOIN_COMMA_EXPR(node, list);
            } else {
                u16 temp = MAKE_SYMBOL_NODE(CREATE_LOCAL_TEMP(type));
                node = JOIN_COMMA_EXPR(MAKE_BINARY_NODE(5, temp, node), list);
                temp = MAKE_BINARY_NODE(0x5F, special, COPY_EXPR_TREE(temp));
                EXPR_W(temp, EXPR_TYPE) = type;
                node = JOIN_COMMA_EXPR(node, temp);
            }
        } else {
            node = MAKE_BINARY_NODE(0x5F, special, node);
            EXPR_W(node, EXPR_TYPE) = type;
        }
        node = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node, VOID_TYPE), 0);
        APPEND_RETURN_JUMP_BLOCK(node, where.third, where.second, where.first);
    } else {
        SAW_RETURN_WITHOUT_VALUE = 1;
        if (!(CTOR_DTOR_MODE == 1 || CTOR_DTOR_MODE == 2) && type != VOID_TYPE && !PRAGMA_NORETVAL_PENDING)
            REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_FUNCTION_SHOULD_RETURN : MSG_FUNCTION_SHOULD_RETURN_367);
        node = 0;
        if (CTOR_DTOR_MODE == 2 || CTOR_DTOR_MODE == 1) {
            APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), SCOPE_W(BCC_TREE_LINK, SCOPE_TEMPS)));
            jump_block(CPP_BODY_END_LABEL, nowhere());
        } else {
            if (CPP_MODE)
                APPEND_ANALYZED_EXPRESSION(BUILD_TEMP_DESTRUCTORS(SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS), SCOPE_W(GLOBAL_SCOPE, SCOPE_TEMPS)));
            node = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node, VOID_TYPE), 1);
            APPEND_RETURN_JUMP_BLOCK(node, where.third, where.second, where.first);
        }
    }
    REQUIRE_TOKEN_BODY(7, 0xEA);
    CODE_UNREACHABLE = 1;
    PRAGMA_NORETVAL_PENDING = 0;
}

/* warns once if the statement about to be parsed cannot be reached */
void REPORT_UNREACHABLE_CODE(void)
{
    if (CODE_UNREACHABLE) {
        REPORT_CURRENT_TOKEN(MSG_UNREACHABLE_CODE);
        CODE_UNREACHABLE = 0;
    }
}

/* one statement (with its labels).  flag nonzero means a declaration is allowed here
   (directly in a block); in C, declarations after statements are also reported.  Tokens
   that can start an expression go to PARSE_EXPRESSION_STATEMENT; anything else is
   "statement missing" and skipped to ';' */
void PARSE_STATEMENT_CPP(u8 flag)
{
    PARSE_LABELS();
    if (CPP_MODE && CURRENT_TOKEN == TOK_EXTERN && peek_kind() == 0x34) {
        REPORT_CURRENT_TOKEN(MSG_LINKAGE_SPECIFICATION);
        ADVANCE_TOKEN();
        ADVANCE_TOKEN();
    }
    if (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) && (!CPP_MODE || IS_DECLARATION_AHEAD())) {
        IN_ERROR_RECOVERY = 0;
        if (!flag || (!CPP_MODE && SCOPE_W(CURRENT_SCOPE, SCOPE_STMT_LEVEL) >= BLOCK_NEST_LEVEL))
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_NOT);
        PARSE_DECLARATION(0);
        return;
    }
    SCOPE_W(CURRENT_SCOPE, SCOPE_STMT_LEVEL) = BLOCK_NEST_LEVEL;
    switch (CURRENT_TOKEN) {
    case TOK_ASM:
        REPORT_UNREACHABLE_CODE();
        PARSE_ASM_STATEMENT();
        TOKEN_TYPE = 0x82;
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
        IN_ERROR_RECOVERY = 1;
        ADVANCE_TOKEN();
        SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
        break;
    }
}

/* statements up to the '}' of the current block (TYPE_FLAGS bits 100h and 8 mark tokens
   that can start a statement or declaration) */
void PARSE_STATEMENT_LIST(void)
{
    u16 saved = SWITCH_OUTER;
    do {
        while ((TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x100) || (TYPE_FLAGS_AT(CURRENT_TOKEN) & 8))
            PARSE_STATEMENT_CPP(1);
        if (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) {
            REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            IN_ERROR_RECOVERY = 1;
            SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
        } else if (CURRENT_TOKEN != TOK_RBRACE) {
            REPORT_CURRENT_TOKEN(MSG_COMPOUND_STATEMENT);
            IN_ERROR_RECOVERY = 1;
            SKIP_TO_SYNC_TOKEN(TOK_RBRACE);
        }
    } while ((TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x100) || (TYPE_FLAGS_AT(CURRENT_TOKEN) & 8));
    SWITCH_OUTER = saved;
}

/* { statements }  If declarations opened a scope for this block, its objects are
   destroyed and the scope is closed at the '}' */
void PARSE_COMPOUND_STATEMENT(void)
{
    REQUIRE_TOKEN_BODY(5, 0xD8);
    BLOCK_NEST_LEVEL++;
    PARSE_STATEMENT_LIST();
    if (SCOPE_W(CURRENT_SCOPE, SCOPE_NEST_LEVEL) == BLOCK_NEST_LEVEL) {
        if (CPP_MODE)
            RELEASE_SCOPE_OBJECTS(SCOPE_W(SCOPE_W(CURRENT_SCOPE, SCOPE_PARENT), SCOPE_TEMPS));
        APPEND_SCOPE_EXIT_BLOCK();
        POP_SCOPE(0);
    }
    REQUIRE_TOKEN_BODY(6, 0x1D);
    BLOCK_NEST_LEVEL--;
}

/* a function body.  In C++ CTOR_THIS_SYMBOL is set to the symbol of "this" (if any).
   Creates and places CPP_BODY_END_LABEL, parses the statements, then warns if a non-void
   function (other than main in C++) has no return, or mixes "return;" with "return
   value;", and reports undefined labels */
void PARSE_FUNCTION_BODY(void)
{
    if (CPP_MODE)
        CTOR_THIS_SYMBOL = LOOKUP_NAME(THIS_NAME);
    REQUIRE_TOKEN_BODY(5, 0xD8);
    BLOCK_NEST_LEVEL++;
    CPP_BODY_END_LABEL = NEW_LABEL_IF_ENABLED();
    APPEND_BLOCK_IF_NONZERO(CPP_BODY_END_LABEL);
    PARSE_STATEMENT_LIST();
    if (!(CPP_MODE && SYM_W(BCC_TREE_SPECIAL, SYM_NAME) == MAIN_SYMBOL && CURRENT_CLASS_TYPE == 0) &&
        TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_TARGET) != VOID_TYPE && !SAW_RETURN_WITH_VALUE && !SAW_RETURN_WITHOUT_VALUE &&
        !PRAGMA_NORETVAL_PENDING)
        REPORT_CURRENT_TOKEN(CPP_MODE ? MSG_FUNCTION_SHOULD_RETURN : MSG_FUNCTION_SHOULD_RETURN_367);
    if (SAW_RETURN_WITH_VALUE && SAW_RETURN_WITHOUT_VALUE)
        REPORT_DIAGNOSTIC(MSG_BOTH_RETURN_RETURN, (i32)FORMAT_SYMBOL(BCC_TREE_SPECIAL), 0);
    PRAGMA_NORETVAL_PENDING = 0;
    CHECK_UNDEFINED_LABELS();
}
