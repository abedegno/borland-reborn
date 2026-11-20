/* target: ovr114_C56UNIT */
/* opts: -mm -G- -O -Z -p -Y */
/* Role: assembly text output (-S): end-of-module symbol declarations (EXTRN, PUBLIC, COMM,
   EQU), ?debug hex records and symbol name text. Entry points: DEBUG_NUMBERS, DUMP_ALL,
   C56_EMIT_NAME. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the C++ front end's twin of ASMEXTRN.C. When BCC writes assembly text (-S,
   or -B for TASM), these write the end-of-module declarations and the symbol spellings,
   reading the C++ symbol records (SYMBOL_POOL_SEG) where ASMEXTRN.C reads the C ones.
   - DEBUG_NUMBERS writes a debug record as "?debug C xx,xx,..." lines (the same code as
     EMIT_HEX_BYTE_LIST).
   - DUMP_ALL walks every prepared storage record (GET_PREPARED_SYMBOL, 10 bytes apart)
     and DUMP_ONE writes extrn, COMM, public, publicdll and equ lines for it; with -v
     DUMP_FINISH then writes the Turbo Debugger header and one "?debug F" line per
     function.
   - C56_EMIT_NAME writes the assembly spelling of a symbol: the mangled name for C++
     names, the upper-case name for pascal ones, "_name" under -u, "d@+n"/"b@+n" for
     static data addressed from the data or BSS base labels.
   The storage class is byte 7 >> 3 of a symbol (SYM_STORAGE_CLASS); as used here: 1
   public, 2 external, 3 defined here, 4 static data at d@/b@, 11 a struct/class tag.
   Prepared-symbol flags (GET_PREPARED_FLAGS): 16 initialized data (passed to the COMM
   writer), 64 pascal name, 128 communal (COMM), 256 written with a leading '@'.
   Symbol offsets used with NW/NB: 0 SYM_NEXT, 2 SYM_NAME, 4 SYM_TYPE, 6 SYM_FLAGS,
   7 SYM_STORAGE_CLASS, 8 SYM_STORAGE, 10 SYM_FUNC_FLAGS, 12 SYM_INLINE_ACCESS, 19
   SYM_NEXT_OVERLOAD. The string name C56_STACK_EQU misleads: it is "\tequ\ts@+"
   (an offset in the string-literal block s@, not the stack). STR_BSS_BASE_LABEL is "b@",
   the BSS base label. */
#include "ASMSYMS.H"
#include "POOL.H"
/* Arena offsets are byte offsets into the original node/type/name records. */
#define W(seg,record,field) (*(C56Word far *)MK_FP((seg),(record)+(field)))
#define B(seg,record,field) (*(C56Byte far *)MK_FP((seg),(record)+(field)))
#define NW(record,field) W(SYMBOL_POOL_SEG,record,field)
#define NB(record,field) B(SYMBOL_POOL_SEG,record,field)
#define PREDICATE_NODE(record) ((struct C56PredicateNode far *)MK_FP(SYMBOL_POOL_SEG,(record)))
#define TW(record,field) W(TYPE_POOL,record,field)
#define TB(record,field) B(TYPE_POOL,record,field)
#define MW(record,field) W(MEMBER_SEGMENT,record,field)
#define MB(record,field) B(MEMBER_SEGMENT,record,field)
/* Name records hold a near pointer to their current string-segment WORD. */
#define NAME_TEXT(record) ((char far *)MK_FP(*((C56Word near *)W(NAME_POOL_SEG,record,4)),W(NAME_POOL_SEG,record,2)))

/* Returns nonzero when symbol node gets a C++ mangled name: in C++ mode, a class member
   (flag 16) or a function with C++ linkage (SYM_LINKAGE, offset 17, equal to 1). */
static int near pascal NEEDS_CPP_MANGLING(register unsigned int node)
{
    return CPP_MODE &&
        ((PREDICATE_NODE(node)->flags&16) ||
         (TW(PREDICATE_NODE(node)->type,0)==18 &&
          PREDICATE_NODE(node)->predicate_value==1));
}

/* Writes the current object record buffer (skipping its first byte) as hex values after
   "\t?debug\tC ", 20 per line, continuing with "+\r\n\t?debug\tC ". count is the record
   length; the first byte (the COMENT attribute) is skipped, so count - 1 bytes are
   written. DEBUG_STATE is -1 while writing unless the comment class is E6h. */
void far pascal DEBUG_NUMBERS(int count)
{
    int saved;
    register char near *p;
    register int printed;
    saved=DEBUG_STATE;
    p=OBJ_RECORD_BUFFER()+1;
    if(*p!=(char)0xE6) DEBUG_STATE=-1;
    PUT_CODE_STRING(DEBUG_PREFIX);
start:
    printed=0;
next:
    EMIT_HEX_BYTE(*p);
    ++printed;
    ++p;
    --count;
    if(count<=1) goto suffix;
    if(printed<20) goto next;
    PUT_CODE_STRING(DEBUG_MORE);
    goto start;
suffix:
    PUT_CODE_STRING(DEBUG_SUFFIX);
    DEBUG_STATE=saved;
}

/* Writes the declarations for one symbol of class 1, 2 or 3 that has storage and is used
   (SYM_FLAGS bits 2/4) or communal: "extrn name:type" (or a COMM line with element size
   and count for arrays) for externals; "public name" or "publicdll name" (export flag
   512) for publics, which then fall into the class-3 case; "name equ s@+n" for a
   non-function in segment 0; and, for a defined symbol whose public spelling differs
   from its plain name (pascal name with lower case, or -u on a non-mangled name),
   "public-spelling equ name". The class byte is set to 1 and back to 3 so NAME_HOOK
   writes the two spellings. */
static void near pascal DUMP_ONE(register unsigned int node)
{
    int kind;
    long count;
    unsigned int type;
    unsigned int flags;
    int state;
    char far *text;
    register unsigned int name;
    state=NB(node,7)>>3;
    if(state!=2 && state!=1 && state!=3) return;
    if(NW(node,8)==0) return;
    name=PREPARE_SYMBOL(node);
    flags=GET_PREPARED_FLAGS(name);
    if((NB(node,6)&6)==0 && !(flags&128)) return;
    /* Storage class: 2 external, 1 public, 3 defined here. */
    switch(NB(node,7)>>3) {
    case 2:
        type=NW(node,4);
        if(flags&128) {
            count=1;
            while(TW(type,0)==17) {
                count*=TYPE_L(type,TYPE_PARAMS);
                type=TW(type,7);
            }
            EMIT_COMM_DECLARATION(name,flags&16,(unsigned int)TYPE_SIZE(type),count);
        } else {
            PUT_CODE_STRING(C56_EXTERN);
            NAME_HOOK(name);
            ((C56CharacterWordTransport)PUT_CODE_CHAR)(':');
            kind=SYMBOL_ELEMENT_KIND_HOOK(name);
            if(kind==18 && GET_SYMBOL_SEGMENT_HOOK(name)!=-1)
                PUT_CODE_STRING(C56_NEAR);
            else
                PUT_CODE_STRING(ASM_TYPE_NAME_TABLE[kind]);
        }
        PUT_CODE_STRING(DEBUG_SUFFIX);
        break;
    case 1:
        if(W(CSYM_POOL_SEG,name,8)&512)
            PUT_CODE_STRING(C56_PUBLIC_DLL);
        else
            PUT_CODE_STRING(C56_PUBLIC);
        NAME_HOOK(name);
        PUT_CODE_STRING(DEBUG_SUFFIX);
        /* A public declaration may also need the stack-relative definition. */
        /* (Note: C56_STACK_EQU is "\tequ\ts@+": the definition is relative to the
           string-literal block s@, not to the stack. Case 1 falls into case 3 on
           purpose.) */
    case 3:
        if(GET_SYMBOL_SEGMENT_HOOK(name)!=0 || TW(NW(node,4),0)==18 ||
                ((NB(node,6)&32)!=0 && !(NB(node,6)&4))) break;
        NAME_HOOK(name);
        PUT_CODE_STRING(C56_STACK_EQU);
        EMIT_SIGNED_DECIMAL(SYMBOL_INDEX_HOOK(name));
        PUT_CODE_STRING(DEBUG_SUFFIX);
        break;
    }
    if((NB(node,7)>>3)!=3 || GET_SYMBOL_SEGMENT_HOOK(name)==0) return;
    if(flags&64) {
        text=NAME_TEXT(NW(node,2));
        while(*text) {
            if(_CTYPE[(int)*text+1]&8) break;
            ++text;
        }
        if(*text==0) return;
    } else {
        if(OPTION_UNDERSCORES==0 || NEEDS_CPP_MANGLING(node)) return;
    }
    NB(node,7)=(NB(node,7)&7)|8;
    NAME_HOOK(name);
    PUT_CODE_STRING(C56_EQU);
    NB(node,7)=(NB(node,7)&7)|24;
    NAME_HOOK(name);
    PUT_CODE_STRING(DEBUG_SUFFIX);
}

/* End of module: declarations for every prepared symbol, then the -v debug lines. The
   gotos form an ordinary loop over the prepared records (10 bytes each, from 10 up to
   NODE_COUNT). */
void far pascal DUMP_ALL(void)
{
    register unsigned int node;

    node = 0;
    goto test;
next:
    DUMP_ONE(GET_PREPARED_SYMBOL(node));
test:
    node += 10;
    if (node < NODE_COUNT)
        goto next;
    if (OPTION_SOURCE_DEBUG)
        DUMP_FINISH();
}

/* Writes "\t?debug\tF name typeindex flags" for function symbol node, unless its
   prepared flags have 0x100. flags is 18h, or 98h when the function type's calling
   convention byte (offset 11) is 4, for symbols with prepared flag 0x20; else 0. */
static void near pascal DUMP_NODE(register unsigned int node)
{
    unsigned char kind;
    int flags;
    register unsigned int name;

    name = PREPARE_SYMBOL(node);
    flags = GET_PREPARED_FLAGS(name);
    if (flags & 0x100)
        return;
    kind = 0;
    if (flags & 0x20) {
        kind = ((unsigned char far *)MK_FP(TYPE_POOL,
                ((unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node))[2]))[11] == 4 ?
               0x98 : 0x18;
    }
    PUT_CODE_STRING(DEBUG_NODE_PREFIX);
    NAME_HOOK(name);
    ((C56CharacterWordTransport)PUT_CODE_CHAR)(32);
    EMIT_DECIMAL(GET_TYPE_DEBUG_ID(((unsigned int far *)MK_FP(SYMBOL_POOL_SEG, node))[2]));
    ((C56CharacterWordTransport)PUT_CODE_CHAR)(32);
    EMIT_DECIMAL(kind);
    PUT_CODE_STRING(DEBUG_SUFFIX);
}

/* Writes "\t?debug\tC EA" + version ("05" in C++, "01" in C) + memory model with the
   -u flag in bit 3, calls DEBUG_HEADER_DONE_HOOK, then walks every name of the name hash
   table (1024 buckets, chains in HASH_CHAIN_LINK_SEG, symbols of each name) and writes a
   ?debug F line for each function (class 3) and, in C++, each overload of it
   (SYM_NEXT_OVERLOAD). For a class tag (class 11) with tag flag 1, member functions
   (member kind 3, not flag 0x80) are walked too and their overloads with inline kind 1
   and function flag 2 are written. */
static void near pascal DUMP_FINISH(void)
{
    int bucket;
    unsigned int chain;
    unsigned int member;
    unsigned int associated;
    register unsigned int node;
    register unsigned int head;
    PUT_CODE_STRING(DEBUG_PREFIX);
    EMIT_HEX_BYTE(234);
    PUT_CODE_STRING(CPP_MODE?C56_VERSION_EXTENDED:C56_VERSION_BASE);
    EMIT_HEX_BYTE((signed char)OPTION_MEMORY_MODEL|((int)(signed char)OPTION_UNDERSCORES<<3));
    PUT_CODE_STRING(DEBUG_SUFFIX);
    DEBUG_HEADER_DONE_HOOK();
    for(bucket=0;bucket<1024;++bucket) {
        for(chain=NAME_HASH_TABLE[bucket];chain;chain=W(HASH_CHAIN_LINK_SEG,chain,0)) {
            for(head=W(NAME_POOL_SEG,chain,0);head;head=NW(head,0)) {
                node=head;
                do {
                    switch(NB(node,7)>>3) {
                    case 3:
                        if(TW(NW(node,4),0)==18) DUMP_NODE(node);
                        break;
                    case 11:
                        if(CPP_MODE && (EXPR_FLAGS[TW(NW(node,4),0)]&64) &&
                                (W(TAG_BODY_POOL_SEG,TW(NW(node,4),5),24)&1)) {
                            for(member=W(TAG_BODY_POOL_SEG,TW(NW(node,4),5),2);member;member=MW(member,0)) {
                                if((MB(member,4)&3)!=3 || (MB(member,4)&128)!=0) continue;
                                for(associated=MW(member,6);associated;associated=NW(associated,19)) {
                                    if((NB(associated,12)&3)==1 && (NW(associated,10)&2))
                                        DUMP_NODE(associated);
                                }
                            }
                        }
                        break;
                    }
                } while(CPP_MODE && TW(NW(node,4),0)==18 && ((node=NW(node,19))!=0));
            }
        }
    }
}

/* Writes the assembly spelling of prepared symbol name (see the overview). Class 3 is
   written as is (after an optional '@'); class 4 as "d@+n", "b@+n", or with "w+" for
   kinds above 2; a pascal name (C56_NAME_FLAGS 64) in upper case; else '_' is added
   under -u unless the name is mangled. */
void far pascal C56_EMIT_NAME(unsigned int name)
{
    char far *text;
    int special;
    register unsigned int node;
    node=GET_PREPARED_SYMBOL(name);
    special=NEEDS_CPP_MANGLING(node);
    if(special)
        text=MANGLE_SYMBOL_NAME(node);
    else
        text=STRING_COPY(BCC_DEBUG_NAME,NAME_TEXT(NW(node,2)));
    if(GET_PREPARED_FLAGS(name)&256) ((C56CharacterWordTransport)PUT_CODE_CHAR)('@');
    if((NB(node,7)>>3)==3) goto output;
    if((NB(node,7)>>3)==4) {
        if(GET_SYMBOL_SEGMENT_HOOK(name)==DATA_SEGMENT_ID)
            PUT_CODE_STRING(C56_DATA_MARK);
        else
            PUT_CODE_STRING(STR_BSS_BASE_LABEL);
        if(SYMBOL_ELEMENT_KIND_HOOK(name)<=2)
            PUT_CODE_STRING(C56_PLUS);
        else
            PUT_CODE_STRING(C56_WORD_MARK);
        EMIT_DECIMAL(SYMBOL_INDEX_HOOK(name));
        return;
    }
    if(C56_NAME_FLAGS(name)&64) {
        while(*text) {
            ((C56CharacterWordTransport)PUT_CODE_CHAR)(RTL_TOUPPER((int)*text));
            ++text;
        }
        return;
    }
    if(!special && OPTION_UNDERSCORES) ((C56CharacterWordTransport)PUT_CODE_CHAR)('_');
output:
    PUT_CODE_STRING(text);
}
