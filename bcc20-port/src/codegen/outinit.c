/* outinit.c: from bcc20/src/codegen/OUTINIT.C: run once before code generation starts.  It
   sets up the far pools the output side uses: code bytes, code fragments, segment data
   blocks and relocations, segment definitions and queued words, plus nine pools nothing
   else uses.  Each pool global is four words: segment, step, unit, used.  It also clears
   the segment list head, starts the debug type counter at 24, and opens either the assembly
   output (COMPILER_MODE set, -S) or the object file.  Bit 1 of CODE_OUTPUT_FLAGS is set
   when an object file name is given and an object file is really written. */
#include "port.h"
#include "data.h"
#include "protos.h"

#define COMPILER_MODE B(COMPILER_MODE_P)
#define OPTION_COMPILE_VIA_ASM B(OPTION_COMPILE_VIA_ASM_P)

/* step and unit set to amount, used cleared, the segment from POOL_INIT */
static void init_pool(farptr pool, u16 amount)
{
    W(fp_add(pool, 4)) = W(fp_add(pool, 2)) = amount;
    W(fp_add(pool, 6)) = 0;
    POOL_INIT(pool, amount);
}

/* initialises the code-output pools and globals and opens filename as the assembly or
   object output */
void INIT_CODEGEN_POOLS(farptr filename)
{
    init_pool(CODE_BYTE_POOL_SEG_P, 0);
    init_pool(CODE_FRAGMENT_POOL_SEG_P, 2);
    init_pool(SEG_DATA_BLOCK_POOL_SEG_P, 2);
    init_pool(RELOCATION_POOL_SEG_P, 2);
    init_pool(CODEGEN_UNUSED_POOL_ONE_P, 2);
    init_pool(CODEGEN_UNUSED_POOL_TWO_P, 2);
    init_pool(CODEGEN_UNUSED_POOL_THREE_P, 0);
    init_pool(CODEGEN_UNUSED_POOL_FOUR_P, 0);
    init_pool(CODEGEN_UNUSED_POOL_FIVE_P, 0);
    init_pool(CODEGEN_UNUSED_POOL_SIX_P, 0);
    init_pool(CODEGEN_UNUSED_POOL_SEVEN_P, 0);
    init_pool(CODEGEN_UNUSED_POOL_EIGHT_P, 0);
    init_pool(CODEGEN_UNUSED_POOL_NINE_P, 0);
    init_pool(SEGDEF_POOL_SEG_P, 2);
    init_pool(QUEUED_WORD_POOL_SEG_P, 0);
    DEBUG_TYPE_COUNTER = 24;
    RTL_MEMSET(SEGMENT_LIST_HEAD_P, 0, 28);
    if (D(OPTION_OBJECT_NAME_P) && (COMPILER_MODE == 0 || OPTION_COMPILE_VIA_ASM == 0))
        CODE_OUTPUT_FLAGS |= 1;
    if (COMPILER_MODE)
        CREATE_ASM_OUTPUT(filename);
    else
        OPEN_OUTPUT_FILE(filename);
}
