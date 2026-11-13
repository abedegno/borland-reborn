/* exprnod2.c: from bcc20/src/expr/EXPRNOD2.C: expression nodes for the back end's side
   (the _ALT and BCC_NODE_* copies of EXPRMAKE.C's functions): 20-byte records in
   EXPR_POOL_SEG (+0 operator, +2 type kind, +4 qualifier flags, +6 and +7 flag bytes, +8
   type, +10 and +12 operands or a long value), and the expansion of x op= y and x++ into
   forms the code generator takes, hoisting an address with side effects into a temporary. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define NW(node, field) W(MK_FP(EXPR_POOL_SEG, (node) + (field)))
#define NB(node, field) B(MK_FP(EXPR_POOL_SEG, (node) + (field)))
#define K(node) SW(MK_FP(EXPR_POOL_SEG, (node)))
#define EXPR_USED W(fp_add(EXPR_POOL_SEG_P, 4))
#define EXPR_EXTRA W(fp_add(EXPR_POOL_SEG_P, 6))

/* the type kind through the hook, which returns an unsigned char */
static u16 type_kind(u16 type) { return (u8)CALL_FAR(GET_TYPE_KIND_HOOK, A16(type)); }

static u16 new_node(void) { return POOL_ALLOC(EXPR_POOL_SEG_P, 20); }

/* empty the expression pool */
void BCC_NODE_RESET(void)
{
    EXPR_EXTRA = 0;
    EXPR_USED = 2;
}

/* a node with operator kind, type and operands; BCC_NODE_MODE also sets the qualifier
   flags word to mode */
static u16 node_with(i8 kind, u16 type, u16 left, u16 right, i8 mode)
{
    u16 node = new_node();
    NW(node, 8) = type;
    K(node) = kind;
    NW(node, 4) = (u16)(i16)mode;
    NB(node, 6) = 0;
    NB(node, 7) = 0;
    u16 kind_of = type ? type_kind(type) : 0;
    NW(node, 2) = kind_of;
    NW(node, 10) = left;
    NW(node, 12) = right;
    return node;
}

u16 BCC_NODE_BINARY(i8 kind, u16 type, u16 left, u16 right) { return node_with(kind, type, left, right, 0); }
u16 BCC_NODE_MODE(i8 kind, u16 type, u16 left, u16 right, i8 mode) { return node_with(kind, type, left, right, mode); }

/* an integer constant node (operator 2) */
u16 BCC_NODE_INTEGER(u16 type, i32 value)
{
    u16 node = new_node();
    NW(node, 8) = type;
    K(node) = 2;
    NW(node, 4) = 0;
    NB(node, 6) = 0;
    NB(node, 7) = 0;
    u16 kind_of = type ? type_kind(type) : 0;
    NW(node, 2) = kind_of;
    SD(MK_FP(EXPR_POOL_SEG, node + 10)) = value;
    return node;
}

/* a bitfield access node (operator 51) of left: first the width, second the shift */
u16 NEW_BITFIELD_NODE_ALT(u16 left, u16 type, u8 first, u8 second)
{
    u16 node = new_node();
    NW(node, 8) = type;
    K(node) = 51;
    u16 kind_of = type_kind(type);
    NW(node, 2) = kind_of;
    NW(node, 4) = 0;
    NB(node, 6) = 0;
    NB(node, 7) = 0;
    NW(node, 10) = left;
    NB(node, 12) = first;
    NB(node, 13) = second;
    return node;
}

/* 1 when the tree contains a call */
i16 BCC_NODE_TEST2(u16 node)
{
    if (!node || K(node) <= 7)
        return 0;
    if (K(node) == 51)
        return BCC_NODE_TEST2(NW(node, 10));
    if (K(node) == 54)
        return 1;
    return BCC_NODE_TEST2(NW(node, 10)) || BCC_NODE_TEST2(NW(node, 12));
}

/* a shallow copy of one node */
u16 BCC_NODE_COPY_NEAR(u16 node)
{
    u16 copy = new_node();
    for (int i = 0; i < 20; i++)
        NB(copy, i) = NB(node, i);
    return copy;
}

/* a copy of the tree with x++ and x-- replaced by x */
u16 BCC_NODE_REBUILD(u16 node)
{
    if (!node)
        return 0;
    node = BCC_NODE_COPY_NEAR(node);
    if (K(node) <= 7)
        return node;
    if (K(node) == 51) {
        u16 left = BCC_NODE_REBUILD(NW(node, 10));
        NW(node, 10) = left;
        return node;
    }
    if (K(node) == 35 || K(node) == 36)
        return BCC_NODE_REBUILD(NW(node, 10));
    u16 right = BCC_NODE_REBUILD(NW(node, 12));
    NW(node, 12) = right;
    u16 left = BCC_NODE_REBUILD(NW(node, 10));
    NW(node, 10) = left;
    return node;
}

/* a copy of the tree with each assignment replaced by its left side */
u16 BCC_NODE_CLONE(u16 node)
{
    if (!node)
        return 0;
    node = BCC_NODE_COPY_NEAR(node);
    if (K(node) <= 7)
        return node;
    if (K(node) == 51) {
        u16 left = BCC_NODE_CLONE(NW(node, 10));
        NW(node, 10) = left;
        return node;
    }
    if (K(node) >= 18 && K(node) <= 28)
        return BCC_NODE_CLONE(NW(node, 10));
    u16 right = BCC_NODE_CLONE(NW(node, 12));
    NW(node, 12) = right;
    u16 left = BCC_NODE_CLONE(NW(node, 10));
    NW(node, 10) = left;
    return node;
}

/* *p (or a bitfield of *p) into *(t = p), leaving the node reading *t */
u16 BCC_NODE_NORMALIZE(u16 node)
{
    u16 root = K(node) == 51 ? NW(node, 10) : node;
    u16 child = NW(root, 10);
    u16 classification = (u16)CALL_FAR(NEW_TEMPORARY_HOOK, A16(NW(child, 8)));
    u16 first = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(NW(child, 8)), A16(classification), A16(0), A16(0));
    u16 second = (u16)CALL_FAR(NEW_SYMBOL_NODE_HOOK, A16(5), A16(NW(child, 8)), A16(classification), A16(0), A16(0));
    NW(root, 10) = second;
    u16 binary = (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(18), A16(NW(child, 8)), A16(first), A16(child));
    u16 result = (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(49), A16(NW(root, 8)), A16(binary), A16(0));
    if (K(node) == 51)
        result = (u16)CALL_FAR(NEW_BITFIELD_NODE_HOOK, A16(result), A16(NW(node, 8)), A16(NB(node, 12)), A16(NB(node, 13)));
    return result;
}

/* x op= y into x = x op y (the operator code goes down by 11) */
u16 EXPAND_COMPOUND_ASSIGN_ALT(u16 node)
{
    u16 left = NW(node, 10);
    NW(node, 0) += (u16)-11;
    if (BCC_NODE_TEST2(left)) {
        u16 hoisted = BCC_NODE_NORMALIZE(left);
        NW(node, 10) = hoisted;
    } else {
        u16 rebuilt = BCC_NODE_REBUILD(left);
        NW(node, 10) = rebuilt;
        left = BCC_NODE_CLONE(left);
    }
    u16 type = NW(node, 8), clone = BCC_NODE_CLONE(left);
    return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(18), A16(type), A16(clone), A16(node));
}

/* x++ and x-- into sequence(old x, x += 1) (the operator code goes down by 16) */
u16 BCC_NODE_CONVERT(u16 node)
{
    u16 result, left = NW(node, 10);
    NW(node, 0) += (u16)-16;
    if (BCC_NODE_TEST2(left))
        result = BCC_NODE_NORMALIZE(left);
    else {
        result = BCC_NODE_REBUILD(left);
        u16 clone = BCC_NODE_CLONE(left);
        NW(node, 10) = clone;
    }
    return (u16)CALL_FAR(NEW_EXPR_NODE_HOOK, A16(41), A16(NW(node, 8)), A16(result), A16(node));
}

/* 1 when the tree has a side effect */
i16 TREE_HAS_SIDE_EFFECTS_ALT(u16 node)
{
    while (node) {
        switch (K(node)) {
        case 1: case 2: case 3: case 4: case 5: case 6: case 7:
            return 0;
        case 18: case 19: case 20: case 21: case 22: case 23: case 24:
        case 25: case 26: case 27: case 28: case 35: case 36: case 54:
            return 1;
        case 51:
            node = NW(node, 10);
            continue;
        default:
            if (NW(node, 12) && (i16)CALL_FAR(TREE_HAS_SIDE_EFFECTS_HOOK, A16(NW(node, 12))))
                return 1;
        }
        node = NW(node, 10);
    }
    return 0;
}
