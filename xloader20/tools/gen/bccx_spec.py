EXE='/Users/jonw/borland-reborn/toolchains/BC20/BIN/BCCX.EXE'
import json as _j, struct as _st
B=[(0x2BF,0x2BFD),(0x32C,0x32C1),(0x41D,0x41DC),(0x438,0x438C),(0x46C,0x46C0),(0x47C,0x47C0),(0x47E,0x47E0),(0x557,0x5579),
   (0x5AD,0x5AD0),(0x6BE,0x6BE6),(0x6F2,0x6F20),(0x736,0x7360),(0x737,0x7370),(0x73F,0x73F0)]
DG=0x7440; UEND=DG+0x70C0-0x70C0+0x3C8
SEGS=[]
for i,(f,lo) in enumerate(B):
    hi=B[i+1][1] if i+1<len(B) else DG
    al='para' if lo%16==0 else 'byte'
    SEGS.append(('S%03X'%f,lo,hi,'code',"segment %s public 'CODE'"%al,f))
SEGS.append(('_DATA',DG+0x91,DG+0x448,'data',"segment byte public 'DATA'",0x744))
SEGS.append(('_BSS',DG+0x692,DG+0x960,'bss',"segment word public 'BSS'",0x744))
SEGNAME={f:'S%03X'%f for f,_ in B}; SEGNAME[0x744]='DGROUP'
EXTERN={int(k,16):v for k,v in _j.load(open('/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/bx/ext.json')).items()}
ENTRIES=[0x2BFD]
NAMES={0x2BFD:'_main'}
HEAD='\t.286p\n\tlocals\nDGROUP\tgroup\t_DATA,_BSS\n\tpublic\t_main\n\textrn\t__setargv__:far\n\textrn\t__setenvp__:far'
TAIL='\tend'
TRACE_ONLY=True
_d=open(EXE,'rb').read(); _img=_d[0x400:]
_n=_st.unpack_from('<H',_d,6)[0]; _ro=_st.unpack_from('<H',_d,0x18)[0]
_rel=set(s*16+o for o,s in (_st.unpack_from('<HH',_d,_ro+4*k) for k in range(_n)))
for _r in sorted(_rel):
    if _r>=0x2BFD and _img[_r-3] in (0x9a,0xea):
        _o,_sv=_st.unpack_from('<HH',_img,_r-2)
        if _sv: ENTRIES.append(_sv*16+_o)
