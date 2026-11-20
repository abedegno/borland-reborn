#ifndef EXPRC4_H
#define EXPRC4_H
#include "DATA.H"
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
/* Actual native PUBLIC names for original still-unnamed interfaces. */
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal APPLY_BASED_POINTER(unsigned int);
extern unsigned int far pascal MAKE_DEREFERENCE(unsigned int);
extern unsigned char far pascal TRY_UNARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
extern unsigned char far pascal TRY_BINARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
#endif
