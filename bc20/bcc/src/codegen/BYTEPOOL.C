/* target: ovr149_C221UNIT */
/* Role: code generation: the data byte pool: appends bytes and merges a byte string with an
   earlier identical copy (probably string literals). Entry points: BYTE_POOL_LENGTH,
   EMIT_VALUE, MERGE_DUPLICATE_BYTES. Map of all sources: docs/SOURCE-MAP.md. */
/* Original CO05A (ovr_1d64_a3bb) as one source. */
/* opts: -mm -O -Z -p -Y -y -B */
/* Overview: the data byte pool, a far pool (DATA_BYTE_POOL_SEG, its length in
   DATA_BYTE_POOL_LENGTH) that collects data bytes one at a time. EMIT_VALUE appends a byte
   (INITDATA.C uses it for initialisers in 'direct' mode); after a byte string has been
   appended, MERGE_DUPLICATE_BYTES looks for an identical earlier copy in the pool and, if
   there is one, drops the new copy and returns the old offset, so identical strings are
   stored once. The callers are the string-literal code (lexer/STRLIT.C, only with the
   merge-duplicate-strings option -d) and expr/EXPRPARS.C.
   The file is compiled with -B: MERGE_DUPLICATE_BYTES has inline assembler. */
#include <dos.h>
#include "DATA.H"



/* ---- STAOV068 (listing ovr_1d64_a3bb:3BB0) ---- */

/* BYTE_POOL_LENGTH: returns the number of bytes in the data byte pool, which is also the
   offset the next byte will get. */
unsigned int far pascal BYTE_POOL_LENGTH(void)
{
    return DATA_BYTE_POOL_LENGTH;
}

/* ---- STAOV069 (listing ovr_1d64_a3bb:3BB8) ---- */
extern unsigned int far POOL_ALLOC(unsigned int far *pool, unsigned int size);
extern unsigned int DATA_BYTE_POOL_SEG;

/* EMIT_VALUE: appends one byte to the data byte pool. */
void far pascal EMIT_VALUE(char value)
{
    register unsigned int position;

    position = POOL_ALLOC(&DATA_BYTE_POOL_SEG, 1);
    *(char far *)MK_FP(DATA_BYTE_POOL_SEG, position) = value;
}

/* ---- STAOV06A (listing ovr_1d64_a3bb:3BDB) ---- */
extern unsigned int DATA_BYTE_POOL_SEG;

/* Look the byte string at offset `value` in segment DATA_BYTE_POOL_SEG up among the
   bytes before it (it ends at DATA_BYTE_POOL_LENGTH).  If an earlier copy exists, the
   pool is cut back to `value` (DATA_BYTE_POOL_LENGTH = value, DATA_BYTE_POOL_WORD6 = 0) and the
   copy's offset is returned; otherwise `value` is returned.

   The search is inline asm in the original C file: the file went through
   TASM (-B), shown by the jmp short + nop at 3BFA, which TASM leaves for
   the forward jmp BCC emits past the asm block.  It scans with repne scasb for the
   first byte and confirms the rest with repe cmpsb, with DS pointing at the
   pool. */
unsigned int far pascal MERGE_DUPLICATE_BYTES(unsigned int value)
{
    unsigned int remaining;
    unsigned int length;
    unsigned int result;

    /* remaining: the string's length, then (after --) the bytes cmpsb
       compares after the first; length: the start positions scasb tries */
    remaining = DATA_BYTE_POOL_LENGTH - value;
    /* Nothing to merge with when the new string is empty or longer than all the bytes before
       it. */
    if (value < remaining || remaining == 0) return value;
    --remaining;
    length = value - remaining;
    asm push ds;
    asm cld;
    asm mov es,word ptr DGROUP:DATA_BYTE_POOL_SEG;
    asm xor di,di;
    asm mov si,value;
    asm mov ds,word ptr DGROUP:DATA_BYTE_POOL_SEG;
    asm mov cx,length;
    asm lodsb;
search:
    asm repne scasb;
    asm jne failed;
    asm mov dx,cx;
    asm mov cx,remaining;
    asm jcxz found;
    asm mov bx,di;
    asm push si;
    asm repe cmpsb;
    asm pop si;
    asm mov di,bx;
    asm mov cx,dx;
    asm jne search;
found:
    asm dec di;
    asm mov result,di;
    asm pop ds;
    DATA_BYTE_POOL_WORD6 = 0;
    DATA_BYTE_POOL_LENGTH = value;
    return result;
failed:
    asm pop ds;
    return value;
}
