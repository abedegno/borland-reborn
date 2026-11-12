# Contributing

Thank you for reading the source. Contributions that make it easier to understand are very
welcome.

## What helps most

- **Better names.** A function, global or field whose name is vague or wrong. Say what the
  code shows, and update `map/names.tsv` with the basis (`descriptive` or `inferred`) and the
  evidence.
- **Comments and findings.** Explanations of tricky code, corrections to existing comments,
  and new entries in `docs/FINDINGS.md` (likely bugs, with how sure you are and why).
- **Setup fixes.** Anything that makes the rebuild work on another system.
- **New versions.** Other Borland or Turbo compilers as new top-level directories. Please
  open an issue first to agree the layout.

## The one rule: the build stays byte-identical

Every change must leave the rebuilt `BCC.EXE` identical to Borland's. Before opening a pull
request, run in `bcc20/`:

```sh
../.venv/bin/python ../exhume/tools/gate.py check --all
```

and include its last lines. Renames, comments and header changes usually cannot change the
code, but the gate is the proof. Things to know:

- Some code shapes look odd on purpose; their `match:` comments explain why. Changing them
  breaks the match.
- Each source's `/* target: */`, `/* opts: */` and `/* compiler: */` lines must stay within
  the first 4,000 bytes. A comment must never start with `context:`.
- Comments use `/* */` only (`//` is not C in these compilers) and plain ASCII. Keep each
  file's line endings: some sources use CRLF, which Turbo C 2.01 requires.
- Never commit Borland's programs, headers, disk images or files generated from them
  (`toolchains/`, `groupobj/`, `memory_blocks/*.bin`, `linktest/*.OBJ`). `.gitignore` covers
  them, and CI rejects executables and object files.

## Licensing of contributions

Contributions to the project's own scripts and documentation are made under the MIT licence.
Contributions to the recovered sources follow [NOTICE.md](NOTICE.md).
