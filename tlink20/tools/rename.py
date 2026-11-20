"""rename.py TABLE.tsv: rename the core's address labels and put a comment above each routine.
TABLE rows: address (hex) <TAB> name <TAB> comment (optional; '|' starts a new comment line).
Renames the definition `Lxxxxx` and every use of it in src/core/*.ASM, and inserts the comment
lines before the definition.  Data labels work the same way.  Refuses a name already in use."""
import re,sys,os,glob
R=os.path.abspath(os.path.join(os.path.dirname(__file__),'..'))
rows=[l.rstrip('\n').split('\t') for l in open(sys.argv[1]) if l.strip() and not l.startswith('#')]
files=glob.glob(os.path.join(R,'src','core','*.ASM'))
text={f:open(f,encoding='latin1').read() for f in files}
allt='\n'.join(text.values())
for r in rows:
    a=int(r[0],16); old='L%05X'%a; new=r[1]; com=r[2] if len(r)>2 else ''
    if not re.search(r'\b%s\b'%old,allt): print('no label',old); continue
    if re.search(r'\b%s\b'%re.escape(new),allt): print('name in use',new); continue
    for f in files:
        t=text[f]
        if com:
            lines=['; '+c.strip() if c.strip() else ';' for c in com.split('|')]
            t=re.sub(r'(?m)^(%s(?::|\s))'%old,lambda m:'\n'.join(lines)+'\n'+m.group(1),t,count=1)
        t=re.sub(r'\b%s\b'%old,new,t)
        text[f]=t
    allt='\n'.join(text.values())
for f in files: open(f,'w',encoding='latin1').write(text[f])
