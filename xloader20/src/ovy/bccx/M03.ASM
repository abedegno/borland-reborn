	.286p
	locals
	public	L0B040
	extrn	L181A0:byte

Y0AE30	segment para public 'CODE'
	assume	cs:Y0AE30
	db	46h, 0FCh, 89h, 5Eh, 0FAh, 0FFh, 4Eh, 0FAh, 8Bh, 5Eh, 0FAh, 26h	;@0AE30
	db	0C6h, 7, 0, 0C4h, 5Eh, 0Ah, 26h, 80h, '?lu', 6, 0FFh, 46h, 0Ah
	db	0BEh, 1, 0, 0C4h, 5Eh, 0Ah, 26h, 8Ah, 7, 98h, 3Dh, 73h, 0, 75h
	db	3, 0E9h, 0B5h, 1, 7Fh, 10h, 3Dh, 63h, 0, 75h, 3, 0E9h, 9Bh, 1
	db	3Dh, 64h, 0, 74h, 0Eh, 0E9h, 0DDh, 1, 3Dh, 78h, 0, 75h, 3, 0E9h
	db	1, 1, 0E9h, 0D2h, 1, 0Bh, 0F6h, 74h, 16h, 0C4h, 5Eh
Y0AE30	ends

Y0AE80	segment para public 'CODE'
	assume	cs:Y0AE80
	db	6, 26h, 8Bh, 57h, 2, 26h, 8Bh, 7, 89h, 56h, 0ECh, 89h, 46h, 0EAh	;@0AE80
	db	83h, 46h, 6, 4, 0EBh, 11h, 0C4h, 5Eh, 6, 26h, 8Bh, 7, 99h, 89h
	db	56h, 0ECh, 89h, 46h
Y0AE80	ends

Y0AEA0	segment para public 'CODE'
	assume	cs:Y0AEA0
	db	0EAh, 83h, 46h, 6, 2, 81h, 7Eh, 0ECh, 0, 80h, 75h, 11h, 83h, 7Eh	;@0AEA0
	db	0EAh, 0, 75h, 0Bh, 8Ch, 5Eh, 0FCh, 0C7h, 46h, 0FAh, 0A2h, 5Ch
	db	0E9h, 84h, 0, 8Bh, 46h, 0EAh
Y0AEA0	ends

Y0AEC0	segment para public 'CODE'
	assume	cs:Y0AEC0
	db	0Bh, 46h, 0ECh, 75h, 0Ah, 0BAh, 30h, 0, 0B4h, 2, 0CDh, 21h, 0E9h	;@0AEC0
	db	6Eh, 1, 83h, 7Eh, 0ECh, 0, 7Fh, 22h, 7Ch, 6, 83h, 7Eh, 0EAh, 0
	db	73h, 1Ah, 0C7h, 46h, 0FEh, 1, 0, 8Bh, 56h, 0ECh, 8Bh, 46h, 0EAh
	db	0F7h, 0DAh, 0F7h, 0D8h, 83h, 0DAh, 0, 89h, 56h, 0ECh, 89h, 46h
	db	0EAh, 0EBh, 3Ch, 0C7h, 46h, 0FEh, 0, 0, 0EBh, 35h, 0FFh, 4Eh, 0FAh
	db	33h, 0D2h, 0B8h, 0Ah, 0, 52h, 50h, 0FFh, 76h, 0ECh, 0FFh, 76h
	db	0EAh, 9Ah, 0D2h, 2, 1Fh, 0, 4, 30h, 0C4h, 5Eh, 0FAh, 26h, 88h
	db	7, 33h, 0D2h, 0B8h, 0Ah, 0, 52h, 50h, 0FFh, 76h, 0ECh, 0FFh, 76h
	db	0EAh, 9Ah, 0C9h, 2, 1Fh, 0, 89h, 56h, 0ECh, 89h, 46h, 0EAh, 8Bh
	db	46h, 0EAh, 0Bh, 46h, 0ECh, 75h, 0C3h, 83h, 7Eh, 0FEh, 0, 74h, 7
	db	0C7h, 46h, 0FEh, 2Dh, 0, 0EBh, 5, 0C7h, 46h, 0FEh, 0, 0, 83h, 7Eh
	db	0FEh, 0, 74h, 19h, 8Bh, 56h, 0FEh, 0B4h, 2, 0CDh, 21h, 0EBh, 10h
	db	0C4h, 5Eh, 0FAh, 26h, 8Ah, 7, 98h, 8Bh, 0D0h, 0FFh, 46h, 0FAh
	db	0B4h, 2, 0CDh, 21h, 0C4h, 5Eh, 0FAh, 26h, 80h, 3Fh, 0, 75h, 0E7h
	db	0E9h, 0C5h, 0, 0Bh, 0F6h, 74h, 16h, 0C4h, 5Eh, 6, 26h, 8Bh, 57h
	db	2, 26h, 8Bh, 7, 89h, 56h, 0E8h, 89h, 46h, 0E6h, 83h, 46h, 6, 4
	db	0EBh, 4Bh, 0C4h, 5Eh, 6, 26h, 8Bh, 7, 33h, 0D2h, 89h, 56h, 0E8h
	db	89h, 46h, 0E6h, 83h, 46h, 6, 2, 0EBh, 37h, 0FFh, 4Eh, 0FAh, 8Bh
	db	46h, 0E6h, 25h, 0Fh, 0, 89h, 46h, 0FEh, 3Dh, 9, 0, 7Eh, 6, 83h
	db	46h, 0FEh, 57h, 0EBh, 4, 83h, 46h, 0FEh, 30h, 8Ah, 46h, 0FEh, 0C4h
	db	5Eh, 0FAh, 26h, 88h, 7, 8Bh, 56h, 0E8h, 8Bh, 46h, 0E6h, 0B1h, 4
	db	9Ah, 0E3h, 3, 1Fh, 0, 89h, 56h, 0E8h, 89h, 46h, 0E6h, 8Bh, 46h
	db	0E6h, 0Bh, 46h, 0E8h, 75h, 0C1h, 0EBh, 10h, 0C4h, 5Eh, 0FAh, 26h
	db	8Ah, 7, 98h, 8Bh, 0D0h, 0FFh, 46h, 0FAh, 0B4h, 2, 0CDh, 21h, 0C4h
	db	5Eh, 0FAh, 26h, 80h, 3Fh, 0, 75h, 0E7h, 0EBh, 3Bh, 0C4h, 5Eh, 6
	db	26h, 8Bh, 17h, 83h, 46h, 6, 2, 0B4h, 2, 0CDh, 21h, 0EBh, 2Bh, 0C4h
	db	5Eh, 6, 26h, 0C4h, 1Fh, 8Ch, 46h, 0FCh, 89h, 5Eh, 0FAh, 83h, 46h
	db	6, 4, 0EBh, 10h, 0C4h, 5Eh, 0FAh, 26h, 8Ah, 7, 98h, 8Bh, 0D0h
	db	0FFh, 46h, 0FAh, 0B4h, 2, 0CDh, 21h, 0C4h, 5Eh, 0FAh, 26h, 80h
	db	3Fh, 0, 75h, 0E7h, 0FFh, 46h, 0Ah
L0B040:	les	bx, dword ptr [bp+0Ah]	;@0B040
	cmp	byte ptr es:[bx], 0	;@0B043
	je	@@1	;@0B047
	db	0E9h, 0B1h, 0FDh	; jmp L181A0+11357	;@0B049
@@1:	pop	si	;@0B04C
	mov	sp, bp	;@0B04D
	pop	bp	;@0B04F
	retf	8	;@0B050
RTL_ULDIV10:	xor	si, si	;@0B053
	xor	di, di	;@0B055
	mov	bx, 0Ah	;@0B057
	cmp	dx, bx	;@0B05A
	jae	@@1	;@0B05C
	div	bx	;@0B05E
	xchg	si, dx	;@0B060
	jmp	short @@5	;@0B062
@@1:	mov	cx, 20h	;@0B064
@@2:	shl	ax, 1	;@0B067
	rcl	dx, 1	;@0B069
	rcl	si, 1	;@0B06B
	rcl	di, 1	;@0B06D
	test	di, di	;@0B06F
	jne	@@3	;@0B071
	cmp	si, bx	;@0B073
	jb	@@4	;@0B075
@@3:	sub	si, bx	;@0B077
	sbb	di, 0	;@0B079
	inc	ax	;@0B07C
@@4:	loop	@@2	;@0B07D
@@5:	ret	;@0B07F
RTL_ULTOA_CORE:	mov	byte ptr es:[di], 0	;@0B080
	xor	bp, bp	;@0B084
@@1:	mov	bx, ax	;@0B086
	or	bx, dx	;@0B088
	je	@@2	;@0B08A
	push	di	;@0B08C
	call	RTL_ULDIV10	;@0B08D
	pop	di	;@0B090
	mov	bx, si	;@0B091
	add	bl, 30h	;@0B093
	mov	word ptr es:[di], bx	;@0B096
	inc	di	;@0B099
	inc	bp	;@0B09A
	jmp	@@1	;@0B09B
@@2:	or	bp, bp	;@0B09D
	jne	@@3	;@0B09F
	mov	word ptr es:[di], 30h	;@0B0A1
	inc	di	;@0B0A6
	inc	bp	;@0B0A7
@@3:	mov	bx, bp	;@0B0A8
	sub	di, bx	;@0B0AA
	dec	bx	;@0B0AC
@@4:	jle	@@5	;@0B0AD
	mov	al, byte ptr es:[di]	;@0B0AF
	mov	ah, byte ptr es:[bx+di]	;@0B0B2
	mov	byte ptr es:[di], ah	;@0B0B5
	mov	byte ptr es:[bx+di], al	;@0B0B8
	inc	di	;@0B0BB
	dec	bx	;@0B0BC
	dec	bx	;@0B0BD
	jmp	@@4	;@0B0BE
@@5:	ret	;@0B0C0
RTL_LTOA_CORE:	or	dx, dx	;@0B0C1
	jns	@@1	;@0B0C3
	mov	byte ptr es:[di], 2Dh	;@0B0C5
	inc	di	;@0B0C9
	not	dx	;@0B0CA
	not	ax	;@0B0CC
	add	ax, 1	;@0B0CE
	adc	dx, 0	;@0B0D1
@@1:	jmp	RTL_ULTOA_CORE	;@0B0D4
RTL_ULTOA10:	push	bp	;@0B0D6
	mov	bp, sp	;@0B0D7
	push	si	;@0B0D9
	push	di	;@0B0DA
	push	ds	;@0B0DB
	les	ax, dword ptr [bp+0Ah]	;@0B0DC
	mov	dx, es	;@0B0DF
	les	di, dword ptr [bp+6]	;@0B0E1
	call	RTL_ULTOA_CORE	;@0B0E4
	pop	ds	;@0B0E7
	pop	di	;@0B0E8
	pop	si	;@0B0E9
	pop	bp	;@0B0EA
	retf	8	;@0B0EB
RTL_LTOA10:	push	bp	;@0B0EE
	mov	bp, sp	;@0B0EF
	push	si	;@0B0F1
	push	di	;@0B0F2
	push	ds	;@0B0F3
	les	ax, dword ptr [bp+0Ah]	;@0B0F4
	mov	dx, es	;@0B0F7
	les	di, dword ptr [bp+6]	;@0B0F9
	call	RTL_LTOA_CORE	;@0B0FC
	pop	ds	;@0B0FF
	pop	di	;@0B100
	pop	si	;@0B101
	pop	bp	;@0B102
	retf	8	;@0B103
RTL_UTOA10:	push	bp	;@0B106
	mov	bp, sp	;@0B107
	push	si	;@0B109
	push	di	;@0B10A
	push	ds	;@0B10B
	xor	dx, dx	;@0B10C
	les	di, dword ptr [bp+6]	;@0B10E
	mov	ax, word ptr [bp+0Ah]	;@0B111
	call	RTL_ULTOA_CORE	;@0B114
	pop	ds	;@0B117
	pop	di	;@0B118
	pop	si	;@0B119
	pop	bp	;@0B11A
	retf	6	;@0B11B
RTL_ITOA10:	push	bp	;@0B11E
	mov	bp, sp	;@0B11F
	push	si	;@0B121
	push	di	;@0B122
	push	ds	;@0B123
	les	di, dword ptr [bp+6]	;@0B124
	mov	ax, word ptr [bp+0Ah]	;@0B127
	cwd	;@0B12A
	call	RTL_LTOA_CORE	;@0B12B
	pop	ds	;@0B12E
	pop	di	;@0B12F
	pop	si	;@0B130
	pop	bp	;@0B131
	retf	6	;@0B132
RTL_MEMSET:	push	bp	;@0B135
	mov	bp, sp	;@0B136
	push	si	;@0B138
	push	di	;@0B139
	les	di, dword ptr [bp+0Ah]	;@0B13A
	mov	cx, word ptr [bp+6]	;@0B13D
	mov	al, byte ptr [bp+8]	;@0B140
	mov	ah, al	;@0B143
	cld	;@0B145
	test	di, 1	;@0B146
	db	74h, 4	; je L0B150	;@0B14A
	db	0E3h, 9	; jcxz L0B157	;@0B14C
	stosb	;@0B14E
	dec	cx	;@0B14F
Y0AEC0	ends

Y0B150	segment para public 'CODE'
	assume	cs:Y0B150
L0B150:	shr	cx, 1	;@0B150
	rep stosw	;@0B152
	jae	L0B157	;@0B154
	stosb	;@0B156
L0B157:	mov	dx, word ptr [bp+0Ch]	;@0B157
	mov	ax, word ptr [bp+0Ah]	;@0B15A
	pop	di	;@0B15D
	pop	si	;@0B15E
	pop	bp	;@0B15F
	retf	8	;@0B160
RTL_SEARCHPATH:	push	bp	;@0B163
	mov	bp, sp	;@0B164
	sub	sp, 8	;@0B166
	xor	ax, ax	;@0B169
	push	ax	;@0B16B
	push	word ptr [bp+8]	;@0B16C
	push	word ptr [bp+6]	;@0B16F
	db	9Ah, 0Ch, 0, 6Fh, 1	; lcall 0x16f, 0xc	;@0B172
	add	sp, 6	;@0B177
	cmp	ax, 0FFFFh	;@0B17A
	je	@@1	;@0B17D
	db	0E9h, 0E7h, 0	; jmp L0B269	;@0B17F
@@1:	push	ds	;@0B182
	mov	ax, 5CAEh	;@0B183
	push	ax	;@0B186
	db	9Ah, 8, 0, 0DFh, 1	; lcall 0x1df, 8	;@0B187
	mov	word ptr [bp-2], dx	;@0B18C
	mov	word ptr [bp-4], ax	;@0B18F
	or	ax, dx	;@0B192
	jne	@@2	;@0B194
	db	0E9h, 0CAh, 0	; jmp L0B263	;@0B196
@@2:	les	bx, dword ptr [bp-4]	;@0B199
	mov	word ptr [bp-6], es	;@0B19C
	mov	word ptr [bp-8], bx	;@0B19F
	jmp	short @@4	;@0B1A2
@@3:	inc	word ptr [bp-8]	;@0B1A4
@@4:	les	bx, dword ptr [bp-8]	;@0B1A7
	cmp	byte ptr es:[bx], 0	;@0B1AA
	je	@@5	;@0B1AE
	cmp	byte ptr es:[bx], 3Bh	;@0B1B0
	jne	@@3	;@0B1B4
@@5:	push	ds	;@0B1B6
	mov	ax, 8DEAh	;@0B1B7
	push	ax	;@0B1BA
	push	word ptr [bp-2]	;@0B1BB
	push	word ptr [bp-4]	;@0B1BE
	mov	ax, word ptr [bp-8]	;@0B1C1
	xor	dx, dx	;@0B1C4
	sub	ax, word ptr [bp-4]	;@0B1C6
	sbb	dx, 0	;@0B1C9
	push	ax	;@0B1CC
	db	9Ah, 3, 0, 0EFh, 2	; lcall 0x2ef, 3	;@0B1CD
	mov	ax, word ptr [bp-8]	;@0B1D2
	xor	dx, dx	;@0B1D5
	sub	ax, word ptr [bp-4]	;@0B1D7
	sbb	dx, 0	;@0B1DA
	mov	bx, ax	;@0B1DD
	mov	byte ptr [bx-7216h], 0	;@0B1DF
	les	bx, dword ptr [bp-8]	;@0B1E4
	inc	bx	;@0B1E7
	mov	word ptr [bp-2], es	;@0B1E8
	mov	word ptr [bp-4], bx	;@0B1EB
	push	ds	;@0B1EE
	mov	ax, 8DEAh	;@0B1EF
	push	ax	;@0B1F2
	db	9Ah, 4, 0, 5Fh, 2	; lcall 0x25f, 4	;@0B1F3
	mov	bx, ax	;@0B1F8
	add	bx, 8DE9h	;@0B1FA
	mov	ax, ds	;@0B1FE
	mov	es, ax	;@0B200
	mov	word ptr [bp-6], es	;@0B202
	mov	word ptr [bp-8], bx	;@0B205
	mov	ax, 8DEAh	;@0B208
	mov	dx, ds	;@0B20B
	cmp	ax, bx	;@0B20D
	db	73h, 21h	; jae L0B232	;@0B20F
	cmp	byte ptr es:[bx], 3Ah	;@0B211
	db	74h, 1Bh	; je L0B232	;@0B215
	cmp	byte ptr es:[bx], 2Fh	;@0B217
	db	74h, 15h	; je L0B232	;@0B21B
	cmp	byte ptr es:[bx], 5Ch	;@0B21D
	db	74h, 0Fh	; je L0B232	;@0B221
	push	ds	;@0B223
	mov	ax, 8DEAh	;@0B224
	push	ax	;@0B227
	push	ds	;@0B228
	mov	ax, 5CB3h	;@0B229
	push	ax	;@0B22C
	db	9Ah, 8, 0	; lcall 0x2ff, 8	;@0B22D
Y0B150	ends

Y0B230	segment para public 'CODE'
	assume	cs:Y0B230
	db	0FFh, 2	;@0B230
L0B232:	push	ds	;@0B232
	mov	ax, 8DEAh	;@0B233
	push	ax	;@0B236
	push	word ptr [bp+8]	;@0B237
	push	word ptr [bp+6]	;@0B23A
	db	9Ah, 8, 0, 0FFh, 2	; lcall 0x2ff, 8	;@0B23D
	xor	ax, ax	;@0B242
	push	ax	;@0B244
	push	ds	;@0B245
	mov	ax, 8DEAh	;@0B246
	push	ax	;@0B249
	db	9Ah, 0Ch, 0, 6Fh, 1	; lcall 0x16f, 0xc	;@0B24A
	add	sp, 6	;@0B24F
	cmp	ax, 0FFFFh	;@0B252
	db	75h, 22h	; jne L0B279	;@0B255
	les	bx, dword ptr [bp-4]	;@0B257
	cmp	byte ptr es:[bx], 0	;@0B25A
	db	74h, 3	; je L0B263	;@0B25E
Y0B230	ends

Y0B260	segment para public 'CODE'
	assume	cs:Y0B260
	db	0E9h, 36h, 0FFh	;@0B260
L0B263:	xor	dx, dx	;@0B263
	mov	ax, dx	;@0B265
	jmp	short L0B27E	;@0B267
L0B269:	push	ds	;@0B269
	mov	ax, 8DEAh	;@0B26A
	push	ax	;@0B26D
	push	word ptr [bp+8]	;@0B26E
	push	word ptr [bp+6]	;@0B271
	db	9Ah, 4, 0, 0DFh, 2	; lcall 0x2df, 4	;@0B274
L0B279:	mov	ax, 8DEAh	;@0B279
	mov	dx, ds	;@0B27C
L0B27E:	mov	sp, bp	;@0B27E
	pop	bp	;@0B280
	retf	4	;@0B281
STRING_COPY:	push	bp	;@0B284
	mov	bp, sp	;@0B285
	push	word ptr [bp+0Ch]	;@0B287
	push	word ptr [bp+0Ah]	;@0B28A
	push	word ptr [bp+8]	;@0B28D
	push	word ptr [bp+6]	;@0B290
	push	word ptr [bp+8]	;@0B293
	push	word ptr [bp+6]	;@0B296
	db	9Ah, 4, 0, 5Fh, 2	; lcall 0x25f, 4	;@0B299
	inc	ax	;@0B29E
	push	ax	;@0B29F
	db	9Ah, 3, 0, 0EFh, 2	; lcall 0x2ef, 3	;@0B2A0
	mov	dx, word ptr [bp+0Ch]	;@0B2A5
	mov	ax, word ptr [bp+0Ah]	;@0B2A8
	pop	bp	;@0B2AB
	retf	8	;@0B2AC
	db	55h, 8Bh, 0ECh, 56h, 57h, 8Bh, 7Eh, 6, 0FFh, 76h, 0Ah, 0FFh, 76h	;@0B2AF
	db	8, 9Ah, 4, 0, 5Fh, 2, 8Bh, 0F0h, 3Bh, 0F7h, 76h, 2, 8Bh, 0F7h
	db	0FFh, 76h, 0Eh, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 56h
	db	9Ah, 3, 0, 0EFh, 2, 3Bh, 0F7h, 73h, 17h, 8Bh, 56h, 0Eh, 8Bh, 46h
	db	0Ch, 3, 0C6h, 'RP3', 0C0h, 50h, 8Bh, 0C7h, 2Bh, 0C6h, 50h, 9Ah
	db	5, 0, 0BFh, 2, 8Bh, 56h, 0Eh, 8Bh, 46h, 0Ch, '_^]', 0CAh, 0Ah
	db	0
RTL_MEMMOVE:	push	bp	;@0B303
	mov	bp, sp	;@0B304
	push	si	;@0B306
	push	di	;@0B307
	push	ds	;@0B308
	mov	dx, word ptr [bp+0Ah]	;@0B309
	mov	ax, word ptr [bp+8]	;@0B30C
	cmp	dx, word ptr [bp+0Eh]	;@0B30F
	ja	@@2	;@0B312
	jb	@@1	;@0B314
	cmp	ax, word ptr [bp+0Ch]	;@0B316
	jae	@@2	;@0B319
@@1:	std	;@0B31B
	mov	ax, 1	;@0B31C
	jmp	short @@3	;@0B31F
@@2:	cld	;@0B321
	xor	ax, ax	;@0B322
@@3:	lds	si, dword ptr [bp+8]	;@0B324
	les	di, dword ptr [bp+0Ch]	;@0B327
	mov	cx, word ptr [bp+6]	;@0B32A
	or	ax, ax	;@0B32D
	je	@@4	;@0B32F
	add	si, cx	;@0B331
	dec	si	;@0B333
	add	di, cx	;@0B334
	dec	di	;@0B336
@@4:	test	di, 1	;@0B337
	je	@@5	;@0B33B
	jcxz	@@6	;@0B33D
	movsb	;@0B33F
	dec	cx	;@0B340
@@5:	sub	si, ax	;@0B341
	sub	di, ax	;@0B343
	shr	cx, 1	;@0B345
	rep movsw	;@0B347
	jae	@@6	;@0B349
	add	si, ax	;@0B34B
	add	di, ax	;@0B34D
	movsb	;@0B34F
@@6:	cld	;@0B350
	pop	ds	;@0B351
	pop	di	;@0B352
	pop	si	;@0B353
	pop	bp	;@0B354
	retf	0Ah	;@0B355
	db	55h, 8Bh, 0ECh, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 9Ah, 4, 0, 5Fh	;@0B358
	db	2, 8Bh, 4Eh, 0Ch, 8Bh, 5Eh, 0Ah, 3, 0D8h, 51h, 53h, 0FFh, 76h
	db	8, 0FFh, 76h, 6, 0FFh, 76h, 8, 0FFh, 76h, 6, 9Ah, 4, 0, 5Fh
Y0B260	ends

Y0B380	segment para public 'CODE'
	assume	cs:Y0B380
	db	2, 40h, 50h, 9Ah, 3, 0, 0EFh, 2, 8Bh, 56h, 0Ch, 8Bh, 46h, 0Ah	;@0B380
	db	5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 56h, 57h, 0FFh, 76h, 0Eh, 0FFh
	db	76h, 0Ch, 9Ah, 4, 0, 5Fh, 2, 8Bh, 0F8h, 0FFh, 76h, 0Ah, 0FFh, 76h
	db	8, 9Ah, 4, 0, 5Fh, 2, 8Bh, 0F0h, 3Bh, 76h, 6, 76h, 3, 8Bh, 76h
	db	6, 8Bh, 56h, 0Eh, 8Bh, 46h, 0Ch, 3, 0C7h, 52h, 50h, 0FFh, 76h
	db	0Ah, 0FFh, 76h, 8, 56h, 9Ah, 3, 0, 0EFh, 2, 8Bh, 0C7h, 3, 0C6h
	db	0C4h, 5Eh, 0Ch, 3, 0D8h, 26h, 0C6h, 7, 0, 8Bh, 56h, 0Eh, 8Bh, 46h
	db	0Ch, '_^]', 0CAh, 0Ah, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'VDISK', 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
Y0B380	ends

Y0B400	segment para public 'CODE'
	assume	cs:Y0B400
	db	10h dup (0)	;@0B400
OVR_EMS_FRAME_SEG:	add	byte ptr [bx+si], al	;@0B410
OVR_EMS_HANDLE	db	0FFh, 0FFh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@0B412
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0
Y0B400	ends

Y0B450	segment para public 'CODE'
	assume	cs:Y0B450
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@0B450
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0A0h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h
	db	0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h
	db	0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0
	db	0
Y0B450	ends

Y0B4F0	segment para public 'CODE'
	assume	cs:Y0B4F0
	db	0, 0, 0E9h, 4Eh, 3Fh, 0, 16h, 52h, 84h, 'Q6R', 16h, 'R-R', 0Eh	;@0B4F0
	db	50h, 0CFh, 4Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80h, 2, 1Fh
	db	0, 0Ch, 0, 8Fh, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0CDh, 3Fh, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'VDISK FAKE', 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2Eh, 0FFh, 2Eh, 2Fh, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1Fh, 0, 18h, 4, 1, 0, 0, 0, 2Fh
	db	0, 3Fh, 5, 1, 0, 8, 0, 3Fh, 0, 76h, 52h, 1, 0, 0Fh, 0, 4Fh, 0
	db	0E0h, 0, 1, 0, 6, 0, 5Fh, 0, 0DFh, 1, 1, 0, 0, 0, 6Fh, 0, 0D4h
	db	1, 1, 0, 0Fh, 0, 7Fh, 0, 5Bh, 1, 1, 0, 4, 0, 8Fh, 0, 0E6h, 17h
	db	1, 0, 0Bh, 0, 9Fh, 0, 0BDh, 1Fh, 1, 0, 6, 0, 0AFh, 0, 0A6h, 6
	db	1, 0, 0Dh, 0, 0BFh, 0, 78h, 0, 1, 0, 6, 0, 0CFh, 0, 0D8h, 1, 1
	db	0, 8, 0, 0DFh, 0, 0CEh, 1, 1, 0, 8, 0, 0EFh, 0, 8Ah, 0, 1, 0, 0Eh
	db	0
Y0B4F0	ends

Y0B6A0	segment para public 'CODE'
	assume	cs:Y0B6A0
	db	0FFh, 0, 2Bh, 1, 1, 0, 0Ah, 0, 0Fh, 1, 0B5h, 0, 1, 0, 0Bh, 0, 1Fh	;@0B6A0
	db	1, 61h, 0, 1, 0, 5, 0, 3Fh, 1, 0Dh, 0, 1, 0, 1, 0
Y0B6A0	ends
	end
