/* target: ovr162_STAOV0F4 */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: emits the x86 instructions for one block's code nodes, dispatching
   on code op and replaying register history. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: the heart of the instruction emitter overlay (ovr162). EMIT_FUNCTION_BODY
   calls EMIT_BLOCK_INSTRUCTIONS for each code or switch block once registers are
   allocated; it walks the block's run of code ops and turns each into x86 instructions
   through the EMIT_INSN_* builders (EMITINSN.C), which fill FIRST_ASM_OPERAND and
   SECOND_ASM_OPERAND and pass an instruction number to EMIT_INSTRUCTION_HOOK (object
   bytes or assembly text). Code-op numbers and instruction numbers share one numbering,
   so a plain op is often emitted with its own opcode as the instruction number.
   Before each op the register history for it is replayed (EMIT_REGISTER_HISTORY, through
   its _ENTRY stub), so moves, pushes and spills the allocator recorded come out in place.
   Per op, _SI holds the op's record offset (number*4) and _DI points at its
   CODE_OP_INFO_TABLE entry minus 3; the macros read that entry: FLAGS is the op's flag
   long, HINT its operand-size byte (1 byte, 2 word, so HINT+0x9A is MOV byte 0x9B or MOV
   word 0x9C), and VALUE the long operand of a constant op (with ES on the operand pool).
   COP_FLAGS bits used: 1 the op is folded into its parent's operand (no code of its own),
   2 the op works in place on its left operand (a store, or e.g. 'OR memory,x'; NEW_CODE_NODE
   then marks that operand folded), 8 its result is used, 0x40 dead, 0x80 already done.
   Register numbers, probably (from EMITINSN.C and the cases here): 0 AX (1 AH), 2 DX,
   4 BX, 6 CX, 8 SI, 9 DI, 10 BP, 11 SP, 12 ES, 13 DS, 14 CS, 15 SS. Instruction numbers,
   probably: 0x94 PUSH, 0x7F POP, 0x95 LEA, 0x96 LES, 0x9B/0x9C MOV, 0x1F ADD word,
   0x57 FWAIT. All the _ES reloads, '_SI=_SI' and '_AX=_AX' lines are shapes kept for byte
   matching; the ES_ accessors read whatever pool the last _ES load chose. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"
struct Operand { unsigned int kind; signed char index,scale,reg; unsigned int offset,symbol; };
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned char OPTION_TARGET_CPU,OPTION_OPTIMIZE_SPEED,INSN_57_PENDING,INSN_9C_DEFERRED;
extern signed char SWAP_OPCODE_FLAG;
extern unsigned int FIRST_ASM_OPERAND;
extern struct Operand SECOND_ASM_OPERAND,INSN_9C_DEFERRED_OPERAND;
extern void (far pascal *BYTE_HOOK)(unsigned char);
extern void (far pascal *LINE_NUMBER_HOOK)(unsigned int,unsigned int);
extern void (far pascal *EMIT_INSTRUCTION_HOOK)(unsigned int);
extern void (far pascal *EMIT_OP_AF_HOOK)(unsigned int);
extern void (far pascal *EMIT_OP_B0_HOOK)(unsigned int);
extern void (far pascal *EMIT_OP_76_HOOK)(void);
extern void near pascal EMIT_HELPER_CALL_FOR_NODE_ENTRY(unsigned int,unsigned int);
extern void near pascal EMIT_REG_ASSIGNED_BINARY_ENTRY(unsigned int,unsigned int);
extern void near pascal EMIT_EVAL_STACK_INSN_ENTRY(unsigned int);
extern unsigned int near pascal REG_MOVE_OPCODE(unsigned int);
extern void near pascal EMIT_REGISTER_HISTORY_ENTRY(unsigned int);
extern signed char far pascal GET_ASSIGNED_REGISTER(unsigned int);
extern unsigned int far pascal REMAP_JUMP_KIND(unsigned int);
extern void far pascal EMIT_FPU_OP_ON_OPERAND(unsigned int,unsigned int);
extern unsigned int far pascal SWAP_OPERAND_OPCODE(unsigned int);
extern int far pascal FPU_STACK_OPERAND_OR_ZERO(unsigned int);
extern void far pascal EMIT_INSN_NO_OPERANDS(unsigned int);
extern void far pascal EMIT_INSN_NODE(unsigned int,unsigned int);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_NODE_IMM(unsigned int,unsigned int,unsigned int);
extern void far pascal EMIT_INSN_NODE_NODE(unsigned int,unsigned int,unsigned int);
extern void far pascal EMIT_INSN_REG_IMM(unsigned int,unsigned char,unsigned int);
extern void far pascal EMIT_INSN_REG_NODE(unsigned int,unsigned char,unsigned int);
extern void far pascal EMIT_INSN_REG_REG(unsigned int,unsigned char,unsigned char);
#define FLAGS (*((unsigned long near *)(_DI+3)))
#define HINT (*((unsigned char near *)(_DI+7)))
#define VALUE (*((unsigned long far *)MK_FP(_ES,_SI)))

/* EMIT_BLOCK_INSTRUCTIONS: emits all code ops of flow block 'node' (FLOW_BLOCK_POOL_SEG
   offset), setting CURRENT_INSN_INDEX to each op number in turn. Ops folded into an
   operand or dead are skipped except line marks (op 1), which go to LINE_NUMBER_HOOK
   (file, line). Called from EMIT_FUNCTION_BODY through EMIT_BLOCK_INSTRUCTIONS_ENTRY. */
static void near pascal EMIT_BLOCK_INSTRUCTIONS(unsigned int node)
{
    unsigned int count,number,symbol;
    signed char saved,saved2;
    unsigned int next,child,operand,amount;
    /* Self-copies keep registers live at joins without emitting instructions. */
    _BX=node;
    _ES=FLOW_BLOCK_POOL_SEG;
    count=ES_W(_BX,CNODE_OP_COUNT);
    number=ES_W(_BX,CNODE_FIRST_OP);
    _SI=number*4;
    for (;count;--count,++number,_SI+=4) {
        CURRENT_INSN_INDEX=number;
        EMIT_REGISTER_HISTORY_ENTRY(number);
        _ES=CODE_OP_POOL_SEG;
        if (ES_B(_SI,COP_FLAGS)&0x41) {
            if (ES_B(_SI,COP_OPCODE)==1)
                LINE_NUMBER_HOOK(OPND_W(_SI,OPND_LEFT),ES_W(_SI,OPND_SOURCE_LINE));
            continue;
        }
        _ES=CODE_OP_POOL_SEG;
        _DI=(unsigned int)(CODE_OP_INFO_TABLE-3+ES_B(_SI,COP_OPCODE)*19);
        /* Table flag 0x2000: the op never produces code. Flag 0x1000: done by a run-time helper. */
        if (FLAGS&0x2000L) continue;
        if (FLAGS&0x1000L) {
            EMIT_HELPER_CALL_FOR_NODE_ENTRY(_SI,_DI);
            continue;
        }
        _ES=CODE_OP_POOL_SEG;
        switch (ES_B(_SI,COP_OPCODE)) {
        /* Register ops: the value is in the fixed register OPND_LEFT; move it when the allocator
           gave the op another register. */
        case 7: case 8:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) break;
            _ES=CODE_OP_POOL_SEG;
            _AX=ES_SC(_SI,COP_REGISTER);
            _ES=CODE_OPERAND_POOL_SEG;
            if (_AX==ES_W(_SI,OPND_LEFT)) break;
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_REG_REG(REG_MOVE_OPCODE(ES_B(_SI,COP_OPCODE)),COP_B(_SI,COP_REGISTER),OPND_B(_SI,OPND_LEFT));
            break;
        case 0xAF:
            EMIT_OP_AF_HOOK(OPND_W(_SI,OPND_LEFT));
            break;
        /* Stack adjust after a call (VALUE bytes): ADD SP,n, or when optimising for size and n
           is 2 or 4, one or two POP CX instead (shorter). */
        case 0xAD:
            _ES=CODE_OPERAND_POOL_SEG;
            if (!VALUE) break;
            if (OPTION_OPTIMIZE_SPEED || VALUE>4UL) {
                EMIT_INSN_REG_IMM(0x1F,11,OPND_W(_SI,OPND_LEFT));
                break;
            }
            _ES=CODE_OPERAND_POOL_SEG;
            if (VALUE>2UL) EMIT_INSN_REG(0x7F,6);
            EMIT_INSN_REG(0x7F,6);
            break;
        /* 0x73 is probably PUSHF (INTRINS.C pushes the flags with it before an interrupt
           call through a vector); when its value is used it is popped into the result
           register. 0x74 (probably POPF) re-reads the flags the same way. */
        case 0x73:
            EMIT_INSN_NO_OPERANDS(0x73);
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_FLAGS)&8) EMIT_INSN_REG(0x7F,ES_B(_SI,COP_REGISTER));
            break;
        case 0x74:
            EMIT_INSN_NO_OPERANDS(0x74);
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_FLAGS)&8) {
                EMIT_INSN_NO_OPERANDS(0x73);
                EMIT_INSN_REG(0x7F,COP_B(_SI,COP_REGISTER));
            }
            break;
        /* Probably INT n (INTRINS.C builds op 0x72 from a constant interrupt number): the op
           becomes a constant (op 10) and is emitted as its own immediate operand. */
        case 0x72:
            _ES=CODE_OP_POOL_SEG;
            ES_B(_SI,COP_OPCODE)=10;
            EMIT_INSN_NODE(0x72,number);
            break;
        case 0x97: case 0x98: case 0x99:
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_FLAGS)&8) EMIT_INSN_REG_NODE(HINT+0x9A,ES_B(_SI,COP_REGISTER),OPND_W(_SI,OPND_LEFT));
            break;
        case 0x95:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) break;
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_REG_NODE(ES_B(_SI,COP_OPCODE),ES_B(_SI,COP_REGISTER),OPND_W(_SI,OPND_LEFT));
            break;
        case 14:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) break;
            _ES=CODE_OP_POOL_SEG;
            saved2=ES_B(_SI,COP_REGISTER);
            ES_B(_SI,COP_REGISTER)=0xFF;
            EMIT_INSN_REG_NODE(0x95,saved2,number);
            _ES=CODE_OP_POOL_SEG;
            ES_B(_SI,COP_REGISTER)=saved2;
            break;
        /* Raw bytes, probably from __emit__: 0x7A one byte, 0x79 two bytes (low, high). */
        case 0x7A:
            BYTE_HOOK(OPND_B(_SI,OPND_LEFT));
            break;
        case 0x79:
            BYTE_HOOK(OPND_B(_SI,OPND_LEFT));
            _ES=CODE_OPERAND_POOL_SEG;
            BYTE_HOOK(VALUE>>8);
            break;
        case 0x7B: case 0x7C:
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),number);
            break;
        /* Load: MOV word into the result register. COP_REGISTER is cleared around the call so
           EMIT_INSN_REG_NODE sees the op as a memory operand, not as the register itself. */
        case 17:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) break;
            _ES=CODE_OP_POOL_SEG;
            saved=ES_B(_SI,COP_REGISTER);
            ES_B(_SI,COP_REGISTER)=0xFF;
            EMIT_INSN_REG_NODE(0x9C,saved,number);
            _ES=CODE_OP_POOL_SEG;
            ES_B(_SI,COP_REGISTER)=saved;
            break;
        /* Load of a far pointer's segment word into ES (12) followed by an op that loads its
           offset: merge the two into one LES. The next op is marked done (0x40), its history is
           replayed now, and this op becomes op 22 so its operand no longer adds 2 (see
           OPERAND_FROM_NODE). The 'else' branch cannot run inside case 27. */
        case 27:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) break;
            next=_SI+4;
            _ES=CODE_OP_POOL_SEG;
            saved=ES_B(_SI,COP_REGISTER);
            ES_B(_SI,COP_REGISTER)=0xFF;
            _BX=next;
            if ((ES_B(_BX,COP_FLAGS)&0x49)==8 && saved==12) {
                ES_B(_BX,COP_FLAGS)|=0x40;
                EMIT_REGISTER_HISTORY_ENTRY(number+1);
                _ES=CODE_OP_POOL_SEG;
                if (ES_B(_SI,COP_OPCODE)==27) ES_B(_SI,COP_OPCODE)=22;
                else {
                    _ES=CODE_OPERAND_POOL_SEG;
                    ES_W(_SI,OPND_RIGHT)-=2;
                }
                EMIT_INSN_REG_NODE(0x96,COP_B(next,COP_REGISTER),number);
            } else EMIT_INSN_REG_NODE(0x9C,saved,number);
            _ES=CODE_OP_POOL_SEG;
            ES_B(_SI,COP_REGISTER)=saved;
            break;
        case 21: case 22:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) break;
            _ES=CODE_OP_POOL_SEG;
            saved=ES_B(_SI,COP_REGISTER);
            ES_B(_SI,COP_REGISTER)=0xFF;
            EMIT_INSN_REG_NODE(HINT+0x9A,saved,number);
            _ES=CODE_OP_POOL_SEG;
            ES_B(_SI,COP_REGISTER)=saved;
            break;
        /* 0xAF and 0xB0 are switch-table ops (SWITCH.C LOWER_SWITCH_TABLE_SCAN); their code comes
           from output hooks. */
        case 0xB0:
            EMIT_OP_B0_HOOK(OPND_W(_SI,OPND_LEFT));
            break;
        case 0x8C:
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_FLAGS)&8) EMIT_INSN_REG(ES_B(_SI,COP_OPCODE),OPND_B(_SI,OPND_LEFT));
            break;
        case 0x8D: case 0x8E:
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_REG(ES_B(_SI,COP_OPCODE),OPND_B(_SI,OPND_LEFT));
            break;
        case 0x8F:
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT));
            break;
        case 0xB3:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) { EMIT_INSN_NO_OPERANDS(0x90); _AX=_AX; }
            break;
        case 0x90: case 0x91:
            _SI=_SI;
            goto emit_opcode;
        /* Op 3 (probably a sequence whose value is its left operand): when unused and the right
           operand is on the 8087 stack, emit 0x90 (probably discards that value); when used,
           move the left operand's register into the result register. */
        case 3:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) {
                _ES=CODE_OPERAND_POOL_SEG;
                _BX=ES_W(_SI,OPND_RIGHT);
                _BX<<=2;
                if (FPU_STACK_OPERAND_OR_ZERO(ES_W(_BX,OPND_LEFT))) { EMIT_INSN_NO_OPERANDS(0x90); break; }
            }
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) break;
            saved=GET_ASSIGNED_REGISTER(OPND_W(_SI,OPND_LEFT));
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_REGISTER)==saved) break;
            EMIT_INSN_REG_REG(0x9C,ES_B(_SI,COP_REGISTER),saved);
            break;
        case 24: case 25: case 26:
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_FLAGS)&8) EMIT_INSN_NODE(HINT+0x61,number);
            break;
        /* 8087 compares (GEN_FPU_COMPARE, SAVEREGS.C). With a memory right operand the compare
           takes it directly; otherwise the operand-less form is used and, unless the operands
           were swapped by a reload (SWAP_OPCODE_FLAG), the block's conditional jump kind goes
           through REMAP_JUMP_KIND. */
        case 0x82: case 0x83: case 0x84:
            _ES=CODE_OPERAND_POOL_SEG;
            if (ES_W(_SI,OPND_RIGHT)) {
                _BX=ES_W(_SI,OPND_RIGHT);
                _BX<<=2;
                _ES=CODE_OP_POOL_SEG;
                if (ES_B(_BX,COP_FLAGS)&1) {
                    EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_RIGHT));
                    goto clear_pending;
                }
            }
            if (!SWAP_OPCODE_FLAG) {
                _BX=node;
                _ES=FLOW_BLOCK_POOL_SEG;
                if (ES_W(_BX,CNODE_JUMP_KIND)&0xF8FF) {
                    _AX=REMAP_JUMP_KIND(ES_W(_BX,CNODE_JUMP_KIND));
                    _BX=node;
                    _ES=FLOW_BLOCK_POOL_SEG;
                    ES_W(_BX,CNODE_JUMP_KIND)=_AX;
                }
            }
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_NO_OPERANDS(ES_B(_SI,COP_OPCODE));
clear_pending:
            SWAP_OPCODE_FLAG=0;
            break;
        /* Zero-extend a byte: MOV the high half (register+1, e.g. AH) to 0. */
        case 0xAA:
            _ES=CODE_OP_POOL_SEG;
            saved=ES_B(_SI,COP_REGISTER);
            ++saved;
            EMIT_INSN_REG_IMM(0x9B,saved,0);
            break;
        case 0xAB: case 0xAC:
            _SI=_SI;
            goto emit_opcode;
        /* Address of a variable: for an auto or parameter (VAR_SYMBOL_KIND 5 or 6) emit LEA of
           its frame slot (the op is turned into leaf op 16 for the operand); globals go to the
           default path. */
        case 13:
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&8)==0) break;
            _ES=CODE_OPERAND_POOL_SEG;
            symbol=ES_W(_SI,OPND_VARIABLE);
            _BX=symbol;
            _ES=VARIABLE_TABLE_SEG;
            if (ES_B(_BX,VAR_SYMBOL_KIND)!=5 && ES_B(_BX,VAR_SYMBOL_KIND)!=6) goto default_case;
            _ES=CODE_OP_POOL_SEG;
            saved2=ES_B(_SI,COP_REGISTER);
            ES_B(_SI,COP_REGISTER)=0xFF;
            ES_B(_SI,COP_OPCODE)=16;
            EMIT_INSN_REG_NODE(0x95,saved2,number);
            _ES=CODE_OP_POOL_SEG;
            ES_B(_SI,COP_REGISTER)=saved2;
            break;
        /* Probably a far call through a pointer when the target is not a simple memory operand:
           PUSH CS, the hook's part, push the two pointer words, then 0xA1 (probably RETF, which
           jumps to the pushed address). Otherwise falls into 0x75 with a memory operand. */
        case 0x76:
            _ES=CODE_OPERAND_POOL_SEG;
            operand=ES_W(_SI,OPND_LEFT)*4;
            _BX=operand;
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_BX,COP_FLAGS)&1)==0) {
                EMIT_INSN_REG(0x94,14);
                EMIT_OP_76_HOOK();
                EMIT_INSN_NODE(0x94,OPND_W(_SI,OPND_RIGHT));
                EMIT_INSN_NODE(0x94,OPND_W(_SI,OPND_LEFT));
                EMIT_INSN_NO_OPERANDS(0xA1);
                break;
            }
        case 0x75:
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT));
            break;
        /* Direct near or far call of the symbol in OPND_LEFT. */
        case 0x77: case 0x78:
            _ES=CODE_OP_POOL_SEG;
            saved2=ES_B(_SI,COP_REGISTER);
            ES_B(_SI,COP_REGISTER)=0xFF;
            _ES=CODE_OPERAND_POOL_SEG;
            ES_W(_SI,OPND_RIGHT)=0;
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),number);
            _ES=CODE_OP_POOL_SEG;
            ES_B(_SI,COP_REGISTER)=saved2;
            break;
        /* Shifts and rotates by a constant: the 8086 (OPTION_TARGET_CPU 0) has no shift by an
           immediate count above 1, so emit 'count' shifts by 1, then move the result if the op
           and its left operand ended up in different registers. */
        case 0x44: case 0x45: case 0x46: case 0x47: case 0x48: case 0x49: case 0x55: case 0x56: case 0xD3: case 0xD4:
            _ES=CODE_OPERAND_POOL_SEG;
            child=ES_W(_SI,OPND_RIGHT)*4;
            _ES=CODE_OP_POOL_SEG;
            _BX=child;
            if (ES_B(_BX,COP_OPCODE)!=9) goto default_case;
            if ((ES_B(_BX,COP_FLAGS)&1)==0) goto default_case;
            if (OPTION_TARGET_CPU) goto default_case;
            _ES=CODE_OPERAND_POOL_SEG;
            amount=ES_W(_BX,OPND_LEFT);
            while (amount>0) {
                _ES=CODE_OP_POOL_SEG;
                EMIT_INSN_NODE_IMM(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT),1);
                --amount;
            }
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&10)!=10) break;
            amount=GET_ASSIGNED_REGISTER(OPND_W(_SI,OPND_LEFT));
            _ES=CODE_OP_POOL_SEG;
            if (ES_SC(_SI,COP_REGISTER)==amount) break;
            EMIT_INSN_REG_NODE(HINT+0x9A,ES_B(_SI,COP_REGISTER),OPND_W(_SI,OPND_LEFT));
            break;
        case 2: case 5: case 6: case 0xAE: case 0xB4:
            break;
        /* Generic path, by the op's table flags: 2 an 8087 op, 9 a load of a leaf, otherwise an
           integer op emitted in one of the shapes reg,operand / reg / operand,operand / operand /
           no operands, depending on which operands it has and whether its result is used. */
        default:
default_case:
            if (FLAGS&2L) {
                if (FLAGS&1L) {
                    _ES=CODE_OP_POOL_SEG;
                    if (ES_B(_SI,COP_FLAGS)&8) EMIT_INSN_NODE(HINT+0x61,number);
                } else {
                    _ES=CODE_OP_POOL_SEG;
                    if (ES_B(_SI,COP_FLAGS)&2) {
                        if (ES_B(_SI,COP_FLAGS)&8) EMIT_EVAL_STACK_INSN_ENTRY(_SI);
                        else {
                            _ES=CODE_OP_POOL_SEG;
                            if (ES_B(_SI,COP_FLAGS)&0x80) goto zero_opcode;
                            if (FLAGS&4L) {
                                _ES=CODE_OP_POOL_SEG;
                                EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT));
                            } else {
                                _ES=CODE_OP_POOL_SEG;
                                EMIT_FPU_OP_ON_OPERAND(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT));
                            }
                        }
                    } else {
                        _ES=CODE_OPERAND_POOL_SEG;
                        if (ES_W(_SI,OPND_RIGHT)) {
                            _BX=ES_W(_SI,OPND_RIGHT);
                            _BX<<=2;
                            _ES=CODE_OP_POOL_SEG;
                            if (ES_B(_BX,COP_FLAGS)&1) {
                                EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_RIGHT));
                                goto check_zero;
                            }
                        }
                        if (SWAP_OPCODE_FLAG) EMIT_INSN_NO_OPERANDS(SWAP_OPERAND_OPCODE(COP_B(_SI,COP_OPCODE)));
                        else EMIT_INSN_NO_OPERANDS(COP_B(_SI,COP_OPCODE));
check_zero:
                        _ES=CODE_OP_POOL_SEG;
                        if ((ES_B(_SI,COP_FLAGS)&8)==0) {
zero_opcode:
                            EMIT_INSN_NO_OPERANDS(0x90);
                        }
                    }
                }
                SWAP_OPCODE_FLAG=0;
                break;
            }
            if (FLAGS&9L) {
                _ES=CODE_OP_POOL_SEG;
                if ((ES_B(_SI,COP_FLAGS)&8)==0) {
                    if (count>1) break;
                    _BX=node;
                    _ES=FLOW_BLOCK_POOL_SEG;
                    if ((ES_W(_BX,CNODE_JUMP_KIND)&0xF8FF)==1) break;
                    if ((ES_W(_BX,CNODE_JUMP_KIND)&0xF8FF)==0) break;
                    EMIT_INSN_NODE_IMM(HINT+0x7F,number,0);
                    break;
                }
                _ES=CODE_OP_POOL_SEG;
                saved=ES_B(_SI,COP_REGISTER);
                ES_B(_SI,COP_REGISTER)=0xFF;
                EMIT_INSN_REG_NODE(HINT+0x9A,saved,number);
                _ES=CODE_OP_POOL_SEG;
                ES_B(_SI,COP_REGISTER)=saved;
                break;
            }
            saved=GET_ASSIGNED_REGISTER(OPND_W(_SI,OPND_LEFT));
            _ES=CODE_OP_POOL_SEG;
            if ((ES_B(_SI,COP_FLAGS)&2)==0) {
                if (ES_B(_SI,COP_FLAGS)&8) {
                    _ES=CODE_OPERAND_POOL_SEG;
                    if (ES_W(_SI,OPND_RIGHT)) {
                        _ES=CODE_OP_POOL_SEG;
                        EMIT_INSN_REG_NODE(ES_B(_SI,COP_OPCODE),ES_B(_SI,COP_REGISTER),OPND_W(_SI,OPND_RIGHT));
                        break;
                    }
                    _ES=CODE_OPERAND_POOL_SEG;
                    if (ES_W(_SI,OPND_LEFT)) {
                        _ES=CODE_OP_POOL_SEG;
                        EMIT_INSN_REG(ES_B(_SI,COP_OPCODE),ES_B(_SI,COP_REGISTER));
                        break;
                    }
                    _ES=CODE_OP_POOL_SEG;
                    EMIT_INSN_NO_OPERANDS(ES_B(_SI,COP_OPCODE));
                    _AX=_AX;
                    break;
                }
                _ES=CODE_OPERAND_POOL_SEG;
                if (ES_W(_SI,OPND_RIGHT)) {
                    _ES=CODE_OP_POOL_SEG;
                    EMIT_INSN_NODE_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT),ES_W(_SI,OPND_RIGHT));
                    break;
                }
                _ES=CODE_OPERAND_POOL_SEG;
                if (ES_W(_SI,OPND_LEFT)) {
                    _ES=CODE_OP_POOL_SEG;
                    EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT));
                    break;
                }
                _ES=CODE_OP_POOL_SEG;
                EMIT_INSN_NO_OPERANDS(ES_B(_SI,COP_OPCODE));
                _AX=_AX;
                break;
            }
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_FLAGS)&8) {
                _ES=CODE_OPERAND_POOL_SEG;
                if (ES_W(_SI,OPND_RIGHT)) {
                    EMIT_REG_ASSIGNED_BINARY_ENTRY(_SI,_DI);
                    break;
                }
                _ES=CODE_OPERAND_POOL_SEG;
                if (ES_W(_SI,OPND_LEFT)) {
                    _ES=CODE_OP_POOL_SEG;
                    EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT));
                    break;
                }
                _ES=CODE_OP_POOL_SEG;
                EMIT_INSN_NO_OPERANDS(ES_B(_SI,COP_OPCODE));
                _AX=_AX;
                break;
            }
            _ES=CODE_OP_POOL_SEG;
            if (ES_B(_SI,COP_FLAGS)&0x80) break;
            _ES=CODE_OPERAND_POOL_SEG;
            if (ES_W(_SI,OPND_RIGHT)) {
                _ES=CODE_OP_POOL_SEG;
                EMIT_INSN_NODE_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT),ES_W(_SI,OPND_RIGHT));
                break;
            }
            _ES=CODE_OPERAND_POOL_SEG;
            if (ES_W(_SI,OPND_LEFT)) {
                _ES=CODE_OP_POOL_SEG;
                EMIT_INSN_NODE(ES_B(_SI,COP_OPCODE),OPND_W(_SI,OPND_LEFT));
                break;
            }
emit_opcode:
            _ES=CODE_OP_POOL_SEG;
            EMIT_INSN_NO_OPERANDS(ES_B(_SI,COP_OPCODE));
            break;
        }
    }
    /* Block end: flush a pending FWAIT and a deferred 'MOV ES,memory' (see
       EMIT_INSN_OPTIMIZED), then replay the history entries tagged with the negated last op
       number, which belong after the block's ops. */
    if (INSN_57_PENDING) {
        FIRST_ASM_OPERAND=0;
        SECOND_ASM_OPERAND.kind=0;
        EMIT_INSTRUCTION_HOOK(0x57);
        INSN_57_PENDING=0;
    }
    if (INSN_9C_DEFERRED) {
        FIRST_ASM_OPERAND=1;
        FIRST_OPERAND_REG=12;
        SECOND_ASM_OPERAND=INSN_9C_DEFERRED_OPERAND;
        EMIT_INSTRUCTION_HOOK(0x9C);
        INSN_9C_DEFERRED=0;
    }
    EMIT_REGISTER_HISTORY_ENTRY(-number);
}
