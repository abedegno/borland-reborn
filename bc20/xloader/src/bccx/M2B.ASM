	.286p
	locals
	public	S32C_START
	public	L05AD7
	public	L063F9
	public	L06BC9
	public	S6BE_START
	public	L06C45
	public	S736a_START
	extrn	L04349:far
	extrn	L052FB:far
	extrn	L0531E:far
	extrn	S6F2_START:byte

S32C	segment byte public 'CODE'
	assume	cs:S32C
S32C_START	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@032C1
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 4Ah, 6
	dw	S32C
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0
	dw	S32C
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2Bh, 0, 8Ah, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	4Dh, 4, 54h, 4, 0A5h, 4, 30h, 5, 1Bh, 5, 9Dh, 5, 0A5h, 5, 0ADh, 5
	db	1, 0, 10h, 0, 2, 0, 0Fh, 0, 4, 0, 0Eh, 0, 8, 0, 0Dh, 0
	db	10h, 0, 0Ch, 0, 20h, 0, 0Bh, 0, 40h, 0, 0Ah, 0, 80h, 0, 9, 0
	db	0, 1, 8, 0, 0, 2, 7, 0, 0, 4, 6, 0, 0, 8, 5, 0
	db	0, 10h, 4, 0, 0, 20h, 3, 0, 0, 40h, 2, 0, 0, 80h, 1, 0
	db	8Fh, 8, 0CEh, 8, 0C1h, 8, 0D3h, 8, 0D3h, 8, 3Eh, 8, 58h, 8, 39h, 8
	db	6, 8, 0ABh, 7, 0FCh, 0, 88h, 0, 0F4h, 0, 0FDh, 0, 8Ch, 0, 0F4h, 0
	db	0FEh, 0, 86h, 0, 0F4h, 0, 0FEh, 0, 0C4h, 0, 0F4h, 0, 0FEh, 0, 84h, 0
	db	0F4h, 0, 0FCh, 0, 0D0h, 0, 0F4h, 0, 0C4h, 0, 0, 0, 0F4h, 0, 0FFh, 0
	db	62h, 0, 0F4h, 0, 0F8h, 0, 0D8h, 0, 0F4h, 0, 0FFh, 0, 8Dh, 0, 0F4h, 0
	db	0FFh, 38h, 0FFh, 30h, 0F4h, 0, 0FFh, 38h, 8Fh, 0, 0F4h, 0, 0FEh, 30h, 0FEh, 0
	db	0F4h, 0, 0FEh, 30h, 0F6h, 20h, 0F4h, 0, 0FEh, 30h, 0F6h, 30h, 0F4h, 5, 0FEh, 30h
	db	0F6h, 10h, 0F4h, 0, 0FFh, 30h, 0FFh, 10h, 0F4h, 84h, 0FFh, 30h, 0FFh, 20h, 0F4h, 82h
	db	0FCh, 0, 80h, 0, 0E8h, 0, 0C6h, 0, 4, 0, 0F0h, 0, 0FEh, 0, 0A8h, 0
	db	0F0h, 0, 0F8h, 0, 90h, 0, 1, 0, 0E7h, 0, 27h, 0, 1, 0, 0FFh, 0
	db	0D7h, 0, 1, 0, 0FFh, 0, 0C8h, 0, 4, 0, 0FFh, 0, 0C9h, 0, 1, 0
	db	0FFh, 0FCh, 0CDh, 34h, 0E4h, 5, 0FFh, 0FCh, 0CDh, 38h, 0E4h, 5, 0FFh, 0FFh, 0CDh, 3Ch
	db	0DCh, 5, 0FFh, 0FFh, 0CDh, 3Dh, 2, 5, 0FFh, 0, 0CDh, 0, 2, 5, 0FFh, 0
	db	0CCh, 0, 1, 0, 0FFh, 0, 0CEh, 0, 1, 0, 0FFh, 0, 9Bh, 0, 1, 0
	db	0FFh, 0, 0EBh, 0, 0FEh, 2, 0F0h, 0, 70h, 0, 0FEh, 3, 0FCh, 0, 0E0h, 0
	db	0FEh, 3, 0FFh, 0, 0E9h, 0, 0FCh, 2, 0FFh, 0, 0E8h, 0, 0FCh, 4, 0FFh, 0
	db	0EAh, 0, 0FAh, 2, 0FFh, 0, 9Ah, 0, 0FAh, 4, 0E7h, 0, 26h, 0, 0, 0
	db	0FEh, 0, 0F2h, 0, 0, 0, 0F7h, 0, 0C3h, 0, 1, 1, 0F7h, 0, 0C2h, 0
	db	3, 1, 0FFh, 0, 0CFh, 0, 1, 1, 0FEh, 0FFh, 0D4h, 0Ah, 2, 0, 0FEh, 0
	db	6Ch, 0, 0E2h, 0, 0FEh, 0, 6Eh, 0, 0E0h, 0, 0FEh, 0, 0A6h, 0, 0DEh, 0
	db	0FEh, 0, 0A4h, 0, 0DEh, 0, 0FEh, 0, 0ACh, 0, 0E0h, 0, 0FEh, 0, 0AEh, 0
	db	0E2h, 0, 0FEh, 0, 0AAh, 0, 0E2h, 0, 0FFh, 0FFh, 0Fh, 6, 2, 0, 0FFh, 0C6h
	db	0Fh, 80h, 1, 0, 0FEh, 0, 60h, 0, 1, 0, 0FEh, 0, 0FCh, 0, 1, 0
	db	0FEh, 0, 0F4h, 0, 1, 0, 0FEh, 0, 98h, 0, 1, 0, 0FCh, 0, 0ECh, 0
	db	1, 0, 0FCh, 0, 0E4h, 0, 2, 0, 0FCh, 0, 0F8h, 0, 1, 0, 0FCh, 0
	db	9Ch, 0, 1, 0, 0F0h, 0, 50h, 0, 1, 0, 0F0h, 0, 40h, 0, 1, 0
	db	0FCh, 0, 0A0h, 0, 0DAh, 0, 0E6h, 0, 6, 0, 1, 0, 0FEh, 0, 0C0h, 0
	db	0F2h, 0, 0FEh, 38h, 0C6h, 0, 0EAh, 0, 0FEh, 38h, 0F6h, 0, 0EAh, 0, 0FDh, 0
	db	69h, 0, 0E6h, 0, 0FFh, 0FFh, 0Fh, 0AFh, 0E4h, 0, 0FDh, 0, 68h, 0, 0EEh, 0
	db	0F0h, 0, 0B0h, 0, 0ECh, 0, 0FFh, 0, 0F0h, 0, 0, 0, 0F8h, 0, 0D8h, 0
	db	0F4h, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0Bh, 0, 5Ch, 0, 0AAh, 0, 0B8h, 0, 0C1h, 0, 0C7h, 0, 0D4h, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
S32C	ends

S5AD	segment para public 'CODE'
	assume	cs:S5AD
	db	0D1h, 0E3h, 0FFh, 97h, 0DAh, 0Ah, 0CBh	;@05AD0
L05AD7:	mov	ax, S32C	;@05AD7
	push	ax	;@05ADA
	mov	ax, 64Ah	;@05ADB
	push	ax	;@05ADE
	mov	ax, 1Ch	;@05ADF
	push	ax	;@05AE2
	xor	ax, ax	;@05AE3
	push	ax	;@05AE5
	push	word ptr ds:[0F0Ch]	;@05AE6
	push	word ptr ds:[0F0Eh]	;@05AEA
	push	word ptr ds:[6]	;@05AEE
	call	far ptr L0531E	;@05AF2
	add	sp, 0Eh	;@05AF7
	retf	;@05AFA
	db	0BEh, 0Eh, 0, 1Eh, 7, 0BFh, 0, 4, 0B9h, 19h, 0, 0F3h, 0A5h, 0BEh, 0Eh, 0	;@05AFB
	db	0B8h
	dw	seg S6F2_START
	db	50h, 0B8h, 0, 0, 50h, 0B8h, 6, 0, 0F7h, 64h, 8, 50h, 33h, 0C0h, 50h, 0FFh
	db	74h, 1Ch, 0FFh, 74h, 2Ch, 0FFh, 36h, 6, 0, 9Ah
	dd	L052FB
	db	83h, 0C4h, 0Eh, 0BEh, 0Eh, 0, 0FFh, 74h, 8, 0B8h
	dw	seg S6F2_START
	db	50h, 0B8h, 0, 0, 50h, 0FFh, 34h, 0Eh, 0E8h, 2Ah, 0, 90h, 0A3h, 0Eh, 0, 0C7h
	db	6, 12h, 0, 0, 0, 89h, 0Eh, 16h, 0, 89h, 16h, 1Ah, 0, 0Eh, 0E8h, 7Eh
	db	0FFh, 0C3h, 0A1h, 0Eh, 0, 0A3h, 0E0h, 0Ah, 0A1h, 1Ah, 0, 0A3h, 0E2h, 0Ah, 0A1h, 16h
	db	0, 0A2h, 0DFh, 0Ah, 0C3h, 55h, 8Bh, 0ECh, 56h, 57h, 0FCh, 0A1h, 9Ch, 0Ah, 8Eh, 0D8h
	db	8Eh, 0C0h, 8Ch, 16h, 0C6h, 0Ah, 89h, 26h, 0C4h, 0Ah, 89h, 2Eh, 0C2h, 0Ah, 0BBh
	dw	S32C
	db	8Eh, 0C3h, 33h, 0C0h, 40h, 26h, 2Ah, 6, 0DEh, 0Ah, 0A3h, 6Ah, 6, 8Bh, 0D0h, 0Bh
	db	0C0h, 74h, 1Dh, 0A1h, 0C8h, 0Ah, 3Dh, 0FFh, 0FFh, 75h, 3, 0A1h, 5Eh, 6, 50h, 0FFh
	db	36h, 5Ch, 6, 1Eh, 0B8h, 0BCh, 0Ah, 50h, 1Eh, 0B8h, 0C0h, 0Ah, 50h, 0E8h, 7Ch, 0Fh
	db	0A3h, 0A4h, 0Ah, 89h, 16h, 0A6h, 0Ah, 0Bh, 0C2h, 75h, 15h, 0E8h, 8Eh, 8, 0C7h, 46h
	db	6, 2, 0, 83h, 3Eh, 6Ah, 6, 0, 74h, 3, 0E8h, 0A1h, 0Fh, 0EBh, 65h, 90h
	db	0E8h, 56h, 8, 0E8h, 76h, 8, 8Ch, 0D8h, 8Eh, 0C0h, 0BFh, 4Ah, 4, 0B9h, 0, 1
	db	8Ch, 0D8h, 0BBh, 4Ah, 5, 0BAh, 0, 1, 0E8h, 8, 2, 83h, 7Eh, 6, 2, 74h
	db	0D9h, 0A1h, 0A8h, 0Ah, 3, 6, 0ACh, 0Ah, 0A3h, 0AEh, 0Ah, 0C4h, 1Eh, 0A8h, 0Ah, 8Bh
	db	16h, 0C8h, 0Ah, 8Bh, 0Eh, 0ACh, 0Ah, 8Bh, 36h, 5Ch, 6, 8Bh, 46h, 6, 0E8h, 19h
	db	2, 73h, 13h, 0E8h, 0D8h, 8, 8Bh, 26h, 0C4h, 0Ah, 8Bh, 2Eh, 0C2h, 0Ah, 33h, 0C0h
	db	0BAh, 0FFh, 0FFh, 0E9h, 0ACh, 1, 8Bh, 3Eh, 0AEh, 0Ah, 8Eh, 6, 0C8h, 0Ah, 0B0h, 6
	db	90h, 0E8h, 8Ah, 4, 83h, 3Eh, 0B6h, 0Ah, 0, 74h, 10h, 0C4h, 3Eh, 0A8h, 0Ah, 26h
	db	80h, 3Dh, 0CCh, 74h, 6, 0E8h, 60h, 0Ah, 0E8h, 91h, 1, 0C7h, 6, 9Eh, 0Ah, 0
	db	0, 0C6h, 6, 0A3h, 0Ah, 0, 0C6h, 6, 0A2h, 0Ah, 0, 0A1h, 5Ch, 6, 0A3h, 0D2h
	db	0Ah, 0A1h, 5Eh, 6, 0A3h, 0D4h, 0Ah, 0C7h, 6, 0D6h, 0Ah, 0, 0, 0E8h, 0C5h, 0Bh
	db	0Eh, 0E8h, 0B2h, 0Ch, 90h, 0E8h, 0EBh, 0Bh, 0A1h, 5Ch, 6, 8Bh, 16h, 5Eh, 6, 8Bh
	db	4Eh, 0Ch, 0E3h, 2Ch, 0C4h, 7Eh, 8, 26h, 80h, 7Dh, 5, 0, 74h, 1Dh, 26h, 3Bh
	db	5, 75h, 18h, 6, 26h, 8Eh, 45h, 2, 8Ch, 6, 9Ah, 0Ah, 0E8h, 0FDh, 3, 8Ch
	db	0C3h, 7, 72h, 7, 3Bh, 0D3h, 75h, 3, 0E9h, 87h, 0, 83h, 0C7h, 6, 0E2h, 0D7h
	db	0E8h, 4Eh, 5, 73h, 78h, 0B9h, 1, 0, 0A1h, 5Ch, 6, 3Bh, 6, 0D2h, 0Ah, 75h
	db	1Ah, 0A1h, 5Eh, 6, 3Bh, 6, 0D4h, 0Ah, 75h, 11h, 0C7h, 6, 0D2h, 0Ah, 0FFh, 0FFh
	db	0FFh, 6, 5Ch, 6, 49h, 83h, 7Eh, 6, 2, 74h, 4Fh, 0C7h, 6, 0D2h, 0Ah, 0FFh
	db	0FFh, 83h, 3Eh, 6Ah, 6, 0, 74h, 3Eh, 51h, 0FFh, 36h, 5Eh, 6, 0FFh, 36h, 5Ch
	db	6, 1Eh, 0B8h, 0BCh, 0Ah, 50h, 1Eh, 0B8h, 0C0h, 0Ah, 50h, 0E8h, 2Eh, 0Eh, 59h, 8Bh
	db	0D8h, 0Bh, 0DAh, 74h, 21h, 51h, 0A3h, 0A4h, 0Ah, 89h, 16h, 0A6h, 0Ah, 0E8h, 19h, 7
	db	59h, 0A1h, 0A8h, 0Ah, 3Bh, 6, 5Ch, 6, 75h, 0Ch, 0A1h, 0AAh, 0Ah, 3Bh, 6, 5Eh
	db	6, 75h, 3, 0E9h, 9Fh, 0, 1, 0Eh, 5Ch, 6, 0E9h, 1Eh, 0FFh, 74h, 0FBh, 0EBh
	db	75h, 90h, 89h, 3Eh, 0D8h, 0Ah, 33h, 0C0h, 26h, 0F6h, 45h, 5, 2, 75h, 6, 8Bh
	db	46h, 0Ch, 2Bh, 0C1h, 40h, 0A3h, 0D6h, 0Ah, 0FFh, 36h, 9Ah, 0Ah, 0FFh, 36h, 5Ch, 6
	db	1Eh, 0B8h, 0BCh, 0Ah, 50h, 1Eh, 0B8h, 0C0h, 0Ah, 50h, 0E8h, 0CFh, 0Dh, 0A3h, 0A4h, 0Ah
	db	89h, 16h, 0A6h, 0Ah, 83h, 3Eh, 0D6h, 0Ah, 0, 74h, 42h, 8Bh, 16h, 9Ah, 0Ah, 0A1h
	db	5Ch, 6, 0E8h, 1Dh, 0Eh, 0FCh, 23h, 0C0h, 75h, 33h, 8Bh, 3Eh, 0D8h, 0Ah, 8Eh, 46h
	db	0Ah, 26h, 0FFh, 75h, 4, 26h, 0C4h, 3Dh, 0E8h, 11h, 3, 58h, 26h, 88h, 5, 0E8h
	db	16h, 9, 8Bh, 3Eh, 0D8h, 0Ah, 8Eh, 46h, 0Ah, 26h, 0C4h, 3Dh, 0E8h, 0FDh, 2, 26h
	db	0C6h, 5, 0CCh, 0E9h, 0C1h, 0FEh, 0A3h, 0A4h, 0Ah, 89h, 16h, 0A6h, 0Ah, 0E8h, 79h, 6
	db	0A1h, 0A8h, 0Ah, 3Bh, 6, 5Ch, 6, 75h, 9, 0A1h, 0AAh, 0Ah, 3Bh, 6, 5Eh, 6
	db	74h, 3, 0E9h, 11h, 0FEh, 0E8h, 26h, 7, 0E8h, 7Fh, 3
L05DD4:	mov	ax, word ptr ds:[0AA4h]	;@05DD4
	mov	dx, word ptr ds:[0AA6h]	;@05DD7
L05DDB:	mov	cx, word ptr ds:[0AD6h]	;@05DDB
	pop	di	;@05DDF
	pop	si	;@05DE0
	pop	bp	;@05DE1
	retf	8	;@05DE2
	db	0C4h, 3Eh, 0A8h, 0Ah, 26h, 8Ah, 5, 26h, 0C6h, 5, 0CCh, 0C4h, 3Eh	;@05DE5
	db	0B8h, 0Ah, 0AAh, 0C7h, 6, 0B6h, 0Ah, 0, 0, 0C3h, 0A3h, 0EEh, 0Ah
	db	89h, 1Eh, 0ECh, 0Ah, 89h, 1Eh, 0F0h, 0Ah, 0C7h, 6, 0F4h, 0Ah, 0
	db	0, 3, 0DAh, 89h, 1Eh, 0F2h, 0Ah, 89h, 3Eh, 0E6h, 0Ah, 8Ch, 6, 0E8h
	db	0Ah, 8Bh, 0C1h, 0D1h, 0E0h, 0D1h, 0E0h, 0D1h, 0E0h, 0A3h, 0EAh
	db	0Ah, 0D1h, 0E9h, 33h, 0C0h, 0F3h, 0ABh, 0A3h, 1Ch, 0Bh, 0A2h, 0E4h
	db	0Ah, 0C3h, 3Bh, 0Eh, 0EAh, 0Ah, 76h, 3, 0E9h, 34h, 1, 0A3h, 2
	db	0Bh, 89h, 1Eh, 0F8h, 0Ah, 8Ch, 6, 0FAh, 0Ah, 89h, 16h, 0FCh, 0Ah
	db	3, 0CBh, 89h, 0Eh, 0FEh, 0Ah, 0C7h, 6, 1Ah, 0Bh, 0, 0, 0C6h, 6
	db	0E5h, 0Ah, 0FFh, 0A1h, 0F2h, 0Ah, 0A3h, 0F6h, 0Ah, 89h, 36h, 0
	db	0Bh, 0E8h, 1Ch, 2, 89h, 1Eh, 8, 0Bh, 89h, 16h, 0Ah, 0Bh, 89h, 0Eh
	db	0Ch, 0Bh, 8Bh, 36h, 8, 0Bh, 8Eh, 6, 0E8h, 0Ah, 0A1h, 0Ah, 0Bh
	db	26h, 85h, 4, 75h, 6Ch, 8Bh, 3Eh, 0, 0Bh, 8Eh, 6, 0FAh, 0Ah, 0E8h
	db	91h, 6, 89h, 0Eh, 10h, 0Bh, 89h, 3Eh, 12h, 0Bh, 8Ch, 6, 14h, 0Bh
	db	0A3h, 0Eh, 0Bh, 8Bh, 36h, 8, 0Bh, 8Eh, 6, 0E8h, 0Ah, 0A1h, 0Ah
	db	0Bh, 8Bh, 16h, 0Ch, 0Bh, 26h, 9, 4, 0D1h, 0E0h, 4Ah, 75h, 0Eh
	db	0B8h, 1, 0, 0BAh, 10h, 0, 83h, 0C6h, 2, 83h, 6, 8, 0Bh, 2, 0E2h
	db	0E8h, 0A3h, 0Ah, 0Bh, 89h, 16h, 0Ch, 0Bh, 0A1h, 0Eh, 0Bh, 3Dh
	db	5, 0, 74h, 3Dh, 0C7h, 6, 1Ah, 0Bh, 0, 0, 23h, 0C0h, 75h, 33h, 0A1h
	db	10h, 0Bh, 1, 6, 0, 0Bh, 0A1h, 0, 0Bh, 3Bh, 6, 0FEh, 0Ah, 73h, 2
	db	0EBh, 84h, 8Bh, 36h, 0F6h, 0Ah, 3Bh, 36h, 0F2h, 0Ah, 74h, 15h
	db	8Eh, 6, 0E8h, 0Ah, 26h, 8Bh, 34h, 83h, 6, 0F6h, 0Ah, 2, 0C7h, 6
	db	1Ah, 0Bh, 0, 0, 0E9h, 52h, 0FFh, 0F8h, 0C3h, 8Bh, 0D8h, 83h, 0E3h
	db	7Fh, 0D1h, 0E3h, 0FFh, 0A7h, 1Ch, 0Bh, 0B0h, 5, 0E8h, 9Dh, 1, 0EBh
	db	0BBh, 0A9h, 80h, 0, 74h, 4Ch, 0B0h, 8, 0E8h, 91h, 1, 0EBh, 0C1h
	db	83h, 3Eh, 0Eh, 0Bh, 3, 74h, 7, 8Bh, 36h, 12h, 0Bh, 0E9h, 24h, 0FFh
	db	8Bh, 36h, 12h, 0Bh, 0E8h, 40h, 1, 8Eh, 6, 0E8h, 0Ah, 26h, 85h
	db	17h, 75h, 1Fh, 8Bh, 1Eh, 8, 0Bh, 0A1h, 0Ah, 0Bh, 26h, 23h, 7, 75h
	db	0DDh, 83h, 2Eh, 0F6h, 0Ah, 2, 8Bh, 3Eh, 0F6h, 0Ah, 3Bh, 3Eh, 0F0h
	db	0Ah, 72h, 7, 0A1h, 12h, 0Bh, 0ABh, 0E9h, 6Fh, 0FFh, 0E8h, 0E0h
	db	1, 0F9h, 0C3h, 0A1h, 14h, 0Bh, 3Bh, 6, 0FAh, 0Ah, 75h, 17h, 0A1h
	db	0FCh, 0Ah, 0A3h, 14h, 0Bh, 0A1h, 12h, 0Bh, 3Bh, 6, 0F8h, 0Ah, 72h
	db	8, 't5;', 6, 0FEh, 0Ah, 72h, 9Bh, 0FFh, 36h, 14h, 0Bh, 0FFh, 36h
	db	12h, 0Bh, 1Eh, 0B8h, 16h, 0Bh, 50h, 1Eh, 0B8h, 0C0h, 0Ah, 50h
	db	0E8h, 8Bh, 0Bh, 0Bh, 0C2h, 75h, 3, 0E9h, 78h, 0FFh, 0B0h, 6, 0C4h
	db	3Eh, 12h, 0Bh, 0E8h, 0Dh, 1, 83h, 3Eh, 0Eh, 0Bh, 3, 74h, 4Fh, 0E9h
	db	2Dh, 0FFh, 0B0h, 9, 0C4h, 3Eh, 12h, 0Bh, 0E8h, 0FAh, 0, 0C6h, 6
	db	0E4h, 0Ah, 1, 0A1h, 5Ch, 6, 3Bh, 6, 0A8h, 0Ah, 75h, 0Dh, 0A1h
	db	5Eh, 6, 3Bh, 6, 0AAh, 0Ah, 75h, 4, 0FEh, 0Eh, 0E4h, 0Ah, 0E9h
	db	45h, 0FFh, 83h, 3Eh, 1Ah, 0Bh, 0, 75h, 0Bh, 0C7h, 6, 1Ah, 0Bh
	db	1, 0, 0B0h, 4, 0E8h, 0C2h, 0, 0E9h, 0DFh, 0FEh, 83h, 7Eh, 6, 0
	db	75h, 5Fh, 0A9h, 80h, 0, 74h, 8, 0B0h, 7, 0E8h, 0AFh, 0, 0E9h, 0CCh
	db	0FEh, 0C4h, 3Eh, 12h, 0Bh, 26h, 81h, 3Eh, 0, 0, 0CDh, 3Fh, 75h
	db	11h, 26h, 8Bh, 45h, 1, 26h, 80h, 3Dh, 0EAh, 74h, 4, 26h, 8Bh, 45h
	db	2, 0A3h, 12h, 0Bh, 0A1h, 14h, 0Bh, 3Bh, 6, 0FAh, 0Ah, 75h, 6, 0A1h
	db	0FCh, 0Ah, 0A3h, 14h, 0Bh, 0FFh, 36h, 14h, 0Bh, 0FFh, 36h, 12h
	db	0Bh, 1Eh, 0B8h, 16h, 0Bh, 50h, 1Eh, 0B8h, 0C0h, 0Ah, 50h, 0E8h
	db	0E0h, 0Ah, 0Bh, 0C2h, 74h, 0Ch, 0B0h, 6, 0C4h, 3Eh, 16h, 0Bh, 0E8h
	db	65h, 0, 0E9h, 7Ah, 0FEh, 0B0h, 3, 0E8h, 55h, 0, 0E9h, 72h, 0FEh
	db	0B0h, 0, 0E8h, 4Dh, 0, 0E9h, 6Ah, 0FEh, 0B0h, 1, 0E8h, 45h, 0
	db	0E9h, 62h, 0FEh, 0B0h, 2, 0E8h, 3Dh, 0, 0E9h, 5Ah, 0FEh, 2Bh, 36h
	db	0F8h, 0Ah, 8Bh, 0DEh, 0B1h, 4, 0D3h, 0EBh, 0D1h, 0E3h, 3, 1Eh
	db	0E6h, 0Ah, 83h, 0E6h, 0Fh, 0D1h, 0E6h, 0D1h, 0E6h, 8Bh, 94h, 2Eh
	db	0Bh, 8Bh, 8Ch, 30h, 0Bh, 0C3h
L060A5:	cmp	word ptr es:[0], 3FCDh	;@060A5
	jne	@@1	;@060AC
	cmp	word ptr es:[10h], 0	;@060AE
	je	@@2	;@060B4
	mov	es, word ptr es:[10h]	;@060B6
@@1:	clc	;@060BB
	ret	;@060BC
@@2:	stc	;@060BD
	ret	;@060BE
	db	8Bh, 3Eh, 0, 0Bh, 8Eh, 6, 0FAh, 0Ah, 3Ch, 9, 75h, 15h, 83h, 3Eh	;@060BF
	db	0B6h, 0Ah, 0, 74h, 0Eh, 3Bh, 3Eh, 0A8h, 0Ah, 75h, 8, 8Ch, 0C2h
	db	3Bh, 16h, 0AAh, 0Ah, 74h, 38h, 0E8h, 0A1h, 0, 74h, 34h, 8Bh, 1Eh
	db	0F0h, 0Ah, 8Dh, 57h, 6, 3Bh, 16h, 0F6h, 0Ah, 77h, 58h, 1Eh, 8Eh
	db	1Eh, 0EEh, 0Ah, 89h, 3Fh, 8Ch, 47h, 2, 88h, 47h, 5, 0E8h, 0A3h
	db	0FFh, 72h, 0Ah, 26h, 8Ah, 5, 88h, 47h, 4, 26h, 0C6h, 5, 0CCh, 1Fh
	db	83h, 6, 0F0h, 0Ah, 6, 0FFh, 6, 0F4h, 0Ah, 0C3h, 3Ch, 9, 75h, 0FBh
	db	8Bh, 0Eh, 0F4h, 0Ah, 0E3h, 0F5h, 1Eh, 0C5h, 36h, 0ECh, 0Ah, 8Ch
	db	0C2h, ';<u', 15h, 3Bh, 54h, 2, 75h, 10h, 8Ah, 44h, 5, 0C6h, 44h
	db	5, 9, 1Fh, 3Ch, 9, 74h, 0D9h, 0A2h, 0E5h, 0Ah, 0C3h, 83h, 0C6h
	db	6, 0E2h, 0E2h, 1Fh, 0C3h, 0E8h, 6, 0, 0E8h, 0A7h, 3, 0E9h, 0C9h
	db	0FAh
L06153:	mov	cx, word ptr ds:[0AF4h]	;@06153
	jcxz	@@3	;@06157
	push	ds	;@06159
	lds	si, dword ptr ds:[0AECh]	;@0615A
@@1:	les	di, dword ptr [si]	;@0615E
	call	L060A5	;@06160
	jb	@@2	;@06163
	cmp	byte ptr es:[di], 0CCh	;@06165
	jne	@@2	;@06169
	mov	al, byte ptr [si+4]	;@0616B
	mov	byte ptr es:[di], al	;@0616E
@@2:	add	si, 6	;@06171
	loop	@@1	;@06174
	pop	ds	;@06176
	mov	ax, word ptr ds:[0AECh]	;@06177
	mov	word ptr ds:[0AF0h], ax	;@0617A
	mov	word ptr ds:[0AF4h], 0	;@0617D
@@3:	ret	;@06183
	db	6, 1Eh, 8Ch, 0C2h, 8Bh, 0Eh, 0F4h, 0Ah, 0E3h, 12h, 0C5h, 36h, 0ECh	;@06184
	db	0Ah, ';<u', 5, 3Bh, 54h, 2, 74h, 2Ch, 83h, 0C6h, 6, 0E2h, 0F2h
	db	1Fh, 1Eh, 8Bh, 4Eh, 0Ch, 0E3h, 1Dh, 0C5h, 76h, 8, 80h, 7Ch, 5
	db	0, 74h, 0Fh, ';<u', 0Bh, 3Bh, 54h, 2, 75h, 6, 80h, 4Ch, 5, 2, 0EBh
	db	8, 83h, 0C6h, 6, 0E2h, 0E6h, 80h, 0C9h, 1, 1Fh, 7, 0C3h, 8Bh, 36h
	db	4, 0Bh, 8Eh, 6, 0EEh, 0Ah, 26h, 0C4h, 3Ch, 0E8h, 0CDh, 0FEh, 'r/&'
	db	80h, 3Dh, 0CCh, 75h, 29h, 8Ah, 44h, 4, 26h, 88h, 5, 0C7h, 6, 92h
	db	0Ah, 1, 0, 0E8h, 0C2h, 4, 0C7h, 6, 92h, 0Ah, 0, 0, 8Bh, 36h, 4
	db	0Bh, 8Eh, 6, 0EEh, 0Ah, 0C4h, 3Ch, 26h, 8Ah, 5, 88h, 44h, 4, 26h
	db	0C6h, 5, 0CCh, 0C3h, 8Bh, 0Eh, 0F4h, 0Ah, 0E3h, 17h, 8Bh, 3Eh
	db	0ECh, 0Ah, 8Eh, 6, 0EEh, 0Ah, 0A1h, 5Ch, 6, 8Bh, 16h, 5Eh, 6, 0AFh
	db	74h, 7, 83h, 0C7h, 4, 0E2h, 0F8h, 0F9h, 0C3h, 6, 26h, 8Eh, 5, 0E8h
	db	75h, 0FEh, 8Ch, 0C3h, 7, 72h, 0EDh, 3Bh, 0D3h, 75h, 0E9h, 26h
	db	8Bh, 5, 0A3h, 9Ah, 0Ah, 83h, 0EFh, 2, 89h, 3Eh, 4, 0Bh, 26h, 8Ah
	db	45h, 5, 98h, 0A3h, 6, 0Bh, 8Bh, 0D8h, 3Ch, 9, 't!<', 7, 74h, 1Dh
	db	3Ch, 8, 74h, 19h, 1Eh, 6, 26h, 0C4h, 35h, 0E8h, 41h, 0FEh, 6, 1Fh
	db	7, 72h, 0Bh, 80h, 3Ch, 0CCh, 75h, 6, 26h, 8Ah, 45h, 4, 88h, 4
	db	1Fh, 0D1h, 0E3h, 0FFh, 0A7h, 6Eh, 0Bh, 0FEh, 6, 0E4h, 0Ah, 0A0h
	db	0E5h, 0Ah, 3Ch, 0FFh, 75h, 10h, 80h, 3Eh, 0E4h, 0Ah, 2, 74h, 6
	db	0E8h, 3Ah, 0FFh, 32h, 0C0h, 0C3h, 0E9h, 92h, 0, 98h, 8Bh, 0D8h
	db	0FFh, 36h, 5Ch, 6, 0E8h, 0D5h, 0FFh, '[PR', 9Ch, 3Bh, 1Eh, 5Ch
	db	6, 75h, 23h, 8Bh, 3Eh, 4, 0Bh, 8Eh, 6, 0EEh, 0Ah, 1Eh, 26h, 0C5h
	db	35h, 80h, 3Ch, 0CCh, 74h, 9, 8Ah, 4, 0C6h, 4, 0CCh, 26h, 88h, 45h
	db	4, 1Fh, 0E8h, 2, 0FFh, 0C6h, 6, 0E5h, 0Ah, 0FFh, 9Dh, 5Ah, 58h
	db	0C6h, 6, 0E4h, 0Ah, 1, 0C3h, 0E8h, 0F1h, 0FEh, 8Bh, 36h, 5Eh, 6
	db	3Bh, 36h, 0FAh, 0Ah, 75h, 45h, 8Bh, 36h, 5Ch, 6, 3Bh, 36h, 0F8h
	db	0Ah, 'r;;6', 0FEh, 0Ah, 73h, 35h, 0E8h, 8Fh, 0FDh, 8Eh, 6, 0E8h
	db	0Ah, 26h, 85h, 17h, 75h, 7, 8Bh, 36h, 5Ch, 6, 0E8h, 56h, 0FBh
	db	32h, 0C0h, 0C3h, 0E8h, 0BEh, 0FEh, 0EBh, 1Ah, 0C7h, 6, 92h, 0Ah
	db	1, 0, 0E8h, 9Ah, 3, 0C7h, 6, 92h, 0Ah, 0, 0, 83h, 7Eh, 6, 1, 75h
	db	5, 0C7h, 46h, 6, 0, 0, 0FFh, 36h, 9Ah, 0Ah, 0FFh, 36h, 5Ch, 6
	db	1Eh, 0B8h, 0BCh, 0Ah, 50h, 1Eh, 0B8h, 0C0h, 0Ah, 50h, 0E8h, 0F8h
	db	7, 83h, 3Eh, 6, 0Bh, 7, 75h, 6, 8Bh, 0D8h, 0Bh, 0DAh, 'tYPR', 0E8h
	db	4, 0FEh, 5Ah, 58h, 8Bh, 0D8h, 0Bh, 0DAh, 75h, 7, 0E8h, 1Dh, 8
	db	33h, 0C0h, 33h, 0D2h, 0C3h, 0A1h, 58h, 6, 50h, 8Bh, 3Eh, 4, 0Bh
	db	1Eh, 8Eh, 1Eh, 0EEh, 0Ah, 0C4h, 35h, 0E8h, 34h, 0FDh, 26h, 80h
	db	3Ch, 0CCh, 75h, 6, 8Ah, 45h, 4, 26h, 88h, 4, 1Fh, 'X=P', 0, 72h
	db	1Fh, 3Dh, 0, 0A0h, 72h, 5, 3Dh, 0, 0C0h, 72h, 15h, 32h, 0C0h, 0C3h
	db	0A1h, 58h, 6, 3Dh, 0, 0A0h, 73h, 0C9h, 3Dh, 50h, 0, 72h, 0C4h
	db	0A1h, 5Ah, 6, 0EBh, 0BFh, 83h, 3Eh, 1Ch, 0Bh, 0, 75h, 2Ch, 0E8h
	db	0CAh, 7, 0C7h, 6, 1Ch, 0Bh, 1, 0, 8Bh, 0Eh, 0F4h, 0Ah, 1Eh, 0C5h
	db	36h, 0ECh, 0Ah, 80h, 7Ch, 5, 4, 77h, 0Eh, 0C4h, 3Ch, 26h, 80h
	db	3Dh, 0CCh, 75h, 6, 8Ah, 44h, 4, 26h, 88h, 5, 83h, 0C6h, 6, 0E2h
	db	0E7h, 1Fh, 32h, 0C0h, 0C3h
L063D9:	mov	cx, word ptr ds:[0AF4h]	;@063D9
	jcxz	@@3	;@063DD
	push	ds	;@063DF
	lds	si, dword ptr ds:[0AECh]	;@063E0
@@1:	les	di, dword ptr [si]	;@063E4
	cmp	byte ptr es:[di], 0CCh	;@063E6
	jne	@@2	;@063EA
	mov	al, byte ptr [si+4]	;@063EC
	mov	byte ptr es:[di], al	;@063EF
@@2:	add	si, 6	;@063F2
	loop	@@1	;@063F5
	pop	ds	;@063F7
@@3:	ret	;@063F8
L063F9:	push	bp	;@063F9
	mov	bp, sp	;@063FA
	push	si	;@063FC
	push	di	;@063FD
	mov	dx, word ptr [bp+6]	;@063FE
	cli	;@06401
	mov	ss, word ptr ds:[0AC6h]	;@06402
	mov	sp, word ptr ds:[0AC4h]	;@06406
	sti	;@0640A
	mov	bp, word ptr ds:[0AC2h]	;@0640B
	mov	ds, word ptr ds:[0A9Ch]	;@0640F
	push	dx	;@06413
	call	L068F3	;@06414
	call	L0688A	;@06417
	call	L064F7	;@0641A
	call	L06153	;@0641D
	xor	ax, ax	;@06420
	pop	dx	;@06422
	xor	dh, dh	;@06423
	cmp	byte ptr ds:[0AA3h], 0	;@06425
	je	@@1	;@0642A
	mov	dx, ax	;@0642C
	dec	ax	;@0642E
@@1:	jmp	L05DDB	;@0642F
	db	0C4h, 6, 0BCh, 0Ah, 0A3h, 0A8h, 0Ah, 8Ch, 6, 0AAh, 0Ah, 8Ch, 6	;@06432
	db	0C8h, 0Ah, 0E8h, 61h, 0FCh, 72h, 4, 8Ch, 6, 0AAh, 0Ah, 0A1h, 0C0h
	db	0Ah, 0A3h, 0ACh, 0Ah, 0C3h, 0, 0, 0, 0, 0C7h, 6, 0B6h, 0Ah, 0
	db	0, 8Bh, 4Eh, 0Ch, 89h, 0Eh, 94h, 0Ah, 0E3h, 65h, 0C4h, 5Eh, 8
	db	89h, 1Eh, 96h, 0Ah, 8Ch, 6, 98h, 0Ah, 51h, 53h, 6, 26h, 8Bh, 7
	db	2Eh, 0A3h, 81h, 9, 26h, 8Bh, 47h, 2, 2Eh, 0A3h, 83h, 9, 2Eh, 0A1h
	db	81h, 9, 3Bh, 6, 5Ch, 6, 75h, 40h, 6, 2Eh, 8Eh, 6, 83h, 9, 0E8h
	db	11h, 0FCh, 8Ch, 0C0h, 7, 'r2;', 6, 5Eh, 6, 'u,2', 0C0h, 83h, 7Eh
	db	6, 2, 75h, 3Bh, 83h, 3Eh, 0B6h, 0Ah, 0, 75h, 34h, 7, 5Bh, 53h
	db	6, 0C7h, 6, 0B6h, 0Ah, 1, 0, 8Dh, 47h, 4, 0A3h, 0B8h, 0Ah, 8Ch
	db	6, 0BAh, 0Ah, 2Eh, 0C4h, 3Eh, 81h, 9, 0EBh, 15h, 0EBh, 2Bh, 2Eh
	db	0C4h, 3Eh, 81h, 9, 6, 0E8h, 0D1h, 0FBh, 72h, 7, 26h, 8Ah, 25h
	db	26h, 0C6h, 5, 0CCh, 7, 0B0h, 1, 8Ch, 0C2h, 7, 5Bh, 26h, 88h, 47h
	db	5, 26h, 88h, 67h, 4, 59h, 83h, 0C3h, 6, 49h, 74h, 3, 0E9h, 79h
	db	0FFh, 0C3h
L064F7:	mov	cx, word ptr [bp+0Ch]	;@064F7
	jcxz	@@3	;@064FA
	push	ds	;@064FC
	lds	si, dword ptr [bp+8]	;@064FD
@@1:	cmp	byte ptr [si+5], 0	;@06500
	je	@@2	;@06504
	mov	di, word ptr [si]	;@06506
	mov	es, word ptr [si+2]	;@06508
	call	L060A5	;@0650B
	cmp	byte ptr es:[di], 0CCh	;@0650E
	jne	@@2	;@06512
	mov	al, byte ptr [si+4]	;@06514
	mov	byte ptr es:[di], al	;@06517
@@2:	add	si, 6	;@0651A
	loop	@@1	;@0651D
	pop	ds	;@0651F
@@3:	ret	;@06520
	db	33h, 0D2h, 89h, 16h, 56h, 0Dh, 26h, 8Bh, 1Dh, 0BEh, 82h, 0Bh, 0B9h	;@06521
	db	4Eh, 0, 0ADh, 23h, 0C3h, 3Bh, 4, 74h, 0Bh, 83h, 0C6h, 4, 0E2h
	db	0F4h, 0B9h, 1, 0, 33h, 0C0h, 0C3h, 8Ah, 4Ch, 2, 32h, 0EDh, 8Ah
	db	44h, 3, 32h, 0E4h, 22h, 0C9h, 7Eh, 3, 3, 0CAh, 0C3h, 74h, 35h
	db	0FEh, 0CDh, 8Bh, 0F1h, 0F7h, 0DEh, 81h, 0C6h, 92h, 0Ah, 2Eh, 0FFh
	db	24h, 0BAh, 0Ah, 0DCh, 0Ah, 0EDh, 0Ah, 0FAh, 0Ah, 82h, 0Ah, 82h
	db	0Ah, 30h, 0Bh, 2Fh, 0Bh, 8Eh, 0Bh, 99h, 0Bh, 0A4h, 0Bh, 28h, 0Bh
	db	22h, 0Bh, 19h, 0Bh, 16h, 0Bh, 0AFh, 0Bh, 0B6h, 0Bh, 0CFh, 0Bh
	db	4, 0Bh, 0BBh, 0Bh, 26h, 8Ah, 5, 'GB<&t', 10h, '<.t', 4, '<&u'
	db	8Ch, 0C7h, 6, 56h, 0Dh, 0FFh, 0FFh, 0EBh, 84h, 0C7h, 6, 56h, 0Dh
	db	7, 0, 0E9h, 7Bh, 0FFh, 8Bh, 0D8h, 26h, 8Ah, 45h, 1, 98h, 93h, 8Dh
	db	79h, 2, 0B9h, 2, 0, 3, 0CAh, 0C3h, 26h, 8Bh, 5Dh, 1, 8Dh, 79h
	db	3, 0B9h, 3, 0, 3, 0CAh, 0C3h, 26h, 0C4h, 7Dh, 1, 0B9h, 5, 0, 3
	db	0CAh, 0C3h, 'GB&', 8Ah, 5Dh, 1, 80h, 0E3h, 0F0h, 80h, 0FBh, 20h
	db	75h, 4, 42h, 3, 0CAh, 0C3h, 47h, 0EBh, 16h, 26h, 0F6h, 5, 2, 75h
	db	10h, 42h, 0EBh, 0Dh, 26h, 0F6h, 5, 2, 75h, 7, 42h, 26h, 0F6h, 5
	db	1, 74h, 1, 42h, 23h, 0C0h, 75h, 34h, 8Bh, 0Eh, 56h, 0Dh, 23h, 0C9h
	db	'|,&', 8Ah, 5Dh, 1, 80h, 0FBh, 0C0h, 73h, 23h, 0E3h, 4, 0Bh, 0C1h
	db	0EBh, 1Dh, 80h, 0E3h, 0C7h, 80h, 0FBh, 6, 74h, 15h, 80h, 0E3h
	db	7, 80h, 0FBh, 2, 74h, 0Dh, 80h, 0FBh, 3, 74h, 8, 80h, 0FBh, 6
	db	74h, 3, 0Dh, 6, 0, 26h, 8Ah, 5Dh, 1, 80h, 0E3h, 0C7h, 0B9h, 2
	db	0, 80h, 0FBh, 0C0h, 73h, 14h, 0B9h, 4, 0, 80h, 0FBh, 80h, 73h
	db	0Ch, 80h, 0FBh, 6, 74h, 7, 49h, 80h, 0FBh, 40h, 73h, 1, 49h, 3
	db	0CAh, 0C3h, 0B9h, 2, 0, 26h, 0F6h, 5, 1, 74h, 1, 41h, 0C3h, 0B9h
	db	2, 0, 26h, 0F6h, 5, 2, 75h, 1, 41h, 0C3h, 0B9h, 2, 0, 26h, 0F6h
	db	5, 8, 74h, 1, 41h, 0C3h, 0B8h, 7, 0, 8Bh, 0CAh, 41h, 0C3h, 0B9h
	db	1, 0, 0EBh, 3, 0B9h, 3, 0, 0A1h, 56h, 0Dh, 3Dh, 7, 0, 74h, 0E9h
	db	40h, 74h, 3, 0B8h, 6, 0, 3, 0CAh, 0C3h, 0A1h, 56h, 0Dh, 3Dh, 7
	db	0, 74h, 0D8h, 40h, 74h, 0D5h, 0B8h, 8, 0, 8Bh, 0CAh, 41h, 0C3h
	db	0C4h, 3Eh, 5Ch, 6, 26h, 80h, 3Dh, 0CDh, 74h, 0Ah, 0E8h, 32h, 4
	db	0E8h, 39h, 0, 0E8h, 51h, 4, 0C3h, 26h, 80h, 7Dh, 1, 34h, 72h, 0EFh
	db	26h, 80h, 7Dh, 1, 3Eh, 77h, 0E8h, 0E8h, 4Bh, 0FEh, 0C4h, 3Eh, 5Ch
	db	6, 3, 0F9h, 26h, 0FFh, 35h, 6, 57h, 26h, 0C6h, 5, 0CCh, 0E8h, 8Fh
	db	4, 0E8h, 53h, 1, 0Eh, 0E8h, 40h, 2, 90h, 0E8h, 79h, 1, 5Fh, 7
	db	58h, 26h, 88h, 5, 0C3h
L066FA:	les	di, dword ptr ds:[65Ch]	;@066FA
	mov	al, byte ptr es:[di]	;@066FE
	cmp	al, 0CCh	;@06701
	je	@@2	;@06703
	cmp	al, 0CFh	;@06705
	je	@@3	;@06707
	cmp	al, 9Ch	;@06709
	je	@@4	;@0670B
	cmp	al, 9Dh	;@0670D
	je	@@5	;@0670F
	cmp	al, 0CDh	;@06711
	je	@@1	;@06713
	or	word ptr ds:[660h], 100h	;@06715
	push	word ptr ds:[0AA0h]	;@0671B
	mov	word ptr ds:[0AA0h], 1	;@0671F
	push	cs	;@06725
	db	0E8h, 6, 2	; call L0692F	;@06726
	nop	;@06729
	pop	word ptr ds:[0AA0h]	;@0672A
	inc	word ptr ds:[65Ch]	;@0672E
	jmp	@@8	;@06732
@@1:	jmp	short @@6	;@06735
@@2:	inc	word ptr ds:[65Ch]	;@06737
	ret	;@0673B
@@3:	mov	es, word ptr ds:[664h]	;@0673C
	mov	bx, word ptr ds:[662h]	;@06740
	mov	ax, word ptr es:[bx]	;@06744
	mov	cx, word ptr es:[bx+2]	;@06747
	mov	dx, word ptr es:[bx+4]	;@0674B
	mov	word ptr ds:[65Ch], ax	;@0674F
	mov	word ptr ds:[65Eh], cx	;@06752
	mov	word ptr ds:[660h], dx	;@06756
	add	word ptr ds:[662h], 6	;@0675A
	jmp	short @@8	;@0675F
@@4:	sub	word ptr ds:[662h], 2	;@06761
	mov	bx, word ptr ds:[662h]	;@06766
	mov	es, word ptr ds:[664h]	;@0676A
	mov	ax, word ptr ds:[660h]	;@0676E
	mov	word ptr es:[bx], ax	;@06771
	inc	word ptr ds:[65Ch]	;@06774
	ret	;@06778
@@5:	mov	bx, word ptr ds:[662h]	;@06779
	mov	es, word ptr ds:[664h]	;@0677D
	mov	ax, word ptr es:[bx]	;@06781
	and	ax, 0FEFFh	;@06784
	mov	word ptr ds:[660h], ax	;@06787
	add	word ptr ds:[662h], 2	;@0678A
	inc	word ptr ds:[65Ch]	;@0678F
	ret	;@06793
@@6:	mov	bl, byte ptr es:[di+1]	;@06794
	xor	bh, bh	;@06798
	shl	bx, 1	;@0679A
	shl	bx, 1	;@0679C
	add	word ptr ds:[65Ch], 2	;@0679E
	sub	word ptr ds:[662h], 6	;@067A3
	mov	di, word ptr ds:[662h]	;@067A8
	mov	es, word ptr ds:[664h]	;@067AC
	mov	ax, word ptr ds:[65Ch]	;@067B0
	stosw	;@067B3
	mov	ax, word ptr ds:[65Eh]	;@067B4
	stosw	;@067B7
	mov	ax, word ptr ds:[660h]	;@067B8
	stosw	;@067BB
	push	ds	;@067BC
	add	bx, 68Ch	;@067BD
	test	byte ptr ds:[0AA3h], 80h	;@067C1
	je	@@7	;@067C6
	xor	ax, ax	;@067C8
	mov	ds, ax	;@067CA
	sub	bx, 68Ch	;@067CC
@@7:	mov	ax, word ptr [bx]	;@067D0
	mov	dx, word ptr [bx+2]	;@067D2
	pop	ds	;@067D5
	mov	word ptr ds:[65Ch], ax	;@067D6
	mov	word ptr ds:[65Eh], dx	;@067D9
@@8:	les	di, dword ptr ds:[65Ch]	;@067DD
	cmp	word ptr es:[0], 3FCDh	;@067E1
	je	@@9	;@067E8
	mov	ax, es	;@067EA
	db	0E8h, 0C3h, 3	; call L06BB2	;@067EC
	mov	word ptr ds:[0A9Ah], ax	;@067EF
	ret	;@067F2
@@9:	test	byte ptr ds:[0AA3h], 80h	;@067F3
	jne	@@11	;@067F8
	cmp	word ptr es:[di], 3FCDh	;@067FA
	je	@@10	;@067FF
	cmp	byte ptr es:[di], 0EAh	;@06801
	jne	@@11	;@06805
	mov	word ptr ds:[0A9Ah], es	;@06807
	les	ax, dword ptr es:[di+1]	;@0680B
	mov	word ptr ds:[65Ch], ax	;@0680F
	mov	word ptr ds:[65Eh], es	;@06812
	ret	;@06816
@@10:	db	0E8h, 0FBh, 2	; call L06B15	;@06817
	call	@@12	;@0681A
	push	cs	;@0681D
	db	0E8h, 0Eh, 1	; call L0692F	;@0681E
	nop	;@06821
	call	@@13	;@06822
	db	0E8h, 0C8h, 2	; call L06AF0	;@06825
	cmp	word ptr ds:[0A8Ch], -1	;@06828
	je	@@11	;@0682D
	les	di, dword ptr ds:[0A8Eh]	;@0682F
	cmp	byte ptr es:[di], 0CCh	;@06833
	jne	@@11	;@06837
	mov	al, byte ptr ds:[0A8Ch]	;@06839
	stosb	;@0683C
@@11:	ret	;@0683D
@@12:	mov	ah, 51h	;@0683E
	int	21h	;@06840
	mov	word ptr ds:[68Ah], bx	;@06842
	mov	es, bx	;@06846
	mov	ax, word ptr ds:[0ACAh]	;@06848
	mov	word ptr es:[2Eh], ax	;@0684B
	mov	ax, word ptr ds:[0ACCh]	;@0684F
	mov	word ptr es:[30h], ax	;@06852
	mov	bx, word ptr ds:[688h]	;@06856
	mov	ah, 50h	;@0685A
	int	21h	;@0685C
	cli	;@0685E
	call	L0688A	;@0685F
	call	L068C8	;@06862
	mov	word ptr ds:[0AA0h], 3	;@06865
	ret	;@0686B
@@13:	call	L068F3	;@0686C
	call	L0688A	;@0686F
	mov	word ptr ds:[0AA0h], 0	;@06872
	sti	;@06878
	mov	ah, 51h	;@06879
	int	21h	;@0687B
	mov	word ptr ds:[688h], bx	;@0687D
	mov	bx, word ptr ds:[68Ah]	;@06881
	mov	ah, 50h	;@06885
	int	21h	;@06887
	ret	;@06889
L0688A:	mov	dx, ds	;@0688A
	xor	ax, ax	;@0688C
	mov	bx, sp	;@0688E
	sub	sp, 401h	;@06890
	and	sp, -2	;@06894
	mov	ds, ax	;@06897
	mov	si, ax	;@06899
	push	ss	;@0689B
	pop	es	;@0689C
	mov	di, sp	;@0689D
	mov	cx, 200h	;@0689F
	rep movsw	;@068A2
	nop	;@068A4
	mov	ds, dx	;@068A5
	mov	si, 68Ch	;@068A7
	mov	es, ax	;@068AA
	mov	di, ax	;@068AC
	mov	cx, 200h	;@068AE
	rep movsw	;@068B1
	mov	si, sp	;@068B3
	push	ss	;@068B5
	pop	ds	;@068B6
	mov	di, 68Ch	;@068B7
	mov	es, dx	;@068BA
	mov	cx, 200h	;@068BC
	rep movsw	;@068BF
	mov	es, dx	;@068C1
	mov	ds, dx	;@068C3
	mov	sp, bx	;@068C5
	ret	;@068C7
L068C8:	push	ds	;@068C8
	mov	ax, S6BE	;@068C9
	mov	ds, ax	;@068CC
	xor	ax, ax	;@068CE
	mov	es, ax	;@068D0
	mov	si, 1Ah	;@068D2
	mov	cx, 5	;@068D5
@@1:	lodsw	;@068D8
	mov	di, ax	;@068D9
	mov	ax, word ptr es:[di]	;@068DB
	mov	word ptr [si], ax	;@068DE
	mov	ax, word ptr es:[di+2]	;@068E0
	mov	word ptr [si+2], ax	;@068E4
	add	si, 4	;@068E7
	movsw	;@068EA
	mov	ax, S6BE	;@068EB
	stosw	;@068EE
	loop	@@1	;@068EF
	pop	ds	;@068F1
	ret	;@068F2
L068F3:	mov	bx, word ptr ds:[688h]	;@068F3
	push	ds	;@068F7
	db	0BAh	;@068F8
	dw	S6BE
	db	8Eh, 0DAh	; mov ds, dx	;@068FB
	xor	ax, ax	;@068FD
	mov	es, ax	;@068FF
	mov	si, 1Ah	;@06901
	mov	cx, 5	;@06904
@@1:	lodsw	;@06907
	mov	di, ax	;@06908
	cmp	dx, word ptr es:[di+2]	;@0690A
	jne	@@3	;@0690E
	mov	ax, word ptr [si+4]	;@06910
	cmp	ax, word ptr es:[di]	;@06913
	jne	@@3	;@06916
@@2:	movsw	;@06918
	movsw	;@06919
	inc	si	;@0691A
	inc	si	;@0691B
	loop	@@1	;@0691C
	pop	ds	;@0691E
	ret	;@0691F
@@3:	cmp	word ptr es:[di+2], bx	;@06920
	jb	@@2	;@06924
	mov	ds, dx	;@06926
	add	si, 6	;@06928
	loop	@@1	;@0692B
	pop	ds	;@0692D
	ret	;@0692E
L0692F:	cli	;@0692F
	mov	word ptr ds:[0D58h], sp	;@06930
	mov	word ptr ds:[0D5Ah], ss	;@06934
	mov	word ptr ds:[0D5Ch], bp	;@06938
	mov	bx, 64Ah	;@0693C
	mov	ax, word ptr [bx]	;@0693F
	mov	cx, word ptr [bx+4]	;@06941
	mov	dx, word ptr [bx+6]	;@06944
	mov	si, word ptr [bx+0Ah]	;@06947
	mov	di, word ptr [bx+0Ch]	;@0694A
	mov	bp, word ptr [bx+8]	;@0694D
	mov	es, word ptr [bx+10h]	;@06950
	mov	ss, word ptr [bx+1Ah]	;@06953
	mov	sp, word ptr [bx+18h]	;@06956
	push	word ptr [bx+16h]	;@06959
	push	word ptr [bx+14h]	;@0695C
	push	word ptr [bx+12h]	;@0695F
	mov	bx, word ptr [bx+2]	;@06962
	mov	ds, word ptr ds:[658h]	;@06965
	iret	;@06969
L0696A:	mov	bx, 64Ah	;@0696A
	mov	word ptr [bx], ax	;@0696D
	pop	word ptr [bx+2]	;@0696F
	mov	word ptr [bx+4], cx	;@06972
	mov	word ptr [bx+6], dx	;@06975
	mov	word ptr [bx+0Ah], si	;@06978
	mov	word ptr [bx+0Ch], di	;@0697B
	mov	word ptr [bx+8], bp	;@0697E
	pop	word ptr [bx+0Eh]	;@06981
	mov	word ptr [bx+10h], es	;@06984
	pop	word ptr [bx+12h]	;@06987
	pop	word ptr [bx+14h]	;@0698A
	pop	word ptr [bx+16h]	;@0698D
	mov	word ptr [bx+1Ah], ss	;@06990
	mov	word ptr [bx+18h], sp	;@06993
	cli	;@06996
	mov	ss, word ptr ds:[0AC6h]	;@06997
	mov	sp, word ptr ds:[0AC4h]	;@0699B
	sti	;@0699F
	mov	bp, word ptr ds:[0AC2h]	;@069A0
	test	byte ptr ds:[0AA3h], 80h	;@069A4
	jne	@@5	;@069A9
	mov	byte ptr ds:[0AA3h], 82h	;@069AB
	sti	;@069B0
	call	L064F7	;@069B1
	call	L063D9	;@069B4
	mov	word ptr ds:[0AA4h], 1	;@069B7
	mov	word ptr ds:[0AA6h], 0	;@069BD
@@1:	mov	ax, word ptr ds:[65Eh]	;@069C3
	db	0E8h, 0E9h, 1	; call L06BB2	;@069C6
	mov	word ptr ds:[0AC8h], ax	;@069C9
	db	0E8h, 0B8h, 1	; call L06B87	;@069CC
	or	ax, ax	;@069CF
	jne	@@3	;@069D1
	mov	ax, word ptr ds:[65Eh]	;@069D3
@@2:	push	ax	;@069D6
	call	@@8	;@069D7
	pop	ax	;@069DA
	jne	@@5	;@069DB
	cmp	ax, word ptr ds:[65Eh]	;@069DD
	je	@@2	;@069E1
	jmp	@@1	;@069E3
@@3:	push	word ptr ds:[0AC8h]	;@069E5
	push	word ptr ds:[65Ch]	;@069E9
	push	ds	;@069ED
	mov	ax, 0ABCh	;@069EE
	push	ax	;@069F1
	push	ds	;@069F2
	mov	ax, 0AC0h	;@069F3
	push	ax	;@069F6
	db	0E8h, 3Bh, 1	; call L06B35	;@069F7
	mov	bx, ax	;@069FA
	or	bx, dx	;@069FC
	jne	@@6	;@069FE
@@4:	mov	ax, word ptr ds:[65Eh]	;@06A00
	push	ax	;@06A03
	call	@@8	;@06A04
	pop	ax	;@06A07
	jne	@@5	;@06A08
	cmp	ax, word ptr ds:[65Eh]	;@06A0A
	je	@@3	;@06A0E
	jmp	@@1	;@06A10
@@5:	neg	word ptr ds:[0AA6h]	;@06A12
	mov	byte ptr ds:[0AA3h], 0	;@06A16
	jmp	short @@7	;@06A1B
@@6:	mov	word ptr ds:[0AA4h], ax	;@06A1D
	mov	word ptr ds:[0AA6h], dx	;@06A20
	mov	ax, word ptr ds:[0ABCh]	;@06A24
	cmp	ax, word ptr ds:[65Ch]	;@06A27
	jne	@@4	;@06A2B
	mov	ax, word ptr ds:[0ABEh]	;@06A2D
	cmp	ax, word ptr ds:[65Eh]	;@06A30
	jne	@@4	;@06A34
@@7:	mov	ah, 51h	;@06A36
	int	21h	;@06A38
	mov	word ptr ds:[688h], bx	;@06A3A
	mov	bx, word ptr ds:[68Ah]	;@06A3E
	mov	ah, 50h	;@06A42
	int	21h	;@06A44
	call	L068F3	;@06A46
	call	L0688A	;@06A49
	sti	;@06A4C
	neg	word ptr ds:[0AA4h]	;@06A4D
	jmp	L05DD4	;@06A51
@@8:	mov	di, word ptr ds:[65Ch]	;@06A54
	mov	es, word ptr ds:[65Eh]	;@06A58
	cmp	word ptr es:[di], 21CDh	;@06A5C
	je	@@11	;@06A61
	cmp	word ptr es:[di], 13CDh	;@06A63
	je	@@11	;@06A68
	cmp	word ptr es:[di], 10CDh	;@06A6A
	je	@@11	;@06A6F
	push	word ptr ds:[0AA0h]	;@06A71
	mov	word ptr ds:[0AA0h], 1	;@06A75
	call	L066FA	;@06A7B
	pop	word ptr ds:[0AA0h]	;@06A7E
	cmp	word ptr ds:[65Ch], 1FBh	;@06A82
	je	@@10	;@06A88
@@9:	test	byte ptr ds:[0AA3h], 1	;@06A8A
	ret	;@06A8F
@@10:	mov	bx, cs	;@06A90
	cmp	bx, word ptr ds:[65Eh]	;@06A92
	jne	@@9	;@06A96
	push	word ptr ds:[0AA0h]	;@06A98
	mov	word ptr ds:[0AA0h], 1	;@06A9C
	push	cs	;@06AA2
	call	L0692F	;@06AA3
	pop	word ptr ds:[0AA0h]	;@06AA6
	jmp	@@9	;@06AAA
@@11:	mov	word ptr ds:[0A9Eh], 1	;@06AAC
	inc	di	;@06AB2
	inc	di	;@06AB3
	mov	al, byte ptr es:[di]	;@06AB4
	mov	byte ptr es:[di], 0CCh	;@06AB7
	push	ax	;@06ABB
@@12:	push	es	;@06ABC
	push	di	;@06ABD
	push	word ptr ds:[0AA0h]	;@06ABE
	mov	word ptr ds:[0AA0h], 3	;@06AC2
	push	cs	;@06AC8
	call	L0692F	;@06AC9
	pop	word ptr ds:[0AA0h]	;@06ACC
	pop	di	;@06AD0
	pop	es	;@06AD1
	mov	dx, es	;@06AD2
	cmp	dx, word ptr ds:[65Eh]	;@06AD4
	jne	@@12	;@06AD8
	cmp	di, word ptr ds:[65Ch]	;@06ADA
	jne	@@12	;@06ADE
	pop	ax	;@06AE0
	mov	byte ptr es:[di], al	;@06AE1
	mov	word ptr ds:[0A9Eh], 0	;@06AE4
	test	byte ptr ds:[0AA3h], 1	;@06AEA
	ret	;@06AEF
L06AF0:	mov	si, 4	;@06AF0
	mov	di, 1Ch	;@06AF3
	mov	ax, 197h	;@06AF6
	push	ds	;@06AF9
	xor	bx, bx	;@06AFA
	mov	ds, bx	;@06AFC
	db	0BAh	;@06AFE
	dw	S6BE
	db	8Eh, 0C2h	; mov es, dx	;@06B01
	movsw	;@06B03
	movsw	;@06B04
	pop	ds	;@06B05
	mov	es, bx	;@06B06
	lea	di, [si-4]	;@06B08
	cli	;@06B0B
	stosw	;@06B0C
	mov	ax, S6BE	;@06B0D
	stosw	;@06B10
	sti	;@06B11
	push	ds	;@06B12
	pop	es	;@06B13
	ret	;@06B14
L06B15:	mov	di, 4	;@06B15
	mov	si, 1Ch	;@06B18
	mov	ax, 197h	;@06B1B
	push	ds	;@06B1E
	xor	bx, bx	;@06B1F
	mov	es, bx	;@06B21
	cmp	ax, word ptr es:[di]	;@06B23
	jne	@@1	;@06B26
	mov	ax, S6BE	;@06B28
	mov	ds, ax	;@06B2B
	cli	;@06B2D
	movsw	;@06B2E
	movsw	;@06B2F
	sti	;@06B30
@@1:	pop	ds	;@06B31
	push	ds	;@06B32
	pop	es	;@06B33
	ret	;@06B34
L06B35:	push	bp	;@06B35
	mov	bp, sp	;@06B36
	push	ds	;@06B38
	pop	es	;@06B39
	mov	di, 400h	;@06B3A
	mov	ax, word ptr [bp+0Ch]	;@06B3D
	mov	word ptr [di], ax	;@06B40
	mov	ax, word ptr [bp+0Eh]	;@06B42
	call	L06BB2	;@06B45
	mov	word ptr [di+0Ch], ax	;@06B48
	mov	word ptr [di+4], 1	;@06B4B
	call	far ptr L04349	;@06B50
	les	bx, dword ptr [bp+4]	;@06B55
	mov	ax, word ptr [di+8]	;@06B58
	mov	word ptr es:[bx], ax	;@06B5B
	les	bx, dword ptr [bp+8]	;@06B5E
	mov	ax, word ptr [di+18h]	;@06B61
	mov	word ptr es:[bx+2], ax	;@06B64
	mov	ax, word ptr [di+1Ch]	;@06B68
	mov	word ptr es:[bx], ax	;@06B6B
	mov	ax, word ptr [di]	;@06B6E
	mov	dx, word ptr [di+0Ch]	;@06B70
	pop	bp	;@06B73
	ret	0Ch	;@06B74
	db	1Eh, 7, 0BFh, 0, 4, 0C7h, 45h, 4, 2, 0, 9Ah	;@06B77
	dd	L04349
	db	0C3h
L06B87:	push	ds	;@06B87
	pop	es	;@06B88
	mov	di, 400h	;@06B89
	mov	word ptr [di+4], 3	;@06B8C
	mov	word ptr [di], ax	;@06B91
	call	far ptr L04349	;@06B93
	mov	ax, word ptr [di]	;@06B98
	ret	;@06B9A
	db	1Eh, 7, 0BFh, 0, 4, 0C7h, 45h, 4, 4, 0, 89h, 5, 89h, 55h, 0Ch, 9Ah	;@06B9B
	dd	L04349
	db	8Bh, 5, 0C3h
L06BB2:	cmp	byte ptr ds:[0ADFh], 0	;@06BB2
	je	@@1	;@06BB7
	push	si	;@06BB9
	push	di	;@06BBA
	push	ax	;@06BBB
	call	dword ptr ds:[0AE0h]	;@06BBC
	pop	bx	;@06BC0
	pop	di	;@06BC1
	pop	si	;@06BC2
	and	ax, ax	;@06BC3
	jne	@@1	;@06BC5
	xchg	ax, bx	;@06BC7
@@1:	ret	;@06BC8
L06BC9:	mov	si, 0Eh	;@06BC9
	push	ds	;@06BCC
	pop	es	;@06BCD
	mov	di, 400h	;@06BCE
	mov	cx, 19h	;@06BD1
	rep movsw	;@06BD4
	push	ds	;@06BD6
	pop	es	;@06BD7
	mov	di, 400h	;@06BD8
	mov	word ptr [di+4], 5	;@06BDB
	call	far ptr L04349	;@06BE0
	retf	;@06BE5
S5AD	ends

S6BE	segment byte public 'CODE'
	assume	cs:S6BE
S6BE_START	dw	S32C	;@06BE6
	db	24h, 2Ah, 24h, 2Ah, 24h, 2Ah, 0, 1, 0, 2, 44h, 45h, 42h, 55h, 47h, 0
	db	5, 0, 4, 0, 0, 0, 0, 0, 97h, 1, 0Ch, 0, 0, 0, 0, 0
	db	0A6h, 1, 24h, 0, 0, 0, 0, 0, 0FBh, 1, 40h, 0, 0, 0, 0, 0
	db	0B6h, 2, 4Ch, 0, 0, 0, 0, 0, 0A3h, 2, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 26h, 81h, 3Eh, 0, 0, 0CDh, 3Fh, 75h, 0Dh, 26h, 83h, 3Eh, 10h
	db	0, 0, 74h, 7, 26h, 8Eh, 6, 10h, 0, 0F8h, 0CBh, 0F9h, 0CBh
L06C45:	push	bp	;@06C45
	mov	bp, sp	;@06C46
	push	si	;@06C48
	push	di	;@06C49
	push	ds	;@06C4A
	mov	ds, word ptr ds:[0A9Ch]	;@06C4B
	mov	ax, word ptr [bp+6]	;@06C4F
	mov	ax, word ptr ds:[658h]	;@06C52
	mov	word ptr ds:[688h], ax	;@06C55
	or	word ptr ds:[660h], 200h	;@06C58
	mov	es, ax	;@06C5E
	mov	es, word ptr es:[16h]	;@06C60
	les	si, dword ptr es:[2Eh]	;@06C65
	mov	word ptr ds:[0ACAh], si	;@06C6A
	mov	word ptr ds:[0ACCh], es	;@06C6E
	mov	word ptr ds:[0AC8h], 0FFFFh	;@06C72
	mov	word ptr ds:[0A92h], 0	;@06C78
	mov	es, word ptr ds:[0A9Ch]	;@06C7E
	xor	ax, ax	;@06C82
	mov	ds, ax	;@06C84
	xor	si, si	;@06C86
	mov	di, 68Ch	;@06C88
	mov	cx, 200h	;@06C8B
	rep movsw	;@06C8E
	push	word ptr ds:[6Eh]	;@06C90
	push	word ptr ds:[6Ch]	;@06C94
	mov	ax, S6BE	;@06C98
	mov	ds, ax	;@06C9B
	pop	word ptr ds:[44h]	;@06C9D
	pop	word ptr ds:[42h]	;@06CA1
	mov	di, 710h	;@06CA5
	mov	ax, word ptr es:[di]	;@06CA8
	mov	word ptr ds:[46h], ax	;@06CAB
	mov	ax, word ptr es:[di+2]	;@06CAE
	mov	word ptr ds:[48h], ax	;@06CB2
	mov	ax, 2C9h	;@06CB5
	stosw	;@06CB8
	mov	ax, S6BE	;@06CB9
	stosw	;@06CBC
	pop	ds	;@06CBD
	pop	di	;@06CBE
	pop	si	;@06CBF
	pop	bp	;@06CC0
	retf	2	;@06CC1
	db	1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 23h, 0C0h, 74h, 0Eh, 3Dh, 1, 0, 74h, 0Bh, 0F6h	;@06CC4
	db	6, 0A3h, 0Ah, 80h, 74h, 4, 1Fh, 0CBh, 0EBh, 74h, 8Ch, 6, 9Ah, 0Ah, 53h, 50h
	db	8Ch, 0C2h, 0Eh, 0E8h, 41h, 0FFh, 5Bh, 8Bh, 0Eh, 94h, 0Ah, 0E3h, 2Dh, 1Eh, 0C5h, 36h
	db	96h, 0Ah, 3Bh, 54h, 2, 75h, 1Dh, 8Bh, 3Ch, 83h, 0FBh, 1, 74h, 0Ch, 26h, 8Ah
	db	5, 88h, 44h, 4, 26h, 0C6h, 5, 0CCh, 0EBh, 0Ah, 26h, 80h, 3Dh, 0CCh, 75h, 4
	db	8Ah, 44h, 4, 0AAh, 83h, 0C6h, 6, 0E2h, 0D9h, 1Fh, 8Bh, 0Eh, 0F4h, 0Ah, 0E3h, 2Dh
	db	1Eh, 0C5h, 36h, 0ECh, 0Ah, 3Bh, 54h, 2, 75h, 1Dh, 8Bh, 3Ch, 83h, 0FBh, 1, 74h
	db	0Ch, 26h, 8Ah, 5, 88h, 44h, 4, 26h, 0C6h, 5, 0CCh, 0EBh, 0Ah, 26h, 80h, 3Dh
	db	0CCh, 75h, 4, 8Ah, 44h, 4, 0AAh, 83h, 0C6h, 6, 0E2h, 0D9h, 1Fh, 5Bh, 83h, 3Eh
	db	92h, 0Ah, 0, 74h, 18h, 83h, 0FBh, 0FFh, 74h, 13h, 8Bh, 0FBh, 26h, 8Ah, 1Dh, 32h
	db	0FFh, 26h, 0C6h, 5, 0CCh, 89h, 3Eh, 8Eh, 0Ah, 8Ch, 6, 90h, 0Ah, 89h, 1Eh, 8Ch
	db	0Ah, 1Fh, 0CBh, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 83h, 3Eh, 0A0h, 0Ah, 1, 74h, 11h
	db	1Fh, 0CFh, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 83h, 3Eh, 0A0h, 0Ah, 3, 74h, 2, 1Fh
	db	0CFh, 53h, 0BBh, 4Ah, 6, 89h, 7, 8Fh, 47h, 2, 89h, 4Fh, 4, 89h, 57h, 6
	db	89h, 77h, 0Ah, 89h, 7Fh, 0Ch, 89h, 6Fh, 8, 8Fh, 47h, 0Eh, 8Ch, 47h, 10h, 8Fh
	db	47h, 12h, 8Fh, 47h, 14h, 8Fh, 47h, 16h, 8Ch, 57h, 1Ah, 89h, 67h, 18h, 0FAh, 8Eh
	db	16h, 5Ah, 0Dh, 8Bh, 26h, 58h, 0Dh, 0FBh, 8Bh, 2Eh, 5Ch, 0Dh, 81h, 67h, 16h, 0FFh
	db	0FEh, 0FFh, 0Eh, 5Ch, 6, 0FCh, 0CBh, 1Eh, 57h, 33h, 0FFh, 8Eh, 0DFh, 0BFh, 6Ch, 0
	db	0FFh, 35h, 0FFh, 75h, 2, 0FAh, 0C7h, 5, 49h, 2, 8Ch, 4Dh, 2, 9Ch, 2Eh, 0FFh
	db	1Eh, 2Ch, 0, 0FAh, 8Fh, 45h, 2, 8Fh, 5, 2Eh, 80h, 3Eh, 4Ah, 0, 0, 74h
	db	15h, 80h, 26h, 71h, 4, 7Fh, 2Eh, 0C6h, 6, 4Ah, 0, 0, 50h, 53h, 56h, 32h
	db	0E4h, 0CDh, 16h, 5Eh, 5Bh, 58h, 5Fh, 2Eh, 8Eh, 1Eh, 6, 0, 0F6h, 6, 0A3h, 0Ah
	db	1, 75h, 33h, 1Fh, 0CFh, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 80h, 0Eh, 0A3h, 0Ah, 1
	db	0F6h, 6, 0A3h, 0Ah, 82h, 75h, 14h, 2Eh, 0C6h, 6, 4Ah, 0, 1, 0C7h, 6, 0A4h
	db	0Ah, 1, 0, 0C7h, 6, 0A6h, 0Ah, 0, 0, 1Fh, 0CFh, 80h, 0Eh, 0A3h, 0Ah, 80h
	db	1Fh, 2Eh, 0FFh, 2Eh, 42h, 0, 80h, 0Eh, 0A3h, 0Ah, 2, 83h, 3Eh, 9Eh, 0Ah, 0
	db	75h, 0C1h, 53h, 0F6h, 6, 0A3h, 0Ah, 80h, 75h, 10h, 83h, 3Eh, 6Ah, 6, 0, 75h
	db	9, 0C6h, 6, 0A3h, 0Ah, 82h, 5Bh, 90h, 0EBh, 0A9h, 0EAh
	dd	L0696A
	db	1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 0FFh, 6, 9Eh, 0Ah, 1Fh, 9Ch, 2Eh, 0FFh, 1Eh, 3Ch
	db	0, 0EBh, 38h, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 0FFh, 6, 9Eh, 0Ah, 1Fh, 9Ch, 2Eh
	db	0FFh, 1Eh, 34h, 0, 0EBh, 25h, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 80h, 3Eh, 0A2h, 0Ah
	db	0, 75h, 3Bh, 0FFh, 6, 9Eh, 0Ah, 80h, 0FCh, 4Bh, 74h, 38h, 1Fh, 55h, 8Bh, 0ECh
	db	0FFh, 76h, 6, 9Dh, 5Dh, 9Ch, 2Eh, 0FFh, 1Eh, 46h, 0, 55h, 8Bh, 0ECh, 50h, 9Ch
	db	58h, 81h, 66h, 6, 0, 2, 9, 46h, 6, 58h, 5Dh, 1Eh, 2Eh, 8Eh, 1Eh, 6
	db	0, 0FFh, 0Eh, 9Eh, 0Ah, 0F6h, 6, 0A3h, 0Ah, 1, 75h, 22h, 1Fh, 0CFh, 1Fh, 2Eh
	db	0FFh, 2Eh, 46h, 0, 0FEh, 6, 0A2h, 0Ah, 1Fh, 9Ch, 2Eh, 0FFh, 1Eh, 46h, 0, 1Eh
	db	2Eh, 8Eh, 1Eh, 6, 0, 9Ch, 0FEh, 0Eh, 0A2h, 0Ah, 9Dh, 1Fh, 0EBh, 0BDh, 83h, 3Eh
	db	9Eh, 0Ah, 0, 75h, 0D7h, 0E9h, 4Bh, 0FFh, 0, 0, 0, 0, 0
S6BE	ends

S736	segment para public 'CODE'
	assume	cs:S736
S736a_START	db	0, 10h, 1, 10h, 0, 0	;@07360
	dw	S5AD
S736	ends
	end
