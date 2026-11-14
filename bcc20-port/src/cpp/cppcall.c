/* cppcall.c: from bcc20/src/cpp/CPPCALL.C: the C++ side of function calls, used by
   expression analysis (CALLCHK.C and the operator checks).  A call node has the callee in
   EXPR_LEFT and a chain of list nodes in EXPR_RIGHT (each list node: EXPR_LEFT next,
   EXPR_RIGHT the argument).  For a member function the object becomes the first argument,
   and node flag 40h on the first list node marks that.
   - PREPARE_CALL runs first on every call: it applies operator() to class objects,
     rewrites obj.f(...) and obj.*pf(...) into calls with the object as first argument,
     resolves overloaded names and converts the object to the function's own class.
   - LOWER_VIRTUAL_CALL turns a call of a virtual function through an object that is not
     exactly known into an indirect call through the virtual table.
   - TRY_UNARY_OPERATOR_CALL and TRY_BINARY_OPERATOR_CALL replace an operator applied to
     class operands by a call of the chosen operator function.
   - CONVERT_ARGUMENT converts each argument to its parameter type and DEFAULT_ARGUMENT
     supplies default arguments.
   Nodes are built with token codes (16h '+', 17h '-', 18h unary '*', 1Dh unary '&', 2Fh
   '.', 30h '->', 5 initialization); expression operators 3Bh and 3Ch are '.' and '.*'.
   Calls nested in a call's arguments are made one by one in the original's order
   (pascal: left to right). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define E(n, o) EXPR_W((n), (o))
#define EB(n, o) EXPR_B((n), (o))
#define KIND(type) TYPE_W((type), TYPE_KIND)
#define KIND_FLAGS(type) EXPR_FLAGS_AT(KIND(type))
#define CLASS_FLAGS(type) TAG_W(TYPE_W((type), TYPE_TAG_BODY), TAG_CLASS_FLAGS)
#define TEMPS_OF(scope) W(MK_FP(SCOPE_POOL_SEG, (scope) + SCOPE_TEMPS))
#define OP_SYMBOL 1
#define MEMBER_ARGUMENT 0x40

/* a node's source position, three words at 14h */
static void copy_location(u16 to, u16 from)
{
    for (int i = 0; i < 6; i += 2)
        E(to, EXPR_SRC_FILE + i) = E(from, EXPR_SRC_FILE + i);
}

static void save_location(u16 saved[3], u16 from)
{
    for (int i = 0; i < 3; ++i)
        saved[i] = E(from, EXPR_SRC_FILE + 2 * i);
}

static void restore_location(u16 to, const u16 saved[3])
{
    for (int i = 0; i < 3; ++i)
        E(to, EXPR_SRC_FILE + 2 * i) = saved[i];
}

/* for a call of a member function with the object as first argument, checks that the
   function is accessible through the object's class, converts the object to the class
   that declares the function when it is a derived class, and drops the object argument
   for a static member function.  type is the object's class (0 or a non-class means no
   object).  Calls without an object are only access-checked against CURRENT_CLASS_TYPE */
u16 ADJUST_THIS_ARGUMENT(u16 expression, u16 type)
{
    u16 callee = E(expression, EXPR_LEFT);
    u8 direct = !(KIND_FLAGS(type) & 0x40) || E(callee, EXPR_OP) != OP_SYMBOL || KIND(E(callee, EXPR_TYPE)) != TK_FUNCTION
                || ((SYM_W(E(callee, EXPR_LEFT), SYM_FUNC_FLAGS) & 0x40) && !(EB(E(expression, EXPR_RIGHT), EXPR_NODE_FLAGS) & MEMBER_ARGUMENT))
                || !(SYM_B(E(callee, EXPR_LEFT), SYM_FLAGS) & 0x10);
    u16 context = direct ? CURRENT_CLASS_TYPE : E(E(E(expression, EXPR_RIGHT), EXPR_RIGHT), EXPR_TYPE);
    if (E(callee, EXPR_OP) == OP_SYMBOL && KIND(E(callee, EXPR_TYPE)) == TK_FUNCTION
        && (SYM_B(E(callee, EXPR_LEFT), SYM_FLAGS) & 0x10) && !SYMBOL_ACCESSIBLE(E(callee, EXPR_LEFT), context))
        return REPORT_EXPR_ERROR(0xB6, FORMAT_SYMBOL(E(callee, EXPR_LEFT)), 0, expression);
    if (direct == 0) {
        u16 target = SYM_W(SYM_W(E(callee, EXPR_LEFT), SYM_OWNER_CLASS), SYM_TYPE);
        if (!TYPES_COMPATIBLE(context, target, 1)) {
            u16 temporary = MAKE_ADDRESS_OF(E(E(expression, EXPR_RIGHT), EXPR_RIGHT));
            temporary = CONVERT_DERIVED_TO_BASE(temporary, type, E(callee, EXPR_SCOPE_CLASS), target, 0, 0);
            temporary = MAKE_DEREFERENCE(temporary);
            E(E(expression, EXPR_RIGHT), EXPR_RIGHT) = temporary;
        }
        if ((SYM_W(E(callee, EXPR_LEFT), SYM_FUNC_FLAGS) & 0x40) && (EB(E(expression, EXPR_RIGHT), EXPR_NODE_FLAGS) & MEMBER_ARGUMENT)) {
            u16 temporary = E(expression, EXPR_RIGHT);
            E(expression, EXPR_RIGHT) = E(temporary, EXPR_LEFT);
            E(temporary, EXPR_LEFT) = 0;
            FREE_EXPR_TREE(temporary);
        }
    }
    return expression;
}

/* when the callee names an overloaded function (it has a SYM_NEXT_OVERLOAD and is not a
   conversion function), analyzes every argument and picks the overload with
   SELECT_OVERLOAD; none fitting is an error.  The argument positions are saved around the
   analysis so messages still point at the source.  type is the object's class for member
   calls */
u16 RESOLVE_OVERLOADED_CALL(u16 expression, u16 type)
{
    u16 callee = E(expression, EXPR_LEFT);
    if (E(callee, EXPR_OP) != OP_SYMBOL || KIND(E(callee, EXPR_TYPE)) != TK_FUNCTION
        || SYM_W(E(callee, EXPR_LEFT), SYM_NEXT_OVERLOAD) == 0 || SYM_W(E(callee, EXPR_LEFT), SYM_FUNC_KIND) == 2)
        return expression;
    /* the original frame from BP-0Ch: flag at 1 */
    u16 mark = scratch_mark();
    farptr flag = fp_add(scratch_alloc(0x0C), 1);
    for (u16 argument = E(expression, EXPR_RIGHT); argument; argument = E(argument, EXPR_LEFT)) {
        u16 saved[3];
        save_location(saved, E(argument, EXPR_RIGHT));
        u16 value = ANALYZE_EXPRESSION(E(argument, EXPR_RIGHT), 0, 0);
        value = CONVERT_TO_RVALUE(value);
        value = CHECK_NULL_CONSTANT(value, flag);
        E(argument, EXPR_RIGHT) = value;
        restore_location(E(argument, EXPR_RIGHT), saved);
    }
    scratch_release(mark);
    u16 selected = SELECT_OVERLOAD(expression, E(callee, EXPR_LEFT), 0, 0);
    if (!selected)
        return REPORT_EXPR_ERROR(MSG_COULD_NOT_FIND_MATCH, FORMAT_CALL_SIGNATURE(expression, type), 0, expression);
    E(callee, EXPR_LEFT) = selected;
    EB(callee, EXPR_NODE_FLAGS) &= 0xFE;
    u16 reference = RESOLVE_SYMBOL_REFERENCE(callee, 0);
    E(expression, EXPR_LEFT) = reference;
    return expression;
}

/* *(entry *)(expression->vptr + index), the virtual table entry number index of class
   type, where expression points to the object and vptr is the hidden member found by
   BCC_MEMBER_LOOKUP; the entry type is far for a huge class (class flag 100h), else
   near */
u16 VIRTUAL_TABLE_ENTRY(u16 index, u16 type, u16 expression)
{
    u16 member = BCC_MEMBER_LOOKUP(type);
    u16 result = MAKE_BINARY_NODE(0x30, expression, MAKE_FIELD_REF_NODE(member));
    u16 entry = (CLASS_FLAGS(type) & 0x100) ? FAR_VTABLE_ENTRY_PTR_TYPE : VTABLE_ENTRY_PTR_TYPE;
    result = MAKE_CAST_NODE(entry, MAKE_BINARY_NODE(0x16, result, index));
    result = MAKE_UNARY_NODE(0x18, result);
    return ANALYZE_EXPRESSION(result, 0, 0);
}

/* if the callee of call node expression is a virtual function (SYM_VIRTUAL_INDEX > 0) and
   the call is not qualified, rewrites it as an indirect call: the object's address is
   saved in a temporary (returned through *type), the callee becomes the function part of
   the table entry at index - 1 (SYM_VIRTUAL_INDEX is the entry's byte offset plus 1; near
   or far member by the function's model) and the first argument becomes *temporary.  A
   dynamically dispatched function (flag 100h) cannot be called this way */
void LOWER_VIRTUAL_CALL(u16 expression, farptr type)
{
    u16 callee = E(expression, EXPR_LEFT);
    u16 index = 0;
    if (!E(callee, EXPR_SCOPE_CLASS) && KIND(SYM_W(E(callee, EXPR_LEFT), SYM_TYPE)) == TK_FUNCTION) {
        if (SYM_W(E(callee, EXPR_LEFT), SYM_FUNC_FLAGS) & 0x100)
            REPORT_DIAGNOSTIC(MSG_CANNOT_CALL, (i32)FORMAT_SYMBOL(E(callee, EXPR_LEFT)), 0);
        else
            index = SYM_W(E(callee, EXPR_LEFT), SYM_VIRTUAL_INDEX);
    }
    if (index == 0)
        return;
    /* the original frame from BP-0Eh: temporary at 4 */
    u16 mark = scratch_mark();
    farptr temporary = fp_add(scratch_alloc(0x0E), 4);
    u8 far_model;
    u16 pointer_type = E(callee, EXPR_TYPE);
    if (!(KIND_FLAGS(pointer_type) & 0x14)) {
        far_model = (TYPE_B(pointer_type, TYPE_FUNC_FLAGS) & 1) != 0;
        pointer_type = MAKE_POINTER_TYPE(pointer_type, 0, 0);
    } else
        far_model = KIND(pointer_type) == TK_FAR_PTR;
    u16 value = ANALYZE_EXPRESSION(E(E(expression, EXPR_RIGHT), EXPR_RIGHT), 0, 0);
    value = CONVERT_TO_RVALUE(value);
    E(E(expression, EXPR_RIGHT), EXPR_RIGHT) = value;
    u16 context = E(E(E(expression, EXPR_RIGHT), EXPR_RIGHT), EXPR_TYPE);
    FREE_EXPR_NODE(callee);
    W(temporary) = MAKE_ADDRESS_OF(E(E(expression, EXPR_RIGHT), EXPR_RIGHT));
    SAVE_EXPR_IN_TEMP(temporary, type);
    W(temporary) = ANALYZE_EXPRESSION(W(temporary), 0, 0);
    u16 slot = MAKE_INT_CONSTANT(INT_TYPE, (i32)(u16)(index - 1));   /* pascal: left to right */
    u16 result = VIRTUAL_TABLE_ENTRY(slot, context, COPY_EXPR_TREE(W(temporary)));
    u16 member_expression = MAKE_BINARY_NODE(0x2F, result, MAKE_FIELD_REF_NODE(far_model ? VTABLE_FAR_FUNC_MEMBER : VTABLE_NEAR_FUNC_MEMBER));
    member_expression = MAKE_UNARY_NODE(0x18, MAKE_CAST_NODE(pointer_type, member_expression));
    value = ANALYZE_EXPRESSION(W(temporary), 0, 0);
    value = MAKE_DEREFERENCE(value);
    E(E(expression, EXPR_RIGHT), EXPR_RIGHT) = value;
    value = ANALYZE_EXPRESSION(member_expression, pointer_type, 0);
    value = DECAY_TO_POINTER(value);
    E(expression, EXPR_LEFT) = value;
    scratch_release(mark);
}

/* calling member function symbol on a const object expression: unless the function is
   const (or a constructor or destructor) a warning; the object's type then loses its cv
   qualifiers so the call can go on */
void CHECK_CONST_THIS(u16 symbol, u16 expression)
{
    if ((TYPE_B(E(expression, EXPR_TYPE), TYPE_ATTRS) & 1) && !(TYPE_B(SYM_W(symbol, SYM_TYPE), TYPE_ATTRS) & 1)) {
        if (SYM_W(symbol, SYM_FUNC_KIND) != 3 && SYM_W(symbol, SYM_FUNC_KIND) != 4)
            REPORT_DIAGNOSTIC_AT(MSG_NON_CONST_FUNCTION, (i32)FORMAT_SYMBOL(symbol), 0, E(expression, EXPR_SRC_LINE), E(expression, EXPR_SRC_WORD3));
        u16 stripped = STRIP_CV_QUALIFIERS(E(expression, EXPR_TYPE));
        E(expression, EXPR_TYPE) = stripped;
    }
}

/* the operator function name for operator node op */
static u16 operator_name(u16 op)
{
    return TOKEN_NAMES_AT(C18_OPERATOR_TOKENS_AT(op));
}

/* *output is a unary operator node (node flag 20h set by MAKE_UNARY_NODE) whose operand is
   a class object.  Looks for operatorX both as a member of the class and as a global
   function and lets SELECT_OVERLOAD choose.  On success replaces *output with the checked
   call and returns 1; 0 lets the caller apply the built-in operator */
u8 TRY_UNARY_OPERATOR_CALL(farptr output, u16 operation, u16 context)
{
    u16 original = W(output);
    u16 type = E(E(original, EXPR_LEFT), EXPR_TYPE);
    if (!(EB(original, EXPR_NODE_FLAGS) & 0x20) || !(KIND_FLAGS(type) & 0x40))
        return 0;
    /* the original frame from BP-0Eh: flag at 7 */
    u16 mark = scratch_mark();
    farptr flag = fp_add(scratch_alloc(0x0E), 7);
    u16 value = CHECK_NULL_CONSTANT(E(original, EXPR_LEFT), flag);
    E(original, EXPR_LEFT) = value;
    scratch_release(mark);
    u16 wrapper = MAKE_LIST_NODE(E(original, EXPR_LEFT), 0);
    EB(wrapper, EXPR_NODE_FLAGS) |= MEMBER_ARGUMENT;
    copy_location(wrapper, original);
    u16 name = operator_name(E(original, EXPR_OP));
    u16 member = type == 0 ? 0 : FIND_MEMBER_REPORT(name, type);
    u16 candidate = member == 0 ? 0 : MEMBER_W(member, MEMB_VALUE);
    u16 result = MAKE_BINARY_NODE(1, 0, wrapper);
    copy_location(result, original);
    u16 symbol = SELECT_OVERLOAD(result, LOOKUP_NAME(name), candidate, operation);
    if (!symbol) {
        FREE_EXPR_NODE(wrapper);
        FREE_EXPR_NODE(result);
        return 0;
    }
    value = RESOLVE_SYMBOL_REFERENCE(MAKE_SYMBOL_NODE(symbol), 0);
    E(result, EXPR_LEFT) = value;
    copy_location(E(result, EXPR_LEFT), original);
    if (SYM_B(symbol, SYM_FLAGS) & 0x10)
        CHECK_CONST_THIS(symbol, E(wrapper, EXPR_RIGHT));
    result = ADJUST_THIS_ARGUMENT(result, type);
    FREE_EXPR_NODE(original);
    value = CHECK_CALL_ARGUMENTS(result, context);
    W(output) = value;
    return 1;
}

/* the same for a binary operator where either operand is a class object.  Operator 47h is
   initialization (T x = y) and gets a constructor call; for a class with virtual bases the
   hidden 0 argument is then inserted after the object.  On failure all the list nodes
   built are freed */
u8 TRY_BINARY_OPERATOR_CALL(farptr output, u16 operation, u16 context)
{
    u16 original = W(output);
    u16 type = E(E(original, EXPR_LEFT), EXPR_TYPE);
    if (!(EB(original, EXPR_NODE_FLAGS) & 0x20)
        || (!(KIND_FLAGS(type) & 0x40) && !(KIND_FLAGS(E(E(original, EXPR_RIGHT), EXPR_TYPE)) & 0x40)))
        return 0;
    /* the original frame from BP-10h: flag at 0Bh */
    u16 mark = scratch_mark();
    farptr flag = fp_add(scratch_alloc(0x10), 0x0B);
    u16 value = CHECK_NULL_CONSTANT(E(original, EXPR_LEFT), flag);
    E(original, EXPR_LEFT) = value;
    value = CHECK_NULL_CONSTANT(E(original, EXPR_RIGHT), flag);
    E(original, EXPR_RIGHT) = value;
    scratch_release(mark);
    u16 arguments = MAKE_LIST_NODE(E(original, EXPR_RIGHT), 0);
    u8 assignment = 0;
    if (E(original, EXPR_OP) == 0x47 && (KIND_FLAGS(type) & 0x40))
        assignment = (CLASS_FLAGS(type) & 4) != 0;
    if (!(KIND_FLAGS(type) & 0x40))
        type = 0;
    if (assignment)
        arguments = MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE, 0), arguments);
    arguments = MAKE_LIST_NODE(E(original, EXPR_LEFT), arguments);
    EB(arguments, EXPR_NODE_FLAGS) |= MEMBER_ARGUMENT;
    u16 name = operator_name(E(original, EXPR_OP));
    u16 member = type == 0 ? 0 : FIND_MEMBER_REPORT(name, type);
    u16 candidate = member == 0 ? 0 : MEMBER_W(member, MEMB_VALUE);
    u16 result = MAKE_BINARY_NODE(1, 0, arguments);
    copy_location(result, original);
    u16 symbol = SELECT_OVERLOAD(result, LOOKUP_NAME(name), candidate, operation);
    if (!symbol) {
        if (assignment)
            FREE_EXPR_NODE(E(E(arguments, EXPR_LEFT), EXPR_RIGHT));
        while (arguments) {
            u16 previous = arguments;
            arguments = E(arguments, EXPR_LEFT);
            FREE_EXPR_NODE(previous);
        }
        FREE_EXPR_NODE(result);
        return 0;
    }
    value = RESOLVE_SYMBOL_REFERENCE(MAKE_SYMBOL_NODE(symbol), 0);
    E(result, EXPR_LEFT) = value;
    copy_location(E(result, EXPR_LEFT), original);
    if (SYM_B(symbol, SYM_FLAGS) & 0x10)
        CHECK_CONST_THIS(symbol, E(arguments, EXPR_RIGHT));
    result = ADJUST_THIS_ARGUMENT(result, type);
    FREE_EXPR_NODE(original);
    value = CHECK_CALL_ARGUMENTS(result, context);
    W(output) = value;
    return 1;
}

/* a '.' node selecting member field of a copy of the member pointer at left */
static u16 member_of_copy(farptr left, u16 field)
{
    u16 copy = COPY_EXPR_TREE(W(left));
    return MAKE_BINARY_NODE(0x2F, copy, MAKE_FIELD_REF_NODE(field));
}

/* (object.*pmf)(args).  *left is the member pointer value, *right the object, *sequence
   collects side effects to run first.  The member pointer is kept in a temporary; with
   p = (char *)&object + pmf.delta the function is
   pmf.vindex ? (*(vtable **)(p + pmf.offset))[pmf.vindex - 1] : pmf.func
   (near or far parts by the function's model and by class flag 100h, huge class), and
   the object becomes *(class *)p */
void LOWER_MEMBER_POINTER_CALL(farptr left, farptr right, farptr sequence)
{
    /* the original frame from BP-0Eh: saved at 0Ah */
    u16 mark = scratch_mark();
    farptr saved = fp_add(scratch_alloc(0x0E), 0x0A);
    u16 original_type = E(W(left), EXPR_TYPE);
    u8 far_model = (TYPE_B(TYPE_W(original_type, TYPE_TARGET), TYPE_FUNC_FLAGS) & 1) != 0;
    u8 wide = (CLASS_FLAGS(E(W(right), EXPR_TYPE)) & 0x100) != 0;
    E(W(left), EXPR_TYPE) = MEMBER_PTR_CLASS_TYPE;
    EB(W(left), EXPR_NODE_FLAGS) |= 1;
    SAVE_EXPR_IN_TEMP(left, saved);
    u16 value = JOIN_COMMA_EXPR(W(sequence), W(saved));
    value = ANALYZE_EXPRESSION(value, 0, 0);
    W(sequence) = value;
    u16 left_pointer = MAKE_CAST_NODE(CHAR_POINTER_TYPE, MAKE_UNARY_NODE(0x1D, W(right)));
    u16 work = member_of_copy(left, MEMBER_PTR_DELTA_MEMBER);
    left_pointer = MAKE_BINARY_NODE(0x16, left_pointer, work);
    u16 offset = member_of_copy(left, MEMBER_PTR_VINDEX_MEMBER);
    work = member_of_copy(left, MEMBER_PTR_OFFSET_MEMBER);
    u16 right_pointer = MAKE_BINARY_NODE(0x16, COPY_EXPR_TREE(left_pointer), work);
    right_pointer = MAKE_CAST_NODE(MAKE_POINTER_TYPE(wide ? FAR_CHAR_POINTER_TYPE : TYPE_LOCAL, 0, 0), right_pointer);
    u16 address = MAKE_UNARY_NODE(0x18, right_pointer);
    u16 copy = COPY_EXPR_TREE(offset);
    work = MAKE_BINARY_NODE(0x17, copy, MAKE_INT_CONSTANT(INT_TYPE, 1));
    address = MAKE_BINARY_NODE(0x16, address, work);
    address = MAKE_CAST_NODE(MAKE_POINTER_TYPE(far_model ? INT_FAR_FUNC_PTR_TYPE : INT_NEAR_FUNC_PTR_TYPE, wide ? TK_FAR_PTR : TK_NEAR_PTR, 0), address);
    address = MAKE_UNARY_NODE(0x18, address);
    u16 dispatch = MAKE_BINARY_NODE(0x2F, W(left), MAKE_FIELD_REF_NODE(far_model ? MEMBER_PTR_FAR_FUNC_MEMBER : MEMBER_PTR_NEAR_FUNC_MEMBER));
    u16 pointer = MAKE_POINTER_TYPE(TYPE_W(original_type, TYPE_TARGET), 0, 0);
    value = MAKE_CAST_NODE(pointer, MAKE_CONDITIONAL_NODE(0x20, offset, address, dispatch));
    W(left) = value;
    value = ANALYZE_EXPRESSION(W(left), 0, 0);
    W(left) = value;
    work = MAKE_CAST_NODE(MAKE_POINTER_TYPE(E(W(right), EXPR_TYPE), 0, 0), left_pointer);
    work = MAKE_UNARY_NODE(0x18, work);
    value = ANALYZE_EXPRESSION(work, 0, 0);
    W(right) = value;
    scratch_release(mark);
}

/* the callee of call node expression is object.f or object.*pmf.  Makes f the callee and
   puts the object in front of the argument list (flag 40h).  When the object is a variable
   of exactly the function's class, the callee is marked qualified (EXPR_SCOPE_CLASS), so
   the call is not made virtual.  An explicit destructor call with no arguments gets the
   flags argument 2.  *type gets the object's type, *sequence any side effects to evaluate
   first */
void REWRITE_MEMBER_CALL(u16 expression, farptr sequence, farptr type)
{
    /* the original frame from BP-6: target at 2, callee at 4 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);
    farptr target = fp_add(v, 2), callee = fp_add(v, 4);
    W(sequence) = 0;
    W(callee) = ANALYZE_EXPRESSION(E(E(expression, EXPR_LEFT), EXPR_LEFT), 0, 0);
    u8 special = E(E(expression, EXPR_LEFT), EXPR_OP) == 0x3C;
    W(target) = E(E(expression, EXPR_LEFT), EXPR_RIGHT);
    if (!special && E(W(target), EXPR_OP) == OP_SYMBOL) {
        if (E(W(callee), EXPR_OP) == OP_SYMBOL && !E(W(target), EXPR_SCOPE_CLASS)
            && SYM_W(E(W(callee), EXPR_LEFT), SYM_TYPE) == SYM_W(SYM_W(E(W(target), EXPR_LEFT), SYM_OWNER_CLASS), SYM_TYPE))
            E(W(target), EXPR_SCOPE_CLASS) = SYM_W(E(W(callee), EXPR_LEFT), SYM_TYPE);
        if (SYM_W(E(W(target), EXPR_LEFT), SYM_FUNC_KIND) == 3 || SYM_W(E(W(target), EXPR_LEFT), SYM_FUNC_KIND) == 4) {
            u16 stripped = STRIP_CV_QUALIFIERS(E(W(callee), EXPR_TYPE));
            E(W(callee), EXPR_TYPE) = stripped;
        }
    }
    W(type) = E(W(callee), EXPR_TYPE);
    FREE_EXPR_NODE(E(expression, EXPR_LEFT));
    if (special)
        LOWER_MEMBER_POINTER_CALL(target, callee, sequence);
    else if (SYM_W(E(W(target), EXPR_LEFT), SYM_FUNC_KIND) == 4 && !E(expression, EXPR_RIGHT)) {
        u16 list = MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE, 2), 0);
        E(expression, EXPR_RIGHT) = list;
    }
    u16 value = ANALYZE_EXPRESSION(W(target), 0, 0);
    E(expression, EXPR_LEFT) = value;
    value = MAKE_LIST_NODE(W(callee), E(expression, EXPR_RIGHT));
    E(expression, EXPR_RIGHT) = value;
    EB(E(expression, EXPR_RIGHT), EXPR_NODE_FLAGS) |= MEMBER_ARGUMENT;
    scratch_release(mark);
}

/* object(args) on a class object: if the class has operator(), the callee becomes
   object.operator() */
u16 FIND_CALL_OPERATOR(u16 expression)
{
    u16 member = FIND_MEMBER_REPORT(TOKEN_NAMES_AT(TOK_LPAREN), E(expression, EXPR_TYPE));
    if (member) {
        expression = ANALYZE_EXPRESSION(MAKE_BINARY_NODE(0x2F, expression, MAKE_FIELD_REF_NODE(member)), 0, 0);
        copy_location(expression, E(expression, EXPR_LEFT));
    }
    return expression;
}

/* first step of analyzing call node expression (see the top).  Reports calls of main and
   of a member function without an object.  *sequence gets side effects that must run
   before the call (from member pointer calls), or 0.  Returns the call node */
u16 PREPARE_CALL(u16 expression, farptr sequence)
{
    /* the original frame from BP-2: type */
    u16 mark = scratch_mark();
    farptr type = scratch_alloc(2);
    W(sequence) = 0;
    W(type) = 0;
    u16 value = DEREF_REFERENCE_EXPR(E(expression, EXPR_LEFT));
    E(expression, EXPR_LEFT) = value;
    if (KIND_FLAGS(E(E(expression, EXPR_LEFT), EXPR_TYPE)) & 0x40) {
        value = FIND_CALL_OPERATOR(E(expression, EXPR_LEFT));
        E(expression, EXPR_LEFT) = value;
    }
    u16 callee = E(expression, EXPR_LEFT);
    if (E(callee, EXPR_OP) == OP_SYMBOL && SYM_W(E(callee, EXPR_LEFT), SYM_NAME) == MAIN_SYMBOL)
        REPORT_CURRENT_TOKEN(MSG_CANNOT_CALL_MAIN_FROM);
    u16 member_type = E(E(callee, EXPR_RIGHT), EXPR_TYPE);
    if ((E(callee, EXPR_OP) == 0x3B || E(callee, EXPR_OP) == 0x3C)
        && (KIND(member_type) == TK_FUNCTION || ((KIND_FLAGS(member_type) & 0x14) && KIND(TYPE_W(member_type, TYPE_TARGET)) == TK_FUNCTION))
        && E(E(callee, EXPR_RIGHT), EXPR_OP) != 0x39)
        REWRITE_MEMBER_CALL(expression, sequence, type);
    else if (KIND(E(callee, EXPR_TYPE)) == TK_FUNCTION && TYPE_W(E(callee, EXPR_TYPE), TYPE_MEMBER_CLASS)) {
        farptr text = E(callee, EXPR_OP) == OP_SYMBOL ? FORMAT_CALL_SIGNATURE(expression, TYPE_W(E(callee, EXPR_TYPE), TYPE_MEMBER_CLASS)) : STR_A_MEMBER_FUNCTION_P;
        scratch_release(mark);
        return REPORT_EXPR_ERROR(MSG_USE_CALL, text, 0, expression);
    }
    expression = RESOLVE_OVERLOADED_CALL(expression, W(type));
    expression = ADJUST_THIS_ARGUMENT(expression, W(type));
    scratch_release(mark);
    return expression;
}

/* a local temporary for type initialized from expression, its destructor registered on
   the current scope; the result is (temporary = expression, &temporary) analyzed as
   type.  destroyed is the type passed for the destructor */
static u16 bind_temporary(u16 temporary, u16 destroyed, u16 expression, u16 type)
{
    u16 node = MAKE_SYMBOL_NODE(temporary);                     /* pascal: left to right */
    u16 temps = REGISTER_TEMP_DESTRUCTOR(node, destroyed, TEMPS_OF(CURRENT_SCOPE));
    TEMPS_OF(CURRENT_SCOPE) = temps;
    expression = MAKE_BINARY_NODE(5, MAKE_SYMBOL_NODE(temporary), expression);
    copy_location(expression, E(expression, EXPR_RIGHT));
    u16 address = MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(temporary));
    return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(expression, address), type, 0);
}

static u16 bad_argument(u16 expression, u16 formal, u16 symbol, i16 position)
{
    REPORT_ARGUMENT_MISMATCH(expression, formal, symbol, position, 0x4D);
    return REPORT_EXPR_ERROR_PLAIN(0, expression);
}

/* converts argument expression for parameter formal of function symbol (position counts
   from 1, for messages): a pointer-to-function parameter and a function name or address
   are used as is; a class with constructors passed by value goes by address (a named
   object, or an lvalue for a const parameter, itself, anything else copied into a local
   temporary); a reference parameter is bound to the object when the types fit, else a
   temporary of the referred type is initialized and bound (a warning when the reference
   is not to const); anything else is an ordinary conversion, with a warning when an enum
   parameter gets another type */
u16 CONVERT_ARGUMENT(u16 expression, u16 formal, u16 symbol, i16 position)
{
    u16 type = FORMAL_W(formal, FORMAL_TYPE);
    u16 saved[3];
    save_location(saved, expression);
    if ((KIND_FLAGS(type) & 0x14) && KIND(TYPE_W(type, TYPE_TARGET)) == TK_FUNCTION
        && (E(expression, EXPR_OP) == OP_SYMBOL || E(expression, EXPR_OP) == 0x32)) {
        EB(expression, EXPR_NODE_FLAGS) &= 0xFE;
        goto converted;
    }
    if ((KIND_FLAGS(type) & 0x40) && (TYPE_B(type, TYPE_ATTRS) & 4)) {
        expression = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression, type, 0));
        restore_location(expression, saved);
        if (TYPE_B(type, TYPE_ATTRS) & 1)
            expression = REWRITE_FOR_REFERENCE_BIND(expression);
        if (TYPES_COMPATIBLE(E(expression, EXPR_TYPE), type, 2)
            && (IS_NAMED_OBJECT_EXPR(expression) || (IS_LVALUE(expression) && (TYPE_B(type, TYPE_ATTRS) & 1))))
            expression = MAKE_ADDRESS_OF(expression);
        else
            expression = bind_temporary(CREATE_LOCAL_TEMP(type), type, expression, type);
        type = MAKE_POINTER_TYPE(type, 0, 0);
        goto converted;
    }
    if ((KIND_FLAGS(type) & 0x14) && (TYPE_B(type, TYPE_ATTRS) & 0x20)) {
        expression = DEREF_REFERENCE_EXPR(ANALYZE_EXPRESSION(expression, type, 0));
        if (FIND_USER_CONVERSION(type, E(expression, EXPR_TYPE), 1, 0, 0))
            expression = CONVERT_EXPR_TO_TYPE(type, expression, 0);
        restore_location(expression, saved);
        expression = REWRITE_FOR_REFERENCE_BIND(expression);
        if (!C7_TYPE_COMPAT(type, E(expression, EXPR_TYPE), 0)) {
            expression = DEREF_REFERENCE_EXPR(expression);
            u8 constant = IS_LVALUE(expression);
            u16 pointer_type = MAKE_POINTER_TYPE(E(expression, EXPR_TYPE), 0, 1);
            if ((constant || IS_NAMED_OBJECT_EXPR(expression)) && !IS_BIT_FIELD_NODE(expression) && C7_TYPE_COMPAT(type, pointer_type, 0)) {
                expression = MAKE_ADDRESS_OF(expression);
                E(expression, EXPR_TYPE) = pointer_type;
                goto converted;
            }
            if (constant && !IS_LINK_TIME_CONSTANT(expression) && !(TYPE_B(TYPE_W(type, TYPE_TARGET), TYPE_ATTRS) & 1)) {
                REPORT_DIAGNOSTIC(MSG_TEMPORARY_USED, FORMAT_TYPE(type), 0);
                u16 stripped = STRIP_CV_QUALIFIERS(E(expression, EXPR_TYPE));
                E(expression, EXPR_TYPE) = stripped;
            }
            if (CANNOT_CONVERT_TYPES(TYPE_W(type, TYPE_TARGET), E(expression, EXPR_TYPE))
                || (KIND(E(expression, EXPR_TYPE)) == TK_ARRAY && KIND(TYPE_W(type, TYPE_TARGET)) == TK_ARRAY && !C7_TYPE_COMPAT(type, pointer_type, 0)))
                return bad_argument(expression, formal, symbol, position);
            u16 temporary;
            if (IS_BASE_CLASS(TYPE_W(type, TYPE_TARGET), E(expression, EXPR_TYPE), 1)) {
                temporary = CREATE_LOCAL_TEMP(E(expression, EXPR_TYPE));
                u16 stripped = STRIP_CV_QUALIFIERS(E(expression, EXPR_TYPE));
                E(expression, EXPR_TYPE) = stripped;
            } else
                temporary = CREATE_LOCAL_TEMP(TYPE_W(type, TYPE_TARGET));
            expression = bind_temporary(temporary, SYM_W(temporary, SYM_TYPE), expression, type);
            E(expression, EXPR_TYPE) = type;
        }
    }
converted:
    if (!((KIND_FLAGS(type) & 0x14) && (TYPE_B(type, TYPE_ATTRS) & 0x20))) {
        expression = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression, type, 0));
        restore_location(expression, saved);
    }
    if (KIND(E(expression, EXPR_TYPE)) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, expression);
    expression = NULL_CONSTANT_TO_POINTER(type, expression);
    if (!((KIND_FLAGS(type) & 0x40) || (KIND_FLAGS(E(expression, EXPR_TYPE)) & 0x40) || C7_TYPE_COMPAT(type, E(expression, EXPR_TYPE), 0)))
        return bad_argument(expression, formal, symbol, position);
    if (KIND(type) == TK_ENUM && !TYPES_COMPATIBLE(type, E(expression, EXPR_TYPE), 1)) {
        i32 from = FORMAT_TYPE(E(expression, EXPR_TYPE));          /* pascal: left to right */
        REPORT_DIAGNOSTIC_AT(MSG_ASSIGNING, from, FORMAT_TYPE(type), E(expression, EXPR_SRC_LINE), 0);
    }
    return CONVERT_EXPR_TO_TYPE(type, NODE_ENUM_TO_INT(expression), 0);
}

/* a list node holding a fresh copy of formal's default argument, or 0 when it has none */
u16 DEFAULT_ARGUMENT(u16 formal)
{
    if (formal && FORMAL_W(formal, FORMAL_DEFAULT_ARG))
        return MAKE_LIST_NODE(UNPACK_EXPR_TREE(FORMAL_W(formal, FORMAL_DEFAULT_ARG)), 0);
    return 0;
}
