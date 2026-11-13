#!/bin/sh
# make check: replay every translated function against its records.  Functions the corpus
# never calls cannot be checked; they are listed, and do not fail the check.
fail=0; unchecked=""
python3 tools/aliascheck.py || fail=1
for f in $(build/replay --list); do
    if [ ! -f "records/$f.rec" ]; then
        echo "$f: no records (python3 tools/record.py $f)"; fail=1; continue
    fi
    out=$(build/replay "$f" "records/$f.rec"); status=$?
    case "$out" in
        *"no recorded calls"*) unchecked="$unchecked $f" ;;
        *) echo "$out"; [ $status -eq 0 ] || fail=1 ;;
    esac
done
[ -n "$unchecked" ] && echo "not reached by the corpus, so not checked:$unchecked"
exit $fail
