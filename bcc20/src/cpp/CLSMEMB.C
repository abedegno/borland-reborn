/* target: ovr121_C131UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: C++ classes: struct/class body members: data members and bitfields, layout and size
   checks, closing a class type, enum bodies. Entry points: ADD_DATA_MEMBER, TYPE_LOOP_FAR,
   TYPE_CHECK2, TYPE_CLOSE, ENUM_BUILD. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: parsing the body of a struct, union or class: the member declarations
   between the braces, their layout, and enum bodies. TYPE_CLOSE is the loop over the
   whole body (called once the '{' has been read); each member declaration is first
   classified (TYPE_CHECK2 in C, TYPE_CLASSIFY_FAR in CLASSDEF.C for C++) and its
   declarators are handled by TYPE_LOOP_FAR; data members and bit fields are laid out
   here (ADD_DATA_MEMBER, ADD_BITFIELD_MEMBER), C++ members such as functions,
   friends and access specifiers by CLASSDEF.C.
   State shared with CLASSDEF.C and the declaration parser: STRUCT_BODY_TYPE is the
   type being defined, CLASS_KEY_TOKEN its keyword (0x43 union: every member at offset
   0), TYPE_SIZE_LOW the size so far (long) and BITFIELD_ALIGN_BITS the bits used in the
   current bit-field unit; TYPE_EXPR, CURRENT_DECLARATOR_NAME, STORAGE_CLASS_TOKEN (0x82
   none) and MEMBER_DECL_ATTRIBUTES describe the declaration being parsed; SCOPE_STATE
   is the current access. PLACE_STRUCT_MEMBER and PLACE_BITFIELD_MEMBER place a member and return
   its offset (and bit shift).
   The function names come from the original's TBITFLD, TLAYOUT, TREVERS, TFINISH,
   TLOOP, TCHECK2, TSKIP2, TCLOSE, TWRAP and TENUM2 and do not all describe the job. */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "TOKEN.H"
#include "POOL.H"

/* ---- TBITFLD (listing A5B0) ---- */
#include <dos.h>
extern unsigned int far *BCC_TYPE_PTR;
extern long  TYPE_SIZE_LOW;
extern long far pascal TYPE_SIZE(unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(int,unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(int);
extern void far pascal ADVANCE_TOKEN(void);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern void far pascal PARSE_CONSTANT_EXPR_VALUE(unsigned int,long far *);
extern void far pascal PLACE_BITFIELD_MEMBER(int,long far *,int far *,int far *,int far *);
extern unsigned int far pascal DECLARE_MEMBER(unsigned int,unsigned int);
/* ADD_BITFIELD_MEMBER: the current declarator is "name : width" (current token ':').
   Checks the type (integral; in strict C only int or unsigned, else
   MSG_BIT_FIELDS_MUST_SIGNED_334; a non-integral type is reported and replaced by
   unsigned, BCC_TYPE_PTR[6]) and the width (at most 16, positive, or 0 for an unnamed
   padding field), places it, and declares a member with MEMB_FLAGS 0x40 and the shift
   and width in MEMB_BITFIELD. An unnamed bit field only takes space. */
static void near pascal ADD_BITFIELD_MEMBER(void)
{
    int result,shift;
    long width,offset;
    int align;
    register unsigned int member;
    if(CLASS_KEY_TOKEN==0x43) {offset=0L;align=0;}
    else {offset=TYPE_SIZE_LOW;align=BITFIELD_ALIGN_BITS;}
    if(TYPE_SIZE(TYPE_EXPR)==0L) REPORT_NAME_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO,CURRENT_DECLARATOR_NAME);
    ADVANCE_TOKEN();
    if(EXPR_FLAGS[TYPE_W(TYPE_EXPR,TYPE_KIND)]&1) {
        if(NOT_ANSI_FLAG==0 && CPP_MODE==0 && TYPES_COMPATIBLE(TYPE_EXPR,INT_TYPE,1)==0 &&
            TYPES_COMPATIBLE(TYPE_EXPR,BCC_TYPE_PTR[6],1)==0) REPORT_CURRENT_TOKEN(MSG_BIT_FIELDS_MUST_SIGNED_334);
    } else {
        REPORT_CURRENT_TOKEN(MSG_BIT_FIELDS_MUST_SIGNED);
        TYPE_EXPR=BCC_TYPE_PTR[6];
    }
    PARSE_CONSTANT_EXPR_VALUE(7,&width);
    if(width>16L) { REPORT_CURRENT_TOKEN(MSG_BIT_FIELD_TOO_LARGE);width=16L; }
    else if(width<0L || (!width && CURRENT_DECLARATOR_NAME)) { REPORT_CURRENT_TOKEN(MSG_BIT_FIELDS_MUST);width=1L; }
    PLACE_BITFIELD_MEMBER((unsigned int)width,&offset,&align,&result,&shift);
    if(CLASS_KEY_TOKEN==0x43) {
        offset+=(align+7)/8;
        if(offset>TYPE_SIZE_LOW) TYPE_SIZE_LOW=offset;
    } else {TYPE_SIZE_LOW=offset;BITFIELD_ALIGN_BITS=align;}
    if(CURRENT_DECLARATOR_NAME) {
        member=DECLARE_MEMBER(CURRENT_DECLARATOR_NAME,0);
        MEMBER_B(member,MEMB_FLAGS)=(MEMBER_B(member,MEMB_FLAGS)&0xE3)|(((unsigned char)SCOPE_STATE&7)<<2);
        MEMBER_W(member,MEMB_TYPE)=TYPE_EXPR;
        MEMBER_W(member,MEMB_VALUE)=result;
        MEMBER_W(member,MEMB_CLASS)=STRUCT_BODY_TYPE;
        MEMBER_B(member,MEMB_FLAGS)|=0x40;
        MEMBER_B(member,MEMB_BITFIELD)=(MEMBER_B(member,MEMB_BITFIELD)&0xF8)|((unsigned char)shift&7);
        MEMBER_B(member,MEMB_BITFIELD)=(MEMBER_B(member,MEMB_BITFIELD)&7)|(((unsigned char)width&0x1F)<<3);
    }
}

/* ---- TLAYOUT (listing A7B6) ---- */
#include <dos.h>
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(int,long,long);
extern void far pascal PLACE_STRUCT_MEMBER(long,long far *,int far *,int far *);
/* ADD_DATA_MEMBER: lays out and declares a data member CURRENT_DECLARATOR_NAME of type
   TYPE_EXPR. In C a member of size 0 is only allowed as an array, and only as the last
   member (the previous data member found in the list is checked). A size above
   0xFFFF is laid out as 2 bytes (why is not shown here). In C++ a union
   member may not need a constructor or be a reference (MSG_UNION_MEMBERS_CANNOT), and a
   far or huge class (flags 8, 0x100) cannot contain a near class (flag 0x10):
   MSG_CANNOT_HAVE_NEAR / _312. */
void far pascal ADD_DATA_MEMBER(void)
{
    int result;
    long size,offset;
    int align;
    register unsigned int member;
    if(CLASS_KEY_TOKEN==0x43) {
        offset=0L;
        align=0;
    } else {
        offset=TYPE_SIZE_LOW;
        align=BITFIELD_ALIGN_BITS;
    }
    member=TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_MEMBERS);
    MEMBER_B(0,MEMB_FLAGS)=0;
    while((unsigned char)(MEMBER_B(member,MEMB_FLAGS)&3)) member=MEMBER_W(member,MEMB_NEXT);
    if(!CPP_MODE && member && TYPE_SIZE(MEMBER_W(member,MEMB_TYPE))==0L) {
        REPORT_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO,(long)NAME_TEXT_COPY(MEMBER_W(member,MEMB_NAME)),0L);
        return;
    }
    size=TYPE_SIZE(TYPE_EXPR);
    if(!size && (TYPE_W(TYPE_EXPR,TYPE_KIND)!=0x11 || CPP_MODE!=0)) {
        REPORT_NAME_DIAGNOSTIC(MSG_SIZE_UNKNOWN_ZERO,CURRENT_DECLARATOR_NAME);
        return;
    }
    if(size>0xFFFFL) size=2L;
    PLACE_STRUCT_MEMBER(size,&offset,&align,&result);
    if(CLASS_KEY_TOKEN==0x43) {
        offset+=(align+7)/8;
        if(offset>TYPE_SIZE_LOW) TYPE_SIZE_LOW=offset;
    } else {
        TYPE_SIZE_LOW=offset;
        BITFIELD_ALIGN_BITS=align;
    }
    member=DECLARE_MEMBER(CURRENT_DECLARATOR_NAME,0);
    MEMBER_W(member,MEMB_TYPE)=TYPE_EXPR;
    MEMBER_W(member,MEMB_VALUE)=result;
    MEMBER_W(member,MEMB_CLASS)=STRUCT_BODY_TYPE;
    if(CPP_MODE && CLASS_KEY_TOKEN==0x43 &&
        ((TYPE_B(TYPE_EXPR,TYPE_ATTRS)&4) ||
        ((EXPR_FLAGS[TYPE_W(TYPE_EXPR,TYPE_KIND)]&0x14) && (TYPE_B(TYPE_EXPR,TYPE_ATTRS)&0x20))))
        REPORT_CURRENT_TOKEN(MSG_UNION_MEMBERS_CANNOT);
    if(CPP_MODE &&
       (TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x108) &&
       (EXPR_FLAGS[TYPE_W(TYPE_EXPR,TYPE_KIND)]&0x40) &&
       (TAG_W(TYPE_W(TYPE_EXPR,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x10))
        REPORT_CURRENT_TOKEN((TAG_W(TYPE_W(STRUCT_BODY_TYPE,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x100)?MSG_CANNOT_HAVE_NEAR_312:MSG_CANNOT_HAVE_NEAR);
}

/* ---- TREVERS (listing A9E2) ---- */
#include <dos.h>


/* TYPE_REVERSE: reverses a member list in place (members are declared newest first)
   and returns the new head. */
static unsigned int near pascal TYPE_REVERSE(unsigned int member)
{
    register unsigned int previous;
    register unsigned int next;

    previous = 0;
    while (member != 0) {
        next = *(unsigned int far *)MK_FP(MEMBER_SEGMENT, member);
        *(unsigned int far *)MK_FP(MEMBER_SEGMENT, member) = previous;
        previous = member;
        member = next;
    }
    return previous;
}

/* ---- TFINISH (listing AA0C) ---- */
#include <dos.h>
struct C16Spec { signed char first,second,third; };
extern struct C16Spec  MEMBER_DECL_ATTRIBUTES;
extern void far pascal PARSE_DECLARATOR(unsigned int,unsigned int,unsigned int far *,unsigned int far *,unsigned int far *,unsigned int far *,struct C16Spec far *,struct C16Spec far *);
#define POOL(r) (*(unsigned int far *)MK_FP(TYPE_POOL,(r)))
/* BCC_TYPE_FINISH: C mode: parses one member declarator. A declaration without a type
   gets int (MSG_TYPE_NAME_EXPECTED unless it declares a function); a storage class,
   conflicting modifiers or a special member name are errors. Returns 2 for a bit field
   (':' follows), 3 for a data member; the C++ version BCC_TYPE_FINISH_FAR (CLASSDEF.C)
   also returns 4 to 7. */
static unsigned int near pascal BCC_TYPE_FINISH(void)
{
    unsigned char changed=0;
    unsigned int previous;
    unsigned char detail[4];
    previous=TYPE_EXPR;
    if (!previous) { TYPE_EXPR=INT_TYPE;changed=1; }
    PARSE_DECLARATOR(TYPE_EXPR,2,&TYPE_EXPR,&CURRENT_DECLARATOR_NAME,&SPECIAL_MEMBER_KIND,&MEMBER_QUALIFIER_CLASS,&MEMBER_DECL_ATTRIBUTES,(struct C16Spec far *)detail);
    if (!CURRENT_DECLARATOR_NAME && CURRENT_TOKEN!=TOK_COLON) {
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    } else if (changed) {
        if (POOL(TYPE_EXPR)!=0x12) {
            if (EXPR_FLAGS[POOL(TYPE_EXPR)]&0x14) {
                if (POOL(POOL(TYPE_EXPR+7))==0x12) goto classify;
            }
            if (STORAGE_CLASS_TOKEN==0x82) REPORT_CURRENT_TOKEN(MSG_TYPE_NAME_EXPECTED);
        }
    }
classify:
    if (STORAGE_CLASS_TOKEN!=0x82) REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT,TOKEN_NAMES[STORAGE_CLASS_TOKEN]);
    if (MEMBER_DECL_ATTRIBUTES.first || MEMBER_DECL_ATTRIBUTES.third || MEMBER_DECL_ATTRIBUTES.second) REPORT_CURRENT_TOKEN(MSG_CONFLICTING_TYPE);
    if (SPECIAL_MEMBER_KIND) REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    return CURRENT_TOKEN==TOK_COLON ? 2 : 3;
}
#undef POOL

/* ---- TLOOP (listing AB05) ---- */
#include <dos.h>

extern unsigned int far pascal BCC_TYPE_FINISH_FAR(void);
static unsigned int near pascal BCC_TYPE_FINISH(void);
extern void far pascal BCC_DECL_CASE0(void);
extern unsigned char far pascal BCC_DECL_CASE2(unsigned int);
extern unsigned char far pascal BCC_DECL_CASE3(unsigned int);
extern void far pascal BCC_DECL_CASE4(void);
static void near pascal ADD_BITFIELD_MEMBER(void);
extern void far pascal ADD_DATA_MEMBER(void);
extern void far pascal SKIP_BRACE_GROUP(void);
/* TYPE_LOOP_FAR: the declarator list of one member declaration: for each declarator
   (restoring the declaration's type and attributes) dispatches on BCC_TYPE_FINISH(_FAR):
   2 bit field, 3 data member, 4-7 the C++ cases in CLASSDEF.C (BCC_DECL_CASE0/2/3/4;
   count is the declarator's position). Handles the ',' between declarators and
   reports a missing ';'. Returns 1 when the rest of the declaration was skipped (the
   caller then expects no ';'). */
unsigned char far pascal TYPE_LOOP_FAR(void)
{
    unsigned int active;
    struct C16Spec saved;
    register unsigned int count=1;
    active=TYPE_EXPR;
    saved=MEMBER_DECL_ATTRIBUTES;
    for(count=1;CURRENT_TOKEN==TOK_TILDE || CURRENT_TOKEN==TOK_COLON || TYPE_FLAGS[CURRENT_TOKEN]&0x10;++count) {
        TYPE_EXPR=active;
        MEMBER_DECL_ATTRIBUTES=saved;
        DISPATCH_NUMBER_GIVEN=0;
        switch(CPP_MODE?BCC_TYPE_FINISH_FAR():BCC_TYPE_FINISH()) {
        case 4:BCC_DECL_CASE0();break;
        case 5:if(BCC_DECL_CASE2(count)) return 1;break;
        case 6:if(BCC_DECL_CASE3(count)) return 1;break;
        case 7:BCC_DECL_CASE4();break;
        case 2:ADD_BITFIELD_MEMBER();break;
        case 3:ADD_DATA_MEMBER();break;
        }
        if(CURRENT_TOKEN==TOK_COMMA) {
            ADVANCE_TOKEN();
            if(!(TYPE_FLAGS[CURRENT_TOKEN]&0x10)) {
                REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
                SKIP_BRACE_GROUP();
                return 1;
            }
        } else if(CURRENT_TOKEN!=TOK_SEMICOLON && CURRENT_TOKEN!=TOK_RBRACE) {
            if(TYPE_FLAGS[CURRENT_TOKEN]&0x10) {
                REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
                count=1;
            } else {
                REPORT_CURRENT_TOKEN(CURRENT_TOKEN==TOK_ASSIGN?MSG_CANNOT_INITIALIZE_199:MSG_USE_TERMINATE);
                SKIP_BRACE_GROUP();
                return 1;
            }
        }
    }
    return 0;
}

/* ---- TYPE_CHECK2 (listing AC3B) ---- */
#include <dos.h>

extern struct C16Spec EXPR_TEMP2;
extern unsigned int CURRENT_TOKEN_RECORD;
extern unsigned char far pascal TOKEN_IS_TYPE_START(void far *);
extern void far pascal PARSE_DECL_SPECIFIERS(unsigned int,unsigned int far *,unsigned char far *,unsigned char far *,unsigned int far *,struct C16Spec far *,unsigned char far *);
/* TYPE_CHECK2: C mode: reads the declaration specifiers of a member declaration
   (storage classes are errors) and returns 1 when declarators follow (TYPE_FLAGS 0x10
   or ':'), 0 for a declaration of only a type, which must name a tag or be an enum
   (MSG_DECLARATION_DOES_NOT). */
int far pascal TYPE_CHECK2(void)
{
    STORAGE_CLASS_TOKEN=0x82;
    TYPE_EXPR=0;
    MEMBER_DECL_TYPE_NAMED=0;
    CURRENT_DECLARATOR_NAME=0;
    MEMBER_DECL_ATTRIBUTES=EXPR_TEMP2;
    if(TOKEN_IS_TYPE_START((void far *)&CURRENT_TOKEN_RECORD)!=0) {
        PARSE_DECL_SPECIFIERS(2,&STORAGE_CLASS_TOKEN,&MEMBER_DECL_FRIEND,
            &PARSE_FLAG2,&TYPE_EXPR,
            &MEMBER_DECL_ATTRIBUTES,&MEMBER_DECL_TYPE_NAMED);
        if(STORAGE_CLASS_TOKEN!=0x82) REPORT_NAME_DIAGNOSTIC(MSG_STORAGE_CLASS_NOT,TOKEN_NAMES[STORAGE_CLASS_TOKEN]);
    }
    if((TYPE_FLAGS[CURRENT_TOKEN]&0x10)!=0 || CURRENT_TOKEN==TOK_COLON) return 1;
    if(AT_W(TYPE_POOL,TYPE_EXPR)!=0x15) {
        if(!(EXPR_FLAGS[AT_W(TYPE_POOL,TYPE_EXPR)]&0x40) ||
           AT_W(SYMBOL_POOL_SEG,AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,TYPE_EXPR+5)+6)+2)==0)
            REPORT_CURRENT_TOKEN(MSG_DECLARATION_DOES_NOT);
    }
    return 0;
}

/* ---- TSKIP2 (listing AD15) ---- */
/* TYPE_SKIP2: reports and skips extra ';' between member declarations
   (MSG_DECLARATION_TERMINATED). */
static void near pascal TYPE_SKIP2(void)
{
    if(CURRENT_TOKEN==TOK_SEMICOLON) {
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_TERMINATED);
        while(CURRENT_TOKEN==TOK_SEMICOLON) ADVANCE_TOKEN();
    }
}

/* ---- TCLOSE (listing AD3A) ---- */
#include <dos.h>

extern unsigned char  BCC_PACK_FLAG;
extern unsigned int far TYPE_CLASSIFY_FAR(void);
extern void far TYPE_SCOPE_FAR(void);
extern unsigned char far pascal TYPE_LOOP_FAR(void);
extern void far TYPE_DECLARE_FAR(void);
extern void far TYPE_RELINK_FAR(void);
extern void far TYPE_FINALIZE_FAR(void);
extern unsigned char far TYPE_ENUM_FAR(void);
static void near pascal TYPE_SKIP2(void);
extern void far TYPE_DEFER_FAR(void);
extern void far REQUIRE_TOKEN_ELSE_ERROR(int first, int second);

/* TYPE_CLOSE: parses the member declarations up to '}' and finishes the type. In C++
   TYPE_CLASSIFY_FAR decides each declaration's kind: 1 declarators (TYPE_LOOP_FAR), 2
   an access specifier (TYPE_SCOPE_FAR, no ';' needed), 3 to 6 other C++ forms handled
   in CLASSDEF.C; C uses TYPE_CHECK2. Afterwards (C++: TYPE_DEFER_FAR first) the member
   list is put in declaration order, a partly used bit-field byte is counted, the size
   is rounded up to even when BCC_PACK_FLAG is set (probably word alignment, -a),
   checked against 64K (MSG_STRUCTURE_SIZE_TOO) and stored as TAG_SIZE (tag body word
   4), and the '}' is required. */
void far pascal TYPE_CLOSE(void)
{
    if (CURRENT_TOKEN == TOK_SEMICOLON) {
        REPORT_CURRENT_TOKEN(MSG_DECLARATION_WAS);
        while (CURRENT_TOKEN == TOK_SEMICOLON)
            ADVANCE_TOKEN();
    }
    while ((TYPE_FLAGS[CURRENT_TOKEN] & TOKEN_MASK) != 0 || CURRENT_TOKEN == TOK_COLON) {
        switch (CPP_MODE != 0 ? TYPE_CLASSIFY_FAR() : TYPE_CHECK2()) {
        case 2:
            TYPE_SCOPE_FAR();
            goto skip_separator;
        case 3:
            TYPE_DECLARE_FAR();
            break;
        case 4:
            TYPE_RELINK_FAR();
            break;
        case 5:
            TYPE_FINALIZE_FAR();
            break;
        case 6:
            if (TYPE_ENUM_FAR() != 0)
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
        TYPE_DEFER_FAR();
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        *(unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY) + 2) =
        TYPE_REVERSE(*(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
            *(unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY) + 2));
    if (BITFIELD_ALIGN_BITS > 0)
        TYPE_SIZE_LOW++;
    if (BCC_PACK_FLAG != 0)
        TYPE_SIZE_LOW = (TYPE_SIZE_LOW + 1L) & 0xFFFFFFFEL;
    if (TYPE_SIZE_LOW > 0xFFFFL) {
        TYPE_SIZE_LOW = 0xFFBFL;
        REPORT_CURRENT_TOKEN(MSG_STRUCTURE_SIZE_TOO);
    }
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        *(unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY) + 4) =
        (unsigned int)TYPE_SIZE_LOW;
    REQUIRE_TOKEN_ELSE_ERROR(6, 0xE6);
}

/* ---- TWRAP (listing AEA1) ---- */
#include <dos.h>
extern unsigned int far pascal BCC_TYPE_CREATE(unsigned int,unsigned int);
/* TYPE_WRAP: declares an enumerator name with value of enum type type in the current
   scope: storage class 15 (int enumerator), value in SYM_STORAGE (word 8), linked into
   the enum's list of enumerators (TAG_MEMBERS) through the symbol's word 0x0A
   (SYM_FUNC_FLAGS reused as a link). */
static void near pascal TYPE_WRAP(register unsigned int type,unsigned int name,long value)
{
    register unsigned int node;
    node=BCC_TYPE_CREATE(name,2);
    SYM_W(node,SYM_TYPE)=type;
    SYM_B(node,SYM_STORAGE_CLASS)=(SYM_B(node,SYM_STORAGE_CLASS)&7)|0x78;
    SYM_W(node,SYM_STORAGE)=(unsigned int)value;
    SYM_B(node,SYM_FLAGS)|=2;
    SYM_W(node,SYM_FUNC_FLAGS)=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);
    TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS)=node;
}

/* ---- TENUM2 (listing AF07) ---- */
#include <dos.h>

extern unsigned int  CURRENT_TOKEN_VALUE;
extern long  BCC_ENUM_LIMIT_LO;
extern unsigned int far DECLARE_TAG(unsigned int node);
extern unsigned int far ALLOC_SYMBOL_ENTRY(int first, int second);
extern unsigned int far CREATE_TYPE(unsigned int type);
extern void far TYPE_ATTACH_FAR(unsigned int type, unsigned int name, long value);
static void near pascal TYPE_WRAP(unsigned int type, unsigned int name, long value);
extern unsigned int far pascal SKIP_TO_SYNC_TOKEN(unsigned int token);

/* ENUM_BUILD: parses an enum body (current token '{') and returns the new enum type.
   With nested the tag is declared under the name stored at byte 9 of outer (the
   caller's declaration record), else the enum is anonymous. Enumerators take the
   next value or an explicit constant (MSG_VALUE_NOT_WITHIN_RANGE past the limit). An
   enum declared in a parameter list gets attribute 0x20; one declared inside a C++
   class body (BCC_TREE_FLAG) gets 0x40 and its enumerators become class members
   (TYPE_ATTACH_FAR), the last one marked with member flag 0x20. The underlying type
   (TAG_ENUM_BASE) is int with ENUMS_AS_INT_FLAG, else unsigned char
   (BCC_TYPE_PTR[2]) when all values lie in 0..INT_LIMIT, char when within
   BCC_ENUM_MIN_LO..BCC_ENUM_MAX_LO, else int. A trailing comma is allowed when
   NOT_ANSI_FLAG is set. */
unsigned int far pascal ENUM_BUILD(void far *outer, unsigned char nested)
{
    long current;
    long value;
    unsigned int name;
    long minimum;
    long maximum;
    unsigned int selected;
    unsigned char scoped;
    register unsigned int expression;
    register unsigned int result;

    scoped = 0;
    ADVANCE_TOKEN();
    if (nested != 0)
        result = DECLARE_TAG(*(unsigned int far *)((unsigned char far *)outer + 9));
    else
        result = ALLOC_SYMBOL_ENTRY(0, 1);
    expression = CREATE_TYPE(0x15);
    *(unsigned int far *)MK_FP(SYMBOL_POOL_SEG, result + SYM_TYPE) = expression;
    *(unsigned char far *)MK_FP(SYMBOL_POOL_SEG, result + SYM_STORAGE_CLASS) =
        (*(unsigned char far *)MK_FP(SYMBOL_POOL_SEG, result + SYM_STORAGE_CLASS) & 0xF8) | 2;
    *(unsigned char far *)MK_FP(SYMBOL_POOL_SEG, result + SYM_STORAGE_CLASS) =
        (*(unsigned char far *)MK_FP(SYMBOL_POOL_SEG, result + SYM_STORAGE_CLASS) & 7) |
        (((nested != 0 ? 0x0B : 8) & 0x1F) << 3);
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        *(unsigned int far *)MK_FP(TYPE_POOL, expression + TYPE_TAG_BODY) + 2) = 0;
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        *(unsigned int far *)MK_FP(TYPE_POOL, expression + TYPE_TAG_BODY) + 6) = result;
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        *(unsigned int far *)MK_FP(TYPE_POOL, expression + TYPE_TAG_BODY) + 4) = INT_TYPE;
    if (PARAM_LIST_DEPTH != 0)
        *(unsigned char far *)MK_FP(TYPE_POOL, expression + TYPE_ATTRS) |= 0x20;
    else if (CPP_MODE != 0 && BCC_TREE_FLAG != 0) {
        scoped = 1;
        *(unsigned char far *)MK_FP(TYPE_POOL, expression + TYPE_ATTRS) |= 0x40;
    }
    current = -1L;
    minimum = 0x7FFFL;
    maximum = -32768L;
    if (CURRENT_TOKEN != TOK_IDENT) {
        REPORT_CURRENT_TOKEN(MSG_IDENTIFIER_EXPECTED);
    }
    while (CURRENT_TOKEN == TOK_IDENT) {
        name = CURRENT_TOKEN_VALUE;
        ADVANCE_TOKEN();
        if (CURRENT_TOKEN == TOK_ASSIGN) {
            ADVANCE_TOKEN();
            PARSE_CONSTANT_EXPR_VALUE(8, &value);
        } else if (current < BCC_ENUM_LIMIT_LO)
            value = current + 1L;
        else {
            value = current;
            REPORT_NAME_DIAGNOSTIC(MSG_VALUE_NOT_WITHIN_RANGE, name);
        }
        if (value < minimum)
            minimum = value;
        if (value > maximum)
            maximum = value;
        current = value;
        if (scoped != 0)
            TYPE_ATTACH_FAR(expression, name, value);
        else
            TYPE_WRAP(expression, name, value);
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
        *(unsigned char far *)MK_FP(MEMBER_SEGMENT,
            *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
                *(unsigned int far *)MK_FP(TYPE_POOL, STRUCT_BODY_TYPE + TYPE_TAG_BODY) + 2) + 4) |= 0x20;
    if (ENUMS_AS_INT_FLAG != 0)
        selected = INT_TYPE;
    else if (minimum >= 0L && maximum <= INT_LIMIT)
        selected = BCC_TYPE_PTR[2];
    else if (minimum >= BCC_ENUM_MIN_LO && maximum <= BCC_ENUM_MAX_LO)
        selected = CHAR_TYPE;
    else
        selected = INT_TYPE;
    *(unsigned int far *)MK_FP(TAG_BODY_POOL_SEG,
        *(unsigned int far *)MK_FP(TYPE_POOL, expression + TYPE_TAG_BODY) + 4) = selected;
    REQUIRE_TOKEN_ELSE_ERROR(6, 0xE6);
    return expression;
}
