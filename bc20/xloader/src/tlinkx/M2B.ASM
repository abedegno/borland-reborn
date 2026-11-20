	.286p
	locals
	public	S2F4_START
	public	L05757
	public	L06079
	public	L06849
	public	S686_START
	public	L068C5
	public	S6FEa_START
	extrn	L03FCD:far
	extrn	L04F7B:far
	extrn	L04F9E:far
	extrn	S6BA_START:byte

S2F4	segment byte public 'CODE'
	assume	cs:S2F4
S2F4_START	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@02F46
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
	db	0, 0, 0, 0, 4Eh, 6
	dw	S2F4
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
	dw	S2F4
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
	db	0Fh, 0, 60h, 0, 0AEh, 0, 0BCh, 0, 0C5h, 0, 0CBh, 0, 0D8h, 0, 0, 0
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
S2F4	ends

S575	segment para public 'CODE'
	assume	cs:S575
	db	0D1h, 0E3h, 0FFh, 97h, 0DEh, 0Ah, 0CBh	;@05750
L05757:	mov	ax, S2F4	;@05757
	push	ax	;@0575A
	mov	ax, 64Eh	;@0575B
	push	ax	;@0575E
	mov	ax, 1Ch	;@0575F
	push	ax	;@05762
	xor	ax, ax	;@05763
	push	ax	;@05765
	push	word ptr ds:[0F10h]	;@05766
	push	word ptr ds:[0F12h]	;@0576A
	push	word ptr ds:[0Ah]	;@0576E
	call	far ptr L04F9E	;@05772
	add	sp, 0Eh	;@05777
	retf	;@0577A
	db	0BEh, 12h, 0, 1Eh, 7, 0BFh, 0, 4, 0B9h, 19h, 0, 0F3h, 0A5h, 0BEh, 12h, 0	;@0577B
	db	0B8h
	dw	seg S6BA_START
	db	50h, 0B8h, 0, 0, 50h, 0B8h, 6, 0, 0F7h, 64h, 8, 50h, 33h, 0C0h, 50h, 0FFh
	db	74h, 1Ch, 0FFh, 74h, 2Ch, 0FFh, 36h, 0Ah, 0, 9Ah
	dd	L04F7B
	db	83h, 0C4h, 0Eh, 0BEh, 12h, 0, 0FFh, 74h, 8, 0B8h
	dw	seg S6BA_START
	db	50h, 0B8h, 0, 0, 50h, 0FFh, 34h, 0Eh, 0E8h, 2Ah, 0, 90h, 0A3h, 12h, 0, 0C7h
	db	6, 16h, 0, 0, 0, 89h, 0Eh, 1Ah, 0, 89h, 16h, 1Eh, 0, 0Eh, 0E8h, 7Eh
	db	0FFh, 0C3h, 0A1h, 12h, 0, 0A3h, 0E4h, 0Ah, 0A1h, 1Eh, 0, 0A3h, 0E6h, 0Ah, 0A1h, 1Ah
	db	0, 0A2h, 0E3h, 0Ah, 0C3h, 55h, 8Bh, 0ECh, 56h, 57h, 0FCh, 0A1h, 0A0h, 0Ah, 8Eh, 0D8h
	db	8Eh, 0C0h, 8Ch, 16h, 0CAh, 0Ah, 89h, 26h, 0C8h, 0Ah, 89h, 2Eh, 0C6h, 0Ah, 0BBh
	dw	S2F4
	db	8Eh, 0C3h, 33h, 0C0h, 40h, 26h, 2Ah, 6, 0E2h, 0Ah, 0A3h, 6Eh, 6, 8Bh, 0D0h, 0Bh
	db	0C0h, 74h, 1Dh, 0A1h, 0CCh, 0Ah, 3Dh, 0FFh, 0FFh, 75h, 3, 0A1h, 62h, 6, 50h, 0FFh
	db	36h, 60h, 6, 1Eh, 0B8h, 0C0h, 0Ah, 50h, 1Eh, 0B8h, 0C4h, 0Ah, 50h, 0E8h, 7Ch, 0Fh
	db	0A3h, 0A8h, 0Ah, 89h, 16h, 0AAh, 0Ah, 0Bh, 0C2h, 75h, 15h, 0E8h, 8Eh, 8, 0C7h, 46h
	db	6, 2, 0, 83h, 3Eh, 6Eh, 6, 0, 74h, 3, 0E8h, 0A1h, 0Fh, 0EBh, 65h, 90h
	db	0E8h, 56h, 8, 0E8h, 76h, 8, 8Ch, 0D8h, 8Eh, 0C0h, 0BFh, 4Eh, 4, 0B9h, 0, 1
	db	8Ch, 0D8h, 0BBh, 4Eh, 5, 0BAh, 0, 1, 0E8h, 8, 2, 83h, 7Eh, 6, 2, 74h
	db	0D9h, 0A1h, 0ACh, 0Ah, 3, 6, 0B0h, 0Ah, 0A3h, 0B2h, 0Ah, 0C4h, 1Eh, 0ACh, 0Ah, 8Bh
	db	16h, 0CCh, 0Ah, 8Bh, 0Eh, 0B0h, 0Ah, 8Bh, 36h, 60h, 6, 8Bh, 46h, 6, 0E8h, 19h
	db	2, 73h, 13h, 0E8h, 0D8h, 8, 8Bh, 26h, 0C8h, 0Ah, 8Bh, 2Eh, 0C6h, 0Ah, 33h, 0C0h
	db	0BAh, 0FFh, 0FFh, 0E9h, 0ACh, 1, 8Bh, 3Eh, 0B2h, 0Ah, 8Eh, 6, 0CCh, 0Ah, 0B0h, 6
	db	90h, 0E8h, 8Ah, 4, 83h, 3Eh, 0BAh, 0Ah, 0, 74h, 10h, 0C4h, 3Eh, 0ACh, 0Ah, 26h
	db	80h, 3Dh, 0CCh, 74h, 6, 0E8h, 60h, 0Ah, 0E8h, 91h, 1, 0C7h, 6, 0A2h, 0Ah, 0
	db	0, 0C6h, 6, 0A7h, 0Ah, 0, 0C6h, 6, 0A6h, 0Ah, 0, 0A1h, 60h, 6, 0A3h, 0D6h
	db	0Ah, 0A1h, 62h, 6, 0A3h, 0D8h, 0Ah, 0C7h, 6, 0DAh, 0Ah, 0, 0, 0E8h, 0C5h, 0Bh
	db	0Eh, 0E8h, 0B2h, 0Ch, 90h, 0E8h, 0EBh, 0Bh, 0A1h, 60h, 6, 8Bh, 16h, 62h, 6, 8Bh
	db	4Eh, 0Ch, 0E3h, 2Ch, 0C4h, 7Eh, 8, 26h, 80h, 7Dh, 5, 0, 74h, 1Dh, 26h, 3Bh
	db	5, 75h, 18h, 6, 26h, 8Eh, 45h, 2, 8Ch, 6, 9Eh, 0Ah, 0E8h, 0FDh, 3, 8Ch
	db	0C3h, 7, 72h, 7, 3Bh, 0D3h, 75h, 3, 0E9h, 87h, 0, 83h, 0C7h, 6, 0E2h, 0D7h
	db	0E8h, 4Eh, 5, 73h, 78h, 0B9h, 1, 0, 0A1h, 60h, 6, 3Bh, 6, 0D6h, 0Ah, 75h
	db	1Ah, 0A1h, 62h, 6, 3Bh, 6, 0D8h, 0Ah, 75h, 11h, 0C7h, 6, 0D6h, 0Ah, 0FFh, 0FFh
	db	0FFh, 6, 60h, 6, 49h, 83h, 7Eh, 6, 2, 74h, 4Fh, 0C7h, 6, 0D6h, 0Ah, 0FFh
	db	0FFh, 83h, 3Eh, 6Eh, 6, 0, 74h, 3Eh, 51h, 0FFh, 36h, 62h, 6, 0FFh, 36h, 60h
	db	6, 1Eh, 0B8h, 0C0h, 0Ah, 50h, 1Eh, 0B8h, 0C4h, 0Ah, 50h, 0E8h, 2Eh, 0Eh, 59h, 8Bh
	db	0D8h, 0Bh, 0DAh, 74h, 21h, 51h, 0A3h, 0A8h, 0Ah, 89h, 16h, 0AAh, 0Ah, 0E8h, 19h, 7
	db	59h, 0A1h, 0ACh, 0Ah, 3Bh, 6, 60h, 6, 75h, 0Ch, 0A1h, 0AEh, 0Ah, 3Bh, 6, 62h
	db	6, 75h, 3, 0E9h, 9Fh, 0, 1, 0Eh, 60h, 6, 0E9h, 1Eh, 0FFh, 74h, 0FBh, 0EBh
	db	75h, 90h, 89h, 3Eh, 0DCh, 0Ah, 33h, 0C0h, 26h, 0F6h, 45h, 5, 2, 75h, 6, 8Bh
	db	46h, 0Ch, 2Bh, 0C1h, 40h, 0A3h, 0DAh, 0Ah, 0FFh, 36h, 9Eh, 0Ah, 0FFh, 36h, 60h, 6
	db	1Eh, 0B8h, 0C0h, 0Ah, 50h, 1Eh, 0B8h, 0C4h, 0Ah, 50h, 0E8h, 0CFh, 0Dh, 0A3h, 0A8h, 0Ah
	db	89h, 16h, 0AAh, 0Ah, 83h, 3Eh, 0DAh, 0Ah, 0, 74h, 42h, 8Bh, 16h, 9Eh, 0Ah, 0A1h
	db	60h, 6, 0E8h, 1Dh, 0Eh, 0FCh, 23h, 0C0h, 75h, 33h, 8Bh, 3Eh, 0DCh, 0Ah, 8Eh, 46h
	db	0Ah, 26h, 0FFh, 75h, 4, 26h, 0C4h, 3Dh, 0E8h, 11h, 3, 58h, 26h, 88h, 5, 0E8h
	db	16h, 9, 8Bh, 3Eh, 0DCh, 0Ah, 8Eh, 46h, 0Ah, 26h, 0C4h, 3Dh, 0E8h, 0FDh, 2, 26h
	db	0C6h, 5, 0CCh, 0E9h, 0C1h, 0FEh, 0A3h, 0A8h, 0Ah, 89h, 16h, 0AAh, 0Ah, 0E8h, 79h, 6
	db	0A1h, 0ACh, 0Ah, 3Bh, 6, 60h, 6, 75h, 9, 0A1h, 0AEh, 0Ah, 3Bh, 6, 62h, 6
	db	74h, 3, 0E9h, 11h, 0FEh, 0E8h, 26h, 7, 0E8h, 7Fh, 3
L05A54:	mov	ax, word ptr ds:[0AA8h]	;@05A54
	mov	dx, word ptr ds:[0AAAh]	;@05A57
L05A5B:	mov	cx, word ptr ds:[0ADAh]	;@05A5B
	pop	di	;@05A5F
	pop	si	;@05A60
	pop	bp	;@05A61
	retf	8	;@05A62
	db	0C4h, 3Eh, 0ACh, 0Ah, 26h, 8Ah, 5, 26h, 0C6h, 5, 0CCh, 0C4h, 3Eh	;@05A65
	db	0BCh, 0Ah, 0AAh, 0C7h, 6, 0BAh, 0Ah, 0, 0, 0C3h, 0A3h, 0F2h, 0Ah
	db	89h, 1Eh, 0F0h, 0Ah, 89h, 1Eh, 0F4h, 0Ah, 0C7h, 6, 0F8h, 0Ah, 0
	db	0, 3, 0DAh, 89h, 1Eh, 0F6h, 0Ah, 89h, 3Eh, 0EAh, 0Ah, 8Ch, 6, 0ECh
	db	0Ah, 8Bh, 0C1h, 0D1h, 0E0h, 0D1h, 0E0h, 0D1h, 0E0h, 0A3h, 0EEh
	db	0Ah, 0D1h, 0E9h, 33h, 0C0h, 0F3h, 0ABh, 0A3h, 20h, 0Bh, 0A2h, 0E8h
	db	0Ah, 0C3h, 3Bh, 0Eh, 0EEh, 0Ah, 76h, 3, 0E9h, 34h, 1, 0A3h, 6
	db	0Bh, 89h, 1Eh, 0FCh, 0Ah, 8Ch, 6, 0FEh, 0Ah, 89h, 16h, 0, 0Bh
	db	3, 0CBh, 89h, 0Eh, 2, 0Bh, 0C7h, 6, 1Eh, 0Bh, 0, 0, 0C6h, 6, 0E9h
	db	0Ah, 0FFh, 0A1h, 0F6h, 0Ah, 0A3h, 0FAh, 0Ah, 89h, 36h, 4, 0Bh
	db	0E8h, 1Ch, 2, 89h, 1Eh, 0Ch, 0Bh, 89h, 16h, 0Eh, 0Bh, 89h, 0Eh
	db	10h, 0Bh, 8Bh, 36h, 0Ch, 0Bh, 8Eh, 6, 0ECh, 0Ah, 0A1h, 0Eh, 0Bh
	db	26h, 85h, 4, 75h, 6Ch, 8Bh, 3Eh, 4, 0Bh, 8Eh, 6, 0FEh, 0Ah, 0E8h
	db	91h, 6, 89h, 0Eh, 14h, 0Bh, 89h, 3Eh, 16h, 0Bh, 8Ch, 6, 18h, 0Bh
	db	0A3h, 12h, 0Bh, 8Bh, 36h, 0Ch, 0Bh, 8Eh, 6, 0ECh, 0Ah, 0A1h, 0Eh
	db	0Bh, 8Bh, 16h, 10h, 0Bh, 26h, 9, 4, 0D1h, 0E0h, 4Ah, 75h, 0Eh
	db	0B8h, 1, 0, 0BAh, 10h, 0, 83h, 0C6h, 2, 83h, 6, 0Ch, 0Bh, 2, 0E2h
	db	0E8h, 0A3h, 0Eh, 0Bh, 89h, 16h, 10h, 0Bh, 0A1h, 12h, 0Bh, 3Dh
	db	5, 0, 74h, 3Dh, 0C7h, 6, 1Eh, 0Bh, 0, 0, 23h, 0C0h, 75h, 33h, 0A1h
	db	14h, 0Bh, 1, 6, 4, 0Bh, 0A1h, 4, 0Bh, 3Bh, 6, 2, 0Bh, 73h, 2, 0EBh
	db	84h, 8Bh, 36h, 0FAh, 0Ah, 3Bh, 36h, 0F6h, 0Ah, 74h, 15h, 8Eh, 6
	db	0ECh, 0Ah, 26h, 8Bh, 34h, 83h, 6, 0FAh, 0Ah, 2, 0C7h, 6, 1Eh, 0Bh
	db	0, 0, 0E9h, 52h, 0FFh, 0F8h, 0C3h, 8Bh, 0D8h, 83h, 0E3h, 7Fh, 0D1h
	db	0E3h, 0FFh, 0A7h, 20h, 0Bh, 0B0h, 5, 0E8h, 9Dh, 1, 0EBh, 0BBh
	db	0A9h, 80h, 0, 74h, 4Ch, 0B0h, 8, 0E8h, 91h, 1, 0EBh, 0C1h, 83h
	db	3Eh, 12h, 0Bh, 3, 74h, 7, 8Bh, 36h, 16h, 0Bh, 0E9h, 24h, 0FFh
	db	8Bh, 36h, 16h, 0Bh, 0E8h, 40h, 1, 8Eh, 6, 0ECh, 0Ah, 26h, 85h
	db	17h, 75h, 1Fh, 8Bh, 1Eh, 0Ch, 0Bh, 0A1h, 0Eh, 0Bh, 26h, 23h, 7
	db	75h, 0DDh, 83h, 2Eh, 0FAh, 0Ah, 2, 8Bh, 3Eh, 0FAh, 0Ah, 3Bh, 3Eh
	db	0F4h, 0Ah, 72h, 7, 0A1h, 16h, 0Bh, 0ABh, 0E9h, 6Fh, 0FFh, 0E8h
	db	0E0h, 1, 0F9h, 0C3h, 0A1h, 18h, 0Bh, 3Bh, 6, 0FEh, 0Ah, 75h, 17h
	db	0A1h, 0, 0Bh, 0A3h, 18h, 0Bh, 0A1h, 16h, 0Bh, 3Bh, 6, 0FCh, 0Ah
	db	72h, 8, 't5;', 6, 2, 0Bh, 72h, 9Bh, 0FFh, 36h, 18h, 0Bh, 0FFh
	db	36h, 16h, 0Bh, 1Eh, 0B8h, 1Ah, 0Bh, 50h, 1Eh, 0B8h, 0C4h, 0Ah
	db	50h, 0E8h, 8Bh, 0Bh, 0Bh, 0C2h, 75h, 3, 0E9h, 78h, 0FFh, 0B0h
	db	6, 0C4h, 3Eh, 16h, 0Bh, 0E8h, 0Dh, 1, 83h, 3Eh, 12h, 0Bh, 3, 74h
	db	4Fh, 0E9h, 2Dh, 0FFh, 0B0h, 9, 0C4h, 3Eh, 16h, 0Bh, 0E8h, 0FAh
	db	0, 0C6h, 6, 0E8h, 0Ah, 1, 0A1h, 60h, 6, 3Bh, 6, 0ACh, 0Ah, 75h
	db	0Dh, 0A1h, 62h, 6, 3Bh, 6, 0AEh, 0Ah, 75h, 4, 0FEh, 0Eh, 0E8h
	db	0Ah, 0E9h, 45h, 0FFh, 83h, 3Eh, 1Eh, 0Bh, 0, 75h, 0Bh, 0C7h, 6
	db	1Eh, 0Bh, 1, 0, 0B0h, 4, 0E8h, 0C2h, 0, 0E9h, 0DFh, 0FEh, 83h
	db	7Eh, 6, 0, 75h, 5Fh, 0A9h, 80h, 0, 74h, 8, 0B0h, 7, 0E8h, 0AFh
	db	0, 0E9h, 0CCh, 0FEh, 0C4h, 3Eh, 16h, 0Bh, 26h, 81h, 3Eh, 0, 0
	db	0CDh, 3Fh, 75h, 11h, 26h, 8Bh, 45h, 1, 26h, 80h, 3Dh, 0EAh, 74h
	db	4, 26h, 8Bh, 45h, 2, 0A3h, 16h, 0Bh, 0A1h, 18h, 0Bh, 3Bh, 6, 0FEh
	db	0Ah, 75h, 6, 0A1h, 0, 0Bh, 0A3h, 18h, 0Bh, 0FFh, 36h, 18h, 0Bh
	db	0FFh, 36h, 16h, 0Bh, 1Eh, 0B8h, 1Ah, 0Bh, 50h, 1Eh, 0B8h, 0C4h
	db	0Ah, 50h, 0E8h, 0E0h, 0Ah, 0Bh, 0C2h, 74h, 0Ch, 0B0h, 6, 0C4h
	db	3Eh, 1Ah, 0Bh, 0E8h, 65h, 0, 0E9h, 7Ah, 0FEh, 0B0h, 3, 0E8h, 55h
	db	0, 0E9h, 72h, 0FEh, 0B0h, 0, 0E8h, 4Dh, 0, 0E9h, 6Ah, 0FEh, 0B0h
	db	1, 0E8h, 45h, 0, 0E9h, 62h, 0FEh, 0B0h, 2, 0E8h, 3Dh, 0, 0E9h
	db	5Ah, 0FEh, 2Bh, 36h, 0FCh, 0Ah, 8Bh, 0DEh, 0B1h, 4, 0D3h, 0EBh
	db	0D1h, 0E3h, 3, 1Eh, 0EAh, 0Ah, 83h, 0E6h, 0Fh, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Bh, 94h, 32h, 0Bh, 8Bh, 8Ch, 34h, 0Bh, 0C3h
L05D25:	cmp	word ptr es:[0], 3FCDh	;@05D25
	jne	@@1	;@05D2C
	cmp	word ptr es:[10h], 0	;@05D2E
	je	@@2	;@05D34
	mov	es, word ptr es:[10h]	;@05D36
@@1:	clc	;@05D3B
	ret	;@05D3C
@@2:	stc	;@05D3D
	ret	;@05D3E
	db	8Bh, 3Eh, 4, 0Bh, 8Eh, 6, 0FEh, 0Ah, 3Ch, 9, 75h, 15h, 83h, 3Eh	;@05D3F
	db	0BAh, 0Ah, 0, 74h, 0Eh, 3Bh, 3Eh, 0ACh, 0Ah, 75h, 8, 8Ch, 0C2h
	db	3Bh, 16h, 0AEh, 0Ah, 74h, 38h, 0E8h, 0A1h, 0, 74h, 34h, 8Bh, 1Eh
	db	0F4h, 0Ah, 8Dh, 57h, 6, 3Bh, 16h, 0FAh, 0Ah, 77h, 58h, 1Eh, 8Eh
	db	1Eh, 0F2h, 0Ah, 89h, 3Fh, 8Ch, 47h, 2, 88h, 47h, 5, 0E8h, 0A3h
	db	0FFh, 72h, 0Ah, 26h, 8Ah, 5, 88h, 47h, 4, 26h, 0C6h, 5, 0CCh, 1Fh
	db	83h, 6, 0F4h, 0Ah, 6, 0FFh, 6, 0F8h, 0Ah, 0C3h, 3Ch, 9, 75h, 0FBh
	db	8Bh, 0Eh, 0F8h, 0Ah, 0E3h, 0F5h, 1Eh, 0C5h, 36h, 0F0h, 0Ah, 8Ch
	db	0C2h, ';<u', 15h, 3Bh, 54h, 2, 75h, 10h, 8Ah, 44h, 5, 0C6h, 44h
	db	5, 9, 1Fh, 3Ch, 9, 74h, 0D9h, 0A2h, 0E9h, 0Ah, 0C3h, 83h, 0C6h
	db	6, 0E2h, 0E2h, 1Fh, 0C3h, 0E8h, 6, 0, 0E8h, 0A7h, 3, 0E9h, 0C9h
	db	0FAh
L05DD3:	mov	cx, word ptr ds:[0AF8h]	;@05DD3
	jcxz	@@3	;@05DD7
	push	ds	;@05DD9
	lds	si, dword ptr ds:[0AF0h]	;@05DDA
@@1:	les	di, dword ptr [si]	;@05DDE
	call	L05D25	;@05DE0
	jb	@@2	;@05DE3
	cmp	byte ptr es:[di], 0CCh	;@05DE5
	jne	@@2	;@05DE9
	mov	al, byte ptr [si+4]	;@05DEB
	mov	byte ptr es:[di], al	;@05DEE
@@2:	add	si, 6	;@05DF1
	loop	@@1	;@05DF4
	pop	ds	;@05DF6
	mov	ax, word ptr ds:[0AF0h]	;@05DF7
	mov	word ptr ds:[0AF4h], ax	;@05DFA
	mov	word ptr ds:[0AF8h], 0	;@05DFD
@@3:	ret	;@05E03
	db	6, 1Eh, 8Ch, 0C2h, 8Bh, 0Eh, 0F8h, 0Ah, 0E3h, 12h, 0C5h, 36h, 0F0h	;@05E04
	db	0Ah, ';<u', 5, 3Bh, 54h, 2, 74h, 2Ch, 83h, 0C6h, 6, 0E2h, 0F2h
	db	1Fh, 1Eh, 8Bh, 4Eh, 0Ch, 0E3h, 1Dh, 0C5h, 76h, 8, 80h, 7Ch, 5
	db	0, 74h, 0Fh, ';<u', 0Bh, 3Bh, 54h, 2, 75h, 6, 80h, 4Ch, 5, 2, 0EBh
	db	8, 83h, 0C6h, 6, 0E2h, 0E6h, 80h, 0C9h, 1, 1Fh, 7, 0C3h, 8Bh, 36h
	db	8, 0Bh, 8Eh, 6, 0F2h, 0Ah, 26h, 0C4h, 3Ch, 0E8h, 0CDh, 0FEh, 'r/&'
	db	80h, 3Dh, 0CCh, 75h, 29h, 8Ah, 44h, 4, 26h, 88h, 5, 0C7h, 6, 96h
	db	0Ah, 1, 0, 0E8h, 0C2h, 4, 0C7h, 6, 96h, 0Ah, 0, 0, 8Bh, 36h, 8
	db	0Bh, 8Eh, 6, 0F2h, 0Ah, 0C4h, 3Ch, 26h, 8Ah, 5, 88h, 44h, 4, 26h
	db	0C6h, 5, 0CCh, 0C3h, 8Bh, 0Eh, 0F8h, 0Ah, 0E3h, 17h, 8Bh, 3Eh
	db	0F0h, 0Ah, 8Eh, 6, 0F2h, 0Ah, 0A1h, 60h, 6, 8Bh, 16h, 62h, 6, 0AFh
	db	74h, 7, 83h, 0C7h, 4, 0E2h, 0F8h, 0F9h, 0C3h, 6, 26h, 8Eh, 5, 0E8h
	db	75h, 0FEh, 8Ch, 0C3h, 7, 72h, 0EDh, 3Bh, 0D3h, 75h, 0E9h, 26h
	db	8Bh, 5, 0A3h, 9Eh, 0Ah, 83h, 0EFh, 2, 89h, 3Eh, 8, 0Bh, 26h, 8Ah
	db	45h, 5, 98h, 0A3h, 0Ah, 0Bh, 8Bh, 0D8h, 3Ch, 9, 't!<', 7, 74h
	db	1Dh, 3Ch, 8, 74h, 19h, 1Eh, 6, 26h, 0C4h, 35h, 0E8h, 41h, 0FEh
	db	6, 1Fh, 7, 72h, 0Bh, 80h, 3Ch, 0CCh, 75h, 6, 26h, 8Ah, 45h, 4
	db	88h, 4, 1Fh, 0D1h, 0E3h, 0FFh, 0A7h, 72h, 0Bh, 0FEh, 6, 0E8h, 0Ah
	db	0A0h, 0E9h, 0Ah, 3Ch, 0FFh, 75h, 10h, 80h, 3Eh, 0E8h, 0Ah, 2, 74h
	db	6, 0E8h, 3Ah, 0FFh, 32h, 0C0h, 0C3h, 0E9h, 92h, 0, 98h, 8Bh, 0D8h
	db	0FFh, 36h, 60h, 6, 0E8h, 0D5h, 0FFh, '[PR', 9Ch, 3Bh, 1Eh, 60h
	db	6, 75h, 23h, 8Bh, 3Eh, 8, 0Bh, 8Eh, 6, 0F2h, 0Ah, 1Eh, 26h, 0C5h
	db	35h, 80h, 3Ch, 0CCh, 74h, 9, 8Ah, 4, 0C6h, 4, 0CCh, 26h, 88h, 45h
	db	4, 1Fh, 0E8h, 2, 0FFh, 0C6h, 6, 0E9h, 0Ah, 0FFh, 9Dh, 5Ah, 58h
	db	0C6h, 6, 0E8h, 0Ah, 1, 0C3h, 0E8h, 0F1h, 0FEh, 8Bh, 36h, 62h, 6
	db	3Bh, 36h, 0FEh, 0Ah, 75h, 45h, 8Bh, 36h, 60h, 6, 3Bh, 36h, 0FCh
	db	0Ah, 'r;;6', 2, 0Bh, 73h, 35h, 0E8h, 8Fh, 0FDh, 8Eh, 6, 0ECh, 0Ah
	db	26h, 85h, 17h, 75h, 7, 8Bh, 36h, 60h, 6, 0E8h, 56h, 0FBh, 32h
	db	0C0h, 0C3h, 0E8h, 0BEh, 0FEh, 0EBh, 1Ah, 0C7h, 6, 96h, 0Ah, 1
	db	0, 0E8h, 9Ah, 3, 0C7h, 6, 96h, 0Ah, 0, 0, 83h, 7Eh, 6, 1, 75h
	db	5, 0C7h, 46h, 6, 0, 0, 0FFh, 36h, 9Eh, 0Ah, 0FFh, 36h, 60h, 6
	db	1Eh, 0B8h, 0C0h, 0Ah, 50h, 1Eh, 0B8h, 0C4h, 0Ah, 50h, 0E8h, 0F8h
	db	7, 83h, 3Eh, 0Ah, 0Bh, 7, 75h, 6, 8Bh, 0D8h, 0Bh, 0DAh, 'tYPR'
	db	0E8h, 4, 0FEh, 5Ah, 58h, 8Bh, 0D8h, 0Bh, 0DAh, 75h, 7, 0E8h, 1Dh
	db	8, 33h, 0C0h, 33h, 0D2h, 0C3h, 0A1h, 5Ch, 6, 50h, 8Bh, 3Eh, 8
	db	0Bh, 1Eh, 8Eh, 1Eh, 0F2h, 0Ah, 0C4h, 35h, 0E8h, 34h, 0FDh, 26h
	db	80h, 3Ch, 0CCh, 75h, 6, 8Ah, 45h, 4, 26h, 88h, 4, 1Fh, 'X=P', 0
	db	72h, 1Fh, 3Dh, 0, 0A0h, 72h, 5, 3Dh, 0, 0C0h, 72h, 15h, 32h, 0C0h
	db	0C3h, 0A1h, 5Ch, 6, 3Dh, 0, 0A0h, 73h, 0C9h, 3Dh, 50h, 0, 72h
	db	0C4h, 0A1h, 5Eh, 6, 0EBh, 0BFh, 83h, 3Eh, 20h, 0Bh, 0, 75h, 2Ch
	db	0E8h, 0CAh, 7, 0C7h, 6, 20h, 0Bh, 1, 0, 8Bh, 0Eh, 0F8h, 0Ah, 1Eh
	db	0C5h, 36h, 0F0h, 0Ah, 80h, 7Ch, 5, 4, 77h, 0Eh, 0C4h, 3Ch, 26h
	db	80h, 3Dh, 0CCh, 75h, 6, 8Ah, 44h, 4, 26h, 88h, 5, 83h, 0C6h, 6
	db	0E2h, 0E7h, 1Fh, 32h, 0C0h, 0C3h
L06059:	mov	cx, word ptr ds:[0AF8h]	;@06059
	jcxz	@@3	;@0605D
	push	ds	;@0605F
	lds	si, dword ptr ds:[0AF0h]	;@06060
@@1:	les	di, dword ptr [si]	;@06064
	cmp	byte ptr es:[di], 0CCh	;@06066
	jne	@@2	;@0606A
	mov	al, byte ptr [si+4]	;@0606C
	mov	byte ptr es:[di], al	;@0606F
@@2:	add	si, 6	;@06072
	loop	@@1	;@06075
	pop	ds	;@06077
@@3:	ret	;@06078
L06079:	push	bp	;@06079
	mov	bp, sp	;@0607A
	push	si	;@0607C
	push	di	;@0607D
	mov	dx, word ptr [bp+6]	;@0607E
	cli	;@06081
	mov	ss, word ptr ds:[0ACAh]	;@06082
	mov	sp, word ptr ds:[0AC8h]	;@06086
	sti	;@0608A
	mov	bp, word ptr ds:[0AC6h]	;@0608B
	mov	ds, word ptr ds:[0AA0h]	;@0608F
	push	dx	;@06093
	call	L06573	;@06094
	call	L0650A	;@06097
	call	L06177	;@0609A
	call	L05DD3	;@0609D
	xor	ax, ax	;@060A0
	pop	dx	;@060A2
	xor	dh, dh	;@060A3
	cmp	byte ptr ds:[0AA7h], 0	;@060A5
	je	@@1	;@060AA
	mov	dx, ax	;@060AC
	dec	ax	;@060AE
@@1:	jmp	L05A5B	;@060AF
	db	0C4h, 6, 0C0h, 0Ah, 0A3h, 0ACh, 0Ah, 8Ch, 6, 0AEh, 0Ah, 8Ch, 6	;@060B2
	db	0CCh, 0Ah, 0E8h, 61h, 0FCh, 72h, 4, 8Ch, 6, 0AEh, 0Ah, 0A1h, 0C4h
	db	0Ah, 0A3h, 0B0h, 0Ah, 0C3h, 0, 0, 0, 0, 0C7h, 6, 0BAh, 0Ah, 0
	db	0, 8Bh, 4Eh, 0Ch, 89h, 0Eh, 98h, 0Ah, 0E3h, 65h, 0C4h, 5Eh, 8
	db	89h, 1Eh, 9Ah, 0Ah, 8Ch, 6, 9Ch, 0Ah, 51h, 53h, 6, 26h, 8Bh, 7
	db	2Eh, 0A3h, 81h, 9, 26h, 8Bh, 47h, 2, 2Eh, 0A3h, 83h, 9, 2Eh, 0A1h
	db	81h, 9, 3Bh, 6, 60h, 6, 75h, 40h, 6, 2Eh, 8Eh, 6, 83h, 9, 0E8h
	db	11h, 0FCh, 8Ch, 0C0h, 7, 'r2;', 6, 62h, 6, 'u,2', 0C0h, 83h, 7Eh
	db	6, 2, 75h, 3Bh, 83h, 3Eh, 0BAh, 0Ah, 0, 75h, 34h, 7, 5Bh, 53h
	db	6, 0C7h, 6, 0BAh, 0Ah, 1, 0, 8Dh, 47h, 4, 0A3h, 0BCh, 0Ah, 8Ch
	db	6, 0BEh, 0Ah, 2Eh, 0C4h, 3Eh, 81h, 9, 0EBh, 15h, 0EBh, 2Bh, 2Eh
	db	0C4h, 3Eh, 81h, 9, 6, 0E8h, 0D1h, 0FBh, 72h, 7, 26h, 8Ah, 25h
	db	26h, 0C6h, 5, 0CCh, 7, 0B0h, 1, 8Ch, 0C2h, 7, 5Bh, 26h, 88h, 47h
	db	5, 26h, 88h, 67h, 4, 59h, 83h, 0C3h, 6, 49h, 74h, 3, 0E9h, 79h
	db	0FFh, 0C3h
L06177:	mov	cx, word ptr [bp+0Ch]	;@06177
	jcxz	@@3	;@0617A
	push	ds	;@0617C
	lds	si, dword ptr [bp+8]	;@0617D
@@1:	cmp	byte ptr [si+5], 0	;@06180
	je	@@2	;@06184
	mov	di, word ptr [si]	;@06186
	mov	es, word ptr [si+2]	;@06188
	call	L05D25	;@0618B
	cmp	byte ptr es:[di], 0CCh	;@0618E
	jne	@@2	;@06192
	mov	al, byte ptr [si+4]	;@06194
	mov	byte ptr es:[di], al	;@06197
@@2:	add	si, 6	;@0619A
	loop	@@1	;@0619D
	pop	ds	;@0619F
@@3:	ret	;@061A0
	db	33h, 0D2h, 89h, 16h, 5Ah, 0Dh, 26h, 8Bh, 1Dh, 0BEh, 86h, 0Bh, 0B9h	;@061A1
	db	4Eh, 0, 0ADh, 23h, 0C3h, 3Bh, 4, 74h, 0Bh, 83h, 0C6h, 4, 0E2h
	db	0F4h, 0B9h, 1, 0, 33h, 0C0h, 0C3h, 8Ah, 4Ch, 2, 32h, 0EDh, 8Ah
	db	44h, 3, 32h, 0E4h, 22h, 0C9h, 7Eh, 3, 3, 0CAh, 0C3h, 74h, 35h
	db	0FEh, 0CDh, 8Bh, 0F1h, 0F7h, 0DEh, 81h, 0C6h, 92h, 0Ah, 2Eh, 0FFh
	db	24h, 0BAh, 0Ah, 0DCh, 0Ah, 0EDh, 0Ah, 0FAh, 0Ah, 82h, 0Ah, 82h
	db	0Ah, 30h, 0Bh, 2Fh, 0Bh, 8Eh, 0Bh, 99h, 0Bh, 0A4h, 0Bh, 28h, 0Bh
	db	22h, 0Bh, 19h, 0Bh, 16h, 0Bh, 0AFh, 0Bh, 0B6h, 0Bh, 0CFh, 0Bh
	db	4, 0Bh, 0BBh, 0Bh, 26h, 8Ah, 5, 'GB<&t', 10h, '<.t', 4, '<&u'
	db	8Ch, 0C7h, 6, 5Ah, 0Dh, 0FFh, 0FFh, 0EBh, 84h, 0C7h, 6, 5Ah, 0Dh
	db	7, 0, 0E9h, 7Bh, 0FFh, 8Bh, 0D8h, 26h, 8Ah, 45h, 1, 98h, 93h, 8Dh
	db	79h, 2, 0B9h, 2, 0, 3, 0CAh, 0C3h, 26h, 8Bh, 5Dh, 1, 8Dh, 79h
	db	3, 0B9h, 3, 0, 3, 0CAh, 0C3h, 26h, 0C4h, 7Dh, 1, 0B9h, 5, 0, 3
	db	0CAh, 0C3h, 'GB&', 8Ah, 5Dh, 1, 80h, 0E3h, 0F0h, 80h, 0FBh, 20h
	db	75h, 4, 42h, 3, 0CAh, 0C3h, 47h, 0EBh, 16h, 26h, 0F6h, 5, 2, 75h
	db	10h, 42h, 0EBh, 0Dh, 26h, 0F6h, 5, 2, 75h, 7, 42h, 26h, 0F6h, 5
	db	1, 74h, 1, 42h, 23h, 0C0h, 75h, 34h, 8Bh, 0Eh, 5Ah, 0Dh, 23h, 0C9h
	db	'|,&', 8Ah, 5Dh, 1, 80h, 0FBh, 0C0h, 73h, 23h, 0E3h, 4, 0Bh, 0C1h
	db	0EBh, 1Dh, 80h, 0E3h, 0C7h, 80h, 0FBh, 6, 74h, 15h, 80h, 0E3h
	db	7, 80h, 0FBh, 2, 74h, 0Dh, 80h, 0FBh, 3, 74h, 8, 80h, 0FBh, 6
	db	74h, 3, 0Dh, 6, 0, 26h, 8Ah, 5Dh, 1, 80h, 0E3h, 0C7h, 0B9h, 2
	db	0, 80h, 0FBh, 0C0h, 73h, 14h, 0B9h, 4, 0, 80h, 0FBh, 80h, 73h
	db	0Ch, 80h, 0FBh, 6, 74h, 7, 49h, 80h, 0FBh, 40h, 73h, 1, 49h, 3
	db	0CAh, 0C3h, 0B9h, 2, 0, 26h, 0F6h, 5, 1, 74h, 1, 41h, 0C3h, 0B9h
	db	2, 0, 26h, 0F6h, 5, 2, 75h, 1, 41h, 0C3h, 0B9h, 2, 0, 26h, 0F6h
	db	5, 8, 74h, 1, 41h, 0C3h, 0B8h, 7, 0, 8Bh, 0CAh, 41h, 0C3h, 0B9h
	db	1, 0, 0EBh, 3, 0B9h, 3, 0, 0A1h, 5Ah, 0Dh, 3Dh, 7, 0, 74h, 0E9h
	db	40h, 74h, 3, 0B8h, 6, 0, 3, 0CAh, 0C3h, 0A1h, 5Ah, 0Dh, 3Dh, 7
	db	0, 74h, 0D8h, 40h, 74h, 0D5h, 0B8h, 8, 0, 8Bh, 0CAh, 41h, 0C3h
	db	0C4h, 3Eh, 60h, 6, 26h, 80h, 3Dh, 0CDh, 74h, 0Ah, 0E8h, 32h, 4
	db	0E8h, 39h, 0, 0E8h, 51h, 4, 0C3h, 26h, 80h, 7Dh, 1, 34h, 72h, 0EFh
	db	26h, 80h, 7Dh, 1, 3Eh, 77h, 0E8h, 0E8h, 4Bh, 0FEh, 0C4h, 3Eh, 60h
	db	6, 3, 0F9h, 26h, 0FFh, 35h, 6, 57h, 26h, 0C6h, 5, 0CCh, 0E8h, 8Fh
	db	4, 0E8h, 53h, 1, 0Eh, 0E8h, 40h, 2, 90h, 0E8h, 79h, 1, 5Fh, 7
	db	58h, 26h, 88h, 5, 0C3h
L0637A:	les	di, dword ptr ds:[660h]	;@0637A
	mov	al, byte ptr es:[di]	;@0637E
	cmp	al, 0CCh	;@06381
	je	@@2	;@06383
	cmp	al, 0CFh	;@06385
	je	@@3	;@06387
	cmp	al, 9Ch	;@06389
	je	@@4	;@0638B
	cmp	al, 9Dh	;@0638D
	je	@@5	;@0638F
	cmp	al, 0CDh	;@06391
	je	@@1	;@06393
	or	word ptr ds:[664h], 100h	;@06395
	push	word ptr ds:[0AA4h]	;@0639B
	mov	word ptr ds:[0AA4h], 1	;@0639F
	push	cs	;@063A5
	db	0E8h, 6, 2	; call L065AF	;@063A6
	nop	;@063A9
	pop	word ptr ds:[0AA4h]	;@063AA
	inc	word ptr ds:[660h]	;@063AE
	jmp	@@8	;@063B2
@@1:	jmp	short @@6	;@063B5
@@2:	inc	word ptr ds:[660h]	;@063B7
	ret	;@063BB
@@3:	mov	es, word ptr ds:[668h]	;@063BC
	mov	bx, word ptr ds:[666h]	;@063C0
	mov	ax, word ptr es:[bx]	;@063C4
	mov	cx, word ptr es:[bx+2]	;@063C7
	mov	dx, word ptr es:[bx+4]	;@063CB
	mov	word ptr ds:[660h], ax	;@063CF
	mov	word ptr ds:[662h], cx	;@063D2
	mov	word ptr ds:[664h], dx	;@063D6
	add	word ptr ds:[666h], 6	;@063DA
	jmp	short @@8	;@063DF
@@4:	sub	word ptr ds:[666h], 2	;@063E1
	mov	bx, word ptr ds:[666h]	;@063E6
	mov	es, word ptr ds:[668h]	;@063EA
	mov	ax, word ptr ds:[664h]	;@063EE
	mov	word ptr es:[bx], ax	;@063F1
	inc	word ptr ds:[660h]	;@063F4
	ret	;@063F8
@@5:	mov	bx, word ptr ds:[666h]	;@063F9
	mov	es, word ptr ds:[668h]	;@063FD
	mov	ax, word ptr es:[bx]	;@06401
	and	ax, 0FEFFh	;@06404
	mov	word ptr ds:[664h], ax	;@06407
	add	word ptr ds:[666h], 2	;@0640A
	inc	word ptr ds:[660h]	;@0640F
	ret	;@06413
@@6:	mov	bl, byte ptr es:[di+1]	;@06414
	xor	bh, bh	;@06418
	shl	bx, 1	;@0641A
	shl	bx, 1	;@0641C
	add	word ptr ds:[660h], 2	;@0641E
	sub	word ptr ds:[666h], 6	;@06423
	mov	di, word ptr ds:[666h]	;@06428
	mov	es, word ptr ds:[668h]	;@0642C
	mov	ax, word ptr ds:[660h]	;@06430
	stosw	;@06433
	mov	ax, word ptr ds:[662h]	;@06434
	stosw	;@06437
	mov	ax, word ptr ds:[664h]	;@06438
	stosw	;@0643B
	push	ds	;@0643C
	add	bx, 690h	;@0643D
	test	byte ptr ds:[0AA7h], 80h	;@06441
	je	@@7	;@06446
	xor	ax, ax	;@06448
	mov	ds, ax	;@0644A
	sub	bx, 690h	;@0644C
@@7:	mov	ax, word ptr [bx]	;@06450
	mov	dx, word ptr [bx+2]	;@06452
	pop	ds	;@06455
	mov	word ptr ds:[660h], ax	;@06456
	mov	word ptr ds:[662h], dx	;@06459
@@8:	les	di, dword ptr ds:[660h]	;@0645D
	cmp	word ptr es:[0], 3FCDh	;@06461
	je	@@9	;@06468
	mov	ax, es	;@0646A
	db	0E8h, 0C3h, 3	; call L06832	;@0646C
	mov	word ptr ds:[0A9Eh], ax	;@0646F
	ret	;@06472
@@9:	test	byte ptr ds:[0AA7h], 80h	;@06473
	jne	@@11	;@06478
	cmp	word ptr es:[di], 3FCDh	;@0647A
	je	@@10	;@0647F
	cmp	byte ptr es:[di], 0EAh	;@06481
	jne	@@11	;@06485
	mov	word ptr ds:[0A9Eh], es	;@06487
	les	ax, dword ptr es:[di+1]	;@0648B
	mov	word ptr ds:[660h], ax	;@0648F
	mov	word ptr ds:[662h], es	;@06492
	ret	;@06496
@@10:	db	0E8h, 0FBh, 2	; call L06795	;@06497
	call	@@12	;@0649A
	push	cs	;@0649D
	db	0E8h, 0Eh, 1	; call L065AF	;@0649E
	nop	;@064A1
	call	@@13	;@064A2
	db	0E8h, 0C8h, 2	; call L06770	;@064A5
	cmp	word ptr ds:[0A90h], -1	;@064A8
	je	@@11	;@064AD
	les	di, dword ptr ds:[0A92h]	;@064AF
	cmp	byte ptr es:[di], 0CCh	;@064B3
	jne	@@11	;@064B7
	mov	al, byte ptr ds:[0A90h]	;@064B9
	stosb	;@064BC
@@11:	ret	;@064BD
@@12:	mov	ah, 51h	;@064BE
	int	21h	;@064C0
	mov	word ptr ds:[68Eh], bx	;@064C2
	mov	es, bx	;@064C6
	mov	ax, word ptr ds:[0ACEh]	;@064C8
	mov	word ptr es:[2Eh], ax	;@064CB
	mov	ax, word ptr ds:[0AD0h]	;@064CF
	mov	word ptr es:[30h], ax	;@064D2
	mov	bx, word ptr ds:[68Ch]	;@064D6
	mov	ah, 50h	;@064DA
	int	21h	;@064DC
	cli	;@064DE
	call	L0650A	;@064DF
	call	L06548	;@064E2
	mov	word ptr ds:[0AA4h], 3	;@064E5
	ret	;@064EB
@@13:	call	L06573	;@064EC
	call	L0650A	;@064EF
	mov	word ptr ds:[0AA4h], 0	;@064F2
	sti	;@064F8
	mov	ah, 51h	;@064F9
	int	21h	;@064FB
	mov	word ptr ds:[68Ch], bx	;@064FD
	mov	bx, word ptr ds:[68Eh]	;@06501
	mov	ah, 50h	;@06505
	int	21h	;@06507
	ret	;@06509
L0650A:	mov	dx, ds	;@0650A
	xor	ax, ax	;@0650C
	mov	bx, sp	;@0650E
	sub	sp, 401h	;@06510
	and	sp, -2	;@06514
	mov	ds, ax	;@06517
	mov	si, ax	;@06519
	push	ss	;@0651B
	pop	es	;@0651C
	mov	di, sp	;@0651D
	mov	cx, 200h	;@0651F
	rep movsw	;@06522
	nop	;@06524
	mov	ds, dx	;@06525
	mov	si, 690h	;@06527
	mov	es, ax	;@0652A
	mov	di, ax	;@0652C
	mov	cx, 200h	;@0652E
	rep movsw	;@06531
	mov	si, sp	;@06533
	push	ss	;@06535
	pop	ds	;@06536
	mov	di, 690h	;@06537
	mov	es, dx	;@0653A
	mov	cx, 200h	;@0653C
	rep movsw	;@0653F
	mov	es, dx	;@06541
	mov	ds, dx	;@06543
	mov	sp, bx	;@06545
	ret	;@06547
L06548:	push	ds	;@06548
	mov	ax, S686	;@06549
	mov	ds, ax	;@0654C
	xor	ax, ax	;@0654E
	mov	es, ax	;@06550
	mov	si, 1Ah	;@06552
	mov	cx, 5	;@06555
@@1:	lodsw	;@06558
	mov	di, ax	;@06559
	mov	ax, word ptr es:[di]	;@0655B
	mov	word ptr [si], ax	;@0655E
	mov	ax, word ptr es:[di+2]	;@06560
	mov	word ptr [si+2], ax	;@06564
	add	si, 4	;@06567
	movsw	;@0656A
	mov	ax, S686	;@0656B
	stosw	;@0656E
	loop	@@1	;@0656F
	pop	ds	;@06571
	ret	;@06572
L06573:	mov	bx, word ptr ds:[68Ch]	;@06573
	push	ds	;@06577
	db	0BAh	;@06578
	dw	S686
	db	8Eh, 0DAh	; mov ds, dx	;@0657B
	xor	ax, ax	;@0657D
	mov	es, ax	;@0657F
	mov	si, 1Ah	;@06581
	mov	cx, 5	;@06584
@@1:	lodsw	;@06587
	mov	di, ax	;@06588
	cmp	dx, word ptr es:[di+2]	;@0658A
	jne	@@3	;@0658E
	mov	ax, word ptr [si+4]	;@06590
	cmp	ax, word ptr es:[di]	;@06593
	jne	@@3	;@06596
@@2:	movsw	;@06598
	movsw	;@06599
	inc	si	;@0659A
	inc	si	;@0659B
	loop	@@1	;@0659C
	pop	ds	;@0659E
	ret	;@0659F
@@3:	cmp	word ptr es:[di+2], bx	;@065A0
	jb	@@2	;@065A4
	mov	ds, dx	;@065A6
	add	si, 6	;@065A8
	loop	@@1	;@065AB
	pop	ds	;@065AD
	ret	;@065AE
L065AF:	cli	;@065AF
	mov	word ptr ds:[0D5Ch], sp	;@065B0
	mov	word ptr ds:[0D5Eh], ss	;@065B4
	mov	word ptr ds:[0D60h], bp	;@065B8
	mov	bx, 64Eh	;@065BC
	mov	ax, word ptr [bx]	;@065BF
	mov	cx, word ptr [bx+4]	;@065C1
	mov	dx, word ptr [bx+6]	;@065C4
	mov	si, word ptr [bx+0Ah]	;@065C7
	mov	di, word ptr [bx+0Ch]	;@065CA
	mov	bp, word ptr [bx+8]	;@065CD
	mov	es, word ptr [bx+10h]	;@065D0
	mov	ss, word ptr [bx+1Ah]	;@065D3
	mov	sp, word ptr [bx+18h]	;@065D6
	push	word ptr [bx+16h]	;@065D9
	push	word ptr [bx+14h]	;@065DC
	push	word ptr [bx+12h]	;@065DF
	mov	bx, word ptr [bx+2]	;@065E2
	mov	ds, word ptr ds:[65Ch]	;@065E5
	iret	;@065E9
L065EA:	mov	bx, 64Eh	;@065EA
	mov	word ptr [bx], ax	;@065ED
	pop	word ptr [bx+2]	;@065EF
	mov	word ptr [bx+4], cx	;@065F2
	mov	word ptr [bx+6], dx	;@065F5
	mov	word ptr [bx+0Ah], si	;@065F8
	mov	word ptr [bx+0Ch], di	;@065FB
	mov	word ptr [bx+8], bp	;@065FE
	pop	word ptr [bx+0Eh]	;@06601
	mov	word ptr [bx+10h], es	;@06604
	pop	word ptr [bx+12h]	;@06607
	pop	word ptr [bx+14h]	;@0660A
	pop	word ptr [bx+16h]	;@0660D
	mov	word ptr [bx+1Ah], ss	;@06610
	mov	word ptr [bx+18h], sp	;@06613
	cli	;@06616
	mov	ss, word ptr ds:[0ACAh]	;@06617
	mov	sp, word ptr ds:[0AC8h]	;@0661B
	sti	;@0661F
	mov	bp, word ptr ds:[0AC6h]	;@06620
	test	byte ptr ds:[0AA7h], 80h	;@06624
	jne	@@5	;@06629
	mov	byte ptr ds:[0AA7h], 82h	;@0662B
	sti	;@06630
	call	L06177	;@06631
	call	L06059	;@06634
	mov	word ptr ds:[0AA8h], 1	;@06637
	mov	word ptr ds:[0AAAh], 0	;@0663D
@@1:	mov	ax, word ptr ds:[662h]	;@06643
	db	0E8h, 0E9h, 1	; call L06832	;@06646
	mov	word ptr ds:[0ACCh], ax	;@06649
	db	0E8h, 0B8h, 1	; call L06807	;@0664C
	or	ax, ax	;@0664F
	jne	@@3	;@06651
	mov	ax, word ptr ds:[662h]	;@06653
@@2:	push	ax	;@06656
	call	@@8	;@06657
	pop	ax	;@0665A
	jne	@@5	;@0665B
	cmp	ax, word ptr ds:[662h]	;@0665D
	je	@@2	;@06661
	jmp	@@1	;@06663
@@3:	push	word ptr ds:[0ACCh]	;@06665
	push	word ptr ds:[660h]	;@06669
	push	ds	;@0666D
	mov	ax, 0AC0h	;@0666E
	push	ax	;@06671
	push	ds	;@06672
	mov	ax, 0AC4h	;@06673
	push	ax	;@06676
	db	0E8h, 3Bh, 1	; call L067B5	;@06677
	mov	bx, ax	;@0667A
	or	bx, dx	;@0667C
	jne	@@6	;@0667E
@@4:	mov	ax, word ptr ds:[662h]	;@06680
	push	ax	;@06683
	call	@@8	;@06684
	pop	ax	;@06687
	jne	@@5	;@06688
	cmp	ax, word ptr ds:[662h]	;@0668A
	je	@@3	;@0668E
	jmp	@@1	;@06690
@@5:	neg	word ptr ds:[0AAAh]	;@06692
	mov	byte ptr ds:[0AA7h], 0	;@06696
	jmp	short @@7	;@0669B
@@6:	mov	word ptr ds:[0AA8h], ax	;@0669D
	mov	word ptr ds:[0AAAh], dx	;@066A0
	mov	ax, word ptr ds:[0AC0h]	;@066A4
	cmp	ax, word ptr ds:[660h]	;@066A7
	jne	@@4	;@066AB
	mov	ax, word ptr ds:[0AC2h]	;@066AD
	cmp	ax, word ptr ds:[662h]	;@066B0
	jne	@@4	;@066B4
@@7:	mov	ah, 51h	;@066B6
	int	21h	;@066B8
	mov	word ptr ds:[68Ch], bx	;@066BA
	mov	bx, word ptr ds:[68Eh]	;@066BE
	mov	ah, 50h	;@066C2
	int	21h	;@066C4
	call	L06573	;@066C6
	call	L0650A	;@066C9
	sti	;@066CC
	neg	word ptr ds:[0AA8h]	;@066CD
	jmp	L05A54	;@066D1
@@8:	mov	di, word ptr ds:[660h]	;@066D4
	mov	es, word ptr ds:[662h]	;@066D8
	cmp	word ptr es:[di], 21CDh	;@066DC
	je	@@11	;@066E1
	cmp	word ptr es:[di], 13CDh	;@066E3
	je	@@11	;@066E8
	cmp	word ptr es:[di], 10CDh	;@066EA
	je	@@11	;@066EF
	push	word ptr ds:[0AA4h]	;@066F1
	mov	word ptr ds:[0AA4h], 1	;@066F5
	call	L0637A	;@066FB
	pop	word ptr ds:[0AA4h]	;@066FE
	cmp	word ptr ds:[660h], 1FBh	;@06702
	je	@@10	;@06708
@@9:	test	byte ptr ds:[0AA7h], 1	;@0670A
	ret	;@0670F
@@10:	mov	bx, cs	;@06710
	cmp	bx, word ptr ds:[662h]	;@06712
	jne	@@9	;@06716
	push	word ptr ds:[0AA4h]	;@06718
	mov	word ptr ds:[0AA4h], 1	;@0671C
	push	cs	;@06722
	call	L065AF	;@06723
	pop	word ptr ds:[0AA4h]	;@06726
	jmp	@@9	;@0672A
@@11:	mov	word ptr ds:[0AA2h], 1	;@0672C
	inc	di	;@06732
	inc	di	;@06733
	mov	al, byte ptr es:[di]	;@06734
	mov	byte ptr es:[di], 0CCh	;@06737
	push	ax	;@0673B
@@12:	push	es	;@0673C
	push	di	;@0673D
	push	word ptr ds:[0AA4h]	;@0673E
	mov	word ptr ds:[0AA4h], 3	;@06742
	push	cs	;@06748
	call	L065AF	;@06749
	pop	word ptr ds:[0AA4h]	;@0674C
	pop	di	;@06750
	pop	es	;@06751
	mov	dx, es	;@06752
	cmp	dx, word ptr ds:[662h]	;@06754
	jne	@@12	;@06758
	cmp	di, word ptr ds:[660h]	;@0675A
	jne	@@12	;@0675E
	pop	ax	;@06760
	mov	byte ptr es:[di], al	;@06761
	mov	word ptr ds:[0AA2h], 0	;@06764
	test	byte ptr ds:[0AA7h], 1	;@0676A
	ret	;@0676F
L06770:	mov	si, 4	;@06770
	mov	di, 1Ch	;@06773
	mov	ax, 197h	;@06776
	push	ds	;@06779
	xor	bx, bx	;@0677A
	mov	ds, bx	;@0677C
	db	0BAh	;@0677E
	dw	S686
	db	8Eh, 0C2h	; mov es, dx	;@06781
	movsw	;@06783
	movsw	;@06784
	pop	ds	;@06785
	mov	es, bx	;@06786
	lea	di, [si-4]	;@06788
	cli	;@0678B
	stosw	;@0678C
	mov	ax, S686	;@0678D
	stosw	;@06790
	sti	;@06791
	push	ds	;@06792
	pop	es	;@06793
	ret	;@06794
L06795:	mov	di, 4	;@06795
	mov	si, 1Ch	;@06798
	mov	ax, 197h	;@0679B
	push	ds	;@0679E
	xor	bx, bx	;@0679F
	mov	es, bx	;@067A1
	cmp	ax, word ptr es:[di]	;@067A3
	jne	@@1	;@067A6
	mov	ax, S686	;@067A8
	mov	ds, ax	;@067AB
	cli	;@067AD
	movsw	;@067AE
	movsw	;@067AF
	sti	;@067B0
@@1:	pop	ds	;@067B1
	push	ds	;@067B2
	pop	es	;@067B3
	ret	;@067B4
L067B5:	push	bp	;@067B5
	mov	bp, sp	;@067B6
	push	ds	;@067B8
	pop	es	;@067B9
	mov	di, 400h	;@067BA
	mov	ax, word ptr [bp+0Ch]	;@067BD
	mov	word ptr [di], ax	;@067C0
	mov	ax, word ptr [bp+0Eh]	;@067C2
	call	L06832	;@067C5
	mov	word ptr [di+0Ch], ax	;@067C8
	mov	word ptr [di+4], 1	;@067CB
	call	far ptr L03FCD	;@067D0
	les	bx, dword ptr [bp+4]	;@067D5
	mov	ax, word ptr [di+8]	;@067D8
	mov	word ptr es:[bx], ax	;@067DB
	les	bx, dword ptr [bp+8]	;@067DE
	mov	ax, word ptr [di+18h]	;@067E1
	mov	word ptr es:[bx+2], ax	;@067E4
	mov	ax, word ptr [di+1Ch]	;@067E8
	mov	word ptr es:[bx], ax	;@067EB
	mov	ax, word ptr [di]	;@067EE
	mov	dx, word ptr [di+0Ch]	;@067F0
	pop	bp	;@067F3
	ret	0Ch	;@067F4
	db	1Eh, 7, 0BFh, 0, 4, 0C7h, 45h, 4, 2, 0, 9Ah	;@067F7
	dd	L03FCD
	db	0C3h
L06807:	push	ds	;@06807
	pop	es	;@06808
	mov	di, 400h	;@06809
	mov	word ptr [di+4], 3	;@0680C
	mov	word ptr [di], ax	;@06811
	call	far ptr L03FCD	;@06813
	mov	ax, word ptr [di]	;@06818
	ret	;@0681A
	db	1Eh, 7, 0BFh, 0, 4, 0C7h, 45h, 4, 4, 0, 89h, 5, 89h, 55h, 0Ch, 9Ah	;@0681B
	dd	L03FCD
	db	8Bh, 5, 0C3h
L06832:	cmp	byte ptr ds:[0AE3h], 0	;@06832
	je	@@1	;@06837
	push	si	;@06839
	push	di	;@0683A
	push	ax	;@0683B
	call	dword ptr ds:[0AE4h]	;@0683C
	pop	bx	;@06840
	pop	di	;@06841
	pop	si	;@06842
	and	ax, ax	;@06843
	jne	@@1	;@06845
	xchg	ax, bx	;@06847
@@1:	ret	;@06848
L06849:	mov	si, 12h	;@06849
	push	ds	;@0684C
	pop	es	;@0684D
	mov	di, 400h	;@0684E
	mov	cx, 19h	;@06851
	rep movsw	;@06854
	push	ds	;@06856
	pop	es	;@06857
	mov	di, 400h	;@06858
	mov	word ptr [di+4], 5	;@0685B
	call	far ptr L03FCD	;@06860
	retf	;@06865
S575	ends

S686	segment byte public 'CODE'
	assume	cs:S686
S686_START	dw	S2F4	;@06866
	db	24h, 2Ah, 24h, 2Ah, 24h, 2Ah, 0, 1, 0, 2, 44h, 45h, 42h, 55h, 47h, 0
	db	5, 0, 4, 0, 0, 0, 0, 0, 97h, 1, 0Ch, 0, 0, 0, 0, 0
	db	0A6h, 1, 24h, 0, 0, 0, 0, 0, 0FBh, 1, 40h, 0, 0, 0, 0, 0
	db	0B6h, 2, 4Ch, 0, 0, 0, 0, 0, 0A3h, 2, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 26h, 81h, 3Eh, 0, 0, 0CDh, 3Fh, 75h, 0Dh, 26h, 83h, 3Eh, 10h
	db	0, 0, 74h, 7, 26h, 8Eh, 6, 10h, 0, 0F8h, 0CBh, 0F9h, 0CBh
L068C5:	push	bp	;@068C5
	mov	bp, sp	;@068C6
	push	si	;@068C8
	push	di	;@068C9
	push	ds	;@068CA
	mov	ds, word ptr ds:[0AA0h]	;@068CB
	mov	ax, word ptr [bp+6]	;@068CF
	mov	ax, word ptr ds:[65Ch]	;@068D2
	mov	word ptr ds:[68Ch], ax	;@068D5
	or	word ptr ds:[664h], 200h	;@068D8
	mov	es, ax	;@068DE
	mov	es, word ptr es:[16h]	;@068E0
	les	si, dword ptr es:[2Eh]	;@068E5
	mov	word ptr ds:[0ACEh], si	;@068EA
	mov	word ptr ds:[0AD0h], es	;@068EE
	mov	word ptr ds:[0ACCh], 0FFFFh	;@068F2
	mov	word ptr ds:[0A96h], 0	;@068F8
	mov	es, word ptr ds:[0AA0h]	;@068FE
	xor	ax, ax	;@06902
	mov	ds, ax	;@06904
	xor	si, si	;@06906
	mov	di, 690h	;@06908
	mov	cx, 200h	;@0690B
	rep movsw	;@0690E
	push	word ptr ds:[6Eh]	;@06910
	push	word ptr ds:[6Ch]	;@06914
	mov	ax, S686	;@06918
	mov	ds, ax	;@0691B
	pop	word ptr ds:[44h]	;@0691D
	pop	word ptr ds:[42h]	;@06921
	mov	di, 714h	;@06925
	mov	ax, word ptr es:[di]	;@06928
	mov	word ptr ds:[46h], ax	;@0692B
	mov	ax, word ptr es:[di+2]	;@0692E
	mov	word ptr ds:[48h], ax	;@06932
	mov	ax, 2C9h	;@06935
	stosw	;@06938
	mov	ax, S686	;@06939
	stosw	;@0693C
	pop	ds	;@0693D
	pop	di	;@0693E
	pop	si	;@0693F
	pop	bp	;@06940
	retf	2	;@06941
	db	1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 23h, 0C0h, 74h, 0Eh, 3Dh, 1, 0, 74h, 0Bh, 0F6h	;@06944
	db	6, 0A7h, 0Ah, 80h, 74h, 4, 1Fh, 0CBh, 0EBh, 74h, 8Ch, 6, 9Eh, 0Ah, 53h, 50h
	db	8Ch, 0C2h, 0Eh, 0E8h, 41h, 0FFh, 5Bh, 8Bh, 0Eh, 98h, 0Ah, 0E3h, 2Dh, 1Eh, 0C5h, 36h
	db	9Ah, 0Ah, 3Bh, 54h, 2, 75h, 1Dh, 8Bh, 3Ch, 83h, 0FBh, 1, 74h, 0Ch, 26h, 8Ah
	db	5, 88h, 44h, 4, 26h, 0C6h, 5, 0CCh, 0EBh, 0Ah, 26h, 80h, 3Dh, 0CCh, 75h, 4
	db	8Ah, 44h, 4, 0AAh, 83h, 0C6h, 6, 0E2h, 0D9h, 1Fh, 8Bh, 0Eh, 0F8h, 0Ah, 0E3h, 2Dh
	db	1Eh, 0C5h, 36h, 0F0h, 0Ah, 3Bh, 54h, 2, 75h, 1Dh, 8Bh, 3Ch, 83h, 0FBh, 1, 74h
	db	0Ch, 26h, 8Ah, 5, 88h, 44h, 4, 26h, 0C6h, 5, 0CCh, 0EBh, 0Ah, 26h, 80h, 3Dh
	db	0CCh, 75h, 4, 8Ah, 44h, 4, 0AAh, 83h, 0C6h, 6, 0E2h, 0D9h, 1Fh, 5Bh, 83h, 3Eh
	db	96h, 0Ah, 0, 74h, 18h, 83h, 0FBh, 0FFh, 74h, 13h, 8Bh, 0FBh, 26h, 8Ah, 1Dh, 32h
	db	0FFh, 26h, 0C6h, 5, 0CCh, 89h, 3Eh, 92h, 0Ah, 8Ch, 6, 94h, 0Ah, 89h, 1Eh, 90h
	db	0Ah, 1Fh, 0CBh, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 83h, 3Eh, 0A4h, 0Ah, 1, 74h, 11h
	db	1Fh, 0CFh, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 83h, 3Eh, 0A4h, 0Ah, 3, 74h, 2, 1Fh
	db	0CFh, 53h, 0BBh, 4Eh, 6, 89h, 7, 8Fh, 47h, 2, 89h, 4Fh, 4, 89h, 57h, 6
	db	89h, 77h, 0Ah, 89h, 7Fh, 0Ch, 89h, 6Fh, 8, 8Fh, 47h, 0Eh, 8Ch, 47h, 10h, 8Fh
	db	47h, 12h, 8Fh, 47h, 14h, 8Fh, 47h, 16h, 8Ch, 57h, 1Ah, 89h, 67h, 18h, 0FAh, 8Eh
	db	16h, 5Eh, 0Dh, 8Bh, 26h, 5Ch, 0Dh, 0FBh, 8Bh, 2Eh, 60h, 0Dh, 81h, 67h, 16h, 0FFh
	db	0FEh, 0FFh, 0Eh, 60h, 6, 0FCh, 0CBh, 1Eh, 57h, 33h, 0FFh, 8Eh, 0DFh, 0BFh, 6Ch, 0
	db	0FFh, 35h, 0FFh, 75h, 2, 0FAh, 0C7h, 5, 49h, 2, 8Ch, 4Dh, 2, 9Ch, 2Eh, 0FFh
	db	1Eh, 2Ch, 0, 0FAh, 8Fh, 45h, 2, 8Fh, 5, 2Eh, 80h, 3Eh, 4Ah, 0, 0, 74h
	db	15h, 80h, 26h, 71h, 4, 7Fh, 2Eh, 0C6h, 6, 4Ah, 0, 0, 50h, 53h, 56h, 32h
	db	0E4h, 0CDh, 16h, 5Eh, 5Bh, 58h, 5Fh, 2Eh, 8Eh, 1Eh, 6, 0, 0F6h, 6, 0A7h, 0Ah
	db	1, 75h, 33h, 1Fh, 0CFh, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 80h, 0Eh, 0A7h, 0Ah, 1
	db	0F6h, 6, 0A7h, 0Ah, 82h, 75h, 14h, 2Eh, 0C6h, 6, 4Ah, 0, 1, 0C7h, 6, 0A8h
	db	0Ah, 1, 0, 0C7h, 6, 0AAh, 0Ah, 0, 0, 1Fh, 0CFh, 80h, 0Eh, 0A7h, 0Ah, 80h
	db	1Fh, 2Eh, 0FFh, 2Eh, 42h, 0, 80h, 0Eh, 0A7h, 0Ah, 2, 83h, 3Eh, 0A2h, 0Ah, 0
	db	75h, 0C1h, 53h, 0F6h, 6, 0A7h, 0Ah, 80h, 75h, 10h, 83h, 3Eh, 6Eh, 6, 0, 75h
	db	9, 0C6h, 6, 0A7h, 0Ah, 82h, 5Bh, 90h, 0EBh, 0A9h, 0EAh
	dd	L065EA
	db	1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 0FFh, 6, 0A2h, 0Ah, 1Fh, 9Ch, 2Eh, 0FFh, 1Eh, 3Ch
	db	0, 0EBh, 38h, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 0FFh, 6, 0A2h, 0Ah, 1Fh, 9Ch, 2Eh
	db	0FFh, 1Eh, 34h, 0, 0EBh, 25h, 1Eh, 2Eh, 8Eh, 1Eh, 6, 0, 80h, 3Eh, 0A6h, 0Ah
	db	0, 75h, 3Bh, 0FFh, 6, 0A2h, 0Ah, 80h, 0FCh, 4Bh, 74h, 38h, 1Fh, 55h, 8Bh, 0ECh
	db	0FFh, 76h, 6, 9Dh, 5Dh, 9Ch, 2Eh, 0FFh, 1Eh, 46h, 0, 55h, 8Bh, 0ECh, 50h, 9Ch
	db	58h, 81h, 66h, 6, 0, 2, 9, 46h, 6, 58h, 5Dh, 1Eh, 2Eh, 8Eh, 1Eh, 6
	db	0, 0FFh, 0Eh, 0A2h, 0Ah, 0F6h, 6, 0A7h, 0Ah, 1, 75h, 22h, 1Fh, 0CFh, 1Fh, 2Eh
	db	0FFh, 2Eh, 46h, 0, 0FEh, 6, 0A6h, 0Ah, 1Fh, 9Ch, 2Eh, 0FFh, 1Eh, 46h, 0, 1Eh
	db	2Eh, 8Eh, 1Eh, 6, 0, 9Ch, 0FEh, 0Eh, 0A6h, 0Ah, 9Dh, 1Fh, 0EBh, 0BDh, 83h, 3Eh
	db	0A2h, 0Ah, 0, 75h, 0D7h, 0E9h, 4Bh, 0FFh, 0, 0, 0, 0, 0
S686	ends

S6FE	segment para public 'CODE'
	assume	cs:S6FE
S6FEa_START	db	0, 10h, 1, 10h, 0, 0	;@06FE0
	dw	S575
S6FE	ends
	end
