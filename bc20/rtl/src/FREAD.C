/* opts: -mc -B -O -Z */
/* FREAD.C: fread() of the interim run-time library (../README.md).
 *
 * Compiled through assembly (-B): the original has TASM's sign-extended immediates.
 * __fread is the original's static helper; its name is a guess. */
#include <stdio.h>
#include <io.h>

/* the interim library's getc(): see FGETS.C */
#undef getc
#define getc(f) \
	((((f)->level = (f)->level - 1) >= 0) ? (unsigned char)(*(f)->curp++) : _fgetc(f))

static unsigned pascal near __fread(char far *ptr, unsigned left, FILE *fp)
{
	int c;
	register int m;

	while (left) {
		left++;
		m = fp->bsize > left ? left : fp->bsize;
		if ((fp->flags & _F_BIN) && fp->bsize && fp->bsize < left && fp->level == 0) {
			left--;
			m = 0;
			while (fp->bsize <= left) {
				m += fp->bsize;
				left -= fp->bsize;
			}
			c = _read(fp->fd, ptr, m);
			ptr += c;
			if (c != m) {
				left += m - c;
				fp->flags |= _F_EOF;
				break;
			}
		} else {
			while (--left != 0 && --m && (c = getc(fp)) != EOF)
				*ptr++ = c;
			if (c == EOF) {
				fp->flags |= _F_EOF;
				break;
			}
		}
	}
	return left;
}

size_t fread(void *ptr, register size_t size, size_t n, FILE *fp)
{
	unsigned long total;
	register unsigned i;

	if (size == 0)
		return 0;
	if ((total = (unsigned long)size * n) < 0x10000L)
		return ((unsigned)total - __fread(ptr, (unsigned)total, fp)) / size;
	for (i = n + 1; --i != 0 && !__fread(ptr, size, fp); ptr = (char huge *)ptr + size)
		;
	return n - i;
}
