/* opts: -mc -O -Z */
/* FGETS.C: fgets() of the interim run-time library (../README.md). */
#include <stdio.h>

/* The interim library's getc(): it decrements level as level = level - 1, where the
 * released headers write --level, and BCC compiles the two differently. */
#undef getc
#define getc(f) \
	((((f)->level = (f)->level - 1) >= 0) ? (unsigned char)(*(f)->curp++) : _fgetc(f))

char *fgets(char *s, register int n, FILE *fp)
{
	int c = 0;
	char *p;

	p = s;
	while (c != '\n' && --n > 0 && (c = getc(fp)) != EOF)
		*p++ = c;
	if (c == EOF && p == s)
		return NULL;
	*p = 0;
	return ferror(fp) ? NULL : s;
}
