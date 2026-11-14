/* objsegs.c: from bcc20/src/output/OBJSEGS.C (overlay CO056): the segment and group table
   of the module being compiled, and the in-memory image of each segment's data, kept until
   OBJ_WRITE_MODULE writes it out.  Records live in SEGDEF_POOL_SEG (SEGDEF_* for segments,
   SEGGRP_* for the 6-byte group records).  Segment ids are numbered from 1 (SEGMENT_COUNT)
   and are the OMF segment indexes; group ids likewise (GROUP_COUNT).  Segments are listed
   from SEGMENT_LIST_HEAD, groups from GROUP_LIST_HEAD.
   One segment is selected (SELECTED_SEGMENT_ID and its record SELECTED_SEGDEF_ENTRY);
   data and relocations go to it.  Its data is a chain of data blocks
   (SEG_DATA_BLOCK_POOL_SEG, 10 bytes: start offset, length up to 400h, relocation list,
   next), each written later as one LEDATA record; the bytes themselves are in one heap
   buffer per segment (SEGDEF_BUFFER_HANDLE), grown 1 KB at a time.  A segment without data
   blocks only counts its size (uninitialized data).  Relocations (RELOCATION_POOL_SEG, 8
   bytes: next, offset in block, symbol or value, kind) become FIXUPP entries.  While code
   is being generated (CODE_OUTPUT_FLAGS bit 2) bytes go to the code buffer instead
   (EMIT_CODE_BYTE).  ADD_LINENUM_ENTRY records line numbers per source-file record for the
   LINNUM records.  Every segment is limited to 64 KB. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define SEGMENT_LIST_HEAD W(SEGMENT_LIST_HEAD_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
/* the far pointer to the heap handle of a segment's data buffer */
#define BUFFER_HANDLE(r) D(MK_FP(SEGDEF_POOL_SEG, (r) + SEGDEF_BUFFER_HANDLE))

static int same_name(u16 a, u16 b)
{
    return COMPARE_NAME(MK_FP(STRING_POOL_SEG, a), MK_FP(STRING_POOL_SEG, b)) == 0;
}

static void too_much_data(u16 record)
{
    REPORT_FATAL(MSG_TOO_MUCH_GLOBAL_DATA, SEGDEF_W(record, SEGDEF_NAME));
}

/* the id of the segment named name in group key with class other (all string-pool
   offsets; key 0 = no group), creating the group and the segment if they do not exist
   yet.  flag is the alignment for a new segment: 1 byte, 2 word, 16 paragraph.  An
   existing segment is matched by name, group and class only */
u16 DEFINE_SEGMENT(u16 flag, u16 name, u16 key, u16 other)
{
    u16 group = 0;
    if (key) {
        for (group = GROUP_LIST_HEAD; group; group = SEGDEF_W(group, SEGGRP_NEXT))
            if (same_name(SEGDEF_W(group, SEGGRP_NAME), key))
                break;
        if (!group) {
            group = POOL_ALLOC(SEGDEF_POOL_SEG_P, 6);
            ++GROUP_COUNT;
            SEGDEF_W(group, SEGGRP_INDEX) = GROUP_COUNT;
            SEGDEF_W(group, SEGGRP_NAME) = key;
            SEGDEF_W(group, SEGGRP_NEXT) = 0;
            if (GROUP_LIST_HEAD == 0)
                GROUP_LIST_HEAD = group;
            else
                SEGDEF_W(GROUP_LIST_TAIL, SEGGRP_NEXT) = group;
            GROUP_LIST_TAIL = group;
        }
    }
    for (u16 record = SEGMENT_LIST_HEAD; record; record = SEGDEF_W(record, SEGDEF_NEXT))
        if (same_name(SEGDEF_W(record, SEGDEF_NAME), name) && SEGDEF_W(record, SEGDEF_GROUP) == group &&
            same_name(SEGDEF_W(record, SEGDEF_CLASS_NAME), other))
            return SEGDEF_W(record, SEGDEF_INDEX);
    u16 record = POOL_ALLOC(SEGDEF_POOL_SEG_P, 0x1B);
    RTL_MEMSET(MK_FP(SEGDEF_POOL_SEG, record), 0, 0x1B);
    SEGDEF_W(record, SEGDEF_NAME) = name;
    SEGDEF_W(record, SEGDEF_CLASS_NAME) = other;
    ++SEGMENT_COUNT;
    SEGDEF_W(record, SEGDEF_INDEX) = SEGMENT_COUNT;
    SEGDEF_W(record, SEGDEF_GROUP) = group;
    SEGDEF_B(record, SEGDEF_ALIGN) = (u8)flag;
    SEGDEF_W(record, SEGDEF_PARENT_ID) = 0;
    if (SEGMENT_LIST_HEAD)
        SEGDEF_W(SEGMENT_LIST_TAIL, SEGDEF_NEXT) = record;
    else
        SEGMENT_LIST_HEAD = record;
    SEGMENT_LIST_TAIL = record;
    return SEGMENT_COUNT;
}

/* adds a segment record named name with alignment align (no group, class offset 0) and
   gives it the caller's id id and parent parent, without using up a segment number.  Used
   for virtual segments (4000h + OBJ_EXTERN_INDEX), which are written as B0h records inside
   their parent.  Returns id */
u16 DEFINE_SEGMENT_FIXED_ID(u16 id, u16 parent, u16 align, u16 name)
{
    u16 saved = SEGMENT_COUNT;
    DEFINE_SEGMENT(align, name, 0, 0);
    SEGMENT_COUNT = saved;
    SEGDEF_W(SEGMENT_LIST_TAIL, SEGDEF_INDEX) = id;
    SEGDEF_W(SEGMENT_LIST_TAIL, SEGDEF_PARENT_ID) = parent;
    return id;
}

/* makes segment id value the selected one (value 0 changes nothing) and returns the
   previously selected id */
u16 SELECT_SEGMENT(u16 value)
{
    u16 old = SELECTED_SEGMENT_ID;
    if (!value)
        return old;
    u16 record = FIND_SEGMENT(value);
    SELECTED_SEGDEF_ENTRY = record;
    SELECTED_SEGDEF_COPY = record;
    SELECTED_SEGMENT_ID = value;
    return old;
}

/* the size so far (the location counter) of the selected segment */
i32 CURRENT_SEGMENT_SIZE(void)
{
    return SEGDEF_L(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE);
}

/* the record of segment id value, or 0 */
u16 FIND_SEGMENT(u16 value)
{
    for (u16 cursor = SEGMENT_LIST_HEAD; cursor; cursor = SEGDEF_W(cursor, SEGDEF_NEXT))
        if (SEGDEF_W(cursor, SEGDEF_INDEX) == value)
            return cursor;
    return 0;
}

/* appends a new empty data block to segment record value, starting at the segment's
   current size, and returns it */
u16 ALLOCATE_DATA_BLOCK(u16 value)
{
    u16 block = POOL_ALLOC(SEG_DATA_BLOCK_POOL_SEG_P, 10);
    RTL_MEMSET(MK_FP(SEG_DATA_BLOCK_POOL_SEG, block), 0, 10);
    SEGBLK_W(block, SEGBLK_START) = SEGDEF_W(value, SEGDEF_SIZE);
    SEGBLK_W(block, SEGBLK_NEXT) = 0;
    if (SEGDEF_W(value, SEGDEF_FIRST_BLOCK))
        SEGBLK_W(SEGDEF_W(value, SEGDEF_LAST_BLOCK), SEGBLK_NEXT) = block;
    else
        SEGDEF_W(value, SEGDEF_FIRST_BLOCK) = block;
    SEGDEF_W(value, SEGDEF_LAST_BLOCK) = block;
    return block;
}

/* records that source line value of the file with serial name starts at the current
   offset of the selected segment.  A file record's line entries must be contiguous in
   LINE_NUMBER_POOL_SEG, so if a later record already has lines, a new record for the same
   file and the current code segment is made first.  A line equal to the last one, or a
   smaller line already recorded, is not added again.  The stored offset is made relative
   to the current code fragment, which counts its lines, because fragments still move when
   jumps are shortened */
void ADD_LINENUM_ENTRY(u16 name, u16 value)
{
    u16 file = FIND_NODE_BY_SERIAL(name);
    if (!file)
        return;
    for (u16 later = file + 14; later < SEGMENT_POOL_USED; later += 14)
        if (SRCFILE_W(later, SRCFILE_LINE_COUNT) != 0) {
            u16 copy = POOL_ALLOC(SRCFILE_POOL_SEG_P, 14);
            SRCFILE_W(copy, SRCFILE_NAME) = SRCFILE_W(file, SRCFILE_NAME);
            SRCFILE_W(copy, SRCFILE_SEGMENT) = CODE_SEGMENT_ID;
            SRCFILE_W(copy, SRCFILE_FIRST_NODE) = SRCFILE_W(file, SRCFILE_FIRST_NODE);
            SRCFILE_W(copy, SRCFILE_LINE_COUNT) = 0;
            SRCFILE_W(copy, SRCFILE_SERIAL) = SRCFILE_W(file, SRCFILE_SERIAL);
            SRCFILE_W(copy, SRCFILE_DEBUG_INDEX) = SRCFILE_W(file, SRCFILE_DEBUG_INDEX);
            file = copy;
            break;
        }
    u16 saved = SEGDEF_W(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE);
    u16 limit = LINE_NUMBER_POOL_USED;
    if (SRCFILE_W(file, SRCFILE_LINE_COUNT) == 0)
        SRCFILE_W(file, SRCFILE_FIRST_LINE) = limit;
    else if (SRCFILE_W(file, SRCFILE_FIRST_LINE) < limit) {
        limit -= 4;
        if (LINENUM_W(limit, LINENUM_LINE) == value)
            return;
        if (LINENUM_W(limit, LINENUM_LINE) > value)
            for (u16 slot = SRCFILE_W(file, SRCFILE_FIRST_LINE); slot <= limit; slot += 4)
                if (LINENUM_W(slot, LINENUM_LINE) == value)
                    return;
    }
    u16 slot = POOL_ALLOC(LINE_NUMBER_POOL_SEG_P, 4);
    SRCFILE_W(file, SRCFILE_LINE_COUNT)++;
    LINENUM_W(slot, LINENUM_LINE) = value;
    LINENUM_W(slot, LINENUM_OFFSET) = saved;
    if (FRAG_W(CURRENT_CODE_FRAGMENT, FRAG_LINE_COUNT) == 0)
        FRAG_W(CURRENT_CODE_FRAGMENT, FRAG_FIRST_LINE) = slot;
    FRAG_W(CURRENT_CODE_FRAGMENT, FRAG_LINE_COUNT)++;
    LINENUM_W(slot, LINENUM_OFFSET) -= FRAG_W(CURRENT_CODE_FRAGMENT, FRAG_START_OFFSET);
}

/* adds a relocation of kind kind for target value at the current end of the selected
   segment's last data block.  A new block is started first if the bytes the fixup covers
   (4 for kind 7, a far pointer; 2 otherwise) would not fit, so a fixup never spans two
   LEDATA records.  The caller writes the bytes next */
void ADD_RELOCATION(u16 kind, u16 value)
{
    u16 current = SELECTED_SEGDEF_ENTRY;
    u16 block = SEGDEF_W(current, SEGDEF_FIRST_BLOCK) == 0 ? ALLOCATE_DATA_BLOCK(current)
                                                            : SEGDEF_W(current, SEGDEF_LAST_BLOCK);
    if (SEGBLK_W(block, SEGBLK_LENGTH) > (kind == 7 ? 0x3FC : 0x3FE))
        block = ALLOCATE_DATA_BLOCK(current);
    u16 reloc = POOL_ALLOC(RELOCATION_POOL_SEG_P, 8);
    RELOC_W(reloc, RELOC_KIND) = kind;
    RELOC_W(reloc, RELOC_OFFSET) = SEGBLK_W(block, SEGBLK_LENGTH);
    RELOC_W(reloc, RELOC_SYMBOL) = value;
    RELOC_W(reloc, RELOC_NEXT) = SEGBLK_W(block, SEGBLK_RELOCS);
    SEGBLK_W(block, SEGBLK_RELOCS) = reloc;
}

/* adds count bytes of zeros: only the size grows while the segment has no data blocks
   (uninitialized data); otherwise real zero bytes are written */
void RESERVE_BYTES(u16 count)
{
    u16 node = SELECTED_SEGDEF_ENTRY;
    if (SEGDEF_W(node, SEGDEF_FIRST_BLOCK) == 0) {
        i32 value = SEGDEF_L(node, SEGDEF_SIZE) + count;
        if (value > 0x10000L)
            too_much_data(node);
        SEGDEF_L(node, SEGDEF_SIZE) = value;
    } else
        while (count) {
            count--;
            EMIT_DATA_BYTE(0);
        }
}

/* for an alignment of 2 or more, makes the selected segment's size even: a 0 code byte, a
   size round-up (no data yet), or a 0 data byte */
void ALIGN_SEGMENT_EVEN(i16 value)
{
    if (value < 2)
        return;
    u16 node = SELECTED_SEGDEF_ENTRY;
    if (CODE_OUTPUT_FLAGS & 4) {
        if (SEGDEF_L(node, SEGDEF_SIZE) & 1)
            EMIT_CODE_BYTE(0);
    } else if (SEGDEF_W(node, SEGDEF_FIRST_BLOCK) == 0) {
        SEGDEF_L(node, SEGDEF_SIZE) += 1;
        SEGDEF_L(node, SEGDEF_SIZE) &= (i32)0xFFFFFFFEu;
    } else if (SEGDEF_L(node, SEGDEF_SIZE) & 1)
        EMIT_DATA_BYTE(0);
}

/* appends one byte to the selected segment: to the code buffer while code is being
   generated, else to the last data block (a new one every 400h bytes) and the segment's
   heap buffer, which is created on first use and grown by 1 KB whenever the offset from
   SEGDEF_BUFFER_BASE reaches a multiple of 400h (a full 64 KB request becomes FFFFh) */
void EMIT_DATA_BYTE(u8 value)
{
    u16 node = SELECTED_SEGDEF_ENTRY;
    if (CODE_OUTPUT_FLAGS & 4) {
        EMIT_CODE_BYTE(value);
        return;
    }
    u16 block = SEGDEF_W(node, SEGDEF_LAST_BLOCK);
    if (!block || SEGBLK_W(block, SEGBLK_LENGTH) >= 0x400)
        block = ALLOCATE_DATA_BLOCK(node);
    if (BUFFER_HANDLE(node) == 0) {
        farptr handle = HEAP_ALLOC_HANDLE(0x400);
        BUFFER_HANDLE(node) = handle;
        SEGDEF_W(node, SEGDEF_BUFFER_BASE) = SEGBLK_W(block, SEGBLK_START) + SEGBLK_W(block, SEGBLK_LENGTH);
    }
    u16 position = SEGBLK_W(block, SEGBLK_START) + SEGBLK_W(block, SEGBLK_LENGTH);
    u16 delta = position - SEGDEF_W(node, SEGDEF_BUFFER_BASE);
    if ((delta & 0x3FF) == 0) {
        u16 size = delta + 0x400;
        if (size == 0)
            size = 0xFFFF;
        RESIZE_POOL_BLOCK(BUFFER_HANDLE(node), size);
    }
    B(MK_FP(W(BUFFER_HANDLE(node)), delta)) = value;
    ++SEGBLK_W(block, SEGBLK_LENGTH);
    if (SEGDEF_L(node, SEGDEF_SIZE) >= 0x10000L)
        too_much_data(node);
    ++SEGDEF_L(node, SEGDEF_SIZE);
}

/* places symbol value at the current position: the selected segment id, and its current
   size as the offset */
void SET_SYMBOL_AT_CURRENT_POS(u16 value)
{
    u16 item = SELECTED_SEGDEF_ENTRY;
    CALL_FAR(SET_SYMBOL_SEGMENT_HOOK, A16(value), A16(SEGDEF_W(item, SEGDEF_INDEX)));
    CALL_FAR(SET_SYMBOL_OFFSET_HOOK, A16(value), A16(SEGDEF_W(item, SEGDEF_SIZE)));
}

/* the same as ADD_JUMP_18_NEXT_FRAGMENT in ASMDATA.C, for the object-file hook table: a
   jump (kind 18h) to flow block value, then a new code fragment */
void ADD_JUMP_18_NEXT_FRAGMENT_ALT(u16 value)
{
    ADD_JUMP(0x18, value, CNODE_W(value, CNODE_FLAGS) & 0x100);
    START_NEXT_FRAGMENT();
}

/* writes a 16-bit address of target mode plus value (relocation kind 1) */
void EMIT_WORD_RELOC(u16 mode, u16 value)
{
    ADD_RELOCATION(1, mode);
    EMIT_DATA_BYTE((u8)value);
    EMIT_DATA_BYTE((u8)(value >> 8));
}

/* writes a 32-bit far address of target mode with offset value (relocation kind 7); the
   segment word is left 0 for the linker */
void EMIT_DWORD_RELOC(u16 mode, u16 value)
{
    ADD_RELOCATION(7, mode);
    EMIT_DATA_BYTE((u8)value);
    EMIT_DATA_BYTE((u8)(value >> 8));
    EMIT_DATA_BYTE(0);
    EMIT_DATA_BYTE(0);
}

/* 1 if any segment has a nonzero size, else 0 */
u16 ANY_SEGMENT_HAS_DATA(void)
{
    for (u16 cursor = SEGMENT_LIST_HEAD; cursor; cursor = SEGDEF_W(cursor, SEGDEF_NEXT))
        if (SEGDEF_L(cursor, SEGDEF_SIZE))
            return 1;
    return 0;
}
