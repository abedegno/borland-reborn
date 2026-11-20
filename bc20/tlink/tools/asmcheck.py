"""asmcheck.py FILE.ASM BASE: assemble one module of TLINK.EXE with a listing and compare each
listing line carrying a ;@ADDR marker with the image bytes at ADDR (fixups and relocated words
masked).  Prints the addresses whose bytes differ (or whose place has moved) and exits 1 if any.
BASE is the image offset of the module's first segment (for CODE0: 0)."""
import os,re,subprocess,sys,struct
R=os.path.abspath(os.path.join(os.path.dirname(__file__),'..'))
EX=os.path.join(R,'..', '..','exhume')
def listing(path):
    ents=[]
    t=open(path,'rb').read().decode('latin1').replace('\r','')
    for l in t.split('\n'):
        l=l.expandtabs(8)
        if not re.match(r'^\s*\d+ ',l): continue
        adr=l[8:12]; field=l[14:37]
        bs=bytearray(); wild=[]
        for tok in field.split():
            w=bool(re.search(r'[rse]$',tok.rstrip('+')))
            tok=tok.rstrip('+rsne')
            if re.fullmatch(r'[0-9A-F]{2}',tok): bs.append(int(tok,16)); wild.append(w)
            elif re.fullmatch(r'[0-9A-F]{4}',tok): v=int(tok,16); bs+=bytes([v&255,v>>8]); wild+=[w,w]
            elif re.fullmatch(r'[0-9A-F]{8}',tok): v=int(tok,16); bs+=v.to_bytes(4,'little'); wild+=[w]*4
            else: break
        mk=re.search(r';@([0-9A-F]{5})',l)
        if re.fullmatch(r'[0-9A-F]{4}',adr) and mk: ents.append([int(mk.group(1),16),bytes(bs),l,int(adr,16),wild])
        elif ents and bs and (adr.strip()=='' or re.fullmatch(r'[0-9A-F]{4}',adr)): ents[-1][1]+=bytes(bs); ents[-1][4]+=wild
    return ents
def check(src,base,out):
    T=os.path.join(R,'toolchain','BC20','BIN')
    name=os.path.basename(src).upper()
    subprocess.run(['rm','-rf',out])
    subprocess.run(['node',os.path.join(EX,'tools','dosrun.mjs'),out,'-t','300','-f',os.path.join(T,'TASM.EXE'),'-f',src,
                    '-c','TASM /l /ml '+name,'-o',name[:-4]+'.LST','-O',name[:-4]+'.OBJ'],capture_output=True)
    log=open(os.path.join(out,'RUN.LOG'),encoding='latin1').read()
    errs=re.findall(r'\*\*(?:Error|Fatal)\*\* .*',log)
    if errs: return None,errs
    d=open(os.path.join(R,'toolchain','BC20','BIN','TLINK.EXE'),'rb').read()
    img=d[struct.unpack_from('<H',d,8)[0]*16:]
    bad=[]; check.shift=None
    for a,bs,l,la,wild in listing(os.path.join(out,name[:-4]+'.LST')):
        if la!=a-base:
            if check.shift is None: check.shift=a
            bad.append(a); continue
        o=img[a:a+len(bs)]
        if any(o[j]!=bs[j] and not wild[j] for j in range(len(bs))): bad.append(a)
    return bad,[]
if __name__=='__main__':
    bad,errs=check(os.path.abspath(sys.argv[1]),int(sys.argv[2],16),sys.argv[3] if len(sys.argv)>3 else '/tmp/asmcheck')
    if errs: print('\n'.join(errs[:20])); sys.exit(2)
    print(len(bad),'differ', ' '.join('%05X'%a for a in bad[:30])); sys.exit(1 if bad else 0)
