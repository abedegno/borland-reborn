/* tokadv.c: from bcc20/src/lexer/TOKADV.C: the parser's token reader.

   The parser sees two token records: CURRENT_TOKEN_RECORD (its code is copied to
   CURRENT_TOKEN) and one token of lookahead in TOKEN_TYPE, filled on demand by PEEK_TOKEN.
   Code 82h in TOKEN_TYPE means "no lookahead read yet", 0 is end of input and 34h a string
   literal.  Tokens come from the innermost playback stream on C26_SCOPE_STACK (tokstrm.c)
   while one is being played back, otherwise from the lexer; while RECORDING_TOKENS is set
   each new token is also appended to TOKEN_RECORD_STREAM.  A string literal's characters
   are read later through NEXT_LITERAL_CHAR; STRING_TOKEN_PENDING says some are unread. */
#include "port.h"
#include "data.h"
#include "protos.h"

#define TOKEN_SIZE 19
#define KIND(t) W(t)

/* the next character of the current string literal, or -1 at its end (which clears
   STRING_TOKEN_PENDING); mode is the index of the character */
i16 NEXT_LITERAL_CHAR(u16 mode)
{
    i16 character;
    if ((i16)SCOPE_STACK_DEPTH > 0)
        character = READ_STREAM_CHAR();
    else
        character = NEXT_POOL_CHARACTER((i16)mode);
    if (character == -1)
        STRING_TOKEN_PENDING = 0;
    return character;
}

/* make sure TOKEN_TYPE holds the next token: from the innermost playback stream (finished
   streams are popped; when all are, from the lexer), or the lexer, or a 0 token once end of
   input was seen; recorded if recording is on */
void PEEK_TOKEN(void)
{
    if (KIND(TOKEN_TYPE_P) != 0x82)
        return;
    if ((i16)SCOPE_STACK_DEPTH > 0) {
        for (STREAM_GET_TOKEN(C26_SCOPE_STACK_AT(SCOPE_STACK_DEPTH - 1), TOKEN_TYPE_P);
             KIND(TOKEN_TYPE_P) == 0x82;
             STREAM_GET_TOKEN(C26_SCOPE_STACK_AT(SCOPE_STACK_DEPTH - 1), TOKEN_TYPE_P))
            if (!--SCOPE_STACK_DEPTH)
                break;
        if (KIND(TOKEN_TYPE_P) == 0x82)
            LEX_NEXT_TOKEN();
    } else if (END_OF_INPUT_SEEN)
        KIND(TOKEN_TYPE_P) = 0;
    else
        LEX_NEXT_TOKEN();
    if (RECORDING_TOKENS)
        STREAM_PUT_TOKEN(TOKEN_RECORD_STREAM, TOKEN_TYPE_P);
}

/* move to the next token: drain the unread characters of a string literal (when
   recording, STREAM_PATCH_LITERAL completes the recorded literal instead), note end of
   input after a 0 token, then make the lookahead current and empty the lookahead */
void ADVANCE_TOKEN(void)
{
    if (STRING_TOKEN_PENDING) {
        u16 mode = 0;
        if (RECORDING_TOKENS)
            STREAM_PATCH_LITERAL();
        else
            while (NEXT_LITERAL_CHAR(mode++) != -1)
                ;
    }
    if (!CURRENT_TOKEN && !END_OF_INPUT_SEEN)
        END_OF_INPUT_SEEN = 1;
    PEEK_TOKEN();
    for (int i = 0; i < TOKEN_SIZE; i++)
        B(fp_add(CURRENT_TOKEN_RECORD_P, i)) = B(fp_add(TOKEN_TYPE_P, i));
    KIND(TOKEN_TYPE_P) = 0x82;
    CURRENT_TOKEN = KIND(CURRENT_TOKEN_RECORD_P);
    STRING_TOKEN_PENDING = CURRENT_TOKEN == 0x34;
}
