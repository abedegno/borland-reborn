	.286p
	locals

Y0D1D0	segment para public 'CODE'
	assume	cs:Y0D1D0
	db	3Fh, 3, 1Eh, 0	;@0D1D0
BCC_STMT_BUILD:	int	3Fh	;@0D1D4
	inc	di	;@0D1D6
	add	word ptr [bx+si], ax	;@0D1D7
STBEGIN:	int	3Fh	;@0D1D9
	clc	;@0D1DB
	sbb	al, 0	;@0D1DC
STINIT:	int	3Fh	;@0D1DE
	db	8Fh, 1Fh, 0	;@0D1E0
BCC_STATEMENT_MAIN:	int	3Fh	;@0D1E3
	add	byte ptr [bx+si], al	;@0D1E5
	db	0, 0CDh	; add ch, cl	;@0D1E7
	aas	;@0D1E9
	out	dx, ax	;@0D1EA
	push	cs	;@0D1EB
	db	0, 0CDh	; add ch, cl	;@0D1EC
	aas	;@0D1EE
	and	al, 1Dh	;@0D1EF
	db	0, 0CDh	; add ch, cl	;@0D1F1
	aas	;@0D1F3
	pop	bp	;@0D1F4
	sbb	al, 0	;@0D1F5
	add	byte ptr [bx+si], al	;@0D1F7
	add	byte ptr [bx+si], al	;@0D1F9
	add	byte ptr [bx+si], al	;@0D1FB
	add	byte ptr [bx+si], al	;@0D1FD
	db	0	; add ch, cl	;@0D1FF
Y0D1D0	ends

Y0D200	segment para public 'CODE'
	assume	cs:Y0D200
	db	0CDh, 3Fh, 0, 0, 20h, 0EFh, 3, 0, 0D3h, 2Eh, 68h, 1, 0Eh, 0, 0	;@0D200
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
TYPECHECK_OPERATOR:	int	3Fh	;@0D220
	inc	dx	;@0D222
	push	ds	;@0D223
	db	0, 0CDh	; add ch, cl	;@0D224
	aas	;@0D226
	mov	al, 0Dh	;@0D227
	db	0, 0CDh	; add ch, cl	;@0D229
	aas	;@0D22B
	add	byte ptr [bx+si], al	;@0D22C
	db	0, 0CDh	; add ch, cl	;@0D22E
	aas	;@0D230
	xchg	ax, di	;@0D231
	db	2Eh, 0, 0CDh	; add ch, cl	;@0D232
	db	3Fh	; aas	;@0D235
	mov	sp, 2Eh	;@0D236
PARSE_TYPE_NAME_PAREN:	int	3Fh	;@0D239
	xor	word ptr [di], cx	;@0D23B
	db	0, 0CDh	; add ch, cl	;@0D23D
	aas	;@0D23F
Y0D200	ends

Y0D240	segment para public 'CODE'
	assume	cs:Y0D240
	db	1Eh, 2Dh, 0	;@0D240
STCVTD:	int	3Fh	;@0D243
	scasw	;@0D245
	sbb	ax, 0CD00h	;@0D246
	aas	;@0D249
	neg	word ptr [bp+di]	;@0D24A
	db	0, 0CDh	; add ch, cl	;@0D24C
	aas	;@0D24E
	out	dx, ax	;@0D24F
	sub	ax, 0CD00h	;@0D250
	aas	;@0D253
	jns	L0D267	;@0D254
	db	0, 0CDh	; add ch, cl	;@0D256
	aas	;@0D258
	lodsb	;@0D259
	sbb	ax, word ptr [bx+si]	;@0D25A
STBIN3:	int	3Fh	;@0D25C
	mov	di, 2Ah	;@0D25E
STCVTC:	int	3Fh	;@0D261
	inc	si	;@0D263
	sbb	ax, 0	;@0D264
L0D267:	add	byte ptr [bx+si], al	;@0D267
	add	byte ptr [bx+si], al	;@0D269
	add	byte ptr [bx+si], al	;@0D26B
	add	byte ptr [bx+si], al	;@0D26D
	db	0	; add ch, cl	;@0D26F
Y0D240	ends

Y0D270	segment para public 'CODE'
	assume	cs:Y0D270
	db	0CDh, 3Fh, 0, 0, 0B0h, 1Fh, 4, 0, 7Bh, 0, 8, 0, 2, 0, 0, 0, 0	;@0D270
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
PARSE_PP_IF_EXPRESSION:	int	3Fh	;@0D290
	add	byte ptr [bx+si], al	;@0D292
	db	0, 0CDh	; add ch, cl	;@0D294
	aas	;@0D296
	push	cs	;@0D297
	add	byte ptr [bx+si], al	;@0D298
	add	byte ptr [bx+si], al	;@0D29A
	add	byte ptr [bx+si], al	;@0D29C
	add	byte ptr [bx+si], al	;@0D29E
Y0D270	ends

Y0D2A0	segment para public 'CODE'
	assume	cs:Y0D2A0
	db	0CDh, 3Fh, 0, 0, 40h, 20h, 4, 0, 4Ah, 19h, 4Ch, 0, 5, 0, 0, 0	;@0D2A0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
LOG2_POWER_OF_TWO:	int	3Fh	;@0D2C0
	dec	bx	;@0D2C2
	push	ss	;@0D2C3
	db	0, 0CDh	; add ch, cl	;@0D2C4
	aas	;@0D2C6
	mov	al, byte ptr ds:[16h]	;@0D2C7
FOLD_CONSTANT_NODE:	int	3Fh	;@0D2CA
	or	al, byte ptr es:[bx+si]	;@0D2CC
FOLD_EXPRESSION:	int	3Fh	;@0D2CF
	loop	@@1	;@0D2D1
	db	0, 0CDh	; add ch, cl	;@0D2D3
@@1:	aas	;@0D2D5
	add	byte ptr [bx+si], al	;@0D2D6
	add	byte ptr [bx+si], al	;@0D2D8
	add	byte ptr [bx+si], al	;@0D2DA
	add	byte ptr [bx+si], al	;@0D2DC
	add	byte ptr [bx+si], al	;@0D2DE
	int	3Fh	;@0D2E0
	add	byte ptr [bx+si], al	;@0D2E2
	db	0F0h, 39h, 4, 0, 7Bh, 0Eh, 4Ah, 0, 17h, 0, 0, 0, 0, 0, 0, 0, 0	;@0D2E4
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D2A0	ends

Y0D300	segment para public 'CODE'
	assume	cs:Y0D300
SET_SYMBOL_FLAG_20:	int	3Fh	;@0D300
	xchg	ax, bp	;@0D302
	or	ax, 0CD00h	;@0D303
	aas	;@0D306
	xchg	word ptr [bp+di], cx	;@0D307
	db	0, 0CDh	; add ch, cl	;@0D309
	aas	;@0D30B
	inc	bx	;@0D30C
	add	byte ptr [bx+si], al	;@0D30D
GET_SYMBOL_WORD_10:	int	3Fh	;@0D30F
	inc	dx	;@0D311
	push	cs	;@0D312
	db	0, 0CDh	; add ch, cl	;@0D313
	aas	;@0D315
	cmc	;@0D316
	or	byte ptr [bx+si], al	;@0D317
SET_SYMBOL_OFFSET:	int	3Fh	;@0D319
	ror	word ptr [di], cl	;@0D31B
	db	0, 0CDh	; add ch, cl	;@0D31D
	aas	;@0D31F
	jno	@@1+4	;@0D320
	db	0, 0CDh	; add ch, cl	;@0D322
	aas	;@0D324
@@1:	db	0EAh, 0Dh, 0, 0CDh, 3Fh	; ljmp 0x3fcd:0xd	;@0D325
	add	word ptr ds:[0CD00h], cx	;@0D32A
	aas	;@0D32E
	sbb	byte ptr ds:[0CD00h], cl	;@0D32F
	aas	;@0D333
	db	2Eh, 0Eh	; push cs	;@0D334
	db	0, 0CDh	; add ch, cl	;@0D336
	aas	;@0D338
	jae	@@2+1	;@0D339
	db	0, 0CDh	; add ch, cl	;@0D33B
	aas	;@0D33D
	stosw	;@0D33E
	or	ax, 0CD00h	;@0D33F
	aas	;@0D342
	push	si	;@0D343
	push	cs	;@0D344
	db	0, 0CDh	; add ch, cl	;@0D345
	aas	;@0D347
@@2:	fld	qword ptr [bx+si]	;@0D348
	db	0, 0CDh	; add ch, cl	;@0D34A
	aas	;@0D34C
	test	byte ptr [si], cl	;@0D34D
	db	0, 0CDh	; add ch, cl	;@0D34F
	aas	;@0D351
	db	68h, 0Dh, 0	; push 0Dh	;@0D352
GET_SYMBOL_SEGMENT:	db	0CDh, 3Fh	; int 3Fh	;@0D355
	mov	di, 0Dh	;@0D357
DECLARE_SYMBOL:	int	3Fh	;@0D35A
	imul	ax, word ptr [bx+di], 0	;@0D35C
ADD_STRUCT_MEMBER:	int	3Fh	;@0D35F
	cmc	;@0D361
	or	al, byte ptr [bx+si]	;@0D362
CREATE_SCOPE:	int	3Fh	;@0D364
	add	byte ptr [bx+si], al	;@0D366
	db	0, 0CDh	; add ch, cl	;@0D368
	aas	;@0D36A
	cmp	cx, word ptr [di]	;@0D36B
	db	0, 0CDh	; add ch, cl	;@0D36D
	aas	;@0D36F
Y0D300	ends

Y0D370	segment para public 'CODE'
	assume	cs:Y0D370
	db	1Bh, 0Dh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0D370
	db	0, 0, 0C0h, 48h, 4, 0, 4Fh, 18h, 52h, 1, 3, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Y0D370	ends

Y0D3A0	segment para public 'CODE'
	assume	cs:Y0D3A0
PARSE_BLOCK_BODY:	int	3Fh	;@0D3A0
	add	byte ptr [bx+si], al	;@0D3A2
	db	0, 0CDh	; add ch, cl	;@0D3A4
	aas	;@0D3A6
	ret	;@0D3A7
	db	14h, 0	;@0D3A8
MARK_SYMBOLS_REFERENCED:	int	3Fh	;@0D3AA
	int	3	;@0D3AC
	adc	ax, 0	;@0D3AD
	int	3Fh	;@0D3B0
	add	byte ptr [bx+si], al	;@0D3B2
	and	byte ptr [bp+si+4], 0	;@0D3B4
	mov	word ptr [bx], cx	;@0D3B8
	xor	al, 0	;@0D3BA
	sldt	word ptr [bx+si]	;@0D3BC
	add	byte ptr [bx+si], al	;@0D3BF
	add	byte ptr [bx+si], al	;@0D3C1
	add	byte ptr [bx+si], al	;@0D3C3
	add	byte ptr [bx+si], al	;@0D3C5
	add	byte ptr [bx+si], al	;@0D3C7
	add	byte ptr [bx+si], al	;@0D3C9
	add	byte ptr [bx+si], al	;@0D3CB
	add	byte ptr [bx+si], al	;@0D3CD
	db	0, 0CDh	; add ch, cl	;@0D3CF
	aas	;@0D3D1
	jcxz	@@1+1	;@0D3D2
@@1:	db	0, 0CDh	; add ch, cl	;@0D3D4
	aas	;@0D3D6
	xchg	ax, sp	;@0D3D7
	add	byte ptr [bx+si], al	;@0D3D8
NEW_EXPR_NODE:	int	3Fh	;@0D3DA
	and	al, 0	;@0D3DC
	db	0, 0CDh	; add ch, cl	;@0D3DE
Y0D3A0	ends

Y0D3E0	segment para public 'CODE'
	assume	cs:Y0D3E0
	db	3Fh, 30h, 0Bh, 0	;@0D3E0
NARROW_INTEGER_EXPR:	int	3Fh	;@0D3E4
	movsb	;@0D3E6
	or	al, byte ptr [bx+si]	;@0D3E7
SEG_PTR_FROM_FAR_ADJUST:	int	3Fh	;@0D3E9
	dec	byte ptr ds:[0CD00h]	;@0D3EB
	aas	;@0D3EF
	sti	;@0D3F0
	or	al, byte ptr [bx+si]	;@0D3F1
EXPR_POOL_IS_RESET:	int	3Fh	;@0D3F3
	add	byte ptr [bx+si], al	;@0D3F5
	db	0, 0CDh	; add ch, cl	;@0D3F7
	aas	;@0D3F9
	adc	ax, word ptr [bx+si]	;@0D3FA
	db	0, 0CDh	; add ch, cl	;@0D3FC
	aas	;@0D3FE
	jne	@@1+1	;@0D3FF
@@1:	db	0, 0CDh	; add ch, cl	;@0D401
	aas	;@0D403
	dec	ax	;@0D404
	add	al, byte ptr [bx+si]	;@0D405
NEW_EXPR_NODE_MODE:	int	3Fh	;@0D407
	add	ax, word ptr [bx+di]	;@0D409
	db	0, 0CDh	; add ch, cl	;@0D40B
	aas	;@0D40D
	cmp	ax, 0Eh	;@0D40E
CONVERT_EXPRESSION_TYPE:	int	3Fh	;@0D411
	test	ax, 2	;@0D413
EXPAND_POST_INC_DEC:	int	3Fh	;@0D416
	mov	byte ptr [bp+di], cl	;@0D418
	add	byte ptr [bx+si], al	;@0D41A
	add	byte ptr [bx+si], al	;@0D41C
	add	byte ptr [bx+si], al	;@0D41E
	int	3Fh	;@0D420
	add	byte ptr [bx+si], al	;@0D422
	push	ax	;@0D424
	jb	@@1+1	;@0D425
	add	byte ptr [bp+0Dh], al	;@0D427
@@1:	jp	@@2	;@0D42A
@@2:	or	word ptr [bx+si], ax	;@0D42C
	add	byte ptr [bx+si], al	;@0D42E
	add	byte ptr [bx+si], al	;@0D430
	add	byte ptr [bx+si], al	;@0D432
	add	byte ptr [bx+si], al	;@0D434
	add	byte ptr [bx+si], al	;@0D436
	add	byte ptr [bx+si], al	;@0D438
	add	byte ptr [bx+si], al	;@0D43A
	add	byte ptr [bx+si], al	;@0D43C
	add	byte ptr [bx+si], al	;@0D43E
BCC_STMT_BEGIN:	int	3Fh	;@0D440
	pusha	;@0D442
	add	byte ptr [bx+si], al	;@0D443
BCC_STMT_BIND_TYPE:	int	3Fh	;@0D445
	or	word ptr [bx+di], 0	;@0D447
PARSE_PARAMETER_LIST:	int	3Fh	;@0D44A
	out	5, al	;@0D44C
	db	0, 0CDh	; add ch, cl	;@0D44E
	aas	;@0D450
	xor	word ptr [bx+si], ax	;@0D451
	db	0, 0CDh	; add ch, cl	;@0D453
	aas	;@0D455
	push	cx	;@0D456
	add	byte ptr [bx+si], al	;@0D457
PTR_TYPE_FOR_MODIFIER:	int	3Fh	;@0D459
	jns	BCC_STMT_DECL_NEW+1	;@0D45B
	db	0, 0CDh	; add ch, cl	;@0D45D
	aas	;@0D45F
	db	0E9h, 0Bh, 0	; jmp near ptr L0D46E	;@0D460
IS_BARE_DECLARATOR:	int	3Fh	;@0D463
	int	3	;@0D465
	or	ax, word ptr [bx+si]	;@0D466
BCC_STMT_DECL_NEW:	int	3Fh	;@0D468
	add	byte ptr [bx+si], al	;@0D46A
	add	byte ptr [bx+si], al	;@0D46C
L0D46E:	add	byte ptr [bx+si], al	;@0D46E
	int	3Fh	;@0D470
	add	byte ptr [bx+si], al	;@0D472
	db	20h, 80h, 4, 0	; and byte ptr [bx+si+4], al	;@0D474
	db	30h, 0	; xor byte ptr [bx+si], al	;@0D478
	add	byte ptr [bx+si], al	;@0D47A
	add	word ptr [bx+si], ax	;@0D47C
	add	byte ptr [bx+si], al	;@0D47E
Y0D3E0	ends

Y0D480	segment para public 'CODE'
	assume	cs:Y0D480
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0	;@0D480
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0, 60h, 80h
	db	4, 0, 0Bh, 0Bh, 3Ah, 0, 14h, 0, 0, 0
Y0D480	ends

Y0D4B0	segment para public 'CODE'
	assume	cs:Y0D4B0
	db	10h dup (0)	;@0D4B0
NEW_ARRAY_TYPE:	int	3Fh	;@0D4C0
	adc	word ptr [bx+si], ax	;@0D4C2
	db	0, 0CDh	; add ch, cl	;@0D4C4
	aas	;@0D4C6
	mov	al, 1	;@0D4C7
	db	0, 0CDh	; add ch, cl	;@0D4C9
	aas	;@0D4CB
	pop	si	;@0D4CC
	add	word ptr [bx+si], ax	;@0D4CD
RESERVE_ARRAY_STORAGE:	int	3Fh	;@0D4CF
	xor	byte ptr [bx+si], cl	;@0D4D1
	db	0, 0CDh	; add ch, cl	;@0D4D3
	aas	;@0D4D5
	mov	byte ptr ds:[0Ah], al	;@0D4D6
ALLOC_ARRAY_SEGMENTS:	int	3Fh	;@0D4D9
	db	0EAh, 7, 0, 0CDh, 3Fh	; ljmp 0x3fcd:7	;@0D4DB
	push	cs	;@0D4E0
	add	word ptr [bx+si], ax	;@0D4E1
GET_TYPE_QUALIFIERS:	int	3Fh	;@0D4E3
	db	7Ch, 0Ah	; jl L0D4F0+1	;@0D4E5
	db	0, 0CDh	; add ch, cl	;@0D4E7
	aas	;@0D4E9
	db	0F3h, 9, 0	; or word ptr [bx+si], ax	;@0D4EA
GET_TYPE_FLAGS:	db	0CDh, 3Fh	; int 3Fh	;@0D4ED
	inc	bp	;@0D4EF
L0D4F0:	or	al, byte ptr [bx+si]	;@0D4F0
GET_TYPE_FLAGS_ALT:	int	3Fh	;@0D4F2
	db	8Fh, 0Ah, 0	;@0D4F4
COUNT_PARAMETERS:	int	3Fh	;@0D4F7
	mov	ch, 0Ah	;@0D4F9
	db	0, 0CDh	; add ch, cl	;@0D4FB
	aas	;@0D4FD
	jmp	short IS_BASED_POINTER	;@0D4FE
	db	0	;@0D500
IS_BASED_POINTER:	int	3Fh	;@0D501
	pop	ax	;@0D503
	or	al, byte ptr [bx+si]	;@0D504
TYPE_RECORDS_COMPATIBLE:	int	3Fh	;@0D506
	and	word ptr [bp+di], ax	;@0D508
	db	0, 0CDh	; add ch, cl	;@0D50A
	aas	;@0D50C
	clts	;@0D50D
	db	0, 0CDh	; add ch, cl	;@0D50F
	aas	;@0D511
	daa	;@0D512
	or	word ptr [bx+si], ax	;@0D513
ADVANCE_IF_SEGMENT_FULL:	int	3Fh	;@0D515
	add	byte ptr [bx+di], cl	;@0D517
	db	0, 0CDh	; add ch, cl	;@0D519
	aas	;@0D51B
	add	byte ptr [bx+si], al	;@0D51C
	db	0, 0CDh	; add ch, cl	;@0D51E
Y0D4B0	ends

Y0D520	segment para public 'CODE'
	assume	cs:Y0D520
	db	3Fh, 0CDh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh	;@0D520
	db	0, 0, 0B0h, 8Bh, 4, 0, 61h, 13h, 8Eh, 1, 6, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
EMIT_OBJ_SYMBOLS:	int	3Fh	;@0D550
	add	byte ptr [bx+si], al	;@0D552
	db	0, 0CDh	; add ch, cl	;@0D554
	aas	;@0D556
	je	L0D568	;@0D557
	db	0, 0CDh	; add ch, cl	;@0D559
	aas	;@0D55B
	xlat	;@0D55C
	or	ax, word ptr [bx+si]	;@0D55D
EMIT_SCOPE_DEBUG_INFO:	int	3Fh	;@0D55F
	add	cx, word ptr [di]	;@0D561
	db	0, 0CDh	; add ch, cl	;@0D563
	aas	;@0D565
	aad	0Ch	;@0D566
L0D568:	db	0, 0CDh	; add ch, cl	;@0D568
	aas	;@0D56A
	into	;@0D56B
	adc	byte ptr [bx+si], al	;@0D56C
	add	byte ptr [bx+si], al	;@0D56E
Y0D520	ends
	end
