/* opts: -mc -B -O -Z -k- */
/* GETC.C: _fgetc(), fgetc() and fgetchar() of the interim run-time library
 * (../README.md).
 *
 * Compiled through assembly and without standard stack frames where none is needed
 * (-B -k-). Three statements below are there for their code only, each marked match:
 * the compiler that built the original left two jumps BCC removes, and an unreachable one
 * BCC never emits. */
#include <stdio.h>
#include <io.h>

static unsigned char c;		/* the character read unbuffered */

/* Flushes every stream open for output to a terminal, before reading from one. */
static void near _flushout(void)
{
	register int i;
	FILE *fp;

	for (i = 20, fp = _streams; i--; fp++)
		if ((fp->flags & (_F_TERM | _F_OUT)) == (_F_TERM | _F_OUT))
			fflush(fp);
}

/* Refills FP's buffer: 0, or EOF at the end of the file or on an error. */
static int pascal near _ffill(FILE *fp)
{
	if (fp->flags & _F_TERM)
		_flushout();
	if ((fp->level = read(fp->fd, fp->curp = fp->buffer, fp->bsize)) > 0) {
		fp->flags &= ~_F_EOF;
		return 0;
	}
	if (fp->level == 0)
		fp->flags = (fp->flags & ~(_F_IN | _F_OUT)) | _F_EOF;
	else {
		fp->level = 0;
		fp->flags |= _F_ERR;
	}
	return EOF;
}

int _fgetc(FILE *fp)
{
	fp->level = fp->level + 1;
	return fgetc(fp);
}

int fgetc(FILE *fp)
{
	if (fp->level > 0) {
take:
		fp->level = fp->level - 1;
		return *fp->curp++;
	}
	if (fp->level < 0 || fp->flags & (_F_OUT | _F_ERR) || !(fp->flags & _F_READ)) {
err:
		fp->flags |= _F_ERR;
eofret:
		return EOF;
	}
	fp->flags |= _F_IN;
	if (fp->bsize) {
		if (_ffill(fp)) {
			(void)0;	/* match: keeps the jump to the shared return */
			return EOF;
		}
		(void)0;	/* match: keeps the separate jump back */
		goto take;
	}
	do {
		if (fp->flags & _F_TERM)
			_flushout();
		if (read(fp->fd, &c, 1) == 0) {
			if (eof(fp->fd) != 1) {
				(void)0;	/* match: keeps the jump over the jump */
				goto err;
			}
			fp->flags = (fp->flags & ~(_F_IN | _F_OUT)) | _F_EOF;
			asm jmp short eofret	/* match: the original has two jumps to the return here */
			return EOF;
		}
	} while (c == '\r' && !(fp->flags & _F_BIN));
	fp->flags &= ~_F_EOF;
	return c;
}

int fgetchar(void)
{
	return fgetc(stdin);
}
