/* initlist.c: from bcc20/src/parser/INITLIST.C: initializers in the C++ front end ("=
   value" and "= { ... }" after a declarator).  A static object's initial value is written
   as data bytes into the object's segment as it is parsed; position (a long passed by
   address everywhere) is the offset reached inside the object, and PAD_INIT_DATA fills
   gaps with zero bytes.  INIT_DECLARATOR is the entry for one declarator: it selects the
   object's output stream, calls INIT_OBJECT, pads to the full size and restores the
   stream.  INIT_OBJECT dispatches on the type: arrays (sized and unsized, the second also
   fixing the element count of "x[] = ..."), structs (packing bitfields into bytes), unions
   (first data member only) and scalars.  A scalar is analysed as the assignment "temporary
   = value"; a constant or an address constant goes out as data, anything else becomes, in
   C++, an assignment queued to run at start-up, and in C an error.  Locals (storage class
   5) are always initialised by code.  Far arrays (type attribute 0x40) go through
   NEXT_DATA_BANK and EMIT_DATA_SPANS.  The long locals whose addresses are passed on live
   in the scratch area (one per function). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define ERROR_COUNT W(ERROR_COUNT_P)
#define POS SD                                  /* a position: a long reached by address */

static int is_local(u16 symbol)
{
    return (SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) == 5;
}

static int starts_value(void)
{
    return CURRENT_TOKEN == TOK_LBRACE || (TYPE_FLAGS_AT(CURRENT_TOKEN) & EXPR_START_FLAG_MASK);
}

/* the '}' closing a brace initializer.  Anything else is reported (as "too many
   initializers" if it could start another value) and skipped up to a synchronising token */
void END_BRACE_INIT(void)
{
    if (CURRENT_TOKEN != TOK_RBRACE) {
        REPORT_CURRENT_TOKEN((TYPE_FLAGS_AT(CURRENT_TOKEN) & EXPR_START_FLAG_MASK) ? MSG_TOO_MANY_INITIALIZERS : MSG_EXPECTED_230);
        IN_ERROR_RECOVERY = 1;
        while (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x200))
            ADVANCE_TOKEN();
    }
    if (CURRENT_TOKEN == TOK_RBRACE)
        ADVANCE_TOKEN();
}

/* zero bytes from *position up to target; *position advances to it */
void PAD_INIT_DATA(i32 target, farptr position)
{
    if (POS(position) < target) {
        EMIT_ZERO_BYTES((u16)(target - POS(position)));
        POS(position) = target;
    }
}

/* nonzero if the expression can be emitted as data: a constant (operators EOP_CONST, 3 and
   48h), or the address of a static object or function, optionally plus or minus a
   constant.  Operator 35h nodes (casts) are looked through.  A local's address is not
   constant.  A function whose address is taken is queued with QUEUE_DEFERRED_SYMBOL */
u8 IS_CONSTANT_INITIALIZER(u16 expression)
{
    while (EXPR_W(expression, EXPR_OP) == 0x35)
        expression = EXPR_W(expression, EXPR_LEFT);
    if (EXPR_W(expression, EXPR_OP) == EOP_CONST || EXPR_W(expression, EXPR_OP) == 3 || EXPR_W(expression, EXPR_OP) == 0x48)
        return 1;
    if (EXPR_W(expression, EXPR_OP) == EOP_ADD) {
        if (EXPR_W(EXPR_W(expression, EXPR_LEFT), EXPR_OP) == EOP_CONST)
            expression = EXPR_W(expression, EXPR_RIGHT);
        else
            expression = EXPR_W(expression, EXPR_LEFT);
    } else if (EXPR_W(expression, EXPR_OP) == EOP_SUB && EXPR_W(EXPR_W(expression, EXPR_RIGHT), EXPR_OP) == EOP_CONST)
        expression = EXPR_W(expression, EXPR_LEFT);
    if (EXPR_W(expression, EXPR_OP) != EOP_ADDR)
        return 0;
    expression = EXPR_W(expression, EXPR_LEFT);
    if (EXPR_W(expression, EXPR_OP) == 1) {
        if (is_local(EXPR_W(expression, EXPR_LEFT)))
            return 0;
        if (TYPE_W(EXPR_W(expression, EXPR_TYPE), TYPE_KIND) == TK_FUNCTION)
            QUEUE_DEFERRED_SYMBOL(EXPR_W(expression, EXPR_LEFT));
        return 1;
    }
    return 0;
}

static void emit_int(i32 value)
{
    EMIT_CONST_INIT_VALUE(MAKE_INT_CONSTANT(INT_TYPE, value));
}

/* one scalar (or a class object with a constructor) of type at *position in symbol.
   expression is the value if the caller has parsed it, else 0 and it is parsed here (it
   may be in braces).  The value is first analysed with NO_ERRORS_YET forced off, so the
   trial gives no code or errors.  A constant goes out as data; a member pointer constant
   (operator 48h) as its parts; anything else as a start-up assignment in C++ */
void INIT_SCALAR(u16 symbol, u16 type, farptr position, u16 expression)
{
    u8 saved = NO_ERRORS_YET;
    u8 special = is_local(symbol);
    u8 braced = 0;
    if (CURRENT_TOKEN == TOK_LBRACE && expression == 0) {
        ADVANCE_TOKEN();
        braced = 1;
    }
    if (expression == 0)
        expression = PARSE_ASSIGNMENT_EXPR(8);
    NO_ERRORS_YET = 0;
    /* the trial: "temporary = copy of value" (pascal: the left operand is made first) */
    u16 left = MAKE_SYMBOL_NODE(CREATE_LOCAL_TEMP(type));
    u16 right = COPY_EXPR_TREE(expression);
    u16 built = MAKE_BINARY_NODE(5, left, right);
    built = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(built, VOID_TYPE), 0);
    u8 aggregate = CPP_MODE &&
        ((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) || (EXPR_FLAGS_AT(TYPE_W(EXPR_W(built, EXPR_TYPE), TYPE_KIND)) & 0x40));
    NO_ERRORS_YET = saved && ERROR_COUNT == 0;
    u8 constant = EXPR_W(built, EXPR_OP) == EOP_ASSIGN && IS_CONSTANT_INITIALIZER(EXPR_W(built, EXPR_RIGHT));
    if (NO_ERRORS_YET) {
        if (aggregate || special || !constant) {
            /* "*(type *)((char *)&symbol + position) = value", run at start-up */
            if (CPP_MODE) {
                if (!special)
                    EMIT_ZERO_BYTES((u16)TYPE_SIZE(type));
                u16 temporary = MAKE_CAST_NODE(CHAR_POINTER_TYPE, MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(symbol)));
                temporary = MAKE_BINARY_NODE(0x16, temporary, MAKE_INT_CONSTANT(INT_TYPE, POS(position)));
                temporary = MAKE_CAST_NODE(MAKE_POINTER_TYPE(type, 0, 0), temporary);
                temporary = MAKE_UNARY_NODE(0x18, temporary);
                temporary = MAKE_BINARY_NODE(5, temporary, expression);
                QUEUE_INIT_EXPR(temporary);
                FREE_EXPR_TREE(built);
            } else {
                REPORT_CURRENT_TOKEN(MSG_ILLEGAL_INITIALIZATION);
                FREE_EXPR_TREE(built);
                FREE_EXPR_TREE(expression);
            }
        } else {
            u16 temporary = EXPR_W(built, EXPR_RIGHT);
            EXPR_W(built, EXPR_RIGHT) = 0;
            FREE_EXPR_TREE(expression);
            FREE_EXPR_TREE(built);
            expression = temporary;
            if (EXPR_W(expression, EXPR_OP) == 0x48) {
                i16 offset = EXPR_W(expression, EXPR_RIGHT);
                i16 value = EXPR_W(expression, EXPR_LEFT);
                u16 reference = EXPR_W(expression, EXPR_SCOPE_CLASS);
                emit_int(value);
                if (reference) {
                    emit_int((i16)SYM_W(reference, SYM_VIRTUAL_INDEX));
                    if (SYM_W(reference, SYM_VIRTUAL_INDEX)) {
                        emit_int(offset);
                        emit_int(0);
                    } else {
                        EMIT_CONST_INIT_VALUE(BUILD_SYMBOL_EXPR(reference));
                        if (TYPE_B(SYM_W(reference, SYM_TYPE), TYPE_FUNC_FLAGS) & 0x40)
                            emit_int(0);
                    }
                } else {
                    emit_int(0);
                    emit_int(0);
                    emit_int(0);
                }
            } else
                EMIT_CONST_INIT_VALUE(expression);
        }
    }
    i32 size = TYPE_SIZE(type);
    POS(position) = POS(position) + size;
    if (braced) {
        if (CURRENT_TOKEN == TOK_COMMA)
            ADVANCE_TOKEN();
        END_BRACE_INIT();
    }
}

/* the next element of a brace list follows unless it is closed */
static void element_separator(void)
{
    REQUIRE_TOKEN_BODY(8, 0xCA);
    if (CURRENT_TOKEN == TOK_COMMA)
        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
}

static void close_braces(u8 braced)
{
    if (braced) {
        if (CURRENT_TOKEN == TOK_COMMA)
            ADVANCE_TOKEN();
        END_BRACE_INIT();
    }
}

static u8 open_braces(void)
{
    if (CURRENT_TOKEN != TOK_LBRACE)
        return 0;
    ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_RBRACE)
        REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
    return 1;
}

static int is_char_kind(u16 type)
{
    return TYPE_W(type, TYPE_KIND) == TK_CHAR || TYPE_W(type, TYPE_KIND) == TK_UCHAR;
}

/* an array declared without a size: from string literals (char arrays) or a brace list.
   type the element type, size its size; *count gets the number of elements.  For a static
   array each element starts at its own offset (padding any gap); for a local the position
   is just reset to it */
void INIT_UNSIZED_ARRAY(u16 symbol, u16 type, u8 advance, farptr count, i32 size, farptr position)
{
    SD(count) = 0;
    i32 target = POS(position);
    u8 braced = open_braces();
    if (CURRENT_TOKEN == 0x34 && is_char_kind(type)) {
        while (CURRENT_TOKEN == 0x34) {
            u16 index = 0;
            i16 value;
            while ((value = NEXT_LITERAL_CHAR(index++)) != -1) {
                SD(count)++;
                EMIT_BYTE_IF_ENABLED((u8)value);
            }
            ADVANCE_TOKEN();
        }
        EMIT_BYTE_IF_ENABLED(0);
        SD(count)++;
        POS(position) += SD(count);
    } else {
        if (!braced)
            REPORT_CURRENT_TOKEN(MSG_INITIALIZATION_ONLY);
        while (starts_value()) {
            if (is_local(symbol))
                POS(position) = target;
            else
                PAD_INIT_DATA(target, position);
            INIT_OBJECT(symbol, type, position, advance, 1);
            SD(count)++;
            target = target + size;
            if (CURRENT_TOKEN != TOK_RBRACE)
                element_separator();
        }
    }
    close_braces(braced);
}

/* an array of count elements of type (size bytes each): from string literals for char
   arrays (too long is an error; in C++ also when only the closing 0 does not fit), or from
   a brace list.  In C++ the elements left over in an array of class objects with
   constructors are constructed by CONSTRUCT_ARRAY_ELEMENTS */
void INIT_SIZED_ARRAY(u16 symbol, u16 type, u8 advance, u8 empty, i32 count, i32 size, farptr position)
{
    i32 target = POS(position);
    u8 braced = open_braces();
    if (CURRENT_TOKEN == 0x34 && is_char_kind(type)) {
        u16 characters = 0;
        while (CURRENT_TOKEN == 0x34) {
            u16 index = 0;
            i16 value;
            while ((value = NEXT_LITERAL_CHAR(index++)) != -1) {
                ++characters;
                if ((i32)characters <= count)
                    EMIT_BYTE_IF_ENABLED((u8)value);
            }
            if (characters == 0 && count > 0) {
                characters = 1;
                EMIT_BYTE_IF_ENABLED(0);
            }
            ADVANCE_TOKEN();
        }
        if ((i32)characters > count || (CPP_MODE && (i32)characters > count - 1))
            REPORT_CURRENT_TOKEN(MSG_ILLEGAL_INITIALIZATION);
        else if ((i32)characters < count)
            count = characters;
        POS(position) += count;
    } else {
        if (!braced)
            REPORT_CURRENT_TOKEN(MSG_INITIALIZATION_ONLY);
        while (count > 0 && starts_value()) {
            if (is_local(symbol))
                POS(position) = target;
            else
                PAD_INIT_DATA(target, position);
            INIT_OBJECT(symbol, type, position, advance, empty);
            count = count - 1;
            target = target + size;
            if (count > 0 && CURRENT_TOKEN != TOK_RBRACE)
                element_separator();
        }
        if (CPP_MODE && count > 0 && (TYPE_B(type, TYPE_ATTRS) & 4)) {
            if (is_local(symbol))
                POS(position) = target;
            else
                PAD_INIT_DATA(target, position);
            CONSTRUCT_ARRAY_ELEMENTS(count, symbol, type, position, advance, empty);
        }
    }
    close_braces(braced);
}

/* the bytes of the storage unit holding the bitfield member: the distance to the next
   member at another offset, or to the end of the struct, at most an int.  Non-data
   members are skipped */
u16 BITFIELD_UNIT_SIZE(u16 type, u16 member)
{
    u16 offset = MEMBER_W(member, MEMB_VALUE);
    while (MEMBER_W(member, MEMB_NEXT) != 0 && ((MEMBER_B(member, MEMB_FLAGS) & 3) || MEMBER_W(member, MEMB_VALUE) == offset))
        member = MEMBER_W(member, MEMB_NEXT);
    if (MEMBER_W(member, MEMB_VALUE) != offset)
        return MEMBER_W(member, MEMB_VALUE) - offset;
    u16 space = (u16)TYPE_SIZE(type) - offset;
    if (space > INT_TYPE_SIZE)
        return INT_TYPE_SIZE;
    return space;
}

/* the data members of a struct in order, from a brace list.  Static members, functions and
   other non-data members are skipped.  Consecutive bitfields in one unit are collected in
   packed (shift and width from MEMB_BITFIELD) and written as one or two bytes when the
   unit changes.  The flags of the member record at offset 0 are cleared first so that it
   ends the skipping loops */
void INIT_STRUCT_MEMBERS(u16 symbol, u16 type, farptr position)
{
    u16 mark = scratch_mark();
    farptr value = scratch_alloc(4);
    i32 stride = 0;
    i16 bits = 0;
    u8 braced = 0;
    if (CURRENT_TOKEN == TOK_LBRACE) {
        ADVANCE_TOKEN();
        braced = 1;
        if (CURRENT_TOKEN == TOK_RBRACE)
            REPORT_CURRENT_TOKEN(MSG_EXPRESSION_EXPECTED);
    } else
        REPORT_CURRENT_TOKEN(MSG_INITIALIZATION_ONLY);
    u8 active = 0;
    i32 base = POS(position);
    u16 packed = 0;
    u16 member = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS);
    while (member && starts_value()) {
        MEMBER_B(0, MEMB_FLAGS) = 0;
        while ((MEMBER_B(member, MEMB_FLAGS) & 3) || ((MEMBER_B(member, MEMB_FLAGS) & 0x20) && !(MEMBER_B(member, MEMB_FLAGS) & 0x80)))
            member = MEMBER_W(member, MEMB_NEXT);
        if (member == 0)
            continue;
        i32 target = base + MEMBER_W(member, MEMB_VALUE);
        if (MEMBER_B(member, MEMB_FLAGS) & 0x40) {
            i16 shift = MEMBER_B(member, MEMB_BITFIELD) & 7;
            i16 width = MEMBER_B(member, MEMB_BITFIELD) >> 3;
            if (!active || POS(position) != target) {
                if (active) {
                    EMIT_BYTE_IF_ENABLED((u8)(packed & 0xFF));
                    packed >>= 8;
                    bits -= 8;
                    if (stride > 1) {
                        EMIT_BYTE_IF_ENABLED((u8)packed);
                        packed = 0;
                        bits = 0;
                    }
                    POS(position) += stride;
                }
                active = 1;
                PAD_INIT_DATA(target, position);
                stride = BITFIELD_UNIT_SIZE(type, member);
            }
            CONST_EXPR_VALUE_BODY(8, value);
            /* a 16-bit shift: a width of 16 gives 0 - 1, all ones */
            u16 masked = (u16)((1U << (width & 31)) - 1) & (u16)SD(value);
            packed |= (u16)(masked << shift);
            bits = width + shift;
        } else {
            if (active) {
                EMIT_BYTE_IF_ENABLED((u8)(packed & 0xFF));
                if (stride > 1)
                    EMIT_BYTE_IF_ENABLED((u8)(packed >> 8));
                packed = 0;
                POS(position) += stride;
                active = 0;
                bits = 0;
            }
            PAD_INIT_DATA(target, position);
            INIT_OBJECT(symbol, MEMBER_W(member, MEMB_TYPE), position, 0, 0);
        }
        member = MEMBER_W(member, MEMB_NEXT);
        if (CURRENT_TOKEN != TOK_RBRACE && member)
            element_separator();
    }
    if (active) {
        EMIT_BYTE_IF_ENABLED((u8)(packed & 0xFF));
        ++POS(position);
        if (bits > 8) {
            EMIT_BYTE_IF_ENABLED((u8)(packed >> 8));
            ++POS(position);
        }
    }
    close_braces(braced);
    scratch_release(mark);
}

/* an object of type at *position in symbol, by kind.  advance: the object is in a far
   (attribute 40h) array, so NEXT_DATA_BANK(empty) follows it.  A struct of unknown size
   cannot be initialised (the braces are skipped).  A class with a constructor (attribute
   4) is initialised like a scalar, by an expression */
void INIT_OBJECT(u16 symbol, u16 type, farptr position, u8 advance, u8 empty)
{
    if (TYPE_W(type, TYPE_KIND) == TK_ARRAY) {
        advance = advance || (TYPE_B(type, TYPE_ATTRS) & 0x40);
        if (TYPE_SIZE(type) == 0) {
            u16 mark = scratch_mark();
            farptr count = scratch_alloc(4);
            u16 element = TYPE_W(type, TYPE_TARGET);
            INIT_UNSIZED_ARRAY(symbol, element, advance, count, TYPE_SIZE(element), position);
            TYPE_L(type, TYPE_ARRAY_COUNT) = SD(count);
            scratch_release(mark);
        } else {
            u16 element = TYPE_W(type, TYPE_TARGET);
            i32 count = TYPE_L(type, TYPE_ARRAY_COUNT);
            INIT_SIZED_ARRAY(symbol, element, advance, empty, count, TYPE_SIZE(element), position);
        }
    } else if (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) {
        if (TYPE_SIZE(type) == 0) {
            IN_ERROR_RECOVERY = 1;
            END_BRACE_INIT();
            return;
        }
        if (TYPE_W(type, TYPE_KIND) == TK_UNION) {
            u16 member = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS);
            MEMBER_B(0, MEMB_FLAGS) = 0;
            while ((MEMBER_B(member, MEMB_FLAGS) & 3) != 0)
                member = MEMBER_W(member, MEMB_NEXT);
            type = MEMBER_W(member, MEMB_TYPE);
            INIT_OBJECT(symbol, type, position, 0, 0);
        } else if (TYPE_B(type, TYPE_ATTRS) & 4)
            INIT_SCALAR(symbol, type, position, 0);
        else
            INIT_STRUCT_MEMBERS(symbol, type, position);
    } else
        INIT_SCALAR(symbol, type, position, 0);
    if (advance)
        NEXT_DATA_BANK(empty);
}

/* the initializer of declarator symbol of type, after the '='.  First checks that a brace
   list is used where one is needed (and not for a C++ class that forbids it, class flag
   40h); IN_ERROR_RECOVERY is set after such an error to quiet follow-on messages.  For
   statics, output goes to the symbol's own data stream and is padded to the full size */
void INIT_DECLARATOR(u16 symbol, u16 type)
{
    u16 saved = 0;
    if (CPP_MODE && (EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) && CURRENT_TOKEN == TOK_LBRACE &&
        (TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x40)) {
        REPORT_CURRENT_TOKEN(MSG_CLASSES_CANNOT);
        IN_ERROR_RECOVERY = 1;
    } else if (((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x40) ||
                (TYPE_W(type, TYPE_KIND) == TK_ARRAY && CURRENT_TOKEN != 0x34 && !(TYPE_B(type, TYPE_ATTRS) & 4))) &&
               CURRENT_TOKEN != TOK_LBRACE) {
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_216);
        IN_ERROR_RECOVERY = 1;
    } else
        IN_ERROR_RECOVERY = 0;
    u16 mark = scratch_mark();
    farptr position = scratch_alloc(4);
    POS(position) = 0;
    u8 advance = TYPE_W(type, TYPE_KIND) == TK_ARRAY && (TYPE_B(type, TYPE_ATTRS) & 0x40);
    u8 empty = advance && TYPE_SIZE(type) == 0;
    if (!is_local(symbol))
        saved = advance ? BEGIN_ARRAY_DATA(symbol) : SELECT_SYMBOL_STREAM(symbol);
    INIT_OBJECT(symbol, type, position, advance, empty);
    if (!is_local(symbol)) {
        if (advance)
            EMIT_DATA_SPANS(TYPE_SIZE(type) - POS(position), empty);
        else
            PAD_INIT_DATA(TYPE_SIZE(type), position);
        IN_ERROR_RECOVERY = 0;
        SET_STREAM(saved);
    }
    scratch_release(mark);
}

/* a scalar initializer, optionally in braces, for symbol, of type initializer: used where
   the type is known to be scalar */
void PARSE_SCALAR_INITIALIZER(u16 symbol, u16 initializer)
{
    u16 saved = 0;
    u8 braced = 0;
    u16 mark = scratch_mark();
    farptr position = scratch_alloc(4);
    POS(position) = 0;
    if (CURRENT_TOKEN == TOK_LBRACE) {
        braced = 1;
        ADVANCE_TOKEN();
    }
    if (!is_local(symbol))
        saved = SELECT_SYMBOL_STREAM(symbol);
    INIT_SCALAR(symbol, initializer, position, 0);
    if (!is_local(symbol))
        SET_STREAM(saved);
    close_braces(braced);
    scratch_release(mark);
}
