/* asmtext.c: from bcc20/src/output/ASMTEXT.C (overlay CO076): the core of BCC's
   assembly-text output, used when COMPILER_MODE is set (-S, or -B where TASM assembles the
   result).  The back end calls everything through a table of output hooks: for assembly
   output CREATE_ASM_OUTPUT copies ASM_TEXT_DEFAULT_HOOKS (96 bytes of far function
   pointers) over the live table that starts at EMIT_DEPENDENCY_HOOK.  So most functions
   here have an object-file twin with the same job.
   What is written, in file order:
   - CREATE_ASM_OUTPUT: creates <name>.asm, writes .286/.287 or .286p for the CPU and float
     options and the header (a dummy ?debug macro for assemblers other than TASM, then
     ?debug S "file"); EMIT_DEPENDENCY_RECORD adds a ?debug C E9 line (file time and name)
     per source file unless auto-dependencies are off.
   - EMIT_ASM_HEADER (on first output): group directives, "assume cs:..,ds:..", and the
     d@/d@w and b@/b@w base labels of the data and BSS segments.
   - per instruction: EMIT_ASM_INSTRUCTION writes one line from the opcode number and the
     two operands FIRST_ASM_OPERAND / SECOND_ASM_OPERAND, and adds the instruction's length
     (INSTRUCTION_SIZE) to the segment size, since the assembly path must know offsets
     without assembling.
   - EMIT_ASM_TRAILER (end): the string-literal block "s@ label byte" with every literal
     byte as db lines (printable runs quoted, up to 61 characters), extrn DGROUP@ and
     __turboFloat when needed, then "end".
   Segment and group names are passed to PUT_FAR_STRING as string-pool offsets with the
   address of the string-pool segment word.  Opcode numbers index OPCODE_DESCRIPTOR_TABLE
   (19-byte entries: mnemonic, length class, flags; flag 2 marks x87 instructions). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define OPTION_TARGET_CPU B(OPTION_TARGET_CPU_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define SEGMENT_LIST_HEAD W(SEGMENT_LIST_HEAD_P)

static void put_pool_string(u16 offset) { PUT_FAR_STRING(offset, FP_OFF(STRING_POOL_SEG_P)); }

/* value's low byte as two upper-case hex digits */
void EMIT_HEX_BYTE(u16 value)
{
    i16 digit = (value >> 4) & 0x0F;
    PUT_CODE_CHAR(digit < 10 ? digit + '0' : digit + 0x37);
    digit = value & 0x0F;
    PUT_CODE_CHAR(digit < 10 ? digit + '0' : digit + 0x37);
}

/* the STR_DEBUG_B text, probably the "?debug B" line that opens a block's debug scope */
void EMIT_DEBUG_B_DIRECTIVE(void)
{
    PUT_CODE_STRING(STR_DEBUG_B_P);
}

/* marks code node value in the fragment list, then writes STR_DEBUG_E, probably the
   matching "?debug E" line */
void EMIT_DEBUG_E_DIRECTIVE(u16 value)
{
    INSERT_NODE_MARK_FRAGMENT(value);
    PUT_CODE_STRING(STR_DEBUG_E_P);
}

/* assembly-output hook entries that just pass on to the common code */
void DEFINE_LABEL_ASM(u16 value)
{
    DEFINE_LABEL(value);
}

void ADD_JUMP_ASM(u16 kind, u16 node, u16 flag)
{
    ADD_JUMP(kind, node, flag);
}

/* a C++ thunk that adjusts "this" on the stack and jumps to the real function:
     mov bx,sp / add ss:[bx+<offset + 4 or 2>],<adjustment> / jmp far|near ptr <function>
   far set means a far function (the return address is 4 bytes, the jump far) */
void EMIT_THIS_ADJUST_THUNK_ASM(u16 function, u16 adjustment, u16 far_call, u16 offset)
{
    PUT_CODE_STRING(STR_MOV_BX_SP_P);
    PUT_CODE_STRING(STR_ADD_SS_BX_P);
    EMIT_DECIMAL(offset + (far_call ? 4 : 2));
    PUT_CODE_STRING(STR_RBRACKET_COMMA_P);
    EMIT_DECIMAL(adjustment);
    PUT_CODE_STRING(far_call ? STR_JMP_FAR_PTR_P : STR_JMP_NEAR_PTR_P);
    CALL_FAR(NAME_HOOK, A16(function));
    PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
}

/* installs the assembly hook table and opens the .asm file.  ASM_OUTPUT_PATH gets ".asm"
   added unless CODE_OUTPUT_FLAGS bit 0 is set (probably when -o gave a full name).  A file
   that cannot be created is fatal.  filename is the source name written into the header.
   The 80-byte path sits at bp-50h in BCC's frame */
void CREATE_ASM_OUTPUT(farptr filename)
{
    u16 mark = scratch_mark();
    farptr path = scratch_alloc(0x50);
    STRING_COPY(path, MK_FP(STRING_POOL_SEG, ASM_OUTPUT_PATH));
    memmove(at(EMIT_DEPENDENCY_HOOK_P), at(ASM_TEXT_DEFAULT_HOOKS_P), 96);
    if (!(CODE_OUTPUT_FLAGS & 1)) {
        STRING_APPEND(path, STR_ASM_2_P);
        u16 copy = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(path) + 1);
        ASM_OUTPUT_PATH = copy;
        STRING_COPY(MK_FP(STRING_POOL_SEG, ASM_OUTPUT_PATH), path);
    }
    if (CREATE_OUTPUT_FILE(path) == -1)
        REPORT_FATAL(MSG_UNABLE_CREATE_OUTPUT, path);
    if (OPTION_TARGET_CPU == 1) {
        PUT_CODE_STRING(STR_286_P);
        if (OPTION_FLOAT_MODE == 2)
            PUT_CODE_STRING(STR_287_P);
    } else if (OPTION_TARGET_CPU == 2) {
        PUT_CODE_STRING(STR_286P_P);
        if (OPTION_FLOAT_MODE == 2)
            PUT_CODE_STRING(STR_287_P);
    }
    PUT_CODE_STRING(STR_IFNDEF_VERSION_DEBUG_MACRO_E_P);
    PUT_CODE_STRING(filename);
    PUT_CODE_STRING(STR_QUOTE_CR_NL_P);
    scratch_release(mark);
}

/* "NAME\tgroup\tseg1,seg2,..." for group record value, listing every segment whose
   SEGDEF_GROUP is that group (a group record's name is at offset 4) */
void EMIT_GROUP_DEFINITION(u16 value)
{
    u16 emitted = 0;
    put_pool_string(SEGDEF_W(value, SEGGRP_NAME));
    PUT_CODE_STRING(STR_GROUP_P);
    for (u16 node = SEGMENT_LIST_HEAD; node != 0; node = SEGDEF_W(node, SEGDEF_NEXT))
        if (SEGDEF_W(node, SEGDEF_GROUP) == value) {
            if (emitted != 0)
                PUT_CODE_CHAR(',');
            put_pool_string(SEGDEF_W(node, SEGDEF_NAME));
            emitted = 1;
        }
    PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
}

/* the group name of segment record node, or its own name */
static u16 group_or_segment_name(u16 node)
{
    return SEGDEF_W(node, SEGDEF_GROUP) != 0 ? SEGDEF_W(SEGDEF_W(node, SEGDEF_GROUP), SEGGRP_NAME)
                                             : SEGDEF_W(node, SEGDEF_NAME);
}

/* the first part of the file body (ASM_OUTPUT_FLAGS bit 0 marks it done): opens and closes
   the code segment once, writes the groups (clearing each group record's own group word
   first), the assume line, and the d@/b@ labels at the start of the data and BSS segments;
   resets LINE_MARK_LAST_FILE */
void EMIT_ASM_HEADER(void)
{
    ASM_OUTPUT_FLAGS |= 1;
    EMIT_PROC_BEGIN(W(CODE_SEGMENT_ID_P));
    EMIT_PROC_BEGIN(0);
    for (u16 item = GROUP_LIST_HEAD; item != 0; item = SEGDEF_W(item, SEGDEF_NEXT)) {
        SEGDEF_W(item, SEGDEF_GROUP) = 0;
        EMIT_GROUP_DEFINITION(item);
    }
    PUT_CODE_STRING(STR_ASSUME_CS_2_P);
    put_pool_string(group_or_segment_name(FIND_SEGMENT(W(CODE_SEGMENT_ID_P))));
    PUT_CODE_STRING(STR_DS_P);
    put_pool_string(group_or_segment_name(FIND_SEGMENT(DATA_SEGMENT_ID)));
    PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
    EMIT_PROC_BEGIN(DATA_SEGMENT_ID);
    PUT_CODE_STRING(STR_D_LABEL_BYTE_D_W_LABEL_WORD_P);
    EMIT_PROC_BEGIN(BSS_SEGMENT_ID);
    PUT_CODE_STRING(STR_B_LABEL_BYTE_B_W_LABEL_WORD_P);
    LINE_MARK_LAST_FILE = 0;
}

static int printable(i8 c) { return c >= 0x20 && c <= 0x7E && c != '\''; }

/* the end of the file: "?debug C E9" (end of dependency list), groups that belong to
   another group, the literal block (DATA_BYTE_POOL_SEG, DATA_BYTE_POOL_LENGTH bytes) under
   "s@ label byte", "extrn DGROUP@:word" if a DS load needed it (ASM_OUTPUT_FLAGS bit 1),
   "extrn __turboFloat:word" if floating point was used, ASM_TRAILER_HOOK, and "\tend"
   followed by ^Z.  A printable byte starts a quoted run; it ends at a non-printable byte, a
   quote, the end, or after 60 more characters.  Other bytes are written as signed decimal
   numbers */
void EMIT_ASM_TRAILER(void)
{
    PUT_CODE_STRING(STR_DEBUG_C_E9_P);
    for (u16 current = GROUP_LIST_HEAD; current; current = SEGDEF_W(current, SEGDEF_NEXT))
        if (SEGDEF_W(current, SEGDEF_GROUP))
            EMIT_GROUP_DEFINITION(current);
    EMIT_PROC_BEGIN(DATA_SEGMENT_ID);
    PUT_CODE_STRING(STR_S_LABEL_BYTE_P);
    u16 pool = W(DATA_BYTE_POOL_SEG_P);
#define C(n) SB(MK_FP(pool, offset + (n)))
    for (u16 offset = 0, index = 0; index < DATA_BYTE_POOL_LENGTH; ++offset, ++index) {
        PUT_CODE_STRING(STR_DB_P);
        if (printable(C(0))) {
            PUT_CODE_CHAR('\'');
            PUT_CODE_CHAR(C(0));
            for (i16 count = 0; count < 60; ++count) {
                if (index + 1 == DATA_BYTE_POOL_LENGTH || !printable(C(1)))
                    break;
                ++offset;
                ++index;
                PUT_CODE_CHAR(C(0));
            }
            PUT_CODE_CHAR('\'');
        } else
            EMIT_SIGNED_DECIMAL(C(0));
        PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
    }
#undef C
    EMIT_PROC_BEGIN(W(CODE_SEGMENT_ID_P));
    if (ASM_OUTPUT_FLAGS & 2)
        PUT_CODE_STRING(STR_EXTRN_DGROUP_WORD_P);
    EMIT_PROC_BEGIN(0);
    if (CODE_OUTPUT_FLAGS & 2)
        PUT_CODE_STRING(STR_EXTRN_TURBOFLOAT_WORD_P);
    CALL_FAR0(ASM_TRAILER_HOOK);
    PUT_CODE_STRING(STR_END_CRLF_EOF_P);
}

/* switch dispatch through a jump table: "\tjmp\tword ptr cs:@<serial>@C<value>[bx]"; the
   segment size grows by 5 (the instruction's length) */
void EMIT_SWITCH_JUMP_ASM(u16 value)
{
    PUT_CODE_STRING(STR_JMP_WORD_PTR_CS_P);
    EMIT_DECIMAL(FUNCTION_SERIAL);
    PUT_CODE_STRING(STR_C_6_P);
    EMIT_DECIMAL(value);
    PUT_CODE_STRING(STR_BX_P);
    SEGDEF_L(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE) += 5;
}

/* "\tmov\tbx,offset @<serial>@C<value>": loads the address of a switch table */
void EMIT_SWITCH_TABLE_LOAD_ASM(u16 value)
{
    PUT_CODE_STRING(STR_MOV_BX_OFFSET_P);
    PUT_CODE_CHAR('@');
    EMIT_DECIMAL(FUNCTION_SERIAL);
    PUT_CODE_STRING(STR_C_6_P);
    EMIT_DECIMAL(value);
    PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
}

/* loads DS's value into register value: tiny model "mov reg,cs:DGROUP@" (and notes that
   DGROUP@ must be declared extrn), else "mov reg,<data group or segment>" */
void EMIT_LOAD_DATA_SEGMENT_ASM(u8 value)
{
    PUT_CODE_STRING(STR_MOV_P);
    PUT_CODE_STRING(REGISTER_NAME((i8)value, 6));
    if (B(OPTION_MEMORY_MODEL_P) == 0) {
        PUT_CODE_STRING(STR_CS_DGROUP_P);
        ASM_OUTPUT_FLAGS |= 2;
        return;
    }
    PUT_CODE_STRING(fp_add(STR_RBRACKET_COMMA_P, 1));
    put_pool_string(group_or_segment_name(FIND_SEGMENT(DATA_SEGMENT_ID)));
    PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
}

/* "\tjmp\tword ptr cs:[bx+<value>]", 5 bytes */
void EMIT_CS_JMP_BX_DISP_ASM(u16 value)
{
    PUT_CODE_STRING(STR_JMP_WORD_PTR_CS_BX_P);
    EMIT_DECIMAL(value);
    PUT_CODE_STRING(fp_add(STR_BX_P, 3));
    SEGDEF_L(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE) += 5;
}

/* pushes a return address that points past the next instruction: on an 8086 through CX,
   from the 186 on with push immediate */
void EMIT_PUSH_RETURN_ADDRESS_ASM(void)
{
    if (OPTION_TARGET_CPU == 0)
        PUT_CODE_STRING(STR_MOV_CX_OFFSET_7_PUSH_P);
    else
        PUT_CODE_STRING(STR_PUSH_OFFSET_6_P);
}

/* "\t?debug\tC E9" + the file time of source file text (4 bytes) + name length + the name,
   in hex, continued every 21 bytes; the same bytes a COMENT class E9h dependency record
   holds in an object file.  Not written with OPTION_NO_AUTODEPEND.  DEBUG_STATE is -1
   while writing */
void EMIT_DEPENDENCY_RECORD(farptr text)
{
    if (OPTION_NO_AUTODEPEND != 0)
        return;
    u16 length = STRING_LENGTH(text);
    u16 saved = W(DEBUG_STATE_P);
    W(DEBUG_STATE_P) = 0xFFFF;
    PUT_CODE_STRING(STR_DEBUG_C_3_P);
    EMIT_HEX_BYTE(0xE9);
    u32 stamp = (u32)FILE_TIME(text);
    EMIT_HEX_BYTE((u16)(i16)(i8)stamp);
    EMIT_HEX_BYTE((u16)(i16)(i8)(stamp >> 8));
    EMIT_HEX_BYTE((u16)(i16)(i8)(stamp >> 16));
    EMIT_HEX_BYTE((u16)(i16)(i8)(stamp >> 24));
    EMIT_HEX_BYTE(length);
    for (farptr cursor = text;;) {
        i16 count = 0;
        do {
            EMIT_HEX_BYTE((u16)(i16)SB(cursor));
            cursor = fp_add(cursor, 1);
            if (SB(cursor) == 0)
                goto done;
            count++;
        } while (count <= 20);
        PUT_CODE_STRING(STR_DEBUG_C_4_P);
    }
done:
    PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
    W(DEBUG_STATE_P) = saved;
}

/* an assembler operand (FIRST_ASM_OPERAND, SECOND_ASM_OPERAND: 9 bytes at a DS offset):
   kind, index (segment register), scale (second address register), reg (register or
   base), offset, symbol */
#define OPD_KIND(o) W(DSPTR(o))
#define OPD_INDEX(o) SB(DSPTR((o) + 2))
#define OPD_SCALE(o) SB(DSPTR((o) + 3))
#define OPD_REG(o) SB(DSPTR((o) + 4))
#define OPD_OFFSET(o) W(DSPTR((o) + 5))
#define OPD_SYMBOL(o) W(DSPTR((o) + 7))
#define FIRST FP_OFF(FIRST_ASM_OPERAND_P)
#define SECOND FP_OFF(SECOND_ASM_OPERAND_P)
/* an instruction descriptor (OPCODE_DESCRIPTOR_TABLE, 19 bytes): 0 the mnemonic (near), 2
   the length class, 3 the flags, 7 and on the tail */
#define DESC(op) fp_add(OPCODE_DESCRIPTOR_TABLE_P, (op) * 19)
#define DESC_NAME(op) DSPTR(W(DESC(op)))
#define DESC_LENGTH(op) SB(fp_add(DESC(op), 2))
#define DESC_FLAGS(op) D(fp_add(DESC(op), 3))
#define DESC_TAIL(op, i) B(fp_add(DESC(op), 7 + (i)))

/* the length in bytes of instruction kind with the current operands: the descriptor's
   base length plus the operand bytes.  Length class -1: 1 extra byte for a register
   operand, else 2 (ModRM form); -2: 2 or 3 bytes for the short accumulator-immediate form,
   else operands + 2.  Opcode 57h under the float emulator (OPTION_FLOAT_MODE 1) gets one
   byte more */
i16 INSTRUCTION_SIZE(u16 kind)
{
    u16 count = OPERAND_SIZE(FIRST, kind) + OPERAND_SIZE(SECOND, kind);
    if (kind == 0x57 && OPTION_FLOAT_MODE == 1)
        count++;
    i16 length = DESC_LENGTH(kind);
    if (length == -1)
        return OPD_KIND(FIRST) == 1 ? count + 1 : count + 2;
    if (length == -2) {
        if (OPD_KIND(SECOND) == 4 && OPD_KIND(FIRST) == 1 && OPD_REG(FIRST) == 0)
            return DESC_TAIL(kind, 0) == 2 ? 3 : 2;
        return count + 2;
    }
    return count + length;
}

/* the bytes an operand adds to instruction type: an immediate (kind 4) 1 or 2 bytes (1
   when the instruction takes a byte, or a sign-extended byte fits); kinds 2 and 3 (offset
   or segment of a symbol) 2; a memory operand (kind 5) its displacement, 0, 1 or 2 bytes,
   plus 1 for a segment override (index set).  Registers (kind 1) add nothing */
i16 OPERAND_SIZE(u16 operand, u16 type)
{
    switch (OPD_KIND(operand)) {
    case 4:
        if (DESC_TAIL(type, 0) == 0)
            return 1;
        if ((DESC_FLAGS(type) & 0x8000) == 0)
            return 2;
        if ((i16)OPD_OFFSET(operand) > 127 || (i16)OPD_OFFSET(operand) < -128)
            return 2;
        return 1;
    case 2:
    case 3:
        return 2;
    case 5: {
        i16 length = 0;
        if (OPD_INDEX(operand) != -1)
            length++;
        if (OPD_SYMBOL(operand) != 0)
            length += 2;
        else if (OPD_REG(operand) == -1 && OPD_SCALE(operand) == -1)
            length += 2;
        else if ((i16)OPD_OFFSET(operand) < -128 || (i16)OPD_OFFSET(operand) > 127)
            length += 2;
        else if (OPD_OFFSET(operand) != 0)
            length++;
        return length;
    }
    default:
        return 0;
    }
}

/* writes one instruction line "\tmnemonic\toperands".  Special cases before the normal
   form: opcode 78h (call) to a far function in the same code segment becomes "push cs /
   call"; A1h in a near function is written as "db 0cbh" (a far return); C8h..CAh are
   prefixes written with a space and no line end; x87 forms (descriptor flag 2) are
   "FCOMPP" or "nameP st(n),st(0)".  Operands follow by opcode */
void EMIT_ASM_INSTRUCTION(i16 opcode)
{
    u16 op = (u16)opcode;
    SEGDEF_L(SELECTED_SEGDEF_ENTRY, SEGDEF_SIZE) += INSTRUCTION_SIZE(op);
    PUT_CODE_CHAR(9);
    if (op == 0x78) {
        u16 symbol = OPD_SYMBOL(FIRST);
        if (!B(OPTION_MEMORY_MODEL_P) ||
            (symbol != 0 && (u16)CALL_FAR(GET_SYMBOL_KIND_HOOK, A16(symbol)) != 2 &&
             (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(symbol)) == FUNCTION_CODE_SEGMENT)) {
            PUT_CODE_STRING(STR_PUSH_CS_CALL_P);
            EMIT_ASM_OPERAND(FIRST, 0x12);
            goto newline;
        }
        goto normal;
    }
    if (op == 0xA1 && !(CODEGEN_FUNCTION_FLAGS & 1)) {
        PUT_CODE_STRING(STR_DB_0CBH_P);
        return;
    }
    if ((i16)op >= 0xC8 && (i16)op <= 0xCA) {
        PUT_CODE_STRING(DESC_NAME(op));
        PUT_CODE_CHAR(' ');
        return;
    }
    if (DESC_FLAGS(op) & 2) {
        if ((i16)op >= 0x82 && (i16)op <= 0x84 && OPD_KIND(FIRST) == 0) {
            PUT_CODE_STRING(STR_FCOMPP_P);
            return;
        }
        if (OPD_KIND(SECOND) == 1) {
            PUT_CODE_STRING(DESC_NAME(op));
            PUT_CODE_STRING(STR_P_ST_P);
            EMIT_DECIMAL((u16)(i16)OPD_REG(FIRST));
            PUT_CODE_STRING(STR_ST_0_P);
            return;
        }
    }
normal:
    PUT_CODE_STRING(DESC_NAME(op));
    PUT_CODE_CHAR(9);
    switch ((i16)op) {
    case 0xA1: case 0xA2:
        if (OPD_KIND(SECOND)) {
            EMIT_DECIMAL(OPD_OFFSET(SECOND));
            goto newline;
        }
        break;
    case 0xA4: case 0xA5: case 0x7B: case 0x7C:
        if (OPD_KIND(FIRST) != 4)
            EMIT_GROUP_PREFIX(OPD_SYMBOL(FIRST));
        EMIT_ASM_OPERAND(FIRST, 0);
        break;
    case 0x8C: case 0x8D:
        PUT_CODE_STRING(fp_add(STR_P_ST_P, 2));
        EMIT_DECIMAL((u16)(i16)OPD_REG(FIRST));
        PUT_CODE_STRING(fp_add(STR_ST_0_P, 8));
        return;
    case 0x3D: case 0x82: case 0x83: case 0x84:
    case 0x20: case 0x21: case 0x22:
    case 0x29: case 0x2A: case 0x2B: case 0x2C: case 0x2D: case 0x2E:
    case 0x33: case 0x34: case 0x35:
    case 0x38: case 0x39: case 0x3A: case 0x3B: case 0x3C:
        if (OPD_KIND(FIRST) != 1)
            goto fallback;
        PUT_CODE_STRING(STR_ST_0_ST_P);
        EMIT_DECIMAL((u16)(i16)OPD_REG(FIRST));
        PUT_CODE_STRING(fp_add(STR_ST_0_P, 8));
        return;
    case 0x92:
        EMIT_DECIMAL(OPD_OFFSET(SECOND));
        PUT_CODE_STRING(STR_0_P);
        return;
    case 0x72:
        EMIT_DECIMAL(OPD_OFFSET(FIRST));
        break;
    case 0x32:
        if (OPD_KIND(FIRST) == 4)
            PUT_CODE_STRING(STR_AX_AX_P);
        /* fall through */
    case 0x31: case 0x36: case 0x37:
    case 0x3F: case 0x41: case 0x42: case 0x43:
        EMIT_ASM_OPERAND(SECOND, INSN_OPERAND_FORMAT((i16)op));
        break;
    case 0x76:
        EMIT_ASM_OPERAND(FIRST, 7);
        break;
    case 0x78:
        EMIT_ASM_OPERAND(FIRST, 0x15);
        break;
    case 0x77:
        EMIT_ASM_OPERAND(FIRST, 0x12);
        break;
    default:
    fallback: {
        i16 format = op == 0x5D ? 7 : INSN_OPERAND_FORMAT((i16)op);
        EMIT_ASM_OPERAND(FIRST, DESC_TAIL(op, 2) == 1 ? 1 : format);
        if (OPD_KIND(SECOND)) {
            PUT_CODE_CHAR(',');
            if (DESC_TAIL(op, 3) == 7 || DESC_TAIL(op, 3) == 1)
                format = 1;
            EMIT_ASM_OPERAND(SECOND, format);
        }
        break;
    }
    }
newline:
    PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
}

/* the operand type (a type kind, used for "byte ptr" and register width) of instruction
   index, from byte 8 of its descriptor through ASM_OPERAND_FORMAT_MAP */
i16 INSN_OPERAND_FORMAT(i16 index)
{
    return ASM_OPERAND_FORMAT_MAP_AT(OPCODE_DESC_BYTE8_AT(index * 19));
}

/* the "byte/word/dword/qword/tbyte/far/near" word of a memory operand of type type */
static farptr ptr_word(i16 type)
{
    switch (type) {
    case 1: case 2: return STR_BYTE_2_P;
    case 10: return STR_QWORD_P;
    case 9: return STR_DWORD_P;
    case 11: return STR_TBYTE_P;
    case 21: return STR_FAR_5_P;
    case 18: return STR_NEAR_6_P;
    case 7: return STR_DWORD_P;
    default: return fp_add(STR_QWORD_P, 1);
    }
}

/* writes one operand.  kind 1: a register (or "st(n)" for x87 types); 4: an immediate; 2:
   "offset [group:]name[+n]"; 3: the segment of a symbol (its group or segment name, or "seg
   name"); 5: memory, with "byte/word/dword/qword/tbyte/far/near ptr" when type is given,
   an optional segment override, then name, [base+index+disp] or "ds:[n]" for an absolute
   address */
void EMIT_ASM_OPERAND(u16 operand, i16 type)
{
    i16 printed = 0;
    u16 symbol = OPD_SYMBOL(operand);
    switch (OPD_KIND(operand)) {
    case 1:
        if (EXPR_FLAGS_AT(type) & 2) {
            PUT_CODE_STRING(fp_add(STR_P_ST_P, 2));
            EMIT_DECIMAL((u16)(i16)OPD_REG(operand));
            PUT_CODE_STRING(STR_RPAREN_P);
        } else
            PUT_CODE_STRING(REGISTER_NAME(OPD_REG(operand), type <= 2 ? 2 : 6));
        break;
    case 4:
        if (type > 2)
            EMIT_DECIMAL(OPD_OFFSET(operand));
        else
            EMIT_DECIMAL(OPD_OFFSET(operand) & 255);
        break;
    case 2:
        PUT_CODE_STRING(fp_add(STR_MOV_BX_OFFSET_P, 8));
        EMIT_GROUP_PREFIX(symbol);
        if (symbol != 0) {
            CALL_FAR(NAME_HOOK, A16(symbol));
            printed = 1;
        }
        if (OPD_OFFSET(operand) != 0) {
            if (printed)
                PUT_CODE_CHAR('+');
            EMIT_DECIMAL(OPD_OFFSET(operand));
        }
        break;
    case 3: {
        i16 owner = (i16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(symbol));
        if ((u16)CALL_FAR(GET_SYMBOL_KIND_HOOK, A16(symbol)) == 3 &&
            (u8)CALL_FAR(SYMBOL_ELEMENT_KIND_HOOK, A16(symbol)) != 18 && owner != -1) {
            u16 node = FIND_SEGMENT(owner == 0 ? DATA_SEGMENT_ID : (u16)owner);
            put_pool_string(group_or_segment_name(node));
            return;
        }
        PUT_CODE_STRING(STR_SEG_P);
        if (symbol != 0)
            CALL_FAR(NAME_HOOK, A16(symbol));
        break;
    }
    case 5:
        if (type != 0) {
            PUT_CODE_STRING(ptr_word(type));
            PUT_CODE_STRING(fp_add(STR_JMP_FAR_PTR_P, 10));
        }
        if (OPD_INDEX(operand) != -1) {
            PUT_CODE_STRING(REGISTER_NAME(OPD_INDEX(operand), 6));
            PUT_CODE_CHAR(':');
        } else
            EMIT_GROUP_PREFIX(symbol);
        if (symbol != 0) {
            CALL_FAR(NAME_HOOK, A16(symbol));
            printed = 1;
        } else if (OPD_REG(operand) == -1 && OPD_SCALE(operand) == -1) {
            if (OPD_INDEX(operand) == -1)
                PUT_CODE_STRING(fp_add(STR_DS_P, 1));
            PUT_CODE_CHAR('[');
            EMIT_DECIMAL(OPD_OFFSET(operand));
            PUT_CODE_CHAR(']');
            break;
        }
        if (OPD_REG(operand) != -1 || OPD_SCALE(operand) != -1) {
            PUT_CODE_CHAR('[');
            printed = 0;
            if (OPD_REG(operand) != -1) {
                PUT_CODE_STRING(REGISTER_NAME(OPD_REG(operand), 6));
                printed = 1;
            }
            if (OPD_SCALE(operand) != -1) {
                if (printed)
                    PUT_CODE_CHAR('+');
                PUT_CODE_STRING(REGISTER_NAME(OPD_SCALE(operand), 6));
                printed = 1;
            }
            if (OPD_OFFSET(operand) != 0) {
                if (printed && (i16)OPD_OFFSET(operand) > 0)
                    PUT_CODE_CHAR('+');
                EMIT_SIGNED_DECIMAL((i16)OPD_OFFSET(operand));
            }
            PUT_CODE_CHAR(']');
        } else if (OPD_OFFSET(operand) != 0) {
            if (printed)
                PUT_CODE_CHAR('+');
            EMIT_DECIMAL(OPD_OFFSET(operand));
        }
        break;
    }
}

/* "GROUP:" before a reference to symbol value when its segment belongs to a group */
void EMIT_GROUP_PREFIX(u16 value)
{
    if (!value)
        return;
    u16 entry = FIND_SEGMENT((u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(value)));
    if (entry && SEGDEF_W(entry, SEGDEF_GROUP)) {
        put_pool_string(SEGDEF_W(SEGDEF_W(entry, SEGDEF_GROUP), SEGGRP_NAME));
        PUT_CODE_CHAR(':');
    }
}

/* one "db value" line */
void EMIT_DB_LINE(u8 value)
{
    PUT_CODE_STRING(STR_DB_P);
    EMIT_SIGNED_DECIMAL(value);
    PUT_CODE_STRING(STR_DB_LINE_CRLF_P);
}

/* a communal variable: "\tcomm\tfar|near name:type" for a single scalar of size 1, 2, 4, 8
   or 10; otherwise "\t$comm\tname,far|near,width,count" (count in hex with H when it is
   64K or more).  indirect set selects far */
void EMIT_COMM_DECLARATION(u16 node, u16 indirect, u16 width, u32 count)
{
    if (count == 1 && (width == 1 || width == 2 || width == 4 || width == 8 || width == 10)) {
        PUT_CODE_STRING(STR_COMM_P);
        PUT_CODE_STRING(indirect != 0 ? STR_FAR_3_P : STR_NEAR_4_P);
        CALL_FAR(NAME_HOOK, A16(node));
        PUT_CODE_CHAR(':');
        u8 kind = (u8)CALL_FAR(SYMBOL_ELEMENT_KIND_HOOK, A16(node));
        PUT_CODE_STRING(D(fp_add(ASM_TYPE_NAME_TABLE_P, kind * 4)));
        return;
    }
    PUT_CODE_STRING(STR_COMM_2_P);
    CALL_FAR(NAME_HOOK, A16(node));
    PUT_CODE_CHAR(',');
    PUT_CODE_STRING(indirect != 0 ? STR_FAR_4_P : STR_NEAR_5_P);
    EMIT_DECIMAL(width);
    PUT_CODE_CHAR(',');
    if (count >= 0x10000) {
        EMIT_HEX_BYTE((u16)(count >> 24));
        EMIT_HEX_BYTE((u16)(count >> 16));
        EMIT_HEX_BYTE((u16)(count >> 8));
        EMIT_HEX_BYTE((u16)count);
        PUT_CODE_CHAR('H');
    } else
        EMIT_DECIMAL((u16)count);
}
