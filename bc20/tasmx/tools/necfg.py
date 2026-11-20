# TASMX.EXE's NE program, for tools/mz2ne.py.
# SEGS: (start in the DOS image TLINK links from src/TASMX.ASM, length, memory size, data?).
# The four code segments are the protected-mode builds of TASM.EXE's four code segments;
# segment 5 is DGROUP, 36A0h bytes of data in a 5CE0h-byte segment whose end is the stack.
SEGS=[(0x0,0xFF77,0xFF77,0),(0xFF80,0x4F92,0x4F92,0),(0x14F20,0x3D,0x3D,0),(0x14F60,0x17A2,0x17A2,0),(0x16710,0x36A0,0x5CE0,1)]
ENTRY=(4,0x0ADD); STACK=(5,0x5CE0); AUTODATA=5
NAME='Tasm'; DESCRIPTION='Turbo Assembler'
