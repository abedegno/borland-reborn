"""annotate.py: add the text of a DGROUP string as a comment to every instruction whose
constant is that string's offset (TASM loads message offsets as plain numbers)."""
import re,glob,os
R=os.path.abspath(os.path.join(os.path.dirname(__file__),'..'))
d=open(os.path.join(R,'toolchain','BC20','BIN','TASM.EXE'),'rb').read()[0x800:]
DG=0x15F60
strs={}
for m in re.finditer(rb'(?<=\x00)[\x02\x0d -~]{6,}(?=\x00)',d[0x15F61:0x19819]):
    t=m.group().replace(b'\x02\r',b'%s').replace(b'\r',b'')
    if sum(1 for x in t if 97<=x<=122)>=3: strs[m.start()+1]=t.decode('latin1')
n=0
for f in glob.glob(os.path.join(R,'src','M[1-6].ASM')):
    L=open(f,encoding='latin1').read().split('\n')
    for k,l in enumerate(L):
        if '; "' in l: continue
        m=re.match(r'^(.*?\b(?:mov|push)\s+\w+,\s*(0?[0-9A-F]{3,4})h)(\s*)(;@[0-9A-F]{5})\s*$',l) or re.match(r'^(.*?\bpush\s+(0?[0-9A-F]{3,4})h)(\s*)(;@[0-9A-F]{5})\s*$',l)
        if not m: continue
        v=int(m.group(2),16)+0x15F60-0x15F61
        if v in strs:
            L[k]='%s\t; "%s"\t%s'%(m.group(1),strs[v][:70].replace('"',"'"),m.group(4)); n+=1
    open(f,'w',encoding='latin1').write('\n'.join(L))
print('annotated',n)
