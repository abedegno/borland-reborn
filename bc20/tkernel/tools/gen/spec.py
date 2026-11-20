EXE='/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/tk/drv.exe'
F=[0x0,0x50a,0x589,0x59f,0x5ad,0x5ed,0x5fd,0x8ef,0x8f6,0x908,0x9cf,0x9d2,0x9f3,0x9fa,0xbb9]
END=0xD330
SEGS=[]
for i,f in enumerate(F):
    lo=f*16; hi=F[i+1]*16 if i+1<len(F) else END
    if f==0x9d2: hi=0x9D20+0x207
    decl="segment para stack 'CODE'" if f==0x9d2 else "segment para public 'CODE'"
    SEGS.append(('S%03X'%f,lo,hi,'code',decl,f))
SEGS.append(('SD33',END,END,'bss',"segment para public 'BSS'",0xd33))
SEGNAME={f:'S%03X'%f for f in F}; SEGNAME[0xd33]='SD33'
ENTRIES=[0x9fa9]
NAMES={0x9fa9:'start'}
HEAD='\t.286p\n\tlocals'
TAIL='\tend\tstart'
TRACE_ONLY=True
import struct as _st
_d=open(EXE,'rb').read(); _img=_d[0x800:]
_n=_st.unpack_from('<H',_d,6)[0]; _ro=_st.unpack_from('<H',_d,0x18)[0]
_rel=set(s*16+o for o,s in (_st.unpack_from('<HH',_d,_ro+4*k) for k in range(_n)))
for _r in sorted(_rel):
    if _d[0x800+_r-3:0x800+_r-2] and _img[_r-3] in (0x9a,0xea):
        _o,_sv=_st.unpack_from('<HH',_img,_r-2); ENTRIES.append(_sv*16+_o)
NODD={0x56AC}
