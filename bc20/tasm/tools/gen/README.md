# tools/gen: how src/ was generated

`exegen.py` writes TASM source for the modules of an EXE from a spec; `spec.py` and
`spec2.py` are TASM.EXE's (segments, entry points, the seven modules, the interleaving of
segment pieces that gives TASM.EXE's relocation order). `post.py` wraps far calls to labels
of the same segment in `nosmart`/`smart` so that TASM keeps them far. Run from this
directory:

    MARK=1 python3 exegen.py spec2.py OUTDIR FALLBACKS.txt && python3 post.py OUTDIR/M1.ASM ...

The files in src/ are this output; they are kept as source from now on (names and comments
are added there, not here).
