/* declspec.c: from bcc20/src/parser/DECLSPEC.C: declaration specifiers and declarators for
   the C++ front end (also used for C when CPP_MODE is clear).  PARSE_DECL_SPECIFIERS reads
   the specifiers of a declaration (storage class, friend, virtual, inline, type keywords, a
   typedef name, a struct/union/class/enum specifier) and gives the base type;
   PARSE_DECLARATOR then reads one declarator and gives the full type and the declared
   name.  Unlike the C front end (CDECLR.C), declarators are built directly as type
   records: pointer, array and function types are made from the outside in with the
   innermost slot left open, and ATTACH_DECLARATOR_BASE fills it with the base type.

   Modifiers travel in a three-byte struct C16Spec: calling convention (cdecl 1, pascal 2,
   interrupt 4), distance or segment (_es 1, _cs 2, _ss 3, _ds 4, _seg 7, near 8, far 9,
   huge 10, 11 a member pointer's), and _loadds 2, _saveregs 10h, _export 80h.  It is
   passed by value as two words, the high one (third and a pad byte) first, and
   PARSE_TYPE_MODIFIERS returns it through a buffer whose address the caller passes; the
   type-word record of BUILD_BASIC_TYPE goes as its four words, last first (README,
   structure arguments).  The locals whose addresses are passed on live in the scratch
   area in the original frame's layout.

   Type record offsets: 0 kind (0Dh near pointer, 0Eh _seg pointer, 0Fh far pointer, 10h
   huge pointer, 11h array, 12h function, 13h struct or class, 14h union, 15h enum), 2
   attributes (1 const, 2 volatile, 20h reference or runtime array bound, 40h old-style
   function or far array, 80h distance given explicitly), 3 member class, 5 struct body, 7
   target or result, 9 parameter list or array count, 11 calling convention or member
   pointer class, 12 function flags, 13 pointer segment mode (80h = not yet attached).  CL
   reads the class body record, whose word 24 holds the class flags. */
#include <string.h>
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"
#include "variadic.h"

#define T(n, o) TYPE_W((n), (o))
#define TB(n, o) TYPE_B((n), (o))
#define S(n, o) SYM_W((n), (o))
#define SB_(n, o) SYM_B((n), (o))
#define CL(n, o) TAG_W(T((n), 5), (o))
#define A(n, o) FORMAL_W((n), (o))
#define AB(n, o) FORMAL_B((n), (o))
#define E(n, o) EXPR_W((n), (o))
#define NW(n, o) SCOPE_W((n), (o))
#define LINK(n, o) NAME_W((n), (o))
#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define CURRENT_TOKEN_VALUE D(CURRENT_TOKEN_VALUE_P)
#define ERROR_COUNT W(ERROR_COUNT_P)
#define BCC_TREE_SPECIAL W(BCC_TREE_SPECIAL_P)
#define DEFAULT_CALL_CONVENTION B(DEFAULT_CALL_CONVENTION_P)
#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define MODEL_FAR_CODE B(MODEL_FAR_CODE_P)
#define BCC_TYPE_AT(i) W(fp_add(D(BCC_TYPE_PTR_P), (i) * 2))
#define CTXW(o) W(fp_add(STRUCT_BODY_TYPE_P, (o)))
#define CTXB(o) B(fp_add(STRUCT_BODY_TYPE_P, (o)))
#define CONTEXT_SIZE 44
#define TOKEN_RECORD_SIZE 19

struct Spec { i8 first, second, third; };

static struct Spec spec_at(farptr p)
{
    struct Spec s = { SB(p), SB(fp_add(p, 1)), SB(fp_add(p, 2)) };
    return s;
}

static void store_spec(farptr p, struct Spec s)
{
    SB(p) = s.first;
    SB(fp_add(p, 1)) = s.second;
    SB(fp_add(p, 2)) = s.third;
}

static u16 spec_low(struct Spec s) { return (u8)s.first | (u16)(u8)s.second << 8; }

static u16 peek_kind(void)
{
    PEEK_TOKEN();
    return TOKEN_TYPE;
}

/* the type-word record */
struct Words { u16 primary, sign, size; u8 constant, changing; };

/* an old-style identifier list "f(a, b, c)" up to ')' as FORMAL records with names only
   (types come later, in PARSE_KR_PARAMETERS).  A repeated name is reported */
u16 PARSE_OLD_STYLE_PARAMS(void)
{
    u16 tail = 0, head = 0;
    while (CURRENT_TOKEN == TOK_IDENT) {
        u16 next = ALLOC_FORMAL_RECORD();
        A(next, 4) = (u16)CURRENT_TOKEN_VALUE;
        if (!tail)
            head = next;
        else
            A(tail, 0) = next;
        tail = next;
        u16 node = head;
        while (A(node, 4) != (u16)CURRENT_TOKEN_VALUE)
            node = A(node, 0);
        if (node != tail)
            REPORT_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, (i32)NAME_TEXT_COPY(A(node, 4)), 0);
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN != TOK_RPAREN) {
            if (CURRENT_TOKEN == TOK_COMMA) {
                while (CURRENT_TOKEN == TOK_COMMA) {
                    ADVANCE_TOKEN();
                    if (CURRENT_TOKEN == TOK_RPAREN || CURRENT_TOKEN == TOK_COMMA)
                        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
                }
            } else {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
                IN_ERROR_RECOVERY = 1;
            }
        }
    }
    if (CURRENT_TOKEN != TOK_RPAREN) {
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
        IN_ERROR_RECOVERY = 1;
        SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
    }
    if (CURRENT_TOKEN == TOK_RPAREN)
        ADVANCE_TOKEN();
    return head;
}

/* nonzero if the current token is void or a typedef name for void (the caller then checks
   that ')' follows, for "f(void)") */
u8 IS_VOID_PARAM_LIST(void)
{
    return CURRENT_TOKEN == TOK_VOID ||
           (CURRENT_TOKEN == TOK_IDENT && T(TYPE_LOOKUP((u16)CURRENT_TOKEN_VALUE), 0) == 0x0C);
}

/* a prototype parameter list up to and including ')'.  *head gets the FORMAL list (type,
   name, register flag, and in C++ a default argument checked against the type and stored
   packed), *variadic 1 if it ends in "...".  The parameters are parsed in a scope of their
   own (PARAM_LIST_DEPTH counts nesting).  Arrays and functions become pointers */
void PARSE_PARAM_LIST(farptr head, farptr variadic)
{
    /* the original frame from BP-1Ah */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x1A);
    farptr modifier2 = fp_add(v, 1), modifier1 = fp_add(v, 2), named = fp_add(v, 3);
    farptr scratch = fp_add(v, 4), spec = fp_add(v, 8), scope = fp_add(v, 0x0C), member = fp_add(v, 0x0E);
    farptr name = fp_add(v, 0x12), type = fp_add(v, 0x14), kind = fp_add(v, 0x16);
    u16 saved = PARAM_SCOPE_MARK;
    u16 context = ALLOC_SCOPE();
    NW(context, 0) = CURRENT_SCOPE;
    CURRENT_SCOPE = context;
    ++PARAM_LIST_DEPTH;
    B(variadic) = 0;
    W(head) = 0;
    u16 tail = 0, parameter;
    if (IS_VOID_PARAM_LIST()) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 2) {
            ADVANCE_TOKEN();
            goto parameters_done;
        }
    }
    while (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) && peek_kind() != 0x67) {
        parameter = ALLOC_FORMAL_RECORD();
        W(type) = INT_TYPE;
        PARSE_DECL_SPECIFIERS(0, kind, modifier1, modifier2, type, spec, named);
        if ((W(kind) != 0x82 && W(kind) != 0x38) || B(modifier1) || B(modifier2))
            REPORT_CURRENT_TOKEN(MSG_REGISTER_ONLY_STORAGE);
        PARSE_DECLARATOR(W(type), 1, type, name, member, scope, spec, scratch);
        if (T(W(type), 0) == 0x12)
            W(type) = MAKE_POINTER_TYPE(W(type), 0, 0);
        else if (T(W(type), 0) == 0x11)
            W(type) = MAKE_POINTER_TYPE(T(W(type), 7), (TB(W(type), 2) & 0x40) ? 0x10 : 0, 0);
        if (CPP_MODE && (EXPR_FLAGS_AT(T(W(type), 0)) & 0x40) && (CL(W(type), 24) & 0x80))
            REPORT_DIAGNOSTIC(MSG_CANNOT_CREATE_VARIABLE, CLASS_NAME_OF_TYPE(W(type)), 0);
        A(parameter, 2) = W(type);
        A(parameter, 4) = W(name);
        if (W(name)) {
            if (W(member))
                REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
            if (W(scope))
                REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_CANNOT_HAVE);
        }
        if (CPP_MODE && CURRENT_TOKEN == TOK_ASSIGN) {
            ADVANCE_TOKEN();
            u16 expression = PARSE_ASSIGNMENT_EXPR(2);
            u16 result = ANALYZE_AND_DECAY(COPY_EXPR_TREE(expression), W(type));
            result = NULL_CONSTANT_TO_POINTER(W(type), result);
            if (CANNOT_CONVERT_TYPES(W(type), E(result, 8))) {
                i32 to = FORMAT_TYPE(W(type));              /* pascal: left to right */
                i32 from = FORMAT_TYPE(E(result, 8));
                result = REPORT_EXPR_ERROR(MSG_CANNOT_INITIALIZE, (farptr)to, from, result);
            }
            FREE_EXPR_TREE(result);
            u16 packed = PACK_EXPR_TREE(expression);
            A(parameter, 8) = packed;
            FREE_EXPR_TREE(expression);
        }
        AB(parameter, 6) = W(kind) == 0x38;
        A(parameter, 0) = 0;
        if (!tail)
            W(head) = parameter;
        else
            A(tail, 0) = parameter;
        tail = parameter;
        if (A(parameter, 4)) {
            parameter = W(head);
            while (A(parameter, 4) != W(name))
                parameter = A(parameter, 0);
            if (parameter != tail)
                REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, W(name));
        }
        if (CURRENT_TOKEN != TOK_RPAREN && (CURRENT_TOKEN != TOK_ELLIPSIS || !CPP_MODE)) {
            if (CURRENT_TOKEN == TOK_COMMA) {
                ADVANCE_TOKEN();
                if (CURRENT_TOKEN == TOK_RPAREN)
                    REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
            } else if (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P))
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
            else if (CURRENT_TOKEN != TOK_ELLIPSIS) {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
                IN_ERROR_RECOVERY = 1;
                SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
            }
        }
    }
    A(tail, 0) = 0;
parameters_done:
    if (CURRENT_TOKEN == TOK_ELLIPSIS) {
        B(variadic) = 1;
        ADVANCE_TOKEN();
    }
    if (CURRENT_TOKEN != TOK_RPAREN) {
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
        IN_ERROR_RECOVERY = 1;
        SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
    }
    if (CURRENT_TOKEN == TOK_RPAREN)
        ADVANCE_TOKEN();
    --PARAM_LIST_DEPTH;
    CURRENT_SCOPE = NW(CURRENT_SCOPE, 0);
    PARAM_SCOPE_MARK_AUX = 0;
    PARAM_SCOPE_MARK = saved;
    scratch_release(mark);
}

/* at '*' or '&': a pointer (or, for '&' in C++, reference) type to type.  The pointer kind
   comes from the modifier in spec or, by default, from the memory model.  A string literal
   after '*' names a based pointer's base.  const and volatile after it qualify the pointer.
   Pointers to references are errors */
u16 PARSE_POINTER_DECLARATOR(u16 type, u8 third, u16 low)
{
    struct Spec spec = { (i8)low, (i8)(low >> 8), (i8)third };
    u8 special = 0;
    u16 kind = 0, model;
    if ((EXPR_FLAGS_AT(T(type, 0)) & 0x14) && (TB(type, 13) & 0x80))
        type = FIND_EQUIVALENT_TYPE(type);
    model = T(type, 0) == 0x12 ? 2 : 4;
    switch (spec.second) {
    case 1: case 2: case 3: case 4: case 5: case 6: case 11:
        model = (u16)(i16)spec.second;
        kind = 0x0D;
        break;
    case 9:
        special = 1;
        model = 0;
        kind = 0x0F;
        break;
    case 7:
        model = 0;
        kind = 0x0E;
        break;
    case 10:
        special = 1;
        model = 0;
        kind = 0x10;
        break;
    case 8:
        special = 1;
        kind = 0x0D;
        break;
    case 0:
        if (T(type, 0) == 0x12) {
            u16 flags = TB(type, 12);
            kind = (MODEL_FAR_CODE || (flags & 1)) ? 0x0F : 0x0D;
        } else
            kind = MODEL_FAR_DATA ? 0x0F : 0x0D;
        break;
    }
    u16 result = CREATE_TYPE(kind);
    if ((EXPR_FLAGS_AT(T(type, 0)) & 0x14) && (TB(type, 2) & 0x20))
        REPORT_CURRENT_TOKEN(MSG_CANNOT_DEFINE_POINTER);
    if (CURRENT_TOKEN == TOK_AMPERSAND) {
        if (!CPP_MODE)
            REPORT_CURRENT_TOKEN(MSG_ONLY_ALLOWED_C);
        else {
            TB(result, 2) |= 0x20;
            if (T(type, 0) == 0x0C)
                REPORT_WARNING(MSG_VOID_NOT_VALID_TYPE);
        }
    }
    if (special)
        TB(result, 2) |= 0x80;
    T(result, 7) = type;
    T(result, 9) = 0;
    TB(result, 13) = (u8)model | 0x80;
    T(result, 11) = 0;
    ADVANCE_TOKEN();
    if (CURRENT_TOKEN == 0x34) {
        if (kind == 0x0D) {
            u16 base = FLUSH_PENDING_POOL();
            T(result, 9) = base;
            STRING_TOKEN_PENDING = 0;
        }
        ADVANCE_TOKEN();
    }
    while (CURRENT_TOKEN == TOK_CONST || CURRENT_TOKEN == TOK_VOLATILE) {
        if (CURRENT_TOKEN == TOK_CONST) {
            if (TB(result, 2) & 1)
                REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
            TB(result, 2) |= 1;
        } else {
            if (TB(result, 2) & 2)
                REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
            TB(result, 2) |= 2;
        }
        ADVANCE_TOKEN();
    }
    return result;
}

/* at '[': an array type.  runtime nonzero (in a new expression) allows a non-constant
   bound, kept as an expression with attribute 20h; otherwise the bound must be a positive
   constant (zero is allowed in C).  Further [] or () suffixes are parsed first, as they
   bind to the element.  huge (spec.second 10) marks the array far (attribute 40h); class
   flags 4 and 8 are copied from the element type */
u16 PARSE_ARRAY_DECLARATOR(u8 runtime, u16 type, u8 third, u16 low)
{
    struct Spec spec = { (i8)low, (i8)(low >> 8), (i8)third };
    u16 mark = scratch_mark();
    farptr count = scratch_alloc(4);
    u8 expression_bound = 0, count_unset = 0;
    u16 expression = 0;
    if ((EXPR_FLAGS_AT(T(type, 0)) & 0x14) && (TB(type, 2) & 0x20))
        REPORT_CURRENT_TOKEN(MSG_ARRAY_REFERENCES_NOT);
    ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_RBRACKET)
        SD(count) = 0;
    else if (runtime) {
        expression = PARSE_ASSIGNMENT_EXPR(4);
        expression_bound = 1;
    } else {
        /* after an error CONST_EXPR_VALUE_BODY leaves count as it was, and the original
           never set it: a stack slot holding whatever an earlier call left.  Over the
           corpus a small positive value gives the original's follow-on messages in every
           case but one (where the slot held a huge value); the port starts it at 2 */
        SD(count) = 2;
        UNSET_BYTES(count, 4);
        u16 errors = ERROR_COUNT;
        CONST_EXPR_VALUE_BODY(4, count);
        count_unset = ERROR_COUNT != errors && SD(count) == 2;   /* still the preset */
        if (SD(count) < 0 || (SD(count) == 0 && CPP_MODE)) {
            REPORT_CURRENT_TOKEN(MSG_ARRAY_MUST_HAVE_LEAST);
            SD(count) = 1;
        }
    }
    if (CURRENT_TOKEN == TOK_RBRACKET)
        ADVANCE_TOKEN();
    else
        REPORT_DIAGNOSTIC(MSG_MISSING, (i32)STR_ARRAY_BOUNDS_P, 0);
    if (CURRENT_TOKEN == TOK_LBRACKET)
        type = PARSE_ARRAY_DECLARATOR(0, type, (u8)spec.third, spec_low(spec));
    else if (CURRENT_TOKEN == TOK_LPAREN && !runtime)
        type = PARSE_FUNCTION_DECLARATOR(type, (u8)spec.third, spec_low(spec));
    u16 result = CREATE_TYPE(0x11);
    T(result, 7) = type;
    if (expression_bound) {
        TB(result, 2) |= 0x20;
        T(result, 13) = expression;
        T(result, 11) = 0;
        T(result, 9) = 0;
    } else {
        TYPE_L(result, TYPE_PARAMS) = SD(count);
        if (count_unset)
            UNSET_RESULT(MK_FP(TYPE_POOL, result + TYPE_PARAMS), 4);
    }
    if (spec.second == 10)
        TB(result, 2) |= 0x40;
    if (TB(type, 2) & 4)
        TB(result, 2) |= 4;
    if (TB(type, 2) & 8)
        TB(result, 2) |= 8;
    scratch_release(mark);
    return result;
}

/* at '(': a function type with its parameter list.  "()" is an unprototyped function in C
   (flag 8) but an empty list in C++; an identifier list is old style (attribute 40h, a
   warning in C++).  The function's distance comes from spec or the memory model (flags 40h
   near, 1 far, 3 huge; interrupt functions are far), its calling convention from spec or
   DEFAULT_CALL_CONVENTION.  In C++ trailing const or volatile qualify a member function */
u16 PARSE_FUNCTION_DECLARATOR(u16 type, u8 third, u16 low)
{
    struct Spec spec = { (i8)low, (i8)(low >> 8), (i8)third };
    /* the original frame from BP-4: variadic at 1, parameters at 2 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(4);
    farptr variadic = fp_add(v, 1), parameters = fp_add(v, 2);
    ADVANCE_TOKEN();
    W(parameters) = 0;
    B(variadic) = 0;
    u8 unspecified = 0, old_style = 0;
    if (CPP_MODE && CURRENT_TOKEN == TOK_ELLIPSIS) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 2) {
            ADVANCE_TOKEN();
            ADVANCE_TOKEN();
            B(variadic) = 1;
            goto parameters_done;
        }
    }
    if (!CPP_MODE && CURRENT_TOKEN == TOK_RPAREN) {
        unspecified = 1;
        ADVANCE_TOKEN();
    } else if (CURRENT_TOKEN == TOK_IDENT && !TYPE_LOOKUP((u16)CURRENT_TOKEN_VALUE)) {
        if (CPP_MODE)
            REPORT_CURRENT_TOKEN(MSG_STYLE_FUNCTION);
        W(parameters) = PARSE_OLD_STYLE_PARAMS();
        old_style = 1;
    } else
        PARSE_PARAM_LIST(parameters, variadic);
parameters_done:
    if (CURRENT_TOKEN == TOK_LBRACKET)
        type = PARSE_ARRAY_DECLARATOR(0, type, third, low);
    else if (CURRENT_TOKEN == TOK_LPAREN)
        type = PARSE_FUNCTION_DECLARATOR(type, third, low);
    u16 result = CREATE_TYPE(0x12);
    T(result, 7) = type;
    T(result, 9) = W(parameters);
    u16 flags = (u16)(i16)spec.third;
    switch (spec.second) {
    case 0:
    case 11:
        if (OPTION_MEMORY_MODEL == 5)
            flags |= 3;
        else
            flags |= MODEL_FAR_CODE ? 1 : 0x40;
        break;
    case 8:
        flags |= 0x40;
        TB(result, 2) |= 0x80;
        break;
    case 9:
        flags |= 1;
        TB(result, 2) |= 0x80;
        break;
    case 10:
        flags |= 3;
        TB(result, 2) |= 0x80;
        break;
    }
    TB(result, 11) = spec.first ? (u8)spec.first : DEFAULT_CALL_CONVENTION;
    if (spec.first == 4) {
        flags &= 0xFFBF;
        flags |= 3;
    }
    if (unspecified)
        flags |= 8;
    if (old_style)
        TB(result, 2) |= 0x40;
    if (B(variadic))
        flags |= 4;
    if (CPP_MODE) {
        while (CURRENT_TOKEN == TOK_CONST || CURRENT_TOKEN == TOK_VOLATILE) {
            TB(result, 2) |= CURRENT_TOKEN == TOK_CONST ? 1 : 2;
            ADVANCE_TOKEN();
        }
    }
    TB(result, 12) = (u8)flags;
    scratch_release(mark);
    return result;
}

/* walks to the innermost type of the declarator chain and makes base its target, then
   applies the rules that depend on the base: pointers to members become near pointers with
   mode 0Bh, a pointer's explicit distance moves onto a function base and the pointer kind
   follows the function's distance, an array above 64K becomes a far array.  Returns the
   outermost type (base itself when declarator is 0) */
u16 ATTACH_DECLARATOR_BASE(u16 declarator, u16 base)
{
    if (!declarator)
        return base;
    base = FIND_EQUIVALENT_TYPE(base);
    u16 result = declarator, next;
    do {
        switch (T(declarator, 0)) {
        case 0x0D: case 0x0E: case 0x0F: case 0x10:
            next = T(declarator, 7);
            TB(declarator, 13) &= 0x7F;
            break;
        case 0x11:
        case 0x12:
            next = T(declarator, 7);
            break;
        default:
            next = 0;
            break;
        }
        if (next)
            declarator = next;
    } while (next);
    switch (T(declarator, 0)) {
    case 0x0E:
        T(declarator, 7) = base;
        if ((CPP_MODE && T(base, 3)) || T(base, 0) == 0x12)
            REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        break;
    case 0x0D:
        T(declarator, 7) = base;
        if ((EXPR_FLAGS_AT(T(base, 0)) & 0x14) && (TB(base, 2) & 0x20))
            REPORT_CURRENT_TOKEN(MSG_CANNOT_DEFINE_POINTER);
        if (CPP_MODE && T(declarator, 11)) {
            if (!T(base, 3)) {
                base = COPY_TYPE_RECORD(base);
                T(declarator, 7) = base;
                T(base, 3) = T(declarator, 11);
                if (T(base, 0) == 0x12)
                    ADD_THIS_PARAMETER(T(declarator, 11), base);
            } else
                REPORT_CURRENT_TOKEN(MSG_MULTIPLE_SCOPE);
        }
        if (CPP_MODE && T(base, 3))
            TB(declarator, 13) = 0x0B;
        else if (T(base, 0) == 0x12) {
            TB(declarator, 13) = 2;
            if (TB(declarator, 2) & 0x80) {
                if (!(TB(base, 2) & 0x80)) {
                    TB(base, 12) &= 0xFE;
                    TB(base, 12) |= 0x40;
                }
            } else if (TB(base, 12) & 1)
                T(declarator, 0) = 0x0F;
        }
        break;
    case 0x0F:
    case 0x10:
        T(declarator, 7) = base;
        if ((EXPR_FLAGS_AT(T(base, 0)) & 0x14) && (TB(base, 2) & 0x20))
            REPORT_CURRENT_TOKEN(MSG_CANNOT_DEFINE_POINTER);
        if (CPP_MODE && T(base, 3)) {
            if (TB(declarator, 2) & 0x80)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            TB(declarator, 13) = 0x0B;
            T(declarator, 0) = 0x0D;
        } else if (T(base, 0) == 0x12) {
            if (TB(declarator, 2) & 0x80) {
                if (!(TB(base, 2) & 0x80)) {
                    TB(base, 12) &= 0xBF;
                    TB(base, 12) |= 1;
                }
            } else if (TB(base, 12) & 0x40) {
                T(declarator, 0) = 0x0D;
                TB(declarator, 13) = 2;
            }
        }
        break;
    case 0x11:
        T(declarator, 7) = base;
        if ((EXPR_FLAGS_AT(T(base, 0)) & 0x14) && (TB(base, 2) & 0x20))
            REPORT_CURRENT_TOKEN(MSG_ARRAY_REFERENCES_NOT);
        TB(declarator, 2) |= TB(base, 2) & 0x0C;
        if (TYPE_SIZE(declarator) > 0xFFFFL)
            TB(declarator, 2) |= 0x40;
        break;
    case 0x12:
        T(declarator, 7) = base;
        break;
    }
    return result;
}

/* a run of modifier keywords, added to a copy of the triple, which is stored at result.
   Two calling conventions, two distances, a repeated flag, or interrupt with near are
   conflicting modifiers.  Returns result's offset, as the original does */
u16 PARSE_TYPE_MODIFIERS(farptr out, u8 third, u16 low)
{
    struct Spec result = { (i8)low, (i8)(low >> 8), (i8)third };
    for (;;) {
        i16 flags = 0, storage = 0, model = 0;
        switch (CURRENT_TOKEN) {
        case TOK_CDECL: storage = 1; break;
        case TOK_PASCAL: storage = 2; break;
        case TOK_INTERRUPT: storage = 4; break;
        case TOK_LOADDS: flags = 2; break;
        case TOK_EXPORT: flags = 0x80; break;
        case TOK_SAVEREGS: flags = 0x10; break;
        case TOK_CS: model = 2; break;
        case TOK_DS: model = 4; break;
        case TOK_ES: model = 1; break;
        case TOK_SS: model = 3; break;
        case TOK_SEG: model = 7; break;
        case TOK_NEAR: model = 8; break;
        case TOK_FAR: model = 9; break;
        case TOK_HUGE: model = 10; break;
        default:
            if (result.first && result.second <= 3 && result.second >= 2)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            store_spec(out, result);
            return FP_OFF(out);
        }
        if ((i16)result.third & flags)
            REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        result.third |= flags;
        if (storage) {
            if (result.first)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            if (storage == 4 && result.second == 8)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            result.first = storage;
        }
        if (model) {
            if (result.second)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            result.second = model;
        }
        ADVANCE_TOKEN();
    }
}

/* PARSE_TYPE_MODIFIERS as a value */
static struct Spec type_modifiers(struct Spec value)
{
    u16 mark = scratch_mark();
    farptr out = scratch_alloc(4);
    PARSE_TYPE_MODIFIERS(out, (u8)value.third, spec_low(value));
    struct Spec result = spec_at(out);
    scratch_release(mark);
    return result;
}

/* one declarator applied to the base type initial.  Outputs: *type the declared type,
   *name the declared name (0 if none), *scope and *owner the qualifying class or scope when
   the name is qualified (C++), *spec the modifiers in force.  mode: 0 an ordinary
   declaration, 1 a parameter, 2 a member, 3 a type name, 4 and 5 the type in a new
   expression (runtime array bounds; in mode 4 no function suffix), 6 only the leading
   pointer part (C++).  In C++ the pointer part is handled by TYPE_PATH, and operator or
   destructor names by TYPE_OPERATOR.  "T x(...)" with T a class may be an object with
   constructor arguments: PARSE_STATE_CHECK decides, and the parentheses are then left for
   the initializer (retain).  Arrays above 64K (16M for far arrays) are errors */
void PARSE_DECLARATOR(u16 initial, u16 mode, farptr type, farptr name, farptr scope, farptr owner, farptr spec,
                      farptr scratch)
{
    /* the original frame from BP-1Ch: pointer at 8, suffix at 0Ch, nested at 10h, current
       at 14h, declarator at 1Ah */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x1C);
    farptr pointer = fp_add(v, 8), suffix = fp_add(v, 0x0C), nested = fp_add(v, 0x10);
    farptr current = fp_add(v, 0x14), declarator = fp_add(v, 0x1A);
    /* the byte after current is the original's retain flag, not yet set when TYPE_PATH reads
       the four bytes at current */
    UNSET_BYTES(fp_add(current, 3), 1);
    u16 base = initial, built;
    W(scope) = 0;
    W(declarator) = 0;
    W(owner) = 0;
    W(name) = 0;
    store_spec(current, spec_at(spec));
    store_spec(suffix, spec_at(EXPR_TEMP2_P));
    if (CPP_MODE) {
        base = TYPE_PATH(base, mode, owner, current, scratch);
        if (mode == 6) {
            W(type) = FIND_EQUIVALENT_TYPE(base);
            store_spec(spec, spec_at(current));
            goto done;
        }
    } else {
        store_spec(current, type_modifiers(spec_at(current)));
        store_spec(pointer, spec_at(current));
        while (CURRENT_TOKEN == TOK_STAR || CURRENT_TOKEN == TOK_AMPERSAND) {
            struct Spec p = spec_at(pointer);
            base = PARSE_POINTER_DECLARATOR(base, (u8)p.third, spec_low(p));
            store_spec(pointer, type_modifiers(spec_at(EXPR_TEMP2_P)));
        }
    }
    store_spec(nested, spec_at(current));
    store_spec(suffix, spec_at(current));
    if (CURRENT_TOKEN == TOK_IDENT && (!mode || mode == 2 || mode == 1)) {
        W(name) = (u16)CURRENT_TOKEN_VALUE;
        W(scope) = 0;
        ADVANCE_TOKEN();
    } else if (CPP_MODE && (CURRENT_TOKEN == TOK_OPERATOR || CURRENT_TOKEN == TOK_TILDE))
        base = TYPE_OPERATOR(FIND_EQUIVALENT_TYPE(base), W(owner), name, scope);
    else if (CURRENT_TOKEN == TOK_LPAREN && mode != 4) {
        PEEK_TOKEN();
        if (TYPE_FLAGS_AT(TOKEN_TYPE) & 0x10) {
            ADVANCE_TOKEN();
            PARSE_DECLARATOR(0, mode, declarator, name, scope, owner, nested, suffix);
            if (!W(declarator)) {
                struct Spec c = spec_at(current), n = spec_at(nested);
                if (n.second) {
                    if (c.second && c.second != n.second)
                        REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
                    else
                        c.second = n.second;
                }
                if (n.first) {
                    if (c.first && c.first != n.first)
                        REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
                    else
                        c.first = n.first;
                }
                if (n.third) {
                    if (c.third && n.third != c.third)
                        REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
                    else
                        c.third = n.third;
                }
                store_spec(current, c);
            }
            if (CURRENT_TOKEN == TOK_RPAREN)
                ADVANCE_TOKEN();
            else {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_233);
                IN_ERROR_RECOVERY = 1;
                SKIP_TO_SYNC_TOKEN(TOK_RPAREN);
            }
        }
    }
    if (CURRENT_TOKEN == TOK_LBRACKET) {
        struct Spec c = spec_at(current);
        u8 runtime = mode == 4 || mode == 5;
        built = PARSE_ARRAY_DECLARATOR(runtime, FIND_EQUIVALENT_TYPE(base), (u8)c.third, spec_low(c));
        if (c.second == 10)
            SB(fp_add(nested, 1)) = 0;
    } else if (CURRENT_TOKEN == TOK_LPAREN) {
        struct Spec s = spec_at(suffix);
        if (CPP_MODE) {
            u8 retain = mode == 4;
            if (!mode && (EXPR_FLAGS_AT(T(initial, 0)) & 0x40))
                retain = W(name) != 0 && W(scope) == 0 && !PARSE_STATE_CHECK();
            built = retain ? base : PARSE_FUNCTION_DECLARATOR(FIND_EQUIVALENT_TYPE(base), (u8)s.third, spec_low(s));
        } else
            built = PARSE_FUNCTION_DECLARATOR(base, (u8)s.third, spec_low(s));
    } else
        built = base;
    W(type) = FIND_EQUIVALENT_TYPE(ATTACH_DECLARATOR_BASE(W(declarator), built));
    store_spec(spec, spec_at(current));
    if (T(W(type), 0) == 0x11 && W(type) != initial) {
        if (TB(W(type), 2) & 0x40) {
            if (TYPE_SIZE(W(type)) > 0xFFFFFFL)
                REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
        } else if (TYPE_SIZE(W(type)) > 0xFFFFL)
            REPORT_CURRENT_TOKEN(MSG_ARRAY_SIZE_TOO_LARGE);
    }
done:
    scratch_release(mark);
}

/* a struct (or union, token 43h) type.  In C++ the class flags record "class" (token 68h)
   and a near, far or huge class (access 4Fh, 50h, 56h) */
u16 NEW_RECORD_TYPE(u16 token, u16 access)
{
    u16 type = CREATE_TYPE(token == 0x43 ? 0x14 : 0x13);
    if (CPP_MODE) {
        if (token == 0x68)
            CL(type, 24) |= 0x20;
        if (access == 0x4F)
            CL(type, 24) |= 0x10;
        else if (access == 0x50)
            CL(type, 24) |= 8;
        else if (access == 0x56)
            CL(type, 24) |= 0x100;
    }
    if (PARAM_LIST_DEPTH)
        REPORT_DIAGNOSTIC(MSG_DECLARE_PRIOR_USE, FORMAT_TYPE(type), 0);
    return type;
}

/* a tag symbol for type (name may be 0 for an anonymous struct), storage class 8,
   name-space kind 2, chained into the list headed at the name record of the keyword
   "struct" */
u16 DECLARE_TAG_SYMBOL(u16 type, u16 name)
{
    u16 result_type = type;
    u16 symbol = ALLOC_SYMBOL_ENTRY(name, 1);
    S(symbol, 4) = result_type;
    if (result_type)
        CL(result_type, 6) = symbol;
    SB_(symbol, 7) = (SB_(symbol, 7) & 7) | 0x40;
    SB_(symbol, 7) = (SB_(symbol, 7) & 0xF8) | 2;
    u16 link = TOKEN_NAMES_AT(TOK_STRUCT);
    S(symbol, 0) = LINK(link, 0);
    LINK(link, 0) = symbol;
    C0MARK(1);
    return symbol;
}

/* an optional tag name; returns the tag symbol.  definition nonzero means a body (or a
   forward declaration "struct S;") follows, so only the current scope is searched;
   otherwise the tag is looked up in all scopes.  Redefining a defined struct, or using a
   non-struct name as a tag, is reported and a fresh tag made (*valid 0 tells the caller to
   skip the body).  A new named tag is declared in the current scope (storage class 11).
   In C++ a struct tag and a typedef of the same name for another type are reported */
u16 LOOKUP_OR_DECLARE_TAG(u16 token, u16 access, u8 definition, farptr valid)
{
    u16 symbol = 0, name = 0, type;
    B(valid) = 1;
    if (CURRENT_TOKEN == TOK_IDENT) {
        name = (u16)CURRENT_TOKEN_VALUE;
        ADVANCE_TOKEN();
    }
    if (name) {
        if (definition)
            symbol = FIND_NAME_IN_LIST(name, NW(CURRENT_SCOPE, 6));
        else
            symbol = BCC_TYPE_PRIMARY(name);
    }
    if (symbol) {
        type = S(symbol, 4);
        if (!(EXPR_FLAGS_AT(T(type, 0)) & 0x40)) {
            REPORT_NAME_DIAGNOSTIC(MSG_MUST_PREVIOUSLY_240, name);
            return DECLARE_TAG_SYMBOL(NEW_RECORD_TYPE(token, access), name);
        }
        if (CL(type, 4) && definition && (!CPP_MODE || CURRENT_TOKEN != TOK_SEMICOLON)) {
            REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, name);
            B(valid) = 0;
            return DECLARE_TAG_SYMBOL(NEW_RECORD_TYPE(token, access), name);
        }
        if (CPP_MODE) {
            if (token == 0x68)
                CL(type, 24) |= 0x20;
            if ((access == 0x4F && (CL(type, 24) & 0x108)) || (access == 0x50 && (CL(type, 24) & 0x110)) ||
                (access == 0x56 && (CL(type, 24) & 0x18)))
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        }
        return symbol;
    }
    type = NEW_RECORD_TYPE(token, access);
    if (name) {
        symbol = DECLARE_TAG(name);
        SB_(symbol, 7) = (SB_(symbol, 7) & 7) | 0x58;
        S(symbol, 4) = type;
        CL(type, 6) = symbol;
    } else
        symbol = DECLARE_TAG_SYMBOL(type, 0);
    if (CPP_MODE && name) {
        u16 previous = FIND_NAME_IN_LIST(name, NW(CURRENT_SCOPE, 4));
        if (previous && (SB_(previous, 7) >> 3) == 8 && S(previous, 4) != type)
            REPORT_NAME_DIAGNOSTIC(MSG_BOTH_STRUCTURE_TAG, S(previous, 2));
    }
    return symbol;
}

/* a struct, union or class specifier after its keyword (with the C++ class modifiers
   near, far, huge, _export first); returns its type.  With a body ('{', or ':' for C++
   base classes) the members are parsed by TYPE_CLOSE with the class being defined in
   STRUCT_BODY_TYPE and CURRENT_CLASS_TYPE; the 44-byte parse state block at
   STRUCT_BODY_TYPE is saved and restored around nested class definitions (BCC_TREE_FLAG
   counts the nesting).  In C++ the compiler-generated members are then declared, unless
   errors occurred (class flag 200h marks a class whose definition had errors) */
u16 PARSE_RECORD_SPECIFIER(u16 token, u8 allow_forward)
{
    u8 saved_context[CONTEXT_SIZE];
    u16 access = 0x82, following;
    u8 virtual_class = 0;
    u16 snapshot = ERROR_COUNT;
    while (CURRENT_TOKEN == TOK_NEAR || CURRENT_TOKEN == TOK_FAR || CURRENT_TOKEN == TOK_HUGE || CURRENT_TOKEN == TOK_EXPORT) {
        if (CURRENT_TOKEN == TOK_NEAR || CURRENT_TOKEN == TOK_FAR || CURRENT_TOKEN == TOK_HUGE)
            access = CURRENT_TOKEN;
        else {
            virtual_class = 1;
            access = 0x56;
        }
        if (!CPP_MODE)
            REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
        ADVANCE_TOKEN();
    }
    if (CURRENT_TOKEN == TOK_IDENT) {
        PEEK_TOKEN();
        following = TOKEN_TYPE;
    } else
        following = CURRENT_TOKEN;
    u8 definition = following == 5 || (CPP_MODE && following == 0x21);
    u16 mark = scratch_mark();
    farptr valid = scratch_alloc(2);
    u16 symbol = LOOKUP_OR_DECLARE_TAG(token, access, definition || (following == 7 && allow_forward), valid);
    u8 is_valid = B(valid);
    scratch_release(mark);
    if (!definition)
        return S(symbol, 4);
    u16 saved_special = BCC_TREE_SPECIAL;
    BCC_TREE_SPECIAL = 0;
    u8 saved = BCC_TREE_FLAG != 0;
    if (BCC_TREE_FLAG++)
        for (int i = 0; i < CONTEXT_SIZE; i++)
            saved_context[i] = B(fp_add(STRUCT_BODY_TYPE_P, i));
    ACTIVE_LIST = symbol;
    STRUCT_BODY_TYPE = S(symbol, 4);
    u16 saved_scope = CURRENT_CLASS_TYPE;
    CURRENT_CLASS_TYPE = STRUCT_BODY_TYPE;
    CLASS_KEY_TOKEN = token;
    CTXW(0x25) = access;
    CTXW(6) = 0;
    CTXW(4) = 0;
    CTXW(8) = 0;
    CTXB(0x2B) = virtual_class;
    if (CPP_MODE)
        TYPE_BASE();
    /* the original's exit for a malformed entry leaves the state as it is */
    if (CURRENT_TOKEN != TOK_LBRACE)
        return STRUCT_BODY_TYPE;
    if (!is_valid) {
        SKIP_BRACE_GROUP();
        IN_ERROR_RECOVERY = 0;
    } else {
        ADVANCE_TOKEN();
        if (!CPP_MODE && !NOT_ANSI_FLAG && CURRENT_TOKEN == TOK_RBRACE)
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
        TYPE_CLOSE();
        if (CPP_MODE && snapshot == ERROR_COUNT)
            DECLARE_IMPLICIT_MEMBERS();
    }
    u16 type = STRUCT_BODY_TYPE;
    if (snapshot != ERROR_COUNT)
        CL(type, 24) |= 0x200;
    if (--BCC_TREE_FLAG) {
        /* match: an inner definition that took the malformed-entry exit above left the
           count raised, so an outer definition that saved nothing (the count was 0 when
           it started) restores its never-written buffer: BCC.EXE's stack garbage.  The
           port leaves the state as it is and marks it unset for the replay (README.md,
           "Decisions for the native build") */
        if (saved)
            for (int i = 0; i < CONTEXT_SIZE; i++)
                B(fp_add(STRUCT_BODY_TYPE_P, i)) = saved_context[i];
        else
            UNSET_RESULT(STRUCT_BODY_TYPE_P, CONTEXT_SIZE);
    }
    CURRENT_CLASS_TYPE = saved_scope;
    BCC_TREE_SPECIAL = saved_special;
    return type;
}

/* an enum specifier after its keyword: a body is built by ENUM_BUILD; "enum name" must
   name an existing enum.  Returns the type or 0 */
u16 PARSE_ENUM_SPECIFIER(void)
{
    u16 mark = scratch_mark();
    farptr token = scratch_alloc(TOKEN_RECORD_SIZE + 1);
    u8 present = 0;
    u16 result = 0;
    if (CURRENT_TOKEN == TOK_IDENT) {
        for (int i = 0; i < TOKEN_RECORD_SIZE; i++)
            B(fp_add(token, i)) = B(fp_add(CURRENT_TOKEN_RECORD_P, i));
        present = 1;
        ADVANCE_TOKEN();
    } else
        UNSET_BYTES(token, TOKEN_RECORD_SIZE);      /* the original passes it unset */
    if (CURRENT_TOKEN == TOK_LBRACE) {
        ENUM_BODY_TREE_FLAG = (u8)BCC_TREE_FLAG;
        result = ENUM_BUILD(token, present);
        if (PARAM_LIST_DEPTH)
            REPORT_DIAGNOSTIC(MSG_DECLARE_PRIOR_USE, FORMAT_TYPE(result), 0);
    } else if (present) {
        u16 symbol = BCC_TYPE_PRIMARY(W(fp_add(token, 9)));
        if (!symbol)
            REPORT_TOKEN_DIAGNOSTIC(token, MSG_UNDEFINED_SYMBOL);
        else if (T(S(symbol, 4), 0) == 0x15)
            result = S(symbol, 4);
        else
            REPORT_TOKEN_DIAGNOSTIC(token, MSG_MUST_PREVIOUSLY_206);
    } else
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    scratch_release(mark);
    return result;
}

/* type with volatile (second) and/or const (first) added.  Basic types (kind 12 and below)
   come from the fixed table C9_TYPE_GRID[2][2][13], others from INTERN_QUALIFIED_TYPE, so
   each qualified type exists once */
u16 ADD_CV_QUALIFIERS(u16 type, u8 second, u8 first)
{
    u16 qualifiers = TB(type, 2) & 3;
    if (second)
        qualifiers |= 2;
    if (first)
        qualifiers |= 1;
    if ((TB(type, 2) & 3) == qualifiers)
        return type;
    if ((i16)T(type, 0) <= 12) {
        i16 row = (qualifiers & 2) ? 0 : 1;
        i16 column = (qualifiers & 1) ? 0 : 1;
        return C9_TYPE_GRID_AT((row * 2 + column) * 13 + T(type, 0));
    }
    return INTERN_QUALIFIED_TYPE(type, qualifiers);
}

/* the unqualified version of type */
u16 STRIP_CV_QUALIFIERS(u16 type)
{
    if (!(TB(type, 2) & 3))
        return type;
    if ((i16)T(type, 0) <= 12)
        return C9_TYPE_GRID_AT(3 * 13 + T(type, 0));
    return INTERN_QUALIFIED_TYPE(type, 0);
}

#define WP(o) W(fp_add(words, (o)))
#define WB(o) B(fp_add(words, (o)))
#define PRIMARY WP(0)
#define SIGN WP(2)
#define SIZE WP(4)
#define CONSTANT WB(6)
#define CHANGING WB(7)

/* adds the current type keyword to words (primary: void, char, int, float, double, struct
   ...; sign; size; const, volatile) and consumes it, parsing a struct/union/class/enum
   specifier on the spot.  1 when the keyword cannot combine with those already seen, which
   ends the specifiers (a repeated keyword is reported and skipped instead) */
u8 ACCEPT_TYPE_WORD(u16 context, farptr words, farptr type)
{
    if (PRIMARY == CURRENT_TOKEN || SIGN == CURRENT_TOKEN || SIZE == CURRENT_TOKEN) {
        if (CURRENT_TOKEN != TOK_STRUCT && CURRENT_TOKEN != TOK_UNION && CURRENT_TOKEN != TOK_CLASS && CURRENT_TOKEN != TOK_ENUM) {
            REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
            ADVANCE_TOKEN();
        }
        return 1;
    }
    switch (CURRENT_TOKEN) {
    case TOK_VOID:
        if (PRIMARY != 0x82 || SIGN != 0x82 || SIZE != 0x82)
            return 1;
        PRIMARY = 0x45;
        ADVANCE_TOKEN();
        break;
    case TOK_CHAR:
        if (PRIMARY != 0x82 || SIZE != 0x82)
            return 1;
        PRIMARY = 0x3A;
        ADVANCE_TOKEN();
        break;
    case TOK_INT:
        if (PRIMARY != 0x82)
            return 1;
        PRIMARY = 0x3C;
        ADVANCE_TOKEN();
        break;
    case TOK_FLOAT:
    case TOK_DOUBLE:
        if (PRIMARY != 0x82 || SIGN != 0x82 || SIZE == 0x3B || (CURRENT_TOKEN == TOK_FLOAT && SIZE == 0x3F))
            return 1;
        PRIMARY = CURRENT_TOKEN;
        ADVANCE_TOKEN();
        break;
    case TOK_SHORT:
        if ((PRIMARY != 0x82 && PRIMARY != 0x3C) || SIZE != 0x82)
            return 1;
        SIZE = 0x3B;
        ADVANCE_TOKEN();
        break;
    case TOK_LONG:
        if ((PRIMARY != 0x82 && PRIMARY != 0x3C && PRIMARY != 0x41) || SIZE != 0x82)
            return 1;
        SIZE = 0x3F;
        ADVANCE_TOKEN();
        break;
    case TOK_UNSIGNED:
    case TOK_SIGNED:
        if ((PRIMARY != 0x82 && PRIMARY != 0x3A && PRIMARY != 0x3C) || SIGN != 0x82)
            return 1;
        SIGN = CURRENT_TOKEN;
        ADVANCE_TOKEN();
        break;
    case TOK_CONST:
        if (W(type) && (CONSTANT || (TB(W(type), 2) & 1)))
            REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
        CONSTANT = 1;
        ADVANCE_TOKEN();
        break;
    case TOK_VOLATILE:
        if (W(type) && (CHANGING || (TB(W(type), 2) & 2)))
            REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
        CHANGING = 1;
        ADVANCE_TOKEN();
        break;
    case TOK_STRUCT:
    case TOK_UNION:
    case TOK_ENUM:
    case TOK_CLASS:
        if (PRIMARY != 0x82 || SIGN != 0x82 || SIZE != 0x82)
            return 1;
        PRIMARY = CURRENT_TOKEN;
        ADVANCE_TOKEN();
        if (PRIMARY == 0x44)
            W(type) = PARSE_ENUM_SPECIFIER();
        else
            W(type) = PARSE_RECORD_SPECIFIER(PRIMARY, context == 0);
        break;
    }
    return 0;
}

/* the collected type words as a type: the basic type indexed in BCC_TYPE_PTR (char kinds
   1 and 2, or PLAIN_CHAR_KIND for plain char; short 3, int 5, long 7, each +1 for
   unsigned; float 9, double 10, long double 11, void 12), or type itself for a typedef name
   or a struct specifier.  0 if no type was given at all.  const and volatile are then
   added */
u16 BUILD_BASIC_TYPE(u16 qualifiers, u16 size, u16 sign, u16 primary, u8 named, u16 type)
{
    struct Words words = { primary, sign, size, (u8)qualifiers, (u8)(qualifiers >> 8) };
    u16 index = 0, result;
    if (!named &&
        (words.primary == 0x45 || words.primary == 0x3A || words.primary == 0x3C || words.primary == 0x40 ||
         words.primary == 0x41 || ((words.constant || words.changing) && words.primary == 0x82) ||
         words.sign != 0x82 || words.size != 0x82))
        result = 0;
    else {
        if (!type)
            return 0;
        result = type;
    }
    if (!result) {
        if (words.primary == 0x40 || words.primary == 0x41) {
            if (words.size == 0x3F)
                index = 11;
            else if (words.primary == 0x41)
                index = 10;
            else
                index = 9;
        } else if (words.primary == 0x3A) {
            if (words.sign == 0x3E)
                index = 1;
            else if (words.sign == 0x3D)
                index = 2;
            else
                index = PLAIN_CHAR_KIND;
        } else if (words.primary != 0x82 || words.sign != 0x82 || words.constant || words.changing || words.size != 0x82) {
            if (words.primary == 0x45)
                index = 12;
            else if (words.size == 0x3B)
                index = 3;
            else if (words.size == 0x3F)
                index = 7;
            else
                index = 5;
            if (words.sign == 0x3D)
                ++index;
        }
        result = BCC_TYPE_AT(index);
    }
    return ADD_CV_QUALIFIERS(result, words.changing, words.constant);
}

/* nonzero while the current token can continue the specifiers: a type start that is not
   '~', and an identifier only if no type has been seen yet (in C++ also not when followed
   by '::', a qualified name) */
u8 MORE_TYPE_WORDS(u16 primary)
{
    return TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) && CURRENT_TOKEN != TOK_TILDE &&
           (CURRENT_TOKEN != TOK_IDENT || primary == 0x82) &&
           (!CPP_MODE || CURRENT_TOKEN != TOK_IDENT ||
            (peek_kind() != 0x67 &&
             (primary == 0x82 || primary == 0x45 || primary == 0x3A || primary == 0x3C || primary == 0x40 || primary == 0x41)));
}

/* declaration specifiers.  Outputs: *kind the storage-class or function-specifier token
   (82h if none; static with inline gives inline), *modifier1 friend, *modifier2 virtual,
   *type the base type (the caller passes a default in *type), *spec the modifiers attached
   to a typedef name used as the type, *named 1 if the type was a typedef name.  context 0
   allows a forward declaration "struct S;".  overload is obsolete and only warned about */
void PARSE_DECL_SPECIFIERS(u16 context, farptr kind, farptr modifier1, farptr modifier2, farptr type, farptr spec,
                           farptr named)
{
    /* the original frame from BP-0Ah: result, words at 2 */
    u16 mark = scratch_mark();
    farptr result = scratch_alloc(0x0A), words = fp_add(result, 2);
    W(result) = W(type);
    SB(spec) = 0;
    SB(fp_add(spec, 1)) = 0;
    SB(fp_add(spec, 2)) = 0;
    PRIMARY = 0x82;
    SIGN = 0x82;
    SIZE = 0x82;
    CONSTANT = 0;
    CHANGING = 0;
    B(named) = 0;
    W(kind) = 0x82;
    B(modifier1) = 0;
    B(modifier2) = 0;
    ENUM_BODY_TREE_FLAG = 0;
    while (MORE_TYPE_WORDS(PRIMARY)) {
        if (TYPE_FLAGS_AT(CURRENT_TOKEN) & 1) {
            if (CURRENT_TOKEN == TOK_OVERLOAD) {
                REPORT_CURRENT_TOKEN(MSG_OVERLOAD_NOW);
                if (W(kind) == 0x82)
                    W(kind) = CURRENT_TOKEN;
            } else if (CURRENT_TOKEN == TOK_FRIEND) {
                if (B(modifier1))
                    REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
                B(modifier1) = 1;
            } else if (CURRENT_TOKEN == TOK_VIRTUAL) {
                if (B(modifier2))
                    REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
                B(modifier2) = 1;
            } else if (CURRENT_TOKEN == TOK_INLINE && W(kind) == 0x35) {
                W(kind) = CURRENT_TOKEN;
            } else if (!(CURRENT_TOKEN == TOK_STATIC && W(kind) == 0x6B)) {
                if (W(kind) != 0x82 && W(kind) != 0x6E)
                    REPORT_CURRENT_TOKEN(MSG_TOO_MANY_STORAGE);
                else
                    W(kind) = CURRENT_TOKEN;
            }
            ADVANCE_TOKEN();
        } else if (TYPE_FLAGS_AT(CURRENT_TOKEN) & 2) {
            if (ACCEPT_TYPE_WORD(context, words, result))
                break;
        } else if (CURRENT_TOKEN == TOK_IDENT) {
            W(result) = TYPE_LOOKUP((u16)CURRENT_TOKEN_VALUE);
            if (PRIMARY == 0x82 && SIGN == 0x82 && SIZE == 0x82) {
                PRIMARY = 0x31;
                B(named) = 1;
                u16 symbol = LOOKUP_NAME((u16)CURRENT_TOKEN_VALUE);
                store_spec(spec, spec_at(MK_FP(SYMBOL_POOL_SEG, symbol + SYM_STORAGE)));
                if (W(result) && ((CONSTANT && (TB(W(result), 2) & 1)) || (CHANGING && (TB(W(result), 2) & 2))))
                    REPORT_CURRENT_TOKEN(MSG_HAS_ALREADY_BEEN);
                ADVANCE_TOKEN();
            } else {
                W(result) = 0;
                break;
            }
        } else
            REPORT_DIAGNOSTIC(MSG_NOT_LEGAL_HERE, (i32)NAME_TEXT_COPY(TOKEN_NAMES_AT(CURRENT_TOKEN)), 0);
    }
    u16 t = BUILD_BASIC_TYPE(CONSTANT | (u16)CHANGING << 8, SIZE, SIGN, PRIMARY, B(named), W(result));
    W(type) = t;
    scratch_release(mark);
}
