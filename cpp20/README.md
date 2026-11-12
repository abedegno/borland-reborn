# cpp20: Borland C++ 2.0's preprocessor, CPP.EXE, as source

CPP.EXE is the standalone preprocessor of Borland C++ 2.0 (1991): `CPP [options] file[s]`
writes the preprocessed text of each C or C++ source to a `.i` file. Each line is prefixed
with its file name and line number unless `-P-` is given. This directory holds C and TASM
sources that rebuild it with the original tools: Borland C++ 2.0's compiler, Turbo C 2.01,
TASM 2.51 and TLINK 4.0.

CPP.EXE was built from the same source files as the compiler BCC.EXE, which is reconstructed
in [../bcc20](../bcc20). The preprocessor build left out the code generator, the C++ front
end, precompiled headers, the overlay manager and the TASM/TLINK steps, and kept the lexer,
the directive processor, the macro table and the full C expression machinery that `#if`
uses (a parser, constant folding, type sizes for `sizeof`). [FINDINGS.md](docs/FINDINGS.md) has
the details.

## Status

| | |
|---|---|
| The original | `CPP.EXE`, 117,332 bytes, SHA-256 `39879c608c26eea11b984f85bd7c3259b656db908109adbc9ba76383c2960513` |
| Sources | 154 (C compiled by Borland C++ 2.0 or Turbo C 2.01, and TASM), plus the data modules that `scripts/prepare.py` generates |
| Match | every source compiles to its original bytes (`match.py`: WHOLE SEGMENT MATCHES) |
| Verify | every relocation target, public, data and BSS placement checked (`verify.py`), and `symbols.tsv` (702 names) rebuilt from scratch |
| Link | **byte-identical** to the original (`cmp` and SHA-256 equal). One documented link step besides TLINK, `tools/fixorder.py`, puts the fixups of one object in CPP.EXE's order ([FINDINGS.md](docs/FINDINGS.md), "The 2 bytes") |
| Runs | `tools/runcheck.sh` preprocesses six test files with both executables in emu2: the outputs are identical |

## Layout

- `src/`: one source per original module, in subsystem directories (`driver`, `lexer`,
  `preproc`, `expr`, `parser`, `types`, `cpp`, `diag`, `heap`, `overlay`, `rtl`, `float`).
  Shared headers are in `src/include`. Generated data modules go in `src/data` (not
  committed). [SOURCE-MAP.md](docs/SOURCE-MAP.md) lists every file.
- `targets/`: one table per source. Each gives where its code lies in CPP.EXE (file base,
  size, org) and its functions.
- `symbols.tsv`: every name at its CPP.EXE address (`DS:offset` or `segment:offset`).
- `map/`: `modules.tsv` (the module list in image order), `names.tsv` (renames with their
  basis and evidence) and the first-pass map files.
- `tools/`: `link.py` (the exact link), `fixorder.py` and `fixorder.tsv` (the one link step
  besides TLINK: the fixup order of HPSHRINK's object), `gendata.py` (the data modules), `runcheck.sh` (the
  run check), and the analysis tools used to map and match (`procs.py`, `similar.py`,
  `segdiff.py`, `dis.py` and others).
- `tests/run/`: inputs for the run check.

## Building, inside the borland-reborn repository

cpp20 sits next to bcc20. It shares the repository's toolchains and the `exhume`
submodule. Follow [../docs/SETUP.md](../docs/SETUP.md) steps 1 to 4 first: tools, clone,
WinWorld downloads, `scripts/setup-toolchains.py`. cpp20 needs the same two products,
Borland C++ 2.0 (its `BIN/CPP.EXE` is the original) and Turbo C 2.01.

```sh
cd cpp20                                           # setup-toolchains.py has linked toolchain -> ../toolchains
../.venv/bin/python scripts/prepare.py             # checks CPP.EXE's SHA-256, writes src/data/
../.venv/bin/python ../exhume/tools/gate.py check --all
sh ../exhume/tools/setup-emu2.sh                   # once, for the run check
sh tools/runcheck.sh                               # preprocess tests/run with both executables
```

`scripts/setup-toolchains.py` links every version directory that has an `exhume.toml`
(`cpp20/toolchain -> ../toolchains`). `make check` does the same as the gate line.

The gate compiles all sources in DOS (DOSBox-X), matches and verifies each, rebuilds
`symbols.tsv` from scratch, links with TLINK and compares with the original. It ends with:

```
pass  match + verify             154/154 sources
pass  symbols.tsv from scratch   702 names
pass  exact link                 byte-identical to the original
CHECK PASSED
```

The rebuilt executable is `build/LINK/out/CPP.EXE`; `cmp` finds no difference from the
original.

The link (`tools/link.py`) assembles the data modules, then runs TLINK 4.0 on every object
in CPP.EXE's order. Before TLINK it runs one more step: `tools/fixorder.py` copies HPSHRINK's
object with the subrecords of its FIXUPP record in the order `tools/fixorder.tsv` gives, so
that TLINK writes 4 relocation entries in CPP.EXE's order. It changes no byte, target or data
record, and it refuses if the object's fixups are not exactly the ones in the table. No
source we could write gives that order through Turbo C 2.01 and TASM; FINDINGS.md has the
evidence.

**Exhume version.** cpp20 needs seven small changes to Exhume's `tools/verify.py`, all for
non-overlaid executables (no FBOV overlay block, data that points into its own module). They
are in the Exhume version the repository pins as its `exhume` submodule.

### Working on one file

```sh
../.venv/bin/python ../exhume/tools/match.py src/preproc/PREPROC.C   # compile and compare one source
../.venv/bin/python ../exhume/tools/verify.py src/preproc/PREPROC.C  # check its relocations and names
../.venv/bin/python tools/segdiff.py src/preproc/PREPROC.C           # whole-segment instruction diff
../.venv/bin/python ../exhume/tools/gate.py check --fast             # every changed source, no link
```

Each source starts with its build lines:
- `/* target: */` names its table;
- `/* opts: */` gives the switches;
- `/* compiler: TC201 */` marks Turbo C 2.01 files;
- `/* link: */` notes explain what the link needs from the file (a shared segment name, a
  code class, a public).

Comments tagged `CPP.EXE edit:` mark where CPP's source differs from BCC's. `match:` marks a
code shape kept for the byte match.
