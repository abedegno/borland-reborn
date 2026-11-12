/* target: ovr060_C4FLAT */
/* opts: -mm -G -O -Z -p */
/* Role: expressions: analyses chains of comma expressions iteratively (no recursion),
   setting each comma node's type from its right operand. Entry points: ANALYZE_COMMA_EXPR.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: semantic analysis of comma expressions, called from RESOLVE_SYMBOL_REFERENCE
   (expr/EXPRDISP.C) when the analyser meets an EOP_COMMA node. Long comma chains such as
   a, b, c, d (produced by the parser and by compiler-generated code) would make the
   ordinary recursive analyser go very deep, so ANALYZE_COMMA_EXPR walks them with an
   explicit stack instead of recursion. The stack is threaded through the tree itself: on
   the way down, the EXPR_LEFT or EXPR_RIGHT link of a comma node is overwritten with the
   previous stack top (left_chain / right_chain), and on the way back up the analysed child
   is stored back into that link. Node flag bits used: 1 = node already analysed (skip
   it), 0x80 = temporary mark "this node was pushed on right_chain" (cleared before
   return), 0x20 = node may be an overloaded operator call (checked in C++ mode,
   CPP_MODE, through TRY_BINARY_OPERATOR_CALL). The left operand of each comma
   is analysed for its side effects only (expected type VOID_TYPE); the right operand
   gives the comma's value and type. */
/* Complete authentic iterative node/chain routine, original19FF..1B54. */
#include <dos.h>
#include "EXPRF4.H"
#include "POOL.H"

/* ANALYZE_COMMA_EXPR: node is the comma node; mode is passed to the operator-call check
   of the outermost comma only; leaf_mode is the expected-value mode for the rightmost
   operand only (inner right operands that sit on the left of another comma get 0).
   Returns the analysed tree (the outermost node may be replaced by an operator call). */
unsigned int far pascal ANALYZE_COMMA_EXPR(unsigned int node,unsigned int mode,unsigned int leaf_mode)
{
    unsigned int right_chain;
    unsigned int saved;
    register unsigned int child;
    register unsigned int left_chain=0;

    right_chain=0;
    /* Descend: push a comma found in the left operand, else analyse the left operand. */
    for(;;) {
        child=EXPR_W(node,EXPR_LEFT);
        if(!(EXPR_B(child,EXPR_NODE_FLAGS)&1)) {
            if(EXPR_W(child,EXPR_OP)==EOP_COMMA) {
                EXPR_W(node,EXPR_LEFT)=left_chain;
                left_chain=node;
                node=child;
                continue;
            }
            EXPR_W(node,EXPR_LEFT)=ANALYZE_EXPRESSION(child,VOID_TYPE,0);
        }
        /* Then the right operand: push a comma found there (marked 0x80), else analyse it. */
        child=EXPR_W(node,EXPR_RIGHT);
        if(!(EXPR_B(child,EXPR_NODE_FLAGS)&1)) {
            if(EXPR_W(child,EXPR_OP)==EOP_COMMA) {
                EXPR_W(node,EXPR_RIGHT)=right_chain;
                right_chain=node;
                node=child;
                EXPR_B(node,EXPR_NODE_FLAGS)|=0x80;
                continue;
            }
            EXPR_W(node,EXPR_RIGHT)=DECAY_TO_POINTER(ANALYZE_EXPRESSION(child,left_chain?0:leaf_mode,0));
        }
        /* Both operands done: the comma takes its right operand's type. */
        EXPR_W(node,EXPR_TYPE)=EXPR_W(EXPR_W(node,EXPR_RIGHT),EXPR_TYPE);
        EXPR_B(node,EXPR_NODE_FLAGS)|=1;
        saved=EXPR_B(node,EXPR_NODE_FLAGS)&0x80;
        EXPR_B(node,EXPR_NODE_FLAGS)&=0x7F;
        if(CPP_MODE && (EXPR_B(node,EXPR_NODE_FLAGS)&0x20))
            TRY_BINARY_OPERATOR_CALL(&node,0,(left_chain || right_chain)?0:mode);
        /* Pop: a node pushed from right_chain gets this result as its right operand... */
        if(saved) {
            unsigned int parent=right_chain;
            right_chain=EXPR_W(parent,EXPR_RIGHT);
            EXPR_W(parent,EXPR_RIGHT)=node;
            node=parent;
            continue;
        }
        /* ...one pushed from left_chain as its left operand; with both stacks empty, done. */
        if(left_chain) {
            unsigned int parent=left_chain;
            left_chain=EXPR_W(parent,EXPR_LEFT);
            EXPR_W(parent,EXPR_LEFT)=node;
            node=parent;
            continue;
        }
        return node;
    }
}
