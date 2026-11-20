#ifndef TOKADV_H
#define TOKADV_H
#include "DATA.H"
#include "OVL.H"
/* Actual nineteen-byte token storage; only its first WORD is inspected here. */
struct C44Token { unsigned int kind; unsigned char rest[17]; };
extern struct C44Token CURRENT_TOKEN_RECORD,TOKEN_TYPE;
extern unsigned int TOKEN_RECORD_STREAM;
extern void far pascal STREAM_GET_TOKEN(unsigned int,struct C44Token far *);
extern void far pascal STREAM_PUT_TOKEN(unsigned int,struct C44Token far *);
#endif
