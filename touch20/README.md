# touch20: Borland C++ 2.0's TOUCH.COM, as source

TOUCH 3.0 sets the date and time of files to now: `TOUCH filename ...`, where a name may
hold the DOS wildcards. MAKE users ran it to force a rebuild. It shipped with Borland C++ 2.0
(1991) as a 5,124-byte `.COM` file. [src/TOUCH.C](src/TOUCH.C) rebuilds it byte for byte.

## Status

| | |
|---|---|
| The original | `BIN/TOUCH.COM` of Borland C++ 2.0, 5,124 bytes, SHA-256 `8a7077f35a0e11dbb7116107fd61372cc89d04b0610555fc8755850cee59d909` |
| Source | `src/TOUCH.C`: three functions, 86 lines |
| Build | **byte-identical** to the original |

## Building

Install Borland C++ 2.0 and Turbo C++ 1.01 with `scripts/setup-toolchains.py` (`--bc20` and
`--tc101`; [../docs/SETUP.md](../docs/SETUP.md)), then:

```sh
cd touch20
make check          # or: ../.venv/bin/python tools/build.py
```

It ends with `TOUCH.COM: byte-identical to the original (SHA-256 8a7077f3...)`. The new
file is `build/out/TOUCH.COM`, with TLINK's map beside it.

## How Borland built it

The evidence is the bytes of TOUCH.COM. [tools/build.py](tools/build.py) repeats each step.

- **Compiler: Turbo C++ 1.01**, not Borland C++ 2.0: tiny model, `TCC -c -mt -O -Z`. Turbo
  C++ 1.01 compiles the source to the original bytes, and Borland C++ 2.0 compiles it with 8
  bytes different. Turbo C++ 1.00 was not tried: it is not on WinWorld.
- **Startup code: an interim C0T.** Its code is Borland C++ 2.0's C0T, but its data has
  Turbo C++ 1.01's banner, "Turbo C++ - Copyright 1990". No released C0T.OBJ has that
  combination, and TLIB's C0C has it too. The build assembles Borland C++ 2.0's own `C0.ASM`
  with the banner line changed, with the switches of Borland's `BUILD-C0.BAT`
  ([../scripts/interim_rtl.py](../scripts/interim_rtl.py)).
- **Library: between the two releases.** Each library module's code was found in TOUCH.COM.
  Most are Turbo C++ 1.01's. `fputs` and `fseek` are Borland C++ 2.0's versions, which differ
  from 1.01's. `NEARHEAP` is the same code in both but byte-aligned only in 2.0's library, as
  in TOUCH.COM. The modules are linked as objects, in the original's order, which is the
  libraries' own order with the data-only modules in their places.
- **Linker: any.** TLINK 2.0, 3.01 and 4.0 all produce the same `.COM` file. The build
  uses Turbo C++ 1.01's TLINK 3.01.

The source calls `_open` and `_close` rather than `open` and `close`: the image holds
the `OPENA` and `CLOSEA` modules and no `CLOSE`. Only the three globals' names are
constrained by the bytes. Turbo C++ places uninitialised globals by a hash of their names,
and `date`, `filetime`, `now` give the original's order. The other names are descriptive.

## What the code shows

- The timestamp is built once, before any file is touched, so every file gets the same time.
- `wild` copies the pattern's drive and directory in front of each name it finds.
  `findfirst` is asked for attribute 0, so hidden and system files are never found. A
  read-only file is found but fails at `_open`, and is reported as "Unable to open file".
- A name matching nothing gives the same message as a file that cannot be opened.
- The path buffer is 82 bytes, two more than DOS's 80-character `MAXPATH`.
- TOUCH ignores `wild`'s result and always exits with status 0 once it has a file name.
