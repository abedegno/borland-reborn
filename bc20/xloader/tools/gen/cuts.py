"""cuts.py SPEC SEG: record cut points for a C module from the original's relocation order
(each descending run of relocations is one LEDATA record of BCC's)."""
import struct,sys
S={}; exec(open(sys.argv[1]).read(),S)
b=open(S['EXE'],'rb').read(); n=struct.unpack_from('<H',b,6)[0]
rb=[s*16+o for o,s in (struct.unpack_from('<HH',b,0x3e+4*k) for k in range(n))]
m1=[x for x in S['SEGS'] if x[0]==sys.argv[2]][0]
run=[r for r in rb if m1[1]<=r<m1[2]]; runs=[[run[0]]]
for x,y in zip(run,run[1:]):
    if y>x: runs.append([])
    runs[-1].append(y)
print(' '.join('%X'%(min(r)-m1[1]) for r in runs[1:]))
