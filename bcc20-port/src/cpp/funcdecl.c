/* funcdecl.c: from bcc20/src/cpp/FUNCDECL.C: C++ checks on declarations, called by the
   external-declaration parser (EXTDECL.C), the function-definition code (FUNCDEF.C) and
   CLASSDEF.C.  The names (from the original's TREL, TMETHOD, TLINK, TCOMP, TMATCH, TVALID,
   TBIND, TNORM) do not say what the functions do:
   - BCC_TYPE_RELATION: a declaration with no declarator (a bare struct or union): an
     anonymous union's members become names in the current scope;
   - DEFINE_STATIC_DATA_MEMBER: the definition of a static data member X::m outside its
     class;
   - BCC_TYPE_MATCH, BCC_TYPE_COMPARE, BCC_TYPE_LINK: a function redeclared with a name
     already declared: the same function (default arguments merged) or a new overload;
   - BCC_TYPE_VALIDATE: the rules for operator functions, operator new and delete, and
     constructors;
   - TYPE_BUILD: finds the member function X::f that an out-of-class definition defines;
   - BCC_TYPE_NORMALIZE: fixes up the type of a constructor or destructor being defined.
   The original wrote several of these with register pseudo-variables; the port spells
   them as plain C. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define NO_STORAGE_CLASS 0x82
#define KIND_FLAGS(type) EXPR_FLAGS_AT(TYPE_W((type), TYPE_KIND))
#define DEFAULT(formal) FORMAL_W((formal), FORMAL_DEFAULT_ARG)

/* type is the type of a declaration that declares no name, op its storage class token.  An
   unnamed union becomes an anonymous union: a temporary object is created and each data
   member is declared as an alias of its member; other members are not allowed; at file
   scope it must be static (35h).  A named struct may take only extern, static or no
   storage class; an unnamed struct or anything else declares nothing */
void BCC_TYPE_RELATION(u16 type, u16 op)
{
    if (!type)
        return;
    if (TYPE_W(type, TYPE_KIND) == TK_UNION) {
        if (SYM_W(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) != 0)
            return;
        if (op != 0x35)
            REPORT_CURRENT_TOKEN(MSG_GLOBAL_ANONYMOUS_UNION);
        u16 member = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS);
        u16 converted = CREATE_TEMP_SYMBOL(type, 0);
        while (member) {
            if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 0)
                DECLARE_MEMBER_ALIAS(member, converted);
            else
                REPORT_NAME_DIAGNOSTIC(MSG_CANNOT_DECLARED, MEMBER_W(member, MEMB_NAME));
            member = MEMBER_W(member, MEMB_NEXT);
        }
    } else if (TYPE_W(type, TYPE_KIND) == TK_STRUCT) {
        if (SYM_W(TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) == 0) {
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
            return;
        }
        if (op != 0x36 && op != 0x35 && op != NO_STORAGE_CLASS)
            REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, TOKEN_NAMES_AT(op));
    } else
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
}

/* defines the static data member name of class context, declared type base (token is the
   storage class; any is an error).  The class must have a static member of that name and
   type, else an error and 0.  The member symbol becomes a defined static and gets storage:
   with flag (an initializer follows) in the data segment or a far segment; a far array in
   huge data segments; otherwise zero bytes in the data segment.  Returns the member
   symbol */
u16 DEFINE_STATIC_DATA_MEMBER(u16 base, u16 context, u16 name, u16 token, u8 flag)
{
    if (token != NO_STORAGE_CLASS)
        REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT_258, TOKEN_NAMES_AT(token));
    u16 member = FIND_MEMBER_BY_NAME(name, context);
    if (!member) {
        farptr text = NAME_TEXT_COPY(name);          /* pascal: left to right */
        REPORT_DIAGNOSTIC(MSG_NOT_MEMBER, (i32)text, FORMAT_TYPE(context));
    } else if ((MEMBER_B(member, MEMB_FLAGS) & 3) != 2 || !TYPES_COMPATIBLE(base, SYM_W(MEMBER_W(member, MEMB_VALUE), SYM_TYPE), 1)) {
        REPORT_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, (i32)FORMAT_MEMBER_NAME(name, 0, base, context), 0);
        member = 0;
    }
    if (!member)
        return 0;
    u16 method = MEMBER_W(member, MEMB_VALUE);
    u8 special = TYPE_W(SYM_W(method, SYM_TYPE), TYPE_KIND) == TK_ARRAY && (TYPE_B(SYM_W(method, SYM_TYPE), TYPE_ATTRS) & 0x40);
    SYM_B(method, SYM_STORAGE_CLASS) = (SYM_B(method, SYM_STORAGE_CLASS) & 7) | 8;
    SYM_B(method, SYM_FLAGS) |= 1;
    u16 prepared = PREPARE_SYMBOL(method);
    CLEAR_PREPARED_FLAGS(prepared, 0x80);
    if (flag) {
        u16 segment = (special || (SYM_B(method, SYM_FLAGS) & 0x80)) ? DEFINE_FAR_SEGMENT() : DATA_SEGMENT_ID;
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(segment));
    } else if (special) {
        u16 segment = DEFINE_HUGE_DATA_SEGMENTS(SYM_W(method, SYM_TYPE));
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(segment));
        EMIT_HUGE_DATA(method);
    } else {
        CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(prepared), A16(DATA_SEGMENT_ID));
        u16 saved = SELECT_SYMBOL_STREAM(method);
        EMIT_ZERO_BYTES((u16)TYPE_SIZE(base));
        SET_STREAM(saved);
    }
    return method;
}

/* merges the default arguments of a redeclaration: left is the new function type, right
   the old one.  A parameter defaulted in both is an error (A1h), a parameter without a
   default after one with a default is another (7Ah); the default found is stored in the
   new type.  Function flag 80h is carried over from the old type */
void BCC_TYPE_LINK(u16 left, u16 right)
{
    u16 seen = 0;
    u16 old = TYPE_W(right, TYPE_PARAMS), new = TYPE_W(left, TYPE_PARAMS);
    while (old) {
        if (DEFAULT(old) != 0 && DEFAULT(new) != 0)
            REPORT_CURRENT_TOKEN(0xA1);
        else if (seen != 0 && DEFAULT(old) == 0 && DEFAULT(new) == 0)
            REPORT_CURRENT_TOKEN(0x7A);
        else if (DEFAULT(old) != 0 || DEFAULT(new) != 0) {
            if (DEFAULT(new) != 0)
                ++seen;
            u16 value = DEFAULT(old) == 0 ? DEFAULT(new) : DEFAULT(old);
            DEFAULT(new) = value;
        }
        old = FORMAL_W(old, FORMAL_NEXT);
        new = FORMAL_W(new, FORMAL_NEXT);
    }
    TYPE_B(left, TYPE_FUNC_FLAGS) |= TYPE_B(right, TYPE_FUNC_FLAGS) & 0x80;
}

/* 1 if two function types differ in their parameters, so the functions can be
   overloaded.  When only one is a member function its this parameter is skipped.
   Parameters match when compatible or when one is an arithmetic type and the other a
   reference to it.  The ellipsis flag must agree too */
u8 BCC_TYPE_COMPARE(u16 left, u16 right)
{
    u16 a = TYPE_W(left, TYPE_PARAMS), b = TYPE_W(right, TYPE_PARAMS);
    if (TYPE_W(left, TYPE_MEMBER_CLASS) != TYPE_W(right, TYPE_MEMBER_CLASS)) {
        if (!TYPE_W(left, TYPE_MEMBER_CLASS))
            b = FORMAL_W(b, FORMAL_NEXT);
        if (!TYPE_W(right, TYPE_MEMBER_CLASS))
            a = FORMAL_W(a, FORMAL_NEXT);
    }
    while (a && b) {
        u16 first = FORMAL_W(a, FORMAL_TYPE), second = FORMAL_W(b, FORMAL_TYPE);
        if (!BCC_TYPE_PRED(first, second)) {
            if ((KIND_FLAGS(first) & 3) && (KIND_FLAGS(second) & 0x14) && (TYPE_B(second, TYPE_ATTRS) & 0x20)) {
                if (!BCC_TYPE_PRED(first, TYPE_W(second, TYPE_TARGET)))
                    return 1;
            } else if ((KIND_FLAGS(second) & 3) && (KIND_FLAGS(first) & 0x14) && (TYPE_B(first, TYPE_ATTRS) & 0x20)) {
                if (!BCC_TYPE_PRED(second, TYPE_W(first, TYPE_TARGET)))
                    return 1;
            } else
                return 1;
        }
        a = FORMAL_W(a, FORMAL_NEXT);
        b = FORMAL_W(b, FORMAL_NEXT);
    }
    return a != b || (TYPE_B(left, TYPE_FUNC_FLAGS) & 4) != (TYPE_B(right, TYPE_FUNC_FLAGS) & 4);
}

/* a function named like the overload chain node is declared with type value and linkage
   mode.  A compatible type in the chain is a redeclaration (*selected gets it, default
   arguments are merged, the linkage must agree); a type that cannot be told apart from an
   existing one is an error; two overloads with "C" linkage (mode 2) are an error.
   Conversion functions (kind 2) are never reported as indistinguishable, and redeclaring
   one is an error.  main cannot be overloaded.  *result is 1 when a new overload must be
   added, 0 when an existing function was matched (or on error) */
void BCC_TYPE_MATCH(u16 node, u16 value, u16 mode, farptr selected, farptr result)
{
    u8 active = value != 0, found = 0;
    u16 cursor = node, type;
    u8 special = SYM_W(cursor, SYM_FUNC_KIND) == 2;
    if (SYM_W(node, SYM_NAME) == MAIN_SYMBOL && !(SYM_B(node, SYM_FLAGS) & 0x10)) {
        B(result) = 0;
        REPORT_CURRENT_TOKEN(MSG_CANNOT_OVERLOAD_MAIN);
        return;
    }
    while (active && cursor) {
        type = SYM_W(cursor, SYM_TYPE);
        if (TYPES_COMPATIBLE(type, value, 0)) {
            found = 1;
            W(selected) = cursor;
            active = 1;
        } else {
            if (mode == 2 && SYM_W(cursor, SYM_LINKAGE) == 2)
                REPORT_CURRENT_TOKEN(MSG_ONLY_ONE_SET);
            if (!special)
                active = BCC_TYPE_COMPARE(type, value);
            if (!active) {
                i32 spelled = SPELL_SYMBOL_WITH_TYPE(cursor, value);   /* pascal: left to right */
                REPORT_DIAGNOSTIC(MSG_CANNOT_DISTINGUISHED, spelled, (i32)FORMAT_SYMBOL(cursor));
            }
        }
        cursor = SYM_W(cursor, SYM_NEXT_OVERLOAD);
    }
    if (active && found) {
        type = SYM_W(W(selected), SYM_TYPE);
        if (mode && SYM_W(W(selected), SYM_LINKAGE) != mode) {
            i32 spelled = (i32)FORMAT_SYMBOL(W(selected));
            REPORT_DIAGNOSTIC(MSG_WAS_PREVIOUSLY, spelled, LINKAGE_NAME(SYM_W(W(selected), SYM_LINKAGE)));
        }
        if (special)
            REPORT_DIAGNOSTIC(MSG_MULTIPLE_DECLARATION, (i32)FORMAT_SYMBOL(W(selected)), 0);
        if (!(SYM_B(W(selected), SYM_FLAGS) & 2) && CURRENT_SCOPE == GLOBAL_SCOPE)
            SYM_W(W(selected), SYM_TYPE) = value;
        if (value != type)
            BCC_TYPE_LINK(value, type);
        active = 0;
    }
    B(result) = active;
}

/* checks function record of type type when it is declared.  Marks it (SYM_FUNC_FLAGS 1)
   unless it is a conversion function.  By the token its name stands for: operator new
   (6Ch) must return void * and take a size_t first; operator delete (69h) must return void
   and take void * and optionally size_t; operator() and [] (1, 3), = (11), -> (30h, must
   return a class or pointer), destructors (6) and conversion functions (37h) must be
   members; a constructor (5) that takes its own class by value is an error and the
   parameter is made a reference; other operators must have one (mode 1) or two (mode 2)
   operands counting this; + - * & and token 42 may have either.  A non-member operator
   needs a class (or reference to class) operand.  count includes this and, for a
   destructor, not its hidden flags parameter */
void BCC_TYPE_VALIDATE(u16 record, u16 type)
{
    i16 count = 0, mode = 0;
    u8 requires_result = 0;
    u16 parameter, argument;
    if (SYM_W(record, SYM_FUNC_KIND) != 2)
        SYM_W(record, SYM_FUNC_FLAGS) |= 1;
    for (parameter = TYPE_W(type, TYPE_PARAMS); parameter; parameter = FORMAL_W(parameter, FORMAL_NEXT))
        ++count;
    if (SYM_W(record, SYM_FUNC_KIND) == 4)
        --count;
    u8 has_result = TYPE_W(type, TYPE_MEMBER_CLASS) != 0;
    switch (TOKEN_FROM_NAME(SYM_W(record, SYM_NAME))) {
    case 108:
        if ((KIND_FLAGS(TYPE_W(type, TYPE_TARGET)) & 0x14) == 0 || TYPE_W(TYPE_W(TYPE_W(type, TYPE_TARGET), TYPE_TARGET), TYPE_KIND) != TK_VOID)
            REPORT_CURRENT_TOKEN(MSG_OPERATOR_NEW_MUST);
        if (count == 0) {
            REPORT_DIAGNOSTIC(MSG_MUST_DECLARED_ONE, (i32)STR_OPERATOR_NEW_P, 0);
            return;
        }
        if (!TYPES_COMPATIBLE(FORMAL_W(TYPE_W(type, TYPE_PARAMS), FORMAL_TYPE), SIZE_T_TYPE, 1))
            REPORT_CURRENT_TOKEN(MSG_OPERATOR_NEW_MUST_HAVE);
        return;
    case 105:
        if (TYPE_W(type, TYPE_TARGET) != VOID_TYPE)
            REPORT_CURRENT_TOKEN(MSG_OPERATOR_DELETE_MUST);
        if (count == 0 || count > 2) {
            REPORT_DIAGNOSTIC(MSG_MUST_DECLARED_ONE, (i32)STR_OPERATOR_DELETE_P, 0);
            return;
        }
        parameter = TYPE_W(type, TYPE_PARAMS);
        if ((KIND_FLAGS(FORMAL_W(parameter, FORMAL_TYPE)) & 0x14) == 0
            || TYPE_W(TYPE_W(FORMAL_W(parameter, FORMAL_TYPE), TYPE_TARGET), TYPE_KIND) != TK_VOID
            || (count == 2 && !TYPES_COMPATIBLE(FORMAL_W(FORMAL_W(parameter, FORMAL_NEXT), FORMAL_TYPE), SIZE_T_TYPE, 1)))
            REPORT_CURRENT_TOKEN(MSG_DECLARE_OPERATOR);
        return;
    case 1:
    case 3:
        requires_result = 1;
        break;
    case 5:
        requires_result = 1;
        parameter = FORMAL_W(TYPE_W(type, TYPE_PARAMS), FORMAL_NEXT);
        if (TAG_W(TYPE_W(TYPE_W(type, TYPE_MEMBER_CLASS), TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 4)
            parameter = FORMAL_W(parameter, FORMAL_NEXT);
        if (!parameter)
            break;
        if (FORMAL_W(parameter, FORMAL_NEXT) != 0 && DEFAULT(FORMAL_W(parameter, FORMAL_NEXT)) == 0)
            break;
        if (TYPES_COMPATIBLE(FORMAL_W(parameter, FORMAL_TYPE), TYPE_W(type, TYPE_MEMBER_CLASS), 1)) {
            REPORT_DIAGNOSTIC(MSG_CONSTRUCTOR_NOT, (i32)FORMAT_SYMBOL(record), 0);
            u16 reference = MAKE_POINTER_TYPE(FORMAL_W(parameter, FORMAL_TYPE), 0, 1);
            FORMAL_W(parameter, FORMAL_TYPE) = reference;
        }
        break;
    case 48:
        if (!(KIND_FLAGS(TYPE_W(type, TYPE_TARGET)) & 0x40) && !(KIND_FLAGS(TYPE_W(type, TYPE_TARGET)) & 0x14))
            REPORT_CURRENT_TOKEN(MSG_OPERATOR_MUST_RETURN);
        requires_result = 1;
        mode = 1;
        break;
    case 6:
    case 55:
        requires_result = 1;
        mode = 1;
        break;
    case 11:
        requires_result = 1;
        mode = 2;
        break;
    case 43: case 45: case 46:
        mode = 1;
        break;
    case 8: case 12: case 13: case 14: case 15: case 16: case 17: case 18: case 19: case 20:
    case 21: case 25: case 26: case 28: case 29: case 30: case 31: case 34: case 35: case 36:
    case 37: case 38: case 39: case 40: case 41: case 102:
        mode = 2;
        break;
    case 22: case 23: case 24: case 27: case 42:
        if ((has_result != 0 && count == 0) || count == 1 || (!has_result && count == 2))
            mode = count;
        else
            mode = 2;
        break;
    }
    if (requires_result != 0 && !has_result)
        REPORT_DIAGNOSTIC(MSG_MUST_MEMBER_FUNCTION_192, (i32)FORMAT_SYMBOL(record), 0);
    if (mode != 0 && (mode != count || mode > 2)) {
        i16 code;
        if (mode == 1 && has_result != 0)
            code = 0x90;
        else if (mode == 1 || (has_result != 0 && mode == 2))
            code = 0x91;
        else
            code = 0x92;
        REPORT_DIAGNOSTIC(code, (i32)FORMAT_SYMBOL(record), 0);
    }
    if (count > 0) {
        parameter = TYPE_W(type, TYPE_PARAMS);
        argument = FORMAL_W(parameter, FORMAL_TYPE);
        if (KIND_FLAGS(argument) & 0x14)
            argument = TYPE_W(argument, TYPE_TARGET);
        if (!(KIND_FLAGS(argument) & 0x40) && count > 1) {
            parameter = FORMAL_W(parameter, FORMAL_NEXT);
            argument = FORMAL_W(parameter, FORMAL_TYPE);
            if (KIND_FLAGS(argument) & 0x14)
                argument = TYPE_W(argument, TYPE_TARGET);
        }
        if (!(KIND_FLAGS(argument) & 0x40))
            REPORT_DIAGNOSTIC(MSG_MUST_MEMBER_FUNCTION, (i32)FORMAT_SYMBOL(record), 0);
    }
}

/* the first overload of member at or after result whose type is compatible with type;
   symbol record 0's type word is the sentinel that ends the search */
static u16 find_overload(u16 result, u16 type)
{
    SYM_W(0, SYM_TYPE) = type;
    while (!TYPES_COMPATIBLE(type, SYM_W(result, SYM_TYPE), 1))
        result = SYM_W(result, SYM_NEXT_OVERLOAD);
    return result;
}

/* finds the member function of class scope that the out-of-class definition X::name with
   function type type defines; kind is the special kind (3 constructor when name is the
   class name, which is then replaced by CTOR_NAME).  Looks for an overload with a
   compatible type, then again after adding the this parameter, then (for a class with
   dynamically dispatched functions, function flag 40h changed to 1) for a dynamically
   dispatched one.  The member's type is replaced by the new one (merging defaults).  When
   none matches, an error is reported and a new member function symbol is declared anyway,
   so parsing can go on */
u16 TYPE_BUILD(u16 scope, u16 type, u16 name, u16 kind)
{
    u16 result = LOOKUP_NAME(name);
    if (result && (SYM_B(result, SYM_STORAGE_CLASS) >> 3) == 11 && SYM_W(result, SYM_TYPE) == scope) {
        kind = 3;
        name = CTOR_NAME;
    }
    u16 member = FIND_MEMBER_BY_NAME(name, scope);
    result = 0;
    if (member) {
        if ((MEMBER_B(member, MEMB_FLAGS) & 3) == 3) {
            result = find_overload(MEMBER_W(member, MEMB_VALUE), type);
            if (!result) {
                ADD_THIS_PARAMETER(scope, type);
                result = find_overload(MEMBER_W(member, MEMB_VALUE), type);
            }
            if (!result && (TAG_W(TYPE_W(scope, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x800) && (TYPE_B(type, TYPE_FUNC_FLAGS) & 0x40)) {
                TYPE_B(type, TYPE_FUNC_FLAGS) &= 0xBF;
                TYPE_B(type, TYPE_FUNC_FLAGS) |= 1;
                result = find_overload(MEMBER_W(member, MEMB_VALUE), type);
                if (result && !(SYM_W(result, SYM_FUNC_FLAGS) & 0x100))
                    result = 0;
            }
        }
        if (result && SYM_W(result, SYM_TYPE) != type) {
            u16 previous = SYM_W(result, SYM_TYPE);
            SYM_W(result, SYM_TYPE) = type;
            BCC_TYPE_LINK(type, previous);
        }
    }
    if (!result) {
        farptr spelled = FORMAT_MEMBER_NAME(name, kind, type, scope);   /* pascal: left to right */
        REPORT_DIAGNOSTIC(MSG_NOT_MEMBER, (i32)spelled, FORMAT_TYPE(scope));
        /* the original frame from BP-8: flag at 1, result at 4 */
        u16 mark = scratch_mark();
        farptr v = scratch_alloc(8);
        farptr declared = fp_add(v, 4), flag = fp_add(v, 1);
        W(declared) = 0;
        DECLARE_FUNCTION(type, name, kind, 0x36, declared, flag);
        result = W(declared);
        scratch_release(mark);
        SYM_W(result, SYM_OWNER_CLASS) = TAG_W(TYPE_W(scope, TYPE_TAG_BODY), TAG_SYMBOL);
        SYM_B(result, SYM_FLAGS) |= 0x10;
        SYM_W(result, SYM_FUNC_FLAGS) |= 1;
    }
    return result;
}

/* prepares the type node of member function owner of class current before its
   definition: sets CURRENT_CLASS_TYPE, recognizes a constructor (a name equal to the class
   name; *kind becomes 3), gives constructors a result type of pointer to the class (they
   return this) and the hidden virtual-base flag (73h) when the class has virtual bases,
   and destructors a void result and the hidden flags parameter (69h).  flag 0 (a return
   type was written) is an error for both */
void BCC_TYPE_NORMALIZE(u16 current, u16 node, u16 owner, farptr kind, u8 flag)
{
    CURRENT_CLASS_TYPE = current;
    if (W(kind) == 0) {
        u16 outer = LOOKUP_NAME(owner);
        if (outer != 0 && (SYM_B(outer, SYM_STORAGE_CLASS) >> 3) == 11 && SYM_W(outer, SYM_TYPE) == CURRENT_CLASS_TYPE)
            W(kind) = 3;
    }
    if (W(kind) == 3) {
        if (TAG_W(TYPE_W(current, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 4)
            ADD_HIDDEN_PARAMETER(node, 0x73);
        if (!flag)
            REPORT_NAME_DIAGNOSTIC(MSG_CONSTRUCTOR_CANNOT, owner);
        u16 pointer = MAKE_POINTER_TYPE(CURRENT_CLASS_TYPE, 0, 0);
        TYPE_W(node, TYPE_TARGET) = pointer;
    } else if (W(kind) == 4) {
        if (!flag)
            REPORT_NAME_DIAGNOSTIC(MSG_DESTRUCTOR_CANNOT_HAVE, owner);
        TYPE_W(node, TYPE_TARGET) = VOID_TYPE;
        ADD_HIDDEN_PARAMETER(node, 0x69);
    }
}
