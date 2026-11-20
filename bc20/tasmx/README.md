# bc20/tasmx: Borland C++ 2.0's TASMX.EXE, as source

TASMX.EXE is the protected-mode Turbo Assembler 2.51 of Borland C++ 2.0. It is a New
Executable (NE) program that DPMILOAD.EXE (see [../dpmiload/](../dpmiload/)) runs under a
DPMI host. Its DOS stub starts DPMILOAD.EXE, or plain TASM.EXE when no DPMI host is there.
It shipped as a 109,234-byte `.EXE`. The two assembler files in [src/](src/) rebuild it byte
for byte.

## Status

| | |
|---|---|
| The original | `BIN/TASMX.EXE` of Borland C++ 2.0, 109,234 bytes, SHA-256 `d1cf3399545b567c58e30b18fa5cfa53c513f8c0bc7159e3def7e819b8e8d2cc` |
| Build | **byte-identical** to the original |
| Source | the generated first draft: [STUB.ASM](src/STUB.ASM) (the DOS stub, decoded) and [TASMX.ASM](src/TASMX.ASM) (the protected-mode assembler). TASMX.ASM is decoded as far as the generator traced it from the entry point, the far calls, and 295 routine starts found by matching [../tasm/](../tasm/)'s routines (tools/gen/xentries.json); about one line in six is still bytes. It has no names and no comments. |

## Building

Install Borland C++ 2.0 with `scripts/setup-toolchains.py` ([../../docs/SETUP.md](../../docs/SETUP.md)),
then run `make check` (or `../../.venv/bin/python tools/build.py`).

## How it is put together

- **The stub**: one code segment that holds its own messages (413h bytes), then a
  byte-aligned stack of C8h bytes. It is assembled with TASM 2.51 and linked with TLINK 4.0
  as a DOS program. The entry point starts with `int 3`, as DPMILOAD.EXE's does.
- **The program**: five segments. Four are code: the protected-mode builds of TASM.EXE's four
  code segments ([../tasm/](../tasm/)), close to them but not the same bytes. The fifth is
  DGROUP. They are assembled as one module and linked with TLINK 4.0 into a DOS program, one
  segment after another.
- **The NE file: our own writer.** TLINK 4.0 writes NE files (`/Twe`), but not this one.
  TASMX.EXE has the NE header at a 512-byte boundary, the stub's size field ending where the
  NE header's tables end, NE flags 02h, and a checksum. That is Microsoft LINK 5.10's layout
  (the header's linker version is 5.10). [tools/mz2ne.py](tools/mz2ne.py) writes it from the
  DOS program and the stub, as follows:
  - each place the DOS program's relocation table names becomes a selector fixup;
  - there is one relocation record for each pair of segments, its places chained from the
    highest offset down;
  - the checksum is the 32-bit sum of the file's doublewords.
  This is a native difference: Borland built the file with another linker, which we don't
  have.
- [tools/gen/](tools/gen/) has the generator, the specs, and `ne2mz.py`, which made the DOS
  image of TASMX.EXE's segments that the draft was generated and checked against. The specs
  were run from a scratch directory and name their paths there.
