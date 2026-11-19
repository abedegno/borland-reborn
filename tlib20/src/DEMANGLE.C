/* target: DEMANGLE */
/* opts: -mc -O -Z */
/* DEMANGLE.C: turning Borland C++ mangled names back into C++ for the listing file.
 *
 * A mangled name is '@' [class '@'] name ['$' type-codes]: "@foo$qi" is foo(int),
 * "@X@$bctr$qv" is X::X(), "@X@$badd$qr1X" is X::operator +(X &). The type codes:
 *   v void  c char  s short  i int  l long  f float  d double  g long double  e ...
 *   u unsigned  z signed  x const  w volatile  (up / ur: huge / _seg pointer)
 *   p near pointer  n far pointer  r near reference  m far reference
 *   q function (arguments, then '$' and the return type)  a array (dimensions)
 *   <digits><name> a class name  t<n> the nth argument type again
 * unmangle() is the entry point; dtype() spells one type and dargs() an argument list,
 * each consuming the code as it goes. A malformed name longjmps to bad, and the result is
 * cut short with "...".
 *
 * Compiled straight to an object (no -B): the code keeps redundant ss: prefixes on stack
 * arrays reached through SI, which Turbo C writes in its own objects and every TASM drops.
 * With register variables on, Turbo C 2.01 puts int locals in SI and DI by itself, but not
 * shorts: dtype()'s two shorts are on the stack in the original too. */
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <mem.h>
#include <setjmp.h>

/* The operator functions, by their mangled names ($b<name>) */
struct optab {
	char near *name;
	char near *op;
} optab[] = {
	{"add", "+"},
	{"adr", "&"},
	{"and", "&"},
	{"asg", "="},
	{"land", "&&"},
	{"lor", "||"},
	{"call", "()"},
	{"cmp", "~"},
	{"dec", "--"},
	{"dele", "delete"},
	{"div", "/"},
	{"eql", "=="},
	{"geq", ">="},
	{"gtr", ">"},
	{"inc", "++"},
	{"ind", "*"},
	{"leq", "<="},
	{"lsh", "<<"},
	{"lss", "<"},
	{"mod", "%"},
	{"mul", "*"},
	{"neq", "!="},
	{"new", "new"},
	{"not", "!"},
	{"or", "|"},
	{"rand", "&="},
	{"rdiv", "/="},
	{"rlsh", "<<="},
	{"rmin", "-="},
	{"rmod", "%="},
	{"rmul", "*="},
	{"ror", "|="},
	{"rplu", "+="},
	{"rrsh", ">>="},
	{"rsh", ">>"},
	{"rxor", "^="},
	{"sub", "-"},
	{"subs", "[]"},
	{"xor", "^"},
	{"arow", "->"},
	{0, 0}
};

static jmp_buf bad;		/* where a malformed name ends up */
static unsigned poolfree;	/* room left in seenpool */
static char _ss *seenpool;	/* the next free byte of unmangle()'s buffer of argument types */

void dargs(char **src, char **dst, unsigned *roomp);

/* Appends STR (COPYN: of length len) to the output, as far as there is room. */
#define COPY(str) \
	len = strlen(str); \
	COPYN(str)

#define COPYN(str) \
	if (*room >= len) { \
		strcpy(d, str); \
		d += len; \
		*room -= len; \
	} else \
		*room = 0

/* The operator for a mangled operator name ("add" -> "+"). */
char near *opname(char *name)
{
	struct optab *p;

	for (p = optab; p->name != NULL && strcmp(p->name, name) != 0; p++)
		;
	if (p->name == NULL)
		longjmp(bad, 1);
	return p->op;
}

/* Reads the decimal length before a class name at **PP, and leaves *PP pointing at the
 * name, NUL-terminated in place (the name is moved back over the last digit). */
void getnum(char **pp, unsigned *out)
{
	char *p;
	register unsigned n;

	p = *pp;
	n = 0;
	do
		n = n * 10 + *p - '0';
	while (isdigit(*++p));
	if (strlen(p) < n)
		longjmp(bad, 1);
	p--;
	memmove(p, p + 1, n);
	p[n] = 0;
	*pp = p;
	*out = n;
}

/* Spells the type coded at *SRC into *DST, with *ROOM bytes left there; both pointers are
 * moved past what was used. QUAL is a pointer's " near"/" far" to put inside a function
 * type's parentheses: "int (far *)(void)". */
void dtype(char **src, char **dst, unsigned *room, char *qual)
{
	char *str;
	char *s;
	char *d;
	unsigned len;
	char *ptrname;

	s = *src;
	d = *dst;
	ptrname = NULL;
	for (;;) {
		switch (*s) {
		case 'u':
			if (s[1] == 'p')
				ptrname = " huge ";
			else if (s[1] == 'r')
				ptrname = " _seg ";
			else
				str = "unsigned ";
			break;
		case 'z':
			str = "";
			break;
		case 'x':
			str = "const ";
			break;
		case 'w':
			str = "volatile ";
			break;
		default:
			goto basic;
		}
		s++;
		if (ptrname != NULL)
			continue;
		COPY(str);
		*d = 0;
	}
basic:
	switch (*s) {
	case 'v':
		str = "void";
		break;
	case 'c':
		str = "char";
		break;
	case 's':
		str = "short";
		break;
	case 'i':
		str = "int";
		break;
	case 'l':
		str = "long";
		break;
	case 'f':
		str = "float";
		break;
	case 'd':
		str = "double";
		break;
	case 'g':
		str = "long double";
		break;
	case 'e':
		str = "...";
		break;
	default:
		goto compound;
	}
	COPY(str);
	s++;
	goto done;
compound:
	if (isdigit(*s)) {
		getnum(&s, &len);
		COPYN(s);
		s += len + 1;
	} else if (*s == 'p' || *s == 'r' || *s == 'm' || *s == 'n') {
		short qcount;
		short isref;
		char iscon;
		char isvol;
		char *p;
		register unsigned n;
		isref = 0;
		if (ptrname == NULL) {
			isref = *s == 'r' || *s == 'm';
			if (*s == 'p' || *s == 'r')
				ptrname = " near";
			else
				ptrname = " far";
		}
		s++;
		p = s;
		iscon = isvol = 0;
		for (;; p++) {
			if (*p == 'x')
				iscon = 1;
			else if (*p == 'w')
				isvol = 1;
			else
				break;
		}
		qcount = 0;
		if (*p == 'q') {
			qcount++;
			ptrname++;
			s = p;
		}
		dtype(&s, &d, room, ptrname);
		if (qcount) {
			if (iscon && *room > 6) {
				strcpy(d, " const");
				d += 6;
				*room -= 6;
			}
			if (isvol && *room > 9) {
				strcpy(d, " volatile");
				d += 9;
				*room -= 9;
			}
		} else {
			if (!isalnum(d[-1]))
				ptrname++;
			n = strlen(ptrname);
			if (*room > n) {
				strcpy(d, ptrname);
				d += n;
				*d++ = isref ? '&' : '*';
				*room -= n + 1;
			}
		}
	} else if (*s == 'a') {
		char dims[90];
		register int n;
		n = 0;
		do {
			dims[n++] = '[';
			s++;
			if (*s == '0')
				s++;
			while (*s != 0 && *s != '$')
				dims[n++] = *s++;
			if (*s != 0)
				s++;
			dims[n++] = ']';
		} while (*s == 'a');
		dims[n] = 0;
		dtype(&s, &d, room, NULL);
		if (*room >= n + 2) {
			strcpy(d, dims);
			d += n;
			*room -= n;
		} else if (*room >= 2) {
			*d++ = '[';
			*d++ = ']';
			*d = 0;
			*room -= 2;
		} else
			*room = 0;
	} else if (*s == 'q') {
		char buf[64];
		char *mid;
		char *start;
		register unsigned n;
		start = d;
		s++;
		if (*room >= 3) {
			*d++ = '(';
			if (qual != NULL) {
				n = strlen(qual);
				if (*room >= n + 2) {
					strcpy(d, qual);
					d += n;
					*room -= n;
				}
			}
			*d++ = '*';
			*d++ = ')';
			*room -= 3;
			*d = 0;
		} else
			*room = 0;
		dargs(&s, &d, room);
		if (*s == '$') {
			s++;
			mid = d;
			dtype(&s, &d, room, NULL);
			n = strlen(mid);
			if (n < 64) {
				strcpy(buf, mid);
				memmove(start + n, start, mid - start);
				memmove(start, buf, n);
			}
		}
	} else if (*s != 0)
		longjmp(bad, 1);
done:
	*d = 0;
	*src = s;
	*dst = d;
}

/* Spells an argument list "(int, char *)": the codes up to the next '$' or the end. Each
 * argument's spelling is kept in seenpool for later t<n> codes. */
void dargs(char **src, char **dst, unsigned *roomp)
{
	char *start;
	char *s;
	char *d;
	unsigned room;
	unsigned len;
	int n;
	char _ss *seen[36];
	unsigned savefree;
	char _ss *savepool;
	register int i;
	register unsigned k;

	s = *src;
	d = *dst;
	room = *roomp;
	n = 0;
	savefree = poolfree;
	savepool = seenpool;
	if (room > 0) {
		*d++ = '(';
		room--;
		*d = 0;
	}
	if (*s == 'v')
		s++;
	else
		for (;;) {
			seen[++n] = NULL;
			if (*s == 't') {
				s++;
				if (isdigit(*s))
					i = *s - '0';
				else if (islower(*s))
					i = *s - 'a' + 10;
				else
					longjmp(bad, 1);
				if (*s)
					s++;
				if (seen[i] != NULL) {
					len = strlen(seen[i]);
					if (room >= len) {
						strcpy(d, seen[i]);
						d += len;
						room -= len;
					} else
						room = 0;
				} else
					longjmp(bad, 1);
			} else {
				start = d;
				dtype(&s, &d, &room, NULL);
				k = strlen(start) + 1;
				if (poolfree >= k) {
					seen[n] = seenpool;
					strcpy(seenpool, start);
					seenpool += k;
					poolfree -= k;
				}
			}
			if (!isalnum(*s))
				break;
			if (room > 0) {
				*d++ = ',';
				*d = 0;
				room--;
			}
		}
	if (room > 0) {
		*d++ = ')';
		room--;
	}
	*d = 0;
	poolfree = savefree;
	seenpool = savepool;
	*src = s;
	*dst = d;
	*roomp = room;
}

/* Writes SRC as C++ to DEST (at most MAXLEN bytes), its class name to QUALP and its base
 * name to BASEP (either may be NULL), with the argument list when DOARGS. Returns the
 * kind of name: 0 not mangled (copied as it is), 1 a function, 2 a constructor, 3 a
 * destructor, 4 an operator, 5 a conversion operator, 6 a data member. A name all in upper
 * case (from a case-insensitive link) is lower-cased first. */
int unmangle(char *src, char *dest, register unsigned maxlen, char *qualP, char *baseP, int doArgs)
{
	char *p;
	char *d;
	char *name;
	char *qual;
	unsigned room;
	char iscon;
	char isvol;
	char pool[128];
	char buf[63];
	int kind;

	if (src == NULL)
		return 0;
	if (*src != '@') {
		strcpy(dest, src);
		return 0;
	}
	strncpy(buf, src, 62);
	buf[62] = 0;
	for (p = buf + 1; *p; p++)
		if (*p >= 'a' && *p <= 'z')
			goto mixed;
	for (p = buf + 1; *p; p++)
		*p = tolower(*p);
mixed:
	p = buf + 1;
	if (*p == '$' && (p[1] == 'b' || p[1] == 'o'))
		p += 3;
	while (*p && *p != '@' && *p != '$')
		p++;
	if (*p == 0) {
		if (dest != NULL)
			strcpy(dest, src);
		if (baseP != NULL)
			strcpy(baseP, src);
		return 0;
	}
	if (*p == '@') {
		*p++ = 0;
		qual = buf + 1;
		for (; isdigit(*p); p++)
			;
		name = p;
		if (*p == '$' && (p[1] == 'b' || p[1] == 'o'))
			p += 3;
		while (*p && *p != '$')
			p++;
		if (*p == 0) {
			kind = 6;
			goto named;
		}
	} else {
		qual = NULL;
		name = buf + 1;
	}
	*p++ = 0;
	if (*name == '$') {
		name += 2;
		if (name[-1] == 'b') {
			if (strcmp(name, "ctr") == 0)
				kind = 2;
			else if (strcmp(name, "dtr") == 0)
				kind = 3;
			else
				kind = 4;
		} else
			kind = 5;
	} else
		kind = 1;
named:
	if (qualP != NULL)
		strcpy(qualP, qual);
	if (baseP != NULL) {
		if (dest == NULL) {
			d = baseP;
			doArgs = 0;
			goto print;
		}
		strcpy(baseP, name);
	}
	if (dest == NULL)
		return kind;
	d = dest;
	room = maxlen - 1;
	if (setjmp(bad)) {
truncated:
		dest[maxlen - 4] = 0;
		strcat(d, "...");
		return kind;
	}
	seenpool = pool;
	poolfree = 128;
	if (qual != NULL) {
		register unsigned n;

		n = strlen(qual);
		strcpy(d, qual);
		d += n;
		*d++ = ':';
		*d++ = ':';
		room -= n + 2;
	}
print:
	switch (kind) {
	case 3:
		*d++ = '~';
	case 2:
		strcpy(d, qual);
		break;
	case 4:
		strcpy(d, "operator ");
		d += 9;
		strcpy(d, opname(name));
		break;
	case 5:
		strcpy(d, "operator ");
		d += 9;
		room -= 9;
		dtype(&name, &d, &room, NULL);
		kind = 5;
		break;
	case 1:
	case 6:
		strcpy(d, name);
		break;
	}
	if (!doArgs)
		return kind;
	d += strlen(d);
	room = dest + maxlen - d - 1;
	if (room < 0)		/* never true: room is unsigned (kept as the original has it) */
		room = 0;
	iscon = isvol = 0;
	for (;; p++) {
		if (*p == 'x')
			iscon = 1;
		else if (*p == 'w')
			isvol = 1;
		else
			break;
	}
	if (*p == 'q') {
		p++;
		dargs(&p, &d, &room);
	}
	if (iscon) {
		if (room < 6)
			goto truncated;
		strcat(d, " const");
	}
	if (isvol) {
		if (room < 9)
			goto truncated;
		strcat(d, " volatile");
	}
	return kind;
}
