/* target: CODE_1_RMAIN13C */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Map of all sources: docs/SOURCE-MAP.md. */
/* Genuine earlier definitions are individually original-proved before this body is released. */
/* context: RVECSET.C */
/* context: RVECGET.C */
/* context: REXIT09F.C */
/* context: RARGV0F0.C */
/* context-helper-entry: RVECSET.C RVECSET */
/* context-helper-entry: RVECGET.C RVECGET */
/* context-helper-entry: RARGV0F0.C RARGV0F0 */
/* context-call: 0xA RVECGET RVECGET_BODY */
/* context-call: 0x21 RVECSET RVECSET_BODY */
/* context-call: 0x52 RVECGET RVECGET_BODY */
/* context-call: 0x69 RVECSET RVECSET_BODY */
/* context-call: 0x71 RVECGET RVECGET_BODY */
/* context-call: 0x88 RVECSET RVECSET_BODY */
/* context-call: 0x9C RARGV0F0 RARGV0F0_BODY */
/* context-call: 0x244 EXIT EXIT_BODY */
/* EXIT's real helper text changes -G policy. Restore the primary's declared
   common policy here; do not rewrite any helper definition. ARGV's inherited
   policy must still be justified by its complete independent helper proof. */
#include "DATA.H"
#include "HEAP.H"
#include "MSG.H"
/* Overview: BCC's main function (RMAIN13C, called by the start-up code with argc and
   argv) and so the top of the whole program. In order it:
   - hooks interrupt 18h, Ctrl-C (23h) and Ctrl-Break (1Bh), saving the old vectors in
     SAVED_INT18_VECTOR etc. for RUN_PROGRAM (RDRV388.C), which restores them around TASM
     and TLINK; reads the date and time once (CURRENT_DATE, CURRENT_TIME, used later for
     __DATE__ and __TIME__ probably) and prints the banner;
   - with no arguments prints the usage text and exits (PRINT_USAGE_AND_EXIT);
   - sizes the far heap (HEAP_SIZE_PARAS; RARGV0F0 lets a -#n argument override it),
     starts the memory manager, expands @response files, reads TURBOC.CFG and all options
     (READ_CONFIG_AND_ARGS in CONFIG.C) and sets up EMS and extended-memory banks;
   - fixes up option results: -o name gets a .obj (or .asm under -S) extension; a -Yo
     (OPTION_LINK_OVERLAY: overlay the files) implies -Y (OPTION_OVERLAY_CODE:
     overlay-ready code); the -I and -L lists, built back to front, are reversed;
   - walks the file arguments: each file is compiled, assembled or noted for the link by
     PROCESS_FILE_ARGUMENT (DRVLINK.C). A -v or -v- between files is applied as it is
     met, so source debugging can be switched per file;
   - runs TLINK (RUN_LINKER), prints the lowest free memory seen during the run
     ("Available memory"), releases the heap banks and exits with 1 if any step failed
     (COMPILE_FAILED).
   The many context lines above record the run-time helpers (vector get/set, exit,
   argv scan) whose code is linked in the same object; they are build information. */
#pragma option -G

typedef char far *FarText;
typedef FarText far *ArgVector;
struct WordPair { unsigned int first,second; };
typedef void far *VectorAddress;
extern VectorAddress SAVED_INT18_VECTOR,SAVED_INT23_VECTOR,SAVED_INT1B_VECTOR;
extern struct WordPair CURRENT_DATE,CURRENT_TIME;
extern char far *OPTION_OBJECT_NAME;
extern unsigned char COMPILER_MODE; extern unsigned char OPTION_SOURCE_DEBUG;
extern signed char OPTION_OVERLAY_CODE,OPTION_COMPILE_VIA_ASM;
/* Address-only references to original handler entries, not owned byte data or
   invented ordinary callback prototypes. Their interrupt contracts are separate. */
extern unsigned char far C0_INT_DISPATCH_HANDLER[];
extern unsigned char far CTRL_C_HANDLER_ENTRY[];
extern unsigned char far CTRL_BREAK_HANDLER_ENTRY[];

extern void far pascal RTL_GETDATE(struct WordPair far *);
extern void far pascal RTL_GETTIME(struct WordPair far *);
extern void far pascal WRITE_STDOUT_STRING(char far *);
extern void far pascal PRINT_USAGE_AND_EXIT(void);
extern void far pascal INIT_MEMORY_MANAGER(void);
/* Return values of the following unaccepted procedures are ignored here;
   physical formal widths/accesses are proved, C return contracts remain advisory. */
extern void far pascal EXPAND_RESPONSE_FILES(int far *,ArgVector far *);
extern void far pascal READ_CONFIG_AND_ARGS(int,ArgVector);
extern void far pascal RUN_LINKER(int,ArgVector);
extern void far pascal FATAL_EXIT(int);
extern void far pascal INIT_EMS_EXT_BANKS(void);
extern char far *far pascal ADD_DEFAULT_EXTENSION(char far *,char far *);
extern void far pascal BCC_REVERSE_PATHS(void);
extern void far pascal PROCESS_FILE_ARGUMENT(char far *);
extern void far pascal APPLY_OPTION(char far *,unsigned int);
extern void far cdecl RTL_DPRINTF(char far *,...);
extern void far pascal SHUTDOWN_HEAP_BANKS(void);

/* The CRT passes exactly argc and a far argv vector. It consumes AX if this
   entry returns, but the observed final EXIT never returns normally. Void is
   an explicit nonreturning-path reconstruction, not a historical main type claim. */
/* The start-up code passes the DOS command line split into argc/argv. Never returns:
   it ends in EXIT. */
static void far cdecl RMAIN13C(int argc,ArgVector argv)
{
    int saved_count;
    ArgVector saved_argv;
    unsigned char saved_option;
    long available;

    SAVED_INT18_VECTOR=RVECGET(0x18);
    RVECSET(0x18,C0_INT_DISPATCH_HANDLER);
    RTL_GETDATE(&CURRENT_DATE);
    RTL_GETTIME(&CURRENT_TIME);
    WRITE_STDOUT_STRING(STR_BORLAND_C_VERSION_2_0);
    if(argc==1) PRINT_USAGE_AND_EXIT();
    SAVED_INT23_VECTOR=RVECGET(0x23);
    RVECSET(0x23,CTRL_C_HANDLER_ENTRY);
    SAVED_INT1B_VECTOR=RVECGET(0x1B);
    RVECSET(0x1B,CTRL_BREAK_HANDLER_ENTRY);
    /* Default heap size: all paragraphs between the heap start and end; -#n replaces it. */
    HEAP_SIZE_PARAS=HEAP_END_SEG-HEAP_START_SEG;
    RARGV0F0(argv);
    INIT_MEMORY_MANAGER();
    EXPAND_RESPONSE_FILES(&argc,&argv);
    READ_CONFIG_AND_ARGS(argc,argv);
    INIT_EMS_EXT_BANKS();
    /* -o name: add the default extension when the name has none (ADD_DEFAULT_EXTENSION adds it
       only then): .asm when compiling to assembly only (-S), else .obj. */
    if(OPTION_OBJECT_NAME)
        OPTION_OBJECT_NAME=ADD_DEFAULT_EXTENSION(OPTION_OBJECT_NAME,
            !OPTION_COMPILE_VIA_ASM && COMPILER_MODE!=0 ? STR_ASM : STR_OBJ);
    if(OPTION_LINK_OVERLAY!=0 && !OPTION_OVERLAY_CODE) OPTION_OVERLAY_CODE=1;
    BCC_REVERSE_PATHS();
    /* Skip the program name and the leading options (already applied by
       READ_CONFIG_AND_ARGS); at least one file name must follow. */
    --argc;
    ++argv;
    while(argc>0 && (**argv=='-' || **argv=='+')) {
        ++argv;
        --argc;
    }
    if(argc==0) FATAL_EXIT(MSG_NO_FILE_NAMES_GIVEN);
    saved_count=argc;
    saved_argv=argv;
    saved_option=OPTION_SOURCE_DEBUG;
    /* Process every file argument in order. Options are skipped except -v, which is
       applied again here so it takes effect for the files after it. */
    while(argc>0) {
        if(**argv!='-') PROCESS_FILE_ARGUMENT(*argv);
        else if((*argv)[1]=='v') APPLY_OPTION(*argv+1,0);
        ++argv;
        --argc;
    }
    /* Back to the -v state set by the leading options, for the link step. RUN_LINKER
       sees the full argument list again (saved_count/saved_argv). */
    OPTION_SOURCE_DEBUG=saved_option;
    RUN_LINKER(saved_count,saved_argv);
    /* Update the low-water mark of free heap once more and print it. */
    available=HEAP_SPACE_BELOW_LIMIT()-HEAP_RESERVE_BYTES;
    if(MIN_FREE_HEAP>available) MIN_FREE_HEAP=available;
    if(MIN_FREE_HEAP<0) MIN_FREE_HEAP=0;
    RTL_DPRINTF(STR_AVAILABLE_MEMORY,MIN_FREE_HEAP);
    SHUTDOWN_HEAP_BANKS();
    EXIT(COMPILE_FAILED!=0);
}
