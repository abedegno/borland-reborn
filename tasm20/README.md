# tasm20: Borland C++ 2.0's TASM.EXE, as source

Turbo Assembler 2.51 is the assembler of Borland C++ 2.0. It shipped as a 106,521-byte
`.EXE` written in assembler. The seven modules in [src/](src/) rebuild it byte for byte with
TASM 2.51 itself and TLINK 2.0.

## Status

| | |
|---|---|
| The original | `BIN/TASM.EXE` of Borland C++ 2.0, 106,521 bytes, SHA-256 `712e4127e470e056c8b7ddda802039f1fe64b509941ba8d820ff8bc7a955c57a` |
| Build | **byte-identical** to the original |
| Source | the generated draft: [M1.ASM](src/M1.ASM) .. [M7.ASM](src/M7.ASM). The code is decoded as instructions (entry points found through TASM's handler tables in DGROUP and the code's own constants; about 4 KB of bytes are left, some of them data). Labels are still addresses (`L0FB18`), each line carries its image address (`;@0FB18`), and there are no comments yet: naming and commenting is the work still to do. |

## Building

Install Borland C++ 2.0 and Turbo C 2.01 with `scripts/setup-toolchains.py`
([../docs/SETUP.md](../docs/SETUP.md)), then run `make check` (or `../.venv/bin/python
tools/build.py`).

## How Borland built it

- **Assembler.** TASM.EXE is hand-written assembler: 286 instructions, `enter`, and far
  calls between its four code segments (frames 0000h, 0F9Bh, 1455h and 1459h). DS and SS
  are DGROUP (frame 15F6h); the start-up code moves the stack into DGROUP.
- **The linker: TLINK 2.0** (Turbo C 2.01's), not TLINK 4.0: the header has TLINK 2.0's
  layout (relocation table at 22h, `fb 20` in the reserved bytes).
- **Modules.** TLINK writes the relocation table module by module, each module's fixups in
  the order TASM writes them. TASM.EXE's table shows the source was split into modules
  that each put code into several segments (the first one, for example, into CODE0, the
  second code segment and the fourth). M1..M7 reproduce that split; their names and exact
  boundaries are not known, only the relocation order they must give. Inside a module TASM
  writes each segment's data in the order the segments were declared, and moves fixups of
  forward references; in M3 the second segment's piece therefore comes before the first's
  in the source, so that its labels are defined before CODE0's code refers to them.
- **`nosmart`.** TASM turns a far call to a label of the same segment into `push cs` and a
  near call. In the original those calls crossed module boundaries; here the few that stay
  inside one module are wrapped in `nosmart` / `smart`.

[tools/gen/](tools/gen/) has the generator and the specs that produced the first draft.
