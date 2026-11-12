/* target: CODE_1_RPUTS */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: WRITE_STDOUT_STRING. Map of all sources:
   docs/SOURCE-MAP.md. */
/* Overview: WRITE_STDOUT_STRING writes a NUL-terminated string to DOS
   handle 1 (standard output) with RTL_WRITE, adding no newline and
   ignoring errors; roughly fputs(text,stdout) without buffering.  Used for
   the version banner (RMAIN13C), the usage text (USAGE) and driver
   messages (DRVLINK). */
extern unsigned int far pascal STRING_LENGTH(char far *);
extern int far pascal RTL_WRITE(unsigned int,char far *,unsigned int);
void far pascal WRITE_STDOUT_STRING(char far *text)
{
    RTL_WRITE(1,text,STRING_LENGTH(text));
}
