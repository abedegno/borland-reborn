/* target: PARSEUTL */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module PARSEUTL (image 0xFFB9..0x10123, frame 0FFBh): one source file, taken
   from the BCC.EXE reconstruction (bcc20/src/). BCC.EXE has this code as
   six files in its overlay 118 (parser/TASSERT.C, parser/TYPSTART.C,
   parser/TCHECK.C, parser/TCALL.C, lexer/STRLIT.C, expr/CONSTVAL.C, in this order); they
   are joined here because CPP.EXE's relocation table lists the six functions' relocations
   as one descending run, last function first, which is what one compiled object gives
   (TLINK keeps module order: two objects give each its own run, in link order (tested)). None of the six calls another, so their code does not tell. The parts
   follow, each with its BCC file's comments; the file name is descriptive. */

/* ==== from parser/TASSERT.C ==== */
/* TASSERT part (TREE_ASSERT, CPP 0FFB:0009): taken unchanged from BCC's
   parser/TASSERT.C; its code is the same in both programs. */
/* Role: parser: accepts a comma separator, or the given closing token, else reports ",
   expected". */

/* Overview: one small helper used by the list parsers (argument lists,
   declarator lists, initializer lists) to step over the separator between
   items.  It looks only at CURRENT_TOKEN: a comma is consumed; the closing
   token the caller names (for example ')') is left for the caller to
   consume; anything else gets the error MSG_EXPECTED_202 (", expected").
   The function is static but far: in BCC.EXE other modules called it
   through an overlay stub. In CPP.EXE, which has no overlays, nothing
   outside this file can reach it. */

#include "DATA.H"
#include "MSG.H"
#include "TOKEN.H"
extern void far ADVANCE_TOKEN(void);
extern void far REPORT_CURRENT_TOKEN(int error);

/* The parameter context is the token that closes the list.  Consumes a ',' if present;
   otherwise, unless the closing token is current, reports ", expected"
   against the current token.  The closing token itself is not consumed. */
static void far pascal TREE_ASSERT(unsigned int context)
{
    if (CURRENT_TOKEN == TOK_COMMA)
        ADVANCE_TOKEN();
    else if (CURRENT_TOKEN != context)
        REPORT_CURRENT_TOKEN(MSG_EXPECTED_202);
}


/* ==== from parser/TYPSTART.C ==== */
/* TYPSTART part (TOKEN_IS_TYPE_START, CPP 0FFB:002F): taken from BCC's
   parser/TYPSTART.C; CPP.EXE edits (marked below): the identifier case (no TYPE_LOOKUP)
   and the char return type. */
/* Role: parser: tests whether a token starts a type (in CPP.EXE: a type keyword). */

/* Overview: the "does a type start here" test; in CPP.EXE the #if
   expression parser uses it for casts and sizeof.  It works on a token
   record (CURRENT_TOKEN_RECORD or the lookahead TOKEN_TYPE record) rather
   than just the token code, because in BCC, for an identifier, it needed
   the name word at offset 9 of the record to ask TYPE_LOOKUP whether that
   name is a typedef or class name.  TYPE_FLAGS is the per-token flag table; bit 0x08
   marks the type keywords.  CPP_MODE is the
   C++ mode flag (INIT_PARSER sets it from OPTION_FLAGS bit 0).  The
   exported entry is TOKEN_IS_TYPE_START; this file holds its body. */

#include "DATA.H"
extern int far pascal TYPE_LOOKUP(unsigned int name);

/* Nonzero if the token record starts a type name: a token whose TYPE_FLAGS
   entry has bit 0x08 (the type keywords), or, when CPP_MODE is set, '~'
   (TOK_TILDE, 43: a destructor name in C++); never an identifier (TOK_IDENT,
   49) in CPP.EXE.  The fallback test is a bitwise & of the flag byte and the
   result of the comparison, as in the binary (mov ah,0; push ax ... test
   ax,dx). */
/* CPP.EXE edit: returns char, not int: the early return is `mov al,0` (image 0xFFEB)
   and CPP's callers test `or al,al` after the calls (e.g. the calls at image 0x65CF, 0x757F). */
/* link: TOKEN_IS_TYPE_START is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
char far pascal TOKEN_IS_TYPE_START(unsigned int far *node)
{
    /* CPP.EXE edit: an identifier never starts a type, since the preprocessor has no
       type names (TYPE_LOOKUP, types/TLOOK.C, is not in CPP.EXE); CPP's code at image
       0xFFE4 returns 0 here at once. */
    if (node[0] == 49)
        return 0;
    return (TYPE_FLAGS[node[0]] & 8) || (CPP_MODE & (node[0] == 43));
}


/* ==== from parser/TCHECK.C ==== */
/* TCHECK part (REQUIRE_TOKEN_ELSE_ERROR, CPP 0FFB:0075): taken unchanged from BCC's
   parser/TCHECK.C; its code is the same in both programs. */
/* Role: parser: requires the current token to be the expected one and advances, otherwise
   reports the given error. */

/* Overview: the plain "expect this token" helper of the parser.  If
   CURRENT_TOKEN is the expected token it is consumed with ADVANCE_TOKEN,
   otherwise the given message is reported against the current token
   (REPORT_CURRENT_TOKEN quotes its spelling).  Unlike TREE_INVOKE
   (below) it does not set IN_ERROR_RECOVERY. */

#include "DATA.H"
extern void far ADVANCE_TOKEN(void);
extern void far REPORT_CURRENT_TOKEN(int error);

/* Parameters: context is the expected token; error is the message number
   to report if the current token is something else.  The token is not
   skipped on error. */
/* link: REQUIRE_TOKEN_ELSE_ERROR is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void far pascal REQUIRE_TOKEN_ELSE_ERROR(unsigned int context, int error)
{
    if (CURRENT_TOKEN == context)
        ADVANCE_TOKEN();
    else
        REPORT_CURRENT_TOKEN(error);
}


/* ==== from parser/TCALL.C ==== */
/* TCALL part (TREE_INVOKE, CPP 0FFB:0093): taken unchanged from BCC's parser/TCALL.C;
   its code is the same in both programs. */
/* Role: parser: requires the expected token and advances, otherwise reports a
   three-argument diagnostic and sets an error flag. */

/* Overview: "expect this token" helper whose failure message takes a
   payload.  If CURRENT_TOKEN is the expected token it is consumed;
   otherwise a diagnostic is reported at the current token and IN_ERROR_RECOVERY
   is set.  IN_ERROR_RECOVERY is the parser's "already in error recovery" flag:
   while it is set REPORT_DIAGNOSTIC_AT (DIAG.C) prints only fatal
   messages, so one syntax error does not cascade into many.  In BCC.EXE
   other modules called it through an overlay stub; in CPP.EXE nothing
   outside this file can reach the static. */

#include "DATA.H"
extern void far ADVANCE_TOKEN(void);
extern void far REPORT_DIAGNOSTIC(unsigned int first, unsigned int second,
                         unsigned int third, long value);

/* Parameters: context is the expected token, first the message number;
   second and third are probably the high and low words of the message's
   first long argument (they are pushed in that order ahead of a 0L second
   argument), so together they form a far pointer such as a name string. */
static void far pascal TREE_INVOKE(unsigned int context, unsigned int first,
                                   unsigned int second, unsigned int third)
{
    if (CURRENT_TOKEN == context) {
        ADVANCE_TOKEN();
    } else {
        REPORT_DIAGNOSTIC(first, second, third, 0L);
        IN_ERROR_RECOVERY = 1;
    }
}


/* ==== from lexer/STRLIT.C ==== */
/* STRLIT part (COLLECT_STRING_LITERAL, CPP 0FFB:00C2): taken from BCC's
   lexer/STRLIT.C; CPP.EXE edit (marked below): COLLECT_STRING_LITERAL only counts
   characters. */
/* Role: lexer: steps over adjacent string-literal tokens and counts their characters
   (BCC: also stored them in the data pool). */

/* Overview: called by the expression parser when it meets a string
   literal.  Adjacent literals ("ab" "cd") are one string in C, so this
   consumes every string-literal token in a row (token code 52, 0x34; the
   first word of CURRENT_TOKEN_RECORD is the token code) and counts their
   characters, read with NEXT_LITERAL_CHAR (TOKADV.C).  BCC's version also
   copied them into its code generator's data byte pool, merging duplicate
   strings under -d; CPP.EXE has no code generator. */
#include "DATA.H"
extern int far MERGE_DUPLICATE_BYTES(int value);
extern int far BYTE_POOL_LENGTH(void);
extern void far EMIT_VALUE(char value);
extern void far ADVANCE_TOKEN(void);
extern int far NEXT_LITERAL_CHAR(int index);
extern unsigned int CURRENT_TOKEN_RECORD;

/* count_result receives the length in bytes including the closing 0. value
   (in BCC the string's offset in the data byte pool) is not set. */
/* link: COLLECT_STRING_LITERAL is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void far pascal COLLECT_STRING_LITERAL(unsigned int far *value,
                                 unsigned int far *count_result)
{
    int token;
    register unsigned int count;
    register unsigned int index;

    /* CPP.EXE edit: only counts the characters; nothing is stored in a data pool and
       value is not set (CPP's code at image 0x10072 has no BYTE_POOL_LENGTH,
       EMIT_VALUE or MERGE_DUPLICATE_BYTES calls). */
    count = 0;
    while (CURRENT_TOKEN_RECORD == 52) {
        index = 0;
        while ((token = NEXT_LITERAL_CHAR(index++)) != -1)
            count++;
        ADVANCE_TOKEN();
    }
    *count_result = count + 1;
}


/* ==== from expr/CONSTVAL.C ==== */
/* CONSTVAL part (PARSE_CONSTANT_EXPR_VALUE, CPP 0FFB:0100): taken unchanged from BCC's
   expr/CONSTVAL.C; its code is the same in both programs. */
/* Role: expressions: parses a constant expression and returns its long value, else reports
   "Constant expression required". */
/* Overview: evaluates an integer constant expression (in BCC for the places the
   grammar needs a number: array bounds, enumerator values, bitfield widths, case
   labels). PARSE_CONSTANT_EXPR_VALUE parses one assignment-expression, analyses it
   with "int" as the expected type (INT_TYPE is BCC_TYPE_PTR[5], the int type),
   simplifies it so constants fold, and stores the long result. If the
   tree is not a constant it reports MSG_CONSTANT_EXPRESSION; an operator-0 node
   (probably an expression that already failed with an error) quietly gives 1 so one
   mistake does not cause a second message. The tree is freed in every case.
   (In BCC the function was static, reached from the other code of its overlay.) */

#include <dos.h>
#include "DATA.H"
#include "MSG.H"
#include "FIELDS.H"

extern int far PARSE_ASSIGNMENT_EXPR(unsigned int type);
extern unsigned int far pascal ANALYZE_AND_DECAY(unsigned int,unsigned int);
extern unsigned int far pascal SIMPLIFY_EXPRESSION(unsigned int,unsigned char);
extern char far IS_CONSTANT_EXPR(unsigned int node);
extern void far REPORT_CURRENT_TOKEN(int error);
extern void far FREE_EXPR_TREE(unsigned int node);
extern unsigned int EXPR_POOL_SEG;

/* PARSE_CONSTANT_EXPR_VALUE: "type" is passed straight to PARSE_ASSIGNMENT_EXPR; *result
   receives the value (left unchanged after an error). A constant node keeps its long
   value at EXPR_VALUE, the same offset as EXPR_LEFT used here. */
/* link: PARSE_CONSTANT_EXPR_VALUE is not static here: other files call it (CPP.EXE has no overlay stubs to reach a static). */
void far pascal PARSE_CONSTANT_EXPR_VALUE(unsigned int type, long far *result)
{
    register unsigned int node;

    node = PARSE_ASSIGNMENT_EXPR(type);
    node = SIMPLIFY_EXPRESSION(ANALYZE_AND_DECAY(node,INT_TYPE),0);
    if (*(unsigned int far *)MK_FP(EXPR_POOL_SEG, node) == 0) {
        *result = 1L;
    } else if (IS_CONSTANT_EXPR(node)) {
        *result = *(long far *)MK_FP(EXPR_POOL_SEG, node + EXPR_LEFT);
    } else {
        REPORT_CURRENT_TOKEN(MSG_CONSTANT_EXPRESSION);
    }
    FREE_EXPR_TREE(node);
}
