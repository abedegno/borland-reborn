/* initpool.c: from bcc20/src/driver/INITPOOL.C: the start and end of one compile
   ("session") of the C++ front end, which COMPILE_ONE_FILE uses for .cpp files and -P (C
   files go through COMPILE_C_SOURCE instead).
   BEGIN_SESSION reserves conventional memory for the overlays, installs the default
   back-end hook table (OBJ_RECORD_HOOK, a 196-byte block of far function pointers copied
   from C31_DEFAULT_DISPATCH), opens the source file and runs the whole parse.  Opening the
   source (OPEN_SESSION_SOURCE) first resets the front end: INIT_POOLS_AND_KEYWORDS sets up
   the symbol, name, hash, expression and string pools and enters every keyword into the
   name table (TOKEN_NAMES[token] = its name record), and the lexer and precompiled-header
   state are reset.  SESSION_PHASE tracks the session: 0 none, 1 parsing, 2 back end
   running.  BEGIN_BACKEND_PHASE is the switch from 1 to 2, made once when the first code
   or data must be written: it sets up segment names, starts the back end and defines the
   code, data and BSS segments; then it passes every source file name seen so far
   (SOURCE_FILE_LIST in the string pool) to EMIT_DEPENDENCY_HOOK.  END_SESSION records the
   free-memory low-water mark, shuts the back end down and frees everything allocated under
   the session's owner tag (INIT_OPTION).  A pool descriptor is segment, growth step
   ("capacity"), unit ("used") and an extra word. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"
#include "calls.h"
#include "msg.h"
#include "variadic.h"

#define C31_MEMORY_OPTION SB(C31_MEMORY_OPTION_P)
#define LANGUAGE_MODE SB(LANGUAGE_MODE_P)
#define OPTION_FLAGS B(OPTION_FLAGS_P)
#define OPTION_WINDOWS_MODE B(OPTION_WINDOWS_MODE_P)
#define PRAGMA_CODESEG_SEEN B(PRAGMA_CODESEG_SEEN_P)
#define INIT_OPTION W(INIT_OPTION_P)
#define SESSION_PHASE W(SESSION_PHASE_P)
#define CODE_SEGMENT_ID W(CODE_SEGMENT_ID_P)
#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define ERROR_COUNT W(ERROR_COUNT_P)
#define DIAGNOSTIC_COUNT W(DIAGNOSTIC_COUNT_P)
#define FUNCTION_NAME_TEXT D(FUNCTION_NAME_TEXT_P)

/* compiles the C++ source file name.  Unless a memory limit was given it asks the heap to
   leave 135000 bytes of conventional memory free, probably for the overlay buffer; too
   little memory is fatal.  HEAP_RESERVE_BYTES records how much of that reserve could not be
   had */
void BEGIN_SESSION(farptr name)
{
    if (!C31_MEMORY_OPTION && C31_SET_MEMORY_LIMIT(135000UL) < 135000UL)
        REPORT_FATAL(MSG_OUT_MEMORY);
    HEAP_RESERVE_BYTES = 135000L - (i32)C31_MEMORY_LIMIT();
    memmove(at(OBJ_RECORD_HOOK_P), at(C31_DEFAULT_DISPATCH_P), 196);
    OPEN_SESSION_SOURCE(name);
    PARSE_EXTERNAL_DECLARATIONS();
}

/* status: nonzero when the compile failed (passed to SHUT_DOWN_BACKEND, which then deletes
   the output file).  The free heap left now goes into MIN_FREE_HEAP when it is the lowest
   seen, printed at the end as "Available memory" */
void END_SESSION(u16 status)
{
    i32 left = HEAP_SPACE_BELOW_LIMIT() - HEAP_RESERVE_BYTES;
    if (MIN_FREE_HEAP > left)
        MIN_FREE_HEAP = left;
    if (SESSION_PHASE == 2)
        SHUT_DOWN_BACKEND(status);
    FREE_TAG_NODES((u8)INIT_OPTION);
    FREE_OWNER_TAG((u8)INIT_OPTION);
    RESTORE_MALLOC_POOL_MARK();
}

/* resets the front end and opens name as the main source file (fatal if it cannot be
   opened).  CURRENT_FILE_NAME becomes a copy of name in the string pool.  Then the name is
   added to the source-file list and the -D macros are defined */
void OPEN_SESSION_SOURCE(farptr name)
{
    CODE_SEGMENT_ID = 0;
    INIT_POOLS_AND_KEYWORDS();
    OBJ_EXTERN_INDEX = 1;
    INIT_LEXER_STATE();
    INIT_PCH_STATE();
    u16 copy = POOL_ALLOC(STRING_POOL_SEG_P, STRING_LENGTH(name) + 1);
    CURRENT_FILE_NAME = copy;
    STRING_COPY(MK_FP(STRING_POOL_SEG, CURRENT_FILE_NAME), name);
    SOURCE_FILE_LIST = 0;
    if (!OPEN_SOURCE_FILE(name))
        REPORT_FATAL(MSG_UNABLE_OPEN_INPUT_FILE, name);
    SESSION_PHASE = 1;
    RECORD_SOURCE_NAME();
    DEFINE_COMMAND_LINE_MACROS();
}

/* enters SESSION_PHASE 2 (does nothing if already there).  BCC_DEBUG_NAME receives the
   main source file name (first entry of SOURCE_FILE_LIST, after its link word) and is used
   as the module name.  DEFINE_SEGMENT's first argument is the alignment (1 byte, 2 word, 16
   paragraph).  The code segment is defined twice with the same names; the second call
   finds the record made by the first, so DEFAULT_CODE_SEGMENT_ID and CODE_SEGMENT_ID get
   the same id and the first alignment stays: word for Windows code, else byte.  Data and
   BSS are word aligned.  BSS gets its own segment only when BSS_SEGMENT_SEPARATE is set */
void BEGIN_BACKEND_PHASE(void)
{
    if (SESSION_PHASE == 2)
        return;
    SESSION_PHASE = 2;
    STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(STRING_POOL_SEG, SOURCE_FILE_LIST + 2));
    INIT_SEGMENT_NAMES(BCC_DEBUG_NAME_P);
    INIT_BACKEND(BCC_DEBUG_NAME_P);
    u16 segment = DEFINE_SEGMENT(OPTION_WINDOWS_MODE ? 2 : 1, CODE_SEGMENT_NAME, CODE_GROUP_NAME, CODE_CLASS_NAME);
    CODE_SEGMENT_ID = segment;
    DEFAULT_CODE_SEGMENT_ID = CODE_SEGMENT_ID;
    segment = DEFINE_SEGMENT(1, CODE_SEGMENT_NAME, CODE_GROUP_NAME, CODE_CLASS_NAME);
    CODE_SEGMENT_ID = segment;
    segment = DEFINE_SEGMENT(2, DATA_SEGMENT_NAME, DATA_GROUP_NAME, DATA_CLASS_NAME);
    DATA_SEGMENT_ID = segment;
    segment = BSS_SEGMENT_SEPARATE ? DEFINE_SEGMENT(2, BSS_SEGMENT_NAME, BSS_GROUP_NAME, BSS_CLASS_NAME)
                                   : DATA_SEGMENT_ID;
    BSS_SEGMENT_ID = segment;
    PRAGMA_CODESEG_SEEN = 0;
    /* each list node: a link word, then the file name */
    for (u16 entry = SOURCE_FILE_LIST; entry; entry = W(MK_FP(STRING_POOL_SEG, entry))) {
        STRING_COPY(BCC_DEBUG_NAME_P, MK_FP(STRING_POOL_SEG, entry + 2));
        CALL_FAR(D(EMIT_DEPENDENCY_HOOK_P), A32(BCC_DEBUG_NAME_P));
    }
}

/* a pool descriptor set up with growth step and unit amount and its first segment */
static void init_bank(farptr bank, u16 amount)
{
    W(fp_add(bank, 2)) = amount;
    W(fp_add(bank, 4)) = amount;
    W(fp_add(bank, 6)) = 0;
    POOL_INIT(bank, amount);
}

/* fresh front-end state for a compile: clears the 1024-entry name hash table, makes
   INIT_OPTION the heap's default owner tag, sets up eight pools, resets the error counts,
   warnings and back-end state, and clears TOKEN_TEXT_BUFFER together with the 1083h bytes
   of globals that follow it.  Bank 0 of C31_BANKS is set with CURRENT_BANK_INDEX set to 0.
   Then the keywords enter the name table, group by group: LANGUAGE_MODE (0 Borland, 1 ANSI,
   and so on, set by -A) is the first group used, so stricter modes skip the leading groups
   of extension keywords; group 5 is used only for C++ (OPTION_FLAGS bit 0).  A group is a
   far pointer to its entries and a count; an entry is a token and a near pointer to its
   text */
void INIT_POOLS_AND_KEYWORDS(void)
{
    RTL_MEMSET(NAME_HASH_TABLE_P, 0, 2048);
    SET_DEFAULT_OWNER_TAG((u8)INIT_OPTION);
    init_bank(SCOPE_POOL_SEG_P, 2);
    init_bank(NAME_POOL_SEG_P, 2);
    init_bank(HASH_CHAIN_LINK_SEG_P, 2);
    init_bank(EXPR_POOL_SEG_P, 2);
    init_bank(STRING_POOL_SEG_P, 1);
    init_bank(POOL_HASH_P, 1);
    CURRENT_BANK_INDEX = 0;
    init_bank(C31_BANKS_P, 1);
    init_bank(SRCFILE_POOL_SEG_P, 2);
    FUNCTION_NAME_TEXT = 0;
    DIAGNOSTIC_COUNT = 0;
    ERROR_COUNT = 0;
    RESET_WARNINGS_TO_DEFAULT();
    CLEAR_BACKEND_STATE();
    INIT_LEXER_POOLS();
    RTL_MEMSET(TOKEN_TEXT_BUFFER_P, 0, 0x1083);
    i16 extended = (OPTION_FLAGS & 1) != 0;
    for (i16 group = LANGUAGE_MODE; group <= extended + 4; ++group) {
        farptr entry = fp_add(C31_KEYWORD_GROUPS_P, group * 6);
        farptr words = D(entry);
        for (i16 left = SW(fp_add(entry, 4)); left; --left, words = fp_add(words, 4)) {
            u16 token = W(words);
            u16 name = BCC_SYMBOL_CREATE(DSPTR(W(fp_add(words, 2))), token);
            TOKEN_NAMES_AT(token) = name;
        }
    }
}
