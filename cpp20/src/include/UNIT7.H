#ifndef UNIT7_H
#define UNIT7_H
#include "DATA.H"
struct Range { long minimum,maximum; };
extern struct Range TYPE_RANGE_TABLE[];
struct C7Token { unsigned char bytes[19]; };
extern struct C7Token CURRENT_TOKEN_RECORD;
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR_PLAIN(unsigned int,unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,long,long,unsigned int);
extern void far pascal FREE_EXPR_NODE(unsigned int);
extern void far pascal FREE_EXPR_TREE(unsigned int);
extern unsigned int far pascal DEREF_REFERENCE_EXPR(unsigned int);
extern long far pascal FORMAT_TYPE(unsigned int);
extern unsigned char far pascal IS_LVALUE(unsigned int);
extern unsigned int far pascal NULL_CONSTANT_TO_POINTER(unsigned int,unsigned int);
extern unsigned char far pascal IS_BASE_CLASS(unsigned int,unsigned int,unsigned char);
extern void far pascal BCC_INPUT_STRING_PTR(unsigned int,unsigned int);
extern void far pascal ADVANCE_TOKEN(void);
extern unsigned int far pascal PARSE_ASSIGNMENT_EXPR(unsigned int);
extern unsigned int far pascal POP_INPUT_CONTEXT(unsigned int);
extern unsigned int far pascal MAKE_BINARY_NODE(unsigned int,unsigned int,unsigned int);
/* The last actual body is genuinely forward-referenced in this translation unit. */
unsigned int far pascal APPLY_BASED_POINTER(unsigned int);
#endif
