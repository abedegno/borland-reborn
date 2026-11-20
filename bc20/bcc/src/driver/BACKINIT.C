/* target: ovr139_C219UNIT */
/* Role: back end: initialisation and shutdown: owner tags and the code-generation pools
   (code nodes, operands, data bytes, line numbers, variables). Entry points:
   CLEAR_BACKEND_STATE, INIT_BACKEND, SHUT_DOWN_BACKEND. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO052 (ovr_1d32_9d6d) as one source. */
/* opts: -mm -O -Z -p -Y -y */
/* Overview: start and end of the back end for one source file.
   CLEAR_BACKEND_STATE runs early in every compile (from INIT_POOLS_AND_KEYWORDS in
   INITPOOL.C) and zeroes a 0x43-byte block of back-end globals that starts at
   NODE_SERIAL_COUNTER. INIT_BACKEND runs once the front end reaches the back-end phase
   (BEGIN_BACKEND_PHASE in INITPOOL.C): it takes two fresh heap owner tags, makes the
   back-end tag the heap's default owner (SET_DEFAULT_OWNER_TAG, which sets
   HEAP_DEFAULT_OWNER_TAG), sets up the ten back-end pools (flow blocks, case entries,
   code ops and operands, data bytes, live values, register history, line numbers,
   variables and a spare pool) and then calls INIT_CODEGEN_POOLS (codegen/OUTINIT.C).
   SHUT_DOWN_BACKEND is called from END_SESSION; it closes or discards the output file
   and frees every heap node carried by the two tags, which releases all back-end pools
   at once.
   Each pool is a four-word descriptor (segment, step, unit, used); the INIT_POOL macro
   sets its growth step and calls POOL_INIT, which allocates the first segment. */



/* ---- STOVR138 (listing ovr_1d32_9d6d:D6D0) ---- */
#include "RTL.H"
extern unsigned char NODE_SERIAL_COUNTER[0x43];
/* Zeroes the back-end globals laid out from NODE_SERIAL_COUNTER on (0x43 bytes), so
   node serial numbers and related counters start from 0 for each source file. */
void far pascal CLEAR_BACKEND_STATE(void)
{
    RTL_MEMSET(NODE_SERIAL_COUNTER,0,sizeof(NODE_SERIAL_COUNTER));
}

/* ---- STOVR139 (listing ovr_1d32_9d6d:D6E6) ---- */
struct Pool { unsigned int segment,step,unit,used; };
extern unsigned int CURRENT_OWNER_TAG,BACKEND_OWNER_TAG;
extern struct Pool FLOW_BLOCK_POOL_SEG,CASE_ENTRY_POOL_SEG,CODE_OP_POOL_SEG,CODE_OPERAND_POOL_SEG;
extern struct Pool DATA_BYTE_POOL_SEG,LIVE_VALUE_POOL_SEG,REG_HISTORY_POOL_SEG,LINE_NUMBER_POOL_SEG;
extern struct Pool VARIABLE_TABLE_SEG,BACKEND_SPARE_POOL_SEG;
extern signed char far pascal ALLOCATE_OWNER_TAG(void);
extern void far pascal SET_DEFAULT_OWNER_TAG(signed char);
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);
extern void far pascal INIT_CODEGEN_POOLS(char far *);
#define INIT_POOL(pool,amount) { \
    (pool).unit=(pool).step=(amount); \
    (pool).used=0; \
    POOL_INIT(&(pool).segment,(amount)); \
}
/* Sets up the back end for a module. filename is the module's source name (from
   BEGIN_BACKEND_PHASE); it is passed on to INIT_CODEGEN_POOLS. Allocates two owner
   tags: CURRENT_OWNER_TAG and BACKEND_OWNER_TAG. The second becomes the heap's default
   owner, so every later allocation belongs to the back end until it is freed. */
void far pascal INIT_BACKEND(char far *filename)
{
    CURRENT_OWNER_TAG=ALLOCATE_OWNER_TAG();
    BACKEND_OWNER_TAG=ALLOCATE_OWNER_TAG();
    SET_DEFAULT_OWNER_TAG((signed char)BACKEND_OWNER_TAG);
    INIT_POOL(FLOW_BLOCK_POOL_SEG,2);
    INIT_POOL(CASE_ENTRY_POOL_SEG,2);
    INIT_POOL(CODE_OP_POOL_SEG,4);
    INIT_POOL(CODE_OPERAND_POOL_SEG,4);
    INIT_POOL(DATA_BYTE_POOL_SEG,0);
    INIT_POOL(LIVE_VALUE_POOL_SEG,0);
    INIT_POOL(REG_HISTORY_POOL_SEG,0);
    INIT_POOL(LINE_NUMBER_POOL_SEG,0);
    INIT_POOL(VARIABLE_TABLE_SEG,2);
    INIT_POOL(BACKEND_SPARE_POOL_SEG,0);
    INIT_CODEGEN_POOLS(filename);
}
#undef INIT_POOL

/* ---- STOVR140 (listing ovr_1d32_9d6d:D82B) ---- */
extern unsigned int CURRENT_OWNER_TAG,BACKEND_OWNER_TAG;
extern void (far pascal *FINISH_OUTPUT_HOOK)(void);
extern void far pascal FREE_TAG_NODES(unsigned int);
extern void far pascal FREE_OWNER_TAG(unsigned int);
/* Ends the back end. value nonzero means the compile failed: the output file is
   deleted. value zero: FINISH_OUTPUT_HOOK writes the end of the output and the file is
   closed. Then all nodes of both back-end owner tags are freed and the tags released. */
void far pascal SHUT_DOWN_BACKEND(unsigned int value)
{
    if(value) DISCARD_OUTPUT_FILE();
    else { FINISH_OUTPUT_HOOK(); CLOSE_OUTPUT_FILE(); }
    FREE_TAG_NODES(BACKEND_OWNER_TAG);
    FREE_OWNER_TAG(BACKEND_OWNER_TAG);
    FREE_TAG_NODES(CURRENT_OWNER_TAG);
    FREE_OWNER_TAG(CURRENT_OWNER_TAG);
}
