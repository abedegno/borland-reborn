	.286
	locals
CODE0	segment byte public 'CODE'
CODE0	ends
DATA	segment byte public 'DATA'
DATA	ends
BSS	segment byte public 'BSS'
BSS	ends
DGROUP	group	DATA,BSS
	public	L03208
	public	L03212
	public	L0321E
	public	L121FD
	public	L12222
	public	L12275
	public	L12282
	public	L1228F
	public	L122AC
	public	L122D6
	public	L12310
	public	L1232B
	public	L1233F
	public	L12358
	public	L12371
	public	L1238A
	public	L12474
	public	L12488
	public	L124A7
	public	L124C0
	public	L124D3
	public	L124E8
	public	L124F8
	public	L12502
	public	L12609
	public	L12613
	public	L1261D
	public	L12633
	public	L1263F
	public	L12652
	public	L12694
	public	L126A5
	public	L126CF
	public	L126F2
	public	L126FD
	public	L12708
	public	L1272B
	public	L12744
	public	L12753
	public	L12778
	public	L12787
	public	L12790
	public	L127BF
	public	L1281F
	public	L128AB
	public	L12907
	public	L12931
	public	L1294D
	public	L12959
	public	L12964
	public	L1296F
	public	L12979
	public	L12A16
	public	L12AB6
	public	L12BD6
	public	L12C89
	public	L12C9B
	public	L12CC4
	public	L12CCA
	public	L12D51
	public	L12D6A
	public	L12E56
	extrn	L04A95:near
	extrn	L0FAA6:near
	extrn	L0FB18:near
	extrn	L0FCE0:near
	extrn	L11699:near
	extrn	L11E9F:far
	extrn	L120E3:near
	extrn	L12124:near
	extrn	L13ADA:near
	extrn	L13B2C:near
	extrn	L13B4E:near
	extrn	L13B66:near
	extrn	L13B89:near
	extrn	L13B98:near
	extrn	L13BB2:near
	extrn	L13BC0:near
	extrn	L13BDF:near
	extrn	L13C07:near
	extrn	L13C2F:near
	extrn	L13C5F:near
	extrn	L13C77:near
	extrn	L13C99:near
	extrn	L13C9F:near
	extrn	L13D2A:near
	extrn	L13D39:near
	extrn	L13D9C:near
	extrn	L13DC1:near
	extrn	L13DD4:near
	extrn	L13E14:near
	extrn	L13E35:near
	extrn	L13E53:near
	extrn	L13F76:near
	extrn	L13FAF:near
	extrn	L14004:near
	extrn	L14062:near
	extrn	L14094:near
	extrn	L140BC:near
	extrn	L140CF:near
	extrn	L140D6:near
	extrn	L14188:near
	extrn	L1418E:near
	extrn	L141D2:near
	extrn	L141D8:near
	extrn	L1429B:near
	extrn	L142B5:near
	extrn	L142E4:near
	extrn	L142EA:near
	extrn	L14315:near
	extrn	L14330:near
	extrn	L14358:near
	extrn	L1437B:near
	extrn	L14385:near
	extrn	L143B0:near
	extrn	L143B8:near
	extrn	L143BF:near
	extrn	L143D4:near
	extrn	L14475:near

CODE0	segment byte public 'CODE'
	assume	cs:CODE0
L03208:	call	far ptr L11E9F	;@03208
	ret	;@0320D
L0320E:	call	L04A95	;@0320E
	retf	;@03211
L03212:	mov	es, ax	;@03212
	mov	ax, word ptr es:[10h]	;@03214
	mov	dx, word ptr es:[12h]	;@03218
	ret	;@0321D
L0321E:	mov	es, ax	;@0321E
	mov	bx, word ptr es:[14h]	;@03220
	ret	;@03225
CODE0	ends

C0F9B	segment byte public 'CODE'
	assume	cs:C0F9B
L121FD:	mov	cx, ax	;@121FD
	mov	si, di	;@121FF
	call	L12275	;@12201
	mov	ax, es	;@12204
	mov	si, ds	;@12206
	cmp	ax, si	;@12208
	mov	al, 3Ah	;@1220A
	je	@@1	;@1220C
	mov	byte ptr [bx], 28h	;@1220E
	inc	bx	;@12211
	mov	ax, cx	;@12212
	inc	ax	;@12214
	call	L12242	;@12215
	mov	al, 29h	;@12218
@@1:	mov	byte ptr [bx], al	;@1221A
	inc	bx	;@1221C
	mov	byte ptr [bx], 20h	;@1221D
	inc	bx	;@12220
	ret	;@12221
L12222:	xchg	al, ah	;@12222
	call	@@1	;@12224
	mov	al, ah	;@12227
@@1:	mov	ch, al	;@12229
	mov	cl, 4	;@1222B
	shr	al, cl	;@1222D
	call	@@2	;@1222F
	mov	al, ch	;@12232
	and	al, 0Fh	;@12234
@@2:	add	al, 30h	;@12236
	cmp	al, 39h	;@12238
	jbe	@@3	;@1223A
	add	al, 7	;@1223C
@@3:	mov	byte ptr [bx], al	;@1223E
	inc	bx	;@12240
	ret	;@12241
L12242:	mov	ch, 30h	;@12242
	mov	si, 2710h	;@12244
	call	@@1	;@12247
	mov	si, 3E8h	;@1224A
	call	@@1	;@1224D
	mov	si, 64h	;@12250
	call	@@1	;@12253
	mov	si, 0Ah	;@12256
	call	@@1	;@12259
	mov	si, 1	;@1225C
	mov	ch, 0FFh	;@1225F
@@1:	mov	cl, 2Fh	;@12261
@@2:	inc	cl	;@12263
	sub	ax, si	;@12265
	jae	@@2	;@12267
	add	ax, si	;@12269
	cmp	cl, ch	;@1226B
	je	@@3	;@1226D
	mov	ch, 0FFh	;@1226F
	mov	byte ptr [bx], cl	;@12271
	inc	bx	;@12273
@@3:	ret	;@12274
L12275:	mov	al, byte ptr es:[si]	;@12275
	and	al, al	;@12278
	je	L1228E	;@1227A
	mov	byte ptr [bx], al	;@1227C
	inc	bx	;@1227E
	inc	si	;@1227F
	jmp	L12275	;@12280
L12282:	mov	al, byte ptr [si]	;@12282
	and	al, al	;@12284
	je	L1228E	;@12286
	mov	byte ptr [bx], al	;@12288
	inc	bx	;@1228A
	inc	si	;@1228B
	jmp	L12282	;@1228C
L1228E:	ret	;@1228E
L1228F:	jcxz	@@4	;@1228F
@@1:	mov	al, byte ptr es:[di]	;@12291
	cmp	al, 21h	;@12294
	jae	@@3	;@12296
	inc	di	;@12298
	loop	@@1	;@12299
	ret	;@1229B
@@2:	mov	al, byte ptr es:[di]	;@1229C
	cmp	al, 20h	;@1229F
	jae	@@3	;@122A1
	mov	al, 20h	;@122A3
@@3:	mov	byte ptr [bx], al	;@122A5
	inc	bx	;@122A7
	inc	di	;@122A8
	loop	@@2	;@122A9
@@4:	ret	;@122AB
L122AC:	inc	word ptr ds:[38C0h]	;@122AC
	mov	ax, word ptr ds:[38D0h]	;@122B0
	cmp	ax, word ptr ds:[38C0h]	;@122B3
	jae	@@1	;@122B7
	mov	word ptr ds:[38C0h], ax	;@122B9
@@1:	test	word ptr es:[4], 8000h	;@122BC
	jne	@@2	;@122C3
	inc	word ptr ds:[38BEh]	;@122C5
	mov	ax, word ptr ds:[38D2h]	;@122C9
	cmp	ax, word ptr ds:[38BEh]	;@122CC
	jae	@@2	;@122D0
	mov	word ptr ds:[38BEh], ax	;@122D2
@@2:	ret	;@122D5
L122D6:	test	word ptr ds:[38C4h], 2000h	;@122D6
	je	@@1	;@122DC
	call	L120E3	;@122DE
	mov	bx, 4EE8h	;@122E1
	mov	cx, 0FFFFh	;@122E4
	sub	di, bx	;@122E7
	push	es	;@122E9
	call	word ptr ds:[4EE2h]	;@122EA
	pop	es	;@122EE
@@1:	call	L12124	;@122EF
	push	di	;@122F2
	push	word ptr es:[4]	;@122F3
	mov	ax, word ptr es:[8]	;@122F8
	mov	dx, word ptr es:[6]	;@122FC
	push	cs	;@12301
	call	L11699	;@12302
	pop	cx	;@12305
	pop	di	;@12306
	mov	bx, 4EE8h	;@12307
	sub	di, bx	;@1230A
	jmp	word ptr ds:[4EE2h]	;@1230C
L12310:	xor	ax, ax	;@12310
	mov	word ptr ds:[4FF4h], ax	;@12312
	mov	word ptr ds:[4FE8h], ax	;@12315
	mov	word ptr ds:[4FEAh], ax	;@12318
	mov	word ptr ds:[4FF6h], ax	;@1231B
	mov	word ptr ds:[4FF8h], ax	;@1231E
	mov	word ptr ds:[4FFCh], ax	;@12321
	mov	word ptr ds:[4FF0h], 1Fh	;@12324
	retf	;@1232A
L1232B:	db	0E8h, 6Bh, 0Bh	; call L12E99	;@1232B
	mov	byte ptr es:[4], 18h	;@1232E
	mov	byte ptr es:[0Ch], bl	;@12334
	mov	word ptr es:[8], bp	;@12339
	retf	;@1233E
L1233F:	db	0E8h, 57h, 0Bh	; call L12E99	;@1233F
	mov	byte ptr es:[4], 17h	;@12342
	mov	word ptr es:[0Ch], si	;@12348
	mov	word ptr es:[0Eh], di	;@1234D
	mov	word ptr es:[8], bp	;@12352
	retf	;@12357
L12358:	db	0E8h, 3Eh, 0Bh	; call L12E99	;@12358
	mov	byte ptr es:[4], 19h	;@1235B
	mov	word ptr es:[0Ch], si	;@12361
	mov	word ptr es:[0Eh], di	;@12366
	mov	word ptr es:[8], bp	;@1236B
	retf	;@12370
L12371:	db	0E8h, 25h, 0Bh	; call L12E99	;@12371
	mov	byte ptr es:[4], 1Ah	;@12374
	mov	word ptr es:[0Ch], si	;@1237A
	mov	word ptr es:[0Eh], di	;@1237F
	mov	word ptr es:[8], bp	;@12384
	retf	;@12389
L1238A:	cmp	word ptr ds:[4FF8h], 0	;@1238A
	je	@@5	;@1238F
@@1:	cmp	cx, word ptr ds:[4FFCh]	;@12391
	jne	@@8	;@12395
	cmp	bp, word ptr ds:[4FFEh]	;@12397
	jne	@@8	;@1239B
	cmp	ax, word ptr ds:[4FFAh]	;@1239D
	jne	@@8	;@123A1
	sub	di, word ptr ds:[5004h]	;@123A3
	je	@@4	;@123A7
	cmp	di, 0Fh	;@123A9
	ja	@@7	;@123AC
	sub	bx, word ptr ds:[5000h]	;@123AE
	sbb	dx, word ptr ds:[5002h]	;@123B2
	jne	@@6	;@123B6
	cmp	bx, 0Fh	;@123B8
	ja	@@6	;@123BB
	add	word ptr ds:[5004h], di	;@123BD
	add	word ptr ds:[5000h], bx	;@123C1
	adc	word ptr ds:[5002h], dx	;@123C5
	mov	ax, di	;@123C9
	mov	cl, 4	;@123CB
	shl	al, cl	;@123CD
	or	al, bl	;@123CF
@@2:	mov	es, word ptr ds:[4FF8h]	;@123D1
	mov	di, word ptr es:[6]	;@123D5
	cmp	di, 3FFh	;@123DA
	ja	@@10	;@123DE
	stosb	;@123E0
@@3:	mov	word ptr es:[6], di	;@123E1
@@4:	retf	;@123E6
@@5:	push	ax	;@123E7
	call	@@12	;@123E8
	pop	ax	;@123EB
	jmp	@@1	;@123EC
@@6:	add	bx, word ptr ds:[5000h]	;@123EE
	adc	dx, word ptr ds:[5002h]	;@123F2
@@7:	add	di, word ptr ds:[5004h]	;@123F6
@@8:	mov	word ptr ds:[4FFAh], ax	;@123FA
	mov	word ptr ds:[4FFCh], cx	;@123FD
	mov	word ptr ds:[4FFEh], bp	;@12401
	mov	word ptr ds:[5000h], bx	;@12405
	mov	word ptr ds:[5002h], dx	;@12409
	mov	word ptr ds:[5004h], di	;@1240D
@@9:	push	di	;@12411
	push	ax	;@12412
	mov	es, word ptr ds:[4FF8h]	;@12413
	mov	di, word ptr es:[6]	;@12417
	cmp	di, 3F3h	;@1241C
	ja	@@11	;@12420
	xor	al, al	;@12422
	stosb	;@12424
	pop	ax	;@12425
	stosw	;@12426
	mov	ax, cx	;@12427
	stosw	;@12429
	mov	ax, bp	;@1242A
	stosw	;@1242C
	mov	ax, bx	;@1242D
	stosw	;@1242F
	mov	ax, dx	;@12430
	stosw	;@12432
	pop	ax	;@12433
	stosw	;@12434
	jmp	@@3	;@12435
@@10:	push	ax	;@12437
	call	L125C6	;@12438
	call	@@12	;@1243B
	pop	ax	;@1243E
	jmp	@@2	;@1243F
@@11:	push	cx	;@12441
	push	dx	;@12442
	call	L125C6	;@12443
	pop	dx	;@12446
	pop	cx	;@12447
	call	@@12	;@12448
	pop	ax	;@1244B
	pop	di	;@1244C
	jmp	@@9	;@1244D
@@12:	push	cx	;@1244F
	push	dx	;@12450
	mov	dx, 40h	;@12451
	db	0E8h, 0F5h, 0Ah	; call L12F4C	;@12454
	pop	dx	;@12457
	pop	cx	;@12458
	mov	word ptr ds:[4FF8h], ax	;@12459
	push	es	;@1245C
	mov	es, ax	;@1245D
	mov	byte ptr es:[4], 4	;@1245F
	mov	byte ptr es:[5], 40h	;@12465
	mov	word ptr es:[6], 8	;@1246B
	pop	es	;@12472
	ret	;@12473
L12474:	push	ax	;@12474
	push	cx	;@12475
	mov	cx, 4	;@12476
	call	L12580	;@12479
	pop	cx	;@1247C
	pop	bx	;@1247D
	mov	al, 0	;@1247E
	stosb	;@12480
	mov	ax, bx	;@12481
	stosw	;@12483
	mov	al, cl	;@12484
	stosb	;@12486
	retf	;@12487
L12488:	push	di	;@12488
	push	cx	;@12489
	push	ax	;@1248A
	mov	cx, 0Fh	;@1248B
	call	L12580	;@1248E
	mov	al, 6	;@12491
	stosb	;@12493
	pop	ax	;@12494
	stosw	;@12495
	pop	ax	;@12496
	stosw	;@12497
	mov	ax, bp	;@12498
	stosw	;@1249A
	mov	ax, dx	;@1249B
	stosw	;@1249D
	mov	ax, bx	;@1249E
	stosw	;@124A0
	mov	ax, si	;@124A1
	stosw	;@124A3
	pop	ax	;@124A4
	stosw	;@124A5
	retf	;@124A6
L124A7:	push	di	;@124A7
	push	cx	;@124A8
	push	ax	;@124A9
	mov	cx, 0Ah	;@124AA
	call	L12580	;@124AD
	mov	al, 7	;@124B0
	stosb	;@124B2
	pop	ax	;@124B3
	stosw	;@124B4
	pop	ax	;@124B5
	stosb	;@124B6
	mov	ax, bp	;@124B7
	stosw	;@124B9
	mov	ax, si	;@124BA
	stosw	;@124BC
	pop	ax	;@124BD
	stosw	;@124BE
	retf	;@124BF
L124C0:	push	cx	;@124C0
	push	ax	;@124C1
	mov	cx, 6	;@124C2
	call	L12580	;@124C5
	mov	al, 8	;@124C8
	stosb	;@124CA
	pop	ax	;@124CB
	stosw	;@124CC
	pop	ax	;@124CD
	stosb	;@124CE
	mov	ax, bp	;@124CF
	stosw	;@124D1
	retf	;@124D2
L124D3:	push	ax	;@124D3
	mov	cx, 7	;@124D4
	call	L12580	;@124D7
	pop	cx	;@124DA
	mov	al, 4	;@124DB
	stosb	;@124DD
	mov	ax, cx	;@124DE
	stosw	;@124E0
	mov	ax, bx	;@124E1
	stosw	;@124E3
	mov	ax, dx	;@124E4
	stosw	;@124E6
	retf	;@124E7
L124E8:	mov	cx, 5	;@124E8
	call	L12580	;@124EB
	mov	al, 5	;@124EE
	stosb	;@124F0
	mov	ax, bx	;@124F1
	stosw	;@124F3
	mov	ax, dx	;@124F4
	stosw	;@124F6
	retf	;@124F7
L124F8:	mov	cx, 1	;@124F8
	call	L12580	;@124FB
	mov	al, 1	;@124FE
	stosb	;@12500
	retf	;@12501
L12502:	cmp	cx, word ptr ds:[4FFCh]	;@12502
	jne	@@2	;@12506
	cmp	bp, word ptr ds:[4FFEh]	;@12508
	jne	@@2	;@1250C
	mov	ax, di	;@1250E
	sub	ax, word ptr ds:[5004h]	;@12510
	cmp	ax, 100h	;@12514
	jae	@@2	;@12517
	sub	bx, word ptr ds:[5000h]	;@12519
	sbb	dx, word ptr ds:[5002h]	;@1251D
	jne	@@1	;@12521
	cmp	bx, 100h	;@12523
	jae	@@1	;@12527
	add	word ptr ds:[5004h], ax	;@12529
	add	word ptr ds:[5000h], bx	;@1252D
	adc	word ptr ds:[5002h], dx	;@12531
	mov	ah, bl	;@12535
	mov	bx, ax	;@12537
	mov	cx, 3	;@12539
	call	L12580	;@1253C
	mov	al, 3	;@1253F
	stosb	;@12541
	mov	al, bl	;@12542
	stosb	;@12544
	mov	al, bh	;@12545
	stosb	;@12547
	retf	;@12548
@@1:	add	bx, word ptr ds:[5000h]	;@12549
	adc	dx, word ptr ds:[5002h]	;@1254D
@@2:	mov	word ptr ds:[5004h], di	;@12551
	mov	word ptr ds:[5000h], bx	;@12555
	mov	word ptr ds:[5002h], dx	;@12559
	mov	word ptr ds:[4FFCh], cx	;@1255D
	mov	word ptr ds:[4FFEh], bp	;@12561
	mov	cx, 0Bh	;@12565
	call	L12580	;@12568
	mov	al, 2	;@1256B
	stosb	;@1256D
	mov	ax, bp	;@1256E
	stosw	;@12570
	mov	ax, word ptr ds:[4FFCh]	;@12571
	stosw	;@12574
	mov	ax, word ptr ds:[5004h]	;@12575
	stosw	;@12578
	mov	ax, bx	;@12579
	stosw	;@1257B
	mov	ax, dx	;@1257C
	stosw	;@1257E
	retf	;@1257F
L12580:	mov	ax, word ptr ds:[4FF6h]	;@12580
	and	ax, ax	;@12583
	je	@@2	;@12585
	mov	es, ax	;@12587
	mov	ax, word ptr es:[6]	;@12589
	mov	di, ax	;@1258D
	add	ax, cx	;@1258F
	cmp	ax, 400h	;@12591
	ja	@@1	;@12594
	mov	word ptr es:[6], ax	;@12596
	ret	;@1259A
@@1:	push	cx	;@1259B
	push	dx	;@1259C
	call	L125D4	;@1259D
	pop	dx	;@125A0
	pop	cx	;@125A1
@@2:	push	cx	;@125A2
	push	dx	;@125A3
	mov	dx, 40h	;@125A4
	db	0E8h, 0A2h, 9	; call L12F4C	;@125A7
	pop	dx	;@125AA
	pop	cx	;@125AB
	mov	word ptr ds:[4FF6h], ax	;@125AC
	mov	es, ax	;@125AF
	mov	byte ptr es:[4], 5	;@125B1
	mov	byte ptr es:[5], 40h	;@125B7
	mov	word ptr es:[6], 8	;@125BD
	jmp	L12580	;@125C4
L125C6:	mov	cx, word ptr ds:[4FF8h]	;@125C6
	jcxz	L12608	;@125CA
	mov	word ptr ds:[4FF8h], 0	;@125CC
	jmp	short L125E0	;@125D2
L125D4:	mov	cx, word ptr ds:[4FF6h]	;@125D4
	jcxz	L12608	;@125D8
	mov	word ptr ds:[4FF6h], 0	;@125DA
L125E0:	mov	es, cx	;@125E0
	mov	cx, word ptr ds:[4FEAh]	;@125E2
	mov	dx, es	;@125E6
	mov	word ptr ds:[4FEAh], dx	;@125E8
	mov	word ptr es:[0], cx	;@125EC
	mov	word ptr es:[2], 0	;@125F1
	jcxz	@@1	;@125F8
	push	ds	;@125FA
	mov	ds, cx	;@125FB
	mov	word ptr ds:[2], dx	;@125FD
	pop	ds	;@12601
	jmp	short L12608	;@12602
@@1:	mov	word ptr ds:[4FE8h], dx	;@12604
L12608:	ret	;@12608
L12609:	db	0E8h, 8Dh, 8	; call L12E99	;@12609
	mov	byte ptr es:[4], 10h	;@1260C
	retf	;@12612
L12613:	db	0E8h, 83h, 8	; call L12E99	;@12613
	mov	byte ptr es:[4], 11h	;@12616
	retf	;@1261C
L1261D:	db	0E8h, 79h, 8	; call L12E99	;@1261D
	mov	byte ptr es:[4], 8	;@12620
	mov	word ptr es:[0Ah], bx	;@12626
	mov	word ptr es:[0Ch], dx	;@1262B
	mov	ax, es	;@12630
	retf	;@12632
L12633:	db	0E8h, 63h, 8	; call L12E99	;@12633
	mov	byte ptr es:[4], 9	;@12636
	mov	ax, es	;@1263C
	retf	;@1263E
L1263F:	db	0E8h, 57h, 8	; call L12E99	;@1263F
	mov	byte ptr es:[4], 0Ah	;@12642
	mov	word ptr es:[0Ah], 0	;@12648
	mov	ax, es	;@1264F
	retf	;@12651
L12652:	db	0E8h, 44h, 8	; call L12E99	;@12652
	mov	byte ptr es:[4], 0	;@12655
	mov	byte ptr es:[19h], dl	;@1265B
	mov	word ptr es:[14h], bx	;@12660
	mov	word ptr es:[16h], si	;@12665
	mov	byte ptr es:[18h], ch	;@1266A
	xor	ax, ax	;@1266F
	mov	word ptr es:[0Ah], ax	;@12671
	mov	word ptr es:[0Ch], ax	;@12675
	mov	word ptr es:[0Eh], ax	;@12679
	mov	word ptr es:[10h], ax	;@1267D
	mov	word ptr es:[12h], ax	;@12681
	mov	word ptr es:[1Eh], ax	;@12685
	mov	word ptr es:[1Ch], ax	;@12689
	mov	word ptr es:[1Ah], ax	;@1268D
	mov	ax, es	;@12691
	retf	;@12693
L12694:	db	0E8h, 2, 8	; call L12E99	;@12694
	mov	byte ptr es:[4], 0Ch	;@12697
	mov	word ptr es:[0Ah], bp	;@1269D
	mov	ax, es	;@126A2
	retf	;@126A4
L126A5:	db	0E8h, 0F1h, 7	; call L12E99	;@126A5
	mov	byte ptr es:[4], 0Dh	;@126A8
	mov	word ptr es:[0Ah], bp	;@126AE
	mov	word ptr es:[0Ch], bx	;@126B3
	mov	word ptr es:[0Eh], dx	;@126B8
	mov	word ptr es:[10h], si	;@126BD
	mov	word ptr es:[12h], di	;@126C2
	mov	byte ptr es:[14h], ch	;@126C7
	mov	ax, es	;@126CC
	retf	;@126CE
L126CF:	db	0E8h, 0C7h, 7	; call L12E99	;@126CF
	mov	byte ptr es:[4], 0Bh	;@126D2
L126D8:	mov	word ptr es:[10h], dx	;@126D8
	mov	word ptr es:[0Ah], bx	;@126DD
	mov	word ptr es:[0Ch], si	;@126E2
	mov	word ptr es:[0Eh], di	;@126E7
	mov	word ptr es:[12h], bp	;@126EC
	retf	;@126F1
L126F2:	db	0E8h, 0A4h, 7	; call L12E99	;@126F2
	mov	byte ptr es:[4], 13h	;@126F5
	jmp	L126D8	;@126FB
L126FD:	db	0E8h, 99h, 7	; call L12E99	;@126FD
	mov	byte ptr es:[4], 12h	;@12700
	jmp	L126D8	;@12706
L12708:	db	0E8h, 8Eh, 7	; call L12E99	;@12708
	mov	byte ptr es:[4], 14h	;@1270B
	mov	word ptr es:[0Ah], bx	;@12711
	mov	word ptr es:[10h], dx	;@12716
	mov	word ptr es:[0Ch], si	;@1271B
	mov	word ptr es:[0Eh], di	;@12720
	mov	word ptr es:[8], bp	;@12725
	retf	;@1272A
L1272B:	db	0E8h, 6Bh, 7	; call L12E99	;@1272B
	mov	byte ptr es:[4], 15h	;@1272E
	mov	word ptr es:[0Ch], si	;@12734
	mov	word ptr es:[0Eh], di	;@12739
	mov	word ptr es:[8], bp	;@1273E
	retf	;@12743
L12744:	db	0E8h, 52h, 7	; call L12E99	;@12744
	mov	byte ptr es:[4], 16h	;@12747
	mov	word ptr es:[8], bp	;@1274D
	retf	;@12752
L12753:	mov	cx, ax	;@12753
	db	0E8h, 41h, 7	; call L12E99	;@12755
	mov	byte ptr es:[4], 0Eh	;@12758
	mov	word ptr es:[6], bx	;@1275E
	mov	word ptr es:[8], dx	;@12763
	mov	word ptr es:[0Ah], si	;@12768
	mov	word ptr es:[0Ch], di	;@1276D
	mov	byte ptr es:[5], cl	;@12772
	retf	;@12777
L12778:	call	L125D4	;@12778
	call	L125C6	;@1277B
	mov	al, 0	;@1277E
	mov	bx, 3612h	;@12780
	db	0E8h, 0A1h, 8	; call L13027	;@12783
	retf	;@12786
L12787:	mov	al, 0	;@12787
	mov	bx, 35D5h	;@12789
	db	0E8h, 98h, 8	; call L13027	;@1278C
	retf	;@1278F
L12790:	mov	es, ax	;@12790
	test	byte ptr ds:[38D7h], 2	;@12792
	jne	@@2	;@12797
	cmp	dx, di	;@12799
	jne	@@1	;@1279B
	cmp	bx, si	;@1279D
	je	@@2	;@1279F
@@1:	push	di	;@127A1
	db	0E8h, 1Dh, 8	; call L12FC2	;@127A2
	pop	di	;@127A5
@@2:	mov	ax, word ptr es:[10h]	;@127A6
	sub	ax, si	;@127AA
	mov	ax, word ptr es:[12h]	;@127AC
	sbb	ax, di	;@127B0
	jae	@@3	;@127B2
	mov	word ptr es:[10h], si	;@127B4
	mov	word ptr es:[12h], di	;@127B9
@@3:	retf	;@127BE
L127BF:	mov	es, ax	;@127BF
	test	byte ptr ds:[38D7h], 2	;@127C1
	jne	@@1	;@127C6
	db	0E8h, 0F7h, 7	; call L12FC2	;@127C8
	db	0E8h, 8Ch, 6	; call L12E5A	;@127CB
	mov	byte ptr es:[4], 0Fh	;@127CE
	mov	word ptr es:[6], bx	;@127D4
	mov	word ptr es:[8], dx	;@127D9
	retf	;@127DE
@@1:	push	es	;@127DF
	db	0E8h, 0A2h, 7	; call L12F85	;@127E0
	mov	ax, word ptr es:[1Ch]	;@127E3
	or	ax, ax	;@127E7
	jne	@@2	;@127E9
	mov	ax, word ptr es:[0Ch]	;@127EB
	jmp	short @@4	;@127EF
@@2:	mov	es, ax	;@127F1
@@3:	mov	ax, word ptr es:[2]	;@127F3
@@4:	or	ax, ax	;@127F7
	je	@@5	;@127F9
	mov	es, ax	;@127FB
	cmp	byte ptr es:[4], 0Fh	;@127FD
	jne	@@3	;@12803
	cmp	dx, word ptr es:[8]	;@12805
	jne	@@3	;@1280A
	cmp	bx, word ptr es:[6]	;@1280C
	jne	@@3	;@12811
	mov	ax, es	;@12813
	pop	es	;@12815
	mov	word ptr es:[1Ch], ax	;@12816
	mov	word ptr es:[1Ah], ax	;@1281A
@@5:	retf	;@1281E
L1281F:	mov	es, ax	;@1281F
	test	byte ptr ds:[38D7h], 2	;@12821
	jne	@@1	;@12826
	push	di	;@12828
	db	0E8h, 96h, 7	; call L12FC2	;@12829
	pop	di	;@1282C
	db	0E8h, 2Ah, 6	; call L12E5A	;@1282D
	mov	byte ptr es:[4], 2	;@12830
	mov	word ptr es:[14h], si	;@12836
	mov	word ptr es:[16h], di	;@1283B
	mov	word ptr es:[6], bx	;@12840
	mov	word ptr es:[8], dx	;@12845
	xor	ax, ax	;@1284A
	mov	word ptr es:[0Ch], ax	;@1284C
	mov	word ptr es:[0Eh], ax	;@12850
	mov	word ptr es:[10h], ax	;@12854
	mov	word ptr es:[12h], ax	;@12858
	mov	word ptr es:[1Ch], ax	;@1285C
	mov	word ptr es:[1Eh], ax	;@12860
	mov	word ptr es:[1Ah], ax	;@12864
	mov	ax, es	;@12868
	retf	;@1286A
@@1:	push	es	;@1286B
	db	0E8h, 16h, 7	; call L12F85	;@1286C
	mov	ax, word ptr es:[1Ch]	;@1286F
	or	ax, ax	;@12873
	jne	@@4	;@12875
	mov	ax, word ptr es:[0Ch]	;@12877
	jmp	short @@3	;@1287B
@@2:	mov	ax, word ptr es:[2]	;@1287D
@@3:	or	ax, ax	;@12881
	je	@@5	;@12883
@@4:	mov	es, ax	;@12885
	cmp	byte ptr es:[4], 2	;@12887
	jne	@@2	;@1288D
	cmp	dx, word ptr es:[8]	;@1288F
	jne	@@2	;@12894
	cmp	bx, word ptr es:[6]	;@12896
	jne	@@2	;@1289B
	mov	ax, es	;@1289D
	pop	es	;@1289F
	mov	word ptr es:[1Ch], ax	;@128A0
	mov	word ptr es:[1Ah], ax	;@128A4
	retf	;@128A8
@@5:	pop	es	;@128A9
	retf	;@128AA
L128AB:	or	ax, ax	;@128AB
	je	@@1	;@128AD
	mov	es, ax	;@128AF
	db	0E8h, 0A6h, 5	; call L12E5A	;@128B1
	jmp	short @@2	;@128B4
@@1:	mov	dx, 2	;@128B6
	db	0E8h, 90h, 6	; call L12F4C	;@128B9
	mov	es, ax	;@128BC
@@2:	mov	byte ptr es:[4], 1	;@128BE
	mov	word ptr es:[6], bx	;@128C4
	mov	word ptr es:[8], dx	;@128C9
	xor	ax, ax	;@128CE
	mov	word ptr es:[0Ch], ax	;@128D0
	mov	word ptr es:[0Eh], ax	;@128D4
	mov	word ptr es:[10h], ax	;@128D8
	mov	word ptr es:[12h], ax	;@128DC
	mov	word ptr es:[1Ch], ax	;@128E0
	mov	word ptr es:[1Eh], ax	;@128E4
	mov	word ptr es:[16h], ax	;@128E8
	mov	word ptr es:[18h], ax	;@128EC
	mov	word ptr es:[0Ah], ax	;@128F0
	mov	word ptr es:[1Ah], ax	;@128F4
	mov	ax, word ptr ds:[4FF0h]	;@128F8
	add	word ptr ds:[4FF0h], 2	;@128FB
	mov	word ptr es:[14h], ax	;@12900
	mov	ax, es	;@12904
	retf	;@12906
L12907:	db	0E8h, 8Fh, 5	; call L12E99	;@12907
	mov	byte ptr es:[4], 1Fh	;@1290A
	mov	word ptr es:[6], ax	;@12910
	mov	word ptr es:[8], dx	;@12914
	and	dx, dx	;@12919
	je	L1293A	;@1291B
	mov	word ptr es:[16h], bx	;@1291D
	mov	bx, word ptr ds:[4FF0h]	;@12922
	mov	word ptr es:[14h], bx	;@12926
	add	word ptr ds:[4FF0h], 2	;@1292B
	retf	;@12930
L12931:	db	0E8h, 65h, 5	; call L12E99	;@12931
	mov	byte ptr es:[4], 1Bh	;@12934
L1293A:	mov	word ptr es:[16h], bx	;@1293A
	mov	bx, word ptr ds:[4FF0h]	;@1293F
	mov	word ptr es:[14h], bx	;@12943
	inc	word ptr ds:[4FF0h]	;@12948
	retf	;@1294C
L1294D:	db	0E8h, 49h, 5	; call L12E99	;@1294D
	mov	byte ptr es:[4], 1Ch	;@12950
	jmp	L1293A	;@12956
	db	0CBh	;@12958
L12959:	db	0E8h, 3Dh, 5	; call L12E99	;@12959
	mov	byte ptr es:[4], 1Dh	;@1295C
	jmp	L1293A	;@12962
L12964:	db	0E8h, 32h, 5	; call L12E99	;@12964
	mov	byte ptr es:[4], 1Eh	;@12967
	jmp	L1293A	;@1296D
L1296F:	mov	bx, word ptr ds:[4FF0h]	;@1296F
	add	word ptr ds:[4FF0h], 2	;@12973
	retf	;@12978
L12979:	test	byte ptr ds:[38D7h], 2	;@12979
	jne	@@1	;@1297E
	mov	es, ax	;@12980
	push	es	;@12982
	db	0E8h, 3Ch, 6	; call L12FC2	;@12983
	push	dx	;@12986
	mov	dx, 1	;@12987
	push	cx	;@1298A
	db	0E8h, 0BEh, 5	; call L12F4C	;@1298B
	pop	cx	;@1298E
	mov	es, ax	;@1298F
	mov	byte ptr es:[4], 7	;@12991
	mov	byte ptr es:[5], dl	;@12997
	mov	di, 8	;@1299C
	mov	ax, bx	;@1299F
	stosw	;@129A1
	pop	ax	;@129A2
	stosw	;@129A3
	mov	ax, cx	;@129A4
	stosw	;@129A6
	mov	word ptr es:[6], di	;@129A7
	mov	ax, es	;@129AC
	pop	es	;@129AE
	mov	word ptr es:[1Ch], ax	;@129AF
	db	0E8h, 0Ch, 6	; call L12FC2	;@129B3
@@1:	retf	;@129B6
L129B7:	mov	ax, word ptr es:[1Ch]	;@129B7
	and	ax, ax	;@129BB
	jne	@@1	;@129BD
	mov	ax, word ptr es:[0Ch]	;@129BF
	jmp	short @@6	;@129C3
@@1:	push	es	;@129C5
	mov	es, ax	;@129C6
	cmp	byte ptr es:[4], 3	;@129C8
	jne	@@5	;@129CE
	sub	bx, word ptr es:[8]	;@129D0
	sbb	dx, word ptr es:[0Ah]	;@129D5
	jb	@@2	;@129DA
	jne	@@4	;@129DC
	cmp	bx, word ptr es:[0Ch]	;@129DE
	jae	@@4	;@129E3
	mov	di, bx	;@129E5
	add	di, 0Eh	;@129E7
	add	bx, cx	;@129EA
	cmp	word ptr es:[0Ch], bx	;@129EC
	jb	@@2	;@129F1
	shr	cx, 1	;@129F3
	rep movsw	;@129F5
	rcl	cx, 1	;@129F7
	rep movsb	;@129F9
@@2:	pop	es	;@129FB
@@3:	retf	;@129FC
@@4:	add	bx, word ptr es:[8]	;@129FD
	adc	dx, word ptr es:[0Ah]	;@12A02
@@5:	mov	ax, word ptr es:[2]	;@12A07
	pop	es	;@12A0B
@@6:	and	ax, ax	;@12A0C
	je	@@3	;@12A0E
	mov	word ptr es:[1Ch], ax	;@12A10
	jmp	@@1	;@12A14
L12A16:	mov	es, ax	;@12A16
	test	byte ptr ds:[38D7h], 2	;@12A18
	jne	L129B7	;@12A1D
	cmp	byte ptr es:[4], 0	;@12A1F
	jne	@@1	;@12A25
	mov	ax, word ptr es:[1Ch]	;@12A27
	or	ax, ax	;@12A2B
	je	@@3	;@12A2D
	push	es	;@12A2F
	mov	es, ax	;@12A30
	sub	bx, word ptr es:[8]	;@12A32
	mov	di, bx	;@12A37
	add	bx, cx	;@12A39
	cmp	bx, 1F2h	;@12A3B
	ja	@@2	;@12A3F
	add	di, 0Eh	;@12A41
	shr	cx, 1	;@12A44
	rep movsw	;@12A46
	rcl	cx, 1	;@12A48
	rep movsb	;@12A4A
	mov	word ptr es:[0Ch], bx	;@12A4C
	mov	word ptr es:[6], di	;@12A51
	pop	es	;@12A56
	retf	;@12A57
@@1:	mov	di, dx	;@12A58
	mov	dx, cx	;@12A5A
	add	dx, 1Dh	;@12A5C
	shr	dx, 1	;@12A5F
	shr	dx, 1	;@12A61
	shr	dx, 1	;@12A63
	shr	dx, 1	;@12A65
	call	@@4	;@12A67
	db	0E8h, 55h, 5	; call L12FC2	;@12A6A
	retf	;@12A6D
@@2:	add	bx, word ptr es:[8]	;@12A6E
	sub	bx, cx	;@12A73
	pop	es	;@12A75
	db	0E8h, 49h, 5	; call L12FC2	;@12A76
@@3:	mov	di, dx	;@12A79
	mov	dx, 20h	;@12A7B
	call	@@4	;@12A7E
	retf	;@12A81
@@4:	push	es	;@12A82
	push	cx	;@12A83
	db	0E8h, 0C5h, 4	; call L12F4C	;@12A84
	pop	cx	;@12A87
	mov	es, ax	;@12A88
	mov	byte ptr es:[4], 3	;@12A8A
	mov	byte ptr es:[5], dl	;@12A90
	push	di	;@12A95
	mov	di, 8	;@12A96
	mov	ax, bx	;@12A99
	stosw	;@12A9B
	pop	ax	;@12A9C
	stosw	;@12A9D
	mov	ax, cx	;@12A9E
	stosw	;@12AA0
	shr	cx, 1	;@12AA1
	rep movsw	;@12AA3
	rcl	cx, 1	;@12AA5
	rep movsb	;@12AA7
	mov	word ptr es:[6], di	;@12AA9
	mov	ax, es	;@12AAE
	pop	es	;@12AB0
	mov	word ptr es:[1Ch], ax	;@12AB1
	ret	;@12AB5
L12AB6:	mov	es, ax	;@12AB6
	cmp	byte ptr es:[4], 0	;@12AB8
	jne	@@1	;@12ABE
	mov	ax, word ptr es:[1Ch]	;@12AC0
	or	ax, ax	;@12AC4
	je	@@1	;@12AC6
	mov	es, ax	;@12AC8
	sub	bx, word ptr es:[8]	;@12ACA
	mov	di, bx	;@12ACF
	add	di, 0Eh	;@12AD1
	mov	word ptr es:[0Ch], bx	;@12AD4
	mov	word ptr es:[6], di	;@12AD9
@@1:	retf	;@12ADE
L12ADF:	mov	word ptr es:[8], di	;@12ADF
	pop	di	;@12AE4
L12AE5:	pop	es	;@12AE5
	cmp	byte ptr es:[4], 0	;@12AE6
	jne	@@1	;@12AEC
	mov	ax, word ptr es:[1Eh]	;@12AEE
	and	ax, ax	;@12AF2
	je	@@3	;@12AF4
	push	es	;@12AF6
	mov	es, ax	;@12AF7
	push	di	;@12AF9
	mov	ax, word ptr es:[6]	;@12AFA
	mov	di, ax	;@12AFE
	add	ax, 9	;@12B00
	cmp	ax, 0D0h	;@12B03
	ja	@@2	;@12B06
	jmp	L12C1B	;@12B08
@@1:	mov	ax, dx	;@12B0B
	mov	dx, 2	;@12B0D
	call	L12C51	;@12B10
	db	0E8h, 6Fh, 4	; call L12F85	;@12B13
	retf	;@12B16
@@2:	pop	di	;@12B17
	pop	es	;@12B18
	db	0E8h, 69h, 4	; call L12F85	;@12B19
@@3:	jmp	L12C48	;@12B1C
L12B1F:	push	di	;@12B1F
	mov	di, word ptr es:[6]	;@12B20
	sub	di, 9	;@12B25
	mov	ax, word ptr es:[di+1]	;@12B28
	sub	ax, bx	;@12B2C
	mov	ax, word ptr es:[di+3]	;@12B2E
	sbb	ax, dx	;@12B32
	jb	@@3	;@12B34
	mov	di, word ptr es:[8]	;@12B36
@@1:	cmp	bx, word ptr es:[di+1]	;@12B3B
	mov	ax, dx	;@12B3F
	sbb	ax, word ptr es:[di+3]	;@12B41
	jb	L12ADF	;@12B45
	jne	@@2	;@12B47
	cmp	bx, word ptr es:[di+1]	;@12B49
	je	@@4	;@12B4D
@@2:	add	di, 9	;@12B4F
	jmp	@@1	;@12B52
@@3:	pop	di	;@12B54
	jmp	short L12B8D	;@12B55
@@4:	mov	word ptr es:[8], di	;@12B57
	mov	al, cl	;@12B5C
	stosb	;@12B5E
	mov	ax, bx	;@12B5F
	stosw	;@12B61
	mov	ax, dx	;@12B62
	stosw	;@12B64
	mov	ax, si	;@12B65
	stosw	;@12B67
	pop	ax	;@12B68
	stosw	;@12B69
L12B6A:	pop	es	;@12B6A
L12B6B:	retf	;@12B6B
L12B6C:	mov	ax, word ptr es:[1Ah]	;@12B6C
	and	ax, ax	;@12B70
	jne	L12B7A	;@12B72
	mov	ax, word ptr es:[0Ch]	;@12B74
	jmp	short L12B92	;@12B78
L12B7A:	push	es	;@12B7A
	mov	es, ax	;@12B7B
	cmp	byte ptr es:[4], 6	;@12B7D
	je	L12B1F	;@12B83
	cmp	byte ptr es:[4], 3	;@12B85
	je	L12B9C	;@12B8B
L12B8D:	mov	ax, word ptr es:[2]	;@12B8D
	pop	es	;@12B91
L12B92:	and	ax, ax	;@12B92
	je	L12B6B	;@12B94
	mov	word ptr es:[1Ah], ax	;@12B96
	jmp	L12B7A	;@12B9A
L12B9C:	sub	bx, word ptr es:[8]	;@12B9C
	sbb	dx, word ptr es:[0Ah]	;@12BA1
	jb	L12B6A	;@12BA6
	jne	@@1	;@12BA8
	cmp	bx, word ptr es:[0Ch]	;@12BAA
	jae	@@1	;@12BAF
	add	bx, word ptr es:[8]	;@12BB1
	adc	dx, word ptr es:[0Ah]	;@12BB6
	jmp	L12AE5	;@12BBB
@@1:	add	bx, word ptr es:[8]	;@12BBE
	adc	dx, word ptr es:[0Ah]	;@12BC3
	mov	ax, es	;@12BC8
	pop	es	;@12BCA
	push	ax	;@12BCB
	db	0E8h, 0B6h, 3	; call L12F85	;@12BCC
	pop	ax	;@12BCF
	push	es	;@12BD0
	mov	es, ax	;@12BD1
	jmp	L12B8D	;@12BD3
	db	90h	;@12BD5
L12BD6:	mov	es, ax	;@12BD6
	test	byte ptr ds:[38D7h], 2	;@12BD8
	jne	L12B6C	;@12BDD
	cmp	byte ptr es:[4], 0	;@12BDF
	jne	L12C2F	;@12BE5
	mov	ax, word ptr es:[1Ch]	;@12BE7
	or	ax, ax	;@12BEB
	je	@@1	;@12BED
	push	es	;@12BEF
	mov	es, ax	;@12BF0
	cmp	word ptr es:[6], 1F0h	;@12BF2
	pop	es	;@12BF9
	jbe	@@1	;@12BFA
	push	di	;@12BFC
	db	0E8h, 0C2h, 3	; call L12FC2	;@12BFD
	pop	di	;@12C00
@@1:	mov	ax, word ptr es:[1Eh]	;@12C01
	or	ax, ax	;@12C05
	je	L12C48	;@12C07
	push	es	;@12C09
	mov	es, ax	;@12C0A
	mov	ax, word ptr es:[6]	;@12C0C
	push	di	;@12C10
	mov	di, ax	;@12C11
	add	ax, 9	;@12C13
	cmp	ax, 0D0h	;@12C16
	ja	L12C3E	;@12C19
L12C1B:	mov	word ptr es:[6], ax	;@12C1B
	mov	al, cl	;@12C1F
	stosb	;@12C21
	mov	ax, bx	;@12C22
	stosw	;@12C24
	mov	ax, dx	;@12C25
	stosw	;@12C27
	mov	ax, si	;@12C28
	stosw	;@12C2A
	pop	ax	;@12C2B
	stosw	;@12C2C
	pop	es	;@12C2D
	retf	;@12C2E
L12C2F:	mov	ax, dx	;@12C2F
	mov	dx, 2	;@12C31
	call	L12C51	;@12C34
	mov	di, 1Eh	;@12C37
	db	0E8h, 8Eh, 3	; call L12FCB	;@12C3A
	retf	;@12C3D
L12C3E:	pop	ax	;@12C3E
	pop	es	;@12C3F
	push	ax	;@12C40
	mov	di, 1Eh	;@12C41
	db	0E8h, 84h, 3	; call L12FCB	;@12C44
	pop	di	;@12C47
L12C48:	mov	ax, dx	;@12C48
	mov	dx, 0Dh	;@12C4A
	call	L12C51	;@12C4D
	retf	;@12C50
L12C51:	push	es	;@12C51
	push	ax	;@12C52
	push	cx	;@12C53
	db	0E8h, 0F5h, 2	; call L12F4C	;@12C54
	pop	cx	;@12C57
	mov	es, ax	;@12C58
	mov	byte ptr es:[4], 6	;@12C5A
	mov	byte ptr es:[5], dl	;@12C60
	mov	dx, di	;@12C65
	mov	di, 8	;@12C67
	mov	ax, 0Ah	;@12C6A
	stosw	;@12C6D
	mov	al, cl	;@12C6E
	stosb	;@12C70
	mov	ax, bx	;@12C71
	stosw	;@12C73
	pop	ax	;@12C74
	stosw	;@12C75
	mov	ax, si	;@12C76
	stosw	;@12C78
	mov	ax, dx	;@12C79
	stosw	;@12C7B
	mov	word ptr es:[6], di	;@12C7C
	mov	ax, es	;@12C81
	pop	es	;@12C83
	mov	word ptr es:[1Eh], ax	;@12C84
	ret	;@12C88
L12C89:	mov	es, ax	;@12C89
	mov	ax, word ptr es:[0Ah]	;@12C8B
	mov	word ptr es:[0Ah], cx	;@12C8F
	mov	es, cx	;@12C94
	mov	word ptr es:[0Ah], ax	;@12C96
	retf	;@12C9A
L12C9B:	mov	cx, word ptr ds:[4FE8h]	;@12C9B
@@1:	jcxz	@@2	;@12C9F
	mov	es, cx	;@12CA1
	push	word ptr es:[2]	;@12CA3
	db	0E8h, 67h, 2	; call L12F12	;@12CA8
	pop	cx	;@12CAB
	jmp	@@1	;@12CAC
@@2:	mov	ax, word ptr ds:[4FF2h]	;@12CAE
	mov	dx, word ptr ds:[4FF4h]	;@12CB1
	and	dx, dx	;@12CB5
	db	74h, 0Ah	; je @@3	;@12CB7
	mov	word ptr ds:[4FF4h], 0	;@12CB9
	push	cs	;@12CBF
	db	0E8h, 0E3h, 0CDh	; call L0FAA6	;@12CC0
@@3:	db	0CBh	; retf	;@12CC3
L12CC4:	mov	es, ax	;@12CC4
	db	0E8h, 18h, 2	; call L12EE1	;@12CC6
	retf	;@12CC9
L12CCA:	xor	ax, ax	;@12CCA
	mov	word ptr ds:[4FF6h], ax	;@12CCC
	mov	word ptr ds:[4FF8h], ax	;@12CCF
	mov	word ptr ds:[4FFCh], ax	;@12CD2
	mov	cx, word ptr ds:[4FE8h]	;@12CD5
@@1:	jcxz	@@6	;@12CD9
	mov	es, cx	;@12CDB
	mov	al, byte ptr es:[4]	;@12CDD
	cmp	al, 0	;@12CE1
	je	@@8	;@12CE3
	cmp	al, 0Ah	;@12CE5
	je	@@7	;@12CE7
	cmp	al, 0Ch	;@12CE9
	je	@@7	;@12CEB
	cmp	al, 0Dh	;@12CED
	je	@@7	;@12CEF
	cmp	al, 8	;@12CF1
	je	@@7	;@12CF3
	cmp	al, 1Bh	;@12CF5
	je	@@7	;@12CF7
	cmp	al, 1Ch	;@12CF9
	je	@@7	;@12CFB
	cmp	al, 1Dh	;@12CFD
	je	@@7	;@12CFF
	cmp	al, 1Eh	;@12D01
	je	@@7	;@12D03
	cmp	al, 1Fh	;@12D05
	je	@@7	;@12D07
	push	word ptr es:[2]	;@12D09
	mov	dx, word ptr es:[0]	;@12D0E
	mov	cx, word ptr es:[2]	;@12D13
	jcxz	@@2	;@12D18
	push	ds	;@12D1A
	mov	ds, cx	;@12D1B
	mov	word ptr ds:[0], dx	;@12D1D
	pop	ds	;@12D21
	jmp	short @@3	;@12D22
@@2:	mov	word ptr ds:[4FEAh], dx	;@12D24
@@3:	and	dx, dx	;@12D28
	je	@@4	;@12D2A
	push	ds	;@12D2C
	mov	ds, dx	;@12D2D
	mov	word ptr ds:[2], cx	;@12D2F
	pop	ds	;@12D33
	jmp	short @@5	;@12D34
@@4:	mov	word ptr ds:[4FE8h], cx	;@12D36
@@5:	db	0E8h, 0D5h, 1	; call L12F12	;@12D3A
	pop	cx	;@12D3D
	jmp	@@1	;@12D3E
@@6:	retf	;@12D40
@@7:	mov	cx, word ptr es:[2]	;@12D41
	jmp	@@1	;@12D46
@@8:	db	0E8h, 96h, 1	; call L12EE1	;@12D48
	mov	word ptr es:[1Ah], ax	;@12D4B
	jmp	@@7	;@12D4F
L12D51:	mov	dx, word ptr ds:[4FF4h]	;@12D51
	and	dx, dx	;@12D55
	db	74h, 0Fh	; je @@1	;@12D57
	mov	word ptr ds:[4FF4h], 0	;@12D59
	mov	ax, word ptr ds:[4FF2h]	;@12D5F
	push	cs	;@12D62
	db	0E8h, 40h, 0CDh	; call L0FAA6	;@12D63
	db	0F8h	; clc	;@12D66
	retf	;@12D67
@@1:	stc	;@12D68
	retf	;@12D69
L12D6A:	xor	ax, ax	;@12D6A
	mov	word ptr ds:[4FECh], ax	;@12D6C
	mov	word ptr ds:[4FEEh], ax	;@12D6F
	mov	word ptr ds:[5007h], si	;@12D72
	call	L13ADA	;@12D76
	test	word ptr ds:[38C4h], 10h	;@12D79
	je	@@1	;@12D7F
	db	0E8h, 96h, 7	; call L1351A	;@12D81
@@1:	mov	byte ptr ds:[5009h], 0	;@12D84
	mov	al, 9	;@12D89
	mov	bx, 3C6Ah	;@12D8B
	call	L13ABB	;@12D8E
	cmp	byte ptr ds:[5009h], 0	;@12D91
	jne	@@2	;@12D96
	mov	si, word ptr ds:[5007h]	;@12D98
	call	L13B98	;@12D9C
@@2:	cmp	byte ptr ds:[38DCh], 0	;@12D9F
	jne	@@3	;@12DA4
	mov	al, 8	;@12DA6
	mov	bx, 3695h	;@12DA8
	call	L13ABB	;@12DAB
@@3:	xor	ax, ax	;@12DAE
	xor	cl, cl	;@12DB0
	call	L13C07	;@12DB2
	call	L13B89	;@12DB5
	call	L13BB2	;@12DB8
	mov	al, 10h	;@12DBB
	mov	bx, 4221h	;@12DBD
	call	L13ABB	;@12DC0
	mov	al, 11h	;@12DC3
	mov	bx, 36B2h	;@12DC5
	call	L13ABB	;@12DC8
	mov	al, 0	;@12DCB
	mov	bx, 3C7Ch	;@12DCD
	call	L13ABB	;@12DD0
	mov	al, 0Ah	;@12DD3
	mov	bx, 3CB2h	;@12DD5
	call	L13ABB	;@12DD8
	call	L14188	;@12DDB
	mov	al, 0Ch	;@12DDE
	mov	bx, 3D46h	;@12DE0
	call	L13ABB	;@12DE3
	call	L13D2A	;@12DE6
	call	L141D2	;@12DE9
	mov	al, 0	;@12DEC
	mov	bx, 3D12h	;@12DEE
	call	L13ABB	;@12DF1
	mov	al, 0Dh	;@12DF4
	mov	bx, 3CE0h	;@12DF6
	call	L13ABB	;@12DF9
	call	L13D2A	;@12DFC
	mov	al, 0Bh	;@12DFF
	mov	bx, 3D81h	;@12E01
	call	L13ABB	;@12E04
	mov	al, 13h	;@12E07
	mov	bx, 3DCDh	;@12E09
	call	L13ABB	;@12E0C
	mov	al, 12h	;@12E0F
	mov	bx, 3D70h	;@12E11
	call	L13ABB	;@12E14
	cmp	byte ptr ds:[38DCh], 0	;@12E17
	jne	@@4	;@12E1C
	call	L13BC0	;@12E1E
@@4:	db	0E8h, 82h, 5	; call L133A6	;@12E21
	db	0E8h, 4Ch, 3	; call L13173	;@12E24
	db	0E8h, 44h, 2	; call L1306E	;@12E27
	mov	al, 15h	;@12E2A
	mov	bx, 3B3Eh	;@12E2C
	call	L13ABB	;@12E2F
	mov	al, 16h	;@12E32
	mov	bx, 3B59h	;@12E34
	call	L13ABB	;@12E37
	mov	al, 14h	;@12E3A
	mov	bx, 3AFEh	;@12E3C
	call	L13ABB	;@12E3F
	mov	al, 0	;@12E42
	mov	bx, 3E4Ah	;@12E44
	call	L13ABB	;@12E47
	mov	al, 0Eh	;@12E4A
	mov	bx, 3E07h	;@12E4C
	call	L13ABB	;@12E4F
	call	L13B4E	;@12E52
	retf	;@12E55
L12E56:	call	L13B2C	;@12E56
	retf	;@12E59
L12E5A:	push	cx	;@12E5A
	push	dx	;@12E5B
	mov	dx, 2	;@12E5C
	db	0E8h, 0EAh, 0	; call L12F4C	;@12E5F
	pop	dx	;@12E62
	mov	cx, es	;@12E63
	mov	ds, cx	;@12E65
	mov	cx, word ptr ds:[0Eh]	;@12E67
	jcxz	@@1	;@12E6B
	mov	es, cx	;@12E6D
	mov	word ptr es:[2], ax	;@12E6F
	jmp	short @@2	;@12E73
@@1:	mov	word ptr ds:[0Ch], ax	;@12E75
@@2:	mov	word ptr ds:[0Eh], ax	;@12E78
	mov	es, ax	;@12E7B
	mov	word ptr es:[0], cx	;@12E7D
	xor	cx, cx	;@12E82
	mov	word ptr es:[2], cx	;@12E84
	mov	word ptr es:[1Ch], cx	;@12E89
	mov	word ptr es:[1Eh], cx	;@12E8E
	mov	cx, ss	;@12E93
	mov	ds, cx	;@12E95
	pop	cx	;@12E97
	ret	;@12E98
L12E99:	push	ax	;@12E99
	push	cx	;@12E9A
	push	dx	;@12E9B
	mov	dx, 2	;@12E9C
	db	0E8h, 0AAh, 0	; call L12F4C	;@12E9F
	mov	es, ax	;@12EA2
	mov	cx, word ptr ds:[4FEAh]	;@12EA4
	mov	dx, es	;@12EA8
	mov	word ptr ds:[4FEAh], dx	;@12EAA
	mov	word ptr es:[0], cx	;@12EAE
	mov	word ptr es:[2], 0	;@12EB3
	jcxz	@@1	;@12EBA
	push	ds	;@12EBC
	mov	ds, cx	;@12EBD
	mov	word ptr ds:[2], dx	;@12EBF
	pop	ds	;@12EC3
	jmp	short @@2	;@12EC4
@@1:	mov	word ptr ds:[4FE8h], dx	;@12EC6
@@2:	pop	dx	;@12ECA
	xor	ax, ax	;@12ECB
	mov	word ptr es:[1Ch], ax	;@12ECD
	mov	word ptr es:[1Eh], ax	;@12ED1
	pop	cx	;@12ED5
	pop	ax	;@12ED6
	mov	word ptr es:[6], ax	;@12ED7
	mov	byte ptr es:[5], cl	;@12EDB
	ret	;@12EE0
L12EE1:	mov	cx, word ptr es:[0Ch]	;@12EE1
	push	es	;@12EE6
@@1:	jcxz	@@2	;@12EE7
	mov	es, cx	;@12EE9
	push	word ptr es:[2]	;@12EEB
	call	L12F12	;@12EF0
	pop	cx	;@12EF3
	jmp	@@1	;@12EF4
@@2:	pop	es	;@12EF6
	xor	ax, ax	;@12EF7
	mov	word ptr es:[0Ch], ax	;@12EF9
	mov	word ptr es:[0Eh], ax	;@12EFD
	mov	word ptr es:[10h], ax	;@12F01
	mov	word ptr es:[12h], ax	;@12F05
	mov	word ptr es:[1Eh], ax	;@12F09
	mov	word ptr es:[1Ch], ax	;@12F0D
	ret	;@12F11
L12F12:	mov	al, byte ptr es:[4]	;@12F12
	cmp	al, 3	;@12F16
	db	72h, 1Ch	; jb @@3	;@12F18
	cmp	al, 8	;@12F1A
	db	72h, 0Ah	; jb @@2	;@12F1C
@@1:	mov	ax, es	;@12F1E
	mov	dx, 2	;@12F20
	push	cs	;@12F23
	db	0E8h, 7Fh, 0CBh	; call L0FAA6	;@12F24
	db	0C3h	; ret	;@12F27
@@2:	mov	ax, es	;@12F28
	mov	dl, byte ptr es:[5]	;@12F2A
	xor	dh, dh	;@12F2F
	push	cs	;@12F31
	db	0E8h, 71h, 0CBh	; call L0FAA6	;@12F32
	db	0C3h	; ret	;@12F35
@@3:	mov	cx, word ptr es:[0Ch]	;@12F36
@@4:	jcxz	@@1	;@12F3B
	push	es	;@12F3D
	mov	es, cx	;@12F3E
	push	word ptr es:[2]	;@12F40
	call	L12F12	;@12F45
	pop	cx	;@12F48
	pop	es	;@12F49
	jmp	@@4	;@12F4A
L12F4C:	cmp	word ptr ds:[4FF4h], dx	;@12F4C
	db	73h, 27h	; jae @@2	;@12F50
	push	dx	;@12F52
	mov	dx, word ptr ds:[4FF4h]	;@12F53
	and	dx, dx	;@12F57
	db	74h, 0Dh	; je @@1	;@12F59
	mov	ax, word ptr ds:[4FF2h]	;@12F5B
	push	cs	;@12F5E
	db	0E8h, 44h, 0CBh	; call L0FAA6	;@12F5F
	db	0C7h, 6, 0F4h, 4Fh, 0, 0	; mov word ptr ds:[4FF4h], 0	;@12F62
@@1:	pop	dx	;@12F68
	mov	ax, dx	;@12F69
	mov	cx, 100h	;@12F6B
	push	cs	;@12F6E
	db	0E8h, 0A6h, 0CBh	; call L0FB18	;@12F6F
	db	89h, 0Eh, 0F4h, 4Fh	; mov word ptr ds:[4FF4h], cx	;@12F72
	mov	word ptr ds:[4FF2h], ax	;@12F76
@@2:	mov	ax, word ptr ds:[4FF2h]	;@12F79
	add	word ptr ds:[4FF2h], dx	;@12F7C
	sub	word ptr ds:[4FF4h], dx	;@12F80
	ret	;@12F84
L12F85:	xor	ax, ax	;@12F85
	xchg	word ptr es:[1Eh], ax	;@12F87
	or	ax, ax	;@12F8C
	je	@@3	;@12F8E
	push	cx	;@12F90
	mov	cx, es	;@12F91
	mov	ds, cx	;@12F93
	mov	es, ax	;@12F95
	mov	cx, word ptr ds:[1Ah]	;@12F97
	mov	word ptr es:[2], cx	;@12F9B
	mov	es, cx	;@12FA0
	mov	cx, word ptr es:[0]	;@12FA2
	mov	word ptr es:[0], ax	;@12FA7
	jcxz	@@1	;@12FAB
	mov	es, cx	;@12FAD
	mov	word ptr es:[2], ax	;@12FAF
	jmp	short @@2	;@12FB3
@@1:	mov	word ptr ds:[0Ch], ax	;@12FB5
@@2:	mov	es, ax	;@12FB8
	mov	word ptr es:[0], cx	;@12FBA
	jmp	short L12FFB	;@12FBF
@@3:	ret	;@12FC1
L12FC2:	mov	di, 1Eh	;@12FC2
	call	L12FCB	;@12FC5
	mov	di, 1Ch	;@12FC8
L12FCB:	xor	ax, ax	;@12FCB
	xchg	word ptr es:[di], ax	;@12FCD
	or	ax, ax	;@12FD0
	db	74h, 52h	; je L13026	;@12FD2
	push	cx	;@12FD4
	mov	cx, es	;@12FD5
	mov	ds, cx	;@12FD7
	mov	cx, word ptr ds:[0Eh]	;@12FD9
	jcxz	@@1	;@12FDD
	mov	es, cx	;@12FDF
	mov	word ptr es:[2], ax	;@12FE1
	jmp	short @@2	;@12FE5
@@1:	mov	word ptr ds:[0Ch], ax	;@12FE7
@@2:	mov	word ptr ds:[0Eh], ax	;@12FEA
	mov	es, ax	;@12FED
	mov	word ptr es:[0], cx	;@12FEF
	mov	word ptr es:[2], 0	;@12FF4
L12FFB:	mov	ax, word ptr es:[6]	;@12FFB
	add	ax, 0Fh	;@12FFF
	mov	cl, 4	;@13002
	shr	ax, cl	;@13004
	push	dx	;@13006
	mov	dx, ax	;@13007
	xchg	byte ptr es:[5], dl	;@13009
	push	ax	;@1300E
	mov	cx, es	;@1300F
	mov	ax, ds	;@13011
	mov	es, ax	;@13013
	mov	ax, ss	;@13015
	mov	ds, ax	;@13017
	pop	ax	;@13019
	sub	dx, ax	;@1301A
	db	74h, 6	; je @@1	;@1301C
	add	ax, cx	;@1301E
	push	cs	;@13020
	db	0E8h, 82h, 0CAh	; call L0FAA6	;@13021
@@1:	db	5Ah	; pop dx	;@13024
	pop	cx	;@13025
L13026:	ret	;@13026
L13027:	mov	cx, word ptr ds:[4FE8h]	;@13027
@@1:	jcxz	@@3	;@1302B
	mov	es, cx	;@1302D
	push	word ptr es:[2]	;@1302F
	cmp	byte ptr es:[4], al	;@13034
	jne	@@2	;@13039
	push	ax	;@1303B
	push	bx	;@1303C
	call	bx	;@1303D
	pop	bx	;@1303F
	pop	ax	;@13040
@@2:	pop	cx	;@13041
	jmp	@@1	;@13042
@@3:	ret	;@13044
L13045:	mov	ax, word ptr es:[6]	;@13045
	mov	cl, byte ptr es:[5]	;@13049
	mov	bx, word ptr es:[0Ah]	;@1304E
	mov	dx, word ptr es:[0Ch]	;@13053
	mov	word ptr es:[8], 0	;@13058
	jmp	L13C07	;@1305F
L13062:	mov	ax, word ptr es:[6]	;@13062
	mov	cl, byte ptr es:[5]	;@13066
	jmp	L13BDF	;@1306B
L1306E:	mov	word ptr ds:[4FFAh], 0	;@1306E
	call	L13C99	;@13074
	mov	byte ptr ds:[5009h], 0	;@13077
	mov	bx, 3720h	;@1307C
	mov	al, 4	;@1307F
	call	L13ABB	;@13081
	call	L13D2A	;@13084
	cmp	byte ptr ds:[5009h], 0	;@13087
	je	@@1	;@1308C
	ret	;@1308E
@@1:	test	word ptr ds:[38C4h], 4000h	;@1308F
	je	@@4	;@13095
	mov	cx, word ptr ds:[4FE8h]	;@13097
@@2:	jcxz	@@4	;@1309B
	mov	es, cx	;@1309D
	cmp	byte ptr es:[4], 8	;@1309F
	je	@@3	;@130A5
	mov	cx, word ptr es:[2]	;@130A7
	jmp	@@2	;@130AC
@@3:	push	es	;@130AE
	mov	ax, word ptr es:[6]	;@130AF
	mov	cl, byte ptr es:[5]	;@130B3
	mov	bx, word ptr es:[0Ah]	;@130B8
	mov	dx, word ptr es:[0Ch]	;@130BD
	mov	bp, word ptr es:[8]	;@130C2
	call	L13C2F	;@130C7
	pop	es	;@130CA
	mov	word ptr es:[8], ax	;@130CB
@@4:	ret	;@130CF
L130D0:	mov	byte ptr ds:[5009h], 0FFh	;@130D0
	mov	si, 8	;@130D5
	mov	cx, word ptr es:[6]	;@130D8
	cmp	cx, si	;@130DD
	je	@@2	;@130DF
@@1:	push	cx	;@130E1
	mov	al, byte ptr es:[si]	;@130E2
	inc	si	;@130E5
	and	al, al	;@130E6
	je	@@3	;@130E8
	mov	bl, al	;@130EA
	and	ax, 0Fh	;@130EC
	add	word ptr ds:[5000h], ax	;@130EF
	adc	word ptr ds:[5002h], 0	;@130F3
	mov	cl, 4	;@130F8
	shr	bl, cl	;@130FA
	and	bx, 0Fh	;@130FC
	add	word ptr ds:[5004h], bx	;@130FF
	jmp	short @@5	;@13103
@@2:	ret	;@13105
@@3:	mov	ax, word ptr es:[si]	;@13106
	cmp	ax, word ptr ds:[4FFAh]	;@13109
	je	@@4	;@1310D
	mov	word ptr ds:[4FFAh], ax	;@1310F
	push	es	;@13112
	push	si	;@13113
	call	L13D2A	;@13114
	mov	es, word ptr ds:[4FFAh]	;@13117
	push	es	;@1311B
	mov	ax, word ptr es:[6]	;@1311C
	mov	cl, byte ptr es:[5]	;@13120
	mov	bx, word ptr es:[0Ah]	;@13125
	mov	dx, word ptr es:[0Ch]	;@1312A
	mov	bp, word ptr es:[8]	;@1312F
	call	L13C2F	;@13134
	pop	es	;@13137
	mov	word ptr es:[8], ax	;@13138
	call	L13C99	;@1313C
	pop	si	;@1313F
	pop	es	;@13140
@@4:	mov	ax, word ptr es:[si+2]	;@13141
	mov	word ptr ds:[4FFCh], ax	;@13145
	mov	ax, word ptr es:[si+4]	;@13148
	mov	word ptr ds:[4FFEh], ax	;@1314C
	mov	ax, word ptr es:[si+6]	;@1314F
	mov	word ptr ds:[5000h], ax	;@13153
	mov	ax, word ptr es:[si+8]	;@13156
	mov	word ptr ds:[5002h], ax	;@1315A
	mov	ax, word ptr es:[si+0Ah]	;@1315D
	mov	word ptr ds:[5004h], ax	;@13161
	add	si, 0Ch	;@13164
@@5:	call	L13375	;@13167
	pop	cx	;@1316A
	cmp	si, cx	;@1316B
	je	@@6	;@1316D
	jmp	@@1	;@1316F
@@6:	ret	;@13172
L13173:	call	L13C99	;@13173
	mov	byte ptr ds:[5006h], 0	;@13176
	mov	cx, word ptr ds:[4FE8h]	;@1317B
@@1:	jcxz	@@3	;@1317F
	mov	es, cx	;@13181
	cmp	byte ptr es:[4], 5	;@13183
	je	@@4	;@13189
@@2:	mov	cx, word ptr es:[2]	;@1318B
	jmp	@@1	;@13190
@@3:	jmp	L13333	;@13192
@@4:	mov	si, 8	;@13195
@@5:	mov	cx, word ptr es:[6]	;@13198
	cmp	si, cx	;@1319D
	je	@@2	;@1319F
	mov	bl, byte ptr es:[si]	;@131A1
	xor	bh, bh	;@131A4
	shl	bx, 1	;@131A6
	call	word ptr [bx+1A70h]	;@131A8
	jmp	@@5	;@131AC
L131AE:	call	L13347	;@131AE
	mov	ax, word ptr es:[si+1]	;@131B1
	mov	cl, byte ptr es:[si+3]	;@131B5
	add	si, 4	;@131B9
	push	si	;@131BC
	push	es	;@131BD
	call	L13D39	;@131BE
	pop	es	;@131C1
	pop	si	;@131C2
	ret	;@131C3
L131C4:	push	si	;@131C4
	push	es	;@131C5
	call	L13D2A	;@131C6
	pop	es	;@131C9
	pop	si	;@131CA
	add	si, 1	;@131CB
	jmp	L13C99	;@131CE
L131D1:	push	es	;@131D1
	push	si	;@131D2
	xor	cx, cx	;@131D3
@@1:	mov	al, byte ptr es:[si]	;@131D5
	cmp	al, 4	;@131D8
	je	@@3	;@131DA
	cmp	al, 5	;@131DC
	je	@@4	;@131DE
@@2:	pop	si	;@131E0
	pop	es	;@131E1
	call	L13333	;@131E2
	mov	ax, word ptr es:[si+1]	;@131E5
	mov	bx, word ptr es:[si+3]	;@131E9
	mov	dx, word ptr es:[si+5]	;@131ED
	add	si, 7	;@131F1
	push	es	;@131F4
	push	si	;@131F5
	mov	es, ax	;@131F6
	mov	ax, word ptr es:[8]	;@131F8
	call	L13D9C	;@131FC
	pop	si	;@131FF
	pop	es	;@13200
	mov	byte ptr ds:[5006h], 0	;@13201
	jmp	L13C99	;@13206
@@3:	add	si, 7	;@13209
	inc	cx	;@1320C
	jmp	short @@5	;@1320D
@@4:	add	si, 5	;@1320F
	dec	cx	;@13212
	jne	@@5	;@13213
	pop	ax	;@13215
	pop	ax	;@13216
	ret	;@13217
@@5:	mov	ax, word ptr es:[6]	;@13218
	cmp	si, ax	;@1321C
	jne	@@1	;@1321E
@@6:	mov	ax, word ptr es:[2]	;@13220
	and	ax, ax	;@13224
	je	@@2	;@13226
	mov	es, ax	;@13228
	cmp	byte ptr es:[4], 5	;@1322A
	jne	@@6	;@13230
	mov	si, 8	;@13232
	jmp	@@1	;@13235
L13237:	call	L13333	;@13237
	mov	bx, word ptr es:[si+1]	;@1323A
	mov	dx, word ptr es:[si+3]	;@1323E
	add	si, 5	;@13242
	push	es	;@13245
	push	si	;@13246
	call	L13DC1	;@13247
	pop	si	;@1324A
	pop	es	;@1324B
	mov	byte ptr ds:[5006h], 0	;@1324C
	jmp	L13C99	;@13251
L13254:	call	L13333	;@13254
	xor	di, di	;@13257
	mov	cx, word ptr es:[si+7]	;@13259
	cmp	cx, word ptr es:[si+9]	;@1325D
	je	@@1	;@13261
	push	es	;@13263
	mov	es, cx	;@13264
	mov	di, word ptr es:[8]	;@13266
	pop	es	;@1326B
@@1:	push	es	;@1326C
	push	si	;@1326D
	mov	bx, word ptr es:[si+0Bh]	;@1326E
	mov	dx, word ptr es:[si+0Dh]	;@13272
	mov	bp, word ptr es:[si+5]	;@13276
	mov	ax, word ptr es:[si+1]	;@1327A
	mov	cl, byte ptr es:[si+3]	;@1327E
	mov	ch, byte ptr es:[si+4]	;@13282
	mov	es, word ptr es:[si+9]	;@13286
	mov	si, word ptr es:[8]	;@1328A
	call	L13DD4	;@1328F
	pop	si	;@13292
	pop	es	;@13293
	add	si, 0Fh	;@13294
	mov	byte ptr ds:[5006h], 0	;@13297
	jmp	L13C99	;@1329C
L1329F:	call	L13333	;@1329F
	push	es	;@132A2
	mov	bx, word ptr es:[si+6]	;@132A3
	mov	dx, word ptr es:[si+8]	;@132A7
	mov	bp, word ptr es:[si+4]	;@132AB
	mov	ax, word ptr es:[si+1]	;@132AF
	mov	cl, byte ptr es:[si+3]	;@132B3
	add	si, 0Ah	;@132B7
	push	si	;@132BA
	call	L13E14	;@132BB
	pop	si	;@132BE
	pop	es	;@132BF
	mov	byte ptr ds:[5006h], 0	;@132C0
	jmp	L13C99	;@132C5
L132C8:	call	L13333	;@132C8
	push	es	;@132CB
	mov	bp, word ptr es:[si+4]	;@132CC
	mov	ax, word ptr es:[si+1]	;@132D0
	mov	cl, byte ptr es:[si+3]	;@132D4
	add	si, 6	;@132D8
	push	si	;@132DB
	call	L13E35	;@132DC
	pop	si	;@132DF
	pop	es	;@132E0
	mov	byte ptr ds:[5006h], 0	;@132E1
	jmp	L13C99	;@132E6
L132E9:	call	L1335E	;@132E9
	mov	ax, word ptr es:[si+1]	;@132EC
	mov	word ptr ds:[4FFEh], ax	;@132F0
	mov	ax, word ptr es:[si+3]	;@132F3
	mov	word ptr ds:[4FFCh], ax	;@132F7
	mov	ax, word ptr es:[si+5]	;@132FA
	mov	word ptr ds:[5004h], ax	;@132FE
	mov	ax, word ptr es:[si+7]	;@13301
	mov	word ptr ds:[5000h], ax	;@13305
	mov	ax, word ptr es:[si+9]	;@13308
	mov	word ptr ds:[5002h], ax	;@1330C
	add	si, 0Bh	;@1330F
	jmp	short L13375	;@13312
L13314:	call	L1335E	;@13314
	mov	al, byte ptr es:[si+1]	;@13317
	xor	ah, ah	;@1331B
	add	word ptr ds:[5004h], ax	;@1331D
	mov	al, byte ptr es:[si+2]	;@13321
	add	word ptr ds:[5000h], ax	;@13325
	adc	word ptr ds:[5002h], 0	;@13329
	add	si, 3	;@1332E
	jmp	short L13375	;@13331
L13333:	push	si	;@13333
	push	es	;@13334
	cmp	byte ptr ds:[5006h], 0	;@13335
	je	@@1	;@1333A
	call	L13D2A	;@1333C
	jmp	short @@2	;@1333F
@@1:	call	L13D2A	;@13341
@@2:	pop	es	;@13344
	pop	si	;@13345
	ret	;@13346
L13347:	cmp	byte ptr ds:[5006h], 0	;@13347
	je	@@1	;@1334C
	push	si	;@1334E
	push	es	;@1334F
	call	L13D2A	;@13350
	pop	es	;@13353
	pop	si	;@13354
	mov	byte ptr ds:[5006h], 0	;@13355
	jmp	L13C99	;@1335A
@@1:	ret	;@1335D
L1335E:	cmp	byte ptr ds:[5006h], 0	;@1335E
	jne	@@1	;@13363
	push	si	;@13365
	push	es	;@13366
	call	L13D2A	;@13367
	pop	es	;@1336A
	pop	si	;@1336B
	mov	byte ptr ds:[5006h], 0FFh	;@1336C
	jmp	L13C99	;@13371
@@1:	ret	;@13374
L13375:	push	es	;@13375
	push	si	;@13376
	mov	bx, word ptr ds:[5000h]	;@13377
	mov	dx, word ptr ds:[5002h]	;@1337B
	mov	ax, word ptr ds:[5004h]	;@1337F
	mov	si, word ptr ds:[4FFCh]	;@13382
	mov	di, word ptr ds:[4FFEh]	;@13386
	cmp	si, di	;@1338A
	je	@@1	;@1338C
	mov	es, di	;@1338E
	mov	di, word ptr es:[8]	;@13390
	jmp	short @@2	;@13395
@@1:	xor	di, di	;@13397
@@2:	mov	es, si	;@13399
	mov	si, word ptr es:[8]	;@1339B
	call	L13C9F	;@133A0
	pop	si	;@133A3
	pop	es	;@133A4
	ret	;@133A5
L133A6:	test	word ptr ds:[38C4h], 4000h	;@133A6
	je	@@1	;@133AC
	call	L13E53	;@133AE
@@1:	mov	cx, word ptr ds:[4FE8h]	;@133B1
	mov	word ptr ds:[5004h], cx	;@133B5
@@2:	jcxz	@@4	;@133B9
	mov	es, cx	;@133BB
	mov	al, byte ptr es:[4]	;@133BD
	push	es	;@133C1
	cmp	al, 1Fh	;@133C2
	je	@@5	;@133C4
	cmp	al, 1Bh	;@133C6
	je	@@6	;@133C8
	cmp	al, 1Ch	;@133CA
	je	@@7	;@133CC
	cmp	al, 1Dh	;@133CE
	je	@@8	;@133D0
	cmp	al, 1Eh	;@133D2
	je	@@9	;@133D4
	cmp	al, 19h	;@133D6
	je	@@11	;@133D8
	cmp	al, 1Ah	;@133DA
	je	@@12	;@133DC
@@3:	pop	es	;@133DE
	mov	cx, word ptr es:[2]	;@133DF
	jmp	@@2	;@133E4
@@4:	ret	;@133E6
@@5:	mov	bx, word ptr es:[16h]	;@133E7
	mov	ax, word ptr es:[6]	;@133EC
	mov	dx, word ptr es:[8]	;@133F0
	mov	bp, word ptr es:[14h]	;@133F5
	call	L13F76	;@133FA
	jmp	@@3	;@133FD
@@6:	mov	si, 4526h	;@133FF
	jmp	short @@10	;@13402
@@7:	mov	si, 454Eh	;@13404
	jmp	short @@10	;@13407
@@8:	mov	si, 4576h	;@13409
	jmp	short @@10	;@1340C
@@9:	mov	si, 459Eh	;@1340E
@@10:	mov	bx, word ptr es:[16h]	;@13411
	mov	bp, word ptr es:[14h]	;@13416
	call	si	;@1341B
	jmp	@@3	;@1341D
@@11:	mov	si, 44E4h	;@1341F
	jmp	short @@13	;@13422
@@12:	mov	si, 4505h	;@13424
@@13:	push	si	;@13427
	call	L13C99	;@13428
	mov	ax, es	;@1342B
@@14:	mov	cx, word ptr ds:[5004h]	;@1342D
	mov	es, cx	;@13431
	mov	dx, word ptr es:[2]	;@13433
	mov	word ptr ds:[5004h], dx	;@13438
	cmp	ax, cx	;@1343C
	je	@@16	;@1343E
	cmp	byte ptr es:[4], 18h	;@13440
	jne	@@15	;@13446
	push	ax	;@13448
	mov	ax, word ptr es:[6]	;@13449
	mov	cl, byte ptr es:[5]	;@1344D
	mov	bl, byte ptr es:[0Ch]	;@13452
	mov	bp, word ptr es:[8]	;@13457
	call	L13FAF	;@1345C
	pop	ax	;@1345F
	jmp	@@14	;@13460
@@15:	cmp	byte ptr es:[4], 17h	;@13462
	jne	@@14	;@13468
	push	ax	;@1346A
	mov	ax, word ptr es:[6]	;@1346B
	mov	cl, byte ptr es:[5]	;@1346F
	mov	bx, word ptr es:[0Ch]	;@13474
	mov	dx, word ptr es:[0Eh]	;@13479
	mov	bp, word ptr es:[8]	;@1347E
	call	L14004	;@13483
	pop	ax	;@13486
	jmp	@@14	;@13487
@@16:	push	ax	;@13489
	call	L14062	;@1348A
	pop	ax	;@1348D
	mov	es, ax	;@1348E
	mov	ax, word ptr es:[6]	;@13490
	mov	cl, byte ptr es:[5]	;@13494
	mov	bx, word ptr es:[0Ch]	;@13499
	mov	dx, word ptr es:[0Eh]	;@1349E
	mov	bp, word ptr es:[8]	;@134A3
	pop	si	;@134A8
	call	si	;@134A9
	jmp	@@3	;@134AB
L134AE:	xor	di, di	;@134AE
	mov	cx, word ptr es:[10h]	;@134B0
	cmp	cx, word ptr es:[0Ah]	;@134B5
	je	@@1	;@134BA
	push	es	;@134BC
	mov	es, cx	;@134BD
	mov	di, word ptr es:[8]	;@134BF
	pop	es	;@134C4
@@1:	mov	bx, word ptr es:[0Ch]	;@134C5
	mov	dx, word ptr es:[0Eh]	;@134CA
	push	es	;@134CF
	mov	es, word ptr es:[0Ah]	;@134D0
	mov	si, word ptr es:[8]	;@134D5
	pop	es	;@134DA
	mov	ax, word ptr es:[6]	;@134DB
	mov	cl, byte ptr es:[5]	;@134DF
	xor	ch, ch	;@134E4
	mov	bp, word ptr es:[8]	;@134E6
	jmp	L13DD4	;@134EB
L134EE:	mov	bx, word ptr es:[0Ch]	;@134EE
	mov	dx, word ptr es:[0Eh]	;@134F3
	mov	ax, word ptr es:[6]	;@134F8
	mov	cl, byte ptr es:[5]	;@134FC
	mov	bp, word ptr es:[8]	;@13501
	jmp	L13E14	;@13506
L13509:	mov	ax, word ptr es:[6]	;@13509
	mov	cl, byte ptr es:[5]	;@1350D
	mov	bp, word ptr es:[8]	;@13512
	jmp	L13E35	;@13517
L1351A:	mov	cx, word ptr ds:[4FE8h]	;@1351A
	jcxz	@@6	;@1351E
@@1:	mov	es, cx	;@13520
	cmp	byte ptr es:[4], 0	;@13522
	je	@@4	;@13528
@@2:	mov	cx, word ptr es:[2]	;@1352A
@@3:	jcxz	@@5	;@1352F
	jmp	@@1	;@13531
@@4:	test	byte ptr es:[19h], 2	;@13533
	jne	@@2	;@13539
	db	0E8h, 0AFh, 0	; call @@19	;@1353B
	mov	dx, es	;@1353E
	push	cx	;@13540
	call	@@7	;@13541
	pop	cx	;@13544
	jmp	@@3	;@13545
@@5:	mov	ax, word ptr ds:[4FECh]	;@13547
	and	ax, ax	;@1354A
	je	@@6	;@1354C
	xchg	word ptr ds:[4FE8h], ax	;@1354E
	mov	es, word ptr ds:[4FEEh]	;@13552
	mov	word ptr es:[2], ax	;@13556
	and	ax, ax	;@1355A
	je	@@6	;@1355C
	mov	cx, es	;@1355E
	mov	es, ax	;@13560
	mov	word ptr es:[0], cx	;@13562
@@6:	ret	;@13567
@@7:	mov	cx, word ptr ds:[4FECh]	;@13568
@@8:	jcxz	@@9	;@1356C
	push	cx	;@1356E
	push	dx	;@1356F
	mov	ax, cx	;@13570
	call	@@14	;@13572
	pop	dx	;@13575
	pop	cx	;@13576
	jae	@@9	;@13577
	mov	es, cx	;@13579
	mov	cx, word ptr es:[2]	;@1357B
	jmp	@@8	;@13580
@@9:	mov	es, dx	;@13582
	mov	dx, es	;@13584
	jcxz	@@10	;@13586
	push	ds	;@13588
	mov	ds, cx	;@13589
	mov	ax, word ptr ds:[0]	;@1358B
	mov	word ptr ds:[0], dx	;@1358E
	pop	ds	;@13592
	jmp	short @@11	;@13593
@@10:	mov	ax, word ptr ds:[4FEEh]	;@13595
	mov	word ptr ds:[4FEEh], dx	;@13598
@@11:	and	ax, ax	;@1359C
	je	@@12	;@1359E
	push	ds	;@135A0
	mov	ds, ax	;@135A1
	mov	word ptr ds:[2], dx	;@135A3
	pop	ds	;@135A7
	jmp	short @@13	;@135A8
@@12:	mov	word ptr ds:[4FECh], dx	;@135AA
@@13:	mov	word ptr es:[0], ax	;@135AE
	mov	word ptr es:[2], cx	;@135B2
	ret	;@135B7
@@14:	mov	es, ax	;@135B8
	call	@@18	;@135BA
	push	es	;@135BD
	mov	si, di	;@135BE
	mov	bx, cx	;@135C0
	mov	es, dx	;@135C2
	call	@@18	;@135C4
	pop	ds	;@135C7
	cmp	cx, bx	;@135C8
	mov	bh, cl	;@135CA
	jb	@@15	;@135CC
	mov	cl, bl	;@135CE
@@15:	repe cmpsb	;@135D0
	je	@@17	;@135D2
@@16:	mov	ax, ss	;@135D4
	mov	ds, ax	;@135D6
	ret	;@135D8
@@17:	cmp	bl, bh	;@135D9
	jmp	@@16	;@135DB
@@18:	mov	ax, word ptr es:[6]	;@135DD
	mov	cl, byte ptr es:[5]	;@135E1
	mov	ch, 0	;@135E6
	push	cs	;@135E8
	db	0E8h, 0F4h, 0C6h	; call L0FCE0	;@135E9
	db	0C3h	; ret	;@135EC
@@19:	mov	dx, word ptr es:[0]	;@135ED
	mov	cx, word ptr es:[2]	;@135F2
	jcxz	@@20	;@135F7
	push	ds	;@135F9
	mov	ds, cx	;@135FA
	mov	word ptr ds:[0], dx	;@135FC
	pop	ds	;@13600
	jmp	short @@21	;@13601
@@20:	mov	word ptr ds:[4FEAh], dx	;@13603
@@21:	and	dx, dx	;@13607
	je	@@22	;@13609
	push	ds	;@1360B
	mov	ds, dx	;@1360C
	mov	word ptr ds:[2], cx	;@1360E
	pop	ds	;@13612
	jmp	short @@23	;@13613
@@22:	mov	word ptr ds:[4FE8h], cx	;@13615
@@23:	ret	;@13619
L1361A:	mov	byte ptr ds:[5009h], 0FFh	;@1361A
	mov	dx, word ptr es:[6]	;@1361F
	mov	cl, byte ptr es:[5]	;@13624
	jmp	L13B66	;@13629
L1362C:	mov	dl, byte ptr es:[19h]	;@1362C
	test	dl, 2	;@13631
	jne	@@1	;@13634
	push	es	;@13636
	mov	ax, word ptr es:[6]	;@13637
	mov	cl, byte ptr es:[5]	;@1363B
	mov	bx, word ptr es:[14h]	;@13640
	mov	si, word ptr es:[16h]	;@13645
	mov	dh, byte ptr es:[18h]	;@1364A
	mov	di, word ptr es:[10h]	;@1364F
	mov	bp, word ptr es:[12h]	;@13654
	call	L140D6	;@13659
	pop	es	;@1365C
	mov	word ptr es:[8], ax	;@1365D
@@1:	ret	;@13661
L13662:	push	es	;@13662
	mov	ax, word ptr es:[6]	;@13663
	mov	cl, byte ptr es:[5]	;@13667
	call	L14094	;@1366C
	pop	es	;@1366F
	mov	word ptr es:[8], ax	;@13670
	mov	cx, word ptr es:[0Ah]	;@13674
@@1:	jcxz	@@2	;@13679
	mov	es, cx	;@1367B
	push	es	;@1367D
	mov	ax, word ptr es:[8]	;@1367E
	call	L140BC	;@13682
	pop	es	;@13685
	mov	cx, word ptr es:[0Ah]	;@13686
	jmp	@@1	;@1368B
@@2:	jmp	L140CF	;@1368D
L13690:	push	es	;@13690
	mov	ax, word ptr es:[6]	;@13691
	mov	cl, byte ptr es:[5]	;@13695
	mov	ch, byte ptr es:[14h]	;@1369A
	and	ch, ch	;@1369F
	je	@@1	;@136A1
	mov	ch, 1	;@136A3
@@1:	mov	bx, word ptr es:[0Ch]	;@136A5
	mov	dx, word ptr es:[0Eh]	;@136AA
	mov	si, word ptr es:[10h]	;@136AF
	mov	di, word ptr es:[12h]	;@136B4
	call	L141D8	;@136B9
	pop	es	;@136BC
	mov	word ptr es:[8], ax	;@136BD
	ret	;@136C1
L136C2:	test	byte ptr es:[19h], 2	;@136C2
	je	@@1	;@136C8
	push	es	;@136CA
	mov	ax, word ptr es:[6]	;@136CB
	mov	cl, byte ptr es:[5]	;@136CF
	mov	ch, 2	;@136D4
	mov	si, word ptr es:[10h]	;@136D6
	mov	di, word ptr es:[12h]	;@136DB
	mov	es, word ptr es:[14h]	;@136E0
	mov	bx, word ptr es:[8]	;@136E5
	call	L141D8	;@136EA
	pop	es	;@136ED
	or	ax, 4000h	;@136EE
	mov	word ptr es:[8], ax	;@136F1
@@1:	ret	;@136F5
L136F6:	push	es	;@136F6
	mov	ax, word ptr es:[6]	;@136F7
	mov	cl, byte ptr es:[5]	;@136FB
	call	L1418E	;@13700
	pop	es	;@13703
	mov	word ptr es:[8], ax	;@13704
	test	word ptr ds:[38C4h], 4000h	;@13708
	jne	@@1	;@1370E
	ret	;@13710
@@1:	push	es	;@13711
	call	L13D2A	;@13712
	pop	es	;@13715
	mov	ax, word ptr es:[0Ah]	;@13716
	call	L13C5F	;@1371A
	jmp	L14188	;@1371D
L13720:	push	es	;@13720
	call	@@1	;@13721
	pop	es	;@13724
	mov	ax, word ptr es:[6]	;@13725
	mov	cl, byte ptr es:[5]	;@13729
	jmp	L1429B	;@1372E
@@1:	xor	si, si	;@13731
	xor	di, di	;@13733
	mov	cx, word ptr es:[0Ah]	;@13735
	jcxz	@@3	;@1373A
	mov	dx, word ptr es:[10h]	;@1373C
	push	es	;@13741
	mov	es, cx	;@13742
	mov	si, word ptr es:[8]	;@13744
	cmp	dx, cx	;@13749
	je	@@2	;@1374B
	mov	es, dx	;@1374D
	mov	di, word ptr es:[8]	;@1374F
@@2:	pop	es	;@13754
@@3:	mov	bx, word ptr es:[0Ch]	;@13755
	mov	dx, word ptr es:[0Eh]	;@1375A
	mov	ax, word ptr es:[6]	;@1375F
	mov	cl, byte ptr es:[5]	;@13763
	push	es	;@13768
	call	L142B5	;@13769
	pop	es	;@1376C
	test	word ptr ds:[38C4h], 4000h	;@1376D
	jne	@@4	;@13773
	ret	;@13775
@@4:	mov	ax, word ptr es:[12h]	;@13776
	jmp	L13C77	;@1377A
L1377D:	xor	si, si	;@1377D
	xor	di, di	;@1377F
	mov	cx, word ptr es:[0Ah]	;@13781
	jcxz	@@2	;@13786
	mov	dx, word ptr es:[10h]	;@13788
	push	es	;@1378D
	mov	es, cx	;@1378E
	mov	si, word ptr es:[8]	;@13790
	cmp	dx, cx	;@13795
	je	@@1	;@13797
	mov	es, dx	;@13799
	mov	di, word ptr es:[8]	;@1379B
@@1:	pop	es	;@137A0
@@2:	mov	bx, word ptr es:[0Ch]	;@137A1
	mov	dx, word ptr es:[0Eh]	;@137A6
	mov	ax, word ptr es:[6]	;@137AB
	mov	cl, byte ptr es:[5]	;@137AF
	jmp	L142E4	;@137B4
L137B7:	cmp	byte ptr es:[5], 0	;@137B7
	je	@@1	;@137BD
	mov	bx, 1A82h	;@137BF
	mov	ax, word ptr es:[0Ah]	;@137C2
	mov	dx, word ptr es:[0Ch]	;@137C6
	push	es	;@137CB
	mov	es, ax	;@137CC
	mov	si, word ptr es:[8]	;@137CE
	mov	al, byte ptr es:[4]	;@137D3
	xlat	;@137D7
	mov	cl, al	;@137D8
	mov	es, dx	;@137DA
	mov	di, word ptr es:[8]	;@137DC
	mov	al, byte ptr es:[4]	;@137E1
	xlat	;@137E5
	mov	ch, al	;@137E6
	pop	es	;@137E8
	mov	bx, word ptr es:[6]	;@137E9
	mov	dx, word ptr es:[8]	;@137EE
@@1:	mov	al, byte ptr es:[5]	;@137F3
	jmp	L14475	;@137F7
L137FA:	mov	ax, word ptr es:[8]	;@137FA
	mov	word ptr ds:[500Ch], ax	;@137FE
	mov	ax, word ptr es:[0Ch]	;@13801
	and	ax, ax	;@13805
	je	@@3	;@13807
@@1:	mov	es, ax	;@13809
	mov	al, byte ptr es:[4]	;@1380B
	cmp	al, 6	;@1380F
	je	@@4	;@13811
	cmp	al, 3	;@13813
	je	@@4	;@13815
	cmp	al, 2	;@13817
	jne	@@2	;@13819
	jmp	@@14	;@1381B
@@2:	mov	ax, word ptr es:[2]	;@1381E
	and	ax, ax	;@13822
	jne	@@1	;@13824
@@3:	ret	;@13826
@@4:	mov	word ptr ds:[5012h], es	;@13827
@@5:	cmp	byte ptr es:[4], 3	;@1382B
	je	@@6	;@13831
	mov	es, word ptr es:[2]	;@13833
	jmp	@@5	;@13838
@@6:	mov	bx, word ptr es:[8]	;@1383A
	mov	ax, word ptr es:[0Ah]	;@1383F
	mov	word ptr ds:[500Eh], bx	;@13843
	mov	word ptr ds:[5010h], ax	;@13847
	mov	dx, word ptr ds:[500Ch]	;@1384A
	push	es	;@1384E
	call	L14385	;@1384F
	pop	ds	;@13852
	xor	dx, dx	;@13853
@@7:	mov	si, 0Eh	;@13855
	mov	cx, word ptr ds:[0Ch]	;@13858
	mov	di, dx	;@1385C
	add	dx, cx	;@1385E
	call	L143B0	;@13860
	mov	word ptr ss:[5014h], ds	;@13863
@@8:	mov	ax, word ptr ds:[2]	;@13868
	and	ax, ax	;@1386B
	je	@@9	;@1386D
	mov	ds, ax	;@1386F
	mov	al, byte ptr ds:[4]	;@13871
	cmp	al, 6	;@13874
	je	@@8	;@13876
	cmp	al, 3	;@13878
	jne	@@9	;@1387A
	mov	ax, word ptr ds:[0Ch]	;@1387C
	add	ax, dx	;@1387F
	cmp	ax, 400h	;@13881
	jb	@@7	;@13884
@@9:	mov	di, dx	;@13886
	mov	ax, ss	;@13888
	mov	ds, ax	;@1388A
	call	L143B8	;@1388C
	call	L13C99	;@1388F
	mov	ax, word ptr ds:[5012h]	;@13892
@@10:	cmp	ax, word ptr ds:[5014h]	;@13895
	je	@@13	;@13899
	mov	es, ax	;@1389B
	cmp	byte ptr es:[4], 6	;@1389D
	je	@@11	;@138A3
	mov	ax, word ptr es:[2]	;@138A5
	jmp	@@10	;@138A9
@@11:	mov	di, 0Ah	;@138AB
@@12:	mov	ax, word ptr es:[di+1]	;@138AE
	sub	ax, word ptr ds:[500Eh]	;@138B2
	push	es	;@138B6
	push	di	;@138B7
	call	L13A8A	;@138B8
	pop	di	;@138BB
	pop	es	;@138BC
	add	di, 9	;@138BD
	cmp	di, word ptr es:[6]	;@138C0
	jb	@@12	;@138C5
	mov	ax, word ptr es:[2]	;@138C7
	jmp	@@10	;@138CB
@@13:	call	L13D2A	;@138CD
	mov	es, word ptr ds:[5014h]	;@138D0
	jmp	@@2	;@138D4
@@14:	mov	word ptr ds:[5014h], es	;@138D7
	cmp	word ptr es:[0Ch], 0	;@138DB
	je	@@16	;@138E1
	call	@@17	;@138E3
	mov	dx, word ptr ds:[500Ch]	;@138E6
	mov	bx, word ptr es:[6]	;@138EA
	mov	ax, word ptr es:[8]	;@138EF
	mov	word ptr ds:[500Eh], bx	;@138F3
	mov	word ptr ds:[5010h], ax	;@138F7
	call	L142EA	;@138FA
	mov	byte ptr ds:[500Ah], 0	;@138FD
	call	L1397A	;@13902
	cmp	byte ptr ds:[500Ah], 0	;@13905
	je	@@15	;@1390A
	call	L1437B	;@1390C
@@15:	mov	ax, word ptr es:[10h]	;@1390F
	add	word ptr ds:[500Eh], ax	;@13913
	mov	ax, word ptr es:[12h]	;@13917
	adc	word ptr ds:[5010h], ax	;@1391B
	call	L13C99	;@1391F
	call	L143BF	;@13922
	mov	word ptr ds:[5016h], ax	;@13925
	mov	word ptr ds:[5018h], bx	;@13928
	xor	dx, dx	;@1392C
	call	L13A01	;@1392E
	call	L13D2A	;@13931
	mov	es, word ptr ds:[5014h]	;@13934
	jmp	@@2	;@13938
@@16:	ret	;@1393B
@@17:	xor	cl, cl	;@1393C
	cmp	word ptr es:[8], 0	;@1393E
	jne	@@23	;@13944
	cmp	word ptr es:[16h], 0	;@13946
	jne	@@23	;@1394C
@@18:	push	es	;@1394E
	mov	es, word ptr es:[0Ch]	;@1394F
@@19:	cmp	byte ptr es:[4], 2	;@13954
	jne	@@21	;@1395A
	cmp	word ptr es:[16h], 0	;@1395C
	je	@@20	;@13962
	mov	cl, 1	;@13964
@@20:	call	@@18	;@13966
@@21:	mov	ax, word ptr es:[2]	;@13969
	or	ax, ax	;@1396D
	je	@@22	;@1396F
	mov	es, ax	;@13971
	jmp	@@19	;@13973
@@22:	pop	es	;@13975
	ret	;@13976
@@23:	mov	cl, 1	;@13977
	ret	;@13979
L1397A:	call	L139D4	;@1397A
	jcxz	@@1	;@1397D
	mov	byte ptr ds:[500Ah], 1	;@1397F
@@1:	add	cx, bx	;@13984
	mov	ax, word ptr es:[14h]	;@13986
	mov	dx, word ptr es:[16h]	;@1398A
	call	L14315	;@1398F
	push	es	;@13992
	mov	es, word ptr es:[0Ch]	;@13993
	jmp	short L139A4	;@13998
L1399A:	mov	ax, word ptr es:[2]	;@1399A
	or	ax, ax	;@1399E
	je	L139D2	;@139A0
	mov	es, ax	;@139A2
L139A4:	mov	al, byte ptr es:[4]	;@139A4
	cmp	al, 3	;@139A8
	je	L139B6	;@139AA
	cmp	al, 7	;@139AC
	je	L139C3	;@139AE
	cmp	al, 2	;@139B0
	je	L139CD	;@139B2
	jmp	L1399A	;@139B4
L139B6:	mov	cx, word ptr es:[0Ch]	;@139B6
	mov	si, 0Eh	;@139BB
	call	L14330	;@139BE
	jmp	L1399A	;@139C1
L139C3:	mov	cx, word ptr es:[0Ch]	;@139C3
	call	L14358	;@139C8
	jmp	L1399A	;@139CB
L139CD:	call	L1397A	;@139CD
	jmp	L1399A	;@139D0
L139D2:	pop	es	;@139D2
	ret	;@139D3
L139D4:	push	es	;@139D4
	xor	bx, bx	;@139D5
	xor	cx, cx	;@139D7
	mov	ax, word ptr es:[0Ch]	;@139D9
	or	ax, ax	;@139DD
	je	@@4	;@139DF
@@1:	mov	es, ax	;@139E1
	mov	al, byte ptr es:[4]	;@139E3
	cmp	al, 3	;@139E7
	je	@@2	;@139E9
	cmp	al, 2	;@139EB
	je	@@2	;@139ED
	cmp	al, 7	;@139EF
	jne	@@3	;@139F1
	inc	bx	;@139F3
	jmp	short @@3	;@139F4
@@2:	inc	cx	;@139F6
@@3:	mov	ax, word ptr es:[2]	;@139F7
	or	ax, ax	;@139FB
	jne	@@1	;@139FD
@@4:	pop	es	;@139FF
	ret	;@13A00
L13A01:	add	dx, word ptr ds:[5016h]	;@13A01
	xor	cx, cx	;@13A05
	xor	bx, bx	;@13A07
	push	es	;@13A09
	mov	es, word ptr es:[0Ch]	;@13A0A
	jmp	short @@2	;@13A0F
@@1:	mov	ax, word ptr es:[2]	;@13A11
	or	ax, ax	;@13A15
	je	@@6	;@13A17
	mov	es, ax	;@13A19
@@2:	mov	al, byte ptr es:[4]	;@13A1B
	cmp	al, 3	;@13A1F
	je	@@3	;@13A21
	cmp	al, 7	;@13A23
	je	@@3	;@13A25
	cmp	al, 6	;@13A27
	je	@@5	;@13A29
	cmp	al, 2	;@13A2B
	je	@@4	;@13A2D
	jmp	@@1	;@13A2F
@@3:	add	dx, word ptr ds:[5018h]	;@13A31
	mov	ax, word ptr es:[0Ch]	;@13A35
	add	dx, ax	;@13A39
	add	bx, ax	;@13A3B
	adc	cx, 0	;@13A3D
	jmp	@@1	;@13A40
@@4:	call	L13A01	;@13A42
	push	dx	;@13A45
	mov	si, word ptr es:[10h]	;@13A46
	mov	di, word ptr es:[12h]	;@13A4B
	mov	bx, word ptr es:[14h]	;@13A50
	mov	cx, word ptr es:[16h]	;@13A55
	call	far ptr L0320E	;@13A5A
	add	bx, word ptr es:[6]	;@13A5F
	adc	cx, word ptr es:[8]	;@13A64
	pop	dx	;@13A69
	jmp	@@1	;@13A6A
@@5:	push	bx	;@13A6C
	push	cx	;@13A6D
	push	dx	;@13A6E
	mov	di, 0Ah	;@13A6F
	mov	ax, word ptr es:[di+1]	;@13A72
	sub	ax, bx	;@13A76
	add	ax, dx	;@13A78
	add	ax, word ptr ds:[5018h]	;@13A7A
	push	es	;@13A7E
	call	L13A8A	;@13A7F
	pop	es	;@13A82
	pop	dx	;@13A83
	pop	cx	;@13A84
	pop	bx	;@13A85
	jmp	@@1	;@13A86
@@6:	pop	es	;@13A88
	ret	;@13A89
L13A8A:	push	ax	;@13A8A
	mov	ax, word ptr es:[di+5]	;@13A8B
	mov	dx, word ptr es:[di+7]	;@13A8F
	mov	ch, byte ptr es:[di]	;@13A93
	mov	bx, 1A82h	;@13A96
	mov	es, ax	;@13A99
	mov	si, word ptr es:[8]	;@13A9B
	mov	al, byte ptr es:[4]	;@13AA0
	xlat	;@13AA4
	mov	cl, al	;@13AA5
	mov	es, dx	;@13AA7
	mov	di, word ptr es:[8]	;@13AA9
	mov	al, byte ptr es:[4]	;@13AAE
	xlat	;@13AB2
	mov	dl, ch	;@13AB3
	mov	ch, al	;@13AB5
	pop	bx	;@13AB7
	jmp	L143D4	;@13AB8
L13ABB:	mov	cx, word ptr ds:[4FE8h]	;@13ABB
@@1:	jcxz	@@3	;@13ABF
	mov	es, cx	;@13AC1
	push	word ptr es:[2]	;@13AC3
	cmp	byte ptr es:[4], al	;@13AC8
	jne	@@2	;@13ACD
	push	ax	;@13ACF
	push	bx	;@13AD0
	call	bx	;@13AD1
	pop	bx	;@13AD3
	pop	ax	;@13AD4
@@2:	pop	cx	;@13AD5
	jmp	@@1	;@13AD6
@@3:	ret	;@13AD8
C0F9B	ends
	end
