/* constval.c: CONST_EXPR_VALUE_BODY, from bcc20/src/expr/CONSTVAL.C: the value of a
   constant expression into *result (left unchanged after an error; 1 for an error node).
   type goes to PARSE_ASSIGNMENT_EXPR; a constant node keeps its long at offset 10. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"

void CONST_EXPR_VALUE_BODY(u16 type, farptr result)
{
    u16 node = PARSE_ASSIGNMENT_EXPR(type);
    node = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node, INT_TYPE), 0);
    if (W(MK_FP(EXPR_POOL_SEG, node)) == 0)
        SD(result) = 1;
    else if (IS_CONSTANT_EXPR(node))
        SD(result) = SD(MK_FP(EXPR_POOL_SEG, node + EXPR_LEFT));
    else
        REPORT_CURRENT_TOKEN(MSG_CONSTANT_EXPRESSION);
    FREE_EXPR_TREE(node);
}
