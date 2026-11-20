exec(open('/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/tx/spec.py').read())
D=dict((s[0],s) for s in SEGS)
order=[s[0] for s in SEGS]
DECL='\n'.join('%s\t%s\n%s\tends'%(n,D[n][4],n) for n in order if not n.startswith('_'))
s=D['S6FE']; SEGS=[x for x in SEGS if x[0]!='S6FE']+[('S6FEa',0x6FE0,0x6FE8)+s[3:6]+('S6FE',),('S6FEb',0x6FE8,0x6FF0,s[3],s[4].replace('para','byte'),s[5],'S6FE')]
SEGS.sort(key=lambda x:x[1])
MODULES=[('M1.ASM',['S2A9']),('M2.ASM',['S3E6']),('M2B.ASM',['S2F4','S575','S686','S6FEa']),
 ('M3.ASM',['S434','S444','S400','S6FEb']),('M3B.ASM',['S6FF','S707','S6BA','_DATA','_BSS','S446','S51F'])]
REVFIX=['M1.OBJ']
HEAD='\t.286p\n\tlocals'
MODHEAD={'M1.ASM':['\tpublic\t_main','\textrn\t__setargv__:far','\textrn\t__setenvp__:far'],'M3B.ASM':['DGROUP\tgroup\t_DATA,_BSS']}
