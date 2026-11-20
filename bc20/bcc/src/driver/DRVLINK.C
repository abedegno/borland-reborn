/* target: ovr109_C51UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: driver: handles each command-line file (compile .C/.CPP, assemble .ASM through
   TASM), builds the TASM command and TLINK response file, expands @response files. Entry
   points: ADD_DEFAULT_EXTENSION, PROCESS_FILE_ARGUMENT, PATH_PROCESS,
   BCC_STRING_FILE_APPEND, RUN_LINKER, FATAL_EXIT, NESTING_CHECK, EXPAND_RESPONSE_FILES. Map
   of all sources: docs/SOURCE-MAP.md. */
/* Overview: the resident-side driver that turns BCC's command line into work, used by
   RMAIN13C after all options are read.
   - EXPAND_RESPONSE_FILES (start-up) replaces each @file argument by the words in that
     file (blank-separated; a ';' starts a comment to the end of the line). The file is
     read whole into one MALLOC block, words are cut out in place (BCC_READ_FILE counts
     them) and a new argv vector is built.
   - PROCESS_FILE_ARGUMENT is called for each file argument. It adds the default source extension when the name has none
     (DEFAULT_SOURCE_EXT, the extension set by -P, ".cpp" in the image), expands wildcards
     (EXPAND_WILDCARDS) and calls LG0A1 for every matching file. LG0A1 prints
     "name:" and compiles the file (.c/.cpp, COMPILE_ONE_FILE in OPTIONS.C) or assembles
     it (.asm, PATH_PROCESS); .obj files are only noted. The first file also gives the
     name of the .exe (LINK_OUTPUT_NAME) unless one is already set (probably by -e).
   - PATH_PROCESS builds a TASM command line from the memory model, calling convention,
     float and debug options and every -T argument (ARGUMENT_LIST), and runs TASM through
     RUN_PROGRAM (RDRV388.C). It serves both .asm files given by the user and the .asm
     file BCC itself writes under -B (then the .asm is deleted afterwards).
   - RUN_LINKER writes the TLINK response file TURBOC.$LN through the buffered output
     file (OUTPUT_CHAR): start-up object, object files with /o and /v switches where
     -Yo or -v change between files, the .exe name, the linker switches collected from
     -l options, then the libraries, and runs "tlink @turboc.$ln".
   Helpers: SLASH_FIX turns '/' into '\', FIND_FILE looks for a file in the current
   directory and the -L directories (SEARCH_LIST) and leaves the result in TOKEN_TEXT_BUFFER.
   HAS_LIB_EXTENSION tests whether a name ends in ".lib" (SPECIAL_NAME),
   and STRIP_EXTENSION cuts the extension off a name in place. Errors here set
   COMPILE_FAILED, which makes RUN_LINKER skip the link and BCC exit with status 1. */
#include "DRVLINK.H"
#include "MSG.H"

/* Callback for PROCESS_FILE_ARGUMENT, called once per file that matches a file argument.
   .obj: only strips the extension and, if no .exe name is known yet, uses this name
   (directory included) as LINK_OUTPUT_NAME. Other files: prints "path:" on stdout,
   assembles a .asm file with TASM or compiles anything else, then takes the bare file
   name (no directory) as the .exe name if none is set. A .cpp file is compiled with
   C++ forced (OPTION_FLAGS bit 0); afterwards OPTION_FLAGS gets back its old value plus
   bit 1 (value 2), probably remembering that a C++ file was compiled.
   Always returns 1, so the wildcard walk goes on. */
static int near pascal LG0A1(char far *path)
{
    char extension[6],base[10];
    unsigned char saved;
    FNSPLIT(path,0,0,base,extension);
    if(!STRING_COMPARE(extension,STR_OBJ_2)) {
        STRIP_EXTENSION(path);
        if(!LINK_OUTPUT_NAME) {
            LINK_OUTPUT_NAME=MALLOC(STRING_LENGTH(path)+1);
            STRING_COPY(LINK_OUTPUT_NAME,path);
        }
    } else {
        WRITE_STDOUT_STRING(path);
        WRITE_STDOUT_STRING(STR_COLON_CRLF);
        if(!STRING_COMPARE(extension,STR_ASM_EXT)) PATH_PROCESS(path,0,1);
        else {
            saved=OPTION_FLAGS;
            if(!STRING_COMPARE(extension,STR_CPP_EXT)) {
                OPTION_FLAGS|=1;
                saved|=2;
            }
            COMPILE_FILE_REPORT_ERRORS(path);
            OPTION_FLAGS=saved;
        }
        STRIP_EXTENSION(path);
        if(!LINK_OUTPUT_NAME) {
            LINK_OUTPUT_NAME=MALLOC(STRING_LENGTH(base)+1);
            STRING_COPY(LINK_OUTPUT_NAME,base);
        }
    }
    return 1;
}

/* Not a plain concatenation: returns first unchanged when the file name already has an
   extension (FNSPLIT flag 2), else a new MALLOC block holding first followed by second
   (an extension such as ".obj"). Used to add default extensions. */
char far * far pascal ADD_DEFAULT_EXTENSION(char far *first,char far *second)
{
    char far *buffer;
    if(!(FNSPLIT(first,0,0,0,0)&2)) {
        buffer=MALLOC(STRING_LENGTH(first)+STRING_LENGTH(second)+1);
        STRING_COPY(buffer,first);
        STRING_APPEND(buffer,second);
        first=buffer;
    }
    return first;
}

/* Replaces the extension of first by second: strips it, then adds second. Note that
   first itself is changed (STRIP_EXTENSION cuts it in place). */
static char far * near pascal BCC_STRING_CONCAT_NEAR(char far *first,char far *second)
{
    STRIP_EXTENSION(first);
    return ADD_DEFAULT_EXTENSION(first,second);
}

/* Handles one file argument from the command line (see the overview). .lib files are
   left for RUN_LINKER. If no file matches, reports "Could not find file" with the -g/-j
   limits set to 0 for the moment, so the message always appears, and sets
   COMPILE_FAILED. */
void far pascal PROCESS_FILE_ARGUMENT(char far *path)
{
    unsigned int first,second;
    if(!HAS_LIB_EXTENSION(path)) {
        path=ADD_DEFAULT_EXTENSION(path,DEFAULT_SOURCE_EXT);
        if(EXPAND_WILDCARDS(path,LG0A1)<0) {
            first=OPTION_ERROR_LIMIT;
            second=OPTION_WARNING_LIMIT;
            OPTION_WARNING_LIMIT=OPTION_ERROR_LIMIT=0;
            REPORT_ERROR(MSG_COULD_NOT_FIND_FILE,path);
            COMPILE_FAILED=1;
            OPTION_ERROR_LIMIT=first;
            OPTION_WARNING_LIMIT=second;
        }
    }
}

/* Assembles path with TASM. The command tail is built in arguments+1 (RUN_PROGRAM puts
   the length in arguments[0]):
     path [/o] /D__model__ /D__conv__ /e|/r [/zi] /ml [ /arg ...] ,object  ;
   where each /arg is one -T option's text (ARGUMENT_LIST).
   /o is added for overlay or Windows code, /e (emulator) or /r (real 8087) follows the
   float option, /zi only for a user .asm file with -v.
   mode 0 = the .asm BCC wrote under -B: the object goes to -o's name if given.
   mode 1 = a user .asm file: the object goes to the output directory (-n) under the
   file's own name. remove_original nonzero deletes path after a good assembly.
   TASM's exit code 11 stops BCC at once (probably TASM's fatal abort code); any other
   nonzero code marks the compile failed. */
void far pascal PATH_PROCESS(char far *path,unsigned int remove_original,unsigned int mode)
{
    char *end;
    struct Argument far *argument;
    char name[10];
    int status;
    char arguments[130],original[82];
    register char *command=arguments+1;
    register char *model;
    /* No source position: messages printed from here carry no file and line. */
    CURRENT_FILE_NAME=LOGICAL_LINE=0;
    SLASH_FIX(path);
    RTL_STRNCPY(original,path,80);
    FNSPLIT(path,0,0,name,0);
    STRIP_EXTENSION(path);
    STRING_COPY(command,path);
    if(OPTION_OVERLAY_CODE || OPTION_WINDOWS_MODE) STRING_APPEND(command,STR_O);
    switch(OPTION_MEMORY_MODEL) {
    case 0:model=STR_D_TINY;break;
    case 1:model=STR_D_SMALL;break;
    case 2:model=STR_D_MEDIUM;break;
    case 3:model=STR_D_COMPACT;break;
    case 4:model=STR_D_LARGE;break;
    case 5:model=STR_D_HUGE;break;
    }
    STRING_APPEND(command,model);
    if(OPTION_CALLING_CONVENTION==1) STRING_APPEND(command,STR_D_PASCAL);
    else if(OPTION_CALLING_CONVENTION==2) STRING_APPEND(command,STR_D_FASTCALL);
    else STRING_APPEND(command,STR_D_CDECL);
    STRING_APPEND(command,OPTION_FLOAT_MODE==1 ? STR_E : STR_R);
    if(OPTION_SOURCE_DEBUG && mode) STRING_APPEND(command,STR_ZI);
    STRING_APPEND(command,STR_ML);
    for(argument=ARGUMENT_LIST;argument;argument=argument->next) {
        STRING_APPEND(command,STR_SPACE_SLASH);
        STRING_APPEND(command,argument->text);
    }
    STRING_APPEND(command,STR_SPACE_COMMA);
    if(!mode && OPTION_OBJECT_NAME) {
        SLASH_FIX(OPTION_OBJECT_NAME);
        STRING_APPEND(command,OPTION_OBJECT_NAME);
    } else {
        end=command+STRING_LENGTH(command);
        SLASH_FIX(OPTION_OUTPUT_DIR);
        STRING_APPEND(command,OPTION_OUTPUT_DIR);
        ADD_TRAILING_BACKSLASH(end);
        STRING_APPEND(command,name);
    }
    STRING_APPEND(command,STR_SPACE_SPACE_SEMI);
    status=RUN_PROGRAM(TASM_PROGRAM_NAME,arguments);
    if(status==11) {
        SHUTDOWN_HEAP_BANKS();
        EXIT(1);
    }
    if(status) COMPILE_FAILED=1;
    else if(remove_original) DELETE_FILE(original);
}

/* Compiles one C or C++ file and prints "*** n errors in Compile ***" when it failed. */
static void near pascal COMPILE_FILE_REPORT_ERRORS(char far *path)
{
    int result;
    result=COMPILE_ONE_FILE(path);
    if(result || ERROR_COUNT) {
        RTL_DPRINTF(STR_ERRORS_IN_COMPILE,ERROR_COUNT);
        COMPILE_FAILED=1;
    }
}

/* Writes text to the open output file (here the TLINK response file). */
static void near pascal PUT_STRING(char far *text)
{
    while (*text != 0)
        OUTPUT_CHAR(*text++);
}

static void near pascal SLASH_FIX(char far *path)
{
    while (*path != 0) {
        if (*path == '/')
            *path = '\\';
        path++;
    }
}

/* Writes a file name with '/' turned into '\'. */
static void near pascal PUT_PATH(char far *path)
{
    SLASH_FIX(path);
    PUT_STRING(path);
}

/* Callback used by BCC_STRING_FILE_APPEND for each matching file: writes "+", a line
   break and the object name. A .obj argument is written as given (without extension);
   a source file is written as output directory + base name, the object BCC made from it. */
static int near pascal FILE_APPEND_CALLBACK(char far *path)
{
    char extension[MAXEXT];
    char name[MAXFILE];
    FNSPLIT(path,0,0,name,extension);
    if(STRING_COMPARE(extension,STR_OBJ_2)==0) {
        STRIP_EXTENSION(path);
        PUT_STRING(STR_PLUS_CRLF);
        PUT_PATH(path);
    } else {
        PUT_STRING(STR_PLUS_CRLF);
        STRING_COPY(TOKEN_TEXT_BUFFER,OPTION_OUTPUT_DIR);
        ADD_TRAILING_BACKSLASH(TOKEN_TEXT_BUFFER);
        PUT_PATH(TOKEN_TEXT_BUFFER);
        PUT_PATH(name);
    }
    return 1;
}

/* Adds one file argument to the object list of the response file. A .lib argument only
   sets LINK_LIBRARY_ARG_SEEN; libraries are written later. */
void far pascal BCC_STRING_FILE_APPEND(char far *path)
{
    if(HAS_LIB_EXTENSION(path)) LINK_LIBRARY_ARG_SEEN=1;
    else {
        path=ADD_DEFAULT_EXTENSION(path,DEFAULT_SOURCE_EXT);
        EXPAND_WILDCARDS(path,FILE_APPEND_CALLBACK);
    }
}

/* Callback for the user library list: writes the library name and "+", line break. */
static int near pascal C51_EMIT_PATH_CALLBACK(char far *path)
{
    PUT_PATH(path);
    PUT_STRING(STR_PLUS_CRLF);
    return 1;
}

/* Builds TURBOC.$LN and runs TLINK. count/arguments are the file arguments and the
   options among them (RMAIN13C has already skipped the leading options). Skipped when a
   fatal error longjmps here (ERROR_JUMP_BUFFER), when -c or -S asked for no link
   (C51_SKIP_LINK), or when an earlier step failed. Lines of the response file, in order:
   objects (start-up object first), .exe name, switches, libraries, and for Windows the
   .def file if one exists. TLINK reads a line break in a response file as the next field
   and a trailing "+" as "continued". */
void far pascal RUN_LINKER(int count,char far * far *arguments)
{
    int result,saved_count;
    char far * far *saved_arguments;
    struct C51Libraries near *libraries;
    int overlay_emitted,overlay_requested,changed;
    signed char windows_model;
    unsigned char dll_mode;
    register int debug_requested;
    register int debug_emitted;
    if(C45_SETJUMP(ERROR_JUMP_BUFFER)!=0 || C51_SKIP_LINK!=0 || (int)COMPILE_FAILED>0)
        return;
    result=CREATE_OUTPUT_FILE(STR_TURBOC_LN);
    if(result<0) FATAL_EXIT(MSG_UNABLE_CREATE_TURBOC);
    /* Pick the start-up object and library names for the memory model. For Windows the
       third letter of the start-up name becomes 'd' (DLL) or 'w' (application). */
    if(OPTION_WINDOWS_MODE!=0) {
        dll_mode=OPTION_WINDOWS_MODE==2 || OPTION_WINDOWS_MODE==5;
        libraries=C51_WINDOWS_LIBRARIES+OPTION_MEMORY_MODEL;
        libraries->startup[2]=dll_mode ? 'd' : 'w';
    } else libraries=C51_DOS_LIBRARIES+OPTION_MEMORY_MODEL;
    /* With the SS==DS option the start-up object comes from STARTUP_SS_DS_NAMES, which
       holds the c0f?.obj names (c0ft.obj ... ). */
    if(OPTION_SS_EQUALS_DS!=0 && !(signed char)OPTION_WINDOWS_MODE)
        FIND_FILE(STARTUP_SS_DS_NAMES[OPTION_MEMORY_MODEL],0);
    else FIND_FILE(libraries->startup,0);
    PUT_PATH(TOKEN_TEXT_BUFFER);
    if(OPTION_WINDOWS_MODE!=0) {
        windows_model=OPTION_MEMORY_MODEL;
        if(dll_mode!=0) {
            windows_model=C51_DLL_MODEL[windows_model];
            libraries=C51_WINDOWS_LIBRARIES+windows_model;
        }
    }
    saved_count=count;
    saved_arguments=arguments;
    changed=0;
    debug_emitted=(signed char)OPTION_SOURCE_DEBUG;
    debug_requested=0;
    /* First pass: find whether any -v / -v- among the files differs from the leading -v
       state. If so ("changed"), debug info is switched per file with /v+ and /v- instead
       of one global /v. (-vi, inline control, is not a debug switch.) */
    while(count>0) {
        if((*arguments)[0]=='-' && (*arguments)[1]=='v' && (*arguments)[2]!='i') {
            debug_requested=!(*arguments)[2];
            changed|=(debug_requested!=0 && debug_emitted==0) ||
                     (debug_requested==0 && debug_emitted!=0);
        }
        ++arguments;
        --count;
    }
    count=saved_count;
    arguments=saved_arguments;
    /* Second pass: write the object files. Before a file whose -Yo or -v state differs
       from what was last written, emit "+", line break and /o, /o-, /v+ or /v-.
       As written, any option other than -Y... reaches the "debug_requested" branch, not
       only -v (the first pass checks for 'v'; this one does not). */
    debug_requested=(signed char)OPTION_SOURCE_DEBUG;
    debug_emitted=OPTION_SOURCE_DEBUG!=0 && changed==0;
    overlay_emitted=0;
    overlay_requested=(signed char)OPTION_LINK_OVERLAY;
    while(count>0) {
        if((*arguments)[0]=='-') {
            if((*arguments)[1]=='Y') overlay_requested=!(*arguments)[3];
            else if((*arguments)[2]!='i') debug_requested=!(*arguments)[2];
        } else if(!HAS_LIB_EXTENSION(*arguments)) {
            if((overlay_requested!=0 && overlay_emitted==0) ||
               (overlay_requested==0 && overlay_emitted!=0) ||
               (debug_requested!=0 && debug_emitted==0) ||
               (debug_requested==0 && debug_emitted!=0)) {
                PUT_STRING(STR_PLUS_CRLF);
                if((overlay_emitted!=0 && overlay_requested==0) ||
                   (overlay_emitted==0 && overlay_requested!=0)) {
                    overlay_emitted=overlay_requested;
                    PUT_STRING(overlay_emitted!=0 ? STR_O : STR_O_2);
                }
                if((debug_emitted!=0 && debug_requested==0) ||
                   (debug_emitted==0 && debug_requested!=0)) {
                    debug_emitted=debug_requested;
                    PUT_STRING(debug_emitted!=0 ? STR_V : STR_V_2);
                }
            }
            BCC_STRING_FILE_APPEND(*arguments);
        } else LINK_LIBRARY_ARG_SEEN=1;
        ++arguments;
        --count;
    }
    /* STR_COLON_CRLF is ":\r\n"; +1 writes just the line break that ends a field. */
    PUT_STRING(STR_COLON_CRLF+1);
    STRING_COPY(TOKEN_TEXT_BUFFER,OPTION_OUTPUT_DIR);
    ADD_TRAILING_BACKSLASH(TOKEN_TEXT_BUFFER);
    PUT_PATH(TOKEN_TEXT_BUFFER);
    PUT_PATH(LINK_OUTPUT_NAME);
    if(OPTION_WINDOWS_MODE!=0 && dll_mode!=0 && !(FNSPLIT(LINK_OUTPUT_NAME,0,0,0,0)&2))
        PUT_STRING(STR_DLL);
    PUT_STRING(STR_COLON_CRLF+1);
    /* Linker switches: /a../z, /A../Z, /0../9 from LINKER_SWITCH_FLAGS and the
       C51_*_LINK_OPTIONS arrays (all filled by the -l option, BCC_SET_OPTION_LIBRARY in
       OPTIONS.C), then /y? and /T? switches. A DLL gets /Twd. */
    if(changed!=0) LINKER_SWITCH_FLAGS['v'-'a']=0;
    for(result=0;result<26;++result) {
        if(LINKER_SWITCH_FLAGS[result]!=0) { OUTPUT_CHAR('/');OUTPUT_CHAR(result+'a'); }
    }
    for(result=0;result<26;++result) {
        if(C51_UPPER_LINK_OPTIONS[result]!=0) { OUTPUT_CHAR('/');OUTPUT_CHAR(result+'A'); }
    }
    for(result=0;result<10;++result) {
        if(C51_DIGIT_LINK_OPTIONS[result]!=0) { OUTPUT_CHAR('/');OUTPUT_CHAR(result+'0'); }
    }
    for(result=0;result<26;++result) {
        if(C51_Y_LINK_OPTIONS[result]!=0) { PUT_STRING(STR_Y);OUTPUT_CHAR(result+'a'); }
    }
    if(OPTION_WINDOWS_MODE!=0 && dll_mode!=0) {
        C51_T_LINK_OPTIONS['w'-'a']=0;
        PUT_STRING(STR_TWD);
    }
    for(result=0;result<26;++result) {
        if(C51_T_LINK_OPTIONS[result]!=0) { PUT_STRING(STR_T);OUTPUT_CHAR(result+'a'); }
    }
    PUT_STRING(STR_COLON_CRLF+1);
    /* User libraries (.lib arguments), each looked up in the current directory first and
       then in the -L directories, again with /o and /v switches where -Yo/-v change. */
    if(LINK_LIBRARY_ARG_SEEN!=0) {
        overlay_emitted=overlay_requested=0;
        debug_requested=(signed char)OPTION_SOURCE_DEBUG;
        while(saved_count>0) {
            if((*saved_arguments)[0]=='-') {
                if((*saved_arguments)[1]=='Y') overlay_requested=!(*saved_arguments)[3];
                else if((*saved_arguments)[2]!='i') debug_requested=!(*saved_arguments)[2];
            } else if(HAS_LIB_EXTENSION(*saved_arguments)) {
                if((overlay_requested!=0 && overlay_emitted==0) ||
                   (overlay_requested==0 && overlay_emitted!=0) ||
                   (debug_requested!=0 && debug_emitted==0) ||
                   (debug_requested==0 && debug_emitted!=0)) {
                    if((overlay_requested!=0 && overlay_emitted==0) ||
                       (overlay_requested==0 && overlay_emitted!=0)) {
                        overlay_emitted=overlay_requested;
                        PUT_STRING(overlay_emitted!=0 ? STR_O : STR_O_2);
                    }
                    if((debug_requested!=0 && debug_emitted==0) ||
                       (debug_requested==0 && debug_emitted!=0)) {
                        debug_emitted=debug_requested;
                        PUT_STRING(debug_emitted!=0 ? STR_V : STR_V_2);
                    }
                    PUT_STRING(STR_PLUS_CRLF);
                }
                FIND_FILE(*saved_arguments,1);
                EXPAND_WILDCARDS(TOKEN_TEXT_BUFFER,C51_EMIT_PATH_CALLBACK);
            }
            ++saved_arguments;
            --saved_count;
        }
        if(overlay_emitted!=0) PUT_STRING(STR_O_3);
    }
    /* Then the standard libraries: OVERLAY.LIB for -Y; IMPORT.LIB and the Windows
       run-time for Windows; EMU.LIB or FP87.LIB and the model's math library when floating
       point is on; last the model's C run-time library. */
    if(OPTION_OVERLAY_CODE!=0) {
        FIND_FILE(STR_OVERLAY_LIB,0);
        PUT_PATH(TOKEN_TEXT_BUFFER);
        PUT_STRING(STR_PLUS_CRLF);
    }
    if(OPTION_WINDOWS_MODE!=0) {
        FIND_FILE(STR_IMPORT_LIB,0);
        PUT_PATH(TOKEN_TEXT_BUFFER);
        PUT_STRING(STR_PLUS_CRLF);
        FIND_FILE(C51_WINDOWS_RUNTIME[windows_model],0);
        PUT_PATH(TOKEN_TEXT_BUFFER);
        PUT_STRING(STR_PLUS_CRLF);
        if(OPTION_FLOAT_MODE!=0) {
            FIND_FILE(libraries->math,0);
            PUT_PATH(TOKEN_TEXT_BUFFER);
            PUT_STRING(STR_PLUS_CRLF);
        }
    } else if(OPTION_FLOAT_MODE!=0) {
        if(OPTION_FLOAT_MODE==1) FIND_FILE(STR_EMU_LIB,0);
        else FIND_FILE(STR_FP87_LIB,0);
        PUT_PATH(TOKEN_TEXT_BUFFER);
        PUT_STRING(STR_PLUS_CRLF);
        FIND_FILE(libraries->math,0);
        PUT_PATH(TOKEN_TEXT_BUFFER);
        PUT_STRING(STR_PLUS_CRLF);
    }
    FIND_FILE(libraries->runtime,0);
    PUT_PATH(TOKEN_TEXT_BUFFER);
    /* Windows: name the module definition file <exe>.def if it exists (FILE_TIME is 0
       when it does not). */
    if(OPTION_WINDOWS_MODE!=0) {
        STRING_COPY(TOKEN_TEXT_BUFFER,BCC_STRING_CONCAT_NEAR(LINK_OUTPUT_NAME,STR_DEF));
        SLASH_FIX(TOKEN_TEXT_BUFFER);
        if(FILE_TIME(TOKEN_TEXT_BUFFER)!=0L) {
            PUT_STRING(STR_COLON_CRLF+1);
            PUT_STRING(TOKEN_TEXT_BUFFER);
        }
    }
    CLOSE_OUTPUT_FILE();
    result=RUN_PROGRAM(STR_TLINK_EXE,STR_TURBOC_LN_2);
    DELETE_FILE(STR_TURBOC_LN);
    if(result>=1) COMPILE_FAILED=1;
}

/* Returns 1 when path has the extension ".lib" (SPECIAL_NAME), else 0. */
static int near pascal HAS_LIB_EXTENSION(char far *path)
{
    char component[6];
    int result;

    result = FNSPLIT(path, 0, 0, 0, component);
    if ((result & 2) && STRING_COMPARE(component, SPECIAL_NAME) == 0)
        return 1;
    return 0;
}

/* Expands a file name that may hold wildcards: for every match (findfirst/findnext)
   builds drive + directory + found name in lower case and calls callback with it.
   Returns -1 when nothing matches, 0 when the callback asked to stop (returned 0), 1
   otherwise. */
static int near pascal EXPAND_WILDCARDS(char far *path,int (near pascal *callback)(char far *))
{
    char drive[4];
    char far *cursor;
    struct ffblk search;
    char combined[82];
    char directory[68];
    if(FINDFIRST(path,&search,0)<0) return -1;
    FNSPLIT(path,drive,directory,0,0);
    do {
        FNMERGE(combined,drive,directory,search.ff_name,0);
        cursor=combined;
        while(*cursor) {*cursor=TOLOWER(*cursor);++cursor;}
        if(!callback(combined)) return 0;
    } while(FINDNEXT(&search)>=0);
    return 1;
}

/* Removes the extension of path in place by writing 0 over the first '.', if the name
   has an extension. (A '.' in a directory name would cut there; the code does not guard
   against it.) */
static void near pascal STRIP_EXTENSION(char far *path)
{
    if (FNSPLIT(path, 0, 0, 0, 0) & 2)
        *STRING_FIND_CHAR(path, '.') = 0;
}

/* Reports message number error (limits set to 0 so it always shows) and exits with 1. */
void far pascal FATAL_EXIT(int error)
{
    OPTION_WARNING_LIMIT = OPTION_ERROR_LIMIT = 0;
    REPORT_ERROR(error);
    EXIT(1);
}

/* Counts calls; every 200th call makes a DOS "check input status" call (int 21h,
   AH=0Bh). DOS tests for Ctrl-C/Ctrl-Break during such calls, so this lets the user
   break into long work. BREAK_POLL_COUNTER is only this counter, not a nesting depth. */
void far pascal NESTING_CHECK(void)
{
    BREAK_POLL_COUNTER++;
    if (BREAK_POLL_COUNTER > 200) {
        DOS_CALL_AH(11, 0, 0);
        BREAK_POLL_COUNTER = 0;
    }
}

/* Locates a file for the link and leaves its name in TOKEN_TEXT_BUFFER. A name with a drive or
   a leading slash is used as is. Otherwise, if check_current is set and the file exists
   in the current directory, that is used; else each -L directory (SEARCH_LIST) is tried
   in turn. If nothing is found, TOKEN_TEXT_BUFFER holds the bare name (TLINK then reports it). */
static void near pascal FIND_FILE(char far *path, int check_current)
{
    struct ffblk info;
    struct search_entry far *entry;

    if (path[1] == ':' || path[0] == '\\' || path[0] == '/') {
        STRING_COPY(TOKEN_TEXT_BUFFER, path);
    } else {
        if (check_current != 0 && FINDFIRST(path, &info, 0) >= 0) {
            STRING_COPY(TOKEN_TEXT_BUFFER, path);
        } else {
            for (entry = SEARCH_LIST; entry != 0; entry = entry->next) {
                STRING_COPY(TOKEN_TEXT_BUFFER, entry->directory);
                STRING_APPEND(TOKEN_TEXT_BUFFER, path);
                if (FINDFIRST(TOKEN_TEXT_BUFFER, &info, 0) >= 0)
                    return;
            }
            STRING_COPY(TOKEN_TEXT_BUFFER, path);
        }
    }
}

/* Reads a whole response file into one MALLOC block ended by a ^Z (26) byte, stores it
   in a new LineBuffer node (*out) and returns the number of words in it. Words are cut
   in place: the blank after each word is overwritten with 0. Lines starting with ';' are
   comments. _CTYPE[ch+1]&1 is the run-time library's isspace test. */
static unsigned int near pascal BCC_READ_FILE(unsigned int handle, struct LineBuffer far * far *out)
{
    register int ch;
    register unsigned int count;
    struct LineBuffer far *node;
    char far *text;

    *out = node = (struct LineBuffer far *)MALLOC(8);
    count = RTL_LSEEK(handle, 0L, 2);
    RTL_LSEEK(handle, 0L, 0);
    text = MALLOC(count + 1);
    RTL_READ(handle, text, count);
    text[count] = 26;
    node->text = text;
    count = 0;
    for (;;) {
        do {
            ch = *text++;
        } while ((_CTYPE[ch + 1] & 1) || ch == 13 || ch == 0);
        if (ch == 26)
            break;
        if (ch == ';') {
            while (ch && ch != 10)
                ch = *text++;
        } else {
            ++count;
            do {
                ch = *text++;
            } while (!(_CTYPE[ch + 1] & 1) && ch != 13 && ch != 26);
            if (ch == 26)
                break;
            text[-1] = 0;
        }
    }
    return count;
}

/* Replaces every "@file" argument by the words of that file (see BCC_READ_FILE) and
   updates *count and *arguments to the new vector. Does nothing when no argument starts
   with '@'. A missing response file is fatal. The first loop reads all files and counts
   the words; the second builds the new vector, taking pointers into the file texts. */
void far pascal EXPAND_RESPONSE_FILES(int far *count,char far * far * far *arguments)
{
    int total,original_count,handle;
    char far * far *original;
    char far * far *output;
    char far *text;
    struct LineBuffer far *first;
    struct LineBuffer far *last;
    struct LineBuffer far *node;
    register int value;
    register int index;
    original_count=*count;
    index=0;
    original=*arguments;
    while(index<original_count) {
        if((*original)[0]=='@') break;
        ++index;
        ++original;
    }
    if(index==original_count) return;
    first=last=0;
    total=original_count;
    while(index<original_count) {
        if((*original)[0]=='@') {
            --total;
            handle=RTL_OPEN(*original+1,0);
            if(handle<0) {
                OPTION_WARNING_LIMIT=OPTION_ERROR_LIMIT=0;
                REPORT_ERROR(MSG_COULD_NOT_FIND_FILE,*original+1);
                SHUTDOWN_HEAP_BANKS();
                EXIT(1);
            }
            total+=BCC_READ_FILE(handle,&node);
            RTL_CLOSE(handle);
            if(last!=0) last->next=node;
            else first=node;
            last=node;
        }
        ++index;
        ++original;
    }
    original=*arguments;
    *count=total;
    *arguments=output=(char far * far *)MALLOC(total*sizeof(char far *));
    index=0;
    while(index<original_count) {
        if((*original)[0]=='@') {
            text=first->text;
            for(;;) {
                do { value=*text++; }
                while((_CTYPE[value+1]&1)!=0 || value==13 || value==0);
                if(value==26) break;
                if(value==';') {
                    while(value!=0 && value!=10) value=*text++;
                } else {
                    *output++=text-1;
                    do { value=*text++; } while(value!=0 && value!=26);
                    if(value==26) { text[-1]=0;break; }
                }
            }
            first=first->next;
        } else *output++=*original;
        ++index;
        ++original;
    }
}
