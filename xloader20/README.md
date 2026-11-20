# xloader20: the loaders of Borland C++ 2.0's TLINKX.EXE and BCCX.EXE, as source

Borland C++ 2.0 ships protected-mode versions of its linker and compiler for big jobs:
TLINKX and BCCX. Each one is two files. The `.EXE` is a real-mode DOS program, the loader,
and the `.OVY` is the protected-mode program it runs on TKERNEL.EXE (see
[../tkernel20/](../tkernel20/)). This project is the two loaders. Their sources in
[src/](src/) rebuild both byte for byte with Borland's tools.

## Status

| | |
|---|---|
| TLINKX.EXE | 31,568 bytes, SHA-256 `cbe244063f5ca3687b6e0235c7a79b8ed40a755ca995137b4af3dbc67a8c14f6`: **byte-identical** |
| BCCX.EXE | 32,850 bytes, SHA-256 `f23dd2a18f3273d0470536b2b0cc1d03b255575c621b350dee6742456cce36ac`: **byte-identical** |
| Source | the generated first draft, five TASM modules per program in [src/tlinkx/](src/tlinkx/) and [src/bccx/](src/bccx/). Labels are addresses, each line carries its image address (`;@nnnnn`), code the generator did not reach is still bytes, and there are no comments. M1 was C in the original and is still assembler here. |
| The `.OVY` files | not done yet (below) |

## Building

Install Borland C++ 2.0 with `scripts/setup-toolchains.py` ([../docs/SETUP.md](../docs/SETUP.md)),
then run `make check` (or `../.venv/bin/python tools/build.py`). The build uses
[../trancopy20/src/PUTC.C](../trancopy20/src/PUTC.C).

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

TLINKX.OVY (136,772 bytes) and BCCX.OVY (502,676 bytes) are protected-mode images in the
extender's "YO" format. Each is a 64h-byte header; then a table of 60 descriptors, one data
(F2h) and one code (FAh) descriptor for each of 30 segments; then the segments, one after
another. TLINKX.OVY's second segment is the TLINK core rebuilt for protected mode: close to
[../tlink20/](../tlink20/)'s source, but not the same bytes. Rebuilding them needs
protected-mode versions of those sources and a tool that writes the YO format.

[tools/gen/](tools/gen/) has the generator and the specs that produced the draft. The specs
were run from a scratch directory and name their paths there.
