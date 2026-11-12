/* target: ovr112_FILETIME */
/* opts: -mm -G -O -Z -p */
/* Role: run-time library: returns a file's DOS date and time stamp through findfirst, or 0;
   used by precompiled headers and object output. Entry points: FILE_TIME. Map of all
   sources: docs/SOURCE-MAP.md. */
/* Overview: one small helper.  FILE_TIME looks the file up with FINDFIRST
   (RFFIND.C, DOS findfirst) and returns the DOS time and date words of the
   ffblk as one long: ff_ftime in the low word and ff_fdate, which follows
   it in struct ffblk, in the high word.  0 means the file was not found.
   The object writer (output/OMFWRITE.C) and the assembler text writer
   (output/ASMTEXT.C) record the stamp of files they name; DRVLINK uses
   a nonzero result as an existence test.  It is like Turbo C's getftime,
   but takes a path instead of an open handle. */

#include <dir.h>
#include "RTL.H"


long far pascal FILE_TIME(char far *path)
{
    struct ffblk info;
    if (FINDFIRST(path, &info, 0) == 0)
        return *(long *)&info.ff_ftime;
    return 0L;
}
