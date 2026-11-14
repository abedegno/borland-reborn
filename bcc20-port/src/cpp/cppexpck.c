/* cppexpck.c: from bcc20/src/cpp/CPPEXPCK.C: C++ checks of expression analysis, called by
   the C checks in expr/ when a class, reference or pointer to member is involved.
   - CHECK_CPP_ASSIGNMENT, CHECK_CPP_INITIALIZATION (operator 47h, T x = y) and
     CHECK_CPP_RETURN_VALUE convert the right side to the target type: derived to base,
     conversion functions, constructors, reference binding (to the object itself or to a
     temporary), and run temporaries' destructors after a return value is computed.
   - ANALYZE_MEMBER_SELECT resolves the member name of a '.' node in the object's class and
     its bases, with access checks; ANALYZE_DOT_STAR handles .* with a pointer to member.
   - COMPARE_MEMBER_POINTERS compares pointers to members field by field.
   - ANALYZE_NEW_EXPRESSION and ANALYZE_DELETE_EXPRESSION expand new and delete into calls
     of operator new/delete, constructors, destructors and the run-time vector helpers.
   Expression operators met here: 1 symbol, 36h call, 47h initialization, 48h
   pointer-to-member constant, 4Ah member node.  Token codes used to build nodes: 5
   initialization, 0Bh '=', 17h '-', 18h '*', 1Dh '&', 23h '&&', 24h '==', 2Ah '!', 2Fh
   '.'; MAKE_CONDITIONAL_NODE(6Bh, c, a, b) is c ? a : b.  A pointer to data member is the
   member offset plus 1 (0 is the null pointer); a pointer to member function is the struct
   MEMBER_PTR_CLASS_TYPE (delta, vindex, offset, pad).  A node handed to ELIDE_COPY_ASSIGN,
   TRY_BINARY_OPERATOR_CALL or SAVE_EXPR_IN_TEMP by address lives in the scratch area in
   the original's frame layout. */
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
#define CLASS_FLAGS(type) TAG_W(TYPE_W((type), TYPE_TAG_BODY), TAG_CLASS_FLAGS)
#define TEMPS_OF(scope) W(MK_FP(SCOPE_POOL_SEG, (scope) + SCOPE_TEMPS))
#define LOCATION_WORDS(n) E((n), EXPR_SRC_WORD3), E((n), EXPR_SRC_LINE), E((n), EXPR_SRC_FILE)

static void copy_location(u16 to, u16 from)
{
    for (int i = 0; i < 6; i += 2)
        E(to, EXPR_SRC_FILE + i) = E(from, EXPR_SRC_FILE + i);
}

/* *&value converted from derived class from to base class to */
static u16 to_base(u16 value, u16 from, u16 to)
{
    u16 temporary = MAKE_ADDRESS_OF(value);
    temporary = CONVERT_DERIVED_TO_BASE(temporary, from, 0, to, 0, 0);
    return MAKE_DEREFERENCE(ANALYZE_EXPRESSION(temporary, 0, 0));
}

/* an error naming two types; pascal: the first is formatted first */
static u16 error_types(u16 message, u16 first, u16 second, u16 node)
{
    i32 a = FORMAT_TYPE(first);
    return REPORT_EXPR_ERROR(message, (farptr)a, FORMAT_TYPE(second), node);
}

static void warning_types(i16 message, u16 first, u16 second, u16 line, u16 word3)
{
    i32 a = FORMAT_TYPE(first);
    REPORT_DIAGNOSTIC_AT(message, a, FORMAT_TYPE(second), line, word3);
}

/* ELIDE_COPY_ASSIGN on *node, the node passed by address from the original's frame
   (frame bytes below BP, the parameter at offset place from the frame's start) */
static u8 elide(u16 *node, u16 frame, u16 place)
{
    u16 mark = scratch_mark();
    farptr slot = fp_add(scratch_alloc(frame), place);
    W(slot) = *node;
    u8 result = ELIDE_COPY_ASSIGN(slot);
    *node = W(slot);
    scratch_release(mark);
    return result;
}

/* finishes assignment node (EXPR_TYPE the left side's type): converts a derived class
   object on the right to the base on the left, applies a conversion function when a
   scalar is assigned from a class (mask 7), checks compatibility and warns when an enum
   gets another type.  The right side is converted to the left's type (passing the left
   side as target unless the class has a destructor or operator=), and ELIDE_COPY_ASSIGN
   may rewrite the whole node.  In an old-style constructor that assigns to this, an
   assignment to this is noted and the saved member initializations are run after it if
   this is not 0: (this = e, this ? init : 0, this) */
u16 CHECK_CPP_ASSIGNMENT(u16 node)
{
    u16 type = E(node, EXPR_TYPE);
    u16 rtype = E(E(node, EXPR_RIGHT), EXPR_TYPE);
    u16 value;
    if (IS_BASE_CLASS(type, rtype, 1) && !TYPES_COMPATIBLE(type, rtype, 1)) {
        value = to_base(E(node, EXPR_RIGHT), rtype, type);
        E(node, EXPR_RIGHT) = value;
    }
    if ((KIND_FLAGS(type) & 7) && (KIND_FLAGS(rtype) & 0x40)) {
        value = APPLY_CONVERSION_FUNCTION(E(node, EXPR_RIGHT), 7, type);
        E(node, EXPR_RIGHT) = value;
        rtype = E(E(node, EXPR_RIGHT), EXPR_TYPE);
    }
    if (!(KIND_FLAGS(type) & 0x40) && !C7_TYPE_COMPAT(type, rtype, 0))
        return error_types(MSG_CANNOT_ASSIGN, rtype, type, node);
    if (KIND(type) == TK_ENUM && !TYPES_COMPATIBLE(type, rtype, 1))
        warning_types(MSG_ASSIGNING, rtype, type, E(node, EXPR_SRC_LINE), E(node, EXPR_SRC_WORD3));
    u16 target = E(node, EXPR_LEFT);
    if ((TYPE_B(type, TYPE_ATTRS) & 8) || (TYPE_B(type, TYPE_ATTRS) & 0x10))
        target = 0;
    value = CONVERT_EXPR_TO_TYPE(type, E(node, EXPR_RIGHT), target);
    E(node, EXPR_RIGHT) = value;
    /* the original frame from BP-4 to the parameter node at BP+6 */
    if (elide(&node, 0x0C, 0x0A))
        return node;
    u16 left = E(node, EXPR_LEFT);
    if (CTOR_CHECK_THIS_ASSIGN && E(left, EXPR_OP) == 1 && E(left, EXPR_LEFT) == CTOR_THIS_SYMBOL) {
        if (!(EXPR_B(node, EXPR_NODE_FLAGS) & 0x10))
            REPORT_DIAGNOSTIC_AT(MSG_ASSIGNMENT_THIS, 0, 0, E(left, EXPR_SRC_LINE), 0);
        CTOR_THIS_ASSIGNED = 1;
        if (PACKED_INIT_EXPR) {
            u16 init = UNPACK_EXPR_TREE(PACKED_INIT_EXPR);
            if (init) {
                u16 test = BUILD_THIS_NODE(CTOR_THIS_SYMBOL);          /* pascal: left to right */
                init = MAKE_CONDITIONAL_NODE(0x6B, test, init, MAKE_INT_CONSTANT(INT_TYPE, 0));
            }
            node = JOIN_COMMA_EXPR(node, init);
            node = JOIN_COMMA_EXPR(node, MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL));
            CTOR_CHECK_THIS_ASSIGN = 0;
            node = ANALYZE_EXPRESSION(node, 0, 0);
            CTOR_CHECK_THIS_ASSIGN = 1;
        }
    }
    return node;
}

/* the member name of the '.' node on the left of node, for messages */
static farptr member_name(u16 node)
{
    return NAME_TEXT_COPY(E(E(E(node, EXPR_LEFT), EXPR_RIGHT), EXPR_MEMBER_NAME));
}

/* TRY_BINARY_OPERATOR_CALL on *node from CHECK_CPP_INITIALIZATION's frame (BP-6 to the
   parameter node at BP+6) */
static u8 try_constructor(u16 *node)
{
    u16 mark = scratch_mark();
    farptr slot = fp_add(scratch_alloc(0x0E), 0x0C);
    W(slot) = *node;
    u8 result = TRY_BINARY_OPERATOR_CALL(slot, 0, 0);
    *node = W(slot);
    scratch_release(mark);
    return result;
}

/* finishes initialization node (operator 47h; EXPR_LEFT the object, EXPR_RIGHT the value,
   EXPR_TYPE the object's type).  A reference is bound: a compatible pointer value by plain
   assignment; an lvalue (not a bit field) of the referred type or a class derived from it
   by its address; a reference member may not be bound to a parameter nor to a temporary;
   otherwise a local temporary initialized from the value is made and bound, with a
   warning for a reference to non-const.  When FIND_USER_CONVERSION picks a constructor,
   the node becomes a constructor call through TRY_BINARY_OPERATOR_CALL, except when the
   value is a call result (op 36h) of the same class or a derived one and the class has a
   copy constructor: that value is copied like an assignment instead.  Otherwise the node
   is checked like an assignment and ELIDE_COPY_ASSIGN may simplify it */
u16 CHECK_CPP_INITIALIZATION(u16 node)
{
    u16 type = E(node, EXPR_TYPE);
    u16 right = E(node, EXPR_RIGHT);
    u16 rtype = E(right, EXPR_TYPE);
    u16 value;
    if (IS_REFERENCE(type)) {
        E(node, EXPR_OP) = EOP_ASSIGN;
        right = APPLY_CONVERSION_FUNCTION(right, 0, type);
        E(node, EXPR_RIGHT) = right;
        rtype = E(right, EXPR_TYPE);
        if (C7_TYPE_COMPAT(type, rtype, 0))
            return node;
        right = REWRITE_FOR_REFERENCE_BIND(right);
        if (KIND(rtype) == TK_ARRAY && TYPE_L(rtype, TYPE_ARRAY_COUNT) == 0 && TYPE_SIZE(TYPE_W(type, TYPE_TARGET)))
            return error_types(MSG_CANNOT_INITIALIZE, type, rtype, node);
        if ((IS_LVALUE(right) || IS_NAMED_OBJECT_EXPR(right)) && !IS_BIT_FIELD_NODE(right)
            && (TYPES_COMPATIBLE(TYPE_W(type, TYPE_TARGET), rtype, 1) || IS_BASE_CLASS(TYPE_W(type, TYPE_TARGET), rtype, 1))) {
            if (E(E(node, EXPR_LEFT), EXPR_OP) == EOP_DOT && E(right, EXPR_OP) == 1 && (SYM_B(E(right, EXPR_LEFT), SYM_STORAGE_CLASS) >> 3) == 6)
                return REPORT_EXPR_ERROR(MSG_REFERENCE_MEMBER, member_name(node), 0, node);
            right = MAKE_REFERENCE(MAKE_ADDRESS_OF(right));
            value = CONVERT_EXPR_TO_TYPE(type, right, E(node, EXPR_LEFT));
            E(node, EXPR_RIGHT) = value;
            return node;
        }
        right = DEREF_REFERENCE_EXPR(right);
        E(node, EXPR_RIGHT) = right;
        if (E(E(node, EXPR_LEFT), EXPR_OP) == EOP_DOT)
            return REPORT_EXPR_ERROR(MSG_REFERENCE_MEMBER_NEEDS, member_name(node), 0, node);
        u16 target = TYPE_W(type, TYPE_TARGET);
        if ((KIND_FLAGS(target) & 0x40) && (CLASS_FLAGS(target) & 0x80))
            return REPORT_EXPR_ERROR(MSG_CANNOT_CREATE_VARIABLE, (farptr)CLASS_NAME_OF_TYPE(target), 0, node);
        if (IS_LVALUE(right) && !(TYPE_B(target, TYPE_ATTRS) & 1)) {
            farptr text = E(E(node, EXPR_LEFT), EXPR_OP) == 1 ? SYMBOL_NAME_TEXT(E(E(node, EXPR_LEFT), EXPR_LEFT)) : STR_REFERENCE_P;
            REPORT_DIAGNOSTIC_AT(MSG_TEMPORARY_USED, (i32)text, 0, E(node, EXPR_SRC_LINE), E(node, EXPR_SRC_WORD3));
        }
        u16 item = CREATE_LOCAL_TEMP(target);
        u16 temp = MAKE_BINARY_NODE(5, E(node, EXPR_LEFT), MAKE_SYMBOL_NODE(item));
        copy_location(temp, E(node, EXPR_LEFT));
        value = MAKE_SYMBOL_NODE(item);
        E(node, EXPR_LEFT) = value;
        EXPR_B(node, EXPR_NODE_FLAGS) &= 0xFE;
        E(node, EXPR_OP) = 0x47;
        return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(node, temp), 0, 0);
    }
    right = DEREF_REFERENCE_EXPR(right);
    E(node, EXPR_RIGHT) = right;
    rtype = E(right, EXPR_TYPE);
    if (KIND(E(node, EXPR_TYPE)) == TK_ENUM && !TYPES_COMPATIBLE(type, rtype, 1))
        warning_types(MSG_INITIALIZING, type, rtype, E(node, EXPR_SRC_LINE), 0);
    u16 item = FIND_USER_CONVERSION(type, rtype, 1, E(node, EXPR_SRC_LINE), E(node, EXPR_SRC_WORD3));
    if (item && SYM_W(item, SYM_FUNC_KIND) == 3
        && ((E(E(node, EXPR_RIGHT), EXPR_OP) != 0x36
             && (!FIND_COPY_CTOR(type, 0) || IS_LVALUE(E(node, EXPR_RIGHT)) || IS_NAMED_OBJECT_EXPR(E(node, EXPR_RIGHT))))
            || (TYPES_COMPATIBLE(type, rtype, 2) == 0 && IS_BASE_CLASS(type, rtype, 1) == 0))
        && try_constructor(&node))
        return node;
    if (IS_BASE_CLASS(type, rtype, 1)) {
        value = to_base(E(node, EXPR_RIGHT), rtype, type);
        E(node, EXPR_RIGHT) = value;
    }
    E(node, EXPR_OP) = EOP_ASSIGN;
    if ((KIND_FLAGS(E(node, EXPR_TYPE)) & 7) && (KIND_FLAGS(E(E(node, EXPR_RIGHT), EXPR_TYPE)) & 0x40)) {
        value = APPLY_CONVERSION_FUNCTION(E(node, EXPR_RIGHT), 7, type);
        E(node, EXPR_RIGHT) = value;
        rtype = E(E(node, EXPR_RIGHT), EXPR_TYPE);
    }
    if (KIND(type) == TK_FUNCTION || (!(KIND_FLAGS(type) & 0x40) && !C7_TYPE_COMPAT(type, rtype, 0)))
        return error_types(MSG_CANNOT_INITIALIZE, type, rtype, node);
    value = CONVERT_EXPR_TO_TYPE(type, NODE_ENUM_TO_INT(E(node, EXPR_RIGHT)), E(node, EXPR_LEFT));
    E(node, EXPR_RIGHT) = value;
    elide(&node, 0x0E, 0x0C);
    return node;
}

/* finishes the return of a value: node is an assignment-like node whose EXPR_TYPE is the
   function's return type, EXPR_LEFT the place for a class result (0 when none) and
   EXPR_RIGHT the value; scope is the temporary-destructor list position at the function's
   start, so BUILD_TEMP_DESTRUCTORS adds the destructor calls of everything newer.  A
   reference result must be an lvalue that is not a local or a named object.  A class
   result is built with ELIDE_COPY_ASSIGN, a conversion function, or a constructor call on
   the result place.  When destructors must run after a scalar value is computed, the value
   is first saved in a temporary: (tmp = value, destructors, tmp) */
u16 CHECK_CPP_RETURN_VALUE(u16 node, u16 scope)
{
    u16 type = E(node, EXPR_TYPE);
    u16 right = E(node, EXPR_RIGHT);
    u16 rtype = E(right, EXPR_TYPE);
    u16 value;
    /* ELIDE_COPY_ASSIGN gets node from the original frame: BP-0Ch to the parameter at BP+8 */
    if (IS_REFERENCE(type)) {
        right = APPLY_CONVERSION_FUNCTION(right, 0, type);
        E(node, EXPR_RIGHT) = right;
        rtype = E(right, EXPR_TYPE);
    }
    if (IS_REFERENCE(type) && !C7_TYPE_COMPAT(type, rtype, 0)) {
        right = REWRITE_FOR_REFERENCE_BIND(DEREF_REFERENCE_EXPR(right));
        if (!IS_LVALUE(right))
            return REPORT_EXPR_ERROR_PLAIN(MSG_VARIABLE_NAME_EXPECTED, node);
        u16 temp = right;
        while (E(temp, EXPR_OP) == EOP_COMMA)
            temp = E(temp, EXPR_RIGHT);
        if (IS_NAMED_OBJECT_EXPR(right))
            return REPORT_EXPR_ERROR_PLAIN(MSG_ATTEMPTING_RETURN_301, node);
        if (E(temp, EXPR_OP) == 1 && (SYM_B(E(temp, EXPR_LEFT), SYM_STORAGE_CLASS) >> 3) == 5)
            return REPORT_EXPR_ERROR(MSG_ATTEMPTING_RETURN, SYMBOL_NAME_TEXT(E(temp, EXPR_LEFT)), 0, node);
        if (TYPES_COMPATIBLE(TYPE_W(type, TYPE_TARGET), rtype, 1)
            || ((KIND_FLAGS(rtype) & 0x14) && C7_TYPE_COMPAT(TYPE_W(type, TYPE_TARGET), rtype, 0))
            || IS_BASE_CLASS(TYPE_W(type, TYPE_TARGET), rtype, 1)) {
            value = CONVERT_EXPR_TO_TYPE(type, MAKE_REFERENCE(MAKE_ADDRESS_OF(right)), 0);
            E(node, EXPR_RIGHT) = value;
        } else
            return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_TYPE_DOES, node);
    } else {
        if (!IS_REFERENCE(type)) {
            right = CONVERT_TO_RVALUE(E(node, EXPR_RIGHT));
            E(node, EXPR_RIGHT) = right;
            rtype = E(right, EXPR_TYPE);
        }
        if (KIND(type) == TK_ENUM && !TYPES_COMPATIBLE(rtype, type, 1))
            warning_types(MSG_INITIALIZING, type, rtype, E(node, EXPR_SRC_LINE), 0);
        if ((KIND_FLAGS(type) & 0x40) || (KIND_FLAGS(rtype) & 0x40)) {
            if ((KIND_FLAGS(type) & 7) && (KIND_FLAGS(rtype) & 0x40))
                right = APPLY_CONVERSION_FUNCTION(right, 7, type);
            else {
                if (elide(&node, 0x16, 0x14)) {
                    node = JOIN_COMMA_EXPR(node, BUILD_TEMP_DESTRUCTORS(TEMPS_OF(CURRENT_SCOPE), scope));
                    return ANALYZE_EXPRESSION(node, 0, 0);
                }
                u16 item = FIND_USER_CONVERSION(type, rtype, 1, E(node, EXPR_SRC_LINE), E(node, EXPR_SRC_WORD3));
                if (item && SYM_W(item, SYM_FUNC_KIND) != 3)
                    right = CONVERT_EXPR_TO_TYPE(type, right, E(node, EXPR_LEFT));
                else if ((KIND_FLAGS(type) & 0x40) && (TYPE_B(type, TYPE_ATTRS) & 4)) {
                    u16 place = E(node, EXPR_LEFT);                   /* pascal: left to right */
                    u16 temp = BUILD_CONSTRUCTOR_CALL(place, type, MAKE_LIST_NODE(right, 0));
                    FREE_EXPR_NODE(node);
                    temp = JOIN_COMMA_EXPR(temp, BUILD_TEMP_DESTRUCTORS(TEMPS_OF(CURRENT_SCOPE), scope));
                    return ANALYZE_EXPRESSION(temp, 0, 0);
                }
            }
        }
        if (KIND(type) != TK_VOID && !C7_TYPE_COMPAT(type, E(right, EXPR_TYPE), 0))
            return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_TYPE_DOES, node);
        value = CONVERT_EXPR_TO_TYPE(type, right, E(node, EXPR_LEFT));
        E(node, EXPR_RIGHT) = value;
    }
    E(node, EXPR_OP) = EOP_ASSIGN;
    if (E(node, EXPR_LEFT) == 0) {
        u16 temp = node;
        node = E(node, EXPR_RIGHT);
        FREE_EXPR_NODE(temp);
    } else
        elide(&node, 0x16, 0x14);
    u16 extra = BUILD_TEMP_DESTRUCTORS(TEMPS_OF(CURRENT_SCOPE), scope);
    if (extra) {
        if (!(KIND_FLAGS(type) & 0x40) && E(node, EXPR_OP) != EOP_ASSIGN) {
            u16 info = CREATE_LOCAL_TEMP(E(node, EXPR_TYPE));
            u16 added = MAKE_BINARY_NODE(5, MAKE_SYMBOL_NODE(info), node);
            added = JOIN_COMMA_EXPR(added, extra);
            node = JOIN_COMMA_EXPR(added, MAKE_SYMBOL_NODE(info));
        } else
            node = JOIN_COMMA_EXPR(node, extra);
        node = ANALYZE_EXPRESSION(node, type, 0);
    }
    return node;
}

/* object.operator T: the member name node (name kind 2) names a conversion function.
   Finds it with FIND_USER_CONVERSION from the class (EXPR_SCOPE_CLASS of the name node) to
   T (EXPR_RIGHT of the name node, else the left side's type) and puts a symbol node for it
   on the right of node; an error when there is none */
u16 RESOLVE_CONVERSION_MEMBER(u16 node)
{
    u16 right = E(node, EXPR_RIGHT);
    u16 type = E(right, EXPR_RIGHT) == 0 ? E(E(node, EXPR_LEFT), EXPR_TYPE) : E(right, EXPR_RIGHT);
    u16 item = FIND_USER_CONVERSION(E(right, EXPR_SCOPE_CLASS), type, 1, E(right, EXPR_SRC_LINE), E(right, EXPR_SRC_WORD3));
    if (!item || SYM_W(item, SYM_FUNC_KIND) != 2) {
        u16 pointer = CREATE_TYPE(TK_FUNCTION);
        TYPE_W(pointer, TYPE_TARGET) = E(right, EXPR_SCOPE_CLASS);
        farptr name = FORMAT_MEMBER_NAME(E(right, EXPR_LEFT), E(right, EXPR_NAME_KIND), pointer, type);   /* pascal: left to right */
        return REPORT_EXPR_ERROR(MSG_NOT_MEMBER, name, CLASS_NAME_OF_TYPE(type), node);
    }
    u16 result = MAKE_SYMBOL_NODE(item);
    copy_location(result, right);
    E(result, EXPR_TYPE) = SYM_W(item, SYM_TYPE);
    E(result, EXPR_SCOPE_CLASS) = E(right, EXPR_RIGHT);
    EXPR_B(result, EXPR_NODE_FLAGS) |= 1;
    FREE_EXPR_NODE(right);
    E(node, EXPR_RIGHT) = result;
    return node;
}

/* an error naming a member and a class; pascal: the member is formatted first */
static u16 error_member(u16 message, u16 name, u16 kind, u16 scope, u16 class, u16 node)
{
    farptr text = FORMAT_MEMBER_NAME(name, kind, 0, scope);
    return REPORT_EXPR_ERROR(message, text, CLASS_NAME_OF_TYPE(class), node);
}

/* finishes a '.' node: EXPR_LEFT is the object, EXPR_RIGHT a member-name node (or an
   already found member node, op 4Ah, or a symbol).  Looks the name up in the class or in
   the qualifying class X of obj.X::m (which must be a base, and unique unless the member
   is a constructor), checks ambiguity and access (except for overloaded functions, checked
   later).  Then by member kind: 0 data member: converts the object to the declaring base
   class if needed and makes a member node whose type carries the object's
   const/volatile; with mode set, a qualified name used for its address (node flag 2)
   gives a bare field reference (for &X::m); 1 enumerator: an int constant; 2 static
   member: a symbol node; 3 member function: a symbol node on the right of the '.',
   qualified by X when given */
u16 ANALYZE_MEMBER_SELECT(u16 node, u8 mode)
{
    u16 member = 0, qualifier = 0, scope, result, value;
    u16 right = E(node, EXPR_RIGHT);
    u16 left = E(node, EXPR_LEFT);
    u16 ltype = E(left, EXPR_TYPE);
    if (E(right, EXPR_OP) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    if (E(right, EXPR_OP) == 1) {
        value = RESOLVE_SYMBOL_REFERENCE(E(node, EXPR_RIGHT), 0);
        E(node, EXPR_RIGHT) = value;
        return node;
    }
    if (E(right, EXPR_OP) == 0x4A) {
        qualifier = E(right, EXPR_RIGHT);
        scope = ltype;
        member = E(right, EXPR_LEFT);
    } else {
        if (E(right, EXPR_NAME_KIND) == 2)
            return RESOLVE_CONVERSION_MEMBER(node);
        qualifier = E(right, EXPR_RIGHT);
        scope = qualifier == 0 ? ltype : qualifier;
        /* the original frame from BP-10h: access at 6, bad at 8, member at 0Eh */
        u16 mark = scratch_mark();
        farptr v = scratch_alloc(0x10);
        farptr access = fp_add(v, 6), bad = fp_add(v, 8), found = fp_add(v, 0x0E);
        W(bad) = 0;
        W(found) = 0;
        FIND_MEMBER_IN_BASES(E(right, EXPR_LEFT), scope, bad, found, access);
        u16 ambiguous = W(bad);
        member = W(found);
        scratch_release(mark);
        if (ambiguous)
            return error_member(MSG_FIELD_AMBIGUOUS, E(right, EXPR_LEFT), E(right, EXPR_NAME_KIND), scope, ambiguous, right);
        if (!member)
            return error_member(MSG_NOT_MEMBER, E(right, EXPR_LEFT), E(right, EXPR_NAME_KIND), scope, scope, right);
    }
    if (qualifier && !IS_BASE_CLASS(qualifier, ltype, 0)) {
        i32 name = CLASS_NAME_OF_TYPE(qualifier);                       /* pascal: left to right */
        return REPORT_EXPR_ERROR(MSG_NOT_BASE_CLASS, (farptr)name, CLASS_NAME_OF_TYPE(ltype), node);
    }
    if (qualifier && !IS_UNIQUE_BASE(qualifier, ltype)
        && !((MEMBER_B(member, MEMB_FLAGS) & 3) == 3 && SYM_W(MEMBER_W(member, MEMB_VALUE), SYM_FUNC_KIND) == 3)) {
        i32 name = FORMAT_MEMBER(member);
        return REPORT_EXPR_ERROR(MSG_FIELD_AMBIGUOUS, (farptr)name, CLASS_NAME_OF_TYPE(ltype), node);
    }
    if (!((MEMBER_B(member, MEMB_FLAGS) & 3) == 3 && SYM_W(MEMBER_W(member, MEMB_VALUE), SYM_NEXT_OVERLOAD)) && !MEMBER_ACCESSIBLE(member, ltype))
        return REPORT_EXPR_ERROR(0xB6, (farptr)FORMAT_MEMBER(member), 0, node);
    switch (MEMBER_B(member, MEMB_FLAGS) & 3) {
    case 0:
        if (mode && (EXPR_B(node, EXPR_NODE_FLAGS) & 2) && qualifier) {
            result = MAKE_FIELD_REF_NODE(member);
            E(result, EXPR_RIGHT) = qualifier;
            E(result, EXPR_TYPE) = MEMBER_W(member, MEMB_TYPE);
            copy_location(result, right);
            EXPR_B(result, EXPR_NODE_FLAGS) |= 1;
            FREE_EXPR_TREE(node);
            return result;
        }
        if (TYPE_W(MEMBER_W(member, MEMB_CLASS), TYPE_TAG_BODY) != TYPE_W(ltype, TYPE_TAG_BODY)) {
            left = CONVERT_DERIVED_TO_BASE(MAKE_ADDRESS_OF(left), ltype, qualifier, MEMBER_W(member, MEMB_CLASS), 0, 0);
            value = MAKE_DEREFERENCE(left);
            E(node, EXPR_LEFT) = value;
        }
        value = MAKE_MEMBER_NODE(member, LOCATION_WORDS(right));
        E(node, EXPR_RIGHT) = value;
        value = ADD_CV_QUALIFIERS(E(E(node, EXPR_RIGHT), EXPR_TYPE), (TYPE_B(ltype, TYPE_ATTRS) & 2) != 0, (TYPE_B(ltype, TYPE_ATTRS) & 1) != 0);
        E(E(node, EXPR_RIGHT), EXPR_TYPE) = value;
        break;
    case 1:
        result = MAKE_INT_CONSTANT(MEMBER_W(member, MEMB_TYPE), (i16)MEMBER_W(member, MEMB_VALUE));
        FREE_EXPR_TREE(node);
        return result;
    case 2:
    case 3:
        result = MAKE_SYMBOL_NODE(MEMBER_W(member, MEMB_VALUE));
        copy_location(result, right);
        E(result, EXPR_TYPE) = SYM_W(MEMBER_W(member, MEMB_VALUE), SYM_TYPE);
        E(result, EXPR_SCOPE_CLASS) = qualifier;
        EXPR_B(result, EXPR_NODE_FLAGS) |= 1;
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 2) {
            FREE_EXPR_TREE(node);
            return result;
        }
        E(node, EXPR_RIGHT) = result;
        break;
    }
    E(node, EXPR_TYPE) = E(E(node, EXPR_RIGHT), EXPR_TYPE);
    FREE_EXPR_NODE(right);
    EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
    return node;
}

/* finishes object .* member pointer.  The object must be a class whose base is the member
   pointer's class (it is converted to that class); a class on the right may be converted
   with a conversion function (mask 80h).  A pointer to data member becomes
   *(T *)((char *)&object + (int)pm - 1); a pointer to member function is left for the
   call code (LOWER_MEMBER_POINTER_CALL in CPPCALL.C) */
u16 ANALYZE_DOT_STAR(u16 node)
{
    u16 target = 0, value;
    value = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(E(node, EXPR_LEFT), 0, 0));
    E(node, EXPR_LEFT) = value;
    if (E(E(node, EXPR_LEFT), EXPR_OP) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);
    if (!(KIND_FLAGS(E(E(node, EXPR_LEFT), EXPR_TYPE)) & 0x40))
        node = REPORT_EXPR_ERROR_PLAIN(MSG_LEFT_SIDE_MUST, node);
    u16 right = ANALYZE_EXPRESSION(E(node, EXPR_RIGHT), 0, 0);
    right = APPLY_CONVERSION_FUNCTION(right, 0x80, 0);
    E(node, EXPR_RIGHT) = right;
    if (KIND(E(right, EXPR_TYPE)) != TK_NEAR_PTR || TYPE_B(E(right, EXPR_TYPE), TYPE_PTR_MODE) != 0x0B)
        return REPORT_EXPR_ERROR_PLAIN(MSG_RIGHT_SIDE_NOT_MEMBER, node);
    if (KIND_FLAGS(E(right, EXPR_TYPE)) & 0x14) {
        target = TYPE_W(E(right, EXPR_TYPE), TYPE_TARGET);
        if (!IS_BASE_CLASS(TYPE_W(target, TYPE_MEMBER_CLASS), E(E(node, EXPR_LEFT), EXPR_TYPE), 1))
            return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_DO_NOT_MATCH, node);
        if (TYPE_W(target, TYPE_MEMBER_CLASS) != E(E(node, EXPR_LEFT), EXPR_TYPE)) {
            u16 temp = MAKE_ADDRESS_OF(E(node, EXPR_LEFT));
            temp = CONVERT_EXPR_TO_TYPE(MAKE_POINTER_TYPE(TYPE_W(target, TYPE_MEMBER_CLASS), 0, 0), temp, 0);
            value = MAKE_DEREFERENCE(temp);
            E(node, EXPR_LEFT) = value;
        }
    }
    if (!((KIND_FLAGS(E(right, EXPR_TYPE)) & 0x14) && KIND(TYPE_W(E(right, EXPR_TYPE), TYPE_TARGET)) == TK_FUNCTION)) {
        u16 offset = MAKE_CAST_NODE(INT_TYPE, right);                   /* pascal: left to right */
        right = MAKE_BINARY_NODE(0x17, offset, MAKE_INT_CONSTANT(INT_TYPE, 1));
        E(node, EXPR_RIGHT) = right;
        value = MAKE_CAST_NODE(CHAR_POINTER_TYPE, MAKE_ADDRESS_OF(E(node, EXPR_LEFT)));
        E(node, EXPR_LEFT) = value;
        E(node, EXPR_OP) = EOP_ADD;
        node = ANALYZE_EXPRESSION(MAKE_CAST_NODE(MAKE_POINTER_TYPE(target, 0, 0), node), 0, 0);
        node = MAKE_DEREFERENCE(node);
    }
    return node;
}

/* 1 for a member pointer constant (op 48h) with all parts 0 */
u8 IS_NULL_MEMBER_PTR(u16 node)
{
    if (E(node, EXPR_OP) == 0x48)
        return E(node, EXPR_LEFT) == 0 && E(node, EXPR_RIGHT) == 0 && E(node, EXPR_SCOPE_CLASS) == 0;
    return 0;
}

/* left.field == right.field, on copies of the two trees when copy is set */
static u16 compare_field(u16 left, u16 right, u16 field, u8 copy)
{
    if (copy)
        left = COPY_EXPR_TREE(left);
    u16 a = MAKE_BINARY_NODE(0x2F, left, MAKE_FIELD_REF_NODE(field));
    if (copy)
        right = COPY_EXPR_TREE(right);
    u16 b = MAKE_BINARY_NODE(0x2F, right, MAKE_FIELD_REF_NODE(field));
    return MAKE_BINARY_NODE(0x24, a, b);
}

/* == or != between pointers to members (other operators are an error).  Against a null
   constant it becomes a test of the value (negated with ! for ==).  Otherwise both sides
   are saved in temporaries and all four fields of the struct are compared and joined,
   negated for != */
u16 COMPARE_MEMBER_POINTERS(u16 node)
{
    if (E(node, EXPR_OP) != EOP_EQ && E(node, EXPR_OP) != EOP_NE)
        return REPORT_EXPR_ERROR_PLAIN(MSG_OPERANDS_ARE_DIFFERING, node);
    if (IS_NULL_MEMBER_PTR(E(node, EXPR_LEFT)))
        node = SWAP_OPERANDS(node);
    if (IS_NULL_MEMBER_PTR(E(node, EXPR_RIGHT))) {
        u16 result = CONVERT_CLASS_TO_SCALAR(E(node, EXPR_LEFT));
        if (E(node, EXPR_OP) == EOP_EQ)
            result = ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x2A, result), 0, 0);
        FREE_EXPR_NODE(E(node, EXPR_RIGHT));
        FREE_EXPR_NODE(node);
        return result;
    }
    /* the original frame from BP-8: side, right at 2, left at 4, result at 6 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(8);
    farptr side = v, right = fp_add(v, 2), left = fp_add(v, 4), saved = fp_add(v, 6);
    W(left) = E(node, EXPR_LEFT);
    E(W(left), EXPR_TYPE) = MEMBER_PTR_CLASS_TYPE;
    SAVE_EXPR_IN_TEMP(left, side);
    W(right) = E(node, EXPR_RIGHT);
    E(W(right), EXPR_TYPE) = MEMBER_PTR_CLASS_TYPE;
    SAVE_EXPR_IN_TEMP(right, saved);
    u16 sides = JOIN_COMMA_EXPR(W(side), W(saved));
    u16 l = W(left), r = W(right);
    scratch_release(mark);
    u16 result = compare_field(l, r, MEMBER_PTR_PAD_MEMBER, 1);
    u16 part = compare_field(l, r, MEMBER_PTR_OFFSET_MEMBER, 1);
    result = MAKE_BINARY_NODE(0x23, part, result);
    part = compare_field(l, r, MEMBER_PTR_VINDEX_MEMBER, 1);
    result = MAKE_BINARY_NODE(0x23, part, result);
    part = compare_field(l, r, MEMBER_PTR_DELTA_MEMBER, 0);
    result = MAKE_BINARY_NODE(0x23, part, result);
    if (E(node, EXPR_OP) == EOP_NE)
        result = MAKE_UNARY_NODE(0x2A, result);
    result = JOIN_COMMA_EXPR(sides, result);
    FREE_EXPR_NODE(node);
    return ANALYZE_EXPRESSION(result, 0, 0);
}

/* (type)operator new(size * sizeof element, placement args) where symbol is the operator
   new to call (0: the global one) and object the placement argument list.  When neither
   force nor placement arguments are given the result is (type)0 instead: the allocation is
   then left to the constructor, which allocates when this is 0.  A member operator new is
   called qualified by its class */
u16 BUILD_ALLOC_CALL(u16 symbol, u16 object, u16 type, u16 size, u8 force)
{
    u16 result;
    if (force || object) {
        u16 copy = COPY_EXPR_TREE(size);                                /* pascal: left to right */
        u16 base = MAKE_BINARY_NODE(0x18, copy, MAKE_INT_CONSTANT(SIZE_T_TYPE, TYPE_SIZE(TYPE_W(type, TYPE_TARGET))));
        if (!symbol)
            symbol = NEW_OPERATOR_SYMBOL;
        u16 callee = MAKE_SYMBOL_NODE(symbol);
        result = MAKE_BINARY_NODE(1, callee, MAKE_LIST_NODE(base, object));
        if (SYM_B(symbol, SYM_FLAGS) & 0x10)
            E(E(result, EXPR_LEFT), EXPR_SCOPE_CLASS) = SYM_W(SYM_W(symbol, SYM_OWNER_CLASS), SYM_TYPE);
    } else
        result = MAKE_INT_CONSTANT(INT_TYPE, 0);
    return MAKE_CAST_NODE(type, result);
}

/* finishes a new node: EXPR_TYPE the allocated type, EXPR_LEFT the element count (0 for one
   object), EXPR_RIGHT a node with the placement arguments (left) and the initializer list
   (right).  For a class with constructors an array uses the vector helper (the virtual-base
   one for a class with virtual bases) with the memory, element size, count, mode and the
   default constructor, and takes no initializers; one object becomes a constructor call on
   *(type *)alloc, where alloc is 0 unless ::new or placement new is used, so the class's
   constructor allocates.  Other types are allocated with operator new and, when
   initializers are given, assigned through a temporary pointer: (tmp = alloc, *tmp = init,
   tmp).  An abstract class (flag 80h) cannot be created */
u16 ANALYZE_NEW_EXPRESSION(u16 node)
{
    u16 symbol = 0, work, value;
    u8 special = 0;
    u16 type = E(node, EXPR_TYPE);
    if (E(node, EXPR_LEFT) == 0) {
        value = MAKE_INT_CONSTANT(INT_TYPE, 1);
        E(node, EXPR_LEFT) = value;
    }
    /* the original frame from BP-1Ah: list at 4, count at 18h */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x1A);
    farptr list = fp_add(v, 4), count = fp_add(v, 0x18);
    W(count) = E(node, EXPR_LEFT);
    work = E(node, EXPR_RIGHT);
    u16 placement = E(work, EXPR_LEFT);
    u16 init = E(work, EXPR_RIGHT);
    u8 global = !(EXPR_B(node, EXPR_NODE_FLAGS) & 0x20);
    u16 ptype = MAKE_POINTER_TYPE(type, 0, 0);
    if (TYPE_B(type, TYPE_ATTRS) & 4) {
        while (KIND(type) == TK_ARRAY) {
            u16 c = W(count);
            W(count) = MAKE_BINARY_NODE(0x18, c, MAKE_INT_CONSTANT(INT_TYPE, TYPE_L(type, TYPE_ARRAY_COUNT)));
            type = TYPE_W(type, TYPE_TARGET);
        }
    }
    W(count) = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(W(count), INT_TYPE, 0));
    u8 array = 1;
    if (IS_LINK_TIME_CONSTANT(W(count))) {
        W(count) = SIMPLIFY_EXPRESSION(W(count), 0);
        if (E(W(count), EXPR_OP) == EOP_CONST)
            array = EXPR_L(W(count), EXPR_VALUE) != 1;
    }
    global = global || array;
    u16 size = (u16)TYPE_SIZE(type);
    if (global)
        symbol = NEW_OPERATOR_SYMBOL;
    if (KIND_FLAGS(type) & 0x40) {
        if (CLASS_FLAGS(type) & 0x80) {
            scratch_release(mark);
            return REPORT_EXPR_ERROR(MSG_CANNOT_CREATE_VARIABLE, (farptr)FORMAT_TYPE(type), 0, node);
        }
        special = (CLASS_FLAGS(type) & 4) != 0;
        if (!global) {
            u16 member = FIND_MEMBER_REPORT(OPERATOR_NEW_NAME, type);
            if (member)
                symbol = MEMBER_W(member, MEMB_VALUE);
        }
    }
    if (!size) {
        scratch_release(mark);
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION, node);
    }
    if (TYPE_B(type, TYPE_ATTRS) & 4) {
        if (array) {
            u16 ctor = FIND_DEFAULT_CTOR(type, 1);
            if (init) {
                scratch_release(mark);
                return REPORT_EXPR_ERROR_PLAIN(MSG_NO_CONSTRUCTOR, node);
            }
            if (!ctor) {
                scratch_release(mark);
                return REPORT_EXPR_ERROR(MSG_CANNOT_FIND_INITIALIZE_225, (farptr)FORMAT_SPECIAL_MEMBER(5, 0, type), 0, node);
            }
            W(list) = 0;
            u16 alloc = special ? VECTOR_VNEW_SYMBOL : VECTOR_NEW_SYMBOL;
            ptype = MAKE_POINTER_TYPE(TYPE_W(ptype, TYPE_TARGET), TK_FAR_PTR, 0);
            if (global || placement)
                SAVE_EXPR_IN_TEMP(count, list);
            /* pascal: the arguments are built left to right */
            u16 function = MAKE_SYMBOL_NODE(alloc);
            u16 address = BUILD_ALLOC_CALL(symbol, placement, ptype, W(count), global);
            u16 bytes = MAKE_INT_CONSTANT(SIZE_T_TYPE, size);
            u16 number = W(count);
            u16 flags = MAKE_INT_CONSTANT(INT_TYPE, DESTRUCTOR_CALL_FLAGS(type, ctor));
            u16 code = MAKE_UNARY_NODE(0x1D, MAKE_SYMBOL_NODE(ctor));
            work = MAKE_CALL_NODE(function, address, bytes, number, flags, code);
            work = JOIN_COMMA_EXPR(W(list), work);
        } else {
            work = BUILD_ALLOC_CALL(symbol, placement, ptype, W(count), global);
            work = BUILD_CONSTRUCTOR_CALL(MAKE_UNARY_NODE(0x18, work), type, init);
            copy_location(work, node);
        }
    } else {
        work = BUILD_ALLOC_CALL(symbol, placement, ptype, W(count), 1);
        if (init) {
            u16 values = 0;
            while (init) {
                values = JOIN_COMMA_EXPR(values, E(init, EXPR_RIGHT));
                u16 old = init;
                init = E(init, EXPR_LEFT);
                FREE_EXPR_NODE(old);
            }
            u16 item = CREATE_LOCAL_TEMP(ptype);
            u16 place = MAKE_SYMBOL_NODE(item);                         /* pascal: left to right */
            work = MAKE_BINARY_NODE(5, place, MAKE_CAST_NODE(ptype, work));
            u16 store = MAKE_BINARY_NODE(0x0B, MAKE_UNARY_NODE(0x18, MAKE_SYMBOL_NODE(item)), values);
            work = JOIN_COMMA_EXPR(work, store);
            work = JOIN_COMMA_EXPR(work, MAKE_SYMBOL_NODE(item));
        }
    }
    scratch_release(mark);
    return ANALYZE_EXPRESSION(MAKE_CAST_NODE(ptype, work), ptype, 0);
}

/* the class's own operator delete, preferring the overload with a second (size)
   parameter; 0 for a non-class or a class without one */
u16 FIND_DELETE_OPERATOR(u16 type)
{
    if (!(KIND_FLAGS(type) & 0x40))
        return 0;
    u16 member = FIND_MEMBER_REPORT(OPERATOR_DELETE_NAME, type);
    if (!member)
        return 0;
    u16 symbol = MEMBER_W(member, MEMB_VALUE);
    if (SYM_W(symbol, SYM_NEXT_OVERLOAD) && FORMAL_W(TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_PARAMS), FORMAL_NEXT) == 0)
        symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD);
    return symbol;
}

/* finishes delete: EXPR_RIGHT the pointer, EXPR_LEFT the count.  A class with a destructor
   is destroyed by BUILD_DESTRUCTOR_CALL with flags 3 (destroy and free), or flags 2
   followed by the global operator delete when ::delete is used on a class that has its own
   operator delete.  A virtual destructor is called through a temporary pointer and only if
   it is not 0.  Other types call operator delete directly (the class's own one only for a
   single object), adding count * size when it takes a size parameter */
u16 ANALYZE_DELETE_EXPRESSION(u16 node)
{
    u16 result;
    /* the original frame from BP-10h: list at 2, expr at 0Eh */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x10);
    farptr list = fp_add(v, 2), expr = fp_add(v, 0x0E);
    W(expr) = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(E(node, EXPR_RIGHT), 0, 0));
    if (!(KIND_FLAGS(E(W(expr), EXPR_TYPE)) & 0x14)) {
        u16 e = W(expr);
        scratch_release(mark);
        return REPORT_EXPR_ERROR_PLAIN(MSG_INVALID_INDIRECTION, e);
    }
    u16 target = TYPE_W(E(W(expr), EXPR_TYPE), TYPE_TARGET);
    u16 symbol = FIND_DELETE_OPERATOR(target);
    u8 global = symbol && !(EXPR_B(node, EXPR_NODE_FLAGS) & 0x20);
    u16 count = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(E(node, EXPR_LEFT), 0, 0));
    u8 single = E(count, EXPR_OP) == EOP_CONST && EXPR_L(count, EXPR_VALUE) == 1;
    if (TYPE_B(target, TYPE_ATTRS) & 8) {
        u16 member = FIND_MEMBER_BY_NAME(DTOR_NAME, target);
        u8 destroy = member && SYM_W(MEMBER_W(member, MEMB_VALUE), SYM_VIRTUAL_INDEX);
        W(list) = 0;
        if (destroy || global)
            SAVE_EXPR_IN_TEMP(expr, list);
        W(expr) = ANALYZE_EXPRESSION(W(expr), 0, 0);
        u16 object = MAKE_DEREFERENCE(COPY_EXPR_TREE(W(expr)));
        result = BUILD_DESTRUCTOR_CALL(object, target, count, global ? 2 : 3);
        if (global) {
            u16 callee = MAKE_SYMBOL_NODE(DELETE_OPERATOR_SYMBOL);       /* pascal: left to right */
            u16 call = MAKE_CALL_NODE(callee, COPY_EXPR_TREE(W(expr)), 0, 0, 0, 0);
            result = JOIN_COMMA_EXPR(result, call);
        }
        if (destroy) {
            u16 test = COPY_EXPR_TREE(W(expr));                          /* pascal: left to right */
            result = MAKE_CONDITIONAL_NODE(0x6B, test, result, MAKE_CAST_NODE(VOID_TYPE, MAKE_INT_CONSTANT(INT_TYPE, 0)));
            result = JOIN_COMMA_EXPR(W(list), result);
        }
    } else {
        if (!single || global || !symbol)
            symbol = DELETE_OPERATOR_SYMBOL;
        if (FORMAL_W(TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_PARAMS), FORMAL_NEXT))
            count = MAKE_BINARY_NODE(0x18, count, MAKE_INT_CONSTANT(SIZE_T_TYPE, TYPE_SIZE(E(W(expr), EXPR_TYPE))));
        else
            count = 0;
        u16 callee = MAKE_SYMBOL_NODE(symbol);
        result = MAKE_CALL_NODE(callee, W(expr), count, 0, 0, 0);
        if (SYM_B(symbol, SYM_FLAGS) & 0x10)
            E(E(result, EXPR_LEFT), EXPR_SCOPE_CLASS) = SYM_W(SYM_W(symbol, SYM_OWNER_CLASS), SYM_TYPE);
    }
    scratch_release(mark);
    return ANALYZE_EXPRESSION(result, 0, 0);
}
