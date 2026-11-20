exec(open('/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/bx/spec.py').read())
D=dict((s[0],s) for s in SEGS)
order=[s[0] for s in SEGS]
DECL='\n'.join('%s\t%s\n%s\tends'%(n,D[n][4],n) for n in order if not n.startswith('_'))
s=D['S736']; SEGS=[x for x in SEGS if x[0]!='S736']+[('S736a',0x7360,0x7368)+s[3:6]+('S736',),('S736b',0x7368,0x7370,s[3],s[4].replace('para','byte'),s[5],'S736')]
SEGS.sort(key=lambda x:x[1])
MODULES=[('M1.ASM',['S2BF']),('M2.ASM',['S41D']),('M2B.ASM',['S32C','S5AD','S6BE','S736a']),
 ('M3.ASM',['S46C','S47C','S438','S736b']),('M3B.ASM',['S737','S73F','S6F2','_DATA','_BSS','S47E','S557'])]
REVFIX=['M1.OBJ']
HEAD='\t.286p\n\tlocals'
MODHEAD={'M1.ASM':['\tpublic\t_main','\textrn\t__setargv__:far','\textrn\t__setenvp__:far'],'M3B.ASM':['DGROUP\tgroup\t_DATA,_BSS']}
NODD={0x3D5C}
REVCUTS={'M1.OBJ':['3FD']}  # the far pointer at 3FDh starts BCC's second record
