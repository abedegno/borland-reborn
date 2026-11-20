"""revfix.py OBJ [CUT...]: make a TASM object's fixups come out as BCC writes them. The
segment's data is re-cut into LEDATA records at the given offsets (hex; a C module has one
record per function), and the fixups of each record are sorted by location, descending.
Single-segment objects with explicit fixups only."""
import sys,struct
p=sys.argv[1]; cuts=sorted(int(x,16) for x in sys.argv[2:])
d=open(p,'rb').read(); recs=[]; i=0
while i<len(d):
    t=d[i]; n=struct.unpack_from('<H',d,i+1)[0]; recs.append((t,d[i+3:i+3+n-1])); i+=3+n
def idx(b,j): return j+2 if b[j]&0x80 else j+1
data=bytearray(); fix=[]; seg=None; first=None; last=None; base=0
for k,(t,b) in enumerate(recs):
    if t==0xA0:
        if first is None: first=k
        last=k; seg=b[0]; base=struct.unpack_from('<H',b,1)[0]; ch=b[3:]
        if len(data)<base+len(ch): data.extend(bytes(base+len(ch)-len(data)))
        data[base:base+len(ch)]=ch
    elif t==0x9C:
        last=k; j=0
        while j<len(b):
            c=b[j]; s=j
            if not c&0x80: raise SystemExit('thread subrecord')
            off=((c&3)<<8)|b[j+1]; j+=2; fd=b[j]; j+=1
            if not fd&0x80 and ((fd>>4)&7)<3: j=idx(b,j)
            if not fd&0x08 and (fd&3)<3: j=idx(b,j)
            if not fd&0x04: j+=2
            fix.append((base+off,bytes(b[s+2:j]),c&0xFC))
    elif first is not None and t in (0xA2,0xA1,0x9D): raise SystemExit('record %02X not handled'%t)
assert all(t in (0xA0,0x9C) for t,_ in recs[first:last+1])
edges=[0]+[c for c in cuts if 0<c<len(data)]+[len(data)]
out=[]
for lo,hi in zip(edges,edges[1:]):
    while lo<hi:
        h=min(hi,lo+1024)
        out.append((0xA0,bytes([seg])+struct.pack('<H',lo)+bytes(data[lo:h])))
        fs=sorted((f for f in fix if lo<=f[0]<h),key=lambda f:-f[0])
        if fs:
            out.append((0x9C,b''.join(bytes([c|((a-lo)>>8),(a-lo)&0xFF])+rest for a,rest,c in fs)))
        lo=h
recs=recs[:first]+out+recs[last+1:]
o=bytearray()
for t,b in recs:
    r=bytes([t])+struct.pack('<H',len(b)+1)+b; o+=r+bytes([(-sum(r))&0xFF])
open(p,'wb').write(o)
