#ifndef INITLIST_H
#define INITLIST_H
#include "DATA.H"
#include "OVL.H"
extern unsigned int EXPR_POOL_SEG;
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);
extern void far pascal PARSE_CONSTANT_EXPR_VALUE(unsigned int,long far *);
extern unsigned int ERROR_COUNT;
#endif
