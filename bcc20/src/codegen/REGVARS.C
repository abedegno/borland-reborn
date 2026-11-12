/* target: ovr156_C212UNIT */
/* Role: register variable allocation. Entry points: ASSIGN_REGISTER_VARIABLES,
   FIND_OR_ADD_VARIABLE, RELEASE_VARIABLE_TABLE. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO060 (ovr_1d80_a69d) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: the code generator's variable table and the choice of register variables.
   The variable table (VARIABLE_TABLE_SEG, 29-byte entries from offset 2 up to
   VARIABLE_TABLE_END, fields VAR_*) has one entry per variable a function's code ops
   name: FIND_OR_ADD_VARIABLE creates it the first time a front-end symbol is used (the
   symbol remembers its entry through GET/SET_SYMBOL_VARIABLE_HOOK) or makes an unnamed
   temporary; RELEASE_VARIABLE_TABLE forgets all entries after the function. VAR_FLAGS
   bits: 1 (from flag 0x10 at creation), 2 lives in a register (VAR_REGISTER), 4 must stay
   in memory, 8 probably declared 'register', 0x20 assigned, 0x40 read, 0x80 (from flag 2 at
   creation, probably volatile).
   ASSIGN_REGISTER_VARIABLES (called by GENERATE_FUNCTION_CODE) repeatedly picks the
   variable with the best score among those of the scope tree and gives it a register,
   until no candidate is left. Scores come from the loop-weighted counts of VARUSES.C;
   which registers a variable may take depends on its type and on how it is used. Scope
   entry blocks record the registers taken: CNODE_SCOPE_OWN_REGS for the scope's own
   variables, CNODE_SCOPE_REG_MASK for registers used in it or in nested scopes.
   Field names to watch: on scope blocks FIND_BEST_REGISTER_VARIABLE reads offset 4
   through CNODE_FIRST_OP (really CNODE_SCOPE_REG_MASK, the same offset) and the sibling
   link through CNODE_SWITCH_HIGH_OP (really CNODE_SCOPE_SIBLING); MARK_BLOCK_TREE_REGISTERS
   uses raw word indexes 2, 10, 11, 12 for the same scope fields. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"



/* ---- STAOV09D (listing ovr_1d80_a69d:69D0) ---- */
static void near pascal FIND_BEST_REGISTER_VARIABLE(register unsigned int root,unsigned int far *best, unsigned int far *symbol,unsigned int far *node, signed char far *flag);
static void near pascal MARK_BLOCK_TREE_REGISTERS(register unsigned int node, register unsigned int flags);
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
extern void (far pascal *REGVAR_ASSIGNED_HOOK)(unsigned int,int);
extern unsigned int far pascal FREE_REGISTER_MASK(void);

/* ASSIGN_REGISTER_VARIABLES: assigns registers to the best-scoring variables of the
   current function, one at a time, while FREE_REGISTER_MASK leaves registers. For each
   winner: VAR_FLAGS 2 and VAR_REGISTER are set, the front end is told
   (REGVAR_ASSIGNED_HOOK), the register is added to FUNCTION_CLAIMED_REG_MASK, to the
   owning scope's CNODE_SCOPE_OWN_REGS, to CNODE_SCOPE_REG_MASK of that scope and all
   enclosing ones, and to every nested scope (MARK_BLOCK_TREE_REGISTERS), so no variable
   whose life overlaps can get it. */
void far pascal ASSIGN_REGISTER_VARIABLES(void)
{
    unsigned int saved,status,node,symbol,count;
    signed char flag;
    saved=FUNCTION_OUTER_SCOPE_BLOCK;
    status=FREE_REGISTER_MASK();
    if (!status) return;
    for (;;) {
        node=0;
        symbol=0;
        count=1;
        flag=0;
        FIND_BEST_REGISTER_VARIABLE(saved,&count,&symbol,&node,&flag);
        if (!symbol) break;
        _BX=symbol;
        _ES=VARIABLE_TABLE_SEG;
        ES_B(_BX,VAR_FLAGS)|=2;
        _AL=flag;
        ES_B(_BX,VAR_REGISTER)=_AL;
        if (ES_W(_BX,VAR_SYMBOL)) REGVAR_ASSIGNED_HOOK(ES_W(_BX,VAR_SYMBOL),(int)(signed char)_AL);
        _DI=1<<flag;
        FUNCTION_CLAIMED_REG_MASK|=_DI;
        _BX=node;
        _ES=FLOW_BLOCK_POOL_SEG;
        ES_W(_BX,CNODE_SCOPE_OWN_REGS)|=_DI;
        for (_SI=node;_SI;_SI=ES_W(_SI,CNODE_SCOPE_PARENT)) {
            _ES=FLOW_BLOCK_POOL_SEG;
            ES_W(_SI,CNODE_SCOPE_REG_MASK)|=_DI;
        }
        _BX=node;
        _ES=FLOW_BLOCK_POOL_SEG;
        MARK_BLOCK_TREE_REGISTERS(ES_W(_BX,CNODE_SCOPE_CHILD),_DI);
    }
}

/* ---- STAOV09E (listing ovr_1d80_a69d:6A8A) ---- */
static unsigned int near pascal REGISTER_VARIABLE_SCORE(register unsigned int symbol,signed char far *flag, register unsigned int mask);
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;

/* FIND_BEST_REGISTER_VARIABLE: walks the scope tree from scope entry block 'root'
   (children and siblings, recursively) and, for each variable owned by a scope, computes
   REGISTER_VARIABLE_SCORE over the registers still free in that scope. The best so far
   is kept in *best (score), *symbol (variable entry), *node (its scope) and *flag (the
   register chosen). */
static void near pascal FIND_BEST_REGISTER_VARIABLE(register unsigned int root,unsigned int far *best,
                                    unsigned int far *symbol,unsigned int far *node,
                                    signed char far *flag)
{
    unsigned int mask;
    signed char selected;
    unsigned int score;
    register unsigned int entry;
    mask=~(CNODE_W(root,CNODE_SCOPE_REG_MASK)|CODEGEN_USED_REG_MASK);
    if (mask) {
        for (entry=2;entry<VARIABLE_TABLE_END;entry+=29) {
            if (VAR_W(entry,VAR_SCOPE_BLOCK)==root) {
                score=REGISTER_VARIABLE_SCORE(entry,&selected,mask);
                if (*best<score) {
                    *symbol=entry;
                    *node=root;
                    *best=score;
                    *flag=selected;
                }
            }
        }
    }
    root=CNODE_W(root,CNODE_SCOPE_CHILD);
    while (root) {
        FIND_BEST_REGISTER_VARIABLE(root,best,symbol,node,flag);
        root=CNODE_W(root,CNODE_SCOPE_SIBLING);
    }
}

/* ---- STAOV09F (listing ovr_1d80_a69d:6B38) ---- */
/* -Z: ES is kept across far stores into the same segment (user-accepted, batch290-admission/policy-Z-extension.json). */


extern unsigned int FLOW_BLOCK_POOL_SEG;

/* MARK_BLOCK_TREE_REGISTERS: ORs register mask 'flags' into the register mask (word 2,
   offset 4) and own-register mask (word 10, offset 0x14) of scope 'node', its siblings
   (word 12) and all their nested scopes (word 11). */
static void near pascal MARK_BLOCK_TREE_REGISTERS(register unsigned int node, register unsigned int flags)
{
    while (node) {
        ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[2] |= flags;
        ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[10] |= flags;
        MARK_BLOCK_TREE_REGISTERS(((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[11], flags);
        node = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[12];
    }
}

/* ---- STAOV0A0 (listing ovr_1d80_a69d:6B6D) ---- */
/* LOWEST_SET_BIT_INDEX: number of the lowest set bit of 'value' (which must not be 0),
   i.e. the first register in a register mask. */
static int near pascal LOWEST_SET_BIT_INDEX(unsigned int value)
{
    _DI = value;
    _DL = 0;
    _SI = 1;
    while ((_SI & _DI) == 0) {
        _SI <<= 1;
        _DL++;
    }
    return (char)_DL;
}

/* ---- STAOV0A1 (listing ovr_1d80_a69d:6B8F) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int far pascal BYTE_REGISTERS_MASK(void);

/* REGISTER_VARIABLE_SCORE: the benefit of keeping variable entry 'symbol' in one of the
   registers in 'mask'; 0 means 'not a candidate'. Sets *flag to the register chosen.
   Not candidates: entries already in a register, forced to memory or flagged 0x80, an
   entry with flag 1 that repeats the previous entry's symbol (probably the second word of
   a split variable), and types other than char, short, int, near or _seg pointer, enum.
   Chars need a byte register (BYTE_REGISTERS_MASK) and prefer CX when used as a shift
   count. Word variables prefer BX/SI/DI when used as addresses, the ES class when used
   more often as a segment, and never take the ES class otherwise. The score is the use
   count plus the weights that fit the register chosen, +0x8000 for a variable declared
   'register' (VAR_FLAGS 8), +2 when its preferred register (VAR_PREFERRED_REG) is free; minus 1 for an
   auto, or 2 for a parameter without a preferred register (it must be loaded first). */
static unsigned int near pascal REGISTER_VARIABLE_SCORE(register unsigned int symbol,signed char far *flag,
                                     register unsigned int mask)
{
    unsigned int total,adjustment,available;
    if (!symbol) return 0;
    if (VAR_B(symbol,VAR_FLAGS)&0x86) return 0;
    if ((VAR_B(symbol,VAR_FLAGS)&1) && symbol>2 && VAR_W(symbol,VAR_SYMBOL)==VAR_W(symbol,-29)) return 0;
    mask&=~VAR_W(symbol,VAR_EXCLUDED_REGS);
    if (!mask) return 0;
    switch (VAR_B(symbol,VAR_TYPE_KIND)) {
    case 1: case 2:
        available=BYTE_REGISTERS_MASK();
        if ((available&mask)==0) return 0;
        if (VAR_W(symbol,VAR_SHIFT_COUNT_USES) && (REG_MASK_CX&mask)) mask&=REG_MASK_CX;
        *flag=LOWEST_SET_BIT_INDEX(mask);
        break;
    case 3: case 4: case 5: case 6: case 13: case 14: case 21:
        if (VAR_W(symbol,VAR_INDEX_WEIGHT) && (REG_MASK_BX_SI_DI&mask)) {
            if (VAR_W(symbol,VAR_ES_CLASS_WEIGHT)>VAR_W(symbol,VAR_INDEX_WEIGHT) && (REG_MASK_ES&mask))
                mask&=REG_MASK_ES;
            else mask&=REG_MASK_BX_SI_DI;
        } else {
            if (VAR_W(symbol,VAR_ES_CLASS_WEIGHT) && (REG_MASK_ES&mask)) mask&=REG_MASK_ES;
        }
        if (VAR_W(symbol,VAR_ES_CLASS_WEIGHT)==0) mask&=~REG_MASK_ES;
        if (!mask) return 0;
        *flag=LOWEST_SET_BIT_INDEX(mask);
        break;
    default:
        return 0;
    }
    if (VAR_B(symbol,VAR_FLAGS)&8) total=0x8000;
    else {
        if ((1<<VAR_B(symbol,VAR_PREFERRED_REG))&mask) {
            total=2;
            *flag=VAR_B(symbol,VAR_PREFERRED_REG);
        } else total=0;
    }
    total+=VAR_W(symbol,VAR_USE_COUNT);
    if (REG_MASK_BX_SI_DI&(1<<*flag)) total+=VAR_W(symbol,VAR_INDEX_WEIGHT);
    if (REG_MASK_ES&(1<<*flag)) total+=VAR_W(symbol,VAR_ES_CLASS_WEIGHT);
    if (REG_MASK_CX&(1<<*flag)) total+=VAR_W(symbol,VAR_SHIFT_COUNT_USES);
    if (VAR_B(symbol,VAR_SYMBOL_KIND)==6) {
        if (VAR_B(symbol,VAR_PREFERRED_REG)) adjustment=0;
        else adjustment=2;
    } else adjustment=1;
    if (total<adjustment) return 0;
    return total-adjustment;
}

/* ---- STAOV0A2 (listing ovr_1d80_a69d:6DA5) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int (far pascal *GET_SYMBOL_VARIABLE_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_VARIABLE_HOOK)(unsigned int, unsigned int);
extern unsigned int (far pascal *TYPE_HOOK)(unsigned int);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern int (far pascal *GET_SYMBOL_KIND_HOOK)(unsigned int);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *, unsigned int);

/* FIND_OR_ADD_VARIABLE: returns the variable-table entry of front-end symbol 'name',
   creating it on first use, or a new unnamed temporary of type kind 'kind' when 'name' is
   0 (owned by the outermost scope, symbol kind 5). A new named entry records the
   symbol's type, type kind, segment, symbol kind (VAR_SYMBOL_KIND: 3/4 global, 5 auto,
   6 parameter) and the current scope. 'flags': 8 the variable was probably declared 'register', 2
   and 0x10 set VAR_FLAGS 0x80 and 1. Globals, and every non-'register' variable under
   OPTION_REGISTER_VARS 2 (probably -rd, declared register variables only), and parameters
   under calling convention 4, are marked as staying in memory (4). */
unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int name, unsigned char kind,
                                     unsigned char flags)
{
    int category;
    _DI = name;
    if (_DI && (_SI = GET_SYMBOL_VARIABLE_HOOK(_DI), _SI))
        return _SI;
    _SI = POOL_ALLOC(&VARIABLE_TABLE_SEG, 29);
    RTL_MEMSET((void far *)MK_FP(VARIABLE_TABLE_SEG, _SI), 0, 29);
    _ES = VARIABLE_TABLE_SEG;
    ES_W(_SI, VAR_SYMBOL) = _DI;
    ES_B(_SI, VAR_PREFERRED_REG) = 0xFF;
    if (_DI) {
        SET_SYMBOL_VARIABLE_HOOK(_DI, _SI);
        _AX = TYPE_HOOK(_DI);
        _ES = VARIABLE_TABLE_SEG;
        ES_W(_SI, VAR_TYPE) = _AX;
        _AL = GET_TYPE_KIND_HOOK(ES_W(_SI, VAR_TYPE));
        _ES = VARIABLE_TABLE_SEG;
        ES_B(_SI, VAR_TYPE_KIND) = _AL;
        _AX = GET_SYMBOL_SEGMENT_HOOK(_DI);
        _ES = VARIABLE_TABLE_SEG;
        ES_W(_SI, VAR_SEGMENT) = _AX;
        category = GET_SYMBOL_KIND_HOOK(_DI);
        _ES = VARIABLE_TABLE_SEG;
        ES_B(_SI, VAR_SYMBOL_KIND) = _AL;
        ES_W(_SI, VAR_SCOPE_BLOCK) = CURRENT_SCOPE_BLOCK;
        if (category == 6 && CODEGEN_CALL_CONV == 4) {
            _SI = _SI;
            goto automatic;
        }
        if (flags & 8) {
            _ES = VARIABLE_TABLE_SEG;
            ES_B(_SI, VAR_FLAGS) = 8;
        } else {
            if (OPTION_REGISTER_VARS == 2) {
                _SI = _SI;
                goto automatic;
            }
            if (category != 6 && category != 5) {
automatic:
                _ES = VARIABLE_TABLE_SEG;
                ES_B(_SI, VAR_FLAGS) = 4;
            }
        }
        if (flags & 2) {
            _ES = VARIABLE_TABLE_SEG;
            ES_B(_SI, VAR_FLAGS) |= 0x80;
        }
        if (flags & 0x10) {
            _ES = VARIABLE_TABLE_SEG;
            ES_B(_SI, VAR_FLAGS) |= 1;
        }
        if (category != 5) {
            _ES = VARIABLE_TABLE_SEG;
            ES_B(_SI, VAR_FLAGS) |= 0x20;
        }
    } else {
        _ES = VARIABLE_TABLE_SEG;
        ES_W(_SI, VAR_SCOPE_BLOCK) = FUNCTION_OUTER_SCOPE_BLOCK;
        ES_B(_SI, VAR_TYPE_KIND) = kind;
        ES_B(_SI, VAR_SYMBOL_KIND) = 5;
    }
    return _SI;
}

/* ---- STAOV0A3 (listing ovr_1d80_a69d:6ECA) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
extern void (far pascal *SET_SYMBOL_VARIABLE_HOOK)(unsigned int, unsigned int);
extern void far pascal RESET_TEMP_POOL(void);

/* RELEASE_VARIABLE_TABLE: clears the symbol-to-entry links of all entries, empties the
   variable table and resets the temporary pool. Called at the end of
   GENERATE_FUNCTION_CODE. */
void far pascal RELEASE_VARIABLE_TABLE(void)
{
    register unsigned int entry;
    entry = 2;
    while (entry < VARIABLE_TABLE_END) {
        if (((unsigned int far *)MK_FP(VARIABLE_TABLE_SEG, entry))[0])
            SET_SYMBOL_VARIABLE_HOOK(((unsigned int far *)MK_FP(VARIABLE_TABLE_SEG, entry))[0], 0);
        entry += 29;
    }
    VARIABLE_TABLE_FREE_LIST = 0;
    VARIABLE_TABLE_END = 2;
    RESET_TEMP_POOL();
}
