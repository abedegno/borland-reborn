# bc20/thelp: Borland C++ 2.0's THELP.COM, as source

Turbo Help 2.0, by David Stafford, is a TSR. It shows the Turbo C++ help file
(`TCHELP.TCH`) on top of any program. Press the hot key (keypad 5) and a window opens with
help for the word under the cursor. The window has links between topics, an index, a
history (Alt-F1), and a way to paste examples into the program underneath (Ctrl-P). It is
built on the TesSeRact TSR library. It shipped as a 10,448-byte `.COM` written in
assembler. The three files in [src/](src/) rebuild it byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/THELP.COM` of Borland C++ 2.0, 10,448 bytes, SHA-256 `f25591824c4416d10460c9ae49580dd3bc7ff93a51cd7fe45325ba6ccd484930` |
| Source | three TASM files: [TESS.ASM](src/TESS.ASM) (the TesSeRact kernel), [THELP.ASM](src/THELP.ASM) (THELP itself), [TSRINST.ASM](src/TSRINST.ASM) (TesSeRact's installer) |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 with `scripts/setup-toolchains.py --bc20`
([../../docs/SETUP.md](../../docs/SETUP.md)), then run `make check` (or `../../.venv/bin/python
tools/build.py`).

## How Borland built it

- **Three modules, linked by TLINK 4.0 as a `.COM` (`/t`).** The layout of THELP.COM shows
  three modules:
  - The TesSeRact kernel comes first. It holds the entry point, the interrupt handlers and
    the INT 2Fh interface, at 100h to FA8h.
  - THELP's own code comes next. It runs from FA9h to 27D1h, and only THELP refers to
    anything in that range.
  - TesSeRact's installer comes last, from 27D2h. The linker took it from the library
    after THELP.
- **THELP: TASM 2.51, one pass.** Eighteen forward jumps keep the `nop` that a single pass
  leaves. The keyboard handler compares with the end of the BIOS keyboard buffer. It names
  that address through a segment `at 40h`, because only an offset into such a segment
  gives the 16-bit immediate that THELP.COM has (`cmp di, offset kbend`).
- **TesSeRact: MASM.** In the library's two modules, ADD, SUB and CMP use the short
  sign-extended immediate (83h). OR and AND never do: they always use the full word
  (81h). That is MASM's habit. TASM uses the short form in every mode (MASM51, QUIRKS).
  So the 16 OR and AND instructions concerned are written as bytes, and each one shows the
  instruction in a comment. Everything else in those modules is ordinary TASM source.

## What the code shows

- THELP rewrites its own code:
  - Four `jmp near` instructions at the start of the resident part get new targets when
    the viewer switches between a topic and the index. The targets are what to draw, how
    to find a link, and what Tab and Shift-Tab do.
  - When snow checking is off (`/S-`), the calls that wait for the CGA retrace before each
    write to the screen are patched into plain `stosw`.
- `/W` writes the options (hot key, colours, help file name, switches) back into THELP.COM
  itself.
- The resident part keeps E558h bytes, well past the end of the file: the topic text, the
  screen under the window and the link table live there.
- The data of the transient part is reused as buffers once THELP is resident.
- In TesSeRact's table of hooked interrupts, the old-vector slot of the INT 24h record is
  the INT 2Fh entry's `jmp`.
- THELP.COM keeps no symbols. The names in THELP.ASM are descriptive. For TesSeRact the
  library's own names are not known: routines whose job is clear have names, and the rest
  are named by address.
