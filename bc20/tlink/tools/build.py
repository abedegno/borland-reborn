"""Build TLINK.EXE (Turbo Link 4.0, Borland C++ 2.0) from src/ with the original tools, then
compare it with Borland's.

    python3 tools/build.py

1. Compile and assemble every module, in link order (LINK_ORDER below). Each C file's
   /* compiler: */ line picks Turbo C 2.01 (TC201) or Turbo C++ 1.0 (TC100); without one,
   Borland C++ 2.0's BCC. Its /* opts: */ line gives the switches (-B sends BCC's output
   through TASM 2.51, which BCC runs itself). TASM 2.51 assembles the .ASM files (/ml).
2. Two modules come from Borland C++ 2.0's own libraries, as they are: F_LXMUL from CL.LIB
   (the long multiply the core calls) and OVRHP from OVERLAY.LIB (__FAR_RETURN).
3. tools/fixorder.py puts the fixups of HPSHRINK.OBJ in TLINK.EXE's order (the one step
   that is not a plain compile or link; tools/fixorder.tsv gives the order and why).
4. TLINK 4.0 links the objects in LINK_ORDER (a response file: the list is too long for
   a DOS command line).
5. SHA-256 of build/link/out/TLINK.EXE against toolchains/BC20/BIN/TLINK.EXE. Exit status
   0 when they are identical."""
import glob, hashlib, os, re, shutil, struct, subprocess, sys

R = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
sys.path.insert(0, os.path.join(R, '..', '..', 'scripts'))
sys.path.insert(0, os.path.join(R, 'tools'))
import interim_rtl as rtl
import fixorder
TC = rtl.toolchains(R)
EXHUME = rtl.EXHUME
B = os.path.join(R, 'build', 'link')
ORIGINAL = os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE')

# Modules in link order: file under src/, or LIB:library:module for a library module.
LINK_ORDER = [
    'ORDER.ASM',            # the segment order
    'core/TLINK.ASM',       # the linker (CODE0, 0000..BF90)
    'core/TLDATA.ASM',      # its data, the stack and its uninitialised data
    'data/HEAPHEAD.ASM',    # ACTIVE_HEAP: DGROUP:0
    'asm/SETJMP.ASM',       # BF90
    'UNMANGLE.C',           # BFFE: the C++ name demangler
    'data/CTYPE.ASM',       # _ctype
    'LIB:CL.LIB:F_LXMUL',   # CDF8
    'LIB:OVERLAY.LIB:OVRHP',  # CE0F: __FAR_RETURN
    'asm/STUB40.ASM',       # CE10
    'rtl/RSCMP.C', 'rtl/RSLEN.C', 'CHARCASE.C', 'rtl/RMSET.C', 'rtl/RSCPY.C',
    'rtl/RMMOVE.C', 'rtl/RSCAT.C',
    'HEAP',                 # D029..10185: the heap library, in address order (targets/H_*)
    'data/HEAPDATA.ASM',    # the heap's DGROUP variables
    'data/OVRDATA.ASM',     # FAR46, FAR50
]


def header(path, key):
    m = re.search(r'/\* %s: (.*?) \*/' % key, open(path, encoding='latin1').read())
    return m.group(1) if m else None


def heap_files():
    """the heap sources in TLINK.EXE's address order"""
    rows = []
    for t in glob.glob(os.path.join(R, 'targets', 'H_*.tsv')):
        org = int(re.search(r'org (0x[0-9A-F]+)', open(t).readline()).group(1), 16)
        stem = os.path.basename(t)[2:-4]
        f = [p for p in (os.path.join('heap', stem + '.C'), os.path.join('heap', stem + '.ASM'))
             if os.path.exists(os.path.join(R, 'src', p))][0]
        rows.append((org, f))
    return [f for _, f in sorted(rows)]


def modules():
    out = []
    for m in LINK_ORDER:
        out += heap_files() if m == 'HEAP' else [m]
    return out


def run(cmd, what):
    r = subprocess.run(cmd, capture_output=True, text=True)
    log = os.path.join(cmd[3], 'RUN.LOG')
    text = open(log, encoding='latin1').read() if os.path.exists(log) else r.stdout + r.stderr
    if r.returncode:
        print(text); sys.exit('bc20/tlink: %s failed' % what)
    return text


def main():
    if not os.path.exists(ORIGINAL):
        sys.exit('no toolchains/BC20: run scripts/setup-toolchains.py with --bc20 (docs/SETUP.md)')
    shutil.rmtree(B, ignore_errors=True)
    os.makedirs(os.path.join(B, 'obj'))
    mods = modules()
    # 1. compile and assemble, one DOS run per compiler
    groups = {}
    for m in mods:
        if m.startswith('LIB:'): continue
        p = os.path.join(R, 'src', m)
        kind = 'ASM' if m.upper().endswith('.ASM') else (header(p, 'compiler') or 'BC20')
        groups.setdefault(kind, []).append(m)
    for kind, files in groups.items():
        out = os.path.join(B, 'c_' + kind)
        cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), out, '-t', '600']
        if kind == 'ASM':
            cmd += ['-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE')]
        elif kind == 'BC20':
            cmd += ['--stage', os.path.join(TC, 'BC20', 'BIN'), '-f', os.path.join(TC, 'BC20', 'INCLUDE') + '=INCLUDE']
        else:
            cmd += ['--stage', os.path.join(TC, kind, 'BIN'), '-f', os.path.join(TC, kind, 'INCLUDE') + '=INCLUDE',
                    '-f', os.path.join(TC, 'BC20', 'BIN', 'TASM.EXE')]
        for h in glob.glob(os.path.join(R, 'src', 'include', '*.H')):
            cmd += ['-f', h]
        for m in files:
            p = os.path.join(R, 'src', m)
            name = os.path.basename(m).upper()
            stem = name.rsplit('.', 1)[0]
            cmd += ['-f', p]
            if kind == 'ASM':
                cmd += ['-c', 'TASM /ml ' + name]
            else:
                cc = 'BCC' if kind == 'BC20' else 'TCC'
                cmd += ['-c', '%s -c %s -IINCLUDE -IC:\\ %s' % (cc, header(p, 'opts') or '', name)]
            cmd += ['-o', stem + '.OBJ']
        log = run(cmd, 'compiling (%s)' % kind)
        for m in files:
            stem = os.path.basename(m).upper().rsplit('.', 1)[0]
            shutil.copy(os.path.join(out, stem + '.OBJ'), os.path.join(B, 'obj', stem + '.OBJ'))
    # 2. library modules
    for m in mods:
        if not m.startswith('LIB:'): continue
        _, lib, name = m.split(':')
        for n, data in rtl.lib_modules(os.path.join(TC, 'BC20', 'LIB', lib)):
            if n == name:
                open(os.path.join(B, 'obj', name + '.OBJ'), 'wb').write(data); break
        else:
            sys.exit('bc20/tlink: %s has no module %s' % (lib, name))
    # 3. the fixup order of HPSHRINK
    p = os.path.join(B, 'obj', 'HPSHRINK.OBJ')
    try:
        data = fixorder.reorder(open(p, 'rb').read(), fixorder.load_table()['HPSHRINK'])
    except ValueError as e:
        sys.exit('bc20/tlink: fixorder: HPSHRINK: %s' % e)
    open(p, 'wb').write(data)
    # 4. link
    stems = [(m.split(':')[2] if m.startswith('LIB:') else os.path.basename(m).upper().rsplit('.', 1)[0]) for m in mods]
    open(os.path.join(B, 'obj', 'LINK.RSP'), 'w', newline='\r\n').write(
        ' +\n'.join(stems) + '\nTLINK\nTLINK\n')
    cmd = ['node', os.path.join(EXHUME, 'tools', 'dosrun.mjs'), os.path.join(B, 'out'), '-t', '600',
           '-f', os.path.join(TC, 'BC20', 'BIN', 'TLINK.EXE') + '=BTLINK.EXE']
    for s in stems:
        cmd += ['-f', os.path.join(B, 'obj', s + '.OBJ')]
    cmd += ['-f', os.path.join(B, 'obj', 'LINK.RSP'), '-c', 'BTLINK /m @LINK.RSP', '-o', 'TLINK.EXE', '-o', 'TLINK.MAP']
    log = run(cmd, 'linking')
    linked = os.path.join(B, 'out', 'TLINK.EXE')
    if re.search(r'(?i)error|undefined', log.replace('Error messages:    None', '')):
        print(log)
    sha = lambda f: hashlib.sha256(open(f, 'rb').read()).hexdigest()
    if open(linked, 'rb').read() == open(ORIGINAL, 'rb').read():
        print('TLINK.EXE: byte-identical to the original (SHA-256 %s)' % sha(linked))
        return 0
    print('TLINK.EXE: differs from the original (cmp %s %s)' % (linked, ORIGINAL))
    return 1


if __name__ == '__main__':
    sys.exit(main())
