"""emscmp.py OUT.COM: compare a TP 3.02A build of EMSTEST.PAS with EMSTEST.COM's program part.
3.02A's runtime is 14 bytes longer, so a word that differs by exactly 14 (an absolute address,
or a call into the runtime's first 215h bytes) counts as equal. Prints the first real
difference with context."""
import sys,struct
o=open(sys.argv[1],'rb').read()[0x2C4D:]; e=open('/Users/jonw/borland-reborn/toolchains/BC20/BIN/EMSTEST.COM','rb').read()[0x2C3F:]
print('parameter block', 'same' if o[3:0x17]==e[3:0x17] and o[0x1C:0x20]==e[0x1C:0x20] else 'differs (sizes follow from the code)')
i=0x23; bad=None
while i<min(len(o),len(e)):
    if o[i]==e[i]: i+=1; continue
    ok=False
    for j in (i-1,i):
        if j>=0 and j+2<=min(len(o),len(e)) and abs(struct.unpack_from('<H',o,j)[0]-struct.unpack_from('<H',e,j)[0])==14: ok=True; nxt=j+2
    if ok: i=nxt; continue
    bad=i; break
print('lengths', hex(len(o)), hex(len(e)))
if bad is None and len(o)==len(e): print('MATCH'); sys.exit(0)
bad=bad if bad is not None else min(len(o),len(e))
print('first difference at program offset %X (EMSTEST address %04X)'%(bad,bad+0x2C3F+0x100))
print(' ours ', o[bad-8:bad+16].hex(' ')); print(' orig ', e[bad-8:bad+16].hex(' ')); sys.exit(1)
