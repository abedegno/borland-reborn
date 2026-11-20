/* target: ovr155_C205UNIT */
/* Role: code-node passes and register masks. Entry points: SIMPLIFY_ZERO_CONST_INSNS,
   RESERVE_ALL_REGISTERS, RESTORE_RESERVED_REGISTERS, FREE_REGISTER_MASK,
   BLOCK_FREE_REGISTERS, ALL_REGISTERS_MASK, BYTE_REGISTERS_MASK, REGISTER_HINT_CODE (+5
   more). Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO05F (ovr_1d79_a596) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: passes over the code ops that run before register allocation
   (GENERATE_FUNCTION_CODE, CGDRIVER.C), and the register masks the allocators use.
   Register masks have bit n for register n (0 AX, 1 AH, 2 DX, 3 DH, 4 BX, 5 BH, 6 CX,
   7 CH, 8 SI, 9 DI, 10 BP, 11 SP, 12 ES, 13 DS, 14 CS, 15 SS, probably; a word register's
   low byte shares its number). 0x1355 (AX, DX, BX, CX, SI, DI, ES) are the registers the
   allocator may hand out, 0x55 those with byte halves. CODEGEN_USED_REG_MASK collects the
   registers the function uses (SI/DI, bits 0x300, decide the prologue's pushes).
   SIMPLIFY_ZERO_CONST_INSNS removes AND/OR/XOR with a zero constant (with
   OPTIMIZE_ENABLED). MAP_SEGMENTS_MARK_OPERANDS replaces 'segment of symbol' ops by the
   segment register that already holds it, then decides for every op which operands the
   x86 instruction can take directly (a register variable, an immediate, one memory
   operand, a segment register) instead of a separate load: such operand ops are marked
   folded (COP_FLAGS 1) and emitted inside their parent's instruction (OPERAND_FROM_NODE,
   EMITINSN.C). Address arithmetic under an indirect access is folded into the x86
   addressing mode [BX|BP + SI|DI + displacement] by MARK_ADDRESS_REGISTERS.
   The 'mode' masks passed to MARK_OPERAND_FOR_MODE are, probably: 1 register operand, 2
   immediate, 4 memory, 8 segment register; it returns the forms still allowed for the
   other operand (an x86 instruction has at most one memory operand). Several functions
   here were compiled without -O (see the #pragma lines) and use _SI/_ES register code;
   those shapes are kept for byte matching. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- STAOV088 (listing ovr_1d79_a596:5960) ---- */
static void near pascal SIMPLIFY_BLOCK_ZERO_CONSTS(unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* SIMPLIFY_ZERO_CONST_INSNS: runs SIMPLIFY_BLOCK_ZERO_CONSTS on every code and switch
   block of the current function (word 6 is CNODE_NEXT). */
void far pascal SIMPLIFY_ZERO_CONST_INSNS(void)
{
    register unsigned int node;
    node = CODE_BLOCK_LIST_HEAD;
    while (node) {
        switch (((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[0]) {
        case 0:
        case 4:
            SIMPLIFY_BLOCK_ZERO_CONSTS(node);
        }
        node = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[6];
    }
}

/* ---- STAOV089 (listing ovr_1d79_a596:598F) ---- */
#pragma option -O-   /* STAOV089 was compiled without -O */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* SIMPLIFY_BLOCK_ZERO_CONSTS: walks the ops of block 'node' from the last to the first,
   skipping ops that work in place (COP_FLAGS 2). 'x AND 0' (ops 0x4A/0x4B) becomes the
   constant 0 itself, and 'x OR 0' / 'x XOR 0' (0x4D/0x4F) a plain copy of x (op 0x99 for
   words, 0x97 for bytes, by the size byte at description+7); the zero constant is marked
   dead and x no longer counts as used where it disappears. The block's first op
   (count 1) is left alone. Op 14 (the parameter area address) sets ASM_OUTPUT_FLAGS bit
   4, which makes EMIT_PROLOGUE build a BP frame. */
static void near pascal SIMPLIFY_BLOCK_ZERO_CONSTS(unsigned int node)
{
    unsigned int count;
    unsigned int index;
    unsigned char near *description;

    _BX = node;
    _ES = FLOW_BLOCK_POOL_SEG;
    count = ES_W(_BX, CNODE_OP_COUNT);
    _SI = (index = ES_W(_BX, CNODE_FIRST_OP) + count - 1) * 4;
    while (count) {
        _ES = CODE_OP_POOL_SEG;
        if (ES_B(_SI, COP_FLAGS) & 2)
            goto next;
        _ES = CODE_OP_POOL_SEG;
        description = CODE_OP_INFO_TABLE - 3 + ES_B(_SI, COP_OPCODE) * 19;
        switch ((int)ES_B(_SI, COP_OPCODE)) {
        case 14:
            ASM_OUTPUT_FLAGS |= 4;
            break;
        case 0x4A: case 0x4B:
            if (count <= 1)
                break;
            _ES = CODE_OPERAND_POOL_SEG;
            _CX = ES_W(_SI, OPND_RIGHT) * 4;
            _DI = ES_W(_SI, OPND_LEFT) * 4;
            _ES = CODE_OP_POOL_SEG;
            _BX = _CX;
            if (ES_B(_BX, COP_OPCODE) == 10 || ES_B(_BX, COP_OPCODE) == 9) {
                _ES = CODE_OPERAND_POOL_SEG;
                _BX = _CX;
                if (ES_UL(_BX, OPND_CONST_VALUE) == 0L) {
                    _ES = CODE_OP_POOL_SEG;
                    ES_B(_BX, COP_FLAGS) |= 0x40;
                    ES_B(_DI, COP_FLAGS) &= 0xF7;
                    ES_B(_SI, COP_OPCODE) = ES_B(_BX, COP_OPCODE);
                    _ES = CODE_OPERAND_POOL_SEG;
                    ES_UL(_SI, OPND_CONST_VALUE) = 0L;
                    break;
                }
            }
            _ES = CODE_OP_POOL_SEG;
            if (ES_B(_DI, COP_OPCODE) != 10 && ES_B(_DI, COP_OPCODE) != 9)
                break;
            _ES = CODE_OPERAND_POOL_SEG;
            if (ES_UL(_DI, OPND_CONST_VALUE) != 0L)
                break;
            _ES = CODE_OP_POOL_SEG;
            ES_B(_DI, COP_FLAGS) |= 0x40;
            _BX = _CX;
            ES_B(_BX, COP_FLAGS) &= 0xF7;
            ES_B(_SI, COP_OPCODE) = ES_B(_DI, COP_OPCODE);
            _ES = CODE_OPERAND_POOL_SEG;
            ES_UL(_SI, OPND_CONST_VALUE) = 0L;
            break;
        case 0x4D: case 0x4F:
            if (count <= 1)
                break;
            _ES = CODE_OPERAND_POOL_SEG;
            _CX = ES_W(_SI, OPND_RIGHT) * 4;
            _DI = ES_W(_SI, OPND_LEFT) * 4;
            _ES = CODE_OP_POOL_SEG;
            _BX = _CX;
            if (ES_B(_BX, COP_OPCODE) == 10 || ES_B(_BX, COP_OPCODE) == 9) {
                _ES = CODE_OPERAND_POOL_SEG;
                _BX = _CX;
                if (ES_UL(_BX, OPND_CONST_VALUE) == 0L) {
                    _ES = CODE_OP_POOL_SEG;
                    ES_B(_BX, COP_FLAGS) |= 0x40;
                    _ES = CODE_OPERAND_POOL_SEG;
                    ES_W(_SI, OPND_RIGHT) = 0;
                    _BX = (unsigned int)description;
                    if (*((unsigned char near *)(_BX + 7)) == 2) {
                        _ES = CODE_OP_POOL_SEG;
                        ES_B(_SI, COP_OPCODE) = 0x99;
                        goto next;
                    }
                    _ES = CODE_OP_POOL_SEG;
                    ES_B(_SI, COP_OPCODE) = 0x97;
                    break;
                }
            }
            _ES = CODE_OP_POOL_SEG;
            if (ES_B(_DI, COP_OPCODE) == 10 || ES_B(_DI, COP_OPCODE) == 9) {
                _ES = CODE_OPERAND_POOL_SEG;
                if (ES_UL(_DI, OPND_CONST_VALUE) == 0L) {
                    _ES = CODE_OP_POOL_SEG;
                    ES_B(_DI, COP_FLAGS) |= 0x40;
                    _ES = CODE_OPERAND_POOL_SEG;
                    ES_W(_SI, OPND_LEFT) = ES_W(_SI, OPND_RIGHT);
                    ES_W(_SI, OPND_RIGHT) = 0;
                    _BX = (unsigned int)description;
                    if (*((unsigned char near *)(_BX + 7)) == 2) {
                        _ES = CODE_OP_POOL_SEG;
                        ES_B(_SI, COP_OPCODE) = 0x99;
                    } else {
                        _ES = CODE_OP_POOL_SEG;
                        ES_B(_SI, COP_OPCODE) = 0x97;
                    }
                }
            }
        }
next:
        count--;
        _SI -= 4;
    }
}

#pragma option -O
/* ---- STAOV08A (listing ovr_1d79_a596:5B9E) ---- */

/* RESERVE_ALL_REGISTERS: marks every register but SI and DI as used and returns the old
   mask. GENERATE_FUNCTION_CODE calls it around the first ASSIGN_REGISTER_VARIABLES, so
   that round can only hand out SI and DI. */
unsigned int far pascal RESERVE_ALL_REGISTERS(void)
{
    unsigned int value;

    value = CODEGEN_USED_REG_MASK;
    CODEGEN_USED_REG_MASK |= 0xFCFF;
    return value;
}

/* ---- STAOV08B (listing ovr_1d79_a596:5BB3) ---- */

/* RESTORE_RESERVED_REGISTERS: puts back the mask saved by RESERVE_ALL_REGISTERS, keeping
   the SI/DI bits the register-variable round set. */
void far pascal RESTORE_RESERVED_REGISTERS(unsigned int value)
{
    CODEGEN_USED_REG_MASK &= 0x0300;
    CODEGEN_USED_REG_MASK |= value;
}

/* ---- STAOV08C (listing ovr_1d79_a596:5BC7) ---- */

/* FREE_REGISTER_MASK: allocatable registers (0x1355) not used yet. A used high byte marks
   its whole register used, and the registers never handed out (high bytes, BP, SP, DS,
   CS, SS: 0xECAA) are added to CODEGEN_USED_REG_MASK. */
unsigned int far pascal FREE_REGISTER_MASK(void)
{
    CODEGEN_USED_REG_MASK |= (CODEGEN_USED_REG_MASK & 0xAA) >> 1;
    CODEGEN_USED_REG_MASK |= 0xECAA;
    return 0x1355 & ~CODEGEN_USED_REG_MASK;
}

/* ---- STAOV08D (listing ovr_1d79_a596:5BEA) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;

/* BLOCK_FREE_REGISTERS: allocatable registers not taken by the register variables of scope
   block 'node' (word 10, offset 0x14, CNODE_SCOPE_OWN_REGS). */
unsigned int far pascal BLOCK_FREE_REGISTERS(unsigned int node)
{
    return 0x1355 & ~((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[10];
}

/* ---- STAOV08E (listing ovr_1d79_a596:5C07) ---- */
/* ALL_REGISTERS_MASK: the allocatable registers: AX, DX, BX, CX, SI, DI, ES. */
int far pascal ALL_REGISTERS_MASK(void)
{
    return 0x1355;
}

/* ---- STAOV08F (listing ovr_1d79_a596:5C0F) ---- */
/* BYTE_REGISTERS_MASK: the registers with byte halves: AX, DX, BX, CX. */
int far pascal BYTE_REGISTERS_MASK(void)
{
    return 0x55;
}

/* ---- STAOV090 (listing ovr_1d79_a596:5C17) ---- */
/* REGISTER_HINT_CODE: the register class meaning 'exactly register 'value'': value+1 for
   a 1-byte operand ('mode' 1), value+9 otherwise (used by REGALLOC.C for hints). */
int far pascal REGISTER_HINT_CODE(char value, unsigned int mode)
{
    if (mode == 1)
        return value + 1;
    return value + 9;
}

/* ---- STAOV091 (listing ovr_1d79_a596:5C33) ---- */
/* OP3_REGISTER_HINT: register class for an op of size 'mode' whose class was 'value'
   (used as an index into REG_CLASS_IS_WORD at DS:4FBC): 11 for operands bigger than a
   byte, else 9 when class 'value' is a word class, else 1. */
int far pascal OP3_REGISTER_HINT(int mode, unsigned char near *value)
{
    register unsigned char near *pointer = value;

    if (mode > 1)
        return 11;
    if (pointer[(unsigned)REG_CLASS_IS_WORD] != 0)
        return 9;
    return 1;
}

/* ---- STAOV092 (listing ovr_1d79_a596:5C59) ---- */

/* IS_MARKED_MEM_OPERAND: true when op 'value' is a folded indirect memory operand (ops
   0x15-0x1B, COP_FLAGS 1) and 'mode' has any of bits 0x310. */
unsigned int far pascal IS_MARKED_MEM_OPERAND(unsigned int mode, unsigned int value)
{
    register unsigned int index;
    index = value << 2;
    if (((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, index))[0] >= 0x15 &&
        ((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, index))[0] <= 0x1B &&
        (((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, index))[1] & 1) &&
        (mode & 0x310))
        return 1;
    return 0;
}

/* ---- STAOV093 (listing ovr_1d79_a596:5C90) ---- */
#pragma option -O-   /* STAOV093 was compiled without -O */
#define B(n) (*((unsigned char far *)MK_FP(_ES, _SI+(n))))

/* IS_OP_97_98_OR_LONG_PAIR: for op record 'node': true for the register copies 0x97/0x98,
   and for a live pair 'high word 0x1B, low word 0x16' of an indirect long read when one of
   them is folded or the first one's register class is not 0x15. Otherwise it falls off
   the end with AX set to 0 (false), a shape kept for byte matching. */
unsigned int far pascal IS_OP_97_98_OR_LONG_PAIR(unsigned int node)
{
    _SI = node;
    _ES = CODE_OP_POOL_SEG;
    if (B(0) == 0x98 || B(0) == 0x97)
        return 1;
    _ES = CODE_OP_POOL_SEG;
    if (B(0) != 0x1B)
        return 0;
    _ES = CODE_OP_POOL_SEG;
    if (B(4) != 0x16)
        return 0;
    _ES = CODE_OP_POOL_SEG;
    if (B(1) & 0x40)
        return 0;
    _ES = CODE_OP_POOL_SEG;
    if (B(5) & 0x40)
        return 0;
    _ES = CODE_OP_POOL_SEG;
    if (B(1) & 1)
        return 1;
    _ES = CODE_OP_POOL_SEG;
    if (B(5) & 1)
        return 1;
    _ES = CODE_OP_POOL_SEG;
    if (B(3) != 0x15)
        return 1;
    _AX = 0;
}
#undef B

#pragma option -O
/* ---- STAOV094 (listing ovr_1d79_a596:5D1E) ---- */
#pragma option -O-   /* STAOV094 was compiled without -O */

/* IS_LONG_MEM_PAIR: the same test for the 0x1B/0x16 pair alone. */
unsigned int far pascal IS_LONG_MEM_PAIR(unsigned int node)
{
    _SI = node;
    _ES = CODE_OP_POOL_SEG;
    if (*((unsigned char far *)MK_FP(_ES, _SI)) != 0x1B) {
        return 0;
    }
    _ES = CODE_OP_POOL_SEG;
    if (*((unsigned char far *)MK_FP(_ES, _SI + 4)) != 0x16) {
        return 0;
    }
    _ES = CODE_OP_POOL_SEG;
    if (*((unsigned char far *)MK_FP(_ES, _SI + 5)) & 0x40) {
        return 0;
    }
    _ES = CODE_OP_POOL_SEG;
    if (*((unsigned char far *)MK_FP(_ES, _SI + 5)) & 1)
        return 1;
    _ES = CODE_OP_POOL_SEG;
    if (*((unsigned char far *)MK_FP(_ES, _SI + COP_REG_CLASS)) != 0x15)
        return 1;
    _AX = 0;
}

#pragma option -O
/* ---- STAOV095 (listing ovr_1d79_a596:5D78) ---- */
static void near pascal MARK_BLOCK_OPERANDS(unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int CODE_SEGMENT_ID;
extern unsigned char OPTION_OVERLAY_CODE;

/* MAP_SEGMENTS_MARK_OPERANDS: first, every 'segment of symbol' op (12) whose symbol lives
   in the code segment becomes register op CS (14; not with overlays, where code can
   move), and one in DGROUP data or BSS becomes DS (13), unless the variable has flag 1.
   Then MARK_BLOCK_OPERANDS runs on every code and switch block. */
void far pascal MAP_SEGMENTS_MARK_OPERANDS(void)
{
    _SI = 4;
    _AX = CODE_OP_NEXT_INDEX;
    _AX--;
    _DX = _AX;
    while (_DX) {
        _ES = CODE_OP_POOL_SEG;
        if (ES_B(_SI, COP_OPCODE) == 12) {
            _ES = CODE_OPERAND_POOL_SEG;
            _BX = ES_W(_SI, OPND_VARIABLE);
            _ES = VARIABLE_TABLE_SEG;
            if (ES_W(_BX, VAR_SYMBOL) != 0) {
                _ES = CODE_OPERAND_POOL_SEG;
                _DI = ES_W(_SI, OPND_VARIABLE);
                _ES = VARIABLE_TABLE_SEG;
                if (ES_W(_DI, VAR_SEGMENT) == CODE_SEGMENT_ID) {
                    if (OPTION_OVERLAY_CODE)
                        goto next;
                    _ES = CODE_OPERAND_POOL_SEG;
                    ES_W(_SI, OPND_LEFT) = 14;
                } else {
                    _ES = VARIABLE_TABLE_SEG;
                    _AX = ES_B(_DI, VAR_FLAGS);
                    if (_AX & 1)
                        goto next;
                    if (ES_W(_DI, VAR_SEGMENT) != DATA_SEGMENT_ID &&
                        (ES_W(_DI, VAR_SEGMENT) != BSS_SEGMENT_ID || DATA_BSS_GROUPS_DIFFER != 0))
                        goto next;
                    _ES = CODE_OPERAND_POOL_SEG;
                    ES_W(_SI, OPND_LEFT) = 13;
                }
                _ES = CODE_OP_POOL_SEG;
                ES_B(_SI, COP_OPCODE) = 8;
            }
        }
next:
        _DX--;
        _SI += 4;
    }
    _SI = CODE_BLOCK_LIST_HEAD;
    while (_SI) {
        _ES = FLOW_BLOCK_POOL_SEG;
        _AX = ES_W(_SI, CNODE_KIND);
        switch (_AX) {
        case 0: case 4:
            MARK_BLOCK_OPERANDS(_SI);
        }
        _ES = FLOW_BLOCK_POOL_SEG;
        _SI = ES_W(_SI, CNODE_NEXT);
    }
}

/* ---- STAOV096 (listing ovr_1d79_a596:5E3D) ---- */
static unsigned int near pascal MARK_OPERAND_FOR_MODE(unsigned int node,unsigned int flags, unsigned int other,int expected);
static unsigned int near pascal NODE_REGISTER_NUMBER(register unsigned int value);
static void near pascal MARK_SEGMENT_REGISTER_OPERAND(unsigned int value);
static void near pascal MARK_ADDRESS_REGISTERS(unsigned int node);
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned char OPTION_TARGET_CPU;
#define INFO description[8]
/* Explicit AX uses retain the original call-tail boundaries. */
#define CALL(v,m) MARK_OPERAND_FOR_MODE((v),(m),flags,(unsigned int)INFO)

/* MARK_BLOCK_OPERANDS: for each op of block 'node' (last to first): clears its register
   and register class for the allocator, then (unless it is folded, dead, a leaf, a
   constant or a raw-word op) marks the operands its instruction can take directly. INFO
   is the op's operand size byte (description[8]); operands of another small size are not
   folded. The cases: 8087 ops take one memory operand; indirect accesses fold their
   address and segment parts; shifts fold a constant count (any count on a 186, up to 3
   on the 8086 where each is one shift) or a count in CL; POP, PUSH (an immediate only on
   a 186), calls, LEA and MOV allow the forms the x86 has; the two halves of a far pointer
   called through (0x76) stay folded only when both are the two words of the same
   variable; compares take the operand with the higher op number first; other ops fold
   the left operand first when they work in place, else the right one. */
static void near pascal MARK_BLOCK_OPERANDS(unsigned int node)
{
    unsigned int count,index,left,right,mode,flags;
    register unsigned int cursor;
    register unsigned char near *description;
    _BX=node;
    _ES=FLOW_BLOCK_POOL_SEG;
    count=ES_W(_BX,CNODE_OP_COUNT);
    cursor=(index=ES_W(_BX,CNODE_FIRST_OP)+count-1)*4;
    while(count) {
        _ES=CODE_OP_POOL_SEG;
        ES_B(cursor,COP_REGISTER)=0xFF;
        ES_B(cursor,COP_REG_CLASS)=0;
        if(ES_B(cursor,COP_FLAGS)&0x41) goto next;
        _ES=CODE_OP_POOL_SEG;
        description=CODE_OP_INFO_TABLE-3+ES_B(cursor,COP_OPCODE)*19;
        flags=*((unsigned int near *)(description+3));
        if(flags&0x29) goto next;
        mode=7;
        _ES=CODE_OP_POOL_SEG;
        switch((int)ES_B(cursor,COP_OPCODE)) {
        case 0x22: case 0x2B: case 0x2E: case 0x35: case 0x3A: case 0x3D: case 0x84:
            _ES=CODE_OP_POOL_SEG;
            if(ES_B(cursor,COP_FLAGS)&2) {
                _ES=CODE_OPERAND_POOL_SEG;
                CALL(ES_W(cursor,OPND_LEFT),5);
            } else {
                _ES=CODE_OPERAND_POOL_SEG;
                _AX=CALL(ES_W(cursor,OPND_RIGHT),1);
            }
            goto next;
        case 0x20: case 0x21: case 0x29: case 0x2A: case 0x2C: case 0x2D:
        case 0x33: case 0x34: case 0x38: case 0x39: case 0x3B: case 0x3C: case 0x82: case 0x83:
            _ES=CODE_OP_POOL_SEG;
            if(ES_B(cursor,COP_FLAGS)&2) {
                _ES=CODE_OPERAND_POOL_SEG;
                CALL(ES_W(cursor,OPND_LEFT),5);
            } else {
                _ES=CODE_OPERAND_POOL_SEG;
                _AX=CALL(ES_W(cursor,OPND_RIGHT),5);
            }
            goto next;
        case 0x5F: case 0x60: case 0x61: case 0x62: case 0x63: case 0x64:
        case 0x68: case 0x69: case 0x6A: case 0x6B: case 0x6C:
            _ES=CODE_OPERAND_POOL_SEG;
            CALL(ES_W(cursor,OPND_LEFT),5);
            goto next;
        case 0x15: case 0x16: case 0x17: case 0x18: case 0x19: case 0x1A: case 0x1B:
            _ES=CODE_OPERAND_POOL_SEG;
            MARK_ADDRESS_REGISTERS(ES_W(cursor,OPND_LEFT));
            _ES=CODE_OPERAND_POOL_SEG;
            MARK_SEGMENT_REGISTER_OPERAND(ES_W(cursor,OPND_RIGHT));
            goto next;
        case 0x44: case 0x45: case 0x46: case 0x47: case 0x48: case 0x49:
        case 0x55: case 0x56: case 0xD3: case 0xD4:
            _ES=CODE_OPERAND_POOL_SEG;
            right=ES_W(cursor,OPND_RIGHT)*4;
            _ES=CODE_OP_POOL_SEG;
            _BX=right;
            if(ES_B(_BX,COP_OPCODE)==9 || ES_B(_BX,COP_OPCODE)==10) {
                if(OPTION_TARGET_CPU || (*((unsigned long far *)MK_FP(CODE_OPERAND_POOL_SEG,right)))<=3L) {
                    _BX=right;
                    _ES=CODE_OP_POOL_SEG;
                    ES_B(_BX,COP_FLAGS)|=1;
                    _AX=_AX; /* Keep AX live across this arm. */
                }
            } else if(NODE_REGISTER_NUMBER(right)==6) {
                _BX=right;
                _ES=CODE_OP_POOL_SEG;
                ES_B(_BX,COP_FLAGS)|=1;
            }
            _ES=CODE_OP_POOL_SEG;
            if((ES_B(cursor,COP_FLAGS)&2)==0) mode=0;
            _ES=CODE_OPERAND_POOL_SEG;
            CALL(ES_W(cursor,OPND_LEFT),mode);
            goto next;
        case 0x7F:
            mode=13;
            _ES=CODE_OPERAND_POOL_SEG;
            CALL(ES_W(cursor,OPND_LEFT),mode);
            goto next;
        case 0x76:
            _ES=CODE_OPERAND_POOL_SEG;
            right=ES_W(cursor,OPND_RIGHT)*4;
            left=ES_W(cursor,OPND_LEFT)*4;
            CALL(ES_W(cursor,OPND_RIGHT),4);
            _ES=CODE_OPERAND_POOL_SEG;
            CALL(ES_W(cursor,OPND_LEFT),4);
            _ES=CODE_OP_POOL_SEG;
            _BX=left;
            if(ES_B(_BX,COP_OPCODE)==0x16) {
                _BX=right;
                if(ES_B(_BX,COP_OPCODE)==0x1B) {
                    _ES=CODE_OPERAND_POOL_SEG;
                    _AX=ES_W(_BX,OPND_LEFT);
                    _BX=left;
                    if(_AX==ES_W(_BX,OPND_LEFT)) {
                        _BX=right;
                        _AX=ES_W(_BX,OPND_RIGHT);
                        _BX=left;
                        if(_AX==ES_W(_BX,OPND_RIGHT)) {
                            _BX=right;
                            _ES=CODE_OP_POOL_SEG;
                            if(ES_B(_BX,COP_FLAGS)&1) {
                                _BX=left;
                                if(ES_B(_BX,COP_FLAGS)&1) goto next;
                            }
                        }
                    }
                }
            }
            _ES=CODE_OP_POOL_SEG;
            _BX=left;
            if(ES_B(_BX,COP_OPCODE)==0x10) {
                _BX=right;
                if(ES_B(_BX,COP_OPCODE)==0x11) {
                    if(*((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,left))==*((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,right))) {
                        if(((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,left))[1]==((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG,right))[1]-2) {
                            _BX=right;
                            _ES=CODE_OP_POOL_SEG;
                            if(ES_B(_BX,COP_FLAGS)&1) {
                                _BX=left;
                                if(ES_B(_BX,COP_FLAGS)&1) goto next;
                            }
                        }
                    }
                }
            }
            _BX=right;
            _ES=CODE_OP_POOL_SEG;
            ES_B(_BX,COP_FLAGS)&=0xFE;
            _BX=left;
            ES_B(_BX,COP_FLAGS)&=0xFE;
            goto next;
        case 0x93:
            if(OPTION_TARGET_CPU==0) mode=9; else mode=11;
            _ES=CODE_OPERAND_POOL_SEG;
            CALL(ES_W(cursor,OPND_LEFT),mode);
            goto next;
        case 0x94:
            if(OPTION_TARGET_CPU==0) mode=13; else mode=15;
        case 0x75: case 0x77: case 0x78: case 0x95:
            _ES=CODE_OPERAND_POOL_SEG;
            CALL(ES_W(cursor,OPND_LEFT),mode);
            goto next;
        case 0x98:
            mode=15;
            _ES=CODE_OPERAND_POOL_SEG;
            CALL(ES_W(cursor,OPND_LEFT),mode);
            goto next;
        case 0x80: case 0x81:
            _ES=CODE_OPERAND_POOL_SEG;
            if(ES_W(cursor,OPND_LEFT)<ES_W(cursor,OPND_RIGHT)) {
                mode=CALL(ES_W(cursor,OPND_RIGHT),mode);
                if(flags&4) {
                    _ES=CODE_OP_POOL_SEG;
                    if(ES_B(cursor,COP_FLAGS)&8) goto next;
                }
                _ES=CODE_OPERAND_POOL_SEG;
                _AX=CALL(ES_W(cursor,OPND_LEFT),mode&0xFFFD);
            } else {
                _ES=CODE_OPERAND_POOL_SEG;
                mode=CALL(ES_W(cursor,OPND_LEFT),mode&0xFFFD);
                if(flags&4) {
                    _ES=CODE_OP_POOL_SEG;
                    if(ES_B(cursor,COP_FLAGS)&8) goto next;
                }
                _ES=CODE_OPERAND_POOL_SEG;
                _AX=CALL(ES_W(cursor,OPND_RIGHT),mode);
            }
            goto next;
        case 0x9C:
            mode=13;
        default:
            if(flags&0x40) goto first;
            _ES=CODE_OP_POOL_SEG;
            if(ES_B(cursor,COP_FLAGS)&2) {
first:
                _ES=CODE_OPERAND_POOL_SEG;
                mode=CALL(ES_W(cursor,OPND_LEFT),mode&0xFFFD);
                if(flags&4) {
                    _ES=CODE_OP_POOL_SEG;
                    if(ES_B(cursor,COP_FLAGS)&8) goto next;
                }
                _ES=CODE_OPERAND_POOL_SEG;
                _AX=CALL(ES_W(cursor,OPND_RIGHT),mode);
            } else {
                _ES=CODE_OPERAND_POOL_SEG;
                _AX=CALL(ES_W(cursor,OPND_RIGHT),mode);
                _ES=CODE_OPERAND_POOL_SEG;
                CALL(ES_W(cursor,OPND_LEFT),0);
            }
            goto next;
        case 2: case 3: case 0x6E: case 0x6F: case 0x70: case 0x71:
        case 0xB5: case 0xB6: case 0xBD: case 0xBE: case 0xBF: case 0xC0:
            goto next;
        }
next:
        --count;
        cursor-=4;
    }
}
#undef INFO
#undef CALL

/* ---- STAOV097 (listing ovr_1d79_a596:6424) ---- */
extern unsigned int VARIABLE_TABLE_SEG;

/* MARK_OPERAND_FOR_MODE: folds operand op 'node' into its parent if its form is allowed
   by 'flags' (see the overview) and returns the forms left for the other operand.
   'other' is the parent's table flags (bit 0x4000: it accepts an immediate), 'expected'
   the parent's operand size. Stack slots (0xB2), indirect accesses, memory variables and
   register variables are handled by kind; frame variable addresses (13 of an auto or
   parameter) are never folded as immediates. */
static unsigned int near pascal MARK_OPERAND_FOR_MODE(unsigned int node,unsigned int flags,
                                     unsigned int other,int expected)
{
    int kind;
    register unsigned int entry;
    register unsigned int symbol;
    if (!node) return 7;
    entry = node*4;
    if (COP_B(entry,COP_OPCODE)==0xB2) {
        if (flags&4) {
            COP_B(entry,COP_FLAGS)|=1;
            return 3;
        }
        return 7;
    }
    kind=CODE_OP_INFO_TABLE[COP_B(entry,COP_OPCODE)*19+4];
    if (expected && kind!=expected && kind<=3 && expected<=3) return 7;
    switch(COP_B(entry,COP_OPCODE)) {
    case 13:
        symbol = OPND_W(entry,OPND_LEFT);
        if (VAR_B(symbol,VAR_SYMBOL_KIND)==5 || VAR_B(symbol,VAR_SYMBOL_KIND)==6) return 7;
    case 9: case 10: case 12:
        if ((flags&2) && (other&0x4000)) {
            COP_B(entry,COP_FLAGS)|=1;
        }
        return 7;
    case 8:
        if (OPND_W(entry,OPND_LEFT)>=12 && OPND_W(entry,OPND_LEFT)<=15) {
            if (flags&8) {
                COP_B(entry,COP_FLAGS)|=1;
            }
            return 5;
        }
    case 7:
        if (flags&1) {
            COP_B(entry,COP_FLAGS)|=1;
        }
        return 7;
    case 21: case 22: case 23: case 24: case 25: case 26: case 27:
        if (flags&4) {
            COP_B(entry,COP_FLAGS)|=1;
            MARK_ADDRESS_REGISTERS(OPND_W(entry,OPND_LEFT));
            MARK_SEGMENT_REGISTER_OPERAND(OPND_W(entry,OPND_RIGHT));
            return (flags&9)|2;
        }
        break;
    case 15:
        symbol = OPND_W(entry,OPND_LEFT);
        if (VAR_B(symbol,VAR_FLAGS)&2) {
            if (VAR_SC(symbol,VAR_REGISTER)>7) return 7;
            if (flags&1) {
                COP_B(entry,COP_FLAGS)|=1;
            }
            return 7;
        }
        if (flags&4) {
            COP_B(entry,COP_FLAGS)|=1;
            return 3;
        }
        break;
    case 16: case 17: case 18: case 19: case 20:
        symbol = OPND_W(entry,OPND_LEFT);
        if (VAR_B(symbol,VAR_FLAGS)&2) {
            if (VAR_SC(symbol,VAR_REGISTER)>=12 && VAR_SC(symbol,VAR_REGISTER)<=15) {
                if (flags&8) {
                    COP_B(entry,COP_FLAGS)|=1;
                }
                return 5;
            }
            if (flags&1) {
                COP_B(entry,COP_FLAGS)|=1;
            }
            return (flags&9)|7;
        }
    case 0xB2:
        if (flags&4) {
            COP_B(entry,COP_FLAGS)|=1;
            return (flags&9)|2;
        }
        break;
    }
    return (flags&9)|7;
}

/* ---- STAOV098 (listing ovr_1d79_a596:6692) ---- */
extern unsigned int VARIABLE_TABLE_SEG;

/* NODE_REGISTER_NUMBER: the register of op record 'value' when it is a register op (7, 8)
   or a leaf (0x0F-0x11) of a register variable (VAR_FLAGS 2, register at offset 7); else
   0 (which is also AX's number). */
static unsigned int near pascal NODE_REGISTER_NUMBER(register unsigned int value)
{
    if (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 8 ||
        *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 7)
        return *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, value));
    if (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 0x10 ||
        *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 0x11 ||
        *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 0x0F) {
        if ((*((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG,
                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, value)) + 0x0E)) & 2) != 0)
            return *((signed char far *)MK_FP(VARIABLE_TABLE_SEG,
                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, value)) + 7));
    }
    return 0;
}

/* ---- STAOV099 (listing ovr_1d79_a596:66F5) ---- */
extern unsigned int VARIABLE_TABLE_SEG;

/* HAS_CONSTANT_ADDRESS_PART: true when op record 'value' can be the displacement of an
   address: a word constant (0x0A), a symbol segment (0x0C) or the address of a global
   (0x0D not of an auto or parameter). It tests for a constant address
   part, not a memory operand. */
static int near pascal HAS_CONSTANT_ADDRESS_PART(register unsigned int value)
{
    if (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 0x0A ||
        *((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 0x0C)
        return 1;
    if (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 0x0D) {
        if (*((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG,
                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, value)) + 0x0D)) == 5 ||
            *((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG,
                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, value)) + 0x0D)) == 6)
            return 0;
        return 1;
    }
    return 0;
}

/* ---- STAOV09A (listing ovr_1d79_a596:674F) ---- */
extern unsigned int VARIABLE_TABLE_SEG;

/* IS_FRAME_VARIABLE_NODE: true when op record 'value' is the address (op 0x0D) of an auto
   or parameter, i.e. BP plus a constant. */
static int near pascal IS_FRAME_VARIABLE_NODE(register unsigned int value)
{
    if (*((unsigned char far *)MK_FP(CODE_OP_POOL_SEG, value)) == 0x0D) {
        if (*((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG,
                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, value)) + 0x0D)) == 5 ||
            *((unsigned char far *)MK_FP(VARIABLE_TABLE_SEG,
                *((unsigned int far *)MK_FP(CODE_OPERAND_POOL_SEG, value)) + 0x0D)) == 6)
            return 1;
        return 0;
    }
    return 0;
}

/* ---- STAOV09B (listing ovr_1d79_a596:6794) ---- */

/* MARK_SEGMENT_REGISTER_OPERAND: folds segment op 'value' (an op number) when it is
   already in a segment register (12-15), so it becomes a segment override. */
static void near pascal MARK_SEGMENT_REGISTER_OPERAND(unsigned int value)
{
    register unsigned int index;
    if (value) {
        index = value << 2;
        if (NODE_REGISTER_NUMBER(index) >= 12 && NODE_REGISTER_NUMBER(index) <= 15)
            *(unsigned char far *)MK_FP(CODE_OP_POOL_SEG, index + COP_FLAGS) |= 1;
    }
}

/* ---- STAOV09C (listing ovr_1d79_a596:67CB) ---- */
extern unsigned int VARIABLE_TABLE_SEG;

/* MARK_ADDRESS_REGISTERS: folds the parts of address op 'node' that the x86 addressing
   mode can hold: a register op or register variable in BX, SI, DI or BP (4, 8, 9, 10),
   a constant or variable address, and for an addition (op 31, unless COP_FLAGS 0x10) one
   base register, one index register and a constant part. A frame variable address may
   join SI or DI (BP+SI/DI+offset); BX with BX is not combined. Each folded op gets
   COP_FLAGS 1. */
static void near pascal MARK_ADDRESS_REGISTERS(unsigned int node)
{
    unsigned int left,kind;
    register unsigned int cursor,right;
    cursor=node*4;
    _ES=CODE_OP_POOL_SEG;
    if(ES_B(cursor,COP_FLAGS)&2) return;
    _ES=CODE_OP_POOL_SEG;
    switch((int)ES_B(cursor,COP_OPCODE)) {
    case 8:
        _ES=CODE_OPERAND_POOL_SEG;
        switch(ES_W(cursor,OPND_REGISTER)) {
        case 4: case 8: case 9: case 10:
            _ES=CODE_OP_POOL_SEG;
            ES_B(cursor,COP_FLAGS)|=1;
            _ES=CODE_OPERAND_POOL_SEG;
            _AL=ES_B(cursor,OPND_REGISTER);
            _ES=CODE_OP_POOL_SEG;
            ES_B(cursor,COP_REGISTER)=_AL;
        }
        break;
    case 16:
        _ES=CODE_OPERAND_POOL_SEG;
        right=ES_W(cursor,OPND_VARIABLE);
        _ES=VARIABLE_TABLE_SEG;
        if(ES_B(right,VAR_FLAGS)&2) {
            _ES=VARIABLE_TABLE_SEG;
            switch((int)ES_SC(right,VAR_REGISTER)) {
            case 4: case 8: case 9: case 10:
                _ES=CODE_OP_POOL_SEG;
                ES_B(cursor,COP_FLAGS)|=1;
                cursor=cursor; /* Retain this separate branch tail. */
            }
        }
        break;
    case 10: case 13:
        cursor=cursor; /* Retain the original branch join. */
        goto mark_current;
    case 31:
        _ES=CODE_OP_POOL_SEG;
        if(ES_B(cursor,COP_FLAGS)&0x10) break;
        _ES=CODE_OPERAND_POOL_SEG;
        left=ES_W(cursor,OPND_LEFT)*4;
        right=ES_W(cursor,OPND_RIGHT)*4;
        if(HAS_CONSTANT_ADDRESS_PART(right)) {
            _ES=CODE_OPERAND_POOL_SEG;
            MARK_ADDRESS_REGISTERS(ES_W(cursor,OPND_LEFT));
            goto mark_right;
        }
        if(HAS_CONSTANT_ADDRESS_PART(left)) {
            _ES=CODE_OPERAND_POOL_SEG;
            MARK_ADDRESS_REGISTERS(ES_W(cursor,OPND_RIGHT));
            _BX=left;
            _ES=CODE_OP_POOL_SEG;
            ES_B(_BX,COP_FLAGS)|=1;
            goto mark_current;
        }
        switch(NODE_REGISTER_NUMBER(left)) {
        case 4: goto done;
        case 8: case 9:
            if(IS_FRAME_VARIABLE_NODE(right)) {
                _ES=CODE_OP_POOL_SEG;
                ES_B(right,COP_FLAGS)|=1;
            }
            _BX=left;
            _ES=CODE_OP_POOL_SEG;
            ES_B(_BX,COP_FLAGS)|=1;
            goto mark_current;
        case 10:
            kind=NODE_REGISTER_NUMBER(right);
            if(kind==8 || kind==9) {
                _ES=CODE_OP_POOL_SEG;
                ES_B(right,COP_FLAGS)|=1;
            }
            _BX=left;
            _ES=CODE_OP_POOL_SEG;
            ES_B(_BX,COP_FLAGS)|=1;
            goto mark_current;
        }
        switch(NODE_REGISTER_NUMBER(right)) {
        case 8: case 9:
            if(IS_FRAME_VARIABLE_NODE(left)) {
                _BX=left;
                _ES=CODE_OP_POOL_SEG;
                ES_B(_BX,COP_FLAGS)|=1;
            }
        case 4: case 10:
mark_right:
            _ES=CODE_OP_POOL_SEG;
            ES_B(right,COP_FLAGS)|=1;
mark_current:
            _ES=CODE_OP_POOL_SEG;
            ES_B(cursor,COP_FLAGS)|=1;
        }
    }
done:
    ;
}
