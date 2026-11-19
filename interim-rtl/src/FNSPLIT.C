/* target: FNSPLIT */
/* opts: -mc -O -Z -a */
/* FNSPLIT.C: fnsplit() of the interim run-time library (../README.md), as MAKE.EXE of
 * Borland C++ 2.0 has it: CopyIt() takes the full buffer size and clears the source itself,
 * and a path's '.' always ends the extension. */
#include <dir.h>
#include <string.h>

static void pascal CopyIt(char *dst, char *src, register unsigned maxlen)
{
	if (dst) {
		strncpy(dst, src, maxlen - 1);
		dst[maxlen - 1] = 0;
	}
	*src = 0;
}

int fnsplit(const char *path, char *drive, char *dir, char *name, char *ext)
{
	register int ret;
	register int wrk;
	char buf[MAXPATH + 2];
	char *p;

	ret = 0;
	p = buf;
	if (drive)
		*drive = 0;
	if (dir)
		*dir = 0;
	if (name)
		*name = 0;
	if (ext)
		*ext = 0;
	while (*path == ' ')
		path++;
	if ((wrk = strlen(path)) > MAXPATH)
		wrk = MAXPATH;
	*p++ = 0;
	strncpy(p, path, wrk);
	p += wrk;
	*p = 0;
	wrk = 0;
	for (;;) {
		switch (*--p) {
		case '.':
			if (!wrk && !(ret & EXTENSION)) {
				ret |= EXTENSION;
				CopyIt(ext, p, MAXEXT);
			}
			continue;
		case ':':
		case 0:
			if (wrk) {
				if (*++p)
					ret |= DIRECTORY;
				CopyIt(dir, p, MAXDIR);
				p--;
				break;
			}
		case '/':
		case '\\':
			if (!wrk) {
				wrk++;
				if (*++p)
					ret |= FILENAME;
				CopyIt(name, p, MAXFILE);
				p--;
				if (*p == ':' || *p == 0)
					break;
			}
			continue;
		case '*':
		case '?':
			if (!wrk)
				ret |= WILDCARDS;
			continue;
		default:
			continue;
		}
		break;
	}
	if (*p == ':') {
		if (buf[1])
			ret |= DRIVE;
		CopyIt(drive, &buf[1], MAXDRIVE);
	}
	return ret;
}
