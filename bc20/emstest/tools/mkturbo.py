"""mkturbo.py TURBO.COM RT302.TSV OUT.COM: Turbo Pascal 3.02A, patched to compile EMSTEST.COM's
program part as Borland's compiler did, and the runtime EMSTEST.COM carries.

- OUT.COM: TP 3.02A with its constants for where a program starts (2D4Dh, 2C4Dh, 2D50h) and the
  runtime addresses it emits calls to (compiler.tsv, next to RT302.TSV) lowered by 14, and the
  .COM writer (5B1Ch) cut to 2C3Fh runtime bytes. The compiler itself still runs on its own,
  unchanged runtime.
- OUT.RT: the 2C3Fh-byte runtime, TP 3.02A's with RT302.TSV applied (the 14-byte window check
  at 215h removed, the addresses after it lowered by 14, the display settings TINST wrote).
  The build puts it in place of the runtime the compiler writes."""
import struct,sys
t=bytearray(open(sys.argv[1],'rb').read())
rt=bytearray(t[:0x2C4D]); rows=[]
for l in open(sys.argv[2]):
    if not l.strip() or l.startswith('#'): continue
    f=l.rstrip('\n').split('\t'); rows.append((int(f[0],16),bytes.fromhex(f[1]),bytes.fromhex(f[2])))
for off,old,new in sorted(rows,reverse=True):   # from the end, so that earlier offsets hold
    assert rt[off:off+len(old)]==old,(hex(off),rt[off:off+len(old)].hex(),old.hex())
    rt[off:off+len(old)]=new
assert len(rt)==0x2C3F,hex(len(rt))
COMPILER=[]  # (address, old word, new word)
def patch(addr,old,new):
    o=addr-0x100; assert struct.unpack_from('<H',t,o)[0]==old,(hex(addr),hex(struct.unpack_from('<H',t,o)[0]))
    struct.pack_into('<H',t,o,new)
for a,v in ((0x5AA6,0x2D4D),(0x5ABB,0x2D4D),(0x5ACD,0x2D4D),(0x5AF7,0x2D4D),(0x5B91,0x2D4D),(0x5AC3,0x2C4D),(0x5AC9,0x2C4D),(0x5B3C,0x2D50),(0x5B4B,0x2D50),(0x5BA3,0x2D50)):
    patch(a,v,v-14)
patch(0x5B1D,0x2C4D,0x2C3F)
for a in [int(l.split()[0],16) for l in open(sys.argv[2].replace("rt302.tsv","compiler.tsv")) if l.strip() and not l.startswith("#")]:
    v=struct.unpack_from('<H',t,a-0x100)[0]; patch(a,v,v-14)
open(sys.argv[3],'wb').write(t)
open(sys.argv[3][:-4]+'.RT','wb').write(rt)
