"""symcheck.py: names the built objects refer to that none of them defines."""
import struct,glob,os,sys
R=os.path.abspath(os.path.join(os.path.dirname(__file__),'..'))
def idx(b,q): return q+2 if b[q]&0x80 else q+1
def names(d):
    p=0; ext=[]; pub=[]
    while p<len(d):
        t=d[p]; L=struct.unpack_from('<H',d,p+1)[0]; b=d[p+3:p+3+L-1]; p+=3+L
        if t in (0x8C,0xB4):
            q=0
            while q<len(b):
                n=b[q]; ext.append(b[q+1:q+1+n].decode('latin1')); q=idx(b,q+1+n)
        elif t in (0x90,0x91,0xB6):
            q=0; gi=b[q]; q=idx(b,q); si=b[q]; q=idx(b,q)
            if si==0: q+=2
            while q<len(b):
                n=b[q]; pub.append(b[q+1:q+1+n].decode('latin1')); q=idx(b,q+1+n+2)
    return ext,pub
if __name__=='__main__':
    E={};P=set()
    objs=sys.argv[1:] or [os.path.join(R,'build',os.path.basename(t)[:-4].split('_',1)[1],os.path.basename(t)[:-4].split('_',1)[1]+'.OBJ') for t in glob.glob(os.path.join(R,'targets','*.tsv'))]
    for o in objs:
        if not os.path.exists(o): print('missing',o); continue
        e,p=names(open(o,'rb').read())
        for x in e: E.setdefault(x,[]).append(os.path.basename(o)[:-4])
        P|=set(p)
    for k in sorted(set(E)-P): print(k, E[k][:4])
