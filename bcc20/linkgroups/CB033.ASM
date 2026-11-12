; TLINK generates the overlay segment-information table in this segment.
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
	end
