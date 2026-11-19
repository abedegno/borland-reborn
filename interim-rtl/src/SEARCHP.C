/* target: SEARCHP */
/* opts: -mc -B -O -Z */
/* SEARCHP.C: searchpath() and __searchpath() of the interim run-time library (../README.md),
 * as MAKE.EXE of Borland C++ 2.0 has it: Borland C++ 2.0's own module but for the drive
 * letter, which this one stores with one conditional expression. */
#include <dir.h>
#include <dos.h>
#include <stdlib.h>
#include <string.h>

static char s_ext[MAXEXT + 1];
static char s_dirs[MAXDIR + 1];
static char s_path[MAXPATH];
static char s_fname[MAXFILE + 1];
static char s_drive[MAXDRIVE + 1];

/* copies src to dst in upper case; returns the end of dst */
static char *pascal CopyUpper(char *dst, char *src)
{
	asm	push	ds
	asm	lds	si, src
	asm	les	di, dst
	asm	cld
next:
	asm	lodsb
	asm	cmp	al, 'a'
	asm	jb	store
	asm	cmp	al, 'z'
	asm	ja	store
	asm	sub	al, 'a' - 'A'
store:
	asm	stosb
	asm	or	al, al
	asm	jnz	next
	asm	dec	di
	asm	xchg	ax, di
	asm	pop	ds
	asm	mov	dx, es
}

static int pascal TryPath(char *path, char *drive, char *dir, char *name, char *ext, int mode)
{
	char *p;
	struct ffblk ff;

	p = path;
	*drive = *drive == 0 ? getdisk() + 'A' : *drive & 0xDF;
	asm ;		/* match: the original reloads drive here, as after an asm statement */
	*p++ = *drive;
	*p++ = ':';
	if (*dir != '\\' && *dir != '/') {
		*p++ = '\\';
		getcurdir(*drive - '@', p);
		if (*p) {
			p = CopyUpper(p, p);
			*p++ = '\\';
		}
	}
	p = CopyUpper(p, dir);
	if (p[-1] != '\\' && p[-1] != '/')
		*p++ = '\\';
	p = CopyUpper(p, name);
	if (ext)
		CopyUpper(p, ext);
	return findfirst(path, &ff, (mode & 2) ? 0x27 : 0x37) + 1;
}

char *pascal __searchpath(char *file, register int mode)
{
	char *path;
	char *env;
	register int flags;

	path = s_path;
	env = NULL;
	flags = 0;
	if (file != NULL || *file)
		flags = fnsplit(file, s_drive, s_dirs, s_fname, s_ext);
	if ((flags & (WILDCARDS | FILENAME)) != FILENAME)
		return NULL;
	if (mode & 2) {
		if (flags & DIRECTORY)
			mode &= ~1;
		if (flags & EXTENSION)
			mode &= ~2;
	}
	if (mode & 1)
		env = getenv("PATH");
	for (;;) {
		if (TryPath(path, s_drive, s_dirs, s_fname, s_ext, mode))
			break;
		if (mode & 2) {
			if (TryPath(path, s_drive, s_dirs, s_fname, ".COM", mode))
				break;
			if (TryPath(path, s_drive, s_dirs, s_fname, ".EXE", mode))
				break;
		}
		if (env == NULL || *env == 0) {
			path = NULL;
			break;
		}
		flags = 0;
		if (env[1] == ':') {
			s_drive[flags++] = *env++;
			s_drive[flags++] = *env++;
		}
		s_drive[flags] = 0;
		for (flags = 0; (s_dirs[flags] = *env++) != 0; flags++)
			if (s_dirs[flags] == ';') {
				s_dirs[flags] = 0;
				env++;
				break;
			}
		env--;
		if (s_dirs[0] == 0) {
			s_dirs[0] = '\\';
			s_dirs[1] = 0;
		}
	}
	return path;
}

char *searchpath(const char *file)
{
	return __searchpath((char *)file, 1);
}
