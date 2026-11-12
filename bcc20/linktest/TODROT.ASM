DOSSEG
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
CODE52	segment byte public 'INITCODE'
	db	16 dup (0)
CODE52	ends
	end
