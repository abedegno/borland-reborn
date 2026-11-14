/* regvars.c: from bcc20/src/codegen/REGVARS.C: the code generator's variable table and the
   choice of register variables.  The variable table (VARIABLE_TABLE_SEG, 29-byte entries
   from offset 2 up to VARIABLE_TABLE_END) has one entry per variable a function's code ops
   name: FIND_OR_ADD_VARIABLE creates it the first time a front-end symbol is used (the
   symbol remembers its entry through the GET/SET_SYMBOL_VARIABLE hooks) or makes an unnamed
   temporary; RELEASE_VARIABLE_TABLE forgets all entries after the function.  VAR_FLAGS: 1
   (flag 10h at creation), 2 lives in a register, 4 must stay in memory, 8 declared
   register, 20h assigned, 40h read, 80h (flag 2 at creation, volatile).
   ASSIGN_REGISTER_VARIABLES repeatedly picks the variable with the best score among those
   of the scope tree and gives it a register, until no candidate is left.  Scope entry blocks
   record the registers taken: CNODE_SCOPE_OWN_REGS for the scope's own variables,
   CNODE_SCOPE_REG_MASK for registers used in it or in nested scopes. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "explain.h"

#define MASK_BIT(n) ((u16)(1u << ((n) & 31)))

/* assigns registers to the best-scoring variables of the current function, one at a time,
   while FREE_REGISTER_MASK leaves registers.  Each winner gets VAR_FLAGS 2 and its
   register, the front end is told, and the register is added to FUNCTION_CLAIMED_REG_MASK,
   to the owning scope's own registers, to the register mask of that scope and all enclosing
   ones, and to every nested scope */
void ASSIGN_REGISTER_VARIABLES(void)
{
    u16 root = FUNCTION_OUTER_SCOPE_BLOCK;
    if (!FREE_REGISTER_MASK())
        return;
    /* the original frame from BP-0Ch: flag at 1, count at 2, symbol at 4, node at 6 */
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x0C);
    farptr flag = fp_add(v, 1), count = fp_add(v, 2), symbol = fp_add(v, 4), node = fp_add(v, 6);
    for (;;) {
        W(node) = 0;
        W(symbol) = 0;
        W(count) = 1;
        SB(flag) = 0;
        FIND_BEST_REGISTER_VARIABLE(root, count, symbol, node, flag);
        u16 entry = W(symbol);
        if (!entry)
            break;
        VAR_B(entry, VAR_FLAGS) |= 2;
        VAR_B(entry, VAR_REGISTER) = B(flag);
        EXPLAIN("regvar var=%s reg=%s score=%u", explain_symbol(VAR_W(entry, VAR_SYMBOL)),
                explain_register((u16)SB(flag)), W(count));
        if (VAR_W(entry, VAR_SYMBOL))
            CALL_FAR(REGVAR_ASSIGNED_HOOK, A16(VAR_W(entry, VAR_SYMBOL)), A16((i16)SB(flag)));
        u16 bit = MASK_BIT(SB(flag));
        FUNCTION_CLAIMED_REG_MASK |= bit;
        CNODE_W(W(node), CNODE_SCOPE_OWN_REGS) |= bit;
        for (u16 scope = W(node); scope; scope = CNODE_W(scope, CNODE_SCOPE_PARENT))
            CNODE_W(scope, CNODE_SCOPE_REG_MASK) |= bit;
        MARK_BLOCK_TREE_REGISTERS(CNODE_W(W(node), CNODE_SCOPE_CHILD), bit);
    }
    scratch_release(mark);
}

/* walks the scope tree from scope entry block root (children and siblings, recursively)
   and, for each variable owned by a scope, computes REGISTER_VARIABLE_SCORE over the
   registers still free in that scope.  The best so far is kept in *best (score), *symbol
   (variable entry), *node (its scope) and *flag (the register chosen) */
void FIND_BEST_REGISTER_VARIABLE(u16 root, farptr best, farptr symbol, farptr node, farptr flag)
{
    u16 mask = (u16)~(CNODE_W(root, CNODE_SCOPE_REG_MASK) | CODEGEN_USED_REG_MASK);
    if (mask) {
        /* the original frame from BP-6: selected at 3 */
        u16 frame = scratch_mark();
        farptr selected = fp_add(scratch_alloc(6), 3);
        for (u16 entry = 2; entry < VARIABLE_TABLE_END; entry += 29) {
            if (VAR_W(entry, VAR_SCOPE_BLOCK) != root)
                continue;
            u16 score = REGISTER_VARIABLE_SCORE(entry, selected, mask);
            if (score)
                EXPLAIN("regvar_candidate var=%s score=%u reg=%s", explain_symbol(VAR_W(entry, VAR_SYMBOL)),
                        score, explain_register((u16)SB(selected)));
            if (W(best) < score) {
                W(symbol) = entry;
                W(node) = root;
                W(best) = score;
                B(flag) = B(selected);
            }
        }
        scratch_release(frame);
    }
    for (root = CNODE_W(root, CNODE_SCOPE_CHILD); root; root = CNODE_W(root, CNODE_SCOPE_SIBLING))
        FIND_BEST_REGISTER_VARIABLE(root, best, symbol, node, flag);
}

/* ORs register mask flags into the register mask and own-register mask of scope node, its
   siblings and all their nested scopes */
void MARK_BLOCK_TREE_REGISTERS(u16 node, u16 flags)
{
    while (node) {
        CNODE_W(node, CNODE_SCOPE_REG_MASK) |= flags;
        CNODE_W(node, CNODE_SCOPE_OWN_REGS) |= flags;
        MARK_BLOCK_TREE_REGISTERS(CNODE_W(node, CNODE_SCOPE_CHILD), flags);
        node = CNODE_W(node, CNODE_SCOPE_SIBLING);
    }
}

/* the number of the lowest set bit of value (which must not be 0), the first register in a
   register mask */
i16 LOWEST_SET_BIT_INDEX(u16 value)
{
    i8 index = 0;
    for (u16 bit = 1; (bit & value) == 0; bit <<= 1)
        index++;
    return index;
}

/* the benefit of keeping variable entry symbol in one of the registers in mask; 0 means not
   a candidate.  Sets *flag to the register chosen.  Not candidates: entries already in a
   register, forced to memory or flagged 80h, an entry with flag 1 that repeats the previous
   entry's symbol, and types other than char, short, int, near or _seg pointer, enum.  Chars
   need a byte register and prefer CX when used as a shift count.  Word variables prefer
   BX/SI/DI when used as addresses, the ES class when used more often as a segment, and never
   take the ES class otherwise.  The score is the use count plus the weights that fit the
   register chosen, +8000h for a variable declared register, +2 when its preferred register
   is free; minus 1 for an auto, or 2 for a parameter without a preferred register */
u16 REGISTER_VARIABLE_SCORE(u16 symbol, farptr flag, u16 mask)
{
    if (!symbol)
        return 0;
    if (VAR_B(symbol, VAR_FLAGS) & 0x86)
        return 0;
    if ((VAR_B(symbol, VAR_FLAGS) & 1) && symbol > 2 && VAR_W(symbol, VAR_SYMBOL) == VAR_W(symbol - 29, VAR_SYMBOL))
        return 0;
    mask &= (u16)~VAR_W(symbol, VAR_EXCLUDED_REGS);
    if (!mask)
        return 0;
    switch (VAR_B(symbol, VAR_TYPE_KIND)) {
    case 1:
    case 2:
        if (((u16)BYTE_REGISTERS_MASK() & mask) == 0)
            return 0;
        if (VAR_W(symbol, VAR_SHIFT_COUNT_USES) && (REG_MASK_CX & mask))
            mask &= REG_MASK_CX;
        SB(flag) = (i8)LOWEST_SET_BIT_INDEX(mask);
        break;
    case 3: case 4: case 5: case 6: case 13: case 14: case 21:
        if (VAR_W(symbol, VAR_INDEX_WEIGHT) && (REG_MASK_BX_SI_DI & mask)) {
            if (VAR_W(symbol, VAR_ES_CLASS_WEIGHT) > VAR_W(symbol, VAR_INDEX_WEIGHT) && (REG_MASK_ES & mask))
                mask &= REG_MASK_ES;
            else
                mask &= REG_MASK_BX_SI_DI;
        } else if (VAR_W(symbol, VAR_ES_CLASS_WEIGHT) && (REG_MASK_ES & mask))
            mask &= REG_MASK_ES;
        if (VAR_W(symbol, VAR_ES_CLASS_WEIGHT) == 0)
            mask &= (u16)~REG_MASK_ES;
        if (!mask)
            return 0;
        SB(flag) = (i8)LOWEST_SET_BIT_INDEX(mask);
        break;
    default:
        return 0;
    }
    u16 total;
    if (VAR_B(symbol, VAR_FLAGS) & 8)
        total = 0x8000;
    else if (MASK_BIT(VAR_B(symbol, VAR_PREFERRED_REG)) & mask) {
        total = 2;
        SB(flag) = (i8)VAR_B(symbol, VAR_PREFERRED_REG);
    } else
        total = 0;
    total += VAR_W(symbol, VAR_USE_COUNT);
    u16 bit = MASK_BIT(SB(flag));
    if (REG_MASK_BX_SI_DI & bit)
        total += VAR_W(symbol, VAR_INDEX_WEIGHT);
    if (REG_MASK_ES & bit)
        total += VAR_W(symbol, VAR_ES_CLASS_WEIGHT);
    if (REG_MASK_CX & bit)
        total += VAR_W(symbol, VAR_SHIFT_COUNT_USES);
    u16 adjustment = VAR_B(symbol, VAR_SYMBOL_KIND) == 6 ? (VAR_B(symbol, VAR_PREFERRED_REG) ? 0 : 2) : 1;
    if (total < adjustment)
        return 0;
    return (u16)(total - adjustment);
}

/* the variable-table entry of front-end symbol name, created on first use, or a new unnamed
   temporary of type kind kind when name is 0 (owned by the outermost scope, symbol kind 5).
   A new named entry records the symbol's type, type kind, segment, symbol kind (3/4 global,
   5 auto, 6 parameter) and the current scope.  flags: 8 declared register, 2 and 10h set
   VAR_FLAGS 80h and 1.  Globals, every non-register variable under OPTION_REGISTER_VARS 2,
   and parameters under calling convention 4 stay in memory (4) */
u16 FIND_OR_ADD_VARIABLE(u16 name, u8 kind, u8 flags)
{
    if (name) {
        u16 entry = (u16)CALL_FAR(GET_SYMBOL_VARIABLE_HOOK, A16(name));
        if (entry)
            return entry;
    }
    u16 entry = POOL_ALLOC(VARIABLE_TABLE_SEG_P, 29);
    RTL_MEMSET(MK_FP(VARIABLE_TABLE_SEG, entry), 0, 29);
    VAR_W(entry, VAR_SYMBOL) = name;
    VAR_B(entry, VAR_PREFERRED_REG) = 0xFF;
    if (!name) {
        VAR_W(entry, VAR_SCOPE_BLOCK) = FUNCTION_OUTER_SCOPE_BLOCK;
        VAR_B(entry, VAR_TYPE_KIND) = kind;
        VAR_B(entry, VAR_SYMBOL_KIND) = 5;
        return entry;
    }
    CALL_FAR(SET_SYMBOL_VARIABLE_HOOK, A16(name), A16(entry));
    u16 type = (u16)CALL_FAR(TYPE_HOOK, A16(name));
    VAR_W(entry, VAR_TYPE) = type;
    u8 type_kind = (u8)CALL_FAR(GET_TYPE_KIND_HOOK, A16(VAR_W(entry, VAR_TYPE)));
    VAR_B(entry, VAR_TYPE_KIND) = type_kind;
    u16 segment = (u16)CALL_FAR(GET_SYMBOL_SEGMENT_HOOK, A16(name));
    VAR_W(entry, VAR_SEGMENT) = segment;
    i16 category = (i16)CALL_FAR(GET_SYMBOL_KIND_HOOK, A16(name));
    VAR_B(entry, VAR_SYMBOL_KIND) = (u8)category;
    VAR_W(entry, VAR_SCOPE_BLOCK) = CURRENT_SCOPE_BLOCK;
    if (category == 6 && CODEGEN_CALL_CONV == 4)
        VAR_B(entry, VAR_FLAGS) = 4;
    else if (flags & 8)
        VAR_B(entry, VAR_FLAGS) = 8;
    else if (OPTION_REGISTER_VARS == 2 || (category != 6 && category != 5))
        VAR_B(entry, VAR_FLAGS) = 4;
    if (flags & 2)
        VAR_B(entry, VAR_FLAGS) |= 0x80;
    if (flags & 0x10)
        VAR_B(entry, VAR_FLAGS) |= 1;
    if (category != 5)
        VAR_B(entry, VAR_FLAGS) |= 0x20;
    return entry;
}

/* clears the symbol-to-entry links of all entries, empties the variable table and resets
   the temporary pool */
void RELEASE_VARIABLE_TABLE(void)
{
    for (u16 entry = 2; entry < VARIABLE_TABLE_END; entry += 29)
        if (VAR_W(entry, VAR_SYMBOL))
            CALL_FAR(SET_SYMBOL_VARIABLE_HOOK, A16(VAR_W(entry, VAR_SYMBOL)), A16(0));
    VARIABLE_TABLE_FREE_LIST = 0;
    VARIABLE_TABLE_END = 2;
    RESET_TEMP_POOL();
}
