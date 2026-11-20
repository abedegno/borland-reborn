	.286p
	locals

Y00000	segment para public 'CODE'
	assume	cs:Y00000
	db	'$*$*$*', 0, 2Eh, 5, 3, 'TLINK', 0, 0D7h, 1, 0C6h, 6, 12h, 0, 0	;@00000
	db	0C6h, 6, 13h, 0, 1, 0C6h, 6, 16h, 0, 0, 0C6h, 6, 17h, 0, 0, 0C6h
	db	6, 34h, 0Ah, 0, 0C6h, 6, 27h, 1, 0, 0C6h, 6, 8, 0, 0, 0C6h, 6
	db	9, 0, 1, 33h, 0C0h, 0A3h, 72h, 52h, 0A3h, 88h, 1, 0A3h, 4Bh, 0Ah
	db	0A3h, 86h, 1, 0C6h, 6, 18h, 0, 1, 0C3h, 0E8h, 0C1h, 0FFh, 0C7h
	db	6, 41h, 0B4h, 40h, 93h, 0E8h, 0CBh, 96h, 0E8h, 83h, 95h, 14h, 'Turbo Link  Version '
	db	0E8h, 6Bh, 95h, 3, '4.0', 0E8h, 64h, 95h, ') Copyright (c) 1991 Borland International'
	db	0E8h, 0DDh, 94h, 0E8h, 8Bh, 96h, 0E8h, 38h, 0Ah, 80h, 3Eh, 2Bh
	db	1, 1, 75h, 16h, 80h, 3Eh, 26h, 1, 0, 74h, 0Fh, 0C6h, 6, 26h, 1
	db	0, 33h, 0C0h, 50h, 0B8h, 41h, 0, 50h, 0E8h, 0DFh, 0BAh, 0A0h, 26h
	db	1, 0A2h, 16h, 0, 0A2h, 17h, 0, 0A0h, 27h, 1, 98h, 0D1h, 0E0h, 0A3h
	db	1Ah, 0, 0D1h, 0E0h, 0A3h, 1Ch, 0, 80h, 3Eh, 2Ah, 1, 0, 75h, 5
	db	0C6h, 6, 2Ah, 1, 1, 33h, 0C0h, 80h, 3Eh, 2Ah, 1, 1, 74h, 1, 40h
	db	0A2h, 19h, 0, 0E8h, 0A2h, 90h, 0E8h
Y00000	ends

Y00100	segment para public 'CODE'
	assume	cs:Y00100
L00100	db	76h, 0, 0E8h, 2Ah, 0B8h, 80h, 3Eh, 2Bh, 1, 0, 75h, 5, 0C6h, 6	;@00100
	db	2Bh, 1, 2, 33h, 0C0h, 80h, 3Eh, 2Ah, 1, 2, 72h, 1, 40h, 0A2h, 19h
	db	0, 80h, 3Eh, 19h, 0, 1, 74h, 5, 0C6h, 6, 28h, 1, 0, 0E8h, 19h
	db	81h, 0C3h
L0012E:	cmp	word ptr ds:[1Eh], 1	;@0012E
	jne	@@1	;@00133
	db	9Ah, 0EDh, 1Ch, 0DFh, 0	; lcall 0xdf, 0x1ced	;@00135
@@1:	ret	;@0013A
	db	'Not enough memory', 0Dh, 0Ah, '$PSR', 1Eh, 2Eh, 8Eh, 1Eh, 10h	;@0013B
	db	0, 80h, 3Eh, 1Eh, 1, 0FFh, 75h, 13h, 8Bh, 1Eh, 24h, 0, 0E8h, 60h
	db	1, 0C7h, 6, 24h, 0, 0FFh, 0FFh, 0E8h, 0EFh, 8Eh, 0E8h, 0BCh, 0FFh
	db	1Fh, 'Z[X', 0F9h, 0CBh, 0A1h, 0Eh, 0, 5, 0Fh, 0, 0B1h, 4, 0D3h
	db	0E8h, 29h, 6, 6, 0, 16h, 1Fh, 0B8h, 0FFh, 0FFh, 50h, 0B8h, 0FFh
	db	0FFh, 50h, 9Ah, 3Bh, 2Eh, 0DFh, 0, 2Eh, 8Eh, 1Eh, 10h, 0, 8Bh
	db	0C2h, 0Bh, 0C0h, 'tEP', 0A1h, 4, 0, 48h, 50h, 0B8h, 80h, 0, 50h
	db	0Eh, 0B8h, 0A0h, 2, 50h, 33h, 0C0h, 50h, 50h, 9Ah, 62h, 1Ch, 0DFh
	db	0, 23h, 0C0h, 74h, 3, 0E9h, 0E1h, 0, 80h, 3Eh, 8, 0, 1, 75h, 9
	db	'PPPP', 9Ah, 33h, 29h, 0DFh, 0, 80h, 3Eh, 9, 0, 1, 75h, 8, 'PPP'
	db	9Ah, 0D6h, 27h, 0DFh, 0, 0C7h, 6, 1Eh, 0, 1, 0, 0C3h, 33h, 0C0h
	db	50h, 0B8h, 19h, 0, 50h, 0E8h, 0B2h, 0B9h
L001EF:	mov	ax, 1A7h	;@001EF
	mov	ds, ax	;@001F2
	mov	ax, word ptr es:[2Ch]	;@001F4
	mov	word ptr ds:[0], ax	;@001F8
	mov	ax, 1D7h	;@001FB
	mov	ds, ax	;@001FE
	xor	ax, ax	;@00200
	mov	byte ptr ds:[11Eh], al	;@00202
	mov	word ptr ds:[1Eh], ax	;@00205
	dec	ax	;@00208
	mov	word ptr ds:[134h], ax	;@00209
	mov	word ptr ds:[136h], ax	;@0020C
	push	ds	;@0020F
	push	cs	;@00210
	pop	ds	;@00211
	mov	dx, 14Fh	;@00212
	mov	ax, 2523h	;@00215
	int	21h	;@00218
	pop	ds	;@0021A
	mov	word ptr ds:[0], es	;@0021B
	mov	word ptr ds:[2], 80h	;@0021F
	mov	bx, word ptr es:[2]	;@00225
	ret	;@0022A
L0022B:	mov	word ptr ds:[0Eh], 0B8C0h	;@0022B
	mov	ax, word ptr ds:[0Eh]	;@00231
	add	ax, 4418h	;@00234
	mov	word ptr ds:[10h], ax	;@00237
	ret	;@0023A
L0023B:	push	ds	;@0023B
	pop	es	;@0023C
	mov	ax, 0FFFFh	;@0023D
	mov	di, 1Eh	;@00240
	mov	cx, 148h	;@00243
	sub	cx, di	;@00246
	shr	cx, 1	;@00248
	rep stosw	;@0024A
	mov	di, 148h	;@0024C
	mov	cx, 0A4Eh	;@0024F
	sub	cx, di	;@00252
	shr	cx, 1	;@00254
	rep stosw	;@00256
	mov	di, 5250h	;@00258
	mov	cx, 0B8C0h	;@0025B
	sub	cx, di	;@0025E
	shr	cx, 1	;@00260
	rep stosw	;@00262
	xor	ax, ax	;@00264
	mov	di, 290h	;@00266
	mov	cx, 3A8h	;@00269
	sub	cx, di	;@0026C
	shr	cx, 1	;@0026E
	rep stosw	;@00270
	ret	;@00272
L00273:	mov	bx, word ptr ds:[22h]	;@00273
	db	0E8h, 4Ch, 0	; call L002C6	;@00277
	mov	bx, word ptr ds:[24h]	;@0027A
	db	0E8h, 45h, 0	; call L002C6	;@0027E
	ret	;@00281
start:	cld	;@00282
	call	L001EF	;@00283
	call	L0022B	;@00286
	call	L0023B	;@00289
	db	0E8h, 0BFh, 0FDh	; call L1004E	;@0028C
	call	L00273	;@0028F
	call	L0012E	;@00292
	mov	al, byte ptr ds:[12h]	;@00295
	mov	ah, 4Ch	;@00298
	int	21h	;@0029A
	db	2Eh, 6Ch	; insb	;@0029C
L0029E:	db	69h, 62h, 2Eh, 8Eh, 1Eh	; imul sp, word ptr [bp+si+2Eh], 1E8Eh	;@0029E
	adc	byte ptr [bx+si], al	;@002A3
	call	L0552C	;@002A5
	xor	ax, ax	;@002A8
	push	ax	;@002AA
	mov	ax, 3	;@002AB
	push	ax	;@002AE
	db	0E8h, 0EFh, 0B8h	; call L0BBA1	;@002AF
L002B2:	push	bx	;@002B2
	int	21h	;@002B3
	pop	bx	;@002B5
	cld	;@002B6
	jb	@@1	;@002B7
	ret	;@002B9
@@1:	push	ax	;@002BA
	mov	cx, 2	;@002BB
	push	cx	;@002BE
	mov	ax, 4	;@002BF
	push	ax	;@002C2
	db	0E8h, 0DBh, 0B8h	; call L0BBA1	;@002C3
L002C6:	or	bx, bx	;@002C6
	je	@@1	;@002C8
	cmp	bx, -1	;@002CA
	je	@@1	;@002CD
	mov	ah, 3Eh	;@002CF
	call	L002B2	;@002D1
@@1:	ret	;@002D4
	db	80h, 0FCh, 40h, 75h, 0D8h, 0E8h, 0D5h, 0FFh, 3Bh, 0C1h, 74h, 0Ah	;@002D5
	db	33h, 0C9h, 51h, 0B8h, 2, 0, 50h, 0E8h, 0B6h, 0B8h, 0C3h, 'PQR'
	db	0CDh, '!ZY[', 0FCh, 72h, 1, 0C3h, 3Dh, 4, 0, 75h, 10h, 53h, 51h
	db	1Eh, 2Eh, 8Eh, 1Eh, 10h, 0, 0E8h, 71h, 8Eh, 1Fh, 'YXs', 0DFh, 1Eh
	db	52h, 0B8h, 4, 0, 50h, 0B8h, 1, 0, 50h, 0E8h, 87h, 0B8h, 53h, 51h
	db	0B4h, 4Eh, 33h, 0C9h, 0CDh, 21h, 72h, 0Fh, 0B4h, 2Fh, 0CDh, 21h
	db	26h, 8Bh, 47h, 1Ah, 26h, 8Bh, 57h, 1Ch, 59h, 5Bh, 0C3h, 33h, 0C0h
	db	99h, 0EBh, 0F8h, 0, 0, 0, 0, 0, 0, 0, 0, 80h, 3Eh, 1Ch, 1, 0FFh
	db	74h, 9, 0B0h, 0FFh, 86h, 6, 1Ch, 1, 8Ah, 0E0h, 0C3h, 'RQS', 0B0h
	db	2Ch, 80h, 3Eh, 18h, 1, 1, 74h, 53h, 8Bh, 1Eh, 20h, 0, 83h, 0FBh
	db	0FFh, 75h, 22h, 8Eh, 6, 0, 0, 8Bh, 1Eh, 2, 0, 26h, 8Ah, 0Fh, 2Ah
	db	0EDh, 8Bh, 1Eh, 50h, 1, 3Bh, 0D9h, 0B0h, ';w3&', 8Ah, 87h, 80h
	db	0, 0FFh, 6, 50h, 1, 0EBh, 28h, 0B4h, 3Fh, 0B9h, 1, 0, 0BAh, 1Ah
	db	1, 0CDh, 21h, 0FCh, 23h, 0C0h, 0A0h, 1Ah, 1, 75h, 16h, 0C7h, 6
	db	20h, 0, 0FFh, 0FFh, 0E8h, 24h, 0FFh, 80h, 3Eh, 5Ch, 1, 1, 75h
	db	4, 0FEh, 0Eh, 5Ch, 1, 0B0h, ' [YZ', 8Ah, 0E0h, '<Ar', 6, '<Zw'
	db	2, 4, 20h, 0C3h, 0E8h, 7Eh, 0FFh, ',0<', 9, 76h, 2, 2Ch, 27h, 0C3h
	db	0Ah, 0, 33h, 0DBh, 0E8h, 6Eh, 0FFh, '<0r4<9w0%', 0Fh, 0, 93h, 2Eh
	db	0F7h, 26h, 0CBh, 3, 72h, 25h, 3, 0D8h, 72h, 12h, 0E8h, 54h, 0FFh
	db	'<0r', 4, '<9v', 0E6h, 88h, 26h, 1Ch, 1, 0F8h, 0EBh, 17h, 0E8h
	db	42h, 0FFh, '<0r', 0Bh, '<9w', 7, 88h, 26h, 1Ch, 1, 0F9h, 0EBh
	db	5, 83h, 0FBh, 0, 75h, 0F4h, 0C3h, 53h, 0A0h, 59h, 1, 0A2h, 58h
	db	1, 0C6h, 6, 59h, 1, 0FFh, 0E8h, 1Eh, 0FFh, 83h, 3Eh, 54h, 1, 0
	db	75h, 6Bh, 83h, 3Eh, 56h, 1, 0, 'uA:', 6, 5Ah, 1, 75h, 5, 0B4h
	db	1, 0E9h, 19h, 1, 2Ah, 0FFh, 8Ah, 0D8h, 2Eh, 8Ah, 0A7h, 0DFh, 8
	db	80h, 0FCh, 0, 75h, 3, 0E9h, 36h, 3, 80h, 0FCh, 2, 73h, 3, 0E9h
	db	0B9h, 0, 76h, 3, 0E9h, 95h, 0, 0C6h, 6, 19h, 1, 0, '<.u', 3, 0E9h
	db	98h, 0, '<\u', 3, 0E9h, 99h, 0, 80h, 0FCh, 2, 5Bh, 0C3h, 88h, 26h
	db	1Ch, 1, 8Bh, 1Eh, 56h, 1, 80h, 0FFh, 0, 75h, 0Ch, 8Ah, 0C3h, 0B4h
	db	2, 0B7h, 1, 89h, 1Eh, 56h, 1, 0EBh, 0E2h, 0B4h, 1, 0C7h, 6, 56h
	db	1, 0, 0, 0EBh, 0D8h, 8Bh, 1Eh, 54h, 1, 80h, 0FFh, 0, 74h, 19h
	db	0C6h, 6, 1Dh, 1, 0, '<(u', 5, 0C6h, 6, 1Dh, 1, 1, 0A2h, 1Ch, 1
	db	8Ah, 0E7h, 0B7h, 0, 89h, 1Eh, 54h, 1, 8Ah, 0C4h, 2Ah, 0FFh, 8Ah
	db	0D8h, 2Eh, 8Ah, 0A7h, 0DFh, 8, 80h, 3Eh, 1Dh, 1, 1, 75h, 8, 0B4h
	db	1, '<)t', 10h, 0EBh, 0Ah, 80h, 0FCh, 1, 74h, 9, 80h, 0FCh, 3, 74h
	db	4, 0B4h, 2, 0EBh, 8Eh, '<+u', 3, 0A2h, 1Ch, 1, 0C7h, 6, 54h, 1
	db	0, 0, 0E9h, 7Eh, 0FFh, '<;t', 3, 0E9h, 77h, 0FFh, 0C6h, 6, 18h
	db	1, 1, 0E9h, 6Fh, 0FFh, 0C6h, 6, 1Bh, 1, 1, 0E9h, 67h, 0FFh, 0C6h
	db	6, 1Bh, 1, 0, 0E9h, 5Fh, 0FFh, '</tC<-u', 0Ch, 80h, 3Eh, 58h, 1
	db	1, 74h, 38h, 0B4h, 2, 0E9h, 38h, 0FFh, 0C6h, 6, 59h, 1, 1, '<+t"<'
	db	0Ah, 74h, 3, 0E9h, 3Bh, 0FFh, 80h, 3Eh, 5Ch, 1, 1, 75h, 3, 0E9h
	db	31h, 0FFh, 80h, 3Eh, 19h, 1, 1, 75h, 3, 0E9h, 27h, 0FFh, 0B0h
	db	2Ch, 0B4h, 3, 0E9h, 20h, 0FFh, 0C6h, 6, 19h, 1, 1, 0E9h, 18h, 0FFh
	db	0E8h, 0E9h, 0FDh, 50h, 0C6h, 6, 19h, 1, 0, 80h, 0FCh, 6Fh, 75h
	db	3, 0E9h, 8Ah, 2, 80h, 0FCh, 76h, 75h, 3, 0E9h, 1Fh, 2, 80h, 0FCh
	db	79h, 75h, 3, 0E9h, 0F1h, 1, 80h, 0FCh, 54h, 75h, 3, 0E9h, 51h
	db	1, 80h, 0FCh, 44h, 75h, 3, 0E9h, 0C0h, 1, 80h, 0FCh, 43h, 75h
	db	3, 0E9h, 2Bh, 2, 80h, 0FCh, 5Ah, 75h, 3, 0E9h, 43h, 2, 80h, 0FCh
	db	4Ch, 75h, 3, 0E9h, 0A9h, 2, 80h, 0FCh, 50h, 75h, 3, 0E9h, 0D3h
	db	2, 80h, 0FCh, 41h, 75h, 3, 0E9h, 0Eh, 3, 0E8h, 90h, 0FDh, 32h
	db	0FFh, 8Ah, 0D8h, 2Eh, 80h, 0BFh, 0DFh, 8, 2, 74h, 0F1h, 0A2h, 1Ch
	db	1, 59h, 33h, 0C0h, 0BBh, 1, 0, 80h, 0FDh, 6Dh, 75h, 3, 0E9h, 94h
	db	0, 80h, 0FDh, 'vtc', 80h, 0FDh, 'ctf', 80h, 0FDh, 'ith', 80h, 0FDh
	db	'ltj', 80h, 0FDh, 'xtl', 80h, 0FDh, 73h, 75h, 3, 0E9h, 7Eh, 0
	db	80h, 0FDh, 64h, 75h, 3, 0E9h, 85h, 0, 80h, 0FDh, 33h, 75h, 3, 0E9h
	db	84h, 0, 80h, 0FDh, 65h, 75h, 3, 0E9h, 83h, 0, 80h, 0FDh, 'nt#'
	db	80h, 0FDh, 74h, 75h, 3, 0E9h, 5, 1, 80h, 0FDh, 68h, 75h, 3, 0E9h
	db	0C1h, 2, 80h, 0FDh, 48h, 75h, 3, 0E9h, 0B9h, 2, 80h, 0FDh, 3Fh
	db	75h, 3, 0E9h, 0B1h, 2, 0E9h, 4Ah, 1, 88h, 1Eh, 25h, 1, 0E9h, 0DFh
	db	0FDh, 0C6h, 6, 26h, 1, 1, 0E9h, 0D7h, 0FDh, 88h, 1Eh, 22h, 1, 0E9h
	db	0D0h, 0FDh, 88h, 1Eh, 23h, 1, 0E9h, 0C9h, 0FDh, 88h, 1Eh, 21h
	db	1, 0E9h, 0C2h, 0FDh, 0A2h, 13h, 0, 0A2h, 21h, 1, 0A2h, 14h, 0
	db	0A2h, 15h, 0, 0E9h, 0B3h, 0FDh, 88h, 1Eh, 13h, 0, 88h, 1Eh, 14h
	db	0, 0E9h, 0A8h, 0FDh, 88h, 1Eh, 13h, 0, 88h, 1Eh, 14h, 0, 88h, 1Eh
	db	15h, 0, 0E9h, 99h, 0FDh, 88h, 1Eh, 24h, 1, 0E9h, 92h, 0FDh, 88h
	db	1Eh, 27h, 1, 0E9h, 8Bh, 0FDh, 88h, 1Eh, 54h, 2, 0E9h, 84h, 0FDh
	db	0E8h, 0ADh, 0FCh, '<+t', 8, '<-t', 0Ch, 88h, 26h, 1Ch, 1, 0C6h
	db	6, 8, 0, 1, 0E9h, 6Dh, 0FDh, 0C6h, 6, 8, 0, 0, 0E9h, 65h, 0FDh
	db	0E8h, 8Eh, 0FCh, '<+t', 8, '<-t', 0Ch, 88h, 26h, 1Ch, 1, 0C6h
	db	6, 9, 0, 1, 0E9h, 4Eh, 0FDh, 0C6h, 6, 9, 0, 0, 0E9h, 46h, 0FDh
	db	59h, 0BBh, 1, 0, 0E8h, 6Bh, 0FCh, '<dt', 0Fh, '<wt', 12h, '<ot'
	db	15h, '<pt', 18h, 0E9h, 90h, 0, 0C6h, 6, 2Ah, 1, 1, 0EBh, 13h, 0C6h
	db	6, 2Ah, 1, 2, 0EBh, 0Ch, 0C6h, 6, 2Ah, 1, 3, 0EBh, 5, 0C6h, 6
	db	2Ah, 1, 4, 0E8h, 3Bh, 0FCh, '<ct', 0Fh, '<et <dt$', 88h, 26h, 1Ch
	db	1, 0E9h, 0FCh, 0FCh, 0C6h, 6, 2Ah, 1, 1, 0C6h, 6, 2Bh, 1, 1, 0B8h
	db	63h, 6Fh, 0B3h, 6Dh, 0E8h, 0Bh, 8Ch, 0E9h, 0E7h, 0FCh, 0C6h, 6
	db	2Bh, 1, 2, 0E9h, 0DFh, 0FCh, 0C6h, 6, 2Bh, 1, 3, 0B8h, 64h, 6Ch
	db	0B3h, 6Ch, 0E8h, 0F3h, 8Bh, 0E9h, 0CFh, 0FCh, 59h, 0BBh, 1, 0
	db	0E8h, 0F4h, 0FBh, '<+t', 8, '<-t', 0Bh, 88h, 26h, 1Ch, 1, 88h
	db	1Eh, 18h, 0, 0E9h, 0B5h, 0FCh, 88h, 3Eh, 18h, 0, 0E9h, 0AEh, 0FCh
	db	59h, 0E8h, 0D6h, 0FBh, '<xu', 3, 0E9h, 1Fh, 0FFh, '<eu', 3, 0E9h
	db	37h, 0FFh, 33h, 0C0h, 50h, 0B8h, 1Ah, 0, 50h, 0E8h, 1Fh, 0B4h
	db	33h, 0C0h, 50h, 0B8h, 1Bh, 0, 50h, 0E8h, 15h, 0B4h, 0E8h, 0B1h
	db	0FBh, '<-t', 10h, '<+t', 7, 88h, 26h, 1Ch, 1, 0E9h, 0Fh, 0FEh
	db	0BBh, 3, 0, 0EBh, 3, 0BBh, 4, 0, 80h, 3Eh, 5Bh, 1, 1, 74h, 4, 59h
	db	0E9h, 63h, 0FCh, 89h, 1Eh, 56h, 1, 59h, 0EBh, 66h, 59h, 0E8h, 84h
	db	0FBh, '<-t', 10h, '<+t', 4, 88h, 26h, 1Ch, 1, 0C6h, 6, 29h, 1
	db	1, 0E9h, 44h, 0FCh, 0C6h, 6, 29h, 1, 0, 0E9h, 3Ch, 0FCh, 59h, 0E8h
	db	64h, 0FBh, '<2t', 7, 88h, 26h, 1Ch, 1, 0E9h, 2Dh, 0FCh, 0C6h, 6
	db	2Fh, 1, 1, 0E9h, 25h, 0FCh, 59h, 0E8h, 4Dh, 0FBh, '<#t7', 80h
	db	3Eh, 5Bh, 1, 1, 75h, 8, '<-u', 0Bh, 0B7h, 2, 0EBh, 12h, 88h, 26h
	db	1Ch, 1, 0E9h, 7, 0FCh, 80h, 0Eh, 34h, 0Ah, 1, 0B7h, 1, 88h, 26h
	db	1Ch, 1, 0B3h, 1, 89h, 1Eh, 54h, 1, 0B0h, 0FFh, 0B4h, 2, 0FEh, 0Eh
	db	53h, 1, 0C6h, 6, 1Bh, 1, 1, 0E9h, 3Eh, 0FCh, 0E8h, 8Eh, 0FBh, 0B1h
	db	4, 0D3h, 0E0h, 8Ah, 0D8h, 0E8h, 85h, 0FBh, 2, 0C3h, 8Ah, 0E0h
	db	0B0h, 0CDh, 0A3h, 7Ch, 4, 0E9h, 0CEh, 0FBh, 59h, 0B9h, 80h, 0
	db	8Bh, 0C1h, 0E8h, 0B6h, 89h, 89h, 3Eh, 42h, 1, 49h, 1Eh, 7, 0E8h
	db	0E7h, 0FAh, 1Eh, 7, 33h, 0DBh, 8Ah, 0D8h, 2Eh, 80h, 0BFh, 0DFh
	db	8, 1, 74h, 3, 0AAh, 0E2h, 0ECh, 88h, 26h, 1Ch, 1, 33h, 0C0h, 0AAh
	db	89h, 3Eh, 0Eh, 0, 0E9h, 9Ch, 0FBh, 59h, 0E8h, 0C4h, 0FAh, '<-t'
	db	10h, '<=t', 14h, 88h, 26h, 1Ch, 1, 0C6h, 6, 28h, 1, 1, 0E9h, 84h
	db	0FBh, 0C6h, 6, 28h, 1, 0, 0E9h, 7Ch, 0FBh, 0E8h, 32h, 0FBh, 72h
	db	0Ch, 89h, 1Eh, 44h, 1, 0C6h, 6, 28h, 1, 1, 0E9h, 6Bh, 0FBh, 33h
	db	0C0h, 50h, 0B8h, 2Bh, 0, 50h, 0E8h, 0F3h, 0B2h, 0C6h, 6, 28h, 1
	db	0, 0E9h, 59h, 0FBh, 59h, 0E8h, 81h, 0FAh, '<=u', 0Ch, 0E8h, 7
	db	0FBh, 72h, 7, 89h, 1Eh, 46h, 1, 0E9h, 45h, 0FBh, 33h, 0C0h, 50h
	db	0B8h, 2Dh, 0, 50h, 0E8h, 0CDh, 0B2h, 0E9h, 38h, 0FBh, 0E9h, 0C3h
	db	2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 2, 0, 2, 2, 2, 2, 2, 2
	db	2, 0, 1, 3, 1, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 0, 0
	db	0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 0, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0
	db	2, 2, 0, 'tlink.cfg', 0, 55h, 8Bh, 0ECh, 81h, 0ECh, 8Ah, 0, 89h
	db	5Eh, 0FEh, 89h, 76h, 0FCh, 0C6h, 46h, 0F8h, 0, 89h, 7Eh, 0FAh
	db	0C6h, 6, 53h, 1, 0, 80h, 3Eh, 5Ch, 1, 0FFh, 74h, 3, 0E9h, 8Ch
	db	0, 0Eh, 0B8h, 5Fh, 9, 50h, 0E8h, 92h, 8Ah, 72h, 12h, 16h, 8Dh
	db	86h, 76h, 0FFh, 50h, 0Eh, 0B8h, 5Fh, 9, 50h, 9Ah, 0Ah, 0, 0AFh
	db	0, 0EBh, 50h, 0B4h, 30h, 0CDh, 21h, 3Ch, 3, 72h, 68h, 0E8h, 0DEh
	db	89h, 72h, 63h, 16h, 8Dh, 8Eh, 76h, 0FFh, 51h, 16h, 'QRP', 9Ah
	db	0Ah, 0, 0AFh, 0, 9Ah, 9, 0, 7Fh, 0, 16h, 7, 8Dh, 0BEh, 76h, 0FFh
	db	3, 0F8h, 8Bh, 0C8h, 0B0h, 5Ch, 0FDh, 0F2h, 0AEh, 0FCh, 75h, 3Dh
	db	83h, 0C7h, 2, 1Eh, 0Eh, 1Fh, 0BEh, 5Fh, 9, 0B9h, 0Ah, 0, 0F3h
	db	0A4h, 33h, 0C0h, 0AAh, 1Fh, 16h, 8Dh, 86h, 76h, 0FFh, 50h, 0E8h
	db	30h, 8Ah, 72h, 20h, 0C6h, 6, 5Ch, 1, 1, 1Eh, 16h, 1Fh, 8Dh, 96h
	db	76h, 0FFh, 0B8h, 0, 3Dh, 0E8h, 0E2h, 0F8h, 1Fh, 0A3h, 20h, 0, 0C6h
	db	6, 18h, 1, 0, 0C6h, 6, 59h, 1, 1, 0C6h, 6, 1Bh, 1, 0, 0E8h, 0F3h
	db	0F9h, 72h, 0FBh, 9Fh, 74h, 9, 83h, 7Eh, 0FEh, 0, 75h, 3, 0E9h
	db	0B2h, 0, 50h, 0B8h, 64h, 0, 0E8h, 0D0h, 87h, 58h, 1Eh, 7, 8Bh
	db	0DFh, '<@t', 0Fh, 8Bh, 5Eh, 0FAh, 89h, 3Fh, 89h, 7Eh, 0FAh, 50h
	db	33h, 0C0h, 0ABh, 58h, 8Bh, 0DFh, 9Eh, 74h, 2Ch, 8Bh, 76h, 0FEh
	db	80h, 7Ch, 2, 0FFh, 75h, 6, 8Bh, 34h, 0Bh, 0F6h, 75h, 0F4h, 46h
	db	46h, 0ACh, 0AAh, '<.u', 0FAh, 80h, '<.t', 0F5h, 80h, '<\t', 0F0h
	db	89h, 3Eh, 0Eh, 0, 0C7h, 46h, 0FEh, 0, 0, 0EBh, 40h, 0C7h, 46h
	db	0FEh, 0, 0, 0AAh, 6, 0E8h, 8Dh, 0F9h, 7, 74h, 0F8h, 32h, 0C0h
	db	0AAh, 80h, '?@u$', 83h, 3Eh, 20h, 0, 0FFh, 75h, 1Dh, 89h, 1Eh
	db	0Eh, 0, 8Dh, 57h, 1, 0B8h, 0, 3Dh, 0E8h, 47h, 0F8h, 0A3h, 20h
	db	0, 0C6h, 6, 18h, 1, 0, 0B0h, 1, 0A2h, 59h, 1, 0E9h, 63h, 0FFh
	db	80h, 3Eh, 1Bh, 1, 1, 74h, 14h, 4Fh, 0B9h, 4, 0, 8Bh, 76h, 0FCh
	db	1Eh, 0Eh, 1Fh, 0F3h, 0A4h, 1Fh, 32h, 0C0h, 0AAh, 0C6h, 46h, 0F8h
	db	1, 0FEh, 6, 53h, 1, 89h, 3Eh, 0Eh, 0, 80h, 0FCh, 2, 73h, 3, 0E9h
	db	38h, 0FFh, 8Ah, 5Eh, 0F8h, 8Bh, 0E5h, 5Dh, 0C3h, 0BFh, 20h, 1
	db	0B9h, 28h, 0, 33h, 0C0h, 1Eh, 7, 0F3h, 0AAh, 0C6h, 6, 28h, 1, 1
	db	0C7h, 6, 44h, 1, 0, 20h, 0C7h, 6, 46h, 1, 0, 2, 0C7h, 6, 34h, 1
	db	10h, 0, 0C7h, 6, 36h, 1, 1Fh, 0, 0E8h, 7, 87h, 0A2h, 5Ah, 1, 33h
	db	0C0h, 0A3h, 54h, 1, 0A3h, 56h, 1, 0A2h, 18h, 1, 48h, 0A2h, 58h
	db	1, 0A2h, 59h, 1, 0C7h, 6, 50h, 1, 1, 0, 0C6h, 6, 5Bh, 1, 1, 0BEh
	db	6Bh, 10h, 0BFh, 38h, 1, 33h, 0DBh, 0E8h, 2Bh, 0FEh, 80h, 3Eh, 53h
	db	1, 0, 74h, 5Dh, 0C6h, 6, 5Bh, 1, 0, 0BEh, 83h, 10h, 80h, 3Eh, 2Bh
	db	1, 1, 74h, 0Dh, 0BEh, 73h, 10h, 80h, 3Eh, 2Bh, 1, 3, 74h, 3, 0BEh
	db	6Fh, 10h, 0BFh, 3Ah, 1, 8Bh, 1Eh, 38h, 1, 0E8h, 0FEh, 0FDh, 88h
	db	1Eh, 1Fh, 1, 0C6h, 6, 52h, 1, 1, 0BEh, 77h, 10h, 0BFh, 3Ch, 1
	db	8Bh, 1Eh, 3Ah, 1, 0E8h, 0E8h, 0FDh, 0C6h, 6, 5Bh, 1, 1, 0BEh, 7Bh
	db	10h, 0BFh, 3Eh, 1, 33h, 0DBh, 0E8h, 0D8h, 0FDh, 0C6h, 6, 5Bh, 1
	db	0, 0BEh, 7Fh, 10h, 0BFh, 40h, 1, 33h, 0DBh, 0E8h, 0C8h, 0FDh, 0C3h
	db	0E8h, 80h, 8Bh, 0E8h, 38h, 8Ah, ';Syntax: TLINK objfiles, exefile, mapfile, libfile'
	db	's, deffile', 0E8h, 9Fh, 89h, 0E8h, 0F6h, 89h, '&@xxxx indicates use response file xxxx'
	db	0E8h, 72h, 89h, 0E8h, 0C9h, 89h, '#Options: /m = map file with publics'
	db	0E8h, 48h, 89h, 0E8h, 9Fh, 89h, '          /x = no map file at all'
	db	0E8h, 21h, 89h, 0E8h, 78h, 89h, '%         /i = initialize all segments'
	db	0E8h, 0F5h, 88h, 0E8h, 4Ch, 89h, ')         /l = include source line numbers'
	db	0E8h, 0C5h, 88h, 0E8h, 1Ch, 89h, '*         /L = specify library search paths'
	db	0E8h, 94h, 88h, 0E8h, 0EBh, 88h, '&         /s = detailed map of segments'
	db	0E8h, 67h, 88h, 0E8h, 0BEh, 88h, '"         /n = no default libraries'
	db	0E8h, 3Eh, 88h, 0E8h, 95h, 88h, '4         /d = warn if duplicate symbols in librar'
	db	'ies', 0E8h, 3, 88h, 0E8h, 5Ah, 88h, '/         /c = lower case significant in symbols'
	db	0E8h, 0CDh, 87h, 0E8h, 24h, 88h, '&         /3 = enable 32-bit processing'
	db	0E8h, 0A0h, 87h, 0E8h, 0F7h, 87h, '5         /v = include full symbolic debug informa'
	db	'tion', 0E8h, 64h, 87h, 0E8h, 0BBh, 87h, '(         /e = ignore Extended Dictionary'
	db	0E8h, 35h, 87h, 0E8h, 8Ch, 87h, '+         /t = create COM file (same as /Tc)'
	db	0E8h, 3, 87h, 0E8h, 5Ah, 87h, 1Ch, '         /o = overlay switch'
	db	0E8h, 0E0h, 86h, 0E8h, 37h, 87h, '(         /P[=NNNNN] = pack code segments'
	db	0E8h, 0B1h, 86h, 0E8h, 8, 87h, '6         /A=NNNN = set NewExe segment alignment f'
	db	'actor', 0E8h, 74h, 86h, 0E8h, 0CBh, 86h, 27h, '         /ye = expanded memory swapping'
	db	0E8h, 46h, 86h, 0E8h, 9Dh, 86h, 27h, '         /yx = extended memory swapping'
	db	0E8h, 18h, 86h, 0E8h, 6Fh, 86h, '1         /C  = case sensitive exports and imports'
	db	0E8h, 0E0h, 85h, 0E8h, 37h, 86h, '(         /Txx = specify output file type'
	db	0E8h, 0B1h, 85h, 0E8h, 8, 86h, 22h, 9, '       /Tdx = DOS image (default)'
	db	0E8h, 88h, 85h, 0E8h, 0DFh, 85h, 1Ch, 9, '       /Twx = Windows image'
	db	0E8h, 65h, 85h, 0E8h, 0BCh, 85h, '9                (third letter can be c=COM, e=EXE'
	db	', d=DLL)', 0E8h, 25h, 85h, 89h, 3Eh, 41h, 0B4h, 0E8h, 0CFh, 86h
	db	0E8h, 0A5h, 'u.obj.exe.dll.map.lib.def.com', 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 80h, 3Eh, 0D2h, 3, 2, 't/+', 0DBh, 2, 1Ch, 7Dh, 8, 46h
	db	80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 83h, 0FBh, 18h, 72h
	db	4, 3, 1Eh, 8Fh, 3, 8Bh, 3Eh, 74h, 1, 57h, 83h, 0E7h, 3, 0D1h, 0E7h
	db	0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 18h, 7, 5Fh, 26h, 89h, 5Dh, 0FAh
	db	0C3h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 46h, 83h, 0FBh, 18h, 72h, 4, 3, 1Eh, 8Fh, 3, 8Bh, 3Eh
	db	76h, 1, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h
	db	8Eh, 85h, 58h, 7, 5Fh, 26h, 89h, 5Dh, 10h, 0ACh, 26h, 8, 45h, 0Fh
	db	0C3h, 90h, 90h, 0E8h, 9Ch, 'u;6', 0E0h, 3, 72h, 8, 75h, 0F3h, 0C3h
	db	83h, 0C6h, 4, 0EBh, 0F2h, 0FFh, 45h, 1Ah, 0ACh, '<@t', 0F3h, 3Ch
	db	0C0h, 74h, 0EFh, 0ACh, 98h, 3, 0F0h, 80h, 3Ch, 80h, 83h, 0DEh
	db	0FEh, 0EBh, 0DAh, 1, 1, 1, 1, 2, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1
	db	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1
	db	1, 1, 1, 1, 1, 2, 1, 1, 0, 2, 1, 0, 2, 0, 0, 2, 1, 1, 80h, 3Ch
	db	80h, 83h, 0DEh, 0FEh, 0ACh, 98h, 3, 0F0h, 0ADh, 0ACh, 0BBh, 27h
	db	11h, 2Eh, 0D7h, 98h, 1, 45h, 18h, 1, 6, 92h, 4, 72h, 1, 0C3h, 33h
	db	0C0h, 50h, 0B8h, 1Fh, 0, 50h, 0E8h, 23h, 0AAh, 80h, 0Eh, 10h, 4
	db	4, 0EBh, 0EEh, 3Bh, 36h, 0E0h, 3, 72h, 6, 74h, 3, 0E9h, 68h, 0FFh
	db	0C3h, 0FFh, 45h, 1Ah, 0ACh, 0ACh, 98h, 3, 0F0h, 0ADh, 0EBh, 0E9h
	db	50h, 53h, 81h, 0EBh, 1, 40h, 0D1h, 0E3h, 3, 1Eh, 2Eh, 5, 8Bh, 3Eh
	db	32h, 5, 3Bh, 3Eh, 0AEh, 7, 73h, 0Eh, 8Eh, 6, 0B0h, 7, 26h, 39h
	db	1Dh, 74h, 20h, 83h, 0C7h, 11h, 0EBh, 0ECh, 0BFh, 11h, 0, 57h, 0BFh
	db	0ACh, 7, 0E8h, 0EEh, 42h, 73h, 3, 0E8h, 0DCh, 42h, 57h, 0B9h, 11h
	db	0, 33h, 0C0h, 0F3h, 0AAh, 5Fh, 26h, 89h, 1Dh, 5Bh, 58h, 0C3h, 0FFh
	db	6, 78h, 1, 0A1h, 78h, 1, 3Bh, 6, 8Ah, 4, 76h, 3, 0A3h, 8Ah, 4
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah
	db	1Ch, 46h, 81h, 0FBh, 0, 40h, 7Fh, 1Fh, 0FFh, 45h, 20h, 0E8h, 9Fh
	db	8, 0C7h, 6, 82h, 1, 0FFh, 0FFh, 0A1h, 67h, 3, 3Bh, 6, 8Eh, 4, 76h
	db	3, 0A3h, 8Eh, 4, 0C7h, 6, 67h, 3, 0, 0, 0C3h, 0E8h, 77h, 0FFh
	db	89h, 1Eh, 82h, 1, 26h, 0FFh, 45h, 8, 0EBh, 0E0h, 3Bh, 36h, 0E0h
	db	3, 72h, 6, 74h, 3, 0E9h, 0BFh, 0FEh, 0C3h, 0ACh, 98h, 3, 0F0h
	db	80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 0ACh, 24h, 7, 2Eh, 0D7h, 0A8h
	db	80h, 74h, 14h, 0FFh, 6, 67h, 3, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh
	db	3Ch, 90h, 72h, 6, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 53h, 83h, 3Eh
	db	78h, 1, 0, 74h, 14h, 8Bh, 1Eh, 82h, 1, 83h, 0FBh, 0FFh, 74h, 0Bh
	db	57h, 0E8h, 25h, 0FFh, 26h, 0FFh, 45h, 6, 5Fh, 0EBh, 3, 0FFh, 45h
	db	1Ch, 5Bh, 25h, 7, 0, 3, 0F0h, 0EBh, 0A6h, 92h, 82h, 2, 2, 1, 4
	db	0, 0, 0BBh, 8Eh, 12h, 0E8h, 98h, 0FFh, 0C3h, 0FFh, 0Eh, 78h, 1
	db	0E9h, 70h, 0FFh, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h
	db	8Ah, 0FBh, 8Ah, 1Ch, 46h, 23h, 0DBh, 75h, 3, 0FFh, 45h, 24h, 0C7h
	db	6, 9Bh, 3, 1, 0, 0C7h, 6, 7Ah, 1, 0FFh, 0FFh, 0C3h, 0C3h, 0ADh
	db	88h, 45h, 30h, 88h, 65h, 31h, 0C3h, 80h, 3Eh, 0D2h, 3, 2, 74h
	db	23h, 0B4h, 0, 0E8h, 3Ah, 7Bh, 8Bh, 0FBh, 2Bh, 0DBh, 2, 1Ch, 7Dh
	db	8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 83h, 0FBh, 18h
	db	72h, 4, 3, 1Eh, 8Fh, 3, 26h, 89h, 5Dh, 0FAh, 0C3h, 0B4h, 0, 0E8h
	db	16h, 7Bh, 26h, 8Bh, 3Fh, 83h, 0FFh, 0FFh, 't0W', 83h, 0E7h, 3
	db	0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 2Bh
	db	0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch
	db	46h, 83h, 0FBh, 18h, 72h, 4, 3, 1Eh, 8Fh, 3, 26h, 89h, 5Dh, 10h
	db	0ACh, 26h, 8, 45h, 0Fh, 0C3h, 0ACh, 22h, 0C0h, 74h, 0Fh, 0ACh
	db	98h, 22h, 0C0h, 79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 1, 45h, 2Ch
	db	0C3h, 0A1h, 78h, 1, 9, 6, 0A8h, 3, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh
	db	83h, 0C6h, 3, 0ACh, 98h, 22h, 0C0h, 79h, 5, 2Ch, 80h, 8Ah, 0E0h
	db	0ACh, 1, 45h, 2Eh, 0FFh, 45h, 2Ah, 0C3h, 0B4h, 0, 0E8h, 0A2h, 7Ah
	db	0C3h, 80h, 3Eh, 2Fh, 1, 1, 74h, 27h, 57h, 2Bh, 0DBh, 2, 1Ch, 7Dh
	db	8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 81h, 0FBh, 0
	db	40h, 7Fh, 16h, 0E8h, 18h, 7, 0A1h, 0E0h, 3, 2Bh, 0C6h, 0D1h, 0E8h
	db	5Fh, 1, 45h, 32h, 0FFh, 45h, 34h, 8Bh, 36h, 0E0h, 3, 0C3h, 83h
	db	0C4h, 2, 0E8h, 0F3h, 0FDh, 0A1h, 0E0h, 3, 2Bh, 0C6h, 0D1h, 0E8h
	db	26h, 1, 45h, 0Ch, 26h, 0FFh, 45h, 0Eh, 0EBh, 0E4h, 90h, 10h, 0C7h
	db	10h, 1, 11h, 5Dh, 11h, 8Ah, 11h, 0E3h, 11h, 96h, 12h, 9Dh, 12h
	db	0A4h, 12h, 0C7h, 12h, 0C8h, 12h, 0D0h, 12h, 0FBh, 12h, 39h, 13h
	db	75h, 13h, 0C7h, 12h, 0C7h, 12h, 0C7h, 12h, 0C7h, 12h, 0C7h, 12h
	db	0C7h, 12h, 0C7h, 12h, 0C7h, 12h, 0C7h, 12h, 6Fh, 13h, 0BEh, 8Ah
	db	1, 8Bh, 0Eh, 50h, 5, 8Bh, 3Eh, 2Ch, 5, 8Eh, 6, 80h, 7, 8Bh, 16h
	db	76h, 7, 0B8h, 1, 0, 85h, 4, 74h, 5, 26h, 0C6h, 45h, 9, 1, 0D1h
	db	0E0h, 72h, 8, 83h, 0C7h, 0Ah, 3Bh, 0FAh, 72h, 0ECh, 0C3h, 0D1h
	db	0D0h, 46h, 46h, 0EBh, 0F2h, 8Ah, 4, 4, 2, 83h, 0EEh, 2, 88h, 4
	db	0A1h, 86h, 1, 89h, 44h, 1, 0C3h, 80h, 3Eh, 94h, 4, 0, 74h, 7, 8Bh
	db	36h, 0E0h, 3, 0E9h, 91h, 43h, 0FEh, 0Eh, 94h, 4, 0C7h, 6, 64h
	db	1, 0, 0, 0C7h, 6, 66h, 1, 0, 0, 0C7h, 6, 8Eh, 7, 0, 0, 0B4h, 40h
	db	80h, 3Eh, 0D2h, 3, 1, 73h, 65h, 0C7h, 6, 36h, 5, 0, 0, 81h, 3Ch
	db	1, 'AuqPQVW', 0C7h, 6, 0BCh, 2, 1, 41h, 1Eh, 7, 0BBh, 0BBh, 92h
	db	8Bh, 0F3h, 80h, '?:t', 0Ah, 80h, '?\t', 5, 80h, '?/u', 3, 8Dh
	db	77h, 1, 80h, 3Fh, 0, 74h, 3, 43h, 0EBh, 0E6h, 8Bh, 0CBh, 2Bh, 0CEh
	db	74h, 17h, 4Bh, 3Bh, 0DEh, 72h, 9, 80h, '?.u', 0F6h, 8Bh, 0CBh
	db	2Bh, 0CEh, 0BFh, 0BCh, 2, 0FCh, 8Ah, 0C1h, 0AAh, 0F3h, 0A4h, 6
	db	1Fh, 0BEh, 0BCh, 2, 0E8h, '[y_^YX', 83h, 0C6h, 2, 0EBh, 1Bh, 8Bh
	db	0C6h, 2Dh, 53h, 12h, 1Bh, 0D2h, 3, 6, 68h, 52h, 13h, 16h, 6Ah
	db	52h, 0F7h, '6bR', 0A3h, 36h, 5, 0B4h, 40h, 0E8h, 37h, 79h, 1Eh
	db	7, 0BFh, 2Ah, 5, 8Bh, 0C3h, 0ABh, 0A1h, 76h, 7, 0ABh, 0A1h, 86h
	db	7, 0ABh, 0A1h, 96h, 7, 0ABh, 0A1h, 0AEh, 7, 0ABh, 33h, 0C0h, 80h
	db	3Eh, 0D2h, 3, 2, 75h, 1, 40h, 0ABh, 'GG3', 0C0h, 0B9h, 2Ah, 0
	db	0F3h, 0AAh, 0A3h, 78h, 1, 0BFh, 8Ah, 1, 0B9h, 40h, 0, 0F3h, 0ABh
	db	0C7h, 6, 7Ah, 1, 0FFh, 0FFh, 0C7h, 6, 9Bh, 3, 0FFh, 0FFh, 0C7h
	db	6, 67h, 3, 0, 0, 0C7h, 6, 0A8h, 3, 0, 0, 0E9h, 0A0h, 42h, 0ADh
	db	80h, 3Eh, 0D4h, 3, 0, 75h, 12h, 80h, 3Eh, 19h, 0, 0, 74h, 0Bh
	db	80h, 0FCh, 0A0h, 75h, 6, 0E8h, 58h, 82h, 0E9h, 1, 1, 0BAh, 9Ch
	db	2, 0Ah, 0E4h, 74h, 4Dh, 80h, 0FCh, 0A1h, 74h, 4Bh, 80h, 0FCh, 9Fh
	db	'tN3', 0D2h, 80h, 0FCh, 0B4h, 74h, 47h, 80h, 3Eh, 18h, 0, 1, 75h
	db	5, 80h, 0FCh, 9Eh, 74h, 28h, 80h, 3Eh, 17h, 0, 0, 74h, 1Eh, 8Ah
	db	0DCh, 32h, 0FFh, 81h, 0EBh, 0E0h, 0, 7Ch, 14h, 83h, 0FBh, 19h
	db	73h, 0Fh, 0BFh, 2Ah, 5, 0D1h, 0E3h, 2Eh, 0FFh, 97h, 0BFh, 13h
	db	0C6h, 6, 3Ah, 5, 4, 0E9h, 0B5h, 0, 0C6h, 6, 0D7h, 3, 1, 0E9h, 0ADh
	db	0, 0E9h, 0AAh, 0, 80h, 0Eh, 3Fh, 5, 1, 0E9h, 0A2h, 0, 80h, 3Eh
	db	25h, 1, 1, 74h, 0E3h, 83h, 3Eh, 7Ch, 1, 0, 74h, 0DCh, 8Bh, 3Eh
	db	80h, 1, 1Eh, 7, 47h, 47h, 8Bh, 0Eh, 0E0h, 3, 2Bh, 0CEh, 32h, 0DBh
	db	0ACh, '<Ar', 6, '<Zw', 2, 4, ' ;>~', 1, 73h, 73h, 0AAh, '<\t'
	db	10h, '<:t', 0Ch, '</t', 8, '<.u', 6, 0B3h, 1, 0EBh, 2, 32h, 0DBh
	db	0E2h, 0D6h, 23h, 0D2h, 74h, 15h, 22h, 0DBh, 75h, 11h, 8Dh, 45h
	db	4, 3Bh, 6, 7Eh, 1, 73h, 49h, 8Bh, 0F2h, 1Eh, 0Eh, 1Fh, 0A5h, 0A5h
	db	1Fh, ';>~', 1, 's;*', 0C0h, 0AAh, 8Bh, 0CFh, 8Bh, 3Eh, 80h, 1
	db	'GG+', 0CFh, 1Eh, 0BEh, 38h, 1, 0E8h, 2Ah, 0, 1Fh, 72h, 24h, 1Eh
	db	0BEh, 3Eh, 1, 0E8h, 20h, 0, 1Fh, 72h, 1Ah, 3, 0F9h, 87h, 3Eh, 80h
	db	1, 56h, 8Bh, '6pR', 89h, 3Ch, 89h, '>pR', 0C7h, 5, 0, 0, 5Eh, 0FFh
	db	0Eh, 7Ch, 1, 0E9h, 82h, 41h, 8Bh, 34h, 0C5h, 1Eh, 34h, 1, 8Eh
	db	1Fh, 83h, 0FEh, 0, 74h, 0Fh, 0FFh, '4WQFF', 0F3h, 0A6h, 'Y_^u'
	db	0EEh, 0F9h, 0C3h, 0F8h, 0C3h, 0FEh, 6, 94h, 4, 8Ah, 4, 3Ch, 0C1h
	db	75h, 1Eh, 83h, 3Eh, 0F6h, 3, 0FFh, 75h, 17h, 8Bh, 3Eh, 86h, 1
	db	89h, 3Eh, 0F6h, 3, 80h, 3Eh, 2Bh, 1, 1, 75h, 8, 46h, 0E8h, 66h
	db	8, 89h, 0Eh, 35h, 0Ah, 0A1h, 66h, 1, 80h, 3Eh, 0D6h, 3, 1, 75h
	db	1Bh, 3Bh, 6, 64h, 1, 76h, 15h, 2Bh, 6, 64h, 1, 90h, 0B4h, 0Ah
	db	0F6h, 0E4h, 90h, 29h, 6, 76h, 7, 29h, 6, 7Eh, 7, 0A1h, 64h, 1
	db	0A3h, 3Dh, 5, 8Ah, 1Eh, 3Ah, 5, 81h, 0E3h, 0FFh, 0, 74h, 18h, 83h
	db	3Eh, 0A8h, 3, 0, 74h, 5, 80h, 0Eh, 5Ah, 5, 80h, 0A1h, 50h, 5, 23h
	db	0C0h, 74h, 5, 53h, 0E8h, 13h, 0FDh, 5Bh, 0A1h, 67h, 3, 3Bh, 6
	db	8Eh, 4, 76h, 3, 0A3h, 8Eh, 4, 0A1h, 5Ch, 5, 3Bh, 6, 0C8h, 3, 76h
	db	3, 0A3h, 0C8h, 3, 0A1h, 5Eh, 5, 3Bh, 6, 0C6h, 3, 76h, 3, 0A3h
	db	0C6h, 3, 0A1h, 42h, 5, 1, 6, 8Fh, 3, 2Eh, 8Bh, 8Fh, 'PWS', 8Bh
	db	1Eh, 3Ah, 7, 0C4h, 7Fh, 2, 3, 0F9h, ';?v', 9, 0E8h, 0C9h, '=[s'
	db	7, 0E8h, 8Ah, 3Dh, 87h, 7Fh, 2, 5Bh, 89h, 3Eh, 84h, 1, 8Bh, 0F7h
	db	83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Dh, 0B4h, 34h
	db	7, 8Bh, 74h, 2, 89h, 36h, 86h, 1, 83h, 0C6h, 38h, 83h, 0FEh, 80h
	db	76h, 1Ch, 83h, 0E6h, 3, 46h, 89h, 36h, 86h, 1, 8Bh, 0F7h, 83h
	db	0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Dh, 0B4h, 34h, 7
	db	0C7h, 44h, 2, 80h, 0FFh, 0BEh, 2Ah, 5, 0D1h, 0E9h, 0F3h, 0A5h
	db	0D1h, 0D1h, 0F3h, 0A4h, 80h, 3Eh, 0D2h, 3, 0, 74h, 2Dh, 8Bh, 36h
	db	0E0h, 3, 46h, 1Eh, 7, 8Bh, 0Eh, 'XR+', 0CEh, 83h, 0F9h, 2, 73h
	db	5, 0E8h, 92h, 6Eh, 0EBh, 0F0h, 2Bh, 0C0h, 8Bh, 0FEh, 0D1h, 0E9h
	db	0F3h, 0AFh, 8Bh, 0F7h, 74h, 0E4h, 4Eh, 4Eh, 80h, 3Ch, 1, 13h, 0F0h
	db	0E9h, 33h, 40h, 0C3h, 50h, 51h, 8Bh, 0Eh, 90h, 4, 53h, 8Bh, 1Eh
	db	5Ah, 7, 0C4h, 7Fh, 2, 3, 0F9h, ';?w', 1Ah, 87h, 7Fh, 2, 5Bh, 89h
	db	3Eh, 76h, 1, 57h, 0B0h, 0, 0FCh, 0F3h, 0AAh, 5Fh, 26h, 0FFh, 4Dh
	db	8, 26h, 0FFh, 4Dh, 0Ah, 59h, 58h, 0C3h, 0E8h, 10h, '=[s', 0E4h
	db	0E9h, 'Ew&', 8Bh, 7, 3Dh, 0FFh, 0FFh, 75h, 25h, 0E8h, 0BEh, 0FFh
	db	26h, 8, 55h, 0Eh, 26h, 89h, 5Dh, 0Ch, 0A1h, 86h, 1, 26h, 89h, 45h
	db	2, 97h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 18h, 7, 5Bh, 26h, 89h, 7, 0C4h, 3Eh, 86h, 7, 83h, 0C7h
	db	2, 3Bh, 3Eh, 84h, 7, 76h, 0Fh, 0BFh, 2, 0, 57h, 0BFh, 84h, 7, 0E8h
	db	9Ah, 3Ch, 73h, 7, 0E8h, 88h, 3Ch, 87h, 3Eh, 86h, 7, 89h, 3Eh, 88h
	db	1, 26h, 89h, 5, 0C3h, 8Bh, 1Eh, 74h, 1, 80h, 0CAh, 10h, 0EBh, 16h
	db	0F6h, 0C2h, 4, 74h, 3, 0E8h, 0DDh, 0FBh, 0B4h, 0, 0E8h, 0CCh, 75h
	db	0E8h, 92h, 0FFh, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 3Bh, 36h, 0E0h
	db	3, 72h, 0E4h, 89h, 1Eh, 74h, 1, 0E9h, 71h, 3Fh, 0B2h, 0, 0EBh
	db	0D0h, 0B2h, 4, 0EBh, 0CCh, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 2Bh
	db	0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch
	db	46h, 0Bh, 0DBh, 75h, 7, 0B2h, 2, 0ADh, 2Bh, 0C0h, 0EBh, 1Eh, 0B2h
	db	0, 81h, 0FBh, 0, 40h, 7Fh, 17h, 3Bh, 1Eh, 64h, 1, 76h, 4, 89h
	db	1Eh, 64h, 1, 4Bh, 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch
	db	5, 93h, 0C3h, 0B8h, 0FFh, 0FFh, 0EBh, 0FAh, 53h, 83h, 0E3h, 3
	db	0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h
	db	8Bh, 37h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h
	db	8Eh, 84h, 58h, 7, 5Eh, 26h, 8Bh, 74h, 2, 0C3h, 26h, 83h, 3Fh, 0FFh
	db	74h, 3, 0E9h, 81h, 0, 0E8h, 0CAh, 0FEh, 89h, 3Eh, 76h, 1, 0A1h
	db	6Ch, 1, 26h, 89h, 5, 0A1h, 86h, 1, 26h, 89h, 45h, 2, 0A1h, 6Eh
	db	1, 26h, 89h, 45h, 4, 0A1h, 70h, 1, 26h, 89h, 45h, 6, 26h, 89h
	db	5Dh, 0Ch, 0A0h, 72h, 1, 26h, 88h, 45h, 0Eh, 0A8h, 2, 74h, 5, 26h
	db	0C6h, 45h, 0Fh, 5, 0BAh, 0FFh, 0FFh, 53h, 0A8h, 2, 75h, 2Fh, 8Bh
	db	1Eh, 6Ch, 1, 8Bh, 0Eh, 4Eh, 4, 8Eh, 6, 78h, 7, '&;O', 2, 75h, 1Dh
	db	8Bh, 0D7h, 8Eh, 6, 80h, 7, 26h, 87h, 57h, 4, 57h, 83h, 0E7h, 3
	db	0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 26h
	db	89h, 55h, 0Ah, 5Bh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h
	db	0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 89h, 3Fh, 0C3h, 26h, 8Bh
	db	3Fh, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh
	db	85h, 58h, 7, 5Fh, 26h, 0F6h, 45h, 0Eh, 18h, 74h, 13h, 26h, 0F6h
	db	45h, 0Eh, 10h, 74h, 3, 0E9h, 5Fh, 0FFh, 26h, 83h, 3Dh, 0FEh, 72h
	db	3, 0E9h, 56h, 0FFh, 80h, 3Eh, 0D2h, 3, 1, 76h, 7, 80h, 3Eh, 24h
	db	1, 1, 75h, 0C5h, 'VWSWPRS', 0E8h, 0Ch, 0FFh, 8Bh, 0DEh, 5Eh, 53h
	db	0BFh, 28h, 0, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Eh, 84h, 18h, 7, 5Eh, 26h, 80h, 7Ch, 3, 40h, 74h, 5, 0E8h
	db	80h, 7Dh, 0EBh, 3, 0E8h, '#|^', 0C7h, 6, 22h, 4, 1, 0, 83h, 0E6h
	db	0FEh, 3Bh, 36h, 86h, 1, 't?V', 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h
	db	0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Bh, 34h, 0BFh, 78h
	db	0, 0E8h, 53h, 7Dh, 1Eh, 0B8h, 78h, 0, 50h, 1Eh, 0B8h, 28h, 0, 50h
	db	0B9h, 8, 0, 51h, 80h, 3Eh, 0D2h, 3, 2, 74h, 9, 0B8h, 25h, 0, 50h
	db	0E8h, 9Dh, 0A1h, 0EBh, 29h, 0B8h, 31h, 0, 50h, 0E8h, 99h, 0A1h
	db	0EBh, 20h, 1Eh, 0B8h, 28h, 0, 50h, 0B9h, 4, 0, 51h, 80h, 3Eh, 0D2h
	db	3, 2, 74h, 9, 0B8h, 24h, 0, 50h, 0E8h, 7Bh, 0A1h, 0EBh, 7, 0B8h
	db	30h, 0, 50h, 0E8h, 77h, 0A1h, 'ZX_[_^', 0E9h, 1Eh, 0FFh, 0A2h
	db	72h, 1, 0E8h, 25h, 0FEh, 8, 16h, 72h, 1, 0A3h, 6Ch, 1, 0EBh, 4Fh
	db	0F6h, 6, 72h, 1, 4, 74h, 3, 0E8h, 0CCh, 0F9h, 0B4h, 0, 0E8h, 0BBh
	db	73h, 80h, 3Eh, 2Bh, 1, 3, 75h, 17h, 3Bh, 1Eh, 72h, 4, 75h, 11h
	db	80h, 3Eh, 0Ah, 2, 0FFh, 74h, 6, 8Bh, 1Eh, 74h, 4, 0EBh, 4, 0FEh
	db	6, 0Ah, 2, 53h, 0ADh, 0A3h, 6Eh, 1, 33h, 0C0h, 3Bh, 6, 1Eh, 4
	db	74h, 1, 0ADh, 0A3h, 70h, 1, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 5Bh
	db	83h, 3Eh, 6Ch, 1, 0FFh, 74h, 3, 0E8h, 37h, 0FEh, 3Bh, 36h, 0E0h
	db	3, 72h, 0ABh, 0E9h, '-=+', 0C0h, 0EBh, 95h, 0B8h, 4, 0, 0EBh, 90h
	db	56h, 4Bh, 81h, 0FBh, 0, 4, 73h, 20h, 8Bh, 0F3h, 83h, 0E6h, 7, 0D1h
	db	0EBh, 0D1h, 0EBh, 0D1h, 0EBh, 2Eh, 8Ah, 84h, 0D8h, 1Ah, 84h, 87h
	db	8Ah, 1, 75h, 8, 0FFh, 6, 50h, 5, 8, 87h, 8Ah, 1, 5Eh, 0C3h, 0E8h
	db	0C5h, 6Bh, 1, 2, 4, 8, 10h, 20h, 40h, 80h, 80h, 3Ch, 80h, 83h
	db	0DEh, 0FEh, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah
	db	0FBh, 8Ah, 1Ch, 46h, 80h, 3Eh, 17h, 0, 0, 74h, 4Dh, 81h, 0FBh
	db	0, 40h, 7Fh, 4Ah, 3Bh, 1Eh, 7Ah, 1, 74h, 17h, 89h, 1Eh, 7Ah, 1
	db	0FFh, 6, 52h, 5, 0A1h, 52h, 5, 3Bh, 6, 8Ch, 4, 76h, 3, 0A3h, 8Ch
	db	4, 0E8h, 8Eh, 0FFh, 83h, 3Eh, 9Bh, 3, 0FFh, 75h, 0Ah, 0FFh, 6
	db	4Eh, 5, 0C7h, 6, 9Bh, 3, 0, 0, 0A1h, 0E0h, 3, 2Bh, 0C6h, 0D1h
	db	0E8h, 0D1h, 0E8h, 1, 6, 4Ch, 5, 80h, 3Eh, 3Ah, 5, 0, 75h, 5, 0C6h
	db	6, 3Ah, 5, 2, 0E9h, 85h, 3Ch, 0E8h, 52h, 0F6h, 83h, 3Eh, 9Bh, 3
	db	0FFh, 75h, 0Ah, 26h, 0FFh, 45h, 2, 0C7h, 6, 9Bh, 3, 0, 0, 0A1h
	db	0E0h, 3, 2Bh, 0C6h, 0D1h, 0E8h, 0D1h, 0E8h, 26h, 1, 45h, 4, 26h
	db	80h, 7Dh, 10h, 0, 75h, 5, 26h, 0C6h, 45h, 10h, 2, 26h, 0FFh, 45h
	db	0Ah, 0E9h, 51h, 3Ch, 0EBh, 17h, 0B4h, 80h, 0E8h, 8Fh, 72h, 0BFh
	db	2, 0, 57h, 0BFh, 8Ch, 7, 0E8h, ',9s', 3, 0E8h, 1Ah, 39h, 26h, 89h
	db	1Dh, 3Bh, 36h, 0E0h, 3, 72h, 0E3h, 0E9h, '/<&', 89h, 1Dh, 26h
	db	89h, 55h, 2, 83h, 3Eh, 43h, 0Ah, 0FFh, 75h, 10h, 3Bh, 1Eh, 38h
	db	4, 75h, 0Ah, 3Bh, 16h, 4Ch, 4, 75h, 4, 89h, 3Eh, 43h, 0Ah, 0A1h
	db	0D8h, 3, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 18h, 7, 5Bh, 26h, 83h, 3Fh, 0FFh, 75h, 4, 40h, 26h, 89h
	db	7, 87h, 0DAh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 83h, 3Fh, 0FFh, 75h, 4, 40h
	db	26h, 89h, 7, 0A3h, 0D8h, 3, 0C3h, 0E8h, 3Eh, 3Eh, 0A1h, 86h, 1
	db	26h, 89h, 45h, 4, 0ACh, 26h, 88h, 45h, 9, 3Ch, 0C0h, 72h, 3, 0E9h
	db	0DDh, 0, 0A8h, 0E0h, 75h, 9, 0ADh, 8Eh, 6, 80h, 7, 26h, 89h, 5
	db	46h, 0ADh, 8Eh, 6, 78h, 7, 26h, 89h, 45h, 6, 91h, 0B8h, 2, 0, '&"E'
	db	9, 0D1h, 0E8h, 83h, 3Eh, 1Eh, 4, 0, 74h, 1, 0ADh, 0Ah, 0C8h, 26h
	db	88h, 45h, 8, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah
	db	0FBh, 8Ah, 1Ch, 46h, 4Bh, 0D1h, 0E3h, 8Bh, 0D3h, 2Bh, 0DBh, 2
	db	1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 4Bh
	db	0D1h, 0E3h, 8Eh, 6, 90h, 7, 26h, 8Bh, 1Fh, 87h, 0D3h, 26h, 8Bh
	db	1Fh, 0A1h, 66h, 1, 40h, 0A3h, 66h, 1, 0Bh, 0C9h, 75h, 0Ch, 3Bh
	db	16h, 26h, 4, 74h, 9, 3Bh, 16h, 2Ch, 4, 74h, 3, 0A3h, 64h, 1, 56h
	db	57h, 83h, 3Eh, 1Ah, 4, 1, 'uN3', 0FFh, ';>.', 8, 73h, 46h, 8Eh
	db	6, 30h, 8, 26h, 83h, 3Dh, 0FEh, 74h, 9, 26h, 3Bh, 15h, 't3GG'
	db	0EBh, 0E7h, 8Bh, 0F2h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 84h, 18h, 7, 5Eh, 26h, 8Ah, 44h, 2, 25h, 3Fh
	db	0, 3Dh, 4, 0, 72h, 0DFh, 3, 0F0h, 26h, 81h, 7Ch, 0FFh, 'COu', 0D5h
	db	26h, 81h, 7Ch, 1, 'DEu', 0CDh, 8Bh, 16h, 4Eh, 4, 5Fh, 5Eh, 8Eh
	db	6, 78h, 7, 0E8h, 0B7h, 0FEh, 0E9h, 0E3h, 3Ah, 0C7h, 6, 22h, 4
	db	1, 0, 33h, 0C0h, 50h, 0B8h, 6, 0, 50h, 0E8h, 0A3h, 9Eh, 0Bh, 0DBh
	db	't K', 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 8Eh, 6
	db	80h, 7, 26h, 83h, 3Fh, 0FFh, 75h, 0Bh, 26h, 89h, 17h, 83h, 0F9h
	db	0FFh, 75h, 2, 8Bh, 0CBh, 0C3h, 8Bh, 0F2h, 0BFh, 28h, 0, 0E8h, 16h
	db	7Ah, 0C7h, 6, 22h, 4, 1, 0, 1Eh, 0B8h, 28h, 0, 50h, 0B9h, 4, 0
	db	51h, 0B8h, 7, 0, 50h, 0E8h, 61h, 9Eh, 0C6h, 6, 60h, 1, 1, 2Bh
	db	0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch
	db	46h, 4Bh, 0D1h, 0E3h, 8Eh, 6, 90h, 7, 26h, 8Bh, 17h, 0BFh, 4, 0
	db	57h, 0BFh, 94h, 7, 0E8h, 'U7s', 3, 0E8h, 'C7&', 89h, 15h, 0B9h
	db	0FFh, 0FFh, 0EBh, 27h, 0ACh, 3Ch, 0FFh, 'u3+', 0DBh, 2, 1Ch, 7Dh
	db	8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 0FEh, 0Eh, 60h
	db	1, 75h, 0Ah, 3Bh, 1Eh, 64h, 1, 76h, 4, 89h, 1Eh, 64h, 1, 0E8h
	db	62h, 0FFh, 3Bh, 36h, 0E0h, 3, 72h, 0D3h, 8Eh, 6, 98h, 7, 26h, 89h
	db	4Dh, 2, 0E9h, '$:3', 0DBh, 0EBh, 0E8h, 'QRVW', 0BEh, 50h, 0Ah
	db	3, 0FEh, 0E8h, 7, 0, 73h, 0FBh, '_^ZY', 0C3h, 0ADh, 50h, 33h, 0C0h
	db	83h, 3Eh, 0ECh, 3, 0, 74h, 1, 0ADh, 50h, 0ADh, 8Bh, 0C8h, 0E3h
	db	0Bh, 51h, 0E8h, 0EAh, 0FFh, 59h, 72h, 10h, 0E2h, 0F7h, 0EBh, 1Ah
	db	0ACh, 2Ah, 0E4h, 3, 0F0h, 3Bh, 0F7h, 72h, 11h, 0B8h, 1, 0, 5Ah
	db	23h, 0D2h, 75h, 0Dh, 5Ah, 0F7h, 0E2h, 23h, 0D2h, 75h, 6, 0F9h
	db	0C3h, 5Ah, 5Ah, 0F8h, 0C3h, 33h, 0C0h, 50h, 0B8h, 1Ch, 0, 50h
	db	0E8h, 98h, 9Dh, 80h, 3Eh, 19h, 0, 0, 74h, 3, 0E9h, 0A4h, 2, 0A1h
	db	0ECh, 3, 0D1h, 0E0h, 0A3h, 6Ah, 1, 33h, 0C9h, 0EBh, 7Ah, 24h, 7
	db	0EBh, 0Fh, 0ACh, 0A8h, 80h, 75h, 1Dh, 0D0h, 0E8h, 0D0h, 0E8h, 0A8h
	db	10h, 75h, 0EFh, 24h, 3, 3Ch, 3, 74h, 0Ah, 77h, 61h, 80h, 3Ch, 80h
	db	83h, 0DEh, 0FEh, 0EBh, 59h, 83h, 0C6h, 2, 0EBh, 54h, 8Ah, 0E0h
	db	0ACh, 8Bh, 0F8h, 80h, 0E4h, 1Ch, 80h, 0FCh, 18h, 77h, 8, 80h, 0E4h
	db	18h, 80h, 0FCh, 8, 75h, 15h, 41h, 80h, 3Eh, 0F1h, 3, 1, 75h, 0Dh
	db	83h, 0E7h, 3Fh, 0E8h, 49h, 0FFh, 48h, 3, 0C8h, 73h, 2, 0EBh, 90h
	db	0ACh, 0A8h, 80h, 75h, 0Ah, '<0sr', 80h, 3Ch, 80h, 83h, 0DEh, 0FEh
	db	0F6h, 0D0h, 0A8h, 8, 74h, 0Ah, 0A8h, 3, 74h, 59h, 80h, 3Ch, 80h
	db	83h, 0DEh, 0FEh, 0A8h, 4, 74h, 7, 83h, 0C6h, 2, 3, 36h, 6Ah, 1
	db	3Bh, 36h, 0E0h, 3, 73h, 2, 0EBh, 82h, 8Bh, 1Eh, 68h, 1, 83h, 0FBh
	db	0FFh, 74h, 23h, 8Eh, 6, 80h, 7, 26h, 1, 4Fh, 6, 8Eh, 6, 78h, 7
	db	26h, 8Bh, 47h, 2, 3Bh, 6, 4Eh, 4, 74h, 0Ah, 3Bh, 6, 50h, 4, 74h
	db	4, 1, 0Eh, 38h, 5, 0E9h, 4, 39h, 8Bh, 1Eh, 62h, 1, 83h, 0FBh, 0FFh
	db	74h, 8, 8Eh, 6, 0A8h, 7, 26h, 1, 4Fh, 0Ah, 0E9h, 0F0h, 38h, 83h
	db	0C6h, 2, 3, 36h, 6Ah, 1, 0EBh, 0A4h, '<@s', 90h, 83h, 0C6h, 2
	db	3, 36h, 6Ah, 1, 0EBh, 87h, 50h, 0ACh, 8Ah, 0E0h, 24h, 0F0h, 78h
	db	11h, '<0s', 8, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 0EBh, 5, 77h, 3
	db	83h, 0C6h, 2, 0F6h, 0C4h, 8, 75h, 24h, 0F6h, 0C4h, 4, 75h, 44h
	db	80h, 0E4h, 3, 80h, 0FCh, 3, 74h, 2Dh, 80h, 3Ch, 80h, 83h, 0DEh
	db	0FEh, 8Bh, 0Ch, 83h, 0C6h, 2, 83h, 3Eh, 1Eh, 4, 0, 74h, 38h, 83h
	db	0C6h, 2, 0EBh, 33h, 0F6h, 0C4h, 4, 75h, 0Fh, 8Bh, 0Ch, 83h, 0C6h
	db	2, 83h, 3Eh, 1Eh, 4, 0, 74h, 3, 83h, 0C6h, 2, 0EBh, 1Dh, 83h, 0C6h
	db	2, 8Bh, 0Ch, 83h, 0C6h, 2, 0EBh, 13h, 83h, 0C6h, 2, 0EBh, 0Eh
	db	80h, 0E4h, 3, 80h, 0FCh, 3, 74h, 0F3h, 80h, 3Ch, 80h, 83h, 0DEh
	db	0FEh, 58h, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 52h, 33h, 0C0h
	db	89h, 46h, 0FEh, 89h, 46h, 0FCh, 0ACh, 8Ah, 0E0h, 24h, 0F0h, 78h
	db	11h, '<0s', 8, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 0EBh, 5, 77h, 3
	db	83h, 0C6h, 2, 0F6h, 0C4h, 8, 75h, 35h, 0F6h, 0C4h, 4, 75h, 6Bh
	db	80h, 0E4h, 3, 80h, 0FCh, 3, 'tU+', 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h
	db	0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 8Bh, 14h, 89h, 56h, 0FEh
	db	83h, 0C6h, 2, 83h, 3Eh, 1Eh, 4, 0, 74h, 5Ch, 8Bh, 14h, 89h, 56h
	db	0FCh, 83h, 0C6h, 2, 0EBh, 52h, 0F6h, 0C4h, 4, 75h, 17h, 8Bh, 14h
	db	89h, 56h, 0FEh, 83h, 0C6h, 2, 83h, 3Eh, 1Eh, 4, 0, 74h, 8, 8Bh
	db	14h, 89h, 56h, 0FCh, 83h, 0C6h, 2, 8Ah, 0DCh, 83h, 0E3h, 3, 8Ah
	db	0A7h, 32h, 2, 0D1h, 0E3h, 8Bh, 9Fh, 36h, 2, 0EBh, 25h, 8Bh, 1Ch
	db	83h, 0C6h, 4, 0EBh, 1Eh, 8Bh, 1Ch, 83h, 0C6h, 2, 0EBh, 17h, 80h
	db	0E4h, 3, 80h, 0FCh, 3, 74h, 0F1h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h
	db	80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 'FZR', 80h, 0E6h, 1Ch, 80h
	db	0FEh, 4, 74h, 14h, 80h, 0FEh, 8, 75h, 3, 0E9h, 7Eh, 0, 80h, 0FEh
	db	0Ch, 74h, 79h, 80h, 0FEh, 14h, 74h, 74h, 0EBh, 73h, 80h, 0FCh
	db	2, 'unK', 0D1h, 0E3h, 3, 1Eh, 2Eh, 5, 8Eh, 6, 88h, 7, 26h, 8Bh
	db	1Fh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh
	db	87h, 58h, 7, '[PSV&', 8Bh, 47h, 0Ch, 0BEh, 60h, 4, 0BBh, 9, 0
	db	3Bh, 4, 74h, 3Ch, 83h, 0C6h, 2, 4Bh, 75h, 0F6h, '^[X', 0A1h, 68h
	db	1, 3Dh, 0FFh, 0FFh, 75h, 6, 0A1h, 62h, 1, 0Dh, 1, 0, 53h, 8Bh
	db	1Eh, 12h, 8, 0C4h, 7Fh, 2, 83h, 0C7h, 4, ';?v', 9, 0E8h, 'N4[s'
	db	7, 0E8h, 0Fh, 34h, 87h, 7Fh, 2, 5Bh, 26h, 89h, 5, 26h, 89h, 5Dh
	db	2, 0EBh, 4, 41h, 0EBh, 0C7h, 41h, 5Ah, 8Bh, 0E5h, 5Dh, 0C3h, 0A1h
	db	0ECh, 3, 0D1h, 0E0h, 0A3h, 6Ah, 1, 33h, 0C9h, 0E9h, 8Eh, 0, 98h
	db	8Bh, 0F8h, 83h, 0E7h, 3, 0A8h, '@u0', 0D0h, 0E8h, 0D0h, 0E8h, 24h
	db	3, 88h, 85h, 32h, 2, 0D1h, 0E7h, 3Ch, 3, 74h, 15h, 2Bh, 0DBh, 2
	db	1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 89h
	db	9Dh, 36h, 2, 0EBh, 5Fh, 8Bh, 1Ch, 83h, 0C6h, 2, 89h, 9Dh, 36h
	db	2, 0EBh, 54h, 0D0h, 0E0h, 0D0h, 0E0h, 24h, 7, 88h, 85h, 3Eh, 2
	db	0D1h, 0E7h, 3Ch, 3, 74h, 15h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h
	db	0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 89h, 9Dh, 42h, 2, 0EBh, 2Fh
	db	8Bh, 1Ch, 83h, 0C6h, 2, 89h, 9Dh, 42h, 2, 0EBh, 24h, 0ACh, 0A8h
	db	80h, 74h, 91h, 8Ah, 0E0h, 0ACh, 8Bh, 0D0h, 0E8h, 33h, 0FEh, 80h
	db	3Eh, 0F1h, 3, 1, 75h, 10h, 8Bh, 0FAh, 83h, 0E7h, 3Fh, 0E8h, 67h
	db	0FCh, 48h, 3, 0C8h, 73h, 3, 0E9h, 0ADh, 0FCh, 3Bh, 36h, 0E0h, 3
	db	73h, 2, 0EBh, 0D4h, 8Bh, 1Eh, 68h, 1, 83h, 0FBh, 0FFh, 74h, 23h
	db	8Eh, 6, 80h, 7, 26h, 1, 4Fh, 6, 8Eh, 6, 78h, 7, 26h, 8Bh, 47h
	db	2, 3Bh, 6, 4Eh, 4, 74h, 0Ah, 3Bh, 6, 50h, 4, 74h, 4, 1, 0Eh, 38h
	db	5, 0E9h, 4Bh, 36h, 8Bh, 1Eh, 62h, 1, 83h, 0FBh, 0FFh, 74h, 8, 8Eh
	db	6, 0A8h, 7, 26h, 1, 4Fh, 0Ah, 0E9h, '76+', 0DBh, 2, 1Ch, 7Dh, 8
	db	46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 81h, 0FBh, 0, 40h
	db	7Fh, 17h, 4Bh, 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5
	db	89h, 1Eh, 68h, 1, 0C6h, 6, 0F1h, 3, 0, 0E9h, 0Bh, 36h, 0E8h, 0E3h
	db	6Eh, 72h, 12h, 0C7h, 6, 68h, 1, 0FFh, 0FFh, 89h, 1Eh, 62h, 1, 0C6h
	db	6, 0F1h, 3, 0, 0E9h, 0F4h, 35h, 83h, 0FBh, 0FFh, 74h, 5, 0BBh
	db	0FFh, 0FFh, 0EBh, 0EAh, 0E8h, 0B3h, 64h, 0C6h, 6, 0F1h, 3, 1, 2Bh
	db	0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch
	db	46h, 4Bh, 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 89h
	db	1Eh, 68h, 1, 8Eh, 6, 78h, 7, 26h, 0F6h, 47h, 9, 0E0h, 74h, 27h
	db	89h, 1Eh, 0E6h, 3, 0ADh, 83h, 3Eh, 1Eh, 4, 0, 74h, 1, 0ADh, 8Bh
	db	0Eh, 0E0h, 3, 2Bh, 0CEh, 89h, 0Eh, 0E4h, 3, 1Eh, 7, 0BFh, 50h
	db	0Ah, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 0E9h, 92h
	db	35h, 0C6h, 6, 0F1h, 3, 0FFh, 0EBh, 0F6h, 0A1h, 0E0h, 3, 2Bh, 0C6h
	db	5, 4, 0, 8Bh, 3Eh, 96h, 4, 89h, 45h, 6, 0A3h, 62h, 52h, 0ADh, 0A3h
	db	64h, 52h, 89h, 45h, 2, 92h, 0ADh, 0A3h, 66h, 52h, 89h, 45h, 4
	db	91h, 0C6h, 6, 61h, 1, 1, 0C6h, 6, 0D2h, 3, 2, 80h, 3Eh, 0D5h, 3
	db	1, 74h, 0Bh, 80h, 3Eh, 0D5h, 3, 4, 74h, 4, 0FEh, 0Eh, 0D2h, 3
	db	80h, 3Eh, 54h, 2, 0, 75h, 6, 0E8h, 0A8h, 21h, 72h, 1, 0C3h, 0E9h
	db	'=5U', 8Bh, 0ECh, 83h, 0ECh, 0Ah, 0Ch, 8, 88h, 46h, 0FEh, 0EBh
	db	6, 8Bh, 0E5h, 5Dh, 0E9h, '*5;6', 0E0h, 3, 73h, 0F4h, 0F6h, 46h
	db	0FEh, 4, 74h, 3, 0E8h, 6Ch, 0F1h, 0B4h, 0, 0E8h, '[kS', 80h, 3Ch
	db	80h, 83h, 0DEh, 0FEh, 0ACh, 0B4h, 0, '<`w', 0Dh, 48h, 90h, 0B4h
	db	0Ah, 0F6h, 0E4h, 90h, 3, 6, 2Ch, 5, 0EBh, 3, 2Dh, 63h, 0, 89h
	db	46h, 0FAh, 53h, 33h, 0C0h, 8Bh, 0D0h, 0ACh, 8Bh, 0D8h, 80h, 0FBh
	db	81h, 72h, 11h, 0ADh, 80h, 0FBh, 81h, 74h, 0Bh, 92h, 80h, 0FBh
	db	84h, 75h, 3, 0ACh, 0EBh, 1, 0ADh, 92h, 5Bh, 83h, 7Eh, 0FAh, 0FEh
	db	'u(RPS3', 0C0h, 8Bh, 0D0h, 0ACh, 8Bh, 0D8h, 80h, 0FBh, 81h, 72h
	db	11h, 0ADh, 80h, 0FBh, 81h, 74h, 0Bh, 92h, 80h, 0FBh, 84h, 75h
	db	3, 0ACh, 0EBh, 1, 0ADh, 92h, '[[Y', 9Ah, 5, 0, 2Fh, 0, 89h, 46h
	db	0F8h, 89h, 56h, 0F6h, 5Bh, 26h, 83h, 3Fh, 0FFh, 74h, 3, 0E9h, 0CAh
	db	0, 0E8h, 6Ch, 0F4h, 26h, 89h, 5Dh, 0Ch, 89h, 3Eh, 76h, 1, 8Bh
	db	46h, 0FAh, 26h, 89h, 5, 0A1h, 86h, 1, 26h, 89h, 45h, 2, 8Ah, 46h
	db	0FEh, 26h, 88h, 45h, 0Eh, 57h, 26h, 0FFh, 75h, 0Ah, 0C4h, 3Eh
	db	0A6h, 7, 83h, 0C7h, 0Ch, 3Bh, 3Eh, 0A4h, 7, 76h, 0Fh, 0BFh, 0Ch
	db	0, 57h, 0BFh, 0A4h, 7, 0E8h, 'I1s', 7, 0E8h, 37h, 31h, 87h, 3Eh
	db	0A6h, 7, 57h, 33h, 0C0h, 0B9h, 0Ch, 0, 0FCh, 0F3h, 0AAh, 5Fh, 26h
	db	8Fh, 5, 0A1h, 86h, 1, 26h, 89h, 45h, 2, 8Bh, 46h, 0F8h, 26h, 89h
	db	45h, 6, 8Bh, 46h, 0F6h, 26h, 89h, 45h, 8, 8Bh, 46h, 0FAh, 26h
	db	89h, 45h, 4, 8Bh, 0C7h, 5Fh, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h
	db	0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 26h, 87h, 45h, 0Ah, 3Dh
	db	0FFh, 0FFh, 75h, 12h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h
	db	0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 89h, 3Fh, 8Bh, 0C7h, 0C4h
	db	3Eh, 86h, 7, 83h, 0C7h, 2, 3Bh, 3Eh, 84h, 7, 76h, 0Fh, 0BFh, 2
	db	0, 57h, 0BFh, 84h, 7, 0E8h, 0D1h, 30h, 73h, 7, 0E8h, 0BFh, 30h
	db	87h, 3Eh, 86h, 7, 89h, 3Eh, 88h, 1, 26h, 89h, 5, 89h, 1Eh, 74h
	db	1, 0E9h, 0A4h, 0FEh, 26h, 8Bh, 3Fh, 57h, 83h, 0E7h, 3, 0D1h, 0E7h
	db	0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 26h, 0F6h, 45h
	db	0Eh, 18h, 74h, 0B7h, 26h, 0F6h, 45h, 0Eh, 8, 75h, 3, 0E9h, 1Ah
	db	0FFh, 83h, 7Eh, 0FAh, 0FEh, 72h, 9, 26h, 83h, 3Dh, 0FEh, 72h, 0Ch
	db	0E9h, 23h, 0FFh, 26h, 83h, 3Dh, 0FEh, 73h, 3, 0E9h, 1Ah, 0FFh
	db	56h, 57h, 0C7h, 6, 22h, 4, 1, 0, 26h, 8Bh, 7Dh, 0Ah, 8Eh, 6, 0A8h
	db	7, 26h, 0FFh, 75h, 2, 8Bh, 0F3h, 0BFh, 28h, 0, 0E8h, 0E6h, 'r^V'
	db	83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h
	db	7, 5Eh, 26h, 8Bh, 34h, 0BFh, 78h, 0, 0E8h, 0CDh, 72h, 2Eh, 8Eh
	db	1Eh, 10h, 0, 1Eh, 0B8h, 78h, 0, 50h, 1Eh, 0B8h, 28h, 0, 50h, 0B9h
	db	8, 0, 51h, 0B8h, 33h, 0, 50h, 0E8h, 1Eh, 97h, 5Fh, 5Eh, 0E9h, 15h
	db	0FEh, 2Bh, 0C0h, 0E9h, 0FDh, 0FDh, 0B8h, 4, 0, 0E9h, 0F7h, 0FDh
	db	0, 0, 0, '%s:%x', 0, '%s:%x%x', 0, 55h, 8Bh, 0ECh, 81h, 0ECh, 82h
	db	0, 0FFh, 6, 0ECh, 4, 1Eh, 7, 0BFh, 0A0h, 2, 0B9h, 10h, 0, 33h
	db	0C0h, 0F3h, 0AAh, 8Bh, 36h, 2Ah, 5, 56h, 83h, 0E6h, 3, 0D1h, 0E6h
	db	0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 18h, 7, 5Eh, 83h, 0C6h, 2, 33h
	db	0C0h, 0E8h, 17h, 2Eh, 0A3h, 2Ah, 2, 80h, 3Eh, 0D2h, 3, 1, 73h
	db	5Ah, 1Eh, 7, 0BFh, 0BBh, 92h, 8Bh, 0F7h, 32h, 0C0h, 0B9h, 0FFh
	db	0FFh, 0F2h, 0AEh, 83h, 0EFh, 5, 33h, 0C9h, 3Bh, 0F7h, 74h, 14h
	db	26h, 8Ah, 45h, 0FFh, '<\t', 0Ch, '<:t', 8, '</t', 4, 4Fh, 41h
	db	0EBh, 0E8h, 8Bh, 0F7h, 8Ch, 0C0h, 8Eh, 0D8h, 8Ch, 0D0h, 8Eh, 0C0h
	db	8Dh, 0BEh, 7Eh, 0FFh, 6, 57h, 8Ah, 0C1h, 0AAh, 0ACh, '<ar', 6
	db	'<zw', 2, 2Ch, 20h, 0AAh, 0FEh, 0C9h, 75h, 0F0h, 5Eh, 7, 2Eh, 8Eh
	db	1Eh, 10h, 0, 33h, 0C0h, 0E8h, 0B3h, 2Dh, 0BFh, 0A0h, 2, 89h, 5
	db	0BEh, 2Ah, 5, 33h, 0C0h, 8Bh, 0D8h, 8Bh, 0C8h, 8Bh, 0D0h, 89h
	db	46h, 0FEh, 80h, 7Ch, 10h, 0, 74h, 23h, 8Bh, 'D$#', 0C0h, 74h, 5
	db	8Bh, 1Eh, 0F4h, 4, 43h, 8Bh, 4Ch, 28h, 0E3h, 5, 8Bh, 16h, 0F8h
	db	4, 42h, 50h, 8Bh, 44h, 30h, 89h, 46h, 0FEh, 58h, 81h, 66h, 0FEh
	db	7Fh, 0FFh, 89h, 45h, 0Ah, 89h, 5Dh, 8, 89h, 4Dh, 0Eh, 89h, 55h
	db	0Ch, 8Bh, 46h, 0FEh, 89h, 45h, 2, 0A1h, 0Ah, 5, 40h, 0A3h, 0B4h
	db	2, 0A1h, 10h, 5, 40h, 0A3h, 0B0h, 2, 0A1h, 0E6h, 4, 40h, 0A3h
	db	9Dh, 3, 0A1h, 0F4h, 4, 0A3h, 9Fh, 3, 33h, 0C0h, 0A3h, 85h, 3, 0A3h
	db	65h, 3, 0A3h, 87h, 3, 0A3h, 89h, 3, 0A3h, 67h, 3, 0A3h, 8Bh, 3
	db	0A3h, 83h, 3, 0A3h, 78h, 1, 0A3h, 8Dh, 3, 48h, 0A3h, 93h, 3, 0A3h
	db	7Ah, 1, 0A3h, 9Bh, 3, 8Bh, 0E5h, 5Dh, 0C3h, 80h, 3Eh, 94h, 4, 0
	db	74h, 7, 8Bh, 36h, 0E0h, 3, 0E9h, 0EBh, 31h, 0FEh, 0Eh, 94h, 4
	db	8Bh, 36h, 0E2h, 3, 89h, 36h, 28h, 2, 56h, 83h, 0E6h, 3, 0D1h, 0E6h
	db	0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Ah, 5Ch, 10h
	db	0B7h, 0, 2Eh, 8Bh, 8Fh, 50h, 57h, 0B8h, 38h, 0, 2Bh, 0C1h, 1, 0Eh
	db	0E2h, 3, 26h, 83h, 7Ch, 0Ah, 2, 72h, 36h, 0BFh, 2Ah, 5, 6, 1Eh
	db	7, 1Fh, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 91h, 0F3h
	db	0AAh, 6, 1Eh, 7, 1Fh, 0A0h, 3Fh, 5, 0A2h, 11h, 4, 80h, 3Eh, 16h
	db	0, 0, 74h, 10h, 0FFh, 36h, 22h, 1, 0C6h, 6, 22h, 1, 0, 0E8h, 63h
	db	0FEh, 58h, 0A2h, 22h, 1, 0E9h, 7Fh, 31h, 8Bh, 36h, 0E0h, 3, 46h
	db	8Bh, 0Eh, 'XR+', 0CEh, 83h, 0F9h, 3, 73h, 5, 0E8h, 0BCh, 5Fh, 0EBh
	db	0F0h, 8Ah, 1Ch, 46h, 0ADh, 8Bh, 0Eh, 'XR+', 0CEh, 3Bh, 0C8h, 73h
	db	5, 0E8h, 0A9h, 5Fh, 0EBh, 0F1h, 8Bh, 0FEh, 3, 0F8h, 4Fh, 89h, 3Eh
	db	0E0h, 3, 80h, 0FBh, 8Ah, 75h, 0CAh, 0E9h, 28h, 16h, 57h, 1Eh, 7
	db	56h, 0E8h, 'e,^', 8Bh, 0D8h, 0ACh, 98h, 3, 0F0h, 8Bh, 0C3h, 5Fh
	db	0C3h, 0B4h, 0, 0E8h, 'tg&', 83h, 3Fh, 0FFh, 't&S', 83h, 0E3h, 3
	db	0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h
	db	8Bh, 1Fh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 58h, 7, 5Bh, 26h, 8Bh, 47h, 12h, 0C3h, 33h, 0C0h, 0C3h
	db	33h, 0D2h, 0EBh, 5Bh, 0FFh, 6, 0E6h, 4, 0BFh, 90h, 2, 0ACh, 88h
	db	5, '<@tT<', 0C0h, 'tPV', 0ACh, 98h, 23h, 0C0h, 74h, 8, 'NR3', 0C0h
	db	0E8h, 96h, 0FFh, 5Ah, 5Bh, 89h, 45h, 1, 23h, 0D2h, 75h, 43h, 80h
	db	'=`tC+', 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 46h, 83h, 0FBh, 18h, 72h, 4, 3, 1Eh, 8Fh, 3, 89h, 5Dh
	db	3, 52h, 56h, 8Bh, 0F7h, 0B9h, 5, 0, 0BDh, 7Eh, 4, 0BBh, 25h, 3
	db	0E8h, '~*^Z;6', 0E0h, 3, 72h, 9Fh, 0C3h, 0ADh, 89h, 45h, 1, 0ADh
	db	89h, 45h, 3, 0EBh, 0DDh, 0ADh, 8Bh, 0D8h, 0EBh, 0D5h, 'VWR', 8Bh
	db	0F3h, 0E8h, 4Fh, 0FFh, 8Bh, 0D8h, 'Z_^', 80h, 3Ch, 80h, 83h, 0DEh
	db	0FEh, 0EBh, 0C0h, 0BAh, 1, 0, 0E9h, 72h, 0FFh, '#9(', 1Eh, 16h
	db	28h, 1Fh, 16h, 28h, 15h, 54h, 28h, 16h, 54h, 28h, 1Ah, 1Dh, '("t($q(.'
	db	0DCh, '(4T(5T(-', 2, ')3^) ', 0F2h, 27h, 21h, 0F2h, 27h, 17h, 'T(0'
	db	0B6h, 28h, 18h, 54h, 28h, 19h, 54h, 28h, 1Bh, 0F8h, 27h, 8Dh, 28h
	db	0BFh, 90h, 2, 33h, 0C0h, 1Eh, 7, 0B9h, 4, 0, 0F3h, 0ABh, 2Bh, 0DBh
	db	2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h
	db	53h, 0ACh, 98h, 23h, 0C0h, 74h, 6, 4Eh, 33h, 0C0h, 0E8h, 0C4h
	db	0FEh, 0BBh, 90h, 2, 89h, 47h, 1, 0ADh, 89h, 47h, 3, 0ACh, 88h
	db	7, 0BFh, 61h, 27h, 0Eh, 7, 0B9h, 14h, 0, 0AEh, 74h, 3, 0AFh, 0E2h
	db	0FAh, 26h, 0FFh, 35h, 1Eh, 7, 8Dh, 7Fh, 5, 0B9h, 8, 0, 8Bh, 16h
	db	8Fh, 3, 0C3h, 0A5h, 0B9h, 10h, 0, 0EBh, 1Fh, 0A5h, 0B9h, 10h, 0
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah
	db	1Ch, 46h, 89h, 1Dh, 83h, 0FBh, 18h, 72h, 7Bh, 1, 15h, 0EBh, 77h
	db	47h, 0A1h, 9Dh, 3, 0ABh, 0EBh, 69h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8
	db	46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 89h, 5Dh, 1, 83h
	db	0FBh, 18h, 72h, 59h, 1, 55h, 1, 0EBh, 54h, 2Bh, 0DBh, 2, 1Ch, 7Dh
	db	8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 53h, 0ADh, 0D0h
	db	0CCh, 80h, 0E4h, 80h, 0Ah, 0C4h, 0AAh, 0EBh, 11h, 2Bh, 0DBh, 2
	db	1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 53h
	db	0A4h, 58h, 0ABh, 3Dh, 18h, 0, 72h, 21h, 1, 55h, 0FEh, 0EBh, 1Ch
	db	0A4h, 0EBh, 19h, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 0B9h, 10h, 0
	db	83h, 0C7h, 3, 0A5h, 0A5h, 0A1h, 9Dh, 3, 0ABh, 0A1h, 0E6h, 4, 40h
	db	0A3h, 9Dh, 3, 58h, 2Dh, 18h, 0, 8Bh, 0F9h, 51h, 0B1h, 3, 0D3h
	db	0E0h, 0D3h, 0EFh, 1, 3Eh, 0E4h, 4, 59h, 56h, 0BEh, 90h, 2, 8Bh
	db	16h, 23h, 3, 3, 6, 21h, 3, 83h, 0D2h, 0, 0BBh, 7Eh, 4, 0E8h, 'Q`^'
	db	0C3h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 'FS2', 0C0h, 0AAh, 57h, 52h, 6, 33h, 0C0h, 0E8h, 0BAh
	db	0FDh, 7, 5Ah, 5Fh, 89h, 45h, 2, 0B9h, 10h, 0, 0EBh, 89h, 8Bh, 47h
	db	1, 0A3h, 0A5h, 3, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h
	db	8Ah, 0FBh, 8Ah, 1Ch, 46h, 3, 1Eh, 0A1h, 3, 89h, 1Eh, 0A3h, 3, 89h
	db	5Dh, 1, 58h, 0A3h, 2Ch, 2, 0EBh, 8Ch, 0ACh, 98h, 22h, 0C0h, 79h
	db	5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 0A4h, 3Dh, 18h, 0, 72h, 2, 3, 0C2h
	db	0ABh, 0ACh, 8Ah, 0C8h, 0A8h, 1, 74h, 3Ch, 0ACh, 98h, 22h, 0C0h
	db	79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 3, 0C2h, 0ABh, 0ACh, 98h, 22h
	db	0C0h, 79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 0D1h, 0E0h, 0ABh, 33h
	db	0C0h, 0F6h, 0C1h, 8, 75h, 9, 57h, 51h, 0E8h, 58h, 0FDh, 59h, 5Fh
	db	1Eh, 7, 0ABh, 33h, 0C0h, 8Ah, 0E1h, 0B1h, 4, 0D2h, 0E4h, 0ABh
	db	0B9h, 10h, 0, 0E9h, 34h, 0FFh, 83h, 0C7h, 6, 0EBh, 0ECh, 47h, 0ACh
	db	98h, 22h, 0C0h, 79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 3Dh, 18h, 0
	db	72h, 2, 3, 0C2h, 0ABh, 0ACh, 98h, 22h, 0C0h, 79h, 5, 2Ch, 80h
	db	8Ah, 0E0h, 0ACh, 3, 6, 0A1h, 3, 0ABh, 0B9h, 10h, 0, 0E9h, 5, 0FFh
	db	50h, 6, 8Eh, 6, 7Dh, 3, 26h, 8Ah, 44h, 8, 26h, 8Ah, 65h, 8, 25h
	db	3, 3, 3Ah, 0E0h, 75h, 12h, 26h, 8Bh, 44h, 6, '&;E', 6, 75h, 8
	db	26h, 8Bh, 44h, 4, '&;E', 4, 7, 58h, 0C3h, 55h, 8Bh, 0Eh, 67h, 3
	db	0E3h, 3Dh, 83h, 0F9h, 1, 74h, 0Ch, 0D1h, 0E1h, 0BDh, 88h, 29h
	db	8Eh, 6, 81h, 3, 0E8h, 93h, 65h, 8Bh, 0Eh, 67h, 3, 33h, 0DBh, 8Eh
	db	6, 81h, 3, 26h, 8Bh, '7SQ', 0BDh, 7Dh, 3, 0B9h, 9, 0, 0BBh, 9
	db	3, 0E8h, 0C7h, 27h, 'Y[CC', 0E2h, 0E5h, 33h, 0C0h, 0A3h, 89h, 3
	db	0A3h, 67h, 3, 0A3h, 8Bh, 3, 83h, 3Eh, 78h, 1, 0, 74h, 25h, 83h
	db	3Eh, 0A8h, 3, 0, 74h, 1Eh, 8Bh, 3Eh, 83h, 3, 83h, 0EFh, 16h, 8Eh
	db	6, 6Dh, 3, 26h, 83h, 7Dh, 14h, 0FFh, 75h, 0Ch, 0A1h, 0Ah, 5, '@&+E'
	db	12h, 26h, 89h, 45h, 14h, 5Dh, 0C3h, 8Eh, 6, 80h, 7, 26h, 8Bh, 4Fh
	db	6, 26h, 8Ah, 47h, 9, 25h, 0FFh, 0, 74h, 39h, 8Eh, 6, 78h, 7, 26h
	db	8Bh, 5Fh, 4, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 38h, 7, 5Bh, 26h, 8Bh, 5Fh, 16h, 48h, 50h, 0B4h, 10h
	db	0F6h, 0E4h, 96h, 58h, 8Eh, 6, 71h, 3, 26h, 3Bh, 1Ch, 74h, 10h
	db	5, 0FFh, 0, 81h, 0C6h, 0F0h, 0Fh, 3Bh, 36h, 99h, 3, 72h, 0EEh
	db	0E8h, 2Ch, 5Ch, 89h, 0Eh, 97h, 3, 40h, 89h, 36h, 95h, 3, 0C3h
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 8, 56h, 0E8h, 2Dh, 0FFh, 5Eh, 2Bh, 0DBh
	db	2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h
	db	81h, 0FBh, 0, 40h, 7Eh, 3, 0E9h, 0CCh, 0, 0C6h, 46h, 0F8h, 0, 33h
	db	0C0h, 89h, 5Eh, 0FEh, 89h, 46h, 0FCh, 8Bh, 3Eh, 83h, 3, 83h, 6
	db	83h, 3, 16h, 8Bh, 0DFh, 8Eh, 6, 6Dh, 3, 0B9h, 0Bh, 0, 33h, 0C0h
	db	0F3h, 0ABh, 83h, 3Eh, 78h, 1, 0, 74h, 8, 26h, 8Bh, 47h, 0FAh, 26h
	db	89h, 47h, 4, 89h, 5Eh, 0FAh, 0FFh, 6, 0F0h, 4, 0A1h, 0F0h, 4, 26h
	db	89h, 47h, 10h, 0A1h, 19h, 3, 26h, 89h, 47h, 0Ch, 0A1h, 1Bh, 3
	db	26h, 89h, 47h, 0Eh, 0A1h, 0Ah, 5, 40h, 26h, 89h, 47h, 12h, 26h
	db	0C7h, 47h, 14h, 0FFh, 0FFh, 83h, 6, 19h, 3, 0Ch, 83h, 16h, 1Bh
	db	3, 0, 8Bh, 5Eh, 0FEh, 56h, 6, 80h, 7Eh, 0F8h, 0, 74h, 8, 0C7h
	db	6, 93h, 3, 0FFh, 0FFh, 0EBh, 15h, 3Bh, 1Eh, 93h, 3, 74h, 1Ch, 89h
	db	1Eh, 93h, 3, 4Bh, 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch
	db	5, 0E8h, 0F6h, 0FEh, 8Bh, 46h, 0FCh, 23h, 0C0h, 74h, 3, 0A3h, 97h
	db	3, 8Bh, 36h, 95h, 3, 8Eh, 6, 71h, 3, 26h, 83h, 7Ch, 0Ah, 0, 75h
	db	7, 0A1h, 0F0h, 4, 26h, 89h, 44h, 8, 26h, 0FFh, 44h, 0Ah, 7, 5Eh
	db	0ADh, 8Bh, 5Eh, 0FAh, 26h, 89h, 47h, 8, 0FFh, 6, 78h, 1, 0C7h
	db	6, 30h, 2, 0FFh, 0FFh, 8Bh, 0E5h, 5Dh, 0C3h, 81h, 0EBh, 1, 40h
	db	0D1h, 0E3h, 3, 1Eh, 2Eh, 5, 8Eh, 6, 88h, 7, 26h, 8Bh, 1Fh, 53h
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h
	db	7, 5Bh, 26h, 8Bh, 47h, 2, 3Bh, 6, 28h, 2, 75h, 0Eh, 26h, 8Bh, 47h
	db	4, 26h, 8Bh, 1Fh, 0C6h, 46h, 0F8h, 0FFh, 0E9h, 2, 0FFh, 0FFh, 6
	db	78h, 1, 0C7h, 6, 30h, 2, 1, 0, 8Bh, 36h, 0E0h, 3, 0EBh, 0B4h, 4Bh
	db	93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 8Bh, 0F3h, 3, 36h, 2Ch, 5, 8Eh
	db	6, 78h, 7, 26h, 8Ah, 44h, 9, 8Eh, 6, 80h, 7, 26h, 8Bh, 4Ch, 6
	db	26h, 8Bh, 34h, 0A8h, 0E0h, 74h, 6, 0E8h, 1Ah, 65h, 33h, 0DBh, 0C3h
	db	8Bh, 0C6h, 0BBh, 1, 0, 0EBh, 0F8h, 83h, 3Eh, 30h, 2, 1, 75h, 0Ah
	db	83h, 3Eh, 78h, 1, 0, 74h, 3, 0E9h, 5Bh, 1, 0A1h, 0E8h, 4, 40h
	db	83h, 3Eh, 78h, 1, 0, 75h, 0Ch, 83h, 3Eh, 8Dh, 3, 0, 75h, 3, 0A3h
	db	8Dh, 3, 0EBh, 7Bh, 8Bh, 3Eh, 83h, 3, 8Eh, 6, 6Dh, 3, 26h, 83h
	db	7Dh, 0EAh, 0, 'ul&', 89h, 45h, 0EAh, 0EBh, 66h, 0FFh, 6, 0E8h
	db	4, 83h, 3Eh, 78h, 1, 0, 74h, 0Ch, 8Bh, 3Eh, 83h, 3, 8Eh, 6, 6Dh
	db	3, 26h, 0FFh, 45h, 0ECh, 33h, 0C0h, 0E8h, 4Fh, 0FAh, 0BFh, 90h
	db	2, 89h, 5, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah
	db	0FBh, 8Ah, 1Ch, 46h, 83h, 0FBh, 18h, 72h, 4, 3, 1Eh, 8Fh, 3, 89h
	db	5Dh, 2, 0ACh, 88h, 45h, 8, 25h, 7, 0, 8Bh, 0D8h, 0D1h, 0E3h, 2Eh
	db	0FFh, 97h, 0B5h, 2Ch, 56h, 0BEh, 90h, 2, 0B9h, 9, 0, 8Ah, 44h
	db	8, 24h, 7, 3Ch, 1, 76h, 11h, 0BDh, 7Eh, 4, 0BBh, 9, 3, 0E8h, 27h
	db	'%^;6', 0E0h, 3, 72h, 94h, 0C3h, 8Eh, 6, 81h, 3, 8Bh, 3Eh, 8Bh
	db	3, 0A1h, 89h, 3, 0ABh, 89h, 3Eh, 8Bh, 3, 8Bh, 0F8h, 8Eh, 6, 7Dh
	db	3, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 0FFh, 6, 67h
	db	3, 89h, 3Eh, 89h, 3, 0EBh, 0D0h, 0CEh, 2Ch, 12h, '-A-A-K-', 0C5h
	db	',@-@-', 0ADh, 89h, 45h, 4, 0ADh, 89h, 45h, 6, 0C3h, 2Bh, 0DBh
	db	2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h
	db	23h, 0DBh, 't1K', 0D1h, 0E3h, 0D1h, 0E3h, 3, 1Eh, 30h, 5, 8Eh
	db	6, 98h, 7, 26h, 8Bh, 1Fh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h
	db	0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 8Bh, 7, 33h, 0C9h
	db	80h, 3Ch, 0, 75h, 8, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 0EBh, 25h
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah
	db	1Ch, 46h, 56h, 0E8h, 8Dh, 0FEh, 5Eh, 83h, 0FBh, 1, 75h, 0Ch, 8Ah
	db	5Dh, 8, 80h, 0E3h, 0F8h, 80h, 0CBh, 1, 8, 5Dh, 8, 89h, 45h, 6
	db	0ADh, 3, 0C1h, 89h, 45h, 4, 0C3h, 0ADh, 0C7h, 45h, 6, 0, 0, 89h
	db	45h, 4, 0C3h, 0ACh, 98h, 0EBh, 0F3h, 8Bh, 36h, 0E0h, 3, 0E9h, 36h
	db	0FFh, 56h, 0E8h, 58h, 0FCh, 5Eh, 83h, 3Eh, 30h, 2, 1, 74h, 66h
	db	83h, 2Eh, 83h, 3, 16h, 7Ch, 5Ch, 8Bh, 1Eh, 83h, 3, 8Eh, 6, 6Dh
	db	3, 0ADh, '&+G', 8, 26h, 89h, 47h, 0Ah, 0A1h, 97h, 3, 26h, 1, 47h
	db	8, 56h, 26h, 8Bh, 47h, 0Ch, 26h, 8Bh, 57h, 0Eh, 8Bh, 0F3h, 0B9h
	db	0Ch, 0, 0BBh, 6Dh, 3, 0E8h, 70h, 5Bh, 0FFh, 0Eh, 78h, 1, 83h, 3Eh
	db	0A8h, 3, 0, 74h, 23h, 8Bh, 36h, 83h, 3, 8Eh, 6, 6Dh, 3, 0B9h, 4
	db	0, 26h, 8Bh, 44h, 10h, 48h, 0F7h, 0E1h, 3, 6, 41h, 3, 13h, 16h
	db	43h, 3, 83h, 0C6h, 12h, 0BBh, 6Dh, 3, 0E8h, 'B[^', 0C3h, 0E8h
	db	0D5h, 58h, 0FFh, 0Eh, 78h, 1, 8Bh, 36h, 0E0h, 3, 0EBh, 0F2h, 0FFh
	db	6, 0F4h, 4, 8Bh, 1Eh, 0F4h, 4, 89h, 1Eh, 9Bh, 3, 0BFh, 90h, 2
	db	8Bh, 0DFh, 1Eh, 7, 0ABh, 0A5h, 0A5h, 56h, 8Bh, 0F3h, 0B9h, 6, 0
	db	0BDh, 7Eh, 4, 0BBh, 11h, 3, 0E8h, 0B5h, 23h, 5Eh, 0C3h, 0C7h, 6
	db	7Ah, 1, 0FFh, 0FFh, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh
	db	80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 23h, 0DBh, 75h, 0Bh, 0B8h, 1, 0
	db	0E8h, 73h, 0F8h, 0E8h, 0B7h, 0FFh, 0EBh, 0Ch, 3, 1Eh, 9Fh, 3, 89h
	db	1Eh, 9Bh, 3, 8Bh, 36h, 0E0h, 3, 0C3h, 8Bh, 36h, 0E0h, 3, 0C3h
	db	0ACh, 22h, 0C0h, 74h, 49h, 0ACh, 98h, 22h, 0C0h, 79h, 5, 2Ch, 80h
	db	8Ah, 0E0h, 0ACh, 1, 6, 10h, 5, 8Bh, 0C8h, 1Eh, 7, 0BFh, 90h, 2
	db	0ACh, 98h, 22h, 0C0h, 79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 3, 6
	db	9Fh, 3, 0ABh, 0A5h, 0ACh, 0B4h, 0, 0ABh, 51h, 33h, 0C0h, 0E8h
	db	26h, 0F8h, 56h, 0BEh, 90h, 2, 89h, 44h, 6, 0B9h, 8, 0, 0BBh, 3Dh
	db	3, 0BDh, 7Eh, 4, 0E8h, '4#^Y', 0E2h, 0C9h, 0C3h, 2Bh, 0DBh, 2
	db	1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 53h
	db	0BFh, 90h, 2, 0A1h, 0A5h, 3, 89h, 45h, 6, 0A1h, 9Dh, 3, 89h, 45h
	db	4, 0A1h, 0E6h, 4, 40h, 0A3h, 9Dh, 3, 0ADh, 89h, 45h, 8, 0ACh, 88h
	db	45h, 0Ah, 0A1h, 0Ch, 5, 40h, 89h, 5, 0ACh, 98h, 22h, 0C0h, 79h
	db	5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 89h, 45h, 2, 1, 6, 0Ch, 5, 8Bh, 0C8h
	db	'XVQ', 3, 6, 0A1h, 3, 48h, 0B9h, 0Bh, 0, 0F7h, 0E1h, 3, 6, 35h
	db	3, 13h, 16h, 37h, 3, 0BEh, 90h, 2, 0BBh, 7Eh, 4, 0E8h, '"ZY^'
	db	0E3h, 1Ch, 8Bh, 0DEh, 8Bh, 0D1h, 0A1h, 0A1h, 3, 1, 7, 43h, 43h
	db	0E2h, 0FAh, 53h, 8Bh, 0CAh, 0D1h, 0E1h, 0BBh, 39h, 3, 0BDh, 7Eh
	db	4, 0E8h, 0AAh, 22h, 5Eh, 0FFh, 6, 0Ah, 5, 0C3h, 0E8h, 92h, 0F7h
	db	23h, 0C0h, 75h, 3, 0B8h, 0FFh, 0FFh, 8Eh, 6, 6Dh, 3, 26h, 0A3h
	db	6, 0, 0C3h, 80h, 3Eh, 2Fh, 1, 1, 'tK+', 0DBh, 2, 1Ch, 7Dh, 8, 46h
	db	80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 81h, 0FBh, 0, 40h, 7Fh
	db	3Ch, 4Bh, 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 8Eh
	db	6, 80h, 7, 26h, 8Bh, 57h, 6, 0C4h, 3Eh, 0B2h, 3, 26h, 89h, 1Dh
	db	47h, 47h, 8Bh, 0Eh, 0E0h, 3, 2Bh, 0CEh, 0D1h, 0E9h, 26h, 89h, 0Dh
	db	47h, 47h, 0E3h, 0Ah, 0ADh, 3, 0C2h, 0ABh, 89h, 3Eh, 0B2h, 3, 0E2h
	db	0F6h, 0C3h, 8Bh, 36h, 0E0h, 3, 0EBh, 0F9h, 81h, 0EBh, 1, 40h, 0D1h
	db	0E3h, 3, 1Eh, 2Eh, 5, 8Eh, 6, 88h, 7, 26h, 8Bh, 1Fh, 53h, 83h
	db	0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7
	db	5Bh, 26h, 8Bh, 47h, 2, 3Bh, 6, 28h, 2, 75h, 5, 26h, 8Bh, 1Fh, 0EBh
	db	0A0h, 8Bh, 36h, 0E0h, 3, 0EBh, 0C4h, 0D1h, 26h, 9Fh, 27h, 5Bh
	db	27h, 7Bh, 2Ah, 0E3h, '+V-', 0F9h, '-*.*.*.*./.', 1Bh, '/*.*.*.*.*.*.*.*.*.'
	db	8, 2Fh, 0ADh, 80h, 3Eh, 17h, 0, 0, 74h, 26h, 80h, '>xR', 0, 75h
	db	1Fh, 8Ah, 0DCh, 32h, 0FFh, 81h, 0EBh, 0E2h, 0, 7Ch, 15h, 83h, 0FBh
	db	17h, 73h, 10h, 0D1h, 0E3h, 2Eh, 0FFh, 97h, 0A8h, '/;6', 0E0h, 3
	db	74h, 3, 0E8h, 99h, 56h, 0E9h, 0CAh, 27h, 50h, 0ADh, 93h, 8Bh, 3Eh
	db	0ECh, 3, 23h, 0FFh, 74h, 5, 0ADh, 97h, 0EBh, 1, 5Eh, 56h, 0ADh
	db	0Bh, 0C0h, 74h, 19h, 57h, 53h, 0E8h, 0E5h, 0FFh, 48h, 75h, 0FAh
	db	5Bh, 5Fh, 83h, 0EBh, 1, 83h, 0DFh, 0, 75h, 0E7h, 0Bh, 0DBh, 75h
	db	0E3h, 0EBh, 1Bh, '^VWS', 0ACh, 0B4h, 0, 91h, 0E8h, 1Dh, 59h, 91h
	db	5Bh, 5Fh, 83h, 0EBh, 1, 83h, 0DFh, 0, 75h, 0EAh, 0Bh, 0DBh, 75h
	db	0E6h, 'XXX', 0C3h, 56h, 80h, 3Eh, 0F1h, 3, 0FFh, 74h, 74h, 8Bh
	db	0Eh, 0E4h, 3, 0BEh, 50h, 0Ah, 8Bh, 0D9h, 8Ah, 40h, 0FFh, 0A2h
	db	14h, 2, 8Bh, 1Eh, 0E8h, 3, 8Bh, 0D1h, 3, 0D3h, 89h, 16h, 12h, 2
	db	8Bh, 16h, 0E6h, 3, 89h, 16h, 10h, 2, 2Bh, 0C0h, 86h, 6, 4Eh, 0Ah
	db	3, 0C8h, 2Bh, 0F0h, 2Bh, 0D8h, 0A1h, 0EEh, 3, 3, 6, 0FEh, 3, 8Ah
	db	16h, 0F0h, 3, 0B6h, 0, 12h, 0D6h, 0D1h, 0E0h, 0D1h, 0D2h, 0D1h
	db	0E0h, 0D1h, 0D2h, 0D1h, 0E0h, 0D1h, 0D2h, 0D1h, 0E0h, 0D1h, 0D2h
	db	3, 0C3h, 13h, 16h, 0EAh, 3, 80h, 3Eh, 0F1h, 3, 1, 74h, 0Ah, 0E8h
	db	0A4h, 58h, 5Eh, 0C6h, 6, 0F1h, 3, 0FFh, 0C3h, 91h, 5, 50h, 0Ah
	db	0EBh, 3, 0E8h, 3Eh, 0FFh, 3Bh, 0F0h, 72h, 0F9h, 0EBh, 0EAh, 0C7h
	db	6, 10h, 2, 0FFh, 0FFh, 0EBh, 0E2h, 'WVP', 8Bh, 3Eh, 0E6h, 3, 8Eh
	db	6, 80h, 7, 26h, 8Bh, 3Dh, 8Eh, 6, 0A0h, 7, 26h, 80h, 7Dh, 1, 1
	db	74h, 7, 26h, 80h, 7Dh, 1, 3, 'uq&;]', 4, 75h, 6Bh, 0BFh, 0FFh
	db	3, 23h, 0FAh, 74h, 4Bh, 8Ah, 85h, 4Fh, 0Ah, 8Bh, 0B5h, 50h, 0Ah
	db	3Ch, 9Ah, 74h, 11h, 3Ch, 0EAh, 75h, 54h, 0C7h, 85h, 4Fh, 0Ah, 90h
	db	90h, 0C6h, 85h, 51h, 0Ah, 0E9h, 0EBh, 0Bh, 0C7h, 85h, 4Fh, 0Ah
	db	90h, 0Eh, 0C6h, 85h, 51h, 0Ah, 0E8h, 0Bh, 0FFh, 75h, 5, 0C6h, 6
	db	4Eh, 0Ah, 1, 81h, 0C2h, 2, 0F8h, 89h, 0B5h, 52h, 0Ah, 2Bh, 0CFh
	db	83h, 0E9h, 4, 2Bh, 0Eh, 0E8h, 3, 0C7h, 6, 1Ch, 2, 0FFh, 0FFh, 0F9h
	db	0EBh, 1Ah, 8Bh, 36h, 10h, 2, 3Bh, 36h, 0E6h, 3, 75h, 0Fh, 8Bh
	db	36h, 12h, 2, 3Bh, 36h, 0E8h, 3, 75h, 5, 0A0h, 14h, 2, 0EBh, 0A0h
	db	0F8h, 'X^_', 0C3h, 0BFh, 0FFh, 3, 23h, 0FAh, 8Eh, 6, 80h, 7, 26h
	db	8Bh, 5Fh, 4, 83h, 3Eh, 1Ch, 2, 0, 74h, 0Ch, 83h, 0BDh, 50h, 0Ah
	db	0, 75h, 5, 8Bh, 0Eh, 1Ch, 2, 0C3h, 3, 8Dh, 50h, 0Ah, 26h, 8Bh
	db	77h, 4, 0EBh, 4, 26h, 8Bh, 74h, 0Ah, 83h, 0FEh, 0FFh, 't V', 83h
	db	0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7
	db	'^&;L', 4, 75h, 0E2h, 0C7h, 85h, 50h, 0Ah, 0, 0, 26h, 8Bh, 4Ch
	db	8, 0C3h, 2Bh, 8Dh, 50h, 0Ah, 0C3h, 31h, 32h, 0E5h, '152', 17h
	db	'212)21212WVP', 0B8h, 1Ch, 0, 22h, 0C6h, 0D1h, 0E8h, 97h, 2Eh
	db	0FFh, 0A5h, 0C5h, 31h, 0A1h, 50h, 4, 8Eh, 6, 78h, 7, '&;G', 2
	db	74h, 3Fh, 8Bh, 3Eh, 0E6h, 3, 8Eh, 6, 80h, 7, 26h, 8Bh, 3Dh, 8Eh
	db	6, 0A0h, 7, 26h, 80h, 7Dh, 1, 1, 74h, 7, 26h, 80h, 7Dh, 1, 3, 'u"&;]'
	db	4, 75h, 14h, 0EBh, 1Ah, 0A1h, 50h, 4, 8Eh, 6, 78h, 7, '&;G', 2
	db	74h, 24h, 0E8h, 0B0h, 0FEh, 72h, 8, 0E8h, 41h, 0FFh, 83h, 0FEh
	db	0FFh, 't!X^_', 0C3h, 0A1h, 50h, 4, 8Eh, 6, 78h, 7, '&;G', 2, 75h
	db	6, 0C7h, 6, 16h, 2, 0FFh, 0FFh, 8Eh, 6, 80h, 7, 26h, 8Bh, 5Fh
	db	4, 0EBh, 0DFh, 56h, 8Bh, 36h, 0E6h, 3, 8Eh, 6, 78h, 7, 26h, 8Bh
	db	34h, 0BFh, 28h, 0, 0E8h, 0DCh, 64h, 0A1h, 24h, 2, 25h, 0FFh, 3
	db	3, 6, 0E8h, 3, 0BFh, 78h, 0, 50h, 8Ah, 0C4h, 0E8h, 0CDh, 62h, 58h
	db	0E8h, 0C9h, 62h, 0C6h, 5, 0, 2Eh, 8Eh, 1Eh, 10h, 0, 0C7h, 6, 22h
	db	4, 1, 0, 1Eh, 0B8h, 78h, 0, 50h, 1Eh, 0B8h, 28h, 0, 50h, 0B9h
	db	8, 0, 51h, 0B8h, 34h, 0, 50h, 0E8h, 0Dh, 89h, 5Eh, 0EBh, 90h, 'PSV&'
	db	8Bh, 47h, 0Ch, 0BEh, 60h, 4, 0BBh, 9, 0, 3Bh, 4, 74h, 0Ah, 83h
	db	0C6h, 2, 4Bh, 75h, 0F6h, '^[X', 0C3h, 33h, 0C9h, 89h, 0Eh, 20h
	db	4, 80h, 0Eh, 15h, 2, 40h, 0A3h, 4Ah, 2, 0EBh, 0ECh, 89h, 16h, 24h
	db	2, 33h, 0C0h, 0A3h, 1Ch, 2, 0A3h, 1Eh, 2, 0A3h, 20h, 2, 0A2h, 15h
	db	2, 0A3h, 20h, 4, 48h, 0A3h, 18h, 2, 0A3h, 1Ah, 2, 0ACh, 8Ah, 0E0h
	db	24h, 0F0h, 78h, 17h, '<0s*+', 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh
	db	80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 8Bh, 0EBh, 0EBh, 1Ch, 0D0h, 0E8h
	db	0D0h, 0E8h, 0D0h, 0E8h, 8Bh, 0D8h, 83h, 0E3h, 6, 8Bh, 0AFh, 42h
	db	2, 0D1h, 0EBh, 8Ah, 87h, 3Eh, 2, 0EBh, 5, 77h, 3, 95h, 0ADh, 95h
	db	0F6h, 0C4h, 8, 75h, 30h, 0F6h, 0C4h, 4, 75h, 65h, 80h, 0E4h, 3
	db	80h, 0FCh, 3, 'tL+', 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h
	db	8Ah, 0FBh, 8Ah, 1Ch, 46h, 91h, 0ADh, 91h, 83h, 3Eh, 1Eh, 4, 0
	db	74h, 5Dh, 0FFh, '4FF', 8Fh, 6, 20h, 4, 0EBh, 53h, 2Bh, 0C9h, 0F6h
	db	0C4h, 4, 75h, 11h, 91h, 0ADh, 91h, 83h, 3Eh, 1Eh, 4, 0, 74h, 7
	db	93h, 0ADh, 93h, 89h, 1Eh, 20h, 4, 8Ah, 0DCh, 83h, 0E3h, 3, 8Ah
	db	0A7h, 32h, 2, 0D1h, 0E3h, 8Bh, 9Fh, 36h, 2, 0EBh, 2Ah, 8Bh, 1Ch
	db	8Bh, 4Ch, 2, 83h, 0C6h, 4, 0EBh, 20h, 8Bh, 1Ch, 83h, 0C6h, 2, 0EBh
	db	19h, 2Bh, 0C9h, 80h, 0E4h, 3, 80h, 0FCh, 3, 74h, 0EFh, 2Bh, 0DBh
	db	2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h
	db	80h, 0FCh, 2, 74h, 9, 77h, 0Ah, 0Ah, 0E4h, 74h, 0Ch, 0E9h, 8Ah
	db	0, 0E9h, 19h, 1, 0E9h, 0E4h, 1, 0E9h, 29h, 5, 81h, 0FBh, 0, 40h
	db	7Eh, 3, 0E9h, 6, 1, 80h, 0Eh, 15h, 2, 4, 3Bh, 1Eh, 3Dh, 5, 77h
	db	0E9h, 4Bh, 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 8Eh
	db	6, 80h, 7, 26h, 3, 4Fh, 6, 97h, 26h, 8Ah, 47h, 8, 0B4h, 0, 11h
	db	6, 20h, 4, 97h, 8Eh, 6, 78h, 7, 26h, 0F6h, 47h, 9, 0E0h, 74h, 0Fh
	db	8Eh, 6, 80h, 7, 26h, 8Bh, 7Fh, 2, 80h, 0Eh, 15h, 2, 10h, 0EBh
	db	7Ah, 80h, 0Eh, 15h, 2, 1, 0C7h, 6, 1Ch, 2, 0FFh, 0FFh, 8Eh, 6
	db	80h, 7, 26h, 8Bh, 3Fh, 0E9h, 8Ch, 1, 26h, 8Bh, 1Fh, 53h, 83h, 0E3h
	db	3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h
	db	8Bh, 1Fh, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 7Fh, 4, 0EBh, 46h, 4Bh, 0D1h
	db	0E3h, 0D1h, 0E3h, 3, 1Eh, 30h, 5, 8Eh, 6, 98h, 7, 80h, 3Eh, 19h
	db	0, 1, 74h, 0CDh, 26h, 8Bh, 3Fh, 26h, 8Bh, 5Fh, 2, 57h, 83h, 0E7h
	db	3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 18h, 7, 5Fh, 26h
	db	8Bh, 3Dh, 89h, 3Eh, 2Eh, 2, 8Eh, 6, 80h, 7, 26h, 8Bh, '?;>.', 2
	db	75h, 47h, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 7Dh, 4, 0F6h, 0C6h, 40h, 74h
	db	3, 0E9h, 1Fh, 1, 0C7h, 6, 1Ch, 2, 0FFh, 0FFh, 50h, 0B8h, 0FFh
	db	3, 23h, 0C2h, 52h, 8Bh, 16h, 0EAh, 3, 3, 6, 0E8h, 3, 83h, 0D2h
	db	0, 5, 2, 0, 83h, 0D2h, 0, 83h, 3Eh, 1Eh, 4, 0, 74h, 6, 5, 2, 0
	db	83h, 0D2h, 0, 0A3h, 1Eh, 2, 89h, 16h, 20h, 2, 5Ah, 58h, 0E9h, 0E8h
	db	0, 26h, 8Bh, 7Fh, 2, 0EBh, 0BBh, 0E9h, 0E8h, 4, 81h, 0EBh, 0, 40h
	db	4Bh, 0D1h, 0E3h, 3, 1Eh, 2Eh, 5, 8Eh, 6, 88h, 7, 26h, 8Bh, 1Fh
	db	89h, 1Eh, 1Ah, 2, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 0FFh, 77h, 0Ch, 8Fh, 6, 18h
	db	2, 26h, 0F6h, 47h, 0Eh, 10h, 75h, 0C9h, 26h, 83h, 3Fh, 0FFh, 74h
	db	0C3h, 26h, 3, 4Fh, 4, 26h, 8Bh, 7Fh, 6, 11h, 3Eh, 20h, 4, 0F6h
	db	0C6h, 40h, 74h, 0Fh, 26h, 8Bh, 7Fh, 8, 83h, 0FFh, 0FFh, 89h, 3Eh
	db	1Ch, 2, 74h, 36h, 0EBh, 42h, 0C7h, 6, 1Ch, 2, 0FFh, 0FFh, 50h
	db	0B8h, 0FFh, 3, 23h, 0C2h, 52h, 8Bh, 16h, 0EAh, 3, 3, 6, 0E8h, 3
	db	83h, 0D2h, 0, 5, 2, 0, 83h, 0D2h, 0, 83h, 3Eh, 1Eh, 4, 0, 74h
	db	6, 5, 2, 0, 83h, 0D2h, 0, 0A3h, 1Eh, 2, 89h, 16h, 20h, 2, 'ZX&'
	db	0F6h, 47h, 0Eh, ' u&&', 0F6h, 47h, 0Eh, 2, 'u)&', 8Bh, 3Fh, 8Eh
	db	6, 80h, 7, 26h, 8Bh, 1Dh, 8Eh, 6, 78h, 7, 26h, 0F6h, 45h, 9, 0E0h
	db	74h, 21h, 8Eh, 6, 80h, 7, 26h, 8Bh, 7Dh, 2, 0EBh, 24h, 26h, 8Bh
	db	4Fh, 2, 0BBh, 0FDh, 0FFh, 0E9h, 8Ah, 2, 80h, 3Eh, 19h, 0, 0, 74h
	db	3, 0E8h, 2, 0FDh, 26h, 8Bh, 1Fh, 80h, 0Eh, 15h, 2, 1, 0C7h, 6
	db	1Ch, 2, 0FFh, 0FFh, 8Bh, 0FBh, 8Bh, 0DDh, '< v', 3, 0E9h, 1, 1
	db	75h, 3, 0E9h, 8, 1, 0Ah, 0C0h, 75h, 63h, 81h, 0FBh, 0, 40h, 7Eh
	db	3, 0E9h, 0F7h, 0, 3Bh, 1Eh, 3Dh, 5, 'wGK', 93h, 0B4h, 0Ah, 0F6h
	db	0E4h, 93h, 3, 1Eh, 2Ch, 5, 8Eh, 6, 78h, 7, 26h, 0F6h, 47h, 9, 0E0h
	db	74h, 34h, 8Eh, 6, 80h, 7, 26h, 8Bh, 5Fh, 2, 80h, 3Eh, 19h, 0, 1
	db	75h, 3, 0E9h, 5Dh, 1, 80h, 0Eh, 15h, 2, 4, 26h, 8Bh, 47h, 6, 24h
	db	0F0h, 2Bh, 0C8h, 26h, 8Ah, 47h, 8, 0B4h, 0, 19h, 6, 20h, 4, 80h
	db	0Eh, 15h, 2, 10h, 0E9h, 3Eh, 1, 0E9h, 0D0h, 2, 8Eh, 6, 80h, 7
	db	26h, 8Bh, 1Fh, 0E9h, 0DDh, 0, 4Bh, 7Dh, 3, 0E9h, 8Bh, 0, 0D1h
	db	0E3h, 0D1h, 0E3h, 3, 1Eh, 30h, 5, 8Eh, 6, 98h, 7, 80h, 3Eh, 19h
	db	0, 1, 'tWW&', 8Bh, 3Fh, 26h, 8Bh, 5Fh, 2, 57h, 83h, 0E7h, 3, 0D1h
	db	0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 18h, 7, 5Fh, 26h, 8Bh
	db	3Dh, 89h, 3Eh, 2Eh, 2, 8Eh, 6, 80h, 7, 26h, 8Bh, '?;>.', 2, 75h
	db	6, 8Bh, 0DFh, 5Fh, 0E9h, 0D1h, 0, 5Fh, 0F6h, 6, 15h, 2, 1, 74h
	db	3, 0E9h, 0E2h, 1, 26h, 8Bh, 1Fh, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 5Fh
	db	4, 8Eh, 6, 80h, 7, 26h, 8Bh, 7Dh, 2, 80h, 0Eh, 15h, 2, 4, 0E9h
	db	0C1h, 0, 26h, 8Bh, 1Fh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h
	db	0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 8Bh, 1Fh, 80h, 0Eh, 15h
	db	2, 10h, 8Eh, 6, 80h, 7, 0E9h, 8Ah, 0, 43h, 0E9h, 71h, 0FFh, '<@terB'
	db	0EBh, 4Ah, 81h, 0EBh, 0, 40h, 4Bh, 0D1h, 0E3h, 3, 1Eh, 2Eh, 5
	db	8Eh, 6, 88h, 7, 26h, 8Bh, 1Fh, 89h, 1Eh, 1Ah, 2, 53h, 83h, 0E3h
	db	3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h
	db	0FFh, 77h, 0Ch, 8Fh, 6, 18h, 2, 26h, 0F6h, 47h, 0Eh, 10h, 75h
	db	13h, 26h, 0F6h, 47h, 0Eh, 2, 26h, 8Bh, 1Fh, 75h, 2, 0EBh, 2Ch
	db	80h, 0Eh, 15h, 2, 2, 0EBh, 4Dh, 0E9h, 0ADh, 2, 8Bh, 0DFh, 0A0h
	db	15h, 2, 0A8h, 1, 75h, 0EDh, 80h, 3Eh, 19h, 0, 1, 74h, 3Ah, 0A8h
	db	4, 74h, 36h, 0E9h, 0B9h, 0FEh, 0F6h, 6, 15h, 2, 1, 75h, 0E2h, 8Bh
	db	1Eh, 0E6h, 3, 8Eh, 6, 78h, 7, 26h, 0F6h, 47h, 9, 0E0h, 8Eh, 6
	db	80h, 7, 26h, 8Bh, 1Fh, 74h, 0C2h, 26h, 8Bh, 3Dh, 8Eh, 6, 0A0h
	db	7, 26h, 8Bh, 5Fh, 4, 0F6h, 6, 15h, 2, 1, 75h, 4, 26h, 8Bh, 7Dh
	db	4, 0A0h, 15h, 2, 0A8h, 3, 74h, 3, 0E9h, 0FFh, 0, 8Eh, 6, 80h, 7
	db	3Bh, 0DFh, 74h, 3, 0E9h, 16h, 1, 80h, 3Eh, 19h, 0, 0, 't#+', 0Eh
	db	1Eh, 2, 52h, 8Bh, 16h, 20h, 4, 1Bh, 16h, 20h, 2, 89h, 16h, 20h
	db	4, 5Ah, 0B0h, 1Ch, 22h, 0C6h, 3Ch, 0Ch, 74h, 3, 0E9h, 91h, 0, 0E8h
	db	46h, 0F9h, 0E9h, 8Bh, 0, 2Bh, 0Eh, 1Eh, 2, 52h, 8Bh, 16h, 20h
	db	4, 1Bh, 16h, 20h, 2, 89h, 16h, 20h, 4, 5Ah, 52h, 8Bh, 16h, 1Eh
	db	2, 0Bh, 16h, 20h, 2, 'Zt%WS&', 8Bh, 3Fh, 8Bh, 1Eh, 0E6h, 3, 26h
	db	8Bh, 1Fh, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 5Fh, 8, 26h, 8Bh, 7Dh, 8
	db	2Bh, 0DFh, 81h, 0FBh, 0, 10h, '[_r', 3, 0E9h, 84h, 0, 80h, 3Eh
	db	27h, 1, 0, 74h, 6, 0C7h, 6, 1Ch, 2, 0FFh, 0FFh, 8Eh, 6, 78h, 7
	db	26h, 8Bh, 7Fh, 2, ';>P', 4, 74h, 17h, 83h, 3Eh, 1Ch, 2, 0FFh, 't&&'
	db	8Bh, 7Fh, 2, ';>N', 4, 74h, 6, ';>P', 4, 75h, 16h, 0A8h, 4, 74h
	db	0Fh, 8Eh, 6, 80h, 7, 26h, 0F7h, 47h, 6, 0F0h, 0FFh, 74h, 3, 0E8h
	db	0Ah, 0, 0E8h, 0B6h, 0F9h, 0BFh, 0FFh, 3, 23h, 0FAh, 0F8h, 0C3h
	db	8Eh, 6, 80h, 7, 26h, 8Bh, 3Fh, 8Eh, 6, 0A0h, 7, 26h, 80h, 7Dh
	db	1, 1, 72h, 22h, 80h, 26h, 15h, 2, 0FBh, 26h, 8Bh, 7Dh, 4, 8Eh
	db	6, 80h, 7, 26h, 8Bh, 47h, 6, 24h, 0F0h, 3, 0C8h, 26h, 8Ah, 47h
	db	8, 0B4h, 0, 11h, 6, 20h, 4, 8Bh, 0DFh, 0C3h, 5Fh, 0E9h, 8Ch, 0
	db	2Bh, 0EDh, 24h, 3, 3Ch, 2, 74h, 0F5h, 0EBh, 0B7h, 3Bh, 0DFh, 75h
	db	14h, 2Bh, 0Eh, 1Eh, 2, 52h, 8Bh, 16h, 20h, 4, 1Bh, 16h, 20h, 2
	db	89h, 16h, 20h, 4, 5Ah, 0EBh, 9Fh, 80h, 3Eh, 19h, 0, 0, 75h, 0D4h
	db	26h, 83h, 7Dh, 4, 0FFh, 75h, 0CDh, 26h, 8Bh, 7, 26h, 3Bh, 5, 75h
	db	27h, 26h, 8Bh, 45h, 6, '&+G', 6, 26h, 8Ah, 45h, 8, 26h, 1Ah, 47h
	db	8, 72h, 3, 0E9h, 0E9h, 0FEh, 26h, 3, 4Fh, 6, '&+M', 6, 26h, 12h
	db	4Fh, 8, 26h, 1Ah, 4Dh, 8, 0EBh, 9Eh, 'SW&', 8Bh, 3Dh, 26h, 8Bh
	db	1Fh, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 45h, 8, '&+G', 8, 5Fh, 5Bh, 0F6h
	db	0C4h, 0F0h, 75h, 83h, 0D1h, 0E0h, 0D1h, 0E0h, 0D1h, 0E0h, 0D1h
	db	0E0h, 3, 0C8h, 72h, 3, 0E9h, 0ADh, 0FEh, 0E9h, 71h, 0FFh, 'RVWQ3'
	db	0D2h, 0A1h, 24h, 2, 25h, 0FFh, 3, 3, 6, 0E8h, 3, 13h, 16h, 0EAh
	db	3, 8Bh, 36h, 0E6h, 3, 8Eh, 6, 80h, 7, '&+D', 6, 26h, 1Ah, 54h
	db	8, 50h, 80h, 3Eh, 27h, 1, 0, 74h, 1, 52h, 8Bh, 36h, 0E6h, 3, 8Eh
	db	6, 78h, 7, 26h, 8Bh, 34h, 0BFh, 0C8h, 0, 0E8h, 18h, 5Eh, 0B8h
	db	0C8h, 0, 1Eh, 50h, 0B8h, 0A0h, 24h, 80h, 3Eh, 27h, 1, 0, 74h, 3
	db	0B8h, 0A6h, 24h, 0Eh, 50h, 0B8h, 28h, 0, 1Eh, 50h, 0Eh, 0E8h, 0ABh
	db	81h, 8Bh, 36h, 18h, 2, 46h, 74h, 0Ch, 4Eh, 0BFh, 78h, 0, 0E8h
	db	0EDh, 5Dh, 83h, 0C4h, 4, 0EBh, 41h, 58h, 8Bh, 16h, 20h, 4, 3, 6
	db	1Eh, 2, 13h, 16h, 20h, 2, 5Eh, 50h, 80h, 3Eh, 27h, 1, 0, 74h, 1
	db	52h, 8Eh, 6, 78h, 7, 26h, 8Bh, 34h, 0BFh, 0C8h, 0, 0E8h, 0C4h
	db	5Dh, 0B8h, 0C8h, 0, 1Eh, 50h, 0B8h, 0A0h, 24h, 80h, 3Eh, 27h, 1
	db	0, 74h, 3, 0B8h, 0A6h, 24h, 0Eh, 50h, 1Eh, 0B8h, 78h, 0, 50h, 0Eh
	db	0E8h, 57h, 81h, 0B8h, 78h, 0, 1Eh, 50h, 0B8h, 28h, 0, 1Eh, 50h
	db	0B8h, 8, 0, 50h, 0B8h, 23h, 0, 50h, 0C7h, 6, 22h, 4, 1, 0, 0E8h
	db	0F2h, 81h, 5Eh, 5Ah, 0EBh, 4Ah, 26h, 0F6h, 47h, 0Eh, '@uC&', 80h
	db	4Fh, 0Eh, 40h, 8Bh, 1Eh, 18h, 2, 53h, 56h, 8Bh, 0F3h, 0BFh, 28h
	db	0, 1Eh, 57h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h
	db	8Eh, 84h, 18h, 7, 5Eh, 26h, 80h, 7Ch, 3, 40h, 74h, 5, 0E8h, 56h
	db	5Dh, 0EBh, 3, 0E8h, 0F9h, 5Bh, 0C7h, 6, 22h, 4, 1, 0, 0B9h, 4
	db	0, 51h, 0B8h, 26h, 0, 50h, 0E8h, 0A6h, 81h, 5Eh, 5Bh, 0F9h, 0C3h
	db	50h, 6, 8Eh, 6, 75h, 3, 26h, 8Bh, 4, 26h, 3Bh, 5, 75h, 2, 3Bh
	db	0F7h, 7, 58h, 0C3h, 55h, 0E8h, 97h, 0EFh, 0BBh, 0A0h, 2, 0BFh
	db	0DAh, 4, 8Bh, 0Eh, 8Dh, 3, 8Bh, 45h, 0Eh, 40h, 0E3h, 5, 2Bh, 0C1h
	db	91h, 0EBh, 2, 33h, 0C9h, 89h, 47h, 4, 89h, 4Fh, 6, 0A1h, 0A6h
	db	2, 23h, 0C0h, 75h, 3, 0A3h, 0A4h, 2, 8Bh, 36h, 65h, 3, 89h, 36h
	db	0AEh, 2, 0BEh, 0A0h, 2, 0B9h, 10h, 0, 0BDh, 7Eh, 4, 0BBh, 0Dh
	db	3, 0E8h, 53h, 17h, 83h, 3Eh, 14h, 5, 0, 74h, 1Fh, 0BEh, 0B0h, 2
	db	0A1h, 56h, 5, 89h, 44h, 2, 0A1h, 54h, 5, 89h, 44h, 6, 1, 6, 0A1h
	db	3, 0B9h, 8, 0, 0BDh, 7Eh, 4, 0BBh, 45h, 3, 0E8h, 2Dh, 17h, 0A1h
	db	0E4h, 4, 2Dh, 17h, 0, 8Bh, 1Eh, 8Fh, 3, 0A3h, 8Fh, 3, 2Bh, 0C3h
	db	33h, 0D2h, 0D1h, 0E0h, 0D1h, 0D2h, 0D1h, 0E0h, 0D1h, 0D2h, 0D1h
	db	0E0h, 0D1h, 0D2h, 1, 6, 21h, 3, 11h, 16h, 23h, 3, 83h, 3Eh, 50h
	db	5, 0, 75h, 3, 0E9h, 99h, 0, 83h, 3Eh, 65h, 3, 0, 75h, 3, 0E9h
	db	8Fh, 0, 8Bh, 0Eh, 65h, 3, 83h, 0F9h, 1, 76h, 0Ch, 0D1h, 0E1h, 0BDh
	db	4, 3Ah, 8Eh, 6, 79h, 3, 0E8h, 90h, 54h, 0A1h, 0F8h, 4, 40h, 8Bh
	db	0Eh, 65h, 3, 1, 0Eh, 0F8h, 4, 33h, 0F6h, 8Eh, 6, 79h, 3, 26h, 8Bh
	db	3Ch, 8Eh, 6, 75h, 3, 26h, 8Bh, 1Dh, 8Bh, 0EBh, 4Bh, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 6, 71h, 3, 26h, 89h, 47h
	db	0Ch, 8Eh, 6, 75h, 3, 1Eh, 8Eh, 1Eh, 79h, 3, 0BAh, 1, 0, 49h, 74h
	db	0Ch, 46h, 46h, 8Bh, '<&;-u', 3, 42h, 0E2h, 0F4h, 1Fh, 8Eh, 6, 71h
	db	3, 26h, 89h, 57h, 0Eh, 3, 0C2h, 41h, 0E2h, 0B6h, 8Bh, 0Eh, 65h
	db	3, 33h, 0DBh, 53h, 51h, 8Eh, 6, 79h, 3, 26h, 8Bh, 37h, 0B9h, 8
	db	0, 0BBh, 31h, 3, 0BDh, 75h, 3, 0E8h, 6Ch, 16h, 59h, 5Bh, 83h, 0C3h
	db	2, 0E2h, 0E4h, 8Bh, 0Eh, 5Eh, 5, 0E3h, 2, 0EBh, 3, 0E9h, 0A6h
	db	0, 33h, 0F6h, 33h, 0FFh, 51h, 8Eh, 6, 0B8h, 3, 26h, 89h, 35h, 8Eh
	db	6, 0B4h, 3, 26h, 8Bh, 54h, 2, 0D1h, 0E2h, 83h, 0C6h, 4, 3, 0F2h
	db	47h, 47h, 0E2h, 0E6h, 59h, 51h, 0BDh, 0EEh, 43h, 0D1h, 0E1h, 8Eh
	db	6, 0B8h, 3, 0E8h, 0DEh, 'SY3', 0FFh, 0BAh, 0FFh, 0FFh, 51h, 8Eh
	db	6, 0B8h, 3, 26h, 8Bh, 35h, 8Eh, 6, 0B4h, 3, 26h, 8Bh, 1Ch, 3Bh
	db	0DAh, 't*V', 8Bh, 0D3h, 52h, 0E8h, 85h, 0EEh, 33h, 0D2h, 8Bh, 0C6h
	db	0BBh, 10h, 0, 0F7h, 0F3h, 0D1h, 0E0h, 0BBh, 7Eh, 4, 0BEh, 0C4h
	db	3, 8Bh, 16h, 0C0h, 3, 3, 6, 0BEh, 3, 0B9h, 2, 0, 57h, 0E8h, 'FM_Z^RFF'
	db	8Eh, 6, 0B4h, 3, 26h, 8Bh, 0Ch, 1, 0Eh, 0C4h, 3, 0D1h, 0E1h, 46h
	db	46h, 0BBh, 0B4h, 3, 8Bh, 16h, 0BCh, 3, 0A1h, 0BAh, 3, 1, 0Eh, 0BAh
	db	3, 83h, 16h, 0BCh, 3, 0, 57h, 0E8h, 1Ah, 'M_ZYGG', 0E2h, 93h, 0C7h
	db	6, 0B2h, 3, 0, 0, 5Dh, 0C3h, 0FEh, 6, 94h, 4, 0E8h, 52h, 0F4h
	db	8Ah, 4, 3Ch, 0C1h, 74h, 3, 0E9h, 9Fh, 0, 83h, 3Eh, 0B2h, 4, 0FFh
	db	74h, 3, 0E9h, 95h, 0, 46h, 0BAh, 0, 0CCh, 0E8h, 0B1h, 0F6h, 8Eh
	db	6, 78h, 7, 56h, 8Bh, 0F3h, 0E8h, 'wV^<', 2, 7Ch, 0Ah, 33h, 0C9h
	db	51h, 0B8h, 27h, 0, 50h, 0E8h, 72h, 7Fh, 8Eh, 6, 80h, 7, 26h, 8Bh
	db	47h, 6, 26h, 8Bh, 1Fh, 8Eh, 6, 0A0h, 7, 80h, 3Eh, 19h, 0, 0, 74h
	db	6, 26h, 8Bh, 5Fh, 6, 0EBh, 13h, 26h, 8Bh, 5Fh, 8, 0F6h, 6, 15h
	db	2, 4, 74h, 8, 51h, 0B1h, 4, 0D3h, 0E8h, 3, 0D8h, 59h, 89h, 0Eh
	db	0B0h, 4, 89h, 1Eh, 0B2h, 4, 89h, 0Eh, 0B3h, 6, 89h, 1Eh, 0B5h
	db	6, 80h, 3Eh, 2Bh, 1, 1, 75h, 19h, 23h, 0DBh, 75h, 0Bh, 81h, 0F9h
	db	0, 1, 74h, 0Fh, 0E8h, 2, 54h, 75h, 0Ah, 33h, 0C0h, 50h, 0B8h, 15h
	db	0, 50h, 0E8h, 0Eh, 7Fh, 83h, 3Eh, 20h, 4, 0, 74h, 0Fh, 33h, 0C0h
	db	50h, 0B8h, 29h, 0, 50h, 0E8h, 2, 7Fh, 80h, 0Eh, 10h, 4, 1, 80h
	db	3Eh, 16h, 0, 0, 74h, 3, 0E8h, 64h, 0FDh, 80h, 3Eh, 0D2h, 3, 1
	db	'rPt!', 8Bh, 3Eh, 0E2h, 3, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h
	db	0E7h, 0D1h, 0E7h, 8Eh, 85h, 38h, 7, 5Fh, 26h, 83h, 7Dh, 0Ah, 2
	db	73h, 7, 8Bh, 3Eh, 28h, 2, 0E9h, 31h, 50h, 8Bh, 36h, 0E0h, 3, 46h
	db	1Eh, 7, 8Bh, 0Eh, 'XR+', 0CEh, 83h, 0F9h, 2, 73h, 5, 0E8h, 2Fh
	db	49h, 0EBh, 0F0h, 2Bh, 0C0h, 8Bh, 0FEh, 0D1h, 0E9h, 0F3h, 0AFh
	db	8Bh, 0F7h, 74h, 0E4h, 4Eh, 4Eh, 80h, 3Ch, 1, 13h, 0F0h, 0E9h, 0D0h
	db	1Ah, 0C3h, 56h, 83h, 3Eh, 9Bh, 3, 0FFh, 75h, 14h, 'PQRV', 0C7h
	db	6, 7Ah, 1, 0FFh, 0FFh, 0A1h, 2Ah, 2, 0E8h, 0AFh, 0F0h, '^ZYXS'
	db	8Bh, 1Eh, 0E0h, 3, 2Bh, 0DEh, 0D1h, 0EBh, 0D1h, 0EBh, 0Bh, 0D2h
	db	74h, 16h, 83h, 0C4h, 2, 3Bh, 16h, 7Ah, 1, 75h, 21h, 8Bh, 36h, 85h
	db	3, 83h, 0EEh, 8, 8Eh, 6, 75h, 3, 0EBh, 'lZPSQ', 0C7h, 6, 93h, 3
	db	0FFh, 0FFh, 0C7h, 6, 7Ah, 1, 0FFh, 0FFh, 8Bh, 0DAh, 0EBh, 18h
	db	89h, 16h, 7Ah, 1, 'PSQ', 8Bh, 0DAh, 89h, 1Eh, 93h, 3, 4Bh, 93h
	db	0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 0E8h, 0A9h, 0ECh, 8Bh
	db	36h, 85h, 3, 83h, 6, 85h, 3, 8, 8Eh, 6, 75h, 3, 26h, 89h, 4, 0A1h
	db	9Bh, 3, 26h, 89h, 44h, 2, 0A1h, 0F2h, 4, 40h, 26h, 89h, 44h, 4
	db	26h, 0C7h, 44h, 6, 0, 0, 6, 8Eh, 6, 79h, 3, 8Bh, 3Eh, 87h, 3, 8Bh
	db	0C6h, 0ABh, 89h, 3Eh, 87h, 3, 7, 'Y[X', 0FFh, 6, 65h, 3, 26h, 1
	db	5Ch, 6, 1, 1Eh, 0F2h, 4, 87h, 0CBh, 5Eh, 8Bh, 0D6h, 'FFQ', 1, 1Ch
	db	83h, 0C6h, 4, 0E2h, 0F9h, 8Bh, 0F2h, 59h, 0D1h, 0E1h, 0D1h, 0E1h
	db	0BDh, 7Eh, 4, 0BBh, 15h, 3, 0E8h, 0CDh, 13h, 8Bh, 36h, 0E0h, 3
	db	0C3h, 80h, '>xR', 0, 75h, 7, 80h, 3Eh, 17h, 0, 0, 75h, 0Ah, 80h
	db	3Eh, 21h, 1, 1, 74h, 3, 0E9h, 0D5h, 19h, 80h, 3Ch, 80h, 83h, 0DEh
	db	0FEh, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 46h, 81h, 0FBh, 0, 40h, 7Eh, 3, 0E9h, 11h, 1, 8Bh, 0D3h
	db	4Bh, 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 8Eh, 6, 80h
	db	7, 26h, 8Bh, 4Fh, 6, 26h, 8Bh, 3Fh, 33h, 0EDh, 80h, 3Eh, 27h, 1
	db	0, 74h, 8, 95h, 26h, 8Ah, 47h, 8, 0B4h, 0, 95h, 8Eh, 6, 0A0h, 7
	db	26h, 8Bh, 45h, 8, 80h, 3Eh, 19h, 0, 0, 74h, 4, 26h, 8Bh, 45h, 6
	db	80h, 3Eh, 17h, 0, 0, 74h, 1Eh, 80h, '>xR', 0, 75h, 0Dh, 'PSVU'
	db	0E8h, 0A0h, 0FEh, ']^[X3', 0C9h, 80h, 3Eh, 21h, 1, 1, 74h, 3, 0E9h
	db	56h, 19h, 8Bh, 0D0h, 8Bh, 3Eh, 41h, 0B4h, 3Bh, 1Eh, 26h, 2, 89h
	db	1Eh, 26h, 2, 't@V', 0E8h, 51h, 57h, 11h, 'Line numbers for ', 0E8h
	db	76h, 58h, 0B0h, 28h, 0E8h, 66h, 56h, 0E8h, 45h, 4Fh, 0E8h, 31h
	db	57h, 0Ah, ') segment ', 8Eh, 6, 78h, 7, 26h, 8Bh, 37h, 0E8h, 0E9h
	db	57h, 0E8h, 0BFh, 56h, 0E8h, 0BCh, 'V^3', 0DBh, 0EBh, 30h, 83h
	db	0FBh, 4, 72h, 5, 0E8h, 0AFh, 56h, 33h, 0DBh, 43h, 0ADh, 51h, 0B9h
	db	5, 0, 0E8h, 1Eh, 51h, 59h, 0B0h, 20h, 0E8h, 27h, 56h, 8Bh, 0C2h
	db	0E8h, 83h, 56h, 0B0h, 3Ah, 0E8h, 1Dh, 56h, 0ADh, 80h, 3Eh, 27h
	db	1, 0, 75h, 15h, 3, 0C1h, 0E8h, 'qV;6', 0E0h, 3, 72h, 0CAh, 0E8h
	db	7Eh, 56h, 89h, 3Eh, 41h, 0B4h, 0E9h, 0C2h, 18h, 52h, 33h, 0D2h
	db	83h, 3Eh, 1Eh, 4, 0, 74h, 4, 8Bh, 14h, 46h, 46h, 3, 0C1h, 13h
	db	0D5h, 50h, 8Bh, 0C2h, 0E8h, 'IVXZ', 0EBh, 0D1h, 81h, 0EBh, 1, 40h
	db	0D1h, 0E3h, 3, 1Eh, 2Eh, 5, 8Eh, 6, 88h, 7, 26h, 8Bh, 1Fh, 53h
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h
	db	7, 5Bh, 26h, 8Bh, 47h, 2, 3Bh, 6, 28h, 2, 75h, 13h, 26h, 8Bh, 4Fh
	db	4, 26h, 8Bh, 1Fh, 8Eh, 6, 80h, 7, 26h, 8Bh, 3Fh, 33h, 0D2h, 0E9h
	db	0CAh, 0FEh, 0E9h, 66h, 18h, 56h, 0BEh, 50h, 0Ah, 3, 0FEh, 2Bh
	db	0DBh, 0A1h, 0E4h, 3, 5, 50h, 0Ah, 50h, 0E8h, 7, 0, 58h, 3Bh, 0F0h
	db	72h, 0F7h, 5Eh, 0C3h, 55h, 51h, 0ADh, 8Bh, 0C8h, 8Bh, 0EEh, 83h
	db	3Eh, 0ECh, 3, 0, 74h, 1, 0ADh, 8Bh, 0F5h, 0ADh, 51h, 8Bh, 0C8h
	db	0E3h, 7, 0E8h, 0E6h, 0FFh, 0E2h, 0FBh, 0EBh, 1Dh, 0ACh, 2Ah, 0E4h
	db	3Bh, 0FEh, 72h, 12h, 8Bh, 0D6h, 3, 0D0h, 3Bh, 0FAh, 73h, 0Ah, 57h
	db	2Bh, 0FEh, 3, 0FBh, 0FFh, 16h, 22h, 2, 5Fh, 3, 0F0h, 3, 0D8h, 59h
	db	0E2h, 0D1h, 59h, 5Dh, 0C3h, 3, 3Eh, 0E8h, 3, 89h, 3Eh, 62h, 6
	db	2Bh, 3Eh, 0E8h, 3, 6, 'VWPSQR', 8Bh, 36h, 0E6h, 3, 8Eh, 6, 80h
	db	7, 26h, 8Bh, 34h, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 44h, 0Dh, 26h, 8Bh
	db	54h, 11h, 26h, 0FFh, 44h, 11h, 0E8h, 88h, 1Ah, 26h, 8Bh, 5Ch, 8
	db	26h, 8Ah, 4Ch, 0Ah, 0B5h, 0, 3, 1Eh, 0FEh, 3, 12h, 0CDh, 0D1h
	db	0E3h, 0D1h, 0D1h, 0D1h, 0E3h, 0D1h, 0D1h, 0D1h, 0E3h, 0D1h, 0D1h
	db	0D1h, 0E3h, 0D1h, 0D1h, 3, 0C3h, 13h, 0D1h, 8Bh, 0Eh, 0, 4, 8Bh
	db	36h, 2, 4, 0E8h, '8IZY[X_^', 7, 0C3h, 0F6h, 6, 15h, 2, 1, 74h
	db	0Bh, 0C3h, 33h, 0C0h, 50h, 0B8h, 16h, 0, 50h, 0E8h, 62h, 7Bh, 80h
	db	3Eh, 2Bh, 1, 1, 74h, 0EFh, 0FFh, 6, 0A2h, 4, 'PSQRVWU', 83h, 3Eh
	db	0ECh, 3, 0, 74h, 1Ch, 33h, 0DBh, 3, 3Eh, 0E8h, 3, 13h, 1Eh, 0EAh
	db	3, 74h, 14h, 0C7h, 6, 22h, 4, 1, 0, 33h, 0C0h, 50h, 0B8h, 18h
	db	0, 50h, 0E8h, 2Dh, 7Bh, 3, 3Eh, 0E8h, 3, 89h, 3Eh, 98h, 4, 8Bh
	db	3Eh, 0EEh, 3, 89h, 3Eh, 9Ah, 4, 0A1h, 0F2h, 3, 8Bh, 16h, 0F4h
	db	3, 0B9h, 4, 0, 1, 0Eh, 0F2h, 3, 83h, 16h, 0F4h, 3, 0, 0BEh, 98h
	db	4, 0E8h, 0C0h, 'H]_^ZY[X', 0C3h, 0E9h, 0BEh, 0, 0E9h, 26h, 17h
	db	98h, 8Bh, 0F8h, 83h, 0E7h, 3, 0A8h, '@u2', 0D0h, 0E8h, 0D0h, 0E8h
	db	24h, 3, 88h, 85h, 32h, 2, 0D1h, 0E7h, 3Ch, 3, 74h, 16h, 2Bh, 0DBh
	db	2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h
	db	89h, 9Dh, 36h, 2, 0E9h, 8Bh, 0, 8Bh, 1Ch, 83h, 0C6h, 2, 89h, 9Dh
	db	36h, 2, 0E9h, 7Fh, 0, 0D0h, 0E0h, 0D0h, 0E0h, 24h, 7, 88h, 85h
	db	3Eh, 2, 0D1h, 0E7h, 3Ch, 3, 74h, 15h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8
	db	46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 89h, 9Dh, 42h, 2
	db	0EBh, 5Ah, 8Bh, 1Ch, 83h, 0C6h, 2, 89h, 9Dh, 42h, 2, 0EBh, 4Fh
	db	83h, 0FBh, 0FDh, 74h, 15h, 80h, 0FEh, 4, 't*r"', 80h, 0FEh, 10h
	db	77h, 2, 74h, 19h, 8Eh, 6, 80h, 7, 26h, 8Bh, 1Fh, 0E8h, 0B8h, 57h
	db	0EBh, 30h, 1, 8Dh, 50h, 0Ah, 0A1h, 20h, 4, 11h, 85h, 52h, 0Ah
	db	0EBh, 23h, 8Ah, 0CDh, 0, 8Dh, 50h, 0Ah, 0EBh, 1Bh, 1, 8Dh, 50h
	db	0Ah, 0F6h, 6, 15h, 2, 40h, 74h, 10h, 0E8h, 4Dh, 57h, 0EBh, 0Bh
	db	83h, 3Eh, 1Eh, 4, 1, 74h, 0D4h, 1, 8Dh, 50h, 0Ah, 3Bh, 36h, 0E0h
	db	3, 72h, 3, 0E9h, 39h, 0FFh, 0ACh, 0A8h, 80h, 75h, 3, 0E9h, 34h
	db	0FFh, 80h, 3Eh, 0F1h, 3, 0FFh, 75h, 3, 0E9h, 27h, 0FFh, 8Ah, 0F0h
	db	8Ah, 14h, 46h, 0E8h, 43h, 0F1h, 72h, 0DBh, 80h, 0E6h, 1Ch, 80h
	db	3Eh, 19h, 0, 0, 75h, 82h, 80h, 0FEh, 4, 74h, 0C1h, 72h, 0A9h, 80h
	db	0FEh, 10h, 'w7t', 0A0h, 8Eh, 6, 80h, 7, 80h, 0FEh, 8, 74h, 62h
	db	83h, 3Eh, 1Eh, 4, 1, 74h, 13h, 1, 8Dh, 50h, 0Ah, 47h, 47h, 0C7h
	db	6, 16h, 2, 0FFh, 0FFh, 80h, 0Eh, 15h, 2, 8, 0EBh, 54h, 1, 8Dh
	db	50h, 0Ah, 50h, 0A1h, 20h, 4, 1, 85h, 52h, 0Ah, 58h, 83h, 0C7h
	db	4, 0EBh, 0E1h, 80h, 3Eh, 27h, 1, 0, 75h, 0Bh, 80h, 0FEh, 14h, 75h
	db	3, 0E9h, 74h, 0FFh, 0E9h, 7Ch, 0FFh, 1, 8Dh, 50h, 0Ah, 50h, 0A1h
	db	20h, 4, 1, 85h, 52h, 0Ah, 58h, 83h, 0C7h, 4, 80h, 0FEh, 14h, 75h
	db	3, 0E9h, 64h, 0FFh, 8Eh, 6, 80h, 7, 0C7h, 6, 16h, 2, 0FFh, 0FFh
	db	0EBh, 0Ch, 0F7h, 6, 11h, 4, 1, 0, 75h, 4, 89h, 1Eh, 16h, 2, 56h
	db	8Bh, 36h, 0E6h, 3, 26h, 8Bh, 54h, 4, 0F6h, 6, 15h, 2, 1, 75h, 0Bh
	db	26h, 8Bh, 4Fh, 6, 26h, 8Bh, 37h, 8Eh, 6, 0A0h, 7, 83h, 0FAh, 0FFh
	db	74h, 42h, 0C7h, 6, 22h, 2, 0C5h, 3Fh, 0F6h, 6, 15h, 2, 4, 74h
	db	15h, '&;\', 4, 74h, 0Fh, 83h, 0C6h, 14h, 3Bh, 36h, 9Eh, 7, 72h
	db	0F1h, 0B8h, 1, 0, 0E8h, 0CDh, 50h, 26h, 8Bh, 5Ch, 6, 4Bh, 0D1h
	db	0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 5Eh, 3Bh, 16h, 16h, 2, 75h, 5, 80h
	db	0CBh, 1, 0EBh, 30h, 0F6h, 6, 15h, 2, 8, 74h, 29h, 0EBh, 27h, 0C7h
	db	6, 22h, 2, 2Dh, 40h, 0F6h, 6, 15h, 2, 1, 'u6&', 80h, 7Ch, 0Ah
	db	0, 'u%&', 8Bh, 5Ch, 8, 5Eh, 0F6h, 6, 15h, 2, 4, 74h, 7, 91h, 0B1h
	db	4, 0D3h, 0E8h, 3, 0D8h, 1, 9Dh, 50h, 0Ah, 80h, 3Eh, 0F1h, 3, 1
	db	74h, 14h, 0FFh, 16h, 22h, 2, 0E9h, 0B1h, 0FEh, 33h, 0C0h, 50h
	db	0B8h, 22h, 0, 50h, 0E8h, 0E2h, 78h, 5Eh, 0EBh, 0E1h, 0E8h, 0A6h
	db	0FCh, 0E9h, 9Eh, 0FEh, 55h, 8Bh, 0ECh, 8Dh, 66h, 0FCh, 89h, 46h
	db	0FEh, 26h, 8Ah, 47h, 8, 0B4h, 0, 89h, 46h, 0FCh, 89h, 1Eh, 0E6h
	db	3, 26h, 8Bh, 1Fh, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 47h, 8, 0A3h, 0EEh
	db	3, 26h, 8Ah, 57h, 0Ah, 88h, 16h, 0F0h, 3, 0ADh, 33h, 0D2h, 8Bh
	db	0Eh, 1Eh, 4, 89h, 0Eh, 0ECh, 3, 0E3h, 3, 92h, 0ADh, 92h, 3, 46h
	db	0FEh, 13h, 56h, 0FCh, 89h, 16h, 0EAh, 3, 0A3h, 0E8h, 3, 8Bh, 0Eh
	db	0E0h, 3, 2Bh, 0CEh, 89h, 0Eh, 0E4h, 3, 1Eh, 7, 0BFh, 50h, 0Ah
	db	0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 8Bh, 0E5h, 5Dh
	db	0C3h, 0E8h, 24h, 0EDh, 0C6h, 6, 0F1h, 3, 0, 2Bh, 0DBh, 2, 1Ch
	db	7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 81h, 0FBh
	db	0, '@~e', 81h, 0EBh, 1, 40h, 0D1h, 0E3h, 3, 1Eh, 2Eh, 5, 8Eh, 6
	db	88h, 7, 26h, 8Bh, 1Fh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h
	db	0D1h, 0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 8Bh, 47h, 2, 3Bh, 6, 28h
	db	2, 75h, 15h, 26h, 8Bh, 47h, 4, 26h, 8Bh, 1Fh, 89h, 1Eh, 68h, 1
	db	8Eh, 6, 80h, 7, 0E8h, 43h, 0FFh, 0E9h, 49h, 14h, 0C6h, 6, 0F1h
	db	3, 0FFh, 0EBh, 0F6h, 0E8h, 0C1h, 0ECh, 0C6h, 6, 0F1h, 3, 1, 2Bh
	db	0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch
	db	46h, 81h, 0FBh, 0, 40h, 7Eh, 2, 0EBh, 9Bh, 4Bh, 93h, 0B4h, 0Ah
	db	0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 89h, 1Eh, 68h, 1, 8Eh, 6, 78h
	db	7, 26h, 0F6h, 47h, 9, 0E0h, 74h, 1Fh, 26h, 80h, 7Fh, 9, 0FFh, 74h
	db	18h, 26h, 8Bh, 47h, 2, 3Bh, 6, 36h, 4, 74h, 0Eh, 8Eh, 6, 80h, 7
	db	26h, 8Bh, 47h, 6, 0E8h, 0E4h, 0FEh, 0E9h, 0EAh, 13h, 0C6h, 6, 0F1h
	db	3, 0FFh, 0EBh, 0F6h, 50h, 8Eh, 6, 0B4h, 3, 26h, 8Bh, 4, 26h, 3Bh
	db	5, 74h, 0Ch, 72h, 7, 0F8h, 8Eh, 6, 0B8h, 3, 58h, 0C3h, 0F9h, 0EBh
	db	0F7h, 3Bh, 0F7h, 0EBh, 0F3h, 0C3h, 0, 0, 0, 0, 1, 5, 28h, 2, 6
	db	48h, 3, 7, 48h, 0, 0, 0, 0E0h, 5, 28h, 0E1h, 6, 48h, 0, 0, 0, 0
	db	0, 0, ',D1D_TEXT_DATA', 89h, 16h, 59h, 2, 89h, 0Eh, 5Bh, 2, 0ADh
	db	3Dh, 80h, 0, 73h, 35h, 0D1h, 0E0h, 86h, 0C4h, 0A3h, 5Dh, 2, 0A3h
	db	80h, 2, 3, 0D0h, 83h, 0D1h, 0, 0A1h, 50h, 2, 8Bh, 1Eh, 52h, 2
	db	0Bh, 0DBh, 75h, 5, 3Dh, 0, 40h, 72h, 16h, 2Bh, 0C2h, 1Bh, 0D9h
	db	75h, 10h, 23h, 0C0h, 74h, 0Ch, 0A3h, 68h, 2, 3, 6, 5Dh, 2, 0A3h
	db	60h, 2, 73h, 1Bh, 0F9h, 0C3h, 8Bh, 16h, 55h, 2, 8Bh, 0Eh, 57h
	db	2, 0B8h, 0, 42h, 8Bh, 1Eh, 26h, 0, 0E8h, 25h, 0BEh, 0C6h, 6, 54h
	db	2, 1, 0EBh, 0E5h, 0A1h, 'XR-P', 12h, 2Bh, 0D2h, 0A3h, 55h, 2, 89h
	db	16h, 57h, 2, 0B8h, 0, 42h, 8Bh, 1Eh, 26h, 0, 8Bh, 16h, 59h, 2
	db	8Bh, 0Eh, 5Bh, 2, 0E8h, 0FDh, 0BDh, 72h, 0C4h, 1Eh, 0B8h, 82h
	db	2, 50h, 0FFh, 36h, 60h, 2, 80h, 3Eh, 5Fh, 2, 1, 74h, 7, 9Ah, 18h
	db	15h, 0DFh, 0, 0EBh, 5, 9Ah, 0CAh, 2Dh, 0DFh, 0, 23h, 0C0h, 75h
	db	0A4h, 0C6h, 6, 5Fh, 2, 1, 1Eh, 0B4h, 3Fh, 8Bh, 1Eh, 26h, 0, 8Bh
	db	0Eh, 60h, 2, 33h, 0D2h, 8Eh, 1Eh, 82h, 2, 0E8h, 0C2h, 0BDh, 1Fh
	db	72h, 1Fh, 3Bh, 6, 60h, 2, 75h, 19h, 0C4h, 1Eh, 80h, 2, 26h, 81h
	db	3Fh, 0ADh, 2Bh, 75h, 0Eh, 0E8h, 49h, 0, 72h, 9, 8Bh, 3Eh, 96h
	db	4, 0C6h, 45h, 8, 1, 0C3h, 0E8h, 3, 0, 0E9h, 63h, 0FFh, 80h, 3Eh
	db	5Fh, 2, 1, 75h, 0Dh, 1Eh, 0B8h, 82h, 2, 50h, 33h, 0C0h, 50h, 9Ah
	db	0CAh, 2Dh, 0DFh, 0, 0C3h, 0ACh, 98h, 22h, 0C0h, 78h, 1, 0C3h, 53h
	db	8Ah, 0D8h, 0ACh, 8Ah, 0F8h, 0D0h, 0E3h, 0D1h, 0EBh, 22h, 0C0h
	db	79h, 0Ah, 0ACh, 80h, 0E7h, 3Fh, 0D0h, 0C8h, 0D0h, 0C8h, 0Ah, 0F8h
	db	8Bh, 0C3h, 5Bh, 0C3h, 1Eh, 7, 0BFh, 2Ah, 5, 0B9h, 38h, 0, 0B0h
	db	0, 0F3h, 0AAh, 0C5h, 36h, 80h, 2, 0FFh, 74h, 2, 83h, 0C6h, 8, 0ADh
	db	8Bh, 0C8h, 0ADh, 26h, 89h, 36h, 64h, 2, 8Bh, 0DEh, 3, 0D8h, 53h
	db	0E3h, 5, 0B4h, 80h, 0E8h, 0CFh, 0, 5Eh, 0ADh, 8Bh, 0C8h, 0ADh
	db	26h, 89h, 36h, 62h, 2, 8Bh, 0DEh, 3, 0D8h, 53h, 0E3h, 5, 0B4h
	db	0, 0E8h, 0B9h, 0, '^]U', 0ADh, 0B1h, 40h, 0E8h, 0D5h, 0, 26h, 0A3h
	db	66h, 2, 0BFh, 2Ah, 5, 8Bh, 0C3h, 0ABh, 26h, 0A1h, 7Eh, 7, 0ABh
	db	26h, 0A1h, 86h, 7, 0ABh, 26h, 0A1h, 96h, 7, 0ABh, 26h, 0A1h, 0AEh
	db	7, 0ABh, 0B8h, 1, 0, 0ABh, 8Bh, 0C2h, 0ABh, 0ACh, 98h, 22h, 0C0h
	db	79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 0ABh, 33h, 0C0h, 0AAh, 0ABh
	db	48h, 0ABh, 40h, 0AAh, 0ABh, 0ADh, 50h, 25h, 7, 0, 74h, 3, 0E8h
	db	24h, 1, 58h, 0D0h, 0E8h, 0D0h, 0E8h, 0D0h, 0E8h, 50h, 25h, 3, 0
	db	74h, 3, 0E8h, 9Ch, 1, 58h, 8Ah, 0C4h, 50h, 25h, 0Fh, 0, 74h, 3
	db	0E8h, 5Fh, 2, 58h, 0D1h, 0E8h, 0D1h, 0E8h, 0D1h, 0E8h, 0D1h, 0E8h
	db	25h, 7, 0, 74h, 3, 0E8h, 0ECh, 1, 56h, 6, 1Fh, 53h, 8Bh, 1Eh, 3Ah
	db	7, 0C4h, 7Fh, 2, 83h, 0C7h, 18h, ';?v', 9, 0E8h, 0C9h, 0Eh, 5Bh
	db	73h, 7, 0E8h, 8Ah, 0Eh, 87h, 7Fh, 2, 5Bh, 0BEh, 2Ah, 5, 0B9h, 18h
	db	0, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 1Eh, 7, 8Eh
	db	1Eh, 82h, 2, '^]Mt', 3, 0E9h, 4Dh, 0FFh, 6, 1Fh, 0F8h, 0C3h, 1Eh
	db	6, 1Fh, 7, 8Bh, 0FEh, 3, 0F1h, 3, 0F1h, 'PQW', 8Ch, 6, 50h, 52h
	db	0E8h, 0BCh, 47h, 8Eh, 6, 82h, 2, 5Fh, 8Bh, 0C3h, 0ABh, 59h, 58h
	db	0E2h, 0EAh, 1Eh, 6, 1Fh, 7, 0C3h, 56h, 1Eh, 6, 1Fh, 7, 8Bh, 0F0h
	db	56h, 26h, 8Ah, 1Ch, 83h, 0E3h, 3Fh, 26h, 0FFh, 70h, 1, 26h, 80h
	db	'8!u', 3, 26h, 0FEh, 0Ch, 8Ah, 0E1h, 26h, 80h, 24h, 3Fh, 8Ch, 6
	db	50h, 52h, 0E8h, 83h, 47h, 1Eh, 7, 'ZX^', 8Eh, 1Eh, 82h, 2, 0C3h
	db	0ACh, 98h, 3Ch, 0E0h, 73h, 0Ch, 4Eh, 0ACh, 98h, 22h, 0C0h, 79h
	db	5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 23h, 0C0h, 78h, 0Ch, 8Bh, 0D8h, 0D1h
	db	0E3h, 26h, 3, 1Eh, 64h, 2, 8Bh, 1Fh, 0C3h, 56h, 57h, 8Ah, 0D8h
	db	26h, 8Bh, 36h, 66h, 2, 0ACh, 25h, 3Fh, 0, 8Bh, 0C8h, 0BFh, 73h
	db	2, 0F3h, 0A4h, 83h, 0E3h, 7, 0D1h, 0E3h, 2Eh, 8Bh, 0B7h, 28h, 44h
	db	0Eh, 1Fh, 0B9h, 5, 0, 0F3h, 0A4h, 6, 1Fh, 0BEh, 72h, 2, 8Bh, 0C7h
	db	2Bh, 0C6h, 48h, 88h, 4, 0B4h, 80h, 0E8h, 1Dh, 47h, 1Eh, 7, 8Eh
	db	1Eh, 82h, 2, 5Fh, 5Eh, 0C3h, 3Dh, 7, 0, 72h, 0Bh, 0ACh, 98h, 22h
	db	0C0h, 79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 50h, 8Ah, 4, 24h, 0E0h
	db	3Ch, 0C0h, 75h, 25h, 0ACh, 25h, 7, 0, 8Bh, 0F8h, 0D1h, 0E0h, 3
	db	0F8h, 81h, 0C7h, 10h, 44h, 2Eh, 8Ah, 45h, 1, 98h, 0E8h, 82h, 0FFh
	db	53h, 2Eh, 8Ah, 5, 98h, 0E8h, 7Ah, 0FFh, 53h, 2Eh, 8Ah, 45h, 2
	db	0EBh, 9, 0E8h, 5Eh, 0FFh, 53h, 0E8h, 5Ah, 0FFh, 53h, 0ACh, 50h
	db	24h, 0E0h, 75h, 2, 0ADh, 50h, 0E8h, 0DAh, 0FDh, 50h, 6, 1Fh, 0E8h
	db	0E3h, 12h, 0A1h, 36h, 7, 26h, 89h, 45h, 4, 26h, 8Fh, 45h, 6, 58h
	db	26h, 88h, 45h, 9, 0A8h, 0E0h, 75h, 7, 8Eh, 6, 80h, 7, 26h, 8Fh
	db	5, 5Bh, 5Ah, 8Eh, 6, 78h, 7, 0E8h, 25h, 0D4h, 1Eh, 7, 8Eh, 1Eh
	db	82h, 2, 'XHt', 2, 0EBh, 89h, 0C3h, 3Dh, 3, 0, 72h, 0Bh, 0ACh, 98h
	db	22h, 0C0h, 79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 91h, 51h, 0ADh, 8Bh
	db	0C8h, 25h, 0Fh, 0, 8Bh, 0D9h, 0B1h, 4, 0D3h, 0EBh, 0D1h, 0E3h
	db	26h, 3, 1Eh, 64h, 2, 8Bh, 17h, 6, 1Fh, 0BFh, 4, 0, 57h, 0BFh, 94h
	db	7, 0E8h, 0, 0Dh, 73h, 3, 0E8h, 0EEh, 0Ch, 26h, 89h, 15h, 0B9h
	db	0FFh, 0FFh, 0EBh, 18h, 8Eh, 6, 82h, 2, 2Bh, 0DBh, 26h, 2, 1Ch
	db	7Dh, 9, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 26h, 8Ah, 1Ch, 46h, 0E8h
	db	1Ch, 0D5h, 48h, 7Dh, 0E5h, 8Eh, 6, 98h, 7, 26h, 89h, 4Dh, 2, 1Eh
	db	7, 8Eh, 1Eh, 82h, 2, 59h, 0E2h, 0A5h, 0C3h, 3Dh, 7, 0, 72h, 0Bh
	db	0ACh, 98h, 22h, 0C0h, 79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 8Bh, 0C8h
	db	51h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 46h, 23h, 0DBh, 74h, 0Ch, 4Bh, 0D1h, 0E3h, 26h, 3, 1Eh
	db	62h, 2, 8Bh, 1Fh, 0EBh, 10h, 0ACh, 98h, 22h, 0C0h, 79h, 5, 2Ch
	db	80h, 8Ah, 0E0h, 0ACh, 0B1h, 0, 0E8h, 36h, 0FEh, 6, 1Fh, 53h, 83h
	db	0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7
	db	5Bh, 0B2h, 10h, 0E8h, 90h, 0CFh, 1Eh, 7, 8Eh, 1Eh, 82h, 2, 59h
	db	0E2h, 0B1h, 0C3h, 3Dh, 0Fh, 0, 72h, 0Bh, 0ACh, 98h, 22h, 0C0h
	db	79h, 5, 2Ch, 80h, 8Ah, 0E0h, 0ACh, 50h, 0ADh, 0B1h, 0, 0E8h, 0FFh
	db	0FDh, 53h, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 2Bh, 0DBh, 2, 1Ch, 7Dh
	db	8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 0B2h, 0, 0Bh
	db	0DBh, 75h, 3, 0B2h, 2, 0ADh, 0ADh, 6, 1Fh, 88h, 16h, 72h, 1, 0A3h
	db	6Eh, 1, 0C7h, 6, 70h, 1, 0, 0, 0F6h, 0C2h, 2, 75h, 0Bh, 4Bh, 93h
	db	0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 89h, 1Eh, 6Ch, 1, 5Bh
	db	53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h
	db	18h, 7, 5Bh, 0E8h, 0Ch, 0D0h, 1Eh, 7, 8Eh, 1Eh, 82h, 2, 'XHu'
	db	99h, 0C3h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 4, 0, 0, 1, 0, 0, 2, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh
	db	0, 0, 0, 5, 0, 0, 2, 0, 0, 4, 0, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh
	db	0, 0, 6, 0, 0, 4, 0, 0, 6, 0, 0, 0, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh
	db	8, 0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0FFh, 0, 0, 0, 9, 0, 0, 2
	db	0, 0, 0Ah, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0Ah, 0, 0, 4, 0, 0
	db	0Ch, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0FFh, 0FFh, 0Dh, 0, 0, 4, 0, 0
	db	0, 0, 0Fh, 0, 0, 8, 0, 0, 0, 0, 10h, 0, 0, 0Ah, 0, 0, 0, 0, 0Eh
	db	0, 0, 6, 0, 0, 0, 0, 28h, 0, 0, 1, 0, 0, 0, 0, 0Ch, 0, 0, 1, 0
	db	0, 13h, 0, 0, 0, 0, 0, 0FFh, 0, 0, 0, 7, 0, 0, 8, 0, 0, 0, 0, 0Bh
	db	0, 0, 8, 0, 0, 0, 0, 2Bh, 0, 0, 0Ah, 0, 0, 0, 0, 5, 3, 9, 0, 0E8h
	db	4, 0Dh, 3, 10h, 0, 0ECh, 4, 11h, 3, 6, 0, 0F4h, 4, 15h, 3, 4, 0
	db	0F2h, 4, 19h, 3, 0Ch, 0, 0F0h, 4, 2Dh, 3, 10h, 0, 0F6h, 4, 31h
	db	3, 8, 0, 0F8h, 4, 1Dh, 3, 8, 0, 0EEh, 4, 21h, 3, 8, 0, 0E4h, 4
	db	25h, 3, 5, 0, 0E6h, 4, 35h, 3, 0Bh, 0, 0Ah, 5, 39h, 3, 2, 0, 0Ch
	db	5, 3Dh, 3, 8, 0, 10h, 5, 41h, 3, 4, 0, 12h, 5, 45h, 3, 8, 0, 14h
	db	5, 0BEh, 3, 2, 0, 0CAh, 3, 0BAh, 3, 2, 0, 16h, 5, 1Eh, 53h, 50h
	db	9Ah, 18h, 15h, 0DFh, 0, 23h, 0C0h, 75h, 1, 0C3h, 0E9h, 92h, 0B8h
	db	33h, 0C0h, 50h, 0B8h, 1Fh, 0, 50h, 0E8h, 89h, 71h, 55h, 8Bh, 0ECh
	db	83h, 0ECh, 0Ah, 0BEh, 34h, 7, 89h, 76h, 0F8h, 33h, 0F6h, 89h, 36h
	db	0A8h, 3, 1Eh, 7, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 26h, 8Eh, 9Ch, 38h, 7, 5Eh, 8Ah, 5Ch, 10h, 0B7h, 0, 83h
	db	7Ch, 0Ah, 2, 'rk&', 0FFh, 6, 0ECh, 4, 26h, 0A1h, 0ECh, 4, 89h
	db	44h, 16h, 23h, 0DBh, 74h, 5Bh, 89h, 76h, 0FAh, 8Dh, 74h, 18h, 0BFh
	db	0E4h, 4, 0B9h, 3, 0, 0E8h, 39h, 7, 8Bh, 76h, 0FAh, 8Dh, 74h, 1Eh
	db	0BFh, 0EEh, 4, 0B9h, 5, 0, 0E8h, 2Ah, 7, 8Bh, 76h, 0FAh, 0BFh
	db	0DAh, 4, 8Bh, 'D(&', 1, 45h, 1Eh, 8Bh, 'D*&', 1, 45h, 30h, 8Bh
	db	'D.&', 1, 45h, 32h, 8Bh, 'D,&', 1, 45h, 36h, 8Bh, 'D2&', 1, 45h
	db	3Ch, 8Bh, 'D4&', 1, 6, 0E6h, 3, 8Ah, 'D0&', 8, 6, 0A8h, 3, 80h
	db	64h, 30h, 7Fh, '&;6', 84h, 1, 't9.', 3, 0B7h, 50h, 57h, 6, 1Fh
	db	57h, 8Bh, 7Eh, 0F8h, 3Bh, 75h, 2, 5Fh, 73h, 0Dh, 56h, 83h, 0C6h
	db	38h, 83h, 0FEh, 80h, 5Eh, 73h, 3, 0E9h, 55h, 0FFh, 57h, 8Bh, 7Eh
	db	0F8h, 81h, 0FFh, 44h, 7, 76h, 3, 5Fh, 0EBh, 0Eh, 83h, 0C7h, 8
	db	89h, 7Eh, 0F8h, 83h, 0E6h, 3, 46h, 5Fh, 0E9h, 3Ah, 0FFh, 6, 1Fh
	db	81h, 26h, 0A8h, 3, 80h, 0, 55h, 0C7h, 6, 0B0h, 3, 1, 0, 0BDh, 63h
	db	4Fh, 0E8h, 23h, 4, 5Dh, 0BFh, 0DAh, 4, 8Bh, 45h, 10h, 1, 45h, 0Eh
	db	83h, 45h, 0Ah, 17h, 0C7h, 45h, 38h, 0, 0, 8Bh, 45h, 30h, 89h, 45h
	db	3Ah, 0Bh, 'E6t', 19h, 0C7h, 6, 0A1h, 3, 0, 0, 8Bh, 45h, 12h, 89h
	db	45h, 3Ah, 83h, 3Eh, 0A8h, 3, 0, 74h, 6, 8Bh, 45h, 16h, 89h, 45h
	db	38h, 0B9h, 18h, 0, 0BEh, 34h, 7, 89h, 76h, 0F8h, 33h, 0F6h, 56h
	db	83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h
	db	7, 5Eh, 26h, 8Ah, 5Ch, 10h, 81h, 0E3h, 0FFh, 0, 74h, 12h, 26h
	db	83h, 7Ch, 18h, 0, 74h, 0Bh, 26h, 83h, 7Ch, 0Ah, 2, 'rS&', 3, 4Ch
	db	18h, 3Bh, 36h, 84h, 1, 75h, 3, 0E9h, 0EFh, 1, 2Eh, 3, 0B7h, 'PWW'
	db	8Bh, 7Eh, 0F8h, 3Bh, 75h, 2, 5Fh, 73h, 0Ah, 56h, 83h, 0C6h, 38h
	db	83h, 0FEh, 80h, 5Eh, 72h, 0C2h, 57h, 8Bh, 7Eh, 0F8h, 81h, 0FFh
	db	44h, 7, 76h, 4, 5Fh, 0E9h, 0C8h, 1, 83h, 0C7h, 8, 89h, 7Eh, 0F8h
	db	83h, 0E6h, 3, 'F_V', 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Eh, 84h, 38h, 7, 5Eh, 0EBh, 98h, 0E9h, 4Bh, 0FEh, 0A1h
	db	92h, 4, 5, 17h, 0, 2Bh, 0C1h, 40h, 89h, 0Eh, 0AEh, 3, 56h, 0Bh
	db	0C0h, 79h, 19h, 50h, 0B8h, 0FFh, 0FFh, 0BBh, 0AAh, 3, 0E8h, 1Fh
	db	0FEh, 58h, 2Dh, 0, 80h, 0D1h, 0E0h, 0BBh, 0ACh, 3, 0E8h, 13h, 0FEh
	db	5Eh, 0EBh, 9, 0D1h, 0E0h, 0BBh, 0AAh, 3, 0E8h, 8, 0FEh, 5Eh, 8Bh
	db	0FEh, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Dh, 0BDh
	db	34h, 7, 89h, 7Eh, 0F8h, 33h, 0FFh, 0A1h, 0AAh, 3, 89h, 46h, 0F6h
	db	0A1h, 0AEh, 3, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Ah, 5Ch, 10h, 81h, 0E3h, 0FFh
	db	0, 'tu&', 8Bh, 4Ch, 18h, 0E3h, 6Fh, 8Bh, 56h, 0F6h, 3Bh, 16h, 0ACh
	db	3, 74h, 0Ah, 57h, 51h, 0D1h, 0E1h, 3, 0F9h, 'Y_r', 17h, 26h, 83h
	db	7Ch, 0Ah, 2, 8Eh, 0C2h, 72h, 6, 0ABh, 40h, 0E2h, 0FCh, 0EBh, 'MP3'
	db	0C0h, 0F3h, 0ABh, 58h, 0EBh, 45h, 51h, 8Bh, 0CFh, 0F7h, 0D9h, 0D1h
	db	0E9h, 51h, 26h, 83h, 7Ch, 0Ah, 2, 8Eh, 0C2h, 72h, 19h, 0ABh, 40h
	db	0E2h, 0FCh, 'ZY+', 0CAh, 8Bh, 16h, 0ACh, 3, 89h, 56h, 0F6h, 8Eh
	db	0C2h, 33h, 0FFh, 0ABh, 40h, 0E2h, 0FCh, 0EBh, 1Bh, 50h, 33h, 0C0h
	db	0F3h, 0ABh, 'XZY+', 0CAh, 8Bh, 16h, 0ACh, 3, 89h, 56h, 0F6h, 8Eh
	db	0C2h, 33h, 0FFh, 50h, 33h, 0C0h, 0F3h, 0ABh, 'X;6', 84h, 1, 'tF.'
	db	3, 0B7h, 'PWW', 8Bh, 7Eh, 0F8h, 3Bh, 75h, 2, 5Fh, 73h, 0Dh, 56h
	db	83h, 0C6h, 38h, 83h, 0FEh, 80h, 5Eh, 73h, 3, 0E9h, 50h, 0FFh, 57h
	db	8Bh, 7Eh, 0F8h, 81h, 0FFh, 44h, 7, 76h, 3, 5Fh, 0EBh, 1Dh, 83h
	db	0C7h, 8, 89h, 7Eh, 0F8h, 83h, 0E6h, 3, 'F_V', 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 0E9h, 26h
	db	0FFh, 2Bh, 0F6h, 56h, 0BBh, 54h, 7, 8Bh, 16h, 90h, 4, 56h, 83h
	db	0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7
	db	5Eh, 8Bh, 47h, 2, 1Eh, 0EBh, 30h, 1Fh, 1Eh, 26h, 8Bh, 7Ch, 10h
	db	2Bh, 3Eh, 0AEh, 3, 'r"x', 0Bh, 0D1h, 0E7h, 50h, 0A1h, 0AAh, 3
	db	8Eh, 0D8h, 58h, 0EBh, 0Fh, 81h, 0EFh, 0, 80h, 0D1h, 0E7h, 1Fh
	db	1Eh, 50h, 0A1h, 0ACh, 3, 8Eh, 0D8h, 58h, 8Bh, 3Dh, 26h, 89h, 7Ch
	db	10h, 3, 0F2h, 3Bh, 0F0h, 72h, 0CCh, 1Fh, 81h, 0FBh, 64h, 7, 77h
	db	8, 83h, 0C3h, 8, '^FV', 0EBh, 0A8h, 58h, 1Eh, 0B8h, 0AAh, 3, 50h
	db	9Ah, 0FCh, 15h, 0DFh, 0, 83h, 3Eh, 0ACh, 3, 0FFh, 74h, 0Ah, 1Eh
	db	0B8h, 0ACh, 3, 50h, 9Ah, 0FCh, 15h, 0DFh, 0, 33h, 0FFh, 0B8h, 10h
	db	0, 0F7h, 26h, 0FEh, 3, 96h, 8Bh, 0FAh, 3, 36h, 0DCh, 3, 13h, 3Eh
	db	0DEh, 3, 83h, 0C6h, 0Fh, 83h, 0D7h, 0, 83h, 0E6h, 0F0h, 80h, 3Eh
	db	19h, 0, 0, 74h, 6, 83h, 0C6h, 10h, 83h, 0D7h, 0, 83h, 0C6h, 30h
	db	83h, 0D7h, 0, 33h, 0C0h, 83h, 3Eh, 14h, 5, 0, 75h, 0Dh, 83h, 3Eh
	db	16h, 5, 0, 74h, 18h, 0A1h, 0F6h, 4, 0A3h, 0CAh, 3, 0B8h, 20h, 0
	db	80h, 3Eh, 2Fh, 1, 1, 75h, 3, 2Dh, 14h, 0, 3, 0F0h, 83h, 0D7h, 0
	db	0A3h, 8, 5, 89h, 76h, 0FCh, 89h, 7Eh, 0FEh, 55h, 0BDh, 98h, 49h
	db	0B9h, 11h, 0, 2Eh, 8Bh, 5Eh, 0, 89h, 37h, 89h, 7Fh, 2, 2Eh, 8Bh
	db	46h, 2, 2Eh, 8Bh, 5Eh, 4, 0F7h, 27h, 3, 0F0h, 13h, 0FAh, 83h, 0C5h
	db	6, 0E2h, 0E4h, 5Dh, 89h, 36h, 29h, 3, 89h, 3Eh, 2Bh, 3, 2Bh, 76h
	db	0FCh, 1Bh, 7Eh, 0FEh, 89h, 36h, 18h, 5, 89h, 3Eh, 1Ah, 5, 0BFh
	db	0DAh, 4, 0B8h, 9, 0, 0F7h, 65h, 10h, 3, 6, 5, 3, 13h, 16h, 7, 3
	db	0A3h, 9, 3, 89h, 16h, 0Bh, 3, 8Bh, 45h, 10h, 89h, 45h, 0Eh, 33h
	db	0C0h, 89h, 45h, 18h, 89h, 45h, 16h, 89h, 45h, 14h, 0C7h, 45h, 0Ah
	db	17h, 0, 89h, 45h, 0Ch, 89h, 45h, 1Ah, 89h, 45h, 12h, 89h, 45h
	db	1Ch, 89h, 45h, 1Eh, 89h, 45h, 32h, 89h, 45h, 36h, 89h, 45h, 30h
	db	0B8h, 0, 80h, 0BBh, 0BAh, 2, 0E8h, 0A8h, 0FBh, 0C7h, 6, 0B8h, 2
	db	0, 0, 0B8h, 16h, 0, 0F7h, 26h, 8Ah, 4, 0BBh, 6Dh, 3, 0E8h, 95h
	db	0FBh, 0B8h, 8, 0, 0F7h, 26h, 8Ch, 4, 0BBh, 75h, 3, 0E8h, 88h, 0FBh
	db	0A1h, 8Ch, 4, 0D1h, 0E0h, 0BBh, 79h, 3, 0E8h, 7Dh, 0FBh, 0B8h
	db	9, 0, 0F7h, 26h, 8Eh, 4, 0BBh, 7Dh, 3, 0E8h, 70h, 0FBh, 0A1h, 8Eh
	db	4, 0D1h, 0E0h, 0BBh, 81h, 3, 0E8h, 65h, 0FBh, 0B8h, 0FDh, 7, 0BBh
	db	49h, 3, 0E8h, 5Ch, 0FBh, 0A1h, 0C8h, 3, 0D1h, 0E0h, 8Bh, 1Eh, 0C6h
	db	3, 0D1h, 0E3h, 0D1h, 0E3h, 3, 0C3h, 0BBh, 0B4h, 3, 0E8h, 47h, 0FBh
	db	0A1h, 0C6h, 3, 0D1h, 0E0h, 0BBh, 0B8h, 3, 0E8h, 3Ch, 0FBh, 33h
	db	0C0h, 0A3h, 6Bh, 3, 0A3h, 73h, 3, 0A3h, 77h, 3, 0A3h, 7Bh, 3, 0A3h
	db	7Fh, 3, 0A3h, 6Fh, 3, 0A3h, 0B2h, 3, 0A3h, 0B6h, 3, 33h, 0C0h
	db	0A3h, 63h, 3, 0A3h, 5Dh, 3, 0C7h, 6, 61h, 3, 0FDh, 7, 0C7h, 6
	db	5Fh, 3, 49h, 3, 0A3h, 59h, 3, 0A3h, 5Bh, 3, 0A3h, 91h, 3, 0A3h
	db	8Fh, 3, 0C6h, 6, 76h, 52h, 2, 0C4h, 3Eh, 0B8h, 2, 0B9h, 0, 40h
	db	0F3h, 0ABh, 0A1h, 21h, 3, 8Bh, 16h, 23h, 3, 0BEh, 0E0h, 48h, 0B9h
	db	0B8h, 0, 1, 0Eh, 21h, 3, 83h, 16h, 23h, 3, 0, 0BBh, 80h, 4, 0E8h
	db	0DFh, 39h, 8Bh, 0E5h, 5Dh, 0C3h, 33h, 0DBh, 0EBh, 2Eh, 8Eh, 6
	db	0C0h, 7, 26h, 8Bh, 37h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 26h, 83h, 7Ch, 0Ch, 0FFh, 74h
	db	0Fh, 57h, 8Bh, 0FEh, 0E8h, 0D2h, 'A_s', 6, 53h, 55h, 0FFh, 0D5h
	db	'][CC;', 1Eh, 0BEh, 7, 72h, 0CCh, 0C3h, 0A1h, 0B0h, 3, 26h, 89h
	db	44h, 12h, 0FFh, 6, 0B0h, 3, 26h, 8Bh, 5Ch, 0Ch, 26h, 83h, 7Ch
	db	10h, 0, 'u*&', 8Bh, 5Ch, 0Ch, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h
	db	0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 8Bh, 47h, 0FAh, 56h
	db	83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h
	db	7, 5Eh, 26h, 89h, 44h, 10h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h
	db	0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 8Ah, 47h, 2, 25h
	db	3Fh, 0, 40h, 1, 6, 0DEh, 4, 83h, 16h, 0E0h, 4, 0, 0FFh, 6, 0E2h
	db	4, 0A1h, 0E2h, 4, 26h, 89h, 47h, 0FCh, 0FFh, 6, 0EAh, 4, 0C3h
	db	56h, 1Eh, 26h, 8Bh, 74h, 0Ch, 1Eh, 7, 56h, 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 9Ch, 18h, 7, 5Eh, 8Bh, 44h
	db	0FCh, 26h, 0A3h, 91h, 3, 46h, 46h, 0B9h, 3Fh, 0, 22h, 0Ch, 88h
	db	0Ch, 41h, 8Bh, 0D9h, 3, 0DEh, 0B0h, 0, 86h, 7, 1Fh, 50h, 53h, 0A1h
	db	29h, 3, 8Bh, 16h, 2Bh, 3, 1, 0Eh, 29h, 3, 83h, 16h, 2Bh, 3, 0
	db	4Eh, 4Eh, 8Bh, 0DEh, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Dh, 9Fh, 18h, 7, 56h, 83h, 0C6h, 3, 0E8h, 0D7h, '8^V', 83h
	db	0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 18h, 7
	db	'^[X&', 88h, 7, 5Eh, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 0E8h, 1Ah, 3, 0C3h, 50h, 53h
	db	8Eh, 6, 78h, 7, 26h, 8Bh, 44h, 2, 26h, 8Bh, 5Dh, 2, 3Bh, 0C3h
	db	74h, 1Eh, 3Bh, 6, 4Eh, 4, 74h, 15h, 3Bh, 1Eh, 4Eh, 4, 74h, 0Ch
	db	3Bh, 6, 50h, 4, 74h, 9, 3Bh, 1Eh, 50h, 4, 75h, 6, 0F9h, 0EBh, 19h
	db	0F8h, 0EBh, 16h, 8Eh, 6, 80h, 7, 26h, 8Bh, 4, 26h, 3Bh, 5, 75h
	db	0Ah, 26h, 8Bh, 44h, 6, '&;E', 6, 74h, 7, 8Eh, 6, 71h, 3, 5Bh, 58h
	db	0C3h, 3Bh, 0F7h, 0EBh, 0F5h, 'VW3', 0F6h, 0BFh, 50h, 0Ah, 8Bh
	db	16h, 76h, 7, 0EBh, 20h, 8Eh, 6, 80h, 7, 0B0h, 0, 26h, 86h, 44h
	db	9, 8Eh, 6, 78h, 7, 26h, 80h, 7Ch, 9, 0FFh, 74h, 8, 0A8h, 1, 74h
	db	4, 89h, '5GG', 83h, 0C6h, 0Ah, 3Bh, 0F2h, 72h, 0DCh, 81h, 0EFh
	db	50h, 0Ah, 75h, 3, 0E9h, 0B6h, 0, 8Bh, 0C7h, 0D1h, 0E8h, 0A3h, 0F6h
	db	4, 0BAh, 10h, 0, 0F7h, 0E2h, 50h, 57h, 0BBh, 71h, 3, 0E8h, 8, 0F9h
	db	0C4h, 3Eh, 6Fh, 3, 0BEh, 50h, 0Ah, 8Bh, 0Eh, 0F6h, 4, 0F3h, 0A5h
	db	0BDh, 'WPYQ', 0E8h, 'R>Y_', 8Bh, 0F1h, 83h, 0EFh, 2, 83h, 0EEh
	db	2, 1Eh, 6, 1Fh, 0FDh, 0D1h, 0E9h, 0F3h, 0A5h, 1Fh, 0FCh, 83h, 0C7h
	db	2, 0B2h, 0, 2Bh, 0DBh, 80h, 0C2h, 1, 80h, 0D2h, 0, 8Eh, 6, 71h
	db	3, 26h, 8Bh, 35h, 8Eh, 6, 80h, 7, 26h, 88h, 54h, 9, 26h, 0FFh
	db	74h, 6, 8Eh, 6, 78h, 7, 26h, 0FFh, 74h, 6, 26h, 0FFh, 74h, 4, 8Eh
	db	6, 80h, 7, 26h, 8Bh, 34h, 0E8h, 9Eh, '?^V', 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Bh
	db	74h, 16h, 8Eh, 6, 71h, 3, 26h, 89h, 37h, 26h, 89h, 47h, 2, 26h
	db	8Fh, 47h, 6, 26h, 8Fh, 47h, 4, 2Bh, 0C0h, 26h, 89h, 47h, 8, 26h
	db	89h, 47h, 0Ah, 26h, 89h, 47h, 0Ch, 26h, 89h, 47h, 0Eh, 83h, 0C3h
	db	10h, 83h, 0C7h, 2, 3Bh, 0FBh, 77h, 8Eh, 89h, 1Eh, 99h, 3, 5Fh
	db	5Eh, 0C3h, 0ADh, 26h, 3, 5, 72h, 4, 0ABh, 0E2h, 0F7h, 0C3h, 0E9h
	db	62h, 0F8h, 8Bh, 7, 8Bh, 57h, 2, 1, 0Fh, 83h, 57h, 2, 0, 8Bh, 0DDh
	db	0E8h, 49h, 37h, 0C3h, 56h, 8Ch, 6, 50h, 52h, 0E8h, 'U<Zr', 9, 26h
	db	8Bh, 47h, 0FCh, 23h, 0C0h, 74h, 1, 0C3h, 8Eh, 6, 50h, 52h, 0A1h
	db	52h, 52h, 0D1h, 0E0h, 0C7h, 6, 69h, 3, 0BAh, 2, 0C5h, 1Eh, 0B8h
	db	2, 3, 0D8h, 8Bh, 37h, 23h, 0F6h, 74h, 36h, 1Eh, 53h, 8Bh, 6Fh
	db	2, 2Eh, 8Eh, 1Eh, 10h, 0, 89h, 36h, 69h, 3, 8Eh, 1Ch, 8Dh, 76h
	db	6, 8Bh, 0FAh, 0ACh, 0AEh, 75h, 16h, 25h, 3Fh, 0, 8Bh, 0C8h, 0F3h
	db	0A6h, 75h, 0Dh, 3Eh, 8Bh, 46h, 4, 83h, 0C4h, 4, 2Eh, 8Eh, 1Eh
	db	10h, 0, 0C3h, 83h, 0C4h, 4, 8Bh, 0DDh, 0EBh, 0C4h, 8Bh, 0F2h, 26h
	db	8Ah, 4, 25h, 3Fh, 0, 40h, 8Bh, 0C8h, 5, 7, 0, 6, 2Eh, 8Eh, 1Eh
	db	10h, 0, 8Bh, 3Eh, 5Dh, 3, 3, 0F8h, 72h, 65h, 83h, 0C7h, 2, 'r`;>a'
	db	3, 77h, 5Ah, 1, 6, 59h, 3, 83h, 16h, 5Bh, 3, 0, 1, 0Eh, 0DEh, 4
	db	83h, 16h, 0E0h, 4, 0, 4Fh, 4Fh, 87h, 3Eh, 5Dh, 3, 8Bh, 36h, 5Fh
	db	3, 8Ch, 0D8h, 53h, 8Bh, 1Eh, 69h, 3, 8Eh, 1Fh, 5Bh, 89h, 7Fh, 2
	db	89h, 37h, 8Eh, 0D8h, 8Eh, 4, 8Bh, 0F2h, 33h, 0C0h, 0ABh, 0ABh
	db	0FFh, 6, 0E2h, 4, 0A1h, 0E2h, 4, 0ABh, 8Ch, 0DAh, 1Fh, 0ACh, 24h
	db	3Fh, 0AAh, 49h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h
	db	32h, 0C0h, 0AAh, 8Eh, 0DAh, 0A1h, 0E2h, 4, 0FFh, 6, 63h, 3, 0C3h
	db	'PSQR', 81h, 6, 61h, 3, 0, 8, 72h, 1Ch, 1Eh, 0FFh, 36h, 5Fh, 3
	db	0FFh, 36h, 61h, 3, 9Ah, 0CAh, 2Dh, 0DFh, 0, 23h, 0C0h, 75h, 7
	db	'ZY[X', 0E9h, 6Eh, 0FFh, 0E9h, 0D5h, 0AFh, 8Bh, 3Eh, 5Fh, 3, 8Eh
	db	5, 8Bh, 3Eh, 5Dh, 3, 0B8h, 0FFh, 0FFh, 0ABh, 83h, 6, 5Fh, 3, 2
	db	0B8h, 0FDh, 7, 0A3h, 61h, 3, 0C7h, 6, 5Dh, 3, 0, 0, 1Eh, 0FFh
	db	36h, 5Fh, 3, 50h, 9Ah, 18h, 15h, 0DFh, 0, 0EBh, 0C6h, 55h, 50h
	db	1Eh, 6, 1Fh, 7, 0BFh, 0C5h, 2, 3Ch, 0, 75h, 11h, 0ACh, 25h, 3Fh
	db	0, 0AAh, 8Bh, 0C8h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h
	db	0EBh, 17h, 0ACh, 25h, 3Fh, 0, 0AAh, 8Bh, 0C8h, 0E3h, 0Eh, 0ACh
	db	'<ar', 6, '<zw', 2, 2Ch, 20h, 0AAh, 0E2h, 0F2h, 6, 1Fh, 0BEh, 0C5h
	db	2, 26h, 80h, 7Ch, 1, '@u2&', 8Ah, 4, 25h, 3Fh, 0, 8Bh, 0C8h, 0E3h
	db	28h, 33h, 0DBh, 43h, 26h, 80h, 38h, 24h, 0E0h, 0F9h, 75h, 1Dh
	db	26h, 80h, 78h, 0FFh, 40h, 74h, 16h, 56h, 6, 26h, 8Ah, 4, 50h, 0FEh
	db	0CBh, 26h, 88h, 1Ch, 32h, 0E4h, 0E8h, 59h, 0FEh, 58h, 7, 5Eh, 26h
	db	88h, 4, 58h, 0E8h, 4Fh, 0FEh, 5Dh, 0C3h, 'SQRV', 6, 0BFh, 90h
	db	2, 26h, 8Ah, 44h, 0Fh, 88h, 45h, 8, 26h, 8Bh, 44h, 10h, 89h, 45h
	db	2, 26h, 0FFh, 74h, 0Ch, 26h, 0F6h, 44h, 0Eh, ' uP', 0E8h, 0CEh
	db	28h, 80h, 0FEh, 1, 75h, 0Ch, 8Ah, 75h, 8, 80h, 0E6h, 0F8h, 80h
	db	0CEh, 1, 8, 75h, 8, 89h, 45h, 6, 89h, 4Dh, 4, 5Eh, 0A1h, 91h, 3
	db	23h, 0C0h, 75h, 17h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 84h, 18h, 7, 5Eh, 83h, 0C6h, 2, 33h, 0C0h, 0E8h
	db	2Dh, 0FFh, 0BEh, 90h, 2, 89h, 4, 0B9h, 9, 0, 0BBh, 9, 3, 0BDh
	db	7Eh, 4, 0E8h, 0D1h, 0FDh, 7, '^ZY[', 0C3h, 57h, 26h, 8Bh, 74h
	db	2, 8Eh, 6, 8, 8, 26h, 8Bh, 44h, 4, 0Bh, 0C0h, 74h, 3, 0Dh, 0, 40h
	db	26h, 8Bh, 74h, 0Ah, 0Dh, 0, 80h, 50h, 8Eh, 6, 0D0h, 7, 26h, 8Bh
	db	34h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh
	db	84h, 18h, 7, 5Eh, 83h, 0C6h, 2, 0B8h, 0, 0C0h, 0E8h, 0DBh, 0FEh
	db	8Bh, 0C8h, 58h, 5Fh, 0EBh, 83h, 83h, 0C4h, 2, 0EBh, 0B4h, 0B8h
	db	10h, 0, 0F7h, 26h, 0F6h, 4, 91h, 0E3h, 1Bh, 0BBh, 71h, 3, 8Bh
	db	36h, 6Fh, 3, 8Bh, 16h, 2Fh, 3, 0A1h, 2Dh, 3, 0E8h, 0C3h, 34h, 1Eh
	db	0B8h, 71h, 3, 50h, 9Ah, 0FCh, 15h, 0DFh, 0, 83h, 6, 0E4h, 4, 0
	db	0A1h, 5, 3, 0A3h, 9, 3, 0A1h, 7, 3, 0A3h, 0Bh, 3, 0BDh, 0D3h, 4Fh
	db	0E8h, 0C7h, 0FAh, 0C7h, 6, 91h, 3, 0, 0, 0A1h, 29h, 3, 8Bh, 16h
	db	2Bh, 3, 0BBh, 49h, 3, 33h, 0F6h, 1Eh, 8Eh, 1Fh, 83h, 3Ch, 0FFh
	db	74h, 1Eh, 83h, 0C6h, 6, 8Ah, 0Ch, 83h, 0E1h, 3Fh, 1Fh, 'FAV', 0E8h
	db	'y4^', 3, 0C1h, 83h, 0D2h, 0, 3, 0F1h, 0FFh, 0Eh, 63h, 3, 75h
	db	0DBh, 0C3h, 1Fh, 83h, 0C3h, 2, 33h, 0F6h, 0EBh, 0D2h, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0E8h, 79h, 0, 33h, 0C0h, 50h, 0B8h
	db	8, 0, 50h, 0E8h, 0E4h, 66h, 55h, 8Bh, 0ECh, 56h, 8Bh, 0F7h, 0BFh
	db	80h, 0FFh, 2Bh, 7Eh, 4, 3Bh, 7Ch, 2, 76h, 0Fh, 0C4h, 7Ch, 2, 3
	db	7Eh, 4, ';<v', 8, 0E8h, 0B9h, 0, 0EBh, 0F1h, 0F9h, 0EBh, 4, 87h
	db	7Ch, 2, 0F8h, 5Eh, 5Dh, 0C2h, 2, 0, 56h, 8Bh, 0F3h, 8Bh, 5Ch, 2
	db	2Bh, 0FBh, 57h, 0EBh, 12h, 8Bh, 5Ch, 6, 53h, 83h, 0C3h, 18h, 3Bh
	db	0DEh, 5Bh, 74h, 16h, 83h, 0C6h, 8, 89h, 77h, 6, 57h, 8Bh, 0FEh
	db	0E8h, 0B1h, 0FFh, 73h, 4, 5Fh, 57h, 0EBh, 0E2h, 0F8h, 5Eh, 5Eh
	db	0C3h, 0F9h, 0EBh, 0FAh, 0E8h, 54h, 40h, 0E8h, 0C1h, 40h, 2, ', ZXR'
	db	0E8h, 48h, 40h, 0E8h, 5Bh, 40h, 0C3h
L0552C:	push	ax	;@0552C
	push	bx	;@0552D
	push	cx	;@0552E
	push	dx	;@0552F
	push	si	;@05530
	push	di	;@05531
	mov	di, word ptr ds:[0B441h]	;@05532
	db	0E8h, 4Dh, 40h	; call L09586	;@05536
	db	0E8h, 0A4h, 40h	; call L095E0	;@05539
	adc	al, 49h	;@0553C
	outsb	;@0553E
	db	74h, 65h	; je @@2	;@0553F
	db	72h, 6Eh	; jb @@3	;@05541
	popa	;@05543
	insb	;@05544
	and	byte ptr [si+69h], ch	;@05545
	outsb	;@05548
	imul	sp, word ptr [di+72h], 20h	;@05549
	db	64h, 61h	; popa	;@0554D
	db	74h, 61h	; je @@3+1	;@0554F
	call	L09586	;@05551
	mov	bx, 714h	;@05554
@@1:	mov	ax, word ptr [bx]	;@05557
	call	L09570	;@05559
	call	L095E0	;@0555C
	add	word ptr [bx+si], sp	;@0555F
	mov	ax, word ptr [bx+2]	;@05561
	call	L09570	;@05564
	call	L095E0	;@05567
	add	word ptr [bx+si], sp	;@0556A
	mov	ax, word ptr [bx+4]	;@0556C
	call	L09570	;@0556F
	call	L095E0	;@05572
	add	word ptr [bx+si], sp	;@05575
	mov	ax, word ptr [bx+6]	;@05577
	call	L09570	;@0557A
	call	L09586	;@0557D
	add	bx, 8	;@05580
	cmp	bx, 834h	;@05583
	jb	@@1	;@05587
	mov	word ptr ds:[0B441h], di	;@05589
	pop	di	;@0558D
	pop	si	;@0558E
	pop	dx	;@0558F
	pop	cx	;@05590
	pop	bx	;@05591
	pop	ax	;@05592
	ret	;@05593
	db	'PSQRWVU', 8Bh, 4, 3Dh, 80h, 0FFh, 's1=', 80h, 3Fh, 73h	;@05594
@@2:	pop	es	;@055A6
	add	ax, ax	;@055A7
	add	ax, 80h	;@055A9
	jmp	short @@3	;@055AC
	db	5, 0, 40h	;@055AE
@@3:	mov	di, ax	;@055B1
	xchg	word ptr [si], di	;@055B3
	push	ds	;@055B5
	lea	si, [si+4]	;@055B6
	push	si	;@055B9
	push	ax	;@055BA
	push	ds	;@055BB
	push	si	;@055BC
	db	9Ah, 0DFh, 2Dh, 0DFh, 0	; lcall 0xdf, 0x2ddf	;@055BD
	db	9Ah, 0CAh, 2Dh, 0DFh, 0	; lcall 0xdf, 0x2dca	;@055C2
	and	ax, ax	;@055C7
	jne	@@4	;@055C9
	pop	bp	;@055CB
	pop	si	;@055CC
	pop	di	;@055CD
	pop	dx	;@055CE
	pop	cx	;@055CF
	pop	bx	;@055D0
	pop	ax	;@055D1
	ret	;@055D2
@@4:	jmp	L0029E+2	;@055D3
	db	51h, 57h, 0C7h, 45h, 2, 0, 0, 0B8h, 80h, 0, 89h, 5, 83h, 0C7h	;@055D6
	db	4, 1Eh, 57h, 50h, 9Ah, 18h, 15h, 0DFh, 0, 5Fh, 59h, 0C3h, 0BFh
	db	14h, 7, 0E8h, 0E0h, 0FFh, 23h, 0C0h, 74h, 3, 0E9h, 9Ah, 0, 83h
	db	0C7h, 8, 81h, 0FFh, 0BCh, 7, 76h, 0EDh, 0C7h, 6, 56h, 7, 0, 0
	db	0C7h, 6, 5Eh, 7, 1, 0, 0C7h, 6, 66h, 7, 2, 0, 0C7h, 6, 6Eh, 7
	db	3, 0, 0C7h, 6, 5Ah, 7, 54h, 7, 0C7h, 6, 62h, 7, 54h, 7, 0C7h, 6
	db	6Ah, 7, 54h, 7, 0C7h, 6, 72h, 7, 54h, 7, 0C7h, 6, 16h, 7, 2, 0
	db	0C7h, 6, 1Eh, 7, 3, 0, 0C7h, 6, 26h, 7, 4, 0, 0C7h, 6, 2Eh, 7
	db	5, 0, 0C7h, 6, 1Ah, 7, 14h, 7, 0C7h, 6, 22h, 7, 14h, 7, 0C7h, 6
	db	2Ah, 7, 14h, 7, 0C7h, 6, 32h, 7, 14h, 7, 0C7h, 6, 36h, 7, 0, 0
	db	0C7h, 6, 3Eh, 7, 1, 0, 0C7h, 6, 46h, 7, 2, 0, 0C7h, 6, 4Eh, 7
	db	3, 0, 0C7h, 6, 3Ah, 7, 34h, 7, 0C7h, 6, 42h, 7, 34h, 7, 0C7h, 6
	db	4Ah, 7, 34h, 7, 0C7h, 6, 52h, 7, 34h, 7, 0C3h, 0E9h, 6, 0ACh, 51h
	db	57h, 0B9h, 4, 0, 0E8h, 34h, 0FFh, 23h, 0C0h, 75h, 0F1h, 83h, 0C7h
	db	8, 0E2h, 0F4h, 5Fh, 0C7h, 45h, 2, 0, 0, 0C7h, 45h, 0Ah, 1, 0, 0C7h
	db	45h, 12h, 2, 0, 0C7h, 45h, 1Ah, 3, 0, 89h, 7Dh, 6, 89h, 7Dh, 0Eh
	db	89h, 7Dh, 16h, 89h, 7Dh, 1Eh, 59h, 0C3h, 0C7h, 45h, 2, 0, 0, 0C7h
	db	45h, 0Ah, 0, 0, 0C7h, 45h, 12h, 0, 0, 0C7h, 45h, 1Ah, 0, 0, 0C3h
	db	51h, 57h, 0B9h, 4, 0, 51h, 0E8h, 9, 0, 59h, 83h, 0C7h, 8, 0E2h
	db	0F6h, 5Fh, 59h, 0C3h, 56h, 57h, 83h, 3Dh, 0, 74h, 1Fh, 8Bh, 45h
	db	2, 89h, 5, 8Dh, 7Dh, 4, 1Eh, 57h, 23h, 0C0h, 74h, 8, 50h, 9Ah
	db	0CAh, 2Dh, 0DFh, 0, 0EBh, 5, 9Ah, 0FCh, 15h, 0DFh, 0, 23h, 0C0h
	db	75h, 3, 5Fh, 5Eh, 0C3h, 0E9h, 7Fh, 0ABh, 83h, 6, 16h, 7, 4, 83h
	db	6, 1Eh, 7, 4, 83h, 6, 26h, 7, 4, 83h, 6, 2Eh, 7, 4, 0BFh, 14h
	db	7, 0E8h, 0BAh, 0FFh, 83h, 0C7h, 8, 81h, 0FFh, 0BCh, 7, 76h, 0F4h
	db	9Ah, 5Eh, 13h, 0DFh, 0, 0C3h, 0, 0, 0, 0, 0, 0, 18h, 0, 38h, 0
	db	38h, 0, ' in module ', 0, ' and ', 0, 0C6h, 6, 0D6h, 3, 0, 80h
	db	3Eh, 0D5h, 3, 1, 75h, 0Ch, 80h, 3Eh, 54h, 2, 0, 74h, 5, 0C6h, 6
	db	0D6h, 3, 1, 0C6h, 6, 0D2h, 3, 0, 0BEh, 50h, 12h, 80h, 3Eh, 0D4h
	db	3, 1, 75h, 4Bh, 8Bh, 3Eh, 0E2h, 3, 57h, 83h, 0E7h, 3, 0D1h, 0E7h
	db	0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 38h, 7, 5Fh, 26h, 83h, 7Dh, 0Ch
	db	0, 74h, 31h, 0C6h, 6, 0D2h, 3, 2, 80h, 3Eh, 0D5h, 3, 4, 74h, 6
	db	0FEh, 0Eh, 0D2h, 3, 0EBh, 1Fh, 26h, 83h, 7Dh, 0Ah, 2, 73h, 18h
	db	0E9h, 49h, 35h, 0E8h, 59h, 2Eh, 0EBh, 10h, 0E8h, 54h, 2Eh, 0EBh
	db	21h, 90h, 90h, 0FFh, 6, 1Ch, 4, 8Bh, 36h, 0E0h, 3, 46h, 8Bh, 0Eh
	db	'XR+', 0CEh, 83h, 0F9h, 3, 72h, 0E0h, 8Ah, 1Ch, 46h, 2Ah, 0FFh
	db	0ADh, 3Dh, 0, 'Cw&', 8Bh, 0Eh, 'XR+', 0CEh, 3Bh, 0C8h, 72h, 0D0h
	db	8Bh, 0FEh, 3, 0F8h, 4Fh, 89h, 3Eh, 0E0h, 3, 0D1h, 0EBh, 72h, 12h
	db	0C7h, 6, 1Eh, 4, 0, 0, 0D1h, 0E3h, 3, 1Eh, 0D0h, 3, 2Eh, 0FFh
	db	27h, 0E8h, 84h, 2Eh, 0C7h, 6, 1Eh, 4, 1, 0, 83h, 0FBh, 78h, 74h
	db	17h, 80h, 3Eh, 27h, 1, 0, 75h, 0E2h, 0C7h, 6, 22h, 4, 1, 0, 33h
	db	0C9h, 51h, 0B8h, 1Dh, 0, 50h, 0E8h, 66h, 63h, 0C3h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h
	db	0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 32h, 14h, 0D1h, 57h, 0D1h, 57h
	db	0D1h, 57h, 31h, 15h, 6Dh, 16h, 60h, 18h, 0D0h, 57h, 0A4h, 1Ah
	db	0A8h, 1Ah, 0E0h, 1Ah, 80h, 1Bh, 0FBh, 1Bh, 40h, 1Dh, 9, 1Eh, 0D1h
	db	57h, 9Ah, 21h, 0EAh, '!F";X;X;X', 0CFh, 57h, 0CFh, 57h, 92h, 24h
	db	0CFh, 57h, 64h, 18h, 0A8h, 1Ah, 97h, 24h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 'WF"', 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h
	db	57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h
	db	57h, 0D8h, 25h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D6h, 2Fh, 0FAh
	db	3Bh, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0E4h, 3Dh, 0D1h
	db	57h, 0D1h, 57h, 0D1h, 57h, 0A5h, 40h, 0D1h, 'W,C', 8Fh, 'CF";X;X;X'
	db	0CFh, 57h, 0CFh, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h
	db	0D1h, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 'WF"', 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 51h
	db	0B9h, 0Ah, 0, 8Bh, 0F9h, 57h, 0BFh, 7Ch, 7, 0E8h, 74h, 0FAh, 73h
	db	3, 0E8h, 62h, 0FAh, 89h, 3Eh, 4Bh, 0Ah, 57h, 33h, 0C0h, 0FCh, 0F3h
	db	0AAh, 5Fh, 26h, 0FFh, 0Dh, 26h, 0FFh, 4Dh, 4, 26h, 0FFh, 4Dh, 2
	db	0B9h, 0Ah, 0, 8Bh, 0F9h, 57h, 0BFh, 74h, 7, 0E8h, 4Dh, 0FAh, 73h
	db	3, 0E8h, 3Bh, 0FAh, 57h, 33h, 0C0h, 0FCh, 0F3h, 0AAh, 5Fh, 59h
	db	0C3h, 0D1h, 0E2h, 80h, 3Eh, 19h, 0, 0, 74h, 7, 0D1h, 0E2h, 0D1h
	db	0E2h, 83h, 0C2h, 2, 3, 0C2h, 0BAh, 0, 0, 13h, 0D2h, 0C3h, 0C7h
	db	6, 7Ah, 4, 0, 0, 0BEh, 77h, 0, 0B4h, 0, 0C7h, 6, 50h, 52h, 97h
	db	1, 0E8h, 7Dh, 34h, 89h, 1Eh, 58h, 4, 72h, 5, 83h, 0Eh, 7Ah, 4
	db	1, 0BEh, 84h, 0, 0B4h, 0, 0C7h, 6, 50h, 52h, 97h, 1, 0E8h, 64h
	db	34h, 89h, 1Eh, 5Ah, 4, 72h, 5, 83h, 0Eh, 7Ah, 4, 2, 0BEh, 9Eh
	db	0, 0B4h, 0, 0C7h, 6, 50h, 52h, 97h, 1, 0E8h, 4Bh, 34h, 89h, 1Eh
	db	5Ch, 4, 72h, 5, 83h, 0Eh, 7Ah, 4, 4, 0BEh, 0AAh, 0, 0B4h, 0, 0C7h
	db	6, 50h, 52h, 97h, 1, 0E8h, 32h, 34h, 89h, 1Eh, 5Eh, 4, 72h, 5
	db	83h, 0Eh, 7Ah, 4, 8, 83h, 3Eh, 7Ah, 4, 0, 75h, 3, 0E9h, 0AEh, 0
	db	53h, 8Bh, 1Eh, 3Ah, 7, 0C4h, 7Fh, 2, 83h, 0C7h, 18h, ';?v', 9
	db	0E8h, 0CDh, 0F9h, 5Bh, 73h, 7, 0E8h, 8Eh, 0F9h, 87h, 7Fh, 2, 5Bh
	db	8Bh, 0D7h, 0A1h, 56h, 4, 0ABh, 0A1h, 76h, 7, 0ABh, 0A1h, 86h, 7
	db	0ABh, 0A1h, 96h, 7, 0ABh, 0A1h, 0AEh, 7, 0ABh, 0B8h, 1, 0, 0ABh
	db	0B0h, 0, 0ABh, 0ABh, 0AAh, 8Bh, 1Eh, 54h, 4, 0A1h, 0D8h, 3, 40h
	db	0A3h, 0D8h, 3, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 89h, 7, 0E8h, 0D7h, 0FEh, 26h
	db	89h, 1Dh, 0A1h, 56h, 4, 26h, 89h, 45h, 2, 26h, 0C6h, 45h, 9, 68h
	db	26h, 89h, 55h, 4, 89h, 3Eh, 8, 4, 0F7h, 6, 7Ah, 4, 1, 0, 74h, 7
	db	8Bh, 1Eh, 58h, 4, 0E8h, 2Eh, 0, 0F7h, 6, 7Ah, 4, 2, 0, 74h, 7
	db	8Bh, 1Eh, 5Ah, 4, 0E8h, 1Fh, 0, 0F7h, 6, 7Ah, 4, 4, 0, 74h, 7
	db	8Bh, 1Eh, 5Ch, 4, 0E8h, 10h, 0, 0F7h, 6, 7Ah, 4, 8, 0, 74h, 7
	db	8Bh, 1Eh, 5Eh, 4, 0E8h, 1, 0, 0C3h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 89h, 3Fh, 26h
	db	80h, 67h, 0Eh, 0EFh, 26h, 89h, 57h, 2, 0C3h, 55h, 8Bh, 0ECh, 'SQW'
	db	8Bh, 76h, 4, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h
	db	8Eh, 84h, 38h, 7, 5Eh, 8Bh, 0FEh, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h
	db	0E7h, 0D1h, 0E7h, 8Dh, 0BDh, 34h, 7, 33h, 0DBh, 26h, 8Ah, 5Ch
	db	10h, 2Eh, 8Bh, 9Fh, 50h, 57h, 3, 0DEh, 26h, 8Bh, 74h, 8, 3Bh, 5Dh
	db	2, 74h, 6, 26h, 8Bh, 5Fh, 8, 0EBh, 21h, 81h, 0FFh, 64h, 7, 77h
	db	17h, 8Bh, 0DEh, 83h, 0E3h, 3, 43h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 38h, 7, 5Bh, 0EBh, 0DDh, 8Bh
	db	1Eh, 0AEh, 7, 3Bh, 0F3h, 73h, 18h, 8Eh, 6, 0B0h, 7, 26h, 8Bh, 3Ch
	db	8Eh, 6, 88h, 7, 26h, 8Bh, '=;~', 6, 74h, 8, 83h, 0C6h, 11h, 0EBh
	db	0E4h, 0F9h, 0EBh, 5, 8Eh, 6, 0B0h, 7, 0F8h, '_Y[', 8Bh, 0E5h, 5Dh
	db	0C2h, 4, 0, 55h, 8Bh, 0ECh, 81h, 0ECh, 90h, 0, 'VW3', 0C0h, 89h
	db	86h, 70h, 0FFh, 89h, 46h, 0F2h, 89h, 46h, 0F6h, 48h, 89h, 46h
	db	0FAh, 26h, 8Bh, 5, 89h, 46h, 0F8h, 26h, 8Bh, 75h, 0Ah, 83h, 0FEh
	db	0FFh, 73h, 7Ch, 8Eh, 6, 0A8h, 7, 26h, 8Bh, 44h, 0Ah, 89h, 46h
	db	0F4h, 26h, 8Bh, 44h, 6, 26h, 8Bh, 5Ch, 2, 26h, 8Bh, 4Ch, 8, 26h
	db	8Bh, 54h, 4, 26h, 8Bh, 34h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h
	db	0E3h, 0D1h, 0E3h, 8Eh, 87h, 38h, 7, 5Bh, 26h, 83h, 7Fh, 0Ah, 2
	db	72h, 0C7h, 83h, 7Eh, 0F8h, 0FEh, 'r*;V', 0F8h, 74h, 3, 0E9h, 8Fh
	db	1, 3Bh, 4Eh, 0F2h, 72h, 0B4h, 75h, 6, 3Bh, 86h, 70h, 0FFh, 72h
	db	0ACh, 89h, 86h, 70h, 0FFh, 89h, 5Eh, 0FAh, 89h, 4Eh, 0F2h, 8Bh
	db	46h, 0F4h, 89h, 46h, 0F6h, 89h, 56h, 0F8h, 0EBh, 97h, 83h, 7Eh
	db	0FAh, 0FFh, 74h, 0E5h, 3Bh, 86h, 70h, 0FFh, 75h, 7, 3Bh, 4Eh, 0F2h
	db	75h, 2, 0EBh, 0D8h, 0E8h, 65h, 1, 0EBh, 0D3h, 83h, 7Eh, 0FAh, 0FFh
	db	75h, 3, 0E9h, 46h, 1, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h
	db	0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 8Bh, 86h, 70h, 0FFh, 26h, 89h
	db	45h, 4, 8Bh, 46h, 0F2h, 26h, 89h, 45h, 6, 8Bh, 5Eh, 0FAh, 26h
	db	89h, 5Dh, 2, 8Bh, 76h, 0F8h, 26h, 89h, 35h, 26h, 0C7h, 45h, 0Ah
	db	0FFh, 0FFh, 83h, 0FEh, 0FEh, 72h, 3, 0E9h, 0Dh, 1, 8Eh, 6, 80h
	db	7, 26h, 8Bh, 4Ch, 4, 83h, 0F9h, 0FFh, 74h, 1Dh, 8Bh, 0CFh, 26h
	db	87h, 4Ch, 4, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h
	db	8Eh, 85h, 58h, 7, 5Fh, 26h, 89h, 4Dh, 0Ah, 8Eh, 6, 80h, 7, 8Bh
	db	4Eh, 0F6h, 26h, 1, 4Ch, 6, 1, 0Eh, 0A2h, 4, 8Bh, 5Eh, 0FAh, 53h
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 38h
	db	7, 5Bh, 26h, 1, 4Fh, 0Eh, 57h, 53h, 0E8h, 39h, 0FEh, 73h, 3, 0E9h
	db	0B8h, 0, 8Bh, 0FBh, 26h, 8Ah, 44h, 10h, 26h, 8Bh, 5Ch, 2, 26h
	db	8Bh, 4Ch, 4, 26h, 8Bh, 54h, 6, 26h, 0FFh, 74h, 0Ch, 26h, 0FFh
	db	74h, 0Eh, 26h, 0FFh, 74h, 0Ah, 26h, 0FFh, 74h, 8, 57h, 83h, 0E7h
	db	3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 38h, 7, 5Fh, 26h
	db	80h, 7Dh, 10h, 0, 75h, 4, 26h, 88h, 45h, 10h, 26h, 1, ']$[&', 1
	db	'] [&', 1, '](&', 1, 'M"&', 8Bh, 'E(;', 6, 8Ch, 4, 76h, 3, 0A3h
	db	8Ch, 4, 3Bh, 16h, 8Eh, 4, 76h, 4, 89h, 16h, 8Eh, 4, 26h, 1, 55h
	db	1Ch, 5Ah, 26h, 1, 'U4&', 8Bh, 'U4;', 16h, 0C6h, 3, 76h, 4, 89h
	db	16h, 0C6h, 3, 5Ah, 26h, 1, 'U2&', 8Bh, 'U2;', 16h, 0C8h, 3, 76h
	db	4, 89h, 16h, 0C8h, 3, 8Eh, 6, 0B0h, 7, 26h, 8Bh, 34h, 8Eh, 6, 88h
	db	7, 26h, 8Bh, 34h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Eh, 84h, 58h, 7, 5Eh, 26h, 8Bh, 34h, 8Eh, 6, 80h, 7, 26h
	db	80h, 4Ch, 9, 1, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0C3h, 83h, 7Eh, 0FAh
	db	0FFh, 75h, 3, 0E9h, 68h, 0FEh, 0E8h, 2, 0, 0EBh, 0ECh, 'PSQRVWWW'
	db	83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h
	db	7, 5Fh, 26h, 8Bh, 75h, 0Ch, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h
	db	0E6h, 0D1h, 0E6h, 8Eh, 84h, 18h, 7, 5Eh, 26h, 80h, 7Ch, 3, 40h
	db	0BFh, 28h, 0, 74h, 5, 0E8h, 9Dh, 38h, 0EBh, 5, 53h, 0E8h, '?7['
	db	8Bh, 76h, 0FAh, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Bh, 34h, 0BFh, 78h, 0, 0E8h
	db	'{8S.', 8Eh, 1Eh, 10h, 0, 1Eh, 0B8h, 78h, 0, 50h, 0Eh, 0B8h, 'VWP'
	db	9Ah, 0Eh, 0, 0CFh, 0, 5Bh, 53h, 16h, 8Dh, 86h, 72h, 0FFh, 50h
	db	53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h
	db	38h, 7, 5Bh, 26h, 8Bh, 37h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h
	db	0E6h, 0D1h, 0E6h, 8Eh, 84h, 18h, 7, '^FF', 6, 56h, 0E8h, 0A4h
	db	33h, 1Eh, 0B8h, 78h, 0, 50h, 16h, 8Dh, 86h, 72h, 0FFh, 50h, 9Ah
	db	0Eh, 0, 0CFh, 0, 1Eh, 0B8h, 78h, 0, 50h, 1Eh, 0B8h, 28h, 0, 50h
	db	0B9h, 8, 0, 51h, 0B8h, 33h, 0, 50h, 0E8h, '|\[__^ZY[X', 0C3h, 55h
	db	8Bh, 0ECh, 83h, 0ECh, 0Ah, 0C7h, 46h, 0F6h, 0FFh, 0FFh, 'PSQRVW'
	db	0E8h, 1Ah, 0FDh, 8Bh, 0F7h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h
	db	0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 26h, 8Bh, 44h, 2, 89h
	db	46h, 0FEh, 3Dh, 0FFh, 0FFh, 75h, 3, 0E9h, 1Ah, 1, 26h, 8Bh, 44h
	db	4, 89h, 46h, 0FCh, 26h, 8Bh, 44h, 6, 89h, 46h, 0FAh, 26h, 8Bh
	db	3Ch, 89h, 7Eh, 0F8h, 83h, 0FFh, 0FEh, 73h, 3, 0E9h, 0B5h, 0, 75h
	db	64h, 8Bh, 56h, 0FAh, 8Bh, 46h, 0FCh, 0B9h, 60h, 0, 0EBh, 23h, 83h
	db	0FAh, 1, 'rOw', 5, 3Dh, 0, 0, 'tHRP', 0BAh, 1, 0, 33h, 0C0h, 0E8h
	db	10h, 1, 0B9h, 20h, 0, 'XZ-', 0, 0, 83h, 0DAh, 1, 0EBh, 0, 83h
	db	0FAh, 0, 77h, 0D8h, 3Dh, 0, 0, 75h, 0D3h, 33h, 0C0h, 56h, 83h
	db	0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7
	db	5Eh, 26h, 89h, 44h, 6, 26h, 89h, 44h, 4, 8Bh, 46h, 0F6h, 26h, 89h
	db	4, 26h, 80h, 64h, 0Eh, 0F7h, 0E9h, 9Dh, 0, 0E8h, 0CFh, 0, 0EBh
	db	0D4h, 8Bh, 3Eh, 3Eh, 4, 83h, 0FFh, 0FFh, 75h, 46h, 0E8h, 42h, 0FAh
	db	89h, 3Eh, 3Eh, 4, 0A1h, 2Ah, 4, 26h, 89h, 5, 8Eh, 6, 80h, 7, 0A1h
	db	24h, 4, 26h, 89h, 5, 8Bh, 16h, 26h, 4, 0B0h, 48h, 8Eh, 6, 78h
	db	7, 26h, 88h, 45h, 9, 26h, 89h, 55h, 2, 8Bh, 46h, 0FEh, 26h, 89h
	db	45h, 4, 97h, 50h, 0BFh, 2, 0, 57h, 0BFh, 0BCh, 7, 0E8h, 8Ah, 0F4h
	db	73h, 3, 0E8h, 78h, 0F4h, 58h, 26h, 89h, 5, 97h, 8Eh, 6, 78h, 7
	db	26h, 8Bh, 45h, 6, 50h, 3, 46h, 0FCh, 26h, 89h, 45h, 6, 26h, 8Ah
	db	45h, 8, 0B4h, 0, 50h, 13h, 46h, 0FAh, 26h, 88h, 45h, 8, 80h, 3Eh
	db	27h, 1, 0, 75h, 5, 3Dh, 0, 0, 'u)V', 83h, 0E6h, 3, 0D1h, 0E6h
	db	0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 26h, 8Fh, 44h, 6
	db	26h, 8Fh, 44h, 4, 26h, 89h, 3Ch, 26h, 80h, 64h, 0Eh, 0F7h, '_^ZY[X'
	db	8Bh, 0E5h, 5Dh, 0C3h, 83h, 7Eh, 0F8h, 0FFh, 75h, 0D1h, 83h, 3Eh
	db	41h, 0Ah, 0FFh, 75h, 0CAh, 0C7h, 6, 41h, 0Ah, 1, 0, 'PSQRVW3'
	db	0C0h, 50h, 0B8h, 2Ah, 0, 50h, 0E8h, 0F3h, 'Z_^ZY[X', 0EBh, 0ACh
	db	'QRPQ', 0A1h, 3Ch, 4, 40h, 0A3h, 3Ch, 4, 0B2h, 1Ah, 0F6h, 0F2h
	db	5, 'AAV', 0BEh, 40h, 4, 0C6h, 4, 0Bh, 0C7h, 44h, 1, 5Fh, 43h, 0C7h
	db	44h, 3, 4Fh, 4Dh, 0C7h, 44h, 5, 44h, 45h, 0C7h, 44h, 7, 46h, 5Fh
	db	89h, 44h, 9, 0C6h, 44h, 0Bh, 5Fh, 0B4h, 80h, 8Ch, 1Eh, 50h, 52h
	db	0E8h, '"-S', 0E8h, 40h, 0F9h, 5Bh, 26h, 89h, 1Dh, 0A1h, 0D8h, 3
	db	40h, 0A3h, 0D8h, 3, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h
	db	0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 89h, 7, 8Eh, 6, 80h, 7
	db	26h, 0C7h, 5, 0FFh, 0FFh, 5Eh, 8Eh, 6, 78h, 7, 59h, 26h, 88h, 4Dh
	db	9, 8Bh, 16h, 28h, 4, 26h, 89h, 55h, 2, 8Bh, 46h, 0FEh, 26h, 89h
	db	45h, 4, 97h, 50h, 0BFh, 2, 0, 57h, 0BFh, 0BCh, 7, 0E8h, 76h, 0F3h
	db	73h, 3, 0E8h, 64h, 0F3h, 58h, 26h, 89h, 5, 97h, 58h, 5Ah, 8Eh
	db	6, 78h, 7, 26h, 89h, 45h, 6, 26h, 88h, 55h, 8, 83h, 7Eh, 0F6h
	db	0FFh, 75h, 3, 89h, 7Eh, 0F6h, 59h, 0C3h, 'PSQRVW3', 0FFh, 57h
	db	0BBh, 54h, 7, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h
	db	0E7h, 8Eh, 85h, 58h, 7, 5Fh, 0EBh, 49h, 26h, 0F6h, 45h, 0Eh, 14h
	db	'u>&', 0F6h, 45h, 0Eh, 8, 't7S&', 8Bh, 5Dh, 2, 53h, 83h, 0E3h
	db	3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 38h, 7, 5Bh, 26h
	db	8Bh, 47h, 0Ah, 5Bh, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h
	db	0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 3Dh, 2, 0, 73h, 7, 26h, 80h
	db	7Dh, 0Eh, 1, 74h, 3, 0E8h, 6Ch, 0FDh, 3, 3Eh, 90h, 4, 3Bh, 7Fh
	db	2, 72h, 0B2h, 81h, 0FBh, 64h, 7, 77h, 8, 83h, 0C3h, 8, '_GW', 0EBh
	db	93h, 58h, 0C7h, 6, 0A6h, 7, 0, 0, 0BFh, 0A4h, 7, 0E8h, 5, 0F5h
	db	'_^ZY[X', 0C3h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 83h, 7Ch, 0Ah, 2, 72h, 1, 0C3h
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 2, 'SQW', 8Bh, 0FEh, 83h, 0E7h, 3, 0D1h
	db	0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Dh, 0BDh, 34h, 7, 26h, 0C7h, 44h
	db	0Ah, 2, 0, 56h, 26h, 3, 44h, 0Eh, 3Bh, 36h, 86h, 1, 75h, 0Eh, 8Bh
	db	0Eh, 88h, 1, 83h, 0C1h, 2, 0C7h, 46h, 0FEh, 0FFh, 0FFh, 0EBh, 1Bh
	db	26h, 8Ah, 5Ch, 10h, 0B7h, 0, 2Eh, 8Bh, 9Fh, 'PWV', 3, 0F3h, 89h
	db	76h, 0FEh, 3Bh, 75h, 2, '^sO&', 8Bh, 48h, 4, 26h, 8Bh, 5Ch, 4
	db	3Bh, 0D9h, 72h, 3, 0E9h, 81h, 0, 8Eh, 6, 88h, 7, 26h, 8Bh, 37h
	db	56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h
	db	58h, 7, 5Eh, 26h, 80h, 4Ch, 0Eh, 1, 26h, 0F6h, 44h, 0Eh, 18h, 75h
	db	59h, 80h, 3Eh, 19h, 0, 0, 'tK&', 0F6h, 44h, 0Eh, ' tD&', 8Bh, 74h
	db	2, 8Eh, 6, 8, 8, 26h, 0C7h, 44h, 6, 0FFh, 0FFh, 0EBh, 3Bh, 26h
	db	8Bh, 5Ch, 4, 83h, 0C7h, 8, 56h, 83h, 0E6h, 3, 46h, 56h, 83h, 0E6h
	db	3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h
	db	8Bh, 4Ch, 4, 89h, 76h, 0FEh, 5Eh, 56h, 83h, 0E6h, 3, 0D1h, 0E6h
	db	0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 0EBh, 85h, 26h
	db	8Bh, 74h, 2, 0E8h, 11h, 0FFh, 83h, 0C3h, 2, 0E9h, 78h, 0FFh, 5Eh
	db	56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h
	db	38h, 7, '^B&', 89h, 54h, 0Ah, 26h, 8Bh, 5Ch, 2, 56h, 8Bh, 76h
	db	0FEh, 83h, 0FEh, 0FFh, 75h, 9, 8Bh, 0Eh, 4Bh, 0Ah, 83h, 0C1h, 0Ah
	db	0EBh, 13h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h
	db	8Eh, 84h, 38h, 7, 5Eh, 26h, 8Bh, 4Ch, 2, 5Eh, 3Bh, 0D9h, 73h, 35h
	db	8Eh, 6, 78h, 7, 50h, 26h, 8Bh, 47h, 2, 3Bh, 6, 32h, 4, 74h, 1Eh
	db	3Bh, 6, 34h, 4, 74h, 18h, 58h, 0BFh, 2, 0, 57h, 0BFh, 0BCh, 7
	db	0E8h, 6Eh, 0F1h, 73h, 3, 0E8h, 5Ch, 0F1h, 26h, 89h, 1Dh, 83h, 0C3h
	db	0Ah, 0EBh, 0CFh, 58h, 26h, 0C6h, 47h, 9, 0FFh, 0EBh, 0F3h, '_Y['
	db	8Bh, 0E5h, 5Dh, 0C3h, 33h, 0C0h, 0BAh, 2, 0, 8Bh, 36h, 0F6h, 3
	db	83h, 0FEh, 0FFh, 74h, 20h, 80h, 3Eh, 19h, 0, 1, 75h, 16h, 56h
	db	83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h
	db	7, 5Eh, 26h, 83h, 7Ch, 0Ah, 1, 74h, 3, 0E8h, 5Eh, 0FEh, 57h, 33h
	db	0F6h, 56h, 0BFh, 34h, 7, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 83h, 7Ch, 0Ah, 0, 75h
	db	3, 0E8h, 3Eh, 0FEh, 3Bh, 36h, 84h, 1, 'tIV', 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Ah
	db	5Ch, 10h, 0B7h, 0, 2Eh, 3, 0B7h, 'PW;u', 2, 73h, 0Ah, 56h, 83h
	db	0C6h, 38h, 83h, 0FEh, 80h, 5Eh, 72h, 0C7h, 81h, 0FFh, 44h, 7, 76h
	db	2, 0EBh, 18h, 83h, 0C7h, 8, 83h, 0E6h, 3, 46h, 56h, 83h, 0E6h
	db	3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 0EBh
	db	0A7h, 83h, 0C4h, 2, 5Fh, 89h, 16h, 0DAh, 3, 0A3h, 0A2h, 4, 0E8h
	db	54h, 0FDh, 0C3h, 0BEh, 0B6h, 0, 0B4h, 0, 0C7h, 6, 50h, 52h, 97h
	db	1, 0E8h, 2, '+rCS', 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 0F6h, 47h, 0Eh, 18h, 'u-&', 8Bh
	db	5Fh, 2, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 38h, 7, 5Bh, 26h, 83h, 7Fh, 0Ah, 2, 73h, 13h, 8Bh, 16h
	db	0DAh, 3, 8Bh, 0F3h, 33h, 0C0h, 0E8h, 95h, 0FDh, 89h, 16h, 0DAh
	db	3, 1, 6, 0A2h, 4, 0C3h, 53h, 50h, 8Eh, 6, 78h, 7, 26h, 0F6h, 44h
	db	9, 0E0h, 't<&', 0F6h, 45h, 9, 0E0h, 't8&', 8Bh, 5Dh, 2, 26h, 8Bh
	db	44h, 2, 3Bh, 0C3h, 't/=', 0FFh, 0FFh, 74h, 24h, 83h, 0FBh, 0FFh
	db	74h, 22h, 80h, 3Eh, 88h, 4, 0, 'tn;', 6, 4Eh, 4, 74h, 15h, 3Bh
	db	1Eh, 4Eh, 4, 74h, 0Ch, 3Bh, 6, 50h, 4, 74h, 9, 3Bh, 1Eh, 50h, 4
	db	75h, 56h, 0F9h, 0EBh, 4Ah, 0F8h, 0EBh, 47h, 26h, 8Bh, 4, 26h, 3Bh
	db	5, 't+P&', 8Bh, 1Dh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h
	db	0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 8Bh, 7, 5Bh, 53h, 83h
	db	0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7
	db	'[&9', 7, 0EBh, 14h, 80h, 3Eh, 0D7h, 3, 1, 75h, 0Bh, 0A1h, 3Ah
	db	4, 3Bh, 0F0h, 74h, 0B9h, 3Bh, 0F8h, 74h, 0B8h, 3Bh, 0F7h, 9Fh
	db	8Eh, 6, 0C0h, 7, 9Eh, 58h, 5Bh, 0C3h, 80h, 3Eh, 0D7h, 3, 1, 't/&'
	db	0FFh, 74h, 2, 26h, 8Bh, 5Dh, 2, 53h, 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 8Bh, 7, 5Bh
	db	53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h
	db	18h, 7, '[&9', 7, 0EBh, 0C1h, 'VWQVW&', 8Bh, 74h, 2, 26h, 8Bh
	db	7Dh, 2, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h
	db	8Eh, 84h, 18h, 7, 5Eh, 33h, 0C9h, 26h, 8Ah, 44h, 2, 25h, 3Fh, 0
	db	3Dh, 4, 0, 72h, 14h, 3, 0F0h, 26h, 81h, 7Ch, 0FFh, 'COu', 0Ah
	db	26h, 81h, 7Ch, 1, 'DEu', 2, 0FEh, 0C1h, 57h, 83h, 0E7h, 3, 0D1h
	db	0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 18h, 7, 5Fh, 26h, 8Ah
	db	45h, 2, 25h, 3Fh, 0, 3Dh, 4, 0, 72h, 14h, 3, 0F8h, 26h, 81h, 7Dh
	db	0FFh, 'COu', 0Ah, 26h, 81h, 7Dh, 1, 'DEu', 2, 0FEh, 0C5h, 5Fh
	db	5Eh, 8Eh, 6, 78h, 7, 3Ah, 0E9h, 74h, 3, 0E9h, 0B3h, 0, 23h, 0C9h
	db	75h, 4Ah, 0A1h, 2Ch, 4, '&;D', 2, 75h, 2, 0FEh, 0C1h, '&;E', 2
	db	75h, 2, 0FEh, 0C5h, 3Ah, 0CDh, 74h, 3, 0E9h, 95h, 0, 23h, 0C9h
	db	74h, 3, 0E9h, 94h, 0, 33h, 0C9h, 0A1h, 24h, 4, 8Eh, 6, 80h, 7
	db	26h, 3Bh, 4, 75h, 2, 0FEh, 0C1h, 26h, 3Bh, 5, 75h, 2, 0FEh, 0C5h
	db	3Ah, 0CDh, 'us#', 0C9h, 'u)Y_^', 8Eh, 6, 78h, 7, 0E9h, 9, 0FFh
	db	33h, 0C9h, 0A1h, 30h, 4, 8Eh, 6, 78h, 7, '&;D', 2, 75h, 2, 0FEh
	db	0C1h, '&;E', 2, 75h, 2, 0FEh, 0C5h, 3Ah, 0CDh, 75h, 48h, 0EBh
	db	4Ch, 33h, 0C9h, 0A1h, 2Eh, 4, 8Eh, 6, 78h, 7, '&;D', 2, 75h, 2
	db	0FEh, 0C1h, '&;E', 2, 75h, 2, 0FEh, 0C5h, 3Ah, 0E9h, 'u)#', 0C9h
	db	'u+3', 0C9h, 0A1h, 26h, 4, '&;D', 2, 75h, 2, 0FEh, 0C1h, '&;E'
	db	2, 75h, 2, 0FEh, 0C5h, 3Ah, 0CDh, 75h, 0Ch, 23h, 0C9h, 75h, 0Eh
	db	'Y_^', 0E9h, 0A6h, 0FEh, 3Ah, 0CDh, 'Y_^', 0E9h, 8Eh, 0FEh, 32h
	db	0C0h, 0EBh, 0F6h, 'PQV&', 8Bh, 47h, 4, 26h, 8Bh, 75h, 4, 26h, 89h
	db	5Dh, 4, 8Eh, 6, 78h, 7, 26h, 8Bh, 4Fh, 6, 83h, 0FEh, 0FFh, 't#V'
	db	83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h
	db	7, 5Eh, 26h, 0FFh, 74h, 0Ah, 26h, 89h, 4Ch, 8, 26h, 89h, 44h, 0Ah
	db	8Bh, 0C6h, 83h, 0C1h, 5, 5Eh, 0EBh, 0D8h, 8Eh, 6, 80h, 7, 26h
	db	89h, 47h, 4, 8Eh, 6, 78h, 7, 26h, 89h, 4Fh, 6, '^YX', 0C3h, 55h
	db	8Bh, 0ECh, 8Dh, 66h, 0FAh, 'VW3', 0F6h, 0A1h, 76h, 7, 89h, 46h
	db	0FEh, 8Eh, 6, 80h, 7, 0EBh, 6, 0E9h, 81h, 0, 83h, 0C6h, 0Ah, 3Bh
	db	76h, 0FEh, 73h, 0F5h, 26h, 83h, 7Ch, 2, 0FFh, 74h, 0F1h, 26h, 8Bh
	db	14h, 8Eh, 6, 78h, 7, 0E8h, 0A0h, 2Bh, 88h, 46h, 0FCh, 8Bh, 0FEh
	db	3Ch, 3, 7Ch, 40h, 0E8h, 34h, 0F3h, 26h, 0C6h, 45h, 9, 60h, 26h
	db	8Bh, 0Ch, 26h, 89h, 0Dh, 26h, 8Bh, 4Ch, 4, 26h, 89h, 4Dh, 4, 8Bh
	db	0Eh, 52h, 4, 26h, 89h, 4Dh, 2, 26h, 0C7h, 45h, 6, 20h, 0, 8Bh
	db	0DFh, 0BFh, 2, 0, 57h, 0BFh, 0BCh, 7, 0E8h, 88h, 0EDh, 73h, 3
	db	0E8h, 76h, 0EDh, 26h, 89h, 1Dh, 8Eh, 6, 80h, 7, 8Bh, 0FEh, 0EBh
	db	1Ah, 0B8h, 0FFh, 0FFh, 8Eh, 6, 80h, 7, 26h, 87h, 45h, 2, 3Dh, 0FEh
	db	0FFh, 74h, 8Eh, 97h, 26h, 89h, 15h, 80h, 7Eh, 0FCh, 3, 75h, 0E6h
	db	0E8h, 15h, 0FFh, 0EBh, 0E1h, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0C3h, 51h
	db	52h, 8Eh, 6, 80h, 7, 26h, 8Bh, 0Ch, 0EBh, 7, 8Eh, 6, 80h, 7, 83h
	db	0C3h, 0Ah, 3Bh, 0DEh, 's7&;', 0Fh, 75h, 5, 83h, 0F9h, 0FFh, 75h
	db	13h, 8Eh, 6, 78h, 7, 26h, 3Bh, 7, 75h, 0E2h, 26h, 8Bh, 54h, 2
	db	'&;W', 2, 75h, 0D8h, 8Eh, 6, 78h, 7, 26h, 8Ah, 77h, 9, 80h, 0FEh
	db	0FFh, 74h, 0CBh, 0F6h, 0C6h, 1Ch, 74h, 0C6h, 0F6h, 0C6h, 2, 75h
	db	0C1h, 5Ah, 59h, 0C3h, 83h, 0F9h, 0FFh, 75h, 0F8h, 83h, 0C3h, 0Ah
	db	3Bh, 1Eh, 76h, 7, 73h, 0EFh, 8Eh, 6, 80h, 7, 26h, 3Bh, 0Fh, 74h
	db	0EEh, 8Eh, 6, 78h, 7, 26h, 3Bh, 7, 75h, 0E5h, 26h, 8Bh, 54h, 2
	db	'&;W', 2, 75h, 0DBh, 26h, 8Ah, 77h, 9, 80h, 0FEh, 0FFh, 74h, 0D2h
	db	0F6h, 0C6h, 1Ch, 74h, 0CDh, 0F6h, 0C6h, 2, 75h, 0C8h, 8Eh, 6, 80h
	db	7, 26h, 8Bh, 0Fh, 26h, 89h, 0Ch, 0EBh, 0B4h, 55h, 8Bh, 0ECh, 'VW3'
	db	0F6h, 0EBh, 0Ch, 8Eh, 6, 78h, 7, 26h, 0C6h, 44h, 9, 0FFh, 83h
	db	0C6h, 0Ah, ';6v', 7, 73h, 73h, 8Eh, 6, 78h, 7, 26h, 8Ah, 54h, 9
	db	80h, 0FAh, 0FFh, 74h, 0EAh, 26h, 8Bh, 5Ch, 4, 53h, 83h, 0E3h, 3
	db	0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 38h, 7, 5Bh, 26h
	db	8Bh, 47h, 0Ah, 3Dh, 1, 0, 74h, 0C5h, 8Eh, 6, 80h, 7, 26h, 0C7h
	db	44h, 2, 0FEh, 0FFh, 0F6h, 0C2h, 1Ch, 74h, 0BFh, 0F6h, 0C2h, 2
	db	75h, 0BAh, 8Eh, 6, 78h, 7, 26h, 8Bh, 4, 33h, 0DBh, 0E8h, 6, 0FFh
	db	3Bh, 0DEh, 73h, 0AAh, 8Eh, 6, 80h, 7, 26h, 8Bh, 4, 3Dh, 0FFh, 0FFh
	db	74h, 0Eh, 26h, 39h, 7, 74h, 9, 26h, 83h, 3Fh, 0FFh, 75h, 18h, 26h
	db	89h, 7, 8Bh, 0C6h, 26h, 87h, 47h, 2, 26h, 89h, 44h, 2, 0EBh, 84h
	db	0E8h, 39h, 0FEh, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0C3h, 'SVW', 8Eh, 6
	db	78h, 7, 26h, 0FFh, 34h, 8Eh, 6, 80h, 7, 26h, 0FFh, 37h, 0BFh, 78h
	db	0, 8Bh, 0F0h, 0E8h, 90h, 2Eh, 1Eh, 0B8h, 78h, 0, 50h, 0Eh, 0B8h
	db	'bWP', 9Ah, 0Eh, 0, 0CFh, 0, 0BFh, 28h, 0, 5Eh, 0E8h, 7Ah, 2Eh
	db	1Eh, 0B8h, 78h, 0, 50h, 1Eh, 0B8h, 28h, 0, 50h, 9Ah, 0Eh, 0, 0CFh
	db	0, 5Eh, 0BFh, 28h, 0, 0E8h, 64h, 2Eh, 1Eh, 0B8h, 78h, 0, 50h, 1Eh
	db	0B8h, 28h, 0, 50h, 0B9h, 8, 0, 51h, 0B8h, 35h, 0, 50h, 0E8h, 0BAh
	db	'R_^[', 8Eh, 6, 80h, 7, 0EBh, 88h, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ch
	db	'RVW', 80h, 3Eh, 28h, 1, 1, 75h, 6, 0BFh, 0ECh, 7, 0E8h, 0C6h
	db	0ECh, 33h, 0FFh, 8Bh, 0CFh, 0BBh, 0FFh, 0FFh, 3Bh, 3Eh, 0BEh, 7
	db	72h, 3, 0E9h, 37h, 1, 89h, 7Eh, 0FAh, 8Eh, 6, 0C0h, 7, 26h, 8Bh
	db	35h, 8Eh, 6, 78h, 7, 0E8h, 6Bh, 29h, 88h, 46h, 0F6h, 3Ch, 0FFh
	db	75h, 0Bh, 83h, 3Eh, 3Bh, 0Ah, 0FFh, 75h, 4, 89h, 36h, 3Bh, 0Ah
	db	26h, 8Ah, 44h, 9, 3Ch, 0FFh, 75h, 3, 0E9h, 0EEh, 0, 0A8h, 0E0h
	db	74h, 0Eh, 24h, 1Ch, 74h, 0Ah, 26h, 3Bh, 1Ch, 'tJ&', 8Bh, 1Ch, 8Bh
	db	0CEh, 26h, 8Bh, 44h, 6, 89h, 46h, 0FEh, 26h, 8Ah, 44h, 8, 0B4h
	db	0, 89h, 46h, 0FCh, 8Eh, 6, 80h, 7, 26h, 89h, 74h, 2, 80h, 3Eh
	db	28h, 1, 1, 75h, 23h, 0BFh, 6, 0, 57h, 0BFh, 0ECh, 7, 0E8h, 34h
	db	0EBh, 73h, 3, 0E8h, 22h, 0EBh, 26h, 89h, 35h, 8Bh, 46h, 0FCh, 26h
	db	89h, 45h, 4, 8Bh, 46h, 0FEh, 26h, 89h, 45h, 2, 89h, 7Eh, 0F8h
	db	0E9h, 97h, 0, 8Eh, 6, 80h, 7, 26h, 89h, 4Ch, 2, 3Ch, 18h, 72h
	db	1Ah, 8Bh, 0F9h, 8Eh, 6, 78h, 7, 26h, 8Bh, 44h, 6, '&;E', 6, 76h
	db	8, 26h, 87h, 45h, 6, 26h, 87h, 44h, 6, 0EBh, 71h, 8Bh, 56h, 0FCh
	db	8Bh, 46h, 0FEh, 51h, 53h, 8Eh, 6, 78h, 7, 26h, 8Ah, 4Ch, 9, 80h
	db	0E1h, 0E0h, 80h, 0F9h, '@r$t', 16h, 80h, 0F9h, 80h, 74h, 7, 77h
	db	0Ah, 0BBh, 0Fh, 0, 0EBh, 0Dh, 0BBh, 0FFh, 0, 0EBh, 8, 0BBh, 3
	db	0, 0EBh, 3, 0BBh, 1, 0, 3, 0C3h, 83h, 0D2h, 0, 23h, 0D8h, 33h
	db	0C3h, 5Bh, 26h, 3, 44h, 6, 26h, 12h, 54h, 8, 89h, 46h, 0FEh, 89h
	db	56h, 0FCh, 59h, 0Bh, 0D2h, 74h, 0Bh, 0Bh, 0C0h, 74h, 7, 80h, 3Eh
	db	27h, 1, 0, 74h, 38h, 80h, 3Eh, 28h, 1, 1, 75h, 0Fh, 8Bh, 7Eh, 0F8h
	db	8Eh, 6, 0F0h, 7, 26h, 89h, 55h, 4, 26h, 89h, 45h, 2, 80h, 7Eh
	db	0F6h, 0FFh, 75h, 0Ch, 8Bh, 46h, 0FEh, 0A3h, 45h, 0Ah, 8Bh, 46h
	db	0FCh, 0A3h, 47h, 0Ah, 8Bh, 7Eh, 0FAh, 83h, 0C7h, 2, 0E9h, 0C0h
	db	0FEh, '_^Z', 8Bh, 0E5h, 5Dh, 0C3h, 83h, 3Eh, 3Fh, 0Ah, 0FFh, 75h
	db	0D7h, 8Eh, 6, 78h, 7, 'PSQRVW&', 8Bh, 34h, 0BFh, 28h, 0, 0E8h
	db	0C8h, 2Ch, 1Eh, 0BBh, 28h, 0, 53h, 0B9h, 4, 0, 51h, 0B8h, 0Ah
	db	0, 50h, 0E8h, 1Eh, 51h, 80h, 0Eh, 10h, 4, 4, '_^ZY[X', 0EBh, 0A7h
	db	'PSQV', 0E8h, 9Ah, 48h, 83h, 0FBh, 0, 74h, 41h, 8Bh, 36h, 76h
	db	7, 0Bh, 0F6h, 74h, 39h, 0B9h, 0FFh, 0FFh, 8Eh, 6, 78h, 7, 0EBh
	db	2Bh, 0E8h, 0E7h, 27h, 3Ch, 0FFh, 74h, 7, 83h, 0F9h, 0FFh, 75h
	db	24h, 0EBh, 1Dh, 83h, 0F9h, 0FFh, 75h, 0Dh, 8Bh, 0CEh, 26h, 0C6h
	db	44h, 8, 0, 26h, 89h, 5Ch, 6, 0EBh, 0Bh, 26h, 0C6h, 44h, 8, 0, 26h
	db	0C7h, 44h, 6, 0, 0, 83h, 0EEh, 0Ah, 75h, 0D0h, '^Y[X', 0C3h, 'QS&'
	db	8Bh, 0Dh, 83h, 0F9h, 0FFh, 't,3', 0DBh, 3Bh, 1Eh, 0B6h, 7, 73h
	db	0Eh, 8Eh, 6, 0B8h, 7, 26h, 39h, 0Fh, 74h, 1Bh, 83h, 0C3h, 4, 0EBh
	db	0ECh, 0BFh, 4, 0, 57h, 0BFh, 0B4h, 7, 0E8h, 0ACh, 0E9h, 73h, 3
	db	0E8h, 9Ah, 0E9h, 26h, 89h, 0Fh, 26h, 89h, 77h, 2, 5Bh, 59h, 0C3h
	db	55h, 8Bh, 0ECh, 33h, 0FFh, 3Bh, 3Eh, 0B6h, 7, 73h, 11h, 8Eh, 6
	db	0B8h, 7, 8Bh, 46h, 4, 26h, 39h, 5, 74h, 0Bh, 83h, 0C7h, 4, 0EBh
	db	0E9h, 0B8h, 3, 0, 0E8h, 0E7h, 27h, 26h, 8Bh, 45h, 2, 8Bh, 0E5h
	db	5Dh, 0C2h, 2, 0, 8Bh, 36h, 0BEh, 7, 0EBh, 0Eh, 8Eh, 6, 0C0h, 7
	db	26h, 8Bh, 3Ch, 8Eh, 6, 80h, 7, 0E8h, 87h, 0FFh, 83h, 0EEh, 2, 73h
	db	0EDh, 0C3h, 50h, 51h, 0B9h, 14h, 0, 8Bh, 0F9h, 57h, 0BFh, 9Ch
	db	7, 0E8h, 49h, 0E9h, 73h, 3, 0E8h, 37h, 0E9h, 57h, 0B0h, 0, 0FCh
	db	0F3h, 0AAh, 5Fh, 26h, 89h, 75h, 4, 0A1h, 0BBh, 6, 40h, 0A3h, 0BBh
	db	6, 26h, 89h, 45h, 6, 59h, 58h, 0C3h, 57h, 33h, 0FFh, 8Eh, 6, 0F0h
	db	7, 0EBh, 8, '&;5t', 11h, 83h, 0C7h, 6, 3Bh, 3Eh, 0EEh, 7, 72h
	db	0F2h, 0B8h, 4, 0, 0E8h, 7Ah, 27h, 0EBh, 1Ah, 26h, 83h, 7Dh, 4
	db	0, 75h, 0F7h, 83h, 3Eh, 44h, 1, 0, 74h, 12h, 26h, 3, 45h, 2, 72h
	db	6, 3Bh, 6, 44h, 1, 76h, 3, 0F9h, 0EBh, 9, 0F8h, 0EBh, 6, 26h, 3
	db	45h, 2, 72h, 0, 5Fh, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 1Ah, 56h
	db	57h, 0E8h, 68h, 0FFh, 0B8h, 0FFh, 0FFh, 89h, 46h, 0F8h, 89h, 46h
	db	0EEh, 89h, 46h, 0ECh, 89h, 46h, 0E6h, 33h, 0F6h, 0EBh, 9, 0E9h
	db	63h, 3, 8Bh, 76h, 0FAh, 83h, 0C6h, 2, 3Bh, 36h, 0BEh, 7, 73h, 0F1h
	db	89h, 76h, 0FAh, 8Eh, 6, 0C0h, 7, 26h, 8Bh, 34h, 8Eh, 6, 80h, 7
	db	80h, 3Eh, 0D7h, 3, 1, 'u;&', 8Bh, 0Ch, 8Eh, 6, 78h, 7, 26h, 8Bh
	db	54h, 2, 83h, 3Eh, 37h, 0Ah, 0FFh, 75h, 12h, 3Bh, 0Eh, 24h, 4, 75h
	db	0Ch, 3Bh, 16h, 26h, 4, 75h, 6, 89h, 36h, 37h, 0Ah, 0EBh, 17h, 83h
	db	3Eh, 39h, 0Ah, 0FFh, 75h, 10h, 3Bh, 0Eh, 24h, 4, 75h, 0Ah, 3Bh
	db	16h, 2Ch, 4, 75h, 4, 89h, 36h, 39h, 0Ah, 8Eh, 6, 78h, 7, 0E8h
	db	3Fh, 26h, 88h, 46h, 0EAh, 26h, 8Ah, 54h, 9, 88h, 56h, 0E8h, 0F6h
	db	0C2h, 0E0h, 74h, 8Eh, 26h, 8Bh, 44h, 6, 89h, 46h, 0F2h, 26h, 8Ah
	db	44h, 8, 0B4h, 0, 89h, 46h, 0F4h, 8Eh, 6, 80h, 7, 33h, 0C0h, 26h
	db	87h, 44h, 6, 89h, 46h, 0FCh, 26h, 8Bh, 5Ch, 2, 0BFh, 0FFh, 0FFh
	db	26h, 87h, 3Ch, 89h, 7Eh, 0FEh, 83h, 0FFh, 0FFh, 75h, 9, 83h, 7Eh
	db	0EEh, 0FFh, 75h, 25h, 0E9h, 98h, 0, 83h, 7Eh, 0EEh, 0FFh, 75h
	db	1Ch, 57h, 57h, 0E8h, 71h, 0FEh, 5Fh, 89h, 46h, 0EEh, 89h, 7Eh
	db	0ECh, 39h, 46h, 0FAh, 74h, 3, 0E9h, 0CFh, 0, 0C7h, 46h, 0EEh, 0FFh
	db	0FFh, 0E9h, 0C7h, 0, 8Bh, 46h, 0FAh, 3Bh, 46h, 0EEh, 74h, 67h
	db	8Bh, 4Eh, 0FEh, 83h, 0F9h, 0FFh, 't=;N', 0ECh, 74h, 38h, 0A0h
	db	19h, 0, 0Ah, 6, 88h, 4, 't/V', 8Bh, 76h, 0ECh, 0BFh, 28h, 0, 0E8h
	db	52h, 2Ah, 8Bh, 76h, 0FEh, 0BFh, 78h, 0, 0E8h, 49h, 2Ah, 1Eh, 0B8h
	db	78h, 0, 50h, 1Eh, 0B8h, 28h, 0, 50h, 0C7h, 6, 22h, 4, 1, 0, 0B9h
	db	8, 0, 51h, 0B8h, 36h, 0, 50h, 0E8h, 99h, 4Eh, 5Eh, 8Eh, 6, 80h
	db	7, 8Bh, 46h, 0ECh, 26h, 89h, 4, 8Bh, 7Eh, 0ECh, 57h, 83h, 0E7h
	db	3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 18h, 7, 5Fh, 26h
	db	8Bh, 3Dh, 0E9h, 4, 1, 0C7h, 46h, 0EEh, 0FFh, 0FFh, 0EBh, 0E1h
	db	0F6h, 0C2h, 1Ch, 75h, 3, 0E9h, 8Fh, 0, 0F6h, 0C2h, 2, 74h, 3, 0E9h
	db	87h, 0, 8Eh, 6, 78h, 7, 26h, 8Bh, 4, 8Bh, 5Eh, 0FAh, 83h, 0EBh
	db	2, 7Ch, 32h, 8Eh, 6, 0C0h, 7, 26h, 8Bh, 1Fh, 8Eh, 6, 78h, 7, 26h
	db	3Bh, 7, 'u"&', 8Bh, 47h, 2, '&;D', 2, 75h, 18h, 26h, 8Ah, 77h
	db	9, 0F6h, 0C6h, 1Ch, 74h, 0Fh, 0F6h, 0C6h, 2, 75h, 0Ah, 8Eh, 6
	db	80h, 7, 26h, 8Bh, 3Fh, 0E9h, 0ACh, 0, 80h, 3Eh, 28h, 1, 1, 75h
	db	3Fh, 80h, 7Eh, 0EAh, 1, 75h, 39h, 83h, 7Eh, 0FEh, 0FFh, 75h, 33h
	db	83h, 7Eh, 0F8h, 0FFh, 74h, 2Dh, 8Bh, 46h, 0F6h, 0E8h, 0E6h, 0FDh
	db	72h, 25h, 8Bh, 5Eh, 0F8h, 0EBh, 0D0h, 8Bh, 7Eh, 0E6h, 83h, 0FFh
	db	0FFh, 74h, 22h, 8Eh, 6, 0A0h, 7, 26h, 83h, 7Dh, 0Dh, 0, 75h, 17h
	db	26h, 83h, 7Dh, 0Fh, 0, 75h, 10h, 26h, 89h, 75h, 4, 0EBh, 10h, 80h
	db	0E2h, 0E0h, 80h, 3Eh, 19h, 0, 0, 75h, 0D6h, 0E8h, 86h, 0FDh, 89h
	db	7Eh, 0E6h, 26h, 88h, 15h, 8Bh, 46h, 0FCh, 26h, 89h, 45h, 11h, 8Bh
	db	46h, 0F2h, 8Bh, 4Eh, 0F4h, 26h, 89h, 45h, 0Dh, 26h, 89h, 4Dh, 0Fh
	db	8Ah, 46h, 0EAh, 26h, 88h, 45h, 1, 3Ch, 3, 7Ch, 0Bh, 83h, 3Eh, 4
	db	4, 0FFh, 75h, 4, 89h, 3Eh, 4, 4, 8Bh, 5Eh, 0FEh, 26h, 89h, 5Dh
	db	2, 83h, 0FBh, 0FFh, 74h, 12h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h
	db	0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 89h, 3Fh, 8Eh, 6
	db	80h, 7, 26h, 89h, 3Ch, 0E9h, 1, 1, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 45h
	db	4, 89h, 46h, 0F0h, 8Ah, 0F2h, 81h, 0E2h, 0E0h, 1Ch, 26h, 3Ah, 15h
	db	76h, 3, 26h, 88h, 15h, 80h, 3Eh, 19h, 0, 1, 75h, 0Bh, 80h, 7Eh
	db	0EAh, 1, 75h, 5, 26h, 0C6h, 45h, 1, 1, 80h, 7Eh, 0EAh, 0FFh, 75h
	db	10h, 83h, 3Eh, 3Bh, 0Ah, 0FFh, 75h, 4, 89h, 1Eh, 3Bh, 0Ah, 26h
	db	0C6h, 45h, 1, 0FFh, 8Bh, 46h, 0FCh, 26h, 1, 45h, 11h, 26h, 8Bh
	db	45h, 0Dh, 26h, 8Bh, 4Dh, 0Fh, 3Bh, 0DEh, 74h, 0Ah, 80h, 0FEh, 14h
	db	74h, 5, 80h, 0FEh, 8, 75h, 14h, 53h, 80h, 0FAh, '@r7t)', 80h, 0FAh
	db	80h, 74h, 1Ah, 77h, 1Dh, 0BBh, 0Fh, 0, 0EBh, 20h, 8Eh, 6, 80h
	db	7, 26h, 0FFh, 77h, 6, 26h, 0FFh, 77h, 8, 80h, 0FEh, 18h, 72h, 1Bh
	db	0EBh, 2Eh, 0BBh, 0FFh, 0, 0EBh, 8, 0BBh, 3, 0, 0EBh, 3, 0BBh, 1
	db	0, 3, 0C3h, 83h, 0D1h, 0, 23h, 0D8h, 33h, 0C3h, '[PQ', 3, 46h
	db	0F2h, 13h, 4Eh, 0F4h, 80h, 3Eh, 27h, 1, 0, 75h, 8, 0Bh, 0C9h, 74h
	db	4, 0Bh, 0C0h, 75h, 77h, 8Eh, 6, 0A0h, 7, 26h, 89h, 45h, 0Dh, 26h
	db	89h, 4Dh, 0Fh, 8Eh, 6, 80h, 7, 59h, 26h, 88h, 4Ch, 8, 26h, 8Fh
	db	44h, 6, 26h, 89h, 3Ch, 80h, 3Eh, 19h, 0, 0, 'u+;v', 0F0h, 't&&;t'
	db	2, 75h, 20h, 80h, 7Eh, 0EAh, 1, 7Dh, 1Ah, 26h, 8Bh, 44h, 6, 0E8h
	db	3Fh, 0FCh, 26h, 0C6h, 5, 20h, 26h, 0C7h, 45h, 11h, 0, 0, 26h, 89h
	db	45h, 0Bh, 26h, 0C6h, 45h, 1, 0FEh, 80h, 3Eh, 28h, 1, 1, 75h, 19h
	db	0C7h, 46h, 0F8h, 0FFh, 0FFh, 80h, 7Eh, 0EAh, 1, 75h, 0Eh, 89h
	db	76h, 0F8h, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 45h, 0Dh, 89h, 46h, 0F6h
	db	0E9h, 9Dh, 0FCh, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0C3h, 8Eh, 6, 80h, 7
	db	83h, 7Eh, 0ECh, 0FFh, 75h, 9, 26h, 83h, 3Ch, 0FFh, 75h, 3, 0E9h
	db	76h, 0FFh, 83h, 3Eh, 3Dh, 0Ah, 0FFh, 74h, 3, 0E9h, 6Ch, 0FFh, 0C7h
	db	6, 3Dh, 0Ah, 1, 0, 'PSQRVW', 8Bh, 76h, 0ECh, 83h, 0FEh, 0FFh, 75h
	db	3, 26h, 8Bh, 34h, 0BFh, 28h, 0, 0E8h, 0A3h, 27h, 1Eh, 0BBh, 28h
	db	0, 53h, 0B9h, 4, 0, 51h, 0B8h, 9, 0, 50h, 0E8h, 0F9h, 4Bh, 80h
	db	0Eh, 10h, 4, 4, '_^ZY[X', 0E9h, 31h, 0FFh, 55h, 8Bh, 0ECh, 83h
	db	0ECh, 6, 2Bh, 0C9h, 88h, 4Eh, 0FCh, 89h, 0Eh, 0B7h, 6, 89h, 0Eh
	db	0B9h, 6, 89h, 0Eh, 0AAh, 4, 89h, 0Eh, 0ACh, 4, 2Bh, 0C9h, 2Bh
	db	0D2h, 2Bh, 0F6h, 8Bh, 0FEh, 0EBh, 36h, 0B8h, 0Fh, 0, 3, 0C8h, 12h
	db	0D6h, 80h, 0E1h, 0F0h, 23h, 0C2h, 0Bh, 0C1h, 0D1h, 0C8h, 0D1h
	db	0C8h, 0D1h, 0C8h, 0D1h, 0C8h, 0A3h, 18h, 4, 83h, 0C1h, 10h, 12h
	db	0D6h, 0C3h, 83h, 3Eh, 14h, 4, 1, 75h, 0Ah, 83h, 3Eh, 18h, 4, 0FFh
	db	75h, 3, 0E8h, 0D0h, 0FFh, 0E9h, 46h, 1, 83h, 0C6h, 14h, 3Bh, 36h
	db	9Eh, 7, 73h, 0E3h, 3Bh, 36h, 4, 4, 75h, 3, 0E8h, 0BBh, 0FFh, 8Eh
	db	6, 0A0h, 7, 80h, 3Eh, 19h, 0, 0, 75h, 12h, 26h, 8Ah, 44h, 1, 3Ch
	db	0FEh, 74h, 0DBh, 3Ch, 0FDh, 74h, 0D7h, 3Ch, 3, 7Dh, 2, 0EBh, 42h
	db	8Bh, 1Eh, 0FAh, 3, 3, 0CBh, 83h, 0D2h, 0, 23h, 0D9h, 33h, 0CBh
	db	26h, 8Bh, 44h, 0Dh, 89h, 46h, 0FEh, 26h, 8Bh, 5Ch, 11h, 80h, 3Eh
	db	19h, 0, 0, 75h, 8, 83h, 0FBh, 3, 73h, 3, 0BBh, 3, 0, 80h, 3Eh
	db	19h, 0, 0, 74h, 5, 83h, 0FBh, 0, 74h, 45h, 87h, 0D3h, 0E8h, 4
	db	0EAh, 87h, 0DAh, 26h, 0C7h, 44h, 11h, 0, 0, 0EBh, 36h, 26h, 80h
	db	'<@r%t', 17h, 26h, 80h, 3Ch, 80h, 74h, 7, 77h, 0Ah, 0BBh, 0Fh
	db	0, 0EBh, 0Dh, 0BBh, 0FFh, 0, 0EBh, 8, 0BBh, 3, 0, 0EBh, 3, 0BBh
	db	1, 0, 3, 0CBh, 83h, 0D2h, 0, 23h, 0D9h, 33h, 0CBh, 26h, 8Bh, 44h
	db	0Dh, 89h, 46h, 0FEh, 26h, 8Bh, 5Ch, 0Fh, 'RQSP', 0B8h, 0Fh, 0
	db	23h, 0C1h, 26h, 89h, 44h, 0Bh, 33h, 0C1h, 0B9h, 4, 0, 0D1h, 0EAh
	db	0D1h, 0D8h, 0E2h, 0FAh, 26h, 89h, 44h, 8, 26h, 88h, 54h, 0Ah, 26h
	db	80h, 7Ch, 1, 0FFh, 75h, 6Dh, 0C6h, 6, 0D3h, 3, 1, 0A3h, 0AAh, 4
	db	80h, 3Eh, 2Bh, 1, 3, 74h, 0Eh, 26h, 8Bh, 5Ch, 6, 89h, 1Eh, 0B9h
	db	6, 8Bh, 46h, 0FEh, 0A3h, 0B7h, 6, 'X[YZPSQ', 80h, 3Eh, 19h, 0
	db	1, 74h, 20h, 8Bh, 1Eh, 3Bh, 0Ah, 83h, 0FBh, 0FFh, 74h, 17h, 0C6h
	db	46h, 0FCh, 1, 8Eh, 6, 80h, 7, 26h, 8Bh, 47h, 6, 0B1h, 4, 0D3h
	db	0E8h, 1, 6, 0AAh, 4, 0A1h, 45h, 0Ah, 59h, 5Bh, 0A3h, 0ACh, 4, 58h
	db	80h, 3Eh, 2Bh, 1, 1, 74h, 63h, 80h, 7Eh, 0FCh, 1, 74h, 6, 0Bh
	db	0DBh, 74h, 0Fh, 0EBh, 61h, 83h, 3Eh, 47h, 0Ah, 0, 75h, 5Ah, 0EBh
	db	4, 'X[YZ', 3, 0C8h, 13h, 0D3h, 0E9h, 0BAh, 0FEh, 89h, 16h, 0DEh
	db	3, 89h, 0Eh, 0DCh, 3, 80h, 3Eh, 2Bh, 1, 1, 74h, 5Bh, 0C7h, 6, 0F2h
	db	3, 3Eh, 0, 0C7h, 6, 0F4h, 3, 0, 0, 0A1h, 0A2h, 4, 5, 8Fh, 0, 24h
	db	80h, 0D1h, 0E8h, 0D1h, 0E8h, 0A3h, 0A4h, 4, 0A3h, 0FEh, 3, 0C7h
	db	6, 0B4h, 4, 3Eh, 0, 0C7h, 6, 0AEh, 4, 0, 0, 0C7h, 6, 0A2h, 4, 0
	db	0, 8Bh, 0E5h, 5Dh, 0C3h, 33h, 0C0h, 50h, 0B8h, 13h, 0, 50h, 0E8h
	db	0FBh, 'IPSQRVW3', 0C9h, 51h, 0B8h, 0Bh, 0, 50h, 0E8h, 0F0h, 49h
	db	80h, 0Eh, 10h, 4, 2, '_^ZY[X', 0EBh, 8Fh, 51h, 0E8h, 0C2h, 1Eh
	db	59h, 0B8h, 0, 0, 75h, 4, 0Bh, 0D2h, 75h, 2, 0EBh, 0ADh, 33h, 0C0h
	db	50h, 0B8h, 14h, 0, 50h, 0E8h, 0C4h, 'IPSRVW+', 0F6h, 0EBh, 31h
	db	8Eh, 6, 78h, 7, 26h, 80h, 7Ch, 9, 0FFh, 't#&', 0F6h, 44h, 9, 0E0h
	db	74h, 1Ch, 8Eh, 6, 80h, 7, 26h, 8Bh, 3Ch, 8Eh, 6, 0A0h, 7, 26h
	db	8Bh, 45h, 0Bh, 8Eh, 6, 80h, 7, 26h, 1, 44h, 6, 26h, 80h, 54h, 8
	db	0, 83h, 0C6h, 0Ah, ';6v', 7, 72h, 0C9h, '_^Z[X', 0C3h, 'PSRVW+'
	db	0F6h, 56h, 0BBh, 54h, 7, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 0EBh, 38h, 26h, 8Ah, 44h, 0Eh
	db	0A8h, 18h, 75h, 2Ch, 0A8h, 2, 'u(&', 8Bh, 3Ch, 8Eh, 6, 80h, 7
	db	26h, 8Bh, 45h, 6, 26h, 8Ah, 55h, 8, 0B6h, 0, 56h, 83h, 0E6h, 3
	db	0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 26h
	db	1, 44h, 4, 26h, 11h, 54h, 6, 3, 36h, 90h, 4, 3Bh, 77h, 2, 72h
	db	0C3h, 81h, 0FBh, 64h, 7, 77h, 8, 83h, 0C3h, 8, '^FV', 0EBh, 0A4h
	db	'^_^Z[X', 0C3h, 55h, 8Bh, 0ECh, 2Bh, 0F6h, 0EBh, 7, 26h, 8Bh, 54h
	db	8, 83h, 0C6h, 14h, 3Bh, 36h, 9Eh, 7, 73h, 2Ch, 8Eh, 6, 0A0h, 7
	db	26h, 80h, 7Ch, 1, 0FEh, 75h, 0E8h, 26h, 8Bh, 44h, 0Bh, 0B9h, 0Fh
	db	0, 23h, 0C8h, 33h, 0C1h, 26h, 89h, 4Ch, 0Bh, 0B1h, 4, 0D3h, 0C8h
	db	3, 0C2h, 26h, 89h, 44h, 8, 26h, 0C7h, 44h, 0Dh, 0FFh, 0FFh, 0EBh
	db	0CBh, 8Bh, 0E5h, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 80h
	db	3Eh, 19h, 0, 0, 74h, 17h, 80h, 3Eh, 16h, 0, 0, 75h, 10h, 0B8h
	db	0, 40h, 0F7h, 26h, 84h, 4, 3, 6, 86h, 4, 83h, 0D2h, 0, 0EBh, 16h
	db	0BAh, 10h, 0, 0F7h, 0E2h, 3, 6, 0DCh, 3, 13h, 16h, 0DEh, 3, 5
	db	0Fh, 0, 83h, 0D2h, 0, 25h, 0F0h, 0FFh, 0E8h, 8Bh, 21h, 80h, 3Eh
	db	19h, 0, 0, 74h, 2Ah, 80h, 3Eh, 16h, 0, 0, 't#RP', 0BFh, 0FBh, 6
	db	57h, 1Eh, 7, 0B8h, 4Eh, 42h, 0ABh, 0B8h, 30h, 32h, 0ABh, 0B9h
	db	0Ch, 0, 0D1h, 0E9h, 0B8h, 0FFh, 0FFh, 0F3h, 0ABh, '^XZ', 0B9h
	db	10h, 0, 0E8h, 1Ah, 16h, 89h, 46h, 0FCh, 89h, 56h, 0FEh, 0BEh, 0DAh
	db	4, 0C7h, 4, 0FBh, 52h, 0B8h, 0, 3, 80h, 3Eh, 2Fh, 1, 1, 75h, 3
	db	0B8h, 9, 2, 89h, 44h, 2, 0A0h, 22h, 1, 88h, 44h, 28h, 8Bh, 46h
	db	0FCh, 8Bh, 56h, 0FEh, 80h, 3Eh, 19h, 0, 1, 74h, 15h, 83h, 3Eh
	db	18h, 4, 0FFh, 74h, 0Eh, 3, 6, 68h, 6, 13h, 16h, 6Ah, 6, 5, 10h
	db	0, 83h, 0D2h, 0, 89h, 44h, 20h, 89h, 54h, 22h, 80h, 3Eh, 16h, 0
	db	0, 75h, 10h, 80h, 3Eh, 19h, 0, 0, 75h, 13h, 33h, 0C9h, 80h, 3Eh
	db	16h, 0, 0, 74h, 7, 0B9h, 30h, 0, 3, 0Eh, 8, 5, 0E8h, 0AEh, 15h
	db	80h, 3Eh, 19h, 0, 0, 74h, 44h, 80h, 3Eh, 16h, 0, 0, 74h, 3Dh, 0BFh
	db	0Bh, 7, 57h, 1Eh, 7, 0B8h, 4Eh, 42h, 0ABh, 0B8h, 30h, 32h, 0ABh
	db	0B8h, 0, 40h, 0F7h, 26h, 84h, 4, 3, 6, 86h, 4, 83h, 0D2h, 0, 'RP+F'
	db	0FCh, 1Bh, 56h, 0FEh, 5, 10h, 0, 83h, 0D2h, 0, 5, 8, 0, 83h, 0D2h
	db	0, 0ABh, 8Bh, 0C2h, 0ABh, 'XZ^', 0B9h, 8, 0, 0E8h, 63h, 15h, 33h
	db	0D2h, 8Bh, 0E5h, 5Dh, 0C3h, 33h, 0C0h, 50h, 0B8h, 32h, 0, 50h
	db	0E8h, 0A1h, 47h, 0C3h, 0A1h, 84h, 4, 40h, 75h, 18h, 0B8h, 10h
	db	0, 0F7h, 26h, 0A4h, 4, 50h, 25h, 0FFh, 7Fh, 0A3h, 86h, 4, 58h
	db	0B1h, 0Fh, 0D3h, 0E8h, 0D1h, 0E0h, 0A3h, 84h, 4, 0A1h, 18h, 4
	db	3Dh, 0FFh, 0FFh, 74h, 0Eh, 0BAh, 10h, 0, 0F7h, 0E2h, 0A3h, 0DCh
	db	3, 89h, 16h, 0DEh, 3, 0EBh, 7, 80h, 3Eh, 16h, 0, 0, 74h, 8, 0A1h
	db	0A4h, 4, 0E8h, 89h, 0FEh, 0EBh, 42h, 0B8h, 0, 40h, 0F7h, 26h, 84h
	db	4, 3, 6, 86h, 4, 83h, 0D2h, 0, 0E8h, 3Eh, 20h, 8Bh, 1Eh, 0A4h
	db	4, 0B1h, 4, 0D3h, 0E3h, 2Bh, 0C3h, 83h, 0DAh, 0, 8Bh, 0Eh, 0DEh
	db	3, 8Bh, 1Eh, 0DCh, 3, 83h, 0C3h, 0Fh, 83h, 0D1h, 0, 2Bh, 0D8h
	db	1Bh, 0CAh, 0D1h, 0E9h, 0D1h, 0DBh, 0D1h, 0E9h, 0D1h, 0DBh, 0D1h
	db	0E9h, 0D1h, 0DBh, 0D1h, 0E9h, 0D1h, 0DBh, 8Bh, 0D3h, 89h, 16h
	db	0A6h, 4, 0C7h, 6, 0A8h, 4, 0FFh, 0FFh, 0C7h, 6, 0B6h, 4, 0, 0
	db	0C7h, 6, 0B8h, 4, 1, 0, 83h, 3Eh, 0B2h, 4, 0FFh, 75h, 0Ch, 0C7h
	db	6, 0B2h, 4, 0, 0, 0C7h, 6, 0B0h, 4, 0, 0, 0C7h, 6, 9Ch, 4, 4Dh
	db	5Ah, 0C7h, 6, 0BAh, 4, 0FBh, 30h, 0C7h, 6, 0BCh, 4, 'jr+', 0C0h
	db	99h, 0B9h, 3Eh, 0, 0BEh, 9Ch, 4, 0E8h, 86h, 14h, 8Bh, 3Eh, 41h
	db	0B4h, 0E8h, 2, 21h, 17h, 'Program entry point at ', 0A1h, 0B2h
	db	4, 0E8h, 74h, 20h, 0B0h, 3Ah, 0E8h, 0Eh, 20h, 0A1h, 0B0h, 4, 0E8h
	db	69h, 20h, 0E8h, 7Ch, 20h, 89h, 3Eh, 41h, 0B4h, 80h, 3Eh, 0D3h
	db	3, 1, 74h, 0Ah, 80h, 3Eh, 2Ch, 1, 1, 74h, 3, 0E8h, 0E1h, 0FEh
	db	0C3h, 0C7h, 6, 14h, 4, 0, 0, 0C7h, 6, 16h, 4, 0, 0, 8Bh, 1Eh, 8
	db	4, 83h, 0FBh, 0FFh, 75h, 3, 0E9h, 0B6h, 0, 8Eh, 6, 78h, 7, 26h
	db	80h, 7Fh, 9, 0FFh, 75h, 3, 0E9h, 0A8h, 0, 26h, 8Bh, 77h, 4, 26h
	db	8Bh, 57h, 6, 8Eh, 6, 80h, 7, 26h, 8Bh, 1Fh, 52h, 0F7h, 6, 7Ah
	db	4, 3, 0, 74h, 4Fh, 0C7h, 6, 14h, 4, 1, 0, 0A1h, 0BBh, 6, 53h, 8Eh
	db	6, 0A0h, 7, 8Bh, 1Eh, 4, 4, 83h, 0FBh, 0FFh, 74h, 5, 26h, 8Bh
	db	47h, 6, 'H[&', 1, 47h, 11h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h
	db	0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 1, 44h, 0Eh, 1, 6
	db	0A2h, 4, 0D1h, 0E0h, 0D1h, 0E0h, 0D1h, 0E0h, 3, 0D0h, 0F7h, 6
	db	7Ah, 4, 2, 0, 74h, 7, 8Bh, 3Eh, 5Ah, 4, 0E8h, 42h, 0, 0F7h, 6
	db	7Ah, 4, 4, 0, 74h, 0Dh, 0C7h, 6, 16h, 4, 1, 0, 8Bh, 3Eh, 5Ch, 4
	db	0E8h, 2Dh, 0, 83h, 0C2h, 0Ch, 0F7h, 6, 7Ah, 4, 8, 0, 74h, 7, 8Bh
	db	3Eh, 5Eh, 4, 0E8h, 1Bh, 0, 83h, 0C2h, 4, 8Eh, 6, 0A0h, 7, 58h
	db	2Bh, 0C2h, '&)G', 0Dh, 8Bh, 1Eh, 8, 4, 8Eh, 6, 78h, 7, 26h, 89h
	db	57h, 6, 0C3h, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h
	db	0E7h, 8Eh, 85h, 58h, 7, 5Fh, 26h, 89h, 55h, 4, 0C3h, 0BEh, 92h
	db	0, 0B4h, 0, 0C7h, 6, 50h, 52h, 97h, 1, 0E8h, 16h, 19h, 2Eh, 8Eh
	db	1Eh, 10h, 0, 72h, 16h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h
	db	0D1h, 0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 0F6h, 47h, 0Eh, 10h, 74h
	db	1Fh, 0C7h, 6, 76h, 4, 0FFh, 0FFh, 0C7h, 6, 78h, 4, 0FFh, 0FFh
	db	83h, 3Eh, 4, 4, 0FFh, 74h, 0Ah, 33h, 0C9h, 51h, 0B8h, 37h, 0, 50h
	db	0E8h, 60h, 45h, 0F9h, 0C3h, 26h, 8Bh, 47h, 4, 0A3h, 78h, 4, 26h
	db	8Bh, 1Fh, 8Eh, 6, 80h, 7, 26h, 8Bh, 1Fh, 8Eh, 6, 0A0h, 7, 26h
	db	8Bh, 47h, 8, 0A3h, 76h, 4, 0F8h, 0C3h, 51h, 57h, 8Bh, 0FEh, 2Bh
	db	0C0h, 99h, 0EBh, 39h, 8Eh, 6, 78h, 7, 26h, 8Ah, 4Dh, 9, 80h, 0E1h
	db	1Ch, 80h, 0F9h, 8, 't)r', 0Fh, 80h, 0F9h, 18h, 73h, 0Ah, 26h, 3
	db	45h, 6, 26h, 12h, 55h, 8, 0EBh, '4&:U', 8, 'w.r', 6, '&;E', 6
	db	's&&', 8Ah, 55h, 8, 26h, 8Bh, 45h, 6, 0EBh, 1Ch, 8Eh, 6, 80h, 7
	db	26h, 8Bh, 45h, 6, 8Eh, 6, 78h, 7, 26h, 3, 45h, 6, 26h, 8Ah, 55h
	db	8, 8Eh, 6, 80h, 7, 26h, 12h, 55h, 8, 83h, 0C3h, 2, 3Bh, 1Eh, 0BEh
	db	7, 73h, 11h, 8Eh, 6, 0C0h, 7, 26h, 8Bh, 3Fh, 8Eh, 6, 80h, 7, '&;u'
	db	2, 74h, 91h, 5Fh, 59h, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 1Ah, 'PSQWV'
	db	8Bh, 0DFh, 8Eh, 6, 78h, 7, 26h, 8Ah, 44h, 9, 88h, 46h, 0E8h, 26h
	db	8Bh, 4, 89h, 46h, 0FEh, 26h, 8Bh, 44h, 2, 89h, 46h, 0FCh, 26h
	db	8Bh, 44h, 4, 89h, 46h, 0FAh, 26h, 8Bh, 44h, 6, 89h, 46h, 0EAh
	db	26h, 8Ah, 44h, 8, 88h, 46h, 0E6h, 8Eh, 6, 80h, 7, 26h, 8Bh, 44h
	db	6, 89h, 46h, 0F6h, 26h, 8Ah, 44h, 8, 0B4h, 0, 89h, 46h, 0F4h, 26h
	db	8Bh, 3Ch, 8Eh, 6, 78h, 7, 26h, 0F6h, 44h, 9, 0E0h, 75h, 0Ah, 0C7h
	db	46h, 0ECh, 0FFh, 0FFh, 89h, 7Eh, 0F8h, 0EBh, 1Dh, 8Eh, 6, 0A0h
	db	7, 26h, 8Bh, 45h, 2, 89h, 46h, 0ECh, 26h, 8Bh, 45h, 8, 80h, 3Eh
	db	19h, 0, 1, 75h, 4, 26h, 8Bh, 45h, 6, 89h, 46h, 0F8h, 8Bh, 3Eh
	db	41h, 0B4h, 0B0h, 20h, 0E8h, 9Dh, 1Dh, 83h, 7Eh, 4, 1, 74h, 4Ah
	db	0E8h, 0F0h, 0FEh, 89h, 46h, 0F2h, 89h, 56h, 0F0h, 80h, 3Eh, 19h
	db	0, 1, 74h, 3Ch, 8Bh, 5Eh, 0F8h, 0B1h, 4, 8Bh, 46h, 0F6h, 8Bh, 56h
	db	0F4h, 0E8h, 93h, 18h, 8Bh, 46h, 0F2h, 8Bh, 56h, 0F0h, 3Bh, 56h
	db	0F4h, 77h, 5, 3Bh, 46h, 0F6h, 76h, 6, 2Dh, 1, 0, 83h, 0DAh, 0
	db	0E8h, 7Ah, 18h, 8Bh, 46h, 0F2h, 8Bh, 56h, 0F0h, 2Bh, 46h, 0F6h
	db	1Bh, 56h, 0F4h, 2Bh, 0DBh, 0E8h, 69h, 18h, 0EBh, 30h, 0EBh, 40h
	db	0B0h, 20h, 0E8h, 46h, 1Dh, 8Bh, 46h, 0F8h, 0E8h, 0A1h, 1Dh, 0E8h
	db	0Eh, 1Eh, 1, 3Ah, 8Bh, 46h, 0F6h, 0E8h, 96h, 1Dh, 0E8h, 3, 1Eh
	db	4, '    ', 8Bh, 46h, 0F2h, 2Bh, 46h, 0F6h, 0E8h, 85h, 1Dh, 0E8h
	db	0F2h, 1Dh, 3, 'H  ', 8Bh, 76h, 0FEh, 0B9h, 12h, 0, 0E8h, 4Dh, 18h
	db	8Bh, 76h, 0FCh, 0E8h, 0ACh, 1Eh, 0E9h, 0AEh, 0, 8Bh, 46h, 0F8h
	db	0E8h, 66h, 1Dh, 0B0h, 3Ah, 0E8h, 0, 1Dh, 8Bh, 46h, 0F6h, 0E8h
	db	5Bh, 1Dh, 0B0h, 20h, 0E8h, 0F5h, 1Ch, 33h, 0C0h, 8Ah, 46h, 0E6h
	db	3Ch, 0, 74h, 3, 0E8h, 4Ah, 1Dh, 8Bh, 46h, 0EAh, 0E8h, 44h, 1Dh
	db	0E8h, 0B1h, 1Dh, 3, ' C=', 8Bh, 76h, 0FCh, 0B9h, 6, 0, 0E8h, 0Ch
	db	18h, 0E8h, 0A1h, 1Dh, 2, 53h, 3Dh, 8Bh, 76h, 0FEh, 0B9h, 0Eh, 0
	db	0E8h, 0FDh, 17h, 0E8h, 92h, 1Dh, 2, 47h, 3Dh, 0F6h, 46h, 0E8h
	db	0E0h, 74h, 0Bh, 8Bh, 76h, 0ECh, 0B9h, 7, 0, 0E8h, 0E8h, 17h, 0EBh
	db	0Bh, 0E8h, 7Bh, 1Dh, 7, '<none> ', 0E8h, 70h, 1Dh, 2, 4Dh, 3Dh
	db	8Bh, 76h, 0FAh, 83h, 0FEh, 0FFh, 75h, 10h, 0E8h, 62h, 1Dh, 0Ah
	db	'<none>    ', 0EBh, 18h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Bh, 34h, 0B9h, 0Ah, 0
	db	0E8h, 0A5h, 17h, 0E8h, 3Ah, 1Dh, 5, 'ACBP=', 8Ah, 46h, 0E8h, 0E8h
	db	0B0h, 1Ch, 0E8h, 0D1h, 1Ch, 89h, 3Eh, 41h, 0B4h, '^_Y[X', 8Bh
	db	0E5h, 5Dh, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 2, 89h, 46h
	db	0FEh, 56h, 57h, 8Bh, 3Eh, 41h, 0B4h, 0E8h, 0B0h, 1Ch, 83h, 7Eh
	db	0FEh, 0, 74h, 1Eh, 0E8h, 1, 1Dh, 18h, 'Detailed map of segments'
	db	0EBh, 6Dh, 80h, 3Eh, 19h, 0, 0, 74h, 34h, 0E8h, 0DCh, 1Ch, '. Start         Length Name               Class'
	db	0EBh, 32h, 0E8h, 0A8h, 1Ch, '. Start  Stop   Length Name               Class'
	db	0E8h, 1Ch, 1Ch, 0E8h, 19h, 1Ch, 89h, 3Eh, 41h, 0B4h, 2Bh, 0FFh
	db	3Bh, 3Eh, 0BEh, 7, 73h, 34h, 8Eh, 6, 0C0h, 7, 26h, 8Bh, 35h, 8Eh
	db	6, 80h, 7, 26h, 8Bh, 44h, 2, 3Dh, 0FFh, 0FFh, 74h, 1Bh, 83h, 7Eh
	db	0FEh, 1, 74h, 0Fh, 8Eh, 6, 78h, 7, 26h, 0F6h, 44h, 9, 0E0h, 74h
	db	0Ah, 3Bh, 0C6h, 75h, 6, 0FFh, 76h, 0FEh, 0E8h, 3Eh, 0FDh, 83h
	db	0C7h, 2, 0EBh, 0C6h, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0C3h, 56h, 83h
	db	0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7
	db	5Eh, 26h, 8Bh, 44h, 4, 26h, 8Ah, 54h, 0Eh, 26h, 8Bh, 34h, 57h
	db	83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h
	db	7, 5Fh, 26h, 8Bh, 5Dh, 4, 26h, 8Ah, 75h, 0Eh, 26h, 8Bh, 3Dh, 8Eh
	db	6, 80h, 7, 81h, 0E2h, 2, 2, 'u&&', 83h, 7Ch, 4, 0FFh, 74h, 7, 80h
	db	0CAh, 1, 26h, 8Bh, 74h, 4, 26h, 8Bh, 34h, 26h, 83h, 7Dh, 4, 0FFh
	db	74h, 7, 80h, 0CEh, 1, 26h, 8Bh, 7Dh, 4, 26h, 8Bh, 3Dh, 8Eh, 6
	db	0A0h, 7, 0C3h, 'PSQRWV', 0E8h, 92h, 0FFh, 0F7h, 0C2h, 2, 2, 'uI&'
	db	8Bh, 74h, 8, 26h, 8Bh, 7Dh, 8, 0F7h, 0C2h, 1, 1, 74h, 6, 3Bh, 0F7h
	db	75h, 2Ah, 0EBh, 24h, 3Bh, 0F7h, 74h, 20h, 0B1h, 4, 0D3h, 0C6h
	db	0D3h, 0C7h, 0B9h, 0Fh, 0, 23h, 0CEh, 33h, 0F1h, 3, 0C6h, 12h, 0CDh
	db	0BAh, 0Fh, 0, 23h, 0D7h, 33h, 0FAh, 3, 0DFh, 12h, 0D6h, 3Bh, 0CAh
	db	75h, 4, 3Bh, 0C3h, 74h, 17h, 9Fh, 8Eh, 6, 0C0h, 7, 9Eh, '^_ZY[X'
	db	0C3h, 81h, 0E2h, 2, 2, 3Ah, 0D6h, 75h, 0EBh, 0EBh, 0E5h, '^_WV;'
	db	0F7h, 0EBh, 0E1h, 'PSQRWV', 0E8h, 28h, 0FFh, 81h, 0E2h, 2, 2, 75h
	db	1Bh, 26h, 8Bh, 4Ch, 6, '&;M', 6, 75h, 4, 3Bh, 0C3h, 74h, 13h, 9Fh
	db	8Eh, 6, 0C0h, 7, 9Eh, '^_ZY[X', 0C3h, 3Ah, 0F2h, 75h, 0EFh, 0EBh
	db	0E9h, '^_WV;', 0F7h, 0EBh, 0E5h, 'PSQRWVV', 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 26h, 0FFh
	db	74h, 6, 26h, 0FFh, 74h, 4, 26h, 8Ah, 54h, 0Eh, 26h, 8Bh, 34h, 57h
	db	83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h
	db	7, 5Fh, 26h, 8Bh, 45h, 4, 26h, 8Bh, 5Dh, 6, 26h, 8Ah, 75h, 0Eh
	db	26h, 8Bh, 3Dh, 81h, 0E2h, 2, 2, 81h, 0FAh, 2, 2, 74h, 2Dh, 8Eh
	db	6, 80h, 7, 0Ah, 0D2h, 75h, 3, 26h, 8Bh, 34h, 0Ah, 0F6h, 75h, 3
	db	26h, 8Bh, 3Dh, 8Eh, 6, 0A0h, 7, 2Bh, 0C9h, 0Ah, 0D2h, 75h, 4, 26h
	db	8Bh, 4Ch, 6, 0Ah, 0F6h, 0BAh, 0, 0, 75h, 4, 26h, 8Bh, 55h, 6, 3Bh
	db	0CAh, 'YZu', 8, 3Bh, 0DAh, 75h, 4, 3Bh, 0C1h, 74h, 0Dh, 9Fh, 8Eh
	db	6, 0C0h, 7, 9Eh, '^_ZY[X', 0C3h, '^_WV;', 0F7h, 0EBh, 0EBh, 'PSQWV'
	db	1Eh, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh
	db	85h, 58h, 7, 5Fh, 26h, 8Bh, 7Dh, 0Ch, 56h, 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 26h, 8Bh
	db	74h, 0Ch, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h
	db	8Eh, 85h, 18h, 7, '_GGV', 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 9Ch, 18h, 7, '^FF', 0ACh, 26h, 3Ah, 5, 9Fh, 76h
	db	3, 26h, 8Ah, 5, 47h, 8Ah, 0C8h, 32h, 0EDh, 0ACh, 26h, 8Ah, 1Dh
	db	47h, 0Ch, 20h, 80h, 0CBh, 20h, 3Ah, 0C3h, 75h, 3, 0E2h, 0F0h, 9Eh
	db	1Fh, 9Fh, 8Eh, 6, 0C0h, 7, 9Eh, '^_Y[X', 0C3h, 56h, 57h, 0C7h
	db	6, 0BEh, 7, 0, 0, 2Bh, 0F6h, 56h, 0BBh, 54h, 7, 0EBh, 6Ch, 26h
	db	8Bh, 5Ch, 2, 8Eh, 6, 8, 8, 26h, 83h, 7Fh, 6, 0, 75h, 46h, 0EBh
	db	'VSV', 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h
	db	58h, 7, 5Eh, 80h, 3Eh, 19h, 0, 0, 74h, 7, 26h, 0F6h, 44h, 0Eh
	db	20h, 75h, 0D1h, 26h, 0F6h, 44h, 0Eh, 14h, 'u1&', 8Bh, 5Ch, 2, 83h
	db	0FBh, 0FFh, 't(S', 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 38h, 7, 5Bh, 26h, 83h, 7Fh, 0Ah, 2, 72h, 12h, 0BFh
	db	2, 0, 57h, 0BFh, 0BCh, 7, 0E8h, 7Fh, 0D8h, 73h, 3, 0E8h, 6Dh, 0D8h
	db	26h, 89h, 35h, 5Bh, 3, 36h, 90h, 4, 3Bh, 77h, 2, 72h, 0A0h, 81h
	db	0FBh, 64h, 7, 77h, 8, 83h, 0C3h, 8, '^FV', 0EBh, 0EDh, '^_^', 0C3h
	db	33h, 0C0h, 99h, 26h, 0F6h, 44h, 0Eh, 20h, 74h, 5, 8Bh, 0C8h, 8Bh
	db	0D8h, 0C3h, 56h, 26h, 8Bh, 4Ch, 4, 26h, 8Bh, 5Ch, 6, 26h, 8Ah
	db	54h, 0Eh, 26h, 8Bh, 34h, 0F6h, 0C2h, 2, 75h, 39h, 8Eh, 6, 80h
	db	7, 26h, 83h, 7Ch, 4, 0FFh, 74h, 4, 26h, 8Bh, 74h, 4, 8Eh, 6, 78h
	db	7, 26h, 8Ah, 44h, 9, 8Eh, 6, 80h, 7, 26h, 8Bh, 34h, 0A8h, 0E0h
	db	74h, 15h, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 44h, 8, 80h, 3Eh, 19h, 0
	db	0, 74h, 4, 26h, 8Bh, 44h, 6, 5Eh, 0C3h, 0B6h, 1, 8Bh, 0C6h, 0EBh
	db	0F8h, 0E8h, 9, 0FFh, 8Bh, 3Eh, 41h, 0B4h, 0E8h, 13h, 19h, '!  Address         Publics by Name'
	db	0BDh, 54h, 7Bh, 0E8h, 3Bh, 0, 8Bh, 3Eh, 41h, 0B4h, 0E8h, 0E4h
	db	18h, '"  Address         Publics by Value', 0BDh, 82h, 7Ah, 80h
	db	3Eh, 27h, 1, 0, 74h, 7, 0BDh, 0BAh, 7Ah, 0E8h, 1, 0, 0C3h, 57h
	db	8Bh, 0Eh, 0BEh, 7, 8Eh, 6, 0C0h, 7, 0E8h, 21h, 12h, 5Fh, 0E8h
	db	46h, 18h, 0E8h, 43h, 18h, 2Bh, 0DBh, 0EBh, 7Bh, 0B0h, 20h, 0E8h
	db	0C3h, 17h, 8Eh, 6, 0C0h, 7, 26h, 8Bh, '7SV', 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 26h, 0FFh
	db	74h, 0Ch, 0E8h, 0F8h, 0FEh, 0E8h, 3, 18h, 0B0h, 3Ah, 0E8h, 9Dh
	db	17h, 80h, 3Eh, 27h, 1, 0, 74h, 4, 93h, 0E8h, 0B0h, 17h, 91h, 0E8h
	db	0EFh, 17h, 80h, 3Eh, 15h, 0, 1, 75h, 12h, 0F6h, 0C2h, 1, 75h, 0Dh
	db	0E8h, 50h, 18h, 7, ' idle  ', 0EBh, 1Dh, 0F6h, 0C2h, 2, 75h, 0Dh
	db	0E8h, 3Eh, 18h, 7, '       ', 0EBh, 0Bh, 0E8h, 31h, 18h, 7, '  Abs  ^'
	db	0E8h, 8Eh, 18h, 0E8h, 0C8h, 17h, 5Bh, 83h, 0C3h, 2, 3Bh, 1Eh, 0BEh
	db	7, 73h, 3, 0E9h, 7Ch, 0FFh, 0E8h, 0B8h, 17h, 89h, 3Eh, 41h, 0B4h
	db	0C3h, 'VWPSQR', 0B1h, 3, 48h, 0D3h, 0E0h, 8Eh, 6, 80h, 7, 8Bh
	db	1Eh, 8, 4, 26h, 8Bh, 57h, 6, 0B1h, 4, 0D3h, 0EAh, 26h, 8Bh, 1Fh
	db	8Eh, 6, 0A0h, 7, 26h, 3, 57h, 8, 0A3h, 98h, 4, 89h, 16h, 9Ah, 4
	db	91h, 3, 16h, 0FEh, 3, 0B8h, 8, 0, 0BEh, 97h, 6, 0E8h, 81h, 0Ah
	db	0FFh, 6, 0A2h, 4, 0A1h, 0F2h, 3, 8Bh, 16h, 0F4h, 3, 0B9h, 4, 0
	db	1, 0Eh, 0F2h, 3, 83h, 16h, 0F4h, 3, 0, 0BEh, 98h, 4, 0E8h, 32h
	db	0Bh, 'ZY[X_^', 0C3h, 'VW&', 8Bh, 45h, 8, 0A3h, 97h, 6, 26h, 8Bh
	db	45h, 0Bh, 0A3h, 9Dh, 6, 0BEh, 0Fh, 0, 23h, 0F0h, 26h, 3, 75h, 0Dh
	db	89h, 36h, 99h, 6, 2Bh, 0D2h, 26h, 8Ah, 4Dh, 1, 80h, 0F9h, 0FEh
	db	75h, 3, 83h, 0CAh, 4, 80h, 0F9h, 0, 7Eh, 10h, 83h, 0CAh, 1, 80h
	db	0F9h, 2, 7Ch, 8, 83h, 0FEh, 20h, 72h, 3, 83h, 0CAh, 2, 89h, 16h
	db	9Bh, 6, 26h, 8Bh, 45h, 6, 0E8h, 56h, 0FFh, 5Fh, 5Eh, 0C3h, 8Bh
	db	1Eh, 5Ch, 4, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 58h, 7, 5Bh, 26h, 8Bh, 4Fh, 4, 8Bh, 36h, 8, 4, 8Eh, 6
	db	80h, 7, 26h, 8Bh, 34h, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 54h, 8, 3, 16h
	db	0FEh, 3, 52h, 1Eh, 8Bh, 36h, 3Ah, 1, 0C5h, 1Eh, 34h, 1, 8Ch, 0DFh
	db	8Eh, 1Fh, 53h, 8Dh, 74h, 2, 0FCh, 8Bh, 0DEh, 0ACh, '<\t', 0F9h
	db	0Ah, 0C0h, 75h, 0F7h, 8Bh, 0F3h, 0B8h, 0Ch, 0, 5Bh, 1Fh, 0E8h
	db	0AFh, 9, 0F7h, 6, 7Ah, 4, 8, 0, 74h, 2Eh, 0B4h, 2Ah, 0CDh, 21h
	db	89h, 16h, 0Ch, 4, 89h, 0Eh, 0Eh, 4, 8Bh, 1Eh, 5Eh, 4, 53h, 83h
	db	0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7
	db	5Bh, 26h, 8Bh, 4Fh, 4, 5Ah, 0B8h, 4, 0, 0BEh, 0Ch, 4, 0E8h, 84h
	db	9, 0C3h, 83h, 0C4h, 2, 0EBh, 0FAh, 83h, 3Eh, 14h, 4, 1, 74h, 8
	db	83h, 3Eh, 16h, 4, 1, 74h, 3Fh, 0C3h, 8Bh, 1Eh, 8, 4, 8Eh, 6, 80h
	db	7, 26h, 8Bh, 47h, 6, 26h, 8Bh, 1Fh, 8Eh, 6, 0A0h, 7, 26h, 8Bh
	db	57h, 8, 0B1h, 4, 0D3h, 0E8h, 3, 0D0h, 89h, 16h, 0Ah, 4, 2Bh, 0F6h
	db	0EBh, 13h, 8Eh, 6, 0A0h, 7, 26h, 80h, 7Ch, 1, 3, 7Dh, 0Eh, 8Bh
	db	0FEh, 0E8h, 0DDh, 0FEh, 83h, 0C6h, 14h, 3Bh, 36h, 9Eh, 7, 72h
	db	0E7h, 83h, 3Eh, 16h, 4, 1, 75h, 3, 0E8h, 18h, 0FFh, 0C3h, 8Bh
	db	16h, 76h, 4, 83h, 0FAh, 0FFh, 74h, 11h, 3, 16h, 0FEh, 3, 8Bh, 0Eh
	db	78h, 4, 0B8h, 2, 0, 0BEh, 7Ch, 4, 0E8h, 0Ch, 9, 0C3h, 'PSQRWV'
	db	8Eh, 6, 80h, 7, 26h, 8Bh, 75h, 4, 26h, 8Bh, 34h, 8Eh, 6, 0A0h
	db	7, 26h, 8Bh, 47h, 8, 26h, 8Ah, 4Fh, 0Ah, 0B5h, 0, 2Bh, 6, 6, 4
	db	1Ah, 0CDh, 0B5h, 4, 0D1h, 0E0h, 0D0h, 0D1h, 0FEh, 0CDh, 75h, 0F8h
	db	0A3h, 76h, 6, 89h, 0Eh, 78h, 6, 26h, 8Bh, 47h, 0Dh, 0A3h, 7Ah
	db	6, 26h, 8Bh, 47h, 11h, 0D1h, 0E0h, 0A3h, 7Ch, 6, 26h, 8Bh, 44h
	db	0Dh, 2Dh, 20h, 0, 0B9h, 5, 0, 2Bh, 0D2h, 0F7h, 0F1h, 0A3h, 7Eh
	db	6, 26h, 8Bh, 54h, 8, 3, 16h, 0FEh, 3, 2Bh, 0C9h, 0B8h, 20h, 0
	db	0BEh, 72h, 6, 0E8h, 0A1h, 8, '^_ZY[X', 0C3h, 'PSQRWV', 0C6h, 6
	db	96h, 6, 0, 8Bh, 1Eh, 7Ch, 4, 89h, 1Eh, 92h, 6, 8Eh, 6, 80h, 7
	db	26h, 8Bh, 75h, 4, 26h, 8Bh, 3Ch, 26h, 8Bh, 74h, 4, 8Eh, 6, 0A0h
	db	7, 26h, 8Bh, 55h, 8, 3, 16h, 0FEh, 3, 83h, 0FEh, 0FFh, 't*V', 83h
	db	0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7
	db	5Eh, 26h, 0FFh, 74h, 0Ah, 26h, 8Bh, 44h, 4, 0A3h, 94h, 6, 26h
	db	8Bh, 4Ch, 8, 0B8h, 5, 0, 0BEh, 92h, 6, 0E8h, 40h, 8, 5Eh, 0EBh
	db	0D1h, '^_ZY[X', 0C3h, 53h, 51h, 8Bh, 1Eh, 4, 4, 83h, 0FBh, 0FFh
	db	75h, 5, 2Bh, 0C0h, 99h, 0EBh, 21h, 8Eh, 6, 0A0h, 7, 0B8h, 10h
	db	0, 26h, 0F7h, 67h, 8, 93h, 8Bh, 0CAh, 8Bh, 16h, 0DEh, 3, 0A1h
	db	0DCh, 3, 2Bh, 0C3h, 1Bh, 0D1h, 5, 0Fh, 0, 83h, 0D2h, 0, 24h, 0F0h
	db	59h, 5Bh, 0C3h, 56h, 57h, 0BFh, 64h, 6, 0C7h, 5, 46h, 42h, 0C7h
	db	45h, 2, 4Fh, 56h, 0E8h, 0BBh, 0FFh, 89h, 45h, 4, 89h, 55h, 6, 8Bh
	db	16h, 0Ah, 4, 83h, 0FAh, 0FFh, 75h, 7, 2Bh, 0C0h, 99h, 2Bh, 0C9h
	db	0EBh, 21h, 3, 16h, 0FEh, 3, 0B8h, 10h, 0, 0F7h, 0E2h, 8Bh, 1Eh
	db	4, 4, 83h, 0FBh, 0FFh, 74h, 0Bh, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 4Fh
	db	6, 49h, 0EBh, 4, 8Bh, 0Eh, 0BBh, 6, 89h, 45h, 8, 89h, 55h, 0Ah
	db	89h, 4Dh, 0Ch, 0B8h, 0Eh, 0, 33h, 0C9h, 8Bh, 16h, 18h, 4, 3, 16h
	db	0FEh, 3, 0BEh, 64h, 6, 0E8h, 9Eh, 7, 5Fh, 5Eh, 0C3h, 56h, 57h
	db	8Bh, 1Eh, 4, 4, 83h, 0FBh, 0FFh, 75h, 9, 83h, 3Eh, 14h, 4, 1, 74h
	db	38h, 0EBh, 39h, 1Eh, 7, 33h, 0C0h, 0B9h, 20h, 0, 0BFh, 72h, 6
	db	0F3h, 0AAh, 0A1h, 7Ch, 4, 0A3h, 72h, 6, 8Eh, 6, 0A0h, 7, 26h, 8Bh
	db	47h, 8, 0A3h, 6, 4, 26h, 8Bh, 7Fh, 4, 0E8h, 58h, 0FEh, 0E8h, 0C6h
	db	0FEh, 83h, 0C3h, 14h, 3Bh, 1Eh, 9Eh, 7, 73h, 6, 8Eh, 6, 0A0h, 7
	db	0EBh, 0E7h, 0E8h, 4Ch, 0FFh, 5Fh, 5Eh, 0C3h, 80h, 3Eh, 13h, 0
	db	1, 75h, 19h, 1Eh, 8Bh, 16h, 3Ch, 1, 0C5h, 1Eh, 34h, 1, 8Eh, 1Fh
	db	83h, 0C2h, 2, 0B4h, 3Ch, 33h, 0C9h, 0E8h, 8Ch, 81h, 1Fh, 0A3h
	db	22h, 0, 0C3h, 0BFh, 1Eh, 1, 0B9h, 1Ch, 0, 0B8h, 97h, 1, 8Eh, 0C0h
	db	26h, 8Bh, 35h, 8Ch, 6, 'PRQW&', 8Ah, 65h, 4, 0E8h, 9Ah, 0Ch, 5Fh
	db	59h, 0B8h, 97h, 1, 8Eh, 0C0h, 26h, 8Bh, 75h, 2, 89h, 1Ch, 49h
	db	74h, 5, 83h, 0C7h, 5, 0EBh, 0DBh, 8Bh, 1Eh, 4Eh, 4, 53h, 83h, 0E3h
	db	3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h
	db	0C7h, 47h, 3, ':O&', 0C7h, 47h, 5, 56h, 59h, 0C3h, 55h, 8Bh, 0ECh
	db	80h, 3Eh, 0D7h, 3, 1, 75h, 6Dh, 83h, 3Eh, 0FCh, 3, 0FFh, 74h, 66h
	db	0BEh, 0C9h, 0, 0B4h, 0, 0BBh, 97h, 1, 89h, 1Eh, 50h, 52h, 0E8h
	db	52h, 0Dh, 'r"S', 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 58h, 7, 5Bh, 26h, 0F6h, 47h, 0Eh, 10h, 74h, 0Ch, 8Bh
	db	36h, 37h, 0Ah, 83h, 0FEh, 0FFh, 74h, 3, 0E8h, 37h, 0, 0BEh, 0D0h
	db	0, 0B4h, 0, 0BBh, 97h, 1, 89h, 1Eh, 50h, 52h, 0E8h, 1Fh, 0Dh, 'r"S'
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h
	db	7, 5Bh, 26h, 0F6h, 47h, 0Eh, 10h, 74h, 0Ch, 8Bh, 36h, 39h, 0Ah
	db	83h, 0FEh, 0FFh, 74h, 3, 0E8h, 4, 0, 8Bh, 0E5h, 5Dh, 0C3h, 26h
	db	89h, 37h, 26h, 0C7h, 47h, 4, 0, 0, 26h, 0C7h, 47h, 6, 0, 0, 0B0h
	db	0EFh, '& G', 0Eh, 0C3h, 8Ch, 1Eh, 7Eh, 4, 8Ch, 0Eh, 80h, 4, 0C7h
	db	6, 82h, 4, 97h, 1, 0A0h, 34h, 0Ah, 0Ah, 6, 16h, 0, 0Ah, 6, 19h
	db	0, 8, 6, 54h, 2, 0C7h, 6, 35h, 0Ah, 0, 0, 0C6h, 6, 10h, 4, 0, 83h
	db	3Eh, 7Ch, 4, 0FFh, 75h, 6, 0C7h, 6, 7Ch, 4, 0CDh, 3Fh, 1Eh, 7
	db	33h, 0C0h, 0BFh, 9Ch, 4, 0B9h, 1Fh, 0, 0F3h, 0ABh, 0C7h, 6, 0B2h
	db	4, 0FFh, 0FFh, 0BFh, 9Fh, 6, 0B9h, 40h, 0, 0D1h, 0E9h, 0F3h, 0ABh
	db	0E8h, 8Fh, 8, 0C7h, 6, 8Fh, 3, 0, 0, 0B8h, 10h, 0, 38h, 26h, 16h
	db	0, 74h, 29h, 1Eh, 7, 0BFh, 0DAh, 4, 0B9h, 28h, 0, 33h, 0C0h, 0F3h
	db	0ABh, 0A3h, 8Ah, 4, 0A3h, 8Ch, 4, 0A3h, 8Eh, 4, 0A3h, 92h, 4, 0BFh
	db	0B2h, 3, 0B9h, 1Ah, 0, 0F3h, 0AAh, 0C7h, 6, 0C4h, 3, 1, 0, 0B8h
	db	14h, 0, 0A3h, 90h, 4, 2Bh, 0C0h, 0A3h, 0EAh, 3, 0A3h, 0ECh, 3
	db	0A3h, 1Eh, 4, 0A3h, 20h, 4, 0E8h, 0Ah, 0D3h, 80h, 3Eh, 19h, 0
	db	1, 75h, 0Ch, 0BFh, 4, 8, 0E8h, 0E3h, 0D2h, 0BFh, 0Ch, 8, 0E8h
	db	0A1h, 0D3h, 0C6h, 6, 0D4h, 3, 0, 0C6h, 6, 94h, 4, 0, 0C6h, 6, 88h
	db	4, 0, 0E8h, 39h, 0FEh, 0E8h, 4Eh, 11h, 80h, 3Eh, 19h, 0, 0, 74h
	db	11h, 0C7h, 6, 0, 4, 8, 0, 0C7h, 6, 2, 4, 0F3h, 6, 0E8h, 0BBh, 17h
	db	0EBh, 0Ch, 0C7h, 6, 0, 4, 2, 0, 0C7h, 6, 2, 4, 62h, 6, 0C7h, 6
	db	11h, 4, 0, 0, 0E8h, 2Ah, 0FEh, 0C7h, 6, 1Ch, 4, 0, 0, 0C7h, 6
	db	0D0h, 3, 3Ch, 58h, 0C6h, 6, 0D5h, 3, 0, 0E8h, 0ABh, 6, 0A1h, 74h
	db	52h, 0A3h, 96h, 4, 8Bh, 36h, 38h, 1, 0E8h, 0E7h, 7, 0C6h, 6, 0D5h
	db	3, 1, 8Bh, 36h, 3Eh, 1, 0E8h, 92h, 6, 0E8h, 0D8h, 7, 0C7h, 6, 96h
	db	4, 0, 0, 0E8h, 0A4h, 0C1h, 0C6h, 6, 54h, 2, 1, 0C6h, 6, 0D5h, 3
	db	2, 0E8h, 45h, 2, 0E8h, 12h, 0D7h, 53h, 8Bh, 1Eh, 3Ah, 7, 0C4h
	db	7Fh, 2, 83h, 0C7h, 18h, ';?v', 9, 0E8h, 53h, 0D1h, 5Bh, 73h, 7
	db	0E8h, 14h, 0D1h, 87h, 7Fh, 2, 5Bh, 0ABh, 0A1h, 76h, 7, 0ABh, 0A1h
	db	86h, 7, 0ABh, 0A1h, 96h, 7, 0ABh, 0A1h, 0AEh, 7, 0ABh, 0B8h, 3
	db	0, 0ABh, 0B0h, 0, 0ABh, 0ABh, 0AAh, 80h, 3Eh, 19h, 0, 0, 74h, 6
	db	0E8h, 0ADh, 33h, 0E8h, 33h, 36h, 0E8h, 0A1h, 0DFh, 0A1h, 0A2h
	db	4, 0A3h, 49h, 0Ah, 80h, 3Eh, 19h, 0, 1, 75h, 0Bh, 0E8h, 53h, 16h
	db	23h, 0C0h, 74h, 1, 40h, 0A3h, 0F8h, 3, 80h, 3Eh, 88h, 4, 1, 75h
	db	3, 0E8h, 2Bh, 0E0h, 0E8h, 11h, 0E4h, 8Eh, 6, 0C0h, 7, 8Bh, 0Eh
	db	0BEh, 7, 0BDh, 6Bh, 64h, 0E8h, 60h, 0Bh, 0E8h, 0FAh, 0E4h, 80h
	db	3Eh, 19h, 0, 1, 75h, 3, 0E8h, 8Bh, 0E6h, 0C7h, 6, 0BBh, 6, 0, 0
	db	0E8h, 0C6h, 0E7h, 8Bh, 1Eh, 24h, 4, 53h, 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 8Bh, 7, 3Dh
	db	0FFh, 0FFh, 74h, 3, 0A3h, 0FCh, 3, 0E8h, 0ECh, 0F0h, 80h, 3Eh
	db	19h, 0, 1, 75h, 3, 0E8h, 0A0h, 1Ch, 0E8h, 7Ah, 0EBh, 0E8h, 71h
	db	0FDh, 0E8h, 96h, 0EDh, 0E8h, 0D9h, 0EDh, 0E8h, 0B6h, 0F1h, 80h
	db	3Eh, 19h, 0, 0, 75h, 3, 0E8h, 3Ah, 0EEh, 80h, 3Eh, 13h, 0, 1, 'uA3'
	db	0C0h, 0E8h, 61h, 0F4h, 8Bh, 3Eh, 41h, 0B4h, 0E8h, 1Ch, 11h, 89h
	db	3Eh, 41h, 0B4h, 80h, 3Eh, 15h, 0, 1, 75h, 11h, 0B8h, 1, 0, 0E8h
	db	49h, 0F4h, 8Bh, 3Eh, 41h, 0B4h, 0E8h, 4, 11h, 89h, 3Eh, 41h, 0B4h
	db	80h, 3Eh, 14h, 0, 1, 75h, 12h, 0E8h, 33h, 0F8h, 8Bh, 3Eh, 41h
	db	0B4h, 89h, 3Eh, 41h, 0B4h, 80h, 3Eh, 16h, 0, 0, 75h, 0Ah, 80h
	db	3Eh, 16h, 0, 0, 74h, 13h, 0E8h, 26h, 0F7h, 0BDh, 18h, 7Ah, 8Bh
	db	0Eh, 0BEh, 7, 8Eh, 6, 0C0h, 7, 0E8h, 0A6h, 0Ah, 0EBh, 6, 0C7h
	db	6, 0BEh, 7, 0, 0, 0C7h, 6, 8Eh, 7, 0, 0, 80h, 3Eh, 10h, 4, 0, 74h
	db	3, 0E8h, 41h, 1, 0C6h, 6, 4Eh, 0Ah, 0, 0E8h, 0D4h, 0, 0C6h, 6
	db	0D4h, 3, 1, 0E8h, 42h, 0D2h, 80h, 3Eh, 19h, 0, 0, 74h, 9, 0E8h
	db	0BFh, 2Eh, 0E8h, 0B9h, 2Fh, 0E8h, 0DEh, 17h, 80h, 3Eh, 16h, 0
	db	0, 74h, 6, 0E8h, 1Fh, 0C5h, 0E8h, 0ACh, 0CBh, 0C7h, 6, 0EAh, 3
	db	0, 0, 33h, 0D2h, 80h, 3Eh, 23h, 1, 1, 75h, 17h, 8Bh, 16h, 0FEh
	db	3, 0B8h, 10h, 0, 0F7h, 0E2h, 3, 6, 0DCh, 3, 13h, 16h, 0DEh, 3
	db	0B9h, 0, 0, 0E8h, 3Bh, 4, 0C7h, 6, 0D0h, 3, 3Ch, 59h, 0C7h, 6
	db	0E2h, 3, 0, 0, 0C6h, 6, 0F1h, 3, 0FFh, 0C6h, 6, 94h, 4, 0, 0E8h
	db	0BFh, 4, 0A0h, 26h, 1, 0A2h, 17h, 0, 0C6h, 6, 0D5h, 3, 3, 0A1h
	db	74h, 52h, 0A3h, 96h, 4, 8Bh, 36h, 38h, 1, 0E8h, 0F0h, 5, 0C6h
	db	6, 0D5h, 3, 4, 0E8h, 9Fh, 4, 8Bh, 36h, 3Eh, 1, 0E8h, 0E1h, 5, 0E8h
	db	0ACh, 0F9h, 0E8h, 1, 0FAh, 0E8h, 89h, 0FBh, 80h, 3Eh, 16h, 0, 0
	db	74h, 3, 0E8h, 0B2h, 0CEh, 80h, 3Eh, 2Bh, 1, 1, 75h, 10h, 81h, 3Eh
	db	0B0h, 4, 0, 1, 74h, 17h, 0E8h, 2, 0Bh, 75h, 12h, 0E9h, 0FDh, 0B6h
	db	80h, 3Eh, 19h, 0, 0, 74h, 5, 0E8h, 2Fh, 1Bh, 0EBh, 3, 0E8h, 70h
	db	0EEh, 8Bh, 3Eh, 41h, 0B4h, 0E8h, 0E4h, 0Fh, 0E8h, 1Bh, 0Fh, 0E8h
	db	44h, 1, 2Bh, 0C0h, 0C3h, 1Eh, 8Bh, 16h, 3Ah, 1, 0C5h, 1Eh, 34h
	db	1, 8Eh, 1Fh, 83h, 0C2h, 2, 0B8h, 0, 3Ch, 33h, 0C9h, 0E8h, 2Bh
	db	7Dh, 1Fh, 0A3h, 24h, 0, 0C3h, 80h, 3Eh, 0D7h, 3, 1, 75h, 39h, 8Bh
	db	1Eh, 43h, 0Ah, 83h, 0FBh, 0FFh, 74h, 30h, 8Eh, 6, 78h, 7, 26h
	db	8Ah, 47h, 9, 26h, 8Bh, 0Fh, 50h, 0E8h, 57h, 0D4h, 58h, 26h, 88h
	db	45h, 9, 26h, 89h, 0Dh, 26h, 0C7h, 45h, 6, 10h, 0, 8Bh, 1Eh, 38h
	db	4, 26h, 89h, 1Dh, 8Bh, 1Eh, 4Ch, 4, 26h, 89h, 5Dh, 2, 89h, 3Eh
	db	3Ah, 4, 0C3h, 0, 0, 0, 0, 0, 0, 0, 0, 0
L08610:	mov	di, word ptr ds:[0B441h]	;@08610
	call	L09586	;@08614
	call	L094C0	;@08617
	call	@@1	;@0861A
	call	@@2	;@0861D
	ret	;@08620
	db	'PSRW', 6, 8Bh, 0D9h, 81h, 0E1h, 0FFh, 3, 33h, 0D9h, 0BFh, 50h	;@08621
	db	12h, 2Bh, 0F9h, 57h, 0Bh, 0CBh, 74h, 0Ah, 1Eh, 7, 0D1h, 0E9h, 0F3h
	db	0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 0A1h, 6Ch, 52h, 8Bh, 16h, 'nR+'
	db	0C3h, 1Ah, 0D6h, 0A3h, 68h, 52h, 89h, 16h, 6Ah, 52h, 0B9h, 0, 40h
	db	2Bh, 0CBh, 80h, 3Eh, 61h, 1, 0, 74h, 16h, 0A1h, 64h, 52h, 8Bh
	db	16h, 'fR+', 6, 6Ch, 52h, 1Bh, 16h, 'nRu', 5, 3Bh, 0C1h, 77h, 1
	db	91h, 0B4h, 3Fh, 8Bh, 1Eh, 26h, 0, 8Bh, 0D7h, 0E8h, 31h, 7Ch, 0Bh
	db	0C0h, 74h, 15h, 1, 6, 6Ch, 52h, 83h, 16h, 6Eh, 52h, 0, 3, 0C7h
	db	0A3h, 'XR^', 7, '_Z[X', 0C3h, 0E8h, 0, 0, 1Eh, 0B8h, 0BBh, 92h
	db	50h, 0B8h, 4, 0, 50h, 0B8h, 5, 0, 50h, 0E8h, 0F4h, 34h, 87h, 0DEh
	db	'SQR', 1Eh, 50h, 8Bh, 0D6h, 0B1h, 6, 0D3h, 0E2h, 86h, 0D6h, 2Bh
	db	0C9h, 86h, 0D1h, 8Bh, 1Eh, 24h, 0, 0B8h, 0, 42h, 0E8h, 0E8h, 7Bh
	db	8Bh, 1Eh, 24h, 0, 0B9h, 0, 80h, 3Bh, 36h, 84h, 4, 75h, 4, 8Bh
	db	0Eh, 86h, 4, 58h, 33h, 0D2h, 8Eh, 9Ch, 34h, 8, 0E8h, 0F0h, 7Bh
	db	1Fh, 'ZY[', 87h, 0DEh, 0C3h, 83h, 3Eh, 84h, 4, 0FFh, 75h, 1, 0C3h
	db	1Eh, 0B8h, 34h, 8, 50h, 9Ah, 0DFh, 2Dh, 0DFh, 0, 23h, 0C0h, 74h
	db	3, 0E9h, 80h, 0, 33h, 0DBh, 83h, 0BFh, 34h, 8, 0FFh, 'u)S', 1Eh
	db	0B8h, 34h, 8, 50h, 9Ah, 0DFh, 2Dh, 0DFh, 0, 23h, 0C0h, '[ug', 8Eh
	db	6, 34h, 8, 2Bh, 0FFh, 2Bh, 0C0h, 0B9h, 0, 40h, 0FCh, 0F3h, 0ABh
	db	8Ch, 87h, 34h, 8, 0B4h, 40h, 0E8h, 78h, 0FFh, 0EBh, 3Ah, 53h, 1Eh
	db	81h, 0C3h, 34h, 8, 53h, 9Ah, 30h, 1Ch, 0DFh, 0, 5Bh, 23h, 0C0h
	db	'u)S', 1Eh, 81h, 0C3h, 34h, 8, 53h, 9Ah, 0DFh, 2Dh, 0DFh, 0, 5Bh
	db	23h, 0C0h, 75h, 2Ch, 0B4h, 40h, 0E8h, 4Fh, 0FFh, 23h, 0DBh, 75h
	db	2, 0EBh, 0Dh, 53h, 1Eh, 81h, 0C3h, 34h, 8, 53h, 9Ah, 0FCh, 15h
	db	0DFh, 0, 5Bh, 83h, 0C3h, 2, 3Bh, 1Eh, 84h, 4, 76h, 8Dh, 1Eh, 0B8h
	db	34h, 8, 50h, 9Ah, 0FCh, 15h, 0DFh, 0, 0C3h, 0E9h, 18h, 7Bh, 55h
	db	8Bh, 0ECh, 1Eh, 'VW.', 8Eh, 1Eh, 10h, 0, 8Bh, 46h, 0Ch, 48h, 74h
	db	7, 48h, 75h, 10h, 0B4h, 3Fh, 0EBh, 2, 0B4h, 40h, 8Bh, 5Eh, 8, 81h
	db	0EBh, 34h, 8, 0E8h, 1, 0FFh, 33h, 0C0h, 5Fh, 5Eh, 1Fh, 5Dh, 0CAh
	db	8, 0, 88h, 87h, 1Fh, 0, 53h, 1Eh, 81h, 0C3h, 34h, 8, 53h, 2Eh
	db	0FFh, 36h, 0B7h, 87h, 2Eh, 0FFh, 36h, 0B5h, 87h, 9Ah, 35h, 17h
	db	0DFh, 0, 5Bh, 53h, 1Eh, 81h, 0C3h, 34h, 8, 53h, 9Ah, 17h, 2Eh
	db	0DFh, 0, 5Bh, 0C3h, 'PQR', 91h, 0B1h, 4, 0D3h, 0C2h, 0B9h, 0F0h
	db	0FFh, 23h, 0CAh, 33h, 0D1h, 3, 0C1h, 12h, 0D6h, 0EBh, 0Dh, 33h
	db	0C0h, 50h, 0B8h, 17h, 0, 50h, 0E8h, 0A4h, '3PQR+', 6, 35h, 0Ah
	db	83h, 0DAh, 0, 72h, 0EAh, 0BBh, 0, 80h, 23h, 0D8h, 33h, 0C3h, 97h
	db	0Bh, 0DAh, 0B1h, 2, 0D3h, 0C3h, 8Bh, 87h, 34h, 8, 80h, 0FCh, 0FFh
	db	't.=', 0, 10h, 72h, 0Ah, 8Eh, 0C0h, 89h, 1Eh, '\RZYX', 0C3h, 57h
	db	53h, 1Eh, 81h, 0C3h, 34h, 8, 53h, 9Ah, 0DFh, 2Dh, 0DFh, 0, '[_#'
	db	0C0h, 75h, 9, 0E8h, 74h, 0FFh, 8Eh, 87h, 34h, 8, 0EBh, 0DCh, 0E9h
	db	'Rz;', 1Eh, 84h, 4, 7Eh, 0Ah, 89h, 1Eh, 84h, 4, 0C7h, 6, 86h, 4
	db	0, 0, 57h, 53h, 1Eh, 81h, 0C3h, 34h, 8, 53h, 0B8h, 0, 80h, 50h
	db	9Ah, 18h, 15h, 0DFh, 0, 23h, 0C0h, 75h, 0D8h, 5Bh, 8Eh, 87h, 34h
	db	8, 0B9h, 0, 40h, 33h, 0FFh, 8Bh, 0C7h, 0FCh, 0F3h, 0ABh, 5Fh, 0EBh
	db	0BDh, 89h, '>VR', 89h, 1Eh, 54h, 52h, 0EBh, 0Ah, 8Ch, 1Eh, 56h
	db	52h, 0C7h, 6, 'TR~', 4, 'PSQ', 0E8h, 3Fh, 0FFh, 1Eh, 0C5h, 1Eh
	db	54h, 52h, 8Eh, 1Fh, 8Bh, 0D9h, 0B9h, 0, 80h, 2Bh, 0CFh, 3Bh, 0C8h
	db	72h, 1Fh, 8Bh, 0C8h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h
	db	0A4h, 1Fh, 8Bh, 0Eh, '\R;', 0Eh, 84h, 4, 74h, 1Bh, 3Bh, 0Eh, '^R}!Y[X'
	db	0C3h, 3, 0D9h, 2Bh, 0C1h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h
	db	0A4h, 1Fh, 8Bh, 0CBh, 0EBh, 0BBh, 3Bh, 3Eh, 86h, 4, 72h, 0DFh
	db	89h, 3Eh, 86h, 4, 0EBh, 0D9h, 7Fh, 0Ch, ';>`Rr', 0D7h, 89h, '>`R'
	db	0EBh, 0D1h, 89h, 0Eh, 5Eh, 52h, 89h, '>`R', 0EBh, 0C7h, 'PSQR'
	db	8Ch, 1Eh, 56h, 52h, 89h, 1Eh, 54h, 52h, 0E8h, 0E9h, 0FEh, 1Eh
	db	0C5h, 1Eh, 54h, 52h, 8Eh, 1Fh, 0BBh, 0, 80h, 2Bh, 0DFh, 3Bh, 0CBh
	db	77h, 18h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 1Fh
	db	8Bh, 0Eh, '\R;', 0Eh, 84h, 4, 74h, 1Ah, 'ZY[X', 0C3h, 51h, 8Bh
	db	0CBh, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 59h, 1Fh
	db	3, 0C3h, 12h, 0D6h, 2Bh, 0CBh, 0EBh, 0C0h, 3Bh, 3Eh, 86h, 4, 72h
	db	0E0h, 89h, 3Eh, 86h, 4, 0EBh, 0DAh, 53h, 51h, 0E8h, 9Bh, 0FEh
	db	0BBh, 0, 80h, 2Bh, 0DFh, 3Bh, 0CBh, 77h, 1Bh, 3, 0C1h, 12h, 0D6h
	db	0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 8Bh, 0Eh, '\R;'
	db	0Eh, 84h, 4, 74h, 19h, 59h, 5Bh, 0Eh, 7, 0C3h, 51h, 8Bh, 0CBh
	db	3, 0C1h, 12h, 0D6h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h
	db	59h, 2Bh, 0CBh, 0EBh, 0C5h, 3Bh, 3Eh, 86h, 4, 72h, 0E1h, 89h, 3Eh
	db	86h, 4, 0EBh, 0DBh, 'WVSQR&', 8Ch, 6, 50h, 52h, 0BEh, 7Ah, 92h
	db	0B8h, 0FFh, 0FFh, 26h, 80h, 3Ch, 0, 74h, 18h, 2Eh, 8Eh, 1Eh, 10h
	db	0, 0B4h, 80h, 0E8h, 54h, 4, 8Bh, 0C3h, 2Eh, 8Eh, 6, 10h, 0, 26h
	db	0C5h, 1Eh, 34h, 1, 8Eh, 1Fh, 'ZY[^_', 0C3h, 57h, 53h, 0BFh, 7Bh
	db	92h, 0B9h, 40h, 0, 0ACh, 0Ah, 0C0h, 74h, 6, 0E3h, 2, 49h, 0AAh
	db	0EBh, 0F5h, 83h, 0E9h, 40h, 0F7h, 0D9h, 26h, 88h, 0Eh, 7Ah, 92h
	db	5Bh, 5Fh, 0C3h, 1Eh, 2Eh, 8Eh, 1Eh, 10h, 0, 0C7h, 6, 1Ah, 4, 0
	db	0, 0C7h, 6, 2Eh, 8, 0, 0, 1Fh, 0C3h, 1Eh, 2Eh, 8Eh, 1Eh, 10h, 0
	db	33h, 0FFh, 8Eh, 6, 30h, 8, ';>.', 8, 73h, 5, 0AFh, 74h, 14h, 0E2h
	db	0FBh, 0BFh, 2, 0, 57h, 0BFh, 2Ch, 8, 0E8h, 8Eh, 0CAh, 73h, 3, 0E8h
	db	7Ch, 0CAh, 26h, 89h, 5, 1Fh, 0C3h, 'VFF', 0B8h, 0FEh, 0FFh, 80h
	db	3Ch, 0, 74h, 6, 0E8h, 93h, 0FFh, 0E8h, 5Ch, 0FFh, 0E8h, 0C1h, 0FFh
	db	5Eh, 0C3h, 53h, 1Eh, 6, 2Eh, 8Eh, 6, 10h, 0, 26h, 0C5h, 1Eh, 34h
	db	1, 8Eh, 1Fh, 80h, 3Ch, 0FFh, 74h, 3, 0E9h, 95h, 0, 8Ah, 44h, 1
	db	3Ch, 1, 74h, 0Fh, 3Ch, 2, 'tj<', 3, 'tk<', 4, 74h, 75h, 0E8h, 94h
	db	0FBh, 26h, 80h, 3Eh, 19h, 0, 1, 'u(&', 80h, '>wR', 1, 74h, 1Eh
	db	26h, 0C6h, 6, 77h, 52h, 1, 56h, 33h, 0C0h, 50h, 0B8h, 3Ch, 0, 50h
	db	0E8h, 0Eh, 31h, 2Eh, 8Eh, 6, 10h, 0, 26h, 0C5h, 1Eh, 34h, 1, 8Eh
	db	1Fh, 5Eh, 0EBh, 48h, 32h, 0E4h, 26h, 0A3h, 1Ah, 4, 26h, 0C6h, 6
	db	88h, 4, 1, 26h, 83h, 3Eh, 30h, 8, 0FFh, 75h, 16h, 6, 1Fh, 56h
	db	0BFh, 2Ch, 8, 0E8h, 0Dh, 0CBh, 5Eh, 2Eh, 8Eh, 6, 10h, 0, 26h, 0C5h
	db	1Eh, 34h, 1, 8Eh, 1Fh, 0E8h, 60h, 0FFh, 0EBh, 19h, 0E8h, 1Ch, 0FFh
	db	0EBh, 14h, 0B0h, 0, 26h, 80h, 3Eh, 2Bh, 1, 1, 74h, 0Ah, 0B0h, 1
	db	0EBh, 2, 33h, 0C0h, 26h, 0A2h, 17h, 0, 4Eh, 4Eh, 8Bh, 34h, 0F9h
	db	0EBh, 1, 0F8h, 7, 1Fh, 5Bh, 0C3h, 53h, 6, 0C4h, 1Eh, 34h, 1, 26h
	db	8Eh, 7, 23h, 0F6h, 74h, 19h, 26h, 80h, 7Ch, 2, 0FFh, 75h, 0Dh
	db	26h, 8Ah, 44h, 3, 3Ch, 3, 75h, 5, 0C6h, 6, 16h, 0, 1, 26h, 8Bh
	db	34h, 0EBh, 0E3h, 7, 5Bh, 0C3h, 56h, 8Bh, 36h, 38h, 1, 0E8h, 0CFh
	db	0FFh, 72h, 9, 8Bh, 36h, 3Eh, 1, 0E8h, 0C6h, 0FFh, 73h, 5, 0C6h
	db	6, 16h, 0, 1, 5Eh, 0C3h, 55h, 8Bh, 0ECh, 81h, 0ECh, 80h, 0, 23h
	db	0F6h, 75h, 3, 0E9h, 0B9h, 1, 83h, 0C6h, 2, 0E8h, 0F8h, 0FEh, 72h
	db	0F1h, 56h, 1Eh, 0BBh, 0BBh, 92h, 53h, 0C4h, 1Eh, 34h, 1, 26h, 0FFh
	db	37h, 56h, 9Ah, 0Ah, 0, 0AFh, 0, 83h, 3Eh, 42h, 1, 0, 74h, 6Bh
	db	80h, 3Eh, 0D5h, 3, 1, 74h, 14h, 80h, 3Eh, 0D5h, 3, 4, 74h, 0Dh
	db	0A1h, 0BBh, 92h, '=C0t', 5, '=c0uP', 1Eh, 7, 0BFh, 0BBh, 92h, 6
	db	57h, 9Ah, 9, 0, 7Fh, 0, 8Bh, 0C8h, 0B0h, 5Ch, 0F2h, 0AEh, 74h
	db	3Ch, 1Eh, 0B8h, 0BBh, 92h, 50h, 0E8h, 7Ch, 8, 73h, 32h, 0C4h, 1Eh
	db	34h, 1, 26h, 0FFh, 37h, 0A1h, 42h, 1, 50h, 0BFh, 0BBh, 92h, 1Eh
	db	57h, 8Dh, 46h, 80h, 16h, 50h, 0B8h, 80h, 0, 50h, 0E8h, 0F8h, 7
	db	72h, 14h, 0BFh, 0BBh, 92h, 1Eh, 7, 16h, 1Fh, 8Dh, 76h, 80h, 0B9h
	db	80h, 0, 0F3h, 0A4h, 2Eh, 8Eh, 1Eh, 10h, 0, 33h, 0D2h, 89h, 16h
	db	68h, 52h, 89h, 16h, 6Ah, 52h, 89h, 16h, 6Ch, 52h, 89h, 16h, 6Eh
	db	52h, 88h, 16h, 61h, 1, 80h, 3Eh, 0D4h, 3, 1, 74h, 69h, 1Eh, 80h
	db	3Eh, 0D5h, 3, 1, 75h, 0Dh, 0BAh, 0BBh, 92h, 0E8h, 11h, 77h, 0A3h
	db	50h, 2, 89h, 16h, 52h, 2, 0B8h, 0, 3Dh, 0BAh, 0BBh, 92h, 0E8h
	db	0D3h, 76h, 1Fh, 83h, '>ZR', 0, 74h, 0Bh, 8Bh, 36h, 96h, 4, 89h
	db	4, 0C7h, 44h, 6, 0, 0, 0A3h, 26h, 0, 93h, 0B4h, 3Fh, 0BAh, 50h
	db	12h, 0B9h, 0, 40h, 80h, 3Eh, 54h, 2, 0, 75h, 0Ah, 80h, 3Eh, 0D5h
	db	3, 1, 75h, 3, 0B9h, 0, 2, 0E8h, 66h, 76h, 0Bh, 0C0h, 74h, 11h
	db	1, 6, 6Ch, 52h, 83h, 16h, 6Eh, 52h, 0, 3, 0D0h, 89h, 16h, 58h
	db	52h, 0EBh, 6Bh, 0E8h, 39h, 0FAh, 8Bh, 36h, 96h, 4, 8Ah, 44h, 8
	db	0A2h, 78h, 52h, 8Bh, 44h, 6, 0A3h, 62h, 52h, 0Ah, 0C4h, 0A2h, 61h
	db	1, 8Bh, 44h, 2, 0A3h, 64h, 52h, 8Bh, 44h, 4, 0A3h, 66h, 52h, 8Bh
	db	4, 23h, 0C0h, 74h, 11h, 0A3h, 26h, 0, 8Bh, 0D8h, 33h, 0C9h, 8Bh
	db	0D1h, 0B8h, 0, 42h, 0E8h, 18h, 76h, 0EBh, 0Eh, 1Eh, 0BAh, 0BBh
	db	92h, 0B8h, 0, 3Dh, 0E8h, 46h, 76h, 1Fh, 0A3h, 26h, 0, 8Bh, 1Eh
	db	26h, 0, 0B4h, 3Fh, 0BAh, 50h, 12h, 0B9h, 0, 40h, 0E8h, 0F9h, 75h
	db	0Bh, 0C0h, 74h, 0A4h, 1, 6, 6Ch, 52h, 83h, 16h, 6Eh, 52h, 0, 3
	db	0D0h, 89h, 16h, 'XRU', 0E8h, 98h, 0CAh, 5Dh, 8Bh, 1Eh, 26h, 0
	db	8Bh, 36h, 96h, 4, 80h, 3Eh, 0D4h, 3, 1, 74h, 9, 83h, '>ZR', 0
	db	74h, 2, 0EBh, 7, 0C7h, 4, 0, 0, 0E8h, 0D6h, 75h, 0C7h, 6, 26h
	db	0, 0FFh, 0FFh, 83h, 6, 96h, 4, 0Ah, 0C4h, 36h, 34h, 1, 26h, 8Eh
	db	4, 5Eh, 26h, 8Bh, 74h, 0FEh, 0E9h, 40h, 0FEh, 8Bh, 0E5h, 5Dh, 0C3h
	db	26h, 8Bh, 55h, 0Ch, 56h, 0BEh, 34h, 7, 56h, 8Bh, 74h, 2, 83h, 0EEh
	db	18h, 26h, 8Ah, 5Dh, 10h, 0B7h, 0, 2Eh, 3, 0BFh, 'PW;', 0FEh, 's7&;U'
	db	0Ch, 'sP&', 83h, 7Dh, 0Ah, 2, 72h, 0E4h, 83h, 0C4h, 2, 5Eh, 89h
	db	3Eh, 0E2h, 3, 26h, 8Bh, 45h, 0Ch, 0F7h, '&bR;', 16h, 'nRw<r', 6
	db	3Bh, 6, 'lRs4', 0BEh, 50h, 12h, 2Bh, 6, 68h, 52h, 3, 0F0h, 0E9h
	db	77h, 0CAh, 5Eh, 81h, 0FEh, 44h, 7, 77h, 1Bh, 83h, 0E7h, 3, 83h
	db	0C6h, 8, 56h, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h
	db	0E7h, 8Eh, 85h, 38h, 7, 5Fh, 0EBh, 0AAh, 83h, 0C4h, 2, 89h, 3Eh
	db	0E2h, 3, 5Eh, 0C3h, 8Bh, 0C8h, 25h, 0, 0FCh, 33h, 0C8h, 51h, 8Bh
	db	0CAh, 92h, 8Bh, 1Eh, 26h, 0, 0B8h, 0, 42h, 0E8h, 12h, 75h, 0A3h
	db	68h, 52h, 89h, 16h, 6Ah, 52h, 0A3h, 6Ch, 52h, 89h, 16h, 6Eh, 52h
	db	0B9h, 0, 40h, 80h, 3Eh, 61h, 1, 0, 74h, 16h, 2Bh, 6, 64h, 52h
	db	1Bh, 16h, 66h, 52h, 0F7h, 0D2h, 0F7h, 0D8h, 83h, 0DAh, 0FFh, 75h
	db	5, 3Bh, 0C1h, 77h, 1, 91h, 0B4h, 3Fh, 8Bh, 1Eh, 26h, 0, 0BAh, 50h
	db	12h, 0E8h, 0D8h, 74h, 1, 6, 6Ch, 52h, 83h, 16h, 6Eh, 52h, 0, 5
	db	50h, 12h, 0A3h, 'XR^', 81h, 0C6h, 50h, 12h, 0E9h, 0E9h, 0C9h, 8Bh
	db	36h, 2Ah, 5, 0E8h, 0B5h, 8, 0C3h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h
	db	0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Bh, 34h, 0E8h
	db	9Fh, 8, 0C3h
	call	L09586	;@08E0F
	call	L09737	;@08E12
	ret	;@08E15
	db	8Ch, 1Eh, 'PRURW', 8Ah, 16h, 22h, 1, 1Eh, 7, 0BFh, 7Ah, 92h, 8Eh	;@08E16
	db	1Eh, 50h, 52h, 0FCh, 0ACh, 24h, 3Fh, 8Bh, 0D8h, 0Ah, 0E0h, 26h
	db	88h, 25h, 47h, 0B4h, 0, 8Bh, 0C8h, 0E3h, 2Bh, 51h, 0Ah, 0D2h, 75h
	db	14h, 0ACh, '<ar', 6, '<zw', 2, 2Ch, 20h, 0AAh, 32h, 0D8h, 0D1h
	db	0C3h, 0E2h, 0EEh, 0EBh, 11h, 0ACh, 0AAh, 32h, 0D8h, 0D1h, 0C3h
	db	49h, 74h, 8, 0ACh, 0AAh, 32h, 0D8h, 0D1h, 0C3h, 0E2h, 0EFh, 'XV@'
	db	6, 1Fh, 32h, 0DFh, 0BEh, 7Ah, 92h, 81h, 0E3h, 0FEh, 3Fh, 89h, 1Eh
	db	52h, 52h, 81h, 0C3h, 7Ah, 52h, 8Ch, 0DAh, 8Bh, 3Fh, 83h, 0FFh
	db	0FFh, 74h, 38h, 8Bh, 0D6h, 8Bh, 0EFh, 8Bh, 0C8h, 57h, 83h, 0E7h
	db	3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 18h, 7, '_GG'
	db	0F3h, 0A6h, 75h, 0Eh, 8Bh, 0DDh, '^_Z]', 0F8h, 0C3h, '^_Z]', 0F9h
	db	0C3h, 8Bh, 0F2h, 8Dh, 5Eh, 0FEh, 26h, 8Bh, 3Fh, 83h, 0FFh, 0FFh
	db	75h, 0CCh, 33h, 0D2h, 80h, '>vR', 2, 74h, 0E4h, 8Bh, 0C8h, 5, 7
	db	0, 24h, 0FCh, 80h, 3Eh, 16h, 0, 0, 74h, 3, 5, 4, 0, 53h, 8Bh, 1Eh
	db	1Ah, 7, 0C4h, 7Fh, 2, 3, 0F8h, ';?w;', 87h, 7Fh, 2, 5Bh, 33h, 0C0h
	db	80h, 3Eh, 16h, 0, 0, 74h, 2, 0ABh, 0ABh, 48h, 0ABh, 57h, 0ABh
	db	0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 5Fh, 1Eh, 23h
	db	0D2h, 75h, 13h, 'CCS', 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 9Fh, 18h, 7, '[KK', 89h, 3Fh, 8Bh, 0EFh, 1Fh, 0EBh
	db	82h, 0E8h, 0C8h, 0C5h, 5Bh, 73h, 0C3h, 0E8h, 89h, 0C5h, 0E8h, 0F0h
	db	0FEh, 26h, 83h, 3Fh, 0FFh, 75h, 2, 0F9h, 0C3h, 26h, 8Bh, 1Fh, 53h
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h
	db	7, 5Bh, 26h, 0F6h, 47h, 0Eh, 1, 75h, 10h, 53h, 26h, 8Bh, 1Fh, 8Eh
	db	6, 78h, 7, 26h, 80h, 7Fh, 9, 0FFh, 5Bh, 74h, 0D5h, 0F8h, 0C3h
	db	83h, 0F9h, 2, 77h, 1, 0C3h, 8Bh, 0D1h, 0D1h, 0EAh, 83h, 0E2h, 0FEh
	db	8Bh, 0C2h, 8Bh, 0D8h, 0D1h, 0E3h, 3Bh, 0D9h, 'w,&', 8Bh, 77h, 0FEh
	db	74h, 0Ch, 26h, 8Bh, 3Fh, 0FFh, 0D5h, 73h, 5, 83h, 0C3h, 2, 8Bh
	db	0F7h, 8Bh, 0FEh, 8Bh, 0F0h, 26h, 8Bh, 74h, 0FEh, 0FFh, 0D5h, 73h
	db	0Eh, 26h, 89h, 77h, 0FEh, 8Bh, 0F0h, 26h, 89h, 7Ch, 0FEh, 8Bh
	db	0C3h, 0EBh, 0CEh, 83h, 0EAh, 2, 75h, 0C5h, 8Bh, 0D1h, 83h, 0EAh
	db	2, 2Bh, 0DBh, 26h, 8Bh, 7, 8Bh, 0FAh, 26h, 0FFh, 35h, 26h, 89h
	db	5, 83h, 0EAh, 2, 8Bh, 0C3h, 43h, 0D1h, 0E3h, 3Bh, 0DAh, 77h, 19h
	db	26h, 8Bh, 37h, 74h, 0Dh, 26h, 8Bh, 7Fh, 2, 0FFh, 0D5h, 73h, 5
	db	8Bh, 0F7h, 83h, 0C3h, 2, 8Bh, 0F8h, 26h, 89h, 35h, 0EBh, 0DEh
	db	5Fh, 0Bh, 0C0h, 74h, 15h, 8Bh, 0D8h, 0D1h, 0EBh, 4Bh, 83h, 0E3h
	db	0FEh, 26h, 8Bh, 37h, 0FFh, 0D5h, 73h, 6, 93h, 26h, 89h, 37h, 0EBh
	db	0E7h, 8Bh, 0D8h, 26h, 89h, 3Fh, 0Bh, 0D2h, 75h, 0ABh, 0C3h, 3Dh
	db	0Ah, 0, 72h, 13h, 52h, 53h, 0BBh, 0Ah, 0, 2Bh, 0D2h, 0F7h, 0F3h
	db	5Bh, 49h, 0E8h, 0EDh, 0FFh, 8Bh, 0C2h, 5Ah, 0EBh, 0Bh, 50h, 0B0h
	db	20h, 0B0h, 20h, 0E8h, 0EFh, 4, 0E2h, 0F9h, 58h, 4, 30h, 0E8h, 0E7h
	db	4, 0C3h, 0B6h, 0Fh, 22h, 0D6h, 22h, 0F0h, 32h, 0C6h, 0Ah, 0C2h
	db	0B1h, 4, 0D3h, 0C8h, 3, 0C3h, 0E8h, 34h, 5, 8Ah, 0C6h, 0E8h, 0ECh
	db	4, 0E8h, 9Ch, 5, 2, 48h, 20h, 0C3h, 51h, 0E8h, 61h, 6, 0B0h, 20h
	db	2Bh, 0Eh, 43h, 0B4h, 76h, 5, 0E8h, 0B8h, 4, 0E2h, 0FBh, 0E8h, 0B3h
	db	4, 59h, 0C3h, 1Eh, 2Eh, 8Eh, 1Eh, 10h, 0, 80h, 3Eh, 52h, 1, 0
	db	1Fh, 74h, 1Ch, 1Eh, 8Bh, 16h, 34h, 1, 83h, 0FAh, 0FFh, 74h, 11h
	db	8Bh, 16h, 3Ah, 1, 0C5h, 1Eh, 34h, 1, 8Eh, 1Fh, 83h, 0C2h, 2, 0B4h
	db	41h, 0CDh, 21h, 1Fh, 0C3h, 8Bh, 3Eh, 3Ah, 1, 0C4h, 1Eh, 34h, 1
	db	26h, 8Eh, 7, 83h, 0C7h, 2, 32h, 0C0h, 0B9h, 64h, 0, 0F2h, 0AEh
	db	26h, 81h, 7Dh, 0FCh, 'cou', 5, 26h, 80h, 7Dh, 0FEh, 6Dh, 0C3h
	db	50h, 81h, 0EBh, 1, 40h, 0D1h, 0E3h, 3, 1Eh, 2Eh, 5, 8Eh, 6, 88h
	db	7, 26h, 8Bh, 1Fh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 58h, 7, '[S&', 8Bh, 5Fh, 0Ah, 8Eh, 6, 0A8h, 7
	db	0A1h, 86h, 1, 0EBh, 9, '&;G', 2, 74h, 0Ch, 26h, 8Bh, 1Fh, 83h
	db	0FBh, 0FFh, 75h, 0F2h, 0F9h, 5Bh, 0EBh, 4, 0F8h, 83h, 0C4h, 2
	db	58h, 0C3h, 56h, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 44h, 6, 80h, 3Eh, 19h
	db	0, 0, 75h, 1Eh, 26h, 80h, 7Ch, 1, 3, 7Ch, 13h, 26h, 8Bh, 74h, 4
	db	8Eh, 6, 80h, 7, 26h, 8Bh, 74h, 4, 26h, 8Bh, 34h, 8Eh, 6, 0A0h
	db	7, 26h, 8Bh, 44h, 8, 5Eh, 0C3h, 57h, 80h, 3Eh, 19h, 0, 0, 74h
	db	7, 26h, 0F6h, 45h, 0Eh, ' u6&', 8Bh, 7Dh, 2, 83h, 0FFh, 0FFh, 74h
	db	19h, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh
	db	85h, 38h, 7, 5Fh, 26h, 83h, 7Dh, 0Ah, 2, 72h, 3, 0F9h, 0EBh, 1
	db	0F8h, 5Fh, 9Fh, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h
	db	0E7h, 8Eh, 85h, 58h, 7, 5Fh, 9Eh, 0C3h, 26h, 8Bh, 7Dh, 2, 8Eh
	db	6, 8, 8, 26h, 83h, 7Dh, 6, 0, 75h, 0DAh, 0EBh, 0DBh, 0C7h, 6, 5Ah
	db	52h, 0, 0, 8Bh, 0Eh, 72h, 52h, 0E3h, 0Fh, 8Bh, '6tR', 8Bh, 1Ch
	db	23h, 0DBh, 75h, 7, 83h, 0C6h, 0Ah, 0E2h, 0F5h, 0F9h, 0C3h, 0C7h
	db	4, 0, 0, 52h, 0E8h, '(qZ', 0F8h, 0C3h, 33h, 0D2h, 33h, 0C0h, 0B9h
	db	0Ah, 0, 0BEh, 38h, 1, 0E8h, 39h, 0, 0BEh, 3Eh, 1, 0E8h, 33h, 0
	db	89h, '6pR', 89h, 16h, 72h, 52h, 5, 40h, 1, 50h, 0E8h, 42h, 0, 59h
	db	89h, '>tR3', 0C0h, 0D1h, 0E9h, 0F3h, 0ABh, 0B8h, 0, 2, 0E8h, 31h
	db	0, 89h, 3Eh, 80h, 1, 81h, 0C7h, 0, 2, 89h, 3Eh, 7Eh, 1, 0C7h, 6
	db	7Ch, 1, 20h, 0, 0C3h, 1Eh, 2Eh, 8Eh, 6, 10h, 0, 0C5h, 1Eh, 34h
	db	1, 8Eh, 1Fh, 26h, 8Bh, 1Ch, 1Eh, 7, 23h, 0DBh, 74h, 7, 3, 0C1h
	db	42h, 8Bh, 0F3h, 0EBh, 0F0h, 1Fh, 0C3h, 8Bh, 3Eh, 0Eh, 0, 3, 0C7h
	db	0A3h, 0Eh, 0, 3Bh, 6, 10h, 0, 73h, 3, 1Eh, 7, 0C3h, 0E9h, 86h
	db	70h, 52h, 0B8h, 0, 37h, 0CDh, 21h, 8Ah, 0C2h, 5Ah, 0C3h, 53h, 1Eh
	db	0B4h, 0, ';6,', 4, 75h, 2, 0FEh, 0C4h, 24h, 1Ch, 3Ch, 14h, 75h
	db	2, 0FEh, 0C4h, 0B0h, 0FFh, 0FEh, 0CCh, 7Fh, 5Ah, 0B0h, 2, ';6R'
	db	4, 74h, 52h, 0B0h, 0, 83h, 0FEh, 0FFh, 74h, 4Bh, 80h, 3Eh, 88h
	db	4, 0, 74h, 10h, 0B0h, 4, ';6P', 4, 74h, 3Ch, 0B0h, 3, ';6N', 4
	db	74h, 34h, 0B0h, 0FDh, ';66', 4, 74h, 2Ch, 0B0h, 1, 56h, 83h, 0E6h
	db	3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 9Ch, 18h, 7, 5Eh, 8Ah
	db	5Ch, 2, 83h, 0E3h, 3Fh, 80h, 0FBh, 4, 72h, 0Eh, 81h, 78h, 1, 'DEu'
	db	7, 81h, 78h, 0FFh, 'COt', 2, 0B0h, 0, 98h, 1Fh, 5Bh, 0C3h, 56h
	db	26h, 8Ah, 44h, 9, 26h, 8Bh, 74h, 2, 0E8h, 7Ch, 0FFh, 5Eh, 8Eh
	db	6, 78h, 7, 0C3h, 55h, 8Bh, 0ECh, 1Eh, 6, 'VWPQ', 0C4h, 7Eh, 8
	db	0C5h, 76h, 4, 0ACh, 8Ah, 0C8h, 83h, 0E1h, 3Fh, 0F3h, 0A4h, 33h
	db	0C0h, 0AAh, 'YX_^', 7, 1Fh, 8Bh, 0E5h, 5Dh, 0C2h, 8, 0
@@1:	push	bx	;@092D4
	mov	bx, word ptr ds:[22h]	;@092D5
	call	L002C6	;@092D9
	mov	bx, word ptr ds:[24h]	;@092DC
	call	L002C6	;@092E0
	pop	bx	;@092E3
	ret	;@092E4
@@2:	push	ds	;@092E5
	mov	dx, word ptr ds:[13Ah]	;@092E6
	cmp	dx, 0	;@092EA
	je	@@3	;@092ED
	lds	bx, dword ptr ds:[134h]	;@092EF
	mov	ds, word ptr [bx]	;@092F3
	add	dx, 2	;@092F5
	push	ds	;@092F8
	push	dx	;@092F9
	call	@@4	;@092FA
@@3:	mov	ax, 2	;@092FD
	push	ax	;@09300
	call	@@5	;@09301
	pop	ds	;@09304
	ret	;@09305
@@4:	push	bp	;@09306
	mov	bp, sp	;@09307
	push	ds	;@09309
	push	dx	;@0930A
	lds	dx, dword ptr [bp+4]	;@0930B
	mov	ah, 41h	;@0930E
	int	21h	;@09310
	pop	dx	;@09312
	pop	ds	;@09313
	pop	bp	;@09314
	ret	4	;@09315
@@5:	push	bp	;@09318
	mov	bp, sp	;@09319
	call	L0012E	;@0931B
	mov	ax, word ptr [bp+4]	;@0931E
	mov	ah, 4Ch	;@09321
	int	21h	;@09323
	pop	bp	;@09325
	ret	2	;@09326
	db	50h, 0B8h, 2, 0, 50h, 0B8h, 1Eh, 0, 50h, 0E8h, 6Ch, 28h, 80h, 3Eh	;@09329
	db	1Fh, 1, 1, 'u#WPS', 0C4h, 1Eh, 34h, 1, 26h, 8Eh, 7, 8Bh, 3Eh, 3Ah
	db	1, 83h, 0C7h, 2, 32h, 0C0h, 0B9h, 64h, 0, 0F2h, 0AEh, '[X&', 89h
	db	45h, 0FCh, 26h, 88h, 5Dh, 0FEh, 5Fh, 0C3h, 55h, 8Bh, 0ECh, 1Eh
	db	0C4h, 7Eh, 4, 26h, 80h, 3Dh, 0, 74h, 13h, 0C5h, 76h, 8, 8Bh, 4Eh
	db	0Ch, 0F3h, 0A6h, 74h, 0Fh, 33h, 0C0h, 0B9h, 0FFh, 0FFh, 0F2h, 0AEh
	db	74h, 0E7h, 33h, 0C0h, 8Bh, 0D0h, 0EBh, 4, 8Ch, 0C2h, 8Bh, 0C7h
	db	1Fh, 8Bh, 0E5h, 5Dh, 0C2h, 0Ah, 0, 6, 51h, 57h, 0BFh, 0A7h, 1
	db	8Eh, 0C7h, 26h, 8Bh, 3Eh, 0, 0, 8Eh, 0C7h, 33h, 0FFh, 33h, 0C0h
	db	0B9h, 0FFh, 0FFh, 0F2h, 0AEh, 74h, 3, 0F9h, 0EBh, 0Eh, 26h, 80h
	db	3Dh, 0, 75h, 0EEh, 83h, 0C7h, 3, 8Ch, 0C2h, 8Bh, 0C7h, 0F8h, 5Fh
	db	59h, 7, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 56h, 0C5h, 76h
	db	0Eh, 0C6h, 46h, 0FEh, 0, 8Bh, 4Eh, 4, 49h, 0C4h, 7Eh, 6, 0ACh
	db	0Ah, 0C0h, 75h, 0Dh, 0EBh, 3Ah, 0ACh, 0Ah, 0C0h, 75h, 6, 0C6h
	db	46h, 0FEh, 1, 0EBh, 9, '<;t', 5, 0AAh, 0E2h, 0EEh, 0EBh, 26h, 89h
	db	76h, 0Eh, 0B0h, 5Ch, 0AAh, 0C5h, 76h, 0Ah, 0ACh, 0Ah, 0C0h, 74h
	db	5, 0AAh, 0E2h, 0F8h, 0EBh, 13h, 32h, 0C0h, 0AAh, 0FFh, 76h, 8
	db	0FFh, 76h, 6, 0E8h, 16h, 0, 73h, 6, 0C5h, 76h, 0Eh, 0EBh, 0B8h
	db	0F9h, 8Bh, 56h, 8, 8Bh, 46h, 6, 5Eh, 1Fh, 8Bh, 0E5h, 5Dh, 0C2h
	db	0Eh, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 2Fh, 1Eh, 0B4h, 2Fh, 0CDh, 21h
	db	8Ch, 46h, 0FEh, 89h, 5Eh, 0FCh, 0B4h, 1Ah, 16h, 1Fh, 8Dh, 56h
	db	0D1h, 0CDh, 21h, 0B4h, 4Eh, 33h, 0C9h, 0C5h, 56h, 4, 0CDh, 21h
	db	9Ch, 8Eh, 5Eh, 0FEh, 8Bh, 56h, 0FCh, 0B4h, 1Ah, 0CDh, 21h, 9Dh
	db	1Fh, 8Bh, 0E5h, 5Dh, 0C2h, 4, 0, 80h, 3Eh, 19h, 0, 0, 75h, 1Ah
	db	0C7h, 6, 0D1h, 6, 4, 0, 0C7h, 6, 0FAh, 3, 0Fh, 0, 0EBh, 2Bh, 33h
	db	0C0h, 50h, 0B8h, 2Dh, 0, 50h, 0E8h, 2Bh, 27h, 0EBh, 1Fh, 8Bh, 0Eh
	db	46h, 1, 0E3h, 0EEh, 33h, 0DBh, 43h, 0D1h, 0E9h, 75h, 0FBh, 4Bh
	db	89h, 1Eh, 0D1h, 6, 8Bh, 0CBh, 0B8h, 1, 0, 0D1h, 0E0h, 0E2h, 0FCh
	db	48h, 0A3h, 0FAh, 3, 0C3h, 'PSR', 0BBh, 0, 2, 0F7h, 0F3h, 89h, 16h
	db	9Eh, 4, 0F7h, 0DAh, 15h, 0, 0, 0A3h, 0A0h, 4, 'Z[X', 0C3h, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
L094C0:	push	ax	;@094C0
	push	bx	;@094C1
	push	cx	;@094C2
	push	dx	;@094C3
	push	si	;@094C4
	push	es	;@094C5
	mov	cx, di	;@094C6
	mov	dx, 9340h	;@094C8
	sub	cx, dx	;@094CB
	cmp	cx, 2000h	;@094CD
	jb	@@1	;@094D1
	mov	cx, 2000h	;@094D3
@@1:	mov	ah, 40h	;@094D6
	mov	bx, word ptr ds:[22h]	;@094D8
	cmp	bx, -1	;@094DC
	je	@@2	;@094DF
	call	L002B2	;@094E1
@@2:	cmp	byte ptr ds:[0B445h], 1	;@094E4
	jne	@@3	;@094E9
	mov	ah, 40h	;@094EB
	mov	bx, 1	;@094ED
	call	L002B2	;@094F0
@@3:	mov	si, 0B340h	;@094F3
	mov	cx, di	;@094F6
	mov	di, 9340h	;@094F8
	sub	cx, si	;@094FB
	jbe	@@4	;@094FD
	push	ds	;@094FF
	pop	es	;@09500
	cld	;@09501
	rep movsb	;@09502
@@4:	mov	word ptr ds:[0B441h], di	;@09504
	pop	es	;@09508
	pop	si	;@09509
	pop	dx	;@0950A
	pop	cx	;@0950B
	pop	bx	;@0950C
	pop	ax	;@0950D
	ret	;@0950E
L0950F:	mov	byte ptr [di], al	;@0950F
	inc	di	;@09511
	cmp	di, 0B340h	;@09512
	jae	@@1	;@09516
	ret	;@09518
@@1:	call	L094C0	;@09519
	ret	;@0951C
	db	'0123456789ABCDEFS', 0BBh, 1Dh, 95h, 24h, 0Fh, 2Eh, 0D7h, 88h	;@0951D
	db	5, 47h, 5Bh, 81h, 0FFh, 40h, 0B3h, 73h, 1, 0C3h, 0E8h, 7Dh, 0FFh
	db	0C3h
L09544:	push	ax	;@09544
	push	bx	;@09545
	mov	bx, 951Dh	;@09546
	mov	ah, al	;@09549
	and	al, 0Fh	;@0954B
	xlat	byte ptr cs:[bx]	;@0954D
	xchg	al, ah	;@0954F
	shr	al, 1	;@09551
	shr	al, 1	;@09553
	shr	al, 1	;@09555
	shr	al, 1	;@09557
	xlat	byte ptr cs:[bx]	;@09559
	mov	word ptr [di], ax	;@0955B
	inc	di	;@0955D
	inc	di	;@0955E
	pop	bx	;@0955F
	pop	ax	;@09560
	ret	;@09561
L09562:	call	L09544	;@09562
	cmp	di, 0B340h	;@09565
	jae	@@1	;@09569
	ret	;@0956B
@@1:	call	L094C0	;@0956C
	ret	;@0956F
L09570:	push	ax	;@09570
	mov	al, ah	;@09571
	call	L09562	;@09573
	pop	ax	;@09576
	call	L09562	;@09577
	ret	;@0957A
L0957B:	push	ax	;@0957B
	mov	al, ah	;@0957C
	call	L09544	;@0957E
	pop	ax	;@09581
	call	L09544	;@09582
	ret	;@09585
L09586:	mov	al, 0Dh	;@09586
	call	L0950F	;@09588
	mov	al, 0Ah	;@0958B
	jmp	L0950F	;@0958D
L0958F:	push	ax	;@0958F
	push	cx	;@09590
	mov	cx, 0FFh	;@09591
	push	es	;@09594
	push	ds	;@09595
	pop	es	;@09596
	pop	ds	;@09597
	lodsb	;@09598
	and	cx, ax	;@09599
	push	cx	;@0959B
	je	@@1	;@0959C
	rep movsb	;@0959E
@@1:	push	es	;@095A0
	push	ds	;@095A1
	pop	es	;@095A2
	pop	ds	;@095A3
	pop	word ptr ds:[0B443h]	;@095A4
	pop	cx	;@095A8
	pop	ax	;@095A9
	cmp	di, 0B340h	;@095AA
	jae	@@2	;@095AE
	ret	;@095B0
@@2:	call	L094C0	;@095B1
	ret	;@095B4
	db	50h, 51h, 0B9h, 3Fh, 0, 0EBh, 0D8h, 1Eh, 6, 2Eh, 8Eh, 6, 10h, 0	;@095B5
	db	0FCh, 0EBh, 1, 0AAh, 0ACh, 3Ch, 0, 75h, 0FAh, 7, 1Fh, 81h, 0FFh
	db	40h, 0B3h, 73h, 1, 0C3h, 1Eh, 2Eh, 8Eh, 1Eh, 10h, 0, 0E8h, 0E2h
	db	0FEh, 1Fh, 0C3h
L095E0:	pop	si	;@095E0
	push	cs	;@095E1
	pop	es	;@095E2
	call	L0958F	;@095E3
	jmp	si	;@095E6
	db	6, 1Fh, 2Eh, 8Eh, 6, 10h, 0, 'FFW', 0BFh, 1, 0B4h, 0FCh, 0ACh	;@095E8
	db	25h, 3Fh, 0, 0AAh, 91h, 0F3h, 0A4h, 0B0h, 0, 0AAh, 6, 1Fh, 0BEh
	db	1, 0B4h, 80h, 3Eh, 22h, 1, 0, 75h, 16h, 46h, 0ACh, '<Zw', 0FBh
	db	'<As', 6, 0Ah, 0C0h, 75h, 0F3h, 0EBh, 6, 80h, 44h, 0FFh, 20h, 0EBh
	db	0EBh, 5Fh, 0BEh, 2, 0B4h, 1Eh, 56h, 1Eh, 57h, 0B8h, 0FFh, 0, 50h
	db	33h, 0C0h, 'PPPP@P', 0B8h, 0A7h, 1, 8Eh, 0D8h, 9Ah, 67h, 9, 4Fh
	db	0, 2Eh, 8Eh, 1Eh, 10h, 0, 1Eh, 7, 0C3h, 51h, 83h, 0FEh, 0FFh, 74h
	db	1Fh, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh
	db	84h, 18h, 7, 5Eh, 26h, 80h, 7Ch, 3, 40h, 74h, 15h, 'VFF', 0E8h
	db	4Ah, 0FFh, 5Eh, 59h, 0C3h, 0E8h, 6Fh, 0FFh, 6, '(none)Y', 0C3h
	db	'PSRVW', 0E8h, 66h, 0FFh, 5Fh, 8Bh, 0DFh, 0B9h, 0FFh, 0, 0FCh
	db	0B0h, 0, 0F2h, 0AEh, 4Fh, 2Bh, 0DFh, 0F7h, 0DBh, 89h, 1Eh, 43h
	db	0B4h, '^Z[XY', 81h, 0FFh, 40h, 0B3h, 73h, 1, 0C3h, 1Eh, 2Eh, 8Eh
	db	1Eh, 10h, 0, 0E8h, 15h, 0FEh, 1Fh, 0C3h, 51h, 83h, 0FEh, 0FFh
	db	74h, 18h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h
	db	8Eh, 84h, 18h, 7, '^VFF', 0E8h, 0EDh, 0FEh, 5Eh, 59h, 0C3h, 0E8h
	db	12h, 0FFh, 6, '(none)Y', 0C3h
L096D7:	push	ax	;@096D7
	push	bx	;@096D8
	push	cx	;@096D9
	mov	bx, 0Ah	;@096DA
	mov	cx, 5	;@096DD
	mov	ax, 2710h	;@096E0
	cwd	;@096E3
@@1:	cmp	ax, si	;@096E4
	jbe	@@2	;@096E6
	div	bx	;@096E8
	loop	@@1	;@096EA
	mov	al, 30h	;@096EC
	mov	byte ptr [di], al	;@096EE
	inc	di	;@096F0
	jmp	short @@3	;@096F1
@@2:	xchg	ax, si	;@096F3
	div	si	;@096F4
	push	dx	;@096F6
	push	si	;@096F7
	add	al, 30h	;@096F8
	push	bx	;@096FA
	push	cx	;@096FB
	mov	byte ptr [di], al	;@096FC
	inc	di	;@096FE
	pop	cx	;@096FF
	pop	bx	;@09700
	pop	ax	;@09701
	cwd	;@09702
	div	bx	;@09703
	pop	si	;@09705
	loop	@@2	;@09706
@@3:	pop	cx	;@09708
	pop	bx	;@09709
	pop	ax	;@0970A
	ret	;@0970B
	db	0E8h, 0C8h, 0FFh, 81h, 0FFh, 40h, 0B3h, 73h, 1, 0C3h, 0E8h, 0A7h	;@0970C
	db	0FDh, 0C3h, 1Eh, 53h, 0BEh, 0BBh, 92h, 0E8h, 9Ah, 0FEh, 5Bh, 1Fh
	db	0C3h
L09725:	mov	ds, word ptr cs:L00100+16	;@09725
	mov	di, word ptr ds:[0B441h]	;@0972A
	call	L094C0	;@0972E
	mov	byte ptr ds:[0B445h], 1	;@09731
	ret	;@09736
L09737:	call	L094C0	;@09737
	mov	byte ptr ds:[0B445h], 0FFh	;@0973A
	ret	;@0973F
	db	1Eh, 2Eh, 8Eh, 6, 10h, 0, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h	;@09740
	db	0E6h, 0D1h, 0E6h, 8Eh, 9Ch, 18h, 7, 5Eh, 0ADh, 0ACh, 25h, 3Fh
	db	0, 8Bh, 0C8h, 0F3h, 0A4h, 32h, 0C0h, 0AAh, 1Fh, 0C3h
L09763:	push	bp	;@09763
	mov	bp, sp	;@09764
	push	ds	;@09766
	push	es	;@09767
	push	si	;@09768
	push	di	;@09769
	lds	si, dword ptr [bp+4]	;@0976A
	mov	es, word ptr cs:L00100+16	;@0976D
	mov	di, word ptr ds:[0B441h]	;@09772
	cld	;@09776
	jmp	short @@2	;@09777
@@1:	stosb	;@09779
@@2:	lodsb	;@0977A
	cmp	al, 0	;@0977B
	jne	@@1	;@0977D
	mov	ds, word ptr cs:L00100+16	;@0977F
	cmp	di, 0B340h	;@09784
	jb	@@3	;@09788
	call	L094C0	;@0978A
@@3:	mov	word ptr ds:[0B441h], di	;@0978D
	pop	di	;@09791
	pop	si	;@09792
	pop	es	;@09793
	pop	ds	;@09794
	pop	bp	;@09795
	ret	4	;@09796
	db	0, 0, 0, 0, 0, 0, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 33h, 0C0h, 0ACh	;@09799
	db	3Dh, 2, 0, 'ti=', 1, 0, 74h, 3, 0E8h, 0E7h, 0EEh, 33h, 0C0h, 0ACh
	db	50h, 33h, 0DBh, 80h, 3Ch, 0, 74h, 1Ah, 33h, 0C0h, 80h, 3Eh, 29h
	db	1, 0, 74h, 1, 40h, 0FFh, 36h, 22h, 1, 0A2h, 22h, 1, 0B4h, 0, 0E8h
	db	3Fh, 0F6h, 58h, 0A2h, 22h, 1, 89h, 1Eh, 0E7h, 6, 89h, 1Eh, 0DFh
	db	6, 0B4h, 0C0h, 0E8h, 2Eh, 0F6h, 89h, 1Eh, 0E1h, 6, 58h, 0Bh, 0C0h
	db	74h, 3, 0ADh, 0EBh, 10h, 80h, 3Ch, 0, 74h, 9, 0B4h, 0, 0E8h, 18h
	db	0F6h, 89h, 1Eh, 0DFh, 6, 33h, 0C0h, 0A3h, 0E3h, 6, 0C7h, 6, 0E5h
	db	6, 0, 0, 0E8h, 0FEh, 1Fh, 89h, 3Eh, 3Bh, 5, 0E9h, 7Fh, 0, 33h
	db	0C0h, 0ACh, 89h, 46h, 0FEh, 0B4h, 0, 0E8h, 0F4h, 0F5h, 89h, 5Eh
	db	0FCh, 80h, 3Ch, 0, 74h, 1Ah, 33h, 0C0h, 80h, 3Eh, 29h, 1, 0, 74h
	db	1, 40h, 0FFh, 36h, 22h, 1, 0A2h, 22h, 1, 0B4h, 0, 0E8h, 0D6h, 0F5h
	db	58h, 0A2h, 22h, 1, 89h, 5Eh, 0FAh, 0BBh, 0, 0, 8Bh, 46h, 0FEh
	db	0A8h, 80h, 74h, 2, 8Bh, 1Ch, 89h, 5Eh, 0F8h, 8Bh, 5Eh, 0FAh, 53h
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h
	db	7, 5Bh, 26h, 8Bh, 1Fh, 83h, 0FBh, 0FFh, 74h, 26h, 0E8h, '1 &'
	db	89h, 5Dh, 4, 8Bh, 5Eh, 0FCh, 26h, 89h, 5Dh, 2, 8Bh, 5Eh, 0F8h
	db	26h, 89h, 5Dh, 6, 8Bh, 46h, 0FEh, 0Ch, 80h, 26h, 88h, 45h, 8, 0FFh
	db	6, 0A4h, 0B4h, 0FFh, 6, 0A6h, 0B4h, 8Bh, 0E5h, 5Dh, 0C3h, 60h
	db	4, 62h, 4, 64h, 4, 66h, 4, 68h, 4, 6Ah, 4, 'SQVW', 0BEh, 9Ah, 98h
	db	0B9h, 6, 0, 2Eh, 8Bh, 1Ch, 8Bh, 1Fh, 3Bh, 1Eh, 4Ah, 2, 74h, 8
	db	83h, 0C6h, 2, 49h, 75h, 0EFh, 0EBh, 24h, 0F7h, 0D1h, 83h, 0E1h
	db	7, 0C6h, 6, 0F3h, 6, 5, 0C6h, 6, 0F4h, 6, 7, 3, 3Eh, 0E8h, 3, 89h
	db	3Eh, 0F5h, 6, 89h, 0Eh, 0F7h, 6, 0C7h, 6, 0F9h, 6, 0, 0, 0E8h
	db	0EAh, 0A6h, '_^Y[', 0C3h, 56h, 57h, 6, 8Ah, 0C6h, 0D0h, 0E8h, 0D0h
	db	0E8h, 3Ch, 1, 75h, 2, 0B0h, 5, 0A2h, 0F3h, 6, 83h, 0FBh, 0FDh
	db	75h, 26h, 0C6h, 6, 0F4h, 6, 1, 8Eh, 6, 8, 8, 8Bh, 0F1h, 26h, 8Bh
	db	5Ch, 2, 26h, 8Bh, 4Ch, 4, 81h, 0E1h, 0FFh, 7Fh, 0Bh, 0C9h, 75h
	db	9, 0C6h, 6, 0F4h, 6, 2, 26h, 8Bh, 4Ch, 6, 0EBh, 69h, 8Eh, 6, 0A0h
	db	7, 80h, 3Eh, 8Bh, 0B4h, 1, 't0&', 0F6h, 47h, 13h, 1, 't)Q', 3
	db	0Eh, 1Eh, 2, 0F6h, 6, 15h, 2, 20h, 75h, 0Bh, 3, 8Dh, 50h, 0Ah
	db	80h, 0FEh, 8, 75h, 2, 33h, 0C9h, 0E8h, 1Eh, 1Dh, 3Dh, 0FFh, 0FFh
	db	74h, 55h, 83h, 0C4h, 2, 8Bh, 0C8h, 0BBh, 0FFh, 0FFh, 0EBh, 4, 26h
	db	8Bh, 5Fh, 6, 32h, 0FFh, 0C6h, 6, 0F4h, 6, 0, 80h, 0FEh, 8, 75h
	db	0Eh, 0F6h, 6, 15h, 2, 10h, 75h, 7, 80h, 0Eh, 0F4h, 6, 4, 0EBh
	db	9, 80h, 0FBh, 0FFh, 74h, 4, 3, 8Dh, 50h, 0Ah, 0F6h, 6, 0F4h, 6
	db	4, 75h, 6, 0C7h, 85h, 50h, 0Ah, 0FFh, 0FFh, 89h, 1Eh, 0F7h, 6
	db	89h, 0Eh, 0F9h, 6, 3, 3Eh, 0E8h, 3, 89h, 3Eh, 0F5h, 6, 0E8h, 26h
	db	0A6h, 7, 5Fh, 5Eh, 0C3h, 'PSRVWQ', 8Eh, 6, 0A0h, 7, 26h, 8Bh, 5Fh
	db	6, 53h, 0B9h, 4, 0, 51h, 0B8h, 39h, 0, 50h, 0E8h, 0E2h, '!_^Z[XY'
	db	8Eh, 6, 0A0h, 7, 0EBh, 8Fh, 6, 56h, 33h, 0F6h, 8Eh, 6, 0D0h, 7
	db	3Bh, 36h, 0CEh, 7, 73h, 0Ah, 26h, 3Bh, 4, 74h, 3Eh, 83h, 0C6h
	db	6, 0EBh, 0F0h, 0BFh, 6, 0, 57h, 0BFh, 0CCh, 7, 0E8h, 0C6h, 0BAh
	db	73h, 3, 0E8h, 0B4h, 0BAh, 26h, 89h, 5, 26h, 89h, 4Dh, 4, 26h, 0FFh
	db	45h, 4, 8Bh, 0D8h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 18h, 7, 5Bh, 83h, 0C3h, 2, 26h, 8Ah, 7, 25h, 3Fh
	db	0, 40h, 8Bh, 0DFh, 0EBh, 4, 8Bh, 0DEh, 33h, 0C0h, 5Eh, 7, 0C3h
	db	'SQRVW', 6, 0BFh, 0C4h, 7, 0E8h, 9Dh, 0BBh, 0BFh, 0CCh, 7, 0E8h
	db	97h, 0BBh, 33h, 0F6h, 33h, 0C9h, 0EBh, 0Eh, 8Eh, 6, 8, 8, 26h
	db	83h, 7Ch, 6, 0FFh, 74h, 12h, 83h, 0C6h, 0Ch, 3Bh, 36h, 6, 8, 72h
	db	0ECh, 8Bh, 0C1h, 7, '_^ZY[', 0C3h, 26h, 8Bh, 44h, 2, 0E8h, 6Ch
	db	0FFh, 0Bh, 0C0h, 74h, 36h, 8Bh, 0D3h, 0BFh, 2, 0, 57h, 0BFh, 0C4h
	db	7, 0E8h, 44h, 0BAh, 73h, 3, 0E8h, 32h, 0BAh, 8Bh, 0DFh, 26h, 89h
	db	0Fh, 26h, 0FFh, 7, 0D1h, 0EBh, 43h, 87h, 0D3h, 8Eh, 6, 0D0h, 7
	db	26h, 89h, 57h, 2, 8Eh, 6, 8, 8, 26h, 89h, 54h, 2, 26h, 89h, 5Ch
	db	0Ah, 3, 0C8h, 0EBh, 14h, 8Eh, 6, 0D0h, 7, 26h, 8Bh, 47h, 2, 8Eh
	db	6, 8, 8, 26h, 89h, 44h, 2, 26h, 89h, 5Ch, 0Ah, 26h, 8Bh, 44h, 4
	db	0Bh, 0C0h, 75h, 91h, 26h, 8Bh, 4, 0E8h, 10h, 0FFh, 3, 0C8h, 8Eh
	db	6, 0D0h, 7, 26h, 8Bh, 47h, 4, 8Eh, 6, 8, 8, 26h, 89h, 44h, 6, 0E9h
	db	76h, 0FFh, 'PATH=U', 8Bh, 0ECh, 81h, 0ECh, 88h, 0, 0BFh, 0FCh
	db	7, 0E8h, 0EAh, 0BAh, 8Bh, 1Eh, 9Ah, 0B4h, 83h, 0FBh, 0, 75h, 6Eh
	db	0B9h, 40h, 0, 0B8h, 44h, 0, 80h, 3Eh, 2Ah, 1, 2, 74h, 3, 0B8h
	db	37h, 0, 3, 0C8h, 83h, 0C1h, 0Fh, 80h, 0E1h, 0F0h, 51h, 8Bh, 0F9h
	db	57h, 0BFh, 0FCh, 7, 0E8h, 0A6h, 0B9h, 73h, 3, 0E8h, 94h, 0B9h
	db	33h, 0C0h, 0F3h, 0AAh, 59h, 51h, 0Eh, 1Fh, 0BEh, 61h, 0A1h, 0B9h
	db	1Ah, 0, 33h, 0FFh, 0F3h, 0A4h, 0BFh, 3Eh, 0, 83h, 0C7h, 0Fh, 83h
	db	0E7h, 0F0h, 2Eh, 8Eh, 1Eh, 10h, 0, 0BEh, 7Bh, 0A1h, 0B9h, 44h
	db	0, 80h, 3Eh, 2Ah, 1, 2, 74h, 6, 0BEh, 0BFh, 0A1h, 0B9h, 37h, 0
	db	0Eh, 1Fh, 0F3h, 0A4h, 2Eh, 8Eh, 1Eh, 10h, 0, 58h, 0E9h, 0D2h, 0
	db	0B8h, 28h, 0, 8Ch, 0DAh, 0EBh, 68h, 8Eh, 6, 6Ch, 0B4h, 0BFh, 28h
	db	0, 57h, 33h, 0C9h, 26h, 8Ah, 0Fh, 51h, 1Eh, 57h, 6, 53h, 0E8h
	db	36h, 0F7h, 59h, 0E3h, 1Ah, 0BBh, 28h, 0, 80h, '?\t', 0D9h, 80h
	db	'?:t', 0D4h, 43h, 0E2h, 0F3h, 1Eh, 0B8h, 28h, 0, 50h, 0E8h, 93h
	db	0F8h, 72h, 7, 8Ch, 0DAh, 0B8h, 28h, 0, 0EBh, 2Fh, 0B8h, 5, 0, 50h
	db	0Eh, 0B8h, 0DAh, 9Ah, 50h, 0B8h, 0A7h, 1, 8Eh, 0C0h, 26h, 0A1h
	db	0, 0, 50h, 33h, 0C0h, 50h, 0E8h, 0ABh, 0F7h, 52h, 50h, 0BFh, 28h
	db	0, 1Eh, 57h, 16h, 8Dh, 86h, 78h, 0FFh, 50h, 0B8h, 80h, 0, 50h
	db	0E8h, 0F7h, 0F7h, 72h, 76h, 89h, 56h, 0FAh, 89h, 46h, 0F8h, 0B8h
	db	0, 3Dh, 8Eh, 5Eh, 0FAh, 8Bh, 56h, 0F8h, 0E8h, 0Fh, 67h, 2Eh, 8Eh
	db	1Eh, 10h, 0, 89h, 46h, 0FEh, 8Bh, 0D8h, 33h, 0C9h, 8Bh, 0D1h, 0B8h
	db	2, 42h, 0E8h, 0C1h, 66h, 83h, 0FAh, 0, 75h, 5Bh, 89h, 46h, 0FCh
	db	8Bh, 0F8h, 57h, 0BFh, 0FCh, 7, 0E8h, 0BBh, 0B8h, 73h, 3, 0E8h
	db	0A9h, 0B8h, 8Bh, 5Eh, 0FEh, 33h, 0C9h, 8Bh, 0D1h, 0B8h, 0, 42h
	db	0E8h, 9Eh, 66h, 8Bh, 5Eh, 0FEh, 1Eh, 8Eh, 1Eh, 0, 8, 33h, 0D2h
	db	8Bh, 4Eh, 0FCh, 0B8h, 0, 3Fh, 0E8h, 8Bh, 66h, 1Fh, 0E8h, 33h, 0
	db	8Bh, 46h, 0FCh, 0A3h, 54h, 0B4h, 0A3h, 0FEh, 7, 5, 0Fh, 0, 25h
	db	0F0h, 0FFh, 0A3h, 52h, 0B4h, 8Bh, 0E5h, 5Dh, 0C3h, 0B8h, 28h, 0
	db	1Eh, 50h, 0B8h, 4, 0, 50h, 0B8h, 1, 0, 50h, 0E8h, 50h, 1Fh, 0E8h
	db	0Ah, 0, 33h, 0C0h, 50h, 0B8h, 21h, 0, 50h, 0E8h, 43h, 1Fh, 8Bh
	db	5Eh, 0FEh, 0E8h, 62h, 66h, 0C3h, 1Eh, 0FFh, 36h, 52h, 0B4h, 0FFh
	db	36h, 9Ah, 0B4h, 8Eh, 1Eh, 0, 8, 83h, 3Eh, 6, 0, 0, 74h, 28h, 83h
	db	3Eh, 18h, 0, '@t!', 8Bh, 0Eh, 6, 0, 0D1h, 0E1h, 51h, 0D1h, 0E1h
	db	1Eh, 7, 8Bh, 36h, 18h, 0, 3, 0F1h, 83h, 0EEh, 2, 0BFh, 40h, 0
	db	3, 0F9h, 83h, 0EFh, 2, 59h, 0FDh, 0F3h, 0A5h, 0FCh, 5Bh, 58h, 0A3h
	db	3Ch, 0, 0C7h, 6, 3Eh, 0, 0, 0, 0C7h, 6, 18h, 0, 40h, 0, 0Bh, 0DBh
	db	74h, 6, 0C7h, 6, 0Ah, 0, 0, 0, 1Fh, 8Bh, 0Eh, 54h, 0B4h, 2Bh, 0C0h
	db	99h, 33h, 0F6h, 0BBh, 0, 8, 0E8h, 39h, 0ECh, 0C3h, 0C7h, 6, 9Fh
	db	6, 4Eh, 45h, 0C6h, 6, 0A1h, 6, 5, 0C6h, 6, 0A2h, 6, 0Ah, 0A1h
	db	50h, 0B4h, 80h, 3Eh, 8Bh, 0B4h, 1, 75h, 3, 0Dh, 8, 0, 0A3h, 0ABh
	db	6, 0E8h, 46h, 16h, 0A3h, 0AFh, 6, 80h, 3Eh, 0D3h, 3, 1, 74h, 0Bh
	db	80h, 3Eh, 2Bh, 1, 3, 74h, 4, 89h, 1Eh, 0B1h, 6, 33h, 0C0h, 0F7h
	db	6, 50h, 0B4h, 3, 0, 74h, 40h, 8Bh, 1Eh, 0FCh, 3, 83h, 0FBh, 0FFh
	db	75h, 18h, 33h, 0C9h, 51h, 0B8h, 38h, 0, 50h, 0E8h, 89h, 1Eh, 0EBh
	db	2Eh, 33h, 0C9h, 51h, 0B8h, 2Ch, 0, 50h, 0E8h, 78h, 1Eh, 0EBh, 1Eh
	db	8Eh, 6, 0A0h, 7, 26h, 8Bh, 47h, 6, 50h, 26h, 8Bh, 47h, 0Dh, 3
	db	6, 0AFh, 6, 72h, 0E1h, 3, 6, 0B1h, 6, 73h, 5, 3Dh, 0, 0, 75h, 0D6h
	db	58h, 0A3h, 0ADh, 6, 83h, 3Eh, 0B9h, 6, 0, 75h, 0Dh, 80h, 3Eh, 2Bh
	db	1, 3, 74h, 6, 0A1h, 0ADh, 6, 0A3h, 0B9h, 6, 80h, 3Eh, 0D3h, 3
	db	1, 74h, 11h, 83h, 3Eh, 0B1h, 6, 0, 75h, 0Ah, 80h, 3Eh, 2Bh, 1
	db	3, 74h, 3, 0E8h, 82h, 0D6h, 0A1h, 0C6h, 7, 0D1h, 0E8h, 0A3h, 0BDh
	db	6, 0E8h, 52h, 14h, 89h, 0Eh, 0BFh, 6, 0B8h, 40h, 0, 0A3h, 0C1h
	db	6, 8Bh, 0Eh, 0BBh, 6, 81h, 0F9h, 0FEh, 0, 76h, 3, 0E9h, 9Dh, 0
	db	8Bh, 1Eh, 9Eh, 7, 0Bh, 0DBh, 74h, 27h, 83h, 0EBh, 14h, 8Eh, 6
	db	0A0h, 7, 8Bh, 16h, 4, 4, 83h, 0FAh, 0FFh, 74h, 6, 8Bh, 0DAh, 26h
	db	8Bh, 4Fh, 6, 50h, 26h, 8Bh, 47h, 0Dh, 26h, 0Bh, 47h, 0Fh, 58h
	db	75h, 5, 49h, 89h, 0Eh, 0BBh, 6, 0D1h, 0E1h, 0D1h, 0E1h, 0D1h, 0E1h
	db	3, 0C1h, 0A3h, 0C3h, 6, 0A3h, 0C5h, 6, 50h, 0E8h, 32h, 10h, 58h
	db	3, 0C1h, 0A3h, 0C7h, 6, 3, 6, 0C6h, 7, 0A3h, 0C9h, 6, 3, 6, 0F8h
	db	3, 0A3h, 0A3h, 6, 50h, 0E8h, 89h, 10h, 0A3h, 0A5h, 6, 58h, 3, 6
	db	0A5h, 6, 50h, 51h, 3, 6, 52h, 0B4h, 0A3h, 0CBh, 6, 0C7h, 6, 0CDh
	db	6, 0, 0, 0C7h, 6, 0D3h, 6, 0, 0, 0E8h, 84h, 1Ah, 0A2h, 0D5h, 6
	db	0A1h, 0CBh, 6, 3, 6, 0BFh, 6, 5, 0Fh, 0, 25h, 0F0h, 0FFh, 8Bh
	db	1Eh, 0FAh, 3, 3, 0C3h, 23h, 0D8h, 33h, 0C3h, 0B1h, 4, 0D3h, 0E8h
	db	0A3h, 0FEh, 3, 59h, 58h, 0C3h, 33h, 0C0h, 50h, 0B8h, 20h, 0, 50h
	db	0E8h, 5Ah, 1Dh, 0A1h, 0B3h, 6, 0Bh, 6, 0B5h, 6, 75h, 11h, 80h
	db	3Eh, 2Bh, 1, 3, 74h, 0Ah, 33h, 0C0h, 50h, 0B8h, 3Bh, 0, 50h, 0E8h
	db	4Ah, 1Dh, 0E8h, 1, 0FEh, 0A1h, 0FEh, 3, 0E8h, 6Bh, 0D4h, 0B8h
	db	2, 0, 99h, 0B9h, 4, 0, 0BEh, 9Eh, 4, 0E8h, 0E6h, 0EAh, 0B9h, 40h
	db	0, 0BEh, 9Fh, 6, 0A1h, 52h, 0B4h, 33h, 0D2h, 0E8h, 0D8h, 0EAh
	db	0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ah, 'PSQRW', 0B8h, 0, 40h, 0F7h
	db	26h, 84h, 4, 3, 6, 86h, 4, 83h, 0D2h, 0, 89h, 56h, 0F8h, 89h, 46h
	db	0FAh, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 47h, 0Dh, 89h, 46h, 0F6h, 8Bh
	db	0FBh, 0A1h, 0FEh, 3, 33h, 0D2h, 26h, 3, 45h, 8, 26h, 12h, 55h
	db	0Ah, 0B9h, 4, 0, 0D1h, 0E0h, 0D1h, 0D2h, 0E2h, 0FAh, 89h, 56h
	db	0FCh, 89h, 46h, 0FEh, 3Bh, 56h, 0F8h, 'w>r', 5, 3Bh, 46h, 0FAh
	db	73h, 37h, 3, 46h, 0F6h, 83h, 0D2h, 0, 3Bh, 56h, 0F8h, 'w=r', 5
	db	3Bh, 46h, 0FAh, 77h, 36h, 8Bh, 46h, 0F6h, 0A3h, 0F1h, 6, 0A3h
	db	0EDh, 6, 0EBh, 45h, 76h, 3, 0E9h, 0C4h, 0, 0Bh, 0C0h, 74h, 3, 0E9h
	db	0BDh, 0, 0C7h, 6, 0EDh, 6, 0, 0, 8Bh, 46h, 0F6h, 0A3h, 0F1h, 6
	db	0EBh, 2Bh, 0B8h, 0, 0, 0A3h, 0EBh, 6, 0A3h, 0EDh, 6, 8Bh, 46h
	db	0F6h, 0A3h, 0F1h, 6, 0EBh, 31h, 8Bh, 56h, 0F8h, 8Bh, 46h, 0FAh
	db	2Bh, 46h, 0FEh, 1Bh, 56h, 0FCh, 83h, 0FAh, 1, 73h, 0C4h, 0A3h
	db	0EDh, 6, 8Bh, 46h, 0F6h, 0A3h, 0F1h, 6, 8Bh, 56h, 0FCh, 8Bh, 46h
	db	0FEh, 8Bh, 0Eh, 0D1h, 6, 0D1h, 0EAh, 0D1h, 0D8h, 0E2h, 0FAh, 0Bh
	db	0D2h, 75h, 66h, 0A3h, 0EBh, 6, 0BAh, 0, 0Ch, 26h, 80h, 7Dh, 1
	db	4, 75h, 3, 83h, 0CAh, 11h, 26h, 80h, 7Dh, 1, 0, 7Fh, 3, 83h, 0CAh
	db	1, 26h, 83h, 7Dh, 11h, 0, 74h, 4, 81h, 0CAh, 0, 1, 26h, 0F6h, 45h
	db	13h, 1, 74h, 3, 83h, 0CAh, 10h, 26h, 0F6h, 45h, 13h, 2, 74h, 3
	db	83h, 0CAh, 20h, 26h, 0F6h, 45h, 13h, 4, 74h, 3, 83h, 0CAh, 40h
	db	26h, 0F6h, 45h, 13h, 8, 74h, 4, 81h, 0CAh, 80h, 0, 26h, 0F6h, 45h
	db	13h, 10h, 74h, 4, 81h, 0CAh, 0, 10h, 89h, 16h, 0EFh, 6, '_ZY[X'
	db	8Bh, 0E5h, 5Dh, 0C3h, 33h, 0C0h, 50h, 0B8h, 11h, 0, 50h, 0E8h
	db	0E1h, 1Bh, 33h, 0C0h, 50h, 0B8h, 12h, 0, 50h, 0E8h, 0D7h, 1Bh
	db	0A1h, 52h, 0B4h, 3, 6, 0C1h, 6, 33h, 0DBh, 3Bh, 1Eh, 9Eh, 7, 73h
	db	23h, 8Eh, 6, 0A0h, 7, 50h, 26h, 8Bh, 47h, 0Dh, 26h, 0Bh, 47h, 0Fh
	db	58h, 74h, 0Eh, 0E8h, 9Ah, 0FEh, 0B9h, 8, 0, 0BEh, 0EBh, 6, 33h
	db	0D2h, 0E8h, 66h, 0E9h, 83h, 0C3h, 14h, 0EBh, 0D7h, 0C3h, 8Bh, 0Eh
	db	0C6h, 7, 0E3h, 15h, 1Eh, 56h, 0A1h, 52h, 0B4h, 3, 6, 0C7h, 6, 33h
	db	0D2h, 33h, 0F6h, 0BBh, 0C8h, 7, 0E8h, 0EFh, 0E8h, 5Eh, 1Fh, 0C3h
	db	33h, 0DBh, 8Bh, 0Eh, 52h, 0B4h, 3, 0Eh, 0C9h, 6, 41h, 3Bh, 1Eh
	db	0CEh, 7, 73h, 41h, 8Eh, 6, 0D0h, 7, 26h, 8Bh, 37h, 53h, 91h, 33h
	db	0D2h, 8Bh, 0DEh, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Dh, 9Fh, 18h, 7, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Eh, 84h, 18h, 7, 5Eh, 83h, 0C6h, 2, 26h, 8Ah, 0Ch, 83h
	db	0E1h, 3Fh, 26h, 88h, 0Ch, 41h, 0E8h, 0A2h, 0E8h, 3, 0C8h, 5Bh
	db	83h, 0C3h, 6, 0EBh, 0B9h, 0C3h, 'SQRVW+', 0F6h, 3Bh, 36h, 9Eh
	db	7, 73h, 46h, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 44h, 8, 26h, 8Ah, 54h
	db	0Ah, 0B6h, 0, 3, 6, 0FEh, 3, 12h, 0D6h, 0D1h, 0E0h, 0D1h, 0D2h
	db	0D1h, 0E0h, 0D1h, 0D2h, 0D1h, 0E0h, 0D1h, 0D2h, 0D1h, 0E0h, 0D1h
	db	0D2h, 26h, 3, 44h, 0Dh, 26h, 13h, 54h, 0Fh, 56h, 0B9h, 2, 0, 26h
	db	83h, 7Ch, 11h, 0, 74h, 9, 8Dh, 74h, 11h, 0BBh, 0A0h, 7, 0E8h, 4Ch
	db	0E8h, 5Eh, 83h, 0C6h, 14h, 0EBh, 0B4h, '_^ZY[', 0C3h, 0E8h, 7Fh
	db	0FDh, 0E8h, 0FFh, 0FEh, 0E8h, 12h, 12h, 0E8h, 2Ch, 0FFh, 0E8h
	db	45h, 0FFh, 0E8h, 41h, 12h, 0E8h, 24h, 12h, 0E8h, 8Fh, 0FFh, 0C3h
	db	'VW3', 0F6h, 56h, 0BBh, 0Ch, 8, 0EBh, 'YV3', 0C0h, 50h, 0B8h, 2Eh
	db	0, 50h, 0E8h, 0B3h, 1Ah, 5Eh, 0EBh, 'GSV', 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 10h, 8, 5Eh, 26h, 8Bh
	db	7Ch, 2, 26h, 8Bh, 1Ch, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h
	db	0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 26h, 0F6h, 45h, 0Eh, 20h, 74h
	db	1Ah, 0F7h, 0C3h, 1, 0, 75h, 0BFh, 8Eh, 6, 80h, 7, 26h, 8Bh, 1Fh
	db	83h, 0FBh, 0FFh, 74h, 8, 8Eh, 6, 0A0h, 7, 26h, 0FFh, 47h, 11h
	db	5Bh, 83h, 0C6h, 4, 3Bh, 77h, 2, 72h, 0B0h, 81h, 0FBh, 1Ch, 8, 77h
	db	8, 83h, 0C3h, 8, '^FV', 0EBh, 0EDh, 5Eh, 0BFh, 0Ch, 8, 0E8h, 73h
	db	0B5h, 0E8h, 85h, 0B5h, 5Fh, 5Eh, 0C3h, 4Dh, 5Ah, 0, 0, 0, 0, 0
	db	0, 4, 0, 0Fh, 0, 0FFh, 0FFh, 0, 0, 0B8h, 0, 0, 0, 0, 0, 0, 0, 40h
	db	0, 0BAh, 10h, 0, 0Eh, 1Fh, 0B4h, 9, 0CDh, 21h, 0B8h, 1, 4Ch, 0CDh
	db	21h, 90h, 90h, 'This program must be run under Microsoft Windows.'
	db	0Dh, 0Ah, 24h, 0BAh, 10h, 0, 0Eh, 1Fh, 0B4h, 9, 0CDh, 21h, 0B8h
	db	1, 4Ch, 0CDh, 21h, 90h, 90h, 'This program must be run under OS/2.'
	db	0Dh, 0Ah, 24h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0Ah, 0, 10h, 0, 19h
	db	0, 9Dh, 0AAh, 14h, 0, 70h, 0AAh, 9, 0, 0DBh, 0AAh, 0Eh, 0, 0E8h
	db	0AAh, 7, 0, 23h, 0ABh, 8, 0, 2Dh, 0ABh, 25h, 0, 94h, 0ABh, 11h
	db	0, 7Bh, 0ABh, 28h, 0, 80h, 0ABh, 0Fh, 0, 44h, 0ACh, 12h, 0, 29h
	db	0ADh, 29h, 0, 0FEh, 0AAh, 20h, 0, 0Fh, 0ABh, 23h, 0, 16h, 0ABh
	db	'<0r#<9w', 4, 2Ch, 30h, 0EBh, 16h, '<Ar', 17h, '<Fw', 4, 2Ch, 37h
	db	0EBh, 0Ah, '<ar', 0Bh, '<fw', 7, ',W2', 0E4h, 0F8h, 0EBh, 1, 0F9h
	db	0C3h, 1Eh, 8Dh, 47h, 4, 50h, 89h, 4Fh, 2, 89h, 0Fh, 51h, 9Ah, 18h
	db	15h, 0DFh, 0, 0C3h, 'SQW', 6, 33h, 0C0h, 0A3h, 0ADh, 0B4h, 0BBh
	db	60h, 0B4h, 0B9h, 2, 0, 0E8h, 0DDh, 0FFh, 0BBh, 68h, 0B4h, 0B9h
	db	2, 0, 0E8h, 0D4h, 0FFh, 0FCh, 1Eh, 7, 0E8h, 33h, 7, 0E8h, 25h
	db	7, 0B8h, 0, 0, 7, '_Y[', 0C3h, 'SVW', 1Eh, 8Bh, 3Eh, 3Ah, 1, 0C4h
	db	1Eh, 34h, 1, 26h, 8Eh, 7, 83h, 0C7h, 2, 33h, 0C0h, 0B9h, 0FFh
	db	0FFh, 0FCh, 0F2h, 0AEh, 0F7h, 0D9h, 83h, 0E9h, 2, 83h, 0EFh, 2
	db	26h, 80h, '=\t', 9, 26h, 80h, '=:t', 3, 4Fh, 0E2h, 0F1h, 47h, 8Bh
	db	0F7h, 6, 1Fh, 2Eh, 8Eh, 6, 10h, 0, 0BFh, 7Bh, 5Ch, 0ACh, 0Ah, 0C0h
	db	74h, 3, 0AAh, 0EBh, 0F8h, 1Fh, 8Bh, 0C7h, 0BBh, '{\+', 0C3h, 4Bh
	db	88h, 7, 0E8h, 0Bh, 7, 89h, 1Eh, 0A8h, 0B4h, 8Bh, 0C3h, '_^[', 0C3h
	db	'SQVW', 8Bh, 36h, 0A8h, 0B4h, 0Bh, 0F6h, 75h, 5, 0E8h, 93h, 0FFh
	db	8Bh, 0F0h, 1Eh, 1Eh, 7, 0BFh, 7Bh, 5Ch, 8Eh, 1Eh, 6Ch, 0B4h, 33h
	db	0C0h, 0ACh, 8Bh, 0C8h, 0E3h, 8, 0ACh, '<.t', 3, 0AAh, 0E2h, 0F8h
	db	1Fh, 8Bh, 0C7h, 0BBh, '{\+', 0C3h, 4Bh, 88h, 7, 0E8h, 0C9h, 6
	db	8Bh, 0C3h, '_^Y[', 0C3h, 83h, 3Eh, 9Ch, 0B4h, 0, 75h, 6, 0E8h
	db	59h, 0FFh, 0A3h, 9Ch, 0B4h, 83h, 3Eh, 8Ch, 0B4h, 0, 75h, 6, 0E8h
	db	0AAh, 0FFh, 0A3h, 8Ch, 0B4h, 80h, 3Eh, 19h, 0, 0, 74h, 10h, 0B0h
	db	2, 80h, 3Eh, 2Ah, 1, 2, 74h, 2, 0B0h, 1, 0A2h, 0AAh, 0B4h, 0EBh
	db	13h, 80h, 3Eh, 0AAh, 0B4h, 2, 74h, 7, 0C6h, 6, 2Ah, 1, 3, 0EBh
	db	5, 0C6h, 6, 2Ah, 1, 2, 80h, 3Eh, 8Ah, 0B4h, 0, 75h, 1Eh, 80h, 3Eh
	db	2Bh, 1, 3, 74h, 7, 0C6h, 6, 8Ah, 0B4h, 1, 0EBh, 10h, 83h, 26h
	db	50h, 0B4h, 0FDh, 81h, 0Eh, 50h, 0B4h, 0, 80h, 83h, 0Eh, 92h, 0B4h
	db	2, 0C3h, 6, 57h, 1Eh, 7, 0E8h, 0BAh, 1, 3Ch, 3, 74h, 9, 3Ch, 2
	db	75h, 0Ah, 0E8h, 0A8h, 5, 73h, 5, 50h, 0E8h, 40h, 6, 58h, 5Fh, 7
	db	0C3h, 'PQW', 6, 33h, 0C0h, 0ACh, 8Bh, 0C8h, 0E3h, 17h, 1Eh, 7
	db	0BFh, 0FAh, 5Ch, 0AAh, 0ACh, '<ar', 6, '<zw', 2, 2Ch, 20h, 0AAh
	db	0E2h, 0F2h, 0BEh, 0FAh, 5Ch, 7, '_YX', 0C3h, 55h, 8Bh, 0ECh, 83h
	db	0ECh, 0Ah, 1Eh, 56h, 57h, 0C7h, 46h, 0FEh, 0, 0, 0C7h, 46h, 0FCh
	db	0, 0, 0C6h, 46h, 0F8h, 0, 89h, 26h, 0B1h, 0B4h, 89h, 1Eh, 84h
	db	0B4h, 33h, 0C0h, 0A3h, 0ABh, 0B4h, 0A3h, 0AFh, 0B4h, 0E8h, 93h
	db	0FFh, 1Eh, 7, 3Ch, 0, 't,<', 1, 74h, 0F3h, 3Ch, 6, 72h, 17h, 6
	db	0Eh, 7, 0BFh, 4, 0A2h, 0B9h, 0Eh, 0, 0AFh, 74h, 7, 47h, 47h, 0E2h
	db	0F9h, 7, 0EBh, 4, 7, 2Eh, 0FFh, 25h, 0B8h, 0Dh, 0, 8Bh, 0Eh, 0B3h
	db	0B4h, 8Bh, 26h, 0B1h, 0B4h, 0EBh, 58h, 0BBh, 8Ah, 0B4h, 80h, 3Fh
	db	0, 74h, 2, 0FEh, 0Fh, 8Bh, 46h, 0FEh, 0A3h, 0A4h, 0B4h, 2Bh, 46h
	db	0FCh, 0A3h, 0A6h, 0B4h, 33h, 0C0h, 0F7h, 6, 94h, 0B4h, 10h, 0
	db	75h, 0Fh, 0BEh, 2, 0, 80h, 3Eh, 8Ah, 0B4h, 1, 74h, 3, 0BEh, 1
	db	0, 0Bh, 0C6h, 0F7h, 6, 92h, 0B4h, 20h, 0, 74h, 5, 0Dh, 2, 0, 0EBh
	db	0Bh, 0F7h, 6, 92h, 0B4h, 10h, 0, 74h, 3, 0Dh, 1, 0, 0A3h, 50h
	db	0B4h, 8Ah, 46h, 0F8h, 3Ch, 0, 75h, 2, 0B0h, 1, 0A2h, 0AAh, 0B4h
	db	33h, 0C0h, 5Fh, 5Eh, 1Fh, 8Bh, 0E5h, 5Dh, 0C3h, 0BAh, 7Ah, 54h
	db	0B9h, 0, 8, 8Bh, 1Eh, 84h, 0B4h, 0B4h, 3Fh, 0E8h, 0FCh, 5Dh, 3Dh
	db	0FFh, 0FFh, 74h, 17h, 0BEh, 7Ah, 54h, 0Bh, 0C0h, 75h, 6, 0B8h
	db	1, 0, 0C6h, 4, 1Ah, 89h, 36h, 86h, 0B4h, 3, 0C6h, 0A3h, 88h, 0B4h
	db	0C3h, 0B8h, 0Eh, 0, 0E9h, 66h, 0FFh, 8Dh, 0A5h, 0A4h, 0A5h, 90h
	db	0A5h, 98h, 0A5h, 0E3h, 0A5h, 77h, 0A6h, 0A6h, 0A5h, 0B5h, 0A6h
	db	0CFh, 0A5h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 6, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 2, 0Ch, 0Eh, 0Ch
	db	0Ah, 0Ch, 0Ch, 0Eh, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 8
	db	8, 8, 8, 8, 8, 8, 8, 8, 8, 0Ch, 10h, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ah
	db	0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah
	db	0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ch
	db	0Ch, 0Ch, 0Ch, 0Ah, 0Ch, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah
	db	0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ah
	db	0Ah, 0Ah, 0Ah, 0Ah, 0Ah, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 8Bh, 36h, 86h
	db	0B4h, 3Bh, 36h, 88h, 0B4h, 72h, 3, 0E8h, 30h, 0FFh, 0ACh, 32h
	db	0E4h, 8Bh, 0D8h, 79h, 3, 0E9h, 0BAh, 0FEh, 2Eh, 8Ah, 9Fh, 0EAh
	db	0A4h, 32h, 0FFh, 2Eh, 0FFh, 0A7h, 0D8h, 0A4h, 0E9h, 0ABh, 0FEh
	db	0B8h, 0, 0, 89h, 36h, 86h, 0B4h, 0C3h, 0FFh, 6, 0B3h, 0B4h, 0B8h
	db	1, 0, 89h, 36h, 86h, 0B4h, 0C3h, 0EBh, 0C8h, '<@t', 9, 8Ah, 0E0h
	db	0B0h, 5, 89h, 36h, 86h, 0B4h, 0C3h, 'P;6', 88h, 0B4h, 72h, 3, 0E8h
	db	0EAh, 0FEh, 0ACh, 32h, 0E4h, 8Bh, 0F8h, 'NX.', 80h, 0BDh, 0EAh
	db	0A4h, 0Ah, 75h, 0DEh, 0E9h, 0A8h, 0, 3Bh, 36h, 88h, 0B4h, 72h
	db	3, 0E8h, 0CFh, 0FEh, 0ACh, 3Ch, 0Ah, 74h, 0BBh, 3Ch, 1Ah, 74h
	db	0B7h, 0EBh, 0ECh, 33h, 0DBh, '<0u!S;6', 88h, 0B4h, 72h, 3, 0E8h
	db	0B4h, 0FEh, 0ACh, '[<xtE<XtA2', 0E4h, 8Bh, 0F8h, 2Eh, 80h, 0BDh
	db	0EAh, 0A4h, 8, 'u*N3', 0DBh, 25h, 0Fh, 0, 93h, 2Eh, 0F7h, 26h
	db	0, 0A2h, 72h, 24h, 3, 0D8h, 'r S;6', 88h, 0B4h, 72h, 3, 0E8h, 82h
	db	0FEh, 0ACh, 5Bh, 32h, 0E4h, 8Bh, 0F8h, 2Eh, 80h, 0BDh, 0EAh, 0A4h
	db	8, 74h, 0D9h, 4Eh, 0B0h, 4, 89h, 36h, 86h, 0B4h, 0C3h, 0E9h, 0FDh
	db	0FDh, 3Bh, 36h, 88h, 0B4h, 72h, 3, 0E8h, 60h, 0FEh, 0ACh, 0E8h
	db	0F1h, 0FBh, 72h, 27h, 33h, 0DBh, 93h, 2Eh, 0F7h, 26h, 2, 0A2h
	db	72h, 1Dh, 3, 0D8h, 72h, 19h, 'S;6', 88h, 0B4h, 72h, 3, 0E8h, 42h
	db	0FEh, 0ACh, 5Bh, 0E8h, 0D2h, 0FBh, 73h, 0E3h, 4Eh, 0B0h, 4, 89h
	db	36h, 86h, 0B4h, 0C3h, 0E9h, 0C4h, 0FDh, 0BFh, 7Bh, 5Ch, 81h, 0FFh
	db	0FAh, 5Ch, 73h, 0F4h, 0AAh, 3Bh, 36h, 88h, 0B4h, 72h, 3, 0E8h
	db	1Dh, 0FEh, 0ACh, 32h, 0E4h, 8Bh, 0D8h, 2Eh, 80h, 0BFh, 0EAh, 0A4h
	db	0Ah, 74h, 0E3h, 2Eh, 80h, 0BFh, 0EAh, 0A4h, 8, 74h, 0DBh, '<@t'
	db	0D7h, 0BBh, 'z\+', 0FBh, 4Fh, 8Bh, 0C7h, 88h, 7, 4Eh, 89h, 36h
	db	86h, 0B4h, 0B0h, 2, 0C3h, 0BFh, '{\;6', 88h, 0B4h, 72h, 3, 0E8h
	db	0E6h, 0FDh, 0ACh, 0EBh, 11h, 81h, 0FFh, 0FAh, 5Ch, 73h, 27h, 0AAh
	db	3Bh, 36h, 88h, 0B4h, 72h, 3, 0E8h, 0D3h, 0FDh, 0ACh, 3Ch, 27h
	db	74h, 1Bh, '<"t', 17h, 32h, 0E4h, 8Bh, 0D8h, 2Eh, 80h, 0BFh, 0EAh
	db	0A4h, 4, 74h, 8, 2Eh, 80h, 0BFh, 0EAh, 0A4h, 6, 75h, 0D3h, 0E9h
	db	47h, 0FDh, 46h, 0BBh, 'z\+', 0FBh, 4Fh, 8Bh, 0C7h, 88h, 7, 4Eh
	db	89h, 36h, 86h, 0B4h, 0B0h, 3, 0C3h, 2Fh, 0A8h, 0, 0, 0, 0, 0, 0
	db	35h, 0A8h, 0, 0, 0, 0, 0, 0, 3Ah, 0A8h, 0, 0, 0, 0, 0, 0, 3Fh
	db	0A8h, 0, 0, 0, 0, 0, 0, 4Bh, 0A8h, 7, 0, 0, 1, 0, 1, 57h, 0A8h
	db	8, 0, 1, 0, 3, 0, 5Ch, 0A8h, 5, 0, 4, 0, 0, 0, 68h, 0A8h, 5, 0
	db	4, 0, 4, 0, 74h, 0A8h, 0, 0, 0, 0, 0, 0, 7Ch, 0A8h, 0, 0, 0, 0
	db	0, 0, 84h, 0A8h, 7, 0, 80h, 0, 0, 0, 8Ah, 0A8h, 0, 0, 0, 0, 0
	db	0, 93h, 0A8h, 0, 0, 0, 0, 0, 0, 9Bh, 0A8h, 4, 0, 8, 0, 8, 0, 0A0h
	db	0A8h, 0, 0, 0, 0, 0, 0, 0A8h, 0A8h, 7, 0, 1, 0, 0, 0, 0B3h, 0A8h
	db	7, 0, 80h, 0, 80h, 0, 0BBh, 0A8h, 7, 0, 80h, 0, 80h, 0, 0C4h, 0A8h
	db	2, 0, 30h, 0, 30h, 0, 0CDh, 0A8h, 0, 0, 0, 0, 0, 0, 0D2h, 0A8h
	db	0, 0, 0, 0, 0, 0, 0D9h, 0A8h, 7, 0, 0, 1, 0, 0, 0E8h, 0A8h, 2
	db	0, 30h, 0, 0, 0, 0EDh, 0A8h, 7, 0, 2, 0, 0, 0, 0F7h, 0A8h, 8, 0
	db	1, 0, 1, 0, 0FBh, 0A8h, 7, 0, 1, 0, 1, 0, 3, 0A9h, 0, 0, 0, 0
	db	0, 0, 0Ch, 0A9h, 6, 0, 40h, 0, 0, 0, 15h, 0A9h, 6, 0, 40h, 0, 40h
	db	0, 1Fh, 0A9h, 0, 0, 0, 0, 0, 0, 28h, 0A9h, 0, 0, 0, 0, 0, 0, 35h
	db	0A9h, 0, 0, 0, 0, 0, 0, 3Eh, 0A9h, 7, 0, 2, 0, 2, 0, 45h, 0A9h
	db	2, 0, 30h, 0, 10h, 0, 4Ch, 0A9h, 0, 0, 0, 0, 0, 0, 56h, 0A9h, 0
	db	0, 0, 0, 0, 0, 5Bh, 0A9h, 8, 0, 1, 0, 2, 0, 5, 'CLASS', 4, 'CODE'
	db	4, 'DATA', 0Bh, 'DESCRIPTION', 0Bh, 'DISCARDABLE', 4, 'DOS4', 0Bh
	db	'EXECUTEONLY', 0Bh, 'EXECUTEREAD', 7, 'EXETYPE', 7, 'EXPORTS'
	db	5, 'FIXED', 8, 'HEAPSIZE', 7, 'IMPORTS', 4, 'IOPL', 7, 'LIBRARY'
	db	0Ah, 'LOADONCALL', 7, 'MOVABLE', 8, 'MOVEABLE', 8, 'MULTIPLE'
	db	4, 'NAME', 6, 'NODATA', 0Eh, 'NONDISCARDABLE', 4, 'NONE', 9, 'NONSHARED'
	db	3, 'OS2', 7, 'PRELOAD', 8, 'PROTMODE', 8, 'READONLY', 9, 'READWRITE'
	db	8, 'REALMODE', 0Ch, 'RESIDENTNAME', 8, 'SEGMENTS', 6, 'SHARED'
	db	6, 'SINGLE', 9, 'STACKSIZE', 4, 'STUB', 7, 'WINDOWSP', 8Bh, 0D3h
	db	8Ah, 7, 32h, 0E4h, 0Eh, 7, 0BBh, 7, 0A7h, 0B9h, 25h, 0, 26h, 8Bh
	db	'?&:', 5, 74h, 1Dh, 83h, 0C3h, 8, 0E2h, 0F3h, 8Bh, 0DAh, 58h, 1Eh
	db	7, 0F9h, 0C3h, 8Bh, 0F2h, 0E8h, 3Ah, 0FAh, 'F_Q', 8Bh, 0C8h, 0F3h
	db	0A6h, 59h, 75h, 0E5h, 0EBh, 10h, 'GWQ', 8Bh, 0F2h, 46h, 8Bh, 0C8h
	db	0F3h, 0A6h, 59h, 75h, 0E2h, 83h, 0C4h, 2, 83h, 0C4h, 2, 8Dh, 47h
	db	2, 81h, 0EBh, 7, 0A7h, 0D1h, 0EBh, 0D1h, 0EBh, 0D1h, 0EBh, 83h
	db	0C3h, 6, 93h, 1Eh, 7, 0F8h, 0C3h, 0BFh, 7Ah, 52h, 0B9h, 0, 1, 33h
	db	0C0h, 0F3h, 0ABh, 0C3h, 89h, 1Eh, 86h, 0B4h, 89h, 1Eh, 88h, 0B4h
	db	0C7h, 6, 0B3h, 0B4h, 1, 0, 0C3h, 8Bh, 0D1h, 83h, 0C2h, 3, 8Bh
	db	0FAh, 57h, 0BFh, 68h, 0B4h, 0E8h, 0D6h, 0AAh, 73h, 3, 0E8h, 0C4h
	db	0AAh, 33h, 0C0h, 0ABh, 8Bh, 0F3h, 8Bh, 0DFh, 8Ah, 0C1h, 0AAh, 0D1h
	db	0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 1Eh, 7, 0C3h, 8Ah, 7
	db	32h, 0E4h, 43h, 50h, 8Bh, 0C8h, 8Bh, 0F3h, 33h, 0D2h, 0E3h, 0Dh
	db	0ACh, 32h, 0D0h, 3, 0D1h, 0D1h, 0C2h, 0D1h, 0C2h, 0D1h, 0C2h, 0E2h
	db	0F3h, 59h, 81h, 0E2h, 0FEh, 1, 8Bh, 0F2h, 81h, 0C6h, 7Ah, 52h
	db	8Bh, 14h, 23h, 0D2h, 75h, 8, 56h, 0E8h, 0A8h, 0FFh, 5Eh, 89h, 1Ch
	db	0C3h, 87h, 0DAh, 8Eh, 6, 6Ch, 0B4h, 26h, 3Ah, 0Fh, 74h, 0Ch, 26h
	db	8Bh, 47h, 0FEh, 23h, 0C0h, 74h, 18h, 8Bh, 0D8h, 0EBh, 0EFh, 8Dh
	db	7Fh, 1, 8Bh, 0F2h, 8Bh, 0C1h, 0F3h, 0A6h, 8Bh, 0C8h, 26h, 8Bh
	db	47h, 0FEh, 75h, 0E7h, 1Eh, 7, 0C3h, 6, 53h, 8Bh, 0DAh, 0E8h, 72h
	db	0FFh, 5Eh, 7, 26h, 89h, 5Ch, 0FEh, 1Eh, 7, 0C3h, 80h, 3Eh, 8Ah
	db	0B4h, 0, 75h, 61h, 80h, 3Eh, 2Bh, 1, 2, 74h, 3Eh, 0C6h, 6, 8Ah
	db	0B4h, 1, 80h, 3Eh, 2Bh, 1, 0, 75h, 32h, 0C6h, 6, 2Bh, 1, 3, 50h
	db	53h, 0B8h, 64h, 6Ch, 0B3h, 6Ch, 0E8h, 9Ch, 0E8h, 5Bh, 58h, 0EBh
	db	1Fh, 80h, 3Eh, 8Ah, 0B4h, 0, 75h, 34h, 80h, 3Eh, 2Bh, 1, 3, 74h
	db	11h, 0C6h, 6, 8Ah, 0B4h, 2, 80h, 3Eh, 2Bh, 1, 0, 74h, 5, 0C6h
	db	6, 2Bh, 1, 2, 0E8h, 0EAh, 0F8h, 3Ch, 2, 75h, 7, 89h, 1Eh, 8Ch
	db	0B4h, 0E8h, 0DFh, 0F8h, 3Ch, 0, 74h, 7, 3Ch, 1, 75h, 6, 0E9h, 3Eh
	db	0F9h, 0E9h, 3Eh, 0F9h, 0E9h, 60h, 0F9h, 0E8h, 0CBh, 0F8h, 3Ch
	db	3, 75h, 0F6h, 89h, 1Eh, 9Ch, 0B4h, 0EBh, 0DFh, 0E8h, 0BEh, 0F8h
	db	3Ch, 6, 72h, 0E9h, 2Eh, 0F6h, 7, 8, 74h, 0E3h, 2Eh, 8Bh, 47h, 4
	db	88h, 46h, 0F8h, 0EBh, 0C9h, 0E8h, 0A8h, 0F8h, 3Ch, 2, 74h, 4, 3Ch
	db	3, 75h, 0CFh, 89h, 1Eh, 9Ah, 0B4h, 0EBh, 0B8h, 0C6h, 6, 8Bh, 0B4h
	db	1, 0EBh, 0B1h, 0C6h, 6, 8Bh, 0B4h, 0, 0EBh, 0AAh, 0B8h, 10h, 0
	db	0E9h, 1Bh, 0F9h, 0B1h, 1, 0BFh, 8Eh, 0B4h, 0BEh, 90h, 0B4h, 0EBh
	db	8, 0B1h, 2, 0BFh, 92h, 0B4h, 0BEh, 94h, 0B4h, 33h, 0D2h, 89h, 56h
	db	0FAh, 'WQRV', 0E8h, 68h, 0F8h, '^ZY_<', 0, 't$<', 1, 't <', 6
	db	72h, 87h, 2Eh, 84h, 0Fh, 74h, 82h, 2Eh, 8Bh, 47h, 2, 85h, 4, 75h
	db	0BFh, 9, 4, 0F7h, 0D0h, 23h, 0D0h, 2Eh, 0Bh, 57h, 4, 0FFh, 46h
	db	0FAh, 0EBh, 0CDh, 83h, 7Eh, 0FAh, 0, 75h, 3, 0E9h, 62h, 0FFh, 89h
	db	15h, 0E9h, 98h, 0F8h, 0BFh, 96h, 0B4h, 0EBh, 3, 0BFh, 98h, 0B4h
	db	57h, 0E8h, 22h, 0F8h, 5Fh, 3Ch, 4, 75h, 45h, 89h, 1Dh, 0E9h, 36h
	db	0FFh, 0E9h, 82h, 0F8h, 0E8h, 12h, 0F8h, 3Ch, 0, 74h, 0F6h, 3Ch
	db	1, 74h, 0F5h, 3Ch, 6, 73h, 0EEh, 3Ch, 2, 74h, 4, 3Ch, 3, 75h, 26h
	db	0BFh, 0Ch, 0, 57h, 0BFh, 60h, 0B4h, 0E8h, 8, 0A9h, 73h, 3, 0E8h
	db	0F6h, 0A8h, 57h, 0B9h, 6, 0, 33h, 0C0h, 0F3h, 0ABh, 5Fh, 8Bh, 36h
	db	0ABh, 0B4h, 23h, 0F6h, 75h, 9, 89h, 3Eh, 9Eh, 0B4h, 0EBh, 6, 0E9h
	db	67h, 0F8h, 26h, 89h, 3Ch, 89h, 3Eh, 0ABh, 0B4h, 26h, 89h, 5Dh
	db	2, 0E8h, 0C7h, 0F7h, 3Ch, 6, 75h, 0Eh, 0E8h, 0C0h, 0F7h, 3Ch, 3
	db	75h, 0E4h, 26h, 89h, 5Dh, 4, 0E8h, 0B5h, 0F7h, 3Ch, 4, 75h, 7
	db	26h, 89h, 5Dh, 6, 0E8h, 0AAh, 0F7h, 33h, 0C9h, 33h, 0D2h, 3Ch
	db	0, 't,<', 1, 't(<', 6, 72h, 0C2h, 2Eh, 0F6h, 7, 4, 74h, 0BCh, 2Eh
	db	8Bh, 47h, 2, 85h, 0C8h, 74h, 3, 0E9h, 0FDh, 0FEh, 0Bh, 0C8h, 0F7h
	db	0D0h, 23h, 0D0h, 2Eh, 0Bh, 57h, 4, 51h, 52h, 0E8h, 7Ah, 0F7h, 5Ah
	db	59h, 0EBh, 0D0h, 26h, 89h, 4Dh, 8, 26h, 89h, 55h, 0Ah, 0E9h, 56h
	db	0FFh, 0E9h, 0D5h, 0F7h, 0E9h, 0F7h, 0F7h, 0E8h, 62h, 0F7h, 3Ch
	db	0, 74h, 0F3h, 3Ch, 1, 74h, 0F5h, 3Ch, 6, 73h, 0EBh, 3Ch, 2, 75h
	db	0EAh, 0B9h, 0Ah, 0, 33h, 0C0h, 1Eh, 7, 57h, 0BFh, 70h, 0B4h, 0F3h
	db	0AAh, 5Fh, 89h, 1Eh, 72h, 0B4h, 0E8h, 3Dh, 0F7h, 3Ch, 5, 75h, 13h
	db	80h, 0FCh, 3Dh, 75h, 12h, 0E8h, 31h, 0F7h, 3Ch, 2, 75h, 0C5h, 89h
	db	1Eh, 74h, 0B4h, 0E8h, 26h, 0F7h, 3Ch, 5, 75h, 1Bh, 80h, 0FCh, 40h
	db	75h, 0B5h, 0E8h, 1Ah, 0F7h, 3Ch, 4, 75h, 0AEh, 0FFh, 46h, 0FCh
	db	89h, 1Eh, 76h, 0B4h, 80h, 0Eh, 78h, 0B4h, 8, 0E8h, 7, 0F7h, '<$u'
	db	8, 80h, 0Eh, 78h, 0B4h, 1, 0E8h, 0FBh, 0F6h, 3Ch, 1Ah, 75h, 8
	db	80h, 0Eh, 78h, 0B4h, 2, 0E8h, 0EFh, 0F6h, 3Ch, 4, 75h, 12h, 81h
	db	0FBh, 0, 1, 77h, 5Fh, 88h, 1Eh, 79h, 0B4h, 80h, 0Eh, 78h, 0B4h
	db	4, 0E8h, 0D9h, 0F6h, 50h, 83h, 3Eh, 74h, 0B4h, 0, 75h, 6, 0A1h
	db	72h, 0B4h, 0A3h, 74h, 0B4h, 0E8h, 0F7h, 0Bh, 0Bh, 0C0h, 75h, 39h
	db	0FFh, 46h, 0FEh, 51h, 56h, 0BFh, 0Ah, 0, 57h, 0BFh, 60h, 0B4h
	db	0E8h, 0C9h, 0A7h, 73h, 3, 0E8h, 0B7h, 0A7h, 57h, 0B9h, 5, 0, 0BEh
	db	70h, 0B4h, 0F3h, 0A5h, 5Fh, 8Bh, 36h, 0ADh, 0B4h, 23h, 0F6h, 75h
	db	6, 89h, 3Eh, 0A0h, 0B4h, 0EBh, 3, 26h, 89h, 3Ch, 89h, 3Eh, 0ADh
	db	0B4h, '^YX', 0E9h, 29h, 0FFh, 0E8h, 0C9h, 0, 0EBh, 0F7h, 0E9h
	db	15h, 0F7h, 0E9h, 0EDh, 0F6h, 0E8h, 7Dh, 0F6h, 3Ch, 0, 74h, 0F6h
	db	3Ch, 1, 74h, 0F5h, 3Ch, 6, 73h, 0EEh, 3Ch, 2, 74h, 3, 0E9h, 90h
	db	0, 0B9h, 0Ah, 0, 33h, 0C0h, 1Eh, 7, 57h, 0BFh, 7Ah, 0B4h, 0F3h
	db	0AAh, 5Fh, 53h, 0E8h, 58h, 0F6h, 5Ah, 3Ch, 5, 75h, 15h, 80h, 0FCh
	db	3Dh, 75h, 10h, 89h, 16h, 7Ch, 0B4h, 0E8h, 47h, 0F6h, 3Ch, 2, 'uiS'
	db	0E8h, 3Fh, 0F6h, 5Ah, 89h, 16h, 7Eh, 0B4h, 3Ch, 5, 75h, 5Ch, 80h
	db	0FCh, '.uW', 0E8h, 2Eh, 0F6h, 3Ch, 4, 74h, 0Ah, 3Ch, 2, 75h, 4Ch
	db	89h, 1Eh, 80h, 0B4h, 0EBh, 0Bh, 83h, 3Eh, 7Ch, 0B4h, 0, 74h, 4Fh
	db	89h, 1Eh, 82h, 0B4h, 83h, 3Eh, 7Ch, 0B4h, 0, 75h, 6, 0A1h, 80h
	db	0B4h, 0A3h, 7Ch, 0B4h, 0E8h, 66h, 0Bh, 0Bh, 0C0h, 75h, 3Dh, 0BFh
	db	0Ah, 0, 57h, 0BFh, 60h, 0B4h, 0E8h, 0Bh, 0A7h, 73h, 3, 0E8h, 0F9h
	db	0A6h, 57h, 0BEh, 7Ah, 0B4h, 0B9h, 5, 0, 0F3h, 0A5h, 5Fh, 8Bh, 36h
	db	0AFh, 0B4h, 23h, 0F6h, 75h, 9, 89h, 3Eh, 0A2h, 0B4h, 0EBh, 6, 0E9h
	db	69h, 0F6h, 26h, 89h, 3Ch, 89h, 3Eh, 0AFh, 0B4h, 0E8h, 0CDh, 0F5h
	db	0E9h, 4Ah, 0FFh, 0B8h, 0Fh, 0, 0E9h, 59h, 0F6h, 0E8h, 2, 0, 0EBh
	db	0EFh, 53h, 56h, 0FFh, 36h, 0B3h, 0B4h, 8Bh, 36h, 40h, 1, 83h, 0C6h
	db	2, 0C5h, 1Eh, 34h, 1, 8Eh, 1Fh, 1Eh, 56h, 2Eh, 8Eh, 1Eh, 10h, 0
	db	8Bh, 0D8h, 0B8h, 6, 0, 50h, 8Bh, 0C3h, 50h, 0E8h, 9Bh, 0Dh, 5Eh
	db	5Bh, 0C3h, 6, 56h, 57h, 0BFh, 0DCh, 7, 0E8h, 0BAh, 0A7h, 8Bh, 36h
	db	8Ch, 0B4h, 33h, 0C9h, 'SR3', 0D2h, 33h, 0DBh, 0E8h, 21h, 4, 5Ah
	db	5Bh, 8Bh, 1Eh, 0A0h, 0B4h, 0EBh, 30h, 26h, 8Bh, 1Fh, 0EBh, 2Bh
	db	8Eh, 6, 64h, 0B4h, 26h, 8Bh, 77h, 2, 26h, 8Bh, 4Fh, 6, 83h, 0F9h
	db	0FFh, 74h, 0EAh, 26h, 8Ah, 47h, 8, 0A8h, 1, 75h, 4, 0A8h, 8, 75h
	db	0DEh, 26h, 8Bh, 1Fh, 'SR3', 0D2h, 8Bh, 0D8h, 0E8h, 0EBh, 3, 5Ah
	db	5Bh, 0Bh, 0DBh, 75h, 0D1h, 0BFh, 1, 0, 57h, 0BFh, 0DCh, 7, 0E8h
	db	4Ch, 0A6h, 73h, 3, 0E8h, 3Ah, 0A6h, 26h, 0C6h, 5, 0, 8Bh, 0Eh
	db	0DEh, 7, 5Fh, 5Eh, 7, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 14h, 57h
	db	56h, 6, 'SQR', 0C6h, 46h, 0ECh, 0FFh, 0BFh, 0D4h, 7, 0E8h, 3Eh
	db	0A7h, 83h, 3Eh, 0F8h, 7, 0FFh, 75h, 8, 0BFh, 0F4h, 7, 0E8h, 31h
	db	0A7h, 0EBh, 6, 0C7h, 6, 0F6h, 7, 0, 0, 8Bh, 36h, 0A0h, 0B4h, 8Eh
	db	6, 64h, 0B4h, 0EBh, 20h, 26h, 83h, 7Ch, 6, 0FFh, 74h, 12h, 0BFh
	db	2, 0, 57h, 0BFh, 0F4h, 7, 0E8h, 0F5h, 0A5h, 73h, 3, 0E8h, 0E3h
	db	0A5h, 26h, 89h, 35h, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 34h, 0Bh, 0F6h
	db	75h, 0DCh, 55h, 0BDh, 0E9h, 0B5h, 8Bh, 0Eh, 0F6h, 7, 8Eh, 6, 0F8h
	db	7, 0E8h, 73h, 0E0h, 5Dh, 33h, 0FFh, 89h, 7Eh, 0FCh, 0C7h, 46h
	db	0F0h, 1, 0, 0E9h, 0D0h, 0, 0B8h, 7, 0, 0E8h, 2Bh, 0E4h, 26h, 0FFh
	db	75h, 6, 0E8h, 0C1h, 6, 0E9h, 0B7h, 0, 0C7h, 46h, 0F2h, 1, 0, 8Eh
	db	6, 0F8h, 7, 26h, 8Bh, 3Dh, 8Eh, 6, 64h, 0B4h, 26h, 83h, 7Dh, 6
	db	0FFh, 75h, 3, 0E9h, 0AFh, 0, 80h, 3Eh, 2Bh, 1, 3, 75h, 0Bh, 26h
	db	0F6h, 45h, 8, 2, 75h, 4, 83h, 4Eh, 0F2h, 2, 26h, 8Bh, 5Dh, 4, 26h
	db	8Bh, 4Dh, 6, 26h, 8Ah, 55h, 8, 2Bh, 4Eh, 0F0h, 72h, 0B9h, 74h
	db	3, 0E8h, 63h, 2, 0F6h, 0C2h, 80h, 74h, 67h, 83h, 0FBh, 0FFh, 'thS'
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h
	db	7, 5Bh, 26h, 8Bh, 4Fh, 4, 89h, 4Eh, 0F8h, 26h, 8Bh, 1Fh, 83h, 0FBh
	db	0FFh, 74h, 86h, 8Eh, 6, 78h, 7, 26h, 80h, 7Fh, 9, 0FFh, 'tB&'
	db	8Bh, 17h, 8Eh, 6, 80h, 7, 26h, 8Bh, 3Fh, 8Eh, 6, 0A0h, 7, 26h
	db	8Bh, 4Dh, 6, 89h, 4Eh, 0F6h, 0C6h, 46h, 0EEh, 0, 26h, 0F6h, 45h
	db	13h, 1, 74h, 3, 0FEh, 46h, 0EEh, 0E8h, 45h, 1, 73h, 3, 0E8h, 6Ch
	db	1, 8Bh, 46h, 0F2h, 80h, 7Eh, 0EEh, 0, 74h, 8, 0E8h, 0C0h, 1, 0EBh
	db	6, 0E9h, 1Ah, 2, 0E8h, 92h, 1, 0FFh, 46h, 0F0h, 8Bh, 7Eh, 0FCh
	db	83h, 0C7h, 2, 89h, 7Eh, 0FCh, 3Bh, 3Eh, 0F6h, 7, 73h, 3, 0E9h
	db	37h, 0FFh, 0C7h, 6, 0F6h, 7, 0, 0, 80h, 3Eh, 8Bh, 0B4h, 1, 75h
	db	3, 0E9h, 0DBh, 0, 'SV3', 0FFh, 57h, 0BBh, 54h, 7, 57h, 83h, 0E7h
	db	3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 0EBh
	db	'uSW', 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h
	db	58h, 7, 5Fh, 26h, 0F6h, 45h, 0Eh, 0A2h, 'uY&', 8Bh, 45h, 4, 89h
	db	46h, 0F8h, 26h, 8Bh, 5, 89h, 46h, 0F4h, 26h, 8Bh, 5Dh, 2, 83h
	db	0FBh, 0FFh, 'tCS', 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 38h, 7, 5Bh, 26h, 83h, 7Fh, 0Ah, 2, 72h, 2Dh, 8Bh
	db	5Eh, 0F4h, 8Eh, 6, 80h, 7, 26h, 8Bh, 37h, 8Eh, 6, 0A0h, 7, 26h
	db	8Bh, 44h, 6, 89h, 46h, 0F6h, 26h, 0F6h, 44h, 13h, 1, 74h, 11h
	db	0C6h, 46h, 0EEh, 1, 0E8h, 88h, 0, 73h, 3, 0E8h, 0AFh, 0, 33h, 0C0h
	db	0E8h, 0Ah, 1, 3, 3Eh, 90h, 4, 5Bh, 3Bh, 7Fh, 2, 73h, 2, 0EBh, 84h
	db	81h, 0FBh, 64h, 7, 77h, 9, 83h, 0C3h, 8, '_GW', 0E9h, 64h, 0FFh
	db	'^[3', 0FFh, 0EBh, 2Bh, 8Eh, 6, 0A0h, 7, 26h, 0F6h, 45h, 13h, 1
	db	74h, 1Dh, 26h, 8Bh, 45h, 6, 89h, 46h, 0F6h, 0C7h, 46h, 0F8h, 0
	db	0, 0C6h, 46h, 0EEh, 1, 0E8h, 3Fh, 0, 73h, 3, 0E8h, 66h, 0, 32h
	db	0C0h, 0E8h, 0C1h, 0, 83h, 0C7h, 14h, 3Bh, 3Eh, 9Eh, 7, 72h, 0CFh
	db	0BFh, 2, 0, 57h, 0BFh, 0D4h, 7, 0E8h, 0F7h, 0A3h, 73h, 3, 0E8h
	db	0E5h, 0A3h, 26h, 0C7h, 5, 0, 0, 0A1h, 0D6h, 7, 'ZY[', 7, 5Eh, 5Fh
	db	8Bh, 0E5h, 5Dh, 0C3h, 32h, 0C0h, 81h, 0E6h, 80h, 0, 74h, 2, 0FEh
	db	0C0h, 0C3h, 57h, 8Ah, 46h, 0ECh, 3Ch, 0FFh, 74h, 1Eh, 8Bh, 7Eh
	db	0FEh, 8Eh, 6, 0D8h, 7, 26h, 80h, 3Dh, 0FFh, 74h, 11h, 3Ah, 46h
	db	0EEh, 75h, 0Ch, 0Ah, 0C0h, 75h, 0Bh, 8Bh, 46h, 0F6h, 3Bh, 46h
	db	0FAh, 74h, 3, 0F9h, 0EBh, 1, 0F8h, 5Fh, 0C3h, 57h, 50h, 8Ah, 46h
	db	0ECh, 3Ch, 0FFh, 75h, 0, 0BFh, 2, 0, 57h, 0BFh, 0D4h, 7, 0E8h
	db	96h, 0A3h, 73h, 3, 0E8h, 84h, 0A3h, 26h, 0C6h, 5, 0, 89h, 7Eh
	db	0FEh, 8Ah, 46h, 0EEh, 88h, 46h, 0ECh, 0Ah, 0C0h, 0B0h, 0FFh, 75h
	db	8, 33h, 0C0h, 8Ah, 46h, 0F6h, 89h, 46h, 0FAh, 26h, 88h, 45h, 1
	db	58h, 5Fh, 0C3h, 57h, 8Eh, 6, 0D8h, 7, 8Bh, 7Eh, 0FEh, 26h, 0FEh
	db	5, 0BFh, 3, 0, 57h, 0BFh, 0D4h, 7, 0E8h, 5Ah, 0A3h, 73h, 3, 0E8h
	db	48h, 0A3h, 26h, 88h, 5, 8Bh, 46h, 0F8h, 26h, 89h, 45h, 1, 5Fh
	db	0C3h, 57h, 0FFh, 6, 0CFh, 6, 8Eh, 6, 0D8h, 7, 8Bh, 7Eh, 0FEh, 26h
	db	0FEh, 5, 0BFh, 6, 0, 57h, 0BFh, 0D4h, 7, 0E8h, 30h, 0A3h, 72h
	db	1Bh, 26h, 88h, 5, 2Eh, 0A1h, 0D9h, 0B1h, 26h, 89h, 45h, 1, 8Ah
	db	46h, 0F6h, 26h, 88h, 45h, 3, 8Bh, 46h, 0F8h, 26h, 89h, 45h, 4
	db	5Fh, 0C3h, 0E8h, 3, 0A3h, 57h, 0C6h, 46h, 0ECh, 0FFh, 0BFh, 2
	db	0, 57h, 0BFh, 0D4h, 7, 0E8h, 1, 0A3h, 73h, 3, 0E8h, 0EFh, 0A2h
	db	26h, 88h, 0Dh, 26h, 0C6h, 45h, 1, 0, 8Bh, 7Eh, 0F0h, 3, 0F9h, 89h
	db	7Eh, 0F0h, 5Fh, 0C3h, 0B8h, 5, 0, 0E8h, 50h, 0E1h, 0CDh, '?SVW'
	db	6, 0BFh, 0E4h, 7, 0E8h, 0F1h, 0A3h, 8Bh, 36h, 9Ch, 0B4h, 33h, 0C9h
	db	'SR3', 0D2h, 33h, 0DBh, 0E8h, 7Fh, 0, 5Ah, 5Bh, 8Bh, 1Eh, 0A0h
	db	0B4h, 0EBh, 30h, 26h, 8Bh, 1Fh, 0EBh, 2Bh, 8Eh, 6, 64h, 0B4h, 26h
	db	8Bh, 77h, 2, 26h, 8Bh, 4Fh, 6, 83h, 0F9h, 0FFh, 74h, 0EAh, 26h
	db	8Ah, 47h, 8, 0A8h, 8, 74h, 0E2h, 0A8h, 1, 75h, 0DEh, 26h, 8Bh
	db	1Fh, 'SR3', 0D2h, 8Bh, 0D8h, 0E8h, 49h, 0, 5Ah, 5Bh, 0Bh, 0DBh
	db	75h, 0D1h, 0BFh, 1, 0, 57h, 0BFh, 0E4h, 7, 0E8h, 83h, 0A2h, 73h
	db	3, 0E8h, 71h, 0A2h, 26h, 0C6h, 5, 0, 8Bh, 0Eh, 0E6h, 7, 7, '_^['
	db	0C3h, 'QVWQ', 0E8h, 47h, 0, 51h, 83h, 0C1h, 2, 8Bh, 0F9h, 57h
	db	0BFh, 0DCh, 7, 0E8h, 5Dh, 0A2h, 73h, 3, 0E8h, 4Bh, 0A2h, 0BEh
	db	62h, 5, 59h, 0F3h, 0A4h, 59h, 26h, 89h, 0Dh, '_^Y', 0C3h, 'VWQQ'
	db	0E8h, 20h, 0, 51h, 83h, 0C1h, 2, 8Bh, 0F9h, 57h, 0BFh, 0E4h, 7
	db	0E8h, 36h, 0A2h, 73h, 3, 0E8h, 24h, 0A2h, 0BEh, 62h, 5, 59h, 0F3h
	db	0A4h, 59h, 26h, 89h, 0Dh, 'Y_^', 0C3h, 0F6h, 0C3h, 80h, 75h, 2Eh
	db	8Eh, 6, 6Ch, 0B4h, 33h, 0C9h, 26h, 8Ah, 0Ch, 0FEh, 0C1h, 51h, 0BFh
	db	62h, 5, 1Eh, 1Eh, 6, 1Fh, 7, 0ACh, 0AAh, 49h, 0E3h, 12h, 0ACh
	db	0Bh, 0D2h, 74h, 0Ah, '<ar', 6, '<zw', 2, 2Ch, 20h, 0AAh, 0EBh
	db	0EBh, 1Fh, 59h, 0C3h, 56h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h
	db	0D1h, 0E6h, 8Eh, 84h, 18h, 7, '^FF', 0EBh, 0C3h, 'VSQR3', 0F6h
	db	8Bh, 0Eh, 0DEh, 7, 0A1h, 52h, 0B4h, 3, 6, 0C5h, 6, 33h, 0D2h, 0BBh
	db	0E0h, 7, 0E8h, 0Ch, 0D6h, 'ZY[^', 0C3h, 'VSQR3', 0F6h, 8Bh, 0Eh
	db	0E6h, 7, 0A1h, 0CBh, 6, 33h, 0D2h, 0BBh, 0E8h, 7, 0E8h, 0F2h, 0D5h
	db	'ZY[^', 0C3h, 'VSQR3', 0F6h, 8Bh, 0Eh, 0D6h, 7, 0A1h, 52h, 0B4h
	db	3, 6, 0A3h, 6, 33h, 0D2h, 0BBh, 0D8h, 7, 0E8h, 0D4h, 0D5h, 'ZY[^'
	db	0C3h, 0A1h, 96h, 0B4h, 8Bh, 1Eh, 98h, 0B4h, 0C3h, 33h, 0F6h, 8Eh
	db	6, 78h, 7, 0EBh, 0Eh, 26h, 3Bh, 1Ch, 75h, 6, '&;L', 2, 74h, 0Ch
	db	83h, 0C6h, 0Ah, ';6v', 7, 72h, 0ECh, 0F9h, 0EBh, 1, 0F8h, 0C3h
	db	85h, 0C8h, 74h, 0Ch, 85h, 0D0h, 75h, 6, 0F7h, 0D6h, 23h, 0DEh
	db	0EBh, 2, 0Bh, 0DEh, 0C3h, 'SV3', 0DBh, 8Ah, 0D8h, 0B8h, 80h, 0
	db	0BEh, 1, 0, 0E8h, 0E0h, 0FFh, 0B8h, 2, 0, 0BEh, 2, 0, 0E8h, 0D7h
	db	0FFh, 0B8h, 1, 0, 0BEh, 4, 0, 0E8h, 0CEh, 0FFh, 0B8h, 0, 1, 0BEh
	db	10h, 0, 0E8h, 0C5h, 0FFh, 0B8h, 0, 1, 0BEh, 1, 0, 0E8h, 0BCh, 0FFh
	db	8Ah, 0C3h, 5Eh, 5Bh, 0C3h, 'WVSQR', 0A1h, 8Eh, 0B4h, 0Bh, 6, 92h
	db	0B4h, 'tm3', 0FFh, 8Eh, 6, 0A0h, 7, 0EBh, 5Fh, 8Bh, 36h, 8Eh, 0B4h
	db	26h, 80h, 7Dh, 1, 1, 74h, 4, 8Bh, 36h, 92h, 0B4h, 0F7h, 0C6h, 80h
	db	0, 74h, 5, 26h, 80h, 4Dh, 13h, 1, 0F7h, 0C6h, 2, 0, 74h, 5, 26h
	db	80h, 4Dh, 13h, 2, 0F7h, 0C6h, 20h, 0, 75h, 0Bh, 0F7h, 0C6h, 10h
	db	0, 74h, 5, 26h, 80h, 4Dh, 13h, 2, 0F7h, 0C6h, 1, 0, 74h, 5, 26h
	db	80h, 4Dh, 13h, 4, 0F7h, 0C6h, 4, 0, 74h, 5, 26h, 80h, 4Dh, 13h
	db	8, 0F7h, 0C6h, 0, 1, 74h, 0Ah, 26h, 80h, 4Dh, 13h, 10h, 26h, 80h
	db	4Dh, 13h, 1, 83h, 0C7h, 14h, 3Bh, 3Eh, 9Eh, 7, 72h, 9Bh, 0A0h
	db	'vRP', 0C6h, 6, 76h, 52h, 2, 8Bh, 3Eh, 9Eh, 0B4h, 8Eh, 6, 64h
	db	0B4h, 0EBh, 61h, 26h, 8Bh, 75h, 2, 26h, 0FFh, 75h, 8, 26h, 0FFh
	db	75h, 0Ah, 26h, 0FFh, 75h, 4, 8Eh, 6, 6Ch, 0B4h, 0B4h, 80h, 8Ch
	db	6, 50h, 52h, 0E8h, 0C7h, 0D9h, 5Eh, 53h, 8Bh, 1Eh, 4Ch, 4, 83h
	db	0FEh, 0, 74h, 0Dh, 8Eh, 6, 6Ch, 0B4h, 0B4h, 80h, 8Ch, 6, 50h, 52h
	db	0E8h, 0AFh, 0D9h, 8Bh, 0CBh, 5Bh, 0E8h, 0CDh, 0FEh, 'ZYr', 1Bh
	db	8Eh, 6, 80h, 7, 26h, 8Bh, 34h, 83h, 0FEh, 0FFh, 74h, 0Fh, 8Eh
	db	6, 0A0h, 7, 26h, 8Ah, 44h, 13h, 0E8h, 0E4h, 0FEh, 26h, 88h, 44h
	db	13h, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 3Dh, 0Bh, 0FFh, 75h, 9Bh, 58h
	db	0A2h, 'vRZY[^_', 0C3h, 55h, 8Bh, 0ECh, 8Dh, 66h, 0FEh, 'PVQ', 83h
	db	3Eh, 0A6h, 0B4h, 0, 75h, 7, 'Y^X', 8Bh, 0E5h, 5Dh, 0C3h, 0A1h
	db	0A4h, 0B4h, 2Bh, 6, 0A6h, 0B4h, 75h, 22h, 8Bh, 36h, 0A0h, 0B4h
	db	0B9h, 1, 0, 0EBh, 13h, 8Eh, 6, 64h, 0B4h, 26h, 83h, 7Ch, 6, 0FFh
	db	74h, 5, 26h, 89h, 4Ch, 6, 41h, 26h, 8Bh, 34h, 0Bh, 0F6h, 75h, 0E9h
	db	0EBh, 0CEh, 0BFh, 0F4h, 7, 0E8h, 0E9h, 0A0h, 0B9h, 1, 0, 8Bh, 36h
	db	0A0h, 0B4h, 8Eh, 6, 64h, 0B4h, 0EBh, 19h, 26h, 0F6h, 44h, 8, 8
	db	74h, 0Fh, 26h, 8Bh, 44h, 6, 3Dh, 0FFh, 0FFh, 74h, 6, 3Bh, 0C1h
	db	72h, 2, 8Bh, 0C8h, 26h, 8Bh, 34h, 0Bh, 0F6h, 75h, 0E3h, 3, 0Eh
	db	0A6h, 0B4h, 83h, 0C1h, 8, 0D1h, 0E9h, 0D1h, 0E9h, 0D1h, 0E9h, 8Bh
	db	0F9h, 57h, 0BFh, 0F4h, 7, 0E8h, 90h, 9Fh, 73h, 3, 0E8h, 7Eh, 9Fh
	db	89h, 7Eh, 0FEh, 32h, 0C0h, 0FCh, 0F3h, 0AAh, 8Bh, 7Eh, 0FEh, 8Bh
	db	36h, 0A0h, 0B4h, 0EBh, 2Fh, 8Eh, 6, 64h, 0B4h, 26h, 0F6h, 44h
	db	8, 8, 't!&', 8Bh, 44h, 6, 3Dh, 0FFh, 0FFh, 74h, 18h, 48h, 8Eh
	db	6, 0F8h, 7, 8Bh, 7Eh, 0FEh, 8Bh, 0Eh, 0F6h, 7, 0E8h, 0C8h, 0, 75h
	db	4Bh, 0E8h, 0B2h, 0, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 34h, 0Bh, 0F6h
	db	75h, 0CDh, 8Bh, 36h, 0A0h, 0B4h, 0EBh, 30h, 26h, 0F6h, 44h, 8
	db	8, 'u&&', 83h, 7Ch, 6, 0FFh, 74h, 1Fh, 8Eh, 6, 0F8h, 7, 8Bh, 7Eh
	db	0FEh, 8Bh, 0Eh, 0F6h, 7, 0E8h, 0A7h, 0, 3Dh, 0FFh, 0FFh, 74h, 23h
	db	0E8h, 7Dh, 0, 40h, 8Eh, 6, 64h, 0B4h, 26h, 89h, 44h, 6, 26h, 8Bh
	db	34h, 0Bh, 0F6h, 75h, 0CCh, 0E9h, 2, 0FFh, 8Eh, 6, 64h, 0B4h, 26h
	db	0FFh, 74h, 6, 0E8h, 8, 0, 0EBh, 0ABh, 0B8h, 8, 0, 0E8h, 63h, 0DDh
	db	55h, 8Bh, 0ECh, 'PSQRVW', 0FFh, 76h, 4, 0B8h, 2, 0, 50h, 0B8h
	db	3Dh, 0, 50h, 0E8h, 0CEh, 5, '_^ZY[X', 8Bh, 0E5h, 5Dh, 0C2h, 2
	db	0, 53h, 50h, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 5Ch, 6, '&;]', 6, 7Fh
	db	3, 0F9h, 0EBh, 1, 0F8h, 9Fh, 8Eh, 6, 0F8h, 7, 9Eh, 58h, 5Bh, 0C3h
	db	52h, 8Bh, 0C8h, 0D1h, 0E8h, 0D1h, 0E8h, 0D1h, 0E8h, 8Bh, 0D0h
	db	0D1h, 0E0h, 0D1h, 0E0h, 0D1h, 0E0h, 2Bh, 0C8h, 3, 0FAh, 5Ah, 0C3h
	db	'PQW', 0E8h, 0E3h, 0FFh, 0B0h, 80h, 0D2h, 0E8h, 26h, 8, 5, '_YX'
	db	0C3h, 'PQW', 0E8h, 0D2h, 0FFh, 0B0h, 80h, 0D2h, 0E8h, 26h, 84h
	db	5, '_YX', 0C3h, 6, 'WSQQ', 0B0h, 0FFh, 0FCh, 0F3h, 0AEh, 74h, 17h
	db	5Bh, 2Bh, 0D9h, 4Bh, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 26h, 8Ah
	db	45h, 0FFh, 33h, 0C9h, 0D0h, 0E0h, 73h, 0Bh, 41h, 0EBh, 0F9h, 83h
	db	0C4h, 2, 0B8h, 0FFh, 0FFh, 0EBh, 4, 3, 0D9h, 8Bh, 0C3h, 'Y[_'
	db	7, 0C3h, 55h, 8Bh, 0ECh, 8Dh, 66h, 0F6h, 'SQRV&', 8Bh, 47h, 6
	db	89h, 46h, 0FEh, 89h, 4Eh, 0FCh, 33h, 0C0h, 88h, 46h, 0F6h, 40h
	db	89h, 46h, 0F8h, 26h, 0F6h, 47h, 13h, 1, 74h, 3, 0FEh, 4Eh, 0F6h
	db	8Eh, 6, 0D8h, 7, 33h, 0F6h, 89h, 76h, 0FAh, 26h, 80h, 3Ch, 0, 74h
	db	11h, 0E8h, 19h, 0, 72h, 5, 0E8h, 38h, 0, 73h, 0Ah, 0E8h, 85h, 0
	db	72h, 2, 0EBh, 0EFh, 0B8h, 0FFh, 0FFh, '^ZY[', 8Bh, 0E5h, 5Dh, 0C3h
	db	80h, 7Eh, 0F6h, 0, 75h, 15h, 8Bh, 76h, 0FAh, 33h, 0C0h, 26h, 8Ah
	db	44h, 1, 3Ch, 0FFh, 74h, 0Fh, 3Bh, 46h, 0FEh, 75h, 0Ah, 0F8h, 0EBh
	db	8, 26h, 80h, 7Ch, 1, 0FFh, 74h, 0F6h, 0F9h, 0C3h, 8Bh, 76h, 0FAh
	db	33h, 0C9h, 26h, 8Ah, 0Ch, 8Bh, 56h, 0FCh, 26h, 80h, 7Ch, 1, 0FFh
	db	74h, 11h, 83h, 0C6h, 2, '&9T', 1, 74h, 26h, 83h, 0C6h, 3, 49h
	db	75h, 0F4h, 0EBh, 18h, 83h, 0C6h, 2, 8Bh, 46h, 0FEh, '&8D', 3, 75h
	db	6, '&9T', 4, 74h, 0Ch, 83h, 0C6h, 6, 49h, 75h, 0EEh, 0B8h, 0FFh
	db	0FFh, 0F9h, 0EBh, 10h, 8Bh, 46h, 0F8h, 8Bh, 76h, 0FAh, 33h, 0DBh
	db	26h, 8Ah, 1Ch, 3, 0C3h, 2Bh, 0C1h, 0F8h, 0C3h, 8Bh, 76h, 0FAh
	db	33h, 0C9h, 26h, 8Ah, 0Ch, 1, 4Eh, 0F8h, 0B8h, 6, 0, 26h, 80h, 7Ch
	db	1, 0FFh, 74h, 0Ch, 33h, 0C0h, 26h, 80h, 7Ch, 1, 0, 74h, 3, 0B8h
	db	3, 0, 0F7h, 0E1h, 83h, 0C6h, 2, 3, 0F0h, 89h, 76h, 0FAh, 26h, 80h
	db	3Ch, 0, 74h, 3, 0F8h, 0EBh, 1, 0F9h, 0C3h, 55h, 8Bh, 0ECh, 'WSR'
	db	8Bh, 3Eh, 0A2h, 0B4h, 0E9h, 82h, 0, 8Eh, 6, 64h, 0B4h, 26h, 8Bh
	db	75h, 4, 26h, 8Bh, 55h, 8, 89h, 16h, 0E3h, 6, 8Eh, 6, 6Ch, 0B4h
	db	32h, 0E4h, 8Ch, 6, 50h, 52h, 0E8h, 7Fh, 0D6h, 89h, 1Eh, 0E1h, 6
	db	8Eh, 6, 64h, 0B4h, 26h, 8Bh, 75h, 6, 0Bh, 0F6h, 74h, 13h, 8Eh
	db	6, 6Ch, 0B4h, 32h, 0E4h, 57h, 8Ch, 6, 50h, 52h, 0E8h, 61h, 0D6h
	db	5Fh, 89h, 1Eh, 0DFh, 6, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 75h, 2, 8Eh
	db	6, 6Ch, 0B4h, 33h, 0C0h, 80h, 3Eh, 29h, 1, 0, 74h, 1, 40h, 0FFh
	db	36h, 22h, 1, 0A2h, 22h, 1, 57h, 32h, 0E4h, 8Ch, 6, 50h, 52h, 0E8h
	db	35h, 0D6h, 5Fh, 58h, 0A2h, 22h, 1, 89h, 1Eh, 0E7h, 6, 0C7h, 6
	db	0E5h, 6, 0, 0, 57h, 0E8h, 16h, 0, 5Fh, 8Eh, 6, 64h, 0B4h, 26h
	db	8Bh, 3Dh, 0Bh, 0FFh, 74h, 3, 0E9h, 77h, 0FFh, 'Z[_', 8Bh, 0E5h
	db	5Dh, 0C3h, 53h, 0BFh, 0Ch, 0, 57h, 0BFh, 4, 8, 0E8h, 0A4h, 9Ch
	db	73h, 3, 0E8h, 92h, 9Ch, 57h, 0BEh, 0DFh, 6, 0B9h, 0Ch, 0, 0D1h
	db	0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 8Bh, 1Eh, 0E7h, 6, 53h
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h
	db	7, 5Bh, 26h, 83h, 3Fh, 0FFh, 75h, 29h, 0E8h, '__&', 0C7h, 5, 0
	db	0, 26h, 8Fh, 45h, 2, 26h, 89h, 5Dh, 0Ch, 26h, 0C6h, 45h, 0Eh, 20h
	db	53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h
	db	18h, 7, 5Bh, 26h, 89h, 3Fh, 0EBh, 27h, 26h, 8Bh, 3Fh, 57h, 83h
	db	0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h, 58h, 7
	db	5Fh, 26h, 0F6h, 45h, 0Eh, 10h, 74h, 10h, 26h, 8Fh, 45h, 2, 26h
	db	80h, 4Dh, 0Eh, 20h, 26h, 80h, 65h, 0Eh, 0EFh, 5Bh, 0C3h, 83h, 0C4h
	db	2, 0EBh, 0F9h, 0A0h, 0AAh, 0B4h, 0C3h, 3Bh, 0F7h, 0C3h, 'PQV'
	db	0BFh, 0Ah, 0, 57h, 0BFh, 60h, 0B4h, 0E8h, 0Ch, 9Ch, 73h, 3, 0E8h
	db	0FAh, 9Bh, 57h, 0B9h, 5, 0, 33h, 0C0h, 0F3h, 0ABh, 5Fh, 8Bh, 36h
	db	0ADh, 0B4h, 23h, 0F6h, 75h, 6, 89h, 3Eh, 0A0h, 0B4h, 0EBh, 3, 26h
	db	89h, 3Ch, 89h, 3Eh, 0ADh, 0B4h, '^YX', 0C3h, 53h, 56h, 8Bh, 36h
	db	0A0h, 0B4h, 8Eh, 6, 64h, 0B4h, 0EBh, 1Dh, 0B8h, 3Fh, 0, 26h, 8Bh
	db	5Ch, 4, 3Bh, 1Eh, 74h, 0B4h, 74h, 16h, 0B8h, 3Eh, 0, 26h, 8Bh
	db	5Ch, 2, 3Bh, 1Eh, 72h, 0B4h, 74h, 9, 26h, 8Bh, 34h, 0Bh, 0F6h
	db	75h, 0DFh, 33h, 0C0h, 5Eh, 5Bh, 0C3h, 53h, 56h, 8Bh, 36h, 0A2h
	db	0B4h, 8Eh, 6, 64h, 0B4h, 0EBh, 10h, 0B8h, 40h, 0, 26h, 8Bh, 5Ch
	db	2, 3Bh, 1Eh, 7Ch, 0B4h, 74h, 9, 26h, 8Bh, 34h, 0Bh, 0F6h, 75h
	db	0ECh, 33h, 0C0h, 5Eh, 5Bh, 0C3h, 1Eh, 7, 0BFh, 8Ah, 0B4h, 0B9h
	db	21h, 0, 33h, 0C0h, 0F3h, 0AAh, 0C6h, 6, 8Bh, 0B4h, 1, 80h, 3Eh
	db	19h, 0, 1, 75h, 46h, 83h, 3Eh, 40h, 1, 0, 75h, 4Ch, 0C7h, 6, 8Eh
	db	0B4h, 81h, 1, 80h, 3Eh, 2Bh, 1, 3, 74h, 0Eh, 0C7h, 6, 92h, 0B4h
	db	81h, 0, 0C7h, 6, 50h, 0B4h, 2, 0, 0EBh, 0Ch, 0C7h, 6, 92h, 0B4h
	db	3, 0, 0C7h, 6, 50h, 0B4h, 1, 80h, 0C7h, 6, 96h, 0B4h, 0, 10h, 0C7h
	db	6, 98h, 0B4h, 0, 14h, 33h, 0C0h, 50h, 0B8h, 42h, 0, 50h, 0E8h
	db	20h, 2, 0EBh, 0Dh, 83h, 3Eh, 40h, 1, 0, 74h, 48h, 0C7h, 6, 50h
	db	0B4h, 2, 0, 0E8h, 0D9h, 0E8h, 8Bh, 16h, 40h, 1, 23h, 0D2h, 74h
	db	25h, 1Eh, 83h, 0C2h, 2, 0B8h, 0, 3Dh, 0C5h, 1Eh, 34h, 1, 8Eh, 1Fh
	db	0E8h, 37h, 49h, 1Fh, 8Bh, 0D8h, 53h, 0E8h, 30h, 0EAh, 'ZPS', 8Bh
	db	0DAh, 0E8h, 2, 'I[X#', 0C0h, 75h, 13h, 0E8h, 72h, 0E9h, 1Eh, 7
	db	0BFh, 7Ah, 52h, 0B9h, 0, 40h, 0D1h, 0E9h, 0B8h, 0FFh, 0FFh, 0F3h
	db	0ABh, 0C3h, 51h, 8Bh, 36h, 40h, 1, 83h, 0C6h, 2, 0C5h, 1Eh, 34h
	db	1, 8Eh, 1Fh, 1Eh, 56h, 2Eh, 8Eh, 1Eh, 10h, 0, 0BBh, 6, 0, 53h
	db	50h, 0E8h, 0A7h, 1, 8Bh, 3Eh, 0A0h, 0B4h, 8Eh, 6, 64h, 0B4h, 0E9h
	db	0ADh, 0, 26h, 8Ah, 55h, 8, 26h, 8Bh, 5Dh, 4, 26h, 8Bh, 4Dh, 2
	db	0F6h, 0C2h, 80h, 75h, 46h, 8Eh, 6, 6Ch, 0B4h, 8Bh, 0F1h, 8Ch, 6
	db	'PR3', 0C0h, 80h, 3Eh, 29h, 1, 0, 74h, 1, 40h, 0FFh, 36h, 22h
	db	1, 0A2h, 22h, 1, 53h, 32h, 0E4h, 0E8h, 0E3h, 0D3h, 5Eh, 8Eh, 6
	db	6Ch, 0B4h, 53h, 8Ch, 6, 'PR2', 0E4h, 0C6h, 6, 76h, 52h, 2, 56h
	db	0E8h, 0CEh, 0D3h, '^YX', 0A2h, 22h, 1, 0C6h, 6, 76h, 52h, 0FFh
	db	'ra&', 8Bh, 1Fh, 83h, 0FBh, 0FFh, 74h, 59h, 8Eh, 6, 64h, 0B4h
	db	26h, 89h, 5Dh, 4, 26h, 89h, 4Dh, 2, 26h, 80h, 4Dh, 8, 80h, 53h
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h
	db	7, 5Bh, 26h, 0F6h, 47h, 0Eh, 80h, 'u\&', 80h, 4Fh, 0Eh, 81h, 26h
	db	8Bh, 5Fh, 2, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 38h, 7, 5Bh, 26h, 83h, 7Fh, 0Ah, 1, 75h, 4, 26h, 0FFh
	db	4Fh, 0Ah, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 3Dh, 0Bh, 0FFh, 74h, 3
	db	0E9h, 4Ch, 0FFh, 0C3h, 'PSQRVW', 8Eh, 6, 6Ch, 0B4h, 1Eh, 0BFh
	db	28h, 0, 57h, 6, 56h, 0E8h, 0E0h, 0D7h, 1Eh, 0BEh, 28h, 0, 56h
	db	0B8h, 4, 0, 50h, 0B8h, 3Ah, 0, 50h, 0E8h, 0CDh, 0, '_^ZY[X', 8Eh
	db	6, 64h, 0B4h, 26h, 0C7h, 45h, 6, 0FFh, 0FFh, 0EBh, 0BFh
L0BAF0:	pop	ax	;@0BAF0
	pop	dx	;@0BAF1
	push	bp	;@0BAF2
	mov	bp, sp	;@0BAF3
	sub	sp, 6	;@0BAF5
	push	ds	;@0BAF8
	mov	word ptr [bp-6], ax	;@0BAF9
	mov	word ptr [bp-4], dx	;@0BAFC
	mov	word ptr [bp-2], 0Ah	;@0BAFF
	les	di, dword ptr [bp+2]	;@0BB04
	lds	si, dword ptr [bp+6]	;@0BB07
@@1:	lodsb	;@0BB0A
	cmp	al, 0	;@0BB0B
	je	@@8	;@0BB0D
	cmp	al, 25h	;@0BB0F
	je	@@2	;@0BB11
	stosb	;@0BB13
	jmp	@@1	;@0BB14
@@2:	lodsb	;@0BB16
	cmp	al, 73h	;@0BB17
	je	@@3	;@0BB19
	cmp	al, 64h	;@0BB1B
	je	@@6	;@0BB1D
	cmp	al, 78h	;@0BB1F
	je	@@7	;@0BB21
	jmp	@@1	;@0BB23
@@3:	push	ds	;@0BB25
	push	si	;@0BB26
	mov	si, word ptr [bp-2]	;@0BB27
	mov	ax, word ptr [bp+si+2]	;@0BB2A
	mov	ds, ax	;@0BB2D
	mov	si, word ptr [bp+si]	;@0BB2F
@@4:	lodsb	;@0BB31
	cmp	al, 0	;@0BB32
	je	@@5	;@0BB34
	stosb	;@0BB36
	jmp	@@4	;@0BB37
@@5:	pop	si	;@0BB39
	pop	ds	;@0BB3A
	add	word ptr [bp-2], 4	;@0BB3B
	jmp	@@1	;@0BB3F
@@6:	push	ds	;@0BB41
	push	si	;@0BB42
	mov	si, word ptr [bp-2]	;@0BB43
	mov	si, word ptr [bp+si]	;@0BB46
	push	ds	;@0BB48
	push	es	;@0BB49
	pop	ds	;@0BB4A
	call	L096D7	;@0BB4B
	pop	ds	;@0BB4E
	pop	si	;@0BB4F
	pop	ds	;@0BB50
	add	word ptr [bp-2], 2	;@0BB51
	jmp	@@1	;@0BB55
@@7:	push	ds	;@0BB57
	push	si	;@0BB58
	mov	si, word ptr [bp-2]	;@0BB59
	mov	ax, word ptr [bp+si]	;@0BB5C
	push	ds	;@0BB5E
	push	es	;@0BB5F
	pop	ds	;@0BB60
	call	L0957B	;@0BB61
	pop	ds	;@0BB64
	pop	si	;@0BB65
	pop	ds	;@0BB66
	add	word ptr [bp-2], 2	;@0BB67
	jmp	@@1	;@0BB6B
@@8:	mov	al, 0	;@0BB6D
	stosb	;@0BB6F
	mov	bx, word ptr [bp-6]	;@0BB70
	mov	cx, word ptr [bp-4]	;@0BB73
	mov	ax, word ptr [bp-2]	;@0BB76
	add	ax, bp	;@0BB79
	pop	ds	;@0BB7B
	mov	sp, bp	;@0BB7C
	pop	bp	;@0BB7E
	mov	sp, ax	;@0BB7F
	push	cx	;@0BB81
	push	bx	;@0BB82
	retf	;@0BB83
L0BB84:	push	bp	;@0BB84
	mov	bp, sp	;@0BB85
	push	es	;@0BB87
	push	bx	;@0BB88
	mov	dx, 0E7h	;@0BB89
	mov	ax, 8CDh	;@0BB8C
	mov	es, dx	;@0BB8F
	mov	bx, word ptr [bp+4]	;@0BB91
	shl	bx, 1	;@0BB94
	add	bx, ax	;@0BB96
	mov	ax, word ptr es:[bx]	;@0BB98
	pop	bx	;@0BB9B
	pop	es	;@0BB9C
	pop	bp	;@0BB9D
	ret	2	;@0BB9E
L0BBA1:	mov	ax, 4	;@0BBA1
	jmp	short @@1	;@0BBA4
	db	0B8h, 1, 0, 0EBh, 5, 0B8h, 0, 0, 0EBh, 0	;@0BBA6
@@1:	pop	dx	;@0BBB0
	push	bp	;@0BBB1
	mov	bp, sp	;@0BBB2
	sub	sp, 0Ch	;@0BBB4
	push	ds	;@0BBB7
	push	bx	;@0BBB8
	push	si	;@0BBB9
	push	di	;@0BBBA
	mov	word ptr [bp-6], ax	;@0BBBB
	mov	word ptr [bp-8], dx	;@0BBBE
	call	L09725	;@0BBC1
	cmp	word ptr [bp-6], 1	;@0BBC4
	jne	@@2+1	;@0BBC8
	mov	byte ptr ds:[12h], 1	;@0BBCA
	call	L095E0	;@0BBCF
	pop	es	;@0BBD2
	inc	bp	;@0BBD3
	jb	@@5+1	;@0BBD4
	outsw	;@0BBD6
	jb	@@4	;@0BBD7
	db	20h, 0EBh	; and bl, ch	;@0BBD9
@@2:	and	byte ptr [bp+di-582h], al	;@0BBDB
	add	byte ptr [di+0Fh], dh	;@0BBDF
	call	L095E0	;@0BBE2
	or	word ptr [bx+61h], dx	;@0BBE5
	db	72h, 6Eh	; jb @@6	;@0BBE8
	imul	bp, word ptr [bp+67h], 203Ah	;@0BBEA
	jmp	short @@3	;@0BBEF
	call	L095E0	;@0BBF1
	pop	es	;@0BBF4
	inc	si	;@0BBF5
	popa	;@0BBF6
	db	74h, 61h	; je @@6+2	;@0BBF7
	insb	;@0BBF9
	cmp	ah, byte ptr [bx+si]	;@0BBFA
@@3:	mov	word ptr ds:[0B441h], di	;@0BBFC
	mov	ax, word ptr [bp+2]	;@0BC00
	push	ax	;@0BC03
	call	L0BB84	;@0BC04
	mov	word ptr [bp-0Ch], ax	;@0BC07
	mov	word ptr [bp-0Ah], dx	;@0BC0A
	sub	sp, word ptr [bp+4]	;@0BC0D
	lea	si, [bp+6]	;@0BC10
@@4:	mov	di, sp	;@0BC13
	mov	ax, ss	;@0BC15
	mov	ds, ax	;@0BC17
	mov	es, ax	;@0BC19
	mov	cx, word ptr [bp+4]	;@0BC1B
	rep movsb	;@0BC1E
	mov	ds, word ptr cs:L00100+16	;@0BC20
	push	word ptr [bp-0Ah]	;@0BC25
	push	word ptr [bp-0Ch]	;@0BC28
	push	ds	;@0BC2B
	mov	ax, 0B4C0h	;@0BC2C
	push	ax	;@0BC2F
	push	cs	;@0BC30
	call	L0BAF0	;@0BC31
	push	ds	;@0BC34
	mov	ax, 0B4C0h	;@0BC35
	push	ax	;@0BC38
	call	L09763	;@0BC39
	cmp	word ptr ds:[422h], 1	;@0BC3C
	db	75h, 1Ah	; jne @@7+1	;@0BC41
	mov	di, word ptr ds:[0B441h]	;@0BC43
@@5:	call	L095E0	;@0BC47
	or	sp, word ptr [bx+si]	;@0BC4A
	imul	bp, word ptr [bp+20h], 6F6Dh	;@0BC4C
	db	64h, 75h, 6Ch	; jne @@9	;@0BC51
	db	65h, 20h, 0E8h	; and al, ch	;@0BC54
	cbw	;@0BC57
@@6:	ror	word ptr [bx+di+413Eh], 1	;@0BC58
@@7:	mov	ah, 8Bh	;@0BC5C
	db	3Eh, 41h	; inc cx	;@0BC5E
	db	0B4h, 0E8h	; mov ah, 0E8h	;@0BC60
	stosw	;@0BC62
	rol	di, 1	;@0BC63
	push	es	;@0BC65
	and	al, byte ptr [si]	;@0BC66
	db	0FFh, 0FFh	;@0BC68
	cmp	word ptr [bp-6], 4	;@0BC6A
	jne	@@8	;@0BC6E
	call	L08610	;@0BC70
@@8:	pop	di	;@0BC73
	pop	si	;@0BC74
	pop	bx	;@0BC75
	pop	ds	;@0BC76
	mov	dx, word ptr [bp-8]	;@0BC77
	mov	ax, word ptr [bp+4]	;@0BC7A
	add	ax, 6	;@0BC7D
	add	ax, bp	;@0BC80
	mov	sp, bp	;@0BC82
	pop	bp	;@0BC84
	mov	sp, ax	;@0BC85
	push	dx	;@0BC87
	ret	;@0BC88
	db	0, 0, 0, 0, 0, 0, 0, 0B8h, 2Fh, 0, 0CBh, 0, 0, 0, 0, 0, 0, 0, 0	;@0BC89
	db	0, 0, 0, 0, 0B8h, 5, 4Ch, 0CDh, 21h, 56h, 96h, 92h, 85h, 0C0h
	db	74h, 2, 0F7h, 0E3h, 0E3h, 5, 91h, 0F7h, 0E6h, 3, 0C1h, 96h, 0F7h
	db	0E3h, 3, 0D6h, 5Eh, 0CBh, 0CBh, 0CDh, 40h, 0CBh
@@9:	push	bp	;@0BCC0
	mov	bp, sp	;@0BCC1
	push	si	;@0BCC3
	push	di	;@0BCC4
	mov	dx, es	;@0BCC5
	mov	cx, di	;@0BCC7
	les	di, dword ptr [bp+6]	;@0BCC9
	cld	;@0BCCC
	lea	ax, [bp+6]	;@0BCCD
	stosw	;@0BCD0
	mov	ax, ss	;@0BCD1
	stosw	;@0BCD3
	pushf	;@0BCD4
	pop	ax	;@0BCD5
	stosw	;@0BCD6
	mov	ax, word ptr [bp+4]	;@0BCD7
	stosw	;@0BCDA
	mov	ax, word ptr [bp+2]	;@0BCDB
	stosw	;@0BCDE
	mov	ax, word ptr [bp]	;@0BCDF
	stosw	;@0BCE2
	mov	ax, cx	;@0BCE3
	stosw	;@0BCE5
	mov	ax, dx	;@0BCE6
	stosw	;@0BCE8
	mov	ax, si	;@0BCE9
	stosw	;@0BCEB
	mov	ax, ds	;@0BCEC
	stosw	;@0BCEE
	mov	es, dx	;@0BCEF
	xor	ax, ax	;@0BCF1
	pop	di	;@0BCF3
	pop	si	;@0BCF4
	pop	bp	;@0BCF5
	retf	4	;@0BCF6
	db	55h, 8Bh, 0ECh, 56h, 57h, 8Bh, 5Eh, 6, 83h, 0FBh, 1, 83h, 0D3h	;@0BCF9
	db	0, 0C5h, 76h, 8, 0FCh, 0ADh, 8Eh, 14h, 8Bh, 0E0h, 0ADh, 0ADh, 50h
	db	0ADh, 50h, 0ADh, 50h, 0ADh, 8Bh, 0E8h, 0ADh, 8Bh, 0F8h, 0ADh, 8Eh
	db	0C0h, 0ADh, 8Eh, 1Ch, 8Bh, 0F0h, 8Bh, 0C3h, 0CFh, '_^]', 0CAh
	db	6, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 8Ch, 5Eh, 0FEh, 0C7h, 46h
	db	0FCh, 4, 0, 0EBh, 4, 83h, 46h, 0FCh, 4, 0C4h, 5Eh, 0FCh, 26h, 83h
	db	3Fh, 0, 74h, 16h, 1Eh, 0C4h, 5Eh, 0FCh, 26h, 0FFh, 37h, 0FFh, 76h
	db	6, 0FFh, 76h, 4, 9Ah, 8, 0, 6Fh, 0, 0Bh, 0C0h, 75h, 0DDh, 0C4h
	db	5Eh, 0FCh, 26h, 83h, 3Fh, 0, 75h, 0Eh, 1Eh, 0B8h, 0D8h, 3, 50h
	db	0B8h, 1, 0, 50h, 9Ah, 39h, 0, 3Fh, 0, 0C4h, 5Eh, 0FCh, 26h, 8Bh
	db	47h, 2, 0EBh, 0, 8Bh, 0E5h, 5Dh, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 83h
	db	0ECh, 4, 56h, 0C4h, 5Eh, 8, 26h, 8Bh, 47h, 2, 26h, 8Bh, 17h, 89h
	db	46h, 0FEh, 89h, 56h, 0FCh, 33h, 0F6h
Y00100	ends

Y0BDA0	segment para public 'CODE'
	assume	cs:Y0BDA0
	db	8Bh, 0C6h, 0BAh, 0Ah, 0, 0F7h, 0EAh, 0C4h, 5Eh, 0FCh, 50h, 26h	;@0BDA0
	db	8Ah, 7, 98h, 5Ah, 3, 0D0h, 83h, 0C2h, 0D0h, 8Bh, 0F2h, 0FFh, 46h
	db	0FCh, 0C4h, 5Eh, 0FCh, 26h, 8Ah, 7
Y0BDA0	ends

Y0BDC0	segment para public 'CODE'
	assume	cs:Y0BDC0
	db	98h, 8Bh, 0D8h, 0F6h, 87h, 73h, 2, 2, 75h, 0D6h, 0FFh, 76h, 0FEh	;@0BDC0
	db	0FFh, 76h, 0FCh, 9Ah, 9, 0, 7Fh, 0, 3Bh, 0C6h, 73h, 0Eh, 1Eh, 0B8h
	db	0D8h, 3, 50h, 0B8h, 1, 0, 50h, 9Ah, 39h, 0, 3Fh, 0, 0FFh, 4Eh
	db	0FCh, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh, 8Bh, 46h, 0FCh, 40h, 0FFh
	db	76h, 0FEh, 50h, 56h, 9Ah, 9, 0, 0BFh, 0, 0C4h, 5Eh, 0FCh, 26h
	db	0C6h, 0, 0, 0C4h, 5Eh, 8, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 26h
	db	89h, 47h, 2, 26h, 89h, 17h, 0C4h, 5Eh, 4, 26h, 89h, 37h, 5Eh, 8Bh
	db	0E5h, 5Dh, 0C2h
Y0BDC0	ends

Y0BE20	segment para public 'CODE'
	assume	cs:Y0BE20
	db	8, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 'tVW', 0C4h, 5Eh, 10h, 26h, 8Bh	;@0BE20
	db	47h, 2, 26h, 8Bh, 17h, 89h, 46h, 0FAh, 89h, 56h, 0F8h, 0C4h, 5Eh
	db	0Ch, 26h, 8Bh, 47h, 2, 26h, 8Bh, 17h, 89h, 46h, 0F6h, 89h, 56h
	db	0F4h, 0C7h, 46h, 0F0h, 0, 0, 0C7h, 46h, 0EEh, 0, 0, 0C4h, 5Eh
	db	0F8h, 26h, 8Ah, 7, 98h, 2Dh, 75h, 0, 8Bh, 0D8h, 83h, 0FBh, 5, 77h
	db	57h, 0D1h, 0E3h, 2Eh, 0FFh, 0A7h, 25h, 7, 0C4h, 5Eh, 0F8h, 26h
	db	80h, 7Fh, 1, 70h, 75h, 0Ah, 8Ch, 5Eh, 0F0h, 0C7h, 46h, 0EEh, 0C5h
	db	1, 0EBh, 1Ch, 0C4h, 5Eh, 0F8h, 26h, 80h, 7Fh, 1, 72h, 75h, 0Ah
	db	8Ch, 5Eh, 0F0h, 0C7h, 46h, 0EEh, 0CCh, 1, 0EBh, 8, 8Ch, 5Eh, 0FEh
	db	0C7h, 46h, 0FCh, 0D3h, 1, 0EBh, 20h, 8Ch, 5Eh, 0FEh, 0C7h, 46h
	db	0FCh, 0DDh, 1, 0EBh, 16h, 8Ch, 5Eh, 0FEh, 0C7h, 46h, 0FCh, 0DEh
	db	1, 0EBh, 0Ch, 8Ch, 5Eh, 0FEh, 0C7h, 46h, 0FCh, 0E5h, 1, 0EBh, 2
	db	0EBh, 58h, 0FFh, 46h, 0F8h, 8Bh, 46h, 0EEh, 0Bh, 46h, 0F0h, 75h
	db	4Ah, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh, 9Ah, 9, 0, 7Fh, 0, 89h
	db	46h, 0F2h, 0C4h, 5Eh, 8, 26h, 8Bh, 7, 3Bh, 46h, 0F2h, 72h, 22h
	db	0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh
	db	9Ah, 0Ah, 0, 0AFh, 0, 8Bh, 46h, 0F2h, 1, 46h, 0F4h, 0C4h, 5Eh
	db	8, 8Bh, 46h, 0F2h, 26h, 29h, 7, 0EBh, 8, 0C4h, 5Eh, 8, 26h, 0C7h
	db	7, 0, 0, 0C4h, 5Eh, 0F4h, 26h, 0C6h, 7, 0, 0E9h, 3Eh, 0FFh, 0C4h
	db	5Eh, 0F8h, 26h, 8Ah, 7, 98h, 2Dh, 63h, 0, 8Bh, 0D8h, 83h, 0FBh
	db	13h, 77h, 61h, 0D1h, 0E3h, 2Eh, 0FFh, 0A7h, 0FDh, 6, 8Ch, 5Eh
	db	0FEh, 0C7h, 46h, 0FCh, 0EFh, 1, 0EBh, 52h, 8Ch, 5Eh, 0FEh, 0C7h
	db	46h, 0FCh, 0F4h, 1, 0EBh, 48h, 8Ch, 5Eh, 0FEh, 0C7h, 46h, 0FCh
	db	0F9h, 1, 0EBh, 3Eh, 8Ch, 5Eh, 0FEh, 0C7h, 46h, 0FCh, 0FFh, 1, 0EBh
	db	34h, 8Ch, 5Eh, 0FEh, 0C7h, 46h, 0FCh, 3, 2, 0EBh, 2Ah, 8Ch, 5Eh
	db	0FEh, 0C7h, 46h, 0FCh, 8, 2, 0EBh, 20h, 8Ch, 5Eh, 0FEh, 0C7h, 46h
	db	0FCh, 0Eh, 2, 0EBh, 16h, 8Ch, 5Eh, 0FEh, 0C7h, 46h, 0FCh, 15h
	db	2, 0EBh, 0Ch, 8Ch, 5Eh, 0FEh, 0C7h, 46h, 0FCh, 21h, 2, 0EBh, 2
	db	0EBh, 49h, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh, 9Ah, 9, 0, 7Fh, 0
	db	89h, 46h, 0F2h, 0C4h, 5Eh, 8, 26h, 8Bh, 7, 3Bh, 46h, 0F2h, 72h
	db	22h, 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 0FFh, 76h, 0FEh, 0FFh, 76h
	db	0FCh, 9Ah, 0Ah, 0, 0AFh, 0, 8Bh, 46h, 0F2h, 1, 46h, 0F4h, 0C4h
	db	5Eh, 8, 8Bh, 46h, 0F2h, 26h, 29h, 7, 0EBh, 8, 0C4h, 5Eh, 8, 26h
	db	0C7h, 7, 0, 0, 0FFh, 46h, 0F8h, 0E9h, 19h, 4, 0C4h, 5Eh, 0F8h
	db	26h, 8Ah, 7, 98h, 8Bh, 0D8h, 0F6h, 87h, 73h, 2, 2, 74h, 4Ch, 16h
	db	8Dh, 46h, 0F8h, 50h, 16h, 8Dh, 46h, 0F2h, 50h, 0E8h, 97h, 0FDh
	db	0C4h, 5Eh, 8, 26h, 8Bh, 7, 3Bh, 46h, 0F2h, 72h, 22h, 0FFh, 76h
	db	0F6h, 0FFh, 76h, 0F4h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h, 9Ah, 0Ah
	db	0, 0AFh, 0, 8Bh, 46h, 0F2h, 1, 46h, 0F4h, 0C4h, 5Eh, 8, 8Bh, 46h
	db	0F2h, 26h, 29h, 7, 0EBh, 8, 0C4h, 5Eh, 8, 26h, 0C7h, 7, 0, 0, 8Bh
	db	46h, 0F2h, 40h, 1, 46h, 0F8h, 0E9h, 0BDh, 3, 0C4h, 5Eh, 0F8h, 26h
	db	80h, '?pt', 1Eh, 0C4h, 5Eh, 0F8h, 26h, 80h, '?rt', 15h, 0C4h, 5Eh
	db	0F8h, 26h, 80h, '?mt', 0Ch, 0C4h, 5Eh, 0F8h, 26h, 80h, '?nt', 3
	db	0E9h, 78h, 1, 0C7h, 46h, 0ECh, 0, 0, 8Bh, 46h, 0EEh, 0Bh, 46h
	db	0F0h, 75h, 40h, 0C4h, 5Eh, 0F8h, 26h, 80h, '?rt', 9, 0C4h, 5Eh
	db	0F8h, 26h, 80h, '?mu', 5, 0B8h, 1, 0, 0EBh, 2, 33h, 0C0h, 89h
	db	46h, 0ECh, 0C4h, 5Eh, 0F8h, 26h, 80h, '?pt', 9, 0C4h, 5Eh, 0F8h
	db	26h, 80h, '?ru', 0Ah, 8Ch, 5Eh, 0F0h, 0C7h, 46h, 0EEh, 25h, 2
	db	0EBh, 8, 8Ch, 5Eh, 0F0h, 0C7h, 46h, 0EEh, 2Bh, 2, 0FFh, 46h, 0F8h
	db	8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h, 89h, 46h, 0E8h, 89h, 56h, 0E6h
	db	0B0h, 0, 88h, 46h, 0EAh, 88h, 46h, 0EBh, 0C4h, 5Eh, 0E6h, 26h
	db	80h, '?xu', 6, 0C6h, 46h, 0EBh, 1, 0EBh, 11h, 0C4h, 5Eh, 0E6h
	db	26h, 80h, '?wu', 6, 0C6h, 46h, 0EAh, 1, 0EBh, 2, 0EBh, 5, 0FFh
	db	46h, 0E6h, 0EBh, 0DBh, 33h, 0FFh, 0C4h, 5Eh, 0E6h, 26h, 80h, '?qu'
	db	10h, 47h, 0FFh, 46h, 0EEh, 8Bh, 46h, 0E8h, 8Bh, 56h, 0E6h, 89h
	db	46h, 0FAh, 89h, 56h, 0F8h, 16h, 8Dh, 46h, 0F8h, 50h, 16h, 8Dh
	db	46h, 0F4h, 50h, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 0F0h
	db	0FFh, 76h, 0EEh, 0E8h, 0Fh, 0FDh, 0Bh, 0FFh, 74h, 56h, 80h, 7Eh
	db	0EBh, 0, 74h, 24h, 0C4h, 5Eh, 8, 26h, 83h, 3Fh, 6, 76h, 1Bh, 0FFh
	db	76h, 0F6h, 0FFh, 76h, 0F4h, 1Eh, 0B8h, 30h, 2, 50h, 9Ah, 0Ah, 0
	db	0AFh, 0, 83h, 46h, 0F4h, 6, 0C4h, 5Eh, 8, 26h, 83h, 2Fh, 6, 80h
	db	7Eh, 0EAh, 0, 74h, 24h, 0C4h, 5Eh, 8, 26h, 83h, 3Fh, 9, 76h, 1Bh
	db	0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 1Eh, 0B8h, 37h, 2, 50h, 9Ah
	db	0Ah, 0, 0AFh, 0, 83h, 46h, 0F4h, 9, 0C4h, 5Eh, 8, 26h, 83h, 2Fh
	db	9, 0EBh, 5Eh, 0C4h, 5Eh, 0F4h, 26h, 8Ah, 47h, 0FFh, 98h, 8Bh, 0D8h
	db	8Ah, 87h, 73h, 2, 98h, 0A9h, 0Eh, 0, 75h, 3, 0FFh, 46h, 0EEh, 0FFh
	db	76h, 0F0h, 0FFh, 76h, 0EEh, 9Ah, 9, 0, 7Fh, 0, 8Bh, 0F0h, 0C4h
	db	5Eh, 8, '&97v2', 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 0FFh, 76h, 0F0h
	db	0FFh, 76h, 0EEh, 9Ah, 0Ah, 0, 0AFh, 0, 1, 76h, 0F4h, 83h, 7Eh
	db	0ECh, 0, 74h, 4, 0B0h, 26h, 0EBh, 2, 0B0h, 2Ah, 0C4h, 5Eh, 0F4h
	db	26h, 88h, 7, 0FFh, 46h, 0F4h, 8Bh, 0C6h, 40h, 0C4h, 5Eh, 8, 26h
	db	29h, 7, 0E9h, 1Eh, 2, 0C4h, 5Eh, 0F8h, 26h, 80h, '?at', 3, 0E9h
	db	0CDh, 0, 33h, 0F6h, 0C6h, 42h, 8Ch, 5Bh, 46h, 0FFh, 46h, 0F8h
	db	0C4h, 5Eh, 0F8h, 26h, 80h, '?0u', 3, 0FFh, 46h, 0F8h, 0EBh, 0Dh
	db	0C4h, 5Eh, 0F8h, 26h, 8Ah, 7, 88h, 42h, 8Ch, 0FFh, 46h, 0F8h, 46h
	db	0C4h, 5Eh, 0F8h, 26h, 80h, 3Fh, 0, 74h, 9, 0C4h, 5Eh, 0F8h, 26h
	db	80h, '?$u', 0E1h, 0C4h, 5Eh, 0F8h, 26h, 80h, 3Fh, 0, 74h, 3, 0FFh
	db	46h, 0F8h, 0C6h, 42h, 8Ch, 5Dh, 46h, 0C4h, 5Eh, 0F8h, 26h, 80h
	db	'?at', 0B1h, 0C6h, 42h, 8Ch, 0, 16h, 8Dh, 46h, 0F8h, 50h, 16h
	db	8Dh, 46h, 0F4h, 50h, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 33h, 0C0h, 33h
	db	0D2h, 50h, 52h, 0E8h, 0DAh, 0FBh, 0C4h, 5Eh, 8, 8Bh, 0C6h, '@@&9'
	db	7, 72h, 1Bh, 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 16h, 8Dh, 46h, 8Ch
	db	50h, 9Ah, 0Ah, 0, 0AFh, 0, 1, 76h, 0F4h, 0C4h, 5Eh, 8, '&)7', 0EBh
	db	35h, 0C4h, 5Eh, 8, 26h, 83h, 3Fh, 2, 72h, 24h, 0C4h, 5Eh, 0F4h
	db	26h, 0C6h, 7, 5Bh, 0FFh, 46h, 0F4h, 0C4h, 5Eh, 0F4h, 26h, 0C6h
	db	7, 5Dh, 0FFh, 46h, 0F4h, 0C4h, 5Eh, 0F4h, 26h, 0C6h, 7, 0, 0C4h
	db	5Eh, 8, 26h, 83h, 2Fh, 2, 0EBh, 8, 0C4h, 5Eh, 8, 26h, 0C7h, 7
	db	0, 0, 0E9h, 45h, 1, 0C4h, 5Eh, 0F8h, 26h, 80h, '?qt', 3, 0E9h
	db	22h, 1, 8Bh, 46h, 0F6h, 8Bh, 56h, 0F4h, 89h, 46h, 0ECh, 89h, 56h
	db	0EAh, 0FFh, 46h, 0F8h, 0C4h, 5Eh, 8, 26h, 83h, 3Fh, 3, 72h, 69h
	db	0C4h, 5Eh, 0F4h, 26h, 0C6h, 7, 28h, 0FFh, 46h, 0F4h, 8Bh, 46h
	db	4, 0Bh, 46h, 6, 74h, 33h, 0FFh, 76h, 6, 0FFh, 76h, 4, 9Ah, 9, 0
	db	7Fh, 0, 8Bh, 0F0h, 0C4h, 5Eh, 8, 8Bh, 0C6h, '@@&9', 7, 72h, 1Ah
	db	0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 0FFh, 76h, 6, 0FFh, 76h, 4, 9Ah
	db	0Ah, 0, 0AFh, 0, 1, 76h, 0F4h, 0C4h, 5Eh, 8, '&)7', 0C4h, 5Eh
	db	0F4h, 26h, 0C6h, 7, 2Ah, 0FFh, 46h, 0F4h, 0C4h, 5Eh, 0F4h, 26h
	db	0C6h, 7, 29h, 0FFh, 46h, 0F4h, 0C4h, 5Eh, 8, 26h, 83h, 2Fh, 3
	db	0C4h, 5Eh, 0F4h, 26h, 0C6h, 7, 0, 0EBh, 8, 0C4h, 5Eh, 8, 26h, 0C7h
	db	7, 0, 0, 16h, 8Dh, 46h, 0F8h, 50h, 16h, 8Dh, 46h, 0F4h, 50h, 0FFh
	db	76h, 0Ah, 0FFh, 76h, 8, 0E8h, 2, 1, 0C4h, 5Eh, 0F8h, 26h, 80h
	db	'?$u{', 0FFh, 46h, 0F8h, 8Bh, 46h, 0F6h, 8Bh, 56h, 0F4h, 89h, 46h
	db	0E8h, 89h, 56h, 0E6h, 16h, 8Dh, 46h, 0F8h, 50h, 16h, 8Dh, 46h
	db	0F4h, 50h, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 33h, 0C0h, 33h, 0D2h
	db	50h, 52h, 0E8h, 0A2h, 0FAh, 0FFh, 76h, 0E8h, 0FFh, 76h, 0E6h, 9Ah
	db	9, 0, 7Fh, 0, 8Bh, 0F0h, 83h, 0FEh, '@sA', 16h, 8Dh, 46h, 0A6h
	db	50h, 0FFh, 76h, 0E8h, 0FFh, 76h, 0E6h, 9Ah, 0Ah, 0, 0AFh, 0, 8Bh
	db	46h, 0EAh, 3, 0C6h, 0FFh, 76h, 0ECh, 50h, 0FFh, 76h, 0ECh, 0FFh
	db	76h, 0EAh, 8Bh, 46h, 0E6h, 33h, 0D2h, 2Bh, 46h, 0EAh, 83h, 0DAh
	db	0, 50h, 9Ah, 9, 0, 0BFh, 0, 0FFh, 76h, 0ECh, 0FFh, 76h, 0EAh, 16h
	db	8Dh, 46h, 0A6h, 50h, 56h, 9Ah, 9, 0, 0BFh, 0, 0EBh, 17h, 0C4h
	db	5Eh, 0F8h, 26h, 80h, 3Fh, 0, 74h, 0Eh, 1Eh, 0B8h, 0D8h, 3, 50h
	db	0B8h, 1, 0, 50h, 9Ah, 39h, 0, 3Fh, 0, 0C4h, 5Eh, 0F4h, 26h, 0C6h
	db	7, 0, 0C4h, 5Eh, 10h, 8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h, 26h, 89h
	db	47h, 2, 26h, 89h, 17h, 0C4h, 5Eh, 0Ch, 8Bh, 46h, 0F6h, 8Bh, 56h
	db	0F4h, 26h, 89h, 47h, 2, 26h, 89h, 17h, 0EBh, 0, 5Fh, 5Eh, 8Bh
	db	0E5h, 5Dh, 0C2h, 10h, 0, 18h, 2, 4Ah, 2, 5Eh, 2, 40h, 2, 54h, 2
	db	68h, 2, 2Ch, 2, 68h, 2, 68h, 2, 36h, 2, 68h, 2, 68h, 2, 68h, 2
	db	68h, 2, 68h, 2, 68h, 2, 22h, 2, 68h, 2, 68h, 2, 0Eh, 2, 4Ch, 1
	db	9Ch, 1, 92h, 1, 88h, 1, 9Ch, 1, 7Eh, 1, 55h, 8Bh, 0ECh, 83h, 0ECh
	db	'^VW', 0C4h, 5Eh, 0Ch, 26h, 8Bh, 47h, 2, 26h, 8Bh, 17h, 89h, 46h
	db	0FEh, 89h, 56h, 0FCh, 0C4h, 5Eh, 8, 26h, 8Bh, 47h, 2, 26h, 8Bh
	db	17h, 89h, 46h, 0FAh, 89h, 56h, 0F8h, 0C4h, 5Eh, 4, 26h, 8Bh, 7
	db	89h, 46h, 0F6h, 33h, 0F6h, 0A1h, 0D4h, 3, 89h, 46h, 0F2h, 0A1h
	db	0D6h, 3, 89h, 46h, 0F0h, 83h, 7Eh, 0F6h, 0, 76h, 14h, 0C4h, 5Eh
	db	0F8h, 26h, 0C6h, 7, 28h, 0FFh, 46h, 0F8h, 0FFh, 4Eh, 0F6h, 0C4h
	db	5Eh, 0F8h, 26h, 0C6h, 7, 0, 0C4h, 5Eh, 0FCh, 26h, 80h, '?vu', 6
	db	0FFh, 46h, 0FCh, 0E9h, 77h, 1, 46h, 8Bh, 0DEh, 0D1h, 0E3h, 8Dh
	db	46h, 0A2h, 3, 0D8h, 36h, 0C7h, 7, 0, 0, 0C4h, 5Eh, 0FCh, 26h, 80h
	db	'?tt', 3, 0E9h, 0C2h, 0, 0FFh, 46h, 0FCh, 0C4h, 5Eh, 0FCh, 26h
	db	8Ah, 7, 98h, 8Bh, 0D8h, 0F6h, 87h, 73h, 2, 2, 74h, 0Eh, 0C4h, 5Eh
	db	0FCh, 26h, 8Ah, 7, 98h, 5, 0D0h, 0FFh, 8Bh, 0F8h, 0EBh, 2Ch, 0C4h
	db	5Eh, 0FCh, 26h, 8Ah, 7, 98h, 8Bh, 0D8h, 0F6h, 87h, 73h, 2, 8, 74h
	db	0Eh, 0C4h, 5Eh, 0FCh, 26h, 8Ah, 7, 98h, 5, 0A9h, 0FFh, 8Bh, 0F8h
	db	0EBh, 0Eh, 1Eh, 0B8h, 0D8h, 3, 50h, 0B8h, 1, 0, 50h, 9Ah, 39h
	db	0, 3Fh, 0, 0C4h, 5Eh, 0FCh, 26h, 80h, 3Fh, 0, 74h, 3, 0FFh, 46h
	db	0FCh, 8Bh, 0DFh, 0D1h, 0E3h, 8Dh, 46h, 0A2h, 3, 0D8h, 36h, 83h
	db	3Fh, 0, 74h, 4Ah, 16h, 8Bh, 0DFh, 0D1h, 0E3h, 8Dh, 46h, 0A2h, 3
	db	0D8h, 36h, 0FFh, 37h, 9Ah, 9, 0, 7Fh, 0, 89h, 46h, 0F4h, 8Bh, 46h
	db	0F6h, 3Bh, 46h, 0F4h, 72h, 26h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h
	db	16h, 8Bh, 0DFh, 0D1h, 0E3h, 8Dh, 46h, 0A2h, 3, 0D8h, 36h, 0FFh
	db	37h, 9Ah, 0Ah, 0, 0AFh, 0, 8Bh, 46h, 0F4h, 1, 46h, 0F8h, 8Bh, 46h
	db	0F4h, 29h, 46h, 0F6h, 0EBh, 5, 0C7h, 46h, 0F6h, 0, 0, 0EBh, 0Eh
	db	1Eh, 0B8h, 0D8h, 3, 50h, 0B8h, 1, 0, 50h, 9Ah, 39h, 0, 3Fh, 0
	db	0EBh, 68h, 8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h, 89h, 46h, 0EEh, 89h
	db	56h, 0ECh, 16h, 8Dh, 46h, 0FCh, 50h, 16h, 8Dh, 46h, 0F8h, 50h
	db	16h, 8Dh, 46h, 0F6h, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 0E8h
	db	68h, 0F8h, 0FFh, 76h, 0EEh, 0FFh, 76h, 0ECh, 9Ah, 9, 0, 7Fh, 0
	db	40h, 89h, 46h, 0EAh, 0A1h, 0D4h, 3, 3Bh, 46h, 0EAh, 72h, 2Dh, 8Bh
	db	0DEh, 0D1h, 0E3h, 8Dh, 46h, 0A2h, 3, 0D8h, 0A1h, 0D6h, 3, 36h
	db	89h, 7, 16h, 0FFh, 36h, 0D6h, 3, 0FFh, 76h, 0EEh, 0FFh, 76h, 0ECh
	db	9Ah, 0Ah, 0, 0AFh, 0, 8Bh, 46h, 0EAh, 1, 6, 0D6h, 3, 8Bh, 46h
	db	0EAh, 29h, 6, 0D4h, 3, 0C4h, 5Eh, 0FCh, 26h, 8Ah, 7, 98h, 8Bh
	db	0D8h, 8Ah, 87h, 73h, 2, 98h, 0A9h, 0Eh, 0, 75h, 2, 0EBh, 1Dh, 83h
	db	7Eh, 0F6h, 0, 76h, 14h, 0C4h, 5Eh, 0F8h, 26h, 0C6h, 7, 2Ch, 0FFh
	db	46h, 0F8h, 0C4h, 5Eh, 0F8h, 26h, 0C6h, 7, 0, 0FFh, 4Eh, 0F6h, 0E9h
	db	89h, 0FEh, 83h, 7Eh, 0F6h, 0, 76h, 0Dh, 0C4h, 5Eh, 0F8h, 26h, 0C6h
	db	7, 29h, 0FFh, 46h, 0F8h, 0FFh, 4Eh, 0F6h, 0C4h, 5Eh, 0F8h, 26h
	db	0C6h, 7, 0, 8Bh, 46h, 0F2h, 0A3h, 0D4h, 3, 8Bh, 46h, 0F0h, 0A3h
	db	0D6h, 3, 0C4h, 5Eh, 0Ch, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 26h, 89h
	db	47h, 2, 26h, 89h, 17h, 0C4h, 5Eh, 8, 8Bh, 46h, 0FAh, 8Bh, 56h
	db	0F8h, 26h, 89h, 47h, 2, 26h, 89h, 17h, 0C4h, 5Eh, 4, 8Bh, 46h
	db	0F6h, 26h, 89h, 7, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0C2h, 0Ch, 0, 55h
	db	8Bh, 0ECh, 81h, 0ECh, 0D6h, 0, 56h, 57h, 8Bh, 7Eh, 10h, 8Bh, 46h
	db	16h, 0Bh, 46h, 18h, 75h, 5, 33h, 0C0h, 0E9h, 74h, 4, 0C4h, 5Eh
	db	16h, 26h, 80h, '?@t', 16h, 0FFh, 76h, 14h, 0FFh, 76h, 12h, 0FFh
	db	76h, 18h, 0FFh, 76h, 16h, 9Ah, 0Ah, 0, 0AFh, 0, 33h, 0C0h, 0E9h
	db	55h, 4, 16h, 8Dh, 86h, 2Ah, 0FFh, 50h, 0FFh, 76h, 18h, 0FFh, 76h
	db	16h, 0B8h, 3Eh, 0, 50h, 9Ah, 35h, 0, 0AFh, 0, 0C6h, 86h, 68h, 0FFh
	db	0, 8Dh, 86h, 2Bh, 0FFh, 8Ch, 56h, 0FEh, 89h, 46h, 0FCh, 0EBh, 17h
	db	0C4h, 5Eh, 0FCh, 26h, 80h, '?a|', 0Bh, 0C4h, 5Eh, 0FCh, 26h, 80h
	db	3Fh, 7Ah, 7Fh, 2, 0EBh, 37h, 0FFh, 46h, 0FCh, 0C4h, 5Eh, 0FCh
	db	26h, 80h, 3Fh, 0, 75h, 0E0h, 8Dh, 86h, 2Bh, 0FFh, 8Ch, 56h, 0FEh
	db	89h, 46h, 0FCh, 0EBh, 16h, 0C4h, 5Eh, 0FCh, 26h, 8Ah, 7, 98h, 50h
	db	9Ah, 4, 0, 8Fh, 0, 0C4h, 5Eh, 0FCh, 26h, 88h, 7, 0FFh, 46h, 0FCh
	db	0C4h, 5Eh, 0FCh, 26h, 80h, 3Fh, 0, 75h, 0E1h, 8Dh, 86h, 2Bh, 0FFh
	db	8Ch, 56h, 0FEh, 89h, 46h, 0FCh, 0C4h, 5Eh, 0FCh, 26h, 80h, '?$u'
	db	18h, 0C4h, 5Eh, 0FCh, 26h, 80h, 7Fh, 1, 62h, 74h, 0Ah, 0C4h, 5Eh
	db	0FCh, 26h, 80h, 7Fh, 1, 6Fh, 75h, 4, 83h, 46h, 0FCh, 3, 0EBh, 3
	db	0FFh, 46h, 0FCh, 0C4h, 5Eh, 0FCh, 26h, 80h, 3Fh, 0, 74h, 12h, 0C4h
	db	5Eh, 0FCh, 26h, 80h, '?@t', 9, 0C4h, 5Eh, 0FCh, 26h, 80h, '?$u'
	db	0E2h, 0C4h, 5Eh, 0FCh, 26h, 80h, 3Fh, 0, 75h, 37h, 8Bh, 46h, 12h
	db	0Bh, 46h, 14h, 74h, 11h, 0FFh, 76h, 14h, 0FFh, 76h, 12h, 0FFh
	db	76h, 18h, 0FFh, 76h, 16h, 9Ah, 0Ah, 0, 0AFh, 0, 8Bh, 46h, 8, 0Bh
	db	46h, 0Ah, 74h, 11h, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 18h
	db	0FFh, 76h, 16h, 9Ah, 0Ah, 0, 0AFh, 0, 33h, 0C0h, 0E9h, 59h, 3
	db	0C4h, 5Eh, 0FCh, 26h, 80h, '?@t', 3, 0E9h, 80h, 0, 0C4h, 5Eh, 0FCh
	db	26h, 0C6h, 7, 0, 0FFh, 46h, 0FCh, 8Dh, 86h, 2Bh, 0FFh, 8Ch, 56h
	db	0F2h, 89h, 46h, 0F0h, 0EBh, 3, 0FFh, 46h, 0FCh, 0C4h, 5Eh, 0FCh
	db	26h, 8Ah, 7, 98h, 8Bh, 0D8h, 8Ah, 87h, 73h, 2, 98h, 0A9h, 2, 0
	db	75h, 0EAh, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 89h, 46h, 0F6h, 89h
	db	56h, 0F4h, 0C4h, 5Eh, 0FCh, 26h, 80h, '?$u', 18h, 0C4h, 5Eh, 0FCh
	db	26h, 80h, 7Fh, 1, 62h, 74h, 0Ah, 0C4h, 5Eh, 0FCh, 26h, 80h, 7Fh
	db	1, 6Fh, 75h, 4, 83h, 46h, 0FCh, 3, 0EBh, 3, 0FFh, 46h, 0FCh, 0C4h
	db	5Eh, 0FCh, 26h, 80h, 3Fh, 0, 74h, 9, 0C4h, 5Eh, 0FCh, 26h, 80h
	db	'?$u', 0EBh, 0C4h, 5Eh, 0FCh, 26h, 80h, 3Fh, 0, 75h, 5, 0BEh, 6
	db	0, 0EBh, 76h, 0EBh, 14h, 0C7h, 46h, 0F2h, 0, 0, 0C7h, 46h, 0F0h
	db	0, 0, 8Dh, 86h, 2Bh, 0FFh, 8Ch, 56h, 0F6h, 89h, 46h, 0F4h, 0C4h
	db	5Eh, 0FCh, 26h, 0C6h, 7, 0, 0FFh, 46h, 0FCh, 0C4h, 5Eh, 0F4h, 26h
	db	80h, '?$uJ', 83h, 46h, 0F4h, 2, 0C4h, 5Eh, 0F4h, 26h, 80h, 7Fh
	db	0FFh, 'bu7', 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 1Eh, 0B8h, 41h
	db	2, 50h, 9Ah, 8, 0, 6Fh, 0, 0Bh, 0C0h, 75h, 5, 0BEh, 2, 0, 0EBh
	db	1Ch, 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 1Eh, 0B8h, 45h, 2, 50h
	db	9Ah, 8, 0, 6Fh, 0, 0Bh, 0C0h, 75h, 5, 0BEh, 3, 0, 0EBh, 3, 0BEh
	db	4, 0, 0EBh, 3, 0BEh, 5, 0, 0EBh, 3, 0BEh, 1, 0, 8Bh, 46h, 0Ch
	db	0Bh, 46h, 0Eh, 74h, 11h, 0FFh, 76h, 0Eh, 0FFh, 76h, 0Ch, 0FFh
	db	76h, 0F2h, 0FFh, 76h, 0F0h, 9Ah, 0Ah, 0, 0AFh, 0, 8Bh, 46h, 8
	db	0Bh, 46h, 0Ah, 74h, 2Dh, 8Bh, 46h, 12h, 0Bh, 46h, 14h, 75h, 14h
	db	8Bh, 46h, 0Ah, 8Bh, 56h, 8, 89h, 46h, 0FAh, 89h, 56h, 0F8h, 0C7h
	db	46h, 6, 0, 0, 0E9h, 0B7h, 0, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh
	db	76h, 0F6h, 0FFh, 76h, 0F4h, 9Ah, 0Ah, 0, 0AFh, 0, 8Bh, 46h, 12h
	db	0Bh, 46h, 14h, 75h, 5, 8Bh, 0C6h, 0E9h, 0FEh, 1, 8Bh, 46h, 14h
	db	8Bh, 56h, 12h, 89h, 46h, 0FAh, 89h, 56h, 0F8h, 8Bh, 0C7h, 48h
	db	89h, 46h, 0ECh, 1Eh, 0B8h, 0D8h, 3, 50h, 9Ah, 0, 0, 3Fh, 0, 0Bh
	db	0C0h, 74h, 23h, 8Bh, 0C7h, 2Dh, 4, 0, 0C4h, 5Eh, 12h, 3, 0D8h
	db	26h, 0C6h, 7, 0, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h, 1Eh, 0B8h, 49h
	db	2, 50h, 9Ah, 0Eh, 0, 0CFh, 0, 8Bh, 0C6h, 0E9h, 0BBh, 1, 8Dh, 86h
	db	6Ah, 0FFh, 0A3h, 0D6h, 3, 0C7h, 6, 0D4h, 3, 80h, 0, 8Bh, 46h, 0F0h
	db	0Bh, 46h, 0F2h, 74h, 41h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F0h, 9Ah
	db	9, 0, 7Fh, 0, 89h, 46h, 0EEh, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h
	db	0FFh, 76h, 0F2h, 0FFh, 76h, 0F0h, 9Ah, 0Ah, 0, 0AFh, 0, 8Bh, 46h
	db	0EEh, 1, 46h, 0F8h, 0C4h, 5Eh, 0F8h, 26h, 0C6h, 7, 3Ah, 0FFh, 46h
	db	0F8h, 0C4h, 5Eh, 0F8h, 26h, 0C6h, 7, 3Ah, 0FFh, 46h, 0F8h, 8Bh
	db	46h, 0EEh, '@@)F', 0ECh, 8Bh, 0DEh, 4Bh, 83h, 0FBh, 5, 76h, 3
	db	0E9h, 98h, 0, 0D1h, 0E3h, 2Eh, 0FFh, 0A7h, 0FCh, 0Dh, 0C4h, 5Eh
	db	0F8h, 26h, 0C6h, 7, 7Eh, 0FFh, 46h, 0F8h, 0FFh, 76h, 0FAh, 0FFh
	db	76h, 0F8h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F0h, 9Ah, 0Ah, 0, 0AFh
	db	0, 0EBh, 74h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h, 1Eh, 0B8h, 4Dh
	db	2, 50h, 9Ah, 0Ah, 0, 0AFh, 0, 83h, 46h, 0F8h, 9, 0FFh, 76h, 0FAh
	db	0FFh, 76h, 0F8h, 1Eh, 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 0E8h, 2Ch
	db	0F3h, 50h, 9Ah, 0Ah, 0, 0AFh, 0, 0EBh, 48h, 0FFh, 76h, 0FAh, 0FFh
	db	76h, 0F8h, 1Eh, 0B8h, 57h, 2, 50h, 9Ah, 0Ah, 0, 0AFh, 0, 83h, 46h
	db	0F8h, 9, 83h, 6Eh, 0ECh, 9, 16h, 8Dh, 46h, 0F4h, 50h, 16h, 8Dh
	db	46h, 0F8h, 50h, 16h, 8Dh, 46h, 0ECh, 50h, 33h, 0C0h, 33h, 0D2h
	db	50h, 52h, 0E8h, 0E8h, 0F3h, 0BEh, 5, 0, 0EBh, 13h, 0FFh, 76h, 0FAh
	db	0FFh, 76h, 0F8h, 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h, 9Ah, 0Ah, 0
	db	0AFh, 0, 0EBh, 0, 83h, 7Eh, 6, 0, 75h, 5, 8Bh, 0C6h, 0E9h, 0B7h
	db	0, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h, 9Ah, 9, 0, 7Fh, 0, 1, 46h
	db	0F8h, 8Bh, 46h, 12h, 3, 0C7h, 33h, 0D2h, 2Bh, 46h, 0F8h, 83h, 0DAh
	db	0, 48h, 89h, 46h, 0ECh, 83h, 7Eh, 0ECh, 0, 73h, 5, 0C7h, 46h, 0ECh
	db	0, 0, 0B0h, 0, 88h, 46h, 0EAh, 88h, 46h, 0EBh, 0C4h, 5Eh, 0FCh
	db	26h, 80h, '?xu', 6, 0C6h, 46h, 0EBh, 1, 0EBh, 11h, 0C4h, 5Eh, 0FCh
	db	26h, 80h, '?wu', 6, 0C6h, 46h, 0EAh, 1, 0EBh, 2, 0EBh, 5, 0FFh
	db	46h, 0FCh, 0EBh, 0DBh, 0C4h, 5Eh, 0FCh, 26h, 80h, '?qu', 15h, 0FFh
	db	46h, 0FCh, 16h, 8Dh, 46h, 0FCh, 50h, 16h, 8Dh, 46h, 0F8h, 50h
	db	16h, 8Dh, 46h, 0ECh, 50h, 0E8h, 7Fh, 0F9h, 80h, 7Eh, 0EBh, 0, 74h
	db	19h, 83h, 7Eh, 0ECh, 6, 73h, 3, 0E9h, 55h, 0FEh, 0FFh, 76h, 0FAh
	db	0FFh, 76h, 0F8h, 1Eh, 0B8h, 61h, 2, 50h, 9Ah, 0Eh, 0, 0CFh, 0
	db	80h, 7Eh, 0EAh, 0, 74h, 19h, 83h, 7Eh, 0ECh, 9, 73h, 3, 0E9h, 36h
	db	0FEh, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h, 1Eh, 0B8h, 68h, 2, 50h
	db	9Ah, 0Eh, 0, 0CFh, 0, 8Bh, 0C6h, 0EBh, 0, 5Fh, 5Eh, 8Bh, 0E5h
	db	5Dh, 0CAh, 14h, 0, 1Fh, 0Dh, 0ABh, 0Ch, 0A1h, 0Ch, 0BEh, 0Ch, 0EAh
	db	0Ch, 1Fh, 0Dh, 55h, 8Bh, 0ECh, 56h, 57h, 0FCh, 1Eh, 0C4h, 7Eh
	db	6, 0C5h, 76h, 0Ah, 0ACh, 0AEh, 75h, 4, 0Ah, 0C0h, 75h, 0F8h, '&*E'
	db	0FFh, 98h, 1Fh, '_^]', 0CAh, 8, 0, 55h, 8Bh, 0ECh, 56h, 57h, 0C4h
	db	7Eh, 6, 0B0h, 0, 0B9h, 0FFh, 0FFh, 0FCh, 0F2h, 0AEh, 8Bh, 0C1h
	db	0F7h, 0D0h, 'H_^]', 0CAh, 4, 0, 55h, 8Bh, 0ECh, 8Ah, 46h, 6, 0B4h
	db	0, 8Bh, 0D8h, 0F6h, 87h, 73h, 2, 4, 74h, 0Ah, 8Ah, 46h, 6, 0B4h
	db	0, 5, 20h, 0, 0EBh, 5, 8Ah, 46h, 6, 0B4h, 0, 5Dh, 0CAh, 2, 0, 55h
	db	8Bh, 0ECh, 8Ah, 46h, 6, 0B4h, 0, 8Bh, 0D8h, 0F6h, 87h, 73h, 2
	db	8, 74h, 0Ah, 8Ah, 46h, 6, 0B4h, 0, 5, 0E0h, 0FFh, 0EBh, 5, 8Ah
	db	46h, 6, 0B4h, 0, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 56h, 57h, 0C4h
	db	7Eh, 0Ah, 8Bh, 4Eh, 6, 8Ah, 46h, 8, 8Ah, 0E0h, 0FCh, 0F7h, 0C7h
	db	1, 0, 74h, 4, 0E3h, 9, 0AAh, 49h, 0D1h, 0E9h, 0F3h, 0ABh, 73h
	db	1, 0AAh, 8Bh, 56h, 0Ch, 8Bh, 46h, 0Ah, '_^]', 0CAh, 8, 0, 55h
	db	8Bh, 0ECh, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh
	db	76h, 6, 0FFh, 76h, 8, 0FFh, 76h, 6, 9Ah, 9, 0, 7Fh, 0, 40h, 50h
	db	9Ah, 9, 0, 0BFh, 0, 8Bh, 56h, 0Ch, 8Bh, 46h, 0Ah, 5Dh, 0CAh, 8
	db	0, 55h, 8Bh, 0ECh, 56h, 57h, 8Bh, 7Eh, 6, 0FFh, 76h, 0Ah, 0FFh
	db	76h, 8, 9Ah, 9, 0, 7Fh, 0, 8Bh, 0F0h, 3Bh, 0F7h, 76h, 2, 8Bh, 0F7h
Y0BE20	ends

Y0CC20	segment para public 'CODE'
	assume	cs:Y0CC20
	db	0FFh, 76h, 0Eh, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 56h	;@0CC20
	db	9Ah, 9, 0, 0BFh, 0, 3Bh, 0F7h, 73h, 17h, 8Bh, 56h, 0Eh, 8Bh, 46h
	db	0Ch, 3, 0C6h, 52h, 50h
Y0CC20	ends

Y0CC40	segment para public 'CODE'
	assume	cs:Y0CC40
	db	33h, 0C0h, 50h, 8Bh, 0C7h, 2Bh, 0C6h, 50h, 9Ah, 0Ch, 0, 9Fh, 0	;@0CC40
	db	8Bh, 56h, 0Eh, 8Bh, 46h, 0Ch, '_^]', 0CAh, 0Ah, 0, 55h, 8Bh, 0ECh
	db	56h, 57h, 1Eh, 8Bh
Y0CC40	ends

Y0CC60	segment para public 'CODE'
	assume	cs:Y0CC60
	db	56h, 0Ah, 8Bh, 46h, 8, 3Bh, 56h, 0Eh, 77h, 0Dh, 72h, 5, 3Bh, 46h	;@0CC60
	db	0Ch, 73h, 6, 0FDh, 0B8h, 1, 0, 0EBh, 3, 0FCh, 33h, 0C0h, 0C5h
	db	76h, 8, 0C4h, 7Eh, 0Ch, 8Bh, 4Eh, 6, 0Bh, 0C0h, 74h, 6, 3, 0F1h
	db	4Eh, 3, 0F9h, 4Fh, 0F7h, 0C7h, 1, 0, 74h, 4, 0E3h, 11h, 0A4h, 49h
	db	2Bh, 0F0h, 2Bh, 0F8h, 0D1h, 0E9h, 0F3h, 0A5h, 73h
Y0CC60	ends

Y0CCA0	segment para public 'CODE'
	assume	cs:Y0CCA0
	db	5, 3, 0F0h, 3, 0F8h, 0A4h, 0FCh, 1Fh, '_^]', 0CAh, 0Ah, 0, 55h	;@0CCA0
	db	8Bh, 0ECh, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 9Ah, 9, 0, 7Fh, 0, 8Bh
	db	4Eh, 0Ch, 8Bh, 5Eh, 0Ah, 3, 0D8h, 51h, 53h, 0FFh, 76h, 8, 0FFh
	db	76h, 6, 0FFh, 76h, 8, 0FFh
Y0CCA0	ends

Y0CCD0	segment para public 'CODE'
	assume	cs:Y0CCD0
	db	76h, 6, 9Ah, 9, 0, 7Fh, 0, 40h, 50h, 9Ah, 9, 0, 0BFh, 0, 8Bh, 56h	;@0CCD0
	db	0Ch, 8Bh, 46h, 0Ah, 5Dh, 0CAh, 8, 0, 55h, 8Bh, 0ECh, 56h, 57h
	db	0FFh, 76h, 0Eh, 0FFh, 76h, 0Ch, 9Ah, 9, 0, 7Fh, 0, 8Bh, 0F8h, 0FFh
	db	76h, 0Ah, 0FFh, 76h, 8, 9Ah, 9, 0, 7Fh, 0, 8Bh, 0F0h, 3Bh, 76h
	db	6, 76h, 3, 8Bh, 76h, 6, 8Bh, 56h, 0Eh, 8Bh, 46h, 0Ch, 3, 0C7h
	db	52h, 50h, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 56h, 9Ah, 9, 0, 0BFh, 0
	db	8Bh, 0C7h, 3, 0C6h, 0C4h, 5Eh, 0Ch, 3, 0D8h, 26h, 0C6h, 7, 0, 8Bh
	db	56h, 0Eh, 8Bh, 46h, 0Ch, '_^]', 0CAh, 0Ah, 0, 55h, 8Bh, 0ECh, 0E8h
	db	0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 57h, 0C7h
	db	46h, 0F8h
Y0CCD0	ends

Y0CD50	segment para public 'CODE'
	assume	cs:Y0CD50
	db	0, 0, 8Bh, 1Eh, 38h, 0, 8Bh, 47h, 0Ch, 89h, 46h, 0FEh, 8Bh, 46h	;@0CD50
	db	4, 0BAh, 18h, 0, 0F7h, 0E2h, 3, 46h, 0FEh, 73h, 3, 0E9h, 8Fh, 0
	db	89h, 46h, 0FCh, 0FFh, 36h, 38h, 0, 0FFh, 76h, 0FCh, 0E8h, 5Bh
	db	0Dh, 89h, 46h, 0FAh, 0Bh, 0C0h, 75h, 3, 0EBh, 79h, 90h, 0A3h, 38h
	db	0, 0A1h, 3Ah, 0, 89h, 46h, 0FAh, 83h, 7Eh, 0FAh, 0, 74h, 1Ch, 0EBh
	db	9, 8Bh, 5Eh, 0FAh, 8Bh, 47h, 14h, 89h, 46h, 0FAh, 8Bh, 5Eh, 0FAh
Y0CD50	ends

Y0CDA0	segment para public 'CODE'
	assume	cs:Y0CDA0
	db	83h, 7Fh, 14h, 0, 75h, 0EEh, 8Bh, 46h, 0FEh, 89h, 47h, 14h, 0EBh	;@0CDA0
	db	6, 8Bh, 46h, 0FEh, 0A3h, 3Ah, 0, 8Bh, 46h, 0FEh, 89h, 46h, 0FAh
	db	1Eh, 7, 57h, 8Bh, 4Eh, 0FCh, 2Bh, 4Eh, 0FAh, 8Bh, 7Eh, 0FEh, 33h
	db	0C0h, 0FCh, 0F3h, 0AAh, 5Fh, 0EBh, 10h, 8Bh, 46h, 0FAh, 5, 18h
	db	0, 8Bh, 5Eh, 0FAh, 89h, 47h, 14h, 83h, 46h, 0FAh, 18h, 8Bh, 46h
	db	0FAh, 3Bh, 46h, 0FCh, 72h, 0E8h, 83h, 6Eh, 0FAh, 18h, 8Bh, 5Eh
	db	0FAh, 0C7h, 47h, 14h, 0, 0, 8Bh, 46h, 4, 1, 6, 3Ch, 0, 0EBh, 5
	db	0C7h, 46h, 0F8h, 1, 10h, 8Bh, 46h, 0F8h, 5Fh, 0C9h, 0C2h, 2, 0
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 4, 0C6h, 46h, 0FFh, 0, 1Eh, 2Eh, 8Eh
	db	1Eh, 5Fh, 29h, 83h, 3Eh, 0EAh, 5, 0Ah, 73h, 68h, 0B8h, 5, 10h
	db	0EBh, 6Dh, 90h, 2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Eh, 1Eh, 96h, 3, 0A1h
	db	3Eh
Y0CDA0	ends

Y0CE30	segment para public 'CODE'
	assume	cs:Y0CE30
	db	0, 5, 8, 0, 3Bh, 6, 3Ch, 0, 76h, 48h, 80h, 7Eh, 0FFh, 0, 75h, 7	;@0CE30
	db	6Ah, 14h, 0E8h, 1, 0FFh, 0EBh, 36h, 80h, 7Eh, 0FFh, 1, 75h, 30h
	db	0C7h, 46h, 0FCh, 0, 0, 0EBh, 23h, 2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Bh
	db	5Eh, 0FCh, 0D1h, 0E3h, 8Bh, 8Fh, 96h, 3, 0E3h, 10h, 8Eh, 0D9h
	db	83h, 7Eh, 0FCh, 4, 74h, 8, 6Ah, 0FFh, 6Ah, 0FFh, 0FFh, 16h, 2Ah
	db	0, 0FFh, 46h, 0FCh, 83h, 7Eh, 0FCh, 5, 7Ch, 0D7h, 0FEh, 46h, 0FFh
	db	0EBh, 5, 1Fh, 33h, 0C0h, 0EBh, 0Ah, 80h, 7Eh, 0FFh, 5, 72h, 98h
	db	1Fh, 0B8h, 1, 10h, 0C9h, 0C3h, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 1Eh, 2Eh
	db	8Eh, 1Eh, 5Fh, 29h, 8Eh, 1Eh, 96h, 3, 0A1h, 3Ah, 0, 89h, 46h, 0FEh
	db	8Bh, 5Eh, 0FEh, 8Bh, 47h, 14h, 0A3h, 3Ah, 0, 0C7h, 47h, 14h, 0
	db	0, 0FFh, 0Eh, 3Ch, 0, 1Fh, 8Bh, 46h, 0FEh, 2Bh, 6, 24h, 0, 0C9h
	db	0C3h, 55h, 8Bh, 0ECh, 8Bh, 5Eh, 4, 8Bh, 47h, 8, 8Bh, 5Fh, 0Ah
	db	89h, 47h, 8, 8Bh, 5Eh, 4, 8Bh, 47h, 0Ah, 8Bh, 5Fh, 8, 89h, 47h
	db	0Ah, 1Eh, 0A1h, 24h, 0, 1, 46h, 4, 2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Eh
	db	1Eh, 96h, 3, 8Bh, 5Eh, 4, 33h, 0C0h, 89h, 47h, 12h, 89h, 47h, 8
	db	0A1h, 3Ah, 0, 89h, 47h, 14h, 8Bh, 46h, 4, 0A3h, 3Ah, 0, 0FFh, 6
	db	3Ch, 0, 1Fh, 5Dh, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 6, 57h
	db	0FFh, 36h, 36h, 0, 0E8h, 0BAh, 9, 89h, 46h, 0FEh, 83h, 7Eh, 0FEh
	db	0, 75h, 3, 0EBh, 7Bh, 90h, 0FFh, 76h, 0FEh, 0E8h, 0ACh, 1Eh, 89h
	db	46h, 0FCh, 8Bh, 5Eh, 0FEh, 81h, 4Fh, 0Eh, 0, 80h, 0C6h, 47h, 10h
	db	0, 0C7h, 46h, 0FAh, 0, 0, 0C4h, 5Eh, 0FAh, 8Bh, 46h, 0FCh, 26h
	db	89h, 47h, 2, 8Bh, 46h, 0FCh, 8Bh, 56h, 0FAh, 42h, 42h, 8Bh, 5Eh
	db	0FEh, 89h, 47h, 14h, 89h, 57h, 12h, 0FFh, 76h, 0FEh, 6Ah, 0, 0E8h
	db	99h, 1Bh, 0C4h, 5Eh, 0FAh, 26h, 0C7h, 47h, 4, 0, 0, 0A1h, 34h
	db	0, 26h, 89h, 7, 8Bh, 46h, 0FCh, 0A3h, 34h, 0, 26h, 0C7h, 47h, 6
	db	0Ah, 0, 57h, 0C4h, 7Eh, 0FAh, 8Bh, 16h, 36h, 0, 83h, 0C7h, 8, 0FCh
	db	33h, 0C0h, 0ABh, 8Dh, 45h, 4, 0ABh, 3Bh, 0FAh, 72h, 0F5h, 26h
	db	0C7h, 45h, 0FEh, 0, 0, 5Fh, 8Ch, 0C0h, 0EBh, 2, 33h, 0C0h, 5Fh
	db	0C9h, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 56h, 0C7h, 46h, 0FCh
	db	0, 0, 0A1h, 34h, 0, 0EBh, 10h, 0C4h, 5Eh, 0FCh, 26h, 83h, 7Fh
	db	6, 0, 75h, 1Fh, 0C4h, 5Eh, 0FCh, 26h, 8Bh, 7, 89h, 46h, 0FEh, 83h
	db	7Eh, 0FEh, 0, 75h, 0E7h, 0E8h, 3Ah, 0FFh, 89h, 46h, 0FEh, 0Bh
	db	0C0h, 75h, 6, 33h, 0D2h, 33h, 0C0h, 0EBh, 2Eh, 0C4h, 5Eh, 0FCh
	db	26h, 0FFh, 47h, 4, 8Bh, 46h, 0FEh, 89h, 46h, 0FAh, 26h, 8Bh, 47h
	db	6, 89h, 46h, 0F8h, 6, 0C4h, 76h, 0F8h, 26h, 8Bh, 4, 7, 26h, 89h
	db	47h, 6, 0C4h, 5Eh, 0F8h, 26h, 0C7h, 7, 0, 0, 8Bh, 56h, 0FAh, 8Bh
	db	46h, 0F8h, 5Eh, 0C9h, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ah, 1Eh
	db	2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Eh, 1Eh, 96h, 3, 8Bh, 46h, 6, 89h, 46h
	db	0FEh, 0C7h, 46h, 0FCh, 0, 0, 0C4h, 5Eh, 0FCh, 26h, 8Bh, 47h, 4
	db	48h, 26h, 89h, 47h, 4, 0Bh, 0C0h, 75h, 63h, 8Bh, 46h, 0FEh, 3Bh
	db	6, 34h, 0, 75h, 8, 26h, 8Bh, 7, 0A3h, 34h, 0, 0EBh, 2Dh, 0A1h
	db	34h, 0, 89h, 46h, 0F8h, 0C7h, 46h, 0F6h, 0, 0, 0EBh, 9, 0C4h, 5Eh
	db	0F6h, 26h, 8Bh, 7, 89h, 46h, 0F8h, 0C4h, 5Eh, 0F6h, 26h, 8Bh, 7
	db	3Bh, 46h, 0FEh, 75h, 0ECh, 0C4h, 5Eh, 0FCh, 26h, 8Bh, 7, 0C4h
	db	5Eh, 0F6h, 26h, 89h, 7, 1Eh, 8Eh, 1Eh, 0Ch, 0, 0FFh, 76h, 0FEh
	db	16h, 8Dh, 46h, 0FAh, 50h, 0E8h, 61h, 1Bh, 1Fh, 8Bh, 5Eh, 0FAh
	db	0C4h, 5Fh, 12h, 26h, 0FFh, 37h, 0E8h, 0AEh, 1Dh, 0FFh, 76h, 0FAh
	db	0E8h, 39h, 3, 0EBh, 17h, 0C4h, 5Eh, 0FCh, 26h, 8Bh, 47h, 6, 0C4h
	db	5Eh, 4, 26h, 89h, 7, 0C4h, 5Eh, 0FCh, 8Bh, 46h, 4, 26h, 89h, 47h
	db	6, 1Fh, 0C9h, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 8Bh, 5Eh, 4
	db	8Bh, 47h, 0Ah, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh, 8Bh, 5Fh, 0Ah, 8Bh
	db	46h, 4, 89h, 47h, 8, 8Bh, 5Eh, 4, 8Bh, 5Fh, 8, 8Bh, 46h, 0FEh
	db	89h, 47h, 0Ah, 8Bh, 5Eh, 4, 8Bh, 47h, 8, 8Bh, 5Eh, 0FEh, 89h, 47h
	db	8, 8Bh, 47h, 0Ah, 8Bh, 5Eh, 4, 89h, 47h, 0Ah, 8Bh, 5Eh, 0FEh, 8Bh
	db	46h, 4, 89h, 47h, 0Ah, 8Bh, 5Eh, 4, 8Bh, 46h, 0FEh, 89h, 47h, 8
	db	8Bh, 47h, 2, 8Bh, 17h, 8Bh, 5Eh, 0FEh, 89h, 47h, 2, 89h, 17h, 8Bh
	db	47h, 6, 8Bh, 57h, 4, 8Bh, 5Eh, 4, 1, 17h, 11h, 47h, 2, 0C9h, 0C2h
	db	2, 0, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Bh
	db	5Eh, 8, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3, 83h, 7Eh, 4, 0, 75h, 6, 0E8h
	db	4Dh, 0FDh, 89h, 46h, 4, 8Ch, 0D8h, 8Eh, 0C0h, 2Eh, 8Eh, 1Eh, 5Fh
	db	29h, 8Bh, 5Eh, 0Ah, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3, 8Bh, 76h, 6
	db	8Bh, 7Eh, 4, 83h, 0C6h, 0Eh, 83h, 0C7h, 0Eh, 0B9h, 5, 0, 0FCh
	db	0F3h, 0A5h, 1Fh, 8Bh, 46h, 4, '_^]', 0C2h, 8, 0, 55h, 8Bh, 0ECh
	db	4Ch, 4Ch, 0A1h, 14h, 0, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh, 8Bh, 47h
	db	14h, 8Bh, 5Eh, 4, 89h, 47h, 14h, 8Bh, 46h, 0FEh, 89h, 47h, 12h
	db	8Bh, 5Eh, 0FEh, 8Bh, 46h, 4, 89h, 47h, 14h, 8Bh, 5Eh, 4, 8Bh, 5Fh
	db	14h, 89h, 47h, 12h, 8Bh, 5Eh, 4, 0C7h, 47h, 0Eh, 4, 0, 0FFh, 6
	db	1Ah, 0, 8Bh, 47h, 6, 8Bh, 57h, 4, 1, 16h, 1Ch, 0, 11h, 6, 1Eh
	db	0, 0C9h, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 8Bh, 5Eh, 4, 8Bh, 47h, 12h
	db	8Bh, 5Fh, 14h, 89h, 47h, 12h, 8Bh, 5Eh, 4, 8Bh, 47h, 14h, 8Bh
	db	5Fh, 12h, 89h, 47h, 14h, 0FFh, 0Eh, 1Ah, 0, 8Bh, 5Eh, 4, 8Bh, 47h
	db	6, 8Bh, 57h, 4, 29h, 16h, 1Ch, 0, 19h, 6, 1Eh, 0, 5Dh, 0C2h, 2
	db	0, 55h, 8Bh, 0ECh, 8Bh, 5Eh, 6, 8Bh, 47h, 0Ah, 8Bh, 5Eh, 4, 89h
	db	47h, 0Ah, 8Bh, 46h, 6, 89h, 47h, 8, 8Bh, 5Fh, 0Ah, 8Bh, 46h, 4
	db	89h, 47h, 8, 8Bh, 5Eh, 6, 89h, 47h, 0Ah, 5Dh, 0C2h, 4, 0, 55h
	db	8Bh, 0ECh, 8Bh, 5Eh, 4, 8Bh, 47h, 0Ah, 0A3h, 0Eh, 0, 8Bh, 1Eh
	db	0Eh, 0, 8Bh, 47h, 2, 8Bh, 17h, 8Bh, 1Eh, 16h, 0, 3Bh, 47h, 2, 72h
	db	1Eh, 75h, 4, 3Bh, 17h, 72h, 18h, 8Bh, 1Eh, 0Eh, 0, 8Bh, 47h, 2
	db	8Bh, 17h, 8Bh, 1Eh, 18h, 0, 3Bh, 47h, 2, 72h, 0Ch, 75h, 4, 3Bh
	db	17h, 72h, 6, 0A1h, 16h, 0, 0A3h, 0Eh, 0, 5Dh, 0C2h, 2, 0, 55h
	db	8Bh, 0ECh, 83h, 0ECh, 6, 8Bh, 5Eh, 0Ah, 8Bh, 47h, 6, 8Bh, 57h
	db	4, 2Bh, 56h, 6, 1Bh, 46h, 8, 89h, 46h, 0FEh, 89h, 56h, 0FCh, 8Bh
	db	46h, 0Ah, 89h, 46h, 0FAh, 8Ah, 46h, 4, 0B4h, 0, 0Bh, 0C0h, 75h
	db	6, 0FFh, 76h, 0Ah, 0E8h, 2Eh, 0FFh, 83h, 7Eh, 0FEh, 0, 'rgw', 6
	db	83h, 7Eh, 0FCh, 0, 76h, 5Fh, 0E8h, 0ECh, 0FBh, 89h, 46h, 0FAh
	db	8Bh, 5Eh, 0FAh, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 89h, 47h, 6, 89h
	db	57h, 4, 8Bh, 5Eh, 0Ah, 8Bh, 46h, 8, 8Bh, 56h, 6, 89h, 47h, 6, 89h
	db	57h, 4, 8Bh, 47h, 2, 8Bh, 17h, 3, 56h, 6, 13h, 46h, 8, 8Bh, 5Eh
	db	0FAh, 89h, 47h, 2, 89h, 17h, 0FFh, 76h, 0Ah, 0FFh, 76h, 0FAh, 0E8h
	db	14h, 0FFh, 8Bh, 5Eh, 0FAh, 0C7h, 47h, 0Eh, 4, 0, 8Ah, 46h, 4, 0B4h
	db	0, 0Bh, 0C0h, 75h, 21h, 0FFh, 76h, 0FAh, 0E8h, 7Ch, 0FEh, 8Bh
	db	46h, 0FAh, 0A3h, 20h, 0, 0EBh, 13h, 8Ah, 46h, 4, 0B4h, 0, 0Bh
	db	0C0h, 75h, 0Ah, 8Bh, 1Eh, 14h, 0, 8Bh, 47h, 14h, 0A3h, 20h, 0
	db	8Bh, 5Eh, 0Ah, 0C7h, 47h, 0Eh, 0, 0, 8Eh, 6, 0Ch, 0, 26h, 0A0h
	db	8Eh, 3, 8Bh, 5Eh, 0Ah, 88h, 47h, 10h, 0A0h, 8, 0, 88h, 47h, 17h
	db	0C6h, 47h, 16h, 0, 8Bh, 46h, 0FAh, 0C9h, 0C2h, 8, 0, 55h, 8Bh
	db	0ECh, 4Ch, 4Ch, 8Bh, 5Eh, 4, 8Bh, 5Fh, 8, 0F7h, 47h, 0Eh, 4, 0
	db	74h, 0Bh, 8Bh, 5Eh, 4, 8Bh, 47h, 8, 89h, 46h, 4, 0EBh, 67h, 0EBh
	db	65h, 0FFh, 76h, 0FEh, 0E8h, 62h, 0FEh, 8Bh, 5Eh, 0FEh, 8Bh, 47h
	db	0Ah, 8Bh, 5Eh, 4, 89h, 47h, 0Ah, 8Bh, 5Eh, 0FEh, 8Bh, 5Fh, 0Ah
	db	8Bh, 46h, 4, 89h, 47h, 8, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 6, 8Bh, 57h
	db	4, 8Bh, 5Eh, 4, 1, 57h, 4, 11h, 47h, 6, 8Bh, 5Eh, 0FEh, 8Bh, 47h
	db	6, 8Bh, 57h, 4, 1, 16h, 1Ch, 0, 11h, 6, 1Eh, 0, 8Bh, 46h, 0FEh
	db	3Bh, 6, 0Eh, 0, 75h, 6, 8Bh, 46h, 4, 0A3h, 0Eh, 0, 8Bh, 46h, 0FEh
	db	3Bh, 6, 20h, 0, 75h, 6, 8Bh, 46h, 4, 0A3h, 20h, 0, 0FFh, 76h, 0FEh
	db	0E8h, 3, 0FBh, 8Bh, 5Eh, 4, 8Bh, 47h, 0Ah, 89h, 46h, 0FEh, 8Bh
	db	5Eh, 0FEh, 0F7h, 47h, 0Eh, 4, 0, 75h, 88h, 0C9h, 0C2h, 2, 0, 55h
	db	8Bh, 0ECh, 0FFh, 76h, 4, 0E8h, 96h, 0FDh, 0FFh, 76h, 4, 0E8h, 56h
	db	0FFh, 33h, 0C0h, 5Dh, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 6
	db	8Bh, 5Eh, 4, 8Bh, 47h, 0Eh, 25h, 3, 0, 40h, 40h, 89h, 46h, 0FCh
	db	0C7h, 46h, 0FEh, 3, 0, 0EBh, 5Ah, 8Bh, 5Eh, 4, 0FFh, 77h, 0Ch
	db	6Ah, 0, 0FFh, 76h, 0FEh, 0E8h, 43h, 16h, 83h, 0C4h, 6, 89h, 46h
	db	0FAh, 0Bh, 0C0h, 74h, 3Fh, 8Bh, 5Eh, 4, 80h, 7Fh, 16h, 0, 74h
	db	1Eh, 0FFh, 76h, 4, 6Ah, 4, 0FFh, 77h, 14h, 0FFh, 77h, 12h, 8Bh
	db	47h, 0Eh, 25h, 0, 4, 50h, 0E8h, 0A7h, 25h, 2Eh, 8Eh, 1Eh, 5Fh
	db	29h, 8Eh, 1Eh, 96h, 3, 8Bh, 5Eh, 4, 0FFh, 77h, 2, 0FFh, 37h, 0FFh
	db	76h, 0FAh, 6Ah, 2, 0FFh, 76h, 0FEh, 0E8h, 0FFh, 15h, 83h, 0C4h
	db	0Ah, 0EBh, 0Bh, 0FFh, 4Eh, 0FEh, 8Bh, 46h, 0FEh, 3Bh, 46h, 0FCh
	db	7Dh, 9Eh, 8Bh, 46h, 0FEh, 3Bh, 46h, 0FCh, '|Kj', 0, 0FFh, 76h
	db	0FEh, 0FFh, 76h, 4, 0FFh, 76h, 0FAh, 0E8h, 0A9h, 0FCh, 0FFh, 76h
	db	4, 0E8h, 0F1h, 0FCh, 0FFh, 76h, 4, 0E8h, 0B1h, 0FEh, 2Eh, 8Eh
	db	1Eh, 5Fh, 29h, 8Bh, 5Eh, 0FEh, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3, 8Bh
	db	5Eh, 0FAh, 0A0h, 8, 0, 88h, 47h, 17h, 81h, 4Fh, 0Eh, 80h, 0, 0FFh
	db	76h, 0FAh, 6Ah, 2, 0E8h, 4Fh, 16h, 2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Eh
	db	1Eh, 96h, 3, 33h, 0C0h, 0EBh, 3, 0B8h, 0, 10h, 0C9h, 0C2h, 2, 0
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 4, 0C7h, 46h, 0FCh, 0, 0, 8Bh, 5Eh
	db	4, 80h, 7Fh, 16h, 0, 74h, 13h, 0FFh, 76h, 4, 6Ah, 1, 0FFh, 77h
	db	14h, 0FFh, 77h, 12h, 6Ah, 0, 0E8h, 0FDh, 24h, 89h, 46h, 0FCh, 2Eh
	db	8Eh, 1Eh, 5Fh, 29h, 8Eh, 1Eh, 96h, 3, 83h, 7Eh, 0FCh, 0, 75h, 5Fh
	db	8Bh, 5Eh, 4, 0FFh, 77h, 0Ch, 6Ah, 0, 6Ah, 4, 0E8h, 52h, 15h, 83h
	db	0C4h, 6, 89h, 46h, 0FEh, 0Bh, 0C0h, 'tCj', 0, 6Ah, 4, 0FFh, 76h
	db	4, 0FFh, 76h, 0FEh, 0E8h, 0Bh, 0FCh, 2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Eh
	db	1Eh, 9Eh, 3, 8Bh, 5Eh, 0FEh, 81h, 4Fh, 0Eh, 0, 1, 0A0h, 8, 0, 88h
	db	47h, 17h, 0FFh, 76h, 0FEh, 6Ah, 2, 0E8h, 0C2h, 15h, 2Eh, 8Eh, 1Eh
	db	5Fh, 29h, 8Eh, 1Eh, 96h, 3, 0FFh, 76h, 4, 0E8h, 2Bh, 0FCh, 0FFh
	db	76h, 4, 0E8h, 0EBh, 0FDh, 0EBh, 37h, 0B8h, 0, 10h, 0EBh, 34h, 8Bh
	db	5Eh, 4, 0C4h, 5Fh, 12h, 26h, 0FFh, 37h, 0E8h, 0E2h, 18h, 8Bh, 5Eh
	db	4, 0F7h, 47h, 0Eh, 0, 40h, 74h, 0Bh, 0FFh, 77h, 14h, 0FFh, 77h
	db	12h, 0E8h, 9Bh, 0FAh, 0EBh, 0Bh, 8Bh, 5Eh, 4, 0C4h, 5Fh, 12h, 26h
	db	0C7h, 7, 0, 0, 0FFh, 76h, 4, 0E8h, 4Dh, 0FEh, 33h, 0C0h, 0C9h
	db	0C2h, 2, 0, 55h, 8Bh, 0ECh, 8Bh, 5Eh, 4, 0F7h, 47h, 0Eh, 20h, 0
	db	74h, 0Eh, 0FFh, 76h, 4, 0E8h, 49h, 0FEh, 0Bh, 0C0h, 75h, 4, 33h
	db	0C0h, 0EBh, 1Bh, 8Bh, 5Eh, 4, 0F7h, 47h, 0Eh, 40h, 0, 74h, 0Eh
	db	0FFh, 76h, 4, 0E8h, 8, 0FFh, 0Bh, 0C0h, 75h, 4, 33h, 0C0h, 0EBh
	db	3, 0B8h, 2, 10h, 5Dh, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4
	db	0C6h, 46h, 0FDh, 1, 8Bh, 46h, 8, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh
	db	0F7h, 47h, 0Eh, 1Ch, 80h, 75h, 44h, 0FFh, 76h, 0FEh, 0E8h, 0A6h
	db	0FFh, 0Bh, 0C0h, 75h, 17h, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch, 0, 3Bh
	db	46h, 0Ch, 72h, 0Bh, 75h, 5, 3Bh, 56h, 0Ah, 72h, 4, 33h, 0C0h, 0EBh
	db	46h, 8Bh, 5Eh, 0FEh, 83h, 7Fh, 8, 0, 75h, 1Ah, 0EBh, 9, 8Bh, 5Eh
	db	0FEh, 8Bh, 47h, 0Ah, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh, 83h, 7Fh
	db	8, 0, 74h, 0EEh, 8Bh, 47h, 8, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh, 8Bh
	db	47h, 0Ah, 89h, 46h, 0FEh, 3Bh, 46h, 4, 75h, 0A4h, 80h, 7Eh, 0FDh
	db	0, 74h, 0Ch, 8Bh, 46h, 6, 89h, 46h, 0FEh, 0C6h, 46h, 0FDh, 0, 0EBh
	db	92h, 0B8h, 0, 10h, 0C9h, 0C2h, 0Ah, 0, 55h, 8Bh, 0ECh, 83h, 0ECh
	db	0Ch, 8Bh, 46h, 4, 89h, 46h, 0FEh, 0C7h, 46h, 0FCh, 0, 0, 0C7h
	db	46h, 0FAh, 0, 0, 0EBh, 1Fh, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 8, 89h, 46h
	db	0FEh, 8Bh, 5Eh, 0FEh, 0F7h, 47h, 0Eh, 4, 0, 74h, 0Ch, 8Bh, 47h
	db	6, 8Bh, 57h, 4, 1, 56h, 0FAh, 11h, 46h, 0FCh, 8Bh, 46h, 0FEh, 3Bh
	db	46h, 6, 74h, 12h, 8Bh, 46h, 0FCh, 8Bh, 56h, 0FAh, 3Bh, 46h, 0Ah
	db	72h, 0CEh, 75h, 5, 3Bh, 56h, 8, 72h, 0C7h, 8Bh, 46h, 0FAh, 0Bh
	db	46h, 0FCh, 75h, 3, 0E9h, 0C9h, 0, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 2
	db	8Bh, 17h, 89h, 46h, 0F8h, 89h, 56h, 0F6h, 8Bh, 46h, 0FEh, 89h
	db	46h, 0F4h, 8Bh, 1Eh, 16h, 0, 8Bh, 47h, 8, 0A3h, 16h, 0, 0EBh, 55h
	db	8Bh, 5Eh, 0FEh, 0F7h, 47h, 0Eh, 4, 0, 74h, 17h, 8Bh, 47h, 0Ah
	db	89h, 46h, 0F4h, 0FFh, 76h, 0FEh, 0E8h, 0E2h, 0FAh, 0FFh, 76h, 0FEh
	db	0E8h, 0DCh, 0F7h, 8Bh, 46h, 0F4h, 0EBh, 31h, 8Bh, 5Eh, 0FEh, 8Bh
	db	47h, 2, 8Bh, 17h, 3Bh, 46h, 0F8h, 75h, 5, 3Bh, 56h, 0F6h, 74h
	db	0Dh, 0FFh, 76h, 0FEh, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F6h, 0FFh, 16h
	db	30h, 0, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 6, 8Bh, 57h, 4, 1, 56h, 0F6h
	db	11h, 46h, 0F8h, 8Bh, 47h, 0Ah, 89h, 46h, 0FEh, 8Bh, 46h, 0FEh
	db	3Bh, 46h, 4, 75h, 0A3h, 8Bh, 5Eh, 0FEh, 0FFh, 77h, 8, 0E8h, 61h
	db	0F7h, 50h, 0E8h, 0C2h, 0FAh, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 8, 89h
	db	46h, 0FEh, 8Bh, 5Eh, 0FEh, 8Bh, 46h, 0FCh, 8Bh, 56h, 0FAh, 89h
	db	47h, 6, 89h, 57h, 4, 8Bh, 46h, 0F8h, 8Bh, 56h, 0F6h, 89h, 47h
	db	2, 89h, 17h, 0FFh, 76h, 0FEh, 0E8h, 18h, 0FAh, 8Bh, 46h, 0FEh
	db	0A3h, 0Eh, 0, 8Bh, 46h, 0FEh, 0A3h, 20h, 0, 8Bh, 1Eh, 16h, 0, 8Bh
	db	47h, 0Ah, 0A3h, 16h, 0, 8Bh, 46h, 0FCh, 8Bh, 56h, 0FAh, 3Bh, 46h
	db	0Ah, 77h, 0Bh, 72h, 5, 3Bh, 56h, 8, 73h, 4, 33h, 0C0h, 0EBh, 3
	db	8Bh, 46h, 0FEh, 0C9h, 0C2h, 8, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ch
	db	8Bh, 46h, 6, 89h, 46h, 0FEh, 0C7h, 46h, 0FCh, 0, 0, 0C7h, 46h
	db	0FAh, 0, 0, 0EBh, 1Fh, 8Bh, 5Eh, 0FEh, 0F7h, 47h, 0Eh, 4, 0, 74h
	db	0Ch, 8Bh, 47h, 6, 8Bh, 57h, 4, 1, 56h, 0FAh, 11h, 46h, 0FCh, 8Bh
	db	5Eh, 0FEh, 8Bh, 47h, 0Ah, 89h, 46h, 0FEh, 8Bh, 46h, 0FEh, 3Bh
	db	46h, 4, 74h, 12h, 8Bh, 46h, 0FCh, 8Bh, 56h, 0FAh, 3Bh, 46h, 0Ah
	db	72h, 0CEh, 75h, 5, 3Bh, 56h, 8, 72h, 0C7h, 8Bh, 46h, 0FAh, 0Bh
	db	46h, 0FCh, 75h, 3, 0E9h, 0CCh, 0, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 2
	db	8Bh, 17h, 89h, 46h, 0F8h, 89h, 56h, 0F6h, 8Bh, 46h, 0FEh, 89h
	db	46h, 0F4h, 8Bh, 1Eh, 16h, 0, 8Bh, 47h, 8, 0A3h, 16h, 0, 0EBh, 52h
	db	8Bh, 5Eh, 0FEh, 8Bh, 47h, 8, 89h, 46h, 0F4h, 8Bh, 5Eh, 0F4h, 0F7h
	db	47h, 0Eh, 4, 0, 74h, 0Eh, 0FFh, 76h, 0F4h, 0E8h, 9Dh, 0F9h, 0FFh
	db	76h, 0F4h, 0E8h, 97h, 0F6h, 0EBh, 31h, 8Bh, 5Eh, 0F4h, 8Bh, 47h
	db	6, 8Bh, 57h, 4, 29h, 56h, 0F6h, 19h, 46h, 0F8h, 8Bh, 47h, 2, 8Bh
	db	17h, 3Bh, 46h, 0F8h, 75h, 5, 3Bh, 56h, 0F6h, 74h, 0Dh, 0FFh, 76h
	db	0F4h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F6h, 0FFh, 16h, 32h, 0, 8Bh
	db	46h, 0F4h, 89h, 46h, 0FEh, 8Bh, 46h, 0F4h, 3Bh, 46h, 6, 75h, 0A6h
	db	8Bh, 5Eh, 0FEh, 0FFh, 77h, 8, 0E8h, 22h, 0F6h, 50h, 0E8h, 83h
	db	0F9h, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 8, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh
	db	8Bh, 46h, 0FCh, 8Bh, 56h, 0FAh, 89h, 47h, 6, 89h, 57h, 4, 8Bh
	db	46h, 0F8h, 8Bh, 56h, 0F6h, 2Bh, 56h, 0FAh, 1Bh, 46h, 0FCh, 89h
	db	47h, 2, 89h, 17h, 0FFh, 76h, 0FEh, 0E8h, 0D3h, 0F8h, 8Bh, 46h
	db	0FEh, 0A3h, 0Eh, 0, 8Bh, 46h, 0FEh, 0A3h, 20h, 0, 8Bh, 1Eh, 16h
	db	0, 8Bh, 47h, 0Ah, 0A3h, 16h, 0, 8Bh, 46h, 0FCh, 8Bh, 56h, 0FAh
	db	3Bh, 46h, 0Ah, 77h, 0Bh, 72h, 5, 3Bh, 56h, 8, 73h, 4, 33h, 0C0h
	db	0EBh, 3, 8Bh, 46h, 0FEh, 0C9h, 0C2h, 8, 0, 55h, 8Bh, 0ECh, 83h
	db	0ECh, 6, 0C7h, 46h, 0FEh, 0, 0, 0FFh, 76h, 4, 0E8h, 0D9h, 13h
	db	89h, 56h, 0FCh, 89h, 46h, 0FAh, 0F6h, 6, 9, 0, 4, 74h, 31h, 0A1h
	db	1Eh, 0, 8Bh, 16h, 1Ch, 0, 3Bh, 46h, 0FCh, 'w=r', 5, 3Bh, 56h, 0FAh
	db	73h, 36h, 0FFh, 76h, 0FCh, 0FFh, 76h, 0FAh, 0FFh, 36h, 0Eh, 0
	db	0FFh, 36h, 16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 0AEh, 0FCh, 0Bh, 0C0h
	db	74h, 1Dh, 33h, 0C0h, 0E9h, 0D7h, 0, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch
	db	0, 3Bh, 46h, 0FCh, 77h, 0Ch, 72h, 5, 3Bh, 56h, 0FAh, 73h, 5, 33h
	db	0C0h, 0E9h, 0BFh, 0, 0A1h, 20h, 0, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh
	db	8Bh, 47h, 6, 8Bh, 57h, 4, 3Bh, 46h, 0FCh, 72h, 18h, 75h, 5, 3Bh
	db	56h, 0FAh, 72h, 11h, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh, 0FFh, 76h
	db	0FAh, 6Ah, 0, 0E8h, 0FFh, 0F8h, 0E9h, 81h, 0, 8Bh, 1Eh, 14h, 0
	db	0EBh, 47h, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 6, 8Bh, 57h, 4, 3Bh, 46h
	db	0FCh, 72h, 17h, 75h, 5, 3Bh, 56h, 0FAh, 72h, 10h, 0FFh, 76h, 0FEh
	db	0FFh, 76h, 0FCh, 0FFh, 76h, 0FAh, 6Ah, 0, 0E8h, 0D3h, 0F8h, 0EBh
	db	56h, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 6, 8Bh, 57h, 4, 8Bh, 1Eh, 20h, 0
	db	3Bh, 47h, 6, 72h, 0Dh, 77h, 5, 3Bh, 57h, 4, 76h, 6, 8Bh, 46h, 0FEh
	db	0A3h, 20h, 0, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 14h, 89h, 46h, 0FEh, 8Bh
	db	46h, 0FEh, 3Bh, 6, 14h, 0, 75h, 0AAh, 0FFh, 76h, 0FCh, 0FFh, 76h
	db	0FAh, 0FFh, 16h, 2Ah, 0, 89h, 46h, 0FEh, 0Bh, 0C0h, 74h, 10h, 0FFh
	db	76h, 0FEh, 0FFh, 76h, 0FCh, 0FFh, 76h, 0FAh, 6Ah, 0, 0E8h, 81h
	db	0F8h, 0EBh, 4, 33h, 0C0h, 0EBh, 12h, 8Bh, 5Eh, 0FEh, 8Bh, 46h
	db	4, 89h, 47h, 0Ch, 0FFh, 76h, 0FEh, 0E8h, 26h, 0F8h, 8Bh, 46h, 0FEh
	db	0C9h, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ah, 0FFh, 76h, 4
	db	0E8h, 0B4h, 12h, 89h, 56h, 0FEh, 89h, 46h, 0FCh, 8Bh, 5Eh, 6, 8Bh
	db	47h, 6, 8Bh, 57h, 4, 2Bh, 56h, 0FCh, 1Bh, 46h, 0FEh, 89h, 46h
	db	0FAh, 89h, 56h, 0F8h, 0E8h, 68h, 0F4h, 89h, 46h, 0F6h, 8Bh, 5Eh
	db	0F6h, 8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h, 89h, 47h, 6, 89h, 57h, 4
	db	8Bh, 5Eh, 6, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 89h, 47h, 6, 89h
	db	57h, 4, 8Bh, 47h, 2, 8Bh, 17h, 3, 56h, 0FCh, 13h, 46h, 0FEh, 8Bh
	db	5Eh, 0F6h, 89h, 47h, 2, 89h, 17h, 0FFh, 76h, 6, 0FFh, 76h, 0F6h
	db	0E8h, 90h, 0F7h, 8Bh, 5Eh, 0F6h, 0C7h, 47h, 0Eh, 4, 0, 8Bh, 47h
	db	0Ah, 3Bh, 6, 16h, 0, 75h, 6, 8Bh, 46h, 0F6h, 0A3h, 16h, 0, 0FFh
	db	76h, 0F6h, 0E8h, 0F2h, 0F6h, 0FFh, 76h, 0F6h, 0E8h, 0B2h, 0F8h
	db	8Bh, 5Eh, 6, 8Bh, 46h, 4, 89h, 47h, 0Ch, 0FFh, 76h, 6, 0E8h, 67h
	db	12h, 0C9h, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 8Ah, 46h, 4, 88h, 46h, 4
	db	0FFh, 76h, 8, 8Bh, 5Eh, 6, 0FFh, 77h, 2, 0FFh, 37h, 0FFh, 16h
	db	30h, 0, 0FFh, 76h, 6, 0E8h, 1, 0F6h, 0FFh, 76h, 6, 0E8h, 7Bh, 0F8h
	db	0A1h, 16h, 0, 3Bh, 46h, 6, 75h, 6, 8Bh, 46h, 8, 0A3h, 16h, 0, 5Dh
	db	0C2h, 6, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 14h, 0FFh, 76h, 4, 0E8h
	db	0E1h, 11h, 89h, 56h, 0FEh, 89h, 46h, 0FCh, 8Bh, 5Eh, 6, 8Bh, 46h
	db	0FEh, 8Bh, 56h, 0FCh, 2Bh, 57h, 4, 1Bh, 47h, 6, 89h, 46h, 0FAh
	db	89h, 56h, 0F8h, 0C6h, 46h, 0F5h, 0, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch
	db	0, 3Bh, 46h, 0FAh, 'wKr', 5, 3Bh, 56h, 0F8h, 73h, 44h, 8Bh, 5Eh
	db	6, 8Bh, 47h, 0Ah, 89h, 46h, 0F6h, 3Bh, 6, 18h, 0, 74h, 17h, 0FFh
	db	76h, 0FAh, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F6h, 0FFh, 76h, 0F6h, 0FFh
	db	36h, 18h, 0, 0E8h, 97h, 0FAh, 0Bh, 0C0h, 74h, 1Eh, 0FFh, 76h, 0FAh
	db	0FFh, 76h, 0F8h, 0FFh, 36h, 0Eh, 0, 0FFh, 36h, 16h, 0, 0FFh, 36h
	db	18h, 0, 0E8h, 7Eh, 0FAh, 0Bh, 0C0h, 74h, 5, 33h, 0C0h, 0E9h, 7
	db	3, 8Bh, 5Eh, 6, 8Bh, 47h, 0Ah, 89h, 46h, 0F6h, 8Bh, 5Eh, 0F6h
	db	0F7h, 47h, 0Eh, 4, 0, 74h, 18h, 8Bh, 47h, 6, 8Bh, 57h, 4, 3Bh
	db	46h, 0FAh, 72h, 0Dh, 74h, 3, 0E9h, 6, 2, 3Bh, 56h, 0F8h, 72h, 3
	db	0E9h, 0FEh, 1, 8Bh, 5Eh, 6, 8Bh, 47h, 8, 89h, 46h, 0F6h, 8Bh, 5Eh
	db	0F6h, 0F7h, 47h, 0Eh, 4, 0, 74h, 22h, 8Bh, 47h, 6, 8Bh, 57h, 4
	db	3Bh, 46h, 0FAh, 72h, 17h, 75h, 5, 3Bh, 56h, 0F8h, 72h, 10h, 0FFh
	db	76h, 6, 0FFh, 76h, 0F6h, 8Ah, 46h, 0F5h, 50h, 0E8h, 0EBh, 0FEh
	db	0E9h, 0C9h, 1, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch, 0, 3Bh, 46h, 0FEh
	db	73h, 3, 0E9h, 44h, 1, 75h, 8, 3Bh, 56h, 0FCh, 73h, 3, 0E9h, 3Ah
	db	1, 0A1h, 20h, 0, 89h, 46h, 0F6h, 8Bh, 5Eh, 0F6h, 8Bh, 47h, 6, 8Bh
	db	57h, 4, 3Bh, 46h, 0FEh, 72h, 7, 'uT;V', 0FCh, 73h, 4Fh, 8Bh, 1Eh
	db	14h, 0, 0EBh, 37h, 8Bh, 5Eh, 0F6h, 8Bh, 47h, 6, 8Bh, 57h, 4, 3Bh
	db	46h, 0FEh, 72h, 7, 'u9;V', 0FCh, 73h, 34h, 8Bh, 5Eh, 0F6h, 8Bh
	db	47h, 6, 8Bh, 57h, 4, 8Bh, 1Eh, 20h, 0, 3Bh, 47h, 6, 72h, 0Dh, 77h
	db	5, 3Bh, 57h, 4, 76h, 6, 8Bh, 46h, 0F6h, 0A3h, 20h, 0, 8Bh, 5Eh
	db	0F6h, 8Bh, 47h, 14h, 89h, 46h, 0F6h, 8Bh, 46h, 0F6h, 3Bh, 6, 14h
	db	0, 75h, 0BAh, 0E9h, 0D0h, 0, 0FFh, 76h, 0F6h, 0FFh, 76h, 0FEh
	db	0FFh, 76h, 0FCh, 6Ah, 0, 0E8h, 1Fh, 0F6h, 8Bh, 1Eh, 16h, 0, 8Bh
	db	47h, 8, 0A3h, 16h, 0, 8Bh, 5Eh, 6, 8Bh, 47h, 2, 8Bh, 17h, 89h
	db	46h, 0F2h, 89h, 56h, 0F0h, 8Bh, 47h, 0Ah, 8Bh, 57h, 8, 89h, 46h
	db	0EEh, 89h, 56h, 0ECh, 0FFh, 76h, 6, 8Bh, 5Eh, 0F6h, 0FFh, 77h
	db	2, 0FFh, 37h, 0FFh, 16h, 30h, 0, 8Bh, 5Eh, 0F6h, 8Bh, 46h, 0F2h
	db	8Bh, 56h, 0F0h, 89h, 47h, 2, 89h, 17h, 8Bh, 5Eh, 6, 8Bh, 47h, 6
	db	8Bh, 57h, 4, 8Bh, 5Eh, 0F6h, 89h, 47h, 6, 89h, 57h, 4, 8Bh, 5Eh
	db	6, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 89h, 47h, 6, 89h, 57h, 4, 8Bh
	db	5Eh, 0F6h, 8Bh, 5Fh, 0Ah, 8Bh, 46h, 6, 89h, 47h, 8, 8Bh, 5Eh, 6
	db	8Bh, 5Fh, 0Ah, 8Bh, 46h, 0F6h, 89h, 47h, 8, 8Bh, 5Eh, 0F6h, 8Bh
	db	5Fh, 8, 8Bh, 46h, 6, 89h, 47h, 0Ah, 8Bh, 5Eh, 6, 8Bh, 5Fh, 8, 8Bh
	db	46h, 0F6h, 89h, 47h, 0Ah, 8Bh, 5Eh, 0F6h, 8Bh, 47h, 0Ah, 8Bh, 57h
	db	8, 8Bh, 5Eh, 6, 89h, 47h, 0Ah, 89h, 57h, 8, 8Bh, 5Eh, 0F6h, 8Bh
	db	46h, 0EEh, 8Bh, 56h, 0ECh, 89h, 47h, 0Ah, 89h, 57h, 8, 0FFh, 76h
	db	0F6h, 0E8h, 77h, 0F4h, 0FFh, 76h, 0F6h, 0E8h, 37h, 0F6h, 0E9h
	db	32h, 1, 8Bh, 5Eh, 6, 8Bh, 47h, 0Ah, 89h, 46h, 0F6h, 3Bh, 6, 18h
	db	0, 74h, 17h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F6h
	db	0FFh, 36h, 18h, 0, 0E8h, 6Ah, 0FAh, 89h, 46h, 0F6h, 0Bh, 0C0h
	db	75h, 50h, 8Bh, 46h, 6, 3Bh, 6, 16h, 0, 74h, 26h, 0FFh, 76h, 0FAh
	db	0FFh, 76h, 0F8h, 0FFh, 36h, 16h, 0, 0FFh, 76h, 6, 0E8h, 8, 0F9h
	db	89h, 46h, 0F6h, 0Bh, 0C0h, 74h, 14h, 0FFh, 76h, 6, 0FFh, 76h, 0F6h
	db	8Ah, 46h, 0F5h, 50h, 0E8h, 42h, 0FDh, 0EBh, 21h, 33h, 0C0h, 0E9h
	db	0FAh, 0, 8Bh, 5Eh, 6, 8Bh, 47h, 8, 89h, 46h, 0F6h, 0FFh, 76h, 6
	db	0FFh, 76h, 0F6h, 8Ah, 46h, 0F5h, 50h, 0E8h, 25h, 0FDh, 0FFh, 76h
	db	0F6h, 0E8h, 0BEh, 0F5h, 8Bh, 1Eh, 16h, 0, 8Bh, 47h, 8, 0A3h, 16h
	db	0, 8Bh, 5Eh, 0F6h, 8Bh, 47h, 6, 8Bh, 57h, 4, 3Bh, 46h, 0FAh, 'uH;V'
	db	0F8h, 75h, 43h, 8Bh, 47h, 2, 8Bh, 17h, 8Bh, 1Eh, 16h, 0, 3Bh, 47h
	db	2, 'r-u', 4, 3Bh, 17h, 72h, 27h, 8Bh, 5Eh, 0F6h, 8Bh, 47h, 2, 8Bh
	db	17h, 8Bh, 1Eh, 18h, 0, 3Bh, 47h, 2, 77h, 16h, 72h, 4, 3Bh, 17h
	db	73h, 10h, 0FFh, 76h, 0F6h, 0E8h, 0F7h, 0F3h, 8Bh, 1Eh, 14h, 0
	db	8Bh, 47h, 14h, 0A3h, 20h, 0, 0FFh, 76h, 0F6h, 0E8h, 0E7h, 0F0h
	db	0EBh, 4Dh, 8Bh, 5Eh, 0F6h, 8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h, 29h
	db	57h, 4, 19h, 47h, 6, 1, 17h, 11h, 47h, 2, 8Bh, 47h, 2, 8Bh, 17h
	db	8Bh, 1Eh, 16h, 0, 3Bh, 47h, 2, 'r+u', 4, 3Bh, 17h, 72h, 25h, 8Bh
	db	5Eh, 0F6h, 8Bh, 47h, 2, 8Bh, 17h, 8Bh, 1Eh, 18h, 0, 3Bh, 47h, 2
	db	77h, 14h, 72h, 4, 3Bh, 17h, 73h, 0Eh, 8Bh, 46h, 0FAh, 8Bh, 56h
	db	0F8h, 29h, 16h, 1Ch, 0, 19h, 6, 1Eh, 0, 8Bh, 5Eh, 6, 8Bh, 46h
	db	0FEh, 8Bh, 56h, 0FCh, 89h, 47h, 6, 89h, 57h, 4, 8Bh, 1Eh, 16h
	db	0, 8Bh, 47h, 0Ah, 0A3h, 16h, 0, 8Bh, 5Eh, 6, 8Bh, 46h, 4, 89h
	db	47h, 0Ch, 0FFh, 76h, 6, 0E8h, 0CCh, 0F3h, 0FFh, 76h, 6, 0E8h, 0A7h
	db	0Eh, 8Bh, 46h, 6, 0C9h, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 0E8h
	db	2Ah, 0F0h, 89h, 46h, 0FEh, 8Bh, 1Eh, 12h, 0, 8Bh, 47h, 2, 8Bh
	db	17h, 8Bh, 5Eh, 0FEh, 89h, 47h, 2, 89h, 17h, 8Bh, 46h, 6, 8Bh, 56h
	db	4, 89h, 47h, 6, 89h, 57h, 4, 8Bh, 1Eh, 12h, 0, 0FFh, 77h, 8, 0FFh
	db	76h, 0FEh, 0E8h, 62h, 0F3h, 8Bh, 46h, 6, 8Bh, 56h, 4, 1, 16h, 4
	db	0, 11h, 6, 6, 0, 8Bh, 1Eh, 12h, 0, 1, 17h, 11h, 47h, 2, 0A1h, 18h
	db	0, 3Bh, 6, 12h, 0, 75h, 35h, 0FFh, 76h, 0FEh, 0E8h, 0BBh, 0F2h
	db	0FFh, 76h, 0FEh, 0E8h, 7Bh, 0F4h, 8Bh, 1Eh, 12h, 0, 8Bh, 47h, 8
	db	89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 6, 8Bh, 57h, 4, 8Bh
	db	1Eh, 20h, 0, 3Bh, 47h, 6, 72h, 0Dh, 77h, 5, 3Bh, 57h, 4, 76h, 6
	db	8Bh, 46h, 0FEh, 0A3h, 20h, 0, 8Bh, 46h, 0FEh, 0C9h, 0C2h, 4, 0
	db	55h, 8Bh, 0ECh, 4Ch, 4Ch, 83h, 7Eh, 6, 0, 74h, 1Eh, 8Bh, 46h, 6
	db	0C1h, 0E0h, 3, 8Bh, 16h, 96h, 3, 3, 0D0h, 8Bh, 5Eh, 6, 0D1h, 0E3h
	db	89h, 97h, 96h, 3, 8Bh, 5Eh, 6, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3, 0B8h
	db	5, 0, 2Bh, 46h, 6, 0C1h, 0E0h, 6, 0A3h, 22h, 0, 8Bh, 46h, 6, 0C1h
	db	0E0h, 6, 0A3h, 24h, 0, 8Bh, 46h, 0Eh, 8Bh, 56h, 0Ch, 0A3h, 2, 0
	db	89h, 16h, 0, 0, 8Bh, 46h, 0Ah, 8Bh, 56h, 8, 0A3h, 6, 0, 89h, 16h
	db	4, 0, 8Ah, 46h, 6, 0A2h, 8, 0, 8Bh, 46h, 4, 0A3h, 0Ah, 0, 0C7h
	db	6, 26h, 0, 0A7h, 0Bh, 0C7h, 6, 28h, 0, 0A8h, 6, 0C7h, 6, 0Ch, 0
	db	0A7h, 1, 0E8h, 28h, 0EFh, 89h, 46h, 0FEh, 0A3h, 14h, 0, 8Bh, 5Eh
	db	0FEh, 0A1h, 2, 0, 8Bh, 16h, 0, 0, 89h, 47h, 2, 89h, 17h, 0C7h
	db	47h, 0Eh, 4, 80h, 8Bh, 46h, 0FEh, 89h, 47h, 8, 89h, 47h, 0Ah, 8Bh
	db	46h, 0FEh, 89h, 47h, 12h, 89h, 47h, 14h, 0C7h, 47h, 6, 0, 0, 0C7h
	db	47h, 4, 0, 0, 0E8h, 0EFh, 0EEh, 89h, 46h, 0FEh, 0A3h, 10h, 0, 8Bh
	db	5Eh, 0FEh, 0A1h, 2, 0, 8Bh, 16h, 0, 0, 89h, 47h, 2, 89h, 17h, 0C7h
	db	47h, 0Eh, 0, 80h, 8Bh, 46h, 0FEh, 89h, 47h, 8, 89h, 47h, 0Ah, 0C7h
	db	47h, 6, 0, 0, 0C7h, 47h, 4, 0, 0, 0E8h, 0BFh, 0EEh, 89h, 46h, 0FEh
	db	0A3h, 0Eh, 0, 0A3h, 16h, 0, 8Bh, 5Eh, 0FEh, 0A1h, 2, 0, 8Bh, 16h
	db	0, 0, 89h, 47h, 2, 89h, 17h, 0A1h, 6, 0, 8Bh, 16h, 4, 0, 89h, 47h
	db	6, 89h, 57h, 4, 0FFh, 36h, 10h, 0, 0FFh, 76h, 0FEh, 0E8h, 0F5h
	db	0F1h, 0FFh, 76h, 0FEh, 0E8h, 6Eh, 0F1h, 8Bh, 46h, 0FEh, 0A3h, 20h
	db	0, 0FFh, 76h, 0FEh, 0E8h, 7Eh, 0EEh, 50h, 0E8h, 0DFh, 0F1h, 8Bh
	db	5Eh, 0FEh, 8Bh, 47h, 0Ah, 89h, 46h, 0FEh, 0A3h, 12h, 0, 0A3h, 18h
	db	0, 0A1h, 2, 0, 8Bh, 16h, 0, 0, 3, 16h, 4, 0, 13h, 6, 6, 0, 8Bh
	db	5Eh, 0FEh, 89h, 47h, 2, 89h, 17h, 0C7h, 47h, 6, 0, 0, 0C7h, 47h
	db	4, 0, 0, 0C7h, 47h, 0Eh, 0, 80h, 0C9h, 0C2h, 0Ch, 0, 55h, 8Bh
	db	0ECh, 4Ch, 4Ch, 0E8h, 39h, 0EEh, 89h, 46h, 0FEh, 0FFh, 36h, 10h
	db	0, 0FFh, 76h, 0FEh, 0E8h, 91h, 0F1h, 8Bh, 5Eh, 0FEh, 8Bh, 46h
	db	4, 89h, 47h, 0Ch, 0C6h, 47h, 17h, 4, 0C6h, 47h, 10h, 0, 8Bh, 46h
	db	0FEh, 0C9h, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 0FFh, 76h, 4, 0E8h, 3Ch
	db	0EEh, 33h, 0C0h, 5Dh, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h
	db	1, 8Eh, 0D8h, 8Eh, 1Eh, 96h, 3, 6Ah, 0FFh, 6Ah, 0FFh, 0FFh, 36h
	db	16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 0A6h, 0F5h, 1Fh, 5Dh, 0CBh, 55h
	db	8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 6Ah, 0FFh, 9Ah, 90h
	db	13h, 0DFh, 0, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 83h, 0ECh, 6, 1Eh
	db	0B8h, 0A7h, 1, 8Eh, 0D8h, 8Bh, 46h, 6, 0BAh, 10h, 0, 0F7h, 0E2h
	db	89h, 46h, 0FAh, 89h, 56h, 0FCh, 8Eh, 1Eh, 96h, 3, 8Eh, 6, 0Ch
	db	0, 8Bh, 1Eh, 12h, 0, 8Bh, 7, 26h, 0A3h, 92h, 3, 8Bh, 47h, 2, 26h
	db	0A3h, 94h, 3, 0A1h, 18h, 0, 3Bh, 6, 12h, 0, 74h, 3, 0E9h, 0C4h
	db	0, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch, 0, 3Bh, 46h, 0FCh, 'w-r', 5, 3Bh
	db	56h, 0FAh, 73h, 26h, 0FFh, 76h, 0FCh, 0FFh, 76h, 0FAh, 0FFh, 36h
	db	0Eh, 0, 0FFh, 36h, 16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 0A4h, 0F4h
	db	0Bh, 0C0h, 74h, 0Dh, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch, 0, 89h, 46h
	db	0FCh, 89h, 56h, 0FAh, 0FFh, 76h, 0FCh, 0FFh, 76h, 0FAh, 0FFh, 36h
	db	16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 7, 0F5h, 8Bh, 1Eh, 12h, 0, 8Bh
	db	47h, 8, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh, 0F7h, 47h, 0Eh, 4, 0, 74h
	db	66h, 8Bh, 47h, 6, 8Bh, 57h, 4, 3Bh, 46h, 0FCh, 77h, 1Ch, 75h, 5
	db	3Bh, 56h, 0FAh, 77h, 15h, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 6, 8Bh, 57h
	db	4, 83h, 0EAh, 10h, 1Dh, 0, 0, 89h, 46h, 0FCh, 89h, 56h, 0FAh, 8Bh
	db	46h, 0FCh, 8Bh, 56h, 0FAh, 29h, 16h, 1Ch, 0, 19h, 6, 1Eh, 0, 8Bh
	db	5Eh, 0FEh, 29h, 57h, 4, 19h, 47h, 6, 8Bh, 47h, 2, 8Bh, 17h, 3
	db	57h, 4, 13h, 47h, 6, 8Bh, 1Eh, 12h, 0, 89h, 47h, 2, 89h, 17h, 8Bh
	db	47h, 2, 8Bh, 17h, 2Bh, 16h, 0, 0, 1Bh, 6, 2, 0, 0A3h, 6, 0, 89h
	db	16h, 4, 0, 0A1h, 0, 0, 8Bh, 16h, 2, 0, 3, 6, 4, 0, 13h, 16h, 6
	db	0, 5, 0Fh, 0, 83h, 0D2h, 0, 0D1h, 0EAh, 0D1h, 0D8h, 0D1h, 0EAh
	db	0D1h, 0D8h, 0D1h, 0EAh, 0D1h, 0D8h, 0D1h, 0EAh, 0D1h, 0D8h, 1Fh
	db	0C9h, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 0B8h, 0A7h
	db	1, 8Eh, 0D8h, 8Bh, 46h, 6, 0C7h, 46h, 0FEh, 0, 0, 89h, 46h, 0FCh
	db	0Bh, 46h, 0FEh, 75h, 0Dh, 0A1h, 94h, 3, 8Bh, 16h, 92h, 3, 89h
	db	46h, 0FEh, 89h, 56h, 0FCh, 8Eh, 1Eh, 96h, 3, 8Bh, 1Eh, 12h, 0
	db	8Bh, 47h, 2, 8Bh, 17h, 3Bh, 46h, 0FEh, 77h, 1Bh, 72h, 5, 3Bh, 56h
	db	0FCh, 73h, 14h, 8Bh, 1Eh, 12h, 0, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh
	db	2Bh, 17h, 1Bh, 47h, 2, 50h, 52h, 0E8h, 1Eh, 0FCh, 1Fh, 0C9h, 0CAh
	db	2, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h
	db	0E8h, 0B2h, 0EBh, 0Bh, 0C0h, 75h, 32h, 0C7h, 6, 90h, 3, 0, 0, 8Eh
	db	1Eh, 96h, 3, 0FFh, 76h, 6, 0E8h, 6Dh, 0F6h, 89h, 46h, 0FEh, 0Bh
	db	0C0h, 74h, 1Bh, 8Bh, 5Eh, 0FEh, 8Bh, 46h, 0Ah, 8Bh, 56h, 8, 89h
	db	47h, 14h, 89h, 57h, 12h, 0FFh, 76h, 0FEh, 6Ah, 1, 0E8h, 77h, 8
	db	33h, 0C0h, 0EBh, 12h, 0B8h, 0A7h, 1, 8Eh, 0D8h, 0C7h, 6, 90h, 3
	db	0, 10h, 0FFh, 1Eh, 0EEh, 5, 0B8h, 0, 10h, 1Fh, 0C9h, 0CAh, 6, 0
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 6, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 0E8h
	db	56h, 0EBh, 0Bh, 0C0h, 75h, 5Eh, 0C7h, 6, 90h, 3, 0, 0, 8Eh, 1Eh
	db	96h, 3, 0E8h, 0E5h, 0ECh, 89h, 56h, 0FCh, 89h, 46h, 0FAh, 0Bh
	db	46h, 0FCh, 74h, 46h, 0FFh, 76h, 6, 0E8h, 3, 0F6h, 89h, 46h, 0FEh
	db	0Bh, 0C0h, 74h, 27h, 8Bh, 5Eh, 0FEh, 8Bh, 46h, 0FCh, 8Bh, 56h
	db	0FAh, 89h, 47h, 14h, 89h, 57h, 12h, 0FFh, 76h, 0FEh, 6Ah, 1, 0E8h
	db	0Dh, 8, 8Bh, 5Eh, 0FEh, 81h, 4Fh, 0Eh, 0, 40h, 8Bh, 56h, 0FCh
	db	8Bh, 46h, 0FAh, 0EBh, 25h, 2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Eh, 1Eh, 96h
	db	3, 0FFh, 76h, 0FCh, 0FFh, 76h, 0FAh, 0E8h, 0FFh, 0ECh, 0B8h, 0A7h
	db	1, 8Eh, 0D8h, 0C7h, 6, 90h, 3, 0, 10h, 0FFh, 1Eh, 0EEh, 5, 33h
	db	0D2h, 33h, 0C0h, 1Fh, 0C9h, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh
	db	4, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 0C4h, 5Eh, 6, 26h, 0FFh, 37h
	db	16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 0A7h, 8, 89h, 46h, 0FCh, 83h, 7Eh
	db	0FCh, 5, 7Dh, 3Ah, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3
	db	0C4h, 5Eh, 6, 26h, 0FFh, 37h, 0E8h, 0E6h, 0Ah, 8Bh, 5Eh, 0FEh
	db	0F7h, 47h, 0Eh, 0, 40h, 74h, 0Bh, 0FFh, 76h, 8, 0FFh, 76h, 6, 0E8h
	db	9Fh, 0ECh, 0EBh, 8, 0C4h, 5Eh, 6, 26h, 0C7h, 7, 0, 0, 0FFh, 76h
	db	0FEh, 0FFh, 16h, 28h, 0, 33h, 0C0h, 0EBh, 0Dh, 0C7h, 6, 90h, 3
	db	2, 10h, 0FFh, 1Eh, 0EEh, 5, 0B8h, 2, 10h, 1Fh, 0C9h, 0CAh, 4, 0
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 6, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 80h
	db	7Eh, 6, 0, 75h, 5, 0A0h, 8Eh, 3, 0EBh, 3, 8Ah, 46h, 6, 88h, 46h
	db	0FFh, 0C7h, 46h, 0FCh, 0, 0, 0E9h, 97h, 0, 8Bh, 5Eh, 0FCh, 0D1h
	db	0E3h, 8Bh, 8Fh, 96h, 3, 0E3h, 2, 0EBh, 3, 0E9h, 84h, 0, 8Eh, 0D9h
	db	8Bh, 1Eh, 10h, 0, 0EBh, 68h, 8Bh, 5Eh, 0FAh, 0F7h, 47h, 0Eh, 4
	db	0, 75h, 5Bh, 8Ah, 47h, 10h, 3Ah, 46h, 0FFh, 75h, 53h, 0C4h, 5Fh
	db	12h, 26h, 0FFh, 37h, 0E8h, 54h, 0Ah, 8Bh, 5Eh, 0FAh, 0F7h, 47h
	db	0Eh, 0, 40h, 74h, 0Bh, 0FFh, 77h, 14h, 0FFh, 77h, 12h, 0E8h, 0Dh
	db	0ECh, 0EBh, 0Bh, 8Bh, 5Eh, 0FAh, 0C4h, 5Fh, 12h, 26h, 0C7h, 7
	db	0, 0, 0FFh, 76h, 0FAh, 0FFh, 16h, 28h, 0, 8Bh, 5Eh, 0FAh, 83h
	db	7Fh, 8, 0, 75h, 1Ah, 0EBh, 9, 8Bh, 5Eh, 0FAh, 8Bh, 47h, 0Ah, 89h
	db	46h, 0FAh, 8Bh, 5Eh, 0FAh, 83h, 7Fh, 8, 0, 74h, 0EEh, 8Bh, 47h
	db	8, 89h, 46h, 0FAh, 8Bh, 5Eh, 0FAh, 8Bh, 47h, 0Ah, 89h, 46h, 0FAh
	db	8Bh, 46h, 0FAh, 3Bh, 6, 12h, 0, 75h, 89h, 0B8h, 0A7h, 1, 8Eh, 0D8h
	db	0FFh, 46h, 0FCh, 83h, 7Eh, 0FCh, 5, 7Dh, 3, 0E9h, 60h, 0FFh, 1Fh
	db	0C9h, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 0B8h, 0A7h
	db	1, 8Eh, 0D8h, 0C4h, 5Eh, 0Ah, 26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh
	db	50h, 0E8h, 6Eh, 7, 89h, 46h, 0FCh, 83h, 7Eh, 0FCh, 5, 7Dh, 26h
	db	0C7h, 6, 90h, 3, 0, 0, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 96h
	db	3, 0FFh, 76h, 8, 0FFh, 76h, 6, 0E8h, 60h, 15h, 8Bh, 5Eh, 0FEh
	db	88h, 47h, 16h, 0Ah, 0C0h, 74h, 4, 33h, 0C0h, 0EBh, 9, 0C7h, 6
	db	90h, 3, 2, 10h, 0B8h, 2, 10h, 1Fh, 0C9h, 0CAh, 8, 0, 55h, 8Bh
	db	0ECh, 83h, 0ECh, 4, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 0C4h, 5Eh, 6
	db	26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 17h, 7, 89h, 46h
	db	0FCh, 83h, 7Eh, 0FCh, 0, 75h, 22h, 0E8h, 26h, 0E9h, 0Bh, 0C0h
	db	75h, 1Bh, 0C7h, 6, 90h, 3, 0, 0, 1Eh, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h
	db	8Eh, 9Fh, 96h, 3, 0FFh, 76h, 0FEh, 0E8h, 0C8h, 0EFh, 1Fh, 33h
	db	0C0h, 0EBh, 9, 0C7h, 6, 90h, 3, 0, 10h, 0B8h, 0, 10h, 1Fh, 0C9h
	db	0CAh, 4, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 6, 1Eh, 0B8h, 0A7h, 1, 8Eh
	db	0D8h, 0C4h, 5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h
	db	0C4h, 6, 89h, 46h, 0FCh, 0C7h, 46h, 0FAh, 0, 10h, 83h, 7Eh, 0FCh
	db	0, 75h, 2Bh, 0E8h, 0CEh, 0E8h, 0Bh, 0C0h, 75h, 24h, 1Eh, 8Bh, 5Eh
	db	0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3, 8Bh, 5Eh, 0FEh, 83h, 7Fh, 0Ch
	db	0, 74h, 0Bh, 0FFh, 76h, 0FEh, 0E8h, 96h, 0EEh, 89h, 46h, 0FAh
	db	0EBh, 5, 0C7h, 46h, 0FAh, 0, 0, 1Fh, 8Bh, 46h, 0FAh, 0A3h, 90h
	db	3, 8Bh, 46h, 0FAh, 1Fh, 0C9h, 0CAh, 4, 0, 55h, 8Bh, 0ECh, 83h
	db	0ECh, 4, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 0C4h, 5Eh, 6, 26h, 0FFh
	db	37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 63h, 6, 89h, 46h, 0FCh, 8Bh
	db	5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3, 8Bh, 5Eh, 0FEh, 8Bh, 47h
	db	0Eh, 1Fh, 0C9h, 0CAh, 4, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 6, 0B8h
	db	0A7h, 1, 8Eh, 0D8h, 8Eh, 1Eh, 96h, 3, 0FFh, 76h, 8, 0E8h, 21h
	db	0F3h, 89h, 46h, 0FEh, 83h, 7Eh, 0FEh, 0, 75h, 3, 0E9h, 8Fh, 0
	db	8Bh, 5Eh, 0FEh, 8Bh, 46h, 0Ch, 8Bh, 56h, 0Ah, 89h, 47h, 14h, 89h
	db	57h, 12h, 8Bh, 46h, 0Eh, 25h, 0, 6, 9, 47h, 0Eh, 83h, 7Eh, 4, 0
	db	74h, 69h, 8Bh, 47h, 2, 8Bh, 17h, 89h, 46h, 0FCh, 89h, 56h, 0FAh
	db	1Eh, 2Eh, 8Eh, 1Eh, 5Fh, 29h, 8Bh, 5Eh, 6, 0D1h, 0E3h, 8Eh, 9Fh
	db	96h, 3, 8Bh, 5Eh, 4, 8Bh, 47h, 0Ch, 3Bh, 46h, 8, 76h, 6, 8Bh, 46h
	db	8, 89h, 47h, 0Ch, 0FFh, 76h, 6, 6Ah, 0, 0FFh, 76h, 4, 0FFh, 76h
	db	0FEh, 0E8h, 10h, 0EBh, 0FFh, 76h, 4, 0FFh, 76h, 0FCh, 0FFh, 76h
	db	0FAh, 0FFh, 16h, 2Eh, 0, 0FFh, 76h, 4, 0FFh, 16h, 28h, 0, 1Fh
	db	8Bh, 5Eh, 0FEh, 81h, 67h, 0Eh, 0FFh, 0DFh, 0C6h, 47h, 17h, 0, 81h
	db	67h, 0Eh, 7Fh, 0FEh, 0FFh, 76h, 0FEh, 6Ah, 4, 0E8h, 0B8h, 4, 0EBh
	db	8, 0FFh, 76h, 0FEh, 6Ah, 1, 0E8h, 0AEh, 4, 8Bh, 46h, 0FEh, 0C9h
	db	0C2h, 0Ch, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ch, 1Eh, 0B8h, 0A7h
	db	1, 8Eh, 0D8h, 0C7h, 46h, 0F8h, 0, 0, 0C7h, 6, 90h, 3, 0, 0, 0E8h
	db	96h, 0E7h, 89h, 46h, 0F8h, 0Bh, 0C0h, 74h, 1Bh, 0F7h, 46h, 0Eh
	db	18h, 78h, 74h, 14h, 81h, 7Eh, 0F8h, 5, 10h, 74h, 3, 0E9h, 0E8h
	db	1, 0F7h, 46h, 0Eh, 0, 48h, 74h, 3, 0E9h, 0DEh, 1, 0C7h, 46h, 0F8h
	db	0, 0, 83h, 66h, 0Eh, 0E7h, 0F7h, 46h, 0Eh, 0, 48h, 74h, 16h, 0C7h
	db	46h, 0FAh, 0, 0, 8Eh, 1Eh, 96h, 3, 0C7h, 46h, 0FEh, 0, 0, 8Bh
	db	46h, 0Ch, 21h, 46h, 0Eh, 0EBh, 43h, 0C4h, 5Eh, 8, 26h, 0FFh, 37h
	db	16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 25h, 5, 89h, 46h, 0FAh, 83h, 7Eh
	db	0FAh, 5, 7Ch, 8, 0C7h, 46h, 0F8h, 2, 10h, 0E9h, 99h, 1, 8Bh, 5Eh
	db	0FAh, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 0Eh
	db	8Bh, 56h, 0Ch, 0F7h, 0D2h, 23h, 0C2h, 25h, 0FFh, 87h, 8Bh, 56h
	db	0Eh, 23h, 56h, 0Ch, 0Bh, 0D0h, 89h, 56h, 0Eh, 0F7h, 46h, 0Eh, 4
	db	0, 74h, 30h, 0C4h, 5Eh, 8, 26h, 0FFh, 37h, 0E8h, 3Ah, 7, 8Bh, 5Eh
	db	0FEh, 0F7h, 47h, 0Eh, 0, 40h, 74h, 0Bh, 0FFh, 76h, 0Ah, 0FFh, 76h
	db	8, 0E8h, 0F3h, 0E8h, 0EBh, 8, 0C4h, 5Eh, 8, 26h, 0C7h, 7, 0, 0
	db	0FFh, 76h, 0FEh, 0FFh, 16h, 28h, 0, 0E9h, 3Eh, 1, 0F7h, 46h, 0Eh
	db	0, 'Ht"', 0FFh, 76h, 0Eh, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h
	db	6, 6Ah, 0, 6Ah, 0, 0E8h, 53h, 0FEh, 89h, 46h, 0FEh, 0Bh, 0C0h
	db	75h, 8, 0C7h, 46h, 0F8h, 0, 10h, 0E9h, 15h, 1, 0A0h, 9, 0, 0B4h
	db	0, 0A9h, 4, 0, 75h, 74h, 0F7h, 46h, 0Eh, 0, 10h, 74h, 0Dh, 8Bh
	db	46h, 6, 89h, 46h, 0F6h, 81h, 66h, 0Eh, 0FFh, 0EFh, 0EBh, 9, 8Bh
	db	5Eh, 0FEh, 8Bh, 47h, 0Ch, 89h, 46h, 0F6h, 0FFh, 76h, 0Eh, 0FFh
	db	76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 0F6h, 0FFh, 76h, 0FAh, 0FFh
	db	76h, 0FEh, 0E8h, 8, 0FEh, 89h, 46h, 0FEh, 0Bh, 0C0h, 75h, 8, 0C7h
	db	46h, 0F8h, 0, 10h, 0E9h, 0CAh, 0, 8Bh, 5Eh, 0FEh, 80h, 7Fh, 16h
	db	0, 74h, 2Ah, 83h, 7Eh, 0FAh, 4, 75h, 7, 0FFh, 76h, 0FEh, 6Ah, 2
	db	0EBh, 5, 0FFh, 76h, 0FEh, 6Ah, 5, 0FFh, 76h, 0Ah, 0FFh, 76h, 8
	db	0C4h, 5Eh, 8, 26h, 0FFh, 37h, 0E8h, 13h, 12h, 2Eh, 8Eh, 1Eh, 5Fh
	db	29h, 8Eh, 1Eh, 96h, 3, 0F7h, 46h, 0Eh, 0, 10h, 74h, 7Eh, 0FFh
	db	76h, 6, 0E8h, 0D9h, 4, 8Bh, 5Eh, 0FEh, 2Bh, 47h, 4, 1Bh, 57h, 6
	db	89h, 56h, 0F6h, 89h, 46h, 0F4h, 83h, 7Eh, 0F6h, 0, 7Fh, 13h, 7Ch
	db	6, 83h, 7Eh, 0F4h, 0, 73h, 0Bh, 0FFh, 76h, 0FEh, 0FFh, 76h, 6
	db	0E8h, 0F3h, 0F1h, 0EBh, 50h, 83h, 7Eh, 0F6h, 0, 7Ch, 3Bh, 7Fh
	db	6, 83h, 7Eh, 0F4h, 0, 76h, 33h, 8Bh, 5Eh, 0FEh, 81h, 4Fh, 0Eh
	db	0, 80h, 0FFh, 76h, 0FEh, 0FFh, 76h, 6, 0E8h, 0A5h, 0F2h, 89h, 46h
	db	0FCh, 0Bh, 0C0h, 74h, 6, 8Bh, 46h, 0FCh, 89h, 46h, 0FEh, 8Bh, 5Eh
	db	0FEh, 81h, 67h, 0Eh, 0FFh, 7Fh, 83h, 7Eh, 0FCh, 0, 75h, 16h, 0C7h
	db	46h, 0F8h, 0, 10h, 0EBh, 21h, 8Bh, 5Eh, 0FEh, 8Bh, 46h, 6, 89h
	db	47h, 0Ch, 0FFh, 76h, 0FEh, 0E8h, 0A1h, 4, 8Bh, 5Eh, 0FEh, 8Bh
	db	47h, 0Eh, 31h, 46h, 0Eh, 8Bh, 46h, 0Eh, 25h, 7Bh, 2, 31h, 47h
	db	0Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 8Bh, 46h, 0F8h, 0A3h, 90h, 3, 83h
	db	7Eh, 0F8h, 0, 74h, 4, 0FFh, 1Eh, 0EEh, 5, 8Bh, 46h, 0F8h, 1Fh
	db	0C9h, 0CAh, 0Ah, 0, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h
	db	55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 8Ah, 46h, 6, 0A2h
	db	8Eh, 3, 1Fh, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h
	db	1, 8Eh, 0D8h, 0A0h, 8Eh, 3, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 56h
	db	1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 0FCh, 8Dh, 16h, 0C6h, 3, 8Dh, 36h
	db	0A6h, 3, 0ADh, 3Dh, 0FFh, 0FFh, 74h, 9, 0B9h, 10h, 0, 0D1h, 0C8h
	db	73h, 0Ah, 0E2h, 0FAh, 3Bh, 0F2h, 72h, 0EDh, 0B0h, 0, 0EBh, 1Ah
	db	0Dh, 0, 80h, 8Bh, 0D9h, 49h, 0D3h, 0C8h, 89h, 44h, 0FEh, 81h, 0EEh
	db	0A8h, 3, 0B1h, 3, 0D3h, 0E6h, 8Bh, 0C6h, 5, 10h, 0, 2Bh, 0C3h
	db	1Fh, 5Eh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h
	db	8Ah, 46h, 6, 50h, 9Ah, 6Bh, 16h, 0DFh, 0, 8Ah, 5Eh, 6, 32h, 0FFh
	db	8Bh, 0CBh, 80h, 0E1h, 7, 0B0h, 0FEh, 0D2h, 0C0h, 0B1h, 3, 0D3h
	db	0EBh, 20h, 87h, 0A6h, 3, 1Fh, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh
	db	83h, 0ECh, 4, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 0C4h, 5Eh, 6, 26h
	db	0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 0A4h, 2, 89h, 46h, 0FCh
	db	8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 96h, 3, 8Bh, 5Eh, 0FEh, 8Bh
	db	47h, 0Ch, 1Fh, 0C9h, 0CAh, 4, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 1Eh
	db	0B8h, 0A7h, 1, 8Eh, 0D8h, 0C4h, 5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh
	db	46h, 0FEh, 50h, 0E8h, 74h, 2, 3Dh, 4, 0, 75h, 5, 0B8h, 1, 0, 0EBh
	db	2, 33h, 0C0h, 1Fh, 0C9h, 0CAh, 4, 0, 55h, 8Bh, 0ECh, 0E8h, 0FAh
	db	0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h
	db	0C6h, 6, 8Eh, 3, 0, 8Bh, 46h, 0Ch, 8Bh, 56h, 0Ah, 0A3h, 0F0h, 5
	db	89h, 16h, 0EEh, 5, 0C6h, 6, 0D2h, 3, 1, 90h, 'TX;', 0C4h, 75h
	db	32h, 0FEh, 6, 0D2h, 3, 1Eh, 0B8h, 6, 35h, 0CDh, 21h, 6, 53h, 0Eh
	db	1Fh, 0BAh, 0AFh, 1Ch, 0B8h, 6, 25h, 0CDh, 21h, 9Ch, 66h, 8Bh, 0C3h
	db	2Eh, 8Eh, 1Eh, 5Fh, 29h, 0FEh, 6, 0D2h, 3, 83h, 0ECh, 6, 83h, 0C4h
	db	6, 9Dh, 5Ah, 1Fh, 0B8h, 6, 25h, 0CDh, 21h, 1Fh, 0C7h, 6, 90h, 3
	db	2, 10h, 0FFh, 76h, 12h, 0FFh, 76h, 10h, 68h, 9Dh, 0Ah, 0FFh, 76h
	db	0Eh, 0E8h, 61h, 6, 0Bh, 0C0h, 74h, 5, 0B8h, 2, 10h, 0EBh, 0Fh
	db	0E8h, 0A6h, 8, 0C7h, 46h, 8, 0, 0, 0C7h, 46h, 6, 0, 0, 33h, 0C0h
	db	1Fh, 5Dh, 0CAh, 0Eh, 0, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh
	db	0D8h, 83h, 3Eh, 9Ch, 3, 0, 74h, 3, 0E8h, 21h, 0Ch, 1Fh, 5Dh, 0CBh
	db	55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 0A1h, 90h, 3, 1Fh
	db	5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 8Eh
	db	1Eh, 96h, 3, 8Bh, 16h, 1Eh, 0, 0A1h, 1Ch, 0, 1Fh, 5Dh, 0CBh, 55h
	db	8Bh, 0ECh, 83h, 0ECh, 4, 0C7h, 46h, 0FEh, 0, 0, 0C7h, 46h, 0FCh
	db	0FFh, 0, 8Ch, 0D8h, 3Dh, 0A7h, 1, 74h, 0Dh, 0A0h, 8, 0, 0B4h, 0
	db	89h, 46h, 0FCh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 8Bh, 5Eh, 4, 0D1h, 0E3h
	db	83h, 0BFh, 96h, 3, 0, 74h, 53h, 8Bh, 5Eh, 4, 0D1h, 0E3h, 8Eh, 9Fh
	db	96h, 3, 8Bh, 5Eh, 6, 83h, 0FBh, 3, 77h, 3Dh, 0D1h, 0E3h, 2Eh, 0FFh
	db	0A7h, 0C7h, 1Dh, 0FFh, 76h, 8, 0FFh, 16h, 26h, 0, 89h, 46h, 0FEh
	db	0EBh, 2Fh, 0FFh, 76h, 8, 0FFh, 16h, 28h, 0, 89h, 46h, 0FEh, 0EBh
	db	23h, 0FFh, 76h, 8, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 16h, 2Ch
	db	0, 0EBh, 0Fh, 0FFh, 76h, 8, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh
	db	16h, 2Eh, 0, 0EBh, 0, 0C7h, 46h, 0FEh, 0, 0, 0B8h, 0A7h, 1, 8Eh
	db	0D8h, 81h, 7Eh, 0FCh, 0FFh, 0, 74h, 9, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h
	db	8Eh, 9Fh, 96h, 3, 8Bh, 46h, 0FEh, 0C9h, 0C3h, 0, 71h, 1Dh, 7Dh
	db	1Dh, 89h, 1Dh, 98h, 1Dh, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 56h, 0F6h
	db	46h, 4, 1, 74h, 0Bh, 0FFh, 76h, 6, 0E8h, 0C9h, 2, 89h, 46h, 0FEh
	db	0EBh, 1Fh, 8Bh, 5Eh, 6, 0C4h, 5Fh, 12h, 26h, 8Bh, 7, 89h, 46h
	db	0FEh, 89h, 46h, 0FCh, 81h, 7Eh, 0FEh, 0, 10h, 73h, 0Ch, 8Bh, 46h
	db	0FEh, 0C1h, 0E0h, 3, 5, 7, 10h, 89h, 46h, 0FCh, 0F6h, 46h, 4, 2
	db	74h, 30h, 8Eh, 6, 0Ch, 0, 26h, 8Eh, 6, 0CCh, 3, 8Bh, 5Eh, 0FCh
	db	83h, 0E3h, 0F8h, 26h, 80h, 67h, 5, 7Fh, 8Bh, 5Eh, 6, 0F7h, 47h
	db	0Eh, 0, 4, 74h, 3, 0EBh, 5Ch, 90h, 8Bh, 46h, 0FCh, 2Dh, 7, 10h
	db	0C1h, 0E8h, 3, 89h, 46h, 0FEh, 0EBh, 4Dh, 90h, 0F6h, 46h, 4, 4
	db	75h, 3, 0EBh, 44h, 90h, 8Bh, 46h, 0FCh, 89h, 46h, 0FEh, 8Eh, 6
	db	0Ch, 0, 26h, 8Eh, 6, 0CCh, 3, 8Bh, 5Eh, 0FCh, 83h, 0E3h, 0F8h
	db	26h, 80h, 4Fh, 5, 80h, 56h, 8Bh, 76h, 6, 8Bh, 4, 8Bh, 54h, 2, 26h
	db	89h, 47h, 2, 26h, 88h, 57h, 4, 8Bh, 4Ch, 0Ch, 0B0h, 0F7h, 0E3h
	db	9, 83h, 0C1h, 1, 0F5h, 83h, 0D9h, 1, 0B0h, 0FFh, '& G', 5, 26h
	db	89h, 0Fh, 5Eh, 8Bh, 5Eh, 6, 0C4h, 5Fh, 12h, 8Bh, 46h, 0FEh, 26h
	db	89h, 7, 8Eh, 6, 0Ch, 0, 26h, 8Eh, 6, 0D0h, 3, 8Bh, 5Eh, 0FCh, 83h
	db	0E3h, 0F8h, 0A0h, 8, 0, 32h, 0E4h, 0Dh, 0, 80h, 26h, 89h, 7, 8Bh
	db	46h, 6, 26h, 89h, 47h, 6, 5Eh, 0C9h, 0C2h, 4, 0, 55h, 8Bh, 0ECh
	db	81h, 7Eh, 8, 0, 10h, 73h, 0Ch, 8Bh, 46h, 8, 0C1h, 0E0h, 3, 5, 7
	db	10h, 89h, 46h, 8, 8Eh, 6, 0D0h, 3, 8Bh, 5Eh, 8, 83h, 0E3h, 0F8h
	db	26h, 8Bh, 4Fh, 6, 26h, 8Bh, 7, 25h, 7, 0, 0C4h, 5Eh, 4, 26h, 89h
	db	0Fh, 5Dh, 0C2h, 6, 0, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh
	db	0D8h, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 6, 0E8h, 0B7h, 0FFh
	db	1Fh, 5Dh, 0CAh, 6, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 0B8h
	db	0A7h, 1, 8Eh, 0D8h, 0FFh, 76h, 6, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h
	db	9Bh, 0FFh, 89h, 46h, 0FCh, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh
	db	96h, 3, 8Bh, 5Eh, 0FEh, 8Bh, 57h, 14h, 8Bh, 47h, 12h, 1Fh, 0C9h
	db	0CAh, 2, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 8Bh, 1Eh, 14h, 0, 8Bh, 47h
	db	14h, 89h, 46h, 0FEh, 3Bh, 6, 14h, 0, 75h, 4, 33h, 0C0h, 0EBh, 38h
	db	8Bh, 5Eh, 0FEh, 8Bh, 47h, 14h, 3Bh, 6, 14h, 0, 75h, 1Bh, 8Bh, 47h
	db	6, 8Bh, 57h, 4, 3Bh, 46h, 6, 72h, 0Ch, 75h, 5, 3Bh, 56h, 4, 72h
	db	5, 8Bh, 46h, 0FEh, 0EBh, 15h, 33h, 0C0h, 0EBh, 11h, 0FFh, 76h
	db	6, 0FFh, 76h, 4, 0FFh, 36h, 16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 93h
	db	0E9h, 0C9h, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 8Bh, 46h, 4, 33h, 0D2h
	db	5, 0FFh, 0FFh, 0F5h, 15h, 1, 0, 8Bh, 1Eh, 0Ah, 0, 3, 0C3h, 83h
	db	0D2h, 0, 0F7h, 0D3h, 23h, 0C3h, 5Dh, 0C2h, 2, 0, 55h, 8Bh, 0ECh
	db	8Bh, 0Eh, 98h, 3, 0E3h, 8, 8Eh, 0C1h, 26h, 80h, 36h, 9, 0, 8, 5Dh
	db	0C3h, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh
	db	5Dh, 0C3h, 55h, 8Bh, 0ECh, 8Bh, 5Eh, 4, 8Bh, 4Fh, 0Ch, 0C4h, 5Fh
	db	12h, 26h, 8Bh, 1Fh, 0B2h, 0F7h, 0E3h, 9, 0B2h, 0FFh, 83h, 0C1h
	db	1, 0F5h, 83h, 0D9h, 1, 81h, 0FBh, 0, 10h, 73h, 7, 0C1h, 0E3h, 3
	db	81h, 0C3h, 7, 10h, 83h, 0E3h, 0F8h, 1Eh, 8Eh, 1Eh, 0Ch, 0, 8Eh
	db	6, 0CCh, 3, '& W', 5, 26h, 89h, 0Fh, 1Fh, 5Dh, 0C2h, 2, 0, 55h
	db	8Bh, 0ECh, 2Eh, 8Eh, 6, '_)&', 8Eh, 6, 0CCh, 3, 83h, 0E3h, 0F8h
	db	26h, 80h, 77h, 5, 8, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 1Eh, 0B9h, 0A7h
	db	1, 8Eh, 0D9h, 8Eh, 6, 0CCh, 3, 8Bh, 0CBh, 83h, 0E3h, 0F8h, 26h
	db	89h, 47h, 2, 26h, 88h, 57h, 4, 8Bh, 0D9h, 1Fh, 5Dh, 0C3h, 55h
	db	8Bh, 0ECh, 1Eh, 0B9h, 0A7h, 1, 8Eh, 0D9h, 8Eh, 6, 0CCh, 3, 8Bh
	db	0CBh, 83h, 0E3h, 0F8h, 33h, 0D2h, 26h, 8Bh, 47h, 2, 26h, 8Ah, 57h
	db	4, 8Bh, 0D9h, 1Fh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 0BBh, 0A7h, 1, 8Eh
	db	0C3h, 26h, 8Bh, 1Eh, 0C6h, 3, 53h, 26h, 8Eh, 6, 0CCh, 3, 83h, 0E3h
	db	0F8h, 26h, 89h, 47h, 2, 26h, 88h, 57h, 4, 58h, 5Dh, 0C3h, 55h
	db	8Bh, 0ECh, 0BBh, 0A7h, 1, 8Eh, 0C3h, 26h, 8Bh, 1Eh, 0C8h, 3, 53h
	db	26h, 8Eh, 6, 0CCh, 3, 83h, 0E3h, 0F8h, 26h, 89h, 47h, 2, 26h, 88h
	db	57h, 4, 58h, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 56h, 1Eh, 8Eh, 1Eh, 0Ch
	db	0, 8Bh, 1Eh, 0E6h, 5, 0Bh, 0DBh, 75h, 3, 0CCh, 0CDh, 0, 0FFh, 0Eh
	db	0EAh, 5, 8Eh, 6, 0CCh, 3, 26h, 8Bh, 47h, 2, 0A3h, 0E6h, 5, 1Fh
	db	56h, 8Bh, 76h, 4, 8Bh, 4, 8Bh, 54h, 2, 26h, 0C7h, 47h, 6, 0, 0
	db	26h, 89h, 47h, 2, 26h, 88h, 57h, 4, 8Bh, 4Ch, 0Ch, 0B0h, 0F7h
	db	0E3h, 9, 83h, 0C1h, 1, 0F5h, 83h, 0D9h, 1, 0B0h, 0FFh, 26h, 88h
	db	47h, 5, 26h, 89h, 0Fh, 0B0h, 0F2h, 0F7h, 44h, 0Eh, 0, 2, 74h, 2
	db	0B0h, 0FAh, '& G', 5, 5Eh, 8Bh, 0C3h, 0Dh, 7, 0, 5Eh, 5Dh, 0C2h
	db	2, 0, 55h, 8Bh, 0ECh, 8Bh, 5Eh, 4, 81h, 0FBh, 0, 10h, 73h, 7, 0C1h
	db	0E3h, 3, 81h, 0C3h, 7, 10h, 1Eh, 8Eh, 1Eh, 0Ch, 0, 0FFh, 6, 0EAh
	db	5, 8Eh, 6, 0CCh, 3, 83h, 0E3h, 0F8h, 0A1h, 0E6h, 5, 26h, 89h, 47h
	db	2, 89h, 1Eh, 0E6h, 5, 1Fh, 5Dh, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 56h
	db	57h, 1Eh, 8Bh, 7Eh, 8, 8Bh, 4Dh, 0Ch, 0C4h, 75h, 12h, 26h, 0FFh
	db	34h, 0F7h, 45h, 0Eh, 0, 8, 74h, 0Ch, 8Bh, 5, 8Bh, 55h, 2, 0E8h
	db	1Fh, 0FFh, 8Eh, 0D8h, 0EBh, 3, 26h, 8Eh, 1Ch, 0E3h, 29h, 8Bh, 46h
	db	4, 8Bh, 56h, 6, 0E8h, 0ECh, 0FEh, 8Eh, 0C0h, 33h, 0F6h, 33h, 0FFh
	db	0FCh, 83h, 0C1h, 1, 49h, 83h, 0D1h, 0, 0D1h, 0D9h, 0EBh, 9, 9Ch
	db	0D1h, 0E9h, 0F3h, 66h, 0A5h, 0D1h, 0D1h, 9Dh, 0F3h, 0A5h, 73h
	db	1, 0A4h, 5Bh, 81h, 0FBh, 0, 10h, 73h, 7, 0C1h, 0E3h, 3, 81h, 0C3h
	db	7, 10h, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 75h, 0FEh, 1Fh, 8Bh, 7Eh
	db	8, 89h, 5, 89h, 55h, 2, 80h, 3Eh, 8, 0, 1, 74h, 1Eh, 8Bh, 5Eh
	db	8, 3Bh, 1Eh, 38h, 0, 75h, 15h, 0B9h, 4, 0, 8Ch, 0DBh, 83h, 0C3h
	db	8, 5, 40h, 0, 80h, 0D2h, 0, 51h, 0E8h, 4Ah, 0FEh, 59h, 0E2h, 0F0h
	db	'_^]', 0C2h, 6, 0, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 8Bh, 7Eh, 8
	db	8Bh, 4Dh, 0Ch, 0C4h, 75h, 12h, 26h, 0FFh, 34h, 0F7h, 45h, 0Eh
	db	0, 8, 74h, 0Ch, 8Bh, 5, 8Bh, 55h, 2, 0E8h, 81h, 0FEh, 8Eh, 0D8h
	db	0EBh, 3, 26h, 8Eh, 1Ch, 0E3h, 35h, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h
	db	4Eh, 0FEh, 8Eh, 0C0h, 83h, 0C1h, 1, 49h, 83h, 0D1h, 0, 8Bh, 0F1h
	db	4Eh, 8Bh, 0FEh, 0FDh, 0D1h, 0D9h, 73h, 1, 0A4h, 4Eh, 0EBh, 10h
	db	0D1h, 0E9h, 73h, 3, 8Bh, 0FEh, 0A5h, 4Eh, 4Eh, 8Bh, 0FEh, 0F3h
	db	66h, 0A5h, 0EBh, 4, 8Bh, 0FEh, 0F3h, 0A5h, 0FCh, 5Bh, 81h, 0FBh
	db	0, 10h, 73h, 7, 0C1h, 0E3h, 3, 81h, 0C3h, 7, 10h, 8Bh, 46h, 4
	db	8Bh, 56h, 6, 0E8h, 0CBh, 0FDh, 1Fh, 8Bh, 7Eh, 8, 89h, 5, 89h, 55h
	db	2, 80h, 3Eh, 8, 0, 1, 74h, 1Eh, 8Bh, 5Eh, 8, 3Bh, 1Eh, 38h, 0
	db	75h, 15h, 0B9h, 4, 0, 8Ch, 0DBh, 83h, 0C3h, 8, 5, 40h, 0, 80h
	db	0D2h, 0, 51h, 0E8h, 0A0h, 0FDh, 59h, 0E2h, 0F0h, '_^]', 0C2h, 6
	db	0, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 8Bh, 7Eh, 8, 8Bh, 4Dh, 0Ch, 0E3h
	db	42h, 0C4h, 75h, 12h, 0F7h, 45h, 0Eh, 0, 8, 74h, 0Ch, 8Bh, 5, 8Bh
	db	55h, 2, 0E8h, 0D8h, 0FDh, 8Eh, 0D8h, 0EBh, 3, 26h, 8Eh, 1Ch, 8Bh
	db	46h, 4, 8Bh, 56h, 6, 0E8h, 0A7h, 0FDh, 8Eh, 0C0h, 33h, 0F6h, 33h
	db	0FFh, 0FCh, 83h, 0C1h, 1, 49h, 83h, 0D1h, 0, 0D1h, 0D9h, 0EBh
	db	9, 9Ch, 0D1h, 0E9h, 0F3h, 66h, 0A5h, 0D1h, 0D1h, 9Dh, 0F3h, 0A5h
	db	73h, 1, 0A4h, 1Fh, '_^]', 0C2h, 6, 0, 55h, 8Bh, 0ECh, 56h, 57h
	db	1Eh, 8Bh, 7Eh, 8, 8Bh, 4Dh, 0Ch, 0E3h, 33h, 8Bh, 5, 8Bh, 55h, 2
	db	0E8h, 6Ah, 0FDh, 50h, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 81h, 0FDh
	db	8Eh, 0D8h, 7, 33h, 0F6h, 33h, 0FFh, 0FCh, 83h, 0C1h, 1, 49h, 83h
	db	0D1h, 0, 0D1h, 0D9h, 0EBh, 9, 9Ch, 0D1h, 0E9h, 0F3h, 66h, 0A5h
	db	0D1h, 0D1h, 9Dh, 0F3h, 0A5h, 73h, 1, 0A4h, 1Fh, '_^]', 0C2h, 6
	db	0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 56h, 57h, 8Bh, 46h, 6, 0BAh, 18h
	db	0, 0F7h, 0EAh, 5, 40h, 1, 89h, 46h, 0FCh, 8Bh, 5Eh, 0Ah, 0B4h
	db	0EDh, 0CDh, 21h, 0Bh, 0C9h, 75h, 6, 0B8h, 0, 10h, 0E9h, 0, 2, 8Ch
	db	0CBh, 0B4h, 0EDh, 0CDh, 21h, 1Eh, 8Ch, 0C8h, 8Eh, 0D8h, 33h, 0F6h
	db	8Bh, 0DEh, 0B8h, 1, 0E8h, 0CDh, 21h, 1Fh, 73h, 6, 0B8h, 2, 10h
	db	0E9h, 0E3h, 1, 8Bh, 0D8h, 0B8h, 2, 0E9h, 0CDh, 21h, 8Eh, 0C3h
	db	26h, 89h, 1Eh, 0B3h, 2Ch, 80h, 3Eh, 0D2h, 3, 3, 75h, 18h, 0B8h
	db	90h, 90h, 2Eh, 8Eh, 6, 0B3h, 2Ch, 26h, 0A3h, 8Dh, 21h, 26h, 0A3h
	db	'0"&', 0A3h, 0D2h, 22h, 26h, 0A3h, 1Ah, 23h, 1Eh, 1Eh, 1Eh, 0B8h
	db	3, 0E5h, 0CDh, 21h, 1Fh, 0A3h, 0CCh, 3, 89h, 1Eh, 0D0h, 3, 0C1h
	db	0E1h, 3, 81h, 0C1h, 80h, 0, 81h, 0F9h, 0, 10h, 73h, 3, 0B9h, 0
	db	10h, 89h, 0Eh, 0ECh, 5, 8Bh, 0F9h, 83h, 0CFh, 7, 89h, 3Eh, 0C6h
	db	3, 83h, 0C7h, 8, 89h, 3Eh, 0C8h, 3, 83h, 0C1h, 60h, 89h, 0Eh, 0E6h
	db	5, 0C1h, 0E2h, 3, 89h, 16h, 0E8h, 5, 8Eh, 0D8h, 8Bh, 0F9h, 8Dh
	db	45h, 8, 89h, 45h, 2, 8Bh, 0F8h, 3Bh, 0FAh, 72h, 0F4h, 0C7h, 45h
	db	0FAh, 0, 0, 8Eh, 0DBh, 8Bh, 0F9h, 83h, 0EFh, 60h, 0C7h, 5, 0, 80h
	db	83h, 0C7h, 8, 3Bh, 0FAh, 72h, 0F5h, 1Fh, 2Bh, 0D1h, 0C1h, 0EAh
	db	3, 89h, 16h, 0EAh, 5, 0A1h, 0C6h, 3, 25h, 0F8h, 0FFh, 0A3h, 0CAh
	db	3, 0C4h, 1Eh, 0CAh, 3, 26h, 0C7h, 7, 0FFh, 0FFh, 26h, 0C6h, 47h
	db	5, 0F2h, 26h, 0C7h, 47h, 6, 0, 0, 0A1h, 0C8h, 3, 25h, 0F8h, 0FFh
	db	0A3h, 0CAh, 3, 0C4h, 1Eh, 0CAh, 3, 26h, 0C7h, 7, 0FFh, 0FFh, 26h
	db	0C6h, 47h, 5, 0F2h, 26h, 0C7h, 47h, 6, 0, 0, 0C7h, 6, 0CAh, 3
	db	0, 0, 8Bh, 5Eh, 0Ah, 0B4h, 0EDh, 0CDh, '!VSQRj', 0, 6Ah, 3, 8Bh
	db	0D6h, 8Bh, 0C3h, 8Bh, 1Eh, 0C6h, 3, 83h, 0C3h, 30h, 0B9h, 5, 0
	db	89h, 1Eh, 96h, 3, 8Eh, 6, 0CCh, 3, 83h, 0E3h, 0F8h, 26h, 0C7h
	db	47h, 6, 0, 0, 26h, 89h, 47h, 2, 26h, 88h, 57h, 4, 26h, 0C7h, 7
	db	0FFh, 0FFh, 26h, 0C6h, 47h, 5, 0F2h, 83h, 0C3h, 8, 5, 40h, 0, 80h
	db	0D2h, 0, 0E2h, 0DDh, 8Eh, 6, 96h, 3, 33h, 0FFh, 8Bh, 0C7h, 8Bh
	db	4Eh, 0FCh, 0D1h, 0E9h, 0FCh, 0F3h, 0ABh, 8Eh, 1Eh, 96h, 3, 0B8h
	db	40h, 1, 89h, 46h, 0FEh, 0A3h, 3Ah, 0, 0EBh, 10h, 8Bh, 46h, 0FEh
	db	5, 18h, 0, 8Bh, 5Eh, 0FEh, 89h, 47h, 14h, 83h, 46h, 0FEh, 18h
	db	8Bh, 46h, 0FEh, 3Bh, 46h, 0FCh, 72h, 0E8h, 83h, 6Eh, 0FEh, 18h
	db	8Bh, 5Eh, 0FEh, 0C7h, 47h, 14h, 0, 0, 8Bh, 46h, 6, 0A3h, 3Ch, 0
	db	0E8h, 0D6h, 0ECh, 0A0h, 9, 0, 0Ch, 6, 0A2h, 9, 0, 0FFh, 76h, 0FCh
	db	0E8h, 0ADh, 0E6h, 89h, 46h, 0FEh, 0A3h, 38h, 0, 8Bh, 5Eh, 0FEh
	db	0C7h, 47h, 12h, 96h, 3, 0C7h, 47h, 14h, 0A7h, 1, 8Bh, 5Eh, 0FEh
	db	81h, 4Fh, 0Eh, 0, 80h, 0FFh, 76h, 0FEh, 6Ah, 0, 0E8h, 0B2h, 0F8h
	db	0C7h, 6, 2Ch, 0, 0E9h, 22h, 0C7h, 6, 2Eh, 0, 92h, 22h, 0C7h, 6
	db	30h, 0, 4Ah, 21h, 0C7h, 6, 32h, 0, 0E8h, 21h, 0C7h, 6, 2Ah, 0
	db	3Ch, 1Fh, 83h, 7Eh, 4, 20h, 73h, 5, 0B8h, 20h, 0, 0EBh, 6, 8Bh
	db	46h, 4, 25h, 0FCh, 0FFh, 0A3h, 36h, 0, 0E8h, 8Dh, 0DCh, 0A3h, 34h
	db	0, 1Fh, 33h, 0C0h, 5Fh, 5Eh, 0C9h, 0C2h, 8, 0, 55h, 8Bh, 0ECh
	db	1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 1Fh, 5Dh, 0CAh, 6, 0, 55h, 8Bh
	db	0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 5Dh, 0C2h, 6
	db	0, 55h, 8Bh, 0ECh, 5Dh, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 1Eh, 6Ah, 0
	db	6Ah, 0, 6Ah, 0, 6Ah, 0, 6Ah, 4, 6Ah, 0, 0E8h, 2Dh, 0ECh, 0C7h
	db	6, 26h, 0, 22h, 13h, 0C7h, 6, 28h, 0, 4Fh, 13h, 0C7h, 6, 2Ch, 0
	db	74h, 25h, 0C7h, 6, 2Eh, 0, 74h, 25h, 0C7h, 6, 30h, 0, 74h, 25h
	db	0C7h, 6, 2Ah, 0, 7Bh, 25h, 1Fh, 33h, 0C0h, 5Dh, 0C3h, 55h, 8Bh
	db	0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 'LLVW', 0C6h
	db	46h, 0FFh, 0, 50h, 58h, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 8Dh, 0FAh
	db	89h, 46h, 4, 8Bh, 7Eh, 8, 8Bh, 16h, 36h, 0, 0B4h, 47h, 0E8h, 0C9h
	db	4, 0D0h, 0E4h, 72h, 71h, 8Bh, 5, 8Bh, 55h, 2, 0BBh, 0, 40h, 0F7h
	db	0F3h, 8Bh, 0D8h, 8Bh, 0F2h, 0D1h, 0EEh, 8Bh, 55h, 0Ch, 83h, 0C2h
	db	1, 0D1h, 0DAh, 33h, 0FFh, 0B9h, 0, 20h, 2Bh, 0CEh, 3Bh, 0CAh, 72h
	db	2, 8Bh, 0CAh, 2Bh, 0D1h, 52h, 8Bh, 16h, 36h, 0, 0B8h, 0, 44h, 0E8h
	db	93h, 4, 5Ah, 0D0h, 0E4h, 72h, 2Dh, 0D1h, 0E6h, 1Eh, 53h, 8Bh, 46h
	db	4, 8Bh, 1Eh, 38h, 0, 80h, 7Eh, 0FFh, 0, 74h, 3, 93h, 87h, 0F7h
	db	8Eh, 0C0h, 8Eh, 0DBh, 5Bh, 0FCh, 0F3h, 0A5h, 1Fh, 43h, 80h, 7Eh
	db	0FFh, 0, 74h, 2, 87h, 0F7h, 33h, 0F6h, 0Bh, 0D2h, 75h, 0B7h, 0F8h
	db	9Ch, 8Bh, 16h, 36h, 0, 0B4h, 48h, 0E8h, 57h, 4, 9Dh, 73h, 0, 5Fh
	db	5Eh, 0C9h, 0C2h, 6, 0, 55h, 8Bh, 0ECh, 'LLVW', 0C6h, 46h, 0FFh
	db	1, 0BEh, 2, 0, 0BFh, 2, 0, 0E8h, 58h, 0FFh, 5Fh, 5Eh, 0C9h, 0C2h
	db	6, 0, 55h, 8Bh, 0ECh, 'LLVW', 8Bh, 5Eh, 8, 8Bh, 47h, 0Ch, 89h
	db	46h, 0FEh, 8Bh, 46h, 4, 8Bh, 56h, 6, 0BBh, 0, 40h, 0F7h, 0F3h
	db	50h, 0D1h, 0EAh, 52h, 8Bh, 76h, 8, 8Bh, 4, 8Bh, 54h, 2, 0BBh, 0
	db	40h, 0F7h, 0F3h, 8Bh, 0D8h, 52h, 8Bh, 0FAh, 0D1h, 0EFh, 8Bh, 56h
	db	0FEh, 83h, 0C2h, 1, 0D1h, 0DAh, 0B8h, 1, 44h, 33h, 0F6h, 50h, 52h
	db	8Bh, 16h, 36h, 0, 0E8h, 0EBh, 3, 5Ah, 0D0h, 0E4h, 72h, 7Bh, 0B9h
	db	0, 20h, 2Bh, 0CFh, 3Bh, 0CAh, 72h, 2, 8Bh, 0CAh, 3, 0F1h, 43h
	db	33h, 0FFh, 2Bh, 0D1h, 58h, 74h, 6, 0FEh, 0C0h, 3Ch, 4, 72h, 0D7h
	db	0D1h, 0E2h, 89h, 56h, 0FEh, 8Bh, 0D6h, 0D1h, 0E6h, 8Bh, 0C6h, 8Bh
	db	76h, 8, 1, 4, 83h, 54h, 2, 0, '^_[', 0B9h, 0, 20h, 2Bh, 0CFh, 3Bh
	db	0CAh, 72h, 2, 8Bh, 0CAh, 2Bh, 0D1h, 52h, 8Bh, 16h, 36h, 0, 0B8h
	db	0, 44h, 0E8h, 9Ch, 3, 5Ah, 0D0h, 0E4h, 72h, 2Ch, 0D1h, 0E7h, 1Eh
	db	0A1h, 38h, 0, 8Eh, 0C0h, 3, 6, 3Ah, 0, 8Eh, 0D8h, 0FCh, 0F3h, 0A5h
	db	1Fh, 81h, 0FFh, 0, 40h, 75h, 3, 43h, 33h, 0FFh, 0Bh, 0D2h, 75h
	db	0C4h, 83h, 7Eh, 0FEh, 0, 74h, 0Ah, 53h, 0D1h, 0EFh, 57h, 0E9h
	db	56h, 0FFh, 83h, 0C4h, 8, 8Bh, 5Eh, 8, 8Bh, 46h, 6, 8Bh, 56h, 4
	db	89h, 47h, 2, 89h, 17h, 5Fh, 5Eh, 0C9h, 0C2h, 6, 0, 55h, 8Bh, 0ECh
	db	4Ch, 4Ch, 8Bh, 1Eh, 14h, 0, 8Bh, 47h, 14h, 89h, 46h, 0FEh, 3Bh
	db	6, 14h, 0, 75h, 4, 33h, 0C0h, 0EBh, 59h, 8Bh, 5Eh, 0FEh, 8Bh, 47h
	db	14h, 3Bh, 6, 14h, 0, 75h, 18h, 8Bh, 47h, 6, 8Bh, 57h, 4, 3Bh, 46h
	db	6, 72h, 9, 75h, 5, 3Bh, 56h, 4, 72h, 2, 0EBh, 36h, 33h, 0C0h, 0EBh
	db	35h, 8Eh, 6, 0Ch, 0, 8Bh, 16h, 36h, 0, 0B4h, 47h, 0E8h, 0Ah, 3
	db	0D0h, 0E4h, 72h, 21h, 0FFh, 76h, 6, 0FFh, 76h, 4, 0FFh, 36h, 16h
	db	0, 0FFh, 36h, 18h, 0, 0E8h, 61h, 0E1h, 89h, 46h, 0FEh, 8Bh, 16h
	db	36h, 0, 0B4h, 48h, 0E8h, 0E9h, 2, 0D0h, 0E4h, 73h, 0, 8Bh, 46h
	db	0FEh, 0C9h, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 1Eh, 0B8h
	db	0A7h, 1, 8Eh, 0D8h, 83h, 7Eh, 0Ah, 0, 75h, 71h, 9Ah, 6Ah, 29h
	db	0DFh, 0, 0Bh, 0C0h, 75h, 7, 33h, 0D2h, 33h, 0C0h, 0E9h, 24h, 1
	db	0B8h, 37h, 1, 8Eh, 0C0h, 26h, 0A1h, 26h, 0, 3Bh, 46h, 8, 77h, 7
	db	33h, 0D2h, 33h, 0C0h, 0E9h, 0Fh, 1, 83h, 7Eh, 6, 0, 74h, 11h, 0B8h
	db	37h, 1, 8Eh, 0C0h, 26h, 0A1h, 26h, 0, 2Bh, 46h, 8, 3Bh, 46h, 6
	db	73h, 0Fh, 0B8h, 37h, 1, 8Eh, 0C0h, 26h, 0A1h, 26h, 0, 2Bh, 46h
	db	8, 89h, 46h, 6, 83h, 7Eh, 6, 4, 73h, 7, 33h, 0D2h, 33h, 0C0h, 0E9h
	db	0DCh, 0, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 6, 9Ah, 20h
	db	2Ah, 0DFh, 0, 0Bh, 0C0h, 74h, 14h, 33h, 0D2h, 33h, 0C0h, 0E9h
	db	0C3h, 0, 83h, 7Eh, 6, 4, 73h, 7, 33h, 0D2h, 33h, 0C0h, 0E9h, 0B6h
	db	0, 0B8h, 0, 40h, 0F7h, 66h, 8, 89h, 46h, 0FCh, 89h, 56h, 0FEh
	db	0B8h, 0, 40h, 0F7h, 66h, 6, 89h, 46h, 0F8h, 89h, 56h, 0FAh, 0FFh
	db	76h, 0FEh, 0FFh, 76h, 0FCh, 52h, 50h, 0B8h, 3, 0, 50h, 0B8h, 1
	db	0, 50h, 0E8h, 31h, 0E9h, 0B8h, 37h, 1, 8Eh, 0C0h, 26h, 0A1h, 22h
	db	0, 0A3h, 36h, 0, 0B8h, 37h, 1, 8Eh, 0C0h, 26h, 0A1h, 20h, 0, 0A3h
	db	38h, 0, 0C7h, 6, 34h, 0, 0FFh, 0FFh, 0C7h, 6, 3Ah, 0, 0, 4, 0C7h
	db	6, 2Ch, 0, 66h, 26h, 0C7h, 6, 2Eh, 0, 0C6h, 25h, 0C7h, 6, 30h
	db	0, 80h, 26h, 0C7h, 6, 2Ah, 0, 60h, 27h, 1Eh, 7, 8Eh, 1Eh, 0Ch
	db	0, 8Bh, 1Eh, 0C6h, 3, 83h, 0C3h, 10h, 26h, 0A1h, 38h, 0, 26h, 89h
	db	1Eh, 38h, 0, 26h, 0C7h, 6, 3Ah, 0, 8, 0, 83h, 0E3h, 0F8h, 0BAh
	db	10h, 0, 0F7h, 0E2h, 8Eh, 6, 0CCh, 3, 0B9h, 4, 0, 26h, 89h, 47h
	db	2, 26h, 88h, 57h, 4, 26h, 0C7h, 7, 0FFh, 0FFh, 26h, 0C6h, 47h
	db	5, 0F2h, 83h, 0C3h, 8, 5, 0, 40h, 80h, 0D2h, 0, 0E2h, 0E3h, 8Bh
	db	56h, 0FAh, 8Bh, 46h, 0F8h, 1Fh, 0C9h, 0CAh, 6, 0, 55h, 8Bh, 0ECh
	db	9Ah, 88h, 2Ah, 0DFh, 0, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 0E8h, 0FAh
	db	0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h
	db	8Bh, 46h, 0Ch, 8Bh, 56h, 0Ah, 89h, 46h, 0Ch, 89h, 56h, 0Ah, 8Bh
	db	46h, 8, 8Bh, 56h, 6, 89h, 46h, 8, 89h, 56h, 6, 33h, 0D2h, 33h
	db	0C0h, 1Fh, 5Dh, 0CAh, 8, 0, 37h, 1, 0A7h, 1, 'EMMXXXX0', 0, 55h
	db	8Bh, 0ECh, 81h, 0ECh, 2, 1, 1Eh, 2Eh, 8Eh, 1Eh, '])VW', 0F6h, 6
	db	28h, 0, 1, 74h, 10h, 0F6h, 6, 28h, 0, 2, 75h, 3, 0EBh, 72h, 90h
	db	0A1h, 26h, 0, 0E9h, 89h, 0, 1Eh, 0Eh, 1Fh, 0BAh, 61h, 29h, 0B8h
	db	0, 3Dh, 0CDh, 21h, 1Fh, 8Bh, 0D8h, 72h, 22h, 0B8h, 0, 44h, 0CDh
	db	21h, 72h, 17h, 0F7h, 0C2h, 80h, 0, 74h, 11h, 0B8h, 7, 44h, 0CDh
	db	21h, 72h, 0Ah, 50h, 0B4h, 3Eh, 0CDh, '!X<', 0FFh, 74h, 7, 0B4h
	db	3Eh, 0CDh, 21h, 0EBh, 4Eh, 90h, 0B8h, 67h, 35h, 0CDh, 21h, 8Ch
	db	0C0h, 0Bh, 0C3h, 74h, 0F2h, 0B4h, 40h, 0E8h, 0DFh, 0, 0Ah, 0E4h
	db	75h, 0E9h, 0C6h, 6, 28h, 0, 1, 0B4h, 46h, 0E8h, 0D1h, 0, 0Ah, 0E4h
	db	75h, 0DBh, '<2r', 0D7h, 0A2h, 29h, 0, 0B4h, 41h, 0E8h, 0C1h, 0
	db	0Ah, 0E4h, 75h, 0CBh, 89h, 1Eh, 20h, 0, 0B4h, 42h, 0E8h, 0B4h
	db	0, 0Ah, 0E4h, 75h, 0Eh, 89h, 1Eh, 26h, 0, 0C7h, 6, 22h, 0, 0FFh
	db	0FFh, 8Bh, 0C3h, 0EBh, 7, 33h, 0C0h, 0C6h, 6, 28h, 0, 0, 5Fh, 5Eh
	db	1Fh, 8Bh, 0E5h, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh
	db	5Dh, 29h, 0F6h, 6, 28h, 0, 1, 75h, 3, 0EBh, 4Eh, 90h, 0F6h, 6
	db	28h, 0, 2, 74h, 5, 33h, 0C0h, 0EBh, 45h, 90h, 80h, 0Eh, 28h, 0
	db	2, 8Bh, 46h, 8, 0A3h, 24h, 0, 8Bh, 5Eh, 6, 89h, 1Eh, 26h, 0, 8Bh
	db	56h, 0Ah, 0Bh, 0D2h, 75h, 0Eh, 0B4h, 43h, 0E8h, 57h, 0, 0Ah, 0E4h
	db	75h, 1Fh, 80h, 0Eh, 28h, 0, 4, 89h, 16h, 22h, 0, 0B4h, 47h, 0E8h
	db	45h, 0, 0Ah, 0E4h, 75h, 0Dh, 8Bh, 16h, 22h, 0, 0B4h, 48h, 0E8h
	db	38h, 0, 8Ah, 0C4h, 0EBh, 3, 0B8h, 0FFh, 0FFh, 1Fh, 5Dh, 0CAh, 6
	db	0, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 5Dh, 29h, 0F6h, 6, 28h
	db	0, 4, 74h, 19h, 8Bh, 16h, 22h, 0, 83h, 0FAh, 0FFh, 74h, 10h, 0B4h
	db	45h, 0E8h, 0Eh, 0, 0C7h, 6, 22h, 0, 0FFh, 0FFh, 0C6h, 6, 28h, 0
	db	0, 1Fh, 5Dh, 0CBh, 6, 1Eh, 57h, 56h, 9Ch, 'RQSP', 8Bh, 0D4h, 16h
	db	1Fh, 0BBh, 8, 0, 0B8h, 67h, 0E3h, 0CDh, '!X[YZ', 9Dh, 5Eh, 5Fh
	db	1Fh, 7, 0C3h, 33h, 0C0h, 8Bh, 0D2h, 0CBh, 55h, 8Bh, 0ECh, 1Eh
	db	2Eh, 8Eh, 1Eh, '])VW', 0F6h, 6, 32h, 0, 1, 75h, 3, 0E9h, 0B9h
	db	0, 0F6h, 6, 32h, 0, 2, 74h, 5, 33h, 0C0h, 0E9h, 0B0h, 0, 80h, 0Eh
	db	32h, 0, 2, 8Bh, 46h, 0Ah, 8Bh, 56h, 0Ch, 8Bh, 76h, 6, 8Bh, 7Eh
	db	8, 8Bh, 1Eh, 33h, 0, 0Bh, 1Eh, 35h, 0, 74h, 43h, 8Bh, 0C6h, 8Bh
	db	0D7h, 5, 0FFh, 3, 83h, 0D2h, 0, 0BBh, 0, 4, 0F7h, 0F3h, 92h, 0B4h
	db	9, 0FFh, 1Eh, 33h, 0, 0Bh, 0C0h, 74h, 26h, 89h, 16h, 37h, 0, 0B4h
	db	0Ch, 0FFh, 1Eh, 33h, 0, 0Bh, 0C0h, 74h, 18h, 89h, 1Eh, 2Ah, 0
	db	89h, 16h, 2Ch, 0, 89h, 1Eh, 39h, 0, 89h, 16h, 3Bh, 0, 8Bh, 0C3h
	db	3, 0C6h, 13h, 0D7h, 0EBh, 47h, 0EBh, 50h, 90h, 0A3h, 2Ah, 0, 89h
	db	16h, 2Ch, 0, 33h, 0DBh, 8Eh, 0C3h, 1Eh, 0BBh, 77h, 1, 8Eh, 0DBh
	db	26h, 8Bh, 1Eh, 64h, 0, 89h, 1Eh, 2Fh, 0, 26h, 8Bh, 1Eh, 66h, 0
	db	89h, 1Eh, 31h, 0, 26h, 0C7h, 6, 64h, 0, 3Fh, 0, 26h, 0C7h, 6, 66h
	db	0, 77h, 1, 0A3h, 3Ah, 0, 88h, 16h, 3Ch, 0, 3, 0C6h, 13h, 0D7h
	db	0A3h, 2Ch, 0, 88h, 16h, 2Eh, 0, 1Fh, 0A3h, 2Eh, 0, 89h, 16h, 30h
	db	0, 33h, 0C0h, 0EBh, 3, 0B8h, 0FFh, 0FFh, 5Fh, 5Eh, 1Fh, 5Dh, 0CAh
	db	8, 0, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 5Dh, 29h, 80h, 3Eh, 32h
	db	0, 0, 74h, 41h, 83h, 3Eh, 37h, 0, 0, 74h, 16h, 0B4h, 0Dh, 8Bh
	db	16h, 37h, 0, 0FFh, 1Eh, 33h, 0, 0B4h, 0Ah, 8Bh, 16h, 37h, 0, 0FFh
	db	1Eh, 33h, 0, 0EBh, 24h, 33h, 0C0h, 8Eh, 0C0h, 26h, 0A1h, 66h, 0
	db	3Dh, 77h, 1, 75h, 17h, 1Eh, 8Eh, 0D8h, 0A1h, 2Fh, 0, 26h, 0A3h
	db	64h, 0, 0A1h, 31h, 0, 26h, 0A3h, 66h, 0, 1Fh, 0C6h, 6, 32h, 0
	db	0, 1Fh, 5Dh, 0CBh, 1Eh, 6, 83h, 0C6h, 1, 83h, 0D7h, 0, 83h, 0E6h
	db	0FEh, 0FCh, 2Eh, 8Eh, 1Eh, 5Dh, 29h, 83h, 3Eh, 37h, 0, 0, 74h
	db	6Ah, 89h, 36h, 3Dh, 0, 89h, 3Eh, 3Fh, 0, 80h, 0FAh, 10h, 72h, 13h
	db	8Bh, 36h, 37h, 0, 89h, 36h, 41h, 0, 2Bh, 6, 39h, 0, 1Bh, 16h, 3Bh
	db	0, 0EBh, 0Ah, 90h, 0C7h, 6, 41h, 0, 0, 0, 0C1h, 0CAh, 4, 0A3h
	db	43h, 0, 89h, 16h, 45h, 0, 80h, 0F9h, 10h, 72h, 13h, 8Bh, 36h, 37h
	db	0, 89h, 36h, 47h, 0, 2Bh, 1Eh, 39h, 0, 1Bh, 0Eh, 3Bh, 0, 0EBh
	db	0Ah, 90h, 0C7h, 6, 47h, 0, 0, 0, 0C1h, 0C9h, 4, 89h, 1Eh, 49h
	db	0, 89h, 0Eh, 4Bh, 0, 0B4h, 0Bh, 8Dh, 36h, 3Dh, 0, 0FFh, 1Eh, 33h
	db	0, 0Bh, 0C0h, 75h, 29h, 0F9h, 0EBh, 21h, 0D1h, 0EFh, 0D1h, 0DEh
	db	0A3h, 4Fh, 0, 88h, 16h, 51h, 0, 89h, 1Eh, 57h, 0, 88h, 0Eh, 59h
	db	0, 8Bh, 0CEh, 8Dh, 36h, 3Dh, 0, 1Eh, 7, 0B4h, 87h, 0CDh, 15h, 73h
	db	5, 1Bh, 0C0h, 0F9h, 0EBh, 2, 33h, 0C0h, 7, 1Fh, 0C3h, 0, 0, 0
	db	0, 58h, 8Bh, 0DCh, 36h, 87h, 47h, 8, 8Bh, 0D8h, 8Ah, 5Fh, 16h
	db	32h, 0FFh, 0D1h, 0E3h, 0D1h, 0E3h, 2Eh, 8Eh, 6, 0B1h, 2Ch, 26h
	db	0FFh, 1Fh, 0C3h, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, ']).', 8Bh
	db	0Eh, 0B1h, 2Ch, 0E3h, 7Ah, 8Eh, 0C1h, 8Bh, 46h, 4, 8Bh, 56h, 6
	db	8Bh, 0Eh, 12h, 0, 0D1h, 0E9h, 0D1h, 0E9h, 33h, 0DBh, '&9W', 2
	db	75h, 5, 26h, 39h, 7, 74h, 52h, 83h, 0C3h, 4, 0E2h, 0F0h, 8Bh, 1Eh
	db	12h, 0, 3Bh, 1Eh, 10h, 0, 72h, 28h, 81h, 0FBh, 0, 1, 72h, 5, 33h
	db	0DBh, 0EBh, 3Dh, 90h, 0B8h, 0, 10h, 'PP.', 0FFh, 36h, 0B3h, 2Ch
	db	0B8h, 0B1h, 2Ch, 50h, 83h, 0C3h, 10h, 53h, 9Ah, 28h, 19h, 0DFh
	db	0, 33h, 0DBh, 0Bh, 0C0h, 75h, 1Fh, 2Eh, 8Eh, 6, 0B1h, 2Ch, 8Bh
	db	1Eh, 12h, 0, 8Bh, 46h, 4, 26h, 89h, 7, 8Bh, 46h, 6, 26h, 89h, 47h
	db	2, 83h, 6, 12h, 0, 4, 0D1h, 0EBh, 0D1h, 0EBh, 8Bh, 0C3h, 1Fh, 5Dh
	db	0C2h, 4, 0, 2Eh, 8Eh, 6, '_)&', 0A0h, 8Eh, 3, 50h, 26h, 0C6h, 6
	db	8Eh, 3, 0, 2Eh, 0FFh, 36h, 0B3h, 2Ch, 0B8h, 0B1h, 2Ch, 50h, 0B8h
	db	10h, 0, 50h, 9Ah, 18h, 15h, 0DFh, 0, 2Eh, 8Eh, 6, '_)[&', 88h
	db	1Eh, 8Eh, 3, 33h, 0DBh, 0Bh, 0C0h, 75h, 0C6h, 0C7h, 6, 10h, 0
	db	10h, 0, 0C7h, 6, 12h, 0, 4, 0, 0EBh, 99h, 8Bh, 0DCh, 36h, 87h
	db	57h, 8, 36h, 87h, 47h, 6, 5Bh, 7, 'YRPQ', 6, 53h, 0EAh, 28h, 19h
	db	0DFh, 0, 8Bh, 0DCh, 36h, 87h, 57h, 6, 36h, 87h, 47h, 4, 5Bh, 7
	db	'RP3', 0C9h, 51h, 6, 53h, 0EAh, 28h, 19h, 0DFh, 0, 0BAh, 0, 10h
	db	8Bh, 0C2h, 0EBh, 0CAh, 0BAh, 20h, 0, 8Bh, 0C2h, 0EBh, 0DAh, 33h
	db	0D2h, 0B8h, 20h, 0, 0EBh, 0D3h, 0BAh, 0, 20h, 8Bh, 0C2h, 0EBh
	db	0CCh, 0BAh, 8, 0, 8Bh, 0C2h, 0EBh, 0C5h, 0BAh, 10h, 0, 8Bh, 0C2h
	db	0EBh, 0BEh, 33h, 0D2h, 0B8h, 18h, 0, 0EBh, 0B7h, 0BAh, 8, 8, 8Bh
	db	0C2h, 0EBh, 99h, 0BAh, 10h, 8, 8Bh, 0C2h, 0EBh, 92h, 0BAh, 8, 20h
	db	8Bh, 0C2h, 0EBh, 0A2h, 0BAh, 40h, 0, 8Bh, 0C2h, 0EBh, 9Bh, 0BAh
	db	60h, 0, 8Bh, 0C2h, 0EBh, 94h, 33h, 0D2h, 0B8h, 40h, 0, 0EBh, 8Dh
	db	0CBh, 0EAh, 0FCh, 15h, 0DFh, 0, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh
	db	5Dh, 0C3h, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh
	db	0ECh, 83h, 0ECh, 4, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 83h, 7Eh, 8
	db	0FFh, 75h, 1Fh, 83h, 7Eh, 6, 0FFh, 75h, 19h, 0B9h, 0FFh, 0FFh
	db	8Bh, 0D1h, 0B8h, 0, 0E8h, 0CDh, 21h, 0B8h, 0, 0E8h, 0CDh, 21h
	db	0C7h, 46h, 0FCh, 0, 0, 89h, 46h, 0FEh, 0EBh, 1Fh, 8Bh, 4Eh, 8
	db	8Bh, 56h, 6, 0B8h, 0, 0E8h, 0CDh, 21h, 0C7h, 46h, 0FCh, 0, 0, 89h
	db	46h, 0FEh, 83h, 7Eh, 0FCh, 0, 73h, 6, 33h, 0D2h, 33h, 0C0h, 0EBh
	db	6, 8Bh, 56h, 0FEh, 8Bh, 46h, 0FCh, 1Fh, 0C9h, 0CAh, 4, 0, 55h
	db	8Bh, 0ECh, 1Eh, 0B8h, 0A7h, 1, 8Eh, 0D8h, 8Eh, 46h, 8, 0B8h, 0
	db	49h, 0CDh, 21h, 3Dh, 0Ah, 0, 73h, 5, 0A1h, 90h, 3, 0EBh, 2, 33h
	db	0C0h, 1Fh, 5Dh, 0CAh, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Internal undefined error'
	db	0, 'Unable to open file ', 27h, 25h, 73h, 27h, 0, 'Write failed, disk full?'
	db	0, 'Out of memory', 0, 'DOS error, ax = %d', 0, 'Bad object file %s'
	db	0, 'Invalid segment definition', 0, 'Illegal group definition: %s'
	db	0, 'Table limit exceeded', 0, 'Group %s exceeds 64K', 0, 'Segment %s exceeds 64K'
	db	0, 'Invalid '
Y0CE30	ends

Y0FCF0	segment para public 'CODE'
	assume	cs:Y0FCF0
	db	'initial stack offset', 0, 'Bad version number in parameter block'	;@0FCF0
	db	0, '%s (%d) : Syntax error', 0, '%s (%d) : File read error', 0
	db	'%s (%d) : Missing internal name', 0, '%s (%d) : Incompatible attribute'
	db	0, 'Segment alignment factor too small', 0, 'Segment too large for segment table'
	db	0, 'Cannot generate COM file : stack segment present', 0, 'Cannot generate COM file : program exceeds 64K'
	db	0, 'Cannot generate COM file : invalid initial entry p', 'oint address'
	db	0, 'Cannot generate COM file : segment-relocatable ite', 'ms present'
	db	0, 'Cannot generate COM file : data below initial CS:I', 'P defined'
	db	0, 'Relocation offset overflow', 0, 'Not enough memory', 0, 'Unknown option'
	db	0, 'Bad character in parameters', 0, 'Relocation table overflow'
	db	0, '32-bit record encountered', 0, 'Internal linker error %d'
	db	0, 'Debugging information overflow; try fewer modules ', 'with debug info'
	db	0, 'Limit of 254 segments for new executable file exce', 'eded'
	db	0, 'Stub program exceeds 64K', 0, 'Relocation item exceeds 1Me'
L1004E:	db	67h, 20h, 44h, 4Fh, 53h	; and byte ptr [edi+ecx+53h], al	;@1004E
	and	byte ptr [si+69h], ch	;@10053
	insw	;@10056
	db	69h, 74h, 0, 46h, 69h	; imul si, word ptr [si], 6946h	;@10057
	db	78h, 75h	; js @@11	;@1005C
	db	70h, 20h	; jo @@2+1	;@1005E
	outsw	;@10060
	db	76h, 65h	; jbe @@9	;@10061
	db	72h, 66h	; jb @@10+1	;@10063
	insb	;@10065
	outsw	;@10066
	db	77h, 20h	; ja @@3+3	;@10067
	popa	;@10069
	db	74h, 20h	; je @@4+1	;@1006A
	and	ax, 2C73h	;@1006C
	and	byte ptr [si+61h], dh	;@1006F
	db	72h, 67h	; jb @@12+4	;@10072
	db	65h, 74h, 20h	; je @@5+7	;@10074
	db	3Dh, 20h, 25h	; cmp ax, 2520h	;@10077
	jae	@@1	;@1007A
@@1:	and	ax, 2073h	;@1007C
@@2:	imul	si, word ptr [bp+di+20h], 7564h	;@1007F
	db	70h, 6Ch	; jo @@13	;@10084
@@3:	imul	sp, word ptr [bp+di+61h], 6574h	;@10086
@@4:	db	64h, 0, 25h	; add byte ptr [di], ah	;@1008B
	db	73h, 20h	; jae @@6+4	;@1008E
@@5:	db	64h, 65h, 66h, 69h, 6Eh, 65h, 64h, 20h, 69h, 6Eh	; imul ebp, dword ptr [bp+65h], 6E692064h	;@10090
	and	byte ptr [di+6Fh], ch	;@1009A
	db	64h, 75h, 6Ch	; jne @@18	;@1009D
	db	65h, 20h, 25h	; and byte ptr [di], ah	;@100A0
	db	73h, 20h	; jae @@7	;@100A3
	imul	si, word ptr [bp+di+20h], 7564h	;@100A5
	db	70h, 6Ch	; jo @@19+1	;@100AA
@@6:	imul	sp, word ptr [bp+di+61h], 6574h	;@100AC
	db	64h, 0, 55h, 6Eh	; add byte ptr [di+6Eh], dl	;@100B1
	db	64h, 65h, 66h, 69h, 6Eh, 65h, 64h, 20h, 73h, 79h	; imul ebp, dword ptr [bp+65h], 79732064h	;@100B5
	db	6Dh	; insw	;@100BF
	bound	bp, dword ptr [bx+6Ch]	;@100C0
	and	byte ptr [di], ah	;@100C3
@@7:	jae	@@8	;@100C5
@@8:	push	ax	;@100C7
@@9:	db	72h, 6Fh	; jb @@26	;@100C8
@@10:	db	67h, 72h, 61h	; jb @@24+3	;@100CA
	db	6Dh	; insw	;@100CD
	and	byte ptr [di+6Eh], ah	;@100CE
	db	74h, 72h	; je @@27	;@100D1
@@11:	db	79h, 20h	; jns @@14	;@100D3
	db	70h, 6Fh	; jo @@27+1	;@100D5
@@12:	imul	bp, word ptr [bp+74h], 6D20h	;@100D7
	popa	;@100DC
	db	79h, 20h	; jns @@16	;@100DD
	outsb	;@100DF
	outsw	;@100E0
	db	74h, 20h	; je @@17+2	;@100E1
	db	72h, 65h	; jb @@28+2	;@100E3
	db	73h, 69h	; jae @@29	;@100E5
	db	64h, 65h, 20h, 69h, 6Eh	; and byte ptr [bx+di+6Eh], ch	;@100E7
	db	20h, 61h, 6Eh	; and byte ptr [bx+di+6Eh], ah	;@100EC
	and	byte ptr [bx+76h], ch	;@100EF
@@13:	db	65h, 72h, 6Ch	; jb @@30+1	;@100F2
@@14:	db	61h	; popa	;@100F5
	jns	@@15	;@100F6
@@15:	push	sp	;@100F8
	outsw	;@100F9
	outsw	;@100FA
	and	byte ptr [di+61h], ch	;@100FB
	outsb	;@100FE
@@16:	db	79h, 20h	; jns @@21+1	;@100FF
@@17:	db	65h, 72h, 72h	; jb @@33	;@10101
	db	6Fh	; outsw	;@10104
	db	72h, 20h	; jb @@22	;@10105
	outsw	;@10107
	db	72h, 20h	; jb @@23+1	;@10108
	db	77h, 61h	; ja @@32+1	;@1010A
@@18:	db	72h, 6Eh	; jb @@34+2	;@1010C
	imul	bp, word ptr [bp+67h], 6D20h	;@1010E
	db	65h, 73h, 73h	; jae @@36+1	;@10113
	db	61h	; popa	;@10116
@@19:	db	67h, 65h, 73h, 0	; jae @@20	;@10117
@@20:	db	49h	; dec cx	;@1011B
	outsb	;@1011C
	db	76h, 61h	; jbe @@35	;@1011D
	insb	;@1011F
@@21:	imul	sp, word ptr [si+20h], 6E65h	;@10120
	db	74h, 72h	; je @@39+3	;@10125
@@22:	db	79h, 20h	; jns @@28+1	;@10127
@@23:	db	70h, 6Fh	; jo @@39+4	;@10129
@@24:	imul	bp, word ptr [bp+74h], 6F20h	;@1012B
	db	66h, 66h, 73h, 65h	; jae @@39+3	;@10130
	db	74h, 0	; je @@25	;@10134
@@25:	inc	bx	;@10136
	outsw	;@10137
	insw	;@10138
@@26:	insw	;@10139
	outsw	;@1013A
	outsb	;@1013B
	and	byte ptr [bp+di+65h], dh	;@1013C
	db	67h, 6Dh	; insw	;@1013F
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@10141
	db	74h, 20h	; je @@31+1	;@10143
@@27:	db	65h, 78h, 63h	; js @@40	;@10145
@@28:	db	65h, 65h, 64h, 73h, 20h	; jae @@32+1	;@10148
	db	36h, 34h, 4Bh	; xor al, 4Bh	;@1014D
@@29:	db	0, 49h, 6Eh	; add byte ptr [bx+di+6Eh], cl	;@10150
	db	76h, 61h	; jbe @@41+4	;@10153
	insb	;@10155
	imul	sp, word ptr [si+20h], 6973h	;@10156
	db	7Ah, 65h	; jp @@43	;@1015B
	and	byte ptr [bp+di+70h], dh	;@1015D
@@30:	db	65h, 63h, 69h, 66h	; arpl word ptr [bx+di+66h], bp	;@10160
@@31:	db	69h, 65h, 64h, 20h, 66h	; imul sp, word ptr [di+64h], 6620h	;@10164
	outsw	;@10169
	db	72h, 20h	; jb @@37+2	;@1016A
@@32:	db	73h, 65h	; jae @@45+1	;@1016C
	db	67h, 6Dh	; insw	;@1016E
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@10170
	db	74h, 20h	; je @@38+1	;@10172
	db	70h, 61h	; jo @@46	;@10174
@@33:	arpl	word ptr [bp+di+69h], bp	;@10176
	outsb	;@10179
@@34:	db	67h, 0, 41h, 75h	; add byte ptr [ecx+75h], al	;@1017A
	db	74h, 6Fh	; je @@50	;@1017E
@@35:	insw	;@10180
	popa	;@10181
	db	74h, 69h	; je @@49	;@10182
	arpl	word ptr [bx+si], sp	;@10184
	db	64h, 61h	; popa	;@10186
@@36:	db	74h, 61h	; je @@48	;@10188
@@37:	and	byte ptr [bp+di+65h], dh	;@1018A
	db	67h, 6Dh	; insw	;@1018D
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@1018F
	db	74h, 20h	; je @@41+1	;@10191
@@38:	db	65h, 78h, 63h	; js @@51+1	;@10193
@@39:	db	65h, 65h, 64h, 73h, 20h	; jae @@42+1	;@10196
	db	36h, 34h, 4Bh	; xor al, 4Bh	;@1019B
	db	0, 49h, 6Eh	; add byte ptr [bx+di+6Eh], cl	;@1019E
	db	76h, 61h	; jbe @@52	;@101A1
	insb	;@101A3
	imul	sp, word ptr [si+20h], 6973h	;@101A4
	db	7Ah, 65h	; jp @@54	;@101A9
@@40:	and	byte ptr [bp+di+70h], dh	;@101AB
	db	65h, 63h, 69h, 66h	; arpl word ptr [bx+di+66h], bp	;@101AE
@@41:	db	69h, 65h, 64h, 20h, 66h	; imul sp, word ptr [di+64h], 6620h	;@101B2
	outsw	;@101B7
	db	72h, 20h	; jb @@46+3	;@101B8
@@42:	db	73h, 65h	; jae @@55+7	;@101BA
	db	67h, 6Dh	; insw	;@101BC
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@101BE
	db	74h, 20h	; je @@47	;@101C0
@@43:	popa	;@101C2
	insb	;@101C3
	imul	sp, word ptr [bx+6Eh], 656Dh	;@101C4
	outsb	;@101C9
	je	@@44	;@101CA
@@44:	dec	cx	;@101CC
	insw	;@101CD
	db	70h, 6Fh	; jo @@58	;@101CE
	db	72h, 74h	; jb @@59	;@101D0
@@45:	db	65h, 64h, 20h, 72h, 65h	; and byte ptr [bp+si+65h], dh	;@101D2
@@46:	db	66h, 65h, 72h, 65h	; jb @@58+1	;@101D7
	outsb	;@101DB
	arpl	word ptr [di+73h], sp	;@101DC
	and	byte ptr [bp+72h], ah	;@101DF
@@47:	outsw	;@101E2
	insw	;@101E3
	and	byte ptr [bp+49h], dl	;@101E4
	push	dx	;@101E7
	inc	sp	;@101E8
	inc	bp	;@101E9
	inc	si	;@101EA
@@48:	db	73h, 20h	; jae @@53+4	;@101EB
@@49:	outsb	;@101ED
	outsw	;@101EE
@@50:	db	74h, 20h	; je @@54+1	;@101EF
	db	73h, 75h	; jae @@63+1	;@101F1
	db	70h, 70h	; jo @@62+1	;@101F3
	outsw	;@101F5
	db	72h, 74h	; jb @@64	;@101F6
@@51:	db	65h, 64h, 0, 55h, 73h	; add byte ptr [di+73h], dl	;@101F8
	db	65h, 72h, 20h	; jb @@55+6	;@101FD
	inc	dx	;@10200
	db	72h, 65h	; jb @@63+1	;@10201
	popa	;@10203
@@52:	imul	ax, word ptr [bx+si], 25h	;@10204
	db	73h, 20h	; jae @@56+2	;@10207
@@53:	imul	si, word ptr [bp+di+20h], 7564h	;@10209
	db	70h, 6Ch	; jo @@65+2	;@1020E
@@54:	imul	sp, word ptr [bp+di+61h], 6574h	;@10210
	db	64h, 0, 25h	; add byte ptr [di], ah	;@10215
	db	73h, 20h	; jae @@57+4	;@10218
@@55:	db	64h, 65h, 66h, 69h, 6Eh, 65h, 64h, 20h, 69h, 6Eh	; imul ebp, dword ptr [bp+65h], 6E692064h	;@1021A
	and	byte ptr [di+6Fh], ch	;@10224
@@56:	db	64h, 75h, 6Ch	; jne @@67+1	;@10227
	db	65h, 20h, 25h	; and byte ptr [di], ah	;@1022A
	db	73h, 20h	; jae @@60+1	;@1022D
	imul	si, word ptr [bp+di+20h], 7564h	;@1022F
	db	70h, 6Ch	; jo @@69	;@10234
@@57:	imul	sp, word ptr [bp+di+61h], 6574h	;@10236
	db	64h, 0, 4Eh, 6Fh	; add byte ptr [bp+6Fh], cl	;@1023B
@@58:	db	20h, 73h, 74h	; and byte ptr [bp+di+74h], dh	;@1023F
	popa	;@10242
	db	63h, 6Bh, 0	; arpl word ptr [bp+di], bp	;@10243
@@59:	db	25h, 73h, 20h	; and ax, 2073h	;@10246
	arpl	word ptr [bx+6Eh], bp	;@10249
	db	66h, 6Ch	; insb	;@1024C
@@60:	db	69h, 63h, 74h, 73h, 20h	; imul sp, word ptr [bp+di+74h], 2073h	;@1024E
	db	77h, 69h	; ja @@73	;@10253
	db	74h, 68h	; je @@73+1	;@10255
	and	byte ptr [di+6Fh], ch	;@10257
	db	64h, 75h, 6Ch	; jne @@75	;@1025A
	db	65h, 20h, 25h	; and byte ptr [di], ah	;@1025D
	jae	@@61	;@10260
@@61:	dec	si	;@10262
	outsw	;@10263
@@62:	and	byte ptr [bp+di+74h], dh	;@10264
@@63:	db	75h, 62h	; jne @@75+2	;@10267
	and	byte ptr [bp+6Fh], ah	;@10269
@@64:	db	72h, 20h	; jb @@66+1	;@1026C
	db	66h, 69h, 78h, 75h, 70h, 20h, 61h, 74h	; imul edi, dword ptr [bx+si+75h], 74612070h	;@1026E
	and	byte ptr [di], ah	;@10276
	db	73h, 3Ah	; jae @@71	;@10278
@@65:	and	ax, 73h	;@1027A
	push	bx	;@1027D
	db	65h, 67h, 6Dh	; insw	;@1027E
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@10281
	je	@@70+1	;@10283
	and	ax, 2073h	;@10285
	imul	si, word ptr [bp+di+20h], 6E69h	;@10288
@@66:	and	byte ptr [si+77h], dh	;@1028D
	outsw	;@10290
	and	byte ptr [bx+72h], ah	;@10291
	outsw	;@10294
@@67:	db	75h, 70h	; jne @@80	;@10295
	db	73h, 3Ah	; jae @@76+2	;@10297
	and	byte ptr [di], ah	;@10299
	jae	@@68	;@1029B
@@68:	inc	di	;@1029D
	db	72h, 6Fh	; jb @@82	;@1029E
	db	75h, 70h	; jne @@83+1	;@102A0
@@69:	and	byte ptr [di], ah	;@102A2
@@70:	jae	@@74+2	;@102A4
	outsw	;@102A6
	db	76h, 65h	; jbe @@81+4	;@102A7
	db	72h, 6Ch	; jb @@84+1	;@102A9
	popa	;@102AB
	db	70h, 73h	; jo @@86	;@102AC
	and	byte ptr [bx+72h], ah	;@102AE
	outsw	;@102B1
	db	75h, 70h	; jne @@86+3	;@102B2
@@71:	and	byte ptr [di], ah	;@102B4
	jae	@@72	;@102B6
@@72:	dec	di	;@102B8
	db	76h, 65h	; jbe @@85+1	;@102B9
	db	72h, 6Ch	; jb @@87+1	;@102BB
	popa	;@102BD
@@73:	db	79h, 73h	; jns @@89	;@102BE
	and	byte ptr [bx+65h], ah	;@102C0
	outsb	;@102C3
@@74:	db	65h, 72h, 61h	; jb @@87	;@102C4
	db	74h, 65h	; je @@88	;@102C7
@@75:	db	64h, 20h, 61h, 6Eh	; and byte ptr [bx+di+6Eh], ah	;@102C9
	db	64h, 20h, 6Eh, 6Fh	; and byte ptr [bp+6Fh], ch	;@102CD
@@76:	and	byte ptr [bx+76h], ch	;@102D1
	db	65h, 72h, 6Ch	; jb @@91+3	;@102D4
	db	61h	; popa	;@102D7
	db	79h, 20h	; jns @@77	;@102D8
	insw	;@102DA
	popa	;@102DB
	outsb	;@102DC
	popa	;@102DD
	db	67h, 65h, 72h, 20h	; jb @@78+1	;@102DE
	db	69h, 6Eh, 63h, 6Ch, 75h	; imul bp, word ptr [bp+63h], 756Ch	;@102E2
	db	64h, 65h, 64h, 0, 4Eh, 6Fh	; add byte ptr [bp+6Fh], cl	;@102E7
	db	20h, 61h, 75h	; and byte ptr [bx+di+75h], ah	;@102ED
	db	74h, 6Fh	; je @@96+1	;@102F0
	insw	;@102F2
	popa	;@102F3
	db	74h, 69h	; je @@95+1	;@102F4
	arpl	word ptr [bx+si], sp	;@102F6
	db	64h, 61h	; popa	;@102F8
@@77:	db	74h, 61h	; je @@94+2	;@102FA
	and	byte ptr [bp+di+65h], dh	;@102FC
	db	67h, 6Dh	; insw	;@102FF
@@78:	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@10301
	je	@@79	;@10303
@@79:	dec	cx	;@10305
	outsb	;@10306
@@80:	db	76h, 61h	; jbe @@97	;@10307
	insb	;@10309
@@81:	imul	sp, word ptr [si+20h], 6E65h	;@1030A
@@82:	db	74h, 72h	; je @@98	;@1030F
@@83:	jns	@@89	;@10311
	popa	;@10313
	je	@@90+1	;@10314
@@84:	and	ax, 3A78h	;@10316
	and	ax, 3B78h	;@10319
	and	byte ptr [bx+di+70h], ah	;@1031C
@@85:	db	70h, 6Ch	; jo @@99+5	;@1031F
@@86:	imul	sp, word ptr [bp+di+61h], 6974h	;@10321
	outsw	;@10326
	outsb	;@10327
@@87:	and	byte ptr [di+61h], ch	;@10328
	db	79h, 20h	; jns @@92	;@1032B
	outsb	;@1032D
@@88:	outsw	;@1032E
	db	74h, 20h	; je @@93+1	;@1032F
	db	77h, 6Fh	; ja @@101+1	;@10331
@@89:	db	72h, 6Bh	; jb @@100+3	;@10333
@@90:	and	byte ptr [bx+di+6Eh], ch	;@10335
	and	byte ptr [bp+si+65h], dh	;@10338
	popa	;@1033B
	insb	;@1033C
	and	byte ptr [di+6Fh], ch	;@1033D
@@91:	db	64h, 65h, 0, 41h, 74h	; add byte ptr [bx+di+74h], al	;@10340
	db	74h, 65h	; je @@102	;@10345
	insw	;@10347
	db	70h, 74h	; jo @@104+2	;@10348
	and	byte ptr [si+6Fh], dh	;@1034A
@@92:	and	byte ptr [di+78h], ah	;@1034D
@@93:	db	70h, 6Fh	; jo @@105	;@10350
	db	72h, 74h	; jb @@106+4	;@10352
	and	byte ptr [bp+6Fh], ch	;@10354
	outsb	;@10357
	sub	ax, 7570h	;@10358
@@94:	bound	bp, dword ptr [si+69h]	;@1035B
@@95:	arpl	word ptr [bx+si], sp	;@1035E
@@96:	db	73h, 79h	; jae @@108+1	;@10360
	insw	;@10362
	bound	bp, dword ptr [bx+6Ch]	;@10363
	and	byte ptr [di], ah	;@10366
	jae	@@97	;@10368
@@97:	dec	si	;@1036A
	outsw	;@1036B
	and	byte ptr [bx+si+72h], dh	;@1036C
	outsw	;@1036F
	db	67h, 72h, 61h	; jb @@107	;@10370
	db	6Dh	; insw	;@10373
	and	byte ptr [bp+di+74h], dh	;@10374
	popa	;@10377
	db	72h, 74h	; jb @@110+1	;@10378
	imul	bp, word ptr [bp+67h], 6120h	;@1037A
	db	64h, 64h, 72h, 65h	; jb @@109	;@1037F
@@98:	db	73h, 73h	; jae @@111+2	;@10383
	and	byte ptr [si+65h], ah	;@10385
@@99:	db	66h, 69h, 6Eh, 65h, 64h, 0, 4Fh, 76h	; imul ebp, dword ptr [bp+65h], 764F0064h	;@10388
	db	65h, 72h, 6Ch	; jb @@112+1	;@10390
	db	61h	; popa	;@10393
	db	79h, 73h	; jns @@114+2	;@10394
	and	byte ptr [bx+di+67h], ch	;@10396
	outsb	;@10399
	outsw	;@1039A
	db	72h, 65h	; jb @@113+1	;@1039B
@@100:	db	64h, 20h, 69h, 6Eh	; and byte ptr [bx+di+6Eh], ch	;@1039D
@@101:	db	20h, 6Eh, 65h	; and byte ptr [bp+65h], ch	;@103A1
	db	77h, 20h	; ja @@106+2	;@103A4
	db	65h, 78h, 65h	; js @@115+2	;@103A6
	db	63h, 75h, 74h	; arpl word ptr [di+74h], si	;@103A9
@@102:	popa	;@103AC
	bound	bp, dword ptr [si+65h]	;@103AD
	and	byte ptr [bx+di+6Dh], ch	;@103B0
	popa	;@103B3
	db	67h, 65h, 73h, 0	; jae @@103	;@103B4
@@103:	db	44h	; inc sp	;@103B8
	db	75h, 70h	; jne @@116	;@103B9
	insb	;@103BB
@@104:	imul	sp, word ptr [bp+di+61h], 6574h	;@103BC
@@105:	and	byte ptr [bx+72h], ch	;@103C1
@@106:	db	64h, 69h, 6Eh, 61h, 6Ch, 20h	; imul bp, word ptr [bp+61h], 206Ch	;@103C4
	db	28h, 25h	; sub byte ptr [di], ah	;@103CA
	db	64h, 29h, 20h	; sub word ptr [bx+si], sp	;@103CC
	db	69h, 6Eh, 20h, 65h, 78h	; imul bp, word ptr [bp+20h], 7865h	;@103CF
@@107:	db	70h, 6Fh	; jo @@118+3	;@103D4
	db	72h, 74h	; jb @@119	;@103D6
	jae	@@108	;@103D8
@@108:	and	ax, 2073h	;@103DA
	sub	byte ptr [di], ah	;@103DD
	db	64h, 29h, 20h	; sub word ptr [bx+si], sp	;@103DF
	db	3Ah, 20h	; cmp ah, byte ptr [bx+si]	;@103E2
	inc	sp	;@103E4
	db	75h, 70h	; jne @@120+3	;@103E5
	insb	;@103E7
@@109:	imul	sp, word ptr [bp+di+61h], 6574h	;@103E8
@@110:	and	byte ptr [di+78h], ah	;@103ED
	db	74h, 65h	; je @@120+3	;@103F0
	db	72h, 6Eh	; jb @@122	;@103F2
	popa	;@103F4
	insb	;@103F5
@@111:	and	byte ptr [bp+61h], ch	;@103F6
	insw	;@103F9
	db	65h, 20h, 69h, 6Eh	; and byte ptr [bx+di+6Eh], ch	;@103FA
@@112:	db	20h, 65h, 78h	; and byte ptr [di+78h], ah	;@103FE
@@113:	db	70h, 6Fh	; jo @@123+4	;@10401
	db	72h, 74h	; jb @@124+1	;@10403
	jae	@@114	;@10405
@@114:	and	ax, 2073h	;@10407
	sub	byte ptr [di], ah	;@1040A
@@115:	db	64h, 29h, 20h	; sub word ptr [bx+si], sp	;@1040C
	db	3Ah, 20h	; cmp ah, byte ptr [bx+si]	;@1040F
	inc	sp	;@10411
	db	75h, 70h	; jne @@125+2	;@10412
	insb	;@10414
	imul	sp, word ptr [bp+di+61h], 6574h	;@10415
	and	byte ptr [bx+di+6Eh], ch	;@1041A
	db	74h, 65h	; je @@125+2	;@1041D
	db	72h, 6Eh	; jb @@127+1	;@1041F
	popa	;@10421
	insb	;@10422
	and	byte ptr [bp+61h], ch	;@10423
	insw	;@10426
	db	65h, 20h, 69h, 6Eh	; and byte ptr [bx+di+6Eh], ch	;@10427
@@116:	db	20h, 65h, 78h	; and byte ptr [di+78h], ah	;@1042B
	db	70h, 6Fh	; jo @@128+2	;@1042E
	db	72h, 74h	; jb @@129+1	;@10430
	jae	@@117	;@10432
@@117:	and	ax, 2073h	;@10434
	sub	byte ptr [di], ah	;@10437
	db	64h, 29h, 20h	; sub word ptr [bx+si], sp	;@10439
	db	3Ah, 20h	; cmp ah, byte ptr [bx+si]	;@1043C
	inc	sp	;@1043E
	db	75h, 70h	; jne @@130+1	;@1043F
	insb	;@10441
@@118:	imul	sp, word ptr [bp+di+61h], 6574h	;@10442
	and	byte ptr [bx+di+6Eh], ch	;@10447
	db	74h, 65h	; je @@130+1	;@1044A
@@119:	db	72h, 6Eh	; jb @@131	;@1044C
	popa	;@1044E
	insb	;@1044F
	and	byte ptr [bp+61h], ch	;@10450
	insw	;@10453
@@120:	db	65h, 20h, 69h, 6Eh	; and byte ptr [bx+di+6Eh], ch	;@10454
	db	20h, 69h, 6Dh	; and byte ptr [bx+di+6Dh], ch	;@10458
	db	70h, 6Fh	; jo @@132+1	;@1045B
	db	72h, 74h	; jb @@133+1	;@1045D
	jae	@@121	;@1045F
@@121:	inc	sp	;@10461
@@122:	db	65h, 62h, 75h, 67h	; bound si, dword ptr [di+67h]	;@10462
	db	20h, 69h, 6Eh	; and byte ptr [bx+di+6Eh], ch	;@10466
	db	66h, 6Fh	; outsd	;@10469
	and	byte ptr [bp+di+77h], dh	;@1046B
@@123:	imul	si, word ptr [si+63h], 2068h	;@1046E
	imul	sp, word ptr [bx+6Eh], 726Fh	;@10473
@@124:	db	65h, 64h, 20h, 66h, 6Fh	; and byte ptr [bp+6Fh], ah	;@10478
	db	72h, 20h	; jb @@128+2	;@1047D
	inc	bx	;@1047F
	dec	di	;@10480
	dec	bp	;@10481
@@125:	and	byte ptr [bp+69h], ah	;@10482
	insb	;@10485
	db	65h, 73h, 0	; jae @@126	;@10486
@@126:	db	4Eh	; dec si	;@10489
	outsw	;@1048A
	and	byte ptr [di+6Fh], ch	;@1048B
@@127:	db	64h, 75h, 6Ch	; jne @@134+3	;@1048E
	db	65h, 20h, 64h, 65h	; and byte ptr [si+65h], ah	;@10491
	db	66h, 69h, 6Eh, 69h, 74h, 69h, 6Fh, 6Eh	; imul ebp, dword ptr [bp+69h], 6E6F6974h	;@10495
@@128:	and	byte ptr [bp+69h], ah	;@1049D
	insb	;@104A0
	db	65h, 20h, 73h, 70h	; and byte ptr [bp+di+70h], dh	;@104A1
@@129:	db	65h, 63h, 69h, 66h	; arpl word ptr [bx+di+66h], bp	;@104A5
	imul	sp, word ptr [di+64h], 203Ah	;@104A9
	db	75h, 73h	; jne @@135	;@104AE
@@130:	imul	bp, word ptr [bp+67h], 6420h	;@104B0
	db	65h, 66h, 61h	; popal	;@104B5
	db	75h, 6Ch	; jne @@136+1	;@104B8
	db	74h, 73h	; je @@138	;@104BA
@@131:	add	byte ptr [bx+si], al	;@104BC
	add	byte ptr [bx+di], bl	;@104BE
	add	byte ptr [bp+si], dh	;@104C0
	db	0, 4Bh, 0	; add byte ptr [bp+di], cl	;@104C2
	db	59h	; pop cx	;@104C5
	db	0, 6Ch, 0	; add byte ptr [si], ch	;@104C6
	db	7Fh, 0	; jg @@132	;@104C9
@@132:	db	9Ah, 0, 0B7h, 0, 0CCh	; lcall 0xcc00, 0xb700	;@104CB
	db	0, 0E1h	; add cl, ah	;@104D0
@@133:	db	0, 0F8h	; add al, bh	;@104D2
	add	byte ptr [di], dl	;@104D4
	add	word ptr [bp+di], di	;@104D6
	add	word ptr [bp+si+1], dx	;@104D8
	insb	;@104DB
	add	word ptr [si-52FFh], cx	;@104DC
	db	1, 0D0h	; add ax, dx	;@104E0
	db	1, 0F4h	; add sp, si	;@104E2
	add	word ptr [di], sp	;@104E4
	add	dl, byte ptr [si+2]	;@104E6
	xchg	ax, bx	;@104E9
	add	dl, al	;@104EA
	add	cl, byte ptr [si]	;@104EC
	add	sp, word ptr [bx]	;@104EE
	add	di, word ptr [bx+di]	;@104F0
	add	cx, word ptr [bx+si+3]	;@104F2
	db	64h, 3, 7Eh, 3	; add di, word ptr [bp+3]	;@104F5
	db	98h	; cbw	;@104F9
@@134:	add	si, word ptr [bx+di-0CFDh]	;@104FA
	add	bp, word ptr [bp+si]	;@104FE
	add	al, 43h	;@10500
	add	al, 6Ah	;@10502
	add	al, 8Ch	;@10504
	add	al, 9Dh	;@10506
	add	al, 0C3h	;@10508
	add	al, 0D7h	;@1050A
	add	al, 8	;@1050C
	add	ax, 52Bh	;@1050E
	inc	si	;@10511
	add	ax, 561h	;@10512
	mov	word ptr [di], es	;@10515
	scasw	;@10517
	add	ax, 5DCh	;@10518
	or	ax, word ptr ds:[616h]	;@1051B
	daa	;@1051F
	push	es	;@10520
	dec	bp	;@10521
	push	es	;@10522
@@135:	push	si	;@10523
	push	es	;@10524
@@136:	db	72h, 6	; jb @@137+2	;@10525
	db	8Dh, 6, 0ADh, 6	; lea ax, ds:[6ADh]	;@10527
@@137:	db	0C8h, 6, 0FBh, 6	; enter 0FB06h, 6	;@1052B
@@138:	adc	ax, 5307h	;@1052F
	pop	es	;@10532
	jp	@@139	;@10533
	sahf	;@10535
	pop	es	;@10536
	enter	0EA07h, 7	;@10537
	pop	ss	;@1053B
@@139:	or	byte ptr [si+8], al	;@1053C
	jno	@@140+1	;@1053F
	cwd	;@10541
	or	byte ptr [bx+si], al	;@10542
	add	byte ptr [bx+si], al	;@10544
	add	byte ptr [bx+si], al	;@10546
@@140:	add	byte ptr [bx+si], al	;@10548
	add	byte ptr [bx+si], al	;@1054A
	add	byte ptr [bx+si], al	;@1054C
	add	byte ptr [bx+si], al	;@1054E
	add	byte ptr [bx+si], al	;@10550
	add	byte ptr [bx+si], al	;@10552
	add	byte ptr [bx+si], al	;@10554
	add	byte ptr [bx+si], al	;@10556
	add	byte ptr [bx+si], al	;@10558
	add	byte ptr [bx+si], al	;@1055A
	add	byte ptr [bx+si], al	;@1055C
	add	byte ptr [bx+si], al	;@1055E
	add	byte ptr [bx+si], al	;@10560
	add	byte ptr [bx+si], al	;@10562
	add	byte ptr [bx+si], al	;@10564
	add	byte ptr [bx+si], al	;@10566
	add	byte ptr [bx+si], al	;@10568
	add	byte ptr [bx+si], al	;@1056A
	add	byte ptr [bx+si], al	;@1056C
	add	byte ptr [bx+si], al	;@1056E
	add	byte ptr [bx+si], al	;@10570
	add	byte ptr [bx+si], al	;@10572
	add	byte ptr [bx+si], al	;@10574
	add	byte ptr [bx+si], al	;@10576
	add	byte ptr [bx+si], al	;@10578
	add	byte ptr [bx+si], al	;@1057A
	add	byte ptr [bx+si], al	;@1057C
	add	byte ptr [bx+si], al	;@1057E
	add	byte ptr [bx+si], al	;@10580
	add	byte ptr [bx+si], al	;@10582
	add	byte ptr [bx+si], al	;@10584
	add	byte ptr [bx+si], al	;@10586
	add	byte ptr [bx+si], al	;@10588
	add	byte ptr [bx+si], al	;@1058A
	add	byte ptr [bx+si], al	;@1058C
	add	byte ptr [bx+si], al	;@1058E
	add	byte ptr [bx+si], al	;@10590
	add	byte ptr [bx+si], al	;@10592
	add	byte ptr [bx+si], al	;@10594
	add	byte ptr [bx+si], al	;@10596
	add	byte ptr [bx+si], al	;@10598
	add	byte ptr [bx+si], al	;@1059A
	add	byte ptr [bx+si], al	;@1059C
	add	byte ptr [bx+si], al	;@1059E
	add	byte ptr [bx+si], al	;@105A0
	add	byte ptr [bx+si], al	;@105A2
	add	byte ptr [bx+si], al	;@105A4
	add	byte ptr [bx+si], al	;@105A6
	add	byte ptr [bx+si], al	;@105A8
	add	byte ptr [bx+si], al	;@105AA
	add	byte ptr [bx+si], al	;@105AC
	add	byte ptr [bx+si], al	;@105AE
	add	byte ptr [bx+si], al	;@105B0
	add	byte ptr [bx+si], al	;@105B2
	add	byte ptr [bx+si], al	;@105B4
	add	byte ptr [bx+si], al	;@105B6
	add	byte ptr [bx+si], al	;@105B8
	add	byte ptr [bx+si], al	;@105BA
	add	byte ptr [bx+si], al	;@105BC
	add	byte ptr [bx+si], al	;@105BE
	add	byte ptr [bx+si], al	;@105C0
	add	byte ptr [bx+si], al	;@105C2
	add	byte ptr [bx+si], al	;@105C4
	add	byte ptr [bx+si], al	;@105C6
	add	byte ptr [bx+si], al	;@105C8
	add	byte ptr [bx+si], al	;@105CA
	add	byte ptr [bx+si], al	;@105CC
	add	byte ptr [bx+si], al	;@105CE
	add	byte ptr [bx+si], al	;@105D0
	add	byte ptr [bx+si], al	;@105D2
	add	byte ptr [bx+si], al	;@105D4
	add	byte ptr [bx+si], al	;@105D6
	add	byte ptr [bx+si], al	;@105D8
	add	byte ptr [bx+si], al	;@105DA
	add	byte ptr [bx+si], al	;@105DC
	add	byte ptr [bx+si], al	;@105DE
	add	byte ptr [bx+si], al	;@105E0
	add	byte ptr [bx+si], al	;@105E2
	add	byte ptr [bx+si], al	;@105E4
	add	byte ptr [bx+si], al	;@105E6
	add	byte ptr [bx+si], al	;@105E8
	add	byte ptr [bx+si], al	;@105EA
	add	byte ptr [bx+si], al	;@105EC
	add	byte ptr [bx+si], al	;@105EE
	add	byte ptr [bx+si], al	;@105F0
	add	byte ptr [bx+si], al	;@105F2
	add	byte ptr [bx+si], al	;@105F4
	add	byte ptr [bx+si], al	;@105F6
	add	byte ptr [bx+si], al	;@105F8
	add	byte ptr [bx+si], al	;@105FA
	add	byte ptr [bx+si], al	;@105FC
	add	byte ptr [bx+si], al	;@105FE
	add	byte ptr [bx+si], al	;@10600
	add	byte ptr [bx+si], al	;@10602
	add	byte ptr [bx+si], al	;@10604
	add	byte ptr [bx+si], al	;@10606
	add	byte ptr [bx+si], al	;@10608
	add	byte ptr [bx+si], al	;@1060A
	add	byte ptr [bx+si], al	;@1060C
	add	byte ptr [bx+si], al	;@1060E
	add	byte ptr [bx+si], al	;@10610
	add	byte ptr [bx+si], al	;@10612
	add	byte ptr [bx+si], al	;@10614
	add	byte ptr [bx+si], al	;@10616
	add	byte ptr [bx+si], al	;@10618
	add	byte ptr [bx+si], al	;@1061A
	add	byte ptr [bx+si], al	;@1061C
	add	byte ptr [bx+si], al	;@1061E
	add	byte ptr [bx+si], al	;@10620
	add	byte ptr [bx+si], al	;@10622
	add	byte ptr [bx+si], al	;@10624
	add	byte ptr [bx+si], al	;@10626
	add	byte ptr [bx+si], al	;@10628
	add	byte ptr [bx+si], al	;@1062A
	add	byte ptr [bx+si], al	;@1062C
	add	byte ptr [bx+si], al	;@1062E
	add	byte ptr [bx+si], al	;@10630
	add	byte ptr [bx+si], al	;@10632
	add	byte ptr [bx+si], al	;@10634
	add	byte ptr [bx+si], al	;@10636
	add	byte ptr [bx+si], al	;@10638
	add	byte ptr [bx+si], al	;@1063A
	add	byte ptr [bx+si], al	;@1063C
	add	byte ptr [bx+si], al	;@1063E
	add	byte ptr [bx+si], al	;@10640
	add	byte ptr [bx+si], al	;@10642
	add	byte ptr [bx+si], al	;@10644
	add	byte ptr [bx+si], al	;@10646
	add	byte ptr [bx+si], al	;@10648
	add	byte ptr [bx+si], al	;@1064A
	add	byte ptr [bx+si], al	;@1064C
	add	byte ptr [bx+si], al	;@1064E
Y0FCF0	ends

Y10650	segment para public 'CODE'
	assume	cs:Y10650
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@10650
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 'VDISK', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0
	db	0FFh, 0FFh, 0, 0, 0, 92h, 0, 0, 0FFh, 0FFh, 0, 0, 0, 92h, 0, 0
	db	0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0, 0, 93h, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 'VDISK FAKE', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0
	db	0, 0, 0, 0, 2Eh, 0FFh, 2Eh, 2Fh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 1Fh, 0, 0A0h, 0BCh, 1, 0, 0, 0, 2Fh, 0, 20h, 0, 1, 0
	db	0, 0, 3Fh, 0, 6Eh, 0, 1, 0, 0, 0, 4Fh, 0, 8, 0Eh, 1, 0, 0Eh, 0
Y10650	ends

Y10E50	segment para public 'CODE'
	assume	cs:Y10E50
	db	6Fh, 0, 8, 0, 1, 0, 8, 0, 6Fh, 0, 29h, 0, 1, 0, 8, 0, 7Fh, 0, 24h	;@10E50
	db	0, 1, 0, 9, 0, 8Fh, 0, 4Ch, 0, 1, 0, 4, 0, 9Fh, 0, 3Ah, 0, 1, 0
	db	0Ch, 0, 0AFh, 0, 89h, 0, 1, 0, 0Ah, 0, 0BFh, 0, 5Eh, 0, 1, 0, 9
	db	0, 0CFh, 0, 9Eh, 0, 1, 0, 0Eh, 0, 0DFh, 0, 0B8h, 2Eh, 1, 0, 0Eh
	db	0, 0E7h, 0, 60h, 9, 0, 0, 0, 0, 0F7h, 0, 0, 8, 0, 0, 0, 0, 37h
	db	1, 0, 0, 1, 0, 0, 0, 37h, 1, 0, 0, 0, 0, 0, 0, 37h, 1, 0, 0, 0
	db	0, 0, 0
Y10E50	ends

Y10EC0	segment para public 'CODE'
	assume	cs:Y10EC0
	db	37h, 1, 0D8h, 1, 0, 0, 0, 0, 57h, 1, 0FFh, 0FFh, 4, 0, 0, 0	;@10EC0
Y10EC0	ends

Y10ED0	segment para public 'CODE'
	assume	cs:Y10ED0
	db	57h, 1, 0FFh, 0FFh, 4, 0, 0, 0, 67h, 1, 0FFh, 0FFh, 4, 0, 0, 0	;@10ED0
Y10ED0	ends

Y10EE0	segment para public 'CODE'
	assume	cs:Y10EE0
	db	77h, 1, 0FFh, 0FFh, 4, 0, 0, 0, 87h, 1, 0FFh, 0FFh, 4, 0, 0, 0	;@10EE0
	db	97h, 1, 0B0h, 1, 0, 0, 0, 0, 0A7h, 1, 22h, 6, 0, 0, 0, 0, 0B7h
	db	1, 3, 0, 4, 0, 4, 0, 0D7h, 1, 0, 0, 0, 0, 0, 0, 0D7h, 1, 0D8h
	db	0FCh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
Y10EE0	ends

Y10F30	segment para public 'CODE'
	assume	cs:Y10F30
	db	6, 'DGROUP', 7, 'BEGDATA', 7, 'ENDCODE', 3, 'BSS', 7, 'FAR_BSS'	;@10F30
	db	9, '__GHOST__', 6, 'DEBSYM', 6, 'DEBTYP', 8, '_COMDEF_', 5, 'STACK'
	db	4, 'CODE', 4, '????', 8, '@OVYDATA', 7, 'STUBSEG', 9, '_EXEINFO_'
	db	7, 'OVRINFO', 0Ch, '__SEGTABLE__', 0Dh, '__SEGTABEND__', 0Bh, '__OVRTRAP__'
	db	0Bh, '__EXENAME__', 0Bh, '__EXEDATE__', 0Ch, '__OvrPrepare', 5
	db	'_TEXT', 6, '_edata', 4, '_end', 6, 'FIARQQ', 6, 'FISRQQ', 6, 'FICRQQ'
	db	6, 'FIERQQ', 6, 'FIDRQQ', 6, 'FIWRQQ', 6
Y10F30	ends

Y11030	segment para public 'CODE'
	assume	cs:Y11030
	db	'FJARQQ', 6, 'FJSRQQ', 6, 'FJCRQQ', 5, '__WEP', 3, 'WEPJ', 0, 4Ch	;@11030
	db	4, 80h, 65h, 0, 54h, 4, 80h, 6Fh, 0, 56h, 4, 80h, 5Dh, 0, 52h
	db	4, 80h, 0, 0, 24h, 4, 80h, 7, 0, 2Eh, 4, 80h, 0Fh, 0, 30h, 4, 80h
	db	17h, 0, 26h, 4, 80h, 1Bh, 0, 28h, 4, 80h, 3Bh, 0, 2Ah, 4, 80h
	db	44h, 0, 2Ch, 4, 80h, 23h, 0, 36h, 4, 80h, 0C3h, 0, 38h, 4, 80h
	db	2Dh, 0, 32h, 4, 80h, 34h, 0, 34h, 4, 80h, 4Fh, 0, 4Eh, 4, 80h
	db	54h, 0, 50h, 4, 80h, 0D5h, 0, 60h, 4, 0, 0DCh, 0, 62h, 4, 0, 0E3h
	db	0, 64h, 4, 0, 0EAh, 0, 66h, 4, 0, 0F1h, 0, 68h, 4, 0, 0F8h, 0
	db	6Ah, 4, 0, 0FFh, 0, 6Ch, 4, 0, 6, 1, 6Eh, 4, 0, 0Dh, 1, 70h, 4
	db	0, 1Ah, 1, 72h, 4, 0, 14h, 1, 74h, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0A8h, 0, 0ACh, 0, 0AEh, 0, 0B2h, 0, 0B4h, 0, 0B8h, 0, 0BAh
	db	0, 0BEh, 0, 0C0h, 0, 0C5h, 0, 0C8h, 0, 0CCh, 0, 0CFh, 0, 0D4h
	db	0, 0D7h, 0, 0DBh, 0, 0DDh, 0, 0E1h, 0, 0E4h, 0, 0E9h, 0, 0F0h
	db	0, 0F4h, 0, 0F6h, 0, 0FAh, 0, 0FDh, 0, 1, 1, 4, 1, 8, 1, 0Ah, 1
	db	0Eh, 1, 11h, 1, 15h, 1, 17h, 1, 1Bh, 1, 1Eh, 1, 22h, 1, 25h, 1
	db	29h, 1, 2Bh, 1, 2Fh, 1, 31h, 1, 35h, 1, 37h, 1, 3Bh, 1, 3Eh, 1
	db	42h, 1, 46h, 1, 4Ah, 1, 4Ch, 1, 4Fh, 1, 51h, 1, 56h, 1, 59h, 1
	db	5Eh, 1, 61h, 1, 66h, 1, 6Ah, 1, 6Fh, 1, 72h, 1, 77h, 1, 7Ah, 1
	db	7Fh, 1, 82h, 1, 86h, 1, 89h, 1, 8Eh, 1, 91h, 1, 96h, 1, 9Ah, 1
	db	9Eh, 1, 0A1h, 1, 0A6h, 1, 0A9h, 1, 0ADh, 1, 0AFh, 1, 0B4h, 1, 0B7h
	db	1, 0BBh, 1, 0BDh, 1, 0C2h, 1, 0, 0, 0, 0, 'add', 0, 2Bh, 0, 'adr'
	db	0, 26h, 0, 'and', 0, 26h, 0, 'asg', 0, 3Dh, 0, 'land', 0, 26h
	db	26h, 0, 'lor', 0, 7Ch, 7Ch, 0, 'call', 0, 28h, 29h, 0, 'cmp', 0
	db	7Eh, 0, 'dec', 0, 2Dh, 2Dh, 0, 'dele', 0, 'delete', 0, 'div', 0
	db	2Fh, 0, 'eql', 0, 3Dh, 3Dh, 0, 'geq'
Y11030	ends

Y111E0	segment para public 'CODE'
	assume	cs:Y111E0
	db	0, 3Eh, 3Dh, 0, 'gtr', 0, 3Eh, 0, 'inc', 0, 2Bh, 2Bh, 0, 'ind'	;@111E0
	db	0, 2Ah, 0, 'leq', 0, 3Ch, 3Dh, 0, 'lsh', 0, 3Ch, 3Ch, 0, 'lss'
	db	0, 3Ch, 0, 'mod', 0, 25h, 0, 'mul', 0, 2Ah, 0, 'neq', 0, 21h, 3Dh
	db	0, 'new', 0, 'new', 0, 'not', 0, 21h, 0, 6Fh, 72h, 0, 7Ch, 0, 'rand'
	db	0, 26h, 3Dh, 0, 'rdiv', 0, 2Fh, 3Dh, 0, 'rlsh', 0, '<<=', 0, 'rmin'
	db	0, 2Dh, 3Dh, 0, 'rmod', 0, 25h, 3Dh, 0, 'rmul', 0, 2Ah, 3Dh, 0
	db	'ror', 0, 7Ch, 3Dh, 0, 'rplu', 0, 2Bh, 3Dh, 0, 'rrsh', 0, '>>='
	db	0, 'rsh', 0, 3Eh, 3Eh, 0, 'rxor', 0, 5Eh, 3Dh, 0, 'sub', 0, 2Dh
	db	0, 'subs', 0, 5Bh, 5Dh, 0, 'xor', 0, 5Eh, 0, 'arow', 0, 2Dh, 3Eh
	db	0, ' huge ', 0, ' _seg ', 0, 'unsigned ', 0, 0, 'const ', 0, 'volatile '
	db	0, 'void', 0, 'char', 0, 'short', 0, 'int', 0, 'long', 0, 'float'
	db	0, 'double', 0, 'long double', 0, '...', 0, ' near', 0, ' far'
	db	0, ' const', 0, ' volatile', 0, 'ctr', 0, 'dtr', 0, '...', 0, 'operator '
	db	0, 'operator ', 0, ' const', 0, ' volatile', 0, 0, '         !!                     '
	db	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 14h, 14h, 14h, 14h, 14h, 14h
	db	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0
	db	0, 0, 0, 0, 0, 18h, 18h, 18h, 18h, 18h, 18h, 8, 8, 8, 8, 8, 8
	db	8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 20h, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, '$*$*$*', 0, 1, 0, 6, 'YOM', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0
Y111E0	ends

Y115B0	segment para public 'CODE'
	assume	cs:Y115B0
	db	260h dup (0)	;@115B0
Y115B0	ends

Y11810	segment para public 'CODE'
	assume	cs:Y11810
	db	0FBE0h dup (0)	;@11810
Y11810	ends

Y213F0	segment byte public 'OVRDATA'
	db	'FBOV', 0, 0, 0, 0, 30h, 12h, 1, 0, 1Dh, 0, 0, 0	;@213F0
Y213F0	ends
	end	start
