	.286
	locals
CODE0	segment byte public 'CODE'
CODE0	ends
DATA	segment byte public 'DATA'
DATA	ends
BSS	segment byte public 'BSS'
BSS	ends
DGROUP	group	DATA,BSS
	public	L00094
	public	L000B4
	public	L000E5
	public	L001B8
	public	L00225
	public	L00263
	public	L0026A
	public	L00271
	public	L00279
	public	L0028D
	public	L002A1
	public	L002C8
	public	L002EE
	public	L00319
	public	L00351
	public	L003A8
	public	L003D0
	public	L003DA
	public	L003E8
	public	L0042B
	public	L00462
	public	L00494
	public	L004A1
	public	L004AE
	public	L004C7
	public	L004D3
	public	L004FF
	public	L00529
	public	L00531
	public	L00575
	public	L005B9
	public	L005FD
	public	L0065F
	public	L0066E
	public	L0067F
	public	L00692
	public	L006C2
	public	L006CE
	public	L006DE
	public	L006E5
	public	L006EC
	public	L006F5
	public	L00713
	public	L0072A
	public	L00752
	public	L0075E
	public	L0076E
	public	L007A1
	public	L007F7
	public	L0080F
	public	L0081F
	public	L00853
	public	L00877
	public	L008AD
	public	L008C4
	public	L008ED
	public	L00905
	public	L00928
	public	L00933
	public	L0094E
	public	L00958
	public	L0095C
	public	L0099B
	public	L00A11
	public	L00A29
	public	L00A81
	public	L00A95
	public	L00AAD
	public	L00AEF
	public	L00B09
	public	L00B4C
	public	L00B56
	public	L00BF4
	public	L00C46
	public	L00C62
	public	L00CA5
	public	L00CD9
	public	L00CE9
	public	L00D3D
	public	L00DBC
	public	L00E05
	public	L00E38
	public	L00FC6
	public	L0109C
	public	L01151
	public	L011AE
	public	L0125C
	public	L01282
	public	L0130D
	public	L01312
	public	L0132A
	public	L01357
	public	L01374
	public	L0148E
	public	L014F8
	public	L0150E
	public	L0152F
	public	L0154B
	public	L0155F
	public	L01575
	public	L0157F
	public	L01589
	public	L015A1
	public	L01647
	public	L016B5
	public	L016C5
	public	L016F6
	public	L017DC
	public	L01873
	public	L0188A
	public	L018A8
	public	L018F9
	public	L01911
	public	L0192E
	public	L0199D
	public	L01B94
	public	L01B9D
	public	L01BE5
	public	L01C23
	public	L01C52
	public	L01D39
	public	L01D70
	public	L01D75
	public	L01D7A
	public	L01D9B
	public	L01E4F
	public	L01E75
	public	L01E8D
	public	L01EB5
	public	L01F5A
	public	L01FCE
	public	L020DB
	public	L02622
	public	L02640
	public	L0265C
	public	L026B8
	public	L02F73
	public	L02FA3
	public	L1119A
	public	L111AB
	public	L111FB
	public	L1122D
	public	L11285
	public	L11293
	public	L1129C
	public	L112D0
	public	L112DA
	public	L112E6
	public	L112EC
	public	L112F6
	public	L11304
	public	L1130A
	public	L11310
	public	L11321
	public	L11344
	public	L1134D
	public	L113A1
	public	L1143C
	public	L1148D
	public	L11510
	public	L11570
	public	L115CF
	public	L115E0
	public	L1160D
	public	L11631
	public	L1164A
	public	L1168C
	public	L11694
	public	L11699
	public	L116B9
	public	L11751
	public	L11763
	public	L11788
	public	L11E07
	public	L11E1C
	public	L11E9F
	public	L1200E
	public	L12018
	public	L12051
	public	L120E3
	public	L12124
	extrn	L03208:near
	extrn	L03212:near
	extrn	L0321E:near
	extrn	L03226:near
	extrn	L03244:near
	extrn	L03262:near
	extrn	L03280:near
	extrn	L03424:near
	extrn	L035C9:near
	extrn	L035F0:near
	extrn	L03BCE:near
	extrn	L04A81:near
	extrn	L05363:near
	extrn	L05542:near
	extrn	L055AC:near
	extrn	L05609:near
	extrn	L05625:near
	extrn	L0563B:near
	extrn	L05656:near
	extrn	L056C3:near
	extrn	L05702:near
	extrn	L0752A:near
	extrn	L07533:near
	extrn	L0753C:near
	extrn	L076DE:near
	extrn	L0A7C0:near
	extrn	L0F9E5:near
	extrn	L0FA44:far
	extrn	L0FAA6:far
	extrn	L0FAFB:near
	extrn	L0FB18:far
	extrn	L0FB8D:far
	extrn	L0FC4F:far
	extrn	L0FCE0:far
	extrn	L0FCFE:far
	extrn	L10060:far
	extrn	L100A6:near
	extrn	L108C1:far
	extrn	L10B6F:far
	extrn	L10BAA:far
	extrn	L121FD:near
	extrn	L12222:near
	extrn	L12275:near
	extrn	L12282:near
	extrn	L1228F:far
	extrn	L122AC:near
	extrn	L122D6:near
	extrn	L1232B:far
	extrn	L12358:far
	extrn	L1263F:far
	extrn	L12652:far
	extrn	L12694:far
	extrn	L126A5:far
	extrn	L126CF:far
	extrn	L126F2:far
	extrn	L126FD:far
	extrn	L128AB:far
	extrn	L12931:far
	extrn	L1294D:far
	extrn	L12959:far
	extrn	L12964:far
	extrn	L1296F:far
	extrn	L12C89:far
	extrn	L12CC4:far

C0F9B	segment byte public 'CODE'
	assume	cs:C0F9B
L1119A:	mov	ax, word ptr ds:[399Eh]	;@1119A
	and	ax, ax	;@1119D
	je	@@1	;@1119F
	mov	dx, word ptr ds:[39A0h]	;@111A1
	nosmart
	call	far ptr L0FAA6	;@111A5
	smart
@@1:	retf	;@111AA
L111AB:	cmp	ax, 3E8h	;@111AB
	jae	@@1	;@111AE
	mov	ax, 3E8h	;@111B0
@@1:	cmp	ax, 7FFFh	;@111B3
	jb	@@2	;@111B6
	mov	ax, 7FFFh	;@111B8
@@2:	mov	cl, 0FFh	;@111BB
@@3:	inc	cl	;@111BD
	shl	ax, 1	;@111BF
	jae	@@3	;@111C1
	mov	ax, 0FFFFh	;@111C3
	shr	ax, cl	;@111C6
	mov	word ptr ds:[39A6h], ax	;@111C8
	shl	word ptr ds:[39A6h], 1	;@111CB
	inc	ax	;@111CF
	mov	word ptr ds:[39A2h], ax	;@111D0
	mov	word ptr ds:[39A4h], ax	;@111D3
	shr	ax, 1	;@111D6
	shr	ax, 1	;@111D8
	shr	ax, 1	;@111DA
	mov	word ptr ds:[39A0h], ax	;@111DC
	nosmart
	call	far ptr L0FA44	;@111DF
	smart
	mov	word ptr ds:[399Eh], ax	;@111E4
	mov	cx, word ptr ds:[39A2h]	;@111E7
	mov	es, word ptr ds:[399Eh]	;@111EB
	xor	ax, ax	;@111EF
	mov	bx, ax	;@111F1
@@4:	mov	word ptr es:[bx], ax	;@111F3
	inc	bx	;@111F6
	inc	bx	;@111F7
	loop	@@4	;@111F8
	retf	;@111FA
L111FB:	mov	dx, word ptr ds:[39AEh]	;@111FB
	and	dx, dx	;@111FF
	je	@@1	;@11201
	mov	word ptr ds:[39AEh], 0	;@11203
	mov	ax, word ptr ds:[39ACh]	;@11209
	nosmart
	call	far ptr L0FAA6	;@1120C
	smart
	clc	;@11211
	retf	;@11212
@@1:	mov	dx, word ptr ds:[39AAh]	;@11213
	and	dx, dx	;@11217
	je	@@2	;@11219
	mov	word ptr ds:[39AAh], 0	;@1121B
	mov	ax, word ptr ds:[39A8h]	;@11221
	nosmart
	call	far ptr L0FAA6	;@11224
	smart
	clc	;@11229
	retf	;@1122A
@@2:	stc	;@1122B
	retf	;@1122C
L1122D:	mov	ax, ds	;@1122D
	mov	es, ax	;@1122F
	mov	ah, 30h	;@11231
	int	21h	;@11233
	xchg	al, ah	;@11235
	cmp	ax, 200h	;@11237
	jb	@@5	;@1123A
	mov	di, 4E1Ah	;@1123C
	mov	si, di	;@1123F
	xor	cx, cx	;@11241
@@1:	mov	dx, 0A42h	;@11243
	mov	ax, 3D01h	;@11246
	int	21h	;@11249
	cld	;@1124B
	jb	@@2	;@1124C
	stosw	;@1124E
	inc	cx	;@1124F
	cmp	cx, 10h	;@11250
	jne	@@1	;@11253
@@2:	mov	word ptr ds:[4E18h], cx	;@11255
	mov	dx, si	;@11259
	jcxz	@@4	;@1125B
@@3:	lodsw	;@1125D
	mov	bx, ax	;@1125E
	mov	ah, 3Eh	;@11260
	int	21h	;@11262
	cld	;@11264
	loop	@@3	;@11265
@@4:	mov	di, dx	;@11267
	mov	ax, 3800h	;@11269
	int	21h	;@1126C
	mov	ah, 30h	;@1126E
	int	21h	;@11270
	xchg	al, ah	;@11272
	cld	;@11274
	cmp	ax, 20Bh	;@11275
	cmc	;@11278
	jae	@@5	;@11279
	mov	byte ptr [di+0Bh], 2Fh	;@1127B
	mov	byte ptr [di+0Dh], 3Ah	;@1127F
	clc	;@11283
@@5:	retf	;@11284
L11285:	mov	ah, 4Ch	;@11285
	int	21h	;@11287
L11289:	mov	ax, word ptr ds:[4E18h]	;@11289
	retf	;@1128C
L1128D:	mov	ax, 5700h	;@1128D
	int	21h	;@11290
	retf	;@11292
L11293:	mov	ah, 2Ch	;@11293
	int	21h	;@11295
	cld	;@11297
	mov	al, byte ptr ds:[4E27h]	;@11298
	retf	;@1129B
L1129C:	mov	ah, 2Ah	;@1129C
	int	21h	;@1129E
	cld	;@112A0
	sub	cx, 76Ch	;@112A1
	cmp	cx, 64h	;@112A5
	jb	@@1	;@112A8
	sub	cx, 64h	;@112AA
@@1:	mov	ch, cl	;@112AD
	mov	cl, dh	;@112AF
	mov	dh, dl	;@112B1
	mov	ax, word ptr ds:[4E1Ah]	;@112B3
	cmp	ax, 2	;@112B6
	je	@@3	;@112B9
	cmp	ax, 1	;@112BB
	je	@@2	;@112BE
	mov	dl, ch	;@112C0
	mov	ch, cl	;@112C2
	mov	cl, dh	;@112C4
	mov	dh, dl	;@112C6
	jmp	short @@3	;@112C8
@@2:	xchg	ch, dh	;@112CA
@@3:	mov	al, byte ptr ds:[4E25h]	;@112CC
	retf	;@112CF
L112D0:	mov	ah, 3Dh	;@112D0
	int	21h	;@112D2
	cld	;@112D4
	jb	@@1	;@112D5
	mov	bx, ax	;@112D7
@@1:	retf	;@112D9
L112DA:	xor	cx, cx	;@112DA
	mov	ah, 3Ch	;@112DC
	int	21h	;@112DE
	cld	;@112E0
	jb	@@1	;@112E1
	mov	bx, ax	;@112E3
@@1:	retf	;@112E5
L112E6:	mov	ah, 3Eh	;@112E6
	int	21h	;@112E8
	cld	;@112EA
	retf	;@112EB
L112EC:	push	ds	;@112EC
	mov	ds, ax	;@112ED
	mov	ah, 3Fh	;@112EF
	int	21h	;@112F1
	cld	;@112F3
	pop	ds	;@112F4
	retf	;@112F5
L112F6:	push	ds	;@112F6
	mov	ds, ax	;@112F7
	mov	ah, 40h	;@112F9
	int	21h	;@112FB
	cld	;@112FD
	pop	ds	;@112FE
	jb	@@1	;@112FF
	cmp	ax, cx	;@11301
@@1:	retf	;@11303
L11304:	mov	ah, 42h	;@11304
	int	21h	;@11306
	cld	;@11308
	retf	;@11309
L1130A:	mov	ah, 41h	;@1130A
	int	21h	;@1130C
	cld	;@1130E
	retf	;@1130F
L11310:	push	di	;@11310
	push	dx	;@11311
	push	ds	;@11312
	push	ss	;@11313
	pop	ds	;@11314
	mov	dx, di	;@11315
	mov	ah, 1Ah	;@11317
	int	21h	;@11319
	pop	ds	;@1131B
	pop	dx	;@1131C
	mov	ah, 4Eh	;@1131D
	jmp	short L1132C	;@1131F
L11321:	push	di	;@11321
	mov	dx, di	;@11322
	push	ss	;@11324
	pop	ds	;@11325
	mov	ah, 1Ah	;@11326
	int	21h	;@11328
	mov	ah, 4Fh	;@1132A
L1132C:	int	21h	;@1132C
	cld	;@1132E
	pop	si	;@1132F
	mov	di, si	;@11330
	push	ss	;@11332
	pop	ds	;@11333
	push	ds	;@11334
	pop	es	;@11335
	pushf	;@11336
	add	di, 17h	;@11337
	add	si, 1Eh	;@1133A
	mov	cx, 7	;@1133D
	rep movsw	;@11340
	popf	;@11342
	retf	;@11343
L11344:	xor	ax, ax	;@11344
	mov	word ptr ds:[4E3Ah], ax	;@11346
	mov	word ptr ds:[4E3Ch], ax	;@11349
	retf	;@1134C
L1134D:	mov	ax, 1	;@1134D
	mov	cx, ax	;@11350
	nosmart
	call	far ptr L0FB18	;@11352
	smart
	mov	es, ax	;@11357
	mov	si, bx	;@11359
	xor	cx, cx	;@1135B
@@1:	inc	cx	;@1135D
	inc	bx	;@1135E
	cmp	byte ptr [bx-1], 0	;@1135F
	jne	@@1	;@11363
	mov	word ptr es:[6], cx	;@11365
	mov	ax, cx	;@1136A
	mov	dx, es	;@1136C
	nosmart
	call	far ptr L0FB8D	;@1136E
	smart
	rep movsb	;@11373
	mov	es, dx	;@11375
	mov	word ptr es:[4], ax	;@11377
	mov	cx, word ptr ds:[4E3Ch]	;@1137B
	mov	word ptr es:[0], cx	;@1137F
	mov	word ptr es:[2], 0	;@11384
	mov	dx, es	;@1138B
	mov	word ptr ds:[4E3Ch], dx	;@1138D
	jcxz	@@2	;@11391
	push	ds	;@11393
	mov	ds, cx	;@11394
	mov	word ptr ds:[2], dx	;@11396
	pop	ds	;@1139A
	retf	;@1139B
@@2:	mov	word ptr ds:[4E3Ah], dx	;@1139C
	retf	;@113A0
L113A1:	push	bx	;@113A1
	push	cx	;@113A2
	push	ss	;@113A3
	pop	es	;@113A4
	mov	di, 4E3Eh	;@113A5
	mov	si, bx	;@113A8
	rep movsb	;@113AA
	mov	byte ptr [di], 0	;@113AC
	mov	bx, di	;@113AF
	mov	cx, word ptr ds:[4E3Ah]	;@113B1
@@1:	cmp	bx, 4E3Eh	;@113B5
	je	@@2	;@113B9
	mov	al, byte ptr [bx-1]	;@113BB
	cmp	al, 3Ah	;@113BE
	je	@@3	;@113C0
	cmp	al, 5Ch	;@113C2
	je	@@3	;@113C4
	cmp	al, 2Fh	;@113C6
	je	@@3	;@113C8
	dec	bx	;@113CA
	jmp	@@1	;@113CB
@@2:	call	@@11	;@113CD
	jmp	short @@5	;@113D0
@@3:	call	@@11	;@113D2
@@4:	push	cx	;@113D5
	mov	dx, 4E3Eh	;@113D6
	mov	di, 4E8Bh	;@113D9
	xor	cx, cx	;@113DC
	nosmart
	nosmart
	call	far ptr L11310	;@113DE
	smart
	smart
	pop	cx	;@113E3
	jae	@@9	;@113E4
@@5:	jcxz	@@10	;@113E6
	mov	es, cx	;@113E8
	mov	ax, word ptr es:[4]	;@113EA
	push	es	;@113EE
	nosmart
	call	far ptr L0FCE0	;@113EF
	smart
	mov	bx, 4E3Eh	;@113F4
@@6:	mov	al, byte ptr es:[di]	;@113F7
	and	al, al	;@113FA
	je	@@7	;@113FC
	mov	byte ptr [bx], al	;@113FE
	inc	bx	;@11400
	inc	di	;@11401
	jmp	@@6	;@11402
@@7:	mov	di, 4E7Eh	;@11404
@@8:	mov	al, byte ptr [di]	;@11407
	mov	byte ptr [bx], al	;@11409
	inc	bx	;@1140B
	inc	di	;@1140C
	and	al, al	;@1140D
	jne	@@8	;@1140F
	pop	es	;@11411
	mov	cx, word ptr es:[2]	;@11412
	jmp	@@4	;@11417
@@9:	pop	ax	;@11419
	pop	ax	;@1141A
	mov	bx, 4E3Eh	;@1141B
	retf	;@1141E
@@10:	pop	cx	;@1141F
	pop	si	;@11420
	push	ss	;@11421
	pop	es	;@11422
	mov	di, 4E3Eh	;@11423
	mov	bx, di	;@11426
	rep movsb	;@11428
	xor	al, al	;@1142A
	stosb	;@1142C
	retf	;@1142D
@@11:	mov	di, 4E7Eh	;@1142E
@@12:	mov	al, byte ptr [bx]	;@11431
	mov	byte ptr [di], al	;@11433
	inc	bx	;@11435
	inc	di	;@11436
	and	al, al	;@11437
	jne	@@12	;@11439
	ret	;@1143B
L1143C:	xor	ax, ax	;@1143C
	mov	word ptr ds:[38C2h], ax	;@1143E
	mov	word ptr ds:[4EB6h], ax	;@11441
	mov	word ptr ds:[4EBAh], ax	;@11444
	mov	word ptr ds:[4EBCh], ax	;@11447
	mov	word ptr ds:[4ED4h], ax	;@1144A
	xor	ax, ax	;@1144D
	mov	word ptr ds:[4EBEh], ax	;@1144F
	mov	word ptr ds:[4EC0h], ax	;@11452
	xor	ax, ax	;@11455
	mov	word ptr ds:[4EC2h], ax	;@11457
	mov	word ptr ds:[4EC4h], ax	;@1145A
	push	cs	;@1145D
	call	L11289	;@1145E
	sub	ax, 2	;@11461
	mov	word ptr ds:[4EC8h], ax	;@11464
	push	cs	;@11467
	call	L0F9E5	;@11468
	shr	ax, 1	;@1146B
	shr	ax, 1	;@1146D
	cmp	ax, 1200h	;@1146F
	jb	@@1	;@11472
	mov	ax, 1200h	;@11474
@@1:	mov	word ptr ds:[4EC6h], ax	;@11477
	cmp	ax, 0FF1h	;@1147A
	jb	@@2	;@1147D
	mov	ax, 0FF1h	;@1147F
@@2:	mov	cl, 4	;@11482
	shl	ax, cl	;@11484
	sub	ax, 6	;@11486
	mov	word ptr ds:[4ECAh], ax	;@11489
	retf	;@1148C
L1148D:	db	0E8h, 44h, 9	; call L11DD4	;@1148D
	jb	@@1	;@11490
	mov	word ptr ds:[4EB6h], cx	;@11492
	mov	word ptr ds:[4EBCh], cx	;@11496
	xor	ax, ax	;@1149A
	mov	cx, ax	;@1149C
	mov	dx, ax	;@1149E
	db	0E8h, 6Bh, 7	; call L11C0E	;@114A0
	db	0EBh, 5Ah	; jmp short @@2	;@114A3
@@1:	mov	di, bx	;@114A5
	push	ds	;@114A7
	pop	es	;@114A8
	xor	ax, ax	;@114A9
	mov	cx, 100h	;@114AB
	repne scasb	;@114AE
	neg	cx	;@114B0
	add	cx, 100h	;@114B2
	mov	ax, cx	;@114B6
	push	cs	;@114B8
	db	0E8h, 0D1h, 0E6h	; call L0FB8D	;@114B9
	db	8Bh, 0D1h	; mov dx, cx	;@114BC
	mov	si, bx	;@114BE
	rep movsb	;@114C0
	mov	di, ax	;@114C2
	mov	bp, 3	;@114C4
	db	0E8h, 0D1h, 8	; call L11D9B	;@114C7
	xor	bl, bl	;@114CA
	db	0E8h, 0A6h, 6	; call L11B75	;@114CC
	mov	word ptr ds:[4EB6h], dx	;@114CF
	xor	ax, ax	;@114D3
	mov	cx, ax	;@114D5
	mov	dx, ax	;@114D7
	db	0E8h, 32h, 7	; call L11C0E	;@114D9
	mov	bx, word ptr es:[26h]	;@114DC
	push	cs	;@114E1
	call	L1128D	;@114E2
	jb	@@3	;@114E5
	mov	bx, cx	;@114E7
	mov	ax, word ptr es:[0]	;@114E9
	mov	cl, byte ptr es:[2]	;@114ED
	dec	cl	;@114F2
	push	es	;@114F4
	call	far ptr L03200	;@114F5
	pop	es	;@114FA
	mov	word ptr es:[16h], ax	;@114FB
@@2:	db	0E8h, 0D6h, 6	; call L11BD8	;@114FF
	mov	ax, es	;@11502
	retf	;@11504
@@3:	mov	byte ptr ds:[38D6h], 5	;@11505
	stc	;@1150A
	mov	sp, word ptr ds:[38BAh]	;@1150B
	retf	;@1150F
L11510:	mov	bx, es	;@11510
	mov	si, cx	;@11512
	db	0E8h, 0BDh, 8	; call L11DD4	;@11514
	jb	@@1	;@11517
	mov	word ptr ds:[4EB8h], cx	;@11519
	mov	word ptr ds:[4EBCh], cx	;@1151D
	db	0E8h, 5, 5	; call L11A29	;@11521
	mov	byte ptr es:[3], 1	;@11524
	mov	word ptr es:[0Eh], 0	;@1152A
	db	0EBh, 28h	; jmp short @@2	;@11531
@@1:	mov	ax, si	;@11533
	mov	cx, ax	;@11535
	mov	si, di	;@11537
	inc	ax	;@11539
	mov	dx, ax	;@1153A
	push	cs	;@1153C
	db	0E8h, 4Dh, 0E6h	; call L0FB8D	;@1153D
	db	1Eh	; push ds	;@11540
	mov	ds, bx	;@11541
	rep movsb	;@11543
	pop	ds	;@11545
	mov	byte ptr es:[di], 0	;@11546
	mov	di, ax	;@1154A
	mov	bp, 2	;@1154C
	db	0E8h, 49h, 8	; call L11D9B	;@1154F
	mov	bl, 1	;@11552
	db	0E8h, 1Eh, 6	; call L11B75	;@11554
	mov	word ptr ds:[4EB8h], dx	;@11557
@@2:	db	0E8h, 31h, 4	; call L1198F	;@1155B
	db	0E8h, 77h, 6	; call L11BD8	;@1155E
	mov	al, byte ptr ds:[51A6h]	;@11561
	mov	byte ptr es:[16h], al	;@11564
	mov	al, byte ptr ds:[51A8h]	;@11568
	mov	byte ptr es:[17h], al	;@1156B
	retf	;@1156F
L11570:	mov	cx, 0FFFFh	;@11570
	mov	di, bx	;@11573
	mov	al, 0Dh	;@11575
	push	ds	;@11577
	pop	es	;@11578
	repne scasb	;@11579
	neg	cx	;@1157B
	mov	si, bx	;@1157D
@@1:	mov	ax, word ptr ds:[4ECCh]	;@1157F
	and	ax, ax	;@11582
	je	@@2	;@11584
	mov	es, ax	;@11586
	mov	di, word ptr es:[4]	;@11588
	mov	ax, word ptr es:[2]	;@1158D
	sub	ax, di	;@11591
	cmp	ax, cx	;@11593
	jae	@@3	;@11595
	sub	cx, ax	;@11597
	add	word ptr es:[4], ax	;@11599
	push	cx	;@1159E
	mov	cx, ax	;@1159F
	shr	cx, 1	;@115A1
	rep movsw	;@115A3
	rcl	cx, 1	;@115A5
	rep movsb	;@115A7
	pop	cx	;@115A9
	push	cx	;@115AA
	push	si	;@115AB
	db	0E8h, 0F1h, 3	; call L119A0	;@115AC
	pop	si	;@115AF
	pop	cx	;@115B0
@@2:	push	cx	;@115B1
	push	si	;@115B2
	mov	ax, 800h	;@115B3
	db	0E8h, 38h, 4	; call L119F1	;@115B6
	pop	si	;@115B9
	pop	cx	;@115BA
	jmp	@@1	;@115BB
@@3:	add	word ptr es:[4], cx	;@115BD
	dec	cx	;@115C2
	shr	cx, 1	;@115C3
	rep movsw	;@115C5
	rcl	cx, 1	;@115C7
	rep movsb	;@115C9
	mov	al, 0Ah	;@115CB
	stosb	;@115CD
	retf	;@115CE
L115CF:	mov	ax, word ptr ds:[4EB8h]	;@115CF
	mov	word ptr ds:[4EB6h], ax	;@115D2
	mov	es, ax	;@115D5
	push	es	;@115D7
	db	0E8h, 0DDh, 3	; call L119B8	;@115D8
	pop	es	;@115DB
	db	0E8h, 73h, 4	; call L11A52	;@115DC
	retf	;@115DF
L115E0:	mov	es, word ptr ds:[4EB6h]	;@115E0
	test	byte ptr es:[3], 1	;@115E4
	je	@@1	;@115EA
	mov	al, byte ptr es:[16h]	;@115EC
	mov	byte ptr ds:[51A6h], al	;@115F0
	mov	al, byte ptr es:[17h]	;@115F3
	mov	byte ptr ds:[51A8h], al	;@115F7
	db	0E8h, 2Ch, 4	; call L11A29	;@115FA
	mov	cx, word ptr es:[0Ch]	;@115FD
	mov	word ptr ds:[4EB6h], cx	;@11602
	retf	;@11606
@@1:	mov	cx, 28h	;@11607
	db	0E9h, 92h, 8	; jmp L11E9F	;@1160A
L1160D:	mov	cx, word ptr ds:[4EBEh]	;@1160D
	jcxz	@@3	;@11611
	mov	es, cx	;@11613
	cmp	cx, word ptr ds:[4EB6h]	;@11615
	je	@@2	;@11619
@@1:	db	0E8h, 0B3h, 4	; call L11AD1	;@1161B
	clc	;@1161E
	retf	;@1161F
@@2:	push	es	;@11620
	mov	es, word ptr es:[10h]	;@11621
	cmp	word ptr es:[2], 20h	;@11626
	pop	es	;@1162C
	ja	@@1	;@1162D
@@3:	stc	;@1162F
	retf	;@11630
L11631:	mov	dx, word ptr ds:[4ED4h]	;@11631
	and	dx, dx	;@11635
	db	74h, 0Fh	; je @@1	;@11637
	mov	word ptr ds:[4ED4h], 0	;@11639
	mov	ax, word ptr ds:[4ED2h]	;@1163F
	push	cs	;@11642
	db	0E8h, 60h, 0E4h	; call L0FAA6	;@11643
	db	0F8h	; clc	;@11646
	retf	;@11647
@@1:	stc	;@11648
	retf	;@11649
L1164A:	cmp	word ptr ds:[4EC2h], 0	;@1164A
	je	@@1	;@1164F
	db	0E8h, 0DDh, 4	; call L11B31	;@11651
	jmp	L1164A	;@11654
@@1:	mov	cx, word ptr ds:[4EBAh]	;@11656
@@2:	jcxz	@@3	;@1165A
	mov	es, cx	;@1165C
	db	0E8h, 0C8h, 3	; call L11A29	;@1165E
	mov	cx, word ptr es:[0Ah]	;@11661
	jmp	@@2	;@11666
@@3:	retf	;@11668
L11669:	mov	es, word ptr ds:[4EB6h]	;@11669
	mov	ax, word ptr es:[0Eh]	;@1166D
	db	0E8h, 91h, 1	; call L11805	;@11671
	jb	L11669	;@11674
	retf	;@11676
L11677:	mov	ax, word ptr ds:[4EB6h]	;@11677
	mov	es, ax	;@1167A
	mov	word ptr ds:[515Eh], ax	;@1167C
	mov	ax, word ptr es:[0Eh]	;@1167F
	mov	word ptr ds:[5152h], ax	;@11683
	db	0E8h, 7Ch, 1	; call L11805	;@11686
	jb	L11677	;@11689
	retf	;@1168B
L1168C:	mov	es, word ptr ds:[4EB6h]	;@1168C
	db	0E8h, 0EBh, 2	; call L1197E	;@11690
	retf	;@11693
L11694:	mov	word ptr es:[16h], ax	;@11694
	retf	;@11698
L11699:	mov	es, dx	;@11699
	mov	cx, dx	;@1169B
	jcxz	@@1	;@1169D
	test	byte ptr es:[3], 1	;@1169F
	jne	@@2	;@116A5
	mov	cx, word ptr es:[16h]	;@116A7
@@1:	retf	;@116AC
@@2:	mov	ax, word ptr es:[18h]	;@116AD
	dec	ax	;@116B1
	mov	dx, word ptr es:[0Ch]	;@116B2
	jmp	L11699	;@116B7
L116B9:	mov	cx, dx	;@116B9
	db	0E3h, 18h	; jcxz @@1	;@116BB
	mov	es, cx	;@116BD
	mov	ax, word ptr es:[0]	;@116BF
	mov	cl, byte ptr es:[2]	;@116C3
	xor	ch, ch	;@116C8
	mov	dl, byte ptr es:[3]	;@116CA
	and	dl, 1	;@116CF
	db	0E9h, 0Bh, 0E6h	; jmp L0FCE0	;@116D2
@@1:	db	16h	; push ss	;@116D5
	pop	es	;@116D6
	mov	di, 0A46h	;@116D7
	xor	dl, dl	;@116DA
	retf	;@116DC
L116DD:	mov	es, dx	;@116DD
	cmp	ax, word ptr es:[0Eh]	;@116DF
	jb	@@4	;@116E4
	sub	ax, word ptr es:[0Eh]	;@116E6
	push	ax	;@116EB
	mov	ax, word ptr es:[0Eh]	;@116EC
	mov	dx, word ptr es:[1Ah]	;@116F0
	mov	cx, word ptr es:[1Ch]	;@116F5
	add	dx, word ptr es:[12h]	;@116FA
	adc	cx, 0	;@116FF
@@1:	db	0E8h, 9, 5	; call L11C0E	;@11702
	pop	cx	;@11705
	mov	ax, es	;@11706
	mov	word ptr ds:[4EB6h], ax	;@11708
	mov	word ptr ds:[4EBCh], ax	;@1170B
	mov	si, word ptr es:[12h]	;@1170E
	mov	ds, word ptr es:[14h]	;@11713
	add	si, 6	;@11718
	mov	dx, cx	;@1171B
	jcxz	@@3	;@1171D
	push	dx	;@1171F
@@2:	push	cx	;@11720
	call	L11938	;@11721
	pop	cx	;@11724
	loop	@@2	;@11725
	pop	dx	;@11727
@@3:	sub	si, 6	;@11728
	push	ss	;@1172B
	pop	ds	;@1172C
	mov	es, word ptr ds:[4EB6h]	;@1172D
	add	word ptr es:[0Eh], dx	;@11731
	mov	word ptr es:[12h], si	;@11736
	xor	di, di	;@1173B
	add	si, word ptr es:[1Ah]	;@1173D
	adc	di, word ptr es:[1Ch]	;@11742
	retf	;@11747
@@4:	push	ax	;@11748
	xor	ax, ax	;@11749
	mov	cx, ax	;@1174B
	mov	dx, ax	;@1174D
	jmp	@@1	;@1174F
L11751:	mov	es, dx	;@11751
	mov	dx, cx	;@11753
	mov	cx, di	;@11755
	db	0E8h, 0B4h, 4	; call L11C0E	;@11757
	mov	ax, es	;@1175A
	mov	word ptr ds:[4EB6h], ax	;@1175C
	mov	word ptr ds:[4EBCh], ax	;@1175F
	retf	;@11762
L11763:	mov	word ptr ds:[4ED6h], si	;@11763
	mov	word ptr ds:[4ED8h], ax	;@11767
	mov	cx, word ptr ds:[4EBAh]	;@1176A
@@1:	jcxz	@@3	;@1176E
	mov	es, cx	;@11770
	test	byte ptr es:[3], 1	;@11772
	jne	@@2	;@11778
	push	es	;@1177A
	call	dword ptr ds:[4ED6h]	;@1177B
	pop	es	;@1177F
@@2:	mov	cx, word ptr es:[0Ah]	;@11780
	jmp	@@1	;@11785
@@3:	retf	;@11787
L11788:	cmp	dx, di	;@11788
	jne	@@2	;@1178A
	cmp	ax, cx	;@1178C
	retf	;@1178E
@@1:	cmp	dx, di	;@1178F
	retf	;@11791
@@2:	or	dx, dx	;@11792
	je	@@1	;@11794
	or	di, di	;@11796
	je	@@1	;@11798
	push	es	;@1179A
	push	si	;@1179B
	push	dx	;@1179C
	push	bx	;@1179D
	push	ax	;@1179E
	mov	si, dx	;@1179F
	mov	dx, ax	;@117A1
	mov	es, si	;@117A3
	call	L1197E	;@117A5
	push	ax	;@117A8
	mov	es, di	;@117A9
	call	L1197E	;@117AB
	pop	bx	;@117AE
	push	ax	;@117AF
	push	bx	;@117B0
@@3:	cmp	ax, bx	;@117B1
	je	@@5	;@117B3
	ja	@@4	;@117B5
	mov	es, si	;@117B7
	mov	si, word ptr es:[0Ch]	;@117B9
	mov	dx, word ptr es:[4]	;@117BE
	dec	dx	;@117C3
	dec	bx	;@117C4
	jmp	@@3	;@117C5
@@4:	mov	es, di	;@117C7
	mov	di, word ptr es:[0Ch]	;@117C9
	mov	cx, word ptr es:[4]	;@117CE
	dec	cx	;@117D3
	dec	ax	;@117D4
	jmp	@@3	;@117D5
@@5:	cmp	si, di	;@117D7
	je	@@6	;@117D9
	mov	es, si	;@117DB
	mov	si, word ptr es:[0Ch]	;@117DD
	mov	dx, word ptr es:[4]	;@117E2
	dec	dx	;@117E7
	mov	es, di	;@117E8
	mov	di, word ptr es:[0Ch]	;@117EA
	mov	cx, word ptr es:[4]	;@117EF
	dec	cx	;@117F4
	jmp	@@5	;@117F5
@@6:	pop	bx	;@117F7
	pop	ax	;@117F8
	cmp	dx, cx	;@117F9
	jne	@@7	;@117FB
	cmp	bx, ax	;@117FD
@@7:	pop	ax	;@117FF
	pop	bx	;@11800
	pop	dx	;@11801
	pop	si	;@11802
	pop	es	;@11803
	retf	;@11804
L11805:	mov	ax, word ptr es:[14h]	;@11805
	and	ax, ax	;@11809
	je	@@5	;@1180B
	mov	si, word ptr es:[12h]	;@1180D
	mov	ds, ax	;@11812
	push	ss	;@11814
	pop	es	;@11815
	mov	dx, di	;@11816
	add	si, 6	;@11818
@@1:	mov	bx, word ptr ds:[4]	;@1181B
	sub	bx, si	;@1181F
	cmp	bx, cx	;@11821
	jb	@@8	;@11823
	mov	ah, 0Ah	;@11825
@@2:	lodsb	;@11827
	stosb	;@11828
	cmp	al, ah	;@11829
	loopne	@@2	;@1182B
	jne	@@11	;@1182D
@@3:	mov	byte ptr es:[di-1], 0Dh	;@1182F
	cmp	word ptr es:[di-3], 0D5Ch	;@11834
	je	@@7	;@1183A
	cmp	byte ptr es:[di-2], 5Ch	;@1183C
	je	@@6	;@11841
@@4:	sub	si, 6	;@11843
	mov	ax, ds	;@11846
	push	ss	;@11848
	pop	ds	;@11849
	mov	es, word ptr ds:[4EB6h]	;@1184A
	mov	word ptr es:[14h], ax	;@1184E
	mov	word ptr es:[12h], si	;@11852
	inc	word ptr es:[0Eh]	;@11857
	clc	;@1185C
	ret	;@1185D
@@5:	push	cx	;@1185E
	push	di	;@1185F
	db	0E8h, 0F6h, 3	; call L11C59	;@11860
	pop	di	;@11863
	pop	cx	;@11864
	jae	L11805	;@11865
	jmp	short @@14	;@11867
@@6:	inc	di	;@11869
	dec	cx	;@1186A
@@7:	test	word ptr ss:[5160h], 4000h	;@1186B
	jne	@@4	;@11872
	sub	di, 3	;@11874
	cmp	di, dx	;@11877
	jb	@@4	;@11879
	jmp	short @@12	;@1187B
@@8:	and	bx, bx	;@1187D
	je	@@10	;@1187F
	xchg	cx, bx	;@11881
	mov	ah, 0Ah	;@11883
@@9:	lodsb	;@11885
	stosb	;@11886
	dec	bx	;@11887
	cmp	al, ah	;@11888
	loopne	@@9	;@1188A
	mov	cx, bx	;@1188C
	je	@@3	;@1188E
@@10:	push	cx	;@11890
	push	dx	;@11891
	call	L1194F	;@11892
	pop	dx	;@11895
	pop	cx	;@11896
	jb	@@13	;@11897
	jcxz	@@11	;@11899
	jmp	@@1	;@1189B
@@11:	push	cx	;@1189E
	push	dx	;@1189F
	call	@@19	;@118A0
	pop	dx	;@118A3
	pop	cx	;@118A4
	jb	@@13	;@118A5
	jmp	@@3	;@118A7
@@12:	call	@@4	;@118A9
	add	cx, 3	;@118AC
	mov	ax, word ptr es:[0Eh]	;@118AF
	jmp	L11805	;@118B3
@@13:	push	ss	;@118B6
	pop	ds	;@118B7
@@14:	push	cx	;@118B8
	push	di	;@118B9
	mov	es, word ptr ds:[4EB6h]	;@118BA
	test	byte ptr es:[3], 1	;@118BE
	je	@@15	;@118C4
	db	0E8h, 60h, 1	; call L11A29	;@118C6
	jmp	short @@17	;@118C9
@@15:	db	0E8h, 36h, 2	; call L11B04	;@118CB
	mov	cx, word ptr ds:[4EBEh]	;@118CE
	mov	dx, es	;@118D2
	mov	word ptr ds:[4EBEh], dx	;@118D4
	mov	word ptr es:[20h], cx	;@118D8
	mov	word ptr es:[1Eh], 0	;@118DD
	jcxz	@@16	;@118E4
	push	ds	;@118E6
	mov	ds, cx	;@118E7
	mov	word ptr ds:[1Eh], dx	;@118E9
	pop	ds	;@118ED
	jmp	short @@17	;@118EE
@@16:	mov	word ptr ds:[4EC0h], dx	;@118F0
@@17:	mov	bx, word ptr es:[0Ch]	;@118F4
	or	bx, bx	;@118F9
	je	@@18	;@118FB
	mov	ax, word ptr es:[4]	;@118FD
	mov	dx, word ptr es:[6]	;@11901
	mov	cx, word ptr es:[8]	;@11906
	mov	word ptr ds:[4EB6h], bx	;@1190B
	mov	es, bx	;@1190F
	db	0E8h, 0FAh, 2	; call L11C0E	;@11911
	pop	di	;@11914
	pop	cx	;@11915
	stc	;@11916
	ret	;@11917
@@18:	call	far ptr L031FC	;@11918
	mov	cx, 4026h	;@1191D
	db	0E9h, 7Ch, 5	; jmp L11E9F	;@11920
@@19:	mov	al, 0Ah	;@11923
	dec	di	;@11925
	stosb	;@11926
	mov	cx, 25h	;@11927
	push	ds	;@1192A
	push	si	;@1192B
	push	es	;@1192C
	push	di	;@1192D
	push	ss	;@1192E
	pop	ds	;@1192F
	push	cs	;@11930
	db	0E8h, 6Bh, 5	; call L11E9F	;@11931
	pop	di	;@11934
	pop	es	;@11935
	pop	si	;@11936
	pop	ds	;@11937
L11938:	mov	cx, word ptr ds:[4]	;@11938
	sub	cx, si	;@1193C
	je	@@2	;@1193E
	mov	ah, 0Ah	;@11940
@@1:	lodsb	;@11942
	cmp	al, ah	;@11943
	loopne	@@1	;@11945
	je	@@3	;@11947
@@2:	call	L1194F	;@11949
	jae	L11938	;@1194C
@@3:	ret	;@1194E
L1194F:	mov	cx, word ptr ds:[0]	;@1194F
	jcxz	@@1	;@11953
	mov	ds, cx	;@11955
	mov	si, 6	;@11957
	clc	;@1195A
	ret	;@1195B
@@1:	sub	si, 6	;@1195C
	push	ss	;@1195F
	pop	ds	;@11960
	push	es	;@11961
	push	di	;@11962
	mov	es, word ptr ss:[4EB6h]	;@11963
	mov	word ptr es:[12h], si	;@11968
	db	0E8h, 0E9h, 2	; call L11C59	;@1196D
	jb	@@2	;@11970
	mov	ds, word ptr es:[10h]	;@11972
	mov	si, 6	;@11977
	clc	;@1197A
@@2:	pop	di	;@1197B
	pop	es	;@1197C
	ret	;@1197D
L1197E:	xor	ax, ax	;@1197E
@@1:	mov	bx, word ptr es:[0Ch]	;@11980
	and	bx, bx	;@11985
	je	@@2	;@11987
	mov	es, bx	;@11989
	inc	ax	;@1198B
	jmp	@@1	;@1198C
@@2:	ret	;@1198E
L1198F:	mov	word ptr ds:[4ECCh], 0	;@1198F
	mov	word ptr ds:[4ECEh], 10h	;@11995
	mov	word ptr ds:[4ED0h], es	;@1199B
	ret	;@1199F
L119A0:	les	di, dword ptr ds:[4ECEh]	;@119A0
	mov	ax, word ptr ds:[4ECCh]	;@119A4
	stosw	;@119A7
	mov	word ptr ds:[4ED0h], ax	;@119A8
	mov	word ptr ds:[4ECEh], 0	;@119AB
	mov	word ptr ds:[4ECCh], 0	;@119B1
	ret	;@119B7
L119B8:	mov	ax, word ptr ds:[4ECCh]	;@119B8
	and	ax, ax	;@119BB
	db	74h, 2Ah	; je @@2	;@119BD
	mov	es, ax	;@119BF
	mov	ax, word ptr es:[4]	;@119C1
	add	ax, 0Fh	;@119C5
	mov	cl, 4	;@119C8
	shr	ax, cl	;@119CA
	mov	dx, word ptr es:[2]	;@119CC
	shr	dx, cl	;@119D1
	sub	dx, ax	;@119D3
	db	74h, 0Fh	; je @@1	;@119D5
	add	ax, word ptr ds:[4ECCh]	;@119D7
	push	cs	;@119DB
	db	0E8h, 0C7h, 0E0h	; call L0FAA6	;@119DC
	db	0D3h, 0E2h	; shl dx, cl	;@119DF
	sub	word ptr es:[2], dx	;@119E1
@@1:	call	L119A0	;@119E6
@@2:	les	di, dword ptr ds:[4ECEh]	;@119E9
	xor	ax, ax	;@119ED
	stosw	;@119EF
	ret	;@119F0
L119F1:	add	ax, 15h	;@119F1
	mov	cl, 4	;@119F4
	shr	ax, cl	;@119F6
	push	ax	;@119F8
	push	cs	;@119F9
	call	L0FAFB	;@119FA
	pop	cx	;@119FD
	cmp	ax, cx	;@119FE
	jb	@@1	;@11A00
	mov	ax, cx	;@11A02
@@1:	cmp	ax, 2	;@11A04
	jae	@@2	;@11A07
	mov	ax, 2	;@11A09
@@2:	mov	cx, ax	;@11A0C
	push	cs	;@11A0E
	db	0E8h, 6, 0E1h	; call L0FB18	;@11A0F
	db	0A3h, 0CCh, 4Eh	; mov word ptr ds:[4ECCh], ax	;@11A12
	mov	es, ax	;@11A15
	mov	ax, cx	;@11A17
	mov	cl, 4	;@11A19
	shl	ax, cl	;@11A1B
	mov	word ptr es:[2], ax	;@11A1D
	mov	word ptr es:[4], 6	;@11A21
	ret	;@11A28
L11A29:	xor	ax, ax	;@11A29
	mov	word ptr es:[14h], ax	;@11A2B
	xchg	word ptr es:[10h], ax	;@11A2F
	push	es	;@11A34
@@1:	and	ax, ax	;@11A35
	db	74h, 17h	; je @@2	;@11A37
	mov	es, ax	;@11A39
	push	word ptr es:[0]	;@11A3B
	mov	dx, word ptr es:[2]	;@11A40
	mov	cl, 4	;@11A45
	shr	dx, cl	;@11A47
	push	cs	;@11A49
	db	0E8h, 59h, 0E0h	; call L0FAA6	;@11A4A
	db	58h	; pop ax	;@11A4D
	jmp	@@1	;@11A4E
@@2:	pop	es	;@11A50
	ret	;@11A51
L11A52:	mov	ax, word ptr es:[10h]	;@11A52
	mov	word ptr es:[14h], ax	;@11A56
	mov	word ptr es:[12h], 0	;@11A5A
	ret	;@11A61
L11A62:	test	byte ptr es:[3], 80h	;@11A62
	db	75h, 35h	; jne @@2	;@11A68
	cmp	word ptr ds:[4EC8h], 0	;@11A6A
	jne	@@1	;@11A6F
	push	es	;@11A71
	db	0E8h, 0BCh, 0	; call L11B31	;@11A72
	pop	es	;@11A75
@@1:	push	es	;@11A76
	mov	ax, word ptr es:[0]	;@11A77
	push	cs	;@11A7B
	db	0E8h, 61h, 0E2h	; call L0FCE0	;@11A7C
	db	1Eh	; push ds	;@11A7F
	push	es	;@11A80
	pop	ds	;@11A81
	mov	dx, di	;@11A82
	mov	al, 0	;@11A84
	push	cs	;@11A86
	call	L112D0	;@11A87
	pop	ds	;@11A8A
	pop	es	;@11A8B
	jb	@@6	;@11A8C
	mov	word ptr es:[26h], bx	;@11A8E
	or	byte ptr es:[3], 80h	;@11A93
	dec	word ptr ds:[4EC8h]	;@11A99
	jmp	short @@3	;@11A9D
@@2:	call	L11B48	;@11A9F
@@3:	mov	cx, word ptr ds:[4EC4h]	;@11AA2
	mov	dx, es	;@11AA6
	mov	word ptr ds:[4EC4h], dx	;@11AA8
	mov	word ptr es:[22h], cx	;@11AAC
	mov	word ptr es:[24h], 0	;@11AB1
	jcxz	@@4	;@11AB8
	push	ds	;@11ABA
	mov	ds, cx	;@11ABB
	mov	word ptr ds:[24h], dx	;@11ABD
	pop	ds	;@11AC1
	jmp	short @@5	;@11AC2
@@4:	mov	word ptr ds:[4EC2h], dx	;@11AC4
@@5:	ret	;@11AC8
@@6:	mov	di, es	;@11AC9
	mov	cx, 6024h	;@11ACB
	db	0E9h, 0CEh, 3	; jmp L11E9F	;@11ACE
L11AD1:	mov	ax, word ptr es:[12h]	;@11AD1
	add	word ptr es:[1Ah], ax	;@11AD5
	adc	word ptr es:[1Ch], 0	;@11ADA
	mov	word ptr es:[12h], 0	;@11AE0
	and	byte ptr es:[3], 0BFh	;@11AE7
	push	es	;@11AED
	mov	es, word ptr es:[10h]	;@11AEE
	mov	dx, word ptr es:[2]	;@11AF3
	pop	es	;@11AF8
	mov	cl, 4	;@11AF9
	shr	dx, cl	;@11AFB
	add	word ptr ds:[4EC6h], dx	;@11AFD
	call	L11A29	;@11B01
L11B04:	mov	dx, word ptr es:[1Eh]	;@11B04
	mov	cx, word ptr es:[20h]	;@11B09
	jcxz	@@1	;@11B0E
	push	ds	;@11B10
	mov	ds, cx	;@11B11
	mov	word ptr ds:[1Eh], dx	;@11B13
	pop	ds	;@11B17
	jmp	short @@2	;@11B18
@@1:	mov	word ptr ds:[4EC0h], dx	;@11B1A
@@2:	and	dx, dx	;@11B1E
	je	@@3	;@11B20
	push	ds	;@11B22
	mov	ds, dx	;@11B23
	mov	word ptr ds:[20h], cx	;@11B25
	pop	ds	;@11B29
	jmp	short @@4	;@11B2A
@@3:	mov	word ptr ds:[4EBEh], cx	;@11B2C
@@4:	ret	;@11B30
L11B31:	mov	es, word ptr ds:[4EC2h]	;@11B31
	inc	word ptr ds:[4EC8h]	;@11B35
	and	byte ptr es:[3], 7Fh	;@11B39
	mov	bx, word ptr es:[26h]	;@11B3F
	push	cs	;@11B44
	call	L112E6	;@11B45
L11B48:	mov	dx, word ptr es:[22h]	;@11B48
	mov	cx, word ptr es:[24h]	;@11B4D
	jcxz	@@1	;@11B52
	push	ds	;@11B54
	mov	ds, cx	;@11B55
	mov	word ptr ds:[22h], dx	;@11B57
	pop	ds	;@11B5B
	jmp	short @@2	;@11B5C
@@1:	mov	word ptr ds:[4EC4h], dx	;@11B5E
@@2:	and	dx, dx	;@11B62
	je	@@3	;@11B64
	push	ds	;@11B66
	mov	ds, dx	;@11B67
	mov	word ptr ds:[24h], cx	;@11B69
	pop	ds	;@11B6D
	jmp	short @@4	;@11B6E
@@3:	mov	word ptr ds:[4EC2h], cx	;@11B70
@@4:	ret	;@11B74
L11B75:	mov	ds, ax	;@11B75
	mov	byte ptr ds:[2], dl	;@11B77
	mov	word ptr ds:[0], di	;@11B7B
	mov	byte ptr ds:[3], bl	;@11B7F
	mov	dx, ax	;@11B83
	xor	ax, ax	;@11B85
	mov	word ptr ds:[0Eh], ax	;@11B87
	mov	word ptr ds:[10h], ax	;@11B8A
	mov	word ptr ds:[4], ax	;@11B8D
	mov	cx, word ptr ss:[4EB6h]	;@11B90
	mov	word ptr ds:[0Ch], cx	;@11B95
	jcxz	@@1	;@11B99
	mov	es, cx	;@11B9B
	mov	ax, word ptr es:[0Eh]	;@11B9D
	mov	word ptr ds:[4], ax	;@11BA1
	mov	ax, word ptr ss:[5152h]	;@11BA4
	inc	ax	;@11BA8
	mov	word ptr ds:[18h], ax	;@11BA9
@@1:	mov	ax, ds	;@11BAC
	mov	es, ax	;@11BAE
	push	ss	;@11BB0
	pop	ds	;@11BB1
	mov	cx, word ptr ds:[4EBCh]	;@11BB2
	jcxz	@@2	;@11BB6
	push	ds	;@11BB8
	mov	ds, cx	;@11BB9
	mov	cx, word ptr ds:[0Ah]	;@11BBB
	mov	word ptr ds:[0Ah], dx	;@11BBF
	pop	ds	;@11BC3
	jmp	short @@3	;@11BC4
@@2:	mov	cx, word ptr ds:[4EBAh]	;@11BC6
	mov	word ptr ds:[4EBAh], dx	;@11BCA
@@3:	mov	word ptr es:[0Ah], cx	;@11BCE
	mov	word ptr ds:[4EBCh], dx	;@11BD3
	ret	;@11BD7
L11BD8:	mov	cx, word ptr es:[0Ch]	;@11BD8
	xor	ax, ax	;@11BDD
	jcxz	@@3	;@11BDF
	push	es	;@11BE1
	mov	es, cx	;@11BE2
	mov	ax, word ptr es:[12h]	;@11BE4
	test	byte ptr es:[3], 1	;@11BE8
	je	@@1	;@11BEE
	mov	cx, word ptr es:[14h]	;@11BF0
	jmp	short @@2	;@11BF5
@@1:	xor	cx, cx	;@11BF7
	add	ax, word ptr es:[1Ah]	;@11BF9
	adc	cx, word ptr es:[1Ch]	;@11BFE
@@2:	pop	es	;@11C03
@@3:	mov	word ptr es:[6], ax	;@11C04
	mov	word ptr es:[8], cx	;@11C08
	ret	;@11C0D
L11C0E:	mov	word ptr es:[0Eh], ax	;@11C0E
	test	byte ptr es:[3], 1	;@11C12
	jne	@@1	;@11C18
	cmp	word ptr es:[10h], 0	;@11C1A
	je	L11C89	;@11C20
	mov	si, dx	;@11C22
	mov	di, cx	;@11C24
	sub	si, word ptr es:[1Ah]	;@11C26
	sbb	di, word ptr es:[1Ch]	;@11C2B
	jb	L11C82	;@11C30
	and	di, di	;@11C32
	jne	L11C82	;@11C34
	push	es	;@11C36
	mov	es, word ptr es:[10h]	;@11C37
	mov	ax, word ptr es:[4]	;@11C3C
	sub	ax, 6	;@11C40
	cmp	si, ax	;@11C43
	pop	es	;@11C45
	jae	L11C82	;@11C46
	mov	word ptr es:[12h], si	;@11C48
	ret	;@11C4D
@@1:	mov	word ptr es:[14h], cx	;@11C4E
	mov	word ptr es:[12h], dx	;@11C53
	ret	;@11C58
L11C59:	test	byte ptr es:[3], 41h	;@11C59
	jne	@@1	;@11C5F
	mov	dx, word ptr es:[1Ah]	;@11C61
	mov	cx, word ptr es:[1Ch]	;@11C66
	add	dx, word ptr es:[12h]	;@11C6B
	adc	cx, 0	;@11C70
	call	@@2	;@11C73
	clc	;@11C76
	ret	;@11C77
@@1:	stc	;@11C78
	ret	;@11C79
@@2:	cmp	word ptr es:[10h], 0	;@11C7A
	je	L11C89	;@11C80
L11C82:	push	cx	;@11C82
	push	dx	;@11C83
	call	L11AD1	;@11C84
	pop	dx	;@11C87
	pop	cx	;@11C88
L11C89:	mov	word ptr es:[1Ah], dx	;@11C89
	mov	word ptr es:[1Ch], cx	;@11C8E
	call	L1198F	;@11C93
	call	L11A62	;@11C96
	xor	al, al	;@11C99
	mov	bx, word ptr es:[26h]	;@11C9B
	mov	dx, word ptr es:[1Ah]	;@11CA0
	mov	cx, word ptr es:[1Ch]	;@11CA5
	push	cs	;@11CAA
	call	L11304	;@11CAB
	jb	@@2	;@11CAE
	mov	bx, word ptr es:[26h]	;@11CB0
	mov	si, word ptr es:[1Ah]	;@11CB5
	push	es	;@11CBA
	mov	ax, word ptr ds:[4ECAh]	;@11CBB
	push	bx	;@11CBE
	push	si	;@11CBF
	call	L119F1	;@11CC0
	pop	si	;@11CC3
	pop	bx	;@11CC4
	mov	es, word ptr ds:[4ECCh]	;@11CC5
	mov	cx, word ptr es:[2]	;@11CC9
	sub	cx, 6	;@11CCE
	mov	ax, es	;@11CD1
	mov	dx, 6	;@11CD3
	cmp	cx, 1000h	;@11CD6
	jb	@@1	;@11CDA
	add	cx, si	;@11CDC
	and	cx, 0F000h	;@11CDE
	sub	cx, si	;@11CE2
@@1:	push	cs	;@11CE4
	call	L112EC	;@11CE5
	jae	@@3	;@11CE8
@@2:	mov	byte ptr ds:[38D6h], 5	;@11CEA
	mov	sp, word ptr ds:[38BAh]	;@11CEF
	retf	;@11CF3
@@3:	mov	si, ax	;@11CF4
	add	si, 6	;@11CF6
	mov	word ptr es:[4], si	;@11CF9
	or	ax, ax	;@11CFE
	je	@@4	;@11D00
	cmp	ax, cx	;@11D02
	je	@@7	;@11D04
@@4:	mov	byte ptr es:[si], 0Ah	;@11D06
	inc	word ptr es:[4]	;@11D0A
	pop	es	;@11D0F
	or	byte ptr es:[3], 40h	;@11D10
	call	L11B48	;@11D16
	mov	cx, word ptr ds:[4EC2h]	;@11D19
	mov	dx, es	;@11D1D
	mov	word ptr ds:[4EC2h], dx	;@11D1F
	mov	word ptr es:[24h], cx	;@11D23
	mov	word ptr es:[22h], 0	;@11D28
	jcxz	@@5	;@11D2F
	push	ds	;@11D31
	mov	ds, cx	;@11D32
	mov	word ptr ds:[22h], dx	;@11D34
	pop	ds	;@11D38
	jmp	short @@6	;@11D39
@@5:	mov	word ptr ds:[4EC4h], dx	;@11D3B
@@6:	jmp	short @@8	;@11D3F
@@7:	pop	es	;@11D41
	and	byte ptr es:[3], 0BFh	;@11D42
@@8:	push	es	;@11D48
	call	L119B8	;@11D49
	pop	es	;@11D4C
	call	L11A52	;@11D4D
	push	es	;@11D50
	mov	es, word ptr es:[10h]	;@11D51
	mov	ax, word ptr es:[2]	;@11D56
	mov	cl, 4	;@11D5A
	shr	ax, cl	;@11D5C
@@9:	cmp	word ptr ds:[4EC6h], ax	;@11D5E
	jb	@@12	;@11D62
	sub	word ptr ds:[4EC6h], ax	;@11D64
	pop	es	;@11D68
	mov	cx, word ptr ds:[4EC0h]	;@11D69
	mov	dx, es	;@11D6D
	mov	word ptr ds:[4EC0h], dx	;@11D6F
	mov	word ptr es:[1Eh], cx	;@11D73
	mov	word ptr es:[20h], 0	;@11D78
	jcxz	@@10	;@11D7F
	push	ds	;@11D81
	mov	ds, cx	;@11D82
	mov	word ptr ds:[20h], dx	;@11D84
	pop	ds	;@11D88
	jmp	short @@11	;@11D89
@@10:	mov	word ptr ds:[4EBEh], dx	;@11D8B
@@11:	ret	;@11D8F
@@12:	push	ax	;@11D90
	mov	es, word ptr ds:[4EBEh]	;@11D91
	call	L11AD1	;@11D95
	pop	ax	;@11D98
	jmp	@@9	;@11D99
L11D9B:	cmp	word ptr ds:[4ED4h], bp	;@11D9B
	db	73h, 27h	; jae @@2	;@11D9F
	push	dx	;@11DA1
	mov	dx, word ptr ds:[4ED4h]	;@11DA2
	and	dx, dx	;@11DA6
	db	74h, 0Dh	; je @@1	;@11DA8
	mov	word ptr ds:[4ED4h], 0	;@11DAA
	mov	ax, word ptr ds:[4ED2h]	;@11DB0
	push	cs	;@11DB3
	db	0E8h, 0EFh, 0DCh	; call L0FAA6	;@11DB4
@@1:	db	5Ah	; pop dx	;@11DB7
	mov	ax, bp	;@11DB8
	mov	cx, 200h	;@11DBA
	push	cs	;@11DBD
	db	0E8h, 57h, 0DDh	; call L0FB18	;@11DBE
	db	89h, 0Eh, 0D4h, 4Eh	; mov word ptr ds:[4ED4h], cx	;@11DC1
	mov	word ptr ds:[4ED2h], ax	;@11DC5
@@2:	mov	ax, word ptr ds:[4ED2h]	;@11DC8
	add	word ptr ds:[4ED2h], bp	;@11DCB
	sub	word ptr ds:[4ED4h], bp	;@11DCF
	ret	;@11DD3
L11DD4:	test	byte ptr ds:[38D7h], 0Fh	;@11DD4
	je	@@2	;@11DD9
	mov	cx, word ptr ds:[4EB6h]	;@11DDB
	jcxz	@@2	;@11DDF
	mov	es, cx	;@11DE1
	mov	dx, cx	;@11DE3
	mov	ax, word ptr es:[0Eh]	;@11DE5
	mov	es, word ptr ds:[4EBCh]	;@11DE9
@@1:	mov	cx, word ptr es:[0Ah]	;@11DED
	jcxz	@@2	;@11DF2
	mov	es, cx	;@11DF4
	cmp	ax, word ptr es:[4]	;@11DF6
	jne	@@1	;@11DFB
	cmp	dx, word ptr es:[0Ch]	;@11DFD
	jne	@@1	;@11E02
	ret	;@11E04
@@2:	stc	;@11E05
	ret	;@11E06
L11E07:	xor	ax, ax	;@11E07
	mov	word ptr ds:[4EDAh], ax	;@11E09
	mov	word ptr ds:[4EDCh], ax	;@11E0C
	mov	word ptr ds:[4EDEh], ax	;@11E0F
	mov	word ptr ds:[4EE0h], ax	;@11E12
	mov	word ptr ds:[38BEh], ax	;@11E15
	mov	word ptr ds:[38C0h], ax	;@11E18
	retf	;@11E1B
L11E1C:	mov	ax, word ptr ds:[4EDAh]	;@11E1C
@@1:	and	ax, ax	;@11E1F
	jne	@@2	;@11E21
	db	0E9h, 0E8h, 1	; jmp L1200E	;@11E23
@@2:	mov	es, ax	;@11E26
	push	word ptr es:[0]	;@11E28
	mov	cx, word ptr es:[4]	;@11E2D
	test	cx, 4000h	;@11E32
	db	75h, 64h	; jne @@7	;@11E36
	and	cx, 7FFh	;@11E38
	cmp	cx, 8Bh	;@11E3C
	db	74h, 5Ah	; je @@7	;@11E40
	cmp	cx, 73h	;@11E42
	db	74h, 55h	; je @@7	;@11E45
	cmp	cx, 79h	;@11E47
	db	74h, 50h	; je @@7	;@11E4A
	cmp	cx, 2Ah	;@11E4C
	db	74h, 4Bh	; je @@7	;@11E4F
	cmp	cx, 17h	;@11E51
	db	74h, 46h	; je @@7	;@11E54
	cmp	cx, 3Bh	;@11E56
	db	74h, 41h	; je @@7	;@11E59
	cmp	word ptr es:[6], 0	;@11E5B
	db	74h, 39h	; je @@7	;@11E61
	push	ax	;@11E63
	mov	dx, word ptr es:[2]	;@11E64
	mov	cx, word ptr es:[0]	;@11E69
	jcxz	@@3	;@11E6E
	push	ds	;@11E70
	mov	ds, cx	;@11E71
	mov	word ptr ds:[2], dx	;@11E73
	pop	ds	;@11E77
	jmp	short @@4	;@11E78
@@3:	mov	word ptr ds:[4EDCh], dx	;@11E7A
@@4:	and	dx, dx	;@11E7E
	je	@@5	;@11E80
	push	ds	;@11E82
	mov	ds, dx	;@11E83
	mov	word ptr ds:[0], cx	;@11E85
	pop	ds	;@11E89
	jmp	short @@6	;@11E8A
@@5:	mov	word ptr ds:[4EDAh], cx	;@11E8C
@@6:	pop	ax	;@11E90
	mov	dx, 1	;@11E91
	push	cs	;@11E94
	db	0E8h, 0Eh, 0DCh	; call L0FAA6	;@11E95
	db	0FFh, 0Eh, 0BEh, 38h	; dec word ptr ds:[38BEh]	;@11E98
@@7:	pop	ax	;@11E9C
	jmp	@@1	;@11E9D
L11E9F:	test	cx, 4000h	;@11E9F
	jne	@@3	;@11EA3
	test	cx, 8000h	;@11EA5
	jne	@@1	;@11EA9
	test	word ptr ds:[5160h], 200h	;@11EAB
	jne	@@1	;@11EB1
	test	byte ptr ds:[38D8h], 4	;@11EB3
	je	@@1	;@11EB8
	retf	;@11EBA
@@1:	test	byte ptr ds:[38D8h], 1	;@11EBB
	je	@@2	;@11EC0
	retf	;@11EC2
@@2:	test	cx, 8000h	;@11EC3
	jne	@@3	;@11EC7
	or	byte ptr ds:[38D8h], 4	;@11EC9
@@3:	push	es	;@11ECE
	push	ax	;@11ECF
	push	si	;@11ED0
	mov	ax, 1	;@11ED1
	push	cx	;@11ED4
	mov	cx, ax	;@11ED5
	push	cs	;@11ED7
	db	0E8h, 3Dh, 0DCh	; call L0FB18	;@11ED8
	db	59h	; pop cx	;@11EDB
	mov	es, ax	;@11EDC
	mov	word ptr es:[4], cx	;@11EDE
	mov	word ptr es:[0Ah], di	;@11EE3
	mov	word ptr es:[0Ch], dx	;@11EE8
	mov	ax, word ptr ds:[5152h]	;@11EED
	mov	word ptr es:[8], ax	;@11EF0
	mov	ax, word ptr ds:[515Eh]	;@11EF4
	mov	word ptr es:[6], ax	;@11EF7
	test	byte ptr ds:[38D7h], 0Fh	;@11EFB
	jne	@@6	;@11F00
	mov	cx, word ptr ds:[4EDCh]	;@11F02
	mov	dx, es	;@11F06
	mov	word ptr ds:[4EDCh], dx	;@11F08
	mov	word ptr es:[2], cx	;@11F0C
	mov	word ptr es:[0], 0	;@11F11
	jcxz	@@4	;@11F18
	push	ds	;@11F1A
	mov	ds, cx	;@11F1B
	mov	word ptr ds:[0], dx	;@11F1D
	pop	ds	;@11F21
	jmp	short @@5	;@11F22
@@4:	mov	word ptr ds:[4EDAh], dx	;@11F24
@@5:	db	0E8h, 81h, 3	; call L122AC	;@11F28
	db	0E9h, 0C2h, 0	; jmp @@19	;@11F2B
@@6:	mov	bx, es	;@11F2E
@@7:	mov	ax, word ptr ds:[4EDEh]	;@11F30
@@8:	and	ax, ax	;@11F33
	db	74h, 7Dh	; je @@14	;@11F35
	mov	es, bx	;@11F37
	mov	cx, word ptr es:[8]	;@11F39
	mov	di, word ptr es:[6]	;@11F3E
	mov	es, ax	;@11F43
	mov	ax, word ptr es:[8]	;@11F45
	mov	dx, word ptr es:[6]	;@11F49
	push	cs	;@11F4E
	call	L11788	;@11F4F
	db	77h, 60h	; ja @@14	;@11F52
	mov	ax, word ptr es:[0]	;@11F54
	mov	word ptr ds:[4EDEh], ax	;@11F58
	jne	@@8	;@11F5B
	mov	ax, word ptr es:[4]	;@11F5D
	mov	dx, word ptr es:[0Ah]	;@11F61
	mov	cx, es	;@11F66
	mov	es, bx	;@11F68
	cmp	ax, word ptr es:[4]	;@11F6A
	jne	@@7	;@11F6F
	test	ax, 1800h	;@11F71
	je	@@9	;@11F74
	cmp	dx, word ptr es:[0Ah]	;@11F76
	jne	@@7	;@11F7B
@@9:	mov	es, cx	;@11F7D
	mov	dx, word ptr es:[2]	;@11F7F
	mov	cx, word ptr es:[0]	;@11F84
	jcxz	@@10	;@11F89
	push	ds	;@11F8B
	mov	ds, cx	;@11F8C
	mov	word ptr ds:[2], dx	;@11F8E
	pop	ds	;@11F92
	jmp	short @@11	;@11F93
@@10:	mov	word ptr ds:[4EDCh], dx	;@11F95
@@11:	and	dx, dx	;@11F99
	je	@@12	;@11F9B
	push	ds	;@11F9D
	mov	ds, dx	;@11F9E
	mov	word ptr ds:[0], cx	;@11FA0
	pop	ds	;@11FA4
	jmp	short @@13	;@11FA5
@@12:	mov	word ptr ds:[4EDAh], cx	;@11FA7
@@13:	mov	ax, es	;@11FAB
	mov	dx, 1	;@11FAD
	push	cs	;@11FB0
	db	0E8h, 0F2h, 0DAh	; call L0FAA6	;@11FB1
@@14:	db	8Bh, 0Eh, 0DEh, 4Eh	; mov cx, word ptr ds:[4EDEh]	;@11FB4
	mov	es, bx	;@11FB8
	mov	dx, es	;@11FBA
	jcxz	@@15	;@11FBC
	push	ds	;@11FBE
	mov	ds, cx	;@11FBF
	mov	ax, word ptr ds:[2]	;@11FC1
	mov	word ptr ds:[2], dx	;@11FC4
	pop	ds	;@11FC8
	jmp	short @@16	;@11FC9
@@15:	mov	ax, word ptr ds:[4EDCh]	;@11FCB
	mov	word ptr ds:[4EDCh], dx	;@11FCE
@@16:	and	ax, ax	;@11FD2
	je	@@17	;@11FD4
	push	ds	;@11FD6
	mov	ds, ax	;@11FD7
	mov	word ptr ds:[0], dx	;@11FD9
	pop	ds	;@11FDD
	jmp	short @@18	;@11FDE
@@17:	mov	word ptr ds:[4EDAh], dx	;@11FE0
@@18:	mov	word ptr es:[2], ax	;@11FE4
	mov	word ptr es:[0], cx	;@11FE8
	db	0E8h, 0BCh, 2	; call L122AC	;@11FED
@@19:	mov	ax, word ptr ds:[4EDAh]	;@11FF0
	mov	word ptr ds:[4EE0h], ax	;@11FF3
	test	word ptr es:[4], 4000h	;@11FF6
	je	@@20	;@11FFD
	mov	byte ptr ds:[38D6h], 0Ah	;@11FFF
	mov	sp, word ptr ds:[38BAh]	;@12004
	stc	;@12008
	retf	;@12009
@@20:	pop	si	;@1200A
	pop	ax	;@1200B
	pop	es	;@1200C
	retf	;@1200D
L1200E:	mov	ax, word ptr ds:[4EDAh]	;@1200E
	mov	word ptr ds:[4EDEh], ax	;@12011
	mov	word ptr ds:[4EE0h], ax	;@12014
	retf	;@12017
L12018:	mov	cx, word ptr ds:[4EE0h]	;@12018
@@1:	jcxz	@@3	;@1201C
	mov	es, cx	;@1201E
	mov	ax, word ptr ds:[5152h]	;@12020
	mov	dx, word ptr ds:[515Eh]	;@12023
	mov	cx, word ptr es:[8]	;@12027
	mov	di, word ptr es:[6]	;@1202C
	push	cs	;@12031
	call	L11788	;@12032
	jb	@@3	;@12035
	jne	@@2	;@12037
	push	es	;@12039
	db	0E8h, 0E7h, 0	; call L12124	;@1203A
	mov	si, 4EE8h	;@1203D
	push	cs	;@12040
	call	L100A6	;@12041
	pop	es	;@12044
@@2:	mov	cx, word ptr es:[0]	;@12045
	mov	word ptr ds:[4EE0h], cx	;@1204A
	jmp	@@1	;@1204E
@@3:	retf	;@12050
L12051:	mov	word ptr ds:[4EE2h], si	;@12051
	mov	ax, word ptr ds:[38D0h]	;@12055
	mov	word ptr ds:[4EE4h], ax	;@12058
	mov	ax, word ptr ds:[38D2h]	;@1205B
	mov	word ptr ds:[4EE6h], ax	;@1205E
	mov	cx, word ptr ds:[4EDAh]	;@12061
@@1:	jcxz	@@3	;@12065
	mov	es, cx	;@12067
	cmp	word ptr ds:[4EE4h], 0	;@12069
	je	@@4	;@1206E
	test	word ptr es:[4], 8000h	;@12070
	jne	@@2	;@12077
	cmp	word ptr ds:[4EE6h], 0	;@12079
	je	@@4	;@1207E
	dec	word ptr ds:[4EE6h]	;@12080
@@2:	dec	word ptr ds:[4EE4h]	;@12084
	push	es	;@12088
	db	0E8h, 4Ah, 2	; call L122D6	;@12089
	pop	es	;@1208C
	mov	cx, word ptr es:[0]	;@1208D
	jmp	@@1	;@12092
@@3:	retf	;@12094
@@4:	push	es	;@12095
	mov	ax, 1	;@12096
	mov	cx, ax	;@12099
	push	cs	;@1209B
	db	0E8h, 79h, 0DAh	; call L0FB18	;@1209C
	db	8Eh, 0C0h	; mov es, ax	;@1209F
	mov	word ptr es:[4], 56h	;@120A1
	pop	ds	;@120A8
	mov	ax, word ptr ds:[8]	;@120A9
	mov	word ptr es:[8], ax	;@120AC
	mov	ax, word ptr ds:[6]	;@120B0
	mov	word ptr es:[6], ax	;@120B3
	push	ds	;@120B7
	push	ss	;@120B8
	pop	ds	;@120B9
	push	es	;@120BA
	db	0E8h, 18h, 2	; call L122D6	;@120BB
	pop	es	;@120BE
	mov	ax, es	;@120BF
	mov	dx, 1	;@120C1
	push	cs	;@120C4
	db	0E8h, 0DEh, 0D9h	; call L0FAA6	;@120C5
	db	7	; pop es	;@120C8
@@5:	test	word ptr es:[4], 4000h	;@120C9
	je	@@6	;@120D0
	push	es	;@120D2
	call	L122D6	;@120D3
	pop	es	;@120D6
@@6:	mov	ax, word ptr es:[0]	;@120D7
	and	ax, ax	;@120DB
	je	@@3	;@120DD
	mov	es, ax	;@120DF
	jmp	@@5	;@120E1
L120E3:	push	es	;@120E3
	mov	dx, word ptr es:[6]	;@120E4
	mov	ax, word ptr es:[8]	;@120E9
	push	cs	;@120ED
	call	L11699	;@120EE
	and	dx, dx	;@120F1
	je	@@3	;@120F3
	push	cs	;@120F5
	call	L116DD	;@120F6
	mov	di, 4EE8h	;@120F9
	mov	cx, 100h	;@120FC
	push	cs	;@120FF
	call	L11677	;@12100
	push	ds	;@12103
	pop	es	;@12104
	mov	si, 4EE8h	;@12105
	mov	di, si	;@12108
@@1:	lodsb	;@1210A
	cmp	al, 0Dh	;@1210B
	je	@@4	;@1210D
	cmp	al, 9	;@1210F
	je	@@2	;@12111
	cmp	al, 20h	;@12113
	jb	@@1	;@12115
@@2:	stosb	;@12117
	jmp	@@1	;@12118
@@3:	push	ds	;@1211A
	pop	es	;@1211B
	mov	di, 4EE8h	;@1211C
@@4:	xor	al, al	;@1211F
	stosb	;@12121
	pop	es	;@12122
	ret	;@12123
L12124:	mov	bx, 4EE8h	;@12124
	test	word ptr es:[4], 4000h	;@12127
	mov	si, 1A5Ch	;@1212E
	jne	@@1	;@12131
	test	word ptr es:[4], 8000h	;@12133
	mov	si, 1A59h	;@1213A
	je	@@1	;@1213D
	mov	si, 1A56h	;@1213F
@@1:	call	L12282	;@12142
	push	es	;@12145
	mov	ax, word ptr es:[8]	;@12146
	mov	dx, word ptr es:[6]	;@1214A
	push	cs	;@1214F
	call	L11699	;@12150
	push	ax	;@12153
	push	cs	;@12154
	call	L116B9	;@12155
	pop	ax	;@12158
	call	L121FD	;@12159
	pop	es	;@1215C
	push	es	;@1215D
	mov	ax, word ptr es:[8]	;@1215E
	mov	dx, word ptr es:[6]	;@12162
	push	ax	;@12167
	push	cs	;@12168
	call	L116B9	;@12169
	pop	ax	;@1216C
	and	dl, dl	;@1216D
	je	@@2	;@1216F
	call	L121FD	;@12171
@@2:	pop	es	;@12174
	mov	ax, word ptr es:[4]	;@12175
	and	ax, 7FFh	;@12179
	shl	ax, 1	;@1217C
	mov	si, ax	;@1217E
	mov	si, word ptr [si+0A72h]	;@12180
	mov	byte ptr [bx], 1	;@12184
	inc	bx	;@12187
	mov	word ptr [bx], si	;@12188
	add	bx, 2	;@1218A
	test	word ptr es:[4], 1000h	;@1218D
	db	74h, 17h	; je @@3	;@12194
	mov	si, 1A5Fh	;@12196
	call	L12282	;@12199
	push	es	;@1219C
	mov	es, word ptr es:[0Ah]	;@1219D
	call	far ptr L03204	;@121A2
	db	0E8h, 0E5h, 0	; call L1228F	;@121A7
	db	7	; pop es	;@121AA
	jmp	short @@6	;@121AB
@@3:	test	word ptr es:[4], 2000h	;@121AD
	je	@@4	;@121B4
	mov	si, 1A5Fh	;@121B6
	call	L12282	;@121B9
	push	es	;@121BC
	mov	dx, word ptr es:[0Ah]	;@121BD
	push	cs	;@121C2
	call	L116B9	;@121C3
	mov	si, di	;@121C6
	call	L12275	;@121C8
	pop	es	;@121CB
	jmp	short @@6	;@121CC
@@4:	test	word ptr es:[4], 800h	;@121CE
	je	@@6	;@121D5
	mov	si, 1A62h	;@121D7
	call	L12282	;@121DA
	mov	cx, word ptr es:[0Ch]	;@121DD
	jcxz	@@5	;@121E2
	mov	ax, cx	;@121E4
	call	L12222	;@121E6
@@5:	mov	ax, word ptr es:[0Ah]	;@121E9
	call	L12222	;@121ED
	mov	si, 1A67h	;@121F0
	call	L12282	;@121F3
@@6:	mov	byte ptr [bx], 0	;@121F6
	inc	bx	;@121F9
	mov	di, bx	;@121FA
	ret	;@121FC
C0F9B	ends

CODE0	segment byte public 'CODE'
	assume	cs:CODE0
	db	9Ah	;@00082
	dd	L10B6F
	db	0C3h, 9Ah
	dd	L10BAA
	db	0C3h, 9Ah
	dd	L108C1
	db	0C3h
L00094:	and	bl, 0Fh	;@00094
	cmp	bl, 0Ah	;@00097
	je	@@1	;@0009A
	xor	bh, bh	;@0009C
	mov	al, byte ptr [bx+608h]	;@0009E
	xor	ah, ah	;@000A2
	xor	dx, dx	;@000A4
	ret	;@000A6
@@1:	push	es	;@000A7
	push	si	;@000A8
	mov	es, cx	;@000A9
	call	L00CD9	;@000AB
	call	L03212	;@000AE
	pop	si	;@000B1
	pop	es	;@000B2
	ret	;@000B3
L000B4:	mov	bl, byte ptr es:[7]	;@000B4
	and	bl, 3Fh	;@000B9
	je	@@2	;@000BC
	test	bl, 20h	;@000BE
	jne	@@1	;@000C1
	cmp	bl, 4	;@000C3
	je	@@1	;@000C6
	xor	dx, dx	;@000C8
	mov	ax, 1	;@000CA
	and	ax, ax	;@000CD
	ret	;@000CF
@@1:	and	bl, bl	;@000D0
	mov	ax, word ptr es:[18h]	;@000D2
	mov	dx, word ptr es:[1Ah]	;@000D6
	ret	;@000DB
@@2:	or	byte ptr es:[10h], 80h	;@000DC
	and	bl, bl	;@000E2
	ret	;@000E4
L000E5:	test	word ptr ds:[5160h], 1000h	;@000E5
	jne	@@7	;@000EB
	mov	cx, word ptr es:[1Ch]	;@000ED
	mov	bl, byte ptr es:[7]	;@000F2
	test	bl, 20h	;@000F7
	jne	@@5	;@000FA
	and	bl, 3Fh	;@000FC
	je	@@6	;@000FF
	cmp	bl, 10h	;@00101
	je	@@6	;@00104
	cmp	bl, 3	;@00106
	je	@@4	;@00109
	cmp	bl, 4	;@0010B
	je	@@1	;@0010E
	cmp	bl, 5	;@00110
	je	@@2	;@00113
	xor	ax, ax	;@00115
	xor	dx, dx	;@00117
	ret	;@00119
@@1:	mov	bl, byte ptr es:[0Eh]	;@0011A
	mov	cx, word ptr es:[1Ch]	;@0011F
	jmp	short @@5	;@00124
@@2:	mov	ax, es	;@00126
	cmp	ax, word ptr ds:[5162h]	;@00128
	jne	@@3	;@0012C
	and	bl, bl	;@0012E
	mov	ax, word ptr ds:[5154h]	;@00130
	mov	dx, word ptr ds:[5156h]	;@00133
	ret	;@00137
@@3:	and	bl, bl	;@00138
	mov	ax, word ptr es:[12h]	;@0013A
	mov	dx, word ptr es:[14h]	;@0013E
	ret	;@00143
@@4:	mov	cx, es	;@00144
	mov	bl, 0Ah	;@00146
@@5:	call	L00094	;@00148
	push	ax	;@0014B
	push	dx	;@0014C
	call	L000B4	;@0014D
	pop	di	;@00150
	pop	cx	;@00151
	mov	bx, ax	;@00152
	call	L04A81	;@00154
	mov	ax, word ptr [bx]	;@00157
	mov	dx, word ptr [bx+2]	;@00159
	xor	bl, bl	;@0015C
	dec	bl	;@0015E
@@6:	ret	;@00160
@@7:	mov	bl, byte ptr es:[7]	;@00161
	and	bl, 3Fh	;@00166
	je	@@6	;@00169
	cmp	bl, 10h	;@0016B
	je	@@6	;@0016E
	test	bl, 20h	;@00170
	jne	@@10	;@00173
	cmp	bl, 4	;@00175
	je	@@9	;@00178
	cmp	bl, 5	;@0017A
	je	@@2	;@0017D
	cmp	bl, 3	;@0017F
	je	@@8	;@00182
	xor	dx, dx	;@00184
	xor	ax, ax	;@00186
	xor	bl, bl	;@00188
	dec	bl	;@0018A
	ret	;@0018C
@@8:	mov	cx, es	;@0018D
	mov	bl, 0Ah	;@0018F
	call	L00094	;@00191
	and	bl, bl	;@00194
	ret	;@00196
@@9:	and	bl, bl	;@00197
	mov	ax, word ptr es:[14h]	;@00199
	mov	dx, word ptr es:[16h]	;@0019D
	ret	;@001A2
@@10:	and	bl, 0Fh	;@001A3
	je	@@9	;@001A6
	cmp	bl, 7	;@001A8
	jb	@@9	;@001AB
	cmp	bl, 0Ah	;@001AD
	je	@@9	;@001B0
	mov	ax, 0	;@001B2
	mov	dx, ax	;@001B5
	ret	;@001B7
L001B8:	mov	bl, byte ptr es:[7]	;@001B8
	and	bl, 3Fh	;@001BD
	je	@@7	;@001C0
	cmp	bl, 0Dh	;@001C2
	je	@@1	;@001C5
	cmp	bl, 0Ah	;@001C7
	je	@@2	;@001CA
	mov	cx, 1058h	;@001CC
	mov	di, es	;@001CF
	call	L03208	;@001D1
	xor	ax, ax	;@001D4
	mov	dx, ax	;@001D6
	jmp	short @@6	;@001D8
@@1:	push	es	;@001DA
	call	L01AEC	;@001DB
	mov	es, ax	;@001DE
	mov	cx, word ptr es:[8]	;@001E0
	pop	es	;@001E5
	xor	bl, bl	;@001E6
	jmp	short @@3	;@001E8
@@2:	mov	cl, byte ptr es:[0Eh]	;@001EA
	xor	ch, ch	;@001EF
	push	es	;@001F1
	mov	es, word ptr es:[10h]	;@001F2
	mov	bl, byte ptr es:[8]	;@001F7
	pop	es	;@001FC
	sub	bl, byte ptr es:[0Eh]	;@001FD
	sub	bl, byte ptr es:[0Fh]	;@00202
@@3:	xor	ax, ax	;@00207
	xor	dx, dx	;@00209
	jcxz	@@6	;@0020B
@@4:	stc	;@0020D
	rcl	ax, 1	;@0020E
	rcl	dx, 1	;@00210
	loop	@@4	;@00212
	and	bl, bl	;@00214
	je	@@6	;@00216
@@5:	shl	ax, 1	;@00218
	rcl	dx, 1	;@0021A
	dec	bl	;@0021C
	jne	@@5	;@0021E
@@6:	xor	bl, bl	;@00220
	dec	bl	;@00222
@@7:	ret	;@00224
L00225:	mov	bl, byte ptr es:[7]	;@00225
	and	bl, 3Fh	;@0022A
	je	@@4	;@0022D
	cmp	bl, 0Dh	;@0022F
	je	@@1	;@00232
	cmp	bl, 0Ah	;@00234
	je	@@2	;@00237
	mov	cx, 1058h	;@00239
	mov	di, es	;@0023C
	call	L03208	;@0023E
	xor	ax, ax	;@00241
	mov	dx, ax	;@00243
	jmp	short @@3	;@00245
@@1:	push	es	;@00247
	call	L01AEC	;@00248
	mov	es, ax	;@0024B
	mov	ax, word ptr es:[8]	;@0024D
	pop	es	;@00251
	xor	dx, dx	;@00252
	jmp	short @@3	;@00254
@@2:	mov	al, byte ptr es:[0Eh]	;@00256
	xor	ah, ah	;@0025A
	xor	dx, dx	;@0025C
@@3:	xor	bl, bl	;@0025E
	dec	bl	;@00260
@@4:	ret	;@00262
L00263:	or	word ptr es:[8], 4000h	;@00263
L0026A:	or	byte ptr es:[7], 80h	;@0026A
	ret	;@00270
L00271:	or	word ptr es:[8], 2000h	;@00271
	ret	;@00278
L00279:	push	si	;@00279
	call	L002AC	;@0027A
	mov	bp, word ptr es:[8]	;@0027D
	and	bp, 1FFFh	;@00282
	call	far ptr L126CF	;@00286
	pop	si	;@0028B
	ret	;@0028C
L0028D:	push	si	;@0028D
	call	L002AC	;@0028E
	mov	bp, word ptr es:[8]	;@00291
	and	bp, 1FFFh	;@00296
	call	far ptr L126FD	;@0029A
	pop	si	;@0029F
	ret	;@002A0
L002A1:	push	si	;@002A1
	call	L002AC	;@002A2
	call	far ptr L126F2	;@002A5
	pop	si	;@002AA
	ret	;@002AB
L002AC:	mov	di, dx	;@002AC
	mov	dx, bx	;@002AE
	mov	bx, cx	;@002B0
	mov	si, ax	;@002B2
	mov	ax, word ptr es:[4]	;@002B4
	mov	cl, byte ptr es:[9]	;@002B8
	rol	cl, 1	;@002BD
	and	cx, 1	;@002BF
	add	cl, byte ptr es:[6]	;@002C2
	ret	;@002C7
L002C8:	mov	si, 2CEh	;@002C8
	jmp	L003A8	;@002CB
L002CE:	mov	es, ax	;@002CE
	test	byte ptr es:[7], 80h	;@002D0
	jne	@@1	;@002D6
	ret	;@002D8
@@1:	mov	dx, ax	;@002D9
	mov	ax, word ptr es:[0Ch]	;@002DB
	test	word ptr es:[8], 4000h	;@002DF
	jne	@@2	;@002E6
	jmp	L0752A	;@002E8
@@2:	jmp	L07533	;@002EB
L002EE:	test	word ptr ds:[38C4h], 800h	;@002EE
	je	L0030F	;@002F4
	mov	si, 2FCh	;@002F6
	jmp	L003A8	;@002F9
L002FC:	mov	es, ax	;@002FC
	test	byte ptr es:[7], 90h	;@002FE
	jne	L0030F	;@00304
	test	word ptr es:[8], 2000h	;@00306
	jne	L00310	;@0030D
L0030F:	ret	;@0030F
L00310:	mov	dx, ax	;@00310
	mov	ax, word ptr es:[0Ch]	;@00312
	jmp	L0753C	;@00316
L00319:	mov	si, 31Fh	;@00319
	jmp	L003A8	;@0031C
L0031F:	mov	es, ax	;@0031F
	mov	al, byte ptr es:[7]	;@00321
	test	al, 20h	;@00325
	je	@@1	;@00327
	ret	;@00329
@@1:	and	al, 3Fh	;@0032A
	cmp	al, 1	;@0032C
	je	L00349	;@0032E
	cmp	al, 2	;@00330
	je	L00349	;@00332
	cmp	al, 3	;@00334
	je	L00349	;@00336
	cmp	al, 0Dh	;@00338
	je	L00349	;@0033A
	cmp	al, 7	;@0033C
	je	L00349	;@0033E
	cmp	al, 8	;@00340
	je	L00349	;@00342
	cmp	al, 0Eh	;@00344
	je	L00349	;@00346
	ret	;@00348
L00349:	mov	word ptr es:[0Eh], 0	;@00349
	ret	;@00350
L00351:	mov	si, 356h	;@00351
	jmp	short L003A8	;@00354
L00356:	mov	es, ax	;@00356
	mov	dx, ax	;@00358
	mov	al, byte ptr es:[7]	;@0035A
	test	al, 20h	;@0035E
	je	@@1	;@00360
	ret	;@00362
@@1:	and	al, 3Fh	;@00363
	cmp	al, 1	;@00365
	je	@@4	;@00367
	cmp	al, 2	;@00369
	je	@@4	;@0036B
	cmp	al, 0Dh	;@0036D
	je	@@4	;@0036F
	cmp	al, 3	;@00371
	je	@@4	;@00373
	cmp	al, 7	;@00375
	je	@@4	;@00377
	cmp	al, 8	;@00379
	je	@@2	;@0037B
	cmp	al, 0Eh	;@0037D
	je	@@4	;@0037F
	ret	;@00381
@@2:	mov	cx, word ptr es:[0Eh]	;@00382
	jcxz	@@4	;@00387
	push	es	;@00389
	mov	es, cx	;@0038A
	mov	di, 8	;@0038C
	call	L05625	;@0038F
	cmp	ax, dx	;@00392
	jne	@@3	;@00394
	call	L0563B	;@00396
	pop	es	;@00399
	call	L031CE	;@0039A
	jmp	short @@4	;@0039D
@@3:	pop	es	;@0039F
@@4:	mov	word ptr es:[0Eh], 0	;@003A0
	ret	;@003A7
L003A8:	mov	word ptr ds:[39B4h], si	;@003A8
	mov	es, word ptr ds:[399Eh]	;@003AC
	xor	bx, bx	;@003B0
	mov	cx, word ptr ds:[39A2h]	;@003B2
@@1:	mov	ax, word ptr es:[bx]	;@003B6
	and	ax, ax	;@003B9
	jne	@@3	;@003BB
@@2:	inc	bx	;@003BD
	inc	bx	;@003BE
	loop	@@1	;@003BF
	ret	;@003C1
@@3:	push	bx	;@003C2
	push	cx	;@003C3
	call	word ptr ds:[39B4h]	;@003C4
	pop	cx	;@003C8
	pop	bx	;@003C9
	mov	es, word ptr ds:[399Eh]	;@003CA
	jmp	@@2	;@003CE
L003D0:	mov	al, byte ptr [bx]	;@003D0
	cmp	al, 30h	;@003D2
	jb	L003E8	;@003D4
	cmp	al, 39h	;@003D6
	ja	L003E8	;@003D8
L003DA:	call	L003E8	;@003DA
	mov	ax, dx	;@003DD
	mov	es, ax	;@003DF
	mov	byte ptr es:[7], 0Bh	;@003E1
	ret	;@003E7
L003E8:	push	si	;@003E8
	call	L02FEB	;@003E9
	jb	@@1	;@003EC
	mov	dx, word ptr es:[bp]	;@003EE
	mov	es, dx	;@003F2
	mov	ax, word ptr es:[0Ch]	;@003F4
	pop	si	;@003F8
	ret	;@003F9
@@1:	call	@@2	;@003FA
	xor	dx, dx	;@003FD
	call	L03073	;@003FF
	pop	si	;@00402
	ret	;@00403
@@2:	cmp	word ptr ds:[39AAh], 0	;@00404
	jne	@@3	;@00409
	mov	ax, 2	;@0040B
	mov	cx, 200h	;@0040E
	call	far ptr L0FB18	;@00411
	mov	word ptr ds:[39AAh], cx	;@00416
	mov	word ptr ds:[39A8h], ax	;@0041A
@@3:	mov	ax, word ptr ds:[39A8h]	;@0041D
	add	word ptr ds:[39A8h], 2	;@00420
	sub	word ptr ds:[39AAh], 2	;@00425
	ret	;@0042A
L0042B:	mov	ax, cx	;@0042B
	shl	ax, 1	;@0042D
	push	cx	;@0042F
	mov	cx, ax	;@00430
	call	far ptr L0FB18	;@00432
	pop	cx	;@00437
	push	ax	;@00438
@@1:	push	cx	;@00439
	push	bx	;@0043A
	mov	cl, byte ptr [bx]	;@0043B
	xor	ch, ch	;@0043D
	inc	bx	;@0043F
	push	ax	;@00440
	call	L02FEB	;@00441
@@2:	jae	@@2	;@00444
	pop	ax	;@00446
	call	L03073	;@00447
	mov	es, ax	;@0044A
	or	byte ptr es:[7], 40h	;@0044C
	add	ax, 2	;@00452
	pop	bx	;@00455
	mov	cl, byte ptr [bx]	;@00456
	xor	ch, ch	;@00458
	inc	bx	;@0045A
	add	bx, cx	;@0045B
	pop	cx	;@0045D
	loop	@@1	;@0045E
	pop	ax	;@00460
	ret	;@00461
L00462:	and	al, 40h	;@00462
@@1:	push	cx	;@00464
	push	di	;@00465
	mov	cl, byte ptr [bx]	;@00466
	inc	bx	;@00468
	xor	ch, ch	;@00469
	test	cl, 80h	;@0046B
	je	@@2	;@0046E
	and	cl, 7Fh	;@00470
	mov	dl, byte ptr [bx]	;@00473
	xor	dh, dh	;@00475
	jmp	short @@3	;@00477
@@2:	push	bx	;@00479
	push	cx	;@0047A
	push	ax	;@0047B
	call	L003E8	;@0047C
	mov	es, dx	;@0047F
	pop	ax	;@00481
	pop	cx	;@00482
	pop	bx	;@00483
	or	byte ptr es:[7], al	;@00484
@@3:	add	bx, cx	;@00489
	pop	di	;@0048B
	pop	cx	;@0048C
	mov	word ptr [di], dx	;@0048D
	inc	di	;@0048F
	inc	di	;@00490
	loop	@@1	;@00491
	ret	;@00493
L00494:	and	word ptr es:[8], 0E000h	;@00494
	or	word ptr es:[8], bx	;@0049B
	ret	;@004A0
L004A1:	mov	cl, byte ptr es:[6]	;@004A1
	les	di, dword ptr es:[0]	;@004A6
	xor	ch, ch	;@004AB
	ret	;@004AD
L004AE:	mov	cl, byte ptr es:[9]	;@004AE
	rol	cl, 1	;@004B3
	and	cx, 1	;@004B5
	add	cl, byte ptr es:[6]	;@004B8
	mov	ax, word ptr es:[4]	;@004BD
	call	far ptr L0FCE0	;@004C1
	ret	;@004C6
L004C7:	mov	es, ax	;@004C7
	mov	al, byte ptr es:[7]	;@004C9
	mov	di, word ptr es:[1Ch]	;@004CD
	ret	;@004D2
L004D3:	test	word ptr ds:[38C4h], 4000h	;@004D3
	jne	@@2	;@004D9
@@1:	xor	bx, bx	;@004DB
	ret	;@004DD
@@2:	test	bl, 20h	;@004DE
	je	@@1	;@004E1
	and	bx, 0Fh	;@004E3
	cmp	bx, 0Ah	;@004E6
	je	L004F2	;@004E9
	shl	bx, 1	;@004EB
	mov	bx, word ptr [bx+612h]	;@004ED
	ret	;@004F1
L004F2:	push	es	;@004F2
	push	si	;@004F3
	mov	es, ax	;@004F4
	call	L00CD9	;@004F6
	call	L0321E	;@004F9
	pop	si	;@004FC
	pop	es	;@004FD
	ret	;@004FE
L004FF:	test	word ptr ds:[38C4h], 4000h	;@004FF
	jne	@@2	;@00505
@@1:	xor	bx, bx	;@00507
	ret	;@00509
@@2:	test	bl, 20h	;@0050A
	je	@@1	;@0050D
	and	bx, 0Fh	;@0050F
	cmp	bx, 0Ah	;@00512
	je	L004F2	;@00515
	shl	bx, 1	;@00517
	mov	di, 626h	;@00519
	test	byte ptr ds:[51A3h], 20h	;@0051C
	je	@@3	;@00521
	mov	di, 63Ah	;@00523
@@3:	mov	bx, word ptr [bx+di]	;@00526
	ret	;@00528
L00529:	call	L004FF	;@00529
	or	bx, 1000h	;@0052C
	ret	;@00530
L00531:	test	word ptr ds:[38C4h], 4000h	;@00531
	jne	@@1	;@00537
	xor	bx, bx	;@00539
	ret	;@0053B
@@1:	xor	di, di	;@0053C
	test	bl, 20h	;@0053E
	je	@@2	;@00541
	mov	di, bx	;@00543
	and	di, 0Fh	;@00545
	cmp	di, 0Ah	;@00548
	je	L0056A	;@0054B
	shl	di, 1	;@0054D
@@2:	mov	cx, word ptr [di+39B9h]	;@0054F
	jcxz	L00558	;@00553
	mov	bx, cx	;@00555
	ret	;@00557
L00558:	push	si	;@00558
	push	di	;@00559
	mov	bx, word ptr [di+612h]	;@0055A
	call	far ptr L12931	;@0055E
	pop	di	;@00563
	mov	word ptr [di+39B9h], bx	;@00564
	pop	si	;@00568
	ret	;@00569
L0056A:	push	si	;@0056A
	mov	es, ax	;@0056B
	call	L00CD9	;@0056D
	call	L03226	;@00570
	pop	si	;@00573
	ret	;@00574
L00575:	test	word ptr ds:[38C4h], 4000h	;@00575
	jne	@@1	;@0057B
	xor	bx, bx	;@0057D
	ret	;@0057F
@@1:	xor	di, di	;@00580
	test	bl, 20h	;@00582
	je	@@2	;@00585
	mov	di, bx	;@00587
	and	di, 0Fh	;@00589
	cmp	di, 0Ah	;@0058C
	je	@@4	;@0058F
	shl	di, 1	;@00591
@@2:	mov	cx, word ptr [di+39CDh]	;@00593
	jcxz	@@3	;@00597
	mov	bx, cx	;@00599
	ret	;@0059B
@@3:	push	si	;@0059C
	push	di	;@0059D
	mov	bx, word ptr [di+612h]	;@0059E
	call	far ptr L1294D	;@005A2
	pop	di	;@005A7
	mov	word ptr [di+39CDh], bx	;@005A8
	pop	si	;@005AC
	ret	;@005AD
@@4:	push	si	;@005AE
	mov	es, ax	;@005AF
	call	L00CD9	;@005B1
	call	L03244	;@005B4
	pop	si	;@005B7
	ret	;@005B8
L005B9:	test	word ptr ds:[38C4h], 4000h	;@005B9
	jne	@@1	;@005BF
	xor	bx, bx	;@005C1
	ret	;@005C3
@@1:	xor	di, di	;@005C4
	test	bl, 20h	;@005C6
	je	@@2	;@005C9
	mov	di, bx	;@005CB
	and	di, 0Fh	;@005CD
	cmp	di, 0Ah	;@005D0
	je	@@4	;@005D3
	shl	di, 1	;@005D5
@@2:	mov	cx, word ptr [di+39E1h]	;@005D7
	jcxz	@@3	;@005DB
	mov	bx, cx	;@005DD
	ret	;@005DF
@@3:	push	si	;@005E0
	push	di	;@005E1
	mov	bx, word ptr [di+612h]	;@005E2
	call	far ptr L12959	;@005E6
	pop	di	;@005EB
	mov	word ptr [di+39E1h], bx	;@005EC
	pop	si	;@005F0
	ret	;@005F1
@@4:	push	si	;@005F2
	mov	es, ax	;@005F3
	call	L00CD9	;@005F5
	call	L03262	;@005F8
	pop	si	;@005FB
	ret	;@005FC
L005FD:	test	word ptr ds:[38C4h], 4000h	;@005FD
	jne	L00608	;@00603
	xor	bx, bx	;@00605
	ret	;@00607
L00608:	xor	di, di	;@00608
	test	bl, 20h	;@0060A
	je	@@1	;@0060D
	mov	di, bx	;@0060F
	and	di, 0Fh	;@00611
	cmp	di, 0Ah	;@00614
	je	@@3	;@00617
	shl	di, 1	;@00619
@@1:	mov	cx, word ptr [di+39F5h]	;@0061B
	jcxz	@@2	;@0061F
	mov	bx, cx	;@00621
	ret	;@00623
@@2:	push	si	;@00624
	push	di	;@00625
	mov	bx, word ptr [di+612h]	;@00626
	call	far ptr L12964	;@0062A
	pop	di	;@0062F
	mov	word ptr [di+39F5h], bx	;@00630
	pop	si	;@00634
	ret	;@00635
@@3:	push	si	;@00636
	mov	es, ax	;@00637
	call	L00CD9	;@00639
	call	L03280	;@0063C
	pop	si	;@0063F
	ret	;@00640
L00641:	test	byte ptr es:[7], 3Fh	;@00641
	jne	@@1	;@00647
	or	byte ptr es:[10h], 0Ah	;@00649
@@1:	ret	;@0064F
L00650:	test	byte ptr es:[7], 3Fh	;@00650
	jne	@@1	;@00656
	or	byte ptr es:[10h], 6	;@00658
@@1:	ret	;@0065E
L0065F:	test	byte ptr es:[7], 3Fh	;@0065F
	jne	@@1	;@00665
	or	byte ptr es:[10h], 1	;@00667
@@1:	ret	;@0066D
L0066E:	and	ah, ah	;@0066E
	jne	@@1	;@00670
	ret	;@00672
@@1:	mov	bp, ds	;@00673
	mov	ds, ax	;@00675
	cmp	byte ptr ds:[7], 0Bh	;@00677
	mov	ds, bp	;@0067C
	ret	;@0067E
L0067F:	and	ah, ah	;@0067F
	je	@@1	;@00681
	mov	bp, ds	;@00683
	mov	ds, ax	;@00685
	cmp	byte ptr ds:[7], 0Bh	;@00687
	mov	ds, bp	;@0068C
	ret	;@0068E
@@1:	and	al, al	;@0068F
	ret	;@00691
L00692:	mov	es, dx	;@00692
	mov	al, byte ptr es:[7]	;@00694
	and	al, 3Fh	;@00698
	cmp	al, 1	;@0069A
	je	@@2	;@0069C
@@1:	mov	es, dx	;@0069E
	mov	ax, word ptr es:[0Ch]	;@006A0
	ret	;@006A4
@@2:	push	dx	;@006A5
	call	L01AEC	;@006A6
	pop	dx	;@006A9
	mov	es, ax	;@006AA
	cmp	word ptr es:[0Ah], 0	;@006AC
	je	@@1	;@006B2
	mov	ax, word ptr es:[8]	;@006B4
	call	far ptr L0FCE0	;@006B8
	mov	dx, word ptr es:[di]	;@006BD
	jmp	@@1	;@006C0
L006C2:	mov	bp, ds	;@006C2
	mov	ds, ax	;@006C4
	test	byte ptr ds:[10h], 80h	;@006C6
	mov	ds, bp	;@006CB
	ret	;@006CD
L006CE:	mov	bp, ds	;@006CE
	mov	ds, ax	;@006D0
	mov	al, byte ptr ds:[7]	;@006D2
	and	al, 3Fh	;@006D5
	cmp	al, 29h	;@006D7
	mov	ax, ds	;@006D9
	mov	ds, bp	;@006DB
	ret	;@006DD
L006DE:	mov	byte ptr es:[19h], 1	;@006DE
	ret	;@006E4
L006E5:	cmp	byte ptr es:[19h], 0	;@006E5
	ret	;@006EB
L006EC:	mov	al, byte ptr es:[18h]	;@006EC
	and	al, 0E0h	;@006F0
	cmp	al, 20h	;@006F2
	ret	;@006F4
L006F5:	mov	al, byte ptr es:[18h]	;@006F5
	and	al, 0E0h	;@006F9
	cmp	al, 20h	;@006FB
	je	@@1	;@006FD
	cmp	al, 40h	;@006FF
@@1:	ret	;@00701
L00702:	mov	al, byte ptr es:[18h]	;@00702
	and	al, 0E0h	;@00706
	cmp	al, 20h	;@00708
	je	@@1	;@0070A
	cmp	al, 40h	;@0070C
	je	@@1	;@0070E
	cmp	al, 0A0h	;@00710
@@1:	ret	;@00712
L00713:	mov	al, byte ptr es:[18h]	;@00713
	and	al, 0E0h	;@00717
	je	@@1	;@00719
	cmp	al, 20h	;@0071B
	je	@@1	;@0071D
	cmp	al, 40h	;@0071F
	je	@@1	;@00721
	cmp	al, 0A0h	;@00723
	je	@@1	;@00725
	cmp	al, 60h	;@00727
@@1:	ret	;@00729
L0072A:	mov	bp, ds	;@0072A
	mov	ds, ax	;@0072C
	mov	al, byte ptr ds:[7]	;@0072E
	and	al, 3Fh	;@00731
	test	al, 20h	;@00733
	je	@@1	;@00735
	test	al, 10h	;@00737
	mov	ax, ds	;@00739
	mov	ds, bp	;@0073B
	ret	;@0073D
@@1:	cmp	al, 9	;@0073E
	je	L00749	;@00740
	xor	al, al	;@00742
	mov	ax, ds	;@00744
	mov	ds, bp	;@00746
	ret	;@00748
L00749:	xor	al, al	;@00749
	dec	al	;@0074B
	mov	ax, ds	;@0074D
	mov	ds, bp	;@0074F
	ret	;@00751
L00752:	mov	bp, ds	;@00752
	mov	ds, ax	;@00754
	test	byte ptr ds:[18h], 1	;@00756
	mov	ds, bp	;@0075B
	ret	;@0075D
L0075E:	mov	bp, ds	;@0075E
	mov	ds, ax	;@00760
	mov	al, byte ptr ds:[7]	;@00762
	and	al, 3Fh	;@00765
	cmp	al, 5	;@00767
	mov	ax, ds	;@00769
	mov	ds, bp	;@0076B
	ret	;@0076D
L0076E:	mov	bp, ds	;@0076E
	mov	ds, ax	;@00770
	mov	al, byte ptr ds:[7]	;@00772
	and	al, 3Fh	;@00775
	cmp	al, 5	;@00777
	jne	@@2	;@00779
	test	word ptr ss:[5160h], 1000h	;@0077B
	je	L00749	;@00782
	mov	al, byte ptr ds:[18h]	;@00784
	and	al, 1Ch	;@00787
	je	@@1	;@00789
	cmp	al, 18h	;@0078B
	jne	@@2	;@0078D
@@1:	mov	al, byte ptr ds:[18h]	;@0078F
	and	al, 0E0h	;@00792
	je	@@2	;@00794
	cmp	al, 60h	;@00796
	je	@@2	;@00798
	cmp	al, 80h	;@0079A
@@2:	mov	ax, ds	;@0079C
	mov	ds, bp	;@0079E
	ret	;@007A0
L007A1:	push	ax	;@007A1
	push	es	;@007A2
	mov	es, ax	;@007A3
	mov	al, byte ptr es:[7]	;@007A5
	and	al, 3Fh	;@007A9
	test	al, 20h	;@007AB
	jne	@@4	;@007AD
	cmp	al, 0	;@007AF
	je	@@2	;@007B1
	cmp	al, 10h	;@007B3
	je	@@3	;@007B5
	cmp	al, 0Bh	;@007B7
	je	@@3	;@007B9
	cmp	al, 2	;@007BB
	je	@@1	;@007BD
	cmp	al, 7	;@007BF
	je	@@1	;@007C1
	cmp	al, 3	;@007C3
	je	@@1	;@007C5
	cmp	al, 1	;@007C7
	je	@@1	;@007C9
	cmp	al, 0Eh	;@007CB
	je	@@1	;@007CD
	cmp	al, 8	;@007CF
	jne	@@4	;@007D1
@@1:	push	bx	;@007D3
	push	cx	;@007D4
	push	dx	;@007D5
	push	si	;@007D6
	push	di	;@007D7
	call	L01AEC	;@007D8
	pop	di	;@007DB
	pop	si	;@007DC
	pop	dx	;@007DD
	pop	cx	;@007DE
	pop	bx	;@007DF
	push	es	;@007E0
	mov	es, ax	;@007E1
	test	byte ptr es:[6], 1	;@007E3
	pop	es	;@007E9
	jmp	short @@4	;@007EA
@@2:	or	byte ptr es:[10h], 1	;@007EC
@@3:	xor	al, al	;@007F2
@@4:	pop	es	;@007F4
	pop	ax	;@007F5
	ret	;@007F6
L007F7:	mov	bp, ds	;@007F7
	mov	ds, ax	;@007F9
	cmp	word ptr ds:[0Ah], 0	;@007FB
	mov	ds, bp	;@00800
	ret	;@00802
	db	8Ch, 0DDh, 8Eh, 0D8h, 0F6h, 6, 7, 0, 40h, 8Eh, 0DDh, 0C3h	;@00803
L0080F:	mov	bp, ds	;@0080F
	mov	ds, ax	;@00811
	mov	al, byte ptr ds:[7]	;@00813
	and	al, 3Fh	;@00816
	cmp	al, 7	;@00818
	mov	ax, ds	;@0081A
	mov	ds, bp	;@0081C
	ret	;@0081E
L0081F:	mov	bp, ds	;@0081F
	mov	ds, ax	;@00821
	mov	al, byte ptr ds:[7]	;@00823
	and	al, 3Fh	;@00826
	cmp	al, 0Dh	;@00828
	mov	ax, ds	;@0082A
	mov	ds, bp	;@0082C
	ret	;@0082E
	db	8Ch, 0DDh, 8Eh, 0D8h, 0A0h, 7, 0, '$?<', 1, 74h, 2, 3Ch, 0Eh, 8Ch	;@0082F
	db	0D8h, 8Eh, 0DDh, 0C3h
L00843:	mov	bp, ds	;@00843
	mov	ds, ax	;@00845
	mov	al, byte ptr ds:[7]	;@00847
	and	al, 3Fh	;@0084A
	cmp	al, 1	;@0084C
	mov	ax, ds	;@0084E
	mov	ds, bp	;@00850
	ret	;@00852
L00853:	mov	bp, ds	;@00853
	mov	ds, ax	;@00855
	mov	al, byte ptr ds:[7]	;@00857
	and	al, 3Fh	;@0085A
	cmp	al, 0Dh	;@0085C
	je	@@1	;@0085E
	cmp	al, 3	;@00860
@@1:	mov	ax, ds	;@00862
	mov	ds, bp	;@00864
	ret	;@00866
	db	8Ch, 0DDh, 8Eh, 0D8h, 0A0h, 7, 0, '$?<', 4, 8Ch, 0D8h, 8Eh, 0DDh	;@00867
	db	0C3h
L00877:	mov	bp, ds	;@00877
	mov	ds, ax	;@00879
	mov	al, byte ptr ds:[7]	;@0087B
	and	al, 3Fh	;@0087E
	cmp	al, 2	;@00880
	mov	ax, ds	;@00882
	mov	ds, bp	;@00884
	je	@@1	;@00886
	ret	;@00888
@@1:	mov	es, ax	;@00889
	push	ax	;@0088B
	push	bx	;@0088C
	push	cx	;@0088D
	push	dx	;@0088E
	push	si	;@0088F
	push	di	;@00890
	call	L01AEC	;@00891
	pop	di	;@00894
	pop	si	;@00895
	pop	dx	;@00896
	pop	cx	;@00897
	pop	bx	;@00898
	mov	es, ax	;@00899
	test	byte ptr es:[6], 1	;@0089B
	je	@@2	;@008A1
	xor	al, al	;@008A3
	pop	ax	;@008A5
	ret	;@008A6
@@2:	xor	al, al	;@008A7
	dec	al	;@008A9
	pop	ax	;@008AB
	ret	;@008AC
L008AD:	mov	byte ptr es:[11h], bl	;@008AD
	mov	word ptr es:[1Ch], ax	;@008B2
	mov	ax, word ptr ds:[5162h]	;@008B6
	mov	word ptr es:[0Eh], ax	;@008B9
	or	byte ptr es:[10h], 40h	;@008BD
	ret	;@008C3
L008C4:	xor	bh, bh	;@008C4
	mov	cx, word ptr es:[0Eh]	;@008C6
	jcxz	@@2	;@008CB
	push	es	;@008CD
	mov	es, cx	;@008CE
	inc	bh	;@008D0
	test	byte ptr es:[18h], 1	;@008D2
	je	@@1	;@008D8
	inc	bh	;@008DA
@@1:	pop	es	;@008DC
@@2:	mov	bl, byte ptr es:[11h]	;@008DD
	mov	ax, word ptr es:[1Ch]	;@008E2
	or	byte ptr es:[10h], 80h	;@008E6
	ret	;@008EC
L008ED:	mov	bh, byte ptr es:[7]	;@008ED
	and	bh, 3Fh	;@008F2
	je	@@1	;@008F5
	cmp	bh, 2	;@008F7
	jne	@@2	;@008FA
	ret	;@008FC
@@1:	mov	bh, 9	;@008FD
	jmp	L0319E	;@008FF
@@2:	jmp	L03185	;@00902
L00905:	call	L01B6D	;@00905
	mov	es, ax	;@00908
	mov	ax, word ptr ds:[515Eh]	;@0090A
	mov	word ptr es:[0], ax	;@0090D
	mov	ax, word ptr ds:[5152h]	;@00911
	mov	word ptr es:[2], ax	;@00914
	mov	byte ptr es:[6], 0	;@00918
	call	L019C3	;@0091E
	or	byte ptr es:[6], 1	;@00921
	ret	;@00927
L00928:	mov	ax, es	;@00928
	mov	dx, 1	;@0092A
	call	far ptr L0FAA6	;@0092D
	ret	;@00932
L00933:	mov	bx, 1A55h	;@00933
	test	byte ptr es:[7], 3Fh	;@00936
	jne	@@1	;@0093C
	or	byte ptr es:[7], 2	;@0093E
	mov	bx, 1A2Fh	;@00944
@@1:	call	bx	;@00947
	mov	es, ax	;@00949
	jmp	L019C3	;@0094B
L0094E:	call	L00933	;@0094E
	or	byte ptr es:[6], 1	;@00951
	ret	;@00957
L00958:	xor	bl, bl	;@00958
	jmp	short L0095E	;@0095A
L0095C:	mov	bl, 1	;@0095C
L0095E:	mov	dx, ax	;@0095E
	mov	di, 0Ah	;@00960
@@1:	mov	cx, word ptr es:[di]	;@00963
	jcxz	@@2	;@00966
	mov	es, cx	;@00968
	cmp	word ptr es:[2], dx	;@0096A
	je	@@3	;@0096F
	mov	di, 0	;@00971
	jmp	@@1	;@00974
@@2:	call	L01B6D	;@00976
	mov	word ptr es:[di], ax	;@00979
	mov	es, ax	;@0097C
	xor	ax, ax	;@0097E
	mov	word ptr es:[6], ax	;@00980
	mov	word ptr es:[0], ax	;@00984
	mov	word ptr es:[2], dx	;@00988
	mov	byte ptr es:[8], bl	;@0098D
	ret	;@00992
@@3:	mov	di, dx	;@00993
	mov	cx, 1046h	;@00995
	jmp	L03208	;@00998
L0099B:	mov	bx, si	;@0099B
	xor	cx, cx	;@0099D
@@1:	inc	cx	;@0099F
	lodsb	;@009A0
	cmp	al, 0Dh	;@009A1
	je	@@3	;@009A3
	cmp	al, 20h	;@009A5
	jbe	@@1	;@009A7
	cmp	word ptr [si-1], 3B3Bh	;@009A9
	je	@@7	;@009AE
@@2:	inc	cx	;@009B0
	lodsb	;@009B1
	cmp	al, 0Dh	;@009B2
	jne	@@2	;@009B4
@@3:	mov	ax, cx	;@009B6
	push	es	;@009B8
	call	far ptr L0FB8D	;@009B9
	mov	dl, cl	;@009BE
	inc	cx	;@009C0
	shr	cx, 1	;@009C1
	mov	si, bx	;@009C3
	rep movsw	;@009C5
	mov	bx, ax	;@009C7
	pop	es	;@009C9
	mov	di, 8	;@009CA
@@4:	mov	cx, word ptr es:[di]	;@009CD
	jcxz	@@5	;@009D0
	mov	es, cx	;@009D2
	cmp	byte ptr es:[2], 4	;@009D4
	jne	@@6	;@009DA
	mov	di, 0	;@009DC
	jmp	@@4	;@009DF
@@5:	call	L01B6D	;@009E1
	mov	word ptr es:[di], ax	;@009E4
	mov	es, ax	;@009E7
	xor	ax, ax	;@009E9
	mov	word ptr es:[0], ax	;@009EB
	mov	byte ptr es:[2], al	;@009EF
@@6:	mov	al, byte ptr es:[2]	;@009F3
	shl	al, 1	;@009F7
	add	al, byte ptr es:[2]	;@009F9
	cbw	;@009FE
	add	ax, 4	;@009FF
	inc	byte ptr es:[2]	;@00A02
	mov	di, ax	;@00A07
	mov	word ptr es:[di], bx	;@00A09
	mov	byte ptr es:[di+2], dl	;@00A0C
@@7:	ret	;@00A10
L00A11:	mov	bh, byte ptr es:[7]	;@00A11
	and	bh, 3Fh	;@00A16
	je	@@1	;@00A19
	cmp	bh, 4	;@00A1B
	jne	@@2	;@00A1E
	ret	;@00A20
@@1:	mov	bh, 1	;@00A21
	jmp	L0319E	;@00A23
@@2:	jmp	L03185	;@00A26
L00A29:	or	bl, 20h	;@00A29
	mov	ax, word ptr ds:[5154h]	;@00A2C
	mov	dx, word ptr ds:[5156h]	;@00A2F
	test	byte ptr es:[7], 3Fh	;@00A33
	je	@@2	;@00A39
	test	byte ptr ds:[38D7h], 0Ch	;@00A3B
	jne	@@3	;@00A40
	cmp	bl, byte ptr es:[0Eh]	;@00A42
	jne	@@1	;@00A47
	cmp	cx, word ptr es:[1Ch]	;@00A49
	jne	@@1	;@00A4E
	cmp	ax, word ptr es:[10h]	;@00A50
	jne	@@1	;@00A55
	cmp	dx, word ptr es:[12h]	;@00A57
	jne	@@1	;@00A5C
	ret	;@00A5E
@@1:	mov	cx, 1017h	;@00A5F
	mov	di, es	;@00A62
	jmp	L03208	;@00A64
@@2:	or	byte ptr es:[7], 4	;@00A67
	mov	byte ptr es:[0Eh], bl	;@00A6D
@@3:	mov	word ptr es:[1Ch], cx	;@00A72
	mov	word ptr es:[10h], ax	;@00A77
	mov	word ptr es:[12h], dx	;@00A7B
	ret	;@00A80
L00A81:	mov	ax, word ptr es:[10h]	;@00A81
	mov	dx, word ptr es:[12h]	;@00A85
	mov	bl, byte ptr es:[0Eh]	;@00A8A
	mov	cx, word ptr es:[1Ch]	;@00A8F
	ret	;@00A94
L00A95:	mov	bh, byte ptr es:[7]	;@00A95
	and	bh, 3Fh	;@00A9A
	je	@@1	;@00A9D
	cmp	bh, 0Ah	;@00A9F
	jne	@@2	;@00AA2
	ret	;@00AA4
@@1:	mov	bh, 1	;@00AA5
	jmp	L0319E	;@00AA7
@@2:	jmp	L03185	;@00AAA
L00AAD:	test	byte ptr es:[7], 3Fh	;@00AAD
	je	@@2	;@00AB3
	test	byte ptr ds:[38D7h], 0Ch	;@00AB5
	jne	@@3	;@00ABA
	cmp	dl, byte ptr es:[0Fh]	;@00ABC
	jne	@@1	;@00AC1
	cmp	dh, byte ptr es:[0Eh]	;@00AC3
	jne	@@1	;@00AC8
	cmp	ax, word ptr es:[10h]	;@00ACA
	jne	@@1	;@00ACF
	ret	;@00AD1
@@1:	mov	cx, 1017h	;@00AD2
	mov	di, es	;@00AD5
	jmp	L03208	;@00AD7
@@2:	or	byte ptr es:[7], 0Ah	;@00ADA
@@3:	mov	byte ptr es:[0Fh], dl	;@00AE0
	mov	byte ptr es:[0Eh], dh	;@00AE5
	mov	word ptr es:[10h], ax	;@00AEA
	ret	;@00AEE
L00AEF:	push	es	;@00AEF
	mov	es, word ptr es:[10h]	;@00AF0
	mov	al, byte ptr es:[8]	;@00AF5
	pop	es	;@00AF9
	sub	al, byte ptr es:[0Fh]	;@00AFA
	sub	al, byte ptr es:[0Eh]	;@00AFF
	xor	ah, ah	;@00B04
	xor	dx, dx	;@00B06
	ret	;@00B08
L00B09:	mov	bh, byte ptr es:[7]	;@00B09
	and	bh, 3Fh	;@00B0E
	je	@@1	;@00B11
	cmp	bh, 0Dh	;@00B13
	jne	@@2	;@00B16
	ret	;@00B18
@@1:	mov	bh, 1	;@00B19
	jmp	L0319E	;@00B1B
@@2:	jmp	L03185	;@00B1E
L00B21:	mov	bx, 1A55h	;@00B21
	test	byte ptr es:[7], 3Fh	;@00B24
	jne	@@1	;@00B2A
	or	byte ptr es:[7], 0Dh	;@00B2C
	mov	bx, 1A2Fh	;@00B32
@@1:	call	bx	;@00B35
	mov	es, ax	;@00B37
	test	byte ptr es:[6], 1	;@00B39
	jne	@@2	;@00B3F
	xor	ax, ax	;@00B41
	mov	word ptr es:[0Ah], ax	;@00B43
	mov	word ptr es:[8], ax	;@00B47
@@2:	ret	;@00B4B
L00B4C:	call	L00B21	;@00B4C
	or	byte ptr es:[6], 1	;@00B4F
	ret	;@00B55
L00B56:	mov	bl, 21h	;@00B56
	cmp	ax, 8	;@00B58
	jbe	@@1	;@00B5B
	mov	bl, 22h	;@00B5D
	cmp	ax, 10h	;@00B5F
	jbe	@@1	;@00B62
	mov	bl, 23h	;@00B64
@@1:	mov	word ptr es:[8], ax	;@00B66
	mov	byte ptr es:[0Ch], bl	;@00B6A
	test	word ptr ds:[38C4h], 4000h	;@00B6F
	jne	@@2	;@00B75
	ret	;@00B77
@@2:	test	byte ptr ds:[38D7h], 3	;@00B78
	jne	@@3	;@00B7D
	mov	cx, word ptr es:[0Ah]	;@00B7F
	push	dx	;@00B84
	push	es	;@00B85
	call	@@4	;@00B86
	call	far ptr L1296F	;@00B89
	pop	es	;@00B8E
	mov	dx, bx	;@00B8F
	mov	word ptr es:[0Eh], dx	;@00B91
	mov	bl, byte ptr es:[0Ch]	;@00B96
	pop	ax	;@00B9B
	mov	es, ax	;@00B9C
	and	bl, 0DFh	;@00B9E
	xor	bh, bh	;@00BA1
	mov	bl, byte ptr [bx+608h]	;@00BA3
	push	si	;@00BA7
	mov	si, bx	;@00BA8
	push	es	;@00BAA
	push	dx	;@00BAB
	call	L004A1	;@00BAC
	call	far ptr L0FCFE	;@00BAF
	xor	di, di	;@00BB4
	pop	bp	;@00BB6
	push	bp	;@00BB7
	call	far ptr L12358	;@00BB8
	pop	bx	;@00BBD
	pop	es	;@00BBE
	call	L035C9	;@00BBF
	pop	si	;@00BC2
@@3:	ret	;@00BC3
@@4:	jcxz	@@3	;@00BC4
	mov	es, cx	;@00BC6
	mov	cx, word ptr es:[0]	;@00BC8
	push	es	;@00BCD
	call	@@4	;@00BCE
	pop	es	;@00BD1
	mov	bl, byte ptr es:[4]	;@00BD2
	and	bl, bl	;@00BD7
	je	@@3	;@00BD9
	mov	es, word ptr es:[2]	;@00BDB
	push	si	;@00BE0
	call	L004A1	;@00BE1
	call	far ptr L0FCFE	;@00BE4
	mov	bp, word ptr ds:[618h]	;@00BE9
	call	far ptr L1232B	;@00BED
	pop	si	;@00BF2
	ret	;@00BF3
L00BF4:	call	L01AEC	;@00BF4
	mov	es, ax	;@00BF7
	xor	ax, ax	;@00BF9
	xor	dx, dx	;@00BFB
	mov	cx, word ptr es:[0Ah]	;@00BFD
@@1:	jcxz	@@4	;@00C02
	mov	es, cx	;@00C04
	xor	di, di	;@00C06
	xor	cx, cx	;@00C08
	mov	bl, byte ptr es:[4]	;@00C0A
	and	bl, bl	;@00C0F
	je	@@3	;@00C11
@@2:	shl	ax, 1	;@00C13
	rcl	dx, 1	;@00C15
	stc	;@00C17
	rcl	cx, 1	;@00C18
	rcl	di, 1	;@00C1A
	dec	bl	;@00C1C
	jne	@@2	;@00C1E
@@3:	push	word ptr es:[0]	;@00C20
	push	ax	;@00C25
	push	dx	;@00C26
	push	cx	;@00C27
	push	di	;@00C28
	push	si	;@00C29
	mov	ax, word ptr es:[6]	;@00C2A
	mov	dx, word ptr es:[8]	;@00C2E
	call	si	;@00C33
	pop	si	;@00C35
	pop	di	;@00C36
	pop	cx	;@00C37
	and	cx, ax	;@00C38
	and	di, dx	;@00C3A
	pop	dx	;@00C3C
	pop	ax	;@00C3D
	or	ax, cx	;@00C3E
	or	dx, di	;@00C40
	pop	cx	;@00C42
	jmp	@@1	;@00C43
@@4:	ret	;@00C45
L00C46:	call	L01AEC	;@00C46
	mov	es, ax	;@00C49
	test	byte ptr es:[6], 1	;@00C4B
	je	@@1	;@00C51
	mov	ax, word ptr es:[8]	;@00C53
	mov	bl, byte ptr es:[0Ch]	;@00C57
	mov	bp, word ptr es:[0Eh]	;@00C5C
@@1:	ret	;@00C61
L00C62:	mov	bh, byte ptr es:[7]	;@00C62
	and	bh, 3Fh	;@00C67
	je	@@1	;@00C6A
	cmp	bh, 3	;@00C6C
	jne	@@2	;@00C6F
	ret	;@00C71
@@1:	mov	bh, 9	;@00C72
	jmp	L0319E	;@00C74
@@2:	jmp	L03185	;@00C77
L00C7A:	mov	bx, 1A55h	;@00C7A
	test	byte ptr es:[7], 3Fh	;@00C7D
	jne	@@1	;@00C83
	or	byte ptr es:[7], 3	;@00C85
	mov	bx, 1A2Fh	;@00C8B
@@1:	call	bx	;@00C8E
	mov	es, ax	;@00C90
	test	byte ptr es:[6], 1	;@00C92
	jne	@@2	;@00C98
	xor	ax, ax	;@00C9A
	mov	word ptr es:[0Ah], ax	;@00C9C
	mov	word ptr es:[8], ax	;@00CA0
@@2:	ret	;@00CA4
L00CA5:	call	L00C7A	;@00CA5
	test	byte ptr es:[6], 1	;@00CA8
	je	L00CC5	;@00CAE
	mov	ax, word ptr es:[8]	;@00CB0
	test	byte ptr ds:[38D7h], 0Ch	;@00CB4
	je	@@1	;@00CB9
	push	es	;@00CBB
	push	ax	;@00CBC
	call	far ptr L12CC4	;@00CBD
	pop	ax	;@00CC2
	pop	es	;@00CC3
@@1:	ret	;@00CC4
L00CC5:	push	es	;@00CC5
	xor	ax, ax	;@00CC6
	call	far ptr L128AB	;@00CC8
	pop	es	;@00CCD
	mov	word ptr es:[8], ax	;@00CCE
	or	byte ptr es:[6], 1	;@00CD2
	ret	;@00CD8
L00CD9:	call	L01AEC	;@00CD9
	mov	es, ax	;@00CDC
	test	byte ptr es:[6], 1	;@00CDE
	mov	ax, word ptr es:[8]	;@00CE4
	ret	;@00CE8
L00CE9:	push	cx	;@00CE9
	push	di	;@00CEA
	mov	dx, ax	;@00CEB
	mov	di, 0Ah	;@00CED
@@1:	mov	cx, word ptr es:[di]	;@00CF0
	jcxz	@@2	;@00CF3
	mov	es, cx	;@00CF5
	cmp	word ptr es:[2], dx	;@00CF7
	je	@@3	;@00CFC
	mov	di, 0	;@00CFE
	jmp	@@1	;@00D01
@@2:	call	L01B6D	;@00D03
	mov	word ptr es:[di], ax	;@00D06
	mov	es, ax	;@00D09
	xor	ax, ax	;@00D0B
	mov	word ptr es:[0], ax	;@00D0D
	mov	word ptr es:[2], dx	;@00D11
	mov	byte ptr es:[4], bl	;@00D16
	pop	word ptr es:[8]	;@00D1B
	pop	word ptr es:[6]	;@00D20
	ret	;@00D25
@@3:	pop	di	;@00D26
	pop	cx	;@00D27
	cmp	cx, word ptr es:[6]	;@00D28
	jne	@@4	;@00D2D
	cmp	di, word ptr es:[8]	;@00D2F
	jne	@@4	;@00D34
	ret	;@00D36
@@4:	mov	cx, 1017h	;@00D37
	jmp	L03208	;@00D3A
L00D3D:	or	bl, 20h	;@00D3D
	push	ax	;@00D40
	push	bx	;@00D41
	push	dx	;@00D42
	call	L01AEC	;@00D43
	mov	es, ax	;@00D46
	pop	dx	;@00D48
	pop	bx	;@00D49
	pop	ax	;@00D4A
	push	dx	;@00D4B
	mov	dx, ax	;@00D4C
	mov	di, 0Ah	;@00D4E
@@1:	mov	cx, word ptr es:[di]	;@00D51
	jcxz	L00D64	;@00D54
	mov	es, cx	;@00D56
	cmp	word ptr es:[2], dx	;@00D58
	je	L00D90	;@00D5D
	mov	di, 0	;@00D5F
	jmp	@@1	;@00D62
L00D64:	call	L01B6D	;@00D64
	mov	word ptr es:[di], ax	;@00D67
	mov	es, ax	;@00D6A
	xor	ax, ax	;@00D6C
	mov	word ptr es:[0], ax	;@00D6E
	mov	word ptr es:[2], dx	;@00D72
	mov	byte ptr es:[0Ah], bl	;@00D77
	pop	word ptr es:[8]	;@00D7C
	mov	ax, word ptr ds:[5154h]	;@00D81
	mov	word ptr es:[4], ax	;@00D84
	mov	ax, word ptr ds:[5156h]	;@00D88
	mov	word ptr es:[6], ax	;@00D8B
	ret	;@00D8F
L00D90:	mov	di, dx	;@00D90
	pop	dx	;@00D92
	mov	ax, word ptr ds:[5154h]	;@00D93
	cmp	ax, word ptr es:[4]	;@00D96
	jne	@@1	;@00D9B
	mov	ax, word ptr ds:[5156h]	;@00D9D
	cmp	ax, word ptr es:[6]	;@00DA0
	jne	@@1	;@00DA5
	cmp	bl, byte ptr es:[0Ah]	;@00DA7
	jne	@@1	;@00DAC
	cmp	dx, word ptr es:[8]	;@00DAE
	jne	@@1	;@00DB3
	ret	;@00DB5
@@1:	mov	cx, 1017h	;@00DB6
	jmp	L03208	;@00DB9
L00DBC:	push	ax	;@00DBC
	call	L01AEC	;@00DBD
	pop	di	;@00DC0
	mov	es, ax	;@00DC1
	test	byte ptr es:[6], 1	;@00DC3
	je	@@3	;@00DC9
	mov	cx, word ptr es:[0Ah]	;@00DCB
@@1:	jcxz	@@2	;@00DD0
	mov	es, cx	;@00DD2
	mov	cx, word ptr es:[0]	;@00DD4
	cmp	word ptr es:[2], di	;@00DD9
	jne	@@1	;@00DDE
	mov	bl, byte ptr es:[0Ah]	;@00DE0
	mov	cx, word ptr es:[8]	;@00DE5
	mov	ax, word ptr es:[4]	;@00DEA
	mov	dx, word ptr es:[6]	;@00DEE
	and	di, di	;@00DF3
	ret	;@00DF5
@@2:	mov	cx, 104Ch	;@00DF6
	call	L03208	;@00DF9
	mov	bl, 20h	;@00DFC
	xor	ax, ax	;@00DFE
	xor	dx, dx	;@00E00
	and	bl, bl	;@00E02
@@3:	ret	;@00E04
L00E05:	call	L01AEC	;@00E05
	mov	es, ax	;@00E08
	mov	cx, word ptr es:[0Ah]	;@00E0A
@@1:	jcxz	@@2	;@00E0F
	mov	es, cx	;@00E11
	mov	ax, word ptr es:[4]	;@00E13
	mov	dx, word ptr es:[6]	;@00E17
	mov	bl, byte ptr es:[0Ah]	;@00E1C
	mov	cx, word ptr es:[8]	;@00E21
	push	word ptr es:[0]	;@00E26
	mov	es, word ptr es:[2]	;@00E2B
	push	si	;@00E30
	call	si	;@00E31
	pop	si	;@00E33
	pop	cx	;@00E34
	jmp	@@1	;@00E35
@@2:	ret	;@00E37
L00E38:	call	L01AEC	;@00E38
	mov	es, ax	;@00E3B
	mov	bl, byte ptr es:[8]	;@00E3D
	mov	cx, word ptr es:[0Ah]	;@00E42
@@1:	jcxz	@@2	;@00E47
	mov	es, cx	;@00E49
	push	word ptr es:[0]	;@00E4B
	mov	es, word ptr es:[2]	;@00E50
	mov	cl, byte ptr es:[0Eh]	;@00E55
	mov	ch, bl	;@00E5A
	sub	ch, byte ptr es:[0Fh]	;@00E5C
	sub	ch, cl	;@00E61
	push	bx	;@00E63
	push	si	;@00E64
	call	si	;@00E65
	pop	si	;@00E67
	pop	bx	;@00E68
	pop	cx	;@00E69
	jmp	@@1	;@00E6A
@@2:	ret	;@00E6C
	db	26h, 8Ah, 1Eh, 7, 0, 80h, 0E3h, 3Fh, 74h, 6, 80h, 0FBh, 0Fh, 75h, 6, 0C3h	;@00E6D
	db	0B7h, 1, 0E9h, 1Ch, 23h, 0E9h, 0, 23h, 26h, 0F6h, 6, 7, 0, 3Fh, 75h, 56h
	db	26h, 80h, 0Eh, 7, 0, 0Fh, 0E8h, 6Eh, 0F5h, 26h, 0A3h, 0Eh, 0, 26h, 0A3h, 10h
	db	0, 8Eh, 0C0h, 26h, 0C7h, 6, 4, 0, 0, 0, 0A1h, 6Eh, 51h, 26h, 0A3h, 2
	db	0, 0A1h, 6Ch, 51h, 26h, 0A3h, 0, 0, 0A1h, 62h, 51h, 26h, 0A3h, 0Eh, 0, 0A1h
	db	54h, 51h, 26h, 0A3h, 10h, 0, 0A1h, 56h, 51h, 26h, 0A3h, 12h, 0, 6, 0E8h, 95h
	db	44h, 7, 74h, 8, 53h, 0B9h, 5Dh, 0, 0E8h, 30h, 23h, 5Bh, 26h, 0A3h, 14h, 0
	db	26h, 89h, 1Eh, 16h, 0, 0C3h, 26h, 8Bh, 0Eh, 10h, 0, 0F6h, 6, 0D7h, 38h, 0Fh
	db	75h, 2Ah, 6, 8Eh, 0C1h, 0A1h, 6Eh, 51h, 26h, 3Bh, 6, 2, 0, 75h, 0Ah, 0A1h
	db	6Ch, 51h, 26h, 3Bh, 6, 0, 0, 74h, 0Ah, 0E8h, 0FBh, 0F4h, 26h, 0A3h, 4, 0
	db	7, 0EBh, 8Ah, 7, 8Ch, 0C7h, 0B9h, 17h, 10h, 0E9h, 0EFh, 22h, 0F6h, 6, 0D7h, 38h
	db	3, 75h, 59h, 6, 8Eh, 0C1h, 0A1h, 6Eh, 51h, 8Bh, 16h, 6Ch, 51h, 26h, 8Bh, 0Eh
	db	2, 0, 26h, 8Bh, 3Eh, 0, 0, 9Ah
	dd	L11788
	db	72h, 55h, 74h, 3Dh, 26h, 8Bh, 0Eh, 4, 0, 0E3h, 0C2h, 8Ch, 0C3h, 8Eh, 0C1h, 0A1h
	db	6Eh, 51h, 8Bh, 16h, 6Ch, 51h, 26h, 8Bh, 0Eh, 2, 0, 26h, 8Bh, 3Eh, 0, 0
	db	9Ah
	dd	L11788
	db	73h, 0DBh, 8Ch, 0C2h, 0E8h, 9Fh, 0F4h, 7, 50h, 53h, 52h, 0E8h, 2Eh, 0FFh, 26h, 8Fh
	db	6, 4, 0, 58h, 8Eh, 0C0h, 26h, 8Fh, 6, 4, 0, 0C3h, 0A1h, 54h, 51h, 26h
	db	0A3h, 10h, 0, 0A1h, 56h, 51h, 26h, 0A3h, 12h, 0, 8Ch, 0C0h, 7, 26h, 0A3h, 10h
	db	0, 0C3h, 7, 26h, 0A1h, 0Eh, 0, 6, 8Eh, 0C0h, 0A1h, 6Eh, 51h, 8Bh, 16h, 6Ch
	db	51h, 26h, 8Bh, 0Eh, 2, 0, 26h, 8Bh, 3Eh, 0, 0, 9Ah
	dd	L11788
	db	73h, 98h, 8Ch, 0C2h, 0E8h, 4Fh, 0F4h, 50h, 52h, 0E8h, 0E0h, 0FEh, 26h, 8Fh, 6, 4
	db	0, 58h, 7, 26h, 0A3h, 0Eh, 0, 0C3h
L00FC6:	test	byte ptr ds:[38D7h], 0Fh	;@00FC6
	jne	@@2	;@00FCB
	mov	ax, word ptr es:[10h]	;@00FCD
	push	es	;@00FD1
	mov	es, ax	;@00FD2
	mov	ax, word ptr es:[2]	;@00FD4
	cmp	ax, word ptr ds:[516Eh]	;@00FD8
	jne	@@1	;@00FDC
	mov	ax, word ptr es:[0]	;@00FDE
	cmp	ax, word ptr ds:[516Ch]	;@00FE2
	je	@@5	;@00FE6
@@1:	pop	es	;@00FE8
	ret	;@00FE9
@@2:	mov	ax, word ptr ds:[5152h]	;@00FEA
	mov	dx, word ptr ds:[515Eh]	;@00FED
	mov	cx, word ptr es:[10h]	;@00FF1
	push	es	;@00FF6
	mov	es, cx	;@00FF7
	mov	di, word ptr es:[0]	;@00FF9
	mov	cx, word ptr es:[2]	;@00FFE
	call	far ptr L11788	;@01003
	jb	@@8	;@01008
	je	@@8	;@0100A
@@3:	mov	cx, word ptr es:[4]	;@0100C
	mov	bx, es	;@01011
	jcxz	@@4	;@01013
	mov	es, cx	;@01015
	mov	di, word ptr es:[0]	;@01017
	mov	cx, word ptr es:[2]	;@0101C
	call	far ptr L11788	;@01021
	je	@@4	;@01026
	jae	@@3	;@01028
@@4:	pop	es	;@0102A
	mov	word ptr es:[10h], bx	;@0102B
	push	es	;@01030
	mov	es, bx	;@01031
@@5:	mov	si, word ptr es:[0Eh]	;@01033
	mov	di, si	;@01038
	mov	ax, word ptr es:[10h]	;@0103A
	mov	dx, word ptr es:[12h]	;@0103E
	push	es	;@01043
	mov	es, di	;@01044
	test	byte ptr es:[18h], 1	;@01046
	mov	bl, 1	;@0104C
	je	@@6	;@0104E
	inc	bl	;@01050
@@6:	mov	es, di	;@01052
	cmp	word ptr es:[10h], 0	;@01054
	je	@@7	;@0105A
	and	di, di	;@0105C
	je	@@7	;@0105E
	xor	di, di	;@01060
	mov	di, word ptr es:[10h]	;@01062
@@7:	pop	es	;@01067
	pop	cx	;@01068
	mov	cx, word ptr es:[14h]	;@01069
	mov	bp, word ptr es:[16h]	;@0106E
	ret	;@01073
@@8:	pop	es	;@01074
	mov	cx, word ptr es:[0Eh]	;@01075
	push	es	;@0107A
	mov	es, cx	;@0107B
	mov	di, word ptr es:[0]	;@0107D
	mov	cx, word ptr es:[2]	;@01082
	call	far ptr L11788	;@01087
	jb	@@9	;@0108C
	jmp	@@3	;@0108E
@@9:	mov	cx, word ptr es:[4]	;@01091
	jcxz	@@5	;@01096
	mov	es, cx	;@01098
	jmp	@@9	;@0109A
L0109C:	mov	bh, byte ptr es:[7]	;@0109C
	and	bh, 3Fh	;@010A1
	je	@@2	;@010A4
	mov	cx, word ptr es:[1Ch]	;@010A6
	or	bl, 20h	;@010AB
	cmp	bl, bh	;@010AE
	jne	@@3	;@010B0
	cmp	bl, 2Ah	;@010B2
	jne	@@1	;@010B5
	cmp	ax, cx	;@010B7
	jne	@@3	;@010B9
	ret	;@010BB
@@1:	xor	bh, bh	;@010BC
	ret	;@010BE
@@2:	mov	bh, 1	;@010BF
	jmp	L0319E	;@010C1
@@3:	jmp	L03185	;@010C4
	db	26h, 89h, 0Eh, 18h, 0, 26h, 89h, 3Eh, 1Ah, 0, 26h, 0A3h, 1Ch, 0, 80h, 0CBh	;@010C7
	db	20h, 26h, 0F6h, 6, 7, 0, 3Fh, 75h, 5Eh, 26h, 8, 1Eh, 7, 0, 53h, 52h
	db	56h, 26h, 0A1h, 1Ch, 0, 0E8h, 0E4h, 0F3h, 5Fh, 58h, 59h, 6, 8Bh, 0F0h, 26h, 8Ah
	db	0Eh, 9, 0, 0D0h, 0C1h, 80h, 0E1h, 1, 26h, 2, 0Eh, 6, 0, 26h, 0A1h, 4
	db	0, 53h, 26h, 8Bh, 1Eh, 18h, 0, 26h, 8Bh, 16h, 1Ah, 0, 5Dh, 9Ah
	dd	L126A5
	db	7, 8Bh, 0Eh, 62h, 51h, 23h, 0C9h, 75h, 2, 8Ch, 0C1h, 33h, 0D2h, 26h, 0FFh, 36h
	db	18h, 0, 26h, 0FFh, 36h, 1Ah, 0, 0E8h, 0C8h, 0, 26h, 8Fh, 6, 1Ah, 0, 26h
	db	8Fh, 6, 18h, 0, 0C3h, 8Bh, 0Eh, 62h, 51h, 23h, 0C9h, 75h, 2, 8Ch, 0C1h, 26h
	db	3Bh, 0Eh, 0Eh, 0, 74h, 0EEh, 0EBh, 55h
L01151:	mov	di, word ptr ds:[5162h]	;@01151
	mov	cx, di	;@01155
	mov	word ptr es:[1Ch], ax	;@01157
	or	bl, 20h	;@0115B
	test	byte ptr es:[7], 3Fh	;@0115E
	jne	@@2	;@01164
	or	byte ptr es:[7], bl	;@01166
	push	cx	;@0116B
	call	L004D3	;@0116C
	mov	cl, byte ptr es:[9]	;@0116F
	rol	cl, 1	;@01174
	and	cl, 1	;@01176
	add	cl, byte ptr es:[6]	;@01179
	push	es	;@0117E
	push	si	;@0117F
	mov	ax, word ptr es:[4]	;@01180
	mov	bp, bx	;@01184
	call	far ptr L12694	;@01186
	pop	si	;@0118B
	pop	es	;@0118C
	pop	cx	;@0118D
	and	cx, cx	;@0118E
	jne	@@1	;@01190
	mov	cx, es	;@01192
@@1:	xor	dx, dx	;@01194
	jmp	short L011FB	;@01196
@@2:	and	cx, cx	;@01198
	jne	@@3	;@0119A
	mov	cx, es	;@0119C
@@3:	cmp	cx, word ptr es:[0Eh]	;@0119E
	jne	@@4	;@011A3
	ret	;@011A5
@@4:	mov	cx, 9017h	;@011A6
	mov	di, es	;@011A9
	jmp	L03208	;@011AB
L011AE:	mov	word ptr es:[1Ch], ax	;@011AE
	or	bl, 20h	;@011B2
	mov	ax, word ptr ds:[5154h]	;@011B5
	mov	dx, word ptr ds:[5156h]	;@011B8
	mov	cx, word ptr ds:[5162h]	;@011BC
	test	byte ptr es:[7], 3Fh	;@011C0
	je	@@3	;@011C6
	test	byte ptr ds:[38D7h], 4	;@011C8
	jne	L011FB	;@011CD
	cmp	ax, word ptr es:[10h]	;@011CF
	jne	@@1	;@011D4
	cmp	dx, word ptr es:[12h]	;@011D6
	jne	@@1	;@011DB
	cmp	cx, word ptr es:[0Eh]	;@011DD
	je	L01243	;@011E2
@@1:	mov	cx, 1017h	;@011E4
	test	byte ptr ds:[38D7h], 8	;@011E7
	je	@@2	;@011EC
	mov	cx, 108Eh	;@011EE
@@2:	mov	di, es	;@011F1
	jmp	L03208	;@011F3
@@3:	or	byte ptr es:[7], bl	;@011F6
L011FB:	mov	word ptr es:[0Eh], cx	;@011FB
	mov	word ptr es:[10h], ax	;@01200
	mov	word ptr es:[12h], dx	;@01204
	xor	ax, ax	;@01209
	mov	word ptr es:[18h], 1	;@0120B
	mov	word ptr es:[1Ah], ax	;@01212
	mov	word ptr es:[14h], 1	;@01216
	mov	word ptr es:[16h], ax	;@0121D
	mov	bl, byte ptr es:[7]	;@01221
	and	bl, 0Fh	;@01226
	cmp	bl, 7	;@01229
	jb	L01243	;@0122C
	cmp	bl, 0Ah	;@0122E
	jae	L01243	;@01231
	push	es	;@01233
	call	L05363	;@01234
	pop	es	;@01237
	jne	L01244	;@01238
L0123A:	mov	word ptr es:[14h], ax	;@0123A
	mov	word ptr es:[16h], bx	;@0123E
L01243:	ret	;@01243
L01244:	test	byte ptr es:[7], 10h	;@01244
	jne	@@1	;@0124A
	push	bx	;@0124C
	mov	cx, 5Dh	;@0124D
	call	L03208	;@01250
	pop	bx	;@01253
	jmp	L0123A	;@01254
@@1:	xor	ax, ax	;@01256
	xor	bx, bx	;@01258
	jmp	L0123A	;@0125A
L0125C:	mov	bl, byte ptr es:[7]	;@0125C
	and	bl, 0Fh	;@01261
	cmp	bl, 7	;@01264
	jb	@@1	;@01267
	cmp	bl, 0Ah	;@01269
	jb	@@2	;@0126C
@@1:	mov	word ptr es:[14h], ax	;@0126E
	mov	word ptr es:[16h], dx	;@01272
@@2:	mov	word ptr es:[18h], cx	;@01277
	mov	word ptr es:[1Ah], di	;@0127C
	ret	;@01281
L01282:	test	byte ptr es:[7], 10h	;@01282
	jne	@@7	;@01288
	mov	si, word ptr es:[0Eh]	;@0128A
	mov	di, si	;@0128F
	mov	ax, word ptr es:[10h]	;@01291
	mov	dx, word ptr es:[12h]	;@01295
@@1:	push	es	;@0129A
	mov	bl, 1	;@0129B
	and	di, di	;@0129D
	je	@@2	;@0129F
	mov	es, di	;@012A1
	test	byte ptr es:[18h], 1	;@012A3
	je	@@2	;@012A9
	inc	bl	;@012AB
@@2:	pop	es	;@012AD
	test	word ptr ds:[5160h], 1000h	;@012AE
	jne	@@3	;@012B4
	test	byte ptr ds:[516Bh], 1	;@012B6
	je	@@5	;@012BB
@@3:	push	es	;@012BD
	and	di, di	;@012BE
	je	@@4	;@012C0
	mov	es, di	;@012C2
	cmp	word ptr es:[10h], 0	;@012C4
	je	@@4	;@012CA
	mov	di, word ptr es:[10h]	;@012CC
@@4:	pop	es	;@012D1
	test	word ptr ds:[5160h], 1000h	;@012D2
	jne	@@6	;@012D8
@@5:	mov	bh, byte ptr es:[7]	;@012DA
	and	bh, 0Fh	;@012DF
	cmp	bh, 7	;@012E2
	jb	@@6	;@012E5
	cmp	bh, 0Ah	;@012E7
	jae	@@6	;@012EA
	mov	cx, word ptr es:[14h]	;@012EC
	mov	bp, word ptr es:[16h]	;@012F1
	clc	;@012F6
	ret	;@012F7
@@6:	stc	;@012F8
	ret	;@012F9
@@7:	mov	si, es	;@012FA
	xor	ax, ax	;@012FC
	xor	dx, dx	;@012FE
	mov	di, word ptr es:[0Eh]	;@01300
	cmp	si, di	;@01305
	jne	@@1	;@01307
	xor	bl, bl	;@01309
	jmp	@@6	;@0130B
L0130D:	mov	ax, word ptr es:[0Eh]	;@0130D
	ret	;@01311
L01312:	mov	bh, byte ptr es:[7]	;@01312
	and	bh, 3Fh	;@01317
	je	@@1	;@0131A
	cmp	bh, 6	;@0131C
	jne	@@2	;@0131F
	ret	;@01321
@@1:	mov	bh, 1	;@01322
	jmp	L0319E	;@01324
@@2:	jmp	L03185	;@01327
L0132A:	test	byte ptr es:[7], 3Fh	;@0132A
	jne	@@1	;@01330
	or	byte ptr es:[7], 6	;@01332
	mov	cl, byte ptr es:[6]	;@01338
	xor	ch, ch	;@0133D
	push	si	;@0133F
	push	es	;@01340
	les	di, dword ptr es:[0]	;@01341
	call	far ptr L0FCFE	;@01346
	call	far ptr L1263F	;@0134B
	pop	es	;@01350
	pop	si	;@01351
	mov	word ptr es:[0Eh], ax	;@01352
@@1:	ret	;@01356
L01357:	mov	bh, byte ptr es:[7]	;@01357
	and	bh, 3Fh	;@0135C
	je	@@2	;@0135F
	cmp	bh, 10h	;@01361
	je	@@1	;@01364
	cmp	bh, 5	;@01366
	jne	@@3	;@01369
@@1:	ret	;@0136B
@@2:	mov	bh, 1	;@0136C
	jmp	L0319E	;@0136E
@@3:	jmp	L03185	;@01371
L01374:	test	bl, 2	;@01374
	je	@@1	;@01377
	and	di, di	;@01379
	je	@@1	;@0137B
	push	es	;@0137D
	mov	es, di	;@0137E
	mov	bl, byte ptr es:[18h]	;@01380
	or	bl, 2	;@01385
	mov	ax, word ptr es:[1Ah]	;@01388
	pop	es	;@0138C
@@1:	mov	cx, ax	;@0138D
	mov	dl, byte ptr es:[7]	;@0138F
	and	dl, 3Fh	;@01394
	je	@@6	;@01397
	cmp	dl, 10h	;@01399
	je	@@7	;@0139C
	test	bl, 2	;@0139E
	jne	@@2	;@013A1
	cmp	bl, byte ptr es:[18h]	;@013A3
	jne	@@3	;@013A8
	cmp	cx, word ptr es:[1Ah]	;@013AA
	jne	@@3	;@013AF
@@2:	cmp	di, word ptr es:[16h]	;@013B1
	je	@@4	;@013B6
@@3:	mov	cx, 51h	;@013B8
	call	L03208	;@013BB
@@4:	mov	ax, word ptr ds:[5152h]	;@013BE
	mov	dx, word ptr ds:[515Eh]	;@013C1
	mov	cx, word ptr es:[1Eh]	;@013C5
	mov	di, word ptr es:[1Ch]	;@013CA
	call	far ptr L11788	;@013CF
	jne	@@5	;@013D4
	xor	ax, ax	;@013D6
	mov	word ptr es:[12h], ax	;@013D8
	mov	word ptr es:[14h], ax	;@013DC
@@5:	ret	;@013E0
@@6:	mov	word ptr es:[10h], 0	;@013E1
@@7:	mov	byte ptr es:[18h], bl	;@013E8
	mov	word ptr es:[16h], di	;@013ED
	mov	word ptr es:[1Ah], cx	;@013F2
	xor	ax, ax	;@013F7
	mov	byte ptr es:[19h], al	;@013F9
	mov	word ptr es:[12h], ax	;@013FD
	mov	word ptr es:[14h], ax	;@01401
	push	es	;@01405
	les	di, dword ptr es:[0]	;@01406
	call	far ptr L0FCFE	;@0140B
	pop	es	;@01410
	mov	dl, byte ptr es:[18h]	;@01411
	mov	bx, word ptr es:[16h]	;@01416
	test	dl, 2	;@0141B
	je	@@8	;@0141E
	and	bx, bx	;@01420
	je	@@8	;@01422
	push	es	;@01424
	mov	es, bx	;@01425
	mov	bx, word ptr es:[0Eh]	;@01427
	pop	es	;@0142C
@@8:	mov	dh, byte ptr es:[6]	;@0142D
	push	es	;@01432
	push	si	;@01433
	jcxz	@@9	;@01434
	push	ax	;@01436
	mov	es, cx	;@01437
	push	es	;@01439
	les	di, dword ptr es:[0]	;@0143A
	call	far ptr L0FCFE	;@0143F
	pop	es	;@01444
	mov	si, ax	;@01445
	pop	ax	;@01447
	mov	ch, byte ptr es:[6]	;@01448
@@9:	mov	cl, dh	;@0144D
	call	far ptr L12652	;@0144F
	pop	si	;@01454
	pop	es	;@01455
	mov	word ptr es:[0Eh], ax	;@01456
	mov	cx, ax	;@0145A
	mov	ax, word ptr es:[10h]	;@0145C
	and	ax, ax	;@01460
	je	@@10	;@01462
	push	es	;@01464
	push	si	;@01465
	mov	es, ax	;@01466
	mov	ax, word ptr es:[0Eh]	;@01468
	call	far ptr L12C89	;@0146C
	pop	si	;@01471
	pop	es	;@01472
@@10:	mov	ax, word ptr ds:[515Eh]	;@01473
	mov	word ptr es:[1Ch], ax	;@01476
	mov	ax, word ptr ds:[5152h]	;@0147A
	mov	word ptr es:[1Eh], ax	;@0147D
	and	byte ptr es:[7], 0C0h	;@01481
	or	byte ptr es:[7], 5	;@01487
	ret	;@0148D
L0148E:	mov	bh, byte ptr es:[7]	;@0148E
	and	bh, 3Fh	;@01493
	je	@@3	;@01496
	cmp	bh, 10h	;@01498
	je	@@2	;@0149B
	cmp	bh, 5	;@0149D
	je	@@2	;@014A0
@@1:	mov	cx, 1027h	;@014A2
	mov	di, es	;@014A5
	jmp	L03208	;@014A7
@@2:	cmp	word ptr es:[10h], 0	;@014AA
	je	@@5	;@014B0
	cmp	ax, word ptr es:[10h]	;@014B2
	jne	@@1	;@014B7
	cmp	bh, 10h	;@014B9
	ret	;@014BC
@@3:	mov	bh, 1	;@014BD
	push	ax	;@014BF
	call	L0319E	;@014C0
	pop	ax	;@014C3
	jne	@@4	;@014C4
	or	byte ptr es:[7], 10h	;@014C6
	mov	word ptr es:[10h], ax	;@014CC
@@4:	xor	al, al	;@014D0
	ret	;@014D2
@@5:	mov	word ptr es:[10h], ax	;@014D3
	cmp	bh, 10h	;@014D7
	je	@@6	;@014DA
	mov	cx, word ptr es:[0Eh]	;@014DC
	push	es	;@014E1
	mov	es, word ptr es:[10h]	;@014E2
	mov	ax, word ptr es:[0Eh]	;@014E7
	push	si	;@014EB
	call	far ptr L12C89	;@014EC
	pop	si	;@014F1
	pop	es	;@014F2
	xor	al, al	;@014F3
	dec	al	;@014F5
@@6:	ret	;@014F7
L014F8:	mov	al, byte ptr es:[7]	;@014F8
	and	al, 3Fh	;@014FC
	cmp	al, 5	;@014FE
	jne	@@1	;@01500
	mov	ax, word ptr es:[10h]	;@01502
	and	ax, ax	;@01506
	je	@@1	;@01508
	ret	;@0150A
@@1:	mov	ax, es	;@0150B
	ret	;@0150D
L0150E:	mov	al, byte ptr es:[7]	;@0150E
	and	al, 3Fh	;@01512
	cmp	al, 5	;@01514
	jne	@@1	;@01516
	test	byte ptr es:[18h], 2	;@01518
	je	@@1	;@0151E
	mov	ax, word ptr es:[16h]	;@01520
	and	ax, ax	;@01524
	je	@@1	;@01526
	mov	es, ax	;@01528
	jmp	L0150E	;@0152A
@@1:	mov	ax, es	;@0152C
	ret	;@0152E
L0152F:	mov	ax, es	;@0152F
	test	word ptr ds:[5160h], 1000h	;@01531
	jne	@@1	;@01537
	test	byte ptr ds:[516Bh], 1	;@01539
	je	@@2	;@0153E
@@1:	mov	cx, word ptr es:[10h]	;@01540
	jcxz	@@2	;@01545
	ret	;@01547
@@2:	mov	cx, es	;@01548
	ret	;@0154A
L0154B:	mov	bx, word ptr es:[10h]	;@0154B
	mov	cl, byte ptr es:[18h]	;@01550
	mov	ax, word ptr es:[16h]	;@01555
	mov	di, word ptr es:[1Ah]	;@01559
	ret	;@0155E
L0155F:	mov	ax, word ptr es:[0Eh]	;@0155F
	mov	cx, word ptr es:[10h]	;@01563
	jcxz	@@1	;@01568
	mov	es, cx	;@0156A
	mov	cx, word ptr es:[0Eh]	;@0156C
	ret	;@01571
@@1:	mov	cx, ax	;@01572
	ret	;@01574
L01575:	mov	word ptr es:[12h], ax	;@01575
	mov	word ptr es:[14h], dx	;@01579
	ret	;@0157E
L0157F:	mov	ax, word ptr es:[12h]	;@0157F
	mov	dx, word ptr es:[14h]	;@01583
	ret	;@01588
L01589:	mov	bh, byte ptr es:[7]	;@01589
	and	bh, 3Fh	;@0158E
	je	@@1	;@01591
	cmp	bh, 9	;@01593
	jne	@@2	;@01596
	ret	;@01598
@@1:	mov	bh, 1	;@01599
	jmp	L0319E	;@0159B
@@2:	jmp	L03185	;@0159E
L015A1:	test	byte ptr es:[7], 3Fh	;@015A1
	jne	@@1	;@015A7
	or	byte ptr es:[7], 9	;@015A9
	mov	cl, byte ptr es:[9]	;@015AF
	rol	cl, 1	;@015B4
	and	cx, 1	;@015B6
	add	cl, byte ptr es:[6]	;@015B9
	push	si	;@015BE
	push	es	;@015BF
	mov	ax, word ptr es:[4]	;@015C0
	xor	bp, bp	;@015C4
	call	far ptr L12694	;@015C6
	pop	es	;@015CB
	pop	si	;@015CC
	mov	word ptr es:[0Eh], ax	;@015CD
@@1:	ret	;@015D1
	db	26h, 8Ah, 3Eh, 7, 0, 80h, 0E7h, 3Fh, 74h, 0Bh, 80h, 0FFh, 0Ch	;@015D2
	db	74h, 5, 80h, 0FFh, 8, 75h, 6, 0C3h, 0B7h, 1, 0E9h, 0B2h, 1Bh, 0E9h
	db	96h, 1Bh, 26h, 8Ah, 1Eh, 7, 0, 80h, 0E3h, '?tB', 80h, 0FBh, 8
	db	75h, 1Ch, 0F7h, 6, 60h, 51h, 0, 10h, 'u-P', 0E8h, 0E2h, 4, 5Bh
	db	6, 8Eh, 0C0h, 0BFh, 8, 0, 8Bh, 0C3h, 0E8h, 96h, 3Fh, 7, 75h, 1Ah
	db	0C3h, 0F6h, 6, 0D7h, 38h, 0Ch, 75h, 0Ch, 6, 50h, 0BFh, 0Eh, 0
	db	0E8h, 83h, 3Fh, 58h, 7, 75h, 6, 0BFh, 0Eh, 0, 0E9h, 0D6h, 3Fh
L01633:	mov	di, es	;@01633
	mov	cx, 1017h	;@01635
	jmp	L03208	;@01638
	db	26h, 80h, 0Eh, 7, 0, 0Ch, 0BFh, 0Eh, 0, 0E9h, 0Fh, 40h	;@0163B
L01647:	mov	di, 0Eh	;@01647
	jmp	L056C3	;@0164A
	db	26h, 8Ah, 3Eh, 7, 0, 80h, 0E7h, 3Fh, 74h, 6, 80h, 0FFh, 0Eh, 75h	;@0164D
	db	6, 0C3h, 0B7h, 5, 0E9h, 3Ch, 1Bh, 0E9h, 20h, 1Bh, 8Ch, 0C7h, 3Bh
	db	0C7h, 75h, 6, 0B9h, 34h, 10h, 0E9h, 97h, 1Bh, 50h, 0BBh, 55h, 1Ah
	db	26h, 0F6h, 6, 7, 0, 3Fh, 75h, 9, 26h, 80h, 0Eh, 7, 0, 0Eh, 0BBh
	db	2Fh, 1Ah, 0FFh, 0D3h, 5Bh, 8Eh, 0C0h, 26h, 0F6h, 6, 6, 0, 1, 74h
	db	16h, 0F6h, 6, 0D7h, 38h, 0Ch, 75h, 15h, 26h, 3Bh, 1Eh, 8, 0, 74h
	db	13h, 8Ch, 0C7h, 0B9h, 17h, 10h, 0E9h, 5Fh, 1Bh, 26h, 80h, 0Eh
	db	6, 0, 1, 26h, 89h, 1Eh, 8, 0, 0C3h
L016B5:	call	L01AEC	;@016B5
	mov	es, ax	;@016B8
	test	byte ptr es:[6], 1	;@016BA
	mov	ax, word ptr es:[8]	;@016C0
	ret	;@016C4
L016C5:	mov	bh, byte ptr es:[7]	;@016C5
	and	bh, 3Fh	;@016CA
	je	@@1	;@016CD
	cmp	bh, 1	;@016CF
	jne	@@3	;@016D2
	ret	;@016D4
@@1:	mov	bh, 3	;@016D5
	call	L0319E	;@016D7
	test	word ptr ds:[5160h], 1000h	;@016DA
	jne	@@2	;@016E0
	mov	ax, word ptr es:[0Ch]	;@016E2
	call	L05702	;@016E6
	jb	@@2	;@016E9
	xor	al, al	;@016EB
	dec	al	;@016ED
	ret	;@016EF
@@2:	xor	al, al	;@016F0
	ret	;@016F2
@@3:	jmp	L03185	;@016F3
L016F6:	mov	word ptr ds:[3E0Ah], bx	;@016F6
	add	bx, cx	;@016FA
	mov	byte ptr [bx], 0Dh	;@016FC
	xor	ax, ax	;@016FF
	mov	word ptr ds:[4E0Eh], ax	;@01701
	mov	byte ptr ds:[4E16h], al	;@01704
	push	cx	;@01707
	mov	bx, 1A55h	;@01708
	test	byte ptr es:[7], 3Fh	;@0170B
	jne	@@1	;@01711
	or	byte ptr es:[7], 1	;@01713
	mov	bx, 1A2Fh	;@01719
@@1:	call	bx	;@0171C
	pop	cx	;@0171E
	mov	di, es	;@0171F
	mov	es, ax	;@01721
	test	byte ptr es:[6], 1	;@01723
	je	@@7	;@01729
	test	byte ptr ds:[38D7h], 0Ch	;@0172B
	jne	@@4	;@01730
	cmp	cx, word ptr es:[0Eh]	;@01732
	jne	@@3	;@01737
	jcxz	@@2	;@01739
	mov	ax, word ptr es:[0Ch]	;@0173B
	push	di	;@0173F
	call	far ptr L0FCE0	;@01740
	mov	si, word ptr ds:[3E0Ah]	;@01745
	repe cmpsb	;@01749
	pop	di	;@0174B
	jne	@@3	;@0174C
@@2:	ret	;@0174E
@@3:	mov	cx, 1017h	;@0174F
	jmp	L03208	;@01752
@@4:	push	cx	;@01755
	mov	dx, word ptr es:[0Eh]	;@01756
	and	dx, dx	;@0175B
	je	@@5	;@0175D
	mov	ax, word ptr es:[0Ch]	;@0175F
	call	far ptr L0FC4F	;@01763
@@5:	mov	dx, word ptr es:[0Ah]	;@01768
	and	dx, dx	;@0176D
	je	@@6	;@0176F
	mov	ax, word ptr es:[8]	;@01771
	call	far ptr L0FC4F	;@01775
@@6:	pop	cx	;@0177A
@@7:	or	byte ptr es:[6], 1	;@0177B
	xor	ax, ax	;@01781
	mov	word ptr es:[8], ax	;@01783
	mov	word ptr es:[0Ah], ax	;@01787
	mov	word ptr es:[0Eh], cx	;@0178B
	jcxz	@@8	;@01790
	mov	ax, cx	;@01792
	push	es	;@01794
	call	far ptr L0FB8D	;@01795
	mov	si, word ptr ds:[3E0Ah]	;@0179A
	shr	cx, 1	;@0179E
	rep movsw	;@017A0
	rcl	cx, 1	;@017A2
	rep movsb	;@017A4
	pop	es	;@017A6
	mov	word ptr es:[0Ch], ax	;@017A7
@@8:	xor	si, si	;@017AB
	mov	byte ptr ds:[39B8h], 0Ah	;@017AD
@@9:	call	L026B8	;@017B2
	jne	@@10	;@017B5
	add	si, 2	;@017B7
	jmp	@@9	;@017BA
@@10:	mov	byte ptr ds:[39B8h], 0	;@017BC
	mov	ax, si	;@017C1
	mov	word ptr es:[0Ah], ax	;@017C3
	mov	cx, ax	;@017C7
	push	es	;@017C9
	call	far ptr L0FB8D	;@017CA
	mov	si, 460Eh	;@017CF
	shr	cx, 1	;@017D2
	rep movsw	;@017D4
	pop	es	;@017D6
	mov	word ptr es:[8], ax	;@017D7
	ret	;@017DB
L017DC:	push	ax	;@017DC
	mov	bx, 1A55h	;@017DD
	test	byte ptr es:[7], 3Fh	;@017E0
	jne	@@1	;@017E6
	or	byte ptr es:[7], 1	;@017E8
	mov	bx, 1A2Fh	;@017EE
@@1:	call	bx	;@017F1
	pop	dx	;@017F3
	mov	di, es	;@017F4
	mov	es, ax	;@017F6
	test	byte ptr es:[6], 1	;@017F8
	je	@@5	;@017FE
	test	byte ptr ds:[38D7h], 0Ch	;@01800
	jne	@@3	;@01805
	cmp	word ptr es:[0Ah], 2	;@01807
	jne	@@2	;@0180D
	mov	ax, word ptr es:[8]	;@0180F
	push	di	;@01813
	call	far ptr L0FCE0	;@01814
	cmp	dx, word ptr es:[di]	;@01819
	pop	di	;@0181C
	je	@@6	;@0181D
@@2:	mov	cx, 1017h	;@0181F
	jmp	L03208	;@01822
@@3:	push	dx	;@01825
	mov	dx, word ptr es:[0Ah]	;@01826
	and	dx, dx	;@0182B
	je	@@4	;@0182D
	mov	ax, word ptr es:[8]	;@0182F
	call	far ptr L0FC4F	;@01833
@@4:	pop	dx	;@01838
@@5:	or	byte ptr es:[6], 1	;@01839
	mov	ax, 2	;@0183F
	mov	word ptr es:[0Ah], ax	;@01842
	push	es	;@01846
	call	far ptr L0FB8D	;@01847
	mov	word ptr es:[di], dx	;@0184C
	pop	es	;@0184F
	mov	word ptr es:[8], ax	;@01850
	push	es	;@01854
	mov	es, dx	;@01855
	mov	cl, byte ptr es:[6]	;@01857
	xor	ch, ch	;@0185C
	les	di, dword ptr es:[0]	;@0185E
	call	far ptr L0FCFE	;@01863
	pop	es	;@01868
	mov	word ptr es:[0Ch], ax	;@01869
	mov	word ptr es:[0Eh], cx	;@0186D
@@6:	ret	;@01872
L01873:	call	L01AEC	;@01873
	mov	es, ax	;@01876
	test	byte ptr es:[6], 1	;@01878
	je	@@1	;@0187E
	mov	ax, word ptr es:[0Ch]	;@01880
	mov	cx, word ptr es:[0Eh]	;@01884
@@1:	ret	;@01889
L0188A:	and	byte ptr es:[7], 0BFh	;@0188A
	mov	bh, byte ptr es:[7]	;@01890
	and	bh, 3Fh	;@01895
	je	@@1	;@01898
	cmp	bh, 7	;@0189A
	jne	@@2	;@0189D
	ret	;@0189F
@@1:	mov	bh, 1	;@018A0
	jmp	L0319E	;@018A2
@@2:	jmp	L03185	;@018A5
L018A8:	push	ax	;@018A8
	mov	bx, 1A55h	;@018A9
	test	byte ptr es:[7], 3Fh	;@018AC
	jne	@@1	;@018B2
	or	byte ptr es:[7], 7	;@018B4
	mov	bx, 1A2Fh	;@018BA
@@1:	call	bx	;@018BD
	mov	di, es	;@018BF
	mov	es, ax	;@018C1
	pop	ax	;@018C3
	test	byte ptr es:[6], 1	;@018C4
	je	@@3	;@018CA
	test	byte ptr ds:[38D7h], 0Ch	;@018CC
	jne	@@2	;@018D1
	push	es	;@018D3
	push	ax	;@018D4
	push	di	;@018D5
	mov	di, 8	;@018D6
	call	L055AC	;@018D9
	pop	di	;@018DC
	pop	ax	;@018DD
	pop	es	;@018DE
	je	@@2	;@018DF
	mov	cx, 1017h	;@018E1
	call	L03208	;@018E4
@@2:	mov	di, 8	;@018E7
	jmp	L05609	;@018EA
@@3:	or	byte ptr es:[6], 1	;@018ED
	mov	di, 8	;@018F3
	jmp	L05656	;@018F6
L018F9:	call	L01AEC	;@018F9
	mov	es, ax	;@018FC
	test	byte ptr es:[6], 1	;@018FE
	je	@@1	;@01904
	mov	di, 8	;@01906
	call	L056C3	;@01909
	xor	bl, bl	;@0190C
	dec	bl	;@0190E
@@1:	ret	;@01910
L01911:	mov	bh, byte ptr es:[7]	;@01911
	and	bh, 3Fh	;@01916
	je	@@2	;@01919
	cmp	bh, 8	;@0191B
	je	@@1	;@0191E
	cmp	bh, 0Ch	;@01920
	jne	@@3	;@01923
@@1:	ret	;@01925
@@2:	mov	bh, 1	;@01926
	jmp	L0319E	;@01928
@@3:	jmp	L03185	;@0192B
L0192E:	push	ax	;@0192E
	mov	al, byte ptr es:[7]	;@0192F
	mov	bx, 1A55h	;@01933
	and	al, 3Fh	;@01936
	je	@@2	;@01938
	cmp	al, 8	;@0193A
	je	@@3	;@0193C
	pop	bx	;@0193E
	test	word ptr ds:[5160h], 1000h	;@0193F
	jne	@@1	;@01945
	push	es	;@01947
	mov	di, 0Eh	;@01948
	mov	ax, bx	;@0194B
	call	L055AC	;@0194D
	pop	es	;@01950
	jne	@@1	;@01951
	ret	;@01953
@@1:	mov	di, es	;@01954
	jmp	short @@4	;@01956
@@2:	or	byte ptr es:[7], 8	;@01958
	mov	bx, 1A2Fh	;@0195E
@@3:	call	bx	;@01961
	mov	di, es	;@01963
	mov	es, ax	;@01965
	pop	ax	;@01967
	test	byte ptr es:[6], 1	;@01968
	je	@@6	;@0196E
	test	byte ptr ds:[38D7h], 0Ch	;@01970
	jne	@@5	;@01975
	push	es	;@01977
	push	ax	;@01978
	push	di	;@01979
	mov	di, 8	;@0197A
	call	L055AC	;@0197D
	pop	di	;@01980
	pop	ax	;@01981
	pop	es	;@01982
	je	@@5	;@01983
@@4:	mov	cx, 1017h	;@01985
	jmp	L03208	;@01988
@@5:	mov	di, 8	;@0198B
	jmp	L05609	;@0198E
@@6:	or	byte ptr es:[6], 1	;@01991
	mov	di, 8	;@01997
	jmp	L05656	;@0199A
L0199D:	mov	al, byte ptr es:[7]	;@0199D
	test	al, 20h	;@019A1
	jne	@@3	;@019A3
	and	al, 1Fh	;@019A5
	cmp	al, 5	;@019A7
	jne	@@1	;@019A9
	mov	ax, word ptr es:[0Eh]	;@019AB
	ret	;@019AF
@@1:	cmp	al, 6	;@019B0
	jne	@@2	;@019B2
	mov	ax, word ptr es:[0Eh]	;@019B4
	ret	;@019B8
@@2:	mov	ax, word ptr es:[0Eh]	;@019B9
	ret	;@019BD
@@3:	mov	ax, word ptr es:[10h]	;@019BE
	ret	;@019C2
L019C3:	test	byte ptr es:[6], 1	;@019C3
	je	@@6	;@019C9
	push	es	;@019CB
	mov	cx, word ptr es:[0Ah]	;@019CC
@@1:	jcxz	@@2	;@019D1
	mov	es, cx	;@019D3
	mov	ax, cx	;@019D5
	mov	cx, word ptr es:[0]	;@019D7
	mov	dx, 1	;@019DC
	call	far ptr L0FAA6	;@019DF
	jmp	@@1	;@019E4
@@2:	pop	es	;@019E6
	push	es	;@019E7
	mov	cx, word ptr es:[8]	;@019E8
@@3:	jcxz	@@5	;@019ED
	mov	es, cx	;@019EF
	mov	bx, 4	;@019F1
	mov	cl, byte ptr es:[2]	;@019F4
	xor	ch, ch	;@019F9
@@4:	mov	ax, word ptr es:[bx]	;@019FB
	mov	dl, byte ptr es:[bx+2]	;@019FE
	xor	dh, dh	;@01A02
	call	far ptr L0FC4F	;@01A04
	add	bx, 3	;@01A09
	loop	@@4	;@01A0C
	mov	cx, word ptr es:[0]	;@01A0E
	mov	ax, es	;@01A13
	mov	dx, 1	;@01A15
	call	far ptr L0FAA6	;@01A18
	jmp	@@3	;@01A1D
@@5:	pop	es	;@01A1F
@@6:	xor	ax, ax	;@01A20
	mov	word ptr es:[8], ax	;@01A22
	mov	word ptr es:[0Ah], ax	;@01A26
	mov	byte ptr es:[6], al	;@01A2A
	ret	;@01A2E
L01A2F:	mov	ax, es	;@01A2F
	inc	ax	;@01A31
L01A32:	push	es	;@01A32
	push	ax	;@01A33
	mov	es, ax	;@01A34
	mov	ax, word ptr ds:[5152h]	;@01A36
	mov	word ptr es:[2], ax	;@01A39
	mov	ax, word ptr ds:[515Eh]	;@01A3D
	mov	word ptr es:[0], ax	;@01A40
	xor	ax, ax	;@01A44
	mov	byte ptr es:[6], al	;@01A46
	mov	word ptr es:[4], ax	;@01A4A
	pop	ax	;@01A4E
	pop	es	;@01A4F
	mov	word ptr es:[0Eh], ax	;@01A50
	ret	;@01A54
L01A55:	test	byte ptr ds:[38D7h], 0Fh	;@01A55
	jne	L01A6E	;@01A5A
	mov	bx, word ptr es:[0Eh]	;@01A5C
L01A61:	push	es	;@01A61
L01A62:	call	L01B6D	;@01A62
	mov	es, bx	;@01A65
L01A67:	mov	word ptr es:[4], ax	;@01A67
	pop	es	;@01A6B
	jmp	L01A32	;@01A6C
L01A6E:	mov	ax, word ptr ds:[5152h]	;@01A6E
	mov	dx, word ptr ds:[515Eh]	;@01A71
	push	es	;@01A75
	mov	cx, word ptr es:[0Eh]	;@01A76
	jcxz	@@4	;@01A7B
	mov	es, cx	;@01A7D
@@1:	mov	bx, es	;@01A7F
	mov	cx, word ptr es:[4]	;@01A81
	jcxz	L01A62	;@01A86
	mov	es, cx	;@01A88
	mov	di, word ptr es:[0]	;@01A8A
	mov	cx, word ptr es:[2]	;@01A8F
	call	far ptr L11788	;@01A94
	je	@@3	;@01A99
	jae	@@1	;@01A9B
	mov	ax, es	;@01A9D
	pop	es	;@01A9F
	push	ax	;@01AA0
	call	L01A61	;@01AA1
@@2:	pop	cx	;@01AA4
	push	es	;@01AA5
	mov	es, ax	;@01AA6
	mov	word ptr es:[4], cx	;@01AA8
	pop	es	;@01AAD
	ret	;@01AAE
@@3:	mov	ax, es	;@01AAF
	pop	es	;@01AB1
	mov	word ptr es:[0Eh], ax	;@01AB2
	ret	;@01AB6
@@4:	pop	es	;@01AB7
	push	es	;@01AB8
	mov	cx, es	;@01AB9
	inc	cx	;@01ABB
	mov	es, cx	;@01ABC
	mov	di, word ptr es:[0]	;@01ABE
	mov	cx, word ptr es:[2]	;@01AC3
	call	far ptr L11788	;@01AC8
	je	@@3	;@01ACD
	jae	@@1	;@01ACF
	call	L01B6D	;@01AD1
	push	si	;@01AD4
	xor	si, si	;@01AD5
	push	es	;@01AD7
	pop	ds	;@01AD8
	mov	es, ax	;@01AD9
	xor	di, di	;@01ADB
	mov	cx, 8	;@01ADD
	rep movsw	;@01AE0
	push	ss	;@01AE2
	pop	ds	;@01AE3
	pop	si	;@01AE4
	pop	es	;@01AE5
	push	ax	;@01AE6
	call	L01A2F	;@01AE7
	jmp	@@2	;@01AEA
L01AEC:	test	byte ptr ds:[38D7h], 0Fh	;@01AEC
	jne	@@3	;@01AF1
	mov	ax, word ptr es:[0Eh]	;@01AF3
	ret	;@01AF7
@@1:	mov	cx, word ptr es:[0Eh]	;@01AF8
	jcxz	@@2	;@01AFD
	mov	ax, cx	;@01AFF
	ret	;@01B01
@@2:	push	es	;@01B02
	mov	ax, es	;@01B03
	inc	ax	;@01B05
	mov	es, ax	;@01B06
	jmp	short @@7	;@01B08
@@3:	test	byte ptr ds:[38D7h], 8	;@01B0A
	jne	@@1	;@01B0F
	mov	ax, word ptr ds:[5152h]	;@01B11
	mov	dx, word ptr ds:[515Eh]	;@01B14
	mov	cx, word ptr es:[0Eh]	;@01B18
	push	es	;@01B1D
	jcxz	@@6	;@01B1E
	mov	es, cx	;@01B20
@@4:	mov	cx, word ptr es:[4]	;@01B22
	mov	bx, es	;@01B27
	jcxz	@@5	;@01B29
	mov	es, cx	;@01B2B
	mov	di, word ptr es:[0]	;@01B2D
	mov	cx, word ptr es:[2]	;@01B32
	call	far ptr L11788	;@01B37
	ja	@@4	;@01B3C
@@5:	mov	ax, bx	;@01B3E
	pop	es	;@01B40
	mov	word ptr es:[0Eh], ax	;@01B41
	ret	;@01B45
@@6:	pop	es	;@01B46
	push	es	;@01B47
	mov	cx, es	;@01B48
	inc	cx	;@01B4A
	mov	es, cx	;@01B4B
	mov	di, word ptr es:[0]	;@01B4D
	mov	cx, word ptr es:[2]	;@01B52
	call	far ptr L11788	;@01B57
	jae	@@4	;@01B5C
@@7:	mov	cx, word ptr es:[4]	;@01B5E
	jcxz	@@8	;@01B63
	mov	es, cx	;@01B65
	jmp	@@7	;@01B67
@@8:	mov	ax, es	;@01B69
	pop	es	;@01B6B
	ret	;@01B6C
L01B6D:	cmp	word ptr ds:[39AEh], 0	;@01B6D
	jne	@@1	;@01B72
	mov	ax, 1	;@01B74
	mov	cx, 40h	;@01B77
	call	far ptr L0FB18	;@01B7A
	mov	word ptr ds:[39AEh], cx	;@01B7F
	mov	word ptr ds:[39ACh], ax	;@01B83
@@1:	mov	ax, word ptr ds:[39ACh]	;@01B86
	add	word ptr ds:[39ACh], 1	;@01B89
	sub	word ptr ds:[39AEh], 1	;@01B8E
	ret	;@01B93
L01B94:	xor	ax, ax	;@01B94
	mov	byte ptr ds:[4E16h], al	;@01B96
	mov	word ptr ds:[4E0Eh], ax	;@01B99
	ret	;@01B9C
L01B9D:	mov	di, 3E0Ch	;@01B9D
	push	ss	;@01BA0
	pop	es	;@01BA1
	mov	cx, ax	;@01BA2
	mov	al, 40h	;@01BA4
	stosb	;@01BA6
	mov	dx, 2710h	;@01BA7
	mov	ah, 30h	;@01BAA
	call	@@1	;@01BAC
	mov	dx, 3E8h	;@01BAF
	call	@@1	;@01BB2
	mov	dx, 64h	;@01BB5
	call	@@1	;@01BB8
	mov	dx, 0Ah	;@01BBB
	call	@@1	;@01BBE
	mov	dx, 1	;@01BC1
	mov	ah, 0FFh	;@01BC4
	call	@@1	;@01BC6
	mov	cx, di	;@01BC9
	mov	bx, 3E0Ch	;@01BCB
	sub	cx, bx	;@01BCE
	jmp	L003E8	;@01BD0
@@1:	mov	al, 2Fh	;@01BD3
@@2:	inc	al	;@01BD5
	sub	cx, dx	;@01BD7
	jae	@@2	;@01BD9
	add	cx, dx	;@01BDB
	cmp	al, ah	;@01BDD
	je	@@3	;@01BDF
	stosb	;@01BE1
	mov	ah, 0FFh	;@01BE2
@@3:	ret	;@01BE4
L01BE5:	push	si	;@01BE5
	mov	bx, 742h	;@01BE6
	mov	si, word ptr ds:[3E0Ah]	;@01BE9
@@1:	mov	al, byte ptr [si]	;@01BED
	xlat	;@01BEF
	test	al, 2	;@01BF0
	je	@@2	;@01BF2
	inc	si	;@01BF4
	jmp	@@1	;@01BF5
@@2:	test	al, 1	;@01BF7
	jne	@@5	;@01BF9
	mov	dx, si	;@01BFB
@@3:	test	al, 1	;@01BFD
	jne	@@6	;@01BFF
	mov	cx, si	;@01C01
@@4:	inc	si	;@01C03
	mov	al, byte ptr [si]	;@01C04
	xlat	;@01C06
	test	al, 2	;@01C07
	jne	@@4	;@01C09
	jmp	@@3	;@01C0B
@@5:	mov	word ptr ds:[3E0Ah], si	;@01C0D
	mov	cx, 0	;@01C11
	pop	si	;@01C14
	ret	;@01C15
@@6:	inc	cx	;@01C16
	mov	word ptr ds:[3E0Ah], si	;@01C17
	pop	si	;@01C1B
	mov	bx, dx	;@01C1C
	sub	cx, bx	;@01C1E
	xor	al, al	;@01C20
	ret	;@01C22
L01C23:	push	si	;@01C23
	mov	bx, 742h	;@01C24
	mov	si, word ptr ds:[3E0Ah]	;@01C27
@@1:	mov	al, byte ptr [si]	;@01C2B
	xlat	;@01C2D
	test	al, 2	;@01C2E
	je	@@2	;@01C30
	inc	si	;@01C32
	jmp	@@1	;@01C33
@@2:	mov	dx, si	;@01C35
@@3:	test	al, 1	;@01C37
	jne	@@5	;@01C39
@@4:	inc	si	;@01C3B
	mov	al, byte ptr [si]	;@01C3C
	xlat	;@01C3E
	jmp	@@3	;@01C3F
@@5:	cmp	byte ptr [si], 3Bh	;@01C41
	je	@@4	;@01C44
	mov	word ptr ds:[3E0Ah], si	;@01C46
	mov	cx, si	;@01C4A
	pop	si	;@01C4C
	mov	bx, dx	;@01C4D
	sub	cx, bx	;@01C4F
	ret	;@01C51
L01C52:	push	si	;@01C52
@@1:	mov	bx, 742h	;@01C53
	mov	si, word ptr ds:[3E0Ah]	;@01C56
@@2:	lodsb	;@01C5A
	xlat	;@01C5B
	test	al, 2	;@01C5C
	jne	@@2	;@01C5E
	dec	si	;@01C60
	and	al, al	;@01C61
	je	@@4	;@01C63
	mov	dx, si	;@01C65
	cmp	byte ptr [si], 3Ch	;@01C67
	jne	@@7	;@01C6A
	inc	dx	;@01C6C
@@3:	inc	si	;@01C6D
	mov	al, byte ptr [si]	;@01C6E
	cmp	al, 3Eh	;@01C70
	je	@@5	;@01C72
	xlat	;@01C74
	test	al, 1	;@01C75
	je	@@3	;@01C77
	mov	cx, si	;@01C79
	mov	word ptr ds:[3E0Ah], si	;@01C7B
	jmp	short @@6	;@01C7F
@@4:	push	es	;@01C81
	call	L02697	;@01C82
	pop	es	;@01C85
	jmp	@@1	;@01C86
@@5:	mov	cx, si	;@01C88
	inc	si	;@01C8A
	mov	word ptr ds:[3E0Ah], si	;@01C8B
@@6:	pop	si	;@01C8F
	mov	bx, dx	;@01C90
	sub	cx, bx	;@01C92
	xor	al, al	;@01C94
	ret	;@01C96
@@7:	pop	si	;@01C97
	push	word ptr ds:[3E0Ah]	;@01C98
	call	L01D7A	;@01C9C
	pop	cx	;@01C9F
	push	es	;@01CA0
	jne	@@8	;@01CA1
	and	ah, ah	;@01CA3
	je	@@8	;@01CA5
	mov	es, dx	;@01CA7
	mov	al, byte ptr es:[7]	;@01CA9
	and	al, 3Fh	;@01CAD
	jne	@@12	;@01CAF
	or	byte ptr es:[10h], 2	;@01CB1
@@8:	pop	es	;@01CB7
	mov	word ptr ds:[3E0Ah], cx	;@01CB8
	mov	word ptr ds:[4E0Eh], si	;@01CBC
	mov	byte ptr ds:[4E16h], 0	;@01CC0
	push	si	;@01CC5
	mov	si, cx	;@01CC6
	mov	bx, 742h	;@01CC8
@@9:	mov	al, byte ptr [si]	;@01CCB
	xlat	;@01CCD
	test	al, 2	;@01CCE
	je	@@10	;@01CD0
	inc	si	;@01CD2
	jmp	@@9	;@01CD3
@@10:	cmp	byte ptr [si], 25h	;@01CD5
	jne	@@11	;@01CD8
	inc	si	;@01CDA
	mov	word ptr ds:[3E0Ah], si	;@01CDB
	pop	si	;@01CDF
	mov	di, 420Ch	;@01CE0
	push	di	;@01CE3
	call	L0251E	;@01CE4
	pop	bx	;@01CE7
	mov	cx, di	;@01CE8
	sub	cx, bx	;@01CEA
	xor	al, al	;@01CEC
	mov	word ptr ds:[4E0Eh], si	;@01CEE
	mov	byte ptr ds:[4E16h], al	;@01CF2
	ret	;@01CF5
@@11:	pop	si	;@01CF6
	ret	;@01CF7
@@12:	cmp	al, 1	;@01CF8
	jne	@@8	;@01CFA
	add	si, 2	;@01CFC
	call	L01AEC	;@01CFF
	mov	es, ax	;@01D02
	xor	cx, cx	;@01D04
	test	byte ptr es:[6], 1	;@01D06
	je	@@13	;@01D0C
	mov	ax, word ptr es:[0Ch]	;@01D0E
	mov	cx, word ptr es:[0Eh]	;@01D12
	call	far ptr L0FCE0	;@01D17
	push	ds	;@01D1C
	push	si	;@01D1D
	push	es	;@01D1E
	push	ds	;@01D1F
	pop	es	;@01D20
	pop	ds	;@01D21
	mov	si, di	;@01D22
	mov	di, 420Ch	;@01D24
	mov	bx, di	;@01D27
	push	cx	;@01D29
	shr	cx, 1	;@01D2A
	rep movsw	;@01D2C
	rcl	cx, 1	;@01D2E
	rep movsb	;@01D30
	pop	cx	;@01D32
	pop	si	;@01D33
	pop	ds	;@01D34
	xor	al, al	;@01D35
@@13:	pop	es	;@01D37
	ret	;@01D38
L01D39:	push	si	;@01D39
	mov	bx, 742h	;@01D3A
	mov	si, word ptr ds:[3E0Ah]	;@01D3D
@@1:	mov	al, byte ptr [si]	;@01D41
	xlat	;@01D43
	test	al, 2	;@01D44
	je	@@2	;@01D46
	inc	si	;@01D48
	jmp	@@1	;@01D49
@@2:	mov	dx, si	;@01D4B
@@3:	mov	al, byte ptr [si]	;@01D4D
	cmp	al, 2Ch	;@01D4F
	je	@@4	;@01D51
	xlat	;@01D53
	test	al, 3	;@01D54
	jne	@@4	;@01D56
	inc	si	;@01D58
	jmp	@@3	;@01D59
@@4:	mov	cx, si	;@01D5B
	mov	word ptr ds:[3E0Ah], si	;@01D5D
	pop	si	;@01D61
	mov	bx, dx	;@01D62
	sub	cx, bx	;@01D64
	je	@@5	;@01D66
	xor	al, al	;@01D68
	ret	;@01D6A
@@5:	xor	al, al	;@01D6B
	dec	al	;@01D6D
	ret	;@01D6F
L01D70:	mov	cx, word ptr ds:[3E0Ah]	;@01D70
	ret	;@01D74
L01D75:	or	byte ptr ds:[39B8h], 8	;@01D75
L01D7A:	or	byte ptr ds:[39B8h], 2	;@01D7A
	or	byte ptr ds:[39B8h], 1	;@01D7F
	call	L026B8	;@01D84
	mov	byte ptr ds:[39B8h], 0	;@01D87
	ret	;@01D8C
L01D8D:	mov	byte ptr ds:[39B8h], 4	;@01D8D
	call	L026B8	;@01D92
	mov	byte ptr ds:[39B8h], 0	;@01D95
	ret	;@01D9A
L01D9B:	test	byte ptr ds:[38D7h], 3	;@01D9B
	jne	@@1	;@01DA0
	test	word ptr ds:[38C4h], 1	;@01DA2
	jne	@@2	;@01DA8
	test	byte ptr ds:[516Bh], 40h	;@01DAA
	jne	@@2	;@01DAF
@@1:	ret	;@01DB1
@@2:	and	dh, dh	;@01DB2
	je	@@1	;@01DB4
	mov	es, dx	;@01DB6
	cmp	byte ptr es:[7], 0Bh	;@01DB8
	je	@@1	;@01DBE
	push	ax	;@01DC0
	push	si	;@01DC1
	mov	si, cx	;@01DC2
	mov	bx, 742h	;@01DC4
@@3:	lodsb	;@01DC7
	xlat	;@01DC8
	test	al, 2	;@01DC9
	jne	@@3	;@01DCB
	dec	si	;@01DCD
	push	es	;@01DCE
	les	di, dword ptr es:[0]	;@01DCF
	call	far ptr L0FCFE	;@01DD4
	pop	es	;@01DD9
	cmp	ax, word ptr es:[4]	;@01DDA
	jne	@@10	;@01DDF
	mov	bx, es	;@01DE1
	mov	al, byte ptr es:[6]	;@01DE3
	xor	ah, ah	;@01DE7
	mov	cx, ax	;@01DE9
	and	byte ptr es:[9], 7Fh	;@01DEB
	test	byte ptr ds:[516Bh], 40h	;@01DF1
	je	@@4	;@01DF6
	inc	al	;@01DF8
	or	byte ptr es:[9], 80h	;@01DFA
	call	far ptr L0FB8D	;@01E00
	mov	byte ptr es:[di], 5Fh	;@01E05
	inc	di	;@01E09
	jmp	short @@5	;@01E0A
@@4:	call	far ptr L0FB8D	;@01E0C
@@5:	push	es	;@01E11
	mov	es, bx	;@01E12
	mov	word ptr es:[4], ax	;@01E14
	pop	es	;@01E18
	mov	dx, bx	;@01E19
	mov	ax, word ptr ds:[38C4h]	;@01E1B
	and	ax, 3	;@01E1E
	cmp	ax, 3	;@01E21
	je	@@7	;@01E24
	and	ax, ax	;@01E26
	je	@@8	;@01E28
@@6:	rep movsb	;@01E2A
	jmp	short @@10	;@01E2C
@@7:	test	byte ptr ds:[516Bh], 40h	;@01E2E
	jne	@@6	;@01E33
	test	byte ptr ds:[516Bh], 10h	;@01E35
	je	@@6	;@01E3A
@@8:	mov	bx, 742h	;@01E3C
@@9:	lodsb	;@01E3F
	mov	ah, al	;@01E40
	xlat	;@01E42
	and	al, 20h	;@01E43
	sub	ah, al	;@01E45
	mov	al, ah	;@01E47
	stosb	;@01E49
	loop	@@9	;@01E4A
@@10:	pop	si	;@01E4C
	pop	ax	;@01E4D
	ret	;@01E4E
L01E4F:	test	byte ptr ds:[38D7h], 2	;@01E4F
	jne	@@1	;@01E54
	mov	word ptr ds:[3E0Ah], ax	;@01E56
	mov	word ptr ds:[4E0Eh], si	;@01E59
	mov	byte ptr ds:[4E16h], 0	;@01E5D
@@1:	ret	;@01E62
	db	0E8h, 2, 3, 0E8h, 23h, 3, 0E8h, 0CEh, 3, 0E8h, 0A4h, 3, 9Ah	;@01E63
	dd	L115CF
	db	0C3h
L01E75:	call	L02168	;@01E75
	mov	word ptr ds:[4E12h], 23E5h	;@01E78
	mov	word ptr ds:[4E14h], 2417h	;@01E7E
	call	L0223A	;@01E84
	call	far ptr L115CF	;@01E87
	ret	;@01E8C
L01E8D:	push	bx	;@01E8D
	push	dx	;@01E8E
	call	L02168	;@01E8F
	pop	dx	;@01E92
	pop	bx	;@01E93
@@1:	mov	ax, bx	;@01E94
	or	ax, dx	;@01E96
	je	@@2	;@01E98
	push	bx	;@01E9A
	push	dx	;@01E9B
	call	L0218C	;@01E9C
	call	L0223A	;@01E9F
	call	L02213	;@01EA2
	pop	dx	;@01EA5
	pop	bx	;@01EA6
	sub	bx, 1	;@01EA7
	sbb	dx, 0	;@01EAA
	jmp	@@1	;@01EAD
@@2:	call	far ptr L115CF	;@01EAF
	ret	;@01EB4
L01EB5:	push	si	;@01EB5
	push	es	;@01EB6
	push	ss	;@01EB7
	pop	es	;@01EB8
	mov	di, 420Ch	;@01EB9
	mov	si, word ptr ds:[3E0Ah]	;@01EBC
	mov	bx, 742h	;@01EC0
@@1:	lodsb	;@01EC3
	xlat	;@01EC4
	test	al, 2	;@01EC5
	jne	@@1	;@01EC7
	dec	si	;@01EC9
	cmp	byte ptr [si], 3Ch	;@01ECA
	jne	@@11	;@01ECD
	mov	dx, si	;@01ECF
	inc	dx	;@01ED1
	mov	ah, 1	;@01ED2
@@2:	inc	si	;@01ED4
@@3:	mov	al, byte ptr [si]	;@01ED5
	cmp	al, 3Ch	;@01ED7
	je	@@4	;@01ED9
	cmp	al, 3Eh	;@01EDB
	je	@@9	;@01EDD
	cmp	al, 21h	;@01EDF
	je	@@5	;@01EE1
	cmp	al, 22h	;@01EE3
	je	@@6	;@01EE5
	cmp	al, 27h	;@01EE7
	je	@@6	;@01EE9
	xlat	;@01EEB
	test	al, 1	;@01EEC
	je	@@2	;@01EEE
	mov	cx, si	;@01EF0
	mov	word ptr ds:[3E0Ah], si	;@01EF2
	jmp	short @@10	;@01EF6
@@4:	inc	ah	;@01EF8
	jmp	@@2	;@01EFA
@@5:	inc	si	;@01EFC
	mov	al, byte ptr [si]	;@01EFD
	cmp	al, 0Dh	;@01EFF
	jne	@@2	;@01F01
	jmp	@@3	;@01F03
@@6:	mov	ch, al	;@01F05
	inc	si	;@01F07
@@7:	lodsb	;@01F08
	cmp	al, 0Dh	;@01F09
	je	@@8	;@01F0B
	cmp	al, ch	;@01F0D
	jne	@@7	;@01F0F
	cmp	byte ptr [si], ch	;@01F11
	jne	@@3	;@01F13
	inc	si	;@01F15
	jmp	@@7	;@01F16
@@8:	dec	si	;@01F18
	mov	cx, si	;@01F19
	mov	word ptr ds:[3E0Ah], si	;@01F1B
	jmp	short @@10	;@01F1F
@@9:	dec	ah	;@01F21
	jne	@@2	;@01F23
	mov	cx, si	;@01F25
	inc	si	;@01F27
	mov	word ptr ds:[3E0Ah], si	;@01F28
@@10:	mov	bx, dx	;@01F2C
	sub	cx, bx	;@01F2E
	mov	word ptr ds:[460Ch], cx	;@01F30
	mov	si, bx	;@01F34
	shr	cx, 1	;@01F36
	rep movsw	;@01F38
	rcl	cx, 1	;@01F3A
	rep movsb	;@01F3C
	pop	es	;@01F3E
	pop	si	;@01F3F
	ret	;@01F40
@@11:	inc	si	;@01F41
	xor	cx, cx	;@01F42
@@12:	test	al, 1	;@01F44
	jne	@@13	;@01F46
	mov	al, byte ptr [si-1]	;@01F48
	stosb	;@01F4B
	inc	cx	;@01F4C
	lodsb	;@01F4D
	xlat	;@01F4E
	test	al, 2	;@01F4F
	je	@@12	;@01F51
@@13:	mov	word ptr ds:[460Ch], cx	;@01F53
	pop	es	;@01F57
	pop	si	;@01F58
	ret	;@01F59
L01F5A:	push	si	;@01F5A
	push	es	;@01F5B
	push	ss	;@01F5C
	pop	es	;@01F5D
	mov	di, 420Ch	;@01F5E
	mov	si, word ptr ds:[3E0Ah]	;@01F61
	mov	bx, 742h	;@01F65
@@1:	lodsb	;@01F68
	xlat	;@01F69
	test	al, 2	;@01F6A
	jne	@@1	;@01F6C
	dec	si	;@01F6E
	cmp	byte ptr [si], 3Ch	;@01F6F
	jne	@@6	;@01F72
	mov	dx, si	;@01F74
	inc	dx	;@01F76
	mov	ah, 1	;@01F77
@@2:	inc	si	;@01F79
	mov	al, byte ptr [si]	;@01F7A
	cmp	al, 3Ch	;@01F7C
	je	@@3	;@01F7E
	cmp	al, 3Eh	;@01F80
	je	@@4	;@01F82
	xlat	;@01F84
	test	al, 1	;@01F85
	je	@@2	;@01F87
	mov	cx, si	;@01F89
	mov	word ptr ds:[3E0Ah], si	;@01F8B
	jmp	short @@5	;@01F8F
@@3:	inc	ah	;@01F91
	jmp	@@2	;@01F93
@@4:	dec	ah	;@01F95
	jne	@@2	;@01F97
	mov	cx, si	;@01F99
	inc	si	;@01F9B
	mov	word ptr ds:[3E0Ah], si	;@01F9C
@@5:	mov	bx, dx	;@01FA0
	sub	cx, bx	;@01FA2
	mov	word ptr ds:[460Ch], cx	;@01FA4
	mov	si, bx	;@01FA8
	shr	cx, 1	;@01FAA
	rep movsw	;@01FAC
	rcl	cx, 1	;@01FAE
	rep movsb	;@01FB0
	pop	es	;@01FB2
	pop	si	;@01FB3
	ret	;@01FB4
@@6:	inc	si	;@01FB5
	xor	cx, cx	;@01FB6
@@7:	test	al, 1	;@01FB8
	jne	@@8	;@01FBA
	mov	al, byte ptr [si-1]	;@01FBC
	stosb	;@01FBF
	inc	cx	;@01FC0
	lodsb	;@01FC1
	xlat	;@01FC2
	test	al, 2	;@01FC3
	je	@@7	;@01FC5
@@8:	mov	word ptr ds:[460Ch], cx	;@01FC7
	pop	es	;@01FCB
	pop	si	;@01FCC
	ret	;@01FCD
L01FCE:	call	L02168	;@01FCE
	push	ss	;@01FD1
	pop	es	;@01FD2
	mov	si, 420Ch	;@01FD3
	mov	di, 3A0Ah	;@01FD6
	mov	cx, word ptr ds:[460Ch]	;@01FD9
	mov	word ptr ds:[3E0Ah], di	;@01FDD
@@1:	jcxz	@@7	;@01FE1
@@2:	lodsb	;@01FE3
	cmp	al, 20h	;@01FE4
	ja	@@4	;@01FE6
	loop	@@2	;@01FE8
	jmp	short @@7	;@01FEA
@@3:	call	far ptr L115CF	;@01FEC
	ret	;@01FF1
@@4:	dec	si	;@01FF2
	cmp	al, 3Ch	;@01FF3
	je	@@6	;@01FF5
	cmp	al, 21h	;@01FF7
	je	@@6	;@01FF9
	mov	al, 3Ch	;@01FFB
	stosb	;@01FFD
	call	L0208E	;@01FFE
	mov	al, 3Eh	;@02001
	stosb	;@02003
@@5:	jcxz	@@7	;@02004
	lodsb	;@02006
	stosb	;@02007
	dec	cx	;@02008
	jmp	@@1	;@02009
@@6:	call	@@10	;@0200B
	jmp	@@5	;@0200E
@@7:	mov	al, 0Dh	;@02010
	stosb	;@02012
@@8:	mov	si, word ptr ds:[3E0Ah]	;@02013
	mov	bx, 742h	;@02017
@@9:	lodsb	;@0201A
	xlat	;@0201B
	test	al, 2	;@0201C
	jne	@@9	;@0201E
	test	al, 1	;@02020
	jne	@@3	;@02022
	dec	si	;@02024
	call	L0218C	;@02025
	call	L0223A	;@02028
	call	L02213	;@0202B
	jmp	@@8	;@0202E
@@10:	jcxz	@@11	;@02030
	xor	dl, dl	;@02032
	call	L0203A	;@02034
	jb	@@10	;@02037
@@11:	ret	;@02039
L0203A:	and	dl, dl	;@0203A
	jne	@@1	;@0203C
	cmp	byte ptr [si], 2Ch	;@0203E
	je	L0205B	;@02041
@@1:	lodsb	;@02043
	cmp	al, 22h	;@02044
	je	L02074	;@02046
	cmp	al, 27h	;@02048
	je	L02074	;@0204A
	cmp	al, 21h	;@0204C
	je	L0205D	;@0204E
	cmp	al, 3Ch	;@02050
	je	L02064	;@02052
	cmp	al, 3Eh	;@02054
	je	L02068	;@02056
L02058:	stosb	;@02058
	loop	L0203A	;@02059
L0205B:	clc	;@0205B
	ret	;@0205C
L0205D:	stosb	;@0205D
	dec	cx	;@0205E
	je	L0205B	;@0205F
	lodsb	;@02061
	jmp	L02058	;@02062
L02064:	inc	dl	;@02064
L02066:	jmp	L02058	;@02066
L02068:	and	dl, dl	;@02068
	je	L02058	;@0206A
	dec	dl	;@0206C
L0206E:	jne	L02058	;@0206E
	stosb	;@02070
	dec	cx	;@02071
	stc	;@02072
	ret	;@02073
L02074:	stosb	;@02074
	dec	cx	;@02075
	je	L0205B	;@02076
	mov	ah, al	;@02078
@@1:	lodsb	;@0207A
	cmp	al, ah	;@0207B
	je	@@2	;@0207D
	stosb	;@0207F
	loop	@@1	;@02080
	clc	;@02082
	ret	;@02083
@@2:	stosb	;@02084
	dec	cx	;@02085
	je	L0205B	;@02086
	cmp	byte ptr [si], al	;@02088
	jne	L0203A	;@0208A
	jmp	@@1	;@0208C
L0208E:	jcxz	@@4	;@0208E
@@1:	cmp	byte ptr [si], 2Ch	;@02090
	je	@@4	;@02093
	lodsb	;@02095
	cmp	al, 22h	;@02096
	je	@@7	;@02098
	cmp	al, 27h	;@0209A
	je	@@7	;@0209C
	cmp	al, 21h	;@0209E
	je	@@5	;@020A0
	cmp	al, 3Ch	;@020A2
	je	@@6	;@020A4
	cmp	al, 3Eh	;@020A6
	je	@@3	;@020A8
@@2:	stosb	;@020AA
@@3:	loop	@@1	;@020AB
@@4:	ret	;@020AD
@@5:	stosb	;@020AE
	dec	cx	;@020AF
	je	@@4	;@020B0
	lodsb	;@020B2
	jmp	@@2	;@020B3
@@6:	dec	cx	;@020B5
	jcxz	@@4	;@020B6
	mov	dl, 1	;@020B8
	call	L0203A	;@020BA
	jae	L0208E	;@020BD
	dec	di	;@020BF
	jmp	L0208E	;@020C0
@@7:	stosb	;@020C2
	dec	cx	;@020C3
	je	@@4	;@020C4
	mov	ah, al	;@020C6
@@8:	lodsb	;@020C8
	cmp	al, ah	;@020C9
	je	@@9	;@020CB
	stosb	;@020CD
	loop	@@8	;@020CE
	ret	;@020D0
@@9:	stosb	;@020D1
	dec	cx	;@020D2
	je	@@4	;@020D3
	cmp	byte ptr [si], al	;@020D5
	jne	L0208E	;@020D7
	jmp	@@8	;@020D9
L020DB:	call	L02168	;@020DB
	mov	si, 420Ch	;@020DE
	mov	di, 3A0Ah	;@020E1
	mov	cx, word ptr ds:[460Ch]	;@020E4
	mov	word ptr ds:[3E0Ah], di	;@020E8
	mov	bx, 742h	;@020EC
	jcxz	@@3	;@020EF
@@1:	lodsb	;@020F1
	cmp	al, 3Ch	;@020F2
	je	@@2	;@020F4
	cmp	al, 3Eh	;@020F6
	je	@@2	;@020F8
	mov	byte ptr [di], 21h	;@020FA
	mov	byte ptr [di+1], al	;@020FD
	mov	byte ptr [di+2], 2Ch	;@02100
	add	di, 3	;@02104
@@2:	loop	@@1	;@02107
	dec	di	;@02109
@@3:	mov	byte ptr [di], 0Dh	;@0210A
@@4:	mov	si, word ptr ds:[3E0Ah]	;@0210D
	mov	bx, 742h	;@02111
@@5:	mov	al, byte ptr [si]	;@02114
	xlat	;@02116
	test	al, 2	;@02117
	je	@@6	;@02119
	inc	si	;@0211B
	jmp	@@5	;@0211C
@@6:	test	al, 1	;@0211E
	jne	@@7	;@02120
	call	L0218C	;@02122
	call	L0223A	;@02125
	call	L02213	;@02128
	jmp	@@4	;@0212B
@@7:	call	far ptr L115CF	;@0212D
	ret	;@02132
L02133:	mov	di, 420Ch	;@02133
	mov	si, word ptr ds:[3E0Ah]	;@02136
	mov	bx, 742h	;@0213A
@@1:	lodsb	;@0213D
	xlat	;@0213E
	test	al, 2	;@0213F
	jne	@@1	;@02141
	dec	si	;@02143
	call	L0245C	;@02144
	mov	bx, 742h	;@02147
@@2:	lodsb	;@0214A
	xlat	;@0214B
	test	al, 2	;@0214C
	jne	@@2	;@0214E
	dec	si	;@02150
	test	al, 1	;@02151
	jne	@@3	;@02153
	cmp	byte ptr [si], 2Ch	;@02155
	jne	@@3	;@02158
	inc	si	;@0215A
@@3:	mov	word ptr ds:[3E0Ah], si	;@0215B
	sub	di, 420Ch	;@0215F
	mov	word ptr ds:[460Ch], di	;@02163
	ret	;@02167
L02168:	mov	word ptr ds:[4E12h], 2397h	;@02168
	mov	word ptr ds:[4E14h], 2408h	;@0216E
	mov	word ptr ds:[4E10h], es	;@02174
	mov	es, ax	;@02178
	mov	cl, byte ptr es:[6]	;@0217A
	xor	ch, ch	;@0217F
	les	di, dword ptr es:[0]	;@02181
	call	far ptr L11510	;@02186
	ret	;@0218B
L0218C:	mov	es, word ptr ds:[4E10h]	;@0218C
	mov	cx, word ptr es:[0Ah]	;@02190
@@1:	jcxz	@@4	;@02195
	mov	es, cx	;@02197
	cmp	byte ptr es:[8], 0	;@02199
	je	@@5	;@0219F
	mov	ax, 3F3Fh	;@021A1
	test	word ptr ds:[5160h], 8000h	;@021A4
	je	@@3	;@021AA
	push	es	;@021AC
	mov	es, word ptr es:[2]	;@021AD
	cmp	byte ptr es:[6], 1	;@021B2
	jbe	@@2	;@021B8
	les	di, dword ptr es:[0]	;@021BA
	mov	cx, word ptr ds:[5164h]	;@021BF
	cmp	cx, word ptr es:[di]	;@021C3
	jne	@@2	;@021C6
	mov	ax, cx	;@021C8
@@2:	pop	es	;@021CA
@@3:	mov	di, 420Ch	;@021CB
	mov	word ptr [di], ax	;@021CE
	add	di, 2	;@021D0
	mov	ax, word ptr ds:[5192h]	;@021D3
	call	L02438	;@021D6
	inc	word ptr ds:[5192h]	;@021D9
	mov	cx, di	;@021DD
	mov	si, 420Ch	;@021DF
	sub	cx, si	;@021E2
	jmp	short @@6	;@021E4
@@4:	ret	;@021E6
@@5:	push	es	;@021E7
	call	L02133	;@021E8
	pop	es	;@021EB
	mov	cx, word ptr ds:[460Ch]	;@021EC
	mov	si, 420Ch	;@021F0
@@6:	mov	word ptr es:[6], cx	;@021F3
	jcxz	@@7	;@021F8
	mov	ax, cx	;@021FA
	push	es	;@021FC
	call	far ptr L0FB8D	;@021FD
	inc	cx	;@02202
	shr	cx, 1	;@02203
	rep movsw	;@02205
	pop	es	;@02207
	mov	word ptr es:[4], ax	;@02208
@@7:	mov	cx, word ptr es:[0]	;@0220C
	jmp	@@1	;@02211
L02213:	mov	es, word ptr ds:[4E10h]	;@02213
	mov	cx, word ptr es:[0Ah]	;@02217
@@1:	jcxz	@@2	;@0221C
	mov	es, cx	;@0221E
	mov	cx, word ptr es:[0]	;@02220
	mov	dx, word ptr es:[6]	;@02225
	and	dx, dx	;@0222A
	je	@@1	;@0222C
	mov	ax, word ptr es:[4]	;@0222E
	call	far ptr L0FC4F	;@02232
	jmp	@@1	;@02237
@@2:	ret	;@02239
L0223A:	mov	es, word ptr ds:[4E10h]	;@0223A
	mov	cx, word ptr es:[8]	;@0223E
@@1:	jcxz	@@3	;@02243
	mov	es, cx	;@02245
	mov	cl, byte ptr es:[2]	;@02247
	xor	ch, ch	;@0224C
	mov	di, 4	;@0224E
@@2:	push	cx	;@02251
	push	di	;@02252
	push	es	;@02253
	mov	ax, word ptr es:[di]	;@02254
	call	far ptr L0FCE0	;@02257
	push	es	;@0225C
	pop	ds	;@0225D
	mov	si, di	;@0225E
	push	ss	;@02260
	pop	es	;@02261
	mov	di, 420Ch	;@02262
	call	@@4	;@02265
	push	ss	;@02268
	pop	ds	;@02269
	mov	bx, 420Ch	;@0226A
	call	far ptr L11570	;@0226D
	pop	es	;@02272
	pop	di	;@02273
	pop	cx	;@02274
	add	di, 3	;@02275
	loop	@@2	;@02278
	mov	cx, word ptr es:[0]	;@0227A
	jmp	@@1	;@0227F
@@3:	ret	;@02281
@@4:	mov	bx, 742h	;@02282
@@5:	lodsb	;@02285
@@6:	stosb	;@02286
	xlat	byte ptr ss:[bx]	;@02287
	test	al, 2	;@02289
	jne	@@5	;@0228B
	dec	di	;@0228D
	test	al, 80h	;@0228E
	jne	@@12	;@02290
	test	al, 40h	;@02292
	jne	@@15	;@02294
	test	al, 10h	;@02296
	jne	@@9	;@02298
	test	al, 4	;@0229A
	jne	@@11	;@0229C
	test	al, 1	;@0229E
	jne	@@18	;@022A0
@@7:	inc	di	;@022A2
	jmp	@@5	;@022A3
@@8:	lodsb	;@022A5
	cmp	al, 26h	;@022A6
	jne	@@6	;@022A8
	stosb	;@022AA
	jmp	@@8	;@022AB
@@9:	dec	si	;@022AD
@@10:	lodsb	;@022AE
	cmp	al, 26h	;@022AF
	je	@@6	;@022B1
	stosb	;@022B3
	xlat	byte ptr ss:[bx]	;@022B4
	test	al, 90h	;@022B6
	jne	@@10	;@022B8
	dec	si	;@022BA
	dec	di	;@022BB
	jmp	@@5	;@022BC
@@11:	test	word ptr ss:[5160h], 1000h	;@022BE
	jne	@@7	;@022C5
@@12:	cmp	byte ptr [si-1], 26h	;@022C7
	je	@@8	;@022CB
	dec	si	;@022CD
	push	di	;@022CE
	call	@@24	;@022CF
	pop	ax	;@022D2
	jcxz	@@5	;@022D3
	mov	di, ax	;@022D5
	call	@@27	;@022D7
	jmp	@@5	;@022DA
@@13:	mov	al, 0Dh	;@022DC
@@14:	stosb	;@022DE
	ret	;@022DF
@@15:	dec	si	;@022E0
	lodsb	;@022E1
	stosb	;@022E2
	mov	ah, al	;@022E3
@@16:	lodsb	;@022E5
	cmp	al, 0Dh	;@022E6
	je	@@14	;@022E8
	stosb	;@022EA
	cmp	al, 26h	;@022EB
	je	@@17	;@022ED
	cmp	al, ah	;@022EF
	jne	@@16	;@022F1
	lodsb	;@022F3
	cmp	al, ah	;@022F4
	jne	@@6	;@022F6
	stosb	;@022F8
	jmp	@@16	;@022F9
@@17:	push	ax	;@022FB
	call	@@21	;@022FC
	pop	ax	;@022FF
	jmp	@@16	;@02300
@@18:	dec	si	;@02302
	lodsb	;@02303
	cmp	al, 0Dh	;@02304
	je	@@14	;@02306
	stosb	;@02308
	lodsb	;@02309
	cmp	al, 3Bh	;@0230A
	je	@@13	;@0230C
	test	word ptr ss:[5160h], 1000h	;@0230E
	jne	@@19	;@02315
	jmp	@@6	;@02317
@@19:	stosb	;@0231A
@@20:	lodsb	;@0231B
	cmp	al, 0Dh	;@0231C
	je	@@14	;@0231E
	stosb	;@02320
	cmp	al, 26h	;@02321
	jne	@@20	;@02323
	call	@@21	;@02325
	jmp	@@20	;@02328
@@21:	mov	al, byte ptr [si]	;@0232A
	xlat	byte ptr ss:[bx]	;@0232C
	test	al, 80h	;@0232E
	je	@@23	;@02330
	push	di	;@02332
	call	@@24	;@02333
	pop	dx	;@02336
	jcxz	@@23	;@02337
	mov	di, dx	;@02339
	cmp	di, 420Ch	;@0233B
	je	@@22	;@0233F
	cmp	byte ptr es:[di-1], 26h	;@02341
	jne	@@22	;@02346
	dec	di	;@02348
@@22:	call	@@27	;@02349
	cmp	byte ptr [si], 26h	;@0234C
	jne	@@23	;@0234F
	inc	si	;@02351
@@23:	ret	;@02352
@@24:	mov	bp, di	;@02353
	lodsb	;@02355
	stosb	;@02356
@@25:	lodsb	;@02357
	cmp	al, 26h	;@02358
	je	@@26	;@0235A
	stosb	;@0235C
	xlat	byte ptr ss:[bx]	;@0235D
	test	al, 90h	;@0235F
	jne	@@25	;@02361
	dec	di	;@02363
@@26:	dec	si	;@02364
	push	ds	;@02365
	push	si	;@02366
	push	es	;@02367
	push	di	;@02368
	mov	cx, di	;@02369
	mov	si, bp	;@0236B
	sub	cx, si	;@0236D
	push	ss	;@0236F
	pop	ds	;@02370
	call	word ptr ds:[4E12h]	;@02371
	pop	di	;@02375
	pop	es	;@02376
	pop	si	;@02377
	pop	ds	;@02378
	ret	;@02379
@@27:	push	ds	;@0237A
	push	si	;@0237B
	push	es	;@0237C
	push	di	;@0237D
	push	ss	;@0237E
	pop	ds	;@0237F
	mov	es, cx	;@02380
	call	word ptr ds:[4E14h]	;@02382
	push	es	;@02386
	pop	ds	;@02387
	mov	si, di	;@02388
	pop	di	;@0238A
	pop	es	;@0238B
	shr	cx, 1	;@0238C
	rep movsw	;@0238E
	rcl	cx, 1	;@02390
	rep movsb	;@02392
	pop	si	;@02394
	pop	ds	;@02395
	ret	;@02396
	db	8Eh, 6, 10h, 4Eh, 8Bh, 0D1h, 26h, 8Bh, 0Eh, 0Ah, 0	;@02397
L023A2:	jcxz	L023E4	;@023A2
	mov	es, cx	;@023A4
	push	word ptr es:[0]	;@023A6
	mov	es, word ptr es:[2]	;@023AB
	cmp	dl, byte ptr es:[6]	;@023B0
	je	L023BA	;@023B5
L023B7:	pop	cx	;@023B7
	jmp	L023A2	;@023B8
L023BA:	push	cx	;@023BA
	mov	cx, dx	;@023BB
	les	di, dword ptr es:[0]	;@023BD
	push	si	;@023C2
	test	word ptr ds:[38C4h], 2	;@023C3
	je	@@1	;@023C9
	repe cmpsb	;@023CB
	jmp	short @@2	;@023CD
@@1:	lodsb	;@023CF
	mov	ah, al	;@023D0
	xlat	;@023D2
	and	al, 20h	;@023D3
	sub	ah, al	;@023D5
	mov	al, byte ptr es:[di]	;@023D7
	inc	di	;@023DA
	cmp	ah, al	;@023DB
	loope	@@1	;@023DD
@@2:	pop	si	;@023DF
	pop	cx	;@023E0
	jne	L023B7	;@023E1
	pop	ax	;@023E3
L023E4:	ret	;@023E4
	db	8Bh, 0DEh, 0E8h, 0FEh, 0DFh, 0BBh, 42h, 7, 8Eh, 0C2h, 33h, 0C9h	;@023E5
	db	26h, 0A0h, 7, 0, '$?u', 7, 26h, 80h, 0Eh, 10h, 0, 2, 0C3h
L02400:	cmp	al, 1	;@02400
	je	@@1	;@02402
	ret	;@02404
@@1:	mov	cx, dx	;@02405
	ret	;@02407
	db	26h, 0A1h, 4, 0, 26h, 8Bh, 0Eh, 6, 0, 9Ah	;@02408
	dd	L0FCE0
	db	0C3h, 53h, 0E8h, 0D1h, 0F6h, 5Bh, 8Eh, 0C0h, 26h, 0F6h, 6, 6, 0, 1, 74h, 0Fh
	db	26h, 0A1h, 0Ch, 0, 26h, 8Bh, 0Eh, 0Eh, 0, 9Ah
	dd	L0FCE0
	db	0C3h, 33h, 0C9h, 0C3h
L02438:	push	ax	;@02438
	mov	al, ah	;@02439
	call	@@1	;@0243B
	pop	ax	;@0243E
@@1:	mov	ah, al	;@0243F
	mov	cl, 4	;@02441
	shr	al, cl	;@02443
	call	@@2	;@02445
	mov	al, ah	;@02448
	and	al, 0Fh	;@0244A
@@2:	cmp	al, 0Ah	;@0244C
	jae	@@3	;@0244E
	add	al, 30h	;@02450
	mov	byte ptr [di], al	;@02452
	inc	di	;@02454
	ret	;@02455
@@3:	add	al, 37h	;@02456
	mov	byte ptr [di], al	;@02458
	inc	di	;@0245A
	ret	;@0245B
L0245C:	call	@@7	;@0245C
	mov	al, byte ptr [si]	;@0245F
	cmp	al, 3Ch	;@02461
	jne	@@1	;@02463
	inc	si	;@02465
	call	@@2	;@02466
	mov	al, byte ptr [si]	;@02469
	cmp	al, 3Eh	;@0246B
	jne	L0245C	;@0246D
	inc	si	;@0246F
	jmp	L0245C	;@02470
@@1:	ret	;@02472
@@2:	mov	al, byte ptr [si]	;@02473
	cmp	al, 3Ch	;@02475
	je	@@5	;@02477
	call	@@7	;@02479
@@3:	mov	al, byte ptr [si]	;@0247C
	cmp	al, 0Dh	;@0247E
	je	@@6	;@02480
	cmp	al, 3Eh	;@02482
	je	@@6	;@02484
	cmp	al, 21h	;@02486
	jb	@@4	;@02488
	cmp	al, 2Ch	;@0248A
	je	@@4	;@0248C
	cmp	al, 3Bh	;@0248E
	jne	@@2	;@02490
@@4:	inc	si	;@02492
	mov	byte ptr [di], al	;@02493
	inc	di	;@02495
	jmp	@@3	;@02496
@@5:	mov	byte ptr [di], al	;@02498
	inc	si	;@0249A
	inc	di	;@0249B
	call	@@2	;@0249C
	mov	al, byte ptr [si]	;@0249F
	cmp	al, 3Eh	;@024A1
	jne	@@2	;@024A3
	mov	byte ptr [di], al	;@024A5
	inc	di	;@024A7
	inc	si	;@024A8
	jmp	@@2	;@024A9
@@6:	ret	;@024AB
@@7:	mov	al, byte ptr [si]	;@024AC
	cmp	al, 22h	;@024AE
	je	@@9	;@024B0
	cmp	al, 27h	;@024B2
	je	@@9	;@024B4
	cmp	al, 25h	;@024B6
	je	@@12	;@024B8
	cmp	al, 21h	;@024BA
	je	@@11	;@024BC
	cmp	al, 3Bh	;@024BE
	je	@@8	;@024C0
	cmp	al, 2Ch	;@024C2
	je	@@8	;@024C4
	cmp	al, 21h	;@024C6
	cmc	;@024C8
	jae	@@8	;@024C9
	cmp	al, 3Ch	;@024CB
	je	@@8	;@024CD
	cmp	al, 3Eh	;@024CF
	je	@@8	;@024D1
	mov	byte ptr [di], al	;@024D3
	inc	di	;@024D5
	inc	si	;@024D6
	jmp	@@7	;@024D7
@@8:	ret	;@024D9
@@9:	mov	ah, al	;@024DA
	mov	byte ptr [di], al	;@024DC
	inc	di	;@024DE
	inc	si	;@024DF
@@10:	mov	al, byte ptr [si]	;@024E0
	cmp	al, 0Dh	;@024E2
	je	@@8	;@024E4
	inc	si	;@024E6
	mov	byte ptr [di], al	;@024E7
	inc	di	;@024E9
	cmp	al, ah	;@024EA
	jne	@@10	;@024EC
	mov	al, byte ptr [si]	;@024EE
	cmp	al, ah	;@024F0
	jne	@@7	;@024F2
	inc	si	;@024F4
	mov	byte ptr [di], al	;@024F5
	inc	di	;@024F7
	jmp	@@10	;@024F8
@@11:	inc	si	;@024FA
	mov	al, byte ptr [si]	;@024FB
	cmp	al, 0Dh	;@024FD
	je	@@8	;@024FF
	mov	byte ptr [di], al	;@02501
	inc	si	;@02503
	inc	di	;@02504
	jmp	@@7	;@02505
@@12:	xor	ax, ax	;@02507
	mov	byte ptr ds:[4E16h], al	;@02509
	mov	word ptr ds:[4E0Eh], ax	;@0250C
	inc	si	;@0250F
	mov	word ptr ds:[3E0Ah], si	;@02510
	mov	si, ax	;@02514
	call	L0251E	;@02516
	mov	si, word ptr ds:[3E0Ah]	;@02519
	ret	;@0251D
L0251E:	push	es	;@0251E
	push	bx	;@0251F
	push	di	;@02520
	call	L01D7A	;@02521
	jne	@@5	;@02524
	and	dh, dh	;@02526
	je	@@4	;@02528
	mov	es, dx	;@0252A
	mov	al, byte ptr es:[7]	;@0252C
	and	al, 3Fh	;@02530
	cmp	al, 1	;@02532
	jne	@@4	;@02534
	add	si, 2	;@02536
	call	L01AEC	;@02539
	mov	es, ax	;@0253C
	mov	ax, word ptr es:[0Ch]	;@0253E
	mov	cx, word ptr es:[0Eh]	;@02542
	call	far ptr L0FCE0	;@02547
	jcxz	@@7	;@0254C
	test	word ptr ds:[5160h], 4000h	;@0254E
	je	@@2	;@02554
@@1:	mov	al, byte ptr es:[di]	;@02556
	cmp	al, 20h	;@02559
	ja	@@2	;@0255B
	inc	di	;@0255D
	loop	@@1	;@0255E
	jmp	short @@7	;@02560
@@2:	pop	bx	;@02562
@@3:	mov	al, byte ptr es:[di]	;@02563
	inc	di	;@02566
	mov	byte ptr [bx], al	;@02567
	inc	bx	;@02569
	loop	@@3	;@0256A
	push	bx	;@0256C
	jmp	short @@7	;@0256D
@@4:	call	L0A7C0	;@0256F
	je	@@6	;@02572
@@5:	call	L05542	;@02574
@@6:	call	L076DE	;@02577
	mov	byte ptr ds:[38D8h], 0	;@0257A
	pop	di	;@0257F
	call	@@10	;@02580
	push	di	;@02583
@@7:	call	L026B8	;@02584
	pop	di	;@02587
	pop	bx	;@02588
	pop	es	;@02589
	push	si	;@0258A
	mov	si, word ptr ds:[3E0Ah]	;@0258B
	cmp	al, 21h	;@0258F
	jb	@@9	;@02591
	dec	si	;@02593
@@8:	mov	al, byte ptr [si]	;@02594
	cmp	al, 21h	;@02596
	jb	@@9	;@02598
	cmp	al, 2Ch	;@0259A
	je	@@9	;@0259C
	cmp	al, 3Bh	;@0259E
	je	@@9	;@025A0
	inc	si	;@025A2
	jmp	@@8	;@025A3
@@9:	mov	word ptr ds:[3E0Ah], si	;@025A5
	pop	si	;@025A9
	ret	;@025AA
@@10:	mov	bl, byte ptr ds:[516Ah]	;@025AB
	and	bl, 0Fh	;@025AF
	je	@@13	;@025B2
	inc	bl	;@025B4
	cmp	bl, 2	;@025B6
	je	@@11	;@025B9
	cmp	bl, 8	;@025BB
	je	@@12	;@025BE
	cmp	bl, 0Ah	;@025C0
	je	@@13	;@025C3
	mov	bx, 676h	;@025C5
	jmp	short @@14	;@025C8
@@11:	mov	bx, 6C2h	;@025CA
	jmp	short @@14	;@025CD
@@12:	mov	bx, 696h	;@025CF
	jmp	short @@14	;@025D2
@@13:	mov	bx, 64Eh	;@025D4
@@14:	xor	dl, dl	;@025D7
@@15:	call	@@16	;@025D9
	add	bx, 4	;@025DC
	cmp	word ptr [bx], 1	;@025DF
	jne	@@15	;@025E2
	cmp	word ptr [bx+2], 0	;@025E4
	jne	@@15	;@025E8
	mov	dh, al	;@025EA
	jmp	short @@18	;@025EC
@@16:	mov	dh, 0FFh	;@025EE
@@17:	inc	dh	;@025F0
	sub	ax, word ptr [bx]	;@025F2
	sbb	cx, word ptr [bx+2]	;@025F4
	jae	@@17	;@025F7
	add	ax, word ptr [bx]	;@025F9
	adc	cx, word ptr [bx+2]	;@025FB
	cmp	dl, dh	;@025FE
	jne	@@18	;@02600
	ret	;@02602
@@18:	cmp	dh, 0Ah	;@02603
	jae	@@19	;@02606
	mov	dl, 0FFh	;@02608
	add	dh, 30h	;@0260A
	mov	byte ptr [di], dh	;@0260D
	inc	di	;@0260F
	ret	;@02610
@@19:	and	dl, dl	;@02611
	jne	@@20	;@02613
	mov	byte ptr [di], 30h	;@02615
	inc	di	;@02618
@@20:	mov	dl, 0FFh	;@02619
	add	dh, 37h	;@0261B
	mov	byte ptr [di], dh	;@0261E
	inc	di	;@02620
	ret	;@02621
L02622:	mov	si, 3A0Ah	;@02622
@@1:	mov	al, byte ptr es:[di]	;@02625
	mov	byte ptr [si], al	;@02628
	inc	si	;@0262A
	inc	di	;@0262B
	cmp	al, 0Dh	;@0262C
	jne	@@1	;@0262E
	mov	si, 3A0Ah	;@02630
	mov	word ptr ds:[3E0Ah], si	;@02633
	xor	ax, ax	;@02637
	mov	word ptr ds:[4E0Eh], ax	;@02639
	mov	byte ptr ds:[4E16h], al	;@0263C
	ret	;@0263F
L02640:	mov	di, 3A0Ah	;@02640
	mov	cx, 400h	;@02643
	call	far ptr L11677	;@02646
	mov	si, 3A0Ah	;@0264B
	mov	word ptr ds:[3E0Ah], si	;@0264E
	xor	ax, ax	;@02652
	mov	word ptr ds:[4E0Eh], ax	;@02654
	mov	byte ptr ds:[4E16h], al	;@02657
	ret	;@0265A
	db	90h	;@0265B
L0265C:	cmp	byte ptr ds:[4E16h], 0	;@0265C
	je	@@1	;@02661
	ret	;@02663
@@1:	push	si	;@02664
	mov	si, word ptr ds:[3E0Ah]	;@02665
@@2:	mov	bx, 742h	;@02669
@@3:	lodsb	;@0266C
	xlat	;@0266D
	test	al, 1	;@0266E
	jne	@@6	;@02670
	test	al, 40h	;@02672
	jne	@@4	;@02674
	and	al, al	;@02676
	jne	@@3	;@02678
	dec	si	;@0267A
	push	si	;@0267B
	call	L02697	;@0267C
	pop	si	;@0267F
	jmp	@@2	;@02680
@@4:	mov	ah, byte ptr [si-1]	;@02682
@@5:	lodsb	;@02685
	cmp	al, ah	;@02686
	je	@@7	;@02688
	cmp	al, 0Dh	;@0268A
	jne	@@5	;@0268C
@@6:	pop	si	;@0268E
	ret	;@0268F
@@7:	cmp	byte ptr [si], ah	;@02690
	jne	@@3	;@02692
	inc	si	;@02694
	jmp	@@5	;@02695
L02697:	mov	di, si	;@02697
	push	ss	;@02699
	pop	es	;@0269A
	mov	al, 20h	;@0269B
	stosb	;@0269D
	mov	cx, 3E0Ah	;@0269E
	sub	cx, di	;@026A1
	push	di	;@026A3
	call	far ptr L11669	;@026A4
	pop	bx	;@026A9
	test	byte ptr ds:[38D7h], 1	;@026AA
	jne	@@1	;@026AF
	ret	;@026B1
@@1:	call	far ptr L10060	;@026B2
	ret	;@026B7
L026B8:	cmp	si, word ptr ds:[4E0Eh]	;@026B8
	jae	@@6	;@026BC
	mov	dx, word ptr [si+460Eh]	;@026BE
	and	dh, dh	;@026C2
	je	@@2	;@026C4
	mov	ds, dx	;@026C6
	mov	al, byte ptr ds:[7]	;@026C8
	and	al, 3Fh	;@026CB
	cmp	al, 1	;@026CD
	je	@@4	;@026CF
	cmp	al, 0Eh	;@026D1
	je	@@5	;@026D3
@@1:	mov	ax, word ptr ds:[0Ch]	;@026D5
	push	ss	;@026D8
	pop	ds	;@026D9
	xor	bl, bl	;@026DA
	ret	;@026DC
@@2:	mov	ax, dx	;@026DD
@@3:	ret	;@026DF
@@4:	test	byte ptr ss:[39B8h], 2	;@026E0
	jne	@@1	;@026E6
	push	es	;@026E8
	mov	es, dx	;@026E9
	push	ss	;@026EB
	pop	ds	;@026EC
	jmp	L02E6D	;@026ED
@@5:	test	byte ptr ss:[39B8h], 2	;@026F0
	jne	@@1	;@026F6
	push	es	;@026F8
	mov	es, dx	;@026F9
	push	ss	;@026FB
	pop	ds	;@026FC
	jmp	L02E7B	;@026FD
@@6:	cmp	byte ptr ds:[4E16h], 0	;@02700
	jne	@@3	;@02705
	mov	di, si	;@02707
	mov	si, word ptr ds:[3E0Ah]	;@02709
L0270D:	lodsb	;@0270D
	xor	ah, ah	;@0270E
	mov	bx, ax	;@02710
	shl	bx, 1	;@02712
	jmp	word ptr [bx+842h]	;@02714
L02718:	dec	si	;@02718
	mov	word ptr ds:[3E0Ah], si	;@02719
	mov	si, di	;@0271D
	mov	byte ptr ds:[4E16h], 0FFh	;@0271F
	and	al, al	;@02724
	ret	;@02726
	db	90h	;@02727
L02728:	mov	dx, ax	;@02728
	mov	word ptr ds:[3E0Ah], si	;@0272A
	mov	si, di	;@0272E
	mov	word ptr [si+460Eh], ax	;@02730
	add	word ptr ds:[4E0Eh], 2	;@02734
	xor	bl, bl	;@02739
	ret	;@0273B
L0273C:	test	byte ptr ds:[39B8h], 8	;@0273C
	jne	L02728	;@02741
	dec	si	;@02743
	push	si	;@02744
	push	di	;@02745
	push	es	;@02746
	call	L02697	;@02747
	pop	es	;@0274A
	pop	di	;@0274B
	pop	si	;@0274C
	jmp	L0270D	;@0274D
L0274F:	dec	si	;@0274F
	push	es	;@02750
	mov	bx, 742h	;@02751
	test	word ptr ds:[5160h], 1000h	;@02754
	jne	@@2	;@0275A
	mov	al, byte ptr [si+1]	;@0275C
	xlat	;@0275F
	test	al, 90h	;@02760
	je	@@2	;@02762
	test	al, 10h	;@02764
	je	@@1	;@02766
	test	byte ptr ds:[39B8h], 4	;@02768
	je	@@1	;@0276D
	push	ss	;@0276F
	pop	es	;@02770
	mov	di, 3E0Ch	;@02771
	mov	cl, 5	;@02774
	mov	ax, 30h	;@02776
	stosb	;@02779
	mov	bp, ax	;@0277A
	mov	al, 2Eh	;@0277C
	jmp	L0283F	;@0277E
@@1:	push	si	;@02781
	lodsb	;@02782
	call	L02D0C	;@02783
	pop	di	;@02786
	test	byte ptr ds:[39B8h], 1	;@02787
	jne	@@3	;@0278C
	mov	es, dx	;@0278E
	test	byte ptr es:[7], 3Fh	;@02790
	jne	@@3	;@02796
	test	byte ptr es:[10h], 40h	;@02798
	jne	@@3	;@0279E
	mov	es, ax	;@027A0
	test	byte ptr es:[7], 3Fh	;@027A2
	jne	@@3	;@027A8
	mov	si, di	;@027AA
	mov	word ptr ds:[3E0Ah], si	;@027AC
	sub	word ptr ds:[4E0Eh], 2	;@027B0
@@2:	inc	si	;@027B5
	mov	di, 3E0Ch	;@027B6
	push	ss	;@027B9
	pop	es	;@027BA
	mov	ax, 2Eh	;@027BB
	stosb	;@027BE
	mov	bp, ax	;@027BF
	jmp	L02D6E	;@027C1
@@3:	pop	es	;@027C4
	xor	bl, bl	;@027C5
	ret	;@027C7
L027C8:	push	es	;@027C8
	push	ss	;@027C9
	pop	es	;@027CA
	mov	di, 3E0Ch	;@027CB
	xor	bp, bp	;@027CE
	stosb	;@027D0
	mov	cl, 5	;@027D1
	mov	ch, al	;@027D3
@@1:	lodsb	;@027D5
	cmp	al, 0Dh	;@027D6
	je	@@2	;@027D8
	stosb	;@027DA
	cbw	;@027DB
	rol	bp, cl	;@027DC
	xor	bp, ax	;@027DE
	cmp	al, ch	;@027E0
	jne	@@1	;@027E2
	lodsb	;@027E4
	cmp	al, ch	;@027E5
	jne	@@2	;@027E7
	stosb	;@027E9
	jmp	@@1	;@027EA
@@2:	dec	si	;@027EC
	jmp	short L02846	;@027ED
L027EF:	push	es	;@027EF
	push	ss	;@027F0
	pop	es	;@027F1
	mov	bx, 742h	;@027F2
	mov	di, 3E0Ch	;@027F5
	xor	bp, bp	;@027F8
	mov	cl, 5	;@027FA
	call	L0295E	;@027FC
	cmp	al, 2Eh	;@027FF
	je	L0283F	;@02801
	test	byte ptr ds:[39B8h], 4	;@02803
	je	@@1	;@02808
	cmp	al, 45h	;@0280A
	je	@@2	;@0280C
	cmp	al, 65h	;@0280E
	je	@@2	;@02810
@@1:	call	L02926	;@02812
	jmp	short L02846	;@02815
@@2:	mov	al, 2Eh	;@02817
	stosb	;@02819
	rol	bp, cl	;@0281A
	add	bp, 2Eh	;@0281C
	call	L0293E	;@0281F
@@3:	lodsb	;@02822
	xlat	;@02823
	test	al, 2	;@02824
	jne	@@3	;@02826
	dec	si	;@02828
	test	al, 1	;@02829
	jne	L02846	;@0282B
	cmp	byte ptr [si], 2Ch	;@0282D
	je	L02846	;@02830
	and	byte ptr ds:[39B8h], 0FBh	;@02832
	mov	si, word ptr ds:[4E0Eh]	;@02837
	pop	es	;@0283B
	jmp	L026B8	;@0283C
L0283F:	inc	si	;@0283F
	call	L0295E	;@02840
	call	L0293E	;@02843
L02846:	mov	word ptr ds:[3E0Ah], si	;@02846
	cmp	di, 3F0Bh	;@0284A
	jae	@@3	;@0284E
@@1:	mov	si, 3E0Ch	;@02850
	shl	bp, 1	;@02853
@@2:	mov	es, word ptr ds:[399Eh]	;@02855
	and	bp, word ptr ds:[39A6h]	;@02859
	mov	cx, word ptr es:[bp]	;@0285D
	jcxz	@@6	;@02861
	push	cx	;@02863
	mov	es, cx	;@02864
	mov	cx, di	;@02866
	sub	cx, si	;@02868
	cmp	cl, byte ptr es:[6]	;@0286A
	jne	@@5	;@0286F
	cmp	word ptr es:[0Ah], 0	;@02871
	jne	@@5	;@02877
	mov	ax, si	;@02879
	mov	bx, di	;@0287B
	les	di, dword ptr es:[0]	;@0287D
	push	cx	;@02882
	shr	cx, 1	;@02883
	repe cmpsw	;@02885
	pop	cx	;@02887
	jne	@@4	;@02888
	and	cx, 1	;@0288A
	repe cmpsb	;@0288D
	jne	@@4	;@0288F
	pop	ax	;@02891
	mov	dx, ax	;@02892
	jmp	L02E30	;@02894
@@3:	mov	di, 3F0Bh	;@02897
	jmp	@@1	;@0289A
@@4:	mov	si, ax	;@0289C
	mov	di, bx	;@0289E
@@5:	pop	cx	;@028A0
	add	bp, 16h	;@028A1
	jmp	@@2	;@028A4
@@6:	cmp	word ptr ds:[39AAh], 0	;@028A6
	jne	@@7	;@028AB
	mov	ax, 2	;@028AD
	mov	cx, 200h	;@028B0
	call	far ptr L0FB18	;@028B3
	mov	word ptr ds:[39AAh], cx	;@028B8
	mov	word ptr ds:[39A8h], ax	;@028BC
@@7:	mov	ax, word ptr ds:[39A8h]	;@028BF
	add	word ptr ds:[39A8h], 2	;@028C2
	sub	word ptr ds:[39AAh], 2	;@028C7
	mov	word ptr es:[bp], ax	;@028CC
	mov	es, ax	;@028D0
	push	es	;@028D2
	xor	ax, ax	;@028D3
	mov	byte ptr es:[7], 0Bh	;@028D5
	mov	word ptr es:[0Ah], ax	;@028DB
	mov	word ptr es:[8], ax	;@028DF
	mov	cx, di	;@028E3
	sub	cx, si	;@028E5
	mov	ax, cx	;@028E7
	mov	byte ptr es:[6], al	;@028E9
	call	far ptr L0FB8D	;@028ED
	mov	dx, di	;@028F2
	inc	cx	;@028F4
	shr	cx, 1	;@028F5
	rep movsw	;@028F7
	mov	cx, es	;@028F9
	pop	es	;@028FB
	mov	word ptr es:[4], ax	;@028FC
	mov	word ptr es:[0], dx	;@02900
	mov	word ptr es:[2], cx	;@02905
	dec	word ptr ds:[39A4h]	;@0290A
	je	@@8	;@0290E
	mov	ax, es	;@02910
	mov	dx, ax	;@02912
	mov	word ptr es:[0Ch], ax	;@02914
	jmp	L02E30	;@02918
@@8:	mov	byte ptr ds:[38D6h], 0Bh	;@0291B
	stc	;@02920
	mov	sp, word ptr ds:[38BAh]	;@02921
	retf	;@02925
L02926:	lodsb	;@02926
	mov	ah, al	;@02927
	xlat	;@02929
	test	al, 90h	;@0292A
	je	@@1	;@0292C
	and	al, 20h	;@0292E
	xchg	al, ah	;@02930
	sub	al, ah	;@02932
	cbw	;@02934
	stosb	;@02935
	rol	bp, cl	;@02936
	xor	bp, ax	;@02938
	jmp	L02926	;@0293A
@@1:	dec	si	;@0293C
	ret	;@0293D
L0293E:	lodsb	;@0293E
	cmp	al, 45h	;@0293F
	je	@@1	;@02941
	cmp	al, 65h	;@02943
	je	@@1	;@02945
	dec	si	;@02947
	ret	;@02948
@@1:	mov	al, 45h	;@02949
	stosb	;@0294B
	lodsb	;@0294C
	cmp	al, 2Dh	;@0294D
	je	L0295E	;@0294F
	cmp	al, 2Bh	;@02951
	je	L0295E	;@02953
L02955:	mov	ah, al	;@02955
	xlat	;@02957
	test	al, 10h	;@02958
	xchg	al, ah	;@0295A
	je	L02967	;@0295C
L0295E:	stosb	;@0295E
	cbw	;@0295F
	rol	bp, cl	;@02960
	xor	bp, ax	;@02962
	lodsb	;@02964
	jmp	L02955	;@02965
L02967:	dec	si	;@02967
	ret	;@02968
L02969:	test	word ptr ds:[38C4h], 2	;@02969
	jne	@@6	;@0296F
	mov	cx, si	;@02971
	lodsb	;@02973
	cmp	al, 58h	;@02974
	je	@@3	;@02976
	cmp	al, 4Ch	;@02978
	je	@@4	;@0297A
	cmp	al, 48h	;@0297C
	je	@@5	;@0297E
	cmp	al, 44h	;@02980
	je	@@1	;@02982
	test	word ptr ds:[38C4h], 2	;@02984
	jne	@@7	;@0298A
	cmp	al, 78h	;@0298C
	je	@@3	;@0298E
	cmp	al, 6Ch	;@02990
	je	@@4	;@02992
	cmp	al, 68h	;@02994
	je	@@5	;@02996
	cmp	al, 64h	;@02998
	jne	@@7	;@0299A
@@1:	lodsb	;@0299C
	cmp	al, 44h	;@0299D
	je	@@2	;@0299F
	test	word ptr ds:[38C4h], 2	;@029A1
	jne	@@7	;@029A7
	cmp	al, 64h	;@029A9
	jne	@@7	;@029AB
@@2:	mov	dx, word ptr ds:[5668h]	;@029AD
	jmp	L02CF5	;@029B1
@@3:	mov	dx, word ptr ds:[5626h]	;@029B4
	jmp	L02CF5	;@029B8
@@4:	mov	dx, word ptr ds:[55EAh]	;@029BB
	jmp	L02CF5	;@029BF
@@5:	mov	dx, word ptr ds:[55F2h]	;@029C2
	jmp	L02CF5	;@029C6
@@6:	jmp	L02D0C	;@029C9
@@7:	jmp	L02D07	;@029CC
	db	0F7h, 6, 0C4h, 38h, 2, 0, 75h, 0F2h, 8Bh, 0CEh, 0ACh, '<Xt9<Pt.<Lt#<Ht'	;@029CF
	db	18h, 0F7h, 6, 0C4h, 38h, 2, 0, 75h, 0DAh, '<xt!<pt', 16h, '<lt'
	db	0Bh, '<hu', 0CAh
L02A02:	mov	dx, word ptr ds:[55F8h]	;@02A02
	jmp	L02CF5	;@02A06
	db	8Bh, 16h, 0F0h, 55h, 0E9h, 0E5h, 2, 8Bh, 16h, 30h, 56h, 0E9h, 0DEh	;@02A09
	db	2, 8Bh, 16h, 2Ch, 56h, 0E9h, 0D7h, 2
L02A1E:	lodsb	;@02A1E
	cmp	al, 50h	;@02A1F
	je	@@1	;@02A21
	test	word ptr ds:[38C4h], 2	;@02A23
	jne	L02AA5	;@02A29
	cmp	al, 70h	;@02A2B
	jne	L02AA5	;@02A2D
@@1:	mov	dx, word ptr ds:[566Ch]	;@02A2F
	jmp	L02CF5	;@02A33
L02A36:	test	word ptr ds:[38C4h], 2	;@02A36
	jne	@@4	;@02A3C
	mov	cx, si	;@02A3E
	lodsb	;@02A40
	cmp	al, 58h	;@02A41
	je	L02AAF	;@02A43
	cmp	al, 4Ch	;@02A45
	je	L02AB6	;@02A47
	cmp	al, 48h	;@02A49
	je	L02ABD	;@02A4B
	cmp	al, 4Dh	;@02A4D
	je	L02A1E	;@02A4F
	cmp	al, 53h	;@02A51
	je	L02AA8	;@02A53
	cmp	al, 41h	;@02A55
	je	@@1	;@02A57
	test	word ptr ds:[38C4h], 2	;@02A59
	jne	L02AA5	;@02A5F
	cmp	al, 78h	;@02A61
	je	L02AAF	;@02A63
	cmp	al, 6Ch	;@02A65
	je	L02AB6	;@02A67
	cmp	al, 68h	;@02A69
	je	L02ABD	;@02A6B
	cmp	al, 6Dh	;@02A6D
	je	L02A1E	;@02A6F
	cmp	al, 73h	;@02A71
	je	L02AA8	;@02A73
	cmp	al, 61h	;@02A75
	jne	L02AA5	;@02A77
@@1:	lodsb	;@02A79
	cmp	al, 4Ch	;@02A7A
	je	@@2	;@02A7C
	test	word ptr ds:[38C4h], 2	;@02A7E
	jne	L02AA5	;@02A84
	cmp	al, 6Ch	;@02A86
	jne	L02AA5	;@02A88
@@2:	lodsb	;@02A8A
	cmp	al, 4Ch	;@02A8B
	je	@@3	;@02A8D
	test	word ptr ds:[38C4h], 2	;@02A8F
	jne	L02AA5	;@02A95
	cmp	al, 6Ch	;@02A97
	jne	L02AA5	;@02A99
@@3:	mov	dx, word ptr ds:[5672h]	;@02A9B
	jmp	L02CF5	;@02A9F
@@4:	jmp	L02D0C	;@02AA2
L02AA5:	jmp	L02D07	;@02AA5
L02AA8:	mov	dx, word ptr ds:[5638h]	;@02AA8
	jmp	L02CF5	;@02AAC
L02AAF:	mov	dx, word ptr ds:[5628h]	;@02AAF
	jmp	L02CF5	;@02AB3
L02AB6:	mov	dx, word ptr ds:[55ECh]	;@02AB6
	jmp	L02CF5	;@02ABA
L02ABD:	mov	dx, word ptr ds:[55F4h]	;@02ABD
	jmp	L02CF5	;@02AC1
L02AC4:	jmp	L02D0C	;@02AC4
L02AC7:	test	word ptr ds:[38C4h], 2	;@02AC7
	jne	L02AC4	;@02ACD
	mov	cx, si	;@02ACF
	lodsb	;@02AD1
	cmp	al, 58h	;@02AD2
	je	L02B36	;@02AD4
	cmp	al, 49h	;@02AD6
	je	L02B4B	;@02AD8
	cmp	al, 4Ch	;@02ADA
	je	L02B3D	;@02ADC
	cmp	al, 48h	;@02ADE
	je	L02B44	;@02AE0
	cmp	al, 53h	;@02AE2
	je	L02B2F	;@02AE4
	cmp	al, 57h	;@02AE6
	je	@@3	;@02AE8
	cmp	al, 42h	;@02AEA
	je	@@2	;@02AEC
	cmp	al, 44h	;@02AEE
	je	@@1	;@02AF0
	test	word ptr ds:[38C4h], 2	;@02AF2
	jne	L02B52	;@02AF8
	cmp	al, 78h	;@02AFA
	je	L02B36	;@02AFC
	cmp	al, 69h	;@02AFE
	je	L02B4B	;@02B00
	cmp	al, 6Ch	;@02B02
	je	L02B3D	;@02B04
	cmp	al, 68h	;@02B06
	je	L02B44	;@02B08
	cmp	al, 73h	;@02B0A
	je	L02B2F	;@02B0C
	cmp	al, 77h	;@02B0E
	je	@@3	;@02B10
	cmp	al, 62h	;@02B12
	je	@@2	;@02B14
	cmp	al, 64h	;@02B16
	jne	L02B52	;@02B18
@@1:	mov	dx, word ptr ds:[5810h]	;@02B1A
	jmp	L02CF5	;@02B1E
@@2:	mov	dx, word ptr ds:[580Ch]	;@02B21
	jmp	L02CF5	;@02B25
@@3:	mov	dx, word ptr ds:[580Eh]	;@02B28
	jmp	L02CF5	;@02B2C
L02B2F:	mov	dx, word ptr ds:[563Ch]	;@02B2F
	jmp	L02CF5	;@02B33
L02B36:	mov	dx, word ptr ds:[562Ah]	;@02B36
	jmp	L02CF5	;@02B3A
L02B3D:	mov	dx, word ptr ds:[55EEh]	;@02B3D
	jmp	L02CF5	;@02B41
L02B44:	mov	dx, word ptr ds:[55F6h]	;@02B44
	jmp	L02CF5	;@02B48
L02B4B:	mov	dx, word ptr ds:[5634h]	;@02B4B
	jmp	L02CF5	;@02B4F
L02B52:	jmp	L02D07	;@02B52
	db	0ACh, '<Xt', 1Bh, '<Pt', 10h, 0F7h, 6, 0C4h, 38h, 2, 0, 'u1<xt'	;@02B55
	db	0Bh, '<pu)', 8Bh, 16h, 4, 56h, 0E9h, 80h, 1, 8Bh, 16h, 0, 56h
	db	0E9h, 79h, 1, 0ACh, '<Xt', 0Ch, 0F7h, 6, 0C4h, 38h, 2, 0, 75h
	db	0Eh, '<xu', 0Ah, 8Bh, 16h, 0FCh, 55h, 0E9h, 61h, 1
L02B94:	jmp	L02D0C	;@02B94
L02B97:	jmp	L02D07	;@02B97
L02B9A:	test	word ptr ds:[38C4h], 2	;@02B9A
	jne	L02B94	;@02BA0
	mov	cx, si	;@02BA2
	lodsb	;@02BA4
	cmp	al, 53h	;@02BA5
	je	@@1	;@02BA7
	test	word ptr ds:[38C4h], 2	;@02BA9
	jne	L02B97	;@02BAF
	cmp	al, 73h	;@02BB1
	jne	L02B97	;@02BB3
@@1:	mov	dx, word ptr ds:[5636h]	;@02BB5
	jmp	L02CF5	;@02BB9
L02BBC:	jmp	L02D07	;@02BBC
L02BBF:	jmp	L02D0C	;@02BBF
L02BC2:	test	word ptr ds:[38C4h], 2	;@02BC2
	jne	L02BBF	;@02BC8
	mov	cx, si	;@02BCA
	lodsb	;@02BCC
	cmp	al, 4Dh	;@02BCD
	je	@@1	;@02BCF
	test	word ptr ds:[38C4h], 2	;@02BD1
	jne	L02BBC	;@02BD7
	cmp	al, 6Dh	;@02BD9
	jne	L02BBC	;@02BDB
@@1:	lodsb	;@02BDD
	cmp	al, 50h	;@02BDE
	je	@@2	;@02BE0
	test	word ptr ds:[38C4h], 2	;@02BE2
	jne	L02BBC	;@02BE8
	cmp	al, 70h	;@02BEA
	jne	L02BBC	;@02BEC
@@2:	mov	dx, word ptr ds:[5670h]	;@02BEE
	jmp	L02CF5	;@02BF2
L02BF5:	test	word ptr ds:[38C4h], 2	;@02BF5
	jne	L02C2B	;@02BFB
	mov	cx, si	;@02BFD
	lodsb	;@02BFF
	cmp	al, 4Fh	;@02C00
	je	@@1	;@02C02
	test	word ptr ds:[38C4h], 2	;@02C04
	jne	L02C28	;@02C0A
	cmp	al, 6Fh	;@02C0C
	jne	L02C28	;@02C0E
@@1:	lodsb	;@02C10
	cmp	al, 56h	;@02C11
	je	@@2	;@02C13
	test	word ptr ds:[38C4h], 2	;@02C15
	jne	L02C28	;@02C1B
	cmp	al, 76h	;@02C1D
	jne	L02C28	;@02C1F
@@2:	mov	dx, word ptr ds:[566Eh]	;@02C21
	jmp	L02CF5	;@02C25
L02C28:	jmp	L02D07	;@02C28
L02C2B:	jmp	L02D0C	;@02C2B
L02C2E:	test	word ptr ds:[38C4h], 2	;@02C2E
	jne	@@4	;@02C34
	mov	cx, si	;@02C36
	lodsb	;@02C38
	cmp	al, 55h	;@02C39
	je	@@5	;@02C3B
	cmp	al, 4Fh	;@02C3D
	je	@@1	;@02C3F
	test	word ptr ds:[38C4h], 2	;@02C41
	jne	@@3	;@02C47
	cmp	al, 75h	;@02C49
	je	@@5	;@02C4B
	cmp	al, 6Fh	;@02C4D
	jne	L02C28	;@02C4F
@@1:	lodsb	;@02C51
	cmp	al, 50h	;@02C52
	je	@@2	;@02C54
	test	word ptr ds:[38C4h], 2	;@02C56
	jne	@@3	;@02C5C
	cmp	al, 70h	;@02C5E
	jne	@@3	;@02C60
@@2:	mov	dx, word ptr ds:[5676h]	;@02C62
	jmp	L02CF5	;@02C66
@@3:	jmp	L02D07	;@02C69
@@4:	jmp	L02D0C	;@02C6C
@@5:	lodsb	;@02C6F
	cmp	al, 53h	;@02C70
	je	@@6	;@02C72
	test	word ptr ds:[38C4h], 2	;@02C74
	jne	@@3	;@02C7A
	cmp	al, 73h	;@02C7C
	jne	@@3	;@02C7E
@@6:	lodsb	;@02C80
	cmp	al, 48h	;@02C81
	je	@@7	;@02C83
	test	word ptr ds:[38C4h], 2	;@02C85
	jne	@@3	;@02C8B
	cmp	al, 68h	;@02C8D
	jne	@@3	;@02C8F
@@7:	mov	dx, word ptr ds:[5674h]	;@02C91
	jmp	short L02CF5	;@02C95
L02C97:	test	word ptr ds:[38C4h], 2	;@02C97
	jne	@@5	;@02C9D
	mov	cx, si	;@02C9F
	lodsb	;@02CA1
	cmp	al, 49h	;@02CA2
	je	@@3	;@02CA4
	cmp	al, 50h	;@02CA6
	je	@@4	;@02CA8
	cmp	al, 53h	;@02CAA
	je	@@7	;@02CAC
	cmp	al, 55h	;@02CAE
	je	@@1	;@02CB0
	test	word ptr ds:[38C4h], 2	;@02CB2
	jne	@@6	;@02CB8
	cmp	al, 69h	;@02CBA
	je	@@3	;@02CBC
	cmp	al, 70h	;@02CBE
	je	@@4	;@02CC0
	cmp	al, 73h	;@02CC2
	je	@@7	;@02CC4
	cmp	al, 75h	;@02CC6
	jne	@@6	;@02CC8
@@1:	lodsb	;@02CCA
	cmp	al, 42h	;@02CCB
	je	@@2	;@02CCD
	test	word ptr ds:[38C4h], 2	;@02CCF
	jne	@@6	;@02CD5
	cmp	al, 62h	;@02CD7
	jne	@@6	;@02CD9
@@2:	mov	dx, word ptr ds:[566Ah]	;@02CDB
	jmp	short L02CF5	;@02CDF
@@3:	mov	dx, word ptr ds:[5632h]	;@02CE1
	jmp	short L02CF5	;@02CE5
@@4:	mov	dx, word ptr ds:[562Eh]	;@02CE7
	jmp	short L02CF5	;@02CEB
@@5:	jmp	short L02D0C	;@02CED
@@6:	jmp	short L02D07	;@02CEF
@@7:	mov	dx, word ptr ds:[563Ah]	;@02CF1
L02CF5:	mov	bx, 742h	;@02CF5
	mov	al, byte ptr [si]	;@02CF8
	xlat	;@02CFA
	test	al, 90h	;@02CFB
	jne	L02D07	;@02CFD
	push	es	;@02CFF
	mov	word ptr ds:[3E0Ah], si	;@02D00
	jmp	L02DD6	;@02D04
L02D07:	mov	si, cx	;@02D07
	mov	al, byte ptr [si-1]	;@02D09
L02D0C:	push	es	;@02D0C
	xor	ah, ah	;@02D0D
	dec	si	;@02D0F
	mov	bx, 742h	;@02D10
	xlat	;@02D13
	push	ss	;@02D14
	pop	es	;@02D15
	mov	di, 3E0Ch	;@02D16
	xor	bp, bp	;@02D19
	mov	cl, 5	;@02D1B
	mov	dh, 90h	;@02D1D
	test	word ptr ds:[38C4h], 2	;@02D1F
	je	L02D46	;@02D25
@@1:	lodsb	;@02D27
	stosb	;@02D28
	rol	bp, cl	;@02D29
	xor	bp, ax	;@02D2B
	mov	al, byte ptr [si]	;@02D2D
	xlat	;@02D2F
	test	al, dh	;@02D30
	je	L02D6E	;@02D32
	lodsb	;@02D34
	stosb	;@02D35
	rol	bp, cl	;@02D36
	xor	bp, ax	;@02D38
	mov	al, byte ptr [si]	;@02D3A
	xlat	;@02D3C
	test	al, dh	;@02D3D
	jne	@@1	;@02D3F
	jmp	short L02D6E	;@02D41
L02D43:	jmp	L02E41	;@02D43
L02D46:	mov	dl, al	;@02D46
	lodsb	;@02D48
	and	dl, 20h	;@02D49
	sub	al, dl	;@02D4C
	stosb	;@02D4E
	rol	bp, cl	;@02D4F
	xor	bp, ax	;@02D51
	mov	al, byte ptr [si]	;@02D53
	xlat	;@02D55
	test	al, dh	;@02D56
	je	L02D6E	;@02D58
	mov	dl, al	;@02D5A
	lodsb	;@02D5C
	and	dl, 20h	;@02D5D
	sub	al, dl	;@02D60
	stosb	;@02D62
	rol	bp, cl	;@02D63
	xor	bp, ax	;@02D65
	mov	al, byte ptr [si]	;@02D67
	xlat	;@02D69
	test	al, dh	;@02D6A
	jne	L02D46	;@02D6C
L02D6E:	mov	word ptr ds:[3E0Ah], si	;@02D6E
	cmp	di, word ptr ds:[39B6h]	;@02D72
	jae	L02D43	;@02D76
L02D78:	mov	byte ptr [di], 0Dh	;@02D78
	mov	si, 3E0Ch	;@02D7B
	mov	dx, word ptr ds:[5160h]	;@02D7E
	and	dx, 8000h	;@02D82
	je	@@1	;@02D86
	xor	dx, dx	;@02D88
	mov	ax, word ptr [si]	;@02D8A
	cmp	ax, word ptr ds:[5164h]	;@02D8C
	jne	@@1	;@02D90
	mov	dx, word ptr ds:[515Ch]	;@02D92
	add	bp, dx	;@02D96
@@1:	shl	bp, 1	;@02D98
	mov	ax, si	;@02D9A
	mov	bx, di	;@02D9C
	sub	bx, ax	;@02D9E
L02DA0:	mov	es, word ptr ds:[399Eh]	;@02DA0
	and	bp, word ptr ds:[39A6h]	;@02DA4
	mov	cx, word ptr es:[bp]	;@02DA8
	jcxz	L02E03	;@02DAC
	push	cx	;@02DAE
	mov	es, cx	;@02DAF
	mov	cx, bx	;@02DB1
	cmp	cl, byte ptr es:[6]	;@02DB3
	jne	L02DFD	;@02DB8
	cmp	dx, word ptr es:[0Ah]	;@02DBA
	jne	L02DFD	;@02DBF
	les	di, dword ptr es:[0]	;@02DC1
	shr	cx, 1	;@02DC6
	repe cmpsw	;@02DC8
	jne	L02DFB	;@02DCA
	mov	cx, bx	;@02DCC
	and	cx, 1	;@02DCE
	repe cmpsb	;@02DD1
	jne	L02DFB	;@02DD3
	pop	dx	;@02DD5
L02DD6:	mov	es, dx	;@02DD6
	mov	si, word ptr ds:[4E0Eh]	;@02DD8
	mov	word ptr [si+460Eh], dx	;@02DDC
	add	word ptr ds:[4E0Eh], 2	;@02DE0
	mov	al, byte ptr es:[7]	;@02DE5
	and	al, 3Fh	;@02DE9
	cmp	al, 1	;@02DEB
	je	L02E5B	;@02DED
	cmp	al, 0Eh	;@02DEF
	je	L02E64	;@02DF1
L02DF3:	mov	ax, word ptr es:[0Ch]	;@02DF3
	pop	es	;@02DF7
	xor	bl, bl	;@02DF8
	ret	;@02DFA
L02DFB:	mov	si, ax	;@02DFB
L02DFD:	pop	cx	;@02DFD
	add	bp, 16h	;@02DFE
	jmp	L02DA0	;@02E01
L02E03:	mov	di, bx	;@02E03
	add	di, ax	;@02E05
	cmp	word ptr ds:[39AAh], 0	;@02E07
	jne	@@1	;@02E0C
	mov	ax, 2	;@02E0E
	mov	cx, 200h	;@02E11
	call	far ptr L0FB18	;@02E14
	mov	word ptr ds:[39AAh], cx	;@02E19
	mov	word ptr ds:[39A8h], ax	;@02E1D
@@1:	mov	ax, word ptr ds:[39A8h]	;@02E20
	add	word ptr ds:[39A8h], 2	;@02E23
	sub	word ptr ds:[39AAh], 2	;@02E28
	call	L03073	;@02E2D
L02E30:	mov	si, word ptr ds:[4E0Eh]	;@02E30
	mov	word ptr [si+460Eh], dx	;@02E34
	add	word ptr ds:[4E0Eh], 2	;@02E38
	xor	bl, bl	;@02E3D
	pop	es	;@02E3F
	ret	;@02E40
L02E41:	mov	si, 3E0Ch	;@02E41
	mov	cx, word ptr ds:[38C8h]	;@02E44
	xor	bp, bp	;@02E48
@@1:	push	cx	;@02E4A
	mov	cl, 5	;@02E4B
	rol	bp, cl	;@02E4D
	pop	cx	;@02E4F
	lodsb	;@02E50
	cbw	;@02E51
	xor	bp, ax	;@02E52
	loop	@@1	;@02E54
	mov	di, si	;@02E56
	jmp	L02D78	;@02E58
L02E5B:	test	byte ptr ds:[39B8h], 2	;@02E5B
	jne	L02DF3	;@02E60
	jmp	short L02E6D	;@02E62
L02E64:	test	byte ptr ds:[39B8h], 2	;@02E64
	jne	L02DF3	;@02E69
	jmp	short L02E7B	;@02E6B
L02E6D:	mov	bx, es	;@02E6D
	call	L035F0	;@02E6F
	push	si	;@02E72
	call	L02E94	;@02E73
	pop	si	;@02E76
	pop	es	;@02E77
	jmp	L026B8	;@02E78
L02E7B:	mov	bx, es	;@02E7B
	call	L035F0	;@02E7D
	call	L01AEC	;@02E80
	mov	es, ax	;@02E83
	mov	dx, word ptr es:[8]	;@02E85
	mov	es, dx	;@02E8A
	mov	ax, word ptr es:[0Ch]	;@02E8C
	pop	es	;@02E90
	xor	bl, bl	;@02E91
	ret	;@02E93
L02E94:	test	byte ptr ds:[38D7h], 2	;@02E94
	je	@@4	;@02E99
@@1:	call	L01AEC	;@02E9B
	mov	es, ax	;@02E9E
	mov	ax, word ptr es:[8]	;@02EA0
	mov	cx, word ptr es:[0Ah]	;@02EA4
	call	far ptr L0FCE0	;@02EA9
	add	si, 460Eh	;@02EAE
	push	es	;@02EB2
	push	di	;@02EB3
	push	ss	;@02EB4
	pop	es	;@02EB5
	mov	ax, cx	;@02EB6
	mov	cx, word ptr ds:[4E0Eh]	;@02EB8
	add	cx, 460Eh	;@02EBC
	sub	cx, si	;@02EC0
	shr	cx, 1	;@02EC2
	dec	cx	;@02EC4
	sub	word ptr ds:[4E0Eh], 2	;@02EC5
	jcxz	@@2	;@02ECA
	mov	dx, cx	;@02ECC
	mov	di, si	;@02ECE
	add	si, 2	;@02ED0
	rep movsw	;@02ED3
	sub	di, 2	;@02ED5
	mov	si, di	;@02ED8
	add	di, ax	;@02EDA
	cmp	di, 4E0Eh	;@02EDC
	ja	@@3	;@02EE0
	mov	cx, dx	;@02EE2
	std	;@02EE4
	jcxz	@@2	;@02EE5
	rep movsw	;@02EE7
	add	si, 2	;@02EE9
@@2:	cld	;@02EEC
	add	word ptr ds:[4E0Eh], ax	;@02EED
	mov	di, si	;@02EF1
	pop	si	;@02EF3
	pop	ds	;@02EF4
	shr	ax, 1	;@02EF5
	mov	cx, ax	;@02EF7
	rep movsw	;@02EF9
	push	ss	;@02EFB
	pop	ds	;@02EFC
	ret	;@02EFD
@@3:	pop	si	;@02EFE
	pop	ds	;@02EFF
	push	ss	;@02F00
	pop	ds	;@02F01
	mov	cx, 89h	;@02F02
	jmp	L03208	;@02F05
@@4:	mov	ax, si	;@02F08
	add	ax, 2	;@02F0A
	cmp	ax, word ptr ds:[4E0Eh]	;@02F0D
	jne	@@1	;@02F11
	mov	word ptr ds:[4E0Eh], si	;@02F13
	mov	byte ptr ds:[4E16h], 0	;@02F17
	push	es	;@02F1C
	call	L01AEC	;@02F1D
	pop	es	;@02F20
	mov	cl, byte ptr es:[6]	;@02F21
	xor	ch, ch	;@02F26
	mov	es, ax	;@02F28
	mov	ax, word ptr es:[0Ch]	;@02F2A
	mov	dx, word ptr es:[0Eh]	;@02F2E
	call	far ptr L0FCE0	;@02F33
	push	es	;@02F38
	push	di	;@02F39
	mov	di, word ptr ds:[3E0Ah]	;@02F3A
	mov	si, di	;@02F3E
	sub	di, cx	;@02F40
	mov	word ptr ds:[3E0Ah], di	;@02F42
	push	ds	;@02F46
	pop	es	;@02F47
@@5:	lodsb	;@02F48
	stosb	;@02F49
	cmp	al, 0Dh	;@02F4A
	jne	@@5	;@02F4C
	mov	ax, dx	;@02F4E
	mov	dx, di	;@02F50
	sub	dx, word ptr ds:[3E0Ah]	;@02F52
	dec	di	;@02F56
	mov	si, di	;@02F57
	add	di, ax	;@02F59
	cmp	di, 3E0Ah	;@02F5B
	ja	@@3	;@02F5F
	mov	cx, dx	;@02F61
	std	;@02F63
	rep movsb	;@02F64
	inc	si	;@02F66
	cld	;@02F67
	mov	di, si	;@02F68
	pop	si	;@02F6A
	pop	ds	;@02F6B
	mov	cx, ax	;@02F6C
	rep movsb	;@02F6E
	push	ss	;@02F70
	pop	ds	;@02F71
	ret	;@02F72
L02F73:	and	ax, ax	;@02F73
	jne	@@1	;@02F75
	mov	si, 460Eh	;@02F77
	mov	ax, word ptr ds:[4E0Eh]	;@02F7A
	jmp	short @@3	;@02F7D
@@1:	mov	si, word ptr ds:[3E0Ah]	;@02F7F
	mov	bx, 742h	;@02F83
@@2:	lodsb	;@02F86
	xlat	;@02F87
	test	al, 1	;@02F88
	je	@@2	;@02F8A
	mov	ax, si	;@02F8C
	dec	ax	;@02F8E
	mov	si, 3A0Ah	;@02F8F
	sub	ax, si	;@02F92
@@3:	mov	cx, ax	;@02F94
	call	far ptr L0FB8D	;@02F96
	push	cx	;@02F9B
	inc	cx	;@02F9C
	shr	cx, 1	;@02F9D
	rep movsw	;@02F9F
	pop	cx	;@02FA1
	ret	;@02FA2
L02FA3:	push	dx	;@02FA3
	call	far ptr L0FCE0	;@02FA4
	pop	dx	;@02FA9
	push	es	;@02FAA
	pop	ds	;@02FAB
	push	ss	;@02FAC
	pop	es	;@02FAD
	mov	si, di	;@02FAE
	and	dl, dl	;@02FB0
	jne	@@1	;@02FB2
	mov	word ptr ss:[4E0Eh], cx	;@02FB4
	shr	cx, 1	;@02FB9
	mov	di, 460Eh	;@02FBB
	rep movsw	;@02FBE
	push	ss	;@02FC0
	pop	ds	;@02FC1
	mov	byte ptr ds:[4E16h], 0FFh	;@02FC2
	ret	;@02FC7
@@1:	test	byte ptr ss:[38D7h], 1	;@02FC8
	jne	@@2	;@02FCE
	mov	di, 3A0Ah	;@02FD0
	mov	word ptr ss:[3E0Ah], di	;@02FD3
	rep movsb	;@02FD8
	mov	al, 0Dh	;@02FDA
	stosb	;@02FDC
	push	ss	;@02FDD
	pop	ds	;@02FDE
	xor	ax, ax	;@02FDF
	mov	byte ptr ds:[4E16h], al	;@02FE1
	mov	word ptr ds:[4E0Eh], ax	;@02FE4
	ret	;@02FE7
@@2:	push	ss	;@02FE8
	pop	ds	;@02FE9
	ret	;@02FEA
L02FEB:	mov	si, bx	;@02FEB
	mov	dx, cx	;@02FED
	mov	bx, 742h	;@02FEF
	push	ss	;@02FF2
	pop	es	;@02FF3
	mov	di, 3E0Ch	;@02FF4
	xor	bp, bp	;@02FF7
	mov	cl, 5	;@02FF9
	test	word ptr ds:[38C4h], 2	;@02FFB
	je	@@2	;@03001
@@1:	lodsb	;@03003
	stosb	;@03004
	cbw	;@03005
	rol	bp, cl	;@03006
	xor	bp, ax	;@03008
	dec	dx	;@0300A
	jne	@@1	;@0300B
	jmp	short @@3	;@0300D
@@2:	mov	al, byte ptr [si]	;@0300F
	xlat	;@03011
	mov	ah, al	;@03012
	lodsb	;@03014
	and	ah, 20h	;@03015
	sub	al, ah	;@03018
	stosb	;@0301A
	cbw	;@0301B
	rol	bp, cl	;@0301C
	xor	bp, ax	;@0301E
	dec	dx	;@03020
	jne	@@2	;@03021
@@3:	mov	si, 3E0Ch	;@03023
	shl	bp, 1	;@03026
@@4:	mov	es, word ptr ds:[399Eh]	;@03028
	and	bp, word ptr ds:[39A6h]	;@0302C
	mov	cx, word ptr es:[bp]	;@03030
	jcxz	@@7	;@03034
	mov	es, cx	;@03036
	mov	cx, di	;@03038
	sub	cx, si	;@0303A
	cmp	cl, byte ptr es:[6]	;@0303C
	jne	@@6	;@03041
	cmp	word ptr es:[0Ah], 0	;@03043
	jne	@@6	;@03049
	mov	ax, si	;@0304B
	mov	bx, di	;@0304D
	les	di, dword ptr es:[0]	;@0304F
	push	cx	;@03054
	shr	cx, 1	;@03055
	repe cmpsw	;@03057
	pop	cx	;@03059
	jne	@@5	;@0305A
	and	cx, 1	;@0305C
	repe cmpsb	;@0305F
	jne	@@5	;@03061
	mov	es, word ptr ds:[399Eh]	;@03063
	ret	;@03067
@@5:	mov	si, ax	;@03068
	mov	di, bx	;@0306A
@@6:	add	bp, 16h	;@0306C
	jmp	@@4	;@0306F
@@7:	stc	;@03071
	ret	;@03072
L03073:	mov	word ptr es:[bp], ax	;@03073
	mov	byte ptr [di], 0Dh	;@03077
	mov	es, ax	;@0307A
	mov	bx, ax	;@0307C
	xor	ax, ax	;@0307E
	mov	byte ptr es:[7], al	;@03080
	mov	byte ptr es:[10h], al	;@03084
	mov	byte ptr es:[11h], 20h	;@03088
	mov	word ptr es:[1Ch], ax	;@0308E
	mov	word ptr es:[0Eh], ax	;@03092
	mov	word ptr es:[8], ax	;@03096
	mov	word ptr es:[0Ah], dx	;@0309A
	mov	cx, di	;@0309F
	sub	cx, si	;@030A1
	mov	ax, cx	;@030A3
	mov	byte ptr es:[6], al	;@030A5
	call	far ptr L0FB8D	;@030A9
	mov	dx, di	;@030AE
	inc	cx	;@030B0
	shr	cx, 1	;@030B1
	rep movsw	;@030B3
	mov	cx, es	;@030B5
	mov	es, bx	;@030B7
	mov	word ptr es:[4], ax	;@030B9
	mov	word ptr es:[0], dx	;@030BD
	mov	word ptr es:[2], cx	;@030C2
	dec	word ptr ds:[39A4h]	;@030C7
	je	@@1	;@030CB
	test	word ptr ds:[38C4h], 2	;@030CD
	jne	@@2	;@030D3
	mov	ax, bx	;@030D5
	mov	dx, ax	;@030D7
	mov	word ptr es:[0Ch], ax	;@030D9
	ret	;@030DD
@@1:	mov	byte ptr ds:[38D6h], 0Bh	;@030DE
	stc	;@030E3
	mov	sp, word ptr ds:[38BAh]	;@030E4
	retf	;@030E8
@@2:	push	es	;@030E9
	mov	si, 3E0Ch	;@030EA
	mov	bx, 742h	;@030ED
	mov	cl, 5	;@030F0
	xor	bp, bp	;@030F2
	mov	al, byte ptr [si]	;@030F4
	xlat	;@030F6
@@3:	mov	ah, al	;@030F7
	lodsb	;@030F9
	and	ah, 20h	;@030FA
	sub	al, ah	;@030FD
	cbw	;@030FF
	mov	byte ptr [si-1], al	;@03100
	rol	bp, cl	;@03103
	xor	bp, ax	;@03105
	mov	al, byte ptr [si]	;@03107
	xlat	;@03109
	test	al, 90h	;@0310A
	jne	@@3	;@0310C
	mov	di, si	;@0310E
	mov	si, 3E0Ch	;@03110
	xor	dx, dx	;@03113
	test	word ptr ds:[5160h], 8000h	;@03115
	je	@@4	;@0311B
	mov	ax, word ptr [si]	;@0311D
	cmp	ax, word ptr ds:[5164h]	;@0311F
	jne	@@4	;@03123
	mov	dx, word ptr ds:[515Ch]	;@03125
	add	bp, dx	;@03129
@@4:	shl	bp, 1	;@0312B
@@5:	mov	es, word ptr ds:[399Eh]	;@0312D
	and	bp, word ptr ds:[39A6h]	;@03131
	mov	cx, word ptr es:[bp]	;@03135
	jcxz	@@8	;@03139
	push	cx	;@0313B
	mov	es, cx	;@0313C
	mov	cx, di	;@0313E
	sub	cx, si	;@03140
	cmp	cl, byte ptr es:[6]	;@03142
	jne	@@7	;@03147
	cmp	dx, word ptr es:[0Ah]	;@03149
	jne	@@7	;@0314E
	mov	ax, si	;@03150
	mov	bx, di	;@03152
	les	di, dword ptr es:[0]	;@03154
	push	cx	;@03159
	shr	cx, 1	;@0315A
	repe cmpsw	;@0315C
	pop	cx	;@0315E
	jne	@@6	;@0315F
	and	cx, 1	;@03161
	repe cmpsb	;@03164
	jne	@@6	;@03166
	pop	ax	;@03168
	pop	es	;@03169
	mov	word ptr es:[0Ch], ax	;@0316A
	mov	dx, es	;@0316E
	ret	;@03170
@@6:	mov	si, ax	;@03171
	mov	di, bx	;@03173
@@7:	pop	cx	;@03175
	add	bp, 16h	;@03176
	jmp	@@5	;@03179
@@8:	pop	es	;@0317B
	mov	ax, es	;@0317C
	mov	dx, ax	;@0317E
	mov	word ptr es:[0Ch], ax	;@03180
	ret	;@03184
L03185:	mov	di, es	;@03185
	mov	al, byte ptr es:[7]	;@03187
	and	al, 3Fh	;@0318B
	cmp	al, 0Bh	;@0318D
	mov	cx, 102Ah	;@0318F
	jne	@@1	;@03192
	mov	cx, 107Dh	;@03194
@@1:	call	L03208	;@03197
	xor	di, di	;@0319A
	dec	di	;@0319C
	ret	;@0319D
L0319E:	test	byte ptr es:[10h], bh	;@0319E
	jne	@@4	;@031A3
@@1:	test	byte ptr es:[7], 40h	;@031A5
	jne	@@3	;@031AB
@@2:	ret	;@031AD
@@3:	test	word ptr ds:[5166h], 2000h	;@031AE
	je	@@2	;@031B4
	push	di	;@031B6
	push	cx	;@031B7
	push	bx	;@031B8
	push	dx	;@031B9
	mov	cx, 9079h	;@031BA
	mov	di, es	;@031BD
	call	L03208	;@031BF
	xor	di, di	;@031C2
	pop	dx	;@031C4
	pop	bx	;@031C5
	pop	cx	;@031C6
	pop	di	;@031C7
	ret	;@031C8
@@4:	call	L031CE	;@031C9
	jmp	@@1	;@031CC
L031CE:	cmp	word ptr ds:[38C6h], 0	;@031CE
	je	@@1	;@031D3
	test	byte ptr ds:[38D7h], 8	;@031D5
	jne	@@2	;@031DA
	mov	byte ptr ds:[38DEh], 0FFh	;@031DC
	jmp	short @@2	;@031E1
@@1:	test	word ptr ds:[5166h], 10h	;@031E3
	je	@@2	;@031E9
	push	di	;@031EB
	push	cx	;@031EC
	push	bx	;@031ED
	push	dx	;@031EE
	mov	cx, 905Ch	;@031EF
	mov	di, es	;@031F2
	call	L03208	;@031F4
	pop	dx	;@031F7
	pop	bx	;@031F8
	pop	cx	;@031F9
	pop	di	;@031FA
@@2:	ret	;@031FB
L031FC:	call	L03424	;@031FC
	retf	;@031FF
L03200:	call	L03BCE	;@03200
	retf	;@03203
L03204:	call	L004A1	;@03204
	retf	;@03207
CODE0	ends
	end
