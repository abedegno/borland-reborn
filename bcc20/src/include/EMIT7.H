#ifndef EMIT7_H
#define EMIT7_H
#include "DATA.H"
typedef union EmissionPair {
    unsigned long value;
    struct { unsigned int low,high; } words;
} EmissionPair;
extern unsigned int EXPR_POOL_SEG;
/* Authentic DS3E3B byte table, indexed by sourceclass*17+destinationclass. */
extern unsigned int (far pascal *GET_TYPE_FLAGS_ALT_HOOK)(unsigned int);
extern void far cdecl REPORT_FATAL(unsigned int);
extern unsigned long far pascal GENERATE_EXPRESSION(unsigned int,unsigned int);
extern unsigned int far pascal NEW_CONSTANT_NODE(unsigned int,unsigned long);
extern unsigned int far pascal NEW_CODE_NODE(unsigned int,unsigned char,unsigned int,unsigned int);
/* Real WORD forwarding facet separately frozen in STAOV0C7-return-facet. */
extern unsigned int far pascal FLOAT_TEMP_NODE(int,unsigned int);
extern unsigned char far pascal SEGMENT_REGISTER_CODE(unsigned int);
extern void far pascal EMIT_HELPER_CALL(char near *,unsigned int);
#endif
