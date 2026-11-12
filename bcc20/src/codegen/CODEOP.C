/* target: ovr176_C223UNIT */
/* Role: code generation: maps an expression node to its code operation number through
   operand-kind tables; probably refines register-variable operands. Entry points:
   CODE_OP_FOR_NODE. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO073 (ovr_1dd0_b1e7) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: two table lookups of the code generator. CODE_OP_FOR_NODE picks the code op
   for an expression node: code ops come in families, one per expression operator, with
   one member per value type, so the op is OPERAND_BASE_BY_KIND[operator] plus an offset
   by the node's value kind (EXPR_KIND) from LEAF_OPCODE_KIND_OFFSET (leaves: operators up
   to 7 and EOP_DEREF 0x31) or OPER_OPCODE_KIND_OFFSET (operators). Note that
   OPERAND_BASE_BY_KIND is indexed by operator, not by kind. REFINE_KIND_10_OPERAND is
   called by the register allocator (REGALLOC.C, through REFINE_KIND_10_OPERAND_STUB) to
   make register class 10 of an operand more precise. The _DI/_CX/_DL register code
   and the '_DL=_DL' line are shapes kept for byte matching. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- CODE_OP_FOR_NODE (listing ovr_1dd0_b1e7:1E70) ---- */
extern unsigned int EXPR_POOL_SEG;

/* CODE_OP_FOR_NODE: returns the code op number for expression node 'value' (operator
   EXPR_OP, value kind EXPR_KIND). Used by the expression generators (CGEXPR.C, CGOPER.C,
   SAVEREGS.C and others) before building the op with NEW_CODE_NODE. */
unsigned int far pascal CODE_OP_FOR_NODE(unsigned int value)
{
    register unsigned int kind,node;
    unsigned int index;
    node=value;
    kind=((unsigned int far *)MK_FP(EXPR_POOL_SEG,node))[0];
    index=((unsigned int far *)MK_FP(EXPR_POOL_SEG,node))[1];
    if((int)kind<=7 || kind==0x31)
        return OPERAND_BASE_BY_KIND[kind]+LEAF_OPCODE_KIND_OFFSET[index];
    return OPERAND_BASE_BY_KIND[kind]+OPER_OPCODE_KIND_OFFSET[index];
}

/* ---- REFINE_KIND_10_OPERAND (listing ovr_1dd0_b1e7:1EB3) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
/* REFINE_KIND_10_OPERAND: 'kind' is an operand's register class from the op table and
   'value' the operand op number. Classes other than 10 come back unchanged. For class 10
   (probably 'an address register') the result depends on what the operand is: 13 when it
   is already in SI or DI (a register variable leaf 16 or a register op 8; probably the
   index-register class), 32 when it is a variable leaf 13 of an auto (5) or parameter (6),
   otherwise 14. */
static unsigned int far pascal REFINE_KIND_10_OPERAND(unsigned int kind,unsigned int value)
{
    _DI=kind;_CX=value;
    if(_DI!=10) return _DI;
    if(_CX==0) goto fallback;
    _SI=_CX<<2;
    _ES=CODE_OP_POOL_SEG;
    if(ES_B(_SI,COP_OPCODE)==16) {
        _ES=CODE_OPERAND_POOL_SEG;_BX=ES_W(_SI,OPND_VARIABLE);_ES=VARIABLE_TABLE_SEG;
        if(ES_B(_BX,VAR_FLAGS)&2) {
            _ES=CODE_OPERAND_POOL_SEG;_BX=ES_W(_SI,OPND_VARIABLE);_ES=VARIABLE_TABLE_SEG;
            _AL=ES_B(_BX,VAR_REGISTER);_DL=_AL;
            if(_DL==8 || _DL==9) return 13;
            /* Retain the separate fallback edge without emitted instructions. */
            _DL=_DL;
            goto fallback;
        }
    }
    _ES=CODE_OP_POOL_SEG;
    if(ES_B(_SI,COP_OPCODE)==8) {
        _ES=CODE_OPERAND_POOL_SEG;_AL=ES_B(_SI,OPND_REGISTER);_DL=_AL;
        if(_DL==8 || _DL==9) return 13;
    }
    _ES=CODE_OP_POOL_SEG;
    if(ES_B(_SI,COP_OPCODE)==13) {
        _ES=CODE_OPERAND_POOL_SEG;_BX=ES_W(_SI,OPND_VARIABLE);_ES=VARIABLE_TABLE_SEG;
        if(ES_B(_BX,VAR_SYMBOL_KIND)==5) goto thirtytwo;
        _ES=CODE_OPERAND_POOL_SEG;_BX=ES_W(_SI,OPND_VARIABLE);_ES=VARIABLE_TABLE_SEG;
        if(ES_B(_BX,VAR_SYMBOL_KIND)==6) {
thirtytwo:
            return 32;
        }
    }
fallback:
    return 14;
}
