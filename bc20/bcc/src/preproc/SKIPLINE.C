/* target: ovr105_C139UNIT */
/* opts: -mm -O -Z -p -Y -y */
/* Role: precompiled headers: skips to end of line past comments, splices and quoted strings
   (used by PCH.C when scanning directives). Entry points: BCC_SCAN_FINISH_FAR. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: skips the rest of a line in the input, starting with the
   character value already read.  Comments and line splices are passed
   over (a block comment may run over several lines), and quoted strings
   and character constants are read whole through COPY_STRING_LITERAL with
   an output function that throws the characters away
   (DISCARD_CHAR_EMIT_FN), so a quote cannot hide the line end.  It stops
   in front of the line end, or at end of input.  PCH.C uses it while
   scanning directive lines; SCAN_FINISH, used by PREPROC.C, probably has
   the same body in another overlay. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
extern unsigned int INPUT_INDEX; extern unsigned int INPUT_LIMIT;
extern signed char  LANGUAGE_MODE;
extern unsigned char far pascal INPUT_REFILL(void);
extern void far pascal COMMENT_BLOCK_BODY(void);
extern void far pascal COMMENT_LINE_BODY(void);
extern void far pascal LEX_NEWLINE(char);

/* ---- LEXFIN (listing DF9B) ---- */
extern void (far pascal *DISCARD_CHAR_EMIT_FN)(signed char);
extern int far pascal COPY_STRING_LITERAL(signed char,void (far pascal *)(signed char),unsigned int);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* value: the first character of the rest of the line. */
void far pascal BCC_SCAN_FINISH_FAR(int value)
{
    for(;;) {
        switch(value) {
        case 10:case 13:
            --INPUT_INDEX;
            return;
        case '/':
            value=GETBYTE;
            if(value=='*') COMMENT_BLOCK_BODY();
            else if(LANGUAGE_MODE!=1 && value=='/') COMMENT_LINE_BODY();
            else --INPUT_INDEX;
            break;
        case '\\':
            value=GETBYTE;
            if(value==10 || value==13) LEX_NEWLINE((char)value);
            break;
        case '"':case '\'':
            if(!COPY_STRING_LITERAL((signed char)value,DISCARD_CHAR_EMIT_FN,0)) return;
            break;
        case 26:
            return;
        }
        value=GETBYTE;
    }
}
#undef GETBYTE
