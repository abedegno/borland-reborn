"""The run-time library Borland linked its Borland C++ 2.0 utilities with (touch20, tlib20).

Borland built TOUCH, TLIB and the other utilities with Turbo C++ 1.01, but linked them with
a run-time library that sat between Turbo C++ 1.01's and Borland C++ 2.0's. Neither
product's library reproduces them alone. This module rebuilds that library's pieces from
the two products' own files:

    c0_source()       the startup module's source: Borland C++ 2.0's STARTUP/C0.ASM with
                      Turbo C++ 1.01's banner, "Turbo C++ - Copyright 1990 Borland Intl.".
                      TOUCH.COM's C0T and TLIB.EXE's C0C equal it in every byte of code and
                      data. Assemble it as Borland's BUILD-C0.BAT does: TASM_C0 below.
    extract(lib, names, out)
                      the named modules of a .LIB, written as OBJ files to be linked as
                      objects (each utility's build lists which product's module it takes,
                      in the order of the original).
    library(tc, model, out, tc101=())
                      the interim library itself, for a link that searches it: every module
                      of Borland C++ 2.0's C?.LIB in its own order, with the named modules
                      taken from Turbo C++ 1.01's library instead, written as OBJ files to
                      OUT; returns the module names in order, for a TLIB response file.
                      The modules no released library has are rebuilt from C:
                      ../interim-rtl/src (INTERIM below gives each one's BCC switches), and
                      library() leaves them out for the build to compile in their place.

Every function finds the toolchains through toolchains() and stops with a message when a
file is not the expected one."""
import os, struct, sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
EXHUME = os.path.join(ROOT, 'exhume')
sys.path.insert(0, os.path.join(EXHUME, 'tools'))
import omf

RTL_SRC = os.path.join(ROOT, 'interim-rtl', 'src')
# the interim modules rebuilt from C, with Borland C++ 2.0's BCC (../interim-rtl/README.md)
INTERIM = {'FFLUSH': '-O -Z', 'FGETS': '-O -Z', 'FREAD': '-B -O -Z', 'GETC': '-B -O -Z -k-'}

# BC 2.0's STARTUP/BUILD-C0.BAT: TASM /M /MX /Q /T /D__TINY__ c0, c0t (and so on per model)
TASM_C0 = 'TASM /M /MX /Q /T /D__{model}__ C0,{obj}'


def toolchains(project):
    """the toolchains folder: PROJECT/toolchain, else the repository's toolchains/"""
    for p in (os.path.join(project, 'toolchain'), os.path.join(ROOT, 'toolchains')):
        if os.path.isdir(os.path.join(p, 'TC101')) and os.path.isdir(os.path.join(p, 'BC20', 'LIB')):
            return p
    sys.exit('no toolchains with TC101 and BC20/LIB: run scripts/setup-toolchains.py with --bc20 and --tc101 '
             '(docs/SETUP.md)')


def c0_source(tc):
    """BC 2.0's C0.ASM with Turbo C++ 1.01's banner, as bytes"""
    s = open(os.path.join(tc, 'BC20', 'STARTUP', 'C0.ASM'), 'rb').read()
    old, new = b"'Borland C++ - Copyright 1991 Borland Intl.'", b"'Turbo C++ - Copyright 1990 Borland Intl.'"
    if s.count(old) != 1:
        sys.exit('toolchains/BC20/STARTUP/C0.ASM is not the expected file')
    return s.replace(old, new)


def extract(lib, names, out):
    """write the named modules of a .LIB as OUT/NAME.OBJ"""
    d = open(lib, 'rb').read(); page = struct.unpack_from('<H', d, 1)[0] + 3; p = page; got = set()
    os.makedirs(out, exist_ok=True)
    while p < len(d) and d[p] == 0x80:
        r = omf.module_masked(d, p); end = r[4]
        if r[0].upper() in names:
            open(os.path.join(out, r[0].upper() + '.OBJ'), 'wb').write(d[p:end]); got.add(r[0].upper())
        p = ((end + page - 1) // page) * page
    if got != set(names):
        sys.exit(f'{lib} lacks {sorted(set(names) - got)}')


def lib_modules(lib):
    """(NAME, bytes) for each module of a .LIB, in library order"""
    d = open(lib, 'rb').read(); page = struct.unpack_from('<H', d, 1)[0] + 3; p = page; out = []
    while p < len(d) and d[p] == 0x80:
        r = omf.module_masked(d, p); end = r[4]
        out.append((r[0].upper(), d[p:end])); p = ((end + page - 1) // page) * page
    return out


def library(tc, model, out, tc101=()):
    """write the interim library's modules to OUT as NAME.OBJ; return the names in order"""
    lib = 'C' + model[0].upper() + '.LIB'
    bc = lib_modules(os.path.join(tc, 'BC20', 'LIB', lib))
    old = dict(lib_modules(os.path.join(tc, 'TC101', 'LIB', lib)))
    os.makedirs(out, exist_ok=True); names = []
    for name, data in bc:
        if name in tc101:
            if name not in old:
                sys.exit(f'Turbo C++ 1.01 {lib} lacks {name}')
            data = old[name]
        if name not in INTERIM:
            open(os.path.join(out, name + '.OBJ'), 'wb').write(data)
        names.append(name)
    missing = set(tc101) - set(names)
    if missing:
        sys.exit(f'{lib} lacks {sorted(missing)}')
    return names
