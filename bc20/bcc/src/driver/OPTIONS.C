/* target: ovr103_C238UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: command-line option handlers. Entry points: COMPILE_ONE_FILE, MODE_FALLBACK,
   RECORD_SOURCE_NAME, RESET_WARNINGS_TO_DEFAULT, SAVE_WARNINGS_AS_DEFAULT, APPLY_OPTION,
   ADD_COMMAND_LINE_MACRO, REMOVE_COMMAND_LINE_MACRO (+3 more). Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: the command-line option machinery and the per-file compile entry.
   Options: APPLY_OPTION is called for every option word (without its '-') from the
   configuration file and the command line (CONFIG.C, RMAIN13C). It walks
   COMMAND_OPTION_TABLE, a table of Option rows (letter, level, handler, variable,
   value) kept in the data segment; every row whose letter matches the first character
   and whose level allows the current SESSION_PHASE calls its handler with the rest of the
   word. Handlers here: on/off flags (HANDLE_FLAG_OPTION and its negated twin), fixed
   values, numbers, strings, warning switches (-w), name lists (-T for TASM), -P (C++ and
   the default extension), -l (linker switches), -D/-U macros, -I/-L directories, and
   EMS/extended-memory limits. A row with HANDLE_SUBTABLE_OPTION points to a second
   table for two-letter options. The option bytes most rows change lie in OPTION_BLOCK
   (0x90 bytes); "-x." restores one of them to its value at the start of the compile
   (from SAVED_OPTION_BLOCK) and is allowed only inside a compile, probably for
   #pragma option.
   Compile: COMPILE_ONE_FILE compiles one .c/.cpp file with setjmp-style error recovery
   (C45_SETJUMP on ERROR_JUMP_BUFFER). Fatal errors and the error limit long-jump back
   with code 2. Code 3 (MODE_FALLBACK(3), raised when inline assembly or a precompiled
   header needs it) restarts the compile writing assembly and running TASM, the
   "restarting compile using assembly" path. Options changed during a compile are undone
   afterwards by copying SAVED_OPTION_BLOCK back.
   Also here: the list of source file names of a compile (RECORD_SOURCE_NAME), the
   -D macro list (ADD/REMOVE_COMMAND_LINE_MACRO, DEFINE_COMMAND_LINE_MACROS) and the
   include-file search (OPEN_INCLUDE_FILE). */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "FIELDS.H"
/* One command-line option: letter, level, handler, variable, value. */
typedef struct Option Option;
struct Option {
    char letter;
    signed char level;
    int (near pascal *handler)(Option near *,char far *);
    void near *variable;
    unsigned int value;
};

/* ---- COMPILE_ONE_FILE (listing B960) ---- */
/* row X02E_08 (offset 0x0): stub 0C85:002A = COMPILE_ONE_FILE */
/* The 0x90-byte option settings and their saved copy; copied whole. */
typedef struct OptionBlock { char data[0x90]; } OptionBlock;
extern char OPTION_BLOCK[];
extern char  OPTION_FLAGS,HUGE_PTR_AHSHIFT_MODE,OPTION_COMPILE_VIA_ASM,OPTION_WINDOWS_MODE,C31_MEMORY_OPTION;
extern unsigned char  COMPILER_MODE;
extern unsigned char  ERROR_JUMP_BUFFER[];
extern unsigned int INIT_OPTION; extern unsigned int ERROR_COUNT; extern unsigned int STRING_POOL_SEG;
extern int  SESSION_PHASE;
extern void (far pascal *FINISH_COMPILATION_HOOK)(int);
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);
extern void far pascal SAVE_MALLOC_POOL_MARK(void);
extern signed char far pascal ALLOCATE_OWNER_TAG(void);
extern unsigned char far pascal GET_DEFAULT_OWNER_TAG(void);
extern int far pascal C45_SETJUMP(void far *);
extern unsigned int far pascal POP_INPUT_CONTEXT(unsigned int);
extern unsigned int far pascal RESTORE_MALLOC_POOL_MARK(void);
extern void far pascal BEGIN_SESSION(char far *);
extern void far pascal COMPILE_C_SOURCE(char far *);
extern void far pascal PATH_PROCESS(char far *,unsigned int,unsigned int);
extern unsigned long far pascal C31_SET_MEMORY_LIMIT(unsigned long);
extern unsigned long far pascal C31_MEMORY_LIMIT(void);
extern void far pascal ADOPT_EXTERNAL_REGIONS(unsigned int,unsigned int);
extern void far CPP_REGION_START_MARK(void),CPP_REGION_END_MARK(void),INIT_END_C_START_MARK(void),C_REGION_END_MARK(void);
extern void far pascal SET_DEFAULT_OWNER_TAG(unsigned char);

/* Compiles one source file. Returns 0 on success, 2 when there were errors or the
   compile was abandoned by a long jump with code 2, 3 when abandoned with code 4. The variable
   is_object is misnamed: it is 1 when the file is compiled as C++ (-P given, OPTION_FLAGS
   bit 0, or the extension is .cpp), and then the C++ front end runs (BEGIN_SESSION),
   else the C front end (COMPILE_C_SOURCE). INIT_OPTION gets a new heap owner tag for
   everything the compile allocates; option_state keeps the previous default tag so it
   can be restored at the end. ASM_OUTPUT_PATH (in the string pool) is the output name
   without extension; when assembly was written PATH_PROCESS(path,1,0) runs TASM on it
   and deletes the .asm file. */
int far pascal COMPILE_ONE_FILE(char far *name)
{
    int option_state;
    char path[80];
    register int result;
    register int is_object;

    FNSPLIT(name,0,0,0,TOKEN_TEXT_BUFFER);
    if((OPTION_FLAGS&1) || STRING_COMPARE(TOKEN_TEXT_BUFFER,STR_CPP)==0)
        is_object=1;
    else
        is_object=0;
    SAVE_MALLOC_POOL_MARK();
    INIT_OPTION=ALLOCATE_OWNER_TAG();
    *(OptionBlock *)SAVED_OPTION_BLOCK=*(OptionBlock *)OPTION_BLOCK;
    HUGE_PTR_AHSHIFT_MODE|=OPTION_WINDOWS_MODE;
    option_state=GET_DEFAULT_OWNER_TAG();
    result=C45_SETJUMP(ERROR_JUMP_BUFFER);
        /* Reached through a long jump. First close every open input file and macro
           context. Codes 2 and 4: give up on this file. Any other code (3): run the
           compile again, now writing assembly (COMPILER_MODE) and assembling it. */
    if(result!=0) {
        if(CURRENT_FILE_CONTEXT!=0) {
            while(POP_INPUT_CONTEXT(1)!=0)
                ;
        }
        if(result==2 || result==4) {
            FINISH_COMPILATION_HOOK(1);
            RESTORE_MALLOC_POOL_MARK();
            /* result=2 restates the value: the original has this copy
               (00B7 mov si,2), and the later result=2 paths (011B, 01E1)
               are cross-jumped into it. */
            if(result==2)
                result=2;
            else
                result=3;
        }
        else {
            FINISH_COMPILATION_HOOK(1);
            COMPILER_MODE=OPTION_COMPILE_VIA_ASM=1;
            if(is_object)
                BEGIN_SESSION(name);
            else
                COMPILE_C_SOURCE(name);
            if(ERROR_COUNT==0) {
                BEGIN_BACKEND_OUTPUT_HOOK();
                STRING_COPY(path,(char far *)MK_FP(STRING_POOL_SEG,ASM_OUTPUT_PATH));
            }
            FINISH_COMPILATION_HOOK(ERROR_COUNT);
            if(ERROR_COUNT!=0)
                result=2;
            else {
                result=0;
                PATH_PROCESS(path,1,0);
            }
        }
    }
        /* Normal first entry from C45_SETJUMP. Unless a memory limit was given, keep
           100000 bytes of conventional memory free (too little is fatal). The first
           compile also calls ADOPT_EXTERNAL_REGIONS (heap/RHAPI.C) with the segments of
           two placeholder marks: those named for the C++ region for a C++ compile,
           those of the C region otherwise, so the heap takes over that span of the
           program image. */
    else {
        if(C31_MEMORY_OPTION==0) {
            if(C31_SET_MEMORY_LIMIT(100000L)<100000L)
                REPORT_FATAL(MSG_OUT_MEMORY);
        }
        HEAP_RESERVE_BYTES=100000L-C31_MEMORY_LIMIT();
        if(COMPILE_FILE_COUNT++==0) {
            /* The arguments are the segments of four one-byte placeholder
               overlays (CO051/CO068 or CO044/CO067), relocated by the linker. */
            if(is_object)
                ADOPT_EXTERNAL_REGIONS(FP_SEG(CPP_REGION_START_MARK),FP_SEG(CPP_REGION_END_MARK));
            else
                ADOPT_EXTERNAL_REGIONS(FP_SEG(INIT_END_C_START_MARK),FP_SEG(C_REGION_END_MARK));
        }
        if(is_object)
            BEGIN_SESSION(name);
        else
            COMPILE_C_SOURCE(name);
        if(ERROR_COUNT==0) {
            BEGIN_BACKEND_OUTPUT_HOOK();
            STRING_COPY(path,(char far *)MK_FP(STRING_POOL_SEG,ASM_OUTPUT_PATH));
        }
        FINISH_COMPILATION_HOOK(ERROR_COUNT);
        if(ERROR_COUNT!=0)
            result=2;
        else {
            result=0;
            if(OPTION_COMPILE_VIA_ASM!=0)
                PATH_PROCESS(path,1,0);
        }
    }
    SESSION_PHASE=0;
    *(OptionBlock *)OPTION_BLOCK=*(OptionBlock *)SAVED_OPTION_BLOCK;
    CURRENT_FILE_NAME=0;
    CURRENT_LINE=0;
    SET_DEFAULT_OWNER_TAG(option_state);
    return result;
}

/* ---- MODE_FALLBACK (listing BB95) ---- */
/* row X02E_09 (offset 0x235): stub 0C85:002F = MODE_FALLBACK */
extern void far pascal C45_LONGJUMP(void far *,int);

/* Abandons the current compile: long-jumps to COMPILE_ONE_FILE with code mode. Called
   with 3 to restart the compile through the assembler. */
void far pascal MODE_FALLBACK(unsigned int mode)
{
    C45_LONGJUMP(ERROR_JUMP_BUFFER,mode);
}

/* ---- RECORD_SOURCE_NAME (listing BBA9) ---- */
/* row X02E_06 (offset 0x249): stub 0C85:0043 = RECORD_SOURCE_NAME */
extern void (far pascal *EMIT_DEPENDENCY_HOOK)(char far *);
extern void far pascal ADD_PCH_DEPENDENCY(void);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
#define W(o) (*(unsigned int far *)MK_FP(STRING_POOL_SEG,(o)))

/* Notes CURRENT_FILE_NAME as a source file of this compile, after ADD_PCH_DEPENDENCY.
   Before the back end runs (SESSION_PHASE not 2) the name is appended to
   SOURCE_FILE_LIST, a list in the string pool (link word, then the text; W() reads a
   word there); BEGIN_BACKEND_PHASE later hands the whole list to EMIT_DEPENDENCY_HOOK.
   Once the back end runs the name goes to EMIT_DEPENDENCY_HOOK at once. */
void far pascal RECORD_SOURCE_NAME(void)
{
    register unsigned int link;
    register unsigned int node;

    ADD_PCH_DEPENDENCY();
    if(SESSION_PHASE==2) {
        STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME));
        EMIT_DEPENDENCY_HOOK(BCC_DEBUG_NAME);
    }
    else {
        node=POOL_ALLOC(&STRING_POOL_SEG,STRING_LENGTH((char far *)MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME))+3);
        W(node)=0;
        STRING_COPY((char far *)MK_FP(STRING_POOL_SEG,node+STRPOOL_SRCLIST_NAME),(char far *)MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME));
        if(SOURCE_FILE_LIST==0)
            SOURCE_FILE_LIST=node;
        else {
            link=SOURCE_FILE_LIST;
            while(W(link)!=0)
                link=W(link);
            W(link)=node;
        }
    }
}
#undef W

/* ---- RESET_WARNINGS_TO_DEFAULT (listing BC3C) ---- */
/* row RESET_WARNINGS_TO_DEFAULT (offset 0x2DC): stub 0C85:003E = RESET_WARNINGS_TO_DEFAULT */

/* Sets the on/off state of all 60 warnings (WARNING_SWITCH_STATE) from the defaults
   kept in WARNING_SWITCH_TABLE. Each table entry is 4 bytes: the 3-letter -w code and
   the default state. */
void far pascal RESET_WARNINGS_TO_DEFAULT(void)
{
    register int i;

    for(i=0;i<=59;i++)
        WARNING_SWITCH_STATE[i]=WARNING_SWITCH_TABLE[i*4+3];
}

/* ---- SAVE_WARNINGS_AS_DEFAULT (listing BC5B) ---- */
/* row SAVE_WARNINGS_AS_DEFAULT (offset 0x2FB): stub 0C85:0039 = SAVE_WARNINGS_AS_DEFAULT */

/* The reverse: makes the current warning states the defaults, so the -w options from
   the command line and configuration file hold for every file. */
void far pascal SAVE_WARNINGS_AS_DEFAULT(void)
{
    register int i;

    for(i=0;i<=59;i++)
        WARNING_SWITCH_TABLE[i*4+3]=WARNING_SWITCH_STATE[i];
}

/* ---- APPLY_OPTION (listing BC7A) ---- */
static int near pascal DISPATCH_OPTION_TABLE(Option near *option,char far *argument);
/* row X02E_04 (offset 0x31A): stub 0C85:004D = APPLY_OPTION */
extern Option  COMMAND_OPTION_TABLE[];

/* Applies one option word (argument has no leading '-'). Returns nonzero when the option
   was accepted, 0 when it is unknown or bad. pass selects which options act now:
   0xFFFF (-1) only -I and -L, 0 everything except -I and -L, any other value (1, from the
   configuration file) everything; skipped options count as accepted. */
int far pascal APPLY_OPTION(char far *argument,register unsigned int pass)
{
    if(*argument=='I' || *argument=='L') {
        if(pass==0)
            return 1;
    }
    else if(pass==-1)
        return 1;
    return DISPATCH_OPTION_TABLE(COMMAND_OPTION_TABLE,argument);
}

/* ---- DISPATCH_OPTION_TABLE (listing BCB2) ---- */
/* row DISPATCH_OPTION_TABLE (offset 0x352): private, no stub */

/* Runs every row of the table option whose letter is argument[0] and whose level is at
   least SESSION_PHASE (so options with a low level are refused inside a compile). Returns
   0 as soon as a handler refuses, else 1 if any row matched, 0 if none did. */
static int near pascal DISPATCH_OPTION_TABLE(Option near *option,char far *argument)
{
    int found;

    found=0;
    while(option->handler!=0) {
        if(option->letter==*argument && option->level>=SESSION_PHASE) {
            if(option->handler(option,argument+1)==0)
                return 0;
            found=1;
        }
        option++;
    }
    return found;
}

/* ---- HANDLE_FLAG_OPTION (listing BCFC) ---- */
/* row HANDLE_FLAG_OPTION (offset 0x39C, first of two functions in the row): private, no stub */

/* Byte flag: "x" or "x+" sets it to 1, "x-" to 0. "x." (only inside a compile)
   stores the current value into SAVED_OPTION_BLOCK at the same offset, so that the value
   stays after the compile instead of being undone. Anything else is refused. */
static int near pascal HANDLE_FLAG_OPTION(Option near *option,char far *argument)
{
    int offset;

    switch(*argument) {
    case '-':
        *(char near *)option->variable=0;
        break;
    case 0:
    case '+':
        *(char near *)option->variable=1;
        break;
    case '.':
        if(SESSION_PHASE==0)
            return 0;
        offset=(char near *)option->variable-OPTION_BLOCK;
        SAVED_OPTION_BLOCK[offset]=*(char near *)option->variable;
        break;
    default:
        return 0;
    }
    return 1;
}
/* row HANDLE_FLAG_OPTION (offset 0x415, second function inside that row, after the switch table): private, no stub */

/* Like HANDLE_FLAG_OPTION for options whose flag means the opposite: "x" or "x+"
   clears the byte, "x-" sets it. */
static int near pascal HANDLE_NEGATED_FLAG_OPTION(register Option near *option,char far *argument)
{
    switch(*argument) {
    case '-':
        *(char near *)option->variable=1;
        break;
    case 0:
    case '+':
        *(char near *)option->variable=0;
        break;
    default:
        return 0;
    }
    return 1;
}

/* ---- HANDLE_WARNING_OPTION (listing BDB1) ---- */
/* row HANDLE_WARNING_OPTION (offset 0x451): private, no stub */

/* -w options: "-w" / "-w-" turn all warnings on or off; "-wxxx" / "-w-xxx" one warning
   by its 3-letter code; "-w." (inside a compile) all warnings back to their defaults and
   "-w.xxx" one warning back to its default. */
static int near pascal HANDLE_WARNING_OPTION(Option near *option,char far *argument)
{
    unsigned char far *entry;
    int value;
    char first;
    register int i;

    first=*argument;
    if(*argument=='-') {
        value=0;
        argument++;
    }
    else if(*argument=='.') {
        if(SESSION_PHASE==0)
            return 0;
        argument++;
    }
    else {
        if(*argument=='+')
            argument++;
        value=1;
    }
    if(*argument==0) {
        if(first=='.')
            RESET_WARNINGS_TO_DEFAULT();
        else {
            for(i=0,entry=WARNING_SWITCH_TABLE;*entry!=0;entry+=4,i++)
                WARNING_SWITCH_STATE[i]=value;
        }
    }
    else {
        for(i=0,entry=WARNING_SWITCH_TABLE;*entry!=0;entry+=4,i++) {
            if(argument[0]==entry[0] && argument[1]==entry[1] && argument[2]==entry[2])
                WARNING_SWITCH_STATE[i]=(first=='.') ? entry[3] : value;
        }
    }
    return 1;
}

/* ---- RESTORE_OPTION_DEFAULT (listing BE98) ---- */
/* row RESTORE_OPTION_DEFAULT (offset 0x538): private, no stub */

/* Same as the "." case of HANDLE_FLAG_OPTION: keeps the current value of the option byte
   past the end of the compile. Refused outside a compile. */
static int near pascal RESTORE_OPTION_DEFAULT(Option near *option,char far *argument)
{
    int offset;

    if(SESSION_PHASE==0)
        return 0;
    offset=(char near *)option->variable-OPTION_BLOCK;
    SAVED_OPTION_BLOCK[offset]=*(char near *)option->variable;
    return 1;
}

/* ---- HANDLE_SUBTABLE_OPTION (listing BEC7) ---- */
/* row HANDLE_SUBTABLE_OPTION (offset 0x567): private, no stub */

/* For multi-letter options: the row's variable is a second option table, searched with
   the next letter. */
static int near pascal HANDLE_SUBTABLE_OPTION(register Option near *option,char far *argument)
{
    return DISPATCH_OPTION_TABLE((Option near *)option->variable,argument);
}

/* ---- SET_OPTION_VALUE (listing BEE1) ---- */
/* row SET_OPTION_VALUE (offset 0x581): private, no stub */

/* Stores the row's fixed value into its byte variable (for example a memory model). */
static int near pascal SET_OPTION_VALUE(register Option near *option,char far *argument)
{
    *(char near *)option->variable=option->value;
    return 1;
}

/* ---- IGNORE_OPTION (listing BEFA) ---- */
/* row IGNORE_OPTION (offset 0x59A): private, no stub */

static int near pascal IGNORE_OPTION(Option near *option,char far *argument)
{
    return 1;
}

/* ---- SET_STRING_OPTION (listing BF06) ---- */
/* row SET_STRING_OPTION (offset 0x5A6): private, no stub */

/* Stores a MALLOC copy of the rest of the word into the row's far-pointer variable
   (file and directory names such as -o, -n, -e). */
static int near pascal SET_STRING_OPTION(register Option near *option,char far *argument)
{
    char far *copy;

    copy=(char far *)MALLOC(STRING_LENGTH(argument)+1);
    STRING_COPY(copy,argument);
    *(char far * near *)option->variable=copy;
    return 1;
}

/* ---- SET_BYTE_NUMBER_OPTION (listing BF53) ---- */
/* row SET_BYTE_NUMBER_OPTION (offset 0x5F3): private, no stub */
extern char  _CTYPE[];
#define isdigit(c) (_CTYPE[(c)+1]&2)

/* Decimal number option stored into a byte; refused if not a number or above the row's
   value (the maximum). The number is converted twice; the first result is only for the
   range check. */
static int near pascal SET_BYTE_NUMBER_OPTION(register Option near *option,char far *argument)
{
    unsigned int number;

    if(!isdigit(*argument))
        return 0;
    number=RTL_ATOL(argument);
    if(option->value<number)
        return 0;
    *(char near *)option->variable=RTL_ATOL(argument);
    return 1;
}

/* ---- SET_INT_NUMBER_OPTION (listing BFA7) ---- */
/* row SET_INT_NUMBER_OPTION (offset 0x647): private, no stub */

/* As SET_BYTE_NUMBER_OPTION, storing into a word. */
static int near pascal SET_INT_NUMBER_OPTION(register Option near *option,char far *argument)
{
    unsigned int number;

    if(!isdigit(*argument))
        return 0;
    number=RTL_ATOL(argument);
    if(option->value<number)
        return 0;
    *(int near *)option->variable=RTL_ATOL(argument);
    return 1;
}

/* ---- ADD_NAME_LIST_OPTION (listing BFFB) ---- */
/* row ADD_NAME_LIST_OPTION (offset 0x69B): private, no stub */
typedef struct NameEntry NameEntry;
struct NameEntry {
    NameEntry far *next;
    char text[1];
};
extern NameEntry far *ARGUMENT_LIST;
extern NameEntry far *ARGUMENT_LIST_TAIL;

/* Appends the text to ARGUMENT_LIST, the list of extra TASM arguments that PATH_PROCESS
   (DRVLINK.C) adds; the text "-" alone empties the list. A node is a far link (4 bytes)
   and the text, hence MALLOC(length+5). */
static int near pascal ADD_NAME_LIST_OPTION(Option near *option,char far *argument)
{
    NameEntry far *entry;

    if(argument[0]=='-' && argument[1]==0)
        ARGUMENT_LIST=0;
    else {
        entry=(NameEntry far *)MALLOC(STRING_LENGTH(argument)+5);
        if(ARGUMENT_LIST!=0)
            ARGUMENT_LIST_TAIL->next=entry;
        else
            ARGUMENT_LIST=entry;
        ARGUMENT_LIST_TAIL=entry;
        entry->next=0;
        STRING_COPY(entry->text,argument);
    }
    return 1;
}

/* ---- HANDLE_CPP_EXT_OPTION (listing C09D) ---- */
/* row HANDLE_CPP_EXT_OPTION (offset 0x73D): private, no stub */

/* -P: compile every file as C++ (OPTION_FLAGS=1) with ".cpp" as default extension.
   -P- turns C++ forcing off. A following text (-Pext or -P-ext, with or without a
   leading '.') sets the default extension in DEFAULT_SOURCE_EXT, at most 3 characters; an
   empty text leaves just ".". */
static int near pascal HANDLE_CPP_EXT_OPTION(Option near *option,char far *argument)
{
    register char near *cursor;

    OPTION_FLAGS=1;
    STRING_COPY(DEFAULT_SOURCE_EXT,STR_CPP);
    if(*argument==0)
        return 1;
    if(*argument=='-') {
        OPTION_FLAGS=0;
        argument++;
        if(*argument==0)
            return 1;
    }
    if(*argument=='.')
        argument++;
    for(cursor=DEFAULT_SOURCE_EXT+1;*argument!=0;argument++) {
        if(cursor<DEFAULT_SOURCE_EXT+4)
            *cursor++=*argument;
    }
    /* Compared as far pointers, as in the original (07A9 mov ax,ds; mov dx,ds). */
    if((char far *)cursor==(char far *)(DEFAULT_SOURCE_EXT+1))
        cursor--;
    *cursor=0;
    return 1;
}

/* ---- OPTLIB (listing C124) ---- */
/* OPTLIB: accepted module carried over; its original options were -mm -G -O -Z -p -Y.
   The pragmas switch to -G and no line records, then back to the unit default. */
#pragma option -G -y-
extern char LINKER_SWITCH_FLAGS[];
#define isalnum(c) (_CTYPE[(c)+1]&14)
#define isalpha(c) (_CTYPE[(c)+1]&12)
#define islower(c) (_CTYPE[(c)+1]&8)
/* -l: linker switches for RUN_LINKER. "-l-" clears them all. Otherwise each character
   (optionally preceded by '-' to turn it off) sets a flag: LINKER_SWITCH_FLAGS holds 62
   bytes, a..z at 0..25, A..Z at 26..51 and 0..9 at 52..61 (the C51_UPPER_LINK_OPTIONS and
   C51_DIGIT_LINK_OPTIONS arrays are the upper parts of the same block). "y?" and "T?" set
   the /y? and /T? flags (LINKER_Y_SWITCH_FLAGS and LINKER_T_SWITCH_FLAGS, indexed by the
   lower-case letter; their 'a'.. parts are C51_Y_LINK_OPTIONS and C51_T_LINK_OPTIONS).
   Setting /m or /s (map file) clears /x (no map). */
static int near pascal BCC_SET_OPTION_LIBRARY(Option near *option, char far *argument)
{
    int value;
    register int index;

    if (argument[0] == '-' && argument[1] == 0) {
        RTL_MEMSET(LINKER_SWITCH_FLAGS, 0, 62);
        RTL_MEMSET(LINKER_Y_SWITCH_FLAGS + 'a', 0, 26);
        RTL_MEMSET(LINKER_T_SWITCH_FLAGS + 'a', 0, 26);
    }
    else {
        while (*argument != 0) {
            value = 1;
            if (*argument == '-') {
                value = 0;
                argument++;
            }
            if (!isalnum(*argument))
                return 0;
            if (isalpha(*argument)) {
                if (*argument == 'y') {
                    argument++;
                    if (isalpha(*argument))
                        LINKER_Y_SWITCH_FLAGS[TOLOWER(*argument)] = value;
                    else {
                        /* Documented exception: an empty statement keeps BC from
                           threading this jump, so the original's je to a separate
                           jmp 090F (0872 -> 088D) is kept.  Without it BC jumps
                           straight to 090F. */
                        (void)0;
                        goto next_library_character;
                    }
                }
                else if (*argument == 'T') {
                    argument++;
                    if (isalpha(*argument))
                        LINKER_T_SWITCH_FLAGS[TOLOWER(*argument)] = value;
                    /* Documented exception, as above: keeps the je onto the
                       branch's own jmp 090F (08AA -> 08C2). */
                    (void)0;
                }
                else {
                    index = *argument - (islower(*argument) ? 'a' : 'A' - 26);
                    goto set_library_flag;
                }
            }
            else {
                index = *argument + 4;
set_library_flag:
                LINKER_SWITCH_FLAGS[index] = value;
                if (LINKER_SWITCH_FLAGS[12] != 0 || LINKER_SWITCH_FLAGS[18] != 0)
                    LINKER_SWITCH_FLAGS[23] = 0;
            }
next_library_character:
            argument++;
        }
    }
    return 1;
}
#pragma option -G- -y

/* ---- DEFINE_MACROS_OPTION (listing C289) ---- */
void far pascal ADD_COMMAND_LINE_MACRO(char far *name, char far *value);
/* row DEFINE_MACROS_OPTION (offset 0x929): private, no stub */
/* -Dname, -Dname=value, several separated by ';' (a backslash protects the next
   character from being taken as a separator). Each one goes to ADD_COMMAND_LINE_MACRO;
   a name without "=" gets STR_EMPTY_MACRO_VALUE. The argument text is cut in place. */
static int near pascal DEFINE_MACROS_OPTION(Option near *option, char far *argument)
{
    char far *name;
    char far *value;
    char far *cursor;

    cursor = argument;
    while (*cursor != 0) {
        do {
            if (*cursor == ';') {
                *cursor = 0;
                cursor++;
                break;
            }
            if (*cursor == '\\' && cursor[1] != 0)
                cursor += 2;
            else
                cursor++;
        } while (*cursor != 0);
        value = STR_EMPTY_MACRO_VALUE;
        name = argument;
        while (*argument != 0) {
            if (*argument == '=') {
                *argument = 0;
                argument++;
                value = argument;
                break;
            }
            argument++;
        }
        ADD_COMMAND_LINE_MACRO(name, value);
        argument = cursor;
    }
    return 1;
}

/* ---- UNDEFINE_MACRO_OPTION (listing C346) ---- */
void far pascal REMOVE_COMMAND_LINE_MACRO(char far *name);
/* row UNDEFINE_MACRO_OPTION (offset 0x9E6): private, no stub */
/* -Uname: removes name from the -D list. */
static int near pascal UNDEFINE_MACRO_OPTION(Option near *option, char far *argument)
{
    REMOVE_COMMAND_LINE_MACRO(argument);
    return 1;
}

/* ---- PATHS (listing C35D) ---- */
/* PATHS: accepted module carried over; its original options were -mm -G -O -Z -p -Y.
   The pragmas switch to -G and no line records, then back to the unit default. */
#pragma option -G -y-
typedef struct PathNode PathNode;
extern PathNode far *INCLUDE_DIR_LIST;
extern PathNode far *SEARCH_LIST;
extern char far *INCLUDE_OPTION_TEXT_PTR;
static void near pascal BCC_ADD_PATHS(char far *,PathNode far * far *);
/* -I dirs: adds the directories to INCLUDE_DIR_LIST and points INCLUDE_OPTION_TEXT_PTR
   at STR_INCLUDE_GIVEN_MARK, probably to note that -I was given. */
static int near pascal BCC_SET_OPTION_INCLUDE(Option near *option,char far *argument)
{
    BCC_ADD_PATHS(argument,&INCLUDE_DIR_LIST);
    INCLUDE_OPTION_TEXT_PTR=STR_INCLUDE_GIVEN_MARK;
    return 1;
}
/* -L dirs: adds the directories to SEARCH_LIST, used by FIND_FILE in DRVLINK.C. */
static int near pascal BCC_SET_OPTION_LIBRARY_PATH(Option near *option,char far *argument)
{
    BCC_ADD_PATHS(argument,&SEARCH_LIST);
    return 1;
}
#pragma option -G- -y

/* ---- PATHLIB (listing C39B) ---- */
static char far *near pascal BCC_COPY_PATH(char far *path);
/* PATHLIB: accepted module carried over; its original options were -mm -G -O -Z -p -Y.
   The pragmas switch to -G and no line records, then back to the unit default. */
#pragma option -G -y-

struct PathNode {
    int kind;
    PathNode far *next;
    char far *path;
};
/* Splits argument at ';' (in place) and pushes each directory, with a trailing
   backslash added by BCC_COPY_PATH, onto the front of *list. The lists therefore come out
   reversed; BCC_REVERSE_PATHS puts them back in command-line order once all options are
   read. A node is 10 bytes: kind word, far next link, far path. */
static void near pascal BCC_ADD_PATHS(char far *argument,PathNode far * far *list)
{
    PathNode far *node;
    char far *cursor;
    cursor=argument;
    while(*argument!=0) {
        while(*cursor!=0 && *cursor!=';') cursor++;
        if(*cursor!=0) {
            *cursor=0;
            cursor++;
        }
        node=(PathNode far *)MALLOC(10);
        node->path=BCC_COPY_PATH(argument);
        node->next=*list;
        *list=node;
        argument=cursor;
    }
}
#pragma option -G- -y

/* ---- ADD_COMMAND_LINE_MACRO (listing C436) ---- */
/* row X02E_05 (offset 0xAD6): stub 0C85:0052 = ADD_COMMAND_LINE_MACRO */
typedef struct DefineNode DefineNode;
struct DefineNode {
    DefineNode far *next;
    char name[1];
};
extern DefineNode far *DEFINE_LIST_TAIL;
extern DefineNode far *DEFINE_LIST_HEAD;
/* Adds a -D macro to the list (DEFINE_LIST_HEAD/TAIL). A node holds the far link, the
   name and 0, then the value followed by the byte FBh and 0; FBh probably marks the end
   of a macro body as the preprocessor stores it. A second -D of the same name with the
   same value is ignored; with another value it warns "Redefinition of name is not
   identical" and keeps the first. */
void far pascal ADD_COMMAND_LINE_MACRO(char far *name, char far *value)
{
    DefineNode far *node;
    char far *text;
    char far *other;

    for (node = DEFINE_LIST_HEAD; node != 0; node = node->next) {
        if (COMPARE_NAME(name, node->name) == 0) {
            text = node->name;
            text += STRING_LENGTH(text) + 1;
            other = value;
            while (*text == *other) {
                text++;
                other++;
            }
            if (*text == '\xFB' && text[1] == 0 && *other == 0)
                return;
            REPORT_WARNING(MSG_REDEFINITION_NOT, name);
            return;
        }
    }
    node = (DefineNode far *)MALLOC(STRING_LENGTH(name) + STRING_LENGTH(value) + 7);
    text = node->name;
    STRING_COPY(text, name);
    text += STRING_LENGTH(text) + 1;
    STRING_COPY(text, value);
    text += STRING_LENGTH(text);
    *text++ = '\xFB';
    *text = 0;
    if (DEFINE_LIST_HEAD != 0)
        DEFINE_LIST_TAIL->next = node;
    else
        DEFINE_LIST_HEAD = node;
    DEFINE_LIST_TAIL = node;
    node->next = 0;
}

/* ---- REMOVE_COMMAND_LINE_MACRO (listing C5BD) ---- */
/* row X02E_02 (offset 0xC5D): stub 0C85:0034 = REMOVE_COMMAND_LINE_MACRO */

/* Unlinks the first -D node named name, if any. The node is not freed. */
void far pascal REMOVE_COMMAND_LINE_MACRO(char far *name)
{
    DefineNode far *node;
    DefineNode far *previous;

    previous = 0;
    for (node = DEFINE_LIST_HEAD; node != 0; node = node->next) {
        if (COMPARE_NAME(name, node->name) == 0) {
            if (previous != 0)
                previous->next = node->next;
            else
                DEFINE_LIST_HEAD = node->next;
            return;
        }
        previous = node;
    }
}

/* ---- PATHREV (listing C64A) ---- */
/* PATHREV: accepted module carried over; its original options were -mm -G -O -Z -p (only far functions, so the unit-wide -Y, which pragmas cannot change, has no effect).
   The pragmas switch to -G and no line records, then back to the unit default. */
#pragma option -G -y-

/* Reverses INCLUDE_DIR_LIST and SEARCH_LIST in place (see BCC_ADD_PATHS). Called once
   from RMAIN13C. */
void pascal far BCC_REVERSE_PATHS(void)
{
    PathNode far *node;
    PathNode far *next;

    node = INCLUDE_DIR_LIST;
    INCLUDE_DIR_LIST = 0;
    while (node != 0) {
        next = node->next;
        node->next = INCLUDE_DIR_LIST;
        INCLUDE_DIR_LIST = node;
        node = next;
    }
    node = SEARCH_LIST;
    SEARCH_LIST = 0;
    while (node != 0) {
        next = node->next;
        node->next = SEARCH_LIST;
        SEARCH_LIST = node;
        node = next;
    }
}
#pragma option -G- -y

/* ---- BCC_COPY_PATH (listing C70C) ---- */
/* row BCC_NEAR_C70C (offset 0xDAC): private, no stub (called from the PATHLIB code above as BCC_COPY_PATH) */
/* Returns a MALLOC copy of the directory path with a backslash added, unless the path is
   empty or already ends in '/', '\' or ':'. */
static char far *near pascal BCC_COPY_PATH(char far *path)
{
    char far *copy;
    int extra;

    copy = path + STRING_LENGTH(path);
    if (copy == path || copy[-1] == '/' || copy[-1] == '\\' || copy[-1] == ':')
        extra = 0;
    else
        extra = 1;
    copy = (char far *)MALLOC(STRING_LENGTH(path) + extra + 1);
    STRING_COPY(copy, path);
    if (extra)
        STRING_APPEND(copy, STR_BACKSLASH);
    return copy;
}

/* ---- OPEN_INCLUDE_FILE (listing C7A9) ---- */
/* row X02E_07 (offset 0xE49): stub 0C85:0048 = OPEN_INCLUDE_FILE */

extern unsigned int far pascal OPEN_SOURCE_FILE(char far *);
/* Tries to open name in each -I directory in turn (the name is built in TOKEN_TEXT_BUFFER).
   Returns 1 when one opened, 0 when none did. */
int far pascal OPEN_INCLUDE_FILE(char far *name)
{
    PathNode far *node;

    for (node = INCLUDE_DIR_LIST; node != 0; node = node->next) {
        STRING_COPY(TOKEN_TEXT_BUFFER, node->path);
        STRING_APPEND(TOKEN_TEXT_BUFFER, name);
        if (OPEN_SOURCE_FILE(TOKEN_TEXT_BUFFER))
            return 1;
    }
    return 0;
}

/* ---- DEFINE_COMMAND_LINE_MACROS (listing C811) ---- */
/* row DEFINE_COMMAND_LINE_MACROS (offset 0xEB1): stub 0C85:0020 = DEFINE_COMMAND_LINE_MACROS */

extern unsigned int far pascal MACRO_DEFINE(char far *,char far *,signed char,unsigned int);
/* Defines every -D macro in the preprocessor at the start of a compile (called from
   OPEN_SESSION_SOURCE in INITPOOL.C). The value text follows the name's 0. */
void far pascal DEFINE_COMMAND_LINE_MACROS(void)
{
    DefineNode far *node;
    char far *text;

    for (node = DEFINE_LIST_HEAD; node != 0; node = node->next) {
        text = node->name;
        MACRO_DEFINE(text, text + STRING_LENGTH(text) + 1, -1, 0);
    }
}

/* ---- HANDLE_EMS_OPTION (listing C871) ---- */
/* row HANDLE_EMS_OPTION (offset 0xF11): private, no stub */

/* EMS use: "-" no EMS (EMS_PAGE_LIMIT -1), empty use all (0), "=n" use n KB, stored in
   16 KB pages rounded up; "=0" means none. */
static int near pascal HANDLE_EMS_OPTION(Option near *option, char far *argument)
{
    long size;

    switch (*argument) {
    case '-':
        EMS_PAGE_LIMIT = -1;
        break;
    case 0:
        EMS_PAGE_LIMIT = 0;
        break;
    case '=':
        argument++;
        if (isdigit(*argument)) {
            size = RTL_ATOL(argument);
            if (size != 0)
                EMS_PAGE_LIMIT = (size + 15) / 16;
            else
                EMS_PAGE_LIMIT = -1;
        }
        else
            return 0;
        break;
    default:
        return 0;
    }
    return 1;
}

/* ---- HANDLE_EXT_MEMORY_OPTION (listing C8FF) ---- */
/* row HANDLE_EXT_MEMORY_OPTION (offset 0xF9F): private, no stub */
/* Extended memory use: "-" none (EXT_MEMORY_BASE -1), empty all (limit and bank size 0),
   "=n" sets the limit to (n+1024) KB in bytes, probably the top address with the first
   megabyte included; ",m" sets the bank size to m KB (the limit then defaults to 1 MB if
   it was -1). "=n,m" sets both. */
static int near pascal HANDLE_EXT_MEMORY_OPTION(Option near *option, char far *argument)
{
    switch (*argument) {
    case '=':
        argument++;
        if (isdigit(*argument)) {
            EXT_MEMORY_BASE = (RTL_ATOL(argument) + 1024) << 10;
            EXT_MEMORY_BANK_SIZE = -1L;
            while (isdigit(*argument))
                argument++;
            if (*argument == 0)
                break;
        }
        if (*argument == ',') {
            argument++;
            if (!isdigit(*argument))
                return 0;
            EXT_MEMORY_BANK_SIZE = RTL_ATOL(argument) << 10;
            if (EXT_MEMORY_BASE == -1L)
                EXT_MEMORY_BASE = 0x100000L;
            while (isdigit(*argument))
                argument++;
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
