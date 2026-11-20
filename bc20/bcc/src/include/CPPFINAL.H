#ifndef CPPFINAL_H
#define CPPFINAL_H

/* Existing canonical DS identities: all storage is extern-owned. */
extern unsigned int EXPR_POOL_SEG;
extern unsigned int CODE_SEGMENT_ID;

/* New observed extern-only WORD/BYTE identities. */
extern unsigned int FUNCTION_DEF_POSITION;

/* Actual adjacent8-byte bank descriptors at649C and64A4. No allocation
   or storage definition is introduced by these typed object views. */
struct C13Bank { unsigned int segment,spare,used,limit; };
extern struct C13Bank C13_BIND_BANK,C13_ORDER_BANK;
/* Exact six-byte structure copied by native F_SCOPY@0:0402. */
struct C13Slot { unsigned int key,symbol,offset; };
/* Exact six-byte existing source record passed by value via F_SPUSH@. */
#include "BCCREC6.H"
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
extern struct C77Record6 NO_SOURCE_LOCATION;

/* Existing real FAR Pascal callback protocols. */
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);
extern void (far pascal *EMIT_THIS_ADJUST_THUNK_HOOK)(unsigned int,unsigned int,unsigned int,int);

extern void far pascal APPEND_RETURN_JUMP_BLOCK(unsigned int,struct C77Record6);
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);

/* Native PUBLIC names below are unused in the current canonical namespace;
   each is independently joined to its actual original record/stub/body. */


#endif
