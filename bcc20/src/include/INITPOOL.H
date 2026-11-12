#ifndef INITPOOL_H
#define INITPOOL_H
#include "RTL.H"
#include "HEAP.H"
struct C31Dispatch { unsigned char representation[196]; };
struct C31Bank { unsigned int segment,capacity,used,extra; };
struct C31Keyword { unsigned int token; char near *text; };
struct C31KeywordGroup { struct C31Keyword far *entries; int count; };
extern struct C31Dispatch OBJ_RECORD_HOOK,C31_DEFAULT_DISPATCH;
extern struct C31Bank SCOPE_POOL_SEG,NAME_POOL_SEG,HASH_CHAIN_LINK_SEG,EXPR_POOL_SEG,STRING_POOL_SEG,POOL_HASH,SRCFILE_POOL_SEG;
extern struct C31Bank near C31_BANKS[];
extern struct C31KeywordGroup near C31_KEYWORD_GROUPS[];
extern signed char C31_MEMORY_OPTION,LANGUAGE_MODE;
extern unsigned char OPTION_FLAGS,OPTION_WINDOWS_MODE,PRAGMA_CODESEG_SEEN;
extern unsigned int INIT_OPTION,SESSION_PHASE,CODE_SEGMENT_ID,DEFAULT_CODE_SEGMENT_ID,DATA_SEGMENT_ID,BSS_SEGMENT_ID;
extern unsigned int CODE_SEGMENT_NAME,CODE_GROUP_NAME,CODE_CLASS_NAME,DATA_SEGMENT_NAME,DATA_GROUP_NAME,DATA_CLASS_NAME;
extern unsigned int BSS_SEGMENT_SEPARATE,BSS_SEGMENT_NAME,BSS_GROUP_NAME,BSS_CLASS_NAME,SOURCE_FILE_LIST,OBJ_EXTERN_INDEX;
extern unsigned int CURRENT_FILE_NAME,CURRENT_BANK_INDEX,DIAGNOSTIC_COUNT,ERROR_COUNT;
extern char far *FUNCTION_NAME_TEXT;
extern long HEAP_RESERVE_BYTES,MIN_FREE_HEAP;
extern char near BCC_DEBUG_NAME[],TOKEN_TEXT_BUFFER[];
extern unsigned int near NAME_HASH_TABLE[],TOKEN_NAMES[];
extern void (far pascal *EMIT_DEPENDENCY_HOOK)(char far *);
extern unsigned int far pascal RESTORE_MALLOC_POOL_MARK(void);
extern void far pascal SHUT_DOWN_BACKEND(unsigned int);
extern void far pascal PARSE_EXTERNAL_DECLARATIONS(void);
extern void far pascal DEFINE_COMMAND_LINE_MACROS(void);
extern void far pascal INIT_PCH_STATE(void);
extern unsigned int far pascal POOL_ALLOC(unsigned int far *,unsigned int);
extern unsigned int far pascal OPEN_SOURCE_FILE(char far *);
extern void far pascal RECORD_SOURCE_NAME(void);
extern void far pascal RESET_WARNINGS_TO_DEFAULT(void);
extern void far pascal INIT_SEGMENT_NAMES(char far *);
extern void far pascal INIT_BACKEND(char far *);
extern unsigned int far pascal DEFINE_SEGMENT(unsigned char,unsigned int,unsigned int,unsigned int);
extern unsigned int far pascal POOL_INIT(unsigned int far *,unsigned int);
extern void far pascal INIT_LEXER_STATE(void);
extern void far pascal INIT_LEXER_POOLS(void);
extern void far pascal CLEAR_BACKEND_STATE(void);
extern unsigned int far pascal BCC_SYMBOL_CREATE(char far *,unsigned int);
void far pascal BEGIN_SESSION(char far *);
void far pascal END_SESSION(unsigned int);
static void near pascal OPEN_SESSION_SOURCE(char far *);
void far pascal BEGIN_BACKEND_PHASE(void);
static void near pascal INIT_POOLS_AND_KEYWORDS(void);
#endif
