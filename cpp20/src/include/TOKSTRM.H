#ifndef TOKSTRM_H
#define TOKSTRM_H
#include "RTL.H"
#include "DATA.H"
#include "OVL.H"
struct C28Stream {
    unsigned int line,file,block;
    int index,cursor;
    unsigned int first;
};
struct C28Block { unsigned char data[510]; unsigned int next; };
union C28Value { unsigned int name; long number; unsigned char real[10]; };
struct C28Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    union C28Value value;
};
extern unsigned int TOKEN_RECORD_STREAM; extern unsigned int CURRENT_TOKEN_VALUE; extern unsigned int SRCFILE_POOL_SEG;
extern unsigned int near REPLAY_STREAM_1[4];
extern struct C28Token CURRENT_TOKEN_RECORD,TOKEN_TYPE;
static void far pascal STREAM_PUT_BYTE(unsigned char,unsigned int);
static void far pascal STREAM_PUT_INT(int,unsigned int);
static void far pascal STREAM_PUT_LONG(long,unsigned int);
static void far pascal STREAM_PUT_REAL(struct C28Token far *,unsigned int);
static void far pascal STREAM_ENCODE_TOKEN(struct C28Token far *,unsigned int);
static unsigned char far pascal STREAM_GET_BYTE(unsigned int);
static int far pascal STREAM_GET_INT(unsigned int);
static long far pascal STREAM_GET_LONG(unsigned int);
static void far pascal STREAM_GET_REAL(unsigned char far *,unsigned int);
static void far pascal STREAM_DECODE_TOKEN(struct C28Token far *,unsigned int);
void far pascal STREAM_PUT_TOKEN(unsigned int,struct C28Token far *);
void far pascal STREAM_GET_TOKEN(unsigned int,struct C28Token far *);
#endif
