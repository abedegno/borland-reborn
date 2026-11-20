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
- src/EMSTEST.PAS: complete. Built with stock TP 3.02A (`tools/tp3c.sh EMSTEST 8 'A1000\r'`:
  compiler options Com-file, mAximum free dynamic memory 1000h), its program part equals
  EMSTEST.COM's except for the 14-byte runtime shift (tools/emscmp.py: MATCH). It needs
  {$P512} (a 512-byte output buffer, which is why the globals start at 462h).
- The parameter block after the start-up call still differs in three words: 4DEh against 4DDh
  (follows from the runtime's size; the patched compiler gives it), and 0087h/0A4Bh against
  47C9h/518Ch (segment values from the compile: where TURBO.COM was loaded on the machine that
  built it; Borland's own 1985 programs carry other values of the same kind).
- Next: the patched compiler (runtime without the window check, the compiler's runtime
  addresses and program origin lowered by 14) and the build script.
- tools/outline.py, tools/outline2.py START END: disassemble EMSTEST between two addresses, with inline strings and routine names.
