/* target: INITTYPE */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module INITTYPE (image 0x4950..0x4BA8, frame 0495h): source taken from the
   BCC.EXE reconstruction (bcc20/src/driver/INITTYPE.C), cut down the way
   CPP.EXE's code shows. Kept, in BCC's order: INITTYPE, C9BANKS, C9SCALAR, C9TYPES,
   INIT_PARSER, each reduced (see the "CPP.EXE edit" comments). Removed (CPP.EXE has no
   code for them): C9POINTER, C9PARAMETER, C9FUNCTION, C9BUILTIN, C9CLASS, C9NAMED,
   C9MEMBER, C9TOKENS, C9INTRINSICS. The preprocessor needs only the scalar types for #if
   expressions, so the symbol, scope, C++ and code-generator parts are gone. */
/* Role: per-file start of the token reader: the type pool, the scalar types and the
   parser flags. Entry point: INIT_PARSER. */
/* Overview: INIT_PARSER is called once per source file from WRITE_PREPROCESSED_TOKENS
   (lexer/TOKADV.C) before the first token is read. It copies option bytes into parser
   flags, then:
   - C9BANKS / INITTYPE create the type pool (with a dummy type 0, so that offset 0 can
     mean "none") and the tag-body pool.
   - C9TYPES builds the basic types: C9_TYPE_GRID[v][c][kind] holds every scalar kind
     1..12 in four variants (v=0 volatile, c=0 const; [1][1] is the plain type, which
     BCC_TYPE_PTR points at), then names the common ones (INT_TYPE, LONG_TYPE ...),
     starts the output (BEGIN_BACKEND_PHASE), reads the first token and sets
     PTRDIFF_TYPE.
   BCC's version also built the derived types, the built-in symbols, the C++ classes,
   the pseudo-registers and the intrinsics; CPP.EXE has none of these.
   Names to trip over: CPP_MODE is the C++ mode flag (OPTION_FLAGS bit 0);
   NOT_ANSI_FLAG is set when the language mode (LANGUAGE_MODE, set by -A) is not ANSI;
   INT_TYPE is the type int. MODEL_FAR_DATA set means data pointers are far by default.
   Type kinds 13 and 15 are TK_NEAR_PTR and TK_FAR_PTR (KIND.H). */
#include <dos.h>
#include "INITTYPE.H"
#include "POOL.H"

#define BANK(name) (*(struct C9Bank near *)&(name))
#define FIRST(segment) (*(unsigned int far *)MK_FP((segment),0))

/* CPP.EXE edit: BEGIN_BACKEND_PHASE (INITPOOL module, CPP 05D4:00E5) is called directly where
   BCC calls BEGIN_BACKEND_OUTPUT_HOOK. */
extern void far pascal BEGIN_BACKEND_PHASE(void);

/* Creates the parser's basic pools, each with its growth step (BCC: also the symbol,
   cons-cell, member, formal and label pools, most with a dummy record 0). */
/* CPP.EXE edit: only the type pool (with its dummy type 0, but without clearing
   DUPLICATE_TYPE_FREE_LIST) and the tag-body pool are created (CPP 0495:0000..0044). */
static void near pascal INITTYPE(void)
{
    BANK(TYPE_POOL).used=BANK(TYPE_POOL).spare=0;
    BANK(TYPE_POOL).limit=0;
    POOL_INIT((unsigned int far *)&BANK(TYPE_POOL),0);
    CREATE_TYPE(0);

    BANK(TAG_BODY_POOL_SEG).used=BANK(TAG_BODY_POOL_SEG).spare=2;
    BANK(TAG_BODY_POOL_SEG).limit=0;
    POOL_INIT((unsigned int far *)&BANK(TAG_BODY_POOL_SEG),2);
}


/* BCC: creates the pools (INITTYPE), the global scope with its name list (GLOBAL_SCOPE_NAMES) and
   tag list (GLOBAL_SCOPE_TAGS), the C++-only pools (temporaries, base paths, destructor
   entries, cache, initializer records, base-class list with its record 0 = a public
   non-virtual base), and resets parser state counters. */
/* CPP.EXE edit: only the call of INITTYPE is left (CPP 0495:0045..004C). */
static void near pascal C9BANKS(void)
{
    INITTYPE();
}

/* Creates the scalar type of kind with its debugger type id. second==0 makes it const
   (TYPE_ATTRS |= 1), first==0 volatile (TYPE_ATTRS |= 2). */
static unsigned int near pascal C9SCALAR(register unsigned int kind,
    unsigned int first,unsigned int second)
{
    register unsigned int type;

    type=CREATE_TYPE(kind);
    SET_TYPE_DEBUG_ID(type,(unsigned int)C9_TYPE_SIZES[kind]);
    if(!second)
        TYPE_B(type,TYPE_ATTRS)|=1;
    if(!first)
        TYPE_B(type,TYPE_ATTRS)|=2;
    return type;
}

/* Builds the basic types (see the overview). BCC's version went on to the derived types
   and built-in symbols, and in the middle loaded the precompiled header (TRY_PCH_LOAD),
   read the first token and called BEGIN_BACKEND_OUTPUT_HOOK. */
/* CPP.EXE edit: ends after the scalar types and PTRDIFF_TYPE (CPP 0495:0090..019B). No
   precompiled header; BEGIN_BACKEND_PHASE (CPP 05D4:00E5) is called directly and before
   LEX_NEXT_TOKEN (CPP 0DE2:0108), where BCC reads the token first and then calls the hook.
   The derived types, built-in symbols, pseudo-registers and intrinsics are gone. */
static void near pascal C9TYPES(void)
{
    int kind;
    register int first;
    register int second;

    INT_TYPE_SIZE=2;
    BCC_TYPE_PTR=C9_TYPE_GRID[1][1];
    first=0;
    while(first<=1) {
        second=0;
        while(second<=1) {
            C9_TYPE_GRID[first][second][0]=0;
            kind=1;
            while(kind<=12) {
                C9_TYPE_GRID[first][second][kind]=C9SCALAR(kind,first,second);
                ++kind;
            }
            ++second;
        }
        ++first;
    }
    PLAIN_CHAR_KIND=UNSIGNED_CHAR?2:1;
    PLAIN_CHAR_TYPE=CHAR_TYPE=BCC_TYPE_PTR[PLAIN_CHAR_KIND];
    INT_TYPE=BCC_TYPE_PTR[5];
    INT_TYPE_SIZE=TYPE_SIZE(INT_TYPE);
    LONG_TYPE=BCC_TYPE_PTR[7];
    SHORT_TYPE=BCC_TYPE_PTR[3];
    DOUBLE_TYPE=BCC_TYPE_PTR[10];
    DOUBLE_TYPE_SIZE=TYPE_SIZE(DOUBLE_TYPE);
    VOID_TYPE=BCC_TYPE_PTR[12];
    SIZE_T_TYPE=UNSIGNED_INT_TYPE;
    BEGIN_BACKEND_PHASE();
    LEX_NEXT_TOKEN();
    PTRDIFF_TYPE=MODEL_FAR_DATA?LONG_TYPE:INT_TYPE;
}

/* The file's only exported entry; see the overview. Ends by reading the first token
   (ADVANCE_TOKEN), so the parser can start. */
/* CPP.EXE edit: no token-stream pool, no C++ replay streams and none of the parser,
   inline and debug-info counters between C9BANKS and RESET_EXPR_PARSER
   (CPP 0495:019C..0257). */
void far pascal INIT_PARSER(void)
{
    PARSER_INIT_MARK_A5=0xA5;
    CPP_MODE=OPTION_FLAGS&1;
    NOT_ANSI_FLAG=LANGUAGE_MODE!=1;
    PARSER_RESET_BYTE_A=0;
    CPU_LEVEL_1_FLAG=VTABLE_MODE==1;
    CPU_IS_286=VTABLE_MODE==2;
    EXPAND_INLINES_FLAG=OPTION_EXPAND_INLINES;
    INLINE_OPTION_BLOCK_FLAG=OPTION_BLOCK;
    PARSER_RESET_BYTE_B=0;
    ENUMS_AS_INT_FLAG=OPTION_ENUMS_AS_INT;
    IN_ERROR_RECOVERY=0;
    SUPPRESS_WARNINGS_DEPTH=0;
    CONDITIONAL_ARM_DEPTH=0;
    EXPR_START_FLAG_MASK=0x40;
    TOKEN_MASK=0x18;
    if(CPP_MODE) {
        EXPR_START_FLAG_MASK|=4;
        TOKEN_MASK|=0x20;
    }
    C9BANKS();
    RESET_EXPR_PARSER();
    DIAG_NAME_BUFFER=0;
    CURRENT_TOKEN=0x82;
    END_OF_INPUT_SEEN=0;
    C9TYPES();
    NO_ERRORS_YET=1;
    ENUM_BODY_TREE_FLAG=0;
    ADVANCE_TOKEN();
}
