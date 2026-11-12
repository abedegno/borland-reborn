BGROUP	group	B0,B1,B2,B3,B4,B5
FGROUP	group	DATA0,STACK0
CODE0	segment byte public 'CODE'
	db	16 dup (0)
CODE0	ends
_OVERLAY_	segment byte public 'OVRINFO'
_OVERLAY_	ends
_EXEINFO_	segment byte public 'OVRINFO'
	public	__SEGTABLE__
	public	__SEGTABEND__
	public	__EXENAME__
	public	__EXEDATE__
__SEGTABLE__	label	byte
__SEGTABEND__	label	byte
__EXENAME__	label	byte
__EXEDATE__	label	byte
_EXEINFO_	ends
B0	segment byte public 'BSS'
	db	32 dup (?)
B0	ends
B1	segment byte public 'BSS'
	db	16 dup (?)
B1	ends
B2	segment byte public 'BSS'
	db	16 dup (?)
B2	ends
B3	segment byte public 'BSS'
B3	ends
B4	segment byte public 'BSS'
B4	ends
B5	segment byte public 'BSS'
	db	80 dup (?)
B5	ends
DATA0	segment byte public 'DATA'
	db	5 dup (0)
DATA0	ends
STACK0	segment byte stack 'STACK'
	db	100 dup (?)
STACK0	ends
	end
