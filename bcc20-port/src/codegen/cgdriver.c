/* cgdriver.c: from bcc20/src/codegen/CGDRIVER.C: the per-function back-end driver.  When a
   function ends, FINISH_FUNCTION_BLOCKS calls GENERATE_FUNCTION_CODE, which runs the
   back-end passes in order: jump optimisation, start of the code stream, switch lowering,
   zero-constant simplification, loop-weighted use counts, register variables (chosen once
   with all registers reserved and once after allocation), segment mapping, register
   allocation, stack balancing, cross-jumping and redundant-load removal, frame layout, then
   prologue, body, epilogue and switch tables, and finally jump shortening and output.
   value is the function's closing source position (file and line words as one far
   pointer argument), handed on to EMIT_EPILOGUE. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "explain.h"

#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)

/* generates and outputs the machine code of the current function from its flow-block
   list */
void GENERATE_FUNCTION_CODE(farptr value)
{
    EXPLAIN("function name=%s", explain_symbol(CODEGEN_FUNCTION_SYMBOL));
    BACKEND_NOOP_HOOK();
    if (OPTIMIZE_ENABLED) {
        RESOLVE_JUMP_TARGETS();
        OPTIMIZE_JUMPS();
    }
    BEGIN_CODE_STREAM();
    LOWER_SWITCHES();
    if (OPTIMIZE_ENABLED)
        SIMPLIFY_ZERO_CONST_INSNS();
    TALLY_WEIGHTED_USES();
    if (OPTION_REGISTER_VARS) {
        u16 saved = RESERVE_ALL_REGISTERS();
        ASSIGN_REGISTER_VARIABLES();
        RESTORE_RESERVED_REGISTERS(saved);
    }
    MAP_SEGMENTS_MARK_OPERANDS();
    ALLOCATE_REGISTERS(1);
    if (OPTION_REGISTER_VARS)
        ASSIGN_REGISTER_VARIABLES();
    RESOLVE_STACK_BALANCE();
    if (OPTIMIZE_ENABLED) {
        CROSS_JUMP_PASS();
        ELIMINATE_REDUNDANT_LOADS();
    }
    /* frame layout: in the Windows modes the frame keeps one more word below BP when the
       function's flags ask for it, so locals start at -2.  ASSIGN_LOCAL_OFFSETS runs twice
       over the scope tree: first for variables of up to 10 bytes, nearest to BP, then for
       the larger ones below them */
    if (FUNCTION_OUTER_SCOPE_BLOCK) {
        i16 offset = 0;
        if (OPTION_WINDOWS_MODE == 1 || OPTION_WINDOWS_MODE == 2 || OPTION_WINDOWS_MODE == 4) {
            if (CODEGEN_FUNCTION_FLAGS & 1)
                offset = -2;
        } else if (OPTION_WINDOWS_MODE == 3 || OPTION_WINDOWS_MODE == 5) {
            if (CODEGEN_FUNCTION_FLAGS & 0x80)
                offset = -2;
        }
        ASSIGN_LOCAL_OFFSETS(FUNCTION_OUTER_SCOPE_BLOCK, (u16)offset, 0);
        ASSIGN_LOCAL_OFFSETS(FUNCTION_OUTER_SCOPE_BLOCK, (u16)-FRAME_LOCALS_SIZE, 1);
        FRAME_LOCALS_SIZE += (u16)offset;
        COMPUTE_PARAMS_SIZE();
    }
    EMIT_PROLOGUE();
    EMIT_FUNCTION_BODY();
    EMIT_EPILOGUE(FP_SEG(value), FP_OFF(value));
    EMIT_SWITCH_TABLES();
    SHRINK_JUMPS_AND_EMIT();
    RELEASE_VARIABLE_TABLE();
    CLEAR_VARIABLE_TABLE();
}

/* empty; called first by GENERATE_FUNCTION_CODE */
void BACKEND_NOOP_HOOK(void)
{
}

/* clears SWITCH_TABLE_LIST and runs LOWER_SWITCH on every switch block (kind 4) of the
   function.  The next block is read first because lowering splices new blocks in after the
   switch block */
void LOWER_SWITCHES(void)
{
    SWITCH_TABLE_LIST = 0;
    for (u16 node = CODE_BLOCK_LIST_HEAD; node != 0;) {
        u16 next = CNODE_W(node, CNODE_NEXT);
        if (CNODE_W(node, CNODE_KIND) == 4)
            LOWER_SWITCH(node);
        node = next;
    }
}
