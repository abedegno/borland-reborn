/* asmcode.c: from bcc20/src/inlasm/ASMCODE.C: the machine-code side of instruction output,
   used when BCC writes an object file directly.  The code generator (emitinsn.c) and the
   inline assembler describe each instruction the same way: an opcode number (an index into
   OPCODE_DESCRIPTOR_TABLE) and two operand records, FIRST_ASM_OPERAND (LEFT) and
   SECOND_ASM_OPERAND (RIGHT).  In object mode the output hook table points here and
   ENCODE_ASM_INSTRUCTION turns that description into bytes; in assembly mode the same calls
   reach asmtext.c, which prints the instruction instead.  Most functions here have such a
   text twin (EMIT_SWITCH_JUMP and EMIT_SWITCH_JUMP_ASM, OPEN_OUTPUT_FILE and
   CREATE_ASM_OUTPUT, ...).
   Code bytes go to the code buffer CODE_BYTE_POOL_SEG (EMIT_CODE_BYTE/WORD), which grows
   past OUTPUT_BUFFER_LIMIT through POOL_ALLOC, and the selected segment's size grows with
   them.  Addresses not known yet become fixups (ADD_FIXUP, by kind: 1 offset of a symbol,
   3 its segment, 5 offset of a code label or switch table, 6 near call (self-relative), 7
   far address, 10 the data group's segment, 11 a named external, 16 the location's own
   offset).
   Register numbers 12..15 are ES, DS, CS, SS (see SEGMENT_PREFIX_OFFSET);
   REGISTER_ENCODING_TABLE maps a register number to its 3-bit machine encoding.  x87
   instructions (descriptor flag 2) under the emulator get an FWAIT (9Bh) and named fixups to
   FIDRQQ, FIERQQ, FIARQQ/FJARQQ and similar symbols in front, so that the emulator library
   can patch them at link time. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "fields.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define CODE_BYTE_POOL_SEG W(CODE_BYTE_POOL_SEG_P)
#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define OPTION_TARGET_CPU B(OPTION_TARGET_CPU_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)

/* an operand record (9 bytes at a DS offset): kind (1 register, 2 offset of a symbol, 3
   segment of a symbol, 4 immediate, 5 memory), index (segment override register), scale
   (index register), reg (register, or base register), offset (immediate or displacement),
   symbol */
#define OPD_KIND(o) W(DSPTR(o))
#define OPD_INDEX(o) SB(DSPTR((o) + 2))
#define OPD_SCALE(o) SB(DSPTR((o) + 3))
#define OPD_REG(o) SB(DSPTR((o) + 4))
#define OPD_OFFSET(o) W(DSPTR((o) + 5))
#define OPD_SYMBOL(o) W(DSPTR((o) + 7))
#define LEFT FP_OFF(FIRST_ASM_OPERAND_P)
#define RIGHT FP_OFF(SECOND_ASM_OPERAND_P)
#define COPY_LEFT_TO_RIGHT() memmove(at(SECOND_ASM_OPERAND_P), at(FIRST_ASM_OPERAND_P), 9)
/* an instruction descriptor (19 bytes): the mnemonic (near), a pad byte, the flags (long),
   6 bytes, then prefix, opcode and mode words: opcode bytes or ModRM /digit values, used
   differently by each encoding */
#define DESC_FLAGS(d) D(fp_add((d), 3))
#define DESC_PREFIX(d) W(fp_add((d), 13))
#define DESC_OPCODE(d) W(fp_add((d), 15))
#define DESC_MODE(d) W(fp_add((d), 17))

#define CODE(n) EMIT_CODE_BYTE((u8)(n))
#define WORD(n) EMIT_CODE_WORD((u16)(n))
#define COMMENT(n) ADD_NAMED_FIXUP(n)
#define FORMAT(p, n) EMIT_MODRM((p), (u16)(n))

/* the selected segment's size */
#define SELECTED_SEGMENT_SIZE D(MK_FP(SEGDEF_POOL_SEG, SELECTED_SEGDEF_ENTRY + SEGDEF_SIZE))

/* one byte to the code buffer; the selected segment's size grows by 1 */
void EMIT_CODE_BYTE(u8 value)
{
    if (OUTPUT_BUFFER_POS >= OUTPUT_BUFFER_LIMIT) {
        u16 at_offset = POOL_ALLOC(CODE_BYTE_POOL_SEG_P, 1);
        B(MK_FP(CODE_BYTE_POOL_SEG, at_offset)) = value;
    } else {
        B(MK_FP(CODE_BYTE_POOL_SEG, OUTPUT_BUFFER_POS)) = value;
        ++OUTPUT_BUFFER_POS;
    }
    ++SELECTED_SEGMENT_SIZE;
}

/* a little-endian word to the code buffer; the segment's size grows by 2 */
void EMIT_CODE_WORD(u16 value)
{
    if ((u16)(OUTPUT_BUFFER_POS + 1) >= OUTPUT_BUFFER_LIMIT) {
        u16 at_offset = POOL_ALLOC(CODE_BYTE_POOL_SEG_P, 2);
        W(MK_FP(CODE_BYTE_POOL_SEG, at_offset)) = value;
    } else {
        W(MK_FP(CODE_BYTE_POOL_SEG, OUTPUT_BUFFER_POS)) = value;
        OUTPUT_BUFFER_POS += 2;
    }
    SELECTED_SEGMENT_SIZE += 2;
}

/* the machine encoding (0..7) of register number reg */
i16 REGISTER_ENCODING(i8 reg)
{
    return REGISTER_ENCODING_TABLE_AT(reg);
}

/* object-mode hook entries passing straight on to DEFINE_LABEL and ADD_JUMP; the small
   ADD_*_FIXUP helpers after them name the fixup kinds */
void DEFINE_ASM_LABEL(u16 node)
{
    DEFINE_LABEL(node);
}

void ADD_ASM_JUMP(u16 kind, u16 node, u16 flag)
{
    ADD_JUMP(kind, node, flag);
}

void ADD_OFFSET_FIXUP(u16 node)
{
    ADD_FIXUP_KIND(1, node);
}

void ADD_FAR_CALL_FIXUP(u16 node)
{
    ADD_FIXUP_KIND(7, node);
}

void ADD_NEAR_CALL_FIXUP(u16 node)
{
    ADD_FIXUP_KIND(6, node);
}

void ADD_FIXUP_KIND_3(u16 node)
{
    ADD_FIXUP_KIND(3, node);
}

void ADD_FIXUP_KIND(i8 kind, u16 node)
{
    ADD_FIXUP((u16)(i16)kind, node);
}

/* a C++ "this"-adjusting thunk as data bytes in the current segment:
     mov bx,sp / add word ptr ss:[bx+offset+2 or 4],addend / jmp near|far target
   with the short (83h, 8-bit) or long (81h) add and an 8- or 16-bit displacement as the
   values need.  far_jump selects the far jump (EAh with a far address) and the 4-byte
   return address; the near jump (E9h) gets a self-relative fixup.  Text twin:
   EMIT_THIS_ADJUST_THUNK_ASM */
void EMIT_THIS_ADJUST_THUNK(u16 target, i16 addend, i16 far_jump, i16 offset)
{
    EMIT_DATA_BYTE(0x8B);
    EMIT_DATA_BYTE(0xDC);
    EMIT_DATA_BYTE(0x36);
    EMIT_DATA_BYTE(addend > 127 || addend < -128 ? 0x81 : 0x83);
    offset += far_jump ? 4 : 2;
    if (offset > 127) {
        EMIT_DATA_BYTE(0x87);
        EMIT_DATA_BYTE((u8)offset);
        EMIT_DATA_BYTE((u8)(offset >> 8));
    } else {
        EMIT_DATA_BYTE(0x47);
        EMIT_DATA_BYTE((u8)offset);
    }
    if (addend > 127 || addend < -128) {
        EMIT_DATA_BYTE((u8)addend);
        EMIT_DATA_BYTE((u8)(addend >> 8));
    } else
        EMIT_DATA_BYTE((u8)addend);
    if (far_jump) {
        EMIT_DATA_BYTE(0xEA);
        EMIT_DWORD_RELOC(target, 0);
    } else {
        EMIT_DATA_BYTE(0xE9);
        ADD_RELOCATION(6, target);
        EMIT_DATA_BYTE(0);
        EMIT_DATA_BYTE(0);
    }
}

/* installs the object-file hook table (OBJ_OUTPUT_DEFAULT_HOOKS, 96 bytes, over the live
   table at EMIT_DEPENDENCY_HOOK), creates <name>.obj (".obj" added unless CODE_OUTPUT_FLAGS
   bit 0 is set), stores the final name back in ASM_OUTPUT_PATH and writes the module header
   (THEADR, translator name) for the source file filename.  Failing to create it is fatal.
   The 80-byte path sits at bp-50h in BCC's frame */
void OPEN_OUTPUT_FILE(farptr filename)
{
    u16 mark = scratch_mark();
    farptr path = scratch_alloc(0x50);
    STRING_COPY(path, MK_FP(STRING_POOL_SEG, ASM_OUTPUT_PATH));
    memmove(at(EMIT_DEPENDENCY_HOOK_P), at(OBJ_OUTPUT_DEFAULT_HOOKS_P), 96);
    if (!(CODE_OUTPUT_FLAGS & 1))
        STRING_APPEND(path, STR_OBJ_3_P);
    if (CREATE_OUTPUT_FILE(path) == -1)
        REPORT_FATAL(MSG_UNABLE_CREATE_OUTPUT, path);
    STRING_COPY(MK_FP(STRING_POOL_SEG, ASM_OUTPUT_PATH), path);
    OBJ_WRITE_MODULE_HEADER(filename);
    scratch_release(mark);
}

/* jmp word ptr cs:[bx+table] (2Eh FFh A7h disp16) through switch table node */
void EMIT_SWITCH_JUMP(u16 node)
{
    EMIT_CODE_BYTE(0x2E);
    EMIT_CODE_BYTE(0xFF);
    EMIT_CODE_BYTE(0xA7);
    ADD_FIXUP_KIND(5, node);
    EMIT_CODE_WORD(0);
}

/* mov bx,offset table (BBh imm16) for switch table node */
void EMIT_SWITCH_TABLE_LOAD(u16 node)
{
    EMIT_CODE_BYTE(0xBB);
    ADD_FIXUP_KIND(5, node);
    EMIT_CODE_WORD(0);
}

/* loads the data segment's value into BP (kind 10) or AX: in the tiny model from the word
   DGROUP@ in the code segment (mov reg,cs:DGROUP@), else as an immediate fixed up to the
   data group (mov reg,seg DGROUP, fixup kind 10) */
void EMIT_LOAD_DATA_SEGMENT(u8 kind)
{
    if (OPTION_MEMORY_MODEL == 0) {
        EMIT_CODE_BYTE(0x2E);
        EMIT_CODE_BYTE(0x8B);
        EMIT_CODE_BYTE((u8)((kind == 10 ? 0x28 : 0) + 6));
        ADD_OFFSET_FIXUP((u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(FP_OFF(STR_DGROUP_2_P)), A16(1)));
    } else {
        EMIT_CODE_BYTE(kind == 10 ? 0xBD : 0xB8);
        ADD_FIXUP_KIND(10, 0);
    }
    EMIT_CODE_WORD(0);
}

/* pushes the address just past the following jump as a return address: on an 8086
   "mov cx,offset $+6 / push cx", else "push offset $+5" (fixup kind 16 adds the location's
   own offset) */
void EMIT_PUSH_RETURN_ADDRESS(void)
{
    if (OPTION_TARGET_CPU == 0) {
        EMIT_CODE_BYTE(0xB9);
        ADD_FIXUP_KIND(16, 0);
        EMIT_CODE_WORD(6);
        EMIT_INSN_REG(0x94, 6);
    } else {
        EMIT_CODE_BYTE(0x68);
        ADD_FIXUP_KIND(16, 0);
        EMIT_CODE_WORD(5);
    }
}

/* jmp word ptr cs:[bx+value], with an 8-bit displacement when value is below 80h */
void EMIT_CS_JMP_BX_DISP(i16 value)
{
    EMIT_CODE_BYTE(0x2E);
    EMIT_CODE_BYTE(0xFF);
    if (value < 0x80) {
        EMIT_CODE_BYTE(0x67);
        EMIT_CODE_BYTE((u8)value);
    } else {
        EMIT_CODE_BYTE(0xA7);
        EMIT_CODE_WORD((u16)value);
    }
}

/* a fixup (kind 11) to the external called name (a DS offset), declaring it on first use
   (DECLARE_NAMED_GLOBAL_HOOK); used for the floating-point emulator symbols */
void ADD_NAMED_FIXUP(u16 name)
{
    ADD_FIXUP_KIND(11, (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(name), A16(1)));
}

/* mov/xchg-style two-operand forms share this tail: opcode byte, then the ModRM of the
   memory side with the register side in the reg field */
static void out_modrm(u16 value, u16 operand, i16 bits)
{
    CODE(value);
    FORMAT(operand, bits);
}

/* encodes instruction number instruction with the operands LEFT and RIGHT into the code
   buffer.  A memory operand's segment override becomes a prefix byte (26h + offset), and
   the descriptor's own prefix follows, except for x87 instructions, which handle their
   prefixes in their own case.  The switch has one case group per encoding pattern: for
   example 72h int (int 3 is CCh), 70h/71h in, 6Eh/6Fh out, 7Fh pop, 94h push, 9Bh/9Ch mov
   byte/word, 32h imul, 77h near call, 78h call (far, or "push cs; call near" when the target
   is in the function's own code segment), A4h/A5h dw/dd with relocation, 7Ah a single data
   byte, and the long list of x87 instructions.  COMMENT(n) adds an emulator fixup named by
   the string at DS offset n (FIARQQ..FIWRQQ at DS:54E7..551F) */
void ENCODE_ASM_INSTRUCTION(i16 instruction)
{
    farptr description = fp_add(OPCODE_DESCRIPTOR_TABLE_P, instruction * 19);
    i8 segment = OPERAND_SEGMENT_OVERRIDE(LEFT);
    if (segment == -1)
        segment = OPERAND_SEGMENT_OVERRIDE(RIGHT);
    if (!(DESC_FLAGS(description) & 2)) {
        if (segment != -1)
            CODE(SEGMENT_PREFIX_OFFSET(segment) + 0x26);
        if (DESC_PREFIX(description))
            CODE(DESC_PREFIX(description));
    }
    i16 value, bits;
    u16 symbol;
    switch (instruction) {
    case 0x0:
        CODE(0x90);
        break;
    case 0x7B:
    case 0x7C:
        EMIT_IMMEDIATE_OPERAND(1);
        break;
    case 0xA4:
        EMIT_WORD_RELOC(OPD_SYMBOL(LEFT), OPD_OFFSET(LEFT));
        break;
    case 0xA5:
        EMIT_DWORD_RELOC(OPD_SYMBOL(LEFT), OPD_OFFSET(LEFT));
        break;
    case 0x7A:
        CODE(OPD_OFFSET(LEFT));
        break;
    case 0x72:
        if (OPD_OFFSET(LEFT) == 3)
            CODE(0xCC);
        else {
            CODE(0xCD);
            CODE(OPD_OFFSET(LEFT));
        }
        break;
    case 0x70:
    case 0x71:
        if (OPD_KIND(RIGHT) == 4) {
            CODE(instruction == 0x70 ? 0xE4 : 0xE5);
            CODE(OPD_OFFSET(RIGHT));
        } else
            CODE(instruction == 0x70 ? 0xEC : 0xED);
        break;
    case 0x6E:
    case 0x6F:
        if (OPD_KIND(LEFT) != 1) {
            CODE(instruction == 0x6E ? 0xE6 : 0xE7);
            CODE(OPD_OFFSET(LEFT));
        } else
            CODE(instruction == 0x6E ? 0xEE : 0xEF);
        break;
    /* the x87 instructions */
    case 0x20: case 0x21: case 0x22: case 0x29: case 0x2A: case 0x2B: case 0x2C: case 0x2D:
    case 0x2E: case 0x33: case 0x34: case 0x35: case 0x38: case 0x39: case 0x3A: case 0x3B:
    case 0x3C: case 0x3D: case 0x52: case 0x5C: case 0x5D: case 0x5E: case 0x5F: case 0x60:
    case 0x61: case 0x62: case 0x63: case 0x64: case 0x65: case 0x66: case 0x67: case 0x68:
    case 0x69: case 0x6A: case 0x6B: case 0x6C: case 0x82: case 0x83: case 0x84: case 0x87:
    case 0x88: case 0x89: case 0x8A: case 0x8B: case 0x8C: case 0x8D: case 0x8E: case 0x8F:
    case 0x90: case 0x91: case 0xD5:
        switch (segment) {
        case 13:
            COMMENT(0x54E7);
            CODE(0x9B);
            COMMENT(0x54EE);
            CODE(0x3E);
            break;
        case 12:
            COMMENT(0x54F5);
            CODE(0x9B);
            CODE(0x26);
            break;
        case 15:
            COMMENT(0x54FC);
            CODE(0x9B);
            COMMENT(0x5503);
            CODE(0x36);
            break;
        case 14:
            COMMENT(0x550A);
            CODE(0x9B);
            COMMENT(0x5511);
            CODE(0x2E);
            break;
        default:
            COMMENT(0x5518);
            CODE(0x9B);
            break;
        }
        if (OPD_KIND(LEFT) == 0)
            WORD(DESC_PREFIX(description));
        else if (OPD_KIND(LEFT) == 1) {
            if (OPD_KIND(RIGHT) == 1)
                WORD(DESC_PREFIX(description) - 0x100 + (OPD_REG(LEFT) << 8));
            else
                WORD(DESC_OPCODE(description) + (OPD_REG(LEFT) << 8));
        } else {
            CODE(DESC_MODE(description));
            FORMAT(LEFT, DESC_MODE(description) >> 8);
        }
        break;
    case 0x57:
        COMMENT(0x551F);
        WORD(0x9B90);
        break;
    case 0x92:
        WORD(OPD_OFFSET(RIGHT));
        CODE(0);
        break;
    case 0x5A:
        CODE(0xFE);
        FORMAT(LEFT, 8);
        break;
    case 0x5B:
        if (OPD_KIND(LEFT) == 1)
            CODE(REGISTER_ENCODING(OPD_REG(LEFT)) + 0x48);
        else {
            CODE(0xFF);
            FORMAT(LEFT, 8);
        }
        break;
    case 0x58:
        CODE(0xFE);
        FORMAT(LEFT, 0);
        break;
    case 0x59:
        if (OPD_KIND(LEFT) == 1)
            CODE(REGISTER_ENCODING(OPD_REG(LEFT)) + 0x40);
        else {
            CODE(0xFF);
            FORMAT(LEFT, 0);
        }
        break;
    case 0x7F:
        if (OPD_KIND(LEFT) == 1) {
            if (OPD_REG(LEFT) >= 12 && OPD_REG(LEFT) <= 15)
                CODE(SEGMENT_PREFIX_OFFSET(OPD_REG(LEFT)) + 7);
            else
                CODE(REGISTER_ENCODING(OPD_REG(LEFT)) + 0x58);
        } else {
            CODE(0x8F);
            FORMAT(LEFT, 0);
        }
        break;
    case 0x94:
        if (OPD_KIND(LEFT) == 1) {
            if (OPD_REG(LEFT) >= 12 && OPD_REG(LEFT) <= 15)
                CODE(SEGMENT_PREFIX_OFFSET(OPD_REG(LEFT)) + 6);
            else
                CODE(REGISTER_ENCODING(OPD_REG(LEFT)) + 0x50);
        } else if (OPD_KIND(LEFT) == 4) {
            value = (i16)OPD_OFFSET(LEFT);
            if (value <= 127 && value >= -128) {
                CODE(0x6A);
                CODE(value & 0xFF);
            } else {
                CODE(0x68);
                WORD(value);
            }
        } else if (OPD_KIND(LEFT) == 2 || OPD_KIND(LEFT) == 3) {
            CODE(0x68);
            COPY_LEFT_TO_RIGHT();
            EMIT_IMMEDIATE_OPERAND(0);
        } else {
            CODE(0xFF);
            FORMAT(LEFT, 0x30);
        }
        break;
    case 0x50:
    case 0x51:
    case 0x53:
    case 0x54:
        FORMAT(LEFT, DESC_OPCODE(description));
        break;
    case 0x31: case 0x36: case 0x37: case 0x3E: case 0x3F: case 0x40: case 0x41: case 0x42:
    case 0x43:
        FORMAT(RIGHT, DESC_OPCODE(description));
        break;
    case 0x32:
        if (OPD_KIND(LEFT) == 4) {
            value = (i16)OPD_OFFSET(LEFT);
            if (value <= 127 && value >= -128) {
                CODE(0x6B);
                CODE(0xC0);
                CODE(value & 0xFF);
            } else {
                CODE(0x69);
                CODE(0xC0);
                WORD(value);
            }
        } else {
            CODE(0xF7);
            FORMAT(RIGHT, DESC_OPCODE(description));
        }
        break;
    case 0x9B:
        if (OPD_KIND(RIGHT) == 4) {
            if (OPD_KIND(LEFT) == 1)
                CODE(REGISTER_ENCODING(OPD_REG(LEFT)) + 0xB0);
            else {
                CODE(0xC6);
                FORMAT(LEFT, 0);
            }
            EMIT_IMMEDIATE_OPERAND(0);
            break;
        }
        value = 0x88;
        if (OPD_KIND(LEFT) == 1) {
            if (OPD_KIND(RIGHT) == 1 && OPD_REG(RIGHT) >= 12 && OPD_REG(RIGHT) <= 15) {
                out_modrm(0x8C, LEFT, SEGMENT_PREFIX_OFFSET(OPD_REG(RIGHT)));
                break;
            }
            if (OPD_REG(LEFT) == 0 && OPD_KIND(RIGHT) != 1 && OPD_REG(RIGHT) == -1 && OPD_SCALE(RIGHT) == -1) {
                FORMAT(RIGHT, 0x9A);
                break;
            }
            value += 2;
            bits = REGISTER_ENCODING(OPD_REG(LEFT)) << 3;
        } else {
            if (OPD_REG(RIGHT) == 0 && OPD_REG(LEFT) == -1 && OPD_SCALE(LEFT) == -1) {
                FORMAT(LEFT, 0x9C);
                break;
            }
            bits = REGISTER_ENCODING(OPD_REG(RIGHT)) << 3;
            COPY_LEFT_TO_RIGHT();
        }
        out_modrm((u16)value, RIGHT, bits);
        break;
    case 0x9C:
        if (OPD_KIND(RIGHT) == 4 || OPD_KIND(RIGHT) == 2 || OPD_KIND(RIGHT) == 3) {
            if (OPD_KIND(LEFT) == 1) {
                value = REGISTER_ENCODING(OPD_REG(LEFT)) + 0xB8;
                CODE(value);
            } else {
                CODE(0xC7);
                FORMAT(LEFT, 0);
            }
            EMIT_IMMEDIATE_OPERAND(1);
            break;
        }
        value = 0x89;
        if (OPD_KIND(LEFT) == 1) {
            if (OPD_REG(LEFT) >= 12 && OPD_REG(LEFT) <= 15) {
                out_modrm(0x8E, RIGHT, SEGMENT_PREFIX_OFFSET(OPD_REG(LEFT)));
                break;
            }
            if (OPD_KIND(RIGHT) == 1 && OPD_REG(RIGHT) >= 12 && OPD_REG(RIGHT) <= 15) {
                out_modrm(0x8C, LEFT, SEGMENT_PREFIX_OFFSET(OPD_REG(RIGHT)));
                break;
            }
            if (OPD_REG(LEFT) == 0 && OPD_KIND(RIGHT) != 1 && OPD_REG(RIGHT) == -1 && OPD_SCALE(RIGHT) == -1) {
                FORMAT(RIGHT, 0x9B);
                break;
            }
            value += 2;
            bits = REGISTER_ENCODING(OPD_REG(LEFT)) << 3;
        } else {
            if (OPD_REG(RIGHT) >= 12 && OPD_REG(RIGHT) <= 15) {
                out_modrm(0x8C, LEFT, SEGMENT_PREFIX_OFFSET(OPD_REG(RIGHT)));
                break;
            }
            if (OPD_REG(RIGHT) == 0 && OPD_REG(LEFT) == -1 && OPD_SCALE(LEFT) == -1) {
                FORMAT(LEFT, 0x9D);
                break;
            }
            bits = REGISTER_ENCODING(OPD_REG(RIGHT)) << 3;
            COPY_LEFT_TO_RIGHT();
        }
        out_modrm((u16)value, RIGHT, bits);
        break;
    case 0x85:
    case 0x86:
        if (ENCODE_IMMEDIATE_FORM(instruction, description))
            break;
        CODE(DESC_OPCODE(description));
        if (OPD_KIND(LEFT) == 1)
            FORMAT(RIGHT, REGISTER_ENCODING(OPD_REG(LEFT)) << 3);
        else
            FORMAT(LEFT, REGISTER_ENCODING(OPD_REG(RIGHT)) << 3);
        break;
    case 0x1C: case 0x1D: case 0x1E: case 0x1F: case 0x23: case 0x24: case 0x25: case 0x26:
    case 0x27: case 0x28: case 0x2F: case 0x30: case 0x4A: case 0x4B: case 0x4C: case 0x4D:
    case 0x4E: case 0x4F: case 0x80: case 0x81: case 0x9A:
        if (ENCODE_IMMEDIATE_FORM(instruction, description))
            break;
        value = (i16)DESC_OPCODE(description);
        if (OPD_KIND(LEFT) == 1) {
            CODE(value + 2);
            FORMAT(RIGHT, REGISTER_ENCODING(OPD_REG(LEFT)) << 3);
        } else {
            CODE(value);
            FORMAT(LEFT, REGISTER_ENCODING(OPD_REG(RIGHT)) << 3);
        }
        break;
    case 0x95:
    case 0x96:
        FORMAT(RIGHT, REGISTER_ENCODING(OPD_REG(LEFT)) << 3);
        break;
    case 0x44: case 0x45: case 0x46: case 0x47: case 0x48: case 0x49: case 0x55: case 0x56:
    case 0xD3: case 0xD4:
        if (OPD_KIND(RIGHT) == 4 && OPD_OFFSET(RIGHT) != 1)
            value = 0xC0;
        else {
            value = 0xD0;
            if (OPD_KIND(RIGHT) != 4)
                value += 2;
        }
        CODE(value + DESC_OPCODE(description));
        FORMAT(LEFT, DESC_MODE(description));
        if (OPD_KIND(RIGHT) == 4 && OPD_OFFSET(RIGHT) != 1)
            CODE(OPD_OFFSET(RIGHT) & 0xFF);
        break;
    case 0xA1:
    case 0xA2:
        if (OPD_KIND(RIGHT) != 0) {
            CODE(DESC_OPCODE(description));
            WORD(OPD_OFFSET(RIGHT));
        } else
            CODE(DESC_MODE(description));
        break;
    case 0x75:
    case 0x76:
        if (OPD_KIND(LEFT) == 1)
            CODE(REGISTER_ENCODING(OPD_REG(LEFT)) + 0xD0);
        else
            FORMAT(LEFT, DESC_OPCODE(description));
        break;
    case 0x77:
        symbol = OPD_SYMBOL(LEFT);
        CODE(0xE8);
        ADD_NEAR_CALL_FIXUP(symbol);
        WORD(0);
        break;
    case 0x78:
        symbol = OPD_SYMBOL(LEFT);
        if (OPTION_MEMORY_MODEL &&
            (!symbol || (u16)CALL_FAR(GET_SYMBOL_KIND_HOOK, A16(symbol)) == 2 ||
             (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(symbol)) != FUNCTION_CODE_SEGMENT)) {
            CODE(0x9A);
            ADD_FAR_CALL_FIXUP(symbol);
            WORD(0);
            WORD(0);
        } else {
            CODE(0x0E);
            CODE(0xE8);
            ADD_NEAR_CALL_FIXUP(symbol);
            WORD(0);
        }
        break;
    }
}

/* the segment-override register of a memory operand, or -1 */
i8 OPERAND_SEGMENT_OVERRIDE(u16 operand)
{
    if (OPD_KIND(operand) == 5)
        return OPD_INDEX(operand);
    return -1;
}

/* the offset of segment register reg in the segment-register opcode pattern: ES 0, CS 8,
   SS 16, DS 24.  Added to 26h it gives the override prefix, to 06h/07h push/pop, and as a
   ModRM reg field it selects the register in mov to or from segment registers */
i16 SEGMENT_PREFIX_OFFSET(i8 reg)
{
    switch (reg) {
    case 12:
        return 0;
    case 15:
        return 16;
    case 13:
        return 24;
    case 14:
        return 8;
    default:
        return 8;
    }
}

/* if RIGHT is an immediate (or a symbol's offset or segment), encodes an arithmetic
   instruction in its immediate form and returns 1; else returns 0.  With AL/AX as LEFT the
   short accumulator form (the descriptor's mode) is used; otherwise 80h/81h/83h (83h, a
   sign-extended byte, when the descriptor allows it, flag 8000h, and the value fits), or
   F6h/F7h for opcodes 85h and up (test).  The original tests reg==0 twice */
i16 ENCODE_IMMEDIATE_FORM(i16 opcode, farptr desc)
{
    i16 mode;
    switch (OPD_KIND(RIGHT)) {
    case 2:
    case 3:
    case 4:
        if (OPD_KIND(LEFT) == 1 && OPD_REG(LEFT) == 0) {
            EMIT_CODE_BYTE((u8)DESC_MODE(desc));
            mode = DESC_OPCODE(desc) & 1;
        } else {
            mode = (i16)(OPD_OFFSET(RIGHT) & 0xFF80);
            if (OPD_KIND(RIGHT) == 4 && (DESC_FLAGS(desc) & 0x8000) != 0 && (mode == 0 || mode == -128))
                mode = 2;
            else
                mode = 0;
            mode = mode + (DESC_OPCODE(desc) & 1);
            if (opcode >= 0x85) {
                EMIT_CODE_BYTE((u8)((u8)mode + 0xF6));
                EMIT_MODRM(LEFT, 0);
            } else {
                EMIT_CODE_BYTE((u8)((u8)mode + 0x80));
                EMIT_MODRM(LEFT, DESC_OPCODE(desc) & 0xFFFE);
            }
        }
        EMIT_IMMEDIATE_OPERAND(mode);
        return 1;
    }
    return 0;
}

/* RIGHT as an immediate: a byte, or a word when mode is 1; a symbol's offset (fixup kind 1);
   a memory operand's address; or a symbol's segment (fixup kind 3) */
void EMIT_IMMEDIATE_OPERAND(i16 mode)
{
    switch (OPD_KIND(RIGHT)) {
    case 4:
        EMIT_CODE_BYTE((u8)OPD_OFFSET(RIGHT));
        if (mode == 1)
            EMIT_CODE_BYTE((u8)((i16)OPD_OFFSET(RIGHT) >> 8));
        break;
    case 2:
        ADD_OFFSET_FIXUP(OPD_SYMBOL(RIGHT));
        EMIT_CODE_WORD(OPD_OFFSET(RIGHT));
        break;
    case 5:
        if (OPD_SYMBOL(RIGHT))
            ADD_OFFSET_FIXUP(OPD_SYMBOL(RIGHT));
        EMIT_CODE_WORD(OPD_OFFSET(RIGHT));
        break;
    default:
        ADD_FIXUP_KIND_3(OPD_SYMBOL(RIGHT));
        EMIT_CODE_WORD(0);
        break;
    }
}

/* the ModRM byte for operand (a DS offset), with format already holding the reg field (or
   the /digit), and any displacement.  A register gives mod 11.  A direct address gives r/m
   110 with a 16-bit displacement (and a fixup if it names a symbol).  Otherwise mod is 10
   (16-bit displacement: a symbol or a large value), 01 (8-bit, also for a plain [bp]) or 00,
   and r/m is built from the base (reg: BX 4, BP 10) and index (scale: SI, DI 9) registers:
   [bx+si] 0, [bx+di] 1, [bp+si] 2, [bp+di] 3, [si] 4, [di] 5, [bp] 6, [bx] 7 */
void EMIT_MODRM(u16 operand, u16 format)
{
    if (OPD_KIND(operand) == 1) {
        EMIT_CODE_BYTE((u8)(REGISTER_ENCODING(OPD_REG(operand)) + format + 0xC0));
        return;
    }
    u16 mode;
    if (OPD_REG(operand) == -1 && OPD_SCALE(operand) == -1) {
        format += 6;
        mode = 0x80;
    } else {
        if (OPD_SYMBOL(operand) || (i16)OPD_OFFSET(operand) > 127 || (i16)OPD_OFFSET(operand) < -128)
            mode = 0x80;
        else if (OPD_OFFSET(operand))
            mode = 0x40;
        else if (OPD_REG(operand) == 10 && OPD_SCALE(operand) == -1)
            mode = 0x40;
        else
            mode = 0;
        format |= mode;
        if (OPD_SCALE(operand) == 9)
            format |= 1;
        if (OPD_REG(operand) == 10)
            format |= 2;
        if (OPD_SCALE(operand) == -1 || OPD_REG(operand) == -1) {
            format |= 4;
            if (OPD_REG(operand) == 4)
                format |= 3;
        }
    }
    EMIT_CODE_BYTE((u8)format);
    if (mode == 0x80) {
        if (OPD_SYMBOL(operand))
            ADD_OFFSET_FIXUP(OPD_SYMBOL(operand));
        EMIT_CODE_WORD(OPD_OFFSET(operand));
    } else if (mode == 0x40)
        EMIT_CODE_BYTE((u8)OPD_OFFSET(operand));
}
