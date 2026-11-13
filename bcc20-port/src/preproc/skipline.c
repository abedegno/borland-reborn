/* skipline.c: BCC_SCAN_FINISH_FAR, from bcc20/src/preproc/SKIPLINE.C: skip the rest of a
   line, starting with the character value already read.  Comments and line splices are
   passed over, quoted strings and character constants are read whole (through
   COPY_STRING_LITERAL with an output that throws the characters away), so a quote cannot
   hide the line end.  Stops in front of the line end, or at end of input.  The original's
   body label SCAN_FINISH is this function, called near from PREPROC.C. */
#include "port.h"
#include "data.h"
#include "protos.h"

#define LANGUAGE_MODE SB(LANGUAGE_MODE_P)

static i16 getbyte(void)
{
    return INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() : B(MK_FP(W(DSPTR(INPUT_BUFFER)), INPUT_INDEX++));
}

void BCC_SCAN_FINISH_FAR(i16 value)
{
    for (;;) {
        switch (value) {
        case 10:
        case 13:
            --INPUT_INDEX;
            return;
        case '/':
            value = getbyte();
            if (value == '*')
                COMMENT_BLOCK();
            else if (LANGUAGE_MODE != 1 && value == '/')
                COMMENT_LINE();
            else
                --INPUT_INDEX;
            break;
        case '\\':
            value = getbyte();
            if (value == 10 || value == 13)
                LEX_NEWLINE((i8)value);
            break;
        case '"':
        case '\'':
            if (!COPY_STRING_LITERAL((i8)value, DISCARD_CHAR_EMIT_FN, 0))
                return;
            break;
        case 26:
            return;
        }
        value = getbyte();
    }
}
