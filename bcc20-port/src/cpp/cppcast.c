/* cppcast.c: from bcc20/src/cpp/CPPCAST.C: C++ hooks of expression analysis.  EXPRDISP.C
   calls these in C++ mode for symbol references, temporary-object nodes and casts; the
   statement parser and the operator checks call the two CONVERT_CLASS_TO_* functions where
   a condition or an integer is required.  RESOLVE_SYMBOL_NODE finishes a symbol node by
   storage class (enumerators and constants become constant nodes, an overloaded function
   name is resolved against the wanted type, a member alias becomes object.member);
   CAST_EXPRESSION handles the C++ cases of (type)expr and returns 0 for an ordinary C
   cast; CONVERT_CLASS_TO_* apply a conversion function to a class value, and turn a
   pointer to member into something testable.  Storage classes seen here: 1-5 objects and
   functions, 6 a parameter, 9 a constant with a stored value, 14 a member alias, 15 an int
   enumerator.  A pointer to member is a TK_NEAR_PTR with pointer mode 0Bh.  The locals
   whose addresses are passed live in the scratch area in the original frame's layout. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "protos.h"
#include "calls.h"

#define E(n, o) EXPR_W((n), (o))
#define KIND(t) TYPE_W((t), TYPE_KIND)
#define IS_POINTER(t) (EXPR_FLAGS_AT(KIND(t)) & 0x14)
#define IS_REFERENCE(t) (IS_POINTER(t) && (TYPE_B((t), TYPE_ATTRS) & 0x20))
#define IS_MEMBER_POINTER(t) (KIND(t) == TK_NEAR_PTR && TYPE_B((t), TYPE_PTR_MODE) == 0x0B)
#define TO_FUNCTION(t) (IS_POINTER(t) && KIND(TYPE_W((t), TYPE_TARGET)) == TK_FUNCTION)

/* finishes symbol node expression (EXPR_LEFT is the symbol); type is the type the value is
   wanted as, or 0.  A parameter of a class with constructors gets a reference type.  An
   overloaded function name is resolved with FIND_MATCHING_OVERLOAD when type is a function
   or pointer to function; without such a type the name is ambiguous.  Marks the result with
   node flag 1 */
u16 RESOLVE_SYMBOL_NODE(u16 expression, u16 type)
{
    u16 symbol = E(expression, EXPR_LEFT);
    u16 base = SYM_W(symbol, SYM_TYPE);
    switch (SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) {
    case 6:
        if ((EXPR_FLAGS_AT(KIND(base)) & 0x40) && (TYPE_B(base, TYPE_ATTRS) & 4)) {
            u16 reference = MAKE_POINTER_TYPE(base, 0, 1);
            E(expression, EXPR_TYPE) = reference;
        }
        break;
    case 15:
        expression = MAKE_INT_CONSTANT(base, (i16)SYM_W(symbol, SYM_CONST_VALUE));
        break;
    case 9:
        FREE_EXPR_NODE(expression);
        if (EXPR_FLAGS_AT(KIND(base)) & 1)
            expression = MAKE_INT_CONSTANT(base, SYM_L(symbol, SYM_CONST_VALUE));
        else {
            u16 mark = scratch_mark();
            farptr real = scratch_alloc(10);
            RTL_MEMMOVE(real, MK_FP(SYMBOL_POOL_SEG, symbol + SYM_CONST_VALUE), 10);
            expression = MAKE_REAL_CONSTANT(base, real);
            scratch_release(mark);
        }
        break;
    case 1: case 2: case 3: case 4: case 5:
        if (KIND(SYM_W(symbol, SYM_TYPE)) == TK_FUNCTION && SYM_W(symbol, SYM_NEXT_OVERLOAD) && type) {
            if (TO_FUNCTION(type) || KIND(type) == TK_FUNCTION) {
                symbol = FIND_MATCHING_OVERLOAD(E(expression, EXPR_LEFT), type);
                if (!symbol)
                    expression = REPORT_EXPR_ERROR(MSG_COULD_NOT_FIND_MATCH, (farptr)FORMAT_TYPE(type), 0, expression);
                else {
                    E(expression, EXPR_LEFT) = symbol;
                    E(expression, EXPR_TYPE) = SYM_W(symbol, SYM_TYPE);
                }
            } else {
                farptr first = FORMAT_SYMBOL(symbol);       /* pascal: left to right */
                farptr second = FORMAT_SYMBOL(SYM_W(symbol, SYM_NEXT_OVERLOAD));
                expression = REPORT_EXPR_ERROR(MSG_AMBIGUITY_BETWEEN, first, (i32)second, expression);
            }
        }
        break;
    case 14: {
        E(expression, EXPR_LEFT) = SYM_W(symbol, SYM_ALIAS_OBJECT);
        u16 field = MAKE_FIELD_REF_NODE(SYM_W(symbol, SYM_ALIAS_MEMBER));
        expression = MAKE_BINARY_NODE(0x2F, expression, field);
        return ANALYZE_EXPRESSION(expression, 0, 0);
    }
    }
    EXPR_B(expression, EXPR_NODE_FLAGS) |= 1;
    return expression;
}

/* a node standing for type(args) (EXPR_TYPE the class, EXPR_RIGHT the arguments) becomes a
   constructed temporary; context is the object to construct into if it fits */
u16 ANALYZE_TEMP_OBJECT_NODE(u16 expression, u16 context)
{
    u16 result = CONSTRUCT_TEMP_OBJECT(E(expression, EXPR_TYPE), E(expression, EXPR_RIGHT), context);
    FREE_EXPR_NODE(expression);
    return result;
}

static u16 cannot_cast(u16 source, u16 target, u16 expression)
{
    i32 from = FORMAT_TYPE(source);                     /* pascal: left to right */
    i32 to = FORMAT_TYPE(target);
    return REPORT_EXPR_ERROR(MSG_CANNOT_CAST_FROM, (farptr)from, to, expression);
}

/* the cast node expression to type EXPR_TYPE: the operand is analysed; if the types are
   already compatible, the operand is just retyped.  Otherwise a user conversion, or a
   constructor of the target class taking the value: a constructor gives a temporary
   object, a conversion function a member call.  Without one: a cast to a reference takes
   the operand's address (after making it addressable); a 0 cast to a pointer to member
   function becomes a null member pointer constant; member pointer casts adjust between
   related classes; pointer casts between classes convert derived to base (must be unique)
   or base to derived (unique and non-virtual).  0 when the cast is not a C++ special case
   and the caller should treat it as a C cast */
u16 CAST_EXPRESSION(u16 expression, u16 context)
{
    u16 target = E(expression, EXPR_TYPE), source, result, symbol, operand, node;
    u8 reference = IS_REFERENCE(target);
    u8 member_reference = 0;
    if (reference && E(expression, EXPR_LEFT) && E(E(expression, EXPR_LEFT), EXPR_OP) == 1)
        member_reference = (SYM_B(E(E(expression, EXPR_LEFT), EXPR_LEFT), SYM_STORAGE_CLASS) >> 3) == 9;
    u16 left = ANALYZE_EXPRESSION(E(expression, EXPR_LEFT), target, 0);
    E(expression, EXPR_LEFT) = left;
    if (!reference || !IS_POINTER(E(E(expression, EXPR_LEFT), EXPR_TYPE)) ||
        (TYPE_B(E(E(expression, EXPR_LEFT), EXPR_TYPE), TYPE_ATTRS) & 0x20) == 0) {
        left = CONVERT_TO_RVALUE(E(expression, EXPR_LEFT));
        E(expression, EXPR_LEFT) = left;
    }
    source = E(E(expression, EXPR_LEFT), EXPR_TYPE);
    EXPR_B(expression, EXPR_NODE_FLAGS) |= 1;
    /* already compatible: the cast only changes the type */
    if (TYPES_COMPATIBLE(source, target, 2)) {
        E(E(expression, EXPR_LEFT), EXPR_TYPE) = target;
        result = E(expression, EXPR_LEFT);
    } else {
        symbol = FIND_USER_CONVERSION(target, source, 1, E(expression, EXPR_SRC_LINE), E(expression, EXPR_SRC_WORD3));
        if (!symbol && (EXPR_FLAGS_AT(KIND(target)) & 0x40) && (TYPE_B(target, TYPE_ATTRS) & 4)) {
            operand = FIND_MEMBER_BY_NAME(CTOR_NAME, target);
            if (operand)
                symbol = MEMBER_W(operand, MEMB_VALUE);
        }
        /* no user conversion: reference, member pointer and class pointer casts remain;
           0 means "an ordinary C cast" */
        if (!symbol) {
            if (reference && !IS_REFERENCE(source)) {
                operand = E(expression, EXPR_LEFT);
                if (member_reference)
                    operand = MAKE_INITIALIZED_TEMP(operand);
                if (!IS_LVALUE(operand))
                    operand = REWRITE_FOR_REFERENCE_BIND(operand);
                if (IS_LVALUE(operand)) {
                    u16 address = MAKE_REFERENCE(ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x1D, operand), 0, 0));
                    E(expression, EXPR_LEFT) = address;
                    source = E(E(expression, EXPR_LEFT), EXPR_TYPE);
                } else
                    E(expression, EXPR_LEFT) = operand;
            }
            if (!IS_POINTER(source)) {
                if (KIND(target) != TK_NEAR_PTR || TYPE_B(target, TYPE_PTR_MODE) != 0x0B || !IS_POINTER(target) ||
                    KIND(TYPE_W(target, TYPE_TARGET)) != TK_FUNCTION)
                    return 0;
                u16 mark = scratch_mark();
                farptr changed = scratch_alloc(2);
                u16 checked = CHECK_NULL_CONSTANT(E(expression, EXPR_LEFT), changed);
                u8 was_changed = B(changed);
                scratch_release(mark);
                E(expression, EXPR_LEFT) = checked;
                if (!was_changed)
                    return cannot_cast(source, target, expression);
                node = E(expression, EXPR_LEFT);
                E(node, EXPR_OP) = 0x48;
                E(node, EXPR_TYPE) = E(expression, EXPR_TYPE);
                E(node, EXPR_SCOPE_CLASS) = 0;
                E(node, EXPR_LEFT) = 0;
                E(node, EXPR_RIGHT) = 0;
                EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
                FREE_EXPR_NODE(expression);
                return node;
            }
            u16 source_inner = TYPE_W(source, TYPE_TARGET), target_inner;
            if (IS_MEMBER_POINTER(source)) {
                if (EXPR_FLAGS_AT(KIND(target)) & 1) {
                    if (KIND(source_inner) == TK_FUNCTION)
                        return cannot_cast(source, target, expression);
                    return expression;
                }
                if (IS_MEMBER_POINTER(target) && (TO_FUNCTION(target) != 0) == (TO_FUNCTION(source) != 0)) {
                    target_inner = TYPE_W(target, TYPE_TARGET);
                    u16 from = TYPE_W(source_inner, TYPE_MEMBER_CLASS), to = TYPE_W(target_inner, TYPE_MEMBER_CLASS);
                    if (TYPES_COMPATIBLE(from, to, 1))
                        return expression;
                    if (IS_BASE_CLASS(from, to, 0) || IS_BASE_CLASS(to, from, 0)) {
                        if (KIND(target_inner) == TK_FUNCTION)
                            return ADJUST_MEMBER_FUNC_PTR_BASE(expression, from, to, context);
                        return ADJUST_NODE_BASE_OFFSET(expression, from, to);
                    }
                }
                return cannot_cast(source, target, expression);
            }
            if (!IS_POINTER(target))
                return 0;
            target_inner = TYPE_W(target, TYPE_TARGET);
            if (TYPES_COMPATIBLE(target_inner, source_inner, 1))
                return 0;
            if (IS_BASE_CLASS(target_inner, source_inner, 0)) {
                if (!IS_UNIQUE_BASE(target_inner, source_inner))
                    return cannot_cast(source, target, expression);
                node = E(expression, EXPR_LEFT);
                result = CONVERT_DERIVED_TO_BASE(node, source_inner, 0, target_inner, reference, 1);
                result = ANALYZE_EXPRESSION(result, 0, 0);
            } else if (IS_BASE_CLASS(source_inner, target_inner, 0)) {
                if (!IS_UNIQUE_NONVIRTUAL_BASE(source_inner, target_inner))
                    return cannot_cast(source, target, expression);
                result = CONVERT_BASE_TO_DERIVED(E(expression, EXPR_LEFT), source_inner, target_inner, reference);
                result = ANALYZE_EXPRESSION(result, 0, 0);
            } else
                return reference ? expression : 0;
            if (KIND(target) != KIND(source)) {
                E(expression, EXPR_LEFT) = result;
                return CHECK_CAST(expression);
            }
            FREE_EXPR_NODE(expression);
            return result;
        } else if (SYM_W(symbol, SYM_FUNC_KIND) == 3)
            result = CONSTRUCT_TEMP_OBJECT(E(expression, EXPR_TYPE), MAKE_LIST_NODE(E(expression, EXPR_LEFT), 0), context);
        else {
            u16 member = MAKE_SYMBOL_NODE(symbol);
            node = MAKE_BINARY_NODE(0x2F, E(expression, EXPR_LEFT), member);
            node = MAKE_CALL_NODE(node, 0, 0, 0, 0, 0);
            result = ANALYZE_EXPRESSION(node, target, 0);
        }
    }
    FREE_EXPR_NODE(expression);
    return result;
}

/* an expression wanted as an int; a class value is converted with a conversion function
   (APPLY_CONVERSION_FUNCTION mask 1, integral types).  Used for switch selectors */
u16 CONVERT_CLASS_TO_INTEGRAL(u16 expression)
{
    expression = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression, INT_TYPE, 0));
    if (CPP_MODE && (EXPR_FLAGS_AT(KIND(E(expression, EXPR_TYPE))) & 0x40))
        expression = APPLY_CONVERSION_FUNCTION(expression, 1, 0);
    return expression;
}

/* member.field of the saved member pointer */
static u16 part(u16 object, u16 member)
{
    u16 field = MAKE_FIELD_REF_NODE(member);
    return MAKE_BINARY_NODE(0x2F, object, field);
}

/* an expression used as a condition or operand of !, && and ||.  A class value goes
   through a conversion function (mask 7).  A pointer to member is saved in a temporary and
   replaced by delta | vindex | offset | pad of its struct, which is nonzero exactly when
   the member pointer is not null */
u16 CONVERT_CLASS_TO_SCALAR(u16 input)
{
    /* the original frame from BP-2 (offset) to the parameter at BP+6 (expression) */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(10);
    farptr offset = v, expression = fp_add(v, 8);
    W(expression) = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(input, 0, 0));
    if (CPP_MODE) {
        u16 type = E(W(expression), EXPR_TYPE);
        if (EXPR_FLAGS_AT(KIND(type)) & 0x40)
            W(expression) = APPLY_CONVERSION_FUNCTION(W(expression), 7, 0);
        else if (IS_MEMBER_POINTER(type)) {
            SAVE_EXPR_IN_TEMP(expression, offset);
            E(W(expression), EXPR_TYPE) = MEMBER_PTR_CLASS_TYPE;
            u16 tree = part(W(expression), MEMBER_PTR_DELTA_MEMBER);
            u16 p = part(COPY_EXPR_TREE(W(expression)), MEMBER_PTR_VINDEX_MEMBER);
            tree = MAKE_BINARY_NODE(0x1C, tree, p);
            p = part(COPY_EXPR_TREE(W(expression)), MEMBER_PTR_OFFSET_MEMBER);
            tree = MAKE_BINARY_NODE(0x1C, tree, p);
            p = part(COPY_EXPR_TREE(W(expression)), MEMBER_PTR_PAD_MEMBER);
            tree = MAKE_BINARY_NODE(0x1C, tree, p);
            W(expression) = ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(W(offset), tree), 0, 0);
        }
    }
    u16 result = W(expression);
    scratch_release(mark);
    return result;
}
