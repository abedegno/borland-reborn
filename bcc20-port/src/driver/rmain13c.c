/* rmain13c.c: from bcc20/src/driver/RMAIN13C.C and RDRV388.C: BCC's main function
   (RMAIN13C, called by the start-up code with argc and argv), the top of the whole program,
   and RUN_PROGRAM, which runs TASM or TLINK.
   RMAIN13C in order:
   - hooks interrupt 18h, Ctrl-C (23h) and Ctrl-Break (1Bh), saving the old vectors for
     RUN_PROGRAM, which restores them around TASM and TLINK; reads the date and time once
     (CURRENT_DATE, CURRENT_TIME) and prints the banner;
   - with no arguments prints the usage text and exits;
   - sizes the far heap (HEAP_SIZE_PARAS; RARGV0F0 lets a -#n argument override it), starts
     the memory manager, expands @response files, reads TURBOC.CFG and all options and sets
     up EMS and extended-memory banks;
   - fixes up option results: -o name gets a .obj (or .asm under -S) extension; -Yo implies
     -Y; the -I and -L lists, built back to front, are reversed;
   - walks the file arguments: each file is compiled, assembled or noted for the link by
     PROCESS_FILE_ARGUMENT.  A -v or -v- between files is applied as it is met;
   - runs TLINK (RUN_LINKER), prints the lowest free memory seen during the run ("Available
     memory"), releases the heap banks and exits with 1 if any step failed.
   The interrupt handlers BCC installs are code labels of the start-up code and the run-time
   library, named by their place relative to the load segment (symbols.tsv). */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define COMPILER_MODE B(COMPILER_MODE_P)
#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)
#define OPTION_OVERLAY_CODE SB(OPTION_OVERLAY_CODE_P)
#define OPTION_COMPILE_VIA_ASM SB(OPTION_COMPILE_VIA_ASM_P)
#define ENVIRONMENT_SEG W(ENVIRONMENT_SEG_P)
/* a far pointer (RMAIN13C.C), where globals.h reads a word */
#undef OPTION_OBJECT_NAME
#define OPTION_OBJECT_NAME D(OPTION_OBJECT_NAME_P)

/* the vectors BCC replaces at start-up, saved in DGROUP */
#define SAVED_INT23_VECTOR D(DSPTR(0x5C96))
#define SAVED_INT18_VECTOR D(DSPTR(0x5C9A))
#define SAVED_INT1B_VECTOR D(DSPTR(0x5C9E))
/* a code label at seg:off relative to the load segment */
#define CODE_LABEL(seg, off) MK_FP((seg) + (DGROUP - DGROUP_PARA), (off))
#define C0_INT_DISPATCH_HANDLER CODE_LABEL(0x0000, 0x014F)
#define CTRL_C_HANDLER_ENTRY CODE_LABEL(0x0041, 0x0068)
#define CTRL_BREAK_HANDLER_ENTRY CODE_LABEL(0x0041, 0x00D0)

/* the start-up code passes the DOS command line split into argc/argv.  Never returns: it
   ends in EXIT.  argc and argv have their addresses taken (EXPAND_RESPONSE_FILES rewrites
   them), so they live in BCC's frame layout: 0Ch bytes of locals, then the saved BP and
   the return address, then argc at bp+6 and argv at bp+8 */
void RMAIN13C(i16 argc_value, farptr argv_value)
{
    farptr v = scratch_alloc(0x18);
    farptr argc_p = fp_add(v, 0x12), argv_p = fp_add(v, 0x14);
#define argc SW(argc_p)
#define argv D(argv_p)
    argc = argc_value;
    argv = argv_value;
    farptr vector = RVECGET(0x18);
    SAVED_INT18_VECTOR = vector;
    RVECSET(0x18, C0_INT_DISPATCH_HANDLER);
    RTL_GETDATE(CURRENT_DATE_P);
    RTL_GETTIME(CURRENT_TIME_P);
    WRITE_STDOUT_STRING(STR_BORLAND_C_VERSION_2_0_P);
    if (argc == 1)
        PRINT_USAGE_AND_EXIT();
    vector = RVECGET(0x23);
    SAVED_INT23_VECTOR = vector;
    RVECSET(0x23, CTRL_C_HANDLER_ENTRY);
    vector = RVECGET(0x1B);
    SAVED_INT1B_VECTOR = vector;
    RVECSET(0x1B, CTRL_BREAK_HANDLER_ENTRY);
    /* the default heap size: all paragraphs between the heap start and end; -#n replaces
       it */
    HEAP_SIZE_PARAS = HEAP_END_SEG - HEAP_START_SEG;
    RARGV0F0(argv);
    INIT_MEMORY_MANAGER();
    EXPAND_RESPONSE_FILES(argc_p, argv_p);
    READ_CONFIG_AND_ARGS(argc, argv);
    INIT_EMS_EXT_BANKS();
    /* -o name: the default extension added when the name has none: .asm when compiling to
       assembly only (-S), else .obj */
    if (OPTION_OBJECT_NAME) {
        farptr name = ADD_DEFAULT_EXTENSION(OPTION_OBJECT_NAME,
                                            !OPTION_COMPILE_VIA_ASM && COMPILER_MODE != 0 ? STR_ASM_P : STR_OBJ_P);
        OPTION_OBJECT_NAME = name;
    }
    if (OPTION_LINK_OVERLAY != 0 && !OPTION_OVERLAY_CODE)
        OPTION_OVERLAY_CODE = 1;
    BCC_REVERSE_PATHS();
    /* skip the program name and the leading options (already applied); at least one file
       name must follow */
    --argc;
    argv = fp_add(argv, 4);
    while (argc > 0 && (SB(D(argv)) == '-' || SB(D(argv)) == '+')) {
        argv = fp_add(argv, 4);
        --argc;
    }
    if (argc == 0)
        FATAL_EXIT(MSG_NO_FILE_NAMES_GIVEN);
    i16 saved_count = argc;
    farptr saved_argv = argv;
    u8 saved_option = OPTION_SOURCE_DEBUG;
    /* every file argument in order; options are skipped except -v, which is applied again
       here so it takes effect for the files after it */
    for (; argc > 0; argv = fp_add(argv, 4), --argc) {
        if (SB(D(argv)) != '-')
            PROCESS_FILE_ARGUMENT(D(argv));
        else if (SB(fp_add(D(argv), 1)) == 'v')
            APPLY_OPTION(fp_add(D(argv), 1), 0);
    }
    /* back to the -v state set by the leading options, for the link step, which sees the
       full argument list again */
    OPTION_SOURCE_DEBUG = saved_option;
    RUN_LINKER(saved_count, saved_argv);
    i32 available = HEAP_SPACE_BELOW_LIMIT() - HEAP_RESERVE_BYTES;
    if (MIN_FREE_HEAP > available)
        MIN_FREE_HEAP = available;
    if (MIN_FREE_HEAP < 0)
        MIN_FREE_HEAP = 0;
    RTL_DPRINTF(STR_AVAILABLE_MEMORY_P, (long)MIN_FREE_HEAP);
    SHUTDOWN_HEAP_BANKS();
    EXIT(COMPILE_FAILED != 0);
#undef argc
#undef argv
}

/* reports that pathname cannot be run, even past the -g/-j limits, releases the heap banks
   and exits with 1 */
static void cannot_execute(farptr pathname)
{
    OPTION_ERROR_LIMIT = 0;
    OPTION_WARNING_LIMIT = 0;
    REPORT_ERROR(MSG_UNABLE_EXECUTE_COMMAND, pathname);
    SHUTDOWN_HEAP_BANKS();
    EXIT(1);
}

/* RDRV388.C: runs pathname (searched along PATH) with the command tail command, for TASM
   (-B and .ASM files) or TLINK.  On entry command[0] is a spare byte and the text starts at
   command+1; the first byte is filled with the text length, as DOS wants in a command tail.
   Because BCC holds almost all of conventional memory as its far heap, it first shrinks
   that memory and puts back the original DOS vectors for interrupts 1Bh, 23h and 18h, so
   the child sees a normal machine; afterwards BCC's own handlers go back and the heap
   regrows.  Returns the DOS exit status of the child (low byte the child's code, high byte
   how it ended).  The EXEC parameter block (environment, far command tail, two far FCB
   pointers) sits at bp-12h in BCC's frame */
i16 RUN_PROGRAM(farptr pathname, farptr command)
{
    u16 mark = scratch_mark();
    farptr block = scratch_alloc(0x12);
    B(command) = (u8)STRING_LENGTH(fp_add(command, 1));
    RTL_MEMSET(block, 0, 14);
    W(block) = ENVIRONMENT_SEG;
    D(fp_add(block, 2)) = command;
    farptr searched = RTL_SEARCHPATH(pathname);
    if (!searched)
        cannot_execute(pathname);
    SHRINK_MEMORY_FOR_EXEC();
    RVECSET(0x1B, SAVED_INT1B_VECTOR);
    RVECSET(0x23, SAVED_INT23_VECTOR);
    RVECSET(0x18, SAVED_INT18_VECTOR);
    i16 status = RTL_EXEC(searched, 0, block);
    RVECSET(0x18, C0_INT_DISPATCH_HANDLER);
    RVECSET(0x23, CTRL_C_HANDLER_ENTRY);
    RVECSET(0x1B, CTRL_BREAK_HANDLER_ENTRY);
    RESTORE_MEMORY_AFTER_EXEC();
    /* high byte 1: the child ended by Ctrl-C, 2: by a critical error; BCC stops as well */
    if ((status & 0xFF00) == 0x100 || (status & 0xFF00) == 0x200) {
        SHUTDOWN_HEAP_BANKS();
        EXIT(1);
    }
    /* negative: the EXEC call itself failed (not enough memory, bad file) */
    if (status < 0)
        cannot_execute(pathname);
    scratch_release(mark);
    return status;
}
