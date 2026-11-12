# Source tree

Borland C++ 2.0's command-line compiler BCC.EXE, recovered as the C and TASM sources that
rebuild it byte for byte. Each directory holds one part of the compiler; the headers shared
between them are in `include/`. File names are DOS 8.3 names and unique across the tree:
the build and the link know a source by its name alone, so a file can move between
directories without any other change. [../docs/SOURCE-MAP.md](../docs/SOURCE-MAP.md) lists
every file with its role, [../docs/SUBSYSTEMS.md](../docs/SUBSYSTEMS.md) describes how the
parts fit together, and [../map/directories.tsv](../map/directories.tsv) records which
directory each file was given.

| Directory | Files | What it holds |
|---|---|---|
| `driver/` | 12 | start-up, main, compile driver, options and initialisation |
| `lexer/` | 6 | lexer and input |
| `preproc/` | 7 | preprocessor and precompiled headers |
| `parser/` | 17 | statement and declaration parsers |
| `cpp/` | 20 | C++ classes, members, overloading, names |
| `types/` | 7 | types and symbols |
| `expr/` | 17 | expression trees, checks and folding |
| `diag/` | 8 | diagnostics and the message table |
| `codegen/` | 34 | code generator and optimiser passes |
| `inlasm/` | 5 | inline assembler and instruction encoders |
| `output/` | 11 | object, debug and assembly-text output |
| `heap/` | 77 | far-memory heap and pools |
| `overlay/` | 3 | overlay manager |
| `rtl/` | 57 | run-time library |
| `float/` | 17 | 80-bit real arithmetic |
| `include/` | | shared headers: data (DATA.H), prototypes, record fields (FIELDS.H, POOL.H), named constants (MSG.H, TOKEN.H, KIND.H, EXPROP.H) |

Every source starts with its build lines: `/* target: SEGMENT */` names the piece of
BCC.EXE it rebuilds, `/* opts: */` the compiler switches, and `/* compiler: TC201 */` marks
the run-time library modules that Turbo C 2.01 built. The header comment after them says
what the file does and lists its entry points.
