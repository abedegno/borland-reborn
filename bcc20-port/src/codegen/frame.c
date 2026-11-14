/* frame.c: from bcc20/src/codegen/FRAME.C (overlay CO063): function entry and exit code
   and the stack frame layout, called from GENERATE_FUNCTION_CODE: ASSIGN_LOCAL_OFFSETS and
   COMPUTE_PARAMS_SIZE before the body, EMIT_PROLOGUE before EMIT_FUNCTION_BODY,
   EMIT_EPILOGUE after it, and CLEAR_VARIABLE_TABLE at the end.  The frame is the usual BP
   frame: parameters above BP (from PARAM_FRAME_BASE: return address plus
   FRAME_HEADER_SIZE), locals below it (FRAME_LOCALS_SIZE), then saved SI/DI
   (FRAME_PUSHED_REG_BYTES).  The prologue shape depends on the function: interrupt
   functions (CODEGEN_CALL_CONV 4: push all registers, load DS, end with IRET), functions
   that save all registers (CODEGEN_FUNCTION_FLAGS 10h, probably _saveregs: the return value
   is written into the saved AX/DX slots so the pops restore it), Windows functions
   (OPTION_WINDOWS_MODE), and ordinary functions.  A frame is made only when something
   needs BP; CODEGEN_FUNCTION_FLAGS 100h records that it was.
   Function flags: 1 far, 2 load DS with DGROUP (_loadds), 10h save all registers, 20h keep
   AX while loading DS, 40h and 1 select the overlay frame marker, 80h with Windows modes 3
   and 5 (probably exported).  Conventions 2 and 3 pop their parameters with RET n; 2 also
   lays the parameters out in reverse (pascal).
   Registers: 0 AX, 2 DX, 4 BX, 6 CX, 8 SI, 9 DI, 10 BP, 11 SP, 12 ES, 13 DS, 15 SS.
   Instructions, probably: 94h PUSH, 7Fh POP, 9Ch MOV word, 9Bh MOV byte, 28h SUB word,
   59h/5Bh INC/DEC word, 95h LEA, 92h ENTER, 7Eh LEAVE, A1h RETF, A2h RET, A3h IRET, 00h NOP;
   register 14 in ENTER and RET n is a placeholder for the immediate form. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"

#define OPTION_MEMORY_MODEL B(OPTION_MEMORY_MODEL_P)
#define OPTION_WINDOWS_MODE SB(OPTION_WINDOWS_MODE_P)
#define OPTION_SOURCE_DEBUG SB(OPTION_SOURCE_DEBUG_P)
#define COMPILER_MODE SB(COMPILER_MODE_P)
#define OPTION_TARGET_CPU SB(OPTION_TARGET_CPU_P)
#define OPTION_LINE_NUMBERS SB(OPTION_LINE_NUMBERS_P)
#define OPTION_OPTIMIZE_SPEED SB(OPTION_OPTIMIZE_SPEED_P)
#define OPTION_OVERLAY_CODE SB(OPTION_OVERLAY_CODE_P)

#define FLAGS CODEGEN_FUNCTION_FLAGS
#define PUSH(r) EMIT_INSN_REG(0x94, (r))
#define POP(r) EMIT_INSN_REG(0x7F, (r))

static void load_dgroup(u8 reg) { CALL_FAR(EMIT_LOAD_DGROUP_HOOK, A16(reg)); }
static u8 return_kind(void) { return (u8)CALL_FAR(GET_TYPE_KIND_HOOK, A16(CODEGEN_RETURN_TYPE)); }
static u16 size_of_type(u16 type) { return (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(type)); }

/* a far function in the Windows modes that push DS and load it from AX */
static int windows_pushes_ds(void)
{
    return (FLAGS & 1) &&
        (OPTION_WINDOWS_MODE == 1 || OPTION_WINDOWS_MODE == 2 || OPTION_WINDOWS_MODE == 4 ||
         (OPTION_WINDOWS_MODE == 3 && (FLAGS & 0x80)) ||
         (OPTION_WINDOWS_MODE == 5 && (FLAGS & 0x80)));
}

/* the frame part of a Windows prologue: INC BP for a far function, PUSH BP, MOV BP,SP, PUSH
   DS and MOV DS,AX in the modes that load DS from AX, then either the stack check
   (OPTION_STACK_CHECK: MOV AX,locals and a near or far call of N_CHKSTK or F_CHKSTK by
   memory model) or SUB SP,locals; then pushes SI and DI when the function uses them */
void EMIT_FRAME_SETUP(void)
{
    if ((FLAGS & 1) ? 1 : (FRAME_LOCALS_SIZE || CODEGEN_PARAMS_SIZE || (ASM_OUTPUT_FLAGS & 4) ||
                           STACK_BALANCE_NEEDED || OPTION_STANDARD_FRAME)) {
        FRAME_HEADER_SIZE = 2;
        if (FLAGS & 1)
            EMIT_INSN_REG(0x59, 10);
        PUSH(10);
        EMIT_INSN_REG_REG(0x9C, 10, 11);
        if (windows_pushes_ds()) {
            PUSH(13);
            FRAME_PUSHED_REG_BYTES += 2;
            EMIT_INSN_REG_REG(0x9C, 13, 0);
        }
        if (OPTION_STACK_CHECK) {
            u16 text = OPTION_MEMORY_MODEL == 1 || OPTION_MEMORY_MODEL == 3 ?
                FP_OFF(STR_N_CHKSTK_P) : FP_OFF(STR_F_CHKSTK_P);
            u16 name = (u16)CALL_FAR(DECLARE_NAMED_GLOBAL_HOOK, A16(text), A16(1));
            EMIT_INSN_REG_IMM(0x9C, 0, FRAME_LOCALS_SIZE);
            u16 op = (ASM_OUTPUT_FLAGS & 8) ? 0x77 : 0x78;
            u16 label = NEW_VARIABLE_NODE((u8)op, name, 0, 16);
            COP_B(label << 2, COP_REGISTER) = 0xFF;
            EMIT_INSN_NODE(op, label);
        } else if (FRAME_LOCALS_SIZE)
            EMIT_INSN_REG_IMM(0x28, 11, FRAME_LOCALS_SIZE);
        FLAGS |= 0x100;
    } else
        FLAGS &= ~0x100;
    if (CODEGEN_USED_REG_MASK & 0x100) {
        PUSH(8);
        FRAME_PUSHED_REG_BYTES += 2;
    }
    if (CODEGEN_USED_REG_MASK & 0x200) {
        PUSH(9);
        FRAME_PUSHED_REG_BYTES += 2;
    }
}

/* the save-all prologue: every register pushed (SP's slot is only a placeholder), DS loaded
   for _loadds, then MOV BP,SP and SUB SP,locals */
static void save_all_prologue(void)
{
    FRAME_HEADER_SIZE = (FLAGS & 1) ? 20 : 18;
    CODEGEN_USED_REG_MASK |= 0x300;
    PUSH(0); PUSH(6); PUSH(2); PUSH(4); PUSH(11); PUSH(10); PUSH(8); PUSH(9); PUSH(13); PUSH(12);
    if (FLAGS & 2) {
        load_dgroup(10);
        EMIT_INSN_REG_REG(0x9C, 13, 10);
    }
    EMIT_INSN_REG_REG(0x9C, 10, 11);
    if (FRAME_LOCALS_SIZE)
        EMIT_INSN_REG_IMM(0x28, 11, FRAME_LOCALS_SIZE);
    FLAGS |= 0x100;
}

/* what every prologue ends with: the 8087 slots, the parameter offsets, the locals debug
   hook when writing assembler with debug information, the loads of register parameters,
   and FRAME_SYMBOL_MARK_HOOK when a frame was made */
static void prologue_tail(void)
{
    EMIT_SAVED_REG_PUSHES();
    if (FUNCTION_OUTER_SCOPE_BLOCK) {
        ASSIGN_PARAM_OFFSETS();
        if (OPTION_SOURCE_DEBUG && COMPILER_MODE)
            CALL_FAR0(EMIT_LOCALS_DEBUG_HOOK);
        EMIT_REGISTER_PARAM_MOVES();
    }
    if (FLAGS & 0x100)
        CALL_FAR(FRAME_SYMBOL_MARK_HOOK, A16(CODEGEN_FUNCTION_SYMBOL));
}

/* the prologue of a function compiled for Windows (not an interrupt function): for far
   functions first MOV AX,DS; NOP (modes 1, and 3 with flag 80h), MOV AX,SS; NOP (mode 4)
   or a DGROUP load (mode 2, and 5 with flag 80h); then a save-all frame or
   EMIT_FRAME_SETUP */
void EMIT_WINDOWS_PROLOGUE(void)
{
    if (FLAGS & 1) {
        switch (OPTION_WINDOWS_MODE) {
        case 3:
            if ((FLAGS & 0x80) == 0)
                break;
            /* fall through */
        case 1:
            EMIT_INSN_REG_REG(0x9C, 0, 13);
            EMIT_INSN_NO_OPERANDS(0);
            break;
        case 2:
            load_dgroup(0);
            break;
        case 4:
            EMIT_INSN_REG_REG(0x9C, 0, 15);
            EMIT_INSN_NO_OPERANDS(0);
            break;
        case 5:
            if (FLAGS & 0x80)
                load_dgroup(0);
            break;
        }
    }
    if (FLAGS & 0x10)
        save_all_prologue();
    else
        EMIT_FRAME_SETUP();
    prologue_tail();
}

/* RETF or RET, with the parameter size for conventions 2 and 3 */
static void emit_return(u16 op)
{
    if ((CODEGEN_CALL_CONV == 2 || CODEGEN_CALL_CONV == 3) && CODEGEN_PARAMS_SIZE)
        EMIT_INSN_REG_IMM(op, 14, CODEGEN_PARAMS_SIZE);
    else
        EMIT_INSN_NO_OPERANDS(op);
}

/* the save-all epilogue: the return value (AX, and DX for 3- or 4-byte structs, longs and
   far pointers; nothing for floats) is stored into the saved register slots, then every
   register popped (BX twice: the first pop only discards the saved SP), and the return */
static void save_all_epilogue(void)
{
    u16 store = 1;
    switch (return_kind()) {
    case 19:
    case 20: {
        u16 size = size_of_type(CODEGEN_RETURN_TYPE);
        if (size <= 4 && size > 2)
            store |= 4;
        else if (FLAGS & 1)
            store |= 4;
        break;
    }
    case 7: case 8: case 15: case 16:
        store |= 4;
        break;
    case 9: case 10: case 11: case 12:
        store = 0;
        break;
    }
    if (store) {
        EMIT_INSN_STACK_REG(0x9C, FRAME_HEADER_SIZE - 2, 0);
        if (store & 4)
            EMIT_INSN_STACK_REG(0x9C, FRAME_HEADER_SIZE - 4, 2);
    }
    if (FRAME_LOCALS_SIZE)
        EMIT_INSN_REG_REG(0x9C, 11, 10);
    POP(12); POP(13); POP(9); POP(8); POP(10); POP(4); POP(4); POP(2); POP(6); POP(0);
    emit_return((FLAGS & 1) ? 0xA1 : 0xA2);
}

/* the Windows epilogue: save-all functions as above; others pop DI/SI, restore SP with
   LEA SP,[BP-2] and pop DS when DS was pushed, drop the 8087 slots, tear the frame down,
   undo the INC BP and return */
void EMIT_WINDOWS_EPILOGUE(void)
{
    if (FLAGS & 0x10) {
        save_all_epilogue();
        return;
    }
    u16 op = (FLAGS & 1) ? 0xA1 : 0xA2;
    if (CODEGEN_USED_REG_MASK & 0x200)
        POP(9);
    if (CODEGEN_USED_REG_MASK & 0x100)
        POP(8);
    if (windows_pushes_ds()) {
        if (FRAME_LOCALS_SIZE)
            EMIT_INSN_REG_STACK(0x95, 11, (u16)-2);
        POP(13);
        FRAME_LOCALS_SIZE = 0;
    }
    EMIT_SAVED_REG_POPS(EXPR_FLAGS_AT(return_kind()) & 2);
    EMIT_FRAME_TEARDOWN();
    if (FLAGS & 1)
        EMIT_INSN_REG(0x5B, 10);
    emit_return(op);
}

/* the current function's entry code: the start line, the function's label, the outer
   scope's debug hook, then the prologue for its kind.  Ordinary functions: ENTER on a 186
   or better when optimising for size without overlays, else [INC BP for overlays,] PUSH
   BP, MOV BP,SP, SUB SP,locals; then PUSH SI/DI if used, and PUSH DS with a DGROUP load
   into DS for flag 2 or the huge model */
void EMIT_PROLOGUE(void)
{
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE)
        CALL_FAR(LINE_NUMBER_HOOK, A16(FUNCTION_SOURCE_FILE), A16(FUNCTION_START_LINE));
    FRAME_PUSHED_REG_BYTES = 0;
    CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(CODEGEN_FUNCTION_SYMBOL));
    if (FUNCTION_OUTER_SCOPE_BLOCK && OPTION_SOURCE_DEBUG)
        CALL_FAR0(SCOPE_ENTER_DEBUG_HOOK);
    FRAME_HEADER_SIZE = 0;
    CODEGEN_USED_REG_MASK |= FUNCTION_CLAIMED_REG_MASK;
    if (OPTION_WINDOWS_MODE != 0 && CODEGEN_CALL_CONV != 4) {
        EMIT_WINDOWS_PROLOGUE();
        return;
    }
    if (CODEGEN_CALL_CONV == 4) {
        FLAGS |= 1;
        FRAME_HEADER_SIZE = 18;
        CODEGEN_USED_REG_MASK |= 0x300;
        PUSH(0); PUSH(4); PUSH(6); PUSH(2); PUSH(12); PUSH(13); PUSH(8); PUSH(9); PUSH(10);
        load_dgroup(10);
        EMIT_INSN_REG_REG(0x9C, 13, 10);
        if (FRAME_LOCALS_SIZE || CODEGEN_PARAMS_SIZE || STACK_BALANCE_NEEDED || OPTION_STANDARD_FRAME)
            EMIT_INSN_REG_REG(0x9C, 10, 11);
        if (FRAME_LOCALS_SIZE)
            EMIT_INSN_REG_IMM(0x28, 11, FRAME_LOCALS_SIZE);
        FLAGS |= 0x100;
    } else if (FLAGS & 0x10)
        save_all_prologue();
    else {
        if (FRAME_LOCALS_SIZE || CODEGEN_PARAMS_SIZE || (ASM_OUTPUT_FLAGS & 4) || STACK_BALANCE_NEEDED ||
            (OPTION_OVERLAY_CODE && (FLAGS & 1)) || OPTION_STANDARD_FRAME) {
            FRAME_HEADER_SIZE = 2;
            if (OPTION_TARGET_CPU && !OPTION_OPTIMIZE_SPEED && !OPTION_OVERLAY_CODE &&
                FRAME_LOCALS_SIZE > 0)
                EMIT_INSN_REG_IMM(0x92, 14, FRAME_LOCALS_SIZE);
            else {
                if ((OPTION_OVERLAY_CODE == 1 && (FLAGS & 0x40)) ||
                    (OPTION_OVERLAY_CODE == 2 && (FLAGS & 1)))
                    EMIT_INSN_REG(0x59, 10);
                PUSH(10);
                EMIT_INSN_REG_REG(0x9C, 10, 11);
                if (FRAME_LOCALS_SIZE)
                    EMIT_INSN_REG_IMM(0x28, 11, FRAME_LOCALS_SIZE);
            }
            FLAGS |= 0x100;
        } else
            FLAGS &= ~0x100;
        if (CODEGEN_USED_REG_MASK & 0x100) {
            PUSH(8);
            FRAME_PUSHED_REG_BYTES += 2;
        }
        if (CODEGEN_USED_REG_MASK & 0x200) {
            PUSH(9);
            FRAME_PUSHED_REG_BYTES += 2;
        }
        if ((FLAGS & 2) || OPTION_MEMORY_MODEL == 5) {
            PUSH(13);
            FRAME_PUSHED_REG_BYTES += 2;
            if (FLAGS & 0x20) {
                PUSH(0);
                load_dgroup(0);
                EMIT_INSN_REG_REG(0x9C, 13, 0);
                POP(0);
            } else {
                load_dgroup(0);
                EMIT_INSN_REG_REG(0x9C, 13, 0);
            }
        }
    }
    prologue_tail();
}

/* removes the BP frame: LEAVE on a 186 or better, else MOV SP,BP and POP BP when there are
   locals; only POP BP when there was a frame without locals */
void EMIT_FRAME_TEARDOWN(void)
{
    if (FRAME_LOCALS_SIZE) {
        if (OPTION_TARGET_CPU)
            EMIT_INSN_NO_OPERANDS(0x7E);
        else {
            EMIT_INSN_REG_REG(0x9C, 11, 10);
            POP(10);
        }
    } else if (FLAGS & 0x100)
        POP(10);
}

/* the current function's exit code; file and line are the closing source position.
   Interrupt functions pop all registers and IRET; save-all functions as in the Windows
   epilogue; ordinary ones pop DS, DI, SI, drop the 8087 slots, tear the frame down, undo
   the overlay INC BP and return.  Ends the outer scope's debug records and calls
   EPILOGUE_DONE_HOOK */
void EMIT_EPILOGUE(u16 file, u16 line)
{
    if (OPTION_SOURCE_DEBUG || OPTION_LINE_NUMBERS || COMPILER_MODE)
        CALL_FAR(LINE_NUMBER_HOOK, A16(file), A16(line));
    if (OPTION_WINDOWS_MODE && CODEGEN_CALL_CONV != 4)
        EMIT_WINDOWS_EPILOGUE();
    else if (CODEGEN_CALL_CONV == 4) {
        EMIT_SAVED_REG_POPS(EXPR_FLAGS_AT(return_kind()) & 2);
        EMIT_FRAME_TEARDOWN();
        POP(9); POP(8); POP(13); POP(12); POP(2); POP(6); POP(4); POP(0);
        EMIT_INSN_NO_OPERANDS(0xA3);
    } else if (FLAGS & 0x10)
        save_all_epilogue();
    else {
        if ((FLAGS & 2) || OPTION_MEMORY_MODEL == 5)
            POP(13);
        if (CODEGEN_USED_REG_MASK & 0x200)
            POP(9);
        if (CODEGEN_USED_REG_MASK & 0x100)
            POP(8);
        EMIT_SAVED_REG_POPS(EXPR_FLAGS_AT(return_kind()) & 2);
        EMIT_FRAME_TEARDOWN();
        if ((FRAME_LOCALS_SIZE || (FLAGS & 0x100)) &&
            ((OPTION_OVERLAY_CODE == 1 && (FLAGS & 0x40)) ||
             (OPTION_OVERLAY_CODE == 2 && (FLAGS & 1))))
            EMIT_INSN_REG(0x5B, 10);
        emit_return((FLAGS & 1) ? 0xA1 : 0xA2);
    }
    if (FUNCTION_OUTER_SCOPE_BLOCK && OPTION_SOURCE_DEBUG) {
        CALL_FAR(SCOPE_EXIT_DEBUG_HOOK, A16(OUTER_SCOPE_EXIT_VALUE));
        CALL_FAR(SCOPE_EXIT_DEBUG_HOOK, A16(0xFFFE));
    }
    CALL_FAR0(EPILOGUE_DONE_HOOK);
}

/* empties the variable table and clears STACK_BALANCE_NEEDED */
void CLEAR_VARIABLE_TABLE(void)
{
    VARIABLE_TABLE_FREE_LIST = 0;
    VARIABLE_TABLE_END = 2;
    STACK_BALANCE_NEEDED = 0;
}

/* frame offsets (VAR_FRAME_OFFSET, also told to the front end) for the used autos of scope
   node that are not in registers, going down from offset amount.  mode 0 places only
   variables of up to 10 bytes, 1 only bigger ones.  Everything but chars is word-aligned.
   Each nested scope starts again where its parent ended, so sibling scopes share stack
   space.  Sets FRAME_LOCALS_SIZE to the deepest point (rounded to a word) and returns it */
u16 ASSIGN_LOCAL_OFFSETS(u16 node, u16 amount, u16 mode)
{
    u16 needed;
    for (u16 cursor = 2; cursor < VARIABLE_TABLE_END; cursor += 0x1D) {
        if (VAR_W(cursor, VAR_SCOPE_BLOCK) != node || VAR_B(cursor, VAR_SYMBOL_KIND) != 5 ||
            VAR_W(cursor, VAR_USE_COUNT) == 0 || (VAR_B(cursor, VAR_FLAGS) & 2))
            continue;
        if (VAR_B(cursor, VAR_TYPE_KIND) == 0x11) {
            u16 type = (u16)CALL_FAR(TYPE_HOOK, A16(VAR_W(cursor, VAR_SYMBOL)));
            VAR_W(cursor, VAR_TYPE) = type;
        }
        if (VAR_W(cursor, VAR_TYPE) && VAR_B(cursor, VAR_TYPE_KIND) > 0x10)
            needed = size_of_type(VAR_W(cursor, VAR_TYPE));
        else
            needed = (u16)(i16)KIND_SIZE_TABLE_AT(VAR_B(cursor, VAR_TYPE_KIND) * 4);
        if (needed > 10) {
            if (mode == 0)
                continue;
        } else if (mode != 0)
            continue;
        VAR_W(cursor, VAR_FRAME_OFFSET) = amount - needed;
        if (VAR_B(cursor, VAR_TYPE_KIND) > 2)
            VAR_W(cursor, VAR_FRAME_OFFSET) &= ~1;
        if (VAR_W(cursor, VAR_SYMBOL))
            CALL_FAR(SET_SYMBOL_OFFSET_HOOK, A16(VAR_W(cursor, VAR_SYMBOL)), A16(VAR_W(cursor, VAR_FRAME_OFFSET)));
        amount = VAR_W(cursor, VAR_FRAME_OFFSET);
    }
    u16 maximum = (u16)-amount;
    for (u16 child = CNODE_W(node, CNODE_SCOPE_CHILD); child; child = CNODE_W(child, CNODE_SCOPE_SIBLING)) {
        needed = ASSIGN_LOCAL_OFFSETS(child, amount, mode);
        if (needed > maximum)
            maximum = needed;
    }
    FRAME_LOCALS_SIZE = (maximum + 1) & 0xFFFE;
    return maximum;
}

/* the size of parameter item, rounded to a word: small kinds take their promoted size
   (MODE_HOOK), a float parameter of a function without prototype arrives as a double */
static u16 param_size(u16 item)
{
    if (VAR_B(item, VAR_TYPE_KIND) == 9 && CODEGEN_PARAM_LIST == 0)
        return 8;
    u16 type = VAR_W(item, VAR_TYPE);
    if (VAR_B(item, VAR_TYPE_KIND) <= 8)
        type = (u16)CALL_FAR(MODE_HOOK, A16(VAR_B(item, VAR_TYPE_KIND)));
    u16 size = size_of_type(type);
    if (size & 1)
        ++size;
    return size;
}

/* CODEGEN_PARAMS_SIZE = the total size of the parameters */
void COMPUTE_PARAMS_SIZE(void)
{
    u16 total = 0;
    for (u16 item = 2; item < VARIABLE_TABLE_END; item += 0x1D) {
        if (VAR_B(item, VAR_SYMBOL_KIND) != 6)
            continue;
        if (VAR_B(item, VAR_TYPE_KIND) == 9 && CODEGEN_PARAM_LIST == 0)
            total += 8;
        else {
            if (VAR_B(item, VAR_TYPE_KIND) <= 8)
                total += size_of_type((u16)CALL_FAR(MODE_HOOK, A16(VAR_B(item, VAR_TYPE_KIND))));
            else
                total += size_of_type(VAR_W(item, VAR_TYPE));
            if (total & 1)
                total++;
        }
    }
    CODEGEN_PARAMS_SIZE = total;
}

/* each parameter's BP-relative offset: from PARAM_FRAME_BASE (0 for interrupt functions,
   else the return address size plus FRAME_HEADER_SIZE) going up in declaration order, or
   for convention 2 starting at the far end and going down */
void ASSIGN_PARAM_OFFSETS(void)
{
    u16 base;
    if (CODEGEN_CALL_CONV == 4)
        base = 0;
    else
        base = ((FLAGS & 1) ? 4 : 2) + FRAME_HEADER_SIZE;
    PARAM_FRAME_BASE = base;
    u16 position = CODEGEN_CALL_CONV == 2 ? CODEGEN_PARAMS_SIZE : 0;
    for (u16 item = 2; item < VARIABLE_TABLE_END; item += 29) {
        if (VAR_B(item, VAR_SYMBOL_KIND) != 6)
            continue;
        u16 size = param_size(item);
        if (CODEGEN_CALL_CONV == 2)
            position -= size;
        VAR_W(item, VAR_FRAME_OFFSET) = position + base;
        if (VAR_W(item, VAR_SYMBOL))
            CALL_FAR(SET_SYMBOL_OFFSET_HOOK, A16(VAR_W(item, VAR_SYMBOL)), A16(VAR_W(item, VAR_FRAME_OFFSET)));
        if (CODEGEN_CALL_CONV != 2)
            position += size;
    }
}

/* a leaf op of kind for the variable of entry item, with no register */
static u16 leaf(u8 kind, u16 item)
{
    u16 op = NEW_VARIABLE_NODE(kind, VAR_W(item, VAR_SYMBOL), 0, 0);
    COP_B(op << 2, COP_REGISTER) = 0xFF;
    return op;
}

/* at function entry: an unprototyped float parameter, passed as a double, is narrowed in
   place (FLD qword, FSTP dword, FWAIT: 66h, 6Ah, 57h); then every parameter given a
   register is loaded into it from its frame slot (MOV word or byte, or FLD and 6Ah to an
   8087 register for floating ones).  VAR_FLAGS 2 is cleared meanwhile so the operand is
   the memory slot, and set again afterwards */
void EMIT_REGISTER_PARAM_MOVES(void)
{
    for (u16 item = 2; item < VARIABLE_TABLE_END; item += 29) {
        if (VAR_B(item, VAR_SYMBOL_KIND) != 6 || (VAR_B(item, VAR_FLAGS) & 2) ||
            VAR_B(item, VAR_TYPE_KIND) != 9 || CODEGEN_PARAM_LIST != 0)
            continue;
        u16 first = leaf(19, item);
        u16 second = leaf(18, item);
        EMIT_INSN_NODE(0x66, first);
        EMIT_INSN_NODE(0x6A, second);
        EMIT_INSN_NO_OPERANDS(0x57);
    }
    for (u16 item = 2; item < VARIABLE_TABLE_END; item += 29) {
        if (VAR_B(item, VAR_SYMBOL_KIND) != 6 || (VAR_B(item, VAR_FLAGS) & 2) == 0)
            continue;
        u8 selected = VAR_B(item, VAR_REGISTER);
        VAR_B(item, VAR_FLAGS) &= ~2;
        if (EXPR_FLAGS_AT(VAR_B(item, VAR_TYPE_KIND)) & 2) {
            EMIT_INSN_LOCAL(VAR_B(item, VAR_TYPE_KIND) + 0x5C, item);
            EMIT_INSN_REG(0x6A, (u8)(selected + 0xF1));
        } else if (VAR_B(item, VAR_TYPE_KIND) > 2) {
            u16 op = NEW_VARIABLE_NODE(16, VAR_W(item, VAR_SYMBOL), 0, 0);
            OPND_W(op << 2, OPND_VARIABLE) = item;
            COP_B(op << 2, COP_REGISTER) = 0xFF;
            EMIT_INSN_REG_NODE(0x9C, selected, op);
        } else
            EMIT_INSN_REG_NODE(0x9B, selected, leaf(15, item));
        VAR_B(item, VAR_FLAGS) |= 2;
    }
}
