/* target: BUILD */
/* opts: -mc -O -Z -d -a -y */
/* BUILD.C: bringing a target up to date. make() checks the dependency graph for cycles
 * (checkcirc()) and calls update(), which makes each dependency first, takes the newest
 * date among them, and runs the target's commands, or the commands of the first implicit
 * rule whose source file exists, when the target is older or does not exist. With
 * .AUTODEPEND an object file also counts as out of date when a file its dependency records
 * name has changed (depcheck()). docmds() runs the commands: it writes their && in-line
 * files, expands macros, and runs each command or adds it to a { } batch. */
#include <dos.h>
#include <dir.h>
#include <io.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <mem.h>

#include "MAKE.H"

void _exit(int status);

/* a { } batch: commands that share the text around their braces run as one command, with
 * the parts between the braces gathered at batchend */
char batchbuf[128] = "";
char *batchend = NULL;
char *lbrace = NULL;
char *rbrace = NULL;

void pascal writeinline(struct inl *list, char *path);
void pascal delinline(struct inl *list);
int pascal runcmd(char *cmd, int *cutoff);
int pascal batch(char *cmd, int *cutoff);
void pascal docmds(char *src, struct cmd *cmds, char *target);
char *pascal srcname(struct file *f, char *path, struct ext *e);
unsigned long pascal tryrule(struct file *f, char *path, struct ext *e);
unsigned long pascal depcheck(char *name);
int pascal readrec(int fd, unsigned char *rec);
void pascal findpath(struct file *f);
void pascal checkcirc(struct file *f);

/* brings f up to date; returns its date and time (0 when it does not exist, which is an
 * error at depth 0: nothing says how to make it) */
unsigned long pascal update(struct file *f, int depth)
{
	unsigned long t;
	unsigned long newest;
	unsigned long deptime;
	struct dep *d;
	struct rule *r;

	if (f->state == 1)
		return 0;
	if (debug)
		msg("make( %s )\n", f->name);
	if (f->time)
		return f->time;
	if (f->deps) {
		newest = 0;
		f->state = 1;
		for (d = f->deps; d; d = d->next) {
			if (d->file == f)
				break;
			t = update(d->file, 0);
			if (t > newest) {
				if (debug)
					msg("%s is newest\n", d->file->name);
				newest = t;
			}
		}
		f->state = 0;
	} else if (f->cmds)
		newest = now();
	else
		newest = 0;
	if (f->cmds) {
		t = f->time ? f->time : getage(f->name);
		if (autodep && newest <= t && strcmp(f->ext->name, "obj") == 0) {
			deptime = depcheck(f->name);
			if (deptime > newest)
				newest = deptime;
		}
		if (newest > t || t && buildall) {
			docmds(f->name, f->cmds, f->name);
			return f->time = now();
		}
		return f->time = t;
	}
	if (f->ext) {
		f->state = 1;
		for (r = f->ext->rules; r; r = r->next) {
			t = tryrule(f, f->path, r->from);
			if (t == 0)
				continue;
			if (t > newest)
				newest = t;
			t = f->time ? f->time : getage(f->name);
			if (debug)
				msg("aging %s %lx ? %lx\n", f->name, t, newest);
			if (autodep && newest <= t && strcmp(f->ext->name, "obj") == 0) {
				deptime = depcheck(f->name);
				if (deptime > newest)
					newest = deptime;
			}
			if (newest > t || t && buildall) {
				if (debug)
					msg("rebuilding %s\n", f->name);
				docmds(srcname(f, f->path, r->from), r->cmds, f->name);
				f->state = 0;
				return f->time = now();
			}
			f->state = 0;
			return f->time = t;
		}
		f->state = 0;
	}
	t = f->time ? f->time : getage(f->name);
	if (t == 0) {
		if (f->deps)
			return now();
		if (depth == 0)
			fatal(nohowmsg, f->name);
		else
			return 0;
	}
	return f->time = t;
}

/* writes a command's in-line files, expanding macros, with \r\n line ends */
void pascal writeinline(struct inl *list, char *path)
{
	struct line *l;
	register int n;
	register int fd;

	for (; list; list = list->next) {
		if ((fd = _creat(list->name, 0)) == -1) {
			msg("Fatal:  Could not create temporary file '%s'\n", list->name);
			exit(1);
		}
		for (l = list->lines; l; l = l->next) {
			expandcmd(l->text, path);
			n = strlen(expbuf);
			if (expbuf[n - 1] == '\n') {
				expbuf[n - 1] = '\r';
				expbuf[n] = '\n';
				n++;
				expbuf[n] = 0;
			}
			_write(fd, expbuf, n);
		}
		_close(fd);
	}
}

void pascal delinline(struct inl *list)
{
	for (; list; list = list->next)
		unlink(list->name);
}

/* runs one command: @ keeps it from being shown, -n lets exit codes up to n pass, and
 * - alone or -i any exit code */
int pascal runcmd(char *cmd, int *cutoff)
{
	char *p;
	char *end;
	char *name;
	register int quiet;

	if (noexec) {
		msg("\t%s\r\n", cmd);
		return 0;
	}
	for (p = cmd; *p == ' '; p++)
		;
	quiet = silent;
	*cutoff = 0;
	if (*p == '@') {
		p++;
		quiet = 1;
	}
	if (*p == '-') {
		p++;
		if (isdigit(*p))
			while (isdigit(*p)) {
				*cutoff = *cutoff * 10 + *p - '0';
				p++;
			}
		else
			*cutoff = 0x7FFF;
		for (; *p == ' '; p++)
			;
	}
	if (ignore)
		*cutoff = 0x7FFF;
	if (*p == '@') {
		p++;
		quiet = 1;
	}
	for (; *p == ' '; p++)
		;
	name = p;
	for (p = name; *p && *p != ' '; p++)
		;
	end = p;
	for (; *p == ' '; p++)
		;
	if (!quiet)
		msg("\t%s\r\n", cmd);
	*end = 0;
	if (strlen(p) > 127)
		fatal(toolongmsg);
	return execute(name, p);
}

/* adds cmd to the { } batch, running the batch first when cmd does not belong to it;
 * -1 when cmd has no braces and must run by itself */
int pascal batch(char *cmd, int *cutoff)
{
	register int rc;

	if ((lbrace = strchr(cmd, '{')) == NULL || (rbrace = strchr(cmd, '}')) == NULL || rbrace <= lbrace) {
		if (batchbuf[0]) {
			rc = runcmd(batchbuf, cutoff);
			batchbuf[0] = 0;
			batchend = NULL;
			if (rc < 0 || *cutoff < rc)
				return rc;
			return -1;
		}
		return -1;
	}
	*lbrace++ = 0;
	*rbrace++ = 0;
	if (strlen(lbrace) + strlen(batchbuf) + 1 > 128) {
		rc = runcmd(batchbuf, cutoff);
		batchbuf[0] = 0;
		batchend = NULL;
		if (rc < 0 || *cutoff < rc)
			return rc;
	}
	if (batchbuf[0] == 0) {
		strcpy(batchbuf, cmd);
		batchend = batchbuf + strlen(batchbuf);
		strcat(batchbuf, rbrace);
	} else if ((strncmp(batchbuf, cmd, strlen(cmd)) || strncmp(batchend, rbrace, strlen(batchend))) && batchbuf[0]) {
		rc = runcmd(batchbuf, cutoff);
		if (rc < 0 || *cutoff < rc)
			return rc;
		strcpy(batchbuf, cmd);
		strcat(batchbuf, lbrace);
		rc = runcmd(batchbuf, cutoff);
		batchbuf[0] = 0;
		batchend = NULL;
		if (rc < 0 || *cutoff < rc)
			return rc;
	}
	rc = strlen(lbrace);
	memmove(batchend + rc, batchend, strlen(batchend) + 1);
	strncpy(batchend, lbrace, rc);
	batchend = batchend + rc;
	return 0;
}

/* runs a target's commands, with src for $* and the like; a failing command deletes the
 * target and ends MAKE */
void pascal docmds(char *src, struct cmd *cmds, char *target)
{
	int cutoff;
	char path[80];
	register int rc;
	register int direct;

	strcpy(path, src);
	do {
		cutoff = 0;
		direct = 0;
		if (!noexec || keeptemp)
			writeinline(cmds->inl, path);
		expandcmd(cmds->text, path);
		if ((rc = batch(expbuf, &cutoff)) == -1) {
			rc = runcmd(expbuf, &cutoff);
			direct = 1;
		}
		if (!keeptemp)
			delinline(cmds->inl);
		if (debug)
			msg("exit code = %d cutoff = %d\n", rc, cutoff);
		if (rc < 0 || rc > cutoff) {
			if (direct) {
				unlink(target);
				msg("\n** error %d ** deleting %s\n", rc, target);
			}
			_exit(1);
		}
	} while ((cmds = cmds->next) != NULL);
}

/* the source of target f for a rule from extension e, in macname */
char *pascal srcname(struct file *f, char *path, struct ext *e)
{
	char name[MAXFILE];
	char drive[MAXDRIVE];
	char dir[MAXDIR];

	fnsplit(f->name, drive, dir, name, NULL);
	if (*path)
		fnmerge(macname, "", path, name, ".");
	else if (e->path)
		fnmerge(macname, "", e->path, name, ".");
	else if (f->pathed)
		fnmerge(macname, drive, NULL, name, ".");
	else
		fnmerge(macname, drive, dir, name, ".");
	strcat(macname, e->name);
	return macname;
}

unsigned long pascal tryrule(struct file *f, char *path, struct ext *e)
{
	return update(definefile(strsave(srcname(f, path, e)), ""), 1);
}

/* .AUTODEPEND: -1 when a file named in the object file's dependency records (OMF comment
 * class E9h) has another date than the one recorded, else 0 */
unsigned long pascal depcheck(char *name)
{
	int type;
	unsigned long t;
	unsigned char rec[128];
	char fname[80];
	int state;
	register int fd;

	state = -1;
	fd = _open(name, 0);
	if (fd < 0)
		return 0;
	type = readrec(fd, rec);
	if (type != 0x80)
		goto done;
	while ((type = readrec(fd, rec)) == 0x88 || state == 1) {
		if (type == 0x88 && rec[4] == 0xE9) {
			if (rec[1] == 3) {
				if (state != -1)
					break;
				state = 1;
			} else {
				if (state == -1)
					state = 0;
				movmem(rec + 10, fname, rec[9]);
				fname[rec[9]] = 0;
				t = getage(fname);
				if (t != *(unsigned long *)(rec + 5)) {
					_close(fd);
					return -1;
				}
			}
		}
	}
done:
	_close(fd);
	return 0;
}

/* the next OMF record of fd into rec (at most 128 bytes are kept); its type, or 0 */
int pascal readrec(register int fd, unsigned char *rec)
{
	register int len;

	if (_read(fd, rec, 3) != 3)
		return 0;
	len = *(int *)(rec + 1);
	if (len > 125) {
		if (_read(fd, rec + 3, 125) != 125)
			return 0;
		if (lseek(fd, (long)(len - 125), SEEK_CUR) < 0)
			return 0;
		(void)1;	/* match: keeps the jump past the else */
	} else if (_read(fd, rec + 3, len) != len)
		return 0;
	return rec[0];
}

/* gives a file without a directory its extension's .path. directory */
void pascal findpath(struct file *f)
{
	char drive[MAXDRIVE];
	char name[MAXFILE];
	char ext[MAXEXT];
	char dir[MAXDIR];
	char path[MAXPATH];

	fnsplit(f->name, drive, dir, name, ext);
	if (!dir[0] && f->ext) {
		if (f->ext->path) {
			fnmerge(path, drive, f->ext->path, name, ext);
			f->name = strsave(path);
			f->pathed = 1;
		} else
			f->pathed = 0;
	} else
		f->pathed = 0;
}

/* reports a cycle in the dependencies below f, printing the chain */
void pascal checkcirc(struct file *f)
{
	struct dep *d;

	if (f->state != 0) {
		if (f->state != 3) {
			error(circmsg);
			msg("  %s", f->name);
			f->state = 3;
			d = f->deps;
			for (;;) {
				for (; d && !d->file->state; d = d->next)
					;
				if (d == NULL)
					return;
				msg(" -> %s", d->file->name);
				if (d->file->state == 3)
					break;
				d = d->file->deps;
				(void)2;
			}
			msg("\n");
		}
	} else {
		f->state = 1;
		findpath(f);
		for (d = f->deps; d; d = d->next)
			checkcirc(d->file);
		if (f->state != 3)
			f->state = 0;
	}
}

unsigned long pascal make(struct file *f, int depth)
{
	int cutoff;
	unsigned long t;

	cutoff = 0;
	if (f == NULL)
		return 0;
	checkcirc(f);
	t = update(f, depth);
	batch(" ", &cutoff);
	return t;
}
