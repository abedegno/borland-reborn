/* objpubs.c: from bcc20/src/output/OBJPUBS.C: the external and public symbol records of an
   OMF object file, written at the end of a C++ compile (EMIT_EXTDEF_PUBDEF_RECORDS, reached
   through the back end's hook table; OBJSYMS.C has the C version).  Records are built with
   the OMFWRITE.C helpers: OBJ_RESET_RECORD starts a record body, OBJ_PUT_BYTE/WORD/INDEX/
   NAME add to it and OBJ_WRITE_RECORD(type) writes it.  Record types used: 8Ch EXTDEF, B0h
   COMDEF (communal variables), 90h PUBDEF, B6h LPUBDEF (local public), 88h COMENT.  The
   COMENT records carry Turbo Debugger information when -v is on: class E0h (type of an
   external), E1h (type of a public), ECh (a function), and A0h subtype 2 (an export
   definition, for _export functions).
   Several names are packed into one EXTDEF or COMDEF record.  PENDING_EXTERN_RECORD_TYPE
   holds the type of the record being filled (0 none); it is written out when the type
   changes, when debug records must come in between, after 128 entries, and at the end.
   External names are numbered from 1 in output order (OBJ_EXTERN_INDEX), and each
   external's index is stored as its symbol offset.  Virtual segments draw from the same
   counter, since they are written as B0h records too; their segment id is 4000h + that
   index.
   Symbols are visited through the prepared storage records (node, 10 bytes apart, up to
   NODE_COUNT); GET_PREPARED_SYMBOL gives the C++ symbol behind each.  Storage classes
   (SYM_STORAGE_CLASS >> 3): 1 public, 2 external, 3 defined here.  Prepared flags
   (CSYM_PREP_FLAGS): 80h communal, 100h function needing only a debug record, 200h
   exported, 20h used for the debug flag byte. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "kind.h"

#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)
#define OPTION_OVERLAY_CODE SB(OPTION_OVERLAY_CODE_P)
#define OPTION_WINDOWS_MODE SB(OPTION_WINDOWS_MODE_P)
#define OPTION_UNDERSCORES B(OPTION_UNDERSCORES_P)
#define STORAGE_CLASS(symbol) (SYM_B((symbol), SYM_STORAGE_CLASS) >> 3)

static u16 symbol_segment(u16 node) { return (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(node)); }
static u16 symbol_index(u16 node) { return (u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(node)); }
static void set_segment(u16 node, u16 segment) { CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(node), A16(segment)); }
static void set_offset(u16 node, u16 offset) { CALL_FAR(SET_SYMBOL_OFFSET_HOOK, A16(node), A16(offset)); }

/* an unused symbol defined here: SYM_FLAGS 20h without 4 */
static int unused(u16 symbol)
{
    return (SYM_B(symbol, SYM_FLAGS) & 0x20) && !(SYM_B(symbol, SYM_FLAGS) & 4);
}

/* the debug type records of symbol (the method type of a member function, and the class
   of a member) */
static void debug_types(u16 symbol, u16 tp)
{
    if (CPP_MODE && TYPE_W(tp, TYPE_KIND) == TK_FUNCTION && (SYM_B(symbol, SYM_FLAGS) & 0x10))
        EMIT_DEBUG_METHOD_TYPE(symbol, GLOBAL_SCOPE_TAGS);
    else
        EMIT_DEBUG_TYPE(tp, GLOBAL_SCOPE_TAGS);
}

/* writes all external, communal and public records of the module.  base is added to the
   offset of class-3 symbols that have no segment yet (placed in the data segment).  First
   pass: EXTDEF/COMDEF entries for used externals, debug records for functions with
   prepared flag 100h.  If floating point was used (CODE_OUTPUT_FLAGS bit 1) an extra
   EXTDEF for "__turboFloat" is written, which probably makes the linker pull in the
   floating-point start-up code.  Second pass: PUBDEF for publics; for overlay or Windows
   code also LPUBDEF for far static functions whose address is taken (SYM_FUNC_FLAGS 8),
   probably so the linker can make entry thunks for them.  Then the -v symbol records */
void EMIT_EXTDEF_PUBDEF_RECORDS(u16 base)
{
    i16 mode = 0;
    OBJ_RESET_RECORD();
    PENDING_EXTERN_RECORD_TYPE = 0;
    for (u16 node = 10; node < NODE_COUNT; node += 10) {
        u16 symbol = GET_PREPARED_SYMBOL(node);
        if (STORAGE_CLASS(symbol) == 2) {
            if (CSYM_W(node, CSYM_PREP_FLAGS) & 0x100)
                EMIT_FUNCTION_DEBUG_RECORD(node);
            else if ((SYM_B(symbol, SYM_FLAGS) & 6) || (CSYM_W(node, CSYM_PREP_FLAGS) & 0x80))
                mode = ADD_EXTDEF_ENTRY(node);
        } else if (STORAGE_CLASS(symbol) == 3 && (CSYM_W(node, CSYM_PREP_FLAGS) & 0x100))
            EMIT_FUNCTION_DEBUG_RECORD(node);
    }
    if (CODE_OUTPUT_FLAGS & 2) {
        if (PENDING_EXTERN_RECORD_TYPE == 0xB0) {
            OBJ_WRITE_RECORD((u8)mode);
            OBJ_RESET_RECORD();
        }
        OBJ_PUT_NAME(STR_TURBOFLOAT_P);
        OBJ_PUT_BYTE(0);
        OBJ_WRITE_RECORD(0x8C);
    } else if (PENDING_EXTERN_RECORD_TYPE)
        OBJ_WRITE_RECORD((u8)PENDING_EXTERN_RECORD_TYPE);
    for (u16 node = 10; node < NODE_COUNT; node += 10) {
        u16 symbol = GET_PREPARED_SYMBOL(node);
        switch (STORAGE_CLASS(symbol)) {
        case 1:
            EMIT_PUBDEF_RECORD(node, 0);
            break;
        case 3:
            if (unused(symbol))
                break;
            if (!symbol_segment(node)) {
                set_segment(node, DATA_SEGMENT_ID);
                set_offset(node, symbol_index(node) + base);
            }
            if (OPTION_OVERLAY_CODE | OPTION_WINDOWS_MODE) {
                u16 tp = SYM_W(symbol, SYM_TYPE);
                if (TYPE_W(tp, TYPE_KIND) == 0x12 && (TYPE_B(tp, TYPE_FUNC_FLAGS) & 1) &&
                    (SYM_W(symbol, SYM_FUNC_FLAGS) & 8))
                    EMIT_PUBDEF_RECORD(node, 1);
            }
            break;
        }
    }
    if (OPTION_SOURCE_DEBUG)
        BCC_SYMBOL_SWEEP();
}

/* writes a COMENT class ECh record for function node: name, debug type index and a flag
   byte (18h, or 98h for calling convention 4, when prepared flag 20h is set).  With -v the
   function's type records come first.  Skipped for an unused symbol defined here.  Any
   pending EXTDEF/COMDEF is written out first */
void EMIT_FUNCTION_DEBUG_RECORD(u16 node)
{
    u16 symbol = GET_PREPARED_SYMBOL(node);
    u16 tp = SYM_W(symbol, SYM_TYPE);
    if (STORAGE_CLASS(symbol) == 3 && unused(symbol))
        return;
    if (PENDING_EXTERN_RECORD_TYPE) {
        OBJ_WRITE_RECORD((u8)PENDING_EXTERN_RECORD_TYPE);
        OBJ_RESET_RECORD();
    }
    if (OPTION_SOURCE_DEBUG) {
        if (CPP_MODE && TYPE_W(tp, TYPE_KIND) == 0x12 && (SYM_B(symbol, SYM_FLAGS) & 0x10))
            EMIT_DEBUG_METHOD_TYPE(symbol, GLOBAL_SCOPE_TAGS);
        else
            EMIT_DEBUG_TYPE(tp, GLOBAL_SCOPE_TAGS);
        OBJ_RESET_RECORD();
    }
    OBJ_PUT_WORD(0xEC00);
    OBJ_PUT_SYMBOL_NAME(symbol, 0);
    OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(tp));
    OBJ_PUT_BYTE((GET_PREPARED_FLAGS(node) & 0x20) ? (TYPE_B(tp, TYPE_CALL_CONV) == 4 ? 0x98 : 0x18) : 0);
    OBJ_WRITE_RECORD(0x88);
    OBJ_RESET_RECORD();
    PENDING_EXTERN_RECORD_TYPE = 0;
}

/* adds external node to the pending EXTDEF record, or to a COMDEF record for a communal
   variable, and gives it the next external index.  COMDEF entry: name, type index 0, then
   61h (far: element count and element size) or 62h (near, in BSS: total size); a length is
   one byte up to 80h, else 81h + word or 88h + dword.  With -v the record is written at
   once and followed by the type records and a COMENT class E0h.  Returns the record type
   used (8Ch or B0h) */
i16 ADD_EXTDEF_ENTRY(u16 node)
{
    u16 symbol = GET_PREPARED_SYMBOL(node);
    i16 mode = (CSYM_W(node, CSYM_PREP_FLAGS) & 0x80) ? 0xB0 : 0x8C;
    set_offset(node, OBJ_EXTERN_INDEX++);
    if (PENDING_EXTERN_RECORD_TYPE && PENDING_EXTERN_RECORD_TYPE != (u16)mode) {
        OBJ_WRITE_RECORD((u8)PENDING_EXTERN_RECORD_TYPE);
        OBJ_RESET_RECORD();
    }
    PENDING_EXTERN_RECORD_TYPE = (u16)mode;
    OBJ_PUT_SYMBOL_NAME(symbol, 0);
    OBJ_PUT_BYTE(0);
    if (CSYM_W(node, CSYM_PREP_FLAGS) & 0x80) {
        u16 tp = SYM_W(symbol, SYM_TYPE);
        u32 size;
        if (symbol_segment(node) != BSS_SEGMENT_ID) {
            OBJ_PUT_BYTE(0x61);
            size = 1;
            while (TYPE_W(tp, TYPE_KIND) == TK_ARRAY) {
                size *= TYPE_UL(tp, TYPE_ARRAY_COUNT);
                tp = TYPE_W(tp, TYPE_TARGET);
            }
            if (size <= 0x80)
                OBJ_PUT_BYTE((u8)size);
            else if (size <= 0x7FFF) {
                OBJ_PUT_BYTE(0x81);
                OBJ_PUT_WORD((u16)size);
            } else {
                OBJ_PUT_BYTE(0x88);
                OBJ_PUT_WORD((u16)size);
                OBJ_PUT_WORD((u16)(size >> 16));
            }
        } else
            OBJ_PUT_BYTE(0x62);
        size = (u32)TYPE_SIZE(tp);
        if (size <= 0x80)
            OBJ_PUT_BYTE((u8)size);
        else {
            OBJ_PUT_BYTE(0x81);
            OBJ_PUT_WORD((u16)size);
        }
    }
    if (OPTION_SOURCE_DEBUG) {
        u16 tp = SYM_W(symbol, SYM_TYPE);
        OBJ_WRITE_RECORD((u8)mode);
        debug_types(symbol, tp);
        if (CPP_MODE && (SYM_B(symbol, SYM_FLAGS) & 0x10))
            EMIT_DEBUG_TYPE(SYM_W(SYM_W(symbol, SYM_OWNER_CLASS), SYM_TYPE), GLOBAL_SCOPE_TAGS);
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xE000);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(tp));
        OBJ_WRITE_RECORD(0x88);
        OBJ_RESET_RECORD();
    } else if (!(OBJ_EXTERN_INDEX & 0x7F)) {
        OBJ_WRITE_RECORD((u8)mode);
        OBJ_RESET_RECORD();
    }
    return mode;
}

/* writes one PUBDEF (flag 0) or LPUBDEF (flag 1) record for node: group index (the
   segment's group, or 0), segment index, name, offset, type 0.  A symbol without a segment
   is placed in the data segment, after the segment's current size.  A symbol in a virtual
   segment (id 4000h and up) gets no PUBDEF here.  With -v and flag 0 a COMENT class E1h
   with the type follows; an exported symbol (prepared flag 200h) also gets an export
   COMENT (class A0h, subtype 2) */
void EMIT_PUBDEF_RECORD(u16 node, i16 flag)
{
    u16 symbol = GET_PREPARED_SYMBOL(node);
    i16 value = (i16)symbol_segment(node);
    if (!value)
        value = (i16)DATA_SEGMENT_ID;
    u16 handle = FIND_SEGMENT((u16)value);
    i16 count = SEGDEF_W(handle, SEGDEF_GROUP) ? (i16)SEGDEF_W(SEGDEF_W(handle, SEGDEF_GROUP), SEGDEF_GROUP) : 0;
    if (value < 0x4000) {
        OBJ_RESET_RECORD();
        OBJ_PUT_BYTE((u8)count);
        OBJ_PUT_BYTE((u8)value);
        if (!symbol_segment(node)) {
            set_segment(node, DATA_SEGMENT_ID);
            set_offset(node, symbol_index(node) + SEGDEF_W(handle, SEGDEF_SIZE));
        }
        OBJ_PUT_SYMBOL_NAME(symbol, 0);
        OBJ_PUT_WORD(symbol_index(node));
        OBJ_PUT_BYTE(0);
        OBJ_WRITE_RECORD(flag ? 0xB6 : 0x90);
    }
    if (!flag && OPTION_SOURCE_DEBUG) {
        u16 tp = SYM_W(symbol, SYM_TYPE);
        debug_types(symbol, tp);
        if (CPP_MODE && (SYM_B(symbol, SYM_FLAGS) & 0x10))
            EMIT_DEBUG_TYPE(SYM_W(SYM_W(symbol, SYM_OWNER_CLASS), SYM_TYPE), GLOBAL_SCOPE_TAGS);
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xE100);
        OBJ_PUT_INDEX(GET_TYPE_DEBUG_ID(tp));
        if (TYPE_W(tp, TYPE_KIND) == TK_FUNCTION && (CSYM_W(node, CSYM_PREP_FLAGS) & 0x20))
            count = TYPE_B(tp, TYPE_CALL_CONV) == 4 ? 0x98 : 0x18;
        else
            count = 0;
        OBJ_PUT_BYTE((u8)count);
        OBJ_WRITE_RECORD(0x88);
    }
    if (CSYM_W(node, CSYM_PREP_FLAGS) & 0x200) {
        OBJ_RESET_RECORD();
        OBJ_PUT_WORD(0xA000);
        OBJ_PUT_WORD(2);
        OBJ_PUT_SYMBOL_NAME(symbol, 0);
        OBJ_PUT_BYTE(0);
        OBJ_WRITE_RECORD(0x88);
    }
}

/* adds the object-file spelling of C++ symbol symbol to the record as a length-prefixed
   name: the mangled name for members and C++-linkage functions, the upper-case name for
   pascal names (SYM_FLAGS 40h), else the name with a leading '_' under -u unless flag is
   set.  The plain name is copied to BCC_DEBUG_NAME first */
void OBJ_PUT_SYMBOL_NAME(u16 symbol, i16 flag)
{
    int special = CPP_MODE && ((SYM_B(symbol, SYM_FLAGS) & 0x10) ||
                               (TYPE_W(SYM_W(symbol, SYM_TYPE), TYPE_KIND) == 0x12 && SYM_W(symbol, SYM_LINKAGE) == 1));
    farptr p;
    if (special)
        p = MANGLE_SYMBOL_NAME(symbol);
    else {
        u16 name = SYM_W(symbol, SYM_NAME);
        p = STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET)));
    }
    if (SYM_B(symbol, SYM_FLAGS) & 0x40) {
        OBJ_PUT_BYTE((u8)STRING_LENGTH(p));
        for (; SB(p); p = fp_add(p, 1))
            OBJ_PUT_BYTE((u8)RTL_TOUPPER(SB(p)));
    } else {
        if (!special && !flag && OPTION_UNDERSCORES) {
            OBJ_PUT_BYTE((u8)(STRING_LENGTH(p) + 1));
            OBJ_PUT_BYTE('_');
        } else
            OBJ_PUT_BYTE((u8)STRING_LENGTH(p));
        for (; SB(p); p = fp_add(p, 1))
            OBJ_PUT_BYTE(B(p));
    }
}
