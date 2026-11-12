"""Generate the inputs the exact link needs that cannot be committed (they are derived from
Borland's CPP.EXE): src/data/*.ASM, CPP.EXE's data segment as assembly, written from your own
verified copy of CPP.EXE by tools/gendata.py.

    python3 scripts/prepare.py          (from cpp20/, after the toolchains are installed)

gendata.py reads symbols.tsv and the objects of the two sources that define data of their own
(TOKADV.C and PREPROC.C), so those are compiled first."""
import os, subprocess, sys, hashlib
R = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
EXHUME = next(p for p in (os.path.join(R, 'exhume'), os.path.join(R, '..', 'exhume')) if os.path.exists(os.path.join(p, 'tools', 'gate.py')))
exe = os.path.join(R, 'toolchain', 'BC20', 'BIN', 'CPP.EXE')
want = '39879c608c26eea11b984f85bd7c3259b656db908109adbc9ba76383c2960513'
got = hashlib.sha256(open(exe, 'rb').read()).hexdigest()
if got != want: sys.exit(f'{exe}: SHA-256 {got}, expected {want} (a different CPP.EXE)')
env = dict(os.environ, PYTHONDONTWRITEBYTECODE='1')
run = lambda *a: subprocess.run([sys.executable] + list(a), cwd=R, env=env, check=True)
run(os.path.join(EXHUME, 'tools', 'build.py'), 'src/lexer/TOKADV.C', 'src/preproc/PREPROC.C')
run(os.path.join(R, 'tools', 'gendata.py'))
print('prepared: src/data/*.ASM')
