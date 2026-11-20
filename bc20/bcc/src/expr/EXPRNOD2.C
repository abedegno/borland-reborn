/* target: ovr116_C58UNIT */
/* opts: -mm -G- -O -Z -p -Y */
/* Role: expressions: second set of expression-node constructors and rewriting of compound
   assignment and post-increment trees with temporaries; probably reached through back-end
   hooks. Entry points: BCC_NODE_RESET, BCC_NODE_BINARY, BCC_NODE_MODE, BCC_NODE_INTEGER,
   NEW_BITFIELD_NODE_ALT, EXPAND_COMPOUND_ASSIGN_ALT, BCC_NODE_CONVERT,
   TREE_HAS_SIDE_EFFECTS_ALT. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: a second copy, in another overlay (ovr116), of the C-mode node constructors
   and tree rewrites of expr/EXPRMAKE.C. The bodies match one for one; only the names
   differ, and several names here say little about what the code does:
     BCC_NODE_RESET     = RESET_EXPR_POOL       BCC_NODE_BINARY  = NEW_EXPR_NODE
     BCC_NODE_MODE      = NEW_EXPR_NODE_MODE    BCC_NODE_INTEGER = NEW_CONSTANT_EXPR
     NEW_BITFIELD_NODE_ALT = NEW_BITFIELD_NODE     EXPAND_COMPOUND_ASSIGN_ALT = EXPAND_COMPOUND_ASSIGN
     BCC_NODE_CONVERT   = EXPAND_POST_INC_DEC   BCC_NODE_TEST2   = EXPR_CONTAINS_CALL
     BCC_NODE_REBUILD   = COPY_TREE_SKIP_POSTINC
     BCC_NODE_CLONE     = COPY_TREE_SKIP_ASSIGNS
     BCC_NODE_COPY_NEAR = DUPLICATE_EXPR_NODE
     BCC_NODE_NORMALIZE = HOIST_LVALUE_ADDR_TO_TEMP
     TREE_HAS_SIDE_EFFECTS_ALT      = TREE_HAS_SIDE_EFFECTS
   See the comments in expr/EXPRMAKE.C for what each one does. The code here uses raw
   offsets through the local macros W, K, B, L: 0 operator (K), 2 value kind, 4 qualifier
   flags, 6 and 7 flag bytes, 8 type, 10 left operand (or the long constant value), 12
   right operand (for operator 51, the bitfield node, bytes 12 and 13 are width and
   shift). Operator numbers: 2 constant, 18 EOP_ASSIGN, 18..28 the assignments, 35/36
   EOP_POSTINC/EOP_POSTDEC, 41 (0x29) the sequence node, 49 EOP_DEREF, 51 bitfield, 54
   call. The Role line guesses these are reached through back-end hooks; that fits, as
   nothing in src/ calls the names directly. */
#include "EXPRNOD2.H"
#define W(node,field) (*(C58Word far *)MK_FP(EXPR_POOL_SEG.segment,(node)+(field)))
#define K(node) (*(int far *)MK_FP(EXPR_POOL_SEG.segment,(node)))
#define B(node,field) (*(C58Byte far *)MK_FP(EXPR_POOL_SEG.segment,(node)+(field)))
#define L(node,field) (*(long far *)MK_FP(EXPR_POOL_SEG.segment,(node)+(field)))
#define RECORD(node) (*(struct C58Record far *)MK_FP(EXPR_POOL_SEG.segment,(node)))

/* BCC_NODE_RESET: empties the expression pool (RESET_EXPR_POOL). */
void far pascal BCC_NODE_RESET(void)
{
    EXPR_POOL_SEG.extra=0;
    EXPR_POOL_SEG.used=2;
}

/* BCC_NODE_BINARY: node with operator kind, type and operands (NEW_EXPR_NODE). */
unsigned int far pascal BCC_NODE_BINARY(signed char kind,register unsigned int type,unsigned int left,unsigned int right)
{
    register unsigned int node;
    node=POOL_ALLOC((unsigned int far *)&EXPR_POOL_SEG,sizeof(struct C58Record));
    W(node,8)=type;
    K(node)=kind;
    W(node,4)=0;
    B(node,6)=0;
    B(node,7)=0;
    if(type) W(node,2)=GET_TYPE_KIND_HOOK(type);
    else W(node,2)=0;
    W(node,10)=left;
    W(node,12)=right;
    return node;
}

/* BCC_NODE_MODE: as BCC_NODE_BINARY, also setting the qualifier flags word to mode. */
unsigned int far pascal BCC_NODE_MODE(signed char kind,register unsigned int type,unsigned int left,unsigned int right,signed char mode)
{
    register unsigned int node;
    node=POOL_ALLOC((unsigned int far *)&EXPR_POOL_SEG,sizeof(struct C58Record));
    W(node,8)=type;
    K(node)=kind;
    W(node,4)=mode;
    B(node,6)=0;
    B(node,7)=0;
    if(type) W(node,2)=GET_TYPE_KIND_HOOK(type);
    else W(node,2)=0;
    W(node,10)=left;
    W(node,12)=right;
    return node;
}

/* BCC_NODE_INTEGER: integer constant node (operator 2) of type with value. */
unsigned int far pascal BCC_NODE_INTEGER(register unsigned int type,long value)
{
    register unsigned int node;
    node=POOL_ALLOC((unsigned int far *)&EXPR_POOL_SEG,sizeof(struct C58Record));
    W(node,8)=type;
    K(node)=2;
    W(node,4)=0;
    B(node,6)=0;
    B(node,7)=0;
    if(type) W(node,2)=GET_TYPE_KIND_HOOK(type);
    else W(node,2)=0;
    L(node,10)=value;
    return node;
}

/* NEW_BITFIELD_NODE_ALT: a bitfield access node (operator 51) of the
   object left; first = width, second = shift (NEW_BITFIELD_NODE). */
unsigned int far pascal NEW_BITFIELD_NODE_ALT(unsigned int left,register unsigned int type,unsigned char first,unsigned char second)
{
    register unsigned int node;
    node=POOL_ALLOC((unsigned int far *)&EXPR_POOL_SEG,sizeof(struct C58Record));
    W(node,8)=type;
    K(node)=51;
    W(node,2)=GET_TYPE_KIND_HOOK(type);
    W(node,4)=0;
    B(node,6)=0;
    B(node,7)=0;
    W(node,10)=left;
    B(node,12)=first;
    B(node,13)=second;
    return node;
}

/* EXPAND_COMPOUND_ASSIGN_ALT: x op= y into x = x op y (EXPAND_COMPOUND_ASSIGN). */
unsigned int far pascal EXPAND_COMPOUND_ASSIGN_ALT(register unsigned int node)
{
    register unsigned int left;
    left=W(node,10);
    W(node,0)+=-11;
    if(BCC_NODE_TEST2(left)) W(node,10)=BCC_NODE_NORMALIZE(left);
    else {
        W(node,10)=BCC_NODE_REBUILD(left);
        left=BCC_NODE_CLONE(left);
    }
    return ((C58BinaryWordTransport)NEW_EXPR_NODE_HOOK)(18,W(node,8),BCC_NODE_CLONE(left),node);
}

/* BCC_NODE_CONVERT: x++ / x-- into sequence(old x, x += 1) (EXPAND_POST_INC_DEC). */
unsigned int far pascal BCC_NODE_CONVERT(register unsigned int node)
{
    unsigned int result;
    register unsigned int left;
    left=W(node,10);
    W(node,0)+=-16;
    if(BCC_NODE_TEST2(left)) result=BCC_NODE_NORMALIZE(left);
    else {
        result=BCC_NODE_REBUILD(left);
        W(node,10)=BCC_NODE_CLONE(left);
    }
    return ((C58BinaryWordTransport)NEW_EXPR_NODE_HOOK)(41,W(node,8),result,node);
}

/* BCC_NODE_TEST2: 1 when the tree contains a call (EXPR_CONTAINS_CALL). */
static int near pascal BCC_NODE_TEST2(register unsigned int node)
{
    if(!node) return 0;
    if(K(node)<=7) return 0;
    if(K(node)==51) return BCC_NODE_TEST2(W(node,10));
    if(K(node)==54) return 1;
    return BCC_NODE_TEST2(W(node,10)) || BCC_NODE_TEST2(W(node,12));
}

/* BCC_NODE_REBUILD: copy of a tree with x++ / x-- replaced by x. */
static unsigned int near pascal BCC_NODE_REBUILD(register unsigned int node)
{
    if(!node) return 0;
    node=BCC_NODE_COPY_NEAR(node);
    if(K(node)<=7) return node;
    if(K(node)==51) {
        W(node,10)=BCC_NODE_REBUILD(W(node,10));
        return node;
    }
    if(K(node)==35 || K(node)==36)
        return BCC_NODE_REBUILD(W(node,10));
    W(node,12)=BCC_NODE_REBUILD(W(node,12));
    W(node,10)=BCC_NODE_REBUILD(W(node,10));
    return node;
}

/* BCC_NODE_CLONE: copy of a tree with each assignment replaced by its left side. */
static unsigned int near pascal BCC_NODE_CLONE(register unsigned int node)
{
    if(!node) return 0;
    node=BCC_NODE_COPY_NEAR(node);
    if(K(node)<=7) return node;
    if(K(node)==51) {
        W(node,10)=BCC_NODE_CLONE(W(node,10));
        return node;
    }
    if(K(node)>=18 && K(node)<=28)
        return BCC_NODE_CLONE(W(node,10));
    W(node,12)=BCC_NODE_CLONE(W(node,12));
    W(node,10)=BCC_NODE_CLONE(W(node,10));
    return node;
}

/* BCC_NODE_COPY_NEAR: shallow copy of one node. */
static unsigned int near pascal BCC_NODE_COPY_NEAR(unsigned int node)
{
    register unsigned int copy;
    copy=POOL_ALLOC((unsigned int far *)&EXPR_POOL_SEG,sizeof(struct C58Record));
    RECORD(copy)=RECORD(node);
    return copy;
}

/* BCC_NODE_NORMALIZE: *p (or a bitfield of *p) into *(t = p), leaving node reading *t
   (HOIST_LVALUE_ADDR_TO_TEMP). */
static unsigned int near pascal BCC_NODE_NORMALIZE(register unsigned int node)
{
    unsigned int root,first,binary,result,classification;
    register unsigned int child;
    if(K(node)==51) root=W(node,10);
    else root=node;
    child=W(root,10);
    classification=NEW_TEMPORARY_HOOK(W(child,8));
    first=((C58ModeWordTransport)NEW_SYMBOL_NODE_HOOK)(5,W(child,8),classification,0,0);
    W(root,10)=((C58ModeWordTransport)NEW_SYMBOL_NODE_HOOK)(5,W(child,8),classification,0,0);
    binary=((C58BinaryWordTransport)NEW_EXPR_NODE_HOOK)(18,W(child,8),first,child);
    result=((C58BinaryWordTransport)NEW_EXPR_NODE_HOOK)(49,W(root,8),binary,0);
    if(K(node)==51)
        result=NEW_BITFIELD_NODE_HOOK(result,W(node,8),B(node,12),B(node,13));
    return result;
}

/* TREE_HAS_SIDE_EFFECTS_ALT: 1 when the tree has a side effect (TREE_HAS_SIDE_EFFECTS). */
int far pascal TREE_HAS_SIDE_EFFECTS_ALT(register unsigned int node)
{
    while(node) {
        switch(K(node)) {
        case 1:case 2:case 3:case 4:case 5:case 6:case 7:
            return 0;
        case 18:case 19:case 20:case 21:case 22:case 23:case 24:
        case 25:case 26:case 27:case 28:case 35:case 36:case 54:
            return 1;
        case 51:
            node=W(node,10);
            continue;
        default:
            if(W(node,12) && TREE_HAS_SIDE_EFFECTS_HOOK(W(node,12))) return 1;
        }
        node=W(node,10);
    }
    return 0;
}
