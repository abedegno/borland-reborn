/* target: CPPMAIN */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module CPPMAIN (image 0x343..0x54C, frame 0034h): CPP's main function and
   the small driver helpers around it, one source file compiled by BC 2.0.
   CPP.EXE edit: BCC.EXE builds the same code from five files (rtl/RCTRL23.C,
   driver/RMAIN13C.C, rtl/RPUTS.C, driver/USAGE.C, rtl/RSTRLOW.C; RCTRL23 went through
   TASM for its `asm stc`, USAGE was compiled with -G-). In CPP.EXE they are one file:
   - main calls PRINT_USAGE_AND_EXIT with a plain near call (E8, `call 01C5h`) and that
     function returns with a near `ret`: a near static of main's own file;
   - PRINT_USAGE_AND_EXIT calls WRITE_STDOUT_STRING as `push cs; call near`, the
     compiler's call to a far function defined earlier in the same file, while main,
     which comes before WRITE_STDOUT_STRING, calls it far (9A) through its prototype;
   - main installs RCTRL23 as the INT 23h handler with `push cs; mov ax,3`: the
     segment is CS, no relocation, so RCTRL23 is in main's own segment and file;
   - the MZ relocations of the frame form one descending run (0x534..0x348), as the
     compiler writes them, with no TASM (ascending) part; so RCTRL23's carry flag is set
     with __emit__ here, not with inline assembly.
   RTL_STRUPR has no call linking it to the others; it is kept in the file because it
   shares the frame and the descending run and compiles the same with BC 2.0.
   The CPP strings (banner, usage text, ".i") are CPP's own; see the names below. */
#include "DATA.H"
#include "HEAP.H"
#include "MSG.H"
#include <dos.h>

typedef char far *FarText;
typedef FarText far *ArgVector;
struct WordPair { unsigned int first,second; };
typedef void far *VectorAddress;
extern VectorAddress SAVED_INT18_VECTOR,SAVED_INT23_VECTOR;
extern struct WordPair CURRENT_DATE,CURRENT_TIME;
extern char far *OPTION_OBJECT_NAME;
/* CPP.EXE's own strings (DS:0022 banner, DS:0085 usage text, DS:0365 ".i"). */
extern char STR_BORLAND_CPP_VERSION_2_0[];
extern char STR_SYNTAX_IS_CPP_OPTIONS[];
extern char STR_OUTPUT_EXT_I[];
/* Address-only reference to the start-up code's INT handler (0000:00CC). */
extern unsigned char far C0_INT_DISPATCH_HANDLER[];

extern VectorAddress far pascal RTL_GETVECT(int);
extern void far pascal RTL_SETVECT(int,VectorAddress);
extern void far pascal RTL_GETDATE(struct WordPair far *);
extern void far pascal RTL_GETTIME(struct WordPair far *);
extern void far pascal DISCARD_OUTPUT_FILE(void);
extern void far pascal SHUTDOWN_HEAP_BANKS(void);
extern void far pascal INIT_MEMORY_MANAGER(void);
extern void far pascal EXPAND_RESPONSE_FILES(int far *,ArgVector far *);
extern void far pascal READ_CONFIG_AND_ARGS(int,ArgVector);
extern void far pascal FATAL_EXIT(int);
extern char far *far pascal ADD_DEFAULT_EXTENSION(char far *,char far *);
extern void far pascal BCC_REVERSE_PATHS(void);
extern void far pascal PROCESS_FILE_ARGUMENT(char far *);
extern void far cdecl RTL_DPRINTF(char far *,...);
extern void far pascal WRITE_STDOUT_STRING(char far *);
extern unsigned int far pascal STRING_LENGTH(char far *);
extern int far pascal RTL_WRITE(unsigned int,char far *,unsigned int);
extern unsigned int far pascal RTL_TOUPPER(int);
/* The start-up code's cdecl exit (0000:00B1); CPP calls it where BCC calls pascal EXIT. */
extern void far cdecl exit(int status);

static void near pascal PRINT_USAGE_AND_EXIT(void);

/* rtl/RCTRL23.C: the Ctrl-C handler. Returns far with the carry flag set, which DOS
   takes as "abort the program".
   CPP.EXE edit: CPP hooks only INT 18h and INT 23h (no INT 1Bh), so only INT 18h is put
   back here; RTL_SETVECT is called directly (BCC: its static RVECSET wrapper); the carry
   is set with __emit__ (stc, F9h), since the file was not assembled through TASM. */
static void far pascal _loadds RCTRL23(void)
{
    RTL_SETVECT(0x18,SAVED_INT18_VECTOR);
    DISCARD_OUTPUT_FILE();
    SHUTDOWN_HEAP_BANKS();
    __emit__((char)0xF9);   /* stc */
}

/* driver/RMAIN13C.C: the start-up code passes the DOS command line split into
   argc/argv. Never returns: it ends in exit.
   CPP.EXE edit: a preprocessor's driver. No INT 1Bh hook, no far-heap -#n override
   (RARGV0F0), no EMS/extended bank set-up call, -o always gets ".i", no -Yo/-Y fix-up,
   no -v handling between files and no link step; the low-water mark is
   HEAP_SPACE_BELOW_LIMIT() alone (no HEAP_RESERVE_BYTES) and is not clamped at 0.
   Called far from C0 (0000:00A9) as cdecl with argc and argv: named main here. */
void far cdecl main(int argc,ArgVector argv)
{
    long available;

    SAVED_INT18_VECTOR=RTL_GETVECT(0x18);
    RTL_SETVECT(0x18,C0_INT_DISPATCH_HANDLER);
    RTL_GETDATE(&CURRENT_DATE);
    RTL_GETTIME(&CURRENT_TIME);
    WRITE_STDOUT_STRING(STR_BORLAND_CPP_VERSION_2_0);
    if(argc==1) PRINT_USAGE_AND_EXIT();
    SAVED_INT23_VECTOR=RTL_GETVECT(0x23);
    RTL_SETVECT(0x23,(VectorAddress)RCTRL23);
    /* Default heap size: all paragraphs between the heap start and end. */
    HEAP_SIZE_PARAS=HEAP_END_SEG-HEAP_START_SEG;
    INIT_MEMORY_MANAGER();
    EXPAND_RESPONSE_FILES(&argc,&argv);
    READ_CONFIG_AND_ARGS(argc,argv);
    if(OPTION_OBJECT_NAME)
        OPTION_OBJECT_NAME=ADD_DEFAULT_EXTENSION(OPTION_OBJECT_NAME,STR_OUTPUT_EXT_I);
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
    while(argc>0) {
        PROCESS_FILE_ARGUMENT(*argv);
        ++argv;
        --argc;
    }
    /* Update the low-water mark of free heap once more and print it. */
    available=HEAP_SPACE_BELOW_LIMIT();
    if(MIN_FREE_HEAP>available) MIN_FREE_HEAP=available;
    RTL_DPRINTF(STR_AVAILABLE_MEMORY,MIN_FREE_HEAP);
    SHUTDOWN_HEAP_BANKS();
    exit(COMPILE_FAILED!=0);
}

/* rtl/RPUTS.C: write a string to standard output (DOS handle 1), no newline. */
void far pascal WRITE_STDOUT_STRING(char far *text)
{
    RTL_WRITE(1,text,STRING_LENGTH(text));
}

/* driver/USAGE.C: print the usage text and exit with status 0.
   CPP.EXE edit: a near static here (main calls it near); exits through cdecl exit. */
static void near pascal PRINT_USAGE_AND_EXIT(void)
{
    WRITE_STDOUT_STRING(STR_SYNTAX_IS_CPP_OPTIONS);
    exit(0);
}

/* rtl/RSTRLOW.C: strupr on a far string, in place; NULL is ignored. */
void far pascal RTL_STRUPR(char far *text)
{
    if (!text) return;
    while (*text) {
        *text=RTL_TOUPPER(*text);
        ++text;
    }
}
