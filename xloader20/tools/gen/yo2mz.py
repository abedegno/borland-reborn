"""yo2mz.py OVY OUT.EXE: the image of a YO file as a DOS program with no relocations, and its
segments (distinct descriptor bases) in OUT.EXE.json."""
import struct,sys,json
d=open(sys.argv[1],'rb').read()
dt,nd,io,isz,msz=struct.unpack_from('<IIIII',d,4)
img=d[io:io+isz]
D=[struct.unpack_from('<HHBBH',d,dt+8*k) for k in range(nd)]
bases=sorted({bl|bh<<16 for lim,bl,bh,a,z in D if (bl|bh<<16)<isz})
segs=[(b,(bases[i+1] if i+1<len(bases) else isz)) for i,b in enumerate(bases)]
tail=d[io+isz:]
for k in range(0,len(tail),0x8000): segs.append((isz+k,isz+min(len(tail),k+0x8000)))
hdr=512; out=bytearray(hdr)+img+tail; n=len(out)
struct.pack_into('<2sHHHHHHHHHHHHH',out,0,b'MZ',n%512,(n+511)//512,0,hdr//16,0,0xFFFF,0,0,0,0,0,0x1C,0)
open(sys.argv[2],'wb').write(out)
json.dump(dict(segs=segs,desc=D,hdr=d[:dt].hex(),tail=len(d)-io-isz,isz=isz),open(sys.argv[2]+'.json','w'))
print(len(segs),'segments',[hex(a) for a,b in segs])
