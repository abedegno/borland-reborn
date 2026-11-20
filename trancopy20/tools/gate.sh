#!/bin/sh
# Prove the tree: match every source file against its part of the original TRANCOPY.EXE,
# and check that the full build gives the original.
cd "$(dirname "$0")/.." || exit 1
if [ -n "$PYTHON" ]; then PY=$PYTHON; elif [ -x ../.venv/bin/python ]; then PY=../.venv/bin/python; else PY=python3; fi
ok=0
for f in TRANCOPY.CPP PRJFILE.CPP PUTC.C; do
	r=$($PY ../exhume/tools/match.py src/$f 2>&1 | tail -1)
	case "$r" in *"WHOLE SEGMENT MATCHES"*) ;; *) echo "$f: $r"; ok=1;; esac
done
$PY tools/build.py | tail -1 | grep -q byte-identical || { echo "build: TRANCOPY.EXE differs"; ok=1; }
[ $ok = 0 ] && echo "gate: all files match, TRANCOPY.EXE byte-identical"
exit $ok
