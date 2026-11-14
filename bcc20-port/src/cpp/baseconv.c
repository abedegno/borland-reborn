/* baseconv.c: from bcc20/src/cpp/BASECONV.C: expression rewrites the C++ front end needs
   for references, class hierarchies and temporaries, called from expression analysis,
   CPPEXPCK.C, CPPCALL.C and the constructor builders.
   - References are pointer types with TYPE_ATTRS bit 20h (EXPR_FLAGS[kind] & 14h selects
     pointer-like kinds).  MAKE_REFERENCE retypes a pointer-valued node as a reference,
     STRIP_REFERENCE does the reverse, DEREF_REFERENCE_EXPR turns a reference-valued node
     into the object it refers to.
   - Base class conversion: ACCUMULATE_BASE_OFFSET finds the path from a derived class down
     to a base and adds up the subobject offsets; each virtual base on the path cannot be
     reached by a constant, so it adds a read of the virtual base pointer to a chain, built
     inside out by BUILD_BASE_ADJUST_EXPR.  CONVERT_DERIVED_TO_BASE and
     CONVERT_BASE_TO_DERIVED use that to convert pointers (with a null test so a null
     pointer stays null) and references.  GET_BASE_OFFSET gives a constant offset;
     ADJUST_MEMBER_FUNC_PTR_BASE and ADJUST_NODE_BASE_OFFSET move pointers to members
     between classes.
   - CONSTRUCT_TEMP_OBJECT builds an object with a constructor in a temporary and registers
     its destructor on the current scope.
   - IS_OBJECT_RVALUE and REWRITE_FOR_REFERENCE_BIND deal with C++ expressions whose result
     is an object (assignments, prefix ++/--, and comma or ?: built from them) although
     IS_LVALUE does not treat them as lvalues.
   Pointer offsets are added as (char *)p + n with token-coded nodes (16h '+', 18h unary
   '*', 1Dh unary '&', 0Bh '=', 2Fh '.'), and MAKE_CONDITIONAL_NODE(20h, c, a, b) is
   c ? a : b. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "exprop.h"
#include "protos.h"
#include "calls.h"

#define E(n, o) EXPR_W((n), (o))
#define KIND(type) TYPE_W((type), TYPE_KIND)
#define KIND_FLAGS(type) EXPR_FLAGS_AT(KIND(type))
#define IS_REFERENCE(type) ((KIND_FLAGS(type) & 0x14) && (TYPE_B((type), TYPE_ATTRS) & 0x20))
#define TEMPS_OF(scope) W(MK_FP(SCOPE_POOL_SEG, (scope) + SCOPE_TEMPS))
#define OP_CAST 0x35

/* if node value has a reference type, retypes it in place as the matching pointer type
   (same target and kind, no reference bit).  Returns value */
u16 STRIP_REFERENCE(u16 value)
{
    if (IS_REFERENCE(E(value, EXPR_TYPE))) {
        u16 type = MAKE_POINTER_TYPE(TYPE_W(E(value, EXPR_TYPE), TYPE_TARGET), KIND(E(value, EXPR_TYPE)), 0);
        E(value, EXPR_TYPE) = type;
    }
    return value;
}

/* if node value has a (non-reference) pointer type, retypes it in place as a reference to
   the same target, keeping the pointer mode and word 9 */
u16 MAKE_REFERENCE(u16 value)
{
    if ((KIND_FLAGS(E(value, EXPR_TYPE)) & 0x14) && !(TYPE_B(E(value, EXPR_TYPE), TYPE_ATTRS) & 0x20)) {
        u16 type = E(value, EXPR_TYPE);
        u16 reference = MAKE_POINTER_TYPE(TYPE_W(type, TYPE_TARGET), KIND(type), 1);
        E(value, EXPR_TYPE) = reference;
        TYPE_B(E(value, EXPR_TYPE), TYPE_PTR_MODE) = TYPE_B(type, TYPE_PTR_MODE);
        TYPE_W(E(value, EXPR_TYPE), TYPE_PARAMS) = TYPE_W(type, TYPE_PARAMS);
    }
    return value;
}

/* turns a reference-valued expression into the referred object: &x typed as a reference
   to x's type gives back x itself, anything else gets a dereference node.  A reference to
   a function is left alone.  A symbol of storage class 14 (a member alias) is an error
   here */
u16 DEREF_REFERENCE_EXPR(u16 value)
{
    if (!value)
        return value;
    if (E(value, EXPR_OP) == 1 && (SYM_B(E(value, EXPR_LEFT), SYM_STORAGE_CLASS) >> 3) == 14)
        return REPORT_EXPR_ERROR_PLAIN(MSG_ILLEGAL_STRUCTURE, value);
    if (IS_REFERENCE(E(value, EXPR_TYPE))) {
        if (KIND(TYPE_W(E(value, EXPR_TYPE), TYPE_TARGET)) == TK_FUNCTION)
            return value;
        if (E(value, EXPR_OP) == EOP_ADDR && TYPE_W(E(value, EXPR_TYPE), TYPE_TARGET) == E(E(value, EXPR_LEFT), EXPR_TYPE)) {
            u16 next = E(value, EXPR_LEFT);
            FREE_EXPR_NODE(value);
            return next;
        }
        value = MAKE_DEREF_NODE(value);
    }
    return value;
}

/* *(value **)<hole>: reads a virtual base pointer of class value.  The cast's operand is
   left 0; BUILD_BASE_ADJUST_EXPR fills it in */
u16 MAKE_VBASE_POINTER_EXPR(u16 value)
{
    u16 intermediate = MAKE_POINTER_TYPE(MAKE_POINTER_TYPE(value, 0, 0), 0, 0);
    return MAKE_UNARY_NODE(0x18, MAKE_CAST_NODE(intermediate, 0));
}

/* (char *)third + value (no addition when value is 0).  If node, a chain of virtual base
   pointer reads, is given, the result is stored in the chain's innermost empty cast and
   the chain is returned, so the new expression becomes the address the deepest read
   starts from */
u16 BUILD_BASE_ADJUST_EXPR(u16 node, i16 value, u16 third)
{
    third = MAKE_CAST_NODE(CHAR_POINTER_TYPE, third);
    if (value)
        third = MAKE_BINARY_NODE(0x16, third, MAKE_INT_CONSTANT(INT_TYPE, value));
    if (node == 0)
        return third;
    u16 original = node;
    while (E(node, EXPR_OP) != OP_CAST || E(node, EXPR_LEFT) != 0)
        node = E(node, EXPR_LEFT);
    E(node, EXPR_LEFT) = third;
    return original;
}

/* finds base class left inside class right (depth first, the first path found) and
   accumulates how to get there: *delta collects constant offsets; at a virtual base the
   offset so far and a virtual base pointer read are folded into the expression chain *out
   and *delta restarts at 0.  *state is 1 when left was found (or is right itself).  The
   word at 2 of the base list (the null record's base type) is set to left, so the search
   loop always stops */
void ACCUMULATE_BASE_OFFSET(u16 left, u16 right, farptr delta, farptr out, farptr state)
{
    B(state) = 0;
    if (right != left) {
        u16 cursor = TAG_W(TYPE_W(right, TYPE_TAG_BODY), TAG_BASES);
        BASE_W(2, BASE_NEXT) = left;
        while (TYPE_W(BASE_W(cursor, BASE_TYPE), TYPE_TAG_BODY) != TYPE_W(left, TYPE_TAG_BODY)) {
            ACCUMULATE_BASE_OFFSET(left, BASE_W(cursor, BASE_TYPE), delta, out, state);
            if (B(state) != 0)
                break;
            cursor = BASE_W(cursor, BASE_NEXT);
        }
        if (cursor == 0) {
            B(state) = 0;
            return;
        }
        if (BASE_B(cursor, BASE_VIRTUAL) != 0) {
            u16 chain = W(out);
            i16 offset = SW(delta);
            W(out) = BUILD_BASE_ADJUST_EXPR(chain, offset, MAKE_VBASE_POINTER_EXPR(BASE_W(cursor, BASE_TYPE)));
            SW(delta) = 0;
        }
        SW(delta) = (i16)(SW(delta) + (i16)BASE_W(cursor, BASE_OFFSET));
    }
    B(state) = 1;
}

/* p ? adjusted : (char *)p, testing a copy of node */
static u16 null_test(u16 node, u16 adjusted)
{
    u16 test = COPY_EXPR_TREE(node);
    u16 copy = COPY_EXPR_TREE(node);
    return MAKE_CONDITIONAL_NODE(0x20, test, adjusted, MAKE_CAST_NODE(CHAR_POINTER_TYPE, copy));
}

/* converts node, a pointer to class target, to a pointer to base class type, going
   through class middle first when it is not 0.  With flag the value is a reference: the
   result is retyped as a reference and no null test is made.  Otherwise, when extra is set
   and the conversion is not a no-op, the pointer is saved in a temporary and tested:
   p ? adjusted : (char *)p.  Without any offset the conversion is just a checked cast */
u16 CONVERT_DERIVED_TO_BASE(u16 node, u16 target, u16 middle, u16 type, u8 flag, u8 extra)
{
    if (type == target)
        return node;
    /* the original frame from BP-0Ah to the parameter node at BP+10h: temp, state at 5,
       second at 6, first at 8 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x1C);
    farptr temp = v, state = fp_add(v, 5), second = fp_add(v, 6), first = fp_add(v, 8), slot = fp_add(v, 0x1A);
    W(slot) = node;
    if (flag)
        extra = 0;
    W(first) = 0;
    W(second) = 0;
    ACCUMULATE_BASE_OFFSET(type, middle == 0 ? target : middle, first, second, state);
    if (middle)
        ACCUMULATE_BASE_OFFSET(middle, target, first, second, state);
    if (W(first) || W(second)) {
        W(slot) = STRIP_REFERENCE(W(slot));
        W(temp) = 0;
        if (extra)
            SAVE_EXPR_IN_TEMP(slot, temp);
        u16 result = BUILD_BASE_ADJUST_EXPR(W(second), SW(first), W(slot));
        if (extra)
            result = null_test(W(slot), result);
        u16 saved = W(temp);
        W(slot) = JOIN_COMMA_EXPR(saved, MAKE_CAST_NODE(MAKE_POINTER_TYPE(type, 0, 0), result));
        W(slot) = ANALYZE_EXPRESSION(W(slot), 0, 0);
        if (flag)
            W(slot) = MAKE_REFERENCE(W(slot));
    } else
        W(slot) = CHECK_CAST(MAKE_CAST_NODE(MAKE_POINTER_TYPE(type, 0, flag), W(slot)));
    node = W(slot);
    scratch_release(mark);
    return node;
}

/* converts node, a pointer to base class target, to a pointer to derived class type by
   subtracting the base's constant offset (only the constant part is used).  A pointer
   (flag 0) gets the null test; a reference (flag 1) is retyped as a reference */
u16 CONVERT_BASE_TO_DERIVED(u16 node, u16 target, u16 type, u8 flag)
{
    /* the original frame from BP-8 to the parameter node at BP+0Ch: temp, state at 3,
       second at 4, first at 6 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x16);
    farptr temp = v, state = fp_add(v, 3), second = fp_add(v, 4), first = fp_add(v, 6), slot = fp_add(v, 0x14);
    W(slot) = node;
    W(first) = 0;
    W(second) = 0;
    ACCUMULATE_BASE_OFFSET(target, type, first, second, state);
    if (W(first)) {
        W(slot) = STRIP_REFERENCE(W(slot));
        SAVE_EXPR_IN_TEMP(slot, temp);
        u16 result = BUILD_BASE_ADJUST_EXPR(0, (i16)-SW(first), W(slot));
        if (!flag)
            result = null_test(W(slot), result);
        u16 saved = W(temp);
        W(slot) = JOIN_COMMA_EXPR(saved, MAKE_CAST_NODE(MAKE_POINTER_TYPE(type, 0, 0), result));
        W(slot) = ANALYZE_EXPRESSION(W(slot), 0, 0);
        if (flag)
            W(slot) = MAKE_REFERENCE(W(slot));
    } else
        W(slot) = CHECK_CAST(MAKE_CAST_NODE(MAKE_POINTER_TYPE(type, 0, flag), W(slot)));
    node = W(slot);
    scratch_release(mark);
    return node;
}

/* the constant offset between classes left and right, negative when left is not a base
   of right; v is the frame of three locals: unused at 4, state at 3, delta at 6 */
static i16 member_offset(farptr v, u16 left, u16 right)
{
    farptr state = fp_add(v, 3), unused = fp_add(v, 4), delta = fp_add(v, 6);
    SW(delta) = 0;
    W(unused) = 0;
    B(state) = 0;
    if (IS_BASE_CLASS(left, right, 0)) {
        ACCUMULATE_BASE_OFFSET(left, right, delta, unused, state);
        return SW(delta);
    }
    ACCUMULATE_BASE_OFFSET(right, left, delta, unused, state);
    SW(delta) = (i16)-SW(delta);
    return SW(delta);
}

/* converts a pointer to member function between classes left and right.  node is the
   conversion node (it is freed; its operand is used and the result gets the node's type).
   The offset between the classes is added to the pointer's this-adjust part: directly for
   a 48h constant, otherwise through a temporary: (tmp = value, tmp.delta += tmp ? offset :
   0, tmp).  temp is a side-effect-free place to use, or 0 to make a new local */
u16 ADJUST_MEMBER_FUNC_PTR_BASE(u16 node, u16 left, u16 right, u16 temp)
{
    u16 saved = E(node, EXPR_TYPE);
    u16 aux = node;
    node = E(aux, EXPR_LEFT);
    FREE_EXPR_NODE(aux);
    /* the original frame from BP-0Ah: state at 3, unused at 4, delta at 6 */
    u16 mark = scratch_mark();
    i16 delta = member_offset(scratch_alloc(0x0A), left, right);
    scratch_release(mark);
    if (delta) {
        if (E(node, EXPR_OP) == 0x48)
            E(node, EXPR_LEFT) += delta;
        else {
            if (!temp || !IS_SIDE_EFFECT_FREE(temp))
                temp = ANALYZE_EXPRESSION(MAKE_SYMBOL_NODE(CREATE_LOCAL_TEMP(saved)), 0, 0);
            aux = COPY_EXPR_TREE(temp);
            E(aux, EXPR_TYPE) = E(node, EXPR_TYPE);
            node = MAKE_BINARY_NODE(0x0B, aux, node);
            aux = COPY_EXPR_TREE(temp);
            E(aux, EXPR_TYPE) = MEMBER_PTR_CLASS_TYPE;
            aux = MAKE_BINARY_NODE(0x2F, aux, MAKE_FIELD_REF_NODE(MEMBER_PTR_DELTA_MEMBER));
            u16 test = COPY_EXPR_TREE(temp);                         /* pascal: left to right */
            u16 offset = MAKE_INT_CONSTANT(INT_TYPE, delta);
            u16 result = MAKE_CONDITIONAL_NODE(0x20, test, offset, MAKE_INT_CONSTANT(INT_TYPE, 0));
            aux = MAKE_BINARY_NODE(0x0C, aux, result);
            node = JOIN_COMMA_EXPR(node, aux);
            node = ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(node, COPY_EXPR_TREE(temp)), 0, 0);
        }
    }
    E(node, EXPR_TYPE) = saved;
    return node;
}

/* the same for a pointer to data member, which is an offset: adds the difference between
   classes left and right to a constant, or builds (type)((int)value + offset).  node is
   the conversion node and is freed */
u16 ADJUST_NODE_BASE_OFFSET(u16 node, u16 left, u16 right)
{
    u16 type = E(node, EXPR_TYPE);
    u16 saved = node;
    node = E(saved, EXPR_LEFT);
    FREE_EXPR_NODE(saved);
    /* the original frame from BP-8: state at 3, unused at 4, delta at 6 */
    u16 mark = scratch_mark();
    i16 delta = member_offset(scratch_alloc(8), left, right);
    scratch_release(mark);
    if (delta == 0) {
        E(node, EXPR_TYPE) = type;
        return node;
    }
    if (E(node, EXPR_OP) == EOP_CONST) {
        EXPR_L(node, EXPR_LEFT) = (i32)((u32)EXPR_L(node, EXPR_LEFT) + (u32)(i32)delta);
        E(node, EXPR_TYPE) = type;
        return node;
    }
    node = MAKE_CAST_NODE(INT_TYPE, node);
    node = MAKE_BINARY_NODE(0x16, node, MAKE_INT_CONSTANT(INT_TYPE, delta));
    node = MAKE_CAST_NODE(type, node);
    return ANALYZE_EXPRESSION(node, type, 0);
}

/* the offset of base class left inside class right as a constant: 0 when left is not a
   base of right; when the path goes through a virtual base, the offset of left in
   COLLECT_VBASES(right) (right taken as a complete object; 0 if left is not itself one of
   the virtual bases) */
u16 GET_BASE_OFFSET(u16 left, u16 right)
{
    /* the original frame from BP-8: state at 3, second at 4, first at 6 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(8);
    farptr state = fp_add(v, 3), second = fp_add(v, 4), first = fp_add(v, 6);
    W(first) = 0;
    W(second) = 0;
    B(state) = 0;
    ACCUMULATE_BASE_OFFSET(left, right, first, second, state);
    u8 found = B(state);
    u16 offset = W(first), chain = W(second);
    scratch_release(mark);
    if (!found)
        return 0;
    if (chain == 0)
        return offset;
    FREE_EXPR_TREE(chain);
    u16 cursor = COLLECT_VBASES(right), result = 0;
    while (cursor) {
        if (TYPE_W(BASE_W(cursor, BASE_TYPE), TYPE_TAG_BODY) == TYPE_W(left, TYPE_TAG_BODY))
            result = BASE_W(cursor, BASE_OFFSET);
        u16 entry = cursor;
        cursor = BASE_W(cursor, BASE_NEXT);
        FREE_PARAM_ITEM(entry);
    }
    return result;
}

/* constructs an object of type with argument list value.  When node is an object of the
   same type without side effects, it is constructed in place: (node.type(value), node).
   Otherwise a new local temporary is used, giving *(tmp.type(value), &tmp), and the
   temporary's destructor is put on the current scope's list.  Returns the analyzed tree */
u16 CONSTRUCT_TEMP_OBJECT(u16 type, u16 value, u16 node)
{
    u16 temp;
    if (node && (!TYPES_COMPATIBLE(E(node, EXPR_TYPE), type, 1) || !IS_SIDE_EFFECT_FREE(node)))
        node = 0;
    if (node == 0)
        temp = MAKE_SYMBOL_NODE(CREATE_LOCAL_TEMP(type));
    else
        temp = COPY_EXPR_TREE(node);
    u16 result = COPY_EXPR_TREE(temp);
    if (node == 0)
        result = MAKE_UNARY_NODE(0x1D, result);
    result = JOIN_COMMA_EXPR(BUILD_CONSTRUCTOR_CALL(temp, type, value), result);
    if (node == 0) {
        result = MAKE_UNARY_NODE(0x18, result);
        u16 copy = COPY_EXPR_TREE(temp);                             /* pascal: left to right */
        u16 temps = REGISTER_TEMP_DESTRUCTOR(copy, type, TEMPS_OF(CURRENT_SCOPE));
        TEMPS_OF(CURRENT_SCOPE) = temps;
    }
    return ANALYZE_EXPRESSION(result, 0, 0);
}

/* whether node yields an object in C++ although it is not a plain lvalue: an assignment
   or compound assignment, a ++ or -- without node flag 2 (the prefix form), a comma whose
   right side is such an object, or a ?: whose two arms both are */
u8 IS_OBJECT_RVALUE(u16 node)
{
    switch (E(node, EXPR_OP)) {
    case EOP_INC:
    case EOP_DEC:
        return !(EXPR_B(node, EXPR_NODE_FLAGS) & 2);
    case EOP_COMMA:
        return IS_LVALUE(E(node, EXPR_RIGHT)) || IS_OBJECT_RVALUE(E(node, EXPR_RIGHT));
    case EOP_QUESTION: {
        u16 child = E(node, EXPR_RIGHT);
        return (IS_LVALUE(E(child, EXPR_LEFT)) || IS_OBJECT_RVALUE(E(child, EXPR_LEFT)))
               && (IS_LVALUE(E(child, EXPR_RIGHT)) || IS_OBJECT_RVALUE(E(child, EXPR_RIGHT)));
    }
    case EOP_ASSIGN: case EOP_ADD_ASSIGN: case EOP_SUB_ASSIGN: case EOP_MUL_ASSIGN:
    case EOP_DIV_ASSIGN: case EOP_MOD_ASSIGN: case EOP_SHL_ASSIGN: case EOP_SHR_ASSIGN:
    case EOP_AND_ASSIGN: case EOP_OR_ASSIGN: case EOP_XOR_ASSIGN:
        return 1;
    default:
        return 0;
    }
}

/* makes an object-yielding expression (see IS_OBJECT_RVALUE) addressable, before & is
   applied or a reference is bound: x op= y becomes *(save, x op= y, &x) with x's address
   kept in a temporary when needed; for comma and ?: the parts are rewritten and their
   addresses taken.  Lvalues, references and other expressions are returned as they are */
u16 REWRITE_FOR_REFERENCE_BIND(u16 node)
{
    u16 kind = E(node, EXPR_OP);
    if (IS_REFERENCE(E(node, EXPR_TYPE)))
        return node;
    if (IS_LVALUE(node) || !IS_OBJECT_RVALUE(node))
        return node;
    if (kind == EOP_COMMA) {
        u16 value = MAKE_ADDRESS_OF(REWRITE_FOR_REFERENCE_BIND(E(node, EXPR_RIGHT)));
        E(node, EXPR_RIGHT) = value;
    } else if (kind == EOP_QUESTION) {
        u16 child = E(node, EXPR_RIGHT);
        u16 value = MAKE_ADDRESS_OF(REWRITE_FOR_REFERENCE_BIND(E(child, EXPR_LEFT)));
        E(child, EXPR_LEFT) = value;
        value = MAKE_ADDRESS_OF(REWRITE_FOR_REFERENCE_BIND(E(child, EXPR_RIGHT)));
        E(child, EXPR_RIGHT) = value;
    } else {
        /* the original frame from BP-6: temp, value at 2 */
        u16 mark = scratch_mark();
        farptr v = scratch_alloc(6);
        farptr temp = v, value = fp_add(v, 2);
        W(value) = E(node, EXPR_LEFT);
        W(temp) = 0;
        SAVE_EXPR_IN_TEMP(value, temp);
        W(value) = ANALYZE_EXPRESSION(W(value), 0, 0);
        E(node, EXPR_LEFT) = W(value);
        u16 joined = JOIN_COMMA_EXPR(W(temp), node);
        node = JOIN_COMMA_EXPR(joined, MAKE_ADDRESS_OF(COPY_EXPR_TREE(W(value))));
        scratch_release(mark);
    }
    EXPR_B(node, EXPR_NODE_FLAGS) &= 0xFE;
    return ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x18, node), 0, 0);
}
