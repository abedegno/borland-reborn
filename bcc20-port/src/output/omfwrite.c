/* omfwrite.c: from bcc20/src/output/OMFWRITE.C (overlay CO055): the OMF (Intel/Microsoft
   object module format) writer that produces the .obj file when BCC compiles straight to an
   object (COMPILER_MODE 0).
   Building records: a record body is collected in a near buffer that reuses
   TOKEN_TEXT_BUFFER (OBJ_RECORD_BUFFER returns it; OBJ_RECORD_CURSOR is the near pointer to
   the next byte); OBJ_RESET_RECORD empties it, OBJ_PUT_BYTE / WORD / INDEX / NAME append,
   and OBJ_WRITE_RECORD(type) writes "type, length, body, checksum" through the buffered
   output file (OUTPUT_CHAR).  When assembly text is written instead (COMPILER_MODE set)
   OBJ_WRITE_RECORD hands the body to OBJ_RECORD_HOOK, which writes it as a "?debug C" line,
   so debug records reach TASM unchanged.  OBJ_BEGIN_RECORD / OBJ_OUT_BYTE / OBJ_END_RECORD
   write a record directly to the file, keeping the checksum, for records too big for the
   buffer (LEDATA, file stamps).
   Record types used: 80h THEADR, 88h COMENT, 8Ah MODEND, 94h LINNUM, 96h LNAMES, 98h
   SEGDEF, 9Ah GRPDEF, 9Ch FIXUPP, A0h LEDATA, B0h COMDEF.  COMENT classes (the second byte;
   the first, attribute, is 0): 00h translator name, E8h source file, E9h dependency (file
   time and name), EAh Turbo Debugger version and memory model, EEh a list of code offsets,
   A1h written for overlay code.
   OBJ_WRITE_MODULE writes the whole module at the end: the string literals into the data
   segment, LNAMES, SEGDEF, GRPDEF, the external and public records (OBJ_WRITE_MODULE_HOOK),
   the data of every segment with its fixups, the line numbers, and MODEND. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define COMPILER_MODE B(COMPILER_MODE_P)
#define OPTION_OVERLAY_CODE B(OPTION_OVERLAY_CODE_P)
#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)
#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define OPTION_UNDERSCORES B(OPTION_UNDERSCORES_P)
#define OPTION_FLAGS B(OPTION_FLAGS_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define DATA_BYTE_POOL_SEG W(DATA_BYTE_POOL_SEG_P)
#define SEGMENT_LIST_HEAD W(SEGMENT_LIST_HEAD_P)
#define NODE_SERIAL_COUNTER W(NODE_SERIAL_COUNTER_P)
#define OBJ_RECORD_HOOK D(OBJ_RECORD_HOOK_P)

#define CURSOR OBJ_RECORD_CURSOR
#define BUFFER FP_OFF(TOKEN_TEXT_BUFFER_P)
/* a string-pool name whose offset is at offset o of segment record n (11h SEGDEF_NAME, 0Ah
   SEGDEF_CLASS_NAME, 4 a group's name) */
#define NAME(n, o) MK_FP(STRING_POOL_SEG, SEGDEF_W((n), (o)))
/* the segment word of a segment's data buffer, through its heap handle */
#define BUFFER_SEGMENT(r) W(D(MK_FP(SEGDEF_POOL_SEG, (r) + SEGDEF_BUFFER_HANDLE)))

/* the next record byte, as an lvalue, then the cursor moves past it */
static void put_raw_byte(u8 value) { B(DSPTR(CURSOR)) = value; CURSOR++; }
static void put_raw_word(u16 value) { W(DSPTR(CURSOR)) = value; CURSOR += 2; }

/* starts a new record body at the start of the buffer */
void OBJ_RESET_RECORD(void)
{
    CURSOR = BUFFER;
}

void OBJ_PUT_BYTE(u8 value)
{
    put_raw_byte(value);
}

/* appends an OMF index: one byte below 128, else two bytes with bit 7 set in the first
   (high byte first) */
void OBJ_PUT_INDEX(u16 value)
{
    if (value > 127) {
        OBJ_PUT_BYTE((u8)(0x80 | (value >> 8)));
        value &= 0xFF;
    }
    OBJ_PUT_BYTE((u8)value);
}

/* the number of bytes in the record body so far */
i16 OBJ_RECORD_LENGTH(void)
{
    return (i16)(CURSOR - BUFFER);
}

/* appends a length-prefixed name */
void OBJ_PUT_NAME(farptr text)
{
    OBJ_PUT_BYTE((u8)STRING_LENGTH(text));
    for (; SB(text); text = fp_add(text, 1))
        OBJ_PUT_BYTE(B(text));
}

void OBJ_PUT_WORD(u16 value)
{
    OBJ_PUT_BYTE((u8)value);
    OBJ_PUT_BYTE((u8)(value >> 8));
}

/* writes the collected body as a record of type type (nothing if the body is empty).  The
   length field counts the body plus the checksum byte.  In assembly mode the body goes to
   OBJ_RECORD_HOOK with its length instead.  Does not reset the buffer */
void OBJ_WRITE_RECORD(u8 type)
{
    i16 length = (i16)(CURSOR - BUFFER);
    if (length <= 0)
        return;
    if (COMPILER_MODE)
        CALL_FAR(OBJ_RECORD_HOOK, A16(length));
    else {
        OBJ_BEGIN_RECORD(type, length + 1);
        for (u16 p = BUFFER; CURSOR > p; ++p)
            OBJ_OUT_BYTE(B(DSPTR(p)));
        OBJ_END_RECORD();
    }
}

/* queues one word (a code offset, under -v) for OBJ_FLUSH_QUEUED_WORDS */
void OBJ_QUEUE_WORD(u16 value)
{
    u16 node = POOL_ALLOC(QUEUED_WORD_POOL_SEG_P, 2);
    QWORD_W(node, QWORD_VALUE) = value;
}

/* a COMENT body of class EEh: the selected segment's index follows */
static void begin_offsets_comment(void)
{
    CURSOR = BUFFER;
    put_raw_word(0xEE00);
    OBJ_PUT_INDEX(SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_INDEX));
}

/* writes the queued words as COMENT class EEh records: segment index of the selected
   segment, then up to 1024 words per record.  Empties the queue */
void OBJ_FLUSH_QUEUED_WORDS(void)
{
    if (!QUEUED_WORD_POOL_USED)
        return;
    begin_offsets_comment();
    i16 count = 0;
    for (u16 offset = 0; offset < QUEUED_WORD_POOL_USED; offset += 2) {
        if (count > 1023) {
            OBJ_WRITE_RECORD(0x88);
            begin_offsets_comment();
            count = 0;
        }
        put_raw_word(QWORD_W(offset, QWORD_VALUE));
        ++count;
    }
    OBJ_WRITE_RECORD(0x88);
    QUEUED_WORD_POOL_FREE = 0;
    QUEUED_WORD_POOL_USED = 0;
}

/* writes a COMENT class E8h naming source file record node (the first record of the same
   file is used).  The first time: byte 0, the name and the file's time stamp, and the file
   gets the next free debug index (largest so far + 1); later times: just that index.  The
   80-byte path copy sits at bp-56h in BCC's frame */
void OBJ_WRITE_FILE_ENTRY(u16 node)
{
    u16 maximum = 0;
    CURSOR = BUFFER;
    put_raw_word(0xE800);
    if (SRCFILE_W(node, SRCFILE_FIRST_NODE))
        node = SRCFILE_W(node, SRCFILE_FIRST_NODE);
    if (!SRCFILE_W(node, SRCFILE_DEBUG_INDEX)) {
        put_raw_byte(0);
        OBJ_PUT_NAME(MK_FP(STRING_POOL_SEG, SRCFILE_W(node, SRCFILE_NAME)));
        u16 mark = scratch_mark();
        farptr path = scratch_alloc(0x56);
        STRING_COPY(path, MK_FP(STRING_POOL_SEG, SRCFILE_W(node, SRCFILE_NAME)));
        u32 stamp = (u32)FILE_TIME(path);
        scratch_release(mark);
        put_raw_byte((u8)stamp);
        put_raw_byte((u8)(stamp >> 8));
        put_raw_byte((u8)(stamp >> 16));
        put_raw_byte((u8)(stamp >> 24));
        for (u16 item = 2; item < SEGMENT_POOL_USED; item += 14)
            if (SRCFILE_W(item, SRCFILE_DEBUG_INDEX) > maximum)
                maximum = SRCFILE_W(item, SRCFILE_DEBUG_INDEX);
        SRCFILE_W(node, SRCFILE_DEBUG_INDEX) = maximum + 1;
    } else
        OBJ_PUT_INDEX(SRCFILE_W(node, SRCFILE_DEBUG_INDEX));
    OBJ_WRITE_RECORD(0x88);
}

/* a LINNUM body: group and segment index */
static void begin_line_numbers(u16 section, u16 segment)
{
    CURSOR = BUFFER;
    OBJ_PUT_INDEX(section);
    OBJ_PUT_INDEX(segment);
}

/* writes the LINNUM records: code segments in ascending order; for each source file record
   with lines in that segment, a file entry and then (line, offset) pairs, at most 1000 per
   record, preceded by group and segment index.  Clears each record's line count as it
   goes.  With no lines at all only the main file's entry (record 2) is written.
   NODE_SERIAL_COUNTER is reset to 0 here */
void OBJ_WRITE_LINE_NUMBERS(void)
{
    i16 any = 0;
    NODE_SERIAL_COUNTER = 0;
    for (u16 node = 2; node < SEGMENT_POOL_USED; node += 14) {
        if (SRCFILE_W(node, SRCFILE_LINE_COUNT)) {
            any = 1;
            break;
        }
        SRCFILE_W(node, SRCFILE_SERIAL) = 0;
    }
    if (!any && SEGMENT_POOL_USED > 2) {
        OBJ_WRITE_FILE_ENTRY(2);
        return;
    }
    for (;;) {
        u16 minimum = 0xFFFF, node = 0;
        for (u16 index = 2; index < SEGMENT_POOL_USED; index += 14)
            if (SRCFILE_W(index, SRCFILE_LINE_COUNT) && SRCFILE_W(index, SRCFILE_SEGMENT) < minimum) {
                node = index;
                minimum = SRCFILE_W(index, SRCFILE_SEGMENT);
            }
        if (!node)
            break;
        for (; node < SEGMENT_POOL_USED; node += 14) {
            if (!SRCFILE_W(node, SRCFILE_LINE_COUNT) || SRCFILE_W(node, SRCFILE_SEGMENT) != minimum)
                continue;
            i16 remaining = (i16)SRCFILE_W(node, SRCFILE_LINE_COUNT);
            SRCFILE_W(node, SRCFILE_LINE_COUNT) = 0;
            OBJ_WRITE_FILE_ENTRY(node);
            i16 count = 0;
            u16 record = FIND_SEGMENT(SRCFILE_W(node, SRCFILE_SEGMENT));
            u16 section = record && SEGDEF_W(record, SEGDEF_GROUP) ? SEGDEF_W(SEGDEF_W(record, SEGDEF_GROUP), SEGDEF_GROUP) : 0;
            begin_line_numbers(section, SRCFILE_W(node, SRCFILE_SEGMENT));
            u16 position = SRCFILE_W(node, SRCFILE_FIRST_LINE);
            while (--remaining >= 0) {
                if (count >= 1000) {
                    OBJ_WRITE_RECORD(0x94);
                    begin_line_numbers(section, SRCFILE_W(node, SRCFILE_SEGMENT));
                    count = 0;
                }
                put_raw_word(LINENUM_W(position, LINENUM_LINE));
                put_raw_word(LINENUM_W(position, LINENUM_OFFSET));
                position += 4;
                ++count;
            }
            OBJ_WRITE_RECORD(0x94);
        }
    }
}

/* starts the object file: THEADR with the module name text, a translator COMENT "TC86
   Borland Turbo C++ 2.0", and for overlay code a COMENT class A1h with the bytes 01h, 'T',
   'D' */
void OBJ_WRITE_MODULE_HEADER(farptr text)
{
    CURSOR = BUFFER;
    OBJ_PUT_NAME(text);
    OBJ_WRITE_RECORD(0x80);
    CURSOR = BUFFER;
    put_raw_word(0);
    OBJ_PUT_NAME(STR_TC86_BORLAND_TURBO_C_2_0_P);
    OBJ_WRITE_RECORD(0x88);
    if (OPTION_OVERLAY_CODE) {
        CURSOR = BUFFER;
        put_raw_word(0xA100);
        put_raw_byte(1);
        put_raw_word(0x4454);
        OBJ_WRITE_RECORD(0x88);
    }
}

/* writes a dependency COMENT (class E9h: file time, name length, name) for source file
   text, unless auto-dependencies are off */
void OBJ_WRITE_FILE_STAMP(farptr text)
{
    if (OPTION_NO_AUTODEPEND != 0)
        return;
    u16 length = STRING_LENGTH(text);
    OBJ_BEGIN_RECORD(0x88, length + 8);
    OBJ_OUT_BYTE(0);
    OBJ_OUT_BYTE(0xE9);
    u32 stamp = (u32)FILE_TIME(text);
    OBJ_OUT_BYTE((u8)stamp);
    OBJ_OUT_BYTE((u8)(stamp >> 8));
    OBJ_OUT_BYTE((u8)(stamp >> 16));
    OBJ_OUT_BYTE((u8)(stamp >> 24));
    OBJ_OUT_BYTE((u8)length);
    for (farptr p = text; SB(p); p = fp_add(p, 1))
        OBJ_OUT_BYTE(B(p));
    OBJ_END_RECORD();
}

/* writes everything after the code.  The literal pool (DATA_BYTE_POOL_SEG) is appended to
   the data segment and the string-literal symbol placed at its start; saved, the data
   segment size before that, is passed to the extern/public writer.  An empty E9h COMENT
   ends the dependency list (unless OPTION_NO_AUTODEPEND).  LNAMES holds "", then name and
   class of every real segment, then the group names, so segment k's names are indexes 2k
   and 2k+1 and the groups follow.  SEGDEF attribute byte: alignment in bits 5-7 (paragraph
   alignment 16 is stored as 3), 2 = exactly 64 KB, 8 = public combine.  A virtual segment
   (SEGDEF_PARENT_ID set) is written as a B0h record naming its parent segment.  A group
   over 64 KB is fatal ("Group overflowed maximum size"); its name is copied to the 64-byte
   buffer at bp-4Ch in BCC's frame for the message */
void OBJ_WRITE_MODULE(void)
{
    SELECT_SEGMENT(DATA_SEGMENT_ID);
    SET_SYMBOL_AT_CURRENT_POS((u16)CALL_FAR0(STRING_LITERAL_SYMBOL_HOOK));
    u16 saved = SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE);
    for (u16 position = 0, count = 0; count < DATA_BYTE_POOL_LENGTH; ++position, ++count)
        EMIT_DATA_BYTE(B(MK_FP(DATA_BYTE_POOL_SEG, position)));
    if (!OPTION_NO_AUTODEPEND) {
        CURSOR = BUFFER;
        put_raw_word(0xE900);
        OBJ_WRITE_RECORD(0x88);
    }
    CURSOR = BUFFER;
    put_raw_word(0xEA00);
    put_raw_byte(OPTION_FLAGS ? 5 : 1);
    put_raw_byte((u8)(OPTION_MEMORY_MODEL | (OPTION_UNDERSCORES << 3)));
    OBJ_WRITE_RECORD(0x88);
    CURSOR = BUFFER;
    put_raw_byte(0);
    for (u16 node = SEGMENT_LIST_HEAD; node; node = SEGDEF_W(node, SEGDEF_NEXT))
        if (!SEGDEF_W(node, SEGDEF_PARENT_ID)) {
            OBJ_PUT_NAME(NAME(node, 17));
            OBJ_PUT_NAME(NAME(node, 10));
        }
    for (u16 group = GROUP_LIST_HEAD; group; group = SEGDEF_W(group, SEGDEF_NEXT))
        OBJ_PUT_NAME(NAME(group, 4));
    OBJ_WRITE_RECORD(0x96);
    u16 index = 2;
    for (u16 node = SEGMENT_LIST_HEAD; node; node = SEGDEF_W(node, SEGDEF_NEXT)) {
        if (SEGDEF_W(node, SEGDEF_PARENT_ID))
            continue;
        CURSOR = BUFFER;
        if (SEGDEF_B(node, SEGDEF_ALIGN) == 16)
            SEGDEF_B(node, SEGDEF_ALIGN) = 3;
        put_raw_byte((u8)((SEGDEF_B(node, SEGDEF_ALIGN) << 5) + (SEGDEF_L(node, SEGDEF_SIZE) == 0x10000L ? 2 : 0) + 8));
        put_raw_word(SEGDEF_W(node, SEGDEF_SIZE));
        OBJ_PUT_INDEX(index);
        OBJ_PUT_INDEX(index + 1);
        put_raw_byte(1);
        OBJ_WRITE_RECORD(0x98);
        index += 2;
    }
    for (u16 node = SEGMENT_LIST_HEAD; node; node = SEGDEF_W(node, SEGDEF_NEXT)) {
        if (!SEGDEF_W(node, SEGDEF_PARENT_ID))
            continue;
        CURSOR = BUFFER;
        OBJ_PUT_NAME(NAME(node, 17));
        put_raw_byte(0);
        OBJ_PUT_INDEX(SEGDEF_W(node, SEGDEF_PARENT_ID) & 0x7FFF);
        if (SEGDEF_L(node, SEGDEF_SIZE) <= 128L)
            put_raw_byte((u8)SEGDEF_L(node, SEGDEF_SIZE));
        else {
            put_raw_byte(0x81);
            put_raw_word(SEGDEF_W(node, SEGDEF_SIZE));
        }
        OBJ_WRITE_RECORD(0xB0);
    }
    for (u16 group = GROUP_LIST_HEAD; group; group = SEGDEF_W(group, SEGDEF_NEXT), ++index) {
        CURSOR = BUFFER;
        OBJ_PUT_INDEX(index);
        i32 total = 0;
        for (u16 node = SEGMENT_LIST_HEAD; node; node = SEGDEF_W(node, SEGDEF_NEXT))
            if (SEGDEF_W(node, SEGDEF_GROUP) == group) {
                total += SEGDEF_L(node, SEGDEF_SIZE);
                put_raw_byte(0xFF);
                OBJ_PUT_INDEX(SEGDEF_W(node, SEGDEF_INDEX));
            }
        if (total > 0x10000L) {
            farptr path = scratch_alloc(0x4C);
            STRING_COPY(path, NAME(group, 4));
            REPORT_FATAL(MSG_GROUP_OVERFLOWED, path);
        }
        OBJ_WRITE_RECORD(0x9A);
    }
    CALL_FAR(OBJ_WRITE_MODULE_HOOK, A16(saved));
    for (u16 node = SEGMENT_LIST_HEAD; node; node = SEGDEF_W(node, SEGDEF_NEXT))
        OBJ_WRITE_SEGMENT_DATA(node);
    OBJ_WRITE_LINE_NUMBERS();
    CURSOR = BUFFER;
    put_raw_byte(0);
    OBJ_WRITE_RECORD(0x8A);
}

/* an empty hook entry */
void OBJ_NOP(void)
{
}

/* writes the data of segment record node, one LEDATA per data block (at most 1 KB): first
   the block's fixups are built in the record buffer (OBJ_WRITE_FIXUP, which may also patch
   the data bytes), then the LEDATA is written directly from the segment's in-memory buffer
   (segment index, start offset, bytes), then the FIXUPP from the record buffer */
void OBJ_WRITE_SEGMENT_DATA(u16 node)
{
    for (u16 block = SEGDEF_W(node, SEGDEF_FIRST_BLOCK); block; block = SEGBLK_W(block, SEGBLK_NEXT)) {
        u16 amount = SEGBLK_W(block, SEGBLK_LENGTH);
        CURSOR = BUFFER;
        for (u16 link = SEGBLK_W(block, SEGBLK_RELOCS); link; link = RELOC_W(link, RELOC_NEXT))
            OBJ_WRITE_FIXUP(node, block, link);
        i16 index = (i16)SEGDEF_W(node, SEGDEF_INDEX);
        if (index > 127) {
            OBJ_BEGIN_RECORD(0xA0, amount + 5);
            OBJ_OUT_BYTE((u8)((index >> 8) | 0x80));
        } else
            OBJ_BEGIN_RECORD(0xA0, amount + 4);
        OBJ_OUT_BYTE((u8)SEGDEF_W(node, SEGDEF_INDEX));
        u16 start = SEGBLK_W(block, SEGBLK_START);
        OBJ_OUT_BYTE((u8)(start & 0xFF));
        OBJ_OUT_BYTE((u8)(start >> 8));
        u16 relative = start - SEGDEF_W(node, SEGDEF_BUFFER_BASE);
        while (amount > 0) {
            --amount;
            OBJ_OUT_BYTE(B(MK_FP(BUFFER_SEGMENT(node), relative)));
            ++relative;
        }
        OBJ_END_RECORD();
        OBJ_WRITE_RECORD(0x9C);
    }
}

/* adds amount to the data word at offset of data block block in segment node (the bytes
   live in a heap buffer reached through SEGDEF_BUFFER_HANDLE, starting at segment offset
   SEGDEF_BUFFER_BASE); used to put the known part of a fixup's value into the data */
void OBJ_PATCH_FIXUP_WORD(u16 node, u16 block, u16 offset, u16 amount)
{
    u16 position = offset + SEGBLK_W(block, SEGBLK_START);
    u16 relative = position - SEGDEF_W(node, SEGDEF_BUFFER_BASE);
    W(MK_FP(BUFFER_SEGMENT(node), relative)) += amount;
}

/* the frame and target of a fixup in segment record segment: its group and segment, or
   just the segment */
static void put_segment_target(u16 segment, int byte_index)
{
    if (SEGDEF_W(segment, SEGDEF_GROUP)) {
        put_raw_byte(0x14);
        OBJ_PUT_INDEX(SEGDEF_W(SEGDEF_W(segment, SEGDEF_GROUP), SEGDEF_GROUP));
    } else
        put_raw_byte(0x54);
    if (byte_index)
        put_raw_byte((u8)SEGDEF_W(segment, SEGDEF_INDEX));
    else
        OBJ_PUT_INDEX(SEGDEF_W(segment, SEGDEF_INDEX));
}

static u16 symbol_kind(u16 symbol) { return (u16)CALL_FAR(GET_SYMBOL_KIND_HOOK, A16(symbol)); }
static u16 symbol_index(u16 symbol) { return (u16)CALL_FAR(SYMBOL_INDEX_HOOK, A16(symbol)); }
static u16 symbol_segment(u16 symbol) { return (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(symbol)); }

/* adds one FIXUPP entry for relocation link of data block block in segment record.  By
   RELOC_KIND: 6 is self-relative (a near call or jump): a target in the same segment is
   resolved here and needs no fixup; 1 and 7 add a non-external target's offset to the data;
   16 adds the location's own offset; 5 adds a constant (then has no symbol).  The locat
   byte comes from FIXUP_CODE_TABLE[kind], with the high bits of the offset; for overlay or
   Windows code a far pointer to a far function uses D4h instead, probably so the linker can
   route it through an overlay or entry thunk.  The fix data byte then picks frame and
   target: 14h group + segment, 54h segment, 16h group + external, 56h external, 46h
   external with the location as frame; kind 10 uses the data segment as target.
   GET_SYMBOL_KIND_HOOK: 2 external, 1/3/4 defined in a segment */
void OBJ_WRITE_FIXUP(u16 record, u16 block, u16 link)
{
    u16 symbol = RELOC_W(link, RELOC_SYMBOL);
    u16 offset = RELOC_W(link, RELOC_OFFSET);
    u16 kind = RELOC_W(link, RELOC_KIND);
    if (kind == 6) {
        if (symbol_kind(symbol) != 2) {
            u16 value = symbol_index(symbol);
            if (symbol_segment(symbol) == SEGDEF_W(record, SEGDEF_INDEX))
                value -= SEGBLK_W(block, SEGBLK_START) + offset + 2;
            OBJ_PATCH_FIXUP_WORD(record, block, offset, value);
            if (symbol_segment(symbol) == SEGDEF_W(record, SEGDEF_INDEX))
                return;
        }
    } else if (kind == 1 || kind == 7) {
        if (symbol_kind(symbol) != 2)
            OBJ_PATCH_FIXUP_WORD(record, block, offset, symbol_index(symbol));
    } else if (kind == 16)
        OBJ_PATCH_FIXUP_WORD(record, block, offset, SEGBLK_W(block, SEGBLK_START) + offset);
    else if (kind == 5 && symbol) {
        OBJ_PATCH_FIXUP_WORD(record, block, offset, symbol);
        symbol = 0;
    }
    i16 code = FIXUP_CODE_TABLE_AT(kind);
    if ((OPTION_OVERLAY_CODE || OPTION_WINDOWS_MODE) && kind == 1 &&
        (u8)CALL_FAR(SYMBOL_ELEMENT_KIND_HOOK, A16(symbol)) == 0x12) {
        u16 type = (u16)CALL_FAR(TYPE_HOOK, A16(symbol));
        if ((u16)CALL_FAR(FLAG_HOOK, A16(type)) & 1)
            code = 0xD4;
    }
    put_raw_byte((u8)((u8)code | (offset >> 8)));
    put_raw_byte((u8)(offset & 0xFF));
    if (kind == 0) {
        OBJ_PATCH_FIXUP_WORD(record, block, offset, CSYM_W(symbol, CSYM_NEXT));
        put_segment_target(record, 1);
    } else if (kind == 5 || kind == 16)
        put_segment_target(record, 0);
    else if (RELOC_W(link, RELOC_KIND) == 10)
        put_segment_target(FIND_SEGMENT(DATA_SEGMENT_ID), 0);
    else if (RELOC_W(link, RELOC_KIND) == 11) {
        put_raw_byte(0x46);
        OBJ_PUT_INDEX(symbol_index(symbol));
    } else
        switch (symbol_kind(symbol)) {
        case 2: {
            u16 other = FIND_SEGMENT(symbol_segment(symbol));
            if (symbol_segment(symbol) == 0xFFFF || !SEGDEF_W(other, SEGDEF_GROUP))
                put_raw_byte(0x56);
            else {
                put_raw_byte(0x16);
                OBJ_PUT_INDEX(SEGDEF_W(SEGDEF_W(other, SEGDEF_GROUP), SEGDEF_GROUP));
            }
            OBJ_PUT_INDEX(symbol_index(symbol));
            break;
        }
        case 1: case 3: case 4:
            put_segment_target(FIND_SEGMENT(symbol_segment(symbol)), 0);
            break;
        }
}

/* starts writing a record directly to the file: type and length (body + checksum) */
void OBJ_BEGIN_RECORD(u8 type, u16 length)
{
    OBJ_RECORD_CHECKSUM = 0;
    OBJ_OUT_BYTE(type);
    OBJ_OUT_BYTE((u8)(length & 0xFF));
    OBJ_OUT_BYTE((u8)(length >> 8));
}

/* writes one byte of a directly written record and adds it to the checksum */
void OBJ_OUT_BYTE(u8 value)
{
    OBJ_RECORD_CHECKSUM += value;
    OUTPUT_CHAR((i8)value);
}

/* writes the checksum byte that makes the record's bytes sum to 0 */
void OBJ_END_RECORD(void)
{
    u16 checksum = (u16)(-OBJ_RECORD_CHECKSUM) & 0xFF;
    OBJ_OUT_BYTE((u8)checksum);
}

/* the record buffer, as a DS offset */
u16 OBJ_RECORD_BUFFER(void)
{
    return BUFFER;
}
