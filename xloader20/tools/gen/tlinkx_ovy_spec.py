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
