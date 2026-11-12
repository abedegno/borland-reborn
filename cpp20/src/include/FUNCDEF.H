#ifndef FUNCDEF_H
#define FUNCDEF_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
struct C27Spec { signed char first,second,third; };
struct C27Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned int name;
    unsigned char payload[8];
};
/* One observed80-byte context: first root WORD and actual remaining storage. */
struct C27Context { unsigned int root; unsigned char bytes[78]; };
extern struct C27Token CURRENT_TOKEN_RECORD,TOKEN_TYPE;
extern struct C27Context BCC_TREE_SPECIAL;
extern unsigned int SCOPE_POOL_SEG;
extern unsigned int DIAG_NAME_BUFFER; extern unsigned int CODE_SEGMENT_ID;
extern unsigned int FUNCTION_BODY_DEPTH;
extern unsigned int RETURN_FORM_SEEN;
extern unsigned int LOOP_CONTEXT;
extern long FUNCTION_DEF_POSITION;
extern unsigned char PRAGMA_SAVEREGS_PENDING; extern unsigned char PRAGMA_ARGSUSED_PENDING;
extern signed char OPTION_WINDOWS_MODE;
extern char far *FUNCTION_NAME_TEXT;
extern unsigned int (far pascal *GET_SYMBOL_SEGMENT_HOOK)(unsigned int);
extern void (far pascal *SET_SYMBOL_SEGMENT_HOOK)(unsigned int,unsigned int);
extern unsigned char far pascal TOKEN_IS_TYPE_START(struct C27Token far *);
extern void far pascal PARSE_DECL_SPECIFIERS(unsigned int,unsigned int far *,unsigned char far *,
    unsigned char far *,unsigned int far *,struct C27Spec far *,unsigned char far *);
extern void far pascal PARSE_DECLARATOR(unsigned int,unsigned int,unsigned int far *,
    unsigned int far *,unsigned int far *,unsigned int far *,struct C27Spec far *,struct C27Spec far *);
extern void far pascal DECLARE_TYPEDEF(unsigned int,struct C27Spec,unsigned int);
extern void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int,unsigned int);
extern void far pascal BCC_TYPE_NORMALIZE(unsigned int,unsigned int,unsigned int,
    unsigned int far *,unsigned char);
extern void far pascal DECLARE_FUNCTION(unsigned int,unsigned int,unsigned int,unsigned int,
    unsigned int far *,unsigned char far *);
static void near pascal PARSE_KR_PARAMETERS(unsigned int);
void far pascal COMPILE_FUNCTION_DEFINITION(unsigned int,unsigned int,unsigned int,unsigned int,
    unsigned int,unsigned char,unsigned char);
#endif
