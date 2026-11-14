/* config.c: from bcc20/src/driver/CONFIG.C (overlay CO036): READ_CONFIG_AND_ARGS, called
   once from RMAIN13C after @response files are expanded, applies every option BCC will use,
   in this order:
   1. Finds the directory BCC.EXE was started from (DOS 3+ stores the program's full path
      after the environment strings) and sets PCH_FILE_NAME, the default precompiled header
      file TCDEF.SYM: in the current directory if it exists there, else in BCC.EXE's
      directory.
   2. Pre-scans the leading options: "+file" names another configuration file
      (C53_OPTION_PATH, TURBOC.CFG by default); -I and -L are applied now (pass 65535) so
      their directories come before those of the configuration file.
   3. Reads the configuration file (current directory, then BCC.EXE's directory; a file
      named with + must exist) into a pool segment and applies each word as an option (pass
      1).  BCC_LINE_READ hands out one word at a time; ';' starts a comment.
   4. Applies the leading command-line options again, all but -I/-L (pass 0), so they win
      over the file.
   5. Checks options that appear between file names: only -Yo, -Yo-, -v, -v-, -vi and -vi-
      are allowed there.
   A bad option is fatal (FILE_FATAL), naming "command line" or "configuration file".  At
   the end the warning switches are saved as the defaults each compile starts from. */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define ENVIRONMENT_SEG W(ENVIRONMENT_SEG_P)
/* far pointers (CONFIG.H), where globals.h reads a word */
#undef PCH_FILE_NAME
#undef C53_OPTION_PATH
#define PCH_FILE_NAME D(PCH_FILE_NAME_P)
#define C53_OPTION_PATH D(C53_OPTION_PATH_P)
#define OPTION_OVERLAY_CODE B(OPTION_OVERLAY_CODE_P)
#define COMPILER_MODE B(COMPILER_MODE_P)
#define OPTION_COMPILE_VIA_ASM B(OPTION_COMPILE_VIA_ASM_P)

/* the first character of the argument at argument vector entry entry */
#define ARG_CHAR(entry) SB(D(entry))

/* argc/argv: the expanded command line, argv[0] the program name.  Returns the argv entry
   after the last argument (the vector's end).  The locals whose addresses are passed sit
   in BCC's frame (12Eh bytes): drive at bp-8, directory at bp-DCh, token at bp-98h,
   pathname at bp-12Eh */
farptr READ_CONFIG_AND_ARGS(i16 argc, farptr argv)
{
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x12E);
    farptr drive = fp_add(v, 0x126), directory = fp_add(v, 0x52);
    farptr token = fp_add(v, 0x96), pathname = v;
    RESET_WARNINGS_TO_DEFAULT();
    farptr environment = 0;
    /* DOS function 30h (get version): AL is the major version.  From DOS 3 on, the
       environment block is followed by a word count and the program's full path; walk past
       the double 0 that ends the strings and skip 3 bytes (the 0 and the count) */
    i16 remaining = DOS_CALL_AH(48, 0, 0) & 255;
    if (remaining >= 3) {
        environment = MK_FP(ENVIRONMENT_SEG, 0);
        while (SB(environment)) {
            do
                environment = fp_add(environment, 1);
            while (SB(environment));
            environment = fp_add(environment, 1);
        }
        environment = fp_add(environment, 3);
        FNSPLIT(environment, drive, directory, 0, 0);
    }
    /* TCDEF.SYM in the current directory, else in BCC.EXE's directory */
    PCH_FILE_NAME = C53_DEFAULT_FILE_P;
    if (!FILE_TEST(PCH_FILE_NAME) && environment) {
        FNMERGE(TOKEN_TEXT_BUFFER_P, drive, directory, C53_DEFAULT_FILE_P, 0);
        farptr copy = MALLOC(STRING_LENGTH(TOKEN_TEXT_BUFFER_P) + 1);
        PCH_FILE_NAME = copy;
        STRING_COPY(PCH_FILE_NAME, TOKEN_TEXT_BUFFER_P);
    }
    i16 explicit_config = 0;
    remaining = argc - 1;
    /* the pre-scan; MALLOC(STRING_LENGTH(*cursor)) is exactly enough for the name after
       '+' plus its 0 */
    for (farptr cursor = fp_add(argv, 4); remaining > 0 && (ARG_CHAR(cursor) == '-' || ARG_CHAR(cursor) == '+');
         cursor = fp_add(cursor, 4), --remaining) {
        if (ARG_CHAR(cursor) == '+') {
            farptr copy = MALLOC(STRING_LENGTH(D(cursor)));
            C53_OPTION_PATH = copy;
            STRING_COPY(C53_OPTION_PATH, fp_add(D(cursor), 1));
            explicit_config = 1;
        } else if (!APPLY_OPTION(fp_add(D(cursor), 1), 65535U))
            FILE_FATAL(C53_COMMAND_LINE_P, D(cursor));
    }
    i16 handle = RTL_OPEN(C53_OPTION_PATH, 0);
    if (handle < 0) {
        if (explicit_config) {
            OPTION_ERROR_LIMIT = 0;
            REPORT_ERROR(MSG_COULD_NOT_FIND_FILE, C53_OPTION_PATH);
            SHUTDOWN_HEAP_BANKS();
            EXIT(1);
        } else if (environment) {
            FNMERGE(pathname, drive, directory, C53_OPTION_PATH, 0);
            handle = RTL_OPEN(pathname, 0);
        }
    }
    /* the whole configuration file read into a new pool segment, a ^Z (26) after it as end
       mark, and its words applied one by one */
    if (handle >= 0) {
        u16 size = (u16)RTL_LSEEK(handle, 0, 2);
        RTL_LSEEK(handle, 0, 0);
        POOL_INIT(BCC_LINE_SEGMENT_P, size + 1);
        BCC_LINE_OFFSET = 0;
        RTL_READ(handle, MK_FP(BCC_LINE_SEGMENT, 0), size);
        RTL_CLOSE(handle);
        B(MK_FP(BCC_LINE_SEGMENT, BCC_LINE_OFFSET + size)) = 26;
        while (BCC_LINE_READ(token) != -1)
            if (SB(token) != '-' || !APPLY_OPTION(fp_add(token, 1), 1))
                FILE_FATAL(C53_CONFIG_FILE_P, token);
        FREE_HANDLE_BLOCK(BCC_LINE_SEGMENT_P);
    }
    --argc;
    argv = fp_add(argv, 4);
    for (; argc > 0 && (ARG_CHAR(argv) == '-' || ARG_CHAR(argv) == '+'); argv = fp_add(argv, 4), --argc)
        if (ARG_CHAR(argv) == '-' && !APPLY_OPTION(fp_add(D(argv), 1), 0))
            FILE_FATAL(C53_COMMAND_LINE_P, D(argv));
    for (; argc > 0; argv = fp_add(argv, 4), --argc) {
        if (ARG_CHAR(argv) != '-')
            continue;
        farptr argument = fp_add(D(argv), 1);
        if (!COMPARE_NAME(argument, OPT_TEXT_YO_P) || !COMPARE_NAME(argument, C53_YO_OFF_P))
            OPTION_OVERLAY_CODE = 1;
        else if (COMPARE_NAME(argument, OPT_TEXT_V_P) && COMPARE_NAME(argument, C53_V_OFF_P) &&
                 COMPARE_NAME(argument, OPT_TEXT_VI_P) && COMPARE_NAME(argument, C53_VI_OFF_P))
            FILE_FATAL(C53_COMMAND_LINE_P, D(argv));
    }
    /* COMPILER_MODE here holds -S (assembly output only), which also means no link.  After
       this COMPILER_MODE is nonzero whenever assembly text is written: for -S and for -B
       (OPTION_COMPILE_VIA_ASM, compile through TASM) */
    C51_SKIP_LINK |= COMPILER_MODE;
    COMPILER_MODE |= OPTION_COMPILE_VIA_ASM;
    SAVE_WARNINGS_AS_DEFAULT();
    scratch_release(mark);
    return D(argv);
}

/* the next character of the configuration text */
static i16 next_char(void)
{
    return SB(MK_FP(BCC_LINE_SEGMENT, BCC_LINE_OFFSET++));
}

/* copies the next blank-separated word of the configuration text (BCC_LINE_SEGMENT at
   BCC_LINE_OFFSET) into out and returns 1; returns -1 at the end of the text.  A word
   starting with ';' begins a comment to the end of the line.  When the ^Z end mark is read
   the offset is stepped back, so later calls see it again */
i16 BCC_LINE_READ(farptr out)
{
    i16 ch;
    for (;;) {
        do
            ch = next_char();
        while ((CTYPE(ch) & 1) || ch == 13);
        if (ch == 0 || ch == 26)
            return -1;
        if (ch != ';')
            break;
        while (ch && ch != 10 && ch != 26)
            ch = next_char();
        if (ch == 26)
            --BCC_LINE_OFFSET;
    }
    do {
        B(out) = (u8)ch;
        out = fp_add(out, 1);
        ch = next_char();
    } while (!(CTYPE(ch) & 1) && ch && ch != 13 && ch != 26);
    if (ch == 26)
        --BCC_LINE_OFFSET;
    B(out) = 0;
    return 1;
}

/* 1 when path names an existing file; the find block sits at bp-2Ch in BCC's frame */
i16 FILE_TEST(farptr path)
{
    u16 mark = scratch_mark();
    farptr info = scratch_alloc(0x2C);
    i16 found = FINDFIRST(path, info, 0) == 0;
    scratch_release(mark);
    return found;
}

/* reports "Incorrect <where> option: <option>" (first = "command line" or "configuration
   file", second = the option) and exits with status 1 */
void FILE_FATAL(farptr first, farptr second)
{
    OPTION_ERROR_LIMIT = 0;
    REPORT_ERROR(MSG_INCORRECT_OPTION, first, second);
    SHUTDOWN_HEAP_BANKS();
    EXIT(1);
}
