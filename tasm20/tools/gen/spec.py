import os
EXE=os.path.join(os.path.dirname(os.path.abspath(__file__)) if '__file__' in globals() else '.','..','..','toolchain','BC20','BIN','TASM.EXE')
C="segment byte public 'CODE'"
SEGS=[('CODE0',0x0,0xF9B0,'code',C,0x0),
 ('C0F9B',0xF9B0,0x14550,'code',C,0xF9B),
 ('C1455',0x14550,0x1459B,'code',C,0x1455),
 ('C1459',0x1459C,0x15F61,'code',"segment word public 'CODE'",0x1459),
 ('DATA',0x15F61,0x19819,'data',"segment byte public 'DATA'",0x15F6),
 ('BSS',0x19819,0x1B810,'bss',"segment byte public 'BSS'",0x15F6),
 ('STK',0x1B810,0x1BC1A,'bss',"segment para stack 'STACK'",0x1B81)]
SEGNAME={0x0:'CODE0',0xF9B:'C0F9B',0x1455:'C1455',0x1459:'C1459',0x15F6:'DGROUP'}
ENTRIES=[0x15217]
NAMES={0x15217:'start'}
HEAD='\t.286\n\tlocals\nDGROUP\tgroup\tDATA,BSS'
TAIL='\tend\tstart'
TRACE_ONLY=True
import struct as _st
_d=open(EXE,'rb').read(); _img=_d[0x800:]
_n=_st.unpack_from('<H',_d,6)[0]; _ro=_st.unpack_from('<H',_d,0x18)[0]
_rel=set(s*16+o for o,s in (_st.unpack_from('<HH',_d,_ro+4*k) for k in range(_n)))
for _r in sorted(_rel):
    _sv=_st.unpack_from('<H',_img,_r)[0]; _o=_st.unpack_from('<H',_img,_r-2)[0]
    if _sv in (0x0,0xF9B,0x1455,0x1459):
        _t=_sv*16+_o
        if _t<0x15F61 and (_img[_r-3] in (0x9a,0xea) or _img[_t] in (0x55,0xc8,0x50,0x53,0x51,0x52,0x56,0x57,0x1e,0x06,0xfa,0xfc,0x8b,0xb8,0x2e,0xe8,0xe9,0xeb,0x9c)): ENTRIES.append(_t)
