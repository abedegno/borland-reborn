/* target: CODE_1_RSTRLOW */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Entry points: RTL_STRUPR. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: RTL_STRUPR is the C library's strupr: changes a far string to
   upper case in place, one character at a time through RTL_TOUPPER.  A
   NULL pointer is ignored.  Unlike the library version it returns
   nothing.  The module name RSTRLOW suggests strlwr but the code is
   strupr.  Callers: ADD_TRAILING_BACKSLASH (RADDSL.C), SEGNAMES and the
   preprocessor. */
extern unsigned int far pascal RTL_TOUPPER(int);
void far pascal RTL_STRUPR(char far *text)
{
    if (!text) return;
    while (*text) {
        *text=RTL_TOUPPER(*text);
        ++text;
    }
}
