# bcc20-port: Borland C++ 2.0 as a native compiler

A port of `BCC.EXE`, Borland C++ 2.0's command-line compiler, to modern hosts. It writes
**exactly** the object files and assembly listings BCC.EXE writes, natively and fast,
for decompiling and preserving early-1990s DOS games built with Borland C++: matching a
game's code byte for byte means compiling candidate C thousands of times with the compiler
that built it.

It is translated, function by function, from the byte-matched source in
[`../bcc20`](../bcc20/README.md), and checked against Borland's own BCC.EXE.

## Status

| | |
|---|---|
| Translation | all of BCC.EXE's C and assembly, 1629 functions |
| Checked call by call | every function, against calls recorded from BCC.EXE ([how](docs/CHECKING.md)) |
| Output | 1874 of 1880 corpus compile steps identical to BCC.EXE; the other 6 are [failing compiles only](docs/NATIVE.md#known-differences) |
| A real game | Ultima 7's own makefiles: all 922 C compiles identical to BCC.EXE ([how](docs/CHECKING.md#a-games-own-build)) |
| Native build | `bcc`: runs without BCC.EXE or a DOS emulator, models BCC.EXE's stack limit ([details](docs/NATIVE.md)) |
| Library | `libbcc20`: one compile in-process, memory to memory, well under a millisecond for a small function ([API](docs/LIBRARY.md)); `bcc20run --serve` keeps compilers running for a pool of them, one per core ([server mode](docs/LIBRARY.md#server-mode-for-many-compiles-at-once)) |
| Explain output | why each register was chosen, what was merged or removed ([format](docs/LIBRARY.md#explain-output)) |
| Permuter | Exhume's [`tools/permute.py`](../exhume/tools/permute.py), on the library |

## Quick start

Prebuilt binaries for Linux, macOS and Windows are on the
[releases page](https://github.com/abedegno/borland-reborn/releases). To build from source
you need a C compiler and `make`:

```sh
make native                                     # build/bcc
build/bcc -c -ml -O -IC:\\INCLUDE HELLO.C       # writes hello.obj, as BCC.EXE would
make lib shlib                                  # build/libbcc20.a, the shared library, build/bcc20run
python3 tools/golden.py check                   # both against BCC.EXE's stored outputs
```

`bcc` treats the current directory as drive C:'s root, so give it Borland's headers
(`INCLUDE\`) there or with `-I`. The headers come with Borland C++ 2.0, which is not part of
this repository (see [../docs/SETUP.md](../docs/SETUP.md)).

Checking the port against BCC.EXE needs the Borland toolchain and Exhume's tracing emu2:

```sh
make check                                      # every function against its recorded calls
python3 tools/nativetest.py                     # the native build against BCC.EXE over the corpus
```

## Documentation

- [docs/CHECKING.md](docs/CHECKING.md): recording and replaying calls, injecting calls BCC
  never makes, the corpus, looking into a failure.
- [docs/NATIVE.md](docs/NATIVE.md): the native build, its switches, the stack model,
  decisions and known differences.
- [docs/LIBRARY.md](docs/LIBRARY.md): the C API, explain output, Python and the permuter.
- [docs/TRANSLATING.md](docs/TRANSLATING.md): the source layout and how a function is
  translated.

## Roadmap

1. Checking machinery: call recorder, replay harness, generated adapters. **Done.**
2. Translation of everything `-c` reaches, then the whole program. **Done.**
3. Native platform layer: heap, files, start-up. **Done.**
4. Native compiles identical to BCC.EXE over the corpus. **Done.**
5. The TASM parts (80-bit reals, the inline assembler) in C. **Done.**
6. Library interface, explain output, permuter. **Done.**
7. Host data structures in place of the 8086 memory model. **Deferred:** it would give up
   the call-by-call check, which depends on the memory layout.

Each game must be matched with the exact compiler that built it. This port is Borland C++
2.0; Turbo C++ 1.0 and Borland C++ 3.x very likely share much of its code generator, and all
of the tooling here carries over.

## Licence

The translations (`src/`, and the generated data in `native/image.c`) derive from Borland's
copyrighted BCC.EXE (now Embarcadero), like `../bcc20`, and are provided for study and
preservation with no rights claimed. The machine model, the platform layer, the harness and
the tools are project material under the MIT licence. See [../NOTICE.md](../NOTICE.md).
