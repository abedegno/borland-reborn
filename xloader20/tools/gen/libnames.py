import sys,struct,subprocess,re,json; sys.path.insert(0,'/Users/jonw/Exhume/tools')
import omf
T='/Users/jonw/borland-reborn/toolchains/BC20'
exe=sys.argv[1]
scan=subprocess.run([sys.executable,'../libscan.py',exe,T+'/LIB/C0L.OBJ',T+'/LIB/CL.LIB'],capture_output=True,text=True).stdout
base={}
for l in scan.split('\n'):
    f=l.split()
    if len(f)>=4 and f[3]=='_TEXT': base.setdefault(f[2],int(f[0],16))
def mods(path):
    L=open(path,'rb').read()
    if not path.upper().endswith('.LIB'): yield L; return
    page=struct.unpack_from('<H',L,1)[0]+3; p=page
    while p<len(L) and L[p]==0x80:
        r=omf.module_masked(L,p); yield L[p:r[4]]; p=((r[4]+page-1)//page)*page
ext={}
for path in (T+'/LIB/C0L.OBJ',T+'/LIB/CL.LIB'):
    for m in mods(path):
        name,segs,data,mask,_=omf.module_masked(m)
        if name not in base: continue
        for pn,(si,off) in omf.publics(m).items():
            if si and segs[si-1][0]=='_TEXT': ext[base[name]+off]=pn
json.dump({hex(k):v for k,v in sorted(ext.items())},open('ext.json','w'),indent=0)
print(len(ext), [ext[k] for k in sorted(ext)][:20])
