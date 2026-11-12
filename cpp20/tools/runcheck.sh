#!/bin/sh
# Run check: preprocess the same files with the original CPP.EXE and the linked one in emu2
# and compare the .i outputs and the console output.
#   sh tools/runcheck.sh [LINKED.EXE]
set -e
R=$(cd "$(dirname "$0")/.." && pwd)
# emu2: built by Exhume's tools/setup-emu2.sh (./exhume here, ../exhume in the repo)
EMU2=${EMU2:-$(ls "$R"/exhume/tools/emu2/emu2 "$R"/../exhume/tools/emu2/emu2 2>/dev/null | head -1)}
[ -x "$EMU2" ] || { echo "emu2 not found: run sh ../exhume/tools/setup-emu2.sh or set EMU2"; exit 2; }
NEW=${1:-$R/build/LINK/out/CPP.EXE}
W=$R/build/RUN; rm -rf "$W"; mkdir -p "$W/orig" "$W/new"
for d in orig new; do
  cp "$R"/tests/run/*.C "$R"/tests/run/*.H "$W/$d/"
  mkdir -p "$W/$d/INC"; cp "$R"/toolchain/BC20/INCLUDE/*.H "$W/$d/INC/"
done
cp "$R/toolchain/BC20/BIN/CPP.EXE" "$W/orig/CPP.EXE"; cp "$NEW" "$W/new/CPP.EXE"
fail=0
for t in "T1.C" "-P- T1.C" "-DX=5 -UA T3.C" "-IINC T4.C" "-ms -A T5.C" "T6.C"; do
  for d in orig new; do
    ( cd "$W/$d" && rm -f *.i *.I; "$EMU2" CPP.EXE $t > console.txt 2>&1 || true
      cat console.txt $(ls *.i *.I 2>/dev/null || true) > "out_$(echo $t | tr ' /=' '___').txt" )
  done
  f="out_$(echo $t | tr ' /=' '___').txt"
  if cmp -s "$W/orig/$f" "$W/new/$f"; then echo "same: CPP $t ($(wc -l < "$W/orig/$f") lines)"; else echo "DIFFERENT: CPP $t"; fail=1; fi
done
exit $fail
