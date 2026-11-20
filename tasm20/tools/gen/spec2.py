exec(open('spec.py').read())
C="segment byte public 'CODE'"
SEGS=[('C0a',0x0,0x82,'code',C,0x0,'CODE0'),
 ('F9Ba',0xF9B0,0xfa44,'code',C,0xF9B,'C0F9B'),
 ('C1455',0x14550,0x1459B,'code',C,0x1455),
 ('C1459',0x1459C,0x15F61,'code',"segment word public 'CODE'",0x1459),
 ('F9Bb',0xfa44,0x1119a,'code',C,0xF9B,'C0F9B'),
 ('C0b',0x82,0x3208,'code',C,0x0,'CODE0'),
 ('F9Bc',0x1119a,0x121fd,'code',C,0xF9B,'C0F9B'),
 ('C0c',0x3208,0x3226,'code',C,0x0,'CODE0'),
 ('F9Bd',0x121fd,0x13ad9,'code',C,0xF9B,'C0F9B'),
 ('C0d',0x3226,0x33d6,'code',C,0x0,'CODE0'),
 ('F9Be',0x13ad9,0x14550,'code',C,0xF9B,'C0F9B'),
 ('C0e',0x33d6,0xF9B0,'code',C,0x0,'CODE0'),
 ('DATA',0x15F61,0x19819,'data',"segment byte public 'DATA'",0x15F6),
 ('BSS',0x19819,0x1B810,'bss',"segment byte public 'BSS'",0x15F6),
 ('STK',0x1B810,0x1BC1A,'bss',"segment para stack 'STACK'",0x1B81)]
HEAD='\t.286\n\tlocals\nCODE0\tsegment byte public \'CODE\'\nCODE0\tends\nDATA\tsegment byte public \'DATA\'\nDATA\tends\nBSS\tsegment byte public \'BSS\'\nBSS\tends\nDGROUP\tgroup\tDATA,BSS'
MODULES=[('M1.ASM',['C0a','F9Ba','C1455','C1459']),('M2.ASM',['F9Bb']),('M3.ASM',['F9Bc','C0b']),('M4.ASM',['C0c','F9Bd']),('M5.ASM',['C0d','F9Be']),('M6.ASM',['C0e']),('M7.ASM',['DATA','BSS','STK'])]
NEAR_EXTRNS=True
import json as _j
_C=_j.load(open(os.path.join(os.path.dirname(EXE),'..','..','..','tasm20','tools','gen','cands.json')))
ENTRIES=ENTRIES+_C
for _a in _C: NAMES.setdefault(_a,'L%05X'%_a)
