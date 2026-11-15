#!/bin/sh
# Smoke test: the native compiler and the library agree on a compile.
set -e
P=$(cd "$(dirname "$0")/.." && pwd)
d=$(mktemp -d)
cd "$d"
printf 'int add(int a,int b){return a+b;}\nint main(void){return add(1,2);}\n' > HELLO.C
printf 'void f(void){}\n' > T2.C

"$P/build/bcc" -c -ml -O HELLO.C > /dev/null
mv -f hello.obj native1.obj 2>/dev/null || mv -f HELLO.OBJ native1.obj
"$P/build/bcc20run" --file HELLO.C --repeat 2 -- -c -ml -O HELLO.C > /dev/null
cmp native1.obj HELLO.OBJ
echo "OK native vs library: $(wc -c < HELLO.OBJ) bytes identical"

"$P/build/bcc" -c -ml T2.C > /dev/null
mv -f t2.obj native2.obj 2>/dev/null || mv -f T2.OBJ native2.obj
"$P/build/bcc20run" --file T2.C -- -c -ml T2.C > /dev/null
cmp native2.obj T2.OBJ
echo "OK second file"
rm -rf "$d"
