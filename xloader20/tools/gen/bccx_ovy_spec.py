EXE='/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/yo/bx/bccx_mz.exe'
import json as _j
_s=_j.load(open(EXE+'.json'))['segs']
_isz=_j.load(open(EXE+'.json'))['isz']
SEGS=[('Y%05X'%a,a,b,'code' if a<_isz else 'data',"segment para public 'CODE'" if a<_isz else "segment byte public 'OVRDATA'",a>>4) for a,b in _s]
SEGNAME={a>>4:'Y%05X'%a for a,b in _s}
ENTRIES=[]
NAMES={}
HEAD='\t.286p\n\tlocals'
TAIL='\tend'
TRACE_ONLY=True
_names=[s[0] for s in SEGS]
MODULES=[('M%02d.ASM'%(k//12),_names[k:k+12]) for k in range(0,len(_names),12)]
MODULES=[(f,ss) for f,ss in MODULES]
_m={}
for k,(f,ss) in enumerate(MODULES): _m[f]=ss
MODULES=[('M%02d.ASM'%k,ss) for k,(f,ss) in enumerate(MODULES)]
