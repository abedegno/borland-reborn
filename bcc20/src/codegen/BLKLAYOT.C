/* target: ovr153_C114UNIT */
/* Role: block layout, jump shortening, assembly or object byte output. Entry points:
   BEGIN_CODE_STREAM, NEW_CODE_FRAGMENT, CLOSE_CODE_FRAGMENT, START_NEXT_FRAGMENT,
   ADD_FIXUP, INSERT_OFFSET_MARK_FRAGMENT, INSERT_NODE_MARK_FRAGMENT, DEFINE_LABEL_ENTRY (+7
   more). Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO05D (ovr_1d6f_a49b) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the last stage of a function's code: collecting the emitted bytes into code
   fragments, shortening jumps, and writing object bytes or assembler text. While the
   body is emitted (EMIT_FUNCTION_BODY and the EMIT_INSN_* builders), the output layer
   appends the instruction bytes (or, with COMPILER_MODE, the assembler text, through
   PUT_CODE_CHAR) to the current fragment. A fragment (CODE_FRAGMENT_POOL_SEG, 0x18 bytes,
   FRAG_*) is a run of bytes that ends with at most one jump; every label (DEFINE_LABEL)
   and every jump (ADD_JUMP) ends one, so jumps can change size without moving anything
   inside a fragment. Fixups inside a fragment are 6-byte records allocated right after it
   (ADD_FIXUP). Mark fragments (FRAG_FIXUP_COUNT 0xFFFF) only record a position for the
   output layer.
   Jumps start in their long form (a near JMP is 3 bytes; a conditional jump is 5: the
   inverted short jump over a near JMP), except those that only have a short form or are
   fixed short. SHRINK_JUMPS_AND_EMIT then turns every jump whose target is in reach into
   a 2-byte short jump, repeating while that makes more of them fit, adds the final
   offsets to the line-number records and writes the function (WRITE_OBJECT_CODE or
   WRITE_ASM_LISTING). Jump kinds in a fragment: the block jump kind (FIELDS.H
   CNODE_JUMP_KIND) plus bit 0x100 'short' (0x100 alone: no jump) and 0x118, a data word
   holding a label's offset (probably for jump tables). EMIT_ASM_STATEMENT (inline
   assembler blocks) and the PUT_* text helpers are here too. Many functions use raw word
   indexes into a fragment ([0] FRAG_NEXT, [2] FRAG_SIZE, [3] FRAG_START_OFFSET, [4]
   FRAG_JUMP_KIND, [5] FRAG_JUMP_TARGET, [7] FRAG_FIXUP_COUNT, [8]/[9] FRAG_FIRST_LINE and
   FRAG_LINE_COUNT, [11] FRAG_FLAGS) or a block ([13] CNODE_PENDING_JUMPS, [15]
   CNODE_FRAGMENT).
   Text records of inline assembler and line marks start with 0xFF, 1, four letters 'a'
   to 'p' giving a 16-bit line number in hex digits, and a '0'/'1' flag (see
   NEW_ASM_STATEMENT_BLOCK, FLOWBLK.C). */
#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"



/* ---- STAOV076 (listing ovr_1d6f_a49b:49B0) ---- */
void far pascal NEW_CODE_FRAGMENT(void);
extern void (far pascal *STREAM_HOOK)(unsigned int value);

/* BEGIN_CODE_STREAM: starts collecting a function's code (called by GENERATE_FUNCTION_CODE
   before the passes): empties the fragment and byte pools, switches output to the
   function's code segment (STREAM_HOOK), opens the first fragment (offset 2 in the pool)
   and sets CODE_OUTPUT_FLAGS bit 4 (bytes go into fragments). */
void far pascal BEGIN_CODE_STREAM(void)
{
    LAST_LINE_MARK_ID = 0;
    CODE_FRAGMENT_POOL_FREE_LIST = 0;
    CODE_FRAGMENT_POOL_USED = 2;
    OUTPUT_BUFFER_POS = 0;
    CODE_BYTE_POOL_FREE_LIST = 0;
    STREAM_HOOK(FUNCTION_CODE_SEGMENT);
    NEW_CODE_FRAGMENT();
    CODE_OUTPUT_FLAGS |= 4;
}

/* ---- STAOV077 (listing ovr_1d6f_a49b:49E6) ---- */
extern unsigned int far pascal POOL_ALLOC(unsigned int far *pool, unsigned int size);

#define RECORD(n) (*(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + (n)))

/* NEW_CODE_FRAGMENT: opens a new current fragment starting at the segment's current size
   (SEGDEF_SIZE of the selected segment) and output position, with no jump (kind 0x100),
   no fixups (their records will follow it in the pool) and no line records. */
void far pascal NEW_CODE_FRAGMENT(void)
{
    CURRENT_CODE_FRAGMENT = POOL_ALLOC(&CODE_FRAGMENT_POOL_SEG, 0x18);
    RECORD(6) = *(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE);
    RECORD(2) = OUTPUT_BUFFER_POS;
    RECORD(14) = 0;
    RECORD(12) = CODE_FRAGMENT_POOL_USED;
    RECORD(0) = 0;
    RECORD(8) = 0x100;
    RECORD(18) = 0;
    RECORD(20) = 0;
    RECORD(22) = 0;
}
#undef RECORD

/* ---- STAOV078 (listing ovr_1d6f_a49b:4A45) ---- */
extern unsigned char COMPILER_MODE;

/* CLOSE_CODE_FRAGMENT: sets the current fragment's size from the segment size (and in
   assembler mode its text length); nothing for a mark fragment. */
void far pascal CLOSE_CODE_FRAGMENT(void)
{
    if (*(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_FIXUP_COUNT) != 0xFFFF) {
        *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_SIZE) =
            *(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE) -
            *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_START_OFFSET);
        if (COMPILER_MODE != 0)
            *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_TEXT_LENGTH) =
                OUTPUT_BUFFER_POS - *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_CODE_START);
    }
}

/* ---- STAOV079 (listing ovr_1d6f_a49b:4A87) ---- */

/* START_NEXT_FRAGMENT: closes the current fragment and chains a new one after it, unless
   the current one is still empty (and not a mark). */
void far pascal START_NEXT_FRAGMENT(void)
{
    register unsigned int node;

    if ((unsigned long)*(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_START_OFFSET) ==
        *(unsigned long far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE)) {
        if (*(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_FIXUP_COUNT) != 0xFFFF)
            return;
    }
    node = CURRENT_CODE_FRAGMENT;
    CLOSE_CODE_FRAGMENT();
    NEW_CODE_FRAGMENT();
    ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, node))[0] = CURRENT_CODE_FRAGMENT;
}

/* ---- STAOV07A (listing ovr_1d6f_a49b:4AD5) ---- */
extern unsigned int far pascal POOL_ALLOC(unsigned int far *pool, unsigned int size);

/* ADD_FIXUP: records a fixup of kind 'first' to target 'second' at the current position
   of the current fragment. */
void far pascal ADD_FIXUP(unsigned int first, unsigned int second)
{
    register unsigned int record;

    record = POOL_ALLOC(&CODE_FRAGMENT_POOL_SEG, 6);
    ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, record))[0] =
        *(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE) -
        *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_START_OFFSET);
    ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, record))[1] = second;
    ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, record))[2] = first;
    ++*(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_FIXUP_COUNT);
}

/* ---- STAOV07B (listing ovr_1d6f_a49b:4B1B) ---- */

/* INSERT_OFFSET_MARK_FRAGMENT: inserts a mark fragment (value 0xFFFF) that reports the
   code offset at this point to the output layer (OBJ_FRAGMENT_LABEL_HOOK). */
void far pascal INSERT_OFFSET_MARK_FRAGMENT(void)
{
    START_NEXT_FRAGMENT();
    *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_FIXUP_COUNT) = 0xFFFF;
    *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_MARK_VALUE) = 0xFFFF;
    START_NEXT_FRAGMENT();
}

/* ---- STAOV07C (listing ovr_1d6f_a49b:4B3C) ---- */
extern unsigned char COMPILER_MODE;
extern void (far pascal *OBJ_FRAGMENT_NODE_HOOK)(unsigned int node);

/* INSERT_NODE_MARK_FRAGMENT: hands 'node' to OBJ_FRAGMENT_NODE_HOOK at this point of the
   code: at once in assembler mode, otherwise through a mark fragment when the object
   bytes are written. */
void far pascal INSERT_NODE_MARK_FRAGMENT(unsigned int node)
{
    register unsigned int value;

    value = node;
    if (COMPILER_MODE != 0) {
        OBJ_FRAGMENT_NODE_HOOK(value);
    } else {
        START_NEXT_FRAGMENT();
        *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_FIXUP_COUNT) = 0xFFFF;
        *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, CURRENT_CODE_FRAGMENT + FRAG_MARK_VALUE) = value;
        START_NEXT_FRAGMENT();
    }
}

/* ---- STAOV07D (listing ovr_1d6f_a49b:4B70) ---- */
void far pascal DEFINE_LABEL(unsigned int node);
/* DEFINE_LABEL_ENTRY: entry point for DEFINE_LABEL. */
void far pascal DEFINE_LABEL_ENTRY(unsigned int value)
{
    DEFINE_LABEL(value);
}

/* ---- STAOV07E (listing ovr_1d6f_a49b:4B7F) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* ADD_JUMP: ends the current fragment with a jump of 'kind' to block 'node'. Kinds 0x14
   to 0x18, or 'flag' set (a jump fixed short), get the short form (bit 0x100, 2 bytes);
   others are counted long: 3 bytes for an unconditional jump, 5 for a conditional one.
   The segment size grows by that much. If the target block already has its fragment (a
   backward jump) it is the target; otherwise the fragment is chained on the block's list
   of pending jumps, which DEFINE_LABEL resolves. */
void far pascal ADD_JUMP(unsigned int kind, unsigned int node, unsigned int flag)
{
    register int value;
    register unsigned int item;

    value = kind;
    item = node;
    _DX = 2;
    if (value == 0x18 || (value >= 0x14 && value <= 0x17) || flag != 0) {
        value |= 0x100;
        value &= 0xFDFF;
    } else {
        _AX = value == 1 ? 3 : 5;
        _DX = _AX;
    }
    _BX = CURRENT_CODE_FRAGMENT;
    ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, _BX))[4] = value;
    _AX = _DX;
    _BX = SELECTED_SEGDEF_ENTRY;
    ((unsigned long far *)MK_FP(SEGDEF_POOL_SEG, _BX))[3] += _AX;
    if (((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, item))[15] != 0xFFFF) {
        _AX = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, item))[15];
        _BX = CURRENT_CODE_FRAGMENT;
        ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, _BX))[5] = _AX;
    } else {
        _AX = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, item))[13];
        _BX = CURRENT_CODE_FRAGMENT;
        ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, _BX))[5] = _AX;
        ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, item))[13] = CURRENT_CODE_FRAGMENT;
    }
}

/* ---- STAOV07F (listing ovr_1d6f_a49b:4C1C) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* DEFINE_LABEL: places block 'node''s label here: starts a new fragment, records it as
   the block's CNODE_FRAGMENT and points every pending jump to it. */
void far pascal DEFINE_LABEL(unsigned int node)
{
    register unsigned int cursor;
    register unsigned int next;

    START_NEXT_FRAGMENT();
    *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node + CNODE_FRAGMENT) = CURRENT_CODE_FRAGMENT;
    cursor = *(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node + CNODE_PENDING_JUMPS);
    while (cursor != 0) {
        next = *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, cursor + FRAG_JUMP_TARGET);
        *(unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, cursor + FRAG_JUMP_TARGET) = CURRENT_CODE_FRAGMENT;
        cursor = next;
    }
}

/* ---- STAOV080 (listing ovr_1d6f_a49b:4C54) ---- */
void far pascal PUT_CODE_STRING(char far *text);
extern signed char OPTION_SOURCE_DEBUG, OPTION_LINE_NUMBERS, OPTION_COMPILE_VIA_ASM;
extern unsigned int CODE_BYTE_POOL_SEG;
extern void far pascal SEEK_ECHO_FILE(unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal DUMP_SOURCE_LINES(unsigned int);
extern void far pascal RESTORE_ECHO_POSITION(void);
extern void far pascal OUTPUT_CHAR(unsigned char);
extern void far pascal BCC_OUTPUT_STRING(char far *);
extern void far pascal EMIT_DECIMAL(unsigned int);
extern unsigned int far pascal INVERT_JUMP_KIND(unsigned int);
#define BYTE(r) (*((unsigned char far *)MK_FP(CODE_BYTE_POOL_SEG,(r))))
#define TEXT(o) ((char near *)(o))

/* WRITE_ASM_LISTING: writes the function's assembler text (-S): for each fragment, a
   '@serial@fragment' label when some jump targets it (FRAG_FLAGS 1), its text with line
   marks turned into source-line echoes (DUMP_SOURCE_LINES, for lines of the main file
   and not when compiling via the assembler) and line comments, then its jump: a short or
   unconditional jump as one instruction, a long conditional one as the inverted jump
   around a JMP (with a local label numbered by LOCAL_LABEL_SERIAL). The strings are at
   fixed DS offsets (0x540A and up). */
static void near pascal WRITE_ASM_LISTING(void)
{
    unsigned int node,kind,extra,remaining,i;
    register unsigned int text;
    register unsigned int id;
    SEEK_ECHO_FILE(FUNCTION_START_LINE,FUNCTION_SOURCE_FILE,FUNCTION_SOURCE_POS_HIGH,FUNCTION_SOURCE_POS_LOW);
    for (node=2; node; node=FRAG_W(node,FRAG_NEXT)) {
        if (FRAG_W(node,FRAG_FLAGS)&1) {
            OUTPUT_CHAR(0x40);
            EMIT_DECIMAL(FUNCTION_SERIAL);
            OUTPUT_CHAR(0x40);
            EMIT_DECIMAL(node);
            BCC_OUTPUT_STRING(TEXT(STR_COLON_CR_NL));
        }
        kind = FRAG_W(node,FRAG_JUMP_KIND);
        remaining = FRAG_W(node,FRAG_TEXT_LENGTH);
        text = FRAG_W(node,FRAG_CODE_START);
        while (remaining--) {
            if (BYTE(text)==0xFF) {
                ++text;
                --remaining;
                if ((unsigned int)BYTE(text++) != 1) continue;
                id = 0;
                for (i=0; i<4; ++i) {
                    id = (id<<4) + BYTE(text) - 0x61;
                    ++text;
                }
                if (!OPTION_COMPILE_VIA_ASM) {
                    if (BYTE(text)!='0') DUMP_SOURCE_LINES(id);
                }
                ++text;
                remaining -= 5;
                if (id != LAST_LINE_MARK_ID) {
                    LAST_LINE_MARK_ID = id;
                    if (OPTION_LINE_NUMBERS || OPTION_SOURCE_DEBUG) {
                        BCC_OUTPUT_STRING(TEXT(STR_DEBUG_L));
                        EMIT_DECIMAL(id);
                        BCC_OUTPUT_STRING(TEXT(STR_ASM_STATEMENT_CRLF));
                    }
                }
            } else {
                OUTPUT_CHAR(BYTE(text++));
            }
        }
        extra = 0;
        if (kind & 0xF8FF) {
            OUTPUT_CHAR(9);
            if (kind == 0x118) BCC_OUTPUT_STRING(TEXT(STR_DW));
            else if ((kind&0x100) || kind==1 || (kind&0xF9FF)==1) {
                BCC_OUTPUT_STRING(JUMP_MNEMONIC_TEXT[kind&0xF8FF]);
                OUTPUT_CHAR(9);
                if (kind&0x100) BCC_OUTPUT_STRING(TEXT(STR_SHORT));
                else if (kind&0x200) BCC_OUTPUT_STRING(TEXT(STR_NEAR_PTR));
                else if (kind&0x400) BCC_OUTPUT_STRING(TEXT(STR_FAR_PTR));
            } else {
                BCC_OUTPUT_STRING(JUMP_MNEMONIC_TEXT[INVERT_JUMP_KIND(kind)]);
                BCC_OUTPUT_STRING(TEXT(STR_TAB_AT_AT));
                EMIT_DECIMAL(LOCAL_LABEL_SERIAL);
                BCC_OUTPUT_STRING(TEXT(STR_ASM_STATEMENT_CRLF));
                PUT_CODE_STRING(TEXT(STR_JMP));
                extra = 1;
            }
            BCC_OUTPUT_STRING(TEXT(STR_TAB_AT_AT+2));
            EMIT_DECIMAL(FUNCTION_SERIAL);
            OUTPUT_CHAR(0x40);
            EMIT_DECIMAL(FRAG_W(node,FRAG_JUMP_TARGET));
            BCC_OUTPUT_STRING(TEXT(STR_ASM_STATEMENT_CRLF));
            if (extra) {
                BCC_OUTPUT_STRING(TEXT(STR_TAB_AT_AT+1));
                EMIT_DECIMAL(LOCAL_LABEL_SERIAL++);
                BCC_OUTPUT_STRING(TEXT(STR_COLON_CR_NL));
            }
        }
    }
    RESTORE_ECHO_POSITION();
}
#undef BYTE
#undef TEXT

/* ---- STAOV081 (listing ovr_1d6f_a49b:4EDF) ---- */
extern signed char OPTION_SOURCE_DEBUG;
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int CODE_BYTE_POOL_SEG;
extern void (far pascal *OBJ_FRAGMENT_LABEL_HOOK)(unsigned int);
extern void (far pascal *EMIT_LOCALS_DEBUG_HOOK)(void);
extern void far pascal OBJ_QUEUE_WORD(unsigned int);
extern void far pascal OBJ_FLUSH_QUEUED_WORDS(void);
extern void far pascal EMIT_DATA_BYTE(unsigned char);
extern void far pascal ADD_RELOCATION(unsigned int,unsigned int);
extern unsigned int far pascal INVERT_JUMP_KIND(unsigned int);

/* WRITE_OBJECT_CODE: writes the function's bytes to the object output (EMIT_DATA_BYTE),
   starting again at the first fragment's offset. Mark fragments call their hooks (the
   first offset mark also emits the locals debug records). For a code fragment: its start
   offset is queued for debug information, its bytes are written with a relocation at each
   fixup (a kind 5 fixup aimed at a block gets that block's code offset), then its jump:
   opcode and 8-bit displacement for a short jump, E9 and a 16-bit displacement for a near
   JMP, an inverted short jump over 3 bytes before it for a long conditional jump, or a
   relocated offset word for kind 0x118. */
static void near pascal WRITE_OBJECT_CODE(void)
{
    unsigned int first,kind,width;
    int displacement;
    unsigned int left,chunk,num,total,text;
    register unsigned int fix,cur;
    first = 1;
    cur = 2;
    *((unsigned long far *)MK_FP(SEGDEF_POOL_SEG,SELECTED_SEGDEF_ENTRY+SEGDEF_SIZE)) = FRAG_W(cur,FRAG_START_OFFSET);
    for (;cur;cur = FRAG_W(cur,FRAG_NEXT)) {
        if (FRAG_W(cur,FRAG_FIXUP_COUNT)==0xFFFF) {
            if (FRAG_W(cur,FRAG_MARK_VALUE)==0xFFFF) {
                OBJ_FRAGMENT_LABEL_HOOK(FRAG_W(cur,FRAG_START_OFFSET));
                if (first) {
                    if (OPTION_SOURCE_DEBUG) EMIT_LOCALS_DEBUG_HOOK();
                    first = 0;
                }
            } else {
                OBJ_FRAGMENT_NODE_HOOK(FRAG_W(cur,FRAG_MARK_VALUE));
            }
        } else {
            if (OPTION_SOURCE_DEBUG) {
                if (FRAG_W(cur,FRAG_SIZE)) OBJ_QUEUE_WORD(FRAG_W(cur,FRAG_START_OFFSET));
            }
            kind = FRAG_W(cur,FRAG_JUMP_KIND);
            if (kind==0x100) width=0;
            else if (kind==0x118) width=2;
            else if (kind&0x100) width=2;
            else if (kind==1) width=3;
            else width=5;
            left = FRAG_W(cur,FRAG_SIZE)-width;
            fix = FRAG_W(cur,FRAG_FIXUPS);
            num = FRAG_W(cur,FRAG_FIXUP_COUNT);
            text = FRAG_W(cur,FRAG_CODE_START);
            total=0;
            while (left) {
                if (num) {
                    chunk = FRAG_W(fix,FRAGFIX_OFFSET)-total;
                } else chunk=left;
                total += chunk;
                left -= chunk;
                while (chunk--)
                    EMIT_DATA_BYTE(*((unsigned char far *)MK_FP(CODE_BYTE_POOL_SEG,text++)));
                if (num) {
                    if (FRAG_W(fix,FRAGFIX_KIND)==5 && FRAG_W(fix,FRAGFIX_TARGET)) {
                        register unsigned int ref, entry;
                        ref = FRAG_W(fix,FRAGFIX_TARGET);
                        entry = CNODE_W(ref,CNODE_FRAGMENT);
                        FRAG_W(fix,FRAGFIX_TARGET) = FRAG_W(entry,FRAG_START_OFFSET);
                    }
                    ADD_RELOCATION(FRAG_W(fix,FRAGFIX_KIND),FRAG_W(fix,FRAGFIX_TARGET));
                    fix += 6;
                    --num;
                }
            }
            if (kind != 0x100) {
                displacement = (int)(FRAG_W(FRAG_W(cur,FRAG_JUMP_TARGET),FRAG_START_OFFSET) - (FRAG_W(cur,FRAG_START_OFFSET)+FRAG_W(cur,FRAG_SIZE)));
                if (kind==0x118) {
                    displacement = FRAG_W(FRAG_W(cur,FRAG_JUMP_TARGET),FRAG_START_OFFSET);
                    ADD_RELOCATION(5,0);
                } else if (kind&0x100) {
                    EMIT_DATA_BYTE(JUMP_OPCODE_BYTE[kind&0xFEFF]);
                    EMIT_DATA_BYTE(displacement);
                    continue;
                } else {
                    if (kind!=1) {
                        EMIT_DATA_BYTE(JUMP_OPCODE_BYTE[INVERT_JUMP_KIND(kind)]);
                        EMIT_DATA_BYTE(3);
                    }
                    EMIT_DATA_BYTE(0xE9);
                }
                EMIT_DATA_BYTE(displacement&0xFF);
                EMIT_DATA_BYTE(displacement>>8);
            }
        }
    }
    if (OPTION_SOURCE_DEBUG) OBJ_FLUSH_QUEUED_WORDS();
}

/* ---- STAOV082 (listing ovr_1d6f_a49b:5137) ---- */
extern unsigned char COMPILER_MODE;

/* SHRINK_JUMPS_AND_EMIT: closes the last fragment, shortens jumps (first loop), fixes the
   line records (second loop) and writes the function out (see the overview). Called near
   the end of GENERATE_FUNCTION_CODE, after the switch tables. The goto structure and
   register code are shapes kept for byte matching. */
void far pascal SHRINK_JUMPS_AND_EMIT(void)
{
    unsigned char changed;
    unsigned char failed;
    unsigned int current;
    unsigned int delta;
    unsigned int flags;
    unsigned int adjustment;
    register unsigned int node;
    register int displacement;

    CLOSE_CODE_FRAGMENT();
restart:
    adjustment = 0;
    _AL = 0;
    failed = _AL;
    changed = _AL;
    node = 2;
    goto first_test;
/* First loop, over all fragments: move each start offset down by the bytes saved so far
   ('adjustment'); mark jump targets as labelled; for each long jump, compute the
   displacement it would have as a short jump (a forward target has not been moved yet in
   this pass, so the bytes saved so far are taken off its offset) and shorten it when the
   displacement fits a byte (a conditional jump saves 3 bytes, a JMP 1). When some jumps
   were shortened and others did not fit, start over: the saving may bring them in reach. */
first_body:
    _ES = CODE_FRAGMENT_POOL_SEG;
    _AX = adjustment;
    ((unsigned int far *)MK_FP(_ES, node))[3] -= _AX;
    if (((unsigned int far *)MK_FP(_ES, node))[7] == 0xFFFF)
        goto first_advance;
    flags = ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, node))[4];
    if ((flags & 0xF8FF) != 0) {
        _BX = ((unsigned int far *)MK_FP(_ES, node))[5];
        ((unsigned int far *)MK_FP(_ES, _BX))[11] |= 1;
    }
    if ((flags & 0x700) != 0)
        goto first_advance;
    current = ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, node))[3];
    _BX = ((unsigned int far *)MK_FP(_ES, node))[5];
    _AX = ((unsigned int far *)MK_FP(_ES, _BX))[3];
    _CX = _AX;
    if (_AX > current) {
        _AX = adjustment;
        _AX += 3;
        _CX -= _AX;
    }
    _ES = CODE_FRAGMENT_POOL_SEG;
    _AX = current;
    _AX += ((unsigned int far *)MK_FP(_ES, node))[2];
    _AX -= 3;
    _DX = _CX;
    _DX -= _AX;
    displacement = _DX;
    if (flags == 1) {
        displacement -= 2;
        _AX = _CX;
        if (_AX > current)
            displacement += 2;
    }
    if (displacement < -128)
        goto first_failed;
    if (displacement >= 127)
        goto first_failed;
    changed = 1;
    _AX = flags == 1 ? 1 : 3;
    delta = _AX;
    ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, node))[4] |= 0x100;
    ((unsigned int far *)MK_FP(_ES, node))[2] -= _AX;
    adjustment += _AX;
    goto first_advance;
first_failed:
    failed = 1;
first_advance:
    node = ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, node))[0];
first_test:
    if (node != 0)
        goto first_body;
    if (changed != 0 && failed != 0)
        goto restart;

    node = 2;
    goto second_test;
/* Second loop: add each fragment's final offset to the offsets of its line-number records. */
second_body:
    if (((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, node))[9] != 0) {
        displacement = ((unsigned int far *)MK_FP(_ES, node))[8];
        _AX = ((unsigned int far *)MK_FP(_ES, node))[9];
        _DX = _AX;
        goto count_test;
count_body:
        _AX = ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, node))[3];
        ((unsigned int far *)MK_FP(LINE_NUMBER_POOL_SEG, displacement))[1] += _AX;
        displacement += 4;
        _DX--;
count_test:
        if (_DX != 0)
            goto count_body;
    }
    node = ((unsigned int far *)MK_FP(CODE_FRAGMENT_POOL_SEG, node))[0];
second_test:
    if (node != 0)
        goto second_body;
    CODE_OUTPUT_FLAGS &= 0xFFFB;
    if (COMPILER_MODE != 0)
        WRITE_ASM_LISTING();
    else
        WRITE_OBJECT_CODE();
}

/* ---- STAOV083 (listing ovr_1d6f_a49b:5282) ---- */
extern unsigned int CODE_SEGMENT_ID;
extern unsigned int CODE_BYTE_POOL_SEG;
extern unsigned int far pascal POOL_ALLOC(unsigned int far *pool, unsigned int size);

/* PUT_CODE_CHAR: assembler-text output of one character: into the current fragment's text
   (the output buffer, then the code byte pool when the buffer is full) while code is
   being collected for the code segment, otherwise straight to the output (OUTPUT_CHAR). */
void far pascal PUT_CODE_CHAR(int value)
{
    if ((CODE_OUTPUT_FLAGS & 4) != 0) {
        if (*(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_INDEX) == CODE_SEGMENT_ID) {
            if (OUTPUT_BUFFER_POS >= OUTPUT_BUFFER_LIMIT) {
                *(char far *)MK_FP(CODE_BYTE_POOL_SEG, POOL_ALLOC(&CODE_BYTE_POOL_SEG, 1)) = value;
            } else {
                *(char far *)MK_FP(CODE_BYTE_POOL_SEG, OUTPUT_BUFFER_POS) = value;
                OUTPUT_BUFFER_POS++;
            }
            return;
        }
    }
    OUTPUT_CHAR(value);
}

/* ---- STAOV084 (listing ovr_1d6f_a49b:52E5) ---- */
extern unsigned int STRING_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
extern signed char  OPTION_SOURCE_DEBUG,OPTION_LINE_NUMBERS,OPTION_TARGET_CPU;
extern char _CTYPE[];
extern void (far pascal *LINE_NUMBER_HOOK)(unsigned int,unsigned int);
extern void (far pascal *NAME_HOOK)(unsigned int);
extern void far pascal STRING_COPY(char far *,char far *);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern int far pascal ASM_ASSEMBLE_STATEMENT(char far * far *,unsigned int,int);
extern void far cdecl REPORT_ERROR(unsigned int);
extern char far * far pascal REGISTER_NAME(unsigned char,unsigned char);
extern void far pascal EMIT_SIGNED_DECIMAL(int);

/* EMIT_ASM_STATEMENT: emits the inline assembler statement whose text record is at
   'text' in STRING_POOL_SEG (from a kind 5 block, EMIT_FUNCTION_BODY). Blank statements
   are skipped. For object output the line mark is decoded (LINE_NUMBER_HOOK on a new
   line) and the statement is assembled by ASM_ASSEMBLE_STATEMENT (with 186 instructions
   when OPTION_TARGET_CPU is set); its negative results become error messages. For
   assembler output the text is copied, with each reference to a variable (0x1A and four
   letters giving its variable-table entry) replaced by its name (globals), its register
   (register variables) or '[bp+n]', and the segment size is counted up by 6, probably an
   assumed size for the statement since its real length is unknown here. */
void far pascal EMIT_ASM_STATEMENT(unsigned int text)
{
    unsigned int cursor;
    int code;
    union { char far *p; long value; } data;
    unsigned int id;
    char buffer[512];

    _SI = text;
    for (cursor=_SI; (_CTYPE[*((signed char far *)MK_FP(STRING_POOL_SEG,cursor))+1]&1) &&
                     *((signed char far *)MK_FP(_ES,cursor)); ++cursor) ;
    _ES = STRING_POOL_SEG;
    _BX = cursor;
    if (ES_B(_BX,STRPOOL_CHAR)==0) return;
    if (ES_B(_BX,STRPOOL_CHAR)==13) return;
    if (!(signed char)COMPILER_MODE) {
        data.p = buffer;
        STRING_COPY(data.p,(char far *)MK_FP(STRING_POOL_SEG,_SI));
        if ((unsigned char)*data.p == 0xFF && (unsigned char)*++data.p == 1) {
            id = 0;
            for (_DI=0; _DI<4; ++_DI) {
                ++data.p;
                id = (id<<4) + *data.p - 0x61;
            }
            ++data.p;
            if (id != LAST_LINE_MARK_ID) {
                LAST_LINE_MARK_ID = id;
                if (OPTION_LINE_NUMBERS || OPTION_SOURCE_DEBUG) LINE_NUMBER_HOOK(FUNCTION_SOURCE_FILE,id);
            }
        }
        ++data.p;
        code = ASM_ASSEMBLE_STATEMENT(&data.p,STRING_LENGTH(data.p),OPTION_TARGET_CPU == 0 ? 0:1);
        if (code==0) return;
        if (code>=0) return;
        switch(code) {
        case -1:
            REPORT_ERROR(MSG_EXPRESSION_SYNTAX); return;
        case -2:
            REPORT_ERROR(MSG_STACK_OVERFLOW); return;
        case -4:
            REPORT_ERROR(MSG_MEMORY_REFERENCE); return;
        case -5:
            REPORT_ERROR(MSG_CONSTANT_EXPRESSION); return;
        case -6:
            REPORT_ERROR(MSG_TYPE_NAME_EXPECTED); return;
        case -7:
            REPORT_ERROR(MSG_CANNOT_ADD_SUBTRACT); return;
        case -8:
            REPORT_ERROR(MSG_INVALID_REGISTER); return;
        case -10:
            REPORT_ERROR(MSG_CHARACTER_CONSTANT_TOO); return;
        case -9:
        case -11:
            REPORT_ERROR(MSG_INCORRECT_NUMBER); return;
        case -12:
        case -3:
            REPORT_ERROR(MSG_INVALID_COMBINATION); return;
        case -13:
            REPORT_ERROR(MSG_286_287_INSTRUCTIONS); return;
        case -14:
            REPORT_ERROR(MSG_DIVISION_ZERO); return;
        case -15:
            REPORT_ERROR(MSG_FIELD_IDENTIFIER); return;
        }
        return;
    }
    while ((_ES = STRING_POOL_SEG, ES_B(_SI,STRPOOL_CHAR))) {
        _ES = STRING_POOL_SEG;
        if (ES_B(_SI,STRPOOL_CHAR)==0x1A) {
            ++_SI;
            data.value=0;
            for (code=0;code<4;++code) {
                data.value=(data.value<<4) + *((signed char far *)MK_FP(STRING_POOL_SEG,_SI)) - 0x61;
                ++_SI;
            }
            _DI=(unsigned int)data.value;
            _ES = VARIABLE_TABLE_SEG;
            if (ES_B(_DI,VAR_SYMBOL_KIND)==3 || ES_B(_DI,VAR_SYMBOL_KIND)==4) {
                _ES = VARIABLE_TABLE_SEG;
                NAME_HOOK(ES_W(_DI,VAR_SYMBOL));
            } else {
                _ES = VARIABLE_TABLE_SEG;
                if (ES_B(_DI,VAR_FLAGS)&2) {
                    PUT_CODE_STRING(REGISTER_NAME(ES_B(_DI,VAR_REGISTER),ES_B(_DI,VAR_TYPE_KIND)<=2 ? 2:6));
                } else {
                    _ES = VARIABLE_TABLE_SEG;
                    code=ES_W(_DI,VAR_FRAME_OFFSET);
                    PUT_CODE_STRING(STR_BP);
                    if (code) {
                        if (code>0) PUT_CODE_CHAR(0x2B);
                        EMIT_SIGNED_DECIMAL(code);
                    }
                    PUT_CODE_CHAR(0x5D);
                }
            }
        } else {
            _ES = STRING_POOL_SEG;
            PUT_CODE_CHAR(ES_SC(_SI,STRPOOL_CHAR));
            ++_SI;
        }
    }
    PUT_CODE_STRING(STR_ASM_STATEMENT_CRLF);
    _BX=SELECTED_SEGDEF_ENTRY;
    _ES=SEGDEF_POOL_SEG;
    *((long far *)MK_FP(_ES,_BX+SEGDEF_SIZE)) += 6;
}

/* ---- STAOV085 (listing ovr_1d6f_a49b:55FC) ---- */
extern unsigned int CODE_SEGMENT_ID;

/* PUT_CODE_STRING: PUT_CODE_CHAR for each character of 'text' (to the output directly
   when no code is being collected). */
void far pascal PUT_CODE_STRING(char far *text)
{
    if ((CODE_OUTPUT_FLAGS & 4) != 0) {
        if (*(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_INDEX) == CODE_SEGMENT_ID) {
            while (*text != 0) {
                PUT_CODE_CHAR(*text++);
            }
            return;
        }
    }
    BCC_OUTPUT_STRING(text);
}

/* ---- STAOV086 (listing ovr_1d6f_a49b:5644) ---- */
extern unsigned int CODE_SEGMENT_ID;

/* PUT_FAR_STRING: the same for the string at *segment:position. */
void far pascal PUT_FAR_STRING(unsigned int position, unsigned int near *segment)
{
    register unsigned int offset;
    register unsigned int near *segment_ptr;

    offset = position;
    segment_ptr = segment;
    if ((CODE_OUTPUT_FLAGS & 4) != 0) {
        if (*(unsigned int far *)MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_INDEX) == CODE_SEGMENT_ID) {
            while (*(char far *)MK_FP(*segment_ptr, offset) != 0) {
                PUT_CODE_CHAR(*(char far *)MK_FP(*segment_ptr, offset));
                offset++;
            }
            return;
        }
    }
    while (*(char far *)MK_FP(*segment_ptr, offset) != 0) {
        OUTPUT_CHAR(*(char far *)MK_FP(*segment_ptr, offset));
        offset++;
    }
}
