#ifndef EXPRC5_H
#define EXPRC5_H
#include "DATA.H"
extern unsigned int EXPR_POOL_SEG;
/* Existing text in the data segment; no owned storage. */
extern char far * far pascal FORMAT_SYMBOL(unsigned int);
/* Actual native PUBLIC names for these original, still-unnamed interfaces. */
extern void far pascal REPORT_DIAGNOSTIC_AT(unsigned int,char far *,long,unsigned int,unsigned int);
extern unsigned int far pascal STRIP_CV_QUALIFIERS(unsigned int);
extern void far pascal LOWER_VIRTUAL_CALL(unsigned int,unsigned int far *);
extern void far pascal QUEUE_DEFERRED_SYMBOL(unsigned int);
extern unsigned int far pascal MAKE_DEREFERENCE(unsigned int);
#endif
