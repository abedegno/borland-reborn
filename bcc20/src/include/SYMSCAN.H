#ifndef SYMSCAN_H
#define SYMSCAN_H
#include "DATA.H"
extern unsigned int NAME_POOL_SEG; extern unsigned int HASH_CHAIN_LINK_SEG;
extern unsigned int near NAME_HASH_TABLE[];
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern int (far pascal *TYPE_ALIGNMENT_HOOK)(unsigned int);
extern void (far pascal *ALIGN_OUTPUT_HOOK)(int);
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern unsigned int (far pascal *STREAM_HOOK)(unsigned int);
extern long (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void (far pascal *RESERVE_BYTES_HOOK)(unsigned int);

extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned int far pascal DEFINE_HUGE_DATA_SEGMENTS(unsigned int);
extern void far pascal EMIT_HUGE_DATA(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern char far * far pascal SYMBOL_NAME_TEXT(unsigned int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void far pascal CLEAR_PREPARED_FLAGS(unsigned int,unsigned int);
extern unsigned int far pascal GET_PREPARED_FLAGS(unsigned int);
extern unsigned int far pascal DEFINE_FAR_SEGMENT(void);

static void near pascal SCAN_FILE_SYMBOLS(void);
void far pascal CHECK_FILE_SYMBOLS(void);
#endif
