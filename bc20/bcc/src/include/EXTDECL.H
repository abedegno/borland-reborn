#ifndef EXTDECL_H
#define EXTDECL_H
#include "RTL.H"
#include "DATA.H"
extern unsigned int SCOPE_POOL_SEG; extern unsigned int NAME_POOL_SEG;
extern unsigned int far pascal FIND_NAME_IN_LIST(unsigned int,unsigned int);
extern unsigned int far pascal BCC_TYPE_CREATE(unsigned int,unsigned int);
extern void far pascal REPORT_NAME_DIAGNOSTIC(unsigned int,unsigned int);
/* Previously unowned real interfaces; names are neutral source-local proposals. */
extern unsigned int far pascal C0FIND(unsigned int,unsigned int);
extern void far pascal C0MARK(unsigned char);
/* Actual observed program WORD at637C; no pointer/ownership semantics promised. */
extern unsigned char far pascal TYPES_COMPATIBLE(unsigned int,unsigned int,unsigned int);
extern void far pascal REPORT_CURRENT_TOKEN(unsigned int);
/* Existing physical diagnostic caller facet: two opaque32-bit payloads. */
extern long far pascal CLASS_NAME_OF_TYPE(unsigned int);
extern unsigned int far pascal ALLOC_SYMBOL_ENTRY(unsigned int,unsigned int);
extern void far pascal BCC_TYPE_VALIDATE(unsigned int,unsigned int);
extern void far pascal BCC_TYPE_MATCH(unsigned int,unsigned int,unsigned int,
    unsigned int far *,unsigned char far *);
/* Three observed BYTE members.  The original caller transfers four physical
   argument bytes; target compiler rounding, not an explicit padding member. */
typedef struct DeclarationAttributes {
    char storage;
    char calling;
    char qualifier;
} DeclarationAttributes;
extern unsigned char OPTION_CALLING_CONVENTION; extern unsigned char OPTION_WINDOWS_MODE; extern unsigned char OPTION_AUTO_FAR_DATA; extern unsigned char OPTION_MEMORY_MODEL;
extern unsigned int far pascal PREPARE_SYMBOL(unsigned int);
extern void far pascal SET_PREPARED_FLAGS(unsigned int,unsigned int);
extern void far pascal CLEAR_PREPARED_FLAGS(unsigned int,unsigned int);
extern long far pascal FORMAT_TYPE(unsigned int);
extern long far pascal TYPE_SIZE(unsigned int);
extern unsigned int far pascal DEFINE_HUGE_DATA_SEGMENTS(unsigned int);
extern void far pascal EMIT_HUGE_DATA(unsigned int);
extern unsigned int far pascal DEFINE_FAR_SEGMENT(void);
/* Actual existing private C0UNIT body OVL0038:008E, nearRET14. */
extern void near pascal C0SELECT(unsigned int,unsigned int,unsigned int,unsigned int far *,unsigned char far *);
extern void far pascal REGISTER_SYMBOL_VARIABLE(unsigned int);
extern char far * far pascal SYMBOL_NAME_TEXT(unsigned int);
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *STREAM_HOOK)(unsigned int);
extern unsigned int (far pascal *TYPE_ALIGNMENT_HOOK)(unsigned int);
extern void (far pascal *ALIGN_OUTPUT_HOOK)(unsigned int);
extern void (far pascal *DEFINE_SYMBOL_HERE_HOOK)(unsigned int);
extern void (far pascal *RESERVE_BYTES_HOOK)(unsigned int);
extern unsigned char OPTION_AUTO_FAR_DATA;
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);
/* Original still-unnamed interfaces, using their actual native PUBLIC names. */
extern void far pascal PARSE_CONST_INITIALIZER(unsigned int,unsigned int);
extern void far pascal INIT_REFERENCE(unsigned int,unsigned int);
extern void far pascal INIT_CLASS_OBJECT(unsigned int,unsigned int);
extern void far pascal PARSE_SCALAR_INITIALIZER(unsigned int,unsigned int);
extern void far pascal INIT_DECLARATOR(unsigned int,unsigned int);
extern long far pascal FORMAT_SYMBOL(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(unsigned int,char far *,long);
extern DeclarationAttributes EXPR_TEMP2;
extern unsigned int NAME_POOL_SEG;
extern unsigned int TOKEN_TYPE; extern unsigned int CURRENT_TOKEN_RECORD;
extern unsigned long TOKEN_POSITION,FUNCTION_DEF_POSITION;
extern void far pascal PARSE_ASM_STATEMENT(void);
extern void far pascal PEEK_TOKEN(void);
extern void far pascal ADVANCE_TOKEN(void);
extern int far pascal NEXT_LITERAL_CHAR(unsigned int);
extern void far pascal SKIP_TO_SYNC_TOKEN(unsigned int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern unsigned char far pascal TOKEN_IS_TYPE_START(void far *);
extern void far pascal PARSE_DECL_SPECIFIERS(unsigned int,void far *,void far *,void far *,void far *,void far *,void far *);
extern void far pascal PARSE_DECLARATOR(unsigned int,unsigned int,void far *,void far *,void far *,void far *,void far *,void far *);
extern void far pascal COMPILE_FUNCTION_DEFINITION(unsigned int,unsigned int,unsigned int,unsigned int,unsigned int,unsigned char,unsigned char);
extern void far pascal BCC_TYPE_RELATION(unsigned int,unsigned int);
extern unsigned int far pascal DEFINE_STATIC_DATA_MEMBER(unsigned int,unsigned int,unsigned int,unsigned int,unsigned char);
extern unsigned int far pascal MAKE_SYMBOL_NODE(unsigned int);
extern unsigned int far pascal REGISTER_TEMP_DESTRUCTOR(unsigned int,unsigned int,unsigned int);
extern void far pascal C11_EXPECT(unsigned int);
extern unsigned int far pascal POOL_ALLOC_REUSE(unsigned int far *,unsigned int);
extern void far pascal POOL_FREE_ITEM(unsigned int far *,unsigned int);
extern void far pascal INIT_PARSER(void);
extern void far pascal PROCESS_DEFERRED_DECLS(void);
extern void far pascal CHECK_FILE_SYMBOLS(void);
#endif
