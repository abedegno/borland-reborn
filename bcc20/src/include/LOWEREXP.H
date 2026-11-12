#ifndef LOWEREXP_H
#define LOWEREXP_H
#include "DATA.H"
#include "OVL.H"
extern unsigned int EXPR_POOL_SEG;
typedef struct { unsigned char bytes[10]; } C40RealStorage;
extern C40RealStorage near REAL_ONE;
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern unsigned int far pascal MAKE_REAL_CONSTANT(unsigned int,C40RealStorage far *);
extern void cdecl REPORT_FATAL(unsigned int,...);
#endif
