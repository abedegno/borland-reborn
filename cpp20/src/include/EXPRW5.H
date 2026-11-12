#ifndef EXPRW5_H
#define EXPRW5_H
#include "DATA.H"
extern unsigned int EXPR_POOL_SEG;
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,long,long,unsigned int);
/* Actual 32-bit result carrier; existing TBIND/TMETHOD caller facet. */
extern long far pascal FORMAT_TYPE(unsigned int);
/* Authentic native PUBLICs for original still-unnamed interfaces. */
extern unsigned int far pascal CONVERT_TO_RVALUE(unsigned int);
extern unsigned int far pascal NODE_ENUM_TO_INT(unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
#endif
