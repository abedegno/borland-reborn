/* target: ovr105_C138UNIT */
/* opts: -mm -O- -Z -p -Y -y -B */
/* Role: lexer: comment skipping (block and line comments) in the input buffer, written as
   inline assembly. Entry points: COMMENT_BLOCK, COMMENT_LINE, SCAN_EMPTY. Map of all
   sources: docs/SOURCE-MAP.md. */

/* Overview: the lexer calls these when it has just read the opening
   "/" + "*" of a block comment or the two slashes of a line comment (LEX_NEXT_TOKEN
   and READ_MACRO_ARGUMENT in LEXER.C, and the directive-line scanners in
   src/preproc).  They read on through the current input buffer, refilling
   it with INPUT_REFILL as needed (which returns the next byte in AL, like
   the lexer's GETBYTE macro), and stop just after the comment.  Line ends
   inside a block comment are counted through LEX_NEWLINE so line numbers
   stay right; a line comment stops in front of its line end and leaves it
   for the caller.  Nested block comments are honoured only when
   COMMENT_NESTED is set (the -C option).  Byte 26 (Ctrl-Z) is the
   end-of-input marker; reaching it reports error 41 with the line the
   comment began on.  SCAN_EMPTY is an empty function from the same
   source, probably a placeholder hook. */
/* ---- LEXCBLK (listing E0B3) ---- */
#include "RTL.H"
#include "DATA.H"
extern unsigned char far pascal INPUT_REFILL(void);
extern void far pascal LEX_NEWLINE(char);
extern unsigned int  INPUT_INDEX;
extern unsigned int  INPUT_LIMIT;

/* COMMENT_BLOCK and COMMENT_LINE skip a comment in the input buffer.  Both
   are hand-written assembly inside this C file (the compiler supplies only
   the frame and the SI/DI saves).  The file went through TASM (-B): the
   jmp short + nop before refill_scan (the jump to done) is TASM's.  While
   scanning, DS points at the input buffer's segment and ES at DGROUP.  BX
   holds the line the comment started on, and in COMMENT_BLOCK CX counts
   nested comment levels.  Error 41 is "Unexpected end of file in comment
   started on line %d" (BCC's message table), so BX is pushed as its
   argument. */
/* Skips a block comment.  Called after the opening delimiter; returns with
   INPUT_INDEX just past the closing one.  A "/" followed by "*" inside the
   comment raises the nesting count CX only if COMMENT_NESTED is set; each
   closing delimiter lowers it, and the comment ends when it goes below
   zero. */
void far pascal COMMENT_BLOCK(void)
{
    asm mov bx,word ptr DGROUP:CURRENT_LINE;
    asm xor cx,cx;
reload:
    asm push ds;
    asm pop es;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    asm mov dx,word ptr DGROUP:INPUT_LIMIT;
    asm mov di,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [di];
    asm cld;
scan:
    asm cmp si,dx;
    asm jnc refill_scan;
    asm lodsb;
character:
    asm cmp al,'*';
    asm je possible_end;
    asm cmp al,'/';
    asm je possible_nested;
    asm cmp al,26;
    asm je unexpected_eof;
    asm cmp al,13;
    asm je newline;
    asm cmp al,10;
    asm jne scan;
newline:
    asm push es;
    asm pop ds;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm push bx;
    asm push cx;
    asm cbw;
    asm push ax;
    asm call far ptr LEX_NEWLINE;
    asm pop cx;
    asm pop bx;
    asm jmp reload;
possible_end:
    asm cmp si,dx;
    asm jnc refill_end;
    asm lodsb;
end_character:
    asm cmp al,'/';
    asm jne character;
    asm dec cx;
    asm jge scan;
    asm push es;
    asm pop ds;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm jmp done;
refill_scan:
    asm call refill_sub;
    asm jmp character;
refill_end:
    asm call refill_sub;
    asm jmp end_character;
refill_nested:
    asm call refill_sub;
    asm jmp nested_character;
possible_nested:
    asm cmp byte ptr es:[offset DGROUP:COMMENT_NESTED],0;
    asm je scan;
    asm cmp si,dx;
    asm jnc refill_nested;
    asm lodsb;
nested_character:
    asm cmp al,'*';
    asm jne character;
    asm inc cx;
    asm jmp scan;
    /* refill_sub names the subroutine for the near calls above: BCC maps
       C labels only in jump instructions, so a call needs an asm label. */
    asm refill_sub label near;
    /* near subroutine: save the position, refill, reload the registers */
    asm push es;
    asm pop ds;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm push bx;
    asm push cx;
    asm call far ptr INPUT_REFILL;
    asm pop cx;
    asm pop bx;
    asm push ds;
    asm pop es;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    asm mov dx,word ptr DGROUP:INPUT_LIMIT;
    asm mov di,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [di];
    asm cld;
    asm retn;
unexpected_eof:
    asm push es;
    asm pop ds;
    asm push bx;
    asm mov ax,41;
    asm push ax;
    asm call far ptr REPORT_ERROR;
    asm pop cx;
    asm pop cx;
done:
    ;
}

/* ---- LEXCLIN (listing E166) ---- */
/* Skips a line comment (two slashes) up to, but not including, the line end. */
void far pascal COMMENT_LINE(void)
{
    asm mov bx,word ptr DGROUP:CURRENT_LINE;
    asm push ds;
    asm pop es;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    asm mov dx,word ptr DGROUP:INPUT_LIMIT;
    asm mov di,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [di];
    asm cld;
scan:
    asm cmp si,dx;
    asm jnc refill;
    asm lodsb;
character:
    asm cmp al,26;
    asm je unexpected_eof;
    asm cmp al,13;
    asm je newline;
    asm cmp al,10;
    asm jne scan;
newline:
    /* leave the newline in the buffer for the caller */
    asm push es;
    asm pop ds;
    asm dec si;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm jmp short done;
refill:
    asm push es;
    asm pop ds;
    asm mov word ptr DGROUP:INPUT_INDEX,si;
    asm push bx;
    asm call far ptr INPUT_REFILL;
    asm pop bx;
    asm push ds;
    asm pop es;
    asm mov si,word ptr DGROUP:INPUT_INDEX;
    asm mov dx,word ptr DGROUP:INPUT_LIMIT;
    asm mov di,word ptr DGROUP:INPUT_BUFFER;
    asm mov ds,word ptr [di];
    asm cld;
    asm jmp character;
unexpected_eof:
    asm push es;
    asm pop ds;
    asm push bx;
    asm mov ax,41;
    asm push ax;
    asm call far ptr REPORT_ERROR;
    asm pop cx;
    asm pop cx;
done:
    ;
}

/* ---- LEXNONE (listing E1CC) ---- */
/* Does nothing; value is ignored.  Probably installed where a scanner
   hook must be called but no work is needed. */
void far pascal SCAN_EMPTY(int value)
{
}
