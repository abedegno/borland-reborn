/* target: ERROR */
/* opts: -mc -B -O -Z */
/* ERROR.C: the console mode, and every message TLIB prints.
 *
 * Compiled through assembly (-B): conmode() is inline assembler. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include "TLIB.H"

/* Puts the console's standard input and output (handles 0 and 1) back into cooked mode
 * (IOCTL 4400h/4401h, clearing the raw bit 20h) and turns DOS's Ctrl-Break checking on
 * (3301h), so that Ctrl-C stops TLIB at any DOS call. */
void conmode(void)
{
	asm mov ax,4400h
	asm sub bx,bx
	asm int 21h
	asm mov ax,4401h
	asm and dx,0DFh
	asm int 21h
	asm mov ax,4400h
	asm mov bx,1
	asm int 21h
	asm mov ax,4401h
	asm and dx,0DFh
	asm int 21h
	asm mov ax,3301h
	asm mov dl,1
	asm int 21h
}

/* Prints a message to stderr: "Warning: " (LEVEL 0), "\nError: " (1), or the DOS error
 * through perror() (2), then FMT and its arguments and a newline. Levels 1 and 2 are fatal:
 * main() takes over at fatal_jmp, removes the half-written library and exits. */
void error(int level, char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	if (level != 2)
		fputs(level == 1 ? "\nError: " : "Warning: ", stderr);
	else
		perror("DOS-reported error");
	vfprintf(stderr, fmt, ap);
	fputc('\n', stderr);
	if (level)
		longjmp(fatal_jmp, 1);
}
