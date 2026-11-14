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
typedef i16 __attribute__((aligned(1), may_alias)) i16u;
typedef i32 __attribute__((aligned(1), may_alias)) i32u;

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
#define SW(p) (*(i16u *)at(p))
#define D(p) (*(u32u *)at(p))
#define SD(p) (*(i32u *)at(p))

/* Locals whose address is taken (passed to another function as a far pointer) live in a
   scratch area of the address space, since the host stack is not in it.  SCRATCH(n) gives n
   bytes there; scratch_mark()/scratch_release() free everything given since the mark (a
   function marks on entry and releases before it returns).  Replay maps the original's stack
   addresses onto these (replay.c). */
#define SCRATCH_SEG 0xF000
farptr scratch_alloc(u16 bytes);
u16 scratch_mark(void);
void scratch_release(u16 mark);

/* An argument the original passes from a local it never set (a stack slot holding whatever
   an earlier call left there) cannot be reproduced.  UNSET_ARGS(mask) before a call of a
   stand-in says which of its arguments (bit 0 the first) are such: replay does not compare
   them, and the mask is cleared by that call.  The translation passes 0 for them. */
extern u32 unset_args;
#define UNSET_ARGS(mask) (unset_args = (mask))

/* The same for a local in the scratch area that the original never sets before a stand-in
   reads it: UNSET_BYTES(p, n) says its n bytes hold whatever the original's stack held, so
   replay does not compare that stand-in read.  It lasts until the scratch is released. */
void UNSET_BYTES(farptr p, u16 n);
int scratch_unset(u16 offset);

/* Memory that receives such an unset value (stored by a translated callee): UNSET_RESULT(p,
   n) says its n bytes end the call holding whatever the original's stack held, so replay
   does not compare them.  The marks last until the next replayed call. */
void UNSET_RESULT(farptr p, u16 n);
int result_unset(u32 linear);
void unset_results_clear(void);

/* the data segment's paragraph from the load segment, for turning code addresses back
   into names (calls.h) */
#define DGROUP_PARA 0x0DEF

#endif
