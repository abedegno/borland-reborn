/* target: CODE_1_RARGV0F0 */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: an early command-line scan made before the memory manager
   starts.  RMAIN13C (driver/RMAIN13C.C) first sets HEAP_SIZE_PARAS to the
   whole heap area and then calls RARGV0F0 with argv.  Every argument that
   starts with "-#" sets HEAP_SIZE_PARAS to the number after it (read with
   RTL_ATOL, so decimal, and cut to 16 bits); a later one wins.
   INIT_MEMORY_MANAGER (heap/MEMINIT.C) then uses HEAP_SIZE_PARAS as the
   heap size in paragraphs under plain DOS.  The -# option is probably a
   hidden debugging or tuning switch.  The function is static and is
   called from RMAIN13C through the build's context mechanism. */
#include "DATA.H"
extern long far pascal RTL_ATOL(char far *);
/* argv is the NULL-terminated far argument vector.  The two text++ in the
   test step past "-" and "#", so text is left at the number. */
static void far pascal RARGV0F0(char far * far *argv)
{
    char far *text;
    while ((text = *argv++) != 0) {
        if (*text++ == '-' && *text++ == '#')
            HEAP_SIZE_PARAS = RTL_ATOL(text);
    }
}
