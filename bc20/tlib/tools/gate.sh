#!/bin/sh
# Prove the tree: every source file matches its target, the library sources compile, and
# the full build gives the original TLIB.EXE.
cd "$(dirname "$0")/.." || exit 1
if [ -n "$PYTHON" ]; then PY=$PYTHON; elif [ -x ../../.venv/bin/python ]; then PY=../../.venv/bin/python; else PY=python3; fi
ok=0
for f in STUBS CMDLINE OMF HASH SYMTAB WALK ERROR FNAME DEMANGLE; do
	r=$($PY ../../exhume/tools/match.py src/$f.C 2>&1 | tail -1)
	case "$r" in *"WHOLE SEGMENT MATCHES"*) ;; *) echo "$f: $r"; ok=1;; esac
done
python3 tools/build.py | tail -1 | grep -q byte-identical || { echo "build: TLIB.EXE differs"; ok=1; }
[ $ok = 0 ] && echo "gate: all files match, TLIB.EXE byte-identical"
exit $ok
