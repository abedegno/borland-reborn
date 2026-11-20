import capstone,sys
e=open('/Users/jonw/borland-reborn/toolchains/BC20/BIN/EMSTEST.COM','rb').read()
md=capstone.Cs(capstone.CS_ARCH_X86,capstone.CS_MODE_16)
off=int(sys.argv[1],16)-0x100; end=int(sys.argv[2],16)-0x100
names={0x2514:'BEGIN_WRITE',0x2931:'WRITELN',0xfc5:'IOCHECK',0x28e2:'WRITE_STR',0x2875:'WRITE_INT?',0x2ddb:'Hex',0x2e92:'EmsCall',0x2ed9:'StatusOk',0x2d58:'Avail',0x2d7f:'BigAvail'}
while off<end:
    i=next(md.disasm(e[off:off+8],off+0x100))
    if i.mnemonic=='call' and i.op_str=='0x2919':
        n=e[off+3]; print('%04X  write %r'%(i.address,e[off+4:off+4+n].decode('latin1'))); off+=4+n; continue
    t=i.op_str
    if i.mnemonic=='call':
        try: t=names.get(int(t,16),t)
        except: pass
    print('%04X  %-12s %s %s'%(i.address,i.bytes.hex(),i.mnemonic,t)); off+=i.size
