/* target: ovr105_C137UNIT */
/* opts: -mm -O -Z -p -Y -y -B */
/* Role: preprocessor: checks the rest of a directive line, skipping blanks, comments and
   line splices and reporting extra characters. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: one helper for the directive handlers in PREPROC.C, called
   once a directive's arguments have been read (after the file name of
   #include, the name of #undef, #ifdef and #ifndef, and after #else and
   #endif).  It reads the rest of the line, skipping blanks, comments and
   line splices, and stops in front of the line end.  Any other text is
   extra: in strict ANSI mode (LANGUAGE_MODE 1) it is reported as an
   illegal character; in every mode the rest of the line is then skipped
   with SCAN_FINISH. */
#include <dos.h>
#include "RTL.H"
#include "DATA.H"
#include "MSG.H"

/* ---- LEXPATH (listing DE75) ---- */
#include <dos.h>
extern unsigned int INPUT_INDEX; extern unsigned int INPUT_LIMIT;
extern signed char  LANGUAGE_MODE;
extern unsigned char far pascal INPUT_REFILL(void);
extern void far pascal COMMENT_BLOCK_BODY(void);
extern void far pascal COMMENT_LINE_BODY(void);
extern void far pascal LEX_NEWLINE(char);
extern void far pascal SCAN_FINISH(int);
#define GETBYTE (INPUT_INDEX>=INPUT_LIMIT ? INPUT_REFILL() : ((unsigned char far *)MK_FP(*(unsigned int near *)INPUT_BUFFER,0))[INPUT_INDEX++])
/* value is the first character after the directive's arguments. */
static void near pascal CHECK_DIRECTIVE_END(int value)
{
    for(;;) {
        switch(value) {
        case 10:case 13:
            --INPUT_INDEX;
            return;
        case 26:
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
        case 9:case 32:
            break;
        default:
            if(LANGUAGE_MODE==1) REPORT_ERROR(MSG_ILLEGAL_CHARACTER_0X,value,value);
            SCAN_FINISH(value);
            return;
        }
        value=GETBYTE;
    }
}
#undef GETBYTE
