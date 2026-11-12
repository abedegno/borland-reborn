/* target: ovr118_TINT */
/* opts: -mm -G- -O -Z -p */
/* Role: parser: tests whether a token starts a type (a type keyword or an identifier naming
   a type). Map of all sources: docs/SOURCE-MAP.md. */

/* Overview: the parser's "does a type start here" test, used wherever C
   or C++ syntax is ambiguous between a declaration and an expression
   (statement starts, casts, sizeof, parameter lists).  It works on a token
   record (CURRENT_TOKEN_RECORD or the lookahead TOKEN_TYPE record) rather
   than just the token code, because for an identifier it needs the name
   word at offset 9 of the record to ask TYPE_LOOKUP whether that name is a
   typedef or class name.  TYPE_FLAGS is the per-token flag table; bit 0x08
   marks the type keywords.  CPP_MODE is the
   C++ mode flag (INIT_PARSER sets it from OPTION_FLAGS bit 0).  The
   exported entry is TOKEN_IS_TYPE_START; this file holds its body. */

#include "DATA.H"
extern int far pascal TYPE_LOOKUP(unsigned int name);

/* Nonzero if the token record starts a type name: an identifier (TOK_IDENT,
   49) whose name TYPE_LOOKUP finds as a type, a token whose TYPE_FLAGS entry
   has bit 0x08 (the type keywords), or, when CPP_MODE is set, '~'
   (TOK_TILDE, 43: a destructor name in C++).  The fallback test is a bitwise
   & of the flag byte and the result of the comparison, as in the original
   (mov ah,0; push ax ... test ax,dx). */
static int far pascal TOKEN_IS_TYPE_START_BODY(unsigned int far *node)
{
    if (node[0] == 49)
        return TYPE_LOOKUP(*(unsigned int far *)((char far *)node + 9)) != 0;
    return (TYPE_FLAGS[node[0]] & 8) || (CPP_MODE & (node[0] == 43));
}
