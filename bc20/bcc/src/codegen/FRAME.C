/* target: ovr159_C207UNIT */
/* Role: prologue/epilogue and frame offsets. Entry points: EMIT_PROLOGUE, EMIT_EPILOGUE,
   CLEAR_VARIABLE_TABLE, ASSIGN_LOCAL_OFFSETS, COMPUTE_PARAMS_SIZE, ASSIGN_PARAM_OFFSETS.
   Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO063 (ovr_1d90_a8f5) as one source. */
/* opts: -mm -G -O -Z -p -Y */
/* Overview: function entry and exit code and the stack frame layout, called from
   GENERATE_FUNCTION_CODE (CGDRIVER.C): ASSIGN_LOCAL_OFFSETS and COMPUTE_PARAMS_SIZE before
   the body, EMIT_PROLOGUE before EMIT_FUNCTION_BODY, EMIT_EPILOGUE after it, and
   CLEAR_VARIABLE_TABLE at the end. The frame is the usual BP frame: parameters above BP
   (from PARAM_FRAME_BASE: return address plus FRAME_HEADER_SIZE), locals below it
   (FRAME_LOCALS_SIZE), then saved SI/DI (FRAME_PUSHED_REG_BYTES). The prologue shape
   depends on the function: interrupt functions (CODEGEN_CALL_CONV 4: push all registers,
   load DS, end with IRET), functions that save all registers (CODEGEN_FUNCTION_FLAGS 0x10,
   probably _saveregs: the return value is written into the saved AX/DX slots so the pops
   restore it), Windows functions (OPTION_WINDOWS_MODE: the exported-function prologue
   with INC BP, 'MOV AX,DS' or 'MOV AX,SS' and a NOP), and ordinary functions. A frame
   is made only when something needs BP (locals, parameters, pushed float arguments, a
   standard-frame option, overlays); CODEGEN_FUNCTION_FLAGS 0x100 records that it was.
   Function flags used: 1 far, 2 load DS with DGROUP (probably _loadds), 0x10 save all
   registers, 0x20 keep AX while loading DS, 0x40 and 1 select the overlay frame marker,
   0x80 used with Windows modes 3 and 5 (probably exported functions). Calling conventions
   2 and 3 pop their parameters with RET n; 2 also lays the parameters out in reverse
   (probably pascal).
   Register numbers: 0 AX, 2 DX, 4 BX, 6 CX, 8 SI, 9 DI, 10 BP, 11 SP, 12 ES, 13 DS, 15 SS,
   as the push order of the interrupt and save-all prologues confirms. Instruction numbers,
   probably: 0x94 PUSH, 0x7F POP, 0x9C MOV word, 0x28 SUB word, 0x59/0x5B INC/DEC word,
   0x95 LEA, 0x92 ENTER, 0x7E LEAVE, 0xA1 RETF, 0xA2 RET, 0xA3 IRET, 0x00 NOP; register 14
   in the ENTER and 'RET n' calls is probably only a placeholder for the immediate form. */
#include <dos.h>
#include "DATA.H"
#include "POOL.H"



/* ---- STAOV0D1 (listing ovr_1d90_a8f5:8F50) ---- */
extern unsigned char OPTION_MEMORY_MODEL;
extern signed char OPTION_WINDOWS_MODE;
extern unsigned int (far pascal *DECLARE_NAMED_GLOBAL_HOOK)(char near *,unsigned int);
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_REG_REG(unsigned int,unsigned char,unsigned char);
extern void far pascal EMIT_INSN_REG_IMM(unsigned int,unsigned char,unsigned int);
extern void far pascal EMIT_INSN_NODE(unsigned int,unsigned int);


/* EMIT_FRAME_SETUP: the frame part of a Windows prologue (from EMIT_WINDOWS_PROLOGUE):
   INC BP for a far function, PUSH BP, MOV BP,SP, PUSH DS and MOV DS,AX in the modes that
   load DS from AX, then either the stack check (OPTION_STACK_CHECK: MOV AX,locals and a
   near or far call of the helper named at DS:5342 or DS:534C, chosen by memory model) or
   SUB SP,locals; then pushes SI and DI when the function uses them. */
static void near pascal EMIT_FRAME_SETUP(void)
{
    register unsigned int name, label;
    if ((CODEGEN_FUNCTION_FLAGS&1) ? 1 : (FRAME_LOCALS_SIZE || CODEGEN_PARAMS_SIZE ||
        (ASM_OUTPUT_FLAGS&4) || STACK_BALANCE_NEEDED || OPTION_STANDARD_FRAME)) {
        FRAME_HEADER_SIZE=2;
        if (CODEGEN_FUNCTION_FLAGS&1) EMIT_INSN_REG(0x59,10);
        EMIT_INSN_REG(0x94,10);
        EMIT_INSN_REG_REG(0x9C,10,11);
        if ((CODEGEN_FUNCTION_FLAGS&1) &&
            (OPTION_WINDOWS_MODE==1 || OPTION_WINDOWS_MODE==2 || OPTION_WINDOWS_MODE==4 ||
             (OPTION_WINDOWS_MODE==3 && (CODEGEN_FUNCTION_FLAGS&0x80)) ||
             (OPTION_WINDOWS_MODE==5 && (CODEGEN_FUNCTION_FLAGS&0x80)))) {
            EMIT_INSN_REG(0x94,13);
            FRAME_PUSHED_REG_BYTES+=2;
            EMIT_INSN_REG_REG(0x9C,13,0);
        }
        if (OPTION_STACK_CHECK) {
            name=DECLARE_NAMED_GLOBAL_HOOK(OPTION_MEMORY_MODEL==1 || OPTION_MEMORY_MODEL==3 ?
                          (char near *)(STR_N_CHKSTK) : (char near *)(STR_F_CHKSTK),1);
            EMIT_INSN_REG_IMM(0x9C,0,FRAME_LOCALS_SIZE);
            if (ASM_OUTPUT_FLAGS&8) {
                label=NEW_VARIABLE_NODE(0x77,name,0,16);
                COP_B(label<<2,COP_REGISTER)=0xFF;
                EMIT_INSN_NODE(0x77,label);
            } else {
                label=NEW_VARIABLE_NODE(0x78,name,0,16);
                COP_B(label<<2,COP_REGISTER)=0xFF;
                EMIT_INSN_NODE(0x78,label);
            }
        } else if (FRAME_LOCALS_SIZE) EMIT_INSN_REG_IMM(0x28,11,FRAME_LOCALS_SIZE);
        CODEGEN_FUNCTION_FLAGS|=0x100;
    } else CODEGEN_FUNCTION_FLAGS&=~0x100;
    if (CODEGEN_USED_REG_MASK&0x100) {
        EMIT_INSN_REG(0x94,8);
        FRAME_PUSHED_REG_BYTES+=2;
    }
    if (CODEGEN_USED_REG_MASK&0x200) {
        EMIT_INSN_REG(0x94,9);
        FRAME_PUSHED_REG_BYTES+=2;
    }
}

/* ---- STAOV0D2 (listing ovr_1d90_a8f5:911E) ---- */
void far pascal ASSIGN_PARAM_OFFSETS(void);
static void near pascal EMIT_REGISTER_PARAM_MOVES(void);
extern signed char OPTION_SOURCE_DEBUG,COMPILER_MODE;
extern void (far pascal *EMIT_LOAD_DGROUP_HOOK)(unsigned char);
extern void (far pascal *EMIT_LOCALS_DEBUG_HOOK)(void);
extern void (far pascal *FRAME_SYMBOL_MARK_HOOK)(unsigned int);
extern void far pascal EMIT_SAVED_REG_PUSHES(void);
extern void far pascal EMIT_INSN_NO_OPERANDS(unsigned int);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_REG_REG(unsigned int,unsigned char,unsigned char);
extern void far pascal EMIT_INSN_REG_IMM(unsigned int,unsigned char,unsigned int);

/* EMIT_WINDOWS_PROLOGUE: prologue of a function compiled for Windows (OPTION_WINDOWS_MODE
   set, not an interrupt function): for far functions first 'MOV AX,DS; NOP' (modes 1, 3
   with flag 0x80), 'MOV AX,SS; NOP' (mode 4) or a DGROUP load (modes 2, 5); then a
   save-all frame or EMIT_FRAME_SETUP; then the 8087 slots, parameter offsets, the locals
   debug hook and the loads of register parameters. */
static void near pascal EMIT_WINDOWS_PROLOGUE(void)
{
    if(CODEGEN_FUNCTION_FLAGS&1) {
        switch((int)OPTION_WINDOWS_MODE) {
        case 3:
            if((CODEGEN_FUNCTION_FLAGS&0x80)==0) break;
        case 1:
            EMIT_INSN_REG_REG(0x9C,0,13);
            EMIT_INSN_NO_OPERANDS(0);
            break;
        case 2:
            EMIT_LOAD_DGROUP_HOOK(0);
            _AX=_AX; /* Keep this callback tail separate from case 5. */
            break;
        case 4:
            EMIT_INSN_REG_REG(0x9C,0,15);
            EMIT_INSN_NO_OPERANDS(0);
            break;
        case 5:
            if(CODEGEN_FUNCTION_FLAGS&0x80) EMIT_LOAD_DGROUP_HOOK(0);
            break;
        }
    }
    if(CODEGEN_FUNCTION_FLAGS&0x10) {
        if(CODEGEN_FUNCTION_FLAGS&1) FRAME_HEADER_SIZE=20;
        else FRAME_HEADER_SIZE=18;
        CODEGEN_USED_REG_MASK|=0x300;
        EMIT_INSN_REG(0x94,0);
        EMIT_INSN_REG(0x94,6);
        EMIT_INSN_REG(0x94,2);
        EMIT_INSN_REG(0x94,4);
        EMIT_INSN_REG(0x94,11);
        EMIT_INSN_REG(0x94,10);
        EMIT_INSN_REG(0x94,8);
        EMIT_INSN_REG(0x94,9);
        EMIT_INSN_REG(0x94,13);
        EMIT_INSN_REG(0x94,12);
        if(CODEGEN_FUNCTION_FLAGS&2) {
            EMIT_LOAD_DGROUP_HOOK(10);
            EMIT_INSN_REG_REG(0x9C,13,10);
        }
        EMIT_INSN_REG_REG(0x9C,10,11);
        if(FRAME_LOCALS_SIZE) EMIT_INSN_REG_IMM(0x28,11,FRAME_LOCALS_SIZE);
        CODEGEN_FUNCTION_FLAGS|=0x100;
    } else EMIT_FRAME_SETUP();
    EMIT_SAVED_REG_PUSHES();
    if(FUNCTION_OUTER_SCOPE_BLOCK) {
        ASSIGN_PARAM_OFFSETS();
        if(OPTION_SOURCE_DEBUG && COMPILER_MODE) EMIT_LOCALS_DEBUG_HOOK();
        EMIT_REGISTER_PARAM_MOVES();
    }
    if(CODEGEN_FUNCTION_FLAGS&0x100) FRAME_SYMBOL_MARK_HOOK(CODEGEN_FUNCTION_SYMBOL);
}

/* ---- STAOV0D3 (listing ovr_1d90_a8f5:92C0) ---- */
static void near pascal EMIT_FRAME_TEARDOWN(void);
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void far pascal EMIT_INSN_STACK_REG(unsigned int,unsigned int,unsigned char);
extern void far pascal EMIT_INSN_NO_OPERANDS(unsigned int);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_REG_REG(unsigned int,unsigned char,unsigned char);
extern void far pascal EMIT_INSN_REG_IMM(unsigned int,unsigned char,unsigned int);
extern void far pascal EMIT_INSN_REG_STACK(unsigned int,unsigned char,int);
extern void far pascal EMIT_SAVED_REG_POPS(unsigned int);
#define EXTRA ((CODEGEN_FUNCTION_FLAGS&1) && (OPTION_WINDOWS_MODE==1 || OPTION_WINDOWS_MODE==2 || OPTION_WINDOWS_MODE==4 || (OPTION_WINDOWS_MODE==3 && (CODEGEN_FUNCTION_FLAGS&0x80)) || (OPTION_WINDOWS_MODE==5 && (CODEGEN_FUNCTION_FLAGS&0x80))))

/* EMIT_WINDOWS_EPILOGUE: the matching epilogue. Save-all functions store the return value
   (AX, and DX for 3- or 4-byte structs, longs and far pointers; not for floats) into the
   saved register slots and pop everything (BX twice: the first pop only discards the
   saved SP). Others pop DI/SI, restore SP with 'LEA SP,[BP-2]' and pop DS when DS was
   pushed, drop the 8087 slots, tear the frame down and undo the INC BP. Both end with
   RETF or RET, with the parameter size for conventions 2 and 3. */
static void near pascal EMIT_WINDOWS_EPILOGUE(void)
{
    if (CODEGEN_FUNCTION_FLAGS&0x10) {
        _SI=1;
        switch (GET_TYPE_KIND_HOOK(CODEGEN_RETURN_TYPE)) {
        case 19: case 20:
            _DI=SIZE_OF_TYPE_CHECKED_HOOK(CODEGEN_RETURN_TYPE);
            if (_DI<=4 && _DI>2) _SI|=4;
            else if (CODEGEN_FUNCTION_FLAGS&1) _SI|=4;
            break;
        case 7: case 8: case 15: case 16:
            _SI|=4;
            break;
        case 9: case 10: case 11: case 12:
            _SI=0;
            break;
        }
        if (_SI) {
            EMIT_INSN_STACK_REG(0x9C,FRAME_HEADER_SIZE-2,0);
            if (_SI&4) EMIT_INSN_STACK_REG(0x9C,FRAME_HEADER_SIZE-4,2);
        }
        if (FRAME_LOCALS_SIZE) EMIT_INSN_REG_REG(0x9C,11,10);
        EMIT_INSN_REG(0x7F,12);
        EMIT_INSN_REG(0x7F,13);
        EMIT_INSN_REG(0x7F,9);
        EMIT_INSN_REG(0x7F,8);
        EMIT_INSN_REG(0x7F,10);
        EMIT_INSN_REG(0x7F,4);
        EMIT_INSN_REG(0x7F,4);
        EMIT_INSN_REG(0x7F,2);
        EMIT_INSN_REG(0x7F,6);
        EMIT_INSN_REG(0x7F,0);
        _DI=(CODEGEN_FUNCTION_FLAGS&1) ? 0xA1:0xA2;
        if ((CODEGEN_CALL_CONV==2 || CODEGEN_CALL_CONV==3) && CODEGEN_PARAMS_SIZE)
            EMIT_INSN_REG_IMM(_DI,14,CODEGEN_PARAMS_SIZE);
        else {
            EMIT_INSN_NO_OPERANDS(_DI);
            /* Keep AX live so this call retains its separate branch tail. */
            _AX=_AX;
        }
    } else {
        _SI=(CODEGEN_FUNCTION_FLAGS&1) ? 0xA1:0xA2;
        if (CODEGEN_USED_REG_MASK&0x200) EMIT_INSN_REG(0x7F,9);
        if (CODEGEN_USED_REG_MASK&0x100) EMIT_INSN_REG(0x7F,8);
        if (EXTRA) {
            if (FRAME_LOCALS_SIZE) EMIT_INSN_REG_STACK(0x95,11,-2);
            EMIT_INSN_REG(0x7F,13);
            FRAME_LOCALS_SIZE=0;
        }
        EMIT_SAVED_REG_POPS(EXPR_FLAGS[GET_TYPE_KIND_HOOK(CODEGEN_RETURN_TYPE)]&2);
        EMIT_FRAME_TEARDOWN();
        if (CODEGEN_FUNCTION_FLAGS&1) EMIT_INSN_REG(0x5B,10);
        if ((CODEGEN_CALL_CONV==2 || CODEGEN_CALL_CONV==3) && CODEGEN_PARAMS_SIZE)
            EMIT_INSN_REG_IMM(_SI,14,CODEGEN_PARAMS_SIZE);
        else EMIT_INSN_NO_OPERANDS(_SI);
    }
}
#undef EXTRA

/* ---- STAOV0D4 (listing ovr_1d90_a8f5:9537) ---- */
extern signed char OPTION_TARGET_CPU,OPTION_SOURCE_DEBUG,OPTION_LINE_NUMBERS,OPTION_OPTIMIZE_SPEED,OPTION_OVERLAY_CODE,COMPILER_MODE;
extern void (far pascal *LINE_NUMBER_HOOK)(unsigned int,unsigned int);
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern void (far pascal *SCOPE_ENTER_DEBUG_HOOK)(void);
extern void (far pascal *EMIT_LOAD_DGROUP_HOOK)(unsigned char);
extern void (far pascal *EMIT_LOCALS_DEBUG_HOOK)(void);
extern void (far pascal *FRAME_SYMBOL_MARK_HOOK)(unsigned int);
extern void far pascal EMIT_SAVED_REG_PUSHES(void);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_REG_IMM(unsigned int,unsigned char,unsigned int);
extern void far pascal EMIT_INSN_REG_REG(unsigned int,unsigned char,unsigned char);
#define OP(r) EMIT_INSN_REG(0x94,(r))

/* EMIT_PROLOGUE: emits the current function's entry code: the start line, the function's
   label (DEFINE_SYMBOL_HERE_HOOK), the outer scope's debug hook, then the prologue for
   its kind (see the overview). Ordinary functions: ENTER on a 186 or better when
   optimising for size without overlays, else [INC BP for overlays,] PUSH BP, MOV BP,SP,
   SUB SP,locals; then PUSH SI/DI if used (CODEGEN_USED_REG_MASK 0x100/0x200), and PUSH DS
   with a DGROUP load into DS for flag 2 or the huge model. Afterwards: the 8087 slots
   (EMIT_SAVED_REG_PUSHES), parameter offsets, the locals debug hook when writing assembler
   with debug information, and the loads of register parameters; FRAME_SYMBOL_MARK_HOOK
   when a frame was made. */
void far pascal EMIT_PROLOGUE(void)
{
    if(OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE)
        LINE_NUMBER_HOOK(FUNCTION_SOURCE_FILE,FUNCTION_START_LINE);
    FRAME_PUSHED_REG_BYTES=0;
    DEFINE_SYMBOL_HERE_HOOK(CODEGEN_FUNCTION_SYMBOL);
    if(FUNCTION_OUTER_SCOPE_BLOCK && OPTION_SOURCE_DEBUG) SCOPE_ENTER_DEBUG_HOOK();
    FRAME_HEADER_SIZE=0;
    CODEGEN_USED_REG_MASK|=FUNCTION_CLAIMED_REG_MASK;
    if(OPTION_WINDOWS_MODE!=0 && CODEGEN_CALL_CONV!=4) {
        EMIT_WINDOWS_PROLOGUE();
        return;
    }
    if(CODEGEN_CALL_CONV==4) {
        CODEGEN_FUNCTION_FLAGS|=1;
        FRAME_HEADER_SIZE=18;
        CODEGEN_USED_REG_MASK|=0x300;
        OP(0); OP(4); OP(6); OP(2); OP(12); OP(13); OP(8); OP(9); OP(10);
        EMIT_LOAD_DGROUP_HOOK(10);
        EMIT_INSN_REG_REG(0x9C,13,10);
        if(FRAME_LOCALS_SIZE || CODEGEN_PARAMS_SIZE || STACK_BALANCE_NEEDED || OPTION_STANDARD_FRAME)
            EMIT_INSN_REG_REG(0x9C,10,11);
        if(FRAME_LOCALS_SIZE) EMIT_INSN_REG_IMM(0x28,11,FRAME_LOCALS_SIZE);
        CODEGEN_FUNCTION_FLAGS|=0x100;
    } else if(CODEGEN_FUNCTION_FLAGS&0x10) {
        if(CODEGEN_FUNCTION_FLAGS&1) FRAME_HEADER_SIZE=20;
        else FRAME_HEADER_SIZE=18;
        CODEGEN_USED_REG_MASK|=0x300;
        OP(0); OP(6); OP(2); OP(4); OP(11); OP(10); OP(8); OP(9); OP(13); OP(12);
        if(CODEGEN_FUNCTION_FLAGS&2) {
            EMIT_LOAD_DGROUP_HOOK(10);
            EMIT_INSN_REG_REG(0x9C,13,10);
        }
        EMIT_INSN_REG_REG(0x9C,10,11);
        if(FRAME_LOCALS_SIZE) EMIT_INSN_REG_IMM(0x28,11,FRAME_LOCALS_SIZE);
        CODEGEN_FUNCTION_FLAGS|=0x100;
    } else {
        if(FRAME_LOCALS_SIZE || CODEGEN_PARAMS_SIZE || (ASM_OUTPUT_FLAGS&4) || STACK_BALANCE_NEEDED ||
           (OPTION_OVERLAY_CODE && (CODEGEN_FUNCTION_FLAGS&1)) || OPTION_STANDARD_FRAME) {
            FRAME_HEADER_SIZE=2;
            if(OPTION_TARGET_CPU && !OPTION_OPTIMIZE_SPEED && !OPTION_OVERLAY_CODE && FRAME_LOCALS_SIZE>0)
                EMIT_INSN_REG_IMM(0x92,14,FRAME_LOCALS_SIZE);
            else {
                if((OPTION_OVERLAY_CODE==1 && (CODEGEN_FUNCTION_FLAGS&0x40)) ||
                   (OPTION_OVERLAY_CODE==2 && (CODEGEN_FUNCTION_FLAGS&1)))
                    EMIT_INSN_REG(0x59,10);
                OP(10);
                EMIT_INSN_REG_REG(0x9C,10,11);
                if(FRAME_LOCALS_SIZE) EMIT_INSN_REG_IMM(0x28,11,FRAME_LOCALS_SIZE);
            }
            CODEGEN_FUNCTION_FLAGS|=0x100;
        } else CODEGEN_FUNCTION_FLAGS&=~0x100;
        if(CODEGEN_USED_REG_MASK&0x100) {
            OP(8);
            FRAME_PUSHED_REG_BYTES+=2;
        }
        if(CODEGEN_USED_REG_MASK&0x200) {
            OP(9);
            FRAME_PUSHED_REG_BYTES+=2;
        }
        if((CODEGEN_FUNCTION_FLAGS&2) || OPTION_MEMORY_MODEL==5) {
            OP(13);
            FRAME_PUSHED_REG_BYTES+=2;
            if(CODEGEN_FUNCTION_FLAGS&0x20) {
                OP(0);
                EMIT_LOAD_DGROUP_HOOK(0);
                EMIT_INSN_REG_REG(0x9C,13,0);
                EMIT_INSN_REG(0x7F,0);
            } else {
                EMIT_LOAD_DGROUP_HOOK(0);
                EMIT_INSN_REG_REG(0x9C,13,0);
            }
        }
    }
    EMIT_SAVED_REG_PUSHES();
    if(FUNCTION_OUTER_SCOPE_BLOCK) {
        ASSIGN_PARAM_OFFSETS();
        if(OPTION_SOURCE_DEBUG && COMPILER_MODE) EMIT_LOCALS_DEBUG_HOOK();
        EMIT_REGISTER_PARAM_MOVES();
    }
    if(CODEGEN_FUNCTION_FLAGS&0x100) FRAME_SYMBOL_MARK_HOOK(CODEGEN_FUNCTION_SYMBOL);
}
#undef OP

/* ---- EMIT_FRAME_TEARDOWN (listing ovr_1d90_a8f5:9915) ---- */
extern void far pascal EMIT_INSN_NO_OPERANDS(unsigned int value);
extern void far pascal EMIT_INSN_REG(unsigned int first, unsigned char second);
extern void far pascal EMIT_INSN_REG_REG(unsigned int first, unsigned char second,
                                    unsigned char third);

/* EMIT_FRAME_TEARDOWN: removes the BP frame: LEAVE on a 186 or better, else MOV SP,BP
   and POP BP when there are locals; only POP BP when there was a frame without locals. */
static void near pascal EMIT_FRAME_TEARDOWN(void)
{
    if (FRAME_LOCALS_SIZE) {
        if (OPTION_TARGET_CPU) {
            EMIT_INSN_NO_OPERANDS(0x7E);
        } else {
            EMIT_INSN_REG_REG(0x9C, 0x0B, 0x0A);
            EMIT_INSN_REG(0x7F, 0x0A);
            _AX = _AX;
        }
    } else if (CODEGEN_FUNCTION_FLAGS & 0x0100) {
        EMIT_INSN_REG(0x7F, 0x0A);
    }
}

/* ---- STAOV0D6 (listing ovr_1d90_a8f5:9966) ---- */
extern unsigned char (far pascal *GET_TYPE_KIND_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void far pascal EMIT_INSN_STACK_REG(unsigned int,unsigned int,unsigned char);
extern void far pascal EMIT_INSN_NO_OPERANDS(unsigned int);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_REG_REG(unsigned int,unsigned char,unsigned char);
extern void far pascal EMIT_INSN_REG_IMM(unsigned int,unsigned char,unsigned int);
extern void far pascal EMIT_INSN_REG_STACK(unsigned int,unsigned char,int);
extern void far pascal EMIT_SAVED_REG_POPS(unsigned int);
extern unsigned char  OPTION_MEMORY_MODEL;
extern void (far pascal *LINE_NUMBER_HOOK)(unsigned int,unsigned int);
extern void (far pascal *SCOPE_EXIT_DEBUG_HOOK)(unsigned int);
extern void (far pascal *EPILOGUE_DONE_HOOK)(void);

/* EMIT_EPILOGUE: emits the current function's exit code; 'first'/'second' are the closing
   source file and line (GENERATE_FUNCTION_CODE passes them as one far-pointer argument).
   Interrupt functions pop all registers and IRET; save-all functions as in
   EMIT_WINDOWS_EPILOGUE; ordinary ones pop DS, DI, SI, drop the 8087 slots, tear the frame
   down, undo the overlay INC BP and return (RETF/RET, 'n' for conventions 2 and 3). Ends
   the outer scope's debug records and calls EPILOGUE_DONE_HOOK. */
void far pascal EMIT_EPILOGUE(unsigned int first,unsigned int second)
{
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE) LINE_NUMBER_HOOK(first,second);
    if (OPTION_WINDOWS_MODE && CODEGEN_CALL_CONV!=4) EMIT_WINDOWS_EPILOGUE();
    else if (CODEGEN_CALL_CONV==4) {
        EMIT_SAVED_REG_POPS(EXPR_FLAGS[GET_TYPE_KIND_HOOK(CODEGEN_RETURN_TYPE)]&2);
        EMIT_FRAME_TEARDOWN();
        EMIT_INSN_REG(0x7F,9);
        EMIT_INSN_REG(0x7F,8);
        EMIT_INSN_REG(0x7F,13);
        EMIT_INSN_REG(0x7F,12);
        EMIT_INSN_REG(0x7F,2);
        EMIT_INSN_REG(0x7F,6);
        EMIT_INSN_REG(0x7F,4);
        EMIT_INSN_REG(0x7F,0);
        EMIT_INSN_NO_OPERANDS(0xA3);
    } else if (CODEGEN_FUNCTION_FLAGS&0x10) {
        _SI=1;
        switch (GET_TYPE_KIND_HOOK(CODEGEN_RETURN_TYPE)) {
        case 19: case 20:
            _DI=SIZE_OF_TYPE_CHECKED_HOOK(CODEGEN_RETURN_TYPE);
            if (_DI<=4 && _DI>2) _SI|=4;
            else if (CODEGEN_FUNCTION_FLAGS&1) _SI|=4;
            break;
        case 7: case 8: case 15: case 16:
            _SI|=4;
            break;
        case 9: case 10: case 11: case 12:
            _SI=0;
            break;
        }
        if (_SI) {
            EMIT_INSN_STACK_REG(0x9C,FRAME_HEADER_SIZE-2,0);
            if (_SI&4) EMIT_INSN_STACK_REG(0x9C,FRAME_HEADER_SIZE-4,2);
        }
        if (FRAME_LOCALS_SIZE) EMIT_INSN_REG_REG(0x9C,11,10);
        EMIT_INSN_REG(0x7F,12);
        EMIT_INSN_REG(0x7F,13);
        EMIT_INSN_REG(0x7F,9);
        EMIT_INSN_REG(0x7F,8);
        EMIT_INSN_REG(0x7F,10);
        EMIT_INSN_REG(0x7F,4);
        EMIT_INSN_REG(0x7F,4);
        EMIT_INSN_REG(0x7F,2);
        EMIT_INSN_REG(0x7F,6);
        EMIT_INSN_REG(0x7F,0);
        _DI=(CODEGEN_FUNCTION_FLAGS&1) ? 0xA1:0xA2;
        if ((CODEGEN_CALL_CONV==2 || CODEGEN_CALL_CONV==3) && CODEGEN_PARAMS_SIZE)
            EMIT_INSN_REG_IMM(_DI,14,CODEGEN_PARAMS_SIZE);
        else {
            EMIT_INSN_NO_OPERANDS(_DI);
            /* Keep AX live so this call retains its separate branch tail. */
            _AX=_AX;
        }
    } else {
        if ((CODEGEN_FUNCTION_FLAGS&2) || OPTION_MEMORY_MODEL==5) EMIT_INSN_REG(0x7F,13);
        if (CODEGEN_USED_REG_MASK&0x200) EMIT_INSN_REG(0x7F,9);
        if (CODEGEN_USED_REG_MASK&0x100) EMIT_INSN_REG(0x7F,8);
        EMIT_SAVED_REG_POPS(EXPR_FLAGS[GET_TYPE_KIND_HOOK(CODEGEN_RETURN_TYPE)]&2);
        EMIT_FRAME_TEARDOWN();
        if ((FRAME_LOCALS_SIZE || (CODEGEN_FUNCTION_FLAGS&0x100)) &&
            ((OPTION_OVERLAY_CODE==1 && (CODEGEN_FUNCTION_FLAGS&0x40)) ||
             (OPTION_OVERLAY_CODE==2 && (CODEGEN_FUNCTION_FLAGS&1)))) EMIT_INSN_REG(0x5B,10);
        _SI=(CODEGEN_FUNCTION_FLAGS&1) ? 0xA1:0xA2;
        if ((CODEGEN_CALL_CONV==2 || CODEGEN_CALL_CONV==3) && CODEGEN_PARAMS_SIZE)
            EMIT_INSN_REG_IMM(_SI,14,CODEGEN_PARAMS_SIZE);
        else EMIT_INSN_NO_OPERANDS(_SI);
    }
    if (FUNCTION_OUTER_SCOPE_BLOCK && OPTION_SOURCE_DEBUG) {
        SCOPE_EXIT_DEBUG_HOOK(OUTER_SCOPE_EXIT_VALUE);
        SCOPE_EXIT_DEBUG_HOOK(0xFFFE);
    }
    EPILOGUE_DONE_HOOK();
}

/* ---- CLEAR_VARIABLE_TABLE (listing ovr_1d90_a8f5:9C9D) ---- */

/* CLEAR_VARIABLE_TABLE: empties the variable table and clears STACK_BALANCE_NEEDED (the
   last step of GENERATE_FUNCTION_CODE). */
void far pascal CLEAR_VARIABLE_TABLE(void)
{
    VARIABLE_TABLE_FREE_LIST = 0;
    VARIABLE_TABLE_END = 2;
    STACK_BALANCE_NEEDED = 0;
}

/* ---- STAOV0D8 (listing ovr_1d90_a8f5:9CB3) ---- */
extern unsigned int FLOW_BLOCK_POOL_SEG; extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int (far pascal *TYPE_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);

/* ASSIGN_LOCAL_OFFSETS: gives frame offsets (VAR_FRAME_OFFSET, also told to the front end
   through SET_SYMBOL_OFFSET_HOOK) to the used autos of scope 'node' that are not in
   registers, going down from offset 'amount'. 'mode' 0 places only variables of up to
   10 bytes, 1 only bigger ones. Everything but chars is word-aligned. Each nested scope
   starts again where its parent ended, so sibling scopes share stack space. Sets
   FRAME_LOCALS_SIZE to the deepest point (rounded to a word) and returns it. */
unsigned int far pascal ASSIGN_LOCAL_OFFSETS(unsigned int node,unsigned int amount,unsigned int mode)
{
    unsigned int child,maximum;
    register unsigned int cursor,needed;
    for(cursor=2;cursor<VARIABLE_TABLE_END;cursor+=0x1D) {
        _ES=VARIABLE_TABLE_SEG;
        if(ES_W(cursor,VAR_SCOPE_BLOCK)!=node) continue;
        _ES=VARIABLE_TABLE_SEG;
        if(ES_B(cursor,VAR_SYMBOL_KIND)!=5) continue;
        _ES=VARIABLE_TABLE_SEG;
        if(ES_W(cursor,VAR_USE_COUNT)==0) continue;
        if(ES_B(cursor,VAR_FLAGS)&2) continue;
        _ES=VARIABLE_TABLE_SEG;
        if(ES_B(cursor,VAR_TYPE_KIND)==0x11) {
            _AX=TYPE_HOOK(ES_W(cursor,VAR_SYMBOL));
            _ES=VARIABLE_TABLE_SEG;
            ES_W(cursor,VAR_TYPE)=_AX;
        }
        _ES=VARIABLE_TABLE_SEG;
        if(ES_W(cursor,VAR_TYPE) && ES_B(cursor,VAR_TYPE_KIND)>0x10)
            needed=SIZE_OF_TYPE_CHECKED_HOOK(ES_W(cursor,VAR_TYPE));
        else {
            _ES=VARIABLE_TABLE_SEG;
            needed=KIND_SIZE_TABLE[ES_B(cursor,VAR_TYPE_KIND)*4];
        }
        if(needed>10) {
            if(mode==0) continue;
        } else if(mode!=0) continue;
        _ES=VARIABLE_TABLE_SEG;
        ES_W(cursor,VAR_FRAME_OFFSET)=amount-needed;
        if(ES_B(cursor,VAR_TYPE_KIND)>2) ES_W(cursor,VAR_FRAME_OFFSET)&=~1;
        _ES=VARIABLE_TABLE_SEG;
        if(ES_W(cursor,VAR_SYMBOL)) SET_SYMBOL_OFFSET_HOOK(ES_W(cursor,VAR_SYMBOL),ES_W(cursor,VAR_FRAME_OFFSET));
        _ES=VARIABLE_TABLE_SEG;
        amount=ES_W(cursor,VAR_FRAME_OFFSET);
    }
    maximum=-amount;
    _BX=node;
    _ES=FLOW_BLOCK_POOL_SEG;
    child=ES_W(_BX,CNODE_SCOPE_CHILD);
    while(child) {
        needed=ASSIGN_LOCAL_OFFSETS(child,amount,mode);
        if(needed>maximum) maximum=needed;
        _BX=child;
        _ES=FLOW_BLOCK_POOL_SEG;
        child=ES_W(_BX,CNODE_SCOPE_SIBLING);
    }
    FRAME_LOCALS_SIZE=(maximum+1)&0xFFFE;
    return maximum;
}

/* ---- COMPUTE_PARAMS_SIZE (listing ovr_1d90_a8f5:9DF2) ---- */
extern unsigned int VARIABLE_TABLE_SEG;

extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);

/* COMPUTE_PARAMS_SIZE: CODEGEN_PARAMS_SIZE = total size of the parameters, each rounded to
   a word: small kinds take their promoted size (MODE_HOOK), a float parameter of a
   function without prototype (no CODEGEN_PARAM_LIST) arrives as a double (8 bytes). */
void far pascal COMPUTE_PARAMS_SIZE(void)
{
    _DI = 0;
    _SI = 2;
    while (_SI < VARIABLE_TABLE_END) {
        _ES = VARIABLE_TABLE_SEG;
        if (*((unsigned char far *)MK_FP(_ES, _SI + VAR_SYMBOL_KIND)) == 6) {
            _ES = VARIABLE_TABLE_SEG;
            if (*((unsigned char far *)MK_FP(_ES, _SI + VAR_TYPE_KIND)) == 9 &&
                CODEGEN_PARAM_LIST == 0) {
                _DI += 8;
            } else {
                _ES = VARIABLE_TABLE_SEG;
                if (*((unsigned char far *)MK_FP(_ES, _SI + VAR_TYPE_KIND)) <= 8)
                    _AX = SIZE_OF_TYPE_CHECKED_HOOK(MODE_HOOK(
                        *((unsigned char far *)MK_FP(_ES, _SI + VAR_TYPE_KIND))));
                else {
                    _ES = VARIABLE_TABLE_SEG;
                    _AX = SIZE_OF_TYPE_CHECKED_HOOK(*((unsigned int far *)MK_FP(_ES, _SI + VAR_TYPE)));
                }
                _DI += _AX;
                if (_DI & 1)
                    _DI++;
            }
        }
        _SI += 0x1D;
    }
    CODEGEN_PARAMS_SIZE = _DI;
}

/* ---- ASSIGN_PARAM_OFFSETS (listing ovr_1d90_a8f5:9E5F) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_OFFSET_HOOK)(unsigned int,unsigned int);

/* ASSIGN_PARAM_OFFSETS: gives each parameter its BP-relative offset: from PARAM_FRAME_BASE
   (0 for interrupt functions, else the return address size plus FRAME_HEADER_SIZE) going
   up in declaration order, or for convention 2 starting at the far end and going down. */
void far pascal ASSIGN_PARAM_OFFSETS(void)
{
    unsigned int type,position,base;
    register unsigned int item;
    register unsigned int size;
    if (CODEGEN_CALL_CONV==4) base=0;
    else {
        if (CODEGEN_FUNCTION_FLAGS&1) base=4;
        else base=2;
        base+=FRAME_HEADER_SIZE;
    }
    PARAM_FRAME_BASE=base;
    if (CODEGEN_CALL_CONV==2) position=CODEGEN_PARAMS_SIZE;
    else position=0;
    for (item=2;item<VARIABLE_TABLE_END;item+=29) {
        if (VAR_B(item,VAR_SYMBOL_KIND)!=6) continue;
        type=VAR_W(item,VAR_TYPE);
        if (VAR_B(item,VAR_TYPE_KIND)==9 && CODEGEN_PARAM_LIST==0) size=8;
        else {
            if (VAR_B(item,VAR_TYPE_KIND)<=8) type=MODE_HOOK(VAR_B(item,VAR_TYPE_KIND));
            size=SIZE_OF_TYPE_CHECKED_HOOK(type);
            if (size&1) ++size;
        }
        if (CODEGEN_CALL_CONV==2) {
            position-=size;
            VAR_W(item,VAR_FRAME_OFFSET)=position+base;
            if (VAR_W(item,VAR_SYMBOL)) SET_SYMBOL_OFFSET_HOOK(VAR_W(item,VAR_SYMBOL),VAR_W(item,VAR_FRAME_OFFSET));
        } else {
            VAR_W(item,VAR_FRAME_OFFSET)=position+base;
            if (VAR_W(item,VAR_SYMBOL)) SET_SYMBOL_OFFSET_HOOK(VAR_W(item,VAR_SYMBOL),VAR_W(item,VAR_FRAME_OFFSET));
            position+=size;
        }
    }
}

/* ---- EMIT_REGISTER_PARAM_MOVES (listing ovr_1d90_a8f5:9F63) ---- */
extern unsigned int VARIABLE_TABLE_SEG;
extern unsigned int far pascal NEW_VARIABLE_NODE(unsigned int,unsigned int,unsigned int,unsigned char);
extern void far pascal EMIT_INSN_NODE(unsigned int,unsigned int);
extern void far pascal EMIT_INSN_NO_OPERANDS(unsigned int);
extern void far pascal EMIT_INSN_REG(unsigned int,unsigned char);
extern void far pascal EMIT_INSN_LOCAL(unsigned int,unsigned int);
extern void far pascal EMIT_INSN_REG_NODE(unsigned int,unsigned char,unsigned int);

/* EMIT_REGISTER_PARAM_MOVES: at function entry: an unprototyped float parameter, passed
   as a double, is narrowed in place (FLD qword, FSTP dword, FWAIT: ops 0x66, 0x6A, 0x57);
   then every parameter given a register is loaded into it from its frame slot (MOV word
   or byte, or FLD and op 0x6A to an 8087 register for floating ones). VAR_FLAGS 2 is
   cleared meanwhile so the operand is the memory slot, and set again afterwards. */
static void near pascal EMIT_REGISTER_PARAM_MOVES(void)
{
    unsigned int first,index;
    unsigned char selected;
    for (_SI=2;_SI<VARIABLE_TABLE_END;_SI+=29) {
        _ES=VARIABLE_TABLE_SEG;
        if (ES_B(_SI,VAR_SYMBOL_KIND)!=6) continue;
        _ES=VARIABLE_TABLE_SEG;
        if (ES_B(_SI,VAR_FLAGS)&2) continue;
        _ES=VARIABLE_TABLE_SEG;
        if (ES_B(_SI,VAR_TYPE_KIND)!=9 || CODEGEN_PARAM_LIST!=0) continue;
        first=NEW_VARIABLE_NODE(19,ES_W(_SI,VAR_SYMBOL),0,0);
        _BX=first;
        _BX<<=2;
        _ES=CODE_OP_POOL_SEG;
        ES_B(_BX,COP_REGISTER)=0xFF;
        _DI=NEW_VARIABLE_NODE(18,*((unsigned int far *)MK_FP(VARIABLE_TABLE_SEG,_SI)),0,0);
        _BX=_DI;
        _BX<<=2;
        _ES=CODE_OP_POOL_SEG;
        ES_B(_BX,COP_REGISTER)=0xFF;
        EMIT_INSN_NODE(0x66,first);
        EMIT_INSN_NODE(0x6A,_DI);
        EMIT_INSN_NO_OPERANDS(0x57);
    }
    for (_SI=2;_SI<VARIABLE_TABLE_END;_SI+=29) {
        _ES=VARIABLE_TABLE_SEG;
        if (ES_B(_SI,VAR_SYMBOL_KIND)!=6) continue;
        _ES=VARIABLE_TABLE_SEG;
        if ((ES_B(_SI,VAR_FLAGS)&2)==0) continue;
        _ES=VARIABLE_TABLE_SEG;
        selected=ES_B(_SI,VAR_REGISTER);
        ES_B(_SI,VAR_FLAGS)&=~2;
        if (EXPR_FLAGS[ES_B(_SI,VAR_TYPE_KIND)]&2) {
            EMIT_INSN_LOCAL(ES_B(_SI,VAR_TYPE_KIND)+0x5C,_SI);
            EMIT_INSN_REG(0x6A,selected+0xF1);
        } else {
            _ES=VARIABLE_TABLE_SEG;
            if (ES_B(_SI,VAR_TYPE_KIND)>2) {
                _DI=NEW_VARIABLE_NODE(16,ES_W(_SI,VAR_SYMBOL),0,0);
                _AX<<=2;
                index=_AX;
                _ES=CODE_OPERAND_POOL_SEG;
                _BX=index;
                ES_W(_BX,OPND_VARIABLE)=_SI;
                _ES=CODE_OP_POOL_SEG;
                ES_B(_BX,COP_REGISTER)=0xFF;
                EMIT_INSN_REG_NODE(0x9C,selected,_DI);
            } else {
                _DI=NEW_VARIABLE_NODE(15,*((unsigned int far *)MK_FP(VARIABLE_TABLE_SEG,_SI)),0,0);
                _BX=_DI;
                _BX<<=2;
                _ES=CODE_OP_POOL_SEG;
                ES_B(_BX,COP_REGISTER)=0xFF;
                EMIT_INSN_REG_NODE(0x9B,selected,_DI);
            }
        }
        _ES=VARIABLE_TABLE_SEG;
        ES_B(_SI,VAR_FLAGS)|=2;
    }
}
