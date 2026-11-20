# tlink20: Borland C++ 2.0's TLINK.EXE, as source

TLINK 4.0 ("Turbo Link") is the linker of Borland C++ 2.0. It shipped as a 72,585-byte
`.EXE`: a core written in 286 assembler, a C++ name demangler in C, a few run-time library
routines, and the far-memory heap Borland used in its 1991 tools (the same library as in
BCC.EXE and CPP.EXE, in a cut-down version). The files in [src/](src/) rebuild it byte for
byte with Borland's own tools and a plain TLINK link.

## Status

| | |
|---|---|
| The original | `BIN/TLINK.EXE` of Borland C++ 2.0, 72,585 bytes, SHA-256 `81701462d0c3f59d774dd7b0f193eb9945ef9568dfec14b5abacf5a4d02c837c` |
| Build | **byte-identical** to the original |
| The core | [core/TLINK.ASM](src/core/TLINK.ASM) (0000h..BF90h of the image) and its data [core/TLDATA.ASM](src/core/TLDATA.ASM) assemble to the original bytes, but they are still the generated first draft: labels are addresses (`L098D0`), every line carries its address (`;@098D0`), and there are no comments yet. Naming and commenting the core is the work still to do. |
| The rest | written as source: the demangler, the heap, the library routines and the data, with comments |

## Building

Install Borland C++ 2.0 and Turbo C 2.01 with `scripts/setup-toolchains.py`
([../docs/SETUP.md](../docs/SETUP.md)). Then run `make check` (or `../.venv/bin/python
tools/build.py`). `make gate` also matches each file against its part of the original with
Exhume, and checks the core line by line ([tools/asmcheck.py](tools/asmcheck.py)).

The build ([tools/build.py](tools/build.py)) compiles and assembles every module, takes two
modules from Borland C++ 2.0's libraries as they are (`F_LXMUL` from `CL.LIB`, `OVRHP` from
`OVERLAY.LIB`), reorders the fixups of one object (below), and links everything with TLINK
4.0 in the order of its `LINK_ORDER` list.

## The parts

In the order they are linked, which is their order in the image:

| Source | Image | What it is |
|---|---|---|
| [ORDER.ASM](src/ORDER.ASM) | | declares the segments, empty, in TLINK.EXE's order |
| [core/TLINK.ASM](src/core/TLINK.ASM) | 0000..BF90 | the linker: options, object and library reading, segment layout, fixups, the map, the EXE |
| [core/TLDATA.ASM](src/core/TLDATA.ASM) | 10190.., 117E0.. | its messages and tables, the stack, and 31K of uninitialised data |
| [asm/SETJMP.ASM](src/asm/SETJMP.ASM) | BF90 | far pascal `SETJMP` and `LONGJMP` |
| [UNMANGLE.C](src/UNMANGLE.C) | BFFE | the C++ name demangler: `@Cls@member$qi` becomes `Cls::member(int)` |
| [data/CTYPE.ASM](src/data/CTYPE.ASM) | | the character table `_ctype` |
| `F_LXMUL` (CL.LIB), `OVRHP` (OVERLAY.LIB) | CDF8, CE0F | the long multiply; `__FAR_RETURN` |
| [asm/STUB40.ASM](src/asm/STUB40.ASM) | CE10 | three bytes nothing calls (`int 40h`, `retf`) |
| [rtl/](src/rtl/) | CE13.. | far pascal string routines shared with BCC.EXE (compare, length, set, copy, move, append) |
| [CHARCASE.C](src/CHARCASE.C) | CE4F | letter case through `_ctype` |
| [heap/](src/heap/) | D029..10185 | the far-memory heap: banks in conventional memory, EMS and extended memory |
| [data/HEAPDATA.ASM](src/data/HEAPDATA.ASM), [data/HEAPHEAD.ASM](src/data/HEAPHEAD.ASM) | | the heap's DGROUP variables |
| [data/OVRDATA.ASM](src/data/OVRDATA.ASM) | 112F0, 11380 | the EMS and extended-memory state of the overlay library |

## How Borland built it

- **The core: TASM**, 286 instructions, near calls, `enter`/`leave`. Two places need care
  with TASM 2.51's single pass: a near jump the original kept near (written as an opcode byte
  and a displacement), and a short jump followed by two NOPs.
- **The demangler: Borland C++ 2.0**, compact model (near code, far data), pascal calls, no
  `-O`. The stack is its own segment, so the argument arena's pointers are `_ss` pointers.
  It has a code segment of its own (`-zC`): in TLINK.EXE the library's `_TEXT` starts at
  LXMUL, not at the demangler. Its three statics are named so that BC 2.0's `_BSS` order,
  which follows a hash of the name, is TLINK.EXE's.
- **The run-time routines and CHARCASE: Turbo C 2.01** (CRLF line ends; Turbo C makes empty
  objects of LF files). CHARCASE needs `-O`.
- **The heap**: Borland C++ 2.0, medium model, pascal, all files in one code segment
  (`-zCCODE2`). The files come from the bcc20 reconstruction with TLINK's differences: five
  banks instead of six (no swap file), 20-byte descriptors from offset 140h instead of 22
  bytes from 1E0h, banks 40h bytes (4 paragraphs) apart instead of 50h, the discard bank
  is 4 not 5, no handle ring or tagging, no overlay calls, no out-of-memory retries, a
  shorter control block (no `field52`, `field54`, `tagged_size`), and an out-of-memory hook
  that takes no arguments. Some files hold several functions, as the relocation order
  shows: HPSHRINK.C (three functions), HPTAGS.C and HPHSIZE.C (as cpp20 found for CPP.EXE).
  Files whose fixups come in ascending order went through TASM (`-B -TjNOSMART`); smart
  mode off keeps `lea` and far calls as written. DOSMEM.C (DOS memory blocks) is TLINK's
  own.
- **One step that is not a plain compile or link**: [tools/fixorder.py](tools/fixorder.py)
  moves one fixup of HPSHRINK.OBJ to the front, where TLINK.EXE's relocation table has it
  (the same in BCC.EXE and CPP.EXE). No source gives that order;
  [tools/fixorder.tsv](tools/fixorder.tsv) gives the evidence.
- **The linker: TLINK 4.0**, no options that change the EXE. Segments come out by class in
  the order TLINK first meets each class (ORDER.ASM).

## What the code shows

- TLINK demangles C++ names for its messages and map file itself. A malformed name ends
  the text with "..." through a `LONGJMP`.
- `_ctype` is not the BC 2.0 library's: only TAB and LF count as spaces, not VT, FF or CR.
- The heap keeps a `YOM` signature in its data, the name of Borland's overlay and memory
  library (OVERLAY.LIB's OVRHP comes from `YOMHP.ASM`).
- TLINK.EXE keeps no symbols. Names come from bcc20 and cpp20 where the code is shared, and
  are descriptive elsewhere.

## Tools

- [tools/build.py](tools/build.py): the build and the comparison.
- [tools/gate.sh](tools/gate.sh): matches every file, checks the core, runs the build.
- [tools/segdiff.py](tools/segdiff.py): one file's code against its target, with a diff.
- [tools/asmcheck.py](tools/asmcheck.py): an assembly module against the image, line by line.
- [tools/disasm.py](tools/disasm.py): a range of the image, with relocations marked.
- [tools/relorder.py](tools/relorder.py): the relocation order the compiled objects give,
  against TLINK.EXE's.
- [tools/symcheck.py](tools/symcheck.py): names the objects need that none defines.
- [tools/mktarget.py](tools/mktarget.py): a target table for a heap file from bcc20's.
