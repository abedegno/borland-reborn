# emstest20 (work in progress, not yet a build)

EMSTEST.COM of Borland C++ 2.0 is a Turbo Pascal 3 program (an expanded-memory test). No
released Turbo Pascal 3 has its runtime: it is TP 3.02A's minus a 14-byte window check in the
cursor routine at 215h, with everything after it 14 bytes lower. The agreed workaround:
recover EMSTEST.PAS, then build it with a patched TP 3.02A (runtime without the check, the
compiler's runtime-address immediates lowered by 14), documented as a native difference.

- tools/tp3c.sh NAME: compiles NAME.PAS with TURBO.COM in emu2 (keystrokes through a pty);
  needs TURBO.COM and TURBO.MSG of 3.02A in the working directory (not in the repo).
- tools/emscmp.py OUT.COM: compares a 3.02A build's program part (from 2C4Dh) with
  EMSTEST.COM's (from 2C3Fh), accepting words that differ by exactly 14.
- tools/PROBE.PAS: maps runtime call targets to builtins (3.02A address - 14 = EMSTEST's
  for targets at 315h and above).
- src/EMSTEST.PAS: matches through the first 40% of the program part (to 39FEh: the EMS wrappers, page fill/check, map save/restore); globals placed with filler arrays (Fill0..Fill2, FillA, FillB) until all are known.
- tools/outline.py START END: disassembles EMSTEST between two addresses, with inline strings and known routine names.
