/* overload.c: from bcc20/src/cpp/OVERLOAD.C: C++ overload resolution and user-defined
   conversions.  SELECT_OVERLOAD picks the function to call among the overloads in chain
   first (and a second chain, for operators: the member operators and the global ones) for
   a call node whose argument list is analysed already; it runs PICK_BEST_CANDIDATE twice:
   first with standard conversions only, then with user conversions and ellipsis matches
   too.  Each argument/parameter pair gets a rank (RANK_CONVERSION): 7 exact match, 6 exact
   apart from added const/volatile (or an overloaded function name matching a function
   pointer parameter), 5 promotion, 4 standard conversion, 3 standard conversion needing a
   temporary for a reference, 2 user conversion, 1 matched by an ellipsis, 0 no match.  A
   candidate's rank is its worst argument's; PREFER_CANDIDATE compares two candidates
   argument by argument, using COMPARE_CONVERSIONS to break ties between pointer and
   reference conversions.  FIND_USER_CONVERSION looks for a way to convert type to desired
   through a conversion function of type's class or a constructor of desired's class;
   APPLY_CONVERSION_FUNCTION applies one to a class value; FIND_MATCHING_OVERLOAD picks the
   overload of an exact function type.  The mask arguments name the built-in kind wanted,
   as EXPR_FLAGS bits of the type kind (0x80 a pointer to member).  Kept as in the original:
   FIND_CONVERSION_FUNCTION's kind test indexes EXPR_FLAGS one past the target kind for a
   reference result. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "exprop.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define F(t) EXPR_FLAGS_AT(TYPE_W((t), TYPE_KIND))
#define IS_REF(t) ((F(t) & 0x14) && (TYPE_B((t), TYPE_ATTRS) & 0x20))
#define IS_ZERO(e) (EXPR_W((e), EXPR_OP) == EOP_CONST && EXPR_L((e), 10) == 0)

/* 1 if a value of type right converts to type left by a standard conversion: arithmetic
   to arithmetic; to a reference of a compatible type or of a base class; a null constant
   to any pointer; a pointer to void * (or, in C, from void *) or to a pointer to a base
   class.  With strict 0 the base must also be unique and accessible */
u8 IS_STANDARD_CONVERSION(u16 left, u16 right, u8 zero, u8 strict)
{
    if ((F(left) & 3) && (F(right) & 3))
        return 1;
    if (IS_REF(left)) {
        if (C7_TYPE_COMPAT(TYPE_W(left, TYPE_TARGET), right, 0))
            return 1;
        if (F(right) & 0x40)
            return IS_BASE_CLASS(TYPE_W(left, TYPE_TARGET), right, !strict);
        return 0;
    }
    if (zero && (F(left) & 0x14))
        return 1;
    if ((F(left) & 0x14) && (F(right) & 0x14)) {
        if (((F(left) & 0x14) && TYPE_W(TYPE_W(left, TYPE_TARGET), TYPE_KIND) == TK_VOID) ||
            ((F(right) & 0x14) && TYPE_W(TYPE_W(right, TYPE_TARGET), TYPE_KIND) == TK_VOID && !CPP_MODE))
            return 1;
        return IS_BASE_CLASS(TYPE_W(left, TYPE_TARGET), TYPE_W(right, TYPE_TARGET), !strict);
    }
    return 0;
}

/* 1 if right promotes to left: the same integral kind, int from char, unsigned char or
   short (kinds below 4), unsigned int from unsigned short, or a floating type to a larger
   one other than long double.  An enum counts as its underlying type */
u8 IS_PROMOTION(u16 left, u16 right)
{
    if (TYPE_W(right, TYPE_KIND) == TK_ENUM)
        right = TAG_W(TYPE_W(right, TYPE_TAG_BODY), 4);
    i16 kind = TYPE_W(left, TYPE_KIND), other = TYPE_W(right, TYPE_KIND);
    if (EXPR_FLAGS_AT(kind) & 1) {
        if (kind == other || (kind == 5 && other < 4) || (kind == 6 && other == 4))
            return 1;
    } else if (EXPR_FLAGS_AT(kind) & 2) {
        if ((EXPR_FLAGS_AT(other) & 2) && kind != 0xB && other < kind)
            return 1;
    }
    return 0;
}

/* 7 when left and right are the same type (a reference on one side, or pointers on both,
   are compared by their targets), 6 when the targets differ only in const/volatile and
   left adds qualifiers (any difference with strict), else 0 */
u16 MATCH_RANK(u16 left, u16 right, u8 strict)
{
    u8 adjusted = 0;
    if (IS_REF(left) && !IS_REF(right)) {
        adjusted = 1;
        left = TYPE_W(left, TYPE_TARGET);
    } else if (IS_REF(right) && !IS_REF(left))
        right = TYPE_W(right, TYPE_TARGET);
    else if ((F(left) & 0x14) && (F(right) & 0x14)) {
        adjusted = 1;
        left = TYPE_W(left, TYPE_TARGET);
        right = TYPE_W(right, TYPE_TARGET);
    }
    if (adjusted) {
        if (TYPES_COMPATIBLE(left, right, 1)) {
            u16 a = TYPE_B(left, TYPE_ATTRS) & 3, b = TYPE_B(right, TYPE_ATTRS) & 3;
            if (a == b)
                return 7;
            if (strict || ((a & ~b) == a))
                return 6;
            return 0;
        }
        return 0;
    }
    return TYPES_COMPATIBLE(left, right, 1) ? 7 : 0;
}

/* 1 when desired is a reference that cannot be bound directly to expression: the value is
   not an object, would lose const or volatile, or is of a type that is neither the same
   nor a derived class */
u8 NEEDS_REFERENCE_TEMP(u16 expression, u16 desired)
{
    if (!IS_REF(desired) || C7_TYPE_COMPAT(desired, EXPR_W(expression, EXPR_TYPE), 0))
        return 0;
    if (!(IS_LVALUE(expression) || IS_OBJECT_RVALUE(expression)))
        return 1;
    u16 left = TYPE_W(desired, TYPE_TARGET), right = EXPR_W(expression, EXPR_TYPE);
    if ((TYPE_B(left, TYPE_ATTRS) & 1) < (TYPE_B(right, TYPE_ATTRS) & 1) || (TYPE_B(left, TYPE_ATTRS) & 2) < (TYPE_B(right, TYPE_ATTRS) & 2))
        return 1;
    if (TYPES_COMPATIBLE(left, right, 1))
        return 0;
    if ((F(left) & 0x40) && (F(right) & 0x40))
        return !IS_BASE_CLASS(left, right, 1);
    return 1;
}

/* the overload in chain head whose type is compatible with function type type (or with
   the target of a function pointer type), or 0 (symbol record 0 ends the chain) */
u16 FIND_MATCHING_OVERLOAD(u16 head, u16 type)
{
    if (F(type) & 0x14)
        type = TYPE_W(type, TYPE_TARGET);
    SYM_W(0, SYM_TYPE) = type;
    while (!TYPES_COMPATIBLE(SYM_W(head, SYM_TYPE), type, 2))
        head = SYM_W(head, SYM_NEXT_OVERLOAD);
    return head;
}

/* the rank of passing expression to a parameter of type desired.  User conversions are
   only considered when user is set; strict goes to the base class checks */
u16 RANK_CONVERSION(u16 desired, u16 expression, u8 user, u8 strict)
{
    u16 type = EXPR_W(expression, EXPR_TYPE);
    u16 rank = MATCH_RANK(desired, type, strict);
    if (rank)
        return rank;
    if ((F(desired) & 0x14) && TYPE_W(TYPE_W(desired, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION) {
        u16 adjusted = EXPR_W(expression, EXPR_OP) == EOP_ADDR ? EXPR_W(expression, EXPR_LEFT) : expression;
        if (EXPR_W(adjusted, EXPR_OP) == 1 && TYPE_W(EXPR_W(adjusted, EXPR_TYPE), TYPE_KIND) == TK_FUNCTION &&
            FIND_MATCHING_OVERLOAD(EXPR_W(adjusted, EXPR_LEFT), desired))
            return 6;
    }
    if (IS_PROMOTION(desired, type))
        return 5;
    if (IS_STANDARD_CONVERSION(desired, type, IS_ZERO(expression), strict))
        return NEEDS_REFERENCE_TEMP(expression, desired) ? 3 : 4;
    if (!user)
        return 0;
    if (IS_REF(desired))
        desired = TYPE_W(desired, TYPE_TARGET);
    if (FIND_USER_CONVERSION(desired, type, 0, 0, 0))
        return 2;
    return 0;
}

/* which parameter type, left or right, is the better target for argument expression: 1
   left, 2 right, 0 neither.  Different ranks decide first; for two pointer or reference
   targets the one with the qualification closest to the argument's, a non-void target
   over void * (unless the argument is a null constant), and a pointer to a derived class
   over one to its base win */
u16 COMPARE_CONVERSIONS(u16 left, u16 right, u16 expression, u8 user)
{
    i16 a = RANK_CONVERSION(left, expression, user, 1);
    i16 b = RANK_CONVERSION(right, expression, user, 1);
    if (a != b)
        return a > b ? 1 : 2;
    if (!((F(left) & 0x14) && (F(right) & 0x14)))
        return 0;
    left = TYPE_W(left, TYPE_TARGET);
    right = TYPE_W(right, TYPE_TARGET);
    u8 zero = IS_ZERO(expression);
    u16 type = EXPR_W(expression, EXPR_TYPE);
    if (F(type) & 0x14)
        type = TYPE_W(type, TYPE_TARGET);
    if (TYPES_COMPATIBLE(left, right, 0))
        return 0;
    if (TYPES_COMPATIBLE(left, right, 1)) {
        u16 ac = (TYPE_B(left, TYPE_ATTRS) & 1) != 0, bc = (TYPE_B(right, TYPE_ATTRS) & 1) != 0, ec = (TYPE_B(type, TYPE_ATTRS) & 1) != 0;
        u16 av = (TYPE_B(left, TYPE_ATTRS) & 2) != 0, bv = (TYPE_B(right, TYPE_ATTRS) & 2) != 0, ev = (TYPE_B(type, TYPE_ATTRS) & 2) != 0;
        if (ec == ev) {
            ac += av;
            bc += bv;
            if (ac == bc)
                return 0;
            return ((ac > bc) == ec) ? 1 : 2;
        }
        if (ec) {
            if (ac && !bc)
                return 1;
            if (bc && !ac)
                return 2;
            return av ? 2 : 1;
        }
        if (av && !bv)
            return 1;
        if (bv && !av)
            return 2;
        return ac ? 2 : 1;
    }
    if (TYPE_W(left, TYPE_KIND) == TK_VOID)
        return zero ? 0 : 2;
    if (TYPE_W(right, TYPE_KIND) == TK_VOID)
        return zero ? 0 : 1;
    if (IS_BASE_CLASS(left, right, 1))
        return 2;
    if (IS_BASE_CLASS(right, left, 1))
        return 1;
    return 0;
}

/* compares candidates left and right for argument list arguments: the better one, or 0
   when neither is better on every argument.  When one is a static member function and the
   call has an object argument (list flag 40h), the object is compared only against the
   other's this parameter.  A candidate whose parameters run out first loses the tie.
   Preference: 1 left, 2 right, 3 conflicting */
u16 PREFER_CANDIDATE(u16 arguments, u8 user, u16 left, u16 right)
{
    u16 preference = 0;
    u16 a = TYPE_W(SYM_W(left, SYM_TYPE), TYPE_PARAMS), b = TYPE_W(SYM_W(right, SYM_TYPE), TYPE_PARAMS);
    if (arguments && ((SYM_W(left, SYM_FUNC_FLAGS) | SYM_W(right, SYM_FUNC_FLAGS)) & 0x40) && (EXPR_B(arguments, EXPR_NODE_FLAGS) & 0x40)) {
        if (SYM_W(left, SYM_FUNC_FLAGS) & 0x40) {
            if (!(SYM_W(right, SYM_FUNC_FLAGS) & 0x40)) {
                if (RANK_CONVERSION(FORMAL_W(b, FORMAL_TYPE), EXPR_W(arguments, EXPR_RIGHT), user, 1) != 7)
                    preference = 1;
                b = FORMAL_W(b, FORMAL_NEXT);
            }
        } else {
            if (RANK_CONVERSION(FORMAL_W(a, FORMAL_TYPE), EXPR_W(arguments, EXPR_RIGHT), user, 1) != 7)
                preference = 2;
            a = FORMAL_W(a, FORMAL_NEXT);
        }
        arguments = EXPR_W(arguments, EXPR_LEFT);
    }
    while (arguments && a && b && preference != 3) {
        u16 next = COMPARE_CONVERSIONS(FORMAL_W(a, FORMAL_TYPE), FORMAL_W(b, FORMAL_TYPE), EXPR_W(arguments, EXPR_RIGHT), user);
        if (!preference)
            preference = next;
        else if (next && preference != next)
            preference = 3;
        arguments = EXPR_W(arguments, EXPR_LEFT);
        a = FORMAL_W(a, FORMAL_NEXT);
        b = FORMAL_W(b, FORMAL_NEXT);
    }
    if (arguments && preference != 3 && a != b) {
        if (!a)
            preference = preference == 1 ? 3 : 2;
        else
            preference = preference == 2 ? 3 : 1;
    }
    switch (preference) {
    case 1:
        return left;
    case 2:
        return right;
    default:
        return 0;
    }
}

/* FIND_CONVERSION_FUNCTION with its "reported" flag in the scratch area */
static u16 conversion_function(u16 desired, u16 type, u8 exact, u16 mask, u16 line, u16 column, u8 *reported)
{
    u16 mark = scratch_mark();
    farptr flag = scratch_alloc(2);
    u16 result = FIND_CONVERSION_FUNCTION(desired, type, exact, mask, line, column, flag);
    *reported = B(flag);
    scratch_release(mark);
    return result;
}

/* for a non-member operator function found only through user conversions: 1 if every
   argument that needed a user conversion could also be converted to the built-in kind mask
   (directly or by a conversion function); then the built-in operator would do as well and
   the call is ambiguous.  Member functions always give 0 */
u8 ARGS_CONVERT_FOR_CANDIDATE(u16 arguments, u16 symbol, u16 mask)
{
    if (SYM_B(symbol, SYM_FLAGS) & 0x10)
        return 0;
    u16 parameter = TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_PARAMS);
    u8 acceptable = 1, reported;
    while (arguments && acceptable) {
        u16 desired = FORMAL_W(parameter, FORMAL_TYPE), actual = EXPR_W(EXPR_W(arguments, EXPR_RIGHT), EXPR_TYPE);
        if ((i16)RANK_CONVERSION(desired, EXPR_W(arguments, EXPR_RIGHT), 1, 0) <= 2) {
            acceptable = (EXPR_FLAGS_AT(TYPE_W(actual, TYPE_KIND)) & mask) || conversion_function(0, actual, 0, mask, 0, 0, &reported);
            arguments = EXPR_W(arguments, EXPR_LEFT);
            parameter = FORMAL_W(parameter, FORMAL_NEXT);
        } else
            acceptable = 0;
    }
    return acceptable;
}

/* ranks every candidate in chain first, then in chain second, against the call node
   expression and returns the best (0 if none matches).  Reports an ambiguity (when the node
   has a source line) when two candidates are equally good, or when a single operator
   candidate competes with the built-in operator.  "variadic" is set for a member function
   (SYM_FLAGS 10h) and "has_defaults" for a function with an ellipsis; "object" means the
   call's first argument is the object for a member function.  A non-static member function
   without an object argument cannot be chosen, and a static one skips the object */
u16 PICK_BEST_CANDIDATE(u16 expression, u16 first, u16 second, u16 mask, u8 user)
{
    u16 best = 0, count = 0, other = 0;
    if (!first) {
        first = second;
        second = 0;
    }
    u16 symbol = first;
    while (symbol) {
        i16 rank = 7;
        u16 type = SYM_W(symbol, SYM_TYPE);
        u8 variadic = (SYM_B(symbol, SYM_FLAGS) & 0x10) != 0;
        u8 has_defaults = (TYPE_B(type, TYPE_FUNC_FLAGS) & 4) != 0;
        u16 parameter = TYPE_W(type, TYPE_PARAMS), arguments = EXPR_W(expression, EXPR_RIGHT);
        u8 object = variadic && (EXPR_B(arguments, EXPR_NODE_FLAGS) & 0x40);
        if (object && (SYM_W(symbol, SYM_FUNC_FLAGS) & 0x40)) {
            arguments = EXPR_W(arguments, EXPR_LEFT);
            object = 0;
        }
        if (variadic && !object && !(SYM_W(symbol, SYM_FUNC_FLAGS) & 0x40))
            rank = 0;
        else {
            /* the worst rank of the arguments; extra arguments need an ellipsis (rank 1,
               only in the second pass) */
            while (rank > 1 && arguments) {
                if (!parameter)
                    rank = has_defaults && user ? 1 : 0;
                else {
                    i16 current = RANK_CONVERSION(FORMAL_W(parameter, FORMAL_TYPE), EXPR_W(arguments, EXPR_RIGHT), user, object);
                    if (current < rank)
                        rank = current;
                    parameter = FORMAL_W(parameter, FORMAL_NEXT);
                }
                arguments = EXPR_W(arguments, EXPR_LEFT);
                object = 0;
            }
            if (parameter && !FORMAL_W(parameter, FORMAL_DEFAULT_ARG))
                rank = 0;
        }
        if (rank > 0) {
            ++count;
            if (!best)
                best = symbol;
            else {
                u16 selected = PREFER_CANDIDATE(EXPR_W(expression, EXPR_RIGHT), user, symbol, best);
                if (!selected)
                    other = symbol;
                else {
                    best = selected;
                    count = 1;
                }
            }
        }
        symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD);
        if (!symbol) {
            symbol = second;
            second = 0;
        }
    }
    /* two equally good candidates, or one operator function the built-in operator could
       replace: ambiguous */
    if (EXPR_W(expression, EXPR_SRC_LINE) &&
        (count > 1 || (count == 1 && mask && user && ARGS_CONVERT_FOR_CANDIDATE(EXPR_W(expression, EXPR_RIGHT), best, mask)))) {
        farptr first_name = count == 1 ? NAME_TEXT_COPY(SYM_W(best, SYM_NAME)) : FORMAT_SYMBOL(other);   /* pascal */
        farptr second_name = FORMAT_SYMBOL(best);
        REPORT_DIAGNOSTIC_AT(MSG_AMBIGUITY_BETWEEN, (i32)first_name, (i32)second_name, EXPR_W(expression, EXPR_SRC_LINE),
                             EXPR_W(expression, EXPR_SRC_WORD3));
    }
    return best;
}

/* the best overload for call node expression among chains first and second; mask is the
   built-in operator kind for operator calls, 0 for ordinary calls */
u16 SELECT_OVERLOAD(u16 expression, u16 first, u16 second, u16 mask)
{
    u16 found = PICK_BEST_CANDIDATE(expression, first, second, 0, 0);
    if (found)
        return found;
    return PICK_BEST_CANDIDATE(expression, first, second, mask, 1);
}

/* a conversion function of class type (or, when the class has none that fits, of its
   bases) for a value wanted as desired.  With exact the result type must be compatible
   with desired; with mask it must be of the built-in kind mask (an exact match wins at
   once); otherwise an exact match wins and standard conversions of the result count.  Two
   eligible functions, or one when a standard conversion to a base reference would also do,
   is an ambiguity: reported once (*reported) when line is given, else the result is 0 */
u16 FIND_CONVERSION_FUNCTION(u16 desired, u16 type, u8 exact, u16 mask, u16 line, u16 column, farptr reported)
{
    u16 count = 0, first = 0, second = 0, symbol;
    u8 eligible = 0, exact_found = 0;
    B(reported) = 0;
    u16 member = FIND_MEMBER_BY_NAME(TOKEN_NAMES_AT(TOK_TYPEDEF), type);
    symbol = member == 0 ? 0 : MEMBER_W(member, 6);
    while (symbol) {
        u16 returned = TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_TARGET);
        if (exact)
            eligible = TYPES_COMPATIBLE(desired, returned, 2);
        else if (mask) {
            if (desired && TYPES_COMPATIBLE(desired, returned, 2)) {
                count = 1;
                exact_found = 1;
                first = symbol;
                break;
            }
            u16 base_type = IS_REF(returned) ? TYPE_W(returned, TYPE_TARGET) : returned;
            if (mask == 0x80)
                eligible = TYPE_W(base_type, TYPE_KIND) == 0xD && TYPE_B(base_type, TYPE_PTR_MODE) == 0xB;
            else {
                /* (EXPR_FLAGS+1)[k-1] in the original, the -1 on the second branch only */
                i16 index = IS_REF(returned) ? (i16)TYPE_W(TYPE_W(returned, TYPE_TARGET), TYPE_KIND) : (i16)TYPE_W(returned, TYPE_KIND) - 1;
                eligible = (EXPR_FLAGS_AT(index + 1) & (u8)mask) != 0;
            }
            eligible = eligible && (!desired || C7_TYPE_COMPAT(desired, returned, 0));
        } else {
            u16 rank = MATCH_RANK(desired, returned, 0);
            if (!rank)
                eligible = IS_STANDARD_CONVERSION(desired, returned, 0, 1);
            else {
                count = 1;
                exact_found = 1;
                first = symbol;
                break;
            }
        }
        if (eligible) {
            ++count;
            if (count == 1)
                first = symbol;
            else
                second = symbol;
        }
        symbol = SYM_W(symbol, SYM_NEXT_OVERLOAD);
    }
    if (!count) {
        for (u16 base = TAG_W(TYPE_W(type, TYPE_TAG_BODY), 12); base; base = BASE_W(base, 0)) {
            symbol = FIND_CONVERSION_FUNCTION(desired, BASE_W(base, 2), exact, mask, line, column, reported);
            if (symbol && symbol != first) {
                ++count;
                if (MATCH_RANK(desired, TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_TARGET), 0)) {
                    if (!exact_found)
                        count = 1;
                    exact_found = 1;
                }
                if (count == 1)
                    first = symbol;
                else
                    second = symbol;
            }
        }
    }
    if (!(count > 1 || (count == 1 && IS_REF(desired) && IS_BASE_CLASS(TYPE_W(desired, TYPE_TARGET), type, 1))))
        return first;
    if (!line)
        first = 0;
    else if (!B(reported)) {
        farptr one = FORMAT_SYMBOL(first);                  /* pascal: left to right */
        farptr two = count > 1 ? FORMAT_SYMBOL(second) : STR_A_STANDARD_CONVERSION_P;
        REPORT_DIAGNOSTIC_AT(MSG_AMBIGUITY_BETWEEN, (i32)one, (i32)two, line, column);
    }
    B(reported) = 1;
    return first;
}

/* the function that converts a value of type to desired: a conversion function of type's
   class, or a constructor of desired's class callable with one argument of type (found by
   ranking a fake call desired(type value), with the hidden virtual-base flag when the class
   has virtual bases).  The constructor is preferred; if both fit exactly it is an
   ambiguity, reported when line is given, else 0.  The result's SYM_FUNC_KIND tells which
   (3 constructor, 2 conversion function) */
u16 FIND_USER_CONVERSION(u16 desired, u16 type, u8 exact, u16 line, u16 column)
{
    if (!desired || !type)
        return 0;
    u16 found = 0;
    u8 reported = 0;
    if (F(type) & 0x40)
        found = conversion_function(desired, type, exact, 0, line, column, &reported);
    if (!reported && (F(desired) & 0x40)) {
        u16 expression = MAKE_LIST_NODE(MAKE_INT_CONSTANT(type, 1), 0);
        if (TAG_W(TYPE_W(desired, TYPE_TAG_BODY), 24) & 4)
            expression = MAKE_LIST_NODE(MAKE_INT_CONSTANT(INT_TYPE, 0), expression);
        expression = MAKE_LIST_NODE(MAKE_INT_CONSTANT(desired, 1), expression);
        EXPR_B(expression, EXPR_NODE_FLAGS) |= 0x40;
        expression = MAKE_BINARY_NODE(1, 0, expression);
        EXPR_W(expression, EXPR_SRC_LINE) = line;
        EXPR_W(expression, EXPR_SRC_WORD3) = column;
        u16 member = FIND_MEMBER_BY_NAME(CTOR_NAME, desired);
        u16 candidates = member == 0 ? 0 : MEMBER_W(member, 6);
        u16 constructor = PICK_BEST_CANDIDATE(expression, candidates, 0, 0, 0);
        FREE_EXPR_TREE(expression);
        if (constructor) {
            if (found && MATCH_RANK(desired, TYPE_W(SYM_W(found, SYM_TYPE), TYPE_TARGET), 0)) {
                if (!line)
                    constructor = 0;
                else {
                    farptr one = FORMAT_SYMBOL(found);      /* pascal: left to right */
                    farptr two = FORMAT_SYMBOL(constructor);
                    REPORT_DIAGNOSTIC_AT(MSG_AMBIGUITY_BETWEEN, (i32)one, (i32)two, line, column);
                }
            }
            found = constructor;
        }
    }
    return found;
}

/* if expression is a class value and a conversion function to desired (or to a type of
   kind mask) exists, the analysed call expression.operator T(); otherwise expression
   unchanged */
u16 APPLY_CONVERSION_FUNCTION(u16 expression, u16 mask, u16 desired)
{
    if (!(F(EXPR_W(expression, EXPR_TYPE)) & 0x40) || (!desired && !mask))
        return expression;
    u8 reported;
    u16 symbol = conversion_function(desired, EXPR_W(expression, EXPR_TYPE), 0, mask, EXPR_W(expression, EXPR_SRC_LINE),
                                     EXPR_W(expression, EXPR_SRC_WORD3), &reported);
    if (symbol) {
        u16 callee = MAKE_SYMBOL_NODE(symbol);
        if (SYM_W(symbol, SYM_FUNC_KIND) != 2)
            EXPR_W(callee, EXPR_SCOPE_CLASS) = SYM_W(SYM_W(symbol, SYM_OWNER_CLASS), SYM_TYPE);
        expression = MAKE_CALL_NODE(MAKE_BINARY_NODE(0x2F, expression, callee), 0, 0, 0, 0, 0);
        expression = ANALYZE_EXPRESSION(expression, 0, 0);
    }
    return expression;
}
