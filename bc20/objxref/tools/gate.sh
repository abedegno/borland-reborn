#!/bin/sh
# Prove the tree: unpack the original OBJXREF.COM for Exhume, match every source file against
# its part of the original, and check that the full build gives the original OBJXREF.COM.
cd "$(dirname "$0")/.." || exit 1
if [ -n "$PYTHON" ]; then PY=$PYTHON; elif [ -x ../../.venv/bin/python ]; then PY=../../.venv/bin/python; else PY=python3; fi
mkdir -p build
$PY tools/compack.py unpack toolchain/BC20/BIN/OBJXREF.COM build/OBJXREF.EXE || exit 1
ok=0
for f in OBJXREF DEMANGLE PRJ; do
	r=$($PY ../../exhume/tools/match.py src/$f.C 2>&1 | tail -1)
	case "$r" in *"WHOLE SEGMENT MATCHES"*) ;; *) echo "$f: $r"; ok=1;; esac
done
$PY tools/build.py | tail -1 | grep -q byte-identical || { echo "build: OBJXREF.COM differs"; ok=1; }
[ $ok = 0 ] && echo "gate: all files match, OBJXREF.COM byte-identical"
exit $ok
