/* raddsl.c: from bcc20/src/rtl/RADDSL.C: makes a directory path ready for a file name to be
   appended: upper case (RTL_STRUPR), and a '\' added unless the path is empty or already
   ends in '\', '/' or ':'.  The buffer needs room for one more character.  Callers:
   segnames.c (the -n directory) and drvlink.c. */
#include "port.h"
#include "protos.h"

void ADD_TRAILING_BACKSLASH(farptr path)
{
    RTL_STRUPR(path);
    i16 length = (i16)STRING_LENGTH(path);
    farptr end = fp_add(path, length - 1);
    if (length > 0 && SB(end) != '\\' && SB(end) != '/' && SB(end) != ':') {
        B(fp_add(end, 1)) = '\\';
        B(fp_add(end, 2)) = 0;
    }
}
