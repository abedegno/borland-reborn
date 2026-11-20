#ifndef EMIT045_H
#define EMIT045_H
#include "DATA.H"
/* Actual DX:AX result carrier: two independent16-bit emission handles, not a FAR pointer. */
typedef union EmissionPair {
    unsigned long value;
    struct { unsigned int low,high; } words;
} EmissionPair;
extern unsigned int EXPR_POOL_SEG; extern unsigned int FLOW_BLOCK_POOL_SEG;
extern signed char HUGE_PTR_AHSHIFT_MODE;
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern unsigned int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
extern unsigned int (far pascal *EXPAND_COMPOUND_ASSIGN_HOOK)(unsigned int);
extern unsigned int (far pascal *DECAY_TO_POINTER_HOOK)(unsigned int,unsigned int,int);
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *NEW_CONST_NODE_HOOK)(unsigned int,unsigned long);
extern unsigned int (far pascal *NEW_EXPR_NODE_HOOK)(unsigned int,unsigned int,unsigned int,unsigned int);
extern void far cdecl REPORT_FATAL(unsigned int);
extern void near pascal NARROW_STRUCT_TO_SCALAR(unsigned int);
extern unsigned long near pascal GENERATE_INDIRECT_LOAD(unsigned int,unsigned int,unsigned int);
extern unsigned long near pascal GENERATE_DEREF_OF_ADDRESS(unsigned int,unsigned int,unsigned int);
extern unsigned long near pascal GEN_DEREF_FAR_ADD_ASSIGN(unsigned int);
extern unsigned long far pascal GENERATE_STRUCT_ASSIGN_BODY(unsigned int,unsigned int);
extern unsigned long near pascal GENERATE_ADDRESS_OF(unsigned int,unsigned char);
extern unsigned long near pascal GENERATE_POST_INCREMENT(unsigned int);
extern unsigned long near pascal GENERATE_POST_DECREMENT(unsigned int);
extern void far pascal EMIT_OPERATOR_HELPER_BODY(unsigned int);
/* Existing physical caller views: WORD opcode plus32-bit payload; WORD+BYTE-slot+twoWORDs. */
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,unsigned long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal GEN_FLOAT_POSTINC_DEC(unsigned int,unsigned int);
extern unsigned int far pascal NEW_LABEL(void);
extern unsigned int far pascal NEW_BRANCH_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal JOIN_BLOCK_CHAINS(unsigned int,unsigned int);
extern unsigned int far pascal NEW_BLOCK(void);
extern unsigned int far pascal NEW_JUMP_BLOCK(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int);
/* Canonical DWORD forwarding facet independently proved and adopted by parent gate233. */
extern unsigned long far pascal GENERATE_BITFIELD_OP_ASSIGN(unsigned int,unsigned int);
extern unsigned long far pascal GENERATE_BITFIELD_LOAD(unsigned int);
extern unsigned long far pascal GENERATE_BITFIELD_STORE(unsigned int,unsigned int,unsigned int);
extern unsigned long far pascal GENERATE_BITFIELD_INC_DEC(unsigned int,unsigned int);
extern unsigned long far pascal GENERATE_CALL(unsigned int,unsigned int);
extern unsigned long far pascal GENERATE_OPERATOR(unsigned int);
#endif
