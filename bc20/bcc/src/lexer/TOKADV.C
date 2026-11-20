/* target: ovr102_C44UNIT */
/* Role: lexer: token advance; reads the next token from nested playback streams or the
   lexer, records tokens, and drains unread string-literal characters. Entry points:
   NEXT_LITERAL_CHAR, PEEK_TOKEN, ADVANCE_TOKEN. Map of all sources: docs/SOURCE-MAP.md. */
/* Character draining, nested token streams, and nineteen-byte token advance. */
/* opts: -mm -G- -O -Z -p -Y -B -TjNOSMART -Tm2 */
/* Overview: the parser's token reader.  The parser sees two token records:
   CURRENT_TOKEN_RECORD (its code is copied to CURRENT_TOKEN) and one token
   of lookahead in TOKEN_TYPE, filled on demand by PEEK_TOKEN.  Token code
   0x82 in TOKEN_TYPE means "no lookahead read yet"; code 0 is end of input
   and 0x34 a string literal.
   Tokens come from one of two places.  Normally from the lexer
   (LEX_NEXT_TOKEN, LEXER.C).  But the C++ front end often has to parse a
   stretch of tokens later than it reads them (inline member function
   bodies, default arguments, lookahead to tell declarations from
   expressions), so it records tokens into streams (TOKSTRM.C) and plays
   them back.  C26_SCOPE_STACK holds the streams being played back, nested
   SCOPE_STACK_DEPTH deep; while it is nonzero tokens come from the
   innermost stream, and an exhausted stream (it returns 0x82) is popped.
   While RECORDING_TOKENS is set every token read is also appended to
   TOKEN_RECORD_STREAM.
   A string literal token does not carry its text: the characters are read
   later, one at a time, through NEXT_LITERAL_CHAR (STRLIT.C does this).
   STRING_TOKEN_PENDING says the current token is a literal whose
   characters have not all been read; ADVANCE_TOKEN must drain them (or
   patch the recording) before it can move on. */
#include "TOKADV.H"
/* Returns the next character of the current string literal, or -1 at its
   end (which also clears STRING_TOKEN_PENDING).  Reads from the playback
   stream when tokens are being replayed, otherwise from the lexer's
   string pool.  mode is the index of the character being read (0 for the
   first); NEXT_POOL_CHARACTER uses it, probably to start a new literal at
   index 0. */
int far pascal NEXT_LITERAL_CHAR(unsigned int mode)
{
    register int character;
    if(SCOPE_STACK_DEPTH>0)
        character=READ_STREAM_CHAR();
    else
        character=NEXT_POOL_CHARACTER(mode);
    if(character==-1)
        STRING_TOKEN_PENDING=0;
    return character;
}
/* Makes sure the lookahead record TOKEN_TYPE holds the next token, reading
   it if it is still empty (0x82).  The source is the innermost playback
   stream (finished streams are popped; when all are finished it falls back
   to the lexer), or the lexer, or, once end of input was seen, a 0 token.
   A newly read token is also recorded if recording is on. */
void far pascal PEEK_TOKEN(void)
{
    if(TOKEN_TYPE.kind==0x82) {
        if(SCOPE_STACK_DEPTH>0) {
            for(STREAM_GET_TOKEN(C26_SCOPE_STACK[SCOPE_STACK_DEPTH-1],&TOKEN_TYPE);
                TOKEN_TYPE.kind==0x82;
                STREAM_GET_TOKEN(C26_SCOPE_STACK[SCOPE_STACK_DEPTH-1],&TOKEN_TYPE)) {
                if(!--SCOPE_STACK_DEPTH)
                    break;
            }
            if(TOKEN_TYPE.kind==0x82)
                LEX_NEXT_TOKEN();
        } else {
            if(END_OF_INPUT_SEEN)
                TOKEN_TYPE.kind=0;
            else
                LEX_NEXT_TOKEN();
        }
        if(RECORDING_TOKENS)
            STREAM_PUT_TOKEN(TOKEN_RECORD_STREAM,&TOKEN_TYPE);
    }
}
/* Moves to the next token: drains any unread characters of a string
   literal (when recording, STREAM_PATCH_LITERAL fixes up the recorded
   literal instead), notes end of input after a 0 token has been
   consumed, then makes the lookahead the current token, empties the
   lookahead and sets STRING_TOKEN_PENDING if the new token is a string
   literal. */
void far pascal ADVANCE_TOKEN(void)
{
    register unsigned int mode;
    if(STRING_TOKEN_PENDING) {
        mode=0;
        if(RECORDING_TOKENS)
            STREAM_PATCH_LITERAL();
        else
            while(NEXT_LITERAL_CHAR(mode++)!=-1)
                ;
    }
    if(!CURRENT_TOKEN && !END_OF_INPUT_SEEN)
        END_OF_INPUT_SEEN=1;
    PEEK_TOKEN();
    CURRENT_TOKEN_RECORD=TOKEN_TYPE;
    TOKEN_TYPE.kind=0x82;
    CURRENT_TOKEN=CURRENT_TOKEN_RECORD.kind;
    STRING_TOKEN_PENDING=CURRENT_TOKEN==0x34;
}
