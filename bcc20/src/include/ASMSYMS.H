#ifndef ASMSYMS_H
#define ASMSYMS_H
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
typedef unsigned int C56Word;
typedef unsigned char C56Byte;
/* Minimum byte-packed arena view; never instantiated or used as an entry stride. */
struct C56PredicateNode {
    C56Word next,name,type;       /* offsets 0,2,4 */
    C56Byte flags;               /* offset 6 */
    C56Byte opaque7_to16[10];
    C56Word predicate_value;     /* unaligned offset 17 */
};
extern unsigned int NAME_POOL_SEG; extern unsigned int HASH_CHAIN_LINK_SEG;
extern unsigned int near NAME_HASH_TABLE[];
extern unsigned char OPTION_SOURCE_DEBUG; extern unsigned char OPTION_UNDERSCORES; extern unsigned char OPTION_MEMORY_MODEL;
extern int DEBUG_STATE;
extern char near _CTYPE[];
extern char far * near ASM_TYPE_NAME_TABLE[];
extern void (far pascal *NAME_HOOK)(unsigned int);
extern unsigned char (far pascal *SYMBOL_ELEMENT_KIND_HOOK)(unsigned int);
extern int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern unsigned int (far pascal *SYMBOL_INDEX_HOOK)(unsigned int);
extern void (far pascal *DEBUG_HEADER_DONE_HOOK)(void);
extern char near * far pascal OBJ_RECORD_BUFFER(void);
extern void far pascal PUT_CODE_STRING(char far *);
extern void far pascal PUT_CODE_CHAR(char);
/* Actual C56 callers transport full WORD values in the canonical char slot. */
typedef void (far pascal *C56CharacterWordTransport)(unsigned int);
extern void far pascal EMIT_HEX_BYTE(unsigned int);
extern void far pascal EMIT_DECIMAL(unsigned int);
extern void far pascal EMIT_SIGNED_DECIMAL(int);
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern unsigned int far pascal GET_PREPARED_SYMBOL(unsigned int);
extern unsigned int far pascal GET_PREPARED_FLAGS(unsigned int);
extern unsigned int far pascal GET_TYPE_DEBUG_ID(unsigned int);
extern unsigned int far pascal C56_NAME_FLAGS(unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern char far * far pascal MANGLE_SYMBOL_NAME(unsigned int);
extern void far pascal EMIT_COMM_DECLARATION(unsigned int,unsigned int,unsigned int,unsigned long);
static int near pascal NEEDS_CPP_MANGLING(unsigned int);
void far pascal DEBUG_NUMBERS(int);
static void near pascal DUMP_ONE(unsigned int);
void far pascal DUMP_ALL(void);
static void near pascal DUMP_NODE(unsigned int);
static void near pascal DUMP_FINISH(void);
void far pascal C56_EMIT_NAME(unsigned int);
#endif
