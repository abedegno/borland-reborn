/* image.h: the parts of BCC.EXE's program image the native build reads (image.c, generated
   by tools/genimage.py) */
#ifndef IMAGE_H
#define IMAGE_H
#include "port.h"

typedef struct {
    u16 para;               /* where it lies in the load module, in paragraphs */
    const u8 *bytes;
    u32 size;
    const u16 *relocs;      /* offsets of the segment words in it to relocate, ended by FFFFh */
} ImagePart;

typedef struct {
    u32 offset;             /* in the overlay area, after its "FBOV" header */
    const u8 *bytes;
    u16 size;
} ImageOverlay;

extern const ImagePart IMAGE_PARTS[];
extern const ImageOverlay IMAGE_OVERLAYS[];
#endif
