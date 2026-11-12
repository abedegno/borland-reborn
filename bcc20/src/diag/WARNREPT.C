/* target: CODE_4_R5BED */
/* opts: -mm -G- -O -Z -p -u- -B */
/* Role: diagnostics: REPORT_WARNING prints a warning when that warning is enabled, counts
   it, and stops the compile when the warning limit is reached. Entry points:
   REPORT_WARNING. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: REPORT_WARNING prints "Warning file line: message" for message number
   error, but only when that warning is switched on (WARNING_ENABLED_TABLE, indexed by
   message number). Warnings count in DIAGNOSTIC_COUNT only, so DIAGNOSTIC_COUNT minus
   ERROR_COUNT is the number of warnings. When a warning limit is set
   (OPTION_WARNING_LIMIT, the -g option) and reached, message 61 "Too many error or
   warning messages" is printed as an error and the compile of the file ends through a
   long jump with code 2 to ERROR_JUMP_BUFFER (COMPILE_ONE_FILE in OPTIONS.C). */
#include "DATA.H"
extern int DIAGNOSTIC_COUNT,ERROR_COUNT;
extern unsigned char ERROR_JUMP_BUFFER[];
extern void near pascal BCC_FORMAT_DIAGNOSTIC(char far *,void far *,unsigned int);
extern void far pascal C45_LONGJUMP(void far *,int);
void far cdecl REPORT_WARNING(unsigned int error,...)
{
    char far *arguments;
    register unsigned int code=error;
    if(!WARNING_ENABLED_TABLE[code]) return;
    arguments=(char far *)&error+sizeof(error);
    BCC_FORMAT_DIAGNOSTIC(STR_WARNING,arguments,code);
    ++DIAGNOSTIC_COUNT;
    if(OPTION_WARNING_LIMIT && (int)OPTION_WARNING_LIMIT<=DIAGNOSTIC_COUNT-ERROR_COUNT) {
        BCC_FORMAT_DIAGNOSTIC(STR_ERROR,arguments,61);
        ++ERROR_COUNT;
        C45_LONGJUMP(ERROR_JUMP_BUFFER,2);
    }
}
