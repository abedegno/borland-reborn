/* dirtail.c: CHECK_DIRECTIVE_END, from bcc20/src/preproc/DIRTAIL.C: the end of a
   directive line after its arguments (the file name of #include, the name of #undef,
   #ifdef and #ifndef, and after #else and #endif).  Blanks, comments and line splices are
   skipped up to the line end; any other text is extra: in strict ANSI mode an illegal
   character, and in every mode the rest of the line is then skipped. */
#include "port.h"
#include "data.h"
#include "msg.h"
#include "protos.h"
#include "variadic.h"

#define LANGUAGE_MODE SB(LANGUAGE_MODE_P)

static i16 getbyte(void)
{
    return INPUT_INDEX >= INPUT_LIMIT ? INPUT_REFILL() : B(MK_FP(W(DSPTR(INPUT_BUFFER)), INPUT_INDEX++));
}

void CHECK_DIRECTIVE_END(i16 value)
{
    for (;;) {
        switch (value) {
        case 10:
        case 13:
            --INPUT_INDEX;
            return;
        case 26:
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
        case 9:
        case 32:
            break;
        default:
            if (LANGUAGE_MODE == 1)
                REPORT_ERROR(MSG_ILLEGAL_CHARACTER_0X, value, value);
            BCC_SCAN_FINISH_FAR(value);
            return;
        }
        value = getbyte();
    }
}
