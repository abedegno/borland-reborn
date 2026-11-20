#!/bin/bash
# tp3c.sh NAME [WAIT] [OPTIONS]: compile NAME.PAS to NAME.COM with TURBO.COM in emu2
# (keystrokes through a pty). OPTIONS: keystrokes typed in the compiler-options menu after
# choosing Com-file, e.g. 'A1000\r' for "mAximum free dynamic memory: 1000".
E=~/Exhume/tools/emu2/emu2
(sleep 1; printf 'N'; sleep 1; printf 'O'; sleep 0.4; printf 'C'; sleep 0.4
 if [ -n "$3" ]; then printf "$3"; sleep 0.6; fi
 printf 'Q'; sleep 0.4; printf 'M'; sleep 0.4; printf '%s\r' "$1"; sleep 0.4; printf 'C'; sleep ${2:-4}; printf ' '; sleep 0.5; printf 'Q'; sleep 1.5) | perl -e 'alarm 45; exec @ARGV' script -q log_$1.txt $E TURBO.COM >/dev/null 2>&1
