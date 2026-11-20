"""segdiff.py SRC: build SRC with match.py, then diff its whole code segment against the target."""
import sys,os,re,subprocess,difflib
R=os.path.abspath(os.path.join(os.path.dirname(__file__),'..'))
sys.path.insert(0,os.path.join(R,'..','exhume','tools')); import omf
src=sys.argv[1]; stem=os.path.basename(src).rsplit('.',1)[0]
out=subprocess.run([sys.executable,os.path.join(R,'..','exhume','tools','match.py'),src],cwd=R,capture_output=True,text=True).stdout
print(out.strip().split('\n')[-1])
seg=re.search(r'/\* target: (\S+) \*/',open(os.path.join(R,src),encoding='latin1').read()).group(1)
hdr=open(os.path.join(R,'targets',seg+'.tsv')).readline()
base=int(re.search(r'base (0x[0-9A-F]+)',hdr).group(1),16); size=int(re.search(r'size (0x[0-9A-F]+)',hdr).group(1),16)
exe=open(os.path.join(R,'toolchain','BC20','BIN','TLINK.EXE'),'rb').read()[base:base+size]
n,segs,data,mask,_=omf.module_masked(open(os.path.join(R,'build',stem,stem+'.OBJ'),'rb').read())
ci=[i for i,s in enumerate(segs) if s[1].endswith('CODE') and s[2]][0]; b=bytearray(data[ci+1]); m=mask[ci+1]
for k in range(min(len(b),len(exe))):
    if m[k]: b[k]=exe[k]
if bytes(b[:len(exe)])==exe and len(b)==len(exe): sys.exit(0)
import capstone
md=capstone.Cs(capstone.CS_ARCH_X86,capstone.CS_MODE_16)
d=lambda x:['%04X %s %s'%(i.address,i.mnemonic,i.op_str) for i in md.disasm(bytes(x),0)]
A=[l[5:] for l in d(exe)]; Bl=[l[5:] for l in d(b)]
print('len obj %X target %X'%(len(b),len(exe)))
for l in difflib.unified_diff(A,Bl,'exe','obj',lineterm='',n=2): print(l)
