/* typespel.c: from bcc20/src/diag/TYPESPEL.C: turns types and symbols into readable text
   for message arguments, such as "int far *", "X::f(int,char *) const" or "operator =".
   Used by the parser and the C++ code when a message names a type or a function.
   Every public FORMAT_* function appends its text to DIAG_NAME_BUFFER (shared with diag.c;
   its text is the memory of BCC_DEBUG_NAME), adds a 0 and returns a far pointer to where
   its text starts.  Several texts can so be built for one message; the buffer is emptied
   after the message is printed (REPORT_DIAGNOSTIC_AT).  Some return the pointer as a long,
   the form REPORT_DIAGNOSTIC takes its arguments in.  Text beyond 511 bytes is dropped.
   The work is done by APPEND_TYPE_SPELLING, which spells a type recursively, and
   APPEND_PARAM_LIST and APPEND_FUNCTION_NAME.  Records are read through the pool accessors
   with the original's raw offsets: type: 0 TYPE_KIND, 2 TYPE_ATTRS (1 const, 2 volatile,
   20h reference), 3 TYPE_MEMBER_CLASS, 5 TYPE_TAG_BODY, 7 TYPE_TARGET, 9 TYPE_PARAMS or
   TYPE_ARRAY_COUNT, 11 TYPE_CALL_CONV (2 pascal), 12 TYPE_FUNC_FLAGS (1 far, 4 ellipsis, 8
   no prototype), 13 TYPE_PTR_MODE (11 member pointer); symbol: 0 SYM_OWNER_CLASS, 2
   SYM_NAME, 4 SYM_TYPE, 6 SYM_FLAGS (10h member), 7 SYM_STORAGE_CLASS (class 11 in bits
   3-7 a tag name, 9 probably typedef), 15 SYM_FUNC_KIND; tag body: 6 TAG_SYMBOL, 24
   TAG_CLASS_FLAGS (4 virtual bases); member: 2 MEMB_NAME, 4 MEMB_FLAGS, 6 MEMB_VALUE, 10
   MEMB_CLASS; formal: 0 FORMAL_NEXT, 2 FORMAL_TYPE; expression: 8 EXPR_TYPE, 10 EXPR_LEFT,
   12 EXPR_RIGHT, 14 EXPR_SCOPE_CLASS.  Type kinds: 13..16 pointers, 17 array, 18
   function, 19 struct, 20 union, 21 enum; C33_TYPE_NAMES holds the word for each kind.
   In C (CPP_MODE clear), "struct", "union", "enum" and "void" are spelled as C needs. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "fields.h"
#include "protos.h"
#include "calls.h"

#define T(n, o) TYPE_W((n), (o))
#define TB(n, o) TYPE_B((n), (o))
#define TS(n, o) ((i8)TYPE_B((n), (o)))
#define TL(n, o) TYPE_L((n), (o))
#define S(n, o) SYM_W((n), (o))
#define SYB(n, o) SYM_B((n), (o))
#define E(n, o) EXPR_W((n), (o))
#define M(n, o) MEMBER_W((n), (o))
#define MB(n, o) MEMBER_B((n), (o))
#define LINK(n, o) W(MK_FP(TAG_BODY_POOL_SEG, (n) + (o)))
#define PARAM(n, o) W(MK_FP(FORMAL_POOL_SEG, (n) + (o)))
#define BUFFER DIAG_NAME_BUFFER_P
#define BUFFER_START() fp_add(BCC_DEBUG_NAME_P, W(DIAG_NAME_BUFFER_P))

/* appends one byte to out; bytes past 511 are dropped */
void APPEND_CHAR(u8 value, farptr out)
{
    if (W(out) < 511) {
        B(fp_add(out, 2 + W(out))) = value;
        W(out)++;
    }
}

/* appends a 0-terminated text (without the 0) */
void APPEND_TEXT(farptr text, farptr out)
{
    for (;;) {
        u8 value = B(text);
        text = fp_add(text, 1);
        if (value == 0)
            break;
        APPEND_CHAR(value, out);
    }
}

/* the text of name record name: its offset and a near pointer to the word holding its
   segment */
static farptr name_text(u16 name)
{
    return MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET));
}

/* appends the name of symbol, if it has one */
void APPEND_SYMBOL_NAME(u16 symbol, farptr out)
{
    if (symbol && S(symbol, 2))
        APPEND_TEXT(name_text(S(symbol, 2)), out);
}

/* appends "(t1,t2,...)" for function type type.  For a C++ member function (it has a
   class, TYPE_MEMBER_CLASS) the first parameter is the hidden this and is left out; skip
   leaves out one more (the extra hidden parameter of a constructor of a class with virtual
   bases).  A function without prototype (flag 8) shows "()"; an empty prototyped list shows
   "(void)" in C and "()" in C++; flag 4 adds "..." */
void APPEND_PARAM_LIST(u16 type, u8 skip, farptr out)
{
    APPEND_CHAR('(', out);
    u16 parameter = T(type, 9);
    if (CPP_MODE && T(type, 3)) {
        parameter = PARAM(parameter, 0);
        if (skip)
            parameter = PARAM(parameter, 0);
    }
    if (!(TB(type, 12) & 8)) {
        if (!parameter && !(TB(type, 12) & 4)) {
            if (!CPP_MODE)
                APPEND_TEXT(STR_VOID_P, out);
        } else
            while (parameter) {
                APPEND_TYPE_SPELLING(PARAM(parameter, 2), out);
                parameter = PARAM(parameter, 0);
                if (parameter || (TB(type, 12) & 4))
                    APPEND_CHAR(',', out);
            }
    }
    if (TB(type, 12) & 4)
        APPEND_TEXT(STR_DOT_DOT_DOT_P, out);
    APPEND_CHAR(')', out);
}

/* the word C33_TYPE_NAMES holds for a type kind (a near pointer) */
static farptr kind_name(u16 kind) { return DSPTR(C33_TYPE_NAMES_AT(kind)); }

/* appends the spelling of type: qualifiers, then by kind: enum/struct/union tag names,
   pointers ("int near *", function pointers as "int (far *)(int)", member pointers as
   "int (near X::*)()" with "pascal" when needed), references with '&', arrays with their
   count, functions with their parameters, and plain kinds by name.  0 is spelled "?" */
void APPEND_TYPE_SPELLING(u16 type, farptr out)
{
    if (!type) {
        APPEND_CHAR('?', out);
        return;
    }
    /* leading const/volatile, except for kinds with EXPR_FLAGS bits 14h (probably the
       pointer kinds, whose qualifiers are written after the '*' below) */
    if (!(EXPR_FLAGS_AT(T(type, 0)) & 0x14)) {
        if (TB(type, 2) & 1)
            APPEND_TEXT(STR_CONST_P, out);
        if (TB(type, 2) & 2)
            APPEND_TEXT(STR_VOLATILE_P, out);
    }
    switch (T(type, 0)) {
    case 21:
        if (!CPP_MODE)
            APPEND_TEXT(STR_ENUM_P, out);
        if ((SYB(LINK(T(type, 5), 6), 7) >> 3) == 11)
            APPEND_SYMBOL_NAME(LINK(T(type, 5), 6), out);
        else if (CPP_MODE)
            APPEND_TEXT(STR_ENUM_2_P, out);
        break;
    case 13:
    case 14:
    case 15:
    case 16:
        if (T(T(type, 7), 0) == 18) {
            /* pointer to function: result type, "(", then "far X::" for a member pointer or
               the pointer word, then "*)" and the parameter list */
            u16 function = T(type, 7);
            u8 member_pointer = CPP_MODE && TS(type, 13) == 11;
            APPEND_TYPE_SPELLING(T(function, 7), out);
            APPEND_CHAR('(', out);
            if (member_pointer) {
                APPEND_TEXT((TB(function, 12) & 1) ? STR_FAR_P : STR_NEAR_P, out);
                APPEND_TYPE_SPELLING(T(function, 3), out);
                APPEND_TEXT(STR_COLON_COLON_P, out);
            } else
                APPEND_TEXT(kind_name(T(type, 0)), out);
            if (TB(function, 11) == 2)
                APPEND_TEXT(STR_PASCAL_P, out);
            APPEND_TEXT(STR_STAR_RPAREN_P, out);
            APPEND_PARAM_LIST(function, 0, out);
        } else {
            APPEND_TYPE_SPELLING(T(type, 7), out);
            APPEND_CHAR(' ', out);
            if (CPP_MODE && T(T(type, 7), 3)) {
                APPEND_TYPE_SPELLING(T(T(type, 7), 3), out);
                APPEND_TEXT(STR_COLON_COLON_P, out);
            } else
                APPEND_TEXT(kind_name(T(type, 0)), out);
            /* a near pointer with mode 1..3 gets its qualifier word from
               C33_POINTER_QUALIFIERS (far pointers) */
            if (T(type, 0) == 13 && TS(type, 13) != 0 && TS(type, 13) < 4)
                APPEND_TEXT(D(fp_add(C33_POINTER_QUALIFIERS_P, TS(type, 13) * 4)), out);
            APPEND_CHAR((TB(type, 2) & 0x20) ? '&' : '*', out);
        }
        if (TB(type, 2) & 1)
            APPEND_TEXT(STR_CONST_2_P, out);
        if (TB(type, 2) & 2)
            APPEND_TEXT(STR_VOLATILE_2_P, out);
        break;
    case 17:
        APPEND_TYPE_SPELLING(T(type, 7), out);
        APPEND_CHAR('[', out);
        /* an array with attribute 20h is printed as "[]", probably one of unknown size */
        if (!(TB(type, 2) & 0x20))
            APPEND_DECIMAL((u32)TL(type, 9), out);
        APPEND_CHAR(']', out);
        break;
    case 19:
    case 20:
        if (!CPP_MODE)
            APPEND_TEXT(kind_name(T(type, 0)), out);
        if ((SYB(LINK(T(type, 5), 6), 7) >> 3) == 11)
            APPEND_SYMBOL_NAME(LINK(T(type, 5), 6), out);
        else if (CPP_MODE)
            APPEND_TEXT(T(type, 0) == 19 ? STR_STRUCT_P : STR_UNION_P, out);
        break;
    case 18:
        APPEND_TYPE_SPELLING(T(type, 7), out);
        APPEND_PARAM_LIST(type, 0, out);
        break;
    default:
        APPEND_TEXT(kind_name(T(type, 0)), out);
        break;
    }
}

/* appends the name of a function symbol.  In C++ the class owner (or the symbol's own
   class when it is a member) comes first as "X::".  Then by SYM_FUNC_KIND: 0 the plain
   name, 1 "operator " and the name, 2 "operator " and the result type (a conversion
   operator), 3 the class name (constructor; *skip is set when the class has virtual bases,
   so callers drop the extra hidden argument), 4 "~" and the class name.  Typedef symbols
   (class 9) and non-functions just give their name */
void APPEND_FUNCTION_NAME(u16 symbol, u16 owner, farptr skip, farptr out)
{
    B(skip) = 0;
    if (CPP_MODE) {
        if (!owner && (SYB(symbol, 6) & 0x10))
            owner = S(S(symbol, 0), 4);
        if (owner) {
            APPEND_SYMBOL_NAME(LINK(T(owner, 5), 6), out);
            APPEND_TEXT(STR_COLON_COLON_P, out);
        }
        if ((SYB(symbol, 7) >> 3) == 9 || T(S(symbol, 4), 0) != 18) {
            APPEND_SYMBOL_NAME(symbol, out);
            return;
        }
        switch (S(symbol, 15)) {
        case 0:
            APPEND_SYMBOL_NAME(symbol, out);
            return;
        case 1:
            APPEND_TEXT(STR_OPERATOR_3_P, out);
            break;
        case 2:
            APPEND_TEXT(STR_OPERATOR_3_P, out);
            APPEND_TYPE_SPELLING(T(S(symbol, 4), 7), out);
            return;
        case 3:
            B(skip) = (LINK(T(owner, 5), 24) & 4) != 0;
            APPEND_SYMBOL_NAME(LINK(T(owner, 5), 6), out);
            return;
        case 4:
            APPEND_CHAR('~', out);
            APPEND_SYMBOL_NAME(LINK(T(owner, 5), 6), out);
            return;
        default:
            return;
        }
    }
    APPEND_SYMBOL_NAME(symbol, out);
}

/* spells a call as written: the called function's name and the types of the actual
   arguments, "f(int,char *)", for messages such as "could not find a match".  expression
   is the call node: its left operand is the function node (whose left is the symbol and
   whose EXPR_SCOPE_CLASS, if set, replaces owner), its right operand the argument list
   (each list node: next in EXPR_LEFT, the argument in EXPR_RIGHT).  For a member call the
   hidden this argument (and the virtual-base argument of a constructor) is skipped; for a
   destructor no arguments are shown */
farptr FORMAT_CALL_SIGNATURE(u16 expression, u16 owner)
{
    u16 mark = scratch_mark();
    farptr skip = scratch_alloc(2);
    farptr start = BUFFER_START();
    if (E(E(expression, 10), 14))
        owner = E(E(expression, 10), 14);
    APPEND_FUNCTION_NAME(E(E(expression, 10), 10), owner, skip, BUFFER);
    APPEND_CHAR('(', BUFFER);
    if (!CPP_MODE || S(E(E(expression, 10), 10), 15) != 4) {
        u16 argument = E(expression, 12);
        if (CPP_MODE && owner) {
            if (argument)
                argument = E(argument, 10);
            if (B(skip) && argument)
                argument = E(argument, 10);
        }
        while (argument) {
            APPEND_TYPE_SPELLING(E(E(argument, 12), 8), BUFFER);
            argument = E(argument, 10);
            if (argument)
                APPEND_CHAR(',', BUFFER);
        }
    }
    APPEND_CHAR(')', BUFFER);
    APPEND_CHAR(0, BUFFER);
    scratch_release(mark);
    return start;
}

/* spells symbol: "name", or in C++ for a function "X::name(params) const" */
farptr FORMAT_SYMBOL(u16 symbol)
{
    u16 mark = scratch_mark();
    farptr skip = scratch_alloc(2);
    farptr start = BUFFER_START();
    u16 owner = (SYB(symbol, 6) & 0x10) ? S(S(symbol, 0), 4) : 0;
    APPEND_FUNCTION_NAME(symbol, owner, skip, BUFFER);
    if (CPP_MODE && T(S(symbol, 4), 0) == 18) {
        if (S(symbol, 15) == 4)
            APPEND_TEXT(STR_LPAREN_RPAREN_P, BUFFER);
        else
            APPEND_PARAM_LIST(S(symbol, 4), B(skip), BUFFER);
        if (TB(S(symbol, 4), 2) & 1)
            APPEND_TEXT(STR_CONST_3_P, BUFFER);
        if (TB(S(symbol, 4), 2) & 2)
            APPEND_TEXT(STR_VOLATILE_3_P, BUFFER);
    }
    APPEND_CHAR(0, BUFFER);
    scratch_release(mark);
    return start;
}

/* spells a class member as "X::name".  Static members and member functions (kinds 2 and 3
   in MEMB_FLAGS) are spelled through their symbol (FORMAT_SYMBOL) */
i32 FORMAT_MEMBER(u16 member)
{
    farptr start = BUFFER_START();
    u16 type = 0;
    switch (MB(member, 4) & 3) {
    case 2:
    case 3:
        return (i32)FORMAT_SYMBOL(M(member, 6));
    case 0:
    case 1:
        type = M(member, 10);
        break;
    }
    APPEND_SYMBOL_NAME(LINK(T(type, 5), 6), BUFFER);
    APPEND_TEXT(STR_COLON_COLON_P, BUFFER);
    farptr text = name_text(M(member, 2));
    for (;;) {
        u8 value = B(text);
        text = fp_add(text, 1);
        if (value == 0)
            break;
        APPEND_CHAR(value, BUFFER);
    }
    APPEND_CHAR(0, BUFFER);
    return (i32)start;
}

/* spells symbol as if its type were type (for example to show the other one of two
   clashing overloads), then puts the real type back */
i32 SPELL_SYMBOL_WITH_TYPE(u16 symbol, u16 type)
{
    u16 saved_type = S(symbol, 4);
    S(symbol, 4) = type;
    farptr text = FORMAT_SYMBOL(symbol);
    S(symbol, 4) = saved_type;
    return (i32)text;
}

/* the name of the class, struct, union or enum type type, as text */
i32 CLASS_NAME_OF_TYPE(u16 type)
{
    return (i32)SYMBOL_NAME_TEXT(LINK(T(type, 5), 6));
}

/* spells a compiler-generated special member of class type: kind 11
   "X::operator=(...)", kind 6 the destructor "X::~X(...)", else the constructor
   "X::X(...)".  reference set puts "X&" between the parentheses (copy constructor or
   assignment) */
i32 FORMAT_SPECIAL_MEMBER(u16 kind, u16 reference, u16 type)
{
    farptr start = BUFFER_START();
    u16 symbol = LINK(T(type, 5), 6);
    APPEND_SYMBOL_NAME(symbol, BUFFER);
    APPEND_TEXT(STR_COLON_COLON_P, BUFFER);
    if (kind == 11)
        APPEND_TEXT(STR_OPERATOR_4_P, BUFFER);
    else {
        if (kind == 6)
            APPEND_CHAR('~', BUFFER);
        APPEND_SYMBOL_NAME(symbol, BUFFER);
    }
    APPEND_CHAR('(', BUFFER);
    if (reference) {
        APPEND_SYMBOL_NAME(symbol, BUFFER);
        APPEND_CHAR('&', BUFFER);
    }
    APPEND_CHAR(')', BUFFER);
    APPEND_CHAR(0, BUFFER);
    return (i32)start;
}

/* spells type alone, for example "unsigned int far *" */
i32 FORMAT_TYPE(u16 type)
{
    farptr start = BUFFER_START();
    APPEND_TYPE_SPELLING(type, BUFFER);
    APPEND_CHAR(0, BUFFER);
    return (i32)start;
}

/* text for messages saying what kind of type an operator needs, by category code; anything
   else "a simple type" */
farptr REQUIRED_TYPE_TEXT(u16 category)
{
    switch (category) {
    case 1:
        return STR_AN_INTEGRAL_TYPE_P;
    case 20:
        return STR_A_POINTER_TYPE_P;
    case 7:
        return STR_A_SCALAR_TYPE_P;
    case 3:
        return STR_AN_ARITHMETIC_TYPE_P;
    default:
        return STR_A_SIMPLE_TYPE_P;
    }
}

/* the name of a linkage (SYM_LINKAGE): 1 "C++", 2 "C", 3 "Pascal"; others "C++" */
i32 LINKAGE_NAME(u16 language)
{
    switch (language) {
    case 1:
        return (i32)STR_C_3_P;
    case 2:
        return (i32)STR_C_4_P;
    case 3:
        return (i32)STR_PASCAL_2_P;
    }
    return (i32)STR_C_3_P;
}

/* spells a member name that may not have a symbol yet (for "not a member" and similar
   messages).  kind as SYM_FUNC_KIND: 0 the name, 1 "operator " and the name, 2 "operator "
   and the target of type (or just "type conversion" when type is 0), 3 the class name of
   member_type (constructor), 4 "~" and that name.  When type is a function type its
   parameter list follows.  0 for an unknown kind */
farptr FORMAT_MEMBER_NAME(u16 name, u16 kind, u16 type, u16 member_type)
{
    farptr start = BUFFER_START();
    switch (kind) {
    case 1:
        APPEND_TEXT(STR_OPERATOR_3_P, BUFFER);
        /* fall through: then the name */
    case 0:
        APPEND_TEXT(name_text(name), BUFFER);
        break;
    case 2:
        if (!type)
            return STR_TYPE_CONVERSION_P;
        APPEND_TEXT(STR_OPERATOR_3_P, BUFFER);
        APPEND_TYPE_SPELLING(T(type, 7), BUFFER);
        break;
    case 3:
    case 4:
        if (kind == 4)
            APPEND_CHAR('~', BUFFER);
        APPEND_SYMBOL_NAME(LINK(T(member_type, 5), 6), BUFFER);
        break;
    default:
        return 0;
    }
    if (type && T(type, 0) == 18)
        APPEND_PARAM_LIST(type, kind == 3 && (LINK(T(member_type, 5), 24) & 4), BUFFER);
    APPEND_CHAR(0, BUFFER);
    return start;
}
