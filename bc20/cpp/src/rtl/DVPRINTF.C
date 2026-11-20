/* target: DVPRINTF */
/* compiler: TC201 */
/* opts: -mm -G -O -Z -p */
/* CPP.EXE module DVPRINTF (11AF:0004..028A): the small console printf, RTL_DPRINTF and
   RTL_DVPRINTF, from the BCC.EXE reconstruction's rtl/DPRINTF.C and rtl/DVPRINTF.C joined
   into one file and compiled directly by Turbo C 2.01 (BCC's reconstruction compiles
   DVPRINTF.C through TASM because of `asm int 21h`).
   link: one file, not two: CPP.EXE's relocation table lists the four relocations of the
   pair as one descending run, DVPRINTF's three (11AF:020C, 0162, 0148) before DPRINTF's
   call (11AF:0024), which is what one directly compiled Turbo C object gives (TASM objects
   and two objects give other orders; tested).  In one directly compiled file the call from
   RTL_DPRINTF to RTL_DVPRINTF, defined later, stays a far call, as in CPP.EXE.
   CPP.EXE edit: geninterrupt(0x21) for BCC's `asm int 21h`, and three documented match
   barriers (see PUT('0')). */

/* ---- RTL_DPRINTF, from rtl/DPRINTF.C ---- */
/* Role: run-time library: dprintf (Turbo C 2.01), builds the argument list by hand and
   passes it to the small console printf RTL_DVPRINTF. Entry points: RTL_DPRINTF. */
/* Overview: the front end of the small console printf.  RTL_DPRINTF is
   the only cdecl, variable-argument function of the pair: it works out
   where the arguments after format start on the stack and passes format
   and that address to RTL_DVPRINTF (DVPRINTF.C), which does all the
   formatting and writes the characters through DOS function 02h.  The
   closest standard functions are printf and vprintf, but only %d, %x, %c
   and %s (with an l prefix for long) are understood and nothing goes
   through stdio.  Callers in CPP.EXE: the diagnostic printer in
   diag/DIAGFMT.C (file name, line number and message of each error or
   warning), the driver's error total in DRVLINK.C, and CPPMAIN.C (the
   available-memory line).  Nothing here has state. */
/* Borland run-time library (Turbo C 2.01):
   void cdecl dprintf(char far *format, ...): passes the argument list to the
   console printf RTL_DVPRINTF (DVPRINTF). */
extern void far pascal RTL_DVPRINTF(char far *format,char far *args);

void far cdecl RTL_DPRINTF(char far *format,...)
{
    char far *args;
    /* va_start by hand: Turbo C 2.01's medium-model va_list is a near
       pointer, but RTL_DVPRINTF takes a far one (ss-relative lea). */
    args=(char far *)(&format+1);
    RTL_DVPRINTF(format,args);
}

/* ---- RTL_DVPRINTF, from rtl/DVPRINTF.C ---- */
/* Role: run-time library: RTL_DVPRINTF, a small console printf with pascal calling: %d, %x,
   %c and %s with an l modifier; a newline prints CR LF; an unknown conversion ends the
   output. Entry points: RTL_DVPRINTF. */
/* Overview: the formatter behind RTL_DPRINTF; diag/DIAGFMT.C also calls it
   directly with the argument list of a message.  RTL_DVPRINTF reads format
   once.  Ordinary characters go straight to the console through DOS
   function 02h (PUT), and a '\n' is preceded by '\r'.  At each '%' it
   takes the value from args, a far pointer that steps over the caller's
   stack words (2 bytes for an int, 4 for a long or a far pointer).
   Conversions: %d and %x (int, or long after l), %c, and %s (a far string).
   There are no widths, flags or precision.  Numbers are built backward, last
   digit first, in the local digits[] buffer, with p moving down from its
   end.  A conversion character with no case leaves the switch, which ends
   the whole function: the rest of the format is not printed.  This is
   roughly vprintf for a tiny subset, writing unbuffered to DOS. */
/* Compiled C, built by Turbo C 2.01 (the far-pointer copies through es:bx and the
   mov bx,ss / mov es,bx pattern are its code, not BC 2.0's), compiled directly with -O
   (no TASM pass).  Each character goes to DOS function 02h through the pseudo-registers
   and geninterrupt(0x21).
   match: the loop is written with goto and its step and test sit inside the switch after
   the last case.  That is the shape the original has: case 's' falls into "next
   character", and the switch's missing default leads straight to the function's end.  The
   same loop as a for statement with "default: return" compiles 4 bytes longer (a jump over
   the default and the default's own jump), whatever the case order.
   %x of 0 prints nothing, and LONG_MIN prints from the table text "2147483648". */
#include <dos.h>
extern char near LONG_MIN_DIGITS[];     /* DS:5738: "2147483648" */

#define PUT(c) { _DX=(c); _AH=2; geninterrupt(0x21); }

void far pascal RTL_DVPRINTF(char far *format,char far *args)
{
    unsigned long unsigned_value;
    long value;
    char digits[12];
    char far *p;
    int c;
    register int is_long;
    /* Start at the loop test, so an empty format prints nothing. */
    goto test;
loop:
    if(*format!='%') {
        if(*format=='\n') PUT('\r');
        PUT(*format);
        goto next;
    }
    /* A conversion: clear the long flag, skip the '%', and point p at the
       terminator stored in the last byte of digits[]. */
    is_long=0;
    format++;
    p=digits+sizeof digits;
    *--p=0;
    if(*format=='l') {
        format++;
        is_long=1;
    }
    switch(*format) {
    case 'd':
        if(is_long) {
            value=*(long far *)args;
            args+=4;
        } else {
            value=*(int far *)args;
            args+=2;
        }
        /* LONG_MIN has no positive counterpart: print its digits from the
           stored string LONG_MIN_DIGITS, with the minus sign. */
        if(value==0x80000000L) {
            p=LONG_MIN_DIGITS;
            goto minus;
        }
        if(value==0) {
            PUT('0');
            /* match: (void)0 here and (void)1 in case 'c' keep Turbo C's -O from merging
               the identical `mov ah,2; int 21h; jmp next` tails of the three PUT sites
               (CPP.EXE keeps all three apart); dummy statements per the
               project's policy, the original form is not known. */
            (void)0;
            goto next;
        }
        if(value<0) {
            c=1;
            value=-value;
        } else c=0;
        while(value) {
            *--p=value%10+'0';
            value/=10;
        }
        if(c) {
minus:
            c='-';
        } else c=0;
        if(c) { PUT(c); (void)0; }   /* match: keeps this PUT from merging into the loop's */
        while(*p) PUT(*p++);
        goto next;
    case 'x':
        if(is_long) {
            unsigned_value=*(unsigned long far *)args;
            args+=4;
        } else {
            unsigned_value=*(unsigned int far *)args;
            args+=2;
        }
        /* One hex digit per pass, lowest first, letters in lower case.
           A value of 0 produces no digits, so %x of 0 prints nothing. */
        while(unsigned_value) {
            --p;
            if((c=(int)unsigned_value&15)>9) c+='a'-10;
            else c+='0';
            *p=c;
            unsigned_value>>=4;
        }
        while(*p) PUT(*p++);
        goto next;
    case 'c':
        /* The character is the low byte of an int argument; this is PUT
           written out with the value read from args. */
        _DX=*(int far *)args;
        args+=2;
        _AH=2;
        geninterrupt(0x21);
        (void)1;                     /* match: see PUT('0') above */
        goto next;
    case 's':
        p=*(char far * far *)args;
        args+=4;
        while(*p) PUT(*p++);
        /* case 's' falls into the loop step: advance to the next format
           character and go round again while it is not the terminator. */
next:
        format++;
test:
        if(*format) goto loop;
    }
}
