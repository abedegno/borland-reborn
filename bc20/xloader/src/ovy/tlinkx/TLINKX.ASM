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
MSG_NO_MEMORY:	dec	si	;@0013B
	outsw	;@0013C
	db	74h, 20h	; je @@1	;@0013D
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@0013F
	outsw	;@00141
	db	75h, 67h	; jne @@3	;@00142
	push	6D20h	;@00144
	db	65h, 6Dh	; insw	;@00147
	db	6Fh	; outsw	;@00149
	jb	@@5+1	;@0014A
	or	ax, 240Ah	;@0014C
	push	ax	;@0014F
	push	bx	;@00150
	push	dx	;@00151
	push	ds	;@00152
	mov	ds, word ptr cs:L00100+16	;@00153
	cmp	byte ptr ds:[11Eh], 0FFh	;@00158
	jne	@@2	;@0015D
@@1:	mov	bx, word ptr ds:[24h]	;@0015F
	call	CLOSE_FILE	;@00163
	mov	word ptr ds:[24h], 0FFFFh	;@00166
	db	0E8h, 0EFh, 8Eh	; call L0905E	;@0016C
	call	L0012E	;@0016F
@@2:	pop	ds	;@00172
	pop	dx	;@00173
	pop	bx	;@00174
	pop	ax	;@00175
	stc	;@00176
	retf	;@00177
	db	0A1h, 0Eh, 0, 5, 0Fh, 0, 0B1h, 4, 0D3h, 0E8h, 29h, 6, 6, 0, 16h	;@00178
	db	1Fh, 0B8h, 0FFh, 0FFh, 50h, 0B8h, 0FFh, 0FFh, 50h, 9Ah, 3Bh, 2Eh
	db	0DFh, 0, 2Eh, 8Eh, 1Eh, 10h, 0, 8Bh, 0C2h, 0Bh, 0C0h, 'tEP', 0A1h
	db	4, 0, 48h, 50h, 0B8h, 80h, 0, 50h, 0Eh
@@3:	mov	ax, 2A0h	;@001AB
	push	ax	;@001AE
	xor	ax, ax	;@001AF
	push	ax	;@001B1
	push	ax	;@001B2
	db	9Ah, 62h, 1Ch, 0DFh, 0	; lcall 0xdf, 0x1c62	;@001B3
	and	ax, ax	;@001B8
	je	@@4	;@001BA
	jmp	L0029E+2	;@001BC
@@4:	cmp	byte ptr ds:[8], 1	;@001BF
@@5:	jne	@@6	;@001C4
	push	ax	;@001C6
	push	ax	;@001C7
	push	ax	;@001C8
	push	ax	;@001C9
	db	9Ah, 33h, 29h, 0DFh, 0	; lcall 0xdf, 0x2933	;@001CA
@@6:	cmp	byte ptr ds:[9], 1	;@001CF
	jne	@@7	;@001D4
	push	ax	;@001D6
	push	ax	;@001D7
	push	ax	;@001D8
	db	9Ah, 0D6h, 27h, 0DFh, 0	; lcall 0xdf, 0x27d6	;@001D9
@@7:	mov	word ptr ds:[1Eh], 1	;@001DE
	ret	;@001E4
	db	33h, 0C0h, 50h, 0B8h, 19h, 0, 50h, 0E8h, 0B2h, 0B9h	;@001E5
STARTUP:	mov	ax, 1A7h	;@001EF
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
	db	0E8h, 4Ch, 0	; call CLOSE_FILE	;@00277
	mov	bx, word ptr ds:[24h]	;@0027A
	db	0E8h, 45h, 0	; call CLOSE_FILE	;@0027E
	ret	;@00281
start:	cld	;@00282
	call	STARTUP	;@00283
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
	db	0E8h, 84h, 52h	; call L0552C	;@002A5
	xor	ax, ax	;@002A8
	push	ax	;@002AA
	mov	ax, 3	;@002AB
	push	ax	;@002AE
	db	0E8h, 0EFh, 0B8h	; call FATAL	;@002AF
DOS_CALL:	push	bx	;@002B2
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
	db	0E8h, 0DBh, 0B8h	; call FATAL	;@002C3
CLOSE_FILE:	or	bx, bx	;@002C6
	je	@@1	;@002C8
	cmp	bx, -1	;@002CA
	je	@@1	;@002CD
	mov	ah, 3Eh	;@002CF
	call	DOS_CALL	;@002D1
@@1:	ret	;@002D4
DOS_CALL_FULL:	cmp	ah, 40h	;@002D5
	jne	DOS_CALL	;@002D8
	call	DOS_CALL	;@002DA
	cmp	ax, cx	;@002DD
	je	@@1	;@002DF
	xor	cx, cx	;@002E1
	push	cx	;@002E3
	mov	ax, 2	;@002E4
	push	ax	;@002E7
	db	0E8h, 0B6h, 0B8h	; call FATAL	;@002E8
@@1:	ret	;@002EB
OPEN_FILE:	push	ax	;@002EC
	push	cx	;@002ED
	push	dx	;@002EE
	int	21h	;@002EF
	pop	dx	;@002F1
	pop	cx	;@002F2
	pop	bx	;@002F3
	cld	;@002F4
	jb	@@1	;@002F5
	ret	;@002F7
@@1:	cmp	ax, 4	;@002F8
	jne	@@2	;@002FB
	push	bx	;@002FD
	push	cx	;@002FE
	push	ds	;@002FF
	mov	ds, word ptr cs:L00100+16	;@00300
	db	0E8h, 71h, 8Eh	; call L09179	;@00305
	pop	ds	;@00308
	pop	cx	;@00309
	pop	ax	;@0030A
	jae	OPEN_FILE	;@0030B
@@2:	push	ds	;@0030D
	push	dx	;@0030E
	mov	ax, 4	;@0030F
	push	ax	;@00312
	mov	ax, 1	;@00313
	push	ax	;@00316
	db	0E8h, 87h, 0B8h	; call FATAL	;@00317
FILE_SIZE:	push	bx	;@0031A
	push	cx	;@0031B
	mov	ah, 4Eh	;@0031C
	xor	cx, cx	;@0031E
	int	21h	;@00320
	jb	@@2	;@00322
	mov	ah, 2Fh	;@00324
	int	21h	;@00326
	mov	ax, word ptr es:[bx+1Ah]	;@00328
	mov	dx, word ptr es:[bx+1Ch]	;@0032C
@@1:	pop	cx	;@00330
	pop	bx	;@00331
	ret	;@00332
@@2:	xor	ax, ax	;@00333
	cwd	;@00335
	jmp	@@1	;@00336
	db	8 dup (0)	;@00338
L00340:	cmp	byte ptr ds:[11Ch], 0FFh	;@00340
	je	@@1	;@00345
	mov	al, 0FFh	;@00347
	xchg	byte ptr ds:[11Ch], al	;@00349
	mov	ah, al	;@0034D
	ret	;@0034F
@@1:	push	dx	;@00350
	push	cx	;@00351
	push	bx	;@00352
	mov	al, 2Ch	;@00353
	cmp	byte ptr ds:[118h], 1	;@00355
	je	@@4	;@0035A
	mov	bx, word ptr ds:[20h]	;@0035C
	cmp	bx, -1	;@00360
	jne	@@2	;@00363
	mov	es, word ptr ds:[0]	;@00365
	mov	bx, word ptr ds:[2]	;@00369
	mov	cl, byte ptr es:[bx]	;@0036D
	sub	ch, ch	;@00370
	mov	bx, word ptr ds:[150h]	;@00372
	cmp	bx, cx	;@00376
	mov	al, 3Bh	;@00378
	ja	@@4	;@0037A
	mov	al, byte ptr es:[bx+80h]	;@0037C
	inc	word ptr ds:[150h]	;@00381
	jmp	short @@4	;@00385
@@2:	mov	ah, 3Fh	;@00387
	mov	cx, 1	;@00389
	mov	dx, 11Ah	;@0038C
	int	21h	;@0038F
	cld	;@00391
	and	ax, ax	;@00392
	mov	al, byte ptr ds:[11Ah]	;@00394
	jne	@@4	;@00397
	mov	word ptr ds:[20h], 0FFFFh	;@00399
	call	CLOSE_FILE	;@0039F
	cmp	byte ptr ds:[15Ch], 1	;@003A2
	jne	@@3	;@003A7
	dec	byte ptr ds:[15Ch]	;@003A9
@@3:	mov	al, 20h	;@003AD
@@4:	pop	bx	;@003AF
	pop	cx	;@003B0
	pop	dx	;@003B1
	mov	ah, al	;@003B2
	cmp	al, 41h	;@003B4
	jb	@@5	;@003B6
	cmp	al, 5Ah	;@003B8
	ja	@@5	;@003BA
	add	al, 20h	;@003BC
@@5:	ret	;@003BE
GET_HEX_DIGIT:	call	L00340	;@003BF
	sub	al, 30h	;@003C2
	cmp	al, 9	;@003C4
	jbe	@@1	;@003C6
	sub	al, 27h	;@003C8
@@1:	ret	;@003CA
TEN:	or	al, byte ptr [bx+si]	;@003CB
GET_NUMBER:	xor	bx, bx	;@003CD
	call	L00340	;@003CF
	cmp	al, 30h	;@003D2
	jb	@@5	;@003D4
	cmp	al, 39h	;@003D6
	ja	@@5	;@003D8
@@1:	and	ax, 0Fh	;@003DA
	xchg	ax, bx	;@003DD
	mul	word ptr cs:L004CA+1	;@003DE
	jb	@@5	;@003E3
	add	bx, ax	;@003E5
	jb	@@3	;@003E7
	call	L00340	;@003E9
	cmp	al, 30h	;@003EC
	jb	@@2	;@003EE
	cmp	al, 39h	;@003F0
	jbe	@@1	;@003F2
@@2:	mov	byte ptr ds:[11Ch], ah	;@003F4
	clc	;@003F8
	jmp	short @@7	;@003F9
@@3:	call	L00340	;@003FB
	cmp	al, 30h	;@003FE
	jb	@@6	;@00400
	cmp	al, 39h	;@00402
	ja	@@6	;@00404
@@4:	mov	byte ptr ds:[11Ch], ah	;@00406
@@5:	stc	;@0040A
	jmp	short @@7	;@0040B
@@6:	cmp	bx, 0	;@0040D
	jne	@@4	;@00410
@@7:	ret	;@00412
PARSE_OPTION:	push	bx	;@00413
L00414:	mov	al, byte ptr ds:[159h]	;@00414
	mov	byte ptr ds:[158h], al	;@00417
	mov	byte ptr ds:[159h], 0FFh	;@0041A
	call	L00340	;@0041F
	cmp	word ptr ds:[154h], 0	;@00422
	jne	L00494	;@00427
	cmp	word ptr ds:[156h], 0	;@00429
	jne	L00471	;@0042E
	cmp	al, byte ptr ds:[15Ah]	;@00430
	jne	@@1	;@00434
	mov	ah, 1	;@00436
	jmp	L00554	;@00438
@@1:	sub	bh, bh	;@0043B
	mov	bl, al	;@0043D
	mov	ah, byte ptr cs:[bx+8DFh]	;@0043F
	cmp	ah, 0	;@00444
	jne	@@2	;@00447
	jmp	L00782	;@00449
@@2:	cmp	ah, 2	;@0044C
	jae	@@3	;@0044F
	jmp	L0050D	;@00451
@@3:	jbe	L00459	;@00454
	jmp	L004EE	;@00456
L00459:	mov	byte ptr ds:[119h], 0	;@00459
	cmp	al, 2Eh	;@0045E
	jne	@@1	;@00460
	jmp	L004FD	;@00462
@@1:	cmp	al, 5Ch	;@00465
	jne	L0046C	;@00467
	jmp	L00505	;@00469
L0046C:	cmp	ah, 2	;@0046C
	pop	bx	;@0046F
	ret	;@00470
L00471:	mov	byte ptr ds:[11Ch], ah	;@00471
	mov	bx, word ptr ds:[156h]	;@00475
	cmp	bh, 0	;@00479
	jne	@@1	;@0047C
	mov	al, bl	;@0047E
	mov	ah, 2	;@00480
	mov	bh, 1	;@00482
	mov	word ptr ds:[156h], bx	;@00484
	jmp	L0046C	;@00488
@@1:	mov	ah, 1	;@0048A
	mov	word ptr ds:[156h], 0	;@0048C
	jmp	L0046C	;@00492
L00494:	mov	bx, word ptr ds:[154h]	;@00494
	cmp	bh, 0	;@00498
	je	@@2	;@0049B
	mov	byte ptr ds:[11Dh], 0	;@0049D
	cmp	al, 28h	;@004A2
	jne	@@1	;@004A4
	mov	byte ptr ds:[11Dh], 1	;@004A6
@@1:	mov	byte ptr ds:[11Ch], al	;@004AB
	mov	ah, bh	;@004AE
	mov	bh, 0	;@004B0
	mov	word ptr ds:[154h], bx	;@004B2
@@2:	mov	al, ah	;@004B6
	sub	bh, bh	;@004B8
	mov	bl, al	;@004BA
	mov	ah, byte ptr cs:[bx+8DFh]	;@004BC
	cmp	byte ptr ds:[11Dh], 1	;@004C1
	jne	L004D0	;@004C6
	mov	ah, 1	;@004C8
L004CA:	cmp	al, 29h	;@004CA
	je	L004DE	;@004CC
	jmp	short L004DA	;@004CE
L004D0:	cmp	ah, 1	;@004D0
	je	L004DE	;@004D3
	cmp	ah, 3	;@004D5
	je	L004DE	;@004D8
L004DA:	mov	ah, 2	;@004DA
	jmp	L0046C	;@004DC
L004DE:	cmp	al, 2Bh	;@004DE
	jne	@@1	;@004E0
	mov	byte ptr ds:[11Ch], al	;@004E2
@@1:	mov	word ptr ds:[154h], 0	;@004E5
	jmp	L0046C	;@004EB
L004EE:	cmp	al, 3Bh	;@004EE
	je	@@1	;@004F0
	jmp	L0046C	;@004F2
@@1:	mov	byte ptr ds:[118h], 1	;@004F5
	jmp	L0046C	;@004FA
L004FD:	mov	byte ptr ds:[11Bh], 1	;@004FD
	jmp	L0046C	;@00502
L00505:	mov	byte ptr ds:[11Bh], 0	;@00505
	jmp	L0046C	;@0050A
L0050D:	cmp	al, 2Fh	;@0050D
	je	L00554	;@0050F
	cmp	al, 2Dh	;@00511
	jne	@@1	;@00513
	cmp	byte ptr ds:[158h], 1	;@00515
	je	L00554	;@0051A
	mov	ah, 2	;@0051C
	jmp	L00459	;@0051E
@@1:	mov	byte ptr ds:[159h], 1	;@00521
	cmp	al, 2Bh	;@00526
	je	@@5	;@00528
	cmp	al, 0Ah	;@0052A
	je	@@2	;@0052C
	jmp	L0046C	;@0052E
@@2:	cmp	byte ptr ds:[15Ch], 1	;@00531
	jne	@@3	;@00536
	jmp	L0046C	;@00538
@@3:	cmp	byte ptr ds:[119h], 1	;@0053B
	jne	@@4	;@00540
	jmp	L0046C	;@00542
@@4:	mov	al, 2Ch	;@00545
	mov	ah, 3	;@00547
	jmp	L0046C	;@00549
@@5:	mov	byte ptr ds:[119h], 1	;@0054C
	jmp	L0046C	;@00551
L00554:	call	L00340	;@00554
	push	ax	;@00557
	mov	byte ptr ds:[119h], 0	;@00558
	cmp	ah, 6Fh	;@0055D
	jne	@@1	;@00560
	jmp	L007EF	;@00562
@@1:	cmp	ah, 76h	;@00565
	jne	@@2	;@00568
	jmp	L0078C	;@0056A
@@2:	cmp	ah, 79h	;@0056D
	jne	@@3	;@00570
	jmp	L00766	;@00572
@@3:	cmp	ah, 54h	;@00575
	jne	@@4	;@00578
	jmp	L006CE	;@0057A
@@4:	cmp	ah, 44h	;@0057D
	jne	@@5	;@00580
	jmp	L00745	;@00582
@@5:	cmp	ah, 43h	;@00585
	jne	@@6	;@00588
	jmp	L007B8	;@0058A
@@6:	cmp	ah, 5Ah	;@0058D
	jne	@@7	;@00590
	jmp	L007D8	;@00592
@@7:	cmp	ah, 4Ch	;@00595
	jne	@@8	;@00598
	jmp	L00846	;@0059A
@@8:	cmp	ah, 50h	;@0059D
	jne	@@9	;@005A0
	jmp	L00878	;@005A2
@@9:	cmp	ah, 41h	;@005A5
	jne	L005AD	;@005A8
	jmp	L008BB	;@005AA
L005AD:	call	L00340	;@005AD
	xor	bh, bh	;@005B0
	mov	bl, al	;@005B2
	cmp	byte ptr cs:[bx+8DFh], 2	;@005B4
	je	L005AD	;@005BA
	mov	byte ptr ds:[11Ch], al	;@005BC
	pop	cx	;@005BF
	xor	ax, ax	;@005C0
	mov	bx, 1	;@005C2
	cmp	ch, 6Dh	;@005C5
	jne	@@1	;@005C8
	jmp	@@16	;@005CA
@@1:	cmp	ch, 76h	;@005CD
	je	@@11	;@005D0
	cmp	ch, 63h	;@005D2
	je	@@12	;@005D5
	cmp	ch, 69h	;@005D7
	je	@@13	;@005DA
	cmp	ch, 6Ch	;@005DC
	je	@@14	;@005DF
	cmp	ch, 78h	;@005E1
	je	@@15	;@005E4
	cmp	ch, 73h	;@005E6
	jne	@@2	;@005E9
	db	0E9h, 7Eh, 0	; jmp near ptr @@17	;@005EB
@@2:	cmp	ch, 64h	;@005EE
	jne	@@3	;@005F1
	jmp	@@18	;@005F3
@@3:	cmp	ch, 33h	;@005F6
	jne	@@4	;@005F9
	jmp	@@19	;@005FB
@@4:	cmp	ch, 65h	;@005FE
	jne	@@5	;@00601
	jmp	@@20	;@00603
@@5:	cmp	ch, 6Eh	;@00606
	je	@@10	;@00609
	cmp	ch, 74h	;@0060B
	jne	@@6	;@0060E
	jmp	L00718	;@00610
@@6:	cmp	ch, 68h	;@00613
	jne	@@7	;@00616
	jmp	L008DC	;@00618
@@7:	cmp	ch, 48h	;@0061B
	jne	@@8	;@0061E
	jmp	L008DC	;@00620
@@8:	cmp	ch, 3Fh	;@00623
	jne	@@9	;@00626
	jmp	L008DC	;@00628
@@9:	jmp	L00778	;@0062B
@@10:	mov	byte ptr ds:[125h], bl	;@0062E
	jmp	L00414	;@00632
@@11:	mov	byte ptr ds:[126h], 1	;@00635
	jmp	L00414	;@0063A
@@12:	mov	byte ptr ds:[122h], bl	;@0063D
	jmp	L00414	;@00641
@@13:	mov	byte ptr ds:[123h], bl	;@00644
	jmp	L00414	;@00648
@@14:	mov	byte ptr ds:[121h], bl	;@0064B
	jmp	L00414	;@0064F
@@15:	mov	byte ptr ds:[13h], al	;@00652
	mov	byte ptr ds:[121h], al	;@00655
	mov	byte ptr ds:[14h], al	;@00658
	mov	byte ptr ds:[15h], al	;@0065B
	jmp	L00414	;@0065E
@@16:	mov	byte ptr ds:[13h], bl	;@00661
	mov	byte ptr ds:[14h], bl	;@00665
	jmp	L00414	;@00669
@@17:	mov	byte ptr ds:[13h], bl	;@0066C
	mov	byte ptr ds:[14h], bl	;@00670
	mov	byte ptr ds:[15h], bl	;@00674
	jmp	L00414	;@00678
@@18:	mov	byte ptr ds:[124h], bl	;@0067B
	jmp	L00414	;@0067F
@@19:	mov	byte ptr ds:[127h], bl	;@00682
	jmp	L00414	;@00686
@@20:	mov	byte ptr ds:[254h], bl	;@00689
	jmp	L00414	;@0068D
L00690:	call	L00340	;@00690
	cmp	al, 2Bh	;@00693
	je	@@1	;@00695
	cmp	al, 2Dh	;@00697
	je	@@2	;@00699
	mov	byte ptr ds:[11Ch], ah	;@0069B
@@1:	mov	byte ptr ds:[8], 1	;@0069F
	jmp	L00414	;@006A4
@@2:	mov	byte ptr ds:[8], 0	;@006A7
	jmp	L00414	;@006AC
L006AF:	call	L00340	;@006AF
	cmp	al, 2Bh	;@006B2
	je	@@1	;@006B4
	cmp	al, 2Dh	;@006B6
	je	@@2	;@006B8
	mov	byte ptr ds:[11Ch], ah	;@006BA
@@1:	mov	byte ptr ds:[9], 1	;@006BE
	jmp	L00414	;@006C3
@@2:	mov	byte ptr ds:[9], 0	;@006C6
	jmp	L00414	;@006CB
L006CE:	pop	cx	;@006CE
	mov	bx, 1	;@006CF
	call	L00340	;@006D2
	cmp	al, 64h	;@006D5
	je	@@1	;@006D7
	cmp	al, 77h	;@006D9
	je	@@2	;@006DB
	cmp	al, 6Fh	;@006DD
	je	@@3	;@006DF
	cmp	al, 70h	;@006E1
	je	@@4	;@006E3
	jmp	L00778	;@006E5
@@1:	mov	byte ptr ds:[12Ah], 1	;@006E8
	jmp	short @@5	;@006ED
@@2:	mov	byte ptr ds:[12Ah], 2	;@006EF
	jmp	short @@5	;@006F4
@@3:	mov	byte ptr ds:[12Ah], 3	;@006F6
	jmp	short @@5	;@006FB
@@4:	mov	byte ptr ds:[12Ah], 4	;@006FD
@@5:	call	L00340	;@00702
	cmp	al, 63h	;@00705
	je	L00718	;@00707
	cmp	al, 65h	;@00709
	je	L0072D	;@0070B
	cmp	al, 64h	;@0070D
	je	L00735	;@0070F
	mov	byte ptr ds:[11Ch], ah	;@00711
	jmp	L00414	;@00715
L00718:	mov	byte ptr ds:[12Ah], 1	;@00718
	mov	byte ptr ds:[12Bh], 1	;@0071D
	mov	ax, 6F63h	;@00722
	mov	bl, 6Dh	;@00725
	db	0E8h, 0Bh, 8Ch	; call L09335	;@00727
	jmp	L00414	;@0072A
L0072D:	mov	byte ptr ds:[12Bh], 2	;@0072D
	jmp	L00414	;@00732
L00735:	mov	byte ptr ds:[12Bh], 3	;@00735
	mov	ax, 6C64h	;@0073A
	mov	bl, 6Ch	;@0073D
	db	0E8h, 0F3h, 8Bh	; call L09335	;@0073F
	jmp	L00414	;@00742
L00745:	pop	cx	;@00745
	mov	bx, 1	;@00746
	call	L00340	;@00749
	cmp	al, 2Bh	;@0074C
	je	@@1	;@0074E
	cmp	al, 2Dh	;@00750
	je	@@2	;@00752
	mov	byte ptr ds:[11Ch], ah	;@00754
@@1:	mov	byte ptr ds:[18h], bl	;@00758
	jmp	L00414	;@0075C
@@2:	mov	byte ptr ds:[18h], bh	;@0075F
	jmp	L00414	;@00763
L00766:	pop	cx	;@00766
	call	L00340	;@00767
	cmp	al, 78h	;@0076A
	jne	@@1	;@0076C
	jmp	L00690	;@0076E
@@1:	cmp	al, 65h	;@00771
	jne	L00778	;@00773
	jmp	L006AF	;@00775
L00778:	xor	ax, ax	;@00778
	push	ax	;@0077A
	mov	ax, 1Ah	;@0077B
	push	ax	;@0077E
	db	0E8h, 1Fh, 0B4h	; call FATAL	;@0077F
L00782:	xor	ax, ax	;@00782
	push	ax	;@00784
	mov	ax, 1Bh	;@00785
	push	ax	;@00788
	db	0E8h, 15h, 0B4h	; call FATAL	;@00789
L0078C:	call	L00340	;@0078C
	cmp	al, 2Dh	;@0078F
	je	@@2	;@00791
	cmp	al, 2Bh	;@00793
	je	@@1	;@00795
	mov	byte ptr ds:[11Ch], ah	;@00797
	jmp	L005AD	;@0079B
@@1:	mov	bx, 3	;@0079E
	jmp	short @@3	;@007A1
@@2:	mov	bx, 4	;@007A3
@@3:	cmp	byte ptr ds:[15Bh], 1	;@007A6
	je	@@4	;@007AB
	pop	cx	;@007AD
	jmp	L00414	;@007AE
@@4:	mov	word ptr ds:[156h], bx	;@007B1
	pop	cx	;@007B5
	jmp	short L0081E	;@007B6
L007B8:	pop	cx	;@007B8
	call	L00340	;@007B9
	cmp	al, 2Dh	;@007BC
	je	@@2	;@007BE
	cmp	al, 2Bh	;@007C0
	je	@@1	;@007C2
	mov	byte ptr ds:[11Ch], ah	;@007C4
@@1:	mov	byte ptr ds:[129h], 1	;@007C8
	jmp	L00414	;@007CD
@@2:	mov	byte ptr ds:[129h], 0	;@007D0
	jmp	L00414	;@007D5
L007D8:	pop	cx	;@007D8
	call	L00340	;@007D9
	cmp	al, 32h	;@007DC
	je	@@1	;@007DE
	mov	byte ptr ds:[11Ch], ah	;@007E0
	jmp	L00414	;@007E4
@@1:	mov	byte ptr ds:[12Fh], 1	;@007E7
	jmp	L00414	;@007EC
L007EF:	pop	cx	;@007EF
	call	L00340	;@007F0
	cmp	al, 23h	;@007F3
	je	L0082E	;@007F5
	cmp	byte ptr ds:[15Bh], 1	;@007F7
	jne	@@1	;@007FC
	cmp	al, 2Dh	;@007FE
	jne	@@2	;@00800
	mov	bh, 2	;@00802
	jmp	short @@3	;@00804
@@1:	mov	byte ptr ds:[11Ch], ah	;@00806
	jmp	L00414	;@0080A
@@2:	or	byte ptr ds:[0A34h], 1	;@0080D
	mov	bh, 1	;@00812
	mov	byte ptr ds:[11Ch], ah	;@00814
@@3:	mov	bl, 1	;@00818
	mov	word ptr ds:[154h], bx	;@0081A
L0081E:	mov	al, 0FFh	;@0081E
	mov	ah, 2	;@00820
	dec	byte ptr ds:[153h]	;@00822
	mov	byte ptr ds:[11Bh], 1	;@00826
	jmp	L0046C	;@0082B
L0082E:	call	GET_HEX_DIGIT	;@0082E
	mov	cl, 4	;@00831
	shl	ax, cl	;@00833
	mov	bl, al	;@00835
	call	GET_HEX_DIGIT	;@00837
	add	al, bl	;@0083A
	mov	ah, al	;@0083C
	mov	al, 0CDh	;@0083E
	mov	word ptr ds:[47Ch], ax	;@00840
	jmp	L00414	;@00843
L00846:	pop	cx	;@00846
	mov	cx, 80h	;@00847
	mov	ax, cx	;@0084A
	db	0E8h, 0B6h, 89h	; call L09205	;@0084C
	mov	word ptr ds:[142h], di	;@0084F
	dec	cx	;@00853
	push	ds	;@00854
	pop	es	;@00855
@@1:	call	L00340	;@00856
	push	ds	;@00859
	pop	es	;@0085A
	xor	bx, bx	;@0085B
	mov	bl, al	;@0085D
	cmp	byte ptr cs:[bx+8DFh], 1	;@0085F
	je	@@2	;@00865
	stosb	;@00867
	loop	@@1	;@00868
@@2:	mov	byte ptr ds:[11Ch], ah	;@0086A
	xor	ax, ax	;@0086E
	stosb	;@00870
	mov	word ptr ds:[0Eh], di	;@00871
	jmp	L00414	;@00875
L00878:	pop	cx	;@00878
	call	L00340	;@00879
	cmp	al, 2Dh	;@0087C
	je	@@1	;@0087E
	cmp	al, 3Dh	;@00880
	je	@@2	;@00882
	mov	byte ptr ds:[11Ch], ah	;@00884
	mov	byte ptr ds:[128h], 1	;@00888
	jmp	L00414	;@0088D
@@1:	mov	byte ptr ds:[128h], 0	;@00890
	jmp	L00414	;@00895
@@2:	call	GET_NUMBER	;@00898
	jb	@@3	;@0089B
	mov	word ptr ds:[144h], bx	;@0089D
	mov	byte ptr ds:[128h], 1	;@008A1
	jmp	L00414	;@008A6
@@3:	xor	ax, ax	;@008A9
	push	ax	;@008AB
	mov	ax, 2Bh	;@008AC
	push	ax	;@008AF
	db	0E8h, 0F3h, 0B2h	; call ERROR	;@008B0
	mov	byte ptr ds:[128h], 0	;@008B3
	jmp	L00414	;@008B8
L008BB:	pop	cx	;@008BB
	call	L00340	;@008BC
	cmp	al, 3Dh	;@008BF
	jne	@@1	;@008C1
	call	GET_NUMBER	;@008C3
	jb	@@1	;@008C6
	mov	word ptr ds:[146h], bx	;@008C8
	jmp	L00414	;@008CC
@@1:	xor	ax, ax	;@008CF
	push	ax	;@008D1
	mov	ax, 2Dh	;@008D2
	push	ax	;@008D5
	db	0E8h, 0CDh, 0B2h	; call ERROR	;@008D6
	jmp	L00414	;@008D9
L008DC:	jmp	@@18+3	;@008DC
	add	byte ptr [bx+si], al	;@008DF
	add	byte ptr [bx+si], al	;@008E1
	add	byte ptr [bx+si], al	;@008E3
	add	byte ptr [bx+si], al	;@008E5
	add	byte ptr [bx+di], al	;@008E7
	add	word ptr [bx+si], ax	;@008E9
	add	byte ptr [bx+di], al	;@008EB
	add	byte ptr [bx+si], al	;@008ED
	add	byte ptr [bx+si], al	;@008EF
	add	byte ptr [bx+si], al	;@008F1
	add	byte ptr [bx+si], al	;@008F3
	add	byte ptr [bx+si], al	;@008F5
	add	byte ptr [bx+si], al	;@008F7
	add	word ptr [bx+si], ax	;@008F9
	add	byte ptr [bx+si], al	;@008FB
	add	byte ptr [bx+si], al	;@008FD
	add	word ptr [bp+si], ax	;@008FF
	add	byte ptr [bp+si], al	;@00901
	add	al, byte ptr [bp+si]	;@00903
	add	al, byte ptr [bp+si]	;@00905
	add	al, byte ptr [bp+si]	;@00907
	add	byte ptr [bx+di], al	;@00909
	add	ax, word ptr [bx+di]	;@0090B
	add	al, byte ptr [bx+di]	;@0090D
	add	al, byte ptr [bp+si]	;@0090F
	add	al, byte ptr [bp+si]	;@00911
	add	al, byte ptr [bp+si]	;@00913
	add	al, byte ptr [bp+si]	;@00915
	add	al, byte ptr [bp+si]	;@00917
	add	al, byte ptr [bp+di]	;@00919
	add	byte ptr [bx+si], al	;@0091B
	add	byte ptr [bx+si], al	;@0091D
	add	al, byte ptr [bp+si]	;@0091F
	add	al, byte ptr [bp+si]	;@00921
	add	al, byte ptr [bp+si]	;@00923
	add	al, byte ptr [bp+si]	;@00925
	add	al, byte ptr [bp+si]	;@00927
	add	al, byte ptr [bp+si]	;@00929
	add	al, byte ptr [bp+si]	;@0092B
	add	al, byte ptr [bp+si]	;@0092D
	add	al, byte ptr [bp+si]	;@0092F
	add	al, byte ptr [bp+si]	;@00931
	add	al, byte ptr [bp+si]	;@00933
	add	al, byte ptr [bp+si]	;@00935
	add	al, byte ptr [bp+si]	;@00937
	add	al, byte ptr [bx+si]	;@00939
	add	al, byte ptr [bx+si]	;@0093B
	add	al, byte ptr [bp+si]	;@0093D
	add	al, byte ptr [bp+si]	;@0093F
	add	al, byte ptr [bp+si]	;@00941
	add	al, byte ptr [bp+si]	;@00943
	add	al, byte ptr [bp+si]	;@00945
	add	al, byte ptr [bp+si]	;@00947
	add	al, byte ptr [bp+si]	;@00949
	add	al, byte ptr [bp+si]	;@0094B
	add	al, byte ptr [bp+si]	;@0094D
	add	al, byte ptr [bp+si]	;@0094F
	add	al, byte ptr [bp+si]	;@00951
	add	al, byte ptr [bp+si]	;@00953
	add	al, byte ptr [bp+si]	;@00955
	add	al, byte ptr [bp+si]	;@00957
	add	al, byte ptr [bp+si]	;@00959
	add	byte ptr [bp+si], al	;@0095B
	add	al, byte ptr [bx+si]	;@0095D
	je	@@3+2	;@0095F
	imul	bp, word ptr [bp+6Bh], 632Eh	;@00961
	db	66h, 67h, 0, 55h, 8Bh	; add byte ptr [ebp-75h], dl	;@00966
	in	al, dx	;@0096B
	sub	sp, 8Ah	;@0096C
	mov	word ptr [bp-2], bx	;@00970
	mov	word ptr [bp-4], si	;@00973
	mov	byte ptr [bp-8], 0	;@00976
	mov	word ptr [bp-6], di	;@0097A
	mov	byte ptr ds:[153h], 0	;@0097D
	cmp	byte ptr ds:[15Ch], 0FFh	;@00982
	je	@@1	;@00987
	jmp	@@5	;@00989
@@1:	push	cs	;@0098C
	mov	ax, 95Fh	;@0098D
	push	ax	;@00990
	db	0E8h, 92h, 8Ah	; call SEARCH_FILE	;@00991
	jb	@@2	;@00994
	push	ss	;@00996
	lea	ax, [bp-8Ah]	;@00997
	push	ax	;@0099B
	push	cs	;@0099C
	mov	ax, 95Fh	;@0099D
	push	ax	;@009A0
	db	9Ah, 0Ah, 0, 0AFh, 0	; lcall 0xaf, 0xa	;@009A1
	jmp	short @@4	;@009A6
@@2:	mov	ah, 30h	;@009A8
	int	21h	;@009AA
	cmp	al, 3	;@009AC
	jb	@@5	;@009AE
	db	0E8h, 0DEh, 89h	; call L09391	;@009B0
	jb	@@5	;@009B3
	push	ss	;@009B5
	lea	cx, [bp-8Ah]	;@009B6
	push	cx	;@009BA
	push	ss	;@009BB
	push	cx	;@009BC
	push	dx	;@009BD
	push	ax	;@009BE
	db	9Ah, 0Ah, 0, 0AFh, 0	; lcall 0xaf, 0xa	;@009BF
	db	9Ah, 9, 0, 7Fh, 0	; lcall 0x7f, 9	;@009C4
	push	ss	;@009C9
	pop	es	;@009CA
@@3:	lea	di, [bp-8Ah]	;@009CB
	add	di, ax	;@009CF
	mov	cx, ax	;@009D1
	mov	al, 5Ch	;@009D3
	std	;@009D5
	repne scasb	;@009D6
	cld	;@009D8
	jne	@@5	;@009D9
	add	di, 2	;@009DB
	push	ds	;@009DE
	push	cs	;@009DF
	pop	ds	;@009E0
	mov	si, 95Fh	;@009E1
	mov	cx, 0Ah	;@009E4
	rep movsb	;@009E7
	xor	ax, ax	;@009E9
	stosb	;@009EB
	pop	ds	;@009EC
	push	ss	;@009ED
	lea	ax, [bp-8Ah]	;@009EE
	push	ax	;@009F2
	db	0E8h, 30h, 8Ah	; call SEARCH_FILE	;@009F3
	jb	@@5	;@009F6
@@4:	mov	byte ptr ds:[15Ch], 1	;@009F8
	push	ds	;@009FD
	push	ss	;@009FE
	pop	ds	;@009FF
	lea	dx, [bp-8Ah]	;@00A00
	mov	ax, 3D00h	;@00A04
	call	OPEN_FILE	;@00A07
	pop	ds	;@00A0A
	mov	word ptr ds:[20h], ax	;@00A0B
	mov	byte ptr ds:[118h], 0	;@00A0E
	mov	byte ptr ds:[159h], 1	;@00A13
@@5:	mov	byte ptr ds:[11Bh], 0	;@00A18
@@6:	call	PARSE_OPTION	;@00A1D
	jb	@@6	;@00A20
	lahf	;@00A22
	je	@@7	;@00A23
	cmp	word ptr [bp-2], 0	;@00A25
	jne	@@7	;@00A29
	jmp	@@17	;@00A2B
@@7:	push	ax	;@00A2E
	mov	ax, 64h	;@00A2F
	db	0E8h, 0D0h, 87h	; call L09205	;@00A32
	pop	ax	;@00A35
	push	ds	;@00A36
	pop	es	;@00A37
	mov	bx, di	;@00A38
	cmp	al, 40h	;@00A3A
	je	@@8	;@00A3C
	mov	bx, word ptr [bp-6]	;@00A3E
	mov	word ptr [bx], di	;@00A41
	mov	word ptr [bp-6], di	;@00A43
	push	ax	;@00A46
	xor	ax, ax	;@00A47
	stosw	;@00A49
	pop	ax	;@00A4A
	mov	bx, di	;@00A4B
@@8:	sahf	;@00A4D
	je	@@12	;@00A4E
	mov	si, word ptr [bp-2]	;@00A50
@@9:	cmp	byte ptr [si+2], 0FFh	;@00A53
	jne	@@10	;@00A57
	mov	si, word ptr [si]	;@00A59
	or	si, si	;@00A5B
	jne	@@9	;@00A5D
@@10:	inc	si	;@00A5F
	inc	si	;@00A60
@@11:	lodsb	;@00A61
	stosb	;@00A62
	cmp	al, 2Eh	;@00A63
	jne	@@11	;@00A65
	cmp	byte ptr [si], 2Eh	;@00A67
	je	@@11	;@00A6A
	cmp	byte ptr [si], 5Ch	;@00A6C
	je	@@11	;@00A6F
	mov	word ptr ds:[0Eh], di	;@00A71
	mov	word ptr [bp-2], 0	;@00A75
	jmp	short @@15	;@00A7A
@@12:	mov	word ptr [bp-2], 0	;@00A7C
@@13:	stosb	;@00A81
	push	es	;@00A82
	call	PARSE_OPTION	;@00A83
	pop	es	;@00A86
	je	@@13	;@00A87
	xor	al, al	;@00A89
	stosb	;@00A8B
	cmp	byte ptr [bx], 40h	;@00A8C
	jne	@@14	;@00A8F
	cmp	word ptr ds:[20h], -1	;@00A91
	jne	@@14	;@00A96
	mov	word ptr ds:[0Eh], bx	;@00A98
	lea	dx, [bx+1]	;@00A9C
	mov	ax, 3D00h	;@00A9F
	call	OPEN_FILE	;@00AA2
	mov	word ptr ds:[20h], ax	;@00AA5
	mov	byte ptr ds:[118h], 0	;@00AA8
	mov	al, 1	;@00AAD
	mov	byte ptr ds:[159h], al	;@00AAF
	jmp	@@5	;@00AB2
@@14:	cmp	byte ptr ds:[11Bh], 1	;@00AB5
	je	@@16	;@00ABA
@@15:	dec	di	;@00ABC
	mov	cx, 4	;@00ABD
	mov	si, word ptr [bp-4]	;@00AC0
	push	ds	;@00AC3
	push	cs	;@00AC4
	pop	ds	;@00AC5
	rep movsb	;@00AC6
	pop	ds	;@00AC8
	xor	al, al	;@00AC9
	stosb	;@00ACB
	mov	byte ptr [bp-8], 1	;@00ACC
@@16:	inc	byte ptr ds:[153h]	;@00AD0
	mov	word ptr ds:[0Eh], di	;@00AD4
	cmp	ah, 2	;@00AD8
	jae	@@17	;@00ADB
	jmp	@@5	;@00ADD
@@17:	mov	bl, byte ptr [bp-8]	;@00AE0
	mov	sp, bp	;@00AE3
	pop	bp	;@00AE5
	ret	;@00AE6
	db	0BFh, 20h, 1, 0B9h, 28h, 0, 33h, 0C0h, 1Eh, 7, 0F3h, 0AAh, 0C6h	;@00AE7
	db	6, 28h, 1, 1, 0C7h, 6, 44h, 1, 0, 20h, 0C7h, 6, 46h, 1, 0, 2, 0C7h
	db	6, 34h, 1, 10h, 0, 0C7h, 6, 36h, 1, 1Fh, 0, 0E8h, 7, 87h, 0A2h
	db	5Ah, 1, 33h, 0C0h, 0A3h, 54h, 1, 0A3h, 56h, 1, 0A2h, 18h, 1, 48h
	db	0A2h, 58h, 1, 0A2h, 59h, 1, 0C7h, 6, 50h, 1, 1, 0, 0C6h, 6, 5Bh
	db	1, 1, 0BEh, 6Bh, 10h, 0BFh, 38h, 1, 33h, 0DBh, 0E8h, 2Bh, 0FEh
	db	80h, 3Eh, 53h, 1, 0, 74h, 5Dh, 0C6h, 6, 5Bh, 1, 0, 0BEh, 83h, 10h
	db	80h, 3Eh, 2Bh, 1, 1, 74h, 0Dh, 0BEh, 73h, 10h, 80h, 3Eh, 2Bh, 1
	db	3, 74h, 3, 0BEh, 6Fh, 10h, 0BFh, 3Ah, 1, 8Bh, 1Eh, 38h, 1, 0E8h
	db	0FEh, 0FDh, 88h, 1Eh, 1Fh, 1, 0C6h, 6, 52h, 1, 1, 0BEh, 77h, 10h
	db	0BFh, 3Ch, 1, 8Bh, 1Eh, 3Ah, 1, 0E8h, 0E8h, 0FDh, 0C6h, 6, 5Bh
	db	1, 1, 0BEh, 7Bh, 10h, 0BFh, 3Eh, 1, 33h, 0DBh, 0E8h, 0D8h, 0FDh
	db	0C6h, 6, 5Bh, 1, 0, 0BEh, 7Fh, 10h, 0BFh, 40h, 1, 33h
	db	0DBh, 0E8h	; fucomi st(0)	;@00B9D
@@18:	db	0C8h, 0FDh, 0C3h, 0E8h	; enter 0C3FDh, 0FFE8h	;@00B9F
	or	byte ptr [bp+di+38E8h], 8Ah	;@00BA3
	cmp	dx, word ptr [bp+di+79h]	;@00BA8
	outsb	;@00BAB
	db	74h, 61h	; je @@21	;@00BAC
	db	78h, 3Ah	; js @@19+2	;@00BAE
	and	byte ptr [si+4Ch], dl	;@00BB0
	dec	cx	;@00BB3
	dec	si	;@00BB4
	dec	bx	;@00BB5
	and	byte ptr [bx+62h], ch	;@00BB6
	push	66h	;@00BB9
	imul	bp, word ptr [si+65h], 2C73h	;@00BBB
	and	byte ptr [di+78h], ah	;@00BC0
	db	65h, 66h, 69h, 6Ch, 65h, 2Ch, 20h, 6Dh, 61h	; imul ebp, dword ptr [si+65h], 616D202Ch	;@00BC3
	db	70h, 66h	; jo @@24+2	;@00BCC
	imul	bp, word ptr [si+65h], 202Ch	;@00BCE
	insb	;@00BD3
	imul	sp, word ptr [bp+si+66h], 6C69h	;@00BD4
	db	65h, 73h, 2Ch	; jae @@20+1	;@00BD9
	db	20h, 64h, 65h	; and byte ptr [si+65h], ah	;@00BDC
	db	66h, 66h, 69h, 6Ch, 65h, 0E8h, 9Fh, 89h, 0E8h	; imul ebp, dword ptr [si+65h], 0E8899FE8h	;@00BDF
@@19:	db	0F6h, 89h, 26h, 40h, 78h	; test byte ptr [bx+di+4026h], 78h	;@00BE8
	db	78h, 78h	; js @@27+2	;@00BED
	db	78h, 20h	; js @@22	;@00BEF
	imul	bp, word ptr [bp+64h], 6369h	;@00BF1
	popa	;@00BF6
	db	74h, 65h	; je @@26+7	;@00BF7
	db	73h, 20h	; jae @@23+1	;@00BF9
	db	75h, 73h	; jne @@30+1	;@00BFB
	db	65h, 20h, 72h, 65h	; and byte ptr [bp+si+65h], dh	;@00BFD
	db	73h, 70h	; jae @@31	;@00C01
	outsw	;@00C03
	outsb	;@00C04
	db	73h, 65h	; jae @@28+1	;@00C05
@@20:	and	byte ptr [bp+69h], ah	;@00C07
	insb	;@00C0A
	db	65h, 20h, 78h, 78h	; and byte ptr [bx+si+78h], bh	;@00C0B
@@21:	db	78h, 78h	; js @@35+1	;@00C0F
@@22:	db	0E8h, 72h, 89h	; call PUT_NEWLINE	;@00C11
	db	0E8h, 0C9h, 89h	; call PUT_INLINE	;@00C14
	and	cx, word ptr [bx+70h]	;@00C17
@@23:	je	@@34	;@00C1A
	outsw	;@00C1C
	outsb	;@00C1D
	jae	@@26+3	;@00C1E
	and	byte ptr [bx], ch	;@00C20
	insw	;@00C22
	and	byte ptr [di], bh	;@00C23
	and	byte ptr [di+61h], ch	;@00C25
	jo	@@25	;@00C28
	db	66h, 69h, 6Ch, 65h, 20h, 77h, 69h, 74h	; imul ebp, dword ptr [si+65h], 74697720h	;@00C2A
@@24:	push	7020h	;@00C32
	db	75h, 62h	; jne @@36+1	;@00C35
	insb	;@00C37
	imul	sp, word ptr [bp+di+73h], 48E8h	;@00C38
	db	89h, 0E8h	; mov ax, bp	;@00C3D
	lahf	;@00C3F
	mov	word ptr [bx+si], sp	;@00C40
	and	byte ptr [bx+si], ah	;@00C42
	and	byte ptr [bx+si], ah	;@00C44
	and	byte ptr [bx+si], ah	;@00C46
	and	byte ptr [bx+si], ah	;@00C48
@@25:	and	byte ptr [bx], ch	;@00C4A
	js	@@29+1	;@00C4C
	cmp	ax, 6E20h	;@00C4E
	outsw	;@00C51
	and	byte ptr [di+61h], ch	;@00C52
	jo	@@32	;@00C55
@@26:	db	66h, 69h, 6Ch, 65h, 20h, 61h, 74h, 20h	; imul ebp, dword ptr [si+65h], 20746120h	;@00C57
	popa	;@00C5F
	insb	;@00C60
	insb	;@00C61
	db	0E8h, 21h, 89h	; call PUT_NEWLINE	;@00C62
@@27:	db	0E8h, 78h, 89h	; call PUT_INLINE	;@00C65
	and	ax, 2020h	;@00C68
@@28:	and	byte ptr [bx+si], ah	;@00C6B
@@29:	and	byte ptr [bx+si], ah	;@00C6D
@@30:	and	byte ptr [bx+si], ah	;@00C6F
	and	byte ptr [bx], ch	;@00C71
@@31:	imul	sp, word ptr [bx+si], 203Dh	;@00C73
@@32:	imul	bp, word ptr [bp+69h], 6974h	;@00C77
	popa	;@00C7C
@@33:	insb	;@00C7D
	imul	di, word ptr [bp+si+65h], 6120h	;@00C7E
	insb	;@00C83
	insb	;@00C84
@@34:	and	byte ptr [bp+di+65h], dh	;@00C85
@@35:	db	67h, 6Dh	; insw	;@00C88
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@00C8A
	db	74h, 73h	; je @@40+1	;@00C8C
	db	0E8h, 0F5h, 88h	; call PUT_NEWLINE	;@00C8E
	db	0E8h, 4Ch, 89h	; call PUT_INLINE	;@00C91
	sub	word ptr [bx+si], sp	;@00C94
	and	byte ptr [bx+si], ah	;@00C96
@@36:	and	byte ptr [bx+si], ah	;@00C98
	and	byte ptr [bx+si], ah	;@00C9A
	and	byte ptr [bx+si], ah	;@00C9C
	das	;@00C9E
	insb	;@00C9F
	and	byte ptr [di], bh	;@00CA0
	and	byte ptr [bx+di+6Eh], ch	;@00CA2
@@37:	arpl	word ptr [si+75h], bp	;@00CA5
	db	64h, 65h, 20h, 73h, 6Fh	; and byte ptr [bp+di+6Fh], dh	;@00CA8
	db	75h, 72h	; jne @@42+2	;@00CAD
	arpl	word ptr [di+20h], sp	;@00CAF
	insb	;@00CB2
	imul	bp, word ptr [bp+65h], 6E20h	;@00CB3
	db	75h, 6Dh	; jne @@44+1	;@00CB8
	bound	sp, dword ptr [di+72h]	;@00CBA
	jae	@@37+2	;@00CBD
	lds	cx, dword ptr [bx+si+1CE8h]	;@00CBF
	mov	word ptr [bp+si], bp	;@00CC3
	and	byte ptr [bx+si], ah	;@00CC5
	and	byte ptr [bx+si], ah	;@00CC7
	and	byte ptr [bx+si], ah	;@00CC9
	and	byte ptr [bx+si], ah	;@00CCB
	and	byte ptr [bx], ch	;@00CCD
	dec	sp	;@00CCF
	and	byte ptr [di], bh	;@00CD0
	and	byte ptr [bp+di+70h], dh	;@00CD2
@@38:	db	65h, 63h, 69h, 66h	; arpl word ptr [bx+di+66h], bp	;@00CD5
	db	79h, 20h	; jns @@39	;@00CD9
	insb	;@00CDB
	imul	sp, word ptr [bp+si+72h], 7261h	;@00CDC
	jns	@@41+1	;@00CE1
	db	73h, 65h	; jae @@46	;@00CE3
	popa	;@00CE5
	db	72h, 63h	; jb @@46+1	;@00CE6
	push	7020h	;@00CE8
	popa	;@00CEB
	db	74h, 68h	; je @@47	;@00CEC
	jae	@@38+3	;@00CEE
	xchg	ax, sp	;@00CF0
	db	88h, 0E8h	; mov al, ch	;@00CF1
	jmp	@@33	;@00CF3
	db	'&     '	;@00CF5
@@39:	and	byte ptr [bx+si], ah	;@00CFB
	and	byte ptr [bx+si], ah	;@00CFD
	das	;@00CFF
@@40:	db	73h, 20h	; jae @@43	;@00D00
@@41:	cmp	ax, 6420h	;@00D02
	db	65h, 74h, 61h	; je @@49+3	;@00D05
	db	69h, 6Ch, 65h, 64h, 20h	; imul bp, word ptr [si+65h], 2064h	;@00D08
	insw	;@00D0D
	popa	;@00D0E
	db	70h, 20h	; jo @@45+1	;@00D0F
	outsw	;@00D11
	db	66h, 20h, 73h, 65h	; and byte ptr [bp+di+65h], dh	;@00D12
	db	67h, 6Dh	; insw	;@00D16
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@00D18
	db	74h, 73h	; je @@50	;@00D1A
	db	0E8h, 67h, 88h	; call PUT_NEWLINE	;@00D1C
@@42:	db	0E8h, 0BEh, 88h	; call PUT_INLINE	;@00D1F
@@43:	and	ah, byte ptr [bx+si]	;@00D22
	and	byte ptr [bx+si], ah	;@00D24
@@44:	and	byte ptr [bx+si], ah	;@00D26
	and	byte ptr [bx+si], ah	;@00D28
	and	byte ptr [bx+si], ah	;@00D2A
	das	;@00D2C
	outsb	;@00D2D
	and	byte ptr [di], bh	;@00D2E
@@45:	and	byte ptr [bp+6Fh], ch	;@00D30
	and	byte ptr [si+65h], ah	;@00D33
	db	66h, 61h	; popal	;@00D36
	db	75h, 6Ch	; jne @@53+2	;@00D38
	db	74h, 20h	; je @@48	;@00D3A
	insb	;@00D3C
	imul	sp, word ptr [bp+si+72h], 7261h	;@00D3D
	imul	sp, word ptr [di+73h], 3EE8h	;@00D42
	db	88h, 0E8h	; mov al, ch	;@00D47
	xchg	ax, bp	;@00D49
@@46:	mov	byte ptr [si], dh	;@00D4A
	and	byte ptr [bx+si], ah	;@00D4C
	and	byte ptr [bx+si], ah	;@00D4E
	and	byte ptr [bx+si], ah	;@00D50
	and	byte ptr [bx+si], ah	;@00D52
	and	byte ptr [bx], ch	;@00D54
@@47:	db	64h, 20h, 3Dh	; and byte ptr [di], bh	;@00D56
	db	20h, 77h, 61h	; and byte ptr [bx+61h], dh	;@00D59
@@48:	db	72h, 6Eh	; jb @@55	;@00D5C
	and	byte ptr [bx+di+66h], ch	;@00D5E
	and	byte ptr [si+75h], ah	;@00D61
	db	70h, 6Ch	; jo @@56+1	;@00D64
@@49:	imul	sp, word ptr [bp+di+61h], 6574h	;@00D66
	and	byte ptr [bp+di+79h], dh	;@00D6B
	insw	;@00D6E
	bound	bp, dword ptr [bx+6Ch]	;@00D6F
	db	73h, 20h	; jae @@51+1	;@00D72
	imul	bp, word ptr [bp+20h], 696Ch	;@00D74
	bound	si, dword ptr [bp+si+61h]	;@00D79
	db	72h, 69h	; jb @@57+1	;@00D7C
	db	65h, 73h, 0E8h	; jae @@49+3	;@00D7E
	db	3, 88h, 0E8h, 5Ah	; add cx, word ptr [bx+si+5AE8h]	;@00D81
	mov	byte ptr [bx], ch	;@00D85
	and	byte ptr [bx+si], ah	;@00D87
	and	byte ptr [bx+si], ah	;@00D89
	and	byte ptr [bx+si], ah	;@00D8B
	and	byte ptr [bx+si], ah	;@00D8D
@@50:	and	byte ptr [bx], ch	;@00D8F
	arpl	word ptr [bx+si], sp	;@00D91
@@51:	cmp	ax, 6C20h	;@00D93
	outsw	;@00D96
	db	77h, 65h	; ja @@58+1	;@00D97
	db	72h, 20h	; jb @@54+2	;@00D99
	arpl	word ptr [bx+di+73h], sp	;@00D9B
@@52:	db	65h, 20h, 73h, 69h	; and byte ptr [bp+di+69h], dh	;@00D9E
	db	67h, 6Eh	; outsb	;@00DA2
@@53:	imul	sp, word ptr [bp+69h], 6163h	;@00DA4
	outsb	;@00DA9
	je	@@55	;@00DAA
	imul	bp, word ptr [bp+20h], 7973h	;@00DAC
	insw	;@00DB1
	bound	bp, dword ptr [bx+6Ch]	;@00DB2
	jae	@@52+1	;@00DB5
	int	87h	;@00DB7
@@54:	db	0E8h, 24h, 88h	; call PUT_INLINE	;@00DB9
	and	byte ptr es:[bx+si], ah	;@00DBC
	and	byte ptr [bx+si], ah	;@00DBF
	and	byte ptr [bx+si], ah	;@00DC1
	and	byte ptr [bx+si], ah	;@00DC3
	and	byte ptr [bx], ch	;@00DC5
	xor	sp, word ptr [bx+si]	;@00DC7
	cmp	ax, 6520h	;@00DC9
@@55:	outsb	;@00DCC
	popa	;@00DCD
	bound	bp, dword ptr [si+65h]	;@00DCE
@@56:	and	byte ptr [bp+di], dh	;@00DD1
	xor	ch, byte ptr [di]	;@00DD3
	bound	bp, dword ptr [bx+di+74h]	;@00DD5
	and	byte ptr [bx+si+72h], dh	;@00DD8
	outsw	;@00DDB
	arpl	word ptr [di+73h], sp	;@00DDC
	db	73h, 69h	; jae @@61	;@00DDF
	outsb	;@00DE1
	db	67h, 0E8h, 0A0h, 87h	; call PUT_NEWLINE	;@00DE2
@@57:	db	0E8h, 0F7h, 87h	; call PUT_INLINE	;@00DE6
	xor	ax, 2020h	;@00DE9
	and	byte ptr [bx+si], ah	;@00DEC
	and	byte ptr [bx+si], ah	;@00DEE
	and	byte ptr [bx+si], ah	;@00DF0
	and	byte ptr [bx], ch	;@00DF2
	db	76h, 20h	; jbe @@59	;@00DF4
	cmp	ax, 6920h	;@00DF6
	outsb	;@00DF9
	arpl	word ptr [si+75h], bp	;@00DFA
@@58:	db	64h, 65h, 20h, 66h, 75h	; and byte ptr [bp+75h], ah	;@00DFD
	db	6Ch	; insb	;@00E02
	insb	;@00E03
	and	byte ptr [bp+di+79h], dh	;@00E04
	insw	;@00E07
	bound	bp, dword ptr [bx+6Ch]	;@00E08
	imul	sp, word ptr [bp+di+20h], 6564h	;@00E0B
	bound	si, dword ptr [di+67h]	;@00E10
	and	byte ptr [bx+di+6Eh], ch	;@00E13
@@59:	db	66h, 6Fh	; outsd	;@00E16
	db	72h, 6Dh	; jb @@63+1	;@00E18
	popa	;@00E1A
	db	74h, 69h	; je @@63	;@00E1B
	outsw	;@00E1D
	outsb	;@00E1E
	db	0E8h, 64h, 87h	; call PUT_NEWLINE	;@00E1F
	db	0E8h, 0BBh, 87h	; call PUT_INLINE	;@00E22
	sub	byte ptr [bx+si], ah	;@00E25
	and	byte ptr [bx+si], ah	;@00E27
	and	byte ptr [bx+si], ah	;@00E29
@@60:	and	byte ptr [bx+si], ah	;@00E2B
	and	byte ptr [bx+si], ah	;@00E2D
	das	;@00E2F
	db	65h, 20h, 3Dh	; and byte ptr [di], bh	;@00E30
	db	20h, 69h, 67h	; and byte ptr [bx+di+67h], ch	;@00E33
	outsb	;@00E36
	outsw	;@00E37
	db	72h, 65h	; jb @@65	;@00E38
	and	byte ptr [di+78h], al	;@00E3A
	db	74h, 65h	; je @@66	;@00E3D
	outsb	;@00E3F
	db	64h, 65h, 64h, 20h, 44h, 69h	; and byte ptr [si+69h], al	;@00E40
	db	63h, 74h, 69h	; arpl word ptr [si+69h], si	;@00E46
	outsw	;@00E49
@@61:	outsb	;@00E4A
	popa	;@00E4B
	db	72h, 79h	; jb @@68+2	;@00E4C
	db	0E8h, 35h, 87h	; call PUT_NEWLINE	;@00E4E
	db	0E8h, 8Ch, 87h	; call PUT_INLINE	;@00E51
	sub	sp, word ptr [bx+si]	;@00E54
	and	byte ptr [bx+si], ah	;@00E56
	and	byte ptr [bx+si], ah	;@00E58
	and	byte ptr [bx+si], ah	;@00E5A
	and	byte ptr [bx+si], ah	;@00E5C
	das	;@00E5E
	db	74h, 20h	; je @@62+1	;@00E5F
	cmp	ax, 6320h	;@00E61
	db	72h, 65h	; jb @@69+3	;@00E64
	popa	;@00E66
	db	74h, 65h	; je @@70	;@00E67
	and	byte ptr [bp+di+4Fh], al	;@00E69
	dec	bp	;@00E6C
	and	byte ptr [bp+69h], ah	;@00E6D
	insb	;@00E70
	db	65h, 20h, 28h	; and byte ptr [bx+si], ch	;@00E71
	db	73h, 61h	; jae @@71+2	;@00E74
	insw	;@00E76
	db	65h, 20h, 61h, 73h	; and byte ptr [bx+di+73h], ah	;@00E77
	db	20h, 2Fh	; and byte ptr [bx], ch	;@00E7B
	push	sp	;@00E7D
	arpl	word ptr [bx+di], bp	;@00E7E
@@62:	db	0E8h, 3, 87h	; call PUT_NEWLINE	;@00E80
	db	0E8h, 5Ah, 87h	; call PUT_INLINE	;@00E83
@@63:	sbb	al, 20h	;@00E86
	and	byte ptr [bx+si], ah	;@00E88
	and	byte ptr [bx+si], ah	;@00E8A
	and	byte ptr [bx+si], ah	;@00E8C
	and	byte ptr [bx+si], ah	;@00E8E
	das	;@00E90
	outsw	;@00E91
	and	byte ptr [di], bh	;@00E92
	and	byte ptr [bx+76h], ch	;@00E94
@@64:	db	65h, 72h, 6Ch	; jb @@73	;@00E97
	db	61h	; popa	;@00E9A
	jns	@@67	;@00E9B
	db	73h, 77h	; jae @@75	;@00E9D
@@65:	imul	si, word ptr [si+63h], 0E868h	;@00E9F
@@66:	loopne	@@60+1	;@00EA4
	db	0E8h, 37h, 87h	; call PUT_INLINE	;@00EA6
	sub	byte ptr [bx+si], ah	;@00EA9
	and	byte ptr [bx+si], ah	;@00EAB
	and	byte ptr [bx+si], ah	;@00EAD
	and	byte ptr [bx+si], ah	;@00EAF
	and	byte ptr [bx+si], ah	;@00EB1
	das	;@00EB3
	push	ax	;@00EB4
	pop	bx	;@00EB5
	cmp	ax, 4E4Eh	;@00EB6
	dec	si	;@00EB9
	dec	si	;@00EBA
	dec	si	;@00EBB
	pop	bp	;@00EBC
@@67:	and	byte ptr [di], bh	;@00EBD
	and	byte ptr [bx+si+61h], dh	;@00EBF
	arpl	word ptr [bp+di+20h], bp	;@00EC2
@@68:	arpl	word ptr [bx+64h], bp	;@00EC5
@@69:	db	65h, 20h, 73h, 65h	; and byte ptr [bp+di+65h], dh	;@00EC8
	db	67h, 6Dh	; insw	;@00ECC
@@70:	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@00ECE
	db	74h, 73h	; je @@80+1	;@00ED0
	db	0E8h, 0B1h, 86h	; call PUT_NEWLINE	;@00ED2
@@71:	db	0E8h, 8, 87h	; call PUT_INLINE	;@00ED5
	and	byte ptr ss:[bx+si], ah	;@00ED8
	and	byte ptr [bx+si], ah	;@00EDB
	and	byte ptr [bx+si], ah	;@00EDD
	and	byte ptr [bx+si], ah	;@00EDF
	and	byte ptr [bx], ch	;@00EE1
	inc	cx	;@00EE3
	cmp	ax, 4E4Eh	;@00EE4
	dec	si	;@00EE7
	dec	si	;@00EE8
	and	byte ptr [di], bh	;@00EE9
	and	byte ptr [bp+di+65h], dh	;@00EEB
	db	74h, 20h	; je @@74	;@00EEE
	dec	si	;@00EF0
	db	65h, 77h, 45h	; ja @@79+1	;@00EF1
	db	78h, 65h	; js @@81+3	;@00EF4
@@72:	and	byte ptr [bp+di+65h], dh	;@00EF6
	db	67h, 6Dh	; insw	;@00EF9
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@00EFB
	je	@@76+1	;@00EFD
	popa	;@00EFF
	insb	;@00F00
	imul	sp, word ptr [bx+6Eh], 656Dh	;@00F01
@@73:	outsb	;@00F06
	je	@@77	;@00F07
	db	66h, 61h	; popal	;@00F09
	arpl	word ptr [si+6Fh], si	;@00F0B
	jb	@@72+2	;@00F0E
@@74:	je	@@64+1	;@00F10
	db	0E8h, 0CBh, 86h	; call PUT_INLINE	;@00F12
	daa	;@00F15
@@75:	and	byte ptr [bx+si], ah	;@00F16
	and	byte ptr [bx+si], ah	;@00F18
	and	byte ptr [bx+si], ah	;@00F1A
	and	byte ptr [bx+si], ah	;@00F1C
@@76:	and	byte ptr [bx], ch	;@00F1E
	db	79h, 65h	; jns @@82+2	;@00F20
	and	byte ptr [di], bh	;@00F22
	and	byte ptr [di+78h], ah	;@00F24
	db	70h, 61h	; jo @@83+1	;@00F27
@@77:	outsb	;@00F29
@@78:	db	64h, 65h, 64h, 20h, 6Dh, 65h	; and byte ptr [di+65h], ch	;@00F2A
	db	6Dh	; insw	;@00F30
	outsw	;@00F31
	db	72h, 79h	; jb @@86	;@00F32
	and	byte ptr [bp+di+77h], dh	;@00F34
	popa	;@00F37
@@79:	db	70h, 70h	; jo @@85+1	;@00F38
	imul	bp, word ptr [bp+67h], 46E8h	;@00F3A
	xchg	ch, al	;@00F3F
	popf	;@00F41
	xchg	byte ptr [bx], ah	;@00F42
@@80:	and	byte ptr [bx+si], ah	;@00F44
	and	byte ptr [bx+si], ah	;@00F46
	and	byte ptr [bx+si], ah	;@00F48
	and	byte ptr [bx+si], ah	;@00F4A
	and	byte ptr [bx], ch	;@00F4C
	db	79h, 78h	; jns @@89+1	;@00F4E
	and	byte ptr [di], bh	;@00F50
	and	byte ptr [di+78h], ah	;@00F52
	db	74h, 65h	; je @@88	;@00F55
	outsb	;@00F57
@@81:	db	64h, 65h, 64h, 20h, 6Dh, 65h	; and byte ptr [di+65h], ch	;@00F58
	db	6Dh	; insw	;@00F5E
	outsw	;@00F5F
	db	72h, 79h	; jb @@91+1	;@00F60
	and	byte ptr [bp+di+77h], dh	;@00F62
	popa	;@00F65
	db	70h, 70h	; jo @@90	;@00F66
	imul	bp, word ptr [bp+67h], 18E8h	;@00F68
	xchg	ch, al	;@00F6D
	outsw	;@00F6F
	xchg	byte ptr [bx+di], dh	;@00F70
	and	byte ptr [bx+si], ah	;@00F72
	and	byte ptr [bx+si], ah	;@00F74
	and	byte ptr [bx+si], ah	;@00F76
	and	byte ptr [bx+si], ah	;@00F78
	and	byte ptr [bx], ch	;@00F7A
	inc	bx	;@00F7C
	and	byte ptr [bx+si], ah	;@00F7D
	cmp	ax, 6320h	;@00F7F
	popa	;@00F82
	db	73h, 65h	; jae @@94	;@00F83
@@82:	and	byte ptr [bp+di+65h], dh	;@00F85
	outsb	;@00F88
@@83:	db	73h, 69h	; jae @@95+1	;@00F89
@@84:	db	74h, 69h	; je @@95+3	;@00F8B
	db	76h, 65h	; jbe @@95+1	;@00F8D
	and	byte ptr [di+78h], ah	;@00F8F
	db	70h, 6Fh	; jo @@96	;@00F92
	db	72h, 74h	; jb @@98+1	;@00F94
	db	73h, 20h	; jae @@87+1	;@00F96
	popa	;@00F98
	outsb	;@00F99
	db	64h, 20h, 69h, 6Dh	; and byte ptr [bx+di+6Dh], ch	;@00F9A
	db	70h, 6Fh	; jo @@99+1	;@00F9E
	db	72h, 74h	; jb @@100	;@00FA0
	jae	@@84+1	;@00FA2
	loopne	@@78+1	;@00FA4
	db	0E8h, 37h, 86h	; call PUT_INLINE	;@00FA6
@@85:	sub	byte ptr [bx+si], ah	;@00FA9
	and	byte ptr [bx+si], ah	;@00FAB
@@86:	and	byte ptr [bx+si], ah	;@00FAD
	and	byte ptr [bx+si], ah	;@00FAF
	and	byte ptr [bx+si], ah	;@00FB1
	das	;@00FB3
	push	sp	;@00FB4
	db	78h, 78h	; js @@102+1	;@00FB5
@@87:	and	byte ptr [di], bh	;@00FB7
	and	byte ptr [bp+di+70h], dh	;@00FB9
@@88:	db	65h, 63h, 69h, 66h	; arpl word ptr [bx+di+66h], bp	;@00FBC
	db	79h, 20h	; jns @@92	;@00FC0
	outsw	;@00FC2
	db	75h, 74h	; jne @@103+1	;@00FC3
	db	70h, 75h	; jo @@103+4	;@00FC5
@@89:	db	74h, 20h	; je @@93	;@00FC7
	db	66h, 69h, 6Ch, 65h, 20h, 74h, 79h, 70h	; imul ebp, dword ptr [si+65h], 70797420h	;@00FC9
	db	65h, 0E8h, 0B1h, 85h	; call PUT_NEWLINE	;@00FD1
	db	0E8h, 8, 86h	; call PUT_INLINE	;@00FD5
@@90:	and	cl, byte ptr [bx+di]	;@00FD8
@@91:	and	byte ptr [bx+si], ah	;@00FDA
	and	byte ptr [bx+si], ah	;@00FDC
	and	byte ptr [bx+si], ah	;@00FDE
	and	byte ptr [bx], ch	;@00FE0
@@92:	push	sp	;@00FE2
	db	64h, 78h, 20h	; js @@97+1	;@00FE3
	db	3Dh, 20h, 44h	; cmp ax, 4420h	;@00FE6
@@93:	dec	di	;@00FE9
@@94:	push	bx	;@00FEA
	and	byte ptr [bx+di+6Dh], ch	;@00FEB
	popa	;@00FEE
	db	67h, 65h, 20h, 28h	; and byte ptr [eax], ch	;@00FEF
@@95:	db	64h, 65h, 66h, 61h	; popal	;@00FF3
	db	75h, 6Ch	; jne @@105+1	;@00FF7
	db	74h, 29h	; je @@101	;@00FF9
	db	0E8h, 88h, 85h	; call PUT_NEWLINE	;@00FFB
	db	0E8h, 0DFh, 85h	; call PUT_INLINE	;@00FFE
	sbb	al, 9	;@01001
@@96:	and	byte ptr [bx+si], ah	;@01003
@@97:	and	byte ptr [bx+si], ah	;@01005
	and	byte ptr [bx+si], ah	;@01007
@@98:	and	byte ptr [bx], ch	;@01009
	push	sp	;@0100B
	db	77h, 78h	; ja L01082+4	;@0100C
@@99:	and	byte ptr [di], bh	;@0100E
	and	byte ptr [bx+69h], dl	;@01010
	outsb	;@01013
	db	64h, 6Fh	; outs dx, word ptr fs:[si]	;@01014
@@100:	db	77h, 73h	; ja L0108B	;@01016
	and	byte ptr [bx+di+6Dh], ch	;@01018
	popa	;@0101B
	db	67h, 65h, 0E8h, 65h, 85h	; call PUT_NEWLINE	;@0101C
	db	0E8h, 0BCh, 85h	; call PUT_INLINE	;@01021
@@101:	cmp	word ptr [bx+si], sp	;@01024
	and	byte ptr [bx+si], ah	;@01026
	and	byte ptr [bx+si], ah	;@01028
	and	byte ptr [bx+si], ah	;@0102A
	and	byte ptr [bx+si], ah	;@0102C
@@102:	and	byte ptr [bx+si], ah	;@0102E
	and	byte ptr [bx+si], ah	;@01030
	and	byte ptr [bx+si], ah	;@01032
	and	byte ptr [bx+si], ch	;@01034
	db	74h, 68h	; je L0109E+2	;@01036
@@103:	imul	si, word ptr [bp+si+64h], 6C20h	;@01038
	db	65h, 74h, 74h	; je L010B4	;@0103D
	db	65h, 72h, 20h	; jb @@104+1	;@01040
	arpl	word ptr [bx+di+6Eh], sp	;@01043
	and	byte ptr [bp+si+65h], ah	;@01046
	and	byte ptr [bp+di+3Dh], ah	;@01049
	inc	bx	;@0104C
	dec	di	;@0104D
	dec	bp	;@0104E
	sub	al, 20h	;@0104F
	db	65h, 3Dh, 45h, 58h	; cmp ax, 5845h	;@01051
	db	45h	; inc bp	;@01055
	sub	al, 20h	;@01056
	db	64h, 3Dh, 44h, 4Ch	; cmp ax, 4C44h	;@01058
	db	4Ch	; dec sp	;@0105C
	db	29h, 0E8h	; sub ax, bp	;@0105D
	and	ax, 8985h	;@0105F
@@104:	db	3Eh, 41h	; inc cx	;@01062
@@105:	db	0B4h, 0E8h	; mov ah, 0E8h	;@01064
	iret	;@01066
	db	86h	;@01067
	db	0E8h, 0A5h, 75h	; call L08610	;@01068
EXTENSIONS:	outs	dx, word ptr cs:[si]	;@0106B
	bound	bp, dword ptr [bp+si+2Eh]	;@0106D
	db	65h, 78h, 65h	; js L010D8	;@01070
	db	2Eh, 64h, 6Ch	; insb	;@01073
	insb	;@01076
	db	2Eh, 6Dh	; insw	;@01077
	db	61h	; popa	;@01079
	db	70h, 2Eh	; jo L010A9+1	;@0107A
	insb	;@0107C
	imul	sp, word ptr [bp+si+2Eh], 6564h	;@0107D
L01082:	db	66h, 2Eh, 63h, 6Fh, 6Dh	; arpl word ptr cs:[bx+6Dh], bp	;@01082
	db	0, 0	; add byte ptr [bx+si], al	;@01087
	add	byte ptr [bx+si], al	;@01089
L0108B:	add	byte ptr [bx+si], al	;@0108B
	add	byte ptr [bx+si], al	;@0108D
	add	byte ptr [bx+si-2DC2h], al	;@0108F
	add	ax, word ptr [bp+si]	;@01093
	je	L010C6	;@01095
	sub	bx, bx	;@01097
	add	bl, byte ptr [si]	;@01099
	jge	L010A5	;@0109B
	inc	si	;@0109D
L0109E:	sub	bl, 80h	;@0109E
	mov	bh, bl	;@010A1
	mov	bl, byte ptr [si]	;@010A3
L010A5:	inc	si	;@010A5
	cmp	bx, 18h	;@010A6
L010A9:	jb	@@1	;@010A9
	add	bx, word ptr ds:[38Fh]	;@010AB
@@1:	mov	di, word ptr ds:[174h]	;@010AF
	push	di	;@010B3
L010B4:	and	di, 3	;@010B4
	shl	di, 1	;@010B7
	shl	di, 1	;@010B9
	shl	di, 1	;@010BB
	mov	es, word ptr [di+718h]	;@010BD
	pop	di	;@010C1
	mov	word ptr es:[di-6], bx	;@010C2
L010C6:	ret	;@010C6
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah	;@010C7
	db	1Ch, 46h, 83h, 0FBh
L010D8:	sbb	byte ptr [bp+si+4], dh	;@010D8
	add	bx, word ptr ds:[38Fh]	;@010DB
	mov	di, word ptr ds:[176h]	;@010DF
	push	di	;@010E3
	and	di, 3	;@010E4
	shl	di, 1	;@010E7
	shl	di, 1	;@010E9
	shl	di, 1	;@010EB
	mov	es, word ptr [di+758h]	;@010ED
	pop	di	;@010F1
	mov	word ptr es:[di+10h], bx	;@010F2
	lodsb	;@010F6
	or	byte ptr es:[di+0Fh], al	;@010F7
	ret	;@010FB
L010FC:	nop	;@010FC
L010FD:	nop	;@010FD
L010FE:	db	0E8h, 9Ch, 75h	; call L0869D	;@010FE
P1_COMENT_E2:	cmp	si, word ptr ds:[3E0h]	;@01101
	jb	@@2	;@01105
	jne	L010FC	;@01107
	ret	;@01109
@@1:	add	si, 4	;@0110A
	jmp	P1_COMENT_E2	;@0110D
@@2:	inc	word ptr [di+1Ah]	;@0110F
	lodsb	;@01112
	cmp	al, 40h	;@01113
	je	@@1	;@01115
	cmp	al, 0C0h	;@01117
	je	@@1	;@01119
	lodsb	;@0111B
	cbw	;@0111C
	add	si, ax	;@0111D
	cmp	byte ptr [si], 80h	;@0111F
	sbb	si, -2	;@01122
	jmp	P1_COMENT_E2	;@01125
	db	1, 1, 1, 1, 2, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1	;@01127
	db	1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2
	db	1, 1, 0, 2, 1, 0, 2, 0, 0, 2, 1, 1, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh
	db	0ACh, 98h, 3, 0F0h, 0ADh, 0ACh, 0BBh, 27h, 11h, 2Eh, 0D7h, 98h
	db	1, 45h, 18h, 1, 6, 92h, 4, 72h, 1, 0C3h, 33h, 0C0h, 50h, 0B8h
	db	1Fh, 0, 50h, 0E8h, 23h, 0AAh, 80h, 0Eh, 10h, 4, 4, 0EBh, 0EEh
P1_COMENT_E4:	cmp	si, word ptr ds:[3E0h]	;@0118A
	jb	@@2	;@0118E
	je	@@1	;@01190
	jmp	L010FD	;@01192
@@1:	ret	;@01195
@@2:	inc	word ptr [di+1Ah]	;@01196
	lodsb	;@01199
	lodsb	;@0119A
	cbw	;@0119B
	add	si, ax	;@0119C
	lodsw	;@0119E
	jmp	P1_COMENT_E4	;@0119F
L011A1:	push	ax	;@011A1
	push	bx	;@011A2
	sub	bx, 4001h	;@011A3
	shl	bx, 1	;@011A7
	add	bx, word ptr ds:[52Eh]	;@011A9
	mov	di, word ptr ds:[532h]	;@011AD
@@1:	cmp	di, word ptr ds:[7AEh]	;@011B1
	jae	@@2	;@011B5
	mov	es, word ptr ds:[7B0h]	;@011B7
	cmp	word ptr es:[di], bx	;@011BB
	je	@@4	;@011BE
	add	di, 11h	;@011C0
	jmp	@@1	;@011C3
@@2:	mov	di, 11h	;@011C5
	push	di	;@011C8
	mov	di, 7ACh	;@011C9
	call	POOL_ALLOC	;@011CC
	jae	@@3	;@011CF
	call	L054B0	;@011D1
@@3:	push	di	;@011D4
	mov	cx, 11h	;@011D5
	xor	ax, ax	;@011D8
	rep stosb	;@011DA
	pop	di	;@011DC
	mov	word ptr es:[di], bx	;@011DD
@@4:	pop	bx	;@011E0
	pop	ax	;@011E1
	ret	;@011E2
	db	0FFh, 6, 78h, 1, 0A1h, 78h, 1, 3Bh, 6, 8Ah, 4, 76h, 3, 0A3h, 8Ah	;@011E3
	db	4, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah
	db	1Ch, 46h, 81h, 0FBh, 0, 40h, 7Fh, 1Fh, 0FFh, 45h, 20h, 0E8h, 9Fh
	db	8, 0C7h, 6, 82h, 1, 0FFh, 0FFh
L01214:	mov	ax, word ptr ds:[367h]	;@01214
	cmp	ax, word ptr ds:[48Eh]	;@01217
	jbe	@@1	;@0121B
	mov	word ptr ds:[48Eh], ax	;@0121D
@@1:	mov	word ptr ds:[367h], 0	;@01220
	ret	;@01226
E5_SCOPE_INDEX:	call	L011A1	;@01227
	mov	word ptr ds:[182h], bx	;@0122A
	inc	word ptr es:[di+8]	;@0122E
	jmp	L01214	;@01232
COUNT_DEBUG_SYMBOLS:	cmp	si, word ptr ds:[3E0h]	;@01234
	jb	@@2	;@01238
	je	@@1	;@0123A
	jmp	L010FE	;@0123C
@@1:	ret	;@0123F
@@2:	lodsb	;@01240
	cbw	;@01241
	add	si, ax	;@01242
	cmp	byte ptr [si], 80h	;@01244
	sbb	si, -2	;@01247
	lodsb	;@0124A
	and	al, 7	;@0124B
	xlat	byte ptr cs:[bx]	;@0124D
	test	al, 80h	;@0124F
	je	@@3	;@01251
	inc	word ptr ds:[367h]	;@01253
	cmp	byte ptr [si], 80h	;@01257
	sbb	si, -2	;@0125A
	cmp	al, 90h	;@0125D
	jb	@@3	;@0125F
	cmp	byte ptr [si], 80h	;@01261
	sbb	si, -2	;@01264
@@3:	push	bx	;@01267
	cmp	word ptr ds:[178h], 0	;@01268
	je	@@4	;@0126D
	mov	bx, word ptr ds:[182h]	;@0126F
	cmp	bx, -1	;@01273
	je	@@4	;@01276
	push	di	;@01278
	call	L011A1	;@01279
	inc	word ptr es:[di+6]	;@0127C
	pop	di	;@01280
	jmp	short @@5	;@01281
@@4:	inc	word ptr [di+1Ch]	;@01283
@@5:	pop	bx	;@01286
	and	ax, 7	;@01287
	add	si, ax	;@0128A
	jmp	COUNT_DEBUG_SYMBOLS	;@0128C
	db	92h, 82h, 2, 2, 1, 4, 0, 0, 0BBh, 8Eh, 12h, 0E8h, 98h, 0FFh, 0C3h	;@0128E
P1_COMENT_E7:	dec	word ptr ds:[178h]	;@0129D
	jmp	L01214	;@012A1
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah	;@012A4
	db	1Ch, 46h, 23h, 0DBh, 75h, 3, 0FFh, 45h, 24h, 0C7h, 6, 9Bh, 3, 1
	db	0, 0C7h, 6, 7Ah, 1, 0FFh, 0FFh, 0C3h
P1_COMENT_SKIP:	ret	;@012C7
P1_COMENT_EA:	lodsw	;@012C8
	mov	byte ptr [di+30h], al	;@012C9
	mov	byte ptr [di+31h], ah	;@012CC
	ret	;@012CF
	db	80h, 3Eh, 0D2h, 3, 2, 74h, 23h, 0B4h, 0, 0E8h, 3Ah, 7Bh, 8Bh, 0FBh	;@012D0
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah
	db	1Ch, 46h, 83h, 0FBh, 18h, 72h, 4, 3, 1Eh, 8Fh, 3, 26h, 89h, 5Dh
	db	0FAh, 0C3h, 0B4h, 0, 0E8h, 16h, 7Bh, 26h, 8Bh, 3Fh, 83h, 0FFh
	db	0FFh, 't0W', 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h
	db	8Eh, 85h, 58h, 7, 5Fh, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh
	db	80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 83h, 0FBh, 18h, 72h, 4, 3, 1Eh
	db	8Fh, 3, 26h, 89h, 5Dh, 10h, 0ACh, 26h, 8, 45h, 0Fh, 0C3h
P1_COMENT_ED:	lodsb	;@01339
	and	al, al	;@0133A
	je	@@2	;@0133C
	lodsb	;@0133E
	cbw	;@0133F
	and	al, al	;@01340
	jns	@@1	;@01342
	sub	al, 80h	;@01344
	mov	ah, al	;@01346
	lodsb	;@01348
@@1:	add	word ptr [di+2Ch], ax	;@01349
	ret	;@0134C
@@2:	mov	ax, word ptr ds:[178h]	;@0134D
	or	word ptr ds:[3A8h], ax	;@01350
	cmp	byte ptr [si], 80h	;@01354
	sbb	si, -2	;@01357
	add	si, 3	;@0135A
	lodsb	;@0135D
	cbw	;@0135E
	and	al, al	;@0135F
	jns	@@3	;@01361
	sub	al, 80h	;@01363
	mov	ah, al	;@01365
	lodsb	;@01367
@@3:	add	word ptr [di+2Eh], ax	;@01368
	inc	word ptr [di+2Ah]	;@0136B
	ret	;@0136E
	db	0B4h, 0, 0E8h, 0A2h, 7Ah, 0C3h, 80h, 3Eh, 2Fh, 1, 1, 74h, 27h	;@0136F
	db	57h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 46h, 81h, 0FBh, 0, 40h, 7Fh, 16h, 0E8h, 18h, 7, 0A1h
	db	0E0h, 3, 2Bh, 0C6h, 0D1h, 0E8h, 5Fh, 1, 45h, 32h, 0FFh, 45h, 34h
	db	8Bh, 36h, 0E0h, 3, 0C3h, 83h, 0C4h, 2, 0E8h, 0F3h, 0FDh, 0A1h
	db	0E0h, 3, 2Bh, 0C6h, 0D1h, 0E8h, 26h, 1, 45h, 0Ch, 26h, 0FFh, 45h
	db	0Eh, 0EBh, 0E4h, 90h, 10h, 0C7h, 10h, 1, 11h, 5Dh, 11h, 8Ah, 11h
	db	0E3h, 11h, 96h, 12h, 9Dh, 12h, 0A4h, 12h, 0C7h, 12h, 0C8h, 12h
	db	0D0h, 12h, 0FBh, 12h, 39h, 13h, 75h, 13h, 0C7h, 12h, 0C7h, 12h
	db	0C7h, 12h, 0C7h, 12h, 0C7h, 12h, 0C7h, 12h, 0C7h, 12h, 0C7h, 12h
	db	0C7h, 12h, 6Fh, 13h, 0BEh, 8Ah, 1, 8Bh, 0Eh, 50h, 5, 8Bh, 3Eh
	db	2Ch, 5, 8Eh, 6, 80h, 7, 8Bh, 16h, 76h, 7, 0B8h, 1, 0, 85h, 4, 74h
	db	5, 26h, 0C6h, 45h, 9, 1, 0D1h, 0E0h, 72h, 8, 83h, 0C7h, 0Ah, 3Bh
	db	0FAh, 72h, 0ECh, 0C3h, 0D1h, 0D0h, 46h, 46h, 0EBh, 0F2h
QUALIFY_LOCAL_NAME:	mov	al, byte ptr [si]	;@01422
	add	al, 2	;@01424
	sub	si, 2	;@01426
	mov	byte ptr [si], al	;@01429
	mov	ax, word ptr ds:[186h]	;@0142B
	mov	word ptr [si+1], ax	;@0142E
	ret	;@01431
	db	80h, 3Eh, 94h, 4, 0, 74h, 7, 8Bh, 36h, 0E0h, 3, 0E9h, 91h, 43h	;@01432
	db	0FEh, 0Eh, 94h, 4, 0C7h, 6, 64h, 1, 0, 0, 0C7h, 6, 66h, 1, 0, 0
	db	0C7h, 6, 8Eh, 7, 0, 0, 0B4h, 40h, 80h, 3Eh, 0D2h, 3, 1, 73h, 65h
	db	0C7h, 6, 36h, 5, 0, 0, 81h, 3Ch, 1, 'AuqPQVW', 0C7h, 6, 0BCh, 2
	db	1, 41h, 1Eh, 7, 0BBh, 0BBh, 92h, 8Bh, 0F3h, 80h, '?:t', 0Ah, 80h
	db	'?\t', 5, 80h, '?/u', 3, 8Dh, 77h, 1, 80h, 3Fh, 0, 74h, 3, 43h
	db	0EBh, 0E6h, 8Bh, 0CBh, 2Bh, 0CEh, 74h, 17h, 4Bh, 3Bh, 0DEh, 72h
	db	9, 80h, '?.u', 0F6h, 8Bh, 0CBh, 2Bh, 0CEh, 0BFh, 0BCh, 2, 0FCh
	db	8Ah, 0C1h, 0AAh, 0F3h, 0A4h, 6, 1Fh, 0BEh, 0BCh, 2, 0E8h, '[y_^YX'
	db	83h, 0C6h, 2, 0EBh, 1Bh, 8Bh, 0C6h, 2Dh, 53h, 12h, 1Bh, 0D2h, 3
	db	6, 68h, 52h, 13h, 16h, 6Ah, 52h, 0F7h, '6bR', 0A3h, 36h, 5, 0B4h
	db	40h, 0E8h, 37h, 79h, 1Eh, 7, 0BFh, 2Ah, 5, 8Bh, 0C3h, 0ABh, 0A1h
	db	76h, 7, 0ABh, 0A1h, 86h, 7, 0ABh, 0A1h, 96h, 7, 0ABh, 0A1h, 0AEh
	db	7, 0ABh, 33h, 0C0h, 80h, 3Eh, 0D2h, 3, 2, 75h, 1, 40h, 0ABh, 'GG3'
	db	0C0h, 0B9h, 2Ah, 0, 0F3h, 0AAh, 0A3h, 78h, 1, 0BFh, 8Ah, 1, 0B9h
	db	40h, 0, 0F3h, 0ABh, 0C7h, 6, 7Ah, 1, 0FFh, 0FFh, 0C7h, 6, 9Bh
	db	3, 0FFh, 0FFh, 0C7h, 6, 67h, 3, 0, 0, 0C7h, 6, 0A8h, 3, 0, 0, 0E9h
	db	0A0h, 42h, 0ADh, 80h, 3Eh, 0D4h, 3, 0, 75h, 12h, 80h, 3Eh, 19h
	db	0, 0, 74h, 0Bh, 80h, 0FCh, 0A0h, 75h, 6, 0E8h, 58h, 82h, 0E9h
	db	1, 1, 0BAh, 9Ch, 2, 0Ah, 0E4h, 74h, 4Dh, 80h, 0FCh, 0A1h, 74h
	db	4Bh, 80h, 0FCh, 9Fh, 'tN3', 0D2h, 80h, 0FCh, 0B4h, 74h, 47h, 80h
	db	3Eh, 18h, 0, 1, 75h, 5, 80h, 0FCh, 9Eh, 74h, 28h, 80h, 3Eh, 17h
	db	0, 0, 74h, 1Eh, 8Ah, 0DCh, 32h, 0FFh, 81h, 0EBh, 0E0h, 0, 7Ch
	db	14h, 83h, 0FBh, 19h, 73h, 0Fh, 0BFh, 2Ah, 5, 0D1h, 0E3h, 2Eh, 0FFh
	db	97h, 0BFh, 13h, 0C6h, 6, 3Ah, 5, 4, 0E9h, 0B5h, 0, 0C6h, 6, 0D7h
	db	3, 1, 0E9h, 0ADh, 0, 0E9h, 0AAh, 0, 80h, 0Eh, 3Fh, 5, 1, 0E9h
	db	0A2h, 0, 80h, 3Eh, 25h, 1, 1, 74h, 0E3h, 83h, 3Eh, 7Ch, 1, 0, 74h
	db	0DCh, 8Bh, 3Eh, 80h, 1, 1Eh, 7, 47h, 47h, 8Bh, 0Eh, 0E0h, 3, 2Bh
	db	0CEh, 32h, 0DBh, 0ACh, '<Ar', 6, '<Zw', 2, 4, ' ;>~', 1, 73h, 73h
	db	0AAh, '<\t', 10h, '<:t', 0Ch, '</t', 8, '<.u', 6, 0B3h, 1, 0EBh
	db	2, 32h, 0DBh, 0E2h, 0D6h, 23h, 0D2h, 74h, 15h, 22h, 0DBh, 75h
	db	11h, 8Dh, 45h, 4, 3Bh, 6, 7Eh, 1, 73h, 49h, 8Bh, 0F2h, 1Eh, 0Eh
	db	1Fh, 0A5h, 0A5h, 1Fh, ';>~', 1, 's;*', 0C0h, 0AAh, 8Bh, 0CFh, 8Bh
	db	3Eh, 80h, 1, 'GG+', 0CFh, 1Eh, 0BEh, 38h, 1, 0E8h, 2Ah, 0, 1Fh
	db	72h, 24h, 1Eh, 0BEh, 3Eh, 1, 0E8h, 20h, 0, 1Fh, 72h, 1Ah, 3, 0F9h
	db	87h, 3Eh, 80h, 1, 56h, 8Bh, '6pR', 89h, 3Ch, 89h, '>pR', 0C7h
	db	5, 0, 0, 5Eh, 0FFh, 0Eh, 7Ch, 1, 0E9h, 82h, 41h, 8Bh, 34h, 0C5h
	db	1Eh, 34h, 1, 8Eh, 1Fh, 83h, 0FEh, 0, 74h, 0Fh, 0FFh, '4WQFF', 0F3h
	db	0A6h, 'Y_^u', 0EEh, 0F9h, 0C3h, 0F8h, 0C3h, 0FEh, 6, 94h, 4, 8Ah
	db	4, 3Ch, 0C1h, 75h, 1Eh, 83h, 3Eh, 0F6h, 3, 0FFh, 75h, 17h, 8Bh
	db	3Eh, 86h, 1, 89h, 3Eh, 0F6h, 3, 80h, 3Eh, 2Bh, 1, 1, 75h, 8, 46h
	db	0E8h, 66h, 8, 89h, 0Eh, 35h, 0Ah, 0A1h, 66h, 1, 80h, 3Eh, 0D6h
	db	3, 1, 75h, 1Bh, 3Bh, 6, 64h, 1, 76h, 15h, 2Bh, 6, 64h, 1, 90h
	db	0B4h, 0Ah, 0F6h, 0E4h, 90h, 29h, 6, 76h, 7, 29h, 6, 7Eh, 7, 0A1h
	db	64h, 1, 0A3h, 3Dh, 5, 8Ah, 1Eh, 3Ah, 5, 81h, 0E3h, 0FFh, 0, 74h
	db	18h, 83h, 3Eh, 0A8h, 3, 0, 74h, 5, 80h, 0Eh, 5Ah, 5, 80h, 0A1h
	db	50h, 5, 23h, 0C0h, 74h, 5, 53h, 0E8h, 13h, 0FDh, 5Bh, 0A1h, 67h
	db	3, 3Bh, 6, 8Eh, 4, 76h, 3, 0A3h, 8Eh, 4, 0A1h, 5Ch, 5, 3Bh, 6
	db	0C8h, 3, 76h, 3, 0A3h, 0C8h, 3, 0A1h, 5Eh, 5, 3Bh, 6, 0C6h, 3
	db	76h, 3, 0A3h, 0C6h, 3, 0A1h, 42h, 5, 1, 6, 8Fh, 3, 2Eh, 8Bh, 8Fh
	db	'PWS', 8Bh, 1Eh, 3Ah, 7, 0C4h, 7Fh, 2, 3, 0F9h, ';?v', 9, 0E8h
	db	0C9h, '=[s', 7, 0E8h, 8Ah, 3Dh, 87h, 7Fh, 2, 5Bh, 89h, 3Eh, 84h
	db	1, 8Bh, 0F7h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h
	db	8Dh, 0B4h, 34h, 7, 8Bh, 74h, 2, 89h, 36h, 86h, 1, 83h, 0C6h, 38h
	db	83h, 0FEh, 80h, 76h, 1Ch, 83h, 0E6h, 3, 46h, 89h, 36h, 86h, 1
	db	8Bh, 0F7h, 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Dh
	db	0B4h, 34h, 7, 0C7h, 44h, 2, 80h, 0FFh, 0BEh, 2Ah, 5, 0D1h, 0E9h
	db	0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 80h, 3Eh, 0D2h, 3, 0, 74h
	db	2Dh, 8Bh, 36h, 0E0h, 3, 46h, 1Eh, 7, 8Bh, 0Eh, 'XR+', 0CEh, 83h
	db	0F9h, 2, 73h, 5, 0E8h, 92h, 6Eh, 0EBh, 0F0h, 2Bh, 0C0h, 8Bh, 0FEh
	db	0D1h, 0E9h, 0F3h, 0AFh, 8Bh, 0F7h, 74h, 0E4h, 4Eh, 4Eh, 80h, 3Ch
	db	1, 13h, 0F0h, 0E9h, 33h, 40h, 0C3h
L017A8:	push	ax	;@017A8
	push	cx	;@017A9
	mov	cx, word ptr ds:[490h]	;@017AA
	push	bx	;@017AE
	mov	bx, word ptr ds:[75Ah]	;@017AF
	les	di, dword ptr [bx+2]	;@017B3
	add	di, cx	;@017B6
	cmp	di, word ptr [bx]	;@017B8
	ja	@@2	;@017BA
	xchg	word ptr [bx+2], di	;@017BC
	pop	bx	;@017BF
@@1:	mov	word ptr ds:[176h], di	;@017C0
	push	di	;@017C4
	mov	al, 0	;@017C5
	cld	;@017C7
	rep stosb	;@017C8
	pop	di	;@017CA
	dec	word ptr es:[di+8]	;@017CB
	dec	word ptr es:[di+0Ah]	;@017CF
	pop	cx	;@017D3
	pop	ax	;@017D4
	ret	;@017D5
@@2:	call	L054E9	;@017D6
	pop	bx	;@017D9
	jae	@@1	;@017DA
	db	0E9h, 45h, 77h	; jmp L08F24	;@017DC
ADD_EXTERN:	mov	ax, word ptr es:[bx]	;@017DF
	cmp	ax, 0FFFFh	;@017E2
	jne	@@1	;@017E5
	call	L017A8	;@017E7
	or	byte ptr es:[di+0Eh], dl	;@017EA
	mov	word ptr es:[di+0Ch], bx	;@017EE
	mov	ax, word ptr ds:[186h]	;@017F2
	mov	word ptr es:[di+2], ax	;@017F5
	xchg	ax, di	;@017F9
	push	bx	;@017FA
	and	bx, 3	;@017FB
	shl	bx, 1	;@017FE
	shl	bx, 1	;@01800
	shl	bx, 1	;@01802
	mov	es, word ptr [bx+718h]	;@01804
	pop	bx	;@01808
	mov	word ptr es:[bx], ax	;@01809
@@1:	les	di, dword ptr ds:[786h]	;@0180C
	add	di, 2	;@01810
	cmp	di, word ptr ds:[784h]	;@01813
	jbe	@@2	;@01817
	mov	di, 2	;@01819
	push	di	;@0181C
	mov	di, 784h	;@0181D
	call	POOL_ALLOC	;@01820
	jae	@@3	;@01823
	call	L054B0	;@01825
@@2:	xchg	word ptr ds:[786h], di	;@01828
@@3:	mov	word ptr ds:[188h], di	;@0182C
	mov	word ptr es:[di], ax	;@01830
	ret	;@01833
P1_EXTDEF_NAMES:	mov	bx, word ptr ds:[174h]	;@01834
	or	dl, 10h	;@01838
	jmp	short @@3	;@0183B
@@1:	test	dl, 4	;@0183D
	je	@@2	;@01840
	call	QUALIFY_LOCAL_NAME	;@01842
@@2:	mov	ah, 0	;@01845
	db	0E8h, 0CCh, 75h	; call L08E16	;@01847
	call	ADD_EXTERN	;@0184A
	cmp	byte ptr [si], 80h	;@0184D
	sbb	si, -2	;@01850
@@3:	cmp	si, word ptr ds:[3E0h]	;@01853
	jb	@@1	;@01857
	mov	word ptr ds:[174h], bx	;@01859
	db	0E9h, 71h, 3Fh	; jmp L057D1	;@0185D
P1_EXTDEF:	mov	dl, 0	;@01860
	jmp	P1_EXTDEF_NAMES	;@01862
P1_LEXTDEF:	mov	dl, 4	;@01864
	jmp	P1_EXTDEF_NAMES	;@01866
L01868:	cmp	byte ptr [si], 80h	;@01868
	sbb	si, -2	;@0186B
	sub	bx, bx	;@0186E
	add	bl, byte ptr [si]	;@01870
	jge	@@1	;@01872
	inc	si	;@01874
	sub	bl, 80h	;@01875
	mov	bh, bl	;@01878
	mov	bl, byte ptr [si]	;@0187A
@@1:	inc	si	;@0187C
	or	bx, bx	;@0187D
	jne	@@2	;@0187F
	mov	dl, 2	;@01881
	lodsw	;@01883
	sub	ax, ax	;@01884
	jmp	short @@4	;@01886
@@2:	mov	dl, 0	;@01888
	cmp	bx, 4000h	;@0188A
	jg	@@5	;@0188E
	cmp	bx, word ptr ds:[164h]	;@01890
	jbe	@@3	;@01894
	mov	word ptr ds:[164h], bx	;@01896
@@3:	dec	bx	;@0189A
	xchg	ax, bx	;@0189B
	mov	ah, 0Ah	;@0189C
	mul	ah	;@0189E
	xchg	ax, bx	;@018A0
	add	bx, word ptr ds:[52Ch]	;@018A1
	xchg	ax, bx	;@018A5
@@4:	ret	;@018A6
@@5:	mov	ax, 0FFFFh	;@018A7
	jmp	@@4	;@018AA
L018AC:	push	bx	;@018AC
	and	bx, 3	;@018AD
	shl	bx, 1	;@018B0
	shl	bx, 1	;@018B2
	shl	bx, 1	;@018B4
	mov	es, word ptr [bx+718h]	;@018B6
	pop	bx	;@018BA
	mov	si, word ptr es:[bx]	;@018BB
	push	si	;@018BE
	and	si, 3	;@018BF
	shl	si, 1	;@018C2
	shl	si, 1	;@018C4
	shl	si, 1	;@018C6
	mov	es, word ptr [si+758h]	;@018C8
	pop	si	;@018CC
	mov	si, word ptr es:[si+2]	;@018CD
	ret	;@018D1
DEFINE_PUBLIC:	cmp	word ptr es:[bx], -1	;@018D2
	je	@@1	;@018D6
	jmp	@@6	;@018D8
@@1:	call	L017A8	;@018DB
@@2:	mov	word ptr ds:[176h], di	;@018DE
	mov	ax, word ptr ds:[16Ch]	;@018E2
	mov	word ptr es:[di], ax	;@018E5
	mov	ax, word ptr ds:[186h]	;@018E8
	mov	word ptr es:[di+2], ax	;@018EB
	mov	ax, word ptr ds:[16Eh]	;@018EF
	mov	word ptr es:[di+4], ax	;@018F2
	mov	ax, word ptr ds:[170h]	;@018F6
	mov	word ptr es:[di+6], ax	;@018F9
	mov	word ptr es:[di+0Ch], bx	;@018FD
	mov	al, byte ptr ds:[172h]	;@01901
	mov	byte ptr es:[di+0Eh], al	;@01904
	test	al, 2	;@01908
	je	@@3	;@0190A
	mov	byte ptr es:[di+0Fh], 5	;@0190C
@@3:	mov	dx, 0FFFFh	;@01911
	push	bx	;@01914
	test	al, 2	;@01915
	jne	@@4	;@01917
	mov	bx, word ptr ds:[16Ch]	;@01919
	mov	cx, word ptr ds:[44Eh]	;@0191D
	mov	es, word ptr ds:[778h]	;@01921
	cmp	cx, word ptr es:[bx+2]	;@01925
	jne	@@4	;@01929
	mov	dx, di	;@0192B
	mov	es, word ptr ds:[780h]	;@0192D
	xchg	word ptr es:[bx+4], dx	;@01931
	push	di	;@01935
	and	di, 3	;@01936
	shl	di, 1	;@01939
	shl	di, 1	;@0193B
	shl	di, 1	;@0193D
	mov	es, word ptr [di+758h]	;@0193F
	pop	di	;@01943
	mov	word ptr es:[di+0Ah], dx	;@01944
@@4:	pop	bx	;@01948
	push	bx	;@01949
	and	bx, 3	;@0194A
	shl	bx, 1	;@0194D
	shl	bx, 1	;@0194F
	shl	bx, 1	;@01951
	mov	es, word ptr [bx+718h]	;@01953
	pop	bx	;@01957
	mov	word ptr es:[bx], di	;@01958
@@5:	ret	;@0195B
@@6:	mov	di, word ptr es:[bx]	;@0195C
	push	di	;@0195F
	and	di, 3	;@01960
	shl	di, 1	;@01963
	shl	di, 1	;@01965
	shl	di, 1	;@01967
	mov	es, word ptr [di+758h]	;@01969
	pop	di	;@0196D
	test	byte ptr es:[di+0Eh], 18h	;@0196E
	je	@@8	;@01973
	test	byte ptr es:[di+0Eh], 10h	;@01975
	je	@@7	;@0197A
	jmp	@@2	;@0197C
@@7:	cmp	word ptr es:[di], -2	;@0197F
	jb	@@8	;@01983
	jmp	@@2	;@01985
@@8:	cmp	byte ptr ds:[3D2h], 1	;@01988
	jbe	@@9	;@0198D
	cmp	byte ptr ds:[124h], 1	;@0198F
	jne	@@5	;@01994
@@9:	push	si	;@01996
	push	di	;@01997
	push	bx	;@01998
	push	di	;@01999
	push	ax	;@0199A
	push	dx	;@0199B
	push	bx	;@0199C
	call	L018AC	;@0199D
	mov	bx, si	;@019A0
	pop	si	;@019A2
	push	bx	;@019A3
	mov	di, 28h	;@019A4
	push	si	;@019A7
	and	si, 3	;@019A8
	shl	si, 1	;@019AB
	shl	si, 1	;@019AD
	shl	si, 1	;@019AF
	mov	es, word ptr [si+718h]	;@019B1
	pop	si	;@019B5
	cmp	byte ptr es:[si+3], 40h	;@019B6
	je	@@10	;@019BB
	db	0E8h, 80h, 7Dh	; call COPY_NAME	;@019BD
	jmp	short @@11	;@019C0
@@10:	db	0E8h, 23h, 7Ch	; call L095E8	;@019C2
@@11:	pop	si	;@019C5
	mov	word ptr ds:[422h], 1	;@019C6
	and	si, -2	;@019CC
	cmp	si, word ptr ds:[186h]	;@019CF
	je	@@13	;@019D3
	push	si	;@019D5
	and	si, 3	;@019D6
	shl	si, 1	;@019D9
	shl	si, 1	;@019DB
	shl	si, 1	;@019DD
	mov	es, word ptr [si+738h]	;@019DF
	pop	si	;@019E3
	mov	si, word ptr es:[si]	;@019E4
	mov	di, 78h	;@019E7
	db	0E8h, 53h, 7Dh	; call COPY_NAME	;@019EA
	push	ds	;@019ED
	mov	ax, 78h	;@019EE
	push	ax	;@019F1
	push	ds	;@019F2
	mov	ax, 28h	;@019F3
	push	ax	;@019F6
	mov	cx, 8	;@019F7
	push	cx	;@019FA
	cmp	byte ptr ds:[3D2h], 2	;@019FB
	je	@@12	;@01A00
	mov	ax, 25h	;@01A02
	push	ax	;@01A05
	db	0E8h, 9Dh, 0A1h	; call ERROR	;@01A06
	jmp	short @@15	;@01A09
@@12:	mov	ax, 31h	;@01A0B
	push	ax	;@01A0E
	db	0E8h, 99h, 0A1h	; call WARNING	;@01A0F
	jmp	short @@15	;@01A12
@@13:	push	ds	;@01A14
	mov	ax, 28h	;@01A15
	push	ax	;@01A18
	mov	cx, 4	;@01A19
	push	cx	;@01A1C
	cmp	byte ptr ds:[3D2h], 2	;@01A1D
	je	@@14	;@01A22
	mov	ax, 24h	;@01A24
	push	ax	;@01A27
	db	0E8h, 7Bh, 0A1h	; call ERROR	;@01A28
	jmp	short @@15	;@01A2B
@@14:	mov	ax, 30h	;@01A2D
	push	ax	;@01A30
	db	0E8h, 77h, 0A1h	; call WARNING	;@01A31
@@15:	pop	dx	;@01A34
	pop	ax	;@01A35
	pop	di	;@01A36
	pop	bx	;@01A37
	pop	di	;@01A38
	pop	si	;@01A39
	jmp	@@5	;@01A3A
P1_PUBDEF_NAMES:	mov	byte ptr ds:[172h], al	;@01A3D
	call	L01868	;@01A40
	or	byte ptr ds:[172h], dl	;@01A43
	mov	word ptr ds:[16Ch], ax	;@01A47
	jmp	short @@6	;@01A4A
@@1:	test	byte ptr ds:[172h], 4	;@01A4C
	je	@@2	;@01A51
	call	QUALIFY_LOCAL_NAME	;@01A53
@@2:	mov	ah, 0	;@01A56
	db	0E8h, 0BBh, 73h	; call L08E16	;@01A58
	cmp	byte ptr ds:[12Bh], 3	;@01A5B
	jne	@@4	;@01A60
	cmp	bx, word ptr ds:[472h]	;@01A62
	jne	@@4	;@01A66
	cmp	byte ptr ds:[20Ah], 0FFh	;@01A68
	je	@@3	;@01A6D
	mov	bx, word ptr ds:[474h]	;@01A6F
	jmp	short @@4	;@01A73
@@3:	inc	byte ptr ds:[20Ah]	;@01A75
@@4:	push	bx	;@01A79
	lodsw	;@01A7A
	mov	word ptr ds:[16Eh], ax	;@01A7B
	xor	ax, ax	;@01A7E
	cmp	ax, word ptr ds:[41Eh]	;@01A80
	je	@@5	;@01A84
	lodsw	;@01A86
@@5:	mov	word ptr ds:[170h], ax	;@01A87
	cmp	byte ptr [si], 80h	;@01A8A
	sbb	si, -2	;@01A8D
	pop	bx	;@01A90
	cmp	word ptr ds:[16Ch], -1	;@01A91
	je	@@6	;@01A96
	call	DEFINE_PUBLIC	;@01A98
@@6:	cmp	si, word ptr ds:[3E0h]	;@01A9B
	jb	@@1	;@01A9F
	db	0E9h, 2Dh, 3Dh	; jmp L057D1	;@01AA1
P1_PUBDEF:	sub	ax, ax	;@01AA4
	jmp	P1_PUBDEF_NAMES	;@01AA6
P1_LPUBDEF:	mov	ax, 4	;@01AA8
	jmp	P1_PUBDEF_NAMES	;@01AAB
MARK_EXTERN_USED:	push	si	;@01AAD
	dec	bx	;@01AAE
	cmp	bx, 400h	;@01AAF
	jae	@@2	;@01AB3
	mov	si, bx	;@01AB5
	and	si, 7	;@01AB7
	shr	bx, 1	;@01ABA
	shr	bx, 1	;@01ABC
	shr	bx, 1	;@01ABE
	mov	al, byte ptr cs:[si+1AD8h]	;@01AC0
	test	byte ptr [bx+18Ah], al	;@01AC5
	jne	@@1	;@01AC9
	inc	word ptr ds:[550h]	;@01ACB
	or	byte ptr [bx+18Ah], al	;@01ACF
@@1:	pop	si	;@01AD3
	ret	;@01AD4
@@2:	db	0E8h, 0C5h, 6Bh	; call L0869D	;@01AD5
	add	word ptr [bp+si], ax	;@01AD8
	add	al, 8	;@01ADA
	adc	byte ptr [bx+si], ah	;@01ADC
	inc	ax	;@01ADE
	add	byte ptr [bx+si-7FC4h], 83h	;@01ADF
	fdivp	st(6)	;@01AE4
	sub	bx, bx	;@01AE6
	add	bl, byte ptr [si]	;@01AE8
	jge	@@3	;@01AEA
	inc	si	;@01AEC
	sub	bl, 80h	;@01AED
	mov	bh, bl	;@01AF0
	mov	bl, byte ptr [si]	;@01AF2
@@3:	inc	si	;@01AF4
	cmp	byte ptr ds:[17h], 0	;@01AF5
	je	@@7	;@01AFA
	cmp	bx, 4000h	;@01AFC
	jg	@@8	;@01B00
	cmp	bx, word ptr ds:[17Ah]	;@01B02
	je	@@5	;@01B06
	mov	word ptr ds:[17Ah], bx	;@01B08
	inc	word ptr ds:[552h]	;@01B0C
	mov	ax, word ptr ds:[552h]	;@01B10
	cmp	ax, word ptr ds:[48Ch]	;@01B13
	jbe	@@4	;@01B17
	mov	word ptr ds:[48Ch], ax	;@01B19
@@4:	call	MARK_EXTERN_USED	;@01B1C
@@5:	cmp	word ptr ds:[39Bh], -1	;@01B1F
	jne	@@6	;@01B24
	inc	word ptr ds:[54Eh]	;@01B26
	mov	word ptr ds:[39Bh], 0	;@01B2A
@@6:	mov	ax, word ptr ds:[3E0h]	;@01B30
	sub	ax, si	;@01B33
	shr	ax, 1	;@01B35
	shr	ax, 1	;@01B37
	add	word ptr ds:[54Ch], ax	;@01B39
	cmp	byte ptr ds:[53Ah], 0	;@01B3D
	jne	@@7	;@01B42
	mov	byte ptr ds:[53Ah], 2	;@01B44
@@7:	db	0E9h, 85h, 3Ch	; jmp L057D1	;@01B49
@@8:	call	L011A1	;@01B4C
	cmp	word ptr ds:[39Bh], -1	;@01B4F
	jne	@@9	;@01B54
	inc	word ptr es:[di+2]	;@01B56
	mov	word ptr ds:[39Bh], 0	;@01B5A
@@9:	mov	ax, word ptr ds:[3E0h]	;@01B60
	sub	ax, si	;@01B63
	shr	ax, 1	;@01B65
	shr	ax, 1	;@01B67
	add	word ptr es:[di+4], ax	;@01B69
	cmp	byte ptr es:[di+10h], 0	;@01B6D
	jne	@@10	;@01B72
	mov	byte ptr es:[di+10h], 2	;@01B74
@@10:	inc	word ptr es:[di+0Ah]	;@01B79
	db	0E9h, 51h, 3Ch	; jmp L057D1	;@01B7D
	db	0EBh, 17h, 0B4h, 80h, 0E8h, 8Fh, 72h, 0BFh, 2, 0, 57h, 0BFh, 8Ch	;@01B80
	db	7, 0E8h, ',9s', 3, 0E8h, 1Ah, 39h, 26h, 89h, 1Dh, 3Bh, 36h, 0E0h
	db	3, 72h, 0E3h, 0E9h, 2Fh, 3Ch
L01BA2:	mov	word ptr es:[di], bx	;@01BA2
	mov	word ptr es:[di+2], dx	;@01BA5
	cmp	word ptr ds:[0A43h], -1	;@01BA9
	jne	@@1	;@01BAE
	cmp	bx, word ptr ds:[438h]	;@01BB0
	jne	@@1	;@01BB4
	cmp	dx, word ptr ds:[44Ch]	;@01BB6
	jne	@@1	;@01BBA
	mov	word ptr ds:[0A43h], di	;@01BBC
@@1:	mov	ax, word ptr ds:[3D8h]	;@01BC0
	push	bx	;@01BC3
	and	bx, 3	;@01BC4
	shl	bx, 1	;@01BC7
	shl	bx, 1	;@01BC9
	shl	bx, 1	;@01BCB
	mov	es, word ptr [bx+718h]	;@01BCD
	pop	bx	;@01BD1
	cmp	word ptr es:[bx], -1	;@01BD2
	jne	@@2	;@01BD6
	inc	ax	;@01BD8
	mov	word ptr es:[bx], ax	;@01BD9
@@2:	xchg	bx, dx	;@01BDC
	push	bx	;@01BDE
	and	bx, 3	;@01BDF
	shl	bx, 1	;@01BE2
	shl	bx, 1	;@01BE4
	shl	bx, 1	;@01BE6
	mov	es, word ptr [bx+718h]	;@01BE8
	pop	bx	;@01BEC
	cmp	word ptr es:[bx], -1	;@01BED
	jne	@@3	;@01BF1
	inc	ax	;@01BF3
	mov	word ptr es:[bx], ax	;@01BF4
@@3:	mov	word ptr ds:[3D8h], ax	;@01BF7
	ret	;@01BFA
	db	0E8h, 3Eh, 3Eh, 0A1h, 86h, 1, 26h, 89h, 45h, 4, 0ACh, 26h, 88h	;@01BFB
	db	45h, 9, 3Ch, 0C0h, 72h, 3, 0E9h, 0DDh, 0, 0A8h, 0E0h, 75h, 9, 0ADh
	db	8Eh, 6, 80h, 7, 26h, 89h, 5, 46h, 0ADh, 8Eh, 6, 78h, 7, 26h, 89h
	db	45h, 6, 91h, 0B8h, 2, 0, '&"E', 9, 0D1h, 0E8h, 83h, 3Eh, 1Eh, 4
	db	0, 74h, 1, 0ADh, 0Ah, 0C8h, 26h, 88h, 45h, 8, 2Bh, 0DBh, 2, 1Ch
	db	7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 4Bh, 0D1h
	db	0E3h, 8Bh, 0D3h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h
	db	8Ah, 0FBh, 8Ah, 1Ch, 46h, 4Bh, 0D1h, 0E3h, 8Eh, 6, 90h, 7, 26h
	db	8Bh, 1Fh, 87h, 0D3h, 26h, 8Bh, 1Fh, 0A1h, 66h, 1, 40h, 0A3h, 66h
	db	1, 0Bh, 0C9h, 75h, 0Ch, 3Bh, 16h, 26h, 4, 74h, 9, 3Bh, 16h, 2Ch
	db	4, 74h, 3, 0A3h, 64h, 1, 56h, 57h, 83h, 3Eh, 1Ah, 4, 1, 'uN3'
	db	0FFh, ';>.', 8, 73h, 46h, 8Eh, 6, 30h, 8, 26h, 83h, 3Dh, 0FEh
	db	74h, 9, 26h, 3Bh, 15h, 't3GG', 0EBh, 0E7h, 8Bh, 0F2h, 56h, 83h
	db	0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 18h, 7
	db	5Eh, 26h, 8Ah, 44h, 2, 25h, 3Fh, 0, 3Dh, 4, 0, 72h, 0DFh, 3, 0F0h
	db	26h, 81h, 7Ch, 0FFh, 'COu', 0D5h, 26h, 81h, 7Ch, 1, 'DEu', 0CDh
	db	8Bh, 16h, 4Eh, 4, 5Fh, 5Eh, 8Eh, 6, 78h, 7, 0E8h, 0B7h, 0FEh, 0E9h
	db	0E3h, 3Ah, 0C7h, 6, 22h, 4, 1, 0, 33h, 0C0h, 50h, 0B8h, 6, 0, 50h
	db	0E8h, 0A3h, 9Eh
L01CFE:	or	bx, bx	;@01CFE
	je	@@2	;@01D00
	dec	bx	;@01D02
	xchg	ax, bx	;@01D03
	mov	ah, 0Ah	;@01D04
	mul	ah	;@01D06
	xchg	ax, bx	;@01D08
	add	bx, word ptr ds:[52Ch]	;@01D09
	mov	es, word ptr ds:[780h]	;@01D0D
	cmp	word ptr es:[bx], -1	;@01D11
	jne	@@2	;@01D15
	mov	word ptr es:[bx], dx	;@01D17
	cmp	cx, -1	;@01D1A
	jne	@@1	;@01D1D
	mov	cx, bx	;@01D1F
@@1:	ret	;@01D21
@@2:	mov	si, dx	;@01D22
	mov	di, 28h	;@01D24
	db	0E8h, 16h, 7Ah	; call COPY_NAME	;@01D27
	mov	word ptr ds:[422h], 1	;@01D2A
	push	ds	;@01D30
	mov	ax, 28h	;@01D31
	push	ax	;@01D34
	mov	cx, 4	;@01D35
	push	cx	;@01D38
	mov	ax, 7	;@01D39
	push	ax	;@01D3C
	db	0E8h, 61h, 9Eh	; call FATAL	;@01D3D
P1_GRPDEF:	mov	byte ptr ds:[160h], 1	;@01D40
	sub	bx, bx	;@01D45
	add	bl, byte ptr [si]	;@01D47
	jge	@@1	;@01D49
	inc	si	;@01D4B
	sub	bl, 80h	;@01D4C
	mov	bh, bl	;@01D4F
	mov	bl, byte ptr [si]	;@01D51
@@1:	inc	si	;@01D53
	dec	bx	;@01D54
	shl	bx, 1	;@01D55
	mov	es, word ptr ds:[790h]	;@01D57
	mov	dx, word ptr es:[bx]	;@01D5B
	mov	di, 4	;@01D5E
	push	di	;@01D61
	mov	di, 794h	;@01D62
	call	POOL_ALLOC	;@01D65
	jae	@@2	;@01D68
	call	L054B0	;@01D6A
@@2:	mov	word ptr es:[di], dx	;@01D6D
	mov	cx, 0FFFFh	;@01D70
	jmp	short @@6	;@01D73
@@3:	lodsb	;@01D75
	cmp	al, 0FFh	;@01D76
	jne	@@7	;@01D78
	sub	bx, bx	;@01D7A
	add	bl, byte ptr [si]	;@01D7C
	jge	@@4	;@01D7E
	inc	si	;@01D80
	sub	bl, 80h	;@01D81
	mov	bh, bl	;@01D84
	mov	bl, byte ptr [si]	;@01D86
@@4:	inc	si	;@01D88
	dec	byte ptr ds:[160h]	;@01D89
	jne	@@5	;@01D8D
	cmp	bx, word ptr ds:[164h]	;@01D8F
	jbe	@@5	;@01D93
	mov	word ptr ds:[164h], bx	;@01D95
@@5:	call	L01CFE	;@01D99
@@6:	cmp	si, word ptr ds:[3E0h]	;@01D9C
	jb	@@3	;@01DA0
	mov	es, word ptr ds:[798h]	;@01DA2
	mov	word ptr es:[di+2], cx	;@01DA6
	db	0E9h, 24h, 3Ah	; jmp L057D1	;@01DAA
@@7:	xor	bx, bx	;@01DAD
	jmp	@@5	;@01DAF
L01DB1:	push	cx	;@01DB1
	push	dx	;@01DB2
	push	si	;@01DB3
	push	di	;@01DB4
	mov	si, 0A50h	;@01DB5
	add	di, si	;@01DB8
@@1:	call	@@2	;@01DBA
	jae	@@1	;@01DBD
	pop	di	;@01DBF
	pop	si	;@01DC0
	pop	dx	;@01DC1
	pop	cx	;@01DC2
	ret	;@01DC3
@@2:	lodsw	;@01DC4
	push	ax	;@01DC5
	xor	ax, ax	;@01DC6
	cmp	word ptr ds:[3ECh], 0	;@01DC8
	je	@@3	;@01DCD
	lodsw	;@01DCF
@@3:	push	ax	;@01DD0
	lodsw	;@01DD1
	mov	cx, ax	;@01DD2
	jcxz	@@5	;@01DD4
@@4:	push	cx	;@01DD6
	call	@@2	;@01DD7
	pop	cx	;@01DDA
	jb	@@6	;@01DDB
	loop	@@4	;@01DDD
	jmp	short @@7	;@01DDF
@@5:	lodsb	;@01DE1
	sub	ah, ah	;@01DE2
	add	si, ax	;@01DE4
	cmp	si, di	;@01DE6
	jb	@@7	;@01DE8
	mov	ax, 1	;@01DEA
@@6:	pop	dx	;@01DED
	and	dx, dx	;@01DEE
	jne	L01DFF	;@01DF0
	pop	dx	;@01DF2
	mul	dx	;@01DF3
	and	dx, dx	;@01DF5
	jne	L01DFF	;@01DF7
	stc	;@01DF9
	ret	;@01DFA
@@7:	pop	dx	;@01DFB
	pop	dx	;@01DFC
	clc	;@01DFD
	ret	;@01DFE
L01DFF:	xor	ax, ax	;@01DFF
	push	ax	;@01E01
	mov	ax, 1Ch	;@01E02
	push	ax	;@01E05
	db	0E8h, 98h, 9Dh	; call FATAL	;@01E06
	cmp	byte ptr ds:[19h], 0	;@01E09
	je	@@1	;@01E0E
	jmp	FIXUPP_THREADS	;@01E10
@@1:	mov	ax, word ptr ds:[3ECh]	;@01E13
	shl	ax, 1	;@01E16
	mov	word ptr ds:[16Ah], ax	;@01E18
	xor	cx, cx	;@01E1B
	jmp	short @@11	;@01E1D
@@2:	and	al, 7	;@01E1F
	jmp	short @@4	;@01E21
@@3:	lodsb	;@01E23
	test	al, 80h	;@01E24
	jne	@@6	;@01E26
	shr	al, 1	;@01E28
	shr	al, 1	;@01E2A
	test	al, 10h	;@01E2C
	jne	@@2	;@01E2E
	and	al, 3	;@01E30
@@4:	cmp	al, 3	;@01E32
	je	@@5	;@01E34
	ja	@@11	;@01E36
	cmp	byte ptr [si], 80h	;@01E38
	sbb	si, -2	;@01E3B
	jmp	short @@11	;@01E3E
@@5:	add	si, 2	;@01E40
	jmp	short @@11	;@01E43
@@6:	mov	ah, al	;@01E45
	lodsb	;@01E47
	mov	di, ax	;@01E48
	and	ah, 1Ch	;@01E4A
	cmp	ah, 18h	;@01E4D
	ja	@@7	;@01E50
	and	ah, 18h	;@01E52
	cmp	ah, 8	;@01E55
	jne	@@8	;@01E58
@@7:	inc	cx	;@01E5A
	cmp	byte ptr ds:[3F1h], 1	;@01E5B
	jne	@@8	;@01E60
	and	di, 3Fh	;@01E62
	call	L01DB1	;@01E65
	dec	ax	;@01E68
	add	cx, ax	;@01E69
	jae	@@8	;@01E6B
	jmp	L01DFF	;@01E6D
@@8:	lodsb	;@01E6F
	test	al, 80h	;@01E70
	jne	@@9	;@01E72
	cmp	al, 30h	;@01E74
	jae	@@17	;@01E76
	cmp	byte ptr [si], 80h	;@01E78
	sbb	si, -2	;@01E7B
@@9:	not	al	;@01E7E
	test	al, 8	;@01E80
	je	@@10	;@01E82
	test	al, 3	;@01E84
	je	@@16	;@01E86
	cmp	byte ptr [si], 80h	;@01E88
	sbb	si, -2	;@01E8B
@@10:	test	al, 4	;@01E8E
	je	@@11	;@01E90
	add	si, 2	;@01E92
	add	si, word ptr ds:[16Ah]	;@01E95
@@11:	cmp	si, word ptr ds:[3E0h]	;@01E99
	jae	@@12	;@01E9D
	jmp	@@3	;@01E9F
@@12:	mov	bx, word ptr ds:[168h]	;@01EA1
	cmp	bx, -1	;@01EA5
	je	@@14	;@01EA8
	mov	es, word ptr ds:[780h]	;@01EAA
	add	word ptr es:[bx+6], cx	;@01EAE
	mov	es, word ptr ds:[778h]	;@01EB2
	mov	ax, word ptr es:[bx+2]	;@01EB6
	cmp	ax, word ptr ds:[44Eh]	;@01EBA
	je	@@13	;@01EBE
	cmp	ax, word ptr ds:[450h]	;@01EC0
	je	@@13	;@01EC4
	add	word ptr ds:[538h], cx	;@01EC6
@@13:	db	0E9h, 4, 39h	; jmp L057D1	;@01ECA
@@14:	mov	bx, word ptr ds:[162h]	;@01ECD
	cmp	bx, -1	;@01ED1
	je	@@15	;@01ED4
	mov	es, word ptr ds:[7A8h]	;@01ED6
	add	word ptr es:[bx+0Ah], cx	;@01EDA
@@15:	db	0E9h, 0F0h, 38h	; jmp L057D1	;@01EDE
@@16:	add	si, 2	;@01EE1
	add	si, word ptr ds:[16Ah]	;@01EE4
	jmp	@@10	;@01EE8
@@17:	cmp	al, 40h	;@01EEA
	jae	@@9	;@01EEC
	add	si, 2	;@01EEE
	add	si, word ptr ds:[16Ah]	;@01EF1
	jmp	@@9	;@01EF5
DECODE_START:	push	ax	;@01EF7
	lodsb	;@01EF8
	mov	ah, al	;@01EF9
	and	al, 0F0h	;@01EFB
	js	@@2	;@01EFD
	cmp	al, 30h	;@01EFF
	jae	@@1	;@01F01
	cmp	byte ptr [si], 80h	;@01F03
	sbb	si, -2	;@01F06
	jmp	short @@2	;@01F09
@@1:	ja	@@2	;@01F0B
	add	si, 2	;@01F0D
@@2:	test	ah, 8	;@01F10
	jne	@@3	;@01F13
	test	ah, 4	;@01F15
	jne	@@7	;@01F18
	and	ah, 3	;@01F1A
	cmp	ah, 3	;@01F1D
	je	@@5	;@01F20
	cmp	byte ptr [si], 80h	;@01F22
	sbb	si, -2	;@01F25
	mov	cx, word ptr [si]	;@01F28
	add	si, 2	;@01F2A
	cmp	word ptr ds:[41Eh], 0	;@01F2D
	je	@@8	;@01F32
	add	si, 2	;@01F34
	jmp	short @@8	;@01F37
@@3:	test	ah, 4	;@01F39
	jne	@@4	;@01F3C
	mov	cx, word ptr [si]	;@01F3E
	add	si, 2	;@01F40
	cmp	word ptr ds:[41Eh], 0	;@01F43
	je	@@4	;@01F48
	add	si, 2	;@01F4A
@@4:	jmp	short @@8	;@01F4D
@@5:	add	si, 2	;@01F4F
	mov	cx, word ptr [si]	;@01F52
	add	si, 2	;@01F54
	jmp	short @@8	;@01F57
@@6:	add	si, 2	;@01F59
	jmp	short @@8	;@01F5C
@@7:	and	ah, 3	;@01F5E
	cmp	ah, 3	;@01F61
	je	@@6	;@01F64
	cmp	byte ptr [si], 80h	;@01F66
	sbb	si, -2	;@01F69
@@8:	pop	ax	;@01F6C
	ret	;@01F6D
READ_FIXDAT:	push	bp	;@01F6E
	mov	bp, sp	;@01F6F
	sub	sp, 4	;@01F71
	push	dx	;@01F74
	xor	ax, ax	;@01F75
	mov	word ptr [bp-2], ax	;@01F77
	mov	word ptr [bp-4], ax	;@01F7A
	lodsb	;@01F7D
	mov	ah, al	;@01F7E
	and	al, 0F0h	;@01F80
	js	@@2	;@01F82
	cmp	al, 30h	;@01F84
	jae	@@1	;@01F86
	cmp	byte ptr [si], 80h	;@01F88
	sbb	si, -2	;@01F8B
	jmp	short @@2	;@01F8E
@@1:	ja	@@2	;@01F90
	add	si, 2	;@01F92
@@2:	test	ah, 8	;@01F95
	jne	@@4	;@01F98
	test	ah, 4	;@01F9A
	jne	@@8	;@01F9D
	and	ah, 3	;@01F9F
	cmp	ah, 3	;@01FA2
	je	@@6	;@01FA5
	sub	bx, bx	;@01FA7
	add	bl, byte ptr [si]	;@01FA9
	jge	@@3	;@01FAB
	inc	si	;@01FAD
	sub	bl, 80h	;@01FAE
	mov	bh, bl	;@01FB1
	mov	bl, byte ptr [si]	;@01FB3
@@3:	inc	si	;@01FB5
	mov	dx, word ptr [si]	;@01FB6
	mov	word ptr [bp-2], dx	;@01FB8
	add	si, 2	;@01FBB
	cmp	word ptr ds:[41Eh], 0	;@01FBE
	je	@@10	;@01FC3
	mov	dx, word ptr [si]	;@01FC5
	mov	word ptr [bp-4], dx	;@01FC7
	add	si, 2	;@01FCA
	jmp	short @@10	;@01FCD
@@4:	test	ah, 4	;@01FCF
	jne	@@5	;@01FD2
	mov	dx, word ptr [si]	;@01FD4
	mov	word ptr [bp-2], dx	;@01FD6
	add	si, 2	;@01FD9
	cmp	word ptr ds:[41Eh], 0	;@01FDC
	je	@@5	;@01FE1
	mov	dx, word ptr [si]	;@01FE3
	mov	word ptr [bp-4], dx	;@01FE5
	add	si, 2	;@01FE8
@@5:	mov	bl, ah	;@01FEB
	and	bx, 3	;@01FED
	mov	ah, byte ptr [bx+232h]	;@01FF0
	shl	bx, 1	;@01FF4
	mov	bx, word ptr [bx+236h]	;@01FF6
	jmp	short @@10	;@01FFA
@@6:	mov	bx, word ptr [si]	;@01FFC
	add	si, 4	;@01FFE
	jmp	short @@10	;@02001
@@7:	mov	bx, word ptr [si]	;@02003
	add	si, 2	;@02005
	jmp	short @@10	;@02008
@@8:	and	ah, 3	;@0200A
	cmp	ah, 3	;@0200D
	je	@@7	;@02010
	sub	bx, bx	;@02012
	add	bl, byte ptr [si]	;@02014
	jge	@@9	;@02016
	inc	si	;@02018
	sub	bl, 80h	;@02019
	mov	bh, bl	;@0201C
	mov	bl, byte ptr [si]	;@0201E
@@9:	inc	si	;@02020
@@10:	pop	dx	;@02021
	push	dx	;@02022
	and	dh, 1Ch	;@02023
	cmp	dh, 4	;@02026
	je	@@12	;@02029
	cmp	dh, 8	;@0202B
	jne	@@11	;@0202E
	db	0E9h, 7Eh, 0	; jmp near ptr @@19	;@02030
@@11:	cmp	dh, 0Ch	;@02033
	je	@@19	;@02036
	cmp	dh, 14h	;@02038
	je	@@19	;@0203B
	jmp	short @@20	;@0203D
@@12:	cmp	ah, 2	;@0203F
	jne	@@20	;@02042
	dec	bx	;@02044
	shl	bx, 1	;@02045
	add	bx, word ptr ds:[52Eh]	;@02047
	mov	es, word ptr ds:[788h]	;@0204B
	mov	bx, word ptr es:[bx]	;@0204F
	push	bx	;@02052
	and	bx, 3	;@02053
	shl	bx, 1	;@02056
	shl	bx, 1	;@02058
	shl	bx, 1	;@0205A
	mov	es, word ptr [bx+758h]	;@0205C
	pop	bx	;@02060
	push	ax	;@02061
	push	bx	;@02062
	push	si	;@02063
	mov	ax, word ptr es:[bx+0Ch]	;@02064
	mov	si, 460h	;@02068
	mov	bx, 9	;@0206B
@@13:	cmp	ax, word ptr [si]	;@0206E
	je	@@18	;@02070
	add	si, 2	;@02072
	dec	bx	;@02075
	jne	@@13	;@02076
@@14:	pop	si	;@02078
	pop	bx	;@02079
	pop	ax	;@0207A
	mov	ax, word ptr ds:[168h]	;@0207B
	cmp	ax, 0FFFFh	;@0207E
	jne	@@15	;@02081
	mov	ax, word ptr ds:[162h]	;@02083
	or	ax, 1	;@02086
@@15:	push	bx	;@02089
	mov	bx, word ptr ds:[812h]	;@0208A
	les	di, dword ptr [bx+2]	;@0208E
	add	di, 4	;@02091
	cmp	di, word ptr [bx]	;@02094
	jbe	@@16	;@02096
	call	L054E9	;@02098
	pop	bx	;@0209B
	jae	@@17	;@0209C
	call	L054B0	;@0209E
@@16:	xchg	word ptr [bx+2], di	;@020A1
	pop	bx	;@020A4
@@17:	mov	word ptr es:[di], ax	;@020A5
	mov	word ptr es:[di+2], bx	;@020A8
	jmp	short @@20	;@020AC
@@18:	inc	cx	;@020AE
	jmp	@@14	;@020AF
@@19:	inc	cx	;@020B1
@@20:	pop	dx	;@020B2
	mov	sp, bp	;@020B3
	pop	bp	;@020B5
	ret	;@020B6
FIXUPP_THREADS:	mov	ax, word ptr ds:[3ECh]	;@020B7
	shl	ax, 1	;@020BA
	mov	word ptr ds:[16Ah], ax	;@020BC
	xor	cx, cx	;@020BF
	jmp	@@8	;@020C1
@@1:	cbw	;@020C4
	mov	di, ax	;@020C5
	and	di, 3	;@020C7
	test	al, 40h	;@020CA
	jne	@@4	;@020CC
	shr	al, 1	;@020CE
	shr	al, 1	;@020D0
	and	al, 3	;@020D2
	mov	byte ptr [di+232h], al	;@020D4
	shl	di, 1	;@020D8
	cmp	al, 3	;@020DA
	je	@@3	;@020DC
	sub	bx, bx	;@020DE
	add	bl, byte ptr [si]	;@020E0
	jge	@@2	;@020E2
	inc	si	;@020E4
	sub	bl, 80h	;@020E5
	mov	bh, bl	;@020E8
	mov	bl, byte ptr [si]	;@020EA
@@2:	inc	si	;@020EC
	mov	word ptr [di+236h], bx	;@020ED
	jmp	short @@8	;@020F1
@@3:	mov	bx, word ptr [si]	;@020F3
	add	si, 2	;@020F5
	mov	word ptr [di+236h], bx	;@020F8
	jmp	short @@8	;@020FC
@@4:	shl	al, 1	;@020FE
	shl	al, 1	;@02100
	and	al, 7	;@02102
	mov	byte ptr [di+23Eh], al	;@02104
	shl	di, 1	;@02108
	cmp	al, 3	;@0210A
	je	@@6	;@0210C
	sub	bx, bx	;@0210E
	add	bl, byte ptr [si]	;@02110
	jge	@@5	;@02112
	inc	si	;@02114
	sub	bl, 80h	;@02115
	mov	bh, bl	;@02118
	mov	bl, byte ptr [si]	;@0211A
@@5:	inc	si	;@0211C
	mov	word ptr [di+242h], bx	;@0211D
	jmp	short @@8	;@02121
@@6:	mov	bx, word ptr [si]	;@02123
	add	si, 2	;@02125
	mov	word ptr [di+242h], bx	;@02128
	jmp	short @@8	;@0212C
@@7:	lodsb	;@0212E
	test	al, 80h	;@0212F
	je	@@1	;@02131
	mov	ah, al	;@02133
	lodsb	;@02135
	mov	dx, ax	;@02136
	call	READ_FIXDAT	;@02138
	cmp	byte ptr ds:[3F1h], 1	;@0213B
	jne	@@8	;@02140
	mov	di, dx	;@02142
	and	di, 3Fh	;@02144
	call	L01DB1	;@02147
	dec	ax	;@0214A
	add	cx, ax	;@0214B
	jae	@@8	;@0214D
	jmp	L01DFF	;@0214F
@@8:	cmp	si, word ptr ds:[3E0h]	;@02152
	jae	@@9	;@02156
	jmp	@@7	;@02158
@@9:	mov	bx, word ptr ds:[168h]	;@0215A
	cmp	bx, -1	;@0215E
	je	@@11	;@02161
	mov	es, word ptr ds:[780h]	;@02163
	add	word ptr es:[bx+6], cx	;@02167
	mov	es, word ptr ds:[778h]	;@0216B
	mov	ax, word ptr es:[bx+2]	;@0216F
	cmp	ax, word ptr ds:[44Eh]	;@02173
	je	@@10	;@02177
	cmp	ax, word ptr ds:[450h]	;@02179
	je	@@10	;@0217D
	add	word ptr ds:[538h], cx	;@0217F
@@10:	db	0E9h, 4Bh, 36h	; jmp L057D1	;@02183
@@11:	mov	bx, word ptr ds:[162h]	;@02186
	cmp	bx, -1	;@0218A
	je	@@12	;@0218D
	mov	es, word ptr ds:[7A8h]	;@0218F
	add	word ptr es:[bx+0Ah], cx	;@02193
@@12:	db	0E9h, 37h, 36h	; jmp L057D1	;@02197
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah	;@0219A
	db	1Ch, 46h, 81h, 0FBh, 0, 40h, 7Fh, 17h, 4Bh, 93h, 0B4h, 0Ah, 0F6h
	db	0E4h, 93h, 3, 1Eh, 2Ch, 5, 89h, 1Eh, 68h, 1, 0C6h, 6, 0F1h, 3
	db	0, 0E9h, 0Bh, 36h, 0E8h, 0E3h, 6Eh, 72h, 12h, 0C7h, 6, 68h, 1
	db	0FFh, 0FFh, 89h, 1Eh, 62h, 1, 0C6h, 6, 0F1h, 3, 0, 0E9h, 0F4h
	db	35h, 83h, 0FBh, 0FFh, 74h, 5, 0BBh, 0FFh, 0FFh, 0EBh, 0EAh, 0E8h
	db	0B3h, 64h, 0C6h, 6, 0F1h, 3, 1, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h
	db	80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 4Bh, 93h, 0B4h, 0Ah
	db	0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 89h, 1Eh, 68h, 1, 8Eh, 6, 78h
	db	7, 26h, 0F6h, 47h, 9, 0E0h, 74h, 27h, 89h, 1Eh, 0E6h, 3, 0ADh
	db	83h, 3Eh, 1Eh, 4, 0, 74h, 1, 0ADh, 8Bh, 0Eh, 0E0h, 3, 2Bh, 0CEh
	db	89h, 0Eh, 0E4h, 3, 1Eh, 7, 0BFh, 50h, 0Ah, 0D1h, 0E9h, 0F3h, 0A5h
	db	0D1h, 0D1h, 0F3h, 0A4h, 0E9h, 92h, 35h, 0C6h, 6, 0F1h, 3, 0FFh
	db	0EBh, 0F6h, 0A1h, 0E0h, 3, 2Bh, 0C6h, 5, 4, 0, 8Bh, 3Eh, 96h, 4
	db	89h, 45h, 6, 0A3h, 62h, 52h, 0ADh, 0A3h, 64h, 52h, 89h, 45h, 2
	db	92h, 0ADh, 0A3h, 66h, 52h, 89h, 45h, 4, 91h, 0C6h, 6, 61h, 1, 1
	db	0C6h, 6, 0D2h, 3, 2, 80h, 3Eh, 0D5h, 3, 1, 74h, 0Bh, 80h, 3Eh
	db	0D5h, 3, 4, 74h, 4, 0FEh, 0Eh, 0D2h, 3, 80h, 3Eh, 54h, 2, 0, 75h
	db	6, 0E8h, 0A8h, 21h, 72h, 1, 0C3h, 0E9h, 3Dh, 35h
CHECK_CONFLICT_1:	push	bp	;@02294
	mov	bp, sp	;@02295
	sub	sp, 0Ah	;@02297
	or	al, 8	;@0229A
	mov	byte ptr [bp-2], al	;@0229C
	jmp	short @@2	;@0229F
@@1:	mov	sp, bp	;@022A1
	pop	bp	;@022A3
	db	0E9h, 2Ah, 35h	; jmp L057D1	;@022A4
@@2:	cmp	si, word ptr ds:[3E0h]	;@022A7
	jae	@@1	;@022AB
	test	byte ptr [bp-2], 4	;@022AD
	je	@@3	;@022B1
	call	QUALIFY_LOCAL_NAME	;@022B3
@@3:	mov	ah, 0	;@022B6
	db	0E8h, 5Bh, 6Bh	; call L08E16	;@022B8
	push	bx	;@022BB
	cmp	byte ptr [si], 80h	;@022BC
	sbb	si, -2	;@022BF
	lodsb	;@022C2
	mov	ah, 0	;@022C3
	cmp	al, 60h	;@022C5
	ja	@@4	;@022C7
	dec	ax	;@022C9
	nop	;@022CA
	mov	ah, 0Ah	;@022CB
	mul	ah	;@022CD
	nop	;@022CF
	add	ax, word ptr ds:[52Ch]	;@022D0
	jmp	short @@5	;@022D4
@@4:	sub	ax, 63h	;@022D6
@@5:	mov	word ptr [bp-6], ax	;@022D9
	push	bx	;@022DC
	xor	ax, ax	;@022DD
	mov	dx, ax	;@022DF
	lodsb	;@022E1
	mov	bx, ax	;@022E2
	cmp	bl, 81h	;@022E4
	jb	@@8	;@022E7
	lodsw	;@022E9
	cmp	bl, 81h	;@022EA
	je	@@8	;@022ED
	xchg	ax, dx	;@022EF
	cmp	bl, 84h	;@022F0
	jne	@@6	;@022F3
	lodsb	;@022F5
	jmp	short @@7	;@022F6
@@6:	lodsw	;@022F8
@@7:	xchg	ax, dx	;@022F9
@@8:	pop	bx	;@022FA
	cmp	word ptr [bp-6], -2	;@022FB
	jne	@@12	;@022FF
	push	dx	;@02301
	push	ax	;@02302
	push	bx	;@02303
	xor	ax, ax	;@02304
	mov	dx, ax	;@02306
	lodsb	;@02308
	mov	bx, ax	;@02309
	cmp	bl, 81h	;@0230B
	jb	@@11	;@0230E
	lodsw	;@02310
	cmp	bl, 81h	;@02311
	je	@@11	;@02314
	xchg	ax, dx	;@02316
	cmp	bl, 84h	;@02317
	jne	@@9	;@0231A
	lodsb	;@0231C
	jmp	short @@10	;@0231D
@@9:	lodsw	;@0231F
@@10:	xchg	ax, dx	;@02320
@@11:	pop	bx	;@02321
	pop	bx	;@02322
	pop	cx	;@02323
	db	9Ah, 5, 0, 2Fh, 0	; lcall 0x2f, 5	;@02324
@@12:	mov	word ptr [bp-8], ax	;@02329
	mov	word ptr [bp-0Ah], dx	;@0232C
	pop	bx	;@0232F
	cmp	word ptr es:[bx], -1	;@02330
	je	@@13	;@02334
	jmp	@@21	;@02336
@@13:	call	L017A8	;@02339
	mov	word ptr es:[di+0Ch], bx	;@0233C
@@14:	mov	word ptr ds:[176h], di	;@02340
	mov	ax, word ptr [bp-6]	;@02344
	mov	word ptr es:[di], ax	;@02347
	mov	ax, word ptr ds:[186h]	;@0234A
	mov	word ptr es:[di+2], ax	;@0234D
	mov	al, byte ptr [bp-2]	;@02351
	mov	byte ptr es:[di+0Eh], al	;@02354
@@15:	push	di	;@02358
	push	word ptr es:[di+0Ah]	;@02359
	les	di, dword ptr ds:[7A6h]	;@0235D
	add	di, 0Ch	;@02361
	cmp	di, word ptr ds:[7A4h]	;@02364
	jbe	@@16	;@02368
	mov	di, 0Ch	;@0236A
	push	di	;@0236D
	mov	di, 7A4h	;@0236E
	call	POOL_ALLOC	;@02371
	jae	@@17	;@02374
	call	L054B0	;@02376
@@16:	xchg	word ptr ds:[7A6h], di	;@02379
@@17:	push	di	;@0237D
	xor	ax, ax	;@0237E
	mov	cx, 0Ch	;@02380
	cld	;@02383
	rep stosb	;@02384
	pop	di	;@02386
	pop	word ptr es:[di]	;@02387
	mov	ax, word ptr ds:[186h]	;@0238A
	mov	word ptr es:[di+2], ax	;@0238D
	mov	ax, word ptr [bp-8]	;@02391
	mov	word ptr es:[di+6], ax	;@02394
	mov	ax, word ptr [bp-0Ah]	;@02398
	mov	word ptr es:[di+8], ax	;@0239B
	mov	ax, word ptr [bp-6]	;@0239F
	mov	word ptr es:[di+4], ax	;@023A2
	mov	ax, di	;@023A6
	pop	di	;@023A8
	push	di	;@023A9
	and	di, 3	;@023AA
	shl	di, 1	;@023AD
	shl	di, 1	;@023AF
	shl	di, 1	;@023B1
	mov	es, word ptr [di+758h]	;@023B3
	pop	di	;@023B7
	xchg	word ptr es:[di+0Ah], ax	;@023B8
	cmp	ax, 0FFFFh	;@023BC
	jne	@@18	;@023BF
	push	bx	;@023C1
	and	bx, 3	;@023C2
	shl	bx, 1	;@023C5
	shl	bx, 1	;@023C7
	shl	bx, 1	;@023C9
	mov	es, word ptr [bx+718h]	;@023CB
	pop	bx	;@023CF
	mov	word ptr es:[bx], di	;@023D0
@@18:	mov	ax, di	;@023D3
	les	di, dword ptr ds:[786h]	;@023D5
	add	di, 2	;@023D9
	cmp	di, word ptr ds:[784h]	;@023DC
	jbe	@@19	;@023E0
	mov	di, 2	;@023E2
	push	di	;@023E5
	mov	di, 784h	;@023E6
	call	POOL_ALLOC	;@023E9
	jae	@@20	;@023EC
	call	L054B0	;@023EE
@@19:	xchg	word ptr ds:[786h], di	;@023F1
@@20:	mov	word ptr ds:[188h], di	;@023F5
	mov	word ptr es:[di], ax	;@023F9
	mov	word ptr ds:[174h], bx	;@023FC
	jmp	@@2	;@02400
@@21:	mov	di, word ptr es:[bx]	;@02403
	push	di	;@02406
	and	di, 3	;@02407
	shl	di, 1	;@0240A
	shl	di, 1	;@0240C
	shl	di, 1	;@0240E
	mov	es, word ptr [di+758h]	;@02410
	pop	di	;@02414
	test	byte ptr es:[di+0Eh], 18h	;@02415
	je	@@18	;@0241A
	test	byte ptr es:[di+0Eh], 8	;@0241C
	jne	@@22	;@02421
	jmp	@@14	;@02423
@@22:	cmp	word ptr [bp-6], -2	;@02426
	jb	@@23	;@0242A
	cmp	word ptr es:[di], -2	;@0242C
	jb	@@24	;@02430
	jmp	@@15	;@02432
@@23:	cmp	word ptr es:[di], -2	;@02435
	jae	@@24	;@02439
	jmp	@@15	;@0243B
@@24:	push	si	;@0243E
	push	di	;@0243F
	mov	word ptr ds:[422h], 1	;@02440
	mov	di, word ptr es:[di+0Ah]	;@02446
	mov	es, word ptr ds:[7A8h]	;@0244A
	push	word ptr es:[di+2]	;@0244E
	mov	si, bx	;@02452
	mov	di, 28h	;@02454
	db	0E8h, 0E6h, 72h	; call COPY_NAME	;@02457
	pop	si	;@0245A
	push	si	;@0245B
	and	si, 3	;@0245C
	shl	si, 1	;@0245F
	shl	si, 1	;@02461
	shl	si, 1	;@02463
	mov	es, word ptr [si+738h]	;@02465
	pop	si	;@02469
	mov	si, word ptr es:[si]	;@0246A
	mov	di, 78h	;@0246D
	db	0E8h, 0CDh, 72h	; call COPY_NAME	;@02470
	mov	ds, word ptr cs:L00100+16	;@02473
	push	ds	;@02478
	mov	ax, 78h	;@02479
	push	ax	;@0247C
	push	ds	;@0247D
	mov	ax, 28h	;@0247E
	push	ax	;@02481
	mov	cx, 8	;@02482
	push	cx	;@02485
	mov	ax, 33h	;@02486
	push	ax	;@02489
	db	0E8h, 1Eh, 97h	; call WARNING	;@0248A
	pop	di	;@0248D
	pop	si	;@0248E
	jmp	@@2	;@0248F
P1_COMDEF:	sub	ax, ax	;@02492
	jmp	CHECK_CONFLICT_1	;@02494
P1_LCOMDEF:	mov	ax, 4	;@02497
	jmp	CHECK_CONFLICT_1	;@0249A
	db	0, 0, 0, '%s:%x', 0, '%s:%x%x', 0, 55h, 8Bh, 0ECh, 81h, 0ECh, 82h	;@0249D
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
	db	0E0h, 3, 80h, 0FBh, 8Ah, 75h, 0CAh, 0E9h, 28h, 16h
LOOKUP_NAME_SKIP:	push	di	;@0268B
	push	ds	;@0268C
	pop	es	;@0268D
	push	si	;@0268E
	call	NAME_LOOKUP_COPY	;@0268F
	pop	si	;@02692
	mov	bx, ax	;@02693
	lodsb	;@02695
	cbw	;@02696
	add	si, ax	;@02697
	mov	ax, bx	;@02699
	pop	di	;@0269B
	ret	;@0269C
L0269D:	mov	ah, 0	;@0269D
	db	0E8h, 74h, 67h	; call L08E16	;@0269F
	cmp	word ptr es:[bx], -1	;@026A2
	je	@@1	;@026A6
	push	bx	;@026A8
	and	bx, 3	;@026A9
	shl	bx, 1	;@026AC
	shl	bx, 1	;@026AE
	shl	bx, 1	;@026B0
	mov	es, word ptr [bx+718h]	;@026B2
	pop	bx	;@026B6
	mov	bx, word ptr es:[bx]	;@026B7
	push	bx	;@026BA
	and	bx, 3	;@026BB
	shl	bx, 1	;@026BE
	shl	bx, 1	;@026C0
	shl	bx, 1	;@026C2
	mov	es, word ptr [bx+758h]	;@026C4
	pop	bx	;@026C8
	mov	ax, word ptr es:[bx+12h]	;@026C9
	ret	;@026CD
@@1:	xor	ax, ax	;@026CE
	ret	;@026D0
	db	33h, 0D2h, 0EBh, 5Bh, 0FFh, 6, 0E6h, 4, 0BFh, 90h, 2, 0ACh, 88h	;@026D1
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
P2_COMENT_E3:	mov	di, 290h	;@0279F
	xor	ax, ax	;@027A2
	push	ds	;@027A4
	pop	es	;@027A5
	mov	cx, 4	;@027A6
	rep stosw	;@027A9
	sub	bx, bx	;@027AB
	add	bl, byte ptr [si]	;@027AD
	jge	@@1	;@027AF
	inc	si	;@027B1
	sub	bl, 80h	;@027B2
	mov	bh, bl	;@027B5
	mov	bl, byte ptr [si]	;@027B7
@@1:	inc	si	;@027B9
	push	bx	;@027BA
	lodsb	;@027BB
	cbw	;@027BC
	and	ax, ax	;@027BD
	je	@@2	;@027BF
	dec	si	;@027C1
	xor	ax, ax	;@027C2
	call	LOOKUP_NAME_SKIP	;@027C4
@@2:	mov	bx, 290h	;@027C7
	mov	word ptr [bx+1], ax	;@027CA
	lodsw	;@027CD
	mov	word ptr [bx+3], ax	;@027CE
	lodsb	;@027D1
	mov	byte ptr [bx], al	;@027D2
	mov	di, 2761h	;@027D4
	push	cs	;@027D7
	pop	es	;@027D8
	mov	cx, 14h	;@027D9
@@3:	scasb	;@027DC
	je	@@4	;@027DD
	scasw	;@027DF
	loop	@@3	;@027E0
@@4:	push	word ptr es:[di]	;@027E2
	push	ds	;@027E5
	pop	es	;@027E6
	lea	di, [bx+5]	;@027E7
	mov	cx, 8	;@027EA
	mov	dx, word ptr ds:[38Fh]	;@027ED
	ret	;@027F1
E3_TYPE_20_21:	movsw	;@027F2
	mov	cx, 10h	;@027F3
	jmp	short E3_TYPE_LIST	;@027F6
E3_TYPE_1B:	movsw	;@027F8
	mov	cx, 10h	;@027F9
	sub	bx, bx	;@027FC
	add	bl, byte ptr [si]	;@027FE
	jge	@@1	;@02800
	inc	si	;@02802
	sub	bl, 80h	;@02803
	mov	bh, bl	;@02806
	mov	bl, byte ptr [si]	;@02808
@@1:	inc	si	;@0280A
	mov	word ptr [di], bx	;@0280B
	cmp	bx, 18h	;@0280D
	jb	E3_WRITE_ENTRY	;@02810
	add	word ptr [di], dx	;@02812
	jmp	short E3_WRITE_ENTRY	;@02814
E3_TYPE_1E_1F:	inc	di	;@02816
E3_TYPE_LIST:	mov	ax, word ptr ds:[39Dh]	;@02817
	stosw	;@0281A
	jmp	short L02886	;@0281B
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah	;@0281D
	db	1Ch, 46h, 89h, 5Dh, 1, 83h, 0FBh, 18h, 72h, 59h, 1, 55h, 1, 0EBh
	db	54h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 46h, 53h, 0ADh, 0D0h, 0CCh, 80h, 0E4h, 80h, 0Ah, 0C4h
	db	0AAh, 0EBh, 11h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h
	db	8Ah, 0FBh, 8Ah, 1Ch, 46h, 53h, 0A4h
E3_STORE_INDEX:	pop	ax	;@02865
	stosw	;@02866
	cmp	ax, 18h	;@02867
	jb	E3_WRITE_ENTRY	;@0286A
	add	word ptr [di-2], dx	;@0286C
	jmp	short E3_WRITE_ENTRY	;@0286F
E3_TYPE_24:	movsb	;@02871
	jmp	short E3_WRITE_ENTRY	;@02872
E3_TYPE_22:	cmp	byte ptr [si], 80h	;@02874
	sbb	si, -2	;@02877
	mov	cx, 10h	;@0287A
	add	di, 3	;@0287D
	movsw	;@02880
	movsw	;@02881
	mov	ax, word ptr ds:[39Dh]	;@02882
	stosw	;@02885
L02886:	mov	ax, word ptr ds:[4E6h]	;@02886
	inc	ax	;@02889
	mov	word ptr ds:[39Dh], ax	;@0288A
E3_WRITE_ENTRY:	pop	ax	;@0288D
E3_WRITE_AX:	sub	ax, 18h	;@0288E
	mov	di, cx	;@02891
	push	cx	;@02893
	mov	cl, 3	;@02894
	shl	ax, cl	;@02896
	shr	di, cl	;@02898
	add	word ptr ds:[4E4h], di	;@0289A
	pop	cx	;@0289E
	push	si	;@0289F
	mov	si, 290h	;@028A0
	mov	dx, word ptr ds:[323h]	;@028A3
	add	ax, word ptr ds:[321h]	;@028A7
	adc	dx, 0	;@028AB
	mov	bx, 47Eh	;@028AE
	db	0E8h, 51h, 60h	; call L08905	;@028B1
	pop	si	;@028B4
	ret	;@028B5
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah	;@028B6
	db	1Ch, 'FS2', 0C0h, 0AAh, 57h, 52h, 6, 33h, 0C0h, 0E8h, 0BAh, 0FDh
	db	7, 5Ah, 5Fh, 89h, 45h, 2, 0B9h, 10h, 0, 0EBh, 89h
E3_TYPE_2E:	mov	ax, word ptr [bx+1]	;@028DC
	mov	word ptr ds:[3A5h], ax	;@028DF
	sub	bx, bx	;@028E2
	add	bl, byte ptr [si]	;@028E4
	jge	@@1	;@028E6
	inc	si	;@028E8
	sub	bl, 80h	;@028E9
	mov	bh, bl	;@028EC
	mov	bl, byte ptr [si]	;@028EE
@@1:	inc	si	;@028F0
	add	bx, word ptr ds:[3A1h]	;@028F1
	mov	word ptr ds:[3A3h], bx	;@028F5
	mov	word ptr [di+1], bx	;@028F9
	pop	ax	;@028FC
	mov	word ptr ds:[22Ch], ax	;@028FD
	jmp	E3_WRITE_AX	;@02900
E3_TYPE_2D:	lodsb	;@02902
	cbw	;@02903
	and	al, al	;@02904
	jns	@@1	;@02906
	sub	al, 80h	;@02908
	mov	ah, al	;@0290A
	lodsb	;@0290C
@@1:	movsb	;@0290D
	cmp	ax, 18h	;@0290E
	jb	@@2	;@02911
	add	ax, dx	;@02913
@@2:	stosw	;@02915
	lodsb	;@02916
	mov	cl, al	;@02917
	test	al, 1	;@02919
	je	@@7	;@0291B
	lodsb	;@0291D
	cbw	;@0291E
	and	al, al	;@0291F
	jns	@@3	;@02921
	sub	al, 80h	;@02923
	mov	ah, al	;@02925
	lodsb	;@02927
@@3:	add	ax, dx	;@02928
	stosw	;@0292A
	lodsb	;@0292B
	cbw	;@0292C
	and	al, al	;@0292D
	jns	@@4	;@0292F
	sub	al, 80h	;@02931
	mov	ah, al	;@02933
	lodsb	;@02935
@@4:	shl	ax, 1	;@02936
	stosw	;@02938
	xor	ax, ax	;@02939
	test	cl, 8	;@0293B
	jne	@@5	;@0293E
	push	di	;@02940
	push	cx	;@02941
	call	L0269D	;@02942
	pop	cx	;@02945
	pop	di	;@02946
	push	ds	;@02947
	pop	es	;@02948
@@5:	stosw	;@02949
@@6:	xor	ax, ax	;@0294A
	mov	ah, cl	;@0294C
	mov	cl, 4	;@0294E
	shl	ah, cl	;@02950
	stosw	;@02952
	mov	cx, 10h	;@02953
	jmp	E3_WRITE_ENTRY	;@02956
@@7:	add	di, 6	;@02959
	jmp	@@6	;@0295C
E3_TYPE_33:	inc	di	;@0295E
	lodsb	;@0295F
	cbw	;@02960
	and	al, al	;@02961
	jns	@@1	;@02963
	sub	al, 80h	;@02965
	mov	ah, al	;@02967
	lodsb	;@02969
@@1:	cmp	ax, 18h	;@0296A
	jb	@@2	;@0296D
	add	ax, dx	;@0296F
@@2:	stosw	;@02971
	lodsb	;@02972
	cbw	;@02973
	and	al, al	;@02974
	jns	@@3	;@02976
	sub	al, 80h	;@02978
	mov	ah, al	;@0297A
	lodsb	;@0297C
@@3:	add	ax, word ptr ds:[3A1h]	;@0297D
	stosw	;@02981
	mov	cx, 10h	;@02982
	jmp	E3_WRITE_ENTRY	;@02985
COMPARE_DEBUG_ENTRIES:	push	ax	;@02988
	push	es	;@02989
	mov	es, word ptr ds:[37Dh]	;@0298A
	mov	al, byte ptr es:[si+8]	;@0298E
	mov	ah, byte ptr es:[di+8]	;@02992
	and	ax, 303h	;@02996
L02999:	cmp	ah, al	;@02999
	jne	@@1	;@0299B
	mov	ax, word ptr es:[si+6]	;@0299D
	cmp	ax, word ptr es:[di+6]	;@029A1
	jne	@@1	;@029A5
	mov	ax, word ptr es:[si+4]	;@029A7
	cmp	ax, word ptr es:[di+4]	;@029AB
@@1:	pop	es	;@029AF
	pop	ax	;@029B0
	ret	;@029B1
SORT_DEBUG_ENTRIES:	push	bp	;@029B2
	mov	cx, word ptr ds:[367h]	;@029B3
	jcxz	@@3	;@029B7
	cmp	cx, 1	;@029B9
	je	@@1	;@029BC
	shl	cx, 1	;@029BE
	mov	bp, 2988h	;@029C0
	mov	es, word ptr ds:[381h]	;@029C3
	db	0E8h, 93h, 65h	; call SORT	;@029C7
@@1:	mov	cx, word ptr ds:[367h]	;@029CA
	xor	bx, bx	;@029CE
@@2:	mov	es, word ptr ds:[381h]	;@029D0
	mov	si, word ptr es:[bx]	;@029D4
	push	bx	;@029D7
	push	cx	;@029D8
	mov	bp, 37Dh	;@029D9
	mov	cx, 9	;@029DC
	mov	bx, 309h	;@029DF
	call	WRITE_AT	;@029E2
	pop	cx	;@029E5
	pop	bx	;@029E6
	inc	bx	;@029E7
	inc	bx	;@029E8
	loop	@@2	;@029E9
	xor	ax, ax	;@029EB
	mov	word ptr ds:[389h], ax	;@029ED
	mov	word ptr ds:[367h], ax	;@029F0
	mov	word ptr ds:[38Bh], ax	;@029F3
@@3:	cmp	word ptr ds:[178h], 0	;@029F6
	je	@@4	;@029FB
	cmp	word ptr ds:[3A8h], 0	;@029FD
	je	@@4	;@02A02
	mov	di, word ptr ds:[383h]	;@02A04
	sub	di, 16h	;@02A08
	mov	es, word ptr ds:[36Dh]	;@02A0B
	cmp	word ptr es:[di+14h], -1	;@02A0F
	jne	@@4	;@02A14
	mov	ax, word ptr ds:[50Ah]	;@02A16
	inc	ax	;@02A19
	sub	ax, word ptr es:[di+12h]	;@02A1A
	mov	word ptr es:[di+14h], ax	;@02A1E
@@4:	pop	bp	;@02A22
	ret	;@02A23
L02A24:	mov	es, word ptr ds:[780h]	;@02A24
	mov	cx, word ptr es:[bx+6]	;@02A28
	mov	al, byte ptr es:[bx+9]	;@02A2C
	and	ax, 0FFh	;@02A30
	je	@@2	;@02A33
	mov	es, word ptr ds:[778h]	;@02A35
	mov	bx, word ptr es:[bx+4]	;@02A39
	push	bx	;@02A3D
	and	bx, 3	;@02A3E
	shl	bx, 1	;@02A41
	shl	bx, 1	;@02A43
	shl	bx, 1	;@02A45
	mov	es, word ptr [bx+738h]	;@02A47
	pop	bx	;@02A4B
	mov	bx, word ptr es:[bx+16h]	;@02A4C
	dec	ax	;@02A50
	push	ax	;@02A51
	mov	ah, 10h	;@02A52
	mul	ah	;@02A54
	xchg	ax, si	;@02A56
	pop	ax	;@02A57
	mov	es, word ptr ds:[371h]	;@02A58
@@1:	cmp	bx, word ptr es:[si]	;@02A5C
	je	@@3	;@02A5F
	add	ax, 0FFh	;@02A61
	add	si, 0FF0h	;@02A64
	cmp	si, word ptr ds:[399h]	;@02A68
	jb	@@1	;@02A6C
@@2:	db	0E8h, 2Ch, 5Ch	; call L0869D	;@02A6E
@@3:	mov	word ptr ds:[397h], cx	;@02A71
	inc	ax	;@02A75
	mov	word ptr ds:[395h], si	;@02A76
	ret	;@02A7A
P2_COMENT_E5:	push	bp	;@02A7B
	mov	bp, sp	;@02A7C
	sub	sp, 8	;@02A7E
	push	si	;@02A81
	call	SORT_DEBUG_ENTRIES	;@02A82
	pop	si	;@02A85
	sub	bx, bx	;@02A86
	add	bl, byte ptr [si]	;@02A88
	jge	@@1	;@02A8A
	inc	si	;@02A8C
	sub	bl, 80h	;@02A8D
	mov	bh, bl	;@02A90
	mov	bl, byte ptr [si]	;@02A92
@@1:	inc	si	;@02A94
	cmp	bx, 4000h	;@02A95
	jle	@@2	;@02A99
	jmp	@@10	;@02A9B
@@2:	mov	byte ptr [bp-8], 0	;@02A9E
	xor	ax, ax	;@02AA2
@@3:	mov	word ptr [bp-2], bx	;@02AA4
	mov	word ptr [bp-4], ax	;@02AA7
	mov	di, word ptr ds:[383h]	;@02AAA
	add	word ptr ds:[383h], 16h	;@02AAE
	mov	bx, di	;@02AB3
	mov	es, word ptr ds:[36Dh]	;@02AB5
	mov	cx, 0Bh	;@02AB9
	xor	ax, ax	;@02ABC
	rep stosw	;@02ABE
	cmp	word ptr ds:[178h], 0	;@02AC0
	je	@@4	;@02AC5
	mov	ax, word ptr es:[bx-6]	;@02AC7
	mov	word ptr es:[bx+4], ax	;@02ACB
@@4:	mov	word ptr [bp-6], bx	;@02ACF
	inc	word ptr ds:[4F0h]	;@02AD2
	mov	ax, word ptr ds:[4F0h]	;@02AD6
	mov	word ptr es:[bx+10h], ax	;@02AD9
	mov	ax, word ptr ds:[319h]	;@02ADD
	mov	word ptr es:[bx+0Ch], ax	;@02AE0
	mov	ax, word ptr ds:[31Bh]	;@02AE4
	mov	word ptr es:[bx+0Eh], ax	;@02AE7
	mov	ax, word ptr ds:[50Ah]	;@02AEB
	inc	ax	;@02AEE
	mov	word ptr es:[bx+12h], ax	;@02AEF
	mov	word ptr es:[bx+14h], 0FFFFh	;@02AF3
	add	word ptr ds:[319h], 0Ch	;@02AF9
	adc	word ptr ds:[31Bh], 0	;@02AFE
	mov	bx, word ptr [bp-2]	;@02B03
	push	si	;@02B06
	push	es	;@02B07
	cmp	byte ptr [bp-8], 0	;@02B08
	je	@@5	;@02B0C
	mov	word ptr ds:[393h], 0FFFFh	;@02B0E
	jmp	short @@6	;@02B14
@@5:	cmp	bx, word ptr ds:[393h]	;@02B16
	je	@@7	;@02B1A
	mov	word ptr ds:[393h], bx	;@02B1C
	dec	bx	;@02B20
	xchg	ax, bx	;@02B21
	mov	ah, 0Ah	;@02B22
	mul	ah	;@02B24
	xchg	ax, bx	;@02B26
	add	bx, word ptr ds:[52Ch]	;@02B27
@@6:	call	L02A24	;@02B2B
	mov	ax, word ptr [bp-4]	;@02B2E
	and	ax, ax	;@02B31
	je	@@7	;@02B33
	mov	word ptr ds:[397h], ax	;@02B35
@@7:	mov	si, word ptr ds:[395h]	;@02B38
	mov	es, word ptr ds:[371h]	;@02B3C
	cmp	word ptr es:[si+0Ah], 0	;@02B40
	jne	@@8	;@02B45
	mov	ax, word ptr ds:[4F0h]	;@02B47
	mov	word ptr es:[si+8], ax	;@02B4A
@@8:	inc	word ptr es:[si+0Ah]	;@02B4E
	pop	es	;@02B52
	pop	si	;@02B53
	lodsw	;@02B54
	mov	bx, word ptr [bp-6]	;@02B55
	mov	word ptr es:[bx+8], ax	;@02B58
	inc	word ptr ds:[178h]	;@02B5C
	mov	word ptr ds:[230h], 0FFFFh	;@02B60
@@9:	mov	sp, bp	;@02B66
	pop	bp	;@02B68
	ret	;@02B69
@@10:	sub	bx, 4001h	;@02B6A
	shl	bx, 1	;@02B6E
	add	bx, word ptr ds:[52Eh]	;@02B70
	mov	es, word ptr ds:[788h]	;@02B74
	mov	bx, word ptr es:[bx]	;@02B78
	push	bx	;@02B7B
	and	bx, 3	;@02B7C
	shl	bx, 1	;@02B7F
	shl	bx, 1	;@02B81
	shl	bx, 1	;@02B83
	mov	es, word ptr [bx+758h]	;@02B85
	pop	bx	;@02B89
	mov	ax, word ptr es:[bx+2]	;@02B8A
	cmp	ax, word ptr ds:[228h]	;@02B8E
	jne	@@11	;@02B92
	mov	ax, word ptr es:[bx+4]	;@02B94
	mov	bx, word ptr es:[bx]	;@02B98
	mov	byte ptr [bp-8], 0FFh	;@02B9B
	jmp	@@3	;@02B9F
@@11:	inc	word ptr ds:[178h]	;@02BA2
	mov	word ptr ds:[230h], 1	;@02BA6
	mov	si, word ptr ds:[3E0h]	;@02BAC
	jmp	@@9	;@02BB0
	db	4Bh, 93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 8Bh, 0F3h, 3, 36h, 2Ch, 5	;@02BB2
	db	8Eh, 6, 78h, 7, 26h, 8Ah, 44h, 9, 8Eh, 6, 80h, 7, 26h, 8Bh, 4Ch
	db	6, 26h, 8Bh, 34h, 0A8h, 0E0h, 74h, 6, 0E8h, 1Ah, 65h, 33h, 0DBh
	db	0C3h, 8Bh, 0C6h, 0BBh, 1, 0, 0EBh, 0F8h
P2_COMENT_E6:	cmp	word ptr ds:[230h], 1	;@02BE3
	jne	@@1	;@02BE8
	cmp	word ptr ds:[178h], 0	;@02BEA
	je	@@1	;@02BEF
	jmp	E6_SKIP	;@02BF1
@@1:	mov	ax, word ptr ds:[4E8h]	;@02BF4
	inc	ax	;@02BF7
	cmp	word ptr ds:[178h], 0	;@02BF8
	jne	@@3	;@02BFD
	cmp	word ptr ds:[38Dh], 0	;@02BFF
	jne	@@2	;@02C04
	mov	word ptr ds:[38Dh], ax	;@02C06
@@2:	jmp	short E6_LOOP	;@02C09
@@3:	mov	di, word ptr ds:[383h]	;@02C0B
	mov	es, word ptr ds:[36Dh]	;@02C0F
	cmp	word ptr es:[di-16h], 0	;@02C13
	jne	E6_LOOP	;@02C18
	mov	word ptr es:[di-16h], ax	;@02C1A
	jmp	short E6_LOOP	;@02C1E
L02C20:	inc	word ptr ds:[4E8h]	;@02C20
	cmp	word ptr ds:[178h], 0	;@02C24
	je	@@1	;@02C29
	mov	di, word ptr ds:[383h]	;@02C2B
	mov	es, word ptr ds:[36Dh]	;@02C2F
	inc	word ptr es:[di-14h]	;@02C33
@@1:	xor	ax, ax	;@02C37
	call	LOOKUP_NAME_SKIP	;@02C39
	mov	di, 290h	;@02C3C
	mov	word ptr [di], ax	;@02C3F
	sub	bx, bx	;@02C41
	add	bl, byte ptr [si]	;@02C43
	jge	@@2	;@02C45
	inc	si	;@02C47
	sub	bl, 80h	;@02C48
	mov	bh, bl	;@02C4B
	mov	bl, byte ptr [si]	;@02C4D
@@2:	inc	si	;@02C4F
	cmp	bx, 18h	;@02C50
	jb	@@3	;@02C53
	add	bx, word ptr ds:[38Fh]	;@02C55
@@3:	mov	word ptr [di+2], bx	;@02C59
	lodsb	;@02C5C
	mov	byte ptr [di+8], al	;@02C5D
	and	ax, 7	;@02C60
	mov	bx, ax	;@02C63
	shl	bx, 1	;@02C65
	call	word ptr cs:[bx+2CB5h]	;@02C67
	push	si	;@02C6C
	mov	si, 290h	;@02C6D
	mov	cx, 9	;@02C70
	mov	al, byte ptr [si+8]	;@02C73
	and	al, 7	;@02C76
	cmp	al, 1	;@02C78
	jbe	E6_KEEP_LOCAL	;@02C7A
	mov	bp, 47Eh	;@02C7C
	mov	bx, 309h	;@02C7F
	call	WRITE_AT	;@02C82
E6_SYMBOL_DONE:	pop	si	;@02C85
E6_LOOP:	cmp	si, word ptr ds:[3E0h]	;@02C86
	jb	L02C20	;@02C8A
E6_DONE:	ret	;@02C8C
E6_KEEP_LOCAL:	mov	es, word ptr ds:[381h]	;@02C8D
	mov	di, word ptr ds:[38Bh]	;@02C91
	mov	ax, word ptr ds:[389h]	;@02C95
	stosw	;@02C98
	mov	word ptr ds:[38Bh], di	;@02C99
	mov	di, ax	;@02C9D
	mov	es, word ptr ds:[37Dh]	;@02C9F
	shr	cx, 1	;@02CA3
	rep movsw	;@02CA5
	rcl	cx, 1	;@02CA7
	rep movsb	;@02CA9
	inc	word ptr ds:[367h]	;@02CAB
	mov	word ptr ds:[389h], di	;@02CAF
	jmp	E6_SYMBOL_DONE	;@02CB3
	db	0CEh, 2Ch, 12h, '-A-A-K-', 0C5h, ',@-@-'	;@02CB5
E6_DWORD:	lodsw	;@02CC5
	mov	word ptr [di+4], ax	;@02CC6
	lodsw	;@02CC9
	mov	word ptr [di+6], ax	;@02CCA
	ret	;@02CCD
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah	;@02CCE
	db	1Ch, 46h, 23h, 0DBh, 't1K', 0D1h, 0E3h, 0D1h, 0E3h, 3, 1Eh, 30h
	db	5, 8Eh, 6, 98h, 7, 26h, 8Bh, 1Fh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, 5Bh, 26h, 8Bh, 7, 33h
	db	0C9h, 80h, 3Ch, 0, 75h, 8, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh, 0EBh
	db	25h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 46h, 56h, 0E8h, 8Dh, 0FEh, 5Eh, 83h, 0FBh, 1, 75h, 0Ch
	db	8Ah, 5Dh, 8, 80h, 0E3h, 0F8h, 80h, 0CBh, 1, 8, 5Dh, 8
E6_STORE_ADDRESS:	mov	word ptr [di+6], ax	;@02D37
	lodsw	;@02D3A
	add	ax, cx	;@02D3B
	mov	word ptr [di+4], ax	;@02D3D
E6_NOTHING:	ret	;@02D40
E6_WORD:	lodsw	;@02D41
E6_STORE_WORD:	mov	word ptr [di+6], 0	;@02D42
	mov	word ptr [di+4], ax	;@02D47
	ret	;@02D4A
E6_BYTE:	lodsb	;@02D4B
	cbw	;@02D4C
	jmp	E6_STORE_WORD	;@02D4D
E6_SKIP:	mov	si, word ptr ds:[3E0h]	;@02D4F
	jmp	E6_DONE	;@02D53
P2_COMENT_E7:	push	si	;@02D56
	call	SORT_DEBUG_ENTRIES	;@02D57
	pop	si	;@02D5A
	cmp	word ptr ds:[230h], 1	;@02D5B
	je	@@4	;@02D60
	sub	word ptr ds:[383h], 16h	;@02D62
	jl	@@3	;@02D67
	mov	bx, word ptr ds:[383h]	;@02D69
	mov	es, word ptr ds:[36Dh]	;@02D6D
	lodsw	;@02D71
	sub	ax, word ptr es:[bx+8]	;@02D72
	mov	word ptr es:[bx+0Ah], ax	;@02D76
	mov	ax, word ptr ds:[397h]	;@02D7A
	add	word ptr es:[bx+8], ax	;@02D7D
	push	si	;@02D81
	mov	ax, word ptr es:[bx+0Ch]	;@02D82
	mov	dx, word ptr es:[bx+0Eh]	;@02D86
	mov	si, bx	;@02D8A
	mov	cx, 0Ch	;@02D8C
	mov	bx, 36Dh	;@02D8F
	db	0E8h, 70h, 5Bh	; call L08905	;@02D92
	dec	word ptr ds:[178h]	;@02D95
	cmp	word ptr ds:[3A8h], 0	;@02D99
	je	@@1	;@02D9E
	mov	si, word ptr ds:[383h]	;@02DA0
	mov	es, word ptr ds:[36Dh]	;@02DA4
	mov	cx, 4	;@02DA8
	mov	ax, word ptr es:[si+10h]	;@02DAB
	dec	ax	;@02DAF
	mul	cx	;@02DB0
	add	ax, word ptr ds:[341h]	;@02DB2
	adc	dx, word ptr ds:[343h]	;@02DB6
	add	si, 12h	;@02DBA
	mov	bx, 36Dh	;@02DBD
	db	0E8h, 42h, 5Bh	; call L08905	;@02DC0
@@1:	pop	si	;@02DC3
@@2:	ret	;@02DC4
@@3:	db	0E8h, 0D5h, 58h	; call L0869D	;@02DC5
@@4:	dec	word ptr ds:[178h]	;@02DC8
	mov	si, word ptr ds:[3E0h]	;@02DCC
	jmp	@@2	;@02DD0
L02DD2:	inc	word ptr ds:[4F4h]	;@02DD2
	mov	bx, word ptr ds:[4F4h]	;@02DD6
	mov	word ptr ds:[39Bh], bx	;@02DDA
	mov	di, 290h	;@02DDE
	mov	bx, di	;@02DE1
	push	ds	;@02DE3
	pop	es	;@02DE4
	stosw	;@02DE5
	movsw	;@02DE6
	movsw	;@02DE7
	push	si	;@02DE8
	mov	si, bx	;@02DE9
	mov	cx, 6	;@02DEB
	mov	bp, 47Eh	;@02DEE
	mov	bx, 311h	;@02DF1
	call	WRITE_AT	;@02DF4
	pop	si	;@02DF7
	ret	;@02DF8
P2_COMENT_E8:	mov	word ptr ds:[17Ah], 0FFFFh	;@02DF9
	sub	bx, bx	;@02DFF
	add	bl, byte ptr [si]	;@02E01
	jge	@@1	;@02E03
	inc	si	;@02E05
	sub	bl, 80h	;@02E06
	mov	bh, bl	;@02E09
	mov	bl, byte ptr [si]	;@02E0B
@@1:	inc	si	;@02E0D
	and	bx, bx	;@02E0E
	jne	@@2	;@02E10
	mov	ax, 1	;@02E12
	call	LOOKUP_NAME_SKIP	;@02E15
	call	L02DD2	;@02E18
	jmp	short @@3	;@02E1B
@@2:	add	bx, word ptr ds:[39Fh]	;@02E1D
	mov	word ptr ds:[39Bh], bx	;@02E21
	mov	si, word ptr ds:[3E0h]	;@02E25
@@3:	ret	;@02E29
P2_COMENT_SKIP:	mov	si, word ptr ds:[3E0h]	;@02E2A
	ret	;@02E2E
P2_COMENT_ED:	lodsb	;@02E2F
	and	al, al	;@02E30
	je	@@4	;@02E32
	lodsb	;@02E34
	cbw	;@02E35
	and	al, al	;@02E36
	jns	@@1	;@02E38
	sub	al, 80h	;@02E3A
	mov	ah, al	;@02E3C
	lodsb	;@02E3E
@@1:	add	word ptr ds:[510h], ax	;@02E3F
	mov	cx, ax	;@02E43
@@2:	push	ds	;@02E45
	pop	es	;@02E46
	mov	di, 290h	;@02E47
	lodsb	;@02E4A
	cbw	;@02E4B
	and	al, al	;@02E4C
	jns	@@3	;@02E4E
	sub	al, 80h	;@02E50
	mov	ah, al	;@02E52
	lodsb	;@02E54
@@3:	add	ax, word ptr ds:[39Fh]	;@02E55
	stosw	;@02E59
	movsw	;@02E5A
	lodsb	;@02E5B
	mov	ah, 0	;@02E5C
	stosw	;@02E5E
	push	cx	;@02E5F
	xor	ax, ax	;@02E60
	call	LOOKUP_NAME_SKIP	;@02E62
	push	si	;@02E65
	mov	si, 290h	;@02E66
	mov	word ptr [si+6], ax	;@02E69
	mov	cx, 8	;@02E6C
	mov	bx, 33Dh	;@02E6F
	mov	bp, 47Eh	;@02E72
	call	WRITE_AT	;@02E75
	pop	si	;@02E78
	pop	cx	;@02E79
	loop	@@2	;@02E7A
	ret	;@02E7C
@@4:	sub	bx, bx	;@02E7D
	add	bl, byte ptr [si]	;@02E7F
	jge	@@5	;@02E81
	inc	si	;@02E83
	sub	bl, 80h	;@02E84
	mov	bh, bl	;@02E87
	mov	bl, byte ptr [si]	;@02E89
@@5:	inc	si	;@02E8B
	push	bx	;@02E8C
	mov	di, 290h	;@02E8D
	mov	ax, word ptr ds:[3A5h]	;@02E90
	mov	word ptr [di+6], ax	;@02E93
	mov	ax, word ptr ds:[39Dh]	;@02E96
	mov	word ptr [di+4], ax	;@02E99
	mov	ax, word ptr ds:[4E6h]	;@02E9C
	inc	ax	;@02E9F
	mov	word ptr ds:[39Dh], ax	;@02EA0
	lodsw	;@02EA3
	mov	word ptr [di+8], ax	;@02EA4
	lodsb	;@02EA7
	mov	byte ptr [di+0Ah], al	;@02EA8
	mov	ax, word ptr ds:[50Ch]	;@02EAB
	inc	ax	;@02EAE
	mov	word ptr [di], ax	;@02EAF
	lodsb	;@02EB1
	cbw	;@02EB2
	and	al, al	;@02EB3
	jns	@@6	;@02EB5
	sub	al, 80h	;@02EB7
	mov	ah, al	;@02EB9
	lodsb	;@02EBB
@@6:	mov	word ptr [di+2], ax	;@02EBC
	add	word ptr ds:[50Ch], ax	;@02EBF
	mov	cx, ax	;@02EC3
	pop	ax	;@02EC5
	push	si	;@02EC6
	push	cx	;@02EC7
	add	ax, word ptr ds:[3A1h]	;@02EC8
	dec	ax	;@02ECC
	mov	cx, 0Bh	;@02ECD
	mul	cx	;@02ED0
	add	ax, word ptr ds:[335h]	;@02ED2
	adc	dx, word ptr ds:[337h]	;@02ED6
	mov	si, 290h	;@02EDA
	mov	bx, 47Eh	;@02EDD
	db	0E8h, 22h, 5Ah	; call L08905	;@02EE0
	pop	cx	;@02EE3
	pop	si	;@02EE4
	jcxz	@@8	;@02EE5
	mov	bx, si	;@02EE7
	mov	dx, cx	;@02EE9
	mov	ax, word ptr ds:[3A1h]	;@02EEB
@@7:	add	word ptr [bx], ax	;@02EEE
	inc	bx	;@02EF0
	inc	bx	;@02EF1
	loop	@@7	;@02EF2
	push	bx	;@02EF4
	mov	cx, dx	;@02EF5
	shl	cx, 1	;@02EF7
	mov	bx, 339h	;@02EF9
	mov	bp, 47Eh	;@02EFC
	call	WRITE_AT	;@02EFF
	pop	si	;@02F02
@@8:	inc	word ptr ds:[50Ah]	;@02F03
	ret	;@02F07
P2_COMENT_F8:	call	L0269D	;@02F08
	and	ax, ax	;@02F0B
	jne	@@1	;@02F0D
	mov	ax, 0FFFFh	;@02F0F
@@1:	mov	es, word ptr ds:[36Dh]	;@02F12
	mov	word ptr es:[6], ax	;@02F16
	ret	;@02F1A
	db	80h, 3Eh, 2Fh, 1, 1, 'tK+', 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh	;@02F1B
	db	80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 81h, 0FBh, 0, 40h, 7Fh, 3Ch, 4Bh
	db	93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 8Eh, 6, 80h, 7
	db	26h, 8Bh, 57h, 6, 0C4h, 3Eh, 0B2h, 3, 26h, 89h, 1Dh, 47h, 47h
	db	8Bh, 0Eh, 0E0h, 3, 2Bh, 0CEh, 0D1h, 0E9h, 26h, 89h, 0Dh, 47h, 47h
	db	0E3h, 0Ah, 0ADh, 3, 0C2h, 0ABh, 89h, 3Eh, 0B2h, 3, 0E2h, 0F6h
	db	0C3h, 8Bh, 36h, 0E0h, 3, 0EBh, 0F9h, 81h, 0EBh, 1, 40h, 0D1h, 0E3h
	db	3, 1Eh, 2Eh, 5, 8Eh, 6, 88h, 7, 26h, 8Bh, 1Fh, 53h, 83h, 0E3h
	db	3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h
	db	8Bh, 47h, 2, 3Bh, 6, 28h, 2, 75h, 5, 26h, 8Bh, 1Fh, 0EBh, 0A0h
	db	8Bh, 36h, 0E0h, 3, 0EBh, 0C4h, 0D1h, 26h, 9Fh, 27h, 5Bh, 27h, 7Bh
	db	2Ah, 0E3h, '+V-', 0F9h, '-*.*.*.*./.', 1Bh, '/*.*.*.*.*.*.*.*.*.'
	db	8, 2Fh, 0ADh, 80h, 3Eh, 17h, 0, 0, 74h, 26h, 80h, '>xR', 0, 75h
	db	1Fh, 8Ah, 0DCh, 32h, 0FFh, 81h, 0EBh, 0E2h, 0, 7Ch, 15h, 83h, 0FBh
	db	17h, 73h, 10h, 0D1h, 0E3h, 2Eh, 0FFh, 97h, 0A8h, '/;6', 0E0h, 3
	db	74h, 3, 0E8h, 99h, 56h, 0E9h, 0CAh, 27h
EXPAND_LIDATA_BLOCK:	push	ax	;@03007
	lodsw	;@03008
	xchg	ax, bx	;@03009
	mov	di, word ptr ds:[3ECh]	;@0300A
	and	di, di	;@0300E
	je	@@2	;@03010
	lodsw	;@03012
	xchg	ax, di	;@03013
	jmp	short @@2	;@03014
@@1:	pop	si	;@03016
@@2:	push	si	;@03017
	lodsw	;@03018
	or	ax, ax	;@03019
	je	@@5	;@0301B
	push	di	;@0301D
	push	bx	;@0301E
@@3:	call	EXPAND_LIDATA_BLOCK	;@0301F
	dec	ax	;@03022
	jne	@@3	;@03023
	pop	bx	;@03025
	pop	di	;@03026
	sub	bx, 1	;@03027
	sbb	di, 0	;@0302A
	jne	@@1	;@0302D
	or	bx, bx	;@0302F
	jne	@@1	;@03031
	jmp	short @@6	;@03033
@@4:	pop	si	;@03035
@@5:	push	si	;@03036
	push	di	;@03037
	push	bx	;@03038
	lodsb	;@03039
	mov	ah, 0	;@0303A
	xchg	ax, cx	;@0303C
	db	0E8h, 1Dh, 59h	; call L0895D	;@0303D
	xchg	ax, cx	;@03040
	pop	bx	;@03041
	pop	di	;@03042
	sub	bx, 1	;@03043
	sbb	di, 0	;@03046
	jne	@@4	;@03049
	or	bx, bx	;@0304B
	jne	@@4	;@0304D
	pop	ax	;@0304F
@@6:	pop	ax	;@03050
	pop	ax	;@03051
	ret	;@03052
L03053:	push	si	;@03053
	cmp	byte ptr ds:[3F1h], 0FFh	;@03054
	je	@@5	;@03059
	mov	cx, word ptr ds:[3E4h]	;@0305B
	mov	si, 0A50h	;@0305F
	mov	bx, cx	;@03062
	mov	al, byte ptr [bx+si-1]	;@03064
	mov	byte ptr ds:[214h], al	;@03067
	mov	bx, word ptr ds:[3E8h]	;@0306A
	mov	dx, cx	;@0306E
	add	dx, bx	;@03070
	mov	word ptr ds:[212h], dx	;@03072
	mov	dx, word ptr ds:[3E6h]	;@03076
	mov	word ptr ds:[210h], dx	;@0307A
	sub	ax, ax	;@0307E
	xchg	byte ptr ds:[0A4Eh], al	;@03080
	add	cx, ax	;@03084
	sub	si, ax	;@03086
	sub	bx, ax	;@03088
	mov	ax, word ptr ds:[3EEh]	;@0308A
	add	ax, word ptr ds:[3FEh]	;@0308D
	mov	dl, byte ptr ds:[3F0h]	;@03091
	mov	dh, 0	;@03095
	adc	dl, dh	;@03097
	shl	ax, 1	;@03099
	rcl	dx, 1	;@0309B
	shl	ax, 1	;@0309D
	rcl	dx, 1	;@0309F
	shl	ax, 1	;@030A1
	rcl	dx, 1	;@030A3
	shl	ax, 1	;@030A5
	rcl	dx, 1	;@030A7
	add	ax, bx	;@030A9
	adc	dx, word ptr ds:[3EAh]	;@030AB
	cmp	byte ptr ds:[3F1h], 1	;@030AF
	je	@@2	;@030B4
	db	0E8h, 0A4h, 58h	; call L0895D	;@030B6
@@1:	pop	si	;@030B9
	mov	byte ptr ds:[3F1h], 0FFh	;@030BA
	ret	;@030BF
@@2:	xchg	ax, cx	;@030C0
	add	ax, 0A50h	;@030C1
	jmp	short @@4	;@030C4
@@3:	call	EXPAND_LIDATA_BLOCK	;@030C6
@@4:	cmp	si, ax	;@030C9
	jb	@@3	;@030CB
	jmp	@@1	;@030CD
@@5:	mov	word ptr ds:[210h], 0FFFFh	;@030CF
	jmp	@@1	;@030D5
L030D7:	push	di	;@030D7
	push	si	;@030D8
	push	ax	;@030D9
	mov	di, word ptr ds:[3E6h]	;@030DA
	mov	es, word ptr ds:[780h]	;@030DE
	mov	di, word ptr es:[di]	;@030E2
	mov	es, word ptr ds:[7A0h]	;@030E5
	cmp	byte ptr es:[di+1], 1	;@030E9
	je	@@1	;@030EE
	cmp	byte ptr es:[di+1], 3	;@030F0
	jne	@@7	;@030F5
@@1:	cmp	bx, word ptr es:[di+4]	;@030F7
	jne	@@7	;@030FB
	mov	di, 3FFh	;@030FD
	and	di, dx	;@03100
	je	@@6	;@03102
	mov	al, byte ptr [di+0A4Fh]	;@03104
@@2:	mov	si, word ptr [di+0A50h]	;@03108
	cmp	al, 9Ah	;@0310C
	je	@@3	;@0310E
	cmp	al, 0EAh	;@03110
	jne	@@7	;@03112
	mov	word ptr [di+0A4Fh], 9090h	;@03114
	mov	byte ptr [di+0A51h], 0E9h	;@0311A
	jmp	short @@4	;@0311F
@@3:	mov	word ptr [di+0A4Fh], 0E90h	;@03121
	mov	byte ptr [di+0A51h], 0E8h	;@03127
@@4:	or	di, di	;@0312C
	jne	@@5	;@0312E
	mov	byte ptr ds:[0A4Eh], 1	;@03130
@@5:	add	dx, 0F802h	;@03135
	mov	word ptr [di+0A52h], si	;@03139
	sub	cx, di	;@0313D
	sub	cx, 4	;@0313F
	sub	cx, word ptr ds:[3E8h]	;@03142
	mov	word ptr ds:[21Ch], 0FFFFh	;@03146
	stc	;@0314C
	jmp	short @@8	;@0314D
@@6:	mov	si, word ptr ds:[210h]	;@0314F
	cmp	si, word ptr ds:[3E6h]	;@03153
	jne	@@7	;@03157
	mov	si, word ptr ds:[212h]	;@03159
	cmp	si, word ptr ds:[3E8h]	;@0315D
	jne	@@7	;@03161
	mov	al, byte ptr ds:[214h]	;@03163
	jmp	@@2	;@03166
@@7:	clc	;@03168
@@8:	pop	ax	;@03169
	pop	si	;@0316A
	pop	di	;@0316B
	ret	;@0316C
L0316D:	mov	di, 3FFh	;@0316D
	and	di, dx	;@03170
	mov	es, word ptr ds:[780h]	;@03172
	mov	bx, word ptr es:[bx+4]	;@03176
	cmp	word ptr ds:[21Ch], 0	;@0317A
	je	@@1	;@0317F
	cmp	word ptr [di+0A50h], 0	;@03181
	jne	@@1	;@03186
	mov	cx, word ptr ds:[21Ch]	;@03188
	ret	;@0318C
@@1:	add	cx, word ptr [di+0A50h]	;@0318D
	mov	si, word ptr es:[bx+4]	;@03191
	jmp	short @@3	;@03195
@@2:	mov	si, word ptr es:[si+0Ah]	;@03197
@@3:	cmp	si, -1	;@0319B
	je	@@4	;@0319E
	push	si	;@031A0
	and	si, 3	;@031A1
	shl	si, 1	;@031A4
	shl	si, 1	;@031A6
	shl	si, 1	;@031A8
	mov	es, word ptr [si+758h]	;@031AA
	pop	si	;@031AE
	cmp	cx, word ptr es:[si+4]	;@031AF
	jne	@@2	;@031B3
	mov	word ptr [di+0A50h], 0	;@031B5
	mov	cx, word ptr es:[si+8]	;@031BB
	ret	;@031BF
@@4:	sub	cx, word ptr [di+0A50h]	;@031C0
	ret	;@031C4
	db	31h, 32h, 0E5h, '152', 17h, '212)21212'	;@031C5
FIXUP_BY_LOCATION:	push	di	;@031D5
	push	si	;@031D6
	push	ax	;@031D7
	mov	ax, 1Ch	;@031D8
	and	al, dh	;@031DB
	shr	ax, 1	;@031DD
	xchg	ax, di	;@031DF
	jmp	word ptr cs:[di+31C5h]	;@031E0
	db	0A1h, 50h, 4, 8Eh, 6, 78h, 7, '&;G', 2, 74h, 3Fh, 8Bh, 3Eh, 0E6h	;@031E5
	db	3, 8Eh, 6, 80h, 7, 26h, 8Bh, 3Dh, 8Eh, 6, 0A0h, 7, 26h, 80h, 7Dh
	db	1, 1, 74h, 7, 26h, 80h, 7Dh, 1, 3, 'u"&;]', 4, 75h, 14h, 0EBh
	db	1Ah, 0A1h, 50h, 4, 8Eh, 6, 78h, 7, '&;G', 2, 74h, 24h, 0E8h, 0B0h
	db	0FEh, 72h, 8
FIX_LOADER_OFFSET:	call	L0316D	;@03229
	cmp	si, -1	;@0322C
	je	@@2	;@0322F
@@1:	pop	ax	;@03231
	pop	si	;@03232
	pop	di	;@03233
	ret	;@03234
	db	0A1h, 50h, 4, 8Eh, 6, 78h, 7, '&;G', 2, 75h, 6, 0C7h, 6, 16h, 2	;@03235
	db	0FFh, 0FFh, 8Eh, 6, 80h, 7, 26h, 8Bh, 5Fh, 4, 0EBh, 0DFh
@@2:	push	si	;@03252
	mov	si, word ptr ds:[3E6h]	;@03253
	mov	es, word ptr ds:[778h]	;@03257
	mov	si, word ptr es:[si]	;@0325B
	mov	di, 28h	;@0325E
	db	0E8h, 0DCh, 64h	; call COPY_NAME	;@03261
	mov	ax, word ptr ds:[224h]	;@03264
	and	ax, 3FFh	;@03267
	add	ax, word ptr ds:[3E8h]	;@0326A
	mov	di, 78h	;@0326E
	push	ax	;@03271
	mov	al, ah	;@03272
	db	0E8h, 0CDh, 62h	; call L09544	;@03274
	pop	ax	;@03277
	db	0E8h, 0C9h, 62h	; call L09544	;@03278
	mov	byte ptr [di], 0	;@0327B
	mov	ds, word ptr cs:L00100+16	;@0327E
	mov	word ptr ds:[422h], 1	;@03283
	push	ds	;@03289
	mov	ax, 78h	;@0328A
	push	ax	;@0328D
	push	ds	;@0328E
	mov	ax, 28h	;@0328F
	push	ax	;@03292
	mov	cx, 8	;@03293
	push	cx	;@03296
	mov	ax, 34h	;@03297
	push	ax	;@0329A
	db	0E8h, 0Dh, 89h	; call WARNING	;@0329B
	pop	si	;@0329E
	jmp	@@1	;@0329F
L032A1:	push	ax	;@032A1
	push	bx	;@032A2
	push	si	;@032A3
	mov	ax, word ptr es:[bx+0Ch]	;@032A4
	mov	si, 460h	;@032A8
	mov	bx, 9	;@032AB
@@1:	cmp	ax, word ptr [si]	;@032AE
	je	@@3	;@032B0
	add	si, 2	;@032B2
	dec	bx	;@032B5
	jne	@@1	;@032B6
@@2:	pop	si	;@032B8
	pop	bx	;@032B9
	pop	ax	;@032BA
	ret	;@032BB
@@3:	xor	cx, cx	;@032BC
	mov	word ptr ds:[420h], cx	;@032BE
	or	byte ptr ds:[215h], 40h	;@032C2
	mov	word ptr ds:[24Ah], ax	;@032C7
	jmp	@@2	;@032CA
DECODE_FIXUP:	mov	word ptr ds:[224h], dx	;@032CC
	xor	ax, ax	;@032D0
	mov	word ptr ds:[21Ch], ax	;@032D2
	mov	word ptr ds:[21Eh], ax	;@032D5
	mov	word ptr ds:[220h], ax	;@032D8
	mov	byte ptr ds:[215h], al	;@032DB
	mov	word ptr ds:[420h], ax	;@032DE
	dec	ax	;@032E1
	mov	word ptr ds:[218h], ax	;@032E2
	mov	word ptr ds:[21Ah], ax	;@032E5
	lodsb	;@032E8
	mov	ah, al	;@032E9
	and	al, 0F0h	;@032EB
	js	@@2	;@032ED
	cmp	al, 30h	;@032EF
	jae	@@3	;@032F1
	sub	bx, bx	;@032F3
	add	bl, byte ptr [si]	;@032F5
	jge	@@1	;@032F7
	inc	si	;@032F9
	sub	bl, 80h	;@032FA
	mov	bh, bl	;@032FD
	mov	bl, byte ptr [si]	;@032FF
@@1:	inc	si	;@03301
	mov	bp, bx	;@03302
	jmp	short @@4	;@03304
@@2:	shr	al, 1	;@03306
	shr	al, 1	;@03308
	shr	al, 1	;@0330A
	mov	bx, ax	;@0330C
	and	bx, 6	;@0330E
	mov	bp, word ptr [bx+242h]	;@03311
	shr	bx, 1	;@03315
	mov	al, byte ptr [bx+23Eh]	;@03317
	jmp	short @@4	;@0331B
@@3:	ja	@@4	;@0331D
	xchg	ax, bp	;@0331F
	lodsw	;@03320
	xchg	ax, bp	;@03321
@@4:	test	ah, 8	;@03322
	jne	@@6	;@03325
	test	ah, 4	;@03327
	jne	@@10	;@0332A
	and	ah, 3	;@0332C
	cmp	ah, 3	;@0332F
	je	@@8	;@03332
	sub	bx, bx	;@03334
	add	bl, byte ptr [si]	;@03336
	jge	@@5	;@03338
	inc	si	;@0333A
	sub	bl, 80h	;@0333B
	mov	bh, bl	;@0333E
	mov	bl, byte ptr [si]	;@03340
@@5:	inc	si	;@03342
	xchg	ax, cx	;@03343
	lodsw	;@03344
	xchg	ax, cx	;@03345
	cmp	word ptr ds:[41Eh], 0	;@03346
	je	@@12	;@0334B
	push	word ptr [si]	;@0334D
	inc	si	;@0334F
	inc	si	;@03350
	pop	word ptr ds:[420h]	;@03351
	jmp	short @@12	;@03355
@@6:	sub	cx, cx	;@03357
	test	ah, 4	;@03359
	jne	@@7	;@0335C
	xchg	ax, cx	;@0335E
	lodsw	;@0335F
	xchg	ax, cx	;@03360
	cmp	word ptr ds:[41Eh], 0	;@03361
	je	@@7	;@03366
	xchg	ax, bx	;@03368
	lodsw	;@03369
	xchg	ax, bx	;@0336A
	mov	word ptr ds:[420h], bx	;@0336B
@@7:	mov	bl, ah	;@0336F
	and	bx, 3	;@03371
	mov	ah, byte ptr [bx+232h]	;@03374
	shl	bx, 1	;@03378
	mov	bx, word ptr [bx+236h]	;@0337A
	jmp	short @@12	;@0337E
@@8:	mov	bx, word ptr [si]	;@03380
	mov	cx, word ptr [si+2]	;@03382
	add	si, 4	;@03385
	jmp	short @@12	;@03388
@@9:	mov	bx, word ptr [si]	;@0338A
	add	si, 2	;@0338C
	jmp	short @@12	;@0338F
@@10:	sub	cx, cx	;@03391
	and	ah, 3	;@03393
	cmp	ah, 3	;@03396
	je	@@9	;@03399
	sub	bx, bx	;@0339B
	add	bl, byte ptr [si]	;@0339D
	jge	@@11	;@0339F
	inc	si	;@033A1
	sub	bl, 80h	;@033A2
	mov	bh, bl	;@033A5
	mov	bl, byte ptr [si]	;@033A7
@@11:	inc	si	;@033A9
@@12:	cmp	ah, 2	;@033AA
	je	@@13	;@033AD
	ja	@@14	;@033AF
	or	ah, ah	;@033B1
	je	@@16	;@033B3
	jmp	@@20	;@033B5
@@13:	jmp	@@27	;@033B8
@@14:	jmp	@@35	;@033BB
@@15:	jmp	FIXUP_OVERFLOW	;@033BE
@@16:	cmp	bx, 4000h	;@033C1
	jle	@@17	;@033C5
	jmp	@@26	;@033C7
@@17:	or	byte ptr ds:[215h], 4	;@033CA
	cmp	bx, word ptr ds:[53Dh]	;@033CF
	ja	@@15	;@033D3
	dec	bx	;@033D5
	xchg	ax, bx	;@033D6
	mov	ah, 0Ah	;@033D7
	mul	ah	;@033D9
	xchg	ax, bx	;@033DB
	add	bx, word ptr ds:[52Ch]	;@033DC
	mov	es, word ptr ds:[780h]	;@033E0
	add	cx, word ptr es:[bx+6]	;@033E4
	xchg	ax, di	;@033E8
	mov	al, byte ptr es:[bx+8]	;@033E9
	mov	ah, 0	;@033ED
	adc	word ptr ds:[420h], ax	;@033EF
	xchg	ax, di	;@033F3
	mov	es, word ptr ds:[778h]	;@033F4
	test	byte ptr es:[bx+9], 0E0h	;@033F8
	je	@@18	;@033FD
	mov	es, word ptr ds:[780h]	;@033FF
	mov	di, word ptr es:[bx+2]	;@03403
	or	byte ptr ds:[215h], 10h	;@03407
	jmp	short @@21	;@0340C
@@18:	or	byte ptr ds:[215h], 1	;@0340E
	mov	word ptr ds:[21Ch], 0FFFFh	;@03413
	mov	es, word ptr ds:[780h]	;@03419
	mov	di, word ptr es:[bx]	;@0341D
	jmp	@@36	;@03420
@@19:	mov	bx, word ptr es:[bx]	;@03423
	push	bx	;@03426
	and	bx, 3	;@03427
	shl	bx, 1	;@0342A
	shl	bx, 1	;@0342C
	shl	bx, 1	;@0342E
	mov	es, word ptr [bx+718h]	;@03430
	pop	bx	;@03434
	mov	bx, word ptr es:[bx]	;@03435
	mov	es, word ptr ds:[7A0h]	;@03438
	mov	di, word ptr es:[bx+4]	;@0343C
	jmp	short @@21	;@03440
@@20:	dec	bx	;@03442
	shl	bx, 1	;@03443
	shl	bx, 1	;@03445
	add	bx, word ptr ds:[530h]	;@03447
	mov	es, word ptr ds:[798h]	;@0344B
	cmp	byte ptr ds:[19h], 1	;@0344F
	je	@@19	;@03454
	mov	di, word ptr es:[bx]	;@03456
	mov	bx, word ptr es:[bx+2]	;@03459
	push	di	;@0345D
	and	di, 3	;@0345E
	shl	di, 1	;@03461
	shl	di, 1	;@03463
	shl	di, 1	;@03465
	mov	es, word ptr [di+718h]	;@03467
	pop	di	;@0346B
	mov	di, word ptr es:[di]	;@0346C
	mov	word ptr ds:[22Eh], di	;@0346F
	mov	es, word ptr ds:[780h]	;@03473
	mov	di, word ptr es:[bx]	;@03477
	cmp	di, word ptr ds:[22Eh]	;@0347A
	jne	@@24	;@0347E
	mov	es, word ptr ds:[7A0h]	;@03480
	mov	di, word ptr es:[di+4]	;@03484
@@21:	test	dh, 40h	;@03488
	je	@@22	;@0348B
	jmp	@@36	;@0348D
@@22:	mov	word ptr ds:[21Ch], 0FFFFh	;@03490
	push	ax	;@03496
	mov	ax, 3FFh	;@03497
	and	ax, dx	;@0349A
	push	dx	;@0349C
	mov	dx, word ptr ds:[3EAh]	;@0349D
	add	ax, word ptr ds:[3E8h]	;@034A1
	adc	dx, 0	;@034A5
	add	ax, 2	;@034A8
	adc	dx, 0	;@034AB
	cmp	word ptr ds:[41Eh], 0	;@034AE
	je	@@23	;@034B3
	add	ax, 2	;@034B5
	adc	dx, 0	;@034B8
@@23:	mov	word ptr ds:[21Eh], ax	;@034BB
	mov	word ptr ds:[220h], dx	;@034BE
	pop	dx	;@034C2
	pop	ax	;@034C3
	jmp	@@36	;@034C4
@@24:	mov	di, word ptr es:[bx+2]	;@034C7
	jmp	@@21	;@034CB
@@25:	jmp	UNDEFINED_SYMBOL	;@034CD
@@26:	sub	bx, 4000h	;@034D0
@@27:	dec	bx	;@034D4
	shl	bx, 1	;@034D5
	add	bx, word ptr ds:[52Eh]	;@034D7
	mov	es, word ptr ds:[788h]	;@034DB
	mov	bx, word ptr es:[bx]	;@034DF
	mov	word ptr ds:[21Ah], bx	;@034E2
	push	bx	;@034E6
	and	bx, 3	;@034E7
	shl	bx, 1	;@034EA
	shl	bx, 1	;@034EC
	shl	bx, 1	;@034EE
	mov	es, word ptr [bx+758h]	;@034F0
	pop	bx	;@034F4
	push	word ptr es:[bx+0Ch]	;@034F5
	pop	word ptr ds:[218h]	;@034F9
	test	byte ptr es:[bx+0Eh], 10h	;@034FD
	jne	@@25	;@03502
	cmp	word ptr es:[bx], -1	;@03504
	je	@@25	;@03508
	add	cx, word ptr es:[bx+4]	;@0350A
	mov	di, word ptr es:[bx+6]	;@0350E
	adc	word ptr ds:[420h], di	;@03512
	test	dh, 40h	;@03516
	je	@@28	;@03519
	mov	di, word ptr es:[bx+8]	;@0351B
	cmp	di, -1	;@0351F
	mov	word ptr ds:[21Ch], di	;@03522
	je	@@30	;@03526
	jmp	short @@31	;@03528
@@28:	mov	word ptr ds:[21Ch], 0FFFFh	;@0352A
	push	ax	;@03530
	mov	ax, 3FFh	;@03531
	and	ax, dx	;@03534
	push	dx	;@03536
	mov	dx, word ptr ds:[3EAh]	;@03537
	add	ax, word ptr ds:[3E8h]	;@0353B
	adc	dx, 0	;@0353F
	add	ax, 2	;@03542
	adc	dx, 0	;@03545
	cmp	word ptr ds:[41Eh], 0	;@03548
	je	@@29	;@0354D
	add	ax, 2	;@0354F
	adc	dx, 0	;@03552
@@29:	mov	word ptr ds:[21Eh], ax	;@03555
	mov	word ptr ds:[220h], dx	;@03558
	pop	dx	;@0355C
	pop	ax	;@0355D
@@30:	test	byte ptr es:[bx+0Eh], 20h	;@0355E
	jne	@@32	;@03563
	test	byte ptr es:[bx+0Eh], 2	;@03565
	jne	@@33	;@0356A
@@31:	mov	di, word ptr es:[bx]	;@0356C
	mov	es, word ptr ds:[780h]	;@0356F
	mov	bx, word ptr es:[di]	;@03573
	mov	es, word ptr ds:[778h]	;@03576
	test	byte ptr es:[di+9], 0E0h	;@0357A
	je	@@35	;@0357F
	mov	es, word ptr ds:[780h]	;@03581
	mov	di, word ptr es:[di+2]	;@03585
	jmp	short @@36	;@03589
@@32:	mov	cx, word ptr es:[bx+2]	;@0358B
	mov	bx, 0FFFDh	;@0358F
	jmp	L0381F	;@03592
@@33:	cmp	byte ptr ds:[19h], 0	;@03595
	je	@@34	;@0359A
	call	L032A1	;@0359C
@@34:	mov	bx, word ptr es:[bx]	;@0359F
@@35:	or	byte ptr ds:[215h], 1	;@035A2
	mov	word ptr ds:[21Ch], 0FFFFh	;@035A7
	mov	di, bx	;@035AD
@@36:	mov	bx, bp	;@035AF
	cmp	al, 20h	;@035B1
	jbe	@@37	;@035B3
	jmp	@@50	;@035B5
@@37:	jne	@@38	;@035B8
	jmp	@@52	;@035BA
@@38:	or	al, al	;@035BD
	jne	@@44	;@035BF
	cmp	bx, 4000h	;@035C1
	jle	@@39	;@035C5
	jmp	@@51	;@035C7
@@39:	cmp	bx, word ptr ds:[53Dh]	;@035CA
	ja	@@42	;@035CE
	dec	bx	;@035D0
	xchg	ax, bx	;@035D1
	mov	ah, 0Ah	;@035D2
	mul	ah	;@035D4
	xchg	ax, bx	;@035D6
	add	bx, word ptr ds:[52Ch]	;@035D7
@@40:	mov	es, word ptr ds:[778h]	;@035DB
	test	byte ptr es:[bx+9], 0E0h	;@035DF
	je	@@43	;@035E4
	mov	es, word ptr ds:[780h]	;@035E6
	mov	bx, word ptr es:[bx+2]	;@035EA
	cmp	byte ptr ds:[19h], 1	;@035EE
	jne	@@41	;@035F3
	jmp	@@59	;@035F5
@@41:	or	byte ptr ds:[215h], 4	;@035F8
	mov	ax, word ptr es:[bx+6]	;@035FD
	and	al, 0F0h	;@03601
	sub	cx, ax	;@03603
	mov	al, byte ptr es:[bx+8]	;@03605
	mov	ah, 0	;@03609
	sbb	word ptr ds:[420h], ax	;@0360B
	or	byte ptr ds:[215h], 10h	;@0360F
	jmp	@@59	;@03614
@@42:	jmp	FIXUP_OVERFLOW	;@03617
@@43:	mov	es, word ptr ds:[780h]	;@0361A
	mov	bx, word ptr es:[bx]	;@0361E
	jmp	@@53	;@03621
@@44:	dec	bx	;@03624
	jge	@@45	;@03625
	jmp	@@49	;@03627
@@45:	shl	bx, 1	;@0362A
	shl	bx, 1	;@0362C
	add	bx, word ptr ds:[530h]	;@0362E
	mov	es, word ptr ds:[798h]	;@03632
	cmp	byte ptr ds:[19h], 1	;@03636
	je	@@48	;@0363B
	push	di	;@0363D
	mov	di, word ptr es:[bx]	;@0363E
	mov	bx, word ptr es:[bx+2]	;@03641
	push	di	;@03645
	and	di, 3	;@03646
	shl	di, 1	;@03649
	shl	di, 1	;@0364B
	shl	di, 1	;@0364D
	mov	es, word ptr [di+718h]	;@0364F
	pop	di	;@03653
	mov	di, word ptr es:[di]	;@03654
	mov	word ptr ds:[22Eh], di	;@03657
	mov	es, word ptr ds:[780h]	;@0365B
	mov	di, word ptr es:[bx]	;@0365F
	cmp	di, word ptr ds:[22Eh]	;@03662
	jne	@@46	;@03666
	mov	bx, di	;@03668
	pop	di	;@0366A
	jmp	@@58	;@0366B
@@46:	pop	di	;@0366E
	test	byte ptr ds:[215h], 1	;@0366F
	je	@@47	;@03674
	jmp	DECODE_OVERFLOW	;@03676
@@47:	mov	bx, word ptr es:[bx]	;@03679
	mov	es, word ptr ds:[7A0h]	;@0367C
	mov	bx, word ptr es:[bx+4]	;@03680
	mov	es, word ptr ds:[780h]	;@03684
	mov	di, word ptr es:[di+2]	;@03688
	or	byte ptr ds:[215h], 4	;@0368C
	jmp	@@59	;@03691
@@48:	mov	bx, word ptr es:[bx]	;@03694
	push	bx	;@03697
	and	bx, 3	;@03698
	shl	bx, 1	;@0369B
	shl	bx, 1	;@0369D
	shl	bx, 1	;@0369F
	mov	es, word ptr [bx+718h]	;@036A1
	pop	bx	;@036A5
	mov	bx, word ptr es:[bx]	;@036A6
	or	byte ptr ds:[215h], 10h	;@036A9
	mov	es, word ptr ds:[780h]	;@036AE
	jmp	@@58	;@036B2
@@49:	inc	bx	;@036B5
	jmp	@@45	;@036B6
@@50:	cmp	al, 40h	;@036B9
	je	@@56	;@036BB
	jb	@@53	;@036BD
	jmp	short @@55	;@036BF
@@51:	sub	bx, 4000h	;@036C1
@@52:	dec	bx	;@036C5
	shl	bx, 1	;@036C6
	add	bx, word ptr ds:[52Eh]	;@036C8
	mov	es, word ptr ds:[788h]	;@036CC
	mov	bx, word ptr es:[bx]	;@036D0
	mov	word ptr ds:[21Ah], bx	;@036D3
	push	bx	;@036D7
	and	bx, 3	;@036D8
	shl	bx, 1	;@036DB
	shl	bx, 1	;@036DD
	shl	bx, 1	;@036DF
	mov	es, word ptr [bx+758h]	;@036E1
	pop	bx	;@036E5
	push	word ptr es:[bx+0Ch]	;@036E6
	pop	word ptr ds:[218h]	;@036EA
	test	byte ptr es:[bx+0Eh], 10h	;@036EE
	jne	@@54	;@036F3
	test	byte ptr es:[bx+0Eh], 2	;@036F5
	mov	bx, word ptr es:[bx]	;@036FA
	jne	@@53	;@036FD
	jmp	short @@57	;@036FF
@@53:	or	byte ptr ds:[215h], 2	;@03701
	jmp	short @@59	;@03706
@@54:	jmp	UNDEFINED_SYMBOL	;@03708
@@55:	mov	bx, di	;@0370B
	mov	al, byte ptr ds:[215h]	;@0370D
	test	al, 1	;@03710
	jne	@@53	;@03712
	cmp	byte ptr ds:[19h], 1	;@03714
	je	@@59	;@03719
	test	al, 4	;@0371B
	je	@@59	;@0371D
	jmp	@@40	;@0371F
@@56:	test	byte ptr ds:[215h], 1	;@03722
	jne	@@55	;@03727
	mov	bx, word ptr ds:[3E6h]	;@03729
@@57:	mov	es, word ptr ds:[778h]	;@0372D
	test	byte ptr es:[bx+9], 0E0h	;@03731
	mov	es, word ptr ds:[780h]	;@03736
	mov	bx, word ptr es:[bx]	;@0373A
	je	@@53	;@0373D
@@58:	mov	di, word ptr es:[di]	;@0373F
	mov	es, word ptr ds:[7A0h]	;@03742
	mov	bx, word ptr es:[bx+4]	;@03746
	test	byte ptr ds:[215h], 1	;@0374A
	jne	@@59	;@0374F
	mov	di, word ptr es:[di+4]	;@03751
@@59:	mov	al, byte ptr ds:[215h]	;@03755
	test	al, 3	;@03758
	je	@@60	;@0375A
	jmp	DECODE_NO_FRAME	;@0375C
@@60:	mov	es, word ptr ds:[780h]	;@0375F
	cmp	bx, di	;@03763
	je	@@61	;@03765
	jmp	L03880	;@03767
@@61:	cmp	byte ptr ds:[19h], 0	;@0376A
	je	L03794	;@0376F
	sub	cx, word ptr ds:[21Eh]	;@03771
	push	dx	;@03775
	mov	dx, word ptr ds:[420h]	;@03776
	sbb	dx, word ptr ds:[220h]	;@0377A
	mov	word ptr ds:[420h], dx	;@0377E
	pop	dx	;@03782
	mov	al, 1Ch	;@03783
	and	al, dh	;@03785
	cmp	al, 0Ch	;@03787
	je	@@62	;@03789
	jmp	L0381F	;@0378B
@@62:	call	L030D7	;@0378E
	jmp	L0381F	;@03791
L03794:	sub	cx, word ptr ds:[21Eh]	;@03794
	push	dx	;@03798
	mov	dx, word ptr ds:[420h]	;@03799
	sbb	dx, word ptr ds:[220h]	;@0379D
	mov	word ptr ds:[420h], dx	;@037A1
	pop	dx	;@037A5
	push	dx	;@037A6
	mov	dx, word ptr ds:[21Eh]	;@037A7
	or	dx, word ptr ds:[220h]	;@037AB
	pop	dx	;@037AF
	je	@@1	;@037B0
	push	di	;@037B2
	push	bx	;@037B3
	mov	di, word ptr es:[bx]	;@037B4
	mov	bx, word ptr ds:[3E6h]	;@037B7
	mov	bx, word ptr es:[bx]	;@037BB
	mov	es, word ptr ds:[7A0h]	;@037BE
	mov	bx, word ptr es:[bx+8]	;@037C2
	mov	di, word ptr es:[di+8]	;@037C6
	sub	bx, di	;@037CA
	cmp	bx, 1000h	;@037CC
	pop	bx	;@037D0
	pop	di	;@037D1
	jb	@@1	;@037D2
	jmp	DECODE_OVERFLOW	;@037D4
@@1:	cmp	byte ptr ds:[127h], 0	;@037D7
	je	@@2	;@037DC
	mov	word ptr ds:[21Ch], 0FFFFh	;@037DE
@@2:	mov	es, word ptr ds:[778h]	;@037E4
	mov	di, word ptr es:[bx+2]	;@037E8
	cmp	di, word ptr ds:[450h]	;@037EC
	je	@@3	;@037F0
	cmp	word ptr ds:[21Ch], -1	;@037F2
	je	L0381F	;@037F7
	mov	di, word ptr es:[bx+2]	;@037F9
	cmp	di, word ptr ds:[44Eh]	;@037FD
	je	@@3	;@03801
	cmp	di, word ptr ds:[450h]	;@03803
	jne	L0381F	;@03807
@@3:	test	al, 4	;@03809
	je	@@4	;@0380B
	mov	es, word ptr ds:[780h]	;@0380D
	test	word ptr es:[bx+6], 0FFF0h	;@03811
	je	@@4	;@03817
	call	L03826	;@03819
@@4:	call	FIXUP_BY_LOCATION	;@0381C
L0381F:	mov	di, 3FFh	;@0381F
	and	di, dx	;@03822
	clc	;@03824
	ret	;@03825
L03826:	mov	es, word ptr ds:[780h]	;@03826
	mov	di, word ptr es:[bx]	;@0382A
	mov	es, word ptr ds:[7A0h]	;@0382D
	cmp	byte ptr es:[di+1], 1	;@03831
	jb	@@1	;@03836
	and	byte ptr ds:[215h], 0FBh	;@03838
	mov	di, word ptr es:[di+4]	;@0383D
	mov	es, word ptr ds:[780h]	;@03841
	mov	ax, word ptr es:[bx+6]	;@03845
	and	al, 0F0h	;@03849
	add	cx, ax	;@0384B
	mov	al, byte ptr es:[bx+8]	;@0384D
	mov	ah, 0	;@03851
	adc	word ptr ds:[420h], ax	;@03853
	mov	bx, di	;@03857
	ret	;@03859
@@1:	pop	di	;@0385A
DECODE_OVERFLOW:	jmp	FIXUP_OVERFLOW	;@0385B
DECODE_NO_FRAME:	sub	bp, bp	;@0385E
	and	al, 3	;@03860
	cmp	al, 2	;@03862
	je	DECODE_OVERFLOW	;@03864
	jmp	L0381F	;@03866
DECODE_SAME_FRAME:	cmp	bx, di	;@03868
	jne	L03880	;@0386A
	sub	cx, word ptr ds:[21Eh]	;@0386C
	push	dx	;@03870
	mov	dx, word ptr ds:[420h]	;@03871
	sbb	dx, word ptr ds:[220h]	;@03875
	mov	word ptr ds:[420h], dx	;@03879
	pop	dx	;@0387D
	jmp	L0381F	;@0387E
L03880:	cmp	byte ptr ds:[19h], 0	;@03880
	jne	DECODE_OVERFLOW	;@03885
	cmp	word ptr es:[di+4], -1	;@03887
	jne	DECODE_OVERFLOW	;@0388C
	mov	ax, word ptr es:[bx]	;@0388E
	cmp	ax, word ptr es:[di]	;@03891
	jne	@@2	;@03894
	mov	ax, word ptr es:[di+6]	;@03896
	sub	ax, word ptr es:[bx+6]	;@0389A
	mov	al, byte ptr es:[di+8]	;@0389E
	sbb	al, byte ptr es:[bx+8]	;@038A2
	jb	@@1	;@038A6
	jmp	L03794	;@038A8
@@1:	add	cx, word ptr es:[bx+6]	;@038AB
	sub	cx, word ptr es:[di+6]	;@038AF
	adc	cl, byte ptr es:[bx+8]	;@038B3
	sbb	cl, byte ptr es:[di+8]	;@038B7
	jmp	DECODE_OVERFLOW	;@038BB
@@2:	push	bx	;@038BD
	push	di	;@038BE
	mov	di, word ptr es:[di]	;@038BF
	mov	bx, word ptr es:[bx]	;@038C2
	mov	es, word ptr ds:[7A0h]	;@038C5
	mov	ax, word ptr es:[di+8]	;@038C9
	sub	ax, word ptr es:[bx+8]	;@038CD
	pop	di	;@038D1
	pop	bx	;@038D2
	test	ah, 0F0h	;@038D3
	jne	DECODE_OVERFLOW	;@038D6
	shl	ax, 1	;@038D8
	shl	ax, 1	;@038DA
	shl	ax, 1	;@038DC
	shl	ax, 1	;@038DE
	add	cx, ax	;@038E0
	jb	@@3	;@038E2
	jmp	L03794	;@038E4
@@3:	jmp	DECODE_OVERFLOW	;@038E7
FIXUP_OVERFLOW:	push	dx	;@038EA
	push	si	;@038EB
	push	di	;@038EC
	push	cx	;@038ED
	xor	dx, dx	;@038EE
	mov	ax, word ptr ds:[224h]	;@038F0
	and	ax, 3FFh	;@038F3
	add	ax, word ptr ds:[3E8h]	;@038F6
	adc	dx, word ptr ds:[3EAh]	;@038FA
	mov	si, word ptr ds:[3E6h]	;@038FE
	mov	es, word ptr ds:[780h]	;@03902
	sub	ax, word ptr es:[si+6]	;@03906
	sbb	dl, byte ptr es:[si+8]	;@0390A
	push	ax	;@0390E
	cmp	byte ptr ds:[127h], 0	;@0390F
	je	@@1	;@03914
	push	dx	;@03916
@@1:	mov	si, word ptr ds:[3E6h]	;@03917
	mov	es, word ptr ds:[778h]	;@0391B
	mov	si, word ptr es:[si]	;@0391F
	mov	di, 0C8h	;@03922
	db	0E8h, 18h, 5Eh	; call COPY_NAME	;@03925
	mov	ax, 0C8h	;@03928
	push	ds	;@0392B
	push	ax	;@0392C
	mov	ax, 24A0h	;@0392D
	cmp	byte ptr ds:[127h], 0	;@03930
	je	@@2	;@03935
	mov	ax, 24A6h	;@03937
@@2:	push	cs	;@0393A
	push	ax	;@0393B
	mov	ax, 28h	;@0393C
	push	ds	;@0393F
	push	ax	;@03940
	push	cs	;@03941
	db	0E8h, 0ABh, 81h	; call FORMAT	;@03942
	mov	si, word ptr ds:[218h]	;@03945
	inc	si	;@03949
	je	@@3	;@0394A
	dec	si	;@0394C
	mov	di, 78h	;@0394D
	db	0E8h, 0EDh, 5Dh	; call COPY_NAME	;@03950
	add	sp, 4	;@03953
	jmp	short @@6	;@03956
@@3:	pop	ax	;@03958
	mov	dx, word ptr ds:[420h]	;@03959
	add	ax, word ptr ds:[21Eh]	;@0395D
	adc	dx, word ptr ds:[220h]	;@03961
	pop	si	;@03965
	push	ax	;@03966
	cmp	byte ptr ds:[127h], 0	;@03967
	je	@@4	;@0396C
	push	dx	;@0396E
@@4:	mov	es, word ptr ds:[778h]	;@0396F
	mov	si, word ptr es:[si]	;@03973
	mov	di, 0C8h	;@03976
	db	0E8h, 0C4h, 5Dh	; call COPY_NAME	;@03979
	mov	ax, 0C8h	;@0397C
	push	ds	;@0397F
	push	ax	;@03980
	mov	ax, 24A0h	;@03981
	cmp	byte ptr ds:[127h], 0	;@03984
	je	@@5	;@03989
	mov	ax, 24A6h	;@0398B
@@5:	push	cs	;@0398E
	push	ax	;@0398F
	push	ds	;@03990
	mov	ax, 78h	;@03991
	push	ax	;@03994
	push	cs	;@03995
	db	0E8h, 57h, 81h	; call FORMAT	;@03996
@@6:	mov	ax, 78h	;@03999
	push	ds	;@0399C
	push	ax	;@0399D
	mov	ax, 28h	;@0399E
	push	ds	;@039A1
	push	ax	;@039A2
	mov	ax, 8	;@039A3
	push	ax	;@039A6
	mov	ax, 23h	;@039A7
	push	ax	;@039AA
	mov	word ptr ds:[422h], 1	;@039AB
	db	0E8h, 0F2h, 81h	; call ERROR	;@039B1
	pop	si	;@039B4
	pop	dx	;@039B5
	jmp	short RETURN_CARRY	;@039B6
UNDEFINED_SYMBOL:	test	byte ptr es:[bx+0Eh], 40h	;@039B8
	jne	RETURN_CARRY	;@039BD
	or	byte ptr es:[bx+0Eh], 40h	;@039BF
	mov	bx, word ptr ds:[218h]	;@039C4
	push	bx	;@039C8
	push	si	;@039C9
	mov	si, bx	;@039CA
	mov	di, 28h	;@039CC
	push	ds	;@039CF
	push	di	;@039D0
	push	si	;@039D1
	and	si, 3	;@039D2
	shl	si, 1	;@039D5
	shl	si, 1	;@039D7
	shl	si, 1	;@039D9
	mov	es, word ptr [si+718h]	;@039DB
	pop	si	;@039DF
	cmp	byte ptr es:[si+3], 40h	;@039E0
	je	@@1	;@039E5
	db	0E8h, 56h, 5Dh	; call COPY_NAME	;@039E7
	jmp	short @@2	;@039EA
@@1:	db	0E8h, 0F9h, 5Bh	; call L095E8	;@039EC
@@2:	mov	word ptr ds:[422h], 1	;@039EF
	mov	cx, 4	;@039F5
	push	cx	;@039F8
	mov	ax, 26h	;@039F9
	push	ax	;@039FC
	db	0E8h, 0A6h, 81h	; call ERROR	;@039FD
	pop	si	;@03A00
	pop	bx	;@03A01
RETURN_CARRY:	stc	;@03A02
	ret	;@03A03
COMPARE_DEBUG_KEYS:	push	ax	;@03A04
	push	es	;@03A05
	mov	es, word ptr ds:[375h]	;@03A06
	mov	ax, word ptr es:[si]	;@03A0A
	cmp	ax, word ptr es:[di]	;@03A0D
	jne	@@1	;@03A10
	cmp	si, di	;@03A12
@@1:	pop	es	;@03A14
	pop	ax	;@03A15
	ret	;@03A16
L03A17:	push	bp	;@03A17
	call	SORT_DEBUG_ENTRIES	;@03A18
	mov	bx, 2A0h	;@03A1B
	mov	di, 4DAh	;@03A1E
	mov	cx, word ptr ds:[38Dh]	;@03A21
	mov	ax, word ptr [di+0Eh]	;@03A25
	inc	ax	;@03A28
	jcxz	@@1	;@03A29
	sub	ax, cx	;@03A2B
	xchg	ax, cx	;@03A2D
	jmp	short @@2	;@03A2E
@@1:	xor	cx, cx	;@03A30
@@2:	mov	word ptr [bx+4], ax	;@03A32
	mov	word ptr [bx+6], cx	;@03A35
	mov	ax, word ptr ds:[2A6h]	;@03A38
	and	ax, ax	;@03A3B
	jne	@@3	;@03A3D
	mov	word ptr ds:[2A4h], ax	;@03A3F
@@3:	mov	si, word ptr ds:[365h]	;@03A42
	mov	word ptr ds:[2AEh], si	;@03A46
	mov	si, 2A0h	;@03A4A
	mov	cx, 10h	;@03A4D
	mov	bp, 47Eh	;@03A50
	mov	bx, 30Dh	;@03A53
	call	WRITE_AT	;@03A56
	cmp	word ptr ds:[514h], 0	;@03A59
	je	@@4	;@03A5E
	mov	si, 2B0h	;@03A60
	mov	ax, word ptr ds:[556h]	;@03A63
	mov	word ptr [si+2], ax	;@03A66
	mov	ax, word ptr ds:[554h]	;@03A69
	mov	word ptr [si+6], ax	;@03A6C
	add	word ptr ds:[3A1h], ax	;@03A6F
	mov	cx, 8	;@03A73
	mov	bp, 47Eh	;@03A76
	mov	bx, 345h	;@03A79
	call	WRITE_AT	;@03A7C
@@4:	mov	ax, word ptr ds:[4E4h]	;@03A7F
	sub	ax, 17h	;@03A82
	mov	bx, word ptr ds:[38Fh]	;@03A85
	mov	word ptr ds:[38Fh], ax	;@03A89
	sub	ax, bx	;@03A8C
	xor	dx, dx	;@03A8E
	shl	ax, 1	;@03A90
	rcl	dx, 1	;@03A92
	shl	ax, 1	;@03A94
	rcl	dx, 1	;@03A96
	shl	ax, 1	;@03A98
	rcl	dx, 1	;@03A9A
	add	word ptr ds:[321h], ax	;@03A9C
	adc	word ptr ds:[323h], dx	;@03AA0
	cmp	word ptr ds:[550h], 0	;@03AA4
	jne	@@5	;@03AA9
	jmp	@@12	;@03AAB
@@5:	cmp	word ptr ds:[365h], 0	;@03AAE
	jne	@@6	;@03AB3
	jmp	@@12	;@03AB5
@@6:	mov	cx, word ptr ds:[365h]	;@03AB8
	cmp	cx, 1	;@03ABC
	jbe	@@7	;@03ABF
	shl	cx, 1	;@03AC1
	mov	bp, 3A04h	;@03AC3
	mov	es, word ptr ds:[379h]	;@03AC6
	db	0E8h, 90h, 54h	; call SORT	;@03ACA
@@7:	mov	ax, word ptr ds:[4F8h]	;@03ACD
	inc	ax	;@03AD0
	mov	cx, word ptr ds:[365h]	;@03AD1
	add	word ptr ds:[4F8h], cx	;@03AD5
	xor	si, si	;@03AD9
@@8:	mov	es, word ptr ds:[379h]	;@03ADB
	mov	di, word ptr es:[si]	;@03ADF
	mov	es, word ptr ds:[375h]	;@03AE2
	mov	bx, word ptr es:[di]	;@03AE6
	mov	bp, bx	;@03AE9
	dec	bx	;@03AEB
	shl	bx, 1	;@03AEC
	shl	bx, 1	;@03AEE
	shl	bx, 1	;@03AF0
	shl	bx, 1	;@03AF2
	mov	es, word ptr ds:[371h]	;@03AF4
	mov	word ptr es:[bx+0Ch], ax	;@03AF8
	mov	es, word ptr ds:[375h]	;@03AFC
	push	ds	;@03B00
	mov	ds, word ptr ds:[379h]	;@03B01
	mov	dx, 1	;@03B05
	dec	cx	;@03B08
	je	@@10	;@03B09
@@9:	inc	si	;@03B0B
	inc	si	;@03B0C
	mov	di, word ptr [si]	;@03B0D
	cmp	bp, word ptr es:[di]	;@03B0F
	jne	@@10	;@03B12
	inc	dx	;@03B14
	loop	@@9	;@03B15
@@10:	pop	ds	;@03B17
	mov	es, word ptr ds:[371h]	;@03B18
	mov	word ptr es:[bx+0Eh], dx	;@03B1C
	add	ax, dx	;@03B20
	inc	cx	;@03B22
	loop	@@8	;@03B23
	mov	cx, word ptr ds:[365h]	;@03B25
	xor	bx, bx	;@03B29
@@11:	push	bx	;@03B2B
	push	cx	;@03B2C
	mov	es, word ptr ds:[379h]	;@03B2D
	mov	si, word ptr es:[bx]	;@03B31
	mov	cx, 8	;@03B34
	mov	bx, 331h	;@03B37
	mov	bp, 375h	;@03B3A
	call	WRITE_AT	;@03B3D
	pop	cx	;@03B40
	pop	bx	;@03B41
	add	bx, 2	;@03B42
	loop	@@11	;@03B45
@@12:	mov	cx, word ptr ds:[55Eh]	;@03B47
	jcxz	@@13	;@03B4B
	jmp	short @@14	;@03B4D
@@13:	jmp	@@18	;@03B4F
@@14:	xor	si, si	;@03B52
	xor	di, di	;@03B54
	push	cx	;@03B56
@@15:	mov	es, word ptr ds:[3B8h]	;@03B57
	mov	word ptr es:[di], si	;@03B5B
	mov	es, word ptr ds:[3B4h]	;@03B5E
	mov	dx, word ptr es:[si+2]	;@03B62
	shl	dx, 1	;@03B66
	add	si, 4	;@03B68
	add	si, dx	;@03B6B
	inc	di	;@03B6D
	inc	di	;@03B6E
	loop	@@15	;@03B6F
	pop	cx	;@03B71
	push	cx	;@03B72
	mov	bp, 43EEh	;@03B73
	shl	cx, 1	;@03B76
	mov	es, word ptr ds:[3B8h]	;@03B78
	db	0E8h, 0DEh, 53h	; call SORT	;@03B7C
	pop	cx	;@03B7F
	xor	di, di	;@03B80
	mov	dx, 0FFFFh	;@03B82
@@16:	push	cx	;@03B85
	mov	es, word ptr ds:[3B8h]	;@03B86
	mov	si, word ptr es:[di]	;@03B8A
	mov	es, word ptr ds:[3B4h]	;@03B8D
	mov	bx, word ptr es:[si]	;@03B91
	cmp	bx, dx	;@03B94
	je	@@17	;@03B96
	push	si	;@03B98
	mov	dx, bx	;@03B99
	push	dx	;@03B9B
	call	L02A24	;@03B9C
	xor	dx, dx	;@03B9F
	mov	ax, si	;@03BA1
	mov	bx, 10h	;@03BA3
	div	bx	;@03BA6
	shl	ax, 1	;@03BA8
	mov	bx, 47Eh	;@03BAA
	mov	si, 3C4h	;@03BAD
	mov	dx, word ptr ds:[3C0h]	;@03BB0
	add	ax, word ptr ds:[3BEh]	;@03BB4
	mov	cx, 2	;@03BB8
	push	di	;@03BBB
	db	0E8h, 46h, 4Dh	; call L08905	;@03BBC
	pop	di	;@03BBF
	pop	dx	;@03BC0
	pop	si	;@03BC1
@@17:	push	dx	;@03BC2
	inc	si	;@03BC3
	inc	si	;@03BC4
	mov	es, word ptr ds:[3B4h]	;@03BC5
	mov	cx, word ptr es:[si]	;@03BC9
	add	word ptr ds:[3C4h], cx	;@03BCC
	shl	cx, 1	;@03BD0
	inc	si	;@03BD2
	inc	si	;@03BD3
	mov	bx, 3B4h	;@03BD4
	mov	dx, word ptr ds:[3BCh]	;@03BD7
	mov	ax, word ptr ds:[3BAh]	;@03BDB
	add	word ptr ds:[3BAh], cx	;@03BDE
	adc	word ptr ds:[3BCh], 0	;@03BE2
	push	di	;@03BE7
	db	0E8h, 1Ah, 4Dh	; call L08905	;@03BE8
	pop	di	;@03BEB
	pop	dx	;@03BEC
	pop	cx	;@03BED
	inc	di	;@03BEE
	inc	di	;@03BEF
	loop	@@16	;@03BF0
	mov	word ptr ds:[3B2h], 0	;@03BF2
@@18:	pop	bp	;@03BF8
	ret	;@03BF9
	db	0FEh, 6, 94h, 4, 0E8h, 52h, 0F4h, 8Ah, 4, 3Ch, 0C1h, 74h, 3, 0E9h	;@03BFA
	db	9Fh, 0, 83h, 3Eh, 0B2h, 4, 0FFh, 74h, 3, 0E9h, 95h, 0, 46h, 0BAh
	db	0, 0CCh, 0E8h, 0B1h, 0F6h, 8Eh, 6, 78h, 7, 56h, 8Bh, 0F3h, 0E8h
	db	'wV^<', 2, 7Ch, 0Ah, 33h, 0C9h, 51h, 0B8h, 27h, 0, 50h, 0E8h, 72h
	db	7Fh, 8Eh, 6, 80h, 7, 26h, 8Bh, 47h, 6, 26h, 8Bh, 1Fh, 8Eh, 6, 0A0h
	db	7, 80h, 3Eh, 19h, 0, 0, 74h, 6, 26h, 8Bh, 5Fh, 6, 0EBh, 13h, 26h
	db	8Bh, 5Fh, 8, 0F6h, 6, 15h, 2, 4, 74h, 8, 51h, 0B1h, 4, 0D3h, 0E8h
	db	3, 0D8h, 59h, 89h, 0Eh, 0B0h, 4, 89h, 1Eh, 0B2h, 4, 89h, 0Eh, 0B3h
	db	6, 89h, 1Eh, 0B5h, 6, 80h, 3Eh, 2Bh, 1, 1, 75h, 19h, 23h, 0DBh
	db	75h, 0Bh, 81h, 0F9h, 0, 1, 74h, 0Fh, 0E8h, 2, 54h, 75h, 0Ah, 33h
	db	0C0h, 50h, 0B8h, 15h, 0, 50h, 0E8h, 0Eh, 7Fh
BAD_ENTRY_OFFSET:	cmp	word ptr ds:[420h], 0	;@03C93
	je	@@1	;@03C98
	xor	ax, ax	;@03C9A
	push	ax	;@03C9C
	mov	ax, 29h	;@03C9D
	push	ax	;@03CA0
	db	0E8h, 2, 7Fh	; call ERROR	;@03CA1
	or	byte ptr ds:[410h], 1	;@03CA4
@@1:	cmp	byte ptr ds:[16h], 0	;@03CA9
	je	MODEND_START	;@03CAE
	call	L03A17	;@03CB0
MODEND_START:	cmp	byte ptr ds:[3D2h], 1	;@03CB3
	jb	@@4	;@03CB8
	je	@@1	;@03CBA
	mov	di, word ptr ds:[3E2h]	;@03CBC
	push	di	;@03CC0
	and	di, 3	;@03CC1
	shl	di, 1	;@03CC4
	shl	di, 1	;@03CC6
	shl	di, 1	;@03CC8
	mov	es, word ptr [di+738h]	;@03CCA
	pop	di	;@03CCE
	cmp	word ptr es:[di+0Ah], 2	;@03CCF
	jae	@@1	;@03CD4
	mov	di, word ptr ds:[228h]	;@03CD6
	db	0E9h, 31h, 50h	; jmp L08D0E	;@03CDA
@@1:	mov	si, word ptr ds:[3E0h]	;@03CDD
	inc	si	;@03CE1
	push	ds	;@03CE2
	pop	es	;@03CE3
@@2:	mov	cx, word ptr ds:[5258h]	;@03CE4
	sub	cx, si	;@03CE8
	cmp	cx, 2	;@03CEA
	jae	@@3	;@03CED
	db	0E8h, 2Fh, 49h	; call L08621	;@03CEF
	jmp	@@2	;@03CF2
@@3:	sub	ax, ax	;@03CF4
	mov	di, si	;@03CF6
	shr	cx, 1	;@03CF8
	repe scasw	;@03CFA
	mov	si, di	;@03CFC
	je	@@2	;@03CFE
	dec	si	;@03D00
	dec	si	;@03D01
	cmp	byte ptr [si], 1	;@03D02
	adc	si, ax	;@03D05
	db	0E9h, 0D0h, 1Ah	; jmp L057DA	;@03D07
@@4:	ret	;@03D0A
WRITE_LINE_NUMBERS:	push	si	;@03D0B
	cmp	word ptr ds:[39Bh], -1	;@03D0C
	jne	@@1	;@03D11
	push	ax	;@03D13
	push	cx	;@03D14
	push	dx	;@03D15
	push	si	;@03D16
	mov	word ptr ds:[17Ah], 0FFFFh	;@03D17
	mov	ax, word ptr ds:[22Ah]	;@03D1D
	call	L02DD2	;@03D20
	pop	si	;@03D23
	pop	dx	;@03D24
	pop	cx	;@03D25
	pop	ax	;@03D26
@@1:	push	bx	;@03D27
	mov	bx, word ptr ds:[3E0h]	;@03D28
	sub	bx, si	;@03D2C
	shr	bx, 1	;@03D2E
	shr	bx, 1	;@03D30
	or	dx, dx	;@03D32
	je	@@2	;@03D34
	add	sp, 2	;@03D36
	cmp	dx, word ptr ds:[17Ah]	;@03D39
	jne	@@3	;@03D3D
	mov	si, word ptr ds:[385h]	;@03D3F
	sub	si, 8	;@03D43
	mov	es, word ptr ds:[375h]	;@03D46
	jmp	short @@5	;@03D4A
@@2:	pop	dx	;@03D4C
	push	ax	;@03D4D
	push	bx	;@03D4E
	push	cx	;@03D4F
	mov	word ptr ds:[393h], 0FFFFh	;@03D50
	mov	word ptr ds:[17Ah], 0FFFFh	;@03D56
	mov	bx, dx	;@03D5C
	jmp	short @@4	;@03D5E
@@3:	mov	word ptr ds:[17Ah], dx	;@03D60
	push	ax	;@03D64
	push	bx	;@03D65
	push	cx	;@03D66
	mov	bx, dx	;@03D67
	mov	word ptr ds:[393h], bx	;@03D69
	dec	bx	;@03D6D
	xchg	ax, bx	;@03D6E
	mov	ah, 0Ah	;@03D6F
	mul	ah	;@03D71
	xchg	ax, bx	;@03D73
	add	bx, word ptr ds:[52Ch]	;@03D74
@@4:	call	L02A24	;@03D78
	mov	si, word ptr ds:[385h]	;@03D7B
	add	word ptr ds:[385h], 8	;@03D7F
	mov	es, word ptr ds:[375h]	;@03D84
	mov	word ptr es:[si], ax	;@03D88
	mov	ax, word ptr ds:[39Bh]	;@03D8B
	mov	word ptr es:[si+2], ax	;@03D8E
	mov	ax, word ptr ds:[4F2h]	;@03D92
	inc	ax	;@03D95
	mov	word ptr es:[si+4], ax	;@03D96
	mov	word ptr es:[si+6], 0	;@03D9A
	push	es	;@03DA0
	mov	es, word ptr ds:[379h]	;@03DA1
	mov	di, word ptr ds:[387h]	;@03DA5
	mov	ax, si	;@03DA9
	stosw	;@03DAB
	mov	word ptr ds:[387h], di	;@03DAC
	pop	es	;@03DB0
	pop	cx	;@03DB1
	pop	bx	;@03DB2
	pop	ax	;@03DB3
	inc	word ptr ds:[365h]	;@03DB4
@@5:	add	word ptr es:[si+6], bx	;@03DB8
	add	word ptr ds:[4F2h], bx	;@03DBC
	xchg	cx, bx	;@03DC0
	pop	si	;@03DC2
	mov	dx, si	;@03DC3
	inc	si	;@03DC5
	inc	si	;@03DC6
	push	cx	;@03DC7
@@6:	add	word ptr [si], bx	;@03DC8
	add	si, 4	;@03DCA
	loop	@@6	;@03DCD
	mov	si, dx	;@03DCF
	pop	cx	;@03DD1
	shl	cx, 1	;@03DD2
	shl	cx, 1	;@03DD4
	mov	bp, 47Eh	;@03DD6
	mov	bx, 315h	;@03DD9
	call	WRITE_AT	;@03DDC
	mov	si, word ptr ds:[3E0h]	;@03DDF
	ret	;@03DE3
	db	80h, '>xR', 0, 75h, 7, 80h, 3Eh, 17h, 0, 0, 75h, 0Ah, 80h, 3Eh	;@03DE4
	db	21h, 1, 1, 74h, 3, 0E9h, 0D5h, 19h, 80h, 3Ch, 80h, 83h, 0DEh, 0FEh
	db	2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh, 8Ah
	db	1Ch, 46h, 81h, 0FBh, 0, 40h, 7Eh, 3, 0E9h, 11h, 1, 8Bh, 0D3h, 4Bh
	db	93h, 0B4h, 0Ah, 0F6h, 0E4h, 93h, 3, 1Eh, 2Ch, 5, 8Eh, 6, 80h, 7
	db	26h, 8Bh, 4Fh, 6, 26h, 8Bh, 3Fh, 33h, 0EDh, 80h, 3Eh, 27h, 1, 0
	db	74h, 8, 95h, 26h, 8Ah, 47h, 8, 0B4h, 0, 95h, 8Eh, 6, 0A0h, 7, 26h
	db	8Bh, 45h, 8, 80h, 3Eh, 19h, 0, 0, 74h, 4, 26h, 8Bh, 45h, 6, 80h
	db	3Eh, 17h, 0, 0, 74h, 1Eh, 80h, '>xR', 0, 75h, 0Dh, 'PSVU', 0E8h
	db	0A0h, 0FEh, ']^[X3', 0C9h, 80h, 3Eh, 21h, 1, 1, 74h, 3, 0E9h, 56h
	db	19h, 8Bh, 0D0h, 8Bh, 3Eh, 41h, 0B4h, 3Bh, 1Eh, 26h, 2, 89h, 1Eh
	db	26h, 2, 't@V', 0E8h, 51h, 57h, 11h, 'Line numbers for ', 0E8h
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
	db	2Bh, 3Eh, 0E8h, 3
L03FD1:	push	es	;@03FD1
	push	si	;@03FD2
	push	di	;@03FD3
	push	ax	;@03FD4
	push	bx	;@03FD5
	push	cx	;@03FD6
	push	dx	;@03FD7
	mov	si, word ptr ds:[3E6h]	;@03FD8
	mov	es, word ptr ds:[780h]	;@03FDC
	mov	si, word ptr es:[si]	;@03FE0
	mov	es, word ptr ds:[7A0h]	;@03FE3
	mov	ax, word ptr es:[si+0Dh]	;@03FE7
	mov	dx, word ptr es:[si+11h]	;@03FEB
	inc	word ptr es:[si+11h]	;@03FEF
	db	0E8h, 88h, 1Ah	; call L05A7E	;@03FF3
	mov	bx, word ptr es:[si+8]	;@03FF6
	mov	cl, byte ptr es:[si+0Ah]	;@03FFA
	mov	ch, 0	;@03FFE
	add	bx, word ptr ds:[3FEh]	;@04000
	adc	cl, ch	;@04004
	shl	bx, 1	;@04006
	rcl	cx, 1	;@04008
	shl	bx, 1	;@0400A
	rcl	cx, 1	;@0400C
	shl	bx, 1	;@0400E
	rcl	cx, 1	;@04010
	shl	bx, 1	;@04012
	rcl	cx, 1	;@04014
	add	ax, bx	;@04016
	adc	dx, cx	;@04018
	mov	cx, word ptr ds:[400h]	;@0401A
	mov	si, word ptr ds:[402h]	;@0401E
	db	0E8h, 38h, 49h	; call L0895D	;@04022
	pop	dx	;@04025
	pop	cx	;@04026
	pop	bx	;@04027
	pop	ax	;@04028
	pop	di	;@04029
	pop	si	;@0402A
	pop	es	;@0402B
	ret	;@0402C
ADD_RELOCATION:	test	byte ptr ds:[215h], 1	;@0402D
	je	@@2	;@04032
	ret	;@04034
@@1:	xor	ax, ax	;@04035
	push	ax	;@04037
	mov	ax, 16h	;@04038
	push	ax	;@0403B
	db	0E8h, 62h, 7Bh	; call FATAL	;@0403C
@@2:	cmp	byte ptr ds:[12Bh], 1	;@0403F
	je	@@1	;@04044
	inc	word ptr ds:[4A2h]	;@04046
	push	ax	;@0404A
	push	bx	;@0404B
	push	cx	;@0404C
	push	dx	;@0404D
	push	si	;@0404E
	push	di	;@0404F
	push	bp	;@04050
	cmp	word ptr ds:[3ECh], 0	;@04051
	je	@@3	;@04056
	xor	bx, bx	;@04058
	add	di, word ptr ds:[3E8h]	;@0405A
	adc	bx, word ptr ds:[3EAh]	;@0405E
	je	@@4	;@04062
	mov	word ptr ds:[422h], 1	;@04064
	xor	ax, ax	;@0406A
	push	ax	;@0406C
	mov	ax, 18h	;@0406D
	push	ax	;@04070
	db	0E8h, 2Dh, 7Bh	; call FATAL	;@04071
@@3:	add	di, word ptr ds:[3E8h]	;@04074
@@4:	mov	word ptr ds:[498h], di	;@04078
	mov	di, word ptr ds:[3EEh]	;@0407C
	mov	word ptr ds:[49Ah], di	;@04080
	mov	ax, word ptr ds:[3F2h]	;@04084
	mov	dx, word ptr ds:[3F4h]	;@04087
	mov	cx, 4	;@0408B
	add	word ptr ds:[3F2h], cx	;@0408E
	adc	word ptr ds:[3F4h], 0	;@04092
	mov	si, 498h	;@04097
	db	0E8h, 0C0h, 48h	; call L0895D	;@0409A
	pop	bp	;@0409D
	pop	di	;@0409E
	pop	si	;@0409F
	pop	dx	;@040A0
	pop	cx	;@040A1
	pop	bx	;@040A2
	pop	ax	;@040A3
	ret	;@040A4
	db	0E9h, 0BEh, 0, 0E9h, 26h, 17h, 98h, 8Bh, 0F8h, 83h, 0E7h, 3, 0A8h	;@040A5
	db	'@u2', 0D0h, 0E8h, 0D0h, 0E8h, 24h, 3, 88h, 85h, 32h, 2, 0D1h
	db	0E7h, 3Ch, 3, 74h, 16h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh
	db	80h, 8Ah, 0FBh, 8Ah, 1Ch, 46h, 89h, 9Dh, 36h, 2, 0E9h, 8Bh, 0
	db	8Bh, 1Ch, 83h, 0C6h, 2, 89h, 9Dh, 36h, 2, 0E9h, 7Fh, 0, 0D0h, 0E0h
	db	0D0h, 0E0h, 24h, 7, 88h, 85h, 3Eh, 2, 0D1h, 0E7h, 3Ch, 3, 74h
	db	15h, 2Bh, 0DBh, 2, 1Ch, 7Dh, 8, 46h, 80h, 0EBh, 80h, 8Ah, 0FBh
	db	8Ah, 1Ch, 46h, 89h, 9Dh, 42h, 2, 0EBh, 5Ah, 8Bh, 1Ch, 83h, 0C6h
	db	2, 89h, 9Dh, 42h, 2, 0EBh, 4Fh, 83h, 0FBh, 0FDh, 74h, 15h, 80h
	db	0FEh, 4, 't*r"', 80h, 0FEh, 10h, 77h, 2, 74h, 19h, 8Eh, 6, 80h
	db	7, 26h, 8Bh, 1Fh, 0E8h, 0B8h, 57h, 0EBh, 30h, 1, 8Dh, 50h, 0Ah
	db	0A1h, 20h, 4, 11h, 85h, 52h, 0Ah, 0EBh, 23h, 8Ah, 0CDh, 0, 8Dh
	db	50h, 0Ah, 0EBh, 1Bh, 1, 8Dh, 50h, 0Ah, 0F6h, 6, 15h, 2, 40h, 74h
	db	10h, 0E8h, 4Dh, 57h, 0EBh, 0Bh, 83h, 3Eh, 1Eh, 4, 1, 74h, 0D4h
	db	1, 8Dh, 50h, 0Ah, 3Bh, 36h, 0E0h, 3, 72h, 3, 0E9h, 39h, 0FFh, 0ACh
	db	0A8h, 80h, 75h, 3, 0E9h, 34h, 0FFh, 80h, 3Eh, 0F1h, 3, 0FFh, 75h
	db	3, 0E9h, 27h, 0FFh, 8Ah, 0F0h, 8Ah, 14h, 46h, 0E8h, 43h, 0F1h
	db	72h, 0DBh, 80h, 0E6h, 1Ch, 80h, 3Eh, 19h, 0, 0, 75h, 82h, 80h
	db	0FEh, 4, 74h, 0C1h, 72h, 0A9h, 80h, 0FEh, 10h, 'w7t', 0A0h, 8Eh
	db	6, 80h, 7, 80h, 0FEh, 8, 74h, 62h, 83h, 3Eh, 1Eh, 4, 1, 74h, 13h
	db	1, 8Dh, 50h, 0Ah, 47h, 47h, 0C7h, 6, 16h, 2, 0FFh, 0FFh, 80h, 0Eh
	db	15h, 2, 8, 0EBh, 54h, 1, 8Dh, 50h, 0Ah, 50h, 0A1h, 20h, 4, 1, 85h
	db	52h, 0Ah, 58h, 83h, 0C7h, 4, 0EBh, 0E1h, 80h, 3Eh, 27h, 1, 0, 75h
	db	0Bh, 80h, 0FEh, 14h, 75h, 3, 0E9h, 74h, 0FFh, 0E9h, 7Ch, 0FFh
	db	1, 8Dh, 50h, 0Ah, 50h, 0A1h, 20h, 4, 1, 85h, 52h, 0Ah, 58h, 83h
	db	0C7h, 4, 80h, 0FEh, 14h, 75h, 3, 0E9h, 64h, 0FFh, 8Eh, 6, 80h
	db	7, 0C7h, 6, 16h, 2, 0FFh, 0FFh, 0EBh, 0Ch, 0F7h, 6, 11h, 4, 1
	db	0, 75h, 4, 89h, 1Eh, 16h, 2, 56h, 8Bh, 36h, 0E6h, 3, 26h, 8Bh
	db	54h, 4, 0F6h, 6, 15h, 2, 1, 75h, 0Bh, 26h, 8Bh, 4Fh, 6, 26h, 8Bh
	db	37h, 8Eh, 6, 0A0h, 7, 83h, 0FAh, 0FFh, 74h, 42h, 0C7h, 6, 22h
	db	2, 0C5h, 3Fh, 0F6h, 6, 15h, 2, 4, 74h, 15h, '&;\', 4, 74h, 0Fh
	db	83h, 0C6h, 14h, 3Bh, 36h, 9Eh, 7, 72h, 0F1h, 0B8h, 1, 0, 0E8h
	db	0CDh, 50h, 26h, 8Bh, 5Ch, 6, 4Bh, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 5Eh, 3Bh, 16h, 16h, 2, 75h, 5, 80h, 0CBh, 1, 0EBh, 30h, 0F6h
	db	6, 15h, 2, 8, 74h, 29h, 0EBh, 27h, 0C7h, 6, 22h, 2, 2Dh, 40h, 0F6h
	db	6, 15h, 2, 1, 'u6&', 80h, 7Ch, 0Ah, 0, 'u%&', 8Bh, 5Ch, 8, 5Eh
	db	0F6h, 6, 15h, 2, 4, 74h, 7, 91h, 0B1h, 4, 0D3h, 0E8h, 3, 0D8h
	db	1, 9Dh, 50h, 0Ah, 80h, 3Eh, 0F1h, 3, 1, 74h, 14h, 0FFh, 16h, 22h
	db	2, 0E9h, 0B1h, 0FEh, 33h, 0C0h, 50h, 0B8h, 22h, 0, 50h, 0E8h, 0E2h
	db	78h, 5Eh, 0EBh, 0E1h, 0E8h, 0A6h, 0FCh, 0E9h, 9Eh, 0FEh
START_DATA_RECORD:	push	bp	;@042C8
	mov	bp, sp	;@042C9
	lea	sp, [bp-4]	;@042CB
	mov	word ptr [bp-2], ax	;@042CE
	mov	al, byte ptr es:[bx+8]	;@042D1
	mov	ah, 0	;@042D5
	mov	word ptr [bp-4], ax	;@042D7
	mov	word ptr ds:[3E6h], bx	;@042DA
	mov	bx, word ptr es:[bx]	;@042DE
	mov	es, word ptr ds:[7A0h]	;@042E1
	mov	ax, word ptr es:[bx+8]	;@042E5
	mov	word ptr ds:[3EEh], ax	;@042E9
	mov	dl, byte ptr es:[bx+0Ah]	;@042EC
	mov	byte ptr ds:[3F0h], dl	;@042F0
	lodsw	;@042F4
	xor	dx, dx	;@042F5
	mov	cx, word ptr ds:[41Eh]	;@042F7
	mov	word ptr ds:[3ECh], cx	;@042FB
	jcxz	@@1	;@042FF
	xchg	ax, dx	;@04301
	lodsw	;@04302
	xchg	ax, dx	;@04303
@@1:	add	ax, word ptr [bp-2]	;@04304
	adc	dx, word ptr [bp-4]	;@04307
	mov	word ptr ds:[3EAh], dx	;@0430A
	mov	word ptr ds:[3E8h], ax	;@0430E
	mov	cx, word ptr ds:[3E0h]	;@04311
	sub	cx, si	;@04315
	mov	word ptr ds:[3E4h], cx	;@04317
	push	ds	;@0431B
	pop	es	;@0431C
	mov	di, 0A50h	;@0431D
	shr	cx, 1	;@04320
	rep movsw	;@04322
	rcl	cx, 1	;@04324
	rep movsb	;@04326
	mov	sp, bp	;@04328
	pop	bp	;@0432A
	ret	;@0432B
P2_LEDATA:	call	L03053	;@0432C
	mov	byte ptr ds:[3F1h], 0	;@0432F
	sub	bx, bx	;@04334
	add	bl, byte ptr [si]	;@04336
	jge	@@1	;@04338
	inc	si	;@0433A
	sub	bl, 80h	;@0433B
	mov	bh, bl	;@0433E
	mov	bl, byte ptr [si]	;@04340
@@1:	inc	si	;@04342
	cmp	bx, 4000h	;@04343
	jle	L043AE	;@04347
L04349:	sub	bx, 4001h	;@04349
	shl	bx, 1	;@0434D
	add	bx, word ptr ds:[52Eh]	;@0434F
	mov	es, word ptr ds:[788h]	;@04353
	mov	bx, word ptr es:[bx]	;@04357
	push	bx	;@0435A
	and	bx, 3	;@0435B
	shl	bx, 1	;@0435E
	shl	bx, 1	;@04360
	shl	bx, 1	;@04362
	mov	es, word ptr [bx+758h]	;@04364
	pop	bx	;@04368
	mov	ax, word ptr es:[bx+2]	;@04369
	cmp	ax, word ptr ds:[228h]	;@0436D
	jne	@@2	;@04371
	mov	ax, word ptr es:[bx+4]	;@04373
	mov	bx, word ptr es:[bx]	;@04377
	mov	word ptr ds:[168h], bx	;@0437A
	mov	es, word ptr ds:[780h]	;@0437E
	call	START_DATA_RECORD	;@04382
@@1:	db	0E9h, 49h, 14h	; jmp L057D1	;@04385
@@2:	mov	byte ptr ds:[3F1h], 0FFh	;@04388
	jmp	@@1	;@0438D
P2_LIDATA:	call	L03053	;@0438F
	mov	byte ptr ds:[3F1h], 1	;@04392
	sub	bx, bx	;@04397
	add	bl, byte ptr [si]	;@04399
	jge	@@1	;@0439B
	inc	si	;@0439D
	sub	bl, 80h	;@0439E
	mov	bh, bl	;@043A1
	mov	bl, byte ptr [si]	;@043A3
@@1:	inc	si	;@043A5
	cmp	bx, 4000h	;@043A6
	jle	L043AE	;@043AA
	jmp	L04349	;@043AC
L043AE:	dec	bx	;@043AE
	xchg	ax, bx	;@043AF
	mov	ah, 0Ah	;@043B0
	mul	ah	;@043B2
	xchg	ax, bx	;@043B4
	add	bx, word ptr ds:[52Ch]	;@043B5
	mov	word ptr ds:[168h], bx	;@043B9
	mov	es, word ptr ds:[778h]	;@043BD
	test	byte ptr es:[bx+9], 0E0h	;@043C1
	je	@@2	;@043C6
	cmp	byte ptr es:[bx+9], 0FFh	;@043C8
	je	@@2	;@043CD
	mov	ax, word ptr es:[bx+2]	;@043CF
	cmp	ax, word ptr ds:[436h]	;@043D3
	je	@@2	;@043D7
	mov	es, word ptr ds:[780h]	;@043D9
	mov	ax, word ptr es:[bx+6]	;@043DD
	call	START_DATA_RECORD	;@043E1
@@1:	db	0E9h, 0EAh, 13h	; jmp L057D1	;@043E4
@@2:	mov	byte ptr ds:[3F1h], 0FFh	;@043E7
	jmp	@@1	;@043EC
COMPARE_KEYS:	push	ax	;@043EE
	mov	es, word ptr ds:[3B4h]	;@043EF
	mov	ax, word ptr es:[si]	;@043F3
	cmp	ax, word ptr es:[di]	;@043F6
	je	@@3	;@043F9
	jb	@@2	;@043FB
	clc	;@043FD
@@1:	mov	es, word ptr ds:[3B8h]	;@043FE
	pop	ax	;@04402
	ret	;@04403
@@2:	stc	;@04404
	jmp	@@1	;@04405
@@3:	cmp	si, di	;@04407
	jmp	@@1	;@04409
	db	0C3h, 0, 0, 0, 0, 1, 5, 28h, 2, 6, 48h, 3, 7, 48h, 0, 0, 0, 0E0h	;@0440B
	db	5, 28h, 0E1h, 6, 48h, 0, 0, 0, 0, 0, 0, ',D1D'
NAME_TEXT:	pop	di	;@0442C
	push	sp	;@0442D
	inc	bp	;@0442E
	pop	ax	;@0442F
	push	sp	;@04430
NAME_DATA:	pop	di	;@04431
	inc	sp	;@04432
	inc	cx	;@04433
	push	sp	;@04434
	inc	cx	;@04435
	mov	word ptr ds:[259h], dx	;@04436
	mov	word ptr ds:[25Bh], cx	;@0443A
	lodsw	;@0443E
	cmp	ax, 80h	;@0443F
	jae	@@2	;@04442
	shl	ax, 1	;@04444
	xchg	al, ah	;@04446
	mov	word ptr ds:[25Dh], ax	;@04448
	mov	word ptr ds:[280h], ax	;@0444B
	add	dx, ax	;@0444E
	adc	cx, 0	;@04450
	mov	ax, word ptr ds:[250h]	;@04453
	mov	bx, word ptr ds:[252h]	;@04456
	or	bx, bx	;@0445A
	jne	@@1	;@0445C
	cmp	ax, 4000h	;@0445E
	jb	@@2	;@04461
@@1:	sub	ax, dx	;@04463
	sbb	bx, cx	;@04465
	jne	@@2	;@04467
	and	ax, ax	;@04469
	je	@@2	;@0446B
	mov	word ptr ds:[268h], ax	;@0446D
	add	ax, word ptr ds:[25Dh]	;@04470
	mov	word ptr ds:[260h], ax	;@04474
	jae	@@4	;@04477
@@2:	stc	;@04479
	ret	;@0447A
@@3:	mov	dx, word ptr ds:[255h]	;@0447B
	mov	cx, word ptr ds:[257h]	;@0447F
	mov	ax, 4200h	;@04483
	mov	bx, word ptr ds:[26h]	;@04486
	call	DOS_CALL	;@0448A
	mov	byte ptr ds:[254h], 1	;@0448D
	jmp	@@2	;@04492
@@4:	mov	ax, word ptr ds:[5258h]	;@04494
	sub	ax, 1250h	;@04497
	sub	dx, dx	;@0449A
	mov	word ptr ds:[255h], ax	;@0449C
	mov	word ptr ds:[257h], dx	;@0449F
	mov	ax, 4200h	;@044A3
	mov	bx, word ptr ds:[26h]	;@044A6
	mov	dx, word ptr ds:[259h]	;@044AA
	mov	cx, word ptr ds:[25Bh]	;@044AE
	call	DOS_CALL	;@044B2
	jb	@@3	;@044B5
	push	ds	;@044B7
	mov	ax, 282h	;@044B8
	push	ax	;@044BB
	push	word ptr ds:[260h]	;@044BC
	cmp	byte ptr ds:[25Fh], 1	;@044C0
	je	@@5	;@044C5
	db	9Ah, 18h, 15h, 0DFh, 0	; lcall 0xdf, 0x1518	;@044C7
	jmp	short @@6	;@044CC
@@5:	db	9Ah, 0CAh, 2Dh, 0DFh, 0	; lcall 0xdf, 0x2dca	;@044CE
@@6:	and	ax, ax	;@044D3
	jne	@@3	;@044D5
	mov	byte ptr ds:[25Fh], 1	;@044D7
	push	ds	;@044DC
	mov	ah, 3Fh	;@044DD
	mov	bx, word ptr ds:[26h]	;@044DF
	mov	cx, word ptr ds:[260h]	;@044E3
	xor	dx, dx	;@044E7
	mov	ds, word ptr ds:[282h]	;@044E9
	call	DOS_CALL	;@044ED
	pop	ds	;@044F0
	jb	@@7	;@044F1
	cmp	ax, word ptr ds:[260h]	;@044F3
	jne	@@7	;@044F7
	les	bx, dword ptr ds:[280h]	;@044F9
	cmp	word ptr es:[bx], 2BADh	;@044FD
	jne	@@7	;@04502
	call	L04550	;@04504
	jb	@@7	;@04507
	mov	di, word ptr ds:[496h]	;@04509
	mov	byte ptr [di+8], 1	;@0450D
	ret	;@04511
@@7:	call	RELEASE_BUFFER	;@04512
	jmp	@@3	;@04515
RELEASE_BUFFER:	cmp	byte ptr ds:[25Fh], 1	;@04518
	jne	@@1	;@0451D
	push	ds	;@0451F
	mov	ax, 282h	;@04520
	push	ax	;@04523
	xor	ax, ax	;@04524
	push	ax	;@04526
	db	9Ah, 0CAh, 2Dh, 0DFh, 0	; lcall 0xdf, 0x2dca	;@04527
@@1:	ret	;@0452C
READ_PACKED_NUMBER:	lodsb	;@0452D
	cbw	;@0452E
	and	al, al	;@0452F
	js	@@1	;@04531
	ret	;@04533
@@1:	push	bx	;@04534
	mov	bl, al	;@04535
	lodsb	;@04537
	mov	bh, al	;@04538
	shl	bl, 1	;@0453A
	shr	bx, 1	;@0453C
	and	al, al	;@0453E
	jns	@@2	;@04540
	lodsb	;@04542
	and	bh, 3Fh	;@04543
	ror	al, 1	;@04546
	ror	al, 1	;@04548
	or	bh, al	;@0454A
@@2:	mov	ax, bx	;@0454C
	pop	bx	;@0454E
	ret	;@0454F
L04550:	push	ds	;@04550
	pop	es	;@04551
	mov	di, 52Ah	;@04552
	mov	cx, 38h	;@04555
	mov	al, 0	;@04558
	rep stosb	;@0455A
	lds	si, dword ptr ds:[280h]	;@0455C
	push	word ptr [si+2]	;@04560
	add	si, 8	;@04563
	lodsw	;@04566
	mov	cx, ax	;@04567
	lodsw	;@04569
	mov	word ptr es:[264h], si	;@0456A
	mov	bx, si	;@0456F
	add	bx, ax	;@04571
	push	bx	;@04573
	jcxz	@@1	;@04574
	mov	ah, 80h	;@04576
	call	@@12	;@04578
@@1:	pop	si	;@0457B
	lodsw	;@0457C
	mov	cx, ax	;@0457D
	lodsw	;@0457F
	mov	word ptr es:[262h], si	;@04580
	mov	bx, si	;@04585
	add	bx, ax	;@04587
	push	bx	;@04589
	jcxz	@@2	;@0458A
	mov	ah, 0	;@0458C
	call	@@12	;@0458E
@@2:	pop	si	;@04591
	pop	bp	;@04592
@@3:	push	bp	;@04593
	lodsw	;@04594
	mov	cl, 40h	;@04595
	call	@@14	;@04597
	mov	word ptr es:[266h], ax	;@0459A
	mov	di, 52Ah	;@0459E
	mov	ax, bx	;@045A1
	stosw	;@045A3
	mov	ax, word ptr es:[77Eh]	;@045A4
	stosw	;@045A8
	mov	ax, word ptr es:[786h]	;@045A9
	stosw	;@045AD
	mov	ax, word ptr es:[796h]	;@045AE
	stosw	;@045B2
	mov	ax, word ptr es:[7AEh]	;@045B3
	stosw	;@045B7
	mov	ax, 1	;@045B8
	stosw	;@045BB
	mov	ax, dx	;@045BC
	stosw	;@045BE
	lodsb	;@045BF
	cbw	;@045C0
	and	al, al	;@045C1
	jns	@@4	;@045C3
	sub	al, 80h	;@045C5
	mov	ah, al	;@045C7
	lodsb	;@045C9
@@4:	stosw	;@045CA
	xor	ax, ax	;@045CB
	stosb	;@045CD
	stosw	;@045CE
	dec	ax	;@045CF
	stosw	;@045D0
	inc	ax	;@045D1
	stosb	;@045D2
	stosw	;@045D3
	lodsw	;@045D4
	push	ax	;@045D5
	and	ax, 7	;@045D6
	je	@@5	;@045D9
	call	@@19	;@045DB
@@5:	pop	ax	;@045DE
	shr	al, 1	;@045DF
	shr	al, 1	;@045E1
	shr	al, 1	;@045E3
	push	ax	;@045E5
	and	ax, 3	;@045E6
	je	@@6	;@045E9
	call	@@26	;@045EB
@@6:	pop	ax	;@045EE
	mov	al, ah	;@045EF
	push	ax	;@045F1
	and	ax, 0Fh	;@045F2
	je	@@7	;@045F5
	call	@@40	;@045F7
@@7:	pop	ax	;@045FA
	shr	ax, 1	;@045FB
	shr	ax, 1	;@045FD
	shr	ax, 1	;@045FF
	shr	ax, 1	;@04601
	and	ax, 7	;@04603
	je	@@8	;@04606
	call	@@33	;@04608
@@8:	push	si	;@0460B
	push	es	;@0460C
	pop	ds	;@0460D
	push	bx	;@0460E
	mov	bx, word ptr ds:[73Ah]	;@0460F
	les	di, dword ptr [bx+2]	;@04613
	add	di, 18h	;@04616
	cmp	di, word ptr [bx]	;@04619
	jbe	@@9	;@0461B
	call	L054E9	;@0461D
	pop	bx	;@04620
	jae	@@10	;@04621
	call	L054B0	;@04623
@@9:	xchg	word ptr [bx+2], di	;@04626
	pop	bx	;@04629
@@10:	mov	si, 52Ah	;@0462A
	mov	cx, 18h	;@0462D
	shr	cx, 1	;@04630
	rep movsw	;@04632
	rcl	cx, 1	;@04634
	rep movsb	;@04636
	push	ds	;@04638
	pop	es	;@04639
	mov	ds, word ptr ds:[282h]	;@0463A
	pop	si	;@0463E
	pop	bp	;@0463F
	dec	bp	;@04640
	je	@@11	;@04641
	jmp	@@3	;@04643
@@11:	push	es	;@04646
	pop	ds	;@04647
	clc	;@04648
	ret	;@04649
@@12:	push	ds	;@0464A
	push	es	;@0464B
	pop	ds	;@0464C
	pop	es	;@0464D
	mov	di, si	;@0464E
	add	si, cx	;@04650
	add	si, cx	;@04652
@@13:	push	ax	;@04654
	push	cx	;@04655
	push	di	;@04656
	mov	word ptr ds:[5250h], es	;@04657
	db	0E8h, 0BCh, 47h	; call L08E1A	;@0465B
	mov	es, word ptr ds:[282h]	;@0465E
	pop	di	;@04662
	mov	ax, bx	;@04663
	stosw	;@04665
	pop	cx	;@04666
	pop	ax	;@04667
	loop	@@13	;@04668
	push	ds	;@0466A
	push	es	;@0466B
	pop	ds	;@0466C
	pop	es	;@0466D
	ret	;@0466E
@@14:	push	si	;@0466F
	push	ds	;@04670
	push	es	;@04671
	pop	ds	;@04672
	pop	es	;@04673
	mov	si, ax	;@04674
	push	si	;@04676
	mov	bl, byte ptr es:[si]	;@04677
	and	bx, 3Fh	;@0467A
	push	word ptr es:[bx+si+1]	;@0467D
	cmp	byte ptr es:[bx+si], 21h	;@04681
	jne	@@15	;@04685
	dec	byte ptr es:[si]	;@04687
@@15:	mov	ah, cl	;@0468A
	and	byte ptr es:[si], 3Fh	;@0468C
	mov	word ptr ds:[5250h], es	;@04690
	db	0E8h, 83h, 47h	; call L08E1A	;@04694
	push	ds	;@04697
	pop	es	;@04698
	pop	dx	;@04699
	pop	ax	;@0469A
	pop	si	;@0469B
	mov	ds, word ptr ds:[282h]	;@0469C
	ret	;@046A0
@@16:	lodsb	;@046A1
	cbw	;@046A2
	cmp	al, 0E0h	;@046A3
	jae	@@17	;@046A5
	dec	si	;@046A7
	lodsb	;@046A8
	cbw	;@046A9
	and	al, al	;@046AA
	jns	@@17	;@046AC
	sub	al, 80h	;@046AE
	mov	ah, al	;@046B0
	lodsb	;@046B2
@@17:	and	ax, ax	;@046B3
	js	@@18	;@046B5
	mov	bx, ax	;@046B7
	shl	bx, 1	;@046B9
	add	bx, word ptr es:[264h]	;@046BB
	mov	bx, word ptr [bx]	;@046C0
	ret	;@046C2
@@18:	push	si	;@046C3
	push	di	;@046C4
	mov	bl, al	;@046C5
	mov	si, word ptr es:[266h]	;@046C7
	lodsb	;@046CC
	and	ax, 3Fh	;@046CD
	mov	cx, ax	;@046D0
	mov	di, 273h	;@046D2
	rep movsb	;@046D5
	and	bx, 7	;@046D7
	shl	bx, 1	;@046DA
	mov	si, word ptr cs:[bx+4428h]	;@046DC
	push	cs	;@046E1
	pop	ds	;@046E2
	mov	cx, 5	;@046E3
	rep movsb	;@046E6
	push	es	;@046E8
	pop	ds	;@046E9
	mov	si, 272h	;@046EA
	mov	ax, di	;@046ED
	sub	ax, si	;@046EF
	dec	ax	;@046F1
	mov	byte ptr [si], al	;@046F2
	mov	ah, 80h	;@046F4
	db	0E8h, 1Dh, 47h	; call L08E16	;@046F6
	push	ds	;@046F9
	pop	es	;@046FA
	mov	ds, word ptr ds:[282h]	;@046FB
	pop	di	;@046FF
	pop	si	;@04700
	ret	;@04701
@@19:	cmp	ax, 7	;@04702
	jb	@@20	;@04705
	lodsb	;@04707
	cbw	;@04708
	and	al, al	;@04709
	jns	@@20	;@0470B
	sub	al, 80h	;@0470D
	mov	ah, al	;@0470F
	lodsb	;@04711
@@20:	push	ax	;@04712
	mov	al, byte ptr [si]	;@04713
	and	al, 0E0h	;@04715
	cmp	al, 0C0h	;@04717
	jne	@@21	;@04719
	lodsb	;@0471B
	and	ax, 7	;@0471C
	mov	di, ax	;@0471F
	shl	ax, 1	;@04721
	add	di, ax	;@04723
	add	di, 4410h	;@04725
	mov	al, byte ptr cs:[di+1]	;@04729
	cbw	;@0472D
	call	@@17	;@0472E
	push	bx	;@04731
	mov	al, byte ptr cs:[di]	;@04732
	cbw	;@04735
	call	@@17	;@04736
	push	bx	;@04739
	mov	al, byte ptr cs:[di+2]	;@0473A
	jmp	short @@22	;@0473E
@@21:	call	@@16	;@04740
	push	bx	;@04743
	call	@@16	;@04744
	push	bx	;@04747
	lodsb	;@04748
@@22:	push	ax	;@04749
	and	al, 0E0h	;@0474A
	jne	@@23	;@0474C
	lodsw	;@0474E
	push	ax	;@0474F
@@23:	call	READ_PACKED_NUMBER	;@04750
	push	ax	;@04753
	push	es	;@04754
	pop	ds	;@04755
	db	0E8h, 0E3h, 12h	; call L05A3C	;@04756
	mov	ax, word ptr ds:[736h]	;@04759
	mov	word ptr es:[di+4], ax	;@0475C
	pop	word ptr es:[di+6]	;@04760
	pop	ax	;@04764
	mov	byte ptr es:[di+9], al	;@04765
	test	al, 0E0h	;@04769
	jne	@@24	;@0476B
	mov	es, word ptr ds:[780h]	;@0476D
	pop	word ptr es:[di]	;@04771
@@24:	pop	bx	;@04774
	pop	dx	;@04775
	mov	es, word ptr ds:[778h]	;@04776
	call	L01BA2	;@0477A
	push	ds	;@0477D
	pop	es	;@0477E
	mov	ds, word ptr ds:[282h]	;@0477F
	pop	ax	;@04783
	dec	ax	;@04784
	je	@@25	;@04785
	jmp	@@20	;@04787
@@25:	ret	;@04789
@@26:	cmp	ax, 3	;@0478A
	jb	@@27	;@0478D
	lodsb	;@0478F
	cbw	;@04790
	and	al, al	;@04791
	jns	@@27	;@04793
	sub	al, 80h	;@04795
	mov	ah, al	;@04797
	lodsb	;@04799
@@27:	xchg	ax, cx	;@0479A
@@28:	push	cx	;@0479B
	lodsw	;@0479C
	mov	cx, ax	;@0479D
	and	ax, 0Fh	;@0479F
	mov	bx, cx	;@047A2
	mov	cl, 4	;@047A4
	shr	bx, cl	;@047A6
	shl	bx, 1	;@047A8
	add	bx, word ptr es:[264h]	;@047AA
	mov	dx, word ptr [bx]	;@047AF
	push	es	;@047B1
	pop	ds	;@047B2
	mov	di, 4	;@047B3
	push	di	;@047B6
	mov	di, 794h	;@047B7
	call	POOL_ALLOC	;@047BA
	jae	@@29	;@047BD
	call	L054B0	;@047BF
@@29:	mov	word ptr es:[di], dx	;@047C2
	mov	cx, 0FFFFh	;@047C5
	jmp	short @@32	;@047C8
@@30:	mov	es, word ptr ds:[282h]	;@047CA
	sub	bx, bx	;@047CE
	add	bl, byte ptr es:[si]	;@047D0
	jge	@@31	;@047D3
	inc	si	;@047D5
	sub	bl, 80h	;@047D6
	mov	bh, bl	;@047D9
	mov	bl, byte ptr es:[si]	;@047DB
@@31:	inc	si	;@047DE
	call	L01CFE	;@047DF
@@32:	dec	ax	;@047E2
	jge	@@30	;@047E3
	mov	es, word ptr ds:[798h]	;@047E5
	mov	word ptr es:[di+2], cx	;@047E9
	push	ds	;@047ED
	pop	es	;@047EE
	mov	ds, word ptr ds:[282h]	;@047EF
	pop	cx	;@047F3
	loop	@@28	;@047F4
	ret	;@047F6
@@33:	cmp	ax, 7	;@047F7
	jb	@@34	;@047FA
	lodsb	;@047FC
	cbw	;@047FD
	and	al, al	;@047FE
	jns	@@34	;@04800
	sub	al, 80h	;@04802
	mov	ah, al	;@04804
	lodsb	;@04806
@@34:	mov	cx, ax	;@04807
@@35:	push	cx	;@04809
	sub	bx, bx	;@0480A
	add	bl, byte ptr [si]	;@0480C
	jge	@@36	;@0480E
	inc	si	;@04810
	sub	bl, 80h	;@04811
	mov	bh, bl	;@04814
	mov	bl, byte ptr [si]	;@04816
@@36:	inc	si	;@04818
	and	bx, bx	;@04819
	je	@@37	;@0481B
	dec	bx	;@0481D
	shl	bx, 1	;@0481E
	add	bx, word ptr es:[262h]	;@04820
	mov	bx, word ptr [bx]	;@04825
	jmp	short @@39	;@04827
@@37:	lodsb	;@04829
	cbw	;@0482A
	and	al, al	;@0482B
	jns	@@38	;@0482D
	sub	al, 80h	;@0482F
	mov	ah, al	;@04831
	lodsb	;@04833
@@38:	mov	cl, 0	;@04834
	call	@@14	;@04836
@@39:	push	es	;@04839
	pop	ds	;@0483A
	push	bx	;@0483B
	and	bx, 3	;@0483C
	shl	bx, 1	;@0483F
	shl	bx, 1	;@04841
	shl	bx, 1	;@04843
	mov	es, word ptr [bx+718h]	;@04845
	pop	bx	;@04849
	mov	dl, 10h	;@0484A
	call	ADD_EXTERN	;@0484C
	push	ds	;@0484F
	pop	es	;@04850
	mov	ds, word ptr ds:[282h]	;@04851
	pop	cx	;@04855
	loop	@@35	;@04856
	ret	;@04858
@@40:	cmp	ax, 0Fh	;@04859
	jb	@@41	;@0485C
	lodsb	;@0485E
	cbw	;@0485F
	and	al, al	;@04860
	jns	@@41	;@04862
	sub	al, 80h	;@04864
	mov	ah, al	;@04866
	lodsb	;@04868
@@41:	push	ax	;@04869
	lodsw	;@0486A
	mov	cl, 0	;@0486B
	call	@@14	;@0486D
	push	bx	;@04870
	cmp	byte ptr [si], 80h	;@04871
	sbb	si, -2	;@04874
	sub	bx, bx	;@04877
	add	bl, byte ptr [si]	;@04879
	jge	@@42	;@0487B
	inc	si	;@0487D
	sub	bl, 80h	;@0487E
	mov	bh, bl	;@04881
	mov	bl, byte ptr [si]	;@04883
@@42:	inc	si	;@04885
	mov	dl, 0	;@04886
	or	bx, bx	;@04888
	jne	@@43	;@0488A
	mov	dl, 2	;@0488C
	lodsw	;@0488E
@@43:	lodsw	;@0488F
	push	es	;@04890
	pop	ds	;@04891
	mov	byte ptr ds:[172h], dl	;@04892
	mov	word ptr ds:[16Eh], ax	;@04896
	mov	word ptr ds:[170h], 0	;@04899
	test	dl, 2	;@0489F
	jne	@@44	;@048A2
	dec	bx	;@048A4
	xchg	ax, bx	;@048A5
	mov	ah, 0Ah	;@048A6
	mul	ah	;@048A8
	xchg	ax, bx	;@048AA
	add	bx, word ptr ds:[52Ch]	;@048AB
@@44:	mov	word ptr ds:[16Ch], bx	;@048AF
	pop	bx	;@048B3
	push	bx	;@048B4
	and	bx, 3	;@048B5
	shl	bx, 1	;@048B8
	shl	bx, 1	;@048BA
	shl	bx, 1	;@048BC
	mov	es, word ptr [bx+718h]	;@048BE
	pop	bx	;@048C2
	call	DEFINE_PUBLIC	;@048C3
	push	ds	;@048C6
	pop	es	;@048C7
	mov	ds, word ptr ds:[282h]	;@048C8
	pop	ax	;@048CC
	dec	ax	;@048CD
	jne	@@41	;@048CE
	ret	;@048D0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@048D1
	db	0, 0, 4, 0, 0, 1, 0, 0, 2, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh, 0, 0
	db	0, 5, 0, 0, 2, 0, 0, 4, 0, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh, 0, 0
	db	6, 0, 0, 4, 0, 0, 6, 0, 0, 0, 0, 80h, 0FFh, 0FFh, 0FFh, 7Fh, 8
	db	0, 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0FFh, 0, 0, 0, 9, 0, 0, 2, 0
	db	0, 0Ah, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0Ah, 0, 0, 4, 0, 0, 0Ch
	db	0, 0, 0, 0, 0, 0FFh, 0FFh, 0FFh, 0FFh, 0Dh, 0, 0, 4, 0, 0, 0, 0
	db	0Fh, 0, 0, 8, 0, 0, 0, 0, 10h, 0, 0, 0Ah, 0, 0, 0, 0, 0Eh, 0, 0
	db	6, 0, 0, 0, 0, 28h, 0, 0, 1, 0, 0, 0, 0, 0Ch, 0, 0, 1, 0, 0, 13h
	db	0, 0, 0, 0, 0, 0FFh, 0, 0, 0, 7, 0, 0, 8, 0, 0, 0, 0, 0Bh, 0, 0
	db	8, 0, 0, 0, 0, 2Bh, 0, 0, 0Ah, 0, 0, 0, 0, 5, 3, 9, 0, 0E8h, 4
	db	0Dh, 3, 10h, 0, 0ECh, 4, 11h, 3, 6, 0, 0F4h, 4, 15h, 3, 4, 0, 0F2h
	db	4, 19h, 3, 0Ch, 0, 0F0h, 4, 2Dh, 3, 10h, 0, 0F6h, 4, 31h, 3, 8
	db	0, 0F8h, 4, 1Dh, 3, 8, 0, 0EEh, 4, 21h, 3, 8, 0, 0E4h, 4, 25h
	db	3, 5, 0, 0E6h, 4, 35h, 3, 0Bh, 0, 0Ah, 5, 39h, 3, 2, 0, 0Ch, 5
	db	3Dh, 3, 8, 0, 10h, 5, 41h, 3, 4, 0, 12h, 5, 45h, 3, 8, 0, 14h
	db	5, 0BEh, 3, 2, 0, 0CAh, 3, 0BAh, 3, 2, 0, 16h, 5
L049FE:	push	ds	;@049FE
	push	bx	;@049FF
	push	ax	;@04A00
	db	9Ah, 18h, 15h, 0DFh, 0	; lcall 0xdf, 0x1518	;@04A01
	and	ax, ax	;@04A06
	jne	@@1	;@04A08
	ret	;@04A0A
@@1:	jmp	L0029E+2	;@04A0B
L04A0E:	xor	ax, ax	;@04A0E
	push	ax	;@04A10
	mov	ax, 1Fh	;@04A11
	push	ax	;@04A14
	db	0E8h, 89h, 71h	; call FATAL	;@04A15
	push	bp	;@04A18
	mov	bp, sp	;@04A19
	sub	sp, 0Ah	;@04A1B
	mov	si, 734h	;@04A1E
	mov	word ptr [bp-8], si	;@04A21
	xor	si, si	;@04A24
	mov	word ptr ds:[3A8h], si	;@04A26
	push	ds	;@04A2A
	pop	es	;@04A2B
@@1:	push	si	;@04A2C
	and	si, 3	;@04A2D
	shl	si, 1	;@04A30
	shl	si, 1	;@04A32
	shl	si, 1	;@04A34
	mov	ds, word ptr es:[si+738h]	;@04A36
	pop	si	;@04A3B
	mov	bl, byte ptr [si+10h]	;@04A3C
	mov	bh, 0	;@04A3F
	cmp	word ptr [si+0Ah], 2	;@04A41
	jb	@@2	;@04A45
	inc	word ptr es:[4ECh]	;@04A47
	mov	ax, word ptr es:[4ECh]	;@04A4C
	mov	word ptr [si+16h], ax	;@04A50
	and	bx, bx	;@04A53
	je	@@2	;@04A55
	mov	word ptr [bp-6], si	;@04A57
	lea	si, [si+18h]	;@04A5A
	mov	di, 4E4h	;@04A5D
	mov	cx, 3	;@04A60
	call	ADD_WORDS_CHECKED	;@04A63
	mov	si, word ptr [bp-6]	;@04A66
	lea	si, [si+1Eh]	;@04A69
	mov	di, 4EEh	;@04A6C
	mov	cx, 5	;@04A6F
	call	ADD_WORDS_CHECKED	;@04A72
	mov	si, word ptr [bp-6]	;@04A75
	mov	di, 4DAh	;@04A78
	mov	ax, word ptr [si+28h]	;@04A7B
	add	word ptr es:[di+1Eh], ax	;@04A7E
	mov	ax, word ptr [si+2Ah]	;@04A82
	add	word ptr es:[di+30h], ax	;@04A85
	mov	ax, word ptr [si+2Eh]	;@04A89
	add	word ptr es:[di+32h], ax	;@04A8C
	mov	ax, word ptr [si+2Ch]	;@04A90
	add	word ptr es:[di+36h], ax	;@04A93
	mov	ax, word ptr [si+32h]	;@04A97
	add	word ptr es:[di+3Ch], ax	;@04A9A
	mov	ax, word ptr [si+34h]	;@04A9E
	add	word ptr es:[3E6h], ax	;@04AA1
	mov	al, byte ptr [si+30h]	;@04AA6
	or	byte ptr es:[3A8h], al	;@04AA9
	and	byte ptr [si+30h], 7Fh	;@04AAE
@@2:	cmp	si, word ptr es:[184h]	;@04AB2
	je	@@5	;@04AB7
	add	si, word ptr cs:[bx+5750h]	;@04AB9
	push	es	;@04ABE
	pop	ds	;@04ABF
	push	di	;@04AC0
	mov	di, word ptr [bp-8]	;@04AC1
	cmp	si, word ptr [di+2]	;@04AC4
	pop	di	;@04AC7
	jae	@@3	;@04AC8
	push	si	;@04ACA
	add	si, 38h	;@04ACB
	cmp	si, -80h	;@04ACE
	pop	si	;@04AD1
	jae	@@3	;@04AD2
	jmp	@@1	;@04AD4
@@3:	push	di	;@04AD7
	mov	di, word ptr [bp-8]	;@04AD8
	cmp	di, 744h	;@04ADB
	jbe	@@4	;@04ADF
	pop	di	;@04AE1
	jmp	short @@5	;@04AE2
@@4:	add	di, 8	;@04AE4
	mov	word ptr [bp-8], di	;@04AE7
	and	si, 3	;@04AEA
	inc	si	;@04AED
	pop	di	;@04AEE
	jmp	@@1	;@04AEF
@@5:	push	es	;@04AF2
	pop	ds	;@04AF3
	and	word ptr ds:[3A8h], 80h	;@04AF4
	push	bp	;@04AFA
	mov	word ptr ds:[3B0h], 1	;@04AFB
	mov	bp, 4F63h	;@04B01
	call	@@40	;@04B04
	pop	bp	;@04B07
	mov	di, 4DAh	;@04B08
	mov	ax, word ptr [di+10h]	;@04B0B
	add	word ptr [di+0Eh], ax	;@04B0E
	add	word ptr [di+0Ah], 17h	;@04B11
	mov	word ptr [di+38h], 0	;@04B15
	mov	ax, word ptr [di+30h]	;@04B1A
	mov	word ptr [di+3Ah], ax	;@04B1D
	or	ax, word ptr [di+36h]	;@04B20
	je	@@6	;@04B23
	mov	word ptr ds:[3A1h], 0	;@04B25
	mov	ax, word ptr [di+12h]	;@04B2B
	mov	word ptr [di+3Ah], ax	;@04B2E
	cmp	word ptr ds:[3A8h], 0	;@04B31
	je	@@6	;@04B36
	mov	ax, word ptr [di+16h]	;@04B38
	mov	word ptr [di+38h], ax	;@04B3B
@@6:	mov	cx, 18h	;@04B3E
	mov	si, 734h	;@04B41
	mov	word ptr [bp-8], si	;@04B44
	xor	si, si	;@04B47
	push	si	;@04B49
	and	si, 3	;@04B4A
	shl	si, 1	;@04B4D
	shl	si, 1	;@04B4F
	shl	si, 1	;@04B51
	mov	es, word ptr [si+738h]	;@04B53
	pop	si	;@04B57
@@7:	mov	bl, byte ptr es:[si+10h]	;@04B58
	and	bx, 0FFh	;@04B5C
	je	@@8	;@04B60
	cmp	word ptr es:[si+18h], 0	;@04B62
	je	@@8	;@04B67
	cmp	word ptr es:[si+0Ah], 2	;@04B69
	jb	@@12	;@04B6E
	add	cx, word ptr es:[si+18h]	;@04B70
@@8:	cmp	si, word ptr ds:[184h]	;@04B74
	jne	@@9	;@04B78
	jmp	@@34	;@04B7A
@@9:	add	si, word ptr cs:[bx+5750h]	;@04B7D
	push	di	;@04B82
	mov	di, word ptr [bp-8]	;@04B83
	cmp	si, word ptr [di+2]	;@04B86
	pop	di	;@04B89
	jae	@@10	;@04B8A
	push	si	;@04B8C
	add	si, 38h	;@04B8D
	cmp	si, -80h	;@04B90
	pop	si	;@04B93
	jb	@@7	;@04B94
@@10:	push	di	;@04B96
	mov	di, word ptr [bp-8]	;@04B97
	cmp	di, 744h	;@04B9A
	jbe	@@11	;@04B9E
	pop	di	;@04BA0
	jmp	@@34	;@04BA1
@@11:	add	di, 8	;@04BA4
	mov	word ptr [bp-8], di	;@04BA7
	and	si, 3	;@04BAA
	inc	si	;@04BAD
	pop	di	;@04BAE
	push	si	;@04BAF
	and	si, 3	;@04BB0
	shl	si, 1	;@04BB3
	shl	si, 1	;@04BB5
	shl	si, 1	;@04BB7
	mov	es, word ptr [si+738h]	;@04BB9
	pop	si	;@04BBD
	jmp	@@7	;@04BBE
	db	0E9h, 4Bh, 0FEh	;@04BC0
@@12:	mov	ax, word ptr ds:[492h]	;@04BC3
	add	ax, 17h	;@04BC6
	sub	ax, cx	;@04BC9
	inc	ax	;@04BCB
	mov	word ptr ds:[3AEh], cx	;@04BCC
	push	si	;@04BD0
	or	ax, ax	;@04BD1
	jns	@@13	;@04BD3
	push	ax	;@04BD5
	mov	ax, 0FFFFh	;@04BD6
	mov	bx, 3AAh	;@04BD9
	call	L049FE	;@04BDC
	pop	ax	;@04BDF
	sub	ax, 8000h	;@04BE0
	shl	ax, 1	;@04BE3
	mov	bx, 3ACh	;@04BE5
	call	L049FE	;@04BE8
	pop	si	;@04BEB
	jmp	short @@14	;@04BEC
@@13:	shl	ax, 1	;@04BEE
	mov	bx, 3AAh	;@04BF0
	call	L049FE	;@04BF3
	pop	si	;@04BF6
@@14:	mov	di, si	;@04BF7
	and	di, 3	;@04BF9
	shl	di, 1	;@04BFC
	shl	di, 1	;@04BFE
	shl	di, 1	;@04C00
	lea	di, [di+734h]	;@04C02
	mov	word ptr [bp-8], di	;@04C06
	xor	di, di	;@04C09
	mov	ax, word ptr ds:[3AAh]	;@04C0B
	mov	word ptr [bp-0Ah], ax	;@04C0E
	mov	ax, word ptr ds:[3AEh]	;@04C11
@@15:	push	si	;@04C14
	and	si, 3	;@04C15
	shl	si, 1	;@04C18
	shl	si, 1	;@04C1A
	shl	si, 1	;@04C1C
	mov	es, word ptr [si+738h]	;@04C1E
	pop	si	;@04C22
	mov	bl, byte ptr es:[si+10h]	;@04C23
	and	bx, 0FFh	;@04C27
	je	@@23	;@04C2B
	mov	cx, word ptr es:[si+18h]	;@04C2D
	jcxz	@@23	;@04C31
	mov	dx, word ptr [bp-0Ah]	;@04C33
	cmp	dx, word ptr ds:[3ACh]	;@04C36
	je	@@16	;@04C3A
	push	di	;@04C3C
	push	cx	;@04C3D
	shl	cx, 1	;@04C3E
	add	di, cx	;@04C40
	pop	cx	;@04C42
	pop	di	;@04C43
	jb	@@19	;@04C44
@@16:	cmp	word ptr es:[si+0Ah], 2	;@04C46
	mov	es, dx	;@04C4B
	jb	@@18	;@04C4D
@@17:	stosw	;@04C4F
	inc	ax	;@04C50
	loop	@@17	;@04C51
	jmp	short @@23	;@04C53
@@18:	push	ax	;@04C55
	xor	ax, ax	;@04C56
	rep stosw	;@04C58
	pop	ax	;@04C5A
	jmp	short @@23	;@04C5B
@@19:	push	cx	;@04C5D
	mov	cx, di	;@04C5E
	neg	cx	;@04C60
	shr	cx, 1	;@04C62
	push	cx	;@04C64
	cmp	word ptr es:[si+0Ah], 2	;@04C65
	mov	es, dx	;@04C6A
	jb	@@22	;@04C6C
@@20:	stosw	;@04C6E
	inc	ax	;@04C6F
	loop	@@20	;@04C70
	pop	dx	;@04C72
	pop	cx	;@04C73
	sub	cx, dx	;@04C74
	mov	dx, word ptr ds:[3ACh]	;@04C76
	mov	word ptr [bp-0Ah], dx	;@04C7A
	mov	es, dx	;@04C7D
	xor	di, di	;@04C7F
@@21:	stosw	;@04C81
	inc	ax	;@04C82
	loop	@@21	;@04C83
	jmp	short @@23	;@04C85
@@22:	push	ax	;@04C87
	xor	ax, ax	;@04C88
	rep stosw	;@04C8A
	pop	ax	;@04C8C
	pop	dx	;@04C8D
	pop	cx	;@04C8E
	sub	cx, dx	;@04C8F
	mov	dx, word ptr ds:[3ACh]	;@04C91
	mov	word ptr [bp-0Ah], dx	;@04C95
	mov	es, dx	;@04C98
	xor	di, di	;@04C9A
	push	ax	;@04C9C
	xor	ax, ax	;@04C9D
	rep stosw	;@04C9F
	pop	ax	;@04CA1
@@23:	cmp	si, word ptr ds:[184h]	;@04CA2
	je	@@26	;@04CA6
	add	si, word ptr cs:[bx+5750h]	;@04CA8
	push	di	;@04CAD
	mov	di, word ptr [bp-8]	;@04CAE
	cmp	si, word ptr [di+2]	;@04CB1
	pop	di	;@04CB4
	jae	@@24	;@04CB5
	push	si	;@04CB7
	add	si, 38h	;@04CB8
	cmp	si, -80h	;@04CBB
	pop	si	;@04CBE
	jae	@@24	;@04CBF
	jmp	@@15	;@04CC1
@@24:	push	di	;@04CC4
	mov	di, word ptr [bp-8]	;@04CC5
	cmp	di, 744h	;@04CC8
	jbe	@@25	;@04CCC
	pop	di	;@04CCE
	jmp	short @@26	;@04CCF
@@25:	add	di, 8	;@04CD1
	mov	word ptr [bp-8], di	;@04CD4
	and	si, 3	;@04CD7
	inc	si	;@04CDA
	pop	di	;@04CDB
	push	si	;@04CDC
	and	si, 3	;@04CDD
	shl	si, 1	;@04CE0
	shl	si, 1	;@04CE2
	shl	si, 1	;@04CE4
	mov	es, word ptr [si+738h]	;@04CE6
	pop	si	;@04CEA
	jmp	@@15	;@04CEB
@@26:	sub	si, si	;@04CEE
	push	si	;@04CF0
	mov	bx, 754h	;@04CF1
	mov	dx, word ptr ds:[490h]	;@04CF4
@@27:	push	si	;@04CF8
	and	si, 3	;@04CF9
	shl	si, 1	;@04CFC
	shl	si, 1	;@04CFE
	shl	si, 1	;@04D00
	mov	es, word ptr [si+758h]	;@04D02
	pop	si	;@04D06
	mov	ax, word ptr [bx+2]	;@04D07
	push	ds	;@04D0A
	jmp	short @@32	;@04D0B
@@28:	pop	ds	;@04D0D
	push	ds	;@04D0E
	mov	di, word ptr es:[si+10h]	;@04D0F
	sub	di, word ptr ds:[3AEh]	;@04D13
	jb	@@31	;@04D17
	js	@@29	;@04D19
	shl	di, 1	;@04D1B
	push	ax	;@04D1D
	mov	ax, word ptr ds:[3AAh]	;@04D1E
	mov	ds, ax	;@04D21
	pop	ax	;@04D23
	jmp	short @@30	;@04D24
@@29:	sub	di, 8000h	;@04D26
	shl	di, 1	;@04D2A
	pop	ds	;@04D2C
	push	ds	;@04D2D
	push	ax	;@04D2E
	mov	ax, word ptr ds:[3ACh]	;@04D2F
	mov	ds, ax	;@04D32
	pop	ax	;@04D34
@@30:	mov	di, word ptr [di]	;@04D35
	mov	word ptr es:[si+10h], di	;@04D37
@@31:	add	si, dx	;@04D3B
@@32:	cmp	si, ax	;@04D3D
	jb	@@28	;@04D3F
	pop	ds	;@04D41
	cmp	bx, 764h	;@04D42
	ja	@@33	;@04D46
	add	bx, 8	;@04D48
	pop	si	;@04D4B
	inc	si	;@04D4C
	push	si	;@04D4D
	jmp	@@27	;@04D4E
@@33:	pop	ax	;@04D50
	push	ds	;@04D51
	mov	ax, 3AAh	;@04D52
	push	ax	;@04D55
	db	9Ah, 0FCh, 15h, 0DFh, 0	; lcall 0xdf, 0x15fc	;@04D56
	cmp	word ptr ds:[3ACh], -1	;@04D5B
	je	@@34	;@04D60
	push	ds	;@04D62
	mov	ax, 3ACh	;@04D63
	push	ax	;@04D66
	db	9Ah, 0FCh, 15h, 0DFh, 0	; lcall 0xdf, 0x15fc	;@04D67
@@34:	xor	di, di	;@04D6C
	mov	ax, 10h	;@04D6E
	mul	word ptr ds:[3FEh]	;@04D71
	xchg	ax, si	;@04D75
	mov	di, dx	;@04D76
	add	si, word ptr ds:[3DCh]	;@04D78
	adc	di, word ptr ds:[3DEh]	;@04D7C
	add	si, 0Fh	;@04D80
	adc	di, 0	;@04D83
	and	si, -10h	;@04D86
	cmp	byte ptr ds:[19h], 0	;@04D89
	je	@@35	;@04D8E
	add	si, 10h	;@04D90
	adc	di, 0	;@04D93
@@35:	add	si, 30h	;@04D96
	adc	di, 0	;@04D99
	xor	ax, ax	;@04D9C
	cmp	word ptr ds:[514h], 0	;@04D9E
	jne	@@36	;@04DA3
	cmp	word ptr ds:[516h], 0	;@04DA5
	je	@@38	;@04DAA
	mov	ax, word ptr ds:[4F6h]	;@04DAC
	mov	word ptr ds:[3CAh], ax	;@04DAF
@@36:	mov	ax, 20h	;@04DB2
	cmp	byte ptr ds:[12Fh], 1	;@04DB5
	jne	@@37	;@04DBA
	sub	ax, 14h	;@04DBC
@@37:	add	si, ax	;@04DBF
	adc	di, 0	;@04DC1
@@38:	mov	word ptr ds:[508h], ax	;@04DC4
	mov	word ptr [bp-4], si	;@04DC7
	mov	word ptr [bp-2], di	;@04DCA
	push	bp	;@04DCD
	mov	bp, 4998h	;@04DCE
	mov	cx, 11h	;@04DD1
@@39:	mov	bx, word ptr cs:[bp]	;@04DD4
	mov	word ptr [bx], si	;@04DD8
	mov	word ptr [bx+2], di	;@04DDA
	mov	ax, word ptr cs:[bp+2]	;@04DDD
	mov	bx, word ptr cs:[bp+4]	;@04DE1
	mul	word ptr [bx]	;@04DE5
	add	si, ax	;@04DE7
	adc	di, dx	;@04DE9
	add	bp, 6	;@04DEB
	loop	@@39	;@04DEE
	pop	bp	;@04DF0
	mov	word ptr ds:[329h], si	;@04DF1
	mov	word ptr ds:[32Bh], di	;@04DF5
	sub	si, word ptr [bp-4]	;@04DF9
	sbb	di, word ptr [bp-2]	;@04DFC
	mov	word ptr ds:[518h], si	;@04DFF
	mov	word ptr ds:[51Ah], di	;@04E03
	mov	di, 4DAh	;@04E07
	mov	ax, 9	;@04E0A
	mul	word ptr [di+10h]	;@04E0D
	add	ax, word ptr ds:[305h]	;@04E10
	adc	dx, word ptr ds:[307h]	;@04E14
	mov	word ptr ds:[309h], ax	;@04E18
	mov	word ptr ds:[30Bh], dx	;@04E1B
	mov	ax, word ptr [di+10h]	;@04E1F
	mov	word ptr [di+0Eh], ax	;@04E22
	xor	ax, ax	;@04E25
	mov	word ptr [di+18h], ax	;@04E27
	mov	word ptr [di+16h], ax	;@04E2A
	mov	word ptr [di+14h], ax	;@04E2D
	mov	word ptr [di+0Ah], 17h	;@04E30
	mov	word ptr [di+0Ch], ax	;@04E35
	mov	word ptr [di+1Ah], ax	;@04E38
	mov	word ptr [di+12h], ax	;@04E3B
	mov	word ptr [di+1Ch], ax	;@04E3E
	mov	word ptr [di+1Eh], ax	;@04E41
	mov	word ptr [di+32h], ax	;@04E44
	mov	word ptr [di+36h], ax	;@04E47
	mov	word ptr [di+30h], ax	;@04E4A
	mov	ax, 8000h	;@04E4D
	mov	bx, 2BAh	;@04E50
	call	L049FE	;@04E53
	mov	word ptr ds:[2B8h], 0	;@04E56
	mov	ax, 16h	;@04E5C
	mul	word ptr ds:[48Ah]	;@04E5F
	mov	bx, 36Dh	;@04E63
	call	L049FE	;@04E66
	mov	ax, 8	;@04E69
	mul	word ptr ds:[48Ch]	;@04E6C
	mov	bx, 375h	;@04E70
	call	L049FE	;@04E73
	mov	ax, word ptr ds:[48Ch]	;@04E76
	shl	ax, 1	;@04E79
	mov	bx, 379h	;@04E7B
	call	L049FE	;@04E7E
	mov	ax, 9	;@04E81
	mul	word ptr ds:[48Eh]	;@04E84
	mov	bx, 37Dh	;@04E88
	call	L049FE	;@04E8B
	mov	ax, word ptr ds:[48Eh]	;@04E8E
	shl	ax, 1	;@04E91
	mov	bx, 381h	;@04E93
	call	L049FE	;@04E96
	mov	ax, 7FDh	;@04E99
	mov	bx, 349h	;@04E9C
	call	L049FE	;@04E9F
	mov	ax, word ptr ds:[3C8h]	;@04EA2
	shl	ax, 1	;@04EA5
	mov	bx, word ptr ds:[3C6h]	;@04EA7
	shl	bx, 1	;@04EAB
	shl	bx, 1	;@04EAD
	add	ax, bx	;@04EAF
	mov	bx, 3B4h	;@04EB1
	call	L049FE	;@04EB4
	mov	ax, word ptr ds:[3C6h]	;@04EB7
	shl	ax, 1	;@04EBA
	mov	bx, 3B8h	;@04EBC
	call	L049FE	;@04EBF
	xor	ax, ax	;@04EC2
	mov	word ptr ds:[36Bh], ax	;@04EC4
	mov	word ptr ds:[373h], ax	;@04EC7
	mov	word ptr ds:[377h], ax	;@04ECA
	mov	word ptr ds:[37Bh], ax	;@04ECD
	mov	word ptr ds:[37Fh], ax	;@04ED0
	mov	word ptr ds:[36Fh], ax	;@04ED3
	mov	word ptr ds:[3B2h], ax	;@04ED6
	mov	word ptr ds:[3B6h], ax	;@04ED9
	xor	ax, ax	;@04EDC
	mov	word ptr ds:[363h], ax	;@04EDE
	mov	word ptr ds:[35Dh], ax	;@04EE1
	mov	word ptr ds:[361h], 7FDh	;@04EE4
	mov	word ptr ds:[35Fh], 349h	;@04EEA
	mov	word ptr ds:[359h], ax	;@04EF0
	mov	word ptr ds:[35Bh], ax	;@04EF3
	mov	word ptr ds:[391h], ax	;@04EF6
	mov	word ptr ds:[38Fh], ax	;@04EF9
	mov	byte ptr ds:[5276h], 2	;@04EFC
	les	di, dword ptr ds:[2B8h]	;@04F01
	mov	cx, 4000h	;@04F05
	rep stosw	;@04F08
	mov	ax, word ptr ds:[321h]	;@04F0A
	mov	dx, word ptr ds:[323h]	;@04F0D
	mov	si, 48E0h	;@04F11
	mov	cx, 0B8h	;@04F14
	add	word ptr ds:[321h], cx	;@04F17
	adc	word ptr ds:[323h], 0	;@04F1B
	mov	bx, 480h	;@04F20
	db	0E8h, 0DFh, 39h	; call L08905	;@04F23
	mov	sp, bp	;@04F26
	pop	bp	;@04F28
	ret	;@04F29
@@40:	xor	bx, bx	;@04F2A
	jmp	short @@43	;@04F2C
@@41:	mov	es, word ptr ds:[7C0h]	;@04F2E
	mov	si, word ptr es:[bx]	;@04F32
	push	si	;@04F35
	and	si, 3	;@04F36
	shl	si, 1	;@04F39
	shl	si, 1	;@04F3B
	shl	si, 1	;@04F3D
	mov	es, word ptr [si+758h]	;@04F3F
	pop	si	;@04F43
	cmp	word ptr es:[si+0Ch], -1	;@04F44
	je	@@42	;@04F49
	push	di	;@04F4B
	mov	di, si	;@04F4C
	db	0E8h, 0D2h, 41h	; call L09123	;@04F4E
	pop	di	;@04F51
	jae	@@42	;@04F52
	push	bx	;@04F54
	push	bp	;@04F55
	call	bp	;@04F56
	pop	bp	;@04F58
	pop	bx	;@04F59
@@42:	inc	bx	;@04F5A
	inc	bx	;@04F5B
@@43:	cmp	bx, word ptr ds:[7BEh]	;@04F5C
	jb	@@41	;@04F60
	ret	;@04F62
ASSIGN_SYMBOL_NUMBER:	mov	ax, word ptr ds:[3B0h]	;@04F63
	mov	word ptr es:[si+12h], ax	;@04F66
	inc	word ptr ds:[3B0h]	;@04F6A
	mov	bx, word ptr es:[si+0Ch]	;@04F6E
	cmp	word ptr es:[si+10h], 0	;@04F72
	jne	@@1	;@04F77
	mov	bx, word ptr es:[si+0Ch]	;@04F79
	push	bx	;@04F7D
	and	bx, 3	;@04F7E
	shl	bx, 1	;@04F81
	shl	bx, 1	;@04F83
	shl	bx, 1	;@04F85
	mov	es, word ptr [bx+718h]	;@04F87
	pop	bx	;@04F8B
	mov	ax, word ptr es:[bx-6]	;@04F8C
	push	si	;@04F90
	and	si, 3	;@04F91
	shl	si, 1	;@04F94
	shl	si, 1	;@04F96
	shl	si, 1	;@04F98
	mov	es, word ptr [si+758h]	;@04F9A
	pop	si	;@04F9E
	mov	word ptr es:[si+10h], ax	;@04F9F
@@1:	push	bx	;@04FA3
	and	bx, 3	;@04FA4
	shl	bx, 1	;@04FA7
	shl	bx, 1	;@04FA9
	shl	bx, 1	;@04FAB
	mov	es, word ptr [bx+718h]	;@04FAD
	pop	bx	;@04FB1
	mov	al, byte ptr es:[bx+2]	;@04FB2
	and	ax, 3Fh	;@04FB6
	inc	ax	;@04FB9
	add	word ptr ds:[4DEh], ax	;@04FBA
	adc	word ptr ds:[4E0h], 0	;@04FBE
	inc	word ptr ds:[4E2h]	;@04FC3
	mov	ax, word ptr ds:[4E2h]	;@04FC7
	mov	word ptr es:[bx-4], ax	;@04FCA
	inc	word ptr ds:[4EAh]	;@04FCE
	ret	;@04FD2
	push	si	;@04FD3
	push	ds	;@04FD4
	mov	si, word ptr es:[si+0Ch]	;@04FD5
	push	ds	;@04FD9
	pop	es	;@04FDA
	push	si	;@04FDB
	and	si, 3	;@04FDC
	shl	si, 1	;@04FDF
	shl	si, 1	;@04FE1
	shl	si, 1	;@04FE3
	mov	ds, word ptr [si+718h]	;@04FE5
	pop	si	;@04FE9
	mov	ax, word ptr [si-4]	;@04FEA
	mov	word ptr es:[391h], ax	;@04FED
	inc	si	;@04FF1
	inc	si	;@04FF2
	mov	cx, 3Fh	;@04FF3
	and	cl, byte ptr [si]	;@04FF6
	mov	byte ptr [si], cl	;@04FF8
	inc	cx	;@04FFA
	mov	bx, cx	;@04FFB
	add	bx, si	;@04FFD
	mov	al, 0	;@04FFF
	xchg	byte ptr [bx], al	;@05001
	pop	ds	;@05003
	push	ax	;@05004
	push	bx	;@05005
	mov	ax, word ptr ds:[329h]	;@05006
	mov	dx, word ptr ds:[32Bh]	;@05009
	add	word ptr ds:[329h], cx	;@0500D
	adc	word ptr ds:[32Bh], 0	;@05011
	dec	si	;@05016
	dec	si	;@05017
	mov	bx, si	;@05018
	and	bx, 3	;@0501A
	shl	bx, 1	;@0501D
	shl	bx, 1	;@0501F
	shl	bx, 1	;@05021
	lea	bx, [bx+718h]	;@05023
	push	si	;@05027
	add	si, 3	;@05028
	db	0E8h, 0D7h, 38h	; call L08905	;@0502B
	pop	si	;@0502E
	push	si	;@0502F
	and	si, 3	;@05030
	shl	si, 1	;@05033
	shl	si, 1	;@05035
	shl	si, 1	;@05037
	mov	es, word ptr [si+718h]	;@05039
	pop	si	;@0503D
	pop	bx	;@0503E
	pop	ax	;@0503F
	mov	byte ptr es:[bx], al	;@05040
	pop	si	;@05043
	push	si	;@05044
	and	si, 3	;@05045
	shl	si, 1	;@05048
	shl	si, 1	;@0504A
	shl	si, 1	;@0504C
	mov	es, word ptr [si+758h]	;@0504E
	pop	si	;@05052
	call	WRITE_DEBUG_SYMBOL	;@05053
	ret	;@05056
	db	50h, 53h, 8Eh, 6, 78h, 7, 26h, 8Bh, 44h, 2, 26h, 8Bh, 5Dh, 2, 3Bh	;@05057
	db	0C3h, 74h, 1Eh, 3Bh, 6, 4Eh, 4, 74h, 15h, 3Bh, 1Eh, 4Eh, 4, 74h
	db	0Ch, 3Bh, 6, 50h, 4, 74h, 9, 3Bh, 1Eh, 50h, 4, 75h, 6, 0F9h, 0EBh
	db	19h, 0F8h, 0EBh, 16h, 8Eh, 6, 80h, 7, 26h, 8Bh, 4, 26h, 3Bh, 5
	db	75h, 0Ah, 26h, 8Bh, 44h, 6, '&;E', 6, 74h, 7, 8Eh, 6, 71h, 3, 5Bh
	db	58h, 0C3h, 3Bh, 0F7h, 0EBh, 0F5h, 'VW3', 0F6h, 0BFh, 50h, 0Ah
	db	8Bh, 16h, 76h, 7, 0EBh, 20h, 8Eh, 6, 80h, 7, 0B0h, 0, 26h, 86h
	db	44h, 9, 8Eh, 6, 78h, 7, 26h, 80h, 7Ch, 9, 0FFh, 74h, 8, 0A8h, 1
	db	74h, 4, 89h, '5GG', 83h, 0C6h, 0Ah, 3Bh, 0F2h, 72h, 0DCh, 81h
	db	0EFh, 50h, 0Ah, 75h, 3, 0E9h, 0B6h, 0, 8Bh, 0C7h, 0D1h, 0E8h, 0A3h
	db	0F6h, 4, 0BAh, 10h, 0, 0F7h, 0E2h, 50h, 57h, 0BBh, 71h, 3, 0E8h
	db	8, 0F9h, 0C4h, 3Eh, 6Fh, 3, 0BEh, 50h, 0Ah, 8Bh, 0Eh, 0F6h, 4
	db	0F3h, 0A5h, 0BDh, 'WPYQ', 0E8h, 'R>Y_', 8Bh, 0F1h, 83h, 0EFh, 2
	db	83h, 0EEh, 2, 1Eh, 6, 1Fh, 0FDh, 0D1h, 0E9h, 0F3h, 0A5h, 1Fh, 0FCh
	db	83h, 0C7h, 2, 0B2h, 0, 2Bh, 0DBh, 80h, 0C2h, 1, 80h, 0D2h, 0, 8Eh
	db	6, 71h, 3, 26h, 8Bh, 35h, 8Eh, 6, 80h, 7, 26h, 88h, 54h, 9, 26h
	db	0FFh, 74h, 6, 8Eh, 6, 78h, 7, 26h, 0FFh, 74h, 6, 26h, 0FFh, 74h
	db	4, 8Eh, 6, 80h, 7, 26h, 8Bh, 34h, 0E8h, 9Eh, '?^V', 83h, 0E6h
	db	3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h
	db	8Bh, 74h, 16h, 8Eh, 6, 71h, 3, 26h, 89h, 37h, 26h, 89h, 47h, 2
	db	26h, 8Fh, 47h, 6, 26h, 8Fh, 47h, 4, 2Bh, 0C0h, 26h, 89h, 47h, 8
	db	26h, 89h, 47h, 0Ah, 26h, 89h, 47h, 0Ch, 26h, 89h, 47h, 0Eh, 83h
	db	0C3h, 10h, 83h, 0C7h, 2, 3Bh, 0FBh, 77h, 8Eh, 89h, 1Eh, 99h, 3
	db	5Fh, 5Eh, 0C3h
ADD_WORDS_CHECKED:	lodsw	;@0519F
	add	ax, word ptr es:[di]	;@051A0
	jb	@@1	;@051A3
	stosw	;@051A5
	loop	ADD_WORDS_CHECKED	;@051A6
	ret	;@051A8
@@1:	jmp	L04A0E	;@051A9
WRITE_AT:	mov	ax, word ptr [bx]	;@051AC
	mov	dx, word ptr [bx+2]	;@051AE
	add	word ptr [bx], cx	;@051B1
	adc	word ptr [bx+2], 0	;@051B3
	mov	bx, bp	;@051B7
	db	0E8h, 49h, 37h	; call L08905	;@051B9
	ret	;@051BC
L051BD:	push	si	;@051BD
	mov	word ptr ds:[5250h], es	;@051BE
	db	0E8h, 55h, 3Ch	; call L08E1A	;@051C2
	pop	dx	;@051C5
	jb	@@1	;@051C6
	mov	ax, word ptr es:[bx-4]	;@051C8
	and	ax, ax	;@051CC
	je	@@1	;@051CE
	ret	;@051D0
@@1:	mov	es, word ptr ds:[5250h]	;@051D1
	mov	ax, word ptr ds:[5252h]	;@051D5
	shl	ax, 1	;@051D8
	mov	word ptr ds:[369h], 2BAh	;@051DA
	lds	bx, dword ptr ds:[2B8h]	;@051E0
	add	bx, ax	;@051E4
@@2:	mov	si, word ptr [bx]	;@051E6
	and	si, si	;@051E8
	je	@@4	;@051EA
	push	ds	;@051EC
	push	bx	;@051ED
	mov	bp, word ptr [bx+2]	;@051EE
	mov	ds, word ptr cs:L00100+16	;@051F1
	mov	word ptr ds:[369h], si	;@051F6
	mov	ds, word ptr [si]	;@051FA
	lea	si, [bp+6]	;@051FC
	mov	di, dx	;@051FF
	lodsb	;@05201
	scasb	;@05202
	jne	@@3	;@05203
	and	ax, 3Fh	;@05205
	mov	cx, ax	;@05208
	repe cmpsb	;@0520A
	jne	@@3	;@0520C
	mov	ax, word ptr ds:[bp+4]	;@0520E
	add	sp, 4	;@05212
	mov	ds, word ptr cs:L00100+16	;@05215
	ret	;@0521A
@@3:	add	sp, 4	;@0521B
	mov	bx, bp	;@0521E
	jmp	@@2	;@05220
@@4:	mov	si, dx	;@05222
	mov	al, byte ptr es:[si]	;@05224
	and	ax, 3Fh	;@05227
	inc	ax	;@0522A
	mov	cx, ax	;@0522B
	add	ax, 7	;@0522D
	push	es	;@05230
	mov	ds, word ptr cs:L00100+16	;@05231
@@5:	mov	di, word ptr ds:[35Dh]	;@05236
	add	di, ax	;@0523A
	jb	@@6	;@0523C
	add	di, 2	;@0523E
	jb	@@6	;@05241
	cmp	di, word ptr ds:[361h]	;@05243
	ja	@@6	;@05247
	add	word ptr ds:[359h], ax	;@05249
	adc	word ptr ds:[35Bh], 0	;@0524D
	add	word ptr ds:[4DEh], cx	;@05252
	adc	word ptr ds:[4E0h], 0	;@05256
	dec	di	;@0525B
	dec	di	;@0525C
	xchg	word ptr ds:[35Dh], di	;@0525D
	mov	si, word ptr ds:[35Fh]	;@05261
	mov	ax, ds	;@05265
	push	bx	;@05267
	mov	bx, word ptr ds:[369h]	;@05268
	mov	ds, word ptr [bx]	;@0526C
	pop	bx	;@0526E
	mov	word ptr [bx+2], di	;@0526F
	mov	word ptr [bx], si	;@05272
	mov	ds, ax	;@05274
	mov	es, word ptr [si]	;@05276
	mov	si, dx	;@05278
	xor	ax, ax	;@0527A
	stosw	;@0527C
	stosw	;@0527D
	inc	word ptr ds:[4E2h]	;@0527E
	mov	ax, word ptr ds:[4E2h]	;@05282
	stosw	;@05285
	mov	dx, ds	;@05286
	pop	ds	;@05288
	lodsb	;@05289
	and	al, 3Fh	;@0528A
	stosb	;@0528C
	dec	cx	;@0528D
	shr	cx, 1	;@0528E
	rep movsw	;@05290
	rcl	cx, 1	;@05292
	rep movsb	;@05294
	xor	al, al	;@05296
	stosb	;@05298
	mov	ds, dx	;@05299
	mov	ax, word ptr ds:[4E2h]	;@0529B
	inc	word ptr ds:[363h]	;@0529E
	ret	;@052A2
@@6:	push	ax	;@052A3
	push	bx	;@052A4
	push	cx	;@052A5
	push	dx	;@052A6
	add	word ptr ds:[361h], 800h	;@052A7
	jb	@@9	;@052AD
	push	ds	;@052AF
	push	word ptr ds:[35Fh]	;@052B0
	push	word ptr ds:[361h]	;@052B4
	db	9Ah, 0CAh, 2Dh, 0DFh, 0	; lcall 0xdf, 0x2dca	;@052B8
@@7:	and	ax, ax	;@052BD
	jne	@@8	;@052BF
	pop	dx	;@052C1
	pop	cx	;@052C2
	pop	bx	;@052C3
	pop	ax	;@052C4
	jmp	@@5	;@052C5
@@8:	jmp	L0029E+2	;@052C8
@@9:	mov	di, word ptr ds:[35Fh]	;@052CB
	mov	es, word ptr [di]	;@052CF
	mov	di, word ptr ds:[35Dh]	;@052D1
	mov	ax, 0FFFFh	;@052D5
	stosw	;@052D8
	add	word ptr ds:[35Fh], 2	;@052D9
	mov	ax, 7FDh	;@052DE
	mov	word ptr ds:[361h], ax	;@052E1
	mov	word ptr ds:[35Dh], 0	;@052E4
	push	ds	;@052EA
	push	word ptr ds:[35Fh]	;@052EB
	push	ax	;@052EF
	db	9Ah, 18h, 15h, 0DFh, 0	; lcall 0xdf, 0x1518	;@052F0
	jmp	@@7	;@052F5
NAME_LOOKUP_COPY:	push	bp	;@052F7
	push	ax	;@052F8
	push	ds	;@052F9
	push	es	;@052FA
	pop	ds	;@052FB
	pop	es	;@052FC
	mov	di, 2C5h	;@052FD
	cmp	al, 0	;@05300
	jne	@@1	;@05302
	lodsb	;@05304
	and	ax, 3Fh	;@05305
	stosb	;@05308
	mov	cx, ax	;@05309
	shr	cx, 1	;@0530B
	rep movsw	;@0530D
	rcl	cx, 1	;@0530F
	rep movsb	;@05311
	jmp	short @@4	;@05313
@@1:	lodsb	;@05315
	and	ax, 3Fh	;@05316
	stosb	;@05319
	mov	cx, ax	;@0531A
	jcxz	@@4	;@0531C
@@2:	lodsb	;@0531E
	cmp	al, 61h	;@0531F
	jb	@@3	;@05321
	cmp	al, 7Ah	;@05323
	ja	@@3	;@05325
	sub	al, 20h	;@05327
@@3:	stosb	;@05329
	loop	@@2	;@0532A
@@4:	push	es	;@0532C
	pop	ds	;@0532D
	mov	si, 2C5h	;@0532E
	cmp	byte ptr es:[si+1], 40h	;@05331
	jne	@@6	;@05336
	mov	al, byte ptr es:[si]	;@05338
	and	ax, 3Fh	;@0533B
	mov	cx, ax	;@0533E
	jcxz	@@6	;@05340
	xor	bx, bx	;@05342
@@5:	inc	bx	;@05344
	cmp	byte ptr es:[bx+si], 24h	;@05345
	loopne	@@5	;@05349
	jne	@@6	;@0534B
	cmp	byte ptr es:[bx+si-1], 40h	;@0534D
	je	@@6	;@05352
	push	si	;@05354
	push	es	;@05355
	mov	al, byte ptr es:[si]	;@05356
	push	ax	;@05359
	dec	bl	;@0535A
	mov	byte ptr es:[si], bl	;@0535C
	xor	ah, ah	;@0535F
	call	L051BD	;@05361
	pop	ax	;@05364
	pop	es	;@05365
	pop	si	;@05366
	mov	byte ptr es:[si], al	;@05367
@@6:	pop	ax	;@0536A
	call	L051BD	;@0536B
	pop	bp	;@0536E
	ret	;@0536F
WRITE_DEBUG_SYMBOL:	push	bx	;@05370
	push	cx	;@05371
	push	dx	;@05372
	push	si	;@05373
	push	es	;@05374
	mov	di, 290h	;@05375
	mov	al, byte ptr es:[si+0Fh]	;@05378
	mov	byte ptr [di+8], al	;@0537C
	mov	ax, word ptr es:[si+10h]	;@0537F
	mov	word ptr [di+2], ax	;@05383
	push	word ptr es:[si+0Ch]	;@05386
	test	byte ptr es:[si+0Eh], 20h	;@0538A
	jne	L053E1	;@0538F
	db	0E8h, 0CEh, 28h	; call L07C62	;@05391
	cmp	dh, 1	;@05394
	jne	DEBUG_SYMBOL_VALUE	;@05397
	mov	dh, byte ptr [di+8]	;@05399
	and	dh, 0F8h	;@0539C
	or	dh, 1	;@0539F
	or	byte ptr [di+8], dh	;@053A2
DEBUG_SYMBOL_VALUE:	mov	word ptr [di+6], ax	;@053A5
	mov	word ptr [di+4], cx	;@053A8
	pop	si	;@053AB
	mov	ax, word ptr ds:[391h]	;@053AC
	and	ax, ax	;@053AF
	jne	@@1	;@053B1
	push	si	;@053B3
	and	si, 3	;@053B4
	shl	si, 1	;@053B7
	shl	si, 1	;@053B9
	shl	si, 1	;@053BB
	mov	es, word ptr [si+718h]	;@053BD
	pop	si	;@053C1
	add	si, 2	;@053C2
	xor	ax, ax	;@053C5
	call	NAME_LOOKUP_COPY	;@053C7
@@1:	mov	si, 290h	;@053CA
	mov	word ptr [si], ax	;@053CD
	mov	cx, 9	;@053CF
	mov	bx, 309h	;@053D2
	mov	bp, 47Eh	;@053D5
	call	WRITE_AT	;@053D8
	pop	es	;@053DB
	pop	si	;@053DC
	pop	dx	;@053DD
	pop	cx	;@053DE
	pop	bx	;@053DF
	ret	;@053E0
L053E1:	push	di	;@053E1
	mov	si, word ptr es:[si+2]	;@053E2
	mov	es, word ptr ds:[808h]	;@053E6
	mov	ax, word ptr es:[si+4]	;@053EA
	or	ax, ax	;@053EE
	je	@@1	;@053F0
	or	ax, 4000h	;@053F2
@@1:	mov	si, word ptr es:[si+0Ah]	;@053F5
	or	ax, 8000h	;@053F9
	push	ax	;@053FC
	mov	es, word ptr ds:[7D0h]	;@053FD
	mov	si, word ptr es:[si]	;@05401
	push	si	;@05404
	and	si, 3	;@05405
	shl	si, 1	;@05408
	shl	si, 1	;@0540A
	shl	si, 1	;@0540C
	mov	es, word ptr [si+718h]	;@0540E
	pop	si	;@05412
	add	si, 2	;@05413
	mov	ax, 0C000h	;@05416
	call	NAME_LOOKUP_COPY	;@05419
	mov	cx, ax	;@0541C
	pop	ax	;@0541E
	pop	di	;@0541F
	jmp	DEBUG_SYMBOL_VALUE	;@05420
	db	83h, 0C4h, 2, 0EBh, 0B4h, 0B8h, 10h, 0, 0F7h, 26h, 0F6h, 4, 91h	;@05422
	db	0E3h, 1Bh, 0BBh, 71h, 3, 8Bh, 36h, 6Fh, 3, 8Bh, 16h, 2Fh, 3, 0A1h
	db	2Dh, 3, 0E8h, 0C3h, 34h, 1Eh, 0B8h, 71h, 3, 50h, 9Ah, 0FCh, 15h
	db	0DFh, 0, 83h, 6, 0E4h, 4, 0, 0A1h, 5, 3, 0A3h, 9, 3, 0A1h, 7, 3
	db	0A3h, 0Bh, 3, 0BDh, 0D3h, 4Fh, 0E8h, 0C7h, 0FAh, 0C7h, 6, 91h
	db	3, 0, 0, 0A1h, 29h, 3, 8Bh, 16h, 2Bh, 3, 0BBh, 49h, 3, 33h, 0F6h
	db	1Eh, 8Eh, 1Fh, 83h, 3Ch, 0FFh, 74h, 1Eh, 83h, 0C6h, 6, 8Ah, 0Ch
	db	83h, 0E1h, 3Fh, 1Fh, 'FAV', 0E8h, 'y4^', 3, 0C1h, 83h, 0D2h, 0
	db	3, 0F1h, 0FFh, 0Eh, 63h, 3, 75h, 0DBh, 0C3h, 1Fh, 83h, 0C3h, 2
	db	33h, 0F6h, 0EBh, 0D2h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
L054B0:	call	L0552C	;@054B0
	xor	ax, ax	;@054B3
	push	ax	;@054B5
	mov	ax, 8	;@054B6
	push	ax	;@054B9
	db	0E8h, 0E4h, 66h	; call FATAL	;@054BA
POOL_ALLOC:	push	bp	;@054BD
	mov	bp, sp	;@054BE
	push	si	;@054C0
	mov	si, di	;@054C1
	mov	di, 0FF80h	;@054C3
	sub	di, word ptr [bp+4]	;@054C6
	cmp	di, word ptr [si+2]	;@054C9
	jbe	@@2	;@054CC
@@1:	les	di, dword ptr [si+2]	;@054CE
	add	di, word ptr [bp+4]	;@054D1
	cmp	di, word ptr [si]	;@054D4
	jbe	@@3	;@054D6
	call	L05594	;@054D8
	jmp	@@1	;@054DB
@@2:	stc	;@054DD
	jmp	short @@4	;@054DE
@@3:	xchg	word ptr [si+2], di	;@054E0
	clc	;@054E3
@@4:	pop	si	;@054E4
	pop	bp	;@054E5
	ret	2	;@054E6
L054E9:	push	si	;@054E9
	mov	si, bx	;@054EA
	mov	bx, word ptr [si+2]	;@054EC
	sub	di, bx	;@054EF
	push	di	;@054F1
	jmp	short @@2	;@054F2
@@1:	mov	bx, word ptr [si+6]	;@054F4
	push	bx	;@054F7
	add	bx, 18h	;@054F8
	cmp	bx, si	;@054FB
	pop	bx	;@054FD
	je	@@5	;@054FE
	add	si, 8	;@05500
	mov	word ptr [bx+6], si	;@05503
@@2:	push	di	;@05506
	mov	di, si	;@05507
	call	POOL_ALLOC	;@05509
	jae	@@3	;@0550C
	pop	di	;@0550E
	push	di	;@0550F
	jmp	@@1	;@05510
@@3:	clc	;@05512
@@4:	pop	si	;@05513
	pop	si	;@05514
	ret	;@05515
@@5:	stc	;@05516
	jmp	@@4	;@05517
	db	0E8h, 54h, 40h, 0E8h, 0C1h, 40h, 2, ', ZXR', 0E8h, 48h, 40h, 0E8h	;@05519
	db	5Bh, 40h, 0C3h
L0552C:	push	ax	;@0552C
	push	bx	;@0552D
	push	cx	;@0552E
	push	dx	;@0552F
	push	si	;@05530
	push	di	;@05531
	mov	di, word ptr ds:[0B441h]	;@05532
	db	0E8h, 4Dh, 40h	; call PUT_NEWLINE	;@05536
	db	0E8h, 0A4h, 40h	; call PUT_INLINE	;@05539
	adc	al, 49h	;@0553C
	outsb	;@0553E
	db	74h, 65h	; je L055A5+1	;@0553F
	db	72h, 6Eh	; jb L055B1	;@05541
	popa	;@05543
	insb	;@05544
	and	byte ptr [si+69h], ch	;@05545
	outsb	;@05548
	imul	sp, word ptr [di+72h], 20h	;@05549
	db	64h, 61h	; popa	;@0554D
	db	74h, 61h	; je L055B1+1	;@0554F
	db	0E8h, 32h, 40h	; call PUT_NEWLINE	;@05551
	mov	bx, 714h	;@05554
@@1:	mov	ax, word ptr [bx]	;@05557
	db	0E8h, 14h, 40h	; call PUT_HEX_WORD	;@05559
	db	0E8h, 81h, 40h	; call PUT_INLINE	;@0555C
	add	word ptr [bx+si], sp	;@0555F
	mov	ax, word ptr [bx+2]	;@05561
	db	0E8h, 9, 40h	; call PUT_HEX_WORD	;@05564
	db	0E8h, 76h, 40h	; call PUT_INLINE	;@05567
	add	word ptr [bx+si], sp	;@0556A
	mov	ax, word ptr [bx+4]	;@0556C
	db	0E8h, 0FEh, 3Fh	; call PUT_HEX_WORD	;@0556F
	db	0E8h, 6Bh, 40h	; call PUT_INLINE	;@05572
	add	word ptr [bx+si], sp	;@05575
	mov	ax, word ptr [bx+6]	;@05577
	db	0E8h, 0F3h, 3Fh	; call PUT_HEX_WORD	;@0557A
	db	0E8h, 6, 40h	; call PUT_NEWLINE	;@0557D
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
L05594:	push	ax	;@05594
	push	bx	;@05595
	push	cx	;@05596
	push	dx	;@05597
	push	di	;@05598
	push	si	;@05599
	push	bp	;@0559A
	mov	ax, word ptr [si]	;@0559B
	cmp	ax, 0FF80h	;@0559D
	jae	L055D3	;@055A0
	cmp	ax, 3F80h	;@055A2
L055A5:	jae	@@1	;@055A5
	add	ax, ax	;@055A7
	add	ax, 80h	;@055A9
	jmp	short L055B1	;@055AC
@@1:	add	ax, 4000h	;@055AE
L055B1:	mov	di, ax	;@055B1
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
	jne	L055D3	;@055C9
	pop	bp	;@055CB
	pop	si	;@055CC
	pop	di	;@055CD
	pop	dx	;@055CE
	pop	cx	;@055CF
	pop	bx	;@055D0
	pop	ax	;@055D1
	ret	;@055D2
L055D3:	jmp	L0029E+2	;@055D3
NEW_POOL:	push	cx	;@055D6
	push	di	;@055D7
	mov	word ptr [di+2], 0	;@055D8
	mov	ax, 80h	;@055DD
	mov	word ptr [di], ax	;@055E0
	add	di, 4	;@055E2
	push	ds	;@055E5
	push	di	;@055E6
	push	ax	;@055E7
	db	9Ah, 18h, 15h, 0DFh, 0	; lcall 0xdf, 0x1518	;@055E8
	pop	di	;@055ED
	pop	cx	;@055EE
	ret	;@055EF
	db	0BFh, 14h, 7, 0E8h, 0E0h, 0FFh, 23h, 0C0h, 74h, 3, 0E9h, 9Ah, 0	;@055F0
	db	83h, 0C7h, 8, 81h, 0FFh, 0BCh, 7, 76h, 0EDh, 0C7h, 6, 56h, 7, 0
	db	0, 0C7h, 6, 5Eh, 7, 1, 0, 0C7h, 6, 66h, 7, 2, 0, 0C7h, 6, 6Eh
	db	7, 3, 0, 0C7h, 6, 5Ah, 7, 54h, 7, 0C7h, 6, 62h, 7, 54h, 7, 0C7h
	db	6, 6Ah, 7, 54h, 7, 0C7h, 6, 72h, 7, 54h, 7, 0C7h, 6, 16h, 7, 2
	db	0, 0C7h, 6, 1Eh, 7, 3, 0, 0C7h, 6, 26h, 7, 4, 0, 0C7h, 6, 2Eh
	db	7, 5, 0, 0C7h, 6, 1Ah, 7, 14h, 7, 0C7h, 6, 22h, 7, 14h, 7, 0C7h
	db	6, 2Ah, 7, 14h, 7, 0C7h, 6, 32h, 7, 14h, 7, 0C7h, 6, 36h, 7, 0
	db	0, 0C7h, 6, 3Eh, 7, 1, 0, 0C7h, 6, 46h, 7, 2, 0, 0C7h, 6, 4Eh
	db	7, 3, 0, 0C7h, 6, 3Ah, 7, 34h, 7, 0C7h, 6, 42h, 7, 34h, 7, 0C7h
	db	6, 4Ah, 7, 34h, 7, 0C7h, 6, 52h, 7, 34h, 7, 0C3h
L05697:	jmp	L0029E+2	;@05697
INIT_LIST_POOLS:	push	cx	;@0569A
	push	di	;@0569B
	mov	cx, 4	;@0569C
@@1:	call	NEW_POOL	;@0569F
	and	ax, ax	;@056A2
	jne	L05697	;@056A4
	add	di, 8	;@056A6
	loop	@@1	;@056A9
	pop	di	;@056AB
	mov	word ptr [di+2], 0	;@056AC
	mov	word ptr [di+0Ah], 1	;@056B1
	mov	word ptr [di+12h], 2	;@056B6
	mov	word ptr [di+1Ah], 3	;@056BB
	mov	word ptr [di+6], di	;@056C0
	mov	word ptr [di+0Eh], di	;@056C3
	mov	word ptr [di+16h], di	;@056C6
	mov	word ptr [di+1Eh], di	;@056C9
	pop	cx	;@056CC
	ret	;@056CD
CLEAR_LIST_POOLS:	mov	word ptr [di+2], 0	;@056CE
	mov	word ptr [di+0Ah], 0	;@056D3
	mov	word ptr [di+12h], 0	;@056D8
	mov	word ptr [di+1Ah], 0	;@056DD
	ret	;@056E2
FREE_LIST_POOLS:	push	cx	;@056E3
	push	di	;@056E4
	mov	cx, 4	;@056E5
@@1:	push	cx	;@056E8
	call	L056F5	;@056E9
	pop	cx	;@056EC
	add	di, 8	;@056ED
	loop	@@1	;@056F0
	pop	di	;@056F2
	pop	cx	;@056F3
	ret	;@056F4
L056F5:	push	si	;@056F5
	push	di	;@056F6
	cmp	word ptr [di], 0	;@056F7
	je	@@3	;@056FA
	mov	ax, word ptr [di+2]	;@056FC
	mov	word ptr [di], ax	;@056FF
	lea	di, [di+4]	;@05701
	push	ds	;@05704
	push	di	;@05705
	and	ax, ax	;@05706
	je	@@1	;@05708
	push	ax	;@0570A
	db	9Ah, 0CAh, 2Dh, 0DFh, 0	; lcall 0xdf, 0x2dca	;@0570B
	jmp	short @@2	;@05710
@@1:	db	9Ah, 0FCh, 15h, 0DFh, 0	; lcall 0xdf, 0x15fc	;@05712
@@2:	and	ax, ax	;@05717
	jne	@@4	;@05719
@@3:	pop	di	;@0571B
	pop	si	;@0571C
	ret	;@0571D
@@4:	jmp	L0029E+2	;@0571E
	db	83h, 6, 16h, 7, 4, 83h, 6, 1Eh, 7, 4, 83h, 6, 26h, 7, 4, 83h, 6	;@05721
	db	2Eh, 7, 4, 0BFh, 14h, 7, 0E8h, 0BAh, 0FFh, 83h, 0C7h, 8, 81h, 0FFh
	db	0BCh, 7, 76h, 0F4h, 9Ah, 5Eh, 13h, 0DFh, 0, 0C3h, 0, 0, 0, 0, 0
	db	0
	sbb	byte ptr [bx+si], al	;@05750
	cmp	byte ptr [bx+si], al	;@05752
	cmp	byte ptr [bx+si], al	;@05754
	and	byte ptr [bx+di+6Eh], ch	;@05756
	and	byte ptr [di+6Fh], ch	;@05759
	db	64h, 75h, 6Ch	; jne L057CA+1	;@0575C
	db	65h, 20h, 0	; and byte ptr [bx+si], al	;@0575F
	and	byte ptr [bx+di+6Eh], ah	;@05762
	db	64h, 20h, 0	; and byte ptr [bx+si], al	;@05765
READ_MODULE:	db	0C6h, 6, 0D6h, 3, 0	; mov byte ptr ds:[3D6h], 0	;@05768
	cmp	byte ptr ds:[3D5h], 1	;@0576D
	jne	@@1	;@05772
	cmp	byte ptr ds:[254h], 0	;@05774
	je	@@1	;@05779
	mov	byte ptr ds:[3D6h], 1	;@0577B
@@1:	mov	byte ptr ds:[3D2h], 0	;@05780
	mov	si, 1250h	;@05785
	cmp	byte ptr ds:[3D4h], 1	;@05788
	jne	L057DA	;@0578D
	mov	di, word ptr ds:[3E2h]	;@0578F
	push	di	;@05793
	and	di, 3	;@05794
	shl	di, 1	;@05797
	shl	di, 1	;@05799
	shl	di, 1	;@0579B
	mov	es, word ptr [di+738h]	;@0579D
	pop	di	;@057A1
	cmp	word ptr es:[di+0Ch], 0	;@057A2
	je	L057DA	;@057A7
	mov	byte ptr ds:[3D2h], 2	;@057A9
	cmp	byte ptr ds:[3D5h], 4	;@057AE
	je	@@2	;@057B3
	dec	byte ptr ds:[3D2h]	;@057B5
	jmp	short L057DA	;@057B9
@@2:	cmp	word ptr es:[di+0Ah], 2	;@057BB
	jae	L057DA	;@057C0
	db	0E9h, 49h, 35h	; jmp L08D0E	;@057C2
L057C5:	db	0E8h, 59h, 2Eh	; call L08621	;@057C5
	jmp	short L057DA	;@057C8
L057CA:	db	0E8h, 54h, 2Eh	; call L08621	;@057CA
	jmp	short L057F0	;@057CD
BAD_RECORD:	nop	;@057CF
	nop	;@057D0
L057D1:	inc	word ptr ds:[41Ch]	;@057D1
	mov	si, word ptr ds:[3E0h]	;@057D5
	inc	si	;@057D9
L057DA:	mov	cx, word ptr ds:[5258h]	;@057DA
	sub	cx, si	;@057DE
	cmp	cx, 3	;@057E0
	jb	L057C5	;@057E3
	mov	bl, byte ptr [si]	;@057E5
	inc	si	;@057E7
	sub	bh, bh	;@057E8
	lodsw	;@057EA
	cmp	ax, 4300h	;@057EB
	ja	L05816	;@057EE
L057F0:	mov	cx, word ptr ds:[5258h]	;@057F0
	sub	cx, si	;@057F4
	cmp	cx, ax	;@057F6
	jb	L057CA	;@057F8
	mov	di, si	;@057FA
	add	di, ax	;@057FC
	dec	di	;@057FE
	mov	word ptr ds:[3E0h], di	;@057FF
	shr	bx, 1	;@05803
	jb	L05819	;@05805
	mov	word ptr ds:[41Eh], 0	;@05807
L0580D:	shl	bx, 1	;@0580D
	add	bx, word ptr ds:[3D0h]	;@0580F
	jmp	word ptr cs:[bx]	;@05813
L05816:	db	0E8h, 84h, 2Eh	; call L0869D	;@05816
L05819:	mov	word ptr ds:[41Eh], 1	;@05819
	cmp	bx, 78h	;@0581F
	je	@@1	;@05822
	cmp	byte ptr ds:[127h], 0	;@05824
	jne	L0580D	;@05829
	mov	word ptr ds:[422h], 1	;@0582B
	xor	cx, cx	;@05831
	push	cx	;@05833
	mov	ax, 1Dh	;@05834
	push	ax	;@05837
	db	0E8h, 66h, 63h	; call FATAL	;@05838
@@1:	ret	;@0583B
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h	;@0583C
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h
	db	0CFh, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h
	db	0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 32h, 14h, 0D1h, 57h
	db	0D1h, 57h, 0D1h, 57h, 31h, 15h, 6Dh, 16h, 60h, 18h, 0D0h, 57h
	db	0A4h, 1Ah, 0A8h, 1Ah, 0E0h, 1Ah, 80h, 1Bh, 0FBh, 1Bh, 40h, 1Dh
	db	9, 1Eh, 0D1h, 57h, 9Ah, 21h, 0EAh, '!F";X;X;X', 0CFh, 57h, 0CFh
	db	57h, 92h, 24h, 0CFh, 57h, 64h, 18h, 0A8h, 1Ah, 97h, 24h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 'WF"', 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0D1h, 57h, 0D1h
	db	57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h
	db	57h, 0D1h, 57h, 0D8h, 25h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D6h
	db	2Fh, 0FAh, 3Bh, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0E4h
	db	3Dh, 0D1h, 57h, 0D1h, 57h, 0D1h, 57h, 0A5h, 40h, 0D1h, 'W,C', 8Fh
	db	'CF";X;X;X', 0CFh, 57h, 0CFh, 57h, 0D1h, 57h, 0D1h, 57h, 0D1h
	db	57h, 0D1h, 57h, 0D1h, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 'WF"', 0CFh
	db	57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh, 57h, 0CFh
	db	57h
L05A3C:	push	cx	;@05A3C
	mov	cx, 0Ah	;@05A3D
	mov	di, cx	;@05A40
	push	di	;@05A42
	mov	di, 77Ch	;@05A43
	call	POOL_ALLOC	;@05A46
	jae	@@1	;@05A49
	call	L054B0	;@05A4B
@@1:	mov	word ptr ds:[0A4Bh], di	;@05A4E
	push	di	;@05A52
	xor	ax, ax	;@05A53
	cld	;@05A55
	rep stosb	;@05A56
	pop	di	;@05A58
	dec	word ptr es:[di]	;@05A59
	dec	word ptr es:[di+4]	;@05A5C
	dec	word ptr es:[di+2]	;@05A60
	mov	cx, 0Ah	;@05A64
	mov	di, cx	;@05A67
	push	di	;@05A69
	mov	di, 774h	;@05A6A
	call	POOL_ALLOC	;@05A6D
	jae	@@2	;@05A70
	call	L054B0	;@05A72
@@2:	push	di	;@05A75
	xor	ax, ax	;@05A76
	cld	;@05A78
	rep stosb	;@05A79
	pop	di	;@05A7B
	pop	cx	;@05A7C
	ret	;@05A7D
L05A7E:	shl	dx, 1	;@05A7E
	cmp	byte ptr ds:[19h], 0	;@05A80
	je	@@1	;@05A85
	shl	dx, 1	;@05A87
	shl	dx, 1	;@05A89
	add	dx, 2	;@05A8B
@@1:	add	ax, dx	;@05A8E
	mov	dx, 0	;@05A90
	adc	dx, dx	;@05A93
	ret	;@05A95
	db	0C7h, 6, 7Ah, 4, 0, 0, 0BEh, 77h, 0, 0B4h, 0, 0C7h, 6, 50h, 52h	;@05A96
	db	97h, 1, 0E8h, 7Dh, 34h, 89h, 1Eh, 58h, 4, 72h, 5, 83h, 0Eh, 7Ah
	db	4, 1, 0BEh, 84h, 0, 0B4h, 0, 0C7h, 6, 50h, 52h, 97h, 1, 0E8h, 64h
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
	db	80h, 67h, 0Eh, 0EFh, 26h, 89h, 57h, 2, 0C3h
L05BD5:	push	bp	;@05BD5
	mov	bp, sp	;@05BD6
	push	bx	;@05BD8
	push	cx	;@05BD9
	push	di	;@05BDA
	mov	si, word ptr [bp+4]	;@05BDB
	push	si	;@05BDE
	and	si, 3	;@05BDF
	shl	si, 1	;@05BE2
	shl	si, 1	;@05BE4
	shl	si, 1	;@05BE6
	mov	es, word ptr [si+738h]	;@05BE8
	pop	si	;@05BEC
	mov	di, si	;@05BED
	and	di, 3	;@05BEF
	shl	di, 1	;@05BF2
	shl	di, 1	;@05BF4
	shl	di, 1	;@05BF6
	lea	di, [di+734h]	;@05BF8
	xor	bx, bx	;@05BFC
	mov	bl, byte ptr es:[si+10h]	;@05BFE
	mov	bx, word ptr cs:[bx+5750h]	;@05C02
	add	bx, si	;@05C07
	mov	si, word ptr es:[si+8]	;@05C09
	cmp	bx, word ptr [di+2]	;@05C0D
	je	@@2	;@05C10
@@1:	mov	bx, word ptr es:[bx+8]	;@05C12
	jmp	short @@4	;@05C16
@@2:	cmp	di, 764h	;@05C18
	ja	@@3	;@05C1C
	mov	bx, si	;@05C1E
	and	bx, 3	;@05C20
	inc	bx	;@05C23
	push	bx	;@05C24
	and	bx, 3	;@05C25
	shl	bx, 1	;@05C28
	shl	bx, 1	;@05C2A
	shl	bx, 1	;@05C2C
	mov	es, word ptr [bx+738h]	;@05C2E
	pop	bx	;@05C32
	jmp	@@1	;@05C33
@@3:	mov	bx, word ptr ds:[7AEh]	;@05C35
@@4:	cmp	si, bx	;@05C39
	jae	@@5	;@05C3B
	mov	es, word ptr ds:[7B0h]	;@05C3D
	mov	di, word ptr es:[si]	;@05C41
	mov	es, word ptr ds:[788h]	;@05C44
	mov	di, word ptr es:[di]	;@05C48
	cmp	di, word ptr [bp+6]	;@05C4B
	je	@@6	;@05C4E
	add	si, 11h	;@05C50
	jmp	@@4	;@05C53
@@5:	stc	;@05C55
	jmp	short @@7	;@05C56
@@6:	mov	es, word ptr ds:[7B0h]	;@05C58
	clc	;@05C5C
@@7:	pop	di	;@05C5D
	pop	cx	;@05C5E
	pop	bx	;@05C5F
	mov	sp, bp	;@05C60
	pop	bp	;@05C62
	ret	4	;@05C63
CHECK_CONFLICT:	push	bp	;@05C66
	mov	bp, sp	;@05C67
	sub	sp, 90h	;@05C69
	push	si	;@05C6D
	push	di	;@05C6E
	xor	ax, ax	;@05C6F
	mov	word ptr [bp-90h], ax	;@05C71
	mov	word ptr [bp-0Eh], ax	;@05C75
	mov	word ptr [bp-0Ah], ax	;@05C78
	dec	ax	;@05C7B
	mov	word ptr [bp-6], ax	;@05C7C
	mov	ax, word ptr es:[di]	;@05C7F
	mov	word ptr [bp-8], ax	;@05C82
	mov	si, word ptr es:[di+0Ah]	;@05C85
@@1:	cmp	si, -1	;@05C89
	jae	@@6	;@05C8C
	mov	es, word ptr ds:[7A8h]	;@05C8E
	mov	ax, word ptr es:[si+0Ah]	;@05C92
	mov	word ptr [bp-0Ch], ax	;@05C96
	mov	ax, word ptr es:[si+6]	;@05C99
	mov	bx, word ptr es:[si+2]	;@05C9D
	mov	cx, word ptr es:[si+8]	;@05CA1
	mov	dx, word ptr es:[si+4]	;@05CA5
	mov	si, word ptr es:[si]	;@05CA9
	push	bx	;@05CAC
	and	bx, 3	;@05CAD
	shl	bx, 1	;@05CB0
	shl	bx, 1	;@05CB2
	shl	bx, 1	;@05CB4
	mov	es, word ptr [bx+738h]	;@05CB6
	pop	bx	;@05CBA
	cmp	word ptr es:[bx+0Ah], 2	;@05CBB
	jb	@@1	;@05CC0
	cmp	word ptr [bp-8], -2	;@05CC2
	jb	@@4	;@05CC6
	cmp	dx, word ptr [bp-8]	;@05CC8
	je	@@2	;@05CCB
	jmp	@@17	;@05CCD
@@2:	cmp	cx, word ptr [bp-0Eh]	;@05CD0
	jb	@@1	;@05CD3
	jne	@@3	;@05CD5
	cmp	ax, word ptr [bp-90h]	;@05CD7
	jb	@@1	;@05CDB
@@3:	mov	word ptr [bp-90h], ax	;@05CDD
	mov	word ptr [bp-6], bx	;@05CE1
	mov	word ptr [bp-0Eh], cx	;@05CE4
	mov	ax, word ptr [bp-0Ch]	;@05CE7
	mov	word ptr [bp-0Ah], ax	;@05CEA
	mov	word ptr [bp-8], dx	;@05CED
	jmp	@@1	;@05CF0
@@4:	cmp	word ptr [bp-6], -1	;@05CF2
	je	@@3	;@05CF6
	cmp	ax, word ptr [bp-90h]	;@05CF8
	jne	@@5	;@05CFC
	cmp	cx, word ptr [bp-0Eh]	;@05CFE
	jne	@@5	;@05D01
	jmp	@@3	;@05D03
@@5:	call	@@19	;@05D05
	jmp	@@3	;@05D08
@@6:	cmp	word ptr [bp-6], -1	;@05D0A
	jne	@@7	;@05D0E
	jmp	@@16	;@05D10
@@7:	push	di	;@05D13
	and	di, 3	;@05D14
	shl	di, 1	;@05D17
	shl	di, 1	;@05D19
	shl	di, 1	;@05D1B
	mov	es, word ptr [di+758h]	;@05D1D
	pop	di	;@05D21
	mov	ax, word ptr [bp-90h]	;@05D22
	mov	word ptr es:[di+4], ax	;@05D26
	mov	ax, word ptr [bp-0Eh]	;@05D2A
	mov	word ptr es:[di+6], ax	;@05D2D
	mov	bx, word ptr [bp-6]	;@05D31
	mov	word ptr es:[di+2], bx	;@05D34
	mov	si, word ptr [bp-8]	;@05D38
	mov	word ptr es:[di], si	;@05D3B
	mov	word ptr es:[di+0Ah], 0FFFFh	;@05D3E
	cmp	si, -2	;@05D44
	jb	@@8	;@05D47
	jmp	@@16	;@05D49
@@8:	mov	es, word ptr ds:[780h]	;@05D4C
	mov	cx, word ptr es:[si+4]	;@05D50
	cmp	cx, -1	;@05D54
	je	@@9	;@05D57
	mov	cx, di	;@05D59
	xchg	word ptr es:[si+4], cx	;@05D5B
	push	di	;@05D5F
	and	di, 3	;@05D60
	shl	di, 1	;@05D63
	shl	di, 1	;@05D65
	shl	di, 1	;@05D67
	mov	es, word ptr [di+758h]	;@05D69
	pop	di	;@05D6D
	mov	word ptr es:[di+0Ah], cx	;@05D6E
	mov	es, word ptr ds:[780h]	;@05D72
@@9:	mov	cx, word ptr [bp-0Ah]	;@05D76
	add	word ptr es:[si+6], cx	;@05D79
	add	word ptr ds:[4A2h], cx	;@05D7D
	mov	bx, word ptr [bp-6]	;@05D81
	push	bx	;@05D84
	and	bx, 3	;@05D85
	shl	bx, 1	;@05D88
	shl	bx, 1	;@05D8A
	shl	bx, 1	;@05D8C
	mov	es, word ptr [bx+738h]	;@05D8E
	pop	bx	;@05D92
	add	word ptr es:[bx+0Eh], cx	;@05D93
	push	di	;@05D97
	push	bx	;@05D98
	call	L05BD5	;@05D99
	jae	@@10	;@05D9C
	jmp	@@16	;@05D9E
@@10:	mov	di, bx	;@05DA1
	mov	al, byte ptr es:[si+10h]	;@05DA3
	mov	bx, word ptr es:[si+2]	;@05DA7
	mov	cx, word ptr es:[si+4]	;@05DAB
	mov	dx, word ptr es:[si+6]	;@05DAF
	push	word ptr es:[si+0Ch]	;@05DB3
	push	word ptr es:[si+0Eh]	;@05DB7
	push	word ptr es:[si+0Ah]	;@05DBB
	push	word ptr es:[si+8]	;@05DBF
	push	di	;@05DC3
	and	di, 3	;@05DC4
	shl	di, 1	;@05DC7
	shl	di, 1	;@05DC9
	shl	di, 1	;@05DCB
	mov	es, word ptr [di+738h]	;@05DCD
	pop	di	;@05DD1
	cmp	byte ptr es:[di+10h], 0	;@05DD2
	jne	@@11	;@05DD7
	mov	byte ptr es:[di+10h], al	;@05DD9
@@11:	add	word ptr es:[di+24h], bx	;@05DDD
	pop	bx	;@05DE1
	add	word ptr es:[di+20h], bx	;@05DE2
	pop	bx	;@05DE6
	add	word ptr es:[di+28h], bx	;@05DE7
	add	word ptr es:[di+22h], cx	;@05DEB
	mov	ax, word ptr es:[di+28h]	;@05DEF
	cmp	ax, word ptr ds:[48Ch]	;@05DF3
	jbe	@@12	;@05DF7
	mov	word ptr ds:[48Ch], ax	;@05DF9
@@12:	cmp	dx, word ptr ds:[48Eh]	;@05DFC
	jbe	@@13	;@05E00
	mov	word ptr ds:[48Eh], dx	;@05E02
@@13:	add	word ptr es:[di+1Ch], dx	;@05E06
	pop	dx	;@05E0A
	add	word ptr es:[di+34h], dx	;@05E0B
	mov	dx, word ptr es:[di+34h]	;@05E0F
	cmp	dx, word ptr ds:[3C6h]	;@05E13
	jbe	@@14	;@05E17
	mov	word ptr ds:[3C6h], dx	;@05E19
@@14:	pop	dx	;@05E1D
	add	word ptr es:[di+32h], dx	;@05E1E
	mov	dx, word ptr es:[di+32h]	;@05E22
	cmp	dx, word ptr ds:[3C8h]	;@05E26
	jbe	@@15	;@05E2A
	mov	word ptr ds:[3C8h], dx	;@05E2C
@@15:	mov	es, word ptr ds:[7B0h]	;@05E30
	mov	si, word ptr es:[si]	;@05E34
	mov	es, word ptr ds:[788h]	;@05E37
	mov	si, word ptr es:[si]	;@05E3B
	push	si	;@05E3E
	and	si, 3	;@05E3F
	shl	si, 1	;@05E42
	shl	si, 1	;@05E44
	shl	si, 1	;@05E46
	mov	es, word ptr [si+758h]	;@05E48
	pop	si	;@05E4C
	mov	si, word ptr es:[si]	;@05E4D
	mov	es, word ptr ds:[780h]	;@05E50
	or	byte ptr es:[si+9], 1	;@05E54
@@16:	pop	di	;@05E59
	pop	si	;@05E5A
	mov	sp, bp	;@05E5B
	pop	bp	;@05E5D
	ret	;@05E5E
@@17:	cmp	word ptr [bp-6], -1	;@05E5F
	jne	@@18	;@05E63
	jmp	@@2	;@05E65
@@18:	call	@@19	;@05E68
	jmp	@@16	;@05E6B
@@19:	push	ax	;@05E6D
	push	bx	;@05E6E
	push	cx	;@05E6F
	push	dx	;@05E70
	push	si	;@05E71
	push	di	;@05E72
	push	di	;@05E73
	push	di	;@05E74
	and	di, 3	;@05E75
	shl	di, 1	;@05E78
	shl	di, 1	;@05E7A
	shl	di, 1	;@05E7C
	mov	es, word ptr [di+758h]	;@05E7E
	pop	di	;@05E82
	mov	si, word ptr es:[di+0Ch]	;@05E83
	push	si	;@05E87
	and	si, 3	;@05E88
	shl	si, 1	;@05E8B
	shl	si, 1	;@05E8D
	shl	si, 1	;@05E8F
	mov	es, word ptr [si+718h]	;@05E91
	pop	si	;@05E95
	cmp	byte ptr es:[si+3], 40h	;@05E96
	mov	di, 28h	;@05E9B
	je	@@20	;@05E9E
	db	0E8h, 9Dh, 38h	; call COPY_NAME	;@05EA0
	jmp	short @@21	;@05EA3
@@20:	push	bx	;@05EA5
	db	0E8h, 3Fh, 37h	; call L095E8	;@05EA6
	pop	bx	;@05EA9
@@21:	mov	si, word ptr [bp-6]	;@05EAA
	push	si	;@05EAD
	and	si, 3	;@05EAE
	shl	si, 1	;@05EB1
	shl	si, 1	;@05EB3
	shl	si, 1	;@05EB5
	mov	es, word ptr [si+738h]	;@05EB7
	pop	si	;@05EBB
	mov	si, word ptr es:[si]	;@05EBC
	mov	di, 78h	;@05EBF
	db	0E8h, 7Bh, 38h	; call COPY_NAME	;@05EC2
	push	bx	;@05EC5
	mov	ds, word ptr cs:L00100+16	;@05EC6
	push	ds	;@05ECB
	mov	ax, 78h	;@05ECC
	push	ax	;@05ECF
	push	cs	;@05ED0
	mov	ax, 5756h	;@05ED1
	push	ax	;@05ED4
	db	9Ah, 0Eh, 0, 0CFh, 0	; lcall 0xcf, 0xe	;@05ED5
	pop	bx	;@05EDA
	push	bx	;@05EDB
	push	ss	;@05EDC
	lea	ax, [bp-8Eh]	;@05EDD
	push	ax	;@05EE1
	push	bx	;@05EE2
	and	bx, 3	;@05EE3
	shl	bx, 1	;@05EE6
	shl	bx, 1	;@05EE8
	shl	bx, 1	;@05EEA
	mov	es, word ptr [bx+738h]	;@05EEC
	pop	bx	;@05EF0
	mov	si, word ptr es:[bx]	;@05EF1
	push	si	;@05EF4
	and	si, 3	;@05EF5
	shl	si, 1	;@05EF8
	shl	si, 1	;@05EFA
	shl	si, 1	;@05EFC
	mov	es, word ptr [si+718h]	;@05EFE
	pop	si	;@05F02
	inc	si	;@05F03
	inc	si	;@05F04
	push	es	;@05F05
	push	si	;@05F06
	db	0E8h, 0A4h, 33h	; call PSTRING_TO_ASCIZ	;@05F07
	push	ds	;@05F0A
	mov	ax, 78h	;@05F0B
	push	ax	;@05F0E
	push	ss	;@05F0F
	lea	ax, [bp-8Eh]	;@05F10
	push	ax	;@05F14
	db	9Ah, 0Eh, 0, 0CFh, 0	; lcall 0xcf, 0xe	;@05F15
	push	ds	;@05F1A
	mov	ax, 78h	;@05F1B
	push	ax	;@05F1E
	push	ds	;@05F1F
	mov	ax, 28h	;@05F20
	push	ax	;@05F23
	mov	cx, 8	;@05F24
	push	cx	;@05F27
	mov	ax, 33h	;@05F28
	push	ax	;@05F2B
	db	0E8h, 7Ch, 5Ch	; call WARNING	;@05F2C
	pop	bx	;@05F2F
	pop	di	;@05F30
	pop	di	;@05F31
	pop	si	;@05F32
	pop	dx	;@05F33
	pop	cx	;@05F34
	pop	bx	;@05F35
	pop	ax	;@05F36
	ret	;@05F37
COMMON_TOO_BIG:	push	bp	;@05F38
	mov	bp, sp	;@05F39
	sub	sp, 0Ah	;@05F3B
	mov	word ptr [bp-0Ah], 0FFFFh	;@05F3E
	push	ax	;@05F43
	push	bx	;@05F44
	push	cx	;@05F45
	push	dx	;@05F46
	push	si	;@05F47
	push	di	;@05F48
	call	CHECK_CONFLICT	;@05F49
	mov	si, di	;@05F4C
	push	si	;@05F4E
	and	si, 3	;@05F4F
	shl	si, 1	;@05F52
	shl	si, 1	;@05F54
	shl	si, 1	;@05F56
	mov	es, word ptr [si+758h]	;@05F58
	pop	si	;@05F5C
	mov	ax, word ptr es:[si+2]	;@05F5D
	mov	word ptr [bp-2], ax	;@05F61
	cmp	ax, 0FFFFh	;@05F64
	jne	@@1	;@05F67
	jmp	@@12	;@05F69
@@1:	mov	ax, word ptr es:[si+4]	;@05F6C
	mov	word ptr [bp-4], ax	;@05F70
	mov	ax, word ptr es:[si+6]	;@05F73
	mov	word ptr [bp-6], ax	;@05F77
	mov	di, word ptr es:[si]	;@05F7A
	mov	word ptr [bp-8], di	;@05F7D
	cmp	di, -2	;@05F80
	jae	@@2	;@05F83
	jmp	@@10	;@05F85
@@2:	jne	@@8	;@05F88
	mov	dx, word ptr [bp-6]	;@05F8A
	mov	ax, word ptr [bp-4]	;@05F8D
	mov	cx, 60h	;@05F90
	jmp	short @@5	;@05F93
@@3:	cmp	dx, 1	;@05F95
	jb	@@7	;@05F98
	ja	@@4	;@05F9A
	cmp	ax, 0	;@05F9C
	je	@@7	;@05F9F
@@4:	push	dx	;@05FA1
	push	ax	;@05FA2
	mov	dx, 1	;@05FA3
	xor	ax, ax	;@05FA6
	call	@@14	;@05FA8
	mov	cx, 20h	;@05FAB
	pop	ax	;@05FAE
	pop	dx	;@05FAF
	sub	ax, 0	;@05FB0
	sbb	dx, 1	;@05FB3
	jmp	short @@5	;@05FB6
@@5:	cmp	dx, 0	;@05FB8
	ja	@@3	;@05FBB
	cmp	ax, 0	;@05FBD
	jne	@@3	;@05FC0
@@6:	xor	ax, ax	;@05FC2
	push	si	;@05FC4
	and	si, 3	;@05FC5
	shl	si, 1	;@05FC8
	shl	si, 1	;@05FCA
	shl	si, 1	;@05FCC
	mov	es, word ptr [si+758h]	;@05FCE
	pop	si	;@05FD2
	mov	word ptr es:[si+6], ax	;@05FD3
	mov	word ptr es:[si+4], ax	;@05FD7
	mov	ax, word ptr [bp-0Ah]	;@05FDB
	mov	word ptr es:[si], ax	;@05FDE
	and	byte ptr es:[si+0Eh], 0F7h	;@05FE1
	jmp	@@12	;@05FE6
@@7:	call	@@14	;@05FE9
	jmp	@@6	;@05FEC
@@8:	mov	di, word ptr ds:[43Eh]	;@05FEE
	cmp	di, -1	;@05FF2
	jne	@@10	;@05FF5
	call	L05A3C	;@05FF7
	mov	word ptr ds:[43Eh], di	;@05FFA
	mov	ax, word ptr ds:[42Ah]	;@05FFE
	mov	word ptr es:[di], ax	;@06001
	mov	es, word ptr ds:[780h]	;@06004
	mov	ax, word ptr ds:[424h]	;@06008
	mov	word ptr es:[di], ax	;@0600B
	mov	dx, word ptr ds:[426h]	;@0600E
	mov	al, 48h	;@06012
	mov	es, word ptr ds:[778h]	;@06014
	mov	byte ptr es:[di+9], al	;@06018
	mov	word ptr es:[di+2], dx	;@0601C
	mov	ax, word ptr [bp-2]	;@06020
	mov	word ptr es:[di+4], ax	;@06023
	xchg	ax, di	;@06027
	push	ax	;@06028
	mov	di, 2	;@06029
	push	di	;@0602C
	mov	di, 7BCh	;@0602D
	call	POOL_ALLOC	;@06030
	jae	@@9	;@06033
	call	L054B0	;@06035
@@9:	pop	ax	;@06038
	mov	word ptr es:[di], ax	;@06039
	xchg	ax, di	;@0603C
@@10:	mov	es, word ptr ds:[778h]	;@0603D
	mov	ax, word ptr es:[di+6]	;@06041
	push	ax	;@06045
	add	ax, word ptr [bp-4]	;@06046
	mov	word ptr es:[di+6], ax	;@06049
	mov	al, byte ptr es:[di+8]	;@0604D
	mov	ah, 0	;@06051
	push	ax	;@06053
	adc	ax, word ptr [bp-6]	;@06054
	mov	byte ptr es:[di+8], al	;@06057
	cmp	byte ptr ds:[127h], 0	;@0605B
	jne	@@11	;@06060
	cmp	ax, 0	;@06062
	jne	@@13	;@06065
@@11:	push	si	;@06067
	and	si, 3	;@06068
	shl	si, 1	;@0606B
	shl	si, 1	;@0606D
	shl	si, 1	;@0606F
	mov	es, word ptr [si+758h]	;@06071
	pop	si	;@06075
	pop	word ptr es:[si+6]	;@06076
	pop	word ptr es:[si+4]	;@0607A
	mov	word ptr es:[si], di	;@0607E
	and	byte ptr es:[si+0Eh], 0F7h	;@06081
@@12:	pop	di	;@06086
	pop	si	;@06087
	pop	dx	;@06088
	pop	cx	;@06089
	pop	bx	;@0608A
	pop	ax	;@0608B
	mov	sp, bp	;@0608C
	pop	bp	;@0608E
	ret	;@0608F
@@13:	cmp	word ptr [bp-8], -1	;@06090
	jne	@@11	;@06094
	cmp	word ptr ds:[0A41h], -1	;@06096
	jne	@@11	;@0609B
	mov	word ptr ds:[0A41h], 1	;@0609D
	push	ax	;@060A3
	push	bx	;@060A4
	push	cx	;@060A5
	push	dx	;@060A6
	push	si	;@060A7
	push	di	;@060A8
	xor	ax, ax	;@060A9
	push	ax	;@060AB
	mov	ax, 2Ah	;@060AC
	push	ax	;@060AF
	db	0E8h, 0F3h, 5Ah	; call ERROR	;@060B0
	pop	di	;@060B3
	pop	si	;@060B4
	pop	dx	;@060B5
	pop	cx	;@060B6
	pop	bx	;@060B7
	pop	ax	;@060B8
	jmp	@@11	;@060B9
@@14:	push	cx	;@060BB
	push	dx	;@060BC
	push	ax	;@060BD
	push	cx	;@060BE
	mov	ax, word ptr ds:[43Ch]	;@060BF
	inc	ax	;@060C2
	mov	word ptr ds:[43Ch], ax	;@060C3
	mov	dl, 1Ah	;@060C6
	div	dl	;@060C8
	add	ax, 4141h	;@060CA
	push	si	;@060CD
	mov	si, 440h	;@060CE
	mov	byte ptr [si], 0Bh	;@060D1
	mov	word ptr [si+1], 435Fh	;@060D4
	mov	word ptr [si+3], 4D4Fh	;@060D9
	mov	word ptr [si+5], 4544h	;@060DE
	mov	word ptr [si+7], 5F46h	;@060E3
	mov	word ptr [si+9], ax	;@060E8
	mov	byte ptr [si+0Bh], 5Fh	;@060EB
	mov	ah, 80h	;@060EF
	mov	word ptr ds:[5250h], ds	;@060F1
	db	0E8h, 22h, 2Dh	; call L08E1A	;@060F5
	push	bx	;@060F8
	call	L05A3C	;@060F9
	pop	bx	;@060FC
	mov	word ptr es:[di], bx	;@060FD
	mov	ax, word ptr ds:[3D8h]	;@06100
	inc	ax	;@06103
	mov	word ptr ds:[3D8h], ax	;@06104
	push	bx	;@06107
	and	bx, 3	;@06108
	shl	bx, 1	;@0610B
	shl	bx, 1	;@0610D
	shl	bx, 1	;@0610F
	mov	es, word ptr [bx+718h]	;@06111
	pop	bx	;@06115
	mov	word ptr es:[bx], ax	;@06116
	mov	es, word ptr ds:[780h]	;@06119
	mov	word ptr es:[di], 0FFFFh	;@0611D
	pop	si	;@06122
	mov	es, word ptr ds:[778h]	;@06123
	pop	cx	;@06127
	mov	byte ptr es:[di+9], cl	;@06128
	mov	dx, word ptr ds:[428h]	;@0612C
	mov	word ptr es:[di+2], dx	;@06130
	mov	ax, word ptr [bp-2]	;@06134
	mov	word ptr es:[di+4], ax	;@06137
	xchg	ax, di	;@0613B
	push	ax	;@0613C
	mov	di, 2	;@0613D
	push	di	;@06140
	mov	di, 7BCh	;@06141
	call	POOL_ALLOC	;@06144
	jae	@@15	;@06147
	call	L054B0	;@06149
@@15:	pop	ax	;@0614C
	mov	word ptr es:[di], ax	;@0614D
	xchg	ax, di	;@06150
	pop	ax	;@06151
	pop	dx	;@06152
	mov	es, word ptr ds:[778h]	;@06153
	mov	word ptr es:[di+6], ax	;@06157
	mov	byte ptr es:[di+8], dl	;@0615B
	cmp	word ptr [bp-0Ah], -1	;@0615F
	jne	@@16	;@06163
	mov	word ptr [bp-0Ah], di	;@06165
@@16:	pop	cx	;@06168
	ret	;@06169
@@17:	push	ax	;@0616A
	push	bx	;@0616B
	push	cx	;@0616C
	push	dx	;@0616D
	push	si	;@0616E
	push	di	;@0616F
	xor	di, di	;@06170
	push	di	;@06172
	mov	bx, 754h	;@06173
@@18:	push	di	;@06176
	and	di, 3	;@06177
	shl	di, 1	;@0617A
	shl	di, 1	;@0617C
	shl	di, 1	;@0617E
	mov	es, word ptr [di+758h]	;@06180
	pop	di	;@06184
	jmp	short @@22	;@06185
@@19:	test	byte ptr es:[di+0Eh], 14h	;@06187
	jne	@@21	;@0618C
	test	byte ptr es:[di+0Eh], 8	;@0618E
	je	@@21	;@06193
	push	bx	;@06195
	mov	bx, word ptr es:[di+2]	;@06196
	push	bx	;@0619A
	and	bx, 3	;@0619B
	shl	bx, 1	;@0619E
	shl	bx, 1	;@061A0
	shl	bx, 1	;@061A2
	mov	es, word ptr [bx+738h]	;@061A4
	pop	bx	;@061A8
	mov	ax, word ptr es:[bx+0Ah]	;@061A9
	pop	bx	;@061AD
	push	di	;@061AE
	and	di, 3	;@061AF
	shl	di, 1	;@061B2
	shl	di, 1	;@061B4
	shl	di, 1	;@061B6
	mov	es, word ptr [di+758h]	;@061B8
	pop	di	;@061BC
	cmp	ax, 2	;@061BD
	jae	@@20	;@061C0
	cmp	byte ptr es:[di+0Eh], 1	;@061C2
	je	@@21	;@061C7
@@20:	call	COMMON_TOO_BIG	;@061C9
@@21:	add	di, word ptr ds:[490h]	;@061CC
@@22:	cmp	di, word ptr [bx+2]	;@061D0
	jb	@@19	;@061D3
	cmp	bx, 764h	;@061D5
	ja	@@23	;@061D9
	add	bx, 8	;@061DB
	pop	di	;@061DE
	inc	di	;@061DF
	push	di	;@061E0
	jmp	@@18	;@061E1
@@23:	pop	ax	;@061E3
	mov	word ptr ds:[7A6h], 0	;@061E4
	mov	di, 7A4h	;@061EA
	call	L056F5	;@061ED
	pop	di	;@061F0
	pop	si	;@061F1
	pop	dx	;@061F2
	pop	cx	;@061F3
	pop	bx	;@061F4
	pop	ax	;@061F5
	ret	;@061F6
@@24:	push	si	;@061F7
	and	si, 3	;@061F8
	shl	si, 1	;@061FB
	shl	si, 1	;@061FD
	shl	si, 1	;@061FF
	mov	es, word ptr [si+738h]	;@06201
	pop	si	;@06205
	cmp	word ptr es:[si+0Ah], 2	;@06206
	jb	@@25	;@0620B
	ret	;@0620D
@@25:	push	bp	;@0620E
	mov	bp, sp	;@0620F
	sub	sp, 2	;@06211
	push	bx	;@06214
	push	cx	;@06215
	push	di	;@06216
	mov	di, si	;@06217
	and	di, 3	;@06219
	shl	di, 1	;@0621C
	shl	di, 1	;@0621E
	shl	di, 1	;@06220
	lea	di, [di+734h]	;@06222
	mov	word ptr es:[si+0Ah], 2	;@06226
	push	si	;@0622C
	add	ax, word ptr es:[si+0Eh]	;@0622D
	cmp	si, word ptr ds:[186h]	;@06231
	jne	@@26	;@06235
	mov	cx, word ptr ds:[188h]	;@06237
	add	cx, 2	;@0623B
	mov	word ptr [bp-2], 0FFFFh	;@0623E
	jmp	short @@27	;@06243
@@26:	mov	bl, byte ptr es:[si+10h]	;@06245
	mov	bh, 0	;@06249
	mov	bx, word ptr cs:[bx+5750h]	;@0624B
	push	si	;@06250
	add	si, bx	;@06251
	mov	word ptr [bp-2], si	;@06253
	cmp	si, word ptr [di+2]	;@06256
	pop	si	;@06259
	jae	@@30	;@0625A
	mov	cx, word ptr es:[bx+si+4]	;@0625C
@@27:	mov	bx, word ptr es:[si+4]	;@06260
@@28:	cmp	bx, cx	;@06264
	jb	@@29	;@06266
	jmp	@@33	;@06268
@@29:	mov	es, word ptr ds:[788h]	;@0626B
	mov	si, word ptr es:[bx]	;@0626F
	push	si	;@06272
	and	si, 3	;@06273
	shl	si, 1	;@06276
	shl	si, 1	;@06278
	shl	si, 1	;@0627A
	mov	es, word ptr [si+758h]	;@0627C
	pop	si	;@06280
	or	byte ptr es:[si+0Eh], 1	;@06281
	test	byte ptr es:[si+0Eh], 18h	;@06286
	jne	@@32	;@0628B
	cmp	byte ptr ds:[19h], 0	;@0628D
	je	@@31	;@06292
	test	byte ptr es:[si+0Eh], 20h	;@06294
	je	@@31	;@06299
	mov	si, word ptr es:[si+2]	;@0629B
	mov	es, word ptr ds:[808h]	;@0629F
	mov	word ptr es:[si+6], 0FFFFh	;@062A3
	jmp	short @@32	;@062A9
@@30:	mov	bx, word ptr es:[si+4]	;@062AB
	add	di, 8	;@062AF
	push	si	;@062B2
	and	si, 3	;@062B3
	inc	si	;@062B6
	push	si	;@062B7
	and	si, 3	;@062B8
	shl	si, 1	;@062BB
	shl	si, 1	;@062BD
	shl	si, 1	;@062BF
	mov	es, word ptr [si+738h]	;@062C1
	pop	si	;@062C5
	mov	cx, word ptr es:[si+4]	;@062C6
	mov	word ptr [bp-2], si	;@062CA
	pop	si	;@062CD
	push	si	;@062CE
	and	si, 3	;@062CF
	shl	si, 1	;@062D2
	shl	si, 1	;@062D4
	shl	si, 1	;@062D6
	mov	es, word ptr [si+738h]	;@062D8
	pop	si	;@062DC
	jmp	@@28	;@062DD
@@31:	mov	si, word ptr es:[si+2]	;@062DF
	call	@@24	;@062E3
@@32:	add	bx, 2	;@062E6
	jmp	@@28	;@062E9
@@33:	pop	si	;@062EC
	push	si	;@062ED
	and	si, 3	;@062EE
	shl	si, 1	;@062F1
	shl	si, 1	;@062F3
	shl	si, 1	;@062F5
	mov	es, word ptr [si+738h]	;@062F7
	pop	si	;@062FB
	inc	dx	;@062FC
	mov	word ptr es:[si+0Ah], dx	;@062FD
	mov	bx, word ptr es:[si+2]	;@06301
	push	si	;@06305
	mov	si, word ptr [bp-2]	;@06306
	cmp	si, -1	;@06309
	jne	@@34	;@0630C
	mov	cx, word ptr ds:[0A4Bh]	;@0630E
	add	cx, 0Ah	;@06312
	jmp	short @@35	;@06315
@@34:	push	si	;@06317
	and	si, 3	;@06318
	shl	si, 1	;@0631B
	shl	si, 1	;@0631D
	shl	si, 1	;@0631F
	mov	es, word ptr [si+738h]	;@06321
	pop	si	;@06325
	mov	cx, word ptr es:[si+2]	;@06326
@@35:	pop	si	;@0632A
@@36:	cmp	bx, cx	;@0632B
	jae	@@40	;@0632D
	mov	es, word ptr ds:[778h]	;@0632F
	push	ax	;@06333
	mov	ax, word ptr es:[bx+2]	;@06334
	cmp	ax, word ptr ds:[432h]	;@06338
	je	@@39	;@0633C
	cmp	ax, word ptr ds:[434h]	;@0633E
	je	@@39	;@06342
	pop	ax	;@06344
	mov	di, 2	;@06345
	push	di	;@06348
	mov	di, 7BCh	;@06349
	call	POOL_ALLOC	;@0634C
	jae	@@37	;@0634F
	call	L054B0	;@06351
@@37:	mov	word ptr es:[di], bx	;@06354
@@38:	add	bx, 0Ah	;@06357
	jmp	@@36	;@0635A
@@39:	pop	ax	;@0635C
	mov	byte ptr es:[bx+9], 0FFh	;@0635D
	jmp	@@38	;@06362
@@40:	pop	di	;@06364
	pop	cx	;@06365
	pop	bx	;@06366
	mov	sp, bp	;@06367
	pop	bp	;@06369
	ret	;@0636A
	xor	ax, ax	;@0636B
	mov	dx, 2	;@0636D
	mov	si, word ptr ds:[3F6h]	;@06370
	cmp	si, -1	;@06374
	je	@@42	;@06377
	cmp	byte ptr ds:[19h], 1	;@06379
	jne	@@41	;@0637E
	push	si	;@06380
	and	si, 3	;@06381
	shl	si, 1	;@06384
	shl	si, 1	;@06386
	shl	si, 1	;@06388
	mov	es, word ptr [si+738h]	;@0638A
	pop	si	;@0638E
	cmp	word ptr es:[si+0Ah], 1	;@0638F
	je	@@42	;@06394
@@41:	call	@@24	;@06396
@@42:	push	di	;@06399
	xor	si, si	;@0639A
	push	si	;@0639C
	mov	di, 734h	;@0639D
	push	si	;@063A0
	and	si, 3	;@063A1
	shl	si, 1	;@063A4
	shl	si, 1	;@063A6
	shl	si, 1	;@063A8
	mov	es, word ptr [si+738h]	;@063AA
	pop	si	;@063AE
@@43:	cmp	word ptr es:[si+0Ah], 0	;@063AF
	jne	@@44	;@063B4
	call	@@24	;@063B6
@@44:	cmp	si, word ptr ds:[184h]	;@063B9
	je	@@47	;@063BD
	push	si	;@063BF
	and	si, 3	;@063C0
	shl	si, 1	;@063C3
	shl	si, 1	;@063C5
	shl	si, 1	;@063C7
	mov	es, word ptr [si+738h]	;@063C9
	pop	si	;@063CD
	mov	bl, byte ptr es:[si+10h]	;@063CE
	mov	bh, 0	;@063D2
	add	si, word ptr cs:[bx+5750h]	;@063D4
	cmp	si, word ptr [di+2]	;@063D9
	jae	@@45	;@063DC
	push	si	;@063DE
	add	si, 38h	;@063DF
	cmp	si, -80h	;@063E2
	pop	si	;@063E5
	jb	@@43	;@063E6
@@45:	cmp	di, 744h	;@063E8
	jbe	@@46	;@063EC
	jmp	short @@47	;@063EE
@@46:	add	di, 8	;@063F0
	and	si, 3	;@063F3
	inc	si	;@063F6
	push	si	;@063F7
	and	si, 3	;@063F8
	shl	si, 1	;@063FB
	shl	si, 1	;@063FD
	shl	si, 1	;@063FF
	mov	es, word ptr [si+738h]	;@06401
	pop	si	;@06405
	jmp	@@43	;@06406
@@47:	add	sp, 2	;@06408
	pop	di	;@0640B
	mov	word ptr ds:[3DAh], dx	;@0640C
	mov	word ptr ds:[4A2h], ax	;@06410
	call	@@17	;@06413
	ret	;@06416
	db	0BEh, 0B6h, 0, 0B4h, 0, 0C7h, 6, 50h, 52h, 97h, 1, 0E8h, 2, '+rCS'	;@06417
	db	83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h
	db	7, 5Bh, 26h, 0F6h, 47h, 0Eh, 18h, 'u-&', 8Bh, 5Fh, 2, 53h, 83h
	db	0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 38h, 7
	db	5Bh, 26h, 83h, 7Fh, 0Ah, 2, 73h, 13h, 8Bh, 16h, 0DAh, 3, 8Bh, 0F3h
	db	33h, 0C0h, 0E8h, 95h, 0FDh, 89h, 16h, 0DAh, 3, 1, 6, 0A2h, 4, 0C3h
	db	53h, 50h, 8Eh, 6, 78h, 7, 26h, 0F6h, 44h, 9, 0E0h, 't<&', 0F6h
	db	45h, 9, 0E0h, 't8&', 8Bh, 5Dh, 2, 26h, 8Bh, 44h, 2, 3Bh, 0C3h
	db	't/=', 0FFh, 0FFh, 74h, 24h, 83h, 0FBh, 0FFh, 74h, 22h, 80h, 3Eh
	db	88h, 4, 0, 'tn;', 6, 4Eh, 4, 74h, 15h, 3Bh, 1Eh, 4Eh, 4, 74h, 0Ch
	db	3Bh, 6, 50h, 4, 74h, 9, 3Bh, 1Eh, 50h, 4, 75h, 56h, 0F9h, 0EBh
	db	4Ah, 0F8h, 0EBh, 47h, 26h, 8Bh, 4, 26h, 3Bh, 5, 't+P&', 8Bh, 1Dh
	db	53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h
	db	18h, 7, 5Bh, 26h, 8Bh, 7, 5Bh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h
	db	0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, '[&9', 7, 0EBh, 14h, 80h, 3Eh
	db	0D7h, 3, 1, 75h, 0Bh, 0A1h, 3Ah, 4, 3Bh, 0F0h, 74h, 0B9h, 3Bh
	db	0F8h, 74h, 0B8h, 3Bh, 0F7h, 9Fh, 8Eh, 6, 0C0h, 7, 9Eh, 58h, 5Bh
	db	0C3h, 80h, 3Eh, 0D7h, 3, 1, 't/&', 0FFh, 74h, 2, 26h, 8Bh, 5Dh
	db	2, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh
	db	87h, 18h, 7, 5Bh, 26h, 8Bh, 7, 5Bh, 53h, 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7, '[&9', 7, 0EBh, 0C1h
	db	'VWQVW&', 8Bh, 74h, 2, 26h, 8Bh, 7Dh, 2, 56h, 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 18h, 7, 5Eh, 33h, 0C9h
	db	26h, 8Ah, 44h, 2, 25h, 3Fh, 0, 3Dh, 4, 0, 72h, 14h, 3, 0F0h, 26h
	db	81h, 7Ch, 0FFh, 'COu', 0Ah, 26h, 81h, 7Ch, 1, 'DEu', 2, 0FEh, 0C1h
	db	57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h, 0D1h, 0E7h, 8Eh, 85h
	db	18h, 7, 5Fh, 26h, 8Ah, 45h, 2, 25h, 3Fh, 0, 3Dh, 4, 0, 72h, 14h
	db	3, 0F8h, 26h, 81h, 7Dh, 0FFh, 'COu', 0Ah, 26h, 81h, 7Dh, 1, 'DEu'
	db	2, 0FEh, 0C5h, 5Fh, 5Eh, 8Eh, 6, 78h, 7, 3Ah, 0E9h, 74h, 3, 0E9h
	db	0B3h, 0, 23h, 0C9h, 75h, 4Ah, 0A1h, 2Ch, 4, '&;D', 2, 75h, 2, 0FEh
	db	0C1h, '&;E', 2, 75h, 2, 0FEh, 0C5h, 3Ah, 0CDh, 74h, 3, 0E9h, 95h
	db	0, 23h, 0C9h, 74h, 3, 0E9h, 94h, 0, 33h, 0C9h, 0A1h, 24h, 4, 8Eh
	db	6, 80h, 7, 26h, 3Bh, 4, 75h, 2, 0FEh, 0C1h, 26h, 3Bh, 5, 75h, 2
	db	0FEh, 0C5h, 3Ah, 0CDh, 'us#', 0C9h, 'u)Y_^', 8Eh, 6, 78h, 7, 0E9h
	db	9, 0FFh, 33h, 0C9h, 0A1h, 30h, 4, 8Eh, 6, 78h, 7, '&;D', 2, 75h
	db	2, 0FEh, 0C1h, '&;E', 2, 75h, 2, 0FEh, 0C5h, 3Ah, 0CDh, 75h, 48h
	db	0EBh, 4Ch, 33h, 0C9h, 0A1h, 2Eh, 4, 8Eh, 6, 78h, 7, '&;D', 2, 75h
	db	2, 0FEh, 0C1h, '&;E', 2, 75h, 2, 0FEh, 0C5h, 3Ah, 0E9h, 'u)#'
	db	0C9h, 'u+3', 0C9h, 0A1h, 26h, 4, '&;D', 2, 75h, 2, 0FEh, 0C1h
	db	'&;E', 2, 75h, 2, 0FEh, 0C5h, 3Ah, 0CDh, 75h, 0Ch, 23h, 0C9h, 75h
	db	0Eh, 'Y_^', 0E9h, 0A6h, 0FEh, 3Ah, 0CDh, 'Y_^', 0E9h, 8Eh, 0FEh
	db	32h, 0C0h, 0EBh, 0F6h
	push	ax	;@06677
	push	cx	;@06678
	push	si	;@06679
	mov	ax, word ptr es:[bx+4]	;@0667A
	mov	si, word ptr es:[di+4]	;@0667E
	mov	word ptr es:[di+4], bx	;@06682
	mov	es, word ptr ds:[778h]	;@06686
	mov	cx, word ptr es:[bx+6]	;@0668A
@@48:	cmp	si, -1	;@0668E
	je	@@49	;@06691
	push	si	;@06693
	and	si, 3	;@06694
	shl	si, 1	;@06697
	shl	si, 1	;@06699
	shl	si, 1	;@0669B
	mov	es, word ptr [si+758h]	;@0669D
	pop	si	;@066A1
	push	word ptr es:[si+0Ah]	;@066A2
	mov	word ptr es:[si+8], cx	;@066A6
	mov	word ptr es:[si+0Ah], ax	;@066AA
	mov	ax, si	;@066AE
	add	cx, 5	;@066B0
	pop	si	;@066B3
	jmp	@@48	;@066B4
@@49:	mov	es, word ptr ds:[780h]	;@066B6
	mov	word ptr es:[bx+4], ax	;@066BA
	mov	es, word ptr ds:[778h]	;@066BE
	mov	word ptr es:[bx+6], cx	;@066C2
	pop	si	;@066C6
	pop	cx	;@066C7
	pop	ax	;@066C8
	ret	;@066C9
	db	55h, 8Bh, 0ECh, 8Dh, 66h, 0FAh, 'VW3', 0F6h, 0A1h, 76h, 7, 89h	;@066CA
	db	46h, 0FEh, 8Eh, 6, 80h, 7, 0EBh, 6, 0E9h, 81h, 0, 83h, 0C6h, 0Ah
	db	3Bh, 76h, 0FEh, 73h, 0F5h, 26h, 83h, 7Ch, 2, 0FFh, 74h, 0F1h, 26h
	db	8Bh, 14h, 8Eh, 6, 78h, 7, 0E8h, 0A0h, 2Bh, 88h, 46h, 0FCh, 8Bh
	db	0FEh, 3Ch, 3, 7Ch, 40h, 0E8h, 34h, 0F3h, 26h, 0C6h, 45h, 9, 60h
	db	26h, 8Bh, 0Ch, 26h, 89h, 0Dh, 26h, 8Bh, 4Ch, 4, 26h, 89h, 4Dh
	db	4, 8Bh, 0Eh, 52h, 4, 26h, 89h, 4Dh, 2, 26h, 0C7h, 45h, 6, 20h
	db	0, 8Bh, 0DFh, 0BFh, 2, 0, 57h, 0BFh, 0BCh, 7, 0E8h, 88h, 0EDh
	db	73h, 3, 0E8h, 76h, 0EDh, 26h, 89h, 1Dh, 8Eh, 6, 80h, 7, 8Bh, 0FEh
	db	0EBh, 1Ah, 0B8h, 0FFh, 0FFh, 8Eh, 6, 80h, 7, 26h, 87h, 45h, 2
	db	3Dh, 0FEh, 0FFh, 74h, 8Eh, 97h, 26h, 89h, 15h, 80h, 7Eh, 0FCh
	db	3, 75h, 0E6h, 0E8h, 15h, 0FFh, 0EBh, 0E1h, 5Fh, 5Eh, 8Bh, 0E5h
	db	5Dh, 0C3h, 51h, 52h, 8Eh, 6, 80h, 7, 26h, 8Bh, 0Ch, 0EBh, 7, 8Eh
	db	6, 80h, 7, 83h, 0C3h, 0Ah, 3Bh, 0DEh, 's7&;', 0Fh, 75h, 5, 83h
	db	0F9h, 0FFh, 75h, 13h, 8Eh, 6, 78h, 7, 26h, 3Bh, 7, 75h, 0E2h, 26h
	db	8Bh, 54h, 2, '&;W', 2, 75h, 0D8h, 8Eh, 6, 78h, 7, 26h, 8Ah, 77h
	db	9, 80h, 0FEh, 0FFh, 74h, 0CBh, 0F6h, 0C6h, 1Ch, 74h, 0C6h, 0F6h
	db	0C6h, 2, 75h, 0C1h, 5Ah, 59h, 0C3h, 83h, 0F9h, 0FFh, 75h, 0F8h
	db	83h, 0C3h, 0Ah, 3Bh, 1Eh, 76h, 7, 73h, 0EFh, 8Eh, 6, 80h, 7, 26h
	db	3Bh, 0Fh, 74h, 0EEh, 8Eh, 6, 78h, 7, 26h, 3Bh, 7, 75h, 0E5h, 26h
	db	8Bh, 54h, 2, '&;W', 2, 75h, 0DBh, 26h, 8Ah, 77h, 9, 80h, 0FEh
	db	0FFh, 74h, 0D2h, 0F6h, 0C6h, 1Ch, 74h, 0CDh, 0F6h, 0C6h, 2, 75h
	db	0C8h, 8Eh, 6, 80h, 7, 26h, 8Bh, 0Fh, 26h, 89h, 0Ch, 0EBh, 0B4h
	db	55h, 8Bh, 0ECh, 'VW3', 0F6h, 0EBh, 0Ch, 8Eh, 6, 78h, 7, 26h, 0C6h
	db	44h, 9, 0FFh, 83h, 0C6h, 0Ah, ';6v', 7, 73h, 73h, 8Eh, 6, 78h
	db	7, 26h, 8Ah, 54h, 9, 80h, 0FAh, 0FFh, 74h, 0EAh, 26h, 8Bh, 5Ch
	db	4, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh
	db	87h, 38h, 7, 5Bh, 26h, 8Bh, 47h, 0Ah, 3Dh, 1, 0, 74h, 0C5h, 8Eh
	db	6, 80h, 7, 26h, 0C7h, 44h, 2, 0FEh, 0FFh, 0F6h, 0C2h, 1Ch, 74h
	db	0BFh, 0F6h, 0C2h, 2, 75h, 0BAh, 8Eh, 6, 78h, 7, 26h, 8Bh, 4, 33h
	db	0DBh, 0E8h, 6, 0FFh, 3Bh, 0DEh, 73h, 0AAh, 8Eh, 6, 80h, 7, 26h
	db	8Bh, 4, 3Dh, 0FFh, 0FFh, 74h, 0Eh, 26h, 39h, 7, 74h, 9, 26h, 83h
	db	3Fh, 0FFh, 75h, 18h, 26h, 89h, 7, 8Bh, 0C6h, 26h, 87h, 47h, 2
	db	26h, 89h, 44h, 2, 0EBh, 84h, 0E8h, 39h, 0FEh, 5Fh, 5Eh, 8Bh, 0E5h
	db	5Dh, 0C3h, 'SVW', 8Eh, 6, 78h, 7, 26h, 0FFh, 34h, 8Eh, 6, 80h
	db	7, 26h, 0FFh, 37h, 0BFh, 78h, 0, 8Bh, 0F0h, 0E8h, 90h, 2Eh, 1Eh
	db	0B8h, 78h, 0, 50h, 0Eh, 0B8h, 'bWP', 9Ah, 0Eh, 0, 0CFh, 0, 0BFh
	db	28h, 0, 5Eh, 0E8h, 7Ah, 2Eh, 1Eh, 0B8h, 78h, 0, 50h, 1Eh, 0B8h
	db	28h, 0, 50h, 9Ah, 0Eh, 0, 0CFh, 0, 5Eh, 0BFh, 28h, 0, 0E8h, 64h
	db	2Eh, 1Eh, 0B8h, 78h, 0, 50h, 1Eh, 0B8h, 28h, 0, 50h, 0B9h, 8, 0
	db	51h, 0B8h, 35h, 0, 50h, 0E8h, 0BAh, 'R_^[', 8Eh, 6, 80h, 7, 0EBh
	db	88h, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ch, 'RVW', 80h, 3Eh, 28h, 1, 1
	db	75h, 6, 0BFh, 0ECh, 7, 0E8h, 0C6h, 0ECh, 33h, 0FFh, 8Bh, 0CFh
	db	0BBh, 0FFh, 0FFh, 3Bh, 3Eh, 0BEh, 7, 72h, 3, 0E9h, 37h, 1, 89h
	db	7Eh, 0FAh, 8Eh, 6, 0C0h, 7, 26h, 8Bh, 35h, 8Eh, 6, 78h, 7, 0E8h
	db	6Bh, 29h, 88h, 46h, 0F6h, 3Ch, 0FFh, 75h, 0Bh, 83h, 3Eh, 3Bh, 0Ah
	db	0FFh, 75h, 4, 89h, 36h, 3Bh, 0Ah, 26h, 8Ah, 44h, 9, 3Ch, 0FFh
	db	75h, 3, 0E9h, 0EEh, 0, 0A8h, 0E0h, 74h, 0Eh, 24h, 1Ch, 74h, 0Ah
	db	26h, 3Bh, 1Ch, 'tJ&', 8Bh, 1Ch, 8Bh, 0CEh, 26h, 8Bh, 44h, 6, 89h
	db	46h, 0FEh, 26h, 8Ah, 44h, 8, 0B4h, 0, 89h, 46h, 0FCh, 8Eh, 6, 80h
	db	7, 26h, 89h, 74h, 2, 80h, 3Eh, 28h, 1, 1, 75h, 23h, 0BFh, 6, 0
	db	57h, 0BFh, 0ECh, 7, 0E8h, 34h, 0EBh, 73h, 3, 0E8h, 22h, 0EBh, 26h
	db	89h, 35h, 8Bh, 46h, 0FCh, 26h, 89h, 45h, 4, 8Bh, 46h, 0FEh, 26h
	db	89h, 45h, 2, 89h, 7Eh, 0F8h, 0E9h, 97h, 0, 8Eh, 6, 80h, 7, 26h
	db	89h, 4Ch, 2, 3Ch, 18h, 72h, 1Ah, 8Bh, 0F9h, 8Eh, 6, 78h, 7, 26h
	db	8Bh, 44h, 6, '&;E', 6, 76h, 8, 26h, 87h, 45h, 6, 26h, 87h, 44h
	db	6, 0EBh, 71h, 8Bh, 56h, 0FCh, 8Bh, 46h, 0FEh, 51h, 53h, 8Eh, 6
	db	78h, 7, 26h, 8Ah, 4Ch, 9, 80h, 0E1h, 0E0h, 80h, 0F9h, '@r$t', 16h
	db	80h, 0F9h, 80h, 74h, 7, 77h, 0Ah, 0BBh, 0Fh, 0, 0EBh, 0Dh, 0BBh
	db	0FFh, 0, 0EBh, 8, 0BBh, 3, 0, 0EBh, 3, 0BBh, 1, 0, 3, 0C3h, 83h
	db	0D2h, 0, 23h, 0D8h, 33h, 0C3h, 5Bh, 26h, 3, 44h, 6, 26h, 12h, 54h
	db	8, 89h, 46h, 0FEh, 89h, 56h, 0FCh, 59h, 0Bh, 0D2h, 74h, 0Bh, 0Bh
	db	0C0h, 74h, 7, 80h, 3Eh, 27h, 1, 0, 74h, 38h, 80h, 3Eh, 28h, 1
	db	1, 75h, 0Fh, 8Bh, 7Eh, 0F8h, 8Eh, 6, 0F0h, 7, 26h, 89h, 55h, 4
	db	26h, 89h, 45h, 2, 80h, 7Eh, 0F6h, 0FFh, 75h, 0Ch, 8Bh, 46h, 0FEh
	db	0A3h, 45h, 0Ah, 8Bh, 46h, 0FCh, 0A3h, 47h, 0Ah, 8Bh, 7Eh, 0FAh
	db	83h, 0C7h, 2, 0E9h, 0C0h, 0FEh, '_^Z', 8Bh, 0E5h, 5Dh, 0C3h, 83h
	db	3Eh, 3Fh, 0Ah, 0FFh, 75h, 0D7h, 8Eh, 6, 78h, 7, 'PSQRVW&', 8Bh
	db	34h, 0BFh, 28h, 0, 0E8h, 0C8h, 2Ch, 1Eh, 0BBh, 28h, 0, 53h, 0B9h
	db	4, 0, 51h, 0B8h, 0Ah, 0, 50h, 0E8h, 1Eh, 51h, 80h, 0Eh, 10h, 4
	db	4, '_^ZY[X', 0EBh, 0A7h, 'PSQV', 0E8h, 9Ah, 48h, 83h, 0FBh, 0
	db	74h, 41h, 8Bh, 36h, 76h, 7, 0Bh, 0F6h, 74h, 39h, 0B9h, 0FFh, 0FFh
	db	8Eh, 6, 78h, 7, 0EBh, 2Bh, 0E8h, 0E7h, 27h, 3Ch, 0FFh, 74h, 7
	db	83h, 0F9h, 0FFh, 75h, 24h, 0EBh, 1Dh, 83h, 0F9h, 0FFh, 75h, 0Dh
	db	8Bh, 0CEh, 26h, 0C6h, 44h, 8, 0, 26h, 89h, 5Ch, 6, 0EBh, 0Bh, 26h
	db	0C6h, 44h, 8, 0, 26h, 0C7h, 44h, 6, 0, 0, 83h, 0EEh, 0Ah, 75h
	db	0D0h, '^Y[X', 0C3h
L06AE7:	push	cx	;@06AE7
	push	bx	;@06AE8
	mov	cx, word ptr es:[di]	;@06AE9
	cmp	cx, -1	;@06AEC
	je	@@4	;@06AEF
	xor	bx, bx	;@06AF1
@@1:	cmp	bx, word ptr ds:[7B6h]	;@06AF3
	jae	@@2	;@06AF7
	mov	es, word ptr ds:[7B8h]	;@06AF9
	cmp	word ptr es:[bx], cx	;@06AFD
	je	@@4	;@06B00
	add	bx, 4	;@06B02
	jmp	@@1	;@06B05
@@2:	mov	di, 4	;@06B07
	push	di	;@06B0A
	mov	di, 7B4h	;@06B0B
	call	POOL_ALLOC	;@06B0E
	jae	@@3	;@06B11
	call	L054B0	;@06B13
@@3:	mov	word ptr es:[bx], cx	;@06B16
	mov	word ptr es:[bx+2], si	;@06B19
@@4:	pop	bx	;@06B1D
	pop	cx	;@06B1E
	ret	;@06B1F
L06B20:	push	bp	;@06B20
	mov	bp, sp	;@06B21
	xor	di, di	;@06B23
@@1:	cmp	di, word ptr ds:[7B6h]	;@06B25
	jae	@@2	;@06B29
	mov	es, word ptr ds:[7B8h]	;@06B2B
	mov	ax, word ptr [bp+4]	;@06B2F
	cmp	word ptr es:[di], ax	;@06B32
	je	@@3	;@06B35
	add	di, 4	;@06B37
	jmp	@@1	;@06B3A
@@2:	mov	ax, 3	;@06B3C
	db	0E8h, 0E7h, 27h	; call L09329	;@06B3F
@@3:	mov	ax, word ptr es:[di+2]	;@06B42
	mov	sp, bp	;@06B46
	pop	bp	;@06B48
	ret	2	;@06B49
L06B4C:	mov	si, word ptr ds:[7BEh]	;@06B4C
	jmp	short @@2	;@06B50
@@1:	mov	es, word ptr ds:[7C0h]	;@06B52
	mov	di, word ptr es:[si]	;@06B56
	mov	es, word ptr ds:[780h]	;@06B59
	call	L06AE7	;@06B5D
@@2:	sub	si, 2	;@06B60
	jae	@@1	;@06B63
	ret	;@06B65
L06B66:	push	ax	;@06B66
	push	cx	;@06B67
	mov	cx, 14h	;@06B68
	mov	di, cx	;@06B6B
	push	di	;@06B6D
	mov	di, 79Ch	;@06B6E
	call	POOL_ALLOC	;@06B71
	jae	@@1	;@06B74
	call	L054B0	;@06B76
@@1:	push	di	;@06B79
	mov	al, 0	;@06B7A
	cld	;@06B7C
	rep stosb	;@06B7D
	pop	di	;@06B7F
	mov	word ptr es:[di+4], si	;@06B80
	mov	ax, word ptr ds:[6BBh]	;@06B84
	inc	ax	;@06B87
	mov	word ptr ds:[6BBh], ax	;@06B88
	mov	word ptr es:[di+6], ax	;@06B8B
	pop	cx	;@06B8F
	pop	ax	;@06B90
	ret	;@06B91
L06B92:	push	di	;@06B92
	xor	di, di	;@06B93
	mov	es, word ptr ds:[7F0h]	;@06B95
	jmp	short @@2	;@06B99
@@1:	cmp	si, word ptr es:[di]	;@06B9B
	je	@@4	;@06B9E
	add	di, 6	;@06BA0
@@2:	cmp	di, word ptr ds:[7EEh]	;@06BA3
	jb	@@1	;@06BA7
	mov	ax, 4	;@06BA9
	db	0E8h, 7Ah, 27h	; call L09329	;@06BAC
@@3:	jmp	short @@5	;@06BAF
@@4:	cmp	word ptr es:[di+4], 0	;@06BB1
	jne	@@3	;@06BB6
	cmp	word ptr ds:[144h], 0	;@06BB8
	je	@@7	;@06BBD
	add	ax, word ptr es:[di+2]	;@06BBF
	jb	@@5	;@06BC3
	cmp	ax, word ptr ds:[144h]	;@06BC5
	jbe	@@6	;@06BC9
@@5:	stc	;@06BCB
	jmp	short @@8	;@06BCC
@@6:	clc	;@06BCE
	jmp	short @@8	;@06BCF
@@7:	add	ax, word ptr es:[di+2]	;@06BD1
	jb	@@8	;@06BD5
@@8:	pop	di	;@06BD7
	ret	;@06BD8
CHECK_GROUPS:	push	bp	;@06BD9
	mov	bp, sp	;@06BDA
	sub	sp, 1Ah	;@06BDC
	push	si	;@06BDF
	push	di	;@06BE0
	call	L06B4C	;@06BE1
	mov	ax, 0FFFFh	;@06BE4
	mov	word ptr [bp-8], ax	;@06BE7
	mov	word ptr [bp-12h], ax	;@06BEA
	mov	word ptr [bp-14h], ax	;@06BED
	mov	word ptr [bp-1Ah], ax	;@06BF0
	xor	si, si	;@06BF3
	jmp	short @@3	;@06BF5
@@1:	jmp	@@39	;@06BF7
@@2:	mov	si, word ptr [bp-6]	;@06BFA
	add	si, 2	;@06BFD
@@3:	cmp	si, word ptr ds:[7BEh]	;@06C00
	jae	@@1	;@06C04
	mov	word ptr [bp-6], si	;@06C06
	mov	es, word ptr ds:[7C0h]	;@06C09
	mov	si, word ptr es:[si]	;@06C0D
	mov	es, word ptr ds:[780h]	;@06C10
	cmp	byte ptr ds:[3D7h], 1	;@06C14
	jne	@@5	;@06C19
	mov	cx, word ptr es:[si]	;@06C1B
	mov	es, word ptr ds:[778h]	;@06C1E
	mov	dx, word ptr es:[si+2]	;@06C22
	cmp	word ptr ds:[0A37h], -1	;@06C26
	jne	@@4	;@06C2B
	cmp	cx, word ptr ds:[424h]	;@06C2D
	jne	@@4	;@06C31
	cmp	dx, word ptr ds:[426h]	;@06C33
	jne	@@4	;@06C37
	mov	word ptr ds:[0A37h], si	;@06C39
	jmp	short @@5	;@06C3D
@@4:	cmp	word ptr ds:[0A39h], -1	;@06C3F
	jne	@@5	;@06C44
	cmp	cx, word ptr ds:[424h]	;@06C46
	jne	@@5	;@06C4A
	cmp	dx, word ptr ds:[42Ch]	;@06C4C
	jne	@@5	;@06C50
	mov	word ptr ds:[0A39h], si	;@06C52
@@5:	mov	es, word ptr ds:[778h]	;@06C56
	db	0E8h, 3Fh, 26h	; call L0929C	;@06C5A
	mov	byte ptr [bp-16h], al	;@06C5D
	mov	dl, byte ptr es:[si+9]	;@06C60
	mov	byte ptr [bp-18h], dl	;@06C64
	test	dl, 0E0h	;@06C67
	je	@@2	;@06C6A
	mov	ax, word ptr es:[si+6]	;@06C6C
	mov	word ptr [bp-0Eh], ax	;@06C70
	mov	al, byte ptr es:[si+8]	;@06C73
	mov	ah, 0	;@06C77
	mov	word ptr [bp-0Ch], ax	;@06C79
	mov	es, word ptr ds:[780h]	;@06C7C
	xor	ax, ax	;@06C80
	xchg	word ptr es:[si+6], ax	;@06C82
	mov	word ptr [bp-4], ax	;@06C86
	mov	bx, word ptr es:[si+2]	;@06C89
	mov	di, 0FFFFh	;@06C8D
	xchg	word ptr es:[si], di	;@06C90
	mov	word ptr [bp-2], di	;@06C93
	cmp	di, -1	;@06C96
	jne	@@6	;@06C99
	cmp	word ptr [bp-12h], -1	;@06C9B
	jne	@@8	;@06C9F
	jmp	@@12	;@06CA1
@@6:	cmp	word ptr [bp-12h], -1	;@06CA4
	jne	@@8	;@06CA8
	push	di	;@06CAA
	push	di	;@06CAB
	call	L06B20	;@06CAC
	pop	di	;@06CAF
	mov	word ptr [bp-12h], ax	;@06CB0
	mov	word ptr [bp-14h], di	;@06CB3
	cmp	word ptr [bp-6], ax	;@06CB6
	je	@@7	;@06CB9
	jmp	@@16	;@06CBB
@@7:	mov	word ptr [bp-12h], 0FFFFh	;@06CBE
	jmp	@@16	;@06CC3
@@8:	mov	ax, word ptr [bp-6]	;@06CC6
	cmp	ax, word ptr [bp-12h]	;@06CC9
	je	@@11	;@06CCC
	mov	cx, word ptr [bp-2]	;@06CCE
	cmp	cx, -1	;@06CD1
	je	@@9	;@06CD4
	cmp	cx, word ptr [bp-14h]	;@06CD6
	je	@@9	;@06CD9
	mov	al, byte ptr ds:[19h]	;@06CDB
	or	al, byte ptr ds:[488h]	;@06CDE
	je	@@9	;@06CE2
	push	si	;@06CE4
	mov	si, word ptr [bp-14h]	;@06CE5
	mov	di, 28h	;@06CE8
	db	0E8h, 52h, 2Ah	; call COPY_NAME	;@06CEB
	mov	si, word ptr [bp-2]	;@06CEE
	mov	di, 78h	;@06CF1
	db	0E8h, 49h, 2Ah	; call COPY_NAME	;@06CF4
	push	ds	;@06CF7
	mov	ax, 78h	;@06CF8
	push	ax	;@06CFB
	push	ds	;@06CFC
	mov	ax, 28h	;@06CFD
	push	ax	;@06D00
	mov	word ptr ds:[422h], 1	;@06D01
	mov	cx, 8	;@06D07
	push	cx	;@06D0A
	mov	ax, 36h	;@06D0B
	push	ax	;@06D0E
	db	0E8h, 99h, 4Eh	; call WARNING	;@06D0F
	pop	si	;@06D12
@@9:	mov	es, word ptr ds:[780h]	;@06D13
	mov	ax, word ptr [bp-14h]	;@06D17
	mov	word ptr es:[si], ax	;@06D1A
@@10:	mov	di, word ptr [bp-14h]	;@06D1D
	push	di	;@06D20
	and	di, 3	;@06D21
	shl	di, 1	;@06D24
	shl	di, 1	;@06D26
	shl	di, 1	;@06D28
	mov	es, word ptr [di+718h]	;@06D2A
	pop	di	;@06D2E
	mov	di, word ptr es:[di]	;@06D2F
	jmp	@@23	;@06D32
@@11:	mov	word ptr [bp-12h], 0FFFFh	;@06D35
	jmp	@@10	;@06D3A
@@12:	test	dl, 1Ch	;@06D3C
	jne	@@13	;@06D3F
	jmp	@@18	;@06D41
@@13:	test	dl, 2	;@06D44
	je	@@14	;@06D47
	jmp	@@18	;@06D49
@@14:	mov	es, word ptr ds:[778h]	;@06D4C
	mov	ax, word ptr es:[si]	;@06D50
	mov	bx, word ptr [bp-6]	;@06D53
	sub	bx, 2	;@06D56
	jl	@@16	;@06D59
	mov	es, word ptr ds:[7C0h]	;@06D5B
	mov	bx, word ptr es:[bx]	;@06D5F
	mov	es, word ptr ds:[778h]	;@06D62
	cmp	ax, word ptr es:[bx]	;@06D66
	jne	@@16	;@06D69
	mov	ax, word ptr es:[bx+2]	;@06D6B
	cmp	ax, word ptr es:[si+2]	;@06D6F
	jne	@@16	;@06D73
	mov	dh, byte ptr es:[bx+9]	;@06D75
	test	dh, 1Ch	;@06D79
	je	@@16	;@06D7C
	test	dh, 2	;@06D7E
	jne	@@16	;@06D81
@@15:	mov	es, word ptr ds:[780h]	;@06D83
	mov	di, word ptr es:[bx]	;@06D87
	jmp	@@23	;@06D8A
@@16:	cmp	byte ptr ds:[128h], 1	;@06D8D
	jne	@@18	;@06D92
	cmp	byte ptr [bp-16h], 1	;@06D94
	jne	@@18	;@06D98
	cmp	word ptr [bp-2], -1	;@06D9A
	jne	@@18	;@06D9E
	cmp	word ptr [bp-8], -1	;@06DA0
	je	@@18	;@06DA4
	mov	ax, word ptr [bp-0Ah]	;@06DA6
	call	L06B92	;@06DA9
	jb	@@18	;@06DAC
	mov	bx, word ptr [bp-8]	;@06DAE
	jmp	@@15	;@06DB1
@@17:	mov	di, word ptr [bp-1Ah]	;@06DB3
	cmp	di, -1	;@06DB6
	je	@@19	;@06DB9
	mov	es, word ptr ds:[7A0h]	;@06DBB
	cmp	word ptr es:[di+0Dh], 0	;@06DBF
	jne	@@19	;@06DC4
	cmp	word ptr es:[di+0Fh], 0	;@06DC6
	jne	@@19	;@06DCB
	mov	word ptr es:[di+4], si	;@06DCD
	jmp	short @@20	;@06DD1
@@18:	and	dl, 0E0h	;@06DD3
	cmp	byte ptr ds:[19h], 0	;@06DD6
	jne	@@17	;@06DDB
@@19:	call	L06B66	;@06DDD
	mov	word ptr [bp-1Ah], di	;@06DE0
@@20:	mov	byte ptr es:[di], dl	;@06DE3
	mov	ax, word ptr [bp-4]	;@06DE6
	mov	word ptr es:[di+11h], ax	;@06DE9
	mov	ax, word ptr [bp-0Eh]	;@06DED
	mov	cx, word ptr [bp-0Ch]	;@06DF0
	mov	word ptr es:[di+0Dh], ax	;@06DF3
	mov	word ptr es:[di+0Fh], cx	;@06DF7
	mov	al, byte ptr [bp-16h]	;@06DFB
	mov	byte ptr es:[di+1], al	;@06DFE
	cmp	al, 3	;@06E02
	jl	@@21	;@06E04
	cmp	word ptr ds:[404h], -1	;@06E06
	jne	@@21	;@06E0B
	mov	word ptr ds:[404h], di	;@06E0D
@@21:	mov	bx, word ptr [bp-2]	;@06E11
	mov	word ptr es:[di+2], bx	;@06E14
	cmp	bx, -1	;@06E18
	je	@@22	;@06E1B
	push	bx	;@06E1D
	and	bx, 3	;@06E1E
	shl	bx, 1	;@06E21
	shl	bx, 1	;@06E23
	shl	bx, 1	;@06E25
	mov	es, word ptr [bx+718h]	;@06E27
	pop	bx	;@06E2B
	mov	word ptr es:[bx], di	;@06E2C
@@22:	mov	es, word ptr ds:[780h]	;@06E2F
	mov	word ptr es:[si], di	;@06E33
	jmp	@@37	;@06E36
@@23:	mov	es, word ptr ds:[7A0h]	;@06E39
	mov	ax, word ptr es:[di+4]	;@06E3D
	mov	word ptr [bp-10h], ax	;@06E41
	mov	dh, dl	;@06E44
	and	dx, 1CE0h	;@06E46
	cmp	dl, byte ptr es:[di]	;@06E4A
	jbe	@@24	;@06E4D
	mov	byte ptr es:[di], dl	;@06E4F
@@24:	cmp	byte ptr ds:[19h], 1	;@06E52
	jne	@@25	;@06E57
	cmp	byte ptr [bp-16h], 1	;@06E59
	jne	@@25	;@06E5D
	mov	byte ptr es:[di+1], 1	;@06E5F
@@25:	cmp	byte ptr [bp-16h], 0FFh	;@06E64
	jne	@@27	;@06E68
	cmp	word ptr ds:[0A3Bh], -1	;@06E6A
	jne	@@26	;@06E6F
	mov	word ptr ds:[0A3Bh], bx	;@06E71
@@26:	mov	byte ptr es:[di+1], 0FFh	;@06E75
@@27:	mov	ax, word ptr [bp-4]	;@06E7A
	add	word ptr es:[di+11h], ax	;@06E7D
	mov	ax, word ptr es:[di+0Dh]	;@06E81
	mov	cx, word ptr es:[di+0Fh]	;@06E85
	cmp	bx, si	;@06E89
	je	@@28	;@06E8B
	cmp	dh, 14h	;@06E8D
	je	@@28	;@06E90
	cmp	dh, 8	;@06E92
	jne	@@29	;@06E95
@@28:	push	bx	;@06E97
	cmp	dl, 40h	;@06E98
	jb	@@34	;@06E9B
	je	@@32	;@06E9D
	cmp	dl, 80h	;@06E9F
	je	@@30	;@06EA2
	ja	@@31	;@06EA4
	mov	bx, 0Fh	;@06EA6
	jmp	short @@33	;@06EA9
@@29:	mov	es, word ptr ds:[780h]	;@06EAB
	push	word ptr es:[bx+6]	;@06EAF
	push	word ptr es:[bx+8]	;@06EB3
	cmp	dh, 18h	;@06EB7
	jb	@@35	;@06EBA
	jmp	short @@36	;@06EBC
@@30:	mov	bx, 0FFh	;@06EBE
	jmp	short @@33	;@06EC1
@@31:	mov	bx, 3	;@06EC3
	jmp	short @@33	;@06EC6
@@32:	mov	bx, 1	;@06EC8
@@33:	add	ax, bx	;@06ECB
	adc	cx, 0	;@06ECD
	and	bx, ax	;@06ED0
	xor	ax, bx	;@06ED2
@@34:	pop	bx	;@06ED4
	push	ax	;@06ED5
	push	cx	;@06ED6
@@35:	add	ax, word ptr [bp-0Eh]	;@06ED7
	adc	cx, word ptr [bp-0Ch]	;@06EDA
	cmp	byte ptr ds:[127h], 0	;@06EDD
	jne	@@36	;@06EE2
	or	cx, cx	;@06EE4
	je	@@36	;@06EE6
	or	ax, ax	;@06EE8
	jne	@@40	;@06EEA
@@36:	mov	es, word ptr ds:[7A0h]	;@06EEC
	mov	word ptr es:[di+0Dh], ax	;@06EF0
	mov	word ptr es:[di+0Fh], cx	;@06EF4
	mov	es, word ptr ds:[780h]	;@06EF8
	pop	cx	;@06EFC
	mov	byte ptr es:[si+8], cl	;@06EFD
	pop	word ptr es:[si+6]	;@06F01
	mov	word ptr es:[si], di	;@06F05
	cmp	byte ptr ds:[19h], 0	;@06F08
	jne	@@37	;@06F0D
	cmp	si, word ptr [bp-10h]	;@06F0F
	je	@@37	;@06F12
	cmp	si, word ptr es:[si+2]	;@06F14
	jne	@@37	;@06F18
	cmp	byte ptr [bp-16h], 1	;@06F1A
	jge	@@37	;@06F1E
	mov	ax, word ptr es:[si+6]	;@06F20
	call	L06B66	;@06F24
	mov	byte ptr es:[di], 20h	;@06F27
	mov	word ptr es:[di+11h], 0	;@06F2B
	mov	word ptr es:[di+0Bh], ax	;@06F31
	mov	byte ptr es:[di+1], 0FEh	;@06F35
@@37:	cmp	byte ptr ds:[128h], 1	;@06F3A
	jne	@@38	;@06F3F
	mov	word ptr [bp-8], 0FFFFh	;@06F41
	cmp	byte ptr [bp-16h], 1	;@06F46
	jne	@@38	;@06F4A
	mov	word ptr [bp-8], si	;@06F4C
	mov	es, word ptr ds:[7A0h]	;@06F4F
	mov	ax, word ptr es:[di+0Dh]	;@06F53
	mov	word ptr [bp-0Ah], ax	;@06F57
@@38:	jmp	@@2	;@06F5A
@@39:	pop	di	;@06F5D
	pop	si	;@06F5E
	mov	sp, bp	;@06F5F
	pop	bp	;@06F61
	ret	;@06F62
@@40:	mov	es, word ptr ds:[780h]	;@06F63
	cmp	word ptr [bp-14h], -1	;@06F67
	jne	@@41	;@06F6B
	cmp	word ptr es:[si], -1	;@06F6D
	jne	@@41	;@06F71
	jmp	@@36	;@06F73
@@41:	cmp	word ptr ds:[0A3Dh], -1	;@06F76
	je	@@42	;@06F7B
	jmp	@@36	;@06F7D
@@42:	mov	word ptr ds:[0A3Dh], 1	;@06F80
	push	ax	;@06F86
	push	bx	;@06F87
	push	cx	;@06F88
	push	dx	;@06F89
	push	si	;@06F8A
	push	di	;@06F8B
	mov	si, word ptr [bp-14h]	;@06F8C
	cmp	si, -1	;@06F8F
	jne	@@43	;@06F92
	mov	si, word ptr es:[si]	;@06F94
@@43:	mov	di, 28h	;@06F97
	db	0E8h, 0A3h, 27h	; call COPY_NAME	;@06F9A
	push	ds	;@06F9D
	mov	bx, 28h	;@06F9E
	push	bx	;@06FA1
	mov	cx, 4	;@06FA2
	push	cx	;@06FA5
	mov	ax, 9	;@06FA6
	push	ax	;@06FA9
	db	0E8h, 0F9h, 4Bh	; call ERROR	;@06FAA
	or	byte ptr ds:[410h], 4	;@06FAD
	pop	di	;@06FB2
	pop	si	;@06FB3
	pop	dx	;@06FB4
	pop	cx	;@06FB5
	pop	bx	;@06FB6
	pop	ax	;@06FB7
	jmp	@@36	;@06FB8
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 6, 2Bh, 0C9h, 88h, 4Eh, 0FCh, 89h, 0Eh	;@06FBB
	db	0B7h, 6, 89h, 0Eh, 0B9h, 6, 89h, 0Eh, 0AAh, 4, 89h, 0Eh, 0ACh
	db	4, 2Bh, 0C9h, 2Bh, 0D2h, 2Bh, 0F6h, 8Bh, 0FEh, 0EBh, 36h, 0B8h
	db	0Fh, 0, 3, 0C8h, 12h, 0D6h, 80h, 0E1h, 0F0h, 23h, 0C2h, 0Bh, 0C1h
	db	0D1h, 0C8h, 0D1h, 0C8h, 0D1h, 0C8h, 0D1h, 0C8h, 0A3h, 18h, 4, 83h
	db	0C1h, 10h, 12h, 0D6h, 0C3h, 83h, 3Eh, 14h, 4, 1, 75h, 0Ah, 83h
	db	3Eh, 18h, 4, 0FFh, 75h, 3, 0E8h, 0D0h, 0FFh, 0E9h, 46h, 1, 83h
	db	0C6h, 14h, 3Bh, 36h, 9Eh, 7, 73h, 0E3h, 3Bh, 36h, 4, 4, 75h, 3
	db	0E8h, 0BBh, 0FFh, 8Eh, 6, 0A0h, 7, 80h, 3Eh, 19h, 0, 0, 75h, 12h
	db	26h, 8Ah, 44h, 1, 3Ch, 0FEh, 74h, 0DBh, 3Ch, 0FDh, 74h, 0D7h, 3Ch
	db	3, 7Dh, 2, 0EBh, 42h, 8Bh, 1Eh, 0FAh, 3, 3, 0CBh, 83h, 0D2h, 0
	db	23h, 0D9h, 33h, 0CBh, 26h, 8Bh, 44h, 0Dh, 89h, 46h, 0FEh, 26h
	db	8Bh, 5Ch, 11h, 80h, 3Eh, 19h, 0, 0, 75h, 8, 83h, 0FBh, 3, 73h
	db	3, 0BBh, 3, 0, 80h, 3Eh, 19h, 0, 0, 74h, 5, 83h, 0FBh, 0, 74h
	db	45h, 87h, 0D3h, 0E8h, 4, 0EAh, 87h, 0DAh, 26h, 0C7h, 44h, 11h
	db	0, 0, 0EBh, 36h, 26h, 80h, '<@r%t', 17h, 26h, 80h, 3Ch, 80h, 74h
	db	7, 77h, 0Ah, 0BBh, 0Fh, 0, 0EBh, 0Dh, 0BBh, 0FFh, 0, 0EBh, 8, 0BBh
	db	3, 0, 0EBh, 3, 0BBh, 1, 0, 3, 0CBh, 83h, 0D2h, 0, 23h, 0D9h, 33h
	db	0CBh, 26h, 8Bh, 44h, 0Dh, 89h, 46h, 0FEh, 26h, 8Bh, 5Ch, 0Fh, 'RQSP'
	db	0B8h, 0Fh, 0, 23h, 0C1h, 26h, 89h, 44h, 0Bh, 33h, 0C1h, 0B9h, 4
	db	0, 0D1h, 0EAh, 0D1h, 0D8h, 0E2h, 0FAh, 26h, 89h, 44h, 8, 26h, 88h
	db	54h, 0Ah, 26h, 80h, 7Ch, 1, 0FFh, 75h, 6Dh, 0C6h, 6, 0D3h, 3, 1
	db	0A3h, 0AAh, 4, 80h, 3Eh, 2Bh, 1, 3, 74h, 0Eh, 26h, 8Bh, 5Ch, 6
	db	89h, 1Eh, 0B9h, 6, 8Bh, 46h, 0FEh, 0A3h, 0B7h, 6, 'X[YZPSQ', 80h
	db	3Eh, 19h, 0, 1, 74h, 20h, 8Bh, 1Eh, 3Bh, 0Ah, 83h, 0FBh, 0FFh
	db	74h, 17h, 0C6h, 46h, 0FCh, 1, 8Eh, 6, 80h, 7, 26h, 8Bh, 47h, 6
	db	0B1h, 4, 0D3h, 0E8h, 1, 6, 0AAh, 4, 0A1h, 45h, 0Ah, 59h, 5Bh, 0A3h
	db	0ACh, 4, 58h, 80h, 3Eh, 2Bh, 1, 1, 74h, 63h, 80h, 7Eh, 0FCh, 1
	db	74h, 6, 0Bh, 0DBh, 74h, 0Fh, 0EBh, 61h, 83h, 3Eh, 47h, 0Ah, 0
	db	75h, 5Ah, 0EBh, 4, 'X[YZ', 3, 0C8h, 13h, 0D3h, 0E9h, 0BAh, 0FEh
	db	89h, 16h, 0DEh, 3, 89h, 0Eh, 0DCh, 3, 80h, 3Eh, 2Bh, 1, 1, 74h
	db	5Bh, 0C7h, 6, 0F2h, 3, 3Eh, 0, 0C7h, 6, 0F4h, 3, 0, 0, 0A1h, 0A2h
	db	4, 5, 8Fh, 0, 24h, 80h, 0D1h, 0E8h, 0D1h, 0E8h, 0A3h, 0A4h, 4
	db	0A3h, 0FEh, 3, 0C7h, 6, 0B4h, 4, 3Eh, 0, 0C7h, 6, 0AEh, 4, 0, 0
	db	0C7h, 6, 0A2h, 4, 0, 0, 8Bh, 0E5h, 5Dh, 0C3h, 33h, 0C0h, 50h, 0B8h
	db	13h, 0, 50h, 0E8h, 0FBh, 'IPSQRVW3', 0C9h, 51h, 0B8h, 0Bh, 0, 50h
	db	0E8h, 0F0h, 49h, 80h, 0Eh, 10h, 4, 2, '_^ZY[X', 0EBh, 8Fh, 51h
	db	0E8h, 0C2h, 1Eh, 59h, 0B8h, 0, 0, 75h, 4, 0Bh, 0D2h, 75h, 2, 0EBh
	db	0ADh, 33h, 0C0h, 50h, 0B8h, 14h, 0, 50h, 0E8h, 0C4h, 'IPSRVW+'
	db	0F6h, 0EBh, 31h, 8Eh, 6, 78h, 7, 26h, 80h, 7Ch, 9, 0FFh, 't#&'
	db	0F6h, 44h, 9, 0E0h, 74h, 1Ch, 8Eh, 6, 80h, 7, 26h, 8Bh, 3Ch, 8Eh
	db	6, 0A0h, 7, 26h, 8Bh, 45h, 0Bh, 8Eh, 6, 80h, 7, 26h, 1, 44h, 6
	db	26h, 80h, 54h, 8, 0, 83h, 0C6h, 0Ah, ';6v', 7, 72h, 0C9h, '_^Z[X'
	db	0C3h, 'PSRVW+', 0F6h, 56h, 0BBh, 54h, 7, 56h, 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h, 7, 5Eh, 0EBh, 38h
	db	26h, 8Ah, 44h, 0Eh, 0A8h, 18h, 75h, 2Ch, 0A8h, 2, 'u(&', 8Bh, 3Ch
	db	8Eh, 6, 80h, 7, 26h, 8Bh, 45h, 6, 26h, 8Ah, 55h, 8, 0B6h, 0, 56h
	db	83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 58h
	db	7, 5Eh, 26h, 1, 44h, 4, 26h, 11h, 54h, 6, 3, 36h, 90h, 4, 3Bh
	db	77h, 2, 72h, 0C3h, 81h, 0FBh, 64h, 7, 77h, 8, 83h, 0C3h, 8, '^FV'
	db	0EBh, 0A4h, '^_^Z[X', 0C3h
	push	bp	;@07291
	mov	bp, sp	;@07292
	sub	si, si	;@07294
	jmp	short @@46	;@07296
@@44:	mov	dx, word ptr es:[si+8]	;@07298
@@45:	add	si, 14h	;@0729C
@@46:	cmp	si, word ptr ds:[79Eh]	;@0729F
	jae	@@47	;@072A3
	mov	es, word ptr ds:[7A0h]	;@072A5
	cmp	byte ptr es:[si+1], 0FEh	;@072A9
	jne	@@44	;@072AE
	mov	ax, word ptr es:[si+0Bh]	;@072B0
	mov	cx, 0Fh	;@072B4
	and	cx, ax	;@072B7
	xor	ax, cx	;@072B9
	mov	word ptr es:[si+0Bh], cx	;@072BB
	mov	cl, 4	;@072BF
	ror	ax, cl	;@072C1
	add	ax, dx	;@072C3
	mov	word ptr es:[si+8], ax	;@072C5
	mov	word ptr es:[si+0Dh], 0FFFFh	;@072C9
	jmp	@@45	;@072CF
@@47:	mov	sp, bp	;@072D1
	pop	bp	;@072D3
	ret	;@072D4
L072D5:	push	bp	;@072D5
	mov	bp, sp	;@072D6
	sub	sp, 4	;@072D8
	cmp	byte ptr ds:[19h], 0	;@072DB
	je	@@1	;@072E0
	cmp	byte ptr ds:[16h], 0	;@072E2
	jne	@@1	;@072E7
	mov	ax, 4000h	;@072E9
	mul	word ptr ds:[484h]	;@072EC
	add	ax, word ptr ds:[486h]	;@072F0
	adc	dx, 0	;@072F4
	jmp	short @@2	;@072F7
@@1:	mov	dx, 10h	;@072F9
	mul	dx	;@072FC
	add	ax, word ptr ds:[3DCh]	;@072FE
	adc	dx, word ptr ds:[3DEh]	;@07302
	add	ax, 0Fh	;@07306
	adc	dx, 0	;@07309
	and	ax, 0FFF0h	;@0730C
@@2:	db	0E8h, 8Bh, 21h	; call L0949D	;@0730F
	cmp	byte ptr ds:[19h], 0	;@07312
	je	@@3	;@07317
	cmp	byte ptr ds:[16h], 0	;@07319
	je	@@3	;@0731E
	push	dx	;@07320
	push	ax	;@07321
	mov	di, 6FBh	;@07322
	push	di	;@07325
	push	ds	;@07326
	pop	es	;@07327
	mov	ax, 424Eh	;@07328
	stosw	;@0732B
	mov	ax, 3230h	;@0732C
	stosw	;@0732F
	mov	cx, 0Ch	;@07330
	shr	cx, 1	;@07333
	mov	ax, 0FFFFh	;@07335
	rep stosw	;@07338
	pop	si	;@0733A
	pop	ax	;@0733B
	pop	dx	;@0733C
	mov	cx, 10h	;@0733D
	db	0E8h, 1Ah, 16h	; call L0895D	;@07340
@@3:	mov	word ptr [bp-4], ax	;@07343
	mov	word ptr [bp-2], dx	;@07346
	mov	si, 4DAh	;@07349
	mov	word ptr [si], 52FBh	;@0734C
	mov	ax, 300h	;@07350
	cmp	byte ptr ds:[12Fh], 1	;@07353
	jne	@@4	;@07358
	mov	ax, 209h	;@0735A
@@4:	mov	word ptr [si+2], ax	;@0735D
	mov	al, byte ptr ds:[122h]	;@07360
	mov	byte ptr [si+28h], al	;@07363
	mov	ax, word ptr [bp-4]	;@07366
	mov	dx, word ptr [bp-2]	;@07369
	cmp	byte ptr ds:[19h], 1	;@0736C
	je	@@5	;@07371
	cmp	word ptr ds:[418h], -1	;@07373
	je	@@5	;@07378
	add	ax, word ptr ds:[668h]	;@0737A
	adc	dx, word ptr ds:[66Ah]	;@0737E
	add	ax, 10h	;@07382
	adc	dx, 0	;@07385
@@5:	mov	word ptr [si+20h], ax	;@07388
	mov	word ptr [si+22h], dx	;@0738B
	cmp	byte ptr ds:[16h], 0	;@0738E
	jne	@@6	;@07393
	cmp	byte ptr ds:[19h], 0	;@07395
	jne	@@8	;@0739A
	xor	cx, cx	;@0739C
	cmp	byte ptr ds:[16h], 0	;@0739E
	je	@@7	;@073A3
@@6:	mov	cx, 30h	;@073A5
	add	cx, word ptr ds:[508h]	;@073A8
@@7:	db	0E8h, 0AEh, 15h	; call L0895D	;@073AC
@@8:	cmp	byte ptr ds:[19h], 0	;@073AF
	je	@@9	;@073B4
	cmp	byte ptr ds:[16h], 0	;@073B6
	je	@@9	;@073BB
	mov	di, 70Bh	;@073BD
	push	di	;@073C0
	push	ds	;@073C1
	pop	es	;@073C2
	mov	ax, 424Eh	;@073C3
	stosw	;@073C6
	mov	ax, 3230h	;@073C7
	stosw	;@073CA
	mov	ax, 4000h	;@073CB
	mul	word ptr ds:[484h]	;@073CE
	add	ax, word ptr ds:[486h]	;@073D2
	adc	dx, 0	;@073D6
	push	dx	;@073D9
	push	ax	;@073DA
	sub	ax, word ptr [bp-4]	;@073DB
	sbb	dx, word ptr [bp-2]	;@073DE
	add	ax, 10h	;@073E1
	adc	dx, 0	;@073E4
	add	ax, 8	;@073E7
	adc	dx, 0	;@073EA
	stosw	;@073ED
	mov	ax, dx	;@073EE
	stosw	;@073F0
	pop	ax	;@073F1
	pop	dx	;@073F2
	pop	si	;@073F3
	mov	cx, 8	;@073F4
	db	0E8h, 63h, 15h	; call L0895D	;@073F7
@@9:	xor	dx, dx	;@073FA
	mov	sp, bp	;@073FC
	pop	bp	;@073FE
	ret	;@073FF
	db	33h, 0C0h, 50h, 0B8h, 32h, 0, 50h, 0E8h, 0A1h, 47h, 0C3h, 0A1h	;@07400
	db	84h, 4, 40h, 75h, 18h, 0B8h, 10h, 0, 0F7h, 26h, 0A4h, 4, 50h, 25h
	db	0FFh, 7Fh, 0A3h, 86h, 4, 58h, 0B1h, 0Fh, 0D3h, 0E8h, 0D1h, 0E0h
	db	0A3h, 84h, 4, 0A1h, 18h, 4, 3Dh, 0FFh, 0FFh, 74h, 0Eh, 0BAh, 10h
	db	0, 0F7h, 0E2h, 0A3h, 0DCh, 3, 89h, 16h, 0DEh, 3, 0EBh, 7, 80h
	db	3Eh, 16h, 0, 0, 74h, 8, 0A1h, 0A4h, 4, 0E8h, 89h, 0FEh, 0EBh, 42h
	db	0B8h, 0, 40h, 0F7h, 26h, 84h, 4, 3, 6, 86h, 4, 83h, 0D2h, 0, 0E8h
	db	3Eh, 20h, 8Bh, 1Eh, 0A4h, 4, 0B1h, 4, 0D3h, 0E3h, 2Bh, 0C3h, 83h
	db	0DAh, 0, 8Bh, 0Eh, 0DEh, 3, 8Bh, 1Eh, 0DCh, 3, 83h, 0C3h, 0Fh
	db	83h, 0D1h, 0, 2Bh, 0D8h, 1Bh, 0CAh, 0D1h, 0E9h, 0D1h, 0DBh, 0D1h
	db	0E9h, 0D1h, 0DBh, 0D1h, 0E9h, 0D1h, 0DBh, 0D1h, 0E9h, 0D1h, 0DBh
	db	8Bh, 0D3h, 89h, 16h, 0A6h, 4, 0C7h, 6, 0A8h, 4, 0FFh, 0FFh, 0C7h
	db	6, 0B6h, 4, 0, 0, 0C7h, 6, 0B8h, 4, 1, 0, 83h, 3Eh, 0B2h, 4, 0FFh
	db	75h, 0Ch, 0C7h, 6, 0B2h, 4, 0, 0, 0C7h, 6, 0B0h, 4, 0, 0, 0C7h
	db	6, 9Ch, 4, 4Dh, 5Ah, 0C7h, 6, 0BAh, 4, 0FBh, 30h, 0C7h, 6, 0BCh
	db	4, 'jr+', 0C0h, 99h, 0B9h, 3Eh, 0, 0BEh, 9Ch, 4, 0E8h, 86h, 14h
	db	8Bh, 3Eh, 41h, 0B4h, 0E8h, 2, 21h, 17h, 'Program entry point at '
	db	0A1h, 0B2h, 4, 0E8h, 74h, 20h, 0B0h, 3Ah, 0E8h, 0Eh, 20h, 0A1h
	db	0B0h, 4, 0E8h, 69h, 20h, 0E8h, 7Ch, 20h, 89h, 3Eh, 41h, 0B4h, 80h
	db	3Eh, 0D3h, 3, 1, 74h, 0Ah, 80h, 3Eh, 2Ch, 1, 1, 74h, 3, 0E8h, 0E1h
	db	0FEh, 0C3h
	mov	word ptr ds:[414h], 0	;@07520
	mov	word ptr ds:[416h], 0	;@07526
	mov	bx, word ptr ds:[408h]	;@0752C
	cmp	bx, -1	;@07530
	jne	@@10	;@07533
	jmp	@@16	;@07535
@@10:	mov	es, word ptr ds:[778h]	;@07538
	cmp	byte ptr es:[bx+9], 0FFh	;@0753C
	jne	@@11	;@07541
	jmp	@@16	;@07543
@@11:	mov	si, word ptr es:[bx+4]	;@07546
	mov	dx, word ptr es:[bx+6]	;@0754A
	mov	es, word ptr ds:[780h]	;@0754E
	mov	bx, word ptr es:[bx]	;@07552
	push	dx	;@07555
	test	word ptr ds:[47Ah], 3	;@07556
	je	@@13	;@0755C
	mov	word ptr ds:[414h], 1	;@0755E
	mov	ax, word ptr ds:[6BBh]	;@07564
	push	bx	;@07567
	mov	es, word ptr ds:[7A0h]	;@07568
	mov	bx, word ptr ds:[404h]	;@0756C
	cmp	bx, -1	;@07570
	je	@@12	;@07573
	mov	ax, word ptr es:[bx+6]	;@07575
	dec	ax	;@07579
@@12:	pop	bx	;@0757A
	add	word ptr es:[bx+11h], ax	;@0757B
	push	si	;@0757F
	and	si, 3	;@07580
	shl	si, 1	;@07583
	shl	si, 1	;@07585
	shl	si, 1	;@07587
	mov	es, word ptr [si+738h]	;@07589
	pop	si	;@0758D
	add	word ptr es:[si+0Eh], ax	;@0758E
	add	word ptr ds:[4A2h], ax	;@07592
	shl	ax, 1	;@07596
	shl	ax, 1	;@07598
	shl	ax, 1	;@0759A
	add	dx, ax	;@0759C
	test	word ptr ds:[47Ah], 2	;@0759E
	je	@@13	;@075A4
	mov	di, word ptr ds:[45Ah]	;@075A6
	call	@@17	;@075AA
@@13:	test	word ptr ds:[47Ah], 4	;@075AD
	je	@@14	;@075B3
	mov	word ptr ds:[416h], 1	;@075B5
	mov	di, word ptr ds:[45Ch]	;@075BB
	call	@@17	;@075BF
@@14:	add	dx, 0Ch	;@075C2
	test	word ptr ds:[47Ah], 8	;@075C5
	je	@@15	;@075CB
	mov	di, word ptr ds:[45Eh]	;@075CD
	call	@@17	;@075D1
@@15:	add	dx, 4	;@075D4
	mov	es, word ptr ds:[7A0h]	;@075D7
	pop	ax	;@075DB
	sub	ax, dx	;@075DC
	sub	word ptr es:[bx+0Dh], ax	;@075DE
	mov	bx, word ptr ds:[408h]	;@075E2
	mov	es, word ptr ds:[778h]	;@075E6
	mov	word ptr es:[bx+6], dx	;@075EA
@@16:	ret	;@075EE
@@17:	push	di	;@075EF
	and	di, 3	;@075F0
	shl	di, 1	;@075F3
	shl	di, 1	;@075F5
	shl	di, 1	;@075F7
	mov	es, word ptr [di+758h]	;@075F9
	pop	di	;@075FD
	mov	word ptr es:[di+4], dx	;@075FE
	ret	;@07602
	db	0BEh, 92h, 0, 0B4h, 0, 0C7h, 6, 50h, 52h, 97h, 1, 0E8h, 16h, 19h	;@07603
	db	2Eh, 8Eh, 1Eh, 10h, 0, 72h, 16h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 0F6h, 47h
	db	0Eh, 10h, 74h, 1Fh, 0C7h, 6, 76h, 4, 0FFh, 0FFh, 0C7h, 6, 78h
	db	4, 0FFh, 0FFh, 83h, 3Eh, 4, 4, 0FFh, 74h, 0Ah, 33h, 0C9h, 51h
	db	0B8h, 37h, 0, 50h, 0E8h, 60h, 45h, 0F9h, 0C3h, 26h, 8Bh, 47h, 4
	db	0A3h, 78h, 4, 26h, 8Bh, 1Fh, 8Eh, 6, 80h, 7, 26h, 8Bh, 1Fh, 8Eh
	db	6, 0A0h, 7, 26h, 8Bh, 47h, 8, 0A3h, 76h, 4, 0F8h, 0C3h
L0766B:	push	cx	;@0766B
	push	di	;@0766C
	mov	di, si	;@0766D
	sub	ax, ax	;@0766F
	cwd	;@07671
	jmp	short @@4	;@07672
@@1:	mov	es, word ptr ds:[778h]	;@07674
	mov	cl, byte ptr es:[di+9]	;@07678
	and	cl, 1Ch	;@0767C
	cmp	cl, 8	;@0767F
	je	@@4	;@07682
	jb	@@2	;@07684
	cmp	cl, 18h	;@07686
	jae	@@2	;@07689
	add	ax, word ptr es:[di+6]	;@0768B
	adc	dl, byte ptr es:[di+8]	;@0768F
	jmp	short @@5	;@07693
@@2:	cmp	dl, byte ptr es:[di+8]	;@07695
	ja	@@5	;@07699
	jb	@@3	;@0769B
	cmp	ax, word ptr es:[di+6]	;@0769D
	jae	@@5	;@076A1
@@3:	mov	dl, byte ptr es:[di+8]	;@076A3
	mov	ax, word ptr es:[di+6]	;@076A7
	jmp	short @@5	;@076AB
@@4:	mov	es, word ptr ds:[780h]	;@076AD
	mov	ax, word ptr es:[di+6]	;@076B1
	mov	es, word ptr ds:[778h]	;@076B5
	add	ax, word ptr es:[di+6]	;@076B9
	mov	dl, byte ptr es:[di+8]	;@076BD
	mov	es, word ptr ds:[780h]	;@076C1
	adc	dl, byte ptr es:[di+8]	;@076C5
@@5:	add	bx, 2	;@076C9
	cmp	bx, word ptr ds:[7BEh]	;@076CC
	jae	@@6	;@076D0
	mov	es, word ptr ds:[7C0h]	;@076D2
	mov	di, word ptr es:[bx]	;@076D6
	mov	es, word ptr ds:[780h]	;@076D9
	cmp	si, word ptr es:[di+2]	;@076DD
	je	@@1	;@076E1
@@6:	pop	di	;@076E3
	pop	cx	;@076E4
	ret	;@076E5
MAP_SEGMENT_LINE:	push	bp	;@076E6
	mov	bp, sp	;@076E7
	sub	sp, 1Ah	;@076E9
	push	ax	;@076EC
	push	bx	;@076ED
	push	cx	;@076EE
	push	di	;@076EF
	push	si	;@076F0
	mov	bx, di	;@076F1
	mov	es, word ptr ds:[778h]	;@076F3
	mov	al, byte ptr es:[si+9]	;@076F7
	mov	byte ptr [bp-18h], al	;@076FB
	mov	ax, word ptr es:[si]	;@076FE
	mov	word ptr [bp-2], ax	;@07701
	mov	ax, word ptr es:[si+2]	;@07704
	mov	word ptr [bp-4], ax	;@07708
	mov	ax, word ptr es:[si+4]	;@0770B
	mov	word ptr [bp-6], ax	;@0770F
	mov	ax, word ptr es:[si+6]	;@07712
	mov	word ptr [bp-16h], ax	;@07716
	mov	al, byte ptr es:[si+8]	;@07719
	mov	byte ptr [bp-1Ah], al	;@0771D
	mov	es, word ptr ds:[780h]	;@07720
	mov	ax, word ptr es:[si+6]	;@07724
	mov	word ptr [bp-0Ah], ax	;@07728
	mov	al, byte ptr es:[si+8]	;@0772B
	mov	ah, 0	;@0772F
	mov	word ptr [bp-0Ch], ax	;@07731
	mov	di, word ptr es:[si]	;@07734
	mov	es, word ptr ds:[778h]	;@07737
	test	byte ptr es:[si+9], 0E0h	;@0773B
	jne	@@1	;@07740
	mov	word ptr [bp-14h], 0FFFFh	;@07742
	mov	word ptr [bp-8], di	;@07747
	jmp	short @@3	;@0774A
@@1:	mov	es, word ptr ds:[7A0h]	;@0774C
	mov	ax, word ptr es:[di+2]	;@07750
	mov	word ptr [bp-14h], ax	;@07754
	mov	ax, word ptr es:[di+8]	;@07757
	cmp	byte ptr ds:[19h], 1	;@0775B
	jne	@@2	;@07760
	mov	ax, word ptr es:[di+6]	;@07762
@@2:	mov	word ptr [bp-8], ax	;@07766
@@3:	mov	di, word ptr ds:[0B441h]	;@07769
	mov	al, 20h	;@0776D
	db	0E8h, 9Dh, 1Dh	; call L0950F	;@0776F
	cmp	word ptr [bp+4], 1	;@07772
	je	@@6	;@07776
	call	L0766B	;@07778
	mov	word ptr [bp-0Eh], ax	;@0777B
	mov	word ptr [bp-10h], dx	;@0777E
	cmp	byte ptr ds:[19h], 1	;@07781
	je	@@7	;@07786
	mov	bx, word ptr [bp-8]	;@07788
	mov	cl, 4	;@0778B
	mov	ax, word ptr [bp-0Ah]	;@0778D
	mov	dx, word ptr [bp-0Ch]	;@07790
	db	0E8h, 93h, 18h	; call L09029	;@07793
	mov	ax, word ptr [bp-0Eh]	;@07796
	mov	dx, word ptr [bp-10h]	;@07799
	cmp	dx, word ptr [bp-0Ch]	;@0779C
	ja	@@4	;@0779F
	cmp	ax, word ptr [bp-0Ah]	;@077A1
	jbe	@@5	;@077A4
@@4:	sub	ax, 1	;@077A6
	sbb	dx, 0	;@077A9
@@5:	db	0E8h, 7Ah, 18h	; call L09029	;@077AC
	mov	ax, word ptr [bp-0Eh]	;@077AF
	mov	dx, word ptr [bp-10h]	;@077B2
	sub	ax, word ptr [bp-0Ah]	;@077B5
	sbb	dx, word ptr [bp-0Ch]	;@077B8
	sub	bx, bx	;@077BB
	db	0E8h, 69h, 18h	; call L09029	;@077BD
	jmp	short @@8+1	;@077C0
@@6:	jmp	short @@9	;@077C2
@@7:	mov	al, 20h	;@077C4
	db	0E8h, 46h, 1Dh	; call L0950F	;@077C6
	mov	ax, word ptr [bp-8]	;@077C9
	db	0E8h, 0A1h, 1Dh	; call PUT_HEX_WORD	;@077CC
	db	0E8h, 0Eh, 1Eh	; call PUT_INLINE	;@077CF
	add	word ptr [bp+si], di	;@077D2
	mov	ax, word ptr [bp-0Ah]	;@077D4
	db	0E8h, 96h, 1Dh	; call PUT_HEX_WORD	;@077D7
	db	0E8h, 3, 1Eh	; call PUT_INLINE	;@077DA
	add	al, 20h	;@077DD
	and	byte ptr [bx+si], ah	;@077DF
	and	byte ptr [bp+di-0DBAh], cl	;@077E1
	sub	ax, word ptr [bp-0Ah]	;@077E5
	db	0E8h, 85h, 1Dh	; call PUT_HEX_WORD	;@077E8
	db	0E8h, 0F2h, 1Dh	; call PUT_INLINE	;@077EB
	add	cx, word ptr [bx+si+20h]	;@077EE
@@8:	and	byte ptr [bp+di-18Ah], cl	;@077F1
	mov	cx, 12h	;@077F5
	db	0E8h, 4Dh, 18h	; call L09048	;@077F8
	mov	si, word ptr [bp-4]	;@077FB
	db	0E8h, 0ACh, 1Eh	; call PUT_PLAIN_NAME	;@077FE
	db	0E9h, 0AEh, 0	; jmp @@16+1	;@07801
@@9:	mov	ax, word ptr [bp-8]	;@07804
	db	0E8h, 66h, 1Dh	; call PUT_HEX_WORD	;@07807
	mov	al, 3Ah	;@0780A
	db	0E8h, 0, 1Dh	; call L0950F	;@0780C
	mov	ax, word ptr [bp-0Ah]	;@0780F
	db	0E8h, 5Bh, 1Dh	; call PUT_HEX_WORD	;@07812
	mov	al, 20h	;@07815
	db	0E8h, 0F5h, 1Ch	; call L0950F	;@07817
	xor	ax, ax	;@0781A
	mov	al, byte ptr [bp-1Ah]	;@0781C
	cmp	al, 0	;@0781F
	je	@@10	;@07821
	db	0E8h, 4Ah, 1Dh	; call PUT_HEX_WORD	;@07823
@@10:	mov	ax, word ptr [bp-16h]	;@07826
	db	0E8h, 44h, 1Dh	; call PUT_HEX_WORD	;@07829
	db	0E8h, 0B1h, 1Dh	; call PUT_INLINE	;@0782C
	add	sp, word ptr [bx+si]	;@0782F
	inc	bx	;@07831
	cmp	ax, 768Bh	;@07832
	cld	;@07835
	mov	cx, 6	;@07836
	db	0E8h, 0Ch, 18h	; call L09048	;@07839
	db	0E8h, 0A1h, 1Dh	; call PUT_INLINE	;@0783C
	add	dl, byte ptr [bp+di+3Dh]	;@0783F
	mov	si, word ptr [bp-2]	;@07842
	mov	cx, 0Eh	;@07845
	db	0E8h, 0FDh, 17h	; call L09048	;@07848
	db	0E8h, 92h, 1Dh	; call PUT_INLINE	;@0784B
	add	al, byte ptr [bx+3Dh]	;@0784E
	test	byte ptr [bp-18h], 0E0h	;@07851
	je	@@11	;@07855
	mov	si, word ptr [bp-14h]	;@07857
	mov	cx, 7	;@0785A
	db	0E8h, 0E8h, 17h	; call L09048	;@0785D
	jmp	short @@12+3	;@07860
@@11:	db	0E8h, 7Bh, 1Dh	; call PUT_INLINE	;@07862
	pop	es	;@07865
	cmp	al, 6Eh	;@07866
	outsw	;@07868
	outsb	;@07869
@@12:	db	65h, 3Eh, 20h, 0E8h	; and al, ch	;@0786A
	db	70h, 1Dh	; jo @@14+1	;@0786E
	add	cl, byte ptr [di+3Dh]	;@07870
	mov	si, word ptr [bp-6]	;@07873
	cmp	si, -1	;@07876
	db	75h, 10h	; jne @@13	;@07879
	db	0E8h, 62h, 1Dh	; call PUT_INLINE	;@0787B
	or	bh, byte ptr [si]	;@0787E
	outsb	;@07880
	outsw	;@07881
	outsb	;@07882
	db	65h, 3Eh, 20h, 20h	; and byte ptr ds:[bx+si], ah	;@07883
	db	20h, 20h	; and byte ptr [bx+si], ah	;@07887
	jmp	short @@15	;@07889
@@13:	push	si	;@0788B
@@14:	and	si, 3	;@0788C
	shl	si, 1	;@0788F
	shl	si, 1	;@07891
	shl	si, 1	;@07893
	mov	es, word ptr [si+738h]	;@07895
	pop	si	;@07899
	mov	si, word ptr es:[si]	;@0789A
	mov	cx, 0Ah	;@0789D
	db	0E8h, 0A5h, 17h	; call L09048	;@078A0
@@15:	db	0E8h, 3Ah, 1Dh	; call PUT_INLINE	;@078A3
	add	ax, 4341h	;@078A6
	inc	dx	;@078A9
	push	ax	;@078AA
	cmp	ax, 468Ah	;@078AB
	call	L02999	;@078AE
@@16:	sbb	al, 0E8h	;@078B1
	rcr	word ptr [si], 1	;@078B3
	mov	word ptr ds:[0B441h], di	;@078B5
	pop	si	;@078B9
	pop	di	;@078BA
	pop	cx	;@078BB
	pop	bx	;@078BC
	pop	ax	;@078BD
	mov	sp, bp	;@078BE
	pop	bp	;@078C0
	ret	2	;@078C1
MAP_SEGMENTS:	push	bp	;@078C4
	mov	bp, sp	;@078C5
	sub	sp, 2	;@078C7
	mov	word ptr [bp-2], ax	;@078CA
	push	si	;@078CD
	push	di	;@078CE
	mov	di, word ptr ds:[0B441h]	;@078CF
	db	0E8h, 0B0h, 1Ch	; call PUT_NEWLINE	;@078D3
	cmp	word ptr [bp-2], 0	;@078D6
	db	74h, 1Eh	; je @@1	;@078DA
	db	0E8h, 1, 1Dh	; call PUT_INLINE	;@078DC
	sbb	byte ptr [si+65h], al	;@078DF
	db	74h, 61h	; je @@4+1	;@078E2
	imul	bp, word ptr [si+65h], 2064h	;@078E4
	insw	;@078E9
	popa	;@078EA
	db	70h, 20h	; jo @@2	;@078EB
	outsw	;@078ED
	db	66h, 20h, 73h, 65h	; and byte ptr [bp+di+65h], dh	;@078EE
	db	67h, 6Dh	; insw	;@078F2
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@078F4
	db	74h, 73h	; je @@7+1	;@078F6
	db	0EBh, 6Dh	; jmp short @@6	;@078F8
@@1:	cmp	byte ptr ds:[19h], 0	;@078FA
	db	74h, 34h	; je @@3	;@078FF
	db	0E8h, 0DCh, 1Ch	; call PUT_INLINE	;@07901
	and	byte ptr cs:[bp+di+74h], dl	;@07904
	popa	;@07908
	db	72h, 74h	; jb @@9+2	;@07909
	and	byte ptr [bx+si], ah	;@0790B
@@2:	and	byte ptr [bx+si], ah	;@0790D
	and	byte ptr [bx+si], ah	;@0790F
	and	byte ptr [bx+si], ah	;@07911
	and	byte ptr [si+65h], cl	;@07913
	outsb	;@07916
	db	67h, 74h, 68h	; je @@10+2	;@07917
	db	20h, 4Eh, 61h	; and byte ptr [bp+61h], cl	;@0791A
	insw	;@0791D
	db	65h, 20h, 20h	; and byte ptr [bx+si], ah	;@0791E
	db	20h, 20h	; and byte ptr [bx+si], ah	;@07921
	and	byte ptr [bx+si], ah	;@07923
	and	byte ptr [bx+si], ah	;@07925
	and	byte ptr [bx+si], ah	;@07927
	and	byte ptr [bx+si], ah	;@07929
	and	byte ptr [bx+si], ah	;@0792B
	and	byte ptr [bp+di+6Ch], al	;@0792D
	popa	;@07930
	db	73h, 73h	; jae @@12+1	;@07931
	db	0EBh, 32h	; jmp short @@6	;@07933
@@3:	db	0E8h, 0A8h, 1Ch	; call PUT_INLINE	;@07935
	and	byte ptr cs:[bp+di+74h], dl	;@07938
	popa	;@0793C
	db	72h, 74h	; jb @@15	;@0793D
	and	byte ptr [bx+si], ah	;@0793F
	push	bx	;@07941
	db	74h, 6Fh	; je @@15	;@07942
@@4:	db	70h, 20h	; jo @@5+1	;@07944
	and	byte ptr [bx+si], ah	;@07946
	dec	sp	;@07948
	db	65h, 6Eh	; outs dx, byte ptr gs:[si]	;@07949
	db	67h, 74h, 68h	; je @@16+2	;@0794B
	db	20h, 4Eh, 61h	; and byte ptr [bp+61h], cl	;@0794E
	insw	;@07951
	db	65h, 20h, 20h	; and byte ptr [bx+si], ah	;@07952
	db	20h, 20h	; and byte ptr [bx+si], ah	;@07955
	and	byte ptr [bx+si], ah	;@07957
	and	byte ptr [bx+si], ah	;@07959
	and	byte ptr [bx+si], ah	;@0795B
	and	byte ptr [bx+si], ah	;@0795D
	and	byte ptr [bx+si], ah	;@0795F
	and	byte ptr [bp+di+6Ch], al	;@07961
	popa	;@07964
@@5:	jae	@@17+3	;@07965
@@6:	db	0E8h, 1Ch, 1Ch	; call PUT_NEWLINE	;@07967
@@7:	db	0E8h, 19h, 1Ch	; call PUT_NEWLINE	;@0796A
	mov	word ptr ds:[0B441h], di	;@0796D
	sub	di, di	;@07971
@@8:	cmp	di, word ptr ds:[7BEh]	;@07973
	jae	@@14	;@07977
	mov	es, word ptr ds:[7C0h]	;@07979
@@9:	mov	si, word ptr es:[di]	;@0797D
@@10:	mov	es, word ptr ds:[780h]	;@07980
	mov	ax, word ptr es:[si+2]	;@07984
	cmp	ax, 0FFFFh	;@07988
	je	@@13	;@0798B
	cmp	word ptr [bp-2], 1	;@0798D
	je	@@11	;@07991
	mov	es, word ptr ds:[778h]	;@07993
	test	byte ptr es:[si+9], 0E0h	;@07997
	je	@@13	;@0799C
	cmp	ax, si	;@0799E
	jne	@@13	;@079A0
@@11:	push	word ptr [bp-2]	;@079A2
@@12:	call	MAP_SEGMENT_LINE	;@079A5
@@13:	add	di, 2	;@079A8
	jmp	@@8	;@079AB
@@14:	pop	di	;@079AD
	pop	si	;@079AE
	mov	sp, bp	;@079AF
	pop	bp	;@079B1
	ret	;@079B2
@@15:	push	si	;@079B3
@@16:	and	si, 3	;@079B4
	shl	si, 1	;@079B7
	shl	si, 1	;@079B9
	shl	si, 1	;@079BB
	mov	es, word ptr [si+758h]	;@079BD
	pop	si	;@079C1
	mov	ax, word ptr es:[si+4]	;@079C2
	mov	dl, byte ptr es:[si+0Eh]	;@079C6
	mov	si, word ptr es:[si]	;@079CA
	push	di	;@079CD
	and	di, 3	;@079CE
	shl	di, 1	;@079D1
	shl	di, 1	;@079D3
	shl	di, 1	;@079D5
@@17:	mov	es, word ptr [di+758h]	;@079D7
	pop	di	;@079DB
	mov	bx, word ptr es:[di+4]	;@079DC
	mov	dh, byte ptr es:[di+0Eh]	;@079E0
	mov	di, word ptr es:[di]	;@079E4
	mov	es, word ptr ds:[780h]	;@079E7
	and	dx, 202h	;@079EB
	jne	@@20	;@079EF
	cmp	word ptr es:[si+4], -1	;@079F1
	je	@@18	;@079F6
	or	dl, 1	;@079F8
	mov	si, word ptr es:[si+4]	;@079FB
@@18:	mov	si, word ptr es:[si]	;@079FF
	cmp	word ptr es:[di+4], -1	;@07A02
	je	@@19	;@07A07
	or	dh, 1	;@07A09
	mov	di, word ptr es:[di+4]	;@07A0C
@@19:	mov	di, word ptr es:[di]	;@07A10
	mov	es, word ptr ds:[7A0h]	;@07A13
@@20:	ret	;@07A17
	push	ax	;@07A18
	push	bx	;@07A19
	push	cx	;@07A1A
	push	dx	;@07A1B
	push	di	;@07A1C
	push	si	;@07A1D
	call	@@15	;@07A1E
	test	dx, 202h	;@07A21
	jne	@@24	;@07A25
	mov	si, word ptr es:[si+8]	;@07A27
	mov	di, word ptr es:[di+8]	;@07A2B
	test	dx, 101h	;@07A2F
	je	@@21	;@07A33
	cmp	si, di	;@07A35
	jne	@@23	;@07A37
	jmp	short @@22	;@07A39
@@21:	cmp	si, di	;@07A3B
	je	@@22	;@07A3D
	mov	cl, 4	;@07A3F
	rol	si, cl	;@07A41
	rol	di, cl	;@07A43
	mov	cx, 0Fh	;@07A45
	and	cx, si	;@07A48
	xor	si, cx	;@07A4A
	add	ax, si	;@07A4C
	adc	cl, ch	;@07A4E
	mov	dx, 0Fh	;@07A50
	and	dx, di	;@07A53
	xor	di, dx	;@07A55
	add	bx, di	;@07A57
	adc	dl, dh	;@07A59
	cmp	cx, dx	;@07A5B
	jne	@@23	;@07A5D
@@22:	cmp	ax, bx	;@07A5F
	je	@@25	;@07A61
@@23:	lahf	;@07A63
	mov	es, word ptr ds:[7C0h]	;@07A64
	sahf	;@07A68
	pop	si	;@07A69
	pop	di	;@07A6A
	pop	dx	;@07A6B
	pop	cx	;@07A6C
	pop	bx	;@07A6D
	pop	ax	;@07A6E
	ret	;@07A6F
@@24:	and	dx, 202h	;@07A70
	cmp	dl, dh	;@07A74
	jne	@@23	;@07A76
	jmp	@@22	;@07A78
@@25:	pop	si	;@07A7A
	pop	di	;@07A7B
	push	di	;@07A7C
	push	si	;@07A7D
	cmp	si, di	;@07A7E
	jmp	@@23	;@07A80
	push	ax	;@07A82
	push	bx	;@07A83
	push	cx	;@07A84
	push	dx	;@07A85
	push	di	;@07A86
	push	si	;@07A87
	call	@@15	;@07A88
	and	dx, 202h	;@07A8B
	jne	@@28	;@07A8F
	mov	cx, word ptr es:[si+6]	;@07A91
	cmp	cx, word ptr es:[di+6]	;@07A95
	jne	@@27	;@07A99
@@26:	cmp	ax, bx	;@07A9B
	je	@@29	;@07A9D
@@27:	lahf	;@07A9F
	mov	es, word ptr ds:[7C0h]	;@07AA0
	sahf	;@07AA4
	pop	si	;@07AA5
	pop	di	;@07AA6
	pop	dx	;@07AA7
	pop	cx	;@07AA8
	pop	bx	;@07AA9
	pop	ax	;@07AAA
	ret	;@07AAB
@@28:	cmp	dh, dl	;@07AAC
	jne	@@27	;@07AAE
	jmp	@@26	;@07AB0
@@29:	pop	si	;@07AB2
	pop	di	;@07AB3
	push	di	;@07AB4
	push	si	;@07AB5
	cmp	si, di	;@07AB6
	jmp	@@27	;@07AB8
	push	ax	;@07ABA
	push	bx	;@07ABB
	push	cx	;@07ABC
	push	dx	;@07ABD
	push	di	;@07ABE
	push	si	;@07ABF
	push	si	;@07AC0
	and	si, 3	;@07AC1
	shl	si, 1	;@07AC4
	shl	si, 1	;@07AC6
	shl	si, 1	;@07AC8
	mov	es, word ptr [si+758h]	;@07ACA
	pop	si	;@07ACE
	push	word ptr es:[si+6]	;@07ACF
	push	word ptr es:[si+4]	;@07AD3
	mov	dl, byte ptr es:[si+0Eh]	;@07AD7
	mov	si, word ptr es:[si]	;@07ADB
	push	di	;@07ADE
	and	di, 3	;@07ADF
	shl	di, 1	;@07AE2
	shl	di, 1	;@07AE4
	shl	di, 1	;@07AE6
	mov	es, word ptr [di+758h]	;@07AE8
	pop	di	;@07AEC
	mov	ax, word ptr es:[di+4]	;@07AED
	mov	bx, word ptr es:[di+6]	;@07AF1
	mov	dh, byte ptr es:[di+0Eh]	;@07AF5
	mov	di, word ptr es:[di]	;@07AF9
	and	dx, 202h	;@07AFC
	cmp	dx, 202h	;@07B00
	je	@@34	;@07B04
	mov	es, word ptr ds:[780h]	;@07B06
	or	dl, dl	;@07B0A
	jne	@@30	;@07B0C
	mov	si, word ptr es:[si]	;@07B0E
@@30:	or	dh, dh	;@07B11
	jne	@@31	;@07B13
	mov	di, word ptr es:[di]	;@07B15
@@31:	mov	es, word ptr ds:[7A0h]	;@07B18
	sub	cx, cx	;@07B1C
	or	dl, dl	;@07B1E
	jne	@@32	;@07B20
	mov	cx, word ptr es:[si+6]	;@07B22
@@32:	or	dh, dh	;@07B26
	mov	dx, 0	;@07B28
	jne	@@33	;@07B2B
	mov	dx, word ptr es:[di+6]	;@07B2D
@@33:	cmp	cx, dx	;@07B31
@@34:	pop	cx	;@07B33
	pop	dx	;@07B34
	jne	@@35	;@07B35
	cmp	bx, dx	;@07B37
	jne	@@35	;@07B39
	cmp	ax, cx	;@07B3B
	je	@@36	;@07B3D
@@35:	lahf	;@07B3F
	mov	es, word ptr ds:[7C0h]	;@07B40
	sahf	;@07B44
	pop	si	;@07B45
	pop	di	;@07B46
	pop	dx	;@07B47
	pop	cx	;@07B48
	pop	bx	;@07B49
	pop	ax	;@07B4A
	ret	;@07B4B
@@36:	pop	si	;@07B4C
	pop	di	;@07B4D
	push	di	;@07B4E
	push	si	;@07B4F
	cmp	si, di	;@07B50
	jmp	@@35	;@07B52
	push	ax	;@07B54
	push	bx	;@07B55
	push	cx	;@07B56
	push	di	;@07B57
	push	si	;@07B58
	push	ds	;@07B59
	push	di	;@07B5A
	and	di, 3	;@07B5B
	shl	di, 1	;@07B5E
	shl	di, 1	;@07B60
	shl	di, 1	;@07B62
	mov	es, word ptr [di+758h]	;@07B64
	pop	di	;@07B68
	mov	di, word ptr es:[di+0Ch]	;@07B69
	push	si	;@07B6D
	and	si, 3	;@07B6E
	shl	si, 1	;@07B71
	shl	si, 1	;@07B73
	shl	si, 1	;@07B75
	mov	es, word ptr [si+758h]	;@07B77
	pop	si	;@07B7B
	mov	si, word ptr es:[si+0Ch]	;@07B7C
	push	di	;@07B80
	and	di, 3	;@07B81
	shl	di, 1	;@07B84
	shl	di, 1	;@07B86
	shl	di, 1	;@07B88
	mov	es, word ptr [di+718h]	;@07B8A
	pop	di	;@07B8E
	inc	di	;@07B8F
	inc	di	;@07B90
	push	si	;@07B91
	and	si, 3	;@07B92
	shl	si, 1	;@07B95
	shl	si, 1	;@07B97
	shl	si, 1	;@07B99
	mov	ds, word ptr [si+718h]	;@07B9B
	pop	si	;@07B9F
	inc	si	;@07BA0
	inc	si	;@07BA1
	lodsb	;@07BA2
	cmp	al, byte ptr es:[di]	;@07BA3
	lahf	;@07BA6
	jbe	@@37	;@07BA7
	mov	al, byte ptr es:[di]	;@07BA9
@@37:	inc	di	;@07BAC
	mov	cl, al	;@07BAD
	xor	ch, ch	;@07BAF
@@38:	lodsb	;@07BB1
	mov	bl, byte ptr es:[di]	;@07BB2
	inc	di	;@07BB5
	or	al, 20h	;@07BB6
	or	bl, 20h	;@07BB8
	cmp	al, bl	;@07BBB
	jne	@@39	;@07BBD
	loop	@@38	;@07BBF
	sahf	;@07BC1
@@39:	pop	ds	;@07BC2
	lahf	;@07BC3
	mov	es, word ptr ds:[7C0h]	;@07BC4
	sahf	;@07BC8
	pop	si	;@07BC9
	pop	di	;@07BCA
	pop	cx	;@07BCB
	pop	bx	;@07BCC
	pop	ax	;@07BCD
	ret	;@07BCE
	db	56h, 57h, 0C7h, 6, 0BEh, 7, 0, 0, 2Bh, 0F6h, 56h, 0BBh, 54h, 7	;@07BCF
	db	0EBh, 6Ch, 26h, 8Bh, 5Ch, 2, 8Eh, 6, 8, 8, 26h, 83h, 7Fh, 6, 0
	db	75h, 46h, 0EBh, 'VSV', 83h, 0E6h, 3, 0D1h, 0E6h, 0D1h, 0E6h, 0D1h
	db	0E6h, 8Eh, 84h, 58h, 7, 5Eh, 80h, 3Eh, 19h, 0, 0, 74h, 7, 26h
	db	0F6h, 44h, 0Eh, 20h, 75h, 0D1h, 26h, 0F6h, 44h, 0Eh, 14h, 'u1&'
	db	8Bh, 5Ch, 2, 83h, 0FBh, 0FFh, 't(S', 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 38h, 7, 5Bh, 26h, 83h, 7Fh, 0Ah
	db	2, 72h, 12h, 0BFh, 2, 0, 57h, 0BFh, 0BCh, 7, 0E8h, 7Fh, 0D8h, 73h
	db	3, 0E8h, 6Dh, 0D8h, 26h, 89h, 35h, 5Bh, 3, 36h, 90h, 4, 3Bh, 77h
	db	2, 72h, 0A0h, 81h, 0FBh, 64h, 7, 77h, 8, 83h, 0C3h, 8, '^FV', 0EBh
	db	0EDh, '^_^', 0C3h
L07C62:	xor	ax, ax	;@07C62
	cwd	;@07C64
	test	byte ptr es:[si+0Eh], 20h	;@07C65
	je	@@1	;@07C6A
	mov	cx, ax	;@07C6C
	mov	bx, ax	;@07C6E
	ret	;@07C70
@@1:	push	si	;@07C71
	mov	cx, word ptr es:[si+4]	;@07C72
	mov	bx, word ptr es:[si+6]	;@07C76
	mov	dl, byte ptr es:[si+0Eh]	;@07C7A
	mov	si, word ptr es:[si]	;@07C7E
	test	dl, 2	;@07C81
	jne	@@5	;@07C84
	mov	es, word ptr ds:[780h]	;@07C86
	cmp	word ptr es:[si+4], -1	;@07C8A
	je	@@2	;@07C8F
	mov	si, word ptr es:[si+4]	;@07C91
@@2:	mov	es, word ptr ds:[778h]	;@07C95
	mov	al, byte ptr es:[si+9]	;@07C99
	mov	es, word ptr ds:[780h]	;@07C9D
	mov	si, word ptr es:[si]	;@07CA1
	test	al, 0E0h	;@07CA4
	je	@@4	;@07CA6
	mov	es, word ptr ds:[7A0h]	;@07CA8
	mov	ax, word ptr es:[si+8]	;@07CAC
	cmp	byte ptr ds:[19h], 0	;@07CB0
	je	@@3	;@07CB5
	mov	ax, word ptr es:[si+6]	;@07CB7
@@3:	pop	si	;@07CBB
	ret	;@07CBC
@@4:	mov	dh, 1	;@07CBD
@@5:	mov	ax, si	;@07CBF
	jmp	@@3	;@07CC1
	db	0E8h, 9, 0FFh, 8Bh, 3Eh, 41h, 0B4h, 0E8h, 13h, 19h, '!  Address         Publics by Name'	;@07CC3
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
	db	0C3h
@@6:	push	si	;@07DD3
	push	di	;@07DD4
	push	ax	;@07DD5
	push	bx	;@07DD6
	push	cx	;@07DD7
	push	dx	;@07DD8
	mov	cl, 3	;@07DD9
	dec	ax	;@07DDB
	shl	ax, cl	;@07DDC
	mov	es, word ptr ds:[780h]	;@07DDE
	mov	bx, word ptr ds:[408h]	;@07DE2
	mov	dx, word ptr es:[bx+6]	;@07DE6
	mov	cl, 4	;@07DEA
	shr	dx, cl	;@07DEC
	mov	bx, word ptr es:[bx]	;@07DEE
	mov	es, word ptr ds:[7A0h]	;@07DF1
	add	dx, word ptr es:[bx+8]	;@07DF5
	mov	word ptr ds:[498h], ax	;@07DF9
	mov	word ptr ds:[49Ah], dx	;@07DFC
	xchg	ax, cx	;@07E00
	add	dx, word ptr ds:[3FEh]	;@07E01
	mov	ax, 8	;@07E05
	mov	si, 697h	;@07E08
	call	L0888F	;@07E0B
	inc	word ptr ds:[4A2h]	;@07E0E
	mov	ax, word ptr ds:[3F2h]	;@07E12
	mov	dx, word ptr ds:[3F4h]	;@07E15
	mov	cx, 4	;@07E19
	add	word ptr ds:[3F2h], cx	;@07E1C
	adc	word ptr ds:[3F4h], 0	;@07E20
	mov	si, 498h	;@07E25
	call	L0895D	;@07E28
	pop	dx	;@07E2B
	pop	cx	;@07E2C
	pop	bx	;@07E2D
	pop	ax	;@07E2E
	pop	di	;@07E2F
	pop	si	;@07E30
	ret	;@07E31
@@7:	push	si	;@07E32
	push	di	;@07E33
	mov	ax, word ptr es:[di+8]	;@07E34
	mov	word ptr ds:[697h], ax	;@07E38
	mov	ax, word ptr es:[di+0Bh]	;@07E3B
	mov	word ptr ds:[69Dh], ax	;@07E3F
	mov	si, 0Fh	;@07E42
	and	si, ax	;@07E45
	add	si, word ptr es:[di+0Dh]	;@07E47
	mov	word ptr ds:[699h], si	;@07E4B
	sub	dx, dx	;@07E4F
	mov	cl, byte ptr es:[di+1]	;@07E51
	cmp	cl, 0FEh	;@07E55
	jne	@@8	;@07E58
	or	dx, 4	;@07E5A
@@8:	cmp	cl, 0	;@07E5D
	jle	@@9	;@07E60
	or	dx, 1	;@07E62
	cmp	cl, 2	;@07E65
	jl	@@9	;@07E68
	cmp	si, 20h	;@07E6A
	jb	@@9	;@07E6D
	or	dx, 2	;@07E6F
@@9:	mov	word ptr ds:[69Bh], dx	;@07E72
	mov	ax, word ptr es:[di+6]	;@07E76
	call	@@6	;@07E7A
	pop	di	;@07E7D
	pop	si	;@07E7E
	ret	;@07E7F
@@10:	mov	bx, word ptr ds:[45Ch]	;@07E80
	push	bx	;@07E84
	and	bx, 3	;@07E85
	shl	bx, 1	;@07E88
	shl	bx, 1	;@07E8A
	shl	bx, 1	;@07E8C
	mov	es, word ptr [bx+758h]	;@07E8E
	pop	bx	;@07E92
	mov	cx, word ptr es:[bx+4]	;@07E93
	mov	si, word ptr ds:[408h]	;@07E97
	mov	es, word ptr ds:[780h]	;@07E9B
	mov	si, word ptr es:[si]	;@07E9F
	mov	es, word ptr ds:[7A0h]	;@07EA2
	mov	dx, word ptr es:[si+8]	;@07EA6
	add	dx, word ptr ds:[3FEh]	;@07EAA
	push	dx	;@07EAE
	push	ds	;@07EAF
	mov	si, word ptr ds:[13Ah]	;@07EB0
	lds	bx, dword ptr ds:[134h]	;@07EB4
	mov	di, ds	;@07EB8
	mov	ds, word ptr [bx]	;@07EBA
	push	bx	;@07EBC
	lea	si, [si+2]	;@07EBD
	cld	;@07EC0
@@11:	mov	bx, si	;@07EC1
@@12:	lodsb	;@07EC3
	cmp	al, 5Ch	;@07EC4
	je	@@11	;@07EC6
	or	al, al	;@07EC8
	jne	@@12	;@07ECA
	mov	si, bx	;@07ECC
	mov	ax, 0Ch	;@07ECE
	pop	bx	;@07ED1
	pop	ds	;@07ED2
	call	L08885	;@07ED3
	test	word ptr ds:[47Ah], 8	;@07ED6
	je	@@14	;@07EDC
	mov	ah, 2Ah	;@07EDE
	int	21h	;@07EE0
	mov	word ptr ds:[40Ch], dx	;@07EE2
	mov	word ptr ds:[40Eh], cx	;@07EE6
	mov	bx, word ptr ds:[45Eh]	;@07EEA
	push	bx	;@07EEE
	and	bx, 3	;@07EEF
	shl	bx, 1	;@07EF2
	shl	bx, 1	;@07EF4
	shl	bx, 1	;@07EF6
	mov	es, word ptr [bx+758h]	;@07EF8
	pop	bx	;@07EFC
	mov	cx, word ptr es:[bx+4]	;@07EFD
	pop	dx	;@07F01
	mov	ax, 4	;@07F02
	mov	si, 40Ch	;@07F05
	call	L0888F	;@07F08
@@13:	ret	;@07F0B
@@14:	add	sp, 2	;@07F0C
	jmp	@@13	;@07F0F
	cmp	word ptr ds:[414h], 1	;@07F11
	je	@@15	;@07F16
	cmp	word ptr ds:[416h], 1	;@07F18
	je	@@18	;@07F1D
	ret	;@07F1F
@@15:	mov	bx, word ptr ds:[408h]	;@07F20
	mov	es, word ptr ds:[780h]	;@07F24
	mov	ax, word ptr es:[bx+6]	;@07F28
	mov	bx, word ptr es:[bx]	;@07F2C
	mov	es, word ptr ds:[7A0h]	;@07F2F
	mov	dx, word ptr es:[bx+8]	;@07F33
	mov	cl, 4	;@07F37
	shr	ax, cl	;@07F39
	add	dx, ax	;@07F3B
	mov	word ptr ds:[40Ah], dx	;@07F3D
	sub	si, si	;@07F41
	jmp	short @@17	;@07F43
@@16:	mov	es, word ptr ds:[7A0h]	;@07F45
	cmp	byte ptr es:[si+1], 3	;@07F49
	jge	@@18	;@07F4E
	mov	di, si	;@07F50
	call	@@7	;@07F52
	add	si, 14h	;@07F55
@@17:	cmp	si, word ptr ds:[79Eh]	;@07F58
	jb	@@16	;@07F5C
@@18:	cmp	word ptr ds:[416h], 1	;@07F5E
	jne	@@19	;@07F63
	call	@@10	;@07F65
@@19:	ret	;@07F68
	mov	dx, word ptr ds:[476h]	;@07F69
	cmp	dx, -1	;@07F6D
	je	@@20	;@07F70
	add	dx, word ptr ds:[3FEh]	;@07F72
	mov	cx, word ptr ds:[478h]	;@07F76
	mov	ax, 2	;@07F7A
	mov	si, 47Ch	;@07F7D
	call	L0888F	;@07F80
@@20:	ret	;@07F83
@@21:	push	ax	;@07F84
	push	bx	;@07F85
	push	cx	;@07F86
	push	dx	;@07F87
	push	di	;@07F88
	push	si	;@07F89
	mov	es, word ptr ds:[780h]	;@07F8A
	mov	si, word ptr es:[di+4]	;@07F8E
	mov	si, word ptr es:[si]	;@07F92
	mov	es, word ptr ds:[7A0h]	;@07F95
	mov	ax, word ptr es:[bx+8]	;@07F99
	mov	cl, byte ptr es:[bx+0Ah]	;@07F9D
	mov	ch, 0	;@07FA1
	sub	ax, word ptr ds:[406h]	;@07FA3
	sbb	cl, ch	;@07FA7
	mov	ch, 4	;@07FA9
@@22:	shl	ax, 1	;@07FAB
	rcl	cl, 1	;@07FAD
	dec	ch	;@07FAF
	jne	@@22	;@07FB1
	mov	word ptr ds:[676h], ax	;@07FB3
	mov	word ptr ds:[678h], cx	;@07FB6
	mov	ax, word ptr es:[bx+0Dh]	;@07FBA
	mov	word ptr ds:[67Ah], ax	;@07FBE
	mov	ax, word ptr es:[bx+11h]	;@07FC1
	shl	ax, 1	;@07FC5
	mov	word ptr ds:[67Ch], ax	;@07FC7
	mov	ax, word ptr es:[si+0Dh]	;@07FCA
	sub	ax, 20h	;@07FCE
	mov	cx, 5	;@07FD1
	sub	dx, dx	;@07FD4
	div	cx	;@07FD6
	mov	word ptr ds:[67Eh], ax	;@07FD8
	mov	dx, word ptr es:[si+8]	;@07FDB
	add	dx, word ptr ds:[3FEh]	;@07FDF
	sub	cx, cx	;@07FE3
	mov	ax, 20h	;@07FE5
	mov	si, 672h	;@07FE8
	call	L0888F	;@07FEB
	pop	si	;@07FEE
	pop	di	;@07FEF
	pop	dx	;@07FF0
	pop	cx	;@07FF1
	pop	bx	;@07FF2
	pop	ax	;@07FF3
	ret	;@07FF4
@@23:	push	ax	;@07FF5
	push	bx	;@07FF6
	push	cx	;@07FF7
	push	dx	;@07FF8
	push	di	;@07FF9
	push	si	;@07FFA
	mov	byte ptr ds:[696h], 0	;@07FFB
	mov	bx, word ptr ds:[47Ch]	;@08000
	mov	word ptr ds:[692h], bx	;@08004
	mov	es, word ptr ds:[780h]	;@08008
	mov	si, word ptr es:[di+4]	;@0800C
	mov	di, word ptr es:[si]	;@08010
	mov	si, word ptr es:[si+4]	;@08013
	mov	es, word ptr ds:[7A0h]	;@08017
	mov	dx, word ptr es:[di+8]	;@0801B
	add	dx, word ptr ds:[3FEh]	;@0801F
@@24:	cmp	si, -1	;@08023
	je	@@25	;@08026
	push	si	;@08028
	and	si, 3	;@08029
	shl	si, 1	;@0802C
	shl	si, 1	;@0802E
	shl	si, 1	;@08030
	mov	es, word ptr [si+758h]	;@08032
	pop	si	;@08036
	push	word ptr es:[si+0Ah]	;@08037
	mov	ax, word ptr es:[si+4]	;@0803B
	mov	word ptr ds:[694h], ax	;@0803F
	mov	cx, word ptr es:[si+8]	;@08042
	mov	ax, 5	;@08046
	mov	si, 692h	;@08049
	call	L0888F	;@0804C
	pop	si	;@0804F
	jmp	@@24	;@08050
@@25:	pop	si	;@08052
	pop	di	;@08053
	pop	dx	;@08054
	pop	cx	;@08055
	pop	bx	;@08056
	pop	ax	;@08057
	ret	;@08058
@@26:	push	bx	;@08059
	push	cx	;@0805A
	mov	bx, word ptr ds:[404h]	;@0805B
	cmp	bx, -1	;@0805F
	jne	@@27	;@08062
	sub	ax, ax	;@08064
	cwd	;@08066
	jmp	short @@28	;@08067
@@27:	mov	es, word ptr ds:[7A0h]	;@08069
	mov	ax, 10h	;@0806D
	mul	word ptr es:[bx+8]	;@08070
	xchg	ax, bx	;@08074
	mov	cx, dx	;@08075
	mov	dx, word ptr ds:[3DEh]	;@08077
	mov	ax, word ptr ds:[3DCh]	;@0807B
	sub	ax, bx	;@0807E
	sbb	dx, cx	;@08080
	add	ax, 0Fh	;@08082
	adc	dx, 0	;@08085
	and	al, 0F0h	;@08088
@@28:	pop	cx	;@0808A
	pop	bx	;@0808B
	ret	;@0808C
@@29:	push	si	;@0808D
	push	di	;@0808E
	mov	di, 664h	;@0808F
	mov	word ptr [di], 4246h	;@08092
	mov	word ptr [di+2], 564Fh	;@08096
	call	@@26	;@0809B
	mov	word ptr [di+4], ax	;@0809E
	mov	word ptr [di+6], dx	;@080A1
	mov	dx, word ptr ds:[40Ah]	;@080A4
	cmp	dx, -1	;@080A8
	jne	@@30	;@080AB
	sub	ax, ax	;@080AD
	cwd	;@080AF
	sub	cx, cx	;@080B0
	jmp	short @@32	;@080B2
@@30:	add	dx, word ptr ds:[3FEh]	;@080B4
	mov	ax, 10h	;@080B8
	mul	dx	;@080BB
	mov	bx, word ptr ds:[404h]	;@080BD
	cmp	bx, -1	;@080C1
	je	@@31	;@080C4
	mov	es, word ptr ds:[7A0h]	;@080C6
	mov	cx, word ptr es:[bx+6]	;@080CA
	dec	cx	;@080CE
	jmp	short @@32	;@080CF
@@31:	mov	cx, word ptr ds:[6BBh]	;@080D1
@@32:	mov	word ptr [di+8], ax	;@080D5
	mov	word ptr [di+0Ah], dx	;@080D8
	mov	word ptr [di+0Ch], cx	;@080DB
	mov	ax, 0Eh	;@080DE
	xor	cx, cx	;@080E1
	mov	dx, word ptr ds:[418h]	;@080E3
	add	dx, word ptr ds:[3FEh]	;@080E7
	mov	si, 664h	;@080EB
	call	L0888F	;@080EE
	pop	di	;@080F1
	pop	si	;@080F2
	ret	;@080F3
	push	si	;@080F4
	push	di	;@080F5
	mov	bx, word ptr ds:[404h]	;@080F6
	cmp	bx, -1	;@080FA
	jne	@@33	;@080FD
	cmp	word ptr ds:[414h], 1	;@080FF
	je	@@35	;@08104
	jmp	short @@36	;@08106
@@33:	push	ds	;@08108
	pop	es	;@08109
	xor	ax, ax	;@0810A
	mov	cx, 20h	;@0810C
	mov	di, 672h	;@0810F
	rep stosb	;@08112
	mov	ax, word ptr ds:[47Ch]	;@08114
	mov	word ptr ds:[672h], ax	;@08117
	mov	es, word ptr ds:[7A0h]	;@0811A
	mov	ax, word ptr es:[bx+8]	;@0811E
	mov	word ptr ds:[406h], ax	;@08122
@@34:	mov	di, word ptr es:[bx+4]	;@08125
	call	@@21	;@08129
	call	@@23	;@0812C
	add	bx, 14h	;@0812F
	cmp	bx, word ptr ds:[79Eh]	;@08132
	jae	@@35	;@08136
	mov	es, word ptr ds:[7A0h]	;@08138
	jmp	@@34	;@0813C
@@35:	call	@@29	;@0813E
@@36:	pop	di	;@08141
	pop	si	;@08142
	ret	;@08143
	db	80h, 3Eh, 13h, 0, 1, 75h, 19h, 1Eh, 8Bh, 16h, 3Ch, 1, 0C5h, 1Eh	;@08144
	db	34h, 1, 8Eh, 1Fh, 83h, 0C2h, 2, 0B4h, 3Ch, 33h, 0C9h, 0E8h, 8Ch
	db	81h, 1Fh, 0A3h, 22h, 0, 0C3h, 0BFh, 1Eh, 1, 0B9h, 1Ch, 0, 0B8h
	db	97h, 1, 8Eh, 0C0h, 26h, 8Bh, 35h, 8Ch, 6, 'PRQW&', 8Ah, 65h, 4
	db	0E8h, 9Ah, 0Ch, 5Fh, 59h, 0B8h, 97h, 1, 8Eh, 0C0h, 26h, 8Bh, 75h
	db	2, 89h, 1Ch, 49h, 74h, 5, 83h, 0C7h, 5, 0EBh, 0DBh, 8Bh, 1Eh, 4Eh
	db	4, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh
	db	87h, 18h, 7, 5Bh, 26h, 0C7h, 47h, 3, ':O&', 0C7h, 47h, 5, 56h
	db	59h, 0C3h, 55h, 8Bh, 0ECh, 80h, 3Eh, 0D7h, 3, 1, 75h, 6Dh, 83h
	db	3Eh, 0FCh, 3, 0FFh, 74h, 66h, 0BEh, 0C9h, 0, 0B4h, 0, 0BBh, 97h
	db	1, 89h, 1Eh, 50h, 52h, 0E8h, 52h, 0Dh, 'r"S', 83h, 0E3h, 3, 0D1h
	db	0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 0F6h
	db	47h, 0Eh, 10h, 74h, 0Ch, 8Bh, 36h, 37h, 0Ah, 83h, 0FEh, 0FFh, 74h
	db	3, 0E8h, 37h, 0, 0BEh, 0D0h, 0, 0B4h, 0, 0BBh, 97h, 1, 89h, 1Eh
	db	50h, 52h, 0E8h, 1Fh, 0Dh, 'r"S', 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h
	db	0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 0F6h, 47h, 0Eh, 10h
	db	74h, 0Ch, 8Bh, 36h, 39h, 0Ah, 83h, 0FEh, 0FFh, 74h, 3, 0E8h, 4
	db	0, 8Bh, 0E5h, 5Dh, 0C3h, 26h, 89h, 37h, 26h, 0C7h, 47h, 4, 0, 0
	db	26h, 0C7h, 47h, 6, 0, 0, 0B0h, 0EFh, '& G', 0Eh, 0C3h, 8Ch, 1Eh
	db	7Eh, 4, 8Ch, 0Eh, 80h, 4, 0C7h, 6, 82h, 4, 97h, 1, 0A0h, 34h, 0Ah
	db	0Ah, 6, 16h, 0, 0Ah, 6, 19h, 0, 8, 6, 54h, 2, 0C7h, 6, 35h, 0Ah
	db	0, 0, 0C6h, 6, 10h, 4, 0, 83h, 3Eh, 7Ch, 4, 0FFh, 75h, 6, 0C7h
	db	6, 7Ch, 4, 0CDh, 3Fh, 1Eh, 7, 33h, 0C0h, 0BFh, 9Ch, 4, 0B9h, 1Fh
	db	0, 0F3h, 0ABh, 0C7h, 6, 0B2h, 4, 0FFh, 0FFh, 0BFh, 9Fh, 6, 0B9h
	db	40h, 0, 0D1h, 0E9h, 0F3h, 0ABh, 0E8h, 8Fh, 8, 0C7h, 6, 8Fh, 3
	db	0, 0, 0B8h, 10h, 0, 38h, 26h, 16h, 0, 74h, 29h, 1Eh, 7, 0BFh, 0DAh
	db	4, 0B9h, 28h, 0, 33h, 0C0h, 0F3h, 0ABh, 0A3h, 8Ah, 4, 0A3h, 8Ch
	db	4, 0A3h, 8Eh, 4, 0A3h, 92h, 4, 0BFh, 0B2h, 3, 0B9h, 1Ah, 0, 0F3h
	db	0AAh, 0C7h, 6, 0C4h, 3, 1, 0, 0B8h, 14h, 0, 0A3h, 90h, 4, 2Bh
	db	0C0h, 0A3h, 0EAh, 3, 0A3h, 0ECh, 3, 0A3h, 1Eh, 4, 0A3h, 20h, 4
	db	0E8h, 0Ah, 0D3h, 80h, 3Eh, 19h, 0, 1, 75h, 0Ch, 0BFh, 4, 8, 0E8h
	db	0E3h, 0D2h, 0BFh, 0Ch, 8, 0E8h, 0A1h, 0D3h, 0C6h, 6, 0D4h, 3, 0
	db	0C6h, 6, 94h, 4, 0, 0C6h, 6, 88h, 4, 0, 0E8h, 39h, 0FEh, 0E8h
	db	4Eh, 11h, 80h, 3Eh, 19h, 0, 0, 74h, 11h, 0C7h, 6, 0, 4, 8, 0, 0C7h
	db	6, 2, 4, 0F3h, 6, 0E8h, 0BBh, 17h, 0EBh, 0Ch, 0C7h, 6, 0, 4, 2
	db	0, 0C7h, 6, 2, 4, 62h, 6, 0C7h, 6, 11h, 4, 0, 0, 0E8h, 2Ah, 0FEh
	db	0C7h, 6, 1Ch, 4, 0, 0, 0C7h, 6, 0D0h, 3, 3Ch, 58h, 0C6h, 6, 0D5h
	db	3, 0, 0E8h, 0ABh, 6, 0A1h, 74h, 52h, 0A3h, 96h, 4, 8Bh, 36h, 38h
	db	1, 0E8h, 0E7h, 7, 0C6h, 6, 0D5h, 3, 1, 8Bh, 36h, 3Eh, 1, 0E8h
	db	92h, 6, 0E8h, 0D8h, 7, 0C7h, 6, 96h, 4, 0, 0, 0E8h, 0A4h, 0C1h
	db	0C6h, 6, 54h, 2, 1, 0C6h, 6, 0D5h, 3, 2, 0E8h, 45h, 2, 0E8h, 12h
	db	0D7h, 53h, 8Bh, 1Eh, 3Ah, 7, 0C4h, 7Fh, 2, 83h, 0C7h, 18h, ';?v'
	db	9, 0E8h, 53h, 0D1h, 5Bh, 73h, 7, 0E8h, 14h, 0D1h, 87h, 7Fh, 2
	db	5Bh, 0ABh, 0A1h, 76h, 7, 0ABh, 0A1h, 86h, 7, 0ABh, 0A1h, 96h, 7
	db	0ABh, 0A1h, 0AEh, 7, 0ABh, 0B8h, 3, 0, 0ABh, 0B0h, 0, 0ABh, 0ABh
	db	0AAh, 80h, 3Eh, 19h, 0, 0, 74h, 6, 0E8h, 0ADh, 33h, 0E8h, 33h
	db	36h, 0E8h, 0A1h, 0DFh, 0A1h, 0A2h, 4, 0A3h, 49h, 0Ah, 80h, 3Eh
	db	19h, 0, 1, 75h, 0Bh, 0E8h, 53h, 16h, 23h, 0C0h, 74h, 1, 40h, 0A3h
	db	0F8h, 3, 80h, 3Eh, 88h, 4, 1, 75h, 3, 0E8h, 2Bh, 0E0h, 0E8h, 11h
	db	0E4h, 8Eh, 6, 0C0h, 7, 8Bh, 0Eh, 0BEh, 7, 0BDh, 6Bh, 64h, 0E8h
	db	60h, 0Bh, 0E8h, 0FAh, 0E4h, 80h, 3Eh, 19h, 0, 1, 75h, 3, 0E8h
	db	8Bh, 0E6h, 0C7h, 6, 0BBh, 6, 0, 0, 0E8h, 0C6h, 0E7h, 8Bh, 1Eh
	db	24h, 4, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 87h, 18h, 7, 5Bh, 26h, 8Bh, 7, 3Dh, 0FFh, 0FFh, 74h, 3, 0A3h
	db	0FCh, 3, 0E8h, 0ECh, 0F0h, 80h, 3Eh, 19h, 0, 1, 75h, 3, 0E8h, 0A0h
	db	1Ch, 0E8h, 7Ah, 0EBh, 0E8h, 71h, 0FDh, 0E8h, 96h, 0EDh, 0E8h, 0D9h
	db	0EDh, 0E8h, 0B6h, 0F1h, 80h, 3Eh, 19h, 0, 0, 75h, 3, 0E8h, 3Ah
	db	0EEh, 80h, 3Eh, 13h, 0, 1, 'uA3', 0C0h, 0E8h, 61h, 0F4h, 8Bh, 3Eh
	db	41h, 0B4h, 0E8h, 1Ch, 11h, 89h, 3Eh, 41h, 0B4h, 80h, 3Eh, 15h
	db	0, 1, 75h, 11h, 0B8h, 1, 0, 0E8h, 49h, 0F4h, 8Bh, 3Eh, 41h, 0B4h
	db	0E8h, 4, 11h, 89h, 3Eh, 41h, 0B4h, 80h, 3Eh, 14h, 0, 1, 75h, 12h
	db	0E8h, 33h, 0F8h, 8Bh, 3Eh, 41h, 0B4h, 89h, 3Eh, 41h, 0B4h, 80h
	db	3Eh, 16h, 0, 0, 75h, 0Ah, 80h, 3Eh, 16h, 0, 0, 74h, 13h, 0E8h
	db	26h, 0F7h, 0BDh, 18h, 7Ah, 8Bh, 0Eh, 0BEh, 7, 8Eh, 6, 0C0h, 7
	db	0E8h, 0A6h, 0Ah, 0EBh, 6, 0C7h, 6, 0BEh, 7, 0, 0, 0C7h, 6, 8Eh
	db	7, 0, 0, 80h, 3Eh, 10h, 4, 0, 74h, 3, 0E8h, 41h, 1, 0C6h, 6, 4Eh
	db	0Ah, 0, 0E8h, 0D4h, 0, 0C6h, 6, 0D4h, 3, 1, 0E8h, 42h, 0D2h, 80h
	db	3Eh, 19h, 0, 0, 74h, 9, 0E8h, 0BFh, 2Eh, 0E8h, 0B9h, 2Fh, 0E8h
	db	0DEh, 17h, 80h, 3Eh, 16h, 0, 0, 74h, 6, 0E8h, 1Fh, 0C5h, 0E8h
	db	0ACh, 0CBh, 0C7h, 6, 0EAh, 3, 0, 0, 33h, 0D2h, 80h, 3Eh, 23h, 1
	db	1, 75h, 17h, 8Bh, 16h, 0FEh, 3, 0B8h, 10h, 0, 0F7h, 0E2h, 3, 6
	db	0DCh, 3, 13h, 16h, 0DEh, 3, 0B9h, 0, 0, 0E8h, 3Bh, 4, 0C7h, 6
	db	0D0h, 3, 3Ch, 59h, 0C7h, 6, 0E2h, 3, 0, 0, 0C6h, 6, 0F1h, 3, 0FFh
	db	0C6h, 6, 94h, 4, 0, 0E8h, 0BFh, 4, 0A0h, 26h, 1, 0A2h, 17h, 0
	db	0C6h, 6, 0D5h, 3, 3, 0A1h, 74h, 52h, 0A3h, 96h, 4, 8Bh, 36h, 38h
	db	1, 0E8h, 0F0h, 5, 0C6h, 6, 0D5h, 3, 4, 0E8h, 9Fh, 4, 8Bh, 36h
	db	3Eh, 1, 0E8h, 0E1h, 5, 0E8h, 0ACh, 0F9h, 0E8h, 1, 0FAh, 0E8h, 89h
	db	0FBh, 80h, 3Eh, 16h, 0, 0, 74h, 3, 0E8h, 0B2h, 0CEh, 80h, 3Eh
	db	2Bh, 1, 1, 75h, 10h, 81h, 3Eh, 0B0h, 4, 0, 1, 74h, 17h, 0E8h, 2
	db	0Bh, 75h, 12h, 0E9h, 0FDh, 0B6h, 80h, 3Eh, 19h, 0, 0, 74h, 5, 0E8h
	db	2Fh, 1Bh, 0EBh, 3, 0E8h, 70h, 0EEh, 8Bh, 3Eh, 41h, 0B4h, 0E8h
	db	0E4h, 0Fh, 0E8h, 1Bh, 0Fh, 0E8h, 44h, 1, 2Bh, 0C0h, 0C3h, 1Eh
	db	8Bh, 16h, 3Ah, 1, 0C5h, 1Eh, 34h, 1, 8Eh, 1Fh, 83h, 0C2h, 2, 0B8h
	db	0, 3Ch, 33h, 0C9h, 0E8h, 2Bh, 7Dh, 1Fh, 0A3h, 24h, 0, 0C3h, 80h
	db	3Eh, 0D7h, 3, 1, 75h, 39h, 8Bh, 1Eh, 43h, 0Ah, 83h, 0FBh, 0FFh
	db	74h, 30h, 8Eh, 6, 78h, 7, 26h, 8Ah, 47h, 9, 26h, 8Bh, 0Fh, 50h
	db	0E8h, 57h, 0D4h, 58h, 26h, 88h, 45h, 9, 26h, 89h, 0Dh, 26h, 0C7h
	db	45h, 6, 10h, 0, 8Bh, 1Eh, 38h, 4, 26h, 89h, 1Dh, 8Bh, 1Eh, 4Ch
	db	4, 26h, 89h, 5Dh, 2, 89h, 3Eh, 3Ah, 4, 0C3h, 0, 0, 0, 0, 0, 0
	db	0, 0, 0
L08610:	mov	di, word ptr ds:[0B441h]	;@08610
	db	0E8h, 6Fh, 0Fh	; call PUT_NEWLINE	;@08614
	call	L094C0	;@08617
	call	L092D4	;@0861A
	call	L092E5	;@0861D
	ret	;@08620
L08621:	push	ax	;@08621
	push	bx	;@08622
	push	dx	;@08623
	push	di	;@08624
	push	es	;@08625
	mov	bx, cx	;@08626
	and	cx, 3FFh	;@08628
	xor	bx, cx	;@0862C
	mov	di, 1250h	;@0862E
	sub	di, cx	;@08631
	push	di	;@08633
	or	cx, bx	;@08634
	je	@@1	;@08636
	push	ds	;@08638
	pop	es	;@08639
	shr	cx, 1	;@0863A
	rep movsw	;@0863C
	rcl	cx, 1	;@0863E
	rep movsb	;@08640
@@1:	mov	ax, word ptr ds:[526Ch]	;@08642
	mov	dx, word ptr ds:[526Eh]	;@08645
	sub	ax, bx	;@08649
	sbb	dl, dh	;@0864B
	mov	word ptr ds:[5268h], ax	;@0864D
	mov	word ptr ds:[526Ah], dx	;@08650
	mov	cx, 4000h	;@08654
	sub	cx, bx	;@08657
	cmp	byte ptr ds:[161h], 0	;@08659
	je	@@2	;@0865E
	mov	ax, word ptr ds:[5264h]	;@08660
	mov	dx, word ptr ds:[5266h]	;@08663
	sub	ax, word ptr ds:[526Ch]	;@08667
	sbb	dx, word ptr ds:[526Eh]	;@0866B
	jne	@@2	;@0866F
	cmp	ax, cx	;@08671
	ja	@@2	;@08673
	xchg	ax, cx	;@08675
@@2:	mov	ah, 3Fh	;@08676
	mov	bx, word ptr ds:[26h]	;@08678
	mov	dx, di	;@0867C
	call	DOS_CALL	;@0867E
	or	ax, ax	;@08681
	je	@@3	;@08683
	add	word ptr ds:[526Ch], ax	;@08685
	adc	word ptr ds:[526Eh], 0	;@08689
	add	ax, di	;@0868E
	mov	word ptr ds:[5258h], ax	;@08690
	pop	si	;@08693
	pop	es	;@08694
	pop	di	;@08695
	pop	dx	;@08696
	pop	bx	;@08697
	pop	ax	;@08698
	ret	;@08699
@@3:	call	L0869D	;@0869A
L0869D:	push	ds	;@0869D
	mov	ax, 92BBh	;@0869E
	push	ax	;@086A1
	mov	ax, 4	;@086A2
	push	ax	;@086A5
	mov	ax, 5	;@086A6
	push	ax	;@086A9
	db	0E8h, 0F4h, 34h	; call FATAL	;@086AA
@@1:	xchg	bx, si	;@086AD
	push	bx	;@086AF
	push	cx	;@086B0
	push	dx	;@086B1
	push	ds	;@086B2
	push	ax	;@086B3
	mov	dx, si	;@086B4
	mov	cl, 6	;@086B6
	shl	dx, cl	;@086B8
	xchg	dl, dh	;@086BA
	sub	cx, cx	;@086BC
	xchg	dl, cl	;@086BE
	mov	bx, word ptr ds:[24h]	;@086C0
	mov	ax, 4200h	;@086C4
	call	DOS_CALL	;@086C7
	mov	bx, word ptr ds:[24h]	;@086CA
	mov	cx, 8000h	;@086CE
	cmp	si, word ptr ds:[484h]	;@086D1
	jne	@@2	;@086D5
	mov	cx, word ptr ds:[486h]	;@086D7
@@2:	pop	ax	;@086DB
	xor	dx, dx	;@086DC
	mov	ds, word ptr [si+834h]	;@086DE
	call	DOS_CALL_FULL	;@086E2
	pop	ds	;@086E5
	pop	dx	;@086E6
	pop	cx	;@086E7
	pop	bx	;@086E8
	xchg	bx, si	;@086E9
	ret	;@086EB
	db	83h, 3Eh, 84h, 4, 0FFh, 75h, 1, 0C3h, 1Eh, 0B8h, 34h, 8, 50h, 9Ah	;@086EC
	db	0DFh, 2Dh, 0DFh, 0, 23h, 0C0h, 74h, 3, 0E9h, 80h, 0, 33h, 0DBh
	db	83h, 0BFh, 34h, 8, 0FFh, 'u)S', 1Eh, 0B8h, 34h, 8, 50h, 9Ah, 0DFh
	db	2Dh, 0DFh, 0, 23h, 0C0h, '[ug', 8Eh, 6, 34h, 8, 2Bh, 0FFh, 2Bh
	db	0C0h, 0B9h, 0, 40h, 0FCh, 0F3h, 0ABh, 8Ch, 87h, 34h, 8, 0B4h, 40h
	db	0E8h, 78h, 0FFh, 0EBh, 3Ah, 53h, 1Eh, 81h, 0C3h, 34h, 8, 53h, 9Ah
	db	30h, 1Ch, 0DFh, 0, 5Bh, 23h, 0C0h, 'u)S', 1Eh, 81h, 0C3h, 34h
	db	8, 53h, 9Ah, 0DFh, 2Dh, 0DFh, 0, 5Bh, 23h, 0C0h, 75h, 2Ch, 0B4h
	db	40h, 0E8h, 4Fh, 0FFh, 23h, 0DBh, 75h, 2, 0EBh, 0Dh, 53h, 1Eh, 81h
	db	0C3h, 34h, 8, 53h, 9Ah, 0FCh, 15h, 0DFh, 0, 5Bh, 83h, 0C3h, 2
	db	3Bh, 1Eh, 84h, 4, 76h, 8Dh, 1Eh, 0B8h, 34h, 8, 50h, 9Ah, 0FCh
	db	15h, 0DFh, 0, 0C3h, 0E9h, 18h, 7Bh
	push	bp	;@08788
	mov	bp, sp	;@08789
	push	ds	;@0878B
	push	si	;@0878C
	push	di	;@0878D
	mov	ds, word ptr cs:L00100+16	;@0878E
	mov	ax, word ptr [bp+0Ch]	;@08793
	dec	ax	;@08796
	je	@@3	;@08797
	dec	ax	;@08799
	jne	@@5	;@0879A
	mov	ah, 3Fh	;@0879C
	jmp	short @@4	;@0879E
@@3:	mov	ah, 40h	;@087A0
@@4:	mov	bx, word ptr [bp+8]	;@087A2
	sub	bx, 834h	;@087A5
	call	@@1	;@087A9
@@5:	xor	ax, ax	;@087AC
	pop	di	;@087AE
	pop	si	;@087AF
	pop	ds	;@087B0
	pop	bp	;@087B1
	retf	8	;@087B2
	db	88h, 87h, 1Fh, 0	;@087B5
L087B9:	push	bx	;@087B9
	push	ds	;@087BA
	add	bx, 834h	;@087BB
	push	bx	;@087BF
	push	word ptr cs:L088B7	;@087C0
	push	word ptr cs:L088B5	;@087C5
	db	9Ah, 35h, 17h, 0DFh, 0	; lcall 0xdf, 0x1735	;@087CA
	pop	bx	;@087CF
	push	bx	;@087D0
	push	ds	;@087D1
	add	bx, 834h	;@087D2
	push	bx	;@087D6
	db	9Ah, 17h, 2Eh, 0DFh, 0	; lcall 0xdf, 0x2e17	;@087D7
	pop	bx	;@087DC
	ret	;@087DD
L087DE:	push	ax	;@087DE
	push	cx	;@087DF
	push	dx	;@087E0
	xchg	ax, cx	;@087E1
	mov	cl, 4	;@087E2
	rol	dx, cl	;@087E4
	mov	cx, 0FFF0h	;@087E6
	and	cx, dx	;@087E9
	xor	dx, cx	;@087EB
	add	ax, cx	;@087ED
	adc	dl, dh	;@087EF
	jmp	short L08800	;@087F1
L087F3:	xor	ax, ax	;@087F3
	push	ax	;@087F5
	mov	ax, 17h	;@087F6
	push	ax	;@087F9
	db	0E8h, 0A4h, 33h	; call FATAL	;@087FA
L087FD:	push	ax	;@087FD
	push	cx	;@087FE
	push	dx	;@087FF
L08800:	sub	ax, word ptr ds:[0A35h]	;@08800
	sbb	dx, 0	;@08804
	jb	L087F3	;@08807
	mov	bx, 8000h	;@08809
	and	bx, ax	;@0880C
	xor	ax, bx	;@0880E
	xchg	ax, di	;@08810
	or	bx, dx	;@08811
	mov	cl, 2	;@08813
	rol	bx, cl	;@08815
	mov	ax, word ptr [bx+834h]	;@08817
	cmp	ah, 0FFh	;@0881B
	je	@@5	;@0881E
	cmp	ax, 1000h	;@08820
	jb	@@2	;@08823
	mov	es, ax	;@08825
@@1:	mov	word ptr ds:[525Ch], bx	;@08827
	pop	dx	;@0882B
	pop	cx	;@0882C
	pop	ax	;@0882D
	ret	;@0882E
@@2:	push	di	;@0882F
	push	bx	;@08830
	push	ds	;@08831
	add	bx, 834h	;@08832
	push	bx	;@08836
	db	9Ah, 0DFh, 2Dh, 0DFh, 0	; lcall 0xdf, 0x2ddf	;@08837
	pop	bx	;@0883C
	pop	di	;@0883D
	and	ax, ax	;@0883E
	jne	@@4	;@08840
@@3:	call	L087B9	;@08842
	mov	es, word ptr [bx+834h]	;@08845
	jmp	@@1	;@08849
@@4:	jmp	L0029E+2	;@0884B
@@5:	cmp	bx, word ptr ds:[484h]	;@0884E
	jle	@@6	;@08852
	mov	word ptr ds:[484h], bx	;@08854
	mov	word ptr ds:[486h], 0	;@08858
@@6:	push	di	;@0885E
	push	bx	;@0885F
	push	ds	;@08860
	add	bx, 834h	;@08861
	push	bx	;@08865
	mov	ax, 8000h	;@08866
	push	ax	;@08869
	db	9Ah, 18h, 15h, 0DFh, 0	; lcall 0xdf, 0x1518	;@0886A
	and	ax, ax	;@0886F
	jne	@@4	;@08871
	pop	bx	;@08873
	mov	es, word ptr [bx+834h]	;@08874
	mov	cx, 4000h	;@08878
	xor	di, di	;@0887B
	mov	ax, di	;@0887D
	cld	;@0887F
	rep stosw	;@08880
	pop	di	;@08882
	jmp	@@3	;@08883
L08885:	mov	word ptr ds:[5256h], di	;@08885
	mov	word ptr ds:[5254h], bx	;@08889
	jmp	short L08899	;@0888D
L0888F:	mov	word ptr ds:[5256h], ds	;@0888F
	mov	word ptr ds:[5254h], 47Eh	;@08893
L08899:	push	ax	;@08899
	push	bx	;@0889A
	push	cx	;@0889B
L0889C:	call	L087DE	;@0889C
	push	ds	;@0889F
	lds	bx, dword ptr ds:[5254h]	;@088A0
	mov	ds, word ptr [bx]	;@088A4
	mov	bx, cx	;@088A6
	mov	cx, 8000h	;@088A8
	sub	cx, di	;@088AB
	cmp	cx, ax	;@088AD
	jb	L088D0	;@088AF
	mov	cx, ax	;@088B1
	shr	cx, 1	;@088B3
L088B5:	rep movsw	;@088B5
L088B7:	rcl	cx, 1	;@088B7
	rep movsb	;@088B9
	pop	ds	;@088BB
	mov	cx, word ptr ds:[525Ch]	;@088BC
	cmp	cx, word ptr ds:[484h]	;@088C0
	je	L088E1	;@088C4
L088C6:	cmp	cx, word ptr ds:[525Eh]	;@088C6
	jge	L088ED	;@088CA
L088CC:	pop	cx	;@088CC
	pop	bx	;@088CD
	pop	ax	;@088CE
	ret	;@088CF
L088D0:	add	bx, cx	;@088D0
	sub	ax, cx	;@088D2
	shr	cx, 1	;@088D4
	rep movsw	;@088D6
	rcl	cx, 1	;@088D8
	rep movsb	;@088DA
	pop	ds	;@088DC
	mov	cx, bx	;@088DD
	jmp	L0889C	;@088DF
L088E1:	cmp	di, word ptr ds:[486h]	;@088E1
	jb	L088C6	;@088E5
	mov	word ptr ds:[486h], di	;@088E7
	jmp	L088C6	;@088EB
L088ED:	jg	@@1	;@088ED
	cmp	di, word ptr ds:[5260h]	;@088EF
	jb	L088CC	;@088F3
	mov	word ptr ds:[5260h], di	;@088F5
	jmp	L088CC	;@088F9
@@1:	mov	word ptr ds:[525Eh], cx	;@088FB
	mov	word ptr ds:[5260h], di	;@088FF
	jmp	L088CC	;@08903
L08905:	push	ax	;@08905
	push	bx	;@08906
	push	cx	;@08907
	push	dx	;@08908
	mov	word ptr ds:[5256h], ds	;@08909
	mov	word ptr ds:[5254h], bx	;@0890D
@@1:	call	L087FD	;@08911
	push	ds	;@08914
	lds	bx, dword ptr ds:[5254h]	;@08915
	mov	ds, word ptr [bx]	;@08919
	mov	bx, 8000h	;@0891B
	sub	bx, di	;@0891E
	cmp	cx, bx	;@08920
	ja	@@3	;@08922
	shr	cx, 1	;@08924
	rep movsw	;@08926
	rcl	cx, 1	;@08928
	rep movsb	;@0892A
	pop	ds	;@0892C
	mov	cx, word ptr ds:[525Ch]	;@0892D
	cmp	cx, word ptr ds:[484h]	;@08931
	je	@@4	;@08935
@@2:	pop	dx	;@08937
	pop	cx	;@08938
	pop	bx	;@08939
	pop	ax	;@0893A
	ret	;@0893B
@@3:	push	cx	;@0893C
	mov	cx, bx	;@0893D
	shr	cx, 1	;@0893F
	rep movsw	;@08941
	rcl	cx, 1	;@08943
	rep movsb	;@08945
	pop	cx	;@08947
	pop	ds	;@08948
	add	ax, bx	;@08949
	adc	dl, dh	;@0894B
	sub	cx, bx	;@0894D
	jmp	@@1	;@0894F
@@4:	cmp	di, word ptr ds:[486h]	;@08951
	jb	@@2	;@08955
	mov	word ptr ds:[486h], di	;@08957
	jmp	@@2	;@0895B
L0895D:	push	bx	;@0895D
	push	cx	;@0895E
@@1:	call	L087FD	;@0895F
	mov	bx, 8000h	;@08962
	sub	bx, di	;@08965
	cmp	cx, bx	;@08967
	ja	@@3	;@08969
	add	ax, cx	;@0896B
	adc	dl, dh	;@0896D
	shr	cx, 1	;@0896F
	rep movsw	;@08971
	rcl	cx, 1	;@08973
	rep movsb	;@08975
	mov	cx, word ptr ds:[525Ch]	;@08977
	cmp	cx, word ptr ds:[484h]	;@0897B
	je	@@4	;@0897F
@@2:	pop	cx	;@08981
	pop	bx	;@08982
	push	cs	;@08983
	pop	es	;@08984
	ret	;@08985
@@3:	push	cx	;@08986
	mov	cx, bx	;@08987
	add	ax, cx	;@08989
	adc	dl, dh	;@0898B
	shr	cx, 1	;@0898D
	rep movsw	;@0898F
	rcl	cx, 1	;@08991
	rep movsb	;@08993
	pop	cx	;@08995
	sub	cx, bx	;@08996
	jmp	@@1	;@08998
@@4:	cmp	di, word ptr ds:[486h]	;@0899A
	jb	@@2	;@0899E
	mov	word ptr ds:[486h], di	;@089A0
	jmp	@@2	;@089A4
L089A6:	push	di	;@089A6
	push	si	;@089A7
	push	bx	;@089A8
	push	cx	;@089A9
	push	dx	;@089AA
	mov	word ptr es:[5250h], es	;@089AB
	mov	si, 927Ah	;@089B0
	mov	ax, 0FFFFh	;@089B3
	cmp	byte ptr es:[si], 0	;@089B6
	je	@@1	;@089BA
	mov	ds, word ptr cs:L00100+16	;@089BC
	mov	ah, 80h	;@089C1
	call	L08E1A	;@089C3
	mov	ax, bx	;@089C6
	mov	es, word ptr cs:L00100+16	;@089C8
	lds	bx, dword ptr es:[134h]	;@089CD
	mov	ds, word ptr [bx]	;@089D2
@@1:	pop	dx	;@089D4
	pop	cx	;@089D5
	pop	bx	;@089D6
	pop	si	;@089D7
	pop	di	;@089D8
	ret	;@089D9
L089DA:	push	di	;@089DA
	push	bx	;@089DB
	mov	di, 927Bh	;@089DC
	mov	cx, 40h	;@089DF
@@1:	lodsb	;@089E2
	or	al, al	;@089E3
	je	@@3	;@089E5
	jcxz	@@2	;@089E7
	dec	cx	;@089E9
	stosb	;@089EA
@@2:	jmp	@@1	;@089EB
@@3:	sub	cx, 40h	;@089ED
	neg	cx	;@089F0
	mov	byte ptr es:[927Ah], cl	;@089F2
	pop	bx	;@089F7
	pop	di	;@089F8
	ret	;@089F9
RESET_PASS:	push	ds	;@089FA
	mov	ds, word ptr cs:L00100+16	;@089FB
	mov	word ptr ds:[41Ah], 0	;@08A00
	mov	word ptr ds:[82Eh], 0	;@08A06
	pop	ds	;@08A0C
	ret	;@08A0D
@@1:	push	ds	;@08A0E
	mov	ds, word ptr cs:L00100+16	;@08A0F
	xor	di, di	;@08A14
	mov	es, word ptr ds:[830h]	;@08A16
	cmp	di, word ptr ds:[82Eh]	;@08A1A
	jae	@@3	;@08A1E
@@2:	scasw	;@08A20
	je	@@5	;@08A21
	loop	@@2	;@08A23
@@3:	mov	di, 2	;@08A25
	push	di	;@08A28
	mov	di, 82Ch	;@08A29
	call	POOL_ALLOC	;@08A2C
	jae	@@4	;@08A2F
	call	L054B0	;@08A31
@@4:	mov	word ptr es:[di], ax	;@08A34
@@5:	pop	ds	;@08A37
	ret	;@08A38
	push	si	;@08A39
	inc	si	;@08A3A
	inc	si	;@08A3B
	mov	ax, 0FFFEh	;@08A3C
	cmp	byte ptr [si], 0	;@08A3F
	je	@@6	;@08A42
	call	L089DA	;@08A44
	call	L089A6	;@08A47
@@6:	call	@@1	;@08A4A
	pop	si	;@08A4D
	ret	;@08A4E
	db	53h, 1Eh, 6, 2Eh, 8Eh, 6, 10h, 0, 26h, 0C5h, 1Eh, 34h, 1, 8Eh	;@08A4F
	db	1Fh, 80h, 3Ch, 0FFh, 74h, 3, 0E9h, 95h, 0, 8Ah, 44h, 1, 3Ch, 1
	db	74h, 0Fh, 3Ch, 2, 'tj<', 3, 'tk<', 4, 74h, 75h, 0E8h, 94h, 0FBh
	db	26h, 80h, 3Eh, 19h, 0, 1, 'u(&', 80h, '>wR', 1, 74h, 1Eh, 26h
	db	0C6h, 6, 77h, 52h, 1, 56h, 33h, 0C0h, 50h, 0B8h, 3Ch, 0, 50h, 0E8h
	db	0Eh, 31h, 2Eh, 8Eh, 6, 10h, 0, 26h, 0C5h, 1Eh, 34h, 1, 8Eh, 1Fh
	db	5Eh, 0EBh, 48h, 32h, 0E4h, 26h, 0A3h, 1Ah, 4, 26h, 0C6h, 6, 88h
	db	4, 1, 26h, 83h, 3Eh, 30h, 8, 0FFh, 75h, 16h, 6, 1Fh, 56h, 0BFh
	db	2Ch, 8, 0E8h, 0Dh, 0CBh, 5Eh, 2Eh, 8Eh, 6, 10h, 0, 26h, 0C5h, 1Eh
	db	34h, 1, 8Eh, 1Fh, 0E8h, 60h, 0FFh, 0EBh, 19h, 0E8h, 1Ch, 0FFh
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
L08D0E:	mov	dx, word ptr es:[di+0Ch]	;@08D0E
	push	si	;@08D12
	mov	si, 734h	;@08D13
	push	si	;@08D16
	mov	si, word ptr [si+2]	;@08D17
	sub	si, 18h	;@08D1A
@@1:	mov	bl, byte ptr es:[di+10h]	;@08D1D
	mov	bh, 0	;@08D21
	add	di, word ptr cs:[bx+5750h]	;@08D23
	cmp	di, si	;@08D28
	jae	@@4	;@08D2A
@@2:	cmp	dx, word ptr es:[di+0Ch]	;@08D2C
	jae	@@5	;@08D30
	cmp	word ptr es:[di+0Ah], 2	;@08D32
	jb	@@1	;@08D37
	add	sp, 2	;@08D39
	pop	si	;@08D3C
	mov	word ptr ds:[3E2h], di	;@08D3D
	mov	ax, word ptr es:[di+0Ch]	;@08D41
	mul	word ptr ds:[5262h]	;@08D45
	cmp	dx, word ptr ds:[526Eh]	;@08D49
	ja	@@7	;@08D4D
	jb	@@3	;@08D4F
	cmp	ax, word ptr ds:[526Ch]	;@08D51
	jae	@@7	;@08D55
@@3:	mov	si, 1250h	;@08D57
	sub	ax, word ptr ds:[5268h]	;@08D5A
	add	si, ax	;@08D5E
	jmp	L057DA	;@08D60
@@4:	pop	si	;@08D63
	cmp	si, 744h	;@08D64
	ja	@@6	;@08D68
	and	di, 3	;@08D6A
	add	si, 8	;@08D6D
	push	si	;@08D70
	push	di	;@08D71
	and	di, 3	;@08D72
	shl	di, 1	;@08D75
	shl	di, 1	;@08D77
	shl	di, 1	;@08D79
	mov	es, word ptr [di+738h]	;@08D7B
	pop	di	;@08D7F
	jmp	@@2	;@08D80
@@5:	add	sp, 2	;@08D82
@@6:	mov	word ptr ds:[3E2h], di	;@08D85
	pop	si	;@08D89
	ret	;@08D8A
@@7:	mov	cx, ax	;@08D8B
	and	ax, 0FC00h	;@08D8D
	xor	cx, ax	;@08D90
	push	cx	;@08D92
	mov	cx, dx	;@08D93
	xchg	ax, dx	;@08D95
	mov	bx, word ptr ds:[26h]	;@08D96
	mov	ax, 4200h	;@08D9A
	call	DOS_CALL	;@08D9D
	mov	word ptr ds:[5268h], ax	;@08DA0
	mov	word ptr ds:[526Ah], dx	;@08DA3
	mov	word ptr ds:[526Ch], ax	;@08DA7
	mov	word ptr ds:[526Eh], dx	;@08DAA
	mov	cx, 4000h	;@08DAE
	cmp	byte ptr ds:[161h], 0	;@08DB1
	je	@@8	;@08DB6
	sub	ax, word ptr ds:[5264h]	;@08DB8
	sbb	dx, word ptr ds:[5266h]	;@08DBC
	not	dx	;@08DC0
	neg	ax	;@08DC2
	sbb	dx, -1	;@08DC4
	jne	@@8	;@08DC7
	cmp	ax, cx	;@08DC9
	ja	@@8	;@08DCB
	xchg	ax, cx	;@08DCD
@@8:	mov	ah, 3Fh	;@08DCE
	mov	bx, word ptr ds:[26h]	;@08DD0
	mov	dx, 1250h	;@08DD4
	call	DOS_CALL	;@08DD7
	add	word ptr ds:[526Ch], ax	;@08DDA
	adc	word ptr ds:[526Eh], 0	;@08DDE
	add	ax, 1250h	;@08DE3
	mov	word ptr ds:[5258h], ax	;@08DE6
	pop	si	;@08DE9
	add	si, 1250h	;@08DEA
	jmp	L057DA	;@08DEE
	db	8Bh, 36h, 2Ah, 5, 0E8h, 0B5h, 8, 0C3h, 56h, 83h, 0E6h, 3, 0D1h	;@08DF1
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 38h, 7, 5Eh, 26h, 8Bh
	db	34h, 0E8h, 9Fh, 8, 0C3h
	db	0E8h, 74h, 7	; call PUT_NEWLINE	;@08E0F
	db	0E8h, 22h, 9	; call L09737	;@08E12
	ret	;@08E15
L08E16:	mov	word ptr ds:[5250h], ds	;@08E16
L08E1A:	push	bp	;@08E1A
	push	dx	;@08E1B
	push	di	;@08E1C
	mov	dl, byte ptr ds:[122h]	;@08E1D
	push	ds	;@08E21
	pop	es	;@08E22
	mov	di, 927Ah	;@08E23
	mov	ds, word ptr ds:[5250h]	;@08E26
	cld	;@08E2A
	lodsb	;@08E2B
	and	al, 3Fh	;@08E2C
	mov	bx, ax	;@08E2E
	or	ah, al	;@08E30
	mov	byte ptr es:[di], ah	;@08E32
	inc	di	;@08E35
	mov	ah, 0	;@08E36
	mov	cx, ax	;@08E38
	jcxz	@@5	;@08E3A
	push	cx	;@08E3C
	or	dl, dl	;@08E3D
	jne	@@3	;@08E3F
@@1:	lodsb	;@08E41
	cmp	al, 61h	;@08E42
	jb	@@2	;@08E44
	cmp	al, 7Ah	;@08E46
	ja	@@2	;@08E48
	sub	al, 20h	;@08E4A
@@2:	stosb	;@08E4C
	xor	bl, al	;@08E4D
	rol	bx, 1	;@08E4F
	loop	@@1	;@08E51
	jmp	short @@4	;@08E53
@@3:	lodsb	;@08E55
	stosb	;@08E56
	xor	bl, al	;@08E57
	rol	bx, 1	;@08E59
	dec	cx	;@08E5B
	je	@@4	;@08E5C
	lodsb	;@08E5E
	stosb	;@08E5F
	xor	bl, al	;@08E60
	rol	bx, 1	;@08E62
	loop	@@3	;@08E64
@@4:	pop	ax	;@08E66
@@5:	push	si	;@08E67
	inc	ax	;@08E68
	push	es	;@08E69
	pop	ds	;@08E6A
	xor	bl, bh	;@08E6B
	mov	si, 927Ah	;@08E6D
	and	bx, 3FFEh	;@08E70
	mov	word ptr ds:[5252h], bx	;@08E74
	add	bx, 527Ah	;@08E78
	mov	dx, ds	;@08E7C
	mov	di, word ptr [bx]	;@08E7E
	cmp	di, -1	;@08E80
	je	@@10	;@08E83
	mov	dx, si	;@08E85
@@6:	mov	bp, di	;@08E87
	mov	cx, ax	;@08E89
	push	di	;@08E8B
	and	di, 3	;@08E8C
	shl	di, 1	;@08E8F
	shl	di, 1	;@08E91
	shl	di, 1	;@08E93
	mov	es, word ptr [di+718h]	;@08E95
	pop	di	;@08E99
	inc	di	;@08E9A
	inc	di	;@08E9B
	repe cmpsb	;@08E9C
	jne	@@9	;@08E9E
@@7:	mov	bx, bp	;@08EA0
	pop	si	;@08EA2
	pop	di	;@08EA3
	pop	dx	;@08EA4
	pop	bp	;@08EA5
	clc	;@08EA6
	ret	;@08EA7
@@8:	pop	si	;@08EA8
	pop	di	;@08EA9
	pop	dx	;@08EAA
	pop	bp	;@08EAB
	stc	;@08EAC
	ret	;@08EAD
@@9:	mov	si, dx	;@08EAE
	lea	bx, [bp-2]	;@08EB0
	mov	di, word ptr es:[bx]	;@08EB3
	cmp	di, -1	;@08EB6
	jne	@@6	;@08EB9
	xor	dx, dx	;@08EBB
@@10:	cmp	byte ptr ds:[5276h], 2	;@08EBD
	je	@@8	;@08EC2
	mov	cx, ax	;@08EC4
	add	ax, 7	;@08EC6
	and	al, 0FCh	;@08EC9
	cmp	byte ptr ds:[16h], 0	;@08ECB
	je	@@11	;@08ED0
	add	ax, 4	;@08ED2
@@11:	push	bx	;@08ED5
	mov	bx, word ptr ds:[71Ah]	;@08ED6
	les	di, dword ptr [bx+2]	;@08EDA
	add	di, ax	;@08EDD
	cmp	di, word ptr [bx]	;@08EDF
	ja	@@15	;@08EE1
	xchg	word ptr [bx+2], di	;@08EE3
	pop	bx	;@08EE6
@@12:	xor	ax, ax	;@08EE7
	cmp	byte ptr ds:[16h], 0	;@08EE9
	je	@@13	;@08EEE
	stosw	;@08EF0
	stosw	;@08EF1
@@13:	dec	ax	;@08EF2
	stosw	;@08EF3
	push	di	;@08EF4
	stosw	;@08EF5
	shr	cx, 1	;@08EF6
	rep movsw	;@08EF8
	rcl	cx, 1	;@08EFA
	rep movsb	;@08EFC
	pop	di	;@08EFE
	push	ds	;@08EFF
	and	dx, dx	;@08F00
	jne	@@14	;@08F02
	inc	bx	;@08F04
	inc	bx	;@08F05
	push	bx	;@08F06
	and	bx, 3	;@08F07
	shl	bx, 1	;@08F0A
	shl	bx, 1	;@08F0C
	shl	bx, 1	;@08F0E
	mov	ds, word ptr [bx+718h]	;@08F10
	pop	bx	;@08F14
	dec	bx	;@08F15
	dec	bx	;@08F16
@@14:	mov	word ptr [bx], di	;@08F17
	mov	bp, di	;@08F19
	pop	ds	;@08F1B
	jmp	@@7	;@08F1C
@@15:	call	L054E9	;@08F1E
	pop	bx	;@08F21
	jae	@@12	;@08F22
L08F24:	call	L054B0	;@08F24
FIND_NAME:	call	L08E1A	;@08F27
	cmp	word ptr es:[bx], -1	;@08F2A
	jne	@@2	;@08F2E
@@1:	stc	;@08F30
	ret	;@08F31
@@2:	mov	bx, word ptr es:[bx]	;@08F32
	push	bx	;@08F35
	and	bx, 3	;@08F36
	shl	bx, 1	;@08F39
	shl	bx, 1	;@08F3B
	shl	bx, 1	;@08F3D
	mov	es, word ptr [bx+758h]	;@08F3F
	pop	bx	;@08F43
	test	byte ptr es:[bx+0Eh], 1	;@08F44
	jne	@@3	;@08F49
	push	bx	;@08F4B
	mov	bx, word ptr es:[bx]	;@08F4C
	mov	es, word ptr ds:[778h]	;@08F4F
	cmp	byte ptr es:[bx+9], 0FFh	;@08F53
	pop	bx	;@08F58
	je	@@1	;@08F59
@@3:	clc	;@08F5B
	ret	;@08F5C
SORT:	cmp	cx, 2	;@08F5D
	ja	@@1	;@08F60
	ret	;@08F62
@@1:	mov	dx, cx	;@08F63
	shr	dx, 1	;@08F65
	and	dx, -2	;@08F67
@@2:	mov	ax, dx	;@08F6A
	mov	bx, ax	;@08F6C
@@3:	shl	bx, 1	;@08F6E
	cmp	bx, cx	;@08F70
	ja	@@5	;@08F72
	mov	si, word ptr es:[bx-2]	;@08F74
	je	@@4	;@08F78
	mov	di, word ptr es:[bx]	;@08F7A
	call	bp	;@08F7D
	jae	@@4	;@08F7F
	add	bx, 2	;@08F81
	mov	si, di	;@08F84
@@4:	mov	di, si	;@08F86
	mov	si, ax	;@08F88
	mov	si, word ptr es:[si-2]	;@08F8A
	call	bp	;@08F8E
	jae	@@5	;@08F90
	mov	word ptr es:[bx-2], si	;@08F92
	mov	si, ax	;@08F96
	mov	word ptr es:[si-2], di	;@08F98
	mov	ax, bx	;@08F9C
	jmp	@@3	;@08F9E
@@5:	sub	dx, 2	;@08FA0
	jne	@@2	;@08FA3
	mov	dx, cx	;@08FA5
	sub	dx, 2	;@08FA7
@@6:	sub	bx, bx	;@08FAA
	mov	ax, word ptr es:[bx]	;@08FAC
	mov	di, dx	;@08FAF
	push	word ptr es:[di]	;@08FB1
	mov	word ptr es:[di], ax	;@08FB4
	sub	dx, 2	;@08FB7
@@7:	mov	ax, bx	;@08FBA
	inc	bx	;@08FBC
	shl	bx, 1	;@08FBD
	cmp	bx, dx	;@08FBF
	ja	@@9	;@08FC1
	mov	si, word ptr es:[bx]	;@08FC3
	je	@@8	;@08FC6
	mov	di, word ptr es:[bx+2]	;@08FC8
	call	bp	;@08FCC
	jae	@@8	;@08FCE
	mov	si, di	;@08FD0
	add	bx, 2	;@08FD2
@@8:	mov	di, ax	;@08FD5
	mov	word ptr es:[di], si	;@08FD7
	jmp	@@7	;@08FDA
@@9:	pop	di	;@08FDC
@@10:	or	ax, ax	;@08FDD
	je	@@11	;@08FDF
	mov	bx, ax	;@08FE1
	shr	bx, 1	;@08FE3
	dec	bx	;@08FE5
	and	bx, -2	;@08FE6
	mov	si, word ptr es:[bx]	;@08FE9
	call	bp	;@08FEC
	jae	@@11	;@08FEE
	xchg	ax, bx	;@08FF0
	mov	word ptr es:[bx], si	;@08FF1
	jmp	@@10	;@08FF4
@@11:	mov	bx, ax	;@08FF6
	mov	word ptr es:[bx], di	;@08FF8
	or	dx, dx	;@08FFB
	jne	@@6	;@08FFD
	ret	;@08FFF
@@12:	cmp	ax, 0Ah	;@09000
	jb	@@13	;@09003
	push	dx	;@09005
	push	bx	;@09006
	mov	bx, 0Ah	;@09007
	sub	dx, dx	;@0900A
	div	bx	;@0900C
	pop	bx	;@0900E
	dec	cx	;@0900F
	call	@@12	;@09010
	mov	ax, dx	;@09013
	pop	dx	;@09015
	jmp	short @@15	;@09016
@@13:	push	ax	;@09018
	mov	al, 20h	;@09019
@@14:	mov	al, 20h	;@0901B
	call	L0950F	;@0901D
	loop	@@14	;@09020
	pop	ax	;@09022
@@15:	add	al, 30h	;@09023
	call	L0950F	;@09025
	ret	;@09028
L09029:	mov	dh, 0Fh	;@09029
	and	dl, dh	;@0902B
	and	dh, al	;@0902D
	xor	al, dh	;@0902F
	or	al, dl	;@09031
	mov	cl, 4	;@09033
	ror	ax, cl	;@09035
	add	ax, bx	;@09037
	db	0E8h, 34h, 5	; call PUT_HEX_WORD	;@09039
	mov	al, dh	;@0903C
	db	0E8h, 0ECh, 4	; call L0952D	;@0903E
	db	0E8h, 9Ch, 5	; call PUT_INLINE	;@09041
	add	cl, byte ptr [bx+si+20h]	;@09044
	ret	;@09047
L09048:	push	cx	;@09048
	db	0E8h, 61h, 6	; call PUT_PLAIN_NAME	;@09049
	mov	al, 20h	;@0904C
	sub	cx, word ptr ds:[0B443h]	;@0904E
	jbe	@@2	;@09052
@@1:	call	L0950F	;@09054
	loop	@@1	;@09057
@@2:	call	L0950F	;@09059
	pop	cx	;@0905C
	ret	;@0905D
L0905E:	push	ds	;@0905E
	mov	ds, word ptr cs:L00100+16	;@0905F
	cmp	byte ptr ds:[152h], 0	;@09064
	pop	ds	;@09069
	je	@@2	;@0906A
	push	ds	;@0906C
	mov	dx, word ptr ds:[134h]	;@0906D
	cmp	dx, -1	;@09071
	je	@@1	;@09074
	mov	dx, word ptr ds:[13Ah]	;@09076
	lds	bx, dword ptr ds:[134h]	;@0907A
	mov	ds, word ptr [bx]	;@0907E
	add	dx, 2	;@09080
	mov	ah, 41h	;@09083
	int	21h	;@09085
@@1:	pop	ds	;@09087
@@2:	ret	;@09088
	db	8Bh, 3Eh, 3Ah, 1, 0C4h, 1Eh, 34h, 1, 26h, 8Eh, 7, 83h, 0C7h, 2	;@09089
	db	32h, 0C0h, 0B9h, 64h, 0, 0F2h, 0AEh, 26h, 81h, 7Dh, 0FCh, 'cou'
	db	5, 26h, 80h, 7Dh, 0FEh, 6Dh, 0C3h, 50h, 81h, 0EBh, 1, 40h, 0D1h
	db	0E3h, 3, 1Eh, 2Eh, 5, 8Eh, 6, 88h, 7, 26h, 8Bh, 1Fh, 53h, 83h
	db	0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 58h, 7
	db	'[S&', 8Bh, 5Fh, 0Ah, 8Eh, 6, 0A8h, 7, 0A1h, 86h, 1, 0EBh, 9, '&;G'
	db	2, 74h, 0Ch, 26h, 8Bh, 1Fh, 83h, 0FBh, 0FFh, 75h, 0F2h, 0F9h, 5Bh
	db	0EBh, 4, 0F8h, 83h, 0C4h, 2, 58h, 0C3h, 56h, 8Eh, 6, 0A0h, 7, 26h
	db	8Bh, 44h, 6, 80h, 3Eh, 19h, 0, 0, 75h, 1Eh, 26h, 80h, 7Ch, 1, 3
	db	7Ch, 13h, 26h, 8Bh, 74h, 4, 8Eh, 6, 80h, 7, 26h, 8Bh, 74h, 4, 26h
	db	8Bh, 34h, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 44h, 8, 5Eh, 0C3h
L09123:	push	di	;@09123
	cmp	byte ptr ds:[19h], 0	;@09124
	je	@@1	;@09129
	test	byte ptr es:[di+0Eh], 20h	;@0912B
	jne	@@5	;@09130
@@1:	mov	di, word ptr es:[di+2]	;@09132
	cmp	di, -1	;@09136
	je	@@3	;@09139
	push	di	;@0913B
	and	di, 3	;@0913C
	shl	di, 1	;@0913F
	shl	di, 1	;@09141
	shl	di, 1	;@09143
	mov	es, word ptr [di+738h]	;@09145
	pop	di	;@09149
	cmp	word ptr es:[di+0Ah], 2	;@0914A
	jb	@@3	;@0914F
@@2:	stc	;@09151
	jmp	short @@4	;@09152
@@3:	clc	;@09154
@@4:	pop	di	;@09155
	lahf	;@09156
	push	di	;@09157
	and	di, 3	;@09158
	shl	di, 1	;@0915B
	shl	di, 1	;@0915D
	shl	di, 1	;@0915F
	mov	es, word ptr [di+758h]	;@09161
	pop	di	;@09165
	sahf	;@09166
	ret	;@09167
@@5:	mov	di, word ptr es:[di+2]	;@09168
	mov	es, word ptr ds:[808h]	;@0916C
	cmp	word ptr es:[di+6], 0	;@09170
	jne	@@2	;@09175
	jmp	@@3	;@09177
L09179:	mov	word ptr ds:[525Ah], 0	;@09179
	mov	cx, word ptr ds:[5272h]	;@0917F
	jcxz	@@2	;@09183
	mov	si, word ptr ds:[5274h]	;@09185
@@1:	mov	bx, word ptr [si]	;@09189
	and	bx, bx	;@0918B
	jne	@@3	;@0918D
	add	si, 0Ah	;@0918F
	loop	@@1	;@09192
@@2:	stc	;@09194
	ret	;@09195
@@3:	mov	word ptr [si], 0	;@09196
	push	dx	;@0919A
	call	CLOSE_FILE	;@0919B
	pop	dx	;@0919E
	clc	;@0919F
	ret	;@091A0
	db	33h, 0D2h, 33h, 0C0h, 0B9h, 0Ah, 0, 0BEh, 38h, 1, 0E8h, 39h, 0	;@091A1
	db	0BEh, 3Eh, 1, 0E8h, 33h, 0, 89h, '6pR', 89h, 16h, 72h, 52h, 5
	db	40h, 1, 50h, 0E8h, 42h, 0, 59h, 89h, '>tR3', 0C0h, 0D1h, 0E9h
	db	0F3h, 0ABh, 0B8h, 0, 2, 0E8h, 31h, 0, 89h, 3Eh, 80h, 1, 81h, 0C7h
	db	0, 2, 89h, 3Eh, 7Eh, 1, 0C7h, 6, 7Ch, 1, 20h, 0, 0C3h, 1Eh, 2Eh
	db	8Eh, 6, 10h, 0, 0C5h, 1Eh, 34h, 1, 8Eh, 1Fh, 26h, 8Bh, 1Ch, 1Eh
	db	7, 23h, 0DBh, 74h, 7, 3, 0C1h, 42h, 8Bh, 0F3h, 0EBh, 0F0h, 1Fh
	db	0C3h
L09205:	mov	di, word ptr ds:[0Eh]	;@09205
	add	ax, di	;@09209
	mov	word ptr ds:[0Eh], ax	;@0920B
	cmp	ax, word ptr ds:[10h]	;@0920E
	jae	@@1	;@09212
	push	ds	;@09214
	pop	es	;@09215
	ret	;@09216
@@1:	jmp	L0029E+2	;@09217
GET_SWITCH_CHAR:	push	dx	;@0921A
	mov	ax, 3700h	;@0921B
	int	21h	;@0921E
	mov	al, dl	;@09220
	pop	dx	;@09222
	ret	;@09223
L09224:	push	bx	;@09224
	push	ds	;@09225
	mov	ah, 0	;@09226
	cmp	si, word ptr ds:[42Ch]	;@09228
	jne	@@1	;@0922C
	inc	ah	;@0922E
@@1:	and	al, 1Ch	;@09230
	cmp	al, 14h	;@09232
	jne	@@2	;@09234
	inc	ah	;@09236
@@2:	mov	al, 0FFh	;@09238
	dec	ah	;@0923A
	jg	@@5	;@0923C
	mov	al, 2	;@0923E
	cmp	si, word ptr ds:[452h]	;@09240
	je	@@5	;@09244
	mov	al, 0	;@09246
	cmp	si, -1	;@09248
	je	@@5	;@0924B
	cmp	byte ptr ds:[488h], 0	;@0924D
	je	@@3	;@09252
	mov	al, 4	;@09254
	cmp	si, word ptr ds:[450h]	;@09256
	je	@@5	;@0925A
	mov	al, 3	;@0925C
	cmp	si, word ptr ds:[44Eh]	;@0925E
	je	@@5	;@09262
@@3:	mov	al, 0FDh	;@09264
	cmp	si, word ptr ds:[436h]	;@09266
	je	@@5	;@0926A
	mov	al, 1	;@0926C
	push	si	;@0926E
	and	si, 3	;@0926F
	shl	si, 1	;@09272
	shl	si, 1	;@09274
	shl	si, 1	;@09276
	mov	ds, word ptr [si+718h]	;@09278
	pop	si	;@0927C
	mov	bl, byte ptr [si+2]	;@0927D
	and	bx, 3Fh	;@09280
	cmp	bl, 4	;@09283
	jb	@@4	;@09286
	cmp	word ptr [bx+si+1], 4544h	;@09288
	jne	@@4	;@0928D
	cmp	word ptr [bx+si-1], 4F43h	;@0928F
	je	@@5	;@09294
@@4:	mov	al, 0	;@09296
@@5:	cbw	;@09298
	pop	ds	;@09299
	pop	bx	;@0929A
	ret	;@0929B
L0929C:	push	si	;@0929C
	mov	al, byte ptr es:[si+9]	;@0929D
	mov	si, word ptr es:[si+2]	;@092A1
	call	L09224	;@092A5
	pop	si	;@092A8
	mov	es, word ptr ds:[778h]	;@092A9
	ret	;@092AD
PSTRING_TO_ASCIZ:	push	bp	;@092AE
	mov	bp, sp	;@092AF
	push	ds	;@092B1
	push	es	;@092B2
	push	si	;@092B3
	push	di	;@092B4
	push	ax	;@092B5
	push	cx	;@092B6
	les	di, dword ptr [bp+8]	;@092B7
	lds	si, dword ptr [bp+4]	;@092BA
	lodsb	;@092BD
	mov	cl, al	;@092BE
	and	cx, 3Fh	;@092C0
	rep movsb	;@092C3
	xor	ax, ax	;@092C5
	stosb	;@092C7
	pop	cx	;@092C8
	pop	ax	;@092C9
	pop	di	;@092CA
	pop	si	;@092CB
	pop	es	;@092CC
	pop	ds	;@092CD
	mov	sp, bp	;@092CE
	pop	bp	;@092D0
	ret	8	;@092D1
L092D4:	push	bx	;@092D4
	mov	bx, word ptr ds:[22h]	;@092D5
	call	CLOSE_FILE	;@092D9
	mov	bx, word ptr ds:[24h]	;@092DC
	call	CLOSE_FILE	;@092E0
	pop	bx	;@092E3
	ret	;@092E4
L092E5:	push	ds	;@092E5
	mov	dx, word ptr ds:[13Ah]	;@092E6
	cmp	dx, 0	;@092EA
	je	@@1	;@092ED
	lds	bx, dword ptr ds:[134h]	;@092EF
	mov	ds, word ptr [bx]	;@092F3
	add	dx, 2	;@092F5
	push	ds	;@092F8
	push	dx	;@092F9
	call	@@2	;@092FA
@@1:	mov	ax, 2	;@092FD
	push	ax	;@09300
	call	@@3	;@09301
	pop	ds	;@09304
	ret	;@09305
@@2:	push	bp	;@09306
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
@@3:	push	bp	;@09318
	mov	bp, sp	;@09319
	call	L0012E	;@0931B
	mov	ax, word ptr [bp+4]	;@0931E
	mov	ah, 4Ch	;@09321
	int	21h	;@09323
	pop	bp	;@09325
	ret	2	;@09326
L09329:	push	ax	;@09329
	mov	ax, 2	;@0932A
	push	ax	;@0932D
	mov	ax, 1Eh	;@0932E
	push	ax	;@09331
	db	0E8h, 6Ch, 28h	; call FATAL	;@09332
L09335:	cmp	byte ptr ds:[11Fh], 1	;@09335
	jne	@@1	;@0933A
	push	di	;@0933C
	push	ax	;@0933D
	push	bx	;@0933E
	les	bx, dword ptr ds:[134h]	;@0933F
	mov	es, word ptr es:[bx]	;@09343
	mov	di, word ptr ds:[13Ah]	;@09346
	add	di, 2	;@0934A
	xor	al, al	;@0934D
	mov	cx, 64h	;@0934F
	repne scasb	;@09352
	pop	bx	;@09354
	pop	ax	;@09355
	mov	word ptr es:[di-4], ax	;@09356
	mov	byte ptr es:[di-2], bl	;@0935A
	pop	di	;@0935E
@@1:	ret	;@0935F
FIND_ENV_STRING:	push	bp	;@09360
	mov	bp, sp	;@09361
	push	ds	;@09363
	les	di, dword ptr [bp+4]	;@09364
@@1:	cmp	byte ptr es:[di], 0	;@09367
	je	@@2	;@0936B
	lds	si, dword ptr [bp+8]	;@0936D
	mov	cx, word ptr [bp+0Ch]	;@09370
	repe cmpsb	;@09373
	je	@@3	;@09375
	xor	ax, ax	;@09377
	mov	cx, 0FFFFh	;@09379
	repne scasb	;@0937C
	je	@@1	;@0937E
@@2:	xor	ax, ax	;@09380
	mov	dx, ax	;@09382
	jmp	short @@4	;@09384
@@3:	mov	dx, es	;@09386
	mov	ax, di	;@09388
@@4:	pop	ds	;@0938A
	mov	sp, bp	;@0938B
	pop	bp	;@0938D
	ret	0Ah	;@0938E
L09391:	push	es	;@09391
	push	cx	;@09392
	push	di	;@09393
	mov	di, 1A7h	;@09394
	mov	es, di	;@09397
	mov	di, word ptr es:[0]	;@09399
	mov	es, di	;@0939E
	xor	di, di	;@093A0
@@1:	xor	ax, ax	;@093A2
	mov	cx, 0FFFFh	;@093A4
	repne scasb	;@093A7
	je	@@2	;@093A9
	stc	;@093AB
	jmp	short @@3	;@093AC
@@2:	cmp	byte ptr es:[di], 0	;@093AE
	jne	@@1	;@093B2
	add	di, 3	;@093B4
	mov	dx, es	;@093B7
	mov	ax, di	;@093B9
	clc	;@093BB
@@3:	pop	di	;@093BC
	pop	cx	;@093BD
	pop	es	;@093BE
	ret	;@093BF
TRY_PATHS:	push	bp	;@093C0
	mov	bp, sp	;@093C1
	sub	sp, 4	;@093C3
	push	ds	;@093C6
	push	si	;@093C7
	lds	si, dword ptr [bp+0Eh]	;@093C8
	mov	byte ptr [bp-2], 0	;@093CB
@@1:	mov	cx, word ptr [bp+4]	;@093CF
	dec	cx	;@093D2
	les	di, dword ptr [bp+6]	;@093D3
	lodsb	;@093D6
	or	al, al	;@093D7
	jne	@@3	;@093D9
	jmp	short @@7	;@093DB
@@2:	lodsb	;@093DD
	or	al, al	;@093DE
	jne	@@3	;@093E0
	mov	byte ptr [bp-2], 1	;@093E2
	jmp	short @@4	;@093E6
@@3:	cmp	al, 3Bh	;@093E8
	je	@@4	;@093EA
	stosb	;@093EC
	loop	@@2	;@093ED
	jmp	short @@7	;@093EF
@@4:	mov	word ptr [bp+0Eh], si	;@093F1
	mov	al, 5Ch	;@093F4
	stosb	;@093F6
	lds	si, dword ptr [bp+0Ah]	;@093F7
@@5:	lodsb	;@093FA
	or	al, al	;@093FB
	je	@@6	;@093FD
	stosb	;@093FF
	loop	@@5	;@09400
	jmp	short @@7	;@09402
@@6:	xor	al, al	;@09404
	stosb	;@09406
	push	word ptr [bp+8]	;@09407
	push	word ptr [bp+6]	;@0940A
	call	SEARCH_FILE	;@0940D
	jae	@@8	;@09410
	lds	si, dword ptr [bp+0Eh]	;@09412
	jmp	@@1	;@09415
@@7:	stc	;@09417
@@8:	mov	dx, word ptr [bp+8]	;@09418
	mov	ax, word ptr [bp+6]	;@0941B
	pop	si	;@0941E
	pop	ds	;@0941F
	mov	sp, bp	;@09420
	pop	bp	;@09422
	ret	0Eh	;@09423
SEARCH_FILE:	push	bp	;@09426
	mov	bp, sp	;@09427
	sub	sp, 2Fh	;@09429
	push	ds	;@0942C
	mov	ah, 2Fh	;@0942D
	int	21h	;@0942F
	mov	word ptr [bp-2], es	;@09431
	mov	word ptr [bp-4], bx	;@09434
	mov	ah, 1Ah	;@09437
	push	ss	;@09439
	pop	ds	;@0943A
	lea	dx, [bp-2Fh]	;@0943B
	int	21h	;@0943E
	mov	ah, 4Eh	;@09440
	xor	cx, cx	;@09442
	lds	dx, dword ptr [bp+4]	;@09444
	int	21h	;@09447
	pushf	;@09449
	mov	ds, word ptr [bp-2]	;@0944A
	mov	dx, word ptr [bp-4]	;@0944D
	mov	ah, 1Ah	;@09450
	int	21h	;@09452
	popf	;@09454
	pop	ds	;@09455
	mov	sp, bp	;@09456
	pop	bp	;@09458
	ret	4	;@09459
	db	80h, 3Eh, 19h, 0, 0, 75h, 1Ah, 0C7h, 6, 0D1h, 6, 4, 0, 0C7h, 6	;@0945C
	db	0FAh, 3, 0Fh, 0, 0EBh, 2Bh, 33h, 0C0h, 50h, 0B8h, 2Dh, 0, 50h
	db	0E8h, 2Bh, 27h, 0EBh, 1Fh, 8Bh, 0Eh, 46h, 1, 0E3h, 0EEh, 33h, 0DBh
	db	43h, 0D1h, 0E9h, 75h, 0FBh, 4Bh, 89h, 1Eh, 0D1h, 6, 8Bh, 0CBh
	db	0B8h, 1, 0, 0D1h, 0E0h, 0E2h, 0FCh, 48h, 0A3h, 0FAh, 3, 0C3h
L0949D:	push	ax	;@0949D
	push	bx	;@0949E
	push	dx	;@0949F
	mov	bx, 200h	;@094A0
	div	bx	;@094A3
	mov	word ptr ds:[49Eh], dx	;@094A5
	neg	dx	;@094A9
	adc	ax, 0	;@094AB
	mov	word ptr ds:[4A0h], ax	;@094AE
	pop	dx	;@094B1
	pop	bx	;@094B2
	pop	ax	;@094B3
	ret	;@094B4
	db	0Bh dup (0)	;@094B5
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
	call	DOS_CALL	;@094E1
@@2:	cmp	byte ptr ds:[0B445h], 1	;@094E4
	jne	@@3	;@094E9
	mov	ah, 40h	;@094EB
	mov	bx, 1	;@094ED
	call	DOS_CALL	;@094F0
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
HEX_DIGITS:	xor	byte ptr [bx+di], dh	;@0951D
	xor	dh, byte ptr [bp+di]	;@0951F
	xor	al, 35h	;@09521
	db	36h, 37h	; aaa	;@09523
	db	38h, 39h	; cmp byte ptr [bx+di], bh	;@09525
	inc	cx	;@09527
	inc	dx	;@09528
	inc	bx	;@09529
	inc	sp	;@0952A
	inc	bp	;@0952B
	inc	si	;@0952C
L0952D:	push	bx	;@0952D
	mov	bx, 951Dh	;@0952E
	and	al, 0Fh	;@09531
	xlat	byte ptr cs:[bx]	;@09533
	mov	byte ptr [di], al	;@09535
	inc	di	;@09537
	pop	bx	;@09538
	cmp	di, 0B340h	;@09539
	jae	@@1	;@0953D
	ret	;@0953F
@@1:	call	L094C0	;@09540
	ret	;@09543
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
PUT_HEX_WORD:	push	ax	;@09570
	mov	al, ah	;@09571
	call	L09562	;@09573
	pop	ax	;@09576
	call	L09562	;@09577
	ret	;@0957A
HEX_WORD:	push	ax	;@0957B
	mov	al, ah	;@0957C
	call	L09544	;@0957E
	pop	ax	;@09581
	call	L09544	;@09582
	ret	;@09585
PUT_NEWLINE:	mov	al, 0Dh	;@09586
	call	L0950F	;@09588
	mov	al, 0Ah	;@0958B
	jmp	L0950F	;@0958D
PUT_PSTRING:	push	ax	;@0958F
	push	cx	;@09590
	mov	cx, 0FFh	;@09591
PUT_PSTRING_MASKED:	push	es	;@09594
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
PUT_NAME_STRING:	push	ax	;@095B5
	push	cx	;@095B6
	mov	cx, 3Fh	;@095B7
	jmp	PUT_PSTRING_MASKED	;@095BA
	push	ds	;@095BC
	push	es	;@095BD
	mov	es, word ptr cs:L00100+16	;@095BE
	cld	;@095C3
	jmp	short @@2	;@095C4
@@1:	stosb	;@095C6
@@2:	lodsb	;@095C7
	cmp	al, 0	;@095C8
	jne	@@1	;@095CA
	pop	es	;@095CC
	pop	ds	;@095CD
	cmp	di, 0B340h	;@095CE
	jae	@@3	;@095D2
	ret	;@095D4
@@3:	push	ds	;@095D5
	mov	ds, word ptr cs:L00100+16	;@095D6
	call	L094C0	;@095DB
	pop	ds	;@095DE
	ret	;@095DF
PUT_INLINE:	pop	si	;@095E0
	push	cs	;@095E1
	pop	es	;@095E2
	call	PUT_PSTRING	;@095E3
	jmp	si	;@095E6
L095E8:	push	es	;@095E8
	pop	ds	;@095E9
	mov	es, word ptr cs:L00100+16	;@095EA
	inc	si	;@095EF
	inc	si	;@095F0
	push	di	;@095F1
	mov	di, 0B401h	;@095F2
	cld	;@095F5
	lodsb	;@095F6
	and	ax, 3Fh	;@095F7
	stosb	;@095FA
	xchg	ax, cx	;@095FB
	rep movsb	;@095FC
	mov	al, 0	;@095FE
	stosb	;@09600
	push	es	;@09601
	pop	ds	;@09602
	mov	si, 0B401h	;@09603
	cmp	byte ptr ds:[122h], 0	;@09606
	jne	@@3	;@0960B
	inc	si	;@0960D
@@1:	lodsb	;@0960E
	cmp	al, 5Ah	;@0960F
	ja	@@1	;@09611
	cmp	al, 41h	;@09613
	jae	@@2	;@09615
	or	al, al	;@09617
	jne	@@1	;@09619
	jmp	short @@3	;@0961B
@@2:	add	byte ptr [si-1], 20h	;@0961D
	jmp	@@1	;@09621
@@3:	pop	di	;@09623
	mov	si, 0B402h	;@09624
	push	ds	;@09627
	push	si	;@09628
	push	ds	;@09629
	push	di	;@0962A
	mov	ax, 0FFh	;@0962B
	push	ax	;@0962E
	xor	ax, ax	;@0962F
	push	ax	;@09631
	push	ax	;@09632
	push	ax	;@09633
	push	ax	;@09634
	inc	ax	;@09635
	push	ax	;@09636
	mov	ax, 1A7h	;@09637
	mov	ds, ax	;@0963A
	db	9Ah, 67h, 9, 4Fh, 0	; lcall 0x4f, 0x967	;@0963C
	mov	ds, word ptr cs:L00100+16	;@09641
	push	ds	;@09646
	pop	es	;@09647
	ret	;@09648
PUT_SYMBOL_NAME:	push	cx	;@09649
	cmp	si, -1	;@0964A
	je	@@1	;@0964D
	push	si	;@0964F
	and	si, 3	;@09650
	shl	si, 1	;@09653
	shl	si, 1	;@09655
	shl	si, 1	;@09657
	mov	es, word ptr [si+718h]	;@09659
	pop	si	;@0965D
	cmp	byte ptr es:[si+3], 40h	;@0965E
	db	74h, 15h	; je @@2	;@09663
	push	si	;@09665
	inc	si	;@09666
	inc	si	;@09667
	call	PUT_NAME_STRING	;@09668
	pop	si	;@0966B
	pop	cx	;@0966C
	ret	;@0966D
@@1:	call	PUT_INLINE	;@0966E
	push	es	;@09671
	sub	byte ptr [bp+6Fh], ch	;@09672
	outsb	;@09675
	db	65h, 29h, 59h, 0C3h	; sub word ptr [bx+di-3Dh], bx	;@09676
@@2:	db	50h	; push ax	;@0967A
	push	bx	;@0967B
	push	dx	;@0967C
	push	si	;@0967D
	push	di	;@0967E
	call	L095E8	;@0967F
	pop	di	;@09682
	mov	bx, di	;@09683
	mov	cx, 0FFh	;@09685
	cld	;@09688
	mov	al, 0	;@09689
	repne scasb	;@0968B
	dec	di	;@0968D
	sub	bx, di	;@0968E
	neg	bx	;@09690
	mov	word ptr ds:[0B443h], bx	;@09692
	pop	si	;@09696
	pop	dx	;@09697
	pop	bx	;@09698
	pop	ax	;@09699
	pop	cx	;@0969A
	cmp	di, 0B340h	;@0969B
	jae	@@3	;@0969F
	ret	;@096A1
@@3:	push	ds	;@096A2
	mov	ds, word ptr cs:L00100+16	;@096A3
	call	L094C0	;@096A8
	pop	ds	;@096AB
	ret	;@096AC
PUT_PLAIN_NAME:	push	cx	;@096AD
	cmp	si, -1	;@096AE
	je	@@1	;@096B1
	push	si	;@096B3
	and	si, 3	;@096B4
	shl	si, 1	;@096B7
	shl	si, 1	;@096B9
	shl	si, 1	;@096BB
	mov	es, word ptr [si+718h]	;@096BD
	pop	si	;@096C1
	push	si	;@096C2
	inc	si	;@096C3
	inc	si	;@096C4
	call	PUT_NAME_STRING	;@096C5
	pop	si	;@096C8
	pop	cx	;@096C9
	ret	;@096CA
@@1:	call	PUT_INLINE	;@096CB
	push	es	;@096CE
	sub	byte ptr [bp+6Fh], ch	;@096CF
	outsb	;@096D2
	db	65h, 29h, 59h, 0C3h	; sub word ptr [bx+di-3Dh], bx	;@096D3
PUT_DECIMAL:	db	50h	; push ax	;@096D7
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
COPY_NAME:	push	ds	;@09740
	mov	es, word ptr cs:L00100+16	;@09741
	push	si	;@09746
	and	si, 3	;@09747
	shl	si, 1	;@0974A
	shl	si, 1	;@0974C
	shl	si, 1	;@0974E
	mov	ds, word ptr [si+718h]	;@09750
	pop	si	;@09754
	lodsw	;@09755
	lodsb	;@09756
	and	ax, 3Fh	;@09757
	mov	cx, ax	;@0975A
	rep movsb	;@0975C
	xor	al, al	;@0975E
	stosb	;@09760
	pop	ds	;@09761
	ret	;@09762
PUT_FAR_STRING:	push	bp	;@09763
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
	db	7 dup (0)	;@09799
	push	bp	;@097A0
	mov	bp, sp	;@097A1
	sub	sp, 8	;@097A3
	xor	ax, ax	;@097A6
	lodsb	;@097A8
	cmp	ax, 2	;@097A9
	je	@@10	;@097AC
	cmp	ax, 1	;@097AE
	je	@@4	;@097B1
	call	L0869D	;@097B3
@@4:	xor	ax, ax	;@097B6
	lodsb	;@097B8
	push	ax	;@097B9
	xor	bx, bx	;@097BA
	cmp	byte ptr [si], 0	;@097BC
	je	@@6	;@097BF
	xor	ax, ax	;@097C1
	cmp	byte ptr ds:[129h], 0	;@097C3
	je	@@5	;@097C8
	inc	ax	;@097CA
@@5:	push	word ptr ds:[122h]	;@097CB
	mov	byte ptr ds:[122h], al	;@097CF
	mov	ah, 0	;@097D2
	call	L08E16	;@097D4
	pop	ax	;@097D7
	mov	byte ptr ds:[122h], al	;@097D8
@@6:	mov	word ptr ds:[6E7h], bx	;@097DB
	mov	word ptr ds:[6DFh], bx	;@097DF
	mov	ah, 0C0h	;@097E3
	call	L08E16	;@097E5
	mov	word ptr ds:[6E1h], bx	;@097E8
	pop	ax	;@097EC
	or	ax, ax	;@097ED
	je	@@7	;@097EF
	lodsw	;@097F1
	jmp	short @@9	;@097F2
@@7:	cmp	byte ptr [si], 0	;@097F4
	je	@@8	;@097F7
	mov	ah, 0	;@097F9
	call	L08E16	;@097FB
	mov	word ptr ds:[6DFh], bx	;@097FE
@@8:	xor	ax, ax	;@09802
@@9:	mov	word ptr ds:[6E3h], ax	;@09804
	mov	word ptr ds:[6E5h], 0	;@09807
	call	L0B80E	;@0980D
	mov	word ptr ds:[53Bh], di	;@09810
	jmp	@@14	;@09814
@@10:	xor	ax, ax	;@09817
	lodsb	;@09819
	mov	word ptr [bp-2], ax	;@0981A
	mov	ah, 0	;@0981D
	call	L08E16	;@0981F
	mov	word ptr [bp-4], bx	;@09822
	cmp	byte ptr [si], 0	;@09825
	je	@@12	;@09828
	xor	ax, ax	;@0982A
	cmp	byte ptr ds:[129h], 0	;@0982C
	je	@@11	;@09831
	inc	ax	;@09833
@@11:	push	word ptr ds:[122h]	;@09834
	mov	byte ptr ds:[122h], al	;@09838
	mov	ah, 0	;@0983B
	call	L08E16	;@0983D
	pop	ax	;@09840
	mov	byte ptr ds:[122h], al	;@09841
@@12:	mov	word ptr [bp-6], bx	;@09844
	mov	bx, 0	;@09847
	mov	ax, word ptr [bp-2]	;@0984A
	test	al, 80h	;@0984D
	je	@@13	;@0984F
	mov	bx, word ptr [si]	;@09851
@@13:	mov	word ptr [bp-8], bx	;@09853
	mov	bx, word ptr [bp-6]	;@09856
	push	bx	;@09859
	and	bx, 3	;@0985A
	shl	bx, 1	;@0985D
	shl	bx, 1	;@0985F
	shl	bx, 1	;@09861
	mov	es, word ptr [bx+718h]	;@09863
	pop	bx	;@09867
	mov	bx, word ptr es:[bx]	;@09868
	cmp	bx, -1	;@0986B
	je	@@14	;@0986E
	call	L0B8A4	;@09870
	mov	word ptr es:[di+4], bx	;@09873
	mov	bx, word ptr [bp-4]	;@09877
	mov	word ptr es:[di+2], bx	;@0987A
	mov	bx, word ptr [bp-8]	;@0987E
	mov	word ptr es:[di+6], bx	;@09881
	mov	ax, word ptr [bp-2]	;@09885
	or	al, 80h	;@09888
	mov	byte ptr es:[di+8], al	;@0988A
	inc	word ptr ds:[0B4A4h]	;@0988E
	inc	word ptr ds:[0B4A6h]	;@09892
@@14:	mov	sp, bp	;@09896
	pop	bp	;@09898
	ret	;@09899
	db	60h, 4, 62h, 4, 64h, 4, 66h, 4, 68h, 4, 6Ah, 4, 'SQVW', 0BEh, 9Ah	;@0989A
	db	98h, 0B9h, 6, 0, 2Eh, 8Bh, 1Ch, 8Bh, 1Fh, 3Bh, 1Eh, 4Ah, 2, 74h
	db	8, 83h, 0C6h, 2, 49h, 75h, 0EFh, 0EBh, 24h, 0F7h, 0D1h, 83h, 0E1h
	db	7, 0C6h, 6, 0F3h, 6, 5, 0C6h, 6, 0F4h, 6, 7, 3, 3Eh, 0E8h, 3, 89h
	db	3Eh, 0F5h, 6, 89h, 0Eh, 0F7h, 6, 0C7h, 6, 0F9h, 6, 0, 0, 0E8h
	db	0EAh, 0A6h, '_^Y[', 0C3h
NE_BAD_ENTRY:	push	si	;@098EC
	push	di	;@098ED
	push	es	;@098EE
	mov	al, dh	;@098EF
	shr	al, 1	;@098F1
	shr	al, 1	;@098F3
	cmp	al, 1	;@098F5
	jne	@@1	;@098F7
	mov	al, 5	;@098F9
@@1:	mov	byte ptr ds:[6F3h], al	;@098FB
	cmp	bx, -3	;@098FE
	jne	@@3	;@09901
	mov	byte ptr ds:[6F4h], 1	;@09903
	mov	es, word ptr ds:[808h]	;@09908
	mov	si, cx	;@0990C
	mov	bx, word ptr es:[si+2]	;@0990E
	mov	cx, word ptr es:[si+4]	;@09912
	and	cx, 7FFFh	;@09916
	or	cx, cx	;@0991A
	jne	@@2	;@0991C
	mov	byte ptr ds:[6F4h], 2	;@0991E
	mov	cx, word ptr es:[si+6]	;@09923
@@2:	jmp	short @@9	;@09927
@@3:	mov	es, word ptr ds:[7A0h]	;@09929
	cmp	byte ptr ds:[0B48Bh], 1	;@0992D
	je	@@5	;@09932
	test	byte ptr es:[bx+13h], 1	;@09934
	je	@@5	;@09939
	push	cx	;@0993B
	add	cx, word ptr ds:[21Eh]	;@0993C
	test	byte ptr ds:[215h], 20h	;@09940
	jne	@@4	;@09945
	add	cx, word ptr [di+0A50h]	;@09947
	cmp	dh, 8	;@0994B
	jne	@@4	;@0994E
	xor	cx, cx	;@09950
@@4:	call	L0B673	;@09952
	cmp	ax, 0FFFFh	;@09955
	je	@@11	;@09958
	add	sp, 2	;@0995A
	mov	cx, ax	;@0995D
	mov	bx, 0FFFFh	;@0995F
	jmp	short @@6	;@09962
@@5:	mov	bx, word ptr es:[bx+6]	;@09964
@@6:	xor	bh, bh	;@09968
	mov	byte ptr ds:[6F4h], 0	;@0996A
	cmp	dh, 8	;@0996F
	jne	@@7	;@09972
	test	byte ptr ds:[215h], 10h	;@09974
	jne	@@7	;@09979
	or	byte ptr ds:[6F4h], 4	;@0997B
	jmp	short @@8	;@09980
@@7:	cmp	bl, 0FFh	;@09982
	je	@@8	;@09985
	add	cx, word ptr [di+0A50h]	;@09987
@@8:	test	byte ptr ds:[6F4h], 4	;@0998B
	jne	@@10	;@09990
@@9:	mov	word ptr [di+0A50h], 0FFFFh	;@09992
@@10:	mov	word ptr ds:[6F7h], bx	;@09998
	mov	word ptr ds:[6F9h], cx	;@0999C
	add	di, word ptr ds:[3E8h]	;@099A0
	mov	word ptr ds:[6F5h], di	;@099A4
	call	L03FD1	;@099A8
	pop	es	;@099AB
	pop	di	;@099AC
	pop	si	;@099AD
	ret	;@099AE
@@11:	push	ax	;@099AF
	push	bx	;@099B0
	push	dx	;@099B1
	push	si	;@099B2
	push	di	;@099B3
	push	cx	;@099B4
	mov	es, word ptr ds:[7A0h]	;@099B5
	mov	bx, word ptr es:[bx+6]	;@099B9
	push	bx	;@099BD
	mov	cx, 4	;@099BE
	push	cx	;@099C1
	mov	ax, 39h	;@099C2
	push	ax	;@099C5
	call	WARNING	;@099C6
	pop	di	;@099C9
	pop	si	;@099CA
	pop	dx	;@099CB
	pop	bx	;@099CC
	pop	ax	;@099CD
	pop	cx	;@099CE
	mov	es, word ptr ds:[7A0h]	;@099CF
	jmp	@@5	;@099D3
	db	6, 56h, 33h, 0F6h, 8Eh, 6, 0D0h, 7, 3Bh, 36h, 0CEh, 7, 73h, 0Ah	;@099D5
	db	26h, 3Bh, 4, 74h, 3Eh, 83h, 0C6h, 6, 0EBh, 0F0h, 0BFh, 6, 0, 57h
	db	0BFh, 0CCh, 7, 0E8h, 0C6h, 0BAh, 73h, 3, 0E8h, 0B4h, 0BAh, 26h
	db	89h, 5, 26h, 89h, 4Dh, 4, 26h, 0FFh, 45h, 4, 8Bh, 0D8h, 53h, 83h
	db	0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 18h, 7
	db	5Bh, 83h, 0C3h, 2, 26h, 8Ah, 7, 25h, 3Fh, 0, 40h, 8Bh, 0DFh, 0EBh
	db	4, 8Bh, 0DEh, 33h, 0C0h, 5Eh, 7, 0C3h, 'SQRVW', 6, 0BFh, 0C4h
	db	7, 0E8h, 9Dh, 0BBh, 0BFh, 0CCh, 7, 0E8h, 97h, 0BBh, 33h, 0F6h
	db	33h, 0C9h, 0EBh, 0Eh, 8Eh, 6, 8, 8, 26h, 83h, 7Ch, 6, 0FFh, 74h
	db	12h, 83h, 0C6h, 0Ch, 3Bh, 36h, 6, 8, 72h, 0ECh, 8Bh, 0C1h, 7, '_^ZY['
	db	0C3h, 26h, 8Bh, 44h, 2, 0E8h, 6Ch, 0FFh, 0Bh, 0C0h, 74h, 36h, 8Bh
	db	0D3h, 0BFh, 2, 0, 57h, 0BFh, 0C4h, 7, 0E8h, 44h, 0BAh, 73h, 3
	db	0E8h, 32h, 0BAh, 8Bh, 0DFh, 26h, 89h, 0Fh, 26h, 0FFh, 7, 0D1h
	db	0EBh, 43h, 87h, 0D3h, 8Eh, 6, 0D0h, 7, 26h, 89h, 57h, 2, 8Eh, 6
	db	8, 8, 26h, 89h, 54h, 2, 26h, 89h, 5Ch, 0Ah, 3, 0C8h, 0EBh, 14h
	db	8Eh, 6, 0D0h, 7, 26h, 8Bh, 47h, 2, 8Eh, 6, 8, 8, 26h, 89h, 44h
	db	2, 26h, 89h, 5Ch, 0Ah, 26h, 8Bh, 44h, 4, 0Bh, 0C0h, 75h, 91h, 26h
	db	8Bh, 4, 0E8h, 10h, 0FFh, 3, 0C8h, 8Eh, 6, 0D0h, 7, 26h, 8Bh, 47h
	db	4, 8Eh, 6, 8, 8, 26h, 89h, 44h, 6, 0E9h, 76h, 0FFh, 'PATH=U', 8Bh
	db	0ECh, 81h, 0ECh, 88h, 0, 0BFh, 0FCh, 7, 0E8h, 0EAh, 0BAh, 8Bh
	db	1Eh, 9Ah, 0B4h, 83h, 0FBh, 0, 75h, 6Eh, 0B9h, 40h, 0, 0B8h, 44h
	db	0, 80h, 3Eh, 2Ah, 1, 2, 74h, 3, 0B8h, 37h, 0, 3, 0C8h, 83h, 0C1h
	db	0Fh, 80h, 0E1h, 0F0h, 51h, 8Bh, 0F9h, 57h, 0BFh, 0FCh, 7, 0E8h
	db	0A6h, 0B9h, 73h, 3, 0E8h, 94h, 0B9h, 33h, 0C0h, 0F3h, 0AAh, 59h
	db	51h, 0Eh, 1Fh, 0BEh, 61h, 0A1h, 0B9h, 1Ah, 0, 33h, 0FFh, 0F3h
	db	0A4h, 0BFh, 3Eh, 0, 83h, 0C7h, 0Fh, 83h, 0E7h, 0F0h, 2Eh, 8Eh
	db	1Eh, 10h, 0, 0BEh, 7Bh, 0A1h, 0B9h, 44h, 0, 80h, 3Eh, 2Ah, 1, 2
	db	74h, 6, 0BEh, 0BFh, 0A1h, 0B9h, 37h, 0, 0Eh, 1Fh, 0F3h, 0A4h, 2Eh
	db	8Eh, 1Eh, 10h, 0, 58h, 0E9h, 0D2h, 0, 0B8h, 28h, 0, 8Ch, 0DAh
	db	0EBh, 68h, 8Eh, 6, 6Ch, 0B4h, 0BFh, 28h, 0, 57h, 33h, 0C9h, 26h
	db	8Ah, 0Fh, 51h, 1Eh, 57h, 6, 53h, 0E8h, 36h, 0F7h, 59h, 0E3h, 1Ah
	db	0BBh, 28h, 0, 80h, '?\t', 0D9h, 80h, '?:t', 0D4h, 43h, 0E2h, 0F3h
	db	1Eh, 0B8h, 28h, 0, 50h, 0E8h, 93h, 0F8h, 72h, 7, 8Ch, 0DAh, 0B8h
	db	28h, 0, 0EBh, 2Fh, 0B8h, 5, 0, 50h, 0Eh, 0B8h, 0DAh, 9Ah, 50h
	db	0B8h, 0A7h, 1, 8Eh, 0C0h, 26h, 0A1h, 0, 0, 50h, 33h, 0C0h, 50h
	db	0E8h, 0ABh, 0F7h, 52h, 50h, 0BFh, 28h, 0, 1Eh, 57h, 16h, 8Dh, 86h
	db	78h, 0FFh, 50h, 0B8h, 80h, 0, 50h, 0E8h, 0F7h, 0F7h, 72h, 76h
	db	89h, 56h, 0FAh, 89h, 46h, 0F8h, 0B8h, 0, 3Dh, 8Eh, 5Eh, 0FAh, 8Bh
	db	56h, 0F8h, 0E8h, 0Fh, 67h, 2Eh, 8Eh, 1Eh, 10h, 0, 89h, 46h, 0FEh
	db	8Bh, 0D8h, 33h, 0C9h, 8Bh, 0D1h, 0B8h, 2, 42h, 0E8h, 0C1h, 66h
	db	83h, 0FAh, 0, 75h, 5Bh, 89h, 46h, 0FCh, 8Bh, 0F8h, 57h, 0BFh, 0FCh
	db	7, 0E8h, 0BBh, 0B8h, 73h, 3, 0E8h, 0A9h, 0B8h, 8Bh, 5Eh, 0FEh
	db	33h, 0C9h, 8Bh, 0D1h, 0B8h, 0, 42h, 0E8h, 9Eh, 66h, 8Bh, 5Eh, 0FEh
	db	1Eh, 8Eh, 1Eh, 0, 8, 33h, 0D2h, 8Bh, 4Eh, 0FCh, 0B8h, 0, 3Fh, 0E8h
	db	8Bh, 66h, 1Fh, 0E8h, 33h, 0, 8Bh, 46h, 0FCh, 0A3h, 54h, 0B4h, 0A3h
	db	0FEh, 7, 5, 0Fh, 0, 25h, 0F0h, 0FFh, 0A3h, 52h, 0B4h, 8Bh, 0E5h
	db	5Dh, 0C3h, 0B8h, 28h, 0, 1Eh, 50h, 0B8h, 4, 0, 50h, 0B8h, 1, 0
	db	50h, 0E8h, 50h, 1Fh, 0E8h, 0Ah, 0, 33h, 0C0h, 50h, 0B8h, 21h, 0
	db	50h, 0E8h, 43h, 1Fh, 8Bh, 5Eh, 0FEh, 0E8h, 62h, 66h, 0C3h
L09C65:	push	ds	;@09C65
	push	word ptr ds:[0B452h]	;@09C66
	push	word ptr ds:[0B49Ah]	;@09C6A
	mov	ds, word ptr ds:[800h]	;@09C6E
	cmp	word ptr ds:[6], 0	;@09C72
	je	@@1	;@09C77
	cmp	word ptr ds:[18h], 40h	;@09C79
	je	@@1	;@09C7E
	mov	cx, word ptr ds:[6]	;@09C80
	shl	cx, 1	;@09C84
	push	cx	;@09C86
	shl	cx, 1	;@09C87
	push	ds	;@09C89
	pop	es	;@09C8A
	mov	si, word ptr ds:[18h]	;@09C8B
	add	si, cx	;@09C8F
	sub	si, 2	;@09C91
	mov	di, 40h	;@09C94
	add	di, cx	;@09C97
	sub	di, 2	;@09C99
	pop	cx	;@09C9C
	std	;@09C9D
	rep movsw	;@09C9E
	cld	;@09CA0
@@1:	pop	bx	;@09CA1
	pop	ax	;@09CA2
	mov	word ptr ds:[3Ch], ax	;@09CA3
	mov	word ptr ds:[3Eh], 0	;@09CA6
	mov	word ptr ds:[18h], 40h	;@09CAC
	or	bx, bx	;@09CB2
	je	@@2	;@09CB4
	mov	word ptr ds:[0Ah], 0	;@09CB6
@@2:	pop	ds	;@09CBC
	mov	cx, word ptr ds:[0B454h]	;@09CBD
	sub	ax, ax	;@09CC1
	cwd	;@09CC3
	xor	si, si	;@09CC4
	mov	bx, 800h	;@09CC6
	call	L08905	;@09CC9
	ret	;@09CCC
	db	0C7h, 6, 9Fh, 6, 4Eh, 45h, 0C6h, 6, 0A1h, 6, 5, 0C6h, 6, 0A2h	;@09CCD
	db	6, 0Ah, 0A1h, 50h, 0B4h, 80h, 3Eh, 8Bh, 0B4h, 1, 75h, 3, 0Dh, 8
	db	0, 0A3h, 0ABh, 6, 0E8h, 46h, 16h, 0A3h, 0AFh, 6, 80h, 3Eh, 0D3h
	db	3, 1, 74h, 0Bh, 80h, 3Eh, 2Bh, 1, 3, 74h, 4, 89h, 1Eh, 0B1h, 6
	db	33h, 0C0h, 0F7h, 6, 50h, 0B4h, 3, 0, 74h, 40h, 8Bh, 1Eh, 0FCh
	db	3, 83h, 0FBh, 0FFh, 75h, 18h, 33h, 0C9h, 51h, 0B8h, 38h, 0, 50h
	db	0E8h, 89h, 1Eh, 0EBh, 2Eh, 33h, 0C9h, 51h, 0B8h, 2Ch, 0, 50h, 0E8h
	db	78h, 1Eh, 0EBh, 1Eh, 8Eh, 6, 0A0h, 7, 26h, 8Bh, 47h, 6, 50h, 26h
	db	8Bh, 47h, 0Dh, 3, 6, 0AFh, 6, 72h, 0E1h, 3, 6, 0B1h, 6, 73h, 5
	db	3Dh, 0, 0, 75h, 0D6h, 58h, 0A3h, 0ADh, 6, 83h, 3Eh, 0B9h, 6, 0
	db	75h, 0Dh, 80h, 3Eh, 2Bh, 1, 3, 74h, 6, 0A1h, 0ADh, 6, 0A3h, 0B9h
	db	6, 80h, 3Eh, 0D3h, 3, 1, 74h, 11h, 83h, 3Eh, 0B1h, 6, 0, 75h, 0Ah
	db	80h, 3Eh, 2Bh, 1, 3, 74h, 3, 0E8h, 82h, 0D6h, 0A1h, 0C6h, 7, 0D1h
	db	0E8h, 0A3h, 0BDh, 6, 0E8h, 52h, 14h, 89h, 0Eh, 0BFh, 6, 0B8h, 40h
	db	0, 0A3h, 0C1h, 6, 8Bh, 0Eh, 0BBh, 6, 81h, 0F9h, 0FEh, 0, 76h, 3
	db	0E9h, 9Dh, 0, 8Bh, 1Eh, 9Eh, 7, 0Bh, 0DBh, 74h, 27h, 83h, 0EBh
	db	14h, 8Eh, 6, 0A0h, 7, 8Bh, 16h, 4, 4, 83h, 0FAh, 0FFh, 74h, 6
	db	8Bh, 0DAh, 26h, 8Bh, 4Fh, 6, 50h, 26h, 8Bh, 47h, 0Dh, 26h, 0Bh
	db	47h, 0Fh, 58h, 75h, 5, 49h, 89h, 0Eh, 0BBh, 6, 0D1h, 0E1h, 0D1h
	db	0E1h, 0D1h, 0E1h, 3, 0C1h, 0A3h, 0C3h, 6, 0A3h, 0C5h, 6, 50h, 0E8h
	db	32h, 10h, 58h, 3, 0C1h, 0A3h, 0C7h, 6, 3, 6, 0C6h, 7, 0A3h, 0C9h
	db	6, 3, 6, 0F8h, 3, 0A3h, 0A3h, 6, 50h, 0E8h, 89h, 10h, 0A3h, 0A5h
	db	6, 58h, 3, 6, 0A5h, 6, 50h, 51h, 3, 6, 52h, 0B4h, 0A3h, 0CBh, 6
	db	0C7h, 6, 0CDh, 6, 0, 0, 0C7h, 6, 0D3h, 6, 0, 0, 0E8h, 84h, 1Ah
	db	0A2h, 0D5h, 6, 0A1h, 0CBh, 6, 3, 6, 0BFh, 6, 5, 0Fh, 0, 25h, 0F0h
	db	0FFh, 8Bh, 1Eh, 0FAh, 3, 3, 0C3h, 23h, 0D8h, 33h, 0C3h, 0B1h, 4
	db	0D3h, 0E8h, 0A3h, 0FEh, 3, 59h, 58h, 0C3h, 33h, 0C0h, 50h, 0B8h
	db	20h, 0, 50h, 0E8h, 5Ah, 1Dh
L09E47:	mov	ax, word ptr ds:[6B3h]	;@09E47
	or	ax, word ptr ds:[6B5h]	;@09E4A
	jne	@@1	;@09E4E
	cmp	byte ptr ds:[12Bh], 3	;@09E50
	je	@@1	;@09E55
	xor	ax, ax	;@09E57
	push	ax	;@09E59
	mov	ax, 3Bh	;@09E5A
	push	ax	;@09E5D
	call	WARNING	;@09E5E
@@1:	call	L09C65	;@09E61
	mov	ax, word ptr ds:[3FEh]	;@09E64
	call	L072D5	;@09E67
	mov	ax, 2	;@09E6A
	cwd	;@09E6D
	mov	cx, 4	;@09E6E
	mov	si, 49Eh	;@09E71
	call	L0895D	;@09E74
	mov	cx, 40h	;@09E77
	mov	si, 69Fh	;@09E7A
	mov	ax, word ptr ds:[0B452h]	;@09E7D
	xor	dx, dx	;@09E80
	call	L0895D	;@09E82
	ret	;@09E85
L09E86:	push	bp	;@09E86
	mov	bp, sp	;@09E87
	sub	sp, 0Ah	;@09E89
	push	ax	;@09E8C
	push	bx	;@09E8D
	push	cx	;@09E8E
	push	dx	;@09E8F
	push	di	;@09E90
	mov	ax, 4000h	;@09E91
	mul	word ptr ds:[484h]	;@09E94
	add	ax, word ptr ds:[486h]	;@09E98
	adc	dx, 0	;@09E9C
	mov	word ptr [bp-8], dx	;@09E9F
	mov	word ptr [bp-6], ax	;@09EA2
	mov	es, word ptr ds:[7A0h]	;@09EA5
	mov	ax, word ptr es:[bx+0Dh]	;@09EA9
	mov	word ptr [bp-0Ah], ax	;@09EAD
	mov	di, bx	;@09EB0
	mov	ax, word ptr ds:[3FEh]	;@09EB2
	xor	dx, dx	;@09EB5
	add	ax, word ptr es:[di+8]	;@09EB7
	adc	dl, byte ptr es:[di+0Ah]	;@09EBB
	mov	cx, 4	;@09EBF
@@1:	shl	ax, 1	;@09EC2
	rcl	dx, 1	;@09EC4
	loop	@@1	;@09EC6
	mov	word ptr [bp-4], dx	;@09EC8
	mov	word ptr [bp-2], ax	;@09ECB
	cmp	dx, word ptr [bp-8]	;@09ECE
	ja	@@7	;@09ED1
	jb	@@2	;@09ED3
	cmp	ax, word ptr [bp-6]	;@09ED5
	jae	@@7	;@09ED8
@@2:	add	ax, word ptr [bp-0Ah]	;@09EDA
	adc	dx, 0	;@09EDD
	cmp	dx, word ptr [bp-8]	;@09EE0
	ja	@@8	;@09EE3
	jb	@@3	;@09EE5
	cmp	ax, word ptr [bp-6]	;@09EE7
	ja	@@8	;@09EEA
@@3:	mov	ax, word ptr [bp-0Ah]	;@09EEC
	mov	word ptr ds:[6F1h], ax	;@09EEF
	mov	word ptr ds:[6EDh], ax	;@09EF2
	jmp	short @@9	;@09EF5
@@4:	jbe	@@5	;@09EF7
	jmp	@@21	;@09EF9
@@5:	or	ax, ax	;@09EFC
	je	@@6	;@09EFE
	jmp	@@21	;@09F00
@@6:	mov	word ptr ds:[6EDh], 0	;@09F03
	mov	ax, word ptr [bp-0Ah]	;@09F09
	mov	word ptr ds:[6F1h], ax	;@09F0C
	jmp	short @@9	;@09F0F
@@7:	mov	ax, 0	;@09F11
	mov	word ptr ds:[6EBh], ax	;@09F14
	mov	word ptr ds:[6EDh], ax	;@09F17
	mov	ax, word ptr [bp-0Ah]	;@09F1A
	mov	word ptr ds:[6F1h], ax	;@09F1D
	jmp	short @@11	;@09F20
@@8:	mov	dx, word ptr [bp-8]	;@09F22
	mov	ax, word ptr [bp-6]	;@09F25
	sub	ax, word ptr [bp-2]	;@09F28
	sbb	dx, word ptr [bp-4]	;@09F2B
	cmp	dx, 1	;@09F2E
	jae	@@4	;@09F31
	mov	word ptr ds:[6EDh], ax	;@09F33
	mov	ax, word ptr [bp-0Ah]	;@09F36
	mov	word ptr ds:[6F1h], ax	;@09F39
@@9:	mov	dx, word ptr [bp-4]	;@09F3C
	mov	ax, word ptr [bp-2]	;@09F3F
	mov	cx, word ptr ds:[6D1h]	;@09F42
@@10:	shr	dx, 1	;@09F46
	rcr	ax, 1	;@09F48
	loop	@@10	;@09F4A
	or	dx, dx	;@09F4C
	jne	@@20	;@09F4E
	mov	word ptr ds:[6EBh], ax	;@09F50
@@11:	mov	dx, 0C00h	;@09F53
	cmp	byte ptr es:[di+1], 4	;@09F56
	jne	@@12	;@09F5B
	or	dx, 11h	;@09F5D
@@12:	cmp	byte ptr es:[di+1], 0	;@09F60
	jg	@@13	;@09F65
	or	dx, 1	;@09F67
@@13:	cmp	word ptr es:[di+11h], 0	;@09F6A
	je	@@14	;@09F6F
	or	dx, 100h	;@09F71
@@14:	test	byte ptr es:[di+13h], 1	;@09F75
	je	@@15	;@09F7A
	or	dx, 10h	;@09F7C
@@15:	test	byte ptr es:[di+13h], 2	;@09F7F
	je	@@16	;@09F84
	or	dx, 20h	;@09F86
@@16:	test	byte ptr es:[di+13h], 4	;@09F89
	je	@@17	;@09F8E
	or	dx, 40h	;@09F90
@@17:	test	byte ptr es:[di+13h], 8	;@09F93
	je	@@18	;@09F98
	or	dx, 80h	;@09F9A
@@18:	test	byte ptr es:[di+13h], 10h	;@09F9E
	je	@@19	;@09FA3
	or	dx, 1000h	;@09FA5
@@19:	mov	word ptr ds:[6EFh], dx	;@09FA9
	pop	di	;@09FAD
	pop	dx	;@09FAE
	pop	cx	;@09FAF
	pop	bx	;@09FB0
	pop	ax	;@09FB1
	mov	sp, bp	;@09FB2
	pop	bp	;@09FB4
	ret	;@09FB5
@@20:	xor	ax, ax	;@09FB6
	push	ax	;@09FB8
	mov	ax, 11h	;@09FB9
	push	ax	;@09FBC
	call	FATAL	;@09FBD
@@21:	xor	ax, ax	;@09FC0
	push	ax	;@09FC2
	mov	ax, 12h	;@09FC3
	push	ax	;@09FC6
	call	FATAL	;@09FC7
L09FCA:	mov	ax, word ptr ds:[0B452h]	;@09FCA
	add	ax, word ptr ds:[6C1h]	;@09FCD
	xor	bx, bx	;@09FD1
@@1:	cmp	bx, word ptr ds:[79Eh]	;@09FD3
	jae	@@3	;@09FD7
	mov	es, word ptr ds:[7A0h]	;@09FD9
	push	ax	;@09FDD
	mov	ax, word ptr es:[bx+0Dh]	;@09FDE
	or	ax, word ptr es:[bx+0Fh]	;@09FE2
	pop	ax	;@09FE6
	je	@@2	;@09FE7
	call	L09E86	;@09FE9
	mov	cx, 8	;@09FEC
	mov	si, 6EBh	;@09FEF
	xor	dx, dx	;@09FF2
	call	L0895D	;@09FF4
@@2:	add	bx, 14h	;@09FF7
	jmp	@@1	;@09FFA
@@3:	ret	;@09FFC
L09FFD:	mov	cx, word ptr ds:[7C6h]	;@09FFD
	jcxz	@@1	;@0A001
	push	ds	;@0A003
	push	si	;@0A004
	mov	ax, word ptr ds:[0B452h]	;@0A005
	add	ax, word ptr ds:[6C7h]	;@0A008
	xor	dx, dx	;@0A00C
	xor	si, si	;@0A00E
	mov	bx, 7C8h	;@0A010
	call	L08905	;@0A013
	pop	si	;@0A016
	pop	ds	;@0A017
@@1:	ret	;@0A018
L0A019:	xor	bx, bx	;@0A019
	mov	cx, word ptr ds:[0B452h]	;@0A01B
	add	cx, word ptr ds:[6C9h]	;@0A01F
	inc	cx	;@0A023
@@1:	cmp	bx, word ptr ds:[7CEh]	;@0A024
	jae	@@2	;@0A028
	mov	es, word ptr ds:[7D0h]	;@0A02A
	mov	si, word ptr es:[bx]	;@0A02E
	push	bx	;@0A031
	xchg	ax, cx	;@0A032
	xor	dx, dx	;@0A033
	mov	bx, si	;@0A035
	and	bx, 3	;@0A037
	shl	bx, 1	;@0A03A
	shl	bx, 1	;@0A03C
	shl	bx, 1	;@0A03E
	lea	bx, [bx+718h]	;@0A040
	push	si	;@0A044
	and	si, 3	;@0A045
	shl	si, 1	;@0A048
	shl	si, 1	;@0A04A
	shl	si, 1	;@0A04C
	mov	es, word ptr [si+718h]	;@0A04E
	pop	si	;@0A052
	add	si, 2	;@0A053
	mov	cl, byte ptr es:[si]	;@0A056
	and	cx, 3Fh	;@0A059
	mov	byte ptr es:[si], cl	;@0A05C
	inc	cx	;@0A05F
	call	L08905	;@0A060
	add	cx, ax	;@0A063
	pop	bx	;@0A065
	add	bx, 6	;@0A066
	jmp	@@1	;@0A069
@@2:	ret	;@0A06B
L0A06C:	push	bx	;@0A06C
	push	cx	;@0A06D
	push	dx	;@0A06E
	push	si	;@0A06F
	push	di	;@0A070
	sub	si, si	;@0A071
@@1:	cmp	si, word ptr ds:[79Eh]	;@0A073
	jae	@@3	;@0A077
	mov	es, word ptr ds:[7A0h]	;@0A079
	mov	ax, word ptr es:[si+8]	;@0A07D
	mov	dl, byte ptr es:[si+0Ah]	;@0A081
	mov	dh, 0	;@0A085
	add	ax, word ptr ds:[3FEh]	;@0A087
	adc	dl, dh	;@0A08B
	shl	ax, 1	;@0A08D
	rcl	dx, 1	;@0A08F
	shl	ax, 1	;@0A091
	rcl	dx, 1	;@0A093
	shl	ax, 1	;@0A095
	rcl	dx, 1	;@0A097
	shl	ax, 1	;@0A099
	rcl	dx, 1	;@0A09B
	add	ax, word ptr es:[si+0Dh]	;@0A09D
	adc	dx, word ptr es:[si+0Fh]	;@0A0A1
	push	si	;@0A0A5
	mov	cx, 2	;@0A0A6
	cmp	word ptr es:[si+11h], 0	;@0A0A9
	je	@@2	;@0A0AE
	lea	si, [si+11h]	;@0A0B0
	mov	bx, 7A0h	;@0A0B3
	call	L08905	;@0A0B6
@@2:	pop	si	;@0A0B9
	add	si, 14h	;@0A0BA
	jmp	@@1	;@0A0BD
@@3:	pop	di	;@0A0BF
	pop	si	;@0A0C0
	pop	dx	;@0A0C1
	pop	cx	;@0A0C2
	pop	bx	;@0A0C3
	ret	;@0A0C4
WRITE_NE_TABLES:	call	L09E47	;@0A0C5
	call	L09FCA	;@0A0C8
	call	L0B2E0	;@0A0CB
	call	L09FFD	;@0A0CE
	call	L0A019	;@0A0D1
	call	L0B318	;@0A0D4
	call	L0B2FE	;@0A0D7
	call	L0A06C	;@0A0DA
	ret	;@0A0DD
	db	'VW3', 0F6h, 56h, 0BBh, 0Ch, 8, 0EBh, 'YV3', 0C0h, 50h, 0B8h, 2Eh	;@0A0DE
	db	0, 50h, 0E8h, 0B3h, 1Ah, 5Eh, 0EBh, 'GSV', 83h, 0E6h, 3, 0D1h
	db	0E6h, 0D1h, 0E6h, 0D1h, 0E6h, 8Eh, 84h, 10h, 8, 5Eh, 26h, 8Bh
	db	7Ch, 2, 26h, 8Bh, 1Ch, 57h, 83h, 0E7h, 3, 0D1h, 0E7h, 0D1h, 0E7h
	db	0D1h, 0E7h, 8Eh, 85h, 58h, 7, 5Fh, 26h, 0F6h, 45h, 0Eh, 20h, 74h
	db	1Ah, 0F7h, 0C3h, 1, 0, 75h, 0BFh, 8Eh, 6, 80h, 7, 26h, 8Bh, 1Fh
	db	83h, 0FBh, 0FFh, 74h, 8, 8Eh, 6, 0A0h, 7, 26h, 0FFh, 47h, 11h
	db	5Bh, 83h, 0C6h, 4, 3Bh, 77h, 2, 72h, 0B0h, 81h, 0FBh, 1Ch, 8, 77h
	db	8, 83h, 0C3h, 8, '^FV', 0EBh, 0EDh, 5Eh, 0BFh, 0Ch, 8, 0E8h, 73h
	db	0B5h, 0E8h, 85h, 0B5h, 5Fh, 5Eh, 0C3h
DEFAULT_STUB:	dec	bp	;@0A161
	pop	dx	;@0A162
	add	byte ptr [bx+si], al	;@0A163
	add	byte ptr [bx+si], al	;@0A165
	add	byte ptr [bx+si], al	;@0A167
	add	al, 0	;@0A169
	db	0Fh, 0, 0FFh, 0FFh, 0, 0, 0B8h, 0, 0, 0, 0, 0, 0, 0, 40h, 0, 0BAh	;@0A16B
	db	10h, 0, 0Eh, 1Fh, 0B4h, 9, 0CDh, 21h, 0B8h, 1, 4Ch, 0CDh, 21h
	db	90h, 90h, 'This program must be run under Microsoft Windows.'
	db	0Dh, 0Ah, 24h, 0BAh, 10h, 0, 0Eh, 1Fh, 0B4h, 9, 0CDh, 21h, 0B8h
	db	1, 4Ch, 0CDh, 21h, 90h, 90h, 'This program must be run under OS/2.'
	db	0Dh, 0Ah, 24h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0Ah, 0, 10h, 0, 19h
	db	0, 9Dh, 0AAh, 14h, 0, 70h, 0AAh, 9, 0, 0DBh, 0AAh, 0Eh, 0, 0E8h
	db	0AAh, 7, 0, 23h, 0ABh, 8, 0, 2Dh, 0ABh, 25h, 0, 94h, 0ABh, 11h
	db	0, 7Bh, 0ABh, 28h, 0, 80h, 0ABh, 0Fh, 0, 44h, 0ACh, 12h, 0, 29h
	db	0ADh, 29h, 0, 0FEh, 0AAh, 20h, 0, 0Fh, 0ABh, 23h, 0, 16h, 0ABh
HEX_VALUE:	cmp	al, 30h	;@0A23C
	jb	@@4	;@0A23E
	cmp	al, 39h	;@0A240
	ja	@@1	;@0A242
	sub	al, 30h	;@0A244
	jmp	short @@3	;@0A246
@@1:	cmp	al, 41h	;@0A248
	jb	@@4	;@0A24A
	cmp	al, 46h	;@0A24C
	ja	@@2	;@0A24E
	sub	al, 37h	;@0A250
	jmp	short @@3	;@0A252
@@2:	cmp	al, 61h	;@0A254
	jb	@@4	;@0A256
	cmp	al, 66h	;@0A258
	ja	@@4	;@0A25A
	sub	al, 57h	;@0A25C
@@3:	xor	ah, ah	;@0A25E
	clc	;@0A260
	jmp	short @@5	;@0A261
@@4:	stc	;@0A263
@@5:	ret	;@0A264
	db	1Eh, 8Dh, 47h, 4, 50h, 89h, 4Fh, 2, 89h, 0Fh, 51h, 9Ah, 18h, 15h	;@0A265
	db	0DFh, 0, 0C3h, 'SQW', 6, 33h, 0C0h, 0A3h, 0ADh, 0B4h, 0BBh, 60h
	db	0B4h, 0B9h, 2, 0, 0E8h, 0DDh, 0FFh, 0BBh, 68h, 0B4h, 0B9h, 2, 0
	db	0E8h, 0D4h, 0FFh, 0FCh, 1Eh, 7, 0E8h, 33h, 7, 0E8h, 25h, 7, 0B8h
	db	0, 0, 7, '_Y[', 0C3h, 'SVW', 1Eh, 8Bh, 3Eh, 3Ah, 1, 0C4h, 1Eh
	db	34h, 1, 26h, 8Eh, 7, 83h, 0C7h, 2, 33h, 0C0h, 0B9h, 0FFh, 0FFh
	db	0FCh, 0F2h, 0AEh, 0F7h, 0D9h, 83h, 0E9h, 2, 83h, 0EFh, 2, 26h
	db	80h, '=\t', 9, 26h, 80h, '=:t', 3, 4Fh, 0E2h, 0F1h, 47h, 8Bh, 0F7h
	db	6, 1Fh, 2Eh, 8Eh, 6, 10h, 0, 0BFh, 7Bh, 5Ch, 0ACh, 0Ah, 0C0h, 74h
	db	3, 0AAh, 0EBh, 0F8h, 1Fh, 8Bh, 0C7h, 0BBh, '{\+', 0C3h, 4Bh, 88h
	db	7, 0E8h, 0Bh, 7, 89h, 1Eh, 0A8h, 0B4h, 8Bh, 0C3h, '_^[', 0C3h
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
	db	2, 0C3h
DEF_TOKEN:	push	es	;@0A3A9
	push	di	;@0A3AA
	push	ds	;@0A3AB
	pop	es	;@0A3AC
	call	L0A56A	;@0A3AD
	cmp	al, 3	;@0A3B0
	je	@@1	;@0A3B2
	cmp	al, 2	;@0A3B4
	jne	@@2	;@0A3B6
	call	L0A963	;@0A3B8
	jae	@@2	;@0A3BB
@@1:	push	ax	;@0A3BD
	call	L0AA01	;@0A3BE
	pop	ax	;@0A3C1
@@2:	pop	di	;@0A3C2
	pop	es	;@0A3C3
	ret	;@0A3C4
L0A3C5:	push	ax	;@0A3C5
	push	cx	;@0A3C6
	push	di	;@0A3C7
	push	es	;@0A3C8
	xor	ax, ax	;@0A3C9
	lodsb	;@0A3CB
	mov	cx, ax	;@0A3CC
	jcxz	@@3	;@0A3CE
	push	ds	;@0A3D0
	pop	es	;@0A3D1
	mov	di, 5CFAh	;@0A3D2
	stosb	;@0A3D5
@@1:	lodsb	;@0A3D6
	cmp	al, 61h	;@0A3D7
	jb	@@2	;@0A3D9
	cmp	al, 7Ah	;@0A3DB
	ja	@@2	;@0A3DD
	sub	al, 20h	;@0A3DF
@@2:	stosb	;@0A3E1
	loop	@@1	;@0A3E2
	mov	si, 5CFAh	;@0A3E4
@@3:	pop	es	;@0A3E7
	pop	di	;@0A3E8
	pop	cx	;@0A3E9
	pop	ax	;@0A3EA
	ret	;@0A3EB
READ_DEF_FILE:	push	bp	;@0A3EC
	mov	bp, sp	;@0A3ED
	sub	sp, 0Ah	;@0A3EF
	push	ds	;@0A3F2
	push	si	;@0A3F3
	push	di	;@0A3F4
	mov	word ptr [bp-2], 0	;@0A3F5
	mov	word ptr [bp-4], 0	;@0A3FA
	mov	byte ptr [bp-8], 0	;@0A3FF
	mov	word ptr ds:[0B4B1h], sp	;@0A403
	mov	word ptr ds:[0B484h], bx	;@0A407
	xor	ax, ax	;@0A40B
	mov	word ptr ds:[0B4ABh], ax	;@0A40D
	mov	word ptr ds:[0B4AFh], ax	;@0A410
DEF_NEXT_SECTION:	call	DEF_TOKEN	;@0A413
L0A416:	push	ds	;@0A416
	pop	es	;@0A417
	cmp	al, 0	;@0A418
	je	L0A448	;@0A41A
	cmp	al, 1	;@0A41C
	je	DEF_NEXT_SECTION	;@0A41E
	cmp	al, 6	;@0A420
	jb	L0A43B	;@0A422
	push	es	;@0A424
	push	cs	;@0A425
	pop	es	;@0A426
	mov	di, 0A204h	;@0A427
	mov	cx, 0Eh	;@0A42A
@@1:	scasw	;@0A42D
	je	@@2	;@0A42E
	inc	di	;@0A430
	inc	di	;@0A431
	loop	@@1	;@0A432
	pop	es	;@0A434
	jmp	short L0A43B	;@0A435
@@2:	pop	es	;@0A437
	jmp	word ptr cs:[di]	;@0A438
L0A43B:	mov	ax, 0Dh	;@0A43B
L0A43E:	mov	cx, word ptr ds:[0B4B3h]	;@0A43E
	mov	sp, word ptr ds:[0B4B1h]	;@0A442
	jmp	short L0A4A0	;@0A446
L0A448:	mov	bx, 0B48Ah	;@0A448
	cmp	byte ptr [bx], 0	;@0A44B
	je	@@1	;@0A44E
	dec	byte ptr [bx]	;@0A450
@@1:	mov	ax, word ptr [bp-2]	;@0A452
	mov	word ptr ds:[0B4A4h], ax	;@0A455
	sub	ax, word ptr [bp-4]	;@0A458
	mov	word ptr ds:[0B4A6h], ax	;@0A45B
	xor	ax, ax	;@0A45E
	test	word ptr ds:[0B494h], 10h	;@0A460
	jne	@@3	;@0A466
	mov	si, 2	;@0A468
	cmp	byte ptr ds:[0B48Ah], 1	;@0A46B
	je	@@2	;@0A470
	mov	si, 1	;@0A472
@@2:	or	ax, si	;@0A475
@@3:	test	word ptr ds:[0B492h], 20h	;@0A477
	je	@@4	;@0A47D
	or	ax, 2	;@0A47F
	jmp	short @@5	;@0A482
@@4:	test	word ptr ds:[0B492h], 10h	;@0A484
	je	@@5	;@0A48A
	or	ax, 1	;@0A48C
@@5:	mov	word ptr ds:[0B450h], ax	;@0A48F
	mov	al, byte ptr [bp-8]	;@0A492
	cmp	al, 0	;@0A495
	jne	@@6	;@0A497
	mov	al, 1	;@0A499
@@6:	mov	byte ptr ds:[0B4AAh], al	;@0A49B
	xor	ax, ax	;@0A49E
L0A4A0:	pop	di	;@0A4A0
	pop	si	;@0A4A1
	pop	ds	;@0A4A2
	mov	sp, bp	;@0A4A3
	pop	bp	;@0A4A5
	ret	;@0A4A6
L0A4A7:	mov	dx, 547Ah	;@0A4A7
	mov	cx, 800h	;@0A4AA
	mov	bx, word ptr ds:[0B484h]	;@0A4AD
	mov	ah, 3Fh	;@0A4B1
	call	DOS_CALL	;@0A4B3
	cmp	ax, 0FFFFh	;@0A4B6
	je	@@2	;@0A4B9
	mov	si, 547Ah	;@0A4BB
	or	ax, ax	;@0A4BE
	jne	@@1	;@0A4C0
	mov	ax, 1	;@0A4C2
	mov	byte ptr [si], 1Ah	;@0A4C5
@@1:	mov	word ptr ds:[0B486h], si	;@0A4C8
	add	ax, si	;@0A4CC
	mov	word ptr ds:[0B488h], ax	;@0A4CE
	ret	;@0A4D1
@@2:	mov	ax, 0Eh	;@0A4D2
	jmp	L0A43E	;@0A4D5
	db	8Dh, 0A5h, 0A4h, 0A5h, 90h, 0A5h, 98h, 0A5h, 0E3h, 0A5h, 77h, 0A6h	;@0A4D8
	db	0A6h, 0A5h, 0B5h, 0A6h, 0CFh, 0A5h
DEF_CHAR_CLASSES:	add	byte ptr [bx+si], al	;@0A4EA
	add	byte ptr [bx+si], al	;@0A4EC
	add	byte ptr [bx+si], al	;@0A4EE
	add	byte ptr [bx+si], al	;@0A4F0
	add	byte ptr [bp+si], al	;@0A4F2
	add	al, byte ptr [bp+si]	;@0A4F4
	add	al, byte ptr ds:[0]	;@0A4F6
	add	byte ptr [bx+si], al	;@0A4FA
	add	byte ptr [bx+si], al	;@0A4FC
	add	byte ptr [bx+si], al	;@0A4FE
	add	byte ptr [bx+si], al	;@0A500
	add	byte ptr [bx+si], al	;@0A502
	add	al, 0	;@0A504
	add	byte ptr [bx+si], al	;@0A506
	add	byte ptr [bx+si], al	;@0A508
	add	cl, byte ptr [si]	;@0A50A
	push	cs	;@0A50C
	or	al, 0Ah	;@0A50D
	or	al, 0Ch	;@0A50F
	push	cs	;@0A511
	or	al, 0Ch	;@0A512
	or	al, 0Ch	;@0A514
	or	al, 0Ch	;@0A516
	or	al, 0Ch	;@0A518
	or	byte ptr [bx+si], cl	;@0A51A
	or	byte ptr [bx+si], cl	;@0A51C
	or	byte ptr [bx+si], cl	;@0A51E
	or	byte ptr [bx+si], cl	;@0A520
	or	byte ptr [bx+si], cl	;@0A522
	or	al, 10h	;@0A524
	or	al, 0Ch	;@0A526
	or	al, 0Ch	;@0A528
	or	al, 0Ah	;@0A52A
	or	cl, byte ptr [bp+si]	;@0A52C
	or	cl, byte ptr [bp+si]	;@0A52E
	or	cl, byte ptr [bp+si]	;@0A530
	or	cl, byte ptr [bp+si]	;@0A532
	or	cl, byte ptr [bp+si]	;@0A534
	or	cl, byte ptr [bp+si]	;@0A536
	or	cl, byte ptr [bp+si]	;@0A538
	or	cl, byte ptr [bp+si]	;@0A53A
	or	cl, byte ptr [bp+si]	;@0A53C
	or	cl, byte ptr [bp+si]	;@0A53E
	or	cl, byte ptr [bp+si]	;@0A540
	or	cl, byte ptr [bp+si]	;@0A542
	or	cl, byte ptr [si]	;@0A544
	or	al, 0Ch	;@0A546
	or	al, 0Ah	;@0A548
	or	al, 0Ah	;@0A54A
	or	cl, byte ptr [bp+si]	;@0A54C
	or	cl, byte ptr [bp+si]	;@0A54E
	or	cl, byte ptr [bp+si]	;@0A550
	or	cl, byte ptr [bp+si]	;@0A552
	or	cl, byte ptr [bp+si]	;@0A554
	or	cl, byte ptr [bp+si]	;@0A556
	or	cl, byte ptr [bp+si]	;@0A558
	or	cl, byte ptr [bp+si]	;@0A55A
	or	cl, byte ptr [bp+si]	;@0A55C
	or	cl, byte ptr [bp+si]	;@0A55E
	or	cl, byte ptr [bp+si]	;@0A560
	or	cl, byte ptr [bp+si]	;@0A562
	or	cl, byte ptr [si]	;@0A564
	or	al, 0Ch	;@0A566
	or	al, 0Ch	;@0A568
L0A56A:	mov	si, word ptr ds:[0B486h]	;@0A56A
	cmp	si, word ptr ds:[0B488h]	;@0A56E
	jb	@@1	;@0A572
	call	L0A4A7	;@0A574
@@1:	lodsb	;@0A577
	xor	ah, ah	;@0A578
	mov	bx, ax	;@0A57A
	jns	@@2	;@0A57C
	jmp	L0A43B	;@0A57E
@@2:	mov	bl, byte ptr cs:[bx-5B16h]	;@0A581
	xor	bh, bh	;@0A586
	jmp	word ptr cs:[bx-5B28h]	;@0A588
	db	0E9h, 0ABh, 0FEh, 0B8h, 0, 0, 89h, 36h, 86h, 0B4h, 0C3h, 0FFh	;@0A58D
	db	6, 0B3h, 0B4h, 0B8h, 1, 0, 89h, 36h, 86h, 0B4h, 0C3h, 0EBh, 0C8h
	db	'<@t', 9, 8Ah, 0E0h, 0B0h, 5, 89h, 36h, 86h, 0B4h, 0C3h, 'P;6'
	db	88h, 0B4h, 72h, 3, 0E8h, 0EAh, 0FEh, 0ACh, 32h, 0E4h, 8Bh, 0F8h
	db	'NX.', 80h, 0BDh, 0EAh, 0A4h, 0Ah, 75h, 0DEh, 0E9h, 0A8h, 0, 3Bh
	db	36h, 88h, 0B4h, 72h, 3, 0E8h, 0CFh, 0FEh, 0ACh, 3Ch, 0Ah, 74h
	db	0BBh, 3Ch, 1Ah, 74h, 0B7h, 0EBh, 0ECh, 33h, 0DBh, '<0u!S;6', 88h
	db	0B4h, 72h, 3, 0E8h, 0B4h, 0FEh, 0ACh, '[<xtE<XtA2', 0E4h, 8Bh
	db	0F8h, 2Eh, 80h, 0BDh, 0EAh, 0A4h, 8, 'u*N3', 0DBh, 25h, 0Fh, 0
	db	93h, 2Eh, 0F7h, 26h, 0, 0A2h, 72h, 24h, 3, 0D8h, 'r S;6', 88h
	db	0B4h, 72h, 3, 0E8h, 82h, 0FEh, 0ACh, 5Bh, 32h, 0E4h, 8Bh, 0F8h
	db	2Eh, 80h, 0BDh, 0EAh, 0A4h, 8, 74h, 0D9h, 4Eh, 0B0h, 4, 89h, 36h
	db	86h, 0B4h, 0C3h, 0E9h, 0FDh, 0FDh, 3Bh, 36h, 88h, 0B4h, 72h, 3
	db	0E8h, 60h, 0FEh, 0ACh, 0E8h, 0F1h, 0FBh, 72h, 27h, 33h, 0DBh, 93h
	db	2Eh, 0F7h, 26h, 2, 0A2h, 72h, 1Dh, 3, 0D8h, 72h, 19h, 'S;6', 88h
	db	0B4h, 72h, 3, 0E8h, 42h, 0FEh, 0ACh, 5Bh, 0E8h, 0D2h, 0FBh, 73h
	db	0E3h, 4Eh, 0B0h, 4, 89h, 36h, 86h, 0B4h, 0C3h, 0E9h, 0C4h, 0FDh
	db	0BFh, 7Bh, 5Ch, 81h, 0FFh, 0FAh, 5Ch, 73h, 0F4h, 0AAh, 3Bh, 36h
	db	88h, 0B4h, 72h, 3, 0E8h, 1Dh, 0FEh, 0ACh, 32h, 0E4h, 8Bh, 0D8h
	db	2Eh, 80h, 0BFh, 0EAh, 0A4h, 0Ah, 74h, 0E3h, 2Eh, 80h, 0BFh, 0EAh
	db	0A4h, 8, 74h, 0DBh, '<@t', 0D7h, 0BBh, 'z\+', 0FBh, 4Fh, 8Bh, 0C7h
	db	88h, 7, 4Eh, 89h, 36h, 86h, 0B4h, 0B0h, 2, 0C3h, 0BFh, '{\;6'
	db	88h, 0B4h, 72h, 3, 0E8h, 0E6h, 0FDh, 0ACh, 0EBh, 11h, 81h, 0FFh
	db	0FAh, 5Ch, 73h, 27h, 0AAh, 3Bh, 36h, 88h, 0B4h, 72h, 3, 0E8h, 0D3h
	db	0FDh, 0ACh, 3Ch, 27h, 74h, 1Bh, '<"t', 17h, 32h, 0E4h, 8Bh, 0D8h
	db	2Eh, 80h, 0BFh, 0EAh, 0A4h, 4, 74h, 8, 2Eh, 80h, 0BFh, 0EAh, 0A4h
	db	6, 75h, 0D3h, 0E9h, 47h, 0FDh, 46h, 0BBh, 'z\+', 0FBh, 4Fh, 8Bh
	db	0C7h, 88h, 7, 4Eh, 89h, 36h, 86h, 0B4h, 0B0h, 3, 0C3h, 2Fh, 0A8h
	db	0, 0, 0, 0, 0, 0, 35h, 0A8h, 0, 0, 0, 0, 0, 0, 3Ah, 0A8h, 0, 0
	db	0, 0, 0, 0, 3Fh, 0A8h, 0, 0, 0, 0, 0, 0, 4Bh, 0A8h, 7, 0, 0, 1
	db	0, 1, 57h, 0A8h, 8, 0, 1, 0, 3, 0, 5Ch, 0A8h, 5, 0, 4, 0, 0, 0
	db	68h, 0A8h, 5, 0, 4, 0, 4, 0, 74h, 0A8h, 0, 0, 0, 0, 0, 0, 7Ch
	db	0A8h, 0, 0, 0, 0, 0, 0, 84h, 0A8h, 7, 0, 80h, 0, 0, 0, 8Ah, 0A8h
	db	0, 0, 0, 0, 0, 0, 93h, 0A8h, 0, 0, 0, 0, 0, 0, 9Bh, 0A8h, 4, 0
	db	8, 0, 8, 0, 0A0h, 0A8h, 0, 0, 0, 0, 0, 0, 0A8h, 0A8h, 7, 0, 1
	db	0, 0, 0, 0B3h, 0A8h, 7, 0, 80h, 0, 80h, 0, 0BBh, 0A8h, 7, 0, 80h
	db	0, 80h, 0, 0C4h, 0A8h, 2, 0, 30h, 0, 30h, 0, 0CDh, 0A8h, 0, 0
	db	0, 0, 0, 0, 0D2h, 0A8h, 0, 0, 0, 0, 0, 0, 0D9h, 0A8h, 7, 0, 0
	db	1, 0, 0, 0E8h, 0A8h, 2, 0, 30h, 0, 0, 0, 0EDh, 0A8h, 7, 0, 2, 0
	db	0, 0, 0F7h, 0A8h, 8, 0, 1, 0, 1, 0, 0FBh, 0A8h, 7, 0, 1, 0, 1
	db	0, 3, 0A9h, 0, 0, 0, 0, 0, 0, 0Ch, 0A9h, 6, 0, 40h, 0, 0, 0, 15h
	db	0A9h, 6, 0, 40h, 0, 40h, 0, 1Fh, 0A9h, 0, 0, 0, 0, 0, 0, 28h, 0A9h
	db	0, 0, 0, 0, 0, 0, 35h, 0A9h, 0, 0, 0, 0, 0, 0, 3Eh, 0A9h, 7, 0
	db	2, 0, 2, 0, 45h, 0A9h, 2, 0, 30h, 0, 10h, 0, 4Ch, 0A9h, 0, 0, 0
	db	0, 0, 0, 56h, 0A9h, 0, 0, 0, 0, 0, 0, 5Bh, 0A9h, 8, 0, 1, 0, 2
	db	0, 5, 'CLASS', 4, 'CODE', 4, 'DATA', 0Bh, 'DESCRIPTION', 0Bh, 'DISCARDABLE'
	db	4, 'DOS4', 0Bh, 'EXECUTEONLY', 0Bh, 'EXECUTEREAD', 7, 'EXETYPE'
	db	7, 'EXPORTS', 5, 'FIXED', 8, 'HEAPSIZE', 7, 'IMPORTS', 4, 'IOPL'
	db	7, 'LIBRARY', 0Ah, 'LOADONCALL', 7, 'MOVABLE', 8, 'MOVEABLE', 8
	db	'MULTIPLE', 4, 'NAME', 6, 'NODATA', 0Eh, 'NONDISCARDABLE', 4, 'NONE'
	db	9, 'NONSHARED', 3, 'OS2', 7, 'PRELOAD', 8, 'PROTMODE', 8, 'READONLY'
	db	9, 'READWRITE', 8, 'REALMODE', 0Ch, 'RESIDENTNAME', 8, 'SEGMENTS'
	db	6, 'SHARED', 6, 'SINGLE', 9, 'STACKSIZE', 4, 'STUB', 7, 'WINDOWS'
L0A963:	push	ax	;@0A963
	mov	dx, bx	;@0A964
	mov	al, byte ptr [bx]	;@0A966
	xor	ah, ah	;@0A968
	push	cs	;@0A96A
	pop	es	;@0A96B
	mov	bx, 0A707h	;@0A96C
	mov	cx, 25h	;@0A96F
@@1:	mov	di, word ptr es:[bx]	;@0A972
	cmp	al, byte ptr es:[di]	;@0A975
	je	@@4	;@0A978
@@2:	add	bx, 8	;@0A97A
	loop	@@1	;@0A97D
	mov	bx, dx	;@0A97F
	pop	ax	;@0A981
	push	ds	;@0A982
	pop	es	;@0A983
	stc	;@0A984
	ret	;@0A985
@@3:	mov	si, dx	;@0A986
	call	L0A3C5	;@0A988
	inc	si	;@0A98B
	pop	di	;@0A98C
	push	cx	;@0A98D
	mov	cx, ax	;@0A98E
	repe cmpsb	;@0A990
	pop	cx	;@0A992
	jne	@@2	;@0A993
	jmp	short @@5	;@0A995
@@4:	inc	di	;@0A997
	push	di	;@0A998
	push	cx	;@0A999
	mov	si, dx	;@0A99A
	inc	si	;@0A99C
	mov	cx, ax	;@0A99D
	repe cmpsb	;@0A99F
	pop	cx	;@0A9A1
	jne	@@3	;@0A9A2
	add	sp, 2	;@0A9A4
@@5:	add	sp, 2	;@0A9A7
	lea	ax, [bx+2]	;@0A9AA
	sub	bx, 0A707h	;@0A9AD
	shr	bx, 1	;@0A9B1
	shr	bx, 1	;@0A9B3
	shr	bx, 1	;@0A9B5
	add	bx, 6	;@0A9B7
	xchg	ax, bx	;@0A9BA
	push	ds	;@0A9BB
	pop	es	;@0A9BC
	clc	;@0A9BD
	ret	;@0A9BE
	db	0BFh, 7Ah, 52h, 0B9h, 0, 1, 33h, 0C0h, 0F3h, 0ABh, 0C3h, 89h, 1Eh	;@0A9BF
	db	86h, 0B4h, 89h, 1Eh, 88h, 0B4h, 0C7h, 6, 0B3h, 0B4h, 1, 0, 0C3h
L0A9D9:	mov	dx, cx	;@0A9D9
	add	dx, 3	;@0A9DB
	mov	di, dx	;@0A9DE
	push	di	;@0A9E0
	mov	di, 0B468h	;@0A9E1
	call	POOL_ALLOC	;@0A9E4
	jae	@@1	;@0A9E7
	call	L054B0	;@0A9E9
@@1:	xor	ax, ax	;@0A9EC
	stosw	;@0A9EE
	mov	si, bx	;@0A9EF
	mov	bx, di	;@0A9F1
	mov	al, cl	;@0A9F3
	stosb	;@0A9F5
	shr	cx, 1	;@0A9F6
	rep movsw	;@0A9F8
	rcl	cx, 1	;@0A9FA
	rep movsb	;@0A9FC
	push	ds	;@0A9FE
	pop	es	;@0A9FF
	ret	;@0AA00
L0AA01:	mov	al, byte ptr [bx]	;@0AA01
	xor	ah, ah	;@0AA03
	inc	bx	;@0AA05
	push	ax	;@0AA06
	mov	cx, ax	;@0AA07
	mov	si, bx	;@0AA09
	xor	dx, dx	;@0AA0B
	jcxz	@@2	;@0AA0D
@@1:	lodsb	;@0AA0F
	xor	dl, al	;@0AA10
	add	dx, cx	;@0AA12
	rol	dx, 1	;@0AA14
	rol	dx, 1	;@0AA16
	rol	dx, 1	;@0AA18
	loop	@@1	;@0AA1A
@@2:	pop	cx	;@0AA1C
	and	dx, 1FEh	;@0AA1D
	mov	si, dx	;@0AA21
	add	si, 527Ah	;@0AA23
	mov	dx, word ptr [si]	;@0AA27
	and	dx, dx	;@0AA29
	jne	@@3	;@0AA2B
	push	si	;@0AA2D
	call	L0A9D9	;@0AA2E
	pop	si	;@0AA31
	mov	word ptr [si], bx	;@0AA32
	ret	;@0AA34
@@3:	xchg	bx, dx	;@0AA35
	mov	es, word ptr ds:[0B46Ch]	;@0AA37
@@4:	cmp	cl, byte ptr es:[bx]	;@0AA3B
	je	@@6	;@0AA3E
	mov	ax, word ptr es:[bx-2]	;@0AA40
@@5:	and	ax, ax	;@0AA44
	je	@@7	;@0AA46
	mov	bx, ax	;@0AA48
	jmp	@@4	;@0AA4A
@@6:	lea	di, [bx+1]	;@0AA4C
	mov	si, dx	;@0AA4F
	mov	ax, cx	;@0AA51
	repe cmpsb	;@0AA53
	mov	cx, ax	;@0AA55
	mov	ax, word ptr es:[bx-2]	;@0AA57
	jne	@@5	;@0AA5B
	push	ds	;@0AA5D
	pop	es	;@0AA5E
	ret	;@0AA5F
@@7:	push	es	;@0AA60
	push	bx	;@0AA61
	mov	bx, dx	;@0AA62
	call	L0A9D9	;@0AA64
	pop	si	;@0AA67
	pop	es	;@0AA68
	mov	word ptr es:[si-2], bx	;@0AA69
	push	ds	;@0AA6D
	pop	es	;@0AA6E
	ret	;@0AA6F
	db	80h, 3Eh, 8Ah, 0B4h, 0, 75h, 61h, 80h, 3Eh, 2Bh, 1, 2, 74h, 3Eh	;@0AA70
	db	0C6h, 6, 8Ah, 0B4h, 1, 80h, 3Eh, 2Bh, 1, 0, 75h, 32h, 0C6h, 6
	db	2Bh, 1, 3, 50h, 53h, 0B8h, 64h, 6Ch, 0B3h, 6Ch, 0E8h, 9Ch, 0E8h
	db	5Bh, 58h, 0EBh, 1Fh, 80h, 3Eh, 8Ah, 0B4h, 0, 75h, 34h, 80h, 3Eh
	db	2Bh, 1, 3, 74h, 11h, 0C6h, 6, 8Ah, 0B4h, 2, 80h, 3Eh, 2Bh, 1, 0
	db	74h, 5, 0C6h, 6, 2Bh, 1, 2, 0E8h, 0EAh, 0F8h, 3Ch, 2, 75h, 7, 89h
	db	1Eh, 8Ch, 0B4h
@@8:	call	DEF_TOKEN	;@0AAC7
	cmp	al, 0	;@0AACA
	je	@@9	;@0AACC
	cmp	al, 1	;@0AACE
	jne	@@10	;@0AAD0
	jmp	DEF_NEXT_SECTION	;@0AAD2
@@9:	jmp	L0A416	;@0AAD5
@@10:	jmp	L0A43B	;@0AAD8
	db	0E8h, 0CBh, 0F8h, 3Ch, 3, 75h, 0F6h, 89h, 1Eh, 9Ch, 0B4h, 0EBh	;@0AADB
	db	0DFh
	call	DEF_TOKEN	;@0AAE8
	cmp	al, 6	;@0AAEB
	jb	@@10	;@0AAED
	test	byte ptr cs:[bx], 8	;@0AAEF
	je	@@10	;@0AAF3
	mov	ax, word ptr cs:[bx+4]	;@0AAF5
	mov	byte ptr [bp-8], al	;@0AAF9
	jmp	@@8	;@0AAFC
	call	DEF_TOKEN	;@0AAFE
	cmp	al, 2	;@0AB01
	je	@@11	;@0AB03
	cmp	al, 3	;@0AB05
	jne	@@10	;@0AB07
@@11:	mov	word ptr ds:[0B49Ah], bx	;@0AB09
	jmp	@@8	;@0AB0D
	db	0C6h, 6, 8Bh, 0B4h, 1, 0EBh, 0B1h, 0C6h, 6, 8Bh, 0B4h, 0, 0EBh	;@0AB0F
	db	0AAh
@@12:	mov	ax, 10h	;@0AB1D
	jmp	L0A43E	;@0AB20
	db	0B1h, 1, 0BFh, 8Eh, 0B4h, 0BEh, 90h, 0B4h, 0EBh, 8, 0B1h, 2, 0BFh	;@0AB23
	db	92h, 0B4h, 0BEh, 94h, 0B4h
	xor	dx, dx	;@0AB35
	mov	word ptr [bp-6], dx	;@0AB37
@@13:	push	di	;@0AB3A
	push	cx	;@0AB3B
	push	dx	;@0AB3C
	push	si	;@0AB3D
	call	DEF_TOKEN	;@0AB3E
	pop	si	;@0AB41
	pop	dx	;@0AB42
	pop	cx	;@0AB43
	pop	di	;@0AB44
	cmp	al, 0	;@0AB45
	je	@@14	;@0AB47
	cmp	al, 1	;@0AB49
	je	@@14	;@0AB4B
	cmp	al, 6	;@0AB4D
	jb	@@10	;@0AB4F
	test	byte ptr cs:[bx], cl	;@0AB51
	je	@@10	;@0AB54
	mov	ax, word ptr cs:[bx+2]	;@0AB56
	test	word ptr [si], ax	;@0AB5A
	jne	@@12	;@0AB5C
	or	word ptr [si], ax	;@0AB5E
	not	ax	;@0AB60
	and	dx, ax	;@0AB62
	or	dx, word ptr cs:[bx+4]	;@0AB64
	inc	word ptr [bp-6]	;@0AB68
	jmp	@@13	;@0AB6B
@@14:	cmp	word ptr [bp-6], 0	;@0AB6D
	jne	@@15	;@0AB71
	jmp	@@10	;@0AB73
@@15:	mov	word ptr [di], dx	;@0AB76
	jmp	DEF_NEXT_SECTION	;@0AB78
	db	0BFh, 96h, 0B4h, 0EBh, 3, 0BFh, 98h, 0B4h	;@0AB7B
	push	di	;@0AB83
	call	DEF_TOKEN	;@0AB84
	pop	di	;@0AB87
	cmp	al, 4	;@0AB88
	jne	@@20	;@0AB8A
	mov	word ptr [di], bx	;@0AB8C
	jmp	@@8	;@0AB8E
@@16:	jmp	L0A416	;@0AB91
@@17:	call	DEF_TOKEN	;@0AB94
	cmp	al, 0	;@0AB97
	je	@@16	;@0AB99
	cmp	al, 1	;@0AB9B
	je	@@17	;@0AB9D
	cmp	al, 6	;@0AB9F
	jae	@@16	;@0ABA1
	cmp	al, 2	;@0ABA3
	je	@@18	;@0ABA5
	cmp	al, 3	;@0ABA7
	jne	@@20	;@0ABA9
@@18:	mov	di, 0Ch	;@0ABAB
	push	di	;@0ABAE
	mov	di, 0B460h	;@0ABAF
	call	POOL_ALLOC	;@0ABB2
	jae	@@19	;@0ABB5
	call	L054B0	;@0ABB7
@@19:	push	di	;@0ABBA
	mov	cx, 6	;@0ABBB
	xor	ax, ax	;@0ABBE
	rep stosw	;@0ABC0
	pop	di	;@0ABC2
	mov	si, word ptr ds:[0B4ABh]	;@0ABC3
	and	si, si	;@0ABC7
	jne	@@21	;@0ABC9
	mov	word ptr ds:[0B49Eh], di	;@0ABCB
	jmp	short @@22	;@0ABCF
@@20:	jmp	L0A43B	;@0ABD1
@@21:	mov	word ptr es:[si], di	;@0ABD4
@@22:	mov	word ptr ds:[0B4ABh], di	;@0ABD7
	mov	word ptr es:[di+2], bx	;@0ABDB
	call	DEF_TOKEN	;@0ABDF
	cmp	al, 6	;@0ABE2
	jne	@@23	;@0ABE4
	call	DEF_TOKEN	;@0ABE6
	cmp	al, 3	;@0ABE9
	jne	@@20	;@0ABEB
	mov	word ptr es:[di+4], bx	;@0ABED
	call	DEF_TOKEN	;@0ABF1
@@23:	cmp	al, 4	;@0ABF4
	jne	@@24	;@0ABF6
	mov	word ptr es:[di+6], bx	;@0ABF8
	call	DEF_TOKEN	;@0ABFC
@@24:	xor	cx, cx	;@0ABFF
	xor	dx, dx	;@0AC01
@@25:	cmp	al, 0	;@0AC03
	je	@@27	;@0AC05
	cmp	al, 1	;@0AC07
	je	@@27	;@0AC09
	cmp	al, 6	;@0AC0B
	jb	@@20	;@0AC0D
	test	byte ptr cs:[bx], 4	;@0AC0F
	je	@@20	;@0AC13
	mov	ax, word ptr cs:[bx+2]	;@0AC15
	test	cx, ax	;@0AC19
	je	@@26	;@0AC1B
	jmp	@@12	;@0AC1D
@@26:	or	cx, ax	;@0AC20
	not	ax	;@0AC22
	and	dx, ax	;@0AC24
	or	dx, word ptr cs:[bx+4]	;@0AC26
	push	cx	;@0AC2A
	push	dx	;@0AC2B
	call	DEF_TOKEN	;@0AC2C
	pop	dx	;@0AC2F
	pop	cx	;@0AC30
	jmp	@@25	;@0AC31
@@27:	mov	word ptr es:[di+8], cx	;@0AC33
	mov	word ptr es:[di+0Ah], dx	;@0AC37
	jmp	@@17	;@0AC3B
@@28:	jmp	L0A416	;@0AC3E
@@29:	jmp	L0A43B	;@0AC41
@@30:	call	DEF_TOKEN	;@0AC44
@@31:	cmp	al, 0	;@0AC47
	je	@@28	;@0AC49
	cmp	al, 1	;@0AC4B
	je	@@30	;@0AC4D
	cmp	al, 6	;@0AC4F
	jae	@@28	;@0AC51
	cmp	al, 2	;@0AC53
	jne	@@29	;@0AC55
	mov	cx, 0Ah	;@0AC57
	xor	ax, ax	;@0AC5A
	push	ds	;@0AC5C
	pop	es	;@0AC5D
	push	di	;@0AC5E
	mov	di, 0B470h	;@0AC5F
	rep stosb	;@0AC62
	pop	di	;@0AC64
	mov	word ptr ds:[0B472h], bx	;@0AC65
	call	DEF_TOKEN	;@0AC69
	cmp	al, 5	;@0AC6C
	jne	@@32	;@0AC6E
	cmp	ah, 3Dh	;@0AC70
	jne	@@33	;@0AC73
	call	DEF_TOKEN	;@0AC75
	cmp	al, 2	;@0AC78
	jne	@@29	;@0AC7A
	mov	word ptr ds:[0B474h], bx	;@0AC7C
	call	DEF_TOKEN	;@0AC80
@@32:	cmp	al, 5	;@0AC83
	jne	@@34	;@0AC85
@@33:	cmp	ah, 40h	;@0AC87
	jne	@@29	;@0AC8A
	call	DEF_TOKEN	;@0AC8C
	cmp	al, 4	;@0AC8F
	jne	@@29	;@0AC91
	inc	word ptr [bp-4]	;@0AC93
	mov	word ptr ds:[0B476h], bx	;@0AC96
	or	byte ptr ds:[0B478h], 8	;@0AC9A
	call	DEF_TOKEN	;@0AC9F
@@34:	cmp	al, 24h	;@0ACA2
	jne	@@35	;@0ACA4
	or	byte ptr ds:[0B478h], 1	;@0ACA6
	call	DEF_TOKEN	;@0ACAB
@@35:	cmp	al, 1Ah	;@0ACAE
	jne	@@36	;@0ACB0
	or	byte ptr ds:[0B478h], 2	;@0ACB2
	call	DEF_TOKEN	;@0ACB7
@@36:	cmp	al, 4	;@0ACBA
	jne	@@37	;@0ACBC
	cmp	bx, 100h	;@0ACBE
	ja	@@44	;@0ACC2
	mov	byte ptr ds:[0B479h], bl	;@0ACC4
	or	byte ptr ds:[0B478h], 4	;@0ACC8
	call	DEF_TOKEN	;@0ACCD
@@37:	push	ax	;@0ACD0
	cmp	word ptr ds:[0B474h], 0	;@0ACD1
	jne	@@38	;@0ACD6
	mov	ax, word ptr ds:[0B472h]	;@0ACD8
	mov	word ptr ds:[0B474h], ax	;@0ACDB
@@38:	call	L0B8D8	;@0ACDE
	or	ax, ax	;@0ACE1
	jne	@@43	;@0ACE3
	inc	word ptr [bp-2]	;@0ACE5
	push	cx	;@0ACE8
	push	si	;@0ACE9
	mov	di, 0Ah	;@0ACEA
	push	di	;@0ACED
	mov	di, 0B460h	;@0ACEE
	call	POOL_ALLOC	;@0ACF1
	jae	@@39	;@0ACF4
	call	L054B0	;@0ACF6
@@39:	push	di	;@0ACF9
	mov	cx, 5	;@0ACFA
	mov	si, 0B470h	;@0ACFD
	rep movsw	;@0AD00
	pop	di	;@0AD02
	mov	si, word ptr ds:[0B4ADh]	;@0AD03
	and	si, si	;@0AD07
	jne	@@40	;@0AD09
	mov	word ptr ds:[0B4A0h], di	;@0AD0B
	jmp	short @@41	;@0AD0F
@@40:	mov	word ptr es:[si], di	;@0AD11
@@41:	mov	word ptr ds:[0B4ADh], di	;@0AD14
	pop	si	;@0AD18
	pop	cx	;@0AD19
@@42:	pop	ax	;@0AD1A
	jmp	@@31	;@0AD1B
@@43:	call	@@59	;@0AD1E
	jmp	@@42	;@0AD21
@@44:	jmp	L0A43B	;@0AD23
@@45:	jmp	L0A416	;@0AD26
@@46:	call	DEF_TOKEN	;@0AD29
	cmp	al, 0	;@0AD2C
	je	@@45	;@0AD2E
	cmp	al, 1	;@0AD30
	je	@@46	;@0AD32
	cmp	al, 6	;@0AD34
	jae	@@45	;@0AD36
	cmp	al, 2	;@0AD38
	je	@@47	;@0AD3A
	jmp	@@53	;@0AD3C
@@47:	mov	cx, 0Ah	;@0AD3F
	xor	ax, ax	;@0AD42
	push	ds	;@0AD44
	pop	es	;@0AD45
	push	di	;@0AD46
	mov	di, 0B47Ah	;@0AD47
	rep stosb	;@0AD4A
	pop	di	;@0AD4C
	push	bx	;@0AD4D
	call	DEF_TOKEN	;@0AD4E
	pop	dx	;@0AD51
	cmp	al, 5	;@0AD52
	jne	@@48	;@0AD54
	cmp	ah, 3Dh	;@0AD56
	jne	@@48	;@0AD59
	mov	word ptr ds:[0B47Ch], dx	;@0AD5B
	call	DEF_TOKEN	;@0AD5F
	cmp	al, 2	;@0AD62
	jne	@@53	;@0AD64
	push	bx	;@0AD66
	call	DEF_TOKEN	;@0AD67
	pop	dx	;@0AD6A
@@48:	mov	word ptr ds:[0B47Eh], dx	;@0AD6B
	cmp	al, 5	;@0AD6F
	jne	@@53	;@0AD71
	cmp	ah, 2Eh	;@0AD73
	jne	@@53	;@0AD76
	call	DEF_TOKEN	;@0AD78
	cmp	al, 4	;@0AD7B
	je	@@49	;@0AD7D
	cmp	al, 2	;@0AD7F
	jne	@@53	;@0AD81
	mov	word ptr ds:[0B480h], bx	;@0AD83
	jmp	short @@50	;@0AD87
@@49:	cmp	word ptr ds:[0B47Ch], 0	;@0AD89
	je	@@57	;@0AD8E
	mov	word ptr ds:[0B482h], bx	;@0AD90
@@50:	cmp	word ptr ds:[0B47Ch], 0	;@0AD94
	jne	@@51	;@0AD99
	mov	ax, word ptr ds:[0B480h]	;@0AD9B
	mov	word ptr ds:[0B47Ch], ax	;@0AD9E
@@51:	call	L0B90A	;@0ADA1
	or	ax, ax	;@0ADA4
	jne	@@58	;@0ADA6
	mov	di, 0Ah	;@0ADA8
	push	di	;@0ADAB
	mov	di, 0B460h	;@0ADAC
	call	POOL_ALLOC	;@0ADAF
	jae	@@52	;@0ADB2
	call	L054B0	;@0ADB4
@@52:	push	di	;@0ADB7
	mov	si, 0B47Ah	;@0ADB8
	mov	cx, 5	;@0ADBB
	rep movsw	;@0ADBE
	pop	di	;@0ADC0
	mov	si, word ptr ds:[0B4AFh]	;@0ADC1
	and	si, si	;@0ADC5
	jne	@@54	;@0ADC7
	mov	word ptr ds:[0B4A2h], di	;@0ADC9
	jmp	short @@55	;@0ADCD
@@53:	jmp	L0A43B	;@0ADCF
@@54:	mov	word ptr es:[si], di	;@0ADD2
@@55:	mov	word ptr ds:[0B4AFh], di	;@0ADD5
@@56:	call	DEF_TOKEN	;@0ADD9
	jmp	@@46	;@0ADDC
@@57:	mov	ax, 0Fh	;@0ADDF
	jmp	L0A43E	;@0ADE2
@@58:	call	@@59	;@0ADE5
	jmp	@@56	;@0ADE8
@@59:	push	bx	;@0ADEA
	push	si	;@0ADEB
	push	word ptr ds:[0B4B3h]	;@0ADEC
	mov	si, word ptr ds:[140h]	;@0ADF0
	add	si, 2	;@0ADF4
	lds	bx, dword ptr ds:[134h]	;@0ADF7
	mov	ds, word ptr [bx]	;@0ADFB
	push	ds	;@0ADFD
	push	si	;@0ADFE
	mov	ds, word ptr cs:L00100+16	;@0ADFF
	mov	bx, ax	;@0AE04
	mov	ax, 6	;@0AE06
	push	ax	;@0AE09
	mov	ax, bx	;@0AE0A
	push	ax	;@0AE0C
	call	WARNING	;@0AE0D
	pop	si	;@0AE10
	pop	bx	;@0AE11
	ret	;@0AE12
	db	6, 56h, 57h, 0BFh, 0DCh, 7, 0E8h, 0BAh, 0A7h, 8Bh, 36h, 8Ch, 0B4h	;@0AE13
	db	33h, 0C9h, 'SR3', 0D2h, 33h, 0DBh, 0E8h, 21h, 4, 5Ah, 5Bh, 8Bh
	db	1Eh, 0A0h, 0B4h, 0EBh, 30h, 26h, 8Bh, 1Fh, 0EBh, 2Bh, 8Eh, 6, 64h
	db	0B4h, 26h, 8Bh, 77h, 2, 26h, 8Bh, 4Fh, 6, 83h, 0F9h, 0FFh, 74h
	db	0EAh, 26h, 8Ah, 47h, 8, 0A8h, 1, 75h, 4, 0A8h, 8, 75h, 0DEh, 26h
	db	8Bh, 1Fh, 'SR3', 0D2h, 8Bh, 0D8h, 0E8h, 0EBh, 3, 5Ah, 5Bh, 0Bh
	db	0DBh, 75h, 0D1h, 0BFh, 1, 0, 57h, 0BFh, 0DCh, 7, 0E8h, 4Ch, 0A6h
	db	73h, 3, 0E8h, 3Ah, 0A6h, 26h, 0C6h, 5, 0, 8Bh, 0Eh, 0DEh, 7, 5Fh
	db	5Eh, 7, 0C3h
	push	bp	;@0AE82
	mov	bp, sp	;@0AE83
	sub	sp, 14h	;@0AE85
	push	di	;@0AE88
	push	si	;@0AE89
	push	es	;@0AE8A
	push	bx	;@0AE8B
	push	cx	;@0AE8C
	push	dx	;@0AE8D
	mov	byte ptr [bp-14h], 0FFh	;@0AE8E
	mov	di, 7D4h	;@0AE92
	call	NEW_POOL	;@0AE95
	cmp	word ptr ds:[7F8h], -1	;@0AE98
	jne	@@60	;@0AE9D
	mov	di, 7F4h	;@0AE9F
	call	NEW_POOL	;@0AEA2
	jmp	short @@61	;@0AEA5
@@60:	mov	word ptr ds:[7F6h], 0	;@0AEA7
@@61:	mov	si, word ptr ds:[0B4A0h]	;@0AEAD
	mov	es, word ptr ds:[0B464h]	;@0AEB1
	jmp	short @@65	;@0AEB5
@@62:	cmp	word ptr es:[si+6], -1	;@0AEB7
	je	@@64	;@0AEBC
	mov	di, 2	;@0AEBE
	push	di	;@0AEC1
	mov	di, 7F4h	;@0AEC2
	call	POOL_ALLOC	;@0AEC5
	jae	@@63	;@0AEC8
	call	L054B0	;@0AECA
@@63:	mov	word ptr es:[di], si	;@0AECD
@@64:	mov	es, word ptr ds:[0B464h]	;@0AED0
	mov	si, word ptr es:[si]	;@0AED4
@@65:	or	si, si	;@0AED7
	jne	@@62	;@0AED9
	push	bp	;@0AEDB
	mov	bp, 0B5E9h	;@0AEDC
	mov	cx, word ptr ds:[7F6h]	;@0AEDF
	mov	es, word ptr ds:[7F8h]	;@0AEE3
	call	SORT	;@0AEE7
	pop	bp	;@0AEEA
	xor	di, di	;@0AEEB
	mov	word ptr [bp-4], di	;@0AEED
	mov	word ptr [bp-10h], 1	;@0AEF0
	jmp	@@78	;@0AEF5
@@66:	mov	ax, 7	;@0AEF8
	call	L09329	;@0AEFB
@@67:	push	word ptr es:[di+6]	;@0AEFE
	call	DUPLICATE_ORDINAL	;@0AF02
	jmp	@@77	;@0AF05
@@68:	mov	word ptr [bp-0Eh], 1	;@0AF08
	mov	es, word ptr ds:[7F8h]	;@0AF0D
	mov	di, word ptr es:[di]	;@0AF11
	mov	es, word ptr ds:[0B464h]	;@0AF14
	cmp	word ptr es:[di+6], -1	;@0AF18
	jne	@@69	;@0AF1D
	jmp	@@79	;@0AF1F
@@69:	cmp	byte ptr ds:[12Bh], 3	;@0AF22
	jne	@@70	;@0AF27
	test	byte ptr es:[di+8], 2	;@0AF29
	jne	@@70	;@0AF2E
	or	word ptr [bp-0Eh], 2	;@0AF30
@@70:	mov	bx, word ptr es:[di+4]	;@0AF34
	mov	cx, word ptr es:[di+6]	;@0AF38
	mov	dl, byte ptr es:[di+8]	;@0AF3C
	sub	cx, word ptr [bp-10h]	;@0AF40
	jb	@@67	;@0AF43
	je	@@71	;@0AF45
	call	@@107	;@0AF47
@@71:	test	dl, 80h	;@0AF4A
	je	@@74	;@0AF4D
	cmp	bx, -1	;@0AF4F
	je	@@76	;@0AF52
	push	bx	;@0AF54
	and	bx, 3	;@0AF55
	shl	bx, 1	;@0AF58
	shl	bx, 1	;@0AF5A
	shl	bx, 1	;@0AF5C
	mov	es, word ptr [bx+758h]	;@0AF5E
	pop	bx	;@0AF62
	mov	cx, word ptr es:[bx+4]	;@0AF63
	mov	word ptr [bp-8], cx	;@0AF67
	mov	bx, word ptr es:[bx]	;@0AF6A
	cmp	bx, -1	;@0AF6D
	je	@@66	;@0AF70
	mov	es, word ptr ds:[778h]	;@0AF72
	cmp	byte ptr es:[bx+9], 0FFh	;@0AF76
	je	@@77	;@0AF7B
	mov	dx, word ptr es:[bx]	;@0AF7D
	mov	es, word ptr ds:[780h]	;@0AF80
	mov	di, word ptr es:[bx]	;@0AF84
	mov	es, word ptr ds:[7A0h]	;@0AF87
	mov	cx, word ptr es:[di+6]	;@0AF8B
	mov	word ptr [bp-0Ah], cx	;@0AF8F
	mov	byte ptr [bp-12h], 0	;@0AF92
	test	byte ptr es:[di+13h], 1	;@0AF96
	je	@@72	;@0AF9B
	inc	byte ptr [bp-12h]	;@0AF9D
@@72:	call	@@95	;@0AFA0
	jae	@@73	;@0AFA3
	call	@@99	;@0AFA5
@@73:	mov	ax, word ptr [bp-0Eh]	;@0AFA8
	cmp	byte ptr [bp-12h], 0	;@0AFAB
	je	@@75	;@0AFAF
	call	@@105	;@0AFB1
	jmp	short @@76	;@0AFB4
@@74:	jmp	@@109	;@0AFB6
@@75:	call	@@103	;@0AFB9
@@76:	inc	word ptr [bp-10h]	;@0AFBC
@@77:	mov	di, word ptr [bp-4]	;@0AFBF
	add	di, 2	;@0AFC2
	mov	word ptr [bp-4], di	;@0AFC5
@@78:	cmp	di, word ptr ds:[7F6h]	;@0AFC8
	jae	@@79	;@0AFCC
	jmp	@@68	;@0AFCE
@@79:	mov	word ptr ds:[7F6h], 0	;@0AFD1
	cmp	byte ptr ds:[0B48Bh], 1	;@0AFD7
	jne	@@80	;@0AFDC
	jmp	@@92	;@0AFDE
@@80:	push	bx	;@0AFE1
	push	si	;@0AFE2
	xor	di, di	;@0AFE3
	push	di	;@0AFE5
	mov	bx, 754h	;@0AFE6
@@81:	push	di	;@0AFE9
	and	di, 3	;@0AFEA
	shl	di, 1	;@0AFED
	shl	di, 1	;@0AFEF
	shl	di, 1	;@0AFF1
	mov	es, word ptr [di+758h]	;@0AFF3
	pop	di	;@0AFF7
	jmp	short @@85	;@0AFF8
@@82:	push	bx	;@0AFFA
	push	di	;@0AFFB
	and	di, 3	;@0AFFC
	shl	di, 1	;@0AFFF
	shl	di, 1	;@0B001
	shl	di, 1	;@0B003
	mov	es, word ptr [di+758h]	;@0B005
	pop	di	;@0B009
	test	byte ptr es:[di+0Eh], 0A2h	;@0B00A
	jne	@@84	;@0B00F
	mov	ax, word ptr es:[di+4]	;@0B011
	mov	word ptr [bp-8], ax	;@0B015
	mov	ax, word ptr es:[di]	;@0B018
	mov	word ptr [bp-0Ch], ax	;@0B01B
	mov	bx, word ptr es:[di+2]	;@0B01E
	cmp	bx, -1	;@0B022
	je	@@84	;@0B025
	push	bx	;@0B027
	and	bx, 3	;@0B028
	shl	bx, 1	;@0B02B
	shl	bx, 1	;@0B02D
	shl	bx, 1	;@0B02F
	mov	es, word ptr [bx+738h]	;@0B031
	pop	bx	;@0B035
	cmp	word ptr es:[bx+0Ah], 2	;@0B036
	jb	@@84	;@0B03B
	mov	bx, word ptr [bp-0Ch]	;@0B03D
	mov	es, word ptr ds:[780h]	;@0B040
	mov	si, word ptr es:[bx]	;@0B044
	mov	es, word ptr ds:[7A0h]	;@0B047
	mov	ax, word ptr es:[si+6]	;@0B04B
	mov	word ptr [bp-0Ah], ax	;@0B04F
	test	byte ptr es:[si+13h], 1	;@0B052
	je	@@84	;@0B057
	mov	byte ptr [bp-12h], 1	;@0B059
	call	@@95	;@0B05D
	jae	@@83	;@0B060
	call	@@99	;@0B062
@@83:	xor	ax, ax	;@0B065
	call	@@105	;@0B067
@@84:	add	di, word ptr ds:[490h]	;@0B06A
	pop	bx	;@0B06E
@@85:	cmp	di, word ptr [bx+2]	;@0B06F
	jae	@@86	;@0B072
	jmp	@@82	;@0B074
@@86:	cmp	bx, 764h	;@0B076
	ja	@@87	;@0B07A
	add	bx, 8	;@0B07C
	pop	di	;@0B07F
	inc	di	;@0B080
	push	di	;@0B081
	jmp	@@81	;@0B082
@@87:	pop	si	;@0B085
	pop	bx	;@0B086
	xor	di, di	;@0B087
	jmp	short @@91	;@0B089
@@88:	mov	es, word ptr ds:[7A0h]	;@0B08B
	test	byte ptr es:[di+13h], 1	;@0B08F
	je	@@90	;@0B094
	mov	ax, word ptr es:[di+6]	;@0B096
	mov	word ptr [bp-0Ah], ax	;@0B09A
	mov	word ptr [bp-8], 0	;@0B09D
	mov	byte ptr [bp-12h], 1	;@0B0A2
	call	@@95	;@0B0A6
	jae	@@89	;@0B0A9
	call	@@99	;@0B0AB
@@89:	xor	al, al	;@0B0AE
	call	@@105	;@0B0B0
@@90:	add	di, 14h	;@0B0B3
@@91:	cmp	di, word ptr ds:[79Eh]	;@0B0B6
	jb	@@88	;@0B0BA
@@92:	mov	di, 2	;@0B0BC
	push	di	;@0B0BF
	mov	di, 7D4h	;@0B0C0
	call	POOL_ALLOC	;@0B0C3
	jae	@@93	;@0B0C6
	call	L054B0	;@0B0C8
@@93:	mov	word ptr es:[di], 0	;@0B0CB
	mov	ax, word ptr ds:[7D6h]	;@0B0D0
	pop	dx	;@0B0D3
	pop	cx	;@0B0D4
	pop	bx	;@0B0D5
	pop	es	;@0B0D6
	pop	si	;@0B0D7
	pop	di	;@0B0D8
	mov	sp, bp	;@0B0D9
	pop	bp	;@0B0DB
	ret	;@0B0DC
	xor	al, al	;@0B0DD
	and	si, 80h	;@0B0DF
	je	@@94	;@0B0E3
	inc	al	;@0B0E5
@@94:	ret	;@0B0E7
@@95:	push	di	;@0B0E8
	mov	al, byte ptr [bp-14h]	;@0B0E9
	cmp	al, 0FFh	;@0B0EC
	je	@@96	;@0B0EE
	mov	di, word ptr [bp-2]	;@0B0F0
	mov	es, word ptr ds:[7D8h]	;@0B0F3
	cmp	byte ptr es:[di], 0FFh	;@0B0F7
	je	@@96	;@0B0FB
	cmp	al, byte ptr [bp-12h]	;@0B0FD
	jne	@@96	;@0B100
	or	al, al	;@0B102
	jne	@@97	;@0B104
	mov	ax, word ptr [bp-0Ah]	;@0B106
	cmp	ax, word ptr [bp-6]	;@0B109
	je	@@97	;@0B10C
@@96:	stc	;@0B10E
	jmp	short @@98	;@0B10F
@@97:	clc	;@0B111
@@98:	pop	di	;@0B112
	ret	;@0B113
@@99:	push	di	;@0B114
	push	ax	;@0B115
	mov	al, byte ptr [bp-14h]	;@0B116
	cmp	al, 0FFh	;@0B119
	jne	@@100	;@0B11B
@@100:	mov	di, 2	;@0B11D
	push	di	;@0B120
	mov	di, 7D4h	;@0B121
	call	POOL_ALLOC	;@0B124
	jae	@@101	;@0B127
	call	L054B0	;@0B129
@@101:	mov	byte ptr es:[di], 0	;@0B12C
	mov	word ptr [bp-2], di	;@0B130
	mov	al, byte ptr [bp-12h]	;@0B133
	mov	byte ptr [bp-14h], al	;@0B136
	or	al, al	;@0B139
	mov	al, 0FFh	;@0B13B
	jne	@@102	;@0B13D
	xor	ax, ax	;@0B13F
	mov	al, byte ptr [bp-0Ah]	;@0B141
	mov	word ptr [bp-6], ax	;@0B144
@@102:	mov	byte ptr es:[di+1], al	;@0B147
	pop	ax	;@0B14B
	pop	di	;@0B14C
	ret	;@0B14D
@@103:	push	di	;@0B14E
	mov	es, word ptr ds:[7D8h]	;@0B14F
	mov	di, word ptr [bp-2]	;@0B153
	inc	byte ptr es:[di]	;@0B156
	mov	di, 3	;@0B159
	push	di	;@0B15C
	mov	di, 7D4h	;@0B15D
	call	POOL_ALLOC	;@0B160
	jae	@@104	;@0B163
	call	L054B0	;@0B165
@@104:	mov	byte ptr es:[di], al	;@0B168
	mov	ax, word ptr [bp-8]	;@0B16B
	mov	word ptr es:[di+1], ax	;@0B16E
	pop	di	;@0B172
	ret	;@0B173
@@105:	push	di	;@0B174
	inc	word ptr ds:[6CFh]	;@0B175
	mov	es, word ptr ds:[7D8h]	;@0B179
	mov	di, word ptr [bp-2]	;@0B17D
	inc	byte ptr es:[di]	;@0B180
	mov	di, 6	;@0B183
	push	di	;@0B186
	mov	di, 7D4h	;@0B187
	call	POOL_ALLOC	;@0B18A
	jb	@@106	;@0B18D
	mov	byte ptr es:[di], al	;@0B18F
	mov	ax, word ptr cs:L0B2D7+2	;@0B192
	mov	word ptr es:[di+1], ax	;@0B196
	mov	al, byte ptr [bp-0Ah]	;@0B19A
	mov	byte ptr es:[di+3], al	;@0B19D
	mov	ax, word ptr [bp-8]	;@0B1A1
	mov	word ptr es:[di+4], ax	;@0B1A4
	pop	di	;@0B1A8
	ret	;@0B1A9
@@106:	call	L054B0	;@0B1AA
@@107:	push	di	;@0B1AD
	mov	byte ptr [bp-14h], 0FFh	;@0B1AE
	mov	di, 2	;@0B1B2
	push	di	;@0B1B5
	mov	di, 7D4h	;@0B1B6
	call	POOL_ALLOC	;@0B1B9
	jae	@@108	;@0B1BC
	call	L054B0	;@0B1BE
@@108:	mov	byte ptr es:[di], cl	;@0B1C1
	mov	byte ptr es:[di+1], 0	;@0B1C4
	mov	di, word ptr [bp-10h]	;@0B1C9
	add	di, cx	;@0B1CC
	mov	word ptr [bp-10h], di	;@0B1CE
	pop	di	;@0B1D1
	ret	;@0B1D2
@@109:	mov	ax, 5	;@0B1D3
	call	L09329	;@0B1D6
	int	3Fh	;@0B1D9
	push	bx	;@0B1DB
	push	si	;@0B1DC
	push	di	;@0B1DD
	push	es	;@0B1DE
	mov	di, 7E4h	;@0B1DF
	call	NEW_POOL	;@0B1E2
	mov	si, word ptr ds:[0B49Ch]	;@0B1E5
	xor	cx, cx	;@0B1E9
	push	bx	;@0B1EB
	push	dx	;@0B1EC
	xor	dx, dx	;@0B1ED
	xor	bx, bx	;@0B1EF
	call	@@115	;@0B1F1
	pop	dx	;@0B1F4
	pop	bx	;@0B1F5
	mov	bx, word ptr ds:[0B4A0h]	;@0B1F6
	jmp	short @@112	;@0B1FA
@@110:	mov	bx, word ptr es:[bx]	;@0B1FC
	jmp	short @@112	;@0B1FF
@@111:	mov	es, word ptr ds:[0B464h]	;@0B201
	mov	si, word ptr es:[bx+2]	;@0B205
	mov	cx, word ptr es:[bx+6]	;@0B209
	cmp	cx, -1	;@0B20D
	je	@@110	;@0B210
	mov	al, byte ptr es:[bx+8]	;@0B212
	test	al, 8	;@0B216
	je	@@110	;@0B218
	test	al, 1	;@0B21A
	jne	@@110	;@0B21C
	mov	bx, word ptr es:[bx]	;@0B21E
	push	bx	;@0B221
	push	dx	;@0B222
	xor	dx, dx	;@0B223
	mov	bx, ax	;@0B225
	call	@@115	;@0B227
	pop	dx	;@0B22A
	pop	bx	;@0B22B
@@112:	or	bx, bx	;@0B22C
	jne	@@111	;@0B22E
	mov	di, 1	;@0B230
	push	di	;@0B233
	mov	di, 7E4h	;@0B234
	call	POOL_ALLOC	;@0B237
	jae	@@113	;@0B23A
	call	L054B0	;@0B23C
@@113:	mov	byte ptr es:[di], 0	;@0B23F
	mov	cx, word ptr ds:[7E6h]	;@0B243
	pop	es	;@0B247
	pop	di	;@0B248
	pop	si	;@0B249
	pop	bx	;@0B24A
	ret	;@0B24B
	push	cx	;@0B24C
	push	si	;@0B24D
	push	di	;@0B24E
	push	cx	;@0B24F
	call	@@117	;@0B250
	push	cx	;@0B253
	add	cx, 2	;@0B254
	mov	di, cx	;@0B257
	push	di	;@0B259
	mov	di, 7DCh	;@0B25A
	call	POOL_ALLOC	;@0B25D
	jae	@@114	;@0B260
	call	L054B0	;@0B262
@@114:	mov	si, 562h	;@0B265
	pop	cx	;@0B268
	rep movsb	;@0B269
	pop	cx	;@0B26B
	mov	word ptr es:[di], cx	;@0B26C
	pop	di	;@0B26F
	pop	si	;@0B270
	pop	cx	;@0B271
	ret	;@0B272
@@115:	push	si	;@0B273
	push	di	;@0B274
	push	cx	;@0B275
	push	cx	;@0B276
	call	@@117	;@0B277
	push	cx	;@0B27A
	add	cx, 2	;@0B27B
	mov	di, cx	;@0B27E
	push	di	;@0B280
	mov	di, 7E4h	;@0B281
	call	POOL_ALLOC	;@0B284
	jae	@@116	;@0B287
	call	L054B0	;@0B289
@@116:	mov	si, 562h	;@0B28C
	pop	cx	;@0B28F
	rep movsb	;@0B290
	pop	cx	;@0B292
	mov	word ptr es:[di], cx	;@0B293
	pop	cx	;@0B296
	pop	di	;@0B297
	pop	si	;@0B298
	ret	;@0B299
@@117:	test	bl, 80h	;@0B29A
	jne	L0B2CD	;@0B29D
	mov	es, word ptr ds:[0B46Ch]	;@0B29F
L0B2A3:	xor	cx, cx	;@0B2A3
	mov	cl, byte ptr es:[si]	;@0B2A5
	inc	cl	;@0B2A8
	push	cx	;@0B2AA
	mov	di, 562h	;@0B2AB
	push	ds	;@0B2AE
	push	ds	;@0B2AF
	push	es	;@0B2B0
	pop	ds	;@0B2B1
	pop	es	;@0B2B2
	lodsb	;@0B2B3
	stosb	;@0B2B4
@@1:	dec	cx	;@0B2B5
	jcxz	@@3	;@0B2B6
	lodsb	;@0B2B8
	or	dx, dx	;@0B2B9
	je	@@2	;@0B2BB
	cmp	al, 61h	;@0B2BD
	jb	@@2	;@0B2BF
	cmp	al, 7Ah	;@0B2C1
	ja	@@2	;@0B2C3
	sub	al, 20h	;@0B2C5
@@2:	stosb	;@0B2C7
	jmp	@@1	;@0B2C8
@@3:	pop	ds	;@0B2CA
	pop	cx	;@0B2CB
	ret	;@0B2CC
L0B2CD:	push	si	;@0B2CD
	and	si, 3	;@0B2CE
	shl	si, 1	;@0B2D1
	shl	si, 1	;@0B2D3
	shl	si, 1	;@0B2D5
L0B2D7:	mov	es, word ptr [si+718h]	;@0B2D7
	pop	si	;@0B2DB
	inc	si	;@0B2DC
	inc	si	;@0B2DD
	jmp	L0B2A3	;@0B2DE
L0B2E0:	push	si	;@0B2E0
	push	bx	;@0B2E1
	push	cx	;@0B2E2
	push	dx	;@0B2E3
	xor	si, si	;@0B2E4
	mov	cx, word ptr ds:[7DEh]	;@0B2E6
	mov	ax, word ptr ds:[0B452h]	;@0B2EA
	add	ax, word ptr ds:[6C5h]	;@0B2ED
	xor	dx, dx	;@0B2F1
	mov	bx, 7E0h	;@0B2F3
	call	L08905	;@0B2F6
	pop	dx	;@0B2F9
	pop	cx	;@0B2FA
	pop	bx	;@0B2FB
	pop	si	;@0B2FC
	ret	;@0B2FD
L0B2FE:	push	si	;@0B2FE
	push	bx	;@0B2FF
	push	cx	;@0B300
	push	dx	;@0B301
	xor	si, si	;@0B302
	mov	cx, word ptr ds:[7E6h]	;@0B304
	mov	ax, word ptr ds:[6CBh]	;@0B308
	xor	dx, dx	;@0B30B
	mov	bx, 7E8h	;@0B30D
	call	L08905	;@0B310
	pop	dx	;@0B313
	pop	cx	;@0B314
	pop	bx	;@0B315
	pop	si	;@0B316
	ret	;@0B317
L0B318:	push	si	;@0B318
	push	bx	;@0B319
	push	cx	;@0B31A
	push	dx	;@0B31B
	xor	si, si	;@0B31C
	mov	cx, word ptr ds:[7D6h]	;@0B31E
	mov	ax, word ptr ds:[0B452h]	;@0B322
	add	ax, word ptr ds:[6A3h]	;@0B325
	xor	dx, dx	;@0B329
	mov	bx, 7D8h	;@0B32B
	call	L08905	;@0B32E
	pop	dx	;@0B331
	pop	cx	;@0B332
	pop	bx	;@0B333
	pop	si	;@0B334
	ret	;@0B335
	db	0A1h, 96h, 0B4h, 8Bh, 1Eh, 98h, 0B4h, 0C3h, 33h, 0F6h, 8Eh, 6	;@0B336
	db	78h, 7, 0EBh, 0Eh, 26h, 3Bh, 1Ch, 75h, 6, '&;L', 2, 74h, 0Ch, 83h
	db	0C6h, 0Ah, ';6v', 7, 72h, 0ECh, 0F9h, 0EBh, 1, 0F8h, 0C3h
@@1:	test	cx, ax	;@0B35F
	je	@@3	;@0B361
	test	dx, ax	;@0B363
	jne	@@2	;@0B365
	not	si	;@0B367
	and	bx, si	;@0B369
	jmp	short @@3	;@0B36B
@@2:	or	bx, si	;@0B36D
@@3:	ret	;@0B36F
	push	bx	;@0B370
	push	si	;@0B371
	xor	bx, bx	;@0B372
	mov	bl, al	;@0B374
	mov	ax, 80h	;@0B376
	mov	si, 1	;@0B379
	call	@@1	;@0B37C
	mov	ax, 2	;@0B37F
	mov	si, 2	;@0B382
	call	@@1	;@0B385
	mov	ax, 1	;@0B388
	mov	si, 4	;@0B38B
	call	@@1	;@0B38E
	mov	ax, 100h	;@0B391
	mov	si, 10h	;@0B394
	call	@@1	;@0B397
	mov	ax, 100h	;@0B39A
	mov	si, 1	;@0B39D
	call	@@1	;@0B3A0
	mov	al, bl	;@0B3A3
	pop	si	;@0B3A5
	pop	bx	;@0B3A6
	ret	;@0B3A7
	db	'WVSQR', 0A1h, 8Eh, 0B4h, 0Bh, 6, 92h, 0B4h, 'tm3', 0FFh, 8Eh	;@0B3A8
	db	6, 0A0h, 7, 0EBh, 5Fh, 8Bh, 36h, 8Eh, 0B4h, 26h, 80h, 7Dh, 1, 1
	db	74h, 4, 8Bh, 36h, 92h, 0B4h, 0F7h, 0C6h, 80h, 0, 74h, 5, 26h, 80h
	db	4Dh, 13h, 1, 0F7h, 0C6h, 2, 0, 74h, 5, 26h, 80h, 4Dh, 13h, 2, 0F7h
	db	0C6h, 20h, 0, 75h, 0Bh, 0F7h, 0C6h, 10h, 0, 74h, 5, 26h, 80h, 4Dh
	db	13h, 2, 0F7h, 0C6h, 1, 0, 74h, 5, 26h, 80h, 4Dh, 13h, 4, 0F7h
	db	0C6h, 4, 0, 74h, 5, 26h, 80h, 4Dh, 13h, 8, 0F7h, 0C6h, 0, 1, 74h
	db	0Ah, 26h, 80h, 4Dh, 13h, 10h, 26h, 80h, 4Dh, 13h, 1, 83h, 0C7h
	db	14h, 3Bh, 3Eh, 9Eh, 7, 72h, 9Bh, 0A0h, 'vRP', 0C6h, 6, 76h, 52h
	db	2, 8Bh, 3Eh, 9Eh, 0B4h, 8Eh, 6, 64h, 0B4h, 0EBh, 61h, 26h, 8Bh
	db	75h, 2, 26h, 0FFh, 75h, 8, 26h, 0FFh, 75h, 0Ah, 26h, 0FFh, 75h
	db	4, 8Eh, 6, 6Ch, 0B4h, 0B4h, 80h, 8Ch, 6, 50h, 52h, 0E8h, 0C7h
	db	0D9h, 5Eh, 53h, 8Bh, 1Eh, 4Ch, 4, 83h, 0FEh, 0, 74h, 0Dh, 8Eh
	db	6, 6Ch, 0B4h, 0B4h, 80h, 8Ch, 6, 50h, 52h, 0E8h, 0AFh, 0D9h, 8Bh
	db	0CBh, 5Bh, 0E8h, 0CDh, 0FEh, 'ZYr', 1Bh, 8Eh, 6, 80h, 7, 26h, 8Bh
	db	34h, 83h, 0FEh, 0FFh, 74h, 0Fh, 8Eh, 6, 0A0h, 7, 26h, 8Ah, 44h
	db	13h, 0E8h, 0E4h, 0FEh, 26h, 88h, 44h, 13h, 8Eh, 6, 64h, 0B4h, 26h
	db	8Bh, 3Dh, 0Bh, 0FFh, 75h, 9Bh, 58h, 0A2h, 'vRZY[^_', 0C3h, 55h
	db	8Bh, 0ECh, 8Dh, 66h, 0FEh, 'PVQ', 83h, 3Eh, 0A6h, 0B4h, 0, 75h
	db	7, 'Y^X', 8Bh, 0E5h, 5Dh, 0C3h, 0A1h, 0A4h, 0B4h, 2Bh, 6, 0A6h
	db	0B4h, 75h, 22h, 8Bh, 36h, 0A0h, 0B4h, 0B9h, 1, 0, 0EBh, 13h, 8Eh
	db	6, 64h, 0B4h, 26h, 83h, 7Ch, 6, 0FFh, 74h, 5, 26h, 89h, 4Ch, 6
	db	41h, 26h, 8Bh, 34h, 0Bh, 0F6h, 75h, 0E9h, 0EBh, 0CEh, 0BFh, 0F4h
	db	7, 0E8h, 0E9h, 0A0h, 0B9h, 1, 0, 8Bh, 36h, 0A0h, 0B4h, 8Eh, 6
	db	64h, 0B4h, 0EBh, 19h, 26h, 0F6h, 44h, 8, 8, 74h, 0Fh, 26h, 8Bh
	db	44h, 6, 3Dh, 0FFh, 0FFh, 74h, 6, 3Bh, 0C1h, 72h, 2, 8Bh, 0C8h
	db	26h, 8Bh, 34h, 0Bh, 0F6h, 75h, 0E3h, 3, 0Eh, 0A6h, 0B4h, 83h, 0C1h
	db	8, 0D1h, 0E9h, 0D1h, 0E9h, 0D1h, 0E9h, 8Bh, 0F9h, 57h, 0BFh, 0F4h
	db	7, 0E8h, 90h, 9Fh, 73h, 3, 0E8h, 7Eh, 9Fh, 89h, 7Eh, 0FEh, 32h
	db	0C0h, 0FCh, 0F3h, 0AAh, 8Bh, 7Eh, 0FEh, 8Bh, 36h, 0A0h, 0B4h, 0EBh
	db	2Fh, 8Eh, 6, 64h, 0B4h, 26h, 0F6h, 44h, 8, 8, 't!&', 8Bh, 44h
	db	6, 3Dh, 0FFh, 0FFh, 74h, 18h, 48h, 8Eh, 6, 0F8h, 7, 8Bh, 7Eh, 0FEh
	db	8Bh, 0Eh, 0F6h, 7, 0E8h, 0C8h, 0, 75h, 4Bh, 0E8h, 0B2h, 0, 8Eh
	db	6, 64h, 0B4h, 26h, 8Bh, 34h, 0Bh, 0F6h, 75h, 0CDh, 8Bh, 36h, 0A0h
	db	0B4h, 0EBh, 30h, 26h, 0F6h, 44h, 8, 8, 'u&&', 83h, 7Ch, 6, 0FFh
	db	74h, 1Fh, 8Eh, 6, 0F8h, 7, 8Bh, 7Eh, 0FEh, 8Bh, 0Eh, 0F6h, 7, 0E8h
	db	0A7h, 0, 3Dh, 0FFh, 0FFh, 74h, 23h, 0E8h, 7Dh, 0, 40h, 8Eh, 6
	db	64h, 0B4h, 26h, 89h, 44h, 6, 26h, 8Bh, 34h, 0Bh, 0F6h, 75h, 0CCh
	db	0E9h, 2, 0FFh, 8Eh, 6, 64h, 0B4h, 26h, 0FFh, 74h, 6, 0E8h, 8, 0
	db	0EBh, 0ABh, 0B8h, 8, 0, 0E8h, 63h, 0DDh
DUPLICATE_ORDINAL:	push	bp	;@0B5C6
	mov	bp, sp	;@0B5C7
	push	ax	;@0B5C9
	push	bx	;@0B5CA
	push	cx	;@0B5CB
	push	dx	;@0B5CC
	push	si	;@0B5CD
	push	di	;@0B5CE
	push	word ptr [bp+4]	;@0B5CF
	mov	ax, 2	;@0B5D2
	push	ax	;@0B5D5
	mov	ax, 3Dh	;@0B5D6
	push	ax	;@0B5D9
	call	WARNING	;@0B5DA
	pop	di	;@0B5DD
	pop	si	;@0B5DE
	pop	dx	;@0B5DF
	pop	cx	;@0B5E0
	pop	bx	;@0B5E1
	pop	ax	;@0B5E2
	mov	sp, bp	;@0B5E3
	pop	bp	;@0B5E5
	ret	2	;@0B5E6
	db	53h, 50h, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 5Ch, 6, '&;]', 6, 7Fh, 3	;@0B5E9
	db	0F9h, 0EBh, 1, 0F8h, 9Fh, 8Eh, 6, 0F8h, 7, 9Eh, 58h, 5Bh, 0C3h
@@1:	push	dx	;@0B606
	mov	cx, ax	;@0B607
	shr	ax, 1	;@0B609
	shr	ax, 1	;@0B60B
	shr	ax, 1	;@0B60D
	mov	dx, ax	;@0B60F
	shl	ax, 1	;@0B611
	shl	ax, 1	;@0B613
	shl	ax, 1	;@0B615
	sub	cx, ax	;@0B617
	add	di, dx	;@0B619
	pop	dx	;@0B61B
	ret	;@0B61C
	push	ax	;@0B61D
	push	cx	;@0B61E
	push	di	;@0B61F
	call	@@1	;@0B620
	mov	al, 80h	;@0B623
	shr	al, cl	;@0B625
	or	byte ptr es:[di], al	;@0B627
	pop	di	;@0B62A
	pop	cx	;@0B62B
	pop	ax	;@0B62C
	ret	;@0B62D
	push	ax	;@0B62E
	push	cx	;@0B62F
	push	di	;@0B630
	call	@@1	;@0B631
	mov	al, 80h	;@0B634
	shr	al, cl	;@0B636
	test	byte ptr es:[di], al	;@0B638
	pop	di	;@0B63B
	pop	cx	;@0B63C
	pop	ax	;@0B63D
	ret	;@0B63E
	push	es	;@0B63F
	push	di	;@0B640
	push	bx	;@0B641
	push	cx	;@0B642
	push	cx	;@0B643
	mov	al, 0FFh	;@0B644
	cld	;@0B646
	repe scasb	;@0B647
	je	@@3	;@0B649
	pop	bx	;@0B64B
	sub	bx, cx	;@0B64C
	dec	bx	;@0B64E
	shl	bx, 1	;@0B64F
	shl	bx, 1	;@0B651
	shl	bx, 1	;@0B653
	mov	al, byte ptr es:[di-1]	;@0B655
	xor	cx, cx	;@0B659
@@2:	shl	al, 1	;@0B65B
	jae	@@4	;@0B65D
	inc	cx	;@0B65F
	jmp	@@2	;@0B660
@@3:	add	sp, 2	;@0B662
	mov	ax, 0FFFFh	;@0B665
	jmp	short @@5	;@0B668
@@4:	add	bx, cx	;@0B66A
	mov	ax, bx	;@0B66C
@@5:	pop	cx	;@0B66E
	pop	bx	;@0B66F
	pop	di	;@0B670
	pop	es	;@0B671
	ret	;@0B672
L0B673:	push	bp	;@0B673
	mov	bp, sp	;@0B674
	lea	sp, [bp-0Ah]	;@0B676
	push	bx	;@0B679
	push	cx	;@0B67A
	push	dx	;@0B67B
	push	si	;@0B67C
	mov	ax, word ptr es:[bx+6]	;@0B67D
	mov	word ptr [bp-2], ax	;@0B681
	mov	word ptr [bp-4], cx	;@0B684
	xor	ax, ax	;@0B687
	mov	byte ptr [bp-0Ah], al	;@0B689
	inc	ax	;@0B68C
	mov	word ptr [bp-8], ax	;@0B68D
	test	byte ptr es:[bx+13h], 1	;@0B690
	je	@@1	;@0B695
	dec	byte ptr [bp-0Ah]	;@0B697
@@1:	mov	es, word ptr ds:[7D8h]	;@0B69A
	xor	si, si	;@0B69E
	mov	word ptr [bp-6], si	;@0B6A0
	cmp	byte ptr es:[si], 0	;@0B6A3
	je	@@4	;@0B6A7
@@2:	call	@@6	;@0B6A9
	jb	@@3	;@0B6AC
	call	@@11	;@0B6AE
	jae	@@5	;@0B6B1
@@3:	call	@@19	;@0B6B3
	jb	@@4	;@0B6B6
	jmp	@@2	;@0B6B8
@@4:	mov	ax, 0FFFFh	;@0B6BA
@@5:	pop	si	;@0B6BD
	pop	dx	;@0B6BE
	pop	cx	;@0B6BF
	pop	bx	;@0B6C0
	mov	sp, bp	;@0B6C1
	pop	bp	;@0B6C3
	ret	;@0B6C4
@@6:	cmp	byte ptr [bp-0Ah], 0	;@0B6C5
	jne	@@8	;@0B6C9
	mov	si, word ptr [bp-6]	;@0B6CB
	xor	ax, ax	;@0B6CE
	mov	al, byte ptr es:[si+1]	;@0B6D0
	cmp	al, 0FFh	;@0B6D4
	je	@@9	;@0B6D6
	cmp	ax, word ptr [bp-2]	;@0B6D8
	jne	@@9	;@0B6DB
@@7:	clc	;@0B6DD
	jmp	short @@10	;@0B6DE
@@8:	cmp	byte ptr es:[si+1], 0FFh	;@0B6E0
	je	@@7	;@0B6E5
@@9:	stc	;@0B6E7
@@10:	ret	;@0B6E8
@@11:	mov	si, word ptr [bp-6]	;@0B6E9
	xor	cx, cx	;@0B6EC
	mov	cl, byte ptr es:[si]	;@0B6EE
	mov	dx, word ptr [bp-4]	;@0B6F1
	cmp	byte ptr es:[si+1], 0FFh	;@0B6F4
	je	@@13	;@0B6F9
	add	si, 2	;@0B6FB
@@12:	cmp	word ptr es:[si+1], dx	;@0B6FE
	je	@@17	;@0B702
	add	si, 3	;@0B704
	dec	cx	;@0B707
	jne	@@12	;@0B708
	jmp	short @@16	;@0B70A
@@13:	add	si, 2	;@0B70C
	mov	ax, word ptr [bp-2]	;@0B70F
@@14:	cmp	byte ptr es:[si+3], al	;@0B712
	jne	@@15	;@0B716
	cmp	word ptr es:[si+4], dx	;@0B718
	je	@@17	;@0B71C
@@15:	add	si, 6	;@0B71E
	dec	cx	;@0B721
	jne	@@14	;@0B722
@@16:	mov	ax, 0FFFFh	;@0B724
	stc	;@0B727
	jmp	short @@18	;@0B728
@@17:	mov	ax, word ptr [bp-8]	;@0B72A
	mov	si, word ptr [bp-6]	;@0B72D
	xor	bx, bx	;@0B730
	mov	bl, byte ptr es:[si]	;@0B732
	add	ax, bx	;@0B735
	sub	ax, cx	;@0B737
	clc	;@0B739
@@18:	ret	;@0B73A
@@19:	mov	si, word ptr [bp-6]	;@0B73B
	xor	cx, cx	;@0B73E
	mov	cl, byte ptr es:[si]	;@0B740
	add	word ptr [bp-8], cx	;@0B743
	mov	ax, 6	;@0B746
	cmp	byte ptr es:[si+1], 0FFh	;@0B749
	je	@@20	;@0B74E
	xor	ax, ax	;@0B750
	cmp	byte ptr es:[si+1], 0	;@0B752
	je	@@20	;@0B757
	mov	ax, 3	;@0B759
@@20:	mul	cx	;@0B75C
	add	si, 2	;@0B75E
	add	si, ax	;@0B761
	mov	word ptr [bp-6], si	;@0B763
	cmp	byte ptr es:[si], 0	;@0B766
	je	@@21	;@0B76A
	clc	;@0B76C
	jmp	short @@22	;@0B76D
@@21:	stc	;@0B76F
@@22:	ret	;@0B770
	db	55h, 8Bh, 0ECh, 'WSR', 8Bh, 3Eh, 0A2h, 0B4h, 0E9h, 82h, 0, 8Eh	;@0B771
	db	6, 64h, 0B4h, 26h, 8Bh, 75h, 4, 26h, 8Bh, 55h, 8, 89h, 16h, 0E3h
	db	6, 8Eh, 6, 6Ch, 0B4h, 32h, 0E4h, 8Ch, 6, 50h, 52h, 0E8h, 7Fh, 0D6h
	db	89h, 1Eh, 0E1h, 6, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 75h, 6, 0Bh, 0F6h
	db	74h, 13h, 8Eh, 6, 6Ch, 0B4h, 32h, 0E4h, 57h, 8Ch, 6, 50h, 52h
	db	0E8h, 61h, 0D6h, 5Fh, 89h, 1Eh, 0DFh, 6, 8Eh, 6, 64h, 0B4h, 26h
	db	8Bh, 75h, 2, 8Eh, 6, 6Ch, 0B4h, 33h, 0C0h, 80h, 3Eh, 29h, 1, 0
	db	74h, 1, 40h, 0FFh, 36h, 22h, 1, 0A2h, 22h, 1, 57h, 32h, 0E4h, 8Ch
	db	6, 50h, 52h, 0E8h, 35h, 0D6h, 5Fh, 58h, 0A2h, 22h, 1, 89h, 1Eh
	db	0E7h, 6, 0C7h, 6, 0E5h, 6, 0, 0, 57h, 0E8h, 16h, 0, 5Fh, 8Eh, 6
	db	64h, 0B4h, 26h, 8Bh, 3Dh, 0Bh, 0FFh, 74h, 3, 0E9h, 77h, 0FFh, 'Z[_'
	db	8Bh, 0E5h, 5Dh, 0C3h
L0B80E:	push	bx	;@0B80E
	mov	di, 0Ch	;@0B80F
	push	di	;@0B812
	mov	di, 804h	;@0B813
	call	POOL_ALLOC	;@0B816
	jae	@@1	;@0B819
	call	L054B0	;@0B81B
@@1:	push	di	;@0B81E
	mov	si, 6DFh	;@0B81F
	mov	cx, 0Ch	;@0B822
	shr	cx, 1	;@0B825
	rep movsw	;@0B827
	rcl	cx, 1	;@0B829
	rep movsb	;@0B82B
	mov	bx, word ptr ds:[6E7h]	;@0B82D
	push	bx	;@0B831
	and	bx, 3	;@0B832
	shl	bx, 1	;@0B835
	shl	bx, 1	;@0B837
	shl	bx, 1	;@0B839
	mov	es, word ptr [bx+718h]	;@0B83B
	pop	bx	;@0B83F
	cmp	word ptr es:[bx], -1	;@0B840
	jne	@@2	;@0B844
	call	L017A8	;@0B846
	mov	word ptr es:[di], 0	;@0B849
	pop	word ptr es:[di+2]	;@0B84E
	mov	word ptr es:[di+0Ch], bx	;@0B852
	mov	byte ptr es:[di+0Eh], 20h	;@0B856
	push	bx	;@0B85B
	and	bx, 3	;@0B85C
	shl	bx, 1	;@0B85F
	shl	bx, 1	;@0B861
	shl	bx, 1	;@0B863
	mov	es, word ptr [bx+718h]	;@0B865
	pop	bx	;@0B869
	mov	word ptr es:[bx], di	;@0B86A
	jmp	short @@3	;@0B86D
@@2:	mov	di, word ptr es:[bx]	;@0B86F
	push	di	;@0B872
	and	di, 3	;@0B873
	shl	di, 1	;@0B876
	shl	di, 1	;@0B878
	shl	di, 1	;@0B87A
	mov	es, word ptr [di+758h]	;@0B87C
	pop	di	;@0B880
	test	byte ptr es:[di+0Eh], 10h	;@0B881
	je	@@4	;@0B886
	pop	word ptr es:[di+2]	;@0B888
	or	byte ptr es:[di+0Eh], 20h	;@0B88C
	and	byte ptr es:[di+0Eh], 0EFh	;@0B891
@@3:	pop	bx	;@0B896
	ret	;@0B897
@@4:	add	sp, 2	;@0B898
	jmp	@@3	;@0B89B
	db	0A0h, 0AAh, 0B4h, 0C3h, 3Bh, 0F7h, 0C3h	;@0B89D
L0B8A4:	push	ax	;@0B8A4
	push	cx	;@0B8A5
	push	si	;@0B8A6
	mov	di, 0Ah	;@0B8A7
	push	di	;@0B8AA
	mov	di, 0B460h	;@0B8AB
	call	POOL_ALLOC	;@0B8AE
	jae	@@1	;@0B8B1
	call	L054B0	;@0B8B3
@@1:	push	di	;@0B8B6
	mov	cx, 5	;@0B8B7
	xor	ax, ax	;@0B8BA
	rep stosw	;@0B8BC
	pop	di	;@0B8BE
	mov	si, word ptr ds:[0B4ADh]	;@0B8BF
	and	si, si	;@0B8C3
	jne	@@2	;@0B8C5
	mov	word ptr ds:[0B4A0h], di	;@0B8C7
	jmp	short @@3	;@0B8CB
@@2:	mov	word ptr es:[si], di	;@0B8CD
@@3:	mov	word ptr ds:[0B4ADh], di	;@0B8D0
	pop	si	;@0B8D4
	pop	cx	;@0B8D5
	pop	ax	;@0B8D6
	ret	;@0B8D7
L0B8D8:	push	bx	;@0B8D8
	push	si	;@0B8D9
	mov	si, word ptr ds:[0B4A0h]	;@0B8DA
	mov	es, word ptr ds:[0B464h]	;@0B8DE
	jmp	short @@2	;@0B8E2
@@1:	mov	ax, 3Fh	;@0B8E4
	mov	bx, word ptr es:[si+4]	;@0B8E7
	cmp	bx, word ptr ds:[0B474h]	;@0B8EB
	je	@@3	;@0B8EF
	mov	ax, 3Eh	;@0B8F1
	mov	bx, word ptr es:[si+2]	;@0B8F4
	cmp	bx, word ptr ds:[0B472h]	;@0B8F8
	je	@@3	;@0B8FC
	mov	si, word ptr es:[si]	;@0B8FE
@@2:	or	si, si	;@0B901
	jne	@@1	;@0B903
	xor	ax, ax	;@0B905
@@3:	pop	si	;@0B907
	pop	bx	;@0B908
	ret	;@0B909
L0B90A:	push	bx	;@0B90A
	push	si	;@0B90B
	mov	si, word ptr ds:[0B4A2h]	;@0B90C
	mov	es, word ptr ds:[0B464h]	;@0B910
	jmp	short @@2	;@0B914
@@1:	mov	ax, 40h	;@0B916
	mov	bx, word ptr es:[si+2]	;@0B919
	cmp	bx, word ptr ds:[0B47Ch]	;@0B91D
	je	@@3	;@0B921
	mov	si, word ptr es:[si]	;@0B923
@@2:	or	si, si	;@0B926
	jne	@@1	;@0B928
	xor	ax, ax	;@0B92A
@@3:	pop	si	;@0B92C
	pop	bx	;@0B92D
	ret	;@0B92E
	db	1Eh, 7, 0BFh, 8Ah, 0B4h, 0B9h, 21h, 0, 33h, 0C0h, 0F3h, 0AAh, 0C6h	;@0B92F
	db	6, 8Bh, 0B4h, 1, 80h, 3Eh, 19h, 0, 1, 75h, 46h, 83h, 3Eh, 40h
	db	1, 0, 75h, 4Ch, 0C7h, 6, 8Eh, 0B4h, 81h, 1, 80h, 3Eh, 2Bh, 1, 3
	db	74h, 0Eh, 0C7h, 6, 92h, 0B4h, 81h, 0, 0C7h, 6, 50h, 0B4h, 2, 0
	db	0EBh, 0Ch, 0C7h, 6, 92h, 0B4h, 3, 0, 0C7h, 6, 50h, 0B4h, 1, 80h
	db	0C7h, 6, 96h, 0B4h, 0, 10h, 0C7h, 6, 98h, 0B4h, 0, 14h, 33h, 0C0h
	db	50h, 0B8h, 42h, 0, 50h, 0E8h, 20h, 2, 0EBh, 0Dh, 83h, 3Eh, 40h
	db	1, 0, 74h, 48h, 0C7h, 6, 50h, 0B4h, 2, 0, 0E8h, 0D9h, 0E8h, 8Bh
	db	16h, 40h, 1, 23h, 0D2h, 74h, 25h, 1Eh, 83h, 0C2h, 2, 0B8h, 0, 3Dh
	db	0C5h, 1Eh, 34h, 1, 8Eh, 1Fh, 0E8h, 37h, 49h, 1Fh, 8Bh, 0D8h, 53h
	db	0E8h, 30h, 0EAh, 'ZPS', 8Bh, 0DAh, 0E8h, 2, 'I[X#', 0C0h, 75h
	db	13h, 0E8h, 72h, 0E9h, 1Eh, 7, 0BFh, 7Ah, 52h, 0B9h, 0, 40h, 0D1h
	db	0E9h, 0B8h, 0FFh, 0FFh, 0F3h, 0ABh, 0C3h, 51h, 8Bh, 36h, 40h, 1
	db	83h, 0C6h, 2, 0C5h, 1Eh, 34h, 1, 8Eh, 1Fh, 1Eh, 56h, 2Eh, 8Eh
	db	1Eh, 10h, 0, 0BBh, 6, 0, 53h, 50h, 0E8h, 0A7h, 1, 8Bh, 3Eh, 0A0h
	db	0B4h, 8Eh, 6, 64h, 0B4h, 0E9h, 0ADh, 0, 26h, 8Ah, 55h, 8, 26h
	db	8Bh, 5Dh, 4, 26h, 8Bh, 4Dh, 2, 0F6h, 0C2h, 80h, 75h, 46h, 8Eh
	db	6, 6Ch, 0B4h, 8Bh, 0F1h, 8Ch, 6, 'PR3', 0C0h, 80h, 3Eh, 29h, 1
	db	0, 74h, 1, 40h, 0FFh, 36h, 22h, 1, 0A2h, 22h, 1, 53h, 32h, 0E4h
	db	0E8h, 0E3h, 0D3h, 5Eh, 8Eh, 6, 6Ch, 0B4h, 53h, 8Ch, 6, 'PR2', 0E4h
	db	0C6h, 6, 76h, 52h, 2, 56h, 0E8h, 0CEh, 0D3h, '^YX', 0A2h, 22h
	db	1, 0C6h, 6, 76h, 52h, 0FFh, 'ra&', 8Bh, 1Fh, 83h, 0FBh, 0FFh, 74h
	db	59h, 8Eh, 6, 64h, 0B4h, 26h, 89h, 5Dh, 4, 26h, 89h, 4Dh, 2, 26h
	db	80h, 4Dh, 8, 80h, 53h, 83h, 0E3h, 3, 0D1h, 0E3h, 0D1h, 0E3h, 0D1h
	db	0E3h, 8Eh, 87h, 58h, 7, 5Bh, 26h, 0F6h, 47h, 0Eh, 80h, 'u\&', 80h
	db	4Fh, 0Eh, 81h, 26h, 8Bh, 5Fh, 2, 53h, 83h, 0E3h, 3, 0D1h, 0E3h
	db	0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 87h, 38h, 7, 5Bh, 26h, 83h, 7Fh, 0Ah
	db	1, 75h, 4, 26h, 0FFh, 4Fh, 0Ah, 8Eh, 6, 64h, 0B4h, 26h, 8Bh, 3Dh
	db	0Bh, 0FFh, 74h, 3, 0E9h, 4Ch, 0FFh, 0C3h, 'PSQRVW', 8Eh, 6, 6Ch
	db	0B4h, 1Eh, 0BFh, 28h, 0, 57h, 6, 56h, 0E8h, 0E0h, 0D7h, 1Eh, 0BEh
	db	28h, 0, 56h, 0B8h, 4, 0, 50h, 0B8h, 3Ah, 0, 50h, 0E8h, 0CDh, 0
	db	'_^ZY[X', 8Eh, 6, 64h, 0B4h, 26h, 0C7h, 45h, 6, 0FFh, 0FFh, 0EBh
	db	0BFh
FORMAT:	pop	ax	;@0BAF0
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
	call	PUT_DECIMAL	;@0BB4B
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
	call	HEX_WORD	;@0BB61
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
MESSAGE_TEXT:	push	bp	;@0BB84
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
FATAL:	mov	ax, 4	;@0BBA1
	jmp	short REPORT	;@0BBA4
ERROR:	mov	ax, 1	;@0BBA6
	jmp	short REPORT	;@0BBA9
WARNING:	mov	ax, 0	;@0BBAB
	jmp	short REPORT	;@0BBAE
REPORT:	pop	dx	;@0BBB0
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
	jne	@@1+1	;@0BBC8
	mov	byte ptr ds:[12h], 1	;@0BBCA
	call	PUT_INLINE	;@0BBCF
	pop	es	;@0BBD2
	inc	bp	;@0BBD3
	jb	@@4+1	;@0BBD4
	outsw	;@0BBD6
	jb	@@3	;@0BBD7
	db	20h, 0EBh	; and bl, ch	;@0BBD9
@@1:	and	byte ptr [bp+di-582h], al	;@0BBDB
	add	byte ptr [di+0Fh], dh	;@0BBDF
	call	PUT_INLINE	;@0BBE2
	or	word ptr [bx+61h], dx	;@0BBE5
	db	72h, 6Eh	; jb @@5	;@0BBE8
	imul	bp, word ptr [bp+67h], 203Ah	;@0BBEA
	jmp	short @@2	;@0BBEF
	call	PUT_INLINE	;@0BBF1
	pop	es	;@0BBF4
	inc	si	;@0BBF5
	popa	;@0BBF6
	db	74h, 61h	; je @@5+2	;@0BBF7
	insb	;@0BBF9
	cmp	ah, byte ptr [bx+si]	;@0BBFA
@@2:	mov	word ptr ds:[0B441h], di	;@0BBFC
	mov	ax, word ptr [bp+2]	;@0BC00
	push	ax	;@0BC03
	call	MESSAGE_TEXT	;@0BC04
	mov	word ptr [bp-0Ch], ax	;@0BC07
	mov	word ptr [bp-0Ah], dx	;@0BC0A
	sub	sp, word ptr [bp+4]	;@0BC0D
	lea	si, [bp+6]	;@0BC10
@@3:	mov	di, sp	;@0BC13
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
	call	FORMAT	;@0BC31
	push	ds	;@0BC34
	mov	ax, 0B4C0h	;@0BC35
	push	ax	;@0BC38
	call	PUT_FAR_STRING	;@0BC39
	cmp	word ptr ds:[422h], 1	;@0BC3C
	db	75h, 1Ah	; jne @@6+1	;@0BC41
	mov	di, word ptr ds:[0B441h]	;@0BC43
@@4:	call	PUT_INLINE	;@0BC47
	or	sp, word ptr [bx+si]	;@0BC4A
	imul	bp, word ptr [bp+20h], 6F6Dh	;@0BC4C
	db	64h, 75h, 6Ch	; jne @@8	;@0BC51
	db	65h, 20h, 0E8h	; and al, ch	;@0BC54
	cbw	;@0BC57
@@5:	ror	word ptr [bx+di+413Eh], 1	;@0BC58
@@6:	mov	ah, 8Bh	;@0BC5C
	db	3Eh, 41h	; inc cx	;@0BC5E
	db	0B4h, 0E8h	; mov ah, 0E8h	;@0BC60
	stosw	;@0BC62
	rol	di, 1	;@0BC63
	push	es	;@0BC65
	and	al, byte ptr [si]	;@0BC66
	db	0FFh, 0FFh	;@0BC68
	cmp	word ptr [bp-6], 4	;@0BC6A
	jne	@@7	;@0BC6E
	call	L08610	;@0BC70
@@7:	pop	di	;@0BC73
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
@@8:	push	bp	;@0BCC0
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
