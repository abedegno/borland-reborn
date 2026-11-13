/* tokstrm.c: from bcc20/src/lexer/TOKSTRM.C: token streams, the C++ front end's way of
   reading tokens twice.

   A stream is a 12-byte descriptor in TOKEN_STREAM_POOL_SEG (line, file, current block,
   index in it, absolute position "cursor", first block) over a chain of 512-byte blocks,
   each 510 data bytes and a link.  A token is stored as its code byte, its column and a
   value that depends on the code (identifier name, integer value, 10-byte real, or a string
   literal's length followed later by its characters).  File and line are written only when
   they change, as marker bytes 84h (file serial number) and 83h (line difference).  Small
   numbers take one byte; FFh introduces the full 2 or 4 bytes.  Byte 82h ends a recording
   (also the "no token" code, so playback of an ended stream delivers "no token").

   A token record (struct C28Token, 19 bytes): kind word at 0, flags byte at 2, location
   words at 3, 5 and 7 (file serial, line, column), value at 9.  BCC_PARSE_PUSH, _POP and
   _BEGIN give the parser backtracking on the four replay streams REPLAY_STREAM_1..4.

   The static functions of the original are external here, so replay can check them. */
#include "port.h"
#include "data.h"
#include "pool.h"
#include "protos.h"

/* stream descriptor fields */
#define S_LINE(n) W(MK_FP(TOKEN_STREAM_POOL_SEG, (n)))
#define S_FILE(n) W(MK_FP(TOKEN_STREAM_POOL_SEG, (n) + 2))
#define S_BLOCK(n) W(MK_FP(TOKEN_STREAM_POOL_SEG, (n) + 4))
#define S_INDEX(n) SW(MK_FP(TOKEN_STREAM_POOL_SEG, (n) + 6))
#define S_CURSOR(n) SW(MK_FP(TOKEN_STREAM_POOL_SEG, (n) + 8))
#define S_FIRST(n) W(MK_FP(TOKEN_STREAM_POOL_SEG, (n) + 10))
/* block: 510 data bytes, then the next block */
#define B_DATA(n, i) B(MK_FP(TOKEN_STREAM_POOL_SEG, (n) + (i)))
#define B_NEXT(n) W(MK_FP(TOKEN_STREAM_POOL_SEG, (n) + 510))
/* token record fields, through a far pointer */
#define T_KIND(t) W(t)
#define T_FLAGS(t) B(fp_add((t), 2))
#define T_LOC(t, i) W(fp_add((t), 3 + 2 * (i)))
#define T_VALUE(t) fp_add((t), 9)
/* replay stream kind 1..4 */
#define MODE_STREAM(kind) W(fp_add(REPLAY_STREAM_1_P, 2 * ((kind) - 1)))
#define CURRENT_TOKEN_VALUE W(CURRENT_TOKEN_VALUE_P)

/* step to the next block when the 510 data bytes are used, allocating it if the chain ends
   (reading does this too, as the original does) */
static void next_block(u16 stream)
{
    if (S_INDEX(stream) != 510)
        return;
    if (!B_NEXT(S_BLOCK(stream))) {
        u16 block = POOL_ALLOC(TOKEN_STREAM_POOL_SEG_P, 512);
        B_NEXT(S_BLOCK(stream)) = block;
        B_NEXT(B_NEXT(S_BLOCK(stream))) = 0;
    }
    S_BLOCK(stream) = B_NEXT(S_BLOCK(stream));
    S_INDEX(stream) = 0;
}

void STREAM_PUT_BYTE(u8 value, u16 stream)
{
    B_DATA(S_BLOCK(stream), S_INDEX(stream)) = value;
    S_INDEX(stream)++;
    S_CURSOR(stream)++;
    next_block(stream);
}

void STREAM_PUT_INT(i16 value, u16 stream)
{
    if (value >= 0 && value < 255)
        STREAM_PUT_BYTE((u8)value, stream);
    else {
        STREAM_PUT_BYTE(0xFF, stream);
        STREAM_PUT_BYTE((u8)value, stream);
        STREAM_PUT_BYTE((u8)((u16)value >> 8), stream);
    }
}

void STREAM_PUT_LONG(i32 value, u16 stream)
{
    if (value >= 0 && value < 255)
        STREAM_PUT_BYTE((u8)value, stream);
    else {
        STREAM_PUT_BYTE(0xFF, stream);
        for (int i = 0; i < 4; i++)
            STREAM_PUT_BYTE((u8)((u32)value >> (8 * i)), stream);
    }
}

/* the ten bytes of the real, then the flags byte */
void STREAM_PUT_REAL(farptr token, u16 stream)
{
    u8 bytes[10];
    for (int i = 0; i < 10; i++)
        bytes[i] = B(fp_add(T_VALUE(token), i));
    for (int i = 0; i < 10; i++)
        STREAM_PUT_BYTE(bytes[i], stream);
    STREAM_PUT_BYTE(T_FLAGS(token), stream);
}

/* one token record; for a string literal (34h) the place of its placeholder length is kept
   in C28_LITERAL_PATCH for STREAM_PATCH_LITERAL */
void STREAM_ENCODE_TOKEN(farptr token, u16 stream)
{
    if (S_FILE(stream) != T_LOC(token, 0)) {
        STREAM_PUT_BYTE(0x84, stream);
        STREAM_PUT_INT((i16)T_LOC(token, 0), stream);
        S_FILE(stream) = T_LOC(token, 0);
    }
    if (S_LINE(stream) != T_LOC(token, 1)) {
        STREAM_PUT_BYTE(0x83, stream);
        STREAM_PUT_INT((i16)(T_LOC(token, 1) - S_LINE(stream)), stream);
        S_LINE(stream) = T_LOC(token, 1);
    }
    STREAM_PUT_BYTE((u8)T_KIND(token), stream);
    STREAM_PUT_INT((i16)T_LOC(token, 2), stream);
    switch (T_KIND(token)) {
    case 0x31:
        STREAM_PUT_INT((i16)W(T_VALUE(token)), stream);
        break;
    case 0x32:
    case 0x65:
        STREAM_PUT_LONG(SD(T_VALUE(token)), stream);
        STREAM_PUT_BYTE(T_FLAGS(token), stream);
        break;
    case 0x34:
        C28_LITERAL_PATCH = STREAM_TELL(stream);
        STREAM_PUT_INT(-1, stream);
        break;
    case 0x33:
        STREAM_PUT_REAL(token, stream);
        break;
    }
}

/* end a recording: the end byte 82h, and recording stops */
void STREAM_PUT_END(u16 stream)
{
    STREAM_PUT_BYTE(0x82, stream);
    RECORDING_TOKENS = 0;
}

u8 STREAM_GET_BYTE(u16 stream)
{
    u8 value = B_DATA(S_BLOCK(stream), S_INDEX(stream));
    S_INDEX(stream)++;
    S_CURSOR(stream)++;
    next_block(stream);
    return value;
}

i16 STREAM_GET_INT(u16 stream)
{
    u16 value = STREAM_GET_BYTE(stream);
    if (value == 255) {
        u8 low = STREAM_GET_BYTE(stream);
        u8 high = STREAM_GET_BYTE(stream);
        value = (u16)(low | high << 8);
    }
    return (i16)value;
}

i32 STREAM_GET_LONG(u16 stream)
{
    u32 value = STREAM_GET_BYTE(stream);
    if (value == 255) {
        value = 0;
        for (int i = 0; i < 4; i++)
            value |= (u32)STREAM_GET_BYTE(stream) << (8 * i);
    }
    return (i32)value;
}

void STREAM_GET_REAL(farptr destination, u16 stream)
{
    u8 bytes[10];
    for (int i = 0; i < 10; i++)
        bytes[i] = STREAM_GET_BYTE(stream);
    for (int i = 0; i < 10; i++)
        B(fp_add(destination, i)) = bytes[i];
}

/* one token record into *token, first applying file and line markers (a file change also
   sets CURRENT_FILE_NAME, so diagnostics name the right file); for a string literal the
   value word gets -count-1 as stored, which reads back as the number of characters that
   follow */
void STREAM_DECODE_TOKEN(farptr token, u16 stream)
{
    u8 kind;
    for (;;) {
        kind = STREAM_GET_BYTE(stream);
        if (kind == 0x84) {
            S_FILE(stream) = (u16)STREAM_GET_INT(stream);
            CURRENT_FILE_NAME = AT_W(SRCFILE_POOL_SEG, FIND_NODE_BY_SERIAL(S_FILE(stream)));
            continue;
        }
        if (kind == 0x83) {
            S_LINE(stream) += (u16)STREAM_GET_INT(stream);
            continue;
        }
        break;
    }
    T_LOC(token, 1) = S_LINE(stream);
    T_LOC(token, 0) = S_FILE(stream);
    T_KIND(token) = kind;
    T_LOC(token, 2) = (u16)STREAM_GET_INT(stream);
    switch (kind) {
    case 0x31:
        W(T_VALUE(token)) = (u16)STREAM_GET_INT(stream);
        break;
    case 0x32:
    case 0x65:
        SD(T_VALUE(token)) = STREAM_GET_LONG(stream);
        T_FLAGS(token) = STREAM_GET_BYTE(stream);
        break;
    case 0x33:
        STREAM_GET_REAL(T_VALUE(token), stream);
        T_FLAGS(token) = STREAM_GET_BYTE(stream);
        break;
    case 0x34:
        W(T_VALUE(token)) = (u16)(-STREAM_GET_INT(stream) - 1);
        break;
    }
}

/* the current token is a string literal being recorded: append all its characters to the
   recording and write -count-1 over the placeholder, keeping position and line */
void STREAM_PATCH_LITERAL(void)
{
    i16 value, index;
    for (index = 0; (value = NEXT_LITERAL_CHAR((u16)index)) != -1; ++index)
        STREAM_PUT_BYTE((u8)value, TOKEN_RECORD_STREAM);
    i16 position = STREAM_TELL(TOKEN_RECORD_STREAM);
    u16 line = S_LINE(TOKEN_RECORD_STREAM);
    STREAM_SEEK(TOKEN_RECORD_STREAM, C28_LITERAL_PATCH);
    STREAM_PUT_INT((i16)(-index - 1), TOKEN_RECORD_STREAM);
    STREAM_SEEK(TOKEN_RECORD_STREAM, position);
    S_LINE(TOKEN_RECORD_STREAM) = line;
}

/* the next character of a replayed string literal, or -1 when the count in the current
   token's value word runs out (it is decremented either way) */
i16 READ_STREAM_CHAR(void)
{
    if (CURRENT_TOKEN_VALUE-- == 0)
        return -1;
    return STREAM_GET_BYTE(C26_SCOPE_STACK_AT(SCOPE_STACK_DEPTH - 1));
}

/* a new stream descriptor into *destination: with existing 0 it gets its own first block,
   otherwise it shares existing's block chain */
void STREAM_CREATE(farptr destination, u16 existing)
{
    u16 stream = POOL_ALLOC(TOKEN_STREAM_POOL_SEG_P, 12);
    S_LINE(stream) = 0;
    S_FILE(stream) = 0;
    if (!existing) {
        u16 first = POOL_ALLOC(TOKEN_STREAM_POOL_SEG_P, 512);
        S_FIRST(stream) = first;
        B_NEXT(S_FIRST(stream)) = 0;
    } else
        S_FIRST(stream) = S_FIRST(existing);
    S_BLOCK(stream) = S_FIRST(stream);
    S_CURSOR(stream) = 0;
    S_INDEX(stream) = 0;
    W(destination) = stream;
}

void STREAM_COPY_STATE(u16 destination, u16 source)
{
    for (int i = 0; i < 12; i++)
        B(MK_FP(TOKEN_STREAM_POOL_SEG, destination + i)) = B(MK_FP(TOKEN_STREAM_POOL_SEG, source + i));
}

/* move to byte position, walking the chain from the current block, or from the first when
   moving back; file and line are reset so the next token carries its full position */
void STREAM_SEEK(u16 stream, i16 position)
{
    S_LINE(stream) = 0;
    S_FILE(stream) = 0xFFFF;
    i16 block = S_CURSOR(stream) / 510;
    S_CURSOR(stream) = position;
    i16 target = position / 510;
    S_INDEX(stream) = position % 510;
    if (block > target) {
        block = 0;
        S_BLOCK(stream) = S_FIRST(stream);
    }
    for (; target > block; ++block) {
        if (!B_NEXT(S_BLOCK(stream))) {
            u16 next = POOL_ALLOC(TOKEN_STREAM_POOL_SEG_P, 512);
            B_NEXT(S_BLOCK(stream)) = next;
            B_NEXT(B_NEXT(S_BLOCK(stream))) = 0;
        }
        S_BLOCK(stream) = B_NEXT(S_BLOCK(stream));
    }
}

i16 STREAM_TELL(u16 stream)
{
    return S_CURSOR(stream);
}

void STREAM_PUT_TOKEN(u16 stream, farptr token)
{
    STREAM_ENCODE_TOKEN(token, stream);
}

void STREAM_GET_TOKEN(u16 stream, farptr token)
{
    STREAM_DECODE_TOKEN(token, stream);
}

/* start recording into replay stream kind (1..4) from its beginning, writing the current
   and the lookahead token first, so BCC_PARSE_POP returns exactly here */
void BCC_PARSE_PUSH(u16 kind)
{
    STREAM_SEEK(MODE_STREAM(kind), 0);
    RECORDING_TOKENS = 1;
    TOKEN_RECORD_STREAM = MODE_STREAM(kind);
    STREAM_PUT_TOKEN(MODE_STREAM(kind), CURRENT_TOKEN_RECORD_P);
    STREAM_PUT_TOKEN(MODE_STREAM(kind), TOKEN_TYPE_P);
}

/* end the recording (finishing a string literal still being read) and rewind: the stream
   goes on the playback stack and the current and lookahead tokens are read again from its
   start */
void BCC_PARSE_POP(u16 kind)
{
    if (STRING_TOKEN_PENDING)
        STREAM_PATCH_LITERAL();
    if (T_KIND(TOKEN_TYPE_P) == 0x34) {
        ADVANCE_TOKEN();
        STREAM_PATCH_LITERAL();
    }
    STREAM_PUT_END(TOKEN_RECORD_STREAM);
    ++SCOPE_STACK_DEPTH;
    C26_SCOPE_STACK_AT(SCOPE_STACK_DEPTH - 1) = MODE_STREAM(kind);
    STREAM_SEEK(MODE_STREAM(kind), 0);
    STREAM_GET_TOKEN(MODE_STREAM(kind), CURRENT_TOKEN_RECORD_P);
    CURRENT_TOKEN = T_KIND(CURRENT_TOKEN_RECORD_P);
    STREAM_GET_TOKEN(MODE_STREAM(kind), TOKEN_TYPE_P);
}

/* 1 if replay stream kind is not being played back now, else 0 */
u8 BCC_PARSE_BEGIN(u16 kind)
{
    for (u16 index = 0; index < SCOPE_STACK_DEPTH; ++index)
        if (C26_SCOPE_STACK_AT(index) == MODE_STREAM(kind))
            return 0;
    return 1;
}
