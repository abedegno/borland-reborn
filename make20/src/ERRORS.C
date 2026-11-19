/* target: ERRORS */
/* opts: -mc -O -Z -d -a -y */
/* ERRORS.C: fatal errors, errors and plain messages. While a makefile is read, errfile and
 * lineno name the place, and both kinds of error print it. fatal() ends MAKE; error() counts
 * (MAIN.C stops before building when errcount is not 0). VMSG.C does the formatting. */
#include <stdarg.h>
#include "MAKE.H"

void _exit(int status);
void vmsg(char *fmt, va_list ap);

char *errfile = 0;
int lineno = 0;
long reserved = 0;		/* never used */
int errcount = 0;

void fatal(char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	msg(fatalmsg);
	if (errfile)
		msg(" %s", errfile);
	if (lineno)
		msg(" %d", lineno);
	msg(": ");
	vmsg(fmt, ap);
	msg("\n");
	_exit(1);
}

void error(char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	errcount++;
	msg(errormsg);
	if (errfile)
		msg(" %s", errfile);
	if (lineno)
		msg(" %d", lineno);
	msg(": ");
	vmsg(fmt, ap);
	msg("\n");
}

void msg(char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vmsg(fmt, ap);
}
