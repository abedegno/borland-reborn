/* comment.c: from bcc20/src/lexer/COMMENT.C: skipping comments in the input buffer.

   The original is hand-written assembly inside a C file.  The input buffer is the segment
   in the handle word that INPUT_BUFFER points to; INPUT_INDEX and INPUT_LIMIT are offsets
   in it.  When the buffer runs out, INPUT_REFILL refills it and returns the next character,
   and scanning goes on with that character.  An end-of-file byte (1Ah) inside a comment is
   error 41, "Unexpected end of file in comment started on line %d", with the line the
   comment began on; the input position is then left as it was before the comment. */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "variadic.h"

typedef struct {
    u16 si, limit, seg;
} Scan;

static void load(Scan *s)
{
    s->si = INPUT_INDEX;
    s->limit = INPUT_LIMIT;
    s->seg = W(DSPTR(INPUT_BUFFER));
}

/* the next character: from the buffer, or from INPUT_REFILL when it has run out */
static u8 next(Scan *s)
{
    if (s->si < s->limit)
        return B(MK_FP(s->seg, s->si++));
    INPUT_INDEX = s->si;
    u8 c = INPUT_REFILL();
    load(s);
    return c;
}

/* skip a block comment, called after its opening delimiter; INPUT_INDEX ends just past the
   closing one.  A nested opening delimiter counts only when COMMENT_NESTED is set. */
void COMMENT_BLOCK(void)
{
    u16 line = CURRENT_LINE;
    i16 depth = 0;
    Scan s;
    u8 c;
    load(&s);
    for (;;) {
        c = next(&s);
    character:
        if (c == '*') {
            c = next(&s);
            if (c != '/')
                goto character;
            if (--depth >= 0)
                continue;
            INPUT_INDEX = s.si;
            return;
        }
        if (c == '/') {
            if (COMMENT_NESTED == 0)
                continue;
            c = next(&s);
            if (c != '*')
                goto character;
            depth++;
            continue;
        }
        if (c == 26) {
            REPORT_ERROR(41, line);
            return;
        }
        if (c == 13 || c == 10) {
            INPUT_INDEX = s.si;
            LEX_NEWLINE((i8)c);
            load(&s);
        }
    }
}

/* skip a line comment up to, not including, the line end */
void COMMENT_LINE(void)
{
    u16 line = CURRENT_LINE;
    Scan s;
    load(&s);
    for (;;) {
        u8 c = next(&s);
        if (c == 26) {
            REPORT_ERROR(41, line);
            return;
        }
        if (c == 13 || c == 10) {
            INPUT_INDEX = s.si - 1;
            return;
        }
    }
}

/* does nothing: a scanner hook that needs no work */
void SCAN_EMPTY(i16 value)
{
    (void)value;
}
