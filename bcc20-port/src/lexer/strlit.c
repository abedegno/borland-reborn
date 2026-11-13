/* strlit.c: EMIT_ARGS, from bcc20/src/lexer/STRLIT.C: a string literal (and the literals
   adjacent to it, which C joins) into the data byte pool.

   *value gets the string's offset in the pool (the start of an earlier copy when -d merges
   duplicate strings), *count_result its length including the closing 0.  Bytes are emitted
   only while there are no errors. */
#include "port.h"
#include "data.h"
#include "protos.h"

void EMIT_ARGS(farptr value, farptr count_result)
{
    u16 count = 0;
    W(value) = BYTE_POOL_LENGTH();
    while (W(CURRENT_TOKEN_RECORD_P) == 52) {
        u16 index = 0;
        i16 token;
        while ((token = NEXT_LITERAL_CHAR(index++)) != -1) {
            count++;
            if (NO_ERRORS_YET)
                EMIT_VALUE((i8)token);
        }
        ADVANCE_TOKEN();
    }
    W(count_result) = count + 1;
    if (NO_ERRORS_YET)
        EMIT_VALUE(0);
    if (NO_ERRORS_YET && OPTION_MERGE_STRINGS)
        W(value) = MERGE_DUPLICATE_BYTES(W(value));
}
