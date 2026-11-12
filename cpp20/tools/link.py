"""Link CPP.EXE exactly from the matched objects and the data sources, then compare.

    python3 tools/link.py [--map]

1. Assembles src/data/*.ASM (tools/gendata.py writes them) with TASM /ml into
   <build>/DATA/STEM.OBJ (DOS run).
2. The link order: src/data/ORDER.ASM first (CPP.EXE's segment order), then every module
   of map/modules.tsv in image order (each one's object from <build>/STEM/STEM.OBJ, built
   by tools/build.py), each data piece of src/data/PIECES.TSV right after the module that
   owns its relocations, and DBSS last.
   One object, HPSHRINK, is linked from a copy whose fixup subrecords tools/fixorder.py
   has put in CPP.EXE's order (tools/fixorder.tsv gives the order and why); nothing else
   in it changes.
3. TLINK 4.0 (BC 2.0) in DOS: `TLINK /c /n [/m /s] @LINK.RSP`: case-sensitive (the
   sources mix pascal upper case and cdecl names), no default libraries (CPP.EXE is
   self-contained: its run-time modules are sources here).
4. exediff against the original. Exit status: exediff's (0 = byte-identical).
The EXE is <build>/LINK/out/CPP.EXE, the map (with --map) <build>/LINK/out/CPP.MAP."""
import os, sys, subprocess, shutil, glob
here = os.path.dirname(os.path.abspath(__file__)); R = os.path.abspath(os.path.join(here, '..'))
EXHUME = next((p for p in (os.path.join(R, 'exhume'), os.path.join(R, '..', 'exhume')) if os.path.exists(os.path.join(p, 'tools', 'gate.py'))), os.path.join(R, 'exhume'))   # ./exhume here, ../exhume in the borland-reborn repo
sys.path.insert(0, os.path.join(EXHUME, 'tools')); sys.path.insert(0, here)
import config
cfg = config.load(os.path.join(R, 'exhume.toml'))
B = cfg.build
want_map = '--map' in sys.argv
DOSRUN = os.path.join(EXHUME, 'tools', 'dosrun.mjs')
BIN = os.path.join(R, 'toolchain', 'BC20', 'BIN')

def dos(outdir, files, lines, outs, optional=()):
    os.makedirs(outdir, exist_ok=True)
    cmd = ['node', DOSRUN, outdir, '-t', '600']
    for f in files: cmd += ['-f', f]
    for l in lines: cmd += ['-c', l]
    for o in outs: cmd += ['-o', o]
    for o in optional: cmd += ['-O', o]
    r = subprocess.run(cmd, capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr

# 1. data modules
data_dir = os.path.join(B, 'DATA'); shutil.rmtree(data_dir, ignore_errors=True)
asms = sorted(glob.glob(os.path.join(R, 'src', 'data', '*.ASM')))
stage = os.path.join(B, 'DATA.stage'); shutil.rmtree(stage, ignore_errors=True)
rc, out = dos(data_dir, [os.path.join(BIN, 'TASM.EXE')] + [f'{a}={os.path.basename(a)}' for a in asms],
              [f'TASM /ml {os.path.basename(a)} >> TASM.LOG' for a in asms],
              [os.path.splitext(os.path.basename(a))[0] + '.OBJ' for a in asms], ['TASM.LOG'])
log = open(os.path.join(data_dir, 'TASM.LOG'), encoding='latin1').read() if os.path.exists(os.path.join(data_dir, 'TASM.LOG')) else out
if rc or any(l.startswith(('**Error**', '**Fatal**')) for l in log.splitlines()):
    print(log); sys.exit('data modules did not assemble')

# 2. link order
pieces = [l.rstrip('\n').split('\t') for l in open(os.path.join(R, 'src', 'data', 'PIECES.TSV')) if not l.startswith('#')]
after = {}
for n, a in pieces: after.setdefault(a, []).append(os.path.splitext(n)[0])
order = [os.path.join(data_dir, 'ORDER.OBJ')]
# the run-time library modules (image 1076Bh..11FF0h: float helpers to RSCAT) were linked
# after every other module, as a library's are: their relocations come last in CPP.EXE's table
LIB = (0x1076B, 0x11FF0)
mods = [l.rstrip('\n').split('\t') for l in open(os.path.join(R, 'map', 'modules.tsv')) if not l.startswith('#')]
stem_of = lambda m: os.path.splitext(os.path.basename(m[8]))[0].upper()
libmods = [stem_of(m) for m in mods if LIB[0] <= int(m[2], 16) < LIB[1]]
mods = [m for m in mods if not LIB[0] <= int(m[2], 16) < LIB[1]]
for m in mods:
    stem = stem_of(m)
    order.append(cfg.obj(stem))
    for p in after.get(stem, []): order.append(os.path.join(data_dir, p + '.OBJ'))
for p in after.get('None', []): order.append(os.path.join(data_dir, p + '.OBJ'))
# The run-time modules are linked last, as objects in image order. (A library would order
# their relocations by library order, which could explain DPRINTF/DVPRINTF, but TLINK then
# leaves out the modules nothing references, and CPP.EXE has them all: see docs/FINDINGS.md.)
for st in libmods: order.append(cfg.obj(st))
order.append(order.pop(order.index(os.path.join(data_dir, 'DBSS.OBJ'))))
missing = [o for o in order if not os.path.exists(o)]
if missing: sys.exit(f'missing objects: {missing[:5]}')
# the one link step besides TLINK: fixup order for the objects of tools/fixorder.tsv
import fixorder as _fixorder
fixdir = os.path.join(B, 'LINK', 'FIX'); shutil.rmtree(fixdir, ignore_errors=True); os.makedirs(fixdir)
for stem, want in _fixorder.load_table().items():
    src = cfg.obj(stem); dst = os.path.join(fixdir, os.path.basename(src))
    try: data = _fixorder.reorder(open(src, 'rb').read(), want)
    except ValueError as e: sys.exit(f'fixorder: {stem}: {e}')
    open(dst, 'wb').write(data); order[order.index(src)] = dst
names = [os.path.basename(o) for o in order]
assert len(set(names)) == len(names), 'object names must be unique'

# 3. TLINK
outdir = os.path.join(B, 'LINK', 'out'); shutil.rmtree(outdir, ignore_errors=True)
rsp = os.path.join(B, 'LINK', 'LINK.RSP'); os.makedirs(os.path.dirname(rsp), exist_ok=True)
with open(rsp, 'w', newline='\r\n') as f:
    f.write(' +\n'.join(names) + '\n')
    f.write('CPP.EXE\n' + ('CPP.MAP\n' if want_map else 'NUL\n') + '\n')
opts = '/c /n' + (' /m /s' if want_map else ' /x')
rc, out = dos(outdir, [os.path.join(BIN, 'TLINK.EXE'), f'{rsp}=LINK.RSP'] + [f'{o}={n}' for o, n in zip(order, names)],
              [f'TLINK {opts} @LINK.RSP > TLINK.LOG'], ['TLINK.LOG'], ['CPP.EXE', 'CPP.MAP'])
print(open(os.path.join(outdir, 'TLINK.LOG'), encoding='latin1').read().strip())
exe = os.path.join(outdir, 'CPP.EXE')
if not os.path.exists(exe): sys.exit('no EXE')
# 4. compare
r = subprocess.run([sys.executable, os.path.join(EXHUME, 'tools', 'exediff.py'), exe, '--config', os.path.join(R, 'exhume.toml')])
sys.exit(r.returncode)
