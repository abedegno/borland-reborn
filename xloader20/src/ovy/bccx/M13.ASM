	.286p
	locals
	public	L0DCEB

Y0DC80	segment para public 'CODE'
	assume	cs:Y0DC80
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0DC80
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0A0h, 88h
	db	5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0
Y0DC80	ends

Y0DCC0	segment para public 'CODE'
	assume	cs:Y0DCC0
	db	0CDh, 3Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0DCC0
	db	0, 0, 0B0h, 88h, 5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0
L0DCEB:	add	byte ptr [bx+si], al	;@0DCEB
	add	byte ptr [bx+si], al	;@0DCED
	db	0, 0CDh	; add ch, cl	;@0DCEF
	aas	;@0DCF1
	add	byte ptr [bx+si], al	;@0DCF2
	add	byte ptr [bx+si], al	;@0DCF4
	add	byte ptr [bx+si], al	;@0DCF6
	add	byte ptr [bx+si], al	;@0DCF8
	add	byte ptr [bx+si], al	;@0DCFA
	add	byte ptr [bx+si], al	;@0DCFC
	add	byte ptr [bx+si], al	;@0DCFE
Y0DCC0	ends

Y0DD00	segment para public 'CODE'
	assume	cs:Y0DD00
	db	0CDh, 3Fh, 0, 0, 0C0h, 88h, 5, 0, 6Dh, 1Eh, 58h, 1, 7, 0, 0, 0	;@0DD00
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
TRY_PCH_LOAD:	int	3Fh	;@0DD20
	mov	dx, 1Dh	;@0DD22
SAVE_WARNING_SWITCH:	int	3Fh	;@0DD25
	in	ax, dx	;@0DD27
	sbb	byte ptr [bx+si], al	;@0DD28
ADD_PCH_DEPENDENCY:	int	3Fh	;@0DD2A
	add	byte ptr [bx+si], al	;@0DD2C
	db	0, 0CDh	; add ch, cl	;@0DD2E
	aas	;@0DD30
	sub	bx, word ptr [bx+di]	;@0DD31
	db	0, 0CDh	; add ch, cl	;@0DD33
	aas	;@0DD35
	xor	ax, 19h	;@0DD36
REPLAY_PREAMBLE:	int	3Fh	;@0DD39
	and	bx, word ptr [bp+si]	;@0DD3B
	db	0, 0CDh	; add ch, cl	;@0DD3D
	aas	;@0DD3F
	cli	;@0DD40
	sbb	al, 0	;@0DD41
	add	byte ptr [bx+si], al	;@0DD43
	add	byte ptr [bx+si], al	;@0DD45
	add	byte ptr [bx+si], al	;@0DD47
	add	byte ptr [bx+si], al	;@0DD49
	add	byte ptr [bx+si], al	;@0DD4B
	add	byte ptr [bx+si], al	;@0DD4D
	db	0, 0CDh	; add ch, cl	;@0DD4F
	aas	;@0DD51
	add	byte ptr [bx+si], al	;@0DD52
	nop	;@0DD54
	test	al, 5	;@0DD55
	add	byte ptr [bp-43F5h], bh	;@0DD57
	add	byte ptr [bp+si], cl	;@0DD5B
	add	byte ptr [bx+si], al	;@0DD5D
	add	byte ptr [bx+si], al	;@0DD5F
	add	byte ptr [bx+si], al	;@0DD61
	add	byte ptr [bx+si], al	;@0DD63
	add	byte ptr [bx+si], al	;@0DD65
	add	byte ptr [bx+si], al	;@0DD67
	add	byte ptr [bx+si], al	;@0DD69
	add	byte ptr [bx+si], al	;@0DD6B
	add	byte ptr [bx+si], al	;@0DD6D
	db	0	; add ch, cl	;@0DD6F
Y0DD00	ends

Y0DD70	segment para public 'CODE'
	assume	cs:Y0DD70
REWRITE_FOR_REFERENCE_BIND:	int	3Fh	;@0DD70
	nop	;@0DD72
	or	al, byte ptr [bx+si]	;@0DD73
CONVERT_DERIVED_TO_BASE:	int	3Fh	;@0DD75
	pop	bp	;@0DD77
	add	ax, word ptr [bx+si]	;@0DD78
GET_BASE_OFFSET:	int	3Fh	;@0DD7A
	push	ds	;@0DD7C
	or	byte ptr [bx+si], al	;@0DD7D
CONVERT_BASE_TO_DERIVED:	int	3Fh	;@0DD7F
	mov	ax, word ptr ds:[4]	;@0DD81
CONSTRUCT_TEMP_OBJECT:	int	3Fh	;@0DD84
	ror	byte ptr [bx+si], 0	;@0DD86
MAKE_REFERENCE:	int	3Fh	;@0DD89
	db	68h, 0, 0	; push 0	;@0DD8B
ADJUST_MEMBER_FUNC_PTR_BASE:	db	0CDh, 3Fh	; int 3Fh	;@0DD8E
	wait	;@0DD90
	add	ax, 0CD00h	;@0DD91
	aas	;@0DD94
	xor	byte ptr [bx], al	;@0DD95
	db	0, 0CDh	; add ch, cl	;@0DD97
	aas	;@0DD99
	hlt	;@0DD9A
	add	byte ptr [bx+si], al	;@0DD9B
IS_OBJECT_RVALUE:	int	3Fh	;@0DD9D
	db	8Fh	;@0DD9F
Y0DD70	ends

Y0DDA0	segment para public 'CODE'
	assume	cs:Y0DDA0
	db	9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0DDA0
	db	10h, 0B5h, 5, 0, 50h, 0Ch, 0E0h, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DDA0	ends

Y0DDD0	segment para public 'CODE'
	assume	cs:Y0DDD0
INIT_VECTOR_ELEMENTS:	int	3Fh	;@0DDD0
	stc	;@0DDD2
	add	word ptr [bx+si], ax	;@0DDD3
BUILD_SPECIAL_MEMBER_BODY:	int	3Fh	;@0DDD5
	ret	0Bh	;@0DDD7
	db	0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 40h, 0C2h, 5, 0, 17h, 5, 1Ch	;@0DDDA
	db	0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0DDD0	ends

Y0DE00	segment para public 'CODE'
	assume	cs:Y0DE00
IS_FRIEND:	int	3Fh	;@0DE00
	db	0F3h, 2, 0	; add al, byte ptr [bx+si]	;@0DE02
FIND_MEMBER_REPORT:	db	0CDh, 3Fh	; int 3Fh	;@0DE05
	xchg	ax, cx	;@0DE07
	add	word ptr [bx+si], ax	;@0DE08
FIND_MEMBER_IN_BASES:	int	3Fh	;@0DE0A
	inc	bp	;@0DE0C
	add	byte ptr [bx+si], al	;@0DE0D
SYMBOL_ACCESSIBLE:	int	3Fh	;@0DE0F
	rol	byte ptr [si], 1	;@0DE11
	db	0, 0CDh	; add ch, cl	;@0DE13
	aas	;@0DE15
	db	65h, 4, 0	; add al, 0	;@0DE16
FIND_MEMBER_QUIET:	db	0CDh, 3Fh	; int 3Fh	;@0DE19
	fadd	qword ptr [bx+di]	;@0DE1B
	db	0, 0CDh	; add ch, cl	;@0DE1D
	aas	;@0DE1F
	add	al, 2	;@0DE20
	db	0, 0CDh	; add ch, cl	;@0DE22
	aas	;@0DE24
	bound	ax, dword ptr [bp+di]	;@0DE25
	add	byte ptr [bx+si], al	;@0DE27
	add	byte ptr [bx+si], al	;@0DE29
	add	byte ptr [bx+si], al	;@0DE2B
	add	byte ptr [bx+si], al	;@0DE2D
	db	0, 0CDh	; add ch, cl	;@0DE2F
	aas	;@0DE31
	add	byte ptr [bx+si], al	;@0DE32
	add	bh, 5	;@0DE34
	db	0, 0CCh	; add ah, cl	;@0DE37
	add	al, 4Ch	;@0DE39
	add	byte ptr [bp+di], al	;@0DE3B
	add	byte ptr [bx+si], al	;@0DE3D
	add	byte ptr [bx+si], al	;@0DE3F
	add	byte ptr [bx+si], al	;@0DE41
	add	byte ptr [bx+si], al	;@0DE43
	add	byte ptr [bx+si], al	;@0DE45
	add	byte ptr [bx+si], al	;@0DE47
	add	byte ptr [bx+si], al	;@0DE49
	add	byte ptr [bx+si], al	;@0DE4B
	add	byte ptr [bx+si], al	;@0DE4D
	db	0	; add ch, cl	;@0DE4F
Y0DE00	ends

Y0DE50	segment para public 'CODE'
	assume	cs:Y0DE50
EMIT_ASM_EXTERNALS:	int	3Fh	;@0DE50
	arpl	word ptr [bx+si], ax	;@0DE52
	db	0, 0CDh	; add ch, cl	;@0DE54
	aas	;@0DE56
	add	byte ptr [bx+si], al	;@0DE57
	db	0, 0CDh	; add ch, cl	;@0DE59
	aas	;@0DE5B
	rol	word ptr [bp+di], 1	;@0DE5C
	add	byte ptr [bx+si], al	;@0DE5E
	int	3Fh	;@0DE60
	add	byte ptr [bx+si], al	;@0DE62
	mov	al, byte ptr ds:[5CCh]	;@0DE64
	add	byte ptr ds:[4805h], dl	;@0DE67
	add	byte ptr [bp+di], al	;@0DE6B
	add	byte ptr [bx+si], al	;@0DE6D
	add	byte ptr [bx+si], al	;@0DE6F
	add	byte ptr [bx+si], al	;@0DE71
	add	byte ptr [bx+si], al	;@0DE73
	add	byte ptr [bx+si], al	;@0DE75
	add	byte ptr [bx+si], al	;@0DE77
	add	byte ptr [bx+si], al	;@0DE79
	add	byte ptr [bx+si], al	;@0DE7B
	add	byte ptr [bx+si], al	;@0DE7D
	db	0, 0CDh	; add ch, cl	;@0DE7F
	aas	;@0DE81
	add	byte ptr [bx+si], al	;@0DE82
	db	0, 0CDh	; add ch, cl	;@0DE84
	aas	;@0DE86
	std	;@0DE87
	add	al, byte ptr [bx+si]	;@0DE88
	int	3Fh	;@0DE8A
	outsb	;@0DE8C
	add	al, 0	;@0DE8D
	db	0, 0CDh	; add ch, cl	;@0DE8F
	aas	;@0DE91
	add	byte ptr [bx+si], al	;@0DE92
	db	0, 0D2h	; add dl, dl	;@0DE94
	add	ax, 6800h	;@0DE96
	or	byte ptr [si], al	;@0DE99
	add	byte ptr [di], al	;@0DE9B
	add	byte ptr [bx+si], al	;@0DE9D
	add	byte ptr [bx+si], al	;@0DE9F
	add	byte ptr [bx+si], al	;@0DEA1
	add	byte ptr [bx+si], al	;@0DEA3
	add	byte ptr [bx+si], al	;@0DEA5
	add	byte ptr [bx+si], al	;@0DEA7
	add	byte ptr [bx+si], al	;@0DEA9
	add	byte ptr [bx+si], al	;@0DEAB
	add	byte ptr [bx+si], al	;@0DEAD
	db	0	; add ch, cl	;@0DEAF
Y0DE50	ends

Y0DEB0	segment para public 'CODE'
	assume	cs:Y0DEB0
UNLINK_NODE:	int	3Fh	;@0DEB0
	cbw	;@0DEB2
	pop	es	;@0DEB3
	db	0, 0CDh	; add ch, cl	;@0DEB4
	aas	;@0DEB6
	pop	cx	;@0DEB7
	add	al, 0	;@0DEB8
INVERT_JUMP_CONDITION:	int	3Fh	;@0DEBA
	pusha	;@0DEBC
	pop	es	;@0DEBD
	db	0, 0CDh	; add ch, cl	;@0DEBE
	aas	;@0DEC0
	add	byte ptr [bx+si], al	;@0DEC1
	db	0, 0CDh	; add ch, cl	;@0DEC3
	aas	;@0DEC5
	and	ax, word ptr [bx+di]	;@0DEC6
	add	byte ptr [bx+si], al	;@0DEC8
	add	byte ptr [bx+si], al	;@0DECA
	add	byte ptr [bx+si], al	;@0DECC
	add	byte ptr [bx+si], al	;@0DECE
	int	3Fh	;@0DED0
	add	byte ptr [bx+si], al	;@0DED2
	sbb	dl, 5	;@0DED4
	add	byte ptr [bx+si], al	;@0DED7
	or	byte ptr [si], al	;@0DED9
	add	byte ptr [bx+di], al	;@0DEDB
	add	byte ptr [bx+si], al	;@0DEDD
	db	0	; add byte ptr [bx+si], al	;@0DEDF
Y0DEB0	ends

Y0DEE0	segment para public 'CODE'
	assume	cs:Y0DEE0
	db	10h dup (0)	;@0DEE0
CROSS_JUMP_PASS_STUB:	int	3Fh	;@0DEF0
	adc	al, byte ptr ds:[0]	;@0DEF2
	add	byte ptr [bx+si], al	;@0DEF6
	add	byte ptr [bx+si], al	;@0DEF8
	add	byte ptr [bx+si], al	;@0DEFA
	add	byte ptr [bx+si], al	;@0DEFC
	add	byte ptr [bx+si], al	;@0DEFE
	int	3Fh	;@0DF00
	add	byte ptr [bx+si], al	;@0DF02
	nop	;@0DF04
	loop	@@1	;@0DF05
	add	byte ptr [bp+di+6], ch	;@0DF07
	add	al, byte ptr [bx+si]	;@0DF0A
@@1:	add	word ptr [bx+si], ax	;@0DF0C
	add	byte ptr [bx+si], al	;@0DF0E
	add	byte ptr [bx+si], al	;@0DF10
	add	byte ptr [bx+si], al	;@0DF12
	add	byte ptr [bx+si], al	;@0DF14
	add	byte ptr [bx+si], al	;@0DF16
	add	byte ptr [bx+si], al	;@0DF18
	add	byte ptr [bx+si], al	;@0DF1A
	add	byte ptr [bx+si], al	;@0DF1C
	add	byte ptr [bx+si], al	;@0DF1E
ELIMINATE_REDUNDANT_LOADS:	int	3Fh	;@0DF20
	push	si	;@0DF22
	add	al, byte ptr [bx+si]	;@0DF23
	add	byte ptr [bx+si], al	;@0DF25
	add	byte ptr [bx+si], al	;@0DF27
	add	byte ptr [bx+si], al	;@0DF29
	add	byte ptr [bx+si], al	;@0DF2B
	add	byte ptr [bx+si], al	;@0DF2D
	db	0	; add ch, cl	;@0DF2F
Y0DEE0	ends

Y0DF30	segment para public 'CODE'
	assume	cs:Y0DF30
	db	0CDh, 3Fh, 0, 0, 10h, 0E9h, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@0DF30
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 20h
	db	0E9h, 5, 0, 6Fh, 2, 14h, 0, 1, 0, 0, 0
Y0DF30	ends

Y0DF60	segment para public 'CODE'
	assume	cs:Y0DF60
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0DF60
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 0B0h, 0EBh
	db	5, 0, 3, 1, 0, 0, 2, 0, 0, 0
Y0DF60	ends
	end
