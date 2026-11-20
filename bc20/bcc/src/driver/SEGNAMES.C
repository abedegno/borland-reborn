/* target: ovr110_C52UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: options and initialisation: per-module setup of segment, group and class names from
   memory model and -z options, predefined macros, far data segments, #pragma startup/exit
   records. Entry points: REGISTER_NAME, BCC_TOKEN_FLAG, INIT_SEGMENT_NAMES,
   BCC_INTERN_STRING, DEFINE_FAR_SEGMENT, PTR_SCALE_TYPE, EMIT_STARTUP_EXIT_RECORD,
   ADD_STARTUP_ENTRY (+1 more). Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: names and set-up that depend on the memory model and the -z options, done
   once per module when the back end starts (INIT_SEGMENT_NAMES, called from
   BEGIN_BACKEND_PHASE in INITPOOL.C), plus a few small services used later.
   INIT_SEGMENT_NAMES fills the code, data and BSS segment, group and class names
   (CODE_SEGMENT_NAME ... BSS_CLASS_NAME, all offsets of strings in STRING_POOL_SEG):
   _TEXT/CODE, _DATA/DGROUP/DATA, _BSS/DGROUP/BSS by default; medium, large and huge
   models use "<module>_TEXT", and huge also "<module>_DATA" in class FAR_DATA with no
   group and no separate BSS. A -z option whose text is not "*" overrides a name. The
   function also defines the predefined macros (__SMALL__ and the like, __MSDOS__,
   __TURBOC__ 0x0297, __BORLANDC__ 0x0200, __TCPLUSPLUS__ for C++, __OVERLAY__,
   __CDECL__ ...) and the output file name ASM_OUTPUT_PATH.
   DEFINE_FAR_SEGMENT makes a new far data segment ("<module><n>_FAR", n counting from
   5) for far variables. EMIT_STARTUP_EXIT_RECORD writes one #pragma startup/exit entry
   into the _INIT_ or _EXIT_ segment. REGISTER_NAME and BCC_TOKEN_FLAG read PSEUDO_REGISTER_TABLE,
   the table of pseudo-register variables (_AX, _DX, ... with
   register number, type kind and a debugger register code). The *_HOOK pointers called
   here are back-end entry points reached through the hook table. */
#include "SEGNAMES.H"
#include "MSG.H"

/* Returns the lower-case assembler name ("ax", "dl" ...) of register number kind for
   an operand of type kind suffix (the pseudo-register entry whose flags field is kind and
   whose type is suffix), built in TOKEN_TEXT from the entry's name without its leading
   '_'. Returns 0 when there is no such entry. Used by ASMTEXT.C to print registers. */
char far * far pascal REGISTER_NAME(char kind,char suffix)
{
    struct C9Token far *entry=PSEUDO_REGISTER_TABLE;
    while(entry->name) {
        if(entry->flags==kind && entry->type==suffix) {
            TOKEN_TEXT[2]=0;
            TOKEN_TEXT[0]=TOLOWER(entry->name[1]);
            TOKEN_TEXT[1]=TOLOWER(entry->name[2]);
            return TOKEN_TEXT;
        }
        ++entry;
    }
    return 0;
}

/* Returns the debugger register code (reserved[0]) of the first pseudo-register entry
   for register number kind, or 0. Used for register variables in Turbo Debugger records
   (DEBUGREC.C, OBJSYMS.C). */
int far pascal BCC_TOKEN_FLAG(signed char kind)
{
    struct C9Token far *entry=PSEUDO_REGISTER_TABLE;
    while(entry->name) {
        if(entry->flags==kind) return (signed char)entry->reserved[0];
        ++entry;
    }
    return 0;
}

/* filename: the module's source name; its base name becomes C52_MODULE_NAME. Also resets
   the far-segment counter and the startup/exit segment names. See the overview. */
void far pascal INIT_SEGMENT_NAMES(char far *filename)
{
    char far *calling_macro;
    unsigned int saved_line;
    FNSPLIT(filename,0,0,C52_MODULE_NAME,0);
    C52_FAR_SERIAL=5;
    SYMBOL_A1=SYMBOL_B1=0;
    CODE_SEGMENT_NAME=BCC_INTERN_STRING(STR__TEXT);
    CODE_CLASS_NAME=BCC_INTERN_STRING(STR_CODE);
    CODE_GROUP_NAME=0;
    DATA_SEGMENT_NAME=BCC_INTERN_STRING(STR__);
    DATA_GROUP_NAME=BCC_INTERN_STRING(STR_DGROUP);
    DATA_CLASS_NAME=BCC_INTERN_STRING(STR_DATA);
    BSS_GROUP_NAME=BCC_INTERN_STRING(STR_DGROUP);
    BSS_SEGMENT_NAME=BCC_INTERN_STRING(STR_X5F_2);
    BSS_CLASS_NAME=BCC_INTERN_STRING(STR_BSS);
    BSS_SEGMENT_SEPARATE=1;
    /* OPTION_MEMORY_MODEL: 0 tiny, 1 small, 2 medium, 3 compact, 4 large, 5 huge. */
    switch(OPTION_MEMORY_MODEL) {
    case 5:
        DATA_SEGMENT_NAME=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(C52_MODULE_NAME)+6);
        STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,DATA_SEGMENT_NAME),C52_MODULE_NAME);
        STRING_APPEND((char far *)MK_FP(STRING_POOL_SEG.segment,DATA_SEGMENT_NAME),STR__);
        BSS_SEGMENT_SEPARATE=0;
        BSS_GROUP_NAME=0;
        BSS_CLASS_NAME=BCC_INTERN_STRING(STR_EMPTY_3);
        DATA_GROUP_NAME=0;
        DATA_CLASS_NAME=BCC_INTERN_STRING(STR_FAR_DATA);
        /* The original model5 path continues through the model2/4 code-name case. */
    case 2: case 4:
        CODE_SEGMENT_NAME=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(C52_MODULE_NAME)+6);
        STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,CODE_SEGMENT_NAME),C52_MODULE_NAME);
        STRING_APPEND((char far *)MK_FP(STRING_POOL_SEG.segment,CODE_SEGMENT_NAME),STR_TEXT_2);
        break;
    case 0: case 1: case 3:
        if(OPTION_OVERLAY_CODE!=0) {
            saved_line=LOGICAL_LINE;
            LOGICAL_LINE=0;
            REPORT_ERROR(MSG_OVERLAYS_ONLY);
            LOGICAL_LINE=saved_line;
        }
    }
    if(OPTION_WINDOWS_MODE!=0 && (OPTION_MEMORY_MODEL==0 || OPTION_MEMORY_MODEL==5)) REPORT_ERROR(MSG_CANNOT_USE_TINY_HUGE);
    /* Model macro, and the model's default pointer sizes: MODEL_FAR_DATA set means data
       pointers are far by default, MODEL_FAR_CODE that functions are far. */
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
    /* Segment-name options (-z...): the text "*" means not given; an empty group
       name means no group. */
    if(*C52_CODE_NAME_OPTION!='*') CODE_SEGMENT_NAME=BCC_INTERN_STRING(C52_CODE_NAME_OPTION);
    if(*C52_CODE_GROUP_OPTION!='*') {
        if(*C52_CODE_GROUP_OPTION==0) CODE_GROUP_NAME=0;
        else CODE_GROUP_NAME=BCC_INTERN_STRING(C52_CODE_GROUP_OPTION);
    }
    if(*C52_CODE_CLASS_OPTION!='*') CODE_CLASS_NAME=BCC_INTERN_STRING(C52_CODE_CLASS_OPTION);
    if(*C52_BSS_NAME_OPTION!='*') BSS_SEGMENT_NAME=BCC_INTERN_STRING(C52_BSS_NAME_OPTION);
    if(*C52_BSS_GROUP_OPTION!='*') {
        if(*C52_BSS_GROUP_OPTION==0) BSS_GROUP_NAME=0;
        else BSS_GROUP_NAME=BCC_INTERN_STRING(C52_BSS_GROUP_OPTION);
    }
    if(*C52_BSS_CLASS_OPTION!='*') BSS_CLASS_NAME=BCC_INTERN_STRING(C52_BSS_CLASS_OPTION);
    if(*C52_DATA_NAME_OPTION!='*') DATA_SEGMENT_NAME=BCC_INTERN_STRING(C52_DATA_NAME_OPTION);
    if(*C52_DATA_GROUP_OPTION!='*') {
        if(*C52_DATA_GROUP_OPTION==0) DATA_GROUP_NAME=0;
        else DATA_GROUP_NAME=BCC_INTERN_STRING(C52_DATA_GROUP_OPTION);
    }
    if(*C52_DATA_CLASS_OPTION!='*') DATA_CLASS_NAME=BCC_INTERN_STRING(C52_DATA_CLASS_OPTION);
    /* A BSS class name means BSS data gets its own segment; DATA_BSS_GROUPS_DIFFER
       notes that data and BSS are not in one group. */
    if(*(char far *)MK_FP(STRING_POOL_SEG.segment,BSS_CLASS_NAME)!=0) {
        BSS_SEGMENT_SEPARATE=1;
        DATA_BSS_GROUPS_DIFFER=DATA_GROUP_NAME==0 || BSS_GROUP_NAME==0 ||
            STRING_COMPARE((char far *)MK_FP(STRING_POOL_SEG.segment,DATA_GROUP_NAME),
                           (char far *)MK_FP(STRING_POOL_SEG.segment,BSS_GROUP_NAME))!=0;
    } else DATA_BSS_GROUPS_DIFFER=0;
    /* Output name (without extension): -o's name, unless BCC writes a temporary .asm
       for -B; else output directory + module name. */
    if(OPTION_OBJECT_NAME!=0 && (COMPILER_MODE==0 || OPTION_COMPILE_VIA_ASM==0))
        ASM_OUTPUT_PATH=BCC_INTERN_STRING(OPTION_OBJECT_NAME);
    else {
        ASM_OUTPUT_PATH=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(OPTION_OUTPUT_DIR)+STRING_LENGTH(C52_MODULE_NAME)+6);
        STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH),OPTION_OUTPUT_DIR);
        ADD_TRAILING_BACKSLASH((char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH));
        STRING_APPEND((char far *)MK_FP(STRING_POOL_SEG.segment,ASM_OUTPUT_PATH),C52_MODULE_NAME);
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
}

/* Copies text into the string pool and returns its offset there. */
unsigned int far pascal BCC_INTERN_STRING(char far *text)
{
    register unsigned int offset;
    offset=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(text)+1);
    STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,offset),text);
    return offset;
}

/* Defines a new paragraph-aligned far data segment (DEFINE_SEGMENT alignment 16) and
   returns its id. Name:
   -zF... text if given, else "<module><n>_FAR" with n = C52_FAR_SERIAL counting up;
   class FAR_DATA unless overridden; group only if one was given. */
unsigned int far pascal DEFINE_FAR_SEGMENT(void)
{
    unsigned int group;
    char number[8];
    register unsigned int segment;
    register unsigned int segment_class;
    segment_class=BCC_INTERN_STRING(STR_FAR_DATA);
    if(*C52_FAR_CLASS_OPTION!='*') {
        segment_class=BCC_INTERN_STRING(C52_FAR_CLASS_OPTION);
        RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,segment_class));
    }
    if(*C52_FAR_NAME_OPTION=='*') {
        RTL_ITOA10(C52_FAR_SERIAL,number);
        ++C52_FAR_SERIAL;
        segment=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(C52_MODULE_NAME)+STRING_LENGTH(number)+5);
        STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,segment),C52_MODULE_NAME);
        STRING_APPEND((char far *)MK_FP(STRING_POOL_SEG.segment,segment),number);
        STRING_APPEND((char far *)MK_FP(STRING_POOL_SEG.segment,segment),STR__FAR);
    } else segment=BCC_INTERN_STRING(C52_FAR_NAME_OPTION);
    RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,segment));
    if(*C52_FAR_GROUP_OPTION=='*') group=0;
    else {
        group=BCC_INTERN_STRING(C52_FAR_GROUP_OPTION);
        RTL_STRUPR((char far *)MK_FP(STRING_POOL_SEG.segment,group));
    }
    return ((unsigned int (far pascal *)(unsigned int,unsigned int,unsigned int,unsigned int))DEFINE_SEGMENT)(16,segment,group,segment_class);
}

/* Returns the integer type used for a size or scale constant built for expression
   node: long when the node's value kind (EXPR_KIND) is TK_HUGE_PTR, int otherwise
   (MODE_HOOK maps a type kind to its basic type). Used by EXPRPARS.C for sizeof. */
unsigned int far pascal PTR_SCALE_TYPE(register unsigned int node)
{
    return MODE_HOOK(((unsigned int far *)MK_FP(EXPR_POOL_SEG.segment,node))[1]==16 ? 7 : 5);
}

/* Writes one #pragma startup/exit table entry: switches the data stream to the
   word-aligned segment named second with class first (_INIT_/INITDATA or _EXIT_/EXITDATA), writes a byte 1
   if the function node is far else 0, the priority byte, then the function's address
   (tiny model: a near offset padded with two zero bytes; else a far pointer), and
   switches the stream back. */
void far pascal EMIT_STARTUP_EXIT_RECORD(register unsigned int node,unsigned char byte,unsigned int second,unsigned int first)
{
    unsigned int stream;
    stream=STREAM_HOOK(((unsigned int (far pascal *)(unsigned int,unsigned int,unsigned int,unsigned int))DEFINE_SEGMENT)(2,second,0,first));
    BYTE_HOOK(FLAG_HOOK(TYPE_HOOK(node))&1 ? 1 : 0);
    BYTE_HOOK(byte);
    if(OPTION_MEMORY_MODEL==0) {
        WORD_HOOK(node,0);
        BYTE_HOOK(0);
        BYTE_HOOK(0);
    } else ALT_HOOK(node,0);
    STREAM_HOOK(stream);
}

/* #pragma startup: first is the function, second the priority. Interns the segment and
   class names _INIT_ and INITDATA on first use. */
void far pascal ADD_STARTUP_ENTRY(unsigned int first,unsigned int second)
{
    if(SYMBOL_A1==0) {
        SYMBOL_A1=BCC_INTERN_STRING(NAME_A1);
        SYMBOL_A2=BCC_INTERN_STRING(NAME_A2);
    }
    ((void (far pascal *)(unsigned int,unsigned int,unsigned int,unsigned int))EMIT_STARTUP_EXIT_RECORD)(first,second,SYMBOL_A1,SYMBOL_A2);
}

/* #pragma exit: as ADD_STARTUP_ENTRY with _EXIT_ and EXITDATA. */
void far pascal ADD_EXIT_ENTRY(unsigned int first,unsigned int second)
{
    if(SYMBOL_B1==0) {
        SYMBOL_B1=BCC_INTERN_STRING(NAME_B1);
        SYMBOL_B2=BCC_INTERN_STRING(NAME_B2);
    }
    ((void (far pascal *)(unsigned int,unsigned int,unsigned int,unsigned int))EMIT_STARTUP_EXIT_RECORD)(first,second,SYMBOL_B1,SYMBOL_B2);
}
