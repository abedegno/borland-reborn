# bc20/tkernel: Borland C++ 2.0's TKERNEL.EXE, as source

TKERNEL.EXE is the protected-mode kernel that BCCX, TLINKX and TASMX run on: the A.I.
Architects protected-mode driver ("version 2.0.34") with its kernel bound to it. It shipped
as a 104,771-byte `.EXE`. The six assembler modules in [src/](src/) rebuild it byte for
byte with TASM 2.51 and TLINK 2.0.

## Status

| | |
|---|---|
| The original | `BIN/TKERNEL.EXE` of Borland C++ 2.0, 104,771 bytes, SHA-256 `ffe579ec98d0c25776a725c57aab6574ca88690c33c0251c66aad44b864d688b` |
| Build | **byte-identical** to the original |
| Source | the generated first draft: the driver [src/driver/M0..M4.ASM](src/driver/) and the kernel [src/kernel/KERNEL.ASM](src/kernel/KERNEL.ASM). Labels are addresses, each line carries its image address (`;@nnnnn`), code the generator did not reach is still bytes (the kernel's protected-mode code mostly), and there are no comments. |

## Building

Install Borland C++ 2.0 and Turbo C 2.01 with `scripts/setup-toolchains.py`
([../../docs/SETUP.md](../../docs/SETUP.md)), then run `make check` (or `../../.venv/bin/python
tools/build.py`).

## How it is put together

- **Two programs.** The file is two complete DOS executables one after the other: the driver
  (DB30h bytes with its header) and the kernel (BE13h bytes), both with TLINK 2.0's header
  (relocation table at 22h, `fb 20`).
- **The bind record.** The driver's header is 512 bytes larger than TLINK makes it. At its old
  end (600h) the binder wrote `AI`, two zero bytes, the kernel's offset in the file as a
  doubleword, and eight FFh bytes; the driver reads it to find its kernel ("hb: panic -
  kernel is not bound to driver" otherwise). The build does the same (tools/build.py,
  `bind`). TKINST.EXE's header has the same 512 extra bytes, all zero.
- **The driver: five modules.** TLINK writes relocations module by module in each object's
  fixup order; M0..M4 reproduce TLINK's order (M0 is only the first nine bytes, the jump
  through the far pointer to the start, so that its fixup comes first). Its code segments
  S000 and S9FA are byte-aligned, so the modules' pieces follow each other without gaps; a
  table of far pointers in S000 writes its segment words as `seg` of an earlier label, so
  that TASM does not treat them as forward references.
- **TASM traps met.** `.386p` for the whole file makes TASM reserve four bytes for every
  forward conditional jump, so the files are `.286p` and the few 386 instructions (with a
  66h prefix: `lidt fword ptr`) are bytes, as are the other instructions TASM encodes
  differently from the original.
- **The kernel: one module**, with all its segments declared at the top so that the segment
  words of its start-up table are not forward references; its last segment is empty, which
  gives the header's minimum allocation of one paragraph.

[tools/gen/](tools/gen/) has the generator and specs that produced the first draft.
