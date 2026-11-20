"""dis.py START END: disassemble TLINK's image (offsets past the header), marking relocated words R."""
import sys,struct,capstone,os
R=os.path.abspath(os.path.join(os.path.dirname(__file__),'..'))
d=open(os.path.join(R,'toolchain','BC20','BIN','TLINK.EXE'),'rb').read(); hs=struct.unpack_from('<H',d,8)[0]*16; img=d[hs:]
n=struct.unpack_from('<H',d,6)[0]; ro=struct.unpack_from('<H',d,0x18)[0]
rel=set(s*16+o for o,s in (struct.unpack_from('<HH',d,ro+4*k) for k in range(n)))
lo,hi=int(sys.argv[1],16),int(sys.argv[2],16)
md=capstone.Cs(capstone.CS_ARCH_X86,capstone.CS_MODE_16)
import re
for i in md.disasm(img[lo:hi],0):
    a=lo+i.address; r=' R' if any(a<=x<a+i.size for x in rel) else ''
    op=i.op_str
    if (i.mnemonic.startswith('j') or i.mnemonic in ('call','loop','jcxz')) and re.fullmatch(r'0x[0-9a-f]+',op):
        op='%05X'%((int(op,16)+lo)&0xFFFFF if int(op,16)<0x10000 else (int(op,16)-0x100000000+lo))
    print('%05X +%03X %-12s %s %s%s'%(a,i.address,i.bytes.hex(),i.mnemonic,op,r))
