#ifndef STMTBLK_H
#define STMTBLK_H
#include "BCCREC6.H"
#include "DATA.H"

/* Bank selectors below read the first WORD of the real eight-byte objects. */
struct C77Bank8 { unsigned int segment,spare,used,limit; };
typedef char C77Bank8Size[(sizeof(struct C77Bank8)==8)?1:-1];
extern unsigned int SCOPE_POOL_SEG; extern unsigned int EXPR_POOL_SEG;
/* CONTEXT_SEG names its first WORD; &CONTEXT_SEG carries the real Bank8 address. */
extern unsigned int BCC_TREE_SPECIAL;
extern unsigned int CODE_SEGMENT_ID;
extern long FUNCTION_DEF_POSITION;
extern unsigned char BCC_PACK_FLAG;

/* Installed families only; the 8134 INT facade is consumed through WORD bits. */
extern int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_VARIABLE_HOOK)(unsigned int,unsigned int);
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern void (far pascal *ALIGN_OUTPUT_HOOK)(int);
extern unsigned int (far pascal *STREAM_HOOK)(unsigned int);
extern void (far pascal *BYTE_HOOK)(unsigned char);

extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int, unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern void far pascal RESET_EXPR_POOL_ALT(void);
extern unsigned int far pascal LOWER_EXPRESSION(unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int, unsigned char);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void far pascal POOL_TRIM(unsigned int far *, unsigned int);
extern unsigned int far pascal INIT_FUNCTION_STATE(unsigned int, unsigned int, unsigned int, unsigned char, unsigned char, unsigned int, unsigned int, unsigned int, long);
extern unsigned int far pascal NEW_JUMP_BLOCK(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal NEW_LABEL(void);
extern void far pascal APPEND_BLOCK_CHAIN(unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal NEW_BRANCH_BLOCK(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
extern void far pascal SET_BLOCK_1C_FLAG_1(unsigned int);
extern void far pascal SPLICE_BLOCK_CHAIN(unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal NEW_RETURN_JUMP_BLOCK(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
extern void far pascal SET_SWITCH_BLOCK_INFO(unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal NEW_SCOPE_EXIT_BLOCK(unsigned int);
extern unsigned int far pascal NEW_SWITCH_BLOCK(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal NEW_EXPRESSION_BLOCK(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal NEW_SCOPE_ENTER_BLOCK(unsigned int, unsigned int);
extern void far pascal FINISH_FUNCTION_BLOCKS(unsigned int, unsigned int, unsigned int);
extern unsigned int far pascal FIND_OR_ADD_VARIABLE(unsigned int, unsigned char, unsigned char);
extern unsigned int far pascal CLONE_NODE_KEEP_SERIAL(unsigned int);
extern void far pascal EMIT_INITIALIZER_VALUE_FAR(unsigned int, unsigned int);

/* All twenty-five real original export definitions, in native order. */
unsigned int far pascal NEW_LABEL_IF_ENABLED(void);
void far pascal START_FUNCTION_STATE(void);
void far pascal FINISH_FUNCTION_STATE(void);
void far pascal APPEND_SCOPE_ENTER_BLOCK(void);
void far pascal APPEND_SCOPE_EXIT_BLOCK(void);
unsigned int far pascal APPEND_SWITCH_BLOCK(unsigned int first, struct C77Record6 record);
void far pascal SET_SWITCH_INFO_IF_ENABLED(unsigned int start, unsigned int value1, unsigned int value2);
void far pascal APPEND_JUMP_IF_FALSE_BLOCK(unsigned int first, unsigned int second, struct C77Record6 record);
unsigned int far pascal MAKE_JUMP_IF_TRUE_BLOCK(unsigned int first, unsigned int second, struct C77Record6 record);
void far pascal APPEND_JUMP_IF_TRUE_BLOCK(unsigned int first, unsigned int second, struct C77Record6 record);
void far pascal APPEND_JUMP_BLOCK(unsigned int first, struct C77Record6 record);
unsigned int far pascal MAKE_EXPRESSION_BLOCK(unsigned int first, struct C77Record6 record);
void far pascal APPEND_EXPRESSION_BLOCK(unsigned int first, struct C77Record6 record);
void far pascal SPLICE_STATEMENT_CHAIN(unsigned int chain, unsigned int parent);
unsigned int far pascal MAKE_RETURN_JUMP_BLOCK(unsigned int first, struct C77Record6 record);
void far pascal APPEND_RETURN_JUMP_BLOCK(unsigned int first, struct C77Record6 record);
void far pascal APPEND_BLOCK_IF_NONZERO(unsigned int value);
void far pascal APPEND_BLOCK_AND_MARK(unsigned int value);
void far pascal APPEND_ANALYZED_EXPRESSION(unsigned int value);
void far pascal REGISTER_SYMBOL_VARIABLE(unsigned int value);
unsigned int far pascal SELECT_SYMBOL_STREAM(unsigned int value);
void far pascal SET_STREAM(unsigned int value);
void far pascal EMIT_ZERO_BYTES(unsigned int count);
void far pascal EMIT_CONST_INIT_VALUE(unsigned int value);
void far pascal EMIT_BYTE_IF_ENABLED(unsigned char code);

#endif
