/* segnames.c: from bcc20/src/driver/SEGNAMES.C: names and set-up that depend on the memory
   model and the -z options, done once per module when the back end starts
   (INIT_SEGMENT_NAMES, from BEGIN_BACKEND_PHASE), plus a few small services used later.
   INIT_SEGMENT_NAMES fills the code, data and BSS segment, group and class names
   (CODE_SEGMENT_NAME ... BSS_CLASS_NAME, all offsets of strings in STRING_POOL_SEG): _TEXT/
   CODE, _DATA/DGROUP/DATA, _BSS/DGROUP/BSS by default; medium, large and huge models use
   "<module>_TEXT", and huge also "<module>_DATA" in class FAR_DATA with no group and no
   separate BSS.  A -z option whose text is not "*" overrides a name.  The function also
   defines the predefined macros (__SMALL__ and the like, __MSDOS__, __TURBOC__ 0x0297,
   __BORLANDC__ 0x0200, __TCPLUSPLUS__ for C++, __OVERLAY__, __CDECL__ ...) and the output
   file name ASM_OUTPUT_PATH.  DEFINE_FAR_SEGMENT makes a new far data segment
   ("<module><n>_FAR", n counting from 5) for far variables.  EMIT_STARTUP_EXIT_RECORD writes
   one #pragma startup/exit entry into the _INIT_ or _EXIT_ segment.  REGISTER_NAME and
   BCC_TOKEN_FLAG read PSEUDO_REGISTER_TABLE, the table of pseudo-register variables (_AX,
   _DX, ...: 7-byte entries of a near name, the register number, the type kind and a
   debugger register code). */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define OPTION_MEMORY_MODEL SB(OPTION_MEMORY_MODEL_P)
#define OPTION_OVERLAY_CODE B(OPTION_OVERLAY_CODE_P)
#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)
#define OPTION_FLAGS B(OPTION_FLAGS_P)
#define OPTION_CALLING_CONVENTION B(OPTION_CALLING_CONVENTION_P)
#define COMPILER_MODE B(COMPILER_MODE_P)
#define OPTION_COMPILE_VIA_ASM B(OPTION_COMPILE_VIA_ASM_P)
#define MODEL_FAR_CODE B(MODEL_FAR_CODE_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
/* far pointers (SEGNAMES.H), where globals.h reads a word */
#undef OPTION_OUTPUT_DIR
#undef OPTION_OBJECT_NAME
#define OPTION_OUTPUT_DIR D(OPTION_OUTPUT_DIR_P)
#define OPTION_OBJECT_NAME D(OPTION_OBJECT_NAME_P)
/* the -z options' texts */
#undef C52_CODE_NAME_OPTION
#define C52_CODE_NAME_OPTION D(C52_CODE_NAME_OPTION_P)
#undef C52_CODE_GROUP_OPTION
#define C52_CODE_GROUP_OPTION D(C52_CODE_GROUP_OPTION_P)
#undef C52_CODE_CLASS_OPTION
#define C52_CODE_CLASS_OPTION D(C52_CODE_CLASS_OPTION_P)
#undef C52_DATA_NAME_OPTION
#define C52_DATA_NAME_OPTION D(C52_DATA_NAME_OPTION_P)
#undef C52_DATA_GROUP_OPTION
#define C52_DATA_GROUP_OPTION D(C52_DATA_GROUP_OPTION_P)
#undef C52_DATA_CLASS_OPTION
#define C52_DATA_CLASS_OPTION D(C52_DATA_CLASS_OPTION_P)
#undef C52_BSS_NAME_OPTION
#define C52_BSS_NAME_OPTION D(C52_BSS_NAME_OPTION_P)
#undef C52_BSS_GROUP_OPTION
#define C52_BSS_GROUP_OPTION D(C52_BSS_GROUP_OPTION_P)
#undef C52_BSS_CLASS_OPTION
#define C52_BSS_CLASS_OPTION D(C52_BSS_CLASS_OPTION_P)
#undef C52_FAR_NAME_OPTION
#define C52_FAR_NAME_OPTION D(C52_FAR_NAME_OPTION_P)
#undef C52_FAR_GROUP_OPTION
#define C52_FAR_GROUP_OPTION D(C52_FAR_GROUP_OPTION_P)
#undef C52_FAR_CLASS_OPTION
#define C52_FAR_CLASS_OPTION D(C52_FAR_CLASS_OPTION_P)

#define POOL_TEXT(offset) MK_FP(STRING_POOL_SEG, (offset))
/* a pseudo-register table entry */
#define PREG(i) fp_add(PSEUDO_REGISTER_TABLE_P, (i) * 7)
#define PREG_NAME(e) W(e)
#define PREG_FLAGS(e) W(fp_add((e), 2))
#define PREG_TYPE(e) SB(fp_add((e), 4))
#define PREG_CODE(e) SB(fp_add((e), 5))

/* the lower-case assembler name ("ax", "dl" ...) of register number kind for an operand of
   type kind suffix (the pseudo-register entry whose register field is kind and whose type
   is suffix), built in TOKEN_TEXT from the entry's name without its leading '_'; 0 when
   there is no such entry */
farptr REGISTER_NAME(i8 kind, i8 suffix)
{
    for (farptr entry = PREG(0); PREG_NAME(entry); entry = fp_add(entry, 7))
        if (PREG_FLAGS(entry) == (u16)(i16)kind && PREG_TYPE(entry) == suffix) {
            TOKEN_TEXT_AT(2) = 0;
            TOKEN_TEXT_AT(0) = (i8)TOLOWER(SB(DSPTR(PREG_NAME(entry) + 1)));
            TOKEN_TEXT_AT(1) = (i8)TOLOWER(SB(DSPTR(PREG_NAME(entry) + 2)));
            return TOKEN_TEXT_P;
        }
    return 0;
}

/* the debugger register code of the first pseudo-register entry for register number kind,
   or 0 (for register variables in Turbo Debugger records) */
i16 BCC_TOKEN_FLAG(i8 kind)
{
    for (farptr entry = PREG(0); PREG_NAME(entry); entry = fp_add(entry, 7))
        if (PREG_FLAGS(entry) == (u16)(i16)kind)
            return PREG_CODE(entry);
    return 0;
}

/* a pool string "<module><suffix>" with room for 6 more bytes than the module name */
static u16 module_name_with(farptr suffix)
{
    u16 offset = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(C52_MODULE_NAME_P) + 6);
    STRING_COPY(POOL_TEXT(offset), C52_MODULE_NAME_P);
    STRING_APPEND(POOL_TEXT(offset), suffix);
    return offset;
}

/* the name a -z option gives, when it gives one ("*" means not given); for a group, an
   empty text means no group */
static void z_option(farptr text, farptr name, int group)
{
    if (SB(text) == '*')
        return;
    if (group && SB(text) == 0)
        W(name) = 0;
    else {
        u16 offset = BCC_INTERN_STRING(text);
        W(name) = offset;
    }
}

/* filename: the module's source name; its base name becomes C52_MODULE_NAME.  Also resets
   the far-segment counter and the startup/exit segment names.  See the overview.
   OPTION_MEMORY_MODEL: 0 tiny, 1 small, 2 medium, 3 compact, 4 large, 5 huge */
void INIT_SEGMENT_NAMES(farptr filename)
{
    FNSPLIT(filename, 0, 0, C52_MODULE_NAME_P, 0);
    C52_FAR_SERIAL = 5;
    SYMBOL_B1 = 0;
    SYMBOL_A1 = 0;
    CODE_SEGMENT_NAME = BCC_INTERN_STRING(STR__TEXT_P);
    CODE_CLASS_NAME = BCC_INTERN_STRING(STR_CODE_P);
    CODE_GROUP_NAME = 0;
    DATA_SEGMENT_NAME = BCC_INTERN_STRING(STR___P);
    DATA_GROUP_NAME = BCC_INTERN_STRING(STR_DGROUP_P);
    DATA_CLASS_NAME = BCC_INTERN_STRING(STR_DATA_P);
    BSS_GROUP_NAME = BCC_INTERN_STRING(STR_DGROUP_P);
    BSS_SEGMENT_NAME = BCC_INTERN_STRING(STR_X5F_2_P);
    BSS_CLASS_NAME = BCC_INTERN_STRING(STR_BSS_P);
    BSS_SEGMENT_SEPARATE = 1;
    switch (OPTION_MEMORY_MODEL) {
    case 5:
        DATA_SEGMENT_NAME = module_name_with(STR___P);
        BSS_SEGMENT_SEPARATE = 0;
        BSS_GROUP_NAME = 0;
        BSS_CLASS_NAME = BCC_INTERN_STRING(STR_EMPTY_3_P);
        DATA_GROUP_NAME = 0;
        DATA_CLASS_NAME = BCC_INTERN_STRING(STR_FAR_DATA_P);
        /* fall through: the code name as for medium and large */
    case 2:
    case 4:
        CODE_SEGMENT_NAME = module_name_with(STR_TEXT_2_P);
        break;
    case 0:
    case 1:
    case 3:
        if (OPTION_OVERLAY_CODE != 0) {
            u16 saved_line = LOGICAL_LINE;
            LOGICAL_LINE = 0;
            REPORT_ERROR(MSG_OVERLAYS_ONLY);
            LOGICAL_LINE = saved_line;
        }
    }
    if (OPTION_WINDOWS_MODE != 0 && (OPTION_MEMORY_MODEL == 0 || OPTION_MEMORY_MODEL == 5))
        REPORT_ERROR(MSG_CANNOT_USE_TINY_HUGE);
    /* the model macro, and the model's default pointer sizes: MODEL_FAR_DATA set means data
       pointers are far by default, MODEL_FAR_CODE that functions are far */
    farptr model = fp_add(C52_MODEL_INFO_P, OPTION_MEMORY_MODEL * 6);
    MACRO_DEFINE(D(model), STR_1_P, -1, 0);
    MODEL_FAR_DATA = B(fp_add(model, 4));
    MODEL_FAR_CODE = B(fp_add(model, 5));
    if (C52_OS2_OPTION != 0) {
        if (C52_MULTITHREAD_OPTION != 0)
            MACRO_DEFINE(STR___MULTI_THREAD___P, STR_XFB_P, -1, 0);
        else
            MACRO_DEFINE(STR___SINGLE_THREAD___P, STR_XFB_P, -1, 0);
        if (C52_DLL_OPTION != 0)
            MACRO_DEFINE(STR___DLL___P, STR_XFB_P, -1, 0);
        MACRO_DEFINE(STR___OS2___P, STR_1_P, -1, 0);
    } else
        MACRO_DEFINE(STR___MSDOS___P, STR_1_P, -1, 0);
    if (OPTION_WINDOWS_MODE != 0) {
        MACRO_DEFINE(STR__WINDOWS_P, STR_XFB_P, -1, 0);
        if (OPTION_WINDOWS_MODE == 2 || OPTION_WINDOWS_MODE == 5)
            MACRO_DEFINE(STR___DLL___P, STR_1_P, -1, 0);
    }
    MACRO_DEFINE(STR___TURBOC___P, STR_0X0297_P, -1, 0);
    MACRO_DEFINE(STR___BORLANDC___P, STR_0X0200_P, -1, 0);
    if (OPTION_FLAGS != 0) {
        MACRO_DEFINE(STR___TCPLUSPLUS___P, STR_0X0200_P, -1, 0);
        MACRO_DEFINE(STR___BCPLUSPLUS___P, STR_0X0200_P, -1, 0);
    }
    if (OPTION_OVERLAY_CODE != 0)
        MACRO_DEFINE(STR___OVERLAY___P, STR_1_P, -1, 0);
    farptr calling_macro;
    if (OPTION_CALLING_CONVENTION == 1)
        calling_macro = STR___PASCAL___P;
    else if (OPTION_CALLING_CONVENTION == 2)
        calling_macro = STR___FASTCALL___P;
    else
        calling_macro = STR___CDECL___P;
    MACRO_DEFINE(calling_macro, STR_1_P, -1, 0);
    z_option(C52_CODE_NAME_OPTION, CODE_SEGMENT_NAME_P, 0);
    z_option(C52_CODE_GROUP_OPTION, CODE_GROUP_NAME_P, 1);
    z_option(C52_CODE_CLASS_OPTION, CODE_CLASS_NAME_P, 0);
    z_option(C52_BSS_NAME_OPTION, BSS_SEGMENT_NAME_P, 0);
    z_option(C52_BSS_GROUP_OPTION, BSS_GROUP_NAME_P, 1);
    z_option(C52_BSS_CLASS_OPTION, BSS_CLASS_NAME_P, 0);
    z_option(C52_DATA_NAME_OPTION, DATA_SEGMENT_NAME_P, 0);
    z_option(C52_DATA_GROUP_OPTION, DATA_GROUP_NAME_P, 1);
    z_option(C52_DATA_CLASS_OPTION, DATA_CLASS_NAME_P, 0);
    /* a BSS class name means BSS data gets its own segment; DATA_BSS_GROUPS_DIFFER notes
       that data and BSS are not in one group */
    if (B(POOL_TEXT(BSS_CLASS_NAME)) != 0) {
        BSS_SEGMENT_SEPARATE = 1;
        DATA_BSS_GROUPS_DIFFER = DATA_GROUP_NAME == 0 || BSS_GROUP_NAME == 0 ||
                                 STRING_COMPARE(POOL_TEXT(DATA_GROUP_NAME), POOL_TEXT(BSS_GROUP_NAME)) != 0;
    } else
        DATA_BSS_GROUPS_DIFFER = 0;
    /* the output name (without extension): -o's name, unless BCC writes a temporary .asm
       for -B; else output directory + module name */
    if (OPTION_OBJECT_NAME != 0 && (COMPILER_MODE == 0 || OPTION_COMPILE_VIA_ASM == 0))
        ASM_OUTPUT_PATH = BCC_INTERN_STRING(OPTION_OBJECT_NAME);
    else {
        u16 path = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(OPTION_OUTPUT_DIR) + STRING_LENGTH(C52_MODULE_NAME_P) + 6);
        ASM_OUTPUT_PATH = path;
        STRING_COPY(POOL_TEXT(ASM_OUTPUT_PATH), OPTION_OUTPUT_DIR);
        ADD_TRAILING_BACKSLASH(POOL_TEXT(ASM_OUTPUT_PATH));
        STRING_APPEND(POOL_TEXT(ASM_OUTPUT_PATH), C52_MODULE_NAME_P);
    }
    RTL_STRUPR(POOL_TEXT(CODE_SEGMENT_NAME));
    RTL_STRUPR(POOL_TEXT(CODE_CLASS_NAME));
    RTL_STRUPR(POOL_TEXT(CODE_GROUP_NAME));
    RTL_STRUPR(POOL_TEXT(DATA_SEGMENT_NAME));
    RTL_STRUPR(POOL_TEXT(DATA_CLASS_NAME));
    RTL_STRUPR(POOL_TEXT(DATA_GROUP_NAME));
    RTL_STRUPR(POOL_TEXT(BSS_SEGMENT_NAME));
    RTL_STRUPR(POOL_TEXT(BSS_CLASS_NAME));
    RTL_STRUPR(POOL_TEXT(BSS_GROUP_NAME));
}

/* copies text into the string pool and returns its offset there */
u16 BCC_INTERN_STRING(farptr text)
{
    u16 offset = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(text) + 1);
    STRING_COPY(POOL_TEXT(offset), text);
    return offset;
}

/* defines a new paragraph-aligned far data segment (alignment 16) and returns its id.
   Name: the -zF text if given, else "<module><n>_FAR" with n = C52_FAR_SERIAL counting up;
   class FAR_DATA unless overridden; group only if one was given.  The number's text is
   built at bp-0Ah in BCC's frame */
u16 DEFINE_FAR_SEGMENT(void)
{
    u16 segment_class = BCC_INTERN_STRING(STR_FAR_DATA_P);
    if (SB(C52_FAR_CLASS_OPTION) != '*') {
        segment_class = BCC_INTERN_STRING(C52_FAR_CLASS_OPTION);
        RTL_STRUPR(POOL_TEXT(segment_class));
    }
    u16 segment;
    if (SB(C52_FAR_NAME_OPTION) == '*') {
        u16 mark = scratch_mark();
        farptr number = scratch_alloc(0x0A);
        RTL_ITOA10((i16)C52_FAR_SERIAL, number);
        ++C52_FAR_SERIAL;
        segment = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(C52_MODULE_NAME_P) + STRING_LENGTH(number) + 5);
        STRING_COPY(POOL_TEXT(segment), C52_MODULE_NAME_P);
        STRING_APPEND(POOL_TEXT(segment), number);
        STRING_APPEND(POOL_TEXT(segment), STR__FAR_P);
        scratch_release(mark);
    } else
        segment = BCC_INTERN_STRING(C52_FAR_NAME_OPTION);
    RTL_STRUPR(POOL_TEXT(segment));
    u16 group = 0;
    if (SB(C52_FAR_GROUP_OPTION) != '*') {
        group = BCC_INTERN_STRING(C52_FAR_GROUP_OPTION);
        RTL_STRUPR(POOL_TEXT(group));
    }
    return DEFINE_SEGMENT(16, segment, group, segment_class);
}

/* the integer type used for a size or scale constant built for expression node: long when
   the node's value kind is TK_HUGE_PTR, int otherwise */
u16 PTR_SCALE_TYPE(u16 node)
{
    return (u16)CALL_FAR(MODE_HOOK, A16(EXPR_W(node, EXPR_KIND) == 16 ? 7 : 5));
}

/* writes one #pragma startup/exit table entry: switches the data stream to the word-aligned
   segment named name with class segment_class (_INIT_/INITDATA or _EXIT_/EXITDATA), writes
   a byte 1 if the function node is far else 0, the priority byte, then the function's
   address (tiny model: a near offset padded with two zero bytes; else a far pointer), and
   switches the stream back */
void EMIT_STARTUP_EXIT_RECORD(u16 node, u8 priority, u16 name, u16 segment_class)
{
    u16 segment = DEFINE_SEGMENT(2, name, 0, segment_class);
    u16 stream = (u16)CALL_FAR(STREAM_HOOK, A16(segment));
    u16 type = (u16)CALL_FAR(TYPE_HOOK, A16(node));
    CALL_FAR(BYTE_HOOK, A16(((u16)CALL_FAR(FLAG_HOOK, A16(type)) & 1) ? 1 : 0));
    CALL_FAR(BYTE_HOOK, A16(priority));
    if (OPTION_MEMORY_MODEL == 0) {
        CALL_FAR(WORD_HOOK, A16(node), A16(0));
        CALL_FAR(BYTE_HOOK, A16(0));
        CALL_FAR(BYTE_HOOK, A16(0));
    } else
        CALL_FAR(ALT_HOOK, A16(node), A16(0));
    CALL_FAR(STREAM_HOOK, A16(stream));
}

/* #pragma startup: function, then priority.  Interns the segment and class names _INIT_
   and INITDATA on first use */
void ADD_STARTUP_ENTRY(u16 function, u16 priority)
{
    if (SYMBOL_A1 == 0) {
        SYMBOL_A1 = BCC_INTERN_STRING(NAME_A1_P);
        SYMBOL_A2 = BCC_INTERN_STRING(NAME_A2_P);
    }
    EMIT_STARTUP_EXIT_RECORD(function, (u8)priority, SYMBOL_A1, SYMBOL_A2);
}

/* #pragma exit: as ADD_STARTUP_ENTRY with _EXIT_ and EXITDATA */
void ADD_EXIT_ENTRY(u16 function, u16 priority)
{
    if (SYMBOL_B1 == 0) {
        SYMBOL_B1 = BCC_INTERN_STRING(NAME_B1_P);
        SYMBOL_B2 = BCC_INTERN_STRING(NAME_B2_P);
    }
    EMIT_STARTUP_EXIT_RECORD(function, (u8)priority, SYMBOL_B1, SYMBOL_B2);
}
