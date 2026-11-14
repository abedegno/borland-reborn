/* options.c: from bcc20/src/driver/OPTIONS.C: the command-line option machinery and the
   per-file compile entry.
   Options: APPLY_OPTION is called for every option word (without its '-') from the
   configuration file and the command line.  It walks COMMAND_OPTION_TABLE, a table of
   8-byte Option rows (letter, level, near handler, near variable, value) kept in the data
   segment; every row whose letter matches the first character and whose level allows the
   current SESSION_PHASE calls its handler with the rest of the word.  Handlers: on/off
   flags (HANDLE_FLAG_OPTION and its negated twin), fixed values, numbers, strings, warning
   switches (-w), name lists (-T for TASM), -P (C++ and the default extension), -l (linker
   switches), -D/-U macros, -I/-L directories, and EMS/extended-memory limits.  A row with
   HANDLE_SUBTABLE_OPTION points to a second table for two-letter options.  The option bytes
   most rows change lie in OPTION_BLOCK (90h bytes); "-x." keeps one of them past the end of
   the compile (in SAVED_OPTION_BLOCK) and is allowed only inside a compile, probably for
   #pragma option.  The handlers are near code in this module, called through the rows.
   Compile: COMPILE_ONE_FILE compiles one .c/.cpp file with setjmp-style error recovery
   (C45_SETJUMP on ERROR_JUMP_BUFFER).  Fatal errors and the error limit long-jump back with
   code 2.  Code 3 (MODE_FALLBACK(3), raised when inline assembly or a precompiled header
   needs it) restarts the compile writing assembly and running TASM.  Options changed during
   a compile are undone afterwards by copying SAVED_OPTION_BLOCK back.
   Also here: the list of source file names of a compile (RECORD_SOURCE_NAME), the -D macro
   list (ADD/REMOVE_COMMAND_LINE_MACRO, DEFINE_COMMAND_LINE_MACROS) and the include-file
   search (OPEN_INCLUDE_FILE). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "setjump.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define OPTION_FLAGS SB(OPTION_FLAGS_P)
#define HUGE_PTR_AHSHIFT_MODE SB(HUGE_PTR_AHSHIFT_MODE_P)
#define OPTION_COMPILE_VIA_ASM SB(OPTION_COMPILE_VIA_ASM_P)
#define OPTION_WINDOWS_MODE SB(OPTION_WINDOWS_MODE_P)
#define C31_MEMORY_OPTION SB(C31_MEMORY_OPTION_P)
#define COMPILER_MODE B(COMPILER_MODE_P)
#define INIT_OPTION W(INIT_OPTION_P)
#define ERROR_COUNT W(ERROR_COUNT_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define SESSION_PHASE SW(SESSION_PHASE_P)
/* lists and pointers OPTIONS.C declares far (symbols.tsv) */
#define ARGUMENT_LIST D(ARGUMENT_LIST_P)
#define ARGUMENT_LIST_TAIL D(DSPTR(0x2458))
#define COMMAND_OPTION_TABLE FP_OFF(DSPTR(0x177E))
#define DEFINE_LIST_TAIL D(DSPTR(0x8170))
#define DEFINE_LIST_HEAD D(DSPTR(0x8174))
#define INCLUDE_DIR_LIST_P DSPTR(0x8178)
#define INCLUDE_DIR_LIST D(INCLUDE_DIR_LIST_P)
#define SEARCH_LIST D(SEARCH_LIST_P)
#undef INCLUDE_OPTION_TEXT_PTR
#define INCLUDE_OPTION_TEXT_PTR D(INCLUDE_OPTION_TEXT_PTR_P)

/* an option row (a DS offset): letter, level, near handler, near variable, value */
#define ROW_LETTER(o) SB(DSPTR(o))
#define ROW_LEVEL(o) SB(DSPTR((o) + 1))
#define ROW_HANDLER(o) W(DSPTR((o) + 2))
#define ROW_VARIABLE(o) W(DSPTR((o) + 4))
#define ROW_VALUE(o) W(DSPTR((o) + 6))
#define VARIABLE_BYTE(o) SB(DSPTR(ROW_VARIABLE(o)))

#define ISDIGIT(c) (CTYPE(c) & 2)
#define ISALNUM(c) (CTYPE(c) & 14)
#define ISALPHA(c) (CTYPE(c) & 12)
#define ISLOWER(c) (CTYPE(c) & 8)

/* the region marks are one-byte placeholder overlays (CO044, CO051, CO067, CO068); the
   original takes FP_SEG of each, which is its overlay stub segment (load-relative paragraphs
   from BCC.EXE's stub headers, in overlay order after INIT_REGION_START_MARK's at 0CE3h) */
#define STUB_SEG(para) ((u16)((para) + (DGROUP - DGROUP_PARA)))
#define INIT_END_C_START_MARK_SEG STUB_SEG(0x0CEA)
#define CPP_REGION_START_MARK_SEG STUB_SEG(0x0D2D)
#define C_REGION_END_MARK_SEG STUB_SEG(0x0DA0)
#define CPP_REGION_END_MARK_SEG STUB_SEG(0x0DA3)

/* the 90h option bytes copied whole */
static void copy_option_block(farptr to, farptr from) { memmove(at(to), at(from), 0x90); }

/* compiles one source file.  Returns 0 on success, 2 when there were errors or the compile
   was abandoned by a long jump with code 2, 3 when abandoned with code 4.  is_cpp is 1 when
   the file is compiled as C++ (-P given, OPTION_FLAGS bit 0, or the extension is .cpp), and
   then the C++ front end runs (BEGIN_SESSION), else the C front end (COMPILE_C_SOURCE).
   INIT_OPTION gets a new heap owner tag for everything the compile allocates; option_state
   keeps the previous default tag so it can be restored at the end.  ASM_OUTPUT_PATH is the
   output name without extension; when assembly was written PATH_PROCESS(path,1,0) runs TASM
   on it and deletes the .asm file.  The 80-byte path sits at bp-52h in BCC's frame */
i16 COMPILE_ONE_FILE(farptr name)
{
    u16 mark = scratch_mark();
    farptr path = scratch_alloc(0x52);
    FNSPLIT(name, 0, 0, 0, TOKEN_TEXT_BUFFER_P);
    i16 is_cpp = (OPTION_FLAGS & 1) || STRING_COMPARE(TOKEN_TEXT_BUFFER_P, STR_CPP_P) == 0;
    SAVE_MALLOC_POOL_MARK_BODY();
    u8 tag = ALLOCATE_OWNER_TAG();
    INIT_OPTION = (u16)(i16)(i8)tag;
    copy_option_block(SAVED_OPTION_BLOCK_P, OPTION_BLOCK_P);
    HUGE_PTR_AHSHIFT_MODE |= OPTION_WINDOWS_MODE;
    u8 option_state = GET_DEFAULT_OWNER_TAG();
    i16 result = C45_SETJUMP(ERROR_JUMP_BUFFER_P);
    if (result != 0) {
        /* reached through a long jump: every open input file and macro context closed
           first; codes 2 and 4 give up on this file; any other code (3) runs the compile
           again, now writing assembly and assembling it */
        if (CURRENT_FILE_CONTEXT != 0)
            while (POP_INPUT_CONTEXT(1) != 0)
                ;
        if (result == 2 || result == 4) {
            CALL_FAR(FINISH_COMPILATION_HOOK, A16(1));
            RESTORE_MALLOC_POOL_MARK();
            result = result == 2 ? 2 : 3;
        } else {
            CALL_FAR(FINISH_COMPILATION_HOOK, A16(1));
            OPTION_COMPILE_VIA_ASM = 1;
            COMPILER_MODE = 1;
            if (is_cpp)
                BEGIN_SESSION(name);
            else
                COMPILE_C_SOURCE(name);
            if (ERROR_COUNT == 0) {
                CALL_FAR0(BEGIN_BACKEND_OUTPUT_HOOK);
                STRING_COPY(path, MK_FP(STRING_POOL_SEG, ASM_OUTPUT_PATH));
            }
            CALL_FAR(FINISH_COMPILATION_HOOK, A16(ERROR_COUNT));
            if (ERROR_COUNT != 0)
                result = 2;
            else {
                result = 0;
                PATH_PROCESS(path, 1, 0);
            }
        }
    } else {
        /* the first entry: unless a memory limit was given, 100000 bytes of conventional
           memory are kept free (too little is fatal).  The first compile also hands the
           heap the program image between two one-byte placeholder overlays: those that
           bound the C++ region for a C++ compile, those of the C region otherwise */
        if (C31_MEMORY_OPTION == 0 && C31_SET_MEMORY_LIMIT(100000L) < 100000L)
            REPORT_FATAL(MSG_OUT_MEMORY);
        HEAP_RESERVE_BYTES = 100000L - (i32)C31_MEMORY_LIMIT();
        if (COMPILE_FILE_COUNT++ == 0) {
            if (is_cpp)
                ADOPT_EXTERNAL_REGIONS(CPP_REGION_START_MARK_SEG, CPP_REGION_END_MARK_SEG);
            else
                ADOPT_EXTERNAL_REGIONS(INIT_END_C_START_MARK_SEG, C_REGION_END_MARK_SEG);
        }
        if (is_cpp)
            BEGIN_SESSION(name);
        else
            COMPILE_C_SOURCE(name);
        if (ERROR_COUNT == 0) {
            CALL_FAR0(BEGIN_BACKEND_OUTPUT_HOOK);
            STRING_COPY(path, MK_FP(STRING_POOL_SEG, ASM_OUTPUT_PATH));
        }
        CALL_FAR(FINISH_COMPILATION_HOOK, A16(ERROR_COUNT));
        if (ERROR_COUNT != 0)
            result = 2;
        else {
            result = 0;
            if (OPTION_COMPILE_VIA_ASM != 0)
                PATH_PROCESS(path, 1, 0);
        }
    }
    SESSION_PHASE = 0;
    copy_option_block(OPTION_BLOCK_P, SAVED_OPTION_BLOCK_P);
    CURRENT_FILE_NAME = 0;
    CURRENT_LINE = 0;
    SET_DEFAULT_OWNER_TAG(option_state);
    scratch_release(mark);
    return result;
}

/* abandons the current compile: long-jumps to COMPILE_ONE_FILE with code mode (3 to
   restart the compile through the assembler) */
void MODE_FALLBACK(u16 mode)
{
    C45_LONGJUMP(ERROR_JUMP_BUFFER_P, (i16)mode);
}

/* notes CURRENT_FILE_NAME as a source file of this compile, after ADD_PCH_DEPENDENCY.
   Before the back end runs the name is appended to SOURCE_FILE_LIST, a list in the string
   pool (link word, then the text); BEGIN_BACKEND_PHASE later hands the whole list to
   EMIT_DEPENDENCY_HOOK.  Once the back end runs the name goes to EMIT_DEPENDENCY_HOOK at
   once */
void RECORD_SOURCE_NAME(void)
{
#define POOL_WORD(o) W(MK_FP(STRING_POOL_SEG, (o)))
    ADD_PCH_DEPENDENCY();
    if (SESSION_PHASE == 2) {
        STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME));
        CALL_FAR(D(EMIT_DEPENDENCY_HOOK_P), A32(BCC_DEBUG_NAME_P));
        return;
    }
    u16 node = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME)) + 3);
    POOL_WORD(node) = 0;
    STRING_COPY(MK_FP(STRING_POOL_SEG, node + STRPOOL_SRCLIST_NAME), MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME));
    if (SOURCE_FILE_LIST == 0)
        SOURCE_FILE_LIST = node;
    else {
        u16 link = SOURCE_FILE_LIST;
        while (POOL_WORD(link) != 0)
            link = POOL_WORD(link);
        POOL_WORD(link) = node;
    }
#undef POOL_WORD
}

/* the on/off state of all 60 warnings from the defaults kept in WARNING_SWITCH_TABLE (each
   entry 4 bytes: the 3-letter -w code and the default state) */
void RESET_WARNINGS_TO_DEFAULT(void)
{
    for (i16 i = 0; i <= 59; i++)
        WARNING_SWITCH_STATE_AT(i) = WARNING_SWITCH_TABLE_AT(i * 4 + 3);
}

/* the reverse: the current warning states become the defaults, so the -w options from the
   command line and configuration file hold for every file */
void SAVE_WARNINGS_AS_DEFAULT(void)
{
    for (i16 i = 0; i <= 59; i++)
        WARNING_SWITCH_TABLE_AT(i * 4 + 3) = WARNING_SWITCH_STATE_AT(i);
}

/* applies one option word (no leading '-').  Returns nonzero when the option was accepted,
   0 when it is unknown or bad.  pass selects which options act now: FFFFh only -I and -L,
   0 everything except -I and -L, any other value (1, from the configuration file)
   everything; skipped options count as accepted */
i16 APPLY_OPTION(farptr argument, u16 pass)
{
    if (SB(argument) == 'I' || SB(argument) == 'L') {
        if (pass == 0)
            return 1;
    } else if (pass == 0xFFFF)
        return 1;
    return DISPATCH_OPTION_TABLE(COMMAND_OPTION_TABLE, argument);
}

/* runs every row of the table option whose letter is argument[0] and whose level is at
   least SESSION_PHASE (so options with a low level are refused inside a compile).  Returns
   0 as soon as a handler refuses, else 1 if any row matched, 0 if none did */
i16 DISPATCH_OPTION_TABLE(u16 option, farptr argument)
{
    i16 found = 0;
    for (; ROW_HANDLER(option) != 0; option += 8)
        if (ROW_LETTER(option) == SB(argument) && ROW_LEVEL(option) >= SESSION_PHASE) {
            if (!(i16)CALL_NEAR("OPTIONS", ROW_HANDLER(option), A16(option), A32(fp_add(argument, 1))))
                return 0;
            found = 1;
        }
    return found;
}

/* keeps the current value of the row's option byte past the end of the compile (its copy
   in SAVED_OPTION_BLOCK at the same offset) */
static void keep_option_byte(u16 option)
{
    i16 offset = (i16)(ROW_VARIABLE(option) - FP_OFF(OPTION_BLOCK_P));
    SB(fp_add(SAVED_OPTION_BLOCK_P, offset)) = VARIABLE_BYTE(option);
}

/* a byte flag: "x" or "x+" sets it to 1, "x-" to 0, "x." (only inside a compile) keeps the
   current value after the compile.  Anything else is refused */
i16 HANDLE_FLAG_OPTION(u16 option, farptr argument)
{
    switch (SB(argument)) {
    case '-':
        VARIABLE_BYTE(option) = 0;
        break;
    case 0:
    case '+':
        VARIABLE_BYTE(option) = 1;
        break;
    case '.':
        if (SESSION_PHASE == 0)
            return 0;
        keep_option_byte(option);
        break;
    default:
        return 0;
    }
    return 1;
}

/* like HANDLE_FLAG_OPTION for options whose flag means the opposite: "x" or "x+" clears
   the byte, "x-" sets it */
i16 HANDLE_NEGATED_FLAG_OPTION(u16 option, farptr argument)
{
    switch (SB(argument)) {
    case '-':
        VARIABLE_BYTE(option) = 1;
        break;
    case 0:
    case '+':
        VARIABLE_BYTE(option) = 0;
        break;
    default:
        return 0;
    }
    return 1;
}

/* -w options: "-w" / "-w-" turn all warnings on or off; "-wxxx" / "-w-xxx" one warning by
   its 3-letter code; "-w." (inside a compile) all warnings back to their defaults and
   "-w.xxx" one warning back to its default */
i16 HANDLE_WARNING_OPTION(u16 option, farptr argument)
{
    (void)option;
    i8 first = SB(argument);
    i16 value = 0;
    if (SB(argument) == '-')
        argument = fp_add(argument, 1);
    else if (SB(argument) == '.') {
        if (SESSION_PHASE == 0)
            return 0;
        argument = fp_add(argument, 1);
    } else {
        if (SB(argument) == '+')
            argument = fp_add(argument, 1);
        value = 1;
    }
    farptr entry = WARNING_SWITCH_TABLE_P;
    if (SB(argument) == 0) {
        if (first == '.')
            RESET_WARNINGS_TO_DEFAULT();
        else
            for (i16 i = 0; B(entry) != 0; entry = fp_add(entry, 4), i++)
                WARNING_SWITCH_STATE_AT(i) = (u8)value;
    } else
        for (i16 i = 0; B(entry) != 0; entry = fp_add(entry, 4), i++)
            if (SB(argument) == SB(entry) && SB(fp_add(argument, 1)) == SB(fp_add(entry, 1)) &&
                SB(fp_add(argument, 2)) == SB(fp_add(entry, 2)))
                WARNING_SWITCH_STATE_AT(i) = first == '.' ? B(fp_add(entry, 3)) : (u8)value;
    return 1;
}

/* as the "." case of HANDLE_FLAG_OPTION: keeps the current value of the option byte past
   the end of the compile; refused outside a compile */
i16 RESTORE_OPTION_DEFAULT(u16 option, farptr argument)
{
    (void)argument;
    if (SESSION_PHASE == 0)
        return 0;
    keep_option_byte(option);
    return 1;
}

/* for multi-letter options: the row's variable is a second option table, searched with
   the next letter */
i16 HANDLE_SUBTABLE_OPTION(u16 option, farptr argument)
{
    return DISPATCH_OPTION_TABLE(ROW_VARIABLE(option), argument);
}

/* stores the row's fixed value into its byte variable (for example a memory model) */
i16 SET_OPTION_VALUE(u16 option, farptr argument)
{
    (void)argument;
    VARIABLE_BYTE(option) = (i8)ROW_VALUE(option);
    return 1;
}

i16 IGNORE_OPTION(u16 option, farptr argument)
{
    (void)option;
    (void)argument;
    return 1;
}

/* stores a MALLOC copy of the rest of the word into the row's far-pointer variable (file
   and directory names such as -o, -n, -e) */
i16 SET_STRING_OPTION(u16 option, farptr argument)
{
    farptr copy = MALLOC(STRING_LENGTH(argument) + 1);
    STRING_COPY(copy, argument);
    D(DSPTR(ROW_VARIABLE(option))) = copy;
    return 1;
}

/* a decimal number option stored into a byte; refused if not a number or above the row's
   value (the maximum).  The number is converted twice; the first result is only for the
   range check */
i16 SET_BYTE_NUMBER_OPTION(u16 option, farptr argument)
{
    if (!ISDIGIT(SB(argument)))
        return 0;
    u16 number = (u16)RTL_ATOL(argument);
    if (ROW_VALUE(option) < number)
        return 0;
    i32 value = RTL_ATOL(argument);
    VARIABLE_BYTE(option) = (i8)value;
    return 1;
}

/* as SET_BYTE_NUMBER_OPTION, storing into a word */
i16 SET_INT_NUMBER_OPTION(u16 option, farptr argument)
{
    if (!ISDIGIT(SB(argument)))
        return 0;
    u16 number = (u16)RTL_ATOL(argument);
    if (ROW_VALUE(option) < number)
        return 0;
    i32 value = RTL_ATOL(argument);
    W(DSPTR(ROW_VARIABLE(option))) = (u16)value;
    return 1;
}

/* appends the text to ARGUMENT_LIST, the list of extra TASM arguments PATH_PROCESS adds;
   the text "-" alone empties the list.  A node is a far link (4 bytes) and the text, hence
   MALLOC(length+5) */
i16 ADD_NAME_LIST_OPTION(u16 option, farptr argument)
{
    (void)option;
    if (SB(argument) == '-' && SB(fp_add(argument, 1)) == 0) {
        ARGUMENT_LIST = 0;
        return 1;
    }
    farptr entry = MALLOC(STRING_LENGTH(argument) + 5);
    if (ARGUMENT_LIST != 0)
        D(ARGUMENT_LIST_TAIL) = entry;
    else
        ARGUMENT_LIST = entry;
    ARGUMENT_LIST_TAIL = entry;
    D(entry) = 0;
    STRING_COPY(fp_add(entry, 4), argument);
    return 1;
}

/* -P: compile every file as C++ (OPTION_FLAGS=1) with ".cpp" as default extension.  -P-
   turns C++ forcing off.  A following text (-Pext or -P-ext, with or without a leading
   '.') sets the default extension in DEFAULT_SOURCE_EXT, at most 3 characters; an empty
   text leaves just "." */
i16 HANDLE_CPP_EXT_OPTION(u16 option, farptr argument)
{
    (void)option;
    OPTION_FLAGS = 1;
    STRING_COPY(DEFAULT_SOURCE_EXT_P, STR_CPP_P);
    if (SB(argument) == 0)
        return 1;
    if (SB(argument) == '-') {
        OPTION_FLAGS = 0;
        argument = fp_add(argument, 1);
        if (SB(argument) == 0)
            return 1;
    }
    if (SB(argument) == '.')
        argument = fp_add(argument, 1);
    u16 extension = FP_OFF(DEFAULT_SOURCE_EXT_P);
    u16 cursor = extension + 1;
    for (; SB(argument) != 0; argument = fp_add(argument, 1))
        if (cursor < extension + 4)
            B(DSPTR(cursor++)) = B(argument);
    if (cursor == extension + 1)
        cursor--;
    B(DSPTR(cursor)) = 0;
    return 1;
}

/* -l: linker switches for RUN_LINKER.  "-l-" clears them all.  Otherwise each character
   (optionally preceded by '-' to turn it off) sets a flag: LINKER_SWITCH_FLAGS holds 62
   bytes, a..z at 0..25, A..Z at 26..51 and 0..9 at 52..61.  "y?" and "T?" set the /y? and
   /T? flags (LINKER_Y_SWITCH_FLAGS and LINKER_T_SWITCH_FLAGS, indexed by the lower-case
   letter).  Setting /m or /s (map file) clears /x (no map) */
i16 BCC_SET_OPTION_LIBRARY(u16 option, farptr argument)
{
    (void)option;
    if (SB(argument) == '-' && SB(fp_add(argument, 1)) == 0) {
        RTL_MEMSET(LINKER_SWITCH_FLAGS_P, 0, 62);
        RTL_MEMSET(fp_add(LINKER_Y_SWITCH_FLAGS_P, 'a'), 0, 26);
        RTL_MEMSET(fp_add(LINKER_T_SWITCH_FLAGS_P, 'a'), 0, 26);
        return 1;
    }
    for (; SB(argument) != 0; argument = fp_add(argument, 1)) {
        i16 value = 1;
        if (SB(argument) == '-') {
            value = 0;
            argument = fp_add(argument, 1);
        }
        if (!ISALNUM(SB(argument)))
            return 0;
        i16 index;
        if (ISALPHA(SB(argument))) {
            if (SB(argument) == 'y') {
                argument = fp_add(argument, 1);
                if (ISALPHA(SB(argument)))
                    B(fp_add(LINKER_Y_SWITCH_FLAGS_P, (i16)TOLOWER(SB(argument)))) = (u8)value;
                continue;
            }
            if (SB(argument) == 'T') {
                argument = fp_add(argument, 1);
                if (ISALPHA(SB(argument)))
                    B(fp_add(LINKER_T_SWITCH_FLAGS_P, (i16)TOLOWER(SB(argument)))) = (u8)value;
                continue;
            }
            index = SB(argument) - (ISLOWER(SB(argument)) ? 'a' : 'A' - 26);
        } else
            index = SB(argument) + 4;
        B(fp_add(LINKER_SWITCH_FLAGS_P, index)) = (u8)value;
        if (B(fp_add(LINKER_SWITCH_FLAGS_P, 12)) != 0 || B(fp_add(LINKER_SWITCH_FLAGS_P, 18)) != 0)
            B(fp_add(LINKER_SWITCH_FLAGS_P, 23)) = 0;
    }
    return 1;
}

/* -Dname, -Dname=value, several separated by ';' (a backslash protects the next character
   from being taken as a separator).  Each one goes to ADD_COMMAND_LINE_MACRO; a name
   without "=" gets STR_EMPTY_MACRO_VALUE.  The argument text is cut in place */
i16 DEFINE_MACROS_OPTION(u16 option, farptr argument)
{
    (void)option;
    farptr cursor = argument;
    while (SB(cursor) != 0) {
        do {
            if (SB(cursor) == ';') {
                B(cursor) = 0;
                cursor = fp_add(cursor, 1);
                break;
            }
            cursor = fp_add(cursor, SB(cursor) == '\\' && SB(fp_add(cursor, 1)) != 0 ? 2 : 1);
        } while (SB(cursor) != 0);
        farptr value = STR_EMPTY_MACRO_VALUE_P;
        farptr name = argument;
        for (; SB(argument) != 0; argument = fp_add(argument, 1))
            if (SB(argument) == '=') {
                B(argument) = 0;
                argument = fp_add(argument, 1);
                value = argument;
                break;
            }
        ADD_COMMAND_LINE_MACRO(name, value);
        argument = cursor;
    }
    return 1;
}

/* -Uname: removes name from the -D list */
i16 UNDEFINE_MACRO_OPTION(u16 option, farptr argument)
{
    (void)option;
    REMOVE_COMMAND_LINE_MACRO(argument);
    return 1;
}

/* -I dirs: adds the directories to INCLUDE_DIR_LIST and points INCLUDE_OPTION_TEXT_PTR at
   STR_INCLUDE_GIVEN_MARK, probably to note that -I was given */
i16 BCC_SET_OPTION_INCLUDE(u16 option, farptr argument)
{
    (void)option;
    BCC_ADD_PATHS(argument, INCLUDE_DIR_LIST_P);
    INCLUDE_OPTION_TEXT_PTR = STR_INCLUDE_GIVEN_MARK_P;
    return 1;
}

/* -L dirs: adds the directories to SEARCH_LIST, used by FIND_FILE */
i16 BCC_SET_OPTION_LIBRARY_PATH(u16 option, farptr argument)
{
    (void)option;
    BCC_ADD_PATHS(argument, SEARCH_LIST_P);
    return 1;
}

/* splits argument at ';' (in place) and pushes each directory, with a trailing backslash
   added by BCC_COPY_PATH, onto the front of the list at list.  The lists come out
   reversed; BCC_REVERSE_PATHS puts them back in command-line order.  A node is 10 bytes:
   kind word, far next link, far path */
void BCC_ADD_PATHS(farptr argument, farptr list)
{
    farptr cursor = argument;
    while (SB(argument) != 0) {
        while (SB(cursor) != 0 && SB(cursor) != ';')
            cursor = fp_add(cursor, 1);
        if (SB(cursor) != 0) {
            B(cursor) = 0;
            cursor = fp_add(cursor, 1);
        }
        farptr node = MALLOC(10);
        farptr path = BCC_COPY_PATH(argument);
        D(fp_add(node, 6)) = path;
        D(fp_add(node, 2)) = D(list);
        D(list) = node;
        argument = cursor;
    }
}

/* a -D node: far link, the name and 0, then the value followed by the byte FBh and 0 (FBh
   probably marks the end of a macro body as the preprocessor stores it).  A second -D of
   the same name with the same value is ignored; with another value it warns "Redefinition
   of name is not identical" and keeps the first */
void ADD_COMMAND_LINE_MACRO(farptr name, farptr value)
{
    for (farptr node = DEFINE_LIST_HEAD; node != 0; node = D(node)) {
        if (COMPARE_NAME(name, fp_add(node, 4)) != 0)
            continue;
        farptr text = fp_add(node, 4);
        text = fp_add(text, STRING_LENGTH(text) + 1);
        farptr other = value;
        while (SB(text) == SB(other)) {
            text = fp_add(text, 1);
            other = fp_add(other, 1);
        }
        if (B(text) == 0xFB && SB(fp_add(text, 1)) == 0 && SB(other) == 0)
            return;
        REPORT_WARNING(MSG_REDEFINITION_NOT, name);
        return;
    }
    farptr node = MALLOC(STRING_LENGTH(name) + STRING_LENGTH(value) + 7);
    farptr text = fp_add(node, 4);
    STRING_COPY(text, name);
    text = fp_add(text, STRING_LENGTH(text) + 1);
    STRING_COPY(text, value);
    text = fp_add(text, STRING_LENGTH(text));
    B(text) = 0xFB;
    B(fp_add(text, 1)) = 0;
    if (DEFINE_LIST_HEAD != 0)
        D(DEFINE_LIST_TAIL) = node;
    else
        DEFINE_LIST_HEAD = node;
    DEFINE_LIST_TAIL = node;
    D(node) = 0;
}

/* unlinks the first -D node named name, if any; the node is not freed */
void REMOVE_COMMAND_LINE_MACRO(farptr name)
{
    farptr previous = 0;
    for (farptr node = DEFINE_LIST_HEAD; node != 0; node = D(node)) {
        if (COMPARE_NAME(name, fp_add(node, 4)) == 0) {
            if (previous != 0)
                D(previous) = D(node);
            else
                DEFINE_LIST_HEAD = D(node);
            return;
        }
        previous = node;
    }
}

/* the list at list reversed in place (path nodes link through offset 2) */
static void reverse_paths(farptr list)
{
    farptr node = D(list);
    D(list) = 0;
    while (node != 0) {
        farptr next = D(fp_add(node, 2));
        D(fp_add(node, 2)) = D(list);
        D(list) = node;
        node = next;
    }
}

/* reverses INCLUDE_DIR_LIST and SEARCH_LIST in place (see BCC_ADD_PATHS); called once from
   RMAIN13C */
void BCC_REVERSE_PATHS(void)
{
    reverse_paths(INCLUDE_DIR_LIST_P);
    reverse_paths(SEARCH_LIST_P);
}

/* a MALLOC copy of the directory path with a backslash added, unless the path is empty or
   already ends in '/', '\' or ':' */
farptr BCC_COPY_PATH(farptr path)
{
    farptr end = fp_add(path, STRING_LENGTH(path));
    i16 extra = !(end == path || SB(fp_add(end, -1)) == '/' || SB(fp_add(end, -1)) == '\\' ||
                  SB(fp_add(end, -1)) == ':');
    farptr copy = MALLOC(STRING_LENGTH(path) + extra + 1);
    STRING_COPY(copy, path);
    if (extra)
        STRING_APPEND(copy, STR_BACKSLASH_P);
    return copy;
}

/* tries to open name in each -I directory in turn (the name is built in
   TOKEN_TEXT_BUFFER); 1 when one opened, 0 when none did */
i16 OPEN_INCLUDE_FILE(farptr name)
{
    for (farptr node = INCLUDE_DIR_LIST; node != 0; node = D(fp_add(node, 2))) {
        STRING_COPY(TOKEN_TEXT_BUFFER_P, D(fp_add(node, 6)));
        STRING_APPEND(TOKEN_TEXT_BUFFER_P, name);
        if (OPEN_SOURCE_FILE(TOKEN_TEXT_BUFFER_P))
            return 1;
    }
    return 0;
}

/* defines every -D macro in the preprocessor at the start of a compile; the value text
   follows the name's 0 */
void DEFINE_COMMAND_LINE_MACROS(void)
{
    for (farptr node = DEFINE_LIST_HEAD; node != 0; node = D(node)) {
        farptr text = fp_add(node, 4);
        MACRO_DEFINE(text, fp_add(text, STRING_LENGTH(text) + 1), -1, 0);
    }
}

/* EMS use: "-" no EMS (EMS_PAGE_LIMIT -1), empty use all (0), "=n" use n KB, stored in 16
   KB pages rounded up; "=0" means none */
i16 HANDLE_EMS_OPTION(u16 option, farptr argument)
{
    (void)option;
    switch (SB(argument)) {
    case '-':
        EMS_PAGE_LIMIT = -1;
        break;
    case 0:
        EMS_PAGE_LIMIT = 0;
        break;
    case '=': {
        argument = fp_add(argument, 1);
        if (!ISDIGIT(SB(argument)))
            return 0;
        i32 size = RTL_ATOL(argument);
        EMS_PAGE_LIMIT = size != 0 ? (i16)((size + 15) / 16) : -1;
        break;
    }
    default:
        return 0;
    }
    return 1;
}

/* extended memory use: "-" none (EXT_MEMORY_BASE -1), empty all (limit and bank size 0),
   "=n" sets the limit to (n+1024) KB in bytes, probably the top address with the first
   megabyte included; ",m" sets the bank size to m KB (the limit then defaults to 1 MB if it
   was -1).  "=n,m" sets both */
i16 HANDLE_EXT_MEMORY_OPTION(u16 option, farptr argument)
{
    (void)option;
    switch (SB(argument)) {
    case '=':
        argument = fp_add(argument, 1);
        if (ISDIGIT(SB(argument))) {
            EXT_MEMORY_BASE = (RTL_ATOL(argument) + 1024) << 10;
            EXT_MEMORY_BANK_SIZE = 0xFFFFFFFFu;
            while (ISDIGIT(SB(argument)))
                argument = fp_add(argument, 1);
            if (SB(argument) == 0)
                break;
        }
        if (SB(argument) == ',') {
            argument = fp_add(argument, 1);
            if (!ISDIGIT(SB(argument)))
                return 0;
            EXT_MEMORY_BANK_SIZE = (u32)(RTL_ATOL(argument) << 10);
            if (EXT_MEMORY_BASE == -1L)
                EXT_MEMORY_BASE = 0x100000L;
            while (ISDIGIT(SB(argument)))
                argument = fp_add(argument, 1);
            break;
        }
        return 0;
    case '-':
        EXT_MEMORY_BASE = -1L;
        break;
    case 0:
        EXT_MEMORY_BASE = 0;
        EXT_MEMORY_BANK_SIZE = 0;
        break;
    default:
        return 0;
    }
    return 1;
}
