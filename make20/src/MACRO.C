/* target: MACRO */
/* opts: -mc -O -Z -d -a -y */
/* MACRO.C: expanding macros into expbuf: $(name) and $(name:old=new) everywhere, $d(name)
 * in !if lines, and in commands the parts of the target's file name ($* without the
 * extension, $< whole, $: the directory, $. the name and extension, $& the name). A
 * macro's value is read through pullptr and may hold more macros; MAC_BUSY stops a macro
 * that holds itself. The three entries are ifexpand() for !if, expandline() for rules and
 * expandcmd() for commands. */
#include <dir.h>
#include <string.h>
#include "MAKE.H"

char *fnameptr;			/* the parts of the target's name for $* ... (expandcmd()) */
char expbuf[2048];
char oldbuf[512];		/* :old=new */
char fdirbuf[MAXDIR];
char repl[512];
char fdrivebuf[MAXDRIVE];
char *dirptr;
char *outptr;
char macname[512];
char *pullptr;
char typebuf[MAXEXT];
char *drivep;
struct macro *macroptr;
char *suffixpos;
char nametext[MAXFILE];
char *ovfmsg;			/* the message when expbuf is full */

int subst = 0;			/* the last $(...) had :old=new (never cleared) */
char *oldp = oldbuf;
char *replend = repl;

int pascal getmacro(register int (*next)(void));
int pascal defined(register int (*next)(void));
void pascal expand(register int dflag, int specials);
void pascal put(int c);
int pull(void);
void putname(void);

int pascal ifexpand(register int c)
{
	ovfmsg = iflongmsg;
	outptr = expbuf;
	*outptr = 0;
	while (c != -1 && c != '\n') {
		if (c == '$') {
			c = nextch();
			if (c == '(') {
				c = getmacro(nextch);
				if (c == -1)
					break;
				if (macroptr)
					expand(1, 0);
				else
					put('0');
			} else if (c == 'd') {
				c = nextch();
				if (c != '(') {
					put('$');
					put('d');
					continue;
				}
				if (defined(nextch) == -1)
					break;
			} else {
				put('$');
				continue;
			}
		} else
			put(c);
		c = nextch();
	}
	return 1;
}

int pascal special(register int c)
{
	if (c == '*')
		fnmerge(macname, drivep, dirptr, fnameptr, NULL);
	else if (c == '<')
		fnmerge(macname, drivep, dirptr, fnameptr, suffixpos);
	else if (c == ':')
		fnmerge(macname, drivep, dirptr, NULL, NULL);
	else if (c == '.')
		fnmerge(macname, NULL, NULL, fnameptr, suffixpos);
	else if (c == '&')
		strcpy(macname, fnameptr);
	else
		return 1;
	putname();
	return 0;
}

void pascal expand(register int dflag, int specials)
{
	struct macro *m;
	char *savepull;
	char *p;
	char *q;
	register int c;

	if (macroptr == NULL)
		return;
	m = macroptr;
	savepull = pullptr;
	pullptr = m->name + strlen(m->name) + 1;
	if (debug) {
		msg("Pullp = %s", pullptr);
		if (subst) {
			msg("Search string = %s\n", oldbuf);
			msg("Replace string = %s\n", repl);
		}
	}
	if (subst) {
		p = pullptr;
		while (p = strstr(p, oldbuf), p != NULL)
			for (q = repl; q < replend; )
				*p++ = *q++;
	}
	m->flags = m->flags | MAC_BUSY;
	c = pull();
	while (c != -1) {
		if (c == '$') {
			c = pull();
			if (c == '(') {
				c = getmacro(pull);
				if (c == -1)
					break;
				expand(dflag, 0);
			} else if (dflag && c == 'd') {
				c = pull();
				if (c != '(') {
					put('$');
					put('d');
					continue;
				}
				if (defined(pull) == -1)
					break;
			} else if (specials) {
				if (special(c)) {
					put('$');
					continue;
				}
			} else {
				put('$');
				continue;
			}
		} else
			put(c);
		c = pull();
	}
	m->flags = m->flags & ~MAC_BUSY;
	pullptr = savepull;
}

void pascal expandline(register int c)
{
	ovfmsg = rulelongmsg;
	outptr = expbuf;
	expbuf[0] = 0;
	while (c != -1 && c != '\n') {
		if (c == '$') {
			c = nextch();
			if (c == '(') {
				c = getmacro(nextch);
				if (c == -1)
					break;
				expand(0, 0);
			} else {
				put('$');
				continue;
			}
		} else
			put(c);
		c = nextch();
	}
}

void pascal expandcmd(char *cmd, char *path)
{
	register int c;

	drivep = fdrivebuf;
	dirptr = fdirbuf;
	fnameptr = nametext;
	suffixpos = typebuf;
	ovfmsg = cmdlongmsg;
	fnsplit(path, fdrivebuf, fdirbuf, nametext, typebuf);
	pullptr = cmd;
	outptr = expbuf;
	expbuf[0] = 0;
	c = pull();
	while (c != -1) {
		if (c == '$') {
			c = pull();
			if (c == '(') {
				c = getmacro(pull);
				if (c == -1)
					break;
				expand(0, 1);
			} else if (special(c)) {
				put('$');
				continue;
			}
		} else
			put(c);
		c = pull();
	}
}

void pascal skipline(register int c)
{
	while (c != -1 && c != '\n')
		c = nextch();
}

int pascal getmacro(register int (*next)(void))
{
	char *p;
	int c;

	p = macname;
	do
		c = (*next)();
	while (c == ' ');
	for (;;) {
		if (c == -1 || c == '\n') {
			*p = 0;
			putname();
			return -1;
		}
		if (c == ')' || c == ':')
			break;
		*p++ = c;
		c = (*next)();
	}
	if (c == ':') {
		c = (*next)();
		if (c == -1 || c == '\n') {
			*p = 0;
			putname();
			return -1;
		}
		subst = 1;
		if (c == ')' || c == '=')
			error(badtransmsg);
		oldp = oldbuf;
		replend = repl;
		while (c != ')' && c != '=') {
			if (c == -1 || c == '\n') {
				*p = 0;
				putname();
				return -1;
			}
			*oldp++ = c;
			c = (*next)();
		}
		if (c == ')')
			error(badtransmsg);
		*oldp = 0;
		while ((c = (*next)(), c) != ')') {
			if (c == -1 || c == '\n') {
				*p = 0;
				putname();
				return -1;
			}
			*replend++ = c;
		}
		*replend = 0;
	}
	for (p--; p >= macname && *p == ' '; )
		;
	p++;
	*p = 0;
	macroptr = findmacro();
	return c;
}

void putname(void)
{
	char *p;

	for (p = macname; *p; p++)
		put(*p);
}

int pascal defined(register int (*next)(void))
{
	char *p;
	int c;

	p = macname;
	do
		c = (*next)();
	while (c == ' ');
	for (;;) {
		if (c == -1 || c == '\n') {
			*p = 0;
			putname();
			return -1;
		}
		if (c == ')')
			break;
		*p++ = c;
		c = (*next)();
	}
	for (p--; p >= macname && *p == ' '; p--)
		;
	p++;
	*p = 0;
	put(isdef(macname) ? '1' : '0');
	return ')';
}

void pascal put(int c)
{
	if (outptr < expbuf + sizeof expbuf)
		*outptr++ = c;
	else if (outptr == expbuf + sizeof expbuf)
		error(ovfmsg);
	*outptr = 0;
}

int pull(void)
{
	register char c;

	c = *pullptr;
	if (c) {
		pullptr++;
		return c;
	}
	return -1;
}
