	.286
	locals
CODE0	segment byte public 'CODE'
CODE0	ends
DATA	segment byte public 'DATA'
DATA	ends
BSS	segment byte public 'BSS'
BSS	ends
DGROUP	group	DATA,BSS
	public	L03226
	public	L03244
	public	L03262
	public	L03280
	public	L0329E
	public	L0334C
	public	L13ADA
	public	L13B2C
	public	L13B4E
	public	L13B66
	public	L13B89
	public	L13B98
	public	L13BB2
	public	L13BC0
	public	L13BDF
	public	L13C07
	public	L13C2F
	public	L13C5F
	public	L13C77
	public	L13C99
	public	L13C9F
	public	L13D2A
	public	L13D39
	public	L13D9C
	public	L13DC1
	public	L13DD4
	public	L13E14
	public	L13E35
	public	L13E53
	public	L13F76
	public	L13FAF
	public	L14004
	public	L14062
	public	L14094
	public	L140BC
	public	L140CF
	public	L140D6
	public	L14188
	public	L1418E
	public	L141D2
	public	L141D8
	public	L1429B
	public	L142B5
	public	L142E4
	public	L142EA
	public	L14315
	public	L14330
	public	L14358
	public	L1437B
	public	L14385
	public	L143B0
	public	L143B8
	public	L143BF
	public	L143D4
	public	L14475
	extrn	L04A95:near
	extrn	L0F0A1:far
	extrn	L0F3C5:near
	extrn	L0FA44:near
	extrn	L0FAA6:near
	extrn	L0FAFB:near
	extrn	L0FCE0:near
	extrn	L112DA:near
	extrn	L112E6:near
	extrn	L112F6:near
	extrn	L12931:far
	extrn	L1294D:far
	extrn	L12959:far
	extrn	L12964:far
	extrn	L14551:near

CODE0	segment byte public 'CODE'
	assume	cs:CODE0
L03226:	mov	es, ax	;@03226
	mov	bx, word ptr es:[16h]	;@03228
	and	bx, bx	;@0322D
	je	@@1	;@0322F
	ret	;@03231
@@1:	mov	bx, word ptr es:[14h]	;@03232
	push	es	;@03237
	call	far ptr L12931	;@03238
	pop	es	;@0323D
	mov	word ptr es:[16h], bx	;@0323E
	ret	;@03243
L03244:	mov	es, ax	;@03244
	mov	bx, word ptr es:[18h]	;@03246
	and	bx, bx	;@0324B
	je	L03250	;@0324D
	ret	;@0324F
L03250:	mov	bx, word ptr es:[14h]	;@03250
	push	es	;@03255
	call	far ptr L1294D	;@03256
	pop	es	;@0325B
	mov	word ptr es:[18h], bx	;@0325C
	ret	;@03261
L03262:	mov	es, ax	;@03262
	mov	bx, word ptr es:[0Ah]	;@03264
	and	bx, bx	;@03269
	je	@@1	;@0326B
	ret	;@0326D
@@1:	mov	bx, word ptr es:[14h]	;@0326E
	push	es	;@03273
	call	far ptr L12959	;@03274
	pop	es	;@03279
	mov	word ptr es:[0Ah], bx	;@0327A
	ret	;@0327F
L03280:	mov	es, ax	;@03280
	mov	bx, word ptr es:[1Ah]	;@03282
	and	bx, bx	;@03287
	je	@@1	;@03289
	ret	;@0328B
@@1:	mov	bx, word ptr es:[14h]	;@0328C
	push	es	;@03291
	call	far ptr L12964	;@03292
	pop	es	;@03297
	mov	word ptr es:[1Ah], bx	;@03298
	ret	;@0329D
L0329E:	push	es	;@0329E
	mov	ax, word ptr es:[0Ch]	;@0329F
	jmp	short @@2	;@032A3
@@1:	mov	ax, word ptr es:[2]	;@032A5
@@2:	or	ax, ax	;@032A9
	je	@@4	;@032AB
	mov	es, ax	;@032AD
	mov	al, byte ptr es:[4]	;@032AF
	push	es	;@032B3
	push	si	;@032B4
	cmp	al, 2	;@032B5
	je	@@5	;@032B7
	cmp	al, 3	;@032B9
	je	@@6	;@032BB
	cmp	al, 7	;@032BD
	je	@@7	;@032BF
	cmp	al, 6	;@032C1
	je	@@8	;@032C3
	cmp	al, 1	;@032C5
	je	@@9	;@032C7
	clc	;@032C9
@@3:	pop	si	;@032CA
	pop	es	;@032CB
	jae	@@1	;@032CC
@@4:	pop	es	;@032CE
	mov	ax, word ptr es:[10h]	;@032CF
	mov	dx, word ptr es:[12h]	;@032D3
	ret	;@032D8
@@5:	mov	bx, word ptr es:[6]	;@032D9
	mov	dx, word ptr es:[8]	;@032DE
	mov	ax, word ptr es:[14h]	;@032E3
	mov	cx, word ptr es:[16h]	;@032E7
	call	word ptr [si]	;@032EC
	jmp	@@3	;@032EE
@@6:	mov	bx, word ptr es:[8]	;@032F0
	mov	dx, word ptr es:[0Ah]	;@032F5
	mov	cx, word ptr es:[0Ch]	;@032FA
	mov	di, 0Eh	;@032FF
	call	word ptr [si+2]	;@03302
	jmp	@@3	;@03305
@@7:	mov	bx, word ptr es:[8]	;@03307
	mov	dx, word ptr es:[0Ah]	;@0330C
	mov	cx, word ptr es:[0Ch]	;@03311
	call	word ptr [si+4]	;@03316
	jmp	@@3	;@03319
@@8:	mov	cl, byte ptr es:[0Ah]	;@0331B
	mov	bx, word ptr es:[0Bh]	;@03320
	mov	dx, word ptr es:[0Dh]	;@03325
	mov	ax, word ptr es:[0Fh]	;@0332A
	mov	di, word ptr es:[11h]	;@0332E
	call	word ptr [si+6]	;@03333
	jmp	@@3	;@03336
@@9:	mov	bx, word ptr es:[6]	;@03338
	mov	dx, word ptr es:[8]	;@0333D
	call	word ptr [si+8]	;@03342
	jmp	@@3	;@03345
	db	0	;@03347
L03348:	call	L04A95	;@03348
	retf	;@0334B
L0334C:	xor	ax, ax	;@0334C
	mov	word ptr ds:[5046h], ax	;@0334E
	mov	word ptr ds:[5048h], ax	;@03351
	mov	word ptr ds:[504Ah], ax	;@03354
	mov	word ptr ds:[504Ch], ax	;@03357
	mov	ax, ss	;@0335A
	mov	es, ax	;@0335C
	mov	di, 5152h	;@0335E
	mov	cx, 59h	;@03361
	xor	al, al	;@03364
	rep stosb	;@03366
	mov	word ptr ds:[5160h], 6020h	;@03368
	call	L0F3C5	;@0336E
	mov	word ptr ds:[5198h], 8Dh	;@03371
	mov	word ptr ds:[5166h], 0FFF3h	;@03377
	mov	word ptr ds:[5164h], 4040h	;@0337D
	test	word ptr ds:[38C4h], 20h	;@03383
	je	@@1	;@03389
	or	word ptr ds:[5198h], 0C00h	;@0338B
@@1:	test	word ptr ds:[38C4h], 1000h	;@03391
	je	@@2	;@03397
	or	word ptr ds:[5198h], 10h	;@03399
@@2:	test	word ptr ds:[38C4h], 8000h	;@0339E
	je	@@3	;@033A4
	or	word ptr ds:[5198h], 4B0h	;@033A6
@@3:	test	word ptr ds:[38C4h], 80h	;@033AC
	je	@@4	;@033B2
	and	word ptr ds:[5198h], 0FF7Fh	;@033B4
@@4:	test	word ptr ds:[38C4h], 40h	;@033BA
	je	@@5	;@033C0
	or	word ptr ds:[5160h], 100h	;@033C2
@@5:	test	word ptr ds:[38C4h], 200h	;@033C8
	je	@@6	;@033CE
	or	word ptr ds:[5160h], 40h	;@033D0
@@6:	ret	;@033D5
CODE0	ends

C0F9B	segment byte public 'CODE'
	assume	cs:C0F9B
	db	0	;@13AD9
L13ADA:	xor	ax, ax	;@13ADA
	mov	cx, 1Fh	;@13ADC
	push	ss	;@13ADF
	pop	es	;@13AE0
	mov	di, 5026h	;@13AE1
	rep stosb	;@13AE4
	mov	word ptr ds:[502Ch], bx	;@13AE6
	push	dx	;@13AEA
@@1:	push	cs	;@13AEB
	call	L0FAFB	;@13AEC
	cmp	ax, 400h	;@13AEF
	jae	@@2	;@13AF2
	call	far ptr L0F0A1	;@13AF4
	jae	@@1	;@13AF9
	cmp	ax, 41h	;@13AFB
	jae	@@3	;@13AFE
	mov	ax, 41h	;@13B00
	jmp	short @@3	;@13B03
@@2:	mov	ax, 400h	;@13B05
@@3:	pop	dx	;@13B08
	mov	cx, ax	;@13B09
	push	cs	;@13B0B
	call	L0FA44	;@13B0C
	mov	word ptr ds:[5028h], ax	;@13B0F
	shl	cx, 1	;@13B12
	shl	cx, 1	;@13B14
	shl	cx, 1	;@13B16
	shl	cx, 1	;@13B18
	mov	word ptr ds:[501Ah], cx	;@13B1A
	push	cs	;@13B1E
	call	L112DA	;@13B1F
	jae	@@4	;@13B22
	jmp	L144BC	;@13B24
@@4:	mov	word ptr ds:[5040h], bx	;@13B27
	ret	;@13B2B
L13B2C:	mov	ax, word ptr ds:[5028h]	;@13B2C
	mov	dx, word ptr ds:[501Ah]	;@13B2F
	mov	cl, 4	;@13B33
	shr	dx, cl	;@13B35
	push	cs	;@13B37
	call	L0FAA6	;@13B38
	mov	bx, word ptr ds:[5040h]	;@13B3B
	and	bx, bx	;@13B3F
	je	@@1	;@13B41
	push	cs	;@13B43
	call	L112E6	;@13B44
	mov	word ptr ds:[5040h], 0	;@13B47
@@1:	ret	;@13B4D
L13B4E:	mov	di, word ptr ds:[502Ah]	;@13B4E
	and	di, di	;@13B52
	je	@@1	;@13B54
	mov	es, word ptr ds:[5028h]	;@13B56
	call	L14505	;@13B5A
@@1:	call	L13B2C	;@13B5D
	jb	@@2	;@13B60
	ret	;@13B62
@@2:	jmp	L144BC	;@13B63
L13B66:	mov	al, 80h	;@13B66
	call	L14551	;@13B68
	mov	ax, dx	;@13B6B
	call	L14532	;@13B6D
L13B70:	call	L144C7	;@13B70
	test	word ptr ds:[38C4h], 4	;@13B73
	jne	@@1	;@13B79
	mov	si, word ptr ds:[502Ch]	;@13B7B
	mov	al, byte ptr [si]	;@13B7F
	or	al, al	;@13B81
	je	@@1	;@13B83
	jmp	L14463	;@13B85
@@1:	ret	;@13B88
L13B89:	mov	al, 96h	;@13B89
	db	0E8h, 0C3h, 9	; call L14551	;@13B8B
	xor	al, al	;@13B8E
	stosb	;@13B90
	inc	word ptr ds:[502Eh]	;@13B91
	jmp	L144C7	;@13B95
L13B98:	mov	al, 80h	;@13B98
	db	0E8h, 0B4h, 9	; call L14551	;@13B9A
	mov	bx, di	;@13B9D
	inc	di	;@13B9F
@@1:	lodsb	;@13BA0
	or	al, al	;@13BA1
	je	@@2	;@13BA3
	stosb	;@13BA5
	jmp	@@1	;@13BA6
@@2:	mov	ax, di	;@13BA8
	sub	ax, bx	;@13BAA
	dec	ax	;@13BAC
	mov	byte ptr es:[bx], al	;@13BAD
	jmp	L13B70	;@13BB0
L13BB2:	mov	al, 88h	;@13BB2
	db	0E8h, 9Ah, 9	; call L14551	;@13BB4
	mov	al, 40h	;@13BB7
	stosb	;@13BB9
	mov	al, 0A1h	;@13BBA
	stosb	;@13BBC
	jmp	L144C7	;@13BBD
L13BC0:	mov	al, 88h	;@13BC0
	db	0E8h, 8Ch, 9	; call L14551	;@13BC2
	mov	al, 40h	;@13BC5
	stosb	;@13BC7
	mov	al, 0A2h	;@13BC8
	stosb	;@13BCA
	mov	al, 1	;@13BCB
	stosb	;@13BCD
	jmp	L144C7	;@13BCE
L13BD1:	mov	al, 88h	;@13BD1
	call	L14551	;@13BD3
	mov	al, 0C0h	;@13BD6
	stosb	;@13BD8
	mov	al, 9Eh	;@13BD9
	stosb	;@13BDB
	jmp	L144C7	;@13BDC
L13BDF:	mov	dx, ax	;@13BDF
	mov	al, 88h	;@13BE1
	call	L14551	;@13BE3
	mov	al, 0C0h	;@13BE6
	stosb	;@13BE8
	mov	al, 9Fh	;@13BE9
	stosb	;@13BEB
	mov	ax, dx	;@13BEC
	xor	ch, ch	;@13BEE
	push	es	;@13BF0
	push	di	;@13BF1
	push	cs	;@13BF2
	call	L0FCE0	;@13BF3
	mov	si, di	;@13BF6
	mov	ax, es	;@13BF8
	mov	ds, ax	;@13BFA
	pop	di	;@13BFC
	pop	es	;@13BFD
	rep movsb	;@13BFE
	mov	ax, ss	;@13C00
	mov	ds, ax	;@13C02
	jmp	L144C7	;@13C04
L13C07:	test	word ptr ds:[38C4h], 4	;@13C07
	jne	@@2	;@13C0D
	push	ax	;@13C0F
	mov	al, 88h	;@13C10
	db	0E8h, 3Ch, 9	; call L14551	;@13C12
	mov	al, 40h	;@13C15
	stosb	;@13C17
	mov	al, 0E9h	;@13C18
	stosb	;@13C1A
	pop	ax	;@13C1B
	and	cl, cl	;@13C1C
	je	@@1	;@13C1E
	push	ax	;@13C20
	mov	ax, bx	;@13C21
	stosw	;@13C23
	mov	ax, dx	;@13C24
	stosw	;@13C26
	pop	ax	;@13C27
	call	L14532	;@13C28
@@1:	jmp	L144C7	;@13C2B
@@2:	ret	;@13C2E
L13C2F:	push	ax	;@13C2F
	mov	al, 88h	;@13C30
	db	0E8h, 1Ch, 9	; call L14551	;@13C32
	mov	al, 40h	;@13C35
	stosb	;@13C37
	mov	al, 0E8h	;@13C38
	stosb	;@13C3A
	mov	ax, bp	;@13C3B
	call	L14524	;@13C3D
	pop	ax	;@13C40
	and	bp, bp	;@13C41
	jne	@@1	;@13C43
	call	L14532	;@13C45
	mov	ax, bx	;@13C48
	stosw	;@13C4A
	mov	ax, dx	;@13C4B
	stosw	;@13C4D
	call	L144C7	;@13C4E
	inc	word ptr ds:[5036h]	;@13C51
	mov	ax, word ptr ds:[5036h]	;@13C55
	ret	;@13C58
@@1:	call	L144C7	;@13C59
	mov	ax, bp	;@13C5C
	ret	;@13C5E
L13C5F:	mov	dx, ax	;@13C5F
	mov	al, 88h	;@13C61
	call	L14551	;@13C63
	mov	al, 40h	;@13C66
	stosb	;@13C68
	mov	al, 0E0h	;@13C69
	stosb	;@13C6B
	mov	ax, dx	;@13C6C
	and	ah, 0Fh	;@13C6E
	call	L14524	;@13C71
	jmp	L144C7	;@13C74
L13C77:	mov	dx, ax	;@13C77
	mov	al, 88h	;@13C79
	call	L14551	;@13C7B
	mov	al, 40h	;@13C7E
	stosb	;@13C80
	mov	al, 0E1h	;@13C81
	stosb	;@13C83
	mov	ax, dx	;@13C84
	and	ah, 0Fh	;@13C86
	call	L14524	;@13C89
	xor	al, al	;@13C8C
	test	dh, 40h	;@13C8E
	je	@@1	;@13C91
	mov	al, 28h	;@13C93
@@1:	stosb	;@13C95
	jmp	L144C7	;@13C96
L13C99:	mov	byte ptr ds:[5021h], 0	;@13C99
	ret	;@13C9E
L13C9F:	inc	ax	;@13C9F
	cmp	byte ptr ds:[5021h], 0	;@13CA0
	je	L13D01	;@13CA5
	cmp	si, word ptr ds:[5022h]	;@13CA7
	jne	L13CFA	;@13CAB
	cmp	di, word ptr ds:[5024h]	;@13CAD
	jne	L13CFA	;@13CB1
L13CB3:	mov	cx, word ptr ds:[502Ah]	;@13CB3
	and	dx, dx	;@13CB7
	je	@@1	;@13CB9
	test	byte ptr ds:[5021h], 1	;@13CBB
	je	L13CFA	;@13CC0
	les	di, dword ptr ds:[5026h]	;@13CC2
	add	cx, 3FAh	;@13CC6
	cmp	di, cx	;@13CCA
	ja	L13CFA	;@13CCC
	stosw	;@13CCE
	mov	ax, bx	;@13CCF
	stosw	;@13CD1
	mov	ax, dx	;@13CD2
	stosw	;@13CD4
	mov	word ptr ds:[5026h], di	;@13CD5
	ret	;@13CD9
@@1:	test	byte ptr ds:[5021h], 1	;@13CDA
	jne	L13CFA	;@13CDF
	les	di, dword ptr ds:[5026h]	;@13CE1
	add	cx, 3FCh	;@13CE5
	cmp	di, cx	;@13CE9
	ja	L13CF6	;@13CEB
	stosw	;@13CED
	mov	ax, bx	;@13CEE
	stosw	;@13CF0
	mov	word ptr ds:[5026h], di	;@13CF1
	ret	;@13CF5
L13CF6:	mov	di, word ptr ds:[5024h]	;@13CF6
L13CFA:	push	ax	;@13CFA
	push	di	;@13CFB
	call	L13D2A	;@13CFC
	pop	di	;@13CFF
	pop	ax	;@13D00
L13D01:	mov	word ptr ds:[5022h], si	;@13D01
	mov	word ptr ds:[5024h], di	;@13D05
	push	ax	;@13D09
	mov	al, 94h	;@13D0A
	and	dx, dx	;@13D0C
	je	@@1	;@13D0E
	or	al, 1	;@13D10
@@1:	mov	byte ptr ds:[5021h], al	;@13D12
	call	L14551	;@13D15
	mov	ax, word ptr ds:[5024h]	;@13D18
	call	L14524	;@13D1B
	mov	ax, si	;@13D1E
	call	L14524	;@13D20
	mov	word ptr ds:[5026h], di	;@13D23
	pop	ax	;@13D27
	jmp	L13CB3	;@13D28
L13D2A:	cmp	byte ptr ds:[5021h], 0	;@13D2A
	je	@@1	;@13D2F
	les	di, dword ptr ds:[5026h]	;@13D31
	jmp	L144C7	;@13D35
@@1:	ret	;@13D38
L13D39:	call	L13D6B	;@13D39
@@1:	call	L13D5A	;@13D3C
	shl	al, 1	;@13D3F
	shl	al, 1	;@13D41
	shl	al, 1	;@13D43
	shl	al, 1	;@13D45
	mov	ah, al	;@13D47
	call	L13D5A	;@13D49
	or	al, ah	;@13D4C
	stosb	;@13D4E
	loop	@@1	;@13D4F
	mov	ax, ss	;@13D51
	mov	ds, ax	;@13D53
	mov	word ptr ds:[5026h], di	;@13D55
	ret	;@13D59
L13D5A:	lodsb	;@13D5A
	cmp	al, 39h	;@13D5B
	ja	@@1	;@13D5D
	sub	al, 30h	;@13D5F
	ret	;@13D61
@@1:	cmp	al, 61h	;@13D62
	jb	@@2	;@13D64
	sub	al, 20h	;@13D66
@@2:	sub	al, 37h	;@13D68
	ret	;@13D6A
L13D6B:	xor	ch, ch	;@13D6B
	shr	cx, 1	;@13D6D
	jcxz	@@2	;@13D6F
	cmp	byte ptr ds:[5021h], 0	;@13D71
	je	@@3	;@13D76
	les	di, dword ptr ds:[5026h]	;@13D78
@@1:	push	es	;@13D7C
	push	di	;@13D7D
	push	cs	;@13D7E
	call	L0FCE0	;@13D7F
	mov	si, di	;@13D82
	mov	ax, es	;@13D84
	mov	ds, ax	;@13D86
	pop	di	;@13D88
	pop	es	;@13D89
@@2:	ret	;@13D8A
@@3:	push	ax	;@13D8B
	push	cx	;@13D8C
	mov	al, 88h	;@13D8D
	mov	byte ptr ds:[5021h], al	;@13D8F
	call	L14551	;@13D92
	mov	al, 40h	;@13D95
	stosb	;@13D97
	pop	cx	;@13D98
	pop	ax	;@13D99
	jmp	@@1	;@13D9A
L13D9C:	mov	cx, ax	;@13D9C
	mov	al, 88h	;@13D9E
	call	L14551	;@13DA0
	mov	al, 40h	;@13DA3
	stosb	;@13DA5
	mov	al, 0E5h	;@13DA6
	and	dx, dx	;@13DA8
	je	@@1	;@13DAA
	or	al, 10h	;@13DAC
@@1:	stosb	;@13DAE
	mov	ax, cx	;@13DAF
	call	L14524	;@13DB1
L13DB4:	mov	ax, bx	;@13DB4
	stosw	;@13DB6
	mov	ax, dx	;@13DB7
L13DB9:	and	ax, ax	;@13DB9
	je	@@1	;@13DBB
	stosw	;@13DBD
@@1:	jmp	L144C7	;@13DBE
L13DC1:	mov	al, 88h	;@13DC1
	call	L14551	;@13DC3
	mov	al, 40h	;@13DC6
	stosb	;@13DC8
	mov	al, 0E7h	;@13DC9
	and	dx, dx	;@13DCB
	je	@@1	;@13DCD
	or	al, 10h	;@13DCF
@@1:	stosb	;@13DD1
	jmp	L13DB4	;@13DD2
L13DD4:	push	di	;@13DD4
	push	ax	;@13DD5
	mov	al, 88h	;@13DD6
	call	L14551	;@13DD8
	mov	al, 40h	;@13DDB
	stosb	;@13DDD
	mov	al, 0E6h	;@13DDE
	and	dx, dx	;@13DE0
	je	@@1	;@13DE2
	or	al, 10h	;@13DE4
@@1:	stosb	;@13DE6
	pop	ax	;@13DE7
	call	L14532	;@13DE8
	mov	ax, bp	;@13DEB
	and	ah, 0Fh	;@13DED
	call	L14524	;@13DF0
	xor	al, al	;@13DF3
	test	bp, 1000h	;@13DF5
	je	@@2	;@13DF9
	mov	al, 28h	;@13DFB
@@2:	stosb	;@13DFD
	pop	ax	;@13DFE
	call	L14524	;@13DFF
	mov	ax, si	;@13E02
	call	L14524	;@13E04
	mov	ax, bx	;@13E07
	stosw	;@13E09
	mov	ax, dx	;@13E0A
	and	ax, ax	;@13E0C
	je	@@3	;@13E0E
	stosw	;@13E10
@@3:	jmp	L144C7	;@13E11
L13E14:	push	ax	;@13E14
	mov	al, 88h	;@13E15
	call	L14551	;@13E17
	mov	al, 40h	;@13E1A
	stosb	;@13E1C
	mov	al, 0E6h	;@13E1D
	stosb	;@13E1F
	pop	ax	;@13E20
	call	L14532	;@13E21
	mov	ax, bp	;@13E24
	and	ah, 0Fh	;@13E26
	call	L14524	;@13E29
	mov	al, 2	;@13E2C
	stosb	;@13E2E
	mov	ax, bx	;@13E2F
	stosw	;@13E31
	jmp	L144C7	;@13E32
L13E35:	push	ax	;@13E35
	mov	al, 88h	;@13E36
	call	L14551	;@13E38
	mov	al, 40h	;@13E3B
	stosb	;@13E3D
	mov	al, 0E6h	;@13E3E
	stosb	;@13E40
	pop	ax	;@13E41
	call	L14532	;@13E42
	mov	ax, bp	;@13E45
	and	ah, 0Fh	;@13E47
	call	L14524	;@13E4A
	mov	al, 7	;@13E4D
	stosb	;@13E4F
	jmp	L144C7	;@13E50
L13E53:	mov	al, 88h	;@13E53
	db	0E8h, 0F9h, 6	; call L14551	;@13E55
	mov	al, 40h	;@13E58
	stosb	;@13E5A
	mov	al, 0EAh	;@13E5B
	stosb	;@13E5D
	mov	ax, 4	;@13E5E
	stosw	;@13E61
	call	L144C7	;@13E62
	xor	bx, bx	;@13E65
@@1:	mov	al, 88h	;@13E67
	db	0E8h, 0E5h, 6	; call L14551	;@13E69
	mov	al, 40h	;@13E6C
	stosb	;@13E6E
	mov	al, 0E3h	;@13E6F
	stosb	;@13E71
	mov	ax, bx	;@13E72
	add	ax, 18h	;@13E74
	call	L14524	;@13E77
	push	bx	;@13E7A
	shl	bx, 1	;@13E7B
	shl	bx, 1	;@13E7D
	mov	si, word ptr [bx+1A90h]	;@13E7F
	mov	cx, word ptr [bx+1A92h]	;@13E83
	rep movsb	;@13E87
	call	L144C7	;@13E89
	pop	bx	;@13E8C
	inc	bx	;@13E8D
	cmp	bx, 7	;@13E8E
	jne	@@1	;@13E91
	ret	;@13E93
L13E94:	push	ax	;@13E94
	mov	al, 88h	;@13E95
	call	L14551	;@13E97
	mov	al, 40h	;@13E9A
	stosb	;@13E9C
	mov	al, 0E3h	;@13E9D
	stosb	;@13E9F
	mov	ax, bp	;@13EA0
	call	L14524	;@13EA2
	pop	ax	;@13EA5
	call	L14532	;@13EA6
	mov	ax, bx	;@13EA9
	stosw	;@13EAB
	mov	al, 20h	;@13EAC
	stosb	;@13EAE
	mov	ax, dx	;@13EAF
	stosw	;@13EB1
	jmp	L144C7	;@13EB2
L13EB5:	push	ax	;@13EB5
	mov	al, 88h	;@13EB6
	call	L14551	;@13EB8
	mov	al, 40h	;@13EBB
	stosb	;@13EBD
	mov	al, 0E3h	;@13EBE
	stosb	;@13EC0
	mov	ax, bp	;@13EC1
	call	L14524	;@13EC3
	pop	ax	;@13EC6
	call	L14532	;@13EC7
	mov	ax, bx	;@13ECA
	stosw	;@13ECC
	mov	al, 21h	;@13ECD
	stosb	;@13ECF
	mov	ax, dx	;@13ED0
	stosw	;@13ED2
	jmp	L144C7	;@13ED3
L13ED6:	mov	al, 88h	;@13ED6
	call	L14551	;@13ED8
	mov	al, 40h	;@13EDB
	stosb	;@13EDD
	mov	al, 0E3h	;@13EDE
	stosb	;@13EE0
	mov	ax, bp	;@13EE1
	call	L14524	;@13EE3
	xor	al, al	;@13EE6
	stosb	;@13EE8
	mov	ax, 2	;@13EE9
	stosw	;@13EEC
	mov	al, 15h	;@13EED
	stosb	;@13EEF
	mov	ax, bx	;@13EF0
L13EF2:	and	ah, 0Fh	;@13EF2
	call	L14524	;@13EF5
	xor	al, al	;@13EF8
	stosb	;@13EFA
	jmp	L144C7	;@13EFB
L13EFE:	mov	al, 88h	;@13EFE
	call	L14551	;@13F00
	mov	al, 40h	;@13F03
	stosb	;@13F05
	mov	al, 0E3h	;@13F06
	stosb	;@13F08
	mov	ax, bp	;@13F09
	call	L14524	;@13F0B
	xor	al, al	;@13F0E
	stosb	;@13F10
	mov	ax, 4	;@13F11
	stosw	;@13F14
	mov	al, 16h	;@13F15
	stosb	;@13F17
	mov	ax, bx	;@13F18
	and	ah, 0Fh	;@13F1A
	call	L14524	;@13F1D
	xor	al, al	;@13F20
	stosb	;@13F22
	jmp	L144C7	;@13F23
L13F26:	mov	al, 88h	;@13F26
	call	L14551	;@13F28
	mov	al, 40h	;@13F2B
	stosb	;@13F2D
	mov	al, 0E3h	;@13F2E
	stosb	;@13F30
	mov	ax, bp	;@13F31
	call	L14524	;@13F33
	xor	al, al	;@13F36
	stosb	;@13F38
	mov	ax, 4	;@13F39
	stosw	;@13F3C
	mov	al, 18h	;@13F3D
	stosb	;@13F3F
	mov	ax, bx	;@13F40
	and	ah, 0Fh	;@13F42
	call	L14524	;@13F45
	xor	al, al	;@13F48
	stosb	;@13F4A
	jmp	L144C7	;@13F4B
L13F4E:	mov	al, 88h	;@13F4E
	call	L14551	;@13F50
	mov	al, 40h	;@13F53
	stosb	;@13F55
	mov	al, 0E3h	;@13F56
	stosb	;@13F58
	mov	ax, bp	;@13F59
	call	L14524	;@13F5B
	xor	al, al	;@13F5E
	stosb	;@13F60
	mov	ax, 6	;@13F61
	stosw	;@13F64
	mov	al, 19h	;@13F65
	stosb	;@13F67
	mov	ax, bx	;@13F68
	and	ah, 0Fh	;@13F6A
	call	L14524	;@13F6D
	xor	al, al	;@13F70
	stosb	;@13F72
	jmp	L144C7	;@13F73
L13F76:	push	ax	;@13F76
	mov	al, 88h	;@13F77
	db	0E8h, 0D5h, 5	; call L14551	;@13F79
	mov	al, 40h	;@13F7C
	stosb	;@13F7E
	mov	al, 0E3h	;@13F7F
	stosb	;@13F81
	mov	ax, bp	;@13F82
	call	L14524	;@13F84
	xor	al, al	;@13F87
	stosb	;@13F89
	pop	ax	;@13F8A
	stosw	;@13F8B
	and	dx, dx	;@13F8C
	jne	@@1	;@13F8E
	mov	al, 1Ah	;@13F90
	stosb	;@13F92
	mov	ax, bx	;@13F93
	and	ah, 0Fh	;@13F95
	call	L14524	;@13F98
	jmp	L144C7	;@13F9B
@@1:	mov	al, 1Bh	;@13F9E
	stosb	;@13FA0
	mov	ax, dx	;@13FA1
	stosw	;@13FA3
	mov	ax, bx	;@13FA4
	and	ah, 0Fh	;@13FA6
	call	L14524	;@13FA9
	jmp	L144C7	;@13FAC
L13FAF:	cmp	byte ptr ds:[5021h], 0	;@13FAF
	je	@@3	;@13FB4
@@1:	les	di, dword ptr ds:[5026h]	;@13FB6
	mov	si, word ptr ds:[502Ah]	;@13FBA
	xor	ch, ch	;@13FBE
	sub	si, cx	;@13FC0
	add	si, 3FCh	;@13FC2
	cmp	di, si	;@13FC6
	ja	@@2	;@13FC8
	push	ax	;@13FCA
	mov	al, bl	;@13FCB
	mov	word ptr ds:[5022h], di	;@13FCD
	stosb	;@13FD1
	pop	ax	;@13FD2
	call	L14532	;@13FD3
	mov	ax, bp	;@13FD6
	and	ah, 0Fh	;@13FD8
	call	L14524	;@13FDB
	mov	word ptr ds:[5026h], di	;@13FDE
	ret	;@13FE2
@@2:	les	di, dword ptr ds:[5026h]	;@13FE3
	push	ax	;@13FE7
	push	cx	;@13FE8
	call	L144C7	;@13FE9
	pop	cx	;@13FEC
	pop	ax	;@13FED
@@3:	push	ax	;@13FEE
	mov	al, 88h	;@13FEF
	db	0E8h, 5Dh, 5	; call L14551	;@13FF1
	mov	al, 40h	;@13FF4
	stosb	;@13FF6
	mov	al, 0E2h	;@13FF7
	mov	byte ptr ds:[5021h], al	;@13FF9
	stosb	;@13FFC
	pop	ax	;@13FFD
	mov	word ptr ds:[5026h], di	;@13FFE
	jmp	@@1	;@14002
L14004:	cmp	byte ptr ds:[5021h], 0	;@14004
	je	@@3	;@14009
@@1:	les	di, dword ptr ds:[5026h]	;@1400B
	mov	si, word ptr ds:[502Ah]	;@1400F
	xor	ch, ch	;@14013
	sub	si, cx	;@14015
	add	si, 3F6h	;@14017
	cmp	di, si	;@1401B
	ja	@@2	;@1401D
	push	ax	;@1401F
	mov	al, 40h	;@14020
	stosb	;@14022
	mov	ax, bx	;@14023
	stosw	;@14025
	mov	ax, dx	;@14026
	stosw	;@14028
	mov	word ptr ds:[5022h], di	;@14029
	xor	al, al	;@1402D
	stosb	;@1402F
	pop	ax	;@14030
	call	L14532	;@14031
	mov	ax, bp	;@14034
	and	ah, 0Fh	;@14036
	call	L14524	;@14039
	mov	word ptr ds:[5026h], di	;@1403C
	ret	;@14040
@@2:	les	di, dword ptr ds:[5026h]	;@14041
	push	ax	;@14045
	push	cx	;@14046
	call	L144C7	;@14047
	pop	cx	;@1404A
	pop	ax	;@1404B
@@3:	push	ax	;@1404C
	mov	al, 88h	;@1404D
	db	0E8h, 0FFh, 4	; call L14551	;@1404F
	mov	al, 40h	;@14052
	stosb	;@14054
	mov	al, 0E2h	;@14055
	mov	byte ptr ds:[5021h], al	;@14057
	stosb	;@1405A
	pop	ax	;@1405B
	mov	word ptr ds:[5026h], di	;@1405C
	jmp	@@1	;@14060
L14062:	cmp	byte ptr ds:[5021h], 0	;@14062
	je	@@2	;@14067
@@1:	les	di, dword ptr ds:[5026h]	;@14069
	mov	si, word ptr ds:[5022h]	;@1406D
	or	byte ptr es:[si], 80h	;@14071
	jmp	L144C7	;@14075
@@2:	mov	al, 88h	;@14078
	db	0E8h, 0D4h, 4	; call L14551	;@1407A
	mov	al, 40h	;@1407D
	stosb	;@1407F
	mov	al, 0E2h	;@14080
	stosb	;@14082
	mov	word ptr ds:[5022h], di	;@14083
	mov	al, 40h	;@14087
	stosb	;@14089
	xor	ax, ax	;@1408A
	stosw	;@1408C
	stosw	;@1408D
	mov	word ptr ds:[5026h], di	;@1408E
	jmp	@@1	;@14092
L14094:	push	ax	;@14094
	mov	al, 96h	;@14095
	call	L14551	;@14097
	pop	ax	;@1409A
	call	L14532	;@1409B
	inc	word ptr ds:[502Eh]	;@1409E
	call	L144C7	;@140A2
	mov	al, 9Ah	;@140A5
	call	L14551	;@140A7
	mov	ax, word ptr ds:[502Eh]	;@140AA
	call	L14524	;@140AD
	mov	word ptr ds:[5026h], di	;@140B0
	inc	word ptr ds:[5030h]	;@140B4
	mov	ax, word ptr ds:[5030h]	;@140B8
	ret	;@140BB
L140BC:	les	di, dword ptr ds:[5026h]	;@140BC
	mov	cx, ax	;@140C0
	mov	al, 0FFh	;@140C2
	stosb	;@140C4
	mov	ax, cx	;@140C5
	call	L14524	;@140C7
	mov	word ptr ds:[5026h], di	;@140CA
	ret	;@140CE
L140CF:	les	di, dword ptr ds:[5026h]	;@140CF
	jmp	L144C7	;@140D3
L140D6:	mov	word ptr ds:[5042h], di	;@140D6
	push	ax	;@140DA
	mov	al, 96h	;@140DB
	call	L14551	;@140DD
	pop	ax	;@140E0
	call	L14532	;@140E1
	inc	word ptr ds:[502Eh]	;@140E4
	mov	ax, word ptr ds:[502Eh]	;@140E8
	mov	word ptr ds:[5038h], ax	;@140EB
	mov	ax, si	;@140EE
	or	dh, dh	;@140F0
	jne	@@1	;@140F2
	mov	ax, 1	;@140F4
	jmp	short @@2	;@140F7
@@1:	mov	cl, dh	;@140F9
	xor	ch, ch	;@140FB
	call	L14532	;@140FD
	inc	word ptr ds:[502Eh]	;@14100
	mov	ax, word ptr ds:[502Eh]	;@14104
@@2:	mov	word ptr ds:[503Ah], ax	;@14107
	call	L144C7	;@1410A
	xor	dh, dh	;@1410D
	mov	si, word ptr ds:[5042h]	;@1410F
	or	si, si	;@14113
	jne	@@3	;@14115
	cmp	bp, 1	;@14117
	jne	@@3	;@1411A
	or	dl, 2	;@1411C
	jmp	short @@4	;@1411F
@@3:	or	bp, bp	;@14121
	je	@@4	;@14123
	mov	dh, 1	;@14125
@@4:	mov	al, 98h	;@14127
	or	al, dh	;@14129
	call	L14551	;@1412B
	mov	al, dl	;@1412E
	test	al, 0E0h	;@14130
	jne	@@5	;@14132
	stosb	;@14134
	mov	ax, bx	;@14135
	stosw	;@14137
	xor	al, al	;@14138
	stosb	;@1413A
	xor	bl, bl	;@1413B
	jmp	short @@7	;@1413D
@@5:	test	word ptr ds:[38C4h], 100h	;@1413F
	je	@@6	;@14145
	and	al, 0FEh	;@14147
@@6:	stosb	;@14149
@@7:	mov	ax, si	;@1414A
	stosw	;@1414C
	or	dh, dh	;@1414D
	je	@@8	;@1414F
	mov	ax, bp	;@14151
	stosw	;@14153
@@8:	mov	ax, word ptr ds:[5038h]	;@14154
	call	L14524	;@14157
	mov	ax, word ptr ds:[503Ah]	;@1415A
	call	L14524	;@1415D
	mov	ax, 1	;@14160
	call	L14524	;@14163
	test	word ptr ds:[38C4h], 100h	;@14166
	je	@@10	;@1416C
	test	bl, 4	;@1416E
	je	@@10	;@14171
	mov	al, bl	;@14173
	test	dl, 1	;@14175
	jne	@@9	;@14178
	and	al, 0FBh	;@1417A
@@9:	stosb	;@1417C
@@10:	call	L144C7	;@1417D
	inc	word ptr ds:[5032h]	;@14180
	mov	ax, word ptr ds:[5032h]	;@14184
	ret	;@14187
L14188:	mov	byte ptr ds:[5021h], 0	;@14188
	ret	;@1418D
L1418E:	cmp	byte ptr ds:[5021h], 0	;@1418E
	je	@@3	;@14193
@@1:	les	di, dword ptr ds:[5026h]	;@14195
	xor	ch, ch	;@14199
	mov	si, word ptr ds:[502Ah]	;@1419B
	sub	si, cx	;@1419F
	add	si, 3FEh	;@141A1
	cmp	di, si	;@141A5
	ja	@@2	;@141A7
	call	L14532	;@141A9
	xor	al, al	;@141AC
	stosb	;@141AE
	mov	word ptr ds:[5026h], di	;@141AF
	inc	word ptr ds:[5034h]	;@141B3
	mov	ax, word ptr ds:[5034h]	;@141B7
	ret	;@141BA
@@2:	push	ax	;@141BB
	push	cx	;@141BC
	call	L144C7	;@141BD
	pop	cx	;@141C0
	pop	ax	;@141C1
@@3:	push	ax	;@141C2
	mov	al, 8Ch	;@141C3
	mov	byte ptr ds:[5021h], al	;@141C5
	call	L14551	;@141C8
	pop	ax	;@141CB
	mov	word ptr ds:[5026h], di	;@141CC
	jmp	@@1	;@141D0
L141D2:	mov	byte ptr ds:[5021h], 0	;@141D2
	ret	;@141D7
L141D8:	mov	byte ptr ds:[5020h], ch	;@141D8
	mov	word ptr ds:[501Ch], si	;@141DC
	mov	word ptr ds:[501Eh], di	;@141E0
	cmp	byte ptr ds:[5021h], 0	;@141E4
	je	@@5	;@141E9
@@1:	les	di, dword ptr ds:[5026h]	;@141EB
	xor	ch, ch	;@141EF
	mov	si, word ptr ds:[502Ah]	;@141F1
	sub	si, cx	;@141F5
	add	si, 3F3h	;@141F7
	cmp	di, si	;@141FB
	ja	@@4	;@141FD
	call	L14532	;@141FF
	xor	al, al	;@14202
	stosb	;@14204
	cmp	byte ptr ds:[5020h], 0	;@14205
	mov	al, 62h	;@1420A
	je	@@2	;@1420C
	dec	al	;@1420E
	cmp	byte ptr ds:[5020h], 1	;@14210
	je	@@2	;@14215
	mov	al, bl	;@14217
@@2:	stosb	;@14219
	cmp	byte ptr ds:[5020h], 0	;@1421A
	je	@@6	;@1421F
	cmp	byte ptr ds:[5020h], 1	;@14221
	je	@@3	;@14226
	mov	ax, word ptr ds:[501Ch]	;@14228
	mov	dx, word ptr ds:[501Eh]	;@1422B
	jmp	short @@7	;@1422F
@@3:	mov	ax, bx	;@14231
	call	@@9	;@14233
	mov	ax, word ptr ds:[501Ch]	;@14236
	mov	dx, word ptr ds:[501Eh]	;@14239
	call	@@9	;@1423D
	jmp	short @@8	;@14240
@@4:	push	ax	;@14242
	push	cx	;@14243
	call	L144C7	;@14244
	pop	cx	;@14247
	pop	ax	;@14248
@@5:	push	ax	;@14249
	mov	al, 0B0h	;@1424A
	mov	byte ptr ds:[5021h], al	;@1424C
	call	L14551	;@1424F
	pop	ax	;@14252
	mov	word ptr ds:[5026h], di	;@14253
	jmp	@@1	;@14257
@@6:	push	di	;@14259
	mov	si, word ptr ds:[501Ch]	;@1425A
	mov	di, word ptr ds:[501Eh]	;@1425E
	mov	cx, dx	;@14262
	call	far ptr L03348	;@14264
	pop	di	;@14269
	mov	dx, cx	;@1426A
	mov	ax, bx	;@1426C
@@7:	call	@@9	;@1426E
@@8:	mov	word ptr ds:[5026h], di	;@14271
	inc	word ptr ds:[5034h]	;@14275
	mov	ax, word ptr ds:[5034h]	;@14279
	ret	;@1427C
@@9:	and	dx, dx	;@1427D
	jne	@@11	;@1427F
	cmp	ax, 80h	;@14281
	ja	@@10	;@14284
	stosb	;@14286
	ret	;@14287
@@10:	mov	dx, ax	;@14288
	mov	al, 81h	;@1428A
	stosb	;@1428C
	mov	ax, dx	;@1428D
	stosw	;@1428F
	ret	;@14290
@@11:	push	ax	;@14291
	mov	al, 88h	;@14292
	stosb	;@14294
	pop	ax	;@14295
	stosw	;@14296
	mov	ax, dx	;@14297
	stosw	;@14299
	ret	;@1429A
L1429B:	push	ax	;@1429B
	mov	al, 88h	;@1429C
	call	L14551	;@1429E
	mov	al, 40h	;@142A1
	stosb	;@142A3
	mov	al, 0A0h	;@142A4
	stosb	;@142A6
	mov	ax, 2	;@142A7
	stosw	;@142AA
	pop	ax	;@142AB
	call	L14532	;@142AC
	xor	al, al	;@142AF
	stosb	;@142B1
	jmp	L144C7	;@142B2
L142B5:	push	ax	;@142B5
	push	di	;@142B6
	mov	al, 90h	;@142B7
L142B9:	or	dx, dx	;@142B9
	je	@@1	;@142BB
	or	al, 1	;@142BD
@@1:	call	L14551	;@142BF
	pop	ax	;@142C2
	call	L14524	;@142C3
	mov	ax, si	;@142C6
	call	L14524	;@142C8
	or	ax, ax	;@142CB
	jne	@@2	;@142CD
	stosw	;@142CF
@@2:	pop	ax	;@142D0
	call	L14532	;@142D1
	mov	ax, bx	;@142D4
	stosw	;@142D6
	or	dx, dx	;@142D7
	je	@@3	;@142D9
	mov	ax, dx	;@142DB
	stosw	;@142DD
@@3:	xor	al, al	;@142DE
	stosb	;@142E0
	jmp	L144C7	;@142E1
L142E4:	push	ax	;@142E4
	push	di	;@142E5
	mov	al, 0B6h	;@142E6
	jmp	L142B9	;@142E8
L142EA:	mov	byte ptr ds:[5044h], cl	;@142EA
	mov	si, ax	;@142EE
	push	es	;@142F0
	mov	word ptr ds:[503Ch], dx	;@142F1
	mov	al, 0A2h	;@142F5
	or	al, cl	;@142F7
	call	L14551	;@142F9
	mov	ax, dx	;@142FC
L142FE:	call	L14524	;@142FE
	mov	ax, bx	;@14301
	stosw	;@14303
	and	cl, cl	;@14304
	je	@@1	;@14306
	mov	ax, si	;@14308
	stosw	;@1430A
@@1:	mov	word ptr ds:[503Eh], di	;@1430B
	mov	word ptr ds:[5026h], di	;@1430F
	pop	es	;@14313
	ret	;@14314
L14315:	mov	bx, es	;@14315
	les	di, dword ptr ds:[5026h]	;@14317
	stosw	;@1431B
	cmp	byte ptr ds:[5044h], 0	;@1431C
	je	@@1	;@14321
	mov	ax, dx	;@14323
	stosw	;@14325
@@1:	mov	ax, cx	;@14326
	stosw	;@14328
	mov	word ptr ds:[5026h], di	;@14329
	mov	es, bx	;@1432D
	ret	;@1432F
L14330:	mov	dx, ds	;@14330
	mov	bx, es	;@14332
	les	di, dword ptr ds:[5026h]	;@14334
	mov	ds, bx	;@14338
	mov	ax, 1	;@1433A
	stosw	;@1433D
	xor	ax, ax	;@1433E
	cmp	byte ptr ss:[5044h], 0	;@14340
	je	@@1	;@14346
	stosw	;@14348
@@1:	stosw	;@14349
	mov	al, cl	;@1434A
	stosb	;@1434C
	rep movsb	;@1434D
	mov	ds, dx	;@1434F
	mov	word ptr ds:[5026h], di	;@14351
	mov	es, bx	;@14355
	ret	;@14357
L14358:	mov	bx, es	;@14358
	les	di, dword ptr ds:[5026h]	;@1435A
	mov	ax, 1	;@1435E
	stosw	;@14361
	xor	ax, ax	;@14362
	cmp	byte ptr ds:[5044h], 0	;@14364
	je	@@1	;@14369
	stosw	;@1436B
@@1:	stosw	;@1436C
	mov	al, cl	;@1436D
	stosb	;@1436F
	xor	al, al	;@14370
	rep stosb	;@14372
	mov	word ptr ds:[5026h], di	;@14374
	mov	es, bx	;@14378
	ret	;@1437A
L1437B:	push	es	;@1437B
	les	di, dword ptr ds:[5026h]	;@1437C
	call	L144C7	;@14380
	pop	es	;@14383
	ret	;@14384
L14385:	mov	word ptr ds:[503Ch], dx	;@14385
	mov	si, ax	;@14389
	xor	cl, cl	;@1438B
	and	si, si	;@1438D
	je	@@1	;@1438F
	or	cl, 1	;@14391
@@1:	mov	al, 0A0h	;@14394
	or	al, cl	;@14396
	call	L14551	;@14398
	mov	ax, word ptr ds:[503Ch]	;@1439B
	call	L14524	;@1439E
	mov	ax, bx	;@143A1
	stosw	;@143A3
	and	cl, cl	;@143A4
	je	@@2	;@143A6
	mov	ax, si	;@143A8
	stosw	;@143AA
@@2:	mov	word ptr ds:[503Eh], di	;@143AB
	ret	;@143AF
L143B0:	add	di, word ptr ss:[503Eh]	;@143B0
	rep movsb	;@143B5
	ret	;@143B7
L143B8:	add	di, word ptr ds:[503Eh]	;@143B8
	jmp	L144C7	;@143BC
L143BF:	cmp	byte ptr ds:[5044h], 0	;@143BF
	jne	@@1	;@143C4
	mov	bx, 5	;@143C6
	mov	ax, 4	;@143C9
	ret	;@143CC
@@1:	mov	bx, 7	;@143CD
	mov	ax, 6	;@143D0
	ret	;@143D3
L143D4:	push	di	;@143D4
	cmp	byte ptr ds:[5021h], 0	;@143D5
	je	@@11	;@143DA
	mov	al, dl	;@143DC
	xor	al, byte ptr ds:[5021h]	;@143DE
	and	al, 1	;@143E2
	jne	@@10	;@143E4
	les	di, dword ptr ds:[5026h]	;@143E6
@@1:	and	dl, 0FEh	;@143EA
	or	bh, 80h	;@143ED
	or	bh, dl	;@143F0
	mov	ax, bx	;@143F2
	xchg	al, ah	;@143F4
	stosw	;@143F6
	pop	bx	;@143F7
	cmp	cl, ch	;@143F8
	jne	@@2	;@143FA
	cmp	si, bx	;@143FC
	je	@@5	;@143FE
@@2:	mov	al, cl	;@14400
	mov	cl, 4	;@14402
	shl	al, cl	;@14404
	or	al, ch	;@14406
	or	al, 4	;@14408
	stosb	;@1440A
	mov	ax, si	;@1440B
	cmp	ax, 7Fh	;@1440D
	ja	@@3	;@14410
	stosb	;@14412
	jmp	short @@4	;@14413
@@3:	or	ah, 80h	;@14415
	xchg	ah, al	;@14418
	stosw	;@1441A
@@4:	jmp	short @@6	;@1441B
@@5:	mov	al, ch	;@1441D
	or	al, 54h	;@1441F
	stosb	;@14421
@@6:	mov	ax, bx	;@14422
	cmp	ax, 7Fh	;@14424
	ja	@@7	;@14427
	stosb	;@14429
	jmp	short @@8	;@1442A
@@7:	or	ah, 80h	;@1442C
	xchg	ah, al	;@1442F
	stosw	;@14431
@@8:	mov	word ptr ds:[5026h], di	;@14432
	mov	ax, word ptr ds:[502Ah]	;@14436
	add	ax, 3F6h	;@14439
	cmp	di, ax	;@1443C
	ja	@@9	;@1443E
	ret	;@14440
@@9:	call	L13D2A	;@14441
	jmp	L13C99	;@14444
@@10:	push	cx	;@14447
	push	si	;@14448
	push	bx	;@14449
	push	dx	;@1444A
	call	L13D2A	;@1444B
	pop	dx	;@1444E
	pop	bx	;@1444F
	pop	si	;@14450
	pop	cx	;@14451
@@11:	mov	al, 9Ch	;@14452
	mov	ah, dl	;@14454
	and	ah, 1	;@14456
	or	al, ah	;@14459
	mov	byte ptr ds:[5021h], al	;@1445B
	call	L14551	;@1445E
	jmp	@@1	;@14461
L14463:	mov	al, 88h	;@14463
	db	0E8h, 0E9h, 0	; call L14551	;@14465
	xor	ax, ax	;@14468
	stosw	;@1446A
@@1:	lodsb	;@1446B
	or	al, al	;@1446C
	je	@@2	;@1446E
	stosb	;@14470
	jmp	@@1	;@14471
@@2:	jmp	short L144C7	;@14473
L14475:	push	di	;@14475
	push	ax	;@14476
	mov	byte ptr ds:[5044h], 0	;@14477
	or	al, al	;@1447C
	je	@@1	;@1447E
	or	dx, dx	;@14480
	je	@@1	;@14482
	mov	byte ptr ds:[5044h], 1	;@14484
@@1:	mov	al, 8Ah	;@14489
	or	al, byte ptr ds:[5044h]	;@1448B
	call	L14551	;@1448F
	pop	ax	;@14492
	or	al, al	;@14493
	stosb	;@14495
	je	@@2	;@14496
	mov	al, cl	;@14498
	mov	cl, 4	;@1449A
	shl	al, cl	;@1449C
	or	al, ch	;@1449E
	stosb	;@144A0
	mov	ax, si	;@144A1
	call	L14524	;@144A3
	pop	ax	;@144A6
	call	L14524	;@144A7
	mov	ax, bx	;@144AA
	stosw	;@144AC
	cmp	byte ptr ds:[5044h], 0	;@144AD
	je	@@3	;@144B2
	mov	ax, dx	;@144B4
	stosw	;@144B6
	jmp	short @@3	;@144B7
@@2:	pop	ax	;@144B9
@@3:	jmp	short L144C7	;@144BA
L144BC:	mov	byte ptr ds:[38D6h], 6	;@144BC
	stc	;@144C1
	mov	sp, word ptr ds:[38BAh]	;@144C2
	retf	;@144C6
L144C7:	push	bx	;@144C7
	push	si	;@144C8
	mov	bx, word ptr ds:[502Ah]	;@144C9
	mov	ax, di	;@144CD
	sub	ax, 2	;@144CF
	sub	ax, bx	;@144D2
	mov	word ptr es:[bx+1], ax	;@144D4
	mov	cx, di	;@144D8
	mov	si, word ptr ds:[502Ah]	;@144DA
	sub	cx, si	;@144DE
	mov	bx, ds	;@144E0
	mov	ax, es	;@144E2
	mov	ds, ax	;@144E4
	xor	ax, ax	;@144E6
@@1:	lodsb	;@144E8
	add	ah, al	;@144E9
	loop	@@1	;@144EB
	mov	ds, bx	;@144ED
	mov	al, ah	;@144EF
	neg	al	;@144F1
	stosb	;@144F3
	pop	si	;@144F4
	pop	bx	;@144F5
	mov	ax, word ptr ds:[501Ah]	;@144F6
	sub	ax, 404h	;@144F9
	cmp	di, ax	;@144FC
	ja	L14505	;@144FE
	mov	word ptr ds:[502Ah], di	;@14500
	ret	;@14504
L14505:	push	bx	;@14505
	push	si	;@14506
	push	dx	;@14507
	mov	cx, di	;@14508
	mov	ax, es	;@1450A
	xor	dx, dx	;@1450C
	mov	bx, word ptr ds:[5040h]	;@1450E
	push	cs	;@14512
	call	L112F6	;@14513
	pop	dx	;@14516
	pop	si	;@14517
	pop	bx	;@14518
	jae	@@1	;@14519
	jmp	L144BC	;@1451B
@@1:	mov	word ptr ds:[502Ah], 0	;@1451D
	ret	;@14523
L14524:	cmp	ax, 7Fh	;@14524
	ja	@@1	;@14527
	stosb	;@14529
	ret	;@1452A
@@1:	or	ah, 80h	;@1452B
	xchg	ah, al	;@1452E
	stosw	;@14530
	ret	;@14531
L14532:	push	si	;@14532
	push	ds	;@14533
	push	es	;@14534
	xchg	si, di	;@14535
	cmp	cl, 3Fh	;@14537
	jb	@@1	;@1453A
	mov	cl, 3Fh	;@1453C
@@1:	push	cs	;@1453E
	call	L0FCE0	;@1453F
	push	es	;@14542
	pop	ds	;@14543
	pop	es	;@14544
	xchg	di, si	;@14545
	xor	ch, ch	;@14547
	mov	al, cl	;@14549
	stosb	;@1454B
	rep movsb	;@1454C
	pop	ds	;@1454E
	pop	si	;@1454F
C0F9B	ends
	end
