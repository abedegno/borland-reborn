/* target: ovr162_STAOV0F7 */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: emits an instruction whose operand is on the 8087 stack, with
   fast-float and stored-symbol variants (probably floating point). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: part of the instruction emitter overlay (ovr162). EMIT_BLOCK_INSTRUCTIONS calls
   this for an op whose table entry marks it as an 8087 operation (CODE_OP_INFO_TABLE flag 2)
   when the op has COP_FLAGS 2 and 8 set (it works in place on its left operand, and its
   result is used again). ARG(r) is the op's left operand word (OPND_LEFT), and
   SYMBOL_FLAGS(r) is the VAR_FLAGS byte of a variable-table entry (bit 2: the variable
   lives in a register). Op 0x6C is the floating store built by FPU_STORE_NODE_6C and
   GEN_FLOAT_POSTINC_DEC (SAVEREGS.C), probably a store-and-pop; 0x68 is probably the
   matching store without pop. For other ops the code relies on the instruction numbering:
   with OPTION_FAST_FLOAT one instruction 'op-2' is emitted, otherwise 'op' followed by
   'op-5'. Which mnemonics those are is not visible here. */
#include <dos.h>
#include "DATA.H"
#include "FIELDS.H"
#include "POOL.H"
extern unsigned int VARIABLE_TABLE_SEG;
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_NODE(unsigned int,unsigned int);
#define ARG(r) (*((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,(r))))
#define SYMBOL_FLAGS(r) (*((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG,(r)+14)))
/* EMIT_EVAL_STACK_INSN: emits the instruction(s) for floating op 'node' (CODE_OP_POOL_SEG
   offset) whose value must stay on the 8087 stack because it is used again. Does nothing
   for an op with COP_FLAGS 0x80. Called from EMIT_BLOCK_INSTRUCTIONS through
   EMIT_EVAL_STACK_INSN_ENTRY. */
static void near pascal EMIT_EVAL_STACK_INSN(register unsigned int node)
{
    register unsigned int child;
    unsigned int symbol;
    if((COP_B(node,COP_FLAGS)&0x80)!=0) return;
    if(COP_B(node,COP_OPCODE)==0x6C) {
        /* A store whose target is a variable leaf (table flag 1) held in a register: one
           instruction 0x68 does it. Otherwise first emit 0x8C with register 0 (probably a copy of
           the stack top, so the stored value stays on the stack) and then the store itself. */
        child=ARG(node)*4;
        if((*((unsigned long near *)(CODE_OP_INFO_TABLE+COP_B(child,COP_OPCODE)*19))&1L)!=0L) {
            symbol=ARG(child);
            if((SYMBOL_FLAGS(symbol)&2)!=0) {
                EMIT_INSN_NODE(0x68,ARG(node));
                return;
            }
        }
        EMIT_INSN_REG(0x8C,0);
        EMIT_INSN_NODE(COP_B(node,COP_OPCODE),ARG(node));
    } else if(OPTION_FAST_FLOAT!=0) {
        EMIT_INSN_NODE(COP_B(node,COP_OPCODE)-2,ARG(node));
    } else {
        EMIT_INSN_NODE(COP_B(node,COP_OPCODE),ARG(node));
        EMIT_INSN_NODE(COP_B(node,COP_OPCODE)-5,ARG(node));
    }
}
