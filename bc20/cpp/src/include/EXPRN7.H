#ifndef EXPRN7_H
#define EXPRN7_H
#include "DATA.H"
extern unsigned int EXPR_POOL_SEG;
/* Existing BYTE declarations; use actual signed facets explicitly at the site. */
struct NodePayload { unsigned char bytes[6]; };
extern unsigned int far pascal MAKE_UNARY_NODE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
#endif
