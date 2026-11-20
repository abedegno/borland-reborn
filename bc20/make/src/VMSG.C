/* target: VMSG */
/* opts: -mc -O -Z -d -y */
/* VMSG.C: MAKE's own small printf, for msg(), error() and fatal() (ERRORS.C). It writes
 * through DOS function 2, a character at a time, with \r before each \n, and knows %d, %x,
 * %c, %s and %ld and %lx. %d and %x print nothing at all for 0: the digits are made only
 * while the value is not 0. Unlike the other files it was compiled without -a. */
#include <stdarg.h>

int bdos(int fn, unsigned dx);

void vmsg(char *fmt, va_list ap)
{
	unsigned long uval;
	long val;
	char *p;
	int t;
	char buf[12];
	register int islong;

	for (; *fmt; fmt++) {
		if (*fmt != '%') {
			if (*fmt == '\n')
				bdos(2, '\r');
			bdos(2, *fmt);
		} else {
			islong = 0;
			fmt++;
			p = buf + 12;
			*--p = 0;
			if (*fmt == 'l') {
				fmt++;
				islong = 1;
			}
			switch (*fmt) {
			case 'd':
				if (islong)
					val = va_arg(ap, long);
				else
					val = va_arg(ap, int);
				if (val == 0x80000000L) {
					p = "2147483648";
					t = '-';
				} else {
					if (val < 0) {
						t = 1;
						val = -val;
					} else
						t = 0;
					while (val) {
						*--p = val % 10 + '0';
						val /= 10;
					}
					if (t)
						t = '-';
					else
						t = 0;
				}
				if (t)
					bdos(2, t);
				while (*p)
					bdos(2, *p++);
				break;
			case 'x':
				if (islong)
					uval = va_arg(ap, unsigned long);
				else
					uval = va_arg(ap, unsigned);
				while (uval) {
					--p;
					t = uval & 0xF;
					if (t > 9)
						t += 'a' - 10;
					else
						t += '0';
					*p = t;
					uval >>= 4;
				}
				while (*p)
					bdos(2, *p++);
				break;
			case 'c':
				bdos(2, va_arg(ap, int));
				break;
			case 's':
				p = va_arg(ap, char *);
				while (*p)
					bdos(2, *p++);
				break;
			default:
				return;
			}
		}
	}
}
