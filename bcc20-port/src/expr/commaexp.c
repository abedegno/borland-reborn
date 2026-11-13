/* commaexp.c: ANALYZE_COMMA_EXPR, from bcc20/src/expr/COMMAEXP.C: analyse a tree of
   comma operators without recursion.  node is the comma node; mode goes to the
   operator-call check of the outermost comma only; leaf_mode is the expected-value mode of
   the rightmost operand only.  Commas met on the way down are pushed on two chains threaded
   through their own operand words (a right-operand comma marked 80h). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "exprop.h"
#include "protos.h"

u16 ANALYZE_COMMA_EXPR(u16 node, u16 mode, u16 leaf_mode)
{
    u16 left_chain = 0, right_chain = 0;
    for (;;) {
        u16 child = EXPR_W(node, EXPR_LEFT);
        if (!(EXPR_B(child, EXPR_NODE_FLAGS) & 1)) {
            if (EXPR_W(child, EXPR_OP) == EOP_COMMA) {
                EXPR_W(node, EXPR_LEFT) = left_chain;
                left_chain = node;
                node = child;
                continue;
            }
            u16 analysed = ANALYZE_EXPRESSION(child, VOID_TYPE, 0);
            EXPR_W(node, EXPR_LEFT) = analysed;
        }
        child = EXPR_W(node, EXPR_RIGHT);
        if (!(EXPR_B(child, EXPR_NODE_FLAGS) & 1)) {
            if (EXPR_W(child, EXPR_OP) == EOP_COMMA) {
                EXPR_W(node, EXPR_RIGHT) = right_chain;
                right_chain = node;
                node = child;
                EXPR_B(node, EXPR_NODE_FLAGS) |= 0x80;
                continue;
            }
            u16 analysed = DECAY_TO_POINTER(ANALYZE_EXPRESSION(child, left_chain ? 0 : leaf_mode, 0));
            EXPR_W(node, EXPR_RIGHT) = analysed;
        }
        /* both operands done: the comma takes its right operand's type */
        EXPR_W(node, EXPR_TYPE) = EXPR_W(EXPR_W(node, EXPR_RIGHT), EXPR_TYPE);
        EXPR_B(node, EXPR_NODE_FLAGS) |= 1;
        u8 saved = EXPR_B(node, EXPR_NODE_FLAGS) & 0x80;
        EXPR_B(node, EXPR_NODE_FLAGS) &= 0x7F;
        if (CPP_MODE && (EXPR_B(node, EXPR_NODE_FLAGS) & 0x20)) {
            u16 mark = scratch_mark();
            farptr np = scratch_alloc(2);
            W(np) = node;
            TRY_BINARY_OPERATOR_CALL(np, 0, (left_chain || right_chain) ? 0 : mode);
            node = W(np);
            scratch_release(mark);
        }
        if (saved) {
            u16 parent = right_chain;
            right_chain = EXPR_W(parent, EXPR_RIGHT);
            EXPR_W(parent, EXPR_RIGHT) = node;
            node = parent;
            continue;
        }
        if (left_chain) {
            u16 parent = left_chain;
            left_chain = EXPR_W(parent, EXPR_LEFT);
            EXPR_W(parent, EXPR_LEFT) = node;
            node = parent;
            continue;
        }
        return node;
    }
}
