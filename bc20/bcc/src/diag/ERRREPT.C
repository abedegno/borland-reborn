/* target: CODE_4_R5B8B */
/* opts: -mm -G -O -Z -p -B */
/* Role: diagnostics: REPORT_ERROR prints an error message, counts it, and stops the compile
   through a long jump when the error limit is reached. Entry points: REPORT_ERROR. Map of
   all sources: docs/SOURCE-MAP.md. */
/* Overview: REPORT_ERROR prints "Error file line: message" for message number error
   (through BCC_FORMAT_DIAGNOSTIC in DIAGFMT.C) and counts it in ERROR_COUNT and
   DIAGNOSTIC_COUNT. When an error limit is set (OPTION_ERROR_LIMIT, the -j option) and
   reached, it also prints message 61 "Too many error or warning messages" and long-jumps
   with code 2 to ERROR_JUMP_BUFFER, which ends the compile of the file (COMPILE_ONE_FILE
   in OPTIONS.C). Driver code that must always show a message sets the limits to 0 first.
   The printf arguments follow error on the stack; arguments points at them. */
#include "DATA.H"
extern int DIAGNOSTIC_COUNT,ERROR_COUNT;
extern unsigned char ERROR_JUMP_BUFFER[];
extern void near pascal BCC_FORMAT_DIAGNOSTIC(char far *,char far *,unsigned int);
extern void far pascal C45_LONGJUMP(void far *,int);
void far cdecl REPORT_ERROR(int error,...)
{
    char far *arguments=(char far *)&error+sizeof(error);
    BCC_FORMAT_DIAGNOSTIC(STR_ERROR,arguments,error);
    ++ERROR_COUNT;
    ++DIAGNOSTIC_COUNT;
    if(OPTION_ERROR_LIMIT && (int)OPTION_ERROR_LIMIT<=ERROR_COUNT) {
        BCC_FORMAT_DIAGNOSTIC(STR_ERROR,arguments,61);
        ++ERROR_COUNT;
        C45_LONGJUMP(ERROR_JUMP_BUFFER,2);
    }
}
