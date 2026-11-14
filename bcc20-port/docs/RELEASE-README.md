# Borland C++ 2.0 native compiler

`bcc` is Borland C++ 2.0's command-line compiler, `BCC.EXE`, as a native program. It writes
exactly the object files and assembly listings BCC.EXE writes. `libbcc20` is the same compiler
as a library, one compile in-process from memory to memory. Built from
https://github.com/abedegno/borland-reborn (`bcc20-port/`), where the documentation lives.

## Using `bcc`

`bcc` takes BCC.EXE's options and treats the current directory as drive C:'s root. Borland's
headers are not included; put Borland C++ 2.0's `INCLUDE` directory where `-I` can find it:

```sh
bcc -c -ml -O -IC:\INCLUDE GAME.C        # writes game.obj
bcc -S -ml -O -IC:\INCLUDE GAME.C        # writes game.asm
```

Switches, by environment variable:
- `BCC_EXPLAIN=1` explains the compiler's choices (registers, merged tails, removed loads) on
  stderr.
- `BCC_STACK_LIMIT=0` drops the model of BCC.EXE's stack limit.
- `BCC_DOS_RUNNER=emu2` runs TLINK and TASM in that DOS emulator, for links and `-B`.

## Using the library

`include/bcc20.h` is the interface. Link `lib/libbcc20.a`, or load the shared library
(`libbcc20.so`, `.dylib`, `.dll`), for example from Python with Exhume's `tools/bcc20.py`.

## Notice

The compiler contains data from Borland's copyrighted BCC.EXE (now Embarcadero). No rights
in it are claimed. The project's own code is under the MIT licence. See `NOTICE.md` and
`LICENSE`.
