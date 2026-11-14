/* backinit.c: from bcc20/src/driver/BACKINIT.C (overlay CO052) and USAGE.C: the start and
   end of the back end for one source file, and the usage text.
   CLEAR_BACKEND_STATE runs early in every compile and zeroes a 43h-byte block of back-end
   globals that starts at NODE_SERIAL_COUNTER.  INIT_BACKEND runs once the front end reaches
   the back-end phase: it takes two fresh heap owner tags, makes the back-end tag the heap's
   default owner, sets up the ten back-end pools (flow blocks, case entries, code ops and
   operands, data bytes, live values, register history, line numbers, variables and a spare
   pool) and then calls INIT_CODEGEN_POOLS.  SHUT_DOWN_BACKEND closes or discards the output
   file and frees every heap node carried by the two tags, which releases all back-end
   pools at once.  Each pool is a four-word descriptor (segment, step, unit, used). */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "calls.h"

#define CURRENT_OWNER_TAG W(CURRENT_OWNER_TAG_P)

/* USAGE.C: called when BCC is started with no arguments: prints the long usage text that
   begins "Syntax is: BCC [ options ] file[s]" and ends the program with exit status 0 */
void PRINT_USAGE_AND_EXIT(void)
{
    WRITE_STDOUT_STRING(STR_SYNTAX_IS_BCC_OPTIONS_P);
    C0_TERMINATE(0);
}

/* zeroes the back-end globals laid out from NODE_SERIAL_COUNTER on (43h bytes), so node
   serial numbers and related counters start from 0 for each source file */
void CLEAR_BACKEND_STATE(void)
{
    RTL_MEMSET(NODE_SERIAL_COUNTER_P, 0, 0x43);
}

/* a pool descriptor's growth step and unit set to amount, nothing used, and its first
   segment allocated */
static void init_pool(farptr pool, u16 amount)
{
    W(fp_add(pool, 2)) = amount;
    W(fp_add(pool, 4)) = amount;
    W(fp_add(pool, 6)) = 0;
    POOL_INIT(pool, amount);
}

/* sets up the back end for a module.  filename is the module's source name; it is passed
   on to INIT_CODEGEN_POOLS.  Allocates two owner tags: CURRENT_OWNER_TAG and
   BACKEND_OWNER_TAG.  The second becomes the heap's default owner, so every later
   allocation belongs to the back end until it is freed */
void INIT_BACKEND(farptr filename)
{
    u8 tag = ALLOCATE_OWNER_TAG();
    CURRENT_OWNER_TAG = (u16)(i16)(i8)tag;
    tag = ALLOCATE_OWNER_TAG();
    BACKEND_OWNER_TAG = (u16)(i16)(i8)tag;
    SET_DEFAULT_OWNER_TAG((u8)BACKEND_OWNER_TAG);
    init_pool(FLOW_BLOCK_POOL_SEG_P, 2);
    init_pool(CASE_ENTRY_POOL_SEG_P, 2);
    init_pool(CODE_OP_POOL_SEG_P, 4);
    init_pool(CODE_OPERAND_POOL_SEG_P, 4);
    init_pool(DATA_BYTE_POOL_SEG_P, 0);
    init_pool(LIVE_VALUE_POOL_SEG_P, 0);
    init_pool(REG_HISTORY_POOL_SEG_P, 0);
    init_pool(LINE_NUMBER_POOL_SEG_P, 0);
    init_pool(VARIABLE_TABLE_SEG_P, 2);
    init_pool(BACKEND_SPARE_POOL_SEG_P, 0);
    INIT_CODEGEN_POOLS(filename);
}

/* ends the back end.  value nonzero means the compile failed: the output file is deleted.
   value zero: FINISH_OUTPUT_HOOK writes the end of the output and the file is closed.  Then
   all nodes of both back-end owner tags are freed and the tags released */
void SHUT_DOWN_BACKEND(u16 value)
{
    if (value)
        DISCARD_OUTPUT_FILE();
    else {
        CALL_FAR0(FINISH_OUTPUT_HOOK);
        CLOSE_OUTPUT_FILE();
    }
    FREE_TAG_NODES((u8)BACKEND_OWNER_TAG);
    FREE_OWNER_TAG((u8)BACKEND_OWNER_TAG);
    FREE_TAG_NODES((u8)CURRENT_OWNER_TAG);
    FREE_OWNER_TAG((u8)CURRENT_OWNER_TAG);
}
