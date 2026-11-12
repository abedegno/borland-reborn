#ifndef LOOKAHD_H
#define LOOKAHD_H
#include "DATA.H"
#include "OVL.H"
struct C30Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned int name;
    unsigned char payload[8];
};
extern struct C30Token CURRENT_TOKEN_RECORD,TOKEN_TYPE;
extern unsigned char far pascal TOKEN_IS_TYPE_START(struct C30Token far *);
#endif
