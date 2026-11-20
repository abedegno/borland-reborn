/* target: ovr137_C100UNIT */
/* Role: object output: OMF symbol records and Turbo Debugger comment records. Entry points:
   EMIT_OBJ_SYMBOLS, WRITE_LINKER_NAME, BCC_DEBUG_VALUE_MARK, EMIT_SCOPE_DEBUG_INFO,
   EMIT_LOCALS_DEBUG_INFO, EMIT_GLOBALS_DEBUG_INFO. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO050 (ovr_1d2b_9c35) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: symbol and Turbo Debugger records of the object file for C compiles; the
   C front end's twin of OBJPUBS.C and DEBUGREC.C. It reads the C symbol records
   (CSYM_POOL_SEG, the C global scope's list SCOPE_C_SYMBOLS) and C-layout types; note
   that the code reads the C layout's offset 3 (pointee, or array count as a long)
   through the C++ field name TYPE_MEMBER_CLASS.
   - EMIT_OBJ_SYMBOLS (end of module): EXTDEF/COMDEF records for used externals, the
     extra "__turboFloat" external when floating point was used, PUBDEF for publics,
     LPUBDEF for far static functions (overlay or Windows code), export COMENTs, and with
     -v the debug records of all module-level symbols.
   - EMIT_SCOPE_DEBUG_INFO, EMIT_LOCALS_DEBUG_INFO, BCC_DEBUG_VALUE_MARK and
     EMIT_GLOBALS_DEBUG_INFO write -v records as code is generated, through the hook
     table.
   Turbo Debugger information travels in COMENT (88h) records whose class byte follows
   a 0 attribute byte: E0h type of an external, E1h type of a public, E2h struct
   members, E3h a type definition, E4h enum members, E5h a scope start, E6h a list of
   symbols, E7h end of a scope, EBh an external with type, ECh a public with type.
   Every type written gets a debug index (TYPE_C_DEBUG_INDEX) from DEBUG_TYPE_COUNTER.
   In an E6h list each symbol is: name, type index, a storage byte (0 static: group,
   segment, offset follow; 2 auto: frame offset; 4 register: register code; 6 typedef;
   7 tag; 10 parameter: frame offset; 12 register parameter), and lists are cut every 63
   entries. C symbol classes (CSYM_CLASS) used: 1 public, 2 external, 3 static, 4 static
   local, 5 auto, 6 parameter, 8 typedef, 9 enum constant, 11 tag. CSYM_FLAGS: 0x80 used,
   0x800 communal, 0x1000 in a register, 0x400 pascal name, 0x2000 '@' name, 0x100
   address taken, 0x20 for the function flag byte. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"



/* ---- STOVR123 (listing ovr_1d2b_9c35:C350) ---- */
static void near pascal EMIT_TYPE_DEBUG_INFO(register unsigned int node);
static void near pascal EMIT_DEBUG_SYMBOL_ENTRY(register unsigned int node);
void far pascal WRITE_LINKER_NAME(unsigned int node);
static void near pascal WRITE_DEBUG_NAME(register unsigned int node);
extern unsigned int SCOPE_POOL_SEG;
extern unsigned char OPTION_SOURCE_DEBUG;
extern signed char OPTION_OVERLAY_CODE,OPTION_WINDOWS_MODE;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern void far pascal OBJ_PUT_NAME(char far *);
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
extern void far pascal OBJ_PUT_INDEX(unsigned int);
extern void far pascal OBJ_PUT_WORD(unsigned int);
#define KIND(n) FAR_B(CSYM_POOL_SEG,n,CSYM_CLASS)
#define TYPE(n) CSYM_W(n,CSYM_TYPE)
/* End-of-module symbol records for a C compile (see the overview). offset is added to
   the offset of symbols without a segment, which are placed in the data segment
   (probably after its initialized data). External indexes count from 1 in list order
   and are stored in CSYM_OFFSET. COMDEF entries: name, type 0, 61h far (element count,
   element size) or 62h near (size), lengths as one byte, 81h + word or 88h + dword. */
void far pascal EMIT_OBJ_SYMBOLS(unsigned int offset)
{
    unsigned int handle;
    unsigned long extent;
    unsigned int head,count,value,previous,format,type;
    register unsigned int record,item;
    head=SCOPE_W(C_GLOBAL_SCOPE,SCOPE_C_SYMBOLS);
    OBJ_RESET_RECORD();
    previous=0;
    count=1;
    for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
        if(KIND(record)==2 && (CSYM_W(record,CSYM_FLAGS)&0x80)) {
            CSYM_W(record,CSYM_OFFSET)=count++;
            if(CSYM_W(record,CSYM_FLAGS)&0x800) format=0xB0; else format=0x8C;
            if(previous && previous!=format) {
                OBJ_WRITE_RECORD((unsigned char)previous);
                OBJ_RESET_RECORD();
            }
            previous=format;
            WRITE_LINKER_NAME(record);
            OBJ_PUT_BYTE(0);
            if(CSYM_W(record,CSYM_FLAGS)&0x800) {
                item=TYPE(record);
                if(CSYM_W(record,CSYM_SEGMENT)!=BSS_SEGMENT_ID) {
                    OBJ_PUT_BYTE(0x61);
                    extent=1UL;
                    while(TYPE_B(item,TYPE_KIND)==17) {
                        extent*=*(unsigned long far *)MK_FP(TYPE_POOL,item+TYPE_C_SIZE);
                        item=TYPE_W(item,TYPE_TARGET);
                    }
                    if(extent<=127UL) OBJ_PUT_BYTE((unsigned char)extent);
                    else if(extent<=32767UL) {
                        OBJ_PUT_BYTE(0x81);
                        OBJ_PUT_WORD((unsigned int)extent);
                    } else {
                        OBJ_PUT_BYTE(0x88);
                        OBJ_PUT_WORD((unsigned int)extent);
                        OBJ_PUT_WORD((unsigned int)(extent>>16));
                    }
                } else OBJ_PUT_BYTE(0x62);
                value=SIZE_OF_TYPE_CHECKED_HOOK(item);
                if(value<=127) OBJ_PUT_BYTE((unsigned char)value);
                else {OBJ_PUT_BYTE(0x81);OBJ_PUT_WORD(value);}
            }
            if(OPTION_SOURCE_DEBUG) {
                OBJ_WRITE_RECORD((unsigned char)format);
                EMIT_TYPE_DEBUG_INFO(TYPE(record));
                OBJ_RESET_RECORD();
                OBJ_PUT_WORD(0xE000);
                OBJ_PUT_INDEX(TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX));
                OBJ_WRITE_RECORD(0x88);
                OBJ_RESET_RECORD();
            } else if(!(count&127)) {
                OBJ_WRITE_RECORD((unsigned char)format);
                OBJ_RESET_RECORD();
            }
        }
    }
    /* Floating point used: add an EXTDEF for "__turboFloat" (DS:387C), probably to pull
       in the floating-point support from the library. */
    if(CODE_OUTPUT_FLAGS&2) {
        if(previous==0xB0) {OBJ_WRITE_RECORD((unsigned char)format);OBJ_RESET_RECORD();}
        OBJ_PUT_NAME((char near *)(STR_TURBOFLOAT_2));
        OBJ_PUT_BYTE(0);
        OBJ_WRITE_RECORD(0x8C);
    } else if(previous) OBJ_WRITE_RECORD((unsigned char)previous);
    for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
        if(KIND(record)==1) {
            OBJ_RESET_RECORD();
            value=CSYM_W(record,CSYM_SEGMENT);
            if(!value) {
                value=DATA_SEGMENT_ID;
                CSYM_W(record,CSYM_SEGMENT)=value;
                CSYM_W(record,CSYM_OFFSET)+=offset;
            }
            handle=FIND_SEGMENT(value);
            if(SEGDEF_W(handle,SEGDEF_GROUP)) count=SEGDEF_W(SEGDEF_W(handle,SEGDEF_GROUP),SEGDEF_GROUP); else count=0;
            OBJ_PUT_BYTE((unsigned char)count);
            OBJ_PUT_BYTE((unsigned char)value);
            WRITE_LINKER_NAME(record);
            OBJ_PUT_WORD(CSYM_W(record,CSYM_OFFSET));
            OBJ_PUT_BYTE(0);
            OBJ_WRITE_RECORD(0x90);
            if(OPTION_SOURCE_DEBUG) {
                type=TYPE(record);
                EMIT_TYPE_DEBUG_INFO(type);
                OBJ_RESET_RECORD();
                OBJ_PUT_WORD(0xE100);
                OBJ_PUT_INDEX(TYPE_W(type,TYPE_C_DEBUG_INDEX));
                OBJ_PUT_BYTE((TYPE_B(type,TYPE_KIND)==18 && (CSYM_W(record,CSYM_FLAGS)&0x20))?
                    (TYPE_B(type,TYPE_C_CALL_CONV)==4?0x98:0x18):0);
                OBJ_WRITE_RECORD(0x88);
            }
            if(TYPE_B(TYPE(record),TYPE_KIND)==18 && (TYPE_B(TYPE(record),TYPE_C_FUNC_FLAGS)&0x80)) {
                OBJ_RESET_RECORD();
                OBJ_PUT_WORD(0xA000);
                OBJ_PUT_WORD(2);
                WRITE_LINKER_NAME(record);
                OBJ_PUT_BYTE(0);
                OBJ_WRITE_RECORD(0x88);
                record=record;
            }
        } else if(KIND(record)==3) {
            if(!CSYM_W(record,CSYM_SEGMENT)) {CSYM_W(record,CSYM_SEGMENT)=DATA_SEGMENT_ID;CSYM_W(record,CSYM_OFFSET)+=offset;}
            if(OPTION_OVERLAY_CODE|OPTION_WINDOWS_MODE) {
                if(TYPE_B(TYPE(record),TYPE_KIND)==18 && (TYPE_B(TYPE(record),TYPE_C_FUNC_FLAGS)&1) && (CSYM_W(record,CSYM_FLAGS)&0x100)) {
                    OBJ_RESET_RECORD();
                    value=CSYM_W(record,CSYM_SEGMENT);
                    handle=FIND_SEGMENT(value);
                    if(SEGDEF_W(handle,SEGDEF_GROUP)) count=SEGDEF_W(SEGDEF_W(handle,SEGDEF_GROUP),SEGDEF_GROUP); else count=0;
                    OBJ_PUT_BYTE((unsigned char)count);
                    OBJ_PUT_BYTE((unsigned char)value);
                    WRITE_LINKER_NAME(record);
                    OBJ_PUT_WORD(CSYM_W(record,CSYM_OFFSET));
                    OBJ_PUT_BYTE(0);
                    OBJ_WRITE_RECORD(0xB6);
                }
            }
        }
    }
    /* -v: types of all statics, then E6h lists of statics, typedefs (storage 6) and
       tags (storage 7). */
    if(OPTION_SOURCE_DEBUG) {
        for(record=head;record;record=CSYM_W(record,CSYM_NEXT))
            if(KIND(record)==3) EMIT_TYPE_DEBUG_INFO(TYPE(record));
        OBJ_RESET_RECORD(); OBJ_PUT_WORD(0xE600);
        count=1;
        for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
            if(KIND(record)==3) {
                if(!(count&63)) {OBJ_WRITE_RECORD(0x88);OBJ_RESET_RECORD();OBJ_PUT_WORD(0xE600);count=1;}
                EMIT_DEBUG_SYMBOL_ENTRY(record);
                ++count;
            }
        }
        for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
            if(KIND(record)==8 && TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX)) {
                if(!(count&63)) {OBJ_WRITE_RECORD(0x88);OBJ_RESET_RECORD();OBJ_PUT_WORD(0xE600);count=1;}
                ++count;
                WRITE_DEBUG_NAME(CSYM_W(record,CSYM_NAME));
                OBJ_PUT_INDEX(TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX));
                OBJ_PUT_BYTE(6);
            }
        }
        for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
            if(KIND(record)==11 && TYPE(record) && TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX) && CSYM_W(record,CSYM_NAME)) {
                if(!(count&63)) {OBJ_WRITE_RECORD(0x88);OBJ_RESET_RECORD();OBJ_PUT_WORD(0xE600);count=1;}
                WRITE_DEBUG_NAME(CSYM_W(record,CSYM_NAME));
                OBJ_PUT_INDEX(TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX));
                OBJ_PUT_BYTE(7);
                ++count;
            }
        }
        if(count>1) OBJ_WRITE_RECORD(0x88);
    }
}
#undef KIND
#undef TYPE

/* ---- STOVR124 (listing ovr_1d2b_9c35:C952) ---- */
static void near pascal EMIT_ENUM_DEBUG_INFO(unsigned int node);
static void near pascal EMIT_STRUCT_DEBUG_INFO(unsigned int node,unsigned int kind);
extern unsigned int NAME_POOL_SEG;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void far pascal OBJ_PUT_NAME(char far *);
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
extern void far pascal OBJ_PUT_INDEX(unsigned int);
extern void far pascal OBJ_PUT_WORD(unsigned int);
#define K(n) TYPE_B(n,TYPE_KIND)
#define NODE_NAME(n) ((char far *)MK_FP(*(unsigned int near *)FAR_W(NAME_POOL_SEG,FAR_W(CSYM_POOL_SEG,FAR_W(TYPE_POOL,n,TYPE_C_TAG_SYMBOL),CSYM_NAME),NAME_TEXT_BANK),FAR_W(NAME_POOL_SEG,FAR_W(CSYM_POOL_SEG,FAR_W(TYPE_POOL,n,TYPE_C_TAG_SYMBOL),CSYM_NAME),NAME_TEXT_OFFSET)))
/* Writes the debug record (COMENT E3h) of C type node once, giving it the next debug
   index; types it refers to are written first (recursively). Record: index, name (the
   tag name or ""), size, then a type code: 22h enum (range 8000h..7FFFh, with its
   member list in E4h), 1Eh struct or 1Fh union (members in E2h; kind 30 is the value for
   a struct), 1Ah array, 15h near pointer (30h for a based pointer, with the base name),
   17h segment pointer, 16h far (flag 0) or huge (flag 1) pointer, 23h function (calling
   convention, far bit, varargs). A struct or union without a body gets index 1. Other
   kinds (scalars, which normally carry a fixed index already, see SET_TYPE_DEBUG_ID in
   INITTYPE.C) give the counter back and write nothing. */
static void near pascal EMIT_TYPE_DEBUG_INFO(register unsigned int node)
{
    int kind,bits;
    char far *name;
    if(TYPE_W(node,TYPE_C_DEBUG_INDEX)) return;
    name=(char near *)(STR_TURBOFLOAT_2+12);
    TYPE_W(node,TYPE_C_DEBUG_INDEX)=DEBUG_TYPE_COUNTER++;
    switch(K(node)) {
    case 21:
        EMIT_ENUM_DEBUG_INFO(node);
        if(TYPE_W(node,TYPE_C_TAG_SYMBOL)) name=NODE_NAME(node);
        break;
    case 19:case 20:
        if(!TYPE_W(node,TYPE_TAG_BODY)) {
            TYPE_W(node,TYPE_C_DEBUG_INDEX)=1;
            --DEBUG_TYPE_COUNTER;
            return;
        }
        kind=TYPE_B(node,TYPE_C_BYTE9)==1 ? 30 : 31;
        EMIT_STRUCT_DEBUG_INFO(node,kind);
        if(TYPE_W(node,TYPE_C_TAG_SYMBOL)) name=NODE_NAME(node);
        break;
    case 17:
        EMIT_TYPE_DEBUG_INFO(TYPE_W(node,TYPE_TARGET));
        break;
    case 13:
        if(TYPE_W(node,TYPE_TAG_BODY)) ++DEBUG_TYPE_COUNTER;
    case 14:case 15:case 16:case 18:
        EMIT_TYPE_DEBUG_INFO(TYPE_W(node,TYPE_C_TARGET));
        break;
    default:
        --DEBUG_TYPE_COUNTER;
        return;
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xe300);
    OBJ_PUT_INDEX(TYPE_W(node,TYPE_C_DEBUG_INDEX));
    OBJ_PUT_NAME(name);
    OBJ_PUT_WORD(SIZE_OF_TYPE_CHECKED_HOOK(node));
    switch(K(node)) {
    case 21:
        OBJ_PUT_BYTE(0x22);OBJ_PUT_BYTE(0);OBJ_PUT_WORD(0x8000);OBJ_PUT_WORD(0x7fff);
        ++DEBUG_TYPE_COUNTER;
        break;
    case 19:case 20:
        OBJ_PUT_BYTE(kind);
        break;
    case 17:
        OBJ_PUT_BYTE(0x1a);
        OBJ_PUT_INDEX(TYPE_W(TYPE_W(node,TYPE_TARGET),TYPE_C_DEBUG_INDEX));
        break;
    case 13:
        OBJ_PUT_BYTE(TYPE_W(node,TYPE_TAG_BODY) ? 0x30 : 0x15);
        OBJ_PUT_INDEX(TYPE_W(TYPE_W(node,TYPE_C_TARGET),TYPE_C_DEBUG_INDEX));
        if(TYPE_W(node,TYPE_TAG_BODY)) {
            STRING_COPY(BCC_DEBUG_NAME,MK_FP(POOL_HASH,TYPE_W(node,TYPE_TAG_BODY)));
            OBJ_PUT_NAME(BCC_DEBUG_NAME);
        } else {
            OBJ_PUT_BYTE(TYPE_B(node,TYPE_C_FUNC_FLAGS));
            node=node;
        }
        break;
    case 14:
        OBJ_PUT_BYTE(0x17);
        OBJ_PUT_INDEX(TYPE_W(TYPE_W(node,TYPE_C_TARGET),TYPE_C_DEBUG_INDEX));
        OBJ_PUT_BYTE(0);
        break;
    case 15:
        OBJ_PUT_BYTE(0x16);
        OBJ_PUT_INDEX(TYPE_W(TYPE_W(node,TYPE_C_TARGET),TYPE_C_DEBUG_INDEX));
        OBJ_PUT_BYTE(0);
        break;
    case 16:
        OBJ_PUT_BYTE(0x16);
        OBJ_PUT_INDEX(TYPE_W(TYPE_W(node,TYPE_C_TARGET),TYPE_C_DEBUG_INDEX));
        OBJ_PUT_BYTE(1);
        break;
    case 18:
        bits=((signed char)TYPE_B(node,TYPE_C_CALL_CONV)-1)&3;
        if(TYPE_B(node,TYPE_C_FUNC_FLAGS)&1) bits|=4;
        OBJ_PUT_BYTE(0x23);
        OBJ_PUT_INDEX(TYPE_W(TYPE_W(node,TYPE_C_TARGET),TYPE_C_DEBUG_INDEX));
        OBJ_PUT_BYTE(bits);
        OBJ_PUT_BYTE(TYPE_B(node,TYPE_C_FUNC_FLAGS)&4 ? 1 : 0);
        break;
    }
    OBJ_WRITE_RECORD(0x88);
}
#undef K
#undef NODE_NAME

/* ---- STOVR126 (listing ovr_1d2b_9c35:CC67) ---- */
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_WORD(unsigned int);
extern int far pascal OBJ_RECORD_LENGTH(void);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
/* COMENT E4h list of enum members: a flag byte (80h on the last), name, value (the
   member's MEMB_FLAGS word holds the value in the C layout). Records are cut at about
   210 bytes. */
static void near pascal EMIT_ENUM_DEBUG_INFO(unsigned int node)
{
    register unsigned int item;
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE400);
    _BX=node;
    item=TYPE_W(_BX,TYPE_TAG_BODY);
    while(item) {
        if(OBJ_RECORD_LENGTH()>210) {
            OBJ_WRITE_RECORD(0x88);
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xE400);
        }
        OBJ_PUT_BYTE(MEMBER_W(item,MEMB_NEXT) ? 0 : 0x80);
        WRITE_DEBUG_NAME(MEMBER_W(item,MEMB_NAME));
        OBJ_PUT_WORD(MEMBER_W(item,MEMB_FLAGS));
        item=MEMBER_W(item,MEMB_NEXT);
    }
    OBJ_WRITE_RECORD(0x88);
}

/* ---- STOVR127 (listing ovr_1d2b_9c35:CCEE) ---- */
extern signed char BCC_PACK_FLAG;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_WORD(unsigned int);
extern int far pascal OBJ_RECORD_LENGTH(void);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
extern void far pascal OBJ_PUT_INDEX(unsigned int);
/* COMENT E2h list of struct or union members: types first, then per member a byte (bit
   width for a bit field, 80h added on the last member), name and type index. For a
   struct, gaps before a member's offset are written as a padding entry (gap in bits and
   two zero bytes). Bit fields advance the position by bytes, or by words when
   BCC_PACK_FLAG is set. Records are cut at about 214 bytes. */
static void near pascal EMIT_STRUCT_DEBUG_INFO(unsigned int node,unsigned int kind)
{
    int delta,bits;
    register unsigned int item;
    register unsigned int position=0;
    bits=0;
    item=TYPE_W(node,TYPE_TAG_BODY);
    while(item) {
        EMIT_TYPE_DEBUG_INFO(MEMBER_W(item,MEMB_C_TYPE));
        item=MEMBER_W(item,MEMB_NEXT);
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE200);
    item=TYPE_W(node,TYPE_TAG_BODY);
    while(item) {
        if(kind==30 && MEMBER_W(item,MEMB_FLAGS)!=position) {
            delta=MEMBER_W(item,MEMB_FLAGS)-position;
            OBJ_PUT_BYTE((unsigned char)delta*8-(unsigned char)bits);
            OBJ_PUT_BYTE(0);
            OBJ_PUT_BYTE(0);
            position=MEMBER_W(item,MEMB_FLAGS);
            bits=0;
        }
        if(OBJ_RECORD_LENGTH()>214) {
            OBJ_WRITE_RECORD(0x88);
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xE200);
        }
        if(MEMBER_B(item,MEMB_C_BIT_WIDTH)==0) {
            OBJ_PUT_BYTE(MEMBER_W(item,MEMB_NEXT) ? 0 : 0x80);
            position+=SIZE_OF_TYPE_CHECKED_HOOK(MEMBER_W(item,MEMB_C_TYPE));
            bits=0;
        } else {
            delta=(signed char)MEMBER_B(item,MEMB_C_BIT_WIDTH);
            OBJ_PUT_BYTE((unsigned char)delta+(MEMBER_W(item,MEMB_NEXT) ? 0 : 0x80));
            bits+=delta;
            if(BCC_PACK_FLAG) {
                if(bits>=16) {position+=2;bits=0;}
            } else {
                while(bits>=8) {position++;bits-=8;}
            }
        }
        WRITE_DEBUG_NAME(MEMBER_W(item,MEMB_NAME));
        OBJ_PUT_INDEX(TYPE_W(MEMBER_W(item,MEMB_C_TYPE),TYPE_C_DEBUG_INDEX));
        item=MEMBER_W(item,MEMB_NEXT);
    }
    OBJ_WRITE_RECORD(0x88);
}

/* ---- STOVR128 (listing ovr_1d2b_9c35:CE60) ---- */
extern unsigned char COMPILER_MODE;
extern void far pascal OBJ_PUT_INDEX(unsigned int);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
extern void far pascal OBJ_PUT_WORD(unsigned int);
#define TYPE(n) FAR_W(CSYM_POOL_SEG,n,CSYM_TYPE)
/* Appends one static symbol to an E6h list: name, type index, flag byte (18h/98h for
   functions with flag 0x20), group, segment and offset. Functions are skipped in
   assembly mode. */
static void near pascal EMIT_DEBUG_SYMBOL_ENTRY(register unsigned int node)
{
    unsigned char flags=0;
    register unsigned int item;
    if(TYPE_B(TYPE(node),TYPE_KIND)==TK_FUNCTION) {
        if(COMPILER_MODE) return;
        if(CSYM_W(node,CSYM_FLAGS)&0x20)
            flags|=TYPE_B(TYPE(node),TYPE_C_CALL_CONV)==4 ? 0x98 : 0x18;
    }
    WRITE_DEBUG_NAME(CSYM_W(node,CSYM_NAME));
    OBJ_PUT_INDEX(TYPE_W(TYPE(node),TYPE_C_DEBUG_INDEX));
    OBJ_PUT_BYTE(flags);
    item=FIND_SEGMENT(CSYM_W(node,CSYM_SEGMENT));
    OBJ_PUT_INDEX(SEGDEF_W(item,SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(item,SEGDEF_GROUP),SEGDEF_GROUP) : 0);
    OBJ_PUT_INDEX(SEGDEF_W(item,SEGDEF_INDEX));
    OBJ_PUT_WORD(CSYM_W(node,CSYM_OFFSET));
}
#undef TYPE

/* ---- STOVR129 (listing ovr_1d2b_9c35:CF27) ---- */
extern unsigned int NAME_POOL_SEG;
extern unsigned char OPTION_UNDERSCORES;
extern void far pascal OBJ_PUT_BYTE(unsigned char);
/* Appends the linker spelling of C symbol node as a length-prefixed name: upper case
   for pascal (0x400), '@' prefix for flag 0x2000, else '_' prefix under -u. */
void far pascal WRITE_LINKER_NAME(unsigned int node)
{
    char far *p;
    register unsigned int current=node;
    p=STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(
        *(unsigned int near *)NAME_W(CSYM_W(current,CSYM_NAME),NAME_TEXT_BANK),
        NAME_W(CSYM_W(current,CSYM_NAME),NAME_TEXT_OFFSET)));
    if(CSYM_W(current,CSYM_FLAGS)&0x400) {
        OBJ_PUT_BYTE(STRING_LENGTH(p));
        while(*p) OBJ_PUT_BYTE(RTL_TOUPPER((int)*p++));
    } else if(CSYM_W(current,CSYM_FLAGS)&0x2000) {
        OBJ_PUT_BYTE(STRING_LENGTH(p)+1);
        OBJ_PUT_BYTE('@');
        while(*p) OBJ_PUT_BYTE(*p++);
    } else {
        if(OPTION_UNDERSCORES) {
            OBJ_PUT_BYTE(STRING_LENGTH(p)+1);
            OBJ_PUT_BYTE('_');
        } else OBJ_PUT_BYTE(STRING_LENGTH(p));
        while(*p) OBJ_PUT_BYTE(*p++);
    }
}

/* ---- STOVR130 (listing ovr_1d2b_9c35:D025) ---- */
extern unsigned char CODE_SEGMENT_ID;
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_WORD(unsigned int);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
/* Writes COMENT E5h with the code segment and offset value, probably the start of a
   debug scope (block). */
void far pascal BCC_DEBUG_VALUE_MARK(unsigned int value)
{
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE500);
    OBJ_PUT_BYTE(CODE_SEGMENT_ID);
    OBJ_PUT_WORD(value);
    OBJ_WRITE_RECORD(0x88);
}

/* ---- STOVR131 (listing ovr_1d2b_9c35:D053) ---- */
static void near pascal EMIT_DEBUG_SYMBOLS_END(void);
extern unsigned int SCOPE_POOL_SEG;
extern int far pascal BCC_TOKEN_FLAG(signed char);
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
extern void far pascal OBJ_PUT_INDEX(unsigned int);
extern void far pascal OBJ_PUT_WORD(unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
/* Writes the debug symbols of C scope list as E6h records (types first) and closes the
   scope with an E7h record holding the current code offset (not in assembly mode). list
   -2 only writes the E7h end. Skipped: externals, statics, enum constants, and autos
   that are neither in a register nor used. */
void far pascal EMIT_SCOPE_DEBUG_INFO(int list)
{
    register unsigned int record,item;
    int count;
    if(list==-2) {
        _AX=(int)(signed char)COMPILER_MODE;
        if(_AX) return;
        EMIT_DEBUG_SYMBOLS_END();
        _AX=_AX;
        return;
    }
    for(record=SCOPE_W(list,SCOPE_C_SYMBOLS);record;record=CSYM_W(record,CSYM_NEXT)) {
        if(CSYM_B(record,CSYM_CLASS)==5 && !(CSYM_W(record,CSYM_FLAGS)&0x1000) && !(CSYM_W(record,CSYM_FLAGS)&0xc0)) continue;
        if(CSYM_B(record,CSYM_CLASS)!=2 && CSYM_B(record,CSYM_CLASS)!=3 && CSYM_B(record,CSYM_CLASS)!=9 && CSYM_W(record,CSYM_NAME)) {
            _ES=CSYM_POOL_SEG;
            if(ES_W(record,CSYM_TYPE)) EMIT_TYPE_DEBUG_INFO(ES_W(record,CSYM_TYPE));
        }
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xe600);
    record=SCOPE_W(list,SCOPE_C_SYMBOLS);
    count=1;
    for(;record;record=CSYM_W(record,CSYM_NEXT)) {
        if(CSYM_B(record,CSYM_CLASS)==5 && !(CSYM_W(record,CSYM_FLAGS)&0x1000) && !(CSYM_W(record,CSYM_FLAGS)&0xc0)) continue;
        if(!CSYM_W(record,CSYM_TYPE) || !CSYM_W(record,CSYM_NAME)) continue;
        if(CSYM_B(record,CSYM_CLASS)==2 || CSYM_B(record,CSYM_CLASS)==3 || CSYM_B(record,CSYM_CLASS)==9) continue;
        if(!(count&0x3f)) {
            OBJ_WRITE_RECORD(0x88);
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xe600);
            count=1;
        }
        ++count;
        WRITE_DEBUG_NAME(CSYM_W(record,CSYM_NAME));
        OBJ_PUT_INDEX(TYPE_W(CSYM_W(record,CSYM_TYPE),TYPE_C_DEBUG_INDEX));
        switch(CSYM_B(record,CSYM_CLASS)) {
        case 4:
            OBJ_PUT_BYTE(0);
            item=FIND_SEGMENT(CSYM_W(record,CSYM_SEGMENT));
            OBJ_PUT_INDEX(SEGDEF_W(item,SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(item,SEGDEF_GROUP),SEGDEF_GROUP) : 0);
            OBJ_PUT_INDEX(SEGDEF_W(item,SEGDEF_INDEX));
            OBJ_PUT_WORD(CSYM_W(record,CSYM_OFFSET));
            break;
        case 5:
            if(CSYM_W(record,CSYM_FLAGS)&0x1000) {
                OBJ_PUT_BYTE(4);
                OBJ_PUT_BYTE(BCC_TOKEN_FLAG(CSYM_B(record,CSYM_SEGMENT)));
            } else {
                OBJ_PUT_BYTE(2);
                OBJ_PUT_WORD(CSYM_W(record,CSYM_OFFSET));
            }
            break;
        case 6:
            if(CSYM_W(record,CSYM_FLAGS)&0x1000) {
                OBJ_PUT_BYTE(12);
                OBJ_PUT_BYTE(BCC_TOKEN_FLAG(CSYM_B(record,CSYM_SEGMENT)));
            } else {
                OBJ_PUT_BYTE(10);
                OBJ_PUT_WORD(CSYM_W(record,CSYM_OFFSET));
            }
            break;
        case 8: OBJ_PUT_BYTE(6); break;
        case 11: OBJ_PUT_BYTE(7); break;
        }
    }
    if(count>1) OBJ_WRITE_RECORD(0x88);
    _AX=(int)(signed char)COMPILER_MODE;
    if(!_AX) EMIT_DEBUG_SYMBOLS_END();
}

/* ---- STOVR133 (listing ovr_1d2b_9c35:D2C4) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
extern void far pascal OBJ_PUT_INDEX(unsigned int);
extern void far pascal OBJ_PUT_WORD(unsigned int);
/* Writes the parameters of the current function (variable table entries of kind 6 in
   the outer scope block, walked from the end) as an E6h list with storage 10 and their
   frame offsets. A float parameter of a function without prototype list
   (CODEGEN_PARAM_LIST 0) is given type index 15, probably double, since it is passed as
   a double. Variable table entries are 29 bytes (FIELDS.H VAR_*). */
void far pascal EMIT_LOCALS_DEBUG_INFO(void)
{
    register unsigned int item;
    register int count;
    for(item=2;item<VARIABLE_TABLE_END;item+=29) {
        if(VAR_B(item,VAR_SYMBOL_KIND)==6) {
            _ES=VARIABLE_TABLE_SEG;
            if(CSYM_W(ES_W(item,VAR_SYMBOL),CSYM_NAME))
                EMIT_TYPE_DEBUG_INFO(VAR_W(item,VAR_TYPE));
        }
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
    count=1;
    item=VARIABLE_TABLE_END;
    while(item>2) {
        item-=29;
        if(VAR_B(item,VAR_SYMBOL_KIND)!=6) continue;
        if(!CSYM_W(VAR_W(item,VAR_SYMBOL),CSYM_NAME)) continue;
        if(VAR_W(item,VAR_SCOPE_BLOCK)!=FUNCTION_OUTER_SCOPE_BLOCK) continue;
        if(!(count&0x3F)) {
            OBJ_WRITE_RECORD(0x88);
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xE600);
            count=1;
        }
        count++;
        WRITE_DEBUG_NAME(CSYM_W(VAR_W(item,VAR_SYMBOL),CSYM_NAME));
        if(TYPE_B(VAR_W(item,VAR_TYPE),TYPE_KIND)==9 && !CODEGEN_PARAM_LIST) OBJ_PUT_BYTE(15);
        else OBJ_PUT_INDEX(TYPE_W(VAR_W(item,VAR_TYPE),TYPE_C_DEBUG_INDEX));
        OBJ_PUT_BYTE(10);
        OBJ_PUT_WORD(VAR_W(item,VAR_FRAME_OFFSET));
    }
    if(count>1) OBJ_WRITE_RECORD(0x88);
}

/* ---- STOVR134 (listing ovr_1d2b_9c35:D3E6) ---- */
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_WORD(unsigned int);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
/* COMENT E7h with the current size of the selected segment: the end of a scope. */
static void near pascal EMIT_DEBUG_SYMBOLS_END(void)
{
    unsigned int saved;
    saved=*(unsigned int far *)MK_FP(SEGDEF_POOL_SEG,SELECTED_SEGDEF_ENTRY+SEGDEF_SIZE);
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE700);
    OBJ_PUT_WORD(saved);
    OBJ_WRITE_RECORD(0x88);
}

/* ---- STOVR135 (listing ovr_1d2b_9c35:D41E) ---- */
extern unsigned int SCOPE_POOL_SEG;
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
extern void far pascal OBJ_PUT_INDEX(unsigned int);
extern void far pascal OBJ_PUT_WORD(unsigned int);
#define KIND(n) FAR_B(CSYM_POOL_SEG,n,CSYM_CLASS)
#define TYPE(n) CSYM_W(n,CSYM_TYPE)
/* Debug records for all module-level symbols without writing EXTDEF/PUBDEF (probably
   for assembly output, where TASM writes those): EBh for used externals and ECh for
   publics, each with type; then the E6h lists of statics, typedefs and tags as in
   EMIT_OBJ_SYMBOLS. */
void far pascal EMIT_GLOBALS_DEBUG_INFO(void)
{
    unsigned int head;
    register unsigned int record;
    register int count;
    head=SCOPE_W(C_GLOBAL_SCOPE,SCOPE_C_SYMBOLS);
    for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
        if(KIND(record)==2 && (CSYM_W(record,CSYM_FLAGS)&0x80)) {
            EMIT_TYPE_DEBUG_INFO(TYPE(record));
            OBJ_RESET_RECORD(); OBJ_PUT_WORD(0xeb00);
            WRITE_LINKER_NAME(record);
            OBJ_PUT_INDEX(TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX));
            OBJ_WRITE_RECORD(0x88);
        } else if(KIND(record)==1) {
            EMIT_TYPE_DEBUG_INFO(TYPE(record));
            OBJ_RESET_RECORD(); OBJ_PUT_WORD(0xec00);
            WRITE_LINKER_NAME(record);
            OBJ_PUT_INDEX(TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX));
            OBJ_PUT_BYTE((TYPE_B(TYPE(record),TYPE_KIND)==18 && (CSYM_W(record,CSYM_FLAGS)&0x20)) ?
                (TYPE_B(TYPE(record),TYPE_C_CALL_CONV)==4 ? 0x98 : 0x18) : 0);
            OBJ_WRITE_RECORD(0x88);
        } else if(KIND(record)==3) EMIT_TYPE_DEBUG_INFO(TYPE(record));
    }
    OBJ_RESET_RECORD(); OBJ_PUT_WORD(0xe600);
    count=1;
    for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
        if(KIND(record)==3) {
            if(!(count&0x3f)) {
                OBJ_WRITE_RECORD(0x88); OBJ_RESET_RECORD(); OBJ_PUT_WORD(0xe600);
                count=1;
            }
            EMIT_DEBUG_SYMBOL_ENTRY(record);
            ++count;
        }
    }
    for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
        if(KIND(record)==8 && TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX)) {
            if(!(count&0x3f)) {
                OBJ_WRITE_RECORD(0x88); OBJ_RESET_RECORD(); OBJ_PUT_WORD(0xe600);
                count=1;
            }
            ++count;
            WRITE_DEBUG_NAME(CSYM_W(record,CSYM_NAME));
            OBJ_PUT_INDEX(TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX));
            OBJ_PUT_BYTE(6);
        }
    }
    for(record=head;record;record=CSYM_W(record,CSYM_NEXT)) {
        if(KIND(record)==11 && TYPE(record) && TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX) && CSYM_W(record,CSYM_NAME)) {
            if(!(count&0x3f)) {
                OBJ_WRITE_RECORD(0x88); OBJ_RESET_RECORD(); OBJ_PUT_WORD(0xe600);
                count=1;
            }
            WRITE_DEBUG_NAME(CSYM_W(record,CSYM_NAME));
            OBJ_PUT_INDEX(TYPE_W(TYPE(record),TYPE_C_DEBUG_INDEX));
            OBJ_PUT_BYTE(7);
            ++count;
        }
    }
    if(count>1) OBJ_WRITE_RECORD(0x88);
}
#undef KIND
#undef TYPE

/* ---- STOVR136 (listing ovr_1d2b_9c35:D681) ---- */
extern unsigned int NAME_POOL_SEG;
extern void far pascal OBJ_PUT_NAME(char far *);
/* Appends the text of NAME_POOL record node as a length-prefixed name (copied through
   BCC_DEBUG_NAME). */
static void near pascal WRITE_DEBUG_NAME(register unsigned int node)
{
    STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(*(unsigned int near *)NAME_W(node,NAME_TEXT_BANK),NAME_W(node,NAME_TEXT_OFFSET)));
    OBJ_PUT_NAME(BCC_DEBUG_NAME);
}
