/* cppexpr.c: from bcc20/src/cpp/CPPEXPR.C: the C++ parts of the expression parser (OPPREC.C
   calls these while reading an expression): the member name after '.' or '->', names
   qualified with '::', T(args) for a type T, and new expressions.  They only parse and
   build nodes; the meaning is worked out later by expression analysis.  Member names are
   member-name nodes made by MAKE_MEMBER_NAME_NODE(name, kind) with kind 0 identifier, 1
   operator function, 2 conversion function (its target type in EXPR_SCOPE_CLASS), 4
   destructor; EXPR_RIGHT holds the qualifying class of X::name.  Declaration specifiers
   inside these constructs must be plain types.  The locals passed by address live in the
   scratch area in the original frame's layout. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define CURRENT_TOKEN_VALUE W(CURRENT_TOKEN_VALUE_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define LANGUAGE_MODE B(LANGUAGE_MODE_P)
#define TOKEN_RECORD_SIZE 19

static u16 peek_kind(void)
{
    PEEK_TOKEN();
    return TOKEN_TYPE;
}

/* the plain-type check after the declaration specifiers of these constructs */
static void check_specifiers(farptr code, farptr first, farptr second)
{
    if (W(code) != 0x82 || B(first) || B(second))
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258,
                          (i32)(B(first) ? STR_FRIEND_2_P : B(second) ? STR_VIRTUAL_2_P : NAME_TEXT_COPY(TOKEN_NAMES_AT(W(code)))), 0);
}

/* what follows '.' or '->': a member-name node stored in EXPR_RIGHT of node: [X::]name,
   [X::]~X (checked against the class name), operator op (op must be overloadable: TYPE_FLAGS
   400h; '()' and '[]' take their closing token) or operator type.  Returns node */
u16 PARSE_MEMBER_SELECTOR(u16 node)
{
    /* the original frame from BP-18h */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x18);
    farptr third = fp_add(v, 1), second = fp_add(v, 2), first = fp_add(v, 3), spec = fp_add(v, 4);
    farptr fourth_value = fp_add(v, 8), third_value = fp_add(v, 0x0A), second_value = fp_add(v, 0x0C);
    farptr code = fp_add(v, 0x0E), value = fp_add(v, 0x10), context = fp_add(v, 0x12);
    u8 bad = 0;
    u16 scope = 0, result;
    if (CURRENT_TOKEN == TOK_IDENT && peek_kind() == 0x67) {
        scope = BCC_TYPE_RESOLVE_NAME();
        ADVANCE_TOKEN();
        ADVANCE_TOKEN();
    }
    if (scope && CURRENT_TOKEN == TOK_TILDE) {
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN != TOK_IDENT) {
            scratch_release(mark);
            return REPORT_EXPR_ERROR_PLAIN(MSG_EXPRESSION_SYNTAX, 0);
        }
        u16 type = BCC_TYPE_PRIMARY(CURRENT_TOKEN_VALUE);
        if (!type)
            type = BCC_TYPE_PRIMARY(CURRENT_TOKEN_VALUE);
        if (!type || ((SYM_B(type, SYM_STORAGE_CLASS) >> 3) != 11 && (SYM_B(type, SYM_STORAGE_CLASS) >> 3) != 8) ||
            !TYPES_COMPATIBLE(SYM_W(type, SYM_TYPE), scope, 1)) {
            scratch_release(mark);
            return REPORT_EXPR_ERROR_PLAIN(MSG_DESTRUCTOR_NAME_MUST, 0);
        }
        result = MAKE_MEMBER_NAME_NODE(DTOR_NAME, 4);
        ADVANCE_TOKEN();
    } else if (CURRENT_TOKEN == TOK_IDENT || CURRENT_TOKEN == TOK_OPERATOR) {
        if (CURRENT_TOKEN == TOK_IDENT)
            result = MAKE_MEMBER_NAME_NODE(CURRENT_TOKEN_VALUE, 0);
        else {
            ADVANCE_TOKEN();
            if (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) && peek_kind() != 0x67) {
                W(context) = INT_TYPE;
                PARSE_DECL_SPECIFIERS(6, code, first, second, context, spec, third);
                check_specifiers(code, first, second);
                PARSE_DECLARATOR(W(context), 6, value, second_value, third_value, fourth_value, spec, spec);
                result = MAKE_MEMBER_NAME_NODE(CONVERSION_FUNC_NAME, 2);
                EXPR_W(result, EXPR_SCOPE_CLASS) = W(value);
                goto check;
            }
            result = MAKE_MEMBER_NAME_NODE(TOKEN_NAMES_AT(W(CURRENT_TOKEN_RECORD_P)), 1);
            if (CURRENT_TOKEN == TOK_LPAREN) {
                ADVANCE_TOKEN();
                if (CURRENT_TOKEN != TOK_RPAREN)
                    REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
            } else if (CURRENT_TOKEN == TOK_LBRACKET) {
                ADVANCE_TOKEN();
                if (CURRENT_TOKEN != TOK_RBRACKET)
                    REPORT_DIAGNOSTIC(MSG_MISSING, (i32)STR_OPERATOR_P, 0);
            } else if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x400)) {
                REPORT_CURRENT_TOKEN(MSG_OVERLOADABLE_OPERATOR);
                bad = 1;
            }
        }
        ADVANCE_TOKEN();
check:
        if (bad)
            result = REPORT_EXPR_ERROR_PLAIN(0, result);
        else
            EXPR_W(result, EXPR_RIGHT) = scope;
    } else
        result = REPORT_EXPR_ERROR_PLAIN(MSG_FIELD_IDENTIFIER, 0);
    EXPR_W(node, EXPR_RIGHT) = result;
    scratch_release(mark);
    return node;
}

/* a primary name: identifier, X::name, ::name, operator op or operator type; returns its
   node.  ("destructor" is set when a '::' is seen.)  ::name searches the global scope;
   X::name the class X (inherited when X is a base of the current class); a plain name the
   open scopes, then the members of CURRENT_CLASS_TYPE (inherited), then the global scope.
   A name that is not a member goes to BUILD_IDENTIFIER_NODE.  A member gives a field
   reference (data member), an int constant (enumerator), a symbol node (static member or
   function; a conversion function chosen by its target type).  Inside a member function a
   member of the current class or its bases becomes this->member (node flag 2); a data
   member used in a function without this is an error.  Access is checked here only for
   enumerators and static members.  With MACRO_MODE and LANGUAGE_MODE both set, lookup
   results are ignored */
u16 PARSE_QUALIFIED_NAME(void)
{
    /* the original frame from BP-3Ah: token at 0 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x3A);
    farptr token = v, third = fp_add(v, 0x15), second = fp_add(v, 0x16), first = fp_add(v, 0x17);
    farptr spec = fp_add(v, 0x18), fourth_value = fp_add(v, 0x1C), third_value = fp_add(v, 0x1E);
    farptr second_value = fp_add(v, 0x20), code = fp_add(v, 0x22), context = fp_add(v, 0x24);
    farptr conversion = fp_add(v, 0x2C);
    u8 inherited = 0, destructor;
    u16 scope = 0, kind = 0, name, result = 0, type, member;
    u16 where_first = 0, where_second = 0, where_third = 0;
    W(conversion) = 0;
    if (CURRENT_TOKEN == TOK_IDENT && peek_kind() == 0x67) {
        scope = BCC_TYPE_RESOLVE_NAME();
        ADVANCE_TOKEN();
    }
    destructor = 0;
    if (CURRENT_TOKEN == TOK_SCOPE) {
        destructor = 1;
        ADVANCE_TOKEN();
    }
    name = 0;
    if (CURRENT_TOKEN == TOK_OPERATOR) {
        ADVANCE_TOKEN();
        if (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) && peek_kind() != 0x67) {
            kind = 2;
            for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
                B(fp_add(token, i)) = B(fp_add(CURRENT_TOKEN_RECORD_P, i));
            where_first = CURRENT_TOKEN_FILE;
            where_second = CURRENT_TOKEN_LINE;
            where_third = CURRENT_TOKEN_LOC_WORD3;
            W(token) = 0x37;
            name = CONVERSION_FUNC_NAME;
            W(context) = INT_TYPE;
            PARSE_DECL_SPECIFIERS(6, code, first, second, context, spec, third);
            check_specifiers(code, first, second);
            PARSE_DECLARATOR(W(context), 6, conversion, second_value, third_value, fourth_value, spec, spec);
        } else {
            kind = 1;
            name = TOKEN_NAMES_AT(W(CURRENT_TOKEN_RECORD_P));
            for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
                B(fp_add(token, i)) = B(fp_add(CURRENT_TOKEN_RECORD_P, i));
            where_first = CURRENT_TOKEN_FILE;
            where_second = CURRENT_TOKEN_LINE;
            where_third = CURRENT_TOKEN_LOC_WORD3;
            if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x400))
                REPORT_CURRENT_TOKEN(MSG_OVERLOADABLE_OPERATOR);
            else if (CURRENT_TOKEN == TOK_LBRACKET || CURRENT_TOKEN == TOK_LPAREN) {
                if (CURRENT_TOKEN == TOK_LBRACKET && peek_kind() != 4)
                    REPORT_DIAGNOSTIC(MSG_MISSING, (i32)STR_OPERATOR_2_P, 0);
                else if (CURRENT_TOKEN == TOK_LPAREN && peek_kind() != 2)
                    REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
                else
                    ADVANCE_TOKEN();
            }
            ADVANCE_TOKEN();
        }
    } else if (CURRENT_TOKEN == TOK_IDENT) {
        name = CURRENT_TOKEN_VALUE;
        for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
            B(fp_add(token, i)) = B(fp_add(CURRENT_TOKEN_RECORD_P, i));
        where_first = CURRENT_TOKEN_FILE;
        where_second = CURRENT_TOKEN_LINE;
        where_third = CURRENT_TOKEN_LOC_WORD3;
        ADVANCE_TOKEN();
    } else
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);

    type = 0;
    member = 0;
    if (!name) {
        result = REPORT_EXPR_ERROR_PLAIN(0, 0);
        goto done;
    }
    if (destructor) {
        if (!scope)
            type = FIND_NAME_IN_LIST(name, SCOPE_W(GLOBAL_SCOPE, SCOPE_NAMES));
        else {
            member = FIND_MEMBER_REPORT(name, scope);
            if (CURRENT_CLASS_TYPE)
                inherited = IS_BASE_CLASS(scope, CURRENT_CLASS_TYPE, 0);
        }
    } else {
        type = (u16)FIND_SYMBOL_IN_SCOPES(name);
        if (!type && CURRENT_CLASS_TYPE) {
            member = FIND_MEMBER_REPORT(name, CURRENT_CLASS_TYPE);
            inherited = member != 0;
        }
        if (!type && !inherited)
            type = FIND_NAME_IN_LIST(name, SCOPE_W(GLOBAL_SCOPE, SCOPE_NAMES));
    }
    if (MACRO_MODE && LANGUAGE_MODE)
        type = 0;
    if (!member && !scope) {
        result = BUILD_IDENTIFIER_NODE(type, token, where_third, where_second, where_first);
        goto done;
    }
    if (!member) {
        REPORT_DIAGNOSTIC(MSG_UNDEFINED_SYMBOL, (i32)FORMAT_MEMBER_NAME(name, kind, scope, W(conversion)), 0);
        result = REPORT_EXPR_ERROR_PLAIN(0, 0);
        goto done;
    }
    if (W(conversion)) {
        for (type = MEMBER_W(member, MEMB_VALUE); type && TYPE_W(SYM_W(type, SYM_TYPE), TYPE_TARGET) != W(conversion);
             type = SYM_W(type, SYM_NEXT_OVERLOAD))
            ;
        if (!type) {
            W(context) = !scope ? CURRENT_CLASS_TYPE : scope;
            W(code) = CREATE_TYPE(0x12);
            TYPE_W(W(code), TYPE_TARGET) = W(conversion);
            farptr text = FORMAT_MEMBER_NAME(MEMBER_W(member, MEMB_NAME), 2, W(code), W(context));  /* pascal */
            i32 class_name = FORMAT_TYPE(W(context));
            REPORT_DIAGNOSTIC(MSG_NOT_MEMBER, (i32)text, class_name);
            result = REPORT_EXPR_ERROR_PLAIN(0, 0);
            goto done;
        }
        member = 0;
        result = MAKE_SYMBOL_NODE(type);
        EXPR_W(result, EXPR_SCOPE_CLASS) = scope;
    } else
        switch (MEMBER_B(member, MEMB_FLAGS) & 3) {
        case 0:
            if (!CTOR_THIS_SYMBOL && BCC_TREE_SPECIAL && inherited) {
                REPORT_NAME_DIAGNOSTIC(MSG_CANNOT_USED_STATIC, MEMBER_W(member, MEMB_NAME));
                result = REPORT_EXPR_ERROR_PLAIN(0, 0);
                goto done;
            }
            result = MAKE_FIELD_REF_NODE(member);
            EXPR_W(result, EXPR_RIGHT) = scope;
            break;
        case 1:
            result = MAKE_INT_CONSTANT(MEMBER_W(member, MEMB_TYPE), (i16)MEMBER_W(member, MEMB_VALUE));
            inherited = 0;
            if (!MEMBER_ACCESSIBLE(member, CURRENT_CLASS_TYPE))
                REPORT_DIAGNOSTIC(0xB6, FORMAT_MEMBER(member), 0);
            break;
        case 2:
            inherited = 0;
            result = MAKE_SYMBOL_NODE(MEMBER_W(member, MEMB_VALUE));
            if (!MEMBER_ACCESSIBLE(member, CURRENT_CLASS_TYPE))
                REPORT_DIAGNOSTIC(0xB6, FORMAT_MEMBER(member), 0);
            break;
        case 3:
            if (!CTOR_THIS_SYMBOL || !inherited) {
                result = MAKE_SYMBOL_NODE(MEMBER_W(member, MEMB_VALUE));
                EXPR_W(result, EXPR_SCOPE_CLASS) = scope;
            } else {
                result = MAKE_FIELD_REF_NODE(member);
                EXPR_W(result, EXPR_RIGHT) = scope;
            }
            break;
        }
    if (inherited && CTOR_THIS_SYMBOL) {
        u16 self = MAKE_SYMBOL_NODE(CTOR_THIS_SYMBOL);
        result = MAKE_BINARY_NODE(0x2F, self, result);
        EXPR_B(result, EXPR_NODE_FLAGS) |= 2;
    }
done:
    scratch_release(mark);
    return result;
}

/* T(args), a type name used like a function: a temporary-object node (op 37h, EXPR_TYPE
   T, EXPR_RIGHT the arguments); with exactly one argument a cast (op 35h) of that argument
   instead */
u16 PARSE_TYPE_CONSTRUCTOR_CALL(void)
{
    /* the original frame from BP-0Ch */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x0C);
    farptr third = fp_add(v, 1), second = fp_add(v, 2), first = fp_add(v, 3), spec = fp_add(v, 4);
    farptr context = fp_add(v, 8), code = fp_add(v, 0x0A);
    W(context) = INT_TYPE;
    PARSE_DECL_SPECIFIERS(3, code, first, second, context, spec, third);
    check_specifiers(code, first, second);
    u16 initializer = PARSE_ARGUMENT_LIST(0);
    u16 expression = MAKE_BINARY_NODE(1, 0, initializer);
    EXPR_W(expression, EXPR_OP) = 0x37;
    EXPR_W(expression, EXPR_TYPE) = W(context);
    if (initializer && EXPR_W(initializer, EXPR_LEFT) == 0) {
        EXPR_W(expression, EXPR_OP) = 0x35;
        EXPR_W(expression, EXPR_LEFT) = EXPR_W(initializer, EXPR_RIGHT);
        EXPR_W(expression, EXPR_RIGHT) = 0;
        FREE_EXPR_NODE(initializer);
    }
    scratch_release(mark);
    return expression;
}

/* [::]new [(placement)] type [(initializers)], the current token being '::' or new.  Two
   nodes made with token 6Ch: the outer one is EXPR_RIGHT of the inner one and holds the
   placement list (left) and the initializer list (right); the inner node has EXPR_TYPE the
   allocated type and EXPR_LEFT the array dimension (an expression for new T[n], else 0).
   ::new clears node flag 20h on the inner node.  new (T) is told apart from placement
   arguments by IS_PAREN_TYPE_NAME */
u16 PARSE_NEW_EXPRESSION(void)
{
    u16 outer = MAKE_BINARY_NODE(0x6C, 0, 0);
    u16 inner = MAKE_BINARY_NODE(0x6C, 0, outer);
    u16 type;
    if (CURRENT_TOKEN == TOK_SCOPE) {
        ADVANCE_TOKEN();
        EXPR_B(inner, EXPR_NODE_FLAGS) &= 0xDF;
    }
    ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_LPAREN && !IS_PAREN_TYPE_NAME(4)) {
        u16 placement = PARSE_ARGUMENT_LIST(0);
        EXPR_W(outer, EXPR_LEFT) = placement;
    }
    if (CURRENT_TOKEN == TOK_LPAREN) {
        ADVANCE_TOKEN();
        type = PARSE_TYPE_NAME(5);
        REQUIRE_TOKEN_BODY(2, 0xE9);
    } else
        type = PARSE_TYPE_NAME(4);
    if (TYPE_W(type, TYPE_KIND) == TK_ARRAY) {
        u16 dimension = (TYPE_B(type, TYPE_ATTRS) & 0x20) ? TYPE_W(type, TYPE_DIM_EXPR)
                                                          : MAKE_INT_CONSTANT(INT_TYPE, TYPE_L(type, TYPE_ARRAY_COUNT));
        EXPR_W(inner, EXPR_LEFT) = dimension;
        type = TYPE_W(type, TYPE_TARGET);
    } else
        EXPR_W(inner, EXPR_LEFT) = 0;
    EXPR_W(inner, EXPR_TYPE) = type;
    u16 initializers = CURRENT_TOKEN == TOK_LPAREN ? PARSE_ARGUMENT_LIST(0) : 0;
    EXPR_W(outer, EXPR_RIGHT) = initializers;
    return inner;
}
