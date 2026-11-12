/* target: ovr126_C240UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: end-of-file symbol scan (C mode); initialisation. Entry points: COMPILE_C_SOURCE,
   FINISH_COMPILATION, BEGIN_BACKEND_OUTPUT. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: start and end of a compilation by the C-mode front end.  BCC
   2.0 has two front ends: the C front end (this directory's CDECL.C,
   CDECLR.C and STMTC.C, with C symbol records CSYM_* and scopes
   C_GLOBAL_SCOPE / C_FUNCTION_SCOPE) and the C++ front end (STMTCPP.C,
   DECLSPEC.C and the rest).  The driver (OPTIONS.C) calls
   COMPILE_C_SOURCE for a C compile.  The order is:
     COMPILE_C_SOURCE -> BEGIN_SOURCE_FILE -> INIT_COMPILER_TABLES
       (pools, keyword names, pseudo-register symbols _AX.., intrinsics),
       then TRY_PCH_LOAD and BCC_STATEMENT_MAIN, which parses the file;
     BEGIN_BACKEND_OUTPUT (called through BEGIN_BACKEND_OUTPUT_HOOK from
       several places: BCC_STATEMENT_MAIN, some directive and macro paths in
       src/preproc, and the driver at the end) opens the back end: segment names, the code, data and BSS segments, the
       dependency records, and a few types and symbols the parser needs;
     FINISH_COMPILATION -> SCAN_FILE_SYMBOLS_C reports unused and undefined
       names and reserves storage for tentative definitions, then shuts the
       back end down and frees the compile's memory.
   SESSION_PHASE tracks progress: 1 after the source is open, 2 once the
   back end has been started (BEGIN_BACKEND_OUTPUT returns at once if it
   is already 2).  The C++ front end has its own scan, CHECK_FILE_SYMBOLS
   in SYMSCAN.C.  The "row" and "listing" comments record where each
   function sat in the original overlay. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"
#include "POOL.H"

/* ---- COMPILE_C_SOURCE (row 0000, listing D5A0) ---- */
/* row X045_02 (offset 0x0000): stub 0CED:0020 = COMPILE_C_SOURCE */
struct C31Dispatch { unsigned char representation[196]; };
extern struct C31Dispatch  OBJ_RECORD_HOOK,C_FRONTEND_HOOK_TABLE;
extern void far pascal TRY_PCH_LOAD(void);
extern void far pascal BCC_STATEMENT_MAIN(void);
static void near pascal BEGIN_SOURCE_FILE(char far *);
/* Entry point of the C front end for one source file (name is its path):
   installs the C front end's hook table into OBJ_RECORD_HOOK, opens the
   file and initialises every table, loads a precompiled header if one
   applies, then parses the whole file. */
void far pascal COMPILE_C_SOURCE(char far *name)
{
    OBJ_RECORD_HOOK=C_FRONTEND_HOOK_TABLE;
    BEGIN_SOURCE_FILE(name);
    TRY_PCH_LOAD();
    BCC_STATEMENT_MAIN();
}

/* ---- FINISH_COMPILATION (listing D5CC) ---- */
/* row FINISH_COMPILATION (offset 0x002C): stub 0CED:0025 = FINISH_COMPILATION */
static void near pascal SCAN_FILE_SYMBOLS_C(void);
extern unsigned int  SESSION_PHASE,INIT_OPTION;
extern void (far pascal *BEGIN_BACKEND_OUTPUT_HOOK)(void);
extern long far pascal HEAP_SPACE_BELOW_LIMIT(void);
extern void far pascal SHUT_DOWN_BACKEND(unsigned int);
extern void far pascal FREE_TAG_NODES(unsigned int);
extern void far pascal FREE_OWNER_TAG(unsigned int);
extern unsigned int far pascal RESTORE_MALLOC_POOL_MARK(void);
/* End of a C compile.  status is the error count (0 means success).
   Records the lowest free heap seen (MIN_FREE_HEAP, for statistics),
   and on success makes sure the back end is open and runs the
   end-of-file symbol scan.  Then closes the back end if it was started
   and frees all memory owned by the compile's owner tag INIT_OPTION. */
void far pascal FINISH_COMPILATION(unsigned int status)
{
    long elapsed;
    elapsed=HEAP_SPACE_BELOW_LIMIT()-HEAP_RESERVE_BYTES;
    if(MIN_FREE_HEAP>elapsed)
        MIN_FREE_HEAP=elapsed;
    if(!status) {
        BEGIN_BACKEND_OUTPUT_HOOK();
        SCAN_FILE_SYMBOLS_C();
    }
    if(SESSION_PHASE==2)
        SHUT_DOWN_BACKEND(status);
    FREE_TAG_NODES(INIT_OPTION);
    FREE_OWNER_TAG(INIT_OPTION);
    RESTORE_MALLOC_POOL_MARK();
}

/* ---- SCAN_FILE_SYMBOLS_C (listing D63F) ---- */
/* row SCAN_FILE_SYMBOLS_C (offset 0x009F): static, no stub; also holds static BEGIN_SOURCE_FILE (0x02F7) */
static void near pascal INIT_COMPILER_TABLES(void);
/* This row holds two private near functions: D63F (row offset 009F)
   and D897 (row offset 02F7, after D63F's switch table). */
extern unsigned int SCOPE_POOL_SEG; extern unsigned int NAME_POOL_SEG; extern unsigned int HASH_CHAIN_LINK_SEG;
extern unsigned int DIAG_NAME_BUFFER;
extern unsigned int near  NAME_HASH_TABLE[];
extern unsigned int (far pascal *SIZE_OF_TYPE_CHECKED_HOOK)(unsigned int);
extern void (far pascal *STREAM_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_ALIGNMENT_HOOK)(unsigned int);
extern void (far pascal *ALIGN_OUTPUT_HOOK)(unsigned int);
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern void (far pascal *RESERVE_BYTES_HOOK)(unsigned int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal RESERVE_ARRAY_STORAGE(unsigned int);
/* End-of-file scan for the C front end.  Walks every name in the hash
   table and every C symbol on it, and as a side effect relinks all those
   symbols into one list headed by SCOPE_TAGS of C_GLOBAL_SCOPE.  By
   symbol class (CSYM_CLASS):
     11: a struct/union tag never defined: warning "undefined structure";
      2: drops flag 0x800 on a symbol whose type has no size (probably
         an extern array of unknown size);
   3, 4: static names never used (flag 0x80 clear): "declared but never
         used", then the same storage handling as class 1;
      1: unless flag 0x20 says storage is already done: a used function
         with no body is "undefined symbol"; otherwise the variable is a
         tentative definition and gets its storage now (in BSS unless a
         segment was chosen), with "size unknown or zero" if it has no
         size.  Arrays with TYPE_PARAMS set go to RESERVE_ARRAY_STORAGE. */
static void near pascal SCAN_FILE_SYMBOLS_C(void)
{
    unsigned int next;
    int bucket;
    unsigned int chain;
    register unsigned int record;
    register unsigned int function;
    SCOPE_W(C_GLOBAL_SCOPE,SCOPE_TAGS)=0;
    for(bucket=0;bucket<0x400;bucket++) {
        for(chain=NAME_HASH_TABLE[bucket];chain;chain=HLINK_W(chain,HLINK_NEXT)) {
            for(record=NAME_W(chain,NAME_SYMBOLS);record;record=next) {
                /* Push the symbol onto the global list (see above). */
                next=CSYM_W(record,CSYM_NEXT);
                CSYM_W(record,CSYM_NEXT)=SCOPE_W(C_GLOBAL_SCOPE,SCOPE_TAGS);
                SCOPE_W(C_GLOBAL_SCOPE,SCOPE_TAGS)=record;
                switch(CSYM_B(record,CSYM_CLASS)) {
                case 11:
                    if(TYPE_B(CSYM_W(record,CSYM_TYPE),TYPE_KIND)!=0x15
                       && TYPE_W(CSYM_W(record,CSYM_TYPE),TYPE_MEMBER_CLASS)==0) {
                        DIAG_NAME_BUFFER=0;
                        REPORT_WARNING(MSG_UNDEFINED_STRUCTURE_383,NAME_TEXT_COPY(CSYM_W(record,CSYM_NAME)));
                    }
                    break;
                case 2:
                    if(!(CSYM_W(record,CSYM_FLAGS)&0x800)
                       || SIZE_OF_TYPE_CHECKED_HOOK(CSYM_W(record,CSYM_TYPE))
                       /* Exception: the original also tests the high word the
                          call leaves in DX (017E or ax,ax ... 0185 or dx,dx); no
                          long, far or huge return type gives that pair of tests. */
                       || _DX) break;
                    CSYM_W(record,CSYM_FLAGS)&=~0x800;
                    break;
                case 3: case 4:
                    if(!(CSYM_W(record,CSYM_FLAGS)&0x80)) {
                        DIAG_NAME_BUFFER=0;
                        REPORT_WARNING(MSG_DECLARED_BUT_NEVER,NAME_TEXT_COPY(CSYM_W(record,CSYM_NAME)));
                    }
                    /* fall through */
                case 1:
                    if(CSYM_W(record,CSYM_FLAGS)&0x20) break;
                    if(TYPE_B(CSYM_W(record,CSYM_TYPE),TYPE_KIND)==0x12) {
                        if(CSYM_W(record,CSYM_FLAGS)&0x80) {
                            DIAG_NAME_BUFFER=0;
                            REPORT_ERROR(MSG_UNDEFINED_SYMBOL,NAME_TEXT_COPY(CSYM_W(record,CSYM_NAME)));
                        }
                        break;
                    }
                    if(CSYM_W(record,CSYM_SEGMENT)==0xFFFF)
                        CSYM_W(record,CSYM_SEGMENT)=BSS_SEGMENT_ID;
                    STREAM_HOOK(CSYM_W(record,CSYM_SEGMENT));
                    if(TYPE_B(CSYM_W(record,CSYM_TYPE),TYPE_KIND)==0x11
                       && TYPE_B(CSYM_W(record,CSYM_TYPE),TYPE_PARAMS)!=0) {
                        RESERVE_ARRAY_STORAGE(record);
                        break;
                    }
                    ALIGN_OUTPUT_HOOK(TYPE_ALIGNMENT_HOOK(CSYM_W(record,CSYM_TYPE)));
                    DEFINE_SYMBOL_HERE_HOOK(record);
                    function=SIZE_OF_TYPE_CHECKED_HOOK(CSYM_W(record,CSYM_TYPE));
                    if(!function) {
                        DIAG_NAME_BUFFER=0;
                        REPORT_ERROR(MSG_SIZE_UNKNOWN_ZERO,NAME_TEXT_COPY(CSYM_W(record,CSYM_NAME)));
                    } else RESERVE_BYTES_HOOK(function);
                    break;
                }
            }
        }
    }
}

extern unsigned int STRING_POOL_SEG;
extern void far pascal INIT_LEXER_STATE(void);
extern void far pascal INIT_PCH_STATE(void);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned int far pascal OPEN_SOURCE_FILE(char far *);
extern void far pascal RECORD_SOURCE_NAME(void);
extern void far pascal DEFINE_COMMAND_LINE_MACROS(void);
/* Prepares a C compile of the file name: resets error state
   (NO_ERRORS_YET=1 means no error yet), initialises the tables, the lexer
   and the precompiled-header state, copies the name into the string
   pool as CURRENT_FILE_NAME, opens the file (a fatal error if it cannot
   be opened), records its name for the dependency list and defines the
   -D macros from the command line. */
static void near pascal BEGIN_SOURCE_FILE(char far *name)
{
    NO_ERRORS_YET=1;
    C_UNNAMED_GLOBAL_LIST=0;
    INIT_COMPILER_TABLES();
    INIT_LEXER_STATE();
    INIT_PCH_STATE();
    CURRENT_FILE_NAME=POOL_ALLOC(&STRING_POOL_SEG,STRING_LENGTH(name)+1);
    STRING_COPY((char far *)MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME),name);
    SOURCE_FILE_LIST=0;
    if(!OPEN_SOURCE_FILE(name))
        REPORT_FATAL(MSG_UNABLE_OPEN_INPUT_FILE,name);
    SESSION_PHASE=1;
    RECORD_SOURCE_NAME();
    DEFINE_COMMAND_LINE_MACROS();
}

/* ---- BEGIN_BACKEND_OUTPUT (listing D91C) ---- */
/* row BEGIN_BACKEND_OUTPUT (offset 0x037C): stub 0CED:002A = BEGIN_BACKEND_OUTPUT */
extern unsigned int CODE_SEGMENT_ID;
extern unsigned char  NEAR_HELPER_CALLS,OPTION_WINDOWS_MODE;
extern unsigned int (far pascal *MODE_HOOK)(unsigned int);
extern void (far pascal *EMIT_DEPENDENCY_HOOK)(char far *);
extern void far pascal INIT_SEGMENT_NAMES(char far *);
extern unsigned int far pascal BUILD_FUNCTION_TYPE(unsigned int,unsigned int,unsigned char,signed char);
extern unsigned int far pascal NEW_FUNCTION_TYPE(unsigned int,unsigned int,unsigned char,int);
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
extern unsigned int far pascal DECLARE_SYMBOL(unsigned int,unsigned int,unsigned char,unsigned int,unsigned int,unsigned int,unsigned int);
extern void far pascal INIT_BACKEND(char far *);
extern unsigned int far pascal DEFINE_SEGMENT(unsigned int,unsigned int,unsigned int,unsigned int);
/* Starts the back end once per compile (no-op when SESSION_PHASE is
   already 2).  Builds the types the C parser needs later
   (IMPLICIT_FUNCTION_TYPE for calls to undeclared functions,
   C_HELPER_FUNC_TYPE for run-time helpers), declares the internal symbol
   for string literals (C_STRING_LITERAL_SYMBOL, named STR_S), initialises
   the back end with the source file name, defines the code, data and BSS
   segments (BSS shares the data segment unless BSS_SEGMENT_SEPARATE),
   emits one dependency record per source file seen so far, and creates
   the name "main" (MAIN_SYMBOL) so the parser can recognise it. */
void far pascal BEGIN_BACKEND_OUTPUT(void)
{
    register unsigned int entry;
    if(SESSION_PHASE==2)
        return;
    BACKEND_MODE3_TYPE=MODE_HOOK(3);
    STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(STRING_POOL_SEG,SOURCE_FILE_LIST+STRPOOL_SRCLIST_NAME));
    INIT_SEGMENT_NAMES(BCC_DEBUG_NAME);
    BACKEND_OUTPUT_BEGUN_FLAG=1;
    IMPLICIT_FUNCTION_TYPE=BUILD_FUNCTION_TYPE(PLAIN_INT_TYPE,0,0,8);
    C_HELPER_FUNC_TYPE=NEW_FUNCTION_TYPE(PLAIN_INT_TYPE,0,2,NEAR_HELPER_CALLS?0x40:1);
    RTL_MEMSET(MK_FP(SCOPE_POOL_SEG,C_FUNCTION_SCOPE),0,8);
    C_STRING_LITERAL_SYMBOL=DECLARE_SYMBOL(BCC_SYMBOL_CREATE(STR_S,0),C_FUNCTION_SCOPE,0,3,PLAIN_INT_TYPE,0,0xE4);
    SESSION_PHASE=2;
    STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(STRING_POOL_SEG,SOURCE_FILE_LIST+STRPOOL_SRCLIST_NAME));
    INIT_BACKEND(BCC_DEBUG_NAME);
    DEFAULT_CODE_SEGMENT_ID=CODE_SEGMENT_ID=DEFINE_SEGMENT(OPTION_WINDOWS_MODE?2:1,CODE_SEGMENT_NAME,CODE_GROUP_NAME,CODE_CLASS_NAME);
    CSYM_W(C_STRING_LITERAL_SYMBOL,CSYM_SEGMENT)=DATA_SEGMENT_ID=DEFINE_SEGMENT(2,DATA_SEGMENT_NAME,DATA_GROUP_NAME,DATA_CLASS_NAME);
    BSS_SEGMENT_ID=BSS_SEGMENT_SEPARATE?DEFINE_SEGMENT(2,BSS_SEGMENT_NAME,BSS_GROUP_NAME,BSS_CLASS_NAME):DATA_SEGMENT_ID;
    for(entry=SOURCE_FILE_LIST;entry;entry=FAR_W(STRING_POOL_SEG,entry,STRPOOL_CHAR)) {
        STRING_COPY(BCC_DEBUG_NAME,(char far *)MK_FP(STRING_POOL_SEG,entry+STRPOOL_SRCLIST_NAME));
        EMIT_DEPENDENCY_HOOK(BCC_DEBUG_NAME);
    }
    MAIN_SYMBOL=BCC_SYMBOL_CREATE(STR_MAIN,0x31);
}

/* ---- INIT_COMPILER_TABLES (listing DAA4) ---- */
/* row INIT_COMPILER_TABLES (offset 0x0504): static, no stub */
struct C31Bank { unsigned int segment,capacity,used,extra; };
struct C31Keyword { unsigned int token; char near *text; };
struct C31KeywordGroup { struct C31Keyword far *entries; int count; };
struct C9Token {
    char near *name;
    unsigned int flags;
    signed char type;
    unsigned char reserved[2];
};
struct C9Intrinsic {
    char near *name;
    signed char result;
    unsigned char reserved3;
    signed char count;
    unsigned char reserved5;
    signed char parameters[4];
};
extern unsigned int EXPR_POOL_SEG; extern unsigned int SRCFILE_POOL_SEG;
extern unsigned int DIAGNOSTIC_COUNT; extern unsigned int ERROR_COUNT;
extern unsigned int LOOP_BLOCK_WEIGHT;
extern char far *FUNCTION_NAME_TEXT;
extern signed char  LANGUAGE_MODE,OPTION_MEMORY_MODEL;
extern unsigned char UNSIGNED_CHAR;
extern struct C31Bank near  C31_BANKS[];
extern struct C31KeywordGroup near  C31_KEYWORD_GROUPS[];
extern struct C9Token near  PSEUDO_REGISTER_TABLE[];
extern struct C9Intrinsic  INTRINSIC_TABLE[];
extern void far pascal SET_DEFAULT_OWNER_TAG(unsigned char);
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);
extern void far pascal RESET_WARNINGS_TO_DEFAULT(void);
extern void far pascal CLEAR_BACKEND_STATE(void);
extern void far pascal INIT_LEXER_POOLS(void);
#define BANK(name) (*(struct C31Bank near *)&(name))
/* Clears and initialises everything the C front end keeps per compile:
   the name hash table, the option set (SET_DEFAULT_OWNER_TAG), every record pool
   (types start from the fixed INITIAL_TYPE_POOL_IMAGE of 0x82 bytes holding
   the basic types), the pseudo-register symbols (_AX, _BX ... from
   PSEUDO_REGISTER_TABLE, which are not defined in strict ANSI mode, LANGUAGE_MODE
   nonzero), the intrinsic functions from INTRINSIC_TABLE (pointer-typed
   parameters and results become near or far pointers by memory model),
   error counters, warnings, the global and function scopes, the include
   search path buffer and the keyword names: keyword groups from
   LANGUAGE_MODE up to 3 are entered, so stricter modes skip the Borland
   extension keywords.  LANGUAGE_MODE is probably the
   language-level option (-A and similar). */
static void near pascal INIT_COMPILER_TABLES(void)
{
    struct C31Keyword far *words;
    struct C9Intrinsic far *entry;
    struct C9Token near *token;
    unsigned int symbol;
    unsigned int record;
    int extended;
    register int index;
    register int number;
    RTL_MEMSET(NAME_HASH_TABLE,0,2048);
    SET_DEFAULT_OWNER_TAG((unsigned char)INIT_OPTION);
    BANK(TYPE_POOL).used=BANK(TYPE_POOL).capacity=0x82;
    BANK(TYPE_POOL).extra=0;
    POOL_INIT(&BANK(TYPE_POOL).segment,0x82);
    BANK(DECLARATOR_NODE_POOL_SEG).used=BANK(DECLARATOR_NODE_POOL_SEG).capacity=2;
    BANK(DECLARATOR_NODE_POOL_SEG).extra=0;
    POOL_INIT(&BANK(DECLARATOR_NODE_POOL_SEG).segment,2);
    RTL_MEMMOVE(MK_FP(TYPE_POOL,0),(void far *)INITIAL_TYPE_POOL_IMAGE,0x82);
    BANK(CSYM_POOL_SEG).used=BANK(CSYM_POOL_SEG).capacity=2;
    BANK(CSYM_POOL_SEG).extra=0;
    POOL_INIT(&BANK(CSYM_POOL_SEG).segment,2);
    BANK(MEMBER_SEGMENT).used=BANK(MEMBER_SEGMENT).capacity=2;
    BANK(MEMBER_SEGMENT).extra=0;
    POOL_INIT(&BANK(MEMBER_SEGMENT).segment,2);
    BANK(SCOPE_POOL_SEG).used=BANK(SCOPE_POOL_SEG).capacity=2;
    BANK(SCOPE_POOL_SEG).extra=0;
    POOL_INIT(&BANK(SCOPE_POOL_SEG).segment,2);
    BANK(NAME_POOL_SEG).used=BANK(NAME_POOL_SEG).capacity=2;
    BANK(NAME_POOL_SEG).extra=0;
    POOL_INIT(&BANK(NAME_POOL_SEG).segment,2);
    BANK(HASH_CHAIN_LINK_SEG).used=BANK(HASH_CHAIN_LINK_SEG).capacity=2;
    BANK(HASH_CHAIN_LINK_SEG).extra=0;
    POOL_INIT(&BANK(HASH_CHAIN_LINK_SEG).segment,2);
    BANK(POOL_HASH).used=BANK(POOL_HASH).capacity=1;
    BANK(POOL_HASH).extra=0;
    POOL_INIT(&BANK(POOL_HASH).segment,1);
    /* Documented exception (undefined behaviour in standard C, predictable in
       BC): the original's macro sets CURRENT_BANK_INDEX on every use of the bank,
       storing it four times (0626, 063A, 064C, 0660). */
#define CURRENT_BANK(i) C31_BANKS[CURRENT_BANK_INDEX=(i)]
    CURRENT_BANK(0).used=CURRENT_BANK(0).capacity=1;
    CURRENT_BANK(0).extra=0;
    POOL_INIT(&CURRENT_BANK(0).segment,1);
#undef CURRENT_BANK
    BANK(C_PARAM_POOL_SEG).used=BANK(C_PARAM_POOL_SEG).capacity=2;
    BANK(C_PARAM_POOL_SEG).extra=0;
    POOL_INIT(&BANK(C_PARAM_POOL_SEG).segment,2);
    BANK(EXPR_POOL_SEG).used=BANK(EXPR_POOL_SEG).capacity=2;
    BANK(EXPR_POOL_SEG).extra=0;
    POOL_INIT(&BANK(EXPR_POOL_SEG).segment,2);
    BANK(STRING_POOL_SEG).used=BANK(STRING_POOL_SEG).capacity=1;
    BANK(STRING_POOL_SEG).extra=0;
    POOL_INIT(&BANK(STRING_POOL_SEG).segment,1);
    BANK(SRCFILE_POOL_SEG).used=BANK(SRCFILE_POOL_SEG).capacity=2;
    BANK(SRCFILE_POOL_SEG).extra=0;
    POOL_INIT(&BANK(SRCFILE_POOL_SEG).segment,2);
    /* Pseudo-register symbols: class 7, CSYM_OFFSET holds the register
       number; 10 and 11 are _BP and _SP, remembered because the code
       generator treats them specially. */
    if(!LANGUAGE_MODE) {
        for(token=PSEUDO_REGISTER_TABLE;token->name;token++) {
            symbol=BCC_SYMBOL_CREATE(token->name,0);
            record=DECLARE_SYMBOL(symbol,C_GLOBAL_SCOPE,0,7,MODE_HOOK(token->type),0,0);
            CSYM_W(record,CSYM_OFFSET)=token->flags;
            if(CSYM_W(record,CSYM_OFFSET)==10) PSEUDO_REG_BP_SYMBOL=record;
            else if(CSYM_W(record,CSYM_OFFSET)==11) PSEUDO_REG_SP_SYMBOL=record;
        }
    }
    /* Intrinsics: memory models from 3 up (probably compact, large, huge)
       have far data pointers, so pointer parameters become kind 15
       (TK_FAR_PTR) instead of 13 (TK_NEAR_PTR). */
    extended=OPTION_MEMORY_MODEL>=3;
    for(entry=INTRINSIC_TABLE,number=0;entry->name;entry++,number++) {
        for(index=0;index<entry->count;index++) {
            if(EXPR_FLAGS[(int)entry->parameters[index]]&0x14)
                entry->parameters[index]=extended?15:13;
        }
        record=DECLARE_SYMBOL(BCC_SYMBOL_CREATE(entry->name,0),C_GLOBAL_SCOPE,0,10,0,0,0);
        if(EXPR_FLAGS[(int)entry->result]&0x14)
            entry->result=extended?15:13;
        CSYM_W(record,CSYM_OFFSET)=number;
    }
    FUNCTION_NAME_TEXT=0;
    ERROR_COUNT=DIAGNOSTIC_COUNT=0;
    RESET_WARNINGS_TO_DEFAULT();
    CLEAR_BACKEND_STATE();
    INIT_LEXER_POOLS();
    C_GLOBAL_SCOPE=POOL_ALLOC(&BANK(SCOPE_POOL_SEG).segment,8);
    RTL_MEMSET(MK_FP(SCOPE_POOL_SEG,C_GLOBAL_SCOPE),0,8);
    C_FUNCTION_SCOPE=POOL_ALLOC(&BANK(SCOPE_POOL_SEG).segment,8);
    C_FUNC_DEF_SET_ONLY_FLAG=1;
    RTL_MEMSET(TOKEN_TEXT_BUFFER,0,0x1083);
    C_DECL_SCOPE=C_GLOBAL_SCOPE;
    CURRENT_SCOPE=GLOBAL_SCOPE=C_GLOBAL_SCOPE;
    LOOP_BLOCK_WEIGHT=1;
    COMPILER_TABLES_INIT_FLAG=1;
    for(index=LANGUAGE_MODE;index<=3;++index) {
        words=C31_KEYWORD_GROUPS[index].entries;
        number=C31_KEYWORD_GROUPS[index].count;
        while(number) {
            TOKEN_NAMES[words->token]=BCC_SYMBOL_CREATE(words->text,words->token);
            ++words;
            --number;
        }
    }
    PLAIN_INT_TYPE=MODE_HOOK(5);
    STRING_CHAR_TYPE=MODE_HOOK(UNSIGNED_CHAR?2:1);
}
#undef BANK
