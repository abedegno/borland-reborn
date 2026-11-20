#!/bin/sh
# Prove the tree: match every source file that has a target table against its part of the
# original TLINK.EXE, check the core assembly module line by line, and check that the full
# build gives the original.
cd "$(dirname "$0")/.." || exit 1
if [ -n "$PYTHON" ]; then PY=$PYTHON; elif [ -x ../.venv/bin/python ]; then PY=../.venv/bin/python; else PY=python3; fi
ok=0
for t in targets/*.tsv; do
	s=$(basename "$t" .tsv); s=${s#*_}
	f=$(ls src/$s.C src/$s.ASM src/*/$s.C src/*/$s.ASM 2>/dev/null | head -1)
	r=$($PY tools/segdiff.py "$f" 2>&1 | head -1)
	case "$r" in *"WHOLE SEGMENT MATCHES"*) ;; *) echo "$f: $r"; ok=1;; esac
done
$PY tools/asmcheck.py src/core/TLINK.ASM 0 build/asmcheck >/dev/null || { echo "core/TLINK.ASM: lines differ"; ok=1; }
$PY tools/build.py | tail -1 | grep -q byte-identical || { echo "build: TLINK.EXE differs"; ok=1; }
[ $ok = 0 ] && echo "gate: all files match, TLINK.EXE byte-identical"
exit $ok
