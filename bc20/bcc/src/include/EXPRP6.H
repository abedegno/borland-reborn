#ifndef EXPRP6_H
#define EXPRP6_H
#include "DATA.H"
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern unsigned char far pascal TRY_UNARY_OPERATOR_CALL(unsigned int far *,unsigned int,unsigned int);
extern unsigned int far pascal APPLY_CONVERSION_FUNCTION(unsigned int,unsigned int,unsigned int);
#endif
