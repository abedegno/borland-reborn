/* target: ovr115_C231UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: object output: EXTDEF and PUBDEF records with mangled names, and function debug
   records. Entry points: EMIT_EXTDEF_PUBDEF_RECORDS, OBJ_PUT_SYMBOL_NAME. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: the external and public symbol records of an OMF object file, written at the
   end of a C++ compile (EMIT_EXTDEF_PUBDEF_RECORDS, reached through the back end's hook
   table; OBJSYMS.C has the C version). Records are built with the OMFWRITE.C helpers:
   OBJ_RESET_RECORD starts a record body, OBJ_PUT_BYTE/WORD/INDEX/NAME add to it and
   OBJ_WRITE_RECORD(type) writes it. Record types used: 8Ch EXTDEF (external names),
   B0h COMDEF (communal variables), 90h PUBDEF (public names), B6h LPUBDEF (local
   public), 88h COMENT. The COMENT records carry Turbo Debugger information when -v is on:
   class E0h (type of an external), E1h (type of a public), ECh (a function), and
   A0h subtype 2 (an export definition, for _export functions).
   Several names are packed into one EXTDEF or COMDEF record. PENDING_EXTERN_RECORD_TYPE
   holds the type of the record being filled (0 none); it is written out when the type
   changes, when debug records must come in between, after 128 entries, and at the end.
   External names are numbered from 1 in output order; OBJ_EXTERN_INDEX
   is this external index counter (it starts at 1 in OPEN_SESSION_SOURCE), and
   each external's index is stored as its symbol offset (SET_SYMBOL_OFFSET_HOOK).
   Virtual segments (CPPCTOR.C, CPPFINAL.C) draw from the same counter, since they are
   written as B0h records and so take external indexes too; their segment id is
   4000h + that index.
   Symbols are visited through the prepared storage records (node, 10 bytes apart, up to
   NODE_COUNT); GET_PREPARED_SYMBOL gives the C++ symbol behind each. Storage classes
   (SYM_STORAGE_CLASS >> 3) as used here: 1 public, 2 external, 3 defined here.
   Prepared flags (CSYM_PREP_FLAGS): 0x80 communal, 0x100 function needing only a debug
   record, 0x200 exported, 0x20 used for the debug flag byte. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"

/* ---- EMIT_EXTDEF_PUBDEF_RECORDS (listing 5C20) ---- */
static void near pascal EMIT_FUNCTION_DEBUG_RECORD(unsigned int node);
static int near pascal ADD_EXTDEF_ENTRY(register unsigned int node);
static void near pascal EMIT_PUBDEF_RECORD(register unsigned int node,int flag);
extern unsigned char  OPTION_SOURCE_DEBUG;
extern signed char  OPTION_OVERLAY_CODE,OPTION_WINDOWS_MODE;
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);
extern unsigned int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
extern unsigned int far pascal GET_PREPARED_SYMBOL(unsigned int);
extern void far pascal OBJ_PUT_NAME(char far *);
extern void far pascal OBJ_RESET_RECORD(void);
extern void far pascal OBJ_PUT_BYTE(unsigned char);
extern void far pascal OBJ_WRITE_RECORD(unsigned char);
extern void far pascal BCC_SYMBOL_SWEEP(void);
/* Writes all external, communal and public records of the module. base is added to the
   offset of class-3 symbols that have no segment yet (placed in the data segment).
   First pass: EXTDEF/COMDEF entries for used externals, debug records for functions with
   prepared flag 0x100. If floating point was used (CODE_OUTPUT_FLAGS bit 1) an extra
   EXTDEF for "__turboFloat" is written, which probably makes the linker pull in the
   floating-point start-up code. Second pass: PUBDEF for publics; for overlay or Windows
   code also LPUBDEF for far static functions whose address is taken (SYM_FUNC_FLAGS 8),
   probably so the linker can make entry thunks for them. Then the -v symbol records
   (BCC_SYMBOL_SWEEP in DEBUGREC.C). */
void far pascal EMIT_EXTDEF_PUBDEF_RECORDS(unsigned int base)
{
    int mode;
    register unsigned int node,type;
    OBJ_RESET_RECORD();
    PENDING_EXTERN_RECORD_TYPE=0;
    node=0;   /* record 0 is skipped: the walk starts at node 10 */
    goto next1;
    do {
        type=GET_PREPARED_SYMBOL(node);
        if((SYM_B(type,SYM_STORAGE_CLASS)>>3)==2) {
            if(CSYM_W(node,CSYM_PREP_FLAGS)&0x100) EMIT_FUNCTION_DEBUG_RECORD(node);
            else if((SYM_B(type,SYM_FLAGS)&6) || (CSYM_W(node,CSYM_PREP_FLAGS)&0x80)) mode=ADD_EXTDEF_ENTRY(node);
        } else if((SYM_B(type,SYM_STORAGE_CLASS)>>3)==3 && (CSYM_W(node,CSYM_PREP_FLAGS)&0x100)) EMIT_FUNCTION_DEBUG_RECORD(node);
next1:
        node+=10;
    } while(node<NODE_COUNT);
    if(CODE_OUTPUT_FLAGS&2) {
        if(PENDING_EXTERN_RECORD_TYPE==0xb0) {
            OBJ_WRITE_RECORD(mode);
            OBJ_RESET_RECORD();
        }
        OBJ_PUT_NAME(STR_TURBOFLOAT);
        OBJ_PUT_BYTE(0);
        OBJ_WRITE_RECORD(0x8c);
    } else if(PENDING_EXTERN_RECORD_TYPE) OBJ_WRITE_RECORD(PENDING_EXTERN_RECORD_TYPE);
    node=0;
    goto next2;
    do {
        type=GET_PREPARED_SYMBOL(node);
        switch(SYM_B(type,SYM_STORAGE_CLASS)>>3) {
        case 1:
            EMIT_PUBDEF_RECORD(node,0);
            break;
        case 3:
            if((SYM_B(type,SYM_FLAGS)&0x20) && !(SYM_B(type,SYM_FLAGS)&4)) break;
            if(!GET_SYMBOL_SEGMENT_HOOK(node)) {
                SET_SYMBOL_SEGMENT_HOOK(node,DATA_SEGMENT_ID);
                SET_SYMBOL_OFFSET_HOOK(node,SYMBOL_INDEX_HOOK(node)+base);
            }
            if(OPTION_OVERLAY_CODE|OPTION_WINDOWS_MODE) {
                if(TYPE_W(SYM_W(type,SYM_TYPE),TYPE_KIND)==0x12 && (TYPE_B(SYM_W(type,SYM_TYPE),TYPE_FUNC_FLAGS)&1) && (SYM_W(type,SYM_FUNC_FLAGS)&8))
                    EMIT_PUBDEF_RECORD(node,1);
            }
            break;
        }
next2:
        node+=10;
    } while(node<NODE_COUNT);
    if(OPTION_SOURCE_DEBUG) BCC_SYMBOL_SWEEP();
}

/* ---- EMIT_FUNCTION_DEBUG_RECORD (listing 5DBE) ---- */
extern void far pascal OBJ_PUT_SYMBOL_NAME(unsigned int type,int flag);
extern unsigned int far pascal GET_TYPE_DEBUG_ID(unsigned int);
extern unsigned int far pascal GET_PREPARED_FLAGS(unsigned int);
extern void far pascal OBJ_PUT_INDEX(unsigned int);
extern void far pascal OBJ_PUT_WORD(unsigned int);
extern void far pascal EMIT_DEBUG_METHOD_TYPE(unsigned int,unsigned int);
extern void far pascal EMIT_DEBUG_TYPE(unsigned int,unsigned int);
/* Writes a COMENT class ECh record for function node: name, debug type index and a flag
   byte (18h, or 98h for calling convention 4, when prepared flag 0x20 is set). With -v
   the function's type records come first. Skipped for an unused symbol (SYM_FLAGS 0x20
   without 4). Any pending EXTDEF/COMDEF is written out first. */
static void near pascal EMIT_FUNCTION_DEBUG_RECORD(unsigned int node)
{
    register unsigned int type,tp;
    type=GET_PREPARED_SYMBOL(node);
    tp=SYM_W(type,SYM_TYPE);
    if((SYM_B(type,SYM_STORAGE_CLASS)>>3)==3 && (SYM_B(type,SYM_FLAGS)&0x20) && !(SYM_B(type,SYM_FLAGS)&4)) return;
    if(PENDING_EXTERN_RECORD_TYPE) {
        OBJ_WRITE_RECORD(PENDING_EXTERN_RECORD_TYPE);
        OBJ_RESET_RECORD();
    }
    if(OPTION_SOURCE_DEBUG) {
        if(CPP_MODE && TYPE_W(tp,TYPE_KIND)==0x12 && (SYM_B(type,SYM_FLAGS)&0x10))
            EMIT_DEBUG_METHOD_TYPE(type,GLOBAL_SCOPE_TAGS);
        else EMIT_DEBUG_TYPE(tp,GLOBAL_SCOPE_TAGS);
        OBJ_RESET_RECORD();
    }
    OBJ_PUT_WORD(0xec00);
    OBJ_PUT_SYMBOL_NAME(type,0);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(tp));
    OBJ_PUT_BYTE((GET_PREPARED_FLAGS(node)&0x20) ? (TYPE_B(tp,TYPE_CALL_CONV)==4 ? 0x98 : 0x18) : 0);
    OBJ_WRITE_RECORD(0x88);
    OBJ_RESET_RECORD();
    PENDING_EXTERN_RECORD_TYPE=0;
}

/* ---- ADD_EXTDEF_ENTRY (listing 5EAF) ---- */
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
/* Adds external node to the pending EXTDEF record, or to a COMDEF record for a communal
   variable, and gives it the next external index. COMDEF entry: name, type index 0, then
   61h (far: element count and element size) or 62h (near, in BSS: total size); a
   length is one byte up to 80h, else 81h + word or 88h + dword. With -v the record is
   written at once and followed by the type records and a COMENT class E0h. Returns the
   record type used (8Ch or B0h). */
static int near pascal ADD_EXTDEF_ENTRY(register unsigned int node)
{
    int mode;
    register unsigned int type;
    type=GET_PREPARED_SYMBOL(node);
    mode=(CSYM_W(node,CSYM_PREP_FLAGS)&0x80) ? 0xb0 : 0x8c;
    SET_SYMBOL_OFFSET_HOOK(node,OBJ_EXTERN_INDEX++);
    if(PENDING_EXTERN_RECORD_TYPE && PENDING_EXTERN_RECORD_TYPE!=mode) {
        OBJ_WRITE_RECORD(PENDING_EXTERN_RECORD_TYPE);
        OBJ_RESET_RECORD();
    }
    PENDING_EXTERN_RECORD_TYPE=mode;
    OBJ_PUT_SYMBOL_NAME(type,0);
    OBJ_PUT_BYTE(0);
    if(CSYM_W(node,CSYM_PREP_FLAGS)&0x80) {
        unsigned int tp;
        unsigned long size;
        tp=SYM_W(type,SYM_TYPE);
        if(GET_SYMBOL_SEGMENT_HOOK(node)!=BSS_SEGMENT_ID) {
            OBJ_PUT_BYTE(0x61);
            size=1;
            while(TYPE_W(tp,TYPE_KIND)==TK_ARRAY) {
                size*=TYPE_UL(tp,TYPE_ARRAY_COUNT);
                tp=TYPE_W(tp,TYPE_TARGET);
            }
            if(size<=0x80) OBJ_PUT_BYTE(size);
            else if(size<=0x7fff) {
                OBJ_PUT_BYTE(0x81);
                OBJ_PUT_WORD(size);
            } else {
                OBJ_PUT_BYTE(0x88);
                OBJ_PUT_WORD(size);
                OBJ_PUT_WORD(size>>16);
            }
        } else OBJ_PUT_BYTE(0x62);
        size=TYPE_SIZE(tp);
        if(size<=0x80) OBJ_PUT_BYTE(size);
        else {
            OBJ_PUT_BYTE(0x81);
            OBJ_PUT_WORD(size);
        }
    }
    if(OPTION_SOURCE_DEBUG) {
        unsigned int tp;
        tp=SYM_W(type,SYM_TYPE);
        OBJ_WRITE_RECORD(mode);
        if(CPP_MODE && TYPE_W(tp,TYPE_KIND)==TK_FUNCTION && (SYM_B(type,SYM_FLAGS)&0x10))
            EMIT_DEBUG_METHOD_TYPE(type,GLOBAL_SCOPE_TAGS);
        else EMIT_DEBUG_TYPE(tp,GLOBAL_SCOPE_TAGS);
        if(CPP_MODE && (SYM_B(type,SYM_FLAGS)&0x10))
            EMIT_DEBUG_TYPE(SYM_W(SYM_W(type,SYM_OWNER_CLASS),SYM_TYPE),GLOBAL_SCOPE_TAGS);
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xe000);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(tp));
        OBJ_WRITE_RECORD(0x88);
        OBJ_RESET_RECORD();
    } else if(!(OBJ_EXTERN_INDEX&0x7f)) {
        OBJ_WRITE_RECORD(mode);
        OBJ_RESET_RECORD();
    }
    return mode;
}

/* ---- EMIT_PUBDEF_RECORD (listing 60E5) ---- */
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);
extern unsigned int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
extern unsigned int far pascal FIND_SEGMENT(unsigned int);
/* Writes one PUBDEF (flag 0) or LPUBDEF (flag 1) record for node: group index (the
   segment's group, or 0), segment index, name, offset, type 0. A symbol without a
   segment is placed in the data segment, after the segment's current size. A symbol in a
   virtual segment (id 4000h and up) gets no PUBDEF here. With -v and flag 0 a
   COMENT class E1h with the type follows; an exported symbol (prepared flag 0x200) also
   gets an export COMENT (class A0h, subtype 2). */
static void near pascal EMIT_PUBDEF_RECORD(register unsigned int node,int flag)
{
    int count;
    int value;
    unsigned int handle;
    unsigned int tp;
    register unsigned int type;
    type=GET_PREPARED_SYMBOL(node);
    value=GET_SYMBOL_SEGMENT_HOOK(node);
    if(!value) value=DATA_SEGMENT_ID;
    handle=FIND_SEGMENT(value);
    count=SEGDEF_W(handle,SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(handle,SEGDEF_GROUP),SEGDEF_GROUP) : 0;
    if(value<0x4000) {
        OBJ_RESET_RECORD();
        OBJ_PUT_BYTE(count);
        OBJ_PUT_BYTE(value);
        if(!GET_SYMBOL_SEGMENT_HOOK(node)) {
            SET_SYMBOL_SEGMENT_HOOK(node,DATA_SEGMENT_ID);
            SET_SYMBOL_OFFSET_HOOK(node,SYMBOL_INDEX_HOOK(node)+SEGDEF_W(handle,SEGDEF_SIZE));
        }
        OBJ_PUT_SYMBOL_NAME(type,0);
        OBJ_PUT_WORD(SYMBOL_INDEX_HOOK(node));
        OBJ_PUT_BYTE(0);
        OBJ_WRITE_RECORD(flag ? 0xb6 : 0x90);
    }
    if(!flag && OPTION_SOURCE_DEBUG) {
        tp=SYM_W(type,SYM_TYPE);
        if(CPP_MODE && TYPE_W(tp,TYPE_KIND)==TK_FUNCTION && (SYM_B(type,SYM_FLAGS)&0x10))
            EMIT_DEBUG_METHOD_TYPE(type,GLOBAL_SCOPE_TAGS);
        else EMIT_DEBUG_TYPE(tp,GLOBAL_SCOPE_TAGS);
        if(CPP_MODE && (SYM_B(type,SYM_FLAGS)&0x10))
            EMIT_DEBUG_TYPE(SYM_W(SYM_W(type,SYM_OWNER_CLASS),SYM_TYPE),GLOBAL_SCOPE_TAGS);
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xe100);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(tp));
        if(TYPE_W(tp,TYPE_KIND)==TK_FUNCTION && (CSYM_W(node,CSYM_PREP_FLAGS)&0x20)) count=TYPE_B(tp,TYPE_CALL_CONV)==4 ? 0x98 : 0x18;
        else count=0;
        OBJ_PUT_BYTE(count);
        OBJ_WRITE_RECORD(0x88);
    }
    if(CSYM_W(node,CSYM_PREP_FLAGS)&0x200) {
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xa000);
        OBJ_PUT_WORD(2);
        OBJ_PUT_SYMBOL_NAME(type,0);
        OBJ_PUT_BYTE(0);
        OBJ_WRITE_RECORD(0x88);
    }
}

/* ---- OBJ_PUT_SYMBOL_NAME (listing 62C8) ---- */
extern unsigned int NAME_POOL_SEG;
extern unsigned char OPTION_UNDERSCORES;
extern char far * far pascal MANGLE_SYMBOL_NAME(unsigned int);
/* Adds the object-file spelling of C++ symbol type to the record as a length-prefixed
   name: the mangled name for members and C++-linkage functions (MANGLE_SYMBOL_NAME),
   the upper-case name for pascal names (SYM_FLAGS 0x40), else the name with a leading
   '_' under -u unless flag is set. The plain name is copied to BCC_DEBUG_NAME first. */
void far pascal OBJ_PUT_SYMBOL_NAME(register unsigned int type,int flag)
{
    char far *p;
    register int special;
    special=CPP_MODE && ((SYM_B(type,SYM_FLAGS)&0x10) || (TYPE_W(SYM_W(type,SYM_TYPE),TYPE_KIND)==0x12 && SYM_W(type,SYM_LINKAGE)==1));
    if(special) p=MANGLE_SYMBOL_NAME(type);
    else p=STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(
        *(unsigned int near *)NAME_W(SYM_W(type,SYM_NAME),NAME_TEXT_BANK),
        NAME_W(SYM_W(type,SYM_NAME),NAME_TEXT_OFFSET)));
    if(SYM_B(type,SYM_FLAGS)&0x40) {
        OBJ_PUT_BYTE(STRING_LENGTH(p));
        while(*p) OBJ_PUT_BYTE(RTL_TOUPPER((int)*p++));
    } else {
        if(!special && !flag && OPTION_UNDERSCORES) {
            OBJ_PUT_BYTE(STRING_LENGTH(p)+1);
            OBJ_PUT_BYTE('_');
        } else OBJ_PUT_BYTE(STRING_LENGTH(p));
        while(*p) OBJ_PUT_BYTE(*p++);
    }
}
