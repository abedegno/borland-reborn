/* target: CODE_4_MSGGET */
/* opts: -mm -G- -O -Z -r- -p */
/* Role: diagnostics: returns the text of a message number from BCC's message table, loading
   its overlay image first. Map of all sources: docs/SOURCE-MAP.md. */
/* Overview: BCC's message texts are not in the data segment. They live in a separate
   loadable image (MESSAGES.C, described by BCC_MESSAGE_IMAGE) that the overlay
   manager brings into memory on demand: OVR_ENSURE_IMAGE_LOADED (overlay/OVRLOAD.ASM)
   loads it if needed and returns a far pointer to its start. The image starts with a
   table of word offsets, one per message number, so the text of message index is at
   segment of the image : table[index]. Called only by BCC_FORMAT_DIAGNOSTIC
   (DIAGFMT.C), which is built in the same object. */
#include <dos.h>
extern unsigned char far BCC_MESSAGE_IMAGE[];
extern unsigned int far * far pascal OVR_ENSURE_IMAGE_LOADED(void far *);
/* Returns a far pointer to the printf format text of message number index. The
   pointer is valid while the image stays loaded; the caller uses it at once. */
static char far * far pascal BCC_MESSAGE_TEXT(unsigned int index)
{
    unsigned int far *table;
    table=OVR_ENSURE_IMAGE_LOADED(BCC_MESSAGE_IMAGE);
    return (char far *)(((unsigned long)FP_SEG(table)<<16)|table[index]);
}
