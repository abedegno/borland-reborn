/* target: ovr084_C28UNIT */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Role: token record/playback stream. Entry points: STREAM_PUT_END, STREAM_PATCH_LITERAL,
   READ_STREAM_CHAR, STREAM_CREATE, STREAM_COPY_STATE, STREAM_SEEK, STREAM_TELL,
   STREAM_PUT_TOKEN (+4 more). Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: token streams, the C++ front end's way of reading tokens
   twice.  A stream is a 12-byte descriptor (struct C28Stream: current
   block, index in it, absolute position "cursor", first block, and the
   last file and line written or read) over a chain of 512-byte blocks in
   TOKEN_STREAM_POOL_SEG, each holding 510 data bytes and a link.
   Tokens are stored compactly: a token code byte, its column, and a value
   that depends on the code (identifier name, integer value, 10-byte
   floating value, or a string literal's length and characters).  The file
   and line are written only when they change, as marker bytes 0x84 (file
   serial number) and 0x83 (line difference).  Small numbers take one
   byte; 0xFF introduces a full 2- or 4-byte value.  Byte 0x82 ends a
   recording (0x82 is also the "no token" code, so playback of an ended
   stream delivers "no token" and TOKADV.C pops the stream).
   Recording: while RECORDING_TOKENS is set, PEEK_TOKEN (TOKADV.C) appends
   each new token to TOKEN_RECORD_STREAM.  A string literal is written with
   a placeholder length; its characters are appended when they are read,
   and STREAM_PATCH_LITERAL then writes the real length back.
   Playback: C26_SCOPE_STACK holds the streams being read, SCOPE_STACK_DEPTH
   deep; tokens come from the innermost one.
   BCC_PARSE_PUSH / BCC_PARSE_POP / BCC_PARSE_BEGIN give the parser a
   backtracking tool on the four fixed streams REPLAY_STREAM_1..4 (chosen
   by kind 1..4): PUSH starts recording at the current token, the parser
   reads ahead as far as it needs to decide something, and POP rewinds by
   replaying the recorded tokens from the start.  CURRENT_TOKEN_VALUE
   is the value word of CURRENT_TOKEN_RECORD (DS:638B, offset 9 of
   the record); for a replayed string literal it counts the characters
   still to be read. */
#include <dos.h>
#include "TOKSTRM.H"
#include "POOL.H"
#define STREAM(n) (*(struct C28Stream far *)MK_FP(TOKEN_STREAM_POOL_SEG,(n)))
#define BLOCK(n) (*(struct C28Block far *)MK_FP(TOKEN_STREAM_POOL_SEG,(n)))
/* Actual slots6420..6426 are addressed by one-based stream kinds. */
#define MODE_STREAM(kind) ((REPLAY_STREAM_1-1)[kind])

/* 0000 */
/* Appends one byte to the stream, moving to the next block (allocating it
   if the chain ends) when the 510 data bytes of a block are full. */
static void far pascal STREAM_PUT_BYTE(unsigned char value,register unsigned int stream)
{
    BLOCK(STREAM(stream).block).data[STREAM(stream).index++]=value;
    ++STREAM(stream).cursor;
    if(STREAM(stream).index!=510)
        return;
    if(!BLOCK(STREAM(stream).block).next) {
        BLOCK(STREAM(stream).block).next=POOL_ALLOC(&TOKEN_STREAM_POOL_SEG,512);
        BLOCK(BLOCK(STREAM(stream).block).next).next=0;
    }
    STREAM(stream).block=BLOCK(STREAM(stream).block).next;
    STREAM(stream).index=0;
}
/* 0082: FF escapes a genuine little-endian two-byte signed value. */
static void far pascal STREAM_PUT_INT(int value,register unsigned int stream)
{
    int stored;
    register int index;
    if(value>=0 && value<255)
        STREAM_PUT_BYTE((unsigned char)value,stream);
    else {
        STREAM_PUT_BYTE(0xFF,stream);
        stored=value;
        for(index=0;index<2;++index)
            STREAM_PUT_BYTE(((unsigned char near *)&stored)[index],stream);
    }
}
/* 00CD */
/* As STREAM_PUT_INT, for a long: one byte for 0..254, else 0xFF and four
   bytes. */
static void far pascal STREAM_PUT_LONG(long value,register unsigned int stream)
{
    long stored;
    register int index;
    if(value>=0L && value<255L)
        STREAM_PUT_BYTE((unsigned char)value,stream);
    else {
        STREAM_PUT_BYTE(0xFF,stream);
        stored=value;
        for(index=0;index<4;++index)
            STREAM_PUT_BYTE(((unsigned char near *)&stored)[index],stream);
    }
}
/* 012F: preserve all ten real payload bytes, then its actual flag byte. */
static void far pascal STREAM_PUT_REAL(struct C28Token far *token,register unsigned int stream)
{
    unsigned char bytes[10];
    register int index;
    RTL_MEMMOVE(bytes,token->value.real,10);
    for(index=0;index<10;++index)
        STREAM_PUT_BYTE(bytes[index],stream);
    STREAM_PUT_BYTE(token->flags,stream);
}
/* 017A: location markers, kind/column, then the five sparse payload cases. */
/* Writes one token record.  location[0] is the file's serial number,
   location[1] the line and location[2] the column.  For a string literal
   (0x34) the position of its placeholder length is remembered in
   C28_LITERAL_PATCH for STREAM_PATCH_LITERAL. */
static void far pascal STREAM_ENCODE_TOKEN(struct C28Token far *token,register unsigned int stream)
{
    if(STREAM(stream).file!=token->location[0]) {
        STREAM_PUT_BYTE(0x84,stream);
        STREAM_PUT_INT(token->location[0],stream);
        STREAM(stream).file=token->location[0];
    }
    if(STREAM(stream).line!=token->location[1]) {
        STREAM_PUT_BYTE(0x83,stream);
        STREAM_PUT_INT(token->location[1]-STREAM(stream).line,stream);
        STREAM(stream).line=token->location[1];
    }
    STREAM_PUT_BYTE(token->kind,stream);
    STREAM_PUT_INT(token->location[2],stream);
    switch(token->kind) {
    case 0x31:
        STREAM_PUT_INT(token->value.name,stream);
        break;
    case 0x32:
    case 0x65:
        STREAM_PUT_LONG(token->value.number,stream);
        STREAM_PUT_BYTE(token->flags,stream);
        break;
    case 0x34:
        C28_LITERAL_PATCH=STREAM_TELL(stream);
        STREAM_PUT_INT(-1,stream);
        break;
    case 0x33:
        STREAM_PUT_REAL(token,stream);
        break;
    }
}
/* 028C */
/* Ends a recording: writes the end byte 0x82 and stops recording. */
void far pascal STREAM_PUT_END(unsigned int stream)
{
    STREAM_PUT_BYTE(0x82,stream);
    RECORDING_TOKENS=0;
}
/* 02A2: reading across a missing block retains the original allocation. */
/* Reads one byte and steps over block ends like STREAM_PUT_BYTE (it even
   allocates a missing next block, as the original does). */
static unsigned char far pascal STREAM_GET_BYTE(register unsigned int stream)
{
    unsigned char value;
    value=BLOCK(STREAM(stream).block).data[STREAM(stream).index++];
    ++STREAM(stream).cursor;
    if(STREAM(stream).index!=510)
        return value;
    if(!BLOCK(STREAM(stream).block).next) {
        BLOCK(STREAM(stream).block).next=POOL_ALLOC(&TOKEN_STREAM_POOL_SEG,512);
        BLOCK(BLOCK(STREAM(stream).block).next).next=0;
    }
    STREAM(stream).block=BLOCK(STREAM(stream).block).next;
    STREAM(stream).index=0;
    return value;
}
/* 032D */
/* Reads a number written by STREAM_PUT_INT. */
static int far pascal STREAM_GET_INT(register unsigned int stream)
{
    int value;
    register int index;
    value=STREAM_GET_BYTE(stream);
    if(value==255) {
        for(index=0;index<2;++index)
            ((unsigned char near *)&value)[index]=STREAM_GET_BYTE(stream);
    }
    return value;
}
/* 0365 */
/* Reads a number written by STREAM_PUT_LONG. */
static long far pascal STREAM_GET_LONG(register unsigned int stream)
{
    long value;
    register int index;
    value=STREAM_GET_BYTE(stream);
    if(value==255L) {
        for(index=0;index<4;++index)
            ((unsigned char near *)&value)[index]=STREAM_GET_BYTE(stream);
    }
    return value;
}
/* 03AC */
/* Reads a 10-byte floating value into destination. */
static void far pascal STREAM_GET_REAL(unsigned char far *destination,unsigned int stream)
{
    unsigned char bytes[10];
    register int index;
    for(index=0;index<10;++index)
        bytes[index]=STREAM_GET_BYTE(stream);
    RTL_MEMMOVE(destination,bytes,10);
}
/* 03E2: default cases deliberately leave flags and payload untouched. */
/* Reads one token record into *token, first applying any file and line
   markers (a file change also sets CURRENT_FILE_NAME, so diagnostics name
   the right file).  For a string literal the value word receives the
   number of characters that follow in the stream. */
static void far pascal STREAM_DECODE_TOKEN(struct C28Token far *token,register unsigned int stream)
{
    unsigned char kind;
    for(;;) {
        kind=STREAM_GET_BYTE(stream);
        if(kind==0x84) {
            STREAM(stream).file=STREAM_GET_INT(stream);
            CURRENT_FILE_NAME=AT_W(SRCFILE_POOL_SEG,FIND_NODE_BY_SERIAL(STREAM(stream).file));
            continue;
        }
        if(kind==0x83) {
            STREAM(stream).line+=STREAM_GET_INT(stream);
            continue;
        }
        break;
    }
    token->location[1]=STREAM(stream).line;
    token->location[0]=STREAM(stream).file;
    token->kind=kind;
    token->location[2]=STREAM_GET_INT(stream);
    switch(kind) {
    case 0x31:
        token->value.name=STREAM_GET_INT(stream);
        break;
    case 0x32:
    case 0x65:
        token->value.number=STREAM_GET_LONG(stream);
        token->flags=STREAM_GET_BYTE(stream);
        break;
    case 0x33:
        STREAM_GET_REAL(token->value.real,stream);
        token->flags=STREAM_GET_BYTE(stream);
        break;
    case 0x34:
        token->value.name=-STREAM_GET_INT(stream)-1;
        break;
    }
}
/* 04EF: append raw literal bytes and patch its existing signed placeholder. */
/* Called when the current token is a string literal being recorded: reads
   all its characters, appends them to the recording stream, and writes
   the character count (as -count-1) over the placeholder written by
   STREAM_ENCODE_TOKEN, keeping the stream position and line. */
void far pascal STREAM_PATCH_LITERAL(void)
{
    int value;
    int position;
    unsigned int line;
    register int index;
    for(index=0;(value=NEXT_LITERAL_CHAR(index))!=-1;++index)
        STREAM_PUT_BYTE((unsigned char)value,TOKEN_RECORD_STREAM);
    position=STREAM_TELL(TOKEN_RECORD_STREAM);
    line=STREAM(TOKEN_RECORD_STREAM).line;
    STREAM_SEEK(TOKEN_RECORD_STREAM,C28_LITERAL_PATCH);
    STREAM_PUT_INT(-index-1,TOKEN_RECORD_STREAM);
    STREAM_SEEK(TOKEN_RECORD_STREAM,position);
    STREAM(TOKEN_RECORD_STREAM).line=line;
}
/* 0569: post-decrement is retained even on the zero-count return. */
/* Returns the next character of a replayed string literal from the
   innermost playback stream, or -1 when CURRENT_TOKEN_VALUE (the remaining count in
   the current token's value word) runs out. */
int far pascal READ_STREAM_CHAR(void)
{
    if(CURRENT_TOKEN_VALUE--==0)
        return -1;
    return STREAM_GET_BYTE(C26_SCOPE_STACK[SCOPE_STACK_DEPTH-1]);
}
/* 058F: descriptors may share the existing first block chain. */
/* Allocates a new stream descriptor into *destination.  With existing 0 it
   gets its own first block; otherwise it reads and writes the same block
   chain as the stream existing (INIT_PARSER makes INLINE_TOKEN_STREAM share
   TOKEN_STREAM_HANDLE's chain this way). */
void far pascal STREAM_CREATE(unsigned int far *destination,register unsigned int existing)
{
    register unsigned int stream;
    stream=POOL_ALLOC(&TOKEN_STREAM_POOL_SEG,12);
    STREAM(stream).line=0;
    STREAM(stream).file=0;
    if(!existing) {
        STREAM(stream).first=POOL_ALLOC(&TOKEN_STREAM_POOL_SEG,512);
        BLOCK(STREAM(stream).first).next=0;
    } else
        STREAM(stream).first=STREAM(existing).first;
    STREAM(stream).block=STREAM(stream).first;
    STREAM(stream).cursor=0;
    STREAM(stream).index=0;
    *destination=stream;
}
/* 060D: genuine12B structure assignment. */
/* Copies a whole descriptor, so destination continues at source's
   position. */
void far pascal STREAM_COPY_STATE(unsigned int destination,unsigned int source)
{
    STREAM(destination)=STREAM(source);
}
/* 062A: all three signed quotient/remainder operations are real consumers. */
/* Moves the stream to byte position, walking the block chain from the
   current block, or from the first one when moving backwards.  The file
   and line state are reset, so the next token read or written carries its
   full position. */
void far pascal STREAM_SEEK(register unsigned int stream,int position)
{
    int target;
    register int block;
    STREAM(stream).line=0;
    STREAM(stream).file=0xFFFF;
    block=STREAM(stream).cursor/510;
    STREAM(stream).cursor=position;
    target=position/510;
    STREAM(stream).index=position%510;
    if(block>target) {
        block=0;
        STREAM(stream).block=STREAM(stream).first;
    }
    for(;target>block;++block) {
        if(!BLOCK(STREAM(stream).block).next) {
            BLOCK(STREAM(stream).block).next=POOL_ALLOC(&TOKEN_STREAM_POOL_SEG,512);
            BLOCK(BLOCK(STREAM(stream).block).next).next=0;
        }
        STREAM(stream).block=BLOCK(STREAM(stream).block).next;
    }
}
/* 06D1 */
/* Returns the stream's current byte position. */
int far pascal STREAM_TELL(register unsigned int stream)
{
    return STREAM(stream).cursor;
}
/* 06E5 */
void far pascal STREAM_PUT_TOKEN(unsigned int stream,struct C28Token far *token)
{
    STREAM_ENCODE_TOKEN(token,stream);
}
/* 06F9 */
void far pascal STREAM_GET_TOKEN(unsigned int stream,struct C28Token far *token)
{
    STREAM_DECODE_TOKEN(token,stream);
}
/* 070D: canonical name retained despite its raw native PUB spelling. */
/* Starts recording into replay stream kind (1..4) from its beginning; the
   current token and the lookahead token are written first, so a later
   BCC_PARSE_POP returns exactly to this point. */
void far pascal BCC_PARSE_PUSH(register unsigned int kind)
{
    STREAM_SEEK(MODE_STREAM(kind),0);
    RECORDING_TOKENS=1;
    TOKEN_RECORD_STREAM=MODE_STREAM(kind);
    STREAM_PUT_TOKEN(MODE_STREAM(kind),&CURRENT_TOKEN_RECORD);
    STREAM_PUT_TOKEN(MODE_STREAM(kind),&TOKEN_TYPE);
}
/* 075A */
/* Ends the recording started by BCC_PARSE_PUSH (finishing any string
   literal still being read) and rewinds: the stream is pushed on the
   playback stack and the current and lookahead tokens are reloaded from
   its start, so the parser reads the same tokens again. */
void far pascal BCC_PARSE_POP(register unsigned int kind)
{
    if(STRING_TOKEN_PENDING)
        STREAM_PATCH_LITERAL();
    if(TOKEN_TYPE.kind==0x34) {
        ADVANCE_TOKEN();
        STREAM_PATCH_LITERAL();
    }
    STREAM_PUT_END(TOKEN_RECORD_STREAM);
    ++SCOPE_STACK_DEPTH;
    C26_SCOPE_STACK[SCOPE_STACK_DEPTH-1]=MODE_STREAM(kind);
    STREAM_SEEK(MODE_STREAM(kind),0);
    STREAM_GET_TOKEN(MODE_STREAM(kind),&CURRENT_TOKEN_RECORD);
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    STREAM_GET_TOKEN(MODE_STREAM(kind),&TOKEN_TYPE);
}
/* 07D7: one unsigned depth scan; BYTE result is fully defined AL0/1. */
/* Returns 1 if replay stream kind is free, that is not being played back
   at the moment, else 0.  Callers check this before BCC_PARSE_PUSH. */
unsigned char far pascal BCC_PARSE_BEGIN(unsigned int kind)
{
    register unsigned int index;
    for(index=0;index<SCOPE_STACK_DEPTH;++index) {
        if(C26_SCOPE_STACK[index]==MODE_STREAM(kind))
            return 0;
    }
    return 1;
}
