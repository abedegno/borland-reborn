/* target: DRVLINK */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module DRVLINK (image 0x10123..0x1076B, frame 1012h): the driver's
   per-file loop and @response-file expansion. Source taken from the BCC.EXE
   reconstruction (bcc20/src/driver/DRVLINK.C). CPP.EXE has only some of
   its functions, in the same order; left out here: PATH_PROCESS, PUT_STRING, SLASH_FIX,
   PUT_PATH, FILE_APPEND_CALLBACK, BCC_STRING_FILE_APPEND, C51_EMIT_PATH_CALLBACK,
   RUN_LINKER, HAS_LIB_EXTENSION, FIND_FILE (BCC's TASM and TLINK steps; CPP.EXE has
   neither). CPP.EXE's edits to the rest are marked "CPP.EXE edit" (PREPROCESS_ONE_FILE,
   PROCESS_FILE_ARGUMENT, cdecl exit). */
/* Role: driver: preprocesses each command-line file and expands @response files. Entry
   points: ADD_DEFAULT_EXTENSION, PROCESS_FILE_ARGUMENT, FATAL_EXIT, NESTING_CHECK,
   EXPAND_RESPONSE_FILES. */
/* Overview: the driver that turns CPP's command line into work, used by main
   (CPPMAIN.C) after all options are read.
   - EXPAND_RESPONSE_FILES (start-up) replaces each @file argument by the words in that
     file (blank-separated; a ';' starts a comment to the end of the line). The file is
     read whole into one MALLOC block, words are cut out in place (BCC_READ_FILE counts
     them) and a new argv vector is built.
   - PROCESS_FILE_ARGUMENT is called for each file argument. It adds the default source
     extension when the name has none (DEFAULT_SOURCE_EXT, ".cpp" in the image), expands
     wildcards (EXPAND_WILDCARDS) and calls PREPROCESS_ONE_FILE for every matching file.
     PREPROCESS_ONE_FILE prints "name:" and preprocesses the file (COMPILE_ONE_FILE in
     OPTIONS.C). It still records the first file's bare name in LINK_OUTPUT_NAME, BCC's
     .exe name; nothing else in CPP.EXE's sources reads that variable.
   Helpers: STRIP_EXTENSION cuts the extension off a name in place; BCC_STRING_CONCAT_NEAR
   replaces an extension. Errors here set COMPILE_FAILED, which makes CPP.EXE exit with
   status 1. */
#include "DRVLINK.H"
#include "MSG.H"
/* CPP.EXE edit: CPP.EXE's start-up exports a cdecl exit (0000:00B1, `push 1; call far;
   pop cx`) where BCC calls the pascal EXIT. */
extern void far cdecl exit(int);

/* Callback for PROCESS_FILE_ARGUMENT, called once per file that matches a file argument.
   Prints "path:" on stdout and preprocesses the file, then takes the bare file name (no
   directory) as LINK_OUTPUT_NAME if none is set. A .cpp file is processed with
   OPTION_FLAGS bit 0 set (BCC's "C++" flag); afterwards OPTION_FLAGS gets back its old
   value plus bit 1 (value 2), probably remembering that a .cpp file was seen.
   Always returns 1, so the wildcard walk goes on. */
/* CPP.EXE edit: no .obj and no .asm branch. CPP.EXE (0x10123) splits the name, prints
   "path:" and goes straight to the .cpp test and the compile; the rest is BCC's
   "other files" branch. */
static int near pascal PREPROCESS_ONE_FILE(char far *path)
{
    char extension[6],base[10];
    unsigned char saved;
    FNSPLIT(path,0,0,base,extension);
    WRITE_STDOUT_STRING(path);
    WRITE_STDOUT_STRING(STR_COLON_CRLF);
    saved=OPTION_FLAGS;
    if(!STRING_COMPARE(extension,STR_CPP_EXT)) {
        OPTION_FLAGS|=1;
        saved|=2;
    }
    COMPILE_FILE_REPORT_ERRORS(path);
    OPTION_FLAGS=saved;
    STRIP_EXTENSION(path);
    if(!LINK_OUTPUT_NAME) {
        LINK_OUTPUT_NAME=MALLOC(STRING_LENGTH(base)+1);
        STRING_COPY(LINK_OUTPUT_NAME,base);
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

/* Handles one file argument from the command line (see the overview). If no file
   matches, reports "Could not find file" with the -g/-j
   limits set to 0 for the moment, so the message always appears, and sets
   COMPILE_FAILED. */
/* CPP.EXE edit: no HAS_LIB_EXTENSION test (there is no linker); CPP.EXE (0x10274)
   starts with ADD_DEFAULT_EXTENSION. */
void far pascal PROCESS_FILE_ARGUMENT(char far *path)
{
    unsigned int first,second;
    path=ADD_DEFAULT_EXTENSION(path,DEFAULT_SOURCE_EXT);
    if(EXPAND_WILDCARDS(path,PREPROCESS_ONE_FILE)<0) {
        first=OPTION_ERROR_LIMIT;
        second=OPTION_WARNING_LIMIT;
        OPTION_WARNING_LIMIT=OPTION_ERROR_LIMIT=0;
        REPORT_ERROR(MSG_COULD_NOT_FIND_FILE,path);
        COMPILE_FAILED=1;
        OPTION_ERROR_LIMIT=first;
        OPTION_WARNING_LIMIT=second;
    }
}

/* (BCC's PATH_PROCESS, the TASM runner, is not in CPP.EXE.) */

/* Preprocesses one file and prints "*** n errors in Compile ***" when it failed. */
static void near pascal COMPILE_FILE_REPORT_ERRORS(char far *path)
{
    int result;
    result=COMPILE_ONE_FILE(path);
    if(result || ERROR_COUNT) {
        RTL_DPRINTF(STR_ERRORS_IN_COMPILE,ERROR_COUNT);
        COMPILE_FAILED=1;
    }
}




/* (BCC's PUT_STRING, SLASH_FIX, PUT_PATH, FILE_APPEND_CALLBACK, BCC_STRING_FILE_APPEND,
   C51_EMIT_PATH_CALLBACK, RUN_LINKER and HAS_LIB_EXTENSION are not in CPP.EXE.) */

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
    exit(1);                /* CPP.EXE edit: cdecl exit */
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
                exit(1);    /* CPP.EXE edit: cdecl exit */
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
