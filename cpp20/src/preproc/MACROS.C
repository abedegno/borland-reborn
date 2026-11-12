/* target: MACROS */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module MACROS (image 0xA040..0xA35D, frame 0A04h): source taken from the
   BCC.EXE reconstruction (bcc20/src/preproc/MACROS.C), with one edit
   (see BEGIN_BACKEND_PHASE); otherwise its code is the same in both programs. */
/* Role: preprocessor: macro table; define (warns on incompatible redefinition), undefine,
   test if defined, and find a name in a macro's parameter list. Entry points: MACRO_DEFINE,
   MACRO_REMOVE, MACRO_DEFINED, BCC_SYMBOL_CURRENT_TEST, MACRO_LOOKUP. */
/* Overview: the macro table.  A macro is attached to its name: the name's
   record in HASH_CHAIN_LINK_SEG (created or found by BCC_SYMBOL_CREATE)
   has a field HLINK_MACRO holding the offset of the macro's definition, or
   0 when the name is not a macro.  A definition is stored in POOL_E, or in
   POOL_F once POOL_E would pass 64K; POOL_E offsets are even and POOL_F
   offsets odd, so the offset alone says which pool it is in (see
   BCC_INPUT_BYTE and PUSH_MACRO_EXPANSION in INPUT.C).  Layout: one byte,
   the parameter count (0xFF, that is -1, for an object-like macro), then
   the body text with its marker bytes (see LEXER.C), zero-terminated, and
   in strict ANSI mode only, the parameter names (zero-terminated strings
   ending with an empty one), kept so a redefinition can be checked for
   identical parameter spelling.  Definitions are never freed: undefining
   or redefining just changes HLINK_MACRO.
   Callers: BCC_PARSE_MACRO and PARSE_UNDEF (PREPROC.C) for #define and
   #undef, the -D/-U option code, LEX_DEFINED and PARSE_IFDEF_DIRECTIVE for
   defined() and #ifdef, CLASSIFY_IDENTIFIER (LEXER.C) for each name
   scanned, and LEX_READ for parameter names in a #define body. */
#include "MACROS.H"
#include "MSG.H"
#include "POOL.H"
/* CPP.EXE edit: CPP.EXE has no back-end hook table; MACRO_DEFINED calls the session
   code's BEGIN_BACKEND_PHASE (INITPOOL module, CPP 05D4:00E5) directly, where BCC calls
   through BEGIN_BACKEND_OUTPUT_HOOK (call far 9A in CPP.EXE, call dword ptr in BCC.EXE). */
extern void far pascal BEGIN_BACKEND_PHASE(void);
/* Size in bytes of the parameter name list at offset in POOL_A, including
   its final empty string; 0 when not in strict ANSI mode, so the names are
   then not stored. */
static unsigned int near pascal BCC_PACKED_LIST_LENGTH(unsigned int offset)
{
    unsigned int length;
    register unsigned int cursor=offset,total;
    if(LANGUAGE_MODE!=1) return 0;
    total=1;
    while(AT_B(POOL_A,cursor)!=0) {
        length=STRING_LENGTH((char far *)MK_FP(POOL_A,cursor))+1;
        total+=length;
        cursor+=length;
    }
    return total;
}
/* Nonzero if the count bytes at offset in POOL_A equal those at text
   (always true for count 0). */
static int near pascal BCC_COUNTED_COMPARE(register unsigned int offset,
                                           unsigned char far *text,
                                           register unsigned int count)
{
    if(!count) return 1;
    while(count) {
        if(AT_B(POOL_A,offset)!=*text) return 0;
        --count;
        ++offset;
        ++text;
    }
    return 1;
}
/* Defines macro name with body replacement; flag is the parameter count
   (-1 object-like) and list the POOL_A offset of the parameter names.
   An identical redefinition keeps the old definition; a different one
   warns "redefinition not identical" and replaces it.  Returns the offset
   of the definition. */
unsigned int far pascal MACRO_DEFINE(char far *name,char far *replacement,
                                    signed char flag,unsigned int list)
{
    unsigned int node;
    char far *record;
    char far *arguments;
    unsigned int length;
    register unsigned int token,size;
    node=BCC_SYMBOL_CREATE(name,0);
    token=HLINK_W(node,HLINK_MACRO);
    if(flag!=0 && flag!=-1) length=BCC_PACKED_LIST_LENGTH(list);
    else length=0;
    if(token) {
        record=(char far *)MK_FP((token&1)?POOL_F:POOL_E,token);
        arguments=record+STRING_LENGTH(record+1)+2;
        if(*record!=flag || COMPARE_NAME(replacement,record+1) ||
           !BCC_COUNTED_COMPARE(list,(unsigned char far *)arguments,length)) {
            REPORT_WARNING(MSG_REDEFINITION_NOT,name);
            HLINK_W(node,HLINK_MACRO)=0;
        } else return token;
    }
    size=STRING_LENGTH(replacement)+length+2;
    size+=size&1;
    /* Allocation is a modular WORD; the original threshold interprets it as int. */
    if((long)POOL_E_UNIT+(int)size>65535L) {
        token=POOL_ALLOC(&POOL_F,size);
        record=(char far *)MK_FP(POOL_F,token);
    } else {
        token=POOL_ALLOC(&POOL_E,size);
        record=(char far *)MK_FP(POOL_E,token);
    }
    *record=flag;
    STRING_COPY(record+1,replacement);
    record+=STRING_LENGTH(replacement)+2;
    RTL_MEMMOVE(record,MK_FP(POOL_A,list),length);
    HLINK_W(node,HLINK_MACRO)=token;
    return token;
}
/* Undefines the macro named text. */
void far pascal MACRO_REMOVE(char far *text)
{
    HLINK_W(BCC_SYMBOL_CREATE(text,0),HLINK_MACRO)=0;
}
/* Nonzero if text names a macro, counting the predefined names.  Names
   beginning "__" or "_W" first start the output phase (BEGIN_BACKEND_PHASE), because
   the predefined memory-model and Windows macros are only defined then
   (INIT_SEGMENT_NAMES, SEGNAMES.C). */
int far pascal MACRO_DEFINED(char far *text)
{
    if(NAME_VALIDATE(text)) return 1;
    if(text[0]=='_' && (text[1]=='_' || text[1]=='W')) BEGIN_BACKEND_PHASE();
    if(HLINK_W(BCC_SYMBOL_CREATE(text,0),HLINK_MACRO)) return 1;
    return 0;
}
/* Looks up the name just scanned (in the token text buffer), leaves its
   name record in CURRENT_SYMBOL and returns nonzero if it is a macro. */
int far pascal BCC_SYMBOL_CURRENT_TEST(void)
{
    CURRENT_SYMBOL=BCC_SYMBOL_CREATE((char far *)TOKEN_PTR,0);
    return HLINK_W(CURRENT_SYMBOL,HLINK_MACRO)!=0;
}
static int near pascal BCC_SYMBOL_MATCH(unsigned char far *,unsigned char far *);
/* Returns the 1-based position of the name in the token text buffer in
   the parameter name list at offset in POOL_A, or 0 if it is not a
   parameter (or offset is 0, no list).  LEX_READ turns a nonzero result
   into the marker byte 0x80 + position. */
unsigned int far pascal MACRO_LOOKUP(register unsigned int offset)
{
    register unsigned int ordinal;
    if(offset==0) return 0;
    ordinal=1;
    while(AT_B(POOL_A,offset)!=0) {
        if(BCC_SYMBOL_MATCH((unsigned char far *)MK_FP(POOL_A,offset),
                            (unsigned char far *)TOKEN_PTR)) return ordinal;
        ++ordinal;
        offset+=STRING_LENGTH((char far *)MK_FP(POOL_A,offset))+1;
    }
    return 0;
}
/* Compares two names over their first NAME_LIMIT significant characters. */
static int near pascal BCC_SYMBOL_MATCH(unsigned char far *first,unsigned char far *second)
{
    register int count=0;
    while(count<NAME_LIMIT) {
        if(*first!=*second) return 0;
        if(*first==0) break;
        ++count;
        ++first;
        ++second;
    }
    return 1;
}
