#ifndef CPPIFEXP_H
#define CPPIFEXP_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
/* The same 19-byte token layout as the C16 token (DECLSPEC.H). */
struct C24Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned int name;
    unsigned char payload[8];
};
extern struct C24Token CURRENT_TOKEN_RECORD,TOKEN_TYPE;
extern unsigned int EXPR_POOL_SEG;
extern long TOKEN_CONST_VALUE;
#endif
