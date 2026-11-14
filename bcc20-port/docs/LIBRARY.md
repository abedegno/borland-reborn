# The library

`make lib` builds `build/libbcc20.a` and `build/bcc20run`; `make shlib` builds
`build/libbcc20.dylib` (`.so` on Linux) for other languages. The interface is
[`include/bcc20.h`](../include/bcc20.h).

## Compiling from memory

`bcc20_compile` runs one BCC command line in-process: the files the job gives (the source,
headers) come from memory, every file BCC writes (object file, listing, precompiled header)
comes back in the result, and so does the console text. Each call starts BCC afresh, its
whole memory image reloaded, so compiles never share state. Files the job does not hold are
read from its root directory (standing for `C:\`, the toolchain's headers for example); the
host is never written. One compile at a time per process. A job holds at most `BCC20_MAX_FILES` (4000)
files; `bcc20_compile` returns -1 without running for more.

```c
#include "bcc20.h"

bcc20_file source = {"T.C", text, length};
const char *args[] = {"-c", "-ml", "-O", "-IC:\\INCLUDE", "T.C"};
bcc20_job job = {0};
job.argc = 5;
job.argv = args;
job.files = &source;
job.n_files = 1;
job.root = "/path/to/BC20";       /* for <stdio.h> and the like */
job.time = 700000000;             /* pin the clock: object files carry file times */
job.stack_limit = 1;              /* stop where BCC.EXE's stack would */

bcc20_result result;
bcc20_compile(&job, &result);     /* result.outputs[0] is T.OBJ */
bcc20_free(&result);
```

A small function compiles in well under a millisecond. Exhume's `tools/build.py` uses the library for
projects on the Borland C++ 2.0 profile with `[toolchain] native = "bcc20"` (Exhume's
docs/config.md). `build/bcc20run` drives the library
from the command line (`--file NAME=PATH`, `--root DIR`, `--time T`, `--repeat N`,
`--explain PATH`); `tools/nativetest.py --lib` runs the whole corpus through it, each
compile twice in one process.

## Server mode, for many compiles at once

`build/bcc20run --serve` keeps a compiler running and takes jobs on stdin, answering each on
stdout, so a client starts one server per core it wants busy and sends jobs without starting
a process (the protocol is at the top of [`tools/bcc20run.c`](../tools/bcc20run.c): plain
length-prefixed records). Files every job needs, a project's headers say, are sent once
(`KEEP`) and held by the server. One compile at a time per server; a client caps the cores
it uses by how many servers it starts, and can lower their priority. A server that crashes
or hangs is killed and started again by the client, and only that job is lost.

Exhume's [`tools/bcc20.py`](../../exhume/tools/bcc20.py) has the client, `bcc20.Pool`:

```python
with bcc20.Pool(workers=4, root="/path/to/BC20", nice=10, timeout=60) as pool:
    pool.keep({"PROJ.H": header})                   # held by every server
    results = pool.map([(["-c", "-ml", "A.C"], {"A.C": a}), (["-c", "-ml", "B.C"], {"B.C": b})])
```

Its default is one server fewer than the cores (`BCC20_WORKERS` to change it). Exhume's
build (`[toolchain] native = "bcc20"`) and permuter use it. `tools/golden.py check` runs every
golden case through one server as well.

## Explain output

The compiler can explain its choices: the job's `explain` callback (or `BCC_EXPLAIN=1` for
`build/bcc`, on stderr) receives one line per event. It reads BCC's memory without writing
it, so explaining never changes what is compiled; the corpus runs with it on.

```
function name=sum
regvar_candidate var=i score=12 reg=si
regvar var=i reg=si score=12
regvar var=total reg=di score=11
reg op=17 preferred=bx,si,di allowed=ax,dx,bx,cx,si,di,bp,sp,es,ds,cs,ss free=dx,bx,cx narrowed_to=bx,si,di chose=bx
spill op=40 pushed_value=31
crossjump merged=3 ops left_block=12 right_block=20 tail_block=44
peephole removed_load op=52 value_in=ax
```

A register pick shows the registers the value's users preferred, those its class allows,
those free at that point, the set the allocator chose from and the register it took (the
lowest-numbered of that set): what ruled the others out. Register variables show every
candidate's score for each free register in turn.

## From Python, and the permuter

Exhume's [`tools/bcc20.py`](../../exhume/tools/bcc20.py) binds the shared library with
ctypes:

```python
import bcc20
bcc = bcc20.Compiler()                      # BCC20_LIB: path of the shared library
r = bcc.compile(["-c", "-ml", "-O", "T.C"], files={"T.C": source}, root="/path/to/BC20",
                explain=True)
r.status, r.console, r.outputs["T.OBJ"], r.explain
```

[`tools/permute.py`](../../exhume/tools/permute.py) is a permuter on top of it. It rewrites
one function's source in ways that keep its meaning (commutative operands, declaration and
declarator order, `register`, compound assignments, increments), compiles every variant
in-process and keeps those that come no further from the target bytes (from an object file
or cut from the program, fixups ignored), until they match:

```sh
python3 ../exhume/tools/permute.py FILE.C FUNCTION --target-obj TARGET.OBJ --opts "-ml -O -G" --out BEST.C
```
