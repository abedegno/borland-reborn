/* target: TKINST */
/* opts: -mh */
/* TKINST.C: TKINST 2.0, the installer of TKERNEL, the protected-mode kernel the Borland C++
 * 2.0 tools (BCCX, TLINKX, TASMX) run under.
 *
 * TKERNEL keeps a database of machines, by BIOS checksum, with how each one enables and
 * disables A20 and gets back from protected mode. TKINST finds that database in
 * TKERNEL.EXE ("!!MACHINE_DB!!"), has ANALYZE.ASM work out this machine's entry, writes it
 * into a free slot, and appends it to a .DB file for Borland.
 *
 * Built by Borland C++ 2.0's BCC, huge model, without -O. TKINST.EXE keeps no symbols: the
 * names are descriptive. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <io.h>
#include <errno.h>

/* in ANALYZE.ASM */
extern int quiet;
extern int switchtime;
extern char romname[];
extern int analyze(unsigned char *entry, unsigned char *db, int count);
extern int checkcpu(void);
extern long bioschecksum(void);

unsigned long version = 0x02000201L;
char *dbname = 0;

void usage(void)
{
	printf("Syntax: TKINST [options]\n");
	printf("     -h,-?        Show this help screen\n");
	printf("     -k<path>     Name of kernel file\n");
	printf("     -g           Just check the database\n");
	printf("     -a           Analyze only, don't try to configure\n");
	printf("     -v           Verbose mode\n");
	printf("     -d<path>     database name (names .db file) default is TKINST.DB\n");
	printf("     -x           Don't try to update\n");
	printf("     -t           Report switch time\n");
	printf("     -c           Don't delete checkpoint file\n");
	printf("     -s           Just show the settings for this machine\n");
	printf("     -f<string>   Force characteristic string to TKERNEL\n");
	printf("                  (format is  ee/dd/ss/ffff/oooo )\n");
	exit(0);
}

/* -X with letter *opt: (char *)-1 when the current argument is not it; else its value
 * (hasarg), or 0. "-ab" is taken as -a, then -b. */
char *option(char ***argvp, int *argcp, char *opt, int hasarg)
{
	if (***argvp != '-' || (**argvp)[1] != *opt)
		return (char *)-1L;
	else if (hasarg) {
		if ((**argvp)[2])
			return **argvp + 2;
		else {
			--*argcp;
			return *++*argvp;
		}
	} else if ((**argvp)[2]) {
		(**argvp)[1] = '-';
		(**argvp)++;
		*argvp -= 1;
		++*argcp;
	}
	return 0;
}

/* a .DB name: quotes dropped, upper case, at most 8 characters.
 * (p[-1] = *p++ copies each character onto itself: BCC increments p before it stores, so
 * the opening quote stays; the closing one ends the name.) */
void fixname(char *s)
{
	char *p;

	if (*s == '"')
		for (p = s + 1; p[-1] != 0; p[-1] = *p++)
			if (p[-2] == '"')
				p[-2] = 0;
	for (p = s; *p != 0; p++)
		*p = toupper(*p);
	if (strlen(s) > 8)
		s[8] = 0;
}

void parseargs(int argc, char **argv, char **kernel, int *analyzeonly, int *quietp,
	char **dbnamep, int *showset, int *reporttimep, int *delcheck, char **force,
	int *noupdate, int *opt3, int *checkdb)
{
	char *s;

	*analyzeonly = *reporttimep = *noupdate = *opt3 = *showset = *checkdb = 0;
	*quietp = *delcheck = 1;
	while (argv++, --argc) {
		if ((s = option(&argv, &argc, "k", 1)) != (char *)-1L)
			*kernel = s;
		else if (option(&argv, &argc, "a", 0) != (char *)-1L)
			*analyzeonly = 1;
		else if (option(&argv, &argc, "v", 0) != (char *)-1L)
			*quietp = 0;
		else if (option(&argv, &argc, "t", 0) != (char *)-1L)
			*reporttimep = 1;
		else if (option(&argv, &argc, "s", 0) != (char *)-1L)
			*showset = 1;
		else if (option(&argv, &argc, "g", 0) != (char *)-1L)
			*checkdb = 1;
		else if (option(&argv, &argc, "c", 0) != (char *)-1L)
			*delcheck = 0;
		else if ((s = option(&argv, &argc, "d", 1)) != (char *)-1L) {
			fixname(s);
			*dbnamep = s;
		} else if (option(&argv, &argc, "x", 0) != (char *)-1L)
			*noupdate = 1;
		else if ((s = option(&argv, &argc, "f", 1)) != (char *)-1L)
			*force = s;
		else if (option(&argv, &argc, "3", 0) != (char *)-1L)
			*opt3 = 1;
		else
			usage();
	}
}

/* the file position just past "!!MACHINE_DB!!" in TKERNEL, or -1 */
long finddb(int fd)
{
	char *p;
	char *marker = "!!MACHINE_DB!!";
	char *m;
	char buf[256];
	int n;

	m = marker;
	while ((n = read(fd, buf, 256)) > 0)
		for (p = buf; n--; p++)
			if (*p == *m) {
				m++;
				if (*m == 0)
					return lseek(fd, 0L, SEEK_CUR) - n;
			} else
				m = marker;
	return -1L;
}

/* words that a BIOS copyright or version string starts near */
char *names[] = {
	"Version", "version", "BIOSIBM", "Phoenix", "Award", "AMI", "CHIPS", "DTK",
	"Copyright", "COPYRIGHT", "\0"
};
int reporttime = 0;

/* copies the printable text around the first key in the BIOS ROM (F000:8000 up) into out */
void findrom(char *key, char *out)
{
	unsigned long p;
	char *q;
	char *start;

	*out = 0;
	start = out;
	for (p = 0xF0008000L; p < 0xF000FFFFL; ) {
		if ((q = strstr((char *)p, key)) == 0) {
			if (*(char *)p == 0)
				p++;
			else
				p += strlen((char *)p);
		} else {
			while (q[-1] >= ' ' && q[-1] <= '~')
				q--;
			while (*q >= ' ' && *q <= '~' && (long)(unsigned)out - (unsigned)start < 80)
				*out++ = *q++;
			break;
		}
	}
	*out = 0;
}

void checkrom(char *out)
{
	char **n;

	for (n = names; **n != 0; n++) {
		findrom(*n, out);
		if (*out != 0)
			break;
	}
}

/* A database entry (16 bytes): A20 enable and disable methods, the shutdown method, two
 * words of flags, the BIOS checksum (7), and three more fields (11, 12, 14). */
void showchar(unsigned char *c)
{
	if (quiet == 0) {
		printf("\n\tEnable A20 method:      %02X\n", c[0]);
		printf("\tDisable A20 method:     %02X\n", c[1]);
		printf("\tShutdown method:        %02X\n", c[2]);
		printf("\tShutdown flags:       %04X\n", *(int *)(c + 3));
		printf("\tOther flags:          %04X\n", *(int *)(c + 5));
		printf("\tBIOS checksum:    %08lX\n", *(long *)(c + 7));
		printf("\n");
	}
}

void showtime(void)
{
	long ticks = 32000L;

	printf("\n  Protected mode switch time: %ld usec\n", switchtime * 1000000L / ticks);
	printf("  (For comparison only.  Your actual switch time may vary.)\n");
}

void parsechar(char *s, unsigned char *c)
{
	int e, d, sh, f, o;

	if (sscanf(s, "%2x/%2x/%2x/%4x/%4x", &e, &d, &sh, &f, &o) < 5) {
		printf("  TKINST: invalid characteristic string\n");
		exit(1);
	} else {
		c[0] = e;
		c[1] = d;
		c[2] = sh;
		*(int *)(c + 3) = f;
		*(int *)(c + 5) = o;
	}
}

int openkernel(char **name)
{
	int fd;

	if (*name == 0)
		*name = "TKERNEL.EXE";
	fd = open(*name, O_RDWR | O_BINARY);
	return fd;
}

/* appends the entry to NAME.DB. (The test for fopen's failure compares the pointer with
 * 0 by its offset as unsigned, so it is never true.) */
void writedb(char *name, char *rom, unsigned char *c, int first)
{
	char path[80];
	FILE *f;

	path[0] = 0;
	if ((f = fopen(strcat(strcpy(path, name), ".DB"), "a")) < 0) {
		printf("can't open .db file\n");
		exit(1);
	}
	if (first) {
		fprintf(f, "%s\n", "Please send this file to Borland International.");
		fprintf(f, "%s\n\n", "");
	}
	fprintf(f, "; %s\n", rom);
	fprintf(f, "db_entry 0%02Xh 0%02Xh 0%02Xh 0%04Xh 0%04Xh 0%08lXh 0%02Xh 0%04Xh 0%04Xh\n",
		c[0], c[1], c[2], *(int *)(c + 3), *(int *)(c + 5), *(long *)(c + 7), c[11],
		*(int *)(c + 12), *(int *)(c + 14));
	fclose(f);
}

void writekernel(int fd, long pos, unsigned char *db, int count)
{
	if (lseek(fd, pos, SEEK_SET) == -1L)
		printf("\nTKINST: seek error %d\n", errno);
	if (write(fd, db, count << 4) == -1)
		printf("\nTKINST: write error %d\n", errno);
	if (close(fd) == -1) {
		printf("\nTKINST: error closing TKERNEL: %d\n", errno);
		exit(1);
	}
}

int main(int argc, char **argv)
{
	int fd, done;
	char *kernel;
	int count;
	int i;
	int result;
	long dbpos;
	int analyzeonly;
	int delcheck;
	int noupdate;
	int opt3;
	int showset;
	int checkdb;
	char *force;
	unsigned char *db;
	unsigned char *entry;
	long checksum;
	int major, minor;
	char buf[80];

	major = (int)((version & 0xFF000000L) >> 24);
	minor = (int)((version & 0x00FF0000L) >> 16);
	printf("TKINST   Version %d.%d  ", major, minor);
	printf("Copyright (c) 1989, 1991 Borland International\n");
	kernel = force = 0;
	parseargs(argc, argv, &kernel, &analyzeonly, &quiet, &dbname, &showset, &reporttime,
		&delcheck, &force, &noupdate, &opt3, &checkdb);
	if (opt3 && !checkcpu())
		exit(0);
	if (analyzeonly) {
		if (dbname == 0 && !noupdate)
			dbname = "TKINST";
		entry = malloc(16);
		if ((result = analyze(entry, db, 0)) == 0)
			showchar(entry);
		else if (result < 0)
			printf("\nTKINST is unable to make a conclusive analysis of this machine\n");
		if (dbname)
			writedb(dbname, romname, entry, 0);
		if (reporttime)
			showtime();
		if (delcheck)
			remove("__CFGCK.DAT");
		exit(0);
	}
	fd = openkernel(&kernel);
	if (fd == -1) {
		if (showset) {
			printf("TKINST: BIOS checksum is %8lx\n", bioschecksum());
			exit(0);
		}
		switch (errno) {
		case EACCES:
			printf("TKINST: can't access TKERNEL file: %s\n", kernel);
		case ENOENT:
			printf("TKINST: cannot find TKERNEL file: %s\n", kernel);
		}
		exit(1);
	}
	dbpos = finddb(fd);
	if (dbpos == -1L) {
		printf("TKINST: cannot find machine database in TKERNEL\n");
		exit(1);
	}
	lseek(fd, dbpos, SEEK_SET);
	read(fd, &count, 2);
	dbpos += 2;
	db = malloc(count << 4);
	if (db)
		read(fd, db, count << 4);
	else {
		printf("TKINST: couldn't allocate memory\n");
		exit(1);
	}
	checksum = bioschecksum();
	for (i = 0, entry = db; i < count; entry += 16, i++)
		if (*entry == 0 || *(long *)(entry + 7) == checksum)
			break;
	if (i == count) {
		printf("TKINST: no free entries in database\n");
		exit(1);
	}
	if (checkdb) {
		if (*(long *)(entry + 7) == checksum) {
			printf("TKINST: machine already in TKERNEL's database\n");
			exit(0);
		} else {
			printf("TKINST: machine not in database (%8lx)\n", checksum);
			exit(1);
		}
	}
	if (showset) {
		if (*(long *)(entry + 7) == checksum) {
			printf("Current database entry for this machine:\n");
			quiet = 0;
			showchar(entry);
		} else
			printf("TKINST: machine not in database (%8lx)\n", checksum);
		exit(0);
	}
	if (force) {
		parsechar(force, entry);
		*(long *)(entry + 7) = bioschecksum();
		writekernel(fd, dbpos, db, count);
		printf("\nTKINST: TKERNEL file %s updated\n", kernel);
		exit(0);
	}
	done = analyze(entry, db, count);
	if (delcheck)
		remove("__CFGCK.DAT");
	if (done == 0) {
		writekernel(fd, dbpos, db, count);
		dbname = ultoa(checksum, buf, 16);
		checkrom(romname);
		writedb(dbname, romname, entry, 1);
		if (reporttime)
			showtime();
		showchar(entry);
		printf("TKINST: TKERNEL file %s updated\n\n", kernel);
		printf("        The file %s.db contains a copy of this machine's\n", dbname);
		printf("        information that is stored in TKERNEL.EXE.  Please send\n");
		printf("        this file to Borland International so that we can include\n");
		printf("        this machine's information in later versions of TKERNEL.\n");
		exit(0);
	} else if (done == 1) {
		printf("TKINST: machine already in TKERNEL's database\n");
		exit(0);
	} else if (done == 2)
		exit(0);
	else if (done == -1) {
		printf("\nTKINST is unable to make a conclusive analysis of this machine\n");
		exit(0);
	}
}
