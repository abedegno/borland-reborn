/* target: ovr089_C33UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: diagnostics: spells types, symbols, members, operators and call signatures as text
   for messages. Entry points: FORMAT_CALL_SIGNATURE, FORMAT_SYMBOL, FORMAT_MEMBER,
   SPELL_SYMBOL_WITH_TYPE, CLASS_NAME_OF_TYPE, FORMAT_SPECIAL_MEMBER, FORMAT_TYPE,
   REQUIRED_TYPE_TEXT (+2 more). Map of all sources: docs/SOURCE-MAP.md. */
#include <dos.h>
#include "TYPESPEL.H"
#include "FIELDS.H"
/* Overview: turns types and symbols into readable text for message arguments, such as
   "int far *", "X::f(int,char *) const" or "operator =". Used by the parser and the C++
   code when a message names a type or a function.
   Every public FORMAT_* function appends its text to DIAG_NAME_BUFFER (shared with
   DIAG.C; its text is the memory of BCC_DEBUG_NAME), adds a 0 and returns a far pointer
   to where its text starts. Several texts can thus be built for one message; the buffer
   is emptied after the message is printed (REPORT_DIAGNOSTIC_AT). Some return the
   pointer as a long, the form REPORT_DIAGNOSTIC takes its arguments in. Text beyond
   511 bytes is dropped.
   The work is done by APPEND_TYPE_SPELLING, which spells a type recursively, and
   APPEND_PARAM_LIST and APPEND_FUNCTION_NAME. Records are read with raw offsets through
   the macros below. The ones used here, with their FIELDS.H names:
   type: 0 TYPE_KIND, 2 TYPE_ATTRS (1 const, 2 volatile, 0x20 reference), 3
   TYPE_MEMBER_CLASS, 5 TYPE_TAG_BODY, 7 TYPE_TARGET, 9 TYPE_PARAMS or TYPE_ARRAY_COUNT,
   11 TYPE_CALL_CONV (2 pascal), 12 TYPE_FUNC_FLAGS (1 far, 4 ellipsis, 8 no prototype),
   13 TYPE_PTR_MODE (11 member pointer);
   symbol: 0 SYM_OWNER_CLASS, 2 SYM_NAME, 4 SYM_TYPE, 6 SYM_FLAGS (0x10 member),
   7 SYM_STORAGE_CLASS (class 11 in bits 3-7 = a tag name, 9 probably typedef),
   15 SYM_FUNC_KIND; tag body (LINK): 6 TAG_SYMBOL, 24 TAG_CLASS_FLAGS (4 virtual bases);
   member: 2 MEMB_NAME, 4 MEMB_FLAGS, 6 MEMB_VALUE, 10 MEMB_CLASS; formal (PARAM): 0
   FORMAL_NEXT, 2 FORMAL_TYPE; expression: 8 EXPR_TYPE, 10 EXPR_LEFT, 12 EXPR_RIGHT,
   14 EXPR_SCOPE_CLASS.
   Type kinds are those of KIND.H (13..16 pointers, 17 array, 18 function, 19 struct,
   20 union, 21 enum); C33_TYPE_NAMES holds the word for each kind. CPP_MODE is
   the C++ mode flag: in C, "struct", "union", "enum" and "void" are spelled as C needs. */
#define W(s,o) (*(unsigned int far *)MK_FP((s),(unsigned int)(o)))
#define B(s,o) (*(unsigned char far *)MK_FP((s),(unsigned int)(o)))
#define SB(s,o) (*(signed char far *)MK_FP((s),(unsigned int)(o)))
#define L(s,o) (*(long far *)MK_FP((s),(unsigned int)(o)))
#define T(n,o) W(TYPE_POOL,(unsigned int)(n)+(o))
#define TB(n,o) B(TYPE_POOL,(unsigned int)(n)+(o))
#define TS(n,o) SB(TYPE_POOL,(unsigned int)(n)+(o))
#define TL(n,o) L(TYPE_POOL,(unsigned int)(n)+(o))
#define S(n,o) W(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define SYB(n,o) B(SYMBOL_POOL_SEG,(unsigned int)(n)+(o))
#define E(n,o) W(EXPR_POOL_SEG,(unsigned int)(n)+(o))
#define M(n,o) W(MEMBER_SEGMENT,(unsigned int)(n)+(o))
#define MB(n,o) B(MEMBER_SEGMENT,(unsigned int)(n)+(o))
#define LINK(n,o) W(TAG_BODY_POOL_SEG,(unsigned int)(n)+(o))
#define PARAM(n,o) W(FORMAL_POOL_SEG,(unsigned int)(n)+(o))
#define NAME(n) (*(struct C33Name far *)MK_FP(NAME_POOL_SEG,(n)))

/* 0000: bounded append consumes a BYTE and advances the actual WORD count. */
/* Appends one byte to out; bytes past 511 are dropped. */
static void near pascal APPEND_CHAR(unsigned char value,struct C33Buffer far *out)
{
    if(out->count<511)
        out->text[out->count++]=value;
}
/* 0022: the source FAR pointer advances even when the destination is full. */
/* Appends a 0-terminated text (without the 0). */
static void near pascal APPEND_TEXT(char far *text,struct C33Buffer far *out)
{
    unsigned char value;
    while((value=*text++)!=0)
        APPEND_CHAR(value,out);
}
/* 004E: name offset plus a NEAR pointer to a segment WORD, not a FAR text field. */
/* Appends the name of symbol, if it has one. */
static void near pascal APPEND_SYMBOL_NAME(register unsigned int symbol,struct C33Buffer far *out)
{
    union C33NameRef reference;
    char far *text;
    unsigned char value;
    if(symbol && S(symbol,2)) {
        reference.raw=*(char far * far *)MK_FP(NAME_POOL_SEG,S(symbol,2)+NAME_TEXT_OFFSET);
        text=MK_FP(*reference.parts.segment,reference.parts.offset);
        while((value=*text++)!=0)
            APPEND_CHAR(value,out);
    }
}
/* 00B0: preserve the optional two parameter-list skips and the native varargs flag. */
/* Appends "(t1,t2,...)" for function type type. For a C++ member function (it has a
   class, TYPE_MEMBER_CLASS) the first parameter is the hidden this and is left out;
   skip set leaves out one more (the extra hidden parameter of a constructor of a class
   with virtual bases). A function without prototype (flag 8) shows "()"; an empty
   prototyped list shows "(void)" in C and "()" in C++; flag 4 adds "...". */
static void near pascal APPEND_PARAM_LIST(unsigned int type,unsigned char skip,
    struct C33Buffer far *out)
{
    register unsigned int parameter;
    APPEND_CHAR('(',out);
    parameter=T(type,9);
    if(CPP_MODE && T(type,3)) {
        parameter=PARAM(parameter,0);
        if(skip)
            parameter=PARAM(parameter,0);
    }
    if(!(TB(type,12)&8)) {
        if(!parameter && !(TB(type,12)&4)) {
            if(!CPP_MODE)
                APPEND_TEXT(STR_VOID,out);
        } else
            while(parameter) {
                APPEND_TYPE_SPELLING(PARAM(parameter,2),out);
                parameter=PARAM(parameter,0);
                if(parameter || (TB(type,12)&4))
                    APPEND_CHAR(',',out);
            }
    }
    if(TB(type,12)&4)
        APPEND_TEXT(STR_DOT_DOT_DOT,out);
    APPEND_CHAR(')',out);
}
/* 0185: complete recursive type formatter, including pointer/function qualifiers. */
/* Appends the spelling of type: qualifiers, then by kind: enum/struct/union tag names,
   pointers ("int near *", function pointers as "int (far *)(int)", member pointers as
   "int (near X::*)()" with "pascal" when needed), references with '&', arrays with their
   count, functions with their parameters, and plain kinds by name. 0 is spelled "?". */
static void near pascal APPEND_TYPE_SPELLING(register unsigned int type,struct C33Buffer far *out)
{
    register unsigned int function;
    unsigned char member_pointer;
    if(!type) {
        APPEND_CHAR('?',out);
        return;
    }
    /* Leading const/volatile, except for kinds with EXPR_FLAGS bit 0x14 (probably the
       pointer kinds, whose qualifiers are written after the '*' below). */
    if(!(EXPR_FLAGS[T(type,0)]&0x14)) {
        if(TB(type,2)&1)
            APPEND_TEXT(STR_CONST,out);
        if(TB(type,2)&2)
            APPEND_TEXT(STR_VOLATILE,out);
    }
    switch(T(type,0)) {
    case 21:
        if(!CPP_MODE)
            APPEND_TEXT(STR_ENUM,out);
        if((SYB(LINK(T(type,5),6),7)>>3)==11)
            APPEND_SYMBOL_NAME(LINK(T(type,5),6),out);
        else if(CPP_MODE)
            APPEND_TEXT(STR_ENUM_2,out);
        break;
    case 13:
    case 14:
    case 15:
    case 16:
            /* Pointer to function: result type, "(", then "far X::" for a member
               pointer or the pointer word, then "*)" and the parameter list. */
        if(T(T(type,7),0)==18) {
            function=T(type,7);
            member_pointer=CPP_MODE && TS(type,13)==11;
            APPEND_TYPE_SPELLING(T(function,7),out);
            APPEND_CHAR('(',out);
            if(member_pointer) {
                APPEND_TEXT((TB(function,12)&1)?STR_FAR:STR_NEAR,out);
                APPEND_TYPE_SPELLING(T(function,3),out);
                APPEND_TEXT(STR_COLON_COLON,out);
            } else
                APPEND_TEXT(C33_TYPE_NAMES[T(type,0)],out);
            if(TB(function,11)==2)
                APPEND_TEXT(STR_PASCAL,out);
            APPEND_TEXT(STR_STAR_RPAREN,out);
            APPEND_PARAM_LIST(function,0,out);
        } else {
            APPEND_TYPE_SPELLING(T(type,7),out);
            APPEND_CHAR(' ',out);
            if(CPP_MODE && T(T(type,7),3)) {
                APPEND_TYPE_SPELLING(T(T(type,7),3),out);
                APPEND_TEXT(STR_COLON_COLON,out);
            } else
                APPEND_TEXT(C33_TYPE_NAMES[T(type,0)],out);
                /* A near pointer with mode 1..3 gets its qualifier word from
                   C33_POINTER_QUALIFIERS. */
            if(T(type,0)==13 && TS(type,13)!=0 && TS(type,13)<4)
                APPEND_TEXT(C33_POINTER_QUALIFIERS[TS(type,13)],out);
            APPEND_CHAR((TB(type,2)&0x20)?'&':'*',out);
        }
        if(TB(type,2)&1)
            APPEND_TEXT(STR_CONST_2,out);
        if(TB(type,2)&2)
            APPEND_TEXT(STR_VOLATILE_2,out);
        break;
    case 17:
        APPEND_TYPE_SPELLING(T(type,7),out);
        APPEND_CHAR('[',out);
            /* An array with attribute 0x20 is printed as "[]", probably one of unknown size. */
        if(!(TB(type,2)&0x20))
            APPEND_DECIMAL((unsigned long)TL(type,9),out);
        APPEND_CHAR(']',out);
        break;
    case 19:
    case 20:
        if(!CPP_MODE)
            APPEND_TEXT(C33_TYPE_NAMES[T(type,0)],out);
        if((SYB(LINK(T(type,5),6),7)>>3)==11)
            APPEND_SYMBOL_NAME(LINK(T(type,5),6),out);
        else if(CPP_MODE)
            APPEND_TEXT(T(type,0)==19?STR_STRUCT:STR_UNION,out);
        break;
    case 18:
        APPEND_TYPE_SPELLING(T(type,7),out);
        APPEND_PARAM_LIST(type,0,out);
        break;
    default:
        APPEND_TEXT(C33_TYPE_NAMES[T(type,0)],out);
        break;
    }
}
/* 0552: operator/constructor/destructor spelling and actual hidden-object flag. */
/* Appends the name of a function symbol. In C++ the class owner (or the symbol's own
   class when it is a member) comes first as "X::". Then by SYM_FUNC_KIND: 0 the plain
   name, 1 "operator " and the name, 2 "operator " and the result type (a conversion
   operator), 3 the class name (constructor; *skip is set when the class has virtual
   bases, so callers drop the extra hidden argument), 4 "~" and the class name. Typedef
   symbols (class 9) and non-functions just give their name. Note that FIELDS.H describes
   SYM_FUNC_KIND as 1 ordinary, 2 conversion, 3 constructor, 4 destructor; this switch
   treats 0 as ordinary and 1 as an operator function. */
static void near pascal APPEND_FUNCTION_NAME(register unsigned int symbol,register unsigned int owner,
    unsigned char far *skip,struct C33Buffer far *out)
{
    *skip=0;
    if(CPP_MODE) {
        if(!owner && (SYB(symbol,6)&0x10))
            owner=S(S(symbol,0),4);
        if(owner) {
            APPEND_SYMBOL_NAME(LINK(T(owner,5),6),out);
            APPEND_TEXT(STR_COLON_COLON,out);
        }
        if((SYB(symbol,7)>>3)==9 || T(S(symbol,4),0)!=18) {
            APPEND_SYMBOL_NAME(symbol,out);
            return;
        }
        switch(S(symbol,15)) {
        case 0:
            APPEND_SYMBOL_NAME(symbol,out);
            return;
        case 1:
            APPEND_TEXT(STR_OPERATOR_3,out);
            break;
        case 2:
            APPEND_TEXT(STR_OPERATOR_3,out);
            APPEND_TYPE_SPELLING(T(S(symbol,4),7),out);
            return;
        case 3:
            *skip=(LINK(T(owner,5),24)&4)!=0;
            APPEND_SYMBOL_NAME(LINK(T(owner,5),6),out);
            return;
        case 4:
            APPEND_CHAR('~',out);
            APPEND_SYMBOL_NAME(LINK(T(owner,5),6),out);
            return;
        default:
            return;
        }
    }
    APPEND_SYMBOL_NAME(symbol,out);
}
/* 0684: print call-argument types after the original implicit-argument removals. */
/* Spells a call as written: the called function's name and the types of the actual
   arguments, "f(int,char *)", for messages such as "could not find a match". expression
   is the call node: its left operand is the function node (whose left is the symbol and
   whose EXPR_SCOPE_CLASS, if set, replaces owner), its right operand the argument list
   (each list node: next in EXPR_LEFT, the argument in EXPR_RIGHT). For a member call
   the hidden this argument (and the virtual-base argument of a constructor) is skipped;
   for a destructor no arguments are shown. */
char far * far pascal FORMAT_CALL_SIGNATURE(unsigned int expression,unsigned int owner)
{
    register unsigned int argument;
    unsigned char skip;
    char far *start;
    start=BCC_DEBUG_NAME+DIAG_NAME_BUFFER.count;
    if(E(E(expression,10),14))
        owner=E(E(expression,10),14);
    APPEND_FUNCTION_NAME(E(E(expression,10),10),owner,&skip,&DIAG_NAME_BUFFER);
    APPEND_CHAR('(',&DIAG_NAME_BUFFER);
    if(!CPP_MODE || S(E(E(expression,10),10),15)!=4) {
        argument=E(expression,12);
        if(CPP_MODE && owner) {
            if(argument)
                argument=E(argument,10);
            if(skip && argument)
                argument=E(argument,10);
        }
        while(argument) {
            APPEND_TYPE_SPELLING(E(E(argument,12),8),&DIAG_NAME_BUFFER);
            argument=E(argument,10);
            if(argument)
                APPEND_CHAR(',',&DIAG_NAME_BUFFER);
        }
    }
    APPEND_CHAR(')',&DIAG_NAME_BUFFER);
    APPEND_CHAR(0,&DIAG_NAME_BUFFER);
    return start;
}
/* 0780: append one complete symbol spelling and return its borrowed buffer slice. */
/* Spells symbol: "name", or in C++ for a function "X::name(params) const". */
char far * far pascal FORMAT_SYMBOL(register unsigned int symbol)
{
    char far *start;
    unsigned char skip;
    unsigned int owner;
    start=BCC_DEBUG_NAME+DIAG_NAME_BUFFER.count;
    owner=(SYB(symbol,6)&0x10)?S(S(symbol,0),4):0;
    APPEND_FUNCTION_NAME(symbol,owner,&skip,&DIAG_NAME_BUFFER);
    if(CPP_MODE && T(S(symbol,4),0)==18) {
        if(S(symbol,15)==4)
            APPEND_TEXT(STR_LPAREN_RPAREN,&DIAG_NAME_BUFFER);
        else
            APPEND_PARAM_LIST(S(symbol,4),skip,&DIAG_NAME_BUFFER);
        if(TB(S(symbol,4),2)&1)
            APPEND_TEXT(STR_CONST_3,&DIAG_NAME_BUFFER);
        if(TB(S(symbol,4),2)&2)
            APPEND_TEXT(STR_VOLATILE_3,&DIAG_NAME_BUFFER);
    }
    APPEND_CHAR(0,&DIAG_NAME_BUFFER);
    return start;
}
/* 0862: actual member-kind closure is0..3; cases2/3 delegate to the symbol printer. */
/* Spells a class member as "X::name". Static members and member functions (kinds 2 and
   3 in MEMB_FLAGS) are spelled through their symbol (FORMAT_SYMBOL). */
long far pascal FORMAT_MEMBER(register unsigned int member)
{
    char far *start;
    union C33NameRef reference;
    char far *text;
    unsigned char value;
    register unsigned int type;
    start=BCC_DEBUG_NAME+DIAG_NAME_BUFFER.count;
    switch(MB(member,4)&3) {
    case 2:
    case 3:
        return (long)FORMAT_SYMBOL(M(member,6));
    case 0:
        type=M(member,10);
        break;
    case 1:
        type=M(member,10);
        break;
    }
    APPEND_SYMBOL_NAME(LINK(T(type,5),6),&DIAG_NAME_BUFFER);
    APPEND_TEXT(STR_COLON_COLON,&DIAG_NAME_BUFFER);
    reference.raw=*(char far * far *)MK_FP(NAME_POOL_SEG,M(member,2)+NAME_TEXT_OFFSET);
    text=MK_FP(*reference.parts.segment,reference.parts.offset);
    while((value=*text++)!=0)
        APPEND_CHAR(value,&DIAG_NAME_BUFFER);
    APPEND_CHAR(0,&DIAG_NAME_BUFFER);
    return (long)start;
}
/* 0936: restore the real symbol type after formatting through the temporary override. */
/* Spells symbol as if its type were type (for example to show the other one of two
   clashing overloads), then puts the real type back. No expression is built. */
long far pascal SPELL_SYMBOL_WITH_TYPE(register unsigned int symbol,unsigned int type)
{
    unsigned int saved_type;
    char far *text;
    saved_type=S(symbol,4);
    S(symbol,4)=type;
    text=FORMAT_SYMBOL(symbol);
    S(symbol,4)=saved_type;
    return (long)text;
}
/* The name of the class, struct, union or enum type type, as text. */
long far pascal CLASS_NAME_OF_TYPE(register unsigned int type)
{
    return (long)SYMBOL_NAME_TEXT(LINK(T(type,5),6));
}
/* 0996: common construction spelling; canonical LONG transports the FAR slice. */
/* Spells a compiler-generated special member of class type: kind 11 "X::operator=(...)",
   kind 6 the destructor "X::~X(...)", else the constructor "X::X(...)". reference set
   puts "X&" between the parentheses (copy constructor or assignment). */
long far pascal FORMAT_SPECIAL_MEMBER(unsigned int kind,unsigned int reference,unsigned int type)
{
    char far *start;
    register unsigned int symbol;
    start=BCC_DEBUG_NAME+DIAG_NAME_BUFFER.count;
    symbol=LINK(T(type,5),6);
    APPEND_SYMBOL_NAME(symbol,&DIAG_NAME_BUFFER);
    APPEND_TEXT(STR_COLON_COLON,&DIAG_NAME_BUFFER);
    if(kind==11)
        APPEND_TEXT(STR_OPERATOR_4,&DIAG_NAME_BUFFER);
    else {
        if(kind==6)
            APPEND_CHAR('~',&DIAG_NAME_BUFFER);
        APPEND_SYMBOL_NAME(symbol,&DIAG_NAME_BUFFER);
    }
    APPEND_CHAR('(',&DIAG_NAME_BUFFER);
    if(reference) {
        APPEND_SYMBOL_NAME(symbol,&DIAG_NAME_BUFFER);
        APPEND_CHAR('&',&DIAG_NAME_BUFFER);
    }
    APPEND_CHAR(')',&DIAG_NAME_BUFFER);
    APPEND_CHAR(0,&DIAG_NAME_BUFFER);
    return (long)start;
}
/* Spells type alone, for example "unsigned int far *". */
long far pascal FORMAT_TYPE(unsigned int type)
{
    char far *start;
    start=BCC_DEBUG_NAME+DIAG_NAME_BUFFER.count;
    APPEND_TYPE_SPELLING(type,&DIAG_NAME_BUFFER);
    APPEND_CHAR(0,&DIAG_NAME_BUFFER);
    return (long)start;
}
/* 0A80: sparse semantic-category words are real CS switch keys. */
/* Text for messages saying what kind of type an operator needs: "an integral type",
   "a pointer type", ... by category code; anything else "a simple type". */
char far * far pascal REQUIRED_TYPE_TEXT(unsigned int category)
{
    switch(category) {
    case 1: return STR_AN_INTEGRAL_TYPE;
    case 20: return STR_A_POINTER_TYPE;
    case 7: return STR_A_SCALAR_TYPE;
    case 3: return STR_AN_ARITHMETIC_TYPE;
    default: return STR_A_SIMPLE_TYPE;
    }
}
/* The name of a linkage (SYM_LINKAGE): 1 "C++", 2 "C", 3 "Pascal"; others "C++". */
long far pascal LINKAGE_NAME(unsigned int language)
{
    switch(language) {
    case 1: return (long)(char far *)STR_C_3;
    case 2: return (long)(char far *)STR_C_4;
    case 3: return (long)(char far *)STR_PASCAL_2;
    }
    return (long)(char far *)STR_C_3;
}
/* 0B0A: operator/name formatting retains branch-specific null and argument cases. */
/* Spells a member name that may not have a symbol yet (for "not a member" and similar
   messages). kind as SYM_FUNC_KIND: 0 the name, 1 "operator " and the name, 2 "operator "
   and the target of type (or just "type conversion" when type is 0), 3 the class name
   of member_type (constructor), 4 "~" and that name. When type is a function type its
   parameter list follows. Returns 0 for an unknown kind. */
char far * far pascal FORMAT_MEMBER_NAME(register unsigned int name,unsigned int kind,
    unsigned int type,unsigned int member_type)
{
    char far *start;
    start=BCC_DEBUG_NAME+DIAG_NAME_BUFFER.count;
    switch(kind) {
    case 0:
append_name:
        APPEND_TEXT(MK_FP(*NAME(name).segment,NAME(name).offset),&DIAG_NAME_BUFFER);
        break;
    case 1:
        APPEND_TEXT(STR_OPERATOR_3,&DIAG_NAME_BUFFER);
        goto append_name;
    case 2:
        if(!type)
            return STR_TYPE_CONVERSION;
        APPEND_TEXT(STR_OPERATOR_3,&DIAG_NAME_BUFFER);
        APPEND_TYPE_SPELLING(T(type,7),&DIAG_NAME_BUFFER);
        break;
    case 3:
    case 4:
        if(kind==4)
            APPEND_CHAR('~',&DIAG_NAME_BUFFER);
        APPEND_SYMBOL_NAME(LINK(T(member_type,5),6),&DIAG_NAME_BUFFER);
        break;
    default:
        return 0;
    }
    if(type && T(type,0)==18)
        APPEND_PARAM_LIST(type,kind==3 && (LINK(T(member_type,5),24)&4),&DIAG_NAME_BUFFER);
    APPEND_CHAR(0,&DIAG_NAME_BUFFER);
    return start;
}
