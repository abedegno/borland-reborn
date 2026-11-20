#ifndef INLINEBD_H
#define INLINEBD_H
#include "DATA.H"
struct C26Token {
    unsigned int kind;
    unsigned char flags;
    unsigned int location[3];
    unsigned int name;
    unsigned char payload[8];
};
struct C26Context { unsigned char bytes[80]; };
extern struct C26Token CURRENT_TOKEN_RECORD,TOKEN_TYPE;
extern struct C26Context BCC_TREE_SPECIAL;
extern unsigned int TOKEN_RECORD_STREAM;
extern int TOKEN_STREAM_POS;
extern unsigned int FUNCTION_DEF_POSITION; extern unsigned int ERROR_COUNT;
extern unsigned char FUNCTION_BODY_DEPTH;
extern char far *FUNCTION_NAME_TEXT;
extern void far pascal STREAM_SEEK(unsigned int,int);
extern void far pascal STREAM_PUT_TOKEN(unsigned int,struct C26Token far *);
extern void far pascal STREAM_PUT_END(unsigned int);
extern int far pascal STREAM_TELL(unsigned int);
extern void far pascal STREAM_COPY_STATE(unsigned int,unsigned int);
extern void far pascal STREAM_GET_TOKEN(unsigned int,struct C26Token far *);
extern void far pascal COMPILE_FUNCTION_DEFINITION(unsigned int,unsigned int,unsigned int,unsigned int,
    unsigned int,unsigned char,unsigned char);
extern unsigned int far pascal LIST_CONS(unsigned int,unsigned int);
extern void far pascal LIST_CELL_FREE(unsigned int);
extern void far pascal ADVANCE_TOKEN(void);
extern void far pascal BCC_LEX_SKIP(void);
extern void far pascal REPORT_CURRENT_TOKEN(int);
extern char far * far pascal NAME_TEXT_COPY(unsigned int);
extern void far pascal REPORT_DIAGNOSTIC(int,char far *,long);
void far pascal RECORD_INLINE_BODY(unsigned int);
void far pascal COMPILE_INLINE_BODY(unsigned int,unsigned char);
#endif
