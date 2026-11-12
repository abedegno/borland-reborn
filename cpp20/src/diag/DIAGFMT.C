/* target: DIAGFMT */
/* opts: -mm -G- -O -Z -p */
/* CPP.EXE module DIAGFMT (image 0x777A..0x7929, frame 0777h): one source file holding
   what the BCC.EXE reconstruction (bcc20/src/diag/) splits into four
   (DIAGFMT.C, FATAL.C, ERRREPT.C, WARNREPT.C), in that order. Each function body is
   BCC's, with CPP.EXE's differences marked "CPP.EXE edit".
   Why one file: the three reporters reach BCC_FORMAT_DIAGNOSTIC with a plain near call
   (E8, no relocation) inside frame 0777h, and BCC_FORMAT_DIAGNOSTIC is a near pascal
   function that no other module calls. In BCC.EXE the four files shared one named code
   segment; CPP.EXE has no such named code segments (every other C module has its own
   FILE_TEXT frame), so a near call between files is not possible and the static in
   one file is the plain reading. One descending relocation run covers the frame. */
/* Role: diagnostics: BCC_FORMAT_DIAGNOSTIC prints one message line: kind, file name, line
   number, message text with arguments, and the function name. REPORT_FATAL,
   REPORT_ERROR and REPORT_WARNING print through it, count, and stop processing the file
   when a fatal message or a limit says so. */
/* Overview: BCC_FORMAT_DIAGNOSTIC prints one message line (through RTL_DPRINTF), in the form
     Error foo.c 12: Undefined symbol 'x' in function main
   format is the prefix ("Fatal", "Error" or "Warning"), then come the current file name
   (CURRENT_FILE_NAME, an offset in the string pool; left out when 0), the line
   (LOGICAL_LINE, left out when 0), ": ", the message text formatted with the caller's
   printf arguments, and " in function name" when FUNCTION_NAME_TEXT is set.
   REPORT_FATAL ends the processing of the file (long jump with code 2 to ERROR_JUMP_BUFFER);
   REPORT_ERROR and REPORT_WARNING do so only when the error limit (-j) or warning limit
   (-g) is reached, after printing message 61 "Too many error or warning messages". */
#include <dos.h>
#include "DATA.H"
extern unsigned int STRING_POOL_SEG;
extern char far *FUNCTION_NAME_TEXT;
extern void far cdecl RTL_DPRINTF(char far *,...);
extern void far pascal RTL_DVPRINTF(char far *,char far *);
extern int DIAGNOSTIC_COUNT,ERROR_COUNT;
extern unsigned char ERROR_JUMP_BUFFER[];
extern void far pascal C45_LONGJUMP(void far *,int);
/* CPP.EXE edit: the message texts are not an overlay image read through BCC_MESSAGE_TEXT
   (MSGGET.C) but a table of near string pointers in DGROUP, indexed by message number
   (CPP DS:1B44, read as `mov bx,error; shl bx,1; push ds; push [bx+1B44h]`). The name is
   this file's. */
extern char near *MESSAGE_TEXT_TABLE[];

/* ---- BCC diag/DIAGFMT.C ---- */
/* format: the prefix word; arguments: pointer to the printf arguments on the caller's
   stack (a va_list); error: the message number. */
static void near pascal BCC_FORMAT_DIAGNOSTIC(char far *format,char far *arguments,unsigned int error)
{
    RTL_DPRINTF(format);
    if(CURRENT_FILE_NAME) RTL_DPRINTF(STR_FMT_SPACE_STRING,MK_FP(STRING_POOL_SEG,CURRENT_FILE_NAME));
    if(LOGICAL_LINE) RTL_DPRINTF(STR_FMT_SPACE_LONG,(long)LOGICAL_LINE);
    RTL_DPRINTF(STR_COLON_SPACE);
    RTL_DVPRINTF(MESSAGE_TEXT_TABLE[error],arguments);   /* CPP.EXE edit: see above */
    if(FUNCTION_NAME_TEXT) RTL_DPRINTF(STR_IN_FUNCTION,FUNCTION_NAME_TEXT);
    RTL_DPRINTF(STR_DIAG_NEWLINE);
}

/* ---- BCC diag/FATAL.C ---- */
#pragma option -G   /* BCC compiled FATAL.C and ERRREPT.C with -G, DIAGFMT.C and WARNREPT.C with -G-; CPP.EXE shows the same (add sp vs pop cx) */
/* error: message number (MSG.H); the printf arguments follow it on the stack, and
   arguments points at them (the cdecl varargs layout, without <stdarg.h>). The prefix is
   "Fatal" for message numbers 1 to 3 (internal failures such as "Register allocation
   failure") and "Error" for all others, as the code reads. */
void far cdecl REPORT_FATAL(int error,...)
{
    register int code=error;
    char far *arguments=(char far *)&error+sizeof(error);
    BCC_FORMAT_DIAGNOSTIC(code<4?STR_FATAL:STR_ERROR,arguments,code);
    ++ERROR_COUNT;
    ++DIAGNOSTIC_COUNT;
    C45_LONGJUMP(ERROR_JUMP_BUFFER,2);
}

/* ---- BCC diag/ERRREPT.C ---- */
/* REPORT_ERROR prints "Error file line: message" for message number error and counts it
   in ERROR_COUNT and DIAGNOSTIC_COUNT. When an error limit is set (OPTION_ERROR_LIMIT, the
   -j option) and reached, it also prints message 61 and long-jumps with code 2 to
   ERROR_JUMP_BUFFER. The printf arguments follow error on the stack; arguments points at
   them. */
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

/* ---- BCC diag/WARNREPT.C ---- */
#pragma option -G-
/* REPORT_WARNING prints "Warning file line: message" for message number error, but only
   when that warning is switched on (WARNING_ENABLED_TABLE, indexed by message number).
   Warnings count in DIAGNOSTIC_COUNT only, so DIAGNOSTIC_COUNT minus ERROR_COUNT is the
   number of warnings. When a warning limit is set (OPTION_WARNING_LIMIT, the -g option)
   and reached, message 61 is printed as an error and processing of the file ends through
   a long jump with code 2 to ERROR_JUMP_BUFFER. */
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
