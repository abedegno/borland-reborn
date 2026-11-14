# Source layout and translating a function

The port is translated from the byte-matched source in [`../bcc20`](../../bcc20/README.md),
which stays as it is and remains the reference. Each translated file starts with a comment
naming the original file and anything the translation keeps on purpose (an original
behaviour the output depends on, for example).

## Layout

| Path | What it holds |
|---|---|
| `src/` | the translations, one file per original file, in the original's subsystem directories |
| `include/port.h` | the machine model: the 8086 address space, far pointers, byte and word access |
| `include/data.h`, `globals.h` | BCC's global data at its DGROUP offsets (`globals.h` generated from DATA.H) |
| `include/pool.h` | record pool accessors (`TYPE_W(r, TYPE_KIND)`...), generated from POOL.H |
| `include/fields.h`, `msg.h`, `token.h`, `kind.h`, `exprop.h` | the original's constants |
| `include/protos.h` | every function of the original in the port's types, generated; `variadic.h` the few with variable arguments |
| `include/bcc20.h`, `explain.h`, `stack.h` | the library interface, explain output, stack checks |
| `native/` | the platform layer: start-up, DOS services, heap, stack model, library, explain output; `image.c` and `stack_table.c` are generated data |
| `generated/adapters.c` | generated adapters and stand-ins, and the tables of BCC's code addresses (committed: making it needs BCC.EXE) |
| `replay/` | the replay harness, and hand-written adapters for functions with unusual calling conventions |
| `tests/` | the port's own tests, for paths the corpus does not reach |
| `tools/record.py`, `inject.py`, `coverage.py` | recording calls, injecting calls, coverage of unchecked functions |
| `tools/nativetest.py` | the native build (or the library) against BCC.EXE over the corpus |
| `tools/golden.py`, `tests/golden/` | BCC.EXE's outputs for the cases that need no Borland header, and the check against them (CI) |
| `tools/genadapters.py`, `genheaders.py`, `genimage.py`, `genstack.py` | generators |
| `tools/ready.py` | the work queue: untranslated functions whose callees all have prototypes |

## Translating a function

1. Pick a function from `python3 tools/ready.py`.
2. Read the original in `../bcc20/src`, its comments, and its assembly where it has any.
3. Write the C in the matching file under `src/`, with fixed-size types (`u8`, `i16`,
   `u32`...), far pointers as `farptr` and memory through `B()`, `W()` and `D()`; globals by
   name, records through `pool.h` and the field constants. Far pointer arithmetic changes
   only the offset: use `fp_add`. Pseudo-registers become locals.
   - A call that may allocate is made before the pool is addressed, in a statement of its
     own: `TYPE_W(r, F) = NEW_X()` and `HLINK_W(CREATE(name), F)` leave C free to read the
     pool's segment first, and the call can move the pool (BCC.EXE always calls first).
     `tools/segorder.py` (run by `make check`) finds such places.
   - Calls through BCC's code pointers use `CALL_FAR` / `CALL_NEAR` (`calls.h`).
   - A local whose address is passed on lives in the scratch area (`scratch_alloc`); keep
     the original frame's layout among several such locals.
   - A function taking a structure by value is listed in genadapters' `STRUCT_ARGUMENTS`.
   - What the original reads from the 8086 flags is computed (`include/overflow.h`). Shift
     counts are taken modulo 32, as the 80186 does.
   - Unset values the original passes or returns are marked (`UNSET_ARGS`, `UNSET_BYTES`,
     `UNSET_RESULT`, `UNSET_RETURN`) and listed in [NATIVE.md](NATIVE.md#decisions).
   - Where several arguments of one call are themselves calls, evaluate them in Turbo C's
     order (left to right for pascal, right to left for cdecl): the replay checks the order.
4. The prototype is already in `include/protos.h`; keep the original's argument order and
   types. The adapter is generated (`generated/adapters.c`, remade by `make` when the toolchain is installed).
5. `python3 tools/record.py NAME`, `build/replay NAME records/NAME.rec`, and at the end
   `make check`.

Prove the check can fail: on the first function, a loop that missed its terminator hung
(caught by the time limit) and a sign error failed 383 of 500 calls.
