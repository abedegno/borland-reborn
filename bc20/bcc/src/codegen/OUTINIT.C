/* target: ovr140_STOVR141 */
/* opts: -mm -G -O -Z -p */
/* Role: code generation: initialises the code-output pools and opens the object file or the
   assembly output file. Entry points: INIT_CODEGEN_POOLS. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: run once before code generation starts (the caller passes the output file
   name). It sets up the far pools the output side uses: code bytes, code fragments
   (BLKLAYOT.C), segment data blocks and relocations (OBJSEGS.C), segment definitions and
   queued words, plus nine pools nothing else uses (CODEGEN_UNUSED_POOL_ONE..NINE, see
   docs/FINDINGS.md). Each pool global is four words: segment, step, unit, used, which the
   local struct Pool mirrors; INIT_POOL sets step and unit to the same growth amount, clears
   'used' and lets POOL_INIT get the segment. It also clears the segment list head, starts
   the debug type counter at 24, and opens either the assembly output (COMPILER_MODE set,
   -S) or the object file. Bit 1 of CODE_OUTPUT_FLAGS is set when an object file name is
   given and an object file is really written (not compiling via assembler). */
#include "RTL.H"
struct Pool { unsigned int segment,step,unit,used; };
extern struct Pool CODE_BYTE_POOL_SEG,CODE_FRAGMENT_POOL_SEG,SEG_DATA_BLOCK_POOL_SEG,RELOCATION_POOL_SEG;
extern struct Pool CODEGEN_UNUSED_POOL_ONE,CODEGEN_UNUSED_POOL_TWO,CODEGEN_UNUSED_POOL_THREE,CODEGEN_UNUSED_POOL_FOUR;
extern struct Pool CODEGEN_UNUSED_POOL_FIVE,CODEGEN_UNUSED_POOL_SIX,CODEGEN_UNUSED_POOL_SEVEN,CODEGEN_UNUSED_POOL_EIGHT;
extern struct Pool CODEGEN_UNUSED_POOL_NINE,SEGDEF_POOL_SEG,QUEUED_WORD_POOL_SEG;
struct OutputState { unsigned char bytes[28]; };
extern struct OutputState SEGMENT_LIST_HEAD;
extern unsigned int DEBUG_TYPE_COUNTER,CODE_OUTPUT_FLAGS;
extern unsigned char COMPILER_MODE,OPTION_COMPILE_VIA_ASM;
extern char far *OPTION_OBJECT_NAME;
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);
extern void far pascal CREATE_ASM_OUTPUT_FAR(char far *);
extern void far pascal OPEN_OUTPUT_FILE(char far *);
#define INIT_POOL(pool,amount) { \
    (pool).unit=(pool).step=(amount); \
    (pool).used=0; \
    POOL_INIT(&(pool).segment,(amount)); \
}
/* INIT_CODEGEN_POOLS: initialises the code-output pools and globals listed above and opens
   'filename' as the assembly or object output. */
void far pascal INIT_CODEGEN_POOLS(char far *filename)
{
    INIT_POOL(CODE_BYTE_POOL_SEG,0);
    INIT_POOL(CODE_FRAGMENT_POOL_SEG,2);
    INIT_POOL(SEG_DATA_BLOCK_POOL_SEG,2);
    INIT_POOL(RELOCATION_POOL_SEG,2);
    INIT_POOL(CODEGEN_UNUSED_POOL_ONE,2);
    INIT_POOL(CODEGEN_UNUSED_POOL_TWO,2);
    INIT_POOL(CODEGEN_UNUSED_POOL_THREE,0);
    INIT_POOL(CODEGEN_UNUSED_POOL_FOUR,0);
    INIT_POOL(CODEGEN_UNUSED_POOL_FIVE,0);
    INIT_POOL(CODEGEN_UNUSED_POOL_SIX,0);
    INIT_POOL(CODEGEN_UNUSED_POOL_SEVEN,0);
    INIT_POOL(CODEGEN_UNUSED_POOL_EIGHT,0);
    INIT_POOL(CODEGEN_UNUSED_POOL_NINE,0);
    INIT_POOL(SEGDEF_POOL_SEG,2);
    INIT_POOL(QUEUED_WORD_POOL_SEG,0);
    DEBUG_TYPE_COUNTER=24;
    RTL_MEMSET(&SEGMENT_LIST_HEAD,0,sizeof(SEGMENT_LIST_HEAD));
    if(OPTION_OBJECT_NAME && (COMPILER_MODE==0 || OPTION_COMPILE_VIA_ASM==0))
        CODE_OUTPUT_FLAGS|=1;
    if(COMPILER_MODE) CREATE_ASM_OUTPUT_FAR(filename);
    else OPEN_OUTPUT_FILE(filename);
}
