/* target: CONFIG */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module CONFIG (image 0x601B..0x64CE, frame 0601h): the configuration-file
   and option reader. Source taken from the BCC.EXE reconstruction
   (bcc20/src/driver/CONFIG.C), all four functions in BCC's order, with
   CPP.EXE's edits marked "CPP.EXE edit" (no TCDEF.SYM lookup; cdecl exit). Switches: -G-
   here, where BCC's file has -G: the cdecl exit(1) pops its argument with `pop cx`, which
   BC 2.0 writes under -G- (under -G it writes `inc sp; inc sp`). BCC's version has no
   cdecl call with one word to pop, so its -G was not tested by its bytes. */
/* Role: reads TURBOC.CFG (from the current directory or the directory CPP.EXE was
   started from) and the command-line options. Entry point: READ_CONFIG_AND_ARGS. */
/* Overview: READ_CONFIG_AND_ARGS is called once from main (CPPMAIN.C), after @response
   files are expanded, and applies every option, in this order:
   1. Finds the directory CPP.EXE was started from (DOS 3+ stores the program's full path
      after the environment strings). BCC also looked for its precompiled-header file
      TCDEF.SYM here; CPP.EXE has no precompiled headers and skips that.
   2. Pre-scans the leading options: "+file" names another configuration file
      (C53_OPTION_PATH, TURBOC.CFG by default); -I and -L are applied now (pass 65535) so
      their directories come before those of the configuration file.
   3. Reads the configuration file (current directory, then CPP.EXE's directory; a file
      named with + must exist) into a pool segment and applies each word as an option
      (pass 1). BCC_LINE_READ hands out one word at a time; ';' starts a comment.
   4. Applies the leading command-line options again, all but -I/-L (pass 0), so they
      win over the file.
   5. Checks options that appear between file names: only -Yo, -Yo-, -v, -v-, -vi and
      -vi- are allowed there. This check and the -S/-B flag updates at the end are BCC's
      code kept unchanged; CPP.EXE has no overlays, assembly output or link step, so
      probably nothing in CPP.EXE acts on those flags.
   APPLY_OPTION (OPTIONS.C) reads the pass number. A bad option is fatal (FILE_FATAL),
   naming "command line" or "configuration file". At the end the warning switches are
   saved as the defaults each file starts from (SAVE_WARNINGS_AS_DEFAULT). */
#include "CONFIG.H"
#include "MSG.H"
/* CPP.EXE edit: CPP.EXE's start-up exports a cdecl exit (0000:00B1, `push 1; call far;
   pop cx`) where BCC calls the pascal EXIT. */
extern void far cdecl exit(int);

/* argc/argv: the expanded command line, argv[0] the program name. Returns the argv entry
   after the last argument (the vector's end); main ignores it. */
char far * far pascal READ_CONFIG_AND_ARGS(register int argc,char far * far *argv)
{
    char far * far *cursor;
    char drive[MAXDRIVE+1];
    int remaining;
    unsigned int size;
    int explicit_config;
    char far *environment;
    char far *argument;
    char token[129];
    char directory[MAXDIR+1];
    char pathname[MAXPATH+1];
    register int handle;

    RESET_WARNINGS_TO_DEFAULT();
    environment=0;
    /* DOS function 30h (get version): AL is the major version. From DOS 3 on, the
       environment block is followed by a word count and the program's full path; walk
       past the double 0 that ends the strings and skip 3 bytes (the 0 and the count). */
    remaining=DOS_CALL_AH(48,0,0)&255;
    if(remaining>=3) {
        environment=(char far *)((long)ENVIRONMENT_SEG<<16);
        while(*environment) {
            while(*++environment) ;
            ++environment;
        }
        environment+=3;
        FNSPLIT(environment,drive,directory,0,0);
    }
    /* CPP.EXE edit: no precompiled headers, so no TCDEF.SYM lookup: CPP.EXE goes from
       FNSPLIT (0x609D) straight to explicit_config=0. FILE_TEST below is kept although
       nothing calls it now (it is still in CPP.EXE at 0x6471). */
    explicit_config=0;
    remaining=argc-1;
    cursor=argv+1;
    /* Pre-scan (step 2 of the overview). MALLOC(STRING_LENGTH(*cursor)) is exactly
       enough for the name after '+' plus its 0. */
    while(remaining>0 && (**cursor=='-' || **cursor=='+')) {
        if(**cursor=='+') {
            C53_OPTION_PATH=MALLOC(STRING_LENGTH(*cursor));
            STRING_COPY(C53_OPTION_PATH,*cursor+1);
            explicit_config=1;
        } else if(!APPLY_OPTION(*cursor+1,65535U)) {
            FILE_FATAL(C53_COMMAND_LINE,*cursor);
        }
        ++cursor;
        --remaining;
    }
    handle=RTL_OPEN(C53_OPTION_PATH,0);
    if(handle<0) {
        if(explicit_config) {
            OPTION_ERROR_LIMIT=0;
            REPORT_ERROR(MSG_COULD_NOT_FIND_FILE,C53_OPTION_PATH);
            SHUTDOWN_HEAP_BANKS();
            exit(1);            /* CPP.EXE edit: cdecl exit */
        } else if(environment) {
            FNMERGE(pathname,drive,directory,C53_OPTION_PATH,0);
            handle=RTL_OPEN(pathname,0);
        }
    }
    /* Read the whole configuration file into a new pool segment (BCC_LINE_SEGMENT),
       put a ^Z (26) after it as end mark and apply its words one by one. */
    if(handle>=0) {
        size=RTL_LSEEK(handle,0L,2);
        RTL_LSEEK(handle,0L,0);
        POOL_INIT(&BCC_LINE_SEGMENT,size+1);
        BCC_LINE_OFFSET=0;
        RTL_READ(handle,MK_FP(BCC_LINE_SEGMENT,0),size);
        RTL_CLOSE(handle);
        *(char far *)MK_FP(BCC_LINE_SEGMENT,BCC_LINE_OFFSET+size)=26;
        for(;;) {
            remaining=BCC_LINE_READ(token);
            if(remaining==-1) break;
            if(token[0]!='-' || !APPLY_OPTION(token+1,1))
                FILE_FATAL(C53_CONFIG_FILE,token);
        }
        FREE_HANDLE_BLOCK(&BCC_LINE_SEGMENT);
    }
    --argc;
    ++argv;
    while(argc>0 && (**argv=='-' || **argv=='+')) {
        if(**argv=='-' && !APPLY_OPTION(*argv+1,0))
            FILE_FATAL(C53_COMMAND_LINE,*argv);
        ++argv;
        --argc;
    }
    while(argc>0) {
        if(**argv=='-') {
            argument=*argv+1;
            if(!COMPARE_NAME(argument,OPT_TEXT_YO) || !COMPARE_NAME(argument,C53_YO_OFF))
                OPTION_OVERLAY_CODE=1;
            else if(COMPARE_NAME(argument,OPT_TEXT_V) && COMPARE_NAME(argument,C53_V_OFF) &&
                    COMPARE_NAME(argument,OPT_TEXT_VI) && COMPARE_NAME(argument,C53_VI_OFF))
                FILE_FATAL(C53_COMMAND_LINE,*argv);
        }
        ++argv;
        --argc;
    }
    /* BCC's code, kept: in BCC COMPILER_MODE here holds -S (assembly output only), which
       also means no link, and after this it is nonzero whenever assembly text is written
       (-S, or -B: OPTION_COMPILE_VIA_ASM, compile through TASM). CPP.EXE has neither. */
    C51_SKIP_LINK|=COMPILER_MODE;
    COMPILER_MODE|=OPTION_COMPILE_VIA_ASM;
    SAVE_WARNINGS_AS_DEFAULT();
    return *argv;
}

/* Copies the next blank-separated word of the configuration text (BCC_LINE_SEGMENT at
   BCC_LINE_OFFSET) into out and returns 1; returns -1 at the end of the text. A word
   starting with ';' begins a comment to the end of the line. When the ^Z end mark is
   read the offset is stepped back, so later calls see it again. */
static int near pascal BCC_LINE_READ(char far *out)
{
    int ch;
    for(;;) {
        do {
            ch=((char far *)MK_FP(BCC_LINE_SEGMENT,0))[BCC_LINE_OFFSET++];
        } while((_CTYPE[ch+1]&1) || ch==13);
        if(ch==0 || ch==26) return -1;
        if(ch==';') {
            while(ch && ch!=10 && ch!=26)
                ch=((char far *)MK_FP(BCC_LINE_SEGMENT,0))[BCC_LINE_OFFSET++];
            if(ch==26) --BCC_LINE_OFFSET;
        } else break;
    }
    do {
        *out++=ch;
        ch=((char far *)MK_FP(BCC_LINE_SEGMENT,0))[BCC_LINE_OFFSET++];
    } while(!(_CTYPE[ch+1]&1) && ch && ch!=13 && ch!=26);
    if(ch==26) --BCC_LINE_OFFSET;
    *out=0;
    return 1;
}

/* Returns 1 when path names an existing file. */
static int near pascal FILE_TEST(char far *path)
{
    struct ffblk info;
    return FINDFIRST(path,&info,0)==0;
}

/* Reports "Incorrect <where> option: <option>" (first = "command line" or
   "configuration file", second = the option) and exits with status 1. */
static void near pascal FILE_FATAL(char far *first,char far *second)
{
    OPTION_ERROR_LIMIT=0;
    REPORT_ERROR(MSG_INCORRECT_OPTION,first,second);
    SHUTDOWN_HEAP_BANKS();
    exit(1);                /* CPP.EXE edit: cdecl exit */
}
