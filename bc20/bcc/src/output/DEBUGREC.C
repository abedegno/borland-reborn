/* target: ovr122_C127UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: debug information records. Entry points: BCC_SYMBOL_SWEEP, EMIT_DEBUG_TYPE,
   EMIT_DEBUG_MEMBER_PTR_TYPE, EMIT_DEBUG_METHOD_TYPE, EMIT_DEBUG_BEGIN_SCOPE,
   EMIT_DEBUG_SCOPE_SYMBOLS, EMIT_DEBUG_TREE_LOCALS, EMIT_DEBUG_GLOBALS. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: Turbo Debugger information (-v) for C++ compiles; OBJSYMS.C does the same for
   C. The records are OMF COMENT records (88h) built with the OMFWRITE.C helpers; in
   assembly mode they come out as "?debug C" lines. Comment classes used (the word
   E300h etc. passed to OBJ_PUT_WORD is a 0 attribute byte followed by the class):
   E2h struct/class members, E3h a type, E4h enum members, E5h scope start, E6h a list
   of symbols, E7h scope end, EBh external with type, ECh public with type, EDh a class
   description (bases), F8h the class of the function being compiled.
   Types: EMIT_DEBUG_TYPE writes a type once, after the types it uses, giving it the next
   debug id (TYPE_DEBUG_ID_COUNTER, read and set through GET/SET_TYPE_DEBUG_ID). Its
   mode argument is a scope's symbol list: a class declared in another scope is only
   marked (bit 15 of TAG_DEBUG_CLASS_INDEX) and written when its own scope is reached;
   GLOBAL_SCOPE_TAGS (the global tag list) means file scope. Type codes beyond C's: 2Dh member
   function, 2Eh class, 30h based pointer, 33h member pointer, 34h/35h near/far
   reference.
   Symbols: E6h lists hold name, type id and a storage byte (0 static + group, segment,
   offset; 2 auto + frame offset; 4 register + register code; 5 constant + long value;
   6 typedef; 7 tag; with 8 added for a parameter).
   Whole-module walks (BCC_SYMBOL_SWEEP at the end of the object, EMIT_DEBUG_GLOBALS)
   visit every name of the name hash table (1024 buckets, chains in HASH_CHAIN_LINK_SEG,
   symbols of a name linked by word 0), and for C++ functions also each overload (word
   19, SYM_NEXT_OVERLOAD). Symbols are read with raw offsets: 2 SYM_NAME, 4 SYM_TYPE,
   6 SYM_FLAGS (2 defined, 4 used, 0x10 member, 0x20 not referenced), 7 storage class in
   bits 3-7 (1 public, 2 extern, 3 defined here, 4 static, 5 auto, 6 parameter, 8 typedef,
   9 enum constant, 11 tag, 14 member alias, 15 skipped), 8 SYM_STORAGE, 10
   SYM_FUNC_FLAGS, 12 SYM_INLINE_ACCESS, 15 SYM_FUNC_KIND, 21 SYM_VIRTUAL_INDEX. Some
   names: THIS_NAME is the name record of "this", CURRENT_FUNCTION_TYPE the type of the
   current function, EMIT_DEBUG_METHOD_TYPE writes a member-function type, EMIT_DEBUG_ENUM_MEMBERS an enum
   member list, EMIT_DEBUG_CLASS a class description, EMIT_DEBUG_PARAM_LIST the parameter list. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"

/* ---- TMEMCHK (listing B200) ---- */
extern int far OBJ_RECORD_LENGTH(void);
extern void far OBJ_WRITE_RECORD(unsigned char value);
extern void far OBJ_RESET_RECORD(void);
extern void far OBJ_PUT_WORD(unsigned int value);

/* Keeps a COMENT record under about 4000 bytes: when the body is longer, writes it and
   starts a new one with the same attribute/class word value. */
static void far pascal TYPE_MEMCHECK(unsigned int value)
{
    if (OBJ_RECORD_LENGTH() > 0x0FA0) {
        OBJ_WRITE_RECORD(0x88);
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(value);
    }
}

/* ---- TSWEEP (listing B226) ---- */
void far pascal EMIT_DEBUG_TYPE(register unsigned int node,register unsigned int mode);
extern unsigned int NAME_HASH_TABLE[]; extern unsigned int NAME_POOL_SEG; extern unsigned int HASH_CHAIN_LINK_SEG;
extern unsigned int far pascal GET_TYPE_DEBUG_ID(unsigned int);
void far pascal EMIT_DEBUG_METHOD_TYPE(register unsigned int node,unsigned int mode);
static void near pascal BCC_TYPE_EMIT_SPECIAL(unsigned int);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_PUT_INDEX(unsigned int);
extern void far pascal OBJ_PUT_NAME(char far *);
#define TAG(n) (AT_B(SYMBOL_POOL_SEG,(n)+7)>>3)
#define LINK(t,n) AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,(t)+5)+(n))
/* End-of-module debug information for a C++ compile (called from
   EMIT_EXTDEF_PUBDEF_RECORDS under -v): the class types, the types of defined symbols,
   member aliases and enum constants, then E6h lists of the module's statics, the types of
   inline member functions (SYM_FUNC_FLAGS bit 2, not when VTABLE_MODE is 3), the
   typedefs and integral enum constants, and the tags. "opened" tells whether an E6h
   record is pending. The loops are four passes of the same name-table walk. */
void far pascal BCC_SYMBOL_SWEEP(void)
{
    int opened,bucket;
    unsigned int chain,kind,member,nested;
    register unsigned int item;
    register unsigned int root;
    opened=0;
    if (CPP_MODE) {
        for(bucket=0;bucket<0x400;++bucket) {
            for(chain=NAME_HASH_TABLE[bucket];chain;chain=AT_W(HASH_CHAIN_LINK_SEG,chain)) {
                for(root=AT_W(NAME_POOL_SEG,chain);root;root=AT_W(SYMBOL_POOL_SEG,root)) {
                    item=root;
                    do {
                        if(TAG(item)==11 && GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,item+4)))
                            EMIT_DEBUG_TYPE(AT_W(SYMBOL_POOL_SEG,item+4),GLOBAL_SCOPE_TAGS);
                    } while(CPP_MODE && TAG(item)!=8 && AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4))==0x12 &&
                            (item=AT_W(SYMBOL_POOL_SEG,item+19))!=0);
                }
            }
        }
    }
    for(bucket=0;bucket<0x400;++bucket) {
        for(chain=NAME_HASH_TABLE[bucket];chain;chain=AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for(root=AT_W(NAME_POOL_SEG,chain);root;root=AT_W(SYMBOL_POOL_SEG,root)) {
                item=root;
                do {
                    kind=TAG(item);
                    if(kind==3 || kind==14 || kind==9)
                        EMIT_DEBUG_TYPE(AT_W(SYMBOL_POOL_SEG,item+4),GLOBAL_SCOPE_TAGS);
                } while(CPP_MODE && TAG(item)!=8 && AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4))==0x12 &&
                        (item=AT_W(SYMBOL_POOL_SEG,item+19))!=0);
            }
        }
    }
    OBJ_RESET_RECORD();OBJ_PUT_WORD(0xE600);
    for(bucket=0;bucket<0x400;++bucket) {
        for(chain=NAME_HASH_TABLE[bucket];chain;chain=AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for(root=AT_W(NAME_POOL_SEG,chain);root;root=AT_W(SYMBOL_POOL_SEG,root)) {
                item=root;
                do {
                    kind=AT_W(SYMBOL_POOL_SEG,item+4);
                    if(!AT_W(SYMBOL_POOL_SEG,item+2)) continue;
                    if(CPP_MODE && TAG(item)==11 && (EXPR_FLAGS[AT_W(TYPE_POOL,kind)]&0x40) && (LINK(kind,24)&1)) {
                        for(member=LINK(kind,2);member;member=AT_W(MEMBER_SEGMENT,member)) {
                            if((AT_B(MEMBER_SEGMENT,member+4)&3)!=3) continue;
                            for(nested=AT_W(MEMBER_SEGMENT,member+6);nested;nested=AT_W(SYMBOL_POOL_SEG,nested+19)) {
                                if(TAG(nested)==3 && !(AT_B(SYMBOL_POOL_SEG,nested+6)&0x20) &&
                                   (AT_W(SYMBOL_POOL_SEG,nested+10)&2) && VTABLE_MODE!=3) {
                                    if(opened) {OBJ_WRITE_RECORD(0x88);opened=0;}
                                    EMIT_DEBUG_METHOD_TYPE(nested,GLOBAL_SCOPE_TAGS);
                                    OBJ_RESET_RECORD();OBJ_PUT_WORD(0xE600);
                                    BCC_TYPE_EMIT_SPECIAL(nested);
                                    opened=1;
                                }
                            }
                        }
                    } else {
                        if(TAG(item)==14) {
                            if(!(AT_B(MEMBER_SEGMENT,AT_W(SYMBOL_POOL_SEG,item+8)+4)&0x40)) {
                                BCC_TYPE_EMIT_SPECIAL(item);
                                opened=1;
                            }
                        } else if(TAG(item)==3) {
                            if(AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4))==0x12 && (AT_B(SYMBOL_POOL_SEG,item+12)&3)==1) {
                                if((AT_W(SYMBOL_POOL_SEG,item+10)&2) && VTABLE_MODE!=3) {
                                    if(opened) {OBJ_WRITE_RECORD(0x88);opened=0;}
                                    EMIT_DEBUG_METHOD_TYPE(item,GLOBAL_SCOPE_TAGS);
                                    OBJ_RESET_RECORD();OBJ_PUT_WORD(0xE600);
                                    BCC_TYPE_EMIT_SPECIAL(item);
                                    opened=1;
                                }
                            } else if(item!=STRING_LITERAL_SYMBOL && (AT_B(SYMBOL_POOL_SEG,item+6)&2)) {
                                BCC_TYPE_EMIT_SPECIAL(item);
                                opened=1;
                            }
                        }
                    }
                } while(CPP_MODE && TAG(item)!=8 && AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4))==0x12 &&
                        (item=AT_W(SYMBOL_POOL_SEG,item+19))!=0);
            }
        }
    }
    for(bucket=0;bucket<0x400;++bucket) {
        for(chain=NAME_HASH_TABLE[bucket];chain;chain=AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for(item=AT_W(NAME_POOL_SEG,chain);item;item=AT_W(SYMBOL_POOL_SEG,item)) {
                kind=TAG(item);
                member=GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,item+4));
                if(kind!=8 && kind!=9) continue;
                if(!AT_W(SYMBOL_POOL_SEG,item+2)) continue;
                if(!member) continue;
                if(kind==9 && !(EXPR_FLAGS[AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4))]&1)) continue;
                TYPE_MEMCHECK(0xE600);
                opened=1;
                OBJ_PUT_NAME(STRING_COPY(BCC_DEBUG_NAME,
                    (char far *)MK_FP(*(unsigned int near *)AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,item+2)+4),
                                     AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,item+2)+2))));
                OBJ_PUT_INDEX(member);
                if(kind==8) OBJ_PUT_BYTE(6);
                else {
                    OBJ_PUT_BYTE(5);
                    OBJ_PUT_WORD(*(long far *)MK_FP(SYMBOL_POOL_SEG,item+SYM_STORAGE)&0xFFFFL);
                    OBJ_PUT_WORD((*(long far *)MK_FP(SYMBOL_POOL_SEG,item+SYM_STORAGE)>>16)&0xFFFFL);
                }
            }
        }
    }
    for(bucket=0;bucket<0x400;++bucket) {
        for(chain=NAME_HASH_TABLE[bucket];chain;chain=AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for(item=AT_W(NAME_POOL_SEG,chain);item;item=AT_W(SYMBOL_POOL_SEG,item)) {
                kind=AT_W(SYMBOL_POOL_SEG,item+4);
                member=GET_TYPE_DEBUG_ID(kind);
                if(TAG(item)==11 && AT_W(SYMBOL_POOL_SEG,item+2) && kind && member) {
                    TYPE_MEMCHECK(0xE600);
                    opened=1;
                    OBJ_PUT_NAME(STRING_COPY(BCC_DEBUG_NAME,
                        (char far *)MK_FP(*(unsigned int near *)AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,item+2)+4),
                                         AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,item+2)+2))));
                    OBJ_PUT_INDEX(member);
                    OBJ_PUT_BYTE(7);
                }
            }
        }
    }
    if(opened) OBJ_WRITE_RECORD(0x88);
}
#undef TAG
#undef LINK
/* ---- EMIT_DEBUG_TYPE (listing B885) ---- */
static unsigned int near pascal EMIT_DEBUG_STRUCT_MEMBERS(unsigned int node,unsigned int mode);
extern void far pascal SET_TYPE_DEBUG_ID(unsigned int,unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
void far pascal EMIT_DEBUG_MEMBER_PTR_TYPE(unsigned int node,unsigned int mode);
static void near pascal EMIT_DEBUG_ENUM_MEMBERS(unsigned int type);
static void near pascal EMIT_DEBUG_CLASS(unsigned int type,unsigned int unused,unsigned int count);
#define LINK(n) AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,node+5)+(n))

/* Writes the E3h record of C++ type node if it has no debug id yet (see the overview):
   index, name ("" or the tag name), size, type code and its operands. A class with
   virtual functions or bases (tag flags 21h) gets a class index, its base classes first,
   the member list (EMIT_DEBUG_STRUCT_MEMBERS) and the class code 2Eh with a description
   (EMIT_DEBUG_CLASS). A struct without body takes void's id. Pointers to members and
   based pointers take two ids. Scalars have fixed ids and are not written. */
void far pascal EMIT_DEBUG_TYPE(register unsigned int node,register unsigned int mode)
{
    unsigned int flags;
    unsigned int count;
    unsigned int emitted;
    unsigned int name;
    unsigned int param;

    if (node == 0)
        return;
    if (GET_TYPE_DEBUG_ID(node)) {
        if (CPP_MODE != 0 && (EXPR_FLAGS[AT_W(TYPE_POOL,node)] & 0x40) != 0 && (LINK(8) & 0x8000) != 0)
            /* Already emitted: only the parameter list is emitted again (count
               and name are set on that path); the original jumps into the
               case 19/20 block past LINK(8)=DEBUG_CLASS_INDEX_NEXT++. */
            goto parameters;
        return;
    }
    name = 0;
    SET_TYPE_DEBUG_ID(node,TYPE_DEBUG_ID_COUNTER++);
    switch (AT_W(TYPE_POOL,node)) {
    case 21:
        ++TYPE_DEBUG_ID_COUNTER;
        if (LINK(6))
            name = AT_W(SYMBOL_POOL_SEG,LINK(6)+2);
        EMIT_DEBUG_ENUM_MEMBERS(node);
        break;
    case 19:
    case 20:
        if (LINK(4) == 0) {
            SET_TYPE_DEBUG_ID(node,GET_TYPE_DEBUG_ID(VOID_TYPE));
            --TYPE_DEBUG_ID_COUNTER;
            return;
        } else if (CPP_MODE && (LINK(24) & 0x21)) {
            LINK(8) = DEBUG_CLASS_INDEX_NEXT++;
parameters:
            if (mode != GLOBAL_SCOPE_TAGS) {
                unsigned int scope;

                for (scope = mode; scope && LINK(6) != scope; scope = AT_W(SYMBOL_POOL_SEG,scope))
                    ;
                if (scope == 0) {
                    LINK(8) |= 0x8000;
                    return;
                }
            }
            name = 0;
            LINK(8) &= 0x7FFF;
            count = 0;
            for (param = LINK(12); param != 0; param = AT_W(BASE_LIST_SEG,param)) {
                ++count;
                EMIT_DEBUG_TYPE(AT_W(BASE_LIST_SEG,param+2),mode);
            }
        }
        if (LINK(6))
            name = AT_W(SYMBOL_POOL_SEG,LINK(6)+2);
        emitted = EMIT_DEBUG_STRUCT_MEMBERS(node,mode);
        break;
    case 17:
        EMIT_DEBUG_TYPE(AT_W(TYPE_POOL,node+7),mode);
        break;
    case 13:
        if (CPP_MODE && AT_B(TYPE_POOL,node+13) == 11) {
            ++TYPE_DEBUG_ID_COUNTER;
            EMIT_DEBUG_MEMBER_PTR_TYPE(AT_W(TYPE_POOL,node+7),mode);
        } else {
            if (AT_W(TYPE_POOL,node+9))
                ++TYPE_DEBUG_ID_COUNTER;
            EMIT_DEBUG_TYPE(AT_W(TYPE_POOL,node+7),mode);
        }
        break;
    case 14:
    case 15:
    case 16:
        EMIT_DEBUG_TYPE(AT_W(TYPE_POOL,node+7),mode);
        break;
    case 18:
        EMIT_DEBUG_TYPE(AT_W(TYPE_POOL,node+7),mode);
        break;
    default:
        --TYPE_DEBUG_ID_COUNTER;
        return;
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE300);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(node));
    OBJ_PUT_NAME(name ? STRING_COPY((char far *)BCC_DEBUG_NAME,
                       (char far *)MK_FP(*(unsigned int near *)AT_W(NAME_POOL_SEG,name+4),AT_W(NAME_POOL_SEG,name+2)))
                 : (char far *)BCC_DEBUG_EMPTY);
    OBJ_PUT_WORD((unsigned int)TYPE_SIZE(node));
    switch (AT_W(TYPE_POOL,node)) {
    case 21:
        OBJ_PUT_BYTE(0x22);
        OBJ_PUT_BYTE(0);
        OBJ_PUT_WORD(0x8000);
        OBJ_PUT_WORD(0x7FFF);
        break;
    case 19:
    case 20:
        if (CPP_MODE && (LINK(24) & 0x21))
            EMIT_DEBUG_CLASS(node,emitted,count);
        else
            OBJ_PUT_BYTE(AT_W(TYPE_POOL,node) == 19 ? 0x1E : 0x1F);
        break;
    case 17:
        OBJ_PUT_BYTE(0x1A);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(TYPE_POOL,node+7)));
        break;
    case 13:
        flags = 0x15;
        if (AT_W(TYPE_POOL,node+9))
            flags = 0x30;
        else if (CPP_MODE) {
            if (AT_B(TYPE_POOL,node+2) & 0x20)
                flags = 0x34;
            else if (AT_B(TYPE_POOL,node+13) == 11)
                flags = 0x33;
        }
        OBJ_PUT_BYTE((unsigned char)flags);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(TYPE_POOL,node+7)));
        if (flags == 0x30)
            OBJ_PUT_NAME(STRING_COPY(BCC_DEBUG_NAME,
                /* Documented exception: a dummy read of the same word first, so
                   ES (TYPE_POOL) is loaded before [POOL_HASH] is pushed, as in
                   the original (0A1A mov es; 0A1E push [789C]). */
                ((void)*(char near * far *)MK_FP(TYPE_POOL,node+TYPE_PARAMS),
                 MK_FP(POOL_HASH,*(char near * far *)MK_FP(TYPE_POOL,node+TYPE_PARAMS)))));
        else if (flags == 0x33)
            OBJ_PUT_INDEX(AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,AT_W(TYPE_POOL,AT_W(TYPE_POOL,node+7)+3)+5)+8) & 0x7FFF);
        else
            OBJ_PUT_BYTE(AT_B(TYPE_POOL,node+13));
        break;
    case 14:
        OBJ_PUT_BYTE(0x17); OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(TYPE_POOL,node+7))); OBJ_PUT_BYTE(0);
        break;
    case 15:
        flags = 0x16;
        if (CPP_MODE && (AT_B(TYPE_POOL,node+2) & 0x20))
            flags = 0x35;
        OBJ_PUT_BYTE((unsigned char)flags); OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(TYPE_POOL,node+7))); OBJ_PUT_BYTE(0);
        break;
    case 16:
        OBJ_PUT_BYTE(0x16); OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(TYPE_POOL,node+7))); OBJ_PUT_BYTE(1);
        break;
    case 18:
        flags = (AT_B(TYPE_POOL,node+11) - 1) & 3;
        if (AT_B(TYPE_POOL,node+12) & 1)
            flags |= 4;
        OBJ_PUT_BYTE(0x23);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(TYPE_POOL,node+7)));
        OBJ_PUT_BYTE((unsigned char)flags);
        OBJ_PUT_BYTE((AT_B(TYPE_POOL,node+12) & 4) ? 1 : 0);
        break;
    }
    OBJ_WRITE_RECORD(0x88);
}
#undef LINK

/* ---- TEMIT2 (listing BD5C) ---- */

/* For a pointer to member function: writes the class and the function type node as a
   2Dh member-function record (result type, calling convention, far bit, flags 9, class
   id, no virtual index); node takes two ids. */
void far pascal EMIT_DEBUG_MEMBER_PTR_TYPE(register unsigned int node, register unsigned int mode)
{
    unsigned int flags;

    EMIT_DEBUG_TYPE(*(unsigned int far *)MK_FP(TYPE_POOL, node + TYPE_MEMBER_CLASS), mode);
    if (GET_TYPE_DEBUG_ID(node) != 0)
        return;
    EMIT_DEBUG_TYPE(*(unsigned int far *)MK_FP(TYPE_POOL, node + TYPE_TARGET), mode);
    SET_TYPE_DEBUG_ID(node, TYPE_DEBUG_ID_COUNTER);
    TYPE_DEBUG_ID_COUNTER += 2;
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE300);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(node));
    OBJ_PUT_NAME(BCC_DEBUG_EMPTY);
    OBJ_PUT_WORD(TYPE_SIZE(node));
    OBJ_PUT_BYTE(0x2D);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(*(unsigned int far *)MK_FP(TYPE_POOL, node + TYPE_TARGET)));
    flags = (*(unsigned char far *)MK_FP(TYPE_POOL, node + TYPE_CALL_CONV) - 1) & 3;
    if ((*(unsigned char far *)MK_FP(TYPE_POOL, node + TYPE_FUNC_FLAGS) & 1) != 0)
        flags |= 4;
    OBJ_PUT_BYTE((unsigned char)flags);
    OBJ_PUT_BYTE(9);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(*(unsigned int far *)MK_FP(TYPE_POOL, node + TYPE_MEMBER_CLASS)));
    OBJ_PUT_INDEX(0);
    OBJ_WRITE_RECORD(0x88);
}
/* ---- TEMIT3 (listing BE43) ---- */
extern void far pascal OBJ_PUT_SYMBOL_NAME(unsigned int,int);
/* Writes the type of function symbol node as a 2Dh member-function record: result type,
   calling convention and far bit, then flags (1 member, 8 inline, 4 when SYM_FUNC_KIND
   is 1), and for a member its class id, its virtual slot ((SYM_VIRTUAL_INDEX - 1) / 2)
   and, when not inline, its linker name. The type takes two ids. */
void far pascal EMIT_DEBUG_METHOD_TYPE(register unsigned int node,unsigned int mode)
{
    register unsigned int type = AT_W(SYMBOL_POOL_SEG,node+4);
    unsigned int flags, extra;
    if (GET_TYPE_DEBUG_ID(type) == 0) {
        EMIT_DEBUG_TYPE(AT_W(TYPE_POOL,type+7),mode);
        SET_TYPE_DEBUG_ID(type,TYPE_DEBUG_ID_COUNTER);
        TYPE_DEBUG_ID_COUNTER += 2;
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xE300);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(type));
        OBJ_PUT_NAME(BCC_DEBUG_EMPTY);
        OBJ_PUT_WORD(TYPE_SIZE(type));
        OBJ_PUT_BYTE(0x2D);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(TYPE_POOL,type+7)));
        flags = (AT_B(TYPE_POOL,type+11)-1) & 3;
        if (AT_B(TYPE_POOL,type+12) & 1) flags |= 4;
        OBJ_PUT_BYTE((unsigned char)flags);
        flags = 0;
        if (AT_B(SYMBOL_POOL_SEG,node+6) & 0x10) flags |= 1;
        if ((AT_B(SYMBOL_POOL_SEG,node+12) & 3) == 1 &&
            (VTABLE_MODE != 3 || !(AT_W(SYMBOL_POOL_SEG,node+10) & 2))) flags |= 8;
        if (AT_W(SYMBOL_POOL_SEG,node+15) == 1) flags |= 4;
        OBJ_PUT_BYTE((unsigned char)flags);
        if (AT_B(SYMBOL_POOL_SEG,node+6) & 0x10) {
            OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,AT_W(SYMBOL_POOL_SEG,node)+4)));
            extra = 0;
            if (AT_W(SYMBOL_POOL_SEG,node+21)) extra = (AT_W(SYMBOL_POOL_SEG,node+21)-1) >> 1;
            OBJ_PUT_INDEX(extra);
            if (!(flags & 8)) OBJ_PUT_SYMBOL_NAME(node,0);
        }
        OBJ_WRITE_RECORD(0x88);
    }
}

/* ---- TPREP (listing BFA5) ---- */
extern char far * far pascal MANGLE_MEMBER_NAME(unsigned int);
/* Writes the E4h member list of enum type: name and value per enumerator, 80h on the
   last. With TYPE_ATTRS 0x40 the members are member records (mangled names, last one
   marked by MEMB_FLAGS 0x20); otherwise enumerator symbols chained through word 10,
   with the value in SYM_STORAGE. */
static void near pascal EMIT_DEBUG_ENUM_MEMBERS(register unsigned int type)
{
    register unsigned int m;

    OBJ_RESET_RECORD();OBJ_PUT_WORD(0xE400);
    if(TYPE_B(type,TYPE_ATTRS)&0x40) {
        for(m=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);m;
            m=(MEMBER_B(m,MEMB_FLAGS)&0x20)?0:MEMBER_W(m,MEMB_NEXT)) {
            TYPE_MEMCHECK(0xE400);
            OBJ_PUT_BYTE((MEMBER_B(m,MEMB_FLAGS)&0x20)?0x80:0);
            OBJ_PUT_NAME(MANGLE_MEMBER_NAME(m));
            OBJ_PUT_WORD(MEMBER_W(m,MEMB_VALUE));
        }
    } else {
        for(m=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_MEMBERS);m;m=SYM_W(m,SYM_FUNC_FLAGS)) {
            TYPE_MEMCHECK(0xE400);
            OBJ_PUT_BYTE(SYM_W(m,SYM_FUNC_FLAGS)==0?0x80:0);
            OBJ_PUT_NAME(STRING_COPY(BCC_DEBUG_NAME,
                (char far *)MK_FP(*(unsigned int near *)NAME_W(SYM_W(m,SYM_NAME),NAME_TEXT_BANK),NAME_W(SYM_W(m,SYM_NAME),NAME_TEXT_OFFSET))));
            OBJ_PUT_WORD(SYM_W(m,SYM_STORAGE));
        }
    }
    OBJ_WRITE_RECORD(0x88);
}
/* ---- TPARAM0 (listing C0B8) ---- */
extern unsigned int far pascal BCC_MEMBER_LOOKUP(unsigned int);
/* Returns MEMB_VALUE (word 3) of the member BCC_MEMBER_LOOKUP finds for class type value,
   or 0; probably the offset of the virtual table pointer. */
static unsigned int near pascal BCC_TYPE_PARAM0(unsigned int value)
{
    register unsigned int member=BCC_MEMBER_LOOKUP(value);
    if (!member) return 0;
    return ((unsigned int far *)MK_FP(MEMBER_SEGMENT,member))[3];
}

/* ---- TPARAMS (listing C0DD) ---- */
extern unsigned char OPTION_MEMORY_MODEL;
/* Ends the E3h record of a class with code 2Eh and its class index, then starts an EDh
   class description: class index, BCC_TYPE_PARAM0, flags (1 unless tag flag 20h, 2 for
   far virtual tables: huge model, OPTION_FLAG or tag flag 100h), the number of base
   classes and one word per base (its class index, bit 15 for a virtual base). The caller
   writes the record. unused is not read. */
static void near pascal EMIT_DEBUG_CLASS(register unsigned int type,unsigned int unused,unsigned int count)
{
    unsigned int param;
    unsigned int flags;

    OBJ_PUT_BYTE(0x2E);
    OBJ_PUT_INDEX(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_DEBUG_CLASS_INDEX)&0x7FFF);
    OBJ_WRITE_RECORD(0x88);OBJ_RESET_RECORD();OBJ_PUT_WORD(0xED00);OBJ_PUT_BYTE(0);
    OBJ_PUT_INDEX(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_DEBUG_CLASS_INDEX)&0x7FFF);
    OBJ_PUT_WORD(BCC_TYPE_PARAM0(type));
    flags=(TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x20)?0:1;
    if(OPTION_MEMORY_MODEL==5 || OPTION_FLAG!=0 || (TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_CLASS_FLAGS)&0x100)!=0) flags|=2;
    OBJ_PUT_BYTE((unsigned char)flags);
    OBJ_PUT_INDEX(count);
    for(param=TAG_W(TYPE_W(type,TYPE_TAG_BODY),TAG_BASES);param;param=BASE_W(param,BASE_NEXT)) {
        flags=TAG_W(TYPE_W(BASE_W(param,BASE_TYPE),TYPE_TAG_BODY),TAG_DEBUG_CLASS_INDEX)&0x7FFF;
        if(BASE_B(param,BASE_VIRTUAL)!=0) flags|=0x8000;
        OBJ_PUT_WORD(flags);
    }
}
/* ---- EMIT_DEBUG_STRUCT_MEMBERS (listing C1FC) ---- */
extern char far * far pascal MANGLE_SYMBOL_NAME(unsigned int);

/* Writes the types the members of class node use, then its E2h member list, and returns
   the DEBUG_MEMBER_COUNTER value before the list. Data members: a byte 0 (or the bit
   width for a bit field), name and type id; for a struct, gaps are written as 40h
   entries (new offset) and bit gaps as padding entries. Member functions: 48h ordinary,
   49h destructor (kind 4), 4Ah constructor (3), 4Bh conversion (2), 50h static, 4 added
   if virtual; then the name (mangled unless simple) and type id. Static data: 60h, mangled
   name, type id. The list ends with C0h and the class size. Members with MEMB_FLAGS
   0x80 are skipped. */
static unsigned int near pascal EMIT_DEBUG_STRUCT_MEMBERS(unsigned int node,unsigned int mode)
{
    unsigned int cursor;
    unsigned int distance;
    int width;
    int bits;
    int gap;
    unsigned int size;
    unsigned int saved;
    unsigned int temp;
    unsigned char simple;
    unsigned int queried;
    register unsigned int type;
    register unsigned int member;

    for (member = AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,node+5)+2); member; member = AT_W(MEMBER_SEGMENT,member)) {
        if (AT_B(MEMBER_SEGMENT,member+4) & 0x80)
            continue;
        switch (AT_B(MEMBER_SEGMENT,member+4) & 3) {
        case 3:
            for (temp = AT_W(MEMBER_SEGMENT,member+6); temp != 0; temp = AT_W(SYMBOL_POOL_SEG,temp+19))
                if (!(AT_B(SYMBOL_POOL_SEG,temp+6) & 0x20))
                    EMIT_DEBUG_METHOD_TYPE(temp,mode);
            break;
        case 2:
            EMIT_DEBUG_TYPE(AT_W(SYMBOL_POOL_SEG,AT_W(MEMBER_SEGMENT,member+6)+4),mode);
            break;
        case 0:
            EMIT_DEBUG_TYPE(AT_W(MEMBER_SEGMENT,member+8),mode);
            break;
        case 1:
            EMIT_DEBUG_TYPE(AT_W(MEMBER_SEGMENT,member+8),mode);
            break;
        }
    }
    saved = DEBUG_MEMBER_COUNTER;
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE200);
    AT_B(MEMBER_SEGMENT,MEMB_FLAGS) &= 0x7F;      /* record 0, not member+4: 10C6 and byte ptr es:[4],7Fh */
    bits = 0;
    cursor = distance = 0;
    for (member = AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,node+5)+2); member; member = AT_W(MEMBER_SEGMENT,member)) {
        if (AT_B(MEMBER_SEGMENT,member+4) & 0x80)
            continue;
        ++DEBUG_MEMBER_COUNTER;
        switch (AT_B(MEMBER_SEGMENT,member+4) & 3) {
        case 0:
            if (AT_W(TYPE_POOL,node) == 0x13) {
                distance = AT_W(MEMBER_SEGMENT,member+6) - cursor;
                gap = 0;
                if ((AT_B(MEMBER_SEGMENT,member+4) & 0x40) && (AT_B(MEMBER_SEGMENT,member+5) & 7) > bits) {
                    gap = (AT_B(MEMBER_SEGMENT,member+5) & 7) - bits;
                    if (bits + gap >= 8) {
                        bits += gap;
                        gap = 0;
                        do {
                            ++distance;
                            bits -= 8;
                        } while (bits >= 8);
                    }
                }
                if (distance) {
                    if (distance > 1 || bits == 0) {
                        temp = AT_W(MEMBER_SEGMENT,member+6) - (bits > 0 ? 1 : 0);
                        OBJ_PUT_BYTE(0x40);
                        OBJ_PUT_BYTE(temp & 0xFF);
                        OBJ_PUT_BYTE(temp >> 8);
                        OBJ_PUT_BYTE(0);
                        OBJ_PUT_BYTE(0);
                        distance = 1;
                    }
                    if (bits > 0) {
                        OBJ_PUT_BYTE((distance << 3) - bits);
                        OBJ_PUT_BYTE(0);
                        OBJ_PUT_BYTE(0);
                        bits = 0;
                    }
                    cursor = AT_W(MEMBER_SEGMENT,member+6);
                }
            }
            TYPE_MEMCHECK(0xE200);
            if (AT_B(MEMBER_SEGMENT,member+4) & 0x40) {
                /* For a union, gap is read unset here, as in the original
                   (1132 jmp 122D skips 1143 mov [bp-0Ah],0; 1240 cmp [bp-0Ah],0). */
                if (gap > 0) {
                    OBJ_PUT_BYTE(gap);
                    OBJ_PUT_BYTE(0);
                    OBJ_PUT_BYTE(0);
                    bits += gap;
                }
                width = AT_B(MEMBER_SEGMENT,member+5) >> 3;
                bits += width;
                OBJ_PUT_BYTE(width);
                while (bits >= 8) {
                    ++cursor;
                    bits -= 8;
                }
            } else {
                OBJ_PUT_BYTE(0);
                cursor += (unsigned int)TYPE_SIZE(AT_W(MEMBER_SEGMENT,member+8));
                bits = 0;
            }
            OBJ_PUT_NAME(STRING_COPY((char far *)BCC_DEBUG_NAME,(char far *)MK_FP(
                *(unsigned int near *)AT_W(NAME_POOL_SEG,AT_W(MEMBER_SEGMENT,member+2)+4),
                AT_W(NAME_POOL_SEG,AT_W(MEMBER_SEGMENT,member+2)+2))));
            OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(MEMBER_SEGMENT,member+8)));
            break;
        case 3:
            for (type = AT_W(MEMBER_SEGMENT,member+6); type; type = AT_W(SYMBOL_POOL_SEG,type+19)) {
                temp = 0;
                simple = !(AT_W(SYMBOL_POOL_SEG,type+10) & 6);
                queried = GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,type+4));
                if (AT_B(SYMBOL_POOL_SEG,type+6) & 0x20)
                    continue;
                if (AT_W(SYMBOL_POOL_SEG,type+10) & 0x40)
                    temp |= 0x50;
                else {
                    switch (AT_W(SYMBOL_POOL_SEG,type+15)) {
                    case 2:
                        temp |= 0x4B;
                        break;
                    case 3:
                        temp |= 0x4A;
                        break;
                    case 4:
                        temp |= 0x49;
                        break;
                    default:
                        temp |= 0x48;
                        break;
                    }
                    if (AT_W(SYMBOL_POOL_SEG,type+21))
                        temp |= 4;
                }
                OBJ_PUT_BYTE(temp);
                if (simple)
                    OBJ_PUT_SYMBOL_NAME(type,0);
                else
                    OBJ_PUT_NAME(MANGLE_SYMBOL_NAME(type));
                OBJ_PUT_INDEX(queried);
                TYPE_MEMCHECK(0xE200);
            }
            break;
        case 2:
            OBJ_PUT_BYTE(0x60);
            OBJ_PUT_NAME(MANGLE_SYMBOL_NAME(AT_W(MEMBER_SEGMENT,member+6)));
            OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,AT_W(MEMBER_SEGMENT,member+6)+4)));
            break;
        }
    }
    size = (unsigned int)TYPE_SIZE(node);
    OBJ_PUT_BYTE(0xC0);
    OBJ_PUT_BYTE(size & 0xFF);
    OBJ_PUT_BYTE(size >> 8);
    OBJ_PUT_BYTE(0);
    OBJ_PUT_BYTE(0);
    OBJ_WRITE_RECORD(0x88);
    return saved;
}

/* ---- TSPECIAL (listing C667) ---- */
extern signed char   COMPILER_MODE;
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
/* Appends one static symbol to the pending E6h list: name (without '_' prefix), type id,
   flag byte (18h/98h for functions with prepared flag 0x20), group, segment, offset.
   Functions are skipped in assembly mode. */
static void near pascal BCC_TYPE_EMIT_SPECIAL(register unsigned int node)
{
    unsigned char flags;
    unsigned int handle;
    register unsigned int opened;
    handle=PREPARE_SYMBOL(node);
    TYPE_MEMCHECK(0xE600);
    flags=0;
    if (TYPE_W(SYM_W(node,SYM_TYPE),TYPE_KIND)==0x12) {
        if (COMPILER_MODE) goto done;
        if (CSYM_W(handle,CSYM_PREP_FLAGS)&0x20)
            flags|=TYPE_B(SYM_W(node,SYM_TYPE),TYPE_CALL_CONV)==4 ? 0x98 : 0x18;
    }
    OBJ_PUT_SYMBOL_NAME(node,1);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(SYM_W(node,SYM_TYPE)));
    OBJ_PUT_BYTE(flags);
    opened=FIND_SEGMENT(GET_SYMBOL_SEGMENT_HOOK(handle));
    OBJ_PUT_INDEX(SEGDEF_W(opened,SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(opened,SEGDEF_GROUP),SEGDEF_GROUP) : 0);
    OBJ_PUT_INDEX(SEGDEF_W(opened,SEGDEF_INDEX));
    OBJ_PUT_WORD(SYMBOL_INDEX_HOOK(handle));
done:
    ;
}

/* ---- TFLUSH (listing C744) ---- */
extern unsigned int  CODE_SEGMENT_ID;

/* COMENT E5h: a scope begins at offset value of the code segment. */
void far pascal EMIT_DEBUG_BEGIN_SCOPE(unsigned int value)
{
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE500);
    OBJ_PUT_INDEX(CODE_SEGMENT_ID);
    OBJ_PUT_WORD(value);
    OBJ_WRITE_RECORD(0x88);
}

/* ---- EMIT_DEBUG_SCOPE_SYMBOLS (listing C772) ---- */
static void near pascal EMIT_DEBUG_END_SCOPE(void);
extern unsigned int  SCOPE_POOL_SEG;
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal GET_PREPARED_FLAGS(unsigned int);
int far pascal BCC_TOKEN_FLAG(signed char);

/* Writes the symbols of C++ scope frame as an E6h list and closes the scope with E7h
   (not in assembly mode). frame 0xFFFE only closes. Skipped: externals, defined
   symbols, class 15, unused autos, bit-field aliases, non-integral constants. For "this"
   in a scope with byte 14h set, the symbol's type is replaced by a plain pointer to the
   class (MAKE_POINTER_TYPE). Parameters get storage 10/12 except "this" (2/4). */
void far pascal EMIT_DEBUG_SCOPE_SYMBOLS(register unsigned int frame)
{
    unsigned int record;
    int count;
    unsigned int flags;
    int kind;
    unsigned int type;
    register unsigned int current;

    if (frame == 0xFFFE) {
        if (!COMPILER_MODE)
            EMIT_DEBUG_END_SCOPE();
        return;
    }
    for (current = AT_W(SCOPE_POOL_SEG,frame+6); current; current = AT_W(SYMBOL_POOL_SEG,current))
        EMIT_DEBUG_TYPE(AT_W(SYMBOL_POOL_SEG,current+4),AT_W(SCOPE_POOL_SEG,frame+6));
    for (current = AT_W(SCOPE_POOL_SEG,frame+4); current; current = AT_W(SYMBOL_POOL_SEG,current)) {
        type = AT_W(SYMBOL_POOL_SEG,current+4); kind = AT_B(SYMBOL_POOL_SEG,current+7) >> 3;
        if (kind == 2 || kind == 3 || kind == 15)
            continue;
        if (kind == 5 && !(AT_B(SYMBOL_POOL_SEG,current+6) & 7))
            continue;
        if (type == 0)
            continue;
        if (CPP_MODE && AT_B(SCOPE_POOL_SEG,frame+0x14) && AT_W(SYMBOL_POOL_SEG,current+2) == THIS_NAME)
            type = AT_W(SYMBOL_POOL_SEG,current+4) = MAKE_POINTER_TYPE(AT_W(TYPE_POOL,type+7),AT_W(TYPE_POOL,type),0);
        EMIT_DEBUG_TYPE(type,AT_W(SCOPE_POOL_SEG,frame+6));
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
    count = 1;
    for (current = AT_W(SCOPE_POOL_SEG,frame+4); current; current = AT_W(SYMBOL_POOL_SEG,current)) {
        if (AT_W(SYMBOL_POOL_SEG,current+4) == 0 || (AT_B(SYMBOL_POOL_SEG,current+6) & 0x20))
            continue;
        kind = AT_B(SYMBOL_POOL_SEG,current+7) >> 3;
        if (kind == 2 || kind == 3 || kind == 15)
            continue;
        if (kind == 5 && !(AT_B(SYMBOL_POOL_SEG,current+6) & 7))
            continue;
        if (kind == 14 && (AT_B(MEMBER_SEGMENT,AT_W(SYMBOL_POOL_SEG,current+8)+4) & 0x40))
            continue;
        if (kind == 9 && !(EXPR_FLAGS[AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,current+4))] & 1))
            continue;
        if (OBJ_RECORD_LENGTH() > 4000)
            count = 1;
        TYPE_MEMCHECK(0xE600);
        ++count;
        OBJ_PUT_NAME(AT_W(SYMBOL_POOL_SEG,current+2)
                    ? STRING_COPY((char far *)BCC_DEBUG_NAME,
                          (char far *)MK_FP(*(unsigned int near *)AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,current+2)+4),
                                            AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,current+2)+2)))
                    : (char far *)BCC_DEBUG_EMPTY);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,current+4)));
        switch (AT_B(SYMBOL_POOL_SEG,current+7) >> 3) {
        case 4:
            OBJ_PUT_BYTE(0);
            type = PREPARE_SYMBOL(current);
            record = FIND_SEGMENT(GET_SYMBOL_SEGMENT_HOOK(type));
            OBJ_PUT_INDEX(AT_W(SEGDEF_POOL_SEG,record+2) ? AT_W(SEGDEF_POOL_SEG,AT_W(SEGDEF_POOL_SEG,record+2)+2) : 0);
            OBJ_PUT_INDEX(AT_W(SEGDEF_POOL_SEG,record+4));
            OBJ_PUT_WORD(SYMBOL_INDEX_HOOK(type));
            break;
        case 9:
            OBJ_PUT_BYTE(5);
            OBJ_PUT_WORD(AT_L(SYMBOL_POOL_SEG,current+8) & 0xFFFFL);
            OBJ_PUT_WORD((AT_L(SYMBOL_POOL_SEG,current+8) >> 16) & 0xFFFFL);
            break;
        case 5:
        case 14:
            type = PREPARE_SYMBOL(current);
            if (GET_PREPARED_FLAGS(type) & 8) {
                OBJ_PUT_BYTE(4); OBJ_PUT_BYTE(BCC_TOKEN_FLAG(GET_SYMBOL_SEGMENT_HOOK(type)));
            } else {
                OBJ_PUT_BYTE(2); OBJ_PUT_WORD(SYMBOL_INDEX_HOOK(type));
            }
            break;
        case 6:
            type = PREPARE_SYMBOL(current);
            flags = 0;
            if (!CPP_MODE || AT_W(SYMBOL_POOL_SEG,current+2) != THIS_NAME)
                flags = 8;
            if (GET_PREPARED_FLAGS(type) & 8) {
                OBJ_PUT_BYTE((unsigned char)flags | 4); OBJ_PUT_BYTE(BCC_TOKEN_FLAG(GET_SYMBOL_SEGMENT_HOOK(type)));
            } else {
                OBJ_PUT_BYTE((unsigned char)flags | 2); OBJ_PUT_WORD(SYMBOL_INDEX_HOOK(type));
            }
            break;
        case 8:
            OBJ_PUT_BYTE(6);
            break;
        case 11:
            OBJ_PUT_BYTE(7);
            break;
        }
    }
    if (count > 1)
        OBJ_WRITE_RECORD(0x88);
    if (!COMPILER_MODE)
        EMIT_DEBUG_END_SCOPE();
}

/* ---- TCOUNT (listing CB2E) ---- */
extern unsigned int far pascal FIND_NAME_IN_LIST(unsigned int,unsigned int);
/* Appends the parameters from formal list node to the E6h list, in declaration order
   (the recursion goes to the end of the list first), and returns count plus their
   number. A float parameter without prototype gets type id 15 (probably double); "this"
   gets storage 2, others 10; the frame offset comes from the parameter's symbol in the
   function's scope (BCC_TREE_LINK). */
static int near pascal EMIT_DEBUG_PARAM_LIST(register unsigned int node,register int count)
{
    unsigned int handle;
    if (!node) return count;
    count=EMIT_DEBUG_PARAM_LIST(FORMAL_W(node,FORMAL_NEXT),count);
    OBJ_PUT_NAME(FORMAL_W(node,FORMAL_NAME) ?
        STRING_COPY(BCC_DEBUG_NAME,
            (char far *)MK_FP(*(unsigned int near *)NAME_W(FORMAL_W(node,FORMAL_NAME),NAME_TEXT_BANK),
                             NAME_W(FORMAL_W(node,FORMAL_NAME),NAME_TEXT_OFFSET))) :
        (char far *)BCC_DEBUG_EMPTY);
    if (TYPE_W(FORMAL_W(node,FORMAL_TYPE),TYPE_KIND)==9 &&
        (TYPE_B(FORMAL_W(node,FORMAL_TYPE),TYPE_FUNC_FLAGS)&8))
        OBJ_PUT_BYTE(15);
    else OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(FORMAL_W(node,FORMAL_TYPE)));
    OBJ_PUT_BYTE(CPP_MODE && FORMAL_W(node,FORMAL_NAME)==THIS_NAME ? 2 : 10);
    handle=FIND_NAME_IN_LIST(FORMAL_W(node,FORMAL_NAME),SCOPE_W(BCC_TREE_LINK,SCOPE_NAMES));
    OBJ_PUT_WORD(SYMBOL_INDEX_HOOK(PREPARE_SYMBOL(handle)));
    return count+1;
}

/* ---- TEFIN (listing CC31) ---- */

extern unsigned int  BCC_TREE_SPECIAL;
/* Debug information for the parameters of the function being compiled: an F8h record
   with the function's name when it is a member of a class (CURRENT_CLASS_TYPE), the
   parameter types, then their E6h list. */
void far pascal EMIT_DEBUG_TREE_LOCALS(void)
{
    register unsigned int sym;

    if (CURRENT_CLASS_TYPE != 0) {
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xF800);
        OBJ_PUT_SYMBOL_NAME(BCC_TREE_SPECIAL, 0);
        OBJ_WRITE_RECORD(0x88);
    }
    for (sym = *(unsigned int far *)MK_FP(TYPE_POOL, CURRENT_FUNCTION_TYPE + TYPE_PARAMS); sym != 0;
         sym = *(unsigned int far *)MK_FP(FORMAL_POOL_SEG, sym))
        EMIT_DEBUG_TYPE(*(unsigned int far *)MK_FP(FORMAL_POOL_SEG, sym + FORMAL_TYPE), 0);
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
    sym = *(unsigned int far *)MK_FP(TYPE_POOL, CURRENT_FUNCTION_TYPE + TYPE_PARAMS);
    if (sym != 0 && EMIT_DEBUG_PARAM_LIST(sym, 1) > 1)
        OBJ_WRITE_RECORD(0x88);
}
/* ---- EMIT_DEBUG_END_SCOPE (listing CCBC) ---- */

/* COMENT E7h with the selected segment's current size: the scope ends here. */
static void near pascal EMIT_DEBUG_END_SCOPE(void)
{
    unsigned int value;

    value = *(unsigned int far *)MK_FP(SEGDEF_POOL_SEG,SELECTED_SEGDEF_ENTRY+SEGDEF_SIZE);
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE700);
    OBJ_PUT_WORD(value);
    OBJ_WRITE_RECORD(0x88);
}

/* ---- EMIT_DEBUG_GLOBALS (listing CCF4) ---- */
#define TAG(n) (AT_B(SYMBOL_POOL_SEG,(n)+7)>>3)
#define LINK(t,n) AT_W(TAG_BODY_POOL_SEG,AT_W(TYPE_POOL,(t)+5)+(n))

/* Module-level debug records without EXTDEF/PUBDEF, probably for assembly output (TASM
   writes those): class types, EBh for used externals, ECh for publics and for defined
   symbols with prepared flag 0x100, member-function types and E6h entries of statics,
   ECh records for defined static member functions, then typedefs and tags. */
void far pascal EMIT_DEBUG_GLOBALS(void)
{
    int opened;
    int bucket;
    unsigned int chain;
    unsigned int member;
    unsigned int nested;
    unsigned int type;
    register unsigned int item;
    register unsigned int root;

    if (CPP_MODE) {
        for (bucket = 0; bucket < 0x400; ++bucket) {
            for (chain = NAME_HASH_TABLE[bucket]; chain; chain = AT_W(HASH_CHAIN_LINK_SEG,chain)) {
                for (root = AT_W(NAME_POOL_SEG,chain); root; root = AT_W(SYMBOL_POOL_SEG,root)) {
                    item = root;
                    do {
                        if (TAG(item) == 11 && GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,item+4)))
                            EMIT_DEBUG_TYPE(AT_W(SYMBOL_POOL_SEG,item+4),GLOBAL_SCOPE_TAGS);
                    } while (CPP_MODE && TAG(item) != 8 && AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4)) == 0x12 &&
                             (item = AT_W(SYMBOL_POOL_SEG,item+19)) != 0);
                }
            }
        }
    }
    for (bucket = 0; bucket < 0x400; ++bucket) {
        for (chain = NAME_HASH_TABLE[bucket]; chain; chain = AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for (root = AT_W(NAME_POOL_SEG,chain); root; root = AT_W(SYMBOL_POOL_SEG,root)) {
                item = root;
                do {
                    switch (TAG(item)) {
                    case 2:
                        if (AT_B(SYMBOL_POOL_SEG,item+6) & 4) {
                            EMIT_DEBUG_TYPE(AT_W(SYMBOL_POOL_SEG,item+4),GLOBAL_SCOPE_TAGS);
                            OBJ_RESET_RECORD();
                            OBJ_PUT_WORD(0xEB00);
                            OBJ_PUT_SYMBOL_NAME(item,0);
                            OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,item+4)));
                            OBJ_WRITE_RECORD(0x88);
                        }
                        break;
                        /* A defined symbol without prepared flag 0x100 gets only its
                           type; with the flag it falls into case 1 and gets an ECh
                           record. */
                    case 3:
                        if (AT_W(SYMBOL_POOL_SEG,item+8) == 0 || (GET_PREPARED_FLAGS(PREPARE_SYMBOL(item)) & 0x100) == 0) {
                            EMIT_DEBUG_TYPE(AT_W(SYMBOL_POOL_SEG,item+4),GLOBAL_SCOPE_TAGS);
                            break;
                        }
                    case 1:
                        EMIT_DEBUG_TYPE(AT_W(SYMBOL_POOL_SEG,item+4),GLOBAL_SCOPE_TAGS);
                        OBJ_RESET_RECORD();
                        OBJ_PUT_WORD(0xEC00);
                        OBJ_PUT_SYMBOL_NAME(item,0);
                        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,item+4)));
                        OBJ_PUT_BYTE((AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4)) == 0x12 && (GET_PREPARED_FLAGS(PREPARE_SYMBOL(item)) & 0x20))
                                    ? (AT_B(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4)+11) == 4 ? 0x98 : 0x18)
                                    : 0);
                        OBJ_WRITE_RECORD(0x88);
                        break;
                    }
                } while (CPP_MODE && TAG(item) != 8 && AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4)) == 0x12 &&
                         (item = AT_W(SYMBOL_POOL_SEG,item+19)) != 0);
            }
        }
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
    opened = 0;
    for (bucket = 0; bucket < 0x400; ++bucket) {
        for (chain = NAME_HASH_TABLE[bucket]; chain; chain = AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for (root = AT_W(NAME_POOL_SEG,chain); root; root = AT_W(SYMBOL_POOL_SEG,root)) {
                item = root;
                do {
                    if (TAG(item) == 3) {
                        if (AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4)) == 0x12 && (AT_B(SYMBOL_POOL_SEG,item+12) & 3) == 1) {
                            if (AT_W(SYMBOL_POOL_SEG,item+10) & 2) {
                                if (opened) {
                                    OBJ_WRITE_RECORD(0x88);
                                    opened = 0;
                                }
                                EMIT_DEBUG_METHOD_TYPE(item,GLOBAL_SCOPE_TAGS);
                                OBJ_RESET_RECORD();
                                OBJ_PUT_WORD(0xE600);
                            }
                        } else if (item != STRING_LITERAL_SYMBOL && (AT_B(SYMBOL_POOL_SEG,item+6) & 2)) {
                            BCC_TYPE_EMIT_SPECIAL(item);
                            opened = 1;
                        }
                    } else if (CPP_MODE && (EXPR_FLAGS[AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4))] & 0x40) &&
                               (LINK(AT_W(SYMBOL_POOL_SEG,item+4),24) & 1)) {
                        for (member = LINK(AT_W(SYMBOL_POOL_SEG,item+4),2); member; member = AT_W(MEMBER_SEGMENT,member)) {
                            if ((AT_B(MEMBER_SEGMENT,member+4) & 3) != 3)
                                continue;
                            for (nested = AT_W(MEMBER_SEGMENT,member+6); nested; nested = AT_W(SYMBOL_POOL_SEG,nested+19)) {
                                if (!(AT_B(SYMBOL_POOL_SEG,nested+6) & 0x20)) {
                                    if ((AT_B(SYMBOL_POOL_SEG,nested+12) & 3) == 1 && (AT_W(SYMBOL_POOL_SEG,nested+10) & 2)) {
                                        if (opened) {
                                            OBJ_WRITE_RECORD(0x88);
                                            opened = 0;
                                        }
                                        EMIT_DEBUG_METHOD_TYPE(nested,GLOBAL_SCOPE_TAGS);
                                        OBJ_RESET_RECORD();
                                        OBJ_PUT_WORD(0xE600);
                                    } else if ((AT_B(SYMBOL_POOL_SEG,nested+12) & 3) == 0 && (AT_B(SYMBOL_POOL_SEG,nested+6) & 2)) {
                                        type = AT_W(SYMBOL_POOL_SEG,nested+4);
                                        if (opened) {
                                            OBJ_WRITE_RECORD(0x88);
                                            opened = 0;
                                        }
                                        EMIT_DEBUG_TYPE(type,GLOBAL_SCOPE_TAGS);
                                        OBJ_RESET_RECORD();
                                        OBJ_PUT_WORD(0xEC00);
                                        OBJ_PUT_SYMBOL_NAME(nested,0);
                                        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(type));
                                        OBJ_PUT_BYTE((GET_PREPARED_FLAGS(PREPARE_SYMBOL(nested)) & 0x20)
                                                    ? (AT_B(TYPE_POOL,type+11) == 4 ? 0x98 : 0x18)
                                                    : 0);
                                        OBJ_WRITE_RECORD(0x88);
                                    }
                                }
                            }
                        }
                    }
                } while (CPP_MODE && TAG(item) != 8 && AT_W(TYPE_POOL,AT_W(SYMBOL_POOL_SEG,item+4)) == 0x12 &&
                         (item = AT_W(SYMBOL_POOL_SEG,item+19)) != 0);
            }
        }
    }
    for (bucket = 0; bucket < 0x400; ++bucket) {
        for (chain = NAME_HASH_TABLE[bucket]; chain; chain = AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for (item = AT_W(NAME_POOL_SEG,chain); item; item = AT_W(SYMBOL_POOL_SEG,item)) {
                member = GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,item+4));
                if (TAG(item) == 8 && AT_W(SYMBOL_POOL_SEG,item+2) && member) {
                    TYPE_MEMCHECK(0xE600);
                    opened = 1;
                    OBJ_PUT_NAME(STRING_COPY((char far *)BCC_DEBUG_NAME,
                        (char far *)MK_FP(*(unsigned int near *)AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,item+2)+4),
                                          AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,item+2)+2))));
                    OBJ_PUT_INDEX(member);
                    OBJ_PUT_BYTE(6);
                }
            }
        }
    }
    for (bucket = 0; bucket < 0x400; ++bucket) {
        for (chain = NAME_HASH_TABLE[bucket]; chain; chain = AT_W(HASH_CHAIN_LINK_SEG,chain)) {
            for (item = AT_W(NAME_POOL_SEG,chain); item; item = AT_W(SYMBOL_POOL_SEG,item)) {
                member = GET_TYPE_DEBUG_ID(AT_W(SYMBOL_POOL_SEG,item+4));
                if (TAG(item) == 11 && AT_W(SYMBOL_POOL_SEG,item+4) && member && AT_W(SYMBOL_POOL_SEG,item+2)) {
                    TYPE_MEMCHECK(0xE600);
                    opened = 1;
                    OBJ_PUT_NAME(STRING_COPY((char far *)BCC_DEBUG_NAME,
                        (char far *)MK_FP(*(unsigned int near *)AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,item+2)+4),
                                          AT_W(NAME_POOL_SEG,AT_W(SYMBOL_POOL_SEG,item+2)+2))));
                    OBJ_PUT_INDEX(member);
                    OBJ_PUT_BYTE(7);
                }
            }
        }
    }
    if (opened)
        OBJ_WRITE_RECORD(0x88);
}
#undef TAG
#undef LINK
