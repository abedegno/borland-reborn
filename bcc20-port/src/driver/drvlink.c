/* drvlink.c: from bcc20/src/driver/DRVLINK.C: the resident-side driver that turns BCC's
   command line into work, used by RMAIN13C after all options are read.
   - EXPAND_RESPONSE_FILES (start-up) replaces each @file argument by the words in that file
     (blank-separated; a ';' starts a comment to the end of the line).  The file is read
     whole into one MALLOC block, words are cut out in place (BCC_READ_FILE counts them)
     and a new argv vector is built.
   - PROCESS_FILE_ARGUMENT is called for each file argument.  It adds the default source
     extension when the name has none, expands wildcards (EXPAND_WILDCARDS) and calls LG0A1
     for every matching file, which prints "name:" and compiles the file (.c/.cpp) or
     assembles it (.asm, PATH_PROCESS); .obj files are only noted.  The first file also
     gives the name of the .exe (LINK_OUTPUT_NAME) unless one is already set.
   - PATH_PROCESS builds a TASM command line from the memory model, calling convention,
     float and debug options and every -T argument (ARGUMENT_LIST), and runs TASM.
   - RUN_LINKER writes the TLINK response file TURBOC.$LN through the buffered output file:
     start-up object, object files with /o and /v switches where -Yo or -v change between
     files, the .exe name, the linker switches collected from -l options, then the
     libraries, and runs "tlink @turboc.$ln".
   Errors here set COMPILE_FAILED, which makes RUN_LINKER skip the link and BCC exit with
   status 1.  The wildcard walk takes a near function pointer to its callback (LG0A1,
   FILE_APPEND_CALLBACK, C51_EMIT_PATH_CALLBACK: their offsets in this module). */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define OPTION_OVERLAY_CODE B(OPTION_OVERLAY_CODE_P)
#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)
#define OPTION_CALLING_CONVENTION B(OPTION_CALLING_CONVENTION_P)
#define OPTION_SOURCE_DEBUG B(OPTION_SOURCE_DEBUG_P)
#define OPTION_FLAGS B(OPTION_FLAGS_P)
#define OPTION_MEMORY_MODEL SB(OPTION_MEMORY_MODEL_P)
#define ERROR_COUNT W(ERROR_COUNT_P)
/* far pointers (DRVLINK.H), where globals.h reads a word */
#undef OPTION_OUTPUT_DIR
#undef OPTION_OBJECT_NAME
#undef LINK_OUTPUT_NAME
#undef TASM_PROGRAM_NAME
#define OPTION_OUTPUT_DIR D(OPTION_OUTPUT_DIR_P)
#define OPTION_OBJECT_NAME D(OPTION_OBJECT_NAME_P)
#define LINK_OUTPUT_NAME D(LINK_OUTPUT_NAME_P)
#define TASM_PROGRAM_NAME D(TASM_PROGRAM_NAME_P)
#define ARGUMENT_LIST D(ARGUMENT_LIST_P)
#define SEARCH_LIST D(SEARCH_LIST_P)

/* the near offsets of this module's callbacks */
#define LG0A1_CODE 0x0000
#define FILE_APPEND_CALLBACK_CODE 0x0524
#define C51_EMIT_PATH_CALLBACK_CODE 0x05F0

/* a library table entry (C51Libraries: near start-up, run-time and math names) */
#define LIBRARY(table, model) fp_add((table), (model) * 6)
#define LIB_STARTUP(l) DSPTR(W(l))
#define LIB_RUNTIME(l) DSPTR(W(fp_add((l), 2)))
#define LIB_MATH(l) DSPTR(W(fp_add((l), 4)))

/* the n-th character of the argument vector entry entry */
#define ARG(entry, n) SB(fp_add(D(entry), (n)))

/* called once per file that matches a file argument.  .obj: only strips the extension and,
   if no .exe name is known yet, uses this name (directory included) as LINK_OUTPUT_NAME.
   Other files: prints "path:", assembles a .asm file with TASM or compiles anything else,
   then takes the bare file name as the .exe name if none is set.  A .cpp file is compiled
   with C++ forced (OPTION_FLAGS bit 0); afterwards OPTION_FLAGS gets back its old value
   plus bit 1, probably remembering that a C++ file was compiled.  Always returns 1, so the
   wildcard walk goes on.  The name parts sit in BCC's frame (12h bytes): extension at
   bp-6, base at bp-10h */
i16 LG0A1(farptr path)
{
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x12);
    farptr extension = fp_add(v, 0x0C), base = fp_add(v, 2);
    FNSPLIT(path, 0, 0, base, extension);
    if (!STRING_COMPARE(extension, STR_OBJ_2_P)) {
        STRIP_EXTENSION(path);
        if (!LINK_OUTPUT_NAME) {
            farptr copy = MALLOC(STRING_LENGTH(path) + 1);
            LINK_OUTPUT_NAME = copy;
            STRING_COPY(LINK_OUTPUT_NAME, path);
        }
    } else {
        WRITE_STDOUT_STRING(path);
        WRITE_STDOUT_STRING(STR_COLON_CRLF_P);
        if (!STRING_COMPARE(extension, STR_ASM_EXT_P))
            PATH_PROCESS(path, 0, 1);
        else {
            u8 saved = OPTION_FLAGS;
            if (!STRING_COMPARE(extension, STR_CPP_EXT_P)) {
                OPTION_FLAGS |= 1;
                saved |= 2;
            }
            COMPILE_FILE_REPORT_ERRORS(path);
            OPTION_FLAGS = saved;
        }
        STRIP_EXTENSION(path);
        if (!LINK_OUTPUT_NAME) {
            farptr copy = MALLOC(STRING_LENGTH(base) + 1);
            LINK_OUTPUT_NAME = copy;
            STRING_COPY(LINK_OUTPUT_NAME, base);
        }
    }
    scratch_release(mark);
    return 1;
}

/* not a plain concatenation: returns first unchanged when the file name already has an
   extension (FNSPLIT flag 2), else a new MALLOC block holding first followed by second */
farptr ADD_DEFAULT_EXTENSION(farptr first, farptr second)
{
    if (!(FNSPLIT(first, 0, 0, 0, 0) & 2)) {
        farptr buffer = MALLOC(STRING_LENGTH(first) + STRING_LENGTH(second) + 1);
        STRING_COPY(buffer, first);
        STRING_APPEND(buffer, second);
        first = buffer;
    }
    return first;
}

/* replaces the extension of first by second: strips it (in place), then adds second */
farptr BCC_STRING_CONCAT_NEAR(farptr first, farptr second)
{
    STRIP_EXTENSION(first);
    return ADD_DEFAULT_EXTENSION(first, second);
}

/* handles one file argument from the command line.  .lib files are left for RUN_LINKER.
   If no file matches, reports "Could not find file" with the -g/-j limits set to 0 for the
   moment, so the message always appears, and sets COMPILE_FAILED */
void PROCESS_FILE_ARGUMENT(farptr path)
{
    if (HAS_LIB_EXTENSION(path))
        return;
    path = ADD_DEFAULT_EXTENSION(path, DEFAULT_SOURCE_EXT_P);
    if (EXPAND_WILDCARDS(path, LG0A1_CODE) < 0) {
        u8 first = OPTION_ERROR_LIMIT, second = OPTION_WARNING_LIMIT;
        OPTION_ERROR_LIMIT = 0;
        OPTION_WARNING_LIMIT = 0;
        REPORT_ERROR(MSG_COULD_NOT_FIND_FILE, path);
        COMPILE_FAILED = 1;
        OPTION_ERROR_LIMIT = first;
        OPTION_WARNING_LIMIT = second;
    }
}

/* assembles path with TASM.  The command tail is built in arguments+1 (RUN_PROGRAM puts
   the length in arguments[0]):
     path [/o] /D__model__ /D__conv__ /e|/r [/zi] /ml [ /arg ...] ,object  ;
   where each /arg is one -T option's text.  /o is added for overlay or Windows code, /e
   (emulator) or /r (real 8087) follows the float option, /zi only for a user .asm file
   with -v.  mode 0 = the .asm BCC wrote under -B: the object goes to -o's name if given.
   mode 1 = a user .asm file: the object goes to the output directory under the file's own
   name.  remove_original nonzero deletes path after a good assembly.  TASM's exit code 11
   stops BCC at once; any other nonzero code marks the compile failed.  The original builds
   the command through near pointers into its stack, which is in DGROUP, so the port keeps
   this frame (E6h bytes: original at bp-E6h, arguments at bp-94h, name at bp-10h) in the
   near scratch area */
void PATH_PROCESS(farptr path, u16 remove_original, u16 mode)
{
    u16 mark = near_scratch_mark();
    farptr v = near_scratch_alloc(0xE6);
    farptr original = v, arguments = fp_add(v, 0x52), name = fp_add(v, 0xD6);
    farptr command = fp_add(arguments, 1);
    /* no source position: messages printed from here carry no file and line */
    LOGICAL_LINE = 0;
    CURRENT_FILE_NAME = 0;
    SLASH_FIX(path);
    RTL_STRNCPY(original, path, 80);
    FNSPLIT(path, 0, 0, name, 0);
    STRIP_EXTENSION(path);
    STRING_COPY(command, path);
    if (OPTION_OVERLAY_CODE || OPTION_WINDOWS_MODE)
        STRING_APPEND(command, STR_O_P);
    farptr model = 0;
    switch (OPTION_MEMORY_MODEL) {
    case 0: model = STR_D_TINY_P; break;
    case 1: model = STR_D_SMALL_P; break;
    case 2: model = STR_D_MEDIUM_P; break;
    case 3: model = STR_D_COMPACT_P; break;
    case 4: model = STR_D_LARGE_P; break;
    case 5: model = STR_D_HUGE_P; break;
    }
    STRING_APPEND(command, model);
    if (OPTION_CALLING_CONVENTION == 1)
        STRING_APPEND(command, STR_D_PASCAL_P);
    else if (OPTION_CALLING_CONVENTION == 2)
        STRING_APPEND(command, STR_D_FASTCALL_P);
    else
        STRING_APPEND(command, STR_D_CDECL_P);
    STRING_APPEND(command, OPTION_FLOAT_MODE == 1 ? STR_E_P : STR_R_P);
    if (OPTION_SOURCE_DEBUG && mode)
        STRING_APPEND(command, STR_ZI_P);
    STRING_APPEND(command, STR_ML_P);
    for (farptr argument = ARGUMENT_LIST; argument; argument = D(argument)) {
        STRING_APPEND(command, STR_SPACE_SLASH_P);
        STRING_APPEND(command, fp_add(argument, 4));
    }
    STRING_APPEND(command, STR_SPACE_COMMA_P);
    if (!mode && OPTION_OBJECT_NAME) {
        SLASH_FIX(OPTION_OBJECT_NAME);
        STRING_APPEND(command, OPTION_OBJECT_NAME);
    } else {
        farptr end = fp_add(command, STRING_LENGTH(command));
        SLASH_FIX(OPTION_OUTPUT_DIR);
        STRING_APPEND(command, OPTION_OUTPUT_DIR);
        ADD_TRAILING_BACKSLASH(end);
        STRING_APPEND(command, name);
    }
    STRING_APPEND(command, STR_SPACE_SPACE_SEMI_P);
    i16 status = RUN_PROGRAM(TASM_PROGRAM_NAME, arguments);
    if (status == 11) {
        SHUTDOWN_HEAP_BANKS();
        EXIT(1);
    }
    if (status)
        COMPILE_FAILED = 1;
    else if (remove_original)
        DELETE_FILE(original);
    near_scratch_release(mark);
}

/* compiles one C or C++ file and prints "*** n errors in Compile ***" when it failed */
void COMPILE_FILE_REPORT_ERRORS(farptr path)
{
    i16 result = COMPILE_ONE_FILE(path);
    if (result || ERROR_COUNT) {
        RTL_DPRINTF(STR_ERRORS_IN_COMPILE_P, ERROR_COUNT);
        COMPILE_FAILED = 1;
    }
}

/* writes text to the open output file (here the TLINK response file) */
void PUT_STRING(farptr text)
{
    for (; SB(text) != 0; text = fp_add(text, 1))
        OUTPUT_CHAR(SB(text));
}

/* turns every '/' of path into '\' */
void SLASH_FIX(farptr path)
{
    for (; SB(path) != 0; path = fp_add(path, 1))
        if (SB(path) == '/')
            B(path) = '\\';
}

/* writes a file name with '/' turned into '\' */
void PUT_PATH(farptr path)
{
    SLASH_FIX(path);
    PUT_STRING(path);
}

/* for each matching file of an object argument: writes "+", a line break and the object
   name.  A .obj argument is written as given (without extension); a source file is
   written as output directory + base name, the object BCC made from it.  The name parts
   sit in BCC's frame (10h bytes): extension at bp-6, name at bp-10h */
i16 FILE_APPEND_CALLBACK(farptr path)
{
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0x10);
    farptr extension = fp_add(v, 0x0A), name = v;
    FNSPLIT(path, 0, 0, name, extension);
    if (STRING_COMPARE(extension, STR_OBJ_2_P) == 0) {
        STRIP_EXTENSION(path);
        PUT_STRING(STR_PLUS_CRLF_P);
        PUT_PATH(path);
    } else {
        PUT_STRING(STR_PLUS_CRLF_P);
        STRING_COPY(TOKEN_TEXT_BUFFER_P, OPTION_OUTPUT_DIR);
        ADD_TRAILING_BACKSLASH(TOKEN_TEXT_BUFFER_P);
        PUT_PATH(TOKEN_TEXT_BUFFER_P);
        PUT_PATH(name);
    }
    scratch_release(mark);
    return 1;
}

/* adds one file argument to the object list of the response file.  A .lib argument only
   sets LINK_LIBRARY_ARG_SEEN; libraries are written later */
void BCC_STRING_FILE_APPEND(farptr path)
{
    if (HAS_LIB_EXTENSION(path))
        LINK_LIBRARY_ARG_SEEN = 1;
    else {
        path = ADD_DEFAULT_EXTENSION(path, DEFAULT_SOURCE_EXT_P);
        EXPAND_WILDCARDS(path, FILE_APPEND_CALLBACK_CODE);
    }
}

/* for the user library list: writes the library name and "+", line break */
i16 C51_EMIT_PATH_CALLBACK(farptr path)
{
    PUT_PATH(path);
    PUT_STRING(STR_PLUS_CRLF_P);
    return 1;
}

/* /o or /o- and /v+ or /v- where the -Yo or -v state changed (needs a "+" line break
   first when written among the objects) */
static int differs(i16 a, i16 b) { return (a != 0 && b == 0) || (a == 0 && b != 0); }

/* the file found, from TOKEN_TEXT_BUFFER, and "+" line break */
static void put_found(farptr name)
{
    FIND_FILE(name, 0);
    PUT_PATH(TOKEN_TEXT_BUFFER_P);
    PUT_STRING(STR_PLUS_CRLF_P);
}

/* builds TURBOC.$LN and runs TLINK.  count/arguments are the file arguments and the
   options among them.  Skipped when a fatal error longjmps here (ERROR_JUMP_BUFFER), when
   -c or -S asked for no link, or when an earlier step failed.  Lines of the response file,
   in order: objects (start-up object first), .exe name, switches, libraries, and for
   Windows the .def file if one exists.  TLINK reads a line break in a response file as the
   next field and a trailing "+" as "continued" */
void RUN_LINKER(i16 count, farptr arguments)
{
    if (C45_SETJUMP(ERROR_JUMP_BUFFER_P) != 0 || C51_SKIP_LINK != 0 || (i16)COMPILE_FAILED > 0)
        return;
    i16 result = CREATE_OUTPUT_FILE(STR_TURBOC_LN_P);
    if (result < 0)
        FATAL_EXIT(MSG_UNABLE_CREATE_TURBOC);
    /* the start-up object and library names for the memory model; for Windows the third
       letter of the start-up name becomes 'd' (DLL) or 'w' (application) */
    farptr libraries;
    u8 dll_mode = 0;
    i8 windows_model = 0;
    if (OPTION_WINDOWS_MODE != 0) {
        dll_mode = OPTION_WINDOWS_MODE == 2 || OPTION_WINDOWS_MODE == 5;
        libraries = LIBRARY(C51_WINDOWS_LIBRARIES_P, OPTION_MEMORY_MODEL);
        B(fp_add(LIB_STARTUP(libraries), 2)) = dll_mode ? 'd' : 'w';
    } else
        libraries = LIBRARY(C51_DOS_LIBRARIES_P, OPTION_MEMORY_MODEL);
    /* with the SS==DS option the start-up object comes from STARTUP_SS_DS_NAMES (the
       c0f?.obj names) */
    if (OPTION_SS_EQUALS_DS != 0 && !(i8)OPTION_WINDOWS_MODE)
        FIND_FILE(DSPTR(STARTUP_SS_DS_NAMES_AT(OPTION_MEMORY_MODEL)), 0);
    else
        FIND_FILE(LIB_STARTUP(libraries), 0);
    PUT_PATH(TOKEN_TEXT_BUFFER_P);
    if (OPTION_WINDOWS_MODE != 0) {
        windows_model = OPTION_MEMORY_MODEL;
        if (dll_mode != 0) {
            windows_model = C51_DLL_MODEL_AT(windows_model);
            libraries = LIBRARY(C51_WINDOWS_LIBRARIES_P, windows_model);
        }
    }
    i16 saved_count = count;
    farptr saved_arguments = arguments;
    i16 changed = 0;
    i16 debug_emitted = (i8)OPTION_SOURCE_DEBUG;
    i16 debug_requested = 0;
    /* first pass: whether any -v / -v- among the files differs from the leading -v state;
       if so, debug info is switched per file with /v+ and /v- instead of one global /v */
    for (; count > 0; arguments = fp_add(arguments, 4), --count)
        if (ARG(arguments, 0) == '-' && ARG(arguments, 1) == 'v' && ARG(arguments, 2) != 'i') {
            debug_requested = !ARG(arguments, 2);
            changed |= differs(debug_requested, debug_emitted);
        }
    count = saved_count;
    arguments = saved_arguments;
    /* second pass: the object files, with "+", line break and /o, /o-, /v+ or /v- before
       a file whose -Yo or -v state differs from what was last written.  Any option other
       than -Y... reaches the debug branch, not only -v */
    debug_requested = (i8)OPTION_SOURCE_DEBUG;
    debug_emitted = OPTION_SOURCE_DEBUG != 0 && changed == 0;
    i16 overlay_emitted = 0;
    i16 overlay_requested = (i8)OPTION_LINK_OVERLAY;
    for (; count > 0; arguments = fp_add(arguments, 4), --count) {
        if (ARG(arguments, 0) == '-') {
            if (ARG(arguments, 1) == 'Y')
                overlay_requested = !ARG(arguments, 3);
            else if (ARG(arguments, 2) != 'i')
                debug_requested = !ARG(arguments, 2);
        } else if (!HAS_LIB_EXTENSION(D(arguments))) {
            if (differs(overlay_requested, overlay_emitted) || differs(debug_requested, debug_emitted)) {
                PUT_STRING(STR_PLUS_CRLF_P);
                if (differs(overlay_emitted, overlay_requested)) {
                    overlay_emitted = overlay_requested;
                    PUT_STRING(overlay_emitted != 0 ? STR_O_P : STR_O_2_P);
                }
                if (differs(debug_emitted, debug_requested)) {
                    debug_emitted = debug_requested;
                    PUT_STRING(debug_emitted != 0 ? STR_V_P : STR_V_2_P);
                }
            }
            BCC_STRING_FILE_APPEND(D(arguments));
        } else
            LINK_LIBRARY_ARG_SEEN = 1;
    }
    /* STR_COLON_CRLF is ":\r\n"; +1 writes just the line break that ends a field */
    PUT_STRING(fp_add(STR_COLON_CRLF_P, 1));
    STRING_COPY(TOKEN_TEXT_BUFFER_P, OPTION_OUTPUT_DIR);
    ADD_TRAILING_BACKSLASH(TOKEN_TEXT_BUFFER_P);
    PUT_PATH(TOKEN_TEXT_BUFFER_P);
    PUT_PATH(LINK_OUTPUT_NAME);
    if (OPTION_WINDOWS_MODE != 0 && dll_mode != 0 && !(FNSPLIT(LINK_OUTPUT_NAME, 0, 0, 0, 0) & 2))
        PUT_STRING(STR_DLL_P);
    PUT_STRING(fp_add(STR_COLON_CRLF_P, 1));
    /* linker switches: /a../z, /A../Z, /0../9 (all filled by the -l option), then /y? and
       /T? switches; a DLL gets /Twd */
    if (changed != 0)
        B(fp_add(LINKER_SWITCH_FLAGS_P, 'v' - 'a')) = 0;
    for (result = 0; result < 26; ++result)
        if (B(fp_add(LINKER_SWITCH_FLAGS_P, result)) != 0) {
            OUTPUT_CHAR('/');
            OUTPUT_CHAR((i8)(result + 'a'));
        }
    for (result = 0; result < 26; ++result)
        if (C51_UPPER_LINK_OPTIONS_AT(result) != 0) {
            OUTPUT_CHAR('/');
            OUTPUT_CHAR((i8)(result + 'A'));
        }
    for (result = 0; result < 10; ++result)
        if (C51_DIGIT_LINK_OPTIONS_AT(result) != 0) {
            OUTPUT_CHAR('/');
            OUTPUT_CHAR((i8)(result + '0'));
        }
    for (result = 0; result < 26; ++result)
        if (C51_Y_LINK_OPTIONS_AT(result) != 0) {
            PUT_STRING(STR_Y_P);
            OUTPUT_CHAR((i8)(result + 'a'));
        }
    if (OPTION_WINDOWS_MODE != 0 && dll_mode != 0) {
        C51_T_LINK_OPTIONS_AT('w' - 'a') = 0;
        PUT_STRING(STR_TWD_P);
    }
    for (result = 0; result < 26; ++result)
        if (C51_T_LINK_OPTIONS_AT(result) != 0) {
            PUT_STRING(STR_T_P);
            OUTPUT_CHAR((i8)(result + 'a'));
        }
    PUT_STRING(fp_add(STR_COLON_CRLF_P, 1));
    /* the user libraries (.lib arguments), each looked up in the current directory first
       and then in the -L directories, again with /o and /v switches where -Yo/-v change */
    if (LINK_LIBRARY_ARG_SEEN != 0) {
        overlay_requested = overlay_emitted = 0;
        debug_requested = (i8)OPTION_SOURCE_DEBUG;
        for (; saved_count > 0; saved_arguments = fp_add(saved_arguments, 4), --saved_count) {
            if (ARG(saved_arguments, 0) == '-') {
                if (ARG(saved_arguments, 1) == 'Y')
                    overlay_requested = !ARG(saved_arguments, 3);
                else if (ARG(saved_arguments, 2) != 'i')
                    debug_requested = !ARG(saved_arguments, 2);
            } else if (HAS_LIB_EXTENSION(D(saved_arguments))) {
                if (differs(overlay_requested, overlay_emitted) || differs(debug_requested, debug_emitted)) {
                    if (differs(overlay_requested, overlay_emitted)) {
                        overlay_emitted = overlay_requested;
                        PUT_STRING(overlay_emitted != 0 ? STR_O_P : STR_O_2_P);
                    }
                    if (differs(debug_requested, debug_emitted)) {
                        debug_emitted = debug_requested;
                        PUT_STRING(debug_emitted != 0 ? STR_V_P : STR_V_2_P);
                    }
                    PUT_STRING(STR_PLUS_CRLF_P);
                }
                FIND_FILE(D(saved_arguments), 1);
                EXPAND_WILDCARDS(TOKEN_TEXT_BUFFER_P, C51_EMIT_PATH_CALLBACK_CODE);
            }
        }
        if (overlay_emitted != 0)
            PUT_STRING(STR_O_3_P);
    }
    /* then the standard libraries: OVERLAY.LIB for -Y; IMPORT.LIB and the Windows run-time
       for Windows; EMU.LIB or FP87.LIB and the model's math library when floating point is
       on; last the model's C run-time library */
    if (OPTION_OVERLAY_CODE != 0)
        put_found(STR_OVERLAY_LIB_P);
    if (OPTION_WINDOWS_MODE != 0) {
        put_found(STR_IMPORT_LIB_P);
        put_found(DSPTR(C51_WINDOWS_RUNTIME_AT(windows_model)));
        if (OPTION_FLOAT_MODE != 0)
            put_found(LIB_MATH(libraries));
    } else if (OPTION_FLOAT_MODE != 0) {
        put_found(OPTION_FLOAT_MODE == 1 ? STR_EMU_LIB_P : STR_FP87_LIB_P);
        put_found(LIB_MATH(libraries));
    }
    FIND_FILE(LIB_RUNTIME(libraries), 0);
    PUT_PATH(TOKEN_TEXT_BUFFER_P);
    /* Windows: the module definition file <exe>.def if it exists (FILE_TIME is 0 when it
       does not) */
    if (OPTION_WINDOWS_MODE != 0) {
        STRING_COPY(TOKEN_TEXT_BUFFER_P, BCC_STRING_CONCAT_NEAR(LINK_OUTPUT_NAME, STR_DEF_P));
        SLASH_FIX(TOKEN_TEXT_BUFFER_P);
        if (FILE_TIME(TOKEN_TEXT_BUFFER_P) != 0) {
            PUT_STRING(fp_add(STR_COLON_CRLF_P, 1));
            PUT_STRING(TOKEN_TEXT_BUFFER_P);
        }
    }
    CLOSE_OUTPUT_FILE();
    result = RUN_PROGRAM(STR_TLINK_EXE_P, STR_TURBOC_LN_2_P);
    DELETE_FILE(STR_TURBOC_LN_P);
    if (result >= 1)
        COMPILE_FAILED = 1;
}

/* 1 when path has the extension ".lib" (SPECIAL_NAME), else 0; the extension sits at bp-6
   in BCC's frame (8 bytes) */
i16 HAS_LIB_EXTENSION(farptr path)
{
    u16 mark = scratch_mark();
    farptr component = fp_add(scratch_alloc(8), 2);
    i16 result = FNSPLIT(path, 0, 0, 0, component);
    i16 found = (result & 2) && STRING_COMPARE(component, SPECIAL_NAME_P) == 0;
    scratch_release(mark);
    return found;
}

/* expands a file name that may hold wildcards: for every match builds drive + directory +
   found name in lower case and calls the callback (a near offset in this module) with it.
   Returns -1 when nothing matches, 0 when the callback asked to stop, 1 otherwise.  The
   locals sit in BCC's frame (CAh bytes): directory at bp-CAh, combined at bp-86h, the find
   block at bp-34h (its name at bp-16h), drive at bp-4 */
i16 EXPAND_WILDCARDS(farptr path, u16 callback)
{
    u16 mark = scratch_mark();
    farptr v = scratch_alloc(0xCA);
    farptr directory = v, combined = fp_add(v, 0x44), search = fp_add(v, 0x96), drive = fp_add(v, 0xC6);
    i16 result = -1;
    if (FINDFIRST(path, search, 0) < 0)
        goto done;
    FNSPLIT(path, drive, directory, 0, 0);
    do {
        FNMERGE(combined, drive, directory, fp_add(search, 0x1E), 0);
        for (farptr cursor = combined; SB(cursor); cursor = fp_add(cursor, 1))
            B(cursor) = (u8)TOLOWER(SB(cursor));
        if (!(i16)CALL_NEAR("DRVLINK", callback, A32(combined))) {
            result = 0;
            goto done;
        }
    } while (FINDNEXT(search) >= 0);
    result = 1;
done:
    scratch_release(mark);
    return result;
}

/* removes the extension of path in place by writing 0 over the first '.', if the name has
   an extension (a '.' in a directory name would cut there) */
void STRIP_EXTENSION(farptr path)
{
    if (FNSPLIT(path, 0, 0, 0, 0) & 2)
        B(STRING_FIND_CHAR(path, '.')) = 0;
}

/* reports message number error (limits set to 0 so it always shows) and exits with 1 */
void FATAL_EXIT(i16 error)
{
    OPTION_ERROR_LIMIT = 0;
    OPTION_WARNING_LIMIT = 0;
    REPORT_ERROR(error);
    EXIT(1);
}

/* counts calls; every 200th call makes a DOS "check input status" call (int 21h, AH=0Bh),
   which lets DOS see Ctrl-C/Ctrl-Break during long work */
void NESTING_CHECK(void)
{
    BREAK_POLL_COUNTER++;
    if (BREAK_POLL_COUNTER > 200) {
        DOS_CALL_AH(11, 0, 0);
        BREAK_POLL_COUNTER = 0;
    }
}

/* locates a file for the link and leaves its name in TOKEN_TEXT_BUFFER.  A name with a
   drive or a leading slash is used as is.  Otherwise, if check_current is set and the file
   exists in the current directory, that is used; else each -L directory (SEARCH_LIST:
   entries of 2 reserved bytes, a far next, a far directory) is tried in turn.  If nothing
   is found, TOKEN_TEXT_BUFFER holds the bare name.  The find block sits at bp-30h */
void FIND_FILE(farptr path, i16 check_current)
{
    u16 mark = scratch_mark();
    farptr info = scratch_alloc(0x30);
    if (SB(fp_add(path, 1)) == ':' || SB(path) == '\\' || SB(path) == '/')
        STRING_COPY(TOKEN_TEXT_BUFFER_P, path);
    else if (check_current != 0 && FINDFIRST(path, info, 0) >= 0)
        STRING_COPY(TOKEN_TEXT_BUFFER_P, path);
    else {
        for (farptr entry = SEARCH_LIST; entry != 0; entry = D(fp_add(entry, 2))) {
            STRING_COPY(TOKEN_TEXT_BUFFER_P, D(fp_add(entry, 6)));
            STRING_APPEND(TOKEN_TEXT_BUFFER_P, path);
            if (FINDFIRST(TOKEN_TEXT_BUFFER_P, info, 0) >= 0)
                goto done;
        }
        STRING_COPY(TOKEN_TEXT_BUFFER_P, path);
    }
done:
    scratch_release(mark);
}

/* reads a whole response file into one MALLOC block ended by a ^Z (26) byte, stores it in
   a new LineBuffer node (far next, far text) at out and returns the number of words in it.
   Words are cut in place: the blank after each word is overwritten with 0.  Lines starting
   with ';' are comments */
u16 BCC_READ_FILE(u16 handle, farptr out)
{
    farptr node = MALLOC(8);
    D(out) = node;
    u16 count = (u16)RTL_LSEEK(handle, 0, 2);
    RTL_LSEEK(handle, 0, 0);
    farptr text = MALLOC(count + 1);
    RTL_READ(handle, text, count);
    B(fp_add(text, count)) = 26;
    D(fp_add(node, 4)) = text;
    count = 0;
    for (;;) {
        i16 ch;
        do {
            ch = SB(text);
            text = fp_add(text, 1);
        } while ((CTYPE(ch) & 1) || ch == 13 || ch == 0);
        if (ch == 26)
            break;
        if (ch == ';') {
            while (ch && ch != 10) {
                ch = SB(text);
                text = fp_add(text, 1);
            }
        } else {
            ++count;
            do {
                ch = SB(text);
                text = fp_add(text, 1);
            } while (!(CTYPE(ch) & 1) && ch != 13 && ch != 26);
            if (ch == 26)
                break;
            B(fp_add(text, -1)) = 0;
        }
    }
    return count;
}

/* replaces every "@file" argument by the words of that file and updates count and
   arguments (far pointers to the caller's argc and argv) to the new vector.  Does nothing
   when no argument starts with '@'.  A missing response file is fatal.  The first loop
   reads all files and counts the words; the second builds the new vector, taking pointers
   into the file texts.  The node BCC_READ_FILE fills sits at bp-1Eh in BCC's frame */
void EXPAND_RESPONSE_FILES(farptr count, farptr arguments)
{
    i16 original_count = SW(count);
    i16 index = 0;
    farptr original = D(arguments);
    while (index < original_count && ARG(original, 0) != '@') {
        ++index;
        original = fp_add(original, 4);
    }
    if (index == original_count)
        return;
    u16 mark = scratch_mark();
    farptr node_p = scratch_alloc(0x1E);
    farptr first = 0, last = 0;
    i16 total = original_count;
    for (; index < original_count; ++index, original = fp_add(original, 4)) {
        if (ARG(original, 0) != '@')
            continue;
        --total;
        i16 handle = RTL_OPEN(fp_add(D(original), 1), 0);
        if (handle < 0) {
            OPTION_ERROR_LIMIT = 0;
            OPTION_WARNING_LIMIT = 0;
            REPORT_ERROR(MSG_COULD_NOT_FIND_FILE, fp_add(D(original), 1));
            SHUTDOWN_HEAP_BANKS();
            EXIT(1);
        }
        total += BCC_READ_FILE(handle, node_p);
        RTL_CLOSE(handle);
        if (last != 0)
            D(last) = D(node_p);
        else
            first = D(node_p);
        last = D(node_p);
    }
    original = D(arguments);
    SW(count) = total;
    farptr output = MALLOC(total * 4);
    D(arguments) = output;
    for (index = 0; index < original_count; ++index, original = fp_add(original, 4)) {
        if (ARG(original, 0) != '@') {
            D(output) = D(original);
            output = fp_add(output, 4);
            continue;
        }
        farptr text = D(fp_add(first, 4));
        for (;;) {
            i16 value;
            do {
                value = SB(text);
                text = fp_add(text, 1);
            } while ((CTYPE(value) & 1) != 0 || value == 13 || value == 0);
            if (value == 26)
                break;
            if (value == ';') {
                while (value != 0 && value != 10) {
                    value = SB(text);
                    text = fp_add(text, 1);
                }
            } else {
                D(output) = fp_add(text, -1);
                output = fp_add(output, 4);
                do {
                    value = SB(text);
                    text = fp_add(text, 1);
                } while (value != 0 && value != 26);
                if (value == 26) {
                    B(fp_add(text, -1)) = 0;
                    break;
                }
            }
        }
        first = D(first);
    }
    scratch_release(mark);
}
