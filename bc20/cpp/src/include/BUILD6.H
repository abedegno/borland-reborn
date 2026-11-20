#ifndef BUILD6_H
#define BUILD6_H
#include "EXPRP6.H"
#include "EXPRK6.H"
#include "DATA.H"
extern unsigned int far pascal APPLY_BASED_POINTER(unsigned int);
extern unsigned int far pascal DECAY_TO_POINTER(unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern unsigned int far pascal DEREF_REFERENCE_EXPR(unsigned int);
extern unsigned int far pascal REWRITE_FOR_REFERENCE_BIND(unsigned int);
extern unsigned char far pascal IS_LVALUE(unsigned int);
extern unsigned char far pascal MEMBER_ACCESSIBLE(unsigned int,unsigned int);
extern unsigned int far pascal COPY_TYPE_RECORD(unsigned int);
extern void far pascal FREE_EXPR_TREE(unsigned int);
extern unsigned int far pascal MAKE_INT_CONSTANT(unsigned int,long);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,long,long,unsigned int);
/* Authentic still-unnamed native interfaces; audited original-stub identities. */
extern unsigned int far pascal CHECK_DOT_MEMBER(unsigned int,unsigned char);
extern unsigned int far pascal RESOLVE_SYMBOL_REFERENCE(unsigned int,unsigned int);
extern unsigned int far pascal MAKE_INITIALIZED_TEMP(unsigned int);
extern unsigned int far pascal MAKE_MEMBER_POINTER(unsigned int,unsigned char);
extern long far pascal FORMAT_MEMBER(unsigned int);
/* The two actual exported definitions in this genuine context. */
unsigned int far pascal BUILD_DEREF(unsigned int,unsigned int,unsigned char);
unsigned int far pascal BUILD_ADDRESS_OF(unsigned int,unsigned int,unsigned int);
#endif
