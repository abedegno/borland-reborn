#ifndef DECLSPEC_H
#define DECLSPEC_H
#include "RTL.H"
#include "DATA.H"

extern unsigned int EXPR_POOL_SEG;
extern unsigned int SCOPE_POOL_SEG; extern unsigned int NAME_POOL_SEG;
extern unsigned int CURRENT_TOKEN_VALUE; extern unsigned int TOKEN_TYPE;
extern unsigned int ERROR_COUNT; extern unsigned int BCC_TREE_SPECIAL;
extern unsigned int CURRENT_TOKEN_RECORD;
extern unsigned char MODEL_FAR_CODE;
extern unsigned char DEFAULT_CALL_CONVENTION; extern unsigned char OPTION_MEMORY_MODEL;
extern unsigned int near C9_TYPE_GRID[2][2][13];
extern unsigned int far *BCC_TYPE_PTR;

/* The genuine three-byte declaration record. Native CBW establishes the
   signed component views; by-value arguments occupy four stack bytes. */
struct C16Spec { signed char first,second,third; };
extern struct C16Spec EXPR_TEMP2;
/* Saved parser context, copied as 44 bytes from STRUCT_BODY_TYPE. */
struct C16Context { unsigned char bytes[44]; };
/* Real19-byte token image; name is the unaligned WORD at+9. */
struct C16Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned int name;
    unsigned char payload[8];
};
/* Genuine eight-byte type-word record passed by value to private helper. */
struct C16TypeWords {
    unsigned int primary,sign,size;
    unsigned char constant,changing;
};
/* Distinct real declarator kinds share their target field offset. */
struct C16Array { unsigned char prefix[7]; unsigned int element; };
struct C16Function { unsigned char prefix[7]; unsigned int result; };

extern unsigned int far pascal ALLOC_FORMAL_RECORD(void);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
extern void far pascal SKIP_TO_SYNC_TOKEN(unsigned int);
extern unsigned int far pascal TYPE_LOOKUP_FAR(unsigned int);
extern unsigned int far pascal ALLOC_SCOPE(void);
extern void far pascal PEEK_TOKEN(void);
extern unsigned int far pascal MAKE_POINTER_TYPE(unsigned int,unsigned int,unsigned char);
extern long far pascal CLASS_NAME_OF_TYPE(unsigned int);
extern unsigned int far pascal PARSE_ASSIGNMENT_EXPR(unsigned int);
extern unsigned int far pascal COPY_EXPR_TREE(unsigned int);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal NULL_CONSTANT_TO_POINTER(unsigned int,unsigned int);
extern unsigned char far pascal CANNOT_CONVERT_TYPES(unsigned int,unsigned int);
extern long far pascal FORMAT_TYPE(unsigned int);
extern unsigned int far pascal REPORT_EXPR_ERROR(unsigned int,long,long,unsigned int);
extern void far pascal FREE_EXPR_TREE(unsigned int);
extern unsigned int far pascal PACK_EXPR_TREE(unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
extern unsigned char far pascal TOKEN_IS_TYPE_START(struct C16Token far *);
extern unsigned int far pascal FIND_EQUIVALENT_TYPE(unsigned int);
extern unsigned int far pascal CREATE_TYPE(unsigned int);
extern unsigned int far pascal FLUSH_PENDING_POOL(void);
extern void far pascal PARSE_CONSTANT_EXPR_VALUE(unsigned int,long far *);
extern unsigned int far pascal COPY_TYPE_RECORD(unsigned int);
extern void far pascal ADD_THIS_PARAMETER(unsigned int,unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
/* BCC's type-path functions (reached in BCC.EXE through overlay stubs); CPP.EXE does
   not have them. */
extern unsigned int far pascal TYPE_PATH_FAR(unsigned int,unsigned int,
    unsigned int far *,struct C16Spec far *,struct C16Spec far *);
extern unsigned int far pascal TYPE_OPERATOR_FAR(unsigned int,unsigned int,
    unsigned int far *,unsigned int far *);
extern unsigned char far pascal PARSE_STATE_CHECK(void);
extern unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int,unsigned int);
extern void far pascal C0MARK(unsigned char);
extern unsigned int far pascal FIND_NAME_IN_LIST(unsigned int,unsigned int);
extern unsigned int far pascal BCC_TYPE_PRIMARY(unsigned int);
extern unsigned int far pascal DECLARE_TAG(unsigned int);
extern void far pascal TYPE_BASE_FAR(void);
extern void far pascal SKIP_BRACE_GROUP(void);
extern void far pascal TYPE_CLOSE(void);
extern void far pascal DECLARE_IMPLICIT_MEMBERS(void);
extern unsigned int far pascal ENUM_BUILD(void far *,unsigned char);
extern void far pascal REPORT_TOKEN_DIAGNOSTIC(struct C16Token far *,unsigned int);
extern unsigned int far pascal INTERN_QUALIFIED_TYPE(unsigned int,unsigned int);
extern unsigned int far pascal LOOKUP_NAME(unsigned int);

/* Entire original-order unit, including real private and struct-return entries. */
static unsigned int near pascal PARSE_OLD_STYLE_PARAMS(void);
static unsigned char near pascal IS_VOID_PARAM_LIST(void);
static void near pascal PARSE_PARAM_LIST(unsigned int far *head,unsigned char far *variadic);
unsigned int far pascal PARSE_POINTER_DECLARATOR(register unsigned int type,struct C16Spec spec);
static unsigned int near pascal PARSE_ARRAY_DECLARATOR(unsigned char runtime,
    register unsigned int type,struct C16Spec spec);
unsigned int far pascal PARSE_FUNCTION_DECLARATOR(register unsigned int type,struct C16Spec spec);
static unsigned int near pascal ATTACH_DECLARATOR_BASE(register unsigned int declarator,
    register unsigned int base);
struct C16Spec far pascal PARSE_TYPE_MODIFIERS(struct C16Spec value);
void far pascal PARSE_DECLARATOR(unsigned int initial,register unsigned int mode,
    unsigned int far *type,unsigned int far *name,unsigned int far *scope,
    unsigned int far *owner,struct C16Spec far *spec,struct C16Spec far *scratch);
unsigned int far pascal NEW_RECORD_TYPE(unsigned int token,register unsigned int access);
static unsigned int near pascal DECLARE_TAG_SYMBOL(unsigned int type,unsigned int name);
static unsigned int near pascal LOOKUP_OR_DECLARE_TAG(unsigned int token,unsigned int access,
    unsigned char definition,unsigned char far *valid);
static unsigned int near pascal PARSE_RECORD_SPECIFIER(unsigned int token,unsigned char allow_forward);
static unsigned int near pascal PARSE_ENUM_SPECIFIER(void);
unsigned int far pascal ADD_CV_QUALIFIERS(register unsigned int type,unsigned char second,
    unsigned char first);
unsigned int far pascal STRIP_CV_QUALIFIERS(register unsigned int type);
static unsigned char near pascal ACCEPT_TYPE_WORD(unsigned int context,
    struct C16TypeWords far *words,unsigned int far *type);
static unsigned int near pascal BUILD_BASIC_TYPE(struct C16TypeWords words,
    unsigned char named,unsigned int type);
static unsigned char near pascal MORE_TYPE_WORDS(register unsigned int primary);
void far pascal PARSE_DECL_SPECIFIERS(unsigned int context,unsigned int far *kind,
    unsigned char far *modifier1,unsigned char far *modifier2,unsigned int far *type,
    struct C16Spec far *spec,unsigned char far *named);

#endif
