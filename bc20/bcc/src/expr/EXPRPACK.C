/* target: ovr100_C42UNIT */
/* Role: expressions: packs expression trees into compact records in a separate pool and
   rebuilds them; used for inline bodies and default arguments, with pool mark/reset. Entry
   points: PACK_EXPR_TREE, UNPACK_EXPR_TREE, EXPR_BANK_MARK, EXPR_BANK_RESET. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: expression nodes (EXPR_POOL_SEG) live only until the pool is reset, but
   some trees must be kept longer: default arguments of C++ functions, inline function
   bodies (expr/INLINEXP.C) and the deferred initialisers of expr/LOWEREXP.C. This file
   copies such a tree into PACKED_EXPR_POOL_SEG in a compact form, and copies it back
   into fresh expression nodes when it is needed (UNPACK_EXPR_TREE, each time, so every
   use gets its own nodes). A packed record has a header (byte 0 operator, byte 1 node
   flags, word 2 type, words 4..9 the source position, struct C42StoredHeader) followed
   from offset 10 (PEXPR_OPERANDS) by what the operator needs: the long value of a
   constant, the 10-byte long double of a floating constant (operator 3), the operand
   words of a leaf (operators 1 and 7 symbols, 0x48, 0x38 member names, 0x4A, 0x39
   members), or for every other operator the packed records of its two operands.
   Leaves are therefore 14 to 20 bytes instead of a full 0x1A-byte node. Error nodes and
   empty trees pack to 0. EXPR_BANK_MARK / EXPR_BANK_RESET let a caller free everything
   packed after a mark. */
/* Compact expression records and their reconstruction. */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
#include <dos.h>
#include "EXPRPACK.H"
#include "POOL.H"
#define R(r,o) AT_W(PACKED_EXPR_POOL_SEG,(r)+(o))
#define RB(r,o) AT_B(PACKED_EXPR_POOL_SEG,(r)+(o))
#define RL(r,o) AT_L(PACKED_EXPR_POOL_SEG,(r)+(o))
#define RECORD(r) (*(struct C42StoredHeader far *)MK_FP(PACKED_EXPR_POOL_SEG,(r)))
#define LOCATION(s,o) (*(struct C42Location far *)MK_FP((s),(o)))
#define BANK (*(struct C42PoolState near *)&PACKED_EXPR_POOL_SEG)
/* PACK_EXPR_TREE: packs expression (recursively) and returns the packed record, or 0
   for a null tree or an error node. The source tree is left as it is. */
unsigned int far pascal PACK_EXPR_TREE(unsigned int expression)
{
    register unsigned int record;
    if(!expression||!EXPR_W(expression,EXPR_OP)) return 0;
    switch(EXPR_W(expression,EXPR_OP)) {
    case EOP_CONST:
        record=POOL_ALLOC(&PACKED_EXPR_POOL_SEG,14);
        RL(record,10)=AT_L(EXPR_POOL_SEG,expression+10);
        break;
    case 3:
        record=POOL_ALLOC(&PACKED_EXPR_POOL_SEG,20);
        RTL_MEMMOVE(MK_FP(PACKED_EXPR_POOL_SEG,record+PEXPR_OPERANDS),MK_FP(EXPR_POOL_SEG,expression+EXPR_LEFT),10);
        break;
    case 0x48:
        record=POOL_ALLOC(&PACKED_EXPR_POOL_SEG,16);
        R(record,10)=EXPR_W(expression,EXPR_LEFT);
        R(record,12)=EXPR_W(expression,EXPR_RIGHT);
        R(record,14)=EXPR_W(expression,EXPR_SCOPE_CLASS);
        break;
    case 1:case 7:
        record=POOL_ALLOC(&PACKED_EXPR_POOL_SEG,16);
        R(record,10)=EXPR_W(expression,EXPR_LEFT);
        R(record,12)=EXPR_W(expression,EXPR_RIGHT);
        R(record,14)=EXPR_W(expression,EXPR_SCOPE_CLASS);
        break;
    case 0x38:
        record=POOL_ALLOC(&PACKED_EXPR_POOL_SEG,18);
        R(record,10)=EXPR_W(expression,EXPR_LEFT);
        R(record,12)=EXPR_W(expression,EXPR_RIGHT);
        R(record,14)=EXPR_W(expression,EXPR_SCOPE_CLASS);
        R(record,16)=EXPR_W(expression,EXPR_NAME_KIND);
        break;
    case 0x4A:
        record=POOL_ALLOC(&PACKED_EXPR_POOL_SEG,14);
        R(record,10)=EXPR_W(expression,EXPR_LEFT);
        R(record,12)=EXPR_W(expression,EXPR_RIGHT);
        break;
    case 0x39:
        record=POOL_ALLOC(&PACKED_EXPR_POOL_SEG,14);
        R(record,10)=EXPR_W(expression,EXPR_LEFT);
        RB(record,12)=EXPR_B(expression,EXPR_BIT_WIDTH);
        RB(record,13)=EXPR_B(expression,EXPR_BIT_SHIFT);
        break;
    default:
        record=POOL_ALLOC(&PACKED_EXPR_POOL_SEG,14);
        R(record,10)=PACK_EXPR_TREE(EXPR_W(expression,EXPR_LEFT));
        R(record,12)=PACK_EXPR_TREE(EXPR_W(expression,EXPR_RIGHT));
        break;
    }
    RECORD(record).kind=EXPR_B(expression,EXPR_OP);
    RECORD(record).flags=EXPR_B(expression,EXPR_NODE_FLAGS);
    RECORD(record).type=EXPR_W(expression,EXPR_TYPE);
    RECORD(record).location=LOCATION(EXPR_POOL_SEG,expression+20);
    return record;
}
/* UNPACK_EXPR_TREE: rebuilds a tree of new expression nodes from a packed record
   (0 gives 0). */
unsigned int far pascal UNPACK_EXPR_TREE(register unsigned int record)
{
    register unsigned int expression;
    if(!record) return 0;
    expression=ALLOC_EXPR_NODE();
    EXPR_W(expression,EXPR_OP)=RB(record,0);
    EXPR_B(expression,EXPR_NODE_FLAGS)=RB(record,1);
    EXPR_W(expression,EXPR_TYPE)=R(record,2);
    LOCATION(EXPR_POOL_SEG,expression+20)=RECORD(record).location;
    switch(RB(record,0)) {
    case 2:
        AT_L(EXPR_POOL_SEG,expression+10)=RL(record,10);
        break;
    case 3:
        RTL_MEMMOVE(MK_FP(EXPR_POOL_SEG,expression+EXPR_LEFT),MK_FP(PACKED_EXPR_POOL_SEG,record+PEXPR_OPERANDS),10);
        break;
    case 0x48:
        EXPR_W(expression,EXPR_LEFT)=R(record,10);
        EXPR_W(expression,EXPR_RIGHT)=R(record,12);
        EXPR_W(expression,EXPR_SCOPE_CLASS)=R(record,14);
        break;
    case 1:case 7:
        EXPR_W(expression,EXPR_LEFT)=R(record,10);
        EXPR_W(expression,EXPR_RIGHT)=R(record,12);
        EXPR_W(expression,EXPR_SCOPE_CLASS)=R(record,14);
        break;
    case 0x38:
        EXPR_W(expression,EXPR_LEFT)=R(record,10);
        EXPR_W(expression,EXPR_RIGHT)=R(record,12);
        EXPR_W(expression,EXPR_SCOPE_CLASS)=R(record,14);
        EXPR_W(expression,EXPR_NAME_KIND)=R(record,16);
        break;
    case 0x4A:
        EXPR_W(expression,EXPR_LEFT)=R(record,10);
        EXPR_W(expression,EXPR_RIGHT)=R(record,12);
        break;
    case 0x39:
        EXPR_W(expression,EXPR_LEFT)=R(record,10);
        EXPR_B(expression,EXPR_BIT_WIDTH)=RB(record,12);
        EXPR_B(expression,EXPR_BIT_SHIFT)=RB(record,13);
        break;
    default:
        EXPR_W(expression,EXPR_LEFT)=UNPACK_EXPR_TREE(R(record,10));
        EXPR_W(expression,EXPR_RIGHT)=UNPACK_EXPR_TREE(R(record,12));
        break;
    }
    return expression;
}
/* EXPR_BANK_MARK: the current fill position of the packed pool, for EXPR_BANK_RESET. */
unsigned int far pascal EXPR_BANK_MARK(void)
{
    return BANK.used;
}
/* EXPR_BANK_RESET: frees every packed record allocated after position (a value from
   EXPR_BANK_MARK). */
void far pascal EXPR_BANK_RESET(unsigned int position)
{
    BANK.word6=0;
    BANK.used=position;
}
