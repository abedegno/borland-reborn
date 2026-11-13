/* callchk.c: from bcc20/src/expr/CALLCHK.C: analysis of a function call node (operator
   36h: EXPR_LEFT the callee, EXPR_RIGHT a list of MAKE_LIST_NODE cells, the argument in
   each cell's EXPR_RIGHT and the next cell in its EXPR_LEFT).  The callee is analysed, in
   C++ an overload picked (PREPARE_CALL, which may give back code to run first), and the
   arguments are converted to their parameters' types (C5ARG in C, CONVERT_ARGUMENT in
   C++) or given the default promotions where no parameter matches (C5WRAP).  Storage
   class 0Ah, probably a built-in function, is exempt from the promotions and from the "no
   prototype" warning.  A function returning a structure gets a hidden result slot
   (C5VALUE); in C++ a call to an inline function may be expanded in place. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "protos.h"

#define KIND_OF(node) TYPE_W(EXPR_W((node), EXPR_TYPE), TYPE_KIND)
#define FLAGS_OF(node) EXPR_FLAGS_AT(KIND_OF(node))

/* storage class 0Ah: probably a built-in function */
static int builtin(u16 symbol) { return (SYM_B(symbol, SYM_STORAGE_CLASS) >> 3) == 0x0A; }

/* the called function's name for a message: decorated in C++ */
static i32 symbol_text(u16 symbol)
{
    return (i32)(CPP_MODE ? FORMAT_SYMBOL(symbol) : SYMBOL_NAME_TEXT(symbol));
}

/* the default argument promotions for an argument with no parameter to match: void and
   classes that need a constructor (TYPE_ATTRS bit 4) are errors, enums and small integers
   become int (long for the long kinds), float becomes double */
u16 C5WRAP(u16 expression)
{
    u16 node = NODE_ENUM_TO_INT(CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression, 0, 0)));
    if (KIND_OF(node) == TK_VOID)
        node = REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    else if ((FLAGS_OF(node) & 0x40) && (TYPE_B(EXPR_W(node, EXPR_TYPE), TYPE_ATTRS) & 4))
        node = REPORT_EXPR_ERROR(MSG_ITEMS_TYPE_NEED, (farptr)FORMAT_TYPE(EXPR_W(node, EXPR_TYPE)), 0, node);
    else if (FLAGS_OF(node) & 1)
        node = CONVERT_EXPR_TO_TYPE((i16)KIND_OF(node) > TK_UINT ? LONG_TYPE : INT_TYPE, node, 0);
    else if ((FLAGS_OF(node) & 2) && (i16)KIND_OF(node) < TK_LDOUBLE)
        node = CONVERT_EXPR_TO_TYPE(DOUBLE_TYPE, node, 0);
    return node;
}

/* in C++, a warning for calling a non-const (non-volatile) member function on a const
   (volatile) object, the object being the first argument */
static void warn_qualifier(i16 message, u16 symbol, u16 argument)
{
    i32 text = symbol ? (i32)FORMAT_SYMBOL(symbol) : (i32)POINTER_TEXT_P;
    REPORT_DIAGNOSTIC_AT(message, text, 0, EXPR_W(argument, EXPR_SRC_LINE), EXPR_W(argument, EXPR_SRC_WORD3));
}

/* the preparation for CHECK_CALL_ARGUMENTS.  Out: *symbol_out the called symbol when the
   callee is a plain name, *type_out the function type, *selected code from
   LOWER_VIRTUAL_CALL, *restricted 1 when the call is to be expanded inline.  In C++ it
   also checks const and volatile objects and queues used inline functions that have a
   body.  A call through a function pointer gets the pointer dereferenced.  The call node
   takes the function's return type. */
void C5CHECK(u16 node, farptr selected, farptr restricted, farptr symbol_out, farptr type_out)
{
    W(selected) = 0;
    B(restricted) = 0;
    u16 callee = EXPR_W(node, EXPR_LEFT);
    u16 symbol = EXPR_W(callee, EXPR_OP) == 1 ? EXPR_W(callee, EXPR_LEFT) : 0;
    W(symbol_out) = symbol;
    if (CPP_MODE && KIND_OF(callee) == TK_FUNCTION) {
        u16 argument = EXPR_W(node, EXPR_RIGHT) ? EXPR_W(EXPR_W(node, EXPR_RIGHT), EXPR_RIGHT) : 0;
        if (TYPE_W(EXPR_W(callee, EXPR_TYPE), TYPE_MEMBER_CLASS) && argument) {
            u16 argument_qualifiers = TYPE_B(EXPR_W(argument, EXPR_TYPE), TYPE_ATTRS);
            u16 function_qualifiers = TYPE_B(EXPR_W(callee, EXPR_TYPE), TYPE_ATTRS);
            if ((argument_qualifiers & 1) && !(function_qualifiers & 1))
                warn_qualifier(MSG_NON_CONST_FUNCTION, symbol, argument);
            if ((argument_qualifiers & 2) && !(function_qualifiers & 2))
                warn_qualifier(MSG_NON_VOLATILE_FUNCTION, symbol, argument);
            u16 stripped = STRIP_CV_QUALIFIERS(EXPR_W(argument, EXPR_TYPE));
            EXPR_W(argument, EXPR_TYPE) = stripped;
        }
        if (symbol)
            LOWER_VIRTUAL_CALL(node, selected);
        if (EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_OP) == 1 && !builtin(symbol) &&
            ((SYM_B(symbol, SYM_INLINE_ACCESS) & 3) == 1 || (SYM_B(symbol, SYM_INLINE_ACCESS) & 3) == 2)) {
            B(restricted) = (SYM_W(symbol, SYM_FUNC_FLAGS) & 4) && NO_ERRORS_YET &&
                            (EXPAND_INLINES_FLAG || (SYM_B(symbol, SYM_INLINE_ACCESS) & 3) == 2);
            if (!(SYM_B(symbol, SYM_FLAGS) & 2)) {
                REPORT_DIAGNOSTIC_AT(MSG_NO_BODY_DEFINED_THIS, (i32)FORMAT_SYMBOL(symbol), 0,
                                     EXPR_W(node, EXPR_SRC_LINE), 0);
                B(restricted) = 0;
            } else if (!B(restricted))
                QUEUE_DEFERRED_SYMBOL(symbol);
        }
    }
    callee = EXPR_W(node, EXPR_LEFT);
    if ((FLAGS_OF(callee) & 0x14) && TYPE_W(TYPE_W(EXPR_W(callee, EXPR_TYPE), TYPE_TARGET), TYPE_KIND) == TK_FUNCTION) {
        u16 dereferenced = MAKE_DEREFERENCE(callee);
        EXPR_W(node, EXPR_LEFT) = dereferenced;
    }
    W(type_out) = EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_TYPE);
    EXPR_W(node, EXPR_TYPE) = TYPE_W(W(type_out), TYPE_KIND) == TK_FUNCTION ? TYPE_W(W(type_out), TYPE_TARGET) : 0;
}

/* a bad argument, reported at its source line.  error is the base message (77): one more
   when the parameter has a name (printed instead of the position), two more when the
   called symbol is unknown, which picks among messages 77 to 80.  The first message
   argument is a number or a text pointer in the same 32 bits. */
void REPORT_ARGUMENT_MISMATCH(u16 expression, u16 formal, u16 symbol, i16 position, u16 error)
{
    i32 first, second;
    if (!FORMAL_W(formal, FORMAL_NAME))
        first = position;
    else {
        first = (i32)NAME_TEXT_COPY(FORMAL_W(formal, FORMAL_NAME));
        ++error;
    }
    if (symbol)
        second = symbol_text(symbol);
    else {
        second = 0;
        error += 2;
    }
    REPORT_DIAGNOSTIC_AT((i16)error, first, second, EXPR_W(expression, EXPR_SRC_LINE), 0);
}

/* (C) one argument, analysed with its parameter's type as the wanted type and converted
   to it; void values and incompatible types are errors */
u16 C5ARG(u16 expression, u16 formal, u16 symbol, i16 position)
{
    u16 type = FORMAL_W(formal, FORMAL_TYPE);
    u16 node = CONVERT_TO_RVALUE(ANALYZE_EXPRESSION(expression, type, 0));
    if (KIND_OF(node) == TK_VOID)
        return REPORT_EXPR_ERROR_PLAIN(MSG_VALUE_TYPE_VOID_NOT, node);
    node = NULL_CONSTANT_TO_POINTER(type, node);
    if (C7_TYPE_COMPAT(type, EXPR_W(node, EXPR_TYPE), 1))
        return CONVERT_EXPR_TO_TYPE(type, NODE_ENUM_TO_INT(node), 0);
    REPORT_ARGUMENT_MISMATCH(node, formal, symbol, position, 0x4D);
    return REPORT_EXPR_ERROR_PLAIN(0, node);
}

/* a call returning a structure (other than a plain 1, 2 or 4 byte one) or a member
   function pointer: the address of a place for the result goes in as a hidden first
   argument and the call becomes *(call, &place).  The place is a copy of other when that
   is a compatible destination, else a new local temporary, destroyed at the end of the
   full expression in C++.  The cast is to a far pointer (kind 0Fh); token 18h (*) makes
   the dereference.  Only the low word of the size is kept, as in the original. */
u16 C5VALUE(u16 node, u16 other)
{
    u16 first, size = (u16)TYPE_SIZE(EXPR_W(node, EXPR_TYPE));
    if (!(TYPE_B(EXPR_W(node, EXPR_TYPE), TYPE_ATTRS) & 4) && (size == 1 || size == 2 || size == 4))
        return node;
    if (other && !TYPES_COMPATIBLE(EXPR_W(other, EXPR_TYPE), EXPR_W(node, EXPR_TYPE), 1))
        other = 0;
    if (!other) {
        u16 record = CREATE_LOCAL_TEMP(EXPR_W(node, EXPR_TYPE));
        first = ANALYZE_EXPRESSION(MAKE_SYMBOL_NODE(record), 0, 0);
        if (CPP_MODE) {
            u16 symnode = MAKE_SYMBOL_NODE(record);
            u16 temps = REGISTER_TEMP_DESTRUCTOR(symnode, EXPR_W(node, EXPR_TYPE), SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS));
            SCOPE_W(CURRENT_SCOPE, SCOPE_TEMPS) = temps;
        }
    } else
        first = COPY_EXPR_TREE(other);
    u16 pointer = MAKE_POINTER_TYPE(EXPR_W(node, EXPR_TYPE), 0x0F, 0);
    u16 address = MAKE_ADDRESS_OF(first);
    u16 second = ANALYZE_EXPRESSION(MAKE_CAST_NODE(pointer, address), 0, 0);
    u16 list = MAKE_LIST_NODE(COPY_EXPR_TREE(second), EXPR_W(node, EXPR_RIGHT));
    EXPR_W(node, EXPR_RIGHT) = list;
    EXPR_B(EXPR_W(node, EXPR_RIGHT), EXPR_NODE_FLAGS) |= 1;
    return ANALYZE_EXPRESSION(MAKE_UNARY_NODE(0x18, JOIN_COMMA_EXPR(node, second)), 0, 0);
}

/* checks and converts the arguments of a call node; other is a destination for a
   returned structure, or 0.  Returns the analysed call, possibly expanded inline or
   wrapped by C5VALUE.  Wrong counts give "Extra parameter" (60h, 61h with a name) and
   "Too few parameters" (2Dh, 2Eh). */
u16 CHECK_CALL_ARGUMENTS(u16 expression, u16 other)
{
    u16 node = expression;
    if (EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_OP) == 0)
        return REPORT_EXPR_ERROR_PLAIN(0, node);

    u16 mark = scratch_mark();
    farptr out = scratch_alloc(8);          /* selected, restricted, symbol, type */
    C5CHECK(node, out, fp_add(out, 2), fp_add(out, 4), fp_add(out, 6));
    u16 selected = W(out), symbol = W(fp_add(out, 4)), type = W(fp_add(out, 6));
    u8 restricted = B(fp_add(out, 2));
    scratch_release(mark);

    if (!CPP_MODE && (TYPE_B(type, TYPE_FUNC_FLAGS) & 8)) {
        if (symbol) {
            if (!builtin(symbol))
                REPORT_DIAGNOSTIC(MSG_CALL_FUNCTION_NO, (i32)SYMBOL_NAME_TEXT(symbol), 0);
        } else
            REPORT_CURRENT_TOKEN(MSG_CALL_FUNCTION_NO_360);
    }
    u8 warned = (TYPE_B(type, TYPE_FUNC_FLAGS) & 4) || (TYPE_B(type, TYPE_FUNC_FLAGS) & 8);
    u16 parameters = (TYPE_B(type, TYPE_FUNC_FLAGS) & 8) ? 0 : TYPE_W(type, TYPE_PARAMS);
    u16 argument = EXPR_W(node, EXPR_RIGHT);
    if (TYPE_SIZE(EXPR_W(node, EXPR_TYPE)) == 0 && EXPR_W(node, EXPR_TYPE) != VOID_TYPE && KIND_OF(node) != TK_UNDEFINED)
        return REPORT_EXPR_ERROR_PLAIN(MSG_SIZE_THIS_EXPRESSION, node);
    if (CPP_MODE && !argument) {
        argument = DEFAULT_ARGUMENT(parameters);
        EXPR_W(node, EXPR_RIGHT) = argument;
    }
    /* position counts arguments for messages; a member function's first argument is the
       object, so counting starts at 0 (or -1 for a constructor of a class with virtual
       bases, which probably gets one more hidden argument) */
    i16 position = 1;
    if (CPP_MODE && TYPE_W(type, TYPE_MEMBER_CLASS)) {
        position = 0;
        if (symbol && SYM_W(symbol, SYM_FUNC_KIND) == 3 &&
            (TAG_W(TYPE_W(TYPE_W(type, TYPE_MEMBER_CLASS), TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 4))
            position = -1;
    }
    while (argument) {
        EXPR_B(argument, EXPR_NODE_FLAGS) |= 1;
        if (!parameters) {
            if (!warned) {
                i32 text = 0;
                u16 error = 0x60;
                if (symbol) {
                    error = 0x61;
                    text = symbol_text(symbol);
                }
                REPORT_DIAGNOSTIC_AT((i16)error, text, 0, EXPR_W(EXPR_W(argument, EXPR_RIGHT), EXPR_SRC_LINE), 0);
                warned = 1;
            }
            if (!symbol || !builtin(symbol)) {
                u16 wrapped = C5WRAP(EXPR_W(argument, EXPR_RIGHT));
                EXPR_W(argument, EXPR_RIGHT) = wrapped;
            }
        } else {
            u16 converted = CPP_MODE ? CONVERT_ARGUMENT(EXPR_W(argument, EXPR_RIGHT), parameters, symbol, position)
                                     : C5ARG(EXPR_W(argument, EXPR_RIGHT), parameters, symbol, position);
            EXPR_W(argument, EXPR_RIGHT) = converted;
        }
        if (FLAGS_OF(EXPR_W(argument, EXPR_RIGHT)) & 0x40)
            REPORT_DIAGNOSTIC_AT(MSG_STRUCTURE_PASSED_VALUE, 0, 0, EXPR_W(EXPR_W(argument, EXPR_RIGHT), EXPR_SRC_LINE), 0);
        if (parameters)
            parameters = FORMAL_W(parameters, FORMAL_NEXT);
        if (CPP_MODE && !EXPR_W(argument, EXPR_LEFT)) {
            u16 next = DEFAULT_ARGUMENT(parameters);
            EXPR_W(argument, EXPR_LEFT) = next;
        }
        argument = EXPR_W(argument, EXPR_LEFT);
        ++position;
    }
    /* parameters left over: too few arguments */
    if (parameters) {
        i32 text = 0;
        u16 error = 0x2D;
        if (symbol) {
            error = 0x2E;
            text = symbol_text(symbol);
        }
        node = REPORT_EXPR_ERROR(error, (farptr)text, 0, node);
    }
    EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
    u16 result_type = EXPR_W(node, EXPR_TYPE);
    if (restricted && EXPR_W(node, EXPR_OP) == 0x36 && NO_ERRORS_YET) {
        ++SUPPRESS_WARNINGS_DEPTH;
        node = EXPAND_INLINE_CALL(node);
        --SUPPRESS_WARNINGS_DEPTH;
    } else if ((EXPR_FLAGS_AT(TYPE_W(result_type, TYPE_KIND)) & 0x40) ||
               ((int)((EXPR_FLAGS_AT(TYPE_W(result_type, TYPE_KIND)) & 0x14) &&
                 TYPE_W(TYPE_W(result_type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION) &
                (int)(TYPE_W(result_type, TYPE_KIND) == TK_NEAR_PTR && TYPE_B(result_type, TYPE_PTR_MODE) == 0x0B)))
        node = C5VALUE(node, other);
    return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(selected, node), 0, 0);
}

/* the entry point for a call node; other as in CHECK_CALL_ARGUMENTS */
u16 ANALYZE_CALL(u16 expression, u16 other)
{
    u16 node = expression;
    u16 left = ANALYZE_EXPRESSION(EXPR_W(node, EXPR_LEFT), 0, 0);
    EXPR_W(node, EXPR_LEFT) = left;
    u16 selected = 0;
    if (CPP_MODE) {
        u16 mark = scratch_mark();
        farptr sp = scratch_alloc(2);
        W(sp) = 0;
        node = PREPARE_CALL(node, sp);
        selected = W(sp);
        scratch_release(mark);
    }
    u16 type = EXPR_W(EXPR_W(node, EXPR_LEFT), EXPR_TYPE);
    if (TYPE_W(type, TYPE_KIND) != TK_FUNCTION &&
        !((EXPR_FLAGS_AT(TYPE_W(type, TYPE_KIND)) & 0x14) && TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_KIND) == TK_FUNCTION) &&
        TYPE_W(type, TYPE_KIND) != TK_UNDEFINED)
        return REPORT_EXPR_ERROR_PLAIN(MSG_CALL_NONFUNCTION, node);
    if (EXPR_W(node, EXPR_OP) == 0x36)
        node = CHECK_CALL_ARGUMENTS(node, other);
    return ANALYZE_EXPRESSION(JOIN_COMMA_EXPR(selected, node), 0, 0);
}
