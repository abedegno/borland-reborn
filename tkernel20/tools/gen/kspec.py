EXE='/private/tmp/claude-501/-Users-jonw-turbocpp/2beb636e-51d3-4acf-9478-abaf68a73e88/scratchpad/tk/krn.exe'
C="segment para public 'CODE'"
SEGS=[('K000',0x0,0x10,'code',C,0x0),('K001',0x10,0x810,'code',C,0x1),('K081',0x810,0x2260,'code',C,0x81),
 ('K226',0x2260,0x2840,'code',C,0x226),('K284',0x2840,0xBC13,'code',C,0x284),('KBC2',0xBC20,0xBC20,'bss',"segment para public 'BSS'",0xBC2)]
SEGNAME={0x0:'K000',0x1:'K001',0x81:'K081',0x226:'K226',0x284:'K284',0xBC2:'KBC2'}
ENTRIES=[0x2840]
NAMES={0x2840:'start'}
HEAD='\t.286p\n\tlocals'
TAIL='\tend\tstart'
TRACE_ONLY=True
HEAD='\t.286p\n\tlocals\n'+''.join('%s\t%s\n%s\tends\n'%(s[0],s[4],s[0]) for s in SEGS)
