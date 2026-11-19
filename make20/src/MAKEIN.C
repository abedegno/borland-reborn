/* target: MAKEIN */
/* opts: -mc -O -Z -d -a -y */
/* MAKEIN.C: reading the makefile a character at a time, through a 1 KB buffer. The
 * original's name: its assertion says "makein.c", line 423. nextch() hands the parser
 * characters with \r dropped, continuation lines (\ newline) joined, runs of blanks folded
 * to one space and # comments removed; it counts lines in lineno (ERRORS.C) for messages.
 * tellin() and openat() let PARSE.C leave a makefile for an !include and come back. */
#include <io.h>
#include <assert.h>
#include "MAKE.H"

int fdin;
char *bufend;			/* the end of what is in inbuf */
char *inp;			/* the next character in inbuf */
long inpos;			/* the file position of inbuf[0] */
char inbuf[0x400];

/* opens a makefile for nextch(); 0 when it does not exist */
int pascal openfile(char *name)
{
	register int fd;

	fd = _open(name, 0);
	if (fd < 0)
		return 0;
	fdin = fd;
	bufend = inp = inbuf;
	inpos = 0;
	return 1;
}

/* the file position of the next character */
long tellin(void)
{
	return lseek(fdin, 0L, 1) - (bufend - inp);
}

/* opens a makefile again at a position tellin() gave */
int pascal openat(char *name, long pos)
{
	register int fd;

	fd = _open(name, 0);
	if (fd < 0)
		return 0;
	fdin = fd;
	bufend = inp = inbuf;
	inpos = lseek(fd, pos, 0);
	return 1;
}

void closein(void)
{
	_close(fdin);
}

/* puts back the character nextch() gave last, reading the buffer before when needed */
void pascal unget(register int c)
{
	register int bytesRead;

	if (c == -1)
		return;
	inp--;
	if (inp < inbuf) {
		lseek(fdin, --inpos, 0);
		bytesRead = _read(fdin, inbuf, 0x400);
#line 423			/* the original's line, which the assertion message names */
		assert(bytesRead > 0);
		bufend = inbuf + bytesRead;
		inp = inbuf;
	}
	if (c == '\n')
		lineno--;
}

/* the next character, without \r; ^Z or the end of the file is -1 */
int rawch(void)
{
	register int c;

	do {
		if (inp >= bufend) {
			inpos += bufend - inbuf;
			c = _read(fdin, inbuf, 0x400);
			if (c <= 0)
				return -1;
			bufend = inbuf + c;
			inp = inbuf;
		}
		c = *inp++;
	} while (c == '\r');
	if (c == '\n')
		lineno++;
	else if (c == 0x1A)
		return -1;
	return c;
}

/* the next character for the parser (see the top of the file) */
int nextch(void)
{
	register int c;

again:
	c = rawch();
	if (c == '\\') {
		c = rawch();
		if (c == '?')
			return c;
		if (c == '\n')
			goto again;
		if (c == '\\')
			return c;
		if (c == ' ' || c == '\t' || c == '\v' || c == '\f') {
			do
				c = rawch();
			while (c == ' ' || c == '\v' || c == '\f' || c == '\t');
			if (c == '\n')
				goto again;
			unget(c);
			unget(' ');
			return '\\';
		}
		unget(c);
		return '\\';
	}
	if (c == ' ' || c == '\t' || c == '\v' || c == '\f') {
		do
			c = rawch();
		while (c == ' ' || c == '\v' || c == '\f' || c == '\t');
		if (c != '#') {
			unget(c);
			return ' ';
		}
		while (c && c != '\n')		/* never ends at the end of the file (-1) */
			c = rawch();
	} else if (c == '#')
		while (c && c != '\n' && c != -1)
			c = rawch();
	return c;
}
