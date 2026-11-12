#ifndef TAIL6_H
#define TAIL6_H
#include "DATA.H"
extern unsigned char far pascal IS_MODIFIABLE_NODE(unsigned int);
extern unsigned int far pascal CONVERT_EXPR_TO_TYPE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal CONVERT_CLASS_TO_SCALAR(unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
unsigned int far pascal BUILD_INCDEC(unsigned int,unsigned int);
unsigned int far pascal BUILD_UNARY_ARITH(unsigned int,unsigned int,unsigned int);
unsigned int far pascal BUILD_COMPLEMENT(unsigned int,unsigned int,unsigned int);
unsigned int far pascal BUILD_LOGICAL_NOT(unsigned int,unsigned int);
#endif
