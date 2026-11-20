#ifndef UNIT5_H
#define UNIT5_H
#include "DATA.H"
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern char far * far pascal SYMBOL_NAME_TEXT(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern unsigned int far pascal NULL_CONSTANT_TO_POINTER(unsigned int,unsigned int);
extern unsigned char far pascal C7_TYPE_COMPAT(unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal DEFAULT_ARGUMENT(unsigned int);
extern unsigned int far pascal CONVERT_ARGUMENT(unsigned int,unsigned int,unsigned int,int);
extern unsigned int far pascal PREPARE_CALL(unsigned int,unsigned int far *);
extern unsigned int far pascal EXPAND_INLINE_CALL(unsigned int);
void far pascal REPORT_ARGUMENT_MISMATCH(unsigned int,unsigned int,unsigned int,int,unsigned int);
unsigned int far pascal CHECK_CALL_ARGUMENTS(unsigned int,unsigned int);
unsigned int far pascal ANALYZE_CALL(unsigned int,unsigned int);
#endif
