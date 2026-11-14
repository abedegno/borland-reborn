/* filetime.c: from bcc20/src/rtl/FILETIME.C: the DOS time stamp of a file, the time and
   date words of its find record (FINDFIRST) as one long (time low, date high); 0 when the
   file is not found.  Used for the precompiled-header dependencies and the object file's
   dependency records.  The 43-byte find record sits at bp-2Ch in BCC's frame. */
#include "port.h"
#include "protos.h"

i32 FILE_TIME(farptr path)
{
    u16 mark = scratch_mark();
    farptr info = scratch_alloc(0x2C);
    i32 time = 0;
    if (FINDFIRST(path, info, 0) == 0)
        time = (i32)D(fp_add(info, 22));     /* ff_ftime, then ff_fdate */
    scratch_release(mark);
    return time;
}
