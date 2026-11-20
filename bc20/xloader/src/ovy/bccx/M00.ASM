	.286p
	locals
	extrn	L0A12D:far
	extrn	L10418:far
	extrn	L1044C:far
	extrn	L104AE:far
	extrn	L104FF:far
	extrn	L10507:far
	extrn	L10957:far
	extrn	L15C90:far
	extrn	L15CBE:far
	extrn	L179A7:far
	extrn	L179E9:far
	extrn	L181A0:byte

Y00000	segment para public 'CODE'
	assume	cs:Y00000
BCC_START:	mov	dx, 0B87h	;@00000
	mov	es, dx	;@00003
	mov	di, sp	;@00005
	mov	word ptr es:[16h], ds	;@00007
	mov	bx, ss	;@0000C
	mov	ax, di	;@0000E
	add	ax, 0Fh	;@00010
	shr	ax, 1	;@00013
	shr	ax, 1	;@00015
	shr	ax, 1	;@00017
	shr	ax, 1	;@00019
	add	bx, ax	;@0001B
	cmp	word ptr es:[16h], 7	;@0001D
	jne	@@1	;@00023
	push	dx	;@00025
	mov	ax, 0E800h	;@00026
	mov	cx, 0FFFFh	;@00029
	mov	dx, cx	;@0002C
	int	21h	;@0002E
	mov	ax, 0E800h	;@00030
	int	21h	;@00033
	mov	word ptr es:[4], ax	;@00035
	mov	word ptr es:[0Ch], ax	;@00039
	mov	byte ptr es:[1Ah], 8	;@0003D
	mov	ax, 0E802h	;@00043
	mov	cx, 0FFFFh	;@00046
	mov	dx, cx	;@00049
	int	21h	;@0004B
	mov	ax, 0E802h	;@0004D
	int	21h	;@00050
	mov	word ptr es:[1Bh], ax	;@00052
	mov	word ptr es:[1Dh], bx	;@00056
	pop	dx	;@0005B
	jmp	short @@2	;@0005C
@@1:	mov	word ptr es:[4], bx	;@0005E
	mov	word ptr es:[0Ch], bx	;@00063
	mov	ax, bx	;@00068
	mov	cx, word ptr ds:[2]	;@0006A
	mov	word ptr es:[8], cx	;@0006E
	mov	word ptr es:[10h], cx	;@00073
	sub	cx, ax	;@00078
@@2:	mov	word ptr es:[12h], ds	;@0007A
	mov	cx, word ptr ds:[2Ch]	;@0007F
	mov	word ptr es:[14h], cx	;@00083
	mov	ch, 0	;@00088
	mov	si, 81h	;@0008A
	mov	cl, byte ptr ds:[80h]	;@0008D
	mov	ax, cx	;@00091
	sub	di, cx	;@00093
	dec	di	;@00095
	and	di, -2	;@00096
	mov	sp, di	;@00099
	push	ss	;@0009B
	pop	es	;@0009C
	cld	;@0009D
	rep movsb	;@0009E
	mov	bp, di	;@000A0
	mov	ds, dx	;@000A2
	mov	es, dx	;@000A4
	push	ax	;@000A6
	xor	ax, ax	;@000A7
	mov	cx, 8E6Ah	;@000A9
	mov	di, 5CB6h	;@000AC
	sub	cx, di	;@000AF
	rep stosb	;@000B1
	pop	cx	;@000B3
	mov	bx, 1	;@000B4
	push	ax	;@000B7
	push	ax	;@000B8
	mov	byte ptr [bp], al	;@000B9
	jcxz	@@6	;@000BC
@@3:	dec	bp	;@000BE
	cmp	byte ptr [bp], 20h	;@000BF
	je	@@4	;@000C3
	cmp	byte ptr [bp], 9	;@000C5
	je	@@4	;@000C9
	mov	ah, 1	;@000CB
	jmp	short @@5	;@000CD
@@4:	or	ah, ah	;@000CF
	mov	byte ptr [bp], al	;@000D1
	je	@@5	;@000D4
	inc	bp	;@000D6
	push	ss	;@000D7
	push	bp	;@000D8
	dec	bp	;@000D9
	inc	bx	;@000DA
	xor	ax, ax	;@000DB
@@5:	loop	@@3	;@000DD
@@6:	or	ah, ah	;@000DF
	je	@@7	;@000E1
	inc	bx	;@000E3
	push	ss	;@000E4
	push	bp	;@000E5
@@7:	push	ss	;@000E6
	push	bp	;@000E7
	push	bx	;@000E8
	mov	ah, 30h	;@000E9
	int	21h	;@000EB
	pop	bx	;@000ED
	cmp	al, 3	;@000EE
	db	72h, 1Ah	; jb L0010C	;@000F0
	pop	ax	;@000F2
	pop	ax	;@000F3
	mov	es, word ptr ds:[14h]	;@000F4
	xor	ax, ax	;@000F8
	mov	di, ax	;@000FA
	mov	cx, ax	;@000FC
	dec	cx	;@000FE
	db	0F2h	; repne scasb	;@000FF
Y00000	ends

Y00100	segment para public 'CODE'
	assume	cs:Y00100
	db	0AEh, 'G&8E', 0FFh, 75h, 0F7h, 47h, 47h, 6, 57h	;@00100
L0010C:	mov	ax, sp	;@0010C
	push	ss	;@0010E
	push	ax	;@0010F
	push	bx	;@00110
	cmp	byte ptr ds:[1Ah], 8	;@00111
	jne	@@1	;@00116
	mov	ax, 8E70h	;@00118
	jmp	short @@2	;@0011B
@@1:	mov	ax, ss	;@0011D
	mov	bx, ds	;@0011F
	sub	ax, bx	;@00121
	mov	cl, 4	;@00123
	shl	ax, cl	;@00125
@@2:	mov	bx, ds	;@00127
	cli	;@00129
	mov	ss, bx	;@0012A
	add	sp, ax	;@0012C
	sti	;@0012E
	xor	ax, ax	;@0012F
	mov	es, bx	;@00131
	mov	cx, sp	;@00133
	mov	di, 8E70h	;@00135
	sub	cx, di	;@00138
	rep stosb	;@0013A
	xor	bp, bp	;@0013C
	db	9Ah, 3Ch, 1, 2Fh, 0	; lcall 0x2f, 0x13c	;@0013E
	push	ax	;@00143
	push	ax	;@00144
	push	ax	;@00145
C0_TERMINATE:	mov	bp, sp	;@00146
	mov	al, byte ptr [bp+4]	;@00148
	mov	ah, 4Ch	;@0014B
	int	21h	;@0014D
C0_INT_DISPATCH_HANDLER:	sti	;@0014F
	push	bx	;@00150
	push	bp	;@00151
	mov	bp, sp	;@00152
	push	es	;@00154
	mov	bx, word ptr [bp+4]	;@00155
	xchg	word ptr [bp+6], bx	;@00158
	xchg	word ptr [bp+8], bx	;@0015B
	xchg	word ptr [bp+2], bx	;@0015E
	mov	word ptr [bp+4], bx	;@00161
	les	bx, dword ptr [bp+6]	;@00164
	inc	word ptr [bp+6]	;@00167
	mov	bl, byte ptr es:[bx]	;@0016A
	mov	bh, 0	;@0016D
	shl	bx, 1	;@0016F
	neg	bx	;@00171
	mov	bx, word ptr cs:[bx+27Eh]	;@00173
	xchg	word ptr [bp+4], bx	;@00178
	pop	es	;@0017B
	pop	bp	;@0017C
	popf	;@0017D
	ret	;@0017E
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h	;@0017F
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 0CBh, 0CDh, 40h
	db	0CBh, 'Runtime overlay error', 0Dh, 0Ah, 0BBh, 87h, 0Bh, 8Eh, 0DBh
	db	0A3h, 0CEh, 6, 0BBh, 2, 0, 53h, 50h, 0FFh, 1Eh, 0C4h, 60h, 0B9h
	db	17h, 0, 0BAh, 84h, 2, 0Eh, 1Fh, 0B4h, 40h, 0BBh, 2, 0, 0CDh, 21h
	db	0B8h, 4, 0, 50h, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 9Ah, 46h, 1, 1Fh, 0
	xor	cx, cx	;@002C9
	jmp	short @@1	;@002CB
	mov	cx, 1	;@002CD
	jmp	short @@1	;@002D0
	mov	cx, 2	;@002D2
	jmp	short @@1	;@002D5
	mov	cx, 3	;@002D7
@@1:	push	bp	;@002DA
	push	si	;@002DB
	push	di	;@002DC
	mov	bp, sp	;@002DD
	mov	di, cx	;@002DF
	mov	ax, word ptr [bp+0Ah]	;@002E1
	mov	dx, word ptr [bp+0Ch]	;@002E4
	mov	bx, word ptr [bp+0Eh]	;@002E7
	mov	cx, word ptr [bp+10h]	;@002EA
	or	cx, cx	;@002ED
	jne	@@2	;@002EF
	or	dx, dx	;@002F1
	je	@@10	;@002F3
	or	bx, bx	;@002F5
	je	@@10	;@002F7
@@2:	test	di, 1	;@002F9
	jne	@@4	;@002FD
	or	dx, dx	;@002FF
	jns	@@3	;@00301
	neg	dx	;@00303
	neg	ax	;@00305
	sbb	dx, 0	;@00307
	or	di, 0Ch	;@0030A
@@3:	or	cx, cx	;@0030D
	jns	@@4	;@0030F
	neg	cx	;@00311
	neg	bx	;@00313
	sbb	cx, 0	;@00315
	xor	di, 4	;@00318
@@4:	mov	bp, cx	;@0031B
	mov	cx, 20h	;@0031D
	push	di	;@00320
	xor	di, di	;@00321
	xor	si, si	;@00323
@@5:	shl	ax, 1	;@00325
	rcl	dx, 1	;@00327
	rcl	si, 1	;@00329
	rcl	di, 1	;@0032B
	cmp	di, bp	;@0032D
	jb	@@7	;@0032F
	ja	@@6	;@00331
	cmp	si, bx	;@00333
	jb	@@7	;@00335
@@6:	sub	si, bx	;@00337
	sbb	di, bp	;@00339
	inc	ax	;@0033B
@@7:	loop	@@5	;@0033C
	pop	bx	;@0033E
	test	bx, 2	;@0033F
	je	@@8	;@00343
	mov	ax, si	;@00345
	mov	dx, di	;@00347
	shr	bx, 1	;@00349
@@8:	test	bx, 4	;@0034B
	je	@@9	;@0034F
	neg	dx	;@00351
	neg	ax	;@00353
	sbb	dx, 0	;@00355
@@9:	pop	di	;@00358
	pop	si	;@00359
	pop	bp	;@0035A
	retf	8	;@0035B
@@10:	div	bx	;@0035E
	test	di, 2	;@00360
	je	@@11	;@00364
	mov	ax, dx	;@00366
@@11:	xor	dx, dx	;@00368
	jmp	@@9	;@0036A
	cmp	cl, 10h	;@0036C
	jae	@@12	;@0036F
	mov	bx, ax	;@00371
	shl	ax, cl	;@00373
	shl	dx, cl	;@00375
	neg	cl	;@00377
	add	cl, 10h	;@00379
	shr	bx, cl	;@0037C
	or	dx, bx	;@0037E
	retf	;@00380
@@12:	sub	cl, 10h	;@00381
	mov	dx, ax	;@00384
	xor	ax, ax	;@00386
	shl	dx, cl	;@00388
	retf	;@0038A
	cmp	cl, 10h	;@0038B
	jae	@@13	;@0038E
	mov	bx, dx	;@00390
	shr	ax, cl	;@00392
	sar	dx, cl	;@00394
	neg	cl	;@00396
	add	cl, 10h	;@00398
	shl	bx, cl	;@0039B
	or	ax, bx	;@0039D
	retf	;@0039F
@@13:	sub	cl, 10h	;@003A0
	mov	ax, dx	;@003A3
	cwd	;@003A5
	sar	ax, cl	;@003A6
	retf	;@003A8
	push	si	;@003A9
	xchg	ax, si	;@003AA
	xchg	ax, dx	;@003AB
	test	ax, ax	;@003AC
	je	@@14	;@003AE
	mul	bx	;@003B0
@@14:	xchg	ax, cx	;@003B2
	test	ax, ax	;@003B3
	je	@@15	;@003B5
	mul	si	;@003B7
	add	cx, ax	;@003B9
@@15:	xchg	ax, si	;@003BB
	mul	bx	;@003BC
	add	dx, cx	;@003BE
	pop	si	;@003C0
	retf	;@003C1
BCC_RUNTIME_BUILD:	pop	bx	;@003C2
	pop	es	;@003C3
	sub	sp, cx	;@003C4
	push	es	;@003C6
	push	bx	;@003C7
	push	di	;@003C8
	push	ds	;@003C9
	mov	di, sp	;@003CA
	add	di, 8	;@003CC
	mov	bx, ss	;@003CF
	mov	es, bx	;@003D1
	mov	ds, dx	;@003D3
	xchg	ax, si	;@003D5
	cld	;@003D6
	shr	cx, 1	;@003D7
	rep movsw	;@003D9
	adc	cx, cx	;@003DB
	rep movsb	;@003DD
	xchg	ax, si	;@003DF
	pop	ds	;@003E0
	pop	di	;@003E1
	retf	;@003E2
	cmp	cl, 10h	;@003E3
	jae	@@1	;@003E6
	mov	bx, dx	;@003E8
	shr	ax, cl	;@003EA
	shr	dx, cl	;@003EC
	neg	cl	;@003EE
	add	cl, 10h	;@003F0
	shl	bx, cl	;@003F3
	or	ax, bx	;@003F5
	retf	;@003F7
@@1:	sub	cl, 10h	;@003F8
	mov	ax, dx	;@003FB
	xor	dx, dx	;@003FD
	shr	ax, cl	;@003FF
	retf	;@00401
BCC_RUNTIME_COPY:	push	bp	;@00402
	mov	bp, sp	;@00403
	push	ds	;@00405
	push	di	;@00406
	push	si	;@00407
	lds	si, dword ptr [bp+6]	;@00408
	les	di, dword ptr [bp+0Ah]	;@0040B
	cld	;@0040E
	rep movsb	;@0040F
	pop	si	;@00411
	pop	di	;@00412
	pop	ds	;@00413
	pop	bp	;@00414
	retf	8	;@00415
RVECSET_BODY:	push	bp	;@00418
	mov	bp, sp	;@00419
	cmp	byte ptr ds:[1Ah], 8	;@0041B
	je	@@1	;@00420
	push	word ptr [bp+0Ah]	;@00422
	push	word ptr [bp+8]	;@00425
	push	word ptr [bp+6]	;@00428
	db	9Ah, 1Dh, 0, 0EFh, 1	; lcall 0x1ef, 0x1d	;@0042B
	jmp	short @@2	;@00430
@@1:	push	ax	;@00432
	push	dx	;@00433
	mov	ax, ds	;@00434
	push	ds	;@00436
	mov	dx, word ptr [bp+6]	;@00437
	mov	ds, word ptr [bp+8]	;@0043A
	mov	al, byte ptr [bp+0Ah]	;@0043D
	mov	ah, 25h	;@00440
	int	21h	;@00442
	pop	ax	;@00444
	mov	ds, ax	;@00445
	pop	dx	;@00447
	pop	ax	;@00448
@@2:	pop	bp	;@00449
	retf	6	;@0044A
RVECGET_BODY:	push	bp	;@0044D
	mov	bp, sp	;@0044E
	dec	sp	;@00450
	dec	sp	;@00451
	cmp	byte ptr ds:[1Ah], 8	;@00452
	je	@@1	;@00457
	push	word ptr [bp+6]	;@00459
	db	9Ah, 0Bh, 0, 0EFh, 1	; lcall 0x1ef, 0xb	;@0045C
	jmp	short @@2	;@00461
@@1:	mov	al, byte ptr [bp+6]	;@00463
	mov	ah, 35h	;@00466
	int	21h	;@00468
	mov	word ptr [bp-2], bx	;@0046A
	mov	dx, es	;@0046D
	mov	ax, word ptr [bp-2]	;@0046F
@@2:	mov	sp, bp	;@00472
	pop	bp	;@00474
	retf	2	;@00475
L00478:	push	bp	;@00478
	mov	bp, sp	;@00479
	push	ds	;@0047B
	mov	ax, 0B87h	;@0047C
	mov	ds, ax	;@0047F
	mov	ax, 18h	;@00481
	push	ax	;@00484
	push	word ptr ds:[5CBCh]	;@00485
	push	word ptr ds:[5CBAh]	;@00489
	push	cs	;@0048D
	call	RVECSET_BODY	;@0048E
	mov	ax, 1Bh	;@00491
	push	ax	;@00494
	push	word ptr ds:[5CC0h]	;@00495
	push	word ptr ds:[5CBEh]	;@00499
	push	cs	;@0049D
	call	RVECSET_BODY	;@0049E
	db	9Ah, 29h, 1, 7Fh, 0	; lcall 0x7f, 0x129	;@004A1
	db	9Ah, 99h, 2Fh, 3Fh, 0	; lcall 0x3f, 0x2f99	;@004A6
	stc	;@004AB
	pop	ds	;@004AC
	pop	bp	;@004AD
	retf	;@004AE
L004AF:	push	bp	;@004AF
	mov	bp, sp	;@004B0
	mov	ax, 1Bh	;@004B2
	push	ax	;@004B5
	push	word ptr ds:[5CC0h]	;@004B6
	push	word ptr ds:[5CBEh]	;@004BA
	push	cs	;@004BE
	call	RVECSET_BODY	;@004BF
	push	word ptr [bp+6]	;@004C2
	db	9Ah, 46h, 1, 1Fh, 0	; lcall 0x1f, 0x146	;@004C5
	pop	cx	;@004CA
	pop	bp	;@004CB
	retf	2	;@004CC
LINE_HOOK:	push	bp	;@004CF
	mov	bp, sp	;@004D0
	push	cs	;@004D2
	call	L00478	;@004D3
	mov	ax, 100h	;@004D6
	push	ax	;@004D9
	push	cs	;@004DA
	call	L004AF	;@004DB
	pop	bp	;@004DE
	retf	;@004DF
CTRL_BREAK_HANDLER_ENTRY:	push	ax	;@004E0
	push	bx	;@004E1
	push	cx	;@004E2
	push	dx	;@004E3
	push	es	;@004E4
	push	ds	;@004E5
	push	si	;@004E6
	push	di	;@004E7
	push	bp	;@004E8
	mov	bp, 0B87h	;@004E9
	mov	ds, bp	;@004EC
	mov	bp, sp	;@004EE
	mov	word ptr ds:[5CC2h], 1	;@004F0
	pop	bp	;@004F6
	pop	di	;@004F7
	pop	si	;@004F8
	pop	ds	;@004F9
	pop	es	;@004FA
	pop	dx	;@004FB
	pop	cx	;@004FC
	pop	bx	;@004FD
	pop	ax	;@004FE
	iret	;@004FF
RARGV0F0_BODY:	push	bp	;@00500
	mov	bp, sp	;@00501
	sub	sp, 4	;@00503
	db	0EBh, 26h	; jmp short L0052E	;@00506
	db	0C4h, 5Eh, 0FCh, 0FFh, 46h, 0FCh, 26h, 80h	;@00508
Y00100	ends

Y00510	segment para public 'CODE'
	assume	cs:Y00510
	db	'?-u', 1Ah, 0C4h, 5Eh, 0FCh, 0FFh, 46h, 0FCh, 26h, 80h, '?#u'	;@00510
	db	0Eh, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh, 9Ah, 0Bh, 0, 0Fh, 1, 0A3h
	db	0C4h, 5Ch
L0052E:	les	bx, dword ptr [bp+6]	;@0052E
	add	word ptr [bp+6], 4	;@00531
	mov	ax, word ptr es:[bx+2]	;@00535
	mov	dx, word ptr es:[bx]	;@00539
	mov	word ptr [bp-2], ax	;@0053C
	mov	word ptr [bp-4], dx	;@0053F
	db	0Bh, 0D0h	; or dx, ax	;@00542
	db	75h, 0C2h	; jne L10507+1	;@00544
	mov	sp, bp	;@00546
	pop	bp	;@00548
	retf	4	;@00549
COMPILER_MAIN_ENTRY:	push	bp	;@0054C
	mov	bp, sp	;@0054D
	sub	sp, 0Ch	;@0054F
	mov	ax, 18h	;@00552
	push	ax	;@00555
	push	cs	;@00556
	db	0E8h, 0F3h, 0FEh	; call L1044C+1	;@00557
	db	89h, 16h, 0BCh, 5Ch	; mov word ptr ds:[5CBCh], dx	;@0055A
	mov	word ptr ds:[5CBAh], ax	;@0055E
	mov	ax, 18h	;@00561
	push	ax	;@00564
	mov	ax, 1Fh	;@00565
	push	ax	;@00568
	mov	ax, 14Fh	;@00569
	push	ax	;@0056C
	push	cs	;@0056D
	db	0E8h, 0A7h, 0FEh	; call L10418	;@0056E
	db	1Eh	; push ds	;@00571
	mov	ax, 84BCh	;@00572
	push	ax	;@00575
	db	9Ah, 0Eh, 0, 0CFh, 1	; lcall 0x1cf, 0xe	;@00576
	push	ds	;@0057B
	mov	ax, 84B6h	;@0057C
	push	ax	;@0057F
	db	9Ah, 23h, 0, 0CFh, 1	; lcall 0x1cf, 0x23	;@00580
	push	ds	;@00585
	mov	ax, 20h	;@00586
	push	ax	;@00589
	db	9Ah, 0D6h, 4, 2Fh, 0	; lcall 0x2f, 0x4d6	;@0058A
	cmp	word ptr [bp+6], 1	;@0058F
	jne	@@1	;@00593
	db	9Ah, 0F8h, 4, 2Fh, 0	; lcall 0x2f, 0x4f8	;@00595
@@1:	mov	ax, 23h	;@0059A
	push	ax	;@0059D
	push	cs	;@0059E
	db	0E8h, 0ABh, 0FEh	; call L1044C+1	;@0059F
	db	89h, 16h, 0B8h, 5Ch	; mov word ptr ds:[5CB8h], dx	;@005A2
	mov	word ptr ds:[5CB6h], ax	;@005A6
	mov	ax, 23h	;@005A9
	push	ax	;@005AC
	mov	ax, 2Fh	;@005AD
	push	ax	;@005B0
	mov	ax, 68h	;@005B1
	push	ax	;@005B4
	push	cs	;@005B5
	db	0E8h, 5Fh, 0FEh	; call L10418	;@005B6
	db	0B8h, 1Bh, 0	; mov ax, 1Bh	;@005B9
	push	ax	;@005BC
	push	cs	;@005BD
	db	0E8h, 8Ch, 0FEh	; call L1044C+1	;@005BE
	db	89h, 16h, 0C0h, 5Ch	; mov word ptr ds:[5CC0h], dx	;@005C1
	mov	word ptr ds:[5CBEh], ax	;@005C5
	mov	ax, 1Bh	;@005C8
	push	ax	;@005CB
	mov	ax, 2Fh	;@005CC
	push	ax	;@005CF
	mov	ax, 0D0h	;@005D0
	push	ax	;@005D3
	push	cs	;@005D4
	db	0E8h, 40h, 0FEh	; call L10418	;@005D5
	db	0A1h, 8, 0	; mov ax, word ptr ds:[8]	;@005D8
	sub	ax, word ptr ds:[4]	;@005DB
	mov	word ptr ds:[5CC4h], ax	;@005DF
	push	word ptr [bp+0Ah]	;@005E2
	push	word ptr [bp+8]	;@005E5
	push	cs	;@005E8
	db	0E8h, 14h, 0FFh	; call L104FF+1	;@005E9
	db	9Ah, 0Fh, 0, 6Fh, 0	; lcall 0x6f, 0xf	;@005EC
	push	ss	;@005F1
	lea	ax, [bp+6]	;@005F2
	push	ax	;@005F5
	push	ss	;@005F6
	lea	ax, [bp+8]	;@005F7
	push	ax	;@005FA
	db	9Ah, 2Fh, 0, 0EFh, 6	; lcall 0x6ef, 0x2f	;@005FB
	push	word ptr [bp+6]	;@00600
	push	word ptr [bp+0Ah]	;@00603
	push	word ptr [bp+8]	;@00606
	db	9Ah, 20h, 0, 0Fh, 7	; lcall 0x70f, 0x20	;@00609
	db	9Ah, 8Bh, 0, 6Fh, 0	; lcall 0x6f, 0x8b	;@0060E
	mov	ax, word ptr ds:[176Eh]	;@00613
	or	ax, word ptr ds:[1770h]	;@00616
	je	@@4	;@0061A
	push	word ptr ds:[1770h]	;@0061C
	push	word ptr ds:[176Eh]	;@00620
	push	ds	;@00624
	mov	al, byte ptr ds:[1735h]	;@00625
	cbw	;@00628
	or	ax, ax	;@00629
	jne	@@2	;@0062B
	cmp	byte ptr ds:[1734h], 0	;@0062D
	je	@@2	;@00632
	mov	ax, 69Ch	;@00634
	jmp	short @@3	;@00637
@@2:	mov	ax, 6A1h	;@00639
@@3:	push	ax	;@0063C
	db	9Ah, 34h, 0, 0EFh, 6	; lcall 0x6ef, 0x34	;@0063D
	mov	word ptr ds:[1770h], dx	;@00642
	mov	word ptr ds:[176Eh], ax	;@00646
@@4:	cmp	byte ptr ds:[1794h], 0	;@00649
	je	@@5	;@0064E
	mov	al, byte ptr ds:[1729h]	;@00650
	cbw	;@00653
	or	ax, ax	;@00654
	jne	@@5	;@00656
	mov	byte ptr ds:[1729h], 1	;@00658
@@5:	db	9Ah, 25h, 0, 8Fh, 6	; lcall 0x68f, 0x25	;@0065D
	dec	word ptr [bp+6]	;@00662
	add	word ptr [bp+8], 4	;@00665
	jmp	short @@7	;@00669
@@6:	add	word ptr [bp+8], 4	;@0066B
	dec	word ptr [bp+6]	;@0066F
@@7:	cmp	word ptr [bp+6], 0	;@00672
	jle	@@8	;@00676
	les	bx, dword ptr [bp+8]	;@00678
	les	bx, dword ptr es:[bx]	;@0067B
	cmp	byte ptr es:[bx], 2Dh	;@0067E
	je	@@6	;@00682
	les	bx, dword ptr [bp+8]	;@00684
	les	bx, dword ptr es:[bx]	;@00687
	cmp	byte ptr es:[bx], 2Bh	;@0068A
	je	@@6	;@0068E
@@8:	cmp	word ptr [bp+6], 0	;@00690
	jne	@@9	;@00694
	mov	ax, 49h	;@00696
	push	ax	;@00699
	db	9Ah, 43h, 0, 0EFh, 6	; lcall 0x6ef, 0x43	;@0069A
@@9:	mov	ax, word ptr [bp+6]	;@0069F
	mov	word ptr [bp-2], ax	;@006A2
	mov	ax, word ptr [bp+0Ah]	;@006A5
	mov	dx, word ptr [bp+8]	;@006A8
	mov	word ptr [bp-4], ax	;@006AB
	mov	word ptr [bp-6], dx	;@006AE
	mov	al, byte ptr ds:[1720h]	;@006B1
	mov	byte ptr [bp-7], al	;@006B4
	jmp	short @@13	;@006B7
@@10:	les	bx, dword ptr [bp+8]	;@006B9
	les	bx, dword ptr es:[bx]	;@006BC
	cmp	byte ptr es:[bx], 2Dh	;@006BF
	je	@@11	;@006C3
	les	bx, dword ptr [bp+8]	;@006C5
	push	word ptr es:[bx+2]	;@006C8
	push	word ptr es:[bx]	;@006CC
	db	9Ah, 39h, 0, 0EFh, 6	; lcall 0x6ef, 0x39	;@006CF
	jmp	short @@12	;@006D4
@@11:	les	bx, dword ptr [bp+8]	;@006D6
	les	bx, dword ptr es:[bx]	;@006D9
	cmp	byte ptr es:[bx+1], 76h	;@006DC
	jne	@@12	;@006E1
	les	bx, dword ptr [bp+8]	;@006E3
	mov	ax, word ptr es:[bx]	;@006E6
	inc	ax	;@006E9
	push	word ptr es:[bx+2]	;@006EA
	push	ax	;@006EE
	xor	ax, ax	;@006EF
	push	ax	;@006F1
	db	9Ah, 4Dh, 0, 8Fh, 6	; lcall 0x68f, 0x4d	;@006F2
@@12:	add	word ptr [bp+8], 4	;@006F7
	dec	word ptr [bp+6]	;@006FB
@@13:	cmp	word ptr [bp+6], 0	;@006FE
	jg	@@10	;@00702
	mov	al, byte ptr [bp-7]	;@00704
	mov	byte ptr ds:[1720h], al	;@00707
	push	word ptr [bp-2]	;@0070A
	push	word ptr [bp-4]	;@0070D
	push	word ptr [bp-6]	;@00710
	db	9Ah, 2Ah, 0, 0EFh, 6	; lcall 0x6ef, 0x2a	;@00713
	db	9Ah, 0DEh, 2Fh, 3Fh, 0	; lcall 0x3f, 0x2fde	;@00718
	sub	ax, word ptr ds:[7A3Eh]	;@0071D
	sbb	dx, word ptr ds:[7A40h]	;@00721
	mov	word ptr [bp-0Ah], dx	;@00725
	mov	word ptr [bp-0Ch], ax	;@00728
	mov	ax, word ptr ds:[2A16h]	;@0072B
	mov	dx, word ptr ds:[2A14h]	;@0072E
	cmp	ax, word ptr [bp-0Ah]	;@00732
	jl	@@15	;@00735
	jg	@@14	;@00737
	cmp	dx, word ptr [bp-0Ch]	;@00739
	jbe	@@15	;@0073C
@@14:	mov	ax, word ptr [bp-0Ah]	;@0073E
	mov	dx, word ptr [bp-0Ch]	;@00741
	mov	word ptr ds:[2A16h], ax	;@00744
	mov	word ptr ds:[2A14h], dx	;@00747
@@15:	cmp	word ptr ds:[2A16h], 0	;@0074B
	jg	@@17	;@00750
	jl	@@16	;@00752
	cmp	word ptr ds:[2A14h], 0	;@00754
	jae	@@17	;@00759
@@16:	mov	word ptr ds:[2A16h], 0	;@0075B
	mov	word ptr ds:[2A14h], 0	;@00761
@@17:	push	word ptr ds:[2A16h]	;@00767
	push	word ptr ds:[2A14h]	;@0076B
	push	ds	;@0076F
	mov	ax, 64h	;@00770
	push	ax	;@00773
	db	9Ah, 0Dh, 0, 9Fh, 2	; lcall 0x29f, 0xd	;@00774
	add	sp, 8	;@00779
	db	9Ah, 99h, 2Fh, 3Fh, 0	; lcall 0x3f, 0x2f99	;@0077C
	cmp	word ptr ds:[84BAh], 0	;@00781
	je	@@18	;@00786
	mov	ax, 1	;@00788
	jmp	short @@19	;@0078B
@@18:	xor	ax, ax	;@0078D
@@19:	push	ax	;@0078F
	push	cs	;@00790
	db	0E8h, 1Bh, 0FDh	; call L104AE+1	;@00791
	db	8Bh, 0E5h	; mov sp, bp	;@00794
	pop	bp	;@00796
	retf	;@00797
RUN_PROGRAM:	push	bp	;@00798
	mov	bp, sp	;@00799
	sub	sp, 12h	;@0079B
	push	si	;@0079E
	mov	ax, word ptr [bp+6]	;@0079F
	inc	ax	;@007A2
	push	word ptr [bp+8]	;@007A3
	push	ax	;@007A6
	db	9Ah, 4, 0, 5Fh, 2	; lcall 0x25f, 4	;@007A7
	les	bx, dword ptr [bp+6]	;@007AC
	mov	byte ptr es:[bx], al	;@007AF
	push	ss	;@007B2
	lea	ax, [bp-12h]	;@007B3
	push	ax	;@007B6
	xor	ax, ax	;@007B7
	push	ax	;@007B9
	mov	ax, 0Eh	;@007BA
	push	ax	;@007BD
	db	9Ah, 5, 0, 0BFh, 2	; lcall 0x2bf, 5	;@007BE
	mov	ax, word ptr ds:[14h]	;@007C3
	mov	word ptr [bp-12h], ax	;@007C6
	mov	ax, word ptr [bp+8]	;@007C9
	mov	dx, word ptr [bp+6]	;@007CC
	mov	word ptr [bp-0Eh], ax	;@007CF
	mov	word ptr [bp-10h], dx	;@007D2
	push	word ptr [bp+0Ch]	;@007D5
	push	word ptr [bp+0Ah]	;@007D8
	db	9Ah, 3, 0, 0CFh, 2	; lcall 0x2cf, 3	;@007DB
	mov	word ptr [bp-2], dx	;@007E0
	mov	word ptr [bp-4], ax	;@007E3
	or	ax, word ptr [bp-2]	;@007E6
	db	75h, 27h	; jne @@1	;@007E9
	mov	al, 0	;@007EB
	mov	byte ptr ds:[1719h], al	;@007ED
	mov	byte ptr ds:[171Ah], al	;@007F0
	push	word ptr [bp+0Ch]	;@007F3
	push	word ptr [bp+0Ah]	;@007F6
	mov	ax, 2Ch	;@007F9
	push	ax	;@007FC
	db	9Ah, 0Dh, 1, 5Fh, 0	; lcall 0x5f, 0x10d	;@007FD
	add	sp, 6	;@00802
	db	9Ah, 99h, 2Fh, 3Fh, 0	; lcall 0x3f, 0x2f99	;@00805
	mov	ax, 1	;@0080A
	push	ax	;@0080D
	push	cs	;@0080E
	db	0E8h, 9Dh, 0FCh	; call L104AE+1	;@0080F
@@1:	db	9Ah, 0C9h, 0, 6Fh, 0	; lcall 0x6f, 0xc9	;@00812
	mov	ax, 1Bh	;@00817
	push	ax	;@0081A
	push	word ptr ds:[5CC0h]	;@0081B
	push	word ptr ds:[5CBEh]	;@0081F
	push	cs	;@00823
	db	0E8h, 0F1h, 0FBh	; call L10418	;@00824
	db	0B8h, 23h, 0	; mov ax, 23h	;@00827
	push	ax	;@0082A
	push	word ptr ds:[5CB8h]	;@0082B
	push	word ptr ds:[5CB6h]	;@0082F
	push	cs	;@00833
	db	0E8h, 0E1h, 0FBh	; call L10418	;@00834
	db	0B8h, 18h, 0	; mov ax, 18h	;@00837
	push	ax	;@0083A
	push	word ptr ds:[5CBCh]	;@0083B
	push	word ptr ds:[5CBAh]	;@0083F
	push	cs	;@00843
	db	0E8h, 0D1h, 0FBh	; call L10418	;@00844
	db	0FFh, 76h, 0FEh	; push word ptr [bp-2]	;@00847
	push	word ptr [bp-4]	;@0084A
	xor	ax, ax	;@0084D
	push	ax	;@0084F
	push	ss	;@00850
	lea	ax, [bp-12h]	;@00851
	push	ax	;@00854
	db	9Ah, 3, 0, 0AFh, 1	; lcall 0x1af, 3	;@00855
	mov	si, ax	;@0085A
	mov	ax, 18h	;@0085C
	push	ax	;@0085F
	mov	ax, 1Fh	;@00860
	push	ax	;@00863
	mov	ax, 14Fh	;@00864
	push	ax	;@00867
	push	cs	;@00868
	db	0E8h, 0ACh, 0FBh	; call L10418	;@00869
	db	0B8h, 23h, 0	; mov ax, 23h	;@0086C
	push	ax	;@0086F
	mov	ax, 2Fh	;@00870
	push	ax	;@00873
	mov	ax, 68h	;@00874
	push	ax	;@00877
	push	cs	;@00878
	db	0E8h, 9Ch, 0FBh	; call L10418	;@00879
	db	0B8h, 1Bh, 0	; mov ax, 1Bh	;@0087C
	push	ax	;@0087F
	mov	ax, 2Fh	;@00880
	push	ax	;@00883
	mov	ax, 0D0h	;@00884
	push	ax	;@00887
	push	cs	;@00888
	db	0E8h, 8Ch, 0FBh	; call L10418	;@00889
	db	9Ah, 0D7h, 0, 6Fh, 0	; lcall 0x6f, 0xd7	;@0088C
	mov	ax, si	;@00891
	and	ax, 0FF00h	;@00893
	cmp	ax, 100h	;@00896
	je	@@2	;@00899
	mov	ax, si	;@0089B
	and	ax, 0FF00h	;@0089D
	cmp	ax, 200h	;@008A0
	db	75h, 0Dh	; jne @@3	;@008A3
@@2:	db	9Ah, 99h, 2Fh, 3Fh, 0	; lcall 0x3f, 0x2f99	;@008A5
	mov	ax, 1	;@008AA
	push	ax	;@008AD
	push	cs	;@008AE
	db	0E8h, 0FDh, 0FBh	; call L104AE+1	;@008AF
@@3:	db	0Bh, 0F6h	; or si, si	;@008B2
	db	7Dh, 27h	; jge @@4	;@008B4
	mov	al, 0	;@008B6
	mov	byte ptr ds:[1719h], al	;@008B8
	mov	byte ptr ds:[171Ah], al	;@008BB
	push	word ptr [bp+0Ch]	;@008BE
	push	word ptr [bp+0Ah]	;@008C1
	mov	ax, 2Ch	;@008C4
	push	ax	;@008C7
	db	9Ah, 0Dh, 1, 5Fh, 0	; lcall 0x5f, 0x10d	;@008C8
	add	sp, 6	;@008CD
	db	9Ah, 99h, 2Fh, 3Fh, 0	; lcall 0x3f, 0x2f99	;@008D0
	mov	ax, 1	;@008D5
	push	ax	;@008D8
	push	cs	;@008D9
	db	0E8h, 0D2h, 0FBh	; call L104AE+1	;@008DA
@@4:	db	8Bh, 0C6h	; mov ax, si	;@008DD
	pop	si	;@008DF
	mov	sp, bp	;@008E0
	pop	bp	;@008E2
	retf	8	;@008E3
WRITE_STDOUT_STRING:	push	bp	;@008E6
	mov	bp, sp	;@008E7
	mov	ax, 1	;@008E9
	push	ax	;@008EC
	push	word ptr [bp+8]	;@008ED
	push	word ptr [bp+6]	;@008F0
	push	word ptr [bp+8]	;@008F3
	push	word ptr [bp+6]	;@008F6
	db	9Ah, 4, 0, 5Fh, 2	; lcall 0x25f, 4	;@008F9
	push	ax	;@008FE
	db	9Ah, 0Dh, 0, 8Fh, 2	; lcall 0x28f, 0xd	;@008FF
	pop	bp	;@00904
	retf	4	;@00905
PRINT_USAGE_AND_EXIT:	push	bp	;@00908
	mov	bp, sp	;@00909
	push	ds	;@0090B
	mov	ax, 7Eh	;@0090C
	push	ax	;@0090F
	push	cs	;@00910
	call	WRITE_STDOUT_STRING	;@00911
	xor	ax, ax	;@00914
	push	ax	;@00916
	db	9Ah, 46h, 1, 1Fh, 0	; lcall 0x1f, 0x146	;@00917
	pop	cx	;@0091C
	pop	bp	;@0091D
	retf	;@0091E
RTL_STRUPR:	push	bp	;@0091F
	mov	bp, sp	;@00920
	mov	ax, word ptr [bp+6]	;@00922
	or	ax, word ptr [bp+8]	;@00925
	jne	@@2	;@00928
	jmp	short @@3	;@0092A
@@1:	les	bx, dword ptr [bp+6]	;@0092C
	mov	al, byte ptr es:[bx]	;@0092F
	cbw	;@00932
	push	ax	;@00933
	db	9Ah, 33h, 0, 6Fh, 2	; lcall 0x26f, 0x33	;@00934
	les	bx, dword ptr [bp+6]	;@00939
	mov	byte ptr es:[bx], al	;@0093C
	inc	word ptr [bp+6]	;@0093F
@@2:	les	bx, dword ptr [bp+6]	;@00942
	cmp	byte ptr es:[bx], 0	;@00945
	jne	@@1	;@00949
@@3:	pop	bp	;@0094B
	retf	4	;@0094C
	db	55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 83h	;@0094F
	db	0ECh, 0Ah, 57h, 0C7h, 46h, 0F8h, 0, 0, 1Eh, 2Eh, 8Eh, 1Eh, 0F1h
	db	48h, 0A1h, 0D8h, 6, 89h, 46h, 0F6h, 0A1h, 0DEh, 6, 0A3h, 0D8h
	db	6, 8Eh, 1Eh, 0D8h, 6, 8Bh, 1Eh, 44h, 0, 8Bh, 47h, 0Ch, 89h, 46h
	db	0FEh, 8Bh, 46h, 4, 0BAh, 1Ah, 0, 0F7h, 0E2h, 3, 46h, 0FEh, 73h
	db	3, 0E9h, 97h, 0, 89h, 46h, 0FCh, 0A0h, 9, 0, 0Ch, 8, 0A2h, 9, 0
	db	0FFh, 36h, 44h, 0, 0FFh, 76h, 0FCh, 0E8h, 0E4h, 14h, 89h, 46h
	db	0FAh, 0Bh, 0C0h, 75h, 3, 0EBh, 79h, 90h, 0A3h, 44h, 0, 0A1h, 46h
	db	0, 89h, 46h, 0FAh, 83h, 7Eh, 0FAh, 0, 74h, 1Ch, 0EBh, 9, 8Bh, 5Eh
	db	0FAh, 8Bh, 47h, 14h, 89h, 46h, 0FAh, 8Bh, 5Eh, 0FAh, 83h, 7Fh
	db	14h, 0, 75h, 0EEh, 8Bh, 46h, 0FEh, 89h, 47h, 14h, 0EBh, 6, 8Bh
	db	46h, 0FEh, 0A3h, 46h, 0, 8Bh, 46h, 0FEh, 89h, 46h, 0FAh, 1Eh, 7
	db	57h, 8Bh, 4Eh, 0FCh, 2Bh, 4Eh, 0FAh, 8Bh, 7Eh, 0FEh, 33h, 0C0h
	db	0FCh, 0F3h, 0AAh, 5Fh, 0EBh, 10h, 8Bh, 46h, 0FAh, 5, 1Ah, 0, 8Bh
	db	5Eh, 0FAh, 89h, 47h, 14h, 83h, 46h, 0FAh, 1Ah, 8Bh, 46h, 0FAh
	db	3Bh, 46h, 0FCh, 72h, 0E8h, 83h, 6Eh, 0FAh, 1Ah, 8Bh, 5Eh, 0FAh
	db	0C7h, 47h, 14h, 0, 0, 8Bh, 46h, 4, 1, 6, 48h, 0, 0EBh, 5, 0C7h
	db	46h, 0F8h, 1, 10h, 0A0h, 9, 0, 24h, 0F7h, 0A2h, 9, 0, 8Eh, 1Eh
	db	0Ch, 0, 8Bh, 46h, 0F6h, 0A3h, 0D8h
Y00510	ends

Y00A40	segment para public 'CODE'
	assume	cs:Y00A40
	db	6, 1Fh, 8Bh, 46h, 0F8h, 5Fh, 0C9h, 0C2h, 2, 0	;@00A40
L00A4A:	push	bp	;@00A4A
	mov	bp, sp	;@00A4B
	sub	sp, 4	;@00A4D
	push	ds	;@00A50
	mov	ds, word ptr cs:L0532F+2	;@00A51
	mov	ax, word ptr ds:[6D8h]	;@00A56
	mov	word ptr [bp-4], ax	;@00A59
	mov	ax, word ptr ds:[6DAh]	;@00A5C
	mov	word ptr ds:[6D8h], ax	;@00A5F
	mov	ds, word ptr ds:[6D8h]	;@00A62
	mov	es, word ptr ds:[0Ch]	;@00A66
	mov	bl, byte ptr es:[6D4h]	;@00A6A
	xor	bh, bh	;@00A6F
@@1:	dec	bl	;@00A71
	shl	bx, 1	;@00A73
	mov	cx, word ptr es:[bx+5EBAh]	;@00A75
	shr	bx, 1	;@00A7A
	jcxz	@@3	;@00A7C
	push	es	;@00A7E
	push	bx	;@00A7F
	mov	word ptr [bp-2], cx	;@00A80
	mov	bx, word ptr [bp-2]	;@00A83
	test	word ptr [bx+0Eh], 400h	;@00A86
	je	@@2	;@00A8B
	push	word ptr [bp-2]	;@00A8D
	db	0E8h, 0D0h, 9	; call L01463	;@00A90
	mov	ax, word ptr [bp+4]	;@00A93
	dec	ax	;@00A96
	mov	word ptr [bp+4], ax	;@00A97
	or	ax, ax	;@00A9A
	jne	@@2	;@00A9C
	add	sp, 4	;@00A9E
	jmp	short @@4	;@00AA1
@@2:	pop	bx	;@00AA3
	pop	es	;@00AA4
@@3:	cmp	bl, byte ptr es:[6D4h]	;@00AA5
	jne	@@1	;@00AAA
@@4:	push	0FFFFh	;@00AAC
	push	0FFFFh	;@00AAE
	call	word ptr ds:[2Ah]	;@00AB0
	mov	ds, word ptr ds:[0Ch]	;@00AB4
	mov	ax, word ptr [bp-4]	;@00AB8
	mov	word ptr ds:[6D8h], ax	;@00ABB
	pop	ds	;@00ABE
	leave	;@00ABF
	ret	2	;@00AC0
L00AC3:	push	bp	;@00AC3
	mov	bp, sp	;@00AC4
	sub	sp, 4	;@00AC6
	push	ds	;@00AC9
	mov	ds, word ptr cs:L0532F+2	;@00ACA
	mov	ax, word ptr ds:[6D8h]	;@00ACF
	mov	word ptr [bp-4], ax	;@00AD2
	mov	ax, word ptr ds:[6DEh]	;@00AD5
	mov	word ptr ds:[6D8h], ax	;@00AD8
	mov	ds, word ptr ds:[6D8h]	;@00ADB
	mov	ax, word ptr ds:[10h]	;@00ADF
	jmp	short @@5	;@00AE2
@@1:	mov	bx, word ptr [bp-2]	;@00AE4
	test	word ptr [bx+0Eh], 400h	;@00AE7
	je	@@4	;@00AEC
	push	word ptr [bp-2]	;@00AEE
	db	0E8h, 6Fh, 9	; call L01463	;@00AF1
	mov	ax, word ptr [bp+4]	;@00AF4
	dec	ax	;@00AF7
	mov	word ptr [bp+4], ax	;@00AF8
	or	ax, ax	;@00AFB
	je	@@6	;@00AFD
	mov	bx, word ptr [bp-2]	;@00AFF
	cmp	word ptr [bx+8], 0	;@00B02
	jne	@@4	;@00B06
	jmp	short @@3	;@00B08
@@2:	mov	bx, word ptr [bp-2]	;@00B0A
	mov	ax, word ptr [bx+0Ah]	;@00B0D
	mov	word ptr [bp-2], ax	;@00B10
@@3:	mov	bx, word ptr [bp-2]	;@00B13
	cmp	word ptr [bx+8], 0	;@00B16
	je	@@2	;@00B1A
	mov	ax, word ptr [bx+8]	;@00B1C
	mov	word ptr [bp-2], ax	;@00B1F
@@4:	mov	bx, word ptr [bp-2]	;@00B22
	mov	ax, word ptr [bx+0Ah]	;@00B25
@@5:	mov	word ptr [bp-2], ax	;@00B28
	mov	ax, word ptr [bp-2]	;@00B2B
	cmp	ax, word ptr ds:[12h]	;@00B2E
	jne	@@1	;@00B32
@@6:	push	0FFFFh	;@00B34
	push	0FFFFh	;@00B36
	call	word ptr ds:[2Ah]	;@00B38
	mov	ds, word ptr ds:[0Ch]	;@00B3C
	mov	ax, word ptr [bp-4]	;@00B40
	mov	word ptr ds:[6D8h], ax	;@00B43
	pop	ds	;@00B46
	leave	;@00B47
	ret	2	;@00B48
L00B4B:	push	bp	;@00B4B
	mov	bp, sp	;@00B4C
	sub	sp, 6	;@00B4E
	mov	byte ptr [bp-1], 0	;@00B51
	push	ds	;@00B55
	mov	ds, word ptr cs:L0532F+2	;@00B56
	cmp	word ptr ds:[60C0h], 0Ah	;@00B5B
	jb	@@1	;@00B60
	db	0E9h, 0EBh, 0	; jmp @@16	;@00B62
@@1:	mov	ax, 1005h	;@00B65
	db	0E9h, 0F2h, 0	; jmp @@18	;@00B68
@@2:	mov	ds, word ptr cs:L0532F+2	;@00B6B
	mov	ax, word ptr ds:[6DCh]	;@00B70
	mov	ds, word ptr ds:[6DEh]	;@00B73
	add	ax, 8	;@00B77
	cmp	ax, word ptr ds:[48h]	;@00B7A
	ja	@@3	;@00B7E
	db	0E9h, 0C8h, 0	; jmp @@15	;@00B80
@@3:	cmp	byte ptr [bp-1], 0	;@00B83
	db	75h, 8	; jne @@4	;@00B87
	push	14h	;@00B89
	db	0E8h, 0C9h, 0FDh	; call L10957	;@00B8B
	db	0E9h, 0B5h, 0	; jmp @@14	;@00B8E
@@4:	cmp	byte ptr [bp-1], 1	;@00B91
	je	@@5	;@00B95
	jmp	@@12	;@00B97
@@5:	mov	word ptr [bp-4], 0	;@00B9A
	jmp	@@10	;@00B9F
@@6:	mov	ds, word ptr cs:L0532F+2	;@00BA2
	mov	bx, word ptr [bp-4]	;@00BA7
	shl	bx, 1	;@00BAA
	mov	cx, word ptr [bx+6DEh]	;@00BAC
	jcxz	@@9	;@00BB0
	mov	ds, cx	;@00BB2
	cmp	word ptr [bp-4], 5	;@00BB4
	je	@@9	;@00BB8
	cmp	word ptr [bp-4], 2	;@00BBA
	je	@@7	;@00BBE
	cmp	word ptr [bp-4], 3	;@00BC0
	jne	@@8	;@00BC4
@@7:	mov	ax, 0B87h	;@00BC6
	mov	es, ax	;@00BC9
	mov	al, byte ptr es:[71Bh]	;@00BCB
	mov	byte ptr [bp-5], al	;@00BCF
	mov	ax, 0B87h	;@00BD2
	mov	es, ax	;@00BD5
	mov	al, byte ptr es:[71Ch]	;@00BD7
	mov	byte ptr [bp-6], al	;@00BDB
	mov	ax, 0B87h	;@00BDE
	mov	es, ax	;@00BE1
	mov	byte ptr es:[71Bh], 0	;@00BE3
	mov	ax, 0B87h	;@00BE9
	mov	es, ax	;@00BEC
	mov	byte ptr es:[71Ch], 1	;@00BEE
	push	0FFFFh	;@00BF4
	push	0FFFFh	;@00BF6
	call	word ptr ds:[2Ah]	;@00BF8
	mov	ax, 0B87h	;@00BFC
	mov	dl, byte ptr [bp-5]	;@00BFF
	mov	es, ax	;@00C02
	mov	byte ptr es:[71Bh], dl	;@00C04
	mov	ax, 0B87h	;@00C09
	mov	dl, byte ptr [bp-6]	;@00C0C
	mov	es, ax	;@00C0F
	mov	byte ptr es:[71Ch], dl	;@00C11
	jmp	short @@9	;@00C16
@@8:	push	0FFFFh	;@00C18
	push	0FFFFh	;@00C1A
	call	word ptr ds:[2Ah]	;@00C1C
@@9:	inc	word ptr [bp-4]	;@00C20
@@10:	cmp	word ptr [bp-4], 6	;@00C23
	jge	@@11	;@00C27
	jmp	@@6	;@00C29
@@11:	jmp	short @@14	;@00C2C
@@12:	cmp	byte ptr [bp-1], 2	;@00C2E
	jne	@@13	;@00C32
	push	14h	;@00C34
	call	L00A4A	;@00C36
	jmp	short @@14	;@00C39
@@13:	cmp	byte ptr [bp-1], 3	;@00C3B
	jne	@@14	;@00C3F
	push	14h	;@00C41
	call	L00AC3	;@00C43
@@14:	inc	byte ptr [bp-1]	;@00C46
	jmp	short @@16	;@00C49
@@15:	pop	ds	;@00C4B
	xor	ax, ax	;@00C4C
	jmp	short @@18	;@00C4E
@@16:	cmp	byte ptr [bp-1], 5	;@00C50
	jae	@@17	;@00C54
	jmp	@@2	;@00C56
@@17:	pop	ds	;@00C59
	mov	ax, 1001h	;@00C5A
@@18:	leave	;@00C5D
	ret	;@00C5E
L00C5F:	push	bp	;@00C5F
	mov	bp, sp	;@00C60
	dec	sp	;@00C62
	dec	sp	;@00C63
	push	ds	;@00C64
	mov	ds, word ptr cs:L0532F+2	;@00C65
	mov	ds, word ptr ds:[6DEh]	;@00C6A
	mov	ax, word ptr ds:[46h]	;@00C6E
	mov	word ptr [bp-2], ax	;@00C71
	mov	bx, word ptr [bp-2]	;@00C74
	mov	ax, word ptr [bx+14h]	;@00C77
	mov	word ptr ds:[46h], ax	;@00C7A
	mov	word ptr [bx+14h], 0	;@00C7D
	dec	word ptr ds:[48h]	;@00C82
	pop	ds	;@00C86
	mov	ax, word ptr [bp-2]	;@00C87
	sub	ax, word ptr ds:[24h]	;@00C8A
	leave	;@00C8E
	ret	;@00C8F
L00C90:	push	bp	;@00C90
	mov	bp, sp	;@00C91
	mov	bx, word ptr [bp+4]	;@00C93
	mov	ax, word ptr [bx+8]	;@00C96
	mov	bx, word ptr [bx+0Ah]	;@00C99
	mov	word ptr [bx+8], ax	;@00C9C
	mov	bx, word ptr [bp+4]	;@00C9F
	mov	ax, word ptr [bx+0Ah]	;@00CA2
	mov	bx, word ptr [bx+8]	;@00CA5
	mov	word ptr [bx+0Ah], ax	;@00CA8
	push	ds	;@00CAB
	mov	ax, word ptr ds:[24h]	;@00CAC
	add	word ptr [bp+4], ax	;@00CAF
	mov	ds, word ptr cs:L0532F+2	;@00CB2
	mov	ds, word ptr ds:[6DEh]	;@00CB7
	mov	bx, word ptr [bp+4]	;@00CBB
	xor	ax, ax	;@00CBE
	mov	word ptr [bx+12h], ax	;@00CC0
	mov	word ptr [bx+8], ax	;@00CC3
	mov	ax, word ptr ds:[46h]	;@00CC6
	mov	word ptr [bx+14h], ax	;@00CC9
	mov	ax, word ptr [bp+4]	;@00CCC
	mov	word ptr ds:[46h], ax	;@00CCF
	inc	word ptr ds:[48h]	;@00CD2
	pop	ds	;@00CD6
	pop	bp	;@00CD7
	ret	2	;@00CD8
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 6, 57h, 0A0h, 9, 0, 0Ch, 8, 0A2h, 9	;@00CDB
	db	0, 0FFh, 36h, 36h, 0, 0E8h, 5, 0Fh, 89h, 46h, 0FEh, 0A0h, 9, 0
	db	24h, 0F7h, 0A2h, 9, 0, 83h, 7Eh, 0FEh, 0, 75h, 3, 0EBh, 7Bh, 90h
	db	0FFh, 76h, 0FEh, 0E8h, 3Ch, 30h, 89h, 46h, 0FCh, 8Bh, 5Eh, 0FEh
	db	81h, 4Fh, 0Eh, 0, 80h, 0C6h, 47h, 10h, 0, 0C7h, 46h, 0FAh, 0, 0
	db	0C4h, 5Eh, 0FAh, 8Bh, 46h, 0FCh, 26h, 89h, 47h, 2, 8Bh, 46h, 0FCh
	db	8Bh, 56h, 0FAh, 42h, 42h, 8Bh, 5Eh, 0FEh, 89h, 47h, 14h, 89h, 57h
	db	12h, 0FFh, 76h, 0FEh, 6Ah, 0, 0E8h, 0Bh, 2Dh, 0C4h, 5Eh, 0FAh
	db	26h, 0C7h, 47h, 4, 0, 0, 0A1h, 34h, 0, 26h, 89h, 7, 8Bh, 46h, 0FCh
	db	0A3h, 34h, 0, 26h, 0C7h, 47h, 6, 0Ah, 0, 57h, 0C4h, 7Eh, 0FAh
	db	8Bh, 16h, 36h, 0, 83h, 0C7h, 8, 0FCh, 33h, 0C0h, 0ABh, 8Dh, 45h
	db	4, 0ABh, 3Bh, 0FAh, 72h, 0F5h, 26h, 0C7h, 45h, 0FEh, 0, 0, 5Fh
	db	8Ch, 0C0h, 0EBh, 2, 33h, 0C0h, 5Fh, 0C9h, 0C3h, 55h, 8Bh, 0ECh
	db	83h, 0ECh, 8, 56h, 0C7h, 46h, 0FCh, 0, 0, 0A1h, 34h, 0, 0EBh, 10h
	db	0C4h, 5Eh, 0FCh, 26h, 83h, 7Fh, 6, 0, 75h, 1Fh, 0C4h, 5Eh, 0FCh
	db	26h, 8Bh, 7, 89h, 46h, 0FEh, 83h, 7Eh, 0FEh, 0, 75h, 0E7h, 0E8h
	db	2Ah, 0FFh, 89h, 46h, 0FEh, 0Bh, 0C0h, 75h, 6, 33h, 0D2h, 33h, 0C0h
	db	0EBh, 2Eh, 0C4h, 5Eh, 0FCh, 26h, 0FFh, 47h, 4, 8Bh, 46h, 0FEh
	db	89h, 46h, 0FAh, 26h, 8Bh, 47h, 6, 89h, 46h, 0F8h, 6, 0C4h, 76h
	db	0F8h, 26h, 8Bh, 4, 7, 26h, 89h, 47h, 6, 0C4h, 5Eh, 0F8h, 26h, 0C7h
	db	7, 0, 0, 8Bh, 56h, 0FAh, 8Bh, 46h, 0F8h, 5Eh, 0C9h, 0C3h
L00DEF:	push	bp	;@00DEF
	mov	bp, sp	;@00DF0
	sub	sp, 0Ah	;@00DF2
	push	ds	;@00DF5
	mov	ds, word ptr cs:L0532F+2	;@00DF6
	mov	ds, word ptr ds:[6DEh]	;@00DFB
	mov	ax, word ptr [bp+6]	;@00DFF
	mov	word ptr [bp-2], ax	;@00E02
	mov	word ptr [bp-4], 0	;@00E05
	les	bx, dword ptr [bp-4]	;@00E0A
	mov	ax, word ptr es:[bx+4]	;@00E0D
	dec	ax	;@00E11
	mov	word ptr es:[bx+4], ax	;@00E12
	or	ax, ax	;@00E16
	jne	@@5	;@00E18
	mov	ax, word ptr [bp-2]	;@00E1A
	cmp	ax, word ptr ds:[34h]	;@00E1D
	jne	@@1	;@00E21
	mov	ax, word ptr es:[bx]	;@00E23
	mov	word ptr ds:[34h], ax	;@00E26
	jmp	short @@4	;@00E29
@@1:	mov	ax, word ptr ds:[34h]	;@00E2B
	mov	word ptr [bp-8], ax	;@00E2E
	mov	word ptr [bp-0Ah], 0	;@00E31
	jmp	short @@3	;@00E36
@@2:	les	bx, dword ptr [bp-0Ah]	;@00E38
	mov	ax, word ptr es:[bx]	;@00E3B
	mov	word ptr [bp-8], ax	;@00E3E
@@3:	les	bx, dword ptr [bp-0Ah]	;@00E41
	mov	ax, word ptr es:[bx]	;@00E44
	cmp	ax, word ptr [bp-2]	;@00E47
	jne	@@2	;@00E4A
	les	bx, dword ptr [bp-4]	;@00E4C
	mov	ax, word ptr es:[bx]	;@00E4F
	les	bx, dword ptr [bp-0Ah]	;@00E52
	mov	word ptr es:[bx], ax	;@00E55
@@4:	push	ds	;@00E58
	mov	ds, word ptr ds:[0Ch]	;@00E59
	push	word ptr [bp-2]	;@00E5D
	push	ss	;@00E60
	lea	ax, [bp-6]	;@00E61
	push	ax	;@00E64
	call	L03B3B	;@00E65
	pop	ds	;@00E68
	mov	bx, word ptr [bp-6]	;@00E69
	les	bx, dword ptr [bx+12h]	;@00E6C
	push	word ptr es:[bx]	;@00E6F
	call	L03DB3	;@00E72
	push	word ptr [bp-6]	;@00E75
	call	L011B4	;@00E78
	jmp	short @@6	;@00E7B
@@5:	les	bx, dword ptr [bp-4]	;@00E7D
	mov	ax, word ptr es:[bx+6]	;@00E80
	les	bx, dword ptr [bp+4]	;@00E84
	mov	word ptr es:[bx], ax	;@00E87
	les	bx, dword ptr [bp-4]	;@00E8A
	mov	ax, word ptr [bp+4]	;@00E8D
	mov	word ptr es:[bx+6], ax	;@00E90
@@6:	pop	ds	;@00E94
	leave	;@00E95
	ret	4	;@00E96
L00E99:	push	bp	;@00E99
	mov	bp, sp	;@00E9A
	dec	sp	;@00E9C
	dec	sp	;@00E9D
	mov	bx, word ptr [bp+4]	;@00E9E
	mov	ax, word ptr [bx+0Ah]	;@00EA1
	mov	word ptr [bp-2], ax	;@00EA4
	mov	bx, word ptr [bp-2]	;@00EA7
	mov	bx, word ptr [bx+0Ah]	;@00EAA
	mov	ax, word ptr [bp+4]	;@00EAD
	mov	word ptr [bx+8], ax	;@00EB0
	mov	bx, word ptr [bp+4]	;@00EB3
	mov	bx, word ptr [bx+8]	;@00EB6
	mov	ax, word ptr [bp-2]	;@00EB9
	mov	word ptr [bx+0Ah], ax	;@00EBC
	mov	bx, word ptr [bp+4]	;@00EBF
	mov	ax, word ptr [bx+8]	;@00EC2
	mov	bx, word ptr [bp-2]	;@00EC5
	mov	word ptr [bx+8], ax	;@00EC8
	mov	ax, word ptr [bx+0Ah]	;@00ECB
	mov	bx, word ptr [bp+4]	;@00ECE
	mov	word ptr [bx+0Ah], ax	;@00ED1
	mov	bx, word ptr [bp-2]	;@00ED4
	mov	ax, word ptr [bp+4]	;@00ED7
	mov	word ptr [bx+0Ah], ax	;@00EDA
	mov	bx, word ptr [bp+4]	;@00EDD
	mov	ax, word ptr [bp-2]	;@00EE0
	mov	word ptr [bx+8], ax	;@00EE3
	mov	ax, word ptr [bx+2]	;@00EE6
	mov	dx, word ptr [bx]	;@00EE9
	mov	bx, word ptr [bp-2]	;@00EEB
	mov	word ptr [bx+2], ax	;@00EEE
	mov	word ptr [bx], dx	;@00EF1
	mov	ax, word ptr [bx+6]	;@00EF3
	mov	dx, word ptr [bx+4]	;@00EF6
	mov	bx, word ptr [bp+4]	;@00EF9
	add	word ptr [bx], dx	;@00EFC
	adc	word ptr [bx+2], ax	;@00EFE
	leave	;@00F01
	ret	2	;@00F02
L00F05:	push	bp	;@00F05
	mov	bp, sp	;@00F06
	push	si	;@00F08
	push	di	;@00F09
	push	ds	;@00F0A
	mov	ds, word ptr cs:L0532F+2	;@00F0B
	mov	bx, word ptr [bp+8]	;@00F10
	shl	bx, 1	;@00F13
	mov	ds, word ptr [bx+6DEh]	;@00F15
	cmp	word ptr [bp+4], 0	;@00F19
	jne	@@1	;@00F1D
	call	L00C5F	;@00F1F
	mov	word ptr [bp+4], ax	;@00F22
@@1:	mov	ax, ds	;@00F25
	mov	es, ax	;@00F27
	mov	ds, word ptr cs:L0532F+2	;@00F29
	mov	bx, word ptr [bp+0Ah]	;@00F2E
	shl	bx, 1	;@00F31
	mov	ds, word ptr [bx+6DEh]	;@00F33
	mov	si, word ptr [bp+6]	;@00F37
	mov	di, word ptr [bp+4]	;@00F3A
	add	si, 0Eh	;@00F3D
	add	di, 0Eh	;@00F40
	mov	cx, 6	;@00F43
	cld	;@00F46
	rep movsw	;@00F47
	pop	ds	;@00F49
	mov	ax, word ptr [bp+4]	;@00F4A
	pop	di	;@00F4D
	pop	si	;@00F4E
	pop	bp	;@00F4F
	ret	8	;@00F50
L00F53:	push	bp	;@00F53
	mov	bp, sp	;@00F54
	dec	sp	;@00F56
	dec	sp	;@00F57
	mov	ax, word ptr ds:[14h]	;@00F58
	mov	word ptr [bp-2], ax	;@00F5B
	mov	bx, word ptr [bp-2]	;@00F5E
	mov	ax, word ptr [bx+14h]	;@00F61
	mov	bx, word ptr [bp+4]	;@00F64
	mov	word ptr [bx+14h], ax	;@00F67
	mov	ax, word ptr [bp-2]	;@00F6A
	mov	word ptr [bx+12h], ax	;@00F6D
	mov	bx, word ptr [bp-2]	;@00F70
	mov	ax, word ptr [bp+4]	;@00F73
	mov	word ptr [bx+14h], ax	;@00F76
	mov	bx, word ptr [bp+4]	;@00F79
	mov	bx, word ptr [bx+14h]	;@00F7C
	mov	word ptr [bx+12h], ax	;@00F7F
	mov	bx, word ptr [bp+4]	;@00F82
	mov	word ptr [bx+0Eh], 4	;@00F85
	inc	word ptr ds:[1Ah]	;@00F8A
	mov	ax, word ptr [bx+6]	;@00F8E
	mov	dx, word ptr [bx+4]	;@00F91
	add	word ptr ds:[1Ch], dx	;@00F94
	adc	word ptr ds:[1Eh], ax	;@00F98
	leave	;@00F9C
	ret	2	;@00F9D
L00FA0:	push	bp	;@00FA0
	mov	bp, sp	;@00FA1
	mov	bx, word ptr [bp+4]	;@00FA3
	mov	ax, word ptr [bx+12h]	;@00FA6
	mov	bx, word ptr [bx+14h]	;@00FA9
	mov	word ptr [bx+12h], ax	;@00FAC
	mov	bx, word ptr [bp+4]	;@00FAF
	mov	ax, word ptr [bx+14h]	;@00FB2
	mov	bx, word ptr [bx+12h]	;@00FB5
	mov	word ptr [bx+14h], ax	;@00FB8
	dec	word ptr ds:[1Ah]	;@00FBB
	mov	bx, word ptr [bp+4]	;@00FBF
	mov	ax, word ptr [bx+6]	;@00FC2
	mov	dx, word ptr [bx+4]	;@00FC5
	sub	word ptr ds:[1Ch], dx	;@00FC8
	sbb	word ptr ds:[1Eh], ax	;@00FCC
	pop	bp	;@00FD0
	ret	2	;@00FD1
L00FD4:	push	bp	;@00FD4
	mov	bp, sp	;@00FD5
	mov	bx, word ptr [bp+6]	;@00FD7
	mov	ax, word ptr [bx+0Ah]	;@00FDA
	mov	bx, word ptr [bp+4]	;@00FDD
	mov	word ptr [bx+0Ah], ax	;@00FE0
	mov	ax, word ptr [bp+6]	;@00FE3
	mov	word ptr [bx+8], ax	;@00FE6
	mov	bx, word ptr [bx+0Ah]	;@00FE9
	mov	ax, word ptr [bp+4]	;@00FEC
	mov	word ptr [bx+8], ax	;@00FEF
	mov	bx, word ptr [bp+6]	;@00FF2
	mov	word ptr [bx+0Ah], ax	;@00FF5
	pop	bp	;@00FF8
	ret	4	;@00FF9
L00FFC:	push	bp	;@00FFC
	mov	bp, sp	;@00FFD
	mov	bx, word ptr [bp+4]	;@00FFF
	mov	ax, word ptr [bx+0Ah]	;@01002
	mov	word ptr ds:[0Eh], ax	;@01005
	mov	bx, word ptr ds:[0Eh]	;@01008
	mov	ax, word ptr [bx+2]	;@0100C
	mov	dx, word ptr [bx]	;@0100F
	mov	bx, word ptr ds:[16h]	;@01011
	cmp	ax, word ptr [bx+2]	;@01015
	jb	@@2	;@01018
	jne	@@1	;@0101A
	cmp	dx, word ptr [bx]	;@0101C
	jb	@@2	;@0101E
@@1:	mov	bx, word ptr ds:[0Eh]	;@01020
	mov	ax, word ptr [bx+2]	;@01024
	mov	dx, word ptr [bx]	;@01027
	mov	bx, word ptr ds:[18h]	;@01029
	cmp	ax, word ptr [bx+2]	;@0102D
	jb	@@3	;@01030
	jne	@@2	;@01032
	cmp	dx, word ptr [bx]	;@01034
	jb	@@3	;@01036
@@2:	mov	ax, word ptr ds:[16h]	;@01038
	mov	word ptr ds:[0Eh], ax	;@0103B
@@3:	pop	bp	;@0103E
	ret	2	;@0103F
L01042:	push	bp	;@01042
	mov	bp, sp	;@01043
	sub	sp, 6	;@01045
	mov	bx, word ptr [bp+0Ah]	;@01048
	mov	ax, word ptr [bx+6]	;@0104B
	mov	dx, word ptr [bx+4]	;@0104E
	sub	dx, word ptr [bp+6]	;@01051
	sbb	ax, word ptr [bp+8]	;@01054
	mov	word ptr [bp-2], ax	;@01057
	mov	word ptr [bp-4], dx	;@0105A
	mov	ax, word ptr [bp+0Ah]	;@0105D
	mov	word ptr [bp-6], ax	;@01060
	mov	al, byte ptr [bp+4]	;@01063
	mov	ah, 0	;@01066
	or	ax, ax	;@01068
	jne	@@1	;@0106A
	push	word ptr [bp+0Ah]	;@0106C
	call	L00FA0	;@0106F
@@1:	cmp	word ptr [bp-2], 0	;@01072
	jb	@@3	;@01076
	ja	@@2	;@01078
	cmp	word ptr [bp-4], 0	;@0107A
	jbe	@@3	;@0107E
@@2:	call	L00C5F	;@01080
	mov	word ptr [bp-6], ax	;@01083
	mov	bx, word ptr [bp-6]	;@01086
	mov	ax, word ptr [bp-2]	;@01089
	mov	dx, word ptr [bp-4]	;@0108C
	mov	word ptr [bx+6], ax	;@0108F
	mov	word ptr [bx+4], dx	;@01092
	mov	bx, word ptr [bp+0Ah]	;@01095
	mov	ax, word ptr [bp+8]	;@01098
	mov	dx, word ptr [bp+6]	;@0109B
	mov	word ptr [bx+6], ax	;@0109E
	mov	word ptr [bx+4], dx	;@010A1
	mov	ax, word ptr [bx+2]	;@010A4
	mov	dx, word ptr [bx]	;@010A7
	add	dx, word ptr [bp+6]	;@010A9
	adc	ax, word ptr [bp+8]	;@010AC
	mov	bx, word ptr [bp-6]	;@010AF
	mov	word ptr [bx+2], ax	;@010B2
	mov	word ptr [bx], dx	;@010B5
	push	word ptr [bp+0Ah]	;@010B7
	push	word ptr [bp-6]	;@010BA
	call	L00FD4	;@010BD
	mov	bx, word ptr [bp-6]	;@010C0
	mov	word ptr [bx+0Eh], 4	;@010C3
	mov	al, byte ptr [bp+4]	;@010C8
	mov	ah, 0	;@010CB
	or	ax, ax	;@010CD
	jne	@@4	;@010CF
	push	word ptr [bp-6]	;@010D1
	call	L00F53	;@010D4
	mov	ax, word ptr [bp-6]	;@010D7
	mov	word ptr ds:[20h], ax	;@010DA
	jmp	short @@4	;@010DD
@@3:	mov	al, byte ptr [bp+4]	;@010DF
	mov	ah, 0	;@010E2
	or	ax, ax	;@010E4
	jne	@@4	;@010E6
	mov	bx, word ptr ds:[14h]	;@010E8
	mov	ax, word ptr [bx+14h]	;@010EC
	mov	word ptr ds:[20h], ax	;@010EF
@@4:	mov	bx, word ptr [bp+0Ah]	;@010F2
	mov	word ptr [bx+0Eh], 0	;@010F5
	mov	es, word ptr ds:[0Ch]	;@010FA
	mov	al, byte ptr es:[6CCh]	;@010FE
	mov	bx, word ptr [bp+0Ah]	;@01102
	mov	byte ptr [bx+10h], al	;@01105
	mov	al, byte ptr ds:[8]	;@01108
	mov	byte ptr [bx+17h], al	;@0110B
	mov	byte ptr [bx+16h], 0	;@0110E
	mov	ax, word ptr [bp-6]	;@01112
	leave	;@01115
	ret	8	;@01116
L01119:	push	bp	;@01119
	mov	bp, sp	;@0111A
	dec	sp	;@0111C
	dec	sp	;@0111D
	mov	bx, word ptr [bp+4]	;@0111E
	mov	bx, word ptr [bx+8]	;@01121
	test	word ptr [bx+0Eh], 4	;@01124
	je	@@1	;@01129
	mov	bx, word ptr [bp+4]	;@0112B
	mov	ax, word ptr [bx+8]	;@0112E
	mov	word ptr [bp+4], ax	;@01131
	jmp	short @@5	;@01134
@@1:	jmp	short @@5	;@01136
@@2:	push	word ptr [bp-2]	;@01138
	call	L00FA0	;@0113B
	mov	bx, word ptr [bp-2]	;@0113E
	mov	ax, word ptr [bx+0Ah]	;@01141
	mov	bx, word ptr [bp+4]	;@01144
	mov	word ptr [bx+0Ah], ax	;@01147
	mov	bx, word ptr [bp-2]	;@0114A
	mov	bx, word ptr [bx+0Ah]	;@0114D
	mov	ax, word ptr [bp+4]	;@01150
	mov	word ptr [bx+8], ax	;@01153
	mov	bx, word ptr [bp-2]	;@01156
	mov	ax, word ptr [bx+6]	;@01159
	mov	dx, word ptr [bx+4]	;@0115C
	mov	bx, word ptr [bp+4]	;@0115F
	add	word ptr [bx+4], dx	;@01162
	adc	word ptr [bx+6], ax	;@01165
	mov	bx, word ptr [bp-2]	;@01168
	mov	ax, word ptr [bx+6]	;@0116B
	mov	dx, word ptr [bx+4]	;@0116E
	add	word ptr ds:[1Ch], dx	;@01171
	adc	word ptr ds:[1Eh], ax	;@01175
	mov	ax, word ptr [bp-2]	;@01179
	cmp	ax, word ptr ds:[0Eh]	;@0117C
	jne	@@3	;@01180
	mov	ax, word ptr [bp+4]	;@01182
	mov	word ptr ds:[0Eh], ax	;@01185
@@3:	mov	ax, word ptr [bp-2]	;@01188
	cmp	ax, word ptr ds:[20h]	;@0118B
	jne	@@4	;@0118F
	mov	ax, word ptr [bp+4]	;@01191
	mov	word ptr ds:[20h], ax	;@01194
@@4:	push	word ptr [bp-2]	;@01197
	call	L00C90	;@0119A
@@5:	mov	bx, word ptr [bp+4]	;@0119D
	mov	ax, word ptr [bx+0Ah]	;@011A0
	mov	word ptr [bp-2], ax	;@011A3
	mov	bx, word ptr [bp-2]	;@011A6
	test	word ptr [bx+0Eh], 4	;@011A9
	jne	@@2	;@011AE
	leave	;@011B0
	ret	2	;@011B1
L011B4:	push	bp	;@011B4
	mov	bp, sp	;@011B5
	test	byte ptr ds:[9], 4	;@011B7
	je	@@1	;@011BC
	mov	bx, word ptr [bp+4]	;@011BE
	test	word ptr [bx+0Eh], 60h	;@011C1
	je	@@1	;@011C6
	mov	es, word ptr ds:[0Ch]	;@011C8
	dec	word ptr es:[6DCh]	;@011CC
	mov	bx, word ptr [bp+4]	;@011D1
	mov	ax, word ptr [bx+6]	;@011D4
	mov	dx, word ptr [bx+4]	;@011D7
	sub	word ptr ds:[4Ah], dx	;@011DA
	sbb	word ptr ds:[4Ch], ax	;@011DE
@@1:	mov	bx, word ptr [bp+4]	;@011E2
	test	word ptr [bx+0Eh], 2000h	;@011E5
	je	@@2	;@011EA
	push	word ptr [bx+18h]	;@011EC
	push	1	;@011EF
	mov	al, byte ptr [bx+17h]	;@011F1
	mov	ah, 0	;@011F4
	sar	ax, 3	;@011F6
	push	ax	;@011F9
	call	L03980	;@011FA
	add	sp, 6	;@011FD
@@2:	mov	bx, word ptr [bp+4]	;@01200
	test	word ptr [bx+0Eh], 1000h	;@01203
	je	@@3	;@01208
	push	word ptr [bp+4]	;@0120A
	call	L015F1	;@0120D
@@3:	push	word ptr [bp+4]	;@01210
	call	L00F53	;@01213
	push	word ptr [bp+4]	;@01216
	call	L01119	;@01219
	xor	ax, ax	;@0121C
	pop	bp	;@0121E
	ret	2	;@0121F
L01222:	push	bp	;@01222
	mov	bp, sp	;@01223
	sub	sp, 6	;@01225
	mov	bx, word ptr [bp+4]	;@01228
	test	word ptr [bx+0Eh], 2000h	;@0122B
	je	@@1	;@01230
	mov	word ptr [bp-4], 0	;@01232
	mov	al, byte ptr [bx+17h]	;@01237
	mov	ah, 0	;@0123A
	sar	ax, 3	;@0123C
	mov	word ptr [bp-2], ax	;@0123F
	mov	ax, word ptr [bx+18h]	;@01242
	mov	word ptr [bp-6], ax	;@01245
	push	word ptr [bp+4]	;@01248
	push	4	;@0124B
	push	word ptr [bx+14h]	;@0124D
	push	word ptr [bx+12h]	;@01250
	mov	ax, word ptr [bx+0Eh]	;@01253
	and	ax, 400h	;@01256
	push	ax	;@01259
	call	L04EEA	;@0125A
	jmp	@@11	;@0125D
@@1:	test	byte ptr ds:[9], 8	;@01260
	je	@@4	;@01265
	cmp	byte ptr ds:[8], 1	;@01267
	jne	@@2	;@0126C
	mov	word ptr [bp-2], 0	;@0126E
	jmp	short @@3	;@01273
@@2:	mov	word ptr [bp-2], 1	;@01275
@@3:	mov	bx, word ptr [bp+4]	;@0127A
	push	word ptr [bx+0Ch]	;@0127D
	push	0	;@01280
	push	word ptr [bp-2]	;@01282
	call	L03980	;@01285
	add	sp, 6	;@01288
	mov	word ptr [bp-6], ax	;@0128B
	or	ax, ax	;@0128E
	je	@@4	;@01290
	mov	bx, word ptr [bp+4]	;@01292
	push	word ptr [bx+2]	;@01295
	push	word ptr [bx]	;@01298
	push	word ptr [bp-6]	;@0129A
	push	2	;@0129D
	push	word ptr [bp-2]	;@0129F
	call	L03980	;@012A2
	add	sp, 0Ah	;@012A5
	jmp	@@11	;@012A8
@@4:	mov	bx, word ptr [bp+4]	;@012AB
	test	word ptr [bx+0Eh], 20h	;@012AE
	jne	@@5	;@012B3
	jmp	@@20	;@012B5
@@5:	mov	bx, word ptr [bp+4]	;@012B8
	mov	ax, word ptr [bx+0Eh]	;@012BB
	and	ax, 3	;@012BE
	inc	ax	;@012C1
	inc	ax	;@012C2
	mov	word ptr [bp-4], ax	;@012C3
	mov	word ptr [bp-2], 4	;@012C6
	jmp	short @@9	;@012CB
@@6:	mov	bx, word ptr [bp+4]	;@012CD
	push	word ptr [bx+0Ch]	;@012D0
	push	0	;@012D3
	push	word ptr [bp-2]	;@012D5
	call	L03980	;@012D8
	add	sp, 6	;@012DB
	mov	word ptr [bp-6], ax	;@012DE
	or	ax, ax	;@012E1
	je	@@8	;@012E3
	mov	bx, word ptr [bp+4]	;@012E5
	cmp	byte ptr [bx+16h], 0	;@012E8
	je	@@7	;@012EC
	push	word ptr [bp+4]	;@012EE
	push	4	;@012F1
	call	L03A4D	;@012F3
	push	word ptr [bp+4]	;@012F6
	push	4	;@012F9
	mov	bx, word ptr [bp+4]	;@012FB
	push	word ptr [bx+14h]	;@012FE
	push	word ptr [bx+12h]	;@01301
	mov	ax, word ptr [bx+0Eh]	;@01304
	and	ax, 400h	;@01307
	push	ax	;@0130A
	call	L04EEA	;@0130B
	mov	ds, word ptr cs:L0532F+2	;@0130E
	mov	ds, word ptr ds:[6D8h]	;@01313
@@7:	mov	bx, word ptr [bp+4]	;@01317
	push	word ptr [bx+2]	;@0131A
	push	word ptr [bx]	;@0131D
	push	word ptr [bp-6]	;@0131F
	push	2	;@01322
	push	word ptr [bp-2]	;@01324
	call	L03980	;@01327
	add	sp, 0Ah	;@0132A
	jmp	short @@10	;@0132D
@@8:	dec	word ptr [bp-2]	;@0132F
@@9:	mov	ax, word ptr [bp-2]	;@01332
	cmp	ax, word ptr [bp-4]	;@01335
	jge	@@6	;@01338
@@10:	mov	ax, word ptr [bp-2]	;@0133A
	cmp	ax, word ptr [bp-4]	;@0133D
	jge	@@11	;@01340
	jmp	@@20	;@01342
@@11:	mov	bx, word ptr [bp+4]	;@01345
	test	word ptr [bx+0Eh], 60h	;@01348
	je	@@12	;@0134D
	mov	es, word ptr ds:[0Ch]	;@0134F
	dec	word ptr es:[6DCh]	;@01353
	mov	bx, word ptr [bp+4]	;@01358
	mov	ax, word ptr [bx+6]	;@0135B
	mov	dx, word ptr [bx+4]	;@0135E
	sub	word ptr ds:[4Ah], dx	;@01361
	sbb	word ptr ds:[4Ch], ax	;@01365
@@12:	test	byte ptr ds:[9], 2	;@01369
	je	@@14	;@0136E
	mov	dx, word ptr ds:[4Ch]	;@01370
	mov	ax, word ptr ds:[4Ah]	;@01374
	shr	dx, 1	;@01377
	rcr	ax, 1	;@01379
	shr	dx, 1	;@0137B
	rcr	ax, 1	;@0137D
	cmp	dx, word ptr ds:[42h]	;@0137F
	jb	@@14	;@01383
	ja	@@13	;@01385
	cmp	ax, word ptr ds:[40h]	;@01387
	jbe	@@14	;@0138B
@@13:	call	L0172E	;@0138D
@@14:	mov	bx, word ptr [bp+4]	;@01390
	test	word ptr [bx+0Eh], 1000h	;@01393
	je	@@15	;@01398
	push	word ptr [bp+4]	;@0139A
	call	L015F1	;@0139D
@@15:	mov	al, byte ptr ds:[8]	;@013A0
	mov	ah, 0	;@013A3
	push	ax	;@013A5
	push	word ptr [bp-2]	;@013A6
	push	word ptr [bp+4]	;@013A9
	push	word ptr [bp-6]	;@013AC
	call	L00F05	;@013AF
	mov	bx, word ptr [bp+4]	;@013B2
	test	word ptr [bx+0Eh], 400h	;@013B5
	je	@@16	;@013BA
	mov	ax, word ptr [bx+6]	;@013BC
	mov	dx, word ptr [bx+4]	;@013BF
	sub	word ptr ds:[38h], dx	;@013C2
	sbb	word ptr ds:[3Ah], ax	;@013C6
@@16:	push	word ptr [bp+4]	;@013CA
	call	L00F53	;@013CD
	push	word ptr [bp+4]	;@013D0
	call	L01119	;@013D3
	mov	ds, word ptr cs:L0532F+2	;@013D6
	mov	bx, word ptr [bp-2]	;@013DB
	shl	bx, 1	;@013DE
	mov	ds, word ptr [bx+6DEh]	;@013E0
	mov	bx, word ptr [bp-6]	;@013E4
	mov	al, byte ptr ds:[8]	;@013E7
	mov	byte ptr [bx+17h], al	;@013EA
	mov	al, byte ptr ds:[9]	;@013ED
	mov	ah, 0	;@013F0
	test	ax, 4	;@013F2
	jne	@@17	;@013F5
	and	word ptr [bx+0Eh], 0DFFFh	;@013F7
	or	word ptr [bx+0Eh], 80h	;@013FC
	push	word ptr [bp-6]	;@01401
	push	2	;@01404
	call	L03A4D	;@01406
	jmp	short @@19	;@01409
@@17:	push	word ptr [bp-6]	;@0140B
	push	4	;@0140E
	call	L03A4D	;@01410
	mov	bx, word ptr [bp-6]	;@01413
	test	word ptr [bx+0Eh], 400h	;@01416
	je	@@18	;@0141B
	mov	ax, word ptr [bx+6]	;@0141D
	mov	dx, word ptr [bx+4]	;@01420
	add	word ptr ds:[38h], dx	;@01423
	adc	word ptr ds:[3Ah], ax	;@01427
@@18:	mov	bx, word ptr [bp-6]	;@0142B
	test	word ptr [bx+0Eh], 60h	;@0142E
	je	@@19	;@01433
	mov	es, word ptr ds:[0Ch]	;@01435
	inc	word ptr es:[6DCh]	;@01439
	mov	bx, word ptr [bp-6]	;@0143E
	mov	ax, word ptr [bx+6]	;@01441
	mov	dx, word ptr [bx+4]	;@01444
	add	word ptr ds:[4Ah], dx	;@01447
	adc	word ptr ds:[4Ch], ax	;@0144B
@@19:	mov	ds, word ptr cs:L0532F+2	;@0144F
	mov	ds, word ptr ds:[6D8h]	;@01454
	xor	ax, ax	;@01458
	jmp	short @@21	;@0145A
@@20:	mov	ax, 1000h	;@0145C
@@21:	leave	;@0145F
	ret	2	;@01460
L01463:	push	bp	;@01463
	mov	bp, sp	;@01464
	sub	sp, 4	;@01466
	mov	word ptr [bp-4], 0	;@01469
	push	word ptr [bp+4]	;@0146E
	push	4	;@01471
	call	L03A4D	;@01473
	mov	bx, word ptr [bp+4]	;@01476
	test	word ptr [bx+0Eh], 2000h	;@01479
	je	@@1	;@0147E
	push	word ptr [bx+18h]	;@01480
	push	1	;@01483
	mov	al, byte ptr [bx+17h]	;@01485
	mov	ah, 0	;@01488
	sar	ax, 3	;@0148A
	push	ax	;@0148D
	call	L03980	;@0148E
	add	sp, 6	;@01491
	mov	bx, word ptr [bp+4]	;@01494
	and	word ptr [bx+0Eh], 0DFFFh	;@01497
@@1:	test	byte ptr ds:[9], 2	;@0149C
	je	@@3	;@014A1
	mov	dx, word ptr ds:[4Ch]	;@014A3
	mov	ax, word ptr ds:[4Ah]	;@014A7
	shr	dx, 1	;@014AA
	rcr	ax, 1	;@014AC
	shr	dx, 1	;@014AE
	rcr	ax, 1	;@014B0
	cmp	dx, word ptr ds:[42h]	;@014B2
	jb	@@3	;@014B6
	ja	@@2	;@014B8
	cmp	ax, word ptr ds:[40h]	;@014BA
	jbe	@@3	;@014BE
@@2:	call	L0172E	;@014C0
@@3:	mov	bx, word ptr [bp+4]	;@014C3
	cmp	byte ptr [bx+16h], 0	;@014C6
	je	@@4	;@014CA
	push	word ptr [bp+4]	;@014CC
	push	1	;@014CF
	push	word ptr [bx+14h]	;@014D1
	push	word ptr [bx+12h]	;@014D4
	push	0	;@014D7
	call	L04EEA	;@014D9
	mov	word ptr [bp-4], ax	;@014DC
@@4:	mov	ds, word ptr cs:L0532F+2	;@014DF
	mov	ds, word ptr ds:[6D8h]	;@014E4
	cmp	word ptr [bp-4], 0	;@014E8
	je	@@5	;@014EC
	jmp	@@12	;@014EE
@@5:	mov	bx, word ptr [bp+4]	;@014F1
	push	word ptr [bx+0Ch]	;@014F4
	push	0	;@014F7
	push	5	;@014F9
	call	L03980	;@014FB
	add	sp, 6	;@014FE
	mov	word ptr [bp-2], ax	;@01501
	or	ax, ax	;@01504
	jne	@@6	;@01506
	jmp	@@11	;@01508
@@6:	mov	bx, word ptr [bp+4]	;@0150B
	test	word ptr [bx+0Eh], 1000h	;@0150E
	je	@@7	;@01513
	push	word ptr [bp+4]	;@01515
	call	L015F1	;@01518
@@7:	mov	al, byte ptr ds:[8]	;@0151B
	mov	ah, 0	;@0151E
	push	ax	;@01520
	push	5	;@01521
	push	word ptr [bp+4]	;@01523
	push	word ptr [bp-2]	;@01526
	call	L00F05	;@01529
	mov	bx, word ptr [bp+4]	;@0152C
	test	word ptr [bx+0Eh], 400h	;@0152F
	je	@@8	;@01534
	mov	ax, word ptr [bx+6]	;@01536
	mov	dx, word ptr [bx+4]	;@01539
	sub	word ptr ds:[38h], dx	;@0153C
	sbb	word ptr ds:[3Ah], ax	;@01540
@@8:	mov	ds, word ptr cs:L0532F+2	;@01544
	mov	ds, word ptr ds:[6E8h]	;@01549
	mov	bx, word ptr [bp-2]	;@0154D
	or	word ptr [bx+0Eh], 100h	;@01550
	mov	al, byte ptr ds:[8]	;@01555
	mov	byte ptr [bx+17h], al	;@01558
	test	word ptr [bx+0Eh], 400h	;@0155B
	je	@@9	;@01560
	push	word ptr [bx+14h]	;@01562
	push	word ptr [bx+12h]	;@01565
	db	0E8h, 32h, 46h	; call OVR_IMAGE_SIZE	;@01568
	mov	bx, word ptr [bp-2]	;@0156B
	mov	word ptr [bx+0Ch], ax	;@0156E
@@9:	push	word ptr [bp-2]	;@01571
	push	2	;@01574
	call	L03A4D	;@01576
	mov	ds, word ptr cs:L0532F+2	;@01579
	mov	ds, word ptr ds:[6D8h]	;@0157E
	mov	bx, word ptr [bp+4]	;@01582
	test	word ptr [bx+0Eh], 60h	;@01585
	je	@@10	;@0158A
	mov	es, word ptr ds:[0Ch]	;@0158C
	dec	word ptr es:[6DCh]	;@01590
	mov	bx, word ptr [bp+4]	;@01595
	mov	ax, word ptr [bx+6]	;@01598
	mov	dx, word ptr [bx+4]	;@0159B
	sub	word ptr ds:[4Ah], dx	;@0159E
	sbb	word ptr ds:[4Ch], ax	;@015A2
@@10:	push	word ptr [bp+4]	;@015A6
	call	L00F53	;@015A9
	push	word ptr [bp+4]	;@015AC
	call	L01119	;@015AF
	jmp	short @@15	;@015B2
@@11:	mov	ax, 1000h	;@015B4
	jmp	short @@16	;@015B7
@@12:	mov	bx, word ptr [bp+4]	;@015B9
	les	bx, dword ptr [bx+12h]	;@015BC
	push	word ptr es:[bx]	;@015BF
	call	L03DB3	;@015C2
	mov	bx, word ptr [bp+4]	;@015C5
	test	word ptr [bx+0Eh], 4000h	;@015C8
	je	@@13	;@015CD
	push	word ptr [bx+14h]	;@015CF
	push	word ptr [bx+12h]	;@015D2
	call	L00DEF	;@015D5
	jmp	short @@14	;@015D8
@@13:	mov	bx, word ptr [bp+4]	;@015DA
	les	bx, dword ptr [bx+12h]	;@015DD
	mov	word ptr es:[bx], 0	;@015E0
@@14:	push	word ptr [bp+4]	;@015E5
	call	L011B4	;@015E8
@@15:	xor	ax, ax	;@015EB
@@16:	leave	;@015ED
	ret	2	;@015EE
L015F1:	push	bp	;@015F1
	mov	bp, sp	;@015F2
	mov	es, word ptr ds:[0Ch]	;@015F4
	mov	bx, word ptr [bp+4]	;@015F8
	mov	bl, byte ptr [bx+11h]	;@015FB
	xor	bh, bh	;@015FE
	shl	bx, 1	;@01600
	mov	word ptr es:[bx+5EBAh], 0	;@01602
	mov	bx, word ptr [bp+4]	;@01609
	test	word ptr [bx+0Eh], 800h	;@0160C
	je	@@1	;@01611
	mov	ax, word ptr [bx+6]	;@01613
	mov	dx, word ptr [bx+4]	;@01616
	sub	word ptr ds:[40h], dx	;@01619
	sbb	word ptr ds:[42h], ax	;@0161D
@@1:	mov	bx, word ptr [bp+4]	;@01621
	and	word ptr [bx+0Eh], 0E7FFh	;@01624
	pop	bp	;@01629
	ret	2	;@0162A
L0162D:	push	bp	;@0162D
	mov	bp, sp	;@0162E
	mov	bx, word ptr [bp+4]	;@01630
	test	word ptr [bx+0Eh], 8000h	;@01633
	jne	@@1	;@01638
	mov	bx, word ptr [bp+4]	;@0163A
	test	word ptr [bx+0Eh], 400h	;@0163D
	mov	bx, word ptr [bp+4]	;@01642
	mov	ax, word ptr [bx+6]	;@01645
	mov	dx, word ptr [bx+4]	;@01648
	add	word ptr ds:[40h], dx	;@0164B
	adc	word ptr ds:[42h], ax	;@0164F
	or	word ptr [bx+0Eh], 800h	;@01653
	push	word ptr [bp+4]	;@01658
	push	2	;@0165B
	call	L03A4D	;@0165D
@@1:	pop	bp	;@01660
	ret	2	;@01661
L01664:	push	bp	;@01664
	mov	bp, sp	;@01665
	mov	bx, word ptr [bp+4]	;@01667
	test	word ptr [bx+0Eh], 800h	;@0166A
	je	@@1	;@0166F
	and	word ptr [bx+0Eh], 0F7FFh	;@01671
	push	word ptr [bp+4]	;@01676
	push	4	;@01679
	call	L03A4D	;@0167B
	mov	bx, word ptr [bp+4]	;@0167E
	test	word ptr [bx+0Eh], 400h	;@01681
	mov	bx, word ptr [bp+4]	;@01686
	mov	ax, word ptr [bx+6]	;@01689
	mov	dx, word ptr [bx+4]	;@0168C
	sub	word ptr ds:[40h], dx	;@0168F
	sbb	word ptr ds:[42h], ax	;@01693
@@1:	pop	bp	;@01697
	ret	2	;@01698
L0169B:	push	bp	;@0169B
	mov	bp, sp	;@0169C
	mov	es, word ptr ds:[0Ch]	;@0169E
	dec	byte ptr es:[6D4h]	;@016A2
	mov	bl, byte ptr es:[6D4h]	;@016A7
	xor	bh, bh	;@016AC
	shl	bx, 1	;@016AE
	mov	cx, word ptr es:[bx+5EBAh]	;@016B0
	jcxz	@@1	;@016B5
	push	cx	;@016B7
	call	L015F1	;@016B8
	mov	es, word ptr ds:[0Ch]	;@016BB
@@1:	cmp	byte ptr [bp+4], 0	;@016BF
	jne	@@2	;@016C3
	mov	al, byte ptr es:[6D6h]	;@016C5
	sub	al, byte ptr es:[6D5h]	;@016C9
	cmp	al, 3	;@016CE
	ja	@@3	;@016D0
@@2:	dec	byte ptr es:[6D5h]	;@016D2
	mov	bl, byte ptr es:[6D5h]	;@016D7
	xor	bh, bh	;@016DC
	shl	bx, 1	;@016DE
	mov	cx, word ptr es:[bx+5EBAh]	;@016E0
	jcxz	@@3	;@016E5
	push	cx	;@016E7
	call	L0162D	;@016E8
	mov	es, word ptr ds:[0Ch]	;@016EB
@@3:	dec	byte ptr es:[6D6h]	;@016EF
	mov	bl, byte ptr es:[6D6h]	;@016F4
	xor	bh, bh	;@016F9
	shl	bx, 1	;@016FB
	mov	cx, word ptr es:[bx+5EBAh]	;@016FD
	jcxz	@@4	;@01702
	push	cx	;@01704
	call	L01664	;@01705
	mov	es, word ptr ds:[0Ch]	;@01708
@@4:	mov	bl, byte ptr es:[6D4h]	;@0170C
	mov	cl, bl	;@01711
	xor	bh, bh	;@01713
	shl	bx, 1	;@01715
	mov	ax, word ptr [bp+6]	;@01717
	mov	word ptr es:[bx+5EBAh], ax	;@0171A
	mov	bx, word ptr [bp+6]	;@0171F
	mov	byte ptr [bx+11h], cl	;@01722
	or	word ptr [bx+0Eh], 1000h	;@01725
	pop	bp	;@0172A
	ret	4	;@0172B
L0172E:	push	bp	;@0172E
	mov	bp, sp	;@0172F
	mov	es, word ptr ds:[0Ch]	;@01731
	mov	al, byte ptr es:[6D5h]	;@01735
	sub	al, byte ptr es:[6D4h]	;@01739
	cmp	al, 3	;@0173E
	jb	@@1	;@01740
	dec	byte ptr es:[6D5h]	;@01742
	mov	bl, byte ptr es:[6D5h]	;@01747
	xor	bh, bh	;@0174C
	shl	bx, 1	;@0174E
	mov	cx, word ptr es:[bx+5EBAh]	;@01750
	jcxz	@@1	;@01755
	push	cx	;@01757
	call	L0162D	;@01758
@@1:	pop	bp	;@0175B
	ret	;@0175C
L0175D:	push	bp	;@0175D
	mov	bp, sp	;@0175E
	sub	sp, 4	;@01760
	push	ds	;@01763
	cmp	byte ptr ds:[8], 0	;@01764
	jne	@@2	;@01769
	mov	ds, word ptr cs:L0532F+2	;@0176B
	cmp	word ptr ds:[6E0h], 0	;@01770
	je	@@1	;@01775
	mov	ds, word ptr ds:[6E0h]	;@01777
	jmp	short @@3	;@0177B
@@1:	mov	word ptr [bp-2], 0	;@0177D
	mov	word ptr [bp-4], 0	;@01782
	jmp	short @@4	;@01787
@@2:	mov	ds, word ptr cs:L0532F+2	;@01789
	mov	ds, word ptr ds:[6DEh]	;@0178E
@@3:	mov	ax, word ptr ds:[1Eh]	;@01792
	mov	dx, word ptr ds:[1Ch]	;@01795
	add	dx, word ptr ds:[38h]	;@01799
	adc	ax, word ptr ds:[3Ah]	;@0179D
	sub	dx, word ptr ds:[3Ch]	;@017A1
	sbb	ax, word ptr ds:[3Eh]	;@017A5
	mov	word ptr [bp-2], ax	;@017A9
	mov	word ptr [bp-4], dx	;@017AC
@@4:	pop	ds	;@017AF
	mov	ax, word ptr [bp-2]	;@017B0
	mov	dx, word ptr [bp-4]	;@017B3
	add	dx, word ptr ds:[38h]	;@017B6
	adc	ax, word ptr ds:[3Ah]	;@017BA
	mov	word ptr [bp-2], ax	;@017BE
	mov	word ptr [bp-4], dx	;@017C1
	cmp	word ptr [bp-2], 0	;@017C4
	jg	@@7	;@017C8
	jl	@@5	;@017CA
	cmp	word ptr [bp-4], 0	;@017CC
	jae	@@7	;@017D0
@@5:	mov	al, byte ptr ds:[9]	;@017D2
	or	al, 40h	;@017D5
	mov	byte ptr ds:[9], al	;@017D7
	test	byte ptr ds:[9], 1	;@017DA
	je	@@6	;@017DF
	jmp	short @@8	;@017E1
@@6:	mov	dx, word ptr ds:[1Eh]	;@017E3
	mov	ax, word ptr ds:[1Ch]	;@017E7
	add	ax, word ptr [bp-4]	;@017EA
	adc	dx, word ptr [bp-2]	;@017ED
	jmp	short @@9	;@017F0
@@7:	mov	al, byte ptr ds:[9]	;@017F2
	and	al, 0BFh	;@017F5
	mov	byte ptr ds:[9], al	;@017F7
@@8:	mov	dx, word ptr ds:[1Eh]	;@017FA
	mov	ax, word ptr ds:[1Ch]	;@017FE
@@9:	leave	;@01801
	ret	;@01802
L01803:	push	bp	;@01803
	mov	bp, sp	;@01804
	test	byte ptr ds:[9], 8	;@01806
	je	@@1	;@0180B
	push	word ptr [bp+4]	;@0180D
	call	L01222	;@01810
	or	ax, ax	;@01813
	jne	@@1	;@01815
	xor	ax, ax	;@01817
	jmp	short @@5	;@01819
@@1:	test	byte ptr ds:[9], 40h	;@0181B
	je	@@2	;@01820
	mov	bx, word ptr [bp+4]	;@01822
	test	word ptr [bx+0Eh], 400h	;@01825
	je	@@2	;@0182A
	mov	al, byte ptr ds:[9]	;@0182C
	mov	ah, 0	;@0182F
	test	ax, 1	;@01831
	jne	@@2	;@01834
	jmp	short @@4	;@01836
@@2:	mov	bx, word ptr [bp+4]	;@01838
	test	word ptr [bx+0Eh], 20h	;@0183B
	je	@@3	;@01840
	push	word ptr [bp+4]	;@01842
	call	L01222	;@01845
	or	ax, ax	;@01848
	jne	@@3	;@0184A
	xor	ax, ax	;@0184C
	jmp	short @@5	;@0184E
@@3:	mov	bx, word ptr [bp+4]	;@01850
	test	word ptr [bx+0Eh], 40h	;@01853
	je	@@4	;@01858
	push	word ptr [bp+4]	;@0185A
	call	L01463	;@0185D
	or	ax, ax	;@01860
	jne	@@4	;@01862
	xor	ax, ax	;@01864
	jmp	short @@5	;@01866
@@4:	mov	ax, 1002h	;@01868
@@5:	pop	bp	;@0186B
	ret	2	;@0186C
RECLAIM_FOR_SPACE:	push	bp	;@0186F
	mov	bp, sp	;@01870
	sub	sp, 4	;@01872
	mov	byte ptr [bp-3], 1	;@01875
	mov	ax, word ptr [bp+8]	;@01879
	mov	word ptr [bp-2], ax	;@0187C
@@1:	mov	bx, word ptr [bp-2]	;@0187F
	test	word ptr [bx+0Eh], 801Ch	;@01882
	jne	@@7	;@01887
	test	word ptr [bx+0Eh], 1000h	;@01889
	je	@@2	;@0188E
	mov	al, byte ptr [bx+11h]	;@01890
	mov	es, word ptr ds:[0Ch]	;@01893
	sub	al, byte ptr es:[6D4h]	;@01897
	mov	ah, byte ptr es:[6D5h]	;@0189C
	sub	ah, byte ptr es:[6D4h]	;@018A1
	cmp	al, ah	;@018A6
	jb	@@7	;@018A8
@@2:	push	word ptr [bp-2]	;@018AA
	call	L01803	;@018AD
	or	ax, ax	;@018B0
	jne	@@4	;@018B2
	call	L0175D	;@018B4
	cmp	dx, word ptr [bp+0Ch]	;@018B7
	jb	@@4	;@018BA
	jne	@@3	;@018BC
	cmp	ax, word ptr [bp+0Ah]	;@018BE
	jb	@@4	;@018C1
@@3:	xor	ax, ax	;@018C3
	jmp	@@16	;@018C5
@@4:	mov	bx, word ptr [bp-2]	;@018C8
	cmp	word ptr [bx+8], 0	;@018CB
	jne	@@7	;@018CF
	jmp	short @@6	;@018D1
@@5:	mov	bx, word ptr [bp-2]	;@018D3
	mov	ax, word ptr [bx+0Ah]	;@018D6
	mov	word ptr [bp-2], ax	;@018D9
@@6:	mov	bx, word ptr [bp-2]	;@018DC
	cmp	word ptr [bx+8], 0	;@018DF
	je	@@5	;@018E3
	mov	ax, word ptr [bx+8]	;@018E5
	mov	word ptr [bp-2], ax	;@018E8
@@7:	mov	bx, word ptr [bp-2]	;@018EB
	mov	ax, word ptr [bx+0Ah]	;@018EE
	mov	word ptr [bp-2], ax	;@018F1
	cmp	ax, word ptr [bp+4]	;@018F4
	je	@@8	;@018F7
	jmp	@@1	;@018F9
@@8:	cmp	byte ptr [bp-3], 0	;@018FB
	je	@@9	;@018FF
	mov	ax, word ptr [bp+6]	;@01901
	mov	word ptr [bp-2], ax	;@01904
	mov	byte ptr [bp-3], 0	;@01907
	jmp	@@1	;@0190B
@@9:	test	byte ptr ds:[9], 2	;@0190E
	jne	@@10	;@01913
	jmp	@@15	;@01915
@@10:	mov	es, word ptr ds:[0Ch]	;@01918
	mov	bl, byte ptr es:[6D4h]	;@0191C
	xor	bh, bh	;@01921
@@11:	dec	bl	;@01923
	shl	bx, 1	;@01925
	mov	cx, word ptr es:[bx+5EBAh]	;@01927
	shr	bx, 1	;@0192C
	jcxz	@@14	;@0192E
	push	es	;@01930
	push	bx	;@01931
	mov	word ptr [bp-2], cx	;@01932
	mov	bx, word ptr [bp-2]	;@01935
	test	word ptr [bx+0Eh], 8018h	;@01938
	jne	@@13	;@0193D
	push	word ptr [bp-2]	;@0193F
	call	L01803	;@01942
	or	ax, ax	;@01945
	jne	@@13	;@01947
	call	L0175D	;@01949
	cmp	dx, word ptr [bp+0Ch]	;@0194C
	jb	@@13	;@0194F
	jne	@@12	;@01951
	cmp	ax, word ptr [bp+0Ah]	;@01953
	jb	@@13	;@01956
@@12:	add	sp, 4	;@01958
	xor	ax, ax	;@0195B
	jmp	short @@16	;@0195D
@@13:	pop	bx	;@0195F
	pop	es	;@01960
@@14:	cmp	bl, byte ptr es:[6D4h]	;@01961
	jne	@@11	;@01966
@@15:	mov	ax, 1000h	;@01968
@@16:	leave	;@0196B
	ret	0Ah	;@0196C
L0196F:	push	bp	;@0196F
	mov	bp, sp	;@01970
	sub	sp, 0Ch	;@01972
	mov	ax, word ptr [bp+4]	;@01975
	mov	word ptr [bp-2], ax	;@01978
	mov	word ptr [bp-4], 0	;@0197B
	mov	word ptr [bp-6], 0	;@01980
	jmp	short @@2	;@01985
@@1:	mov	bx, word ptr [bp-2]	;@01987
	mov	ax, word ptr [bx+8]	;@0198A
	mov	word ptr [bp-2], ax	;@0198D
	mov	bx, word ptr [bp-2]	;@01990
	test	word ptr [bx+0Eh], 4	;@01993
	je	@@2	;@01998
	mov	ax, word ptr [bx+6]	;@0199A
	mov	dx, word ptr [bx+4]	;@0199D
	add	word ptr [bp-6], dx	;@019A0
	adc	word ptr [bp-4], ax	;@019A3
@@2:	mov	ax, word ptr [bp-2]	;@019A6
	cmp	ax, word ptr [bp+6]	;@019A9
	je	@@3	;@019AC
	mov	ax, word ptr [bp-4]	;@019AE
	mov	dx, word ptr [bp-6]	;@019B1
	cmp	ax, word ptr [bp+0Ah]	;@019B4
	jb	@@1	;@019B7
	jne	@@3	;@019B9
	cmp	dx, word ptr [bp+8]	;@019BB
	jb	@@1	;@019BE
@@3:	mov	ax, word ptr [bp-6]	;@019C0
	or	ax, word ptr [bp-4]	;@019C3
	jne	@@4	;@019C6
	jmp	@@11	;@019C8
@@4:	mov	bx, word ptr [bp-2]	;@019CB
	mov	ax, word ptr [bx+2]	;@019CE
	mov	dx, word ptr [bx]	;@019D1
	mov	word ptr [bp-8], ax	;@019D3
	mov	word ptr [bp-0Ah], dx	;@019D6
	mov	ax, word ptr [bp-2]	;@019D9
	mov	word ptr [bp-0Ch], ax	;@019DC
	mov	bx, word ptr ds:[16h]	;@019DF
	mov	ax, word ptr [bx+8]	;@019E3
	mov	word ptr ds:[16h], ax	;@019E6
	jmp	short @@10	;@019E9
@@5:	mov	bx, word ptr [bp-2]	;@019EB
	test	word ptr [bx+0Eh], 4	;@019EE
	je	@@6	;@019F3
	mov	ax, word ptr [bx+0Ah]	;@019F5
	mov	word ptr [bp-0Ch], ax	;@019F8
	push	word ptr [bp-2]	;@019FB
	call	L00FA0	;@019FE
	push	word ptr [bp-2]	;@01A01
	call	L00C90	;@01A04
	mov	ax, word ptr [bp-0Ch]	;@01A07
	jmp	short @@9	;@01A0A
@@6:	mov	bx, word ptr [bp-2]	;@01A0C
	mov	ax, word ptr [bx+2]	;@01A0F
	mov	dx, word ptr [bx]	;@01A12
	cmp	ax, word ptr [bp-8]	;@01A14
	jne	@@7	;@01A17
	cmp	dx, word ptr [bp-0Ah]	;@01A19
	je	@@8	;@01A1C
@@7:	push	word ptr [bp-2]	;@01A1E
	push	word ptr [bp-8]	;@01A21
	push	word ptr [bp-0Ah]	;@01A24
	call	word ptr ds:[30h]	;@01A27
@@8:	mov	bx, word ptr [bp-2]	;@01A2B
	mov	ax, word ptr [bx+6]	;@01A2E
	mov	dx, word ptr [bx+4]	;@01A31
	add	word ptr [bp-0Ah], dx	;@01A34
	adc	word ptr [bp-8], ax	;@01A37
	mov	ax, word ptr [bx+0Ah]	;@01A3A
@@9:	mov	word ptr [bp-2], ax	;@01A3D
@@10:	mov	ax, word ptr [bp-2]	;@01A40
	cmp	ax, word ptr [bp+4]	;@01A43
	jne	@@5	;@01A46
	mov	bx, word ptr [bp-2]	;@01A48
	push	word ptr [bx+8]	;@01A4B
	call	L00C5F	;@01A4E
	push	ax	;@01A51
	call	L00FD4	;@01A52
	mov	bx, word ptr [bp-2]	;@01A55
	mov	ax, word ptr [bx+8]	;@01A58
	mov	word ptr [bp-2], ax	;@01A5B
	mov	bx, word ptr [bp-2]	;@01A5E
	mov	ax, word ptr [bp-4]	;@01A61
	mov	dx, word ptr [bp-6]	;@01A64
	mov	word ptr [bx+6], ax	;@01A67
	mov	word ptr [bx+4], dx	;@01A6A
	mov	ax, word ptr [bp-8]	;@01A6D
	mov	dx, word ptr [bp-0Ah]	;@01A70
	mov	word ptr [bx+2], ax	;@01A73
	mov	word ptr [bx], dx	;@01A76
	push	word ptr [bp-2]	;@01A78
	call	L00F53	;@01A7B
	mov	ax, word ptr [bp-2]	;@01A7E
	mov	word ptr ds:[0Eh], ax	;@01A81
	mov	ax, word ptr [bp-2]	;@01A84
	mov	word ptr ds:[20h], ax	;@01A87
	mov	bx, word ptr ds:[16h]	;@01A8A
	mov	ax, word ptr [bx+0Ah]	;@01A8E
	mov	word ptr ds:[16h], ax	;@01A91
@@11:	mov	ax, word ptr [bp-4]	;@01A94
	mov	dx, word ptr [bp-6]	;@01A97
	cmp	ax, word ptr [bp+0Ah]	;@01A9A
	ja	@@13	;@01A9D
	jb	@@12	;@01A9F
	cmp	dx, word ptr [bp+8]	;@01AA1
	jae	@@13	;@01AA4
@@12:	xor	ax, ax	;@01AA6
	jmp	short @@14	;@01AA8
@@13:	mov	ax, word ptr [bp-2]	;@01AAA
@@14:	leave	;@01AAD
	ret	8	;@01AAE
L01AB1:	push	bp	;@01AB1
	mov	bp, sp	;@01AB2
	sub	sp, 0Ch	;@01AB4
	mov	ax, word ptr [bp+6]	;@01AB7
	mov	word ptr [bp-2], ax	;@01ABA
	mov	word ptr [bp-4], 0	;@01ABD
	mov	word ptr [bp-6], 0	;@01AC2
	jmp	short @@3	;@01AC7
@@1:	mov	bx, word ptr [bp-2]	;@01AC9
	test	word ptr [bx+0Eh], 4	;@01ACC
	je	@@2	;@01AD1
	mov	ax, word ptr [bx+6]	;@01AD3
	mov	dx, word ptr [bx+4]	;@01AD6
	add	word ptr [bp-6], dx	;@01AD9
	adc	word ptr [bp-4], ax	;@01ADC
@@2:	mov	bx, word ptr [bp-2]	;@01ADF
	mov	ax, word ptr [bx+0Ah]	;@01AE2
	mov	word ptr [bp-2], ax	;@01AE5
@@3:	mov	ax, word ptr [bp-2]	;@01AE8
	cmp	ax, word ptr [bp+4]	;@01AEB
	je	@@4	;@01AEE
	mov	ax, word ptr [bp-4]	;@01AF0
	mov	dx, word ptr [bp-6]	;@01AF3
	cmp	ax, word ptr [bp+0Ah]	;@01AF6
	jb	@@1	;@01AF9
	jne	@@4	;@01AFB
	cmp	dx, word ptr [bp+8]	;@01AFD
	jb	@@1	;@01B00
@@4:	mov	ax, word ptr [bp-6]	;@01B02
	or	ax, word ptr [bp-4]	;@01B05
	jne	@@5	;@01B08
	jmp	@@11	;@01B0A
@@5:	mov	bx, word ptr [bp-2]	;@01B0D
	mov	ax, word ptr [bx+2]	;@01B10
	mov	dx, word ptr [bx]	;@01B13
	mov	word ptr [bp-8], ax	;@01B15
	mov	word ptr [bp-0Ah], dx	;@01B18
	mov	ax, word ptr [bp-2]	;@01B1B
	mov	word ptr [bp-0Ch], ax	;@01B1E
	mov	bx, word ptr ds:[16h]	;@01B21
	mov	ax, word ptr [bx+8]	;@01B25
	mov	word ptr ds:[16h], ax	;@01B28
	jmp	short @@10	;@01B2B
@@6:	mov	bx, word ptr [bp-2]	;@01B2D
	mov	ax, word ptr [bx+8]	;@01B30
	mov	word ptr [bp-0Ch], ax	;@01B33
	mov	bx, word ptr [bp-0Ch]	;@01B36
	test	word ptr [bx+0Eh], 4	;@01B39
	je	@@7	;@01B3E
	push	word ptr [bp-0Ch]	;@01B40
	call	L00FA0	;@01B43
	push	word ptr [bp-0Ch]	;@01B46
	call	L00C90	;@01B49
	jmp	short @@10	;@01B4C
@@7:	mov	bx, word ptr [bp-0Ch]	;@01B4E
	mov	ax, word ptr [bx+6]	;@01B51
	mov	dx, word ptr [bx+4]	;@01B54
	sub	word ptr [bp-0Ah], dx	;@01B57
	sbb	word ptr [bp-8], ax	;@01B5A
	mov	ax, word ptr [bx+2]	;@01B5D
	mov	dx, word ptr [bx]	;@01B60
	cmp	ax, word ptr [bp-8]	;@01B62
	jne	@@8	;@01B65
	cmp	dx, word ptr [bp-0Ah]	;@01B67
	je	@@9	;@01B6A
@@8:	push	word ptr [bp-0Ch]	;@01B6C
	push	word ptr [bp-8]	;@01B6F
	push	word ptr [bp-0Ah]	;@01B72
	call	word ptr ds:[32h]	;@01B75
@@9:	mov	ax, word ptr [bp-0Ch]	;@01B79
	mov	word ptr [bp-2], ax	;@01B7C
@@10:	mov	ax, word ptr [bp-0Ch]	;@01B7F
	cmp	ax, word ptr [bp+6]	;@01B82
	jne	@@6	;@01B85
	mov	bx, word ptr [bp-2]	;@01B87
	push	word ptr [bx+8]	;@01B8A
	call	L00C5F	;@01B8D
	push	ax	;@01B90
	call	L00FD4	;@01B91
	mov	bx, word ptr [bp-2]	;@01B94
	mov	ax, word ptr [bx+8]	;@01B97
	mov	word ptr [bp-2], ax	;@01B9A
	mov	bx, word ptr [bp-2]	;@01B9D
	mov	ax, word ptr [bp-4]	;@01BA0
	mov	dx, word ptr [bp-6]	;@01BA3
	mov	word ptr [bx+6], ax	;@01BA6
	mov	word ptr [bx+4], dx	;@01BA9
	mov	ax, word ptr [bp-8]	;@01BAC
	mov	dx, word ptr [bp-0Ah]	;@01BAF
	sub	dx, word ptr [bp-6]	;@01BB2
	sbb	ax, word ptr [bp-4]	;@01BB5
	mov	word ptr [bx+2], ax	;@01BB8
	mov	word ptr [bx], dx	;@01BBB
	push	word ptr [bp-2]	;@01BBD
	call	L00F53	;@01BC0
	mov	ax, word ptr [bp-2]	;@01BC3
	mov	word ptr ds:[0Eh], ax	;@01BC6
	mov	ax, word ptr [bp-2]	;@01BC9
	mov	word ptr ds:[20h], ax	;@01BCC
	mov	bx, word ptr ds:[16h]	;@01BCF
	mov	ax, word ptr [bx+0Ah]	;@01BD3
	mov	word ptr ds:[16h], ax	;@01BD6
@@11:	mov	ax, word ptr [bp-4]	;@01BD9
	mov	dx, word ptr [bp-6]	;@01BDC
	cmp	ax, word ptr [bp+0Ah]	;@01BDF
	ja	@@13	;@01BE2
	jb	@@12	;@01BE4
	cmp	dx, word ptr [bp+8]	;@01BE6
	jae	@@13	;@01BE9
@@12:	xor	ax, ax	;@01BEB
	jmp	short @@14	;@01BED
@@13:	mov	ax, word ptr [bp-2]	;@01BEF
@@14:	leave	;@01BF2
	ret	8	;@01BF3
L01BF6:	push	bp	;@01BF6
	mov	bp, sp	;@01BF7
	sub	sp, 6	;@01BF9
	mov	word ptr [bp-2], 0	;@01BFC
	push	word ptr [bp+4]	;@01C01
	call	L03C2D	;@01C04
	mov	word ptr [bp-4], dx	;@01C07
	mov	word ptr [bp-6], ax	;@01C0A
	test	byte ptr ds:[9], 4	;@01C0D
	je	@@2	;@01C12
	call	L0175D	;@01C14
	cmp	dx, word ptr [bp-4]	;@01C17
	ja	@@6	;@01C1A
	jb	@@1	;@01C1C
	cmp	ax, word ptr [bp-6]	;@01C1E
	jae	@@6	;@01C21
@@1:	push	word ptr [bp-4]	;@01C23
	push	word ptr [bp-6]	;@01C26
	push	word ptr ds:[0Eh]	;@01C29
	push	word ptr ds:[16h]	;@01C2D
	push	word ptr ds:[18h]	;@01C31
	call	RECLAIM_FOR_SPACE	;@01C35
	or	ax, ax	;@01C38
	je	@@6	;@01C3A
	xor	ax, ax	;@01C3C
	jmp	@@17	;@01C3E
@@2:	mov	ax, word ptr ds:[1Eh]	;@01C41
	mov	dx, word ptr ds:[1Ch]	;@01C44
	cmp	ax, word ptr [bp-4]	;@01C48
	ja	@@6	;@01C4B
	jb	@@3	;@01C4D
	cmp	dx, word ptr [bp-6]	;@01C4F
	jae	@@6	;@01C52
@@3:	test	byte ptr ds:[9], 80h	;@01C54
	je	@@5	;@01C59
	mov	ax, 0B87h	;@01C5B
	mov	es, ax	;@01C5E
	cmp	byte ptr es:[71Bh], 0	;@01C60
	je	@@5	;@01C66
	push	1	;@01C68
	push	0	;@01C6A
	call	L0436F	;@01C6C
	or	ax, ax	;@01C6F
	jne	@@4	;@01C71
	push	1	;@01C73
	push	0	;@01C75
	call	L0225B	;@01C77
	jmp	short @@6	;@01C7A
@@4:	xor	ax, ax	;@01C7C
	jmp	@@17	;@01C7E
@@5:	xor	ax, ax	;@01C81
	jmp	@@17	;@01C83
@@6:	mov	ax, word ptr ds:[20h]	;@01C86
	mov	word ptr [bp-2], ax	;@01C89
	mov	bx, word ptr [bp-2]	;@01C8C
	mov	ax, word ptr [bx+6]	;@01C8F
	mov	dx, word ptr [bx+4]	;@01C92
	cmp	ax, word ptr [bp-4]	;@01C95
	jb	@@8	;@01C98
	jne	@@7	;@01C9A
	cmp	dx, word ptr [bp-6]	;@01C9C
	jb	@@8	;@01C9F
@@7:	push	word ptr [bp-2]	;@01CA1
	push	word ptr [bp-4]	;@01CA4
	push	word ptr [bp-6]	;@01CA7
	push	0	;@01CAA
	call	L01042	;@01CAC
	jmp	@@16	;@01CAF
@@8:	mov	bx, word ptr ds:[14h]	;@01CB2
	jmp	short @@14	;@01CB6
@@9:	mov	bx, word ptr [bp-2]	;@01CB8
	mov	ax, word ptr [bx+6]	;@01CBB
	mov	dx, word ptr [bx+4]	;@01CBE
	cmp	ax, word ptr [bp-4]	;@01CC1
	jb	@@11	;@01CC4
	jne	@@10	;@01CC6
	cmp	dx, word ptr [bp-6]	;@01CC8
	jb	@@11	;@01CCB
@@10:	push	word ptr [bp-2]	;@01CCD
	push	word ptr [bp-4]	;@01CD0
	push	word ptr [bp-6]	;@01CD3
	push	0	;@01CD6
	call	L01042	;@01CD8
	jmp	short @@16	;@01CDB
@@11:	mov	bx, word ptr [bp-2]	;@01CDD
	mov	ax, word ptr [bx+6]	;@01CE0
	mov	dx, word ptr [bx+4]	;@01CE3
	mov	bx, word ptr ds:[20h]	;@01CE6
	cmp	ax, word ptr [bx+6]	;@01CEA
	jb	@@13	;@01CED
	ja	@@12	;@01CEF
	cmp	dx, word ptr [bx+4]	;@01CF1
	jbe	@@13	;@01CF4
@@12:	mov	ax, word ptr [bp-2]	;@01CF6
	mov	word ptr ds:[20h], ax	;@01CF9
@@13:	mov	bx, word ptr [bp-2]	;@01CFC
@@14:	mov	ax, word ptr [bx+14h]	;@01CFF
	mov	word ptr [bp-2], ax	;@01D02
	mov	ax, word ptr [bp-2]	;@01D05
	cmp	ax, word ptr ds:[14h]	;@01D08
	jne	@@9	;@01D0C
	push	word ptr [bp-4]	;@01D0E
	push	word ptr [bp-6]	;@01D11
	call	word ptr ds:[2Ah]	;@01D14
	mov	word ptr [bp-2], ax	;@01D18
	or	ax, ax	;@01D1B
	je	@@15	;@01D1D
	push	word ptr [bp-2]	;@01D1F
	push	word ptr [bp-4]	;@01D22
	push	word ptr [bp-6]	;@01D25
	push	0	;@01D28
	call	L01042	;@01D2A
	jmp	short @@16	;@01D2D
@@15:	xor	ax, ax	;@01D2F
	jmp	short @@17	;@01D31
@@16:	mov	bx, word ptr [bp-2]	;@01D33
	mov	ax, word ptr [bp+4]	;@01D36
	mov	word ptr [bx+0Ch], ax	;@01D39
	push	word ptr [bp-2]	;@01D3C
	call	L00FFC	;@01D3F
	mov	ax, word ptr [bp-2]	;@01D42
@@17:	leave	;@01D45
	ret	2	;@01D46
L01D49:	push	bp	;@01D49
	mov	bp, sp	;@01D4A
	sub	sp, 0Ah	;@01D4C
	push	word ptr [bp+4]	;@01D4F
	call	L03C2D	;@01D52
	mov	word ptr [bp-2], dx	;@01D55
	mov	word ptr [bp-4], ax	;@01D58
	mov	bx, word ptr [bp+6]	;@01D5B
	mov	ax, word ptr [bx+6]	;@01D5E
	mov	dx, word ptr [bx+4]	;@01D61
	sub	dx, word ptr [bp-4]	;@01D64
	sbb	ax, word ptr [bp-2]	;@01D67
	mov	word ptr [bp-6], ax	;@01D6A
	mov	word ptr [bp-8], dx	;@01D6D
	call	L00C5F	;@01D70
	mov	word ptr [bp-0Ah], ax	;@01D73
	mov	bx, word ptr [bp-0Ah]	;@01D76
	mov	ax, word ptr [bp-6]	;@01D79
	mov	dx, word ptr [bp-8]	;@01D7C
	mov	word ptr [bx+6], ax	;@01D7F
	mov	word ptr [bx+4], dx	;@01D82
	mov	bx, word ptr [bp+6]	;@01D85
	mov	ax, word ptr [bp-2]	;@01D88
	mov	dx, word ptr [bp-4]	;@01D8B
	mov	word ptr [bx+6], ax	;@01D8E
	mov	word ptr [bx+4], dx	;@01D91
	mov	ax, word ptr [bx+2]	;@01D94
	mov	dx, word ptr [bx]	;@01D97
	add	dx, word ptr [bp-4]	;@01D99
	adc	ax, word ptr [bp-2]	;@01D9C
	mov	bx, word ptr [bp-0Ah]	;@01D9F
	mov	word ptr [bx+2], ax	;@01DA2
	mov	word ptr [bx], dx	;@01DA5
	push	word ptr [bp+6]	;@01DA7
	push	word ptr [bp-0Ah]	;@01DAA
	call	L00FD4	;@01DAD
	mov	bx, word ptr [bp-0Ah]	;@01DB0
	mov	word ptr [bx+0Eh], 4	;@01DB3
	mov	ax, word ptr [bx+0Ah]	;@01DB8
	cmp	ax, word ptr ds:[16h]	;@01DBB
	jne	@@1	;@01DBF
	mov	ax, word ptr [bp-0Ah]	;@01DC1
	mov	word ptr ds:[16h], ax	;@01DC4
@@1:	push	word ptr [bp-0Ah]	;@01DC7
	call	L00F53	;@01DCA
	push	word ptr [bp-0Ah]	;@01DCD
	call	L01119	;@01DD0
	mov	bx, word ptr [bp+6]	;@01DD3
	mov	ax, word ptr [bp+4]	;@01DD6
	mov	word ptr [bx+0Ch], ax	;@01DD9
	push	word ptr [bp+6]	;@01DDC
	call	L03C6D	;@01DDF
	mov	bx, word ptr [bp+6]	;@01DE2
	test	word ptr [bx+0Eh], 60h	;@01DE5
	je	@@2	;@01DEA
	mov	ax, word ptr [bp-6]	;@01DEC
	mov	dx, word ptr [bp-8]	;@01DEF
	sub	word ptr ds:[4Ah], dx	;@01DF2
	sbb	word ptr ds:[4Ch], ax	;@01DF6
@@2:	leave	;@01DFA
	ret	4	;@01DFB
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 6, 1Eh, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 0C4h	;@01DFE
	db	5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 23h, 1Dh
	db	0D1h, 0E0h, 8Bh, 0D8h, 8Eh, 9Fh, 0DEh, 6, 0FFh, 76h, 4, 0E8h, 7
	db	1Eh, 8Bh, 5Eh, 0FEh, 2Bh, 47h, 4, 1Bh, 57h, 6, 89h, 56h, 0FCh
	db	89h, 46h, 0FAh, 0Bh, 46h, 0FCh, 74h, 17h, 0FFh, 76h, 0FEh, 0FFh
	db	76h, 4, 0E8h, 6, 0FFh, 8Bh, 46h, 0FCh, 8Bh, 56h, 0FAh, 1, 16h
	db	38h, 0, 11h, 6, 3Ah, 0, 1Fh, 0C9h, 0C2h, 6, 0
SWAP_WITH_FREE_NODE:	push	bp	;@01E56
	mov	bp, sp	;@01E57
	mov	al, byte ptr [bp+4]	;@01E59
	mov	byte ptr [bp+4], al	;@01E5C
	push	word ptr [bp+8]	;@01E5F
	mov	bx, word ptr [bp+6]	;@01E62
	push	word ptr [bx+2]	;@01E65
	push	word ptr [bx]	;@01E68
	call	word ptr ds:[30h]	;@01E6A
	push	word ptr [bp+6]	;@01E6E
	call	L00E99	;@01E71
	push	word ptr [bp+6]	;@01E74
	call	L01119	;@01E77
	mov	ax, word ptr ds:[16h]	;@01E7A
	cmp	ax, word ptr [bp+6]	;@01E7D
	jne	@@1	;@01E80
	mov	ax, word ptr [bp+8]	;@01E82
	mov	word ptr ds:[16h], ax	;@01E85
@@1:	pop	bp	;@01E88
	ret	6	;@01E89
L01E8C:	push	bp	;@01E8C
	mov	bp, sp	;@01E8D
	sub	sp, 14h	;@01E8F
	push	word ptr [bp+4]	;@01E92
	call	L03C2D	;@01E95
	mov	word ptr [bp-2], dx	;@01E98
	mov	word ptr [bp-4], ax	;@01E9B
	mov	bx, word ptr [bp+6]	;@01E9E
	mov	ax, word ptr [bp-2]	;@01EA1
	mov	dx, word ptr [bp-4]	;@01EA4
	sub	dx, word ptr [bx+4]	;@01EA7
	sbb	ax, word ptr [bx+6]	;@01EAA
	mov	word ptr [bp-6], ax	;@01EAD
	mov	word ptr [bp-8], dx	;@01EB0
	mov	byte ptr [bp-0Bh], 0	;@01EB3
	call	L0175D	;@01EB7
	cmp	dx, word ptr [bp-6]	;@01EBA
	ja	@@4	;@01EBD
	jb	@@1	;@01EBF
	cmp	ax, word ptr [bp-8]	;@01EC1
	jae	@@4	;@01EC4
@@1:	mov	bx, word ptr [bp+6]	;@01EC6
	mov	ax, word ptr [bx+0Ah]	;@01EC9
	mov	word ptr [bp-0Ah], ax	;@01ECC
	cmp	ax, word ptr ds:[18h]	;@01ECF
	je	@@2	;@01ED3
	push	word ptr [bp-6]	;@01ED5
	push	word ptr [bp-8]	;@01ED8
	push	word ptr [bp-0Ah]	;@01EDB
	push	word ptr [bp-0Ah]	;@01EDE
	push	word ptr ds:[18h]	;@01EE1
	call	RECLAIM_FOR_SPACE	;@01EE5
	or	ax, ax	;@01EE8
	je	@@4	;@01EEA
@@2:	push	word ptr [bp-6]	;@01EEC
	push	word ptr [bp-8]	;@01EEF
	push	word ptr ds:[0Eh]	;@01EF2
	push	word ptr ds:[16h]	;@01EF6
	push	word ptr ds:[18h]	;@01EFA
	call	RECLAIM_FOR_SPACE	;@01EFE
	or	ax, ax	;@01F01
	je	@@3	;@01F03
	mov	ax, word ptr [bp+6]	;@01F05
	cmp	ax, word ptr ds:[44h]	;@01F08
	je	@@3	;@01F0C
	mov	bx, word ptr [bp+6]	;@01F0E
	test	word ptr [bx+0Eh], 18h	;@01F11
	jne	@@3	;@01F16
	push	word ptr [bx+0Eh]	;@01F18
	push	word ptr [bx+14h]	;@01F1B
	push	word ptr [bx+12h]	;@01F1E
	push	word ptr [bp+4]	;@01F21
	mov	al, byte ptr ds:[8]	;@01F24
	mov	ah, 0	;@01F27
	push	ax	;@01F29
	push	word ptr [bp+6]	;@01F2A
	call	L02D21	;@01F2D
	jmp	@@32	;@01F30
@@3:	xor	ax, ax	;@01F33
	jmp	@@32	;@01F35
@@4:	mov	bx, word ptr [bp+6]	;@01F38
	mov	ax, word ptr [bx+0Ah]	;@01F3B
	mov	word ptr [bp-0Ah], ax	;@01F3E
	mov	bx, word ptr [bp-0Ah]	;@01F41
	test	word ptr [bx+0Eh], 4	;@01F44
	je	@@6	;@01F49
	mov	ax, word ptr [bx+6]	;@01F4B
	mov	dx, word ptr [bx+4]	;@01F4E
	cmp	ax, word ptr [bp-6]	;@01F51
	jb	@@6	;@01F54
	je	@@5	;@01F56
	jmp	@@22	;@01F58
@@5:	cmp	dx, word ptr [bp-8]	;@01F5B
	jb	@@6	;@01F5E
	jmp	@@22	;@01F60
@@6:	mov	bx, word ptr [bp+6]	;@01F63
	mov	ax, word ptr [bx+8]	;@01F66
	mov	word ptr [bp-0Ah], ax	;@01F69
	mov	bx, word ptr [bp-0Ah]	;@01F6C
	test	word ptr [bx+0Eh], 4	;@01F6F
	je	@@8	;@01F74
	mov	ax, word ptr [bx+6]	;@01F76
	mov	dx, word ptr [bx+4]	;@01F79
	cmp	ax, word ptr [bp-6]	;@01F7C
	jb	@@8	;@01F7F
	jne	@@7	;@01F81
	cmp	dx, word ptr [bp-8]	;@01F83
	jb	@@8	;@01F86
@@7:	push	word ptr [bp+6]	;@01F88
	push	word ptr [bp-0Ah]	;@01F8B
	mov	al, byte ptr [bp-0Bh]	;@01F8E
	push	ax	;@01F91
	call	SWAP_WITH_FREE_NODE	;@01F92
	jmp	@@22	;@01F95
@@8:	mov	ax, word ptr ds:[1Eh]	;@01F98
	mov	dx, word ptr ds:[1Ch]	;@01F9B
	cmp	ax, word ptr [bp-2]	;@01F9F
	jae	@@9	;@01FA2
	jmp	@@18	;@01FA4
@@9:	jne	@@10	;@01FA7
	cmp	dx, word ptr [bp-4]	;@01FA9
	jae	@@10	;@01FAC
	jmp	@@18	;@01FAE
@@10:	mov	ax, word ptr ds:[20h]	;@01FB1
	mov	word ptr [bp-0Ah], ax	;@01FB4
	mov	bx, word ptr [bp-0Ah]	;@01FB7
	mov	ax, word ptr [bx+6]	;@01FBA
	mov	dx, word ptr [bx+4]	;@01FBD
	cmp	ax, word ptr [bp-2]	;@01FC0
	jb	@@11	;@01FC3
	jne	@@17	;@01FC5
	cmp	dx, word ptr [bp-4]	;@01FC7
	jae	@@17	;@01FCA
@@11:	mov	bx, word ptr ds:[14h]	;@01FCC
	jmp	short @@16	;@01FD0
@@12:	mov	bx, word ptr [bp-0Ah]	;@01FD2
	mov	ax, word ptr [bx+6]	;@01FD5
	mov	dx, word ptr [bx+4]	;@01FD8
	cmp	ax, word ptr [bp-2]	;@01FDB
	jb	@@13	;@01FDE
	jne	@@17	;@01FE0
	cmp	dx, word ptr [bp-4]	;@01FE2
	jae	@@17	;@01FE5
@@13:	mov	bx, word ptr [bp-0Ah]	;@01FE7
	mov	ax, word ptr [bx+6]	;@01FEA
	mov	dx, word ptr [bx+4]	;@01FED
	mov	bx, word ptr ds:[20h]	;@01FF0
	cmp	ax, word ptr [bx+6]	;@01FF4
	jb	@@15	;@01FF7
	ja	@@14	;@01FF9
	cmp	dx, word ptr [bx+4]	;@01FFB
	jbe	@@15	;@01FFE
@@14:	mov	ax, word ptr [bp-0Ah]	;@02000
	mov	word ptr ds:[20h], ax	;@02003
@@15:	mov	bx, word ptr [bp-0Ah]	;@02006
@@16:	mov	ax, word ptr [bx+14h]	;@02009
	mov	word ptr [bp-0Ah], ax	;@0200C
	mov	ax, word ptr [bp-0Ah]	;@0200F
	cmp	ax, word ptr ds:[14h]	;@02012
	jne	@@12	;@02016
	jmp	@@18	;@02018
@@17:	push	word ptr [bp-0Ah]	;@0201B
	push	word ptr [bp-2]	;@0201E
	push	word ptr [bp-4]	;@02021
	push	0	;@02024
	call	L01042	;@02026
	mov	bx, word ptr ds:[16h]	;@02029
	mov	ax, word ptr [bx+8]	;@0202D
	mov	word ptr ds:[16h], ax	;@02030
	mov	bx, word ptr [bp+6]	;@02033
	mov	ax, word ptr [bx+2]	;@02036
	mov	dx, word ptr [bx]	;@02039
	mov	word ptr [bp-0Eh], ax	;@0203B
	mov	word ptr [bp-10h], dx	;@0203E
	mov	ax, word ptr [bx+0Ah]	;@02041
	mov	dx, word ptr [bx+8]	;@02044
	mov	word ptr [bp-12h], ax	;@02047
	mov	word ptr [bp-14h], dx	;@0204A
	push	word ptr [bp+6]	;@0204D
	mov	bx, word ptr [bp-0Ah]	;@02050
	push	word ptr [bx+2]	;@02053
	push	word ptr [bx]	;@02056
	call	word ptr ds:[30h]	;@02058
	mov	bx, word ptr [bp-0Ah]	;@0205C
	mov	ax, word ptr [bp-0Eh]	;@0205F
	mov	dx, word ptr [bp-10h]	;@02062
	mov	word ptr [bx+2], ax	;@02065
	mov	word ptr [bx], dx	;@02068
	mov	bx, word ptr [bp+6]	;@0206A
	mov	ax, word ptr [bx+6]	;@0206D
	mov	dx, word ptr [bx+4]	;@02070
	mov	bx, word ptr [bp-0Ah]	;@02073
	mov	word ptr [bx+6], ax	;@02076
	mov	word ptr [bx+4], dx	;@02079
	mov	bx, word ptr [bp+6]	;@0207C
	mov	ax, word ptr [bp-2]	;@0207F
	mov	dx, word ptr [bp-4]	;@02082
	mov	word ptr [bx+6], ax	;@02085
	mov	word ptr [bx+4], dx	;@02088
	mov	bx, word ptr [bp-0Ah]	;@0208B
	mov	bx, word ptr [bx+0Ah]	;@0208E
	mov	ax, word ptr [bp+6]	;@02091
	mov	word ptr [bx+8], ax	;@02094
	mov	bx, word ptr [bp+6]	;@02097
	mov	bx, word ptr [bx+0Ah]	;@0209A
	mov	ax, word ptr [bp-0Ah]	;@0209D
	mov	word ptr [bx+8], ax	;@020A0
	mov	bx, word ptr [bp-0Ah]	;@020A3
	mov	bx, word ptr [bx+8]	;@020A6
	mov	ax, word ptr [bp+6]	;@020A9
	mov	word ptr [bx+0Ah], ax	;@020AC
	mov	bx, word ptr [bp+6]	;@020AF
	mov	bx, word ptr [bx+8]	;@020B2
	mov	ax, word ptr [bp-0Ah]	;@020B5
	mov	word ptr [bx+0Ah], ax	;@020B8
	mov	bx, word ptr [bp-0Ah]	;@020BB
	mov	ax, word ptr [bx+0Ah]	;@020BE
	mov	dx, word ptr [bx+8]	;@020C1
	mov	bx, word ptr [bp+6]	;@020C4
	mov	word ptr [bx+0Ah], ax	;@020C7
	mov	word ptr [bx+8], dx	;@020CA
	mov	bx, word ptr [bp-0Ah]	;@020CD
	mov	ax, word ptr [bp-12h]	;@020D0
	mov	dx, word ptr [bp-14h]	;@020D3
	mov	word ptr [bx+0Ah], ax	;@020D6
	mov	word ptr [bx+8], dx	;@020D9
	push	word ptr [bp-0Ah]	;@020DC
	call	L00F53	;@020DF
	push	word ptr [bp-0Ah]	;@020E2
	call	L01119	;@020E5
	jmp	@@30	;@020E8
@@18:	mov	bx, word ptr [bp+6]	;@020EB
	mov	ax, word ptr [bx+0Ah]	;@020EE
	mov	word ptr [bp-0Ah], ax	;@020F1
	cmp	ax, word ptr ds:[18h]	;@020F4
	je	@@19	;@020F8
	push	word ptr [bp-6]	;@020FA
	push	word ptr [bp-8]	;@020FD
	push	word ptr [bp-0Ah]	;@02100
	push	word ptr ds:[18h]	;@02103
	call	L01AB1	;@02107
	mov	word ptr [bp-0Ah], ax	;@0210A
	or	ax, ax	;@0210D
	jne	@@22	;@0210F
@@19:	mov	ax, word ptr [bp+6]	;@02111
	cmp	ax, word ptr ds:[16h]	;@02114
	je	@@20	;@02118
	push	word ptr [bp-6]	;@0211A
	push	word ptr [bp-8]	;@0211D
	push	word ptr ds:[16h]	;@02120
	push	word ptr [bp+6]	;@02124
	call	L0196F	;@02127
	mov	word ptr [bp-0Ah], ax	;@0212A
	or	ax, ax	;@0212D
	je	@@21	;@0212F
	push	word ptr [bp+6]	;@02131
	push	word ptr [bp-0Ah]	;@02134
	mov	al, byte ptr [bp-0Bh]	;@02137
	push	ax	;@0213A
	call	SWAP_WITH_FREE_NODE	;@0213B
	jmp	short @@22	;@0213E
@@20:	xor	ax, ax	;@02140
	jmp	@@32	;@02142
@@21:	mov	bx, word ptr [bp+6]	;@02145
	mov	ax, word ptr [bx+8]	;@02148
	mov	word ptr [bp-0Ah], ax	;@0214B
	push	word ptr [bp+6]	;@0214E
	push	word ptr [bp-0Ah]	;@02151
	mov	al, byte ptr [bp-0Bh]	;@02154
	push	ax	;@02157
	call	SWAP_WITH_FREE_NODE	;@02158
	push	word ptr [bp-0Ah]	;@0215B
	call	L01119	;@0215E
@@22:	mov	bx, word ptr ds:[16h]	;@02161
	mov	ax, word ptr [bx+8]	;@02165
	mov	word ptr ds:[16h], ax	;@02168
	mov	bx, word ptr [bp-0Ah]	;@0216B
	mov	ax, word ptr [bx+6]	;@0216E
	mov	dx, word ptr [bx+4]	;@02171
	cmp	ax, word ptr [bp-6]	;@02174
	jne	@@26	;@02177
	cmp	dx, word ptr [bp-8]	;@02179
	jne	@@26	;@0217C
	mov	ax, word ptr [bx+2]	;@0217E
	mov	dx, word ptr [bx]	;@02181
	mov	bx, word ptr ds:[16h]	;@02183
	cmp	ax, word ptr [bx+2]	;@02187
	jb	@@25	;@0218A
	jne	@@23	;@0218C
	cmp	dx, word ptr [bx]	;@0218E
	jb	@@25	;@02190
@@23:	mov	bx, word ptr [bp-0Ah]	;@02192
	mov	ax, word ptr [bx+2]	;@02195
	mov	dx, word ptr [bx]	;@02198
	mov	bx, word ptr ds:[18h]	;@0219A
	cmp	ax, word ptr [bx+2]	;@0219E
	ja	@@25	;@021A1
	jb	@@24	;@021A3
	cmp	dx, word ptr [bx]	;@021A5
	jae	@@25	;@021A7
@@24:	push	word ptr [bp-0Ah]	;@021A9
	call	L00FA0	;@021AC
	mov	bx, word ptr ds:[14h]	;@021AF
	mov	ax, word ptr [bx+14h]	;@021B3
	mov	word ptr ds:[20h], ax	;@021B6
@@25:	push	word ptr [bp-0Ah]	;@021B9
	call	L00C90	;@021BC
	jmp	short @@29	;@021BF
@@26:	mov	bx, word ptr [bp-0Ah]	;@021C1
	mov	ax, word ptr [bp-6]	;@021C4
	mov	dx, word ptr [bp-8]	;@021C7
	sub	word ptr [bx+4], dx	;@021CA
	sbb	word ptr [bx+6], ax	;@021CD
	add	word ptr [bx], dx	;@021D0
	adc	word ptr [bx+2], ax	;@021D2
	mov	ax, word ptr [bx+2]	;@021D5
	mov	dx, word ptr [bx]	;@021D8
	mov	bx, word ptr ds:[16h]	;@021DA
	cmp	ax, word ptr [bx+2]	;@021DE
	jb	@@29	;@021E1
	jne	@@27	;@021E3
	cmp	dx, word ptr [bx]	;@021E5
	jb	@@29	;@021E7
@@27:	mov	bx, word ptr [bp-0Ah]	;@021E9
	mov	ax, word ptr [bx+2]	;@021EC
	mov	dx, word ptr [bx]	;@021EF
	mov	bx, word ptr ds:[18h]	;@021F1
	cmp	ax, word ptr [bx+2]	;@021F5
	ja	@@29	;@021F8
	jb	@@28	;@021FA
	cmp	dx, word ptr [bx]	;@021FC
	jae	@@29	;@021FE
@@28:	mov	ax, word ptr [bp-6]	;@02200
	mov	dx, word ptr [bp-8]	;@02203
	sub	word ptr ds:[1Ch], dx	;@02206
	sbb	word ptr ds:[1Eh], ax	;@0220A
@@29:	mov	bx, word ptr [bp+6]	;@0220E
	mov	ax, word ptr [bp-2]	;@02211
	mov	dx, word ptr [bp-4]	;@02214
	mov	word ptr [bx+6], ax	;@02217
	mov	word ptr [bx+4], dx	;@0221A
@@30:	mov	bx, word ptr ds:[16h]	;@0221D
	mov	ax, word ptr [bx+0Ah]	;@02221
	mov	word ptr ds:[16h], ax	;@02224
	mov	bx, word ptr [bp+6]	;@02227
	mov	ax, word ptr [bp+4]	;@0222A
	mov	word ptr [bx+0Ch], ax	;@0222D
	push	word ptr [bp+6]	;@02230
	call	L00FFC	;@02233
	push	word ptr [bp+6]	;@02236
	call	L03C6D	;@02239
	mov	bx, word ptr [bp+6]	;@0223C
	test	word ptr [bx+0Eh], 60h	;@0223F
	je	@@31	;@02244
	mov	ax, word ptr [bp-6]	;@02246
	mov	dx, word ptr [bp-8]	;@02249
	add	word ptr ds:[4Ah], dx	;@0224C
	adc	word ptr ds:[4Ch], ax	;@02250
@@31:	mov	ax, word ptr [bp+6]	;@02254
@@32:	leave	;@02257
	ret	4	;@02258
L0225B:	push	bp	;@0225B
	mov	bp, sp	;@0225C
	dec	sp	;@0225E
	dec	sp	;@0225F
	call	L00C5F	;@02260
	mov	word ptr [bp-2], ax	;@02263
	mov	bx, word ptr ds:[12h]	;@02266
	mov	ax, word ptr [bx+2]	;@0226A
	mov	dx, word ptr [bx]	;@0226D
	mov	bx, word ptr [bp-2]	;@0226F
	mov	word ptr [bx+2], ax	;@02272
	mov	word ptr [bx], dx	;@02275
	mov	ax, word ptr [bp+6]	;@02277
	mov	dx, word ptr [bp+4]	;@0227A
	mov	word ptr [bx+6], ax	;@0227D
	mov	word ptr [bx+4], dx	;@02280
	mov	bx, word ptr ds:[12h]	;@02283
	push	word ptr [bx+8]	;@02287
	push	word ptr [bp-2]	;@0228A
	call	L00FD4	;@0228D
	mov	ax, word ptr [bp+6]	;@02290
	mov	dx, word ptr [bp+4]	;@02293
	add	word ptr ds:[4], dx	;@02296
	adc	word ptr ds:[6], ax	;@0229A
	mov	bx, word ptr ds:[12h]	;@0229E
	add	word ptr [bx], dx	;@022A2
	adc	word ptr [bx+2], ax	;@022A4
	mov	ax, word ptr ds:[18h]	;@022A7
	cmp	ax, word ptr ds:[12h]	;@022AA
	jne	@@2	;@022AE
	push	word ptr [bp-2]	;@022B0
	call	L00F53	;@022B3
	push	word ptr [bp-2]	;@022B6
	call	L01119	;@022B9
	mov	bx, word ptr ds:[12h]	;@022BC
	mov	ax, word ptr [bx+8]	;@022C0
	mov	word ptr [bp-2], ax	;@022C3
	mov	bx, word ptr [bp-2]	;@022C6
	mov	ax, word ptr [bx+6]	;@022C9
	mov	dx, word ptr [bx+4]	;@022CC
	mov	bx, word ptr ds:[20h]	;@022CF
	cmp	ax, word ptr [bx+6]	;@022D3
	jb	@@2	;@022D6
	ja	@@1	;@022D8
	cmp	dx, word ptr [bx+4]	;@022DA
	jbe	@@2	;@022DD
@@1:	mov	ax, word ptr [bp-2]	;@022DF
	mov	word ptr ds:[20h], ax	;@022E2
@@2:	mov	ax, word ptr [bp-2]	;@022E5
	leave	;@022E8
	ret	4	;@022E9
L022EC:	push	bp	;@022EC
	mov	bp, sp	;@022ED
	dec	sp	;@022EF
	dec	sp	;@022F0
	cmp	word ptr [bp+6], 0	;@022F1
	je	@@1	;@022F5
	mov	ax, word ptr [bp+6]	;@022F7
	shl	ax, 3	;@022FA
	mov	dx, word ptr ds:[6DEh]	;@022FD
	add	dx, ax	;@02301
	mov	bx, word ptr [bp+6]	;@02303
	shl	bx, 1	;@02306
	mov	word ptr [bx+6DEh], dx	;@02308
	mov	bx, word ptr [bp+6]	;@0230C
	shl	bx, 1	;@0230F
	mov	ds, word ptr [bx+6DEh]	;@02311
@@1:	mov	ax, 6	;@02315
	sub	ax, word ptr [bp+6]	;@02318
	mov	dx, 50h	;@0231B
	imul	dx	;@0231E
	mov	word ptr ds:[22h], ax	;@02320
	mov	ax, word ptr [bp+6]	;@02323
	mov	dx, 50h	;@02326
	imul	dx	;@02329
	mov	word ptr ds:[24h], ax	;@0232B
	mov	ax, word ptr [bp+0Eh]	;@0232E
	mov	dx, word ptr [bp+0Ch]	;@02331
	mov	word ptr ds:[2], ax	;@02334
	mov	word ptr ds:[0], dx	;@02337
	mov	ax, word ptr [bp+0Ah]	;@0233B
	mov	dx, word ptr [bp+8]	;@0233E
	mov	word ptr ds:[6], ax	;@02341
	mov	word ptr ds:[4], dx	;@02344
	mov	al, byte ptr [bp+6]	;@02348
	mov	byte ptr ds:[8], al	;@0234B
	mov	ax, word ptr [bp+4]	;@0234E
	mov	word ptr ds:[0Ah], ax	;@02351
	mov	word ptr ds:[26h], 12B6h	;@02354
	mov	word ptr ds:[28h], 874h	;@0235A
	mov	word ptr ds:[0Ch], 0B87h	;@02360
	call	L00C5F	;@02366
	mov	word ptr [bp-2], ax	;@02369
	mov	word ptr ds:[14h], ax	;@0236C
	mov	bx, word ptr [bp-2]	;@0236F
	mov	ax, word ptr ds:[2]	;@02372
	mov	dx, word ptr ds:[0]	;@02375
	mov	word ptr [bx+2], ax	;@02379
	mov	word ptr [bx], dx	;@0237C
	mov	word ptr [bx+0Eh], 8004h	;@0237E
	mov	ax, word ptr [bp-2]	;@02383
	mov	word ptr [bx+8], ax	;@02386
	mov	word ptr [bx+0Ah], ax	;@02389
	mov	ax, word ptr [bp-2]	;@0238C
	mov	word ptr [bx+12h], ax	;@0238F
	mov	word ptr [bx+14h], ax	;@02392
	mov	word ptr [bx+6], 0	;@02395
	mov	word ptr [bx+4], 0	;@0239A
	call	L00C5F	;@0239F
	mov	word ptr [bp-2], ax	;@023A2
	mov	word ptr ds:[10h], ax	;@023A5
	mov	bx, word ptr [bp-2]	;@023A8
	mov	ax, word ptr ds:[2]	;@023AB
	mov	dx, word ptr ds:[0]	;@023AE
	mov	word ptr [bx+2], ax	;@023B2
	mov	word ptr [bx], dx	;@023B5
	mov	word ptr [bx+0Eh], 8000h	;@023B7
	mov	ax, word ptr [bp-2]	;@023BC
	mov	word ptr [bx+8], ax	;@023BF
	mov	word ptr [bx+0Ah], ax	;@023C2
	mov	word ptr [bx+6], 0	;@023C5
	mov	word ptr [bx+4], 0	;@023CA
	call	L00C5F	;@023CF
	mov	word ptr [bp-2], ax	;@023D2
	mov	word ptr ds:[0Eh], ax	;@023D5
	mov	word ptr ds:[16h], ax	;@023D8
	mov	bx, word ptr [bp-2]	;@023DB
	mov	ax, word ptr ds:[2]	;@023DE
	mov	dx, word ptr ds:[0]	;@023E1
	mov	word ptr [bx+2], ax	;@023E5
	mov	word ptr [bx], dx	;@023E8
	mov	ax, word ptr ds:[6]	;@023EA
	mov	dx, word ptr ds:[4]	;@023ED
	mov	word ptr [bx+6], ax	;@023F1
	mov	word ptr [bx+4], dx	;@023F4
	push	word ptr ds:[10h]	;@023F7
	push	word ptr [bp-2]	;@023FB
	call	L00FD4	;@023FE
	push	word ptr [bp-2]	;@02401
	call	L00F53	;@02404
	mov	ax, word ptr [bp-2]	;@02407
	mov	word ptr ds:[20h], ax	;@0240A
	push	word ptr [bp-2]	;@0240D
	call	L00C5F	;@02410
	push	ax	;@02413
	call	L00FD4	;@02414
	mov	bx, word ptr [bp-2]	;@02417
	mov	ax, word ptr [bx+0Ah]	;@0241A
	mov	word ptr [bp-2], ax	;@0241D
	mov	word ptr ds:[12h], ax	;@02420
	mov	word ptr ds:[18h], ax	;@02423
	mov	ax, word ptr ds:[2]	;@02426
	mov	dx, word ptr ds:[0]	;@02429
	add	dx, word ptr ds:[4]	;@0242D
	adc	ax, word ptr ds:[6]	;@02431
	mov	bx, word ptr [bp-2]	;@02435
	mov	word ptr [bx+2], ax	;@02438
	mov	word ptr [bx], dx	;@0243B
	mov	word ptr [bx+6], 0	;@0243D
	mov	word ptr [bx+4], 0	;@02442
	mov	word ptr [bx+0Eh], 8000h	;@02447
	leave	;@0244C
	ret	0Ch	;@0244D
L02450:	push	bp	;@02450
	mov	bp, sp	;@02451
	dec	sp	;@02453
	dec	sp	;@02454
	call	L00C5F	;@02455
	mov	word ptr [bp-2], ax	;@02458
	push	word ptr ds:[10h]	;@0245B
	push	word ptr [bp-2]	;@0245F
	call	L00FD4	;@02462
	mov	bx, word ptr [bp-2]	;@02465
	mov	ax, word ptr [bp+4]	;@02468
	mov	word ptr [bx+0Ch], ax	;@0246B
	mov	byte ptr [bx+17h], 5	;@0246E
	mov	byte ptr [bx+10h], 0	;@02472
	mov	ax, word ptr [bp-2]	;@02476
	leave	;@02479
	ret	2	;@0247A
	db	55h, 8Bh, 0ECh, 0FFh, 76h, 4, 0E8h, 0Ah, 0E8h, 33h, 0C0h, 5Dh	;@0247D
	db	0C2h, 2, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 1Eh, 0B8h, 87h, 0Bh, 8Eh
	db	0D8h, 0A1h, 0D8h, 6, 89h, 46h, 0FEh, 0A1h, 0DAh, 6, 0A3h, 0D8h
	db	6, 8Eh, 1Eh, 0D8h, 6, 6Ah, 0FFh, 6Ah, 0FFh, 0FFh, 36h, 16h, 0
	db	0FFh, 36h, 18h, 0, 0E8h, 0B9h, 0F4h, 8Eh, 1Eh, 0Ch, 0, 8Bh, 46h
	db	0FEh, 0A3h, 0D8h, 6, 1Fh, 0C9h, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 0B8h
	db	87h, 0Bh, 8Eh, 0D8h, 6Ah, 0FFh, 9Ah, 96h, 1Bh, 3Fh, 0, 1Fh, 5Dh
	db	0CBh, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h
	db	0A1h, 0D8h, 6, 89h, 46h, 0FCh, 8Bh, 46h, 6, 0BAh, 10h, 0, 0F7h
	db	0E2h, 89h, 46h, 0F8h, 89h, 56h, 0FAh, 0A1h, 0DAh, 6, 3Bh, 6, 0E0h
	db	6, 74h, 6, 0B8h, 0FFh, 0FFh, 0E9h, 27h, 1, 0A1h, 0DAh, 6, 0A3h
	db	0D8h, 6, 8Eh, 1Eh, 0D8h, 6, 8Eh, 6, 0Ch, 0, 8Bh, 1Eh, 12h, 0, 8Bh
	db	7, 26h, 0A3h, 0D0h, 6, 8Bh, 47h, 2, 26h, 0A3h, 0D2h, 6, 0A1h, 18h
	db	0, 3Bh, 6, 12h, 0, 74h, 3, 0E9h, 0CCh, 0, 0A0h, 9, 0, 0Ch, 8, 0A2h
	db	9, 0, 0E8h, 22h, 0F2h, 3Bh, 56h, 0FAh, 'w)r', 5, 3Bh, 46h, 0F8h
	db	73h, 22h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h, 0FFh, 36h, 0Eh, 0
	db	0FFh, 36h, 16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 13h, 0F3h, 0Bh, 0C0h
	db	74h, 9, 0E8h, 0FAh, 0F1h, 89h, 56h, 0FAh, 89h, 46h, 0F8h, 0FFh
	db	76h, 0FAh, 0FFh, 76h, 0F8h, 0FFh, 36h, 16h, 0, 0FFh, 36h, 18h
	db	0, 0E8h, 0F5h, 0F3h, 8Bh, 1Eh, 12h, 0, 8Bh, 47h, 8, 89h, 46h, 0FEh
	db	8Bh, 5Eh, 0FEh, 0F7h, 47h, 0Eh, 4, 0, 74h, 66h, 8Bh, 47h, 6, 8Bh
	db	57h, 4, 3Bh, 46h, 0FAh, 77h, 1Ch, 75h, 5, 3Bh, 56h, 0F8h, 77h
	db	15h, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 6, 8Bh, 57h, 4, 83h, 0EAh, 10h
	db	1Dh, 0, 0, 89h, 46h, 0FAh, 89h, 56h, 0F8h, 8Bh, 46h, 0FAh, 8Bh
	db	56h, 0F8h, 29h, 16h, 1Ch, 0, 19h, 6, 1Eh, 0, 8Bh, 5Eh, 0FEh, 29h
	db	57h, 4, 19h, 47h, 6, 8Bh, 47h, 2, 8Bh, 17h, 3, 57h, 4, 13h, 47h
	db	6, 8Bh, 1Eh, 12h, 0, 89h, 47h, 2, 89h, 17h, 8Bh, 47h, 2, 8Bh, 17h
	db	2Bh, 16h, 0, 0, 1Bh, 6, 2, 0, 0A3h, 6, 0, 89h, 16h, 4, 0, 0A0h
	db	9, 0, 24h, 0F7h, 0A2h, 9, 0, 8Eh, 6, 0Ch, 0, 8Bh, 46h, 0FCh, 26h
	db	0A3h, 0D8h, 6, 0A1h, 0, 0, 8Bh, 16h, 2, 0, 3, 6, 4, 0, 13h, 16h
	db	6, 0, 5, 0Fh, 0, 83h, 0D2h, 0, 0D1h, 0EAh, 0D1h, 0D8h, 0D1h, 0EAh
	db	0D1h, 0D8h, 0D1h, 0EAh, 0D1h, 0D8h, 0D1h, 0EAh, 0D1h, 0D8h, 1Fh
	db	0C9h, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 6, 1Eh, 0B8h, 87h
	db	0Bh, 8Eh, 0D8h, 8Bh, 46h, 6, 0C7h, 46h, 0FEh, 0, 0, 89h, 46h, 0FCh
	db	0A1h, 0D8h, 6, 89h, 46h, 0FAh, 0A1h, 0DAh, 6, 3Bh, 6, 0E0h, 6
	db	75h, 5Fh, 0B8h, 10h, 0, 0F7h, 66h, 6, 89h, 46h, 0FCh, 89h, 56h
	db	0FEh, 0A1h, 0DAh, 6, 0A3h, 0D8h, 6, 8Bh, 46h, 0FCh, 0Bh, 46h, 0FEh
	db	75h, 0Dh, 0A1h, 0D2h, 6, 8Bh, 16h, 0D0h, 6, 89h, 46h, 0FEh, 89h
	db	56h, 0FCh, 8Eh, 1Eh, 0D8h, 6, 8Bh, 1Eh, 12h, 0, 8Bh, 47h, 2, 8Bh
	db	17h, 3Bh, 46h, 0FEh, 77h, 1Bh, 72h, 5, 3Bh, 56h, 0FCh, 73h, 14h
	db	8Bh, 1Eh, 12h, 0, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 2Bh, 17h, 1Bh
	db	47h, 2, 50h, 52h, 0E8h, 0B0h, 0FBh, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 8Bh
	db	46h, 0FAh, 0A3h, 0D8h, 6, 1Fh, 0C9h, 0CAh, 2, 0, 55h, 8Bh, 0ECh
	db	83h, 0ECh, 4, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0A1h, 0D8h, 6, 89h
	db	46h, 0FEh, 0E8h, 7Bh, 0E4h, 0Bh, 0C0h, 75h, 3Ah, 0C7h, 6, 0CEh
	db	6, 0, 0, 0A1h, 0DEh, 6, 0A3h, 0D8h, 6, 8Eh, 1Eh, 0DEh, 6, 68h
	db	0, 8, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 6, 6Ah, 0, 6Ah
	db	0, 0E8h, 2Ah, 6, 89h, 46h, 0FCh, 8Eh, 1Eh, 0Ch, 0, 8Bh, 46h, 0FEh
	db	0A3h, 0D8h, 6, 83h, 7Eh, 0FCh, 0, 74h, 4, 33h, 0C0h, 0EBh, 17h
	db	0B8h, 87h, 0Bh, 8Eh, 0D8h, 0C7h, 6, 0CEh, 6, 0, 10h, 6Ah, 1, 68h
	db	0, 10h, 0FFh, 1Eh, 0C4h, 60h, 0B8h, 0, 10h, 1Fh, 0C9h, 0CAh, 6
	db	0, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h
	db	0A1h, 0D8h, 6, 89h, 46h, 0FEh, 0E8h, 0Ch, 0E4h, 0Bh, 0C0h, 75h
	db	64h, 0C7h, 6, 0CEh, 6, 0, 0, 0A1h, 0DEh, 6, 0A3h, 0D8h, 6, 8Eh
	db	1Eh, 0DEh, 6, 0E8h, 2Eh, 0E6h, 89h, 56h, 0FAh, 89h, 46h, 0F8h
	db	0Bh, 46h, 0FAh, 'tFh', 0, 8, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F8h
	db	0FFh, 76h, 6, 6Ah, 0, 6Ah, 0, 0E8h, 0ADh, 5, 89h, 46h, 0FCh, 0Bh
	db	0C0h, 74h, 1Ah, 8Bh, 5Eh, 0FCh, 81h, 4Fh, 0Eh, 0, 40h, 8Eh, 1Eh
	db	0Ch, 0, 8Bh, 46h, 0FEh, 0A3h, 0D8h, 6, 8Bh, 56h, 0FAh, 8Bh, 46h
	db	0F8h, 0EBh, 30h, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 8Eh, 1Eh, 0DEh, 6, 0FFh
	db	76h, 0FAh, 0FFh, 76h, 0F8h, 0E8h, 48h, 0E6h, 0B8h, 87h, 0Bh, 8Eh
	db	0D8h, 8Bh, 46h, 0FEh, 0A3h, 0D8h, 6, 0C7h, 6, 0CEh, 6, 0, 10h
	db	6Ah, 1, 68h, 0, 10h, 0FFh, 1Eh, 0C4h, 60h, 33h, 0D2h, 33h, 0C0h
	db	1Fh, 0C9h, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 0B8h
	db	87h, 0Bh, 8Eh, 0D8h, 0C4h, 5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh, 46h
	db	0FEh, 50h, 0E8h, 57h, 13h, 89h, 46h, 0FCh, 83h, 7Eh, 0FCh, 6, 7Dh
	db	3Ah, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 0DEh, 6, 0C4h, 5Eh
	db	6, 26h, 0FFh, 37h, 0E8h, 0B4h, 15h, 8Bh, 5Eh, 0FEh, 0F7h, 47h
	db	0Eh, 0, 40h, 74h, 0Bh, 0FFh, 76h, 8, 0FFh, 76h, 6, 0E8h, 0DDh
	db	0E5h, 0EBh, 8, 0C4h, 5Eh, 6, 26h, 0C7h, 7, 0, 0, 0FFh, 76h, 0FEh
	db	0FFh, 16h, 28h, 0, 33h, 0C0h, 0EBh, 12h, 0C7h, 6, 0CEh, 6, 2, 10h
	db	6Ah, 1, 68h, 2, 10h, 0FFh, 1Eh, 0C4h, 60h, 0B8h, 2, 10h, 1Fh, 0C9h
	db	0CAh, 4, 0
FREE_TAG_NODES:	push	bp	;@0283E
	mov	bp, sp	;@0283F
	sub	sp, 6	;@02841
	push	ds	;@02844
	mov	ax, 0B87h	;@02845
	mov	ds, ax	;@02848
	cmp	byte ptr [bp+6], 0	;@0284A
	jne	@@1	;@0284E
	mov	al, byte ptr ds:[6CCh]	;@02850
	jmp	short @@2	;@02853
@@1:	mov	al, byte ptr [bp+6]	;@02855
@@2:	mov	byte ptr [bp-1], al	;@02858
	mov	word ptr [bp-4], 0	;@0285B
	jmp	@@14	;@02860
@@3:	mov	bx, word ptr [bp-4]	;@02863
	shl	bx, 1	;@02866
	mov	cx, word ptr [bx+6DEh]	;@02868
	jcxz	@@4	;@0286C
	jmp	short @@5	;@0286E
@@4:	jmp	@@13	;@02870
@@5:	mov	ds, cx	;@02873
	mov	bx, word ptr ds:[10h]	;@02875
	jmp	short @@12	;@02879
@@6:	mov	bx, word ptr [bp-6]	;@0287B
	test	word ptr [bx+0Eh], 4	;@0287E
	jne	@@11	;@02883
	mov	al, byte ptr [bx+10h]	;@02885
	cmp	al, byte ptr [bp-1]	;@02888
	jne	@@11	;@0288B
	les	bx, dword ptr [bx+12h]	;@0288D
	push	word ptr es:[bx]	;@02890
	call	L03DB3	;@02893
	mov	bx, word ptr [bp-6]	;@02896
	test	word ptr [bx+0Eh], 4000h	;@02899
	je	@@7	;@0289E
	push	word ptr [bx+14h]	;@028A0
	push	word ptr [bx+12h]	;@028A3
	call	L00DEF	;@028A6
	jmp	short @@8	;@028A9
@@7:	mov	bx, word ptr [bp-6]	;@028AB
	les	bx, dword ptr [bx+12h]	;@028AE
	mov	word ptr es:[bx], 0	;@028B1
@@8:	push	word ptr [bp-6]	;@028B6
	call	word ptr ds:[28h]	;@028B9
	mov	bx, word ptr [bp-6]	;@028BD
	cmp	word ptr [bx+8], 0	;@028C0
	jne	@@11	;@028C4
	jmp	short @@10	;@028C6
@@9:	mov	bx, word ptr [bp-6]	;@028C8
	mov	ax, word ptr [bx+0Ah]	;@028CB
	mov	word ptr [bp-6], ax	;@028CE
@@10:	mov	bx, word ptr [bp-6]	;@028D1
	cmp	word ptr [bx+8], 0	;@028D4
	je	@@9	;@028D8
	mov	ax, word ptr [bx+8]	;@028DA
	mov	word ptr [bp-6], ax	;@028DD
@@11:	mov	bx, word ptr [bp-6]	;@028E0
@@12:	mov	ax, word ptr [bx+0Ah]	;@028E3
	mov	word ptr [bp-6], ax	;@028E6
	mov	ax, word ptr [bp-6]	;@028E9
	cmp	ax, word ptr ds:[12h]	;@028EC
	jne	@@6	;@028F0
	mov	ax, 0B87h	;@028F2
	mov	ds, ax	;@028F5
@@13:	inc	word ptr [bp-4]	;@028F7
@@14:	cmp	word ptr [bp-4], 6	;@028FA
	jge	@@15	;@028FE
	jmp	@@3	;@02900
@@15:	pop	ds	;@02903
	leave	;@02904
	retf	2	;@02905
SET_NODE_INFO:	push	bp	;@02908
	mov	bp, sp	;@02909
	sub	sp, 4	;@0290B
	push	ds	;@0290E
	mov	ax, 0B87h	;@0290F
	mov	ds, ax	;@02912
	les	bx, dword ptr [bp+0Ah]	;@02914
	push	word ptr es:[bx]	;@02917
	push	ss	;@0291A
	lea	ax, [bp-2]	;@0291B
	push	ax	;@0291E
	call	L03B3B	;@0291F
	mov	word ptr [bp-4], ax	;@02922
	cmp	word ptr [bp-4], 6	;@02925
	jge	@@1	;@02929
	mov	word ptr ds:[6CEh], 0	;@0292B
	mov	bx, word ptr [bp-4]	;@02931
	shl	bx, 1	;@02934
	mov	ds, word ptr [bx+6DEh]	;@02936
	push	word ptr [bp+8]	;@0293A
	push	word ptr [bp+6]	;@0293D
	call	L04F05	;@02940
	mov	bx, word ptr [bp-2]	;@02943
	mov	byte ptr [bx+16h], al	;@02946
	or	al, al	;@02949
	je	@@1	;@0294B
	xor	ax, ax	;@0294D
	jmp	short @@2	;@0294F
@@1:	mov	word ptr ds:[6CEh], 1002h	;@02951
	mov	ax, 1002h	;@02957
@@2:	pop	ds	;@0295A
	leave	;@0295B
	retf	8	;@0295C
RH_HANDLE_TRY_FLAG20:	push	bp	;@0295F
	mov	bp, sp	;@02960
	sub	sp, 6	;@02962
	push	ds	;@02965
	mov	ax, 0B87h	;@02966
	mov	ds, ax	;@02969
	les	bx, dword ptr [bp+6]	;@0296B
	push	word ptr es:[bx]	;@0296E
	push	ss	;@02971
	lea	ax, [bp-2]	;@02972
	push	ax	;@02975
	call	L03B3B	;@02976
	mov	word ptr [bp-4], ax	;@02979
	cmp	word ptr [bp-4], 0	;@0297C
	je	@@1	;@02980
	cmp	word ptr [bp-4], 1	;@02982
	jne	@@2	;@02986
@@1:	call	L00B4B	;@02988
	or	ax, ax	;@0298B
	jne	@@2	;@0298D
	mov	ax, word ptr ds:[6D8h]	;@0298F
	mov	word ptr [bp-6], ax	;@02992
	mov	bx, word ptr [bp-4]	;@02995
	shl	bx, 1	;@02998
	mov	ax, word ptr [bx+6DEh]	;@0299A
	mov	word ptr ds:[6D8h], ax	;@0299E
	mov	word ptr ds:[6CEh], 0	;@029A1
	push	ds	;@029A7
	mov	bx, word ptr [bp-4]	;@029A8
	shl	bx, 1	;@029AB
	mov	ds, word ptr [bx+6DEh]	;@029AD
	push	word ptr [bp-2]	;@029B1
	call	L01463	;@029B4
	pop	ds	;@029B7
	mov	ax, word ptr [bp-6]	;@029B8
	mov	word ptr ds:[6D8h], ax	;@029BB
	xor	ax, ax	;@029BE
	jmp	short @@3	;@029C0
@@2:	mov	word ptr ds:[6CEh], 1000h	;@029C2
	mov	ax, 1000h	;@029C8
@@3:	pop	ds	;@029CB
	leave	;@029CC
	retf	4	;@029CD
ALLOC_BANK5_NODE:	push	bp	;@029D0
	mov	bp, sp	;@029D1
	dec	sp	;@029D3
	dec	sp	;@029D4
	push	ds	;@029D5
	mov	ax, 0B87h	;@029D6
	mov	ds, ax	;@029D9
	mov	ax, word ptr [bp+6]	;@029DB
	or	ax, word ptr [bp+8]	;@029DE
	je	@@1	;@029E1
	call	L00B4B	;@029E3
	or	ax, ax	;@029E6
	jne	@@1	;@029E8
	mov	word ptr ds:[6CEh], 0	;@029EA
	mov	ds, word ptr ds:[6E8h]	;@029F0
	push	word ptr [bp+0Ah]	;@029F4
	call	L02450	;@029F7
	mov	word ptr [bp-2], ax	;@029FA
	mov	bx, word ptr [bp-2]	;@029FD
	mov	ax, word ptr [bp+0Ah]	;@02A00
	mov	word ptr [bx+0Ch], ax	;@02A03
	mov	word ptr [bx+0Eh], 761h	;@02A06
	mov	ax, word ptr [bp+0Eh]	;@02A0B
	mov	dx, word ptr [bp+0Ch]	;@02A0E
	mov	word ptr [bx+14h], ax	;@02A11
	mov	word ptr [bx+12h], dx	;@02A14
	push	word ptr [bp+8]	;@02A17
	push	word ptr [bp+6]	;@02A1A
	call	L04F05	;@02A1D
	mov	bx, word ptr [bp-2]	;@02A20
	mov	byte ptr [bx+16h], al	;@02A23
	push	word ptr [bp-2]	;@02A26
	push	3	;@02A29
	call	L03A4D	;@02A2B
	xor	ax, ax	;@02A2E
	jmp	short @@2	;@02A30
@@1:	mov	word ptr ds:[6CEh], 1002h	;@02A32
	mov	ax, 1002h	;@02A38
@@2:	pop	ds	;@02A3B
	leave	;@02A3C
	retf	0Ah	;@02A3D
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 10h, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h	;@02A40
	db	0C6h, 46h, 0F3h, 0, 0A1h, 0D8h, 6, 89h, 46h, 0F0h, 8Bh, 46h, 8
	db	8Bh, 56h, 6, 89h, 46h, 0FAh, 89h, 56h, 0F8h, 8Eh, 1Eh, 0DEh, 6
	db	0A1h, 3Ah, 0, 8Bh, 16h, 38h, 0, 3, 16h, 1Ch, 0, 13h, 6, 1Eh, 0
	db	89h, 46h, 0FEh, 89h, 56h, 0FCh, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 8Bh
	db	0Eh, 0E0h, 6, 0E3h, 1Ch, 8Eh, 0D9h, 0A1h, 3Ah, 0, 8Bh, 16h, 38h
	db	0, 3, 16h, 1Ch, 0, 13h, 6, 1Eh, 0, 1, 56h, 0FCh, 11h, 46h, 0FEh
	db	2Eh, 8Eh, 1Eh, 0F1h, 48h, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 3Bh
	db	46h, 0FAh, 76h, 3, 0EBh, 7Ch, 90h, 72h, 8, 3Bh, 56h, 0F8h, 72h
	db	3, 0EBh, 72h, 90h, 80h, 7Eh, 0F3h, 0, 75h, 6Bh, 0A1h, 0DEh, 6
	db	0A3h, 0D8h, 6, 8Eh, 1Eh, 0DEh, 6, 8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h
	db	2Bh, 16h, 38h, 0, 1Bh, 6, 3Ah, 0, 50h, 52h, 0FFh, 36h, 0Eh, 0
	db	0FFh, 36h, 16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 86h, 0EDh, 0Bh, 0C0h
	db	't2.', 8Eh, 1Eh, 0F1h, 48h, 8Bh, 0Eh, 0E0h, 6, 0E3h, 27h, 0A1h
	db	0E0h, 6, 0A3h, 0D8h, 6, 8Eh, 0D9h, 8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h
	db	2Bh, 16h, 38h, 0, 1Bh, 6, 3Ah, 0, 50h, 52h, 0FFh, 36h, 0Eh, 0
	db	0FFh, 36h, 16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 50h, 0EDh, 2Eh, 8Eh
	db	1Eh, 0F1h, 48h, 0C6h, 46h, 0F3h, 1, 0E9h, 37h, 0FFh, 8Eh, 1Eh
	db	0DEh, 6, 8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h, 3Bh, 46h, 0FEh, 77h, 0Fh
	db	72h, 5, 3Bh, 56h, 0FCh, 73h, 8, 8Bh, 56h, 0FAh, 8Bh, 46h, 0F8h
	db	0EBh, 6, 8Bh, 56h, 0FEh, 8Bh, 46h, 0FCh, 89h, 16h, 3Eh, 0, 0A3h
	db	3Ch, 0, 89h, 56h, 0FEh, 89h, 46h, 0FCh, 2Eh, 8Eh, 1Eh, 0F1h, 48h
	db	8Bh, 46h, 0F0h, 0A3h, 0D8h, 6, 8Bh, 0Eh, 0E0h, 6, 0E3h, 14h, 8Eh
	db	0D9h, 8Bh, 46h, 0FEh, 8Bh, 56h, 0FCh, 0A3h, 3Eh, 0, 89h, 16h, 3Ch
	db	0, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 8Eh, 1Eh, 0DEh, 6, 0A1h, 3Eh, 0, 8Bh
	db	16h, 3Ch, 0, 89h, 46h, 0F6h, 89h, 56h, 0F4h, 8Bh, 56h, 0F6h, 8Bh
	db	46h, 0F4h, 1Fh, 0C9h, 0CAh, 4, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4
	db	1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 8Eh, 1Eh, 0DAh, 6, 0A1h, 3Eh, 0
	db	8Bh, 16h, 3Ch, 0, 89h, 46h, 0FEh, 89h, 56h, 0FCh, 8Bh, 56h, 0FEh
	db	8Bh, 46h, 0FCh, 1Fh, 0C9h, 0CBh
SET_NODE_REQUEST_SIZE:	push	bp	;@02BC3
	mov	bp, sp	;@02BC4
	sub	sp, 4	;@02BC6
	push	ds	;@02BC9
	mov	ax, 0B87h	;@02BCA
	mov	ds, ax	;@02BCD
	les	bx, dword ptr [bp+8]	;@02BCF
	push	word ptr es:[bx]	;@02BD2
	push	ss	;@02BD5
	lea	ax, [bp-2]	;@02BD6
	push	ax	;@02BD9
	call	L03B3B	;@02BDA
	mov	word ptr [bp-4], ax	;@02BDD
	cmp	word ptr [bp-4], 5	;@02BE0
	jne	@@1	;@02BE4
	mov	word ptr ds:[6CEh], 0	;@02BE6
	mov	ds, word ptr ds:[6E8h]	;@02BEC
	mov	bx, word ptr [bp-2]	;@02BF0
	mov	ax, word ptr [bp+6]	;@02BF3
	mov	word ptr [bx+0Ch], ax	;@02BF6
	xor	ax, ax	;@02BF9
	jmp	short @@2	;@02BFB
@@1:	mov	word ptr ds:[6CEh], 1002h	;@02BFD
	mov	ax, 1002h	;@02C03
@@2:	pop	ds	;@02C06
	leave	;@02C07
	retf	6	;@02C08
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0C4h	;@02C0B
	db	5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 16h, 0Fh
	db	89h, 46h, 0FCh, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 0DEh, 6
	db	8Bh, 5Eh, 0FEh, 81h, 4Fh, 0Eh, 0, 80h, 1Fh, 0C9h, 0CAh, 4, 0, 55h
	db	8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0C4h
	db	5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 0E3h, 0Eh
	db	89h, 46h, 0FCh, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 0DEh, 6
	db	8Bh, 5Eh, 0FEh, 81h, 67h, 0Eh, 0FFh, 7Fh, 1Fh, 0C9h, 0CAh, 4, 0
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 8, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0C4h
	db	5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 0B0h, 0Eh
	db	89h, 46h, 0FCh, 0C7h, 46h, 0FAh, 0, 10h, 83h, 7Eh, 0FCh, 0, 74h
	db	6, 83h, 7Eh, 0FCh, 1, 75h, 43h, 0E8h, 0A9h, 0DEh, 0Bh, 0C0h, 75h
	db	3Ch, 0A1h, 0D8h, 6, 89h, 46h, 0F8h, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h
	db	8Bh, 87h, 0DEh, 6, 0A3h, 0D8h, 6, 1Eh, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h
	db	8Eh, 9Fh, 0DEh, 6, 8Bh, 5Eh, 0FEh, 83h, 7Fh, 0Ch, 0, 74h, 0Bh
	db	0FFh, 76h, 0FEh, 0E8h, 51h, 0E5h, 89h, 46h, 0FAh, 0EBh, 5, 0C7h
	db	46h, 0FAh, 0, 0, 1Fh, 8Bh, 46h, 0F8h, 0A3h, 0D8h, 6, 8Bh, 46h
	db	0FAh, 0A3h, 0CEh, 6, 8Bh, 46h, 0FAh, 1Fh, 0C9h, 0CAh, 4, 0, 55h
	db	8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0C4h
	db	5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 31h, 0Eh
	db	89h, 46h, 0FCh, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 0DEh, 6
	db	8Bh, 5Eh, 0FEh, 8Bh, 47h, 0Eh, 1Fh, 0C9h, 0CAh, 4, 0
L02D21:	push	bp	;@02D21
	mov	bp, sp	;@02D22
	sub	sp, 0Ah	;@02D24
	mov	ax, 0B87h	;@02D27
	mov	ds, ax	;@02D2A
@@1:	test	word ptr [bp+0Eh], 4620h	;@02D2C
	je	@@2	;@02D31
	mov	ax, word ptr ds:[6DAh]	;@02D33
	mov	word ptr ds:[6D8h], ax	;@02D36
@@2:	mov	byte ptr [bp-3], 0	;@02D39
@@3:	mov	ds, word ptr ds:[6D8h]	;@02D3D
	test	word ptr [bp+0Eh], 400h	;@02D41
	je	@@4	;@02D46
	mov	al, byte ptr ds:[9]	;@02D48
	or	al, 1	;@02D4B
	mov	byte ptr ds:[9], al	;@02D4D
@@4:	push	word ptr [bp+8]	;@02D50
	call	L01BF6	;@02D53
	mov	word ptr [bp-2], ax	;@02D56
	mov	al, byte ptr ds:[9]	;@02D59
	and	al, 0FEh	;@02D5C
	mov	byte ptr ds:[9], al	;@02D5E
	cmp	word ptr [bp-2], 0	;@02D61
	jne	@@6	;@02D65
	mov	al, byte ptr [bp-3]	;@02D67
	mov	ah, 0	;@02D6A
	or	ax, ax	;@02D6C
	jne	@@6	;@02D6E
	mov	byte ptr [bp-3], 1	;@02D70
	mov	ds, word ptr cs:L0532F+2	;@02D74
	mov	ax, word ptr ds:[6D8h]	;@02D79
	cmp	ax, word ptr ds:[6E0h]	;@02D7C
	jne	@@5	;@02D80
	test	word ptr [bp+0Eh], 4000h	;@02D82
	jne	@@6	;@02D87
	mov	ax, word ptr ds:[6DEh]	;@02D89
	mov	word ptr ds:[6D8h], ax	;@02D8C
	jmp	@@3	;@02D8F
@@5:	cmp	word ptr ds:[6E0h], 0	;@02D91
	je	@@6	;@02D96
	mov	ax, word ptr ds:[6E0h]	;@02D98
	mov	word ptr ds:[6D8h], ax	;@02D9B
	jmp	@@3	;@02D9E
@@6:	cmp	word ptr [bp-2], 0	;@02DA0
	jne	@@7	;@02DA4
	mov	ds, word ptr cs:L0532F+2	;@02DA6
	push	1	;@02DAB
	push	100h	;@02DAD
	call	dword ptr ds:[60C4h]	;@02DB0
	cmp	word ptr ds:[6CEh], 0	;@02DB4
	jne	@@7	;@02DB9
	jmp	@@1	;@02DBB
@@7:	cmp	word ptr [bp-2], 0	;@02DBE
	jne	@@8	;@02DC2
	jmp	@@15	;@02DC4
@@8:	mov	bx, word ptr [bp-2]	;@02DC7
	mov	ax, word ptr [bp+0Ch]	;@02DCA
	mov	dx, word ptr [bp+0Ah]	;@02DCD
	mov	word ptr [bx+14h], ax	;@02DD0
	mov	word ptr [bx+12h], dx	;@02DD3
	mov	ax, word ptr [bp+0Eh]	;@02DD6
	and	ax, 600h	;@02DD9
	or	word ptr [bx+0Eh], ax	;@02DDC
	cmp	word ptr [bp+4], 0	;@02DDF
	jne	@@9	;@02DE3
	jmp	@@14	;@02DE5
@@9:	mov	ax, word ptr [bx+2]	;@02DE8
	mov	dx, word ptr [bx]	;@02DEB
	mov	word ptr [bp-6], ax	;@02DED
	mov	word ptr [bp-8], dx	;@02DF0
	mov	al, byte ptr ds:[8]	;@02DF3
	mov	ah, 0	;@02DF6
	mov	word ptr [bp-0Ah], ax	;@02DF8
	push	ds	;@02DFB
	mov	ds, word ptr cs:L0532F+2	;@02DFC
	mov	bx, word ptr [bp+6]	;@02E01
	shl	bx, 1	;@02E04
	mov	ds, word ptr [bx+6DEh]	;@02E06
	mov	bx, word ptr [bp+4]	;@02E0A
	mov	ax, word ptr [bx+0Ch]	;@02E0D
	cmp	ax, word ptr [bp+8]	;@02E10
	jbe	@@10	;@02E13
	mov	ax, word ptr [bp+8]	;@02E15
	mov	word ptr [bx+0Ch], ax	;@02E18
@@10:	push	word ptr [bp+6]	;@02E1B
	push	word ptr [bp-0Ah]	;@02E1E
	push	word ptr [bp+4]	;@02E21
	push	word ptr [bp-2]	;@02E24
	call	L00F05	;@02E27
	push	word ptr [bp+4]	;@02E2A
	push	word ptr [bp-6]	;@02E2D
	push	word ptr [bp-8]	;@02E30
	call	word ptr ds:[2Eh]	;@02E33
	mov	bx, word ptr [bp+4]	;@02E37
	test	word ptr [bx+0Eh], 200h	;@02E3A
	je	@@11	;@02E3F
	cmp	word ptr [bp+6], 2	;@02E41
	jl	@@11	;@02E45
	cmp	word ptr [bp+6], 5	;@02E47
	jge	@@11	;@02E4B
	pop	ds	;@02E4D
	mov	bx, word ptr [bp-2]	;@02E4E
	or	word ptr [bx+0Eh], 2000h	;@02E51
	mov	al, byte ptr [bp+6]	;@02E56
	mov	cl, 3	;@02E59
	shl	al, cl	;@02E5B
	or	al, byte ptr ds:[8]	;@02E5D
	mov	bx, word ptr [bp-2]	;@02E61
	mov	byte ptr [bx+17h], al	;@02E64
	mov	ax, word ptr [bp+4]	;@02E67
	mov	word ptr [bx+18h], ax	;@02E6A
	jmp	short @@12	;@02E6D
@@11:	push	word ptr [bp+4]	;@02E6F
	call	word ptr ds:[28h]	;@02E72
	pop	ds	;@02E76
	mov	bx, word ptr [bp-2]	;@02E77
	and	word ptr [bx+0Eh], 0DFFFh	;@02E7A
	mov	al, byte ptr ds:[8]	;@02E7F
	mov	byte ptr [bx+17h], al	;@02E82
@@12:	mov	bx, word ptr [bp-2]	;@02E85
	test	word ptr [bx+0Eh], 400h	;@02E88
	je	@@13	;@02E8D
	mov	ax, word ptr [bx+6]	;@02E8F
	mov	dx, word ptr [bx+4]	;@02E92
	add	word ptr ds:[38h], dx	;@02E95
	adc	word ptr ds:[3Ah], ax	;@02E99
@@13:	mov	bx, word ptr [bp-2]	;@02E9D
	and	word ptr [bx+0Eh], 0FE7Fh	;@02EA0
	push	word ptr [bp-2]	;@02EA5
	push	4	;@02EA8
	call	L03A4D	;@02EAA
	mov	bx, word ptr [bp-2]	;@02EAD
	test	word ptr [bx+0Eh], 60h	;@02EB0
	je	@@15	;@02EB5
	mov	es, word ptr ds:[0Ch]	;@02EB7
	inc	word ptr es:[6DCh]	;@02EBB
	mov	bx, word ptr [bp-2]	;@02EC0
	mov	ax, word ptr [bx+6]	;@02EC3
	mov	dx, word ptr [bx+4]	;@02EC6
	add	word ptr ds:[4Ah], dx	;@02EC9
	adc	word ptr ds:[4Ch], ax	;@02ECD
	jmp	short @@15	;@02ED1
@@14:	push	word ptr [bp-2]	;@02ED3
	push	1	;@02ED6
	call	L03A4D	;@02ED8
@@15:	mov	ax, word ptr [bp-2]	;@02EDB
	leave	;@02EDE
	ret	0Ch	;@02EDF
L02EE2:	push	bp	;@02EE2
	mov	bp, sp	;@02EE3
	sub	sp, 0Eh	;@02EE5
	push	ds	;@02EE8
	mov	ax, 0B87h	;@02EE9
	mov	ds, ax	;@02EEC
	mov	word ptr [bp-8], 0	;@02EEE
	mov	ax, word ptr ds:[6D8h]	;@02EF3
	mov	word ptr [bp-0Ah], ax	;@02EF6
	mov	word ptr ds:[6CEh], 0	;@02EF9
	mov	ax, word ptr ds:[6DEh]	;@02EFF
	mov	word ptr ds:[6D8h], ax	;@02F02
	call	L00B4B	;@02F05
	mov	word ptr [bp-8], ax	;@02F08
	or	ax, ax	;@02F0B
	je	@@4	;@02F0D
	test	word ptr [bp+0Eh], 7818h	;@02F0F
	je	@@4	;@02F14
	cmp	word ptr [bp-8], 1005h	;@02F16
	jne	@@1	;@02F1B
	test	word ptr [bp+0Eh], 4800h	;@02F1D
	je	@@4	;@02F22
@@1:	cmp	word ptr [bp+0Eh], 2000h	;@02F24
	je	@@2	;@02F29
	jmp	@@35	;@02F2B
@@2:	les	bx, dword ptr [bp+8]	;@02F2E
	push	word ptr es:[bx]	;@02F31
	push	ss	;@02F34
	lea	ax, [bp-2]	;@02F35
	push	ax	;@02F38
	call	L03B3B	;@02F39
	mov	word ptr [bp-6], ax	;@02F3C
	push	ds	;@02F3F
	mov	bx, word ptr [bp-6]	;@02F40
	shl	bx, 1	;@02F43
	mov	ds, word ptr [bx+6DEh]	;@02F45
	mov	bx, word ptr [bp-2]	;@02F49
	test	word ptr [bx+0Eh], 400h	;@02F4C
	je	@@3	;@02F51
	pop	ds	;@02F53
	jmp	short @@4	;@02F54
@@3:	pop	ds	;@02F56
	jmp	@@35	;@02F57
@@4:	mov	word ptr [bp-8], 0	;@02F5A
	and	word ptr [bp+0Eh], -19h	;@02F5F
	test	word ptr [bp+0Eh], 4800h	;@02F63
	je	@@5	;@02F68
	mov	word ptr [bp-6], 0	;@02F6A
	mov	ds, word ptr ds:[6DEh]	;@02F6F
	mov	word ptr [bp-2], 0	;@02F73
	mov	ax, word ptr [bp+0Ch]	;@02F78
	and	word ptr [bp+0Eh], ax	;@02F7B
	jmp	short @@9	;@02F7E
@@5:	les	bx, dword ptr [bp+8]	;@02F80
	push	word ptr es:[bx]	;@02F83
	push	ss	;@02F86
	lea	ax, [bp-2]	;@02F87
	push	ax	;@02F8A
	call	L03B3B	;@02F8B
	mov	word ptr [bp-6], ax	;@02F8E
	cmp	word ptr [bp-6], 6	;@02F91
	jl	@@6	;@02F95
	mov	word ptr [bp-8], 1002h	;@02F97
	jmp	@@35	;@02F9C
@@6:	cmp	word ptr [bp-6], 0	;@02F9F
	je	@@7	;@02FA3
	cmp	word ptr [bp-6], 1	;@02FA5
	jne	@@8	;@02FA9
@@7:	mov	bx, word ptr [bp-6]	;@02FAB
	shl	bx, 1	;@02FAE
	mov	ax, word ptr [bx+6DEh]	;@02FB0
	mov	word ptr ds:[6D8h], ax	;@02FB4
@@8:	mov	bx, word ptr [bp-6]	;@02FB7
	shl	bx, 1	;@02FBA
	mov	ds, word ptr [bx+6DEh]	;@02FBC
	mov	bx, word ptr [bp-2]	;@02FC0
	mov	ax, word ptr [bx+0Eh]	;@02FC3
	mov	dx, word ptr [bp+0Ch]	;@02FC6
	not	dx	;@02FC9
	and	ax, dx	;@02FCB
	and	ax, 87FFh	;@02FCD
	mov	dx, word ptr [bp+0Eh]	;@02FD0
	and	dx, word ptr [bp+0Ch]	;@02FD3
	or	dx, ax	;@02FD6
	mov	word ptr [bp+0Eh], dx	;@02FD8
	test	word ptr [bx+0Eh], 800h	;@02FDB
	je	@@9	;@02FE0
	push	word ptr [bp-2]	;@02FE2
	call	L01664	;@02FE5
	push	word ptr [bp-2]	;@02FE8
	call	L015F1	;@02FEB
	push	word ptr [bp-2]	;@02FEE
	push	0	;@02FF1
	call	L0169B	;@02FF3
@@9:	test	word ptr [bp+0Eh], 4	;@02FF6
	je	@@12	;@02FFB
	les	bx, dword ptr [bp+8]	;@02FFD
	push	word ptr es:[bx]	;@03000
	call	L03DB3	;@03003
	mov	bx, word ptr [bp-2]	;@03006
	test	word ptr [bx+0Eh], 4000h	;@03009
	je	@@10	;@0300E
	push	word ptr [bp+0Ah]	;@03010
	push	word ptr [bp+8]	;@03013
	call	L00DEF	;@03016
	jmp	short @@11	;@03019
@@10:	les	bx, dword ptr [bp+8]	;@0301B
	mov	word ptr es:[bx], 0	;@0301E
@@11:	push	word ptr [bp-2]	;@03023
	call	word ptr ds:[28h]	;@03026
	jmp	@@35	;@0302A
@@12:	test	word ptr [bp+0Eh], 4800h	;@0302D
	je	@@13	;@03032
	push	word ptr [bp+0Eh]	;@03034
	push	word ptr [bp+0Ah]	;@03037
	push	word ptr [bp+8]	;@0303A
	push	word ptr [bp+6]	;@0303D
	push	0	;@03040
	push	0	;@03042
	call	L02D21	;@03044
	mov	word ptr [bp-2], ax	;@03047
	or	ax, ax	;@0304A
	jne	@@13	;@0304C
	mov	word ptr [bp-8], 1000h	;@0304E
	jmp	@@35	;@03053
@@13:	mov	al, byte ptr ds:[9]	;@03056
	mov	ah, 0	;@03059
	test	ax, 4	;@0305B
	je	@@14	;@0305E
	jmp	@@21	;@03060
@@14:	test	word ptr [bp+0Eh], 1000h	;@03063
	je	@@15	;@03068
	mov	ax, word ptr [bp+6]	;@0306A
	mov	word ptr [bp-0Ch], ax	;@0306D
	and	word ptr [bp+0Eh], 0EFFFh	;@03070
	jmp	short @@16	;@03075
@@15:	mov	bx, word ptr [bp-2]	;@03077
	mov	ax, word ptr [bx+0Ch]	;@0307A
	mov	word ptr [bp-0Ch], ax	;@0307D
@@16:	mov	bx, word ptr [bp-2]	;@03080
	test	word ptr [bx+0Eh], 400h	;@03083
	je	@@17	;@03088
	or	word ptr [bp+0Eh], 400h	;@0308A
@@17:	push	word ptr [bp+0Eh]	;@0308F
	push	word ptr [bp+0Ah]	;@03092
	push	word ptr [bp+8]	;@03095
	push	word ptr [bp-0Ch]	;@03098
	push	word ptr [bp-6]	;@0309B
	push	word ptr [bp-2]	;@0309E
	call	L02D21	;@030A1
	mov	word ptr [bp-2], ax	;@030A4
	or	ax, ax	;@030A7
	jne	@@18	;@030A9
	mov	word ptr [bp-8], 1000h	;@030AB
	jmp	@@35	;@030B0
@@18:	mov	bx, word ptr [bp-2]	;@030B3
	cmp	byte ptr [bx+16h], 0	;@030B6
	je	@@21	;@030BA
	cmp	word ptr [bp-6], 5	;@030BC
	jne	@@19	;@030C0
	push	word ptr [bp-2]	;@030C2
	push	2	;@030C5
	jmp	short @@20	;@030C7
@@19:	push	word ptr [bp-2]	;@030C9
	push	5	;@030CC
@@20:	push	word ptr [bp+0Ah]	;@030CE
	push	word ptr [bp+8]	;@030D1
	les	bx, dword ptr [bp+8]	;@030D4
	push	word ptr es:[bx]	;@030D7
	call	L04EEA	;@030DA
	mov	ds, word ptr cs:L0532F+2	;@030DD
	mov	ds, word ptr ds:[6D8h]	;@030E2
@@21:	test	word ptr [bp+0Eh], 1000h	;@030E6
	jne	@@22	;@030EB
	jmp	@@30	;@030ED
@@22:	push	word ptr [bp+6]	;@030F0
	call	L03C2D	;@030F3
	mov	bx, word ptr [bp-2]	;@030F6
	sub	ax, word ptr [bx+4]	;@030F9
	sbb	dx, word ptr [bx+6]	;@030FC
	mov	word ptr [bp-0Ch], dx	;@030FF
	mov	word ptr [bp-0Eh], ax	;@03102
	test	word ptr [bx+0Eh], 2000h	;@03105
	je	@@23	;@0310A
	push	word ptr [bx+18h]	;@0310C
	push	1	;@0310F
	mov	al, byte ptr [bx+17h]	;@03111
	mov	ah, 0	;@03114
	sar	ax, 3	;@03116
	push	ax	;@03119
	call	L03980	;@0311A
	add	sp, 6	;@0311D
	mov	bx, word ptr [bp-2]	;@03120
	and	word ptr [bx+0Eh], 0DFFFh	;@03123
@@23:	cmp	word ptr [bp-0Ch], 0	;@03128
	jg	@@25	;@0312C
	jl	@@24	;@0312E
	cmp	word ptr [bp-0Eh], 0	;@03130
	jae	@@25	;@03134
@@24:	push	word ptr [bp-2]	;@03136
	push	word ptr [bp+6]	;@03139
	call	L01D49	;@0313C
	jmp	short @@30	;@0313F
@@25:	cmp	word ptr [bp-0Ch], 0	;@03141
	jl	@@29	;@03145
	jg	@@26	;@03147
	cmp	word ptr [bp-0Eh], 0	;@03149
	jbe	@@29	;@0314D
@@26:	mov	bx, word ptr [bp-2]	;@0314F
	or	word ptr [bx+0Eh], 8000h	;@03152
	push	word ptr [bp-2]	;@03157
	push	word ptr [bp+6]	;@0315A
	call	L01E8C	;@0315D
	mov	word ptr [bp-4], ax	;@03160
	or	ax, ax	;@03163
	jne	@@27	;@03165
	mov	ds, word ptr cs:L0532F+2	;@03167
	mov	bx, word ptr [bp-6]	;@0316C
	shl	bx, 1	;@0316F
	mov	ax, word ptr [bx+6DEh]	;@03171
	mov	word ptr ds:[6D8h], ax	;@03175
	mov	bx, word ptr [bp-6]	;@03178
	shl	bx, 1	;@0317B
	mov	ds, word ptr [bx+6DEh]	;@0317D
	jmp	short @@28	;@03181
@@27:	mov	ax, word ptr [bp-4]	;@03183
	mov	word ptr [bp-2], ax	;@03186
@@28:	mov	bx, word ptr [bp-2]	;@03189
	and	word ptr [bx+0Eh], 7FFFh	;@0318C
	cmp	word ptr [bp-4], 0	;@03191
	jne	@@30	;@03195
	mov	word ptr [bp-8], 1000h	;@03197
	jmp	@@35	;@0319C
@@29:	mov	bx, word ptr [bp-2]	;@0319F
	mov	ax, word ptr [bp+6]	;@031A2
	mov	word ptr [bx+0Ch], ax	;@031A5
	push	word ptr [bp-2]	;@031A8
	call	L03C6D	;@031AB
@@30:	mov	bx, word ptr [bp-2]	;@031AE
	test	word ptr [bx+0Eh], 60h	;@031B1
	je	@@31	;@031B6
	test	word ptr [bp+0Eh], 60h	;@031B8
	jne	@@32	;@031BD
	mov	es, word ptr ds:[0Ch]	;@031BF
	dec	word ptr es:[6DCh]	;@031C3
	mov	bx, word ptr [bp-2]	;@031C8
	mov	ax, word ptr [bx+6]	;@031CB
	mov	dx, word ptr [bx+4]	;@031CE
	sub	word ptr ds:[4Ah], dx	;@031D1
	sbb	word ptr ds:[4Ch], ax	;@031D5
	jmp	short @@32	;@031D9
@@31:	test	word ptr [bp+0Eh], 60h	;@031DB
	je	@@32	;@031E0
	mov	es, word ptr ds:[0Ch]	;@031E2
	inc	word ptr es:[6DCh]	;@031E6
	mov	bx, word ptr [bp-2]	;@031EB
	mov	ax, word ptr [bx+6]	;@031EE
	mov	dx, word ptr [bx+4]	;@031F1
	add	word ptr ds:[4Ah], dx	;@031F4
	adc	word ptr ds:[4Ch], ax	;@031F8
@@32:	mov	bx, word ptr [bp-2]	;@031FC
	mov	ax, word ptr [bx+0Eh]	;@031FF
	xor	word ptr [bp+0Eh], ax	;@03202
	mov	ax, word ptr [bp+0Eh]	;@03205
	and	ax, 27Bh	;@03208
	xor	word ptr [bx+0Eh], ax	;@0320B
	test	word ptr [bp+0Eh], 200h	;@0320E
	je	@@33	;@03213
	test	word ptr [bx+0Eh], 200h	;@03215
	jne	@@33	;@0321A
	test	word ptr [bx+0Eh], 2000h	;@0321C
	je	@@33	;@03221
	push	word ptr [bx+18h]	;@03223
	push	1	;@03226
	mov	al, byte ptr [bx+17h]	;@03228
	mov	ah, 0	;@0322B
	sar	ax, 3	;@0322D
	push	ax	;@03230
	call	L03980	;@03231
	add	sp, 6	;@03234
	mov	bx, word ptr [bp-2]	;@03237
	and	word ptr [bx+0Eh], 0DFFFh	;@0323A
@@33:	mov	bx, word ptr [bp-2]	;@0323F
	mov	ax, word ptr [bx+0Eh]	;@03242
	and	ax, 1060h	;@03245
	cmp	ax, 1000h	;@03248
	jne	@@34	;@0324B
	push	word ptr [bp-2]	;@0324D
	call	L015F1	;@03250
@@34:	mov	bx, word ptr [bp-2]	;@03253
	test	word ptr [bx+0Eh], 60h	;@03256
	je	@@35	;@0325B
	test	word ptr [bx+0Eh], 1018h	;@0325D
	jne	@@35	;@03262
	test	byte ptr ds:[9], 2	;@03264
	je	@@35	;@03269
	push	word ptr [bp-2]	;@0326B
	push	1	;@0326E
	call	L0169B	;@03270
@@35:	mov	ax, 0B87h	;@03273
	mov	ds, ax	;@03276
	mov	ax, word ptr [bp-0Ah]	;@03278
	mov	word ptr ds:[6D8h], ax	;@0327B
	mov	ax, word ptr [bp-8]	;@0327E
	mov	word ptr ds:[6CEh], ax	;@03281
	cmp	word ptr [bp-8], 0	;@03284
	je	@@36	;@03288
	push	1	;@0328A
	push	word ptr [bp-8]	;@0328C
	call	dword ptr ds:[60C4h]	;@0328F
@@36:	mov	ax, word ptr [bp-8]	;@03293
	pop	ds	;@03296
	leave	;@03297
	retf	0Ah	;@03298
CHANGE_TAG_NODES_MODE:	push	bp	;@0329B
	mov	bp, sp	;@0329C
	sub	sp, 6	;@0329E
	push	ds	;@032A1
	mov	ax, 0B87h	;@032A2
	mov	ds, ax	;@032A5
	cmp	word ptr [bp+6], 0	;@032A7
	jne	@@1	;@032AB
	mov	al, byte ptr ds:[6CCh]	;@032AD
	mov	ah, 0	;@032B0
	mov	word ptr [bp+6], ax	;@032B2
@@1:	mov	word ptr [bp-4], 0	;@032B5
	jmp	@@11	;@032BA
@@2:	mov	bx, word ptr [bp-4]	;@032BD
	shl	bx, 1	;@032C0
	mov	cx, word ptr [bx+6DEh]	;@032C2
	jcxz	@@10	;@032C6
	mov	ds, cx	;@032C8
	mov	bx, word ptr ds:[10h]	;@032CA
	jmp	short @@8	;@032CE
@@3:	mov	bx, word ptr [bp-2]	;@032D0
	test	word ptr [bx+0Eh], 4	;@032D3
	jne	@@4	;@032D8
	mov	al, byte ptr [bx+10h]	;@032DA
	mov	ah, 0	;@032DD
	cmp	ax, word ptr [bp+6]	;@032DF
	jne	@@4	;@032E2
	push	word ptr [bp+0Ah]	;@032E4
	push	word ptr [bp+8]	;@032E7
	push	word ptr [bx+14h]	;@032EA
	push	word ptr [bx+12h]	;@032ED
	push	0	;@032F0
	push	cs	;@032F2
	call	L02EE2	;@032F3
	mov	word ptr [bp-6], ax	;@032F6
	or	ax, ax	;@032F9
	je	@@4	;@032FB
	jmp	short @@13	;@032FD
@@4:	mov	bx, word ptr [bp-2]	;@032FF
	cmp	word ptr [bx+8], 0	;@03302
	jne	@@7	;@03306
	jmp	short @@6	;@03308
@@5:	mov	bx, word ptr [bp-2]	;@0330A
	mov	ax, word ptr [bx+0Ah]	;@0330D
	mov	word ptr [bp-2], ax	;@03310
@@6:	mov	bx, word ptr [bp-2]	;@03313
	cmp	word ptr [bx+8], 0	;@03316
	je	@@5	;@0331A
	jmp	short @@9	;@0331C
@@7:	mov	bx, word ptr [bp-2]	;@0331E
@@8:	mov	ax, word ptr [bx+0Ah]	;@03321
	mov	word ptr [bp-2], ax	;@03324
@@9:	mov	ax, word ptr [bp-2]	;@03327
	cmp	ax, word ptr ds:[12h]	;@0332A
	jne	@@3	;@0332E
	mov	ax, 0B87h	;@03330
	mov	ds, ax	;@03333
@@10:	inc	word ptr [bp-4]	;@03335
@@11:	cmp	word ptr [bp-4], 6	;@03338
	jge	@@12	;@0333C
	jmp	@@2	;@0333E
@@12:	xor	ax, ax	;@03341
@@13:	pop	ds	;@03343
	leave	;@03344
	retf	6	;@03345
	db	55h, 8Bh, 0ECh, 4Ch, 4Ch, 0E8h, 0Fh, 0D9h, 89h, 46h, 0FEh, 8Bh	;@03348
	db	5Eh, 8, 8Bh, 47h, 6, 8Bh, 57h, 4, 2Bh, 56h, 4, 1Bh, 46h, 6, 8Bh
	db	5Eh, 0FEh, 89h, 47h, 6, 89h, 57h, 4, 8Bh, 5Eh, 8, 8Bh, 46h, 6
	db	8Bh, 56h, 4, 89h, 47h, 6, 89h, 57h, 4, 8Bh, 5Eh, 0FEh, 8Bh, 47h
	db	6, 8Bh, 57h, 4, 29h, 16h, 1Ch, 0, 19h, 6, 1Eh, 0, 8Bh, 5Eh, 8
	db	8Bh, 47h, 2, 8Bh, 17h, 3, 56h, 4, 13h, 46h, 6, 8Bh, 5Eh, 0FEh
	db	89h, 47h, 2, 89h, 17h, 0FFh, 76h, 8, 0FFh, 76h, 0FEh, 0E8h, 2Ah
	db	0DCh, 8Bh, 5Eh, 0FEh, 0C7h, 47h, 0Eh, 4, 0, 0FFh, 76h, 0FEh, 0E8h
	db	9Bh, 0DBh, 8Bh, 46h, 0FEh, 0A3h, 20h, 0, 8Bh, 46h, 0FEh, 0C9h
	db	0C2h, 6, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 1Eh, 1Eh, 0B8h, 87h, 0Bh
	db	8Eh, 0D8h, 0C7h, 46h, 0F6h, 0FFh, 0FFh, 0C7h, 46h, 0F4h, 0FFh
	db	0FFh, 0C7h, 46h, 0EEh, 0, 0, 0A1h, 0D8h, 6, 89h, 46h, 0E4h, 0A1h
	db	0DAh, 6, 0A3h, 0D8h, 6, 8Eh, 1Eh, 0D8h, 6, 0C7h, 46h, 0FCh, 0
	db	0, 83h, 7Eh, 6, 0, 74h, 17h, 8Bh, 46h, 6, 89h, 46h, 0FEh, 0C4h
	db	5Eh, 0FCh, 26h, 8Bh, 47h, 6, 26h, 8Bh, 57h, 4, 89h, 46h, 0F6h
	db	89h, 56h, 0F4h, 8Bh, 46h, 8, 35h, 8, 0, 89h, 46h, 8, 89h, 46h
	db	0FEh, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch, 0, 89h, 46h, 0FAh, 89h, 56h
	db	0F8h, 0C4h, 5Eh, 0FCh, 8Bh, 46h, 0FAh, 26h, 3, 57h, 4, 26h, 13h
	db	47h, 6, 3Bh, 46h, 0F6h, 77h, 1Eh, 72h, 5, 3Bh, 56h, 0F4h, 73h
	db	17h, 0C4h, 5Eh, 0FCh, 8Bh, 46h, 0FAh, 8Bh, 56h, 0F8h, 26h, 3, 57h
	db	4, 26h, 13h, 47h, 6, 89h, 46h, 0F6h, 89h, 56h, 0F4h, 8Bh, 4Eh
	db	8, 8Eh, 0C1h, 26h, 8Bh, 0Eh, 12h, 0, 0E3h, 18h, 8Eh, 0C1h, 26h
	db	0A1h, 4, 0, 26h, 8Bh, 16h, 6, 0, 2Bh, 46h, 0F4h, 1Bh, 56h, 0F6h
	db	79h, 5, 0FFh, 46h, 0EEh, 0EBh, 0E1h, 8Ch, 0C0h, 3Bh, 46h, 8, 75h
	db	3, 0E9h, 3Fh, 2, 8Bh, 46h, 0EEh, 0BAh, 3, 0, 0F7h, 0EAh, 50h, 0E8h
	db	0C1h, 0D4h, 0Bh, 0C0h, 74h, 3, 0E9h, 2Ch, 2, 0C4h, 5Eh, 0FCh, 26h
	db	8Bh, 47h, 6, 26h, 8Bh, 57h, 4, 29h, 56h, 0F4h, 19h, 46h, 0F6h
	db	8Bh, 46h, 0F6h, 8Bh, 56h, 0F4h, 3Bh, 6, 1Eh, 0, 72h, 15h, 77h
	db	6, 3Bh, 16h, 1Ch, 0, 76h, 0Dh, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch, 0
	db	89h, 46h, 0F6h, 89h, 56h, 0F4h, 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h
	db	0FFh, 36h, 16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 8Fh, 0E4h, 89h, 46h
	db	0ECh, 0Bh, 0C0h, 75h, 3, 0E9h, 0D5h, 1, 0FFh, 76h, 8, 8Bh, 5Eh
	db	0ECh, 0FFh, 77h, 2, 0FFh, 37h, 0FFh, 76h, 0F6h, 0FFh, 76h, 0F4h
	db	0E8h, 0D1h, 20h, 0Bh, 0C0h, 74h, 3, 0E9h, 0C4h, 1, 0C4h, 5Eh, 0FCh
	db	26h, 8Bh, 47h, 6, 26h, 8Bh, 57h, 4, 89h, 46h, 0FAh, 89h, 56h, 0F8h
	db	8Bh, 5Eh, 0ECh, 8Bh, 47h, 2, 8Bh, 17h, 89h, 46h, 0F2h, 89h, 56h
	db	0F0h, 0E9h, 8Fh, 1, 1Eh, 8Eh, 1Eh, 0Ch, 0, 0C4h, 5Eh, 0FCh, 26h
	db	0FFh, 77h, 0Eh, 16h, 8Dh, 46h, 0E8h, 50h, 0E8h, 0, 6, 89h, 46h
	db	0E6h, 1Fh, 83h, 7Eh, 0E6h, 0, 74h, 6, 83h, 7Eh, 0E6h, 1, 75h, 24h
	db	8Bh, 5Eh, 0ECh, 0F7h, 47h, 0Eh, 0, 8, 75h, 3, 0E9h, 54h, 1, 0FFh
	db	76h, 0ECh, 0E8h, 6, 0E1h, 0FFh, 76h, 0ECh, 0E8h, 8Dh, 0E0h, 0FFh
	db	76h, 0ECh, 6Ah, 0, 0E8h, 2Fh, 0E1h, 0E9h, 3Dh, 1, 0C4h, 5Eh, 0FCh
	db	26h, 8Bh, 47h, 6, 26h, 8Bh, 57h, 4, 2Bh, 56h, 0F8h, 1Bh, 46h, 0FAh
	db	89h, 46h, 0F6h, 89h, 56h, 0F4h, 8Bh, 46h, 0F2h, 8Bh, 56h, 0F0h
	db	1, 56h, 0F4h, 11h, 46h, 0F6h, 8Bh, 5Eh, 0ECh, 8Bh, 46h, 0F6h, 8Bh
	db	56h, 0F4h, 2Bh, 17h, 1Bh, 47h, 2, 0Bh, 0C0h, 72h, 1Fh, 77h, 4
	db	0Bh, 0D2h, 76h, 19h, 0FFh, 76h, 0ECh, 8Bh, 5Eh, 0ECh, 8Bh, 46h
	db	0F6h, 8Bh, 56h, 0F4h, 2Bh, 17h, 1Bh, 47h, 2, 50h, 52h, 0E8h, 88h
	db	0FDh, 89h, 46h, 0ECh, 0FFh, 76h, 0ECh, 0C4h, 5Eh, 0FCh, 26h, 0FFh
	db	77h, 8, 0E8h, 5Dh, 6, 'RPj', 0, 0E8h, 6Bh, 0DAh, 89h, 46h, 0EAh
	db	0C4h, 5Eh, 0FCh, 26h, 8Bh, 47h, 8, 8Bh, 5Eh, 0ECh, 89h, 47h, 0Ch
	db	0A0h, 8, 0, 0B4h, 0, 89h, 46h, 0E2h, 1Eh, 2Eh, 8Eh, 1Eh, 0F1h
	db	48h, 8Bh, 5Eh, 0E6h, 0D1h, 0E3h, 8Eh, 9Fh, 0DEh, 6, 0FFh, 76h
	db	0E6h, 0FFh, 76h, 0E2h, 0FFh, 76h, 0E8h, 0FFh, 76h, 0ECh, 0E8h
	db	0F8h, 0D8h, 83h, 7Eh, 0E6h, 2, 7Ch, 28h, 83h, 7Eh, 0E6h, 5, 7Dh
	db	22h, 1Fh, 8Bh, 5Eh, 0ECh, 81h, 4Fh, 0Eh, 0, 20h, 8Ah, 46h, 0E6h
	db	0B1h, 3, 0D2h, 0E0h, 0Ah, 6, 8, 0, 8Bh, 5Eh, 0ECh, 88h, 47h, 17h
	db	8Bh, 46h, 0E8h, 89h, 47h, 18h, 0EBh, 11h, 0FFh, 76h, 0E8h, 0FFh
	db	16h, 28h, 0, 1Fh, 8Bh, 5Eh, 0ECh, 0A0h, 8, 0, 88h, 47h, 17h, 8Bh
	db	5Eh, 0ECh, 8Bh, 47h, 6, 8Bh, 57h, 4, 1, 16h, 38h, 0, 11h, 6, 3Ah
	db	0, 81h, 67h, 0Eh, 7Fh, 0FEh, 0FFh, 76h, 0ECh, 6Ah, 4, 0E8h, 0E3h
	db	3, 8Bh, 5Eh, 0ECh, 0F7h, 47h, 0Eh, 60h, 0, 74h, 1Ah, 8Eh, 6, 0Ch
	db	0, 26h, 0FFh, 6, 0DCh, 6, 8Bh, 5Eh, 0ECh, 8Bh, 47h, 6, 8Bh, 57h
	db	4, 1, 16h, 4Ah, 0, 11h, 6, 4Ch, 0, 8Bh, 5Eh, 0ECh, 0F7h, 47h, 0Eh
	db	0, 10h, 75h, 8, 0FFh, 76h, 0ECh, 6Ah, 1, 0E8h, 0FBh, 0DFh, 8Eh
	db	46h, 0FEh, 0E8h, 0C1h, 1Fh, 8Bh, 46h, 0EAh, 89h, 46h, 0ECh, 0C4h
	db	5Eh, 0FCh, 26h, 8Bh, 47h, 1Ch, 89h, 46h, 0FEh, 83h, 7Eh, 0FEh
	db	0, 74h, 3, 0E9h, 68h, 0FEh, 8Eh, 1Eh, 0Ch, 0, 8Bh, 46h, 0E4h, 0A3h
	db	0D8h, 6, 1Fh, 0C9h, 0CAh, 4, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 6, 1Eh
	db	2Eh, 8Eh, 1Eh, 0F1h, 48h, 0FFh, 76h, 4, 16h, 8Dh, 46h, 0FCh, 50h
	db	0E8h, 56h, 4, 89h, 46h, 0FAh, 0A1h, 0D8h, 6, 89h, 46h, 0FEh, 8Bh
	db	5Eh, 0FAh, 0D1h, 0E3h, 8Bh, 87h, 0DEh, 6, 0A3h, 0D8h, 6, 8Bh, 5Eh
	db	0FAh, 0D1h, 0E3h, 8Eh, 9Fh, 0DEh, 6, 0FFh, 76h, 0FCh, 0E8h, 5Bh
	db	0DFh, 0FFh, 76h, 0FCh, 0E8h, 0E2h, 0DEh, 0FFh, 76h, 0FCh, 6Ah
	db	0, 0E8h, 84h, 0DFh, 8Eh, 1Eh, 0Ch, 0, 8Bh, 46h, 0FEh, 0A3h, 0D8h
	db	6, 1Fh, 0C9h, 0C2h, 2, 0, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh
	db	0C3h, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 8Ah, 46h
	db	6, 0A2h, 0CCh, 6, 1Fh, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 1Eh, 0B8h
	db	87h, 0Bh, 8Eh, 0D8h, 0A0h, 0CCh, 6, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh
	db	56h, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0FCh, 8Dh, 16h, 0Eh, 7, 8Dh
	db	36h, 0EEh, 6, 0ADh, 3Dh, 0FFh, 0FFh, 74h, 9, 0B9h, 10h, 0, 0D1h
	db	0C8h, 73h, 0Ah, 0E2h, 0FAh, 3Bh, 0F2h, 72h, 0EDh, 0B0h, 0, 0EBh
	db	1Ah, 0Dh, 0, 80h, 8Bh, 0D9h, 49h, 0D3h, 0C8h, 89h, 44h, 0FEh, 81h
	db	0EEh, 0F0h, 6, 0B1h, 3, 0D3h, 0E6h, 8Bh, 0C6h, 5, 10h, 0, 2Bh
	db	0C3h, 1Fh, 5Eh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 87h, 0Bh
	db	8Eh, 0D8h, 8Ah, 46h, 6, 50h, 9Ah, 0FEh, 1Eh, 3Fh, 0, 8Ah, 5Eh
	db	6, 32h, 0FFh, 8Bh, 0CBh, 80h, 0E1h, 7, 0B0h, 0FEh, 0D2h, 0C0h
	db	0B1h, 3, 0D3h, 0EBh, 20h, 87h, 0EEh, 6, 1Fh, 5Dh, 0CAh, 2, 0, 55h
	db	8Bh, 0ECh, 83h, 0ECh, 4, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0C4h
	db	5Eh, 6, 26h, 0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 5Bh, 3
	db	89h, 46h, 0FCh, 8Bh, 5Eh, 0FCh, 0D1h, 0E3h, 8Eh, 9Fh, 0DEh, 6
	db	8Bh, 5Eh, 0FEh, 8Bh, 47h, 0Ch, 1Fh, 0C9h, 0CAh, 4, 0, 55h, 8Bh
	db	0ECh, 4Ch, 4Ch, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0C4h, 5Eh, 6, 26h
	db	0FFh, 37h, 16h, 8Dh, 46h, 0FEh, 50h, 0E8h, 2Bh, 3, 3Dh, 5, 0, 75h
	db	5, 0B8h, 1, 0, 0EBh, 2, 33h, 0C0h, 1Fh, 0C9h, 0CAh, 4, 0, 55h
	db	8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 1Eh, 0B8h
	db	87h, 0Bh, 8Eh, 0D8h, 0C6h, 6, 0CCh, 6, 0, 8Bh, 46h, 0Ch, 8Bh, 56h
	db	0Ah, 0A3h, 0C6h, 60h, 89h, 16h, 0C4h, 60h, 0C6h, 6, 1Ah, 7, 1
	db	90h, 'TX;', 0C4h, 75h, 32h, 0FEh, 6, 1Ah, 7, 1Eh, 0B8h, 6, 35h
	db	0CDh, 21h, 6, 53h, 0Eh, 1Fh, 0BAh, 36h, 2Fh, 0B8h, 6, 25h, 0CDh
	db	21h, 9Ch, 66h, 8Bh, 0C3h, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 0FEh, 6, 1Ah
	db	7, 83h, 0ECh, 6, 83h, 0C4h, 6, 9Dh, 5Ah, 1Fh, 0B8h, 6, 25h, 0CDh
	db	21h, 1Fh, 0C7h, 6, 0CEh, 6, 2, 10h, 0FFh, 76h, 12h, 0FFh, 76h
	db	10h, 68h, 0C6h, 9, 0FFh, 76h, 0Eh, 0E8h, 36h, 7, 0Bh, 0C0h, 74h
	db	5, 0B8h, 2, 10h, 0EBh, 34h, 0E8h, 0DDh, 0Eh, 8Bh, 46h, 6, 0Bh
	db	46h, 8, 74h, 0Fh, 6Ah, 2, 6Ah, 2, 6Ah, 0, 0FFh, 76h, 8, 0FFh, 76h
	db	6, 0E8h, 8Dh, 0Dh, 0FFh, 76h, 12h, 0FFh, 76h, 10h, 6Ah, 0, 6Ah
	db	0, 9Ah, 0FAh, 48h, 3Fh, 0, 0Bh, 0C0h, 74h, 5, 0B8h, 2, 10h, 0EBh
	db	2, 33h, 0C0h, 1Fh, 5Dh, 0CAh, 0Eh, 0, 55h, 8Bh, 0ECh, 1Eh, 0B8h
	db	87h, 0Bh, 8Eh, 0D8h, 83h, 3Eh, 0E2h, 6, 0, 74h, 5, 6Ah, 2, 0E8h
	db	4Ah, 0Eh, 83h, 3Eh, 0E4h, 6, 0, 74h, 5, 6Ah, 3, 0E8h, 3Eh, 0Eh
	db	83h, 3Eh, 0E6h, 6, 0, 74h, 3, 0E8h, 55h, 12h, 9Ah, 94h, 4Ah, 3Fh
	db	0, 0E8h, 0C9h, 16h, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 0B8h
	db	87h, 0Bh, 8Eh, 0D8h, 0A1h, 0CEh, 6, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh
	db	83h, 0ECh, 4, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 83h, 3Eh, 0E0h, 6
	db	0, 74h, 1Bh, 8Eh, 1Eh, 0E0h, 6, 0A1h, 1Eh, 0, 8Bh, 16h, 1Ch, 0
	db	3, 16h, 4Ah, 0, 13h, 6, 4Ch, 0, 89h, 46h, 0FEh, 89h, 56h, 0FCh
	db	0EBh, 0Ah, 0C7h, 46h, 0FEh, 0, 0, 0C7h, 46h, 0FCh, 0, 0, 2Eh, 8Eh
	db	1Eh, 0F1h, 48h, 8Eh, 1Eh, 0DEh, 6, 8Bh, 56h, 0FEh, 8Bh, 46h, 0FCh
	db	3, 6, 1Ch, 0, 13h, 16h, 1Eh, 0, 3, 6, 4Ah, 0, 13h, 16h, 4Ch, 0
	db	2Bh, 6, 3Ch, 0, 1Bh, 16h, 3Eh, 0, 1Fh, 0C9h, 0CBh
L03980:	push	bp	;@03980
	mov	bp, sp	;@03981
	sub	sp, 6	;@03983
	mov	word ptr [bp-2], 0	;@03986
	mov	word ptr [bp-4], 0FFh	;@0398B
	mov	ax, ds	;@03990
	cmp	ax, 0B87h	;@03992
	je	@@1	;@03995
	mov	al, byte ptr ds:[8]	;@03997
	mov	ah, 0	;@0399A
	mov	word ptr [bp-4], ax	;@0399C
	mov	ax, 0B87h	;@0399F
	mov	ds, ax	;@039A2
@@1:	mov	ax, word ptr ds:[6D8h]	;@039A4
	mov	word ptr [bp-6], ax	;@039A7
	mov	bx, word ptr [bp+4]	;@039AA
	shl	bx, 1	;@039AD
	cmp	word ptr [bx+6DEh], 0	;@039AF
	jne	@@2	;@039B4
	jmp	@@6	;@039B6
@@2:	cmp	word ptr [bp+4], 0	;@039B9
	je	@@3	;@039BD
	cmp	word ptr [bp+4], 1	;@039BF
	jne	@@4	;@039C3
@@3:	mov	bx, word ptr [bp+4]	;@039C5
	shl	bx, 1	;@039C8
	mov	ax, word ptr [bx+6DEh]	;@039CA
	mov	word ptr ds:[6D8h], ax	;@039CE
@@4:	mov	bx, word ptr [bp+4]	;@039D1
	shl	bx, 1	;@039D4
	mov	ds, word ptr [bx+6DEh]	;@039D6
	mov	bx, word ptr [bp+6]	;@039DA
	cmp	bx, 3	;@039DD
	ja	@@5	;@039E0
	shl	bx, 1	;@039E2
	jmp	word ptr cs:[bx+3105h]	;@039E4
	db	0FFh, 76h, 8, 0FFh, 16h, 26h, 0, 89h, 46h, 0FEh, 0EBh, 2Fh, 0FFh	;@039E9
	db	76h, 8, 0FFh, 16h, 28h, 0, 89h, 46h, 0FEh, 0EBh, 23h, 0FFh, 76h
	db	8, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 16h, 2Ch, 0, 0EBh, 0Fh
	db	0FFh, 76h, 8, 0FFh, 76h, 0Ch, 0FFh, 76h, 0Ah, 0FFh, 16h, 2Eh, 0
	db	0EBh, 0
@@5:	mov	word ptr [bp-2], 0	;@03A1F
@@6:	mov	ax, 0B87h	;@03A24
	mov	ds, ax	;@03A27
	mov	ax, word ptr [bp-6]	;@03A29
	mov	word ptr ds:[6D8h], ax	;@03A2C
	cmp	word ptr [bp-4], 0FFh	;@03A2F
	je	@@7	;@03A34
	mov	bx, word ptr [bp-4]	;@03A36
	shl	bx, 1	;@03A39
	mov	ds, word ptr [bx+6DEh]	;@03A3B
@@7:	mov	ax, word ptr [bp-2]	;@03A3F
	leave	;@03A42
	ret	;@03A43
	db	0, 0A9h, 30h, 0B5h, 30h, 0C1h, 30h, 0D0h, 30h	;@03A44
L03A4D:	push	bp	;@03A4D
	mov	bp, sp	;@03A4E
	sub	sp, 4	;@03A50
	push	si	;@03A53
	test	byte ptr [bp+4], 1	;@03A54
	je	@@1	;@03A58
	push	word ptr [bp+6]	;@03A5A
	call	L03D47	;@03A5D
	mov	word ptr [bp-2], ax	;@03A60
	jmp	short @@2	;@03A63
@@1:	mov	bx, word ptr [bp+6]	;@03A65
	les	bx, dword ptr [bx+12h]	;@03A68
	mov	ax, word ptr es:[bx]	;@03A6B
	mov	word ptr [bp-2], ax	;@03A6E
	mov	word ptr [bp-4], ax	;@03A71
	cmp	word ptr [bp-2], 1000h	;@03A74
	jae	@@3	;@03A79
	mov	ax, word ptr [bp-2]	;@03A7B
	shl	ax, 3	;@03A7E
	add	ax, 1007h	;@03A81
@@2:	mov	word ptr [bp-4], ax	;@03A84
@@3:	test	byte ptr [bp+4], 2	;@03A87
	je	@@5	;@03A8B
	mov	es, word ptr ds:[0Ch]	;@03A8D
	mov	es, word ptr es:[714h]	;@03A91
	mov	bx, word ptr [bp-4]	;@03A96
	and	bx, -8	;@03A99
	and	byte ptr es:[bx+5], 7Fh	;@03A9C
	mov	bx, word ptr [bp+6]	;@03AA1
	test	word ptr [bx+0Eh], 400h	;@03AA4
	je	@@4	;@03AA9
	jmp	@@8	;@03AAB
@@4:	mov	ax, word ptr [bp-4]	;@03AAE
	sub	ax, 1007h	;@03AB1
	shr	ax, 3	;@03AB4
	mov	word ptr [bp-2], ax	;@03AB7
	jmp	@@8	;@03ABA
@@5:	test	byte ptr [bp+4], 4	;@03ABD
	jne	@@6	;@03AC1
	jmp	@@8	;@03AC3
@@6:	mov	ax, word ptr [bp-4]	;@03AC6
	mov	word ptr [bp-2], ax	;@03AC9
	mov	es, word ptr ds:[0Ch]	;@03ACC
	mov	es, word ptr es:[714h]	;@03AD0
	mov	bx, word ptr [bp-4]	;@03AD5
	and	bx, -8	;@03AD8
	or	byte ptr es:[bx+5], 80h	;@03ADB
	push	si	;@03AE0
	mov	si, word ptr [bp+6]	;@03AE1
	mov	ax, word ptr [si]	;@03AE4
	mov	dx, word ptr [si+2]	;@03AE6
	mov	word ptr es:[bx+2], ax	;@03AE9
	mov	byte ptr es:[bx+4], dl	;@03AED
	mov	cx, word ptr [si+0Ch]	;@03AF1
	mov	al, 0F7h	;@03AF4
	jcxz	@@7	;@03AF6
	add	cx, 1	;@03AF8
	cmc	;@03AFB
	sbb	cx, 1	;@03AFC
	mov	al, 0FFh	;@03AFF
@@7:	and	byte ptr es:[bx+5], al	;@03B01
	mov	word ptr es:[bx], cx	;@03B05
	pop	si	;@03B08
@@8:	mov	bx, word ptr [bp+6]	;@03B09
	les	bx, dword ptr [bx+12h]	;@03B0C
	mov	ax, word ptr [bp-2]	;@03B0F
	mov	word ptr es:[bx], ax	;@03B12
	mov	es, word ptr ds:[0Ch]	;@03B15
	mov	es, word ptr es:[718h]	;@03B19
	mov	bx, word ptr [bp-4]	;@03B1E
	and	bx, -8	;@03B21
	mov	al, byte ptr ds:[8]	;@03B24
	xor	ah, ah	;@03B27
	or	ax, 8000h	;@03B29
	mov	word ptr es:[bx], ax	;@03B2C
	mov	ax, word ptr [bp+6]	;@03B2F
	mov	word ptr es:[bx+6], ax	;@03B32
	pop	si	;@03B36
	leave	;@03B37
	ret	4	;@03B38
L03B3B:	push	bp	;@03B3B
	mov	bp, sp	;@03B3C
	cmp	word ptr [bp+8], 1000h	;@03B3E
	jae	@@1	;@03B43
	mov	ax, word ptr [bp+8]	;@03B45
	shl	ax, 3	;@03B48
	add	ax, 1007h	;@03B4B
	mov	word ptr [bp+8], ax	;@03B4E
@@1:	mov	es, word ptr ds:[718h]	;@03B51
	mov	bx, word ptr [bp+8]	;@03B55
	and	bx, -8	;@03B58
	mov	cx, word ptr es:[bx+6]	;@03B5B
	mov	ax, word ptr es:[bx]	;@03B5F
	and	ax, 7	;@03B62
	les	bx, dword ptr [bp+4]	;@03B65
	mov	word ptr es:[bx], cx	;@03B68
	pop	bp	;@03B6B
	ret	6	;@03B6C
RESOLVE_HANDLE_FAR:	push	bp	;@03B6F
	mov	bp, sp	;@03B70
	push	ds	;@03B72
	mov	ax, 0B87h	;@03B73
	mov	ds, ax	;@03B76
	push	word ptr [bp+0Ah]	;@03B78
	push	word ptr [bp+8]	;@03B7B
	push	word ptr [bp+6]	;@03B7E
	call	L03B3B	;@03B81
	pop	ds	;@03B84
	pop	bp	;@03B85
	retf	6	;@03B86
HANDLE_ITEM_POINTER:	push	bp	;@03B89
	mov	bp, sp	;@03B8A
	sub	sp, 4	;@03B8C
	push	ds	;@03B8F
	mov	ax, 0B87h	;@03B90
	mov	ds, ax	;@03B93
	push	word ptr [bp+6]	;@03B95
	push	ss	;@03B98
	lea	ax, [bp-2]	;@03B99
	push	ax	;@03B9C
	call	L03B3B	;@03B9D
	mov	word ptr [bp-4], ax	;@03BA0
	mov	bx, word ptr [bp-4]	;@03BA3
	shl	bx, 1	;@03BA6
	mov	ds, word ptr [bx+6DEh]	;@03BA8
	mov	bx, word ptr [bp-2]	;@03BAC
	mov	dx, word ptr [bx+14h]	;@03BAF
	mov	ax, word ptr [bx+12h]	;@03BB2
	pop	ds	;@03BB5
	leave	;@03BB6
	retf	2	;@03BB7
	db	55h, 8Bh, 0ECh, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 33h, 0C0h, 1Fh	;@03BBA
	db	5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h
	db	1Fh, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 8Bh, 1Eh, 14h
	db	0, 8Bh, 47h, 14h, 89h, 46h, 0FEh, 3Bh, 6, 14h, 0, 75h, 4, 33h
	db	0C0h, 0EBh, 38h, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 14h, 3Bh, 6, 14h, 0
	db	75h, 1Bh, 8Bh, 47h, 6, 8Bh, 57h, 4, 3Bh, 46h, 6, 72h, 0Ch, 75h
	db	5, 3Bh, 56h, 4, 72h, 5, 8Bh, 46h, 0FEh, 0EBh, 15h, 33h, 0C0h, 0EBh
	db	11h, 0FFh, 76h, 6, 0FFh, 76h, 4, 0FFh, 36h, 16h, 0, 0FFh, 36h
	db	18h, 0, 0E8h, 46h, 0DDh, 0C9h, 0C2h, 4, 0
L03C2D:	push	bp	;@03C2D
	mov	bp, sp	;@03C2E
	mov	ax, word ptr [bp+4]	;@03C30
	xor	dx, dx	;@03C33
	add	ax, 0FFFFh	;@03C35
	cmc	;@03C38
	adc	ax, 1	;@03C39
	mov	bx, word ptr ds:[0Ah]	;@03C3C
	add	ax, bx	;@03C40
	adc	dx, 0	;@03C42
	not	bx	;@03C45
	and	ax, bx	;@03C47
	pop	bp	;@03C49
	ret	2	;@03C4A
	db	55h, 8Bh, 0ECh, 8Bh, 0Eh, 0E0h, 6, 0E3h, 8, 8Eh, 0C1h, 26h, 80h	;@03C4D
	db	36h, 9, 0, 8, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh
	db	0C3h, 55h, 8Bh, 0ECh, 5Dh, 0C3h
L03C6D:	push	bp	;@03C6D
	mov	bp, sp	;@03C6E
	mov	bx, word ptr [bp+4]	;@03C70
	mov	cx, word ptr [bx+0Ch]	;@03C73
	les	bx, dword ptr [bx+12h]	;@03C76
	mov	bx, word ptr es:[bx]	;@03C79
	mov	dl, 0F7h	;@03C7C
	jcxz	@@1	;@03C7E
	mov	dl, 0FFh	;@03C80
	add	cx, 1	;@03C82
	cmc	;@03C85
	sbb	cx, 1	;@03C86
@@1:	cmp	bx, 1000h	;@03C89
	jae	@@2	;@03C8D
	shl	bx, 3	;@03C8F
	add	bx, 1007h	;@03C92
@@2:	and	bx, -8	;@03C96
	push	ds	;@03C99
	mov	ds, word ptr ds:[0Ch]	;@03C9A
	mov	es, word ptr ds:[714h]	;@03C9E
	and	byte ptr es:[bx+5], dl	;@03CA2
	mov	word ptr es:[bx], cx	;@03CA6
	pop	ds	;@03CA9
	pop	bp	;@03CAA
	ret	2	;@03CAB
	db	55h, 8Bh, 0ECh, 2Eh, 8Eh, 6, 0F1h, 48h, 26h, 8Eh, 6, 14h, 7, 83h	;@03CAE
	db	0E3h, 0F8h, 26h, 80h, 77h, 5, 8, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 1Eh
	db	0B9h, 87h, 0Bh, 8Eh, 0D9h, 8Eh, 6, 14h, 7, 8Bh, 0CBh, 83h, 0E3h
	db	0F8h, 26h, 89h, 47h, 2, 26h, 88h, 57h, 4, 8Bh, 0D9h, 1Fh, 5Dh
	db	0C3h, 55h, 8Bh, 0ECh, 1Eh, 0B9h, 87h, 0Bh, 8Eh, 0D9h, 8Eh, 6, 14h
	db	7, 8Bh, 0CBh, 83h, 0E3h, 0F8h, 33h, 0D2h, 26h, 8Bh, 47h, 2, 26h
	db	8Ah, 57h, 4, 8Bh, 0D9h, 1Fh, 5Dh, 0C3h
L03D05:	push	bp	;@03D05
	mov	bp, sp	;@03D06
	mov	bx, 0B87h	;@03D08
	mov	es, bx	;@03D0B
	mov	bx, word ptr es:[70Eh]	;@03D0D
	push	bx	;@03D12
	mov	es, word ptr es:[714h]	;@03D13
	and	bx, -8	;@03D18
	mov	word ptr es:[bx+2], ax	;@03D1B
	mov	byte ptr es:[bx+4], dl	;@03D1F
	pop	ax	;@03D23
	pop	bp	;@03D24
	ret	;@03D25
	db	55h, 8Bh, 0ECh, 0BBh, 87h, 0Bh, 8Eh, 0C3h, 26h, 8Bh, 1Eh, 10h	;@03D26
	db	7, 53h, 26h, 8Eh, 6, 14h, 7, 83h, 0E3h, 0F8h, 26h, 89h, 47h, 2
	db	26h, 88h, 57h, 4, 58h, 5Dh, 0C3h
L03D47:	push	bp	;@03D47
	mov	bp, sp	;@03D48
	push	si	;@03D4A
	push	ds	;@03D4B
	mov	ds, word ptr ds:[0Ch]	;@03D4C
	mov	bx, word ptr ds:[60BCh]	;@03D50
	or	bx, bx	;@03D54
	jne	@@1	;@03D56
	int	3	;@03D58
	int	0	;@03D59
@@1:	dec	word ptr ds:[60C0h]	;@03D5B
	mov	es, word ptr ds:[714h]	;@03D5F
	mov	ax, word ptr es:[bx+2]	;@03D63
	mov	word ptr ds:[60BCh], ax	;@03D67
	pop	ds	;@03D6A
	push	si	;@03D6B
	mov	si, word ptr [bp+4]	;@03D6C
	mov	ax, word ptr [si]	;@03D6F
	mov	dx, word ptr [si+2]	;@03D71
	mov	word ptr es:[bx+6], 0	;@03D74
	mov	word ptr es:[bx+2], ax	;@03D7A
	mov	byte ptr es:[bx+4], dl	;@03D7E
	mov	cx, word ptr [si+0Ch]	;@03D82
	mov	al, 0F7h	;@03D85
	jcxz	@@2	;@03D87
	add	cx, 1	;@03D89
	cmc	;@03D8C
	sbb	cx, 1	;@03D8D
	mov	al, 0FFh	;@03D90
@@2:	mov	byte ptr es:[bx+5], al	;@03D92
	mov	word ptr es:[bx], cx	;@03D96
	mov	al, 0F2h	;@03D99
	test	word ptr [si+0Eh], 200h	;@03D9B
	je	@@3	;@03DA0
	mov	al, 0FAh	;@03DA2
@@3:	and	byte ptr es:[bx+5], al	;@03DA4
	pop	si	;@03DA8
	mov	ax, bx	;@03DA9
	or	ax, 7	;@03DAB
	pop	si	;@03DAE
	pop	bp	;@03DAF
	ret	2	;@03DB0
L03DB3:	push	bp	;@03DB3
	mov	bp, sp	;@03DB4
	mov	bx, word ptr [bp+4]	;@03DB6
	cmp	bx, 1000h	;@03DB9
	jae	@@1	;@03DBD
	shl	bx, 3	;@03DBF
	add	bx, 1007h	;@03DC2
@@1:	push	ds	;@03DC6
	mov	ds, word ptr ds:[0Ch]	;@03DC7
	inc	word ptr ds:[60C0h]	;@03DCB
	mov	es, word ptr ds:[714h]	;@03DCF
	and	bx, -8	;@03DD3
	mov	ax, word ptr ds:[60BCh]	;@03DD6
	mov	word ptr es:[bx+2], ax	;@03DD9
	mov	word ptr ds:[60BCh], bx	;@03DDD
	pop	ds	;@03DE1
	pop	bp	;@03DE2
	ret	2	;@03DE3
	db	55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 8Bh, 7Eh, 8, 8Bh, 4Dh, 0Ch, 0C4h	;@03DE6
	db	75h, 12h, 26h, 0FFh, 34h, 0F7h, 45h, 0Eh, 0, 8, 74h, 0Ch, 8Bh
	db	5, 8Bh, 55h, 2, 0E8h, 1Fh, 0FFh, 8Eh, 0D8h, 0EBh, 3, 26h, 8Eh
	db	1Ch, 0E3h, 29h, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 0ECh, 0FEh, 8Eh
	db	0C0h, 33h, 0F6h, 33h, 0FFh, 0FCh, 83h, 0C1h, 1, 49h, 83h, 0D1h
	db	0, 0D1h, 0D9h, 0EBh, 9, 9Ch, 0D1h, 0E9h, 0F3h, 66h, 0A5h, 0D1h
	db	0D1h, 9Dh, 0F3h, 0A5h, 73h, 1, 0A4h, 5Bh, 81h, 0FBh, 0, 10h, 73h
	db	7, 0C1h, 0E3h, 3, 81h, 0C3h, 7, 10h, 8Bh, 46h, 4, 8Bh, 56h, 6
	db	0E8h, 75h, 0FEh, 1Fh, 8Bh, 7Eh, 8, 89h, 5, 89h, 55h, 2, 80h, 3Eh
	db	8, 0, 1, 74h, 1Eh, 8Bh, 5Eh, 8, 3Bh, 1Eh, 44h, 0, 75h, 15h, 0B9h
	db	5, 0, 8Ch, 0DBh, 83h, 0C3h, 8, 5, 50h, 0, 80h, 0D2h, 0, 51h, 0E8h
	db	4Ah, 0FEh, 59h, 0E2h, 0F0h, '_^]', 0C2h, 6, 0, 55h, 8Bh, 0ECh
	db	56h, 57h, 1Eh, 8Bh, 7Eh, 8, 8Bh, 4Dh, 0Ch, 0C4h, 75h, 12h, 26h
	db	0FFh, 34h, 0F7h, 45h, 0Eh, 0, 8, 74h, 0Ch, 8Bh, 5, 8Bh, 55h, 2
	db	0E8h, 81h, 0FEh, 8Eh, 0D8h, 0EBh, 3, 26h, 8Eh, 1Ch, 0E3h, 35h
	db	8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 4Eh, 0FEh, 8Eh, 0C0h, 83h, 0C1h
	db	1, 49h, 83h, 0D1h, 0, 8Bh, 0F1h, 4Eh, 8Bh, 0FEh, 0FDh, 0D1h, 0D9h
	db	73h, 1, 0A4h, 4Eh, 0EBh, 10h, 0D1h, 0E9h, 73h, 3, 8Bh, 0FEh, 0A5h
	db	4Eh, 4Eh, 8Bh, 0FEh, 0F3h, 66h, 0A5h, 0EBh, 4, 8Bh, 0FEh, 0F3h
	db	0A5h, 0FCh, 5Bh, 81h, 0FBh, 0, 10h, 73h, 7, 0C1h, 0E3h, 3, 81h
	db	0C3h, 7, 10h, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 0CBh, 0FDh, 1Fh
	db	8Bh, 7Eh, 8, 89h, 5, 89h, 55h, 2, 80h, 3Eh, 8, 0, 1, 74h, 1Eh
	db	8Bh, 5Eh, 8, 3Bh, 1Eh, 44h, 0, 75h, 15h, 0B9h, 5, 0, 8Ch, 0DBh
	db	83h, 0C3h, 8, 5, 50h, 0, 80h, 0D2h, 0, 51h, 0E8h, 0A0h, 0FDh, 59h
	db	0E2h, 0F0h, '_^]', 0C2h, 6, 0, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 8Bh
	db	7Eh, 8, 8Bh, 4Dh, 0Ch, 0E3h, 42h, 0C4h, 75h, 12h, 0F7h, 45h, 0Eh
	db	0, 8, 74h, 0Ch, 8Bh, 5, 8Bh, 55h, 2, 0E8h, 0D8h, 0FDh, 8Eh, 0D8h
	db	0EBh, 3, 26h, 8Eh, 1Ch, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 0A7h, 0FDh
	db	8Eh, 0C0h, 33h, 0F6h, 33h, 0FFh, 0FCh, 83h, 0C1h, 1, 49h, 83h
	db	0D1h, 0, 0D1h, 0D9h, 0EBh, 9, 9Ch, 0D1h, 0E9h, 0F3h, 66h, 0A5h
	db	0D1h, 0D1h, 9Dh, 0F3h, 0A5h, 73h, 1, 0A4h, 1Fh, '_^]', 0C2h, 6
	db	0, 55h, 8Bh, 0ECh, 56h, 57h, 1Eh, 8Bh, 7Eh, 8, 8Bh, 4Dh, 0Ch, 0E3h
	db	33h, 8Bh, 5, 8Bh, 55h, 2, 0E8h, 6Ah, 0FDh, 50h, 8Bh, 46h, 4, 8Bh
	db	56h, 6, 0E8h, 81h, 0FDh, 8Eh, 0D8h, 7, 33h, 0F6h, 33h, 0FFh, 0FCh
	db	83h, 0C1h, 1, 49h, 83h, 0D1h, 0, 0D1h, 0D9h, 0EBh, 9, 9Ch, 0D1h
	db	0E9h, 0F3h, 66h, 0A5h, 0D1h, 0D1h, 9Dh, 0F3h, 0A5h, 73h, 1, 0A4h
	db	1Fh, '_^]', 0C2h, 6, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4, 56h, 57h
	db	8Bh, 46h, 6, 0BAh, 1Ah, 0, 0F7h, 0EAh, 5, 0E0h, 1, 89h, 46h, 0FCh
	db	8Bh, 5Eh, 0Ah, 0B4h, 0EDh, 0CDh, 21h, 0Bh, 0C9h, 75h, 6, 0B8h
	db	0, 10h, 0E9h, 0B8h, 2, 8Ch, 0CBh, 0B4h, 0EDh, 0CDh, 21h, 1Eh, 8Ch
	db	0C8h, 8Eh, 0D8h, 33h, 0F6h, 8Bh, 0DEh, 0B8h, 1, 0E8h, 0CDh, 21h
	db	1Fh, 73h, 6, 0B8h, 2, 10h, 0E9h, 9Bh, 2, 8Bh, 0D8h, 0B8h, 2, 0E9h
	db	0CDh, 21h, 8Eh, 0C3h, 26h, 89h, 1Eh, 0A8h, 45h, 80h, 3Eh, 1Ah
	db	7, 3, 75h, 18h, 0B8h, 90h, 90h, 2Eh, 8Eh, 6, 0A8h, 45h, 26h, 0A3h
	db	0E9h, 34h, 26h, 0A3h, 8Ch, 35h, 26h, 0A3h, '.6&', 0A3h, 76h, 36h
	db	1Eh, 1Eh, 1Eh, 0B8h, 3, 0E5h, 0CDh, 21h, 1Fh, 0A3h, 14h, 7, 89h
	db	1Eh, 18h, 7, 0C1h, 0E1h, 3, 81h, 0C1h, 80h, 0, 81h, 0F9h, 0, 10h
	db	73h, 3, 0B9h, 0, 10h, 89h, 0Eh, 0C2h, 60h, 8Bh, 0F9h, 83h, 0CFh
	db	7, 89h, 3Eh, 0Eh, 7, 83h, 0C7h, 8, 89h, 3Eh, 10h, 7, 83h, 0C1h
	db	60h, 89h, 0Eh, 0BCh, 60h, 0C1h, 0E2h, 3, 0BAh, 0, 70h, 89h, 16h
	db	0BEh, 60h, 8Eh, 0D8h, 8Bh, 0F9h, 8Dh, 45h, 8, 89h, 45h, 2, 8Bh
	db	0F8h, 3Bh, 0FAh, 72h, 0F4h, 0C7h, 45h, 0FAh, 0, 0, 8Eh, 0DBh, 8Bh
	db	0F9h, 83h, 0EFh, 60h, 0C7h, 5, 0, 80h, 83h, 0C7h, 8, 3Bh, 0FAh
	db	72h, 0F5h, 1Fh, 2Bh, 0D1h, 0C1h, 0EAh, 3, 89h, 16h, 0C0h, 60h
	db	0A1h, 0Eh, 7, 25h, 0F8h, 0FFh, 0A3h, 12h, 7, 0C4h, 1Eh, 12h, 7
	db	26h, 0C7h, 7, 0FFh, 0FFh, 26h, 0C6h, 47h, 5, 0F2h, 26h, 0C7h, 47h
	db	6, 0, 0, 0A1h, 10h, 7, 25h, 0F8h, 0FFh, 0A3h, 12h, 7, 0C4h, 1Eh
	db	12h, 7, 26h, 0C7h, 7, 0FFh, 0FFh, 26h, 0C6h, 47h, 5, 0F2h, 26h
	db	0C7h, 47h, 6, 0, 0, 0C7h, 6, 12h, 7, 0, 0, 0B8h, 0, 70h, 0A3h
	db	16h, 7, 0A3h, 12h, 7, 0EBh, 32h, 0C4h, 1Eh, 12h, 7, 26h, 0C7h
	db	7, 0, 0, 26h, 0C6h, 47h, 5, 0F2h, 26h, 0C7h, 47h, 2, 0FFh, 0FFh
	db	26h, 0C6h, 47h, 4, 0FFh, 26h, 0C7h, 47h, 6, 0, 0, 0C4h, 1Eh, 16h
	db	7, 26h, 81h, 0Fh, 0, 80h, 83h, 6, 12h, 7, 8, 83h, 6, 16h, 7, 8
	db	81h, 3Eh, 12h, 7, 0, 80h, 72h, 0C6h, 0C7h, 6, 12h, 7, 0, 0, 0C7h
	db	6, 16h, 7, 0, 0, 8Bh, 5Eh, 0Ah, 0B4h, 0EDh, 0CDh, '!VSQRj', 0
	db	6Ah, 3, 8Bh, 0D6h, 8Bh, 0C3h, 8Bh, 1Eh, 0Eh, 7, 83h, 0C3h, 30h
	db	0B9h, 6, 0, 89h, 1Eh, 0DEh, 6, 8Eh, 6, 14h, 7, 83h, 0E3h, 0F8h
	db	26h, 0C7h, 47h, 6, 0, 0, 26h, 89h, 47h, 2, 26h, 88h, 57h, 4, 26h
	db	0C7h, 7, 0FFh, 0FFh, 26h, 0C6h, 47h, 5, 0F2h, 83h, 0C3h, 8, 5
	db	50h, 0, 80h, 0D2h, 0, 0E2h, 0DDh, 0A1h, 0DEh, 6, 0A3h, 0DAh, 6
	db	0A3h, 0D8h, 6, 8Eh, 6, 0DEh, 6, 33h, 0FFh, 8Bh, 0C7h, 8Bh, 4Eh
	db	0FCh, 0D1h, 0E9h, 0FCh, 0F3h, 0ABh, 8Eh, 1Eh, 0DEh, 6, 0B8h, 0E0h
	db	1, 89h, 46h, 0FEh, 0A3h, 46h, 0, 0EBh, 10h, 8Bh, 46h, 0FEh, 5
	db	1Ah, 0, 8Bh, 5Eh, 0FEh, 89h, 47h, 14h, 83h, 46h, 0FEh, 1Ah, 8Bh
	db	46h, 0FEh, 3Bh, 46h, 0FCh, 72h, 0E8h, 83h, 6Eh, 0FEh, 1Ah, 8Bh
	db	5Eh, 0FEh, 0C7h, 47h, 14h, 0, 0, 8Bh, 46h, 6, 0A3h, 48h, 0, 0E8h
	db	7, 0E1h, 0E8h, 0EDh, 0Dh, 0A0h, 9, 0, 0Ch, 6, 0A2h, 9, 0, 0FFh
	db	76h, 0FCh, 0E8h, 0, 0DAh, 89h, 46h, 0FEh, 0A3h, 44h, 0, 8Bh, 5Eh
	db	0FEh, 0C7h, 47h, 12h, 0DEh, 6, 0C7h, 47h, 14h, 87h, 0Bh, 8Bh, 5Eh
	db	0FEh, 81h, 4Fh, 0Eh, 0, 80h, 0FFh, 76h, 0FEh, 6Ah, 0, 0E8h, 34h
	db	0F8h, 0C7h, 6, 2Ch, 0, 45h, 36h, 0C7h, 6, 2Eh, 0, 0EEh, 35h, 0C7h
	db	6, 30h, 0, 0A6h, 34h, 0C7h, 6, 32h, 0, 44h, 35h, 0C7h, 6, 2Ah
	db	0, 98h, 32h, 83h, 7Eh, 4, 20h, 73h, 5, 0B8h, 20h, 0, 0EBh, 6, 8Bh
	db	46h, 4, 25h, 0FCh, 0FFh, 0A3h, 36h, 0, 0E8h, 8Dh, 0CAh, 0A3h, 34h
	db	0, 8Eh, 1Eh, 0Ch, 0, 8Bh, 5Eh, 8, 0Bh, 0DBh, 74h, 4Dh, 0B4h, 0EDh
	db	0CDh, 21h, 0E3h, 'GVSQRj', 1, 6Ah, 3, 0E8h, 7Fh, 0E0h, 0A0h, 9
	db	0, 0Ch, 6, 0A2h, 9, 0, 0C7h, 6, 2Ch, 0, 45h, 36h, 0C7h, 6, 2Eh
	db	0, 0EEh, 35h, 0C7h, 6, 30h, 0, 0A6h, 34h, 0C7h, 6, 32h, 0, 44h
	db	35h, 0C7h, 6, 2Ah, 0, 98h, 32h, 8Eh, 1Eh, 0Ch, 0, 0A1h, 0E0h, 6
	db	0A3h, 0DAh, 6, 8Eh, 1Eh, 0DEh, 6, 0A0h, 9, 0, 34h, 2, 0A2h, 9
	db	0, 1Fh, 33h, 0C0h, 5Fh, 5Eh, 0C9h, 0C2h, 8, 0
L042B2:	push	bp	;@042B2
	mov	bp, sp	;@042B3
	push	di	;@042B5
	push	ds	;@042B6
	mov	ds, word ptr cs:L0532F+2	;@042B7
	mov	dx, 3Fh	;@042BC
	mov	ax, cs	;@042BF
	cmp	ax, dx	;@042C1
	je	@@2	;@042C3
	xor	dl, 8	;@042C5
	mov	es, dx	;@042C8
	mov	es, word ptr es:[1Eh]	;@042CA
	mov	di, 23h	;@042CF
	mov	ax, word ptr es:[0Eh]	;@042D2
	mov	cx, word ptr es:[0Ch]	;@042D6
	mov	word ptr es:[10h], ax	;@042DB
	cld	;@042DF
@@1:	stosw	;@042E0
	add	di, 3	;@042E1
	loop	@@1	;@042E4
	mov	es, word ptr ds:[714h]	;@042E6
	mov	bx, cs	;@042EA
	and	bx, -8	;@042EC
	mov	cx, word ptr es:[bx+2]	;@042EF
	mov	dl, byte ptr es:[bx+4]	;@042F3
	mov	bx, ax	;@042F7
	and	bx, -8	;@042F9
	mov	word ptr es:[bx+2], cx	;@042FC
	mov	byte ptr es:[bx+4], dl	;@04300
	or	byte ptr es:[bx+5], 80h	;@04304
@@2:	pop	ds	;@04309
	pop	di	;@0430A
	pop	bp	;@0430B
	ret	;@0430C
	db	55h, 8Bh, 0ECh, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 1Fh, 5Dh, 0CAh	;@0430D
	db	6, 0, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h
L04323:	push	bp	;@04323
	mov	bp, sp	;@04324
	dec	sp	;@04326
	dec	sp	;@04327
	mov	al, byte ptr ds:[8]	;@04328
	mov	ah, 0	;@0432B
	mov	word ptr [bp-2], ax	;@0432D
	push	ds	;@04330
	mov	ds, word ptr cs:L0532F+2	;@04331
	cmp	word ptr ds:[6CAh], 0	;@04336
	jne	@@1	;@0433B
	inc	word ptr ds:[6CAh]	;@0433D
	pop	ds	;@04341
	push	ds	;@04342
	push	2	;@04343
	push	0	;@04345
	call	L0436F	;@04347
	or	ax, ax	;@0434A
	je	@@1	;@0434C
	mov	ds, word ptr cs:L0532F+2	;@0434E
	push	word ptr [bp-2]	;@04353
	call	L04738	;@04356
	mov	bx, word ptr [bp-2]	;@04359
	shl	bx, 1	;@0435C
	mov	word ptr [bx+6DEh], 0	;@0435E
	pop	ds	;@04364
	mov	ax, 1003h	;@04365
	jmp	short @@2	;@04368
@@1:	pop	ds	;@0436A
	xor	ax, ax	;@0436B
@@2:	leave	;@0436D
	ret	;@0436E
L0436F:	push	bp	;@0436F
	mov	bp, sp	;@04370
	sub	sp, 4	;@04372
	call	L04323	;@04375
	mov	ax, 0	;@04378
	mov	dx, 4	;@0437B
	call	L03D05	;@0437E
	mov	word ptr [bp-2], ax	;@04381
	push	word ptr ds:[34h]	;@04384
	push	0	;@04388
	push	0	;@0438A
	push	2	;@0438C
	call	RH_DOS_SEEK	;@0438E
	cmp	dx, -1	;@04391
	jne	@@6	;@04394
	cmp	ax, 0FFFFh	;@04396
	je	@@7	;@04399
	jmp	short @@6	;@0439B
@@1:	cmp	word ptr [bp+6], 0	;@0439D
	jb	@@3	;@043A1
	ja	@@2	;@043A3
	cmp	word ptr [bp+4], 8000h	;@043A5
	jbe	@@3	;@043AA
@@2:	mov	word ptr [bp-4], 8000h	;@043AC
	jmp	short @@4	;@043B1
@@3:	mov	ax, word ptr [bp+4]	;@043B3
	mov	word ptr [bp-4], ax	;@043B6
@@4:	push	word ptr ds:[34h]	;@043B9
	push	word ptr [bp-2]	;@043BD
	push	0	;@043C0
	push	word ptr [bp-4]	;@043C2
	call	RH_DOS_WRITE	;@043C5
	cmp	ax, word ptr [bp-4]	;@043C8
	je	@@5	;@043CB
	jmp	short @@10	;@043CD
@@5:	mov	ax, word ptr [bp-4]	;@043CF
	sub	word ptr [bp+4], ax	;@043D2
	sbb	word ptr [bp+6], 0	;@043D5
@@6:	mov	ax, word ptr [bp+4]	;@043D9
	or	ax, word ptr [bp+6]	;@043DC
	jne	@@1	;@043DF
	push	word ptr ds:[34h]	;@043E1
	call	RH_DOS_DUP	;@043E5
	or	ax, ax	;@043E8
	jbe	@@8	;@043EA
	push	ax	;@043EC
	call	RH_DOS_CLOSE	;@043ED
	jmp	short @@9	;@043F0
@@7:	jmp	short @@10	;@043F2
@@8:	jmp	short @@10	;@043F4
@@9:	xor	ax, ax	;@043F6
	jmp	short @@11	;@043F8
	db	1Fh	;@043FA
@@10:	mov	ax, 1003h	;@043FB
@@11:	leave	;@043FE
	ret	4	;@043FF
	db	55h, 8Bh, 0ECh, 0E8h, 1Bh, 0FFh, 8Bh, 5Eh, 8, 83h, 7Fh, 0Ch, 0	;@04402
	db	75h, 3, 0EBh, 5Eh, 90h, 0FFh, 36h, 34h, 0, 0FFh, 77h, 2, 0FFh
	db	37h, 6Ah, 0, 0E8h, 0C1h, 0Dh, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 0DAh
	db	0F8h, 0FFh, 36h, 34h, 0, 50h, 8Bh, 5Eh, 8, 8Bh, 4Fh, 0Ch, 83h
	db	0F9h, 0F0h, 76h, 1Ah, 0BAh, 0F0h, 0FFh, 52h, 2Bh, 0CAh, 51h, 0FFh
	db	36h, 34h, 0, 50h, 33h, 0C9h, 51h, 52h, 0E8h, 61h, 0Dh, 73h, 9
	db	83h, 0C4h, 8, 0EBh, 9, 33h, 0C0h, 50h, 51h, 0E8h, 53h, 0Dh, 73h
	db	13h, 1Eh, 0B8h, 1, 0, 50h, 0B8h, 0, 0E0h, 50h, 2Eh, 8Eh, 1Eh, 0F1h
	db	48h, 0FFh, 1Eh, 0C4h, 60h, 1Fh, 5Dh, 0C2h, 6, 0, 55h, 8Bh, 0ECh
	db	0E8h, 0A8h, 0FEh, 8Bh, 5Eh, 8, 83h, 7Fh, 0Ch, 0, 75h, 3, 0EBh
	db	5Eh, 90h, 0FFh, 36h, 34h, 0, 0FFh, 77h, 2, 0FFh, 37h, 6Ah, 0, 0E8h
	db	4Eh, 0Dh, 8Bh, 46h, 4, 8Bh, 56h, 6, 0E8h, 67h, 0F8h, 0FFh, 36h
	db	34h, 0, 50h, 8Bh, 5Eh, 8, 8Bh, 4Fh, 0Ch, 83h, 0F9h, 0F0h, 76h
	db	1Ah, 0BAh, 0F0h, 0FFh, 52h, 2Bh, 0CAh, 51h, 0FFh, 36h, 34h, 0
	db	50h, 33h, 0C9h, 51h, 52h, 0E8h, 8, 0Dh, 73h, 9, 83h, 0C4h, 8, 0EBh
	db	9, 33h, 0C0h, 50h, 51h, 0E8h, 0FAh, 0Ch, 73h, 13h, 1Eh, 0B8h, 1
	db	0, 50h, 0B8h, 1, 0E0h, 50h, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 0FFh, 1Eh
	db	0C4h, 60h, 1Fh, 5Dh, 0C2h, 6, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 4
	db	0E8h, 32h, 0FEh, 8Eh, 6, 0Ch, 0, 26h, 8Eh, 6, 0DEh, 6, 26h, 0A1h
	db	0, 0, 89h, 46h, 0FCh, 26h, 0A1h, 2, 0, 89h, 46h, 0FEh, 0FFh, 76h
	db	8, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh, 0E8h, 0EEh, 0FEh, 8Bh, 5Eh
	db	8, 8Bh, 46h, 6, 8Bh, 56h, 4, 89h, 47h, 2, 89h, 17h, 0FFh, 76h
	db	8, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh, 0E8h, 47h, 0FFh, 0C9h, 0C2h
	db	6, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ch, 0C7h, 46h, 0F8h, 0, 0, 0C7h
	db	46h, 0F6h, 0, 0, 0A0h, 8, 0, 0B4h, 0, 89h, 46h, 0F4h, 0E8h, 0D6h
	db	0FDh, 0B8h, 87h, 0Bh, 8Eh, 0C0h, 26h, 80h, 3Eh, 1Bh, 7, 0, 't-j'
	db	1, 6Ah, 0, 0E8h, 0Eh, 0FEh, 0Bh, 0C0h, 'u"j', 1, 6Ah, 0, 0E8h
	db	0EFh, 0DCh, 89h, 46h, 0FEh, 8Bh, 5Eh, 0FEh, 8Bh, 47h, 6, 8Bh, 57h
	db	4, 3Bh, 46h, 6, 72h, 0Ah, 75h, 5, 3Bh, 56h, 4, 72h, 3, 0E9h, 0B9h
	db	0, 0B8h, 87h, 0Bh, 8Eh, 0C0h, 26h, 80h, 3Eh, 1Ch, 7, 0, 75h, 5
	db	33h, 0C0h, 0E9h, 0AAh, 0, 8Bh, 1Eh, 14h, 0, 8Bh, 47h, 14h, 89h
	db	46h, 0FEh, 3Bh, 6, 14h, 0, 75h, 5, 33h, 0C0h, 0E9h, 95h, 0, 8Bh
	db	5Eh, 0FEh, 8Bh, 47h, 14h, 3Bh, 6, 14h, 0, 75h, 18h, 8Bh, 47h, 6
	db	8Bh, 57h, 4, 3Bh, 46h, 6, 72h, 9, 75h, 5, 3Bh, 56h, 4, 72h, 2
	db	0EBh, 72h, 33h, 0C0h, 0EBh, 71h, 8Eh, 1Eh, 0Ch, 0, 83h, 3Eh, 0E0h
	db	6, 0, 75h, 4, 33h, 0C0h, 0EBh, 62h, 8Eh, 1Eh, 0E0h, 6, 83h, 3Eh
	db	6, 0, 1, 77h, 0Dh, 72h, 7, 83h, 3Eh, 4, 0, 0, 73h, 4, 33h, 0C0h
	db	0EBh, 4Ah, 0A1h, 2, 0, 8Bh, 16h, 0, 0, 89h, 46h, 0FCh, 89h, 56h
	db	0FAh, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 8Bh, 5Eh, 0F4h, 0D1h, 0E3h, 8Eh
	db	9Fh, 0DEh, 6, 0FFh, 36h, 36h, 0, 0FFh, 76h, 0FCh, 0FFh, 76h, 0FAh
	db	0E8h, 54h, 0FEh, 6Ah, 0FFh, 6Ah, 0FFh, 0FFh, 36h, 16h, 0, 0FFh
	db	36h, 18h, 0, 0E8h, 3Fh, 0D3h, 89h, 46h, 0FEh, 0FFh, 36h, 36h, 0
	db	0FFh, 76h, 0FCh, 0FFh, 76h, 0FAh, 0E8h, 0C2h, 0FDh, 8Bh, 46h, 0FEh
	db	0C9h, 0C2h, 4, 0
INIT_SWAP_BANK:	push	bp	;@04647
	mov	bp, sp	;@04648
	sub	sp, 4	;@0464A
	cmp	word ptr [bp+0Ah], 2	;@0464D
	ja	@@2	;@04651
	jb	@@1	;@04653
	cmp	word ptr [bp+8], 0	;@04655
	jae	@@2	;@04659
@@1:	jmp	@@4	;@0465B
@@2:	mov	ax, word ptr [bp+4]	;@0465E
	mov	dx, word ptr [bp+6]	;@04661
	push	dx	;@04664
	push	ax	;@04665
	xor	ax, ax	;@04666
	push	ax	;@04668
	call	RH_DOS_CREATE	;@04669
	mov	word ptr [bp-4], ax	;@0466C
	cmp	word ptr [bp-4], -1	;@0466F
	jne	@@3	;@04673
	mov	ax, 1002h	;@04675
	jmp	@@5	;@04678
@@3:	push	ds	;@0467B
	mov	ax, word ptr [bp+0Ch]	;@0467C
	shl	ax, 3	;@0467F
	mov	dx, word ptr ds:[6DEh]	;@04682
	add	dx, ax	;@04686
	mov	bx, word ptr [bp+0Ch]	;@04688
	shl	bx, 1	;@0468B
	mov	word ptr [bx+6DEh], dx	;@0468D
	mov	bx, word ptr [bp+0Ch]	;@04691
	shl	bx, 1	;@04694
	mov	ds, word ptr [bx+6DEh]	;@04696
	mov	ax, word ptr [bp-4]	;@0469A
	mov	word ptr ds:[34h], ax	;@0469D
	mov	ax, word ptr [bp+6]	;@046A0
	mov	dx, word ptr [bp+4]	;@046A3
	mov	word ptr ds:[3Ah], ax	;@046A6
	mov	word ptr ds:[38h], dx	;@046A9
	pop	ds	;@046AD
	push	ds	;@046AE
	push	0	;@046AF
	push	0	;@046B1
	push	word ptr [bp+0Ah]	;@046B3
	push	word ptr [bp+8]	;@046B6
	push	word ptr [bp+0Ch]	;@046B9
	push	1FFh	;@046BC
	call	L022EC	;@046BF
	push	0FFFFh	;@046C2
	call	L01BF6	;@046C4
	mov	word ptr [bp-2], ax	;@046C7
	mov	word ptr ds:[36h], ax	;@046CA
	mov	bx, word ptr [bp-2]	;@046CD
	or	word ptr [bx+0Eh], 8008h	;@046D0
	mov	word ptr [bx+14h], 0	;@046D5
	mov	word ptr [bx+12h], 0	;@046DA
	mov	ax, word ptr [bx+0Ah]	;@046DF
	mov	word ptr ds:[0Eh], ax	;@046E2
	mov	word ptr ds:[16h], ax	;@046E5
	mov	al, byte ptr ds:[9]	;@046E8
	or	al, 80h	;@046EB
	mov	byte ptr ds:[9], al	;@046ED
	mov	word ptr ds:[2Ch], 3B35h	;@046F0
	mov	word ptr ds:[2Eh], 3AC2h	;@046F6
	mov	word ptr ds:[30h], 3BA8h	;@046FC
	mov	word ptr ds:[2Ah], 3BF2h	;@04702
	pop	ds	;@04708
@@4:	xor	ax, ax	;@04709
@@5:	leave	;@0470B
	ret	0Ah	;@0470C
	db	55h, 8Bh, 0ECh, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 0E8h, 30h, 0C4h	;@0470F
	db	0Bh, 0C0h, 75h, 11h, 6Ah, 3, 6Ah, 2, 6Ah, 0, 0FFh, 76h, 8, 0FFh
	db	76h, 6, 0E8h, 19h, 0FFh, 0EBh, 3, 0B8h, 0, 10h, 1Fh, 5Dh, 0CAh
	db	4, 0
L04738:	push	bp	;@04738
	mov	bp, sp	;@04739
	sub	sp, 4	;@0473B
	push	ds	;@0473E
	mov	bx, word ptr [bp+4]	;@0473F
	shl	bx, 1	;@04742
	mov	ds, word ptr [bx+6DEh]	;@04744
	mov	ax, word ptr ds:[3Ah]	;@04748
	mov	dx, word ptr ds:[38h]	;@0474B
	mov	word ptr [bp-2], ax	;@0474F
	mov	word ptr [bp-4], dx	;@04752
	push	word ptr ds:[34h]	;@04755
	call	RH_DOS_CLOSE	;@04759
	pop	ds	;@0475C
	push	word ptr [bp-2]	;@0475D
	push	word ptr [bp-4]	;@04760
	call	RH_DOS_DELETE	;@04763
	leave	;@04766
	ret	2	;@04767
	db	55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 5Dh	;@0476A
	db	0C2h, 6, 0, 55h, 8Bh, 0ECh, 5Dh, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 1Eh
	db	6Ah, 0, 6Ah, 0, 6Ah, 0, 6Ah, 0, 6Ah, 5, 6Ah, 0, 0E8h, 59h, 0DBh
	db	0C7h, 6, 26h, 0, 10h, 1Bh, 0C7h, 6, 28h, 0, 3Dh, 1Bh, 0C7h, 6
	db	2Ch, 0, 32h, 3Eh, 0C7h, 6, 2Eh, 0, 32h, 3Eh, 0C7h, 6, 30h, 0, 32h
	db	3Eh, 0C7h, 6, 2Ah, 0, 39h, 3Eh, 1Fh, 33h, 0C0h, 5Dh, 0C3h
CALL_SELF_FOREVER_RG2BEND:	push	bp	;@047BC
	mov	bp, sp	;@047BD
	call	CALL_SELF_FOREVER_RG2BEND	;@047BF
	pop	bp	;@047C2
	ret	;@047C3
	db	55h, 8Bh, 0ECh, 'LLVW', 0C6h, 46h, 0FFh, 0, 50h	;@047C4
L047D0:	pop	ax	;@047D0
	mov	ax, word ptr [bp+4]	;@047D1
	mov	dx, word ptr [bp+6]	;@047D4
	call	L03D05	;@047D7
	mov	word ptr [bp+4], ax	;@047DA
	mov	di, word ptr [bp+8]	;@047DD
	mov	dx, word ptr ds:[36h]	;@047E0
	mov	ah, 47h	;@047E4
	call	L04CE7	;@047E6
	shl	ah, 1	;@047E9
	jb	@@6	;@047EB
	mov	ax, word ptr [di]	;@047ED
	mov	dx, word ptr [di+2]	;@047EF
	mov	bx, 4000h	;@047F2
	div	bx	;@047F5
	mov	bx, ax	;@047F7
	mov	si, dx	;@047F9
	shr	si, 1	;@047FB
	mov	dx, word ptr [di+0Ch]	;@047FD
	add	dx, 1	;@04800
	rcr	dx, 1	;@04803
	xor	di, di	;@04805
@@1:	mov	cx, 2000h	;@04807
	sub	cx, si	;@0480A
	cmp	cx, dx	;@0480C
	jb	@@2	;@0480E
	mov	cx, dx	;@04810
@@2:	sub	dx, cx	;@04812
	push	dx	;@04814
	mov	dx, word ptr ds:[36h]	;@04815
	mov	ax, 4400h	;@04819
	call	L04CE7	;@0481C
	pop	dx	;@0481F
	shl	ah, 1	;@04820
	jb	@@5	;@04822
	shl	si, 1	;@04824
	push	ds	;@04826
	push	bx	;@04827
	mov	ax, word ptr [bp+4]	;@04828
	mov	bx, word ptr ds:[38h]	;@0482B
	cmp	byte ptr [bp-1], 0	;@0482F
	je	@@3	;@04833
	xchg	ax, bx	;@04835
	xchg	si, di	;@04836
@@3:	mov	es, ax	;@04838
	mov	ds, bx	;@0483A
	pop	bx	;@0483C
	cld	;@0483D
	rep movsw	;@0483E
	pop	ds	;@04840
	inc	bx	;@04841
	cmp	byte ptr [bp-1], 0	;@04842
	je	@@4	;@04846
	xchg	si, di	;@04848
@@4:	xor	si, si	;@0484A
	or	dx, dx	;@0484C
	jne	@@1	;@0484E
	clc	;@04850
@@5:	pushf	;@04851
	mov	dx, word ptr ds:[36h]	;@04852
	mov	ah, 48h	;@04856
	call	L04CE7	;@04858
	popf	;@0485B
	jae	@@7	;@0485C
@@6:	push	ds	;@0485E
	mov	ax, 1	;@0485F
	push	ax	;@04862
	mov	ax, 0E010h	;@04863
	push	ax	;@04866
	mov	ds, word ptr cs:L0532F+2	;@04867
	call	dword ptr ds:[60C4h]	;@0486C
	pop	ds	;@04870
@@7:	pop	di	;@04871
	pop	si	;@04872
	leave	;@04873
	ret	6	;@04874
EMS_WRITE_NODE:	push	bp	;@04877
	mov	bp, sp	;@04878
	dec	sp	;@0487A
	dec	sp	;@0487B
	push	si	;@0487C
	push	di	;@0487D
	mov	byte ptr [bp-1], 1	;@0487E
	mov	si, 2	;@04882
	mov	di, 2	;@04885
	call	L047D0	;@04888
	pop	di	;@0488B
	pop	si	;@0488C
	leave	;@0488D
	ret	6	;@0488E
	db	55h, 8Bh, 0ECh, 'LLVW', 8Bh, 5Eh, 8, 8Bh, 47h, 0Ch, 89h, 46h, 0FEh	;@04891
	db	8Bh, 46h, 4, 8Bh, 56h, 6, 0BBh, 0, 40h, 0F7h, 0F3h, 50h, 0D1h
	db	0EAh, 52h, 8Bh, 76h, 8, 8Bh, 4, 8Bh, 54h, 2, 0BBh, 0, 40h, 0F7h
	db	0F3h, 8Bh, 0D8h, 52h, 8Bh, 0FAh, 0D1h, 0EFh, 8Bh, 56h, 0FEh, 83h
	db	0C2h, 1, 0D1h, 0DAh, 0B8h, 1, 44h, 33h, 0F6h, 50h, 52h, 8Bh, 16h
	db	36h, 0, 0E8h, 0Dh, 4, 5Ah, 0D0h, 0E4h, 72h, 7Bh, 0B9h, 0, 20h
	db	2Bh, 0CFh, 3Bh, 0CAh, 72h, 2, 8Bh, 0CAh, 3, 0F1h, 43h, 33h, 0FFh
	db	2Bh, 0D1h, 58h, 74h, 6, 0FEh, 0C0h, 3Ch, 4, 72h, 0D7h, 0D1h, 0E2h
	db	89h, 56h, 0FEh, 8Bh, 0D6h, 0D1h, 0E6h, 8Bh, 0C6h, 8Bh, 76h, 8
	db	1, 4, 83h, 54h, 2, 0, '^_[', 0B9h, 0, 20h, 2Bh, 0CFh, 3Bh, 0CAh
	db	72h, 2, 8Bh, 0CAh, 2Bh, 0D1h, 52h, 8Bh, 16h, 36h, 0, 0B8h, 0, 44h
	db	0E8h, 0BEh, 3, 5Ah, 0D0h, 0E4h, 72h, 2Ch, 0D1h, 0E7h, 1Eh, 0A1h
	db	38h, 0, 8Eh, 0C0h, 3, 6, 3Ah, 0, 8Eh, 0D8h, 0FCh, 0F3h, 0A5h, 1Fh
	db	81h, 0FFh, 0, 40h, 75h, 3, 43h, 33h, 0FFh, 0Bh, 0D2h, 75h, 0C4h
	db	83h, 7Eh, 0FEh, 0, 74h, 1Dh, 53h, 0D1h, 0EFh, 57h, 0E9h, 56h, 0FFh
	db	83h, 0C4h, 8, 1Eh, 0B8h, 1, 0, 50h, 0B8h, 10h, 0E0h, 50h, 2Eh
	db	8Eh, 1Eh, 0F1h, 48h, 0FFh, 1Eh, 0C4h, 60h, 1Fh, 8Bh, 5Eh, 8, 8Bh
	db	46h, 6, 8Bh, 56h, 4, 89h, 47h, 2, 89h, 17h, 5Fh, 5Eh, 0C9h, 0C2h
	db	6, 0, 55h, 8Bh, 0ECh, 4Ch, 4Ch, 8Bh, 1Eh, 14h, 0, 8Bh, 47h, 14h
	db	89h, 46h, 0FEh, 3Bh, 6, 14h, 0, 75h, 5, 33h, 0C0h, 0EBh, 6Dh, 90h
	db	8Bh, 5Eh, 0FEh, 8Bh, 47h, 14h, 3Bh, 6, 14h, 0, 75h, 18h, 8Bh, 47h
	db	6, 8Bh, 57h, 4, 3Bh, 46h, 6, 72h, 9, 75h, 5, 3Bh, 56h, 4, 72h
	db	2, 0EBh, 49h, 33h, 0C0h, 0EBh, 48h, 8Eh, 6, 0Ch, 0, 8Bh, 16h, 36h
	db	0, 0B4h, 47h, 0E8h, 18h, 3, 0D0h, 0E4h, 72h, 21h, 0FFh, 76h, 6
	db	0FFh, 76h, 4, 0FFh, 36h, 16h, 0, 0FFh, 36h, 18h, 0, 0E8h, 8Bh
	db	0CFh, 89h, 46h, 0FEh, 8Bh, 16h, 36h, 0, 0B4h, 48h, 0E8h, 0F7h
	db	2, 0D0h, 0E4h, 73h, 13h, 1Eh, 0B8h, 1, 0, 50h, 0B8h, 10h, 0E0h
	db	50h, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 0FFh, 1Eh, 0C4h, 60h, 1Fh, 8Bh
	db	46h, 0FEh, 0C9h, 0C2h, 4, 0, 55h, 8Bh, 0ECh, 83h, 0ECh, 8, 1Eh
	db	0B8h, 87h, 0Bh, 8Eh, 0D8h, 83h, 7Eh, 0Ah, 0, 75h, 71h, 9Ah, '^B?'
	db	0, 0Bh, 0C0h, 75h, 7, 33h, 0D2h, 33h, 0C0h, 0E9h, 24h, 1, 0B8h
	db	17h, 3, 8Eh, 0C0h, 26h, 0A1h, 26h, 0, 3Bh, 46h, 8, 77h, 7, 33h
	db	0D2h, 33h, 0C0h, 0E9h, 0Fh, 1, 83h, 7Eh, 6, 0, 74h, 11h, 0B8h
	db	17h, 3, 8Eh, 0C0h, 26h, 0A1h, 26h, 0, 2Bh, 46h, 8, 3Bh, 46h, 6
	db	73h, 0Fh, 0B8h, 17h, 3, 8Eh, 0C0h, 26h, 0A1h, 26h, 0, 2Bh, 46h
	db	8, 89h, 46h, 6, 83h, 7Eh, 6, 4, 73h, 7, 33h, 0D2h, 33h, 0C0h, 0E9h
	db	0DCh, 0, 0FFh, 76h, 0Ah, 0FFh, 76h, 8, 0FFh, 76h, 6, 9Ah, 14h
	db	43h, 3Fh, 0, 0Bh, 0C0h, 74h, 14h, 33h, 0D2h, 33h, 0C0h, 0E9h, 0C3h
	db	0, 83h, 7Eh, 6, 4, 73h, 7, 33h, 0D2h, 33h, 0C0h, 0E9h, 0B6h, 0
	db	0B8h, 0, 40h, 0F7h, 66h, 8, 89h, 46h, 0FCh, 89h, 56h, 0FEh, 0B8h
	db	0, 40h, 0F7h, 66h, 6, 89h, 46h, 0F8h, 89h, 56h, 0FAh, 0FFh, 76h
	db	0FEh, 0FFh, 76h, 0FCh, 52h, 50h, 0B8h, 4, 0, 50h, 0B8h, 1, 0, 50h
	db	0E8h, 23h, 0D8h, 0B8h, 17h, 3, 8Eh, 0C0h, 26h, 0A1h, 22h, 0, 0A3h
	db	36h, 0, 0B8h, 17h, 3, 8Eh, 0C0h, 26h, 0A1h, 20h, 0, 0A3h, 38h
	db	0, 0C7h, 6, 34h, 0, 0FFh, 0FFh, 0C7h, 6, 3Ah, 0, 0, 4, 0C7h, 6
	db	2Ch, 0, 37h, 3Fh, 0C7h, 6, 2Eh, 0, 84h, 3Eh, 0C7h, 6, 30h, 0, 51h
	db	3Fh, 0C7h, 6, 2Ah, 0, 44h, 40h, 1Eh, 7, 8Eh, 1Eh, 0Ch, 0, 8Bh
	db	1Eh, 0Eh, 7, 83h, 0C3h, 10h, 26h, 0A1h, 38h, 0, 26h, 89h, 1Eh
	db	38h, 0, 26h, 0C7h, 6, 3Ah, 0, 8, 0, 83h, 0E3h, 0F8h, 0BAh, 10h
	db	0, 0F7h, 0E2h, 8Eh, 6, 14h, 7, 0B9h, 4, 0, 26h, 89h, 47h, 2, 26h
	db	88h, 57h, 4, 26h, 0C7h, 7, 0FFh, 0FFh, 26h, 0C6h, 47h, 5, 0F2h
	db	83h, 0C3h, 8, 5, 0, 40h, 80h, 0D2h, 0, 0E2h, 0E3h, 8Bh, 56h, 0FAh
	db	8Bh, 46h, 0F8h, 1Fh, 0C9h, 0CAh, 6, 0, 55h, 8Bh, 0ECh, 9Ah, '|C?'
	db	0, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h
	db	8Bh, 0ECh, 1Eh, 0B8h, 87h, 0Bh, 8Eh, 0D8h, 8Bh, 46h, 0Ch, 8Bh
	db	56h, 0Ah, 89h, 46h, 0Ch, 89h, 56h, 0Ah, 8Bh, 46h, 8, 8Bh, 56h
	db	6, 89h, 46h, 8, 89h, 56h, 6, 33h, 0D2h, 33h, 0C0h, 1Fh, 5Dh, 0CAh
	db	8, 0, 'EMMXXXX0', 0, 55h, 8Bh, 0ECh, 81h, 0ECh, 2, 1, 1Eh, 2Eh
	db	8Eh, 1Eh, 0EFh, 'HVW', 0F6h, 6, 28h, 0, 1, 74h, 10h, 0F6h, 6, 28h
	db	0, 2, 75h, 3, 0EBh, 72h, 90h, 0A1h, 26h, 0, 0E9h, 89h, 0, 1Eh
	db	0Eh, 1Fh, 0BAh, 55h, 42h, 0B8h, 0, 3Dh, 0CDh, 21h, 1Fh, 8Bh, 0D8h
	db	72h, 22h, 0B8h, 0, 44h, 0CDh, 21h, 72h, 17h, 0F7h, 0C2h, 80h, 0
	db	74h, 11h, 0B8h, 7, 44h, 0CDh, 21h, 72h, 0Ah, 50h, 0B4h, 3Eh, 0CDh
	db	'!X<', 0FFh, 74h, 7, 0B4h, 3Eh, 0CDh, 21h, 0EBh, 4Eh, 90h, 0B8h
	db	67h, 35h, 0CDh, 21h, 8Ch, 0C0h, 0Bh, 0C3h, 74h, 0F2h, 0B4h, 40h
	db	0E8h, 0DEh, 0, 0Ah, 0E4h, 75h, 0E9h, 0C6h, 6, 28h, 0, 1, 0B4h
	db	46h, 0E8h, 0D0h, 0, 0Ah, 0E4h, 75h, 0DBh, '<2r', 0D7h, 0A2h, 29h
	db	0, 0B4h, 41h, 0E8h, 0C0h, 0, 0Ah, 0E4h, 75h, 0CBh, 89h, 1Eh, 20h
	db	0, 0B4h, 42h, 0E8h, 0B3h, 0, 0Ah, 0E4h, 75h, 0Eh, 89h, 1Eh, 26h
	db	0, 0C7h, 6, 22h, 0, 0FFh, 0FFh, 8Bh, 0C3h, 0EBh, 7, 33h, 0C0h
	db	0C6h, 6, 28h, 0, 0, 5Fh, 5Eh, 1Fh, 8Bh, 0E5h, 5Dh, 0CBh, 55h, 8Bh
	db	0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 0F6h, 6, 28h, 0, 1, 75h, 3
	db	0EBh, 4Eh, 90h, 0F6h, 6, 28h, 0, 2, 74h, 5, 33h, 0C0h, 0EBh, 45h
	db	90h, 80h, 0Eh, 28h, 0, 2, 8Bh, 46h, 8, 0A3h, 24h, 0, 8Bh, 5Eh
	db	6, 89h, 1Eh, 26h, 0, 8Bh, 56h, 0Ah, 0Bh, 0D2h, 75h, 0Eh, 0B4h
	db	43h, 0E8h, 56h, 0, 0Ah, 0E4h, 75h, 1Fh, 80h, 0Eh, 28h, 0, 4, 89h
	db	16h, 22h, 0, 0B4h, 47h, 0E8h, 44h, 0, 0Ah, 0E4h, 75h, 0Dh, 8Bh
	db	16h, 22h, 0, 0B4h, 48h, 0E8h, 37h, 0, 8Ah, 0C4h, 0EBh, 3, 0B8h
	db	0FFh, 0FFh, 1Fh, 5Dh, 0CAh, 6, 0, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh
	db	1Eh, 0EFh, 48h, 0F6h, 6, 28h, 0, 4, 74h, 18h, 8Bh, 16h, 22h, 0
	db	0Bh, 0D2h, 78h, 10h, 0B4h, 45h, 0E8h, 0Eh, 0, 0C7h, 6, 22h, 0
	db	0FFh, 0FFh, 0C6h, 6, 28h, 0, 0, 1Fh, 5Dh, 0CBh
L04CE7:	push	es	;@04CE7
	push	ds	;@04CE8
	push	di	;@04CE9
	push	si	;@04CEA
	pushf	;@04CEB
	push	dx	;@04CEC
	push	cx	;@04CED
	push	bx	;@04CEE
	push	ax	;@04CEF
	mov	dx, sp	;@04CF0
	push	ss	;@04CF2
	pop	ds	;@04CF3
	mov	bx, 8	;@04CF4
	mov	ax, 0E367h	;@04CF7
	int	21h	;@04CFA
	pop	ax	;@04CFC
	pop	bx	;@04CFD
	pop	cx	;@04CFE
	pop	dx	;@04CFF
	popf	;@04D00
	pop	si	;@04D01
	pop	di	;@04D02
	pop	ds	;@04D03
	pop	es	;@04D04
	ret	;@04D05
	db	33h, 0C0h, 8Bh, 0D2h, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh	;@04D06
	db	0EFh, 'HVW', 0F6h, 6, 0C2h, 0, 1, 75h, 3, 0E9h, 0B9h, 0, 0F6h
	db	6, 0C2h, 0, 2, 74h, 5, 33h, 0C0h, 0E9h, 0B0h, 0, 80h, 0Eh, 0C2h
	db	0, 2, 8Bh, 46h, 0Ah, 8Bh, 56h, 0Ch, 8Bh, 76h, 6, 8Bh, 7Eh, 8, 8Bh
	db	1Eh, 0C3h, 0, 0Bh, 1Eh, 0C5h, 0, 74h, 43h, 8Bh, 0C6h, 8Bh, 0D7h
	db	5, 0FFh, 3, 83h, 0D2h, 0, 0BBh, 0, 4, 0F7h, 0F3h, 92h, 0B4h, 9
	db	0FFh, 1Eh, 0C3h, 0, 0Bh, 0C0h, 74h, 26h, 89h, 16h, 0C7h, 0, 0B4h
	db	0Ch, 0FFh, 1Eh, 0C3h, 0, 0Bh, 0C0h, 74h, 18h, 89h, 1Eh, 0BAh, 0
	db	89h, 16h, 0BCh, 0, 89h, 1Eh, 0C9h, 0, 89h, 16h, 0CBh, 0, 8Bh, 0C3h
	db	3, 0C6h, 13h, 0D7h, 0EBh, 47h, 0EBh, 50h, 90h, 0A3h, 0BAh, 0, 89h
	db	16h, 0BCh, 0, 33h, 0DBh, 8Eh, 0C3h, 1Eh, 0BBh, 67h, 3, 8Eh, 0DBh
	db	26h, 8Bh, 1Eh, 64h, 0, 89h, 1Eh, 2Fh, 0, 26h, 8Bh, 1Eh, 66h, 0
	db	89h, 1Eh, 31h, 0, 26h, 0C7h, 6, 64h, 0, 3Fh, 0, 26h, 0C7h, 6, 66h
	db	0, 67h, 3, 0A3h, 3Ah, 0, 88h, 16h, 3Ch, 0, 3, 0C6h, 13h, 0D7h
	db	0A3h, 2Ch, 0, 88h, 16h, 2Eh, 0, 1Fh, 0A3h, 0BEh, 0, 89h, 16h, 0C0h
	db	0, 33h, 0C0h, 0EBh, 3, 0B8h, 0FFh, 0FFh, 5Fh, 5Eh, 1Fh, 5Dh, 0CAh
	db	8, 0, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 80h, 3Eh
	db	0C2h, 0, 0, 74h, 41h, 83h, 3Eh, 0C7h, 0, 0, 74h, 16h, 0B4h, 0Dh
	db	8Bh, 16h, 0C7h, 0, 0FFh, 1Eh, 0C3h, 0, 0B4h, 0Ah, 8Bh, 16h, 0C7h
	db	0, 0FFh, 1Eh, 0C3h, 0, 0EBh, 24h, 33h, 0C0h, 8Eh, 0C0h, 26h, 0A1h
	db	66h, 0, 3Dh, 67h, 3, 75h, 17h, 1Eh, 8Eh, 0D8h, 0A1h, 2Fh, 0, 26h
	db	0A3h, 64h, 0, 0A1h, 31h, 0, 26h, 0A3h, 66h, 0, 1Fh, 0C6h, 6, 0C2h
	db	0, 0, 1Fh, 5Dh, 0CBh, 1Eh, 6, 83h, 0C6h, 1, 83h, 0D7h, 0, 83h
	db	0E6h, 0FEh, 0FCh, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 83h, 3Eh, 0C7h, 0
	db	0, 74h, 6Ah, 89h, 36h, 0CDh, 0, 89h, 3Eh, 0CFh, 0, 80h, 0FAh, 10h
	db	72h, 13h, 8Bh, 36h, 0C7h, 0, 89h, 36h, 0D1h, 0, 2Bh, 6, 0C9h, 0
	db	1Bh, 16h, 0CBh, 0, 0EBh, 0Ah, 90h, 0C7h, 6, 0D1h, 0, 0, 0, 0C1h
	db	0CAh, 4, 0A3h, 0D3h, 0, 89h, 16h, 0D5h, 0, 80h, 0F9h, 10h, 72h
	db	13h, 8Bh, 36h, 0C7h, 0, 89h, 36h, 0D7h, 0, 2Bh, 1Eh, 0C9h, 0, 1Bh
	db	0Eh, 0CBh, 0, 0EBh, 0Ah, 90h, 0C7h, 6, 0D7h, 0, 0, 0, 0C1h, 0C9h
	db	4, 89h, 1Eh, 0D9h, 0, 89h, 0Eh, 0DBh, 0, 0B4h, 0Bh, 8Dh, 36h, 0CDh
	db	0, 0FFh, 1Eh, 0C3h, 0, 0Bh, 0C0h, 75h, 29h, 0F9h, 0EBh, 21h, 0D1h
	db	0EFh, 0D1h, 0DEh, 0A3h, 0DFh, 0, 88h, 16h, 0E1h, 0, 89h, 1Eh, 0E7h
	db	0, 88h, 0Eh, 0E9h, 0, 8Bh, 0CEh, 8Dh, 36h, 0CDh, 0, 1Eh, 7, 0B4h
	db	87h, 0CDh, 15h, 73h, 5, 1Bh, 0C0h, 0F9h, 0EBh, 2, 33h, 0C0h, 7
	db	1Fh, 0C3h, 0CBh, 0CBh, 0, 0, 0, 0
L04EEA:	pop	ax	;@04EEA
	mov	bx, sp	;@04EEB
	xchg	word ptr ss:[bx+8], ax	;@04EED
	mov	bx, ax	;@04EF1
	mov	bl, byte ptr [bx+16h]	;@04EF3
	xor	bh, bh	;@04EF6
	shl	bx, 1	;@04EF8
	shl	bx, 1	;@04EFA
	mov	es, word ptr cs:L04FD0+22	;@04EFC
	call	dword ptr es:[bx]	;@04F01
	ret	;@04F04
L04F05:	push	bp	;@04F05
	mov	bp, sp	;@04F06
	push	ds	;@04F08
	mov	ds, word ptr cs:L0532F	;@04F09
	mov	cx, word ptr cs:L04FD0+22	;@04F0E
	jcxz	@@7	;@04F13
	mov	es, cx	;@04F15
	mov	ax, word ptr [bp+4]	;@04F17
	mov	dx, word ptr [bp+6]	;@04F1A
	mov	cx, word ptr ds:[12h]	;@04F1D
	shr	cx, 1	;@04F21
	shr	cx, 1	;@04F23
	xor	bx, bx	;@04F25
@@1:	cmp	word ptr es:[bx+2], dx	;@04F27
	jne	@@2	;@04F2B
	cmp	word ptr es:[bx], ax	;@04F2D
	je	@@5	;@04F30
@@2:	add	bx, 4	;@04F32
	loop	@@1	;@04F35
	mov	bx, word ptr ds:[12h]	;@04F37
	cmp	bx, word ptr ds:[10h]	;@04F3B
	jb	@@4	;@04F3F
	cmp	bx, 100h	;@04F41
	jb	@@3	;@04F45
	xor	bx, bx	;@04F47
	jmp	@@6	;@04F49
@@3:	mov	ax, 1000h	;@04F4C
	push	ax	;@04F4F
	push	ax	;@04F50
	push	word ptr cs:L04FD0+24	;@04F51
	mov	ax, 45A6h	;@04F56
	push	ax	;@04F59
	add	bx, 10h	;@04F5A
	push	bx	;@04F5D
	db	9Ah, 0A2h, 25h, 3Fh, 0	; lcall 0x3f, 0x25a2	;@04F5E
	xor	bx, bx	;@04F63
	or	ax, ax	;@04F65
	jne	@@6	;@04F67
@@4:	mov	es, word ptr cs:L04FD0+22	;@04F69
	mov	bx, word ptr ds:[12h]	;@04F6E
	mov	ax, word ptr [bp+4]	;@04F72
	mov	word ptr es:[bx], ax	;@04F75
	mov	ax, word ptr [bp+6]	;@04F78
	mov	word ptr es:[bx+2], ax	;@04F7B
	add	word ptr ds:[12h], 4	;@04F7F
@@5:	shr	bx, 1	;@04F84
	shr	bx, 1	;@04F86
@@6:	mov	ax, bx	;@04F88
	pop	ds	;@04F8A
	pop	bp	;@04F8B
	ret	4	;@04F8C
@@7:	mov	es, word ptr cs:L0532F+2	;@04F8F
	mov	al, byte ptr es:[6CCh]	;@04F94
	push	ax	;@04F98
	mov	byte ptr es:[6CCh], 0	;@04F99
	push	word ptr cs:L04FD0+24	;@04F9F
	mov	ax, 45A6h	;@04FA4
	push	ax	;@04FA7
	mov	ax, 10h	;@04FA8
	push	ax	;@04FAB
	db	9Ah, 7Bh, 1Dh, 3Fh, 0	; lcall 0x3f, 0x1d7b	;@04FAC
	mov	es, word ptr cs:L0532F+2	;@04FB1
	pop	bx	;@04FB6
	mov	byte ptr es:[6CCh], bl	;@04FB7
	xor	bx, bx	;@04FBC
	or	ax, ax	;@04FBE
	jne	@@6	;@04FC0
	mov	word ptr ds:[10h], 10h	;@04FC2
	mov	word ptr ds:[12h], 4	;@04FC8
	jmp	@@4	;@04FCE
L04FD0	db	0FFh, 0BBh, 46h, 3Fh, 0, 1Eh, 0B8h, 0Bh, 35h, 0CDh, 21h, 6, 53h	;@04FD0
	db	0B8h, 0Bh, 25h, 2Eh, 8Bh, 16h, 91h, 46h, 2Eh, 8Eh, 1Eh, 93h, 46h
	db	0CDh, 21h, 2Eh, 8Eh, 1Eh, 0A8h, 45h, 8Fh, 6, 91h, 46h, 8Fh, 6
	db	93h, 46h, 1Fh, 0C3h, 50h, 0B0h, 0Bh, 0E6h, 20h, 0E4h, 20h, 0A8h
	db	8, 74h, 13h, 58h, 1Eh, 6, 60h, 8Bh, 0D4h, 16h, 1Fh, 33h, 0DBh
	db	0B8h, 0Bh, 0E3h, 0CDh, 21h, 61h, 7, 1Fh, 0CFh, 58h, 55h, 8Bh, 0ECh
	db	1Eh, 53h, 8Bh, 5Eh, 2, 2Eh, 8Eh, 1Eh, 0F1h, 48h, 3Bh, 1Eh, 0C2h
	db	60h, 72h, 0Eh, 3Bh, 1Eh, 0BEh, 60h, 73h, 8, 83h, 0E3h, 7, 80h
	db	0FBh, 4, 74h, 3, 0E9h, 82h, 0, 60h, 6, 0FFh, 76h, 2, 9Ah, 'I2?'
	db	0, 2Eh, 8Eh, 6, 0EFh, 48h, 26h, 8Bh, 1Eh, 0B0h, 1, 8Eh, 0C2h, 26h
	db	3Bh, 1Eh, 0, 0, 'um&', 0FFh, 36h, 10h, 0, 6, 68h, 0, 20h, 68h
	db	0, ' RPj', 0, 0E8h, 0DFh, 0EBh, 9Ah, 0A2h, 25h, 3Fh, 0, 50h, 0E8h
	db	0D6h, 0EBh, 58h, 0Bh, 0C0h, 74h, 1, 0CCh, 7, 58h, 8Ch, 0C2h, 80h
	db	0F2h, 8, 8Eh, 0C2h, 3Bh, 56h, 6, 74h, 15h, 0C5h, 5Eh, 4, 80h, 3Fh
	db	0CBh, 75h, 8, 0C7h, 46h, 4, 0A1h, 47h, 8Ch, 4Eh, 6, 8Bh, 5Eh, 0Ah
	db	0EBh, 7, 8Bh, 5Eh, 4, 26h, 8Bh, 5Fh, 1, 0Bh, 0C0h, 3Dh, 1, 0, 1Bh
	db	0C0h, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 0FFh, 1Eh, 20h, 1, 7, 61h, 5Bh
	db	1Fh, 5Dh, 83h, 0C4h, 2, 0CFh, 5Bh, 1Fh, 5Dh, 0CCh, 83h, 0C4h, 2
	db	0CFh, 0C4h, 5Eh, 4, 26h, 8Ah, 7, 3Ch, 1Fh, 74h, 4, 3Ch, 7, 75h
	db	7, 0C7h, 46h, 0Ah, 0, 0, 0EBh, 0DAh, 7, 61h, 0EBh, 0DFh, 0CBh
L050E2:	mov	bx, sp	;@050E2
	xchg	word ptr ss:[bx+8], dx	;@050E4
	xchg	word ptr ss:[bx+6], ax	;@050E8
	pop	bx	;@050EC
	pop	es	;@050ED
	pop	cx	;@050EE
	push	dx	;@050EF
	push	ax	;@050F0
	push	cx	;@050F1
	push	es	;@050F2
	push	bx	;@050F3
	db	0EAh, 0A2h, 25h, 3Fh, 0	; ljmp 0x3f:0x25a2	;@050F4
L050F9:	mov	bx, sp	;@050F9
	xchg	word ptr ss:[bx+6], dx	;@050FB
	xchg	word ptr ss:[bx+4], ax	;@050FF
	pop	bx	;@05103
	pop	es	;@05104
	push	dx	;@05105
	push	ax	;@05106
	xor	cx, cx	;@05107
	push	cx	;@05109
	push	es	;@0510A
	push	bx	;@0510B
	db	0EAh, 0A2h, 25h, 3Fh, 0	; ljmp 0x3f:0x25a2	;@0510C
RESIZE_POOL_BLOCK:	mov	dx, 1000h	;@05111
	mov	ax, dx	;@05114
	jmp	L050E2	;@05116
HEAP_MODE_SET_BIT5:	mov	dx, 20h	;@05118
	mov	ax, dx	;@0511B
	jmp	L050F9	;@0511D
	db	33h, 0D2h, 0B8h, 20h, 0, 0EBh, 0D3h	;@0511F
HEAP_MODE_SET_BIT13:	mov	dx, 2000h	;@05126
	mov	ax, dx	;@05129
	jmp	L050F9	;@0512B
FIX_HEAP_NODE_LOW:	mov	dx, 8	;@0512D
	mov	ax, dx	;@05130
	jmp	L050F9	;@05132
	db	0BAh, 10h, 0, 8Bh, 0C2h, 0EBh, 0BEh, 33h, 0D2h, 0B8h, 18h, 0, 0EBh	;@05134
	db	0B7h, 0BAh, 8, 8, 8Bh, 0C2h, 0EBh, 99h, 0BAh, 10h, 8, 8Bh, 0C2h
	db	0EBh, 92h, 0BAh, 8, 20h, 8Bh, 0C2h, 0EBh, 0A2h, 0BAh, 40h, 0, 8Bh
	db	0C2h, 0EBh, 9Bh, 0BAh, 60h, 0, 8Bh, 0C2h, 0EBh, 94h, 33h, 0D2h
	db	0B8h, 40h, 0, 0EBh, 8Dh, 0EAh, 8Ah, 1Eh, 3Fh, 0, 55h, 8Bh, 0ECh
	db	0E8h, 0FAh, 0FFh, 5Dh, 0C3h, 55h, 8Bh, 0ECh, 0E8h, 0FAh, 0FFh
	db	5Dh, 0C3h
RH_DOS_OPEN:	push	bp	;@05181
	mov	bp, sp	;@05182
	push	ds	;@05184
	lds	dx, dword ptr [bp+6]	;@05185
	mov	al, byte ptr [bp+4]	;@05188
	mov	ah, 3Dh	;@0518B
	int	21h	;@0518D
	pop	ds	;@0518F
	jae	@@1	;@05190
	sbb	ax, ax	;@05192
@@1:	pop	bp	;@05194
	ret	6	;@05195
RH_DOS_CREATE:	push	bp	;@05198
	mov	bp, sp	;@05199
	push	ds	;@0519B
	lds	dx, dword ptr [bp+6]	;@0519C
	mov	ax, 3C00h	;@0519F
	xor	cx, cx	;@051A2
	int	21h	;@051A4
	pop	ds	;@051A6
	jae	@@1	;@051A7
	sbb	ax, ax	;@051A9
@@1:	pop	bp	;@051AB
	ret	6	;@051AC
RH_DOS_READ:	push	bp	;@051AF
	mov	bp, sp	;@051B0
	push	ds	;@051B2
	mov	bx, word ptr [bp+0Ah]	;@051B3
	lds	dx, dword ptr [bp+6]	;@051B6
	mov	cx, word ptr [bp+4]	;@051B9
	mov	ah, 3Fh	;@051BC
	int	21h	;@051BE
	jb	@@1	;@051C0
	cmp	ax, cx	;@051C2
@@1:	pop	ds	;@051C4
	pop	bp	;@051C5
	ret	8	;@051C6
RH_DOS_WRITE:	push	bp	;@051C9
	mov	bp, sp	;@051CA
	push	ds	;@051CC
	mov	bx, word ptr [bp+0Ah]	;@051CD
	lds	dx, dword ptr [bp+6]	;@051D0
	mov	cx, word ptr [bp+4]	;@051D3
	mov	ah, 40h	;@051D6
	int	21h	;@051D8
	jb	@@1	;@051DA
	cmp	ax, cx	;@051DC
@@1:	pop	ds	;@051DE
	pop	bp	;@051DF
	ret	8	;@051E0
RH_DOS_SEEK:	push	bp	;@051E3
	mov	bp, sp	;@051E4
	mov	bx, word ptr [bp+0Ah]	;@051E6
	mov	dx, word ptr [bp+6]	;@051E9
	mov	cx, word ptr [bp+8]	;@051EC
	mov	al, byte ptr [bp+4]	;@051EF
	mov	ah, 42h	;@051F2
	int	21h	;@051F4
	jae	@@1	;@051F6
	sbb	ax, ax	;@051F8
	cwd	;@051FA
@@1:	pop	bp	;@051FB
	ret	8	;@051FC
RH_DOS_DELETE:	push	bp	;@051FF
	mov	bp, sp	;@05200
	push	ds	;@05202
	lds	dx, dword ptr [bp+4]	;@05203
	mov	ah, 41h	;@05206
	int	21h	;@05208
	pop	ds	;@0520A
	pop	bp	;@0520B
	ret	4	;@0520C
RH_DOS_CLOSE:	push	bp	;@0520F
	mov	bp, sp	;@05210
	mov	bx, word ptr [bp+4]	;@05212
	mov	ah, 3Eh	;@05215
	int	21h	;@05217
	pop	bp	;@05219
	ret	2	;@0521A
RH_DOS_DUP:	push	bp	;@0521D
	mov	bp, sp	;@0521E
	mov	bx, word ptr [bp+4]	;@05220
	mov	ah, 45h	;@05223
	int	21h	;@05225
	jae	@@1	;@05227
	sbb	ax, ax	;@05229
@@1:	pop	bp	;@0522B
	ret	2	;@0522C
__OVRGROUP:	pop	ss	;@0522F
	add	ax, word ptr [bx+500Bh]	;@05230
	inc	cx	;@05234
	push	sp	;@05235
	dec	ax	;@05236
	cmp	ax, 0	;@05237
	push	bp	;@0523A
	mov	bp, sp	;@0523B
	sub	sp, 14h	;@0523D
	push	ds	;@05240
	mov	ds, word ptr cs:L0532F	;@05241
	push	si	;@05246
	push	di	;@05247
	cmp	word ptr ds:[1C2h], 0	;@05248
	je	@@1	;@0524D
	jmp	L05374	;@0524F
@@1:	cld	;@05252
	cmp	word ptr ds:[1B0h], 0	;@05253
	jne	@@2	;@05258
	jmp	L05374	;@0525A
@@2:	db	0E8h, 98h, 1	; call L053F8	;@0525D
	jae	@@5	;@05260
	mov	ax, word ptr [bp+6]	;@05262
	or	ax, word ptr [bp+8]	;@05265
	jne	@@3	;@05268
	mov	word ptr [bp+6], 5E0h	;@0526A
	mov	word ptr [bp+8], 377h	;@0526F
@@3:	call	L053EC	;@05274
	jae	@@5	;@05277
	db	0E8h, 0BCh, 1	; call L05438	;@05279
	jae	@@5	;@0527C
	mov	ax, 0FFFEh	;@0527E
	jmp	L05376	;@05281
@@4:	push	word ptr ds:[1C8h]	;@05284
	call	RH_DOS_CLOSE	;@05288
	mov	ax, 0FFFFh	;@0528B
	jmp	L05376	;@0528E
@@5:	mov	bx, ax	;@05291
	mov	word ptr ds:[1C8h], bx	;@05293
	mov	cx, 14h	;@05297
	db	0E8h, 1Eh, 2	; call L054BB	;@0529A
	mov	cx, 0FFFDh	;@0529D
	jb	@@4	;@052A0
	xor	ax, ax	;@052A2
	xor	dx, dx	;@052A4
	cmp	word ptr [bp-14h], 5A4Dh	;@052A6
	je	@@7	;@052AB
	cmp	word ptr [bp-14h], 4F59h	;@052AD
	jne	@@6	;@052B2
	mov	ax, word ptr [bp-8]	;@052B4
	mov	dx, word ptr [bp-6]	;@052B7
	add	ax, word ptr [bp-4]	;@052BA
	adc	dx, word ptr [bp-2]	;@052BD
	jmp	short @@9	;@052C0
@@6:	mov	cx, 0FFFCh	;@052C2
	jmp	@@4	;@052C5
@@7:	mov	ax, word ptr [bp-10h]	;@052C7
	mov	cx, word ptr [bp-12h]	;@052CA
	jcxz	@@8	;@052CD
	dec	ax	;@052CF
@@8:	mov	dx, 200h	;@052D0
	mul	dx	;@052D3
	add	ax, cx	;@052D5
@@9:	push	dx	;@052D7
	push	ax	;@052D8
	push	word ptr ds:[1C8h]	;@052D9
	push	dx	;@052DD
	push	ax	;@052DE
	xor	ax, ax	;@052DF
	push	ax	;@052E1
	call	RH_DOS_SEEK	;@052E2
	mov	cx, 10h	;@052E5
	db	0E8h, 0D0h, 1	; call L054BB	;@052E8
	pop	ax	;@052EB
	pop	dx	;@052EC
	mov	cx, 0FFFDh	;@052ED
	jb	@@4	;@052F0
	add	ax, 10h	;@052F2
	adc	dx, 0	;@052F5
	cmp	word ptr [bp-14h], 4246h	;@052F8
	mov	cx, 0FFFCh	;@052FD
	jne	@@4	;@05300
	cmp	word ptr [bp-12h], 564Fh	;@05302
	je	@@10	;@05307
	add	ax, word ptr [bp-10h]	;@05309
	adc	dx, word ptr [bp-0Eh]	;@0530C
	jmp	@@9	;@0530F
@@10:	mov	word ptr ds:[1B4h], ax	;@05311
	mov	word ptr ds:[1B6h], dx	;@05314
	mov	es, word ptr cs:L0532F+2	;@05318
	mov	ax, word ptr [bp-10h]	;@0531D
	mov	word ptr es:[71Eh], ax	;@05320
	mov	ax, word ptr [bp-0Eh]	;@05324
	mov	word ptr es:[720h], ax	;@05327
	push	word ptr ds:[1C8h]	;@0532B
L0532F:	call	RH_DOS_CLOSE	;@0532F
	mov	word ptr ds:[1C8h], 0	;@05332
	db	9Ah, 3Fh, 4Ah, 3Fh, 0	; lcall 0x3f, 0x4a3f	;@05338
	mov	ax, word ptr [bp+0Ch]	;@0533D
	mov	word ptr ds:[1C4h], ax	;@05340
	mov	ax, word ptr [bp+0Ah]	;@05343
	mov	word ptr ds:[1C6h], ax	;@05346
	db	0E8h, 7Dh, 1	; call L054C9	;@05349
	or	ax, ax	;@0534C
	jne	L05376	;@0534E
	mov	ax, 3	;@05350
	mul	word ptr ds:[1BAh]	;@05353
	push	dx	;@05357
	push	ax	;@05358
	mov	di, dx	;@05359
	mov	si, ax	;@0535B
	db	9Ah, 0, 21h, 3Fh, 0	; lcall 0x3f, 0x2100	;@0535D
	cmp	dx, di	;@05362
	jb	@@1	;@05364
	ja	@@2	;@05366
	cmp	ax, si	;@05368
	jae	@@2	;@0536A
@@1:	mov	ax, 0FFFFh	;@0536C
	jmp	short L05376	;@0536F
@@2:	call	L042B2	;@05371
L05374:	xor	ax, ax	;@05374
L05376:	pop	di	;@05376
	pop	si	;@05377
	pop	ds	;@05378
	mov	sp, bp	;@05379
	pop	bp	;@0537B
	retf	8	;@0537C
	db	55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 0A0h, 0B1h, 1, 0B4h	;@0537F
	db	35h, 0CDh, 21h, 6, 53h, 1Eh, 0A0h, 0B1h, 1, 8Bh, 16h, 2, 1, 8Eh
	db	1Eh, 4, 1, 0B4h, 25h, 0CDh, 21h, 1Fh, 8Fh, 6, 2, 1, 8Fh, 6, 4
	db	1, 83h, 3Eh, 0C8h, 1, 0, 74h, 0Fh, 0FFh, 36h, 0C8h, 1, 0E8h, 57h
	db	0FEh, 0C7h, 6, 0C8h, 1, 0, 0, 0EBh, 11h, 0B8h, 17h, 3, 50h, 0B8h
	db	2Ah, 1, 50h, 33h, 0C0h, 50h, 0E8h, 0B3h, 0FDh, 0A3h, 0C8h, 1, 1Fh
	db	5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 83h
	db	3Eh, 0C8h, 1, 0, 74h, 5, 9Ah, '?J?', 0, 1Fh, 5Dh, 0CBh
L053EC:	push	ds	;@053EC
	db	8Dh, 3Eh, 2Ah, 1	; lea di, ds:[12Ah]	;@053ED
	db	1Eh	; push ds	;@053F1
	pop	es	;@053F2
	db	0E8h, 9Fh, 0	; call L05495	;@053F3
	pop	ds	;@053F6
	ret	;@053F7
L053F8:	mov	ah, 30h	;@053F8
	int	21h	;@053FA
	cmp	al, 3	;@053FC
	db	72h, 37h	; jb @@4	;@053FE
	push	ds	;@05400
	mov	ax, 0B87h	;@05401
	mov	ds, ax	;@05404
	mov	ds, word ptr ds:[14h]	;@05406
	xor	si, si	;@0540A
	cld	;@0540C
@@1:	lodsb	;@0540D
	or	al, al	;@0540E
	jne	@@1	;@05410
	lodsb	;@05412
	or	al, al	;@05413
	jne	@@1	;@05415
	lodsw	;@05417
	db	8Dh, 3Eh, 2Ah, 1	; lea di, ds:[12Ah]	;@05418
	db	0B8h, 17h, 3	; mov ax, 317h	;@0541C
	mov	es, ax	;@0541F
	mov	bx, di	;@05421
@@2:	lodsb	;@05423
	stosb	;@05424
	or	al, al	;@05425
	je	@@3	;@05427
	cmp	al, 5Ch	;@05429
	jne	@@2	;@0542B
	mov	bx, di	;@0542D
	jmp	@@2	;@0542F
@@3:	mov	di, bx	;@05431
	db	0E8h, 5Fh, 0	; call L05495	;@05433
	pop	ds	;@05436
@@4:	ret	;@05437
L05438:	push	ds	;@05438
	mov	ax, 0B87h	;@05439
	mov	ds, ax	;@0543C
	mov	ds, word ptr ds:[14h]	;@0543E
	xor	si, si	;@05442
@@1:	mov	di, 48F3h	;@05444
	push	cs	;@05447
	pop	es	;@05448
	mov	cx, 5	;@05449
	cld	;@0544C
	repe cmpsb	;@0544D
	je	@@4	;@0544F
	dec	si	;@05451
@@2:	lodsb	;@05452
	or	al, al	;@05453
	jne	@@2	;@05455
	cmp	al, byte ptr [si]	;@05457
	jne	@@1	;@05459
@@3:	pop	ds	;@0545B
	stc	;@0545C
	ret	;@0545D
@@4:	cmp	byte ptr [si], 0	;@0545E
	je	@@3	;@05461
	db	8Dh, 3Eh, 2Ah, 1	; lea di, ds:[12Ah]	;@05463
	db	0B8h, 17h, 3	; mov ax, 317h	;@05467
	mov	es, ax	;@0546A
	xor	al, al	;@0546C
@@5:	mov	ah, al	;@0546E
	lodsb	;@05470
	or	al, al	;@05471
	je	@@6	;@05473
	cmp	al, 3Bh	;@05475
	je	@@7	;@05477
	stosb	;@05479
	jmp	@@5	;@0547A
@@6:	dec	si	;@0547C
@@7:	cmp	ah, 3Ah	;@0547D
	je	@@8	;@05480
	cmp	ah, 5Ch	;@05482
	je	@@8	;@05485
	mov	al, 5Ch	;@05487
	stosb	;@05489
@@8:	push	ds	;@0548A
	push	si	;@0548B
	call	L05495	;@0548C
	pop	si	;@0548F
	pop	ds	;@05490
	jb	@@4	;@05491
	pop	ds	;@05493
	ret	;@05494
L05495:	lds	si, dword ptr [bp+6]	;@05495
	mov	ax, ds	;@05498
	or	ax, si	;@0549A
	je	@@2	;@0549C
	mov	cx, 0Ch	;@0549E
@@1:	lodsb	;@054A1
	stosb	;@054A2
	or	al, al	;@054A3
	je	@@2	;@054A5
	loop	@@1	;@054A7
	sub	al, al	;@054A9
	stosb	;@054AB
@@2:	mov	ax, 317h	;@054AC
	push	ax	;@054AF
	mov	ax, 12Ah	;@054B0
	push	ax	;@054B3
	xor	ax, ax	;@054B4
	push	ax	;@054B6
	call	RH_DOS_OPEN	;@054B7
	ret	;@054BA
L054BB:	push	word ptr ds:[1C8h]	;@054BB
	push	ss	;@054BF
	lea	ax, [bp-14h]	;@054C0
	push	ax	;@054C3
	push	cx	;@054C4
	call	RH_DOS_READ	;@054C5
	ret	;@054C8
L054C9:	mov	ax, 327h	;@054C9
	mov	es, ax	;@054CC
	xor	bx, bx	;@054CE
	xor	di, di	;@054D0
	db	8Dh, 36h, 40h, 2	; lea si, ds:[240h]	;@054D2
@@1:	db	0F7h, 44h, 4, 2, 0	; test word ptr [si+4], 2	;@054D6
	je	@@2	;@054DB
	cmp	word ptr [si+2], 0	;@054DD
	jne	@@3	;@054E1
@@2:	jmp	@@9	;@054E3
@@3:	mov	ax, word ptr [si]	;@054E6
	xor	ax, 8	;@054E8
	push	es	;@054EB
	mov	word ptr es:[12h], ax	;@054EC
	mov	es, ax	;@054F0
	cmp	byte ptr es:[1Ah], 0FFh	;@054F2
	jne	@@4	;@054F8
	push	es	;@054FA
	mov	ax, 0Eh	;@054FB
	push	ax	;@054FE
	push	word ptr es:[8]	;@054FF
	mov	ax, 3Fh	;@05504
	push	ax	;@05507
	mov	ax, 515Eh	;@05508
	push	ax	;@0550B
	db	9Ah, 90h, 20h, 3Fh, 0	; lcall 0x3f, 0x2090	;@0550C
	pop	es	;@05511
	mov	word ptr es:[12h], 0	;@05512
	jmp	@@9	;@05519
@@4:	pop	ax	;@0551C
	mov	word ptr es:[18h], 4EBBh	;@0551D
	mov	ax, word ptr ds:[1B4h]	;@05524
	mov	dx, word ptr ds:[1B6h]	;@05527
	add	word ptr es:[4], ax	;@0552B
	adc	word ptr es:[6], dx	;@05530
	mov	dx, word ptr es:[8]	;@05535
	add	dx, word ptr es:[0Ah]	;@0553A
	jae	@@5	;@0553F
	mov	dx, word ptr es:[8]	;@05541
	cmp	di, word ptr es:[0Ah]	;@05546
	jae	@@5	;@0554B
	mov	di, word ptr es:[0Ah]	;@0554D
@@5:	cmp	bx, dx	;@05552
	jae	@@6	;@05554
	mov	bx, dx	;@05556
@@6:	push	es	;@05558
	push	bx	;@05559
	push	es	;@0555A
	mov	ax, 0Eh	;@0555B
	push	ax	;@0555E
	push	dx	;@0555F
	mov	ax, 3Fh	;@05560
	push	ax	;@05563
	mov	ax, 515Eh	;@05564
	push	ax	;@05567
	db	9Ah, 90h, 20h, 3Fh, 0	; lcall 0x3f, 0x2090	;@05568
	pop	bx	;@0556D
	pop	es	;@0556E
	or	ax, ax	;@0556F
	je	@@7	;@05571
	mov	ax, 0F000h	;@05573
	db	0EAh, 9Bh, 2, 1Fh, 0	; ljmp 0x1f:0x29b	;@05576
@@7:	push	di	;@0557B
	push	bx	;@0557C
	mov	bx, word ptr es:[0Eh]	;@0557D
	mov	word ptr es:[10h], bx	;@05582
	cmp	word ptr ds:[128h], 0	;@05587
	jne	@@8	;@0558C
	mov	word ptr ds:[128h], bx	;@0558E
	mov	ax, 2	;@05592
	push	es	;@05595
	call	dword ptr ds:[120h]	;@05596
	pop	es	;@0559A
@@8:	call	@@12	;@0559B
	mov	word ptr es:[10h], 0	;@0559E
	pop	bx	;@055A5
	pop	di	;@055A6
@@9:	add	si, 8	;@055A7
	cmp	si, 820h	;@055AA
	jae	@@10	;@055AE
	jmp	@@1	;@055B0
@@10:	xor	ax, ax	;@055B3
	add	bx, 2	;@055B5
	mov	word ptr ds:[1BAh], bx	;@055B8
	or	di, di	;@055BC
	je	@@11	;@055BE
	mov	ax, 317h	;@055C0
	push	ax	;@055C3
	mov	ax, 100h	;@055C4
	push	ax	;@055C7
	push	di	;@055C8
	db	9Ah, 7Bh, 1Dh, 3Fh, 0	; lcall 0x3f, 0x1d7b	;@055C9
@@11:	ret	;@055CE
	db	55h, 8Bh, 0ECh, 1Eh, 2Eh, 8Eh, 1Eh, 0EFh, 'HVW', 8Bh, 4Eh, 0Ch	;@055CF
	db	89h, 0Eh, 0CCh, 1, 8Eh, 0D9h, 8Bh, 36h, 4, 0, 8Bh, 3Eh, 6, 0, 3
	db	76h, 4, 13h, 7Eh, 6, 33h, 0DBh, 8Eh, 0D9h, 8Bh, 0Eh, 12h, 0, 0E3h
	db	19h, 8Eh, 0C1h, 26h, 0A1h, 4, 0, 26h, 8Bh, 16h, 6, 0, 2Bh, 0C6h
	db	1Bh, 0D7h, 79h, 8, 89h, 0Eh, 1Ch, 0, 8Ch, 0DBh, 0EBh, 0DFh, 0Bh
	db	0DBh, 74h, 41h, 8Bh, 36h, 4, 0, 8Bh, 3Eh, 6, 0, 8Eh, 0DBh, 0C7h
	db	6, 1Ch, 0, 0, 0, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 8Bh, 46h, 8, 8Bh, 56h
	db	0Ah, 2Eh, 8Eh, 6, 0F1h, 48h, 26h, 8Bh, 1Eh, 0Eh, 7, 0E8h, 85h
	db	0E6h, 8Bh, 0C3h, 8Eh, 6, 0CCh, 1, 26h, 8Bh, 16h, 4, 0, 26h, 8Bh
	db	0Eh, 6, 0, 2Bh, 0F2h, 1Bh, 0F9h, 0E8h, 93h, 0, 73h, 5, 0B8h, 0FFh
	db	0FFh, 0EBh, 2, 33h, 0C0h, 5Fh, 5Eh, 1Fh, 5Dh, 0C2h, 0Ah, 0, 1Eh
	db	'VW.', 8Eh, 1Eh, 0EFh, 48h, 26h, 8Bh, 3Eh, 0Eh, 0, 26h, 89h, 3Eh
	db	10h, 0, 6, 8Bh, 0DFh, 0E8h, 2Fh, 0E6h, 7, 26h, 8Bh, 0Eh, 0Ah, 0
	db	0E3h, 2Ch, 6, 51h, 26h, 8Bh, 36h, 8, 0, 8Bh, 0DFh, 0E8h, 51h, 0E6h
	db	3, 0C6h, 83h, 0D2h, 0, 2Eh, 8Eh, 6, 0F1h, 48h, 26h, 8Bh, 1Eh, 0Eh
	db	7, 0E8h, 20h, 0E6h, 8Bh, 0C3h, 59h, 7, 33h, 0F6h, 0E8h, 97h, 0
	db	0EBh, 3, 0E8h, 85h, 0, 0E8h, 59h, 2, 6, 26h, 8Bh, 1Eh, 10h, 0
	db	0E8h, 0EFh, 0E5h, 7, 0B8h, 0FFh, 0FFh, 8Bh, 0D8h, 2Eh, 8Eh, 1Eh
	db	0EFh, 48h, 0FFh, 1Eh, 20h, 1, 5Fh, 5Eh, 1Fh, 0C3h, 0B1h, 4, 0D3h
	db	0E8h, 0D3h, 0CAh, 81h, 0E2h, 0, 0F0h, 0Bh, 0C2h, 0C3h, 1Eh, 0B8h
	db	17h, 3, 8Eh, 0D8h, 0E8h, 13h, 1, 1Fh, 0CBh, 50h, 0FFh, 36h, 0C8h
	db	1, 'QR3', 0C0h, 50h, 0E8h, 0ECh, 0FAh, 8Bh, 1Eh, 0C8h, 1, 58h
	db	1Eh, 8Eh, 0D8h, 0EBh, 14h, 53h, 8Ch, 0DBh, 6, 0E8h, 0DCh, 0E5h
	db	5, 0F0h, 0FFh, 83h, 0D2h, 0, 0E8h, 0B4h, 0E5h, 8Eh, 0DBh, 7, 5Bh
	db	0B9h, 0F0h, 0FFh, 0Bh, 0FFh, 75h, 2, 8Bh, 0CEh, 53h, 53h, 1Eh
	db	33h, 0C0h, 50h, 51h, 0E8h, 87h, 0FAh, 5Bh, 72h, 0Bh, 2Bh, 0F0h
	db	83h, 0DFh, 0, 8Bh, 0C6h, 0Bh, 0C7h, 75h, 0CBh, 1Fh, 0C3h, 1Eh
	db	6, 26h, 8Bh, 36h, 8, 0, 26h, 0A1h, 10h, 0, 0EBh, 2, 1Eh, 6, 8Eh
	db	0D8h, 26h, 8Eh, 6, 10h, 0, 0D1h, 0E9h, 0FCh, 0ADh, 8Bh, 0D8h, 26h
	db	8Bh, 3Fh, 1Eh, 0B8h, 77h, 3, 8Eh, 0D8h, 8Bh, 0C7h, 83h, 0E7h, 0F8h
	db	8Bh, 15h, 0A9h, 4, 0, 74h, 21h, 8Eh, 0DAh, 80h, 3Eh, 0, 0, 0CDh
	db	75h, 18h, 26h, 8Bh, 7Fh, 0FEh, 80h, 3Dh, 0EAh, 75h, 0Fh, 8Bh, 45h
	db	1, 26h, 89h, 47h, 0FEh, 8Bh, 55h, 3, 26h, 89h, 17h, 0EBh, 0Bh
	db	26h, 89h, 17h, 0A9h, 1, 0, 74h, 3, 0E8h, 6, 0, 1Fh, 0E2h, 0B9h
	db	7, 1Fh, 0C3h, 51h, 8Eh, 0DAh, 26h, 8Ah, 67h, 0FFh, 8Ah, 0C4h, 25h
	db	7, 0F8h, 80h, 0FCh, 0B8h, 75h, 4Bh, 8Bh, 0C8h, 26h, 8Ah, 67h, 2
	db	8Ah, 0C4h, 25h, 7, 0F8h, 80h, 0FCh, 'Pu;:', 0C1h, 75h, 37h, 8Bh
	db	0D0h, 26h, 8Ah, 67h, 3, 8Ah, 0C4h, 25h, 7, 0F8h, 3Bh, 0C8h, 'u(&'
	db	8Ah, 67h, 6, 8Ah, 0C4h, 25h, 7, 0F8h, 3Bh, 0C2h, 75h, 1Bh, 0BFh
	db	20h, 0, 8Bh, 0Eh, 0Ch, 0, 26h, 8Bh, 47h, 4, 3Bh, 45h, 1, 74h, 7
	db	83h, 0C7h, 5, 0E2h, 0F6h, 0EBh, 6, 26h, 89h, 7Fh, 4, 59h, 0C3h
	db	59h, 0C3h, 26h, 8Bh, 36h, 8, 0, 33h, 0FFh, 26h, 3, 36h, 0Ah, 0
	db	83h, 0D7h, 0, 26h, 8Bh, 16h, 4, 0, 26h, 8Bh, 0Eh, 6, 0, 26h, 0A1h
	db	10h, 0, 0E8h, 0CFh, 0FEh, 72h, 0Bh, 26h, 8Bh, 0Eh, 0Ah, 0, 0E3h
	db	3, 0E8h, 11h, 0FFh, 0F8h, 0C3h, 55h, 8Bh, 0ECh, 0F7h, 0C5h, 1
	db	0, 74h, 8, 0B8h, 1, 0F0h, 0EAh, 9Bh, 2, 1Fh, 0, 'PSQRVW', 1Eh
	db	6, 0B8h, 17h, 3, 8Eh, 0D8h, 0FBh, 0C4h, 5Eh, 2, 26h, 0FFh, 37h
	db	83h, 6Eh, 2, 2, 75h, 5, 0E8h, 3Bh, 0, 0EBh, 18h, 83h, 0C5h, 6
	db	8Bh, 46h, 0, 87h, 46h, 0FAh, 89h, 46h, 0, 0E8h, 2Ah, 0, 8Bh, 46h
	db	0, 87h, 46h, 0FAh, 89h, 46h, 0, 5Bh, 26h, 0A0h, 1Ah, 0, 24h, 8
	db	26h, 80h, 26h, 1Ah, 0, 0F7h, 98h, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 0FFh
	db	1Eh, 20h, 1, 7, 1Fh, '_^ZY[X]', 0CFh, 8Ch, 0C0h, 35h, 8, 0, 8Eh
	db	0C0h, 26h, 83h, 3Eh, 10h, 0, 0, 74h, 2, 0EBh, 6, 26h, 80h, 0Eh
	db	1Ah, 0, 8, 6, 6, 0B8h, 0Eh, 0, 50h, 9Ah, 0E6h, 47h, 3Fh, 0, 7
	db	0Bh, 0C0h, 75h, 0Ch, 26h, 0A1h, 0Eh, 0, 26h, 0A3h, 10h, 0, 0E8h
	db	4Bh, 0, 0C3h, 0B8h, 4, 0F0h, 0EAh, 9Bh, 2, 1Fh, 0, 55h, 8Bh, 0ECh
	db	1Eh, 2Eh, 8Eh, 1Eh, 0EFh, 'HVW', 8Eh, 46h, 6, 26h, 83h, 3Eh, 10h
	db	0, 0, 74h, 9, 26h, 81h, 3Eh, 0Eh, 0, 0, 10h, 73h, 1Ch, 0E8h, 0A3h
	db	0FFh, 0BBh, 0FFh, 0FFh, 26h, 0A0h, 1Ah, 0, 24h, 8, 26h, 80h, 26h
	db	1Ah, 0, 0F7h, 98h, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 0FFh, 1Eh, 20h, 1
	db	5Fh, 5Eh, 1Fh, 5Dh, 0CAh, 2, 0
@@12:	cmp	word ptr es:[0Ch], 0	;@0590F
	jne	@@13	;@05915
	ret	;@05917
@@13:	cmp	byte ptr es:[20h], 0EAh	;@05918
	je	@@16	;@0591E
	mov	cx, word ptr es:[2]	;@05920
	jcxz	@@14	;@05925
	mov	ax, word ptr es:[10h]	;@05927
	mov	dx, es	;@0592B
	call	@@17	;@0592D
@@14:	mov	bx, word ptr es:[10h]	;@05930
	mov	cx, word ptr es:[0Ch]	;@05935
	mov	di, 20h	;@0593A
	cld	;@0593D
@@15:	mov	dx, word ptr es:[di+2]	;@0593E
	mov	al, 0EAh	;@05942
	stosb	;@05944
	mov	ax, dx	;@05945
	stosw	;@05947
	mov	ax, bx	;@05948
	stosw	;@0594A
	loop	@@15	;@0594B
@@16:	ret	;@0594D
	db	26h, 80h, 3Eh, 20h, 0, 0CDh, 74h, 2Ah, 8Ch, 0C0h, 26h, 8Bh, 16h	;@0594E
	db	10h, 0, 33h, 0C9h, 0E8h, 1Fh, 0, 26h, 89h, 0Eh, 2, 0, 26h, 8Bh
	db	0Eh, 0Ch, 0, 0BFh, 20h, 0, 0FCh, 26h, 8Bh, 55h, 1, 0A1h, 0B0h
	db	1, 0ABh, 8Bh, 0C2h, 0ABh, 32h, 0C0h, 0AAh, 0E2h, 0F0h, 0C3h
@@17:	call	@@19	;@05981
	or	bx, bx	;@05984
	je	@@18	;@05986
	xchg	word ptr ss:[bx+2], cx	;@05988
@@18:	ret	;@0598C
@@19:	xor	bx, bx	;@0598D
	push	cx	;@0598F
	push	bp	;@05990
	jmp	short @@21	;@05991
@@20:	shl	cx, 1	;@05993
	mov	bp, cx	;@05995
@@21:	mov	cx, word ptr [bp]	;@05997
	shr	cx, 1	;@0599A
	je	@@22	;@0599C
	jb	@@20	;@0599E
	cmp	dx, word ptr [bp+4]	;@059A0
	jne	@@20	;@059A3
	mov	word ptr [bp+4], ax	;@059A5
	or	bx, bx	;@059A8
	jne	@@20	;@059AA
	mov	bx, bp	;@059AC
	jmp	@@20	;@059AE
@@22:	pop	bp	;@059B0
	pop	cx	;@059B1
	ret	;@059B2
	db	0A1h, 0CCh, 1, 0Bh, 0C0h, 74h, 0Ch, 8Eh, 0C0h, 26h, 0A1h, 10h	;@059B3
	db	0, 2Bh, 6, 0C0h, 1, 73h, 8, 0A1h, 0C6h, 1, 2Bh, 6, 0C0h, 1, 0F9h
	db	0C3h, 26h, 0A1h, 8, 0, 5, 11h, 0, 0B1h, 4, 0D3h, 0E8h, 0C3h, 0B1h
	db	4, 26h, 0A1h, 8, 0, 5, 11h, 0, 0D3h, 0E8h, 26h, 8Bh, 16h, 0Ah
	db	0, 83h, 0C2h, 0Fh, 0D3h, 0EAh, 3, 0D0h, 0C3h, 1Eh, 6, 2Eh, 8Eh
	db	1Eh, 0F1h, 48h, 3Bh, 6, 0C2h, '`r<;', 6, 0BEh, '`s6.', 8Eh, 1Eh
	db	0EFh, 48h, 0EBh, 11h, 2Eh, 8Eh, 1Eh, 0EFh, 48h, 3Bh, 6, 0C4h, 1
	db	'r$;', 6, 0C6h, 1, 73h, 1Eh, 50h, 50h, 9Ah, 'I2?', 0, 58h, 8Eh
	db	0C2h, 8Bh, 1Eh, 0B0h, 1, 26h, 3Bh, 1Eh, 0, 0, 75h, 9, 26h, 3Bh
	db	6, 10h, 0, 8Ch, 0C0h, 74h, 3, 33h, 0C0h, 0F9h, 7, 1Fh, 0CBh
C45_SETJUMP:	push	bp	;@05A42
	mov	bp, sp	;@05A43
	push	di	;@05A45
	push	di	;@05A46
	les	di, dword ptr [bp+6]	;@05A47
	cld	;@05A4A
	mov	ax, bp	;@05A4B
	stosw	;@05A4D
	mov	ax, word ptr [bp]	;@05A4E
	stosw	;@05A51
	mov	ax, word ptr [bp+2]	;@05A52
	stosw	;@05A55
	mov	ax, word ptr [bp+4]	;@05A56
	stosw	;@05A59
	pop	ax	;@05A5A
	stosw	;@05A5B
	mov	ax, ds	;@05A5C
	stosw	;@05A5E
	mov	ax, si	;@05A5F
	stosw	;@05A61
	xor	ax, ax	;@05A62
	pop	di	;@05A64
	pop	bp	;@05A65
	retf	4	;@05A66
	db	55h, 8Bh, 0ECh, 8Bh, 7Eh, 6, 0C4h, 76h, 8, 0FCh, 26h, 0ADh, 95h	;@05A69
	db	26h, 0ADh, 89h, 46h, 0, 26h, 0ADh, 89h, 46h, 2, 26h, 0ADh, 89h
	db	46h, 4, 8Bh, 0D7h, 26h, 0ADh, 97h, 26h, 0ADh, 8Eh, 0D8h, 26h, 0ADh
	db	96h, 83h, 0FAh, 1, 83h, 0D2h, 0, 92h, 8Bh, 0E5h, 5Dh, 0CAh, 4
	db	0, 55h, 8Bh, 0ECh, 83h, 0ECh, 2, 1Eh, 2Eh, 8Eh, 1Eh, 0EFh, 'HVW'
	db	8Eh, 46h, 0Ah, 8Bh, 5Eh, 0Ch, 4Bh, 0D1h, 0E3h, 0FFh, 97h, 6, 1
	db	'_^3', 0C0h, 1Fh, 8Bh, 0E5h, 5Dh, 0CAh, 8, 0, 26h, 0A1h, 0Eh, 0
	db	26h, 0A3h, 10h, 0, 0FFh, 36h, 0C8h, 1, 26h, 0FFh, 36h, 6, 0, 26h
	db	0FFh, 36h, 4, 0, 33h, 0C0h, 50h, 0E8h, 3, 0F7h, 26h, 8Bh, 0Eh
	db	8, 0, 26h, 3, 0Eh, 0Ah, 0, 73h, 5, 26h, 8Bh, 0Eh, 8, 0, 9Ch, 0FFh
	db	36h, 0C8h, 1, 26h, 8Bh, 1Eh, 10h, 0, 53h, 6, 0E8h, 0AEh, 0E1h
	db	7, 33h, 0C0h, 50h, 51h, 0E8h, 0A7h, 0F6h, 'rD&', 8Bh, 0Eh, 0Ah
	db	0, 9Dh, 0E3h, 33h, 72h, 14h, 0E8h, 21h, 0FCh, 6, 6, 0B8h, 0Eh
	db	0, 50h, 26h, 0FFh, 36h, 8, 0, 0E8h, 0D9h, 0C2h, 7, 0EBh, 1Dh, 0FFh
	db	36h, 0C8h, 1, 0FFh, 36h, 0, 1, 33h, 0C0h, 50h, 26h, 0FFh, 36h
	db	0Ah, 0, 0E8h, 74h, 0F6h, 72h, 11h, 0A1h, 0, 1, 33h, 0F6h, 0E8h
	db	0, 0FCh, 26h, 8Bh, 1Eh, 10h, 0, 0E8h, 61h, 0E1h, 0C3h, 0B8h, 2
	db	0F0h, 0EAh, 9Bh, 2, 1Fh, 0, 83h, 7Eh, 6, 0, 74h, 9, 6, 0B8h, 1
	db	0, 0FFh, 1Eh, 20h, 1, 7, 26h, 0C7h, 6, 10h, 0, 0, 0, 0C3h, 26h
	db	0A1h, 0Eh, 0, 26h, 0A3h, 10h, 0, 0C3h, 8Bh, 46h, 6, 26h, 80h, 3Eh
	db	20h, 0, 0CDh, 74h, 17h, 26h, 8Bh, 16h, 10h, 0, 0E8h, 4, 0FEh, 26h
	db	8Bh, 0Eh, 0Ch, 0, 0BFh, 23h, 0, 0FCh, 0ABh, 83h, 0C7h, 3, 0E2h
	db	0FAh, 26h, 0A3h, 10h, 0, 0C3h
OVR_IMAGE_SIZE:	push	bp	;@05B9D
	mov	bp, sp	;@05B9E
	mov	es, word ptr [bp+6]	;@05BA0
	mov	ax, word ptr es:[8]	;@05BA3
	add	ax, word ptr es:[0Ah]	;@05BA7
	jae	@@1	;@05BAC
	mov	ax, word ptr es:[8]	;@05BAE
@@1:	pop	bp	;@05BB2
	ret	4	;@05BB3
OVR_ENSURE_IMAGE_LOADED:	push	bp	;@05BB6
	mov	bp, sp	;@05BB7
	sub	sp, 2	;@05BB9
	push	bx	;@05BBC
	push	cx	;@05BBD
	push	si	;@05BBE
	push	di	;@05BBF
	push	ds	;@05BC0
	les	bx, dword ptr [bp+6]	;@05BC1
	mov	dx, es	;@05BC4
	xor	dl, byte ptr ds:[1Ah]	;@05BC6
	mov	es, dx	;@05BCA
	push	bx	;@05BCC
	mov	dx, word ptr es:[10h]	;@05BCD
	mov	word ptr [bp-2], 0	;@05BD2
	or	dx, dx	;@05BD7
	jne	@@3	;@05BD9
	mov	ax, word ptr [bp+4]	;@05BDB
	push	ds	;@05BDE
	push	es	;@05BDF
	db	9Ah, 0B3h, 50h, 3Fh, 0	; lcall 0x3f, 0x50b3	;@05BE0
	pop	es	;@05BE5
	pop	ds	;@05BE6
	jb	@@1	;@05BE7
	push	ds	;@05BE9
	push	es	;@05BEA
	mov	word ptr [bp-2], ax	;@05BEB
	push	ax	;@05BEE
	mov	ax, 0Eh	;@05BEF
	push	ax	;@05BF2
	db	9Ah, 0CBh, 22h, 3Fh, 0	; lcall 0x3f, 0x22cb	;@05BF3
	pop	es	;@05BF8
	pop	ds	;@05BF9
@@1:	push	es	;@05BFA
	push	es	;@05BFB
	mov	ax, 10h	;@05BFC
	push	ax	;@05BFF
	push	es	;@05C00
	push	ax	;@05C01
	mov	ax, word ptr es:[8]	;@05C02
	add	ax, word ptr es:[0Ah]	;@05C06
	add	ax, 10h	;@05C0B
	push	ax	;@05C0E
	db	9Ah, 7Bh, 1Dh, 3Fh, 0	; lcall 0x3f, 0x1d7b	;@05C0F
	db	9Ah, 0D8h, 47h, 3Fh, 0	; lcall 0x3f, 0x47d8	;@05C14
	mov	ax, word ptr [bp-2]	;@05C19
	or	ax, ax	;@05C1C
	je	@@2	;@05C1E
	push	ds	;@05C20
	push	es	;@05C21
	push	ax	;@05C22
	mov	ax, 0Eh	;@05C23
	push	ax	;@05C26
	db	9Ah, 0FEh, 22h, 3Fh, 0	; lcall 0x3f, 0x22fe	;@05C27
	pop	es	;@05C2C
	pop	ds	;@05C2D
@@2:	pop	es	;@05C2E
	db	9Ah, 9Fh, 4Dh, 3Fh, 0	; lcall 0x3f, 0x4d9f	;@05C2F
@@3:	mov	dx, word ptr es:[10h]	;@05C34
	cmp	dx, 1000h	;@05C39
	ja	@@6	;@05C3D
	mov	ax, word ptr [bp+4]	;@05C3F
	push	ds	;@05C42
	push	es	;@05C43
	db	9Ah, 0B3h, 50h, 3Fh, 0	; lcall 0x3f, 0x50b3	;@05C44
	pop	es	;@05C49
	pop	ds	;@05C4A
	jb	@@4	;@05C4B
	push	ds	;@05C4D
	push	es	;@05C4E
	mov	word ptr [bp-2], ax	;@05C4F
	push	ax	;@05C52
	mov	ax, 0Eh	;@05C53
	push	ax	;@05C56
	db	9Ah, 0CBh, 22h, 3Fh, 0	; lcall 0x3f, 0x22cb	;@05C57
	pop	es	;@05C5C
	pop	ds	;@05C5D
@@4:	push	es	;@05C5E
	push	es	;@05C5F
	mov	ax, 10h	;@05C60
	push	ax	;@05C63
	db	9Ah, 0E6h, 47h, 3Fh, 0	; lcall 0x3f, 0x47e6	;@05C64
	pop	es	;@05C69
	mov	ax, word ptr [bp-2]	;@05C6A
	or	ax, ax	;@05C6D
	je	@@5	;@05C6F
	push	ds	;@05C71
	push	es	;@05C72
	push	ax	;@05C73
	mov	ax, 0Eh	;@05C74
	push	ax	;@05C77
	db	9Ah, 0FEh, 22h, 3Fh, 0	; lcall 0x3f, 0x22fe	;@05C78
	pop	es	;@05C7D
	pop	ds	;@05C7E
@@5:	mov	dx, word ptr es:[10h]	;@05C7F
@@6:	pop	ax	;@05C84
	pop	ds	;@05C85
	pop	di	;@05C86
	pop	si	;@05C87
	pop	cx	;@05C88
	pop	bx	;@05C89
	mov	sp, bp	;@05C8A
	pop	bp	;@05C8C
	retf	4	;@05C8D
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 4, 0B8h, 0Fh, 6, 50h, 0B8h, 0, 0, 50h	;@05C90
	db	9Ah, 6, 0, 4Fh, 0, 89h, 56h, 0FEh, 89h, 46h, 0FCh, 8Bh, 56h, 0FEh
	db	8Bh, 46h, 6, 0D1h
Y00A40	ends

Y05CB0	segment para public 'CODE'
	assume	cs:Y05CB0
	db	0E0h, 0C4h, 5Eh, 0FCh, 3, 0D8h, 26h, 8Bh, 7, 8Bh, 0E5h, 5Dh, 0CAh	;@05CB0
	db	2, 0
L05CBF:	inc	bp	;@05CBF
	push	bp	;@05CC0
	mov	bp, sp	;@05CC1
	push	word ptr [bp+0Ch]	;@05CC3
	push	word ptr [bp+0Ah]	;@05CC6
	db	9Ah, 0Dh, 0, 9Fh, 2	; lcall 0x29f, 0xd	;@05CC9
	pop	cx	;@05CCE
	pop	cx	;@05CCF
	cmp	word ptr ds:[68E0h], 0	;@05CD0
	je	@@1	;@05CD5
	push	word ptr ds:[7A62h]	;@05CD7
	push	word ptr ds:[68E0h]	;@05CDB
	push	ds	;@05CDF
	mov	ax, 1108h	;@05CE0
	push	ax	;@05CE3
	db	9Ah, 0Dh, 0, 9Fh, 2	; lcall 0x29f, 0xd	;@05CE4
	add	sp, 8	;@05CE9
@@1:	cmp	word ptr ds:[68DAh], 0	;@05CEC
	je	@@2	;@05CF1
	xor	ax, ax	;@05CF3
	push	ax	;@05CF5
	push	word ptr ds:[68DAh]	;@05CF6
	push	ds	;@05CFA
	mov	ax, 110Ch	;@05CFB
	push	ax	;@05CFE
	db	9Ah, 0Dh, 0, 9Fh, 2	; lcall 0x29f, 0xd	;@05CFF
	add	sp, 8	;@05D04
@@2:	push	ds	;@05D07
	mov	ax, 1111h	;@05D08
	push	ax	;@05D0B
	db	9Ah, 0Dh, 0, 9Fh, 2	; lcall 0x29f, 0xd	;@05D0C
	pop	cx	;@05D11
	pop	cx	;@05D12
	push	word ptr [bp+4]	;@05D13
	push	cs	;@05D16
	db	0E8h, 76h, 0FFh	; call L15C90	;@05D17
	db	52h	; push dx	;@05D1A
	push	ax	;@05D1B
	push	word ptr [bp+8]	;@05D1C
	push	word ptr [bp+6]	;@05D1F
	db	9Ah, 33h, 0, 9Fh, 2	; lcall 0x29f, 0x33	;@05D22
	mov	ax, word ptr ds:[68DCh]	;@05D27
	or	ax, word ptr ds:[68DEh]	;@05D2A
	je	@@3	;@05D2E
	push	word ptr ds:[68DEh]	;@05D30
	push	word ptr ds:[68DCh]	;@05D34
	push	ds	;@05D38
	mov	ax, 10E8h	;@05D39
	push	ax	;@05D3C
	db	9Ah, 0Dh, 0, 9Fh, 2	; lcall 0x29f, 0xd	;@05D3D
	add	sp, 8	;@05D42
@@3:	push	ds	;@05D45
	mov	ax, 1114h	;@05D46
	push	ax	;@05D49
	db	9Ah, 0Dh, 0, 9Fh, 2	; lcall 0x29f, 0xd	;@05D4A
	pop	cx	;@05D4F
	pop	cx	;@05D50
	pop	bp	;@05D51
	dec	bp	;@05D52
	ret	0Ah	;@05D53
_REPORT_FATAL:	push	bp	;@05D56
	mov	bp, sp	;@05D57
	sub	sp, 4	;@05D59
	push	si	;@05D5C
	mov	si, word ptr [bp+6]	;@05D5D
	lea	ax, [bp+8]	;@05D60
	mov	word ptr [bp-2], ss	;@05D63
	mov	word ptr [bp-4], ax	;@05D66
	push	ds	;@05D69
	cmp	si, 4	;@05D6A
	jge	@@1	;@05D6D
	mov	ax, 10E2h	;@05D6F
	jmp	short @@2	;@05D72
@@1:	mov	ax, 1100h	;@05D74
@@2:	push	ax	;@05D77
	push	word ptr [bp-2]	;@05D78
	push	word ptr [bp-4]	;@05D7B
	push	si	;@05D7E
	call	L05CBF	;@05D7F
	inc	word ptr ds:[8860h]	;@05D82
	inc	word ptr ds:[1106h]	;@05D86
	push	ds	;@05D8A
	mov	ax, 7AAAh	;@05D8B
	push	ax	;@05D8E
	db	0B8h	; mov ax, 2	;@05D8F
Y05CB0	ends

Y05D90	segment para public 'CODE'
	assume	cs:Y05D90
	db	2, 0, 50h, 9Ah, ')Q?', 0, 5Eh, 8Bh, 0E5h, 5Dh, 0CBh	;@05D90
_REPORT_ERROR:	push	bp	;@05D9D
	mov	bp, sp	;@05D9E
	sub	sp, 4	;@05DA0
	lea	ax, [bp+8]	;@05DA3
	mov	word ptr [bp-2], ss	;@05DA6
	mov	word ptr [bp-4], ax	;@05DA9
	push	ds	;@05DAC
	mov	ax, 1100h	;@05DAD
	push	ax	;@05DB0
	push	word ptr [bp-2]	;@05DB1
	push	word ptr [bp-4]	;@05DB4
	push	word ptr [bp+6]	;@05DB7
	db	0E8h, 2, 0FFh	; call L15CBE+1	;@05DBA
	db	0FFh, 6, 60h, 88h	; inc word ptr ds:[8860h]	;@05DBD
	inc	word ptr ds:[1106h]	;@05DC1
	cmp	byte ptr ds:[1719h], 0	;@05DC5
	db	74h, 2Fh	; je @@1	;@05DCA
	mov	al, byte ptr ds:[1719h]	;@05DCC
	mov	ah, 0	;@05DCF
	cmp	ax, word ptr ds:[8860h]	;@05DD1
	db	7Fh, 24h	; jg @@1	;@05DD5
	push	ds	;@05DD7
	mov	ax, 1100h	;@05DD8
	push	ax	;@05DDB
	push	word ptr [bp-2]	;@05DDC
	push	word ptr [bp-4]	;@05DDF
	mov	ax, 3Dh	;@05DE2
	push	ax	;@05DE5
	db	0E8h, 0D6h, 0FEh	; call L15CBE+1	;@05DE6
	db	0FFh, 6, 60h, 88h	; inc word ptr ds:[8860h]	;@05DE9
	push	ds	;@05DED
	mov	ax, 7AAAh	;@05DEE
	push	ax	;@05DF1
	mov	ax, 2	;@05DF2
	push	ax	;@05DF5
	db	9Ah, 29h, 51h, 3Fh, 0	; lcall 0x3f, 0x5129	;@05DF6
@@1:	mov	sp, bp	;@05DFB
	pop	bp	;@05DFD
	retf	;@05DFE
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 4, 56h, 8Bh, 76h, 6, 8Ah, 84h, 9, 65h	;@05DFF
	db	98h, 0Bh, 0C0h, 74h, 58h, 8Dh, 46h, 8, 8Ch, 56h, 0FEh, 89h, 46h
	db	0FCh, 1Eh, 0B8h, 0F8h, 10h, 50h, 0FFh, 76h, 0FEh, 0FFh, 76h, 0FCh
	db	56h, 0E8h, 95h, 0FEh, 0FFh, 6, 6, 11h, 80h, 3Eh, 1Ah, 17h, 0, 74h
	db	35h, 0A0h, 1Ah, 17h, 0B4h, 0, 8Bh, 16h, 6, 11h, 2Bh, 16h, 60h
	db	88h, 3Bh, 0C2h, 7Fh, 24h, 1Eh, 0B8h, 0, 11h, 50h, 0FFh, 76h, 0FEh
	db	0FFh, 76h, 0FCh, 0B8h, 3Dh, 0, 50h, 0E8h, 67h, 0FEh, 0FFh, 6, 60h
	db	88h, 1Eh, 0B8h, 0AAh, 7Ah, 50h, 0B8h, 2, 0, 50h, 9Ah, ')Q?', 0
	db	5Eh, 8Bh, 0E5h, 5Dh, 0CBh
INIT_MEMORY_MANAGER:	push	bp	;@05E6F
	mov	bp, sp	;@05E70
	push	si	;@05E72
	cmp	byte ptr ds:[1Ah], 8	;@05E73
	jne	@@1	;@05E78
	mov	si, word ptr ds:[1Bh]	;@05E7A
	jmp	short @@2	;@05E7E
@@1:	mov	ax, word ptr ds:[4]	;@05E80
	add	ax, word ptr ds:[5CC4h]	;@05E83
	mov	si, ax	;@05E87
@@2:	push	word ptr ds:[4]	;@05E89
	push	si	;@05E8D
	mov	ax, 0FEh	;@05E8E
	push	ax	;@05E91
	mov	ax, 6Fh	;@05E92
	push	ax	;@05E95
	mov	ax, 12Eh	;@05E96
	push	ax	;@05E99
	xor	ax, ax	;@05E9A
	xor	dx, dx	;@05E9C
	push	ax	;@05E9E
	push	dx	;@05E9F
	db	9Ah, 0E9h, 2Eh, 3Fh, 0	; lcall 0x3f, 0x2ee9	;@05EA0
	or	ax, ax	;@05EA5
	je	@@3	;@05EA7
	mov	ax, 6	;@05EA9
	push	ax	;@05EAC
	db	9Ah, 0Dh, 1, 5Fh, 0	; lcall 0x5f, 0x10d	;@05EAD
	pop	cx	;@05EB2
	mov	ax, 1	;@05EB3
	push	ax	;@05EB6
	db	9Ah, 9Fh, 0, 2Fh, 0	; lcall 0x2f, 0x9f	;@05EB7
@@3:	mov	ax, 7CFh	;@05EBC
	push	ax	;@05EBF
	mov	ax, 7EFh	;@05EC0
	push	ax	;@05EC3
	db	9Ah, 85h, 2Ah, 3Fh, 0	; lcall 0x3f, 0x2a85	;@05EC4
	mov	al, 42h	;@05EC9
	push	ax	;@05ECB
	db	9Ah, 0EEh, 2Dh, 3Fh, 0	; lcall 0x3f, 0x2dee	;@05ECC
	push	ds	;@05ED1
	mov	ax, 852Ch	;@05ED2
	push	ax	;@05ED5
	xor	ax, ax	;@05ED6
	push	ax	;@05ED8
	db	9Ah, 7Bh, 1Dh, 3Fh, 0	; lcall 0x3f, 0x1d7b	;@05ED9
	push	ds	;@05EDE
	mov	ax, 852Ch	;@05EDF
	push	ax	;@05EE2
	db	9Ah, 0EDh, 47h, 3Fh, 0	; lcall 0x3f, 0x47ed	;@05EE3
	pop	si	;@05EE8
	pop	bp	;@05EE9
	retf	;@05EEA
	db	55h, 8Bh, 0ECh, 83h, 3Eh, 8Ah, 17h, 0, 7Ch, 0Dh, 33h, 0C0h, 50h	;@05EEB
	db	50h, 0FFh, 36h, 8Ah, 17h, 9Ah, 0CEh, 40h, 3Fh, 0, 83h, 3Eh, 8Eh
	db	17h, 0, 7Ch, 1Eh, 75h, 7, 83h, 3Eh, 8Ch, 17h, 0, 72h, 15h, 0FFh
	db	36h, 8Eh, 17h, 0FFh, 36h, 8Ch, 17h, 0FFh, 36h, 92h, 17h, 0FFh
	db	36h, 90h, 17h, 9Ah, '+B?', 0, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 9Ah, 83h
	db	1Bh, 3Fh, 0, 50h, 0E8h, 9Dh, 0, 5Dh, 0CBh
RESTORE_MEMORY_AFTER_EXEC:	push	bp	;@05F37
	mov	bp, sp	;@05F38
	push	si	;@05F3A
	mov	ax, 0FFFFh	;@05F3B
	push	ax	;@05F3E
	db	0E8h, 90h, 0	; call SET_PROGRAM_TOP	;@05F3F
	mov	si, ax	;@05F42
	push	si	;@05F44
	db	0E8h, 8Ah, 0	; call SET_PROGRAM_TOP	;@05F45
	mov	si, ax	;@05F48
	push	si	;@05F4A
	db	9Ah, 0F1h, 1Ch, 3Fh, 0	; lcall 0x3f, 0x1cf1	;@05F4B
	pop	si	;@05F50
	pop	bp	;@05F51
	retf	;@05F52
	db	55h, 8Bh, 0ECh, 0A1h, 30h, 85h, 0A3h, 2Ah, 85h, 5Dh, 0CBh, 55h	;@05F53
	db	8Bh
Y05D90	ends

Y05F60	segment para public 'CODE'
	assume	cs:Y05F60
	db	0ECh, 0C7h, 6, 32h, 85h, 0, 0, 0A1h, 2Ah, 85h, 0A3h, 30h, 85h	;@05F60
	db	5Dh, 0CBh, 55h, 8Bh, 0ECh, 56h, 8Bh, 76h, 6, 46h, 83h, 0E6h, 0FEh
	db	1Eh, 0B8h, 2Ch, 85h, 50h, 56h, 9Ah, 2Fh, 0, 0DFh, 7, 8Bh, 16h
	db	2Ch, 85h, 5Eh, 5Dh, 0CAh, 2, 0, 55h, 8Bh, 0ECh, 1Eh, 0B8h, 'NzP'
	db	9Ah, 8Ah, 1Eh, 3Fh, 0, 1Eh, 0B8h, 'VzP', 9Ah, 8Ah, 1Eh, 3Fh, 0
	db	83h, 3Eh, 4, 15h, 0, 75h, 1Ah, 0C6h, 6, 19h, 17h, 0, 0B8h, 6, 0
	db	50h, 9Ah, 0Dh, 1, 5Fh, 0, 59h, 0B8h, 1, 0, 50h, 9Ah, 9Fh, 0, 2Fh
	db	0, 0EBh, 0Ah, 0B8h, 6, 0, 50h, 9Ah, 0C6h, 0, 5Fh, 0, 59h, 5Dh
	db	0CBh
SET_PROGRAM_TOP:	inc	bp	;@05FD2
	push	bp	;@05FD3
	mov	bp, sp	;@05FD4
	cmp	byte ptr ds:[1Ah], 8	;@05FD6
	je	@@2	;@05FDB
	mov	es, word ptr ds:[16h]	;@05FDD
	mov	ax, word ptr [bp+4]	;@05FE1
	sub	ax, word ptr ds:[16h]	;@05FE4
	mov	bx, ax	;@05FE8
	mov	ah, 4Ah	;@05FEA
	int	21h	;@05FEC
	jae	@@1	;@05FEE
	mov	ax, bx	;@05FF0
	add	ax, word ptr ds:[16h]	;@05FF2
	jmp	short @@4	;@05FF6
@@1:	jmp	short @@3	;@05FF8
@@2:	mov	ax, word ptr [bp+4]	;@05FFA
	mov	dx, word ptr ds:[1Dh]	;@05FFD
	sub	ax, dx	;@06001
	xor	dx, dx	;@06003
	mov	cx, 10h	;@06005
	mul	cx	;@06008
	mov	cx, dx	;@0600A
	mov	dx, ax	;@0600C
	mov	bx, word ptr ds:[1Bh]	;@0600E
	mov	ax, 0E905h	;@06012
	int	21h	;@06015
	jae	@@3	;@06017
	shr	cx, 1	;@06019
	rcr	dx, 1	;@0601B
	shr	cx, 1	;@0601D
	rcr	dx, 1	;@0601F
	shr	cx, 1	;@06021
	rcr	dx, 1	;@06023
	shr	cx, 1	;@06025
	rcr	dx, 1	;@06027
	mov	ax, dx	;@06029
	jmp	short @@4	;@0602B
@@3:	xor	ax, ax	;@0602D
@@4:	pop	bp	;@0602F
	dec	bp	;@06030
	ret	2	;@06031
	db	55h, 8Bh, 0ECh, 4Ch, 4Ch, 0FFh, 76h, 8, 0FFh, 76h, 6, 33h, 0C0h	;@06034
	db	50h, 9Ah, 4, 0, 8Fh, 1, 0A3h, 1Ah, 39h, 9Ah, 2, 2Eh, 3Fh, 0, 0B4h
	db	0, 89h, 46h, 0FEh, 0A0h, 5Ch, 88h, 50h, 9Ah, 0EEh, 2Dh, 3Fh, 0
	db	1Eh, 0B8h, 5Eh, 88h, 50h, 0B8h, 0, 10h, 50h, 9Ah, 7Bh, 1Dh, 3Fh
	db	0, 8Ah, 46h, 0FEh, 50h, 9Ah, 0EEh, 2Dh, 3Fh, 0, 0C7h, 6, 5Ah, 88h
	db	0, 0, 0A1h, 1Ah, 39h, 8Bh, 0E5h, 5Dh, 0CAh, 4, 0
BCC_OUTPUT_STRING:	push	bp	;@06083
	mov	bp, sp	;@06084
	jmp	short @@2	;@06086
@@1:	les	bx, dword ptr [bp+6]	;@06088
	inc	word ptr [bp+6]	;@0608B
	mov	al, byte ptr es:[bx]	;@0608E
	push	ax	;@06091
	db	9Ah, 74h, 0, 7Fh, 0	; lcall 0x7f, 0x74	;@06092
@@2:	les	bx, dword ptr [bp+6]	;@06097
	cmp	byte ptr es:[bx], 0	;@0609A
	jne	@@1	;@0609E
	pop	bp	;@060A0
	retf	4	;@060A1
	db	55h, 8Bh, 0ECh, 8Eh, 6, 5Eh, 88h, 8Bh, 1Eh, 5Ah, 88h, 8Ah, 46h	;@060A4
	db	6, 26h, 88h, 7, 0FFh, 6, 5Ah, 88h, 81h, 3Eh, 5Ah, 88h, 0, 10h
	db	72h, 30h, 0FFh, 36h, 1Ah, 39h, 0FFh, 36h, 5Eh, 88h, 33h, 0C0h
	db	50h, 0B8h, 0, 10h, 50h, 9Ah, 0Dh, 0, 8Fh, 2, 3Dh, 0, 10h, 74h
	db	11h, 0C7h, 6, 5Ah, 88h, 0, 0, 0B8h, 7, 0, 50h, 9Ah, 0C6h, 0, 5Fh
	db	0, 44h, 44h, 0C7h, 6, 5Ah, 88h, 0, 0, 5Dh, 0CAh, 2, 0, 55h, 8Bh
	db	0ECh, 56h, 83h, 3Eh, 1Ah, 39h, 0, 7Ch, 56h, 83h, 3Eh, 5Ah, 88h
	db	0, 74h, 25h, 0FFh, 36h, 1Ah, 39h, 0FFh, 36h, 5Eh, 88h, 33h, 0C0h
	db	50h, 0FFh, 36h, 5Ah, 88h, 9Ah, 0Dh, 0, 8Fh, 2, 3Bh, 6, 5Ah, 88h
	db	74h, 5, 0B8h, 1, 0, 0EBh, 2, 33h, 0C0h, 8Bh, 0F0h, 0EBh, 2, 33h
	db	0F6h, 1Eh, 0B8h
Y05F60	ends

Y06130	segment para public 'CODE'
	assume	cs:Y06130
	db	5Eh, 88h, 50h, 9Ah, 8Ah, 1Eh, 3Fh, 0, 0FFh, 36h, 1Ah, 39h, 9Ah	;@06130
	db	6, 0, 7Fh, 1, 0C7h, 6, 1Ah, 39h, 0FFh, 0FFh, 0Bh, 0F6h, 74h, 0Bh
	db	0B8h, 7, 0, 50h, 9Ah, 0C6h, 0, 5Fh, 0, 'DD^]', 0CBh, 55h, 8Bh
	db	0ECh, 83h, 3Eh, 1Ah, 39h, 0, 7Ch, 26h, 0FFh, 36h, 1Ah, 39h, 9Ah
	db	6, 0, 7Fh, 1, 1Eh, 0B8h, 5Eh, 88h, 50h, 9Ah, 8Ah, 1Eh, 3Fh, 0
	db	0C7h, 6, 1Ah, 39h, 0FFh, 0FFh, 0FFh, '6bz', 0FFh, 36h, 62h, 88h
	db	9Ah, 7, 0, 7Fh, 2, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 83h, 0ECh, 1Ch, 56h
	db	57h, 8Bh, 76h, 6, 8Eh, 6, 0A2h, 83h, 26h, 83h, '<5u', 7, 56h, 0E8h
	db	14h, 11h, 0E9h, 0A5h, 10h, 8Eh, 6, 0A2h, 83h, 26h, 83h, 3Ch, 7
	db	'~i&', 83h, 3Ch, 2Dh, 7Fh, 63h, 26h, 80h, 7Ch, 6, 0, '},&', 0FFh
	db	74h, 0Ah, 0B8h, 1, 0, 50h, 9Ah, 34h, 0, 5Fh, 9, 89h, 56h, 0FAh
	db	89h, 46h, 0F8h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h, 0Ch, 0B8h, 1
	db	0, 50h, 9Ah, 34h, 0, 5Fh, 9, 89h, 56h, 0F6h, 89h, 46h, 0F4h, 0EBh
	db	53h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h, 0Ch, 0B8h, 1, 0, 50h, 9Ah
	db	34h, 0, 5Fh, 9, 89h, 56h, 0F6h, 89h, 46h, 0F4h, 8Eh, 6, 0A2h, 83h
	db	26h, 0FFh, 74h, 0Ah, 0B8h, 1, 0, 50h, 9Ah, 34h, 0, 5Fh, 9, 89h
	db	56h, 0FAh, 89h, 46h, 0F8h, 0EBh, 23h, 8Eh, 6, 0A2h, 83h, 26h, 83h
	db	'<-~', 19h, 26h, 83h, 3Ch, 32h, 7Fh, 13h, 26h, 0FFh, 74h, 0Ah
	db	0B8h, 1, 0, 50h, 9Ah, 34h, 0, 5Fh, 9, 89h, 56h, 0FAh, 89h, 46h
	db	0F8h, 33h, 0C0h, 89h, 46h, 0EEh, 89h, 46h, 0ECh, 8Eh, 6, 0A2h
	db	83h, 26h, 8Bh, 4, 0BAh, 15h, 0, 0F7h, 0EAh, 26h, 3, 44h, 2, 8Bh
	db	0D8h, 8Ah, 87h, 0D8h, 39h, 0B4h, 0, 48h, 48h, 8Bh, 0D8h, 83h, 0FBh
	db	31h, 77h, 7, 0D1h, 0E3h, 2Eh, 0FFh, 0A7h, 0D4h, 10h, 0B8h, 1, 0
	db	50h, 9Ah, 0C6h, 0, 5Fh, 0, 44h, 44h, 8Eh, 6, 0A2h, 83h, 26h, 0F7h
	db	44h, 4
Y06130	ends

Y06280	segment para public 'CODE'
	assume	cs:Y06280
	db	10h, 0, 74h, 5Bh, 0B8h, 0Dh, 0, 50h, 26h, 0FFh, 74h, 0Ah, 26h	;@06280
	db	0FFh, 74h, 0Ch, 26h, 8Ah, 44h, 4, 50h, 9Ah, 34h, 0, 4Fh, 9, 89h
	db	46h, 0F2h, 0B8h, 0Ch, 0, 50h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h
	db	0Ah, 33h, 0C0h, 50h, 26h, 8Ah, 44h, 4, 50h, 9Ah, 34h, 0, 4Fh, 9
	db	89h, 46h, 0F0h, 8Eh, 6, 0A2h, 83h, 26h, 8Bh, 5Ch, 2, 8Ah, 87h
	db	40h, 50h, 0B4h, 0, 5, 15h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F2h
	db	0FFh, 76h, 0F0h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 67h
	db	0Fh, 56h, 9Ah, 25h, 0, 1Fh, 0Bh, 50h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh
	db	74h, 0Ah, 26h, 0FFh, 74h, 0Ch, 26h, 8Ah, 44h, 4, 50h, 9Ah, 34h
	db	0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 44h, 0Fh, 8Eh, 6, 0A2h, 83h, 26h
	db	0F7h, 44h, 4, 10h, 0, 74h, 62h, 0B8h, 0Dh, 0, 50h, 26h, 0FFh, 74h
	db	0Ah, 26h, 0FFh, 74h, 0Ch, 26h, 8Ah, 44h, 4, 50h, 9Ah, 34h, 0, 4Fh
	db	9, 89h, 46h, 0F2h, 0B8h, 0Ch, 0, 50h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh
	db	74h, 0Ah, 33h, 0C0h, 50h, 26h, 8Ah, 44h, 4, 50h, 9Ah, 34h, 0, 4Fh
	db	9, 89h, 46h, 0F0h, 0B8h, 1Bh, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h
	db	0F2h, 0FFh, 76h, 0F0h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0B8h
	db	16h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F0h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 0D6h, 0Eh, 0B8h, 11h, 0
	db	50h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h, 0Ah, 26h, 8Bh, 44h, 0Ch
	db	'@@P&', 8Ah, 44h, 4, 50h, 9Ah, 34h, 0, 4Fh, 9, 89h, 46h, 0EEh
	db	0B8h, 10h, 0, 50h, 8Bh, 5Eh, 0EEh, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh
	db	6, 0B4h, 88h, 26h, 0FFh, 37h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h
	db	0Ch, 9Ah, 25h, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 91h, 0Eh, 8Eh
	db	6, 0A2h, 83h, 26h, 0FFh, 74h, 0Ah, 0FFh, 1Eh, 34h, 83h, 89h, 46h
	db	0F2h, 0B8h, 1, 0, 8Ah, 4Eh, 0F2h, 0D3h, 0E0h, 9, 6, 17h, 89h, 83h
	db	7Eh, 0F2h, 0FFh, 75h, 16h, 0B8h, 73h, 0, 50h, 0B0h, 0, 50h, 33h
	db	0C0h, 50h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 5Ah
	db	0Eh, 8Eh, 6, 0A2h, 83h, 26h, 83h, 7Ch, 2, 2, 7Fh, 18h, 0B8h, 7
	db	0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F2h, 33h, 0C0h, 50h, 9Ah, 2Ah
	db	0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 37h, 0Eh, 0B8h, 8, 0, 50h, 0B0h
	db	0, 50h, 0FFh, 76h, 0F2h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h
	db	46h, 0ECh, 0E9h, 1Fh, 0Eh, 0B8h, 0Dh, 0, 50h, 8Eh, 6, 0A2h, 83h
	db	26h, 0FFh, 74h, 0Ah, 26h, 0FFh, 74h, 0Ch, 26h, 8Ah, 44h, 4, 50h
	db	9Ah, 34h, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h, 0Ch, 0, 50h, 8Eh, 6
	db	0A2h, 83h, 26h, 0FFh, 74h, 0Ah, 33h, 0C0h, 50h, 26h, 8Ah, 44h
	db	4, 50h, 9Ah, 34h, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 0E3h, 0Dh, 56h
	db	9Ah, 25h, 0, 1Fh, 0Bh, 50h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h
	db	0Ch, 26h, 0FFh, 74h, 0Ah, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0ECh
	db	0E9h, 0C5h, 0Dh, 0B8h, 0Ah, 0, 50h, 8Eh, 6, 0A2h, 83h, 26h, 8Bh
	db	44h, 0Ch, 99h, 52h, 50h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0EEh, 0B8h
	db	0Ah, 0, 50h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h, 0Ch, 26h, 0FFh
	db	74h, 0Ah, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 93h, 0Dh
	db	56h, 9Ah, 66h, 0, 0FFh, 9, 89h, 46h, 0ECh, 0E9h, 87h, 0Dh, 0B8h
	db	0Dh, 0, 50h, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h, 0Ah, 26h, 0FFh
	db	74h, 0Ch, 26h, 8Ah, 44h, 4, 50h, 9Ah, 34h, 0, 4Fh, 9, 89h, 46h
	db	0ECh, 0B8h, 8, 0, 50h, 0B0h, 0, 50h, 0B8h, 0Fh, 0, 50h, 33h, 0C0h
	db	50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 51h, 0Dh, 56h
	db	9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 0FFh
	db	76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 36h, 0Dh
	db	0B8h, 1Dh, 0, 50h, 0B0h, 10h, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h
	db	0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h, 24h, 0, 50h, 0B0h
	db	20h, 50h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F6h, 9Ah, 2Ah, 0, 4Fh, 9
	db	89h, 46h, 0EEh, 0E9h, 9, 0Dh, 56h, 0FFh, 76h, 0F8h, 0FFh, 76h
	db	0F4h, 9Ah, 6Bh, 0, 0FFh, 9, 89h, 46h, 0ECh, 0E9h, 0F7h, 0Ch, 56h
	db	9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h, 0FFh
	db	76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 0DCh, 0Ch
	db	56h, 9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h
	db	0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 83h, 7Eh
	db	0FAh, 0, 74h, 9, 8Bh, 46h, 0FAh, 89h, 46h, 0EEh, 0E9h, 0B5h, 0Ch
	db	8Bh, 46h, 0F6h, 89h, 46h, 0EEh, 0E9h, 0ACh, 0Ch, 8Eh, 6, 0A2h
	db	83h, 26h, 8Bh, 5Ch, 0Ah, 26h, 83h, 7Fh, 2, 10h, 75h, 14h, 8Bh
	db	46h, 0FAh, 8Bh, 56h, 0F8h, 89h, 46h, 0EAh, 89h, 56h, 0E8h, 8Bh
	db	46h, 0F6h, 8Bh, 56h, 0F4h, 0EBh, 20h, 8Eh, 6, 0A2h, 83h, 26h, 8Ah
	db	44h, 6, 0F6h, 0D8h, 26h, 88h, 44h, 6, 8Bh, 46h, 0F6h, 8Bh, 56h
	db	0F4h, 89h, 46h, 0EAh, 89h, 56h, 0E8h, 8Bh, 46h, 0FAh, 8Bh, 56h
	db	0F8h, 89h, 46h, 0E6h, 89h, 56h, 0E4h, 80h, 3Eh, 32h, 17h, 0, 75h
	db	3, 0E9h, 0FCh, 0, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h
	db	52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F2h, 8Eh, 6, 0A2h, 83h, 26h
	db	83h, 3Ch, 8, 75h, 70h, 0B8h, 1Dh, 0, 50h, 0B0h, 10h, 50h, 0FFh
	db	76h, 0E4h, 0FFh, 76h, 0E8h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh
	db	0B8h, 24h, 0, 50h, 0B0h, 20h, 50h, 0FFh, 76h, 0E6h, 0FFh, 76h
	db	0F2h, 9Ah, 2Ah, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h, 0Dh, 0, 50h, 0B8h
	db	'|?P', 0B8h, 1, 0, 50h, 0FFh, 1Eh, 68h, 83h, 50h, 33h, 0C0h, 50h
	db	0B0h, 10h, 50h, 9Ah, 34h, 0, 4Fh, 9, 89h, 46h, 0F0h, 0B8h, 45h
	db	0, 50h, 0B0h, 0, 50h, 57h, 0FFh, 76h, 0F0h, 9Ah, 2Ah, 0, 4Fh, 9
	db	8Bh, 0F8h, 0B8h, 1Fh, 0, 50h, 0B0h, 0, 50h, 57h, 0FFh, 76h, 0EAh
	db	9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 0CDh, 0Bh, 0B8h, 26h
	db	0, 50h, 0B0h, 10h, 50h, 0FFh, 76h, 0E8h, 0FFh, 76h, 0E4h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h, 24h, 0, 50h, 0B0h, 20h, 50h
	db	0FFh, 76h, 0E6h, 0FFh, 76h, 0F2h, 9Ah, 2Ah, 0, 4Fh, 9, 8Bh, 0F8h
	db	0B8h, 0Dh, 0, 50h, 0B8h, '|?P', 0B8h, 1, 0, 50h, 0FFh, 1Eh, 68h
	db	83h, 50h, 33h, 0C0h, 50h, 0B0h, 10h, 50h, 9Ah, 34h, 0, 4Fh, 9
	db	89h, 46h, 0F0h, 0B8h, 45h, 0, 50h, 0B0h, 0, 50h, 57h, 0FFh, 76h
	db	0F0h, 9Ah, 2Ah, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h, 28h, 0, 50h, 0B0h
	db	0, 50h, 0FFh, 76h, 0EAh, 57h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh
	db	0E9h, 5Dh, 0Bh, 8Eh, 6, 0A2h, 83h, 26h, 80h, 7Ch, 6, 0, 7Dh, 21h
	db	0B8h, 0B6h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0E4h, 0FFh, 76h, 0E6h
	db	9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0B5h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h
	db	0E8h, 0FFh, 76h, 0EAh, 0EBh, 1Fh, 0B8h, 0B5h, 0, 50h, 0B0h, 0
	db	50h, 0FFh, 76h, 0E8h, 0FFh, 76h, 0EAh, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h
	db	0B6h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0E4h, 0FFh, 76h, 0E6h, 9Ah
	db	2Ah, 0, 4Fh, 9, 8Eh, 6, 0A2h, 83h, 26h, 83h, 3Ch, 8, 75h, 5, 0B8h
	db	86h, 3Fh, 0EBh, 3, 0B8h, 8Ch, 3Fh, 50h, 0B8h, 55h, 10h, 50h, 9Ah
	db	39h, 0, 5Fh, 9, 0B8h, 0C2h, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h
	db	52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h, 0C3h, 0, 50h, 33h
	db	0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0EEh
	db	0E9h, 0CAh, 0Ah, 0B8h, 26h, 0, 50h, 0B0h, 10h, 50h, 0FFh, 76h
	db	0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h
	db	30h, 0, 50h, 0B0h, 20h, 50h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F6h
	db	9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 9Dh, 0Ah, 80h, 3Eh
	db	10h, 17h, 0, 75h, 1Dh, 8Eh, 6, 0A2h, 83h, 26h, 80h, 7Ch, 6, 0
	db	7Eh, 12h, 8Bh, 46h, 0F8h, 89h, 46h, 0F2h, 8Bh, 46h, 0F4h, 89h
	db	46h, 0F8h, 8Bh, 46h, 0F2h, 89h, 46h, 0F4h, 0B8h, 32h, 0, 50h, 0B0h
	db	0, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9
	db	89h, 46h, 0ECh, 0E9h, 61h, 0Ah, 8Eh, 6, 0A2h, 83h, 26h, 80h, 7Ch
	db	6, 0, 7Dh, 21h, 0B8h, 0B5h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F4h
	db	0FFh, 76h, 0F6h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0B6h, 0, 50h, 0B0h
	db	0, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0FAh, 0EBh, 1Fh, 0B8h, 0B5h
	db	0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0FAh, 9Ah, 2Ah
	db	0, 4Fh, 9, 0B8h, 0B6h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F4h, 0FFh
	db	76h, 0F6h, 9Ah, 2Ah, 0, 4Fh, 9, 56h, 9Ah, 2Fh, 0, 5Fh, 9, 0B8h
	db	0C2h, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh
	db	9, 89h, 46h, 0ECh, 0B8h, 0C3h, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h
	db	52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 0E4h, 9, 0B8h
	db	0ACh, 0, 50h, 0B0h, 10h, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h
	db	9Ah, 2Ah, 0, 4Fh, 9, 56h, 9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h, 20h
	db	50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h
	db	46h, 0ECh, 0E9h, 0B7h, 9, 0B8h, 0B5h, 0, 50h, 0B0h, 10h, 50h, 33h
	db	0C0h, 50h, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah
	db	20h, 0, 4Fh, 9, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 3Fh, 0, 50h, 0B0h
	db	20h, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9
	db	89h, 46h, 0ECh, 0E9h, 80h, 9, 0B8h, 0B5h, 0, 50h, 0B0h, 10h, 50h
	db	33h, 0C0h, 50h, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h
	db	9Ah, 20h, 0, 4Fh, 9, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 41h, 0, 50h
	db	0B0h, 20h, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0
	db	4Fh, 9, 89h, 46h, 0ECh, 0E9h, 49h, 9, 8Eh, 6, 0A2h, 83h, 26h, 80h
	db	7Ch, 6, 0, 7Dh, 21h, 0B8h, 0B5h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h
	db	0F8h, 0FFh, 76h, 0FAh, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0BDh, 0, 50h
	db	0B0h, 0, 50h, 0FFh, 76h, 0F4h, 33h, 0C0h, 50h, 0EBh, 1Fh, 0B8h
	db	0BDh, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F4h, 33h, 0C0h, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 0B8h, 0B5h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h
	db	0FFh, 76h, 0FAh, 9Ah, 2Ah, 0, 4Fh, 9, 56h, 9Ah, 2Fh, 0, 5Fh, 9
	db	0B8h, 0C2h, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0
	db	4Fh, 9, 89h, 46h, 0ECh, 0B8h, 0C3h, 0, 50h, 33h, 0C0h, 33h, 0D2h
	db	50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 0CCh, 8, 8Eh
	db	6, 0A2h, 83h, 26h, 8Bh, 5Ch, 2, 8Ah, 87h, 56h, 50h, 0B4h, 0, 5
	db	48h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 0A6h, 8, 56h, 9Ah, 25h, 0
	db	1Fh, 0Bh, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h
	db	9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 56h, 9Ah, 25h, 0, 1Fh, 0Bh
	db	50h, 0B0h, 0, 50h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F6h, 9Ah, 2Ah
	db	0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 73h, 8, 56h, 9Ah, 25h, 0, 1Fh
	db	0Bh, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 58h, 8, 0B8h, 9Ch, 0, 50h
	db	0B0h, 2, 50h, 0FFh, 76h, 0FAh, 0FFh, 76h, 0F6h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0EEh, 0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0FFh, 76h
	db	0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h
	db	2Bh, 8, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 52h, 0, 0FFh, 9
	db	89h, 46h, 0ECh, 0E9h, 1Ah, 8, 0B8h, 1Dh, 0, 50h, 0B0h, 12h, 50h
	db	0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h
	db	0ECh, 0B8h, 24h, 0, 50h, 0B0h, 22h, 50h, 0FFh, 76h, 0FAh, 0FFh
	db	76h, 0F6h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 0EDh, 7
	db	56h, 9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h
	db	0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 56h, 9Ah
	db	25h, 0, 1Fh, 0Bh, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0FAh, 0FFh, 76h
	db	0F6h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 0BAh, 7, 56h
	db	9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h, 0FFh
	db	76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 8Bh, 46h, 0FAh
	db	89h, 46h, 0EEh, 0E9h, 99h, 7, 80h, 3Eh, 32h, 17h, 0, 75h, 3, 0E9h
	db	0A6h, 0, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah
	db	20h, 0, 4Fh, 9, 89h, 46h, 0F2h, 8Eh, 6, 0A2h, 83h, 26h, 83h, 3Ch
	db	13h, 75h, 1Ah, 0B8h, 1Dh, 0, 50h, 0B0h, 12h, 50h, 0FFh, 76h, 0F8h
	db	0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h, 24h
	db	0, 0EBh, 18h, 0B8h, 26h, 0, 50h, 0B0h, 12h, 50h, 0FFh, 76h, 0F8h
	db	0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h, 30h
	db	0, 50h, 0B0h, 20h, 50h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F6h, 9Ah
	db	2Ah, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h, 0Dh, 0, 50h, 0B8h, '|?P', 0B8h
	db	1, 0, 50h, 0FFh, 1Eh, 68h, 83h, 50h, 33h, 0C0h, 50h, 0B0h, 10h
	db	50h, 9Ah, 34h, 0, 4Fh, 9, 89h, 46h, 0F0h, 0B8h, 45h, 0, 50h, 0B0h
	db	0, 50h, 57h, 0FFh, 76h, 0F0h, 9Ah, 2Ah, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h
	db	1Fh, 0, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0FAh, 57h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0EEh, 0E9h, 0E9h, 6, 83h, 7Eh, 0FAh, 0, 75h, 16h
	db	0B8h, 8, 0, 50h, 0B0h, 0, 50h, 0B8h, 0Dh, 0, 50h, 33h, 0C0h, 50h
	db	9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0FAh, 8Eh, 6, 0A2h, 83h, 26h, 80h
	db	7Ch, 6, 0, 7Dh, 21h, 0B8h, 0B6h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h
	db	0F4h, 0FFh, 76h, 0F6h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0B5h, 0, 50h
	db	0B0h, 0, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0FAh, 0EBh, 1Fh, 0B8h
	db	0B5h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0FAh, 9Ah
	db	2Ah, 0, 4Fh, 9, 0B8h, 0B6h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F4h
	db	0FFh, 76h, 0F6h, 9Ah, 2Ah, 0, 4Fh, 9, 8Eh, 6, 0A2h, 83h, 26h, 83h
	db	3Ch, 14h, 75h, 5, 0B8h, 92h, 3Fh, 0EBh, 3, 0B8h, 98h, 3Fh, 50h
	db	0B8h, 55h, 10h, 50h, 9Ah, 39h, 0, 5Fh, 9, 0B8h, 0C2h, 0, 50h, 33h
	db	0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0ECh
	db	0B8h, 0C3h, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0
	db	4Fh, 9, 89h, 46h, 0EEh, 0E9h, 3Ah, 6, 0B8h, 26h, 0, 50h, 0B0h
	db	12h, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9
	db	89h, 46h, 0ECh, 0B8h, 30h, 0, 50h, 0B0h, 22h, 50h, 0FFh, 76h, 0FAh
	db	0FFh, 76h, 0F6h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 0Dh
	db	6, 0B8h, 97h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h
	db	50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F2h, 56h, 9Ah, 25h, 0, 1Fh
	db	0Bh, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F4h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0B8h, 9Bh, 0, 50h, 0B0h, 2, 50h
	db	0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h
	db	0ECh, 8Bh, 5Eh, 0F8h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 6, 9Ch, 88h
	db	26h, 80h, 67h, 1, 0FBh, 0E9h, 0B8h, 5, 0B8h, 98h, 0, 50h, 0B0h
	db	0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h
	db	46h, 0F2h, 56h, 9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h, 0, 50h, 0FFh
	db	76h, 0F2h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h
	db	0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h
	db	9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 8Bh, 5Eh, 0F8h, 0D1h, 0E3h
	db	0D1h, 0E3h, 8Eh, 6, 9Ch, 88h, 26h, 80h, 67h, 1, 0FBh, 0E9h, 63h
	db	5, 0B8h, 97h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h
	db	50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F2h, 0B8h, 0ABh, 0, 50h, 0B0h
	db	10h, 50h, 0FFh, 76h, 0F2h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9
	db	89h, 46h, 0F2h, 56h, 9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h, 20h, 50h
	db	0FFh, 76h, 0F2h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h
	db	0F4h, 0B8h, 9Bh, 0, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h
	db	0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 8Bh, 5Eh, 0F8h, 0D1h
	db	0E3h, 0D1h, 0E3h, 8Eh, 6, 9Ch, 88h, 26h, 80h, 67h, 1, 0FBh, 0E9h
	db	0F9h, 4, 0B8h, 97h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h
	db	0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F2h, 0B8h, 0ABh, 0
	db	50h, 0B0h, 10h, 50h, 0FFh, 76h, 0F2h, 33h, 0C0h, 50h, 9Ah, 2Ah
	db	0, 4Fh, 9, 89h, 46h, 0F2h, 56h, 9Ah, 25h, 0, 1Fh, 0Bh, 50h, 0B0h
	db	30h, 50h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9
	db	89h, 46h, 0F4h, 0B8h, 7, 0, 50h, 0B0h, 0, 50h, 0B8h, 1, 0, 50h
	db	33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0B8h, 9Bh
	db	0, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah
	db	0, 4Fh, 9, 89h, 46h, 0ECh, 8Bh, 5Eh, 0F8h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 6, 9Ch, 88h, 26h, 80h, 67h, 1, 0FBh, 0E9h, 79h, 4, 0B8h, 97h
	db	0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah
	db	0, 4Fh, 9, 89h, 46h, 0F2h, 0B8h, 0AAh, 0, 50h, 0B0h, 0, 50h, 0FFh
	db	76h, 0F2h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F2h
	db	0B8h, 3Eh, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F4h
	db	9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0B8h, 9Bh, 0, 50h, 0B0h, 2
	db	50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h
	db	46h, 0ECh, 8Bh, 5Eh, 0F8h, 0D1h, 0E3h, 0D1h, 0E3h, 8Eh, 6, 9Ch
	db	88h, 26h, 80h, 67h, 1, 0FBh, 0E9h, 12h, 4, 0B8h, 97h, 0, 50h, 0B0h
	db	0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h
	db	46h, 0F2h, 0B8h, 0AAh, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F2h, 33h
	db	0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F2h, 0B8h, 3Eh, 0, 50h
	db	0B0h, 0, 50h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0F4h, 0B8h, 7, 0, 50h, 0B0h, 0, 50h, 0B8h, 1, 0, 50h
	db	33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0B8h, 9Bh
	db	0, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah
	db	0, 4Fh, 9, 89h, 46h, 0ECh, 8Bh, 5Eh, 0F8h, 0D1h, 0E3h, 0D1h, 0E3h
	db	8Eh, 6, 9Ch, 88h, 26h, 80h, 67h, 1, 0FBh, 0E9h, 95h, 3, 8Eh, 6
	db	0A2h, 83h, 26h, 8Bh, 5Ch, 2, 8Ah, 87h, 56h, 50h, 0B4h, 0, 5, 48h
	db	0, 50h, 0B0h, 2, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah, 2Ah
	db	0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 6Fh, 3, 8Bh, 46h, 0FAh, 8Bh, 56h
	db	0F8h, 89h, 46h, 0EEh, 89h, 56h, 0ECh, 0E9h, 60h, 3, 8Bh, 46h, 0F6h
	db	8Bh, 56h, 0F4h, 89h, 46h, 0EEh, 89h, 56h, 0ECh, 0E9h, 51h, 3, 0B8h
	db	28h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 0FFh, 76h, 0F4h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 39h, 3, 8Eh, 6, 0A2h, 83h
	db	26h, 8Bh, 5Ch, 0Ah, 26h, 83h, 7Fh, 2, 10h, 74h, 3, 0E9h, 8Ch, 0
	db	26h, 80h, 7Ch, 6, 0, 7Dh, 21h, 0B8h, 0B5h, 0, 50h, 0B0h, 0, 50h
	db	0FFh, 76h, 0F8h, 0FFh, 76h, 0FAh, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0B6h
	db	0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F4h, 0FFh, 76h, 0F6h, 0EBh, 1Fh
	db	0B8h, 0B6h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F4h, 0FFh, 76h, 0F6h
	db	9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0B5h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h
	db	0F8h, 0FFh, 76h, 0FAh, 9Ah, 2Ah, 0, 4Fh, 9, 80h, 3Eh, 32h, 17h
	db	0, 74h, 5, 0B8h, 9Eh, 3Fh, 0EBh, 3, 0B8h, 0A4h, 3Fh, 50h, 0B8h
	db	55h, 10h, 50h, 9Ah, 39h, 0, 5Fh, 9, 0B8h, 0C2h, 0, 50h, 33h, 0C0h
	db	33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h
	db	0C3h, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh
	db	9, 89h, 46h, 0EEh, 0E9h, 9Bh, 2, 0B8h, 0Ah, 0, 50h, 33h, 0C0h
	db	33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F2h, 0B8h
	db	0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh
	db	9, 8Bh, 0F8h, 0B8h, 26h, 0, 50h, 0B0h, 10h, 50h, 0FFh, 76h, 0F8h
	db	0FFh, 76h, 0F4h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h, 30h
	db	0, 50h, 0B0h, 20h, 50h, 0FFh, 76h, 0F2h, 57h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0EEh, 0E9h, 4Dh, 2, 8Bh, 46h, 0F8h, 89h, 46h, 0EEh
	db	8Bh, 46h, 0F4h, 89h, 46h, 0ECh, 0E9h, 3Eh, 2, 56h, 9Ah, 25h, 0
	db	1Fh, 0Bh, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 23h, 2, 0B8h, 51h, 0, 50h
	db	0B0h, 0, 50h, 0FFh, 76h, 0FAh, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0F0h, 0B8h, 51h, 0, 50h, 0B0h, 10h, 50h, 0FFh, 76h
	db	0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0B8h
	db	0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh
	db	9, 8Bh, 0F8h, 0B8h, 30h, 0, 50h, 0B0h, 20h, 50h, 0FFh, 76h, 0F0h
	db	57h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h, 0D2h, 1, 0B8h
	db	52h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0ECh, 0E9h, 0BAh, 1, 0B8h, 54h, 0, 50h
	db	0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0ECh, 0B8h, 54h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h
	db	0FAh, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0EEh, 0E9h
	db	8Dh, 1, 8Bh, 46h, 0F8h, 89h, 46h, 0F2h, 8Eh, 6, 0A2h, 83h, 26h
	db	8Bh, 5Ch, 0Ah, 26h, 83h, 7Fh, 2, 2, 7Fh, 15h, 0B8h, 0ABh, 0, 50h
	db	0B0h, 0, 50h, 0FFh, 76h, 0F2h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0F2h, 0B8h, 51h, 0, 50h, 0B0h, 10h, 50h, 0FFh, 76h
	db	0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F2h, 0B8h
	db	30h, 0, 50h, 0B0h, 20h, 50h, 0FFh, 76h, 0F2h, 0FFh, 76h, 0F2h
	db	9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F2h, 0B8h, 59h, 0, 50h, 0B0h, 0
	db	50h, 0FFh, 76h, 0F2h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h
	db	46h, 0ECh, 0E9h, 21h, 1, 8Eh, 6, 0A2h, 83h, 26h, 8Bh, 44h, 0Ah
	db	89h, 46h, 0FEh, 0B8h, 94h, 0, 50h, 0B0h, 0, 50h, 0B8h, 8, 0, 50h
	db	0B0h, 0, 50h, 0B8h, 0Fh, 0, 50h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh
	db	9, 50h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 8Bh, 5Eh, 0FEh, 8Eh
	db	6, 0A2h, 83h, 26h, 8Bh, 47h, 0Ah, 89h, 46h, 0FCh, 0B8h, 0Dh, 0
	db	50h, 8Bh, 5Eh, 0FCh, 26h, 0FFh, 77h, 0Ah, 26h, 0FFh, 77h, 0Ch
	db	26h, 8Ah, 47h, 4, 50h, 9Ah, 34h, 0, 4Fh, 9, 89h, 46h, 0F8h, 0B8h
	db	94h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 0B8h, 94h, 0, 50h, 0B0h, 0, 50h, 0B8h, 8, 0, 50h
	db	0B0h, 0, 50h, 0B8h, 0Dh, 0, 50h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh
	db	9, 50h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 8Bh, 5Eh, 0FEh, 8Eh
	db	6, 0A2h, 83h, 26h, 8Bh, 47h, 0Ch, 89h, 46h, 0FEh, 0B8h, 0Dh, 0
	db	50h, 8Bh, 5Eh, 0FEh, 26h, 0FFh, 77h, 0Ah, 26h, 0FFh, 77h, 0Ch
	db	26h, 8Ah, 47h, 4, 50h, 9Ah, 34h, 0, 4Fh, 9, 89h, 46h, 0F4h, 0B8h
	db	94h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F4h, 33h, 0C0h, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 0B8h, 0Ah, 0, 50h, 8Eh, 6, 0A2h, 83h, 26h, 8Bh
	db	5Ch, 0Ch, 26h, 0FFh, 77h, 0Ch, 26h, 0FFh, 77h, 0Ah, 9Ah, 20h, 0
	db	4Fh, 9, 89h, 46h, 0F2h, 0B8h, 0B6h, 0, 50h, 0B0h, 0, 50h, 33h
	db	0C0h, 50h, 0FFh, 76h, 0F2h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0AAh, 3Fh
	db	50h, 0B8h, 40h, 10h, 50h, 9Ah, 39h, 0, 5Fh, 9, 0B8h, 0AEh, 0, 50h
	db	33h, 0C0h, 0BAh, 8, 0, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 0EBh, 0Bh
	db	0B8h, 1, 0, 50h, 9Ah, 0C6h, 0, 5Fh, 0, 44h, 44h, 8Bh, 56h, 0EEh
	db	8Bh, 46h, 0ECh, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0CAh, 2, 0, 0F8h, 0
	db	82h, 1, 35h, 2, 0A7h, 2, 0E3h, 2, 1, 3, 33h, 3, 3Fh, 3, 75h, 3
	db	90h, 3, 0BDh, 3, 0CFh, 3, 0EAh, 3, 1Ah, 4, 0FCh, 5, 29h, 6, 65h
	db	6, 0E2h, 6, 0Fh, 7, 46h, 7, 7Dh, 7, 0FAh, 7, 20h, 8, 53h, 8, 6Eh
	db	8, 9Bh, 8, 0ACh, 8, 0D9h, 8, 0Ch, 9, 2Dh, 9, 8Ch, 0Ah, 0B9h, 0Ah
	db	0Eh, 0Bh, 63h, 0Bh, 0CDh, 0Bh, 4Dh, 0Ch, 0B4h, 0Ch, 31h, 0Dh, 57h
	db	0Dh, 66h, 0Dh, 75h, 0Dh, 8Dh, 0Dh, 79h, 0Eh, 88h, 0Eh, 0A3h, 0Eh
	db	0F4h, 0Eh, 0Ch, 0Fh, 39h, 0Fh, 0A5h, 0Fh, 0BBh, 10h, 45h, 55h
	db	8Bh, 0ECh, 83h, 0ECh, 0Ch, 56h, 57h, 8Bh, 76h, 4, 8Eh, 6, 0A2h
	db	83h, 26h, 8Bh, 44h, 2, 89h, 46h, 0FCh, 26h, 8Bh, 5Ch, 0Ah, 26h
	db	8Bh, 47h, 2, 89h, 46h, 0FEh, 26h, 0FFh, 74h, 0Ah, 0B8h, 1, 0, 50h
	db	9Ah, 34h, 0, 5Fh, 9, 89h, 56h, 0FAh, 89h, 46h, 0F8h, 33h, 0C0h
	db	89h, 46h, 0F6h, 89h, 46h, 0F4h, 8Bh, 46h, 0FEh, 0BAh, 11h, 0, 0F7h
	db	0EAh, 3, 46h, 0FCh, 8Bh, 0D8h, 8Ah, 87h, 5Bh, 3Eh, 0B4h, 0, 48h
	db	8Bh, 0D8h, 83h, 0FBh, 18h, 77h, 7, 0D1h, 0E3h, 2Eh, 0FFh, 0A7h
	db	0B4h, 17h, 0B8h, 1, 0, 50h, 9Ah, 0C6h, 0, 5Fh, 0, 44h, 44h, 8Bh
	db	46h, 0FAh, 8Bh, 56h, 0F8h, 89h, 46h, 0F6h, 89h, 56h, 0F4h, 0E9h
	db	0F4h, 5, 80h, 3Eh, 14h, 17h, 0, 74h, 0Fh, 8Bh, 46h, 0FAh, 8Bh
	db	56h, 0F8h, 89h, 46h, 0F6h, 89h, 56h, 0F4h, 0E9h, 0DEh, 5, 8Eh
	db	6, 0A2h, 83h, 26h, 8Bh, 44h, 2, 5, 61h, 0, 50h, 0B0h, 2, 50h, 26h
	db	0FFh, 74h, 2, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 0FFh
	db	76h, 0F8h, 9Ah, 2Ah, 0, 4Fh, 9, 8Eh, 6, 0A2h, 83h, 26h, 0FFh, 74h
	db	2, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 89h, 46h, 0F4h, 0E9h
	db	0A4h, 5, 0B8h, 0ABh, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h
	db	0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0E9h, 8Ch, 5, 0B8h
	db	0ABh, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0F8h, 0B8h, 0ACh, 0, 50h, 0B0h, 10h
	db	50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h
	db	46h, 0F4h, 0B8h, 0C3h, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h
	db	9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F6h, 0E9h, 4Dh, 5, 0B8h, 0ABh
	db	0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah
	db	0, 4Fh, 9, 89h, 46h, 0F8h, 0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h
	db	3, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 0FFh, 76h
	db	0F8h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 5Ch, 0, 50h, 0B0h, 0, 50h, 33h
	db	0C0h, 50h, 0B8h, 3, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh
	db	9, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0E9h, 0FAh, 4, 0B8h
	db	0AAh, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0E9h, 0E2h, 4, 0B8h, 0AAh, 0, 50h
	db	0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0F8h, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h
	db	52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F6h, 8Bh, 46h, 0F8h, 89h
	db	46h, 0F4h, 0E9h, 0B2h, 4, 0B8h, 0AAh, 0, 50h, 0B0h, 0, 50h, 0FFh
	db	76h, 0F8h, 33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F8h
	db	0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h, 3, 0, 50h, 33h, 0C0h, 50h
	db	9Ah, 7Fh, 0, 0FFh, 9, 50h, 0FFh, 76h, 0F8h, 9Ah, 2Ah, 0, 4Fh, 9
	db	0B8h, 5Ch, 0, 50h, 0B0h, 0, 50h, 33h, 0C0h, 50h, 0B8h, 3, 0, 50h
	db	33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 9Ah, 2Ah, 0, 4Fh, 9
	db	89h, 46h, 0F4h, 0E9h, 5Fh, 4, 8Bh, 46h, 0F8h, 89h, 46h, 0F4h, 0E9h
	db	56h, 4, 0B8h, 0ACh, 0, 50h, 0B0h, 10h, 50h, 0FFh, 76h, 0F8h, 33h
	db	0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0B8h, 0C3h, 0
	db	50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h
	db	46h, 0F6h, 0E9h, 2Ch, 4, 0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h
	db	3, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 0FFh, 76h
	db	0F8h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 5Ch, 0, 50h, 0B0h, 0, 50h, 33h
	db	0C0h, 50h, 0B8h, 3, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh
	db	9, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0E9h, 0EEh, 3, 0B8h
	db	9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h, 3, 0, 50h, 0B8h, 2, 0, 50h, 9Ah
	db	7Fh, 0, 0FFh, 9, 50h, 0FFh, 76h, 0F8h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h
	db	0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh
	db	9, 8Bh, 0F8h, 0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h, 3, 0, 50h
	db	33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 57h, 9Ah, 2Ah, 0, 4Fh
	db	9, 0B8h, 5Dh, 0, 50h, 0B0h, 0, 50h, 33h, 0C0h, 50h, 0B8h, 7, 0
	db	50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 9Ah, 2Ah, 0, 4Fh
	db	9, 89h, 46h, 0F4h, 0E9h, 84h, 3, 0B8h, 0Ah, 0, 50h, 33h, 0C0h
	db	33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F6h, 8Bh
	db	46h, 0F8h, 89h, 46h, 0F4h, 0E9h, 69h, 3, 0B8h, 9Ch, 0, 50h, 0B0h
	db	2, 50h, 0B8h, 3, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9
	db	50h, 0FFh, 76h, 0F8h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0Ah, 0, 50h, 33h
	db	0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h
	db	9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h, 3, 0, 50h, 0B8h, 2, 0, 50h, 9Ah
	db	7Fh, 0, 0FFh, 9, 50h, 57h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 5Dh, 0, 50h
	db	0B0h, 0, 50h, 33h, 0C0h, 50h, 0B8h, 7, 0, 50h, 33h, 0C0h, 50h
	db	9Ah, 7Fh, 0, 0FFh, 9, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h
	db	0E9h, 0FFh, 2, 8Bh, 46h, 0F8h, 89h, 46h, 0F4h, 0E9h, 0F6h, 2, 8Bh
	db	46h, 0FAh, 89h, 46h, 0F4h, 0E9h, 0EDh, 2, 0B8h, 9Ch, 0, 50h, 0B0h
	db	2, 50h, 0B8h, 3, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9
	db	50h, 0FFh, 76h, 0F8h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 9Ch, 0, 50h, 0B0h
	db	2, 50h, 0B8h, 3, 0, 50h, 0B8h, 2, 0, 50h, 9Ah, 7Fh, 0, 0FFh, 9
	db	50h, 0FFh, 76h, 0FAh, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 5Dh, 0, 50h, 0B0h
	db	0, 50h, 33h, 0C0h, 50h, 0B8h, 7, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh
	db	0, 0FFh, 9, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0E9h, 92h
	db	2, 0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h, 3, 0, 50h, 33h, 0C0h
	db	50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 0FFh, 76h, 0F8h, 9Ah, 2Ah, 0, 4Fh
	db	9, 0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h, 3, 0, 50h, 0B8h, 2, 0
	db	50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 0FFh, 76h, 0FAh, 9Ah, 2Ah, 0, 4Fh
	db	9, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h
	db	0, 4Fh, 9, 8Bh, 0F8h, 0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h, 3
	db	0, 50h, 0B8h, 4, 0, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 57h, 9Ah, 2Ah
	db	0, 4Fh, 9, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah
	db	20h, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h, 9Ch, 0, 50h, 0B0h, 2, 50h, 0B8h
	db	3, 0, 50h, 0B8h, 6, 0, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 57h, 9Ah
	db	2Ah, 0, 4Fh, 9, 0B8h, 5Eh, 0, 50h, 0B0h, 0, 50h, 33h, 0C0h, 50h
	db	0B8h, 0Ah, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0E9h, 0DFh, 1, 0B8h, 8, 0, 50h
	db	0B0h, 0, 50h, 8Eh, 6, 0A2h, 83h, 26h, 8Bh, 5Ch, 0Ah, 26h, 0FFh
	db	77h, 8, 0FFh, 1Eh, 20h, 83h, 50h, 9Ah, 3Eh, 0, 5Fh, 9, 98h, 50h
	db	33h, 0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F6h, 8Bh, 46h
	db	0F8h, 89h, 46h, 0F4h, 0E9h, 0ACh, 1, 0B8h, 9Ch, 0, 50h, 0B0h, 2
	db	50h, 0B8h, 3, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h
	db	0FFh, 76h, 0F8h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 8, 0, 50h, 0B0h, 0
	db	50h, 8Eh, 6, 0A2h, 83h, 26h, 8Bh, 5Ch, 0Ah, 26h, 0FFh, 77h, 8
	db	0FFh, 1Eh, 20h, 83h, 50h, 9Ah, 3Eh, 0, 5Fh, 9, 98h, 50h, 33h, 0C0h
	db	50h, 9Ah, 2Ah, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h, 9Ch, 0, 50h, 0B0h, 2
	db	50h, 0B8h, 3, 0, 50h, 0B8h, 2, 0, 50h, 9Ah, 7Fh, 0, 0FFh, 9, 50h
	db	57h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h
	db	50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h, 9Ch, 0, 50h, 0B0h
	db	2, 50h, 0B8h, 3, 0, 50h, 0B8h, 4, 0, 50h, 9Ah, 7Fh, 0, 0FFh, 9
	db	50h, 57h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h
	db	0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 8Bh, 0F8h, 0B8h, 9Ch, 0, 50h
	db	0B0h, 2, 50h, 0B8h, 3, 0, 50h, 0B8h, 6, 0, 50h, 9Ah, 7Fh, 0, 0FFh
	db	9, 50h, 57h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 5Eh, 0, 50h, 0B0h, 0, 50h
	db	33h, 0C0h, 50h, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 50h, 9Ah, 7Fh, 0
	db	0FFh, 9, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 89h, 46h, 0F4h, 0E9h, 0D2h
	db	0, 0B8h, 0Ah, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h
	db	0, 4Fh, 9, 89h, 46h, 0F4h, 8Bh, 46h, 0F8h, 89h, 46h, 0F6h, 0E9h
	db	0B7h, 0, 0B8h, 0B4h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h
	db	0C0h, 50h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0B1h, 3Fh, 50h, 0B8h, 55h
	db	10h, 50h, 9Ah, 39h, 0, 5Fh, 9, 0B8h, 0C2h, 0, 50h, 33h, 0C0h, 33h
	db	0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F4h, 0E9h, 83h
	db	0, 0B8h, 0B4h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h
	db	50h, 9Ah, 2Ah, 0, 4Fh, 9, 0B8h, 0B1h, 3Fh, 50h, 0B8h, 55h, 10h
	db	50h, 9Ah, 39h, 0, 5Fh, 9, 0B8h, 0C3h, 0, 50h, 33h, 0C0h, 33h, 0D2h
	db	50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F4h, 0EBh, 50h, 0B8h
	db	0B4h, 0, 50h, 0B0h, 0, 50h, 0FFh, 76h, 0F8h, 33h, 0C0h, 50h, 9Ah
	db	2Ah, 0, 4Fh, 9, 0B8h, 0B1h, 3Fh, 50h, 0B8h, 55h, 10h, 50h, 9Ah
	db	39h, 0, 5Fh, 9, 0B8h, 0C2h, 0, 50h, 33h, 0C0h, 33h, 0D2h, 50h
	db	52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F4h, 0B8h, 0C3h, 0, 50h, 33h
	db	0C0h, 33h, 0D2h, 50h, 52h, 9Ah, 20h, 0, 4Fh, 9, 89h, 46h, 0F6h
	db	0EBh, 0Bh, 0B8h, 1, 0, 50h, 9Ah, 0C6h, 0, 5Fh, 0, 44h, 44h, 8Bh
	db	56h, 0F6h, 8Bh, 46h, 0F4h, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 4Dh, 0C2h
	db	2, 0, 0A2h, 11h, 0B1h, 11h, 1, 12h, 19h, 12h, 58h, 12h, 0ABh, 12h
	db	0C3h, 12h, 0F3h, 12h, 46h, 13h, 4Fh, 13h, 79h, 13h, 0B7h, 13h
	db	21h, 14h, 3Ch, 14h, 0A6h, 14h, 0AFh, 14h, 0B8h, 14h, 13h, 15h
	db	0C6h, 15h, 0F9h, 15h, 0D3h, 16h, 0EEh, 16h, 22h, 17h, 55h, 17h
	db	9Ah, 17h
ASM_ASSEMBLE_STATEMENT:	push	bp	;@07966
	mov	bp, sp	;@07967
	sub	sp, 1C0h	;@07969
	call	ASM_INIT_STATE	;@0796D
	mov	byte ptr [bp-1Bh], 1	;@07970
	db	0E8h, 9Dh, 7	; call ASM_NEXT_TOKEN	;@07974
	mov	ax, word ptr [bp-12h]	;@07977
	mov	word ptr [bp-14h], ax	;@0797A
	db	0E8h, 0E5h, 1	; call ASM_PARSE_LABEL_PREFIX	;@0797D
	call	ASM_PARSE_PREFIXES	;@07980
	dec	byte ptr [bp-1Bh]	;@07983
	db	0E8h, 0F1h, 0	; call ASM_PARSE_DATA_DIRECTIVE	;@07986
	je	@@2	;@07989
	mov	al, 3Bh	;@0798B
	db	0E8h, 7Dh, 7	; call ASM_ACCEPT_TOKEN	;@0798D
	je	@@1	;@07990
	db	0E8h, 0D6h, 11h	; call ASM_EMIT_PREFIX_LIST	;@07992
	jmp	short @@2	;@07995
@@1:	mov	al, 41h	;@07997
	db	0E8h, 6Ah, 7	; call ASM_EXPECT_TOKEN	;@07999
	db	0E8h, 0E2h, 1	; call ASM_PARSE_OPERANDS	;@0799C
	db	0E8h, 0Ch, 0Bh	; call ASM_ENCODE_INSTRUCTION	;@0799F
@@2:	call	ASM_FLUSH_EMIT_RECORDS	;@079A2
	xor	ax, ax	;@079A5
ASM_STATEMENT_EXIT:	mov	cx, word ptr [bp-12h]	;@079A7
	lds	bx, dword ptr [bp+0Ah]	;@079AA
	mov	word ptr [bx], cx	;@079AD
	mov	si, word ptr [bp-4]	;@079AF
	mov	di, word ptr [bp-6]	;@079B2
	mov	sp, bp	;@079B5
	pop	bp	;@079B7
	retf	8	;@079B8
ASM_INIT_STATE:	mov	word ptr [bp-4], si	;@079BB
	mov	word ptr [bp-6], di	;@079BE
	lea	ax, [bp-5A8h]	;@079C1
	mov	word ptr [bp-8], ax	;@079C5
	les	bx, dword ptr [bp+0Ah]	;@079C8
	les	bx, dword ptr es:[bx]	;@079CB
	mov	word ptr [bp-12h], bx	;@079CE
	mov	word ptr [bp-10h], es	;@079D1
	xor	ax, ax	;@079D4
	mov	word ptr [bp-14h], ax	;@079D6
	mov	word ptr [bp-3Ah], ax	;@079D9
	mov	word ptr [bp-38h], ax	;@079DC
	mov	word ptr [bp-0Eh], ax	;@079DF
	mov	word ptr [bp-110h], ax	;@079E2
	mov	byte ptr [bp-25h], al	;@079E6
	ret	;@079E9
ASM_FLUSH_EMIT_RECORDS:	lea	si, [bp-17Eh]	;@079EA
@@1:	sub	word ptr [bp-110h], 0Ah	;@079EE
	jb	@@7	;@079F3
	cld	;@079F5
	push	si	;@079F6
	xor	ax, ax	;@079F7
	lodsb	;@079F9
	mov	bx, ax	;@079FA
	lodsb	;@079FC
	mov	cx, ax	;@079FD
	lodsw	;@079FF
	xchg	ax, dx	;@07A00
	lodsw	;@07A01
	xchg	ax, dx	;@07A02
	dec	bx	;@07A03
	js	@@2	;@07A04
	je	@@3	;@07A06
	dec	bx	;@07A08
	je	@@4	;@07A09
	push	ax	;@07A0B
	mov	ax, cx	;@07A0C
	and	cl, 0FEh	;@07A0E
	push	cx	;@07A11
	and	al, 1	;@07A12
	push	ax	;@07A14
	db	9Ah, 20h, 0, 7Fh, 0Bh	; lcall 0xb7f, 0x20	;@07A15
	jmp	short @@5	;@07A1A
@@2:	push	ax	;@07A1C
	db	9Ah, 2Fh, 0, 7Fh, 0Bh	; lcall 0xb7f, 0x2f	;@07A1D
	jmp	short @@5	;@07A22
@@3:	push	cx	;@07A24
	push	word ptr [si+2]	;@07A25
	push	word ptr [si]	;@07A28
	push	dx	;@07A2A
	push	ax	;@07A2B
	db	9Ah, 34h, 0, 7Fh, 0Bh	; lcall 0xb7f, 0x34	;@07A2C
	jmp	short @@5	;@07A31
@@4:	push	ax	;@07A33
	push	word ptr [si+2]	;@07A34
	push	word ptr [si]	;@07A37
	db	9Ah, 2Ah, 0, 7Fh, 0Bh	; lcall 0xb7f, 0x2a	;@07A39
@@5:	or	ax, ax	;@07A3E
	je	@@6	;@07A40
	db	0E9h, 0AFh, 1	; jmp ASM_REWIND_AND_EXIT	;@07A42
@@6:	pop	si	;@07A45
	add	si, 0Ah	;@07A46
	jmp	@@1	;@07A49
@@7:	mov	word ptr [bp-110h], 0	;@07A4B
	ret	;@07A51
ASM_PARSE_PREFIXES:	cmp	dh, 41h	;@07A52
	db	75h, 22h	; jne L07A79	;@07A55
	mov	bx, word ptr [bp-1Eh]	;@07A57
	cmp	byte ptr cs:[bx], 0AEh	;@07A5A
	db	75h, 19h	; jne L07A79	;@07A5E
Y06280	ends

Y07A60	segment para public 'CODE'
	assume	cs:Y07A60
	db	2Eh, 8Ah, 47h, 2, 0B9h, 5, 0, 8Dh, 5Eh, 0F1h, 43h, 80h, 3Fh, 0	;@07A60
	db	0E0h, 0FAh, 0B4h, 0, 89h, 7, 0E8h, 9Dh, 6, 0EBh, 0D9h
L07A79:	ret	;@07A79
ASM_PARSE_DATA_DIRECTIVE:	cmp	dh, 41h	;@07A7A
	db	75h, 36h	; jne @@3	;@07A7D
	mov	bx, word ptr [bp-1Eh]	;@07A7F
	mov	ax, word ptr cs:[bx]	;@07A82
	cmp	al, 0EAh	;@07A85
	db	75h, 2Ch	; jne @@3	;@07A87
	mov	byte ptr [bp-1Ah], ah	;@07A89
	cmp	word ptr [bp-0Eh], 0	;@07A8C
	je	@@1	;@07A90
	db	0E9h, 0A0h, 1	; jmp ASM_FAIL_SYNTAX	;@07A92
@@1:	db	0E8h, 7Ch, 6	; call ASM_NEXT_TOKEN	;@07A95
@@2:	lea	si, [bp-196h]	;@07A98
	db	0E8h, 0A0h, 1	; call ASM_PARSE_OPERAND_EXPR	;@07A9C
	push	dx	;@07A9F
	db	0E8h, 13h, 0	; call ASM_EMIT_DATA_VALUE	;@07AA0
	db	0E8h, 44h, 0FFh	; call L179E9+1	;@07AA3
	db	5Ah	; pop dx	;@07AA6
	mov	al, 2Ch	;@07AA7
	db	0E8h, 61h, 6	; call ASM_ACCEPT_TOKEN	;@07AA9
	jne	@@2	;@07AAC
	mov	al, 3Bh	;@07AAE
	db	0E8h, 53h, 6	; call ASM_EXPECT_TOKEN	;@07AB0
	xor	ax, ax	;@07AB3
@@3:	ret	;@07AB5
ASM_EMIT_DATA_VALUE:	mov	di, si	;@07AB6
	mov	ax, word ptr [si]	;@07AB8
	mov	dx, word ptr [si+2]	;@07ABA
	mov	cx, word ptr [si+8]	;@07ABD
	or	cx, word ptr [si+0Ah]	;@07AC0
	cmp	byte ptr [bp-1Ah], 2	;@07AC3
	db	74h, 2Fh	; je @@5	;@07AC7
	db	77h, 58h	; ja @@7	;@07AC9
	or	cx, cx	;@07ACB
	je	@@1	;@07ACD
	db	0E9h, 5Bh, 1	; jmp ASM_FAIL_SIZE_COMBINATION	;@07ACF
@@1:	lea	si, [bp-10Eh]	;@07AD2
	cmp	byte ptr [si], 0	;@07AD6
	jne	@@2	;@07AD9
	db	0E8h, 1Ch, 10h	; call ASM_IMM_FITS_BYTE	;@07ADB
	db	75h, 7Fh	; jne @@13	;@07ADE
	db	0EBh, 75h	; jmp short @@11	;@07AE0
@@2:	xor	ax, ax	;@07AE2
	cld	;@07AE4
	lodsb	;@07AE5
	xchg	ax, cx	;@07AE6
	db	0E3h, 0Eh	; jcxz @@4	;@07AE7
@@3:	cld	;@07AE9
	lodsb	;@07AEA
	push	si	;@07AEB
	push	cx	;@07AEC
	db	0E8h, 67h, 0	; call @@11	;@07AED
	db	0E8h, 0F7h, 0FEh	; call L179E9+1	;@07AF0
	db	59h	; pop cx	;@07AF3
	pop	si	;@07AF4
	loop	@@3	;@07AF5
@@4:	ret	;@07AF7
@@5:	cmp	byte ptr [bp-10Eh], 2	;@07AF8
	ja	@@14	;@07AFD
	db	0E8h, 10h, 10h	; call ASM_CHECK_IMM_FITS_WORD	;@07AFF
	jcxz	@@10	;@07B02
	mov	bx, 101h	;@07B04
	cmp	byte ptr [si+13h], bh	;@07B07
	jb	@@6	;@07B0A
	mov	bh, byte ptr [si+13h]	;@07B0C
@@6:	xchg	ax, cx	;@07B0F
	mov	ax, word ptr [bp-18Eh]	;@07B10
	mov	word ptr [bp-182h], ax	;@07B14
	mov	ax, word ptr [bp-18Ch]	;@07B18
	mov	word ptr [bp-180h], ax	;@07B1C
	db	0E9h, 0B9h, 10h	; jmp ASM_QUEUE_EMIT_RECORD	;@07B20
@@7:	cmp	byte ptr [bp-10Eh], 4	;@07B23
	ja	@@14	;@07B28
	jcxz	@@8	;@07B2A
	xchg	ax, cx	;@07B2C
	mov	bx, 301h	;@07B2D
	cmp	byte ptr [si+13h], 0	;@07B30
	je	@@12	;@07B34
	mov	bh, byte ptr [si+13h]	;@07B36
	mov	ax, word ptr [bp-18Eh]	;@07B39
	mov	word ptr [bp-182h], ax	;@07B3D
	mov	ax, word ptr [bp-18Ch]	;@07B41
	mov	word ptr [bp-180h], ax	;@07B45
	db	0E8h, 90h, 10h	; call ASM_QUEUE_EMIT_RECORD	;@07B49
	jmp	short @@9	;@07B4C
@@8:	call	@@10	;@07B4E
@@9:	xchg	ax, dx	;@07B51
@@10:	call	@@11	;@07B52
	xchg	al, ah	;@07B55
@@11:	mov	bl, 0	;@07B57
	mov	cx, ax	;@07B59
@@12:	db	0E8h, 7Eh, 10h	; call ASM_QUEUE_EMIT_RECORD	;@07B5B
	ret	;@07B5E
@@13:	db	0E9h, 0B3h, 0	; jmp ASM_FAIL_NUMBER_OVERFLOW	;@07B5F
@@14:	db	0E9h, 0ACh, 0	; jmp ASM_FAIL_STRING_TOO_LONG	;@07B62
ASM_PARSE_LABEL_PREFIX:	db	0E8h, 7, 6	; call ASM_PEEK_NONBLANK_CHAR	;@07B65
	cmp	al, 3Ah	;@07B68
	jne	@@1	;@07B6A
	lea	bx, [bp-6Ch]	;@07B6C
	push	ss	;@07B6F
	push	bx	;@07B70
	db	9Ah, 25h, 0, 7Fh, 0Bh	; lcall 0xb7f, 0x25	;@07B71
	jne	ASM_REWIND_AND_EXIT	;@07B76
	db	0E8h, 99h, 5	; call ASM_NEXT_TOKEN	;@07B78
	mov	al, 3Ah	;@07B7B
	db	0E8h, 86h, 5	; call ASM_EXPECT_TOKEN	;@07B7D
@@1:	ret	;@07B80
ASM_PARSE_OPERANDS:	mov	byte ptr [bp-1Ch], 0	;@07B81
	mov	ax, word ptr [bp-14h]	;@07B85
	mov	word ptr [bp-16h], ax	;@07B88
	mov	al, 3Bh	;@07B8B
	db	0E8h, 7Dh, 5	; call ASM_ACCEPT_TOKEN	;@07B8D
	jne	@@3	;@07B90
	lea	si, [bp-196h]	;@07B92
	db	0E8h, 0A6h, 0	; call ASM_PARSE_OPERAND_EXPR	;@07B96
	inc	byte ptr [bp-1Ch]	;@07B99
	mov	al, 3Bh	;@07B9C
	db	0E8h, 6Ch, 5	; call ASM_ACCEPT_TOKEN	;@07B9E
	jne	@@3	;@07BA1
	mov	al, 2Ch	;@07BA3
	db	0E8h, 5Eh, 5	; call ASM_EXPECT_TOKEN	;@07BA5
	mov	ax, word ptr [bp-14h]	;@07BA8
	mov	word ptr [bp-18h], ax	;@07BAB
	lea	si, [bp-1AAh]	;@07BAE
	db	0E8h, 8Ah, 0	; call ASM_PARSE_OPERAND_EXPR	;@07BB2
	inc	byte ptr [bp-1Ch]	;@07BB5
	lea	si, [bp-196h]	;@07BB8
	lea	di, [bp-1AAh]	;@07BBC
	mov	ax, word ptr [si+0Ch]	;@07BC0
	mov	cx, word ptr [di+0Ch]	;@07BC3
	mov	word ptr [bp-22h], cx	;@07BC6
	jcxz	@@1	;@07BC9
	or	ax, ax	;@07BCB
	jne	@@2	;@07BCD
	xchg	word ptr [si+0Ch], cx	;@07BCF
	jmp	short @@2	;@07BD2
@@1:	xchg	word ptr [di+0Ch], ax	;@07BD4
@@2:	mov	al, 3Bh	;@07BD7
	db	0E8h, 31h, 5	; call ASM_ACCEPT_TOKEN	;@07BD9
	jne	@@3	;@07BDC
	mov	al, 2Ch	;@07BDE
	db	0E8h, 23h, 5	; call ASM_EXPECT_TOKEN	;@07BE0
	lea	si, [bp-1BEh]	;@07BE3
	db	0E8h, 55h, 0	; call ASM_PARSE_OPERAND_EXPR	;@07BE7
	inc	byte ptr [bp-1Ch]	;@07BEA
	mov	al, 3Bh	;@07BED
	db	0E8h, 14h, 5	; call ASM_EXPECT_TOKEN	;@07BEF
@@3:	ret	;@07BF2
ASM_RETURN_ERROR:	cbw	;@07BF3
ASM_REWIND_AND_EXIT:	push	word ptr [bp-14h]	;@07BF4
	pop	word ptr [bp-12h]	;@07BF7
	db	0E9h, 0AAh, 0FDh	; jmp L179A7	;@07BFA
ASM_FAIL_FIELD_IDENT:	db	0B0h, 0F1h	; mov al, 0F1h	;@07BFD
	jmp	ASM_RETURN_ERROR	;@07BFF
ASM_FAIL_DIVIDE_BY_ZERO:	mov	al, 0F2h	;@07C01
	jmp	ASM_RETURN_ERROR	;@07C03
ASM_FAIL_NEEDS_286_287:	mov	al, 0F3h	;@07C05
	jmp	ASM_RETURN_ERROR	;@07C07
ASM_FAIL_BAD_COMBINATION:	mov	al, 0F4h	;@07C09
	jmp	ASM_RETURN_ERROR	;@07C0B
ASM_FAIL_BAD_DIGIT:	mov	al, 0F5h	;@07C0D
	jmp	ASM_RETURN_ERROR	;@07C0F
ASM_FAIL_STRING_TOO_LONG:	mov	al, 0F6h	;@07C11
	jmp	ASM_RETURN_ERROR	;@07C13
ASM_FAIL_NUMBER_OVERFLOW:	mov	al, 0F7h	;@07C15
	jmp	ASM_RETURN_ERROR	;@07C17
ASM_FAIL_INVALID_REGISTER:	mov	al, 0F8h	;@07C19
	jmp	ASM_RETURN_ERROR	;@07C1B
ASM_FAIL_ADD_RELOCATABLES:	mov	al, 0F9h	;@07C1D
	jmp	ASM_RETURN_ERROR	;@07C1F
	db	0B0h, 0FAh, 0EBh, 0CEh	;@07C21
ASM_FAIL_NOT_CONSTANT:	mov	al, 0FBh	;@07C25
	jmp	ASM_RETURN_ERROR	;@07C27
L07C29:	mov	al, 0FCh	;@07C29
	jmp	ASM_RETURN_ERROR	;@07C2B
ASM_FAIL_SIZE_COMBINATION:	mov	al, 0FDh	;@07C2D
	jmp	ASM_RETURN_ERROR	;@07C2F
L07C31:	mov	al, 0FEh	;@07C31
	jmp	ASM_RETURN_ERROR	;@07C33
ASM_FAIL_SYNTAX:	mov	al, 0FFh	;@07C35
	jmp	ASM_RETURN_ERROR	;@07C37
ASM_CHECK_STACK_DEPTH:	cmp	sp, word ptr [bp-8]	;@07C39
	jbe	L07C31	;@07C3C
	ret	;@07C3E
ASM_PARSE_OPERAND_EXPR:	call	ASM_CHECK_STACK_DEPTH	;@07C3F
	db	0E8h, 93h, 4	; call ASM_CLEAR_OPERAND	;@07C42
	call	L07C55	;@07C45
	cmp	byte ptr [si+12h], 67h	;@07C48
	jne	@@1	;@07C4C
	test	byte ptr [si+0Eh], 40h	;@07C4E
	je	L07C29	;@07C52
@@1:	ret	;@07C54
L07C55:	call	ASM_EXPR_AND	;@07C55
@@1:	mov	bx, 328h	;@07C58
	db	0E8h, 54h, 4	; call ASM_MATCH_OPERATOR_TABLE	;@07C5B
	je	@@2	;@07C5E
	db	0E8h, 91h, 4	; call ASM_REQUIRE_IMMEDIATE	;@07C60
	db	0E8h, 68h, 4	; call ASM_PUSH_TEMP_OPERAND	;@07C63
	call	ASM_EXPR_AND	;@07C66
	db	0E8h, 88h, 4	; call ASM_REQUIRE_IMMEDIATE	;@07C69
	db	0E8h, 78h, 4	; call ASM_POP_TEMP_OPERAND	;@07C6C
	mov	ax, word ptr [di]	;@07C6F
	mov	cx, word ptr [di+2]	;@07C71
	call	bx	;@07C74
	add	sp, 14h	;@07C76
	jmp	@@1	;@07C79
@@2:	ret	;@07C7B
ASM_OP_OR:	or	word ptr [si], ax	;@07C7C
	or	word ptr [si+2], cx	;@07C7E
	ret	;@07C81
ASM_OP_XOR:	xor	word ptr [si], ax	;@07C82
	xor	word ptr [si+2], cx	;@07C84
	ret	;@07C87
ASM_OR_XOR_OPS_TABLE:	dec	ax	;@07C88
	hlt	;@07C89
	dec	word ptr [bx+di-6]	;@07C8A
	inc	word ptr [bx+si]	;@07C8D
ASM_EXPR_AND:	call	@@3	;@07C8F
@@1:	mov	al, 4Ah	;@07C92
	db	0E8h, 76h, 4	; call ASM_ACCEPT_TOKEN	;@07C94
	je	@@2	;@07C97
	db	0E8h, 58h, 4	; call ASM_REQUIRE_IMMEDIATE	;@07C99
	db	0E8h, 2Fh, 4	; call ASM_PUSH_TEMP_OPERAND	;@07C9C
	call	@@3	;@07C9F
	db	0E8h, 4Fh, 4	; call ASM_REQUIRE_IMMEDIATE	;@07CA2
	db	0E8h, 3Fh, 4	; call ASM_POP_TEMP_OPERAND	;@07CA5
	mov	ax, word ptr [di]	;@07CA8
	and	word ptr [si], ax	;@07CAA
	mov	ax, word ptr [di+2]	;@07CAC
	and	word ptr [si+2], ax	;@07CAF
	add	sp, 14h	;@07CB2
	jmp	@@1	;@07CB5
@@2:	ret	;@07CB7
@@3:	call	ASM_CHECK_STACK_DEPTH	;@07CB8
	mov	bx, 374h	;@07CBB
	db	0E8h, 0F1h, 3	; call ASM_MATCH_OPERATOR_TABLE	;@07CBE
	je	@@4	;@07CC1
	call	@@3	;@07CC3
	db	0E8h, 2Bh, 4	; call ASM_REQUIRE_IMMEDIATE	;@07CC6
	not	word ptr [si]	;@07CC9
	not	word ptr [si+2]	;@07CCB
	mov	byte ptr [bp-10Eh], 0	;@07CCE
	ret	;@07CD3
	db	43h, 0, 0, 0	;@07CD4
@@4:	call	@@7	;@07CD8
@@5:	mov	bx, 3ACh	;@07CDB
	db	0E8h, 0D1h, 3	; call ASM_MATCH_OPERATOR_TABLE	;@07CDE
	je	@@6	;@07CE1
	db	0E8h, 0E8h, 3	; call ASM_PUSH_TEMP_OPERAND	;@07CE3
	call	@@7	;@07CE6
	db	0E8h, 0FBh, 3	; call ASM_POP_TEMP_OPERAND	;@07CE9
	call	bx	;@07CEC
	add	sp, 14h	;@07CEE
	jmp	@@5	;@07CF1
	db	87h, 0F7h, 0E8h, 0F6h, 3, 87h, 0F7h, 0F7h, 1Dh, 83h, 55h, 2, 0	;@07CF3
	db	0F7h, 5Dh, 2, 0E8h, 0CEh, 2, 0C6h, 86h, 0F2h, 0FEh, 0
@@6:	ret	;@07D0B
	db	2Bh, 0F7h, 0FFh, 2Dh, 0E7h, 0FFh, 0	;@07D0C
@@7:	call	L07D89	;@07D13
@@8:	mov	bx, 419h	;@07D16
	db	0E8h, 96h, 3	; call ASM_MATCH_OPERATOR_TABLE	;@07D19
	je	@@9	;@07D1C
	db	0E8h, 0D3h, 3	; call ASM_REQUIRE_IMMEDIATE	;@07D1E
	db	0E8h, 0AAh, 3	; call ASM_PUSH_TEMP_OPERAND	;@07D21
	call	L07D89	;@07D24
	db	0E8h, 0CAh, 3	; call ASM_REQUIRE_IMMEDIATE	;@07D27
	db	0E8h, 0BAh, 3	; call ASM_POP_TEMP_OPERAND	;@07D2A
	push	dx	;@07D2D
	mov	ax, word ptr [si]	;@07D2E
	mov	dx, word ptr [si+2]	;@07D30
	mov	cx, word ptr [di]	;@07D33
	call	bx	;@07D35
	mov	word ptr [si], ax	;@07D37
	mov	word ptr [si+2], dx	;@07D39
	pop	dx	;@07D3C
	add	sp, 14h	;@07D3D
	jmp	@@8	;@07D40
	db	0F7h, 0D9h, 81h, 0E1h, 3Fh, 80h, 78h, 9, 74h, 19h, 0D1h, 0EAh	;@07D42
	db	0D1h, 0D8h, 0E2h, 0FAh, 0C3h, 0F7h, 0D9h, 70h, 0Eh, 81h, 0E1h
	db	3Fh, 80h, 78h, 0E5h, 74h, 6, 0D1h, 0E0h, 0D1h, 0D2h, 0E2h, 0FAh
@@9:	ret	;@07D65
	db	8Bh, 5Dh, 2, 0E9h, 0C4h, 6, 8Bh, 5Dh, 2, 0E9h, 0D9h, 6, 0E8h, 0F7h	;@07D66
	db	0FFh, 91h, 87h, 0D3h, 0C3h
ASM_MUL_DIV_SHIFT_OPS_TABLE:	sub	ch, ch	;@07D79
	jmp	dword ptr [bx]	;@07D7B
	db	0F3h, 0FFh, 4Bh, 0F9h, 0FFh, 4Ch, 0CBh, 0FFh, 4Dh, 0DEh, 0FFh	;@07D7D
	db	0
L07D89:	call	ASM_CHECK_STACK_DEPTH	;@07D89
	mov	bx, 4D9h	;@07D8C
	db	0E8h, 20h, 3	; call ASM_MATCH_OPERATOR_TABLE	;@07D8F
	je	@@1	;@07D92
	push	bx	;@07D94
	db	0E8h, 40h, 3	; call ASM_CLEAR_OPERAND	;@07D95
	jmp	L07D89	;@07D98
@@1:	call	L07E43	;@07D9A
	mov	al, 50h	;@07D9D
	db	0E8h, 6Bh, 3	; call ASM_ACCEPT_TOKEN	;@07D9F
	jne	@@2	;@07DA2
	cmp	byte ptr [si+10h], 2	;@07DA4
	jne	L07DFC	;@07DA8
	cmp	byte ptr [si+12h], 65h	;@07DAA
	jne	L07DFC	;@07DAE
	mov	al, 3Ah	;@07DB0
	db	0E8h, 58h, 3	; call ASM_ACCEPT_TOKEN	;@07DB2
	je	L07DFC	;@07DB5
	push	word ptr [si+11h]	;@07DB7
	db	0E8h, 1Bh, 3	; call ASM_CLEAR_OPERAND	;@07DBA
	call	L07D89	;@07DBD
	pop	ax	;@07DC0
	mov	cl, 3	;@07DC1
	shl	al, cl	;@07DC3
	or	al, 26h	;@07DC5
	mov	byte ptr [si+0Fh], al	;@07DC7
	or	byte ptr [si+0Eh], 40h	;@07DCA
	db	0E8h, 0A0h, 2	; call ASM_MAKE_MEMORY_OPERAND	;@07DCE
	jmp	short L07DFC	;@07DD1
@@2:	db	0E8h, 0F8h, 2	; call ASM_PUSH_TEMP_OPERAND	;@07DD3
	call	L07D89	;@07DD6
	db	0E8h, 0Bh, 3	; call ASM_POP_TEMP_OPERAND	;@07DD9
	push	word ptr [si+0Ch]	;@07DDC
	push	word ptr [si+4]	;@07DDF
	push	word ptr [si+6]	;@07DE2
	db	0E8h, 0D9h, 1	; call ASM_COPY_OPERAND_FROM_DI	;@07DE5
	pop	word ptr [si+6]	;@07DE8
	pop	word ptr [si+4]	;@07DEB
	pop	word ptr [si+0Ch]	;@07DEE
	mov	byte ptr [si+12h], 67h	;@07DF1
	or	byte ptr [si+0Eh], 40h	;@07DF5
	add	sp, 14h	;@07DF9
L07DFC:	ret	;@07DFC
ASM_APPLY_OFFSET_SEG_TYPE:	mov	byte ptr [si+13h], 1	;@07DFD
	jmp	short @@1	;@07E01
	db	0C6h, 44h, 13h, 2, 8Bh, 44h, 2, 89h, 4, 0EBh, 0Dh, 8Bh, 44h, 0Ch	;@07E03
	db	89h, 4, 33h, 0C0h, 89h, 44h, 8, 89h, 44h, 0Ah
@@1:	mov	byte ptr [si+12h], 64h	;@07E1B
	xor	bx, bx	;@07E1F
	mov	byte ptr [si+0Eh], bl	;@07E21
	mov	byte ptr [si+0Fh], bl	;@07E24
	mov	word ptr [si+2], bx	;@07E27
	mov	word ptr [si+0Ch], bx	;@07E2A
	mov	ax, word ptr [si+8]	;@07E2D
	or	ax, word ptr [si+0Ah]	;@07E30
	jne	L07DFC	;@07E33
	mov	byte ptr [si+13h], bl	;@07E35
	ret	;@07E38
	db	44h, 0C4h, 0FFh, 45h, 0CAh, 0FFh, 46h, 0D5h, 0FFh, 0	;@07E39
L07E43:	mov	bx, 503h	;@07E43
	db	0E8h, 69h, 2	; call ASM_MATCH_OPERATOR_TABLE	;@07E46
	je	@@1	;@07E49
	call	ASM_CHECK_STACK_DEPTH	;@07E4B
	push	bx	;@07E4E
	jmp	L07E43	;@07E4F
	db	0E8h, 9Ah, 2, 0F7h, 1Ch, 83h, 54h, 2, 0, 0F7h, 5Ch, 2, 0C6h, 86h	;@07E51
	db	0F2h, 0FEh, 0, 0C3h, 2Bh, 0FAh, 0FFh, 2Dh, 0EEh, 0FFh, 0
@@1:	mov	bx, 526h	;@07E6A
	db	0E8h, 42h, 2	; call ASM_MATCH_OPERATOR_TABLE	;@07E6D
	db	74h, 1Bh	; je ASM_EXPR_POSTFIX	;@07E70
	call	ASM_CHECK_STACK_DEPTH	;@07E72
	push	bx	;@07E75
	jmp	@@1	;@07E76
	db	0B1h, 8, 0D3h, 0Ch, 0C6h, 44h, 1, 0, 0C7h, 44h, 2, 0, 0, 0C3h	;@07E78
ASM_HIGH_LOW_OPS_TABLE:	dec	si	;@07E86
	db	0F2h, 0FFh, 4Fh, 0F6h	; dec word ptr [bx-0Ah]	;@07E87
	db	0FFh, 0	; inc word ptr [bx+si]	;@07E8B
ASM_EXPR_POSTFIX:	call	ASM_CHECK_STACK_DEPTH	;@07E8D
	call	L07EF9	;@07E90
L07E93:	cmp	dh, 2Eh	;@07E93
	je	L07EBE	;@07E96
	cmp	dh, 5Bh	;@07E98
	je	ASM_EXPR_INDEX_OR_MEMBER	;@07E9B
	cmp	dh, 28h	;@07E9D
	je	ASM_EXPR_INDEX_OR_MEMBER	;@07EA0
	ret	;@07EA2
ASM_EXPR_INDEX_OR_MEMBER:	call	ASM_PUSH_TEMP_OPERAND	;@07EA3
	call	L07EF9	;@07EA6
	call	ASM_POP_TEMP_OPERAND	;@07EA9
	mov	cx, word ptr [si+0Ch]	;@07EAC
	jcxz	@@1	;@07EAF
	mov	word ptr [di+0Ch], 0	;@07EB1
@@1:	call	ASM_ADD_OPERANDS	;@07EB6
	add	sp, 14h	;@07EB9
	jmp	L07E93	;@07EBC
L07EBE:	mov	ax, word ptr [si+4]	;@07EBE
	mov	word ptr [bp-3Ah], ax	;@07EC1
	mov	ax, word ptr [si+6]	;@07EC4
	mov	word ptr [bp-38h], ax	;@07EC7
	xor	ax, ax	;@07ECA
	mov	word ptr [si+4], ax	;@07ECC
	mov	word ptr [si+6], ax	;@07ECF
	call	ASM_NEXT_TOKEN	;@07ED2
	call	ASM_PUSH_TEMP_OPERAND	;@07ED5
	call	L07D89	;@07ED8
	call	ASM_POP_TEMP_OPERAND	;@07EDB
	cmp	byte ptr [di+12h], 65h	;@07EDE
	jne	@@1	;@07EE2
	jmp	ASM_FAIL_FIELD_IDENT	;@07EE4
@@1:	mov	cx, word ptr [di+0Ch]	;@07EE7
	jcxz	@@2	;@07EEA
	mov	word ptr [si+0Ch], 0	;@07EEC
@@2:	call	ASM_ADD_OPERANDS	;@07EF1
	add	sp, 14h	;@07EF4
	jmp	L07E93	;@07EF7
L07EF9:	mov	bx, 5B6h	;@07EF9
	call	ASM_MATCH_OPERATOR_TABLE	;@07EFC
	je	ASM_EXPR_PRIMARY	;@07EFF
	push	bx	;@07F01
	call	L07C55	;@07F02
	ret	;@07F05
ASM_EXPECT_CLOSE_BRACKET:	mov	al, 29h	;@07F06
	jmp	short @@1	;@07F08
	db	0E8h, 64h, 1, 80h, 4Ch, 0Eh, 40h, 0B0h, 5Dh	;@07F0A
@@1:	jmp	ASM_EXPECT_TOKEN	;@07F13
ASM_BRACKET_OPS_TABLE:	db	28h, 0F0h	; sub al, dh	;@07F16
	call	dword ptr [bp+di-0Ch]	;@07F18
	inc	word ptr [bx+si]	;@07F1B
ASM_EXPR_PRIMARY:	call	@@1	;@07F1D
	jmp	ASM_NEXT_TOKEN	;@07F20
@@1:	mov	byte ptr [si+12h], dh	;@07F23
	cmp	dh, 65h	;@07F26
	je	@@2	;@07F29
	cmp	dh, 64h	;@07F2B
	je	ASM_TERM_NUMBER	;@07F2E
	cmp	dh, 6Bh	;@07F30
	je	ASM_TERM_SYMBOL	;@07F33
	cmp	dh, 66h	;@07F35
	je	ASM_TERM_SIZE_KEYWORD	;@07F38
	jmp	ASM_FAIL_SYNTAX	;@07F3A
@@2:	mov	ax, word ptr [bp-20h]	;@07F3D
	mov	word ptr [si+10h], ax	;@07F40
	dec	al	;@07F43
	js	@@3	;@07F45
	jne	@@4	;@07F47
	inc	word ptr [si+0Ch]	;@07F49
@@3:	inc	word ptr [si+0Ch]	;@07F4C
@@4:	ret	;@07F4F
ASM_TERM_SIZE_KEYWORD:	mov	byte ptr [si+12h], 64h	;@07F50
	mov	ax, word ptr [bp-36h]	;@07F54
	mov	word ptr [si+0Ch], ax	;@07F57
	ret	;@07F5A
ASM_TERM_NUMBER:	mov	ax, word ptr [bp-36h]	;@07F5B
	mov	word ptr [si], ax	;@07F5E
	mov	ax, word ptr [bp-34h]	;@07F60
	mov	word ptr [si+2], ax	;@07F63
	ret	;@07F66
ASM_TERM_SYMBOL:	mov	byte ptr [si+12h], 67h	;@07F67
	mov	ax, word ptr [bp-3Eh]	;@07F6B
	mov	word ptr [si+0Ch], ax	;@07F6E
	mov	ax, word ptr [bp-42h]	;@07F71
	mov	word ptr [si], ax	;@07F74
	mov	ax, word ptr [bp-40h]	;@07F76
	mov	word ptr [si+2], ax	;@07F79
	mov	ax, word ptr [bp-3Ah]	;@07F7C
	mov	word ptr [si+4], ax	;@07F7F
	mov	ax, word ptr [bp-38h]	;@07F82
	mov	word ptr [si+6], ax	;@07F85
	xor	ax, ax	;@07F88
	mov	word ptr [bp-3Ah], ax	;@07F8A
	mov	word ptr [bp-38h], ax	;@07F8D
	mov	ax, word ptr [bp-46h]	;@07F90
	mov	cx, word ptr [bp-44h]	;@07F93
	inc	cx	;@07F96
	je	ASM_TERM_SYMBOL_NO_FIXUP	;@07F97
	dec	cx	;@07F99
	mov	word ptr [si+8], ax	;@07F9A
	mov	word ptr [si+0Ah], cx	;@07F9D
	test	byte ptr [bp-3Ch], 1	;@07FA0
	je	L07FAA	;@07FA4
	mov	byte ptr [si+0Fh], 2Eh	;@07FA6
L07FAA:	or	byte ptr [si+0Eh], 40h	;@07FAA
	ret	;@07FAE
ASM_TERM_SYMBOL_NO_FIXUP:	cmp	ax, 0FFFEh	;@07FAF
	jb	ASM_TERM_BP_RELATIVE	;@07FB2
	je	L07FBF	;@07FB4
	mov	byte ptr [si+12h], 64h	;@07FB6
	ret	;@07FBA
ASM_TERM_BP_RELATIVE:	mov	byte ptr [si+0Eh], 4	;@07FBB
L07FBF:	jmp	L07FAA	;@07FBF
ASM_COPY_OPERAND_FROM_DI:	push	ds	;@07FC1
	pop	es	;@07FC2
	xchg	si, di	;@07FC3
	mov	cx, 0Ah	;@07FC5
	cld	;@07FC8
	rep movsw	;@07FC9
	sub	si, 14h	;@07FCB
	sub	di, 14h	;@07FCE
	xchg	si, di	;@07FD1
	ret	;@07FD3
ASM_ADD_OPERANDS:	push	dx	;@07FD4
	cmp	byte ptr [di+12h], 64h	;@07FD5
	jne	@@1	;@07FD9
	cmp	byte ptr [si+12h], 64h	;@07FDB
	je	@@2	;@07FDF
	cmp	byte ptr [si+12h], 65h	;@07FE1
	jne	@@1	;@07FE5
	cmp	byte ptr [si+10h], 4	;@07FE7
	jne	@@1	;@07FEB
	mov	ax, word ptr [di]	;@07FED
	add	byte ptr [si+11h], al	;@07FEF
	and	byte ptr [si+11h], 7	;@07FF2
	jmp	short @@8	;@07FF6
@@1:	call	ASM_MAKE_MEMORY_OPERAND	;@07FF8
	xchg	si, di	;@07FFB
	call	ASM_MAKE_MEMORY_OPERAND	;@07FFD
	xchg	si, di	;@08000
@@2:	mov	ax, word ptr [di]	;@08002
	mov	bx, word ptr [di+2]	;@08004
	add	word ptr [si], ax	;@08007
	adc	word ptr [si+2], bx	;@08009
	mov	ax, word ptr [di+4]	;@0800C
	mov	dx, word ptr [di+6]	;@0800F
	or	ax, dx	;@08012
	je	@@3	;@08014
	mov	ax, word ptr [di+4]	;@08016
	mov	word ptr [si+4], ax	;@08019
	mov	ax, word ptr [di+6]	;@0801C
	mov	word ptr [si+6], ax	;@0801F
@@3:	mov	cl, byte ptr [di+13h]	;@08022
	mov	bx, word ptr [di+8]	;@08025
	mov	dx, word ptr [di+0Ah]	;@08028
	mov	ax, dx	;@0802B
	or	ax, bx	;@0802D
	je	@@4	;@0802F
	mov	byte ptr [si+13h], cl	;@08031
	xchg	word ptr [si+8], bx	;@08034
	xchg	word ptr [si+0Ah], dx	;@08037
	or	bx, dx	;@0803A
	je	@@4	;@0803C
	jmp	ASM_FAIL_ADD_RELOCATABLES	;@0803E
@@4:	mov	cx, word ptr [di+0Ch]	;@08041
	jcxz	@@5	;@08044
	xchg	word ptr [si+0Ch], cx	;@08046
@@5:	mov	al, byte ptr [di+0Eh]	;@08049
	mov	ah, al	;@0804C
	and	ah, byte ptr [si+0Eh]	;@0804E
	or	byte ptr [si+0Eh], al	;@08051
	and	ah, 0Fh	;@08054
	je	@@6	;@08057
	jmp	ASM_FAIL_INVALID_REGISTER	;@08059
@@6:	mov	al, byte ptr [di+0Fh]	;@0805C
	or	al, al	;@0805F
	je	@@8	;@08061
	cmp	byte ptr [si+0Fh], 0	;@08063
	jns	@@7	;@08067
	jmp	ASM_FAIL_SYNTAX	;@08069
@@7:	mov	byte ptr [si+0Fh], al	;@0806C
@@8:	pop	dx	;@0806F
	ret	;@08070
ASM_MAKE_MEMORY_OPERAND:	cmp	byte ptr [si+12h], 64h	;@08071
	je	@@2	;@08075
	cmp	byte ptr [si+12h], 65h	;@08077
	jne	@@1	;@0807B
	cmp	byte ptr [si+10h], 1	;@0807D
	jne	ASM_ERROR_INVALID_REGISTER	;@08081
	xor	bx, bx	;@08083
	add	bl, byte ptr [si+11h]	;@08085
	add	bh, byte ptr cs:[bx+747h]	;@08088
	js	ASM_ERROR_INVALID_REGISTER	;@0808D
	mov	byte ptr [si+0Eh], bh	;@0808F
	mov	word ptr [si+0Ch], 0	;@08092
	jmp	short @@2	;@08097
@@1:	cmp	byte ptr [si+12h], 67h	;@08099
	je	@@2	;@0809D
	jmp	L07C29	;@0809F
@@2:	mov	byte ptr [si+12h], 67h	;@080A2
	ret	;@080A6
ASM_REG_ADDRESS_BITS	db	0FFh, 0FFh, 0FFh, 8, 0FFh, 4, 2, 1	;@080A7
ASM_ERROR_INVALID_REGISTER:	jmp	ASM_FAIL_INVALID_REGISTER	;@080AF
ASM_MATCH_OPERATOR_TABLE:	mov	cx, bx	;@080B2
@@1:	mov	al, byte ptr cs:[bx]	;@080B4
	add	bx, 3	;@080B7
	or	al, al	;@080BA
	je	@@2	;@080BC
	cmp	al, dh	;@080BE
	jne	@@1	;@080C0
	mov	bx, word ptr cs:[bx-2]	;@080C2
	add	bx, cx	;@080C6
	call	ASM_NEXT_TOKEN	;@080C8
	or	bx, bx	;@080CB
@@2:	ret	;@080CD
ASM_PUSH_TEMP_OPERAND:	pop	cx	;@080CE
	sub	sp, 14h	;@080CF
	mov	ax, sp	;@080D2
	push	si	;@080D4
	push	bx	;@080D5
	xchg	ax, si	;@080D6
	push	cx	;@080D7
ASM_CLEAR_OPERAND:	push	ds	;@080D8
	pop	es	;@080D9
	xor	ax, ax	;@080DA
	mov	cx, 0Ah	;@080DC
	push	di	;@080DF
	lea	di, [si]	;@080E0
	cld	;@080E2
	rep stosw	;@080E3
	pop	di	;@080E5
	ret	;@080E6
ASM_POP_TEMP_OPERAND:	pop	ax	;@080E7
	pop	bx	;@080E8
	pop	si	;@080E9
	mov	di, sp	;@080EA
	push	ax	;@080EC
	ret	;@080ED
ASM_REQUIRE_CONSTANT:	cmp	byte ptr [si+12h], 67h	;@080EE
	je	L080FA	;@080F2
ASM_REQUIRE_IMMEDIATE:	cmp	byte ptr [si+12h], 64h	;@080F4
	jne	ASM_ERROR_NOT_CONSTANT	;@080F8
L080FA:	mov	ax, word ptr [si+8]	;@080FA
	or	ax, word ptr [si+0Ah]	;@080FD
	jne	ASM_ERROR_NOT_CONSTANT	;@08100
	ret	;@08102
ASM_ERROR_NOT_CONSTANT:	jmp	ASM_FAIL_NOT_CONSTANT	;@08103
ASM_EXPECT_TOKEN:	cmp	al, dh	;@08106
	je	ASM_NEXT_TOKEN	;@08108
	jmp	ASM_FAIL_SYNTAX	;@0810A
ASM_ACCEPT_TOKEN:	cmp	al, dh	;@0810D
	je	ASM_NEXT_TOKEN	;@0810F
	xor	ax, ax	;@08111
	ret	;@08113
ASM_NEXT_TOKEN:	mov	dh, 3Bh	;@08114
	cmp	word ptr [bp+8], 0	;@08116
	jbe	@@3	;@0811A
	push	si	;@0811C
	push	di	;@0811D
	push	bx	;@0811E
	call	ASM_SCAN_WORD	;@0811F
	cmp	byte ptr [bp-1Bh], 1	;@08122
	jne	@@1	;@08126
	call	ASM_LOOKUP_MNEMONIC	;@08128
	jne	@@2	;@0812B
@@1:	call	ASM_GET_PUNCT_TOKEN	;@0812D
	jne	@@2	;@08130
	call	ASM_LOOKUP_KEYWORD	;@08132
	jne	@@2	;@08135
	call	ASM_SCAN_NUMBER_TOKEN	;@08137
	jne	@@2	;@0813A
	cmp	byte ptr [bp-1Bh], 1	;@0813C
	je	@@2	;@08140
	call	ASM_LOOKUP_C_SYMBOL	;@08142
@@2:	pop	bx	;@08145
	pop	di	;@08146
	pop	si	;@08147
@@3:	sub	dh, 1	;@08148
	adc	dh, 1	;@0814B
	ret	;@0814E
ASM_ADVANCE_CHAR:	inc	word ptr [bp-12h]	;@0814F
	dec	word ptr [bp+8]	;@08152
ASM_PEEK_CHAR:	xor	ax, ax	;@08155
	cmp	word ptr [bp+8], ax	;@08157
	jbe	ASM_SET_TEXT_END	;@0815A
	les	bx, dword ptr [bp-12h]	;@0815C
	add	al, byte ptr es:[bx]	;@0815F
	je	ASM_SET_TEXT_END	;@08162
	ret	;@08164
ASM_SET_TEXT_END:	mov	word ptr [bp+8], ax	;@08165
	ret	;@08168
ASM_SKIP_WHITESPACE:	inc	word ptr [bp-12h]	;@08169
	dec	word ptr [bp+8]	;@0816C
ASM_PEEK_NONBLANK_CHAR:	call	ASM_PEEK_CHAR	;@0816F
	je	@@1	;@08172
	cmp	al, 20h	;@08174
	jbe	ASM_SKIP_WHITESPACE	;@08176
	cmp	al, 7Fh	;@08178
	jae	ASM_SKIP_WHITESPACE	;@0817A
@@1:	ret	;@0817C
ASM_SCAN_WORD:	xor	ax, ax	;@0817D
	mov	word ptr [bp-6Ch], ax	;@0817F
	mov	word ptr [bp-8Eh], ax	;@08182
	mov	byte ptr [bp-23h], al	;@08186
	call	ASM_PEEK_NONBLANK_CHAR	;@08189
	mov	word ptr [bp-14h], bx	;@0818C
	je	@@6	;@0818F
	call	ASM_IS_WORD_CHAR	;@08191
	jae	@@5	;@08194
@@1:	mov	si, word ptr [bp-6Ch]	;@08196
	and	si, 0FFh	;@08199
	cmp	si, 20h	;@0819D
	je	@@3	;@081A0
	inc	byte ptr [bp-6Ch]	;@081A2
	inc	byte ptr [bp-8Eh]	;@081A5
	mov	word ptr [bp+si-6Bh], ax	;@081A9
	cmp	al, 61h	;@081AC
	jb	@@2	;@081AE
	and	al, 5Fh	;@081B0
@@2:	mov	word ptr [bp+si-8Dh], ax	;@081B2
	dec	ax	;@081B6
	add	byte ptr [bp-23h], al	;@081B7
@@3:	call	ASM_ADVANCE_CHAR	;@081BA
	je	@@4	;@081BD
	call	ASM_IS_WORD_CHAR	;@081BF
	jb	@@1	;@081C2
@@4:	mov	byte ptr [bp-19h], 1	;@081C4
	cmp	word ptr [bp-8Eh], 4503h	;@081C8
	jne	@@7	;@081CE
	cmp	word ptr [bp-8Ch], 444Eh	;@081D0
	je	@@6	;@081D6
	jmp	short @@7	;@081D8
@@5:	mov	byte ptr [bp-19h], 2	;@081DA
	call	ASM_SCAN_QUOTED_STRING	;@081DE
	je	@@7	;@081E1
	mov	byte ptr [bp-19h], 0	;@081E3
	inc	byte ptr [bp-6Ch]	;@081E7
	mov	word ptr [bp-6Bh], ax	;@081EA
	cmp	al, 3Bh	;@081ED
	je	@@6	;@081EF
	cmp	al, 7Bh	;@081F1
	je	@@6	;@081F3
	xchg	ax, dx	;@081F5
	call	ASM_ADVANCE_CHAR	;@081F6
	mov	ah, dl	;@081F9
	cmp	ax, 282Ah	;@081FB
	jne	@@7	;@081FE
@@6:	mov	byte ptr [bp-19h], 0	;@08200
	mov	word ptr [bp-6Ch], 3B01h	;@08204
	mov	word ptr [bp+8], 0	;@08209
	mov	ax, word ptr [bp-14h]	;@0820E
	mov	word ptr [bp-12h], ax	;@08211
@@7:	ret	;@08214
ASM_SCAN_QUOTED_STRING:	mov	cl, al	;@08215
	cmp	al, 27h	;@08217
	je	ASM_SCAN_STRING_BODY	;@08219
	cmp	al, 22h	;@0821B
	je	ASM_SCAN_STRING_BODY	;@0821D
	ret	;@0821F
ASM_SCAN_STRING_BODY:	mov	byte ptr [bp-10Eh], 0	;@08220
	jmp	short @@3	;@08225
@@1:	mov	si, word ptr [bp-10Eh]	;@08227
	and	si, 0FFh	;@0822B
	cmp	si, 7Fh	;@0822F
	jne	@@2	;@08232
	jmp	ASM_FAIL_STRING_TOO_LONG	;@08234
@@2:	inc	byte ptr [bp-10Eh]	;@08237
	mov	byte ptr [bp+si-10Dh], al	;@0823B
@@3:	call	ASM_ADVANCE_CHAR	;@0823F
	jne	@@4	;@08242
	jmp	ASM_FAIL_STRING_TOO_LONG	;@08244
@@4:	cmp	al, cl	;@08247
	jne	@@1	;@08249
	call	ASM_ADVANCE_CHAR	;@0824B
	cmp	al, cl	;@0824E
	je	@@1	;@08250
	xor	ax, ax	;@08252
	ret	;@08254
ASM_IS_WORD_CHAR:	call	ASM_IS_IDENT_CHAR	;@08255
	jae	ASM_IS_DIGIT	;@08258
	ret	;@0825A
ASM_IS_DIGIT:	push	ax	;@0825B
	sub	al, 3Ah	;@0825C
	add	al, 0Ah	;@0825E
	pop	ax	;@08260
	ret	;@08261
ASM_IS_IDENT_CHAR:	call	ASM_IS_LETTER	;@08262
	jb	@@1	;@08265
	cmp	al, 5Fh	;@08267
	je	@@1	;@08269
	cmp	al, 24h	;@0826B
	je	@@1	;@0826D
	cmp	al, 40h	;@0826F
	je	@@1	;@08271
	cmp	al, 26h	;@08273
	je	@@1	;@08275
	cmp	al, 3Fh	;@08277
	je	@@1	;@08279
	clc	;@0827B
	ret	;@0827C
@@1:	stc	;@0827D
	ret	;@0827E
ASM_IS_LETTER:	push	ax	;@0827F
	sub	al, 5Bh	;@08280
	add	al, 1Ah	;@08282
	jb	@@1	;@08284
	sub	al, 3Ah	;@08286
	add	al, 1Ah	;@08288
@@1:	pop	ax	;@0828A
	ret	;@0828B
ASM_LOOKUP_C_SYMBOL:	lea	bx, [bp-6Ch]	;@0828C
	mov	ax, word ptr [bx]	;@0828F
	cmp	ah, 26h	;@08291
	jne	@@2	;@08294
	inc	bx	;@08296
	dec	al	;@08297
	jne	@@1	;@08299
	jmp	ASM_FAIL_SYNTAX	;@0829B
@@1:	mov	byte ptr [bx], al	;@0829E
@@2:	push	ss	;@082A0
	push	bx	;@082A1
	lea	bx, [bp-4Ah]	;@082A2
	push	ss	;@082A5
	push	bx	;@082A6
	mov	ax, word ptr [bp-3Ah]	;@082A7
	mov	word ptr [bp-4Ah], ax	;@082AA
	mov	ax, word ptr [bp-38h]	;@082AD
	mov	word ptr [bp-48h], ax	;@082B0
	db	9Ah, 39h, 0, 7Fh, 0Bh	; lcall 0xb7f, 0x39	;@082B3
	or	ax, ax	;@082B8
	je	@@3	;@082BA
	jmp	ASM_REWIND_AND_EXIT	;@082BC
@@3:	mov	ax, word ptr [bp-4Ah]	;@082BF
	mov	word ptr [bp-3Ah], ax	;@082C2
	mov	ax, word ptr [bp-48h]	;@082C5
	mov	word ptr [bp-38h], ax	;@082C8
	mov	dh, 6Bh	;@082CB
	ret	;@082CD
ASM_GET_PUNCT_TOKEN:	cmp	byte ptr [bp-19h], 0	;@082CE
	jne	@@1	;@082D2
	mov	dx, word ptr [bp-6Ch]	;@082D4
	cmp	dl, 1	;@082D7
	je	@@2	;@082DA
@@1:	xor	dx, dx	;@082DC
@@2:	or	dh, dh	;@082DE
	ret	;@082E0
ASM_SCAN_NUMBER_TOKEN:	cmp	byte ptr [bp-19h], 1	;@082E1
	je	L0830B	;@082E5
	ja	ASM_CONVERT_LITERAL	;@082E7
L082E9:	xor	ax, ax	;@082E9
	ret	;@082EB
ASM_CONVERT_LITERAL:	lea	si, [bp-10Eh]	;@082EC
	xor	ax, ax	;@082F0
	xor	di, di	;@082F2
	cwd	;@082F4
	cld	;@082F5
	lodsb	;@082F6
	xchg	ax, cx	;@082F7
	jcxz	L08363	;@082F8
@@1:	and	di, 0FFh	;@082FA
	call	ASM_MUL32_BY_16	;@082FE
	call	ASM_MUL32_BY_16	;@08301
	lodsb	;@08304
	mov	dl, al	;@08305
	loop	@@1	;@08307
	jmp	short L08363	;@08309
L0830B:	mov	byte ptr [bp-10Eh], 0	;@0830B
	xor	cx, cx	;@08310
	mov	cl, byte ptr [bp-8Eh]	;@08312
	mov	ax, word ptr [bp-8Dh]	;@08316
	mov	si, 1	;@0831A
	cmp	al, 24h	;@0831D
	je	@@1	;@0831F
	dec	si	;@08321
	call	ASM_IS_DIGIT	;@08322
	jae	L082E9	;@08325
	mov	di, cx	;@08327
	mov	al, byte ptr [bp+di-8Eh]	;@08329
	call	ASM_IS_DIGIT	;@0832D
	mov	bx, 0A20h	;@08330
	jb	@@2	;@08333
	dec	cx	;@08335
	cmp	al, 44h	;@08336
	je	@@2	;@08338
	mov	bx, 0A0Eh	;@0833A
	cmp	al, 42h	;@0833D
	je	@@2	;@0833F
	mov	bx, 0A17h	;@08341
	cmp	al, 4Fh	;@08344
	je	@@2	;@08346
	cmp	al, 48h	;@08348
	jne	ASM_ERROR_BAD_DIGIT	;@0834A
@@1:	sub	cx, si	;@0834C
	mov	bx, 0A29h	;@0834E
@@2:	xor	di, di	;@08351
	xor	dx, dx	;@08353
@@3:	jcxz	L08363	;@08355
	dec	cx	;@08357
	inc	si	;@08358
	xor	ax, ax	;@08359
	mov	al, byte ptr [bp+si-8Eh]	;@0835B
	call	bx	;@0835F
	jmp	@@3	;@08361
L08363:	mov	word ptr [bp-36h], dx	;@08363
	mov	word ptr [bp-34h], di	;@08366
	mov	dh, 64h	;@08369
	or	dh, dh	;@0836B
	ret	;@0836D
ASM_ACCUMULATE_DIGIT:	call	ASM_MUL32_BY_2	;@0836E
	sub	al, 32h	;@08371
	add	al, 2	;@08373
	jmp	short @@1	;@08375
	db	0E8h, 3Ch, 0, 2Ch, 38h, 4, 8, 0EBh, 16h, 0E8h, 1Dh, 0, 2Ch, 3Ah	;@08377
	db	4, 0Ah, 0EBh, 0Dh, 0E8h, 27h, 0, '<:r', 2, 2Ch, 7, 2Ch, 40h, 4
	db	10h
@@1:	jae	ASM_ERROR_BAD_DIGIT	;@08396
	add	dx, ax	;@08398
	adc	di, 0	;@0839A
	jb	L083C6	;@0839D
	ret	;@0839F
ASM_MUL32_BY_10:	push	ax	;@083A0
	call	ASM_MUL32_BY_2	;@083A1
	push	di	;@083A4
	push	dx	;@083A5
	call	ASM_MUL32_BY_4	;@083A6
	pop	ax	;@083A9
	add	dx, ax	;@083AA
	pop	ax	;@083AC
	add	di, ax	;@083AD
	jb	L083C6	;@083AF
	pop	ax	;@083B1
	ret	;@083B2
ASM_MUL32_BY_16:	call	ASM_MUL32_BY_2	;@083B3
ASM_MUL32_BY_8:	call	ASM_MUL32_BY_2	;@083B6
ASM_MUL32_BY_4:	call	ASM_MUL32_BY_2	;@083B9
ASM_MUL32_BY_2:	add	dx, dx	;@083BC
	adc	di, di	;@083BE
	jb	L083C6	;@083C0
	ret	;@083C2
ASM_ERROR_BAD_DIGIT:	jmp	ASM_FAIL_BAD_DIGIT	;@083C3
L083C6:	jmp	ASM_FAIL_NUMBER_OVERFLOW	;@083C6
ASM_LOOKUP_MNEMONIC:	call	L08D22	;@083C9
	call	ASM_HASH_TABLE_LOOKUP	;@083CC
	je	@@1	;@083CF
	mov	word ptr [bp-1Eh], di	;@083D1
	mov	dh, 41h	;@083D4
@@1:	ret	;@083D6
ASM_LOOKUP_KEYWORD:	call	L097B8	;@083D7
	call	ASM_HASH_TABLE_LOOKUP	;@083DA
	je	@@1	;@083DD
	mov	dh, byte ptr cs:[di]	;@083DF
	inc	di	;@083E2
	mov	ax, word ptr cs:[di]	;@083E3
	mov	word ptr [bp-20h], ax	;@083E6
	mov	word ptr [bp-36h], ax	;@083E9
	add	ax, ax	;@083EC
	sbb	ax, ax	;@083EE
	mov	word ptr [bp-34h], ax	;@083F0
	dec	ax	;@083F3
@@1:	ret	;@083F4
ASM_HASH_TABLE_LOOKUP:	cmp	byte ptr [bp-19h], 1	;@083F5
	jne	@@2	;@083F9
	cld	;@083FB
	push	cs	;@083FC
	pop	es	;@083FD
	mov	bl, byte ptr [bp-23h]	;@083FE
	add	bl, bl	;@08401
	and	bx, word ptr es:[di]	;@08403
	mov	bx, word ptr es:[bx+di+2]	;@08406
	or	bx, bx	;@0840A
	je	@@2	;@0840C
	lea	ax, [bp-8Eh]	;@0840E
	mov	dl, byte ptr [bp-8Eh]	;@08412
	mov	dh, 0	;@08416
	inc	dx	;@08418
@@1:	lea	di, [bx+2]	;@08419
	mov	si, ax	;@0841C
	mov	cx, dx	;@0841E
	repe cmpsb	;@08420
	je	@@3	;@08422
	mov	bx, word ptr es:[bx]	;@08424
	or	bx, bx	;@08427
	jne	@@1	;@08429
@@2:	xor	di, di	;@0842B
@@3:	or	di, di	;@0842D
	ret	;@0842F
ASM_MUL32:	push	si	;@08430
	push	di	;@08431
	mov	si, ax	;@08432
	mov	di, dx	;@08434
	mul	cx	;@08436
	push	ax	;@08438
	push	dx	;@08439
	mov	ax, si	;@0843A
	mul	bx	;@0843C
	xchg	ax, bx	;@0843E
	xchg	ax, di	;@0843F
	mul	cx	;@08440
	pop	dx	;@08442
	add	dx, bx	;@08443
	add	dx, ax	;@08445
	pop	ax	;@08447
	pop	di	;@08448
	pop	si	;@08449
	ret	;@0844A
ASM_DIV32:	push	si	;@0844B
	push	di	;@0844C
	push	bp	;@0844D
	mov	si, cx	;@0844E
	or	si, bx	;@08450
	jne	@@1	;@08452
	jmp	ASM_FAIL_DIVIDE_BY_ZERO	;@08454
@@1:	or	bx, bx	;@08457
	pushf	;@08459
	jns	@@2	;@0845A
	neg	cx	;@0845C
	adc	bx, 0	;@0845E
	neg	bx	;@08461
@@2:	or	dx, dx	;@08463
	pushf	;@08465
	jns	@@3	;@08466
	neg	ax	;@08468
	adc	dx, 0	;@0846A
	neg	dx	;@0846D
@@3:	mov	si, cx	;@0846F
	mov	di, bx	;@08471
	xor	cx, cx	;@08473
	xor	bx, bx	;@08475
	mov	bp, 21h	;@08477
@@4:	rcl	cx, 1	;@0847A
	rcl	bx, 1	;@0847C
	sub	cx, si	;@0847E
	sbb	bx, di	;@08480
	jae	@@5	;@08482
	add	cx, si	;@08484
	adc	bx, di	;@08486
@@5:	cmc	;@08488
	rcl	ax, 1	;@08489
	rcl	dx, 1	;@0848B
	dec	bp	;@0848D
	jne	@@4	;@0848E
	popf	;@08490
	jns	@@6	;@08491
	neg	cx	;@08493
	adc	bx, 0	;@08495
	neg	bx	;@08498
	popf	;@0849A
	jns	@@7	;@0849B
	jmp	short @@8	;@0849D
@@6:	popf	;@0849F
	jns	@@8	;@084A0
@@7:	neg	ax	;@084A2
	adc	dx, 0	;@084A4
	neg	dx	;@084A7
@@8:	pop	bp	;@084A9
	pop	di	;@084AA
	pop	si	;@084AB
	ret	;@084AC
	db	0	;@084AD
ASM_ENCODE_INSTRUCTION:	xor	ax, ax	;@084AE
	mov	word ptr [bp-110h], ax	;@084B0
	mov	byte ptr [bp-25h], al	;@084B4
	mov	byte ptr [bp-2Dh], al	;@084B7
	mov	byte ptr [bp-2Eh], al	;@084BA
	mov	bx, word ptr [bp-1Eh]	;@084BD
	mov	bx, word ptr cs:[bx]	;@084C0
	mov	cl, 6	;@084C3
	shr	bh, cl	;@084C5
	cmp	bh, byte ptr [bp-1Ch]	;@084C7
	jne	@@1	;@084CA
	lea	si, [bp-196h]	;@084CC
	lea	di, [bp-1AAh]	;@084D0
	mov	ah, byte ptr [si+12h]	;@084D4
	mov	al, byte ptr [di+12h]	;@084D7
	and	bx, 7Eh	;@084DA
	call	word ptr cs:[bx+1356h]	;@084DD
	je	@@2	;@084E2
@@1:	call	ASM_OPCODE_BYTE_COUNT	;@084E4
	test	byte ptr cs:[bx], 80h	;@084E7
	je	@@4	;@084EB
	add	ax, 2	;@084ED
	add	word ptr [bp-1Eh], ax	;@084F0
	jmp	ASM_ENCODE_INSTRUCTION	;@084F3
@@2:	mov	bx, word ptr [bp-1Eh]	;@084F5
	test	byte ptr cs:[bx+1], 4	;@084F8
	je	@@3	;@084FD
	test	byte ptr [bp+6], 3	;@084FF
	jne	@@3	;@08503
	mov	ax, word ptr [bp-16h]	;@08505
	mov	word ptr [bp-14h], ax	;@08508
	jmp	ASM_FAIL_NEEDS_286_287	;@0850B
@@3:	call	ASM_FLUSH_PENDING_OPCODE	;@0850E
	ret	;@08511
@@4:	mov	ax, word ptr [bp-16h]	;@08512
	cmp	byte ptr [bp-1Ch], 1	;@08515
	jle	@@5	;@08519
	mov	ax, word ptr [bp-18h]	;@0851B
@@5:	mov	word ptr [bp-14h], ax	;@0851E
	jle	@@6	;@08521
	mov	ax, word ptr [bp-18Ah]	;@08523
	cmp	ax, word ptr [bp-19Eh]	;@08527
	je	@@6	;@0852B
	jmp	ASM_FAIL_SIZE_COMBINATION	;@0852D
@@6:	jmp	ASM_FAIL_BAD_COMBINATION	;@08530
ASM_ENCODE_NO_OPERANDS:	call	ASM_BEGIN_OPCODE	;@08533
	xor	ax, ax	;@08536
	ret	;@08538
ASM_REJECT_OPERAND_FORM:	jmp	ASM_FAIL_SYNTAX	;@08539
ASM_ENCODE_NEAR_INDIRECT:	call	ASM_IS_WORD_RM	;@0853C
	jne	@@1	;@0853F
	call	ASM_BEGIN_OPCODE	;@08541
	call	ASM_EMIT_MODRM	;@08544
@@1:	ret	;@08547
ASM_ENCODE_FAR_INDIRECT:	call	ASM_DECODE_RM_OPERAND	;@08548
	jne	@@1	;@0854B
	cmp	al, 0FFh	;@0854D
	jne	@@1	;@0854F
	call	ASM_BEGIN_OPCODE	;@08551
	call	ASM_EMIT_MODRM	;@08554
@@1:	ret	;@08557
ASM_ENCODE_SHORT_JUMP:	cmp	ah, 67h	;@08558
	jne	@@1	;@0855B
	cmp	word ptr [si+0Ch], -3	;@0855D
	jne	@@1	;@08561
	mov	ax, word ptr [si]	;@08563
	or	ax, word ptr [si+2]	;@08565
	jne	@@1	;@08568
	call	ASM_EMIT_PREFIX_LIST	;@0856A
	call	ASM_OPCODE_BYTE_COUNT	;@0856D
	mov	cl, byte ptr cs:[bx+2]	;@08570
	mov	bx, 2	;@08574
	mov	ax, word ptr [si+8]	;@08577
	mov	word ptr [bp-182h], ax	;@0857A
	mov	ax, word ptr [si+0Ah]	;@0857E
	mov	word ptr [bp-180h], ax	;@08581
	call	ASM_QUEUE_EMIT_RECORD	;@08585
@@1:	ret	;@08588
ASM_ENCODE_DIRECT_JUMP:	mov	bh, 0	;@08589
	mov	cx, 0FFFDh	;@0858B
	cmp	word ptr [si+0Ch], cx	;@0858E
	je	@@1	;@08591
	mov	cl, 0FFh	;@08593
	jmp	short @@1	;@08595
	db	0B7h, 3, 0B9h, 0FEh, 0FFh	;@08597
@@1:	cmp	word ptr [si+0Ch], cx	;@0859C
	jne	@@2	;@0859F
	cmp	ah, 67h	;@085A1
	jne	@@2	;@085A4
	cmp	byte ptr [si+0Eh], 40h	;@085A6
	jne	@@2	;@085AA
	push	bx	;@085AC
	call	ASM_EMIT_PREFIX_LIST	;@085AD
	call	ASM_OPCODE_BYTE_COUNT	;@085B0
	mov	cl, byte ptr cs:[bx+2]	;@085B3
	mov	bl, 0	;@085B7
	call	ASM_QUEUE_EMIT_RECORD	;@085B9
	pop	bx	;@085BC
	mov	bl, 1	;@085BD
	mov	cx, word ptr [si]	;@085BF
	mov	dx, word ptr [si+2]	;@085C1
	mov	ax, word ptr [si+8]	;@085C4
	mov	word ptr [bp-182h], ax	;@085C7
	mov	ax, word ptr [si+0Ah]	;@085CB
	mov	word ptr [bp-180h], ax	;@085CE
	call	ASM_QUEUE_EMIT_RECORD	;@085D2
@@2:	ret	;@085D5
ASM_ENCODE_SHIFT_ROTATE:	call	ASM_IS_BYTE_OR_WORD_RM	;@085D6
	jne	@@4	;@085D9
	call	ASM_BEGIN_OPCODE	;@085DB
	call	ASM_IMM_FITS_BYTE	;@085DE
	jne	@@2	;@085E1
	cmp	al, 1	;@085E3
	je	@@3	;@085E5
	test	byte ptr [bp+6], 3	;@085E7
	jne	@@1	;@085EB
	jmp	ASM_FAIL_NEEDS_286_287	;@085ED
@@1:	sub	byte ptr [bp-24h], 10h	;@085F0
	push	ax	;@085F4
	call	ASM_EMIT_MODRM_FORM_REG	;@085F5
	pop	ax	;@085F8
	call	ASM_QUEUE_BYTE	;@085F9
	ret	;@085FC
@@2:	cmp	byte ptr [di+12h], 65h	;@085FD
	jne	@@4	;@08601
	cmp	word ptr [di+10h], 100h	;@08603
	jne	@@4	;@08608
	add	byte ptr [bp-24h], 2	;@0860A
@@3:	call	ASM_EMIT_MODRM_FORM_REG	;@0860E
@@4:	ret	;@08611
ASM_ENCODE_XCHG_REG16_AX:	xchg	al, ah	;@08612
	xchg	si, di	;@08614
	cmp	ax, 6565h	;@08616
	jne	@@1	;@08619
	cmp	word ptr [si+10h], 1	;@0861B
	jne	@@1	;@0861F
	cmp	byte ptr [di+10h], 1	;@08621
	jne	@@1	;@08625
	call	ASM_BEGIN_OPCODE	;@08627
	mov	al, byte ptr [di+11h]	;@0862A
	or	byte ptr [bp-24h], al	;@0862D
	xor	ax, ax	;@08630
@@1:	ret	;@08632
ASM_ENCODE_ENTER:	xchg	si, di	;@08633
	call	ASM_BEGIN_OPCODE	;@08635
	call	ASM_EMIT_IMM16	;@08638
	jne	@@1	;@0863B
	xchg	si, di	;@0863D
	call	ASM_EMIT_IMM8	;@0863F
@@1:	ret	;@08642
ASM_ENCODE_RETURN:	call	ASM_BEGIN_OPCODE	;@08643
	test	byte ptr [bp+7], 1	;@08646
	je	@@1	;@0864A
	or	byte ptr [bp-24h], 8	;@0864C
@@1:	cmp	byte ptr [bp-1Ch], 0	;@08650
	jne	@@2	;@08654
	ret	;@08656
	db	0E8h, 0E3h, 4	;@08657
@@2:	mov	di, si	;@0865A
	or	byte ptr [bp-24h], 1	;@0865C
	call	ASM_IS_IMM_ZERO	;@08660
	jne	@@3	;@08663
	ret	;@08665
@@3:	and	byte ptr [bp-24h], 0FEh	;@08666
	jmp	ASM_EMIT_IMM16	;@0866A
ASM_ENCODE_IMM16_OPERAND:	call	ASM_BEGIN_OPCODE	;@0866D
	xchg	si, di	;@08670
	jmp	ASM_EMIT_IMM16	;@08672
ASM_ENCODE_IMM8_OPERAND:	xchg	si, di	;@08675
	call	ASM_BEGIN_OPCODE	;@08677
	call	ASM_IMM_FITS_SIGNED_BYTE	;@0867A
	jne	@@1	;@0867D
	call	ASM_QUEUE_BYTE	;@0867F
@@1:	ret	;@08682
ASM_ENCODE_IMUL_IMMEDIATE:	cmp	ah, 65h	;@08683
	jne	@@3	;@08686
	cmp	byte ptr [si+10h], 1	;@08688
	jne	@@3	;@0868C
	xchg	si, di	;@0868E
	call	ASM_IS_WORD_RM	;@08690
	jne	@@3	;@08693
	call	ASM_BEGIN_OPCODE	;@08695
	call	ASM_SET_MODRM_REG_FROM_DI	;@08698
	lea	di, [bp-1BEh]	;@0869B
	call	ASM_CHECK_IMM_FITS_WORD	;@0869F
	jne	@@3	;@086A2
	call	ASM_IMM_FITS_SIGNED_BYTE	;@086A4
	pushf	;@086A7
	jne	@@1	;@086A8
	or	byte ptr [bp-24h], 2	;@086AA
@@1:	push	ax	;@086AE
	call	ASM_EMIT_MODRM_NO_SIZE	;@086AF
	pop	ax	;@086B2
	popf	;@086B3
	jne	@@2	;@086B4
	jmp	ASM_QUEUE_BYTE	;@086B6
@@2:	call	ASM_QUEUE_WORD	;@086B9
@@3:	ret	;@086BC
ASM_ENCODE_LEA:	cmp	ax, 6567h	;@086BD
	jne	@@1	;@086C0
	cmp	byte ptr [si+10h], 1	;@086C2
	jne	@@1	;@086C6
	xchg	si, di	;@086C8
	call	ASM_DECODE_RM_OPERAND	;@086CA
	xchg	si, di	;@086CD
	jne	@@1	;@086CF
	mov	byte ptr [bp-2Eh], 0	;@086D1
	call	ASM_BEGIN_OPCODE	;@086D5
	call	ASM_SET_MODRM_REG_FIELD	;@086D8
	call	ASM_EMIT_MODRM_NO_SIZE	;@086DB
@@1:	ret	;@086DE
ASM_ENCODE_OUT_IMM8_ACC:	xchg	si, di	;@086DF
	xchg	al, ah	;@086E1
	call	ASM_EMIT_OPCODE_IF_ACC	;@086E3
	jne	@@1	;@086E6
	call	ASM_EMIT_IMM8	;@086E8
@@1:	ret	;@086EB
ASM_ENCODE_OUT_DX_ACC:	xchg	si, di	;@086EC
	xchg	al, ah	;@086EE
	cmp	al, 65h	;@086F0
	jne	@@1	;@086F2
	cmp	word ptr [di+10h], 201h	;@086F4
	jne	@@1	;@086F9
	call	ASM_EMIT_OPCODE_IF_ACC	;@086FB
@@1:	ret	;@086FE
ASM_EMIT_OPCODE_IF_ACC:	cmp	ah, 65h	;@086FF
	jne	@@1	;@08702
	cmp	byte ptr [si+11h], 0	;@08704
	jne	@@1	;@08708
	call	ASM_BEGIN_OPCODE	;@0870A
	mov	al, byte ptr [si+10h]	;@0870D
	cmp	al, 1	;@08710
	ja	@@1	;@08712
	or	byte ptr [bp-24h], al	;@08714
	xor	ax, ax	;@08717
@@1:	ret	;@08719
ASM_ENCODE_INT:	call	ASM_BEGIN_OPCODE	;@0871A
	mov	di, si	;@0871D
	call	ASM_IMM_FITS_BYTE	;@0871F
	jne	@@1	;@08722
	cmp	al, 3	;@08724
	je	@@1	;@08726
	inc	byte ptr [bp-24h]	;@08728
	call	ASM_QUEUE_BYTE	;@0872B
@@1:	ret	;@0872E
ASM_ENCODE_MOV_SREG_RM:	xchg	al, ah	;@0872F
	xchg	si, di	;@08731
	mov	bl, byte ptr [di+11h]	;@08733
	sub	bl, 1	;@08736
	jne	@@1	;@08739
	dec	bx	;@0873B
	ret	;@0873C
@@1:	cmp	al, 65h	;@0873D
	jne	@@3	;@0873F
	cmp	byte ptr [di+10h], 2	;@08741
	jne	@@3	;@08745
	call	ASM_DECODE_RM_OPERAND	;@08747
	jne	@@3	;@0874A
	cmp	al, 1	;@0874C
	je	@@2	;@0874E
	cmp	word ptr [si+0Ch], 0	;@08750
	jne	@@3	;@08754
@@2:	call	ASM_BEGIN_OPCODE	;@08756
	call	ASM_SET_MODRM_REG_FROM_DI	;@08759
	call	ASM_EMIT_MODRM_NO_SIZE	;@0875C
@@3:	ret	;@0875F
ASM_ENCODE_MOV_REG_IMM:	cmp	ax, 6564h	;@08760
	jne	@@2	;@08763
	cmp	byte ptr [si+10h], 1	;@08765
	ja	@@2	;@08769
	call	ASM_BEGIN_OPCODE	;@0876B
	mov	al, byte ptr [si+11h]	;@0876E
	or	byte ptr [bp-24h], al	;@08771
	cmp	byte ptr [si+10h], 0	;@08774
	je	@@1	;@08778
	or	byte ptr [bp-24h], 8	;@0877A
	jmp	ASM_EMIT_IMM16	;@0877E
@@1:	call	ASM_EMIT_IMM8	;@08781
@@2:	ret	;@08784
ASM_ENCODE_UNARY_RM:	call	ASM_IS_BYTE_OR_WORD_RM	;@08785
	jne	@@1	;@08788
	call	ASM_BEGIN_OPCODE	;@0878A
	call	ASM_EMIT_MODRM_FORM_REG	;@0878D
@@1:	ret	;@08790
ASM_ENCODE_MOV_ACC_MOFFS:	xchg	al, ah	;@08791
	xchg	si, di	;@08793
	cmp	ax, 6765h	;@08795
	jne	@@1	;@08798
	cmp	byte ptr [di+11h], 0	;@0879A
	jne	@@1	;@0879E
	call	ASM_IS_DIRECT_ADDRESS	;@087A0
	jne	@@1	;@087A3
	call	ASM_BEGIN_OPCODE	;@087A5
	mov	al, byte ptr [di+10h]	;@087A8
	cmp	al, 1	;@087AB
	ja	@@1	;@087AD
	cmp	al, byte ptr [bp-2Ch]	;@087AF
	jne	@@1	;@087B2
	or	byte ptr [bp-24h], al	;@087B4
	call	ASM_EMIT_DISPLACEMENT	;@087B7
@@1:	ret	;@087BA
ASM_ENCODE_TEST_XCHG_RM:	push	ax	;@087BB
	call	@@1	;@087BC
	pop	ax	;@087BF
	je	@@2	;@087C0
	xchg	si, di	;@087C2
	xchg	al, ah	;@087C4
@@1:	cmp	al, 65h	;@087C6
	jne	@@2	;@087C8
	cmp	byte ptr [di+10h], 1	;@087CA
	ja	@@2	;@087CE
	call	ASM_IS_BYTE_OR_WORD_RM	;@087D0
	jne	@@2	;@087D3
	call	ASM_BEGIN_OPCODE	;@087D5
	call	ASM_SET_MODRM_REG_FROM_DI	;@087D8
	mov	al, byte ptr [di+10h]	;@087DB
	cmp	al, byte ptr [bp-2Ch]	;@087DE
	jne	@@2	;@087E1
	call	ASM_EMIT_MODRM_BYTES	;@087E3
@@2:	ret	;@087E6
ASM_ENCODE_LDS_LES:	cmp	ax, 6567h	;@087E7
	jne	@@2	;@087EA
	cmp	byte ptr [si+10h], 1	;@087EC
	jne	@@2	;@087F0
	xchg	si, di	;@087F2
	call	ASM_DECODE_RM_OPERAND	;@087F4
	cmp	word ptr [bp-22h], 0	;@087F7
	je	@@1	;@087FB
	cmp	al, 0FFh	;@087FD
	jne	@@2	;@087FF
@@1:	call	ASM_BEGIN_OPCODE	;@08801
	call	ASM_SET_MODRM_REG_FROM_DI	;@08804
	call	ASM_EMIT_MODRM_NO_SIZE	;@08807
@@2:	ret	;@0880A
ASM_ENCODE_LAR_LSL:	xchg	si, di	;@0880B
	xchg	al, ah	;@0880D
	cmp	al, 65h	;@0880F
	jne	@@1	;@08811
	cmp	byte ptr [di+10h], 1	;@08813
	jne	@@1	;@08817
	call	ASM_IS_WORD_RM	;@08819
	jne	@@1	;@0881C
	call	ASM_BEGIN_OPCODE	;@0881E
	call	ASM_SET_MODRM_REG_FROM_DI	;@08821
	call	ASM_EMIT_MODRM_NO_SIZE	;@08824
@@1:	ret	;@08827
ASM_ENCODE_DESCRIPTOR_MEM:	call	ASM_DECODE_RM_OPERAND	;@08828
	jne	@@2	;@0882B
	cmp	word ptr [si+0Ch], 6	;@0882D
	je	@@1	;@08831
	cmp	word ptr [si+0Ch], 0	;@08833
	jne	@@2	;@08837
@@1:	call	ASM_BEGIN_OPCODE	;@08839
	call	ASM_EMIT_MODRM	;@0883C
@@2:	ret	;@0883F
ASM_ENCODE_RM_REG:	cmp	al, 65h	;@08840
	je	@@1	;@08842
	cmp	ah, 65h	;@08844
	jne	@@2	;@08847
	mov	byte ptr [bp-2Dh], 2	;@08849
	xchg	si, di	;@0884D
@@1:	cmp	byte ptr [di+10h], 1	;@0884F
	ja	@@2	;@08853
	call	ASM_IS_BYTE_OR_WORD_RM	;@08855
	jne	@@2	;@08858
	call	ASM_BEGIN_OPCODE	;@0885A
	call	ASM_SET_MODRM_REG_FROM_DI	;@0885D
	mov	al, byte ptr [di+10h]	;@08860
	cmp	al, byte ptr [bp-2Ch]	;@08863
	jne	@@2	;@08866
	call	ASM_EMIT_MODRM_BYTES	;@08868
@@2:	ret	;@0886B
ASM_ENCODE_RM16:	call	ASM_IS_WORD_RM	;@0886C
	jne	@@1	;@0886F
	call	ASM_BEGIN_OPCODE	;@08871
	call	ASM_EMIT_MODRM	;@08874
@@1:	ret	;@08877
ASM_ENCODE_ALU_RM_IMM:	call	ASM_CHECK_IMM_FITS_WORD	;@08878
	jne	@@3	;@0887B
	call	ASM_IS_BYTE_OR_WORD_RM	;@0887D
	jne	@@3	;@08880
	call	ASM_BEGIN_OPCODE	;@08882
	cmp	byte ptr [bp-2Ch], 0	;@08885
	je	@@1	;@08889
	call	ASM_IMM_FITS_SIGNED_BYTE	;@0888B
	jne	@@2	;@0888E
	or	byte ptr [bp-24h], 2	;@08890
@@1:	call	ASM_IMM_FITS_BYTE	;@08894
	jne	@@3	;@08897
	call	ASM_EMIT_MODRM_FORM_REG	;@08899
	jne	@@3	;@0889C
	call	ASM_EMIT_IMM8	;@0889E
	jmp	short @@3	;@088A1
@@2:	call	ASM_EMIT_MODRM_FORM_REG	;@088A3
	jne	@@3	;@088A6
	call	ASM_EMIT_IMM16	;@088A8
@@3:	ret	;@088AB
ASM_ENCODE_RM_IMM:	cmp	al, 64h	;@088AC
	jne	@@2	;@088AE
	call	ASM_IS_BYTE_OR_WORD_RM	;@088B0
	jne	@@2	;@088B3
	call	ASM_BEGIN_OPCODE	;@088B5
	call	ASM_EMIT_MODRM_FORM_REG	;@088B8
	cmp	byte ptr [bp-2Ch], 1	;@088BB
	je	@@1	;@088BF
	jmp	ASM_EMIT_IMM8	;@088C1
@@1:	jmp	ASM_EMIT_IMM16	;@088C4
@@2:	ret	;@088C7
ASM_ENCODE_ACC_IMM:	cmp	ax, 6564h	;@088C8
	jne	@@2	;@088CB
	call	ASM_CHECK_IMM_FITS_WORD	;@088CD
	jne	@@2	;@088D0
	cmp	byte ptr [si+11h], 0	;@088D2
	jne	@@2	;@088D6
	cmp	byte ptr [si+10h], 1	;@088D8
	ja	@@2	;@088DC
	jne	@@1	;@088DE
	call	ASM_BEGIN_OPCODE	;@088E0
	inc	byte ptr [bp-24h]	;@088E3
	call	ASM_EMIT_IMM16	;@088E6
	jmp	short @@2	;@088E9
@@1:	call	ASM_IMM_FITS_BYTE	;@088EB
	jne	@@2	;@088EE
	call	ASM_BEGIN_OPCODE	;@088F0
	call	ASM_EMIT_IMM8	;@088F3
@@2:	ret	;@088F6
ASM_ENCODE_REG16_IN_OPCODE:	cmp	ah, 65h	;@088F7
	jne	@@1	;@088FA
	cmp	byte ptr [si+10h], 1	;@088FC
	jne	@@1	;@08900
	call	ASM_BEGIN_OPCODE	;@08902
	mov	al, byte ptr [si+11h]	;@08905
	or	byte ptr [bp-24h], al	;@08908
	xor	ax, ax	;@0890B
@@1:	ret	;@0890D
ASM_ENCODE_PUSH_POP_SREG:	mov	cl, 1	;@0890E
	jmp	short @@1	;@08910
	db	0B1h, 0FFh	;@08912
@@1:	cmp	ah, 65h	;@08914
	jne	@@2	;@08917
	cmp	byte ptr [si+10h], 2	;@08919
	jne	@@2	;@0891D
	cmp	byte ptr [si+11h], cl	;@0891F
	je	@@3	;@08922
	call	ASM_BEGIN_OPCODE	;@08924
	mov	al, byte ptr [si+11h]	;@08927
	mov	cl, 3	;@0892A
	shl	al, cl	;@0892C
	or	byte ptr [bp-24h], al	;@0892E
	xor	ax, ax	;@08931
@@2:	ret	;@08933
@@3:	inc	ax	;@08934
	ret	;@08935
ASM_ENCODE_FSTSW_AX:	cmp	ah, 65h	;@08936
	jne	L08985	;@08939
	cmp	word ptr [si+10h], 1	;@0893B
	jne	L08985	;@0893F
ASM_EMIT_FPU_OPCODE:	mov	al, 0	;@08941
ASM_EMIT_FPU_OPCODE_BITS:	xchg	ax, dx	;@08943
	call	ASM_EMIT_PREFIX_LIST	;@08944
	call	ASM_OPCODE_BYTE_COUNT	;@08947
	mov	dh, 0	;@0894A
	test	byte ptr [bp+6], 3	;@0894C
	jne	@@1	;@08950
	mov	dh, 1	;@08952
@@1:	mov	cx, word ptr cs:[bx+2]	;@08954
	cmp	cl, 1	;@08958
	ja	@@2	;@0895B
	mov	dh, cl	;@0895D
	inc	bx	;@0895F
	dec	ax	;@08960
	jmp	@@1	;@08961
@@2:	cmp	cl, 9Bh	;@08963
	jne	@@3	;@08966
	xor	dh, dh	;@08968
@@3:	or	cl, dl	;@0896A
	mov	ah, ch	;@0896C
	mov	bl, 3	;@0896E
	mov	bh, byte ptr [bp-2Eh]	;@08970
	mov	byte ptr [bp-2Eh], 0	;@08973
	or	bh, dh	;@08977
	call	ASM_QUEUE_EMIT_RECORD	;@08979
	dec	ax	;@0897C
	mov	byte ptr [bp-25h], al	;@0897D
	mov	byte ptr [bp-24h], ah	;@08980
	xor	ax, ax	;@08983
L08985:	ret	;@08985
ASM_ENCODE_FPU_MEM_SIZED:	mov	cx, 0FDFDh	;@08986
	jmp	short @@1	;@08989
	db	0B9h, 0FEh, 0FEh, 0EBh, 18h, 0B9h, 1, 0FFh, 0EBh, 13h, 83h, 7Ch	;@0898B
	db	0Ch, 0, 75h, 5, 0C7h, 44h, 0Ch, 2, 0, 0B9h, 1, 1, 0EBh, 3, 0B9h
	db	0FEh, 0FFh
@@1:	cmp	ah, 67h	;@089A8
	jne	@@3	;@089AB
	push	cx	;@089AD
	call	ASM_DECODE_RM_OPERAND	;@089AE
	pop	cx	;@089B1
	jne	@@3	;@089B2
	mov	al, 0	;@089B4
	cmp	byte ptr [bp-2Ch], ch	;@089B6
	je	@@2	;@089B9
	cmp	byte ptr [bp-2Ch], cl	;@089BB
	jne	@@3	;@089BE
	or	al, 4	;@089C0
@@2:	call	ASM_EMIT_FPU_OPCODE_BITS	;@089C2
	call	ASM_EMIT_MODRM	;@089C5
@@3:	ret	;@089C8
ASM_ENCODE_FPU_ENV_MEM:	mov	cx, 0Eh	;@089C9
	jmp	short @@1	;@089CC
	db	0B9h, 5Eh, 0	;@089CE
@@1:	cmp	word ptr [si+0Ch], cx	;@089D1
	je	@@2	;@089D4
	cmp	word ptr [si+0Ch], 0	;@089D6
	jne	@@3	;@089DA
@@2:	cmp	ah, 67h	;@089DC
	jne	@@3	;@089DF
	call	ASM_DECODE_RM_OPERAND	;@089E1
	jne	@@3	;@089E4
	call	ASM_EMIT_FPU_OPCODE	;@089E6
	call	ASM_EMIT_MODRM	;@089E9
@@3:	ret	;@089EC
ASM_ENCODE_FPU_STI:	mov	al, 65h	;@089ED
	jmp	short @@1	;@089EF
	db	87h, 0F7h, 86h, 0C4h, 83h, 7Dh, 10h, 4, 75h, 16h	;@089F1
@@1:	cmp	ax, 6565h	;@089FB
	jne	@@2	;@089FE
	cmp	byte ptr [si+10h], 4	;@08A00
	jne	@@2	;@08A04
	call	ASM_EMIT_FPU_OPCODE	;@08A06
	mov	al, byte ptr [si+11h]	;@08A09
	or	byte ptr [bp-24h], al	;@08A0C
	xor	ax, ax	;@08A0F
@@2:	ret	;@08A11
ASM_IS_DIRECT_ADDRESS:	call	ASM_DECODE_RM_OPERAND	;@08A12
	jne	@@1	;@08A15
	cmp	byte ptr [bp-2Bh], 1	;@08A17
@@1:	ret	;@08A1B
ASM_IS_BYTE_OR_WORD_RM:	call	ASM_DECODE_RM_OPERAND	;@08A1C
	jne	@@1	;@08A1F
	test	al, 0FEh	;@08A21
@@1:	ret	;@08A23
ASM_IS_WORD_RM:	call	ASM_DECODE_RM_OPERAND	;@08A24
	jne	@@1	;@08A27
	cmp	al, 1	;@08A29
@@1:	ret	;@08A2B
ASM_DECODE_RM_OPERAND:	mov	ax, word ptr [si+8]	;@08A2C
	mov	word ptr [bp-2Ah], ax	;@08A2F
	mov	ax, word ptr [si+0Ah]	;@08A32
	mov	word ptr [bp-28h], ax	;@08A35
	mov	word ptr [bp-30h], 0	;@08A38
	mov	byte ptr [bp-2Eh], 0	;@08A3D
	cmp	byte ptr [si+12h], 65h	;@08A41
	je	@@6	;@08A45
	cmp	byte ptr [si+12h], 67h	;@08A47
	jne	@@8	;@08A4B
	mov	al, byte ptr [si+13h]	;@08A4D
	or	al, al	;@08A50
	jne	@@1	;@08A52
	inc	ax	;@08A54
@@1:	mov	byte ptr [bp-31h], al	;@08A55
	mov	ax, 601h	;@08A58
	mov	bl, byte ptr [si+0Eh]	;@08A5B
	and	bx, 0Fh	;@08A5E
	je	@@3	;@08A61
	mov	ah, byte ptr cs:[bx+1166h]	;@08A63
	or	ah, ah	;@08A68
	jns	@@2	;@08A6A
	jmp	ASM_FAIL_INVALID_REGISTER	;@08A6C
@@2:	dec	ax	;@08A6F
@@3:	mov	byte ptr [bp-2Bh], al	;@08A70
	mov	cx, word ptr [si]	;@08A73
	mov	word ptr [bp-30h], cx	;@08A75
	mov	cl, 0FCh	;@08A78
	mov	bx, word ptr [si+0Ch]	;@08A7A
	cmp	bx, 0Ah	;@08A7D
	ja	@@4	;@08A80
	mov	cl, byte ptr cs:[bx+1176h]	;@08A82
@@4:	mov	byte ptr [bp-2Ch], cl	;@08A87
	mov	byte ptr [bp-26h], ah	;@08A8A
	mov	ah, byte ptr [si+0Fh]	;@08A8D
	or	ah, ah	;@08A90
	je	@@7	;@08A92
	mov	al, 3Eh	;@08A94
	cmp	byte ptr [bp-2Bh], 1	;@08A96
	je	@@5	;@08A9A
	test	byte ptr [si+0Eh], 4	;@08A9C
	je	@@5	;@08AA0
	mov	al, 36h	;@08AA2
@@5:	cmp	al, ah	;@08AA4
	je	@@7	;@08AA6
	mov	byte ptr [bp-2Eh], ah	;@08AA8
	jmp	short @@7	;@08AAB
@@6:	mov	byte ptr [bp-2Bh], 0	;@08AAD
	mov	ax, word ptr [si+10h]	;@08AB1
	or	ah, 0C0h	;@08AB4
	mov	byte ptr [bp-26h], ah	;@08AB7
	cmp	al, 1	;@08ABA
	ja	@@8	;@08ABC
	mov	byte ptr [bp-2Ch], al	;@08ABE
@@7:	xor	ax, ax	;@08AC1
@@8:	mov	al, byte ptr [bp-2Ch]	;@08AC3
	ret	;@08AC6
ASM_MODRM_RM_SIZE_TABLE:	add	ax, 0FF04h	;@08AC7
	push	es	;@08ACA
	add	ax, word ptr [bp+si]	;@08ACB
	inc	word ptr [bx]	;@08ACD
	add	word ptr [bx+si], ax	;@08ACF
	db	0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FCh, 0, 1, 0FCh, 0FFh, 0FCh, 0FCh	;@08AD1
	db	0FCh, 0FEh, 0FCh, 0FDh
ASM_IMM_FITS_SIGNED_BYTE:	cmp	byte ptr [di+12h], 64h	;@08AE1
	jne	@@1	;@08AE5
	cmp	byte ptr [di+13h], 0	;@08AE7
	jne	@@1	;@08AEB
	mov	al, byte ptr [di]	;@08AED
	cbw	;@08AEF
	cwd	;@08AF0
	cmp	ah, byte ptr [di+1]	;@08AF1
	jne	@@1	;@08AF4
	cmp	dx, word ptr [di+2]	;@08AF6
@@1:	ret	;@08AF9
ASM_IMM_FITS_BYTE:	call	ASM_CHECK_IMM_FITS_WORD	;@08AFA
	jne	@@2	;@08AFD
	cmp	byte ptr [di+13h], 0	;@08AFF
	jne	@@2	;@08B03
	or	dx, dx	;@08B05
	js	@@1	;@08B07
	or	ah, ah	;@08B09
	ret	;@08B0B
@@1:	mov	dx, ax	;@08B0C
	cbw	;@08B0E
	cmp	ax, dx	;@08B0F
@@2:	ret	;@08B11
ASM_CHECK_IMM_FITS_WORD:	cmp	byte ptr [di+12h], 64h	;@08B12
	jne	@@1	;@08B16
	mov	ax, word ptr [di]	;@08B18
	cwd	;@08B1A
	cmp	word ptr [di+2], dx	;@08B1B
	je	@@1	;@08B1E
	xor	dx, dx	;@08B20
	cmp	word ptr [di+2], dx	;@08B22
	je	@@1	;@08B25
	jmp	ASM_FAIL_NUMBER_OVERFLOW	;@08B27
@@1:	ret	;@08B2A
ASM_SET_MODRM_REG_FIELD:	mov	al, byte ptr [si+11h]	;@08B2B
	jmp	short L08B33	;@08B2E
ASM_SET_MODRM_REG_FROM_DI:	mov	al, byte ptr [di+11h]	;@08B30
L08B33:	shl	al, 1	;@08B33
	shl	al, 1	;@08B35
	shl	al, 1	;@08B37
	or	byte ptr [bp-26h], al	;@08B39
	ret	;@08B3C
ASM_BEGIN_OPCODE:	call	ASM_EMIT_PREFIX_LIST	;@08B3D
	mov	al, byte ptr [bp-2Eh]	;@08B40
	or	al, al	;@08B43
	je	@@1	;@08B45
	call	ASM_QUEUE_BYTE	;@08B47
@@1:	call	ASM_EMIT_OPCODE_BYTES	;@08B4A
	inc	byte ptr [bp-25h]	;@08B4D
	mov	byte ptr [bp-24h], al	;@08B50
	ret	;@08B53
ASM_EMIT_OPCODE_BYTES:	call	ASM_OPCODE_BYTE_COUNT	;@08B54
	xchg	ax, cx	;@08B57
	dec	cx	;@08B58
	je	@@2	;@08B59
	js	@@2	;@08B5B
@@1:	call	@@2	;@08B5D
	call	ASM_QUEUE_BYTE	;@08B60
	loop	@@1	;@08B63
@@2:	mov	al, byte ptr cs:[bx+2]	;@08B65
	inc	bx	;@08B69
	ret	;@08B6A
ASM_EMIT_PREFIX_LIST:	lea	bx, [bp-0Eh]	;@08B6B
@@1:	xor	ax, ax	;@08B6E
	add	al, byte ptr ss:[bx]	;@08B70
	je	@@2	;@08B73
	call	ASM_QUEUE_BYTE	;@08B75
	inc	bx	;@08B78
	jmp	@@1	;@08B79
@@2:	ret	;@08B7B
ASM_FLUSH_PENDING_OPCODE:	push	ax	;@08B7C
	xor	ax, ax	;@08B7D
	xchg	byte ptr [bp-25h], al	;@08B7F
	or	al, al	;@08B82
	je	@@1	;@08B84
	mov	al, byte ptr [bp-24h]	;@08B86
	call	ASM_QUEUE_BYTE	;@08B89
@@1:	pop	ax	;@08B8C
	ret	;@08B8D
ASM_IS_IMM_ZERO:	cmp	byte ptr [di+13h], 0	;@08B8E
	jne	@@1	;@08B92
	call	ASM_CHECK_IMM_FITS_WORD	;@08B94
	jne	@@1	;@08B97
	or	ax, ax	;@08B99
@@1:	ret	;@08B9B
ASM_EMIT_IMM16:	mov	bh, byte ptr [di+13h]	;@08B9C
	or	bh, bh	;@08B9F
	jne	@@1	;@08BA1
	call	ASM_CHECK_IMM_FITS_WORD	;@08BA3
	je	ASM_QUEUE_WORD	;@08BA6
	ret	;@08BA8
@@1:	mov	bl, 1	;@08BA9
	mov	cx, word ptr [di]	;@08BAB
	mov	dx, word ptr [di+2]	;@08BAD
	mov	ax, word ptr [di+8]	;@08BB0
	mov	word ptr [bp-182h], ax	;@08BB3
	mov	ax, word ptr [di+0Ah]	;@08BB7
	mov	word ptr [bp-180h], ax	;@08BBA
	call	ASM_QUEUE_EMIT_RECORD	;@08BBE
	ret	;@08BC1
ASM_EMIT_IMM8:	call	ASM_IMM_FITS_BYTE	;@08BC2
	je	ASM_QUEUE_BYTE	;@08BC5
	ret	;@08BC7
ASM_QUEUE_WORD:	call	ASM_QUEUE_BYTE	;@08BC8
	xchg	al, ah	;@08BCB
ASM_QUEUE_BYTE:	call	ASM_FLUSH_PENDING_OPCODE	;@08BCD
	push	bx	;@08BD0
	push	cx	;@08BD1
	mov	bl, 0	;@08BD2
	mov	cx, ax	;@08BD4
	call	ASM_QUEUE_EMIT_RECORD	;@08BD6
	pop	cx	;@08BD9
	pop	bx	;@08BDA
	ret	;@08BDB
ASM_QUEUE_EMIT_RECORD:	call	ASM_FLUSH_PENDING_OPCODE	;@08BDC
	push	si	;@08BDF
	mov	si, word ptr [bp-110h]	;@08BE0
	cmp	si, 6Eh	;@08BE4
	jne	@@1	;@08BE7
	jmp	ASM_FAIL_SYNTAX	;@08BE9
@@1:	mov	word ptr [bp+si-17Eh], bx	;@08BEC
	mov	word ptr [bp+si-17Ch], cx	;@08BF0
	mov	word ptr [bp+si-17Ah], dx	;@08BF4
	push	word ptr [bp-182h]	;@08BF8
	pop	word ptr [bp+si-178h]	;@08BFC
	push	word ptr [bp-180h]	;@08C00
	pop	word ptr [bp+si-176h]	;@08C04
	add	word ptr [bp-110h], 0Ah	;@08C08
	pop	si	;@08C0D
	cmp	ax, ax	;@08C0E
	ret	;@08C10
ASM_EMIT_DISPLACEMENT:	mov	ax, word ptr [bp-30h]	;@08C11
	mov	cx, word ptr [bp-2Ah]	;@08C14
	or	cx, word ptr [bp-28h]	;@08C17
	je	ASM_QUEUE_WORD	;@08C1A
	xchg	ax, cx	;@08C1C
	xor	dx, dx	;@08C1D
	mov	bl, 1	;@08C1F
	mov	bh, byte ptr [bp-31h]	;@08C21
	mov	ax, word ptr [bp-2Ah]	;@08C24
	mov	word ptr [bp-182h], ax	;@08C27
	mov	ax, word ptr [bp-28h]	;@08C2B
	mov	word ptr [bp-180h], ax	;@08C2E
	jmp	ASM_QUEUE_EMIT_RECORD	;@08C32
ASM_EMIT_MODRM:	mov	byte ptr [bp-2Ch], 0	;@08C34
ASM_EMIT_MODRM_FORM_REG:	call	L08CAE	;@08C38
	and	al, 38h	;@08C3B
	or	byte ptr [bp-26h], al	;@08C3D
	cmp	byte ptr [bp-2Dh], 0	;@08C40
	je	ASM_EMIT_MODRM_BYTES	;@08C44
	ret	;@08C46
ASM_EMIT_MODRM_NO_SIZE:	mov	byte ptr [bp-2Ch], 0	;@08C47
ASM_EMIT_MODRM_BYTES:	mov	al, byte ptr [bp-2Ch]	;@08C4B
	or	al, byte ptr [bp-2Dh]	;@08C4E
	or	byte ptr [bp-24h], al	;@08C51
	mov	al, byte ptr [bp-26h]	;@08C54
	mov	ah, al	;@08C57
	and	ax, 0C7C0h	;@08C59
	cmp	al, 0C0h	;@08C5C
	je	@@5	;@08C5E
	cmp	byte ptr [bp-2Bh], 1	;@08C60
	je	@@3	;@08C64
	mov	cx, word ptr [bp-2Ah]	;@08C66
	or	cx, word ptr [bp-28h]	;@08C69
	jne	@@2	;@08C6C
	mov	cx, word ptr [bp-30h]	;@08C6E
	cmp	ah, 6	;@08C71
	je	@@1	;@08C74
	jcxz	@@5	;@08C76
@@1:	mov	ax, cx	;@08C78
	cbw	;@08C7A
	cmp	ax, cx	;@08C7B
	je	@@4	;@08C7D
@@2:	or	byte ptr [bp-26h], 80h	;@08C7F
@@3:	call	@@5	;@08C83
	call	ASM_EMIT_DISPLACEMENT	;@08C86
	jmp	short @@7	;@08C89
@@4:	or	byte ptr [bp-26h], 40h	;@08C8B
	call	@@5	;@08C8F
	mov	ax, word ptr [bp-30h]	;@08C92
	jmp	short @@6	;@08C95
@@5:	mov	al, byte ptr [bp-26h]	;@08C97
@@6:	call	ASM_QUEUE_BYTE	;@08C9A
@@7:	cmp	byte ptr [bp-2Ch], 0FDh	;@08C9D
	ja	@@8	;@08CA1
	xor	ax, ax	;@08CA3
@@8:	ret	;@08CA5
ASM_OPCODE_BYTE_COUNT:	call	L08CAE	;@08CA6
	and	ax, 3	;@08CA9
	inc	ax	;@08CAC
	ret	;@08CAD
L08CAE:	mov	bx, word ptr [bp-1Eh]	;@08CAE
	mov	al, byte ptr cs:[bx+1]	;@08CB1
	ret	;@08CB5
	db	0D3h, 0Bh, 0Dh, 0Dh, 15h, 0Dh, 5Dh, 0Dh, 8Ch, 0Dh, 7Fh, 0Dh, 90h	;@08CB6
	db	0Dh, 83h, 0Dh, 0B2h, 0Ch, 0B6h, 0Ch, 0BAh, 0Dh, 0D3h, 0Ch, 68h
	db	0Fh, 0, 0Eh, 0DCh, 0Bh, 37h, 0Ch, 0E8h, 0Bh, 0F8h, 0Bh, 29h, 0Ch
	db	35h, 0Eh, 31h, 0Eh, 0E3h, 0Ch, 0F7h, 0Ch, 0D9h, 0Bh, 0B2h, 0Fh
	db	0AEh, 0Fh, 97h, 0Fh, 0C8h, 0Eh, 0ABh, 0Eh, 0AFh, 0Eh, 23h, 0Dh
	db	0CFh, 0Dh, 0DDh, 0Dh, 0E0h, 0Eh, 5Bh, 0Eh, 0Ch, 0Fh, 18h, 0Fh
	db	4Ch, 0Fh, 25h, 0Eh, 87h, 0Eh, 76h, 0Ch, 0E1h, 0Fh, 0D6h, 0Fh, 8Dh
	db	10h, 95h, 10h, 91h, 10h, 45h, 10h, 26h, 10h, 35h, 10h, 30h, 10h
	db	2Bh, 10h, 69h, 10h, 6Eh, 10h, 0D9h, 0Bh
L08D22:	mov	di, 13C6h	;@08D22
	ret	;@08D25
	db	1Eh, 0, 1Ah, 1Eh, 0A1h, 1Bh, 35h, 1Eh, 6Bh, 1Ch, 0DAh, 1Ch, 0CDh	;@08D26
	db	1Dh, 31h, 1Dh, 0A6h, 1Dh, 3Ch, 1Dh, 0Dh, 1Dh, 99h, 1Dh, 0C0h, 1Dh
	db	0ABh, 1Ch, 27h, 1Eh, 0B4h, 1Dh, 46h, 1Eh, 0, 0, 2, 44h, 42h, 0EAh
	db	1, 0, 0, 2, 44h, 57h, 0EAh, 2, 0, 0, 2, 44h, 44h, 0EAh, 4, 0, 0
	db	4, 'LOCK', 0AEh, 0, 0F0h, 0E8h, 13h, 3, 'REP', 0AEh, 0, 0F3h, 0
	db	0, 4, 'REPE', 0AEh, 0, 0F3h, 0, 0, 4, 'REPZ', 0AEh, 0, 0F3h, 0FDh
	db	13h, 5, 'REPNE', 0AEh, 0, 0F2h, 0, 0, 5, 'REPNZ', 0AEh, 0, 0F2h
	db	0, 0, 5, 'SEGES', 0AEh, 0, 26h, 0, 0, 5, 'SEGCS', 0AEh, 0, 2Eh
	db	45h, 14h, 5, 'SEGSS', 0AEh, 0, 36h, 0, 0, 5, 'SEGDS', 0AEh, 0
	db	3Eh, 24h, 14h, 3, 'ADC', 98h, 80h, 14h, 0C2h, 80h, 10h, 48h, 90h
	db	80h, 0F6h, 13h, 3, 'ADD', 98h, 80h, 4, 0C2h, 80h, 0, 48h, 80h
	db	80h, 50h, 14h, 3, 'AND', 98h, 80h, 24h, 0C2h, 80h, 20h, 4Ah, 0A0h
	db	80h, 84h, 14h, 3, 'AAA', 0, 0, 37h, 3Ah, 14h, 3, 'AAS', 0, 0, 3Fh
	db	0, 0, 3, 'AAD', 80h, 1, 0D5h, 0Ah, 4, 40h, 0D5h, 0, 0, 3, 'AAM'
	db	80h, 1, 0D4h, 0Ah, 4, 40h, 0D4h, 0A5h, 14h, 5, 'BOUNDN', 84h, 62h
	db	10h, 14h, 4, 'CALL', 0A4h, 40h, 0E8h, 9Eh, 40h, 9Ah, 9Ch, 50h
	db	0FFh, 20h, 58h, 0FFh, 1Ah, 14h, 3, 'CMP', 98h, 80h, 3Ch, 0C2h
	db	80h, 38h, 48h, 0B8h, 80h, 0EFh, 13h, 3, 'CBW', 0, 0, 98h, 0, 0
	db	3, 'CWD', 0, 0, 99h, 0, 0, 3, 'CLC', 0, 0, 0F8h, 93h, 14h, 3, 'CLD'
	db	0, 0, 0FCh, 66h, 14h, 3, 'CLI', 0, 0, 0FAh, 7, 15h, 3, 'CMC', 0
	db	0, 0F5h, 19h, 15h, 5, 'CMPSB', 0, 0, 0A6h, 10h, 15h, 5, 'CMPSW'
	db	0, 0, 0A7h, 0BFh, 14h, 3, 'DAA', 0, 0, 27h, 2Dh, 15h, 3, 'DAS'
	db	0, 0, 2Fh, 0ECh, 14h, 3, 'DEC', 0B4h, '@HLH', 0FEh, 22h, 15h, 3
	db	'DIVLp', 0F6h, 4Ah, 15h, 5, 'ENTER', 16h, 84h, 0C8h, 41h, 15h
	db	3, 'HLT', 0, 0, 0F4h, 0CAh, 14h, 4, 'IDIVLx', 0F6h, 38h, 15h, 4
	db	'IMUL', 0CCh, 68h, 0F6h, 3Ch, 0C4h, 69h, 6Ah, 15h, 2, 49h, 4Eh
	db	8Ch, 80h, 0ECh, 0Eh, 80h, 0E4h, 0, 0, 3, 'INC', 0B4h, '@@L@', 0FEh
	db	73h, 15h, 4, 'INSB', 0, 4, 6Ch, 0DDh, 14h, 4, 'INSW', 0, 4, 6Dh
	db	0A1h, 15h, 3, 'INT', 14h, 40h, 0CCh, 75h, 14h, 4, 'INTO', 0, 0
	db	0CEh, 56h, 15h, 4, 'IRET', 0, 0, 0CFh, 7, 14h, 3, 'JMP', 0A2h
	db	40h, 0EBh, 0A4h, 40h, 0E9h, 9Eh, 40h, 0EAh, 9Ch, 60h, 0FFh, 20h
	db	68h, 0FFh, 95h, 15h, 2, 'JO"@p', 0D2h, 15h, 3, 'JNO"@q', 0F5h
	db	14h, 2, 'JC"@r/', 14h, 2, 'JB"@r', 0, 16h, 4, 'JNAE"@r', 0B5h
	db	15h, 3, 'JNC"@s', 0ABh, 15h, 3, 'JAE"@s', 0E7h, 15h, 3, 'JNB"@s'
	db	1Bh, 16h, 2, 'JE"@t', 9Ch, 14h, 2, 'JZ"@t', 8, 16h, 3, 'JNE"@u'
	db	0FEh, 14h, 3, 'JNZ"@u', 0, 0, 3, 'JBE"@v', 0BEh, 15h, 3, 'JNA"@v_'
	db	15h, 2, 'JA"@w', 0F8h, 15h, 4, 'JNBE"@wi', 16h, 2, 'JS"@x', 12h
	db	16h, 3, 'JNS"@y{', 16h, 2, 'JP"@z', 0B2h, 14h, 3, 'JPE"@z', 8Ah
	db	15h, 3, 'JNP"@{X', 16h, 3, 'JPO"@{', 0EFh, 15h, 2, 'JL"@|', 0C8h
	db	15h, 4, 'JNGE"@|}', 15h, 3, 'JGE"@}[', 14h, 3, 'JNL"@}', 84h, 16h
	db	3, 'JLE"@~', 8Ch, 16h, 3, 'JNG"@~F', 16h, 2, 'JG"@', 7Fh, 95h
	db	16h, 4, 'JNLE"@', 7Fh, 73h, 16h, 4, 'JCXZ"@', 0E3h, 24h, 16h, 4
	db	'LAHF', 0, 0, 9Fh, 0AFh, 16h, 3, 'LDSN', 80h, 0C5h, 0DDh, 16h
	db	3, 'LEA', 6, 80h, 8Dh, 0CBh, 16h, 5, 'LEAVE', 0, 4, 0C9h, 0C2h
	db	16h, 3, 'LESN', 80h, 0C4h, 0Ch, 17h, 5, 'LODSB', 0, 0, 0ACh, 0A7h
	db	16h, 5, 'LODSW', 0, 0, 0ADh, 9Eh, 16h, 4, 'LOOP"@', 0E2h, 3Dh
	db	16h, 5, 'LOOPE"@', 0E1h, 29h, 17h, 5, 'LOOPZ"@', 0E1h, 0F9h, 16h
	db	6, 'LOOPNE"@', 0E0h, 0D4h, 16h, 6, 'LOOPNZ"@', 0E0h, 54h, 17h
	db	3, 'MOV', 0A8h, 80h, 0A0h, 0A6h, 80h, 0A2h, 9Ah, 80h, 0B0h, 0CAh
	db	80h, 0C6h, 0C2h, 80h, 88h, 0C0h, 80h, 8Ch, 3Eh, 80h, 8Eh, 35h
	db	16h, 5, 'MOVSB', 0, 0, 0A4h, 5Fh, 17h, 5, 'MOVSW', 0, 0, 0A5h
	db	0EFh, 16h, 3, 'MULL`', 0F6h, 9Dh, 17h, 3, 'NEGLX', 0F6h, 49h, 17h
	db	3, 'NOP', 0, 0, 90h, 4Fh, 16h, 3, 'NOTLP', 0F6h, 77h, 17h, 2, 4Fh
	db	52h, 98h, 80h, 0Ch, 0C2h, 80h, 8, 4Ah, 88h, 80h, 0E5h, 16h, 3
	db	'OUT', 88h, 80h, 0EEh, 0Ah, 80h, 0E6h, 15h, 17h, 5, 'OUTSB', 0
	db	4, 6Eh, 2Dh, 16h, 5, 'OUTSW', 0, 4, 6Fh, 6Bh, 17h, 3, 'POP', 0B4h
	db	40h, 58h, 0B2h, 40h, 7, 46h, 40h, 8Fh, 0FCh, 17h, 4, 'POPA', 0
	db	4, 61h, 20h, 17h, 4, 'POPF', 0, 0, 9Dh, 0Bh, 18h, 4, 'PUSH', 0B4h
	db	40h, 50h, 0B0h, 40h, 6, 0C6h, 70h, 0FFh, 84h, 44h, 6Ah, 2, 44h
	db	68h, 1Fh, 18h, 5, 'PUSHA', 0, 4, 60h, 15h, 18h, 5, 'PUSHF', 0
	db	0, 9Ch, 0E6h, 17h, 3, 'RET', 0AAh, 0, 0C3h, 2Ah, 40h, 0C2h, 0DAh
	db	17h, 4, 'RETN', 80h, 0, 0C3h, 2Ch, 40h, 0C2h, 0F1h, 17h, 4, 'RETF'
	db	80h, 0, 0CBh, 2Ch, 40h, 0CAh, 0B1h, 17h, 3, 'SUB', 98h, 80h, 2Ch
	db	0C2h, 80h, 28h, 48h, 0A8h, 80h, 34h, 17h, 3, 'SBB', 98h, 80h, 1Ch
	db	0C2h, 80h, 18h, 48h, 98h, 80h, 0C3h, 17h, 3, 'RCLP', 90h, 0D0h
	db	80h, 18h, 3, 'RCRP', 98h, 0D0h, 0BAh, 17h, 3, 'ROLP', 80h, 0D0h
	db	3, 17h, 3, 'RORP', 88h, 0D0h, 64h, 18h, 3, 'SALP', 0A0h, 0D0h
	db	98h, 18h, 3, 'SHLP', 0A0h, 0D0h, 0B9h, 16h, 3, 'SARP', 0B8h, 0D0h
	db	0A1h, 18h, 3, 'SHRP', 0A8h, 0D0h, 8Fh, 18h, 4, 'SAHF', 0, 0, 9Eh
	db	71h, 18h, 5, 'SCASB', 0, 0, 0AEh, 35h, 18h, 5, 'SCASW', 0, 0, 0AFh
	db	0E1h, 18h, 3, 'STC', 0, 0, 0F9h, 4Bh, 18h, 3, 'STD', 0, 0, 0FDh
	db	0B3h, 18h, 3, 'STI', 0, 0, 0FBh, 3Fh, 17h, 5, 'STOSB', 0, 0, 0AAh
	db	0A8h, 17h, 5, 'STOSW', 0, 0, 0ABh, 0ECh, 18h, 4, 'TEST', 98h, 80h
	db	0A8h, 0CAh, 80h, 0F6h, 44h, 80h, 84h, 40h, 18h, 4, 'WAIT', 0, 0
	db	9Bh, 12h, 19h, 4, 'XCHG', 90h, 80h, 90h, 92h, 80h, 90h, 44h, 80h
	db	86h, 57h, 18h, 4, 'XLAT', 0, 0, 0D7h, 42h, 19h, 3, 'XOR', 98h
	db	80h, 34h, 0C2h, 80h, 30h, 4Ah, 0B0h, 80h, 1Dh, 19h, 4, 'ARPL:'
	db	84h, 63h, 28h, 19h, 3, 'LAR8', 85h, 0Fh, 2, 92h, 17h, 4, 'CLTS'
	db	0, 5, 0Fh, 6, 0F7h, 18h, 4, 'LGDT6U', 0Fh, 1, 0D7h, 18h, 4, 'SGDT6E'
	db	0Fh, 1, 61h, 16h, 4, 'LIDT6]', 0Fh, 1, 0AAh, 18h, 4, 'SIDT6M'
	db	0Fh, 1, 75h, 19h, 4, 'LLDTFU', 0Fh, 0, 0C5h, 18h, 4, 'SLDTFE'
	db	0Fh, 0, 0CCh, 17h, 4, 'LMSWFu', 0Fh, 1, 5Ch, 19h, 4, 'SMSWFe'
	db	0Fh, 1, 0, 19h, 3, 'LSL8', 85h, 0Fh, 3, 0CCh, 19h, 3, 'LTRF]'
	db	0Fh, 0, 0D7h, 19h, 3, 'STRFM', 0Fh, 0, 6Bh, 19h, 4, 'VERRFe', 0Fh
	db	0, 0ABh, 19h, 4, 'VERWFm', 0Fh, 0, 0C1h, 19h, 3, 'FLD', 0D2h, 1
	db	0D9h, 0C1h, 0D6h, 41h, 0D9h, 0C0h, 0DCh, 40h, 0D9h, 5Eh, 68h, 0DBh
	db	0, 1Ah, 4, 'FILD', 0E2h, 40h, 0DBh, 64h, 68h, 0DFh, 0CEh, 18h
	db	3, 'FST', 0D2h, 1, 0DDh, 0D1h, 0D6h, 41h, 0DDh, 0D0h, 5Ch, 50h
	db	0D9h, 0A0h, 19h, 4, 'FSTP', 0D2h, 1, 0DDh, 0D9h, 0D6h, 41h, 0DDh
	db	0D8h, 0DCh, 58h, 0D9h, 5Eh, 78h, 0DBh, 7Fh, 19h, 4, 'FISTbP', 0DBh
	db	38h, 19h, 5, 'FISTP', 0E2h, 58h, 0DBh, 64h, 78h, 0DFh, 2Ah, 1Ah
	db	4, 'FADD', 0D2h, 1, 0DEh, 0C1h, 0DAh, 81h, 0D8h, 0C0h, 0D8h, 81h
	db	0DCh, 0C0h, 5Ch, 40h, 0D8h, 37h, 1Ah, 5, 'FADDP', 0D2h, 1, 0DEh
	db	0C1h, 58h, 81h, 0DEh, 0C0h, 16h, 1Ah, 5, 'FIADDb@', 0DAh, 0B6h
	db	19h, 4, 'FSUB', 0D2h, 1, 0DEh, 0E9h, 0DAh, 81h, 0D8h, 0E0h, 0D8h
	db	81h, 0DCh, 0E8h, 5Ch, 60h, 0D8h, 75h, 1Ah, 5, 'FSUBP', 0D2h, 1
	db	0DEh, 0E9h, 58h, 81h, 0DEh, 0E8h, 9, 19h, 5, 'FSUBR', 0D2h, 1
	db	0DEh, 0E1h, 0DAh, 81h, 0D8h, 0E8h, 0D8h, 81h, 0DCh, 0E0h, 5Ch
	db	68h, 0D8h, 0A6h, 1Ah, 6, 'FSUBRP', 0D2h, 1, 0DEh, 0E1h, 58h, 81h
	db	0DEh, 0E0h, 0BCh, 18h, 5, 'FISUBb`', 0DAh, 52h, 19h, 6, 'FISUBRbh'
	db	0DAh, 0Bh, 1Ah, 4, 'FMUL', 0D2h, 1, 0DEh, 0C9h, 0DAh, 81h, 0D8h
	db	0C8h, 0D8h, 81h, 0DCh, 0C8h, 5Ch, 48h, 0D8h, 0ECh, 19h, 5, 'FMULP'
	db	0D2h, 1, 0DEh, 0C9h, 58h, 81h, 0DEh, 0C8h, 0E2h, 19h, 5, 'FIMULbH'
	db	0DAh, 0FFh, 1Ah, 4, 'FDIV', 0D2h, 1, 0DEh, 0F9h, 0DAh, 81h, 0D8h
	db	0F0h, 0D8h, 81h, 0DCh, 0F8h, 5Ch, 70h, 0D8h, 0F4h, 1Ah, 5, 'FDIVP'
	db	0D2h, 1, 0DEh, 0F9h, 58h, 81h, 0DEh, 0F8h, 0F6h, 19h, 5, 'FDIVR'
	db	0D2h, 1, 0DEh, 0F1h, 0DAh, 81h, 0D8h, 0F8h, 0D8h, 81h, 0DCh, 0F0h
	db	5Ch, 78h, 0D8h, 3Ch, 1Bh, 6, 'FDIVRP', 0D2h, 1, 0DEh, 0F1h, 58h
	db	81h, 0DEh, 0F0h, 0CCh, 1Ah, 5, 'FIDIVbp', 0DAh, 95h, 19h, 6, 'FIDIVRbx'
	db	0DAh, 67h, 1Ah, 4, 'FCOM', 0D2h, 1, 0D8h, 0D1h, 0D6h, 41h, 0D8h
	db	0D0h, 5Ch, 50h, 0D8h, 0Bh, 1Bh, 5, 'FCOMP', 0D2h, 1, 0D8h, 0D9h
	db	0D6h, 41h, 0D8h, 0D8h, 5Ch, 58h, 0D8h, 21h, 1Bh, 6, 'FCOMPPR'
	db	1, 0DEh, 0D9h, 48h, 1Ah, 5, 'FICOMbP', 0DAh, 31h, 1Bh, 6, 'FICOMPbX'
	db	0DAh, 0D3h, 1Bh, 5, 'F2XM1R', 1, 0D9h, 0F0h, 0DEh, 1Bh, 4, 'FABSR'
	db	1, 0D9h, 0E1h, 52h, 1Bh, 4, 'FBLD^`', 0DFh, 8Bh, 1Ah, 5, 'FBSTP^p'
	db	0DFh, 0B3h, 1Bh, 4, 'FCHSR', 1, 0D9h, 0E0h, 5Dh, 1Ah, 7, 'FDECSTPR'
	db	1, 0D9h, 0F6h, 9Bh, 1Ah, 5, 'FFREEVA', 0DDh, 0C0h, 16h, 1Ch, 7
	db	'FINCSTPR', 1, 0D9h, 0F7h, 2Fh, 1Ch, 4, 'FLD1R', 1, 0D9h, 0E8h
	db	0BCh, 1Ah, 5, 'FLDCW`h', 0D9h, 0EAh, 1Bh, 6, 'FLDENVf`', 0D9h
	db	49h, 1Ch, 6, 'FLDL2ER', 1, 0D9h, 0EAh, 21h, 1Ch, 6, 'FLDL2TR'
	db	1, 0D9h, 0E9h, 79h, 1Bh, 6, 'FLDLG2R', 1, 0D9h, 0ECh, 0E3h, 1Ah
	db	6, 'FLDLN2R', 5, 0D9h, 0EDh, 0Bh, 1Ch, 5, 'FLDPIR', 1, 0D9h, 0EBh
	db	92h, 1Ch, 4, 'FLDZR', 1, 0D9h, 0EEh, 0C6h, 1Bh, 4, 'FNOPR', 1
	db	0D9h, 0D0h, 1, 1Ch, 6, 'FPATANR', 1, 0D9h, 0F3h, 85h, 1Ch, 5, 'FPREMR'
	db	1, 0D9h, 0F8h, 0C1h, 1Ch, 5, 'FPTANR', 1, 0D9h, 0F2h, 95h, 1Bh
	db	7, 'FRNDINTR', 1, 0D9h, 0FCh, 9Fh, 1Ch, 6, 'FRSTORh`', 0DDh, 0F6h
	db	1Bh, 6, 'FSCALER', 1, 0D9h, 0FDh, 5Fh, 1Ch, 6, 'FSETPMR', 5, 0DBh
	db	0E4h, 54h, 1Ch, 5, 'FSQRTR', 1, 0D9h, 0FAh, 8Ah, 1Bh, 4, 'FTSTR'
	db	1, 0D9h, 0E4h, 62h, 1Bh, 5, 'FWAITR', 0, 9Bh, 0, 1Dh, 4, 'FXAMR'
	db	1, 0D9h, 0E5h, 0CEh, 1Ch, 4, 'FXCH', 0D2h, 1, 0D9h, 0C9h, 56h
	db	41h, 0D9h, 0C8h, 47h, 1Dh, 7, 'FXTRACTR', 1, 0D9h, 0F4h, 3Bh, 1Ch
	db	5, 'FYL2XR', 1, 0D9h, 0F1h, 0B6h, 1Ch, 7, 'FYL2XP1R', 1, 0D9h
	db	0F9h, 26h, 1Dh, 5, 'FCLEXR', 2, 1, 0DBh, 0E2h, 0F4h, 1Ch, 6, 'FNCLEXR'
	db	2, 0, 0DBh, 0E2h, 8Bh, 1Dh, 5, 'FDISIR', 2, 1, 0DBh, 0E1h, 8Ah
	db	19h, 6, 'FNDISIR', 2, 0, 0DBh, 0E1h, 0E6h, 1Ch, 4, 'FENIR', 2
	db	1, 0DBh, 0E0h, 1Ah, 1Dh, 5, 'FNENIR', 2, 0, 0DBh, 0E0h, 56h, 1Dh
	db	5, 'FINITR', 2, 1, 0DBh, 0E3h, 78h, 1Ch, 6, 'FNINITR', 2, 0, 0DBh
	db	0E3h, 64h, 1Dh, 5, 'FSAVEhq', 1, 0DDh, 7Eh, 1Dh, 6, 'FNSAVEhq'
	db	0, 0DDh, 0DAh, 1Dh, 5, 'FSTCW`y', 1, 0D9h, 70h, 1Dh, 6, 'FNSTCW`y'
	db	0, 0D9h, 0E8h, 1Dh, 6, 'FSTENVfq', 1, 0D9h, 0F4h, 1Dh, 7, 'FNSTENVfq'
	db	0, 0D9h, 1, 1Eh, 5, 'FSTSW', 0E0h, 79h, 1, 0DDh, 54h, 46h, 1, 0DFh
	db	0E0h, 0Dh, 1Eh, 6, 'FNSTSW', 0E0h, 79h, 0, 0DDh, 54h, 46h, 0, 0DFh
	db	0E0h
L097B8:	mov	di, 1E5Ch	;@097B8
	ret	;@097BB
	db	0Eh, 0, 8Dh, 1Fh, 7Dh, 1Fh, 85h, 1Fh, 55h, 1Fh, 0A5h, 1Fh, 0B5h	;@097BC
	db	1Fh, 95h, 1Fh, 75h, 1Fh, 0, 0, 6, 'OFFSETD', 0, 0, 3, 'SEGE', 0
	db	0, 4, 'TYPEF', 0, 0, 3, 'PTRP', 7Fh, 1Eh, 3, 'NOTC', 0, 0, 2, 'ORH'
	db	8Eh, 1Eh, 3, 'XORI', 0, 0, 3, 'ANDJ', 0, 0, 3, 'MODK', 0, 0, 3
	db	'SHRLx', 1Eh, 3, 'SHLM', 0B7h, 1Eh, 4, 'HIGHN', 95h, 1Eh, 3, 'LOWO'
	db	0A2h, 1Eh, 4, 'BYTEf', 1, 0, 0CDh, 1Eh, 4, 'WORDf', 2, 0, 87h
	db	1Eh, 5, 'DWORDf', 4, 0, 0D7h, 1Eh, 5, 'QWORDf', 8, 0, 0E1h, 1Eh
	db	5, 'TBYTEf', 0Ah, 0, 0B0h, 1Eh, 4, 'NEARf', 0FFh, 0FFh, 9Bh, 1Eh
	db	3, 'FARf', 0FEh, 0FFh, 0C6h, 1Eh, 2, 'AXe', 1, 0, 6Eh, 1Eh, 2
	db	'CXe', 1, 1, 2, 1Fh, 2, 'DXe', 1, 2, 0ECh, 1Eh, 2, 'BXe', 1, 3
	db	1Dh, 1Fh, 2, 'SPe', 1, 4, 2Dh, 1Fh, 2, 'BPe', 1, 5, 25h, 1Fh, 2
	db	'SIe', 1, 6, 0F7h, 1Eh, 2, 'DIe', 1, 7, 4Dh, 1Fh, 2, 'ALe', 0
	db	0, 0A9h, 1Eh, 2, 'CLe', 0, 1, 0Ch, 1Fh, 2, 'DLe', 0, 2, 0BEh, 1Eh
	db	2, 'BLe', 0, 3, 15h, 1Fh, 2, 'AHe', 0, 4, 35h, 1Fh, 2, 'CHe', 0
	db	5, 45h, 1Fh, 2, 'DHe', 0, 6, 3Dh, 1Fh, 2, 'BHe', 0, 7, 65h, 1Fh
	db	2, 'ESe', 2, 0, 6Dh, 1Fh, 2, 'CSe', 2, 1, 9Dh, 1Fh, 2, 'SSe', 2
	db	2, 5Dh, 1Fh, 2, 'DSe', 2, 3, 0ADh, 1Fh, 2, 'STe', 4, 0
RTL_LDOUBLE_UNPACK:	push	si	;@0991D
	push	di	;@0991E
	push	ss	;@0991F
	pop	es	;@09920
	sub	dx, dx	;@09921
	cld	;@09923
	mov	cx, 4	;@09924
	rep movsw	;@09927
	lodsw	;@09929
	shl	ax, 1	;@0992A
	rcl	dx, 1	;@0992C
	shr	ax, 1	;@0992E
	stosw	;@09930
	xchg	ax, dx	;@09931
	stosw	;@09932
	pop	di	;@09933
	pop	si	;@09934
	retf	;@09935
BCC_EXTENDED_HAS_PAYLOAD:	push	bp	;@09936
	mov	bp, sp	;@09937
	les	bx, dword ptr [bp+4]	;@09939
	cmp	word ptr es:[bx+8], 7FFFh	;@0993C
	jne	@@2	;@09942
	les	bx, dword ptr [bp+4]	;@09944
	cmp	word ptr es:[bx+6], 8000h	;@09947
	jne	@@1	;@0994D
	les	bx, dword ptr [bp+4]	;@0994F
	cmp	word ptr es:[bx], 0	;@09952
	jne	@@1	;@09956
	les	bx, dword ptr [bp+4]	;@09958
	cmp	word ptr es:[bx+2], 0	;@0995B
	jne	@@1	;@09960
	les	bx, dword ptr [bp+4]	;@09962
	cmp	word ptr es:[bx+4], 0	;@09965
	je	@@2	;@0996A
@@1:	mov	ax, 1	;@0996C
	jmp	short @@3	;@0996F
@@2:	xor	ax, ax	;@09971
@@3:	jmp	short @@4	;@09973
@@4:	pop	bp	;@09975
	ret	4	;@09976
RTL_LDOUBLE_ADDSUB:	push	bp	;@09979
	mov	bp, sp	;@0997A
	sub	sp, 1Ah	;@0997C
	push	si	;@0997F
	push	di	;@09980
	push	ds	;@09981
	lds	si, dword ptr [bp+0Ah]	;@09982
	lea	di, [bp-18h]	;@09985
	db	9Ah, 0Dh, 0, 0AFh, 0	; lcall 0xaf, 0xd	;@09988
	lds	si, dword ptr [bp+6]	;@0998D
	lea	di, [bp-0Ch]	;@09990
	db	9Ah, 0Dh, 0, 0AFh, 0	; lcall 0xaf, 0xd	;@09993
	pop	ds	;@09998
	lea	si, [bp-18h]	;@09999
	lea	di, [bp-0Ch]	;@0999C
	mov	al, byte ptr [bp+0Eh]	;@0999F
	xor	al, byte ptr [bp-2]	;@099A2
	mov	byte ptr [bp-2], al	;@099A5
	xor	al, byte ptr [bp-0Eh]	;@099A8
	mov	byte ptr [bp+0Eh], al	;@099AB
	mov	ax, word ptr [bp-10h]	;@099AE
	mov	bx, word ptr [bp-4]	;@099B1
	cmp	ax, 7FFFh	;@099B4
	jae	@@3	;@099B7
	cmp	bx, 7FFFh	;@099B9
	jae	@@2	;@099BD
	cmp	ax, bx	;@099BF
	jae	@@1	;@099C1
	mov	cl, byte ptr [bp-2]	;@099C3
	mov	byte ptr [bp-0Eh], cl	;@099C6
	mov	word ptr [bp-10h], bx	;@099C9
	xchg	ax, bx	;@099CC
	xchg	si, di	;@099CD
@@1:	or	bx, bx	;@099CF
	db	77h, 46h	; ja L09A19	;@099D1
	jmp	short @@4	;@099D3
@@2:	mov	si, di	;@099D5
	mov	ax, word ptr [bp-4]	;@099D7
	mov	word ptr [bp-10h], ax	;@099DA
	mov	ax, word ptr [bp-2]	;@099DD
	mov	word ptr [bp-0Eh], ax	;@099E0
@@3:	mov	ax, word ptr [bp-10h]	;@099E3
	cmp	ax, word ptr [bp-4]	;@099E6
	jne	@@4	;@099E9
	mov	ax, word ptr [bp-0Eh]	;@099EB
	cmp	ax, word ptr [bp-2]	;@099EE
	je	@@4	;@099F1
	mov	word ptr [bp-0Eh], 0	;@099F3
	mov	ax, 0	;@099F8
	mov	bx, 0	;@099FB
	mov	cx, 0	;@099FE
	mov	dx, 0C000h	;@09A01
	db	0E9h, 4, 1	; jmp L09B0B	;@09A04
@@4:	mov	ax, word ptr ss:[si]	;@09A07
	mov	bx, word ptr ss:[si+2]	;@09A0A
	db	36h, 8Bh	; mov cx, word ptr ss:[si+4]	;@09A0E
Y07A60	ends

Y09A10	segment para public 'CODE'
	assume	cs:Y09A10
	db	4Ch, 4, 36h, 8Bh, 54h, 6, 0E9h, 0F2h, 0	;@09A10
L09A19:	sub	ax, bx	;@09A19
	cmp	ax, 40h	;@09A1B
	db	7Fh, 0E7h	; jg L181A0+6247	;@09A1E
	mov	byte ptr [bp-1Ah], al	;@09A20
	mov	ax, word ptr ss:[di]	;@09A23
	mov	bx, word ptr ss:[di+2]	;@09A26
	mov	cx, word ptr ss:[di+4]	;@09A2A
	mov	dx, word ptr ss:[di+6]	;@09A2E
	mov	byte ptr [bp-19h], 0	;@09A32
	sub	byte ptr [bp-1Ah], 8	;@09A36
	jl	@@2	;@09A3A
@@1:	mov	byte ptr [bp-19h], al	;@09A3C
	mov	al, ah	;@09A3F
	mov	ah, bl	;@09A41
	mov	bl, bh	;@09A43
	mov	bh, cl	;@09A45
	mov	cl, ch	;@09A47
	mov	ch, dl	;@09A49
	mov	dl, dh	;@09A4B
	mov	dh, 0	;@09A4D
	sub	byte ptr [bp-1Ah], 8	;@09A4F
	jge	@@1	;@09A53
@@2:	and	byte ptr [bp-1Ah], 7	;@09A55
	je	@@4	;@09A59
@@3:	shr	dx, 1	;@09A5B
	rcr	cx, 1	;@09A5D
	rcr	bx, 1	;@09A5F
	rcr	ax, 1	;@09A61
	rcr	byte ptr [bp-19h], 1	;@09A63
	dec	byte ptr [bp-1Ah]	;@09A66
	jne	@@3	;@09A69
@@4:	sub	di, di	;@09A6B
	cmp	byte ptr [bp+0Eh], 0	;@09A6D
	jne	@@5	;@09A71
	add	ax, word ptr ss:[si]	;@09A73
	adc	bx, word ptr ss:[si+2]	;@09A76
	adc	cx, word ptr ss:[si+4]	;@09A7A
	adc	dx, word ptr ss:[si+6]	;@09A7E
	jae	@@9	;@09A82
	rcr	dx, 1	;@09A84
	rcr	cx, 1	;@09A86
	rcr	bx, 1	;@09A88
	rcr	ax, 1	;@09A8A
	rcr	byte ptr [bp-19h], 1	;@09A8C
	inc	word ptr [bp-10h]	;@09A8F
	jmp	short @@9	;@09A92
@@5:	xor	byte ptr [bp-0Eh], 1	;@09A94
	sub	ax, word ptr ss:[si]	;@09A98
	sbb	bx, word ptr ss:[si+2]	;@09A9B
	sbb	cx, word ptr ss:[si+4]	;@09A9F
	sbb	dx, word ptr ss:[si+6]	;@09AA3
	jae	@@6	;@09AA7
	xor	byte ptr [bp-0Eh], 1	;@09AA9
	not	dx	;@09AAD
	not	cx	;@09AAF
	not	bx	;@09AB1
	not	ax	;@09AB3
	neg	byte ptr [bp-19h]	;@09AB5
	cmc	;@09AB8
	adc	ax, di	;@09AB9
	adc	bx, di	;@09ABB
	adc	cx, di	;@09ABD
	adc	dx, di	;@09ABF
@@6:	mov	si, 40h	;@09AC1
	or	dh, dh	;@09AC4
	js	@@9	;@09AC6
@@7:	dec	si	;@09AC8
	je	@@8	;@09AC9
	shl	byte ptr [bp-19h], 1	;@09ACB
	rcl	ax, 1	;@09ACE
	rcl	bx, 1	;@09AD0
	rcl	cx, 1	;@09AD2
	adc	dx, dx	;@09AD4
	jns	@@7	;@09AD6
	sub	si, 40h	;@09AD8
	add	word ptr [bp-10h], si	;@09ADB
	jmp	@@9	;@09ADE
@@8:	mov	word ptr [bp-10h], 0	;@09AE1
	mov	byte ptr [bp-0Eh], 0	;@09AE6
	jmp	short L09B0B	;@09AEA
@@9:	shl	byte ptr [bp-19h], 1	;@09AEC
	adc	ax, di	;@09AEF
	adc	bx, di	;@09AF1
	adc	cx, di	;@09AF3
	adc	dx, di	;@09AF5
	jae	@@10	;@09AF7
	rcr	dx, 1	;@09AF9
	inc	word ptr [bp-10h]	;@09AFB
@@10:	cmp	word ptr [bp-10h], 7FFFh	;@09AFE
	jae	L09B23	;@09B03
	cmp	word ptr [bp-10h], 0	;@09B05
	je	L09B2A	;@09B09
L09B0B:	les	di, dword ptr [bp+0Ah]	;@09B0B
	cld	;@09B0E
	stosw	;@09B0F
	xchg	ax, bx	;@09B10
	stosw	;@09B11
	xchg	ax, cx	;@09B12
	stosw	;@09B13
	xchg	ax, dx	;@09B14
	stosw	;@09B15
	mov	ax, word ptr [bp-10h]	;@09B16
	shl	ax, 1	;@09B19
	or	al, byte ptr [bp-0Eh]	;@09B1B
	ror	ax, 1	;@09B1E
	stosw	;@09B20
	jmp	short L09B39	;@09B21
L09B23:	mov	word ptr [bp-10h], 7FFFh	;@09B23
	jmp	short L09B2F	;@09B28
L09B2A:	mov	word ptr [bp-10h], 0	;@09B2A
L09B2F:	sub	ax, ax	;@09B2F
	mov	bx, ax	;@09B31
	mov	cx, ax	;@09B33
	mov	dx, ax	;@09B35
	jmp	L09B0B	;@09B37
L09B39:	pop	di	;@09B39
	pop	si	;@09B3A
	mov	sp, bp	;@09B3B
	pop	bp	;@09B3D
	retf	0Ah	;@09B3E
RTL_LDOUBLE_ADD:	push	bp	;@09B41
	mov	bp, sp	;@09B42
	mov	al, 0	;@09B44
	push	ax	;@09B46
	push	word ptr [bp+0Ch]	;@09B47
	push	word ptr [bp+0Ah]	;@09B4A
	push	word ptr [bp+8]	;@09B4D
	push	word ptr [bp+6]	;@09B50
	push	cs	;@09B53
	db	0E8h, 22h, 0FEh	; call L181A0+6105	;@09B54
	pop	bp	;@09B57
	retf	8	;@09B58
RTL_LDOUBLE_SUB:	push	bp	;@09B5B
	mov	bp, sp	;@09B5C
	mov	al, 1	;@09B5E
	push	ax	;@09B60
	push	word ptr [bp+0Ch]	;@09B61
	push	word ptr [bp+0Ah]	;@09B64
	push	word ptr [bp+8]	;@09B67
	push	word ptr [bp+6]	;@09B6A
	push	cs	;@09B6D
	db	0E8h, 8, 0FEh	; call L181A0+6105	;@09B6E
	pop	bp	;@09B71
	retf	8	;@09B72
RTL_LDOUBLE_MUL:	push	bp	;@09B75
	mov	bp, sp	;@09B76
	sub	sp, 18h	;@09B78
	push	si	;@09B7B
	push	di	;@09B7C
	push	ds	;@09B7D
	lds	si, dword ptr [bp+0Ah]	;@09B7E
	lea	di, [bp-18h]	;@09B81
	db	9Ah, 0Dh, 0, 0AFh, 0	; lcall 0xaf, 0xd	;@09B84
	lds	si, dword ptr [bp+6]	;@09B89
	lea	di, [bp-0Ch]	;@09B8C
	db	9Ah, 0Dh, 0, 0AFh, 0	; lcall 0xaf, 0xd	;@09B8F
	pop	ds	;@09B94
	mov	cl, byte ptr [bp-2]	;@09B95
	xor	byte ptr [bp-0Eh], cl	;@09B98
	mov	bx, word ptr [bp-4]	;@09B9B
	mov	ax, word ptr [bp-10h]	;@09B9E
	cmp	ax, 7FFFh	;@09BA1
	jae	@@5	;@09BA4
	cmp	bx, 7FFFh	;@09BA6
	jae	@@9	;@09BAA
	cmp	ax, bx	;@09BAC
	jb	@@1	;@09BAE
	xchg	ax, bx	;@09BB0
@@1:	or	ax, ax	;@09BB1
	je	@@3	;@09BB3
	add	ax, bx	;@09BB5
	sub	ax, 3FFEh	;@09BB7
	jb	@@3	;@09BBA
	jmp	@@13	;@09BBC
@@2:	mov	di, 7FFFh	;@09BBF
	mov	dx, 8000h	;@09BC2
	jmp	short @@4	;@09BC5
@@3:	sub	di, di	;@09BC7
	mov	dx, 0	;@09BC9
@@4:	sub	ax, ax	;@09BCC
	mov	bx, ax	;@09BCE
	mov	cx, ax	;@09BD0
	jmp	@@22	;@09BD2
@@5:	cmp	word ptr [bp-4], 0	;@09BD5
	je	@@6	;@09BD9
	push	ss	;@09BDB
	lea	ax, [bp-18h]	;@09BDC
	push	ax	;@09BDF
	db	0E8h, 53h, 0FDh	; call L181A0+6038	;@09BE0
	or	ax, ax	;@09BE3
	je	@@7	;@09BE5
@@6:	jmp	short @@12	;@09BE7
@@7:	les	bx, dword ptr [bp+0Ah]	;@09BE9
	and	word ptr es:[bx+8], 7FFFh	;@09BEC
	test	word ptr [bp-0Eh], 0FFh	;@09BF2
	je	@@8	;@09BF7
	les	bx, dword ptr [bp+0Ah]	;@09BF9
	xor	word ptr es:[bx+8], 8000h	;@09BFC
@@8:	jmp	@@23	;@09C02
@@9:	cmp	word ptr [bp-10h], 0	;@09C05
	je	@@10	;@09C09
	push	ss	;@09C0B
	lea	ax, [bp-0Ch]	;@09C0C
	push	ax	;@09C0F
	db	0E8h, 23h, 0FDh	; call L181A0+6038	;@09C10
	or	ax, ax	;@09C13
	je	@@11	;@09C15
@@10:	jmp	short @@12	;@09C17
@@11:	mov	di, 7FFFh	;@09C19
	mov	ax, word ptr [bp-0Ch]	;@09C1C
	mov	bx, word ptr [bp-0Ah]	;@09C1F
	mov	cx, word ptr [bp-8]	;@09C22
	mov	dx, word ptr [bp-6]	;@09C25
	jmp	@@22	;@09C28
@@12:	mov	dx, 0C000h	;@09C2B
	mov	di, 7FFFh	;@09C2E
	jmp	@@4	;@09C31
@@13:	mov	word ptr [bp-10h], ax	;@09C33
	sub	di, di	;@09C36
	mov	cx, di	;@09C38
	mov	si, di	;@09C3A
	test	byte ptr [bp-9], 80h	;@09C3C
	je	@@14	;@09C40
	mov	cx, word ptr [bp-18h]	;@09C42
	mov	si, word ptr [bp-16h]	;@09C45
@@14:	test	byte ptr [bp-15h], 80h	;@09C48
	je	@@15	;@09C4C
	add	cx, word ptr [bp-0Ch]	;@09C4E
	adc	si, word ptr [bp-0Ah]	;@09C51
	adc	di, di	;@09C54
	test	byte ptr [bp-9], 80h	;@09C56
	je	@@15	;@09C5A
	dec	di	;@09C5C
@@15:	sub	bx, bx	;@09C5D
	mov	ax, word ptr [bp-0Ch]	;@09C5F
	mul	word ptr [bp-14h]	;@09C62
	add	cx, ax	;@09C65
	adc	si, dx	;@09C67
	adc	di, 0	;@09C69
	mov	ax, word ptr [bp-8]	;@09C6C
	or	ax, ax	;@09C6F
	je	@@16	;@09C71
	mul	word ptr [bp-18h]	;@09C73
	add	cx, ax	;@09C76
	adc	si, dx	;@09C78
	adc	di, 0	;@09C7A
	mov	ax, word ptr [bp-8]	;@09C7D
	mul	word ptr [bp-16h]	;@09C80
	add	si, ax	;@09C83
	adc	di, dx	;@09C85
	adc	bx, 0	;@09C87
@@16:	mov	ax, word ptr [bp-0Ch]	;@09C8A
	mul	word ptr [bp-12h]	;@09C8D
	add	si, ax	;@09C90
	adc	di, dx	;@09C92
	adc	bx, 0	;@09C94
	mov	ax, word ptr [bp-0Ah]	;@09C97
	mul	word ptr [bp-14h]	;@09C9A
	add	si, ax	;@09C9D
	adc	di, dx	;@09C9F
	adc	bx, 0	;@09CA1
	mov	ax, word ptr [bp-6]	;@09CA4
	or	ax, ax	;@09CA7
	je	@@17	;@09CA9
	mul	word ptr [bp-18h]	;@09CAB
	add	si, ax	;@09CAE
	adc	di, dx	;@09CB0
	adc	bx, 0	;@09CB2
@@17:	sub	cx, cx	;@09CB5
	push	si	;@09CB7
	mov	si, cx	;@09CB8
	mov	ax, word ptr [bp-0Ah]	;@09CBA
	mul	word ptr [bp-12h]	;@09CBD
	add	di, ax	;@09CC0
	adc	bx, dx	;@09CC2
	adc	cx, 0	;@09CC4
	mov	ax, word ptr [bp-8]	;@09CC7
	or	ax, ax	;@09CCA
	je	@@18	;@09CCC
	mul	word ptr [bp-14h]	;@09CCE
	add	di, ax	;@09CD1
	adc	bx, dx	;@09CD3
	adc	cx, 0	;@09CD5
	mov	ax, word ptr [bp-8]	;@09CD8
	mul	word ptr [bp-12h]	;@09CDB
	add	bx, ax	;@09CDE
	adc	cx, dx	;@09CE0
	adc	si, 0	;@09CE2
@@18:	mov	ax, word ptr [bp-6]	;@09CE5
	or	ax, ax	;@09CE8
	je	@@19	;@09CEA
	mul	word ptr [bp-16h]	;@09CEC
	add	di, ax	;@09CEF
	adc	bx, dx	;@09CF1
	adc	cx, 0	;@09CF3
	adc	si, 0	;@09CF6
	mov	ax, word ptr [bp-6]	;@09CF9
	mul	word ptr [bp-14h]	;@09CFC
	add	bx, ax	;@09CFF
	adc	cx, dx	;@09D01
	adc	si, 0	;@09D03
	mov	ax, word ptr [bp-6]	;@09D06
	mul	word ptr [bp-12h]	;@09D09
	add	cx, ax	;@09D0C
	adc	si, dx	;@09D0E
@@19:	mov	dx, si	;@09D10
	xchg	ax, di	;@09D12
	pop	si	;@09D13
	mov	di, word ptr [bp-10h]	;@09D14
	or	dx, dx	;@09D17
	js	@@20	;@09D19
	dec	di	;@09D1B
	shl	si, 1	;@09D1C
	rcl	ax, 1	;@09D1E
	rcl	bx, 1	;@09D20
	rcl	cx, 1	;@09D22
	rcl	dx, 1	;@09D24
@@20:	shl	si, 1	;@09D26
	adc	ax, 0	;@09D28
	adc	bx, 0	;@09D2B
	adc	cx, 0	;@09D2E
	adc	dx, 0	;@09D31
	jae	@@21	;@09D34
	rcr	dx, 1	;@09D36
	inc	di	;@09D38
@@21:	cmp	di, 7FFFh	;@09D39
	jb	@@22	;@09D3D
	jmp	@@2	;@09D3F
@@22:	mov	si, di	;@09D42
	les	di, dword ptr [bp+0Ah]	;@09D44
	cld	;@09D47
	stosw	;@09D48
	xchg	ax, bx	;@09D49
	stosw	;@09D4A
	xchg	ax, cx	;@09D4B
	stosw	;@09D4C
	xchg	ax, dx	;@09D4D
	stosw	;@09D4E
	xchg	ax, si	;@09D4F
	shl	ax, 1	;@09D50
	or	al, byte ptr [bp-0Eh]	;@09D52
	ror	ax, 1	;@09D55
	stosw	;@09D57
@@23:	pop	di	;@09D58
	pop	si	;@09D59
	mov	sp, bp	;@09D5A
	pop	bp	;@09D5C
	retf	8	;@09D5D
RTL_LDOUBLE_DIV:	push	bp	;@09D60
	mov	bp, sp	;@09D61
	sub	sp, 28h	;@09D63
	push	si	;@09D66
	push	di	;@09D67
	mov	word ptr [bp-4], 0	;@09D68
	push	ds	;@09D6D
	lds	si, dword ptr [bp+0Ah]	;@09D6E
	lea	di, [bp-28h]	;@09D71
	db	9Ah, 0Dh, 0, 0AFh, 0	; lcall 0xaf, 0xd	;@09D74
	lds	si, dword ptr [bp+6]	;@09D79
	lea	di, [bp-1Ch]	;@09D7C
	db	9Ah, 0Dh, 0, 0AFh, 0	; lcall 0xaf, 0xd	;@09D7F
	pop	ds	;@09D84
	mov	al, byte ptr [bp-1Eh]	;@09D85
	xor	al, byte ptr [bp-12h]	;@09D88
	mov	byte ptr [bp-6], al	;@09D8B
	mov	si, word ptr [bp-14h]	;@09D8E
	mov	ax, word ptr [bp-20h]	;@09D91
	cmp	si, 7FFFh	;@09D94
	jae	@@3	;@09D98
	cmp	ax, 7FFFh	;@09D9A
	jae	@@5	;@09D9D
	or	si, si	;@09D9F
	je	@@1	;@09DA1
	or	ax, ax	;@09DA3
	je	@@5	;@09DA5
	add	ax, 3FFEh	;@09DA7
	sub	ax, si	;@09DAA
	jb	@@3	;@09DAC
	jmp	@@7	;@09DAE
@@1:	mov	dx, 7FFFh	;@09DB1
	mov	si, 8000h	;@09DB4
	or	ax, ax	;@09DB7
	jne	@@4	;@09DB9
@@2:	mov	dx, 7FFFh	;@09DBB
	mov	si, 0C000h	;@09DBE
	jmp	short @@4	;@09DC1
@@3:	sub	dx, dx	;@09DC3
	sub	si, si	;@09DC5
	cmp	ax, 7FFFh	;@09DC7
	je	@@2	;@09DCA
@@4:	sub	ax, ax	;@09DCC
	mov	bx, ax	;@09DCE
	mov	cx, ax	;@09DD0
	jmp	@@20	;@09DD2
@@5:	les	bx, dword ptr [bp+0Ah]	;@09DD5
	and	word ptr es:[bx+8], 7FFFh	;@09DD8
	test	word ptr [bp-6], 0FFh	;@09DDE
	je	@@6	;@09DE3
	les	bx, dword ptr [bp+0Ah]	;@09DE5
	xor	word ptr es:[bx+8], 8000h	;@09DE8
@@6:	jmp	@@21	;@09DEE
@@7:	mov	word ptr [bp-8], ax	;@09DF1
	sub	cx, cx	;@09DF4
	mov	dx, word ptr [bp-22h]	;@09DF6
	mov	si, word ptr [bp-16h]	;@09DF9
	cmp	si, dx	;@09DFC
	ja	@@8	;@09DFE
	sub	dx, si	;@09E00
	inc	cx	;@09E02
@@8:	mov	ax, word ptr [bp-24h]	;@09E03
	div	si	;@09E06
	adc	ax, 1	;@09E08
	adc	cl, ch	;@09E0B
	mov	byte ptr [bp-1], cl	;@09E0D
	mov	word ptr [bp-0Ah], ax	;@09E10
	push	ax	;@09E13
	mov	ax, word ptr [bp-1Ch]	;@09E14
	mov	bx, word ptr [bp-1Ah]	;@09E17
	jcxz	@@10	;@09E1A
	mov	dx, word ptr [bp-18h]	;@09E1C
@@9:	sub	word ptr [bp-28h], ax	;@09E1F
	sbb	word ptr [bp-26h], bx	;@09E22
	sbb	word ptr [bp-24h], dx	;@09E25
	sbb	word ptr [bp-22h], si	;@09E28
	loop	@@9	;@09E2B
@@10:	pop	si	;@09E2D
	mul	si	;@09E2E
	mov	word ptr [bp-4], ax	;@09E30
	xchg	ax, dx	;@09E33
	xchg	ax, bx	;@09E34
	mul	si	;@09E35
	add	bx, ax	;@09E37
	adc	cx, dx	;@09E39
	mov	ax, word ptr [bp-18h]	;@09E3B
	mul	si	;@09E3E
	add	cx, ax	;@09E40
	adc	dx, 0	;@09E42
	xchg	ax, dx	;@09E45
	xchg	ax, si	;@09E46
	mul	word ptr [bp-16h]	;@09E47
	add	ax, si	;@09E4A
	adc	dx, 0	;@09E4C
	sub	bx, word ptr [bp-28h]	;@09E4F
	sbb	cx, word ptr [bp-26h]	;@09E52
	sbb	ax, word ptr [bp-24h]	;@09E55
	sbb	dx, word ptr [bp-22h]	;@09E58
	mov	word ptr [bp-28h], bx	;@09E5B
	mov	word ptr [bp-26h], cx	;@09E5E
	mov	word ptr [bp-24h], ax	;@09E61
	mov	si, word ptr [bp-16h]	;@09E64
	div	si	;@09E67
	xchg	ax, cx	;@09E69
	div	si	;@09E6A
	sub	dx, dx	;@09E6C
	stc	;@09E6E
	adc	ax, dx	;@09E6F
	adc	cx, dx	;@09E71
	sub	dx, ax	;@09E73
	mov	word ptr [bp-0Ch], dx	;@09E75
	sbb	word ptr [bp-0Ah], cx	;@09E78
	sbb	byte ptr [bp-1], 0	;@09E7B
	push	ax	;@09E7F
	mov	ax, word ptr [bp-1Ch]	;@09E80
	mov	bx, word ptr [bp-1Ah]	;@09E83
	jcxz	@@12	;@09E86
	mov	dx, word ptr [bp-18h]	;@09E88
@@11:	sub	word ptr [bp-4], ax	;@09E8B
	sbb	word ptr [bp-28h], bx	;@09E8E
	sbb	word ptr [bp-26h], dx	;@09E91
	sbb	word ptr [bp-24h], si	;@09E94
	loop	@@11	;@09E97
@@12:	pop	si	;@09E99
	mul	si	;@09E9A
	xchg	ax, dx	;@09E9C
	xchg	ax, bx	;@09E9D
	mul	si	;@09E9E
	add	bx, ax	;@09EA0
	adc	cx, dx	;@09EA2
	mov	ax, word ptr [bp-18h]	;@09EA4
	mul	si	;@09EA7
	add	cx, ax	;@09EA9
	adc	dx, 0	;@09EAB
	xchg	ax, dx	;@09EAE
	xchg	ax, si	;@09EAF
	mul	word ptr [bp-16h]	;@09EB0
	add	ax, si	;@09EB3
	adc	dx, 0	;@09EB5
	sub	bx, word ptr [bp-4]	;@09EB8
	sbb	cx, word ptr [bp-28h]	;@09EBB
	sbb	ax, word ptr [bp-26h]	;@09EBE
	sbb	dx, word ptr [bp-24h]	;@09EC1
	mov	word ptr [bp-4], bx	;@09EC4
	mov	word ptr [bp-28h], cx	;@09EC7
	mov	word ptr [bp-26h], ax	;@09ECA
	mov	si, word ptr [bp-16h]	;@09ECD
	div	si	;@09ED0
	xchg	ax, cx	;@09ED2
	div	si	;@09ED3
	sub	dx, dx	;@09ED5
	stc	;@09ED7
	adc	ax, dx	;@09ED8
	adc	cx, dx	;@09EDA
	mov	word ptr [bp-0Eh], ax	;@09EDC
	add	word ptr [bp-0Ch], cx	;@09EDF
	adc	word ptr [bp-0Ah], dx	;@09EE2
	adc	byte ptr [bp-1], dl	;@09EE5
	xchg	ax, si	;@09EE8
	mov	dx, word ptr [bp-1Ah]	;@09EE9
	xchg	ax, dx	;@09EEC
	mov	bx, word ptr [bp-18h]	;@09EED
	jcxz	@@14	;@09EF0
@@13:	sub	word ptr [bp-4], ax	;@09EF2
	sbb	word ptr [bp-28h], bx	;@09EF5
	sbb	word ptr [bp-26h], dx	;@09EF8
	loop	@@13	;@09EFB
@@14:	mul	si	;@09EFD
	xchg	ax, dx	;@09EFF
	xchg	ax, bx	;@09F00
	mul	si	;@09F01
	add	bx, ax	;@09F03
	adc	cx, dx	;@09F05
	mov	ax, word ptr [bp-16h]	;@09F07
	mul	si	;@09F0A
	add	ax, cx	;@09F0C
	adc	dx, 0	;@09F0E
	sub	bx, word ptr [bp-4]	;@09F11
	sbb	ax, word ptr [bp-28h]	;@09F14
	sbb	dx, word ptr [bp-26h]	;@09F17
	mov	word ptr [bp-4], bx	;@09F1A
	mov	word ptr [bp-28h], ax	;@09F1D
	mov	si, word ptr [bp-18h]	;@09F20
	add	si, si	;@09F23
	mov	si, word ptr [bp-16h]	;@09F25
	adc	si, 0	;@09F28
	jae	@@15	;@09F2B
	xchg	bx, dx	;@09F2D
	jmp	short @@16	;@09F2F
@@15:	shl	bx, 1	;@09F31
	rcl	ax, 1	;@09F33
	rcl	dx, 1	;@09F35
	div	si	;@09F37
	xchg	ax, bx	;@09F39
	div	si	;@09F3A
	shr	bx, 1	;@09F3C
	rcr	ax, 1	;@09F3E
	rcr	dh, 1	;@09F40
@@16:	mov	cx, 0FFFFh	;@09F42
	mov	si, cx	;@09F45
	mov	dl, cl	;@09F47
	not	bx	;@09F49
	not	ax	;@09F4B
	neg	dh	;@09F4D
	cmc	;@09F4F
	adc	ax, 0	;@09F50
	adc	bx, word ptr [bp-0Eh]	;@09F53
	adc	cx, word ptr [bp-0Ch]	;@09F56
	adc	si, word ptr [bp-0Ah]	;@09F59
	adc	dl, byte ptr [bp-1]	;@09F5C
	shr	dl, 1	;@09F5F
	jae	@@17	;@09F61
	rcr	si, 1	;@09F63
	rcr	cx, 1	;@09F65
	rcr	bx, 1	;@09F67
	rcr	ax, 1	;@09F69
	rcr	dh, 1	;@09F6B
	inc	word ptr [bp-8]	;@09F6D
@@17:	sub	di, di	;@09F70
	add	dh, dh	;@09F72
	adc	ax, di	;@09F74
	adc	bx, di	;@09F76
	adc	cx, di	;@09F78
	adc	si, di	;@09F7A
	adc	dl, 0	;@09F7C
	mov	dx, word ptr [bp-8]	;@09F7F
	je	@@18	;@09F82
	mov	si, 8000h	;@09F84
	inc	dx	;@09F87
@@18:	cmp	dx, 7FFFh	;@09F88
	jb	@@19	;@09F8C
	jmp	@@1	;@09F8E
@@19:	cmp	dx, 7FFFh	;@09F91
	jb	@@20	;@09F95
	jmp	@@1	;@09F97
@@20:	les	di, dword ptr [bp+0Ah]	;@09F9A
	cld	;@09F9D
	stosw	;@09F9E
	xchg	ax, bx	;@09F9F
	stosw	;@09FA0
	xchg	ax, cx	;@09FA1
	stosw	;@09FA2
	xchg	ax, si	;@09FA3
	stosw	;@09FA4
	xchg	ax, dx	;@09FA5
	shl	ax, 1	;@09FA6
	or	al, byte ptr [bp-6]	;@09FA8
	ror	ax, 1	;@09FAB
	stosw	;@09FAD
@@21:	pop	di	;@09FAE
	pop	si	;@09FAF
	mov	sp, bp	;@09FB0
	pop	bp	;@09FB2
	retf	8	;@09FB3
RTL_LDOUBLE_COMPARE:	push	bp	;@09FB6
	mov	bp, sp	;@09FB7
	push	si	;@09FB9
	push	di	;@09FBA
	push	ds	;@09FBB
	lds	si, dword ptr [bp+0Ah]	;@09FBC
	les	di, dword ptr [bp+6]	;@09FBF
	mov	ax, word ptr [si+8]	;@09FC2
	mov	dx, word ptr es:[di+8]	;@09FC5
	sub	bx, bx	;@09FC9
	shl	ax, 1	;@09FCB
	rcr	bl, 1	;@09FCD
	shl	dx, 1	;@09FCF
	rcr	bh, 1	;@09FD1
	mov	cx, ax	;@09FD3
	or	cx, dx	;@09FD5
	jcxz	@@1	;@09FD7
	cmp	bl, bh	;@09FD9
	jg	@@6	;@09FDB
	jl	@@4	;@09FDD
	cmp	ax, dx	;@09FDF
	jb	@@3	;@09FE1
	ja	@@5	;@09FE3
	mov	ax, word ptr [si+6]	;@09FE5
	cmp	ax, word ptr es:[di+6]	;@09FE8
	jne	@@2	;@09FEC
	mov	ax, word ptr [si+4]	;@09FEE
	cmp	ax, word ptr es:[di+4]	;@09FF1
	jne	@@2	;@09FF5
	mov	ax, word ptr [si+2]	;@09FF7
	cmp	ax, word ptr es:[di+2]	;@09FFA
	jne	@@2	;@09FFE
	mov	ax, word ptr [si]	;@0A000
	cmp	ax, word ptr es:[di]	;@0A002
	jne	@@2	;@0A005
@@1:	sub	ax, ax	;@0A007
	jmp	short @@7	;@0A009
@@2:	ja	@@5	;@0A00B
@@3:	or	bl, bl	;@0A00D
	jne	@@6	;@0A00F
@@4:	mov	ax, 0FFFFh	;@0A011
	jmp	short @@7	;@0A014
@@5:	or	bl, bl	;@0A016
	jne	@@4	;@0A018
@@6:	mov	ax, 1	;@0A01A
@@7:	or	ax, ax	;@0A01D
	pop	ds	;@0A01F
	jmp	short @@8	;@0A020
@@8:	pop	di	;@0A022
	pop	si	;@0A023
	pop	bp	;@0A024
	retf	8	;@0A025
RTL_LDOUBLE_ROUND_TO_FLOAT:	push	bp	;@0A028
	mov	bp, sp	;@0A029
	push	si	;@0A02B
	push	ds	;@0A02C
	lds	si, dword ptr [bp+6]	;@0A02D
	mov	ax, word ptr [si+4]	;@0A030
	mov	dx, word ptr [si+6]	;@0A033
	cmp	word ptr [si], 0	;@0A036
	jne	@@1	;@0A039
	cmp	word ptr [si+2], 0	;@0A03B
	jne	@@1	;@0A03F
	test	al, 7Fh	;@0A041
	jne	@@1	;@0A043
	test	ah, 1	;@0A045
	je	@@2	;@0A048
@@1:	add	al, al	;@0A04A
	adc	ah, 0	;@0A04C
	adc	dx, 0	;@0A04F
	jae	@@2	;@0A052
	rcr	dx, 1	;@0A054
	rcr	ax, 1	;@0A056
	inc	word ptr [si+8]	;@0A058
	mov	bx, 7FFFh	;@0A05B
	and	bx, word ptr [si+8]	;@0A05E
	inc	bx	;@0A061
	jo	@@3	;@0A062
@@2:	mov	al, 0	;@0A064
	sub	bx, bx	;@0A066
	mov	word ptr [si], bx	;@0A068
	mov	word ptr [si+2], bx	;@0A06A
	mov	word ptr [si+4], ax	;@0A06D
	mov	word ptr [si+6], dx	;@0A070
	pop	ds	;@0A073
	jmp	short @@4	;@0A074
@@3:	sub	ax, ax	;@0A076
	mov	dx, 8000h	;@0A078
	jmp	@@2	;@0A07B
@@4:	pop	si	;@0A07D
	pop	bp	;@0A07E
	retf	4	;@0A07F
	db	55h, 8Bh, 0ECh, 83h, 0ECh, 0Ah, 56h, 57h, 1Eh, 0C5h, 76h, 0Ah	;@0A082
	db	8Dh, 7Eh, 0F6h, 16h, 7, 0B9h, 5, 0, 0FCh, 0F3h, 0A5h, 1Fh, 16h
	db	8Dh, 46h, 0F6h, 50h, 0Eh, 0E8h, 85h, 0FFh, 8Bh, 5Eh, 0FEh, 0B1h
	db	0, 0D1h, 0E3h, 0D0h, 0D1h, 0D1h, 0EBh, 81h, 0FBh
Y09A10	ends

Y0A0B0	segment para public 'CODE'
	assume	cs:Y0A0B0
	db	0FFh, 7Fh, 74h, 23h, 81h, 0C3h, 80h, 0C0h, 7Eh, 2Fh, 81h, 0FBh	;@0A0B0
	db	0FFh, 0, 7Dh, 22h, 8Ah, 7Eh, 0FDh, 8Bh, 46h, 0FBh, 86h, 0FBh, 0D0h
	db	0E3h, 0D0h, 0E9h, 0D1h, 0DBh, 0C4h, 7Eh, 6, 0FCh, 0ABh, 93h, 0ABh
	db	0EBh, 18h, 8Ah, 5Eh, 0FDh, 0D0h, 0E3h, 0B7h, 0FFh, 2Bh, 0C0h, 0EBh
	db	0E8h, 0BBh, 0, 0FFh, 2Bh, 0C0h, 0EBh, 0E1h, 2Bh, 0DBh, 2Bh, 0C0h
	db	0EBh, 0DBh, 5Fh, 5Eh, 8Bh, 0E5h, 5Dh, 0CAh, 8, 0
RTL_LDOUBLE_ROUND_TO_DOUBLE:	push	bp	;@0A0F7
	mov	bp, sp	;@0A0F8
	push	si	;@0A0FA
	push	di	;@0A0FB
	push	ds	;@0A0FC
	lds	si, dword ptr [bp+6]	;@0A0FD
	mov	ax, word ptr [si+1]	;@0A100
	mov	dh, 3	;@0A103
	and	dh, al	;@0A105
	or	dh, byte ptr [si]	;@0A107
	jne	@@1	;@0A109
	test	al, 8	;@0A10B
	db	74h, 1Eh	; je L0A12D	;@0A10D
@@1:	add	ax, 4	;@0A10F
	db	73h, 19h	; jae L0A12D	;@0A112
	sub	bx, bx	;@0A114
	adc	word ptr [si+3], bx	;@0A116
	adc	word ptr [si+5], bx	;@0A119
	adc	byte ptr [si+7], bl	;@0A11C
	db	73h	; jae L0A12D	;@0A11F
Y0A0B0	ends
	end
