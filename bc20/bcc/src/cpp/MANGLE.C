/* target: ovr070_C14UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: C++ names: name mangling for symbols, member functions, operators, conversions and
   argument types; decimal output used by type spelling. Entry points: APPEND_DECIMAL,
   MANGLE_PLAIN_NAME, MANGLE_FUNCTION_PREFIX, MANGLE_SYMBOL_NAME, MANGLE_MEMBER_NAME. Map of
   all sources: docs/SOURCE-MAP.md. */
/* Overview: Borland C++ name mangling, the link names that encode a C++ symbol's
   class and parameter types. MANGLE_SYMBOL_NAME is the main entry, used when a symbol
   is written to the object file and to name per-function and virtual table segments
   (CPPCTOR.C, CPPFINAL.C); MANGLE_MEMBER_NAME does the same for a member record;
   MANGLE_PLAIN_NAME and MANGLE_FUNCTION_PREFIX are also used by the type spelling for
   messages, and APPEND_DECIMAL by type spelling (diag/).
   The form built here is
     @Class@name$q<arguments>            member function
     @name$q<arguments>                  ordinary function
     @Class@$b<op>$q... / @Class@$o<type>$q...   operators / conversion functions
     @Class@name                         static data member, ordinary data
   with 'x' and 'w' before the 'q' for const and volatile member functions, and '0'
   after "@Class@" when the class is huge (class flag 0x100) or OPTION_FLAG is set
   (the same test that makes its virtual table far, see C12HIDDEN). Argument types: one or two letters per type from
   C14_TYPE_ENCODINGS (qualifiers 'x' const, 'w' volatile first), 'p'/'r' near
   pointer/reference, 'n'/'m' far pointer/reference, 'a<count>$' arrays, 'q...$'
   functions, length-prefixed names for classes and enums, 'v' for no arguments, 'e'
   for an ellipsis, and 't<code>' to repeat an earlier argument's type (codes from
   C14_ARGUMENT_CODES; only for types longer than two letters).
   All output goes into a C14Buffer (length plus text, at most 0x1FF characters);
   MANGLE_SYMBOL_NAME and MANGLE_MEMBER_NAME use the shared C14_NAME_BUFFER and
   shorten the result to 63 characters, replacing the last two with a checksum of the
   cut-off part. The operator names come from TOKEN_FROM_NAME of the function name
   (token codes, see TOKEN.H). */
#include <dos.h>
#include "MANGLE.H"
#include "POOL.H"
#define NAME_REF(n) (*(char far * far *)MK_FP(NAME_POOL_SEG,(n)+2))

/* C14CHAR / C14TEXT: append a character or a zero-ended string to out, dropping what
   does not fit. */
static void near pascal C14CHAR(char value,struct C14Buffer far *out)
{
    if(out->length<0x1FF)
        out->text[out->length++]=value;
}

static void near pascal C14TEXT(char far *text,struct C14Buffer far *out)
{
    char value;
    while((value=*text++)!=0)
        C14CHAR(value,out);
}

/* C14SYMBOL: appends the name of symbol (nothing for 0 or an unnamed symbol); the
   name record holds a far pointer to the text through a bank segment word. */
static void near pascal C14SYMBOL(register unsigned int symbol,
    struct C14Buffer far *out)
{
    union C14NameRef reference;
    char far *text;

    if(symbol && SYM_W(symbol,SYM_NAME)) {
        reference.raw=NAME_REF(SYM_W(symbol,SYM_NAME));
        text=MK_FP(*reference.parts.segment,reference.parts.offset);
        C14TEXT(text,out);
    }
}

/* 00A0: unsigned decimal output, genuine exported RETF8. */
/* APPEND_DECIMAL: appends value in decimal. */
void far pascal APPEND_DECIMAL(unsigned long value,struct C14Buffer far *out)
{
    unsigned int digits[12];
    register int index=12;

    do {
        ((unsigned int far *)digits)[--index]=(unsigned int)(value%10UL)+'0';
        value/=10UL;
    } while(value!=0);
    while(index<=11)
        C14CHAR((char)((unsigned int far *)digits)[index++],out);
}

/* C14LENGTH: appends a symbol's name preceded by its length in decimal (the form used
   for class and enum types among the arguments). */
static void near pascal C14LENGTH(unsigned int symbol,
    struct C14Buffer far *out)
{
    struct C14Buffer temporary;
    register int index;

    temporary.length=0;
    C14SYMBOL(symbol,&temporary);
    APPEND_DECIMAL((unsigned long)temporary.length,out);
    index=0;
    while(index<(int)temporary.length) {
        C14CHAR(temporary.text[index],out);
        ++index;
    }
}

/* C14PREFIX: appends '@' and, for a member, the class name, '@' and the marker '0'
   for a huge class (or with OPTION_FLAG). owner is the class's tag symbol or 0. */
static void near pascal C14PREFIX(register unsigned int owner,
    struct C14Buffer far *out)
{
    C14CHAR('@',out);
    if(owner) {
        C14SYMBOL(owner,out);
        C14CHAR('@',out);
        if(OPTION_FLAG || (TAG_W(TYPE_W(SYM_W(owner,SYM_TYPE),TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x100))
            C14CHAR('0',out);
    }
}

/* Actual native PUBLIC MANGLE_PLAIN_NAME at original stub0BDE:0034. */
/* MANGLE_PLAIN_NAME: out = @[Class@]name, the mangled name of a data symbol, or the
   start of a function's name. */
void far pascal MANGLE_PLAIN_NAME(unsigned int owner,unsigned int symbol,
    struct C14Buffer far *out)
{
    out->length=0;
    C14PREFIX(owner,out);
    C14SYMBOL(symbol,out);
}

/* Its genuine CS switch table follows at0339..034B. */
/* C14TYPE: appends the encoding of type (see the overview); '?' for a missing type.
   Pointers, arrays and functions continue with the encoding of their target type. */
static void near pascal C14TYPE(register unsigned int type,
    struct C14Buffer far *out)
{
    if(!type) {
        C14CHAR('?',out);
        return;
    }
    if(TYPE_B(type,TYPE_ATTRS)&1)
        C14CHAR('x',out);
    if(TYPE_B(type,TYPE_ATTRS)&2)
        C14CHAR('w',out);
    switch(TYPE_W(type,TYPE_KIND)) {
    case TK_ENUM:
        C14LENGTH(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),out);
        return;
    case TK_NEAR_PTR:
        C14CHAR((TYPE_B(type,TYPE_ATTRS)&0x20)?'r':'p',out);
        goto recurse_type;
    case TK_FAR_PTR:
        C14CHAR((TYPE_B(type,TYPE_ATTRS)&0x20)?'m':'n',out);
        goto recurse_type;
    case TK_SEG_PTR:
    case TK_HUGE_PTR:
        C14TEXT(C14_TYPE_ENCODINGS[TYPE_W(type,TYPE_KIND)],out);
        goto recurse_type;
    case TK_ARRAY:
        C14CHAR('a',out);
        if(!((unsigned int)TYPE_B(type,TYPE_ATTRS)&0x20))
            APPEND_DECIMAL(TYPE_UL(type,TYPE_ARRAY_COUNT),out);
        C14CHAR('$',out);
        goto recurse_type;
    case TK_STRUCT:
    case TK_UNION:
        C14LENGTH(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_SYMBOL),out);
        return;
    case TK_FUNCTION:
        C14CHAR('q',out);
        C14ARGUMENTS(type,0,0,out);
        C14CHAR('$',out);
    recurse_type:
        C14TYPE(TYPE_W(type,TYPE_TARGET),out);
        return;
    default:
        C14TEXT(C14_TYPE_ENCODINGS[TYPE_W(type,TYPE_KIND)],out);
        return;
    }
}

/* C14SHORT: 1 when type is a basic type whose encoding, with a qualifier letter, is at
   most two characters: repeating it is shorter than a 't' back-reference. */
static unsigned char near pascal C14SHORT(register unsigned int type)
{
    unsigned int qualifier;

    qualifier=(TYPE_B(type,TYPE_ATTRS)&3)!=0;
    return (int)TYPE_W(type,TYPE_KIND)<=TK_VOID &&
        STRING_LENGTH(C14_TYPE_ENCODINGS[TYPE_W(type,TYPE_KIND)])+qualifier<=2;
}

/* C14ARGUMENTS: appends the parameter types of function type, skipping the first
   parameter when first is set (this) and the next when second is set (the hidden
   virtual-base flag of a constructor or the flags of a destructor). A type equal to an
   earlier parameter's (up to 35 remembered) is written as 't' plus the earlier
   position's code. */
static void near pascal C14ARGUMENTS(unsigned int type,unsigned char first,
    unsigned char second,struct C14Buffer far *out)
{
    unsigned char variadic;
    union C14Arguments workspace;
    register unsigned int parameter;
    register int count;

    parameter=TYPE_W(type,TYPE_PARAMS);
    variadic=(TYPE_B(type,TYPE_FUNC_FLAGS)&4)!=0;
    if(first)
        parameter=FORMAL_W(parameter,FORMAL_NEXT);
    if(second)
        parameter=FORMAL_W(parameter,FORMAL_NEXT);
    count=0;
    if(!parameter)
        C14CHAR('v',out);
    else {
        do {
            if(count<=35)
                ((unsigned int far *)workspace.slots)[++count]=FORMAL_W(parameter,FORMAL_TYPE);
            if(C14SHORT(FORMAL_W(parameter,FORMAL_TYPE)))
                C14TYPE(FORMAL_W(parameter,FORMAL_TYPE),out);
            else {
                for(workspace.fields.search=1;
                    workspace.fields.search<count &&
                        !TYPES_COMPATIBLE(((unsigned int far *)workspace.slots)[workspace.fields.search],
                            FORMAL_W(parameter,FORMAL_TYPE),0);
                    ++workspace.fields.search)
                    ;
                if(workspace.fields.search>=count)
                    C14TYPE(FORMAL_W(parameter,FORMAL_TYPE),out);
                else {
                    C14CHAR('t',out);
                    C14CHAR(C14_ARGUMENT_CODES[workspace.fields.search],out);
                }
            }
            parameter=FORMAL_W(parameter,FORMAL_NEXT);
        } while(parameter);
    }
    if(variadic)
        C14CHAR('e',out);
}

/* 04B1, with its genuine compiler-generated CS switch table. */
/* C14OPERATOR: @[Class@]$b<name> for a binary operator function; operation is the
   operator's token code and selects the short name (add, sub, asg, ...; '?' if unknown;
   r-prefixed names for compound assignments). */
static void near pascal C14OPERATOR(unsigned int owner,unsigned int operation,
    struct C14Buffer far *out)
{
    char far *text;

    C14PREFIX(owner,out);
    C14CHAR('$',out);
    C14CHAR('b',out);
    switch(operation) {
    case 22:
        text=(char far *)STR_ADD;
        break;
    case 23:
        text=(char far *)STR_SUB;
        break;
    case 24:
        text=(char far *)STR_MUL;
        break;
    case 25:
        text=(char far *)STR_DIV;
        break;
    case 26:
        text=(char far *)STR_MOD;
        break;
    case 29:
        text=(char far *)STR_X;
        break;
    case 27:
        text=(char far *)STR_AND;
        break;
    case 28:
        text=(char far *)STR_OR;
        break;
    case 43:
        text=(char far *)STR_CMP;
        break;
    case 11:
        text=(char far *)STR_ASG;
        break;
    case 38:
        text=(char far *)STR_LSS;
        break;
    case 39:
        text=(char far *)STR_GTR;
        break;
    case 12:
        text=(char far *)STR_RPLU;
        break;
    case 13:
        text=(char far *)STR_RMIN;
        break;
    case 14:
        text=(char far *)STR_RMUL;
        break;
    case 15:
        text=(char far *)STR_RDIV;
        break;
    case 16:
        text=(char far *)STR_RMOD;
        break;
    case 19:
        text=(char far *)STR_RXOR;
        break;
    case 17:
        text=(char far *)STR_RAND;
        break;
    case 18:
        text=(char far *)STR_ROR;
        break;
    case 30:
        text=(char far *)STR_LSH;
        break;
    case 31:
        text=(char far *)STR_RSH;
        break;
    case 20:
        text=(char far *)STR_RLSH;
        break;
    case 21:
        text=(char far *)STR_RRSH;
        break;
    case 36:
        text=(char far *)STR_EQL;
        break;
    case 37:
        text=(char far *)STR_NEQ;
        break;
    case 40:
        text=(char far *)STR_LEQ;
        break;
    case 41:
        text=(char far *)STR_GEQ;
        break;
    case 35:
        text=(char far *)STR_LAND;
        break;
    case 34:
        text=(char far *)STR_LOR;
        break;
    case 1:
        text=(char far *)STR_CALL;
        break;
    case 3:
        text=(char far *)STR_SUBS;
        break;
    case 108:
        text=(char far *)STR_NEW_2;
        break;
    case 105:
        text=(char far *)STR_DELE;
        break;
    case 48:
        text=(char far *)STR_AROW;
        break;
    case 8:
        text=(char far *)STR_COMA;
        break;
    case 102:
        text=(char far *)STR_ARWM;
        break;
    default:
        text=(char far *)STR_QUEST;
        break;
    }
    while(*text)
        C14CHAR(*text++,out);
}

/* 0781, with its genuine compiler-generated CS switch table. */
/* C14SPECIAL: the same for the one-operand forms: unary operators (unary + and -,
   ind for *, adr for &, not, inc, dec, cmp for ~), constructors (ctr, operation 5),
   destructors (dtr, 6), new and delete. */
static void near pascal C14SPECIAL(unsigned int owner,unsigned int operation,
    struct C14Buffer far *out)
{
    char far *text;

    C14PREFIX(owner,out);
    C14CHAR('$',out);
    C14CHAR('b',out);
    switch(operation) {
    case 22:
        text=(char far *)STR_ADD;
        break;
    case 23:
        text=(char far *)STR_SUB;
        break;
    case 24:
        text=(char far *)STR_IND;
        break;
    case 27:
        text=(char far *)STR_ADR;
        break;
    case 43:
        text=(char far *)STR_CMP;
        break;
    case 42:
        text=(char far *)STR_NOT;
        break;
    case 45:
        text=(char far *)STR_INC;
        break;
    case 46:
        text=(char far *)STR_DEC;
        break;
    case 5:
        text=(char far *)STR_CTR;
        break;
    case 6:
        text=(char far *)STR_DTR;
        break;
    case 108:
        text=(char far *)STR_NEW_2;
        break;
    case 105:
        text=(char far *)STR_DELE;
        break;
    default:
        text=(char far *)STR_QUEST;
        break;
    }
    while(*text)
        C14CHAR(*text++,out);
}

/* C14CONVERSION: @[Class@]$o<type> for a conversion function to type. */
static void near pascal C14CONVERSION(unsigned int owner,unsigned int type,
    struct C14Buffer far *out)
{
    C14PREFIX(owner,out);
    C14CHAR('$',out);
    C14CHAR('o',out);
    C14TYPE(type,out);
}

/* 08DA, with the genuine five-WORD CS table at09EC..09F6. */
/* MANGLE_FUNCTION_PREFIX: out = the part of a function's mangled name before its
   argument types, ending in $q (with x/w for const/volatile functions). The form
   depends on SYM_FUNC_KIND: 0 plain name, 1 operator function (unary when it has a
   single parameter, counting this), 2 conversion function, 3 constructor, 4 destructor.
   (So kind 1 is an operator function here, not an ordinary one.) owner is the class's
   tag symbol or 0. */
void far pascal MANGLE_FUNCTION_PREFIX(register unsigned int owner,
    register unsigned int symbol,struct C14Buffer far *out)
{
    unsigned int parameter;

    out->length=0;
    switch(SYM_W(symbol,SYM_FUNC_KIND)) {
    case 0:
        MANGLE_PLAIN_NAME(owner,symbol,out);
        break;
    case 1:
        parameter=TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_PARAMS);
        if(FORMAL_W(parameter,FORMAL_NEXT)==0)
            C14SPECIAL(owner,TOKEN_FROM_NAME(SYM_W(symbol,SYM_NAME)),out);
        else
            C14OPERATOR(owner,TOKEN_FROM_NAME(SYM_W(symbol,SYM_NAME)),out);
        break;
    case 2:
        C14CONVERSION(owner,TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_TARGET),out);
        break;
    case 3:
        C14SPECIAL(owner,5,out);
        break;
    case 4:
        C14SPECIAL(owner,6,out);
        break;
    }
    C14CHAR('$',out);
    if(TYPE_B(SYM_W(symbol,SYM_TYPE),TYPE_ATTRS)&1)
        C14CHAR('x',out);
    if(TYPE_B(SYM_W(symbol,SYM_TYPE),TYPE_ATTRS)&2)
        C14CHAR('w',out);
    C14CHAR('q',out);
}

/* C14NAME: the full mangled name of symbol: for a function the prefix and the
   argument types, skipping this (non-static members) and the hidden parameter of a
   destructor or of a constructor of a class with virtual bases; for data the plain
   name. */
static void near pascal C14NAME(register unsigned int symbol,
    struct C14Buffer far *out)
{
    unsigned int owner_symbol;
    unsigned char first;
    unsigned char second;
    register unsigned int owner;

    owner=(SYM_B(symbol,SYM_FLAGS)&0x10)?SYM_W(SYM_W(symbol,SYM_OWNER_CLASS),SYM_TYPE):0;
    owner_symbol=owner==0?0:TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_SYMBOL);
    if(TYPE_W(SYM_W(symbol,SYM_TYPE),TYPE_KIND)==TK_FUNCTION) {
        first=owner && !(SYM_W(symbol,SYM_FUNC_FLAGS)&0x40);
        second=0;
        MANGLE_FUNCTION_PREFIX(owner_symbol,symbol,out);
        if(owner) {
            if(SYM_W(symbol,SYM_FUNC_KIND)==4)
                second=1;
            else if(SYM_W(symbol,SYM_FUNC_KIND)==3)
                second=(TAG_W(TYPE_W(owner,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&4)!=0;
        }
        C14ARGUMENTS(SYM_W(symbol,SYM_TYPE),first,second,out);
    } else
        MANGLE_PLAIN_NAME(owner_symbol,symbol,out);
}

/* C14SHORTEN: cuts out to limit characters when longer than limit - 2, putting a
   two-character checksum of the removed tail (letters from a 63-character alphabet)
   in the last two places, so long names stay distinct (probably for the 63-character
   limit of OMF names, or of the linker). */
static void near pascal C14SHORTEN(register int limit,
    struct C14Buffer far *out)
{
    char far *alphabet=(char far *)STR_ZYXWVUTSRQPONMLKJIHGFEDC;
    register int checksum;

    if((int)out->length>limit-2) {
        int index;
        checksum=0;
        for(index=limit-2;index<(int)out->length;++index)
            checksum=checksum+out->text[index];
        out->text[limit-2]=alphabet[(checksum/63)%63];
        out->text[limit-1]=alphabet[checksum%63];
        out->length=limit;
    }
}

/* MANGLE_SYMBOL_NAME: the mangled name of symbol as a zero-ended string in
   C14_NAME_BUFFER (overwritten by the next call). */
char far * far pascal MANGLE_SYMBOL_NAME(unsigned int symbol)
{
    C14NAME(symbol,&C14_NAME_BUFFER);
    C14SHORTEN(63,&C14_NAME_BUFFER);
    C14_NAME_BUFFER.text[C14_NAME_BUFFER.length]=0;
    return (char far *)C14_NAME_BUFFER.text;
}

/* MANGLE_MEMBER_NAME: @Class@name for member record member, in C14_NAME_BUFFER. */
char far * far pascal MANGLE_MEMBER_NAME(register unsigned int member)
{
    union C14NameRef reference;
    char far *text;

    C14_NAME_BUFFER.length=0;
    C14PREFIX(TAG_W(TYPE_W(MEMBER_W(member,MEMB_CLASS),TYPE_TAG_BODY),TAG_SYMBOL),&C14_NAME_BUFFER);
    reference.raw=NAME_REF(MEMBER_W(member,MEMB_NAME));
    text=MK_FP(*reference.parts.segment,reference.parts.offset);
    C14TEXT(text,&C14_NAME_BUFFER);
    C14SHORTEN(63,&C14_NAME_BUFFER);
    C14_NAME_BUFFER.text[C14_NAME_BUFFER.length]=0;
    return (char far *)C14_NAME_BUFFER.text;
}
