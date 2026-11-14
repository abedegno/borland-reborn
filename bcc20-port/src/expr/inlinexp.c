/* inlinexp.c: from bcc20/src/expr/INLINEXP.C: the expansion of calls to C++ inline
   functions (and compiler-made special members) into the calling expression.
   EXPAND_INLINE_CALL is reached from CHECK_CALL_ARGUMENTS.  The body was saved as tokens;
   REPLAY_FUNCTION_BODY seeks the token stream to it and parses it again with a statement
   parser that makes one expression of it: an expression statement becomes (void)e, a
   block a comma list, a declaration its initialisation, "return e" a cast of e to the
   return type (&e for a reference) after which the path is dead, "if" cond ? a : b (when
   only one branch returns, the statements after the if go into the other).  Then
   BIND_INLINE_PARAMETERS puts the call's arguments in for the parameters, directly (a
   copy) when used at most once or trivial, else through a temporary.  Constructors and
   destructors get extra work.  INLINE_FUNCTION_STACK lists the functions being expanded,
   so that a recursive call stays a call.

   The statement context is a 6-byte structure passed by pointer (+0 returned: a return
   was seen on this path; +1 the return type; +3 returns a reference; +4 the conditionals
   that still need the code after them), and the binding table a 9Fh-byte one (17 entries
   of 9 bytes: +0 name, +2 type, +4 value, +6 temporary, +8 by reference; +99h count, +9Bh
   setup list, +9Dh result), both in the scratch area.  The flags the PARSE_INLINE_*
   functions give mean "this part contains a return".

   PARSE_INLINE_STATEMENT returns an unset register for a stray "else" or a token that
   cannot start a statement; the port returns 0 there (README, decisions for the native
   build).  SUBSTITUTE_PARAMETERS' "out of memory" stack check is STACK_CHECK (native/stack.c). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "token.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "stack.h"

#define OP(n) EXPR_W((n), EXPR_OP)
#define LEFT(n) EXPR_W((n), EXPR_LEFT)
#define RIGHT(n) EXPR_W((n), EXPR_RIGHT)
#define TYPE_OF(n) EXPR_W((n), EXPR_TYPE)
#define FLAGS(t) EXPR_FLAGS_AT(TYPE_W((t), TYPE_KIND))

/* the statement context */
#define CTX_RETURNED(c) B(c)
#define CTX_TYPE(c) W(fp_add((c), 1))
#define CTX_BY_REF(c) B(fp_add((c), 3))
#define CTX_TEMPS(c) W(fp_add((c), 4))

/* the binding table */
#define ENTRY(m, i) fp_add((m), (i) * 9)
#define E_NAME(e) W(e)
#define E_TYPE(e) W(fp_add((e), 2))
#define E_VALUE(e) W(fp_add((e), 4))
#define E_TEMP(e) W(fp_add((e), 6))
#define E_BY_REF(e) B(fp_add((e), 8))
#define MAP_COUNT(m) SW(fp_add((m), 0x99))
#define MAP_LIST(m) W(fp_add((m), 0x9B))
#define MAP_RESULT(m) W(fp_add((m), 0x9D))
#define MAP_SIZE 0x9F

#define TOKEN_RECORD_SIZE 19
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)     /* the function being expanded */
#define RETURN_FORM_SEEN W(RETURN_FORM_SEEN_P)
#define LOOKAHEAD_KIND W(TOKEN_TYPE_P)
#define CURRENT_RECORD_KIND W(CURRENT_TOKEN_RECORD_P)

static u16 peek_kind(void)
{
    PEEK_TOKEN();
    return LOOKAHEAD_KIND;
}

/* statements and declarations up to the end of the block (while the token can start
   one, TYPE_FLAGS 108h) joined with commas; *flag set when one of them returns */
u16 PARSE_INLINE_STATEMENTS(farptr flag, farptr context)
{
    u16 list = 0;
    B(flag) = 0;
    while (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x108) {
        u16 item;
        if (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) && peek_kind() != 0x67 && peek_kind() != 1) {
            IN_ERROR_RECOVERY = 0;
            item = PARSE_DECLARATION(1);
        } else {
            u16 mark = scratch_mark();
            farptr sub = scratch_alloc(2);
            item = PARSE_INLINE_STATEMENT(sub, context);
            if (B(sub))
                B(flag) = 1;
            scratch_release(mark);
        }
        list = JOIN_COMMA_EXPR(list, item);
    }
    return list;
}

/* list tail appended to list head (cells linked through EXPR_LEFT) */
u16 APPEND_EXPR_CHAIN(u16 head, u16 tail)
{
    if (!head)
        return tail;
    u16 node = head;
    while (LEFT(node))
        node = LEFT(node);
    LEFT(node) = tail;
    return head;
}

/* for each pending conditional in the list node, a copy of expr (the statements after an
   if) appended to the arm that did not return; flag (expr itself returns) takes the entry
   off the list */
void APPEND_TAIL_TO_BRANCHES(u16 node, u16 expr, u8 flag)
{
    if (!expr)
        return;
    for (; node; node = LEFT(node)) {
        if (!RIGHT(node))
            continue;
        u16 inner = RIGHT(RIGHT(node));
        u16 copy = COPY_EXPR_TREE(expr);
        u16 joined = JOIN_COMMA_EXPR(RIGHT(inner), copy);
        RIGHT(inner) = joined;
        if (flag)
            RIGHT(node) = 0;
        else if (OP(copy) == 0x45)
            RIGHT(node) = copy;
    }
}

/* "if (cond) stmt [else stmt]" as cond ? then : else (missing arms 0).  When only the else
   arm returns, the arms are swapped and the condition negated.  chained is 1 for a
   statement-level if, whose following statements may go into the arm that does not
   return.  A dead if (after a return) is parsed and dropped */
u16 PARSE_INLINE_IF(u8 chained, farptr flag, farptr context)
{
    u16 mark = scratch_mark();
    farptr flags = scratch_alloc(4);       /* then, else, sub */
    farptr then_flag = flags, else_flag = fp_add(flags, 1), sub = fp_add(flags, 2);
    u8 saved = CTX_RETURNED(context);
    B(then_flag) = 0;
    B(else_flag) = 0;
    B(flag) = 0;
    u16 list = CTX_TEMPS(context);
    CTX_TEMPS(context) = 0;
    IN_ERROR_RECOVERY = 0;
    ADVANCE_TOKEN();
    TREE_INVOKE(1, 0x3E, FP_SEG(STR_IF_2_P), FP_OFF(STR_IF_2_P));
    u16 condition = PARSE_COMMA_EXPRESSION(2);
    TREE_INVOKE(2, 0x3F, FP_SEG(STR_IF_2_P), FP_OFF(STR_IF_2_P));
    u16 then_part = PARSE_INLINE_STATEMENT(then_flag, context);
    CTX_RETURNED(context) = saved;
    u8 any = B(then_flag) && CTX_TEMPS(context);
    list = APPEND_EXPR_CHAIN(CTX_TEMPS(context), list);
    CTX_TEMPS(context) = 0;
    u16 else_part = 0;
    if (CURRENT_TOKEN == TOK_ELSE) {
        ADVANCE_TOKEN();
        IN_ERROR_RECOVERY = 0;
        else_part = CURRENT_TOKEN == TOK_IF ? PARSE_INLINE_IF(0, else_flag, context)
                                            : PARSE_INLINE_STATEMENT(else_flag, context);
        CTX_RETURNED(context) = saved;
        any = any || (B(else_flag) && CTX_TEMPS(context));
        list = APPEND_EXPR_CHAIN(CTX_TEMPS(context), list);
        CTX_TEMPS(context) = 0;
    }
    if (B(else_flag) && !B(then_flag)) {
        u16 swap = then_part;
        then_part = else_part;
        else_part = swap;
        condition = MAKE_UNARY_NODE(0x2A, condition);
        B(then_flag) = 1;
        B(else_flag) = 0;
    }
    if (chained && (any || (B(then_flag) & !B(else_flag)))) {
        B(sub) = 0;
        u16 item = PARSE_INLINE_STATEMENTS(sub, context);
        APPEND_TAIL_TO_BRANCHES(list, item, B(sub));
        list = APPEND_EXPR_CHAIN(CTX_TEMPS(context), list);
        if (!B(else_flag))
            else_part = JOIN_COMMA_EXPR(else_part, item);
        B(else_flag) = B(else_flag) || B(sub);
    }
    CTX_TEMPS(context) = list;
    u8 then_returns = B(then_flag), else_returns = B(else_flag);
    scratch_release(mark);
    if (saved) {
        FREE_EXPR_TREE(condition);
        return 0;
    }
    if (!then_part)
        then_part = MAKE_INT_CONSTANT(INT_TYPE, 0);
    if (!else_part)
        else_part = MAKE_INT_CONSTANT(INT_TYPE, 0);
    u16 result = MAKE_CONDITIONAL_NODE(0x6B, condition, then_part, else_part);
    if (else_returns) {
        CTX_RETURNED(context) = 1;
        B(flag) = 1;
    } else if (then_returns) {
        u16 temps = MAKE_LIST_NODE(result, CTX_TEMPS(context));
        CTX_TEMPS(context) = temps;
        B(flag) = 1;
    }
    return result;
}

/* one statement of an inline body as an expression; labels ("name :" and a stray ":")
   are skipped.  0 for dead code (after a return) */
u16 PARSE_INLINE_STATEMENT(farptr flag, farptr context)
{
    u16 result = 0;     /* unset in the original for "else" and bad tokens */
    u8 saved = CTX_RETURNED(context);
    while ((CURRENT_TOKEN == TOK_IDENT && peek_kind() == 0x21) || CURRENT_TOKEN == TOK_COLON) {
        if (CURRENT_TOKEN != TOK_COLON)
            ADVANCE_TOKEN();
        ADVANCE_TOKEN();
    }
    B(flag) = 0;
    switch (CURRENT_TOKEN) {
    case TOK_SEMICOLON:
        ADVANCE_TOKEN();
        result = MAKE_INT_CONSTANT(INT_TYPE, 0);
        break;
    case TOK_LBRACE:
        result = PARSE_INLINE_BLOCK(flag, context);
        break;
    case TOK_IF:
        result = PARSE_INLINE_IF(1, flag, context);
        break;
    case TOK_ELSE:
        ADVANCE_TOKEN();
        break;
    case TOK_RETURN:
        if (TYPE_FLAGS_AT(peek_kind()) & EXPR_START_FLAG_MASK) {
            ADVANCE_TOKEN();
            result = PARSE_COMMA_EXPRESSION(7);
        } else {
            result = MAKE_INT_CONSTANT(INT_TYPE, 0);
            ADVANCE_TOKEN();
        }
        REQUIRE_TOKEN_BODY(7, 0xEA);
        if (!CTX_RETURNED(context)) {
            result = CTX_BY_REF(context) ? MAKE_UNARY_NODE(0x1D, result) : MAKE_CAST_NODE(CTX_TYPE(context), result);
            B(flag) = 1;
            CTX_RETURNED(context) = 1;
        }
        break;
    case TOK_LPAREN: case TOK_PLUS: case TOK_MINUS: case TOK_STAR: case TOK_AMPERSAND: case TOK_COLON:
    case TOK_NOT: case TOK_TILDE: case TOK_SIZEOF: case TOK_INC: case TOK_DEC:
    case TOK_IDENT: case 0x32: case 0x33: case 0x34:
    case 0x65: case TOK_SCOPE: case TOK_DELETE: case TOK_NEW: case TOK_OPERATOR: case TOK_THIS:
        result = MAKE_CAST_NODE(VOID_TYPE, PARSE_COMMA_EXPRESSION(7));
        REQUIRE_TOKEN_BODY(7, 0xEA);
        break;
    default:
        SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
    }
    if (saved) {
        FREE_EXPR_TREE(result);
        return 0;
    }
    return result;
}

/* { ... } as a comma list, the block's scope closed */
u16 PARSE_INLINE_BLOCK(farptr flag, farptr context)
{
    if (CURRENT_TOKEN == TOK_LBRACE)
        ADVANCE_TOKEN();
    BLOCK_NEST_LEVEL++;
    u16 result = PARSE_INLINE_STATEMENTS(flag, context);
    if (SCOPE_W(CURRENT_SCOPE, SCOPE_NEST_LEVEL) == BLOCK_NEST_LEVEL)
        POP_SCOPE(1);
    if (CURRENT_TOKEN == TOK_RBRACE)
        ADVANCE_TOKEN();
    BLOCK_NEST_LEVEL--;
    return result;
}

/* the index of the parameter symbol name in the binding table, or -1 (EXPR_REGISTER_NEED
   in the target table; FLOWBLK.C has another function of that name, so the port keeps
   this one inside the file) */
static i16 binding_index(u16 name, farptr map)
{
    i16 index;
    for (index = 0; index < MAP_COUNT(map) && E_NAME(ENTRY(map, index)) != name; index++)
        ;
    if (MAP_COUNT(map) == index)
        index = -1;
    return index;
}

/* a parameter used as an lvalue (assigned, incremented, its address taken): reference
   parameters and named object arguments go in directly; else the argument is copied once
   into a temporary that is then used, since the function may change its own copy.  For
   the first parameter of a member function ("this", index 0) the temporary becomes the
   map's result and CTOR_THIS_ASSIGNED says whether it was assigned (flag) */
u16 SUBSTITUTE_LVALUE_PARAM(u16 node, farptr map, u8 flag)
{
    if (OP(node) == EOP_DOT) {
        u16 left = SUBSTITUTE_LVALUE_PARAM(LEFT(node), map, flag);
        LEFT(node) = left;
    } else if (OP(node) == 1) {
        i16 index = binding_index(LEFT(node), map);
        if (index != -1) {
            farptr entry = ENTRY(map, index);
            if ((E_BY_REF(entry) || IS_NAMED_OBJECT_EXPR(E_VALUE(entry))) &&
                (!(EXPR_B(node, EXPR_NODE_FLAGS) & 1) || index || !CURRENT_CLASS_TYPE)) {
                if (E_TEMP(entry))
                    LEFT(node) = E_TEMP(entry);
                else {
                    FREE_EXPR_NODE(node);
                    node = COPY_EXPR_TREE(E_VALUE(entry));
                    if (E_BY_REF(entry))
                        EXPR_W(node, EXPR_TYPE) = E_TYPE(entry);
                }
            } else {
                if (!E_TEMP(entry)) {
                    u16 type = E_TYPE(entry);
                    E_TEMP(entry) = CREATE_LOCAL_TEMP(type);
                    u16 symbol = MAKE_SYMBOL_NODE(E_TEMP(entry));
                    u16 copy = COPY_EXPR_TREE(E_VALUE(entry));
                    u16 declaration = MAKE_BINARY_NODE(5, symbol, copy);
                    MAP_LIST(map) = JOIN_COMMA_EXPR(MAP_LIST(map), declaration);
                }
                if (index == 0 && CURRENT_CLASS_TYPE) {
                    MAP_RESULT(map) = E_TEMP(entry);
                    CTOR_THIS_ASSIGNED = flag;
                }
                LEFT(node) = E_TEMP(entry);
            }
        }
    } else
        node = SUBSTITUTE_PARAMETERS(node, map);
    return node;
}

/* one use (a symbol leaf) of a parameter replaced by its temporary or a copy of the
   argument; "this" used as an object in a member function made an address again */
u16 SUBSTITUTE_PARAMETER(u16 node, farptr map)
{
    i16 index = binding_index(LEFT(node), map);
    if (index == -1)
        return node;
    SYM_B(LEFT(node), SYM_FLAGS) |= 4;
    u8 convert = (EXPR_B(node, EXPR_NODE_FLAGS) & 1) && index == 0 && CURRENT_CLASS_TYPE &&
                 (!(FLAGS(TYPE_OF(node)) & 0x14) || !(TYPE_B(TYPE_OF(node), TYPE_ATTRS) & 0x20));
    farptr entry = ENTRY(map, index);
    if (E_TEMP(entry)) {
        LEFT(node) = E_TEMP(entry);
        return node;
    }
    FREE_EXPR_NODE(node);
    node = COPY_EXPR_TREE(E_VALUE(entry));
    if (E_BY_REF(entry) && !convert)
        EXPR_W(node, EXPR_TYPE) = E_TYPE(entry);
    if (convert)
        node = MAKE_ADDRESS_OF(CONVERT_TO_RVALUE(node));
    return node;
}

/* every parameter use in the body substituted; the targets of assignments, ++, -- and &
   through SUBSTITUTE_LVALUE_PARAM */
u16 SUBSTITUTE_PARAMETERS(u16 node, farptr map)
{
    STACK_CHECK(SUBSTITUTE_PARAMETERS);     /* if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY): native/stack.c */
    if (!node || OP(node) == 0)
        return node;
    if (OP(node) == 1)
        return SUBSTITUTE_PARAMETER(node, map);
    if (EXPR_OP_FLAGS_AT(OP(node)) & 4)
        return node;
    u16 operand;
    if (OP(node) == EOP_INC || OP(node) == EOP_DEC ||
        (EXPR_I(node, EXPR_OP) >= EOP_ASSIGN && EXPR_I(node, EXPR_OP) <= EOP_XOR_ASSIGN))
        operand = SUBSTITUTE_LVALUE_PARAM(LEFT(node), map, 1);
    else if (OP(node) == EOP_ADDR && OP(LEFT(node)) == 1)
        operand = SUBSTITUTE_LVALUE_PARAM(LEFT(node), map, 0);
    else
        operand = SUBSTITUTE_PARAMETERS(LEFT(node), map);
    LEFT(node) = operand;
    operand = SUBSTITUTE_PARAMETERS(RIGHT(node), map);
    RIGHT(node) = operand;
    return node;
}

/* the symbol under an lvalue (the right side of commas, the left of everything else) */
u16 FIND_LVALUE_SYMBOL(u16 node)
{
    while (OP(node) != 1)
        node = OP(node) == EOP_COMMA ? RIGHT(node) : LEFT(node);
    return LEFT(node);
}

/* 1 for arguments cheap enough to repeat: symbols, constants, member pointer constants
   (48h) and &symbol */
u8 IS_TRIVIAL_ARGUMENT(u16 node)
{
    switch (OP(node)) {
    case 1: case EOP_CONST: case 3: case 0x48:
        return 1;
    case EOP_ADDR:
        return OP(LEFT(node)) == 1;
    default:
        return 0;
    }
}

/* the number of leaves in the tree that name the symbol name */
u16 COUNT_SYMBOL_USES(u16 name, u16 node)
{
    if (!node || OP(node) == 0)
        return 0;
    if (OP(node) == 1)
        return LEFT(node) == name;
    if (EXPR_OP_FLAGS_AT(OP(node)) & 4)
        return 0;
    return COUNT_SYMBOL_USES(name, LEFT(node)) + COUNT_SYMBOL_USES(name, RIGHT(node));
}

/* the binding table from the parameters of the function being expanded
   (BCC_TREE_SPECIAL) and the call's arguments, then substituted into body.  A class
   argument by value that needs construction (TYPE_ATTRS 4) is taken by address.  An
   argument used more than once and not trivial is evaluated first into a temporary (or, a
   named object, evaluated for its side effects and then reused).  Returns (setup, body);
   MEMBER_INIT_EXPR is substituted too when the constructor assigned to "this" */
u16 BIND_INLINE_PARAMETERS(u16 call, u16 body)
{
    u16 mark = scratch_mark();
    farptr map = scratch_alloc(MAP_SIZE);
    MAP_LIST(map) = 0;
    u16 argument = RIGHT(call);
    MAP_COUNT(map) = 0;
    MAP_RESULT(map) = 0;
    CTOR_THIS_ASSIGNED = 0;
    for (u16 parameter = TYPE_W(SYM_W(BCC_TREE_SPECIAL, SYM_TYPE), TYPE_PARAMS); parameter;
         parameter = FORMAL_W(parameter, FORMAL_NEXT)) {
        farptr entry = ENTRY(map, MAP_COUNT(map));
        MAP_COUNT(map)++;
        E_NAME(entry) = FIND_NAME_IN_LIST(FORMAL_W(parameter, FORMAL_NAME), SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES));
        E_TYPE(entry) = FORMAL_W(parameter, FORMAL_TYPE);
        E_BY_REF(entry) = (FLAGS(E_TYPE(entry)) & 0x14) && (TYPE_B(E_TYPE(entry), TYPE_ATTRS) & 0x20);
        u8 reference = (FLAGS(E_TYPE(entry)) & 0x40) && (TYPE_B(E_TYPE(entry), TYPE_ATTRS) & 4);
        if (reference) {
            u16 by_address = ANALYZE_AND_DECAY(MAKE_UNARY_NODE(0x18, RIGHT(argument)), 0);
            RIGHT(argument) = by_address;
        }
        u16 simplified = SIMPLIFY_EXPRESSION(RIGHT(argument), 0);
        RIGHT(argument) = simplified;
        E_VALUE(entry) = RIGHT(argument);
        if (COUNT_SYMBOL_USES(E_NAME(entry), body) > 1 && !IS_TRIVIAL_ARGUMENT(E_VALUE(entry))) {
            if (IS_NAMED_OBJECT_EXPR(E_VALUE(entry))) {
                E_TEMP(entry) = FIND_LVALUE_SYMBOL(E_VALUE(entry));
                MAP_LIST(map) = JOIN_COMMA_EXPR(MAP_LIST(map), COPY_EXPR_TREE(E_VALUE(entry)));
            } else {
                E_TEMP(entry) = CREATE_LOCAL_TEMP(E_TYPE(entry));
                u16 symbol = MAKE_SYMBOL_NODE(E_TEMP(entry));
                u16 copy = COPY_EXPR_TREE(E_VALUE(entry));
                MAP_LIST(map) = JOIN_COMMA_EXPR(MAP_LIST(map), MAKE_BINARY_NODE(5, symbol, copy));
            }
        } else
            E_TEMP(entry) = 0;
        argument = LEFT(argument);
    }
    if (body)
        body = SUBSTITUTE_PARAMETERS(body, map);
    u16 result = JOIN_COMMA_EXPR(MAP_LIST(map), body);
    if (CTOR_THIS_ASSIGNED && MEMBER_INIT_EXPR) {
        MAP_LIST(map) = 0;
        MEMBER_INIT_EXPR = SUBSTITUTE_PARAMETERS(MEMBER_INIT_EXPR, map);
    }
    scratch_release(mark);
    return result;
}

/* the statements of a body in braces, with a flag slot of their own */
static u16 body_statements(farptr context)
{
    u16 mark = scratch_mark();
    farptr sub = scratch_alloc(2);
    u16 body = PARSE_INLINE_STATEMENTS(sub, context);
    scratch_release(mark);
    return body;
}

/* an ordinary inline function's body ({ expected), with the call's arguments bound */
u16 EXPAND_FUNCTION_BODY(u16 call, farptr context)
{
    IN_ERROR_RECOVERY = 0;
    TREE_INVOKE(5, 0xD8, 0, 0);
    BLOCK_NEST_LEVEL++;
    u16 body = body_statements(context);
    if (!body)
        body = MAKE_INT_CONSTANT(INT_TYPE, 0);
    return BIND_INLINE_PARAMETERS(call, body);
}

/* 1 when the tree assigns to the "this" symbol (CTOR_THIS_SYMBOL), the old C++ way for a
   constructor to choose its own storage */
u8 ASSIGNS_TO_THIS(u16 node)
{
    if (!node || OP(node) == 0 || (EXPR_OP_FLAGS_AT(OP(node)) & 4))
        return 0;
    if ((OP(node) == EOP_ASSIGN || OP(node) == 5) && LEFT(node) && OP(LEFT(node)) == 1 &&
        (EXPR_B(LEFT(node), EXPR_NODE_FLAGS) & 1))
        return LEFT(LEFT(node)) == CTOR_THIS_SYMBOL;
    return ASSIGNS_TO_THIS(LEFT(node)) || ASSIGNS_TO_THIS(RIGHT(node));
}

/* for a constructor that assigns to this: the call's object argument stored in a new
   temporary (CTOR_THIS_SYMBOL) and *(temp = arg, &this) passed instead, so that the caller
   sees the assignment */
u16 SAVE_THIS_ARG_IN_TEMP(u16 node)
{
    u16 type = TYPE_OF(RIGHT(RIGHT(node)));
    CTOR_THIS_SYMBOL = CREATE_LOCAL_TEMP(TYPE_OF(RIGHT(RIGHT(node))));
    u16 list = MAKE_BINARY_NODE(5, MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL), RIGHT(RIGHT(node)));
    list = JOIN_COMMA_EXPR(list, MAKE_ADDRESS_OF(BUILD_THIS_NODE(CTOR_THIS_SYMBOL)));
    u16 object = ANALYZE_AND_DECAY(MAKE_UNARY_NODE(0x18, list), 0);
    RIGHT(RIGHT(node)) = object;
    EXPR_W(RIGHT(RIGHT(node)), EXPR_TYPE) = type;
    return node;
}

/* an expanded constructor body *list completed: when the object argument is a null
   pointer (construct on the heap) the body runs only if BUILD_THIS_ALLOCATION succeeds;
   member initialisers go in front; the value of the whole is "this".  flag: the class
   probably assigns to this (TAG_CLASS_FLAGS 2) */
void FINISH_CONSTRUCTOR_BODY(u8 flag, farptr list, farptr call)
{
    u16 mark = scratch_mark();
    farptr changed = scratch_alloc(2);
    B(changed) = 0;
    u16 node = RIGHT(RIGHT(W(call)));
    if (OP(node) == 0x35) {
        u16 left = CHECK_NULL_CONSTANT(LEFT(node), changed);
        LEFT(node) = left;
    } else if (OP(node) == EOP_ADDR && OP(LEFT(node)) == EOP_DEREF) {
        u16 left = CHECK_NULL_CONSTANT(LEFT(LEFT(node)), changed);
        LEFT(LEFT(node)) = left;
    }
    u8 null_object = B(changed);
    scratch_release(mark);
    if (flag && ASSIGNS_TO_THIS(W(list)))
        W(call) = SAVE_THIS_ARG_IN_TEMP(W(call));
    else {
        if (null_object) {
            node = BUILD_THIS_ALLOCATION(CTOR_THIS_SYMBOL, CURRENT_CLASS_TYPE);
            W(list) = JOIN_COMMA_EXPR(MEMBER_INIT_EXPR, W(list));
            W(list) = MAKE_CONDITIONAL_NODE(0x6B, node, W(list), MAKE_INT_CONSTANT(INT_TYPE, 0));
        } else {
            W(list) = JOIN_COMMA_EXPR(MEMBER_INIT_EXPR, W(list));
            if (flag && ASSIGNS_TO_THIS(MEMBER_INIT_EXPR))
                W(call) = SAVE_THIS_ARG_IN_TEMP(W(call));
        }
        MEMBER_INIT_EXPR = 0;
    }
    W(list) = JOIN_COMMA_EXPR(W(list), BUILD_THIS_NODE(CTOR_THIS_SYMBOL));
}

/* FINISH_CONSTRUCTOR_BODY with the body and call in slots of their own */
static void finish_constructor(u8 flag, u16 *body, u16 *call)
{
    u16 mark = scratch_mark();
    farptr slots = scratch_alloc(4);
    W(slots) = *body;
    W(fp_add(slots, 2)) = *call;
    FINISH_CONSTRUCTOR_BODY(flag, slots, fp_add(slots, 2));
    *body = W(slots);
    *call = W(fp_add(slots, 2));
    scratch_release(mark);
}

/* an inline constructor's member initialiser list and body, with the arguments bound */
u16 EXPAND_CONSTRUCTOR_BODY(u16 call, farptr context)
{
    CTOR_DTOR_MODE = 1;
    IN_ERROR_RECOVERY = 0;
    CTOR_THIS_SYMBOL = FIND_NAME_IN_LIST(THIS_NAME, SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES));
    u8 member = (TAG_W(TYPE_W(CURRENT_CLASS_TYPE, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 2) != 0;
    u16 name = FIND_NAME_IN_LIST(VTABLE_PTR_NAME, SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES));
    MEMBER_INIT_EXPR = PARSE_MEMBER_INITIALIZERS(member, name);
    TREE_INVOKE(5, 0xD8, 0, 0);
    BLOCK_NEST_LEVEL++;
    u16 body = body_statements(context);
    CTOR_THIS_ASSIGNED = 0;
    CTOR_CHECK_THIS_ASSIGN = member;
    finish_constructor(member, &body, &call);
    return BIND_INLINE_PARAMETERS(call, body);
}

/* an inline destructor's body with the member and base destructor calls appended (the
   delete flag parameter passed on), all guarded by "this != 0" */
u16 EXPAND_DESTRUCTOR_BODY(u16 call, farptr context)
{
    CTOR_DTOR_MODE = 2;
    u16 name = FIND_NAME_IN_LIST(THIS_NAME, SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES));
    u16 alias = FIND_NAME_IN_LIST(OPERATOR_DELETE_NAME, SCOPE_W(CURRENT_SCOPE, SCOPE_NAMES));
    IN_ERROR_RECOVERY = 0;
    TREE_INVOKE(5, 0xD8, 0, 0);
    BLOCK_NEST_LEVEL++;
    u16 body = body_statements(context);
    body = JOIN_COMMA_EXPR(body, BUILD_DESTRUCTOR_BODY(CURRENT_CLASS_TYPE, name, ASSIGNS_TO_THIS(body), alias));
    u16 value = BUILD_THIS_NODE(name);
    u16 result = MAKE_CONDITIONAL_NODE(0x6B, value, body, MAKE_INT_CONSTANT(VOID_TYPE, 0));
    CTOR_CHECK_THIS_ASSIGN = (TAG_W(TYPE_W(CURRENT_CLASS_TYPE, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 2) != 0;
    return BIND_INLINE_PARAMETERS(call, result);
}

/* the expanded body made no lvalue ("0," in front), so that the call cannot be assigned */
u16 MAKE_RVALUE(u16 list)
{
    if (IS_LVALUE(list))
        list = JOIN_COMMA_EXPR(MAKE_INT_CONSTANT(INT_TYPE, 0), list);
    return list;
}

/* 1 when symbol is already being expanded; else pushed on INLINE_FUNCTION_STACK */
u8 CHECK_RECURSIVE_EXPANSION(u16 symbol)
{
    if (LIST_CONTAINS_VALUE(symbol, INLINE_FUNCTION_STACK))
        return 1;
    INLINE_FUNCTION_STACK = LIST_CONS(INLINE_FUNCTION_STACK, symbol);
    return 0;
}

static void copy_record(farptr to, farptr from)
{
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
        B(fp_add(to, i)) = B(fp_add(from, i));
}

/* the lexer state saved, pointed at the saved tokens of the called function's body, the
   body parsed and expanded (constructor, destructor or ordinary function), the lexer put
   back, the result analysed against CURRENT_FUNCTION_TYPE and packed trees made meanwhile
   freed.  A constructor's member initialisers are analysed and kept packed in
   PACKED_INIT_EXPR */
u16 REPLAY_FUNCTION_BODY(u16 call, farptr context)
{
    u16 smark = scratch_mark();
    farptr saved_token = scratch_alloc(TOKEN_RECORD_SIZE), saved_lookahead = scratch_alloc(TOKEN_RECORD_SIZE);
    copy_record(saved_token, CURRENT_TOKEN_RECORD_P);
    copy_record(saved_lookahead, TOKEN_TYPE_P);
    u16 saved_input = CURRENT_FILE_NAME;
    u16 saved_depth = SCOPE_STACK_DEPTH;
    C26_SCOPE_STACK_AT(SCOPE_STACK_DEPTH) = TOKEN_STREAM_HANDLE;
    ++SCOPE_STACK_DEPTH;
    STREAM_SEEK(TOKEN_STREAM_HANDLE, (i16)SYM_W(LEFT(LEFT(call)), SYM_INLINE_POS));
    STREAM_GET_TOKEN(TOKEN_STREAM_HANDLE, CURRENT_TOKEN_RECORD_P);
    CURRENT_TOKEN = CURRENT_RECORD_KIND;
    LOOKAHEAD_KIND = 0x82;
    CTX_RETURNED(context) = 0;
    u16 mark = EXPR_BANK_MARK();
    u16 result = SYM_W(BCC_TREE_SPECIAL, SYM_FUNC_KIND) == 3 ? EXPAND_CONSTRUCTOR_BODY(call, context)
               : SYM_W(BCC_TREE_SPECIAL, SYM_FUNC_KIND) == 4 ? EXPAND_DESTRUCTOR_BODY(call, context)
               : EXPAND_FUNCTION_BODY(call, context);
    if (CURRENT_TOKEN == TOK_RBRACE)
        ADVANCE_TOKEN();
    SCOPE_STACK_DEPTH = saved_depth;
    copy_record(CURRENT_TOKEN_RECORD_P, saved_token);
    CURRENT_TOKEN = CURRENT_RECORD_KIND;
    copy_record(TOKEN_TYPE_P, saved_lookahead);
    CURRENT_FILE_NAME = saved_input;
    scratch_release(smark);
    if (SYM_W(BCC_TREE_SPECIAL, SYM_FUNC_KIND) == 3) {
        MEMBER_INIT_EXPR = ANALYZE_AND_DECAY(MEMBER_INIT_EXPR, VOID_TYPE);
        PACKED_INIT_EXPR = PACK_EXPR_TREE(MEMBER_INIT_EXPR);
        FREE_EXPR_TREE(MEMBER_INIT_EXPR);
    }
    result = ANALYZE_AND_DECAY(result, CURRENT_FUNCTION_TYPE);
    EXPR_BANK_RESET(mark);
    POP_SCOPE(1);
    BLOCK_NEST_LEVEL--;
    return result;
}

/* a compiler-made special member expanded (its body from BUILD_SPECIAL_MEMBER_BODY, not
   from saved tokens) */
u16 EXPAND_SPECIAL_MEMBER_BODY(u16 call)
{
    u16 body = BUILD_SPECIAL_MEMBER_BODY(LEFT(LEFT(call)));
    if (SYM_W(LEFT(LEFT(call)), SYM_FUNC_KIND) == 3)
        finish_constructor(0, &body, &call);
    body = ANALYZE_AND_DECAY(BIND_INLINE_PARAMETERS(call, body), 0);
    POP_SCOPE(1);
    return body;
}

/* the call node replaced by the expanded body of the called inline function, analysed.
   A recursive call stays a call: the function is queued for normal compilation and loses
   its "expand" flag (SYM_FUNC_FLAGS 4).  Otherwise the current function's context is
   saved, a scope with the callee's parameters opened, the body expanded, and all put
   back */
u16 EXPAND_INLINE_CALL(u16 node)
{
    u16 function = LEFT(LEFT(node));
    if (CHECK_RECURSIVE_EXPANSION(function)) {
        QUEUE_DEFERRED_SYMBOL(function);
        SYM_W(function, SYM_FUNC_FLAGS) &= 0xFFFB;
        node = ANALYZE_AND_DECAY(node, TYPE_W(SYM_W(function, SYM_TYPE), TYPE_TARGET));
        if (OP(node) == 0x36)
            SYM_W(LEFT(LEFT(node)), SYM_FUNC_FLAGS) |= 4;
        return node;
    }
    INLINE_EXPANSION_DEPTH++;
    u16 saved_class_type = CURRENT_CLASS_TYPE;
    function = BCC_TREE_SPECIAL;
    u16 saved_root = CURRENT_FUNCTION_TYPE;
    u16 saved_ctor_mode = CTOR_DTOR_MODE;
    u16 saved_this_symbol = CTOR_THIS_SYMBOL;
    u8 saved_this_assigned = CTOR_THIS_ASSIGNED;
    u8 saved_check_this = CTOR_CHECK_THIS_ASSIGN;
    u16 saved_packed_init = PACKED_INIT_EXPR;
    PUSH_SCOPE(1);
    SCOPE_W(CURRENT_SCOPE, SCOPE_ENTER_BLOCK) = SCOPE_W(SCOPE_W(CURRENT_SCOPE, SCOPE_PARENT), SCOPE_ENTER_BLOCK);
    BCC_TREE_SPECIAL = LEFT(LEFT(node));
    u8 is_inline = (SYM_B(BCC_TREE_SPECIAL, SYM_INLINE_ACCESS) & 3) == 2;
    CURRENT_CLASS_TYPE = (SYM_B(BCC_TREE_SPECIAL, SYM_FLAGS) & 0x10) ? SYM_W(SYM_W(BCC_TREE_SPECIAL, SYM_OWNER_CLASS), SYM_TYPE) : 0;
    CURRENT_FUNCTION_TYPE = SYM_W(BCC_TREE_SPECIAL, SYM_TYPE);
    CTOR_DTOR_MODE = 0;
    CTOR_THIS_ASSIGNED = 0;
    CTOR_CHECK_THIS_ASSIGN = 0;
    PACKED_INIT_EXPR = 0;
    for (u16 cache = CACHE_HEAD; cache; cache = FNCACHE_W(cache, FNCACHE_NEXT))
        if (FNCACHE_W(cache, FNCACHE_FUNCTION) == BCC_TREE_SPECIAL) {
            RETURN_FORM_SEEN = FNCACHE_W(cache, FNCACHE_LIST);
            break;
        }
    u16 mark = scratch_mark();
    farptr context = scratch_alloc(6);
    CTX_TYPE(context) = TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_TARGET);
    u16 function_type = TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_PARAMS);
    if (EXPR_FLAGS_AT(TYPE_W(TYPE_W(CURRENT_FUNCTION_TYPE, TYPE_TARGET), TYPE_KIND)) & 0x40)
        DECLARE_HIDDEN_RETURN_PARAM(CURRENT_FUNCTION_TYPE, 1);
    DECLARE_PARAMETERS(function_type, 1);
    CTOR_THIS_SYMBOL = LOOKUP_NAME(THIS_NAME);
    CTX_BY_REF(context) = (FLAGS(CTX_TYPE(context)) & 0x14) && (TYPE_B(CTX_TYPE(context), TYPE_ATTRS) & 0x20);
    if (CTX_BY_REF(context))
        CTX_TYPE(context) = TYPE_W(CTX_TYPE(context), TYPE_TARGET);
    CTX_TEMPS(context) = 0;
    u16 body;
    if (is_inline)
        body = EXPAND_SPECIAL_MEMBER_BODY(node);
    else {
        SCOPE_W(CURRENT_SCOPE, SCOPE_NEST_LEVEL)++;
        body = REPLAY_FUNCTION_BODY(node, context);
    }
    FREE_EXPR_TREE(node);
    body = CTX_BY_REF(context) ? MAKE_UNARY_NODE(0x18, body) : MAKE_RVALUE(body);
    scratch_release(mark);
    node = ANALYZE_AND_DECAY(body, 0);
    CURRENT_CLASS_TYPE = saved_class_type;
    BCC_TREE_SPECIAL = function;
    CURRENT_FUNCTION_TYPE = saved_root;
    CTOR_DTOR_MODE = saved_ctor_mode;
    CTOR_THIS_SYMBOL = saved_this_symbol;
    CTOR_THIS_ASSIGNED = saved_this_assigned;
    CTOR_CHECK_THIS_ASSIGN = saved_check_this;
    PACKED_INIT_EXPR = saved_packed_init;
    INLINE_EXPANSION_DEPTH--;
    u16 pending = INLINE_FUNCTION_STACK;
    INLINE_FUNCTION_STACK = CONS_W(INLINE_FUNCTION_STACK, CONS_NEXT);
    LIST_CELL_FREE(pending);
    return node;
}
