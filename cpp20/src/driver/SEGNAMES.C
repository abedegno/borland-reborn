/* target: SEGNAMES */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module SEGNAMES (image 0x9D03..0xA040, frame 09D0h): source taken from the
   BCC.EXE reconstruction (bcc20/src/driver/SEGNAMES.C), with CPP.EXE's
   edits marked "CPP.EXE edit". CPP.EXE has only two of its functions, in the same order;
   left out here: REGISTER_NAME, BCC_TOKEN_FLAG, DEFINE_FAR_SEGMENT, PTR_SCALE_TYPE,
   EMIT_STARTUP_EXIT_RECORD, ADD_STARTUP_ENTRY, ADD_EXIT_ENTRY (segment, register and
   startup/exit services of BCC's code generator, which CPP.EXE does not have). */
/* Role: per-file set-up: predefined macros, the memory model's pointer sizes, and the
   name and creation of the .i output file. Entry points: INIT_SEGMENT_NAMES,
   BCC_INTERN_STRING. */
/* Overview: INIT_SEGMENT_NAMES is called once per source file from BEGIN_BACKEND_PHASE
   (INITPOOL.C). It defines the predefined macros (__SMALL__ and the like, __MSDOS__ or
   __OS2__, _Windows, __TURBOC__ 0x0297, __BORLANDC__ 0x0200, __TCPLUSPLUS__ and
   __BCPLUSPLUS__ when OPTION_FLAGS is set, __OVERLAY__, __CDECL__/__PASCAL__/__FASTCALL__),
   sets MODEL_FAR_DATA and MODEL_FAR_CODE, builds the output file name ASM_OUTPUT_PATH (the
   -o name, or output directory + module name + ".i") and creates the output file. BCC's
   version of the function also filled the segment, group and class names; CPP.EXE keeps
   only the RTL_STRUPR calls on those (never set) names. BCC_INTERN_STRING copies a string
   into the string pool. */
#include "SEGNAMES.H"
#include "MSG.H"

/* CPP.EXE edit: names INIT_SEGMENT_NAMES uses in CPP.EXE only. STR_DOT_I is ".i" (DS:1B40),
   the preprocessor output's extension; CREATE_OUTPUT_FILE is RFILEIO.C's. */
extern char near STR_DOT_I[];
extern char TOKEN_TEXT_BUFFER[];
extern int far pascal CREATE_OUTPUT_FILE(char far *);



/* filename: the module's source name; its base name becomes C52_MODULE_NAME. Also resets
   the far-segment counter and the startup/exit segment names. See the overview. */
/* CPP.EXE edit: the preprocessor keeps only the predefined macros, the model's pointer
   sizes and the output name (CPP 09D0:0003..030B). Gone: C52_FAR_SERIAL and the
   startup/exit names, every segment/group/class name assignment, the model switch with
   its overlay error, the tiny/huge Windows error and the -z overrides; the nine
   RTL_STRUPR calls on the (never set) segment names stay. The output name gets the
   extension ".i" (string at DS:1B40) when it is built from the output directory and the
   module name, and the function then creates the output file itself
   (CREATE_OUTPUT_FILE, 11FF:0000), fatal MSG_UNABLE_CREATE_OUTPUT on failure, with the
   name copied to TOKEN_TEXT_BUFFER for the message. */
void far pascal INIT_SEGMENT_NAMES(char far *filename)
{
    char far *calling_macro;
    FNSPLIT(filename,0,0,C52_MODULE_NAME,0);
    MACRO_DEFINE(C52_MODEL_INFO[OPTION_MEMORY_MODEL].name,STR_1,-1,0);
    MODEL_FAR_DATA=C52_MODEL_INFO[OPTION_MEMORY_MODEL].far_data;
    MODEL_FAR_CODE=C52_MODEL_INFO[OPTION_MEMORY_MODEL].far_code;
    if(C52_OS2_OPTION!=0) {
        if(C52_MULTITHREAD_OPTION!=0) MACRO_DEFINE(STR___MULTI_THREAD__,STR_XFB,-1,0);
        else MACRO_DEFINE(STR___SINGLE_THREAD__,STR_XFB,-1,0);
        if(C52_DLL_OPTION!=0) MACRO_DEFINE(STR___DLL__,STR_XFB,-1,0);
        MACRO_DEFINE(STR___OS2__,STR_1,-1,0);
    } else MACRO_DEFINE(STR___MSDOS__,STR_1,-1,0);
    if(OPTION_WINDOWS_MODE!=0) {
        MACRO_DEFINE(STR__WINDOWS,STR_XFB,-1,0);
        if(OPTION_WINDOWS_MODE==2 || OPTION_WINDOWS_MODE==5) MACRO_DEFINE(STR___DLL__,STR_1,-1,0);
    }
    MACRO_DEFINE(STR___TURBOC__,STR_0X0297,-1,0);
    MACRO_DEFINE(STR___BORLANDC__,STR_0X0200,-1,0);
    if(OPTION_FLAGS!=0) {
        MACRO_DEFINE(STR___TCPLUSPLUS__,STR_0X0200,-1,0);
        MACRO_DEFINE(STR___BCPLUSPLUS__,STR_0X0200,-1,0);
    }
    if(OPTION_OVERLAY_CODE!=0) MACRO_DEFINE(STR___OVERLAY__,STR_1,-1,0);
    if(OPTION_CALLING_CONVENTION==1) calling_macro=STR___PASCAL__;
    else if(OPTION_CALLING_CONVENTION==2) calling_macro=STR___FASTCALL__;
    else calling_macro=STR___CDECL__;
    MACRO_DEFINE(calling_macro,STR_1,-1,0);
    /* Output name: -o's name (main has already given it ".i"), unless the -B test kept
       from BCC holds (BCC wrote a temporary .asm there); else output directory + module
       name + ".i". */
    if(OPTION_OBJECT_NAME!=0 && (COMPILER_MODE==0 || OPTION_COMPILE_VIA_ASM==0))
        ASM_OUTPUT_PATH=BCC_INTERN_STRING(OPTION_OBJECT_NAME);
    else {
        ASM_OUTPUT_PATH=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(OPTION_OUTPUT_DIR)+STRING_LENGTH(C52_MODULE_NAME)+6);
        STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH),OPTION_OUTPUT_DIR);
        ADD_TRAILING_BACKSLASH((char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH));
        STRING_APPEND((char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH),C52_MODULE_NAME);
        STRING_APPEND((char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH),STR_DOT_I);
    }
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,CODE_SEGMENT_NAME));
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,CODE_CLASS_NAME));
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,CODE_GROUP_NAME));
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,DATA_SEGMENT_NAME));
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,DATA_CLASS_NAME));
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,DATA_GROUP_NAME));
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,BSS_SEGMENT_NAME));
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,BSS_CLASS_NAME));
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,BSS_GROUP_NAME));
    if(CREATE_OUTPUT_FILE((char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH))<0) {
        STRING_COPY((char far *)TOKEN_TEXT_BUFFER,(char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH));
        REPORT_FATAL(MSG_UNABLE_CREATE_OUTPUT,(char far *)TOKEN_TEXT_BUFFER);
    }
}

/* Copies text into the string pool and returns its offset there. */
unsigned int far pascal BCC_INTERN_STRING(char far *text)
{
    register unsigned int offset;
    offset=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(text)+1);
    STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,offset),text);
    return offset;
}
