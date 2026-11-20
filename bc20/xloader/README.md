# bc20/xloader: Borland C++ 2.0's TLINKX and BCCX (loaders and protected-mode images), as source

Borland C++ 2.0 ships protected-mode versions of its linker and compiler for big jobs:
TLINKX and BCCX. Each one is two files. The `.EXE` is a real-mode DOS program, the loader,
and the `.OVY` is the protected-mode program it runs on TKERNEL.EXE (see
[../tkernel/](../tkernel/)). This project is all four files. Their sources in
[src/](src/) rebuild them byte for byte: the loaders with Borland's tools alone, the `.OVY`
images with Borland's tools and our own YO writer.

## Status

| | |
|---|---|
| TLINKX.EXE | 31,568 bytes, SHA-256 `cbe244063f5ca3687b6e0235c7a79b8ed40a755ca995137b4af3dbc67a8c14f6`: **byte-identical** |
| BCCX.EXE | 32,850 bytes, SHA-256 `f23dd2a18f3273d0470536b2b0cc1d03b255575c621b350dee6742456cce36ac`: **byte-identical** |
| Source | the generated first draft, five TASM modules per program in [src/tlinkx/](src/tlinkx/) and [src/bccx/](src/bccx/). Labels are addresses, each line carries its image address (`;@nnnnn`), code the generator did not reach is still bytes, and there are no comments. M1 was C in the original and is still assembler here. |
| TLINKX.OVY | 136,772 bytes, SHA-256 `2a7922547c0abdcf82e627cd3728f09ccc3176390bb8014bfcf0b0f1d0563c6b`: **byte-identical**, with our YO writer |
| BCCX.OVY | 502,676 bytes, SHA-256 `b94b4fae451d17fe8c3895dc3d40277d40b71bb3dcc8815ffb4e43074d2c0429`: **byte-identical**, with our YO writer |
| The `.OVY` sources | a thinner draft than the loaders' (below): [src/ovy/](src/ovy/) |

## Building

Install Borland C++ 2.0 with `scripts/setup-toolchains.py` ([../../docs/SETUP.md](../../docs/SETUP.md)),
then run `make check` (or `../../.venv/bin/python tools/build.py`). The build uses
[../trancopy/src/PUTC.C](../trancopy/src/PUTC.C).

## How Borland built them

- **A large-model Borland C++ 2.0 program**: C0L.OBJ, Borland's CL.LIB, and the loader's
  own code, which is mostly assembler. Its own fputc is the same one TRANCOPY.EXE has.
  BCCX.EXE's loader is TLINKX.EXE's, with three more library routines (`atol`, `movmem`,
  `strstr`) and a longer `main`. The rest is the same code at other addresses.
- **What the loader does**, from its messages: it checks for enough extended memory, finds
  `TKERNEL.EXE` along the `PATH`, starts the kernel unless it is already running, creates a
  protected-mode task for the `.OVY` file, and serves the task's requests. "Internal error:
  unhandled server function" names any request it does not know.
- **Modules.** TLINK writes relocations module by module, and the original order shows five
  modules after C0:
  - M1 is `main` and the functions after it, compiled C (fixups in descending order per
    record);
  - M2 is one assembler segment;
  - M2B has three segments and the first entry of a two-entry table that both of the
    following modules extend;
  - M3 and M3B are the rest.
  M1 declares all the code segments, empty, in image order. That is a draft device: it
  fixes the segment order, which the original got some other way.
- **The fixups of M1** need [tools/revfix.py](tools/revfix.py), because M1 is still
  assembler: it re-cuts M1.OBJ's data records where BCC cut them and sorts each record's
  fixups in descending order, as BCC writes them. It goes away when M1 is written as C.
- **Data.** C0's `_DATA` is 91h bytes; the loader's own data follows it, byte-aligned, before
  the library's.

## The `.OVY` files

TLINKX.OVY and BCCX.OVY are protected-mode images in the extender's "YO" format:
- a 64h-byte header;
- a table of descriptors, a data (F2h) and a code (FAh) descriptor for each segment (60 in
  TLINKX.OVY, 378 in BCCX.OVY);
- the image, its segments one after another, starting with a 100h-byte block;
- the overlay block that TLINK writes for an overlaid DOS program: `FBOV`, the size of the
  overlay data, the offset of TLINK's segment table in the image, the number of segments,
  then the data. It is empty in TLINKX.OVY and 393 KB in BCCX.OVY.

So the images were linked by TLINK as overlaid DOS programs, and then a binding tool turned
each segment into a pair of descriptors and each relocation into a selector. That tool
didn't ship.

How they are built:
- **Assembled and linked:** TASM 2.51 assembles [src/ovy/](src/ovy/), and TLINK 4.0 links it
  into a DOS program holding the image and the overlay block.
- **Our YO writer:** [tools/mz2yo.py](tools/mz2yo.py) adds the header and the descriptor table.
  The descriptors and the header's start-up values are written out in
  [tools/tlinkx_ovy.py](tools/tlinkx_ovy.py) and [tools/bccx_ovy.py](tools/bccx_ovy.py).
  This is a native difference: the tool is ours, not Borland's.

The sources are a first draft, thinner than the loaders':
- The selectors are plain numbers, because the binding tool left no relocation table to show
  where they are.
- **TLINKX.OVY:** decoded from the entry point and from 214 routine starts found by matching
  [../tlink/](../tlink/)'s core (tools/gen/ovy_entries.json); 150 of them carry their
  bc20/tlink names. Its main segment is the TLINK core rebuilt for protected mode, close to
  [../tlink/](../tlink/)'s source but not the same bytes.
- **BCCX.OVY:** in 17 modules, because one file is too big for TASM. Its code is the C
  compiler. 1,150 of [../bcc/](../bcc/)'s functions match it exactly once, and the
  draft is decoded from them and named after them (tools/gen/bccx_entries.json). The
  overlay block, and code the generator did not reach, are still bytes: about 32,000 of
  its 51,000 lines.
- Next: decode both against the real-mode sources they were built from.

[tools/gen/](tools/gen/) has the generators (exegen_ovy.py, for the OVY drafts, cuts byte runs at segment ends) and the specs that produced the drafts. The specs
were run from a scratch directory and name their paths there.
