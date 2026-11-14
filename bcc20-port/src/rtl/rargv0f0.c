/* rargv0f0.c: from bcc20/src/rtl/RARGV0F0.C: every argument that starts with "-#" sets
   HEAP_SIZE_PARAS (the heap size in paragraphs INIT_MEMORY_MANAGER uses under plain DOS)
   to the decimal number after it, cut to 16 bits; a later one wins.  RMAIN13C calls it with
   argv after setting HEAP_SIZE_PARAS to the whole heap area.  Probably a hidden tuning
   switch. */
#include "port.h"
#include "data.h"
#include "protos.h"

void RARGV0F0(farptr argv)
{
    for (;;) {
        farptr text = D(argv);
        argv = fp_add(argv, 4);
        if (text == 0)
            break;
        if (SB(text) == '-' && SB(fp_add(text, 1)) == '#')
            HEAP_SIZE_PARAS = (u16)RTL_ATOL(fp_add(text, 2));
    }
}
