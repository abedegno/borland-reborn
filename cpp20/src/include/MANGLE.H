#ifndef MANGLE_H
#define MANGLE_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
/* A counted buffer: a length word and 514 bytes of text; appends stop at 511. */
struct C14Buffer { unsigned int length; char text[514]; };
union C14NameRef {
    char far *raw;
    struct { unsigned int offset; unsigned int near *segment; } parts;
};
/* Actual inclusive slot36 aliases the real search variable atBP-4. */
union C14Arguments {
    struct { unsigned int seen[36]; int search; } fields;
    unsigned int slots[37];
};
extern unsigned int NAME_POOL_SEG;
extern struct C14Buffer C14_NAME_BUFFER;
extern char far * near C14_TYPE_ENCODINGS[];
extern char far *C14_ARGUMENT_CODES;
static void near pascal C14ARGUMENTS(unsigned int,unsigned char,unsigned char,
    struct C14Buffer far *);
void far pascal APPEND_DECIMAL(unsigned long,struct C14Buffer far *);
void far pascal MANGLE_PLAIN_NAME(unsigned int,unsigned int,struct C14Buffer far *);
void far pascal MANGLE_FUNCTION_PREFIX(unsigned int,unsigned int,struct C14Buffer far *);

#endif
