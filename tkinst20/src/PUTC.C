/* target: PUTC */
/* opts: -mh -O -zC_TEXT -zR_DATA -zTDATA */
/* PUTC.C: fputc(), fputchar() and __fputn(), the library module TKINST.EXE has in place of
 * Borland C++ 2.0's PUTC (CH.LIB). The same source as ../../trancopy20/src/PUTC.C,
 * compiled for the huge model: it gives the released module's code except for one
 * instruction, fp->level += (int)n in __fputn(), a single add here where the released
 * library loads, adds and stores. Code in _TEXT and data in _DATA (class DATA, no group),
 * like the library's own huge-model modules. */
#include <stdio.h>
#include <io.h>
#include <string.h>

static char cr = '\r';
static unsigned char ch;

/* the putc() macro's slow path: the buffer is full or the stream is not ready */
int _fputc(char c, FILE *fp)
{
	--fp->level;
	return fputc(c, fp);
}

int fputc(int c, FILE *fp)
{
	ch = c;
	if (fp->level < -1) {
		fp->level++;
		*fp->curp++ = ch;
		if ((fp->flags & _F_LBUF) && (ch == '\n' || ch == '\r'))
			if (fflush(fp))
				return EOF;
		return ch;
	}
	if ((fp->flags & (_F_ERR | _F_IN)) || !(fp->flags & _F_WRIT)) {
		fp->flags |= _F_ERR;
		return EOF;
	}
	fp->flags |= _F_OUT;
	if (fp->bsize) {
		if (fp->level && fflush(fp))
			return EOF;
		fp->level = -fp->bsize;
		*fp->curp++ = ch;
		if ((fp->flags & _F_LBUF) && (ch == '\n' || ch == '\r'))
			if (fflush(fp))
				return EOF;
		return ch;
	}
	if (((ch == '\n' && !(fp->flags & _F_BIN) && _write(fp->fd, &cr, 1) != 1) ||
	    _write(fp->fd, &ch, 1) != 1) && !(fp->flags & _F_TERM)) {
		fp->flags |= _F_ERR;
		return EOF;
	}
	return ch;
}

int fputchar(register int c)
{
	return fputc(c, stdout);
}

/* writes n bytes from ptr; returns n, or 0 on an error */
unsigned pascal near __fputn(const char *ptr, unsigned n, FILE *fp)
{
	unsigned left = n;

	if (fp->flags & _F_LBUF) {
		while (n--)
			if (fputc(*ptr++, fp) == EOF)
				return 0;
		return left;
	}
	if (fp->flags & _F_BIN) {
		if (fp->bsize) {
			if (fp->bsize < n) {
				if (fp->level && fflush(fp))
					return 0;
				if (_write(fp->fd, ptr, n) < n)
					return 0;
				return left;
			}
			if (fp->level + (int)n >= 0) {
				if (fp->level == 0)
					fp->level = -1 - fp->bsize;
				else if (fflush(fp))
					return 0;
			}
			memcpy(fp->curp, ptr, n);
			fp->level += (int)n;
			fp->curp += n;
			return left;
		}
		if (_write(fp->fd, ptr, n) < n)
			return 0;
		return left;
	}
	if (fp->bsize) {
		while (n--)
			if (putc(*ptr++, fp) == EOF)
				return 0;
		return left;
	}
	if (write(fp->fd, ptr, n) < n)
		return 0;
	return left;
}
