/* symscanc.c: from bcc20/src/parser/SYMSCANC.C: the start and end of a compile by the C
   front end.  COMPILE_C_SOURCE installs the C front end's hook table, opens the file and
   sets up every table (INIT_COMPILER_TABLES: pools, keyword names, the pseudo-register
   symbols _AX..., the intrinsics), loads a precompiled header if one applies and parses
   the file.  BEGIN_BACKEND_OUTPUT (through BEGIN_BACKEND_OUTPUT_HOOK, from several places)
   opens the back end once: segment names, the code, data and BSS segments, the dependency
   records, and a few types and symbols the parser needs.  FINISH_COMPILATION runs the
   end-of-file symbol scan, shuts the back end down and frees the compile's memory.
   SESSION_PHASE: 1 once the source is open, 2 once the back end has started. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"
#include "calls.h"

#define SESSION_PHASE W(SESSION_PHASE_P)
#define INIT_OPTION W(INIT_OPTION_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define NEAR_HELPER_CALLS B(NEAR_HELPER_CALLS_P)
#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define OPTION_MEMORY_MODEL SB(OPTION_MEMORY_MODEL_P)
#define LANGUAGE_MODE SB(LANGUAGE_MODE_P)
#define ERROR_COUNT W(ERROR_COUNT_P)
#define DIAGNOSTIC_COUNT W(DIAGNOSTIC_COUNT_P)
#define LOOP_BLOCK_WEIGHT W(LOOP_BLOCK_WEIGHT_P)
#define UNSIGNED_CHAR B(UNSIGNED_CHAR_P)
#define FUNCTION_NAME_TEXT D(FUNCTION_NAME_TEXT_P)
#define DIAG_NAME_BUFFER W(DIAG_NAME_BUFFER_P)
#define BUCKET(i) W(fp_add(NAME_HASH_TABLE_P, (i) * 2))

static u16 mode_type(u16 kind) { return (u16)CALL_FAR(MODE_HOOK, A16(kind)); }

/* the entry of the C front end for one source file: its hook table installed into
   OBJ_RECORD_HOOK (196 bytes), the file opened and the tables set up, a precompiled header
   loaded if one applies, the whole file parsed */
void COMPILE_C_SOURCE(farptr name)
{
    for (int i = 0; i < 196; i++)
        B(fp_add(OBJ_RECORD_HOOK_P, i)) = B(fp_add(C_FRONTEND_HOOK_TABLE_P, i));
    BEGIN_SOURCE_FILE(name);
    TRY_PCH_LOAD();
    BCC_STATEMENT_MAIN();
}

/* the end of a C compile; status is the error count.  The lowest free heap seen is kept
   (MIN_FREE_HEAP, for the statistics); on success the back end is opened if need be and
   the end-of-file scan run.  Then the back end is closed if it was started and the memory
   of the compile's owner tag INIT_OPTION freed */
void FINISH_COMPILATION(u16 status)
{
    i32 elapsed = (i32)((u32)HEAP_SPACE_BELOW_LIMIT() - (u32)HEAP_RESERVE_BYTES);
    if (MIN_FREE_HEAP > elapsed)
        MIN_FREE_HEAP = elapsed;
    if (!status) {
        CALL_FAR0(BEGIN_BACKEND_OUTPUT_HOOK);
        SCAN_FILE_SYMBOLS_C();
    }
    if (SESSION_PHASE == 2)
        SHUT_DOWN_BACKEND(status);
    FREE_TAG_NODES((u8)INIT_OPTION);
    FREE_OWNER_TAG((u8)INIT_OPTION);
    RESTORE_MALLOC_POOL_MARK();
}

/* "warning" or "error" with a symbol's name */
static void report_named(int error, i16 message, u16 record)
{
    DIAG_NAME_BUFFER = 0;
    farptr name = NAME_TEXT_COPY(CSYM_W(record, CSYM_NAME));
    if (error)
        REPORT_ERROR(message, name);
    else
        REPORT_WARNING((u16)message, name);
}

/* the end-of-file scan of the C front end: every name of the hash table and every C
   symbol on it, all relinked into one list headed by C_GLOBAL_SCOPE's SCOPE_TAGS.  By
   class: 11 a struct or union tag never defined, "undefined structure"; 2 flag 800h dropped
   on a symbol whose type has no size; 3 and 4 statics never used (flag 80h clear),
   "declared but never used", then as 1; 1 unless flag 20h (storage done): a used function
   with no body "undefined symbol", else a tentative definition given its storage now (BSS
   unless a segment was chosen), with "size unknown or zero" when it has none.  Arrays with
   TYPE_PARAMS set go to RESERVE_ARRAY_STORAGE */
void SCAN_FILE_SYMBOLS_C(void)
{
    SCOPE_W(C_GLOBAL_SCOPE, SCOPE_TAGS) = 0;
    for (i16 bucket = 0; bucket < 0x400; bucket++)
        for (u16 chain = BUCKET(bucket); chain; chain = HLINK_W(chain, HLINK_NEXT))
            for (u16 record = NAME_W(chain, NAME_SYMBOLS), next; record; record = next) {
                next = CSYM_W(record, CSYM_NEXT);
                CSYM_W(record, CSYM_NEXT) = SCOPE_W(C_GLOBAL_SCOPE, SCOPE_TAGS);
                SCOPE_W(C_GLOBAL_SCOPE, SCOPE_TAGS) = record;
                switch (CSYM_B(record, CSYM_CLASS)) {
                case 11:
                    if (TYPE_B(CSYM_W(record, CSYM_TYPE), TYPE_KIND) != 0x15 && TYPE_W(CSYM_W(record, CSYM_TYPE), TYPE_MEMBER_CLASS) == 0)
                        report_named(0, MSG_UNDEFINED_STRUCTURE_383, record);
                    break;
                case 2:
                    /* the original tests both words of the size the hook returns */
                    if (!(CSYM_W(record, CSYM_FLAGS) & 0x800) || CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(CSYM_W(record, CSYM_TYPE))))
                        break;
                    CSYM_W(record, CSYM_FLAGS) &= (u16)~0x800;
                    break;
                case 3: case 4:
                    if (!(CSYM_W(record, CSYM_FLAGS) & 0x80))
                        report_named(0, MSG_DECLARED_BUT_NEVER, record);
                    /* fall through */
                case 1: {
                    if (CSYM_W(record, CSYM_FLAGS) & 0x20)
                        break;
                    if (TYPE_B(CSYM_W(record, CSYM_TYPE), TYPE_KIND) == 0x12) {
                        if (CSYM_W(record, CSYM_FLAGS) & 0x80)
                            report_named(1, MSG_UNDEFINED_SYMBOL, record);
                        break;
                    }
                    if (CSYM_W(record, CSYM_SEGMENT) == 0xFFFF)
                        CSYM_W(record, CSYM_SEGMENT) = BSS_SEGMENT_ID;
                    CALL_FAR(STREAM_HOOK, A16(CSYM_W(record, CSYM_SEGMENT)));
                    if (TYPE_B(CSYM_W(record, CSYM_TYPE), TYPE_KIND) == 0x11 && TYPE_B(CSYM_W(record, CSYM_TYPE), TYPE_PARAMS)) {
                        RESERVE_ARRAY_STORAGE(record);
                        break;
                    }
                    u16 alignment = (u16)CALL_FAR(TYPE_ALIGNMENT_HOOK, A16(CSYM_W(record, CSYM_TYPE)));
                    CALL_FAR(ALIGN_OUTPUT_HOOK, A16(alignment));
                    CALL_FAR(DEFINE_SYMBOL_HERE_HOOK, A16(record));
                    u16 size = (u16)CALL_FAR(SIZE_OF_TYPE_CHECKED_HOOK, A16(CSYM_W(record, CSYM_TYPE)));
                    if (!size)
                        report_named(1, MSG_SIZE_UNKNOWN_ZERO, record);
                    else
                        CALL_FAR(RESERVE_BYTES_HOOK, A16(size));
                    break;
                }
                }
            }
}

/* a C compile of the file name prepared: the error state reset, the tables, the lexer and
   the precompiled header state set up, the name copied into the string pool as
   CURRENT_FILE_NAME, the file opened (fatal if it cannot be), its name recorded for the
   dependency list and the command line's -D macros defined */
void BEGIN_SOURCE_FILE(farptr name)
{
    NO_ERRORS_YET = 1;
    C_UNNAMED_GLOBAL_LIST = 0;
    INIT_COMPILER_TABLES();
    INIT_LEXER_STATE();
    INIT_PCH_STATE();
    CURRENT_FILE_NAME = POOL_ALLOC(STRING_POOL_SEG_P, (u16)(STRING_LENGTH(name) + 1));
    STRING_COPY(MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME), name);
    SOURCE_FILE_LIST = 0;
    if (!OPEN_SOURCE_FILE(name))
        REPORT_FATAL(MSG_UNABLE_OPEN_INPUT_FILE, name);
    SESSION_PHASE = 1;
    RECORD_SOURCE_NAME();
    DEFINE_COMMAND_LINE_MACROS();
}

/* the back end started once per compile: the types the C parser needs later
   (IMPLICIT_FUNCTION_TYPE for calls to undeclared functions, C_HELPER_FUNC_TYPE for
   run-time helpers), the symbol for string literals (C_STRING_LITERAL_SYMBOL, "STR_S"),
   the back end set up with the source file's name, the code, data and BSS segments (BSS
   shares the data segment unless BSS_SEGMENT_SEPARATE), a dependency record per source
   file seen, and the name "main" (MAIN_SYMBOL) */
void BEGIN_BACKEND_OUTPUT(void)
{
    if (SESSION_PHASE == 2)
        return;
    BACKEND_MODE3_TYPE = mode_type(3);
    STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(STRING_POOL_SEG, SOURCE_FILE_LIST + STRPOOL_SRCLIST_NAME));
    INIT_SEGMENT_NAMES(BCC_DEBUG_NAME_P);
    BACKEND_OUTPUT_BEGUN_FLAG = 1;
    IMPLICIT_FUNCTION_TYPE = BUILD_FUNCTION_TYPE(PLAIN_INT_TYPE, 0, 0, 8);
    C_HELPER_FUNC_TYPE = NEW_FUNCTION_TYPE(PLAIN_INT_TYPE, 0, 2, NEAR_HELPER_CALLS ? 0x40 : 1);
    RTL_MEMSET(MK_FP(SCOPE_POOL_SEG, C_FUNCTION_SCOPE), 0, 8);
    C_STRING_LITERAL_SYMBOL = DECLARE_SYMBOL(BCC_SYMBOL_CREATE(STR_S_P, 0), C_FUNCTION_SCOPE, 0, 3, PLAIN_INT_TYPE, 0, 0xE4);
    SESSION_PHASE = 2;
    STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(STRING_POOL_SEG, SOURCE_FILE_LIST + STRPOOL_SRCLIST_NAME));
    INIT_BACKEND(BCC_DEBUG_NAME_P);
    CODE_SEGMENT_ID = DEFINE_SEGMENT(OPTION_WINDOWS_MODE ? 2 : 1, CODE_SEGMENT_NAME, CODE_GROUP_NAME, CODE_CLASS_NAME);
    DEFAULT_CODE_SEGMENT_ID = CODE_SEGMENT_ID;
    DATA_SEGMENT_ID = DEFINE_SEGMENT(2, DATA_SEGMENT_NAME, DATA_GROUP_NAME, DATA_CLASS_NAME);
    CSYM_W(C_STRING_LITERAL_SYMBOL, CSYM_SEGMENT) = DATA_SEGMENT_ID;
    BSS_SEGMENT_ID = BSS_SEGMENT_SEPARATE ? DEFINE_SEGMENT(2, BSS_SEGMENT_NAME, BSS_GROUP_NAME, BSS_CLASS_NAME) : DATA_SEGMENT_ID;
    for (u16 entry = SOURCE_FILE_LIST; entry; entry = FAR_W(STRING_POOL_SEG, entry, STRPOOL_CHAR)) {
        STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(STRING_POOL_SEG, entry + STRPOOL_SRCLIST_NAME));
        CALL_FAR(D(EMIT_DEPENDENCY_HOOK_P), A32(BCC_DEBUG_NAME_P));
    }
    MAIN_SYMBOL = BCC_SYMBOL_CREATE(STR_MAIN_P, 0x31);
}

/* a pool descriptor {segment, capacity, used, extra} at the pool's segment variable, set
   up with capacity and used both size */
static void init_pool(farptr bank, u16 size)
{
    W(fp_add(bank, 4)) = size;          /* used */
    W(fp_add(bank, 2)) = size;          /* capacity */
    W(fp_add(bank, 6)) = 0;             /* extra */
    POOL_INIT(bank, size);
}

/* everything the C front end keeps per compile set up: the name hash table, the option
   owner tag, every record pool (types from the fixed 82h-byte INITIAL_TYPE_POOL_IMAGE of
   basic types), the pseudo-register symbols (_AX... from PSEUDO_REGISTER_TABLE, not in
   strict ANSI), the intrinsics from INTRINSIC_TABLE (pointer parameters and results near or
   far by memory model), the error counters, warnings, the global and function scopes, the
   include path buffer and the keyword names (the groups from LANGUAGE_MODE up to 3, so
   stricter modes skip Borland's extension keywords) */
void INIT_COMPILER_TABLES(void)
{
    RTL_MEMSET(NAME_HASH_TABLE_P, 0, 2048);
    SET_DEFAULT_OWNER_TAG((u8)INIT_OPTION);
    init_pool(TYPE_POOL_P, 0x82);
    init_pool(DECLARATOR_NODE_POOL_SEG_P, 2);
    RTL_MEMMOVE(MK_FP(TYPE_POOL, 0), INITIAL_TYPE_POOL_IMAGE_P, 0x82);
    init_pool(CSYM_POOL_SEG_P, 2);
    init_pool(MEMBER_SEGMENT_P, 2);
    init_pool(SCOPE_POOL_SEG_P, 2);
    init_pool(NAME_POOL_SEG_P, 2);
    init_pool(HASH_CHAIN_LINK_SEG_P, 2);
    init_pool(POOL_HASH_P, 1);
    /* the original's macro sets CURRENT_BANK_INDEX on every use of the bank (four times) */
    CURRENT_BANK_INDEX = 0;
    init_pool(C31_BANKS_P, 1);
    init_pool(C_PARAM_POOL_SEG_P, 2);
    init_pool(EXPR_POOL_SEG_P, 2);
    init_pool(STRING_POOL_SEG_P, 1);
    init_pool(SRCFILE_POOL_SEG_P, 2);
    /* the pseudo-register symbols: class 7, CSYM_OFFSET the register number; 10 and 11 are
       _BP and _SP, remembered for the code generator.  Entries of 7 bytes: name, flags,
       type */
    if (!LANGUAGE_MODE)
        for (farptr token = PSEUDO_REGISTER_TABLE_P; W(token); token = fp_add(token, 7)) {
            u16 symbol = BCC_SYMBOL_CREATE(DSPTR(W(token)), 0);
            u16 record = DECLARE_SYMBOL(symbol, C_GLOBAL_SCOPE, 0, 7, mode_type((u16)(i16)SB(fp_add(token, 4))), 0, 0);
            CSYM_W(record, CSYM_OFFSET) = W(fp_add(token, 2));
            if (CSYM_W(record, CSYM_OFFSET) == 10)
                PSEUDO_REG_BP_SYMBOL = record;
            else if (CSYM_W(record, CSYM_OFFSET) == 11)
                PSEUDO_REG_SP_SYMBOL = record;
        }
    /* the intrinsics (entries of 10 bytes: name, result, -, count, -, four parameters):
       memory models from 3 up have far data pointers, so pointer kinds become 15 instead of
       13 */
    i16 extended = OPTION_MEMORY_MODEL >= 3, number = 0;
    for (farptr entry = INTRINSIC_TABLE_P; W(entry); entry = fp_add(entry, 10), number++) {
        for (i16 index = 0; index < SB(fp_add(entry, 4)); index++) {
            farptr parameter = fp_add(entry, 6 + index);
            if (EXPR_FLAGS_AT((i16)SB(parameter)) & 0x14)
                B(parameter) = extended ? 15 : 13;
        }
        u16 record = DECLARE_SYMBOL(BCC_SYMBOL_CREATE(DSPTR(W(entry)), 0), C_GLOBAL_SCOPE, 0, 10, 0, 0, 0);
        if (EXPR_FLAGS_AT((i16)SB(fp_add(entry, 2))) & 0x14)
            B(fp_add(entry, 2)) = extended ? 15 : 13;
        CSYM_W(record, CSYM_OFFSET) = (u16)number;
    }
    FUNCTION_NAME_TEXT = 0;
    DIAGNOSTIC_COUNT = 0;
    ERROR_COUNT = 0;
    RESET_WARNINGS_TO_DEFAULT();
    CLEAR_BACKEND_STATE();
    INIT_LEXER_POOLS();
    C_GLOBAL_SCOPE = POOL_ALLOC(SCOPE_POOL_SEG_P, 8);
    RTL_MEMSET(MK_FP(SCOPE_POOL_SEG, C_GLOBAL_SCOPE), 0, 8);
    C_FUNCTION_SCOPE = POOL_ALLOC(SCOPE_POOL_SEG_P, 8);
    C_FUNC_DEF_SET_ONLY_FLAG = 1;
    RTL_MEMSET(TOKEN_TEXT_BUFFER_P, 0, 0x1083);
    C_DECL_SCOPE = C_GLOBAL_SCOPE;
    GLOBAL_SCOPE = C_GLOBAL_SCOPE;
    CURRENT_SCOPE = GLOBAL_SCOPE;
    LOOP_BLOCK_WEIGHT = 1;
    COMPILER_TABLES_INIT_FLAG = 1;
    /* keyword groups of 6 bytes: a far pointer to {token, near text} entries, a count */
    for (i16 index = LANGUAGE_MODE; index <= 3; ++index) {
        farptr group = fp_add(C31_KEYWORD_GROUPS_P, index * 6);
        farptr words = D(group);
        for (i16 number2 = (i16)W(fp_add(group, 4)); number2; --number2, words = fp_add(words, 4))
            TOKEN_NAMES_AT(W(words)) = BCC_SYMBOL_CREATE(DSPTR(W(fp_add(words, 2))), W(words));
    }
    PLAIN_INT_TYPE = mode_type(5);
    STRING_CHAR_TYPE = mode_type(UNSIGNED_CHAR ? 2 : 1);
}
