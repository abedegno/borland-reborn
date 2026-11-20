import capstone,sys
e=open('/Users/jonw/borland-reborn/toolchains/BC20/BIN/EMSTEST.COM','rb').read()
md=capstone.Cs(capstone.CS_ARCH_X86,capstone.CS_MODE_16)
off=int(sys.argv[1],16)-0x100; end=int(sys.argv[2],16)-0x100
names={0x2514:'BEGIN_WRITE',0x2931:'WRITELN',0xfc5:'IOCHECK',0x28e2:'WRITE_STR',0x2875:'WRITE_INT',0x2859:'WRITE_CHAR',0x2ddb:'Hex',0x2e92:'EmsCall',0x2ed9:'StatusOk',0x2d58:'Avail',0x2d7f:'BigAvail',0x2e61:'Min',0x33d8:'Quit',0x343c:'Fatal',0x3498:'Report',0x34e0:'IntStr',0x351a:'AskContinue',0x35bd:'FrameSeg',0x3605:'FreePageCount',0x364d:'MapPage',0x3697:'FillPage',0x36fa:'CheckPage',0x3857:'MapAndCheck',0x3896:'MapWindow',0x38e7:'Allocate',0x393b:'Deallocate',0x397d:'SaveMap',0x39c2:'RestoreMap',0x12a5:'CONCAT',0x11e5:'STRPARAM',0x1174:'STRLOAD'}
skip=('dec sp','0xf74')
while off<end:
    i=next(md.disasm(e[off:off+8],off+0x100))
    if i.mnemonic=='call' and i.op_str in ('0x2919','0x118d'):
        n=e[off+3]; print('%04X  %s %r'%(i.address,'write' if i.op_str=='0x2919' else 'lit',e[off+4:off+4+n].decode('latin1'))); off+=4+n; continue
    t=i.op_str
    if i.mnemonic=='call':
        try: t=names.get(int(t,16),t)
        except: pass
    s='%s %s'%(i.mnemonic,t)
    if not (s=='dec sp' or t=='0xf74' or t=='IOCHECK' or (i.mnemonic=='mov' and i.op_str.startswith('cx, ') and e[off+3]==0xe8)): print('%04X  %s'%(i.address,s))
    off+=i.size
