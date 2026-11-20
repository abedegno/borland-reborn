/* target: ovr087_C31UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: compiler initialisation: pools, keywords. Entry points: BEGIN_SESSION, END_SESSION,
   BEGIN_BACKEND_PHASE. Map of all sources: docs/SOURCE-MAP.md. */
#include <dos.h>
#include "INITPOOL.H"
#include "MSG.H"

/* Overview: start and end of one compile ("session") of the C++ front end, which
   COMPILE_ONE_FILE (OPTIONS.C) uses for .cpp files and -P (C files go through
   COMPILE_C_SOURCE instead).
   BEGIN_SESSION reserves conventional memory for the overlays, installs the default
   back-end hook table (OBJ_RECORD_HOOK, a 196-byte block of far function pointers copied
   from C31_DEFAULT_DISPATCH), opens the source file and runs the whole parse
   (PARSE_EXTERNAL_DECLARATIONS). Opening the source (OPEN_SESSION_SOURCE) first resets
   the front end: INIT_POOLS_AND_KEYWORDS sets up the symbol, name, hash, expression and
   string pools and enters every keyword into the name table (TOKEN_NAMES[token] =
   its name record), and the lexer and precompiled-header state are reset.
   SESSION_PHASE tracks the session: 0 none, 1 parsing, 2 back end running.
   BEGIN_BACKEND_PHASE is the switch from 1 to 2, made once when the first code or data
   must be written: it sets up segment names, starts the back end (INIT_BACKEND) and
   defines the code, data and BSS segments; then it passes every source file name seen
   so far (SOURCE_FILE_LIST in the string pool) to EMIT_DEPENDENCY_HOOK, which probably
   writes them as dependency records into the object file.
   END_SESSION records the free-memory low-water mark, shuts the back end down and frees
   everything allocated under the session's owner tag (INIT_OPTION). */
/* 0000: actual resource limit, complete dispatch-table installation, then session start. */
/* Compiles the C++ source file name. Unless a memory limit was given (C31_MEMORY_OPTION)
   it asks the heap to leave 135000 bytes of conventional memory free, probably for the
   overlay buffer; too little memory is fatal. HEAP_RESERVE_BYTES records how much of
   that reserve could not be had. */
void far pascal BEGIN_SESSION(char far *name)
{
    if(!C31_MEMORY_OPTION)
        if(C31_SET_MEMORY_LIMIT(135000UL)<135000UL)
            REPORT_FATAL(MSG_OUT_MEMORY);
    HEAP_RESERVE_BYTES=135000L-(long)C31_MEMORY_LIMIT();
    OBJ_RECORD_HOOK=C31_DEFAULT_DISPATCH;
    OPEN_SESSION_SOURCE(name);
    PARSE_EXTERNAL_DECLARATIONS();
}
/* 0069: record the real signed LONG minimum and release the session. */
/* status: nonzero when the compile failed (passed to SHUT_DOWN_BACKEND, which then
   deletes the output file). "elapsed" is really the free heap left now; MIN_FREE_HEAP
   keeps the lowest value seen, printed at the end as "Available memory". The calls
   through casts to FREE_TAG_NODES and FREE_OWNER_TAG are the same functions; the casts
   only give the prototype this unit needs. */
void far pascal END_SESSION(unsigned int status)
{
    long elapsed;
    elapsed=HEAP_SPACE_BELOW_LIMIT()-HEAP_RESERVE_BYTES;
    if(MIN_FREE_HEAP>elapsed)
        MIN_FREE_HEAP=elapsed;
    if(SESSION_PHASE==2)
        SHUT_DOWN_BACKEND(status);
    ((void (far pascal *)(unsigned int))FREE_TAG_NODES)(INIT_OPTION);
    ((void (far pascal *)(unsigned int))FREE_OWNER_TAG)(INIT_OPTION);
    RESTORE_MALLOC_POOL_MARK();
}
/* 00CE: allocate and retain the session name before opening the scanner. */
/* Resets the front end and opens name as the main source file (fatal if it cannot be
   opened). CURRENT_FILE_NAME becomes a copy of name in the string pool. Then the name is
   added to the source-file list and the -D macros are defined. */
static void near pascal OPEN_SESSION_SOURCE(char far *name)
{
    CODE_SEGMENT_ID=0;
    INIT_POOLS_AND_KEYWORDS();
    OBJ_EXTERN_INDEX=1;
    INIT_LEXER_STATE();
    INIT_PCH_STATE();
    CURRENT_FILE_NAME=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(name)+1);
    STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,CURRENT_FILE_NAME),name);
    SOURCE_FILE_LIST=0;
    if(!OPEN_SOURCE_FILE(name))
        REPORT_FATAL(MSG_UNABLE_OPEN_INPUT_FILE,name);
    SESSION_PHASE=1;
    RECORD_SOURCE_NAME();
    DEFINE_COMMAND_LINE_MACROS();
}
/* 0154: idempotent second phase; materialize names before invoking the backend. */
/* Enters SESSION_PHASE 2 (does nothing if already there). BCC_DEBUG_NAME receives the
   main source file name (first entry of SOURCE_FILE_LIST; +2 skips the link word) and is
   used as the module name. DEFINE_SEGMENT's first argument is the alignment (1 byte,
   2 word, 16 paragraph). The code segment is defined twice with the same names; the
   second call finds the record made by the first (DEFINE_SEGMENT matches name, group
   and class), so DEFAULT_CODE_SEGMENT_ID and CODE_SEGMENT_ID get the same id and the
   first alignment stays: word for Windows code, else byte. Data and BSS are word
   aligned. BSS gets its own segment only when BSS_SEGMENT_SEPARATE is set
   (INIT_SEGMENT_NAMES clears it for the huge model). */
void far pascal BEGIN_BACKEND_PHASE(void)
{
    register unsigned int entry;
    if(SESSION_PHASE==2)
        return;
    SESSION_PHASE=2;
    STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(STRING_POOL_SEG.segment,SOURCE_FILE_LIST+2));
    INIT_SEGMENT_NAMES(BCC_DEBUG_NAME);
    INIT_BACKEND(BCC_DEBUG_NAME);
    DEFAULT_CODE_SEGMENT_ID=CODE_SEGMENT_ID=((unsigned int (far pascal *)(unsigned int,unsigned int,unsigned int,unsigned int))DEFINE_SEGMENT)(OPTION_WINDOWS_MODE?2:1,CODE_SEGMENT_NAME,CODE_GROUP_NAME,CODE_CLASS_NAME);
    CODE_SEGMENT_ID=((unsigned int (far pascal *)(unsigned int,unsigned int,unsigned int,unsigned int))DEFINE_SEGMENT)(1,CODE_SEGMENT_NAME,CODE_GROUP_NAME,CODE_CLASS_NAME);
    DATA_SEGMENT_ID=((unsigned int (far pascal *)(unsigned int,unsigned int,unsigned int,unsigned int))DEFINE_SEGMENT)(2,DATA_SEGMENT_NAME,DATA_GROUP_NAME,DATA_CLASS_NAME);
    BSS_SEGMENT_ID=BSS_SEGMENT_SEPARATE?((unsigned int (far pascal *)(unsigned int,unsigned int,unsigned int,unsigned int))DEFINE_SEGMENT)(2,BSS_SEGMENT_NAME,BSS_GROUP_NAME,BSS_CLASS_NAME):DATA_SEGMENT_ID;
    PRAGMA_CODESEG_SEEN=0;
        /* Each list node: a link word, then the file name. */
    for(entry=SOURCE_FILE_LIST;entry;entry=*(unsigned int far *)MK_FP(STRING_POOL_SEG.segment,entry)) {
        STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(STRING_POOL_SEG.segment,entry+2));
        EMIT_DEPENDENCY_HOOK(BCC_DEBUG_NAME);
    }
}
/* 0240: real bank descriptors, repeated indexed stores and native keyword groups. */
/* Fresh front-end state for a compile: clears the 1024-entry name hash table, makes
   INIT_OPTION the heap's default owner tag (SET_DEFAULT_OWNER_TAG), sets up eight pools, resets the
   error counts, warnings and back-end state, and clears TOKEN_TEXT_BUFFER together with the
   0x1083 bytes of globals that follow it.
   Each C31Bank is a pool descriptor: segment, growth step ("capacity"), unit ("used",
   set to the same value) and an extra word cleared to 0; POOL_INIT allocates the first
   segment. The writes through C31_BANKS[CURRENT_BANK_INDEX=0] set CURRENT_BANK_INDEX to
   0 each time and fill bank 0. */
static void near pascal INIT_POOLS_AND_KEYWORDS(void)
{
    int extended;
    struct C31Keyword far *words;
    register int group;
    register int left;
    RTL_MEMSET(NAME_HASH_TABLE,0,2048);
    SET_DEFAULT_OWNER_TAG((unsigned char)INIT_OPTION);
    SCOPE_POOL_SEG.used=SCOPE_POOL_SEG.capacity=2;
    SCOPE_POOL_SEG.extra=0;
    POOL_INIT(&SCOPE_POOL_SEG.segment,2);
    NAME_POOL_SEG.used=NAME_POOL_SEG.capacity=2;
    NAME_POOL_SEG.extra=0;
    POOL_INIT(&NAME_POOL_SEG.segment,2);
    HASH_CHAIN_LINK_SEG.used=HASH_CHAIN_LINK_SEG.capacity=2;
    HASH_CHAIN_LINK_SEG.extra=0;
    POOL_INIT(&HASH_CHAIN_LINK_SEG.segment,2);
    EXPR_POOL_SEG.used=EXPR_POOL_SEG.capacity=2;
    EXPR_POOL_SEG.extra=0;
    POOL_INIT(&EXPR_POOL_SEG.segment,2);
    STRING_POOL_SEG.used=STRING_POOL_SEG.capacity=1;
    STRING_POOL_SEG.extra=0;
    POOL_INIT(&STRING_POOL_SEG.segment,1);
    POOL_HASH.used=POOL_HASH.capacity=1;
    POOL_HASH.extra=0;
    POOL_INIT(&POOL_HASH.segment,1);
    C31_BANKS[CURRENT_BANK_INDEX=0].used=C31_BANKS[CURRENT_BANK_INDEX=0].capacity=1;
    C31_BANKS[CURRENT_BANK_INDEX=0].extra=0;
    POOL_INIT(&C31_BANKS[CURRENT_BANK_INDEX=0].segment,1);
    SRCFILE_POOL_SEG.used=SRCFILE_POOL_SEG.capacity=2;
    SRCFILE_POOL_SEG.extra=0;
    POOL_INIT(&SRCFILE_POOL_SEG.segment,2);
    FUNCTION_NAME_TEXT=0;
    ERROR_COUNT=DIAGNOSTIC_COUNT=0;
    RESET_WARNINGS_TO_DEFAULT();
    CLEAR_BACKEND_STATE();
    INIT_LEXER_POOLS();
    RTL_MEMSET(TOKEN_TEXT_BUFFER,0,0x1083);
    /* Enter keywords into the name table, group by group. LANGUAGE_MODE (the
       language-mode switch: 0 Borland, 1 ANSI, and so on, set by -A) is the first
       group used, so stricter modes skip the leading groups of extension keywords
       (probably near, far, asm and the like). Group 5 is used only for C++
       (OPTION_FLAGS bit 0), probably the C++ keywords. */
    extended=(OPTION_FLAGS&1)!=0;
    for(group=LANGUAGE_MODE;group<=extended+4;++group) {
        words=C31_KEYWORD_GROUPS[group].entries;
        left=C31_KEYWORD_GROUPS[group].count;
        while(left) {
            TOKEN_NAMES[words->token]=BCC_SYMBOL_CREATE(words->text,words->token);
            ++words;
            --left;
        }
    }
}
