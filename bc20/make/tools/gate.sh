#!/bin/sh
# Prove the tree: every source file matches its part of MAKE.EXE and verifies, and the full
# build gives the original MAKE.EXE.
cd "$(dirname "$0")/.." || exit 1
if [ -n "$PYTHON" ]; then PY=$PYTHON; elif [ -x ../../.venv/bin/python ]; then PY=../../.venv/bin/python; else PY=python3; fi
ok=0
for f in src/BUILD.C src/MAKEIN.C src/MAIN.C src/PARSE.C src/EXEC.C src/MACRO.C src/IFEXPR.C \
	 src/CONFIG.C src/ERRORS.C src/VMSG.C src/SPAWN.C src/SWAP.ASM \
	 ../rtl/src/FNSPLIT.C ../rtl/src/SEARCHP.C; do
	r=$($PY ../../exhume/tools/match.py $f 2>&1 | tail -1)
	case "$r" in *"WHOLE SEGMENT MATCHES"*) ;; *) echo "$f: $r"; ok=1;; esac
	v=$($PY ../../exhume/tools/verify.py $f 2>&1 | tail -1)
	case "$v" in *"verified"*) ;; *) echo "$f: $v"; ok=1;; esac
done
v=$($PY ../../exhume/tools/verify.py src/MSGS.C 2>&1 | tail -1)
case "$v" in *"verified"*) ;; *) echo "src/MSGS.C: $v"; ok=1;; esac
$PY tools/build.py | tail -1 | grep -q byte-identical || { echo "build: MAKE.EXE differs"; ok=1; }
[ $ok = 0 ] && echo "gate: all files match and verify, MAKE.EXE byte-identical"
exit $ok
