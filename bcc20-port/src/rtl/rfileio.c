/* rfileio.c: from bcc20/src/rtl/RFILEIO.C: BCC's one buffered output file, used for the
   assembler output (asmtext.c, asmcode.c) and the linker response file (drvlink.c).  Only
   one is open at a time: OUTPUT_FILE_HANDLE is its DOS handle (-1 when none),
   OUTPUT_BUFFER_SEG the segment of a 4096-byte buffer from the far heap, OUTPUT_BUFFER_FILL
   the bytes in the buffer.  A write error is fatal (MSG_ERROR_WRITING_OUTPUT);
   DISCARD_OUTPUT_FILE deletes the file named by ASM_OUTPUT_PATH, whichever file is open.
   A tiny stand-in for stdio's fopen, fputc, fputs and fclose. */
#include "port.h"
#include "data.h"
#include "protos.h"
#include "msg.h"
#include "variadic.h"

#define STRING_POOL_SEG W(STRING_POOL_SEG_P)
#define CURRENT_OWNER_TAG B(CURRENT_OWNER_TAG_P)
#define BUFFER MK_FP(OUTPUT_BUFFER_SEG, 0)

/* creates name for writing and sets up the buffer, allocated under CURRENT_OWNER_TAG (the
   default owner tag is switched for the POOL_INIT call and put back).  The handle, or -1
   if the file could not be created; the buffer is set up either way */
i16 CREATE_OUTPUT_FILE(farptr name)
{
    OUTPUT_FILE_HANDLE = RTL_CREAT(name, 0);
    u8 saved = GET_DEFAULT_OWNER_TAG();
    SET_DEFAULT_OWNER_TAG(CURRENT_OWNER_TAG);
    POOL_INIT(OUTPUT_BUFFER_SEG_P, 4096);
    SET_DEFAULT_OWNER_TAG(saved);
    OUTPUT_BUFFER_FILL = 0;
    return OUTPUT_FILE_HANDLE;
}

/* a 0-terminated string to the output file (like fputs) */
void BCC_OUTPUT_STRING(farptr text)
{
    while (SB(text)) {
        i8 c = SB(text);
        text = fp_add(text, 1);
        OUTPUT_CHAR(c);
    }
}

/* one character into the buffer (like fputc), writing the buffer when it holds 4096
   bytes; a short write empties the buffer and is fatal */
void OUTPUT_CHAR(i8 value)
{
    B(fp_add(BUFFER, OUTPUT_BUFFER_FILL)) = (u8)value;
    ++OUTPUT_BUFFER_FILL;
    if (OUTPUT_BUFFER_FILL >= 4096) {
        if (RTL_WRITE(OUTPUT_FILE_HANDLE, BUFFER, 4096) != 4096) {
            OUTPUT_BUFFER_FILL = 0;
            REPORT_FATAL(MSG_ERROR_WRITING_OUTPUT);
        }
        OUTPUT_BUFFER_FILL = 0;
    }
}

/* writes what is left, frees the buffer, closes the file and marks it closed; a failed
   write is reported, fatally, only after the close.  Nothing when no file is open */
void CLOSE_OUTPUT_FILE(void)
{
    if (OUTPUT_FILE_HANDLE < 0)
        return;
    i16 error = OUTPUT_BUFFER_FILL ? (u16)RTL_WRITE(OUTPUT_FILE_HANDLE, BUFFER, OUTPUT_BUFFER_FILL) != OUTPUT_BUFFER_FILL : 0;
    FREE_HANDLE_BLOCK(OUTPUT_BUFFER_SEG_P);
    RTL_CLOSE(OUTPUT_FILE_HANDLE);
    OUTPUT_FILE_HANDLE = -1;
    if (error)
        REPORT_FATAL(MSG_ERROR_WRITING_OUTPUT);
}

/* abandons the open output file: closes it unwritten, frees the buffer and deletes the
   file at ASM_OUTPUT_PATH (used when compilation is interrupted) */
void DISCARD_OUTPUT_FILE(void)
{
    if (OUTPUT_FILE_HANDLE < 0)
        return;
    RTL_CLOSE(OUTPUT_FILE_HANDLE);
    FREE_HANDLE_BLOCK(OUTPUT_BUFFER_SEG_P);
    OUTPUT_FILE_HANDLE = -1;
    DELETE_FILE(MK_FP(STRING_POOL_SEG, ASM_OUTPUT_PATH));
}
