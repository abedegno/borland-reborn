/* port.h: the machine model of the port's first stage.

   In this stage the port keeps BCC's memory exactly as the DOS program laid it out: one
   flat array stands for the 8086's address space, a far pointer is a 32-bit segment:offset
   value, and BCC's data stays at its own offsets.  That is what lets a translated function
   be run from a state recorded in Borland's BCC.EXE and compared with what BCC.EXE did
   (replay/replay.c).  The second stage replaces this model with host data structures.

   Hosts must be little-endian, as the 8086 is. */
#ifndef PORT_H
#define PORT_H

#include <stdint.h>
#include <string.h>

typedef uint8_t u8;
typedef int8_t i8;
typedef uint16_t u16;
typedef int16_t i16;
typedef uint32_t u32;
typedef int32_t i32;

/* a word that may sit at an odd address and alias any other type */
typedef u16 __attribute__((aligned(1), may_alias)) u16u;
typedef u32 __attribute__((aligned(1), may_alias)) u32u;

/* the 8086 address space: 1 MB, plus 64 KB past the end for segment:offset values that run
   beyond it (BCC never relies on wrapping at 1 MB) */
#define MEM_SIZE (0x100000 + 0x10000)
extern u8 *mem;

/* far pointers: segment in the high word, offset in the low word, as LES/LDS load them */
typedef u32 farptr;
#define MK_FP(s, o) (((farptr)(u16)(s) << 16) | (u16)(o))
#define FP_SEG(p) ((u16)((p) >> 16))
#define FP_OFF(p) ((u16)(p))
#define LIN(s, o) (((u32)(u16)(s) << 4) + (u16)(o))

static inline u8 *at(farptr p) { return mem + LIN(FP_SEG(p), FP_OFF(p)); }

/* far pointer arithmetic changes only the offset, which wraps inside its segment, as on the
   8086; never add to a farptr directly (that would carry into the segment) */
static inline farptr fp_add(farptr p, i16 n) { return MK_FP(FP_SEG(p), FP_OFF(p) + n); }

/* the byte, word and doubleword at a far pointer, as lvalues */
#define B(p) (*at(p))
#define SB(p) (*(i8 *)at(p))
#define W(p) (*(u16u *)at(p))
#define D(p) (*(u32u *)at(p))

#endif
