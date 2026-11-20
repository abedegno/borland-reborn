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
import re as _re
_e={int(k,16):v for k,v in _j.load(open('/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/yo/bx/bccx_entries.json')).items()}
ENTRIES=sorted(_e)
TRACE_ONLY=True
_seen=set()
NAMES={}
for _a,_n in sorted(_e.items()):
    if _n.isidentifier() and _n not in _seen and len(_n)<=32: NAMES[_a]=_n; _seen.add(_n)
TAIL='\tend'
