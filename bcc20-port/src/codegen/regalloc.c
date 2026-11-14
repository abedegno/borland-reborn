/* regalloc.c: from bcc20/src/codegen/REGALLOC.C (overlay CO061): the register allocator,
   run once per function by GENERATE_FUNCTION_CODE after register variables are chosen.  It
   is a local allocator: it walks each code and switch block's ops in order and gives every
   op whose result is used a register (COP_REGISTER) from the class its CODE_OP_INFO_TABLE
   entry allows.  It never rewrites the ops: when a value must move it appends register
   history entries (RECORD_REGISTER_MOVE: 1 push, 2 pop, 3 move, 6 exchange; 4/5 come from
   SAVEREGS.C for the 8087), which the emitter replays.
   Register classes are indexes into REG_CLASS_MASK_TABLE (allowed registers) and
   REG_CLASS_IS_WORD; an op's wanted class is COP_REG_CLASS (low 6 bits), first filled
   backwards from its users by COLLECT_REGISTER_HINTS.  The table entry gives the operand
   classes (left, right), the result class and the set of registers the op destroys
   (REGISTER_MASK_TABLE).  Values computed but not yet used are live: LIVE_VALUE_POOL_SEG
   holds 4-byte entries (op, remaining uses) up to LIVE_VALUE_END; those below
   LIVE_VALUE_SPILL_END were pushed to free their register and are popped back in reverse
   order.  ALLOCATABLE_REGISTER_MASK is the set free right now, BLOCK_FREE_REGISTER_MASK the
   set the current scope allows; CLAIM_REGISTERS takes registers and records them in
   BLOCK_CLAIMED_REG_MASK, FUNCTION_CLAIMED_REG_MASK and the scope masks.  Before each op,
   the registers its operands must be in are pending requests (PENDING_REQUESTS at DS:8724,
   12-byte entries); RESOLVE_PENDING_REGISTERS satisfies them with moves, exchanges and
   pops.  When no register is free, SPILL_REGISTER pushes the oldest live value.  Special
   ops: 2 carries a value to the join of a ?: (the second arm's op 2 names the first arm's
   as the register to use), 3 is the joined value, 5 and 6 carry a mask of registers that
   must be free.  Running out of registers or leaving values live at the end is fatal
   (MSG_REGISTER_ALLOCATION).
   Shifts of 1 by a register number use the count mod 32, as the 80186 does, so a missing
   register (FFh) gives an empty mask. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define BIT(n) ((u16)(1u << ((n) & 31)))
#define OP_FLAGS(op) D(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19))
/* byte n of an op's descriptor (the table entry seen 3 bytes earlier): 7 operand size, 9
   left operand class, 10 right operand class, 0Bh result class, 0Ch destroyed registers */
#define DESC(op, n) B(fp_add(CODE_OP_INFO_TABLE_P, (op) * 19 + (n) - 3))
#define CLASS_MASK(c) REG_CLASS_MASK_TABLE_AT(c)
#define CLASS_IS_WORD(c) B(fp_add(REG_CLASS_IS_WORD_P, (i16)(c)))

/* a pending request: node at 0, reg 2, previous 3, mode 4, other 5, mask 6, other_mask 8,
   references 10 */
#define REQ(i) (FP_OFF(PENDING_REQUESTS_P) + (i) * 12)
#define REQ_NODE(e) W(DSPTR(e))
#define REQ_REG(e) SB(DSPTR((e) + 2))
#define REQ_PREVIOUS(e) B(DSPTR((e) + 3))
#define REQ_MODE(e) SB(DSPTR((e) + 4))
#define REQ_OTHER(e) SB(DSPTR((e) + 5))
#define REQ_MASK(e) W(DSPTR((e) + 6))
#define REQ_OTHER_MASK(e) W(DSPTR((e) + 8))
#define REQ_REFERENCES(e) SW(DSPTR((e) + 10))

#define SLOT(r) LVAL_W((r), LVAL_OP)

static void fatal(void) { REPORT_FATAL(MSG_REGISTER_ALLOCATION); }

/* takes the live entry at offset off the live list */
static void remove_live(u16 offset)
{
    LIVE_VALUE_END -= 4;
    RTL_MEMMOVE(MK_FP(LIVE_VALUE_POOL_SEG, offset), MK_FP(LIVE_VALUE_POOL_SEG, offset + 4),
                LIVE_VALUE_END - offset);
    LIVE_VALUE_POOL_FREE_LIST = 0;
    LIVE_VALUE_POOL_USED = LIVE_VALUE_END;
}

/* the registers the current scope allows become free */
static void set_scope_registers(u16 mask)
{
    ALLOCATABLE_REGISTER_MASK = mask;
    BLOCK_FREE_REGISTER_MASK = mask;
}

/* allocates registers for the current function: empties the history and live-value
   pools, collects register hints over the blocks from last to first, then walks the blocks
   from first to last: each block's CNODE_HISTORY is set to where its history entries
   start; scope entry and exit blocks change the registers allowed; code and switch blocks
   are allocated.  The parameter is not used */
void ALLOCATE_REGISTERS(u16 unused)
{
    (void)unused;
    HISTORY_END_OFFSET = 0;
    REG_HISTORY_POOL_FREE_LIST = 0;
    LIVE_VALUE_POOL_USED = 0;
    LIVE_VALUE_POOL_FREE_LIST = 0;
    for (u16 node = CODE_BLOCK_LIST_TAIL; node; node = CNODE_W(node, CNODE_PREV))
        switch (CNODE_W(node, CNODE_KIND)) {
        case 0:
        case 4:
            COLLECT_REGISTER_HINTS(node);
        }
    LIVE_VALUE_SPILL_END = 0;
    LIVE_VALUE_END = 0;
    set_scope_registers((u16)ALL_REGISTERS_MASK());
    for (u16 node = CODE_BLOCK_LIST_HEAD; node; node = CNODE_W(node, CNODE_NEXT)) {
        CNODE_W(node, CNODE_HISTORY) = HISTORY_END_OFFSET;
        switch (CNODE_W(node, CNODE_KIND)) {
        case 1:
            REGALLOC_SCOPE_NODE = node;
            set_scope_registers(BLOCK_FREE_REGISTERS(REGALLOC_SCOPE_NODE));
            break;
        case 2:
            REGALLOC_SCOPE_NODE = CNODE_W(REGALLOC_SCOPE_NODE, CNODE_SCOPE_PARENT);
            set_scope_registers(BLOCK_FREE_REGISTERS(REGALLOC_SCOPE_NODE));
            break;
        case 0:
        case 4:
            ALLOCATE_BLOCK_REGISTERS(node);
            break;
        }
    }
    if (LIVE_VALUE_END)
        fatal();
}

/* true when the operand tree of op node reads a register variable living in exactly the
   register mask (a one-bit mask).  Constants and raw-word ops (table flags 8, 20h) stop
   the search */
i16 TREE_USES_REGISTER_MASK(u16 mask, u16 node)
{
    u16 offset = node * 4;
    u32 flags = OP_FLAGS(COP_B(offset, COP_OPCODE));
    if (node == 0)
        return 0;
    if (flags & 1) {
        u16 variable = OPND_W(offset, OPND_LEFT);
        if (VAR_B(variable, VAR_FLAGS) & 2)
            return BIT(VAR_B(variable, VAR_REGISTER)) == mask;
        return 0;
    }
    if (flags & 0x28)
        return 0;
    return TREE_USES_REGISTER_MASK(mask, OPND_W(offset, OPND_LEFT)) ||
           TREE_USES_REGISTER_MASK(mask, OPND_W(offset, OPND_RIGHT));
}

/* walks block node's ops backwards and passes register class wishes down to the operand
   ops: from the operand classes in the table (REFINE_KIND_10_OPERAND for ops with a folded
   operand), from ?: join ops 3 and carry ops 2 to their values, and, for ops that leave
   their result in their left operand's register (table flag 100h), the op's own wanted
   class to its left operand, unless the right operand needs that register or the class
   does not fit */
void COLLECT_REGISTER_HINTS(u16 node)
{
    u16 count = CNODE_W(node, CNODE_OP_COUNT);
    u16 slot = (CNODE_W(node, CNODE_FIRST_OP) + count - 1) * 4;
    for (; count; --count, slot -= 4) {
        if (COP_B(slot, COP_FLAGS) & 0x40)
            continue;
        u8 op = COP_B(slot, COP_OPCODE);
        u32 flags = OP_FLAGS(op);
        if (flags & 0x29)
            continue;
        if (op == 3) {
            u16 available = (u16)OP3_REGISTER_HINT((i16)count, COP_B(slot, COP_REG_CLASS));
            NARROW_REGISTER_HINT(OPND_W(slot, OPND_RIGHT) * 4, available);
            NARROW_REGISTER_HINT(OPND_W(slot, OPND_LEFT) * 4, available);
            continue;
        }
        if (op == 2) {
            NARROW_REGISTER_HINT(OPND_W(slot, OPND_LEFT) * 4, COP_B(slot, COP_REG_CLASS));
            continue;
        }
        if (COP_B(slot, COP_FLAGS) & 1) {
            if (OPND_W(slot, OPND_LEFT)) {
                u16 left = OPND_W(slot, OPND_LEFT) * 4;
                if ((COP_B(left, COP_FLAGS) & 1) == 0)
                    NARROW_REGISTER_HINT(left, REFINE_KIND_10_OPERAND(DESC(op, 9), OPND_W(slot, OPND_RIGHT)));
            }
            if (OPND_W(slot, OPND_RIGHT) == 0)
                continue;
            u16 right = OPND_W(slot, OPND_RIGHT) * 4;
            if (COP_B(right, COP_FLAGS) & 1)
                continue;
            NARROW_REGISTER_HINT(right, REFINE_KIND_10_OPERAND(DESC(op, 10), OPND_W(slot, OPND_LEFT)));
            continue;
        }
        if (OPND_W(slot, OPND_RIGHT)) {
            u16 right = OPND_W(slot, OPND_RIGHT) * 4;
            if ((COP_B(right, COP_FLAGS) & 1) == 0)
                NARROW_REGISTER_HINT(right, DESC(op, 10));
        }
        if (OPND_W(slot, OPND_LEFT) == 0)
            continue;
        u16 left = OPND_W(slot, OPND_LEFT) * 4;
        if (COP_B(left, COP_FLAGS) & 1)
            continue;
        NARROW_REGISTER_HINT(left, DESC(op, 9));
        if ((flags & 0x100) == 0)
            continue;
        u16 old = CLASS_MASK(COP_B(left, COP_REG_CLASS));
        u16 mask = CLASS_MASK(COP_B(slot, COP_REG_CLASS));
        if ((mask & REG_MASK_HIGH_BYTES) && (OP_FLAGS(COP_B(left, COP_OPCODE)) & 1)) {
            u16 variable = OPND_W(left, OPND_LEFT);
            if ((VAR_B(variable, VAR_FLAGS) & 2) && (REG_MASK_LOW_BYTES & BIT(VAR_B(variable, VAR_REGISTER))) == 0)
                continue;
        }
        if (IS_MARKED_MEM_OPERAND(mask, OPND_W(slot, OPND_RIGHT)) || mask == 0 || (old & mask) != mask)
            continue;
        if (OPND_W(slot, OPND_LEFT) <= OPND_W(slot, OPND_RIGHT) &&
            TREE_USES_REGISTER_MASK(mask, OPND_W(slot, OPND_RIGHT)))
            continue;
        NARROW_REGISTER_HINT(left, COP_B(slot, COP_REG_CLASS));
    }
}

/* sets op record record's wanted class to class when it has none yet, or when class
   allows a subset of its current class of the same width */
void NARROW_REGISTER_HINT(u16 record, u16 class)
{
    u8 current = COP_B(record, COP_REG_CLASS);
    if (current != 0) {
        u16 mask = CLASS_MASK(class);
        if ((mask & CLASS_MASK(current)) != mask)
            return;
        if (CLASS_IS_WORD(current) != CLASS_IS_WORD(class))
            return;
    }
    COP_B(record, COP_REG_CLASS) = (u8)class;
}

/* allocates the ops of block node in order (CURRENT_INSN_INDEX is the op number, so
   history entries land before the right op).  For each live op: operand requests are
   resolved; 8087 ops only update the 8087 stack model; registers the op destroys are
   freed; ops whose result is unused only handle their side effects; ops whose result is
   used get a register: a specific high byte when the wanted class is one, the operand's
   register for table flag 100h ops when allowed, else PICK_FREE_REGISTER.  A result with
   uses ahead becomes a live value.  At the end of a block marked CNODE_FLAGS 8 the next
   block's first op requests are resolved here, so values can flow into it.  Register copies
   and long-pair reads use their operands' values one more time, so the live values they
   read get an extra expected use first */
void ALLOCATE_BLOCK_REGISTERS(u16 node)
{
    u16 count = CNODE_W(node, CNODE_OP_COUNT);
    CURRENT_INSN_INDEX = CNODE_W(node, CNODE_FIRST_OP);
    u16 cursor = CURRENT_INSN_INDEX * 4;
    BLOCK_CLAIMED_REG_MASK = 0;
    for (; count; --count, cursor += 4, ++CURRENT_INSN_INDEX) {
        u8 op = COP_B(cursor, COP_OPCODE);
        u32 flags = OP_FLAGS(op);
        if (IS_OP_97_98_OR_LONG_PAIR(cursor)) {
            COUNT_REGISTER_USES(OPND_W(cursor, OPND_LEFT));
            COUNT_REGISTER_USES(OPND_W(cursor, OPND_RIGHT));
        }
        if (COP_B(cursor, COP_FLAGS) & 0x41)
            continue;
        PENDING_RESULT_REGISTER = -1;
        if ((flags & 0x29) == 0 && !(COP_B(cursor, COP_OPCODE) == 2 && OPND_W(cursor, OPND_RIGHT))) {
            if (count <= 1 || !IS_LONG_MEM_PAIR(cursor))
                RESOLVE_PENDING_REGISTERS(CURRENT_INSN_INDEX, 0);
            else
                RESOLVE_PENDING_REGISTERS(CURRENT_INSN_INDEX, 1);
        }
        if (flags & 2) {
            COP_B(cursor, COP_REGISTER) = 0xFF;
            if ((flags & 1) == 0)
                POP_EVAL_STACK_OPERANDS(cursor, CURRENT_INSN_INDEX);
            if ((COP_B(cursor, COP_FLAGS) & 9) == 8)
                PUSH_EVAL_STACK(CURRENT_INSN_INDEX);
            continue;
        }
        if (DESC(op, 0x0C))
            ENSURE_REGISTERS_FREE(REGISTER_MASK_TABLE_AT(DESC(op, 0x0C)));
        else if (COP_B(cursor, COP_OPCODE) == 5)
            ENSURE_REGISTERS_FREE(OPND_W(cursor, OPND_LEFT));
        else if ((flags & 0x401) == 0x401)
            ENSURE_REGISTERS_FREE(OPND_W(cursor, OPND_RIGHT));
        if ((COP_B(cursor, COP_FLAGS) & 8) == 0) {
            if (COP_B(cursor, COP_OPCODE) == 6) {
                /* op 6 with an unused result: spill until every register in its mask is
                   free, and spill the 8087 stack */
                while (LIVE_VALUE_SPILL_END < LIVE_VALUE_END &&
                       (ALLOCATABLE_REGISTER_MASK & OPND_W(cursor, OPND_LEFT)) != OPND_W(cursor, OPND_LEFT))
                    SPILL_REGISTER();
                SPILL_EVAL_STACK_TO_TEMPS(CURRENT_INSN_INDEX);
                continue;
            }
            if (COP_B(cursor, COP_OPCODE) == 3) {
                POP_EVAL_STACK_OPERANDS(cursor, CURRENT_INSN_INDEX);
                continue;
            }
            if (flags & 0x100) {
                u16 temp = BIT(PENDING_RESULT_REGISTER);
                CLAIM_REGISTERS(temp);
                ALLOCATABLE_REGISTER_MASK |= temp & BLOCK_FREE_REGISTER_MASK;
            }
            continue;
        }
        if (COP_B(cursor, COP_OPCODE) == 2) {
            /* a value carried to a ?: join: its register is the one of the value; in the
               second arm (right operand set) it must be the register the first arm's op 2
               got, so a move is recorded when they differ */
            u8 previous = 0;
            u16 mask = 0;
            if (OPND_W(cursor, OPND_RIGHT)) {
                previous = COP_B(OPND_W(cursor, OPND_RIGHT) << 2, COP_REGISTER);
                u16 right = OPND_W(cursor, OPND_LEFT) * 4;
                u8 class = (u8)REGISTER_HINT_CODE((i8)previous, DESC(COP_B(right, COP_OPCODE), 7));
                COP_B(cursor, COP_REG_CLASS) = class;
                COP_B(right, COP_REG_CLASS) = class;
                mask = BIT(previous);
            }
            RESOLVE_PENDING_REGISTERS(CURRENT_INSN_INDEX, 0);
            if (OPND_W(cursor, OPND_RIGHT) == 0)
                POP_EVAL_STACK_OPERANDS(cursor, CURRENT_INSN_INDEX);
            u8 reg = FIND_VALUE_REGISTER(OPND_W(cursor, OPND_LEFT));
            COP_B(cursor, COP_REGISTER) = reg;
            if (OPND_W(cursor, OPND_RIGHT) == 0 || COP_B(cursor, COP_REGISTER) == previous)
                continue;
            reg = PICK_FREE_REGISTER(mask, mask);
            COP_B(cursor, COP_REGISTER) = reg;
            RECORD_REGISTER_MOVE(3, CLASS_IS_WORD(DESC(op, 0x0B)), COP_B(cursor, COP_REGISTER),
                                 OPND_W(cursor, OPND_LEFT), 0);
            continue;
        }
        if (COP_B(cursor, COP_OPCODE) == 3) {
            /* the joined value: takes the register of the first arm's op 2, unless the
               value is an 8087 value */
            u16 right = cursor;
            do {
                right = OPND_W(right, OPND_LEFT) * 4;
                right = OPND_W(right, OPND_LEFT) * 4;
            } while (COP_B(right, COP_OPCODE) == 3);
            if (OP_FLAGS(COP_B(right, COP_OPCODE)) & 2)
                continue;
            COP_B(cursor, COP_REGISTER) = COP_B(OPND_W(cursor, OPND_LEFT) << 2, COP_REGISTER);
            goto emit;
        }
        if (COP_B(cursor, COP_OPCODE) == 0x1B && (COP_B(cursor, COP_REG_CLASS) & 0x3F) == 0x15 &&
            OPND_W(cursor, OPND_RIGHT) && (ALLOCATABLE_REGISTER_MASK & 0x1000) == 0) {
            /* the high word of an indirect long read with class 15h (probably ES) while ES
               is taken: any register of the op's result class */
            u16 allowed = CLASS_MASK(DESC(op, 0x0B));
            u8 reg = PICK_FREE_REGISTER(allowed, allowed);
            COP_B(cursor, COP_REGISTER) = reg;
            goto emit;
        }
        if (DESC(op, 0x0B) == 0)
            continue;
        {
            u16 allowed = CLASS_MASK(DESC(op, 0x0B));
            u16 mask = (COP_B(cursor, COP_REG_CLASS) & 0x3F) ? CLASS_MASK(COP_B(cursor, COP_REG_CLASS) & 0x3F)
                                                             : allowed;
            if ((mask & REG_MASK_HIGH_BYTES) == mask && (mask & allowed)) {
                COP_B(cursor, COP_REGISTER) = (u8)((COP_B(cursor, COP_REG_CLASS) & 0x3F) - 1);
                continue;
            }
            u8 reg;
            if ((flags & 0x100) && (allowed & BIT(PENDING_RESULT_REGISTER)))
                reg = (u8)PENDING_RESULT_REGISTER;
            else
                reg = PICK_FREE_REGISTER(mask, allowed);
            COP_B(cursor, COP_REGISTER) = reg;
        }
emit:
        ADD_LIVE_VALUE(CURRENT_INSN_INDEX, COP_B(cursor, COP_REGISTER));
    }
    if (CNODE_W(node, CNODE_FLAGS) & 8)
        RESOLVE_PENDING_NEXT_BLOCK(node);
}

/* spills live values until all registers in flags are free, then marks them used for the
   scope chain without taking them out of the free set */
void ENSURE_REGISTERS_FREE(u16 flags)
{
    while (LIVE_VALUE_SPILL_END < LIVE_VALUE_END && (ALLOCATABLE_REGISTER_MASK & flags) != flags)
        SPILL_REGISTER();
    u16 saved = ALLOCATABLE_REGISTER_MASK;
    CLAIM_REGISTERS(flags);
    ALLOCATABLE_REGISTER_MASK = saved;
}

/* the register of op value, or FFh when there is none or the op is folded into its
   parent's operand */
u8 GET_ASSIGNED_REGISTER(u16 value)
{
    if (value == 0)
        return 0xFF;
    u16 index = value << 2;
    if (COP_B(index, COP_FLAGS) & 1)
        return 0xFF;
    return COP_B(index, COP_REGISTER);
}

/* gets the operands of op node into the registers its instruction needs (flags is passed
   to ADD_NODE_REGISTER_REQUESTS).  The requests are collected first; spilled values are
   popped back; values in a wrong register are moved when the right one is free, otherwise
   two values swap places with an exchange (action 6).  Finally each request's value is
   released when this was its last use or stays live when more uses follow, and
   PENDING_RESULT_REGISTER notes the register of the op's left operand */
void RESOLVE_PENDING_REGISTERS(u16 node, u16 flags)
{
    u16 index = node * 4;
    PENDING_REQUEST_COUNT = 0;
    RESOLVED_REQUEST_COUNT = 0;
    PENDING_REGISTER_MASK = 0;
    SPILLED_REQUEST_COUNT = 0;
    ADD_NODE_REGISTER_REQUESTS(node, flags);
    if (PENDING_REQUEST_COUNT == 0)
        return;
    if (RESOLVED_REQUEST_COUNT == PENDING_REQUEST_COUNT)
        goto finalize;
    if (PENDING_REQUEST_COUNT == 1) {
        u16 p = REQ(0);
        REQ_REG(p) = (i8)ACQUIRE_VALUE_REGISTER(REQ_NODE(p), (u16)(i16)REQ_OTHER(p));
        goto finalize;
    }
    if (SPILLED_REQUEST_COUNT >= PENDING_REQUEST_COUNT) {
        for (i16 i = 0; i < PENDING_REQUEST_COUNT; i++) {
            u16 p = REQ(i);
            REQ_REG(p) = (i8)ACQUIRE_VALUE_REGISTER(REQ_NODE(p), (u16)(i16)REQ_OTHER(p));
        }
        goto finalize;
    }
    for (;;) {
        int changed = 0;
        for (i16 i = 0; i < PENDING_REQUEST_COUNT; i++) {
            u16 p = REQ(i);
            if (REQ_REG(p) == -1)
                continue;
            if ((BIT(REQ_REG(p)) & REQ_MASK(p)) == 0 && (REQ_MASK(p) & PENDING_REGISTER_MASK) == 0) {
                REQ_REG(p) = (i8)ACQUIRE_VALUE_REGISTER(REQ_NODE(p), (u16)(i16)REQ_OTHER(p));
                REQ_MASK(p) = BIT(REQ_REG(p));
                RESOLVED_REQUEST_COUNT++;
                changed = 1;
            }
        }
        if (RESOLVED_REQUEST_COUNT == PENDING_REQUEST_COUNT - SPILLED_REQUEST_COUNT)
            break;
        if (changed)
            continue;
        for (i16 i = 0; i < PENDING_REQUEST_COUNT; i++) {
            u16 p = REQ(i);
            if (BIT(REQ_REG(p)) & REQ_MASK(p))
                continue;
            i16 j = 0;
            u16 q = REQ(0);
            for (; (BIT(REQ_REG(p)) & REQ_MASK(q)) == 0 && j < PENDING_REQUEST_COUNT; q += 12, j++)
                ;
            if (j < PENDING_REQUEST_COUNT) {
                RECORD_REGISTER_MOVE(6, 0, (u8)REQ_REG(q), REQ_NODE(p), REQ_NODE(q));
                i8 swap = REQ_REG(q);
                REQ_REG(q) = REQ_REG(p);
                REQ_REG(p) = swap;
                RESOLVED_REQUEST_COUNT++;
                if ((BIT(REQ_REG(q)) & REQ_MASK(q)) && (BIT(REQ_REG(p)) & REQ_MASK(q)) == 0)
                    RESOLVED_REQUEST_COUNT++;
            } else
                fatal();
            break;
        }
        if (RESOLVED_REQUEST_COUNT == PENDING_REQUEST_COUNT - SPILLED_REQUEST_COUNT)
            break;
    }
    for (i16 i = 0; i < PENDING_REQUEST_COUNT; i++) {
        u16 p = REQ(i);
        if (REQ_REG(p) == -1)
            REQ_REG(p) = (i8)ACQUIRE_VALUE_REGISTER(REQ_NODE(p), (u16)(i16)REQ_OTHER(p));
    }
finalize:
    for (u16 p = REQ(0); PENDING_REQUEST_COUNT; p += 12, --PENDING_REQUEST_COUNT) {
        if (REQ_REFERENCES(p) > 1)
            ADD_LIVE_VALUE(REQ_NODE(p), (u8)REQ_REG(p));
        else if (REQ_REFERENCES(p) && (BLOCK_FREE_REGISTER_MASK & BIT(REQ_REG(p))))
            ALLOCATABLE_REGISTER_MASK |= BIT(REQ_REG(p));
        if (OPND_W(index, OPND_LEFT) == REQ_NODE(p))
            PENDING_RESULT_REGISTER = REQ_REG(p);
    }
    PENDING_REGISTER_MASK = 0;
}

/* adds requests for the operands of op index: for a leaf only the leaf itself (when it
   has a register and is not folded); otherwise each operand with the operand class from
   the table (refined for folded operands).  Folded operands are searched recursively */
void ADD_NODE_REGISTER_REQUESTS(u16 index, u16 mode)
{
    u16 slot = index * 4;
    u8 op = COP_B(slot, COP_OPCODE);
    u32 flags = OP_FLAGS(op);
    if (flags & 0x20)
        return;
    if (flags & 9) {
        if (flags & 2)
            return;
        if ((COP_B(slot, COP_REG_CLASS) & 0x80) && mode == 0) {
            ADD_REGISTER_REQUEST(index, 0);
            return;
        }
        if (COP_B(slot, COP_FLAGS) & 1)
            return;
        ADD_REGISTER_REQUEST(index, 0);
        return;
    }
    u16 first, second;
    if (COP_B(slot, COP_FLAGS) & 1) {
        first = REFINE_KIND_10_OPERAND(DESC(op, 9), OPND_W(slot, OPND_RIGHT));
        second = REFINE_KIND_10_OPERAND(DESC(op, 10), OPND_W(slot, OPND_LEFT));
    } else {
        first = DESC(op, 9);
        second = DESC(op, 10);
    }
    ADD_OPERAND_REQUEST(OPND_W(slot, OPND_LEFT), mode, first);
    if (COP_B(slot, COP_OPCODE) != 2)
        ADD_OPERAND_REQUEST(OPND_W(slot, OPND_RIGHT), mode, second);
}

/* requests register class class for operand op operand, or looks inside it when it is
   folded; 8087 values need no CPU register */
void ADD_OPERAND_REQUEST(u16 operand, u16 mode, u16 class)
{
    if (!operand)
        return;
    u16 entry = operand << 2;
    if (COP_B(entry, COP_FLAGS) & 1) {
        ADD_NODE_REGISTER_REQUESTS(operand, mode);
        return;
    }
    if ((OP_FLAGS(COP_B(entry, COP_OPCODE)) & 2) == 0)
        ADD_REGISTER_REQUEST(operand, class);
}

/* the lowest free register in mask allowed, preferring those also in preferred that no
   pending request holds; spills live values until one is free */
u8 PICK_FREE_REGISTER(u16 preferred, u16 allowed)
{
    if (allowed & preferred) {
        u16 mask = allowed & preferred;
        if ((mask & PENDING_REGISTER_MASK) != mask && (BLOCK_FREE_REGISTER_MASK & mask))
            allowed = mask;
    }
    for (;;) {
        u8 position = 0;
        u16 bits = ALLOCATABLE_REGISTER_MASK & allowed;
        if (bits)
            for (u16 mask = 1; mask; mask <<= 1, position++)
                if ((mask & bits) == mask)
                    return position;
        SPILL_REGISTER();
    }
}

/* frees the register of the oldest unspilled live value: normally by PUSHing it (action
   1) and moving LIVE_VALUE_SPILL_END past it; when the current op is itself a PUSH
   (93h/94h), which would upset the stack order, the value is moved to another free
   register instead */
void SPILL_REGISTER(void)
{
    u16 slot = LIVE_VALUE_SPILL_END;
    while (slot < LIVE_VALUE_END && SLOT(slot) == 0)
        slot += 4;
    if (slot >= LIVE_VALUE_END)
        fatal();
    u16 offset = CURRENT_INSN_INDEX * 4;
    if (COP_B(offset, COP_OPCODE) == 0x94 || COP_B(offset, COP_OPCODE) == 0x93) {
        if (ALLOCATABLE_REGISTER_MASK & BLOCK_FREE_REGISTER_MASK) {
            u8 selected = PICK_FREE_REGISTER(ALLOCATABLE_REGISTER_MASK, ALLOCATABLE_REGISTER_MASK);
            offset = LVAL_W(slot, LVAL_OP) * 4;
            u16 type = COP_B(offset, COP_REG_CLASS) & 0x3F;
            ALLOCATABLE_REGISTER_MASK |= BIT(FIND_VALUE_REGISTER(SLOT(slot))) & BLOCK_FREE_REGISTER_MASK;
            RECORD_REGISTER_MOVE(3, CLASS_IS_WORD(type), selected, SLOT(slot), 0);
            ALLOCATABLE_REGISTER_MASK &= ~BIT(selected);
        } else
            fatal();
    } else {
        ALLOCATABLE_REGISTER_MASK |= BIT(FIND_VALUE_REGISTER(SLOT(slot))) & BLOCK_FREE_REGISTER_MASK;
        RECORD_REGISTER_MOVE(1, 0, 0xFF, SLOT(slot), 0);
        LIVE_VALUE_SPILL_END = slot + 4;
    }
}

/* appends a history entry before the current op: action, word flag, target register,
   value op and partner op */
void RECORD_REGISTER_MOVE(u8 action, u8 is_word, u8 reg, u16 value, u16 partner)
{
    u16 entry = POOL_ALLOC(REG_HISTORY_POOL_SEG_P, 9);
    RHIST_B(entry, RHIST_ACTION) = action;
    RHIST_W(entry, RHIST_INSN_INDEX) = CURRENT_INSN_INDEX;
    RHIST_B(entry, RHIST_IS_WORD) = is_word;
    RHIST_B(entry, RHIST_REGISTER) = reg;
    RHIST_W(entry, RHIST_VALUE_OP) = value;
    RHIST_W(entry, RHIST_PARTNER) = partner;
}

/* the pending request for node, searched from the last one down, or 0 */
static u16 find_request(u16 node)
{
    if (PENDING_REQUEST_COUNT <= 0)
        return 0;
    for (u16 entry = REQ(PENDING_REQUEST_COUNT - 1);; entry -= 12) {
        if (REQ_NODE(entry) == node)
            return entry;
        if (entry == REQ(0))
            return 0;
    }
}

/* adds a request that value op node be in a register of class mode.  A value requested
   twice for the same op only counts one use less.  A live value is taken off the live
   list (its remaining uses go into the request); a spilled one is marked for reloading
   (reg FFh) */
void ADD_REGISTER_REQUEST(u16 node, u16 mode)
{
    i16 references = 0;
    u16 offset = 0;
    for (;; offset += 4) {
        if (offset >= LIVE_VALUE_END) {
            u16 entry = find_request(node);
            if (entry) {
                --REQ_REFERENCES(entry);
                return;
            }
            break;
        }
        if (LVAL_W(offset, LVAL_OP) == node) {
            u16 entry = find_request(node);
            if (entry) {
                --REQ_REFERENCES(entry);
                return;
            }
            references = (i16)LVAL_W(offset, LVAL_USE_COUNT);
            break;
        }
    }
    u16 entry = REQ(PENDING_REQUEST_COUNT);
    ++PENDING_REQUEST_COUNT;
    REQ_NODE(entry) = node;
    REQ_MASK(entry) = CLASS_MASK(mode);
    REQ_MODE(entry) = (i8)mode;
    u16 other = COP_B(node * 4, COP_REG_CLASS) & 0x3F;
    REQ_OTHER(entry) = (i8)other;
    REQ_OTHER_MASK(entry) = CLASS_MASK(other);
    REQ_REFERENCES(entry) = references;
    if (offset < LIVE_VALUE_SPILL_END) {
        REQ_PREVIOUS(entry) = 0xFF;
        REQ_REG(entry) = -1;
        SPILLED_REQUEST_COUNT++;
        return;
    }
    REQ_REG(entry) = (i8)FIND_VALUE_REGISTER(node);
    PENDING_REGISTER_MASK |= BIT(REQ_REG(entry));
    REQ_PREVIOUS(entry) = 0xFF;
    if (offset < LIVE_VALUE_END) {
        if (REQ_MASK(entry) & BIT(REQ_REG(entry)))
            RESOLVED_REQUEST_COUNT++;
        remove_live(offset);
    } else
        RESOLVED_REQUEST_COUNT++;
}

/* the register value op node will be read from, taking it off the live list: spilled
   values are popped back (with every value pushed after it, in reverse order); a value
   whose register does not fit its wanted class is moved to one that does (or to class
   hint) */
u8 ACQUIRE_VALUE_REGISTER(u16 node, u16 hint)
{
    u8 selected;
    for (u16 offset = LIVE_VALUE_END; offset;) {
        offset -= 4;
        if (SLOT(offset) != node)
            continue;
        if (offset < LIVE_VALUE_SPILL_END) {
            do {
                LIVE_VALUE_SPILL_END -= 4;
                u16 wanted = CLASS_MASK(COP_B(SLOT(LIVE_VALUE_SPILL_END) * 4, COP_REG_CLASS) & 0x3F);
                if (ALLOCATABLE_REGISTER_MASK & wanted)
                    selected = PICK_FREE_REGISTER(wanted, wanted);
                else
                    selected = FREE_REGISTER_FROM(wanted);
                RECORD_REGISTER_MOVE(2, 0, selected, SLOT(LIVE_VALUE_SPILL_END), 0);
                CLAIM_REGISTERS(BIT(selected));
            } while (offset < LIVE_VALUE_SPILL_END);
        } else
            selected = FIND_VALUE_REGISTER(node);
        remove_live(offset);
        return selected;
    }
    u16 index = node * 4;
    selected = FIND_VALUE_REGISTER(node);
    if (selected == 0xFF)
        return selected;
    u16 type = COP_B(index, COP_REG_CLASS) & 0x3F;
    u16 mask = CLASS_MASK(type);
    if ((BIT(selected) & mask) == 0 &&
        ((mask & ALLOCATABLE_REGISTER_MASK) != 0 || (BIT(selected) & CLASS_MASK(hint)) == 0)) {
        u8 replacement = PICK_FREE_REGISTER(mask, CLASS_MASK(hint));
        RECORD_REGISTER_MOVE(3, CLASS_IS_WORD(type), replacement, node, 0);
        ALLOCATABLE_REGISTER_MASK |= BIT(selected) & BLOCK_FREE_REGISTER_MASK;
        PENDING_REGISTER_MASK &= ~BIT(selected);
        PENDING_REGISTER_MASK |= BIT(replacement);
        CLAIM_REGISTERS(BIT(replacement));
        selected = replacement;
    }
    return selected;
}

/* frees one register of available by moving its live value or pending request elsewhere
   (first to a register of the value's own class, then to any free register), returning
   the freed register */
u8 FREE_REGISTER_FROM(u16 available)
{
    for (u16 slot = LIVE_VALUE_SPILL_END + 4; slot < LIVE_VALUE_END; slot += 4) {
        u16 node = LVAL_W(slot, LVAL_OP);
        u8 selected = FIND_VALUE_REGISTER(node);
        u16 type = COP_B(node * 4, COP_REG_CLASS) & 0x3F;
        u16 mask = CLASS_MASK(type);
        if ((BIT(selected) & available) && (mask & ALLOCATABLE_REGISTER_MASK)) {
            u8 replacement = PICK_FREE_REGISTER(mask, mask);
            RECORD_REGISTER_MOVE(3, CLASS_IS_WORD(type), replacement, node, 0);
            CLAIM_REGISTERS(BIT(replacement));
            ALLOCATABLE_REGISTER_MASK |= BIT(selected) & BLOCK_FREE_REGISTER_MASK;
            return selected;
        }
    }
    for (u16 slot = LIVE_VALUE_SPILL_END + 4; slot < LIVE_VALUE_END; slot += 4) {
        u16 node = LVAL_W(slot, LVAL_OP);
        u8 selected = FIND_VALUE_REGISTER(node);
        if (BIT(selected) & available) {
            u8 replacement = PICK_FREE_REGISTER(ALLOCATABLE_REGISTER_MASK, ALLOCATABLE_REGISTER_MASK);
            RECORD_REGISTER_MOVE(3, 1, replacement, node, 0);
            CLAIM_REGISTERS(BIT(replacement));
            ALLOCATABLE_REGISTER_MASK |= BIT(selected) & BLOCK_FREE_REGISTER_MASK;
            return selected;
        }
    }
    for (u16 e = REQ(PENDING_REQUEST_COUNT - 1); e >= REQ(0); e -= 12) {
        if ((BIT(REQ_REG(e)) & available) && (REQ_MASK(e) & ALLOCATABLE_REGISTER_MASK)) {
            u8 selected = (u8)REQ_REG(e);
            u8 replacement = PICK_FREE_REGISTER(REQ_MASK(e), REQ_MASK(e));
            RECORD_REGISTER_MOVE(3, CLASS_IS_WORD(REQ_MODE(e)), replacement, REQ_NODE(e), 0);
            CLAIM_REGISTERS(BIT(replacement));
            REQ_REG(e) = (i8)replacement;
            ALLOCATABLE_REGISTER_MASK |= BIT(selected) & BLOCK_FREE_REGISTER_MASK;
            return selected;
        }
    }
    for (u16 e = REQ(PENDING_REQUEST_COUNT - 1); e >= REQ(0); e -= 12) {
        if (BIT(REQ_REG(e)) & available) {
            u8 selected = (u8)REQ_REG(e);
            u8 replacement = PICK_FREE_REGISTER(ALLOCATABLE_REGISTER_MASK, ALLOCATABLE_REGISTER_MASK);
            RECORD_REGISTER_MOVE(3, CLASS_IS_WORD(REQ_MODE(e)), replacement, REQ_NODE(e), 0);
            CLAIM_REGISTERS(BIT(replacement));
            REQ_REG(e) = (i8)replacement;
            ALLOCATABLE_REGISTER_MASK |= BIT(selected) & BLOCK_FREE_REGISTER_MASK;
            return selected;
        }
    }
    fatal();
    return 0;
}

/* the register value op value is in now: the latest history entry that moved it
   (following exchanges), else its COP_REGISTER */
u8 FIND_VALUE_REGISTER(u16 value)
{
    for (u16 entry = HISTORY_END_OFFSET; entry;) {
        entry -= 9;
        if (RHIST_W(entry, RHIST_INSN_INDEX) < value)
            break;
        if (RHIST_W(entry, RHIST_VALUE_OP) == value) {
            if (RHIST_B(entry, RHIST_ACTION) == 6) {
                value = RHIST_W(entry, RHIST_PARTNER);
                continue;
            }
            return RHIST_B(entry, RHIST_REGISTER);
        }
        if (RHIST_B(entry, RHIST_ACTION) == 6 && RHIST_W(entry, RHIST_PARTNER) == value)
            value = RHIST_W(entry, RHIST_VALUE_OP);
    }
    return COP_B(value << 2, COP_REGISTER);
}

/* when values are still live at the end of block node, resolves the requests of the
   first op of the next non-empty block now, recording the moves with the negated op
   number so they are replayed at the end of node */
void RESOLVE_PENDING_NEXT_BLOCK(u16 node)
{
    if (LIVE_VALUE_END) {
        node = CNODE_W(node, CNODE_NEXT);
        if (CNODE_W(node, CNODE_OP_COUNT) == 0)
            node = CNODE_W(node, CNODE_NEXT);
        CURRENT_INSN_INDEX = (u16)-CURRENT_INSN_INDEX;
        RESOLVE_PENDING_REGISTERS(CNODE_W(node, CNODE_FIRST_OP), 0);
    }
}

/* takes the registers in flags out of the free set and records them as used in the
   block, the function and every scope from the current one outwards */
void CLAIM_REGISTERS(u16 flags)
{
    BLOCK_CLAIMED_REG_MASK |= flags;
    FUNCTION_CLAIMED_REG_MASK |= flags;
    ALLOCATABLE_REGISTER_MASK &= ~flags;
    for (u16 cursor = REGALLOC_SCOPE_NODE; cursor; cursor = CNODE_W(cursor, CNODE_SCOPE_PARENT))
        CNODE_W(cursor, CNODE_SCOPE_REG_MASK) |= flags;
}

/* op value now holds register reg with uses ahead: the register is claimed and the value
   appended to the live list */
void ADD_LIVE_VALUE(u16 value, u8 reg)
{
    CLAIM_REGISTERS(BIT(reg));
    u16 entry = POOL_ALLOC(LIVE_VALUE_POOL_SEG_P, 4);
    LVAL_W(entry, LVAL_OP) = value;
    LVAL_W(entry, LVAL_USE_COUNT) = 1;
    LIVE_VALUE_END = entry + 4;
}

/* the number of the highest set bit of value (FFh for 0) */
u8 HIGH_BIT_INDEX(u16 value)
{
    u8 result = 0xFF;
    for (; value != 0; value >>= 1)
        result++;
    return result;
}

/* adds one expected use to the live value of op node, or, for an op without a register,
   to the live values in its operand tree */
void COUNT_REGISTER_USES(u16 node)
{
    if (!node)
        return;
    u16 record = node * 4;
    if (COP_B(record, COP_REGISTER) != 0xFF) {
        for (u16 cursor = 0; cursor < LIVE_VALUE_END; cursor += 4)
            if (LVAL_W(cursor, LVAL_OP) == node) {
                ++LVAL_W(cursor, LVAL_USE_COUNT);
                break;
            }
    } else if ((OP_FLAGS(COP_B(record, COP_OPCODE)) & 0x29) == 0) {
        COUNT_REGISTER_USES(OPND_W(record, OPND_LEFT));
        COUNT_REGISTER_USES(OPND_W(record, OPND_RIGHT));
    }
}
