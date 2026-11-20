/* target: PRJFILE */
/* opts: -ml */
/* PRJFILE.CPP: PrjFile, a project file read and written through stdio, which keeps count of
 * where it is. Each read or write returns 0, or 1 when it fell short. */
#include <stdio.h>
#include "PRJFILE.H"

FILE *PrjFile::open(char *name, char *mode)
{
	pos = 0;
	return fp = fopen(name, mode);
}

int PrjFile::read(void *buf, unsigned n)
{
	unsigned got;

	if ((got = fread(buf, 1, n, fp)) < n)
		return 1;
	pos += n;
	return 0;
}

int PrjFile::write(void *buf, unsigned n)
{
	unsigned put;

	if ((put = fwrite(buf, 1, n, fp)) < n)
		return 1;
	pos += n;
	return 0;
}

void PrjFile::rewind()
{
	::rewind(fp);
	pos = 0;
}

int PrjFile::skip(unsigned n)
{
	pos += n;
	return fseek(fp, n, SEEK_CUR);
}

int PrjFile::seek(unsigned where)
{
	pos = where;
	return fseek(fp, where, SEEK_SET);
}

int PrjFile::close()
{
	pos = 0;
	return fclose(fp);
}
