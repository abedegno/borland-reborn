/* opts: -mc -O -Z */
/* FFLUSH.C: fflush() of the interim run-time library (../README.md).
 *
 * Turbo C++ 1.01's FFLUSH module compiled from this source with its own compiler is
 * identical to its library's; TLIB.EXE's copy is this source compiled with Borland C++
 * 2.0's BCC, which writes a far pointer's segment before its offset. */
#include <stdio.h>
#include <io.h>

int fflush(FILE *fp)
{
	register int count;

	if (fp == NULL) {
		flushall();
		return 0;
	}
	if (fp->token != (short)fp)
		return EOF;
	if (fp->level >= 0) {
		if (fp->flags & _F_LBUF || fp->curp == &fp->hold) {
			fp->level = 0;
			if (fp->curp == &fp->hold)
				fp->curp = fp->buffer;
		}
		return 0;
	}
	count = fp->bsize + fp->level + 1;
	fp->level = fp->level - count;	/* match: not -=, which BCC turns into one sub */
	if (write(fp->fd, (fp->curp = fp->buffer), count) != count)
		if (!(fp->flags & _F_TERM)) {
			fp->flags |= _F_ERR;
			return EOF;
		}
	return 0;
}
