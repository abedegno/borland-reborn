/* target: TRUNCVAL */
/* opts: -mm -G- -O -Z -p -B */
/* CPP.EXE module TRUNCVAL (image 0x4754..0x4850, frame 0475h): source taken unchanged
   from the BCC.EXE reconstruction (bcc20/src/expr/TRUNCVAL.C); its code
   is the same in both programs. The function's switch table follows it, so the module
   is 0xFC bytes. */
/* Role: expressions: truncates a long constant to a given width, with or without sign
   extension, using the int, char and long masks. Entry point: CODE_MASK (public: called
   far from SIMPLIFY, EXPRDISP, OPPREC and LEXER). */
/* Overview: CODE_MASK cuts a long constant down to the width of a smaller integer type,
   as storing it into that type would, probably for the constant folder when it converts
   a constant. The masks are globals set up for the target: INT_LIMIT for int (probably
   0xFFFF), MASK_B for char (probably 0xFF) and MASK_C for long. For the signed modes the
   top bit of the masked value is copied into all higher bits (sign extension): the test
   value & ((mask + 1) >> 1) picks out that top bit. */

#include "DATA.H"
extern long MASK_C;

/* CODE_MASK: mode 1 signed int, 2 unsigned int, 3 signed char, 4 unsigned char, 5 signed
   long, 6 unsigned long; any other mode returns the value unchanged. */
/* CPP.EXE edit: public here; CPP's SIMPLIFY calls it by far call (CPP 0475:0004), where BCC
   reaches it through the TOKEN_CONVERT pointer. Same code either way. */
long far pascal CODE_MASK(long value, unsigned char mode)
{
    switch (mode) {
    case 1:
        value &= INT_LIMIT;
        if (value & ((INT_LIMIT + 1) >> 1)) {
            value |= ~INT_LIMIT;
        }
        break;
    case 2:
        value &= INT_LIMIT;
        break;
    case 3:
        value &= MASK_B;
        if (value & ((MASK_B + 1) >> 1)) {
            value |= ~MASK_B;
        }
        break;
    case 4:
        value &= MASK_B;
        break;
    case 5:
        value &= MASK_C;
        if (value & ((MASK_C + 1) >> 1)) {
            value |= ~MASK_C;
        }
        break;
    case 6:
        value &= MASK_C;
        break;
    }
    return value;
}
