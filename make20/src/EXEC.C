/* target: EXEC */
/* opts: -mc -O -Z -d -a -y */
/* EXEC.C: running one command. pathfind() looks for the program as DOS would, in the
 * current directory and then the PATH, as .COM, .EXE or .BAT; DOS's own commands
 * (dosnames) and batch files go through COMMAND.COM /c, the rest straight to spawnve() or,
 * with -S, swapspawn() (SPAWN.C), after execute() has taken out < and > redirections. Also
 * getage() and now(), the file times that BUILD.C compares, and importenv(), which makes
 * every environment variable a macro. */
#include <dos.h>
#include <dir.h>
#include <io.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <process.h>
#include <mem.h>
#include "MAKE.H"

char *dosnames[28] = {
	"break", "cd", "chdir", "cls", "copy", "ctty", "date", "del",
	"dir", "echo", "erase", "for", "if", "md", "mkdir", "path",
	"prompt", "rd", "rem", "ren", "rename", "rmdir", "set", "time",
	"type", "ver", "verify", "vol"
};

char cmdbuf[128];		/* /c and the command, for COMMAND.COM */
int viashell;			/* findexec(): run it through COMMAND.COM */
char pathbuf[80];		/* the program found */

int pascal findexec(char *name);
void pascal catarg(int max, char *dst, char *src);

/* a file's date and time as one number to compare (date high, time low), 0 if absent */
unsigned long pascal getage(char *name)
{
	struct ffblk ff;

	if (findfirst(name, &ff, 0) < 0)
		return 0;
	if (debug)
		msg("age of %s is %x:%x\n", name, ff.ff_fdate, ff.ff_ftime);
	return ((long)ff.ff_fdate << 16) + ff.ff_ftime;
}

/* the date and time now, as getage() gives them */
unsigned long now(void)
{
	struct ftime ft;
	struct date d;
	struct time t;

	getdate(&d);
	gettime(&t);
	ft.ft_tsec = t.ti_sec >> 1;
	ft.ft_min = t.ti_min;
	/* match: the hour and the year are stored as the original's compiler stored bitfields
	   that fit in a word's high byte, with word operations; Borland C++ 2.0 narrows those
	   stores to the high byte, so they are spelled out here */
	_AX = t.ti_hour & 0x1F;
	*(unsigned *)&ft &= 0x7FF;
	*(unsigned *)&ft |= _AX << 11;
	ft.ft_day = d.da_day;
	ft.ft_month = d.da_mon;
	_AX = (d.da_year - 1980) & 0x7F;
	((unsigned *)&ft)[1] &= 0x1FF;
	((unsigned *)&ft)[1] |= _AX << 9;
	return *(unsigned long *)&ft;
}

char *pascal pathfind(char *name)
{
	char *p;
	char *env;

	strcpy(pathbuf, name);
	if (findexec(pathbuf))
		goto found;
	env = getenv("PATH");
	if (env == NULL)
		return NULL;
	do {
		for (p = env; *p && *p != ';'; p++)
			;
		movmem(env, pathbuf, p - env);
		pathbuf[p - env] = 0;
		env = p + 1;
		p = pathbuf + strlen(pathbuf) - 1;
		if (p > pathbuf && *p != ':' && *p != '/' && *p != '\\')
			catarg(64, pathbuf, "\\");
		catarg(79, pathbuf, name);
		if (findexec(pathbuf)) {
			(void)0;	/* match: keeps the test as a jump over a jump */
			goto found;
		}
	} while (*env);
	return NULL;
found:
	return pathbuf;
}

int pascal execute(char *cmd, char *args)
{
	char *prog;
	char *p;
	int infd;
	int outfd;
	char *fname;
	char save;
	int mode;
	char *argv[3];
	register int quote;
	register int status;

	infd = -1;
	outfd = -1;
	viashell = 0;
	prog = pathfind(cmd);
	if (viashell) {
		prog = getenv("COMSPEC");
		cmdbuf[0] = getswitchar();
		cmdbuf[1] = 'c';
		cmdbuf[2] = ' ';
		cmdbuf[3] = 0;
		catarg(128, cmdbuf, cmd);
		catarg(128, cmdbuf, " ");
		catarg(128, cmdbuf, args);
		args = cmdbuf;
		if (debug)
			msg("s = %s cmd = %s\n", prog, args);
	} else {
		p = args;
		while (*p && prog) {
			for (quote = 0; ((*p != '<' && *p != '>') || quote) && *p; p++)
				if (*p == '"')
					quote = !quote;
			if (*p == '<') {
				*p = 0;
				while (*++p == ' ' || *p == '\t')
					(void)0;	/* match: (void)0 rather than ; keeps the jump into the loop */
				fname = p;
				while (*++p && *p != '\n' && *p != ' ' && *p != '>')
					(void)0;
				save = *p;
				*p = 0;
				if ((infd = redirect(fname, 0, O_RDONLY)) < 0)
					fatal(redirmsg);
				*p = save;
			} else if (*p == '>') {
				*p = 0;
				if (p[1] == '>') {
					mode = O_WRONLY | O_CREAT | O_APPEND;
					p++;
				} else
					mode = O_WRONLY | O_CREAT | O_TRUNC;
				(void)0;	/* match: keeps the else's own jump */
				while (*++p == ' ' || *p == '\t')
					(void)0;
				fname = p;
				while (*++p && *p != '\n' && *p != ' ' && *p != '>')
					(void)0;
				save = *p;
				*p = 0;
				if ((outfd = redirect(fname, 1, mode)) < 0)
					fatal(redirmsg);
				*p = save;
				(void)0;	/* match: keeps this tail apart from the identical one above */
			}
		}
	}
	if (prog == NULL)
		fatal(execmsg, cmd);
	argv[0] = prog;
	argv[1] = args;
	argv[2] = NULL;
	if (swap)
		status = swapspawn(prog, args);
	else
		status = spawnve(P_WAIT, prog, argv, myenv);
	unredirect(outfd, 1);
	unredirect(infd, 0);
	if (status == -1)
		fatal(execmsg, cmd);
	if ((status & 0xFF00) == 0x100 || (status & 0xFF00) == 0x200)
		_exit(1);
	return status;
}

int cmpname(const void *key, const void *elem)
{
	return stricmp((char *)key, *(char **)elem);
}

int pascal findexec(char *name)
{
	char *p;

	for (p = name + strlen(name) - 1; p + 1 >= name + 1 && *p != '.'; p--)
		if (*p == '\\' || *p == '/')
			break;
	if (*p == '.')
		return _chmod(name, 0, 0) != -1;
	if (bsearch(name, dosnames, 28, sizeof(char *), cmpname)) {
		viashell = 1;
		return 1;
	}
	p = name + strlen(name);
	strcpy(p, ".com");
	if (_chmod(name, 0, 0) != -1)
		return 1;
	strcpy(p, ".exe");
	if (_chmod(name, 0, 0) != -1)
		return 1;
	strcpy(p, ".bat");
	if (_chmod(name, 0, 0) != -1) {
		viashell = 1;
		*p = 0;
		return 1;
	}
	*p = 0;
	return 0;
}

void importenv(void)
{
	char **e;
	int flag = 0;

	for (e = myenv; *e; e++) {
		flag = 0;
		defstring(*e, "", &flag);
	}
}

void pascal catarg(int max, char *dst, char *src)
{
	if (strlen(dst) + strlen(src) >= max)
		fatal(toolongmsg);
	strcat(dst, src);
}
