/* classdef.c: from bcc20/src/cpp/CLASSDEF.C: the C++ part of parsing a class definition.
   CLSMEMB.C runs the loop over the member declarations of a class body; for C++ it calls
   in here: TYPE_BASE (the base clause), TYPE_CLASSIFY (kind of member declaration),
   TYPE_SCOPE (public:/private:/protected:), TYPE_DECLARE (access declaration Base::m;),
   TYPE_RELINK (anonymous union member), TYPE_FINALIZE (friend), TYPE_ENUM (constructor
   declaration), TYPE_DEFER (end of the member list), TYPE_DISPATCH (one declarator), and
   for its kinds TYPE_APPLY (typedef), TYPE_ARRAY (friend with a declarator), TYPE_RECORD
   (member function) and TYPE_VIRTUAL (static data member).  The declarator parser calls
   TYPE_PATH and TYPE_OPERATOR.  Several names (TYPE_ENUM, TYPE_ARRAY, TYPE_VIRTUAL,
   TYPE_RECORD) do not say what the function does.
   State: STRUCT_BODY_TYPE is the class, ACTIVE_LIST its tag symbol, CLASS_KEY_TOKEN its
   keyword (68h class, 43h union), SCOPE_STATE the current access (0 public, 1 protected, 2
   private, 4 hidden members), CLASS_VTABLE_SIZE the bytes of virtual table entries so far.
   A member declaration is described by TYPE_EXPR, CURRENT_DECLARATOR_NAME,
   STORAGE_CLASS_TOKEN (82h none, 35h static, 6Bh inline, 37h typedef), SPECIAL_MEMBER_KIND
   (0 plain, 1 operator, 2 conversion, 3 constructor, 4 destructor),
   MEMBER_QUALIFIER_CLASS (the X of X::name), MEMBER_DECL_FRIEND, PARSE_FLAG2 (virtual),
   NO_THIS_PARAMETER, RETURN_TYPE_OMITTED and, for dynamically dispatched functions
   declared "= [n]", DISPATCH_NUMBER and DISPATCH_NUMBER_GIVEN.  Virtual functions get
   SYM_VIRTUAL_INDEX = their entry's byte offset in the table plus 1 (TYPE_OFFSET).  A
   friend class F of class A gets A on the list at word 0Ah of F's tag body, a friend
   function gets A on its CACHE_HEAD entry (CACHE_ADD).  Modifier triples (struct C16Spec)
   go by value as two words, the high one first; the locals whose addresses are passed on
   live in the scratch area in the original frame's layout. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define KIND(type) TYPE_W((type), TYPE_KIND)
#define KIND_FLAGS(type) EXPR_FLAGS_AT(KIND(type))
#define TAG(type) TYPE_W((type), TYPE_TAG_BODY)
#define CLASS_FLAGS(type) TAG_W(TAG(type), TAG_CLASS_FLAGS)
#define TAG_FRIENDS 0x0A
#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define CURRENT_TOKEN_VALUE W(CURRENT_TOKEN_VALUE_P)
#define TYPE_SIZE_LOW SD(TYPE_SIZE_LOW_P)
#define FUNCTION_BODY_DEPTH W(FUNCTION_BODY_DEPTH_P)
#define NO_STORAGE_CLASS 0x82
#define INLINE_TOKEN 0x6B
#define TAG_NAME(type) SYM_W(TAG_W(TAG(type), TAG_SYMBOL), SYM_NAME)
#define SPEC_LOW(p) (u16)(B(p) | (B(fp_add((p), 1)) << 8))
#define SPEC_THIRD(p) B(fp_add((p), 2))

static void copy_spec(farptr to, farptr from)
{
    for (int i = 0; i < 3; ++i)
        B(fp_add(to, i)) = B(fp_add(from, i));
}

/* after "X(" inside class X: a trial parse that answers whether the parenthesis starts a
   constructor's parameter list (nonzero) rather than a declarator of a member of type X */
u8 PARSE_STATE_CHECK(void)
{
    u8 result = 0;
    if (BCC_PARSE_BEGIN(1)) {
        BCC_PARSE_PUSH(1);
        if (CURRENT_TOKEN == TOK_LPAREN)
            result = BCC_PARSE_QUERY();
        BCC_PARSE_POP(1);
    }
    return result;
}

/* the class type named by the current identifier, as used before '::': a tag or typedef
   (storage class 11 or 8) of a class type, else an error and 0.  Does not advance */
u16 BCC_TYPE_RESOLVE_NAME(void)
{
    u16 node = BCC_TYPE_PRIMARY(CURRENT_TOKEN_VALUE);
    if (!node)
        node = LOOKUP_NAME(CURRENT_TOKEN_VALUE);
    if (!node) {
        REPORT_CURRENT_TOKEN(MSG_UNDEFINED_SYMBOL);
        return 0;
    }
    if (((SYM_B(node, SYM_STORAGE_CLASS) >> 3) == 11 || (SYM_B(node, SYM_STORAGE_CLASS) >> 3) == 8)
        && SYM_W(node, SYM_TYPE) && (KIND_FLAGS(SYM_W(node, SYM_TYPE)) & 0x40))
        return SYM_W(node, SYM_TYPE);
    REPORT_NAME_DIAGNOSTIC(MSG_TYPE_QUALIFIER_MUST, SYM_W(node, SYM_NAME));
    return 0;
}

/* PARSE_TYPE_MODIFIERS(from) into to, through the buffer at buffer */
static void type_modifiers(farptr to, farptr from, farptr buffer)
{
    PARSE_TYPE_MODIFIERS(buffer, SPEC_THIRD(from), SPEC_LOW(from));
    copy_spec(to, buffer);
}

/* the pointer part of a C++ declarator: any sequence of '*', '&' and X::*, with type
   modifiers, applied to type initial.  X::* makes a pointer to member (the member class
   goes into a copy of the type, pointer mode 0Bh); a qualifier X:: left over in front of
   the name is returned in *result (0 if none).  mode 0 also accepts "X:" (an error).  text
   and scratch receive the modifier sets.  Returns the type built */
u16 TYPE_PATH(u16 initial, u16 mode, farptr result, farptr text, farptr scratch)
{
    /* the original frame from BP-0Ch: a buffer, another at 4, temp at 8 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x0C);
    farptr buffer2 = v, buffer1 = fp_add(v, 4), temp = fp_add(v, 8);
    u16 type = initial, qualifier = 0;
    u8 changed = 0;
    copy_spec(scratch, EXPR_TEMP2_P);
    W(result) = 0;
    while (CURRENT_TOKEN == TOK_SCOPE) {
        REPORT_CURRENT_TOKEN(MSG_REQUIRES_PRECEEDING);
        ADVANCE_TOKEN();
    }
    type_modifiers(text, text, buffer1);
    copy_spec(temp, text);
    for (;;) {
        if (!(CURRENT_TOKEN == TOK_STAR || CURRENT_TOKEN == TOK_AMPERSAND)) {
            if (CURRENT_TOKEN != TOK_IDENT)
                break;
            PEEK_TOKEN();
            if (TOKEN_TYPE != 0x67) {
                PEEK_TOKEN();
                if (TOKEN_TYPE != 0x2F) {
                    if (mode != 0)
                        break;
                    PEEK_TOKEN();
                    if (TOKEN_TYPE != 0x21)
                        break;
                }
            }
        }
        if (CURRENT_TOKEN == TOK_STAR && qualifier != 0) {
            if (type != 0) {
                type = COPY_TYPE_RECORD(type);
                if (TYPE_W(type, TYPE_MEMBER_CLASS) == 0)
                    TYPE_W(type, TYPE_MEMBER_CLASS) = qualifier;
                else
                    REPORT_CURRENT_TOKEN(MSG_MULTIPLE_SCOPE);
                qualifier = 0;
            }
            if (SB(fp_add(text, 1)) != 0)
                REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
            B(fp_add(temp, 1)) = 0x0B;
        }
        if (CURRENT_TOKEN == TOK_STAR || CURRENT_TOKEN == TOK_AMPERSAND) {
            changed = 1;
            copy_spec(scratch, temp);
            type = PARSE_POINTER_DECLARATOR(type, SPEC_THIRD(temp), SPEC_LOW(temp));
            TYPE_W(type, TYPE_CALL_CONV) = qualifier;
            qualifier = 0;
            type_modifiers(temp, EXPR_TEMP2_P, buffer2);
            if (TYPE_W(type, TYPE_CALL_CONV) != 0)
                copy_spec(scratch, temp);
        } else {
            if (qualifier != 0)
                REPORT_CURRENT_TOKEN(MSG_MULTIPLE_SCOPE);
            qualifier = BCC_TYPE_RESOLVE_NAME();
            changed = 0;
            ADVANCE_TOKEN();
            if (CURRENT_TOKEN == TOK_DOT)
                REPORT_CURRENT_TOKEN(MSG_OBSOLETE_SYNTAX_USE);
            else if (CURRENT_TOKEN == TOK_COLON)
                REPORT_CURRENT_TOKEN(MSG_FOUND_INSTEAD);
            ADVANCE_TOKEN();
        }
    }
    if (!changed)
        W(result) = qualifier;
    copy_spec(text, temp);
    scratch_release(mark);
    return type;
}

/* the name part "operator op", "operator type" or "~X" of a declarator.  *name gets the
   member name (TOKEN_NAMES of the operator token, of 37h for conversion functions, or the
   destructor name) and *kind 1 operator, 2 conversion, 4 destructor.  For a conversion
   function the declared type is returned (a written return type is an error inside a
   class), otherwise fallback.  ~X must name class scope (or the class being defined) */
u16 TYPE_OPERATOR(u16 fallback, u16 scope, farptr name, farptr kind)
{
    u16 token = NO_STORAGE_CLASS;
    if (CURRENT_TOKEN == TOK_OPERATOR) {
        ADVANCE_TOKEN();
        token = CURRENT_TOKEN;
        if (CURRENT_TOKEN != TOK_TILDE && TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) != 0) {
            PEEK_TOKEN();
            if (TOKEN_TYPE != 0x67) {
                /* the original frame from BP-16h: value, third at 3, pair2 at 4, pair1 at 8,
                   b at 0Eh, a at 10h, code at 12h, second at 14h, first at 15h */
                u16 mark = scratch_mark();
                farptr v = scratch_alloc(0x16);
                farptr value = v, third = fp_add(v, 3), pair2 = fp_add(v, 4), pair1 = fp_add(v, 8);
                farptr b = fp_add(v, 0x0E), a = fp_add(v, 0x10), code = fp_add(v, 0x12);
                farptr second = fp_add(v, 0x14), first = fp_add(v, 0x15);
                token = 0x37;
                W(value) = INT_TYPE;
                PARSE_DECL_SPECIFIERS(6, code, first, second, value, pair1, third);
                if (W(code) != NO_STORAGE_CLASS || B(first) != 0 || B(second) != 0) {
                    farptr text = B(first) ? STR_FRIEND_4_P : B(second) ? STR_VIRTUAL_4_P : NAME_TEXT_COPY(TOKEN_NAMES_AT(W(code)));
                    REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, (i32)text, 0);
                }
                PARSE_DECLARATOR(W(value), 6, value, fp_add(pair1, 4), a, b, pair1, pair2);
                if (BCC_TREE_FLAG != 0 && !RETURN_TYPE_OMITTED)
                    REPORT_CURRENT_TOKEN(MSG_BAD_RETURN_TYPE_TYPE);
                W(kind) = 2;
                W(name) = TOKEN_NAMES_AT(token);
                u16 result = W(value);
                scratch_release(mark);
                return result;
            }
        }
        W(kind) = 1;
        W(name) = TOKEN_NAMES_AT(token);
        if ((TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x400) == 0)
            REPORT_CURRENT_TOKEN(MSG_OVERLOADABLE_OPERATOR);
        ADVANCE_TOKEN();
        if (token == 1) {
            REQUIRE_TOKEN_BODY(2, 0xE9);
            return fallback;
        }
        if (token == 3) {
            if (CURRENT_TOKEN == TOK_RBRACKET)
                ADVANCE_TOKEN();
            else
                REPORT_DIAGNOSTIC(MSG_MISSING, (i32)STR_OPERATOR_5_P, 0);
        }
        return fallback;
    }
    if (CURRENT_TOKEN != TOK_TILDE)
        return fallback;
    ADVANCE_TOKEN();
    W(name) = DTOR_NAME;
    W(kind) = 4;
    if (CURRENT_TOKEN != TOK_IDENT)
        return fallback;
    if (scope == 0 && BCC_TREE_FLAG != 0)
        scope = STRUCT_BODY_TYPE;
    u16 node = LOOKUP_NAME(CURRENT_TOKEN_VALUE);
    if ((SYM_B(node, SYM_STORAGE_CLASS) >> 3) == 11) {
        if (SYM_W(node, SYM_TYPE) != scope)
            REPORT_CURRENT_TOKEN(MSG_DESTRUCTOR_NAME_MUST);
    } else
        REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
    ADVANCE_TOKEN();
    return fallback;
}

/* searches list (a base list) and, recursively, the bases of its entries for another entry
   of the same class as base entry target where at least one of the two is non-virtual.
   The entry found or 0 */
i16 LIST_FIND(u16 target, u16 list)
{
    while (list != 0) {
        if (list != target && TAG(BASE_W(target, BASE_TYPE)) == TAG(BASE_W(list, BASE_TYPE))
            && (BASE_B(target, BASE_VIRTUAL) == 0 || BASE_B(list, BASE_VIRTUAL) == 0))
            break;
        if (LIST_FIND(target, TAG_W(TAG(BASE_W(list, BASE_TYPE)), TAG_BASES)))
            break;
        list = BASE_W(list, BASE_NEXT);
    }
    return (i16)list;
}

/* parses the base-specifier list after ':' up to '{': each entry is [virtual]
   [public|private] Name (protected is not allowed; the default access is public for
   struct, private for class).  A base must be a complete class, not a union.  Entries are
   collected with ADD_UNIQUE_PARAM (duplicates are an error), put in declaration order, and
   checked with LIST_FIND.  Returns the BASE list */
u16 LIST_PARSE(void)
{
    /* the original frame from BP-14h: status at 1, item at 4, head at 0Eh */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x14);
    farptr status = fp_add(v, 1), head = fp_add(v, 0x0E);
    u8 qualifier, scope, seen;
    ADVANCE_TOKEN();
    if (CURRENT_TOKEN == TOK_LBRACE)
        REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
    scope = SCOPE_STATE == 0;
    seen = 0;
    W(head) = 0;
    while (CURRENT_TOKEN == TOK_PUBLIC || CURRENT_TOKEN == TOK_PRIVATE || CURRENT_TOKEN == TOK_PROTECTED
           || CURRENT_TOKEN == TOK_VIRTUAL || CURRENT_TOKEN == TOK_IDENT) {
        qualifier = 0;
        while (CURRENT_TOKEN == TOK_PUBLIC || CURRENT_TOKEN == TOK_PRIVATE || CURRENT_TOKEN == TOK_PROTECTED || CURRENT_TOKEN == TOK_VIRTUAL) {
            if (CURRENT_TOKEN == TOK_VIRTUAL) {
                if (qualifier != 0)
                    REPORT_CURRENT_TOKEN(MSG_VIRTUAL_SPECIFIED_MORE);
                qualifier = 1;
            } else {
                if (seen != 0)
                    REPORT_CURRENT_TOKEN(MSG_SPECIFIES_MULTIPLE);
                if (CURRENT_TOKEN == TOK_PROTECTED)
                    REPORT_CURRENT_TOKEN(MSG_BASE_CLASS_CANNOT);
                else
                    scope = CURRENT_TOKEN == TOK_PUBLIC;
                seen = 1;
            }
            ADVANCE_TOKEN();
        }
        if (CURRENT_TOKEN != TOK_IDENT) {
            REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
            if (CURRENT_TOKEN == TOK_COMMA)
                ADVANCE_TOKEN();
            if (CURRENT_TOKEN != TOK_IDENT)
                SKIP_TO_SYNC_TOKEN(TOK_LBRACE);
        } else {
            u16 node = (u16)TYPE_LOOKUP(CURRENT_TOKEN_VALUE);
            if (node == 0)
                REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
            else if (!(KIND_FLAGS(node) & 0x40) || KIND(node) == TK_UNION || TYPE_SIZE(node) == 0)
                REPORT_NAME_DIAGNOSTIC(MSG_MUST_PREVIOUSLY, TAG_NAME(node));
            else {
                /* the item's words, last first: used and a pad byte, scope and qualifier,
                   offset, type, and next (not set: ADD_UNIQUE_PARAM replaces it) */
                ADD_UNIQUE_PARAM(head, 0, (u16)(scope | (qualifier << 8)), 0, node, 0, status);
                if (B(status) != 0)
                    REPORT_NAME_DIAGNOSTIC(MSG_BASE_CLASS_INCLUDED, TAG_NAME(node));
                qualifier = 0;
                scope = 0;
                seen = 0;
            }
        }
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN == TOK_COMMA) {
            ADVANCE_TOKEN();
            continue;
        }
        if (CURRENT_TOKEN != TOK_LBRACE)
            REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
    }
    if (CURRENT_TOKEN != TOK_LBRACE) {
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_216);
        SKIP_TO_SYNC_TOKEN(TOK_LBRACE);
    }
    u16 reversed = 0;
    while (W(head) != 0) {
        u16 duplicate = W(head);
        W(head) = BASE_W(duplicate, BASE_NEXT);
        BASE_W(duplicate, BASE_NEXT) = reversed;
        reversed = duplicate;
    }
    W(head) = reversed;
    for (u16 entry = reversed; entry; entry = BASE_W(entry, BASE_NEXT)) {
        u16 duplicate = (u16)LIST_FIND(entry, reversed);
        if (duplicate != 0) {
            i32 a = FORMAT_TYPE(BASE_W(entry, BASE_TYPE));             /* pascal: left to right */
            REPORT_DIAGNOSTIC(MSG_INACCESSIBLE_BECAUSE, a, FORMAT_TYPE(BASE_W(duplicate, BASE_TYPE)));
        }
    }
    scratch_release(mark);
    return reversed;
}

/* lays out the bases of STRUCT_BODY_TYPE: each non-virtual base at the next offset, a
   virtual base taking only room for its virtual base pointer.  The first non-virtual base
   with a table at offset 0 shares its table pointer with the class (BASE_USED) and its
   table size is the start of CLASS_VTABLE_SIZE; a base with dynamically dispatched
   functions is always marked BASE_USED and passes on class flag 800h.  Each base gets class
   flag 1, 400h is passed on, and flag 4 is set when there are virtual bases.  The class's
   memory model (8 far, 100h huge, 10h near) must agree with its bases'; without any,
   OPTION_FLAG makes it huge, MODEL_FAR_DATA far, else near.  Stores TAG_BASES and sets
   TYPE_SIZE_LOW to the bases' size */
void LIST_FINISH(u16 list)
{
    u16 context = STRUCT_BODY_TYPE;
    u8 first = (CLASS_FLAGS(context) & 8) != 0;
    u8 second = (CLASS_FLAGS(context) & 0x10) != 0;
    u8 third = (CLASS_FLAGS(context) & 0x100) != 0;
    u32 total = 0;
    u8 size_flag = 0;
    CLASS_VTABLE_SIZE = 0;
    for (u16 entry = list; entry; entry = BASE_W(entry, BASE_NEXT)) {
        BASE_W(entry, BASE_OFFSET) = (u16)total;
        u16 current = BASE_W(entry, BASE_TYPE);
        CLASS_FLAGS(current) |= 1;
        CLASS_FLAGS(context) |= CLASS_FLAGS(current) & 0x400;
        if (CLASS_FLAGS(current) & 0x800) {
            CLASS_FLAGS(context) |= 0x800;
            BASE_B(entry, BASE_USED) = 1;
        }
        u16 message = 0;
        if (CLASS_FLAGS(current) & 8) {
            if (second != 0)
                message = 0xA5;
            else if (third != 0)
                message = 0x134;
            else
                first = 1;
        } else if (CLASS_FLAGS(current) & 0x100) {
            if (second != 0)
                message = 0x137;
            else if (first != 0)
                message = 0x135;
            else
                third = 1;
        } else if (first != 0)
            message = 0xA4;
        else if (third != 0)
            message = 0x136;
        else
            second = 1;
        if (message)
            REPORT_DIAGNOSTIC((i16)message, FORMAT_TYPE(current), 0);
        if (BASE_B(entry, BASE_VIRTUAL) != 0) {
            total += (u32)TYPE_SIZE(TAG_W(TAG(BASE_W(entry, BASE_TYPE)), TAG_THIS_TYPE));
            size_flag = 1;
        } else {
            size_flag = size_flag != 0 || (CLASS_FLAGS(BASE_W(entry, BASE_TYPE)) & 4) != 0;
            if (CLASS_VTABLE_SIZE == 0 && total == 0) {
                CLASS_VTABLE_SIZE = TAG_W(TAG(BASE_W(entry, BASE_TYPE)), TAG_VTABLE_SIZE);
                if (CLASS_VTABLE_SIZE != 0)
                    BASE_B(entry, BASE_USED) = 1;
            }
            total += TAG_W(TAG(BASE_W(entry, BASE_TYPE)), TAG_OWN_SIZE);
        }
    }
    TAG_W(TAG(context), TAG_BASES) = list;
    if (size_flag != 0)
        CLASS_FLAGS(context) |= 4;
    if (!first && !second && !third) {
        if (OPTION_FLAG != 0)
            third = 1;
        else
            first = MODEL_FAR_DATA;
    }
    CLASS_FLAGS(context) |= first != 0 ? 8 : third != 0 ? 0x100 : 0x10;
    TYPE_SIZE_LOW = (i32)total;
}

/* adds class value to the friend list of function key in the CACHE_HEAD records (6 bytes:
   next, function, list of classes), creating the record */
void CACHE_ADD(u16 key, u16 value)
{
    u16 node;
    for (node = CACHE_HEAD; node != 0; node = AT_W(CACHE_POOL, node))
        if (AT_W(CACHE_POOL, node + 2) == key)
            break;
    if (node == 0) {
        node = POOL_ALLOC(CACHE_POOL_P, 6);
        AT_W(CACHE_POOL, node) = CACHE_HEAD;
        AT_W(CACHE_POOL, node + 2) = key;
        AT_W(CACHE_POOL, node + 4) = 0;
        CACHE_HEAD = node;
    }
    u16 list = LIST_CONS(AT_W(CACHE_POOL, node + 4), value);
    AT_W(CACHE_POOL, node + 4) = list;
}

/* the member function type changes for a constructor of class owner (the hidden
   virtual-base flag, a result of owner *) or a destructor (the hidden flags parameter, a
   void result); operator new and delete are static */
static void special_function_type(u16 owner)
{
    if (SPECIAL_MEMBER_KIND == 1) {
        if (DECLARATOR_NAME_TOKEN != 0x6C && DECLARATOR_NAME_TOKEN != 0x69)
            return;
        if (STORAGE_CLASS_TOKEN != INLINE_TOKEN && STORAGE_CLASS_TOKEN != NO_STORAGE_CLASS)
            REPORT_NAME_DIAGNOSTIC(MSG_MEMBER_FUNCTIONS_CAN, CURRENT_DECLARATOR_NAME);
        NO_THIS_PARAMETER = 1;
    } else if (SPECIAL_MEMBER_KIND == 3) {
        if (CLASS_FLAGS(owner) & 4)
            ADD_HIDDEN_PARAMETER(TYPE_EXPR, 0x73);
        u16 pointer = MAKE_POINTER_TYPE(owner, 0, 0);
        TYPE_W(TYPE_EXPR, TYPE_TARGET) = pointer;
    } else if (SPECIAL_MEMBER_KIND == 4) {
        ADD_HIDDEN_PARAMETER(TYPE_EXPR, 0x69);
        TYPE_W(TYPE_EXPR, TYPE_TARGET) = VOID_TYPE;
    }
}

/* a friend declaration in the class body.  "friend class F;" adds the current class to F's
   friend list.  A friend function is declared or found (X::f through TYPE_BUILD, others
   through DECLARE_FUNCTION; a constructor name becomes CTOR_NAME, operator new/delete are
   static) and gets the class on its CACHE_HEAD list.  "friend F;" with F not yet declared
   declares a new class tag F with the current class on its list.  Friends that are data
   are an error.  Returns the function symbol, or 0 */
i16 TYPE_FINALIZE(void)
{
    if (PARSE_FLAG2 != 0 && MEMBER_QUALIFIER_CLASS == 0)
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, (i32)STR_VIRTUAL_4_P, 0);
    if (KIND_FLAGS(TYPE_EXPR) & 0x40) {
        if (CURRENT_DECLARATOR_NAME != 0)
            REPORT_CURRENT_TOKEN(MSG_FRIENDS_MUST_FUNCTIONS);
        u16 list = LIST_CONS(TAG_W(TAG(TYPE_EXPR), TAG_FRIENDS), ACTIVE_LIST);
        TAG_W(TAG(TYPE_EXPR), TAG_FRIENDS) = list;
        return 0;
    }
    if (KIND(TYPE_EXPR) == TK_FUNCTION) {
        if (SPECIAL_MEMBER_KIND == 0) {
            u16 node = LOOKUP_NAME(CURRENT_DECLARATOR_NAME);
            if (node != 0 && (SYM_B(node, SYM_STORAGE_CLASS) >> 3) == 11 && SYM_W(node, SYM_TYPE) == MEMBER_QUALIFIER_CLASS) {
                SPECIAL_MEMBER_KIND = 3;
                if (!RETURN_TYPE_OMITTED)
                    REPORT_NAME_DIAGNOSTIC(MSG_CONSTRUCTOR_CANNOT, CURRENT_DECLARATOR_NAME);
                CURRENT_DECLARATOR_NAME = CTOR_NAME;
            }
        }
        special_function_type(MEMBER_QUALIFIER_CLASS);
        u16 result;
        if (MEMBER_QUALIFIER_CLASS != 0)
            result = TYPE_BUILD(MEMBER_QUALIFIER_CLASS, TYPE_EXPR, CURRENT_DECLARATOR_NAME, SPECIAL_MEMBER_KIND);
        else {
            /* the original frame from BP-4: result, extra at 3 */
            u16 mark = scratch_mark();
            farptr v = scratch_alloc(4);
            DECLARE_FUNCTION(TYPE_EXPR, CURRENT_DECLARATOR_NAME, SPECIAL_MEMBER_KIND, NO_STORAGE_CLASS, v, fp_add(v, 3));
            result = W(v);
            scratch_release(mark);
        }
        CACHE_ADD(result, ACTIVE_LIST);
        return (i16)result;
    }
    u16 code;
    if (TYPE_EXPR != INT_TYPE || CURRENT_DECLARATOR_NAME == 0)
        code = 0xD2;
    else if (MEMBER_QUALIFIER_CLASS != 0 || LOOKUP_NAME(CURRENT_DECLARATOR_NAME) != 0)
        code = 0x114;
    else if (MEMBER_QUALIFIER_CLASS != 0 || SPECIAL_MEMBER_KIND != 0)
        code = MSG_FRIENDS_MUST_FUNCTIONS;
    else {
        u16 node = DECLARE_TAG(CURRENT_DECLARATOR_NAME);
        SYM_B(node, SYM_STORAGE_CLASS) = (SYM_B(node, SYM_STORAGE_CLASS) & 7) | 0x58;
        u16 type = NEW_RECORD_TYPE(TOK_STRUCT, NO_STORAGE_CLASS);
        SYM_W(node, SYM_TYPE) = type;
        TAG_W(TAG(SYM_W(node, SYM_TYPE)), TAG_SYMBOL) = node;
        u16 list = LIST_CONS(0, ACTIVE_LIST);
        TAG_W(TAG(SYM_W(node, SYM_TYPE)), TAG_FRIENDS) = list;
        return 0;
    }
    REPORT_CURRENT_TOKEN(code);
    return 0;
}

/* an access declaration "Base::name;" (or Base::operator op): Base must be a direct base;
   not allowed in a private section; the member's access (and, for functions, every
   overload's) must equal the current section.  The member is added to TAG_ACCESS_DECLS */
void TYPE_DECLARE(void)
{
    u16 result = (u16)TYPE_LOOKUP(CURRENT_TOKEN_VALUE);
    if (SCOPE_STATE == 2)
        REPORT_CURRENT_TOKEN(0x104);
    else if (result == 0)
        REPORT_CURRENT_TOKEN(0xF7);
    else {
        u16 base = TAG_W(TAG(STRUCT_BODY_TYPE), TAG_BASES);
        BASE_W(0, BASE_TYPE) = result;
        while (TAG(BASE_W(base, BASE_TYPE)) != TAG(result))
            base = BASE_W(base, BASE_NEXT);
        if (base == 0) {
            farptr text = NAME_TEXT_COPY(TAG_NAME(result));              /* pascal: left to right */
            REPORT_DIAGNOSTIC(MSG_NOT_BASE_CLASS, (i32)text, FORMAT_TYPE(STRUCT_BODY_TYPE));
        }
    }
    ADVANCE_TOKEN();
    ADVANCE_TOKEN();
    /* the original frame from BP-8: kind at 2, name at 4 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(8);
    farptr kind = fp_add(v, 2), name = fp_add(v, 4);
    u16 code = 0;
    if (CURRENT_TOKEN == TOK_OPERATOR) {
        TYPE_OPERATOR(0, 0, name, kind);
        if (W(kind) == 2)
            code = 0x9F;
    } else if (CURRENT_TOKEN == TOK_IDENT) {
        W(name) = CURRENT_TOKEN_VALUE;
        W(kind) = 0;
        ADVANCE_TOKEN();
    } else
        code = 0xD4;
    u16 member_name = W(name);
    scratch_release(mark);
    if (code) {
        REPORT_CURRENT_TOKEN(code);
        SKIP_TO_SYNC_TOKEN(TOK_SEMICOLON);
        return;
    }
    if (result == 0)
        return;
    u16 member = FIND_MEMBER_REPORT(member_name, result);
    if (member == 0)
        REPORT_CURRENT_TOKEN(0xD0);
    else if (((MEMBER_B(member, MEMB_FLAGS) >> 2) & 7) != SCOPE_STATE) {
        REPORT_CURRENT_TOKEN(0x69);
    } else if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 3) {
        for (u16 inherit = MEMBER_W(member, MEMB_VALUE); inherit != 0; inherit = SYM_W(inherit, SYM_NEXT_OVERLOAD))
            if ((SYM_B(inherit, SYM_INLINE_ACCESS) >> 2) != SCOPE_STATE) {
                REPORT_CURRENT_TOKEN(MSG_ACCESS_DECLARATIONS);
                member = 0;
                break;
            }
    }
    if (member != 0) {
        u16 list = LIST_CONS_ALT(TAG_W(TAG(STRUCT_BODY_TYPE), TAG_ACCESS_DECLS), member);
        TAG_W(TAG(STRUCT_BODY_TYPE), TAG_ACCESS_DECLS) = list;
    }
}

/* completes a member function's type before it is declared (see special_function_type);
   non-static functions get the this parameter */
void TYPE_COMMIT(void)
{
    special_function_type(STRUCT_BODY_TYPE);
    if (!NO_THIS_PARAMETER)
        ADD_THIS_PARAMETER(STRUCT_BODY_TYPE, TYPE_EXPR);
}

/* looks in class expr and its bases (only those sharing the table pointer when flag is
   set) for a virtual or dynamically dispatched function that function symbol type would
   override: same name and signature (a conversion function: same result type).  Warns
   when the result types differ.  The function found or 0; symbol record 0 is the search
   sentinel */
u16 TYPE_RESOLVE(u16 expr, u16 type, u8 flag)
{
    u16 base_list = TAG_W(TAG(expr), TAG_BASES);
    u16 base = SYM_W(type, SYM_TYPE);
    u16 member = FIND_MEMBER_BY_NAME(SYM_W(type, SYM_NAME), expr);
    if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 3) {
        u16 found = MEMBER_W(member, MEMB_VALUE);
        SYM_W(0, SYM_TYPE) = base;
        if (SYM_W(found, SYM_FUNC_KIND) == 2) {
            while (!TYPES_COMPATIBLE(TYPE_W(SYM_W(found, SYM_TYPE), TYPE_TARGET), TYPE_W(base, TYPE_TARGET), 0))
                found = SYM_W(found, SYM_NEXT_OVERLOAD);
        } else {
            while (!SAME_SIGNATURE(SYM_W(found, SYM_TYPE), base))
                found = SYM_W(found, SYM_NEXT_OVERLOAD);
        }
        if (found != 0 && (SYM_W(found, SYM_VIRTUAL_INDEX) != 0 || (SYM_W(found, SYM_FUNC_FLAGS) & 0x100))) {
            if (!TYPES_COMPATIBLE(TYPE_W(SYM_W(found, SYM_TYPE), TYPE_TARGET), TYPE_W(base, TYPE_TARGET), 0)) {
                i32 a = (i32)FORMAT_SYMBOL(type);                        /* pascal: left to right */
                REPORT_DIAGNOSTIC(MSG_VIRTUAL_FUNCTION, a, (i32)FORMAT_SYMBOL(found));
            }
            return found;
        }
    }
    for (; base_list; base_list = BASE_W(base_list, BASE_NEXT)) {
        if (BASE_B(base_list, BASE_USED) != 0 || !flag) {
            u16 result = TYPE_RESOLVE(BASE_W(base_list, BASE_TYPE), type, flag);
            if (result != 0)
                return result;
        }
    }
    return 0;
}

/* the SYM_VIRTUAL_INDEX for member function node: the slot of the function it overrides
   in the table-sharing base chain; else, when it is declared virtual (flag) or overrides a
   virtual function of some other base, a new slot at the end of the class's table and the
   result is the old size plus 1; else 0 (not virtual) */
u16 TYPE_OFFSET(u8 flag, u16 node)
{
    u16 result = TYPE_RESOLVE(STRUCT_BODY_TYPE, node, 1);
    if (result != 0 && SYM_W(result, SYM_VIRTUAL_INDEX) > 0)
        return SYM_W(result, SYM_VIRTUAL_INDEX);
    if (!flag && TYPE_RESOLVE(STRUCT_BODY_TYPE, node, 0) == 0)
        return 0;
    u16 previous = CLASS_VTABLE_SIZE;
    u16 pointer = (TYPE_B(SYM_W(node, SYM_TYPE), TYPE_FUNC_FLAGS) & 1) ? INT_FAR_FUNC_PTR_TYPE : INT_NEAR_FUNC_PTR_TYPE;
    CLASS_VTABLE_SIZE += (u16)TYPE_SIZE(pointer);
    return (u16)(previous + 1);
}

/* parses "= [ n ]" after a member function declarator, Borland's dynamic dispatch number:
   the class becomes a dynamically dispatched class (flag 800h; a warning when the base
   chain has multiple inheritance) and DISPATCH_NUMBER = n is given.  The virtual keyword
   is then not needed */
void TYPE_SETUP(void)
{
    if ((CLASS_FLAGS(STRUCT_BODY_TYPE) & 0x800) == 0) {
        for (u16 current = STRUCT_BODY_TYPE; TAG_W(TAG(current), TAG_BASES) != 0;) {
            if (BASE_W(TAG_W(TAG(current), TAG_BASES), BASE_NEXT) != 0) {
                REPORT_WARNING(MSG_CANNOT_USE_MULTIPLE);
                break;
            }
            current = BASE_W(TAG_W(TAG(current), TAG_BASES), BASE_TYPE);
        }
        CLASS_FLAGS(STRUCT_BODY_TYPE) |= 0x800;
    }
    ADVANCE_TOKEN();
    ADVANCE_TOKEN();
    /* the original frame from BP-4: value */
    u16 mark = scratch_mark();
    farptr value = scratch_alloc(4);
    CONST_EXPR_VALUE_BODY(4, value);
    DISPATCH_NUMBER = W(value);
    scratch_release(mark);
    DISPATCH_NUMBER_GIVEN = 1;
    PARSE_FLAG2 = 0;
    if (CURRENT_TOKEN == TOK_RBRACKET) {
        ADVANCE_TOKEN();
        return;
    }
    REPORT_DIAGNOSTIC(MSG_MISSING, (i32)STR_DYNAMIC_DISPATCH_CONSTAN_P, 0);
}

/* makes member function current dynamically dispatched with id: far, flag 100h, counted
   in TAG_DDVT_COUNT */
static void make_dispatched(u16 current, u16 id)
{
    SYM_W(current, SYM_FUNC_FLAGS) |= 0x100;
    SYM_W(current, SYM_VIRTUAL_INDEX) = id;
    ++TAG_W(TAG(STRUCT_BODY_TYPE), TAG_DDVT_COUNT);
    TYPE_B(SYM_W(current, SYM_TYPE), TYPE_FUNC_FLAGS) &= 0xBF;
    TYPE_B(SYM_W(current, SYM_TYPE), TYPE_FUNC_FLAGS) |= 1;
    SYM_B(current, SYM_FLAGS) |= 0x80;
}

/* in a dynamically dispatched class, makes member function node dynamically dispatched
   when it overrides such a function (inheriting its id; a different given number is an
   error) or when a dispatch number was given (overriding an ordinary virtual function then
   is an error).  Otherwise the function gets an ordinary slot */
void TYPE_INHERIT(u16 node)
{
    u16 resolved = TYPE_RESOLVE(STRUCT_BODY_TYPE, node, 0);
    if (resolved != 0 && (SYM_W(resolved, SYM_FUNC_FLAGS) & 0x100)) {
        make_dispatched(node, SYM_W(resolved, SYM_VIRTUAL_INDEX));
        if (DISPATCH_NUMBER_GIVEN != 0 && SYM_W(node, SYM_VIRTUAL_INDEX) != DISPATCH_NUMBER)
            REPORT_DIAGNOSTIC(MSG_MATCHING_BASE_CLASS, (i32)FORMAT_SYMBOL(node), 0);
        return;
    }
    if (DISPATCH_NUMBER_GIVEN != 0) {
        make_dispatched(node, DISPATCH_NUMBER);
        if (resolved != 0 && SYM_W(resolved, SYM_VIRTUAL_INDEX) != 0)
            REPORT_DIAGNOSTIC(MSG_MATCHING_BASE_CLASS_319, (i32)FORMAT_SYMBOL(node), 0);
    } else {
        u16 index = TYPE_OFFSET(PARSE_FLAG2, node);
        SYM_W(node, SYM_VIRTUAL_INDEX) = index;
    }
}

/* declares member function CURRENT_DECLARATOR_NAME of type TYPE_EXPR in the class: checks
   storage (only inline) and misplaced virtual, reads a dispatch number, completes the
   type, rejects a second declaration with the same type, creates the symbol, merges it with
   an earlier declaration, assigns its virtual slot or dispatch id, links it into the
   member's overload chain and handles a pure specifier "= 0".  A virtual pascal function
   is an error.  Returns the symbol */
u16 TYPE_DEFINE(void)
{
    if (STORAGE_CLASS_TOKEN != INLINE_TOKEN && STORAGE_CLASS_TOKEN != NO_STORAGE_CLASS)
        REPORT_CURRENT_TOKEN(MSG_MEMBER_FUNCTIONS_CAN);
    if (PARSE_FLAG2 != 0 && (SPECIAL_MEMBER_KIND == 3 || NO_THIS_PARAMETER != 0))
        REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, (i32)STR_VIRTUAL_4_P, 0);
    if (CURRENT_TOKEN == TOK_ASSIGN) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 3)
            TYPE_SETUP();
    }
    TYPE_COMMIT();
    u16 member = FIND_MEMBER_BY_NAME(CURRENT_DECLARATOR_NAME, STRUCT_BODY_TYPE), first = 0;
    if (member != 0 && (MEMBER_B(member, MEMB_FLAGS) & 3) == 3)
        first = MEMBER_W(member, MEMB_VALUE);
    else {
        if (member != 0)
            REPORT_NAME_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, CURRENT_DECLARATOR_NAME);
        member = 0;
    }
    u16 search = 0;
    if (first != 0) {
        if (SYM_W(first, SYM_FUNC_KIND) != 2)
            SYM_W(first, SYM_FUNC_FLAGS) |= 1;
        search = first;
        SYM_W(0, SYM_TYPE) = TYPE_EXPR;
        while (!TYPES_COMPATIBLE(SYM_W(search, SYM_TYPE), TYPE_EXPR, 0))
            search = SYM_W(search, SYM_NEXT_OVERLOAD);
    }
    if (search != 0 && (SYM_W(search, SYM_FUNC_KIND) != 2 || TYPE_W(TYPE_EXPR, TYPE_TARGET) != 0)) {
        REPORT_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, (i32)FORMAT_SYMBOL(search), 0);
        return 0;
    }
    /* the original frame from BP-6: flag at 1, result at 4 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(6);
    farptr flag = fp_add(v, 1), slot = fp_add(v, 4);
    W(slot) = ALLOC_SYMBOL_ENTRY(CURRENT_DECLARATOR_NAME, 6);
    SYM_W(W(slot), SYM_FUNC_KIND) = SPECIAL_MEMBER_KIND;
    SYM_B(W(slot), SYM_FLAGS) |= 0x10;
    SYM_W(W(slot), SYM_NEXT) = ACTIVE_LIST;
    MERGE_FUNCTION_DECLARATION(SPECIAL_MEMBER_KIND, TYPE_EXPR, slot, first, STORAGE_CLASS_TOKEN, flag);
    u16 result = W(slot);
    u8 merged = B(flag);
    scratch_release(mark);
    SYM_B(result, SYM_INLINE_ACCESS) = (SYM_B(result, SYM_INLINE_ACCESS) & 0xE3) | (((u8)SCOPE_STATE & 7) << 2);
    if (first != 0 && SPECIAL_MEMBER_KIND != 2)
        SYM_W(result, SYM_FUNC_FLAGS) |= 1;
    if (SPECIAL_MEMBER_KIND == 3)
        SYM_W(result, SYM_FUNC_FLAGS) |= 0x10;
    if (NO_THIS_PARAMETER != 0)
        SYM_W(result, SYM_FUNC_FLAGS) |= 0x40;
    if (MEMBER_FLAG_200_SWITCH != 0)
        TYPE_B(TYPE_EXPR, TYPE_FUNC_FLAGS) |= 0x80;
    if (CLASS_FLAGS(STRUCT_BODY_TYPE) & 0x800)
        TYPE_INHERIT(result);
    else {
        u16 index = TYPE_OFFSET(PARSE_FLAG2, result);
        SYM_W(result, SYM_VIRTUAL_INDEX) = index;
    }
    SYM_W(result, SYM_LINKAGE) = 1;
    if (TYPE_B(TYPE_EXPR, TYPE_CALL_CONV) == 2 && SYM_W(result, SYM_VIRTUAL_INDEX) != 0)
        REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
    if (member == 0)
        member = DECLARE_MEMBER(CURRENT_DECLARATOR_NAME, 3);
    if (merged != 0 || first == 0) {
        SYM_W(result, SYM_NEXT_OVERLOAD) = MEMBER_W(member, MEMB_VALUE);
        MEMBER_W(member, MEMB_VALUE) = result;
    }
    if (CURRENT_TOKEN == TOK_ASSIGN) {
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN == 0x32 && D(CURRENT_TOKEN_VALUE_P) == 0) {
            if (SYM_W(result, SYM_VIRTUAL_INDEX) == 0)
                REPORT_DIAGNOSTIC(MSG_NON_VIRTUAL_FUNCTION, (i32)FORMAT_SYMBOL(result), 0);
            else {
                SYM_W(result, SYM_FUNC_FLAGS) |= 0x20;
                CLASS_FLAGS(STRUCT_BODY_TYPE) |= 0x80;
            }
            ADVANCE_TOKEN();
        } else {
            REPORT_CURRENT_TOKEN(MSG_BAD_SYNTAX_PURE);
            SKIP_BRACE_GROUP();
        }
    }
    return result;
}

/* despite its name, declares a static data member: a member of kind 2 whose value is an
   extern member symbol, far when the class is far or huge (unless declared near), when
   declared far, or for a far array.  Not allowed in a local class */
void TYPE_VIRTUAL(void)
{
    if (FUNCTION_BODY_DEPTH > 0)
        REPORT_DIAGNOSTIC(MSG_CANNOT_HAVE_LOCAL, (i32)STR_STATIC_MEMBER_P, 0);
    u8 special = ((CLASS_FLAGS(STRUCT_BODY_TYPE) & 0x108) != 0 && PARSE_CLASS != 8) || PARSE_CLASS == 9
                 || (KIND(TYPE_EXPR) == TK_ARRAY && (TYPE_B(TYPE_EXPR, TYPE_ATTRS) & 0x40));
    u16 member = DECLARE_MEMBER(CURRENT_DECLARATOR_NAME, 2);
    u16 node = ALLOC_SYMBOL_ENTRY(CURRENT_DECLARATOR_NAME, 5);
    MEMBER_W(member, MEMB_VALUE) = node;
    SYM_W(node, SYM_TYPE) = TYPE_EXPR;
    SYM_W(node, SYM_NEXT) = ACTIVE_LIST;
    SYM_B(node, SYM_STORAGE_CLASS) = (SYM_B(node, SYM_STORAGE_CLASS) & 7) | 0x10;
    SYM_B(node, SYM_FLAGS) |= 0x12 | (special ? 0x80 : 0);
    SYM_W(node, SYM_STORAGE) = 0;
    u16 result = PREPARE_SYMBOL(node);
    SET_PREPARED_FLAGS(result, special ? 0x10 : 4);
    if (MEMBER_FLAG_200_SWITCH)
        SET_PREPARED_FLAGS(result, 0x200);
}

/* an anonymous union inside a class: declares a hidden data member of the union type and
   copies each of the union's data members into the class as a member at the union's
   offset (flag 20h), so they can be named directly.  Other members are not allowed */
void TYPE_RELINK(void)
{
    if (TYPE_SIZE(TYPE_EXPR) == 0)
        REPORT_CURRENT_TOKEN(MSG_SIZE_TYPE_UNKNOWN_ZERO);
    CURRENT_DECLARATOR_NAME = EXPR_CURRENT2;
    ADD_DATA_MEMBER();
    u16 member = FIND_MEMBER_BY_NAME(CURRENT_DECLARATOR_NAME, STRUCT_BODY_TYPE);
    MEMBER_B(member, MEMB_FLAGS) |= 0xA0;
    u16 inherited = MEMBER_W(member, MEMB_VALUE);
    for (member = TAG_W(TAG(TYPE_EXPR), TAG_MEMBERS); member; member = MEMBER_W(member, MEMB_NEXT)) {
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 0) {
            u16 created = COPY_MEMBER_RECORD(member, inherited, TAG_W(TAG(STRUCT_BODY_TYPE), TAG_MEMBERS), SCOPE_STATE);
            TAG_W(TAG(STRUCT_BODY_TYPE), TAG_MEMBERS) = created;
            CACHE_MEMBER_LOOKUP(MEMBER_W(created, MEMB_NAME), STRUCT_BODY_TYPE, created);
            MEMBER_W(created, MEMB_CLASS) = STRUCT_BODY_TYPE;
            MEMBER_B(created, MEMB_FLAGS) |= 0x20;
        } else
            REPORT_NAME_DIAGNOSTIC(MSG_CANNOT_DECLARED, MEMBER_W(member, MEMB_NAME));
    }
}

/* start of a class body: sets the default access (private for class), resets
   CLASS_VTABLE_SIZE, parses an optional base clause (not for a union), lays out the bases
   and makes TAG_THIS_TYPE, the type of this parameters */
void TYPE_BASE(void)
{
    u16 list = 0;
    SCOPE_STATE = CLASS_KEY_TOKEN == 0x68 ? 2 : 0;
    CLASS_VTABLE_SIZE = 0;
    EXPR_OFFSET2 = 0;
    if (CURRENT_TOKEN == TOK_COLON) {
        if (CLASS_KEY_TOKEN == 0x43)
            REPORT_CURRENT_TOKEN(MSG_UNION_CANNOT_HAVE_BASE);
        list = LIST_PARSE();
        if (CURRENT_TOKEN != TOK_LBRACE)
            REPORT_CURRENT_TOKEN(MSG_CANNOT_SPECIFY_BASE);
    }
    LIST_FINISH(list);
    u16 type = MAKE_POINTER_TYPE(STRUCT_BODY_TYPE, 0, 1);
    TAG_W(TAG(STRUCT_BODY_TYPE), TAG_THIS_TYPE) = type;
}

/* an access specifier followed by ':' sets SCOPE_STATE (not allowed in a union) */
void TYPE_SCOPE(void)
{
    if (CLASS_KEY_TOKEN == 0x43)
        REPORT_CURRENT_TOKEN(MSG_ACCESS_SPECIFIER_FOUND);
    if (CURRENT_TOKEN == TOK_PRIVATE)
        SCOPE_STATE = 2;
    else if (CURRENT_TOKEN == TOK_PROTECTED)
        SCOPE_STATE = 1;
    else
        SCOPE_STATE = 0;
    PEEK_TOKEN();
    if (TOKEN_TYPE != 0x21)
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_AFTER);
    else
        ADVANCE_TOKEN();
    ADVANCE_TOKEN();
}

/* a stray ';' after a member function body */
static void skip_extra_semicolon(void)
{
    if (CURRENT_TOKEN == TOK_SEMICOLON) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 5) {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_TERMINATED);
            ADVANCE_TOKEN();
        }
    }
}

/* despite its name, a constructor declaration "X(...)" inside class X: parses the
   parameter list (result type X *), makes it inline when a body or mem-initializer list
   follows, declares it and records the body.  1 when a body was recorded */
u8 TYPE_ENUM(void)
{
    u16 pointer = MAKE_POINTER_TYPE(STRUCT_BODY_TYPE, 0, 0);              /* pascal: left to right */
    TYPE_EXPR = PARSE_FUNCTION_DECLARATOR(pointer, SPEC_THIRD(MEMBER_DECL_ATTRIBUTES_P), SPEC_LOW(MEMBER_DECL_ATTRIBUTES_P));
    if (STORAGE_CLASS_TOKEN == NO_STORAGE_CLASS && (CURRENT_TOKEN == TOK_LBRACE || CURRENT_TOKEN == TOK_COLON))
        STORAGE_CLASS_TOKEN = INLINE_TOKEN;
    SPECIAL_MEMBER_KIND = 3;
    CURRENT_DECLARATOR_NAME = CTOR_NAME;
    u16 result = TYPE_DEFINE();
    skip_extra_semicolon();
    if (CURRENT_TOKEN == TOK_LBRACE || CURRENT_TOKEN == TOK_COLON) {
        RECORD_INLINE_BODY(result);
        if (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
        return 1;
    }
    if (FUNCTION_BODY_DEPTH > 0)
        REPORT_DIAGNOSTIC(MSG_CANNOT_HAVE_LOCAL, (i32)STR_NON_INLINE_FUNCTION_P, 0);
    return 0;
}

/* at the end of the member list of a class that has virtual functions (or class flags
   C00h): stores TAG_VTABLE_SIZE and, unless a base already provides the table pointer
   (record 0 is made a sentinel), adds the hidden table pointer member (a far char pointer
   for a huge class), access 4, member flag 80h */
void TYPE_DEFER(void)
{
    if (CLASS_VTABLE_SIZE == 0 && (CLASS_FLAGS(STRUCT_BODY_TYPE) & 0xC00) == 0)
        return;
    TAG_W(TAG(STRUCT_BODY_TYPE), TAG_VTABLE_SIZE) = CLASS_VTABLE_SIZE;
    u16 cursor = TAG_W(TAG(STRUCT_BODY_TYPE), TAG_BASES);
    BASE_B(0, BASE_USED) = 1;
    while (!BASE_B(cursor, BASE_USED))
        cursor = BASE_W(cursor, BASE_NEXT);
    if (cursor != 0)
        return;
    CURRENT_DECLARATOR_NAME = VTABLE_PTR_NAME;
    TYPE_EXPR = (CLASS_FLAGS(STRUCT_BODY_TYPE) & 0x100) ? FAR_CHAR_POINTER_TYPE : TYPE_LOCAL;
    SCOPE_STATE = 4;
    ADD_DATA_MEMBER();
    u16 member = FIND_MEMBER_BY_NAME(CURRENT_DECLARATOR_NAME, STRUCT_BODY_TYPE);
    MEMBER_B(member, MEMB_FLAGS) |= 0x80;
}

/* a typedef inside the class body; special names are an error */
void TYPE_APPLY(void)
{
    if (SPECIAL_MEMBER_KIND != 0) {
        REPORT_CURRENT_TOKEN(MSG_NEED_IDENTIFIER);
        return;
    }
    DECLARE_TYPEDEF(TYPE_EXPR, SPEC_THIRD(MEMBER_DECL_ATTRIBUTES_P), SPEC_LOW(MEMBER_DECL_ATTRIBUTES_P), CURRENT_DECLARATOR_NAME);
}

/* despite its name, a friend declaration with a declarator: declares it with
   TYPE_FINALIZE and, when a function body follows, records it as an inline function
   queued on INLINE_BODY_QUEUE, to be compiled when the class is complete.  depth > 1 (not
   the first declarator) cannot have a body.  1 when a body was recorded */
u8 TYPE_ARRAY(u16 depth)
{
    u16 node = (u16)TYPE_FINALIZE();
    skip_extra_semicolon();
    if (CURRENT_TOKEN == TOK_LBRACE && KIND(SYM_W(node, SYM_TYPE)) == TK_FUNCTION) {
        if (depth > 1)
            REPORT_CURRENT_TOKEN(MSG_OTHER_OBJECTS_CANNOT);
        RECORD_INLINE_BODY(node);
        INLINE_BODY_QUEUE = LIST_CONS(INLINE_BODY_QUEUE, node);
        SYM_B(node, SYM_STORAGE_CLASS) = (SYM_B(node, SYM_STORAGE_CLASS) & 7) | 0x18;
        if (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
        return 1;
    }
    if (FUNCTION_BODY_DEPTH > 0)
        REPORT_DIAGNOSTIC(MSG_CANNOT_HAVE_LOCAL, (i32)STR_NON_INLINE_FUNCTION_P, 0);
    return 0;
}

/* a member function declaration (depth is the declarator's position): recognizes a
   constructor by its name, notes the operator token, makes a function with a body inline
   and a static one static (constructors and the like cannot be static), declares it and
   records an inline body.  1 when a body was recorded */
u8 TYPE_RECORD(u16 depth)
{
    if (SPECIAL_MEMBER_KIND == 0) {
        u16 node = LOOKUP_NAME(CURRENT_DECLARATOR_NAME);
        if (node != 0 && (SYM_B(node, SYM_STORAGE_CLASS) >> 3) == 0x0B && SYM_W(node, SYM_TYPE) == STRUCT_BODY_TYPE) {
            SPECIAL_MEMBER_KIND = 3;
            if (RETURN_TYPE_OMITTED == 0)
                REPORT_NAME_DIAGNOSTIC(MSG_CONSTRUCTOR_CANNOT, CURRENT_DECLARATOR_NAME);
            CURRENT_DECLARATOR_NAME = CTOR_NAME;
        }
    }
    DECLARATOR_NAME_TOKEN = TOKEN_FROM_NAME(CURRENT_DECLARATOR_NAME);
    NO_THIS_PARAMETER = 0;
    if (MEMBER_QUALIFIER_CLASS != 0 && MEMBER_QUALIFIER_CLASS != STRUCT_BODY_TYPE)
        REPORT_NAME_DIAGNOSTIC(MSG_IDENTIFIER_CANNOT_HAVE, CURRENT_DECLARATOR_NAME);
    if (STORAGE_CLASS_TOKEN == NO_STORAGE_CLASS && (CURRENT_TOKEN == TOK_LBRACE || (CURRENT_TOKEN == TOK_COLON && SPECIAL_MEMBER_KIND == 3)))
        STORAGE_CLASS_TOKEN = INLINE_TOKEN;
    if (STORAGE_CLASS_TOKEN == 0x35) {
        if (SPECIAL_MEMBER_KIND != 0 && DECLARATOR_NAME_TOKEN != 0x6C && DECLARATOR_NAME_TOKEN != 0x69) {
            farptr name = FORMAT_MEMBER_NAME(CURRENT_DECLARATOR_NAME, SPECIAL_MEMBER_KIND, TYPE_EXPR, STRUCT_BODY_TYPE);
            REPORT_DIAGNOSTIC(MSG_FUNCTION_CANNOT_STATIC, (i32)name, 0);
        } else
            NO_THIS_PARAMETER = 1;
        STORAGE_CLASS_TOKEN = NO_STORAGE_CLASS;
    }
    u16 result = TYPE_DEFINE();
    skip_extra_semicolon();
    if (CURRENT_TOKEN == TOK_LBRACE || (CURRENT_TOKEN == TOK_COLON && SPECIAL_MEMBER_KIND == 3)) {
        if (depth > 1)
            REPORT_CURRENT_TOKEN(MSG_OTHER_OBJECTS_CANNOT);
        RECORD_INLINE_BODY(result);
        if (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
        return 1;
    }
    if (FUNCTION_BODY_DEPTH > 0)
        REPORT_DIAGNOSTIC(MSG_CANNOT_HAVE_LOCAL, (i32)STR_NON_INLINE_FUNCTION_P, 0);
    return 0;
}

/* reads the start of a member declaration and returns its kind for TYPE_CLOSE: 2 access
   specifier, 3 access declaration (Base::...), 6 constructor declaration, 1 declarators
   follow, 5 friend without declarator, 4 anonymous union, 0 a type alone (it must name a
   tag or be an enum).  Reads the declaration specifiers (storage only none, static, inline
   or typedef) */
u16 TYPE_CLASSIFY(void)
{
    if (CURRENT_TOKEN == TOK_PRIVATE || CURRENT_TOKEN == TOK_PUBLIC || CURRENT_TOKEN == TOK_PROTECTED)
        return 2;
    if (CURRENT_TOKEN == TOK_IDENT) {
        PEEK_TOKEN();
        if (TOKEN_TYPE == 0x67 && (u16)TYPE_LOOKUP(CURRENT_TOKEN_VALUE) != STRUCT_BODY_TYPE)
            return 3;
    }
    STORAGE_CLASS_TOKEN = NO_STORAGE_CLASS;
    PARSE_FLAG2 = 0;
    MEMBER_DECL_FRIEND = 0;
    TYPE_EXPR = 0;
    MEMBER_DECL_TYPE_NAMED = 0;
    CURRENT_DECLARATOR_NAME = 0;
    NO_THIS_PARAMETER = 0;
    copy_spec(MEMBER_DECL_ATTRIBUTES_P, EXPR_TEMP2_P);
    MEMBER_QUALIFIER_CLASS = 0;
    DISPATCH_NUMBER_GIVEN = 0;
    if (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) != 0) {
        if (CURRENT_TOKEN == TOK_INLINE) {
            ADVANCE_TOKEN();
            STORAGE_CLASS_TOKEN = INLINE_TOKEN;
        }
        PARSE_DECL_SPECIFIERS(2, STORAGE_CLASS_TOKEN_P, MEMBER_DECL_FRIEND_P, PARSE_FLAG2_P, TYPE_EXPR_P, MEMBER_DECL_ATTRIBUTES_P, MEMBER_DECL_TYPE_NAMED_P);
        if (STORAGE_CLASS_TOKEN != NO_STORAGE_CLASS && STORAGE_CLASS_TOKEN != 0x35 && STORAGE_CLASS_TOKEN != INLINE_TOKEN && STORAGE_CLASS_TOKEN != 0x37) {
            REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT, TOKEN_NAMES_AT(STORAGE_CLASS_TOKEN));
            STORAGE_CLASS_TOKEN = NO_STORAGE_CLASS;
        }
    }
    if (TYPE_EXPR == STRUCT_BODY_TYPE && CURRENT_TOKEN == TOK_LPAREN && PARSE_STATE_CHECK() != 0)
        return 6;
    if ((TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) != 0 || CURRENT_TOKEN == TOK_COLON || CURRENT_TOKEN == TOK_TILDE)
        return 1;
    if (MEMBER_DECL_FRIEND != 0)
        return 5;
    if (TYPE_EXPR != 0 && KIND(TYPE_EXPR) == TK_UNION && TAG_NAME(TYPE_EXPR) == 0)
        return 4;
    if (KIND(TYPE_EXPR) != TK_ENUM && (!(KIND_FLAGS(TYPE_EXPR) & 0x40) || TAG_NAME(TYPE_EXPR) == 0))
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
    return 0;
}

/* parses one member declarator and returns its kind for TYPE_LOOP_FAR: 4 typedef, 5
   friend, 6 member function, 7 static data member, 2 bit field (':'), 3 data member.  A
   missing type means int (void for a destructor) and is only accepted for functions;
   storage classes and special names that do not fit are reported */
u16 TYPE_DISPATCH(void)
{
    u16 previous = TYPE_EXPR;
    RETURN_TYPE_OMITTED = 0;
    MEMBER_QUALIFIER_CLASS = 0;
    if (previous == 0) {
        TYPE_EXPR = CURRENT_TOKEN == TOK_TILDE ? VOID_TYPE : INT_TYPE;
        RETURN_TYPE_OMITTED = 1;
    } else if (CURRENT_TOKEN == TOK_TILDE)
        REPORT_CURRENT_TOKEN(MSG_DESTRUCTOR_CANNOT_HAVE);
    /* the original frame from BP-4: parsed */
    u16 mark = scratch_mark();
    farptr parsed = scratch_alloc(4);
    PARSE_DECLARATOR(TYPE_EXPR, 2, TYPE_EXPR_P, CURRENT_DECLARATOR_NAME_P, SPECIAL_MEMBER_KIND_P, MEMBER_QUALIFIER_CLASS_P, MEMBER_DECL_ATTRIBUTES_P, parsed);
    scratch_release(mark);
    if (CURRENT_DECLARATOR_NAME == 0) {
        if (CURRENT_TOKEN == TOK_COLON)
            return 2;
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
        CURRENT_DECLARATOR_NAME = TOKEN_NAMES_AT(W(CURRENT_TOKEN_RECORD_P));
    } else if (RETURN_TYPE_OMITTED != 0 && KIND(TYPE_EXPR) != TK_FUNCTION && !MEMBER_DECL_FRIEND
               && ((KIND_FLAGS(TYPE_EXPR) & 0x14) == 0 || KIND(TYPE_W(TYPE_EXPR, TYPE_TARGET)) != TK_FUNCTION)
               && STORAGE_CLASS_TOKEN == NO_STORAGE_CLASS)
        REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
    if (STORAGE_CLASS_TOKEN == 0x37)
        return 4;
    if (MEMBER_DECL_FRIEND != 0)
        return 5;
    if (KIND(TYPE_EXPR) == TK_FUNCTION) {
        if (previous == TYPE_EXPR && MEMBER_DECL_TYPE_NAMED != 0)
            REPORT_CURRENT_TOKEN(MSG_FUNCTION_DEFINITION);
        return 6;
    }
    if (STORAGE_CLASS_TOKEN == 0x35) {
        if (CURRENT_TOKEN == TOK_COLON)
            REPORT_CURRENT_TOKEN(MSG_BIT_FIELD_CANNOT);
        else if (CLASS_KEY_TOKEN != 0x43)
            return 7;
        else
            REPORT_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT, (i32)STR_STATIC_2_P, 0);
    }
    if (STORAGE_CLASS_TOKEN != NO_STORAGE_CLASS)
        REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT, TOKEN_NAMES_AT(STORAGE_CLASS_TOKEN));
    if (SPECIAL_MEMBER_KIND != 0)
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    if (CURRENT_TOKEN == TOK_COLON)
        return 2;
    return 3;
}

/* an enumerator of enum source declared inside a class becomes a member of kind 1 named
   type with value value (the long value comes as two words; context, its high word, is not
   used).  The first one is also stored as the enum's TAG_MEMBERS */
void TYPE_ATTACH(u16 source, u16 type, u16 context, u16 value)
{
    (void)context;
    u16 member = DECLARE_MEMBER(type, 1);
    MEMBER_W(member, MEMB_TYPE) = source;
    MEMBER_W(member, MEMB_VALUE) = value;
    MEMBER_W(member, MEMB_CLASS) = STRUCT_BODY_TYPE;
    if (TAG_W(TAG(source), TAG_MEMBERS) == 0)
        TAG_W(TAG(source), TAG_MEMBERS) = member;
}
