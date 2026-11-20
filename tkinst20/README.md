# tkinst20: Borland C++ 2.0's TKINST.EXE, as source

TKINST 2.0 installs TKERNEL, the protected-mode kernel that Borland C++ 2.0's protected-mode
tools (BCCX, TLINKX, TASMX) run under. TKERNEL keeps a database of machines, keyed by
BIOS checksum. Each entry says how that machine enables and disables A20 and how it gets
back from protected mode. TKINST tests the machine, writes its entry into TKERNEL.EXE,
and appends a copy to a `.DB` file for Borland. TKINST.EXE is 33,962 bytes, written in C
and assembler. The files in [src/](src/) rebuild it byte for byte, with one documented
step after the link (below).

## Status

| | |
|---|---|
| The original | `BIN/TKINST.EXE` of Borland C++ 2.0, 33,962 bytes, SHA-256 `6f84a44c7334d01974a71cd06d75db50e8fe69a5fdf91802769eff50ca85afbd` |
| Source | [TKINST.C](src/TKINST.C) (the program), [ANALYZE.ASM](src/ANALYZE.ASM) (the machine analysis, TASM), and the library module [PUTC.C](src/PUTC.C) |
| Build | **byte-identical** to the original, after adding 512 bytes to the EXE header (see below) |

## Building

Install Borland C++ 2.0 with `scripts/setup-toolchains.py --bc20`
([../docs/SETUP.md](../docs/SETUP.md)). Then run `make check` (or `../.venv/bin/python
tools/build.py`). `make gate` also matches the C files against their parts of the
original with Exhume.

## How Borland built it

- **TKINST.C: Borland C++ 2.0's BCC, huge model, without `-O`.**
- **ANALYZE.ASM: TASM 2.51.** The module has:
  - a code segment;
  - four paragraph-aligned DATA segments in DGROUP (variables, descriptor tables, a
    buffer, and `$`-terminated messages);
  - a stack of its own, in a segment after `_STACK`.

  The C code reaches the module's variables through DGROUP, while the module reaches them
  through its own segment. Its data segments are declared before the code: TASM groups the
  fixups of forward-referenced segments, which would change the order of the relocation
  table. Only the two `mov eax, cr0` / `mov cr0, eax` instructions are assembled under
  `.386p`, because the whole file in that mode would size forward jumps differently.
- **The library: Borland C++ 2.0's C0H.OBJ and CH.LIB**, except PUTC. TKINST.EXE has the
  same PUTC as TRANCOPY.EXE, one instruction away from the released module.
  [src/PUTC.C](src/PUTC.C) is the same source, compiled for the huge model.
- **Linker: TLINK 4.0.**
- **The header.** TKINST.EXE's header is 512 bytes longer than its 400 relocations need.
  TLINK sizes the header for every segment fixup it meets, including fixups that resolve
  to absolute values and get no relocation entry (`seg` of an `AT` segment, for
  example). So the original analysis module had about a hundred such fixups where
  ANALYZE.ASM has plain numbers. TKERNEL.EXE, which carries the same machine analysis,
  has the same 512 extra bytes. Nothing left in the EXE says which constants they were,
  so [tools/build.py](tools/build.py) adds the 512 bytes after the link. Everything else,
  the load image and the relocation table in its order, comes straight from TLINK.

## What the code shows

- The analysis runs its risky tests (switching A20, entering protected mode and coming
  back through the CMOS shutdown codes 9 and 0Ah, or by the 386's own means) after
  writing a checkpoint file, `__CFGCK.DAT`. If a test hangs the machine, running TKINST
  again skips it.
- TKINST refuses to analyze with a VCPI memory manager present, and explains that TKERNEL
  cannot run from extended memory alongside an EMS driver without VCPI.
- `-d` is meant to strip quotes from the `.DB` name, but `p[-1] = *p++` copies each
  character onto itself (BCC increments `p` before the store), so an opening quote stays.
- `writedb()` tests `fopen`'s result with `< 0`, which compares only the offset, as
  unsigned, and so can never catch a failure.
- An undocumented option `-3` makes TKINST stop on a machine without protected mode.
- TKINST.EXE keeps no symbols. Names are descriptive; ANALYZE.ASM names its routines where
  their job is clear and gives the address otherwise.
