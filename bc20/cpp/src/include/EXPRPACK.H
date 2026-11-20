#ifndef EXPRPACK_H
#define EXPRPACK_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
struct C42Location { unsigned int words[3]; };
struct C42StoredHeader {
    unsigned char kind,flags;
    unsigned int type;
    struct C42Location location;
};
struct C42PoolState { unsigned int segment,capacity,used,word6; };
extern unsigned int EXPR_POOL_SEG;
#endif
