#ifndef EXPRV5_H
#define EXPRV5_H
#include "DATA.H"
extern unsigned int EXPR_POOL_SEG; extern unsigned int SCOPE_POOL_SEG;
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal CREATE_LOCAL_TEMP(unsigned int);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal ANALYZE_EXPRESSION(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal REGISTER_TEMP_DESTRUCTOR(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal MAKE_ADDRESS_OF(unsigned int);
extern unsigned int far pascal MAKE_CAST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_LIST_NODE(unsigned int,unsigned int);
extern unsigned int far pascal JOIN_COMMA_EXPR(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
#endif
