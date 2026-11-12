#ifndef DIAG_H
#define DIAG_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
struct C25Buffer { unsigned int count; char text[511]; };
struct C25Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned int name;
    unsigned char payload[8];
};
struct C25Name {
    unsigned int next,offset;
    unsigned int near *segment;
};
extern struct C25Buffer DIAG_NAME_BUFFER;
extern unsigned int BCC_TREE_SPECIAL; extern unsigned int NAME_POOL_SEG;
extern char far *FUNCTION_NAME_TEXT;
extern struct C25Token CURRENT_TOKEN_RECORD;
static void near pascal APPEND_NAME_BYTE(unsigned char,struct C25Buffer far *);
static void near pascal APPEND_NAME_TEXT(char far *,struct C25Buffer far *);
void far pascal REPORT_TOKEN_DIAGNOSTIC(struct C25Token far *,int);
#endif
