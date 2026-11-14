/* pch.c: from bcc20/src/preproc/PCH.C: precompiled headers.
   When the option is on (PCH_OPTION_MODE nonzero), TRY_PCH_LOAD runs at the start of a
   compile, before the parser reads its first token.  It scans the "preamble": the run of
   directives at the top of the main file (#include, #define, #if, #ifdef, #ifndef, #endif,
   #pragma hdrfile and hdrstop, and extern "C" { ... } around them), recording each as a
   directive record (PDIR) in PREAMBLE_POOL_SEG (kinds: 0 #include <>, 1 #include "", 2
   #define, 3 #if, 4 #ifdef, 5 #ifndef, 6 #endif, 7 extern "C" {, 8 the closing brace).  The
   first line that does not belong is left in PREAMBLE_PUSHBACK_BUFFER as text.
   The precompiled-header file (PCH_FILE_NAME, set by #pragma hdrfile) holds an index: a trie
   of directive sequences (PCHTRIE records in PCH_INDEX_POOL_SEG), each node giving the file
   position of a saved compiler state.  LOAD_PCH_FILE finds the longest saved sequence that
   matches this file's preamble and, if the options, the macros defined beforehand and (in
   mode 2) the headers' file times all agree, reads the saved state back: every record pool
   listed in POOL_BANK_TABLE, the string pool and the name hash table, so the compiler is as
   if it had just compiled those headers.  The directives after the matched part are turned
   back into text and fed to the lexer as input.
   If nothing could be loaded, the preamble is compiled normally by REPLAY_PREAMBLE, which
   handles the recorded directives one by one: each #include opens the file and returns,
   and POP_INPUT_CONTEXT (input.c) calls REPLAY_PREAMBLE again when the file ends.  At the
   end of the preamble the state is saved for next time (WRITE_PCH_ENTRY) unless there were
   errors, code or data were generated, or an extern "C" block is still open; then a stale
   entry is made unloadable instead.  Pragmas and options set inside headers are recorded
   (SAVE_OPTION_STRING, SAVE_WARNING_SWITCH) so a load can apply them again.
   PCH_OPTION_MODE: loading is tried only above 1, 2 also checks the headers' file times,
   and 4 never saves (read from the tests; the driver sets it from the command line).
   The static functions of the original are external here: they are recorded calls. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "fields.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define COMPILER_MODE SB(COMPILER_MODE_P)
#define ERROR_COUNT W(ERROR_COUNT_P)
#define TOKEN_TYPE W(TOKEN_TYPE_P)
#define TOKEN_CONST_VALUE SD(TOKEN_CONST_VALUE_P)
#define TOKEN_STREAM_POS W(TOKEN_STREAM_POS_P)
#define NODE_SERIAL_COUNTER W(NODE_SERIAL_COUNTER_P)
#undef PCH_FILE_NAME
#define PCH_FILE_NAME D(PCH_FILE_NAME_P)                     /* char far * */
#undef INCLUDE_OPTION_TEXT_PTR
#define INCLUDE_OPTION_TEXT_PTR D(INCLUDE_OPTION_TEXT_PTR_P) /* char far * */
#define TTB TOKEN_TEXT_BUFFER_P
#define TEXT(i) B(fp_add(TOKEN_TEXT_BUFFER_P, (i)))
#define PUSHBACK PREAMBLE_PUSHBACK_BUFFER_P
#define CHAR_CLASS_OF(c) SB(fp_add(CHAR_CLASS_P, (c) + 1))
#define LINE_END_CLASS (-20)          /* CHAR_CLASS of a line end (ECh) */

/* a pool bank (POOL_BANK_TABLE holds 37 near pointers to them): segment, capacity, used,
   free list */
#define POOL_COUNT 37
#define BANK_AT(i) W(fp_add(POOL_BANK_TABLE_P, 2 * (i)))
#define BANK_SEGMENT(b) W(DSPTR(b))
#define BANK_CAPACITY(b) W(DSPTR((b) + 2))
#define BANK_USED(b) W(DSPTR((b) + 4))
#define BANK_EXTRA(b) W(DSPTR((b) + 6))

/* the next input character (the lexer's GETBYTE) */
static u16 getbyte(void)
{
    return INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() : B(MK_FP(W(DSPTR(INPUT_BUFFER)), INPUT_INDEX++));
}

/* while a preamble is being compiled for saving (PCH_COLLECT_DEPENDENCIES), records the
   file just opened (CURRENT_FILE_NAME) and its time stamp at the end of the dependency
   list, so a later load can tell whether a header changed.  The 80-byte name copy sits at
   bp-50h in BCC's frame */
void ADD_PCH_DEPENDENCY(void)
{
    if (!PCH_COLLECT_DEPENDENCIES)
        return;
    u16 mark = scratch_mark();
    farptr buffer = scratch_alloc(0x50);
    u16 entry = POOL_ALLOC(PCH_DEPENDENCY_POOL_SEG_P, STRING_LENGTH(MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME)) + 7);
    PDEP_W(entry, PDEP_NEXT) = 0;
    i32 time = FILE_TIME(STRING_COPY(buffer, MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME)));
    PDEP_UL(entry, PDEP_FILE_TIME) = (u32)time;
    STRING_COPY(MK_FP(PCH_DEPENDENCY_POOL_SEG, entry + PDEP_FILE_NAME), MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME));
    if (PCH_DEPENDENCY_HEAD)
        PDEP_W(PCH_DEPENDENCY_TAIL, PDEP_NEXT) = entry;
    else
        PCH_DEPENDENCY_HEAD = entry;
    PCH_DEPENDENCY_TAIL = entry;
    scratch_release(mark);
}

/* a new trie node (no sibling, no child, no saved state yet) for the directive record
   node */
u16 NEW_PREAMBLE_TRIE_NODE(u16 node)
{
    u16 entry = POOL_ALLOC(PCH_INDEX_POOL_SEG_P, STRING_LENGTH(MK_FP(PREAMBLE_POOL_SEG, node + PDIR_TEXT)) + 15);
    PCHTRIE_W(entry, PCHTRIE_NEXT) = 0;
    PCHTRIE_W(entry, PCHTRIE_CHILD) = 0;
    PCHTRIE_W(entry, PCHTRIE_FILE_POS_HI) = 0;
    PCHTRIE_W(entry, PCHTRIE_FILE_POS) = 0;
    PCHTRIE_W(entry, PCHTRIE_ALLOC_SIZE_HI) = 0;
    PCHTRIE_W(entry, PCHTRIE_ALLOC_SIZE) = 0;
    PCHTRIE_W(entry, PCHTRIE_KIND) = PDIR_W(node, PDIR_KIND);
    STRING_COPY(MK_FP(PCH_INDEX_POOL_SEG, entry + PCHTRIE_TEXT), MK_FP(PREAMBLE_POOL_SEG, node + PDIR_TEXT));
    return entry;
}

/* whether directive record node and trie node tree stand for the same directive */
static int same_directive(u16 node, u16 tree)
{
    return PDIR_W(node, PDIR_KIND) == PCHTRIE_W(tree, PCHTRIE_KIND) &&
           COMPARE_NAME(MK_FP(PREAMBLE_POOL_SEG, node + PDIR_TEXT), MK_FP(PCH_INDEX_POOL_SEG, tree + PCHTRIE_TEXT)) == 0;
}

/* walks the trie from tree along the directive list starting at node, adding nodes where
   the path does not exist yet, and returns the trie node of the last directive: where the
   saved state for this exact preamble lives.  tree == PCH_INDEX_POOL_USED means the trie
   is empty (no node at offset 2 yet) */
u16 FIND_OR_ADD_PREAMBLE(u16 tree, u16 node)
{
    for (;;) {
        u16 saved = tree;
        if (tree == PCH_INDEX_POOL_USED) {
            tree = NEW_PREAMBLE_TRIE_NODE(node);
            continue;
        }
        if (same_directive(node, tree)) {
            tree = PCHTRIE_W(tree, PCHTRIE_CHILD);
            node = PDIR_W(node, PDIR_NEXT);
            if (!node)
                return saved;
            if (!tree) {
                tree = NEW_PREAMBLE_TRIE_NODE(node);
                PCHTRIE_W(saved, PCHTRIE_CHILD) = tree;
            }
        } else {
            tree = PCHTRIE_W(tree, PCHTRIE_NEXT);
            if (!tree) {
                tree = NEW_PREAMBLE_TRIE_NODE(node);
                PCHTRIE_W(saved, PCHTRIE_NEXT) = tree;
            }
        }
    }
}

/* the directive list value appended to the end of the list node; the joined list (value
   alone if node is 0) */
u16 APPEND_DIRECTIVE_LIST(u16 node, u16 value)
{
    if (!node)
        return value;
    u16 last = node;
    while (W(MK_FP(PREAMBLE_POOL_SEG, last)))
        last = W(MK_FP(PREAMBLE_POOL_SEG, last));
    W(MK_FP(PREAMBLE_POOL_SEG, last)) = value;
    return node;
}

/* like FIND_OR_ADD_PREAMBLE but read-only: the trie node of the longest prefix of the
   directive list node found in the trie (0 if not even the first directive matches).  The
   first directive that did not match is left in PREAMBLE_MISMATCH_NODE (TRY_PCH_LOAD feeds
   it and the rest back as text after a load) */
u16 FIND_PREAMBLE(u16 tree, u16 node)
{
    u16 saved = 0;
    for (;;) {
        if (tree == PCH_INDEX_POOL_USED)
            return saved;
        if (same_directive(node, tree)) {
            saved = tree;
            tree = PCHTRIE_W(tree, PCHTRIE_CHILD);
            node = PDIR_W(node, PDIR_NEXT);
            if (!node)
                return saved;
            if (!tree)
                break;
        } else {
            tree = PCHTRIE_W(tree, PCHTRIE_NEXT);
            if (!tree)
                break;
        }
    }
    PREAMBLE_MISMATCH_NODE = node;
    return saved;
}

/* the used size of each of the 37 pools of POOL_BANK_TABLE into output (FFFFh for a pool
   never set up); returns their sum */
u32 COLLECT_POOL_SIZES(farptr output)
{
    u32 total = 0;
    for (i16 i = 0; i < POOL_COUNT; i++, output = fp_add(output, 2)) {
        u16 bank = BANK_AT(i);
        if (BANK_SEGMENT(bank)) {
            W(output) = BANK_USED(bank);
            total += BANK_USED(bank);
        } else
            W(output) = 0xFFFF;
    }
    return total;
}

/* the 11 option bytes listed in PCH_OPTION_FLAG_PTRS (the options a saved state depends on)
   copied to dest */
void SAVE_OPTION_FLAGS(farptr dest)
{
    for (i16 i = 0; i < 11; i++)
        B(fp_add(dest, i)) = B(DSPTR(PCH_OPTION_FLAG_PTRS_AT(i)));
}

/* nonzero if the 11 saved option bytes at text differ from the current options */
i16 OPTION_FLAGS_DIFFER(farptr text)
{
    for (i16 i = 0; i < 11; i++)
        if (B(fp_add(text, i)) != B(DSPTR(PCH_OPTION_FLAG_PTRS_AT(i))))
            return 1;
    return 0;
}

/* records every macro defined before the preamble (from the command line or the compiler
   itself) into MACRO_SNAPSHOT_POOL_SEG: the name, then the parameter count and body.  A
   saved state may be loaded only if this snapshot is the same as the one saved with it.
   The name records are 6 bytes each, from offset 2 up to NAME_TABLE_END.  It always reads
   the definition from POOL_E, even for an odd offset, which would be in POOL_F (probably
   never the case this early) */
void SAVE_MACRO_SNAPSHOT(void)
{
    for (u16 entry = 2; entry < NAME_TABLE_END; entry += 6) {
        u16 macro = HLINK_W(entry, HLINK_MACRO);
        if (!macro)
            continue;
        farptr source = MK_FP(W(DSPTR(NAME_W(entry, NAME_TEXT_BANK))), NAME_W(entry, NAME_TEXT_OFFSET));
        u16 text = POOL_ALLOC(MACRO_SNAPSHOT_POOL_SEG_P, STRING_LENGTH(source) + 1);
        STRING_COPY(MK_FP(MACRO_SNAPSHOT_POOL_SEG, text), source);
        text = POOL_ALLOC(MACRO_SNAPSHOT_POOL_SEG_P,
                          STRING_LENGTH(MK_FP(POOL_E, HLINK_W(entry, HLINK_MACRO) + 1)) + 2);
        MSNAP_B(text, MSNAP_PARAM_COUNT) = FAR_B(POOL_E, HLINK_W(entry, HLINK_MACRO), MACDEF_PARAM_COUNT);
        text++;
        STRING_COPY(MK_FP(MACRO_SNAPSHOT_POOL_SEG, text), MK_FP(POOL_E, HLINK_W(entry, HLINK_MACRO) + 1));
    }
}

/* a file position for size bytes: the best block of the free list at offset 0 of
   PCH_INDEX_POOL_SEG, else the end of the file data (PCH_INDEX_FILE_OFFSET, which then
   moves up; the index itself is written after the data).  The best-fit test also takes a
   block smaller than size (a negative difference); the list is probably always empty, see
   FREE_PCH_FILE_SPACE */
i32 ALLOC_PCH_FILE_SPACE(i32 size)
{
    u16 block = 0, best_block = 0;
    i32 best = size;
    while ((block = W(MK_FP(PCH_INDEX_POOL_SEG, block + PCHFREE_NEXT))) != 0) {
        i32 difference = SD(MK_FP(PCH_INDEX_POOL_SEG, block + PCHFREE_SIZE)) - size;
        if (difference < best) {
            best = difference;
            best_block = block;
        }
    }
    if (best_block) {
        SD(MK_FP(PCH_INDEX_POOL_SEG, best_block + PCHFREE_SIZE)) = 0;
        return SD(MK_FP(PCH_INDEX_POOL_SEG, best_block + PCHFREE_FILE_POS));
    }
    i32 result = PCH_INDEX_FILE_OFFSET;
    PCH_INDEX_FILE_OFFSET += size;
    return result;
}

/* meant to put the file block at position, of size bytes, on the free list.  As the
   original stores the new block's link as 0 and never updates the list head (it makes the
   block the head only in a local), the block is never reachable, so freed space is not
   reused */
void FREE_PCH_FILE_SPACE(i32 position, i32 size)
{
    if (size == 0)
        return;
    u16 head = 0;
    u16 block = W(MK_FP(PCH_INDEX_POOL_SEG, head));
    for (;;) {
        if (block == 0) {
            block = POOL_ALLOC(PCH_INDEX_POOL_SEG_P, 0x0A);
            break;
        }
        if (SD(MK_FP(PCH_INDEX_POOL_SEG, block + PCHFREE_SIZE)) == 0)
            break;
        block = W(MK_FP(PCH_INDEX_POOL_SEG, block));
    }
    W(MK_FP(PCH_INDEX_POOL_SEG, block)) = head;
    SD(MK_FP(PCH_INDEX_POOL_SEG, block + PCHFREE_FILE_POS)) = position;
    SD(MK_FP(PCH_INDEX_POOL_SEG, block + PCHFREE_SIZE)) = size;
}

/* writes size bytes to the precompiled-header file.  0 on success; on a failed write the
   file is closed and deleted and 1 is returned */
i16 WRITE_PCH_DATA(farptr buffer, u16 size)
{
    if (!size)
        return 0;
    if ((u16)RTL_WRITE(PCH_FILE_HANDLE, buffer, size) == size)
        return 0;
    RTL_CLOSE(PCH_FILE_HANDLE);
    PCH_FILE_HANDLE = -1;
    DELETE_FILE(PCH_FILE_NAME);
    return 1;
}

/* makes the saved state for the current preamble unloadable, by adding 1 to the magic word
   EDFEh at the start of its header in the file.  Used when this compile's preamble could
   not be saved, so an out-of-date state is not loaded later.  The 70h-byte header copy
   sits at bp-70h in BCC's frame */
void INVALIDATE_PCH_ENTRY(void)
{
    if (PCH_FILE_HANDLE < 0)
        return;
    u16 mark = scratch_mark();
    farptr header = scratch_alloc(0x70);
    u16 entry = FIND_OR_ADD_PREAMBLE(2, PREAMBLE_LIST_HEAD);
    i32 position = PCHTRIE_L(entry, PCHTRIE_FILE_POS);
    if (position != 0 && RTL_LSEEK(PCH_FILE_HANDLE, PCHTRIE_L(entry, PCHTRIE_FILE_POS), 0) == PCHTRIE_L(entry, PCHTRIE_FILE_POS) &&
        RTL_READ(PCH_FILE_HANDLE, header, 0x70) == 0x70 && W(header) == 0xEDFE && W(fp_add(header, 2)) == 6) {
        W(header)++;
        if (RTL_LSEEK(PCH_FILE_HANDLE, PCHTRIE_L(entry, PCHTRIE_FILE_POS), 0) == PCHTRIE_L(entry, PCHTRIE_FILE_POS))
            WRITE_PCH_DATA(header, 0x70);   /* the original tests the result, then ends either way */
    }
    scratch_release(mark);
}

/* the 70h-byte header of a saved state (struct Header) */
#define HDR_MAGIC 0
#define HDR_VERSION 2
#define HDR_SNAPSHOT_SIZE 4
#define HDR_DEPENDENCY_SIZE 6
#define HDR_STRING_SIZE 8
#define HDR_FAR_SEGMENTS 10
#define HDR_TAG 12
#define HDR_VTABLE_CLASS_LIST 14
#define HDR_UNNAMED_GLOBAL_LIST 16
#define HDR_TOKEN_STREAM_POS 18
#define HDR_CACHE_HEAD 20
#define HDR_BANK_INDEX 22
#define HDR_ASM_NEEDED 24      /* byte: PCH_DIAGNOSTIC_ISSUED */
#define HDR_OPTION_BYTES 25    /* 11 bytes */
#define HDR_POOL_COUNT 36
#define HDR_POOL_SIZES 38      /* 37 words */

/* saves the compiler state after the preamble.  Creates the file if needed (a 10-byte file
   header at PCH_FILE_MAGIC: magic D03Ch, version 2, index position and size).  Finds or
   adds the trie node for this preamble, reserves file space when the old space is too small
   (with 800h bytes to spare), and writes a 70h-byte header (magic EDFEh, version 6, sizes
   of the parts, a few list heads and counters, the option bytes, each pool's size) followed
   by the macro snapshot, the dependency list, the string pool, each pool's contents and the
   name hash table.  Then rewrites the index and the file header.  A write error abandons
   the file (WRITE_PCH_DATA deletes it).  BCC's frame: the header at bp-74h */
void WRITE_PCH_ENTRY(void)
{
    if (PCH_FILE_HANDLE < 0) {
        PCH_FILE_HANDLE = RTL_CREAT(PCH_FILE_NAME, 0);
        if (PCH_FILE_HANDLE < 0)
            return;
        PCH_FILE_MAGIC = 0xD03C;
        PCH_HEADER_VERSION = 2;
        PCH_INDEX_FILE_OFFSET = 10;
        if (WRITE_PCH_DATA(PCH_FILE_MAGIC_P, 10))
            return;
        PCHTRIE_W(0, 0) = 0;
    }
    u16 mark = scratch_mark();
    farptr header = scratch_alloc(0x74);
#define HW(o) W(fp_add(header, (o)))
    u16 entry = FIND_OR_ADD_PREAMBLE(2, PREAMBLE_LIST_HEAD);
    PCH_INDEX_FILE_SIZE = PCH_INDEX_POOL_USED;
    HW(HDR_MAGIC) = 0xEDFE;
    HW(HDR_VERSION) = 6;
    HW(HDR_TAG) = 11;
    HW(HDR_VTABLE_CLASS_LIST) = VTABLE_CLASS_LIST;
    HW(HDR_UNNAMED_GLOBAL_LIST) = C_UNNAMED_GLOBAL_LIST;
    HW(HDR_TOKEN_STREAM_POS) = TOKEN_STREAM_POS;
    HW(HDR_CACHE_HEAD) = CACHE_HEAD;
    HW(HDR_BANK_INDEX) = CURRENT_BANK_INDEX;
    B(fp_add(header, HDR_ASM_NEEDED)) = PCH_DIAGNOSTIC_ISSUED;
    SAVE_OPTION_FLAGS(fp_add(header, HDR_OPTION_BYTES));
    HW(HDR_POOL_COUNT) = 0x25;
    HW(HDR_SNAPSHOT_SIZE) = MACRO_SNAPSHOT_POOL_USED;
    HW(HDR_DEPENDENCY_SIZE) = PCH_DEPENDENCY_POOL_USED;
    HW(HDR_STRING_SIZE) = STRING_POOL_USED;
    HW(HDR_FAR_SEGMENTS) = FAR_SEGMENT_COUNT;
    u16 parts = (u16)(HW(HDR_SNAPSHOT_SIZE) + HW(HDR_DEPENDENCY_SIZE) + HW(HDR_STRING_SIZE) + 0x800);
    i32 total = (i32)(parts + COLLECT_POOL_SIZES(fp_add(header, HDR_POOL_SIZES)) + 0x70);
    if (PCHTRIE_L(entry, PCHTRIE_ALLOC_SIZE) < total) {
        FREE_PCH_FILE_SPACE(PCHTRIE_L(entry, PCHTRIE_FILE_POS), PCHTRIE_L(entry, PCHTRIE_ALLOC_SIZE));
        total += 0x800;
        i32 position = ALLOC_PCH_FILE_SPACE(total);
        PCHTRIE_L(entry, PCHTRIE_FILE_POS) = position;
        PCHTRIE_L(entry, PCHTRIE_ALLOC_SIZE) = total;
    }
    do {
        if (RTL_LSEEK(PCH_FILE_HANDLE, PCHTRIE_L(entry, PCHTRIE_FILE_POS), 0) != PCHTRIE_L(entry, PCHTRIE_FILE_POS))
            break;
        if (WRITE_PCH_DATA(header, 0x70) ||
            WRITE_PCH_DATA(MK_FP(MACRO_SNAPSHOT_POOL_SEG, 0), HW(HDR_SNAPSHOT_SIZE)) ||
            WRITE_PCH_DATA(MK_FP(PCH_DEPENDENCY_POOL_SEG, 0), HW(HDR_DEPENDENCY_SIZE)) ||
            WRITE_PCH_DATA(MK_FP(STRING_POOL_SEG, 0), HW(HDR_STRING_SIZE)))
            break;
        i16 i;
        for (i = 0; i < POOL_COUNT; i++) {
            u16 bank = BANK_AT(i);
            if (BANK_SEGMENT(bank) && WRITE_PCH_DATA(MK_FP(BANK_SEGMENT(bank), 0), BANK_USED(bank)))
                break;
        }
        if (i < POOL_COUNT)
            break;
        if (WRITE_PCH_DATA(NAME_HASH_TABLE_P, 0x800))
            break;
        if (RTL_LSEEK(PCH_FILE_HANDLE, PCH_INDEX_FILE_OFFSET, 0) != PCH_INDEX_FILE_OFFSET)
            break;
        if (WRITE_PCH_DATA(MK_FP(PCH_INDEX_POOL_SEG, 0), PCH_INDEX_POOL_USED))
            break;
        if (RTL_LSEEK(PCH_FILE_HANDLE, 0, 0))
            break;
        WRITE_PCH_DATA(PCH_FILE_MAGIC_P, 10);
    } while (0);
#undef HW
    scratch_release(mark);
}

/* each 6-byte name record holds, in its third word, the near address of the bank (in
   C31_BANKS) holding its text.  If C31_BANKS is at another address than in the compiler
   that wrote the file, adds the difference to every record */
void RELOCATE_NAME_BANKS(void)
{
    u16 cursor = 2;
    u16 delta = (u16)(FP_OFF(C31_BANKS_P) - W(MK_FP(NAME_POOL_SEG, cursor + 4)));
    if (!delta)
        return;
    for (; cursor < NAME_TABLE_END; cursor += 6)
        W(MK_FP(NAME_POOL_SEG, cursor + 4)) += delta;
}

/* nonzero if count bytes at offset second and at offset first of MACRO_SNAPSHOT_POOL_SEG
   differ */
i16 MACRO_SNAPSHOT_DIFFERS(u16 second, u16 first, u16 count)
{
    for (; count; --count, ++second, ++first)
        if (B(MK_FP(MACRO_SNAPSHOT_POOL_SEG, second)) != B(MK_FP(MACRO_SNAPSHOT_POOL_SEG, first)))
            return 1;
    return 0;
}

/* nonzero if any header in the loaded dependency list now has another file time (an
   80-byte name copy at bp-50h in BCC's frame) */
i16 PCH_DEPENDENCIES_CHANGED(void)
{
    u16 mark = scratch_mark();
    farptr buffer = scratch_alloc(0x50);
    i16 changed = 0;
    for (u16 entry = 2; entry; entry = W(MK_FP(PCH_DEPENDENCY_POOL_SEG, entry))) {
        i32 time = FILE_TIME(STRING_COPY(buffer, MK_FP(PCH_DEPENDENCY_POOL_SEG, entry + PDEP_FILE_NAME)));
        if ((u32)time != D(MK_FP(PCH_DEPENDENCY_POOL_SEG, entry + PDEP_FILE_TIME))) {
            changed = 1;
            break;
        }
    }
    scratch_release(mark);
    return changed;
}

/* after a load, passes every header of the saved state to EMIT_DEPENDENCY_HOOK, so the
   object file's dependency list still names them although they were not opened */
void NOTIFY_PCH_DEPENDENCIES(void)
{
    u16 mark = scratch_mark();
    farptr buffer = scratch_alloc(0x50);
    for (u16 entry = 2; entry; entry = W(MK_FP(PCH_DEPENDENCY_POOL_SEG, entry)))
        CALL_FAR(D(EMIT_DEPENDENCY_HOOK_P),
                 A32(STRING_COPY(buffer, MK_FP(PCH_DEPENDENCY_POOL_SEG, entry + PDEP_FILE_NAME))));
    scratch_release(mark);
}

/* fixes the 14-byte source-file records in SRCFILE_POOL_SEG after a load: their first word
   is a string pool offset, and the loaded strings were placed value bytes further up.  Also
   raises NODE_SERIAL_COUNTER to the highest serial number found (the third word).  The
   first record, the main file's own, is skipped */
void OFFSET_SEGMENT_RECORDS(u16 value)
{
    for (u16 cursor = 2 + 14; cursor < SEGMENT_POOL_USED; cursor += 14) {
        if (W(MK_FP(SRCFILE_POOL_SEG, cursor + 4)) > NODE_SERIAL_COUNTER)
            NODE_SERIAL_COUNTER = W(MK_FP(SRCFILE_POOL_SEG, cursor + 4));
        W(MK_FP(SRCFILE_POOL_SEG, cursor)) += value;
    }
}

/* applies again the options and warning switches recorded with the loaded state: an entry
   starting '=' is a #pragma option text, one starting '+', '-' or '.' a #pragma warn
   switch (see PRAGMA_WARN) */
void REPLAY_SAVED_OPTIONS(void)
{
#define BYTE(n) B(MK_FP(SAVED_OPTION_POOL_SEG, offset + (n)))
    for (u16 offset = 0; offset < SAVED_OPTION_POOL_USED;
         offset += STRING_LENGTH(MK_FP(SAVED_OPTION_POOL_SEG, offset)) + 1) {
        if (BYTE(0) == '=') {
            APPLY_OPTION(MK_FP(SAVED_OPTION_POOL_SEG, offset + 1), 1);
            continue;
        }
        u16 index = 0;
        for (farptr entry = WARNING_SWITCH_TABLE_P; B(entry); entry = fp_add(entry, 4), ++index)
            if (BYTE(1) == B(entry) && BYTE(2) == B(fp_add(entry, 1)) && BYTE(3) == B(fp_add(entry, 2))) {
                if (BYTE(0) == '.')
                    WARNING_SWITCH_STATE_AT(index) = B(fp_add(entry, 3));
                else if (BYTE(0) == '+')
                    WARNING_SWITCH_STATE_AT(index) = 1;
                else
                    WARNING_SWITCH_STATE_AT(index) = 0;
            }
    }
#undef BYTE
}

/* tries to load a saved state for this preamble.  0 on success, -1 if anything does not
   fit (file missing, no matching trie node, wrong header, other options or macros, changed
   headers); a failed load can leave the index pool loaded but changes nothing else.  If the
   saved state needs compiling through the assembler (the header's PCH_DIAGNOSTIC_ISSUED
   byte) and that is not yet the case, the compile is restarted that way (MODE_FALLBACK(3)).
   BCC's frame: the 14-byte copy of the main source-file record at bp-88h, the 112-byte
   header after it at bp-7Ah */
static i16 load_pch_file(farptr saved, farptr header)
{
#define H(n) W(fp_add(header, (n)))
#define TRIE_POSITION D(MK_FP(PCH_INDEX_POOL_SEG, entry + PCHTRIE_FILE_POS))
    PCH_FILE_HANDLE = RTL_OPEN(PCH_FILE_NAME, 2);
    if (PCH_FILE_HANDLE < 0)
        return -1;
    if (RTL_READ(PCH_FILE_HANDLE, PCH_FILE_MAGIC_P, 10) != 10)
        return -1;
    if (RTL_LSEEK(PCH_FILE_HANDLE, PCH_INDEX_FILE_OFFSET, 0) != PCH_INDEX_FILE_OFFSET)
        return -1;
    POOL_ALLOC(PCH_INDEX_POOL_SEG_P, PCH_INDEX_FILE_SIZE - PCH_INDEX_POOL_USED);
    if ((u16)RTL_READ(PCH_FILE_HANDLE, MK_FP(PCH_INDEX_POOL_SEG, 0), PCH_INDEX_FILE_SIZE) != PCH_INDEX_FILE_SIZE)
        return -1;
    if (PCH_OPTION_MODE <= 1)
        return -1;
    u16 entry = FIND_PREAMBLE(2, PREAMBLE_LIST_HEAD);
    if (!entry || TRIE_POSITION == 0)
        return -1;
    if ((u32)RTL_LSEEK(PCH_FILE_HANDLE, (i32)TRIE_POSITION, 0) != TRIE_POSITION)
        return -1;
    if (RTL_READ(PCH_FILE_HANDLE, header, 112) != 112)
        return -1;
    if (B(fp_add(header, HDR_ASM_NEEDED)) && !COMPILER_MODE) {
        RTL_CLOSE(PCH_FILE_HANDLE);
        PCH_FILE_HANDLE = -1;
        MODE_FALLBACK(3);
    }
    if (H(HDR_MAGIC) != 0xEDFE || H(HDR_VERSION) != 6 || H(HDR_TAG) != 11 ||
        OPTION_FLAGS_DIFFER(fp_add(header, HDR_OPTION_BYTES)) || H(HDR_POOL_COUNT) != 0x25)
        return -1;
    u16 base = POOL_ALLOC(MACRO_SNAPSHOT_POOL_SEG_P, H(HDR_SNAPSHOT_SIZE));
    if ((u16)RTL_READ(PCH_FILE_HANDLE, MK_FP(MACRO_SNAPSHOT_POOL_SEG, base), H(HDR_SNAPSHOT_SIZE)) != H(HDR_SNAPSHOT_SIZE))
        return -1;
    if (H(HDR_SNAPSHOT_SIZE) != base || MACRO_SNAPSHOT_DIFFERS(0, base, H(HDR_SNAPSHOT_SIZE))) {
        MACRO_SNAPSHOT_POOL_FREE = 0;
        MACRO_SNAPSHOT_POOL_USED = base;
        return -1;
    }
    MACRO_SNAPSHOT_POOL_FREE = 0;
    MACRO_SNAPSHOT_POOL_USED = base;
    POOL_ALLOC(PCH_DEPENDENCY_POOL_SEG_P, H(HDR_DEPENDENCY_SIZE));
    if ((u16)RTL_READ(PCH_FILE_HANDLE, MK_FP(PCH_DEPENDENCY_POOL_SEG, 0), H(HDR_DEPENDENCY_SIZE)) != H(HDR_DEPENDENCY_SIZE))
        return -1;
    if (PCH_OPTION_MODE == 2 && PCH_DEPENDENCIES_CHANGED())
        return -1;
    CALL_FAR0(BEGIN_BACKEND_OUTPUT_HOOK);
    u16 offset = STRING_POOL_USED;
    POOL_ALLOC(STRING_POOL_SEG_P, H(HDR_STRING_SIZE));
    if ((u16)RTL_READ(PCH_FILE_HANDLE, MK_FP(STRING_POOL_SEG, offset), H(HDR_STRING_SIZE)) != H(HDR_STRING_SIZE))
        return -1;
    u16 old = SEGMENT_POOL_USED;
    if (old > 2)
        memmove(at(saved), at(MK_FP(SRCFILE_POOL_SEG, 2)), 14);
    while (FAR_SEGMENT_COUNT < H(HDR_FAR_SEGMENTS))
        DEFINE_FAR_SEGMENT();
    farptr sizes = fp_add(header, HDR_POOL_SIZES);
    for (i16 i = 0; i < POOL_COUNT; i++, sizes = fp_add(sizes, 2)) {
        u16 bank = BANK_AT(i);
        if (W(sizes) == 0xFFFF)
            continue;
        if (BANK_SEGMENT(bank) == 0) {
            BANK_CAPACITY(bank) = 0;
            BANK_USED(bank) = 0;
            BANK_EXTRA(bank) = 0;
            POOL_INIT(DSPTR(bank), 0);
        }
        POOL_ALLOC(DSPTR(bank), W(sizes) - BANK_USED(bank));
        if ((u16)RTL_READ(PCH_FILE_HANDLE, MK_FP(BANK_SEGMENT(bank), 0), W(sizes)) != W(sizes))
            return -1;
    }
    if (RTL_READ(PCH_FILE_HANDLE, NAME_HASH_TABLE_P, 0x800) != 0x800)
        return -1;
    RELOCATE_NAME_BANKS();
    REPLAY_SAVED_OPTIONS();
    if (old > 2) {
        memmove(at(MK_FP(SRCFILE_POOL_SEG, 2)), at(saved), 14);
        OFFSET_SEGMENT_RECORDS(offset);
    } else {
        SEGMENT_POOL_FREE_LIST = 0;
        SEGMENT_POOL_USED = old;
    }
    VTABLE_CLASS_LIST = H(HDR_VTABLE_CLASS_LIST);
    C_UNNAMED_GLOBAL_LIST = H(HDR_UNNAMED_GLOBAL_LIST);
    TOKEN_STREAM_POS = H(HDR_TOKEN_STREAM_POS);
    CACHE_HEAD = H(HDR_CACHE_HEAD);
    CURRENT_BANK_INDEX = H(HDR_BANK_INDEX);
    RTL_DPRINTF(STR_LOADED_PRE_COMPILED_P);
    return 0;
#undef H
#undef TRIE_POSITION
}

i16 LOAD_PCH_FILE(void)
{
    u16 mark = scratch_mark();
    farptr frame = scratch_alloc(0x88);
    i16 result = load_pch_file(frame, fp_add(frame, 0x0E));
    scratch_release(mark);
    return result;
}

/* skips blank lines and comments; 1 if the next line starts with '#' and more text
   (INPUT_INDEX left on the first character after '#'), else 0 with the first character
   put back */
i16 NEXT_LINE_IS_DIRECTIVE(void)
{
    for (;;) {
        u16 c = (u16)SCAN_NEXT(0x20);
        if (c == '#') {
            LOGICAL_LINE = CURRENT_LINE;
            c = (u16)SCAN_NEXT(0x20);
            if (CHAR_CLASS_OF(c) == LINE_END_CLASS) {
                LEX_NEWLINE((i8)c);
                continue;
            }
            if (c == 0x1A)
                return 0;
            break;
        }
        if (CHAR_CLASS_OF(c) == LINE_END_CLASS) {
            LEX_NEWLINE((i8)c);
            continue;
        }
        INPUT_INDEX--;
        return 0;
    }
    INPUT_INDEX--;
    return 1;
}

/* rebuilds the directive "#text " in PREAMBLE_PUSHBACK_BUFFER (text a DS offset).  With
   flag set the directive runs at once (pushed back as input and passed to DIRECTIVE_START)
   and the preamble scan goes on; with flag 0 it stays in the buffer and the scan stops.
   Returns flag ("go on") */
i16 PUSH_BACK_DIRECTIVE(u16 text, i16 flag)
{
    STRING_COPY(PUSHBACK, STR_HASH_P);
    STRING_APPEND(PUSHBACK, DSPTR(text));
    STRING_APPEND(PUSHBACK, STR_SPACE_P);
    --INPUT_INDEX;
    if (flag) {
        BCC_INPUT_STRING(fp_add(PUSHBACK, 1));
        DIRECTIVE_START(0x20);
        B(PUSHBACK) = 0;
    }
    return flag;
}

/* copies characters from value on into the token text until the line ends or close */
static i16 scan_until(i16 value, i16 close)
{
    do {
        SCAN_EMIT_FAR((i8)value);
        value = (i16)getbyte();
    } while (value != 0x1A && value != 10 && value != 13 && value != close);
    return value;
}

/* #pragma inside the preamble: hdrfile "name" sets the file name and the scan goes on;
   hdrstop ends the preamble; any other pragma runs at once if no preamble directive has
   been recorded yet, and otherwise ends the preamble */
i16 PCH_DIRECTIVE_PRAGMA(i16 value)
{
    value = SCAN_TOKEN(value);
    if (COMPARE_NAME(STR_HDRFILE_P, NAME_BUFFER_P) == 0) {
        value = SCAN_NEXT(value);
        TOKEN_PTR = FP_OFF(TTB);
        TEXT(0) = 0;
        i16 close;
        if (value == '"') {
            close = value;
            value = (i16)getbyte();
        } else
            close = 0x1A;
        value = scan_until(value, close);
        TOKEN_PTR = FP_OFF(TTB);
        PCH_FILE_NAME = MALLOC(STRING_LENGTH(TTB) + 1);
        STRING_COPY(PCH_FILE_NAME, TTB);
        BCC_SCAN_FINISH_FAR(value);
        return 1;
    }
    if (COMPARE_NAME(STR_HDRSTOP_P, NAME_BUFFER_P) == 0) {
        BCC_SCAN_FINISH_FAR(value);
        return 0;
    }
    STRING_COPY(TTB, STR_PRAGMA_2_P);
    STRING_APPEND(TTB, NAME_BUFFER_P);
    return PUSH_BACK_DIRECTIVE(FP_OFF(TTB), PREAMBLE_LIST_HEAD == 0 ? 1 : 0);
}

/* a directive record of kind with text name (a DS offset) and the current logical line,
   appended to the preamble list */
void ADD_PREAMBLE_ENTRY(u16 kind, u16 name)
{
    u16 entry = POOL_ALLOC(PREAMBLE_POOL_SEG_P, STRING_LENGTH(DSPTR(name)) + 9);
    PDIR_W(entry, PDIR_NEXT) = 0;
    PDIR_W(entry, PDIR_KIND) = kind;
    PDIR_W(entry, PDIR_LINE) = LOGICAL_LINE;
    STRING_COPY(MK_FP(PREAMBLE_POOL_SEG, entry + PDIR_TEXT), DSPTR(name));
    if (PREAMBLE_LIST_HEAD) {
        W(MK_FP(PREAMBLE_POOL_SEG, PREAMBLE_LIST_TAIL)) = entry;
        PDIR_W(entry, PDIR_PREV) = PREAMBLE_LIST_TAIL;
    } else {
        PREAMBLE_LIST_HEAD = entry;
        PDIR_W(entry, PDIR_PREV) = 0;
    }
    PREAMBLE_LIST_TAIL = entry;
}

/* #include in the preamble: records "file" or <file> and returns 1.  A macro name
   instead of a file name ends the preamble (the directive is left in the pushback buffer);
   a malformed name is reported and also ends it */
i16 PCH_DIRECTIVE_INCLUDE(i16 value)
{
    TOKEN_PTR = FP_OFF(TTB);
    if (value != '<' && value != '"') {
        --INPUT_INDEX;
        STRING_COPY(PUSHBACK, STR_HASH_P);
        STRING_APPEND(PUSHBACK, TTB);
        STRING_APPEND(PUSHBACK, STR_SPACE_P);
        return 0;
    }
    TEXT(0) = 0;
    i16 close = value == '<' ? '>' : '"';
    value = scan_until(value, close);
    if (value == close) {
        SCAN_EMIT_FAR((i8)value);
        value = ' ';
    }
    TOKEN_PTR = FP_OFF(TTB);
    BCC_SCAN_FINISH_FAR(value);
    u16 name = TOKEN_TRIM();
    u16 last = name + STRING_LENGTH(DSPTR(name)) - 1;
    if (SB(DSPTR(name)) != '"' && SB(DSPTR(name)) != '<') {
        REPORT_ERROR(MSG_BAD_FILE_NAME_FORMAT);
        return 0;
    }
    if ((SB(DSPTR(name)) == '"' && SB(DSPTR(last)) != '"') || (SB(DSPTR(name)) == '<' && SB(DSPTR(last)) != '>')) {
        REPORT_ERROR(MSG_NO_FILE_NAME_ENDING);
        return 0;
    }
    close = SB(DSPTR(name));
    B(DSPTR(last)) = 0;
    ++name;
    i16 length = (i16)STRING_LENGTH(DSPTR(name));
    if (length > 0x50) {
        REPORT_ERROR(MSG_FILE_NAME_TOO_LONG);
        return 0;
    }
    ADD_PREAMBLE_ENTRY(close == '<' ? 0 : 1, name);
    return 1;
}

/* a directive that cannot be recorded (#else and the like): runs at once while the
   preamble is still empty, otherwise ends the preamble */
i16 PCH_DIRECTIVE_ELSE(i16 value)
{
    (void)value;
    return PUSH_BACK_DIRECTIVE(FP_OFF(TTB), PREAMBLE_LIST_HEAD == 0 ? 1 : 0);
}

/* a directive that always runs at once without ending the preamble scan */
i16 PCH_PUSH_BACK_DIRECTIVE_NOW(i16 value)
{
    (void)value;
    return PUSH_BACK_DIRECTIVE(FP_OFF(TTB), 1);
}

/* the rest of the directive line read into the token buffer, trimmed (a DS offset) */
u16 READ_DIRECTIVE_LINE(i16 value)
{
    TOKEN_PTR = FP_OFF(TTB);
    while (value != 0x1A && value != 10 && value != 13) {
        SCAN_EMIT_FAR((i8)value);
        value = (i16)getbyte();
    }
    TOKEN_PTR = FP_OFF(TTB);
    BCC_SCAN_FINISH_FAR(value);
    return TOKEN_TRIM();
}

/* #define in the preamble: runs at once while the preamble is empty (so macros set
   before the first #include count as predefined), otherwise recorded */
i16 PCH_DIRECTIVE_DEFINE(i16 value)
{
    if (PREAMBLE_LIST_HEAD == 0)
        PUSH_BACK_DIRECTIVE(FP_OFF(TTB), 1);
    else
        ADD_PREAMBLE_ENTRY(2, READ_DIRECTIVE_LINE(value));
    return 1;
}

/* #if, #ifdef or #ifndef (kind 3, 4, 5) in the preamble: runs at once while the preamble
   is empty, otherwise recorded with its line text, and the open conditional is counted in
   PREAMBLE_IF_DEPTH */
i16 ADD_CONDITIONAL_ENTRY(i16 value, u16 kind)
{
    if (PREAMBLE_LIST_HEAD == 0)
        PUSH_BACK_DIRECTIVE(FP_OFF(TTB), 1);
    else {
        ADD_PREAMBLE_ENTRY(kind, READ_DIRECTIVE_LINE(value));
        ++PREAMBLE_IF_DEPTH;
    }
    return 1;
}

i16 PCH_DIRECTIVE_IF(i16 value)
{
    return ADD_CONDITIONAL_ENTRY(value, 3);
}

i16 PCH_DIRECTIVE_IFDEF(i16 value)
{
    return ADD_CONDITIONAL_ENTRY(value, 4);
}

i16 PCH_DIRECTIVE_IFNDEF(i16 value)
{
    return ADD_CONDITIONAL_ENTRY(value, 5);
}

/* #endif in the preamble: recorded if it closes a recorded conditional, otherwise run at
   once */
i16 PCH_DIRECTIVE_ENDIF(i16 value)
{
    if (PREAMBLE_IF_DEPTH <= 0)
        PUSH_BACK_DIRECTIVE(FP_OFF(TTB), 1);
    else {
        ADD_PREAMBLE_ENTRY(6, READ_DIRECTIVE_LINE(value));
        --PREAMBLE_IF_DEPTH;
    }
    return 1;
}

/* skips blanks, comments and line ends; the next character */
u16 SKIP_BLANKS_AND_NEWLINES(u16 value)
{
    for (;;) {
        value = (u16)SCAN_NEXT((i16)value);
        if (CHAR_CLASS_OF(value) != LINE_END_CLASS)
            break;
        LEX_NEWLINE((i8)value);
        value = getbyte();
    }
    return value;
}

/* reads an identifier starting with value into the token buffer; the character after it */
static u16 read_word(u16 value)
{
    u16 path = FP_OFF(TTB);
    while (CTYPE(value) & 12) {
        B(DSPTR(path)) = (u8)value;
        ++path;
        value = getbyte();
    }
    B(DSPTR(path)) = 0;
    return value;
}

/* called when the next line is not a directive.  Accepts extern "name" { (recorded as kind
   7) and a closing brace (kind 8) as part of the preamble and returns 1.  Anything else ends
   the preamble: the text read so far is rebuilt in PREAMBLE_PUSHBACK_BUFFER and 0 is
   returned */
i16 SCAN_EXTERN_LINKAGE(void)
{
    u16 value = getbyte();
    LOGICAL_LINE = CURRENT_LINE;
    if (value == '}') {
        ADD_PREAMBLE_ENTRY(8, FP_OFF(STR_EMPTY_P));
        return 1;
    }
    value = read_word(value);
    if (COMPARE_NAME(STR_EXTERN_P, TTB)) {
        STRING_COPY(PUSHBACK, TTB);
        --INPUT_INDEX;
        return 0;
    }
    value = SKIP_BLANKS_AND_NEWLINES(value);
    if (value != '"') {
        STRING_COPY(PUSHBACK, STR_EXTERN_2_P);
        --INPUT_INDEX;
        return 0;
    }
    value = getbyte();
    u16 path = FP_OFF(TTB);
    while (value != '"') {
        B(DSPTR(path)) = (u8)value;
        ++path;
        value = getbyte();
    }
    B(DSPTR(path)) = 0;
    if (value == '"')
        value = getbyte();
    value = SKIP_BLANKS_AND_NEWLINES(value);
    if (value != '{') {
        STRING_COPY(PUSHBACK, STR_EXTERN_3_P);
        STRING_APPEND(PUSHBACK, TTB);
        STRING_APPEND(PUSHBACK, STR_QUOTE_CRLF_P);
        --CURRENT_LINE;
        --INPUT_INDEX;
        return 0;
    }
    ADD_PREAMBLE_ENTRY(7, FP_OFF(TTB));
    return 1;
}

/* scans one line of the preamble; nonzero to go on.  A directive is dispatched through
   PREAMBLE_DIRECTIVE_TABLE (9 entries of a near name and a near handler in this module);
   an unknown one ends the preamble */
i16 SCAN_PREAMBLE_DIRECTIVE(void)
{
    if (!NEXT_LINE_IS_DIRECTIVE())
        return SCAN_EXTERN_LINKAGE();
    u16 value = getbyte();
    LOGICAL_LINE = CURRENT_LINE;
    value = read_word(value);
    value = (u16)SCAN_NEXT((i16)value);
    for (u16 entry = FP_OFF(PREAMBLE_DIRECTIVE_TABLE_P); entry < FP_OFF(PREAMBLE_DIRECTIVE_TABLE_P) + 9 * 4; entry += 4)
        if (COMPARE_NAME(DSPTR(W(DSPTR(entry))), TTB) == 0)
            return (i16)CALL_NEAR("PCH", W(DSPTR(entry + 2)), A16(value));
    STRING_COPY(PUSHBACK, STR_HASH_P);
    STRING_APPEND(PUSHBACK, TTB);
    STRING_APPEND(PUSHBACK, STR_SPACE_P);
    --INPUT_INDEX;
    return 0;
}

/* empties all the precompiled-header pools once the preamble is done */
void RESET_PCH_STATE(void)
{
    PREAMBLE_POOL_FREE_LIST = 0;
    PREAMBLE_POOL_USED = 2;
    PCH_INDEX_POOL_FREE = 0;
    PCH_INDEX_POOL_USED = 2;
    MACRO_SNAPSHOT_POOL_FREE = 0;
    MACRO_SNAPSHOT_POOL_USED = 0;
    PCH_DEPENDENCY_POOL_FREE = 0;
    PCH_DEPENDENCY_POOL_USED = 2;
    SAVED_OPTION_POOL_FREE = 0;
    SAVED_OPTION_POOL_USED = 2;
    POOL_TRIM(PREAMBLE_POOL_SEG_P, 0);
    POOL_TRIM(PCH_INDEX_POOL_SEG_P, 0);
    POOL_TRIM(MACRO_SNAPSHOT_POOL_SEG_P, 0);
    POOL_TRIM(PCH_DEPENDENCY_POOL_SEG_P, 0);
    POOL_TRIM(SAVED_OPTION_POOL_SEG_P, 0);
    PCH_DIAGNOSTIC_ISSUED = 0;
}

/* the #endif record (kind 6) that closes the conditional whose body starts at record
   input, counting nested #if kinds (3 to 5); the last record if there is none */
u16 FIND_MATCHING_ENDIF(u16 input)
{
    u16 node = input;
    i16 depth = 1;
    for (;;) {
        switch (PDIR_W(node, PDIR_KIND)) {
        case 3:
        case 4:
        case 5:
            ++depth;
            break;
        case 6:
            if (--depth)
                break;
            return node;
        }
        if (PDIR_W(node, PDIR_NEXT))
            node = PDIR_W(node, PDIR_NEXT);
        else
            break;
    }
    return node;
}

/* walks the directive list from node over balanced #if ... #endif and extern "C" { ... }
   groups.  Returns the record that closes the current level (an #endif or closing brace),
   or the first opener that is never closed (0 instead when nested), or 0 at the end of the
   list */
u16 FIND_BALANCED_BLOCK_END(u16 node, u16 nested)
{
    while (node) {
        u16 end;
        switch (PDIR_W(node, PDIR_KIND)) {
        case 7:
            end = FIND_BALANCED_BLOCK_END(PDIR_W(node, PDIR_NEXT), 1);
            if (end && PDIR_W(end, PDIR_KIND) == 8)
                node = end;
            else
                return nested ? 0 : node;
            break;
        case 6:
        case 8:
            return node;
        case 3:
        case 4:
        case 5:
            end = FIND_BALANCED_BLOCK_END(PDIR_W(node, PDIR_NEXT), 1);
            if (end && PDIR_W(end, PDIR_KIND) == 6)
                node = end;
            else
                return nested ? 0 : node;
            break;
        }
        node = PDIR_W(node, PDIR_NEXT);
    }
    return node;
}

/* how much of the preamble can be precompiled: everything before the first unclosed
   group, less any #defines at its end (left to be compiled normally, probably so a saved
   state ends with an #include).  The first record of the part that is not precompiled, or 0
   if all of it is */
u16 FIND_PREAMBLE_END(u16 value)
{
    u16 prev = FIND_BALANCED_BLOCK_END(value, 0);
    value = prev ? PDIR_W(prev, PDIR_PREV) : PREAMBLE_LIST_TAIL;
    while (value && PDIR_W(value, PDIR_KIND) == 2) {
        prev = value;
        value = PDIR_W(value, PDIR_PREV);
    }
    return prev;
}

/* the directive records from node on, turned back into source text in TOKEN_TEXT_BUFFER,
   one directive per line, with line ends added so each lands on its original line;
   CURRENT_LINE is set back to before the first one, so the text can be pushed back as input
   with correct line numbers */
void REBUILD_DIRECTIVE_TEXT(u16 node)
{
#define WORD(n) SW(MK_FP(PREAMBLE_POOL_SEG, node + (n)))
#define NODETEXT MK_FP(PREAMBLE_POOL_SEG, node + 8)
    i16 saved_line = (i16)CURRENT_LINE;
    i16 line = WORD(4) - 1;
    CURRENT_LINE = (u16)line;
    LOGICAL_LINE = (u16)line;
    for (; node; node = (u16)WORD(0)) {
        while (WORD(4) > line) {
            STRING_APPEND(TTB, STR_CRLF_P);
            ++line;
        }
        switch (WORD(6)) {
        case 0:
            STRING_APPEND(TTB, STR_INCLUDE_P);
            STRING_APPEND(TTB, NODETEXT);
            STRING_APPEND(TTB, STR_GREATER_P);
            break;
        case 1:
            STRING_APPEND(TTB, STR_INCLUDE_2_P);
            STRING_APPEND(TTB, NODETEXT);
            STRING_APPEND(TTB, STR_QUOTE_P);
            break;
        case 2:
            STRING_APPEND(TTB, STR_DEFINE_2_P);
            STRING_APPEND(TTB, NODETEXT);
            break;
        case 3:
            STRING_APPEND(TTB, STR_IF_3_P);
            STRING_APPEND(TTB, NODETEXT);
            break;
        case 4:
            STRING_APPEND(TTB, STR_IFDEF_P);
            STRING_APPEND(TTB, NODETEXT);
            break;
        case 5:
            STRING_APPEND(TTB, STR_IFNDEF_P);
            STRING_APPEND(TTB, NODETEXT);
            break;
        case 6:
            STRING_APPEND(TTB, STR_ENDIF_P);
            break;
        case 7:
            STRING_APPEND(TTB, STR_EXTERN_3_P);
            STRING_APPEND(TTB, NODETEXT);
            STRING_APPEND(TTB, STR_QUOTE_OPEN_BRACE_P);
            break;
        case 8:
            STRING_APPEND(TTB, STR_CLOSE_BRACE_P);
            break;
        }
    }
    while (line < saved_line) {
        STRING_APPEND(TTB, STR_CRLF_P);
        ++line;
    }
#undef WORD
#undef NODETEXT
}

/* records an option text for REPLAY_SAVED_OPTIONS, after a marker byte */
static void save_option_text(farptr text, u8 marker)
{
    u16 node = POOL_ALLOC(SAVED_OPTION_POOL_SEG_P, STRING_LENGTH(text) + 2);
    B(MK_FP(SAVED_OPTION_POOL_SEG, node)) = marker;
    ++node;
    STRING_COPY(MK_FP(SAVED_OPTION_POOL_SEG, node), text);
}

/* records a #pragma warn switch made inside a header (prefix '+', '-' or '.', then the
   warning name) */
void SAVE_WARNING_SWITCH(farptr text, u8 prefix)
{
    save_option_text(text, prefix);
}

/* notes that the headers need the compile to go through the assembler (called from
   CHECK_NAME_CONTEXT in preproc.c, probably for #pragma inline inside a header); saved in
   the state's header so a load can restart the compile that way */
void CONTEXT_DIAGNOSTIC(void)
{
    PCH_DIAGNOSTIC_ISSUED = 1;
}

/* records a #pragma option text made inside a header, marked '=' */
void SAVE_OPTION_STRING(farptr text)
{
    save_option_text(text, '=');
}

/* extern "name" { while replaying the preamble: saves CURRENT_LINKAGE on LINKAGE_STACK and
   sets it from the name (1 or 2 for the two names the compiler knows, STR_C and STR_C_2;
   anything else is an error) */
void PUSH_LANGUAGE_LINKAGE(farptr name)
{
    u16 node = POOL_ALLOC_REUSE(LINKAGE_STACK_POOL_SEG_P, 4);
    LINKSTK_W(node, LINKSTK_SAVED_LINKAGE) = CURRENT_LINKAGE;
    LINKSTK_W(node, LINKSTK_NEXT) = LINKAGE_STACK;
    LINKAGE_STACK = node;
    if (COMPARE_NAME(name, STR_C_P) == 0)
        CURRENT_LINKAGE = 1;
    else if (COMPARE_NAME(name, STR_C_2_P) == 0)
        CURRENT_LINKAGE = 2;
    else {
        CURRENT_LINKAGE = 0;
        REPORT_CURRENT_TOKEN(MSG_UNKNOWN_LANGUAGE_MUST);
    }
}

/* the closing brace of an extern "name" block: restores the saved linkage */
void POP_LANGUAGE_LINKAGE(void)
{
    if (!LINKAGE_STACK) {
        REPORT_CURRENT_TOKEN(MSG_UNEXPECTED);
        return;
    }
    u16 node = LINKAGE_STACK;
    LINKAGE_STACK = LINKSTK_W(node, LINKSTK_NEXT);
    CURRENT_LINKAGE = LINKSTK_W(node, LINKSTK_SAVED_LINKAGE);
    POOL_FREE_ITEM(LINKAGE_STACK_POOL_SEG_P, node);
}

/* continues compiling the recorded preamble from PREAMBLE_REPLAY_NODE.  #define records
   go through the directive code as text; #if, #ifdef and #ifndef are evaluated and a false
   one skips to its #endif; extern blocks push and pop the linkage.  An #include opens the
   file and returns at once (the next record is kept in PREAMBLE_REPLAY_NODE);
   POP_INPUT_CONTEXT calls this again when the main file is resumed, which happens after
   every top-level #include and so also in compiles without precompiled headers, where it
   finds nothing to do.  At the end: saves or invalidates the state if a save is pending,
   closes the file, and pushes back as input the text of the directives that were not part
   of the precompiled preamble plus the line that ended the preamble.  The 256-byte name
   buffer sits at bp-100h in BCC's frame */
static void replay_preamble(farptr name)
{
    u16 node = PREAMBLE_REPLAY_NODE;
    while (node) {
        STRING_COPY(name, MK_FP(PREAMBLE_POOL_SEG, node + PDIR_TEXT));
        LOGICAL_LINE = PDIR_W(node, PDIR_LINE);
        switch (PDIR_W(node, PDIR_KIND)) {
        case 0:
        case 1:
            if ((PDIR_W(node, PDIR_KIND) == 1 || SB(fp_add(name, 1)) == ':' || SB(name) == '/' || SB(name) == '\\' ||
                 SB(INCLUDE_OPTION_TEXT_PTR) == 0) &&
                OPEN_SOURCE_FILE(name)) {
                RECORD_SOURCE_NAME();
                PREAMBLE_REPLAY_NODE = PDIR_W(node, PDIR_NEXT);
                return;
            }
            if (!OPEN_INCLUDE_FILE(name))
                REPORT_ERROR(MSG_UNABLE_OPEN_INCLUDE, name);
            RECORD_SOURCE_NAME();
            PREAMBLE_REPLAY_NODE = PDIR_W(node, PDIR_NEXT);
            return;
        case 2:
            STRING_COPY(name, STR_DEFINE_3_P);
            STRING_APPEND(name, MK_FP(PREAMBLE_POOL_SEG, node + PDIR_TEXT));
            STRING_APPEND(name, STR_NEWLINE_P);
            BCC_INPUT_STRING(name);
            DIRECTIVE_START(0x20);
            if (CHAR_CLASS_OF(getbyte()) == LINE_END_CLASS)
                getbyte();
            --INPUT_INDEX;
            break;
        case 3:
            STRING_APPEND(name, STR_NEWLINE_P);
            BCC_INPUT_STRING(name);
            if (!(i16)CALL_FAR0(EVAL_EXPRESSION) || !TOKEN_CONST_VALUE)
                node = FIND_MATCHING_ENDIF(PDIR_W(node, PDIR_NEXT));
            getbyte();
            --INPUT_INDEX;
            break;
        case 4:
            if (!MACRO_DEFINED(name))
                node = FIND_MATCHING_ENDIF(PDIR_W(node, PDIR_NEXT));
            break;
        case 5:
            if (MACRO_DEFINED(name))
                node = FIND_MATCHING_ENDIF(PDIR_W(node, PDIR_NEXT));
            break;
        case 7:
            PUSH_LANGUAGE_LINKAGE(name);
            break;
        case 8:
            POP_LANGUAGE_LINKAGE();
            break;
        }
        node = PDIR_W(node, PDIR_NEXT);
    }
    PREAMBLE_REPLAY_NODE = 0;
    if (PCH_SAVE_PENDING) {
        PCH_SAVE_PENDING = 0;
        CALL_FAR0(BEGIN_BACKEND_OUTPUT_HOOK);
        if (ERROR_COUNT || ANY_SEGMENT_HAS_DATA() || LINKAGE_STACK)
            INVALIDATE_PCH_ENTRY();
        else
            WRITE_PCH_ENTRY();
    }
    PCH_COLLECT_DEPENDENCIES = 0;
    if (PCH_FILE_HANDLE >= 0) {
        RTL_CLOSE(PCH_FILE_HANDLE);
        PCH_FILE_HANDLE = -1;
    }
    TEXT(0) = 0;
    if (PREAMBLE_REMAINDER_NODE) {
        REBUILD_DIRECTIVE_TEXT(PREAMBLE_REMAINDER_NODE);
        PREAMBLE_REMAINDER_NODE = 0;
    }
    if (B(PUSHBACK)) {
        if (TEXT(0) == 0) {
            STRING_COPY(TTB, STR_CRLF_P);
            --CURRENT_LINE;
        }
        STRING_APPEND(TTB, PUSHBACK);
        B(PUSHBACK) = 0;
    }
    RESET_PCH_STATE();
    u16 entry = POOL_ALLOC(PREAMBLE_POOL_SEG_P, STRING_LENGTH(TTB) + 1);
    STRING_COPY(MK_FP(PREAMBLE_POOL_SEG, entry), TTB);
    BCC_INPUT_STRING_PTR(FP_OFF(PREAMBLE_POOL_SEG_P), entry);
}

void REPLAY_PREAMBLE(void)
{
    u16 mark = scratch_mark();
    replay_preamble(scratch_alloc(0x100));
    scratch_release(mark);
}

/* clears the preamble state and sets up the precompiled-header pools for a new compile */
void INIT_PCH_STATE(void)
{
    PREAMBLE_MISMATCH_NODE = 0;
    PREAMBLE_LIST_TAIL = 0;
    PREAMBLE_LIST_HEAD = 0;
    PREAMBLE_REMAINDER_NODE = 0;
    PREAMBLE_REPLAY_NODE = 0;
    B(PUSHBACK) = 0;
    PCH_SAVE_PENDING = 0;
    PCH_COLLECT_DEPENDENCIES = 0;
    PCH_FILE_HANDLE = -1;
    PREAMBLE_POOL_CAPACITY = 2;
    PREAMBLE_POOL_USED = 2;
    PREAMBLE_POOL_FREE_LIST = 0;
    POOL_INIT(PREAMBLE_POOL_SEG_P, 2);
    PCH_INDEX_POOL_CAPACITY = 2;
    PCH_INDEX_POOL_USED = 2;
    PCH_INDEX_POOL_FREE = 0;
    POOL_INIT(PCH_INDEX_POOL_SEG_P, 2);
    MACRO_SNAPSHOT_POOL_CAPACITY = 0;
    MACRO_SNAPSHOT_POOL_USED = 0;
    MACRO_SNAPSHOT_POOL_FREE = 0;
    POOL_INIT(MACRO_SNAPSHOT_POOL_SEG_P, 0);
    PCH_DEPENDENCY_POOL_CAPACITY = 2;
    PCH_DEPENDENCY_POOL_USED = 2;
    PCH_DEPENDENCY_POOL_FREE = 0;
    POOL_INIT(PCH_DEPENDENCY_POOL_SEG_P, 2);
    SAVED_OPTION_POOL_CAPACITY = 0;
    SAVED_OPTION_POOL_USED = 0;
    SAVED_OPTION_POOL_FREE = 0;
    POOL_INIT(SAVED_OPTION_POOL_SEG_P, 0);
    PCH_DEPENDENCY_TAIL = 0;
    PCH_DEPENDENCY_HEAD = 0;
}

/* the entry point, called once per compile before parsing (COMPILE_C_SOURCE for the C
   front end, driver/inittype.c for the C++ one).  Scans the preamble, splits off the part
   that cannot be precompiled, snapshots the macros, and tries to load a saved state.  On
   success the matched directives are dropped and the rest is left as text; on failure
   (unless mode 4) the state will be saved after the preamble has been compiled.
   REPLAY_PREAMBLE then starts the work.  TOKEN_TYPE is set to "no token" (82h) so the
   parser's first read starts fresh */
void TRY_PCH_LOAD(void)
{
    if (!PCH_OPTION_MODE)
        return;
    PREAMBLE_IF_DEPTH = 0;
    while (SCAN_PREAMBLE_DIRECTIVE())
        ;
    PREAMBLE_REPLAY_NODE = PREAMBLE_LIST_HEAD;
    PREAMBLE_REMAINDER_NODE = FIND_PREAMBLE_END(PREAMBLE_LIST_HEAD);
    if (PREAMBLE_REMAINDER_NODE) {
        if (PDIR_W(PREAMBLE_REMAINDER_NODE, PDIR_PREV))
            PDIR_W(PDIR_W(PREAMBLE_REMAINDER_NODE, PDIR_PREV), PDIR_NEXT) = 0;
        else
            PREAMBLE_REPLAY_NODE = 0;
    }
    if (PREAMBLE_REPLAY_NODE) {
        SAVE_MACRO_SNAPSHOT();
        if (!LOAD_PCH_FILE()) {
            NOTIFY_PCH_DEPENDENCIES();
            RTL_CLOSE(PCH_FILE_HANDLE);
            PCH_FILE_HANDLE = -1;
            PREAMBLE_REPLAY_NODE = 0;
            PREAMBLE_REMAINDER_NODE = APPEND_DIRECTIVE_LIST(PREAMBLE_MISMATCH_NODE, PREAMBLE_REMAINDER_NODE);
        } else if (PCH_OPTION_MODE != 4) {
            PCH_COLLECT_DEPENDENCIES = 1;
            PCH_SAVE_PENDING = 1;
        }
    }
    PCH_DEPENDENCY_POOL_FREE = 0;
    PCH_DEPENDENCY_POOL_USED = 2;
    REPLAY_PREAMBLE();
    TOKEN_TYPE = 0x82;
}
