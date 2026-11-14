/* objsyms.c: from bcc20/src/output/OBJSYMS.C (overlay CO050): symbol and Turbo Debugger
   records of the object file for C compiles; the C front end's twin of OBJPUBS.C and
   DEBUGREC.C.  It reads the C symbol records (CSYM_POOL_SEG, the C global scope's list
   SCOPE_C_SYMBOLS) and C-layout types (offset 3 is the pointee, or an array count as a
   long).
   - EMIT_OBJ_SYMBOLS (end of module): EXTDEF/COMDEF records for used externals, the extra
     "__turboFloat" external when floating point was used, PUBDEF for publics, LPUBDEF for
     far static functions (overlay or Windows code), export COMENTs, and with -v the debug
     records of all module-level symbols.
   - EMIT_SCOPE_DEBUG_INFO, EMIT_LOCALS_DEBUG_INFO, BCC_DEBUG_VALUE_MARK and
     EMIT_GLOBALS_DEBUG_INFO write -v records as code is generated, through the hook table.
   Turbo Debugger information travels in COMENT (88h) records whose class byte follows a 0
   attribute byte: E0h type of an external, E1h type of a public, E2h struct members, E3h a
   type definition, E4h enum members, E5h a scope start, E6h a list of symbols, E7h end of a
   scope, EBh an external with type, ECh a public with type.  Every type written gets a
   debug index (TYPE_C_DEBUG_INDEX) from DEBUG_TYPE_COUNTER.  In an E6h list each symbol is:
   name, type index, a storage byte (0 static: group, segment, offset follow; 2 auto: frame
   offset; 4 register: register code; 6 typedef; 7 tag; 10 parameter: frame offset; 12
   register parameter), and lists are cut every 63 entries.  C symbol classes used: 1
   public, 2 external, 3 static, 4 static local, 5 auto, 6 parameter, 8 typedef, 9 enum
   constant, 11 tag.  CSYM_FLAGS: 80h used, 800h communal, 1000h in a register, 400h pascal
   name, 2000h '@' name, 100h address taken, 20h for the function flag byte. */
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
#define COMPILER_MODE B(COMPILER_MODE_P)
#define BCC_PACK_FLAG SB(BCC_PACK_FLAG_P)
#define KIND(n) CSYM_B((n), CSYM_CLASS)
#define TYPE(n) CSYM_W((n), CSYM_TYPE)
/* the debug index of a pointer's or function's target type */
#define TARGET_INDEX(node) TYPE_W(TYPE_W((node), TYPE_C_TARGET), TYPE_C_DEBUG_INDEX)

static u16 size_of_type(u16 type) { return (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(type)); }

/* a symbol list COMENT E6h starts */
static void begin_symbol_list(void)
{
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE600);
}

/* a full list (63 entries) is written out and another started */
static void list_room(i16 *count)
{
    if (!(*count & 63)) {
        OBJ_WRITE_RECORD(0x88);
        begin_symbol_list();
        *count = 1;
    }
}

/* the group (or 0) and segment index of segment id segment */
static void put_group_and_segment(u16 segment)
{
    u16 item = FIND_SEGMENT(segment);
    OBJ_PUT_INDEX(SEGDEF_W(item, SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(item, SEGDEF_GROUP), SEGDEF_GROUP) : 0);
    OBJ_PUT_INDEX(SEGDEF_W(item, SEGDEF_INDEX));
}

/* the debug flag byte of a function: 18h, or 98h for calling convention 4, when CSYM_FLAGS
   20h is set; 0 otherwise */
static u8 function_flag(u16 record)
{
    return (TYPE_B(TYPE(record), TYPE_KIND) == 18 && (CSYM_W(record, CSYM_FLAGS) & 0x20))
               ? (TYPE_B(TYPE(record), TYPE_C_CALL_CONV) == 4 ? 0x98 : 0x18) : 0;
}

/* the E6h lists of typedefs (storage 6) and tags (storage 7) of the list at head, after
   count entries already in the record */
static i16 typedefs_and_tags(u16 head, i16 count)
{
    for (u16 record = head; record; record = CSYM_W(record, CSYM_NEXT))
        if (KIND(record) == 8 && TYPE_W(TYPE(record), TYPE_C_DEBUG_INDEX)) {
            list_room(&count);
            ++count;
            WRITE_DEBUG_NAME(CSYM_W(record, CSYM_NAME));
            OBJ_PUT_INDEX(TYPE_W(TYPE(record), TYPE_C_DEBUG_INDEX));
            OBJ_PUT_BYTE(6);
        }
    for (u16 record = head; record; record = CSYM_W(record, CSYM_NEXT))
        if (KIND(record) == 11 && TYPE(record) && TYPE_W(TYPE(record), TYPE_C_DEBUG_INDEX) &&
            CSYM_W(record, CSYM_NAME)) {
            list_room(&count);
            WRITE_DEBUG_NAME(CSYM_W(record, CSYM_NAME));
            OBJ_PUT_INDEX(TYPE_W(TYPE(record), TYPE_C_DEBUG_INDEX));
            OBJ_PUT_BYTE(7);
            ++count;
        }
    return count;
}

/* the E6h list of the statics of the list at head, then its typedefs and tags */
static void module_symbol_lists(u16 head)
{
    begin_symbol_list();
    i16 count = 1;
    for (u16 record = head; record; record = CSYM_W(record, CSYM_NEXT))
        if (KIND(record) == 3) {
            list_room(&count);
            EMIT_DEBUG_SYMBOL_ENTRY(record);
            ++count;
        }
    count = typedefs_and_tags(head, count);
    if (count > 1)
        OBJ_WRITE_RECORD(0x88);
}

/* the end-of-module symbol records for a C compile.  offset is added to the offset of
   symbols without a segment, which are placed in the data segment (probably after its
   initialized data).  External indexes count from 1 in list order and are stored in
   CSYM_OFFSET.  COMDEF entries: name, type 0, 61h far (element count, element size) or 62h
   near (size), lengths as one byte, 81h + word or 88h + dword */
void EMIT_OBJ_SYMBOLS(u16 offset)
{
    u16 head = SCOPE_W(C_GLOBAL_SCOPE, SCOPE_C_SYMBOLS);
    OBJ_RESET_RECORD();
    u16 previous = 0, format = 0, count = 1;
    for (u16 record = head; record; record = CSYM_W(record, CSYM_NEXT)) {
        if (KIND(record) != 2 || !(CSYM_W(record, CSYM_FLAGS) & 0x80))
            continue;
        CSYM_W(record, CSYM_OFFSET) = count++;
        format = (CSYM_W(record, CSYM_FLAGS) & 0x800) ? 0xB0 : 0x8C;
        if (previous && previous != format) {
            OBJ_WRITE_RECORD((u8)previous);
            OBJ_RESET_RECORD();
        }
        previous = format;
        WRITE_LINKER_NAME(record);
        OBJ_PUT_BYTE(0);
        if (CSYM_W(record, CSYM_FLAGS) & 0x800) {
            u16 item = TYPE(record);
            if (CSYM_W(record, CSYM_SEGMENT) != BSS_SEGMENT_ID) {
                OBJ_PUT_BYTE(0x61);
                u32 extent = 1;
                while (TYPE_B(item, TYPE_KIND) == 17) {
                    extent *= TYPE_UL(item, TYPE_C_SIZE);
                    item = TYPE_W(item, TYPE_TARGET);
                }
                if (extent <= 127)
                    OBJ_PUT_BYTE((u8)extent);
                else if (extent <= 32767) {
                    OBJ_PUT_BYTE(0x81);
                    OBJ_PUT_WORD((u16)extent);
                } else {
                    OBJ_PUT_BYTE(0x88);
                    OBJ_PUT_WORD((u16)extent);
                    OBJ_PUT_WORD((u16)(extent >> 16));
                }
            } else
                OBJ_PUT_BYTE(0x62);
            u16 value = size_of_type(item);
            if (value <= 127)
                OBJ_PUT_BYTE((u8)value);
            else {
                OBJ_PUT_BYTE(0x81);
                OBJ_PUT_WORD(value);
            }
        }
        if (OPTION_SOURCE_DEBUG) {
            OBJ_WRITE_RECORD((u8)format);
            EMIT_TYPE_DEBUG_INFO(TYPE(record));
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xE000);
            OBJ_PUT_INDEX(TYPE_W(TYPE(record), TYPE_C_DEBUG_INDEX));
            OBJ_WRITE_RECORD(0x88);
            OBJ_RESET_RECORD();
        } else if (!(count & 127)) {
            OBJ_WRITE_RECORD((u8)format);
            OBJ_RESET_RECORD();
        }
    }
    /* floating point used: an EXTDEF for "__turboFloat", probably to pull in the
       floating-point support from the library */
    if (CODE_OUTPUT_FLAGS & 2) {
        if (previous == 0xB0) {
            OBJ_WRITE_RECORD((u8)format);
            OBJ_RESET_RECORD();
        }
        OBJ_PUT_NAME(STR_TURBOFLOAT_2_P);
        OBJ_PUT_BYTE(0);
        OBJ_WRITE_RECORD(0x8C);
    } else if (previous)
        OBJ_WRITE_RECORD((u8)previous);
    for (u16 record = head; record; record = CSYM_W(record, CSYM_NEXT)) {
        if (KIND(record) == 1) {
            OBJ_RESET_RECORD();
            u16 value = CSYM_W(record, CSYM_SEGMENT);
            if (!value) {
                value = DATA_SEGMENT_ID;
                CSYM_W(record, CSYM_SEGMENT) = value;
                CSYM_W(record, CSYM_OFFSET) += offset;
            }
            u16 handle = FIND_SEGMENT(value);
            count = SEGDEF_W(handle, SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(handle, SEGDEF_GROUP), SEGDEF_GROUP) : 0;
            OBJ_PUT_BYTE((u8)count);
            OBJ_PUT_BYTE((u8)value);
            WRITE_LINKER_NAME(record);
            OBJ_PUT_WORD(CSYM_W(record, CSYM_OFFSET));
            OBJ_PUT_BYTE(0);
            OBJ_WRITE_RECORD(0x90);
            if (OPTION_SOURCE_DEBUG) {
                u16 type = TYPE(record);
                EMIT_TYPE_DEBUG_INFO(type);
                OBJ_RESET_RECORD();
                OBJ_PUT_WORD(0xE100);
                OBJ_PUT_INDEX(TYPE_W(type, TYPE_C_DEBUG_INDEX));
                OBJ_PUT_BYTE(function_flag(record));
                OBJ_WRITE_RECORD(0x88);
            }
            if (TYPE_B(TYPE(record), TYPE_KIND) == 18 && (TYPE_B(TYPE(record), TYPE_C_FUNC_FLAGS) & 0x80)) {
                OBJ_RESET_RECORD();
                OBJ_PUT_WORD(0xA000);
                OBJ_PUT_WORD(2);
                WRITE_LINKER_NAME(record);
                OBJ_PUT_BYTE(0);
                OBJ_WRITE_RECORD(0x88);
            }
        } else if (KIND(record) == 3) {
            if (!CSYM_W(record, CSYM_SEGMENT)) {
                CSYM_W(record, CSYM_SEGMENT) = DATA_SEGMENT_ID;
                CSYM_W(record, CSYM_OFFSET) += offset;
            }
            if ((OPTION_OVERLAY_CODE | OPTION_WINDOWS_MODE) && TYPE_B(TYPE(record), TYPE_KIND) == 18 &&
                (TYPE_B(TYPE(record), TYPE_C_FUNC_FLAGS) & 1) && (CSYM_W(record, CSYM_FLAGS) & 0x100)) {
                OBJ_RESET_RECORD();
                u16 value = CSYM_W(record, CSYM_SEGMENT);
                u16 handle = FIND_SEGMENT(value);
                count = SEGDEF_W(handle, SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(handle, SEGDEF_GROUP), SEGDEF_GROUP) : 0;
                OBJ_PUT_BYTE((u8)count);
                OBJ_PUT_BYTE((u8)value);
                WRITE_LINKER_NAME(record);
                OBJ_PUT_WORD(CSYM_W(record, CSYM_OFFSET));
                OBJ_PUT_BYTE(0);
                OBJ_WRITE_RECORD(0xB6);
            }
        }
    }
    /* -v: types of all statics, then E6h lists of statics, typedefs and tags */
    if (OPTION_SOURCE_DEBUG) {
        for (u16 record = head; record; record = CSYM_W(record, CSYM_NEXT))
            if (KIND(record) == 3)
                EMIT_TYPE_DEBUG_INFO(TYPE(record));
        module_symbol_lists(head);
    }
}

/* the text of the tag name of struct, union or enum type node */
static farptr tag_name(u16 node)
{
    u16 name = CSYM_W(TYPE_W(node, TYPE_C_TAG_SYMBOL), CSYM_NAME);
    return MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET));
}

/* writes the debug record (COMENT E3h) of C type node once, giving it the next debug
   index; types it refers to are written first (recursively).  Record: index, name (the tag
   name or ""), size, then a type code: 22h enum (range 8000h..7FFFh, with its member list
   in E4h), 1Eh struct or 1Fh union (members in E2h), 1Ah array, 15h near pointer (30h for a
   based pointer, with the base name), 17h segment pointer, 16h far (flag 0) or huge (flag
   1) pointer, 23h function (calling convention, far bit, varargs).  A struct or union
   without a body gets index 1.  Other kinds (scalars, which normally carry a fixed index
   already) give the counter back and write nothing */
void EMIT_TYPE_DEBUG_INFO(u16 node)
{
    if (TYPE_W(node, TYPE_C_DEBUG_INDEX))
        return;
    farptr name = fp_add(STR_TURBOFLOAT_2_P, 12);
    i16 kind = 0;
    TYPE_W(node, TYPE_C_DEBUG_INDEX) = DEBUG_TYPE_COUNTER++;
    switch (TYPE_B(node, TYPE_KIND)) {
    case 21:
        EMIT_ENUM_DEBUG_INFO(node);
        if (TYPE_W(node, TYPE_C_TAG_SYMBOL))
            name = tag_name(node);
        break;
    case 19:
    case 20:
        if (!TYPE_W(node, TYPE_TAG_BODY)) {
            TYPE_W(node, TYPE_C_DEBUG_INDEX) = 1;
            --DEBUG_TYPE_COUNTER;
            return;
        }
        kind = TYPE_B(node, TYPE_C_BYTE9) == 1 ? 30 : 31;
        EMIT_STRUCT_DEBUG_INFO(node, (u16)kind);
        if (TYPE_W(node, TYPE_C_TAG_SYMBOL))
            name = tag_name(node);
        break;
    case 17:
        EMIT_TYPE_DEBUG_INFO(TYPE_W(node, TYPE_TARGET));
        break;
    case 13:
        if (TYPE_W(node, TYPE_TAG_BODY))
            ++DEBUG_TYPE_COUNTER;
        /* fall through */
    case 14: case 15: case 16: case 18:
        EMIT_TYPE_DEBUG_INFO(TYPE_W(node, TYPE_C_TARGET));
        break;
    default:
        --DEBUG_TYPE_COUNTER;
        return;
    }
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE300);
    OBJ_PUT_INDEX(TYPE_W(node, TYPE_C_DEBUG_INDEX));
    OBJ_PUT_NAME(name);
    OBJ_PUT_WORD(size_of_type(node));
    switch (TYPE_B(node, TYPE_KIND)) {
    case 21:
        OBJ_PUT_BYTE(0x22);
        OBJ_PUT_BYTE(0);
        OBJ_PUT_WORD(0x8000);
        OBJ_PUT_WORD(0x7FFF);
        ++DEBUG_TYPE_COUNTER;
        break;
    case 19:
    case 20:
        OBJ_PUT_BYTE((u8)kind);
        break;
    case 17:
        OBJ_PUT_BYTE(0x1A);
        OBJ_PUT_INDEX(TYPE_W(TYPE_W(node, TYPE_TARGET), TYPE_C_DEBUG_INDEX));
        break;
    case 13:
        OBJ_PUT_BYTE(TYPE_W(node, TYPE_TAG_BODY) ? 0x30 : 0x15);
        OBJ_PUT_INDEX(TARGET_INDEX(node));
        if (TYPE_W(node, TYPE_TAG_BODY)) {
            STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(POOL_HASH, TYPE_W(node, TYPE_TAG_BODY)));
            OBJ_PUT_NAME(BCC_DEBUG_NAME_P);
        } else
            OBJ_PUT_BYTE(TYPE_B(node, TYPE_C_FUNC_FLAGS));
        break;
    case 14:
        OBJ_PUT_BYTE(0x17);
        OBJ_PUT_INDEX(TARGET_INDEX(node));
        OBJ_PUT_BYTE(0);
        break;
    case 15:
        OBJ_PUT_BYTE(0x16);
        OBJ_PUT_INDEX(TARGET_INDEX(node));
        OBJ_PUT_BYTE(0);
        break;
    case 16:
        OBJ_PUT_BYTE(0x16);
        OBJ_PUT_INDEX(TARGET_INDEX(node));
        OBJ_PUT_BYTE(1);
        break;
    case 18: {
        i16 bits = ((i8)TYPE_B(node, TYPE_C_CALL_CONV) - 1) & 3;
        if (TYPE_B(node, TYPE_C_FUNC_FLAGS) & 1)
            bits |= 4;
        OBJ_PUT_BYTE(0x23);
        OBJ_PUT_INDEX(TARGET_INDEX(node));
        OBJ_PUT_BYTE((u8)bits);
        OBJ_PUT_BYTE(TYPE_B(node, TYPE_C_FUNC_FLAGS) & 4 ? 1 : 0);
        break;
    }
    }
    OBJ_WRITE_RECORD(0x88);
}

/* COMENT E4h list of enum members: a flag byte (80h on the last), name, value (the
   member's MEMB_FLAGS word holds the value in the C layout).  Records are cut at about 210
   bytes */
void EMIT_ENUM_DEBUG_INFO(u16 node)
{
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE400);
    for (u16 item = TYPE_W(node, TYPE_TAG_BODY); item; item = MEMBER_W(item, MEMB_NEXT)) {
        if (OBJ_RECORD_LENGTH() > 210) {
            OBJ_WRITE_RECORD(0x88);
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xE400);
        }
        OBJ_PUT_BYTE(MEMBER_W(item, MEMB_NEXT) ? 0 : 0x80);
        WRITE_DEBUG_NAME(MEMBER_W(item, MEMB_NAME));
        OBJ_PUT_WORD(MEMBER_W(item, MEMB_FLAGS));
    }
    OBJ_WRITE_RECORD(0x88);
}

/* COMENT E2h list of struct or union members: types first, then per member a byte (bit
   width for a bit field, 80h added on the last member), name and type index.  For a struct
   (kind 30), gaps before a member's offset are written as a padding entry (gap in bits and
   two zero bytes).  Bit fields advance the position by bytes, or by words when
   BCC_PACK_FLAG is set.  Records are cut at about 214 bytes */
void EMIT_STRUCT_DEBUG_INFO(u16 node, u16 kind)
{
    u16 position = 0;
    i16 bits = 0;
    for (u16 item = TYPE_W(node, TYPE_TAG_BODY); item; item = MEMBER_W(item, MEMB_NEXT))
        EMIT_TYPE_DEBUG_INFO(MEMBER_W(item, MEMB_C_TYPE));
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE200);
    for (u16 item = TYPE_W(node, TYPE_TAG_BODY); item; item = MEMBER_W(item, MEMB_NEXT)) {
        if (kind == 30 && MEMBER_W(item, MEMB_FLAGS) != position) {
            i16 delta = (i16)(MEMBER_W(item, MEMB_FLAGS) - position);
            OBJ_PUT_BYTE((u8)((u8)delta * 8 - (u8)bits));
            OBJ_PUT_BYTE(0);
            OBJ_PUT_BYTE(0);
            position = MEMBER_W(item, MEMB_FLAGS);
            bits = 0;
        }
        if (OBJ_RECORD_LENGTH() > 214) {
            OBJ_WRITE_RECORD(0x88);
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xE200);
        }
        if (MEMBER_B(item, MEMB_C_BIT_WIDTH) == 0) {
            OBJ_PUT_BYTE(MEMBER_W(item, MEMB_NEXT) ? 0 : 0x80);
            position += size_of_type(MEMBER_W(item, MEMB_C_TYPE));
            bits = 0;
        } else {
            i16 delta = (i8)MEMBER_B(item, MEMB_C_BIT_WIDTH);
            OBJ_PUT_BYTE((u8)((u8)delta + (MEMBER_W(item, MEMB_NEXT) ? 0 : 0x80)));
            bits += delta;
            if (BCC_PACK_FLAG) {
                if (bits >= 16) {
                    position += 2;
                    bits = 0;
                }
            } else
                while (bits >= 8) {
                    position++;
                    bits -= 8;
                }
        }
        WRITE_DEBUG_NAME(MEMBER_W(item, MEMB_NAME));
        OBJ_PUT_INDEX(TYPE_W(MEMBER_W(item, MEMB_C_TYPE), TYPE_C_DEBUG_INDEX));
    }
    OBJ_WRITE_RECORD(0x88);
}

/* appends one static symbol to an E6h list: name, type index, flag byte (18h/98h for
   functions with flag 20h), group, segment and offset.  Functions are skipped in assembly
   mode */
void EMIT_DEBUG_SYMBOL_ENTRY(u16 node)
{
    u8 flags = 0;
    if (TYPE_B(TYPE(node), TYPE_KIND) == TK_FUNCTION) {
        if (COMPILER_MODE)
            return;
        if (CSYM_W(node, CSYM_FLAGS) & 0x20)
            flags |= TYPE_B(TYPE(node), TYPE_C_CALL_CONV) == 4 ? 0x98 : 0x18;
    }
    WRITE_DEBUG_NAME(CSYM_W(node, CSYM_NAME));
    OBJ_PUT_INDEX(TYPE_W(TYPE(node), TYPE_C_DEBUG_INDEX));
    OBJ_PUT_BYTE(flags);
    put_group_and_segment(CSYM_W(node, CSYM_SEGMENT));
    OBJ_PUT_WORD(CSYM_W(node, CSYM_OFFSET));
}

/* appends the linker spelling of C symbol node as a length-prefixed name: upper case for
   pascal (400h), '@' prefix for flag 2000h, else '_' prefix under -u */
void WRITE_LINKER_NAME(u16 node)
{
    u16 name = CSYM_W(node, CSYM_NAME);
    farptr p = STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(W(DSPTR(NAME_W(name, NAME_TEXT_BANK))), NAME_W(name, NAME_TEXT_OFFSET)));
    if (CSYM_W(node, CSYM_FLAGS) & 0x400) {
        OBJ_PUT_BYTE((u8)STRING_LENGTH(p));
        for (; SB(p); p = fp_add(p, 1))
            OBJ_PUT_BYTE((u8)RTL_TOUPPER(SB(p)));
        return;
    }
    if (CSYM_W(node, CSYM_FLAGS) & 0x2000) {
        OBJ_PUT_BYTE((u8)(STRING_LENGTH(p) + 1));
        OBJ_PUT_BYTE('@');
    } else if (OPTION_UNDERSCORES) {
        OBJ_PUT_BYTE((u8)(STRING_LENGTH(p) + 1));
        OBJ_PUT_BYTE('_');
    } else
        OBJ_PUT_BYTE((u8)STRING_LENGTH(p));
    for (; SB(p); p = fp_add(p, 1))
        OBJ_PUT_BYTE(B(p));
}

/* COMENT E5h with the code segment and offset value, probably the start of a debug scope
   (block) */
void BCC_DEBUG_VALUE_MARK(u16 value)
{
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE500);
    OBJ_PUT_BYTE(B(CODE_SEGMENT_ID_P));
    OBJ_PUT_WORD(value);
    OBJ_WRITE_RECORD(0x88);
}

/* a symbol a scope's debug list leaves out: an auto neither in a register nor used */
static int unused_auto(u16 record)
{
    return CSYM_B(record, CSYM_CLASS) == 5 && !(CSYM_W(record, CSYM_FLAGS) & 0x1000) &&
           !(CSYM_W(record, CSYM_FLAGS) & 0xC0);
}

static int global_class(u16 record)
{
    return CSYM_B(record, CSYM_CLASS) == 2 || CSYM_B(record, CSYM_CLASS) == 3 || CSYM_B(record, CSYM_CLASS) == 9;
}

/* writes the debug symbols of C scope list as E6h records (types first) and closes the
   scope with an E7h record holding the current code offset (not in assembly mode).  list
   -2 only writes the E7h end.  Skipped: externals, statics, enum constants, and autos that
   are neither in a register nor used */
void EMIT_SCOPE_DEBUG_INFO(i16 list)
{
    if (list == -2) {
        if (!COMPILER_MODE)
            EMIT_DEBUG_SYMBOLS_END();
        return;
    }
    for (u16 record = SCOPE_W(list, SCOPE_C_SYMBOLS); record; record = CSYM_W(record, CSYM_NEXT)) {
        if (unused_auto(record))
            continue;
        if (!global_class(record) && CSYM_W(record, CSYM_NAME) && CSYM_W(record, CSYM_TYPE))
            EMIT_TYPE_DEBUG_INFO(CSYM_W(record, CSYM_TYPE));
    }
    begin_symbol_list();
    i16 count = 1;
    for (u16 record = SCOPE_W(list, SCOPE_C_SYMBOLS); record; record = CSYM_W(record, CSYM_NEXT)) {
        if (unused_auto(record))
            continue;
        if (!CSYM_W(record, CSYM_TYPE) || !CSYM_W(record, CSYM_NAME))
            continue;
        if (global_class(record))
            continue;
        list_room(&count);
        ++count;
        WRITE_DEBUG_NAME(CSYM_W(record, CSYM_NAME));
        OBJ_PUT_INDEX(TYPE_W(CSYM_W(record, CSYM_TYPE), TYPE_C_DEBUG_INDEX));
        switch (CSYM_B(record, CSYM_CLASS)) {
        case 4:
            OBJ_PUT_BYTE(0);
            put_group_and_segment(CSYM_W(record, CSYM_SEGMENT));
            OBJ_PUT_WORD(CSYM_W(record, CSYM_OFFSET));
            break;
        case 5:
        case 6: {
            int parameter = CSYM_B(record, CSYM_CLASS) == 6;
            if (CSYM_W(record, CSYM_FLAGS) & 0x1000) {
                OBJ_PUT_BYTE(parameter ? 12 : 4);
                OBJ_PUT_BYTE((u8)BCC_TOKEN_FLAG((i8)CSYM_B(record, CSYM_SEGMENT)));
            } else {
                OBJ_PUT_BYTE(parameter ? 10 : 2);
                OBJ_PUT_WORD(CSYM_W(record, CSYM_OFFSET));
            }
            break;
        }
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
        EMIT_DEBUG_SYMBOLS_END();
}

/* writes the parameters of the current function (variable table entries of kind 6 in the
   outer scope block, walked from the end) as an E6h list with storage 10 and their frame
   offsets.  A float parameter of a function without prototype list is given type index
   15, probably double, since it is passed as a double */
void EMIT_LOCALS_DEBUG_INFO(void)
{
    for (u16 item = 2; item < VARIABLE_TABLE_END; item += 29)
        if (VAR_B(item, VAR_SYMBOL_KIND) == 6 && CSYM_W(VAR_W(item, VAR_SYMBOL), CSYM_NAME))
            EMIT_TYPE_DEBUG_INFO(VAR_W(item, VAR_TYPE));
    begin_symbol_list();
    i16 count = 1;
    for (u16 item = VARIABLE_TABLE_END; item > 2;) {
        item -= 29;
        if (VAR_B(item, VAR_SYMBOL_KIND) != 6 || !CSYM_W(VAR_W(item, VAR_SYMBOL), CSYM_NAME) ||
            VAR_W(item, VAR_SCOPE_BLOCK) != FUNCTION_OUTER_SCOPE_BLOCK)
            continue;
        list_room(&count);
        count++;
        WRITE_DEBUG_NAME(CSYM_W(VAR_W(item, VAR_SYMBOL), CSYM_NAME));
        if (TYPE_B(VAR_W(item, VAR_TYPE), TYPE_KIND) == 9 && !CODEGEN_PARAM_LIST)
            OBJ_PUT_BYTE(15);
        else
            OBJ_PUT_INDEX(TYPE_W(VAR_W(item, VAR_TYPE), TYPE_C_DEBUG_INDEX));
        OBJ_PUT_BYTE(10);
        OBJ_PUT_WORD(VAR_W(item, VAR_FRAME_OFFSET));
    }
    if (count > 1)
        OBJ_WRITE_RECORD(0x88);
}

/* COMENT E7h with the current size of the selected segment: the end of a scope */
void EMIT_DEBUG_SYMBOLS_END(void)
{
    u16 saved = SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE);
    OBJ_RESET_RECORD();
    OBJ_PUT_WORD(0xE700);
    OBJ_PUT_WORD(saved);
    OBJ_WRITE_RECORD(0x88);
}

/* debug records for all module-level symbols without writing EXTDEF/PUBDEF (probably for
   assembly output, where TASM writes those): EBh for used externals and ECh for publics,
   each with type; then the E6h lists of statics, typedefs and tags as in
   EMIT_OBJ_SYMBOLS */
void EMIT_GLOBALS_DEBUG_INFO(void)
{
    u16 head = SCOPE_W(C_GLOBAL_SCOPE, SCOPE_C_SYMBOLS);
    for (u16 record = head; record; record = CSYM_W(record, CSYM_NEXT)) {
        if (KIND(record) == 2 && (CSYM_W(record, CSYM_FLAGS) & 0x80)) {
            EMIT_TYPE_DEBUG_INFO(TYPE(record));
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xEB00);
            WRITE_LINKER_NAME(record);
            OBJ_PUT_INDEX(TYPE_W(TYPE(record), TYPE_C_DEBUG_INDEX));
            OBJ_WRITE_RECORD(0x88);
        } else if (KIND(record) == 1) {
            EMIT_TYPE_DEBUG_INFO(TYPE(record));
            OBJ_RESET_RECORD();
            OBJ_PUT_WORD(0xEC00);
            WRITE_LINKER_NAME(record);
            OBJ_PUT_INDEX(TYPE_W(TYPE(record), TYPE_C_DEBUG_INDEX));
            OBJ_PUT_BYTE(function_flag(record));
            OBJ_WRITE_RECORD(0x88);
        } else if (KIND(record) == 3)
            EMIT_TYPE_DEBUG_INFO(TYPE(record));
    }
    module_symbol_lists(head);
}

/* appends the text of NAME_POOL record node as a length-prefixed name (copied through
   BCC_DEBUG_NAME) */
void WRITE_DEBUG_NAME(u16 node)
{
    STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(W(DSPTR(NAME_W(node, NAME_TEXT_BANK))), NAME_W(node, NAME_TEXT_OFFSET)));
    OBJ_PUT_NAME(BCC_DEBUG_NAME_P);
}
