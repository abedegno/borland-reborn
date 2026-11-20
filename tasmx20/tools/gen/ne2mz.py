"""ne2mz.py NE.EXE OUT.EXE: an equivalent DOS image of an NE program's segments, for the
generator: segments one after another at paragraph boundaries, each NE segment (selector)
fixup turned into a DOS relocation holding the segment's paragraph."""
import struct,sys,json
d=open(sys.argv[1],'rb').read(); ne=struct.unpack_from('<I',d,0x3c)[0]
nseg=struct.unpack_from('<H',d,ne+0x1C)[0]; st=ne+struct.unpack_from('<H',d,ne+0x22)[0]
sh=struct.unpack_from('<H',d,ne+0x32)[0]
segs=[]; base=0
for k in range(nseg):
    off,ln,fl,mn=struct.unpack_from('<4H',d,st+8*k)
    ln=ln or 0x10000; segs.append(dict(file=off<<sh,len=ln,flags=fl,alloc=mn or 0x10000,base=base))
    base+=(max(ln,mn or 0x10000) +15)&~15
img=bytearray(base); rel=[]; chains=[]
for k,s in enumerate(segs):
    img[s['base']:s['base']+s['len']]=d[s['file']:s['file']+s['len']]
for k,s in enumerate(segs):
    if not s['flags']&0x100: continue
    e=s['file']+s['len']; n=struct.unpack_from('<H',d,e)[0]
    for j in range(n):
        typ,fl,o,tseg,z,toff=struct.unpack_from('<BBHBBH',d,e+2+8*j)
        assert typ==2 and fl==0, (typ,fl)
        frame=segs[tseg-1]['base']>>4; ch=[]
        while o!=0xFFFF:
            a=s['base']+o; nxt=struct.unpack_from('<H',img,a)[0]
            struct.pack_into('<H',img,a,frame); rel.append(a); ch.append(o); o=nxt
        chains.append(dict(seg=k+1,target=tseg,locs=ch))
ip=struct.unpack_from('<H',d,ne+0x14)[0]; cs=struct.unpack_from('<H',d,ne+0x16)[0]
sp=struct.unpack_from('<H',d,ne+0x18)[0]; ss=struct.unpack_from('<H',d,ne+0x1A)[0]
hdr=0x20+((len(rel)*4+15)//16)*16 if False else ((0x1C+len(rel)*4+511)//512)*512
out=bytearray(hdr)+img[:sum(1 for _ in [0]) and len(img)]
n=len(out)
struct.pack_into('<2sHHHHHHHHHHHHH',out,0,b'MZ',n%512,(n+511)//512,len(rel),hdr//16,0,0xFFFF,segs[ss-1]['base']>>4,sp,0,ip,segs[cs-1]['base']>>4,0x1C,0)
for i,a in enumerate(sorted(rel)): struct.pack_into('<HH',out,0x1C+4*i,a&15,a>>4)
open(sys.argv[2],'wb').write(out)
json.dump(dict(segs=segs,chains=chains),open(sys.argv[2]+'.json','w'),indent=1)
for s in segs: print('seg base %05X len %04X alloc %04X flags %04X'%(s['base'],s['len'],s['alloc'],s['flags']))
print(len(rel),'relocations')
