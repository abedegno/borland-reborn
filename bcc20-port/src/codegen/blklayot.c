/* blklayot.c: from bcc20/src/codegen/BLKLAYOT.C (overlay CO05D): the last stage of a
   function's code: collecting the emitted bytes into code fragments, shortening jumps, and
   writing object bytes or assembler text.  While the body is emitted, the output layer
   appends the instruction bytes (or, with COMPILER_MODE, the assembler text, through
   PUT_CODE_CHAR) to the current fragment.  A fragment (CODE_FRAGMENT_POOL_SEG, 18h bytes,
   FRAG_*) is a run of bytes that ends with at most one jump; every label (DEFINE_LABEL) and
   every jump (ADD_JUMP) ends one, so jumps can change size without moving anything inside a
   fragment.  Fixups inside a fragment are 6-byte records allocated right after it
   (ADD_FIXUP).  Mark fragments (FRAG_FIXUP_COUNT FFFFh) only record a position for the
   output layer.
   Jumps start in their long form (a near JMP is 3 bytes; a conditional jump is 5: the
   inverted short jump over a near JMP), except those that only have a short form or are
   fixed short.  SHRINK_JUMPS_AND_EMIT then turns every jump whose target is in reach into a
   2-byte short jump, repeating while that makes more of them fit, adds the final offsets to
   the line-number records and writes the function.  Jump kinds in a fragment: the block
   jump kind plus bit 100h short (100h alone: no jump), and 118h, a data word holding a
   label's offset (for jump tables).
   Text records of inline assembler and line marks start with FFh, 1, four letters 'a' to
   'p' giving a 16-bit line number in hex digits, and a '0'/'1' flag. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define COMPILER_MODE SB(COMPILER_MODE_P)
#define OPTION_SOURCE_DEBUG SB(OPTION_SOURCE_DEBUG_P)
#define OPTION_LINE_NUMBERS SB(OPTION_LINE_NUMBERS_P)
#define OPTION_TARGET_CPU SB(OPTION_TARGET_CPU_P)
#define OPTION_COMPILE_VIA_ASM SB(OPTION_COMPILE_VIA_ASM_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define CODE_BYTE_POOL_SEG W(CODE_BYTE_POOL_SEG_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)

#define CUR CURRENT_CODE_FRAGMENT
#define SEL_W(o) W(MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + (o)))
#define SEL_D(o) D(MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + (o)))
#define CODE_BYTE(r) B(MK_FP(CODE_BYTE_POOL_SEG, (r)))
#define POOL_CHAR(r) SB(MK_FP(STRING_POOL_SEG, (r)))

/* starts collecting a function's code: empties the fragment and byte pools, switches
   output to the function's code segment (STREAM_HOOK), opens the first fragment (offset 2
   in the pool) and sets CODE_OUTPUT_FLAGS bit 4 (bytes go into fragments) */
void BEGIN_CODE_STREAM(void)
{
    LAST_LINE_MARK_ID = 0;
    CODE_FRAGMENT_POOL_FREE_LIST = 0;
    CODE_FRAGMENT_POOL_USED = 2;
    OUTPUT_BUFFER_POS = 0;
    CODE_BYTE_POOL_FREE_LIST = 0;
    CALL_FAR(STREAM_HOOK, A16(FUNCTION_CODE_SEGMENT));
    NEW_CODE_FRAGMENT();
    CODE_OUTPUT_FLAGS |= 4;
}

/* opens a new current fragment starting at the segment's current size and output
   position, with no jump (kind 100h), no fixups (their records will follow it in the pool)
   and no line records */
void NEW_CODE_FRAGMENT(void)
{
    u16 fragment = POOL_ALLOC(CODE_FRAGMENT_POOL_SEG_P, 0x18);
    CUR = fragment;
    FRAG_W(CUR, FRAG_START_OFFSET) = SEL_W(SEGDEF_SIZE);
    FRAG_W(CUR, FRAG_CODE_START) = OUTPUT_BUFFER_POS;
    FRAG_W(CUR, FRAG_FIXUP_COUNT) = 0;
    FRAG_W(CUR, FRAG_FIXUPS) = CODE_FRAGMENT_POOL_USED;
    FRAG_W(CUR, FRAG_NEXT) = 0;
    FRAG_W(CUR, FRAG_JUMP_KIND) = 0x100;
    FRAG_W(CUR, FRAG_LINE_COUNT) = 0;
    FRAG_W(CUR, 0x14) = 0;
    FRAG_W(CUR, FRAG_FLAGS) = 0;
}

/* sets the current fragment's size from the segment size (and in assembler mode its text
   length); nothing for a mark fragment */
void CLOSE_CODE_FRAGMENT(void)
{
    if (FRAG_W(CUR, FRAG_FIXUP_COUNT) != 0xFFFF) {
        FRAG_W(CUR, FRAG_SIZE) = SEL_W(SEGDEF_SIZE) - FRAG_W(CUR, FRAG_START_OFFSET);
        if (COMPILER_MODE != 0)
            FRAG_W(CUR, FRAG_TEXT_LENGTH) = OUTPUT_BUFFER_POS - FRAG_W(CUR, FRAG_CODE_START);
    }
}

/* closes the current fragment and chains a new one after it, unless the current one is
   still empty (and not a mark) */
void START_NEXT_FRAGMENT(void)
{
    if ((u32)FRAG_W(CUR, FRAG_START_OFFSET) == SEL_D(SEGDEF_SIZE) &&
        FRAG_W(CUR, FRAG_FIXUP_COUNT) != 0xFFFF)
        return;
    u16 node = CUR;
    CLOSE_CODE_FRAGMENT();
    NEW_CODE_FRAGMENT();
    FRAG_W(node, FRAG_NEXT) = CUR;
}

/* records a fixup of kind to target at the current position of the current fragment */
void ADD_FIXUP(u16 kind, u16 target)
{
    u16 record = POOL_ALLOC(CODE_FRAGMENT_POOL_SEG_P, 6);
    FRAG_W(record, FRAGFIX_OFFSET) = SEL_W(SEGDEF_SIZE) - FRAG_W(CUR, FRAG_START_OFFSET);
    FRAG_W(record, FRAGFIX_TARGET) = target;
    FRAG_W(record, FRAGFIX_KIND) = kind;
    ++FRAG_W(CUR, FRAG_FIXUP_COUNT);
}

/* inserts a mark fragment with value FFFFh, which reports the code offset at this point to
   the output layer (OBJ_FRAGMENT_LABEL_HOOK) */
void INSERT_OFFSET_MARK_FRAGMENT(void)
{
    START_NEXT_FRAGMENT();
    FRAG_W(CUR, FRAG_FIXUP_COUNT) = 0xFFFF;
    FRAG_W(CUR, FRAG_MARK_VALUE) = 0xFFFF;
    START_NEXT_FRAGMENT();
}

/* hands node to OBJ_FRAGMENT_NODE_HOOK at this point of the code: at once in assembler
   mode, otherwise through a mark fragment when the object bytes are written */
void INSERT_NODE_MARK_FRAGMENT(u16 node)
{
    if (COMPILER_MODE != 0)
        CALL_FAR(OBJ_FRAGMENT_NODE_HOOK, A16(node));
    else {
        START_NEXT_FRAGMENT();
        FRAG_W(CUR, FRAG_FIXUP_COUNT) = 0xFFFF;
        FRAG_W(CUR, FRAG_MARK_VALUE) = node;
        START_NEXT_FRAGMENT();
    }
}

/* an entry point for DEFINE_LABEL */
void DEFINE_LABEL_ENTRY(u16 value)
{
    DEFINE_LABEL(value);
}

/* ends the current fragment with a jump of kind to block node.  Kinds 14h to 18h, or flag
   set (a jump fixed short), get the short form (bit 100h, 2 bytes); others are counted
   long: 3 bytes for an unconditional jump, 5 for a conditional one.  The segment size grows
   by that much.  If the target block already has its fragment (a backward jump) that is the
   target; otherwise the fragment is chained on the block's list of pending jumps, which
   DEFINE_LABEL resolves */
void ADD_JUMP(u16 kind, u16 node, u16 flag)
{
    u16 size = 2;
    if (kind == 0x18 || (kind >= 0x14 && kind <= 0x17) || flag != 0) {
        kind |= 0x100;
        kind &= 0xFDFF;
    } else
        size = kind == 1 ? 3 : 5;
    FRAG_W(CUR, FRAG_JUMP_KIND) = kind;
    SEL_D(SEGDEF_SIZE) += size;
    if (CNODE_W(node, CNODE_FRAGMENT) != 0xFFFF)
        FRAG_W(CUR, FRAG_JUMP_TARGET) = CNODE_W(node, CNODE_FRAGMENT);
    else {
        FRAG_W(CUR, FRAG_JUMP_TARGET) = CNODE_W(node, CNODE_PENDING_JUMPS);
        CNODE_W(node, CNODE_PENDING_JUMPS) = CUR;
    }
}

/* places block node's label here: starts a new fragment, records it as the block's
   CNODE_FRAGMENT and points every pending jump to it */
void DEFINE_LABEL(u16 node)
{
    START_NEXT_FRAGMENT();
    CNODE_W(node, CNODE_FRAGMENT) = CUR;
    for (u16 cursor = CNODE_W(node, CNODE_PENDING_JUMPS); cursor != 0;) {
        u16 next = FRAG_W(cursor, FRAG_JUMP_TARGET);
        FRAG_W(cursor, FRAG_JUMP_TARGET) = CUR;
        cursor = next;
    }
}

/* writes the function's assembler text (-S): for each fragment, an @serial@fragment label
   when some jump targets it (FRAG_FLAGS 1), its text with line marks turned into
   source-line echoes (DUMP_SOURCE_LINES, not when compiling via the assembler) and line
   comments, then its jump: a short or unconditional jump as one instruction, a long
   conditional one as the inverted jump around a JMP (with a local label numbered by
   LOCAL_LABEL_SERIAL) */
void WRITE_ASM_LISTING(void)
{
    SEEK_ECHO_FILE(FUNCTION_START_LINE, FUNCTION_SOURCE_FILE,
                   (i32)((u32)FUNCTION_SOURCE_POS_HIGH << 16 | FUNCTION_SOURCE_POS_LOW));
    for (u16 node = 2; node; node = FRAG_W(node, FRAG_NEXT)) {
        if (FRAG_W(node, FRAG_FLAGS) & 1) {
            OUTPUT_CHAR('@');
            EMIT_DECIMAL(FUNCTION_SERIAL);
            OUTPUT_CHAR('@');
            EMIT_DECIMAL(node);
            BCC_OUTPUT_STRING(STR_COLON_CR_NL_P);
        }
        u16 kind = FRAG_W(node, FRAG_JUMP_KIND);
        u16 remaining = FRAG_W(node, FRAG_TEXT_LENGTH);
        u16 text = FRAG_W(node, FRAG_CODE_START);
        while (remaining--) {
            if (CODE_BYTE(text) == 0xFF) {
                ++text;
                --remaining;
                if (CODE_BYTE(text++) != 1)
                    continue;
                u16 id = 0;
                for (u16 i = 0; i < 4; ++i) {
                    id = (id << 4) + CODE_BYTE(text) - 0x61;
                    ++text;
                }
                if (!OPTION_COMPILE_VIA_ASM && CODE_BYTE(text) != '0')
                    DUMP_SOURCE_LINES(id);
                ++text;
                remaining -= 5;
                if (id != LAST_LINE_MARK_ID) {
                    LAST_LINE_MARK_ID = id;
                    if (OPTION_LINE_NUMBERS || OPTION_SOURCE_DEBUG) {
                        BCC_OUTPUT_STRING(STR_DEBUG_L_P);
                        EMIT_DECIMAL(id);
                        BCC_OUTPUT_STRING(STR_ASM_STATEMENT_CRLF_P);
                    }
                }
            } else
                OUTPUT_CHAR((i8)CODE_BYTE(text++));
        }
        if (!(kind & 0xF8FF))
            continue;
        u16 extra = 0;
        OUTPUT_CHAR(9);
        if (kind == 0x118)
            BCC_OUTPUT_STRING(STR_DW_P);
        else if ((kind & 0x100) || kind == 1 || (kind & 0xF9FF) == 1) {
            BCC_OUTPUT_STRING(DSPTR(JUMP_MNEMONIC_TEXT_AT(kind & 0xF8FF)));
            OUTPUT_CHAR(9);
            if (kind & 0x100)
                BCC_OUTPUT_STRING(STR_SHORT_P);
            else if (kind & 0x200)
                BCC_OUTPUT_STRING(STR_NEAR_PTR_P);
            else if (kind & 0x400)
                BCC_OUTPUT_STRING(STR_FAR_PTR_P);
        } else {
            BCC_OUTPUT_STRING(DSPTR(JUMP_MNEMONIC_TEXT_AT(INVERT_JUMP_KIND(kind))));
            BCC_OUTPUT_STRING(STR_TAB_AT_AT_P);
            EMIT_DECIMAL(LOCAL_LABEL_SERIAL);
            BCC_OUTPUT_STRING(STR_ASM_STATEMENT_CRLF_P);
            PUT_CODE_STRING(STR_JMP_P);
            extra = 1;
        }
        BCC_OUTPUT_STRING(fp_add(STR_TAB_AT_AT_P, 2));
        EMIT_DECIMAL(FUNCTION_SERIAL);
        OUTPUT_CHAR('@');
        EMIT_DECIMAL(FRAG_W(node, FRAG_JUMP_TARGET));
        BCC_OUTPUT_STRING(STR_ASM_STATEMENT_CRLF_P);
        if (extra) {
            BCC_OUTPUT_STRING(fp_add(STR_TAB_AT_AT_P, 1));
            EMIT_DECIMAL(LOCAL_LABEL_SERIAL++);
            BCC_OUTPUT_STRING(STR_COLON_CR_NL_P);
        }
    }
    RESTORE_ECHO_POSITION();
}

/* writes the function's bytes to the object output (EMIT_DATA_BYTE), starting again at the
   first fragment's offset.  Mark fragments call their hooks (the first offset mark also
   emits the locals debug records).  For a code fragment: its start offset is queued for
   debug information, its bytes are written with a relocation at each fixup (a kind 5 fixup
   aimed at a block gets that block's code offset), then its jump: opcode and 8-bit
   displacement for a short jump, E9h and a 16-bit displacement for a near JMP, an inverted
   short jump over 3 bytes before it for a long conditional jump, or a relocated offset
   word for kind 118h */
void WRITE_OBJECT_CODE(void)
{
    u16 first = 1;
    u16 cur = 2;
    SEL_D(SEGDEF_SIZE) = FRAG_W(cur, FRAG_START_OFFSET);
    for (; cur; cur = FRAG_W(cur, FRAG_NEXT)) {
        if (FRAG_W(cur, FRAG_FIXUP_COUNT) == 0xFFFF) {
            if (FRAG_W(cur, FRAG_MARK_VALUE) == 0xFFFF) {
                CALL_FAR(OBJ_FRAGMENT_LABEL_HOOK, A16(FRAG_W(cur, FRAG_START_OFFSET)));
                if (first) {
                    if (OPTION_SOURCE_DEBUG)
                        CALL_FAR0(EMIT_LOCALS_DEBUG_HOOK);
                    first = 0;
                }
            } else
                CALL_FAR(OBJ_FRAGMENT_NODE_HOOK, A16(FRAG_W(cur, FRAG_MARK_VALUE)));
            continue;
        }
        if (OPTION_SOURCE_DEBUG && FRAG_W(cur, FRAG_SIZE))
            OBJ_QUEUE_WORD(FRAG_W(cur, FRAG_START_OFFSET));
        u16 kind = FRAG_W(cur, FRAG_JUMP_KIND);
        u16 width;
        if (kind == 0x100)
            width = 0;
        else if (kind == 0x118)
            width = 2;
        else if (kind & 0x100)
            width = 2;
        else if (kind == 1)
            width = 3;
        else
            width = 5;
        u16 left = FRAG_W(cur, FRAG_SIZE) - width;
        u16 fix = FRAG_W(cur, FRAG_FIXUPS);
        u16 num = FRAG_W(cur, FRAG_FIXUP_COUNT);
        u16 text = FRAG_W(cur, FRAG_CODE_START);
        u16 total = 0;
        while (left) {
            u16 chunk = num ? FRAG_W(fix, FRAGFIX_OFFSET) - total : left;
            total += chunk;
            left -= chunk;
            while (chunk--)
                EMIT_DATA_BYTE(CODE_BYTE(text++));
            if (num) {
                if (FRAG_W(fix, FRAGFIX_KIND) == 5 && FRAG_W(fix, FRAGFIX_TARGET)) {
                    u16 entry = CNODE_W(FRAG_W(fix, FRAGFIX_TARGET), CNODE_FRAGMENT);
                    FRAG_W(fix, FRAGFIX_TARGET) = FRAG_W(entry, FRAG_START_OFFSET);
                }
                ADD_RELOCATION(FRAG_W(fix, FRAGFIX_KIND), FRAG_W(fix, FRAGFIX_TARGET));
                fix += 6;
                --num;
            }
        }
        if (kind == 0x100)
            continue;
        i16 displacement = (i16)(FRAG_W(FRAG_W(cur, FRAG_JUMP_TARGET), FRAG_START_OFFSET) -
                                 (FRAG_W(cur, FRAG_START_OFFSET) + FRAG_W(cur, FRAG_SIZE)));
        if (kind == 0x118) {
            displacement = (i16)FRAG_W(FRAG_W(cur, FRAG_JUMP_TARGET), FRAG_START_OFFSET);
            ADD_RELOCATION(5, 0);
        } else if (kind & 0x100) {
            EMIT_DATA_BYTE(JUMP_OPCODE_BYTE_AT(kind & 0xFEFF));
            EMIT_DATA_BYTE((u8)displacement);
            continue;
        } else {
            if (kind != 1) {
                EMIT_DATA_BYTE(JUMP_OPCODE_BYTE_AT(INVERT_JUMP_KIND(kind)));
                EMIT_DATA_BYTE(3);
            }
            EMIT_DATA_BYTE(0xE9);
        }
        EMIT_DATA_BYTE((u8)(displacement & 0xFF));
        EMIT_DATA_BYTE((u8)(displacement >> 8));
    }
    if (OPTION_SOURCE_DEBUG)
        OBJ_FLUSH_QUEUED_WORDS();
}

/* closes the last fragment, shortens jumps, fixes the line records and writes the function
   out.  The first loop moves each start offset down by the bytes saved so far, marks jump
   targets as labelled and, for each long jump, computes the displacement it would have as a
   short jump (a forward target has not been moved yet in this pass, so the bytes saved so
   far, and the 3 of a short jump's end, are taken off its offset); it shortens the jump when
   the displacement fits a byte (a conditional jump saves 3 bytes, a JMP 1).  When some jumps
   were shortened and others did not fit, it starts over: the saving may bring them in
   reach.  The second loop adds each fragment's final offset to its line-number records */
void SHRINK_JUMPS_AND_EMIT(void)
{
    CLOSE_CODE_FRAGMENT();
    u8 changed, failed;
    do {
        u16 adjustment = 0;
        changed = failed = 0;
        for (u16 node = 2; node != 0; node = FRAG_W(node, FRAG_NEXT)) {
            FRAG_W(node, FRAG_START_OFFSET) -= adjustment;
            if (FRAG_W(node, FRAG_FIXUP_COUNT) == 0xFFFF)
                continue;
            u16 flags = FRAG_W(node, FRAG_JUMP_KIND);
            if (flags & 0xF8FF)
                FRAG_W(FRAG_W(node, FRAG_JUMP_TARGET), FRAG_FLAGS) |= 1;
            if (flags & 0x700)
                continue;
            u16 current = FRAG_W(node, FRAG_START_OFFSET);
            u16 target = FRAG_W(FRAG_W(node, FRAG_JUMP_TARGET), FRAG_START_OFFSET);
            if (target > current)
                target -= adjustment + 3;
            i16 displacement = (i16)(target - (current + FRAG_W(node, FRAG_SIZE) - 3));
            if (flags == 1) {
                displacement -= 2;
                if (target > current)
                    displacement += 2;
            }
            if (displacement < -128 || displacement >= 127) {
                failed = 1;
                continue;
            }
            changed = 1;
            u16 delta = flags == 1 ? 1 : 3;
            FRAG_W(node, FRAG_JUMP_KIND) |= 0x100;
            FRAG_W(node, FRAG_SIZE) -= delta;
            adjustment += delta;
        }
    } while (changed != 0 && failed != 0);
    for (u16 node = 2; node != 0; node = FRAG_W(node, FRAG_NEXT)) {
        u16 record = FRAG_W(node, FRAG_FIRST_LINE);
        for (u16 count = FRAG_W(node, FRAG_LINE_COUNT); count != 0; count--) {
            LINENUM_W(record, 2) += FRAG_W(node, FRAG_START_OFFSET);
            record += 4;
        }
    }
    CODE_OUTPUT_FLAGS &= 0xFFFB;
    if (COMPILER_MODE != 0)
        WRITE_ASM_LISTING();
    else
        WRITE_OBJECT_CODE();
}

/* assembler-text output of one character: into the current fragment's text (the output
   buffer, then the code byte pool when the buffer is full) while code is being collected
   for the code segment, otherwise straight to the output */
void PUT_CODE_CHAR(i16 value)
{
    if ((CODE_OUTPUT_FLAGS & 4) != 0 && SEL_W(SEGDEF_INDEX) == CODE_SEGMENT_ID) {
        if (OUTPUT_BUFFER_POS >= OUTPUT_BUFFER_LIMIT) {
            u16 place = POOL_ALLOC(CODE_BYTE_POOL_SEG_P, 1);
            CODE_BYTE(place) = (u8)value;
        } else {
            CODE_BYTE(OUTPUT_BUFFER_POS) = (u8)value;
            OUTPUT_BUFFER_POS++;
        }
        return;
    }
    OUTPUT_CHAR((i8)value);
}

/* the inline assembler error message for ASM_ASSEMBLE_STATEMENT's negative results */
static i16 asm_error_message(i16 code)
{
    switch (code) {
    case -1: return MSG_EXPRESSION_SYNTAX;
    case -2: return MSG_STACK_OVERFLOW;
    case -4: return MSG_MEMORY_REFERENCE;
    case -5: return MSG_CONSTANT_EXPRESSION;
    case -6: return MSG_TYPE_NAME_EXPECTED;
    case -7: return MSG_CANNOT_ADD_SUBTRACT;
    case -8: return MSG_INVALID_REGISTER;
    case -10: return MSG_CHARACTER_CONSTANT_TOO;
    case -9:
    case -11: return MSG_INCORRECT_NUMBER;
    case -12:
    case -3: return MSG_INVALID_COMBINATION;
    case -13: return MSG_286_287_INSTRUCTIONS;
    case -14: return MSG_DIVISION_ZERO;
    case -15: return MSG_FIELD_IDENTIFIER;
    }
    return 0;
}

/* emits the inline assembler statement whose text record is at text in STRING_POOL_SEG.
   Blank statements are skipped.  For object output the line mark is decoded
   (LINE_NUMBER_HOOK on a new line) and the statement is assembled by ASM_ASSEMBLE_STATEMENT
   (with 186 instructions when OPTION_TARGET_CPU is set); its negative results become error
   messages.  For assembler output the text is copied, with each reference to a variable
   (1Ah and four letters giving its variable-table entry) replaced by its name (globals),
   its register (register variables) or [bp+n], and the segment size is counted up by 6,
   probably an assumed size since the statement's real length is unknown here.  The
   512-byte copy sits at bp-20Ah in BCC's frame and the text pointer at bp-8 */
void EMIT_ASM_STATEMENT(u16 text)
{
    u16 cursor = text;
    while ((CTYPE(POOL_CHAR(cursor)) & 1) && POOL_CHAR(cursor))
        ++cursor;
    if (POOL_CHAR(cursor) == 0 || POOL_CHAR(cursor) == 13)
        return;
    if (!COMPILER_MODE) {
        u16 mark = scratch_mark();
        farptr v = scratch_alloc(0x20A);
        farptr buffer = v, pointer = fp_add(v, 0x202);
        farptr p = buffer;
        STRING_COPY(p, MK_FP(STRING_POOL_SEG, text));
        if (B(p) == 0xFF && B(p = fp_add(p, 1)) == 1) {
            u16 id = 0;
            for (i16 i = 0; i < 4; ++i) {
                p = fp_add(p, 1);
                id = (id << 4) + SB(p) - 0x61;
            }
            p = fp_add(p, 1);
            if (id != LAST_LINE_MARK_ID) {
                LAST_LINE_MARK_ID = id;
                if (OPTION_LINE_NUMBERS || OPTION_SOURCE_DEBUG)
                    CALL_FAR(LINE_NUMBER_HOOK, A16(FUNCTION_SOURCE_FILE), A16(id));
            }
        }
        p = fp_add(p, 1);
        D(pointer) = p;
        UNSET_BYTES(pointer, 4);        /* a pointer into BCC's stack there */
        u16 length = STRING_LENGTH(p);
        i16 code = ASM_ASSEMBLE_STATEMENT(pointer, length, OPTION_TARGET_CPU == 0 ? 0 : 1);
        scratch_release(mark);
        if (code < 0) {
            i16 message = asm_error_message(code);
            if (message)
                REPORT_ERROR(message);
        }
        return;
    }
    u16 at_ = text;
    while (POOL_CHAR(at_)) {
        if (POOL_CHAR(at_) != 0x1A) {
            PUT_CODE_CHAR(POOL_CHAR(at_));
            ++at_;
            continue;
        }
        ++at_;
        i32 value = 0;
        for (i16 i = 0; i < 4; ++i) {
            value = (value << 4) + POOL_CHAR(at_) - 0x61;
            ++at_;
        }
        u16 item = (u16)value;
        if (VAR_B(item, VAR_SYMBOL_KIND) == 3 || VAR_B(item, VAR_SYMBOL_KIND) == 4)
            CALL_FAR(NAME_HOOK, A16(VAR_W(item, VAR_SYMBOL)));
        else if (VAR_B(item, VAR_FLAGS) & 2)
            PUT_CODE_STRING(REGISTER_NAME((i8)VAR_B(item, VAR_REGISTER), VAR_B(item, VAR_TYPE_KIND) <= 2 ? 2 : 6));
        else {
            i16 offset = (i16)VAR_W(item, VAR_FRAME_OFFSET);
            PUT_CODE_STRING(STR_BP_P);
            if (offset) {
                if (offset > 0)
                    PUT_CODE_CHAR('+');
                EMIT_SIGNED_DECIMAL(offset);
            }
            PUT_CODE_CHAR(']');
        }
    }
    PUT_CODE_STRING(STR_ASM_STATEMENT_CRLF_P);
    SEL_D(SEGDEF_SIZE) += 6;
}

/* PUT_CODE_CHAR for each character of text (to the output directly when no code is being
   collected) */
void PUT_CODE_STRING(farptr text)
{
    if ((CODE_OUTPUT_FLAGS & 4) != 0 && SEL_W(SEGDEF_INDEX) == CODE_SEGMENT_ID) {
        for (; SB(text) != 0; text = fp_add(text, 1))
            PUT_CODE_CHAR(SB(text));
        return;
    }
    BCC_OUTPUT_STRING(text);
}

/* the same for the string at position in the segment held in the word at DS:segment */
void PUT_FAR_STRING(u16 position, u16 segment)
{
    if ((CODE_OUTPUT_FLAGS & 4) != 0 && SEL_W(SEGDEF_INDEX) == CODE_SEGMENT_ID) {
        for (; SB(MK_FP(W(DSPTR(segment)), position)) != 0; position++)
            PUT_CODE_CHAR(SB(MK_FP(W(DSPTR(segment)), position)));
        return;
    }
    for (; SB(MK_FP(W(DSPTR(segment)), position)) != 0; position++)
        OUTPUT_CHAR(SB(MK_FP(W(DSPTR(segment)), position)));
}
