/* target: ovr151_C220UNIT */
/* Role: per-function back-end driver (GENERATE_FUNCTION_CODE). Entry points:
   GENERATE_FUNCTION_CODE, BACKEND_NOOP_HOOK, LOWER_SWITCHES. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Original CO05B (ovr_1d69_a3c6) as one source. */
/* opts: -mm -O -Z -p -Y -y */
/* Overview: the per-function back-end driver. The statement layer builds a function as a
   list of flow blocks (FLOWBLK.C, STMTBLK.C) holding code ops (CODENODE.C); when the
   function ends, FINISH_FUNCTION_BLOCKS calls GENERATE_FUNCTION_CODE (if there were no
   errors), which runs the back-end passes in order: jump optimisation (with
   OPTIMIZE_ENABLED), start of the code stream, switch lowering (LOWER_SWITCHES here),
   zero-constant simplification, loop-weighted use counts, register variables
   (OPTION_REGISTER_VARS; ASSIGN_REGISTER_VARIABLES runs once with all registers reserved
   to choose candidates and once after allocation), segment mapping, register allocation,
   stack balancing, cross-jumping and redundant-load removal (with OPTIMIZE_ENABLED), frame
   layout, then prologue, body, epilogue and switch tables, and finally jump shortening and
   output, and the variable table is released. The '_STUB' names are the overlay entry
   stubs of the passes. 'value' is the function's closing source position, the file and
   line words FINISH_FUNCTION_BLOCKS passes in, handed on to EMIT_EPILOGUE. */
#include <dos.h>
#include "DATA.H"



/* ---- STAOV06B (listing ovr_1d69_a3c6:3C60) ---- */
void far pascal BACKEND_NOOP_HOOK(void);
void far pascal LOWER_SWITCHES(void);
extern unsigned char OPTION_WINDOWS_MODE;
extern void far pascal RESOLVE_JUMP_TARGETS_STUB(void);
extern void far pascal OPTIMIZE_JUMPS(void);
extern void far pascal BEGIN_CODE_STREAM(void);
extern void far pascal SIMPLIFY_ZERO_CONST_INSNS(void);
extern void far pascal TALLY_WEIGHTED_USES(void);
extern unsigned int far pascal RESERVE_ALL_REGISTERS(void);
extern void far pascal ASSIGN_REGISTER_VARIABLES(void);
extern void far pascal RESTORE_RESERVED_REGISTERS(unsigned int);
extern void far pascal MAP_SEGMENTS_MARK_OPERANDS(void);
extern void far pascal ALLOCATE_REGISTERS(unsigned int);
extern void far pascal RESOLVE_STACK_BALANCE(void);
extern void far pascal CROSS_JUMP_PASS_STUB(void);
extern void far pascal ELIMINATE_REDUNDANT_LOADS(void);
extern void far pascal ASSIGN_LOCAL_OFFSETS(unsigned int,int,unsigned int);
extern void far pascal COMPUTE_PARAMS_SIZE(void);
extern void far pascal EMIT_PROLOGUE(void);
extern void far pascal EMIT_FUNCTION_BODY(void);
extern void far pascal EMIT_EPILOGUE(void far *);
extern void far pascal EMIT_SWITCH_TABLES(void);
extern void far pascal SHRINK_JUMPS_AND_EMIT(void);
extern void far pascal RELEASE_VARIABLE_TABLE(void);
extern void far pascal CLEAR_VARIABLE_TABLE(void);

/* GENERATE_FUNCTION_CODE: generates and outputs the machine code of the current function
   from its flow-block list (CODE_BLOCK_LIST_HEAD); see the overview for the pass order. */
void far pascal GENERATE_FUNCTION_CODE(void far *value)
{
    unsigned int saved;
    register int offset;
    BACKEND_NOOP_HOOK();
    if(OPTIMIZE_ENABLED) {
        RESOLVE_JUMP_TARGETS_STUB();
        OPTIMIZE_JUMPS();
    }
    BEGIN_CODE_STREAM();
    LOWER_SWITCHES();
    if(OPTIMIZE_ENABLED) SIMPLIFY_ZERO_CONST_INSNS();
    TALLY_WEIGHTED_USES();
    if(OPTION_REGISTER_VARS) {
        saved=RESERVE_ALL_REGISTERS();
        ASSIGN_REGISTER_VARIABLES();
        RESTORE_RESERVED_REGISTERS(saved);
    }
    MAP_SEGMENTS_MARK_OPERANDS();
    ALLOCATE_REGISTERS(1);
    if(OPTION_REGISTER_VARS) ASSIGN_REGISTER_VARIABLES();
    RESOLVE_STACK_BALANCE();
    if(OPTIMIZE_ENABLED) {
        CROSS_JUMP_PASS_STUB();
        ELIMINATE_REDUNDANT_LOADS();
    }
    /* Frame layout. In the Windows modes the frame keeps one more word below BP when the
       function's flags ask for it (1 in modes 1, 2, 4; 0x80 in modes 3, 5; probably the
       Windows prologue's saved DS), so locals start at -2. ASSIGN_LOCAL_OFFSETS runs twice
       over the scope tree: first for variables of up to 10 bytes, nearest to BP, then for
       the larger ones below them. Then the parameter block size is computed. */
    if(FUNCTION_OUTER_SCOPE_BLOCK) {
        offset=0;
        if(OPTION_WINDOWS_MODE==1 || OPTION_WINDOWS_MODE==2 || OPTION_WINDOWS_MODE==4) {
            if(CODEGEN_FUNCTION_FLAGS&1) {
                offset=-2;
                /* Preserve this assignment as a separate branch tail. */
                offset=offset;
            }
        } else if(OPTION_WINDOWS_MODE==3 || OPTION_WINDOWS_MODE==5) {
            if(CODEGEN_FUNCTION_FLAGS&0x80) offset=-2;
        }
        ASSIGN_LOCAL_OFFSETS(FUNCTION_OUTER_SCOPE_BLOCK,offset,0);
        ASSIGN_LOCAL_OFFSETS(FUNCTION_OUTER_SCOPE_BLOCK,-FRAME_LOCALS_SIZE,1);
        FRAME_LOCALS_SIZE+=offset;
        COMPUTE_PARAMS_SIZE();
    }
    EMIT_PROLOGUE();
    EMIT_FUNCTION_BODY();
    EMIT_EPILOGUE(value);
    EMIT_SWITCH_TABLES();
    SHRINK_JUMPS_AND_EMIT();
    RELEASE_VARIABLE_TABLE();
    CLEAR_VARIABLE_TABLE();
}

/* ---- BACKEND_NOOP_HOOK (listing ovr_1d69_a3c6:3D80) ---- */
/* BACKEND_NOOP_HOOK: empty; called first by GENERATE_FUNCTION_CODE. */
void far pascal BACKEND_NOOP_HOOK(void)
{
}

/* ---- STAOV06D (listing ovr_1d69_a3c6:3D85) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern void far pascal LOWER_SWITCH(unsigned int node);

/* LOWER_SWITCHES: clears SWITCH_TABLE_LIST and runs LOWER_SWITCH (SWITCH.C) on every
   switch block (kind 4) of the function. The next block is read first (word 6 is
   CNODE_NEXT) because lowering splices new blocks in after the switch block. */
void far pascal LOWER_SWITCHES(void)
{
    register unsigned int node;
    register unsigned int next;

    SWITCH_TABLE_LIST = 0;
    node = CODE_BLOCK_LIST_HEAD;
    while (node != 0) {
        next = ((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node))[6];
        if (*(unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG, node) == 4)
            LOWER_SWITCH(node);
        node = next;
    }
}
