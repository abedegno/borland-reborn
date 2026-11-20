EXE='/Users/jonw/borland-reborn/toolchains/BC20/BIN/TLINKX.EXE'
import json as _j, struct as _st
B=[(0x2A9,0x2A96),(0x2F4,0x2F46),(0x3E6,0x3E60),(0x400,0x4008),(0x434,0x4340),(0x444,0x4440),(0x446,0x4460),(0x51F,0x51F9),
   (0x575,0x5750),(0x686,0x6866),(0x6BA,0x6BA0),(0x6FE,0x6FE0),(0x6FF,0x6FF0),(0x707,0x7070)]
DG=0x70C0; UEND=DG+0x70C0-0x70C0+0x3C8
SEGS=[]
for i,(f,lo) in enumerate(B):
    hi=B[i+1][1] if i+1<len(B) else DG
    al='para' if lo%16==0 else 'byte'
    SEGS.append(('S%03X'%f,lo,hi,'code',"segment %s public 'CODE'"%al,f))
SEGS.append(('_DATA',DG+0x91,DG+0x3C8,'data',"segment byte public 'DATA'",0x70C))
SEGS.append(('_BSS',DG+0x692,DG+0x960,'bss',"segment word public 'BSS'",0x70C))
SEGNAME={f:'S%03X'%f for f,_ in B}; SEGNAME[0x70C]='DGROUP'
EXTERN={int(k,16):v for k,v in _j.load(open('/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/tx/ext.json')).items()}
ENTRIES=[0x2A96]
NAMES={0x2A96:'_main'}
HEAD='\t.286p\n\tlocals\nDGROUP\tgroup\t_DATA,_BSS\n\tpublic\t_main\n\textrn\t__setargv__:far\n\textrn\t__setenvp__:far'
TAIL='\tend'
TRACE_ONLY=True
_d=open(EXE,'rb').read(); _img=_d[0x400:]
_n=_st.unpack_from('<H',_d,6)[0]; _ro=_st.unpack_from('<H',_d,0x18)[0]
_rel=set(s*16+o for o,s in (_st.unpack_from('<HH',_d,_ro+4*k) for k in range(_n)))
for _r in sorted(_rel):
    if _r>=0x2A96 and _img[_r-3] in (0x9a,0xea):
        _o,_sv=_st.unpack_from('<HH',_img,_r-2)
        if _sv: ENTRIES.append(_sv*16+_o)
