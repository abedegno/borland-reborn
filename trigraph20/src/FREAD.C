/* target: FREAD */
/* opts: -ms -B -O -Z */
/* FREAD.C: fread() as TRIGRAPH.EXE has it: Turbo C++ 1.01's fread, compiled by Borland C++
 * 2.0's BCC for the small model (it stores a long's high word first, where Turbo C++ 1.01's
 * own CS.LIB has the low word first). Neither library has this module. It is older than
 * the interim library's fread (../../interim-rtl/src/FREAD.C), which TLIB.EXE has: a
 * request of 64K or more reads nothing here. __fread is the original's static helper; its
 * name is a guess. */
#include <stdio.h>
#include <io.h>

#undef getc
#define getc(f) \
	((((f)->level = (f)->level - 1) >= 0) ? (unsigned char)(*(f)->curp++) : _fgetc(f))

static unsigned pascal near __fread(register char *ptr, unsigned left, FILE *fp)
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

	if (size == 0)
		return 0;
	if ((total = (unsigned long)size * n) < 0x10000L)
		return ((unsigned)total - __fread(ptr, (unsigned)total, fp)) / size;
	return 0;
}
