/* target: ovr162_STAOV0F3 */
/* opts: -mm -G -O -Z -p -Y */
/* Role: code generation: emits a function body block by block (instruction blocks, inline
   asm, scope debug hooks, jumps and returns). Entry points: EMIT_FUNCTION_BODY. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: last step of the per-function back end (called from GENERATE_FUNCTION_CODE,
   CGDRIVER.C, after register allocation and the jump and peephole passes). It walks the
   function's flow-block list from CODE_BLOCK_LIST_HEAD through CNODE_NEXT and, for each
   block, tells the output layer a block starts (BLOCK_START_HOOK), points
   REGISTER_HISTORY_CURSOR at the block's register history, and emits by block kind:
   code blocks (0) through EMIT_BLOCK_INSTRUCTIONS plus the block's closing jump, inline
   assembler blocks (5) through EMIT_ASM_STATEMENT, scope entry (1) and exit (2) blocks as
   debug-information hooks when OPTION_SOURCE_DEBUG is set, and switch blocks (4). Label
   blocks (3) emit nothing here. The EMIT() macro hands the block's jump to BLOCK_JUMP_HOOK
   (jump kind, target block, and a flag that is true for a conditional jump whose block
   has CNODE_FLAGS 0x100, 'jump fixed'). The block pointer lives in _SI for the whole loop;
   the _ES loads and '_AX=_AX' lines are shapes kept for byte matching.
   Field names to watch: a kind 5 block keeps its asm statement at offset 0x12, read here
   through CNODE_SCOPE_INFO, and a jump-table switch block keeps its table record (made by
   LOWER_SWITCH_JUMP_TABLE, SWITCH.C) at offset 0x14, read through CNODE_SCOPE_OWN_REGS;
   both names belong to scope blocks and only share the offset. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "POOL.H"
extern unsigned int FLOW_BLOCK_POOL_SEG;
extern unsigned char OPTION_SOURCE_DEBUG;
extern void (far pascal *BLOCK_START_HOOK)(unsigned int);
extern void (far pascal *BLOCK_JUMP_HOOK)(unsigned int,unsigned int,int);
extern void (far pascal *SCOPE_ENTER_DEBUG_HOOK)(void);
extern void (far pascal *SCOPE_EXIT_DEBUG_HOOK)(unsigned int);
extern void (far pascal *RETURN_BLOCK_WORD20_HOOK)(unsigned int);
extern void near pascal EMIT_BLOCK_INSTRUCTIONS_ENTRY(unsigned int);
extern void far pascal EMIT_ASM_STATEMENT(unsigned int);
extern void far pascal EMIT_INSN_REG_IMM(unsigned int,unsigned char,unsigned int);
#define EMIT() BLOCK_JUMP_HOOK(ES_W(_SI,CNODE_JUMP_KIND),ES_W(_SI,CNODE_TARGET),((ES_W(_SI,CNODE_JUMP_KIND)&0xF8FF)!=1 && (ES_W(_SI,CNODE_FLAGS)&0x100)))

/* EMIT_FUNCTION_BODY: emits the code of the current function, block by block (see the
   overview). Sets OUTER_SCOPE_EXIT_VALUE when the outermost scope closes at the end. */
void far pascal EMIT_FUNCTION_BODY(void)
{
    OUTER_SCOPE_EXIT_VALUE=0;
    for (_SI=CODE_BLOCK_LIST_HEAD;_SI;) {
        BLOCK_START_HOOK(_SI);
        _ES=FLOW_BLOCK_POOL_SEG;
        REGISTER_HISTORY_CURSOR=ES_W(_SI,CNODE_HISTORY);
        if (CTRL_BREAK_SEEN) LINE_HOOK();
        _ES=FLOW_BLOCK_POOL_SEG;
        switch (ES_W(_SI,CNODE_KIND)) {
        case 5:
            EMIT_ASM_STATEMENT(*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,_SI+CNODE_ASM_TEXT)));
            _ES=FLOW_BLOCK_POOL_SEG;
            if (ES_W(_SI,CNODE_JUMP_KIND)&0xF8FF) {
                EMIT();
                /* Keep the callback return register live in this branch. */
                _AX=_AX;
            }
            break;
        case 1:
            if (OPTION_SOURCE_DEBUG) SCOPE_ENTER_DEBUG_HOOK();
            break;
        /* Scope exit. When it is the last block (no next block, or the next is block 2, probably
           the function's return label) its scope value is kept in OUTER_SCOPE_EXIT_VALUE for the
           epilogue instead of going to SCOPE_EXIT_DEBUG_HOOK now. */
        case 2:
            if (OPTION_SOURCE_DEBUG) {
                _ES=FLOW_BLOCK_POOL_SEG;
                _DI=ES_W(_SI,CNODE_NEXT);
                if (!_DI || _DI==2) {
                    _ES=FLOW_BLOCK_POOL_SEG;
                    _BX=ES_W(_SI,CNODE_SCOPE_ENTRY);
                    OUTER_SCOPE_EXIT_VALUE=ES_W(_BX,CNODE_SCOPE_INFO);
                } else {
                    _ES=FLOW_BLOCK_POOL_SEG;
                    _BX=ES_W(_SI,CNODE_SCOPE_ENTRY);
                    SCOPE_EXIT_DEBUG_HOOK(ES_W(_BX,CNODE_SCOPE_INFO));
                }
            }
            break;
        case 0:
            EMIT_BLOCK_INSTRUCTIONS_ENTRY(_SI);
            _ES=FLOW_BLOCK_POOL_SEG;
            if (ES_W(_SI,CNODE_JUMP_KIND)&0xF8FF) {
                EMIT();
                /* Keep the callback return register live in this branch. */
                _AX=_AX;
            }
            break;
        /* Switch block: its selector code, then either a jump table (CNODE_FLAGS 2: emit 0x45
           with register 4 and 1, probably SHL BX,1 to scale the index to words, and let
           RETURN_BLOCK_WORD20_HOOK emit the jump through the table record at offset 0x14)
           or the ordinary closing jump. */
        case 4:
            EMIT_BLOCK_INSTRUCTIONS_ENTRY(_SI);
            _ES=FLOW_BLOCK_POOL_SEG;
            if (ES_W(_SI,CNODE_FLAGS)&2) {
                EMIT_INSN_REG_IMM(0x45,4,1);
                RETURN_BLOCK_WORD20_HOOK(*((unsigned int far *)MK_FP(FLOW_BLOCK_POOL_SEG,_SI+CNODE_SWITCH_TABLE)));
            } else {
                _ES=FLOW_BLOCK_POOL_SEG;
                EMIT();
            }
            break;
        }
        _ES=FLOW_BLOCK_POOL_SEG;
        _SI=ES_W(_SI,CNODE_NEXT);
    }
}
