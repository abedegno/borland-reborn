#ifndef EMITMAIN_H
#define EMITMAIN_H
#include "DATA.H"
typedef union EmissionPair {
    unsigned long value;
    struct { unsigned int low, high; } words;
} EmissionPair;
extern unsigned int EXPR_POOL_SEG;
extern unsigned char OPTION_TARGET_CPU, HUGE_PTR_AHSHIFT_MODE;
extern unsigned int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *,unsigned int);
extern void far cdecl REPORT_FATAL(unsigned int);
extern unsigned long near pascal GENERATE_CONVERSION(unsigned int);
extern unsigned long far pascal GENERATE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,unsigned long);
/* These are the original caller's physical WORD opcode/BYTE flags facets. */
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal NEW_PLAIN_CODE_NODE(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal CODE_OP_FOR_NODE(unsigned int);
extern unsigned int far pascal EMIT_FLOAT_CONSTANT(unsigned int);
/* Proposed WORD forwarding facet: STAOV0BC-return-facet; not yet adopted. */
extern unsigned int far pascal GEN_FPU_BINARY_OP(unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal FPU_STORE_NODE_6C(unsigned int,unsigned int);
extern void far pascal EMIT_OPERATOR_HELPER(unsigned int);
extern void far pascal EMIT_HELPER_CALL(char near *,unsigned int);
#endif
