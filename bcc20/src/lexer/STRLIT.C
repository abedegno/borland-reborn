/* target: ovr118_EARGS */
/* opts: -mm -G- -O -Z -p */
/* Role: lexer: joins adjacent string-literal tokens into one byte string in the data pool,
   counting characters and merging duplicate strings. Map of all sources:
   docs/SOURCE-MAP.md. */

/* Overview: called by the expression parser when it meets a string
   literal.  Adjacent literals ("ab" "cd") are one string in C, so this
   consumes every string-literal token in a row (token code 52, 0x34; the
   first word of CURRENT_TOKEN_RECORD is the token code) and copies their
   characters, one after another, into the data byte pool (BYTE_POOL_LENGTH,
   EMIT_VALUE, in codegen/BYTEPOOL.C), then a closing 0 byte.  The
   characters are read with NEXT_LITERAL_CHAR (TOKADV.C), which drains the
   literal from the input or from a token playback stream.
   Bytes are emitted only while NO_ERRORS_YET is set (no error so far), so
   after an error literals are still counted but not stored.
   OPTION_MERGE_STRINGS is the "merge duplicate strings" option
   (-d): every use of it guards MERGE_DUPLICATE_BYTES, which replaces the
   new string by an identical earlier copy.
   The function is static far, linked into an overlay group whose stub
   is the real entry point. */
#include "DATA.H"
extern int far MERGE_DUPLICATE_BYTES(int value);
extern int far BYTE_POOL_LENGTH(void);
extern void far EMIT_VALUE(char value);
extern void far ADVANCE_TOKEN(void);
extern int far NEXT_LITERAL_CHAR(int index);
extern unsigned int CURRENT_TOKEN_RECORD;

/* value receives the offset of the string in the data byte pool (the
   start of a merged earlier copy when strings are merged); count_result
   receives its length in bytes including the closing 0. */
static void far pascal EMIT_ARGS(unsigned int far *value,
                                 unsigned int far *count_result)
{
    int token;
    register unsigned int count;
    register unsigned int index;

    count = 0;
    *value = BYTE_POOL_LENGTH();
    while (CURRENT_TOKEN_RECORD == 52) {
        index = 0;
        while ((token = NEXT_LITERAL_CHAR(index++)) != -1) {
            count++;
            if (NO_ERRORS_YET)
                EMIT_VALUE(token);
        }
        ADVANCE_TOKEN();
    }
    *count_result = count + 1;
    if (NO_ERRORS_YET)
        EMIT_VALUE(0);
    if (NO_ERRORS_YET && OPTION_MERGE_STRINGS)
        *value = MERGE_DUPLICATE_BYTES(*value);
}
