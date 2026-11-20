import re,sys
S={}; import os
H=os.path.dirname(os.path.abspath(__file__)); os.chdir(H)
exec(open(os.path.join(H,'spec2.py')).read(),S)
def segname(a):
    for s in S['SEGS']:
        if s[1]<=a<s[2]: return s[6] if len(s)>6 else s[0]
p=sys.argv[1]; L=open(p).read().split('\n'); out=[]
for l in L:
    m=re.search(r'\b(call|jmp)\s+far ptr (L([0-9A-F]{5}))\b',l); mk=re.search(r';@([0-9A-F]{5})',l)
    if m and mk and segname(int(m.group(3),16))==segname(int(mk.group(1),16)):
        out+=['\tnosmart',l,'\tsmart']
    else: out.append(l)
open(p,'w').write('\n'.join(out))
