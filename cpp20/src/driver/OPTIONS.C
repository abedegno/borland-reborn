/* target: OPTIONS */
/* opts: -mm -O -Z -p -y */
/* CPP.EXE module OPTIONS (image 0x5071..0x5D4A, frame 0507h): source taken from the
   BCC.EXE reconstruction (bcc20/src/driver/OPTIONS.C) with CPP.EXE's
   differences, each marked "CPP.EXE edit". */
/* Role: command-line option handlers and the per-file entry. Entry points:
   COMPILE_ONE_FILE, MODE_FALLBACK, RECORD_SOURCE_NAME, RESET_WARNINGS_TO_DEFAULT,
   SAVE_WARNINGS_AS_DEFAULT, APPLY_OPTION, ADD_COMMAND_LINE_MACRO,
   REMOVE_COMMAND_LINE_MACRO, BCC_REVERSE_PATHS, OPEN_INCLUDE_FILE,
   DEFINE_COMMAND_LINE_MACROS. */
/* Overview: the command-line option machinery and the per-file entry.
   Options: APPLY_OPTION is called for every option word (without its '-') from the
   configuration file and the command line (CONFIG.C). It walks COMMAND_OPTION_TABLE, a
   table of Option rows (letter, level, handler, variable, value) kept in the data
   segment; every row whose letter matches the first character and whose level allows
   the current SESSION_PHASE calls its handler with the rest of the word. Handlers here:
   on/off flags (HANDLE_FLAG_OPTION and its negated twin), fixed values, numbers,
   strings, warning switches (-w), -D/-U macros, -I/-L directories, EMS/extended-memory
   limits, and two "accept and ignore" handlers that stand where BCC has its -T, -P and
   -l handlers. A row with HANDLE_SUBTABLE_OPTION points to a second table for
   two-letter options. The option bytes most rows change lie in OPTION_BLOCK (0x8B bytes
   in CPP.EXE, 0x90 in BCC); "-x." keeps one of them past the end of the file (in
   SAVED_OPTION_BLOCK) and is allowed only while a file is processed, probably for
   #pragma option.
   Per file: COMPILE_ONE_FILE preprocesses one file with setjmp-style error recovery
   (C45_SETJUMP on ERROR_JUMP_BUFFER). Fatal errors and the error limit long-jump back
   with code 2. Options changed during the file are undone afterwards by copying
   SAVED_OPTION_BLOCK back. BCC's version also chose between its C and C++ front ends
   and could restart a compile through TASM (code 3); CPP.EXE does neither.
   Also here: the list of source file names (RECORD_SOURCE_NAME), the -D macro list
   (ADD/REMOVE_COMMAND_LINE_MACRO, DEFINE_COMMAND_LINE_MACROS) and the include-file
   search (OPEN_INCLUDE_FILE). */
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

/* ---- COMPILE_ONE_FILE (CPP 0507:0001) ---- */
/* The option settings and their saved copy; copied whole. */
/* CPP.EXE edit: the option block is 0x8B bytes in CPP.EXE (BCC: 0x90). */
typedef struct OptionBlock { char data[0x8B]; } OptionBlock;
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
/* CPP.EXE edit: no C front end, no back end, no hook table: COMPILE_ONE_FILE runs the
   session code directly (INITPOOL module: BEGIN_SESSION CPP 05D4:000A, END_SESSION
   CPP 05D4:001F, BEGIN_BACKEND_PHASE CPP 05D4:00E5) and never restarts a compile through TASM. The
   C++/C test survives, but its result (is_object, a stack word now) is never read. */
extern void far pascal END_SESSION(int);
extern void far pascal BEGIN_BACKEND_PHASE(void);

/* Preprocesses one source file. Returns 0 on success, 2 when there were errors or the
   file was abandoned by a long jump. is_object (BCC's misnomer) is 1 when OPTION_FLAGS
   bit 0 is set or the extension is .cpp; in BCC it chose the C++ front end, here it is
   set and never read. INIT_OPTION gets a new heap owner tag for everything the file
   allocates; option_state keeps the previous default tag so it can be restored at the
   end. BEGIN_SESSION runs the whole preprocessing; BEGIN_BACKEND_PHASE afterwards does
   nothing when the output was already started (SESSION_PHASE 2). */
/* CPP.EXE edit: see the note above the declarations; this is CPP.EXE's whole compile. */
int far pascal COMPILE_ONE_FILE(char far *name)
{
    int option_state;
    int is_object;
    register int result;

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
    if(result!=0) {
        if(CURRENT_FILE_CONTEXT!=0) {
            while(POP_INPUT_CONTEXT(1)!=0)
                ;
        }
        END_SESSION(1);
        RESTORE_MALLOC_POOL_MARK();
        result=2;
    }
    else {
        BEGIN_SESSION(name);
        if(ERROR_COUNT==0)
            BEGIN_BACKEND_PHASE();
        END_SESSION(ERROR_COUNT);
        if(ERROR_COUNT!=0)
            result=2;
        else
            result=0;
    }
    SESSION_PHASE=0;
    *(OptionBlock *)OPTION_BLOCK=*(OptionBlock *)SAVED_OPTION_BLOCK;
    CURRENT_FILE_NAME=0;
    CURRENT_LINE=0;
    SET_DEFAULT_OWNER_TAG(option_state);
    return result;
}

/* ---- MODE_FALLBACK (CPP 0507:0111) ---- */
extern void far pascal C45_LONGJUMP(void far *,int);

/* Abandons the current file: long-jumps to COMPILE_ONE_FILE with code mode. (In BCC
   code 3 restarted the compile through the assembler; CPP.EXE's COMPILE_ONE_FILE treats
   every nonzero code alike.) */
void far pascal MODE_FALLBACK(unsigned int mode)
{
    C45_LONGJUMP(ERROR_JUMP_BUFFER,mode);
}

/* ---- RECORD_SOURCE_NAME (CPP 0507:0125) ---- */
extern void (far pascal *EMIT_DEPENDENCY_HOOK)(char far *);
extern void far pascal ADD_PCH_DEPENDENCY(void);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
#define W(o) (*(unsigned int far *)MK_FP(STRING_POOL_SEG,(o)))

/* Appends CURRENT_FILE_NAME to SOURCE_FILE_LIST, a list in the string pool (link word,
   then the text; W() reads a word there). BEGIN_BACKEND_PHASE takes the first entry as
   the module name. (BCC's version also passed the names to its object-file dependency
   records.) */
/* CPP.EXE edit: CPP.EXE has only the list-append half (no ADD_PCH_DEPENDENCY, no
   SESSION_PHASE test, no EMIT_DEPENDENCY_HOOK). */
void far pascal RECORD_SOURCE_NAME(void)
{
    register unsigned int link;
    register unsigned int node;

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
#undef W

/* ---- RESET_WARNINGS_TO_DEFAULT (CPP 0507:018F) ---- */

/* Sets the on/off state of all 60 warnings (WARNING_SWITCH_STATE) from the defaults
   kept in WARNING_SWITCH_TABLE. Each table entry is 4 bytes: the 3-letter -w code and
   the default state. */
void far pascal RESET_WARNINGS_TO_DEFAULT(void)
{
    register int i;

    for(i=0;i<=59;i++)
        WARNING_SWITCH_STATE[i]=WARNING_SWITCH_TABLE[i*4+3];
}

/* ---- SAVE_WARNINGS_AS_DEFAULT (CPP 0507:01AE) ---- */

/* The reverse: makes the current warning states the defaults, so the -w options from
   the command line and configuration file hold for every file. */
void far pascal SAVE_WARNINGS_AS_DEFAULT(void)
{
    register int i;

    for(i=0;i<=59;i++)
        WARNING_SWITCH_TABLE[i*4+3]=WARNING_SWITCH_STATE[i];
}

/* ---- APPLY_OPTION (CPP 0507:01CD) ---- */
static int near pascal DISPATCH_OPTION_TABLE(Option near *option,char far *argument);
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

/* ---- DISPATCH_OPTION_TABLE (CPP 0507:0205) ---- */

/* Runs every row of the table option whose letter is argument[0] and whose level is at
   least SESSION_PHASE (so options with a low level are refused while a file is processed). Returns
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

/* ---- HANDLE_FLAG_OPTION (CPP 0507:024D) ---- */

/* Byte flag: "x" or "x+" sets it to 1, "x-" to 0. "x." (only while a file is processed)
   stores the current value into SAVED_OPTION_BLOCK at the same offset, so that the value
   stays after the file instead of being undone. Anything else is refused. */
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

/* ---- HANDLE_WARNING_OPTION (CPP 0507:02FE) ---- */

/* -w options: "-w" / "-w-" turn all warnings on or off; "-wxxx" / "-w-xxx" one warning
   by its 3-letter code; "-w." (while a file is processed) all warnings back to their defaults and
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

/* ---- RESTORE_OPTION_DEFAULT (CPP 0507:03E3) ---- */

/* Same as the "." case of HANDLE_FLAG_OPTION: keeps the current value of the option byte
   past the end of the file. Refused when no file is being processed. */
static int near pascal RESTORE_OPTION_DEFAULT(Option near *option,char far *argument)
{
    int offset;

    if(SESSION_PHASE==0)
        return 0;
    offset=(char near *)option->variable-OPTION_BLOCK;
    SAVED_OPTION_BLOCK[offset]=*(char near *)option->variable;
    return 1;
}

/* ---- HANDLE_SUBTABLE_OPTION (CPP 0507:0410) ---- */

/* For multi-letter options: the row's variable is a second option table, searched with
   the next letter. */
static int near pascal HANDLE_SUBTABLE_OPTION(register Option near *option,char far *argument)
{
    return DISPATCH_OPTION_TABLE((Option near *)option->variable,argument);
}

/* ---- SET_OPTION_VALUE (CPP 0507:0428) ---- */

/* Stores the row's fixed value into its byte variable (for example a memory model). */
static int near pascal SET_OPTION_VALUE(register Option near *option,char far *argument)
{
    *(char near *)option->variable=option->value;
    return 1;
}

/* ---- IGNORE_OPTION (CPP 0507:043F) ---- */

static int near pascal IGNORE_OPTION(Option near *option,char far *argument)
{
    return 1;
}

/* ---- SET_STRING_OPTION (CPP 0507:0449) ---- */

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

/* ---- SET_BYTE_NUMBER_OPTION (CPP 0507:0494) ---- */
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

/* ---- SET_INT_NUMBER_OPTION (CPP 0507:04E6) ---- */

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

/* ---- IGNORE_OPTION_2 (CPP 0507:0538) ---- */
typedef struct NameEntry NameEntry;
struct NameEntry {
    NameEntry far *next;
    char text[1];
};
extern NameEntry far *ARGUMENT_LIST;
extern NameEntry far *ARGUMENT_LIST_TAIL;

/* CPP.EXE edit: BCC's ADD_NAME_LIST_OPTION (-T), HANDLE_CPP_EXT_OPTION (-P) and
   BCC_SET_OPTION_LIBRARY (-l) are not in CPP.EXE. In their place it has two handlers with
   IGNORE_OPTION's code (image 0x55A8 and 0x55B2), so the options CPP.EXE does not use are
   accepted and ignored. Which option row uses which one is not checked yet; the names are
   descriptive, chosen here. */
static int near pascal IGNORE_OPTION_2(Option near *option,char far *argument)
{
    return 1;
}

static int near pascal IGNORE_OPTION_3(Option near *option,char far *argument)
{
    return 1;
}
#pragma option -G- -y

/* ---- DEFINE_MACROS_OPTION (CPP 0507:054C) ---- */
void far pascal ADD_COMMAND_LINE_MACRO(char far *name, char far *value);
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

/* ---- UNDEFINE_MACRO_OPTION (CPP 0507:0607) ---- */
void far pascal REMOVE_COMMAND_LINE_MACRO(char far *name);
/* -Uname: removes name from the -D list. */
static int near pascal UNDEFINE_MACRO_OPTION(Option near *option, char far *argument)
{
    REMOVE_COMMAND_LINE_MACRO(argument);
    return 1;
}

/* ---- BCC_SET_OPTION_INCLUDE (CPP 0507:061C) ---- */
/* BCC's PATHS module, carried over; in BCC it was a file of its own built with
   -mm -G -O -Z -p -Y. The pragmas switch to -G and no line records, then back to the
   unit default. */
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
/* -L dirs: adds the directories to SEARCH_LIST (in BCC used by FIND_FILE, which
   CPP.EXE does not have). */
static int near pascal BCC_SET_OPTION_LIBRARY_PATH(Option near *option,char far *argument)
{
    BCC_ADD_PATHS(argument,&SEARCH_LIST);
    return 1;
}
#pragma option -G- -y

/* ---- BCC_ADD_PATHS (CPP 0507:0656) ---- */
static char far *near pascal BCC_COPY_PATH(char far *path);
/* BCC's PATHLIB module, carried over; in BCC built with -mm -G -O -Z -p -Y. The
   pragmas switch to -G and no line records, then back to the unit default. */
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

/* ---- ADD_COMMAND_LINE_MACRO (CPP 0507:06EF) ---- */
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

/* ---- REMOVE_COMMAND_LINE_MACRO (CPP 0507:0876) ---- */

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

/* ---- BCC_REVERSE_PATHS (CPP 0507:0903) ---- */
/* BCC's PATHREV module, carried over; in BCC built with -mm -G -O -Z -p. The pragmas
   switch to -G and no line records, then back to the unit default. */
#pragma option -G -y-

/* Reverses INCLUDE_DIR_LIST and SEARCH_LIST in place (see BCC_ADD_PATHS). Called once
   from main (CPPMAIN.C). */
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

/* ---- BCC_COPY_PATH (CPP 0507:09C5) ---- */
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

/* ---- OPEN_INCLUDE_FILE (CPP 0507:0A60) ---- */

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

/* ---- DEFINE_COMMAND_LINE_MACROS (CPP 0507:0AC8) ---- */

extern unsigned int far pascal MACRO_DEFINE(char far *,char far *,signed char,unsigned int);
/* Defines every -D macro in the preprocessor at the start of a file (called from
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

/* ---- HANDLE_EMS_OPTION (CPP 0507:0B28) ---- */

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

/* ---- HANDLE_EXT_MEMORY_OPTION (CPP 0507:0BB4) ---- */
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
