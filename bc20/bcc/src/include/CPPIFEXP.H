#ifndef CPPIFEXP_H
#define CPPIFEXP_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
/* Same actual19B token layout as the independently matched C16 token. */
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
