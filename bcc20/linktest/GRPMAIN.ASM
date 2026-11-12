DGROUP	group	DATA0,BSS0,STACK0
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
DATA0	segment byte public 'DATA'
	db	5 dup (0)
DATA0	ends
BSS0	segment byte public 'BSS'
	db	13 dup (?)
BSS0	ends
STACK0	segment byte stack 'STACK'
	db	4500 dup (?)
STACK0	ends
TAIL	segment byte public 'CODE'
	db	4 dup (0)
TAIL	ends
	end
