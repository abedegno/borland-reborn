exec(open('/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/tk/spec.py').read())
SEGS=[(x[0],x[1],x[2],x[3],x[4].replace('para','byte'),x[5]) if x[0] in ('S000','S9FA') else x for x in SEGS]
D=dict((s[0],s) for s in SEGS)
def P(name,base,lo,hi): s=D[base]; return (name,lo,hi,s[3],s[4],s[5],base)
A,B,C1,C2=0xA7E4,0xB74F,0x48E0,0x4F13
SEGS=[P('FA0','S9FA',0x9FA0,0x9FA9),P('FA1','S9FA',0x9FA9,A),
 P('S0a','S000',0,C1),P('FA2','S9FA',A,B),
 P('S0b','S000',C1,C2),P('S50A','S50A',0x50A0,0x5890),P('FA3','S9FA',B,0xBB90),
 P('S0c','S000',C2,0x50A0),P('S9CF','S9CF',0x9CF0,0x9D20)]+[D[n] for n in ('S589','S59F','S5AD','S5ED','S5FD','S8EF','S8F6','S908','S9D2','S9F3','SBB9')]
DECL=''.join("%s\t%s\n%s\tends\n"%(n,D[n][4],n) for n in ('S000','S50A','S589','S59F','S5AD','S5ED','S5FD','S8EF','S8F6','S908','S9CF','S9D2','S9F3','S9FA','SBB9','SD33'))
HEAD='\t.286p\n\tlocals\n'+DECL
MODULES=[('M0.ASM',['FA0']),('M1.ASM',['FA1']),('M2.ASM',['S0a','FA2']),('M3.ASM',['S0b','S50A','FA3']),('M4.ASM',['S0c','S9CF','S589','S59F','S5AD','S5ED','S5FD','S8EF','S8F6','S908','S9D2','S9F3','SBB9'])]
NEAR_EXTRNS=True
SELFSEG=['S0a','FA0','S50A','S9CF']
NODD=NODD|set([3570, 3574, 3578, 3582, 3586, 3590, 3594, 3598, 3602, 3606, 3610, 3614, 3618, 3622, 3626, 3630, 3634, 3638, 3642, 3646, 3650, 3654, 3658, 3662, 3666, 3670, 3674, 3678, 3682, 3686, 3690, 3694, 3698, 3702, 3706, 3710, 3714, 3718, 3816, 3944, 4056])
NODD=NODD|{0x4B8A}
