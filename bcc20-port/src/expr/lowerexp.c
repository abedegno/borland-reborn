/* lowerexp.c: from bcc20/src/expr/LOWEREXP.C: lowering an analysed expression tree for
   the back end: enum types become their integer type, member-function pointers the class
   MEMBER_PTR_CLASS_TYPE, symbols are prepared (and get their segment or frame form), ++
   and -- become add and subtract with a step constant (postfix flag 2), member selection
   becomes a bitfield access node, call argument lists are reversed, pointer - pointer
   becomes operator 2Ch, array assignment a struct copy.  Operands are normally lowered
   right before left.

   The original gives up with "out of memory" when the 8086 stack pointer drops below
   8F0Ch (a very deep tree); STACK_CHECK does the same with the native build's model of
   that stack (native/stack.c). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"
#include "stack.h"

#define REAL_ONE_P DSPTR(0x09B7)      /* the 10-byte real 1.0 (symbols.tsv) */

/* a member pointer constant becomes a new static temporary (storage class 4), with an
   initialiser record {next, symbol, packed value list} queued on PENDING_INIT_LIST.  The
   values: the member offset, the virtual function index, then the vtable slot data
   (virtual) or the function's address (after a 0 for a flag-40h function type); a null
   member pointer is two long zeros. */
void LOWER_OP48_TO_TEMP_SYMBOL(u16 expression)
{
    u16 record = POOL_ALLOC_REUSE(INIT_RECORD_POOL_SEG_P, 6);
    AT_W(INIT_RECORD_POOL_SEG, record) = PENDING_INIT_LIST;
    PENDING_INIT_LIST = record;
    u16 temp = CREATE_TEMP_SYMBOL(MEMBER_PTR_CLASS_TYPE, 1);
    AT_W(INIT_RECORD_POOL_SEG, record + 2) = temp;
    u16 tsym = AT_W(INIT_RECORD_POOL_SEG, record + 2);
    SYM_B(tsym, SYM_STORAGE_CLASS) = (SYM_B(tsym, SYM_STORAGE_CLASS) & 7) | 0x20;
    u16 arguments = 0;
    u16 symbol = EXPR_W(expression, EXPR_SCOPE_CLASS);
    u16 type = SYM_W(symbol, SYM_TYPE);
#define PUSH(value) arguments = MAKE_LIST_NODE((value), arguments)
#define DONE() EXPR_B(arguments, EXPR_NODE_FLAGS) |= 1
    if (!symbol) {
        PUSH(MAKE_INT_CONSTANT(LONG_TYPE, 0));
        DONE();
        PUSH(MAKE_INT_CONSTANT(LONG_TYPE, 0));
        DONE();
    } else {
        if (SYM_W(symbol, SYM_VIRTUAL_INDEX)) {
            PUSH(MAKE_INT_CONSTANT(INT_TYPE, 0));
            DONE();
            PUSH(MAKE_INT_CONSTANT(INT_TYPE, (i16)EXPR_W(expression, EXPR_RIGHT)));
        } else {
            if (TYPE_B(type, TYPE_FUNC_FLAGS) & 0x40) {
                PUSH(MAKE_INT_CONSTANT(INT_TYPE, 0));
                DONE();
            }
            PUSH(BUILD_SYMBOL_EXPR(symbol));
        }
        DONE();
        PUSH(MAKE_INT_CONSTANT(INT_TYPE, (i32)SYM_W(symbol, SYM_VIRTUAL_INDEX)));
        DONE();
        PUSH(MAKE_INT_CONSTANT(INT_TYPE, (i16)EXPR_W(expression, EXPR_LEFT)));
        DONE();
    }
#undef PUSH
#undef DONE
    EXPR_W(expression, EXPR_OP) = 1;
    EXPR_W(expression, EXPR_LEFT) = AT_W(INIT_RECORD_POOL_SEG, record + 2);
    EXPR_W(expression, EXPR_SCOPE_CLASS) = 0;
    EXPR_W(expression, EXPR_RIGHT) = 0;
    EXPR_W(expression, EXPR_TYPE) = MEMBER_PTR_CLASS_TYPE;
    u16 packed = PACK_EXPR_TREE(arguments);
    AT_W(INIT_RECORD_POOL_SEG, record + 4) = packed;
    C0MARK(1);
}

/* what ++ and -- add: 1.0 for floating types, the target's size for pointers (a long for
   huge pointers), 1 otherwise */
u16 MAKE_STEP_CONSTANT(u16 type)
{
    if (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 2)
        return MAKE_REAL_CONSTANT(type, REAL_ONE_P);
    if (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14)
        return MAKE_INT_CONSTANT(TYPE_W(type, TYPE_KIND) == TK_HUGE_PTR ? LONG_TYPE : INT_TYPE,
                                 TYPE_SIZE(TYPE_W(type, TYPE_TARGET)));
    return MAKE_INT_CONSTANT(type, 1);
}

u16 LOWER_EXPR_TREE(u16 expression)
{
    STACK_CHECK(LOWER_EXPR_TREE);     /* if(_SP<0x8F0C) REPORT_FATAL(MSG_OUT_MEMORY): native/stack.c */
    u16 result = expression;
    if (!result)
        return result;
    EXPR_W(result, EXPR_QUAL_FLAGS) = 0;
    u16 type = EXPR_W(result, EXPR_TYPE);
    if (TYPE_W(type, TYPE_KIND) == TK_ENUM)
        EXPR_W(result, EXPR_TYPE) = AT_W(TAG_BODY_POOL_SEG, TYPE_W(type, TYPE_TAG_BODY) + 4);
    else if (TYPE_W(type, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(type, TYPE_PTR_MODE) == 0xB &&
             TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION)
        EXPR_W(result, EXPR_TYPE) = MEMBER_PTR_CLASS_TYPE;
#define LOWER(field) do { u16 t_ = LOWER_EXPR_TREE(EXPR_W(expression, field)); EXPR_W(result, field) = t_; } while (0)
    switch (EXPR_W(result, EXPR_OP)) {
    case 0: case EOP_CONST: case 3: case 5: case 7: case 0x33: case 0x39:
        break;
    case 0x42:
        EXPR_W(result, EXPR_OP) = EOP_DEREF;
        LOWER(EXPR_LEFT);
        break;
    case EOP_DOT: {
        u16 child = EXPR_W(expression, EXPR_RIGHT);
        u8 low = EXPR_B(child, EXPR_MEMB_BIT_SHIFT), high = EXPR_B(child, EXPR_MEMB_BIT_WIDTH);
        FREE_EXPR_NODE(child);
        EXPR_W(result, EXPR_OP) = 0x33;
        u16 left = LOWER_EXPRESSION(EXPR_W(expression, EXPR_LEFT));
        EXPR_W(result, EXPR_LEFT) = left;
        EXPR_B(result, EXPR_BIT_WIDTH) = high;
        EXPR_B(result, EXPR_BIT_SHIFT) = low;
        break;
    }
    case 0x48:
        LOWER_OP48_TO_TEMP_SYMBOL(expression);
        /* fall through: it is now a symbol operation, as kind 1 */
    case 1: {
        u16 sym = EXPR_W(expression, EXPR_LEFT);
        switch (SYM_B(sym, SYM_STORAGE_CLASS) >> 3) {
        case 5: case 6:
            EXPR_W(result, EXPR_OP) = 5;
            break;
        case 1: case 2: case 3:
            SYM_B(sym, SYM_FLAGS) |= 4;
            break;
        case 7: {
            EXPR_W(result, EXPR_OP) = 4;
            u16 prepared = PREPARE_SYMBOL(EXPR_W(expression, EXPR_LEFT));
            u16 segment = (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(prepared));
            EXPR_W(result, EXPR_RIGHT) = segment;
            break;
        }
        }
        u16 prepared = PREPARE_SYMBOL(EXPR_W(expression, EXPR_LEFT));
        EXPR_W(result, EXPR_LEFT) = prepared;
        u16 flags = GET_PREPARED_FLAGS(EXPR_W(result, EXPR_LEFT));
        EXPR_W(result, EXPR_QUAL_FLAGS) = flags;
        break;
    }
    case 0x36: {   /* a call: lower callee and arguments, then reverse the argument cells */
        LOWER(EXPR_LEFT);
        LOWER(EXPR_RIGHT);
        if (!EXPR_W(result, EXPR_RIGHT))
            break;
        u16 node = EXPR_W(result, EXPR_RIGHT), previous = EXPR_W(node, EXPR_LEFT);
        if (!previous)
            EXPR_W(result, EXPR_RIGHT) = EXPR_W(node, EXPR_RIGHT);
        else {
            u16 next = EXPR_W(previous, EXPR_LEFT);
            EXPR_W(previous, EXPR_LEFT) = EXPR_W(node, EXPR_RIGHT);
            node = previous;
            while (next) {
                previous = next;
                next = EXPR_W(previous, EXPR_LEFT);
                EXPR_W(previous, EXPR_LEFT) = node;
                node = previous;
            }
            EXPR_W(result, EXPR_RIGHT) = node;
        }
        break;
    }
    case EOP_ASSIGN:   /* an array assignment is a block copy: a struct assignment */
        LOWER(EXPR_RIGHT);
        LOWER(EXPR_LEFT);
        if (TYPE_W(EXPR_W(result, EXPR_TYPE), TYPE_KIND) == TK_ARRAY) {
            EXPR_W(result, EXPR_KIND) = TK_STRUCT;
            EXPR_W(EXPR_W(result, EXPR_RIGHT), EXPR_KIND) = TK_STRUCT;
            EXPR_W(EXPR_W(result, EXPR_LEFT), EXPR_KIND) = TK_STRUCT;
            EXPR_B(result, EXPR_NODE_FLAGS) = 0;
            EXPR_B(result, EXPR_NODE_FLAGS2) = 0;
            return result;
        }
        break;
    case EOP_INC:
    case EOP_DEC: {
        int inc = EXPR_W(result, EXPR_OP) == EOP_INC, post = EXPR_B(expression, EXPR_NODE_FLAGS) & 2;
        EXPR_W(result, EXPR_OP) = inc ? (post ? 0x23 : 0x13) : (post ? 0x24 : 0x14);
        LOWER(EXPR_LEFT);
        u16 step = LOWER_EXPR_TREE(MAKE_STEP_CONSTANT(EXPR_W(EXPR_W(expression, EXPR_LEFT), EXPR_TYPE)));
        EXPR_W(result, EXPR_RIGHT) = step;
        break;
    }
    case 0x35:
        LOWER(EXPR_LEFT);
        break;
    case EOP_SUB:   /* pointer - pointer */
        if ((EXPR_FLAGS_AT(TYPE_W(EXPR_W(EXPR_W(expression, EXPR_LEFT), EXPR_TYPE), TYPE_KIND)) & 0x14) &&
            (EXPR_FLAGS_AT(TYPE_W(EXPR_W(EXPR_W(expression, EXPR_RIGHT), EXPR_TYPE), TYPE_KIND)) & 0x14))
            EXPR_W(result, EXPR_OP) = 0x2C;
        /* fall through */
    default:
        LOWER(EXPR_RIGHT);
        LOWER(EXPR_LEFT);
        break;
    }
#undef LOWER
    EXPR_B(result, EXPR_NODE_FLAGS) = 0;
    EXPR_B(result, EXPR_NODE_FLAGS2) = 0;
    if (EXPR_W(result, EXPR_OP))
        EXPR_W(result, EXPR_KIND) = TYPE_W(EXPR_W(result, EXPR_TYPE), TYPE_KIND);
    return result;
}

/* the entry: lower the expression for the back end */
u16 LOWER_EXPRESSION(u16 expression)
{
    return LOWER_EXPR_TREE(expression);
}
