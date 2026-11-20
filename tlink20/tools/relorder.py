"""relorder.py: the EXE relocations each compiled object would produce, in object order, placed at
its target address; compared with TLINK.EXE's relocation table.  Objects: every target's build."""
import sys,os,re,glob,struct
R=os.path.abspath(os.path.join(os.path.dirname(__file__),'..'))
def relocs_of(obj):
    """(segment index, offset) of each fixup that becomes an EXE relocation, in record order."""
    d=open(obj,'rb').read(); p=0; out=[]; last=None; threads={}
    while p<len(d):
        t=d[p]; L=struct.unpack_from('<H',d,p+1)[0]; b=d[p+3:p+3+L-1]; p+=3+L
        if t in (0xA0,0xA1):
            q=0; si=b[q]; q+=1
            if si&0x80: si=((si&0x7f)<<8)|b[q]; q+=1
            off=struct.unpack_from('<H' if t==0xA0 else '<I',b,q)[0]; last=(si,off)
        elif t in (0x9C,0x9D):
            q=0
            while q<len(b):
                c=b[q]
                if not c&0x80:          # thread
                    q+=1; method=(c>>2)&7
                    if method<3: q+= 2 if b[q]&0x80 else 1
                    continue
                loc=((c<<8)|b[q+1]); q+=2; locat=(loc>>10)&0xF; dro=loc&0x3FF
                fd=b[q]; q+=1
                F=(fd>>7)&1; frame=(fd>>4)&7; T=(fd>>3)&1; P=(fd>>2)&1; targ=fd&3
                if not F and frame<3: q+= 2 if b[q]&0x80 else 1
                if not T: q+= 2 if b[q]&0x80 else 1
                if not P: q+= 2 if t==0x9C else 4
                if locat in (2,3,11):   # segment base, far pointer
                    out.append((last[0], last[1]+dro+(2 if locat in (3,11) else 0)))
        elif t==0x8A: break
    return out
def segs_of(obj):
    sys.path.insert(0,os.path.join(R,'..','exhume','tools')); import omf
    return omf.module_masked(open(obj,'rb').read())[1]
d=open(os.path.join(R,'toolchain','BC20','BIN','TLINK.EXE'),'rb').read()
n=struct.unpack_from('<H',d,6)[0]; ro=struct.unpack_from('<H',d,0x18)[0]
exe=[s*16+o for o,s in (struct.unpack_from('<HH',d,ro+4*k) for k in range(n))]
mods=[]
for t in glob.glob(os.path.join(R,'targets','*.tsv')):
    h=open(t).readline(); org=int(re.search(r'org (0x[0-9A-F]+)',h).group(1),16)
    name=os.path.basename(t)[:-4]; stem=name.split('_',1)[1]
    obj=os.path.join(R,'build',stem,stem+'.OBJ')
    if os.path.exists(obj): mods.append((org,stem,obj))
mods.sort(); sim=[]
for org,stem,obj in mods:
    segs=segs_of(obj); ci=[i for i,s in enumerate(segs) if s[1].endswith('CODE') and s[2]][0]
    for si,off in relocs_of(obj):
        if si==ci+1: sim.append((org+off,stem))
lo=min(m[0] for m in mods)
ex=[a for a in exe if a>=lo]
print('sim',len(sim),'exe',len(ex))
for k in range(max(len(sim),len(ex))):
    a=sim[k] if k<len(sim) else None; b=ex[k] if k<len(ex) else None
    mark='' if a and a[0]==b else '  <<'
    print('%05X %-9s | %05X%s'%(a[0] if a else 0,a[1] if a else '',b or 0,mark))
