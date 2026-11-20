/* target: ovr162_STAG001 */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: picks one of two register-to-register opcodes for a code op from
   the opcode descriptor table. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: one small helper of the instruction emitter (overlay ovr162, with EMITBLK.C,
   EMITBIN.C, EMITFPU.C, EMITHELP.C and EMITHIST.C). OPCODE_DESCRIPTOR_TABLE is the same
   19-byte-per-op table as CODE_OP_INFO_TABLE, seen from 3 bytes earlier (symbols.tsv puts
   it at DS:3F98, CODE_OP_INFO_TABLE at DS:3F9B), so 'flags' here is the op's flag long
   and tail[0] is the op's operand-size byte (1 byte, 2 word; EMITBLK.C reads the same byte
   as HINT). Instruction numbers and code-op numbers share one numbering: 0x9B and 0x9C are
   probably the byte and word forms of MOV (EMITBLK.C forms them as HINT+0x9A). */
struct Descriptor { unsigned char prefix[3]; long flags; unsigned char tail[12]; };
extern struct Descriptor OPCODE_DESCRIPTOR_TABLE[];
/* REG_MOVE_OPCODE: returns the register-to-register move instruction for code op 'kind':
   0x9B (probably MOV byte) when the op's operand size is 1, otherwise 0x9C (probably MOV
   word). Used by EMIT_BLOCK_INSTRUCTIONS for register ops 7 and 8 whose value sits in a
   different register from the one the allocator gave the op. */
static int near pascal REG_MOVE_OPCODE(int kind)
{
    return OPCODE_DESCRIPTOR_TABLE[kind].tail[0]!=1 ? 0x9C : 0x9B;
}
