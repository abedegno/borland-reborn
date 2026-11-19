/* TOUCH.C: TOUCH 3.0 of Borland C++ 2.0 (1991), "TOUCH filename ...".
 *
 * Sets the date and time of each named file to now. A name may hold the DOS wildcards
 * * and ?: every file it matches is touched. A name that matches nothing, or a file that
 * cannot be opened for writing, is reported, and TOUCH goes on with the next name.
 *
 * Built with Turbo C++ 1.01 in the tiny model (TCC -mt -O -Z) and linked into a .COM file;
 * ../README.md has the build. The function and local names are descriptive: TOUCH.COM keeps
 * no names. The three globals' names are chosen to fit their order in the original's _BSS,
 * which Turbo C++ lays out by a hash of each name (Exhume's profiles/borland-tc101/
 * bssorder.py): date, then filetime, then now. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dos.h>
#include <dir.h>
#include <io.h>

struct date date;               /* today's date, from DOS */
struct ftime filetime;          /* the stamp every file gets, packed as DOS keeps it */
struct time now;                /* the time of day, from DOS */

int wild(char *pattern, int (*action)(char *));

/* Stamps one file with filetime. Returns 1, or 0 when the file cannot be opened. */
int touch(char *name)
{
	int fd;

	fd = _open(name, 2);    /* 2: DOS's read/write access code (_open takes DOS's codes) */
	if (fd < 0)
		return 0;
	setftime(fd, &filetime);
	_close(fd);
	return 1;
}

main(int argc, char *argv[])
{
	puts("Touch  Version 3.0  Copyright (c) 1991 Borland International");
	if (argc < 2) {
		puts("Usage is: TOUCH filename ...");
		exit(1);
	}
	gettime(&now);
	getdate(&date);
	filetime.ft_year = date.da_year - 1980;
	filetime.ft_month = date.da_mon;
	filetime.ft_day = date.da_day;
	filetime.ft_hour = now.ti_hour;
	filetime.ft_min = now.ti_min;
	filetime.ft_tsec = now.ti_sec / 2;      /* DOS keeps seconds in units of two */
	for (; argc > 1; argc--, argv++)
		wild(argv[1], touch);
	exit(0);
}

/* Calls action on the full path of every file that pattern matches, in the order DOS finds
 * them. Returns 1 when every call succeeded; reports the path and returns 0 when nothing
 * matches or a call fails. */
int wild(char *pattern, int (*action)(char *))
{
	struct ffblk found;
	char path[82];          /* pattern's directory part, then each match's name */
	char *name;             /* where the name part starts in path */
	char *pat = pattern;    /* match: a register copy (DI); the parameter itself stays on the stack */

	strcpy(path, pat);
	if (findfirst(pat, &found, 0) >= 0) {
		/* keep the drive and directory: the name starts after the last ':', '/' or '\' */
		for (name = path + strlen(path) - 1; name >= path; name--)
			if (*name == ':' || *name == '/' || *name == '\\')
				break;
		name++;
		do {
			strcpy(name, found.ff_name);
			if (!(*action)(path))
				goto failed;
		} while (findnext(&found) >= 0);
		return 1;
	}
failed:
	fputs("Unable to open file ", stdout);
	puts(path);
	return 0;
}
