"""mktarget.py STEM ADDR: point src/heap/STEM.C at TLINK's copy at image offset ADDR (a target table
made from bcc20's rows for the same source)."""
import sys,re,os
stem,addr=sys.argv[1],int(sys.argv[2],16)
SIZE=int(sys.argv[3],16) if len(sys.argv)>3 else None
R=os.path.abspath(os.path.join(os.path.dirname(__file__),'..'))
p=os.path.join(R,'src','heap',stem+'.C')
s=open(p,'rb').read().decode('latin1')
old=re.search(r'/\* target: (\S+) \*/',open(os.path.join(R,'..','bcc','src','heap',stem+'.C'),'rb').read().decode('latin1')).group(1)
cur=re.search(r'/\* target: (\S+) \*/',s).group(1)
rows=open(os.path.join(R,'..','bcc','targets',old+'.tsv')).read().split('\n')
size=int(re.search(r'size (0x[0-9A-Fa-f]+)',rows[0]).group(1),16)
new='H_'+stem
if SIZE: size=SIZE
hdr='# segment %s base 0x%X size 0x%X org 0x%X'%(new,addr+0x400,size,addr)
rr=[r for r in rows[1:] if r]
if SIZE and len(rr)==1: f=rr[0].split('\t'); f[3]='0x%X'%SIZE; rr=['\t'.join(f)]
open(os.path.join(R,'targets',new+'.tsv'),'w').write('\n'.join([hdr]+rr)+'\n')
s=s.replace('/* target: %s */'%cur,'/* target: %s */'%new)
open(p,'wb').write(s.encode('latin1'))
