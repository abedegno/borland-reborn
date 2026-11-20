#ifndef EXPRC7_H
#define EXPRC7_H
#include "DATA.H"
extern unsigned int EXPR_POOL_SEG;
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
/* Authentic native PUBLICs for original still-unnamed foreign interfaces. */
extern unsigned int far pascal CHECK_NULL_CONSTANT(unsigned int,unsigned char far *);
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal APPLY_CONVERSION_FUNCTION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
#endif
