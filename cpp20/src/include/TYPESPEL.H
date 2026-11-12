#ifndef TYPESPEL_H
#define TYPESPEL_H
#include "DATA.H"
#include "OVL.H"
/* Shared counted buffer: actual append cap511, no owned storage. */
struct C33Buffer { unsigned int count; char text[511]; };
struct C33Name { unsigned int next,offset; unsigned int near *segment; };
union C33NameRef {
    char far *raw;
    struct { unsigned int offset; unsigned int near *segment; } parts;
};
extern struct C33Buffer DIAG_NAME_BUFFER;
extern unsigned int NAME_POOL_SEG;
extern unsigned int EXPR_POOL_SEG;
extern char near * near C33_TYPE_NAMES[];
extern char far * near C33_POINTER_QUALIFIERS[];
extern void far pascal APPEND_DECIMAL(unsigned long,struct C33Buffer far *);
static void near pascal APPEND_CHAR(unsigned char,struct C33Buffer far *);
static void near pascal APPEND_TEXT(char far *,struct C33Buffer far *);
static void near pascal APPEND_SYMBOL_NAME(unsigned int,struct C33Buffer far *);
static void near pascal APPEND_PARAM_LIST(unsigned int,unsigned char,struct C33Buffer far *);
static void near pascal APPEND_TYPE_SPELLING(unsigned int,struct C33Buffer far *);
static void near pascal APPEND_FUNCTION_NAME(unsigned int,unsigned int,unsigned char far *,struct C33Buffer far *);
#endif
