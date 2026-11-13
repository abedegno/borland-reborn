/* longops.h: Borland's long arithmetic helpers as the original runs them, where C's own
   operators differ or are undefined: shifts by Borland's F_LXLSH@, F_LXRSH@ and F_LXURSH@
   (DX:AX by CL, the 80186 taking 16-bit shift counts modulo 32, as emu2 does), and signed
   division where the host could trap. */
#ifndef PORT_LONGOPS_H
#define PORT_LONGOPS_H
#include "port.h"

static inline u16 shl16(u16 v, u8 c) { c &= 31; return c >= 16 ? 0 : (u16)(v << c); }
static inline u16 shr16(u16 v, u8 c) { c &= 31; return c >= 16 ? 0 : (u16)(v >> c); }
static inline u16 sar16(u16 v, u8 c) { c &= 31; return (u16)((i16)v >> (c >= 16 ? 15 : c)); }

/* value << cl (F_LXLSH@) */
static inline i32 long_shl(i32 value, u8 cl)
{
    u16 ax = (u16)value, dx = (u16)((u32)value >> 16);
    if (cl < 16) {
        u16 bx = ax;
        ax = shl16(ax, cl);
        dx = shl16(dx, cl) | shr16(bx, (u8)(16 - cl));
    } else {
        dx = shl16(ax, (u8)(cl - 16));
        ax = 0;
    }
    return (i32)((u32)dx << 16 | ax);
}

/* value >> cl, arithmetic (F_LXRSH@) or logical (F_LXURSH@) */
static inline i32 long_shr(i32 value, u8 cl, int is_unsigned)
{
    u16 ax = (u16)value, dx = (u16)((u32)value >> 16);
    if (cl < 16) {
        u16 bx = dx;
        ax = shr16(ax, cl);
        dx = is_unsigned ? shr16(dx, cl) : sar16(dx, cl);
        ax |= shl16(bx, (u8)(16 - cl));
    } else {
        ax = is_unsigned ? shr16(dx, (u8)(cl - 16)) : sar16(dx, (u8)(cl - 16));
        dx = is_unsigned ? 0 : (u16)((i16)dx >> 15);
    }
    return (i32)((u32)dx << 16 | ax);
}

/* signed long division and remainder: the most negative value by -1 gives itself,
   remainder 0, as Borland's helpers do; division by 0 is never reached in the original
   (its callers test first) and gives 0 here */
static inline i32 long_div(i32 a, i32 b) { return !b ? 0 : (a == INT32_MIN && b == -1) ? a : a / b; }
static inline i32 long_mod(i32 a, i32 b) { return !b ? 0 : (a == INT32_MIN && b == -1) ? 0 : a % b; }

#endif
