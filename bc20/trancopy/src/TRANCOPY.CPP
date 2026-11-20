/* target: TRANCOPY */
/* opts: -ml -vi- */
/* TRANCOPY.CPP: TRANCOPY 2.0, which copies the Transfer menu between two Turbo C++ / Borland
 * C++ project files (.PRJ).
 *
 * A project file is a header, then sections from offset 20h on: each a 2-byte id, a 2-byte
 * size and the data. Section 10 holds the transfer items, 323 bytes each; TRANCOPY merges
 * the source project's items into the destination's (or replaces them, -r) and writes the
 * destination's sections back in the order it keeps them.
 *
 * Built by Borland C++ 2.0 as C++, large model, without -O, and with inline expansion off
 * (-vi-): PrjFile::tell() is called, and its out-of-line copy (a "virtual segment" in the
 * object) is placed by TLINK after this file's code. TRANCOPY.EXE keeps no symbols: the class
 * and member names are descriptive (their mangled forms are what the object file holds). */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mem.h>
#include "PRJFILE.H"

/* one section of a project file, found by its id and read whole into memory */
class Section {
public:
	PrjFile *file;
	int pos;
	int id;
	unsigned size;
	void *data;

	Section(PrjFile *f, int want);
	~Section();
	virtual int read();
	virtual int write(PrjFile *out);
};

/* a Transfer menu item, as the IDE stores it */
struct Transfer {
	char flags;
	char title[40];
	char program[80];
	char options[200];
	int hotkey;		/* 0, or a code from -56 to -47 (see merge) */
};

/* section 10: the Transfer menu */
class TransferSection : public Section {
public:
	int count;

	TransferSection(PrjFile *f);
	int read();
	Transfer *item(int i);
	int merge(TransferSection *dst);
};

/* finds section `want`; its id is -2 when the file has none */
Section::Section(PrjFile *f, int want)
{
	int err;

	file = f;
	data = 0;
	err = file->seek(0x20);
	do {
		pos = (int)file->tell();
		err |= file->read(&id, 2);
		err |= id != 10 && id != 0x32 && id != 0x33 && id != 0x34 && id != 0x35 &&
			id != 0x36 && id != 0x37 && id != -1;
		err |= file->read(&size, 2);
		err |= file->skip(size);
	} while (id != -1 && id != want);
	if (id != want) {
		id = -2;
		pos = 0;
		size = 0;
	}
	if (err)
		printf("Invalid project file\n");
}

Section::~Section()
{
	if (data)
		free(data);
}

int Section::read()
{
	int err = 0;

	if (id != -2 && size != 0) {
		data = malloc(size);
		if (!data)
			return 1;
		err = file->seek(pos + 4);
		err |= file->read(data, size);
	}
	return err;
}

int Section::write(PrjFile *out)
{
	int err = 0;

	if (id != -2) {
		err = out->write(&id, 2);
		err |= out->write(&size, 2);
		err |= out->write(data, size);
	}
	return err;
}

TransferSection::TransferSection(PrjFile *f) : Section(f, 10)
{
	count = -1;
}

int TransferSection::read()
{
	int err = Section::read();

	count = size / sizeof(Transfer);
	return err;
}

Transfer *TransferSection::item(int i)
{
	if (i < count)
		return (Transfer *)data + i;
	else
		return 0;
}

/* Merges this project's items into dst's: an item with the same title replaces dst's (when
 * it differs), any other is added before dst's last item, at most 16 in all. A hot key that
 * one of dst's first ten items uses is cleared. Returns how many items did not fit, or -1 when out of memory.
 * used[] is indexed by hotkey + 0x38: a hot key outside -56..-47 would fall outside it. */
int TransferSection::merge(TransferSection *dst)
{
	Transfer *s, *d;
	int found, room, failed;
	char name[160];
	int used[10];
	int i, j;

	failed = 0;
	for (i = 0; i < 10; i++)
		used[i] = 0;
	for (i = 0; i < 10; i++) {
		d = dst->item(i);
		if (d && d->hotkey)
			used[d->hotkey + 0x38] = 1;
	}
	for (i = 0; i < count; i++) {
		room = dst->count < 16;
		found = 0;
		s = item(i);
		for (j = 0; j < dst->count; j++) {
			d = dst->item(j);
			found = strcmp(s->title, d->title) == 0;	/* match: not !strcmp() */
			if (!found)
				continue;
			if (strcmp(s->program, d->program) || strcmp(s->options, d->options)) {
				strcpy(name, s->title);
				printf("Replacing %s", name);
				if (s->hotkey && used[s->hotkey + 0x38]) {
					printf(" (hot key changed to \"Unassigned\")");
					s->hotkey = 0;
				}
				memmove(d, s, sizeof(Transfer));
				printf("\n");
			}
			break;
		}
		if (found)
			continue;
		strcpy(name, s->title);
		if (room) {
			printf("Adding %s", name);
			if (s->hotkey && used[s->hotkey + 0x38]) {
				printf(" (hot key changed to \"Unassigned\")");
				s->hotkey = 0;
			}
			if ((dst->data = realloc(dst->data, dst->size + sizeof(Transfer))) == 0)
				return -1;
			dst->size += sizeof(Transfer);
			dst->count++;
			d = dst->item(dst->count - 1);
			memmove(d, dst->item(dst->count - 2), sizeof(Transfer));
			memmove(dst->item(dst->count - 2), s, sizeof(Transfer));
			printf("\n");
		} else {
			failed++;
			printf("No room to add %s\n", name);
		}
	}
	return failed;
}

unsigned long version = 0x02000002L;
char *prjsig = "Turbo C Project File \x1a";
char *prjsig2 = "\x01\r\x12\x17\x01\x1a\0";

/* 1: a project file of version ver, 2: another minor version, 0: another major version,
 * 3: not a project file at all */
static int near checkheader(PrjFile &f, char *sig, unsigned ver)
{
	char buf[82];
	unsigned v;
	int err, result;

	f.rewind();
	err = f.read(buf, strlen(sig) + 1);
	err |= strcmp(buf, sig);
	err |= f.read(buf, strlen(prjsig2) + 1);
	err |= strcmp(buf, prjsig2);
	err |= f.read(&v, 2);
	if ((v & 0xFF00) == (ver & 0xFF00)) {
		if ((v & 0xFF) == (ver & 0xFF))
			result = 1;
		else
			result = 2;
	} else
		result = 0;
	f.rewind();
	if (err)
		result = 3;
	return result;
}

/* Copies the Transfer menu from srcname into dstname; 0 when all went well. The other
 * sections are read and written back unchanged. (When dstname cannot be used, srcname is
 * left open.) */
int copy(char *srcname, char *dstname, int replace)
{
	int result = 0;
	int err;
	PrjFile src, dst;

	if (!src.open(srcname, "rb")) {
		printf("Unable to open %s\n", srcname);
		return 1;
	}
	err = checkheader(src, prjsig, 0x700);
	if (err != 1 && err != 2) {
		printf("Error:  %s is not a valid project file\n", srcname);
		src.close();
		return 1;
	}
	if (!dst.open(dstname, "r+b")) {
		printf("Unable to open %s\n", dstname);
		return 1;
	}
	err = checkheader(dst, prjsig, 0x700);
	if (err != 1 && err != 2) {
		printf("Error:  %s is not a valid project file\n", dstname);
		dst.close();
		return 1;
	}
	Section s32(&dst, 0x32);
	Section s33(&dst, 0x33);
	Section s34(&dst, 0x34);
	Section s35(&dst, 0x35);
	Section s36(&dst, 0x36);
	Section s37(&dst, 0x37);
	Section send(&dst, -1);
	TransferSection dtrans(&dst);
	TransferSection strans(&src);

	err = s32.read();
	err |= s33.read();
	err |= strans.read();
	err |= s34.read();
	err |= s35.read();
	err |= s36.read();
	err |= s37.read();
	if (err) {
		printf("Error loading project files\n");
		return err;
	}
	if (!replace) {
		err = dtrans.read();
		if (err) {
			printf("Error loading project files\n");
			return err;
		} else
			err = strans.merge(&dtrans);
		if (err < 0) {
			printf("Error merging transfer items.  Try specifying \"-r\"\n");
			return 1;
		} else if (err > 0) {
			printf("\nUse the IDE to delete %d or more translators from the destination project.\n", err);
			result = 1;
		}
	}
	err = dst.seek(0x20);
	err |= s32.write(&dst);
	err |= s33.write(&dst);
	if (replace)
		err |= strans.write(&dst);
	else
		err |= dtrans.write(&dst);
	err |= s34.write(&dst);
	err |= s35.write(&dst);
	err |= s36.write(&dst);
	err |= s37.write(&dst);
	err |= send.write(&dst);
	if (err) {
		printf("Error saving project file\n");
		return err;
	}
	err = src.close();
	err |= dst.close();
	if (err) {
		printf("Error closing project files\n");
		return err;
	}
	return result;
}

int main(int argc, char **argv)
{
	int result;
	char src[80], dst[80];
	int replace, i;

	if (argc < 3) {
		int major = (int)((version & 0xFF000000L) >> 24);
		int minor = (int)((version & 0x00FF0000L) >> 16);	/* match: masked, then shifted */

		printf("TRANCOPY  %d.%d  Copyright (c) 1991 Borland International\n", major, minor);
		printf("Syntax:   TRANCOPY [-r] <source project> <destination project>\n\n");
		printf("Merges the transfer programs in <source project> and <destination project>\n");
		printf("and writes the results to <destination project>.\n\n");
		printf("-r causes the transfer programs in <source project> to replace those\n");
		printf("in <destination project>.\n");
		return 1;
	}
	src[0] = dst[0] = 0;
	replace = 0;
	for (i = 1; i < argc; i++) {
		if (argv[i][0] == '-' || argv[i][0] == '/') {
			if (argv[i][1] == 'r' || argv[i][1] == 'R')
				replace = 1;
		} else if (!src[0])
			strcpy(src, argv[i]);
		else if (!dst[0])
			strcpy(dst, argv[i]);
	}
	if (!strchr(src, '.'))
		strcat(src, ".prj");
	if (!strchr(dst, '.'))
		strcat(dst, ".prj");
	result = copy(src, dst, replace);
	if (!result) {
		if (replace)
			printf("Transfer items replaced successfully\n");
		else
			printf("Transfer items merged successfully\n");
	}
	return result;
}
