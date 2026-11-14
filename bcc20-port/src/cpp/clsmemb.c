/* clsmemb.c: from bcc20/src/cpp/CLSMEMB.C: the body of a struct, union or class: the member
   declarations between the braces, their layout, and enum bodies.  TYPE_CLOSE is the loop
   over the whole body (called once the '{' has been read); each member declaration is
   first classified (TYPE_CHECK2 in C, TYPE_CLASSIFY_FAR in CLASSDEF.C for C++) and its
   declarators are handled by TYPE_LOOP_FAR; data members and bit fields are laid out here
   (ADD_DATA_MEMBER, ADD_BITFIELD_MEMBER), C++ members such as functions, friends and access
   specifiers by CLASSDEF.C.  STRUCT_BODY_TYPE is the type being defined, CLASS_KEY_TOKEN its
   keyword (43h union: every member at offset 0), TYPE_SIZE_LOW the size so far (a long) and
   BITFIELD_ALIGN_BITS the bits used in the current bit-field unit.  The values a callee
   fills in by address live in the scratch area in the original's frame layout. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "kind.h"
#include "msg.h"
#include "token.h"
#include "protos.h"
#include "calls.h"

#define TYPE_SIZE_LOW SD(TYPE_SIZE_LOW_P)
#define TYPE_PTR(i) W(fp_add(D(BCC_TYPE_PTR_P), (i) * 2))
#define BCC_PACK_FLAG B(BCC_PACK_FLAG_P)
#define BCC_ENUM_LIMIT_LO SD(BCC_ENUM_LIMIT_LO_P)
#define CURRENT_TOKEN_VALUE W(CURRENT_TOKEN_VALUE_P)
#define ATTRIBUTES(i) SB(fp_add(MEMBER_DECL_ATTRIBUTES_P, (i)))
#define UNION_KEY 0x43
#define NO_STORAGE_CLASS 0x82

/* the current declarator is "name : width" (current token ':').  The type must be
   integral (in strict C int or unsigned only; anything else is reported and replaced by
   unsigned, BCC_TYPE_PTR[6]); the width at most 16, positive, or 0 for an unnamed padding
   field.  A named field is declared as a member with flag 40h and its shift and width in
   MEMB_BITFIELD; an unnamed one only takes space */
void ADD_BITFIELD_MEMBER(void)
{
    /* the original frame from BP-0Eh: align, offset at 2, width at 6, shift at 0Ah, result
       at 0Ch */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x0E);
    farptr align = v, offset = fp_add(v, 2), width = fp_add(v, 6), shift = fp_add(v, 0x0A), result = fp_add(v, 0x0C);
    if (CLASS_KEY_TOKEN == UNION_KEY) {
        SD(offset) = 0;
        SW(align) = 0;
    } else {
        SD(offset) = TYPE_SIZE_LOW;
        SW(align) = BITFIELD_ALIGN_BITS;
    }
    if (TYPE_SIZE(TYPE_EXPR) == 0)
        REPORT_NAME_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO, CURRENT_DECLARATOR_NAME);
    ADVANCE_TOKEN();
    if (EXPR_FLAGS_AT(TYPE_W(TYPE_EXPR, TYPE_KIND)) & 1) {
        if (NOT_ANSI_FLAG == 0 && CPP_MODE == 0 && TYPES_COMPATIBLE(TYPE_EXPR, INT_TYPE, 1) == 0 && TYPES_COMPATIBLE(TYPE_EXPR, TYPE_PTR(6), 1) == 0)
            REPORT_CURRENT_TOKEN(MSG_BIT_FIELDS_MUST_SIGNED_334);
    } else {
        REPORT_CURRENT_TOKEN(MSG_BIT_FIELDS_MUST_SIGNED);
        TYPE_EXPR = TYPE_PTR(6);
    }
    CONST_EXPR_VALUE_BODY(7, width);
    if (SD(width) > 16) {
        REPORT_CURRENT_TOKEN(MSG_BIT_FIELD_TOO_LARGE);
        SD(width) = 16;
    } else if (SD(width) < 0 || (!SD(width) && CURRENT_DECLARATOR_NAME)) {
        REPORT_CURRENT_TOKEN(MSG_BIT_FIELDS_MUST);
        SD(width) = 1;
    }
    PLACE_BITFIELD_MEMBER((i16)SD(width), offset, align, result, shift);
    if (CLASS_KEY_TOKEN == UNION_KEY) {
        SD(offset) = (i32)((u32)SD(offset) + (u32)(i32)((SW(align) + 7) / 8));
        if (SD(offset) > TYPE_SIZE_LOW)
            TYPE_SIZE_LOW = SD(offset);
    } else {
        TYPE_SIZE_LOW = SD(offset);
        BITFIELD_ALIGN_BITS = SW(align);
    }
    if (CURRENT_DECLARATOR_NAME) {
        u16 member = DECLARE_MEMBER(CURRENT_DECLARATOR_NAME, 0);
        MEMBER_B(member, MEMB_FLAGS) = (MEMBER_B(member, MEMB_FLAGS) & 0xE3) | (((u8)SCOPE_STATE & 7) << 2);
        MEMBER_W(member, MEMB_TYPE) = TYPE_EXPR;
        MEMBER_W(member, MEMB_VALUE) = W(result);
        MEMBER_W(member, MEMB_CLASS) = STRUCT_BODY_TYPE;
        MEMBER_B(member, MEMB_FLAGS) |= 0x40;
        MEMBER_B(member, MEMB_BITFIELD) = (MEMBER_B(member, MEMB_BITFIELD) & 0xF8) | ((u8)W(shift) & 7);
        MEMBER_B(member, MEMB_BITFIELD) = (MEMBER_B(member, MEMB_BITFIELD) & 7) | (((u8)SD(width) & 0x1F) << 3);
    }
    scratch_release(mark);
}

/* lays out and declares a data member CURRENT_DECLARATOR_NAME of type TYPE_EXPR.  In C a
   member of size 0 is only allowed as an array, and only as the last member (the previous
   data member is checked).  A size above FFFFh is laid out as 2 bytes.  In C++ a union
   member may not need a constructor or be a reference, and a far or huge class (flags 8,
   100h) cannot contain a near class (flag 10h) */
void ADD_DATA_MEMBER(void)
{
    /* the original frame from BP-0Ch: align, offset at 2, result at 0Ah */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x0C);
    farptr align = v, offset = fp_add(v, 2), result = fp_add(v, 0x0A);
    if (CLASS_KEY_TOKEN == UNION_KEY) {
        SD(offset) = 0;
        SW(align) = 0;
    } else {
        SD(offset) = TYPE_SIZE_LOW;
        SW(align) = BITFIELD_ALIGN_BITS;
    }
    u16 member = TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS);
    MEMBER_B(0, MEMB_FLAGS) = 0;
    while ((u8)(MEMBER_B(member, MEMB_FLAGS) & 3))
        member = MEMBER_W(member, MEMB_NEXT);
    if (!CPP_MODE && member && TYPE_SIZE(MEMBER_W(member, MEMB_TYPE)) == 0) {
        REPORT_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO, (i32)NAME_TEXT_COPY(MEMBER_W(member, MEMB_NAME)), 0);
        scratch_release(mark);
        return;
    }
    i32 size = TYPE_SIZE(TYPE_EXPR);
    if (!size && (TYPE_W(TYPE_EXPR, TYPE_KIND) != TK_ARRAY || CPP_MODE != 0)) {
        REPORT_NAME_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO, CURRENT_DECLARATOR_NAME);
        scratch_release(mark);
        return;
    }
    if (size > 0xFFFF)
        size = 2;
    PLACE_STRUCT_MEMBER(size, offset, align, result);
    if (CLASS_KEY_TOKEN == UNION_KEY) {
        SD(offset) = (i32)((u32)SD(offset) + (u32)(i32)((SW(align) + 7) / 8));
        if (SD(offset) > TYPE_SIZE_LOW)
            TYPE_SIZE_LOW = SD(offset);
    } else {
        TYPE_SIZE_LOW = SD(offset);
        BITFIELD_ALIGN_BITS = SW(align);
    }
    member = DECLARE_MEMBER(CURRENT_DECLARATOR_NAME, 0);
    MEMBER_W(member, MEMB_TYPE) = TYPE_EXPR;
    MEMBER_W(member, MEMB_VALUE) = W(result);
    MEMBER_W(member, MEMB_CLASS) = STRUCT_BODY_TYPE;
    if (CPP_MODE && CLASS_KEY_TOKEN == UNION_KEY
        && ((TYPE_B(TYPE_EXPR, TYPE_ATTRS) & 4)
            || ((EXPR_FLAGS_AT(TYPE_W(TYPE_EXPR, TYPE_KIND)) & 0x14) && (TYPE_B(TYPE_EXPR, TYPE_ATTRS) & 0x20))))
        REPORT_CURRENT_TOKEN(MSG_UNION_MEMBERS_CANNOT);
    if (CPP_MODE
        && (TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x108)
        && (EXPR_FLAGS_AT(TYPE_W(TYPE_EXPR, TYPE_KIND)) & 0x40)
        && (TAG_W(TYPE_W(TYPE_EXPR, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x10))
        REPORT_CURRENT_TOKEN((TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_CLASS_FLAGS) & 0x100) ? MSG_CANNOT_HAVE_NEAR_312 : MSG_CANNOT_HAVE_NEAR);
    scratch_release(mark);
}

/* reverses a member list in place (members are declared newest first) and returns the new
   head */
u16 TYPE_REVERSE(u16 member)
{
    u16 previous = 0;
    while (member != 0) {
        u16 next = W(MK_FP(MEMBER_SEGMENT, member));
        W(MK_FP(MEMBER_SEGMENT, member)) = previous;
        previous = member;
        member = next;
    }
    return previous;
}

/* C mode: parses one member declarator.  A declaration without a type gets int (an error
   unless it declares a function); a storage class, conflicting modifiers or a special
   member name are errors.  2 for a bit field (':' follows), 3 for a data member; the C++
   version BCC_TYPE_FINISH_FAR (CLASSDEF.C) also returns 4 to 7 */
u16 BCC_TYPE_FINISH(void)
{
    /* the original frame from BP-8: detail */
    u16 mark = scratch_mark();
    farptr detail = scratch_alloc(8);
    u8 changed = 0;
    if (!TYPE_EXPR) {
        TYPE_EXPR = INT_TYPE;
        changed = 1;
    }
    PARSE_DECLARATOR(TYPE_EXPR, 2, TYPE_EXPR_P, CURRENT_DECLARATOR_NAME_P, SPECIAL_MEMBER_KIND_P, MEMBER_QUALIFIER_CLASS_P, MEMBER_DECL_ATTRIBUTES_P, detail);
    if (!CURRENT_DECLARATOR_NAME && CURRENT_TOKEN != TOK_COLON)
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    else if (changed && TYPE_W(TYPE_EXPR, TYPE_KIND) != TK_FUNCTION
             && !((EXPR_FLAGS_AT(TYPE_W(TYPE_EXPR, TYPE_KIND)) & 0x14) && TYPE_W(TYPE_W(TYPE_EXPR, 7), TYPE_KIND) == TK_FUNCTION)
             && STORAGE_CLASS_TOKEN == NO_STORAGE_CLASS)
        REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
    if (STORAGE_CLASS_TOKEN != NO_STORAGE_CLASS)
        REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT, TOKEN_NAMES_AT(STORAGE_CLASS_TOKEN));
    if (ATTRIBUTES(0) || ATTRIBUTES(2) || ATTRIBUTES(1))
        REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
    if (SPECIAL_MEMBER_KIND)
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    scratch_release(mark);
    return CURRENT_TOKEN == TOK_COLON ? 2 : 3;
}

/* the declarator list of one member declaration: for each declarator (restoring the
   declaration's type and attributes) dispatches on BCC_TYPE_FINISH(_FAR): 2 bit field, 3
   data member, 4-7 the C++ cases in CLASSDEF.C (count is the declarator's position).
   Handles the ',' between declarators and reports a missing ';'.  1 when the rest of the
   declaration was skipped (the caller then expects no ';') */
u8 TYPE_LOOP_FAR(void)
{
    u16 active = TYPE_EXPR;
    u8 saved[3];
    for (int i = 0; i < 3; ++i)
        saved[i] = ATTRIBUTES(i);
    for (u16 count = 1; CURRENT_TOKEN == TOK_TILDE || CURRENT_TOKEN == TOK_COLON || (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10); ++count) {
        TYPE_EXPR = active;
        for (int i = 0; i < 3; ++i)
            ATTRIBUTES(i) = saved[i];
        DISPATCH_NUMBER_GIVEN = 0;
        switch (CPP_MODE ? TYPE_DISPATCH() : BCC_TYPE_FINISH()) {
        case 4:
            TYPE_APPLY();
            break;
        case 5:
            if (TYPE_ARRAY(count))
                return 1;
            break;
        case 6:
            if (TYPE_RECORD(count))
                return 1;
            break;
        case 7:
            TYPE_VIRTUAL();
            break;
        case 2:
            ADD_BITFIELD_MEMBER();
            break;
        case 3:
            ADD_DATA_MEMBER();
            break;
        }
        if (CURRENT_TOKEN == TOK_COMMA) {
            ADVANCE_TOKEN();
            if (!(TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10)) {
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
                SKIP_BRACE_GROUP();
                return 1;
            }
        } else if (CURRENT_TOKEN != TOK_SEMICOLON && CURRENT_TOKEN != TOK_RBRACE) {
            if (TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
                count = 1;
            } else {
                REPORT_CURRENT_TOKEN(CURRENT_TOKEN == TOK_ASSIGN ? MSG_CANNOT_INITIALIZE_199 : MSG_USE_TERMINATE);
                SKIP_BRACE_GROUP();
                return 1;
            }
        }
    }
    return 0;
}

/* C mode: reads the declaration specifiers of a member declaration (storage classes are
   errors).  1 when declarators follow (TYPE_FLAGS 10h or ':'), 0 for a declaration of only
   a type, which must name a tag or be an enum */
i16 TYPE_CHECK2(void)
{
    STORAGE_CLASS_TOKEN = NO_STORAGE_CLASS;
    TYPE_EXPR = 0;
    MEMBER_DECL_TYPE_NAMED = 0;
    CURRENT_DECLARATOR_NAME = 0;
    for (int i = 0; i < 3; ++i)
        ATTRIBUTES(i) = SB(fp_add(EXPR_TEMP2_P, i));
    if (TOKEN_IS_TYPE_START_BODY(CURRENT_TOKEN_RECORD_P) != 0) {
        PARSE_DECL_SPECIFIERS(2, STORAGE_CLASS_TOKEN_P, MEMBER_DECL_FRIEND_P, PARSE_FLAG2_P, TYPE_EXPR_P, MEMBER_DECL_ATTRIBUTES_P, MEMBER_DECL_TYPE_NAMED_P);
        if (STORAGE_CLASS_TOKEN != NO_STORAGE_CLASS)
            REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT, TOKEN_NAMES_AT(STORAGE_CLASS_TOKEN));
    }
    if ((TYPE_FLAGS_AT(CURRENT_TOKEN) & 0x10) != 0 || CURRENT_TOKEN == TOK_COLON)
        return 1;
    if (TYPE_W(TYPE_EXPR, TYPE_KIND) != TK_ENUM
        && (!(EXPR_FLAGS_AT(TYPE_W(TYPE_EXPR, TYPE_KIND)) & 0x40)
            || SYM_W(TAG_W(TYPE_W(TYPE_EXPR, TYPE_TAG_BODY), TAG_SYMBOL), SYM_NAME) == 0))
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
    return 0;
}

/* reports and skips extra ';' between member declarations */
void TYPE_SKIP2(void)
{
    if (CURRENT_TOKEN == TOK_SEMICOLON) {
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_TERMINATED);
        while (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
    }
}

/* parses the member declarations up to '}' and finishes the type.  In C++
   TYPE_CLASSIFY_FAR decides each declaration's kind: 1 declarators (TYPE_LOOP_FAR), 2 an
   access specifier (no ';' needed), 3 to 6 other C++ forms handled in CLASSDEF.C; C uses
   TYPE_CHECK2.  Afterwards the member list is put in declaration order, a partly used
   bit-field byte is counted, the size is rounded up to even when BCC_PACK_FLAG is set,
   checked against 64K and stored as TAG_SIZE, and the '}' is required */
void TYPE_CLOSE(void)
{
    if (CURRENT_TOKEN == TOK_SEMICOLON) {
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
        while (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
    }
    while ((TYPE_FLAGS_AT(CURRENT_TOKEN) & TOKEN_MASK) != 0 || CURRENT_TOKEN == TOK_COLON) {
        switch (CPP_MODE != 0 ? TYPE_CLASSIFY() : (u16)TYPE_CHECK2()) {
        case 2:
            TYPE_SCOPE();
            goto skip_separator;
        case 3:
            TYPE_DECLARE();
            break;
        case 4:
            TYPE_RELINK();
            break;
        case 5:
            TYPE_FINALIZE();
            break;
        case 6:
            if (TYPE_ENUM() != 0)
                goto skip_separator;
            break;
        case 1:
            if (TYPE_LOOP_FAR() != 0)
                goto skip_separator;
            break;
        }
        if (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
        else
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_MISSING);
skip_separator:
        TYPE_SKIP2();
    }
    if (CPP_MODE != 0)
        TYPE_DEFER();
    u16 head = TYPE_REVERSE(TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS));
    TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS) = head;
    if (BITFIELD_ALIGN_BITS > 0)
        TYPE_SIZE_LOW = (i32)((u32)TYPE_SIZE_LOW + 1);
    if (BCC_PACK_FLAG != 0)
        TYPE_SIZE_LOW = (i32)(((u32)TYPE_SIZE_LOW + 1) & 0xFFFFFFFEu);
    if (TYPE_SIZE_LOW > 0xFFFF) {
        TYPE_SIZE_LOW = 0xFFBF;
        REPORT_CURRENT_TOKEN(MSG_STRUCTURE_SIZE_TOO);
    }
    TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_SIZE) = (u16)TYPE_SIZE_LOW;
    REQUIRE_TOKEN_BODY(6, 0xE6);
}

/* declares an enumerator name with value of enum type type in the current scope: storage
   class 15 (int enumerator), value in SYM_STORAGE, linked into the enum's list of
   enumerators (TAG_MEMBERS) through the symbol's word 0Ah */
void TYPE_WRAP(u16 type, u16 name, i32 value)
{
    u16 node = BCC_TYPE_CREATE(name, 2);
    SYM_W(node, SYM_TYPE) = type;
    SYM_B(node, SYM_STORAGE_CLASS) = (SYM_B(node, SYM_STORAGE_CLASS) & 7) | 0x78;
    SYM_W(node, SYM_STORAGE) = (u16)value;
    SYM_B(node, SYM_FLAGS) |= 2;
    SYM_W(node, SYM_FUNC_FLAGS) = TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS);
    TAG_W(TYPE_W(type, TYPE_TAG_BODY), TAG_MEMBERS) = node;
}

/* parses an enum body (current token '{') and returns the new enum type.  With nested the
   tag is declared under the name stored at byte 9 of outer (the caller's declaration
   record), else the enum is anonymous.  Enumerators take the next value or an explicit
   constant.  An enum declared in a parameter list gets attribute 20h; one declared inside
   a C++ class body gets 40h and its enumerators become class members, the last one marked
   with member flag 20h.  The underlying type is int with ENUMS_AS_INT_FLAG, else unsigned
   char when all values lie in 0..INT_LIMIT, char when within the char range, else int */
u16 ENUM_BUILD(farptr outer, u8 nested)
{
    /* the original frame from BP-16h: value at 0Eh */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x16);
    farptr value = fp_add(v, 0x0E);
    u8 scoped = 0;
    u16 result, selected;
    ADVANCE_TOKEN();
    if (nested != 0)
        result = DECLARE_TAG(W(fp_add(outer, 9)));
    else
        result = ALLOC_SYMBOL_ENTRY(0, 1);
    u16 expression = CREATE_TYPE(TK_ENUM);
    SYM_W(result, SYM_TYPE) = expression;
    SYM_B(result, SYM_STORAGE_CLASS) = (SYM_B(result, SYM_STORAGE_CLASS) & 0xF8) | 2;
    SYM_B(result, SYM_STORAGE_CLASS) = (SYM_B(result, SYM_STORAGE_CLASS) & 7) | (((nested != 0 ? 0x0B : 8) & 0x1F) << 3);
    TAG_W(TYPE_W(expression, TYPE_TAG_BODY), TAG_MEMBERS) = 0;
    TAG_W(TYPE_W(expression, TYPE_TAG_BODY), TAG_SYMBOL) = result;
    TAG_W(TYPE_W(expression, TYPE_TAG_BODY), TAG_ENUM_BASE) = INT_TYPE;
    if (PARAM_LIST_DEPTH != 0)
        TYPE_B(expression, TYPE_ATTRS) |= 0x20;
    else if (CPP_MODE != 0 && BCC_TREE_FLAG != 0) {
        scoped = 1;
        TYPE_B(expression, TYPE_ATTRS) |= 0x40;
    }
    i32 current = -1, minimum = 0x7FFF, maximum = -32768;
    if (CURRENT_TOKEN != TOK_IDENT)
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    while (CURRENT_TOKEN == TOK_IDENT) {
        u16 name = CURRENT_TOKEN_VALUE;
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN == TOK_ASSIGN) {
            ADVANCE_TOKEN();
            CONST_EXPR_VALUE_BODY(8, value);
        } else if (current < BCC_ENUM_LIMIT_LO)
            SD(value) = (i32)((u32)current + 1);
        else {
            SD(value) = current;
            REPORT_NAME_DIAGNOSTIC(MSG_VALUE_NOT_WITHIN_RANGE, name);
        }
        if (SD(value) < minimum)
            minimum = SD(value);
        if (SD(value) > maximum)
            maximum = SD(value);
        current = SD(value);
        if (scoped != 0)
            TYPE_ATTACH(expression, name, (u16)((u32)SD(value) >> 16), (u16)SD(value));
        else
            TYPE_WRAP(expression, name, SD(value));
        if (CURRENT_TOKEN == TOK_COMMA) {
            ADVANCE_TOKEN();
            if (CURRENT_TOKEN != TOK_IDENT) {
                if (CURRENT_TOKEN != TOK_RBRACE || NOT_ANSI_FLAG == 0)
                    REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
                SKIP_TO_SYNC_TOKEN(TOK_RBRACE);
            }
        } else if (CURRENT_TOKEN != TOK_RBRACE) {
            REPORT_CURRENT_TOKEN(MSG_ENUM_SYNTAX_ERROR);
            SKIP_TO_SYNC_TOKEN(TOK_RBRACE);
        }
    }
    if (scoped != 0)
        MEMBER_B(TAG_W(TYPE_W(STRUCT_BODY_TYPE, TYPE_TAG_BODY), TAG_MEMBERS), MEMB_FLAGS) |= 0x20;
    if (ENUMS_AS_INT_FLAG != 0)
        selected = INT_TYPE;
    else if (minimum >= 0 && maximum <= INT_LIMIT)
        selected = TYPE_PTR(2);
    else if (minimum >= BCC_ENUM_MIN_LO && maximum <= BCC_ENUM_MAX_LO)
        selected = CHAR_TYPE;
    else
        selected = INT_TYPE;
    TAG_W(TYPE_W(expression, TYPE_TAG_BODY), TAG_ENUM_BASE) = selected;
    REQUIRE_TOKEN_BODY(6, 0xE6);
    scratch_release(mark);
    return expression;
}
