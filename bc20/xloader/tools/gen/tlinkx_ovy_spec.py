EXE='/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/yo/tlinkx_mz.exe'
import json as _j
_s=_j.load(open(EXE+'.json'))['segs']
_isz=_j.load(open(EXE+'.json'))['isz']
SEGS=[('Y%05X'%a,a,b,'code' if a<_isz else 'data',"segment para public 'CODE'" if a<_isz else "segment byte public 'OVRDATA'",a>>4) for a,b in _s]
SEGNAME={a>>4:'Y%05X'%a for a,b in _s}
ENTRIES=[0x282]
NAMES={0x282:'start'}
HEAD='\t.286p\n\tlocals'
TAIL='\tend\tstart'
TRACE_ONLY=True
import re as _re
_e={int(k,16):v for k,v in _j.load(open('/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/yo/ovy_entries.json')).items()}
ENTRIES+=sorted(_e)
_seen=set(NAMES.values())
for _a,_n in sorted(_e.items()):
    if not _re.match(r'L[0-9A-F]{5}$',_n) and _n not in _seen and _a not in NAMES: NAMES[_a]=_n; _seen.add(_n)
