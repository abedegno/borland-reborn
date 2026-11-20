EXE='/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/tsx/tasmx_mz.exe'
C="segment para public 'CODE'"
SEGS=[('SEG1',0x0,0xFF77,'code',C,0x0),('SEG2',0xFF80,0xFF80+0x4F92,'code',C,0xFF8),('SEG3',0x14F20,0x14F5D,'code',C,0x14F2),
 ('SEG4',0x14F60,0x14F60+0x17A2,'code',C,0x14F6),('SEG5',0x16710,0x16710+0x36A0,'data',"segment para public 'DATA'",0x1671),
 ('SEG5B',0x16710+0x36A0,0x16710+0x5CE0,'bss',"segment para public 'DATA'",0x1671,'SEG5')]
SEGNAME={0:'SEG1',0xFF8:'SEG2',0x14F2:'SEG3',0x14F6:'SEG4',0x1671:'SEG5'}
ENTRIES=[0x14F60+0xADD]
NAMES={0x14F60+0xADD:'start'}
HEAD='\t.286p\n\tlocals'
TAIL='\tend\tstart'
TRACE_ONLY=True
import struct as _st
_d=open(EXE,'rb').read(); _h=_st.unpack_from('<H',_d,8)[0]*16; _img=_d[_h:]
_n=_st.unpack_from('<H',_d,6)[0]
for _k in range(_n):
    _o,_s=_st.unpack_from('<HH',_d,0x1C+4*_k); _r=_s*16+_o
    if _r>=3 and _img[_r-3] in (0x9a,0xea):
        _oo,_sv=_st.unpack_from('<HH',_img,_r-2); ENTRIES.append(_sv*16+_oo)
