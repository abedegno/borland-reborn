#ifndef EXPRDISP_H
#define EXPRDISP_H
#include "DATA.H"
#include "OVL.H"

/* Existing first-WORD read aliases of real eight-byte bank descriptors.
   These are fixed-DS selector views, not declarations of new two-byte banks. */
extern unsigned int EXPR_POOL_SEG;
/* Accepted WORD-mode caller facade. Both installed providers consume the
   low BYTE of that slot; this is a qualified target ABI, not ISO type identity. */
extern long (far pascal *TOKEN_CONVERT)(long,int);

extern void cdecl REPORT_FATAL(unsigned int,...);


#endif
