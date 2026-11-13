/* convert.c: from bcc20/src/expr/CONVERT.C: the conversions every checker uses: building
   * and & nodes, decaying arrays and functions to pointers, reading a value out of a
   reference (CONVERT_TO_RVALUE), the implicit conversion of a value to a type with its
   portability warnings (CONVERT_EXPR_TO_TYPE), the check of an explicit cast (CHECK_CAST)
   and bringing the operands of a binary operator to a common type
   (USUAL_ARITHMETIC_CONVERSIONS, BALANCE_BINARY_OPERANDS).  Conversions are cast nodes
   (MAKE_CAST_NODE, operator 35h) that ANALYZE_EXPRESSION then checks; a conversion that
   changes nothing just retypes the operand.  MAKE_UNARY_NODE takes token codes: 18h *,
   1Bh &, 16h +, 1Dh the & of a plain function.  RANK(k) is byte 0 of the kind's
   KIND_SIZE_TABLE row, its size in bytes.  Nodes made here copy the source position (6
   bytes at node + 14h) of the node they are made from. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "protos.h"

#define TYPE_OF(node) EXPR_W((node), EXPR_TYPE)
#define KIND_OF(node) TYPE_W(TYPE_OF(node), TYPE_KIND)
#define FLAGS(type) EXPR_FLAGS_AT(TYPE_W((type), TYPE_KIND))
#define FLAGS_OF(node) FLAGS(TYPE_OF(node))
#define LEFT(node) EXPR_W((node), EXPR_LEFT)
#define RIGHT(node) EXPR_W((node), EXPR_RIGHT)
#define RANK(kind) KIND_SIZE_TABLE_AT((kind) * 4)
#define RANGE_MIN(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8))
#define RANGE_MAX(kind) SD(fp_add(TYPE_RANGE_TABLE_P, (kind) * 8 + 4))
#define TOKEN_RECORD_SIZE 19

/* the source position, 6 bytes at node + 14h */
static void copy_position(u16 to, u16 from)
{
    for (int i = 0; i < 6; i++)
        EXPR_B(to, 0x14 + i) = EXPR_B(from, 0x14 + i);
}

/* an analysed *node, whose type is node's pointer target */
u16 MAKE_DEREF_NODE(u16 node)
{
    u16 result = MAKE_UNARY_NODE(0x18, node);
    copy_position(result, node);
    EXPR_W(result, EXPR_TYPE) = TYPE_W(TYPE_OF(node), TYPE_TARGET);
    EXPR_B(result, EXPR_NODE_FLAGS) |= 1;
    return result;
}

/* *node, but *&x folds back to x when the types agree */
u16 MAKE_DEREFERENCE(u16 node)
{
    if (EXPR_W(node, EXPR_OP) == EOP_ADDR &&
        TYPES_COMPATIBLE(TYPE_W(TYPE_OF(node), TYPE_TARGET), TYPE_OF(LEFT(node)), 0)) {
        u16 result = LEFT(node);
        FREE_EXPR_NODE(node);
        return result;
    }
    return MAKE_DEREF_NODE(node);
}

/* the analysed &expression with pointed-to type type.  For a comma chain the & goes onto
   the last operand and every comma takes the pointer type.  The pointer kind and
   TYPE_PTR_MODE follow the object: *p keeps p's kind and mode (a _seg pointer gives far),
   a far variable gives far, an automatic gets mode 3 (probably SS-relative) when DS may
   differ from SS, a far array (TYPE_ATTRS 40h) gives huge; otherwise mode 2 (code) or 4
   (data) */
u16 C7CHAIN(u16 expression, u16 type)
{
    u16 node = expression, first = 0, last = 0;
    if (EXPR_W(node, EXPR_OP) == EOP_COMMA) {
        first = node;
        while (EXPR_W(node, EXPR_OP) == EOP_COMMA) {
            last = node;
            node = RIGHT(node);
        }
    }
    u16 result = MAKE_UNARY_NODE(0x1B, node);
    copy_position(result, node);
    while (EXPR_W(node, EXPR_OP) == EOP_DOT)
        node = LEFT(node);
    u16 kind = 0;
    i16 attribute = TYPE_W(type, TYPE_KIND) == TK_FUNCTION ? 2 : 4;
    if (EXPR_W(node, EXPR_OP) == EOP_DEREF) {
        u16 pointer = TYPE_OF(LEFT(node));
        attribute = (i8)TYPE_B(pointer, TYPE_PTR_MODE);
        kind = TYPE_W(pointer, TYPE_KIND) == TK_SEG_PTR ? 0x0F : TYPE_W(pointer, TYPE_KIND);
    } else if (EXPR_W(node, EXPR_OP) == 1) {
        if (SYM_B(LEFT(node), SYM_FLAGS) & 0x80) {
            kind = 0x0F;
            attribute = 0;
        } else if ((SYM_B(LEFT(node), SYM_STORAGE_CLASS) >> 3) == 5 &&
                   (OPTION_DS_NOT_SS || ((i16)(i8)MODEL_FAR_DATA & !(i16)(i8)OPTION_SS_EQUALS_DS)))
            attribute = 3;
    }
    if (KIND_OF(node) == TK_ARRAY && (TYPE_B(TYPE_OF(node), TYPE_ATTRS) & 0x40)) {
        kind = 0x10;
        attribute = 0;
    }
    u16 pointer = MAKE_POINTER_TYPE(type, kind, 0);
    EXPR_W(result, EXPR_TYPE) = pointer;
    TYPE_B(TYPE_OF(result), TYPE_PTR_MODE) = (u8)attribute;
    EXPR_B(result, EXPR_NODE_FLAGS) |= 1;
    if (!last)
        return result;
    RIGHT(last) = result;
    for (node = first; EXPR_W(node, EXPR_OP) == EOP_COMMA; node = RIGHT(node))
        EXPR_W(node, EXPR_TYPE) = TYPE_OF(result);
    return first;
}

/* &node, with node's own type as the target */
u16 MAKE_ADDRESS_OF(u16 node)
{
    return C7CHAIN(node, TYPE_OF(node));
}

/* the "nonportable pointer conversion" warning between an integer and a pointer, a
   separate message when their sizes are equal */
static void warn_nonportable(u16 destination, u16 source_type)
{
    if (TYPE_SIZE(destination) == TYPE_SIZE(source_type))
        REPORT_CURRENT_TOKEN(MSG_NONPORTABLE_POINTER_375);
    else
        REPORT_CURRENT_TOKEN(MSG_NONPORTABLE_POINTER);
}

static int char_kind(u16 type)
{
    return TYPE_W(type, TYPE_KIND) == TK_CHAR || TYPE_W(type, TYPE_KIND) == TK_UCHAR;
}

/* the implicit conversion of expression to destination (mode goes to ANALYZE_EXPRESSION
   as the context).  Types compatible but for qualifiers: the node is just retyped.  Else
   warnings at the current token: integer to pointer or back (a null pointer constant is
   fine), incompatible pointers ("suspicious pointer conversion", or "mixing pointers to
   signed and unsigned char"), long to a shorter integer.  In C++ a class value goes
   through its conversion function first.  Then a cast node, analysed */
u16 CONVERT_EXPR_TO_TYPE(u16 destination, u16 expression, u16 mode)
{
    /* the original reads the type before it tests expression for 0 */
    u16 source_type = TYPE_OF(expression);
    if (!expression)
        return 0;
    if (TYPE_W(source_type, TYPE_KIND) == TK_ENUM)
        source_type = TAG_W(TYPE_W(source_type, TYPE_TAG_BODY), TAG_ENUM_BASE);
    if (TYPES_COMPATIBLE(destination, source_type, 2)) {
        EXPR_W(expression, EXPR_TYPE) = destination;
        return expression;
    }
    if (FLAGS(destination) & 0x14) {
        u16 mark = scratch_mark();
        farptr derived = scratch_alloc(2);
        expression = CHECK_NULL_CONSTANT(expression, derived);
        u8 null_constant = B(derived);
        scratch_release(mark);
        if (!null_constant && (FLAGS(source_type) & 1))
            warn_nonportable(destination, source_type);
        else if ((FLAGS(source_type) & 0x14) && !C7_TYPE_COMPAT(destination, source_type, 0)) {
            if (TYPE_W(destination, TYPE_KIND) == TYPE_W(source_type, TYPE_KIND) &&
                TYPE_B(destination, TYPE_PTR_MODE) == TYPE_B(source_type, TYPE_PTR_MODE) &&
                TYPE_W(destination, TYPE_PTR_BASE) == TYPE_W(source_type, TYPE_PTR_BASE) &&
                char_kind(TYPE_W(source_type, TYPE_TARGET)) && char_kind(TYPE_W(destination, TYPE_TARGET)))
                REPORT_CURRENT_TOKEN(MSG_MIXING_POINTERS_SIGNED);
            else
                REPORT_CURRENT_TOKEN(MSG_SUSPICIOUS_POINTER);
        }
    } else if ((FLAGS(destination) & 1) && (FLAGS(source_type) & 0x14))
        warn_nonportable(destination, source_type);
    if ((TYPE_W(source_type, TYPE_KIND) == TK_ULONG || TYPE_W(source_type, TYPE_KIND) == TK_LONG) &&
        (i16)TYPE_W(destination, TYPE_KIND) <= TK_UINT && (i16)TYPE_W(destination, TYPE_KIND) >= TK_SHORT)
        REPORT_CURRENT_TOKEN(MSG_CONVERSION_MAY_LOSE);
    if (CPP_MODE && (FLAGS(source_type) & 0x40)) {
        if (FLAGS(destination) & 3)
            expression = APPLY_CONVERSION_FUNCTION(expression, 3, destination);
        else if (FLAGS(destination) & 0x14)
            expression = APPLY_CONVERSION_FUNCTION(expression, 0x14, destination);
    }
    return ANALYZE_EXPRESSION(MAKE_CAST_NODE(destination, expression), 0, mode);
}

/* the value of an array is a pointer to its first element, the value of a function a
   pointer to it.  A member (operator 4Ah) cannot be used here; object.function only in
   C++ for a qualified member function.  A function's symbol is marked "address taken"
   (SYM_FUNC_FLAGS 8); the & is token 1Dh for an ordinary function, 1Bh for a member
   function */
u16 DECAY_TO_POINTER(u16 node)
{
    if (!node)
        return node;
    if (EXPR_W(node, EXPR_OP) == 0x4A)
        return REPORT_EXPR_ERROR(MSG_FIELD_CANNOT_USED, NAME_TEXT_COPY(MEMBER_W(LEFT(node), MEMB_NAME)), 0, node);
    EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
    if (KIND_OF(node) == TK_ARRAY)
        return C7CHAIN(node, TYPE_W(TYPE_OF(node), TYPE_TARGET));
    if (KIND_OF(node) == TK_FUNCTION) {
        if (EXPR_W(node, EXPR_OP) == EOP_DOT) {
            if (CPP_MODE && EXPR_W(RIGHT(node), EXPR_OP) == 1 && EXPR_W(RIGHT(node), EXPR_SCOPE_CLASS)) {
                u16 saved = node;
                node = RIGHT(node);
                RIGHT(saved) = 0;
                FREE_EXPR_TREE(saved);
            } else
                node = REPORT_EXPR_ERROR_PLAIN(MSG_USE_TAKE_ADDRESS, node);
        }
        if (KIND_OF(node) == TK_FUNCTION) {
            if (EXPR_W(node, EXPR_OP) == 1)
                W(MK_FP(SYMBOL_POOL_SEG, LEFT(node) + SYM_FUNC_FLAGS)) |= 8;
            node = MAKE_UNARY_NODE(TYPE_W(TYPE_OF(node), TYPE_MEMBER_CLASS) == 0 ? 0x1D : 0x1B, node);
            node = ANALYZE_EXPRESSION(node, 0, 0);
        }
    }
    return node;
}

/* a reference read (C++) and arrays and functions decayed: the usual step before a value
   is used */
u16 CONVERT_TO_RVALUE(u16 node)
{
    return DECAY_TO_POINTER(CPP_MODE ? DEREF_REFERENCE_EXPR(node) : node);
}

/* an enum type's integer type; other types unchanged */
u16 ENUM_UNDERLYING_TYPE(u16 type)
{
    if (TYPE_W(type, TYPE_KIND) == TK_ENUM)
        return TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_ENUM_BASE);
    return type;
}

/* an enum-typed node given its integer type in place */
u16 NODE_ENUM_TO_INT(u16 node)
{
    if (!node)
        return node;
    if (KIND_OF(node) == TK_ENUM)
        EXPR_W(node, EXPR_TYPE) = TAG_W(TYPE_W(TYPE_OF(node), TYPE_TAG_BODY), TAG_ENUM_BASE);
    return node;
}

/* 1 when an object of type cannot be modified: the type is const, or a struct or union
   with a const data member (MEMB_FLAGS & 3 == 0, probably ordinary data members) or, in
   C++, a const base class */
u8 C7CONST(u16 type)
{
    if (!(FLAGS(type) & 0x40) || (TYPE_B(type, TYPE_ATTRS) & 1))
        return TYPE_B(type, TYPE_ATTRS) & 1;
    for (u16 member = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT))
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 0 && C7CONST(MEMBER_W(member, MEMB_TYPE)))
            return 1;
    if (!CPP_MODE)
        return 0;
    for (u16 base = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_BASES); base; base = BASE_W(base, BASE_NEXT))
        if (C7CONST(BASE_W(base, BASE_TYPE)))
            return 1;
    return 0;
}

/* 1 when the lvalue node may be assigned (an error node counts as modifiable, so that no
   second message appears) */
u8 IS_MODIFIABLE_NODE(u16 node)
{
    if (EXPR_W(node, EXPR_OP) == 0)
        return 1;
    if (C7CONST(TYPE_OF(node)))
        return 0;
    return (TYPE_B(TYPE_OF(node), TYPE_ATTRS) & 1) == 0;
}

/* 1 for object.member where the member is a bitfield (flag 4) */
u8 IS_BIT_FIELD_NODE(u16 node)
{
    if (EXPR_W(node, EXPR_OP) != EOP_DOT)
        return 0;
    return (EXPR_B(RIGHT(node), EXPR_NODE_FLAGS) & 4) != 0;
}

/* 1 when an explicit cast from second to first is allowed at all: anything to void; from
   void only to void (when NOT_ANSI_FLAG); to a reference only from a reference; otherwise
   between scalars (integers and pointers) or between arithmetic types */
u8 C7COMPAT(u16 first, u16 second)
{
    if (TYPE_W(second, TYPE_KIND) == TK_VOID)
        return NOT_ANSI_FLAG && TYPE_W(first, TYPE_KIND) == TK_VOID;
    if (first == second || TYPE_W(first, TYPE_KIND) == TK_VOID)
        return 1;
    if ((FLAGS(first) & 0x14) && (TYPE_B(first, TYPE_ATTRS) & 0x20) &&
        (!(FLAGS(second) & 0x14) || !(TYPE_B(second, TYPE_ATTRS) & 0x20)))
        return 0;
    return ((FLAGS(second) & 0x15) && (FLAGS(first) & 0x15)) || ((FLAGS(second) & 3) && (FLAGS(first) & 3));
}

/* 1 when a cast between kinds first and second can reinterpret an lvalue in place:
   integer and pointer kinds where the target is not wider, or pointer kinds of equal kind
   or no wider and neither a _seg pointer */
u8 C7RANK(u16 first, u16 second)
{
    if (((EXPR_FLAGS_AT(first) & 1) && (EXPR_FLAGS_AT(second) & 0x15)) ||
        ((EXPR_FLAGS_AT(first) & 0x15) && (EXPR_FLAGS_AT(second) & 1)))
        return RANK(first) <= RANK(second);
    if ((EXPR_FLAGS_AT(first) & 0x14) && (EXPR_FLAGS_AT(second) & 0x14))
        return first == second || (first != 0x0E && second != 0x0E && RANK(first) <= RANK(second));
    return 0;
}

/* checks the analysed cast node and simplifies it.  A based near pointer cast to far is
   made a normal pointer first, an integer cast to a far pointer long.  The cast goes when
   the types are compatible, or when an lvalue (not a bitfield) can be reinterpreted in
   place; an impossible cast is an error */
u16 CHECK_CAST(u16 expression)
{
    u16 node = expression;
    u16 source_type = TYPE_OF(LEFT(node));
    u16 type = TYPE_OF(node);
    u16 result = node;
    if (TYPE_W(type, TYPE_KIND) == TK_FAR_PTR) {
        if (TYPE_W(source_type, TYPE_KIND) == TK_NEAR_PTR && TYPE_W(source_type, TYPE_PTR_BASE)) {
            u16 left = ANALYZE_EXPRESSION(APPLY_BASED_POINTER(LEFT(node)), type, 0);
            LEFT(node) = left;
            source_type = TYPE_OF(LEFT(node));
        } else if (FLAGS(source_type) & 1) {
            u16 left = CONVERT_EXPR_TO_TYPE(LONG_TYPE, LEFT(node), 0);
            LEFT(node) = left;
        }
    }
    if (TYPE_W(source_type, TYPE_KIND) == TK_VOID && TYPE_W(type, TYPE_KIND) != TK_VOID)
        result = REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    else if (TYPES_COMPATIBLE(type, source_type, 1)) {
        EXPR_W(LEFT(node), EXPR_TYPE) = type;
        result = LEFT(node);
        FREE_EXPR_NODE(node);
    } else if (!C7COMPAT(type, source_type)) {
        i32 from = FORMAT_TYPE(source_type);
        i32 to = FORMAT_TYPE(type);
        result = REPORT_EXPR_ERROR(MSG_CANNOT_CAST_FROM, (farptr)from, to, node);
    } else if ((!CPP_MODE || !(FLAGS(type) & 0x14) || TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) != TK_FUNCTION) &&
               C7RANK(TYPE_W(type, TYPE_KIND), TYPE_W(source_type, TYPE_KIND)) && IS_LVALUE(LEFT(node)) &&
               (EXPR_W(LEFT(node), EXPR_OP) != EOP_DOT || !(EXPR_B(RIGHT(LEFT(node)), EXPR_NODE_FLAGS) & 4))) {
        EXPR_W(LEFT(node), EXPR_TYPE) = type;
        result = LEFT(node);
        FREE_EXPR_NODE(node);
    }
    EXPR_B(result, EXPR_NODE_FLAGS) |= 1;
    return result;
}

/* a constant node that fits in char or unsigned char (kind 1 or 2 of type) takes that
   type, so that arithmetic with a char operand can stay in bytes */
void C7RANGE(u16 node, u16 type)
{
    u16 kind = TYPE_W(type, TYPE_KIND);
    if (kind == 1 || kind == 2) {
        i32 value = EXPR_L(node, EXPR_VALUE);
        if (RANGE_MIN(kind) <= value && RANGE_MAX(kind) >= value)
            EXPR_W(node, EXPR_TYPE) = type;
    }
}

/* both operands of the binary node converted to a common arithmetic type, which the node
   takes; requested is the wanted result type (0 int).  Floating: the larger floating kind
   (or the wanted one if larger).  Integers: the larger size, unsigned winning at equal
   size; then, unless a type smaller than int is wanted, char and short become int and
   unsigned short unsigned int, so that with char wanted, char op char stays char */
u16 USUAL_ARITHMETIC_CONVERSIONS(u16 requested, u16 expression)
{
    u16 left = LEFT(expression), right = RIGHT(expression);
    if (EXPR_W(left, EXPR_OP) == 0 || EXPR_W(right, EXPR_OP) == 0)
        return expression;
    i16 requested_kind = requested == 0 ? 5 : (i16)TYPE_W(requested, TYPE_KIND);
    if (requested_kind == 1 || requested_kind == 2) {
        if (EXPR_W(left, EXPR_OP) == EOP_CONST)
            C7RANGE(left, TYPE_OF(right));
        if (EXPR_W(right, EXPR_OP) == EOP_CONST)
            C7RANGE(right, TYPE_OF(left));
    }
    EXPR_W(left, EXPR_TYPE) = ENUM_UNDERLYING_TYPE(TYPE_OF(left));
    u16 left_type = TYPE_OF(left);
    i16 left_kind = (i16)TYPE_W(left_type, TYPE_KIND);
    EXPR_W(right, EXPR_TYPE) = ENUM_UNDERLYING_TYPE(TYPE_OF(right));
    u16 right_type = TYPE_OF(right);
    i16 right_kind = (i16)TYPE_W(right_type, TYPE_KIND);
    u16 selected_type = 0;      /* the original leaves it unset where no path sets it */
    i16 selected_kind = 0;
    if ((EXPR_FLAGS_AT(left_kind) & 2) || (EXPR_FLAGS_AT(right_kind) & 2)) {
        if (EXPR_FLAGS_AT(left_kind) & 2) {
            selected_type = left_type;
            selected_kind = left_kind;
        }
        if ((EXPR_FLAGS_AT(right_kind) & 2) && right_kind > selected_kind) {
            selected_type = right_type;
            selected_kind = right_kind;
        }
        if (requested && (FLAGS(requested) & 2) && (i16)TYPE_W(requested, TYPE_KIND) > selected_kind)
            selected_type = requested;
    } else {
        u16 left_rank = (u16)RANK(left_kind), right_rank = (u16)RANK(right_kind);
        if (left_rank > right_rank ||
            (left_rank == right_rank && (EXPR_FLAGS_AT(left_kind) & 0x20) && !(EXPR_FLAGS_AT(right_kind) & 0x20))) {
            selected_type = left_type;
            selected_kind = left_kind;
        } else {
            selected_type = right_type;
            selected_kind = right_kind;
        }
        requested_kind = requested ? (i16)TYPE_W(requested, TYPE_KIND) : selected_kind;
        if (requested_kind >= 5) {
            if (selected_kind < 4)
                selected_type = INT_TYPE;
            else if (selected_kind == 4)
                selected_type = UNSIGNED_INT_TYPE;
        }
    }
    u16 converted = CONVERT_EXPR_TO_TYPE(selected_type, right, 0);
    RIGHT(expression) = converted;
    converted = CONVERT_EXPR_TO_TYPE(selected_type, left, 0);
    LEFT(expression) = converted;
    EXPR_W(expression, EXPR_TYPE) = selected_type;
    return expression;
}

/* a pointer operand made a pointer of kind to target, by an analysed cast */
static u16 cast_pointer(u16 node, u16 target, u16 kind)
{
    u16 pointer = MAKE_POINTER_TYPE(target, kind, 0);
    return ANALYZE_EXPRESSION(MAKE_CAST_NODE(pointer, node), 0, 0);
}

/* the operands of the binary node brought to a common type: arithmetic operands (or one
   arithmetic and one class, for C++ conversions) by USUAL_ARITHMETIC_CONVERSIONS.  Two
   pointers: null constants take the other pointer's type, both become the larger pointer
   kind (_seg with another kind gives far), enum targets their integer type, a void
   pointer side wins, in C++ a pointer to a derived class becomes the base class pointer,
   and a based pointer becomes the plain one.  The node takes the right operand's type */
u16 BALANCE_BINARY_OPERANDS(u16 requested, u16 expression)
{
    u16 left = LEFT(expression), right = RIGHT(expression);
    u8 arithmetic = 0;
    if (FLAGS_OF(left) & 3)
        arithmetic = (FLAGS_OF(right) & 3) || (FLAGS_OF(right) & 0x40);
    else if (FLAGS_OF(right) & 3)
        arithmetic = FLAGS_OF(left) & 0x40;
    if (arithmetic)
        return USUAL_ARITHMETIC_CONVERSIONS(requested, expression);
    EXPR_W(left, EXPR_TYPE) = ENUM_UNDERLYING_TYPE(TYPE_OF(left));
    EXPR_W(right, EXPR_TYPE) = ENUM_UNDERLYING_TYPE(TYPE_OF(right));
    right = NULL_CONSTANT_TO_POINTER(TYPE_OF(left), right);
    left = NULL_CONSTANT_TO_POINTER(TYPE_OF(right), left);
    if ((FLAGS_OF(right) & 0x14) && (FLAGS_OF(left) & 0x14)) {
        i16 right_kind = (i16)KIND_OF(right), left_kind = (i16)KIND_OF(left);
        i16 kind = right_kind > left_kind ? right_kind : left_kind;
        if (kind == 0x0E && right_kind != left_kind)
            kind = 0x0F;
        u16 right_type = ENUM_UNDERLYING_TYPE(TYPE_W(TYPE_OF(right), TYPE_TARGET));
        if (TYPE_W(TYPE_OF(right), TYPE_TARGET) != right_type || kind != right_kind)
            right = cast_pointer(right, right_type, (u16)kind);
        u16 left_type = ENUM_UNDERLYING_TYPE(TYPE_W(TYPE_OF(left), TYPE_TARGET));
        if (TYPE_W(TYPE_OF(left), TYPE_TARGET) != left_type || kind != left_kind)
            left = cast_pointer(left, left_type, (u16)kind);
        if ((FLAGS_OF(left) & 0x14) && TYPE_W(TYPE_W(TYPE_OF(left), TYPE_TARGET), TYPE_KIND) == TK_VOID)
            right = CONVERT_EXPR_TO_TYPE(TYPE_OF(left), right, 0);
        else if ((FLAGS_OF(right) & 0x14) && TYPE_W(TYPE_W(TYPE_OF(right), TYPE_TARGET), TYPE_KIND) == TK_VOID)
            left = CONVERT_EXPR_TO_TYPE(TYPE_OF(right), left, 0);
        else if (CPP_MODE && !TYPES_COMPATIBLE(right_type, left_type, 1)) {
            if (IS_BASE_CLASS(right_type, left_type, 1))
                left = CONVERT_EXPR_TO_TYPE(TYPE_OF(right), left, 0);
            else if (IS_BASE_CLASS(left_type, right_type, 1))
                right = CONVERT_EXPR_TO_TYPE(TYPE_OF(left), right, 0);
        }
        if (TYPE_W(TYPE_OF(left), TYPE_PTR_BASE) && !TYPE_W(TYPE_OF(right), TYPE_PTR_BASE))
            left = CONVERT_EXPR_TO_TYPE(TYPE_OF(right), left, 0);
        else if (TYPE_W(TYPE_OF(right), TYPE_PTR_BASE) && !TYPE_W(TYPE_OF(left), TYPE_PTR_BASE))
            right = CONVERT_EXPR_TO_TYPE(TYPE_OF(left), right, 0);
    }
    EXPR_W(expression, EXPR_TYPE) = TYPE_OF(right);
    LEFT(expression) = left;
    RIGHT(expression) = right;
    return expression;
}

/* a value of based pointer type (TYPE_PTR_BASE names the base expression as text in
   POOL_HASH) made base + pointer: the text is pushed as input and parsed, and the
   lexer's current token is put back afterwards.  node unchanged when the base does not
   parse */
u16 APPLY_BASED_POINTER(u16 node)
{
    u8 saved[TOKEN_RECORD_SIZE];
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
        saved[i] = B(fp_add(CURRENT_TOKEN_RECORD_P, i));
    BCC_INPUT_STRING_PTR(FP_OFF(POOL_HASH_P), TYPE_W(TYPE_OF(node), TYPE_PTR_BASE));
    ADVANCE_TOKEN();
    u16 result = PARSE_ASSIGNMENT_EXPR(7);
    POP_INPUT_CONTEXT(1);
    for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
        B(fp_add(CURRENT_TOKEN_RECORD_P, i)) = saved[i];
    CURRENT_TOKEN = W(CURRENT_TOKEN_RECORD_P);
    if (!result)
        return node;
    return MAKE_BINARY_NODE(0x16, result, node);
}
