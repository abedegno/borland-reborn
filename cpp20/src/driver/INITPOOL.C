/* target: INITPOOL */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module INITPOOL (image 0x5D4A..0x601B, frame 05D4h): source taken from the
   BCC.EXE reconstruction (bcc20/src/driver/INITPOOL.C), all five
   functions in BCC's order, with CPP.EXE's edits marked "CPP.EXE edit" (BEGIN_SESSION,
   END_SESSION, OPEN_SESSION_SOURCE, BEGIN_BACKEND_PHASE and removed calls in
   INIT_POOLS_AND_KEYWORDS). */
/* Role: start and end of preprocessing one file: pools, keywords, opening the source and
   the output. Entry points: BEGIN_SESSION, END_SESSION, BEGIN_BACKEND_PHASE. */
#include <dos.h>
#include "INITPOOL.H"
#include "MSG.H"

/* Overview: start and end of preprocessing one file (a "session"), used by
   COMPILE_ONE_FILE (OPTIONS.C).
   BEGIN_SESSION opens the source file and runs the preprocessor's output loop
   (WRITE_PREPROCESSED_TOKENS, TOKADV.C). Opening the source (OPEN_SESSION_SOURCE) first
   resets the front end: INIT_POOLS_AND_KEYWORDS sets up the symbol, name, hash,
   expression and string pools and enters every keyword into the name table
   (TOKEN_NAMES[token] = its name record), and the lexer state is reset.
   SESSION_PHASE tracks the session: 0 none, 1 source open, 2 output started.
   BEGIN_BACKEND_PHASE is the switch from 1 to 2 (the name is BCC's: there it started the
   code generator). In CPP.EXE it only calls INIT_SEGMENT_NAMES (SEGNAMES.C), which
   defines the predefined macros and creates the .i output file.
   END_SESSION records the free-memory low-water mark, closes the output file and frees
   everything allocated under the session's owner tag (INIT_OPTION).
   BCC's BEGIN_SESSION also reserved memory for its overlays and installed the back-end
   hook table; CPP.EXE has neither. */
/* Preprocesses the source file name. */
/* CPP.EXE edit: no memory reserve and no back-end hook table. CPP.EXE's BEGIN_SESSION
   (0x5D4A) is only the two calls: OPEN_SESSION_SOURCE (near call) and, instead of
   PARSE_EXTERNAL_DECLARATIONS, the preprocessor's token loop at CPP 0315:00D3,
   WRITE_PREPROCESSED_TOKENS (TOKADV.C); it reads CURRENT_TOKEN until 0 and writes each
   token through RFILEIO. */
extern void far pascal WRITE_PREPROCESSED_TOKENS(void);
void far pascal BEGIN_SESSION(char far *name)
{
    OPEN_SESSION_SOURCE(name);
    WRITE_PREPROCESSED_TOKENS();
}
/* status: nonzero when the compile failed (in BCC passed to SHUT_DOWN_BACKEND, which
   then deletes the output file; unused here). "elapsed" is really the free heap left now; MIN_FREE_HEAP
   keeps the lowest value seen, printed at the end as "Available memory". The calls
   through casts to FREE_TAG_NODES and FREE_OWNER_TAG are the same functions; the casts
   only give the prototype this unit needs. */
/* CPP.EXE edit: elapsed is HEAP_SPACE_BELOW_LIMIT() itself (no HEAP_RESERVE_BYTES), and
   instead of SHUT_DOWN_BACKEND(status) under SESSION_PHASE==2 the output file is closed
   unconditionally (CLOSE_OUTPUT_FILE, CPP 11FF:00C1, no arguments; status is unused but
   still popped: retf 2). */
void far pascal END_SESSION(unsigned int status)
{
    long elapsed;
    elapsed=HEAP_SPACE_BELOW_LIMIT();
    if(MIN_FREE_HEAP>elapsed)
        MIN_FREE_HEAP=elapsed;
    CLOSE_OUTPUT_FILE();
    ((void (far pascal *)(unsigned int))FREE_TAG_NODES)(INIT_OPTION);
    ((void (far pascal *)(unsigned int))FREE_OWNER_TAG)(INIT_OPTION);
    RESTORE_MALLOC_POOL_MARK();
}
/* Resets the front end and opens name as the main source file (fatal if it cannot be
   opened). CURRENT_FILE_NAME becomes a copy of name in the string pool. Then the name is
   added to the source-file list and the -D macros are defined. */
/* CPP.EXE edit: no CODE_SEGMENT_ID, OBJ_EXTERN_INDEX or INIT_PCH_STATE (0x5DBC goes
   from the INIT_POOLS_AND_KEYWORDS call straight to INIT_LEXER_STATE and then to the
   string pool). */
static void near pascal OPEN_SESSION_SOURCE(char far *name)
{
    INIT_POOLS_AND_KEYWORDS();
    INIT_LEXER_STATE();
    CURRENT_FILE_NAME=POOL_ALLOC(&STRING_POOL_SEG.segment,STRING_LENGTH(name)+1);
    STRING_COPY((char far *)MK_FP(STRING_POOL_SEG.segment,CURRENT_FILE_NAME),name);
    SOURCE_FILE_LIST=0;
    if(!OPEN_SOURCE_FILE(name))
        REPORT_FATAL(MSG_UNABLE_OPEN_INPUT_FILE,name);
    SESSION_PHASE=1;
    RECORD_SOURCE_NAME();
    DEFINE_COMMAND_LINE_MACROS();
}
/* Enters SESSION_PHASE 2 (does nothing if already there). BCC_DEBUG_NAME receives the
   main source file name (first entry of SOURCE_FILE_LIST; +2 skips the link word) and is
   used as the module name. */
/* CPP.EXE edit: reduced to the phase switch and one call. After STRING_COPY of the
   main file name into BCC_DEBUG_NAME, CPP.EXE calls only CPP 09D0:0003 with BCC_DEBUG_NAME
   (0x5E25..0x5E54). That function selects the memory model's segment names (it indexes
   a 6-byte table by the model byte, like BCC's INIT_SEGMENT_NAMES), so BCC's name is
   kept (SEGNAMES.C). No INIT_BACKEND, segment definitions or dependency list, and
   no register variable (no push si). */
void far pascal BEGIN_BACKEND_PHASE(void)
{
    if(SESSION_PHASE==2)
        return;
    SESSION_PHASE=2;
    STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(STRING_POOL_SEG.segment,SOURCE_FILE_LIST+2));
    INIT_SEGMENT_NAMES(BCC_DEBUG_NAME);
}
/* Fresh front-end state for a file: clears the 1024-entry name hash table, makes
   INIT_OPTION the heap's default owner tag (SET_DEFAULT_OWNER_TAG), sets up seven pools,
   resets the error counts and warnings, and clears TOKEN_TEXT_BUFFER together with the
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
    /* CPP.EXE edit: no POOL_HASH pool (seven POOL_INIT calls, not eight). */
    C31_BANKS[CURRENT_BANK_INDEX=0].used=C31_BANKS[CURRENT_BANK_INDEX=0].capacity=1;
    C31_BANKS[CURRENT_BANK_INDEX=0].extra=0;
    POOL_INIT(&C31_BANKS[CURRENT_BANK_INDEX=0].segment,1);
    SRCFILE_POOL_SEG.used=SRCFILE_POOL_SEG.capacity=2;
    SRCFILE_POOL_SEG.extra=0;
    POOL_INIT(&SRCFILE_POOL_SEG.segment,2);
    FUNCTION_NAME_TEXT=0;
    ERROR_COUNT=DIAGNOSTIC_COUNT=0;
    RESET_WARNINGS_TO_DEFAULT();
    /* CPP.EXE edit: no CLEAR_BACKEND_STATE. */
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
