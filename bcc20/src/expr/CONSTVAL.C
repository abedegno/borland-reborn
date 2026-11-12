/* target: ovr118_TVALUE */
/* opts: -mm -G- -O -Z -p */
/* Role: expressions: parses a constant expression and returns its long value, else reports
   "Constant expression required". Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: evaluates an integer constant expression, probably for the
   places the grammar needs a number (array bounds, enumerator values, bitfield widths,
   case labels). CONST_EXPR_VALUE_BODY parses one assignment-expression, analyses it
   with "int" as the expected type (INT_TYPE is BCC_TYPE_PTR[5], the int type),
   simplifies it so constants fold, and stores the long result. If the
   tree is not a constant it reports MSG_CONSTANT_EXPRESSION; an operator-0 node
   (probably an expression that already failed with an error) quietly gives 1 so one
   mistake does not cause a second message. The tree is freed in every case.
   The function is static: it is reached from the other code of overlay ovr118. */

#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "FIELDS.H"

extern int far PARSE_ASSIGNMENT_EXPR(unsigned int type);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern char far IS_CONSTANT_EXPR(unsigned int node);
extern void far REPORT_CURRENT_TOKEN(int error);
extern void far FREE_EXPR_TREE(unsigned int node);
extern unsigned int EXPR_POOL_SEG;

/* CONST_EXPR_VALUE_BODY: "type" is passed straight to PARSE_ASSIGNMENT_EXPR; *result
   receives the value (left unchanged after an error). A constant node keeps its long
   value at EXPR_VALUE, the same offset as EXPR_LEFT used here. */
static void far pascal CONST_EXPR_VALUE_BODY(unsigned int type, long far *result)
{
    register unsigned int node;

    node = PARSE_ASSIGNMENT_EXPR(type);
    node = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node,INT_TYPE),0);
    if (*(unsigned int far *)MK_FP(EXPR_POOL_SEG, node) == 0) {
        *result = 1L;
    } else if (IS_CONSTANT_EXPR(node)) {
        *result = *(long far *)MK_FP(EXPR_POOL_SEG, node + EXPR_LEFT);
    } else {
        REPORT_CURRENT_TOKEN(MSG_CONSTANT_EXPRESSION);
    }
    FREE_EXPR_TREE(node);
}
