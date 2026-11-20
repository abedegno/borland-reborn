/* target: SPAWN */
/* opts: -mc -O -Z -d -a -y */
/* SPAWN.C: the C half of running commands with -S, and redirection. redirect() opens a
 * file in place of handle 0 or 1 by closing that handle's entry in the PSP's file table
 * (offset 18h) first, so that DOS gives the new file that handle; unredirect() puts the old
 * entry back. swapspawn() runs a command through doswap() (SWAP.ASM) and returns its exit
 * code. */
#include <dos.h>
#include <io.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdio.h>
#include "MAKE.H"

void pascal unredirect(int saved, register int fd)
{
	if (saved >= 0) {
		_close(fd);
		_ES = _psp;
		_BX = fd + 0x18;
		*(char _es *)_BX = saved;
	}
}

int pascal redirect(char *name, int fd, register int mode)
{
	int newfd;
	int perm;
	int saved;

	saved = -1;
	perm = (mode & O_RDONLY) ? S_IREAD : S_IWRITE;
	if (name == NULL || *name == 0)
		return saved;
	_ES = _psp;
	_BX = fd + 0x18;
	saved = *(unsigned char _es *)_BX;
	*(unsigned char _es *)_BX = 0xFF;
	newfd = open(name, mode, perm);
	if (newfd == -1) {
		if (mode == O_RDONLY)
			puts("File not found");
		else
			puts("File creation error");
		unredirect(saved, fd);
		saved = -2;
		return saved;
	}
	if (mode & O_TRUNC)
		chsize(newfd, 0L);
	if (mode & O_APPEND)
		lseek(newfd, 0L, SEEK_END);
	return saved;
}

/* the exit code of the last child process (DOS function 4Dh) */
int getrc(void)
{
	_AH = 0x4D;
	geninterrupt(0x21);
}				/* returns AX, as the original does */

/* the largest free block of memory in bytes (DOS function 48h); never called */
long maxmem(void)
{
	_AH = 0x48;
	_BX = 0xFFFF;
	geninterrupt(0x21);
	return (unsigned long)_BX << 4;
}

int pascal swapspawn(char *prog, char *args)
{
	register int rc;

	rc = doswap(prog, args);
	if (rc != 0)
		return rc;
	return getrc();
}
