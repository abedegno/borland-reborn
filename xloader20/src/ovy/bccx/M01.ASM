	.286p
	locals
	public	L0A12D
	extrn	L0AB74:far
	extrn	L181A0:byte

Y0A120	segment para public 'CODE'
	assume	cs:Y0A120
	db	0Ch, 0FFh, 44h, 8, 0BFh, 0FFh, 7Fh, 23h, 7Ch, 8, 47h, 70h, 0Bh	;@0A120
L0A12D:	and	al, 0F8h	;@0A12D
	mov	byte ptr [si], 0	;@0A12F
	mov	word ptr [si+1], ax	;@0A132
	pop	ds	;@0A135
	jmp	short @@1	;@0A136
	db	89h, 1Ch, 89h, 5Ch, 2, 89h, 5Ch, 4, 0C7h, 44h, 6, 0, 80h, 0EBh	;@0A138
	db	0EEh
@@1:	pop	di	;@0A147
	pop	si	;@0A148
	pop	bp	;@0A149
	retf	4	;@0A14A
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 0Ah, 56h, 57h, 1Eh, 0C5h, 76h, 0Ah	;@0A14D
	db	8Dh, 7Eh, 0F6h, 16h, 7, 0B9h, 5, 0, 0FCh, 0F3h, 0A5h, 1Fh, 16h
	db	8Dh, 46h, 0F6h, 50h, 0Eh, 0E8h, 89h, 0FFh, 8Bh, 46h, 0F7h, 8Bh
	db	7Eh, 0F9h, 8Bh, 4Eh, 0FBh, 8Ah, 56h, 0FDh, 8Bh, 5Eh, 0FEh, 81h
	db	0E3h, 0FFh, 7Fh, 81h, 0FBh, 0FFh, 7Fh, 74h, 4Dh, 81h, 0C3h, 0
	db	0C4h, 7Eh, 42h, 81h, 0FBh, 0FFh, 7, 7Dh, 4Dh, 0D0h, 0E2h, 0D1h
	db	0EBh, 0D0h, 0DAh, 0Ah, 0C7h, 8Ah, 0F3h, 8Bh, 0DFh, 0D1h, 0EFh
	db	0D1h, 0D8h, 0D1h, 0DAh, 0D1h, 0D9h, 0D1h, 0DBh, 0D1h, 0EFh, 0D1h
	db	0D8h, 0D1h, 0DAh, 0D1h, 0D9h, 0D1h, 0DBh, 0D1h, 66h, 0FEh, 14h
	db	0, 0D1h, 0EFh, 0D1h, 0D8h, 0D1h, 0DAh, 0D1h, 0D9h, 0D1h, 0DBh
	db	0C4h, 7Eh, 6, 0FCh, 0ABh, 93h, 0ABh, 91h, 0ABh, 92h, 0ABh, 0EBh
	db	21h, 0BAh, 0, 0, 0EBh, 0Fh, 83h, 0E2h, 7Fh, 0D1h, 0EAh, 0D1h, 0EAh
	db	83h, 0CAh, 0E0h, 0EBh, 3, 0BAh, 0E0h, 0FFh, 0D1h, 66h, 0FEh, 0D1h
	db	0DAh, 2Bh, 0C9h, 8Bh, 0D9h, 8Bh, 0C1h, 0EBh, 0D2h, 5Fh, 5Eh, 8Bh
	db	0E5h, 5Dh, 0CAh, 8, 0
RTL_INT64_TO_LDOUBLE:	push	bp	;@0A1F8
	mov	bp, sp	;@0A1F9
	push	si	;@0A1FB
	push	di	;@0A1FC
	push	ds	;@0A1FD
	lds	si, dword ptr [bp+0Ah]	;@0A1FE
	mov	ax, word ptr [si]	;@0A201
	mov	bx, word ptr [si+2]	;@0A203
	mov	cx, word ptr [si+4]	;@0A206
	mov	dx, word ptr [si+6]	;@0A209
	pop	ds	;@0A20C
	mov	di, 0	;@0A20D
	or	dx, dx	;@0A210
	jl	@@1	;@0A212
	jg	@@2	;@0A214
	or	cx, cx	;@0A216
	jne	@@2	;@0A218
	or	bx, bx	;@0A21A
	jne	@@2	;@0A21C
	or	ax, ax	;@0A21E
	jne	@@2	;@0A220
	sub	si, si	;@0A222
	jmp	short @@7	;@0A224
@@1:	not	dx	;@0A226
	not	cx	;@0A228
	not	bx	;@0A22A
	neg	ax	;@0A22C
	cmc	;@0A22E
	adc	bx, 0	;@0A22F
	adc	cx, 0	;@0A232
	adc	dx, 0	;@0A235
	mov	di, 1	;@0A238
@@2:	mov	si, 40h	;@0A23B
@@3:	or	dx, dx	;@0A23E
	jne	@@4	;@0A240
	xchg	dx, cx	;@0A242
	xchg	cx, bx	;@0A244
	xchg	ax, bx	;@0A246
	sub	si, 10h	;@0A247
	jmp	@@3	;@0A24A
@@4:	js	@@6	;@0A24C
@@5:	dec	si	;@0A24E
	add	ax, ax	;@0A24F
	adc	bx, bx	;@0A251
	adc	cx, cx	;@0A253
	adc	dx, dx	;@0A255
	jns	@@5	;@0A257
@@6:	add	si, 3FFEh	;@0A259
	shl	si, 1	;@0A25D
	or	si, di	;@0A25F
	ror	si, 1	;@0A261
@@7:	les	di, dword ptr [bp+6]	;@0A263
	cld	;@0A266
	stosw	;@0A267
	xchg	ax, bx	;@0A268
	stosw	;@0A269
	xchg	ax, cx	;@0A26A
	stosw	;@0A26B
	xchg	ax, dx	;@0A26C
	stosw	;@0A26D
	xchg	ax, si	;@0A26E
	stosw	;@0A26F
	pop	di	;@0A270
	pop	si	;@0A271
	pop	bp	;@0A272
	retf	8	;@0A273
RTL_LDOUBLE_TO_INT64:	push	bp	;@0A276
	mov	bp, sp	;@0A277
	push	si	;@0A279
	push	di	;@0A27A
	push	ds	;@0A27B
	lds	si, dword ptr [bp+0Ah]	;@0A27C
	mov	di, 7FFFh	;@0A27F
	and	di, word ptr [si+8]	;@0A282
	sub	di, 3FFEh	;@0A285
	cmp	di, 3Fh	;@0A289
	jg	@@1	;@0A28C
	or	di, di	;@0A28E
	jge	@@3	;@0A290
	sub	dx, dx	;@0A292
	jmp	short @@2	;@0A294
@@1:	mov	dx, 8000h	;@0A296
@@2:	sub	ax, ax	;@0A299
	mov	bx, ax	;@0A29B
	mov	cx, ax	;@0A29D
	jmp	short @@8	;@0A29F
@@3:	mov	dx, word ptr [si+6]	;@0A2A1
	mov	cx, word ptr [si+4]	;@0A2A4
	mov	bx, word ptr [si+2]	;@0A2A7
	mov	ax, word ptr [si]	;@0A2AA
	sub	di, 30h	;@0A2AC
	ja	@@5	;@0A2AF
@@4:	mov	ax, bx	;@0A2B1
	mov	bx, cx	;@0A2B3
	mov	cx, dx	;@0A2B5
	sub	dx, dx	;@0A2B7
	add	di, 10h	;@0A2B9
	jle	@@4	;@0A2BC
	and	di, 0Fh	;@0A2BE
@@5:	neg	di	;@0A2C1
	je	@@7	;@0A2C3
	add	di, 10h	;@0A2C5
@@6:	shr	dx, 1	;@0A2C8
	rcr	cx, 1	;@0A2CA
	rcr	bx, 1	;@0A2CC
	rcr	ax, 1	;@0A2CE
	dec	di	;@0A2D0
	jg	@@6	;@0A2D1
@@7:	test	byte ptr [si+9], 80h	;@0A2D3
	je	@@8	;@0A2D7
	sub	si, si	;@0A2D9
	not	dx	;@0A2DB
	not	cx	;@0A2DD
	not	bx	;@0A2DF
	neg	ax	;@0A2E1
	cmc	;@0A2E3
	adc	bx, si	;@0A2E4
	adc	cx, si	;@0A2E6
	adc	dx, si	;@0A2E8
@@8:	les	di, dword ptr [bp+6]	;@0A2EA
	cld	;@0A2ED
	stosw	;@0A2EE
	xchg	ax, bx	;@0A2EF
Y0A120	ends

Y0A2F0	segment para public 'CODE'
	assume	cs:Y0A2F0
	db	0ABh, 91h, 0ABh, 92h, 0ABh, 83h, 0EFh, 8, 1Fh, '_^]', 0CAh, 8	;@0A2F0
	db	0, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 0FFh, 76h, 8, 0FFh, 76h, 6, 16h
	db	8Dh, 46h, 0F8h, 50h, 0Eh, 0E8h, 62h, 0FFh, 8Bh, 46h, 0FAh, 99h
	db	3Bh, 56h, 0FCh, 75h, 0Bh, 3Bh, 56h, 0FEh, 75h, 6, 92h, 8Bh, 46h
	db	0F8h, 0EBh, 5, 2Bh, 0C0h, 0BAh, 0, 80h, 8Bh, 0E5h, 5Dh, 0CAh, 4
	db	0, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 0FFh, 76h, 8, 0FFh, 76h, 6, 16h
	db	8Dh, 46h, 0F8h, 50h, 0Eh, 0E8h, 2Eh, 0FFh, 8Bh, 46h, 0F8h, 8Bh
	db	56h, 0FAh, 8Bh, 4Eh, 0FCh, 0Bh, 4Eh, 0FEh, 74h, 5, 0B8h, 0FFh
	db	0FFh, 8Bh, 0D0h, 8Bh, 0E5h, 5Dh, 0CAh, 4, 0, 55h, 8Bh, 0ECh, 83h
	db	0ECh, 8, 8Bh, 46h, 0Ah, 89h, 46h, 0F8h, 8Bh, 46h, 0Ch, 89h, 46h
	db	0FAh, 99h, 89h, 56h, 0FCh, 89h, 56h, 0FEh, 16h, 8Dh, 46h, 0F8h
	db	50h, 0FFh, 76h, 8, 0FFh, 76h, 6, 0Eh, 0E8h, 6Fh, 0FEh, 8Bh, 0E5h
	db	5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 8Bh, 46h, 0Ah, 89h
	db	46h, 0F8h, 8Bh, 46h, 0Ch, 89h, 46h, 0FAh, 2Bh, 0C0h, 89h, 46h
	db	0FCh, 89h, 46h, 0FEh, 16h, 8Dh, 46h, 0F8h, 50h, 0FFh, 76h, 8, 0FFh
	db	76h, 6, 0Eh, 0E8h, 40h, 0FEh, 8Bh, 0E5h, 5Dh, 0CAh, 8, 0
RTL_LDOUBLE_SCALE_POW10:	push	bp	;@0A3BE
	mov	bp, sp	;@0A3BF
	sub	sp, 0Ah	;@0A3C1
	push	si	;@0A3C4
	push	di	;@0A3C5
	mov	si, word ptr [bp+0Ah]	;@0A3C6
	or	si, si	;@0A3C9
	je	@@7	;@0A3CB
	jns	@@1	;@0A3CD
	neg	si	;@0A3CF
@@1:	cmp	si, 1387h	;@0A3D1
	jbe	@@2	;@0A3D5
	mov	si, 1387h	;@0A3D7
@@2:	mov	bx, 7	;@0A3DA
	and	bx, si	;@0A3DD
	shl	bx, 1	;@0A3DF
	shl	bx, 1	;@0A3E1
	add	bx, 5B1Ch	;@0A3E3
	push	word ptr [bx+2]	;@0A3E7
	push	word ptr [bx]	;@0A3EA
	lea	ax, [bp-0Ah]	;@0A3EC
	push	ss	;@0A3EF
	push	ax	;@0A3F0
	db	9Ah, 9Fh, 1, 0DFh, 0	; lcall 0xdf, 0x19f	;@0A3F1
	mov	cl, 3	;@0A3F6
	shr	si, cl	;@0A3F8
	mov	di, 5B3Ch	;@0A3FA
@@3:	or	si, si	;@0A3FD
	je	@@5	;@0A3FF
	shr	si, 1	;@0A401
	jae	@@4	;@0A403
	lea	ax, [bp-0Ah]	;@0A405
	push	ss	;@0A408
	push	ax	;@0A409
	push	ds	;@0A40A
	push	di	;@0A40B
	db	9Ah, 65h, 2, 0AFh, 0	; lcall 0xaf, 0x265	;@0A40C
@@4:	add	di, 0Ah	;@0A411
	jmp	@@3	;@0A414
@@5:	les	ax, dword ptr [bp+6]	;@0A416
	push	es	;@0A419
	push	ax	;@0A41A
	lea	ax, [bp-0Ah]	;@0A41B
	push	ss	;@0A41E
	push	ax	;@0A41F
	cmp	word ptr [bp+0Ah], 0	;@0A420
	jns	@@6	;@0A424
	db	9Ah, 50h, 4, 0AFh, 0	; lcall 0xaf, 0x450	;@0A426
	jmp	short @@7	;@0A42B
@@6:	db	9Ah, 65h, 2, 0AFh, 0	; lcall 0xaf, 0x265	;@0A42D
@@7:	pop	di	;@0A432
	pop	si	;@0A433
	mov	sp, bp	;@0A434
	pop	bp	;@0A436
	retf	6	;@0A437
RTL_SCAN_LDOUBLE:	push	bp	;@0A43A
	mov	bp, sp	;@0A43B
	sub	sp, 0Ch	;@0A43D
	push	si	;@0A440
	push	di	;@0A441
	push	ds	;@0A442
	lds	si, dword ptr [bp+0Ah]	;@0A443
	cld	;@0A446
	xor	di, di	;@0A447
	mov	dx, di	;@0A449
	mov	cx, di	;@0A44B
	mov	bx, di	;@0A44D
	mov	word ptr [bp-0Ch], di	;@0A44F
	mov	word ptr [bp-0Ah], di	;@0A452
@@1:	lodsb	;@0A455
	cmp	al, 30h	;@0A456
	db	72h, 67h	; jb L0A4C1	;@0A458
	cmp	al, 39h	;@0A45A
	db	77h, 63h	; ja L0A4C1	;@0A45C
	sub	al, 30h	;@0A45E
	cbw	;@0A460
	or	bx, bx	;@0A461
	jne	@@2	;@0A463
	or	cx, cx	;@0A465
	jne	@@3	;@0A467
	or	dx, dx	;@0A469
	jne	@@3	;@0A46B
	xchg	ax, di	;@0A46D
	mov	dx, 0Ah	;@0A46E
	mul	dx	;@0A471
	add	di, ax	;@0A473
	adc	dx, 0	;@0A475
	adc	cx, 0	;@0A478
	adc	bx, 0	;@0A47B
	mov	ax, word ptr [bp-0Ah]	;@0A47E
	add	word ptr [bp-0Ch], ax	;@0A481
	jmp	@@1	;@0A484
@@2:	cmp	bx, 0CCCh	;@0A486
	db	73h, 2Ch	; jae L0A4B8	;@0A48A
@@3:	push	ax	;@0A48C
	shl	di, 1	;@0A48D
	rcl	dx, 1	;@0A48F
	rcl	cx, 1	;@0A491
	rcl	bx, 1	;@0A493
	push	bx	;@0A495
	push	cx	;@0A496
	push	dx	;@0A497
	push	di	;@0A498
	shl	di, 1	;@0A499
	rcl	dx, 1	;@0A49B
	rcl	cx, 1	;@0A49D
	rcl	bx, 1	;@0A49F
	shl	di, 1	;@0A4A1
	rcl	dx, 1	;@0A4A3
	rcl	cx, 1	;@0A4A5
	rcl	bx, 1	;@0A4A7
	pop	ax	;@0A4A9
	add	di, ax	;@0A4AA
	pop	ax	;@0A4AC
	adc	dx, ax	;@0A4AD
	pop	ax	;@0A4AF
Y0A2F0	ends

Y0A4B0	segment para public 'CODE'
	assume	cs:Y0A4B0
	db	13h, 0C8h, 58h, 13h, 0D8h, 58h, 0EBh, 0BBh	;@0A4B0
L0A4B8:	mov	ax, word ptr [bp-0Ah]	;@0A4B8
	inc	ax	;@0A4BB
	add	word ptr [bp-0Ch], ax	;@0A4BC
	db	0EBh, 94h	; jmp short L181A0+8885	;@0A4BF
L0A4C1:	cmp	al, 2Eh	;@0A4C1
	jne	@@1	;@0A4C3
	cmp	word ptr [bp-0Ah], 0	;@0A4C5
	jne	@@1	;@0A4C9
	dec	word ptr [bp-0Ah]	;@0A4CB
	db	0EBh, 85h	; jmp short L181A0+8885	;@0A4CE
@@1:	mov	word ptr [bp-8], di	;@0A4D0
	mov	word ptr [bp-6], dx	;@0A4D3
	mov	word ptr [bp-4], cx	;@0A4D6
	mov	word ptr [bp-2], bx	;@0A4D9
	mov	di, word ptr [bp-0Ch]	;@0A4DC
	cmp	al, 45h	;@0A4DF
	je	@@2	;@0A4E1
	cmp	al, 65h	;@0A4E3
	jne	@@7	;@0A4E5
@@2:	xor	bx, bx	;@0A4E7
	lodsb	;@0A4E9
	mov	cl, al	;@0A4EA
	cmp	al, 2Dh	;@0A4EC
	je	@@4	;@0A4EE
	cmp	al, 2Bh	;@0A4F0
	je	@@4	;@0A4F2
@@3:	cmp	al, 30h	;@0A4F4
	jb	@@5	;@0A4F6
	cmp	al, 39h	;@0A4F8
	ja	@@5	;@0A4FA
	cmp	bx, 3E8h	;@0A4FC
	jae	@@5	;@0A500
	sub	al, 30h	;@0A502
	cbw	;@0A504
	shl	bx, 1	;@0A505
	mov	dx, bx	;@0A507
	shl	bx, 1	;@0A509
	shl	bx, 1	;@0A50B
	add	bx, dx	;@0A50D
	add	bx, ax	;@0A50F
@@4:	lodsb	;@0A511
	jmp	@@3	;@0A512
@@5:	cmp	cl, 2Dh	;@0A514
	jne	@@6	;@0A517
	neg	bx	;@0A519
@@6:	add	di, bx	;@0A51B
@@7:	pop	ds	;@0A51D
	lea	ax, [bp-8]	;@0A51E
	push	ss	;@0A521
	push	ax	;@0A522
	les	ax, dword ptr [bp+6]	;@0A523
	push	es	;@0A526
	push	ax	;@0A527
	db	9Ah, 8, 0, 0DFh, 0	; lcall 0xdf, 8	;@0A528
	mov	ax, 0F000h	;@0A52D
Y0A4B0	ends

Y0A530	segment para public 'CODE'
	assume	cs:Y0A530
	db	3Bh, 0F8h, 7Dh, 0Dh, 2Bh, 0F8h, 50h, 0C4h, 46h, 6, 6, 50h, 9Ah	;@0A530
	db	0Eh, 0, 0EFh, 0, 57h, 0C4h, 46h, 6, 6, 50h, 9Ah, 0Eh, 0, 0EFh
	db	0, 96h, 'H+F', 0Ah, 0EBh, 0, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0CAh, 8
	db	0
RTL_ATOL:	push	bp	;@0A55B
	mov	bp, sp	;@0A55C
	sub	sp, 4	;@0A55E
	push	si	;@0A561
	jmp	short @@2	;@0A562
@@1:	inc	word ptr [bp+6]	;@0A564
@@2:	les	bx, dword ptr [bp+6]	;@0A567
	cmp	byte ptr es:[bx], 20h	;@0A56A
	je	@@1	;@0A56E
	cmp	byte ptr es:[bx], 9	;@0A570
	je	@@1	;@0A574
	cmp	byte ptr es:[bx], 2Dh	;@0A576
	jne	@@3	;@0A57A
	mov	si, 1	;@0A57C
	add	word ptr [bp+6], si	;@0A57F
	jmp	short @@4	;@0A582
@@3:	xor	si, si	;@0A584
@@4:	mov	word ptr [bp-2], 0	;@0A586
	mov	word ptr [bp-4], 0	;@0A58B
	jmp	short @@6	;@0A590
@@5:	mov	dx, word ptr [bp-2]	;@0A592
	mov	ax, word ptr [bp-4]	;@0A595
	xor	cx, cx	;@0A598
	mov	bx, 0Ah	;@0A59A
	db	9Ah, 0A9h, 3, 1Fh, 0	; lcall 0x1f, 0x3a9	;@0A59D
	les	bx, dword ptr [bp+6]	;@0A5A2
	push	dx	;@0A5A5
	push	ax	;@0A5A6
	mov	al, byte ptr es:[bx]	;@0A5A7
	cbw	;@0A5AA
	cwd	;@0A5AB
	pop	bx	;@0A5AC
	pop	cx	;@0A5AD
	add	bx, ax	;@0A5AE
	adc	cx, dx	;@0A5B0
	add	bx, -30h	;@0A5B2
	adc	cx, -1	;@0A5B5
	mov	word ptr [bp-2], cx	;@0A5B8
	mov	word ptr [bp-4], bx	;@0A5BB
	inc	word ptr [bp+6]	;@0A5BE
@@6:	les	bx, dword ptr [bp+6]	;@0A5C1
	cmp	byte ptr es:[bx], 30h	;@0A5C4
	jl	@@7	;@0A5C8
	cmp	byte ptr es:[bx], 39h	;@0A5CA
	jle	@@5	;@0A5CE
@@7:	or	si, si	;@0A5D0
	je	@@8	;@0A5D2
	mov	dx, word ptr [bp-2]	;@0A5D4
	mov	ax, word ptr [bp-4]	;@0A5D7
	neg	dx	;@0A5DA
	neg	ax	;@0A5DC
	sbb	dx, 0	;@0A5DE
	mov	word ptr [bp-2], dx	;@0A5E1
	mov	word ptr [bp-4], ax	;@0A5E4
@@8:	mov	dx, word ptr [bp-2]	;@0A5E7
	mov	ax, word ptr [bp-4]	;@0A5EA
	pop	si	;@0A5ED
	mov	sp, bp	;@0A5EE
	pop	bp	;@0A5F0
	retf	4	;@0A5F1
RTL_ATOI:	push	bp	;@0A5F4
	mov	bp, sp	;@0A5F5
	push	word ptr [bp+8]	;@0A5F7
	push	word ptr [bp+6]	;@0A5FA
	push	cs	;@0A5FD
	call	RTL_ATOL	;@0A5FE
	pop	bp	;@0A601
	retf	4	;@0A602
ADD_TRAILING_BACKSLASH:	push	bp	;@0A605
	mov	bp, sp	;@0A606
	sub	sp, 4	;@0A608
	push	si	;@0A60B
	push	word ptr [bp+8]	;@0A60C
	push	word ptr [bp+6]	;@0A60F
	db	9Ah, 0Fh, 5, 2Fh, 0	; lcall 0x2f, 0x50f	;@0A612
	push	word ptr [bp+8]	;@0A617
	push	word ptr [bp+6]	;@0A61A
	db	9Ah, 4, 0, 5Fh, 2	; lcall 0x25f, 4	;@0A61D
	mov	si, ax	;@0A622
	les	bx, dword ptr [bp+6]	;@0A624
	add	bx, si	;@0A627
	dec	bx	;@0A629
	mov	word ptr [bp-2], es	;@0A62A
	mov	word ptr [bp-4], bx	;@0A62D
	or	si, si	;@0A630
	db	7Eh, 26h	; jle L0A65A	;@0A632
	cmp	byte ptr es:[bx], 5Ch	;@0A634
	db	74h, 20h	; je L0A65A	;@0A638
	cmp	byte ptr es:[bx], 2Fh	;@0A63A
	db	74h, 1Ah	; je L0A65A	;@0A63E
	cmp	byte ptr es:[bx], 3Ah	;@0A640
	db	74h, 14h	; je L0A65A	;@0A644
	inc	word ptr [bp-4]	;@0A646
	mov	bx, word ptr [bp-4]	;@0A649
	mov	byte ptr es:[bx], 5Ch	;@0A64C
Y0A530	ends

Y0A650	segment para public 'CODE'
	assume	cs:Y0A650
	db	0FFh, 46h, 0FCh, 8Bh, 5Eh, 0FCh, 26h, 0C6h, 7, 0	;@0A650
L0A65A:	pop	si	;@0A65A
	mov	sp, bp	;@0A65B
	pop	bp	;@0A65D
	retf	4	;@0A65E
DOS_CALL_AH:	push	bp	;@0A661
	mov	bp, sp	;@0A662
	mov	ah, byte ptr [bp+0Ah]	;@0A664
	int	21h	;@0A667
	pop	bp	;@0A669
	retf	6	;@0A66A
RTL_DOS_CALL_PTR:	push	bp	;@0A66D
	mov	bp, sp	;@0A66E
	mov	ah, byte ptr [bp+0Ch]	;@0A670
	push	ds	;@0A673
	lds	dx, dword ptr [bp+8]	;@0A674
	clc	;@0A677
	int	21h	;@0A678
	pop	ds	;@0A67A
	jae	@@1	;@0A67B
	mov	word ptr ds:[0], ax	;@0A67D
	mov	ax, 0FFFFh	;@0A680
@@1:	pop	bp	;@0A683
	retf	8	;@0A684
	db	55h, 8Bh, 0ECh, 8Bh, 46h, 0Ah, 0Bh, 46h, 0Ch, 74h, 1Eh, 0FFh, 76h	;@0A687
	db	0Ch, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 6, 0FFh, 76h, 4
	db	9Ah, 2Fh, 0, 0DFh, 2, 0C4h, 5Eh, 0Ah, 3, 5Eh, 4, 26h, 0C6h, 7
	db	0, 0C4h, 5Eh, 6, 26h, 0C6h, 7, 0, 5Dh, 0C2h, 0Ah, 0
FNSPLIT:	push	bp	;@0A6BB
	mov	bp, sp	;@0A6BC
	sub	sp, 56h	;@0A6BE
	push	si	;@0A6C1
	push	di	;@0A6C2
	xor	di, di	;@0A6C3
	mov	ax, word ptr [bp+12h]	;@0A6C5
	or	ax, word ptr [bp+14h]	;@0A6C8
	je	@@1	;@0A6CB
	les	bx, dword ptr [bp+12h]	;@0A6CD
	mov	byte ptr es:[bx], 0	;@0A6D0
@@1:	mov	ax, word ptr [bp+0Eh]	;@0A6D4
	or	ax, word ptr [bp+10h]	;@0A6D7
	je	@@2	;@0A6DA
	les	bx, dword ptr [bp+0Eh]	;@0A6DC
	mov	byte ptr es:[bx], 0	;@0A6DF
@@2:	mov	ax, word ptr [bp+0Ah]	;@0A6E3
	or	ax, word ptr [bp+0Ch]	;@0A6E6
	je	@@3	;@0A6E9
	les	bx, dword ptr [bp+0Ah]	;@0A6EB
	mov	byte ptr es:[bx], 0	;@0A6EE
@@3:	mov	ax, word ptr [bp+6]	;@0A6F2
	or	ax, word ptr [bp+8]	;@0A6F5
	db	74h, 7	; je L0A701	;@0A6F8
	les	bx, dword ptr [bp+6]	;@0A6FA
	db	26h, 0C6h, 7	; mov byte ptr es:[bx], 0	;@0A6FD
Y0A650	ends

Y0A700	segment para public 'CODE'
	assume	cs:Y0A700
	db	0	;@0A700
L0A701:	mov	bx, ss	;@0A701
	mov	es, bx	;@0A703
	lea	bx, [bp-52h]	;@0A705
	mov	word ptr [bp-54h], es	;@0A708
	mov	word ptr [bp-56h], bx	;@0A70B
	jmp	short @@2	;@0A70E
@@1:	inc	word ptr [bp+16h]	;@0A710
@@2:	les	bx, dword ptr [bp+16h]	;@0A713
	cmp	byte ptr es:[bx], 20h	;@0A716
	je	@@1	;@0A71A
	push	word ptr [bp+18h]	;@0A71C
	push	bx	;@0A71F
	db	9Ah, 4, 0, 5Fh, 2	; lcall 0x25f, 4	;@0A720
	mov	si, ax	;@0A725
	mov	ax, si	;@0A727
	cmp	ax, 50h	;@0A729
	jle	@@3	;@0A72C
	mov	si, 50h	;@0A72E
@@3:	les	bx, dword ptr [bp-56h]	;@0A731
	mov	byte ptr es:[bx], 0	;@0A734
	inc	word ptr [bp-56h]	;@0A738
	push	word ptr [bp-54h]	;@0A73B
	push	word ptr [bp-56h]	;@0A73E
	push	word ptr [bp+18h]	;@0A741
	push	word ptr [bp+16h]	;@0A744
	push	si	;@0A747
	db	9Ah, 2Fh, 0, 0DFh, 2	; lcall 0x2df, 0x2f	;@0A748
	add	word ptr [bp-56h], si	;@0A74D
	les	bx, dword ptr [bp-56h]	;@0A750
	mov	byte ptr es:[bx], 0	;@0A753
	xor	si, si	;@0A757
	dec	word ptr [bp-56h]	;@0A759
	les	bx, dword ptr [bp-56h]	;@0A75C
	db	26h	; mov al, byte ptr es:[bx]	;@0A75F
Y0A700	ends

Y0A760	segment para public 'CODE'
	assume	cs:Y0A760
	db	8Ah, 7, 98h, 3Dh, 2Fh, 0, 75h, 3, 0E9h, 78h, 0, 7Fh, 13h, 0Bh	;@0A760
	db	0C0h, 'tF=*', 0, 75h, 3, 0E9h, 0AAh, 0, 3Dh, 2Eh, 0, 74h, 16h
	db	0EBh, 0D9h
Y0A760	ends

Y0A780	segment para public 'CODE'
	assume	cs:Y0A780
	db	3Dh, 3Ah, 0, 't2=?', 0, 75h, 3, 0E9h, 96h, 0, 3Dh, 5Ch, 0, 74h	;@0A780
	db	51h, 0EBh, 0C5h, 0Bh, 0F6h, 75h, 0C1h, 0F7h, 0C7h, 2, 0, 75h, 0BBh
	db	81h, 0CFh, 2, 0, 0FFh, 76h, 8, 0FFh, 76h, 6, 0FFh, 76h, 0ACh, 0FFh
	db	76h, 0AAh, 0B8h, 5, 0, 50h, 0E8h, 0D2h, 0FEh, 0EBh, 0A2h, 0Bh
	db	0F6h, 74h, 28h, 0FFh, 46h, 0AAh, 0C4h, 5Eh, 0AAh, 26h, 80h, 3Fh
	db	0, 74h, 4, 81h, 0CFh, 8, 0, 0FFh, 76h, 10h, 0FFh, 76h, 0Eh, 0FFh
	db	76h, 0ACh, 0FFh, 76h, 0AAh, 0B8h, 42h, 0, 50h, 0E8h, 0A9h, 0FEh
	db	0FFh, 4Eh, 0AAh, 0EBh, 4Eh, 0Bh, 0F6h, 74h, 3, 0E9h, 6Fh, 0FFh
	db	46h, 0FFh, 46h, 0AAh, 0C4h, 5Eh, 0AAh, 26h, 80h, 3Fh, 0, 74h, 4
	db	81h, 0CFh, 4, 0, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 76h, 0ACh
	db	0FFh, 76h, 0AAh, 0B8h, 9, 0, 50h, 0E8h, 79h, 0FEh, 0FFh, 4Eh, 0AAh
	db	0C4h, 5Eh, 0AAh, 26h, 80h, '?:t', 17h, 26h, 80h, 3Fh, 0, 74h, 11h
	db	0E9h, 36h, 0FFh, 0Bh, 0F6h, 74h, 3, 0E9h, 2Fh, 0FFh, 81h, 0CFh
	db	1, 0, 0E9h, 28h, 0FFh, 0C4h, 5Eh, 0AAh, 26h, 80h, '?:u', 1Ch, 80h
	db	7Eh, 0AFh, 0, 74h, 4, 81h, 0CFh, 10h, 0, 0FFh, 76h, 14h, 0FFh
	db	76h, 12h, 16h, 8Dh, 46h, 0AFh, 50h, 0B8h, 3, 0, 50h, 0E8h, 31h
	db	0FEh, 8Bh, 0C7h, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0CAh, 14h, 0
L0A860:	push	bp	;@0A860
	mov	bp, sp	;@0A861
	jmp	short @@2	;@0A863
@@1:	inc	word ptr [bp+0Ah]	;@0A865
@@2:	les	bx, dword ptr [bp+6]	;@0A868
	inc	word ptr [bp+6]	;@0A86B
	mov	al, byte ptr es:[bx]	;@0A86E
	les	bx, dword ptr [bp+0Ah]	;@0A871
	mov	byte ptr es:[bx], al	;@0A874
	or	al, al	;@0A877
	jne	@@1	;@0A879
	mov	dx, word ptr [bp+0Ch]	;@0A87B
	mov	ax, bx	;@0A87E
	pop	bp	;@0A880
	retf	8	;@0A881
FNMERGE:	push	bp	;@0A884
	mov	bp, sp	;@0A885
	mov	ax, word ptr [bp+12h]	;@0A887
	or	ax, word ptr [bp+14h]	;@0A88A
	je	@@1	;@0A88D
	les	bx, dword ptr [bp+12h]	;@0A88F
	cmp	byte ptr es:[bx], 0	;@0A892
	je	@@1	;@0A896
	mov	al, byte ptr es:[bx]	;@0A898
	les	bx, dword ptr [bp+16h]	;@0A89B
	mov	byte ptr es:[bx], al	;@0A89E
	inc	word ptr [bp+12h]	;@0A8A1
	inc	word ptr [bp+16h]	;@0A8A4
	mov	bx, word ptr [bp+16h]	;@0A8A7
	mov	byte ptr es:[bx], 3Ah	;@0A8AA
	inc	word ptr [bp+16h]	;@0A8AE
@@1:	mov	ax, word ptr [bp+0Eh]	;@0A8B1
	or	ax, word ptr [bp+10h]	;@0A8B4
	je	@@2	;@0A8B7
	les	bx, dword ptr [bp+0Eh]	;@0A8B9
	cmp	byte ptr es:[bx], 0	;@0A8BC
	je	@@2	;@0A8C0
	push	word ptr [bp+18h]	;@0A8C2
	push	word ptr [bp+16h]	;@0A8C5
	push	word ptr [bp+10h]	;@0A8C8
	push	bx	;@0A8CB
	push	cs	;@0A8CC
	call	L0A860	;@0A8CD
	mov	word ptr [bp+18h], dx	;@0A8D0
	mov	word ptr [bp+16h], ax	;@0A8D3
	les	bx, dword ptr [bp+16h]	;@0A8D6
	dec	bx	;@0A8D9
	cmp	byte ptr es:[bx], 5Ch	;@0A8DA
	je	@@2	;@0A8DE
	mov	bx, ax	;@0A8E0
	dec	bx	;@0A8E2
	cmp	byte ptr es:[bx], 2Fh	;@0A8E3
	je	@@2	;@0A8E7
	mov	bx, ax	;@0A8E9
	mov	byte ptr es:[bx], 5Ch	;@0A8EB
	inc	word ptr [bp+16h]	;@0A8EF
@@2:	mov	ax, word ptr [bp+0Ah]	;@0A8F2
	or	ax, word ptr [bp+0Ch]	;@0A8F5
	je	@@3	;@0A8F8
	push	word ptr [bp+18h]	;@0A8FA
	push	word ptr [bp+16h]	;@0A8FD
	push	word ptr [bp+0Ch]	;@0A900
	push	word ptr [bp+0Ah]	;@0A903
	push	cs	;@0A906
	call	L0A860	;@0A907
	mov	word ptr [bp+18h], dx	;@0A90A
	mov	word ptr [bp+16h], ax	;@0A90D
@@3:	mov	ax, word ptr [bp+6]	;@0A910
	or	ax, word ptr [bp+8]	;@0A913
	je	@@4	;@0A916
	push	word ptr [bp+18h]	;@0A918
	push	word ptr [bp+16h]	;@0A91B
	push	word ptr [bp+8]	;@0A91E
	push	word ptr [bp+6]	;@0A921
	push	cs	;@0A924
	call	L0A860	;@0A925
	mov	word ptr [bp+18h], dx	;@0A928
	mov	word ptr [bp+16h], ax	;@0A92B
@@4:	les	bx, dword ptr [bp+16h]	;@0A92E
	mov	byte ptr es:[bx], 0	;@0A931
	pop	bp	;@0A935
	retf	14h	;@0A936
BCC_BINARY_SEARCH:	push	bp	;@0A939
	mov	bp, sp	;@0A93A
	sub	sp, 0Ah	;@0A93C
	push	si	;@0A93F
	push	di	;@0A940
	mov	si, word ptr [bp+0Ch]	;@0A941
	les	bx, dword ptr [bp+0Eh]	;@0A944
	mov	word ptr [bp-8], es	;@0A947
	mov	word ptr [bp-0Ah], bx	;@0A94A
	jmp	short @@4	;@0A94D
@@1:	mov	di, si	;@0A94F
	sar	di, 1	;@0A951
	mov	ax, di	;@0A953
	mul	word ptr [bp+0Ah]	;@0A955
	les	bx, dword ptr [bp-0Ah]	;@0A958
	add	bx, ax	;@0A95B
	mov	word ptr [bp-4], es	;@0A95D
	mov	word ptr [bp-6], bx	;@0A960
	push	word ptr [bp+14h]	;@0A963
	push	word ptr [bp+12h]	;@0A966
	push	word ptr [bp-4]	;@0A969
	push	bx	;@0A96C
	call	dword ptr [bp+6]	;@0A96D
	mov	word ptr [bp-2], ax	;@0A970
	or	ax, ax	;@0A973
	jne	@@2	;@0A975
	mov	dx, word ptr [bp-4]	;@0A977
	mov	ax, word ptr [bp-6]	;@0A97A
	jmp	short @@5	;@0A97D
@@2:	cmp	word ptr [bp-2], 0	;@0A97F
	jge	@@3	;@0A983
	mov	si, di	;@0A985
	jmp	short @@4	;@0A987
@@3:	les	bx, dword ptr [bp-6]	;@0A989
	add	bx, word ptr [bp+0Ah]	;@0A98C
	mov	word ptr [bp-8], es	;@0A98F
	mov	word ptr [bp-0Ah], bx	;@0A992
	mov	ax, si	;@0A995
	sub	ax, di	;@0A997
	dec	ax	;@0A999
	mov	si, ax	;@0A99A
@@4:	or	si, si	;@0A99C
	jg	@@1	;@0A99E
	xor	dx, dx	;@0A9A0
	mov	ax, dx	;@0A9A2
@@5:	pop	di	;@0A9A4
	pop	si	;@0A9A5
	mov	sp, bp	;@0A9A6
	pop	bp	;@0A9A8
	retf	10h	;@0A9A9
__chmod:	push	bp	;@0A9AC
	mov	bp, sp	;@0A9AD
	mov	cx, word ptr [bp+0Ch]	;@0A9AF
	mov	al, byte ptr [bp+0Ah]	;@0A9B2
	push	ds	;@0A9B5
	lds	dx, dword ptr [bp+6]	;@0A9B6
	mov	ah, 43h	;@0A9B9
	int	21h	;@0A9BB
	pop	ds	;@0A9BD
	jae	@@1	;@0A9BE
	mov	word ptr ds:[0], ax	;@0A9C0
	mov	ax, 0FFFFh	;@0A9C3
	jmp	short @@3	;@0A9C6
@@1:	cmp	word ptr [bp+0Ah], 1	;@0A9C8
	jne	@@2	;@0A9CC
	xor	ax, ax	;@0A9CE
	jmp	short @@3	;@0A9D0
@@2:	mov	ax, cx	;@0A9D2
@@3:	pop	bp	;@0A9D4
	retf	;@0A9D5
RTL_CLOSE:	push	bp	;@0A9D6
	mov	bp, sp	;@0A9D7
	push	si	;@0A9D9
	mov	si, word ptr [bp+6]	;@0A9DA
	mov	bx, si	;@0A9DD
	mov	ah, 3Eh	;@0A9DF
	int	21h	;@0A9E1
	jae	@@1	;@0A9E3
	mov	word ptr ds:[0], ax	;@0A9E5
	mov	ax, 0FFFFh	;@0A9E8
	jmp	short @@2	;@0A9EB
@@1:	xor	ax, ax	;@0A9ED
@@2:	pop	si	;@0A9EF
	pop	bp	;@0A9F0
	retf	2	;@0A9F1
RTL_CREAT:	push	bp	;@0A9F4
	mov	bp, sp	;@0A9F5
	push	si	;@0A9F7
	mov	cx, word ptr [bp+6]	;@0A9F8
	push	ds	;@0A9FB
	lds	dx, dword ptr [bp+8]	;@0A9FC
	mov	ah, 3Ch	;@0A9FF
	int	21h	;@0AA01
	pop	ds	;@0AA03
	jae	@@1	;@0AA04
	mov	word ptr ds:[0], ax	;@0AA06
	mov	ax, 0FFFFh	;@0AA09
	jmp	short @@1	;@0AA0C
@@1:	pop	si	;@0AA0E
	pop	bp	;@0AA0F
	retf	6	;@0AA10
	db	55h, 8Bh, 0ECh, 8Bh, 0C4h, 0A3h, 68h, 8Dh, 8Ch, 0D0h, 0A3h, 66h	;@0AA13
	db	8Dh, 8Bh, 16h, 12h, 0, 0B8h, 80h, 0, 52h, 50h, 0FFh, 76h, 0Eh
	db	0FFh, 76h, 0Ch, 9Ah
Y0A780	ends

Y0AA30	segment para public 'CODE'
	assume	cs:Y0AA30
	db	4, 0, 0DFh, 2, 0C4h, 5Eh, 6, 8Eh, 1Eh, 12h, 0, 0BAh, 80h, 0, 0B4h	;@0AA30
	db	4Bh, 8Ah, 46h, 0Ah, 0CDh, 21h, 0BAh, 87h, 0Bh, 8Eh, 0DAh, 0FAh
	db	8Eh, 16h, 66h, 8Dh, 8Bh, 26h, 68h, 8Dh, 0FBh, 8Bh, 0ECh, 73h, 8
	db	0A3h, 0, 0, 0B8h, 0FFh, 0FFh, 0EBh, 10h, 80h, 7Eh, 0Ah, 0, 75h
	db	6, 0B4h, 4Dh, 0CDh, 21h, 0EBh, 4, 33h, 0C0h, 0EBh, 0, 5Dh, 0CAh
	db	0Ah, 0
FINDFIRST:	push	bp	;@0AA74
	mov	bp, sp	;@0AA75
	mov	ax, 1Ah	;@0AA77
	push	ax	;@0AA7A
	push	word ptr [bp+0Ah]	;@0AA7B
	push	word ptr [bp+8]	;@0AA7E
	xor	ax, ax	;@0AA81
	push	ax	;@0AA83
	db	9Ah, 0Dh, 0, 3Fh, 1	; lcall 0x13f, 0xd	;@0AA84
	push	ds	;@0AA89
	lds	dx, dword ptr [bp+0Ch]	;@0AA8A
	mov	cx, word ptr [bp+6]	;@0AA8D
	mov	ah, 4Eh	;@0AA90
	int	21h	;@0AA92
	pop	ds	;@0AA94
	jae	@@1	;@0AA95
	mov	word ptr ds:[0], ax	;@0AA97
	mov	ax, 0FFFFh	;@0AA9A
	db	0EBh, 2	; jmp short L0AAA1	;@0AA9D
@@1:	db	33h	; xor ax, ax	;@0AA9F
Y0AA30	ends

Y0AAA0	segment para public 'CODE'
	assume	cs:Y0AAA0
	db	0C0h	;@0AAA0
L0AAA1:	pop	bp	;@0AAA1
	retf	0Ah	;@0AAA2
FINDNEXT:	push	bp	;@0AAA5
	mov	bp, sp	;@0AAA6
	mov	ax, 1Ah	;@0AAA8
	push	ax	;@0AAAB
	push	word ptr [bp+8]	;@0AAAC
	push	word ptr [bp+6]	;@0AAAF
	xor	ax, ax	;@0AAB2
	push	ax	;@0AAB4
	db	9Ah, 0Dh, 0, 3Fh, 1	; lcall 0x13f, 0xd	;@0AAB5
	mov	ah, 4Fh	;@0AABA
	int	21h	;@0AABC
	jae	@@1	;@0AABE
	mov	word ptr ds:[0], ax	;@0AAC0
	mov	ax, 0FFFFh	;@0AAC3
	jmp	short @@2	;@0AAC6
@@1:	xor	ax, ax	;@0AAC8
@@2:	pop	bp	;@0AACA
	retf	4	;@0AACB
RTL_GETDATE:	push	bp	;@0AACE
	db	8Bh	; mov bp, sp	;@0AACF
Y0AAA0	ends

Y0AAD0	segment para public 'CODE'
	assume	cs:Y0AAD0
	db	0ECh, 0B4h, 2Ah, 0CDh, 21h, 0C4h, 5Eh, 6, 26h, 89h, 0Fh, 26h, 89h	;@0AAD0
	db	57h, 2, 5Dh, 0CAh, 4, 0
RTL_GETTIME:	push	bp	;@0AAE3
	mov	bp, sp	;@0AAE4
	mov	ah, 2Ch	;@0AAE6
	int	21h	;@0AAE8
	les	bx, dword ptr [bp+6]	;@0AAEA
	mov	word ptr es:[bx], cx	;@0AAED
Y0AAD0	ends

Y0AAF0	segment para public 'CODE'
	assume	cs:Y0AAF0
	db	26h, 89h, 57h, 2, 5Dh, 0CAh, 4, 0	;@0AAF0
RTL_GETENV:	push	bp	;@0AAF8
	mov	bp, sp	;@0AAF9
	sub	sp, 8	;@0AAFB
	push	si	;@0AAFE
	mov	dx, word ptr ds:[14h]	;@0AAFF
	xor	ax, ax	;@0AB03
	mov	word ptr [bp-6], dx	;@0AB05
	mov	word ptr [bp-8], ax	;@0AB08
	db	0EBh, 67h	; jmp short L0AB74	;@0AB0B
	db	0C4h, 5Eh, 6	;@0AB0D
Y0AAF0	ends
	end
