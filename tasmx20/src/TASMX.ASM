	.286p
	locals

SEG1	segment para public 'CODE'
	assume	cs:SEG1
	db	9Ah	;@00000
	dd	L15440
	db	0C3h
L00006:	mov	word ptr ds:[38ACh], sp	;@00006
	call	far ptr L0FF94	;@0000A
	clc	;@0000F
	retf	;@00010
L00011:	mov	word ptr ds:[38ACh], sp	;@00011
	call	L0F5A0	;@00015
	clc	;@00018
	retf	;@00019
L0001A:	mov	word ptr ds:[38ACh], sp	;@0001A
	call	L0F67B	;@0001E
	clc	;@00021
	retf	;@00022
L00023:	mov	word ptr ds:[38ACh], sp	;@00023
	call	L0F916	;@00027
	clc	;@0002A
	retf	;@0002B
L0002C:	mov	word ptr ds:[38ACh], sp	;@0002C
	call	L0F91E	;@00030
	clc	;@00033
	retf	;@00034
L00035:	call	L0F635	;@00035
	retf	;@00038
L00039:	call	L0F93D	;@00039
	retf	;@0003C
	db	0	;@0003D
L0003E:	call	L004D1	;@0003E
	retf	;@00041
L00042:	call	L004DC	;@00042
	retf	;@00045
L00046:	call	L004F3	;@00046
	retf	;@00049
L0004A:	call	L013B3	;@0004A
	retf	;@0004D
L0004E:	call	L010C0	;@0004E
	retf	;@00051
L00052:	call	L01A84	;@00052
	retf	;@00055
L00056:	call	L017AE	;@00056
	retf	;@00059
L0005A:	call	L019F1	;@0005A
	retf	;@0005D
L0005E:	call	L01826	;@0005E
	retf	;@00061
	db	0E8h, 0F4h, 15h, 0CBh	;@00062
L00066:	call	L016A4	;@00066
	retf	;@00069
L0006A:	call	L016D9	;@0006A
	retf	;@0006D
L0006E:	call	L00EC7	;@0006E
	retf	;@00071
L00072:	call	L00F03	;@00072
	retf	;@00075
L00076:	call	L003CD	;@00076
	retf	;@00079
L0007A:	call	L057EE	;@0007A
	retf	;@0007D
L0007E:	call	L05751	;@0007E
	retf	;@00081
	db	9Ah	;@00082
	dd	L111E6
	db	0C3h, 9Ah
	dd	L11224
	db	0C3h, 9Ah
	dd	L10F01
	db	0C3h, 80h, 0E3h, 0Fh, 80h, 0FBh, 0Ah, 74h, 0Bh, 32h, 0FFh, 8Ah, 87h, 6, 6, 32h
	db	0E4h, 33h, 0D2h, 0C3h, 6, 55h, 56h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0E8h, 0D8h, 0Ch, 0E8h, 7Fh, 34h, 5Eh, 5Dh, 7, 0C3h, 26h, 8Ah, 5Eh, 7, 80h, 0E3h
	db	3Fh, 74h, 1Dh, 0F6h, 0C3h, 20h, 75h, 0Dh, 80h, 0FBh, 4, 74h, 8, 33h, 0D2h, 0B8h
	db	1, 0, 23h, 0C0h, 0C3h, 22h, 0DBh, 26h, 8Bh, 46h, 18h, 26h, 8Bh, 56h, 1Ah, 0C3h
	db	26h, 80h, 4Eh, 10h, 80h, 22h, 0DBh, 0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 77h
	db	26h, 8Bh, 4Eh, 1Ch, 26h, 8Ah, 5Eh, 7, 0F6h, 0C3h, 20h, 75h, 51h, 80h, 0E3h, 3Fh
	db	74h, 64h, 80h, 0FBh, 10h, 74h, 5Fh, 80h, 0FBh, 3, 74h, 39h, 80h, 0FBh, 4, 74h
	db	0Ah, 80h, 0FBh, 5, 74h, 0Fh, 33h, 0C0h, 33h, 0D2h, 0C3h, 26h, 8Ah, 5Eh, 0Eh, 26h
	db	8Bh, 4Eh, 1Ch, 0EBh, 29h, 9Ah
	dd	L101F7
	db	3Bh, 6, 7Eh, 51h, 75h, 0Ah, 22h, 0DBh, 0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 0C3h
	db	22h, 0DBh, 26h, 8Bh, 46h, 12h, 26h, 8Bh, 56h, 14h, 0C3h, 9Ah
	dd	L101F7
	db	8Bh, 0C8h, 0B3h, 0Ah, 0E8h, 42h, 0FFh, 50h, 52h, 0E8h, 64h, 0FFh, 5Fh, 59h, 8Bh, 0D8h
	db	0E8h, 35h, 4Dh, 8Bh, 7, 8Bh, 57h, 2, 32h, 0DBh, 0FEh, 0CBh, 0C3h, 26h, 8Ah, 5Eh
	db	7, 80h, 0E3h, 3Fh, 74h, 0F6h, 80h, 0FBh, 10h, 74h, 0F1h, 0F6h, 0C3h, 20h, 75h, 32h
	db	80h, 0FBh, 4, 74h, 22h, 80h, 0FBh, 5, 74h, 0A1h, 80h, 0FBh, 3, 74h, 9, 33h
	db	0D2h, 33h, 0C0h, 32h, 0DBh, 0FEh, 0CBh, 0C3h, 9Ah
	dd	L101F7
	db	8Bh, 0C8h, 0B3h, 0Ah, 0E8h, 0F5h, 0FEh, 22h, 0DBh, 0C3h, 22h, 0DBh, 26h, 8Bh, 46h, 14h
	db	26h, 8Bh, 56h, 16h, 0C3h, 80h, 0E3h, 0Fh, 74h, 0F0h, 80h, 0FBh, 7, 72h, 0EBh, 80h
	db	0FBh, 0Ah, 74h, 0E6h, 0B8h, 0, 0, 8Bh, 0D0h, 0C3h, 26h, 8Ah, 5Eh, 7, 80h, 0E3h
	db	3Fh, 74h, 6Dh, 80h, 0FBh, 0Dh, 74h, 18h, 80h, 0FBh, 0Ah, 74h, 27h, 0B9h, 58h, 10h
	db	9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0E8h, 4Ah, 33h, 33h, 0C0h, 8Bh, 0D0h, 0EBh, 4Ch, 6, 55h, 0E8h, 0F4h, 1Ah
	db	9Ah
	dd	L101E0
	db	26h, 8Bh, 4Eh, 8, 5Dh, 7, 32h, 0DBh, 0EBh, 1Fh, 26h, 8Ah, 4Eh, 0Eh, 32h, 0EDh
	db	6, 55h, 26h, 8Bh, 46h, 10h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 5Eh, 8, 5Dh, 7, 26h, 2Ah, 5Eh, 0Eh, 26h, 2Ah, 5Eh, 0Fh, 33h, 0C0h
	db	33h, 0D2h, 0E3h, 13h, 0F9h, 0D1h, 0D0h, 0D1h, 0D2h, 0E2h, 0F9h, 22h, 0DBh, 74h, 8, 0D1h
	db	0E0h, 0D1h, 0D2h, 0FEh, 0CBh, 75h, 0F8h, 32h, 0DBh, 0FEh, 0CBh, 0C3h, 26h, 8Ah, 5Eh, 7
	db	80h, 0E3h, 3Fh, 74h, 3Dh, 80h, 0FBh, 0Dh, 74h, 18h, 80h, 0FBh, 0Ah, 74h, 27h, 0B9h
	db	58h, 10h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0E8h, 0D3h, 32h, 33h, 0C0h, 8Bh, 0D0h, 0EBh, 1Ch, 6, 55h, 0E8h, 7Dh, 1Ah
	db	9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 8, 5Dh, 7, 33h, 0D2h, 0EBh, 8, 26h, 8Ah, 46h, 0Eh, 32h, 0E4h
	db	33h, 0D2h, 32h, 0DBh, 0FEh, 0CBh, 0C3h, 26h, 81h, 4Eh, 8, 0, 40h, 26h, 80h, 4Eh
	db	7, 80h, 0C3h, 26h, 81h, 4Eh, 8, 0, 20h, 0C3h, 56h, 0E8h, 2Dh, 0, 26h, 8Bh
	db	6Eh, 8, 81h, 0E5h, 0FFh, 1Fh, 9Ah
	dd	L12F55
	db	5Eh, 0C3h, 56h, 0E8h, 1Ah, 0, 26h, 8Bh, 6Eh, 8, 81h, 0E5h, 0FFh, 1Fh, 9Ah
	dd	L12F7E
	db	5Eh, 0C3h, 56h, 0E8h, 7, 0, 9Ah
	dd	L12F73
	db	5Eh, 0C3h, 8Bh, 0FAh, 8Bh, 0D3h, 8Bh, 0D9h, 8Bh, 0F0h, 26h, 8Bh, 46h, 4, 26h, 8Ah
	db	4Eh, 9, 0D0h, 0C1h, 83h, 0E1h, 1, 26h, 2, 4Eh, 6, 0C3h
L002DE:	mov	si, 2E4h	;@002DE
	jmp	L003CD	;@002E1
	db	9Ah	;@002E4
	dd	L101E0
	db	26h, 0F6h, 46h, 7, 80h, 75h, 1, 0C3h, 8Bh, 0D0h, 26h, 8Bh, 46h, 0Ch, 26h, 0F7h
	db	46h, 8, 0, 40h, 75h, 3, 0E9h, 25h, 76h, 0E9h, 2Bh, 76h
L00305:	test	word ptr ds:[38B6h], 800h	;@00305
	je	@@1	;@0030B
	mov	si, 313h	;@0030D
	jmp	L003CD	;@00310
	db	9Ah	;@00313
	dd	L101E0
	db	26h, 0F6h, 46h, 7, 90h, 75h, 8, 26h, 0F7h, 46h, 8, 0, 20h, 75h, 1
@@1:	ret	;@00327
	db	8Bh, 0D0h, 26h, 8Bh, 46h, 0Ch, 0E9h, 8, 76h	;@00328
L00331:	mov	si, 337h	;@00331
	jmp	L003CD	;@00334
	db	9Ah	;@00337
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 0A8h, 20h, 74h, 1, 0C3h, 24h, 3Fh, 3Ch, 1, 74h, 19h, 3Ch
	db	2, 74h, 15h, 3Ch, 3, 74h, 11h, 3Ch, 0Dh, 74h, 0Dh, 3Ch, 7, 74h, 9, 3Ch
	db	8, 74h, 5, 3Ch, 0Eh, 74h, 1, 0C3h, 26h, 0C7h, 46h, 0Eh, 0, 0, 0C3h
L0036B:	mov	si, 370h	;@0036B
	jmp	short L003CD	;@0036E
	db	9Ah	;@00370
	dd	L101E0
	db	8Bh, 0D0h, 26h, 8Ah, 46h, 7, 0A8h, 20h, 74h, 1, 0C3h, 24h, 3Fh, 3Ch, 1, 74h
	db	40h, 3Ch, 2, 74h, 3Ch, 3Ch, 0Dh, 74h, 38h, 3Ch, 3, 74h, 34h, 3Ch, 7, 74h
	db	30h, 3Ch, 8, 74h, 5, 3Ch, 0Eh, 74h, 28h, 0C3h, 26h, 8Bh, 4Eh, 0Eh, 0E3h, 21h
	db	6, 55h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	8Bh, 0FDh, 83h, 0C7h, 8, 0E8h, 0E2h, 56h, 3Bh, 0C2h, 75h, 0Ah, 0E8h, 0F8h, 56h, 5Dh
	db	7, 0E8h, 28h, 31h, 0EBh, 2, 5Dh, 7, 26h, 0C7h, 46h, 0Eh, 0, 0, 0C3h
L003CD:	mov	word ptr ds:[39CEh], si	;@003CD
	mov	es, word ptr ds:[39B8h]	;@003D1
	xor	bx, bx	;@003D5
	mov	cx, word ptr ds:[39BCh]	;@003D7
@@1:	mov	ax, word ptr es:[bx]	;@003DB
	and	ax, ax	;@003DE
	jne	@@3	;@003E0
@@2:	inc	bx	;@003E2
	inc	bx	;@003E3
	loop	@@1	;@003E4
	ret	;@003E6
@@3:	push	bx	;@003E7
	push	cx	;@003E8
	call	word ptr ds:[39CEh]	;@003E9
	pop	cx	;@003ED
	pop	bx	;@003EE
	mov	es, word ptr ds:[39B8h]	;@003EF
	jmp	@@2	;@003F3
L003F5:	mov	al, byte ptr [bx]	;@003F5
	cmp	al, 30h	;@003F7
	jb	L0040F	;@003F9
	cmp	al, 39h	;@003FB
	ja	L0040F	;@003FD
L003FF:	call	L0040F	;@003FF
	mov	ax, dx	;@00402
	call	far ptr L101E0	;@00404
	mov	byte ptr es:[bp+7], 0Bh	;@00409
	ret	;@0040E
L0040F:	push	si	;@0040F
	call	L032EB	;@00410
	jb	@@1	;@00413
	mov	dx, word ptr es:[bp]	;@00415
	mov	ax, dx	;@00419
	call	far ptr L101E0	;@0041B
	mov	ax, word ptr es:[bp+0Ch]	;@00420
	pop	si	;@00424
	ret	;@00425
@@1:	call	@@2	;@00426
	xor	dx, dx	;@00429
	call	L03378	;@0042B
	pop	si	;@0042E
	ret	;@0042F
@@2:	cmp	word ptr ds:[39C4h], 0	;@00430
	jne	@@3	;@00435
	mov	ax, 2	;@00437
	mov	cx, 200h	;@0043A
	call	far ptr L100B0	;@0043D
	mov	word ptr ds:[39C4h], cx	;@00442
	mov	word ptr ds:[39C2h], ax	;@00446
@@3:	mov	ax, word ptr ds:[39C2h]	;@00449
	add	word ptr ds:[39C2h], 2	;@0044C
	sub	word ptr ds:[39C4h], 2	;@00451
	ret	;@00456
L00457:	mov	ax, cx	;@00457
	shl	ax, 1	;@00459
	push	cx	;@0045B
	mov	cx, ax	;@0045C
	call	far ptr L100B0	;@0045E
	pop	cx	;@00463
	push	ax	;@00464
@@1:	push	cx	;@00465
	push	bx	;@00466
	mov	cl, byte ptr [bx]	;@00467
	xor	ch, ch	;@00469
	inc	bx	;@0046B
	push	ax	;@0046C
	call	L032EB	;@0046D
@@2:	jae	@@2	;@00470
	pop	ax	;@00472
	call	L03378	;@00473
	call	far ptr L101E0	;@00476
	or	byte ptr es:[bp+7], 40h	;@0047B
	add	ax, 2	;@00480
	pop	bx	;@00483
	mov	cl, byte ptr [bx]	;@00484
	xor	ch, ch	;@00486
	inc	bx	;@00488
	add	bx, cx	;@00489
	pop	cx	;@0048B
	loop	@@1	;@0048C
	pop	ax	;@0048E
	ret	;@0048F
L00490:	and	al, 40h	;@00490
@@1:	push	cx	;@00492
	push	di	;@00493
	mov	cl, byte ptr [bx]	;@00494
	inc	bx	;@00496
	xor	ch, ch	;@00497
	test	cl, 80h	;@00499
	je	@@2	;@0049C
	and	cl, 7Fh	;@0049E
	mov	dl, byte ptr [bx]	;@004A1
	xor	dh, dh	;@004A3
	jmp	short @@3	;@004A5
@@2:	push	bx	;@004A7
	push	cx	;@004A8
	push	ax	;@004A9
	call	L0040F	;@004AA
	mov	ax, dx	;@004AD
	call	far ptr L101E0	;@004AF
	pop	ax	;@004B4
	pop	cx	;@004B5
	pop	bx	;@004B6
	or	byte ptr es:[bp+7], al	;@004B7
@@3:	add	bx, cx	;@004BB
	pop	di	;@004BD
	pop	cx	;@004BE
	mov	word ptr [di], dx	;@004BF
	inc	di	;@004C1
	inc	di	;@004C2
	loop	@@1	;@004C3
	ret	;@004C5
L004C6:	and	word ptr es:[bp+8], 0E000h	;@004C6
	or	word ptr es:[bp+8], bx	;@004CC
	ret	;@004D0
L004D1:	mov	cl, byte ptr es:[bp+6]	;@004D1
	les	di, dword ptr es:[bp]	;@004D5
	xor	ch, ch	;@004D9
	ret	;@004DB
L004DC:	mov	cl, byte ptr es:[bp+9]	;@004DC
	rol	cl, 1	;@004E0
	and	cx, 1	;@004E2
	add	cl, byte ptr es:[bp+6]	;@004E5
	mov	ax, word ptr es:[bp+4]	;@004E9
	call	far ptr L1035F	;@004ED
	ret	;@004F2
L004F3:	call	far ptr L101E0	;@004F3
	mov	al, byte ptr es:[bp+7]	;@004F8
	mov	di, word ptr es:[bp+1Ch]	;@004FC
	ret	;@00500
	db	0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 3, 33h, 0DBh, 0C3h, 0F6h, 0C3h	;@00501
	db	20h, 74h, 0F8h, 83h, 0E3h, 0Fh, 83h, 0FBh, 0Ah, 74h, 7, 0D1h, 0E3h
	db	8Bh, 9Fh, 10h, 6, 0C3h
L00520:	push	es	;@00520
	push	bp	;@00521
	push	si	;@00522
	call	far ptr L101E0	;@00523
	call	L00D8C	;@00528
	call	L03544	;@0052B
	pop	si	;@0052E
	pop	bp	;@0052F
	pop	es	;@00530
	ret	;@00531
L00532:	test	word ptr ds:[38B6h], 4000h	;@00532
	jne	@@2	;@00538
@@1:	xor	bx, bx	;@0053A
	ret	;@0053C
@@2:	test	bl, 20h	;@0053D
	je	@@1	;@00540
	and	bx, 0Fh	;@00542
	cmp	bx, 0Ah	;@00545
	je	L00520	;@00548
	shl	bx, 1	;@0054A
	mov	di, 624h	;@0054C
	test	byte ptr ds:[51BFh], 20h	;@0054F
	je	@@3	;@00554
	mov	di, 638h	;@00556
@@3:	mov	bx, word ptr [bx+di]	;@00559
	ret	;@0055B
L0055C:	call	L00532	;@0055C
	or	bx, 1000h	;@0055F
	ret	;@00563
	db	0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 3, 33h, 0DBh, 0C3h, 33h, 0FFh, 0F6h, 0C3h, 20h	;@00564
	db	74h, 0Ch, 8Bh, 0FBh, 83h, 0E7h, 0Fh, 83h, 0FFh, 0Ah, 74h, 1Dh, 0D1h, 0E7h, 8Bh, 8Dh
	db	0D3h, 39h, 0E3h, 3, 8Bh, 0D9h, 0C3h, 56h, 57h, 8Bh, 9Dh, 10h, 6, 9Ah
	dd	L131A9
	db	5Fh, 89h, 9Dh, 0D3h, 39h, 5Eh, 0C3h, 56h, 9Ah
	dd	L101E0
	db	0E8h, 0E6h, 7, 0E8h, 0A5h, 2Fh, 5Eh, 0C3h, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 3
	db	33h, 0DBh, 0C3h, 33h, 0FFh, 0F6h, 0C3h, 20h, 74h, 0Ch, 8Bh, 0FBh, 83h, 0E7h, 0Fh, 83h
	db	0FFh, 0Ah, 74h, 1Dh, 0D1h, 0E7h, 8Bh, 8Dh, 0E7h, 39h, 0E3h, 3, 8Bh, 0D9h, 0C3h, 56h
	db	57h, 8Bh, 9Dh, 10h, 6, 9Ah
	dd	L131C2
	db	5Fh, 89h, 9Dh, 0E7h, 39h, 5Eh, 0C3h, 56h, 9Ah
	dd	L101E0
	db	0E8h, 9Fh, 7, 0E8h, 7Eh, 2Fh, 5Eh, 0C3h, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 3
	db	33h, 0DBh, 0C3h, 33h, 0FFh, 0F6h, 0C3h, 20h, 74h, 0Ch, 8Bh, 0FBh, 83h, 0E7h, 0Fh, 83h
	db	0FFh, 0Ah, 74h, 1Dh, 0D1h, 0E7h, 8Bh, 8Dh, 0FBh, 39h, 0E3h, 3, 8Bh, 0D9h, 0C3h, 56h
	db	57h, 8Bh, 9Dh, 10h, 6, 9Ah
	dd	L131CD
	db	5Fh, 89h, 9Dh, 0FBh, 39h, 5Eh, 0C3h, 56h, 9Ah
	dd	L101E0
	db	0E8h, 58h, 7, 0E8h, 57h, 2Fh, 5Eh, 0C3h, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 3
	db	33h, 0DBh, 0C3h, 33h, 0FFh, 0F6h, 0C3h, 20h, 74h, 0Ch, 8Bh, 0FBh, 83h, 0E7h, 0Fh, 83h
	db	0FFh, 0Ah, 74h, 1Dh, 0D1h, 0E7h, 8Bh, 8Dh, 0Fh, 3Ah, 0E3h, 3, 8Bh, 0D9h, 0C3h, 56h
	db	57h, 8Bh, 9Dh, 10h, 6, 9Ah
	dd	L131D7
	db	5Fh, 89h, 9Dh, 0Fh, 3Ah, 5Eh, 0C3h, 56h, 9Ah
	dd	L101E0
	db	0E8h, 11h, 7, 0E8h, 30h, 2Fh, 5Eh, 0C3h, 26h, 0F6h, 46h, 7, 3Fh, 75h, 5, 26h
	db	80h, 4Eh, 10h, 0Ah, 0C3h, 26h, 0F6h, 46h, 7, 3Fh, 75h, 5, 26h, 80h, 4Eh, 10h
	db	6, 0C3h, 26h, 0F6h, 46h, 7, 3Fh, 75h, 5, 26h, 80h, 4Eh, 10h, 1, 0C3h, 22h
	db	0E4h, 75h, 1, 0C3h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 80h, 7Eh, 7, 0Bh, 5Dh, 7, 0C3h, 22h, 0E4h, 74h, 0Fh, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 80h, 7Eh, 7, 0Bh, 5Dh, 7, 0C3h, 22h, 0C0h, 0C3h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 24h, 3Fh, 3Ch, 1, 74h, 0Ch, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 0Ch, 0C3h, 52h, 0E8h, 0EFh, 15h, 5Ah, 9Ah
	dd	L101E0
	db	26h, 83h, 7Eh, 0Ah, 0, 74h, 0E3h, 26h, 8Bh, 46h, 8, 9Ah
	dd	L1035F
	db	26h, 8Bh, 15h, 0EBh, 0D5h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 10h, 80h, 5Dh, 7, 0C3h
L0071C:	push	ax	;@0071C
	push	es	;@0071D
	push	bp	;@0071E
	call	far ptr L101E0	;@0071F
	mov	al, byte ptr es:[bp+7]	;@00724
	pop	bp	;@00728
	pop	es	;@00729
	and	al, 3Fh	;@0072A
	cmp	al, 29h	;@0072C
	pop	ax	;@0072E
	ret	;@0072F
L00730:	mov	byte ptr es:[bp+19h], 1	;@00730
	ret	;@00735
	db	26h, 80h, 7Eh, 19h, 0, 0C3h, 26h, 8Ah, 46h, 18h, 24h, 0E0h, 3Ch, 20h, 0C3h, 26h	;@00736
	db	8Ah, 46h, 18h, 24h, 0E0h, 3Ch, 20h, 74h, 2, 3Ch, 40h, 0C3h, 26h, 8Ah, 46h, 18h
	db	24h, 0E0h, 3Ch, 20h, 74h, 6, 3Ch, 40h, 74h, 2, 3Ch, 0A0h, 0C3h, 26h, 8Ah, 46h
	db	18h, 24h, 0E0h, 74h, 0Eh, 3Ch, 20h, 74h, 0Ah, 3Ch, 40h, 74h, 6, 3Ch, 0A0h, 74h
	db	2, 3Ch, 60h, 0C3h, 50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 5Dh, 7, 24h, 3Fh, 0A8h, 20h, 74h, 4, 0A8h, 10h, 58h, 0C3h
	db	3Ch, 9, 74h, 4, 32h, 0C0h, 58h, 0C3h, 32h, 0C0h, 0FEh, 0C8h, 58h, 0C3h
L007A0:	push	es	;@007A0
	push	bp	;@007A1
	call	far ptr L101E0	;@007A2
	test	byte ptr es:[bp+18h], 1	;@007A7
	pop	bp	;@007AC
	pop	es	;@007AD
	ret	;@007AE
	db	50h, 6, 55h, 9Ah	;@007AF
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 5Dh, 7, 24h, 3Fh, 3Ch, 5, 58h, 0C3h, 50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 24h, 3Fh, 3Ch, 5, 75h, 22h, 0F7h, 6, 7Ch, 51h, 0, 10h
	db	74h, 1Eh, 26h, 8Ah, 46h, 18h, 24h, 1Ch, 74h, 4, 3Ch, 18h, 75h, 0Eh, 26h, 8Ah
	db	46h, 18h, 24h, 0E0h, 74h, 6, 3Ch, 60h, 74h, 2, 3Ch, 80h, 5Dh, 7, 58h, 0C3h
	db	32h, 0C0h, 0FEh, 0C8h, 5Dh, 7, 58h, 0C3h, 50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 24h, 3Fh, 0A8h, 20h, 75h, 48h, 3Ch, 0, 74h, 3Dh, 3Ch, 10h
	db	74h, 3Eh, 3Ch, 0Bh, 74h, 3Ah, 3Ch, 2, 74h, 14h, 3Ch, 7, 74h, 10h, 3Ch, 3
	db	74h, 0Ch, 3Ch, 1, 74h, 8, 3Ch, 0Eh, 74h, 4, 3Ch, 8, 75h, 24h, 53h, 51h
	db	52h, 56h, 57h, 0E8h, 0A0h, 14h, 5Fh, 5Eh, 5Ah, 59h, 5Bh, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 5Dh, 7, 0EBh, 7, 26h, 80h, 4Eh, 10h, 1, 32h, 0C0h
	db	5Dh, 7, 58h, 0C3h
L00861:	push	es	;@00861
	push	bp	;@00862
	call	far ptr L101E0	;@00863
	cmp	word ptr es:[bp+0Ah], 0	;@00868
	pop	bp	;@0086D
	pop	es	;@0086E
	ret	;@0086F
	db	6, 55h, 9Ah	;@00870
	dd	L101E0
	db	26h, 0F6h, 46h, 7, 40h, 5Dh, 7, 0C3h, 50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 5Dh, 7, 24h, 3Fh, 3Ch, 7, 58h, 0C3h, 50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 5Dh, 7, 24h, 3Fh, 3Ch, 0Dh, 58h, 0C3h, 50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 5Dh, 7, 24h, 3Fh, 3Ch, 1, 74h, 2, 3Ch, 0Eh, 58h, 0C3h
	db	50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 5Dh, 7, 24h, 3Fh, 3Ch, 1, 58h, 0C3h, 50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 5Dh, 7, 24h, 3Fh, 3Ch, 0Dh, 74h, 2, 3Ch, 3, 58h, 0C3h
	db	50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 5Dh, 7, 24h, 3Fh, 3Ch, 4, 58h, 0C3h, 50h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 24h, 3Fh, 3Ch, 2, 5Dh, 7, 58h, 74h, 1, 0C3h, 9Ah
	dd	L101E0
	db	50h, 53h, 51h, 52h, 56h, 57h, 0E8h, 0BEh, 13h, 5Fh, 5Eh, 5Ah, 59h, 5Bh, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 74h, 4, 32h, 0C0h, 58h, 0C3h, 32h, 0C0h, 0FEh, 0C8h, 58h
	db	0C3h, 26h, 88h, 5Eh, 11h, 26h, 89h, 46h, 1Ch, 0A1h, 7Eh, 51h, 26h, 89h, 46h, 0Eh
	db	26h, 80h, 4Eh, 10h, 40h, 0C3h, 32h, 0FFh, 26h, 8Bh, 4Eh, 0Eh, 0E3h, 16h, 6, 55h
	db	8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0FEh, 0C7h, 26h, 0F6h, 46h, 18h, 1, 74h, 2, 0FEh, 0C7h, 5Dh, 7, 26h, 8Ah, 5Eh
	db	11h, 26h, 8Bh, 46h, 1Ch, 26h, 80h, 4Eh, 10h, 80h, 0C3h, 26h, 8Ah, 7Eh, 7, 80h
	db	0E7h, 3Fh, 74h, 6, 80h, 0FFh, 2, 75h, 6, 0C3h, 0B7h, 9, 0E9h, 22h, 2Bh, 0E9h
	db	1, 2Bh, 0E8h, 0F6h, 13h, 9Ah
	dd	L101E0
	db	0A1h, 7Ah, 51h, 26h, 89h, 46h, 0, 0A1h, 6Eh, 51h, 26h, 89h, 46h, 2, 26h, 0C6h
	db	46h, 6, 0, 0E8h, 0B5h, 11h, 26h, 80h, 4Eh, 6, 1, 0C3h, 9Ah
	dd	L101F7
	db	0BAh, 1, 0, 9Ah
	dd	L1015C
	db	0C3h, 0BBh, 10h, 1Ch, 26h, 0F6h, 46h, 7, 3Fh, 75h, 8, 26h, 80h, 4Eh, 7, 2
	db	0BBh, 0E2h, 1Bh, 0FFh, 0D3h, 9Ah
	dd	L101E0
	db	0E9h, 85h, 11h, 0E8h, 0E1h, 0FFh, 26h, 80h, 4Eh, 6, 1, 0C3h, 32h, 0DBh, 0EBh, 2
	db	0B3h, 1, 8Bh, 0D0h, 8Bh, 0FDh, 83h, 0C7h, 0Ah, 26h, 8Bh, 0Dh, 0E3h, 14h, 8Bh, 0C1h
	db	9Ah
	dd	L101E0
	db	26h, 39h, 56h, 2, 74h, 25h, 8Bh, 0FDh, 83h, 0C7h, 0, 0EBh, 0E7h, 0E8h, 79h, 13h
	db	26h, 89h, 5, 9Ah
	dd	L101E0
	db	33h, 0C0h, 26h, 89h, 46h, 6, 26h, 89h, 46h, 0, 26h, 89h, 56h, 2, 26h, 88h
	db	5Eh, 8, 0C3h, 8Bh, 0FAh, 0B9h, 46h, 10h, 0E9h, 0F3h, 2Ah, 8Bh, 0DEh, 33h, 0C9h, 41h
	db	0ACh, 3Ch, 0Dh, 74h, 11h, 3Ch, 20h, 76h, 0F6h, 81h, 7Ch, 0FFh, 3Bh, 3Bh, 74h, 6Bh
	db	41h, 0ACh, 3Ch, 0Dh, 75h, 0FAh, 8Bh, 0C1h, 6, 55h, 9Ah
	dd	L10215
	db	8Ah, 0D1h, 41h, 0D1h, 0E9h, 8Bh, 0F3h, 0F3h, 0A5h, 8Bh, 0D8h, 5Dh, 7, 8Bh, 0FDh, 83h
	db	0C7h, 8, 26h, 8Bh, 0Dh, 0E3h, 15h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 80h, 7Eh, 2, 4, 75h, 1Ch, 8Bh, 0FDh, 83h, 0C7h, 0, 0EBh, 0E6h, 0E8h, 3
	db	13h, 26h, 89h, 5, 9Ah
	dd	L101E0
	db	33h, 0C0h, 26h, 89h, 46h, 0, 26h, 88h, 46h, 2, 26h, 8Ah, 46h, 2, 0D0h, 0E0h
	db	26h, 2, 46h, 2, 98h, 5, 4, 0, 26h, 0FEh, 46h, 2, 8Bh, 0F8h, 26h, 89h
	db	1Bh, 26h, 88h, 53h, 2, 0C3h, 26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h, 6, 80h
	db	0FFh, 4, 75h, 6, 0C3h, 0B7h, 1, 0E9h, 0E7h, 29h, 0E9h, 0C6h, 29h, 80h, 0CBh, 20h
	db	0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 26h, 0F6h, 46h, 7, 3Fh, 74h, 2Dh, 0F6h, 6
	db	0C9h, 38h, 0Ch, 75h, 2Fh, 26h, 3Ah, 5Eh, 0Eh, 75h, 13h, 26h, 3Bh, 4Eh, 1Ch, 75h
	db	0Dh, 26h, 3Bh, 46h, 10h, 75h, 7, 26h, 3Bh, 56h, 12h, 75h, 1, 0C3h, 0B9h, 17h
	db	10h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0E9h, 1Dh, 2Ah, 26h, 80h, 4Eh, 7, 4, 26h, 88h, 5Eh, 0Eh, 26h, 89h
	db	4Eh, 1Ch, 26h, 89h, 46h, 10h, 26h, 89h, 56h, 12h, 0C3h, 26h, 8Bh, 46h, 10h, 26h
	db	8Bh, 56h, 12h, 26h, 8Ah, 5Eh, 0Eh, 26h, 8Bh, 4Eh, 1Ch, 0C3h, 26h, 8Ah, 7Eh, 7
	db	80h, 0E7h, 3Fh, 74h, 6, 80h, 0FFh, 0Ah, 75h, 6, 0C3h, 0B7h, 1, 0E9h, 6Bh, 29h
	db	0E9h, 4Ah, 29h, 26h, 0F6h, 46h, 7, 3Fh, 74h, 27h, 0F6h, 6, 0C9h, 38h, 0Ch, 75h
	db	25h, 26h, 3Ah, 56h, 0Fh, 75h, 0Dh, 26h, 3Ah, 76h, 0Eh, 75h, 7, 26h, 3Bh, 46h
	db	10h, 75h, 1, 0C3h, 0B9h, 17h, 10h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0E9h, 0B1h, 29h, 26h, 80h, 4Eh, 7, 0Ah, 26h, 88h, 56h, 0Fh, 26h, 88h
	db	76h, 0Eh, 26h, 89h, 46h, 10h, 0C3h, 6, 55h, 26h, 8Bh, 46h, 10h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 8, 5Dh, 7, 26h, 2Ah, 46h, 0Fh, 26h, 2Ah, 46h, 0Eh, 32h, 0E4h
	db	33h, 0D2h, 0C3h, 26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h, 6, 80h, 0FFh, 0Dh, 75h
	db	6, 0C3h, 0B7h, 1, 0E9h, 0F6h, 28h, 0E9h, 0D5h, 28h, 0BBh, 10h, 1Ch, 26h, 0F6h, 46h
	db	7, 3Fh, 75h, 8, 26h, 80h, 4Eh, 7, 0Dh, 0BBh, 0E2h, 1Bh, 0FFh, 0D3h, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 75h, 0Ah, 33h, 0C0h, 26h, 89h, 46h, 0Ah, 26h, 89h, 46h
	db	8, 0C3h, 0E8h, 0D2h, 0FFh, 26h, 80h, 4Eh, 6, 1, 0C3h, 0B3h, 21h, 3Dh, 8, 0
	db	76h, 9, 0B3h, 22h, 3Dh, 10h, 0, 76h, 2, 0B3h, 23h, 26h, 89h, 46h, 8, 26h
	db	88h, 5Eh, 0Ch, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 1, 0C3h, 0F6h, 6, 0C9h, 38h
	db	3, 75h, 48h, 26h, 8Bh, 4Eh, 0Ah, 52h, 6, 55h, 0E8h, 3Fh, 0, 9Ah
	dd	L131E1
	db	5Dh, 7, 8Bh, 0D3h, 26h, 89h, 56h, 0Eh, 26h, 8Ah, 5Eh, 0Ch, 58h, 9Ah
	dd	L101E0
	db	80h, 0E3h, 0DFh, 32h, 0FFh, 8Ah, 9Fh, 6, 6, 56h, 8Bh, 0F3h, 6, 55h, 52h, 0E8h
	db	80h, 0F8h, 9Ah
	dd	L10375
	db	33h, 0FFh, 5Dh, 55h, 9Ah
	dd	L12BC9
	db	5Bh, 5Dh, 7, 0E8h, 0B0h, 2Ch, 5Eh, 0C3h, 0E3h, 0FDh, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 4Eh, 0, 6, 55h, 0E8h, 0EEh, 0FFh, 5Dh, 7, 26h, 8Ah, 5Eh, 4, 22h
	db	0DBh, 74h, 0E3h, 26h, 8Bh, 46h, 2, 9Ah
	dd	L101E0
	db	56h, 0E8h, 41h, 0F8h, 9Ah
	dd	L10375
	db	8Bh, 2Eh, 16h, 6, 9Ah
	dd	L12BA1
	db	5Eh, 0C3h, 0E8h, 3Eh, 10h, 9Ah
	dd	L101E0
	db	33h, 0C0h, 33h, 0D2h, 26h, 8Bh, 4Eh, 0Ah, 0E3h, 45h, 50h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	58h, 33h, 0FFh, 33h, 0C9h, 26h, 8Ah, 5Eh, 4, 22h, 0DBh, 74h, 0Dh, 0D1h, 0E0h, 0D1h
	db	0D2h, 0F9h, 0D1h, 0D1h, 0D1h, 0D7h, 0FEh, 0CBh, 75h, 0F3h, 26h, 0FFh, 76h, 0, 50h, 52h
	db	51h, 57h, 56h, 26h, 8Bh, 46h, 6, 26h, 8Bh, 56h, 8, 0FFh, 0D6h, 5Eh, 5Fh, 59h
	db	23h, 0C8h, 23h, 0FAh, 5Ah, 58h, 0Bh, 0C1h, 0Bh, 0D7h, 59h, 0EBh, 0B9h, 0C3h, 0E8h, 0E6h
	db	0Fh, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 74h, 0Ch, 26h, 8Bh, 46h, 8, 26h, 8Ah, 5Eh, 0Ch, 26h
	db	8Bh, 6Eh, 0Eh, 0C3h, 26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h, 6, 80h, 0FFh, 3
	db	75h, 6, 0C3h, 0B7h, 9, 0E9h, 8Dh, 27h, 0E9h, 6Ch, 27h, 0BBh, 10h, 1Ch, 26h, 0F6h
	db	46h, 7, 3Fh, 75h, 8, 26h, 80h, 4Eh, 7, 3, 0BBh, 0E2h, 1Bh, 0FFh, 0D3h, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 75h, 0Ah, 33h, 0C0h, 26h, 89h, 46h, 0Ah, 26h, 89h, 46h
	db	8, 0C3h, 0E8h, 0D2h, 0FFh, 26h, 0F6h, 46h, 6, 1, 74h, 17h, 26h, 8Bh, 46h, 8
	db	0F6h, 6, 0C9h, 38h, 0Ch, 74h, 0Bh, 6, 55h, 50h, 9Ah
	dd	L1356E
	db	58h, 5Dh, 7, 0C3h, 6, 55h, 33h, 0C0h, 9Ah
	dd	L13124
	db	5Dh, 7, 26h, 89h, 46h, 8, 26h, 80h, 4Eh, 6, 1, 0C3h
L00D8C:	call	L01CE1	;@00D8C
	call	far ptr L101E0	;@00D8F
	test	byte ptr es:[bp+6], 1	;@00D94
	mov	ax, word ptr es:[bp+8]	;@00D99
	ret	;@00D9D
	db	51h, 57h, 8Bh, 0D0h, 8Bh, 0FDh, 83h, 0C7h, 0Ah, 26h, 8Bh, 0Dh, 0E3h, 14h, 8Bh, 0C1h	;@00D9E
	db	9Ah
	dd	L101E0
	db	26h, 39h, 56h, 2, 74h, 29h, 8Bh, 0FDh, 83h, 0C7h, 0, 0EBh, 0E7h, 0E8h, 0CCh, 0Fh
	db	26h, 89h, 5, 9Ah
	dd	L101E0
	db	33h, 0C0h, 26h, 89h, 46h, 0, 26h, 89h, 56h, 2, 26h, 88h, 5Eh, 4, 26h, 8Fh
	db	46h, 8, 26h, 8Fh, 46h, 6, 0C3h, 5Fh, 59h, 26h, 3Bh, 4Eh, 6, 75h, 7, 26h
	db	3Bh, 7Eh, 8, 75h, 1, 0C3h, 0B9h, 17h, 10h, 0E9h, 35h, 27h, 80h, 0CBh, 20h, 50h
	db	53h, 52h, 0E8h, 0E1h, 0Eh, 9Ah
	dd	L101E0
	db	5Ah, 5Bh, 58h, 52h, 8Bh, 0D0h, 8Bh, 0FDh, 83h, 0C7h, 0Ah, 26h, 8Bh, 0Dh, 0E3h, 14h
	db	8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 39h, 56h, 2, 74h, 33h, 8Bh, 0FDh, 83h, 0C7h, 0, 0EBh, 0E7h, 0E8h, 63h, 0Fh
	db	26h, 89h, 5, 9Ah
	dd	L101E0
	db	33h, 0C0h, 26h, 89h, 46h, 0, 26h, 89h, 56h, 2, 26h, 88h, 5Eh, 0Ah, 26h, 8Fh
	db	46h, 8, 0A1h, 70h, 51h, 26h, 89h, 46h, 4, 0A1h, 72h, 51h, 26h, 89h, 46h, 6
	db	0C3h, 8Bh, 0FAh, 5Ah, 0A1h, 70h, 51h, 26h, 3Bh, 46h, 4, 75h, 16h, 0A1h, 72h, 51h
	db	26h, 3Bh, 46h, 6, 75h, 0Dh, 26h, 3Ah, 5Eh, 0Ah, 75h, 7, 26h, 3Bh, 56h, 8
	db	75h, 1, 0C3h, 0B9h, 17h, 10h, 0E9h, 0AFh, 26h, 50h, 0E8h, 60h, 0Eh, 5Fh, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 74h, 38h, 26h, 8Bh, 4Eh, 0Ah, 0E3h, 24h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 4Eh, 0, 26h, 39h, 7Eh, 2, 75h, 0EDh, 26h, 8Ah, 5Eh, 0Ah, 26h, 8Bh
	db	4Eh, 8, 26h, 8Bh, 46h, 4, 26h, 8Bh, 56h, 6, 23h, 0FFh, 0C3h, 0B9h, 4Ch, 10h
	db	0E8h, 6Eh, 26h, 0B3h, 20h, 33h, 0C0h, 33h, 0D2h, 22h, 0DBh, 0C3h
L00EC7:	call	L01CE1	;@00EC7
	call	far ptr L101E0	;@00ECA
	mov	cx, word ptr es:[bp+0Ah]	;@00ECF
@@1:	jcxz	@@2	;@00ED3
	mov	ax, cx	;@00ED5
	call	far ptr L101E0	;@00ED7
	mov	ax, word ptr es:[bp+4]	;@00EDC
	mov	dx, word ptr es:[bp+6]	;@00EE0
	mov	bl, byte ptr es:[bp+0Ah]	;@00EE4
	mov	cx, word ptr es:[bp+8]	;@00EE8
	push	word ptr es:[bp]	;@00EEC
	push	ax	;@00EF0
	mov	ax, word ptr es:[bp+2]	;@00EF1
	call	far ptr L101E0	;@00EF5
	pop	ax	;@00EFA
	push	si	;@00EFB
	call	si	;@00EFC
	pop	si	;@00EFE
	pop	cx	;@00EFF
	jmp	@@1	;@00F00
@@2:	ret	;@00F02
L00F03:	call	L01CE1	;@00F03
	call	far ptr L101E0	;@00F06
	mov	bl, byte ptr es:[bp+8]	;@00F0B
	mov	cx, word ptr es:[bp+0Ah]	;@00F0F
@@1:	jcxz	@@2	;@00F13
	mov	ax, cx	;@00F15
	call	far ptr L101E0	;@00F17
	push	word ptr es:[bp]	;@00F1C
	mov	ax, word ptr es:[bp+2]	;@00F20
	call	far ptr L101E0	;@00F24
	mov	cl, byte ptr es:[bp+0Eh]	;@00F29
	mov	ch, bl	;@00F2D
	sub	ch, byte ptr es:[bp+0Fh]	;@00F2F
	sub	ch, cl	;@00F33
	push	bx	;@00F35
	push	si	;@00F36
	call	si	;@00F37
	pop	si	;@00F39
	pop	bx	;@00F3A
	pop	cx	;@00F3B
	jmp	@@1	;@00F3C
@@2:	ret	;@00F3E
	db	26h, 8Ah, 5Eh, 7, 80h, 0E3h, 3Fh, 74h, 6, 80h, 0FBh, 0Fh, 75h, 6, 0C3h, 0B7h	;@00F3F
	db	1, 0E9h, 62h, 25h, 0E9h, 41h, 25h, 26h, 0F6h, 46h, 7, 3Fh, 75h, 58h, 26h, 80h
	db	4Eh, 7, 0Fh, 0E8h, 0CBh, 0F4h, 26h, 89h, 46h, 0Eh, 26h, 89h, 46h, 10h, 9Ah
	dd	L101E0
	db	26h, 0C7h, 46h, 4, 0, 0, 0A1h, 8Ah, 51h, 26h, 89h, 46h, 2, 0A1h, 88h, 51h
	db	26h, 89h, 46h, 0, 0A1h, 7Eh, 51h, 26h, 89h, 46h, 0Eh, 0A1h, 70h, 51h, 26h, 89h
	db	46h, 10h, 0A1h, 72h, 51h, 26h, 89h, 46h, 12h, 6, 55h, 0E8h, 0E5h, 47h, 5Dh, 7
	db	74h, 8, 53h, 0B9h, 5Dh, 0, 0E8h, 81h, 25h, 5Bh, 26h, 89h, 46h, 14h, 26h, 89h
	db	5Eh, 16h, 0C3h, 26h, 8Bh, 4Eh, 10h, 0F6h, 6, 0C9h, 38h, 0Fh, 75h, 35h, 6, 55h
	db	8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0A1h, 8Ah, 51h, 26h, 3Bh, 46h, 2, 75h, 9, 0A1h, 88h, 51h, 26h, 3Bh, 46h, 0
	db	74h, 0Bh, 0E8h, 52h, 0F4h, 26h, 89h, 46h, 4, 5Dh, 7, 0EBh, 83h, 5Dh, 7, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0B9h, 17h, 10h, 0E9h, 37h, 25h, 0F6h, 6, 0C9h, 38h, 3, 75h, 6Bh, 6
	db	55h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0A1h, 8Ah, 51h, 8Bh, 16h, 88h, 51h, 26h, 8Bh, 4Eh, 2, 26h, 8Bh, 7Eh, 0, 9Ah
	dd	L11EA6
	db	72h, 67h, 74h, 4Bh, 26h, 8Bh, 4Eh, 4, 0E3h, 0B8h, 9Ah
	dd	L101F7
	db	8Bh, 0D8h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0A1h, 8Ah, 51h, 8Bh, 16h, 88h, 51h, 26h, 8Bh, 4Eh, 2, 26h, 8Bh, 7Eh, 0, 9Ah
	dd	L11EA6
	db	73h, 0D4h, 9Ah
	dd	L101F7
	db	8Bh, 0D0h, 0E8h, 0DFh, 0F3h, 5Dh, 7, 50h, 53h, 52h, 0E8h, 10h, 0FFh, 26h, 8Fh, 46h
	db	4, 58h, 9Ah
	dd	L101E0
	db	26h, 8Fh, 46h, 4, 0C3h, 0A1h, 70h, 51h, 26h, 89h, 46h, 10h, 0A1h, 72h, 51h, 26h
	db	89h, 46h, 12h, 9Ah
	dd	L101F7
	db	5Dh, 7, 26h, 89h, 46h, 10h, 0C3h, 5Dh, 7, 26h, 8Bh, 46h, 0Eh, 6, 55h, 9Ah
	dd	L101E0
	db	0A1h, 8Ah, 51h, 8Bh, 16h, 88h, 51h, 26h, 8Bh, 4Eh, 2, 26h, 8Bh, 7Eh, 0, 9Ah
	dd	L11EA6
	db	73h, 8Ch, 9Ah
	dd	L101F7
	db	8Bh, 0D0h, 0E8h, 81h, 0F3h, 50h, 52h, 0E8h, 0B5h, 0FEh, 26h, 8Fh, 46h, 4, 58h, 5Dh
	db	7, 26h, 89h, 46h, 0Eh, 0C3h
L010C0:	test	byte ptr ds:[38C9h], 0Fh	;@010C0
	jne	@@2	;@010C5
	mov	ax, word ptr es:[bp+10h]	;@010C7
	push	es	;@010CB
	push	bp	;@010CC
	call	far ptr L101E0	;@010CD
	mov	ax, word ptr es:[bp+2]	;@010D2
	cmp	ax, word ptr ds:[518Ah]	;@010D6
	jne	@@1	;@010DA
	mov	ax, word ptr es:[bp]	;@010DC
	cmp	ax, word ptr ds:[5188h]	;@010E0
	je	@@6	;@010E4
@@1:	pop	bp	;@010E6
	pop	es	;@010E7
	ret	;@010E8
@@2:	mov	ax, word ptr ds:[516Eh]	;@010E9
	mov	dx, word ptr ds:[517Ah]	;@010EC
	mov	cx, word ptr es:[bp+10h]	;@010F0
	push	es	;@010F4
	push	bp	;@010F5
	mov	ax, cx	;@010F6
	call	far ptr L101E0	;@010F8
	mov	di, word ptr es:[bp]	;@010FD
	mov	cx, word ptr es:[bp+2]	;@01101
	call	far ptr L11EA6	;@01105
	jae	@@3	;@0110A
	jmp	@@9	;@0110C
@@3:	jne	@@4	;@0110F
	jmp	@@9	;@01111
@@4:	mov	cx, word ptr es:[bp+4]	;@01114
	push	ax	;@01118
	call	far ptr L101F7	;@01119
	mov	bx, ax	;@0111E
	pop	ax	;@01120
	jcxz	@@5	;@01121
	mov	ax, cx	;@01123
	call	far ptr L101E0	;@01125
	mov	di, word ptr es:[bp]	;@0112A
	mov	cx, word ptr es:[bp+2]	;@0112E
	call	far ptr L11EA6	;@01132
	je	@@5	;@01137
	jae	@@4	;@01139
@@5:	pop	bp	;@0113B
	pop	es	;@0113C
	mov	word ptr es:[bp+10h], bx	;@0113D
	push	es	;@01141
	push	bp	;@01142
	mov	ax, bx	;@01143
	call	far ptr L101E0	;@01145
@@6:	mov	si, word ptr es:[bp+0Eh]	;@0114A
	mov	di, si	;@0114E
	mov	ax, word ptr es:[bp+10h]	;@01150
	mov	dx, word ptr es:[bp+12h]	;@01154
	push	es	;@01158
	push	bp	;@01159
	push	ax	;@0115A
	mov	ax, di	;@0115B
	call	far ptr L101E0	;@0115D
	test	byte ptr es:[bp+18h], 1	;@01162
	mov	bl, 1	;@01167
	je	@@7	;@01169
	inc	bl	;@0116B
@@7:	mov	ax, di	;@0116D
	call	far ptr L101E0	;@0116F
	pop	ax	;@01174
	cmp	word ptr es:[bp+10h], 0	;@01175
	je	@@8	;@0117A
	and	di, di	;@0117C
	je	@@8	;@0117E
	xor	di, di	;@01180
	mov	di, word ptr es:[bp+10h]	;@01182
@@8:	pop	bp	;@01186
	pop	es	;@01187
	pop	cx	;@01188
	pop	cx	;@01189
	mov	cx, word ptr es:[bp+14h]	;@0118A
	mov	bp, word ptr es:[bp+16h]	;@0118E
	ret	;@01192
@@9:	pop	bp	;@01193
	pop	es	;@01194
	mov	cx, word ptr es:[bp+0Eh]	;@01195
	push	es	;@01199
	push	bp	;@0119A
	push	ax	;@0119B
	mov	ax, cx	;@0119C
	call	far ptr L101E0	;@0119E
	pop	ax	;@011A3
	mov	di, word ptr es:[bp]	;@011A4
	mov	cx, word ptr es:[bp+2]	;@011A8
	call	far ptr L11EA6	;@011AC
	jb	@@10	;@011B1
	jmp	@@4	;@011B3
@@10:	mov	cx, word ptr es:[bp+4]	;@011B6
	jcxz	@@6	;@011BA
	mov	ax, cx	;@011BC
	call	far ptr L101E0	;@011BE
	jmp	@@10	;@011C3
	db	26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h, 18h, 26h, 8Bh, 4Eh, 1Ch, 80h, 0CBh, 20h	;@011C5
	db	3Ah, 0DFh, 75h, 12h, 80h, 0FBh, 2Ah, 75h, 5, 3Bh, 0C1h, 75h, 9, 0C3h, 32h, 0FFh
	db	0C3h, 0B7h, 1, 0E9h, 0CAh, 22h, 0E9h, 0A9h, 22h, 26h, 89h, 4Eh, 18h, 26h, 89h, 7Eh
	db	1Ah, 26h, 89h, 46h, 1Ch, 80h, 0CBh, 20h, 26h, 0F6h, 46h, 7, 3Fh, 75h, 62h, 26h
	db	8, 5Eh, 7, 53h, 52h, 56h, 26h, 8Bh, 46h, 1Ch, 0E8h, 0EFh, 0F2h, 5Fh, 58h, 59h
	db	6, 55h, 8Bh, 0F0h, 26h, 8Ah, 4Eh, 9, 0D0h, 0C1h, 80h, 0E1h, 1, 26h, 2, 4Eh
	db	6, 26h, 8Bh, 46h, 4, 53h, 26h, 8Bh, 5Eh, 18h, 26h, 8Bh, 56h, 1Ah, 5Dh, 9Ah
	dd	L12F2F
	db	5Dh, 7, 8Bh, 0Eh, 7Eh, 51h, 23h, 0C9h, 75h, 9, 50h, 9Ah
	dd	L101F7
	db	8Bh, 0C8h, 58h, 33h, 0D2h, 26h, 0FFh, 36h, 18h, 0, 26h, 0FFh, 36h, 1Ah, 0, 0E8h
	db	0DAh, 0, 26h, 8Fh, 6, 1Ah, 0, 26h, 8Fh, 6, 18h, 0, 0C3h, 8Bh, 0Eh, 7Eh
	db	51h, 23h, 0C9h, 75h, 7, 9Ah
	dd	L101F7
	db	8Bh, 0C8h, 26h, 3Bh, 4Eh, 0Eh, 74h, 0EAh, 0EBh, 5Eh, 8Bh, 3Eh, 7Eh, 51h, 8Bh, 0CFh
	db	26h, 89h, 46h, 1Ch, 80h, 0CBh, 20h, 26h, 0F6h, 46h, 7, 3Fh, 75h, 38h, 26h, 8
	db	5Eh, 7, 51h, 0E8h, 68h, 0F2h, 26h, 8Ah, 4Eh, 9, 0D0h, 0C1h, 80h, 0E1h, 1, 26h
	db	2, 4Eh, 6, 6, 55h, 56h, 26h, 8Bh, 46h, 4, 8Bh, 0EBh, 9Ah
	dd	L12F1D
	db	5Eh, 5Dh, 7, 59h, 23h, 0C9h, 75h, 9, 50h, 9Ah
	dd	L101F7
	db	8Bh, 0C8h, 58h, 33h, 0D2h, 0EBh, 6Ch, 23h, 0C9h, 75h, 7, 9Ah
	dd	L101F7
	db	8Bh, 0C8h, 26h, 3Bh, 4Eh, 0Eh, 75h, 1, 0C3h, 0B9h, 17h, 90h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0E9h, 44h, 22h, 26h, 89h, 46h, 1Ch, 80h, 0CBh, 20h, 0A1h, 70h, 51h, 8Bh
	db	16h, 72h, 51h, 8Bh, 0Eh, 7Eh, 51h, 26h, 0F6h, 46h, 7, 3Fh, 74h, 30h, 0F6h, 6
	db	0C9h, 38h, 4, 75h, 2Dh, 26h, 3Bh, 46h, 10h, 75h, 0Ch, 26h, 3Bh, 56h, 12h, 75h
	db	6, 26h, 3Bh, 4Eh, 0Eh, 74h, 5Fh, 0B9h, 17h, 10h, 0F6h, 6, 0C9h, 38h, 8, 74h
	db	3, 0B9h, 8Eh, 10h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0E9h, 0FBh, 21h, 26h, 8, 5Eh, 7, 26h, 89h, 4Eh, 0Eh, 26h, 89h, 46h
	db	10h, 26h, 89h, 56h, 12h, 33h, 0C0h, 26h, 0C7h, 46h, 18h, 1, 0, 26h, 89h, 46h
	db	1Ah, 26h, 0C7h, 46h, 14h, 1, 0, 26h, 89h, 46h, 16h, 26h, 8Ah, 5Eh, 7, 80h
	db	0E3h, 0Fh, 80h, 0FBh, 7, 72h, 16h, 80h, 0FBh, 0Ah, 73h, 11h, 6, 55h, 0E8h, 18h
	db	44h, 5Dh, 7, 75h, 9, 26h, 89h, 46h, 14h, 26h, 89h, 5Eh, 16h, 0C3h, 26h, 0F6h
	db	46h, 7, 10h, 75h, 0Ah, 53h, 0B9h, 5Dh, 0, 0E8h, 0A4h, 21h, 5Bh, 0EBh, 0E6h, 33h
	db	0C0h, 33h, 0DBh, 0EBh, 0E0h, 26h, 8Ah, 5Eh, 7, 80h, 0E3h, 0Fh, 80h, 0FBh, 7, 72h
	db	5, 80h, 0FBh, 0Ah, 72h, 8, 26h, 89h, 46h, 14h, 26h, 89h, 56h, 16h, 26h, 89h
	db	4Eh, 18h, 26h, 89h, 7Eh, 1Ah, 0C3h
L013B3:	test	byte ptr es:[bp+7], 10h	;@013B3
	jne	@@7	;@013B8
	mov	si, word ptr es:[bp+0Eh]	;@013BA
	mov	di, si	;@013BE
	mov	ax, word ptr es:[bp+10h]	;@013C0
	mov	dx, word ptr es:[bp+12h]	;@013C4
@@1:	push	ax	;@013C8
	push	es	;@013C9
	push	bp	;@013CA
	mov	bl, 1	;@013CB
	and	di, di	;@013CD
	je	@@2	;@013CF
	mov	ax, di	;@013D1
	call	far ptr L101E0	;@013D3
	test	byte ptr es:[bp+18h], 1	;@013D8
	je	@@2	;@013DD
	inc	bl	;@013DF
@@2:	pop	bp	;@013E1
	pop	es	;@013E2
	pop	ax	;@013E3
	test	word ptr ds:[517Ch], 1000h	;@013E4
	jne	@@3	;@013EA
	test	byte ptr ds:[5187h], 1	;@013EC
	je	@@5	;@013F1
@@3:	push	ax	;@013F3
	push	es	;@013F4
	push	bp	;@013F5
	and	di, di	;@013F6
	je	@@4	;@013F8
	mov	ax, di	;@013FA
	call	far ptr L101E0	;@013FC
	cmp	word ptr es:[bp+10h], 0	;@01401
	je	@@4	;@01406
	mov	di, word ptr es:[bp+10h]	;@01408
@@4:	pop	bp	;@0140C
	pop	es	;@0140D
	pop	ax	;@0140E
	test	word ptr ds:[517Ch], 1000h	;@0140F
	jne	@@6	;@01415
@@5:	mov	bh, byte ptr es:[bp+7]	;@01417
	and	bh, 0Fh	;@0141B
	cmp	bh, 7	;@0141E
	jb	@@6	;@01421
	cmp	bh, 0Ah	;@01423
	jae	@@6	;@01426
	mov	cx, word ptr es:[bp+14h]	;@01428
	mov	bp, word ptr es:[bp+16h]	;@0142C
	clc	;@01430
	ret	;@01431
@@6:	stc	;@01432
	ret	;@01433
@@7:	call	far ptr L101F7	;@01434
	mov	si, ax	;@01439
	xor	ax, ax	;@0143B
	xor	dx, dx	;@0143D
	mov	di, word ptr es:[bp+0Eh]	;@0143F
	cmp	si, di	;@01443
	jne	@@1	;@01445
	xor	bl, bl	;@01447
	jmp	@@6	;@01449
L0144B:	mov	ax, word ptr es:[bp+0Eh]	;@0144B
	ret	;@0144F
	db	26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h, 6, 80h, 0FFh, 6, 75h, 6, 0C3h, 0B7h	;@01450
	db	1, 0E9h, 51h, 20h, 0E9h, 30h, 20h, 26h, 0F6h, 46h, 7, 3Fh, 75h, 23h, 26h, 80h
	db	4Eh, 7, 6, 26h, 8Ah, 4Eh, 6, 32h, 0EDh, 56h, 6, 55h, 26h, 0C4h, 7Eh, 0
	db	9Ah
	dd	L10375
	db	9Ah
	dd	L12ECB
	db	5Dh, 7, 5Eh, 26h, 89h, 46h, 0Eh, 0C3h, 26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h
	db	0Bh, 80h, 0FFh, 10h, 74h, 5, 80h, 0FFh, 5, 75h, 6, 0C3h, 0B7h, 1, 0E9h, 0Ah
	db	20h, 0E9h, 0E9h, 1Fh, 0F6h, 0C3h, 2, 74h, 1Ah, 23h, 0FFh, 74h, 16h, 6, 55h, 8Bh
	db	0C7h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 5Eh, 18h, 80h, 0CBh, 2, 26h, 8Bh, 46h, 1Ah, 5Dh, 7, 8Bh, 0C8h, 26h
	db	8Ah, 56h, 7, 80h, 0E2h, 3Fh, 74h, 43h, 80h, 0FAh, 10h, 74h, 44h, 0F6h, 0C3h, 2
	db	75h, 0Ch, 26h, 3Ah, 5Eh, 18h, 75h, 0Ch, 26h, 3Bh, 4Eh, 1Ah, 75h, 6, 26h, 3Bh
	db	7Eh, 16h, 74h, 6, 0B9h, 51h, 0, 0E8h, 32h, 20h, 0A1h, 6Eh, 51h, 8Bh, 16h, 7Ah
	db	51h, 26h, 8Bh, 4Eh, 1Eh, 26h, 8Bh, 7Eh, 1Ch, 9Ah
	dd	L11EA6
	db	75h, 0Ah, 33h, 0C0h, 26h, 89h, 46h, 12h, 26h, 89h, 46h, 14h, 0C3h, 26h, 0C7h, 46h
	db	10h, 0, 0, 26h, 88h, 5Eh, 18h, 26h, 89h, 7Eh, 16h, 26h, 89h, 4Eh, 1Ah, 33h
	db	0C0h, 26h, 88h, 46h, 19h, 26h, 89h, 46h, 12h, 26h, 89h, 46h, 14h, 6, 26h, 0C4h
	db	7Eh, 0, 9Ah
	dd	L10375
	db	7, 26h, 8Ah, 56h, 18h, 26h, 8Bh, 5Eh, 16h, 0F6h, 0C2h, 2, 74h, 15h, 23h, 0DBh
	db	74h, 11h, 6, 55h, 50h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	58h, 26h, 8Bh, 5Eh, 0Eh, 5Dh, 7, 26h, 8Ah, 76h, 6, 6, 55h, 56h, 0E3h, 1Ah
	db	50h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	6, 26h, 0C4h, 7Eh, 0, 9Ah
	dd	L10375
	db	7, 8Bh, 0F0h, 58h, 26h, 8Ah, 6Eh, 6, 8Ah, 0CEh, 9Ah
	dd	L12EDE
	db	5Eh, 5Dh, 7, 26h, 89h, 46h, 0Eh, 8Bh, 0C8h, 26h, 8Bh, 46h, 10h, 23h, 0C0h, 74h
	db	14h, 6, 55h, 56h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 0Eh, 9Ah
	dd	L13529
	db	5Eh, 5Dh, 7, 0A1h, 7Ah, 51h, 26h, 89h, 46h, 1Ch, 0A1h, 6Eh, 51h, 26h, 89h, 46h
	db	1Eh, 26h, 80h, 66h, 7, 0C0h, 26h, 80h, 4Eh, 7, 5, 0C3h, 26h, 8Ah, 7Eh, 7
	db	80h, 0E7h, 3Fh, 74h, 28h, 80h, 0FFh, 10h, 74h, 12h, 80h, 0FFh, 5, 74h, 0Dh, 0B9h
	db	27h, 10h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0E9h, 3Ch, 1Fh, 26h, 83h, 7Eh, 10h, 0, 74h, 1Fh, 26h, 3Bh, 46h, 10h
	db	75h, 0E6h, 80h, 0FFh, 10h, 0C3h, 0B7h, 1, 50h, 0E8h, 0AEh, 1Eh, 58h, 75h, 9, 26h
	db	80h, 4Eh, 7, 10h, 26h, 89h, 46h, 10h, 32h, 0C0h, 0C3h, 26h, 89h, 46h, 10h, 80h
	db	0FFh, 10h, 74h, 20h, 26h, 8Bh, 4Eh, 0Eh, 6, 55h, 26h, 8Bh, 46h, 10h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 0Eh, 56h, 9Ah
	dd	L13529
	db	5Eh, 5Dh, 7, 32h, 0C0h, 0FEh, 0C8h, 0C3h, 26h, 8Ah, 46h, 7, 24h, 3Fh, 3Ch, 5
	db	75h, 9, 26h, 8Bh, 46h, 10h, 23h, 0C0h, 74h, 1, 0C3h, 9Ah
	dd	L101F7
	db	0C3h, 26h, 8Ah, 46h, 7, 24h, 3Fh, 3Ch, 5, 75h, 16h, 26h, 0F6h, 46h, 18h, 2
	db	74h, 0Fh, 26h, 8Bh, 46h, 16h, 23h, 0C0h, 74h, 7, 9Ah
	dd	L101E0
	db	0EBh, 0E0h, 9Ah
	dd	L101F7
	db	0C3h, 9Ah
	dd	L101F7
	db	0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 7, 0F6h, 6, 87h, 51h, 1, 74h, 7, 26h
	db	8Bh, 4Eh, 10h, 0E3h, 1, 0C3h, 50h, 9Ah
	dd	L101F7
	db	8Bh, 0C8h, 58h, 0C3h
L016A4:	mov	bx, word ptr es:[bp+10h]	;@016A4
	mov	cl, byte ptr es:[bp+18h]	;@016A8
	mov	ax, word ptr es:[bp+16h]	;@016AC
	mov	di, word ptr es:[bp+1Ah]	;@016B0
	ret	;@016B4
L016B5:	mov	ax, word ptr es:[bp+0Eh]	;@016B5
	mov	cx, word ptr es:[bp+10h]	;@016B9
	jcxz	@@1	;@016BD
	push	ax	;@016BF
	mov	ax, cx	;@016C0
	call	far ptr L101E0	;@016C2
	pop	ax	;@016C7
	mov	cx, word ptr es:[bp+0Eh]	;@016C8
	ret	;@016CC
@@1:	mov	cx, ax	;@016CD
	ret	;@016CF
L016D0:	mov	word ptr es:[bp+12h], ax	;@016D0
	mov	word ptr es:[bp+14h], dx	;@016D4
	ret	;@016D8
L016D9:	mov	ax, word ptr es:[bp+12h]	;@016D9
	mov	dx, word ptr es:[bp+14h]	;@016DD
	ret	;@016E1
	db	26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h, 6, 80h, 0FFh, 9, 75h, 6, 0C3h, 0B7h	;@016E2
	db	1, 0E9h, 0BFh, 1Dh, 0E9h, 9Eh, 1Dh, 26h, 0F6h, 46h, 7, 3Fh, 75h, 27h, 26h, 80h
	db	4Eh, 7, 9, 26h, 8Ah, 4Eh, 9, 0D0h, 0C1h, 83h, 0E1h, 1, 26h, 2, 4Eh, 6
	db	56h, 6, 55h, 26h, 8Bh, 46h, 4, 33h, 0EDh, 9Ah
	dd	L12F1D
	db	5Dh, 7, 5Eh, 26h, 89h, 46h, 0Eh, 0C3h, 26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h
	db	0Bh, 80h, 0FFh, 0Ch, 74h, 5, 80h, 0FFh, 8, 75h, 6, 0C3h, 0B7h, 1, 0E9h, 74h
	db	1Dh, 0E9h, 53h, 1Dh, 26h, 8Ah, 5Eh, 7, 80h, 0E3h, 3Fh, 74h, 54h, 80h, 0FBh, 8
	db	75h, 23h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 3Ah, 50h, 0E8h, 83h, 5, 5Bh, 6
	db	55h, 9Ah
	dd	L101E0
	db	8Bh, 0FDh, 83h, 0C7h, 8, 8Bh, 0C3h, 0E8h, 98h, 42h, 5Dh, 7, 75h, 20h, 0C3h, 0F6h
	db	6, 0C9h, 38h, 0Ch, 75h, 10h, 6, 55h, 50h, 8Bh, 0FDh, 83h, 0C7h, 0Eh, 0E8h, 81h
	db	42h, 58h, 5Dh, 7, 75h, 8, 8Bh, 0FDh, 83h, 0C7h, 0Eh, 0E9h, 0DAh, 42h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0B9h, 17h, 10h, 0E9h, 8Bh, 1Dh, 26h, 80h, 4Eh, 7, 0Ch, 8Bh, 0FDh, 83h
	db	0C7h, 0Eh, 0E9h, 28h, 43h
L017AE:	mov	di, bp	;@017AE
	add	di, 0Eh	;@017B0
	jmp	L05B53	;@017B3
	db	26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h, 6, 80h, 0FFh, 0Eh, 75h, 6, 0C3h, 0B7h	;@017B6
	db	5, 0E9h, 0EBh, 1Ch, 0E9h, 0CAh, 1Ch, 50h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 58h, 3Bh, 0C7h, 75h, 6, 0B9h, 34h, 10h, 0E9h, 4Ch, 1Dh, 50h, 0BBh, 10h
	db	1Ch, 26h, 0F6h, 46h, 7, 3Fh, 75h, 8, 26h, 80h, 4Eh, 7, 0Eh, 0BBh, 0E2h, 1Bh
	db	0FFh, 0D3h, 5Bh, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 74h, 1Ah, 0F6h, 6, 0C9h, 38h, 0Ch, 75h, 18h, 26h, 3Bh
	db	5Eh, 8, 74h, 16h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 0B9h, 17h, 10h, 0E9h, 10h, 1Dh, 26h, 80h, 4Eh, 6, 1, 26h, 89h, 5Eh
	db	8, 0C3h
L01826:	call	L01CE1	;@01826
	call	far ptr L101E0	;@01829
	test	byte ptr es:[bp+6], 1	;@0182E
	mov	ax, word ptr es:[bp+8]	;@01833
	ret	;@01837
L01838:	mov	bh, byte ptr es:[bp+7]	;@01838
	and	bh, 3Fh	;@0183C
	je	@@1	;@0183F
	cmp	bh, 1	;@01841
	jne	@@3	;@01844
	ret	;@01846
@@1:	mov	bh, 3	;@01847
	call	L034B5	;@01849
	test	word ptr ds:[517Ch], 1000h	;@0184C
	jne	@@2	;@01852
	mov	ax, word ptr es:[bp+0Ch]	;@01854
	call	L05BA0	;@01858
	jb	@@2	;@0185B
	xor	al, al	;@0185D
	dec	al	;@0185F
	ret	;@01861
@@2:	xor	al, al	;@01862
	ret	;@01864
@@3:	jmp	L03497	;@01865
	db	89h, 1Eh, 24h, 3Eh, 3, 0D9h, 0C6h, 7, 0Dh, 33h, 0C0h, 0A3h, 28h, 4Eh, 0A2h, 32h	;@01868
	db	4Eh, 51h, 0BBh, 10h, 1Ch, 26h, 0F6h, 46h, 7, 3Fh, 75h, 8, 26h, 80h, 4Eh, 7
	db	1, 0BBh, 0E2h, 1Bh, 0FFh, 0D3h, 59h, 50h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 58h, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 74h, 4Dh, 0F6h, 6, 0C9h, 38h, 0Ch, 75h, 22h, 26h, 3Bh
	db	4Eh, 0Eh, 75h, 16h, 0E3h, 13h, 26h, 8Bh, 46h, 0Ch, 57h, 9Ah
	dd	L1035F
	db	8Bh, 36h, 24h, 3Eh, 0F3h, 0A6h, 5Fh, 75h, 1, 0C3h, 0B9h, 17h, 10h, 0E9h, 5Fh, 1Ch
	db	51h, 26h, 8Bh, 56h, 0Eh, 23h, 0D2h, 74h, 9, 26h, 8Bh, 46h, 0Ch, 9Ah
	dd	L102C9
	db	26h, 8Bh, 56h, 0Ah, 23h, 0D2h, 74h, 9, 26h, 8Bh, 46h, 8, 9Ah
	dd	L102C9
	db	59h, 26h, 80h, 4Eh, 6, 1, 33h, 0C0h, 26h, 89h, 46h, 8, 26h, 89h, 46h, 0Ah
	db	26h, 89h, 4Eh, 0Eh, 0E3h, 19h, 8Bh, 0C1h, 6, 9Ah
	dd	L10215
	db	8Bh, 36h, 24h, 3Eh, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 7, 26h, 89h, 46h
	db	0Ch, 33h, 0F6h, 0C6h, 6, 0D2h, 39h, 0Ah, 0E8h, 0FBh, 0Fh, 75h, 5, 83h, 0C6h, 2
	db	0EBh, 0F6h, 0C6h, 6, 0D2h, 39h, 0, 8Bh, 0C6h, 26h, 89h, 46h, 0Ah, 8Bh, 0C8h, 6
	db	9Ah
	dd	L10215
	db	0BEh, 28h, 46h, 0D1h, 0E9h, 0F3h, 0A5h, 7, 26h, 89h, 46h, 8, 0C3h
L01950:	push	ax	;@01950
	mov	bx, 1C10h	;@01951
	test	byte ptr es:[bp+7], 3Fh	;@01954
	jne	@@1	;@01959
	or	byte ptr es:[bp+7], 1	;@0195B
	mov	bx, 1BE2h	;@01960
@@1:	call	bx	;@01963
	pop	dx	;@01965
	push	ax	;@01966
	call	far ptr L101F7	;@01967
	mov	di, ax	;@0196C
	pop	ax	;@0196E
	call	far ptr L101E0	;@0196F
	test	byte ptr es:[bp+6], 1	;@01974
	je	@@5	;@01979
	test	byte ptr ds:[38C9h], 0Ch	;@0197B
	jne	@@3	;@01980
	cmp	word ptr es:[bp+0Ah], 2	;@01982
	jne	@@2	;@01987
	mov	ax, word ptr es:[bp+8]	;@01989
	push	di	;@0198D
	call	far ptr L1035F	;@0198E
	cmp	dx, word ptr es:[di]	;@01993
	pop	di	;@01996
	je	@@6	;@01997
@@2:	mov	cx, 1017h	;@01999
	jmp	L0352C	;@0199C
@@3:	push	dx	;@0199F
	mov	dx, word ptr es:[bp+0Ah]	;@019A0
	and	dx, dx	;@019A4
	je	@@4	;@019A6
	mov	ax, word ptr es:[bp+8]	;@019A8
	call	far ptr L102C9	;@019AC
@@4:	pop	dx	;@019B1
@@5:	or	byte ptr es:[bp+6], 1	;@019B2
	mov	ax, 2	;@019B7
	mov	word ptr es:[bp+0Ah], ax	;@019BA
	push	es	;@019BE
	push	bp	;@019BF
	call	far ptr L10215	;@019C0
	mov	word ptr es:[di], dx	;@019C5
	pop	bp	;@019C8
	pop	es	;@019C9
	mov	word ptr es:[bp+8], ax	;@019CA
	push	es	;@019CE
	push	bp	;@019CF
	mov	ax, dx	;@019D0
	call	far ptr L101E0	;@019D2
	mov	cl, byte ptr es:[bp+6]	;@019D7
	xor	ch, ch	;@019DB
	les	di, dword ptr es:[bp]	;@019DD
	call	far ptr L10375	;@019E1
	pop	bp	;@019E6
	pop	es	;@019E7
	mov	word ptr es:[bp+0Ch], ax	;@019E8
	mov	word ptr es:[bp+0Eh], cx	;@019EC
@@6:	ret	;@019F0
L019F1:	call	L01CE1	;@019F1
	call	far ptr L101E0	;@019F4
	test	byte ptr es:[bp+6], 1	;@019F9
	je	@@1	;@019FE
	mov	ax, word ptr es:[bp+0Ch]	;@01A00
	mov	cx, word ptr es:[bp+0Eh]	;@01A04
@@1:	ret	;@01A08
L01A09:	and	byte ptr es:[bp+7], 0BFh	;@01A09
	mov	bh, byte ptr es:[bp+7]	;@01A0E
	and	bh, 3Fh	;@01A12
	je	@@1	;@01A15
	cmp	bh, 7	;@01A17
	jne	@@2	;@01A1A
	ret	;@01A1C
@@1:	mov	bh, 1	;@01A1D
	jmp	L034B5	;@01A1F
@@2:	jmp	L03497	;@01A22
L01A25:	push	ax	;@01A25
	mov	bx, 1C10h	;@01A26
	test	byte ptr es:[bp+7], 3Fh	;@01A29
	jne	@@1	;@01A2E
	or	byte ptr es:[bp+7], 7	;@01A30
	mov	bx, 1BE2h	;@01A35
@@1:	call	bx	;@01A38
	push	ax	;@01A3A
	call	far ptr L101F7	;@01A3B
	mov	di, ax	;@01A40
	pop	ax	;@01A42
	call	far ptr L101E0	;@01A43
	pop	ax	;@01A48
	test	byte ptr es:[bp+6], 1	;@01A49
	je	@@3	;@01A4E
	test	byte ptr ds:[38C9h], 0Ch	;@01A50
	jne	@@2	;@01A55
	push	es	;@01A57
	push	bp	;@01A58
	push	ax	;@01A59
	push	di	;@01A5A
	mov	di, bp	;@01A5B
	add	di, 8	;@01A5D
	call	L05A08	;@01A60
	pop	di	;@01A63
	pop	ax	;@01A64
	pop	bp	;@01A65
	pop	es	;@01A66
	je	@@2	;@01A67
	mov	cx, 1017h	;@01A69
	call	L0352C	;@01A6C
@@2:	mov	di, bp	;@01A6F
	add	di, 8	;@01A71
	jmp	L05A6E	;@01A74
@@3:	or	byte ptr es:[bp+6], 1	;@01A77
	mov	di, bp	;@01A7C
	add	di, 8	;@01A7E
	jmp	L05AD6	;@01A81
L01A84:	call	L01CE1	;@01A84
	call	far ptr L101E0	;@01A87
	test	byte ptr es:[bp+6], 1	;@01A8C
	je	@@1	;@01A91
	mov	di, bp	;@01A93
	add	di, 8	;@01A95
	call	L05B53	;@01A98
	xor	bl, bl	;@01A9B
	dec	bl	;@01A9D
@@1:	ret	;@01A9F
	db	26h, 8Ah, 7Eh, 7, 80h, 0E7h, 3Fh, 74h, 0Bh, 80h, 0FFh, 8, 74h	;@01AA0
	db	5, 80h, 0FFh, 0Ch, 75h, 6, 0C3h, 0B7h, 1, 0E9h, 0FCh, 19h, 0E9h
	db	0DBh, 19h
L01ABC:	push	ax	;@01ABC
	mov	al, byte ptr es:[bp+7]	;@01ABD
	mov	bx, 1C10h	;@01AC1
	and	al, 3Fh	;@01AC4
	je	@@2	;@01AC6
	cmp	al, 8	;@01AC8
	je	@@3	;@01ACA
	pop	bx	;@01ACC
	test	word ptr ds:[517Ch], 1000h	;@01ACD
	jne	@@1	;@01AD3
	push	es	;@01AD5
	push	bp	;@01AD6
	mov	di, bp	;@01AD7
	add	di, 0Eh	;@01AD9
	mov	ax, bx	;@01ADC
	call	L05A08	;@01ADE
	pop	bp	;@01AE1
	pop	es	;@01AE2
	jne	@@1	;@01AE3
	ret	;@01AE5
@@1:	call	far ptr L101F7	;@01AE6
	mov	di, ax	;@01AEB
	jmp	short @@4	;@01AED
@@2:	or	byte ptr es:[bp+7], 8	;@01AEF
	mov	bx, 1BE2h	;@01AF4
@@3:	call	bx	;@01AF7
	push	ax	;@01AF9
	call	far ptr L101F7	;@01AFA
	mov	di, ax	;@01AFF
	pop	ax	;@01B01
	call	far ptr L101E0	;@01B02
	pop	ax	;@01B07
	test	byte ptr es:[bp+6], 1	;@01B08
	je	@@6	;@01B0D
	test	byte ptr ds:[38C9h], 0Ch	;@01B0F
	jne	@@5	;@01B14
	push	es	;@01B16
	push	bp	;@01B17
	push	ax	;@01B18
	push	di	;@01B19
	mov	di, bp	;@01B1A
	add	di, 8	;@01B1C
	call	L05A08	;@01B1F
	pop	di	;@01B22
	pop	ax	;@01B23
	pop	bp	;@01B24
	pop	es	;@01B25
	je	@@5	;@01B26
@@4:	mov	cx, 1017h	;@01B28
	jmp	L0352C	;@01B2B
@@5:	mov	di, bp	;@01B2E
	add	di, 8	;@01B30
	jmp	L05A6E	;@01B33
@@6:	or	byte ptr es:[bp+6], 1	;@01B36
	mov	di, bp	;@01B3B
	add	di, 8	;@01B3D
	jmp	L05AD6	;@01B40
L01B43:	mov	al, byte ptr es:[bp+7]	;@01B43
	test	al, 20h	;@01B47
	jne	@@3	;@01B49
	and	al, 1Fh	;@01B4B
	cmp	al, 5	;@01B4D
	jne	@@1	;@01B4F
	mov	ax, word ptr es:[bp+0Eh]	;@01B51
	ret	;@01B55
@@1:	cmp	al, 6	;@01B56
	jne	@@2	;@01B58
	mov	ax, word ptr es:[bp+0Eh]	;@01B5A
	ret	;@01B5E
@@2:	mov	ax, word ptr es:[bp+0Eh]	;@01B5F
	ret	;@01B63
@@3:	mov	ax, word ptr es:[bp+10h]	;@01B64
	ret	;@01B68
	db	26h, 0F6h, 46h, 6, 1, 74h, 63h, 6, 55h, 26h, 8Bh, 4Eh, 0Ah, 0E3h, 17h, 8Bh	;@01B69
	db	0C1h, 9Ah
	dd	L101E0
	db	8Bh, 0C1h, 26h, 8Bh, 4Eh, 0, 0BAh, 1, 0, 9Ah
	dd	L1015C
	db	0EBh, 0E7h, 5Dh, 7, 6, 55h, 26h, 8Bh, 4Eh, 8, 0E3h, 38h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	8Bh, 0DDh, 83h, 0C3h, 4, 26h, 8Ah, 4Eh, 2, 32h, 0EDh, 26h, 8Bh, 7, 26h, 8Ah
	db	57h, 2, 32h, 0F6h, 9Ah
	dd	L102C9
	db	83h, 0C3h, 3, 0E2h, 0EDh, 26h, 8Bh, 4Eh, 0, 9Ah
	dd	L101F7
	db	0BAh, 1, 0, 9Ah
	dd	L1015C
	db	0EBh, 0C6h, 5Dh, 7, 33h, 0C0h, 26h, 89h, 46h, 8, 26h, 89h, 46h, 0Ah, 26h, 88h
	db	46h, 6, 0C3h, 9Ah
	dd	L101F7
	db	40h, 6, 55h, 50h, 9Ah
	dd	L101E0
	db	0A1h, 6Eh, 51h, 26h, 89h, 46h, 2, 0A1h, 7Ah, 51h, 26h, 89h, 46h, 0, 33h, 0C0h
	db	26h, 88h, 46h, 6, 26h, 89h, 46h, 4, 58h, 5Dh, 7, 26h, 89h, 46h, 0Eh, 0C3h
	db	0F6h, 6, 0C9h, 38h, 0Fh, 75h, 1Ah, 26h, 8Bh, 5Eh, 0Eh, 6, 55h, 0E8h, 6Fh, 1
	db	50h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	58h, 26h, 89h, 46h, 4, 5Dh, 7, 0EBh, 0B7h, 0A1h, 6Eh, 51h, 8Bh, 16h, 7Ah, 51h
	db	6, 55h, 26h, 8Bh, 4Eh, 0Eh, 0E3h, 58h, 50h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	58h, 50h, 9Ah
	dd	L101F7
	db	8Bh, 0D8h, 58h, 26h, 8Bh, 4Eh, 4, 0E3h, 0C5h, 50h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	58h, 26h, 8Bh, 7Eh, 0, 26h, 8Bh, 4Eh, 2, 9Ah
	dd	L11EA6
	db	74h, 1Ch, 73h, 0D7h, 9Ah
	dd	L101F7
	db	5Dh, 7, 50h, 0E8h, 9Eh, 0FFh, 59h, 6, 55h, 9Ah
	dd	L101E0
	db	26h, 89h, 4Eh, 4, 5Dh, 7, 0C3h, 9Ah
	dd	L101F7
	db	5Dh, 7, 26h, 89h, 46h, 0Eh, 0C3h, 5Dh, 7, 6, 55h, 50h, 9Ah
	dd	L101F7
	db	8Bh, 0C8h, 41h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	58h, 26h, 8Bh, 7Eh, 0, 26h, 8Bh, 4Eh, 2, 9Ah
	dd	L11EA6
	db	74h, 0D0h, 73h, 8Bh, 0E8h, 0CEh, 0, 56h, 33h, 0F6h, 3, 0F5h, 6, 1Fh, 9Ah
	dd	L101E0
	db	33h, 0FFh, 3, 0FDh, 0B9h, 8, 0, 0F3h, 0A5h, 16h, 1Fh, 5Eh, 5Dh, 7, 50h, 0E8h
	db	3, 0FFh, 0EBh, 9Ch
L01CE1:	test	byte ptr ds:[38C9h], 0Fh	;@01CE1
	jne	@@3	;@01CE6
	mov	ax, word ptr es:[bp+0Eh]	;@01CE8
	ret	;@01CEC
@@1:	mov	cx, word ptr es:[bp+0Eh]	;@01CED
	jcxz	@@2	;@01CF1
	mov	ax, cx	;@01CF3
	ret	;@01CF5
@@2:	push	es	;@01CF6
	push	bp	;@01CF7
	call	far ptr L101F7	;@01CF8
	inc	ax	;@01CFD
	call	far ptr L101E0	;@01CFE
	jmp	short @@7	;@01D03
@@3:	test	byte ptr ds:[38C9h], 8	;@01D05
	jne	@@1	;@01D0A
	mov	ax, word ptr ds:[516Eh]	;@01D0C
	mov	dx, word ptr ds:[517Ah]	;@01D0F
	mov	cx, word ptr es:[bp+0Eh]	;@01D13
	push	es	;@01D17
	push	bp	;@01D18
	jcxz	@@6	;@01D19
	push	ax	;@01D1B
	mov	ax, cx	;@01D1C
	call	far ptr L101E0	;@01D1E
	pop	ax	;@01D23
@@4:	mov	cx, word ptr es:[bp+4]	;@01D24
	push	ax	;@01D28
	call	far ptr L101F7	;@01D29
	mov	bx, ax	;@01D2E
	pop	ax	;@01D30
	jcxz	@@5	;@01D31
	push	ax	;@01D33
	mov	ax, cx	;@01D34
	call	far ptr L101E0	;@01D36
	pop	ax	;@01D3B
	mov	di, word ptr es:[bp]	;@01D3C
	mov	cx, word ptr es:[bp+2]	;@01D40
	call	far ptr L11EA6	;@01D44
	ja	@@4	;@01D49
@@5:	mov	ax, bx	;@01D4B
	pop	bp	;@01D4D
	pop	es	;@01D4E
	mov	word ptr es:[bp+0Eh], ax	;@01D4F
	ret	;@01D53
@@6:	pop	bp	;@01D54
	pop	es	;@01D55
	push	es	;@01D56
	push	bp	;@01D57
	push	ax	;@01D58
	call	far ptr L101F7	;@01D59
	mov	cx, ax	;@01D5E
	inc	cx	;@01D60
	mov	ax, cx	;@01D61
	call	far ptr L101E0	;@01D63
	pop	ax	;@01D68
	mov	di, word ptr es:[bp]	;@01D69
	mov	cx, word ptr es:[bp+2]	;@01D6D
	call	far ptr L11EA6	;@01D71
	jae	@@4	;@01D76
@@7:	mov	cx, word ptr es:[bp+4]	;@01D78
	jcxz	@@8	;@01D7C
	mov	ax, cx	;@01D7E
	call	far ptr L101E0	;@01D80
	jmp	@@7	;@01D85
@@8:	call	far ptr L101F7	;@01D87
	pop	bp	;@01D8C
	pop	es	;@01D8D
	ret	;@01D8E
	db	83h, 3Eh, 0C8h, 39h, 0, 75h, 12h, 0B8h, 1, 0, 0B9h, 40h, 0, 9Ah	;@01D8F
	dd	L100B0
	db	89h, 0Eh, 0C8h, 39h, 0A3h, 0C6h, 39h, 0A1h, 0C6h, 39h, 83h, 6, 0C6h, 39h, 1, 83h
	db	2Eh, 0C8h, 39h, 1, 0C3h
L01DB6:	xor	ax, ax	;@01DB6
	mov	byte ptr ds:[4E32h], al	;@01DB8
	mov	word ptr ds:[4E28h], ax	;@01DBB
	ret	;@01DBE
	db	0BFh, 26h, 3Eh, 16h, 7, 8Bh, 0C8h, 0B0h, 40h, 0AAh, 0BAh, 10h, 27h, 0B4h, 30h, 0E8h	;@01DBF
	db	24h, 0, 0BAh, 0E8h, 3, 0E8h, 1Eh, 0, 0BAh, 64h, 0, 0E8h, 18h, 0, 0BAh, 0Ah
	db	0, 0E8h, 12h, 0, 0BAh, 1, 0, 0B4h, 0FFh, 0E8h, 0Ah, 0, 8Bh, 0CFh, 0BBh, 26h
	db	3Eh, 2Bh, 0CBh, 0E9h, 1Ah, 0E6h, 0B0h, 2Fh, 0FEh, 0C0h, 2Bh, 0CAh, 73h, 0FAh, 3, 0CAh
	db	3Ah, 0C4h, 74h, 3, 0AAh, 0B4h, 0FFh, 0C3h, 56h, 0BBh, 40h, 7, 8Bh, 36h, 24h, 3Eh
	db	8Ah, 4, 0D7h, 0A8h, 2, 74h, 3, 46h, 0EBh, 0F6h, 0A8h, 1, 75h, 12h, 8Bh, 0D6h
	db	0A8h, 1, 75h, 15h, 8Bh, 0CEh, 46h, 8Ah, 4, 0D7h, 0A8h, 2, 75h, 0F8h, 0EBh, 0F0h
	db	89h, 36h, 24h, 3Eh, 0B9h, 0, 0, 5Eh, 0C3h, 41h, 89h, 36h, 24h, 3Eh, 5Eh, 8Bh
	db	0DAh, 2Bh, 0CBh, 32h, 0C0h, 0C3h, 56h, 0BBh, 40h, 7, 8Bh, 36h, 24h, 3Eh, 8Ah, 4
	db	0D7h, 0A8h, 2, 74h, 3, 46h, 0EBh, 0F6h, 8Bh, 0D6h, 0A8h, 1, 75h, 6, 46h, 8Ah
	db	4, 0D7h, 0EBh, 0F6h, 80h, 3Ch, 3Bh, 74h, 0F5h, 89h, 36h, 24h, 3Eh, 8Bh, 0CEh, 5Eh
	db	8Bh, 0DAh, 2Bh, 0CBh, 0C3h, 56h, 0BBh, 40h, 7, 8Bh, 36h, 24h, 3Eh, 0ACh, 0D7h, 0A8h
	db	2, 75h, 0FAh, 4Eh, 22h, 0C0h, 74h, 1Ch, 8Bh, 0D6h, 80h, 3Ch, 3Ch, 75h, 2Dh, 42h
	db	46h, 8Ah, 4, 3Ch, 3Eh, 74h, 16h, 0D7h, 0A8h, 1, 74h, 0F4h, 8Bh, 0CEh, 89h, 36h
	db	24h, 3Eh, 0EBh, 10h, 6, 55h, 0E8h, 5Bh, 0Ah, 5Dh, 7, 0EBh, 0C9h, 8Bh, 0CEh, 46h
	db	89h, 36h, 24h, 3Eh, 5Eh, 8Bh, 0DAh, 2Bh, 0CBh, 32h, 0C0h, 0C3h, 5Eh, 0FFh, 36h, 24h
	db	3Eh, 0E8h, 0E3h, 0, 59h, 6, 55h, 75h, 18h, 22h, 0E4h, 74h, 14h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 24h, 3Fh, 75h, 47h, 26h, 80h, 4Eh, 10h, 2, 5Dh, 7, 89h
	db	0Eh, 24h, 3Eh, 89h, 36h, 28h, 4Eh, 0C6h, 6, 32h, 4Eh, 0, 56h, 8Bh, 0F1h, 0BBh
	db	40h, 7, 8Ah, 4, 0D7h, 0A8h, 2, 74h, 3, 46h, 0EBh, 0F6h, 80h, 3Ch, 25h, 75h
	db	1Ch, 46h, 89h, 36h, 24h, 3Eh, 5Eh, 0BFh, 26h, 42h, 57h, 0E8h, 72h, 8, 5Bh, 8Bh
	db	0CFh, 2Bh, 0CBh, 32h, 0C0h, 89h, 36h, 28h, 4Eh, 0A2h, 32h, 4Eh, 0C3h, 5Eh, 0C3h, 3Ch
	db	1, 75h, 0BAh, 83h, 0C6h, 2, 0E8h, 0B5h, 0FDh, 9Ah
	dd	L101E0
	db	33h, 0C9h, 26h, 0F6h, 46h, 6, 1, 74h, 28h, 26h, 8Bh, 46h, 0Ch, 26h, 8Bh, 4Eh
	db	0Eh, 9Ah
	dd	L1035F
	db	1Eh, 56h, 6, 1Eh, 7, 1Fh, 8Bh, 0F7h, 0BFh, 26h, 42h, 8Bh, 0DFh, 51h, 0D1h, 0E9h
	db	0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 59h, 5Eh, 1Fh, 32h, 0C0h, 5Dh, 7, 0C3h, 56h, 0BBh
	db	40h, 7, 8Bh, 36h, 24h, 3Eh, 8Ah, 4, 0D7h, 0A8h, 2, 74h, 3, 46h, 0EBh, 0F6h
	db	8Bh, 0D6h, 8Ah, 4, 3Ch, 2Ch, 74h, 8, 0D7h, 0A8h, 3, 75h, 3, 46h, 0EBh, 0F2h
	db	8Bh, 0CEh, 89h, 36h, 24h, 3Eh, 5Eh, 8Bh, 0DAh, 2Bh, 0CBh, 74h, 3, 32h, 0C0h, 0C3h
	db	32h, 0C0h, 0FEh, 0C8h, 0C3h, 8Bh, 0Eh, 24h, 3Eh, 0C3h, 80h, 0Eh, 0D2h, 39h, 8, 80h
	db	0Eh, 0D2h, 39h, 2, 80h, 0Eh, 0D2h, 39h, 1, 0E8h, 71h, 9, 0C6h, 6, 0D2h, 39h
	db	0, 0C3h, 0C6h, 6, 0D2h, 39h, 4, 0E8h, 63h, 9, 0C6h, 6, 0D2h, 39h, 0, 0C3h
	db	0F6h, 6, 0C9h, 38h, 3, 75h, 0Fh, 0F7h, 6, 0B6h, 38h, 1, 0, 75h, 8, 0F6h
	db	6, 87h, 51h, 40h, 75h, 1, 0C3h, 22h, 0F6h, 74h, 0FBh, 50h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	58h, 26h, 80h, 7Eh, 7, 0Bh, 74h, 0EBh, 50h, 56h, 8Bh, 0F1h, 0BBh, 40h, 7, 0ACh
	db	0D7h, 0A8h, 2, 75h, 0FAh, 4Eh, 6, 55h, 26h, 0C4h, 7Eh, 0, 9Ah
	dd	L10375
	db	5Dh, 7, 26h, 3Bh, 46h, 4, 75h, 77h, 9Ah
	dd	L101F7
	db	8Bh, 0D8h, 26h, 8Ah, 46h, 6, 32h, 0E4h, 8Bh, 0C8h, 26h, 80h, 66h, 9, 7Fh, 0F6h
	db	6, 87h, 51h, 40h, 74h, 13h, 0FEh, 0C0h, 26h, 80h, 4Eh, 9, 80h, 9Ah
	dd	L10215
	db	26h, 0C6h, 5, 5Fh, 47h, 0EBh, 5, 9Ah
	dd	L10215
	db	6, 55h, 50h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	58h, 26h, 89h, 46h, 4, 5Dh, 7, 8Bh, 0D3h, 0A1h, 0B6h, 38h, 25h, 3, 0, 3Dh
	db	3, 0, 74h, 8, 23h, 0C0h, 74h, 12h, 0F3h, 0A4h, 0EBh, 1Eh, 0F6h, 6, 87h, 51h
	db	40h, 75h, 0F5h, 0F6h, 6, 87h, 51h, 10h, 74h, 0EEh, 0BBh, 40h, 7, 0ACh, 8Ah, 0E0h
	db	0D7h, 24h, 20h, 2Ah, 0E0h, 8Ah, 0C4h, 0AAh, 0E2h, 0F3h, 5Eh, 58h, 0C3h, 0F6h, 6, 0C9h
	db	38h, 2, 75h, 0Ch, 0A3h, 24h, 3Eh, 89h, 36h, 28h, 4Eh, 0C6h, 6, 32h, 4Eh, 0
	db	0C3h, 0E8h, 2, 3, 0E8h, 28h, 3, 0E8h, 0E1h, 3, 0E8h, 0B5h, 3, 9Ah
	dd	L11CA8
	db	0C3h, 0E8h, 0F0h, 2, 0C7h, 6, 2Eh, 4Eh, 46h, 26h, 0C7h, 6, 30h, 4Eh, 7Bh, 26h
	db	0E8h, 0C6h, 3, 9Ah
	dd	L11CA8
	db	0C3h, 53h, 52h, 0E8h, 0D6h, 2, 5Ah, 5Bh, 8Bh, 0C3h, 0Bh, 0C2h, 74h, 15h, 53h, 52h
	db	0E8h, 0F2h, 2, 0E8h, 0ABh, 3, 0E8h, 7Fh, 3, 5Ah, 5Bh, 83h, 0EBh, 1, 83h, 0DAh
	db	0, 0EBh, 0E5h, 9Ah
	dd	L11CA8
	db	0C3h, 56h, 6, 16h, 7, 0BFh, 26h, 42h, 8Bh, 36h, 24h, 3Eh, 0BBh, 40h, 7, 0ACh
	db	0D7h, 0A8h, 2, 75h, 0FAh, 4Eh, 80h, 3Ch, 3Ch, 75h, 72h, 8Bh, 0D6h, 42h, 0B4h, 1
	db	46h, 8Ah, 4, 3Ch, 3Ch, 74h, 1Dh, 3Ch, 3Eh, 74h, 42h, 3Ch, 21h, 74h, 19h, 3Ch
	db	22h, 74h, 1Eh, 3Ch, 27h, 74h, 1Ah, 0D7h, 0A8h, 1, 74h, 0E4h, 8Bh, 0CEh, 89h, 36h
	db	24h, 3Eh, 0EBh, 34h, 0FEh, 0C4h, 0EBh, 0D8h, 46h, 8Ah, 4, 3Ch, 0Dh, 75h, 0D1h, 0EBh
	db	0D0h, 8Ah, 0E8h, 46h, 0ACh, 3Ch, 0Dh, 74h, 0Bh, 3Ah, 0C5h, 75h, 0F7h, 38h, 2Ch, 75h
	db	0C0h, 46h, 0EBh, 0F0h, 4Eh, 8Bh, 0CEh, 89h, 36h, 24h, 3Eh, 0EBh, 0Bh, 0FEh, 0CCh, 75h
	db	0AFh, 8Bh, 0CEh, 46h, 89h, 36h, 24h, 3Eh, 8Bh, 0DAh, 2Bh, 0CBh, 89h, 0Eh, 26h, 46h
	db	8Bh, 0F3h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 7, 5Eh, 0C3h, 46h, 33h, 0C9h
	db	0A8h, 1, 75h, 0Bh, 8Ah, 44h, 0FFh, 0AAh, 41h, 0ACh, 0D7h, 0A8h, 2, 74h, 0F1h, 89h
	db	0Eh, 26h, 46h, 7, 5Eh, 0C3h, 56h, 6, 16h, 7, 0BFh, 26h, 42h, 8Bh, 36h, 24h
	db	3Eh, 0BBh, 40h, 7, 0ACh, 0D7h, 0A8h, 2, 75h, 0FAh, 4Eh, 80h, 3Ch, 3Ch, 75h, 41h
	db	8Bh, 0D6h, 42h, 0B4h, 1, 46h, 8Ah, 4, 3Ch, 3Ch, 74h, 11h, 3Ch, 3Eh, 74h, 11h
	db	0D7h, 0A8h, 1, 74h, 0F0h, 8Bh, 0CEh, 89h, 36h, 24h, 3Eh, 0EBh, 0Fh, 0FEh, 0C4h, 0EBh
	db	0E4h, 0FEh, 0CCh, 75h, 0E0h, 8Bh, 0CEh, 46h, 89h, 36h, 24h, 3Eh, 8Bh, 0DAh, 2Bh, 0CBh
	db	89h, 0Eh, 26h, 46h, 8Bh, 0F3h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 7, 5Eh
	db	0C3h, 46h, 33h, 0C9h, 0A8h, 1, 75h, 0Bh, 8Ah, 44h, 0FFh, 0AAh, 41h, 0ACh, 0D7h, 0A8h
	db	2, 74h, 0F1h, 89h, 0Eh, 26h, 46h, 7, 5Eh, 0C3h, 0E8h, 97h, 1, 16h, 7, 0BEh
	db	26h, 42h, 0BFh, 24h, 3Ah, 8Bh, 0Eh, 26h, 46h, 89h, 3Eh, 24h, 3Eh, 0E3h, 2Dh, 0ACh
	db	3Ch, 20h, 77h, 0Ah, 0E2h, 0F9h, 0EBh, 24h, 9Ah
	dd	L11CA8
	db	0C3h, 4Eh, 3Ch, 3Ch, 74h, 14h, 3Ch, 21h, 74h, 10h, 0B0h, 3Ch, 0AAh, 0E8h, 8Dh, 0
	db	0B0h, 3Eh, 0AAh, 0E3h, 0Ah, 0ACh, 0AAh, 49h, 0EBh, 0D6h, 0E8h, 22h, 0, 0EBh, 0F4h, 0B0h
	db	0Dh, 0AAh, 8Bh, 36h, 24h, 3Eh, 0BBh, 40h, 7, 0ACh, 0D7h, 0A8h, 2, 75h, 0FAh, 0A8h
	db	1, 75h, 0C8h, 4Eh, 0E8h, 69h, 1, 0E8h, 22h, 2, 0E8h, 0F6h, 1, 0EBh, 0E3h, 0E3h
	db	7, 32h, 0D2h, 0E8h, 3, 0, 72h, 0F7h, 0C3h, 22h, 0D2h, 75h, 5, 80h, 3Ch, 2Ch
	db	74h, 18h, 0ACh, 3Ch, 22h, 74h, 2Ch, 3Ch, 27h, 74h, 28h, 3Ch, 21h, 74h, 0Dh, 3Ch
	db	3Ch, 74h, 10h, 3Ch, 3Eh, 74h, 10h, 0AAh, 0E2h, 0DFh, 0F8h, 0C3h, 0AAh, 49h, 74h, 0FAh
	db	0ACh, 0EBh, 0F4h, 0FEh, 0C2h, 0EBh, 0F0h, 22h, 0D2h, 74h, 0ECh, 0FEh, 0CAh, 75h, 0E8h, 0AAh
	db	49h, 0F9h, 0C3h, 0AAh, 49h, 74h, 0E3h, 8Ah, 0E0h, 0ACh, 3Ah, 0C4h, 74h, 5, 0AAh, 0E2h
	db	0F8h, 0F8h, 0C3h, 0AAh, 49h, 74h, 0D3h, 38h, 4, 75h, 0AEh, 0EBh, 0ECh, 0E3h, 1Dh, 80h
	db	3Ch, 2Ch, 74h, 18h, 0ACh, 3Ch, 22h, 74h, 28h, 3Ch, 27h, 74h, 24h, 3Ch, 21h, 74h
	db	0Ch, 3Ch, 3Ch, 74h, 0Fh, 3Ch, 3Eh, 74h, 1, 0AAh, 0E2h, 0E3h, 0C3h, 0AAh, 49h, 74h
	db	0FBh, 0ACh, 0EBh, 0F5h, 49h, 0E3h, 0F5h, 0B2h, 1, 0E8h, 7Dh, 0FFh, 73h, 0CFh, 4Fh, 0EBh
	db	0CCh, 0AAh, 49h, 74h, 0E7h, 8Ah, 0E0h, 0ACh, 3Ah, 0C4h, 74h, 4, 0AAh, 0E2h, 0F8h, 0C3h
	db	0AAh, 49h, 74h, 0D8h, 38h, 4, 75h, 0B5h, 0EBh, 0EDh, 0E8h, 8Ah, 0, 0BEh, 26h, 42h
	db	0BFh, 24h, 3Ah, 8Bh, 0Eh, 26h, 46h, 89h, 3Eh, 24h, 3Eh, 0BBh, 40h, 7, 0E3h, 19h
	db	0ACh, 3Ch, 3Ch, 74h, 11h, 3Ch, 3Eh, 74h, 0Dh, 0C6h, 5, 21h, 88h, 45h, 1, 0C6h
	db	45h, 2, 2Ch, 83h, 0C7h, 3, 0E2h, 0E8h, 4Fh, 0C6h, 5, 0Dh, 8Bh, 36h, 24h, 3Eh
	db	0BBh, 40h, 7, 8Ah, 4, 0D7h, 0A8h, 2, 74h, 3, 46h, 0EBh, 0F6h, 0A8h, 1, 75h
	db	0Bh, 0E8h, 6Ch, 0, 0E8h, 25h, 1, 0E8h, 0F9h, 0, 0EBh, 0E0h, 9Ah
	dd	L11CA8
	db	0C3h, 0BFh, 26h, 42h, 8Bh, 36h, 24h, 3Eh, 0BBh, 40h, 7, 0ACh, 0D7h, 0A8h, 2, 75h
	db	0FAh, 4Eh, 0E8h, 3Ch, 3, 0BBh, 40h, 7, 0ACh, 0D7h, 0A8h, 2, 75h, 0FAh, 4Eh, 0A8h
	db	1, 75h, 6, 80h, 3Ch, 2Ch, 75h, 1, 46h, 89h, 36h, 24h, 3Eh, 81h, 0EFh, 26h
	db	42h, 89h, 3Eh, 26h, 46h, 0C3h, 0C7h, 6, 2Eh, 4Eh, 0F3h, 25h, 0C7h, 6, 30h, 4Eh
	db	6Dh, 26h, 89h, 2Eh, 2Ah, 4Eh, 8Ch, 6, 2Ch, 4Eh, 9Ah
	dd	L101E0
	db	26h, 8Ah, 4Eh, 6, 32h, 0EDh, 26h, 0C4h, 7Eh, 0, 9Ah
	dd	L11BEA
	db	0C3h, 0C4h, 2Eh, 2Ah, 4Eh, 26h, 8Bh, 4Eh, 0Ah, 0E3h, 59h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 80h, 7Eh, 8, 0, 74h, 4Ch, 0B8h, 3Fh, 3Fh, 0F7h, 6, 7Ch, 51h, 0, 80h
	db	74h, 25h, 6, 55h, 50h, 26h, 8Bh, 46h, 2, 9Ah
	dd	L101E0
	db	58h, 26h, 80h, 7Eh, 6, 1, 76h, 0Fh, 26h, 0C4h, 7Eh, 0, 8Bh, 0Eh, 80h, 51h
	db	26h, 3Bh, 0Dh, 75h, 2, 8Bh, 0C1h, 5Dh, 7, 0BFh, 26h, 42h, 89h, 5, 83h, 0C7h
	db	2, 0A1h, 0AEh, 51h, 0E8h, 78h, 2, 0FFh, 6, 0AEh, 51h, 8Bh, 0CFh, 0BEh, 26h, 42h
	db	2Bh, 0CEh, 0EBh, 0Fh, 0C3h, 6, 55h, 0E8h, 39h, 0FFh, 5Dh, 7, 8Bh, 0Eh, 26h, 46h
	db	0BEh, 26h, 42h, 26h, 89h, 4Eh, 6, 0E3h, 14h, 8Bh, 0C1h, 6, 55h, 9Ah
	dd	L10215
	db	41h, 0D1h, 0E9h, 0F3h, 0A5h, 5Dh, 7, 26h, 89h, 46h, 4, 26h, 8Bh, 4Eh, 0, 0E9h
	db	75h, 0FFh, 0C4h, 2Eh, 2Ah, 4Eh, 26h, 8Bh, 4Eh, 0Ah, 0E3h, 1Eh, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 4Eh, 0, 26h, 8Bh, 56h, 6, 23h, 0D2h, 74h, 0EBh, 26h, 8Bh, 46h, 4
	db	9Ah
	dd	L102C9
	db	0EBh, 0E0h, 0C3h, 0C4h, 2Eh, 2Ah, 4Eh, 26h, 8Bh, 4Eh, 8, 0E3h, 43h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 4Eh, 2, 32h, 0EDh, 8Bh, 0FDh, 83h, 0C7h, 4, 51h, 57h, 6, 55h, 26h
	db	8Bh, 5, 9Ah
	dd	L1035F
	db	6, 1Fh, 8Bh, 0F7h, 16h, 7, 0BFh, 26h, 42h, 0E8h, 1Ah, 0, 16h, 1Fh, 0BBh, 26h
	db	42h, 9Ah
	dd	L11C48
	db	5Dh, 7, 5Fh, 59h, 83h, 0C7h, 3, 0E2h, 0D5h, 26h, 8Bh, 4Eh, 0, 0EBh, 0BBh, 0C3h
	db	0BBh, 40h, 7, 0ACh, 0AAh, 36h, 0D7h, 0A8h, 2, 75h, 0F8h, 4Fh, 0A8h, 80h, 75h, 35h
	db	0A8h, 40h, 75h, 4Ah, 0A8h, 10h, 75h, 13h, 0A8h, 4, 75h, 20h, 0A8h, 1, 75h, 60h
	db	47h, 0EBh, 0E0h, 0ACh, 3Ch, 26h, 75h, 0DCh, 0AAh, 0EBh, 0F8h, 4Eh, 0ACh, 3Ch, 26h, 74h
	db	0D3h, 0AAh, 36h, 0D7h, 0A8h, 90h, 75h, 0F4h, 4Eh, 4Fh, 0EBh, 0C7h, 36h, 0F7h, 6, 7Ch
	db	51h, 0, 10h, 75h, 0DBh, 80h, 7Ch, 0FFh, 26h, 74h, 0D8h, 4Eh, 57h, 0E8h, 81h, 0
	db	58h, 0E3h, 0B0h, 8Bh, 0F8h, 0E8h, 0A0h, 0, 0EBh, 0A9h, 0B0h, 0Dh, 0AAh, 0C3h, 4Eh, 0ACh
	db	0AAh, 8Ah, 0E0h, 0ACh, 3Ch, 0Dh, 74h, 0F4h, 0AAh, 3Ch, 26h, 74h, 0Ch, 3Ah, 0C4h, 75h
	db	0F2h, 0ACh, 3Ah, 0C4h, 75h, 8Eh, 0AAh, 0EBh, 0EAh, 50h, 0E8h, 2Bh, 0, 58h, 0EBh, 0E3h
	db	4Eh, 0ACh, 3Ch, 0Dh, 74h, 0D6h, 0AAh, 0ACh, 3Ch, 3Bh, 74h, 0CEh, 36h, 0F7h, 6, 7Ch
	db	51h, 0, 10h, 75h, 3, 0E9h, 6Ch, 0FFh, 0AAh, 0ACh, 3Ch, 0Dh, 74h, 0BEh, 0AAh, 3Ch
	db	26h, 75h, 0F6h, 0E8h, 2, 0, 0EBh, 0F1h, 8Ah, 4, 36h, 0D7h, 0A8h, 80h, 74h, 20h
	db	57h, 0E8h, 1Dh, 0, 5Ah, 0E3h, 19h, 8Bh, 0FAh, 81h, 0FFh, 26h, 42h, 74h, 8, 26h
	db	80h, 7Dh, 0FFh, 26h, 75h, 1, 4Fh, 0E8h, 2Eh, 0, 80h, 3Ch, 26h, 75h, 1, 46h
	db	0C3h, 8Bh, 0EFh, 0ACh, 0AAh, 0ACh, 3Ch, 26h, 74h, 8, 0AAh, 36h, 0D7h, 0A8h, 90h, 75h
	db	0F4h, 4Fh, 4Eh, 1Eh, 56h, 6, 57h, 8Bh, 0CFh, 8Bh, 0F5h, 2Bh, 0CEh, 16h, 1Fh, 0FFh
	db	16h, 2Eh, 4Eh, 5Fh, 7, 5Eh, 1Fh, 0C3h, 1Eh, 56h, 6, 57h, 16h, 1Fh, 8Bh, 0C1h
	db	9Ah
	dd	L101E0
	db	0FFh, 16h, 30h, 4Eh, 6, 1Fh, 8Bh, 0F7h, 5Fh, 7, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h
	db	0F3h, 0A4h, 5Eh, 1Fh, 0C3h, 0C4h, 2Eh, 2Ah, 4Eh, 8Bh, 0D1h, 26h, 8Bh, 4Eh, 0Ah, 0E3h
	db	46h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 0FFh, 76h, 0, 26h, 8Bh, 46h, 2, 9Ah
	dd	L101E0
	db	26h, 3Ah, 56h, 6, 74h, 3, 59h, 0EBh, 0E1h, 51h, 8Bh, 0CAh, 26h, 0C4h, 7Eh, 0
	db	56h, 0F7h, 6, 0B6h, 38h, 2, 0, 74h, 4, 0F3h, 0A6h, 0EBh, 10h, 0ACh, 8Ah, 0E0h
	db	0D7h, 24h, 20h, 2Ah, 0E0h, 26h, 8Ah, 5, 47h, 3Ah, 0E0h, 0E1h, 0F0h, 5Eh, 59h, 75h
	db	0D5h, 58h, 0C3h, 8Bh, 0DEh, 0E8h, 0C4h, 0DDh, 0BBh, 40h, 7, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	33h, 0C9h, 26h, 8Ah, 46h, 7, 24h, 3Fh, 75h, 6, 26h, 80h, 4Eh, 10h, 2, 0C3h
	db	3Ch, 1, 74h, 1, 0C3h, 8Bh, 0CAh, 0C3h, 26h, 8Bh, 46h, 4, 26h, 8Bh, 4Eh, 6
	db	9Ah
	dd	L1035F
	db	0C3h, 53h, 0E8h, 62h, 0F6h, 5Bh, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 6, 1, 74h, 0Eh, 26h, 8Bh, 46h, 0Ch, 26h, 8Bh, 4Eh, 0Eh, 9Ah
	dd	L1035F
	db	0C3h, 33h, 0C9h, 0C3h, 50h, 8Ah, 0C4h, 0E8h, 1, 0, 58h, 8Ah, 0E0h, 0B1h, 4, 0D2h
	db	0E8h, 0E8h, 4, 0, 8Ah, 0C4h, 24h, 0Fh, 3Ch, 0Ah, 73h, 6, 4, 30h, 88h, 5
	db	47h, 0C3h, 4, 37h, 88h, 5, 47h, 0C3h, 0E8h, 4Dh, 0, 8Ah, 4, 3Ch, 3Ch, 75h
	db	0Dh, 46h, 0E8h, 0Ah, 0, 8Ah, 4, 3Ch, 3Eh, 75h, 0EDh, 46h, 0EBh, 0EAh, 0C3h, 8Ah
	db	4, 3Ch, 3Ch, 74h, 1Fh, 0E8h, 30h, 0, 8Ah, 4, 3Ch, 0Dh, 74h, 29h, 3Ch, 3Eh
	db	74h, 25h, 3Ch, 21h, 72h, 8, 3Ch, 2Ch, 74h, 4, 3Ch, 3Bh, 75h, 0E1h, 46h, 88h
	db	5, 47h, 0EBh, 0E4h, 88h, 5, 46h, 47h, 0E8h, 0D4h, 0FFh, 8Ah, 4, 3Ch, 3Eh, 75h
	db	0CEh, 88h, 5, 47h, 46h, 0EBh, 0C8h, 0C3h, 8Ah, 4, 3Ch, 22h, 74h, 28h, 3Ch, 27h
	db	74h, 24h, 3Ch, 25h, 74h, 4Dh, 3Ch, 21h, 74h, 3Ch, 3Ch, 3Bh, 74h, 17h, 3Ch, 2Ch
	db	74h, 13h, 3Ch, 21h, 0F5h, 73h, 0Eh, 3Ch, 3Ch, 74h, 0Ah, 3Ch, 3Eh, 74h, 6, 88h
	db	5, 47h, 46h, 0EBh, 0D3h, 0C3h, 8Ah, 0E0h, 88h, 5, 47h, 46h, 8Ah, 4, 3Ch, 0Dh
	db	74h, 0F3h, 46h, 88h, 5, 47h, 3Ah, 0C4h, 75h, 0F2h, 8Ah, 4, 3Ah, 0C4h, 75h, 0B8h
	db	46h, 88h, 5, 47h, 0EBh, 0E6h, 46h, 8Ah, 4, 3Ch, 0Dh, 74h, 0D8h, 88h, 5, 46h
	db	47h, 0EBh, 0A5h, 33h, 0C0h, 0A2h, 32h, 4Eh, 0A3h, 28h, 4Eh, 46h, 89h, 36h, 24h, 3Eh
	db	8Bh, 0F0h, 0E8h, 5, 0, 8Bh, 36h, 24h, 3Eh, 0C3h, 6, 53h, 57h, 0E8h, 1Dh, 0F8h
	db	75h, 55h, 22h, 0F6h, 74h, 4Ch, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 24h, 3Fh, 3Ch, 1, 75h, 3Bh, 83h, 0C6h, 2, 0E8h, 3Bh, 0F5h
	db	9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 0Ch, 26h, 8Bh, 4Eh, 0Eh, 9Ah
	dd	L1035F
	db	0E3h, 36h, 0F7h, 6, 7Ch, 51h, 0, 40h, 74h, 0Ch, 26h, 8Ah, 5, 3Ch, 20h, 77h
	db	5, 47h, 0E2h, 0F6h, 0EBh, 22h, 5Bh, 26h, 8Ah, 5, 47h, 88h, 7, 43h, 0E2h, 0F7h
	db	53h, 0EBh, 15h, 0E8h, 0E4h, 83h, 74h, 3, 0E8h, 0B9h, 31h, 0E8h, 14h, 53h, 0C6h, 6
	db	0CAh, 38h, 0, 5Fh, 0E8h, 28h, 0, 57h, 0E8h, 31h, 1, 5Fh, 5Bh, 7, 56h, 8Bh
	db	36h, 24h, 3Eh, 3Ch, 21h, 72h, 12h, 4Eh, 8Ah, 4, 3Ch, 21h, 72h, 0Bh, 3Ch, 2Ch
	db	74h, 7, 3Ch, 3Bh, 74h, 3, 46h, 0EBh, 0EFh, 89h, 36h, 24h, 3Eh, 5Eh, 0C3h, 8Ah
	db	1Eh, 86h, 51h, 80h, 0E3h, 0Fh, 74h, 20h, 0FEh, 0C3h, 80h, 0FBh, 2, 74h, 0Fh, 80h
	db	0FBh, 8, 74h, 0Fh, 80h, 0FBh, 0Ah, 74h, 0Fh, 0BBh, 74h, 6, 0EBh, 0Dh, 0BBh, 0C0h
	db	6, 0EBh, 8, 0BBh, 94h, 6, 0EBh, 3, 0BBh, 4Ch, 6, 32h, 0D2h, 0E8h, 12h, 0
	db	83h, 0C3h, 4, 83h, 3Fh, 1, 75h, 0F5h, 83h, 7Fh, 2, 0, 75h, 0EFh, 8Ah, 0F0h
	db	0EBh, 15h, 0B6h, 0FFh, 0FEh, 0C6h, 2Bh, 7, 1Bh, 4Fh, 2, 73h, 0F7h, 3, 7, 13h
	db	4Fh, 2, 3Ah, 0D6h, 75h, 1, 0C3h, 80h, 0FEh, 0Ah, 73h, 9, 0B2h, 0FFh, 80h, 0C6h
	db	30h, 88h, 35h, 47h, 0C3h, 22h, 0D2h, 75h, 4, 0C6h, 5, 30h, 47h, 0B2h, 0FFh, 80h
	db	0C6h, 37h, 88h, 35h, 47h, 0C3h
L0288E:	mov	si, 3A24h	;@0288E
@@1:	mov	al, byte ptr es:[di]	;@02891
	mov	byte ptr [si], al	;@02894
	inc	si	;@02896
	inc	di	;@02897
	cmp	al, 0Dh	;@02898
	jne	@@1	;@0289A
	mov	si, 3A24h	;@0289C
	mov	word ptr ds:[3E24h], si	;@0289F
	xor	ax, ax	;@028A3
	mov	word ptr ds:[4E28h], ax	;@028A5
	mov	byte ptr ds:[4E32h], al	;@028A8
	ret	;@028AB
L028AC:	mov	di, 3A24h	;@028AC
	mov	cx, 400h	;@028AF
	call	far ptr L11D63	;@028B2
	mov	si, 3A24h	;@028B7
	mov	word ptr ds:[3E24h], si	;@028BA
	xor	ax, ax	;@028BE
	mov	word ptr ds:[4E28h], ax	;@028C0
	mov	byte ptr ds:[4E32h], al	;@028C3
	ret	;@028C6
	db	90h	;@028C7
L028C8:	cmp	byte ptr ds:[4E32h], 0	;@028C8
	je	@@1	;@028CD
	ret	;@028CF
@@1:	push	si	;@028D0
	mov	si, word ptr ds:[3E24h]	;@028D1
@@2:	mov	bx, 740h	;@028D5
@@3:	lodsb	;@028D8
	xlat	;@028D9
	test	al, 1	;@028DA
	jne	@@6	;@028DC
	test	al, 40h	;@028DE
	jne	@@4	;@028E0
	and	al, al	;@028E2
	jne	@@3	;@028E4
	dec	si	;@028E6
	push	si	;@028E7
	call	@@8	;@028E8
	pop	si	;@028EB
	jmp	@@2	;@028EC
@@4:	mov	ah, byte ptr [si-1]	;@028EE
@@5:	lodsb	;@028F1
	cmp	al, ah	;@028F2
	je	@@7	;@028F4
	cmp	al, 0Dh	;@028F6
	jne	@@5	;@028F8
@@6:	pop	si	;@028FA
	ret	;@028FB
@@7:	cmp	byte ptr [si], ah	;@028FC
	jne	@@3	;@028FE
	inc	si	;@02900
	jmp	@@5	;@02901
@@8:	mov	di, si	;@02903
	push	ss	;@02905
	pop	es	;@02906
	mov	al, 20h	;@02907
	stosb	;@02909
	mov	cx, 3E24h	;@0290A
	sub	cx, di	;@0290D
	push	di	;@0290F
	call	far ptr L11D52	;@02910
	pop	bx	;@02915
	test	byte ptr ds:[38C9h], 1	;@02916
	jne	@@9	;@0291B
	ret	;@0291D
@@9:	call	far ptr L10664	;@0291E
	ret	;@02923
	db	3Bh, 36h, 28h, 4Eh, 73h, 54h, 8Bh, 94h, 28h, 46h, 22h, 0F6h, 74h, 20h, 6, 55h	;@02924
	db	8Bh, 0C2h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 7, 24h, 3Fh, 3Ch, 1, 74h, 11h, 3Ch, 0Eh, 74h, 21h, 26h, 8Bh
	db	46h, 0Ch, 5Dh, 7, 32h, 0DBh, 0C3h, 8Bh, 0C2h, 0C3h, 90h, 36h, 0F6h, 6, 0D2h, 39h
	db	2, 75h, 0EBh, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	16h, 1Fh, 0E9h, 0EBh, 7, 36h, 0F6h, 6, 0D2h, 39h, 2, 75h, 0D7h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	16h, 1Fh, 0E9h, 0EBh, 7, 80h, 3Eh, 32h, 4Eh, 0, 75h, 0CFh, 8Bh, 0FEh, 8Bh, 36h
	db	24h, 3Eh, 0ACh, 32h, 0E4h, 8Bh, 0D8h, 0D1h, 0E3h, 0FFh, 0A7h, 40h, 8, 4Eh, 89h, 36h
	db	24h, 3Eh, 8Bh, 0F7h, 0C6h, 6, 32h, 4Eh, 0FFh, 22h, 0C0h, 0C3h, 90h, 8Bh, 0D0h, 89h
	db	36h, 24h, 3Eh, 8Bh, 0F7h, 89h, 84h, 28h, 46h, 83h, 6, 28h, 4Eh, 2, 32h, 0DBh
	db	0C3h, 0F6h, 6, 0D2h, 39h, 8, 75h, 0E5h, 4Eh, 56h, 57h, 6, 55h, 0E8h, 3Ah, 0FFh
	db	5Dh, 7, 5Fh, 5Eh, 0EBh, 0BCh, 4Eh, 6, 55h, 0BBh, 40h, 7, 0F7h, 6, 7Ch, 51h
	db	0, 10h, 75h, 60h, 8Ah, 44h, 1, 0D7h, 0A8h, 90h, 74h, 58h, 0A8h, 10h, 74h, 19h
	db	0F6h, 6, 0D2h, 39h, 4, 74h, 12h, 16h, 7, 0BFh, 26h, 3Eh, 0B1h, 5, 0B8h, 30h
	db	0, 0AAh, 8Bh, 0E8h, 0B0h, 2Eh, 0E9h, 0C9h, 0, 56h, 0ACh, 0E8h, 0BCh, 5, 5Fh, 0F6h
	db	6, 0D2h, 39h, 1, 75h, 3Dh, 50h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	58h, 26h, 0F6h, 46h, 7, 3Fh, 75h, 2Dh, 26h, 0F6h, 46h, 10h, 40h, 75h, 26h, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 7, 3Fh, 75h, 1Ah, 8Bh, 0F7h, 89h, 36h, 24h, 3Eh, 83h, 2Eh, 28h
	db	4Eh, 2, 46h, 0BFh, 26h, 3Eh, 16h, 7, 0B8h, 2Eh, 0, 0AAh, 8Bh, 0E8h, 0E9h, 0DAh
	db	5, 5Dh, 7, 32h, 0DBh, 0C3h, 6, 55h, 16h, 7, 0BFh, 26h, 3Eh, 33h, 0EDh, 0AAh
	db	0B1h, 5, 8Ah, 0E8h, 0ACh, 3Ch, 0Dh, 74h, 12h, 0AAh, 98h, 0D3h, 0C5h, 33h, 0E8h, 3Ah
	db	0C5h, 75h, 0F1h, 0ACh, 3Ah, 0C5h, 75h, 3, 0AAh, 0EBh, 0E9h, 4Eh, 0EBh, 59h, 6, 55h
	db	16h, 7, 0BBh, 40h, 7, 0BFh, 26h, 3Eh, 33h, 0EDh, 0B1h, 5, 0E8h, 8Ah, 1, 3Ch
	db	2Eh, 74h, 3Dh, 0F6h, 6, 0D2h, 39h, 4, 74h, 8, 3Ch, 45h, 74h, 9, 3Ch, 65h
	db	74h, 5, 0E8h, 3Ch, 1, 0EBh, 30h, 0B0h, 2Eh, 0AAh, 0D3h, 0C5h, 83h, 0C5h, 2Eh, 0E8h
	db	47h, 1, 0ACh, 0D7h, 0A8h, 2, 75h, 0FAh, 4Eh, 0A8h, 1, 75h, 1Ah, 80h, 3Ch, 2Ch
	db	74h, 15h, 80h, 26h, 0D2h, 39h, 0FBh, 8Bh, 36h, 28h, 4Eh, 5Dh, 7, 0E9h, 59h, 0FEh
	db	46h, 0E8h, 45h, 1, 0E8h, 22h, 1, 89h, 36h, 24h, 3Eh, 81h, 0FFh, 25h, 3Fh, 73h
	db	5Ah, 0BEh, 26h, 3Eh, 0D1h, 0E5h, 8Eh, 6, 0B8h, 39h, 23h, 2Eh, 0C0h, 39h, 26h, 8Bh
	db	4Eh, 0, 0E3h, 57h, 51h, 55h, 53h, 8Bh, 0D9h, 0C1h, 0C3h, 4, 8Bh, 0EBh, 83h, 0E5h
	db	0F0h, 83h, 0E3h, 0Fh, 0D1h, 0E3h, 36h, 8Eh, 87h, 0D2h, 38h, 5Bh, 8Bh, 0CFh, 2Bh, 0CEh
	db	26h, 3Ah, 4Eh, 6, 75h, 2Eh, 26h, 83h, 7Eh, 0Ah, 0, 75h, 27h, 8Bh, 0C6h, 8Bh
	db	0DFh, 26h, 0C4h, 7Eh, 0, 51h, 0D1h, 0E9h, 0F3h, 0A7h, 59h, 75h, 13h, 83h, 0E1h, 1
	db	0F3h, 0A6h, 75h, 0Ch, 5Dh, 58h, 8Bh, 0D0h, 0E9h, 0E1h, 5, 0BFh, 25h, 3Fh, 0EBh, 0A1h
	db	8Bh, 0F0h, 8Bh, 0FBh, 5Dh, 59h, 83h, 0C5h, 16h, 0EBh, 9Bh, 83h, 3Eh, 0C4h, 39h, 0
	db	75h, 12h, 0B8h, 2, 0, 0B9h, 0, 2, 9Ah
	dd	L100B0
	db	89h, 0Eh, 0C4h, 39h, 0A3h, 0C2h, 39h, 0A1h, 0C2h, 39h, 83h, 6, 0C2h, 39h, 2, 83h
	db	2Eh, 0C4h, 39h, 2, 26h, 89h, 46h, 0, 53h, 8Bh, 0D8h, 0C1h, 0C3h, 4, 8Bh, 0EBh
	db	83h, 0E5h, 0F0h, 83h, 0E3h, 0Fh, 0D1h, 0E3h, 36h, 8Eh, 87h, 0D2h, 38h, 5Bh, 6, 55h
	db	33h, 0C0h, 26h, 0C6h, 46h, 7, 0Bh, 26h, 89h, 46h, 0Ah, 26h, 89h, 46h, 8, 8Bh
	db	0CFh, 2Bh, 0CEh, 8Bh, 0C1h, 26h, 88h, 46h, 6, 9Ah
	dd	L10215
	db	8Bh, 0D7h, 41h, 0D1h, 0E9h, 0F3h, 0A5h, 8Ch, 0C1h, 5Dh, 7, 26h, 89h, 46h, 4, 26h
	db	89h, 56h, 0, 26h, 89h, 4Eh, 2, 0FFh, 0Eh, 0BEh, 39h, 74h, 0Eh, 9Ah
	dd	L101F7
	db	8Bh, 0D0h, 26h, 89h, 46h, 0Ch, 0E9h, 46h, 5, 0C6h, 6, 0C8h, 38h, 0Bh, 0F9h, 8Bh
	db	26h, 0ACh, 38h, 0CBh, 0ACh, 8Ah, 0E0h, 0D7h, 0A8h, 90h, 74h, 0Eh, 24h, 20h, 86h, 0C4h
	db	2Ah, 0C4h, 98h, 0AAh, 0D3h, 0C5h, 33h, 0E8h, 0EBh, 0EAh, 4Eh, 0C3h, 0ACh, 3Ch, 45h, 74h
	db	6, 3Ch, 65h, 74h, 2, 4Eh, 0C3h, 0B0h, 45h, 0AAh, 0ACh, 3Ch, 2Dh, 74h, 0Dh, 3Ch
	db	2Bh, 74h, 9, 8Ah, 0E0h, 0D7h, 0A8h, 10h, 86h, 0C4h, 74h, 9, 0AAh, 98h, 0D3h, 0C5h
	db	33h, 0E8h, 0ACh, 0EBh, 0EEh, 4Eh, 0C3h, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 58h, 8Bh
	db	0CEh, 0ACh, 3Ch, 58h, 74h, 3Ch, 3Ch, 4Ch, 74h, 3Fh, 3Ch, 48h, 74h, 42h, 3Ch, 44h
	db	74h, 18h, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 40h, 3Ch, 78h, 74h, 24h, 3Ch, 6Ch
	db	74h, 27h, 3Ch, 68h, 74h, 2Ah, 3Ch, 64h, 75h, 30h, 0ACh, 3Ch, 44h, 74h, 0Ch, 0F7h
	db	6, 0B6h, 38h, 2, 0, 75h, 23h, 3Ch, 64h, 75h, 1Fh, 8Bh, 16h, 8Ch, 56h, 0E9h
	db	41h, 3, 8Bh, 16h, 4Ah, 56h, 0E9h, 3Ah, 3, 8Bh, 16h, 0Eh, 56h, 0E9h, 33h, 3
	db	8Bh, 16h, 16h, 56h, 0E9h, 2Ch, 3, 0E9h, 41h, 3, 0E9h, 39h, 3, 0F7h, 6, 0B6h
	db	38h, 2, 0, 75h, 0F2h, 8Bh, 0CEh, 0ACh, 3Ch, 58h, 74h, 39h, 3Ch, 50h, 74h, 2Eh
	db	3Ch, 4Ch, 74h, 23h, 3Ch, 48h, 74h, 18h, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0DAh
	db	3Ch, 78h, 74h, 21h, 3Ch, 70h, 74h, 16h, 3Ch, 6Ch, 74h, 0Bh, 3Ch, 68h, 75h, 0CAh
	db	8Bh, 16h, 1Ch, 56h, 0E9h, 0ECh, 2, 8Bh, 16h, 14h, 56h, 0E9h, 0E5h, 2, 8Bh, 16h
	db	54h, 56h, 0E9h, 0DEh, 2, 8Bh, 16h, 50h, 56h, 0E9h, 0D7h, 2, 0ACh, 3Ch, 50h, 74h
	db	0Ch, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 7Ah, 3Ch, 70h, 75h, 76h, 8Bh, 16h, 90h
	db	56h, 0E9h, 0BFh, 2, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 64h, 8Bh, 0CEh, 0ACh, 3Ch
	db	58h, 74h, 6Ah, 3Ch, 4Ch, 74h, 6Dh, 3Ch, 48h, 74h, 70h, 3Ch, 4Dh, 74h, 0CDh, 3Ch
	db	53h, 74h, 53h, 3Ch, 41h, 74h, 20h, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 44h, 3Ch
	db	78h, 74h, 4Ah, 3Ch, 6Ch, 74h, 4Dh, 3Ch, 68h, 74h, 50h, 3Ch, 6Dh, 74h, 0ADh, 3Ch
	db	73h, 74h, 33h, 3Ch, 61h, 75h, 2Ch, 0ACh, 3Ch, 4Ch, 74h, 0Ch, 0F7h, 6, 0B6h, 38h
	db	2, 0, 75h, 1Fh, 3Ch, 6Ch, 75h, 1Bh, 0ACh, 3Ch, 4Ch, 74h, 0Ch, 0F7h, 6, 0B6h
	db	38h, 2, 0, 75h, 0Eh, 3Ch, 6Ch, 75h, 0Ah, 8Bh, 16h, 96h, 56h, 0E9h, 53h, 2
	db	0E9h, 68h, 2, 0E9h, 60h, 2, 8Bh, 16h, 5Ch, 56h, 0E9h, 46h, 2, 8Bh, 16h, 4Ch
	db	56h, 0E9h, 3Fh, 2, 8Bh, 16h, 10h, 56h, 0E9h, 38h, 2, 8Bh, 16h, 18h, 56h, 0E9h
	db	31h, 2, 0E9h, 46h, 2, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0F5h, 8Bh, 0CEh, 0ACh
	db	3Ch, 58h, 74h, 60h, 3Ch, 49h, 74h, 71h, 3Ch, 4Ch, 74h, 5Fh, 3Ch, 48h, 74h, 62h
	db	3Ch, 53h, 74h, 49h, 3Ch, 57h, 74h, 3Eh, 3Ch, 42h, 74h, 33h, 3Ch, 44h, 74h, 28h
	db	0F7h, 6, 0B6h, 38h, 2, 0, 75h, 58h, 3Ch, 78h, 74h, 38h, 3Ch, 69h, 74h, 49h
	db	3Ch, 6Ch, 74h, 37h, 3Ch, 68h, 74h, 3Ah, 3Ch, 73h, 74h, 21h, 3Ch, 77h, 74h, 16h
	db	3Ch, 62h, 74h, 0Bh, 3Ch, 64h, 75h, 38h, 8Bh, 16h, 36h, 58h, 0E9h, 0D4h, 1, 8Bh
	db	16h, 32h, 58h, 0E9h, 0CDh, 1, 8Bh, 16h, 34h, 58h, 0E9h, 0C6h, 1, 8Bh, 16h, 60h
	db	56h, 0E9h, 0BFh, 1, 8Bh, 16h, 4Eh, 56h, 0E9h, 0B8h, 1, 8Bh, 16h, 12h, 56h, 0E9h
	db	0B1h, 1, 8Bh, 16h, 1Ah, 56h, 0E9h, 0AAh, 1, 8Bh, 16h, 58h, 56h, 0E9h, 0A3h, 1
	db	0E9h, 0B3h, 1, 0ACh, 3Ch, 58h, 74h, 1Bh, 3Ch, 50h, 74h, 10h, 0F7h, 6, 0B6h, 38h
	db	2, 0, 75h, 31h, 3Ch, 78h, 74h, 0Bh, 3Ch, 70h, 75h, 29h, 8Bh, 16h, 28h, 56h
	db	0E9h, 80h, 1, 8Bh, 16h, 24h, 56h, 0E9h, 79h, 1, 0ACh, 3Ch, 58h, 74h, 0Ch, 0F7h
	db	6, 0B6h, 38h, 2, 0, 75h, 0Eh, 3Ch, 78h, 75h, 0Ah, 8Bh, 16h, 20h, 56h, 0E9h
	db	61h, 1, 0E9h, 76h, 1, 0E9h, 6Eh, 1, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0F2h
	db	8Bh, 0CEh, 0ACh, 3Ch, 53h, 74h, 0Ch, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0E6h, 3Ch
	db	73h, 75h, 0E2h, 8Bh, 16h, 5Ah, 56h, 0E9h, 39h, 1, 0E9h, 49h, 1, 0E9h, 4Bh, 1
	db	0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0F5h, 8Bh, 0CEh, 0ACh, 3Ch, 4Dh, 74h, 0Ch, 0F7h
	db	6, 0B6h, 38h, 2, 0, 75h, 0E3h, 3Ch, 6Dh, 75h, 0DFh, 0ACh, 3Ch, 50h, 74h, 0Ch
	db	0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0D2h, 3Ch, 70h, 75h, 0CEh, 8Bh, 16h, 94h, 56h
	db	0E9h, 0, 1, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 2Eh, 8Bh, 0CEh, 0ACh, 3Ch, 4Fh
	db	74h, 0Ch, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 1Ch, 3Ch, 6Fh, 75h, 18h, 0ACh, 3Ch
	db	56h, 74h, 0Ch, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0Bh, 3Ch, 76h, 75h, 7, 8Bh
	db	16h, 92h, 56h, 0E9h, 0CDh, 0, 0E9h, 0DDh, 0, 0E9h, 0DFh, 0, 0F7h, 6, 0B6h, 38h
	db	2, 0, 75h, 36h, 8Bh, 0CEh, 0ACh, 3Ch, 55h, 74h, 32h, 3Ch, 4Fh, 74h, 10h, 0F7h
	db	6, 0B6h, 38h, 2, 0, 75h, 20h, 3Ch, 75h, 74h, 22h, 3Ch, 6Fh, 75h, 0D7h, 0ACh
	db	3Ch, 50h, 74h, 0Ch, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0Bh, 3Ch, 70h, 75h, 7
	db	8Bh, 16h, 9Ah, 56h, 0E9h, 8Ch, 0, 0E9h, 9Ch, 0, 0E9h, 9Eh, 0, 0ACh, 3Ch, 53h
	db	74h, 0Ch, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0EDh, 3Ch, 73h, 75h, 0E9h, 0ACh, 3Ch
	db	48h, 74h, 0Ch, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 0DCh, 3Ch, 68h, 75h, 0D8h, 8Bh
	db	16h, 98h, 56h, 0EBh, 5Eh, 0F7h, 6, 0B6h, 38h, 2, 0, 75h, 4Eh, 8Bh, 0CEh, 0ACh
	db	3Ch, 49h, 74h, 3Bh, 3Ch, 50h, 74h, 3Dh, 3Ch, 53h, 74h, 43h, 3Ch, 55h, 74h, 18h
	db	0F7h, 6, 0B6h, 38h, 2, 0, 75h, 35h, 3Ch, 69h, 74h, 23h, 3Ch, 70h, 74h, 25h
	db	3Ch, 73h, 74h, 2Bh, 3Ch, 75h, 75h, 25h, 0ACh, 3Ch, 42h, 74h, 0Ch, 0F7h, 6, 0B6h
	db	38h, 2, 0, 75h, 18h, 3Ch, 62h, 75h, 14h, 8Bh, 16h, 8Eh, 56h, 0EBh, 14h, 8Bh
	db	16h, 56h, 56h, 0EBh, 0Eh, 8Bh, 16h, 52h, 56h, 0EBh, 8, 0EBh, 1Eh, 0EBh, 17h, 8Bh
	db	16h, 5Eh, 56h, 0BBh, 40h, 7, 8Ah, 4, 0D7h, 0A8h, 90h, 75h, 9, 6, 55h, 89h
	db	36h, 24h, 3Eh, 0E9h, 0E8h, 0, 8Bh, 0F1h, 8Ah, 44h, 0FFh, 6, 55h, 32h, 0E4h, 4Eh
	db	0BBh, 40h, 7, 0D7h, 16h, 7, 0BFh, 26h, 3Eh, 33h, 0EDh, 0B1h, 5, 0B6h, 90h, 0F7h
	db	6, 0B6h, 38h, 2, 0, 74h, 1Fh, 0ACh, 0AAh, 0D3h, 0C5h, 33h, 0E8h, 8Ah, 4, 0D7h
	db	84h, 0C6h, 74h, 3Ah, 0ACh, 0AAh, 0D3h, 0C5h, 33h, 0E8h, 8Ah, 4, 0D7h, 84h, 0C6h, 75h
	db	0E6h, 0EBh, 2Bh, 0E9h, 2Bh, 1, 8Ah, 0D0h, 0ACh, 80h, 0E2h, 20h, 2Ah, 0C2h, 0AAh, 0D3h
	db	0C5h, 33h, 0E8h, 8Ah, 4, 0D7h, 84h, 0C6h, 74h, 14h, 8Ah, 0D0h, 0ACh, 80h, 0E2h, 20h
	db	2Ah, 0C2h, 0AAh, 0D3h, 0C5h, 33h, 0E8h, 8Ah, 4, 0D7h, 84h, 0C6h, 75h, 0D8h, 89h, 36h
	db	24h, 3Eh, 3Bh, 3Eh, 0D0h, 39h, 73h, 0CBh, 0C6h, 5, 0Dh, 0BEh, 26h, 3Eh, 8Bh, 16h
	db	7Ch, 51h, 81h, 0E2h, 0, 80h, 74h, 10h, 33h, 0D2h, 8Bh, 4, 3Bh, 6, 80h, 51h
	db	75h, 6, 8Bh, 16h, 78h, 51h, 3, 0EAh, 0D1h, 0E5h, 8Bh, 0C6h, 8Bh, 0DFh, 2Bh, 0D8h
	db	8Eh, 6, 0B8h, 39h, 23h, 2Eh, 0C0h, 39h, 26h, 8Bh, 4Eh, 0, 0E3h, 2, 0EBh, 3
	db	0E9h, 7Fh, 0, 51h, 55h, 53h, 8Bh, 0D9h, 0C1h, 0C3h, 4, 8Bh, 0EBh, 83h, 0E5h, 0F0h
	db	83h, 0E3h, 0Fh, 0D1h, 0E3h, 36h, 8Eh, 87h, 0D2h, 38h, 5Bh, 8Bh, 0CBh, 26h, 3Ah, 4Eh
	db	6, 75h, 57h, 26h, 3Bh, 56h, 0Ah, 75h, 51h, 26h, 0C4h, 7Eh, 0, 0D1h, 0E9h, 0F3h
	db	0A7h, 75h, 45h, 8Bh, 0CBh, 83h, 0E1h, 1, 0F3h, 0A6h, 75h, 3Ch, 5Dh, 5Ah, 53h, 8Bh
	db	0DAh, 0C1h, 0C3h, 4, 8Bh, 0EBh, 83h, 0E5h, 0F0h, 83h, 0E3h, 0Fh, 0D1h, 0E3h, 36h, 8Eh
	db	87h, 0D2h, 38h, 5Bh, 8Bh, 36h, 28h, 4Eh, 89h, 94h, 28h, 46h, 83h, 6, 28h, 4Eh
	db	2, 26h, 8Ah, 46h, 7, 24h, 3Fh, 3Ch, 1, 74h, 70h, 3Ch, 0Eh, 74h, 75h, 26h
	db	8Bh, 46h, 0Ch, 5Dh, 7, 32h, 0DBh, 0C3h, 8Bh, 0F0h, 5Dh, 59h, 83h, 0C5h, 16h, 0E9h
	db	6Eh, 0FFh, 8Bh, 0FBh, 3, 0F8h, 83h, 3Eh, 0C4h, 39h, 0, 75h, 12h, 0B8h, 2, 0
	db	0B9h, 0, 2, 9Ah
	dd	L100B0
	db	89h, 0Eh, 0C4h, 39h, 0A3h, 0C2h, 39h, 0A1h, 0C2h, 39h, 83h, 6, 0C2h, 39h, 2, 83h
	db	2Eh, 0C4h, 39h, 2, 0E8h, 61h, 2, 8Bh, 36h, 28h, 4Eh, 89h, 94h, 28h, 46h, 83h
	db	6, 28h, 4Eh, 2, 32h, 0DBh, 5Dh, 7, 0C3h, 0BEh, 26h, 3Eh, 8Bh, 0Eh, 0BAh, 38h
	db	33h, 0EDh, 51h, 0B1h, 5, 0D3h, 0C5h, 59h, 0ACh, 98h, 33h, 0E8h, 0E2h, 0F4h, 8Bh, 0FEh
	db	0E9h, 0EDh, 0FEh, 0F6h, 6, 0D2h, 39h, 2, 75h, 8Dh, 0EBh, 9, 0F6h, 6, 0D2h, 39h
	db	2, 75h, 84h, 0EBh, 14h, 9Ah
	dd	L101F7
	db	8Bh, 0D8h, 0E8h, 0E0h, 7, 56h, 0E8h, 2Ch, 0, 5Eh, 5Dh, 7, 0E9h, 0BBh, 0F7h, 9Ah
	dd	L101F7
	db	8Bh, 0D8h, 0E8h, 0CCh, 7, 0E8h, 6Bh, 0EBh, 9Ah
	dd	L101E0
	db	26h, 8Bh, 56h, 8, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 0Ch, 5Dh, 7, 32h, 0DBh, 0C3h, 0F6h, 6, 0C9h, 38h, 2, 74h, 6Fh
	db	0E8h, 48h, 0EBh, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 8, 26h, 8Bh, 4Eh, 0Ah, 9Ah
	dd	L1035F
	db	81h, 0C6h, 28h, 46h, 6, 57h, 16h, 7, 8Bh, 0C1h, 8Bh, 0Eh, 28h, 4Eh, 81h, 0C1h
	db	28h, 46h, 2Bh, 0CEh, 0D1h, 0E9h, 49h, 83h, 2Eh, 28h, 4Eh, 2, 0E3h, 20h, 8Bh, 0D1h
	db	8Bh, 0FEh, 83h, 0C6h, 2, 0F3h, 0A5h, 83h, 0EFh, 2, 8Bh, 0F7h, 3, 0F8h, 81h, 0FFh
	db	28h, 4Eh, 77h, 1Ch, 8Bh, 0CAh, 0FDh, 0E3h, 5, 0F3h, 0A5h, 83h, 0C6h, 2, 0FCh, 1
	db	6, 28h, 4Eh, 8Bh, 0FEh, 5Eh, 1Fh, 0D1h, 0E8h, 8Bh, 0C8h, 0F3h, 0A5h, 16h, 1Fh, 0C3h
	db	5Eh, 1Fh, 16h, 1Fh, 0B9h, 89h, 0, 0E9h, 27h, 3, 8Bh, 0C6h, 5, 2, 0, 3Bh
	db	6, 28h, 4Eh, 75h, 86h, 89h, 36h, 28h, 4Eh, 0C6h, 6, 32h, 4Eh, 0, 6, 55h
	db	0E8h, 0C3h, 0EAh, 5Dh, 7, 26h, 8Ah, 4Eh, 6, 32h, 0EDh, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 0Ch, 26h, 8Bh, 56h, 0Eh, 9Ah
	dd	L1035F
	db	6, 57h, 8Bh, 3Eh, 24h, 3Eh, 8Bh, 0F7h, 2Bh, 0F9h, 89h, 3Eh, 24h, 3Eh, 1Eh, 7
	db	0ACh, 0AAh, 3Ch, 0Dh, 75h, 0FAh, 8Bh, 0C2h, 8Bh, 0D7h, 2Bh, 16h, 24h, 3Eh, 4Fh, 8Bh
	db	0F7h, 3, 0F8h, 81h, 0FFh, 24h, 3Eh, 77h, 9Ah, 8Bh, 0CAh, 0FDh, 0F3h, 0A4h, 46h, 0FCh
	db	8Bh, 0FEh, 5Eh, 1Fh, 8Bh, 0C8h, 0F3h, 0A4h, 16h, 1Fh, 0C3h
L03273:	and	ax, ax	;@03273
	jne	@@1	;@03275
	mov	si, 4628h	;@03277
	mov	ax, word ptr ds:[4E28h]	;@0327A
	jmp	short @@3	;@0327D
@@1:	mov	si, word ptr ds:[3E24h]	;@0327F
	mov	bx, 740h	;@03283
@@2:	lodsb	;@03286
	xlat	;@03287
	test	al, 1	;@03288
	je	@@2	;@0328A
	mov	ax, si	;@0328C
	dec	ax	;@0328E
	mov	si, 3A24h	;@0328F
	sub	ax, si	;@03292
@@3:	mov	cx, ax	;@03294
	call	far ptr L10215	;@03296
	push	cx	;@0329B
	inc	cx	;@0329C
	shr	cx, 1	;@0329D
	rep movsw	;@0329F
	pop	cx	;@032A1
	ret	;@032A2
L032A3:	push	dx	;@032A3
	call	far ptr L1035F	;@032A4
	pop	dx	;@032A9
	push	es	;@032AA
	pop	ds	;@032AB
	push	ss	;@032AC
	pop	es	;@032AD
	mov	si, di	;@032AE
	and	dl, dl	;@032B0
	jne	@@1	;@032B2
	mov	word ptr ss:[4E28h], cx	;@032B4
	shr	cx, 1	;@032B9
	mov	di, 4628h	;@032BB
	rep movsw	;@032BE
	push	ss	;@032C0
	pop	ds	;@032C1
	mov	byte ptr ds:[4E32h], 0FFh	;@032C2
	ret	;@032C7
@@1:	test	byte ptr ss:[38C9h], 1	;@032C8
	jne	@@2	;@032CE
	mov	di, 3A24h	;@032D0
	mov	word ptr ss:[3E24h], di	;@032D3
	rep movsb	;@032D8
	mov	al, 0Dh	;@032DA
	stosb	;@032DC
	push	ss	;@032DD
	pop	ds	;@032DE
	xor	ax, ax	;@032DF
	mov	byte ptr ds:[4E32h], al	;@032E1
	mov	word ptr ds:[4E28h], ax	;@032E4
	ret	;@032E7
@@2:	push	ss	;@032E8
	pop	ds	;@032E9
	ret	;@032EA
L032EB:	mov	si, bx	;@032EB
	mov	dx, cx	;@032ED
	mov	bx, 740h	;@032EF
	push	ss	;@032F2
	pop	es	;@032F3
	mov	di, 3E26h	;@032F4
	xor	bp, bp	;@032F7
	mov	cl, 5	;@032F9
	test	word ptr ds:[38B6h], 2	;@032FB
	je	@@2	;@03301
@@1:	lodsb	;@03303
	stosb	;@03304
	cbw	;@03305
	rol	bp, cl	;@03306
	xor	bp, ax	;@03308
	dec	dx	;@0330A
	jne	@@1	;@0330B
	jmp	short @@3	;@0330D
@@2:	mov	al, byte ptr [si]	;@0330F
	xlat	;@03311
	mov	ah, al	;@03312
	lodsb	;@03314
	and	ah, 20h	;@03315
	sub	al, ah	;@03318
	stosb	;@0331A
	cbw	;@0331B
	rol	bp, cl	;@0331C
	xor	bp, ax	;@0331E
	dec	dx	;@03320
	jne	@@2	;@03321
@@3:	mov	si, 3E26h	;@03323
	shl	bp, 1	;@03326
@@4:	mov	es, word ptr ds:[39B8h]	;@03328
	and	bp, word ptr ds:[39C0h]	;@0332C
	mov	cx, word ptr es:[bp]	;@03330
	jcxz	@@7	;@03334
	push	bp	;@03336
	mov	ax, cx	;@03337
	call	far ptr L101E0	;@03339
	mov	cx, di	;@0333E
	sub	cx, si	;@03340
	cmp	cl, byte ptr es:[bp+6]	;@03342
	jne	@@6	;@03346
	cmp	word ptr es:[bp+0Ah], 0	;@03348
	jne	@@6	;@0334D
	mov	ax, si	;@0334F
	mov	bx, di	;@03351
	les	di, dword ptr es:[bp]	;@03353
	push	cx	;@03357
	shr	cx, 1	;@03358
	repe cmpsw	;@0335A
	pop	cx	;@0335C
	jne	@@5	;@0335D
	and	cx, 1	;@0335F
	repe cmpsb	;@03362
	jne	@@5	;@03364
	pop	bp	;@03366
	mov	es, word ptr ds:[39B8h]	;@03367
	ret	;@0336B
@@5:	mov	si, ax	;@0336C
	mov	di, bx	;@0336E
@@6:	pop	bp	;@03370
	add	bp, 16h	;@03371
	jmp	@@4	;@03374
@@7:	stc	;@03376
	ret	;@03377
L03378:	mov	word ptr es:[bp], ax	;@03378
	mov	byte ptr [di], 0Dh	;@0337C
	call	far ptr L101E0	;@0337F
	mov	bx, ax	;@03384
	xor	ax, ax	;@03386
	mov	byte ptr es:[bp+7], al	;@03388
	mov	byte ptr es:[bp+10h], al	;@0338C
	mov	byte ptr es:[bp+11h], 20h	;@03390
	mov	word ptr es:[bp+1Ch], ax	;@03395
	mov	word ptr es:[bp+0Eh], ax	;@03399
	mov	word ptr es:[bp+8], ax	;@0339D
	mov	word ptr es:[bp+0Ah], dx	;@033A1
	mov	cx, di	;@033A5
	sub	cx, si	;@033A7
	mov	ax, cx	;@033A9
	mov	byte ptr es:[bp+6], al	;@033AB
	call	far ptr L10215	;@033AF
	mov	dx, di	;@033B4
	inc	cx	;@033B6
	shr	cx, 1	;@033B7
	rep movsw	;@033B9
	mov	cx, es	;@033BB
	push	ax	;@033BD
	mov	ax, bx	;@033BE
	call	far ptr L101E0	;@033C0
	pop	ax	;@033C5
	mov	word ptr es:[bp+4], ax	;@033C6
	mov	word ptr es:[bp], dx	;@033CA
	mov	word ptr es:[bp+2], cx	;@033CE
	dec	word ptr ds:[39BEh]	;@033D2
	je	@@1	;@033D6
	test	word ptr ds:[38B6h], 2	;@033D8
	jne	@@2	;@033DE
	mov	ax, bx	;@033E0
	mov	dx, ax	;@033E2
	mov	word ptr es:[bp+0Ch], ax	;@033E4
	ret	;@033E8
@@1:	mov	byte ptr ds:[38C8h], 0Bh	;@033E9
	stc	;@033EE
	mov	sp, word ptr ds:[38ACh]	;@033EF
	retf	;@033F3
@@2:	push	bx	;@033F4
	push	es	;@033F5
	push	bp	;@033F6
	mov	si, 3E26h	;@033F7
	mov	bx, 740h	;@033FA
	mov	cl, 5	;@033FD
	xor	bp, bp	;@033FF
	mov	al, byte ptr [si]	;@03401
	xlat	;@03403
@@3:	mov	ah, al	;@03404
	lodsb	;@03406
	and	ah, 20h	;@03407
	sub	al, ah	;@0340A
	cbw	;@0340C
	mov	byte ptr [si-1], al	;@0340D
	rol	bp, cl	;@03410
	xor	bp, ax	;@03412
	mov	al, byte ptr [si]	;@03414
	xlat	;@03416
	test	al, 90h	;@03417
	jne	@@3	;@03419
	mov	di, si	;@0341B
	mov	si, 3E26h	;@0341D
	xor	dx, dx	;@03420
	test	word ptr ds:[517Ch], 8000h	;@03422
	je	@@4	;@03428
	mov	ax, word ptr [si]	;@0342A
	cmp	ax, word ptr ds:[5180h]	;@0342C
	jne	@@4	;@03430
	mov	dx, word ptr ds:[5178h]	;@03432
	add	bp, dx	;@03436
@@4:	shl	bp, 1	;@03438
@@5:	mov	es, word ptr ds:[39B8h]	;@0343A
	and	bp, word ptr ds:[39C0h]	;@0343E
	mov	cx, word ptr es:[bp]	;@03442
	jcxz	@@8	;@03446
	push	cx	;@03448
	push	bp	;@03449
	mov	ax, cx	;@0344A
	call	far ptr L101E0	;@0344C
	mov	cx, di	;@03451
	sub	cx, si	;@03453
	cmp	cl, byte ptr es:[bp+6]	;@03455
	jne	@@7	;@03459
	cmp	dx, word ptr es:[bp+0Ah]	;@0345B
	jne	@@7	;@0345F
	mov	ax, si	;@03461
	mov	bx, di	;@03463
	les	di, dword ptr es:[bp]	;@03465
	push	cx	;@03469
	shr	cx, 1	;@0346A
	repe cmpsw	;@0346C
	pop	cx	;@0346E
	jne	@@6	;@0346F
	and	cx, 1	;@03471
	repe cmpsb	;@03474
	jne	@@6	;@03476
	pop	bp	;@03478
	pop	ax	;@03479
	pop	bp	;@0347A
	pop	es	;@0347B
	mov	word ptr es:[bp+0Ch], ax	;@0347C
	pop	dx	;@03480
	ret	;@03481
@@6:	mov	si, ax	;@03482
	mov	di, bx	;@03484
@@7:	pop	bp	;@03486
	pop	cx	;@03487
	add	bp, 16h	;@03488
	jmp	@@5	;@0348B
@@8:	pop	bp	;@0348D
	pop	es	;@0348E
	pop	ax	;@0348F
	mov	dx, ax	;@03490
	mov	word ptr es:[bp+0Ch], ax	;@03492
	ret	;@03496
L03497:	call	far ptr L101F7	;@03497
	mov	di, ax	;@0349C
	mov	al, byte ptr es:[bp+7]	;@0349E
	and	al, 3Fh	;@034A2
	cmp	al, 0Bh	;@034A4
	mov	cx, 102Ah	;@034A6
	jne	@@1	;@034A9
	mov	cx, 107Dh	;@034AB
@@1:	call	L0352C	;@034AE
	xor	di, di	;@034B1
	dec	di	;@034B3
	ret	;@034B4
L034B5:	test	byte ptr es:[bp+10h], bh	;@034B5
	jne	@@4	;@034B9
@@1:	test	byte ptr es:[bp+7], 40h	;@034BB
	jne	@@3	;@034C0
@@2:	ret	;@034C2
@@3:	test	word ptr ds:[5182h], 2000h	;@034C3
	je	@@2	;@034C9
	push	di	;@034CB
	push	cx	;@034CC
	push	bx	;@034CD
	push	dx	;@034CE
	mov	cx, 9079h	;@034CF
	push	ax	;@034D2
	call	far ptr L101F7	;@034D3
	mov	di, ax	;@034D8
	pop	ax	;@034DA
	call	L0352C	;@034DB
	xor	di, di	;@034DE
	pop	dx	;@034E0
	pop	bx	;@034E1
	pop	cx	;@034E2
	pop	di	;@034E3
	ret	;@034E4
@@4:	call	@@5	;@034E5
	jmp	@@1	;@034E8
@@5:	cmp	word ptr ds:[38B8h], 0	;@034EA
	je	@@6	;@034EF
	test	byte ptr ds:[38C9h], 8	;@034F1
	jne	@@7	;@034F6
	mov	byte ptr ds:[38D0h], 0FFh	;@034F8
	jmp	short @@7	;@034FD
@@6:	test	word ptr ds:[5182h], 10h	;@034FF
	je	@@7	;@03505
	push	di	;@03507
	push	cx	;@03508
	push	bx	;@03509
	push	dx	;@0350A
	mov	cx, 905Ch	;@0350B
	push	ax	;@0350E
	call	far ptr L101F7	;@0350F
	mov	di, ax	;@03514
	pop	ax	;@03516
	call	L0352C	;@03517
	pop	dx	;@0351A
	pop	bx	;@0351B
	pop	cx	;@0351C
	pop	di	;@0351D
@@7:	ret	;@0351E
	db	0	;@0351F
L03520:	call	L03750	;@03520
	retf	;@03523
L03524:	call	L03F61	;@03524
	retf	;@03527
L03528:	call	L004D1	;@03528
	retf	;@0352B
L0352C:	call	far ptr L126B7	;@0352C
	ret	;@03531
L03532:	call	L04EA7	;@03532
	retf	;@03535
	db	9Ah	;@03536
	dd	L101E0
	db	26h, 8Bh, 46h, 10h, 26h, 8Bh, 56h, 12h, 0C3h
L03544:	call	far ptr L101E0	;@03544
	mov	bx, word ptr es:[bp+14h]	;@03549
	ret	;@0354D
	db	9Ah	;@0354E
	dd	L101E0
	db	26h, 8Bh, 5Eh, 16h, 23h, 0DBh, 74h, 1, 0C3h, 26h, 8Bh, 5Eh, 14h, 6, 55h, 9Ah
	dd	L131A9
	db	5Dh, 7, 26h, 89h, 5Eh, 16h, 0C3h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 5Eh, 18h, 23h, 0DBh, 74h, 1, 0C3h, 26h, 8Bh, 5Eh, 14h, 6, 55h, 9Ah
	dd	L131C2
	db	5Dh, 7, 26h, 89h, 5Eh, 18h, 0C3h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 5Eh, 0Ah, 23h, 0DBh, 74h, 1, 0C3h, 26h, 8Bh, 5Eh, 14h, 6, 55h, 9Ah
	dd	L131CD
	db	5Dh, 7, 26h, 89h, 5Eh, 0Ah, 0C3h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 5Eh, 1Ah, 23h, 0DBh, 74h, 1, 0C3h, 26h, 8Bh, 5Eh, 14h, 6, 55h, 9Ah
	dd	L131D7
	db	5Dh, 7, 26h, 89h, 5Eh, 1Ah, 0C3h, 6, 55h, 26h, 8Bh, 46h, 0Ch, 0EBh, 4, 26h
	db	8Bh, 46h, 2, 0Bh, 0C0h, 74h, 26h, 9Ah
	dd	L101E0
	db	26h, 8Ah, 46h, 4, 6, 55h, 56h, 3Ch, 2, 74h, 21h, 3Ch, 3, 74h, 31h, 3Ch
	db	7, 74h, 43h, 3Ch, 6, 74h, 50h, 3Ch, 1, 74h, 65h, 0F8h, 5Eh, 5Dh, 7, 73h
	db	0D2h, 5Dh, 7, 26h, 8Bh, 46h, 10h, 26h, 8Bh, 56h, 12h, 0C3h, 26h, 8Bh, 5Eh, 6
	db	26h, 8Bh, 56h, 8, 26h, 8Bh, 46h, 14h, 26h, 8Bh, 4Eh, 16h, 0FFh, 14h, 0EBh, 0DCh
	db	26h, 8Bh, 5Eh, 8, 26h, 8Bh, 56h, 0Ah, 26h, 8Bh, 4Eh, 0Ch, 8Bh, 0FDh, 83h, 0C7h
	db	0Eh, 0FFh, 54h, 2, 0EBh, 0C6h, 26h, 8Bh, 5Eh, 8, 26h, 8Bh, 56h, 0Ah, 26h, 8Bh
	db	4Eh, 0Ch, 0FFh, 54h, 4, 0EBh, 0B5h, 26h, 8Ah, 4Eh, 0Ah, 26h, 8Bh, 5Eh, 0Bh, 26h
	db	8Bh, 56h, 0Dh, 26h, 8Bh, 46h, 0Fh, 26h, 8Bh, 7Eh, 11h, 0FFh, 54h, 6, 0EBh, 9Ch
	db	26h, 8Bh, 5Eh, 6, 26h, 8Bh, 56h, 8, 0FFh, 54h, 8, 0EBh, 8Fh
L03670:	call	L04EA7	;@03670
	retf	;@03673
L03674:	xor	ax, ax	;@03674
	mov	word ptr ds:[5062h], ax	;@03676
	mov	word ptr ds:[5064h], ax	;@03679
	mov	word ptr ds:[5066h], ax	;@0367C
	mov	word ptr ds:[5068h], ax	;@0367F
	mov	ax, ss	;@03682
	mov	es, ax	;@03684
	mov	di, 516Eh	;@03686
	mov	cx, 59h	;@03689
	xor	al, al	;@0368C
	rep stosb	;@0368E
	mov	word ptr ds:[517Ch], 6020h	;@03690
	call	L0F969	;@03696
	mov	word ptr ds:[51B4h], 8Dh	;@03699
	mov	word ptr ds:[5182h], 0FFF3h	;@0369F
	mov	word ptr ds:[5180h], 4040h	;@036A5
	test	word ptr ds:[38B6h], 20h	;@036AB
	je	@@1	;@036B1
	or	word ptr ds:[51B4h], 0C00h	;@036B3
@@1:	test	word ptr ds:[38B6h], 1000h	;@036B9
	je	@@2	;@036BF
	or	word ptr ds:[51B4h], 10h	;@036C1
@@2:	test	word ptr ds:[38B6h], 8000h	;@036C6
	je	@@3	;@036CC
	or	word ptr ds:[51B4h], 4B0h	;@036CE
@@3:	test	word ptr ds:[38B6h], 80h	;@036D4
	je	@@4	;@036DA
	and	word ptr ds:[51B4h], 0FF7Fh	;@036DC
@@4:	test	word ptr ds:[38B6h], 40h	;@036E2
	je	@@5	;@036E8
	or	word ptr ds:[517Ch], 100h	;@036EA
@@5:	test	word ptr ds:[38B6h], 200h	;@036F0
	je	@@6	;@036F6
	or	word ptr ds:[517Ch], 40h	;@036F8
@@6:	ret	;@036FD
L036FE:	mov	ax, word ptr ds:[5062h]	;@036FE
	mov	word ptr ds:[5062h], 0	;@03701
	call	@@2	;@03707
	mov	ax, word ptr ds:[5064h]	;@0370A
	mov	word ptr ds:[5064h], 0	;@0370D
	call	@@2	;@03713
	mov	ax, word ptr ds:[5066h]	;@03716
	mov	word ptr ds:[5066h], 0	;@03719
@@1:	and	ax, ax	;@0371F
	je	@@3	;@03721
	call	far ptr L101E0	;@03723
	push	word ptr es:[bp]	;@03728
	mov	dx, 2	;@0372C
	call	far ptr L1015C	;@0372F
	pop	ax	;@03734
	jmp	@@1	;@03735
@@2:	and	ax, ax	;@03737
	je	@@3	;@03739
	call	far ptr L101E0	;@0373B
	push	word ptr es:[bp]	;@03740
	mov	dx, 1	;@03744
	call	far ptr L1015C	;@03747
	pop	ax	;@0374C
	jmp	@@2	;@0374D
@@3:	ret	;@0374F
L03750:	mov	di, word ptr ds:[51B2h]	;@03750
	and	di, di	;@03754
	je	@@2	;@03756
	test	word ptr ds:[5182h], 200h	;@03758
	je	@@1	;@0375E
	mov	cx, 9036h	;@03760
	call	L0352C	;@03763
@@1:	call	L04189	;@03766
	jmp	L03750	;@03769
@@2:	call	L0423E	;@0376B
@@3:	mov	di, word ptr ds:[517Eh]	;@0376E
	and	di, di	;@03772
	je	@@6	;@03774
	cmp	byte ptr ds:[51C6h], 0	;@03776
	jne	@@5	;@0377B
	test	word ptr ds:[5182h], 100h	;@0377D
	je	@@4	;@03783
	mov	cx, 9035h	;@03785
	call	L0352C	;@03788
@@4:	call	L043D0	;@0378B
	jmp	@@3	;@0378E
@@5:	dec	byte ptr ds:[51C6h]	;@03790
	jmp	@@4	;@03794
@@6:	cmp	byte ptr ds:[51C2h], 0	;@03796
	je	@@7	;@0379B
	test	word ptr ds:[5182h], 400h	;@0379D
	je	@@7	;@037A3
	mov	cx, 8038h	;@037A5
	call	L0352C	;@037A8
@@7:	mov	di, word ptr ds:[51B0h]	;@037AB
	and	di, di	;@037AF
	je	@@8	;@037B1
	mov	cx, 104Bh	;@037B3
	call	L0352C	;@037B6
	call	L03CF3	;@037B9
	jmp	@@7	;@037BC
@@8:	ret	;@037BE
	db	0F6h, 6, 0C9h, 38h, 3, 75h, 8, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 1, 0C3h	;@037BF
	db	56h, 8Bh, 0F0h, 0E3h, 0Fh, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0E8h, 0F3h, 0CCh, 9Ah
	dd	L10375
	db	8Bh, 0FAh, 8Bh, 0EBh, 9Ah
	dd	L12BB3
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 10h, 75h, 9, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h
	db	0Ch, 0C3h, 0E8h, 0F8h, 0, 0F6h, 6, 0C9h, 38h, 1, 74h, 0EDh, 0C3h, 0F6h, 6, 0C9h
	db	38h, 2, 75h, 0F8h, 0E8h, 0B3h, 0CCh, 56h, 8Bh, 0F0h, 52h, 0EBh, 39h
L03819:	test	byte ptr ds:[38C9h], 10h	;@03819
	jne	@@2	;@0381E
@@1:	test	word ptr ds:[38B6h], 4000h	;@03820
	jne	@@4	;@03826
	ret	;@03828
@@2:	call	L038F9	;@03829
	test	byte ptr ds:[38C9h], 1	;@0382C
	je	@@1	;@03831
@@3:	ret	;@03833
@@4:	test	byte ptr ds:[38C9h], 2	;@03834
	jne	@@3	;@03839
	call	L004C6	;@0383B
	mov	cx, word ptr ds:[517Eh]	;@0383E
	jcxz	@@3	;@03842
	push	si	;@03844
	mov	si, ax	;@03845
	push	dx	;@03847
	call	far ptr L101F7	;@03848
	call	L00861	;@0384D
	je	@@5	;@03850
	push	es	;@03852
	push	bp	;@03853
	mov	ax, cx	;@03854
	call	far ptr L101E0	;@03856
	call	L016B5	;@0385B
	pop	bp	;@0385E
	pop	es	;@0385F
	push	bx	;@03860
	mov	bx, ax	;@03861
	mov	dx, cx	;@03863
	call	L004D1	;@03865
	call	far ptr L10375	;@03868
	pop	bp	;@0386D
	pop	di	;@0386E
	call	far ptr L12D00	;@0386F
	pop	si	;@03874
	ret	;@03875
@@5:	push	es	;@03876
	push	bp	;@03877
	mov	ax, cx	;@03878
	call	far ptr L101E0	;@0387A
	call	L016B5	;@0387F
	pop	bp	;@03882
	pop	es	;@03883
	push	bx	;@03884
	mov	bx, ax	;@03885
	mov	dx, cx	;@03887
	call	L004D1	;@03889
	call	far ptr L10375	;@0388C
	pop	bp	;@03891
	pop	di	;@03892
	call	far ptr L12F89	;@03893
	pop	si	;@03898
	ret	;@03899
	db	0F6h, 6, 0C9h, 38h, 10h, 75h, 9, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 0Ch, 0C3h	;@0389A
	db	0E8h, 53h, 0, 0F6h, 6, 0C9h, 38h, 1, 74h, 0EDh, 0C3h, 0F6h, 6, 0C9h, 38h, 2
	db	75h, 0F8h, 0E8h, 7, 0CCh, 56h, 8Bh, 0F0h, 52h, 9Ah
	dd	L101F7
	db	0E8h, 96h, 0CFh, 74h, 12h, 0E8h, 1, 0CCh, 9Ah
	dd	L10375
	db	5Fh, 8Bh, 0EBh, 9Ah
	dd	L12D1F
	db	5Eh, 0C3h, 0E8h, 0EFh, 0CBh, 9Ah
	dd	L10375
	db	5Fh, 8Bh, 0EBh, 9Ah
	dd	L12FA7
	db	5Eh, 0C3h
L038F1:	test	byte ptr ds:[38C9h], 10h	;@038F1
	jne	L03900	;@038F6
	ret	;@038F8
L038F9:	push	es	;@038F9
	push	bp	;@038FA
	call	L0463A	;@038FB
	pop	bp	;@038FE
	pop	es	;@038FF
L03900:	push	si	;@03900
	push	es	;@03901
	push	bp	;@03902
	push	ax	;@03903
	push	bx	;@03904
	call	far ptr L101F7	;@03905
	call	far ptr L107FD	;@0390A
	pop	bx	;@0390F
	pop	ax	;@03910
	pop	bp	;@03911
	pop	es	;@03912
	pop	si	;@03913
	ret	;@03914
L03915:	call	far ptr L101F7	;@03915
	call	L00861	;@0391A
	je	@@1	;@0391D
	call	L004D1	;@0391F
	call	far ptr L10375	;@03922
	mov	bp, bx	;@03927
	call	far ptr L12D38	;@03929
	ret	;@0392E
@@1:	call	L004D1	;@0392F
	call	far ptr L10375	;@03932
	mov	bp, bx	;@03937
	call	far ptr L12FBD	;@03939
	ret	;@0393E
	db	0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 56h, 6, 55h, 53h, 52h, 9Ah	;@0393F
	dd	L10813
	db	5Ah, 5Bh, 5Dh, 7, 5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 1, 75h, 8, 0F7h, 6, 0B6h
	db	38h, 0, 40h, 75h, 1, 0C3h, 56h, 8Bh, 0F0h, 8Bh, 0FAh, 87h, 0DDh, 0E8h, 36h, 15h
	db	8Bh, 0C3h, 8Bh, 0D1h, 8Bh, 0DDh, 9Ah
	dd	L13183
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 56h, 6, 55h, 0B0h, 3Dh, 9Ah
	dd	L10775
	db	0B0h, 20h, 9Ah
	dd	L10775
	db	5Dh, 7, 0E8h, 52h, 1Eh, 5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 56h
	db	6, 55h, 53h, 51h, 0B0h, 3Dh, 9Ah
	dd	L10775
	db	0B0h, 20h, 9Ah
	dd	L10775
	db	59h, 5Fh, 57h, 51h, 16h, 7, 9Ah
	dd	L10782
	db	59h, 5Bh, 5Dh, 7, 5Eh, 0C3h, 8Bh, 0Eh, 64h, 50h, 0E3h, 18h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 4Eh, 0, 23h, 0C9h, 75h, 0F1h, 26h, 8Bh, 46h, 4, 26h, 8Bh, 56h, 6
	db	0C3h, 0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 0C3h
L039F0:	xor	ax, ax	;@039F0
	mov	byte ptr ds:[516Ch], al	;@039F2
	mov	word ptr ds:[506Ah], ax	;@039F5
	ret	;@039F8
	db	0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 3, 6, 6Ah, 50h, 83h, 0D2h	;@039F9
	db	0, 0C3h, 8Bh, 0Eh, 6Ah, 50h, 0E3h, 77h, 0A1h, 0A4h, 51h, 23h, 0C0h
	db	74h, 7Ch, 0F6h, 6, 0C9h, 38h, 10h, 'tJP', 0E8h, 1Ah, 0Ch, 58h
	db	0F6h, 6, 0C9h, 38h, 1, 75h, 54h, 0EBh, 3Ch
L03A2A:	mov	cx, word ptr ds:[506Ah]	;@03A2A
	jcxz	@@4	;@03A2E
	cmp	word ptr ds:[51B0h], 0	;@03A30
	jne	@@5	;@03A35
	mov	ax, word ptr ds:[51A4h]	;@03A37
	and	ax, ax	;@03A3A
	je	@@6	;@03A3C
	test	byte ptr ds:[38C9h], 10h	;@03A3E
	je	@@1	;@03A43
	push	ax	;@03A45
	call	L0463A	;@03A46
	pop	ax	;@03A49
	test	byte ptr ds:[38C9h], 1	;@03A4A
	jne	@@3	;@03A4F
@@1:	push	ax	;@03A51
	mov	ax, word ptr ds:[517Eh]	;@03A52
	call	far ptr L101E0	;@03A55
	pop	ax	;@03A5A
	call	L00730	;@03A5B
	test	word ptr ds:[38B6h], 8	;@03A5E
	jne	@@9	;@03A64
@@2:	push	si	;@03A66
	mov	si, 506Ch	;@03A67
	mov	cx, word ptr ds:[506Ah]	;@03A6A
	mov	bx, word ptr ds:[5170h]	;@03A6E
	mov	dx, word ptr ds:[5172h]	;@03A72
	call	far ptr L13292	;@03A76
	pop	si	;@03A7B
@@3:	mov	ax, word ptr ds:[506Ah]	;@03A7C
	add	word ptr ds:[5170h], ax	;@03A7F
	jb	@@7	;@03A83
@@4:	ret	;@03A85
@@5:	and	byte ptr ds:[38CAh], 0FEh	;@03A86
	mov	cx, 49h	;@03A8B
	jmp	L0352C	;@03A8E
@@6:	mov	cx, 30h	;@03A91
	jmp	L0352C	;@03A94
@@7:	inc	word ptr ds:[5172h]	;@03A97
	je	@@8	;@03A9B
	call	L04677	;@03A9D
	jne	@@4	;@03AA0
@@8:	jmp	L0468D	;@03AA2
@@9:	test	byte ptr ds:[38C9h], 3	;@03AA5
	jne	@@2	;@03AAA
	xor	cx, cx	;@03AAC
	cmp	word ptr ds:[51B0h], cx	;@03AAE
	jne	@@2	;@03AB2
	cmp	word ptr ds:[5064h], cx	;@03AB4
	jne	@@2	;@03AB8
	cmp	byte ptr ds:[51C5h], cl	;@03ABA
	mov	byte ptr ds:[51C5h], cl	;@03ABE
	jne	@@2	;@03AC2
	mov	dx, word ptr ds:[517Ah]	;@03AC4
	mov	ax, word ptr ds:[516Eh]	;@03AC8
	push	si	;@03ACB
	call	far ptr L11D9C	;@03ACC
	pop	si	;@03AD1
	mov	dx, cx	;@03AD2
	push	ax	;@03AD4
	mov	ax, word ptr ds:[517Eh]	;@03AD5
	call	far ptr L101E0	;@03AD8
	call	L016B5	;@03ADD
	mov	bp, cx	;@03AE0
	mov	cx, ax	;@03AE2
	pop	di	;@03AE4
	mov	ax, dx	;@03AE5
	mov	bx, word ptr ds:[5170h]	;@03AE7
	mov	dx, word ptr ds:[5172h]	;@03AEB
	push	si	;@03AEF
	call	far ptr L12BF5	;@03AF0
	pop	si	;@03AF5
	mov	ax, word ptr ds:[51A4h]	;@03AF6
	jmp	@@2	;@03AF9
L03AFC:	mov	ax, word ptr ds:[51A4h]	;@03AFC
	and	ax, ax	;@03AFF
	je	@@1	;@03B01
	mov	bx, word ptr ds:[5170h]	;@03B03
	mov	dx, word ptr ds:[5172h]	;@03B07
	push	si	;@03B0B
	call	far ptr L1333F	;@03B0C
	pop	si	;@03B11
@@1:	ret	;@03B12
	db	6, 1Fh, 16h, 7, 8Bh, 0F7h, 0BFh, 6Ch, 50h, 8Bh, 0DFh, 51h, 0F3h, 0A4h, 59h, 16h	;@03B13
	db	1Fh, 89h, 0Eh, 6Ah, 50h, 0F6h, 6, 0C9h, 38h, 10h, 74h, 5, 8Bh, 0C1h, 0E8h, 28h
	db	0Bh, 0E9h, 0D1h, 0FEh, 83h, 3Eh, 0A4h, 51h, 0, 74h, 59h, 0F6h, 6, 0C9h, 38h, 10h
	db	75h, 0Dh, 56h, 8Bh, 0F0h, 0A1h, 0A4h, 51h, 9Ah
	dd	L13464
	db	5Eh, 0C3h, 2Bh, 1Eh, 70h, 51h, 1Bh, 16h, 72h, 51h, 0Bh, 0DAh, 0B0h, 2, 75h, 2Ch
	db	80h, 0E1h, 1Ch, 0B0h, 5, 74h, 25h, 80h, 0E9h, 4, 0B0h, 1, 74h, 1Eh, 80h, 0E9h
	db	4, 0B0h, 4, 74h, 17h, 80h, 0E9h, 4, 0B0h, 3, 74h, 10h, 80h, 0E9h, 4, 0B0h
	db	6, 74h, 9, 80h, 0E9h, 4, 0B0h, 1, 74h, 2, 0B0h, 3, 0A2h, 6Ch, 51h, 0F6h
	db	6, 0C9h, 38h, 1, 74h, 0AFh, 0C3h, 0B9h, 30h, 0, 0E9h, 8Fh, 0F9h, 0F6h, 6, 0C9h
	db	38h, 3, 75h, 2Dh, 56h, 51h, 22h, 0C9h, 75h, 4, 32h, 0C0h, 0EBh, 1Ch, 50h, 8Bh
	db	0C3h, 9Ah
	dd	L101E0
	db	5Bh, 0E8h, 89h, 0DFh, 8Bh, 0F0h, 8Bh, 0C7h, 9Ah
	dd	L101E0
	db	0E8h, 7Dh, 0DFh, 8Bh, 0F8h, 0B0h, 0C1h, 9Ah
	dd	L12FCB
	db	59h, 5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 1, 75h, 0Ch, 51h, 56h, 0B1h, 44h, 8Bh, 0F0h
	db	8Bh, 0F8h, 32h, 0EDh, 0EBh, 41h, 0C3h, 0F6h, 6, 0C9h, 38h, 10h, 75h, 5Eh, 51h, 56h
	db	8Ah, 0C8h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 48h, 0DFh, 8Bh, 0F0h, 8Bh, 0C7h, 9Ah
	dd	L101E0
	db	0E8h, 3Ch, 0DFh, 8Bh, 0F8h, 32h, 0EDh, 8Bh, 0D9h, 0D1h, 0E3h, 80h, 0FEh, 2, 74h, 0Eh
	db	83h, 0C3h, 40h, 0F7h, 6, 0B6h, 38h, 0, 1, 74h, 3, 83h, 0C3h, 40h, 8Bh, 8Fh
	db	0D4h, 1Ah, 33h, 0C0h, 8Bh, 1Eh, 70h, 51h, 8Bh, 16h, 72h, 51h, 3, 1Eh, 6Ah, 50h
	db	13h, 0D0h, 2, 0DDh, 12h, 0F8h, 13h, 0D0h, 0A1h, 0A4h, 51h, 23h, 0C0h, 74h, 23h, 9Ah
	dd	L13464
	db	5Eh, 59h, 0C3h, 50h, 24h, 7, 0A2h, 6Ch, 51h, 8Bh, 0C7h, 0E8h, 24h, 0CBh, 58h, 74h
	db	5, 80h, 0Eh, 6Ch, 51h, 8, 0F6h, 6, 0C9h, 38h, 1, 74h, 88h, 0C3h, 0B9h, 30h
	db	0, 0E8h, 0C0h, 0F8h, 5Eh, 59h, 0C3h, 56h, 53h, 0A1h, 0A4h, 51h, 8Bh, 1Eh, 70h, 51h
	db	8Bh, 16h, 72h, 51h, 9Ah
	dd	L13124
	db	5Bh, 5Eh, 56h, 8Bh, 0D0h, 0B8h, 1, 0, 8Bh, 0C8h, 9Ah
	dd	L100B0
	db	9Ah
	dd	L101E0
	db	8Bh, 0Eh, 68h, 50h, 26h, 89h, 4Eh, 0, 0A3h, 68h, 50h, 0A1h, 0A4h, 51h, 26h, 89h
	db	46h, 2, 0A1h, 70h, 51h, 26h, 89h, 46h, 4, 0A1h, 72h, 51h, 26h, 89h, 46h, 6
	db	0A1h, 0AAh, 51h, 26h, 89h, 46h, 8, 0A1h, 0ACh, 51h, 26h, 89h, 46h, 0Ah, 0A0h, 0BDh
	db	51h, 26h, 88h, 46h, 0Ch, 88h, 1Eh, 0BDh, 51h, 89h, 16h, 0A4h, 51h, 33h, 0C0h, 0A3h
	db	0AAh, 51h, 0A3h, 0ACh, 51h, 0A1h, 70h, 51h, 0A3h, 0A6h, 51h, 0A1h, 72h, 51h, 0A3h, 0A8h
	db	51h, 5Eh, 0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 0E9h, 48h, 9
L03CF2:	ret	;@03CF2
L03CF3:	mov	cx, word ptr ds:[5068h]	;@03CF3
	jcxz	L03CF2	;@03CF7
	test	byte ptr ds:[38C9h], 1	;@03CF9
	je	@@2	;@03CFE
	push	word ptr ds:[5170h]	;@03D00
	push	word ptr ds:[5172h]	;@03D04
	cmp	byte ptr ds:[51BDh], 0	;@03D08
	je	@@1	;@03D0D
	mov	ax, word ptr ds:[51AAh]	;@03D0F
	add	word ptr ds:[5170h], ax	;@03D12
	mov	ax, word ptr ds:[51ACh]	;@03D16
	add	word ptr ds:[5172h], ax	;@03D19
@@1:	call	L0463A	;@03D1D
	pop	word ptr ds:[5172h]	;@03D20
	pop	word ptr ds:[5170h]	;@03D24
@@2:	mov	bx, word ptr ds:[5170h]	;@03D28
	mov	dx, word ptr ds:[5172h]	;@03D2C
	mov	ax, word ptr ds:[51A4h]	;@03D30
	push	si	;@03D33
	mov	si, bx	;@03D34
	mov	di, dx	;@03D36
	call	far ptr L13002	;@03D38
	pop	si	;@03D3D
	mov	ax, word ptr ds:[5068h]	;@03D3E
	call	far ptr L101E0	;@03D41
	mov	ax, word ptr es:[bp]	;@03D46
	mov	word ptr ds:[5068h], ax	;@03D4A
	and	ax, ax	;@03D4D
	jne	@@6	;@03D4F
	test	byte ptr ds:[38C9h], 1	;@03D51
	jne	@@5	;@03D56
	test	word ptr ds:[38B6h], 4000h	;@03D58
	je	@@5	;@03D5E
	push	es	;@03D60
	push	bp	;@03D61
	push	si	;@03D62
	mov	ax, word ptr ds:[51B0h]	;@03D63
	call	far ptr L101E0	;@03D66
	call	L00D8C	;@03D6B
	call	L03544	;@03D6E
	push	bx	;@03D71
	mov	ax, word ptr ds:[51B0h]	;@03D72
	call	far ptr L101E0	;@03D75
	push	es	;@03D7A
	push	bp	;@03D7B
	call	L004D1	;@03D7C
	call	far ptr L10375	;@03D7F
	mov	bp, bx	;@03D84
	mov	si, word ptr ds:[51AAh]	;@03D86
	mov	di, word ptr ds:[51ACh]	;@03D8A
	cmp	byte ptr ds:[51BDh], 0	;@03D8E
	je	@@3	;@03D93
	call	far ptr L12BDF	;@03D95
	jmp	short @@4	;@03D9A
@@3:	call	far ptr L12BC9	;@03D9C
@@4:	pop	bp	;@03DA1
	pop	es	;@03DA2
	pop	bx	;@03DA3
	call	L03915	;@03DA4
	pop	si	;@03DA7
	pop	bp	;@03DA8
	pop	es	;@03DA9
	xor	ax, ax	;@03DAA
@@5:	mov	word ptr ds:[51B0h], ax	;@03DAC
@@6:	mov	ax, word ptr es:[bp+2]	;@03DAF
	mov	word ptr ds:[51A4h], ax	;@03DB3
	mov	al, byte ptr es:[bp+0Ch]	;@03DB6
	mov	byte ptr ds:[51BDh], al	;@03DBA
	and	al, al	;@03DBD
	jne	@@7	;@03DBF
	mov	ax, word ptr es:[bp+4]	;@03DC1
	sub	ax, word ptr es:[bp+8]	;@03DC5
	mov	word ptr ds:[51A6h], ax	;@03DC9
	mov	ax, word ptr es:[bp+6]	;@03DCC
	sbb	ax, word ptr es:[bp+0Ah]	;@03DD0
	mov	word ptr ds:[51A8h], ax	;@03DD4
	jmp	short @@8	;@03DD7
@@7:	mov	ax, word ptr es:[bp+4]	;@03DD9
	mov	word ptr ds:[51A6h], ax	;@03DDD
	mov	ax, word ptr es:[bp+6]	;@03DE0
	mov	word ptr ds:[51A8h], ax	;@03DE4
@@8:	mov	ax, word ptr es:[bp+4]	;@03DE7
	mov	word ptr ds:[5170h], ax	;@03DEB
	mov	ax, word ptr es:[bp+6]	;@03DEE
	mov	word ptr ds:[5172h], ax	;@03DF2
	cmp	word ptr ds:[51B0h], 0	;@03DF5
	je	@@9	;@03DFA
	mov	ax, word ptr ds:[51AAh]	;@03DFC
	add	word ptr ds:[5170h], ax	;@03DFF
	mov	ax, word ptr ds:[51ACh]	;@03E03
	adc	word ptr ds:[5172h], ax	;@03E06
	jae	@@9	;@03E0A
	mov	cx, 5Eh	;@03E0C
	call	L0352C	;@03E0F
@@9:	mov	ax, word ptr es:[bp+8]	;@03E12
	mov	word ptr ds:[51AAh], ax	;@03E16
	mov	ax, word ptr es:[bp+0Ah]	;@03E19
	mov	word ptr ds:[51ACh], ax	;@03E1D
	call	far ptr L101F7	;@03E20
	mov	dx, 1	;@03E25
	call	far ptr L1015C	;@03E28
	mov	ax, word ptr ds:[5170h]	;@03E2D
	mov	dx, word ptr ds:[5172h]	;@03E30
	sub	ax, word ptr ds:[51A6h]	;@03E34
	sbb	dx, word ptr ds:[51A8h]	;@03E38
	mov	cx, word ptr ds:[51AAh]	;@03E3C
	sub	cx, ax	;@03E40
	mov	cx, word ptr ds:[51ACh]	;@03E42
	sbb	cx, dx	;@03E46
	jae	@@10	;@03E48
	mov	word ptr ds:[51AAh], ax	;@03E4A
	mov	word ptr ds:[51ACh], dx	;@03E4D
@@10:	cmp	byte ptr ds:[51BDh], 0	;@03E51
	jne	@@11	;@03E56
	ret	;@03E58
@@11:	mov	ax, word ptr ds:[51A6h]	;@03E59
	mov	dx, word ptr ds:[51A8h]	;@03E5C
	mov	bx, word ptr ds:[5170h]	;@03E60
	mov	dx, word ptr ds:[5172h]	;@03E64
	mov	ax, word ptr ds:[51A4h]	;@03E68
	push	si	;@03E6B
	mov	si, bx	;@03E6C
	mov	di, dx	;@03E6E
	call	far ptr L13002	;@03E70
	pop	si	;@03E75
	mov	ax, word ptr ds:[51A6h]	;@03E76
	mov	word ptr ds:[5170h], ax	;@03E79
	mov	ax, word ptr ds:[51A8h]	;@03E7C
	mov	word ptr ds:[5172h], ax	;@03E7F
	ret	;@03E82
	db	0F6h, 6, 0C9h, 38h, 3, 75h, 7, 56h, 9Ah	;@03E83
	dd	L12E97
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 3, 75h, 14h, 8Bh, 0C1h, 9Ah
	dd	L10215
	db	56h, 8Bh, 0F3h, 51h, 0F3h, 0A4h, 59h, 9Ah
	dd	L12EA0
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 3, 75h, 7, 56h, 9Ah
	dd	L12CEC
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 3, 75h, 7, 56h, 9Ah
	dd	L12D70
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 3, 75h, 12h, 56h, 0A1h, 0A4h, 51h, 8Bh, 1Eh, 70h
	db	51h, 8Bh, 16h, 72h, 51h, 9Ah
	dd	L12D4B
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 3, 75h, 0Fh, 56h, 8Bh, 1Eh, 70h, 51h, 8Bh, 16h
	db	72h, 51h, 9Ah
	dd	L12D60
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 3, 75h, 2Dh, 56h, 50h, 52h, 51h, 57h, 0E8h, 0C5h
	db	0C5h, 8Bh, 0EBh, 9Ah
	dd	L10375
	db	5Fh, 5Ah, 8Ah, 0EEh, 50h, 51h, 8Bh, 0C7h, 9Ah
	dd	L101E0
	db	0E8h, 92h, 0D7h, 8Bh, 0D1h, 8Bh, 0D8h, 59h, 58h, 5Fh, 5Eh, 9Ah
	dd	L12D00
	db	5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 3, 75h, 27h, 8Bh, 0Eh, 7Eh, 51h, 0E3h, 21h, 50h
	db	8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0E8h, 6Bh, 0D7h, 8Bh, 0E9h, 8Bh, 0C8h, 5Fh, 8Bh, 0C2h, 8Bh, 1Eh, 70h, 51h, 8Bh, 16h
	db	72h, 51h, 56h, 9Ah
	dd	L12D7A
	db	5Eh, 0C3h
L03F61:	test	byte ptr ds:[38C9h], 3	;@03F61
	jne	@@1	;@03F66
	push	si	;@03F68
	call	far ptr L12EA9	;@03F69
	pop	si	;@03F6E
@@1:	ret	;@03F6F
	db	56h, 8Bh, 0F0h, 8Bh, 0F9h, 8Bh, 1Eh, 70h, 51h, 8Bh, 16h, 72h, 51h, 0A1h, 0A4h, 51h	;@03F70
	db	23h, 0C0h, 75h, 8, 0B9h, 30h, 0, 0E8h, 0A2h, 0F5h, 0EBh, 77h, 56h, 57h, 0F6h, 6
	db	0C9h, 38h, 10h, 74h, 22h, 50h, 53h, 52h, 56h, 57h, 0E8h, 9Dh, 6, 5Ah, 58h, 50h
	db	52h, 9Ah
	dd	L107CC
	db	5Fh, 5Eh, 5Ah, 5Bh, 59h, 0B8h, 0FFh, 0FFh, 0F6h, 6, 0C9h, 38h, 1, 75h, 7, 8Bh
	db	0C1h, 9Ah
	dd	L13095
	db	5Fh, 5Eh, 8Bh, 0D8h, 0B8h, 1, 0, 8Bh, 0C8h, 9Ah
	dd	L100B0
	db	9Ah
	dd	L101E0
	db	8Bh, 0Eh, 64h, 50h, 26h, 89h, 4Eh, 0, 0A3h, 64h, 50h, 26h, 89h, 76h, 8, 26h
	db	89h, 7Eh, 0Ah, 0A1h, 0A4h, 51h, 26h, 89h, 46h, 2, 0A1h, 70h, 51h, 26h, 89h, 46h
	db	4, 0A1h, 72h, 51h, 26h, 89h, 46h, 6, 89h, 1Eh, 0A4h, 51h, 33h, 0C0h, 0A3h, 70h
	db	51h, 0A3h, 72h, 51h, 5Eh, 0C3h, 56h, 83h, 3Eh, 0A4h, 51h, 0, 75h, 8, 0B9h, 30h
	db	0, 0E8h, 19h, 0F5h, 5Eh, 0C3h, 0F6h, 6, 0C9h, 38h, 10h, 74h, 5, 9Ah
	dd	L107EA
	db	8Bh, 0Eh, 64h, 50h, 0E3h, 71h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 0, 0A3h, 64h, 50h, 26h, 8Bh, 46h, 2, 0A3h, 0A4h, 51h, 26h, 8Bh
	db	5Eh, 8, 26h, 8Bh, 4Eh, 0Ah, 8Bh, 36h, 70h, 51h, 8Bh, 3Eh, 72h, 51h, 55h, 0E8h
	db	57h, 0Eh, 5Dh, 72h, 16h, 23h, 0C9h, 75h, 1Bh, 26h, 3, 5Eh, 4, 26h, 8Bh, 4Eh
	db	6, 73h, 20h, 41h, 74h, 5, 0E8h, 10h, 6, 75h, 18h, 53h, 51h, 0E8h, 1Fh, 6
	db	59h, 5Bh, 0EBh, 0Fh, 26h, 3, 5Eh, 4, 26h, 13h, 4Eh, 6, 72h, 0EDh, 0E8h, 0F8h
	db	5, 74h, 0E8h, 89h, 1Eh, 70h, 51h, 89h, 0Eh, 72h, 51h, 9Ah
	dd	L101F7
	db	0BAh, 1, 0, 9Ah
	dd	L1015C
	db	0EBh, 0Bh, 8Bh, 0C1h, 0A3h, 70h, 51h, 0A3h, 72h, 51h, 0A3h, 0A4h, 51h, 5Eh, 0C3h, 8Bh
	db	0D8h, 0A1h, 7Ah, 51h, 0A3h, 88h, 51h, 0A1h, 6Eh, 51h, 0A3h, 8Ah, 51h, 8Bh, 0Eh, 0B2h
	db	51h, 0E3h, 64h, 0B8h, 2, 0, 8Bh, 0C8h, 9Ah
	dd	L100B0
	db	9Ah
	dd	L101E0
	db	8Bh, 0Eh, 66h, 50h, 26h, 89h, 4Eh, 0, 0A3h, 66h, 50h, 0A1h, 0B2h, 51h, 26h, 89h
	db	46h, 2, 0A1h, 78h, 51h, 26h, 89h, 46h, 4, 0A0h, 0BAh, 51h, 26h, 88h, 46h, 0Fh
	db	32h, 0E4h, 56h, 0BEh, 8Ch, 51h, 8Bh, 0FDh, 83h, 0C7h, 10h, 8Bh, 0C8h, 0F3h, 0A5h, 5Eh
	db	0A1h, 0A0h, 51h, 26h, 89h, 46h, 6, 0A1h, 0A2h, 51h, 26h, 89h, 46h, 8, 0A1h, 9Ch
	db	51h, 26h, 89h, 46h, 0Ah, 0A1h, 9Eh, 51h, 26h, 89h, 46h, 0Ch, 0A0h, 0BFh, 51h, 26h
	db	88h, 46h, 0Eh, 0EBh, 5, 53h, 0E8h, 1Dh, 1, 5Bh, 33h, 0C0h, 0A2h, 0BAh, 51h, 0A3h
	db	9Ch, 51h, 0A3h, 9Eh, 51h, 0A3h, 0A0h, 51h, 0A3h, 0A2h, 51h, 0A0h, 87h, 51h, 24h, 30h
	db	0Ah, 6, 0C0h, 51h, 0A2h, 0BFh, 51h, 80h, 0Eh, 86h, 51h, 20h, 8Bh, 0C3h, 0A3h, 0B2h
	db	51h, 80h, 26h, 86h, 51h, 0EFh, 0E8h, 0CBh, 0C5h, 75h, 5, 80h, 0Eh, 86h, 51h, 10h
	db	0A3h, 78h, 51h, 0F6h, 6, 0C9h, 38h, 1, 75h, 8, 0F7h, 6, 0B6h, 38h, 0, 40h
	db	75h, 1, 0C3h, 0F6h, 6, 0C9h, 38h, 2, 75h, 0F8h, 56h, 6, 55h, 0A1h, 0A4h, 51h
	db	8Bh, 1Eh, 70h, 51h, 8Bh, 16h, 72h, 51h, 9Ah
	dd	L12D4B
	db	5Dh, 7, 5Eh, 0C3h
L04189:	call	L0423E	;@04189
	push	si	;@0418C
	call	L04294	;@0418D
	pop	si	;@04190
	mov	cx, word ptr ds:[5066h]	;@04191
	jcxz	@@1	;@04195
	jmp	short @@2	;@04197
@@1:	db	0E9h, 7Ch, 0	; jmp near ptr @@4	;@04199
@@2:	push	cx	;@0419C
	mov	ax, cx	;@0419D
	call	far ptr L101E0	;@0419F
	mov	ax, word ptr es:[bp]	;@041A4
	mov	word ptr ds:[5066h], ax	;@041A8
	mov	ax, word ptr es:[bp+2]	;@041AB
	mov	word ptr ds:[51B2h], ax	;@041AF
	and	byte ptr ds:[5186h], 0EFh	;@041B2
	and	ax, ax	;@041B7
	je	@@3	;@041B9
	call	L0071C	;@041BB
	jne	@@3	;@041BE
	or	byte ptr ds:[5186h], 10h	;@041C0
@@3:	mov	ax, word ptr es:[bp+4]	;@041C5
	mov	word ptr ds:[5178h], ax	;@041C9
	mov	al, byte ptr es:[bp+0Fh]	;@041CC
	mov	byte ptr ds:[51BAh], al	;@041D0
	xor	ah, ah	;@041D3
	push	si	;@041D5
	push	es	;@041D6
	pop	ds	;@041D7
	push	ss	;@041D8
	pop	es	;@041D9
	mov	si, bp	;@041DA
	add	si, 10h	;@041DC
	mov	di, 518Ch	;@041DF
	mov	cx, ax	;@041E2
	rep movsw	;@041E4
	push	ds	;@041E6
	pop	es	;@041E7
	push	ss	;@041E8
	pop	ds	;@041E9
	pop	si	;@041EA
	mov	ax, word ptr es:[bp+6]	;@041EB
	mov	word ptr ds:[51A0h], ax	;@041EF
	mov	ax, word ptr es:[bp+8]	;@041F2
	mov	word ptr ds:[51A2h], ax	;@041F6
	mov	ax, word ptr es:[bp+0Ah]	;@041F9
	mov	word ptr ds:[519Ch], ax	;@041FD
	mov	ax, word ptr es:[bp+0Ch]	;@04200
	mov	word ptr ds:[519Eh], ax	;@04204
	mov	al, byte ptr es:[bp+0Eh]	;@04207
	mov	byte ptr ds:[51BFh], al	;@0420B
	pop	ax	;@0420E
	mov	dx, 2	;@0420F
	call	far ptr L1015C	;@04212
	ret	;@04217
@@4:	xor	ax, ax	;@04218
	mov	word ptr ds:[51B2h], ax	;@0421A
	mov	byte ptr ds:[51BAh], al	;@0421D
	mov	word ptr ds:[519Ch], ax	;@04220
	mov	word ptr ds:[519Eh], ax	;@04223
	mov	word ptr ds:[51A0h], ax	;@04226
	mov	word ptr ds:[51A2h], ax	;@04229
	mov	al, byte ptr ds:[5187h]	;@0422C
	and	al, 30h	;@0422F
	or	al, byte ptr ds:[51C0h]	;@04231
	mov	byte ptr ds:[51BFh], al	;@04235
	and	byte ptr ds:[5186h], 0CFh	;@04238
	ret	;@0423D
L0423E:	cmp	word ptr ds:[5178h], 0	;@0423E
	je	@@3	;@04243
	test	word ptr ds:[38B6h], 4000h	;@04245
	je	@@3	;@0424B
	test	byte ptr ds:[38C9h], 3	;@0424D
	jne	@@3	;@04252
	push	si	;@04254
	push	es	;@04255
	push	bp	;@04256
	mov	ax, word ptr ds:[5178h]	;@04257
	call	far ptr L101E0	;@0425A
	call	L0144B	;@0425F
	cmp	ax, word ptr ds:[517Eh]	;@04262
	je	@@1	;@04266
	call	far ptr L101E0	;@04268
	push	es	;@0426D
	push	bp	;@0426E
	call	L016B5	;@0426F
	pop	bp	;@04272
	pop	es	;@04273
	push	ax	;@04274
	call	L016D9	;@04275
	mov	bx, ax	;@04278
	pop	ax	;@0427A
	jmp	short @@2	;@0427B
@@1:	mov	bx, word ptr ds:[5170h]	;@0427D
	mov	dx, word ptr ds:[5172h]	;@04281
@@2:	call	far ptr L12D60	;@04285
	pop	bp	;@0428A
	pop	es	;@0428B
	pop	si	;@0428C
@@3:	mov	word ptr ds:[5178h], 0	;@0428D
	ret	;@04293
L04294:	test	byte ptr ds:[38C9h], 10h	;@04294
	je	@@1	;@04299
	call	L0463A	;@0429B
@@1:	test	byte ptr ds:[38C9h], 3	;@0429E
	jne	@@2	;@042A3
	mov	ax, word ptr ds:[51B2h]	;@042A5
	and	ax, ax	;@042A8
	je	@@2	;@042AA
	call	far ptr L101E0	;@042AC
	call	L004F3	;@042B1
	mov	bl, al	;@042B4
	mov	ax, di	;@042B6
	test	byte ptr ds:[51BFh], 10h	;@042B8
	jne	@@3	;@042BD
	jmp	short @@4	;@042BF
@@2:	ret	;@042C1
@@3:	mov	cx, word ptr ds:[519Ch]	;@042C2
	or	cx, word ptr ds:[519Eh]	;@042C6
	or	cx, word ptr ds:[51A0h]	;@042CA
	or	cx, word ptr ds:[51A2h]	;@042CE
	je	@@4	;@042D2
	call	L0055C	;@042D4
	jmp	short @@5	;@042D7
@@4:	call	L00532	;@042D9
@@5:	push	bx	;@042DC
	push	bp	;@042DD
	call	L013B3	;@042DE
	pop	bp	;@042E1
	pop	bx	;@042E2
	jmp	L03819	;@042E3
	db	0F6h, 6, 0C9h, 38h, 1, 75h, 0Ch, 56h, 9Ah	;@042E6
	dd	L10375
	db	9Ah
	dd	L12EBE
	db	5Eh, 0C3h, 8Bh, 0Eh, 0A4h, 51h, 0E3h, 61h, 0F6h, 6, 0C9h, 38h, 1, 75h, 22h, 83h
	db	3Eh, 0B0h, 51h, 0, 75h, 1Bh, 56h, 50h, 52h, 8Bh, 0D8h, 8Bh, 0C1h, 9Ah
	dd	L13031
	db	5Ah, 58h, 5Eh, 0F6h, 6, 0C9h, 38h, 0Ah, 75h, 5, 80h, 0Eh, 0CAh, 38h, 9, 56h
	db	8Bh, 36h, 70h, 51h, 8Bh, 3Eh, 72h, 51h, 0A3h, 70h, 51h, 89h, 16h, 72h, 51h, 23h
	db	0D2h, 74h, 11h, 8Bh, 0D8h, 0E8h, 35h, 3, 8Bh, 0C3h, 75h, 8, 52h, 0B9h, 5Eh, 0
	db	0E8h, 0DFh, 0F1h, 5Ah, 0F6h, 6, 0C9h, 38h, 1, 75h, 0Ah, 8Bh, 0D8h, 0A1h, 0A4h, 51h
	db	9Ah
	dd	L13002
	db	5Eh, 0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 1, 0C3h, 0B9h, 30h, 0, 0E9h, 0BCh
	db	0F1h, 8Bh, 0D8h, 8Bh, 0Eh, 7Eh, 51h, 0E3h, 32h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 0E8h, 47h, 0D3h, 0B8h, 1, 0, 8Bh, 0C8h, 9Ah
	dd	L100B0
	db	9Ah
	dd	L101E0
	db	8Bh, 0Eh, 62h, 50h, 26h, 89h, 4Eh, 0, 0A3h, 62h, 50h, 0A1h, 7Eh, 51h, 26h, 89h
	db	46h, 2, 89h, 1Eh, 7Eh, 51h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 21h, 0D3h, 0A3h, 70h, 51h, 89h, 16h, 72h, 51h, 0E8h, 0F3h, 0D2h, 0A3h, 0A4h, 51h
	db	0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 0E9h, 6Ah, 2
L043D0:	mov	cx, word ptr ds:[517Eh]	;@043D0
	jcxz	@@1	;@043D4
	jmp	short @@2	;@043D6
@@1:	db	0E9h, 7Bh, 0	; jmp near ptr @@5	;@043D8
@@2:	mov	ax, word ptr ds:[517Eh]	;@043DB
	call	far ptr L101E0	;@043DE
	mov	ax, word ptr ds:[5170h]	;@043E3
	mov	dx, word ptr ds:[5172h]	;@043E6
	call	L016D0	;@043EA
	test	byte ptr ds:[38C9h], 10h	;@043ED
	je	@@3	;@043F2
	call	L0463A	;@043F4
@@3:	mov	cx, word ptr ds:[51A4h]	;@043F7
	jcxz	@@7	;@043FB
	test	byte ptr ds:[38C9h], 1	;@043FD
	jne	@@4	;@04402
	push	si	;@04404
	mov	bx, word ptr ds:[5170h]	;@04405
	mov	dx, word ptr ds:[5172h]	;@04409
	mov	ax, cx	;@0440D
	mov	si, bx	;@0440F
	mov	di, dx	;@04411
	call	far ptr L13002	;@04413
	pop	si	;@04418
@@4:	mov	cx, word ptr ds:[5062h]	;@04419
	jcxz	@@6	;@0441D
	mov	ax, cx	;@0441F
	call	far ptr L101E0	;@04421
	mov	ax, word ptr es:[bp]	;@04426
	mov	word ptr ds:[5062h], ax	;@0442A
	mov	ax, word ptr es:[bp+2]	;@0442D
	mov	word ptr ds:[517Eh], ax	;@04431
	mov	ax, cx	;@04434
	mov	dx, 1	;@04436
	call	far ptr L1015C	;@04439
	mov	ax, word ptr ds:[517Eh]	;@0443E
	call	far ptr L101E0	;@04441
	call	L016D9	;@04446
	mov	word ptr ds:[5170h], ax	;@04449
	mov	word ptr ds:[5172h], dx	;@0444C
	call	L016B5	;@04450
	mov	word ptr ds:[51A4h], ax	;@04453
@@5:	ret	;@04456
@@6:	mov	ax, cx	;@04457
	mov	word ptr ds:[51A4h], ax	;@04459
	mov	word ptr ds:[517Eh], ax	;@0445C
	mov	word ptr ds:[5170h], ax	;@0445F
	mov	word ptr ds:[5172h], ax	;@04462
	ret	;@04465
@@7:	mov	cx, 30h	;@04466
	jmp	L0352C	;@04469
	db	8Bh, 1Eh, 6Ah, 50h, 88h, 87h, 6Ch, 50h, 0FFh, 6, 6Ah, 50h, 0F6h, 6, 0C9h, 38h	;@0446C
	db	10h, 75h, 1, 0C3h, 6, 55h, 56h, 51h, 8Ah, 87h, 6Ch, 50h, 0C6h, 6, 6Ch, 51h
	db	0, 9Ah
	dd	L10727
	db	59h, 5Eh, 5Dh, 7, 0C3h, 8Bh, 1Eh, 6Ah, 50h, 88h, 87h, 6Ch, 50h, 0FFh, 6, 6Ah
	db	50h, 0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 6, 55h, 56h, 51h, 8Ah, 87h, 6Ch
	db	50h, 0C6h, 6, 6Ch, 51h, 0, 9Ah
	dd	L1075B
	db	59h, 5Eh, 5Dh, 7, 0C3h, 8Bh, 1Eh, 6Ah, 50h, 88h, 87h, 6Ch, 50h, 0FFh, 6, 6Ah
	db	50h, 0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 6, 55h, 56h, 51h, 8Ah, 87h, 6Ch
	db	50h, 0C6h, 6, 6Ch, 51h, 0, 9Ah
	dd	L10741
	db	59h, 5Eh, 5Dh, 7, 0C3h, 90h
L044EE:	mov	bx, word ptr ds:[506Ah]	;@044EE
	mov	byte ptr [bx+506Ch], al	;@044F2
	inc	word ptr ds:[506Ah]	;@044F6
	test	byte ptr ds:[38C9h], 10h	;@044FA
	jne	@@1	;@044FF
	ret	;@04501
@@1:	push	ax	;@04502
	mov	ax, 1	;@04503
	call	L04658	;@04506
	pop	ax	;@04509
	ret	;@0450A
	db	90h, 8Bh, 1Eh, 6Ah, 50h, 89h, 87h, 6Ch, 50h, 83h, 6, 6Ah, 50h, 2, 0F6h, 6	;@0450B
	db	0C9h, 38h, 10h, 75h, 1, 0C3h, 0B8h, 2, 0, 0E9h, 31h, 1, 90h, 8Bh, 1Eh, 6Ah
	db	50h, 89h, 87h, 6Ch, 50h, 89h, 8Fh, 6Eh, 50h, 83h, 6, 6Ah, 50h, 4, 0F6h, 6
	db	0C9h, 38h, 10h, 75h, 1, 0C3h, 0B8h, 4, 0, 0E9h, 11h, 1, 8Bh, 1Eh, 6Ah, 50h
	db	89h, 87h, 6Ch, 50h, 89h, 8Fh, 6Eh, 50h, 89h, 0BFh, 70h, 50h, 83h, 6, 6Ah, 50h
	db	6, 0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 0B8h, 6, 0, 0E9h, 0EEh, 0, 6
	db	16h, 7, 0BFh, 6Ch, 50h, 3, 3Eh, 6Ah, 50h, 1, 0Eh, 6Ah, 50h, 8Bh, 0C1h, 56h
	db	8Bh, 0F3h, 0F3h, 0A4h, 5Eh, 7, 0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h, 8Bh, 0DFh
	db	2Bh, 0D8h, 0E9h, 0CCh, 0, 6, 16h, 7, 0BFh, 6Ch, 50h, 3, 3Eh, 6Ah, 50h, 1
	db	0Eh, 6Ah, 50h, 89h, 5, 89h, 5Dh, 2, 8Bh, 0D1h, 83h, 0C7h, 4, 83h, 0E9h, 4
	db	74h, 5, 8Ah, 0C6h, 0AAh, 0E2h, 0FDh, 7, 0F6h, 6, 0C9h, 38h, 10h, 75h, 1, 0C3h
	db	8Bh, 0C2h, 8Bh, 0DFh, 2Bh, 0D8h, 0E9h, 98h, 0, 6, 16h, 7, 0BFh, 6Ch, 50h, 3
	db	3Eh, 6Ah, 50h, 1, 0Eh, 6Ah, 50h, 8Bh, 0D1h, 0AAh, 0E2h, 0FDh, 7, 0F6h, 6, 0C9h
	db	38h, 10h, 75h, 1, 0C3h, 8Bh, 0C2h, 8Bh, 0DFh, 2Bh, 0D8h, 0EBh, 74h, 8Bh, 0C8h, 8Bh
	db	1Eh, 70h, 51h, 8Bh, 16h, 72h, 51h, 0A1h, 0A4h, 51h, 23h, 0C0h, 75h, 6, 0B9h, 30h
	db	0, 0E9h, 2Dh, 0EFh, 51h, 56h, 0F6h, 6, 0C9h, 38h, 10h, 74h, 17h, 50h, 53h, 51h
	db	52h, 9Ah
	dd	L10715
	db	0E8h, 26h, 0, 5Ah, 59h, 5Bh, 58h, 0F6h, 6, 0C9h, 38h, 1, 75h, 5, 9Ah
	dd	L131EB
	db	5Eh, 59h, 1, 0Eh, 70h, 51h, 72h, 1, 0C3h, 0FFh, 6, 72h, 51h, 74h, 5, 0E8h
	db	41h, 0, 75h, 0F4h, 0EBh, 53h
L0463A:	call	L04677	;@0463A
	mov	cx, 2	;@0463D
	je	@@1	;@04640
	shl	cx, 1	;@04642
@@1:	mov	ax, word ptr ds:[5170h]	;@04644
	mov	dx, word ptr ds:[5172h]	;@04647
	push	si	;@0464B
	call	far ptr L1068C	;@0464C
	mov	byte ptr ds:[51BBh], 0FFh	;@04651
	pop	si	;@04656
	ret	;@04657
L04658:	add	bx, 506Ch	;@04658
	push	es	;@0465C
	push	bp	;@0465D
	push	si	;@0465E
	push	cx	;@0465F
	mov	cx, ax	;@04660
	mov	si, bx	;@04662
	mov	dl, byte ptr ds:[516Ch]	;@04664
	mov	byte ptr ds:[516Ch], 0	;@04668
	call	far ptr L106E7	;@0466D
	pop	cx	;@04672
	pop	si	;@04673
	pop	bp	;@04674
	pop	es	;@04675
	ret	;@04676
L04677:	cmp	word ptr ds:[51B0h], 0	;@04677
	jne	@@2	;@0467C
	mov	ax, word ptr ds:[517Eh]	;@0467E
	and	ax, ax	;@04681
	je	@@1	;@04683
	jmp	L007A0	;@04685
@@1:	xor	al, al	;@04688
	dec	al	;@0468A
@@2:	ret	;@0468C
L0468D:	test	word ptr ds:[5182h], 800h	;@0468D
	je	@@1	;@04693
	mov	cx, 805Eh	;@04695
	jmp	L0352C	;@04698
@@1:	ret	;@0469B
L0469C:	xor	ax, ax	;@0469C
	mov	word ptr ds:[52C8h], ax	;@0469E
	mov	word ptr ds:[52D2h], 52C8h	;@046A1
	mov	word ptr ds:[52D4h], ds	;@046A7
	mov	word ptr ds:[52D6h], ax	;@046AB
	mov	word ptr ds:[52CCh], ax	;@046AE
	ret	;@046B1
L046B2:	mov	dx, word ptr ds:[52CCh]	;@046B2
	and	dx, dx	;@046B6
	je	@@1	;@046B8
	mov	word ptr ds:[52CCh], 0	;@046BA
	mov	ax, word ptr ds:[52CAh]	;@046C0
	call	far ptr L1015C	;@046C3
	clc	;@046C8
	ret	;@046C9
@@1:	stc	;@046CA
	ret	;@046CB
L046CC:	call	L04B59	;@046CC
	jb	@@1	;@046CF
	call	L04A92	;@046D1
	jmp	short @@2	;@046D4
@@1:	call	L04AC0	;@046D6
@@2:	mov	ax, bp	;@046D9
	add	ax, 0	;@046DB
	mov	word ptr ds:[52D2h], ax	;@046DE
	mov	word ptr ds:[52D4h], es	;@046E1
	ret	;@046E5
L046E6:	cmp	word ptr ds:[52C8h], 0	;@046E6
	je	@@2	;@046EB
	mov	word ptr ds:[52CEh], si	;@046ED
	mov	word ptr ds:[52D0h], 4731h	;@046F1
	call	L04A6E	;@046F7
	mov	cx, word ptr ds:[52C8h]	;@046FA
@@1:	jcxz	@@2	;@046FE
	mov	ax, cx	;@04700
	call	far ptr L101E0	;@04702
	call	L0494D	;@04707
	push	es	;@0470A
	push	bp	;@0470B
	mov	cx, word ptr es:[bp+4]	;@0470C
	mov	dl, ch	;@04710
	and	cx, 1FFFh	;@04712
	and	dl, 40h	;@04716
	mov	ax, word ptr es:[bp+2]	;@04719
	call	L032A3	;@0471D
	mov	si, bx	;@04720
	call	word ptr ds:[52CEh]	;@04722
	pop	bp	;@04726
	pop	es	;@04727
	call	L049D4	;@04728
	mov	cx, word ptr es:[bp]	;@0472B
	jmp	@@1	;@0472F
@@2:	ret	;@04731
L04732:	mov	word ptr ds:[52CEh], si	;@04732
	mov	word ptr ds:[52D0h], di	;@04736
	xor	ax, ax	;@0473A
	mov	cx, ax	;@0473C
	mov	di, ax	;@0473E
	call	far ptr L11E63	;@04740
	call	L04A6E	;@04745
	xor	ax, ax	;@04748
	mov	word ptr ds:[52D6h], ax	;@0474A
	mov	word ptr ds:[52D2h], 52C8h	;@0474D
	mov	word ptr ds:[52D4h], ds	;@04753
@@1:	call	L028AC	;@04757
@@2:	les	bx, dword ptr ds:[52D2h]	;@0475A
	mov	cx, word ptr es:[bx]	;@0475E
	jcxz	@@3	;@04761
	mov	ax, cx	;@04763
	call	far ptr L101E0	;@04765
	mov	ax, word ptr ds:[516Eh]	;@0476A
	mov	dx, word ptr ds:[517Ah]	;@0476D
	test	byte ptr es:[bp+5], 80h	;@04771
	je	@@8	;@04776
	mov	cx, word ptr es:[bp+6]	;@04778
	mov	di, word ptr ds:[52D8h]	;@0477C
	call	far ptr L11EA6	;@04780
	je	@@10	;@04785
	jb	@@3	;@04787
	mov	dx, 1	;@04789
	jmp	short @@9	;@0478C
@@3:	mov	byte ptr ds:[38CAh], 0	;@0478E
	mov	ax, word ptr ds:[5170h]	;@04793
	mov	word ptr ds:[5174h], ax	;@04796
	mov	ax, word ptr ds:[5172h]	;@04799
	mov	word ptr ds:[5176h], ax	;@0479C
	mov	ax, word ptr ds:[51B6h]	;@0479F
	mov	word ptr ds:[5184h], ax	;@047A2
	call	word ptr ds:[52CEh]	;@047A5
	test	byte ptr ds:[38CAh], 1	;@047A9
	je	@@6	;@047AE
	call	L04B59	;@047B0
	jb	@@4	;@047B3
	call	L04A92	;@047B5
	jmp	short @@5	;@047B8
@@4:	call	L04AC0	;@047BA
@@5:	mov	ax, bp	;@047BD
	add	ax, 0	;@047BF
	mov	word ptr ds:[52D2h], ax	;@047C2
	mov	word ptr ds:[52D4h], es	;@047C5
@@6:	call	word ptr ds:[52D0h]	;@047C9
	je	@@1	;@047CD
@@7:	jmp	L03750	;@047CF
@@8:	mov	cx, word ptr es:[bp+6]	;@047D2
	mov	di, word ptr es:[bp+12h]	;@047D6
	mov	word ptr ds:[52D8h], di	;@047DA
	call	far ptr L11EA6	;@047DE
	je	@@10	;@047E3
	jb	@@3	;@047E5
	mov	dx, 2	;@047E7
@@9:	call	L04B89	;@047EA
	jmp	@@2	;@047ED
@@10:	mov	byte ptr ds:[38CAh], 1	;@047F0
	mov	ax, word ptr ds:[5170h]	;@047F5
	mov	word ptr ds:[5174h], ax	;@047F8
	push	ax	;@047FB
	mov	ax, word ptr ds:[5172h]	;@047FC
	mov	word ptr ds:[5176h], ax	;@047FF
	push	ax	;@04802
	mov	ax, word ptr ds:[51B6h]	;@04803
	mov	word ptr ds:[5184h], ax	;@04806
	push	es	;@04809
	push	bp	;@0480A
	call	word ptr ds:[52CEh]	;@0480B
	pop	bp	;@0480F
	pop	es	;@04810
	test	byte ptr es:[bp+5], 20h	;@04811
	jne	@@12	;@04816
	pop	word ptr ds:[5172h]	;@04818
	pop	word ptr ds:[5170h]	;@0481C
	test	byte ptr es:[bp+5], 80h	;@04820
	je	@@14	;@04825
	mov	ax, word ptr es:[bp+0Ch]	;@04827
	add	word ptr ds:[5170h], ax	;@0482B
	adc	word ptr ds:[5172h], 0	;@0482F
@@11:	push	es	;@04834
	push	bp	;@04835
	call	L04B59	;@04836
	pop	bp	;@04839
	pop	es	;@0483A
	jb	@@13	;@0483B
	mov	word ptr es:[bp+0Ch], dx	;@0483D
	mov	ax, word ptr ds:[5174h]	;@04841
	mov	word ptr es:[bp+8], ax	;@04844
	mov	ax, word ptr ds:[5176h]	;@04848
	mov	word ptr es:[bp+0Ah], ax	;@0484B
	mov	ax, word ptr ds:[5178h]	;@0484F
	mov	word ptr es:[bp+0Eh], ax	;@04852
	jmp	short @@16	;@04856
@@12:	pop	ax	;@04858
	pop	ax	;@04859
	test	byte ptr es:[bp+5], 80h	;@0485A
	jne	@@11	;@0485F
	jmp	short @@15	;@04861
@@13:	call	L04B89	;@04863
	call	L04AC0	;@04866
	jmp	short @@16	;@04869
@@14:	mov	ax, word ptr es:[bp+8]	;@0486B
	sub	ax, word ptr es:[bp+0Ch]	;@0486F
	mov	cx, word ptr es:[bp+0Ah]	;@04873
	sbb	cx, word ptr es:[bp+0Eh]	;@04877
	add	word ptr ds:[5170h], ax	;@0487B
	adc	word ptr ds:[5172h], cx	;@0487F
@@15:	mov	cx, 0Dh	;@04883
	mov	di, bp	;@04886
	add	di, 6	;@04888
	mov	si, 516Eh	;@0488B
	rep movsw	;@0488E
	call	far ptr L101F7	;@04890
	mov	word ptr ds:[52D6h], ax	;@04895
@@16:	mov	byte ptr ds:[38CAh], 0	;@04898
	push	es	;@0489D
	push	bp	;@0489E
	call	L03AFC	;@0489F
	call	word ptr ds:[52D0h]	;@048A2
	pop	bp	;@048A6
	pop	es	;@048A7
	jne	@@17	;@048A8
	mov	ax, bp	;@048AA
	add	ax, 0	;@048AC
	mov	word ptr ds:[52D2h], ax	;@048AF
	mov	word ptr ds:[52D4h], es	;@048B2
	jmp	@@1	;@048B6
@@17:	jmp	@@7	;@048B9
L048BC:	mov	word ptr ds:[52CEh], si	;@048BC
	mov	word ptr ds:[52D0h], di	;@048C0
	xor	ax, ax	;@048C4
	mov	cx, ax	;@048C6
	mov	di, ax	;@048C8
	call	far ptr L11E63	;@048CA
	call	L04A6E	;@048CF
	mov	ax, word ptr ds:[52C8h]	;@048D2
	mov	word ptr ds:[52D2h], ax	;@048D5
@@1:	call	L028AC	;@048D8
	mov	cx, word ptr ds:[52D2h]	;@048DB
	jcxz	@@4	;@048DF
	mov	ax, cx	;@048E1
	call	far ptr L101E0	;@048E3
	mov	ax, word ptr ds:[516Eh]	;@048E8
	test	byte ptr es:[bp+5], 80h	;@048EB
	je	@@2	;@048F0
	cmp	ax, word ptr es:[bp+6]	;@048F2
	jne	@@4	;@048F6
	mov	ax, word ptr ds:[517Ah]	;@048F8
	cmp	ax, word ptr ds:[52D8h]	;@048FB
	jne	@@4	;@048FF
	jmp	short @@3	;@04901
@@2:	cmp	ax, word ptr es:[bp+6]	;@04903
	jne	@@4	;@04907
	mov	ax, word ptr ds:[517Ah]	;@04909
	cmp	ax, word ptr es:[bp+12h]	;@0490C
	jne	@@4	;@04910
	mov	word ptr ds:[52D8h], ax	;@04912
@@3:	push	word ptr ds:[5170h]	;@04915
	push	word ptr ds:[5172h]	;@04919
	push	si	;@0491D
	call	L0494D	;@0491E
	pop	si	;@04921
	pop	word ptr ds:[5172h]	;@04922
	pop	word ptr ds:[5170h]	;@04926
	push	es	;@0492A
	push	bp	;@0492B
	call	word ptr ds:[52CEh]	;@0492C
	pop	bp	;@04930
	pop	es	;@04931
	call	L049D4	;@04932
	mov	ax, word ptr es:[bp]	;@04935
	mov	word ptr ds:[52D2h], ax	;@04939
	je	@@1	;@0493C
	jmp	short @@5	;@0493E
@@4:	call	word ptr ds:[52CEh]	;@04940
	call	word ptr ds:[52D0h]	;@04944
	je	@@1	;@04948
@@5:	jmp	L03750	;@0494A
L0494D:	mov	bx, si	;@0494D
	test	byte ptr es:[bp+5], 80h	;@0494F
	je	@@1	;@04954
	mov	ax, word ptr es:[bp+0Eh]	;@04956
	mov	word ptr ds:[5178h], ax	;@0495A
	mov	ax, word ptr es:[bp+6]	;@0495D
	mov	word ptr ds:[516Eh], ax	;@04961
	mov	ax, word ptr es:[bp+8]	;@04964
	mov	cx, word ptr es:[bp+0Ah]	;@04968
	mov	word ptr ds:[5170h], ax	;@0496C
	mov	word ptr ds:[5172h], cx	;@0496F
	mov	word ptr ds:[5174h], ax	;@04973
	mov	word ptr ds:[5176h], cx	;@04976
	add	ax, word ptr es:[bp+0Ch]	;@0497A
	adc	cx, 0	;@0497E
	mov	word ptr ds:[52DAh], ax	;@04981
	mov	word ptr ds:[52DCh], cx	;@04984
	ret	;@04988
@@1:	push	es	;@04989
	pop	ds	;@0498A
	push	ss	;@0498B
	pop	es	;@0498C
	mov	si, bp	;@0498D
	add	si, 6	;@0498F
	mov	di, 516Eh	;@04992
	mov	cx, 0Dh	;@04995
	rep movsw	;@04998
	push	ds	;@0499A
	push	bp	;@0499B
	push	ss	;@0499C
	pop	ds	;@0499D
	call	L0F969	;@0499E
	mov	ax, word ptr ds:[517Eh]	;@049A1
	and	ax, ax	;@049A4
	je	@@2	;@049A6
	call	far ptr L101E0	;@049A8
	call	L01B43	;@049AD
@@2:	pop	bp	;@049B0
	pop	es	;@049B1
	mov	word ptr ds:[51A4h], ax	;@049B2
	mov	ax, word ptr ds:[5170h]	;@049B5
	mov	word ptr ds:[52DAh], ax	;@049B8
	mov	ax, word ptr ds:[5172h]	;@049BB
	mov	word ptr ds:[52DCh], ax	;@049BE
	mov	ax, word ptr ds:[5174h]	;@049C1
	mov	word ptr ds:[5170h], ax	;@049C4
	mov	ax, word ptr ds:[5176h]	;@049C7
	mov	word ptr ds:[5172h], ax	;@049CA
	mov	ax, word ptr ds:[5184h]	;@049CD
	mov	word ptr ds:[51B6h], ax	;@049D0
	ret	;@049D3
L049D4:	mov	ax, word ptr ds:[52DAh]	;@049D4
	mov	dx, word ptr ds:[52DCh]	;@049D7
	mov	bx, ax	;@049DB
	mov	cx, dx	;@049DD
	sub	ax, word ptr ds:[5170h]	;@049DF
	sbb	dx, word ptr ds:[5172h]	;@049E3
	jb	@@6	;@049E7
	and	ax, ax	;@049E9
	je	@@5	;@049EB
	cmp	word ptr ds:[38B8h], 0	;@049ED
	je	@@2	;@049F2
	test	byte ptr ds:[38C9h], 8	;@049F4
	jne	@@1	;@049F9
	call	@@8	;@049FB
	jmp	short @@3	;@049FE
@@1:	push	ax	;@04A00
	call	L0FE07	;@04A01
	pop	ax	;@04A04
	jne	@@5	;@04A05
@@2:	test	word ptr ds:[5182h], 8	;@04A07
	je	@@3	;@04A0D
	mov	cx, 805Fh	;@04A0F
	call	L0352C	;@04A12
@@3:	mov	cx, ax	;@04A15
	push	es	;@04A17
	push	bp	;@04A18
	call	L039F0	;@04A19
@@4:	mov	al, 90h	;@04A1C
	call	L044EE	;@04A1E
	loop	@@4	;@04A21
	call	L03A2A	;@04A23
	pop	bp	;@04A26
	pop	es	;@04A27
@@5:	push	es	;@04A28
	push	bp	;@04A29
	call	word ptr ds:[52D0h]	;@04A2A
	pop	bp	;@04A2E
	pop	es	;@04A2F
	ret	;@04A30
@@6:	mov	word ptr ds:[5170h], bx	;@04A31
	mov	word ptr ds:[5172h], cx	;@04A35
	cmp	word ptr ds:[38B8h], 0	;@04A39
	je	@@7	;@04A3E
	test	byte ptr ds:[38C9h], 8	;@04A40
	jne	@@7	;@04A45
	call	@@8	;@04A47
	jmp	@@5	;@04A4A
@@7:	mov	cx, 32h	;@04A4C
	call	L0352C	;@04A4F
	jmp	@@5	;@04A52
@@8:	mov	byte ptr ds:[38CFh], 0FFh	;@04A54
	test	byte ptr es:[bp+5], 80h	;@04A59
	je	@@9	;@04A5E
	sub	word ptr es:[bp+0Ch], ax	;@04A60
	ret	;@04A64
@@9:	sub	word ptr es:[bp+8], ax	;@04A65
	sbb	word ptr es:[bp+0Ah], dx	;@04A69
	ret	;@04A6D
L04A6E:	push	word ptr ds:[51B8h]	;@04A6E
	call	L036FE	;@04A72
	call	L03674	;@04A75
	pop	word ptr ds:[51B8h]	;@04A78
	mov	ax, word ptr ds:[38BCh]	;@04A7C
	mov	word ptr ds:[517Ch], ax	;@04A7F
	call	L0F969	;@04A82
	mov	ax, word ptr ds:[38BEh]	;@04A85
	mov	word ptr ds:[5182h], ax	;@04A88
	mov	ax, word ptr ds:[38C0h]	;@04A8B
	mov	word ptr ds:[51B4h], ax	;@04A8E
	ret	;@04A91
L04A92:	mov	bp, 1	;@04A92
	push	dx	;@04A95
	call	L04ADC	;@04A96
	pop	dx	;@04A99
	or	byte ptr es:[bp+5], 80h	;@04A9A
	mov	word ptr es:[bp+0Ch], dx	;@04A9F
	mov	ax, word ptr ds:[5174h]	;@04AA3
	mov	word ptr es:[bp+8], ax	;@04AA6
	mov	ax, word ptr ds:[5176h]	;@04AAA
	mov	word ptr es:[bp+0Ah], ax	;@04AAD
	mov	ax, word ptr ds:[516Eh]	;@04AB1
	mov	word ptr es:[bp+6], ax	;@04AB4
	mov	ax, word ptr ds:[5178h]	;@04AB8
	mov	word ptr es:[bp+0Eh], ax	;@04ABB
	ret	;@04ABF
L04AC0:	mov	bp, 2	;@04AC0
	call	L04ADC	;@04AC3
	mov	cx, 0Dh	;@04AC6
	mov	di, bp	;@04AC9
	add	di, 6	;@04ACB
	mov	si, 516Eh	;@04ACE
	rep movsw	;@04AD1
	call	far ptr L101F7	;@04AD3
	mov	word ptr ds:[52D6h], ax	;@04AD8
	ret	;@04ADB
L04ADC:	cmp	word ptr ds:[52CCh], bp	;@04ADC
	jae	@@2	;@04AE0
	mov	dx, word ptr ds:[52CCh]	;@04AE2
	and	dx, dx	;@04AE6
	je	@@1	;@04AE8
	mov	ax, word ptr ds:[52CAh]	;@04AEA
	call	far ptr L1015C	;@04AED
	mov	word ptr ds:[52CCh], 0	;@04AF2
@@1:	mov	cx, 100h	;@04AF8
	mov	ax, bp	;@04AFB
	call	far ptr L100B0	;@04AFD
	mov	word ptr ds:[52CCh], cx	;@04B02
	mov	word ptr ds:[52CAh], ax	;@04B06
@@2:	push	bp	;@04B09
	mov	ax, word ptr ds:[52CAh]	;@04B0A
	call	far ptr L101E0	;@04B0D
	mov	bx, bp	;@04B12
	pop	bp	;@04B14
	add	word ptr ds:[52CAh], bp	;@04B15
	sub	word ptr ds:[52CCh], bp	;@04B19
	test	byte ptr ds:[38CAh], 2	;@04B1D
	mov	ax, 4000h	;@04B22
	jne	@@3	;@04B25
	xor	ax, ax	;@04B27
@@3:	push	ax	;@04B29
	push	es	;@04B2A
	push	bx	;@04B2B
	call	L03273	;@04B2C
	pop	bp	;@04B2F
	pop	es	;@04B30
	mov	word ptr es:[bp+2], ax	;@04B31
	pop	ax	;@04B35
	test	byte ptr ds:[38CAh], 8	;@04B36
	je	@@4	;@04B3B
	or	ah, 20h	;@04B3D
@@4:	or	ax, cx	;@04B40
	mov	word ptr es:[bp+4], ax	;@04B42
	call	far ptr L101F7	;@04B46
	push	es	;@04B4B
	les	bx, dword ptr ds:[52D2h]	;@04B4C
	xchg	word ptr es:[bx], ax	;@04B50
	pop	es	;@04B53
	mov	word ptr es:[bp], ax	;@04B54
	ret	;@04B58
L04B59:	mov	cx, word ptr ds:[52D6h]	;@04B59
	jcxz	@@1	;@04B5D
	mov	ax, cx	;@04B5F
	call	far ptr L101E0	;@04B61
	mov	si, 517Ah	;@04B66
	mov	cx, 7	;@04B69
	mov	di, bp	;@04B6C
	add	di, 12h	;@04B6E
	repe cmpsw	;@04B71
	jne	@@1	;@04B73
	mov	dx, word ptr ds:[5170h]	;@04B75
	sub	dx, word ptr ds:[5174h]	;@04B79
	mov	ax, word ptr ds:[5172h]	;@04B7D
	sbb	ax, word ptr ds:[5176h]	;@04B80
	jne	@@1	;@04B84
	ret	;@04B86
@@1:	stc	;@04B87
	ret	;@04B88
L04B89:	mov	ax, word ptr es:[bp]	;@04B89
	push	es	;@04B8D
	push	bp	;@04B8E
	les	bx, dword ptr ds:[52D2h]	;@04B8F
	xchg	word ptr es:[bx], ax	;@04B93
	pop	bp	;@04B96
	pop	es	;@04B97
	push	ax	;@04B98
	push	dx	;@04B99
	mov	ax, word ptr es:[bp+2]	;@04B9A
	mov	dx, word ptr es:[bp+4]	;@04B9E
	and	dx, 1FFFh	;@04BA2
	call	far ptr L102C9	;@04BA6
	pop	dx	;@04BAB
	pop	ax	;@04BAC
	call	far ptr L1015C	;@04BAD
	ret	;@04BB2
	db	0	;@04BB3
L04BB4:	mov	ax, 3500h	;@04BB4
	int	21h	;@04BB7
	mov	word ptr ds:[55DEh], bx	;@04BB9
	mov	word ptr ds:[55E0h], es	;@04BBD
	push	ds	;@04BC1
	push	cs	;@04BC2
	pop	ds	;@04BC3
	mov	dx, 5693h	;@04BC4
	mov	ax, 2500h	;@04BC7
	int	21h	;@04BCA
	pop	ds	;@04BCC
	ret	;@04BCD
L04BCE:	push	ds	;@04BCE
	mov	dx, word ptr ds:[55DEh]	;@04BCF
	mov	ds, word ptr ds:[55E0h]	;@04BD3
	mov	ax, 2500h	;@04BD7
	int	21h	;@04BDA
	pop	ds	;@04BDC
	ret	;@04BDD
	db	88h, 26h, 0EDh, 55h, 0BAh, 5, 0, 26h, 8Ah, 5, '<0r', 4, '<:r'	;@04BDE
	db	5, 0E8h, 38h, 6, 0EBh, 4Ah, 3, 0F9h, 26h, 8Ah, 45h, 0FFh, 2Bh
	db	0F9h, 'I<Bu', 5, 0E8h, 88h, 4, 0EBh, '8<Qt', 4, '<Ou', 5, 0E8h
	db	48h, 4, 0EBh, '+<Du', 5, 0E8h, 0BAh, 3, 0EBh, '"<Hu', 5, 0E8h
	db	6Dh, 3, 0EBh, 19h, '<Ru', 7, 0B3h, 14h, 0E8h, 55h, 3, 0EBh, 0Eh
	db	41h, 0E8h, 0, 8, 75h, 5, 0E8h, 0E4h, 4, 0EBh, 3, 0E8h, 0E3h, 3
	db	0BBh, 0DEh, 53h, 0C3h, 88h, 26h, 0EDh, 55h, 0BAh, 4, 0, 26h, 8Ah
	db	5, '<0r', 4, '<:r', 5, 0E8h, 0D3h, 5, 0EBh, 45h, 3, 0F9h, 26h
	db	8Ah, 45h, 0FFh, 2Bh, 0F9h, 'I<Bu', 5, 0E8h, 23h, 4, 0EBh, '3<Qt'
	db	4, '<Ou', 5, 0E8h, 0E3h, 3, 0EBh, '&<Du', 5, 0E8h, 55h, 3, 0EBh
	db	1Dh, '<Hu', 5, 0E8h, 8, 3, 0EBh, 14h, '<Ru', 7, 0B3h, 10h, 0E8h
	db	0F0h, 2, 0EBh, 9, 41h, 0E8h, 9Bh, 7, 75h, 0E1h, 0E8h, 17h, 4, 0BBh
	db	0DEh, 53h, 0C3h, 88h, 26h, 0EDh, 55h, 0BAh, 3, 0, 26h, 8Ah, 5
	db	'<0r', 4, '<:r', 5, 0E8h, 73h, 5, 0EBh, 34h, 3, 0F9h, 26h, 8Ah
	db	45h, 0FFh, 2Bh, 0F9h, 'I<Bu', 5, 0E8h, 0C3h, 3, 0EBh, '"<Qt', 4
	db	'<Ou', 5, 0E8h, 83h, 3, 0EBh, 15h, '<Du', 5, 0E8h, 0F5h, 2, 0EBh
	db	0Ch, '<Hu', 5, 0E8h, 0A8h, 2, 0EBh, 3, 41h, 0EBh, 0EFh, 0BBh, 0DEh
	db	53h, 0C3h, 88h, 26h, 0EDh, 55h, 26h, 8Ah, 5, '<0r', 4, '<:r', 5
	db	0E8h, 89h, 6, 0EBh, 43h, 3, 0F9h, 26h, 8Ah, 45h, 0FFh, 2Bh, 0F9h
	db	'I<Bu', 5, 0E8h, 54h, 6, 0EBh, '1<Qt', 4, '<Ou', 5, 0E8h, 18h
	db	6, 0EBh, '$<Du', 5, 0E8h, 81h, 5, 0EBh, 1Bh, '<Hu', 5, 0E8h, 37h
	db	5, 0EBh, 12h, '<Ru', 5, 0E8h, 1Fh, 5, 0EBh, 9, 41h, 0E8h, 0F1h
	db	6, 75h, 0E3h, 0E8h, 0ABh, 5, 0BBh, 0DEh, 53h, 0C3h, 88h, 26h, 0EDh
	db	55h, 26h, 8Ah, 5, '<0r', 4, '<:r', 5, 0E8h, 2Eh, 6, 0EBh, 3, 0E8h
	db	0CDh, 1, 0BBh, 0DEh, 53h, 0C3h, 88h, 26h, 0EDh, 55h, 26h, 8Ah
	db	5, '<0r', 4, '<:r', 0Ah, 0E8h, 6Ch, 6, 83h, 0F9h, 1, 74h, 8, 0EBh
	db	1Bh, 0E8h, 0ADh, 1, 0B9h, 1, 0, 0A0h, 0E2h, 53h, 98h, 3Bh, 6, 0E0h
	db	53h, 75h, 6, 3Ah, 6, 0DFh, 53h, 74h, 5, 51h, 0E8h, 0A3h, 6, 59h
	db	0BBh, 0DEh, 53h, 0C3h, 8Bh, 0C3h, 81h, 0C3h, 0DEh, 54h, 3, 0C1h
	db	3Dh, 0, 1, 72h, 0Ah, 53h, 0B9h, 7Bh, 0, 0E8h, 78h, 0E7h, 5Bh, 0EBh
	db	0Bh, 0E3h, 9, 26h, 8Ah, 5, 88h, 7, 43h, 47h, 0E2h, 0F7h, 8Bh, 0CBh
	db	0BBh, 0DEh, 54h, 2Bh, 0CBh, 0C3h, 22h, 0FFh, 74h, 1Ah, 0F7h, 0D0h
	db	0F7h, 0D2h, 5, 1, 0, 83h, 0D2h, 0, 22h, 0DBh, 74h, 1Ah, 0F7h, 0D1h
	db	0F7h, 0D7h, 83h, 0C1h, 1, 83h, 0D7h, 0, 0EBh, 17h, 22h, 0DBh, 74h
	db	13h, 0F7h, 0D1h, 0F7h, 0D7h, 83h, 0C1h, 1, 83h, 0D7h, 0, 0E8h
	db	6, 0, 53h, 0E8h, 17h, 7, 5Bh, 0C3h, 0E8h, 70h, 8, 0A3h, 0DEh, 53h
	db	33h, 0D2h, 89h, 16h, 0E0h, 53h, 88h, 16h, 0E2h, 53h, 0BBh, 0DEh
	db	53h, 0C3h, 22h, 0FFh, 74h, 1Ah, 0F7h, 0D0h, 0F7h, 0D2h, 5, 1, 0
	db	83h, 0D2h, 0, 22h, 0DBh, 74h, 1Ah, 0F7h, 0D1h, 0F7h, 0D7h, 83h
	db	0C1h, 1, 83h, 0D7h, 0, 0EBh, 17h, 22h, 0DBh, 74h, 13h, 0F7h, 0D1h
	db	0F7h, 0D7h, 83h, 0C1h, 1, 83h, 0D7h, 0, 0E8h, 6, 0, 53h, 0E8h
	db	0CEh, 6, 5Bh, 0C3h, 0E8h, 27h, 8, 8Bh, 0C2h, 0A3h, 0DEh, 53h, 33h
	db	0D2h, 89h, 16h, 0E0h, 53h, 88h, 16h, 0E2h, 53h, 0BBh, 0DEh, 53h
	db	0C3h, 22h, 0FFh, 74h, 1Ah, 0F7h, 0D0h, 0F7h, 0D2h, 5, 1, 0, 83h
	db	0D2h, 0, 22h, 0DBh, 74h, 1Ah, 0F7h, 0D1h, 0F7h, 0D7h, 83h, 0C1h
	db	1, 83h, 0D7h, 0, 0EBh, 17h, 22h, 0DBh, 74h, 13h, 0F7h, 0D1h, 0F7h
	db	0D7h, 83h, 0C1h, 1, 83h, 0D7h, 0, 0E8h, 6, 0, 53h, 0E8h, 83h, 6
	db	5Bh, 0C3h, 56h, 8Bh, 0F1h, 8Bh, 0D8h, 8Bh, 0CAh, 0E8h, 5Ch, 0
	db	73h, 3, 0E8h, 9Ch, 5, 0BBh, 0DEh, 53h, 5Eh, 0C3h
L04EA7:	call	@@2	;@04EA7
	jb	@@1	;@04EAA
	mov	bx, word ptr ds:[53DEh]	;@04EAC
	mov	cx, word ptr ds:[53E0h]	;@04EB0
	ret	;@04EB4
@@1:	xor	bx, bx	;@04EB5
	xor	cx, cx	;@04EB7
	stc	;@04EB9
	ret	;@04EBA
	db	50h, 8Ah, 0C4h, 0E8h, 1, 0, 58h, 8Ah, 0E0h, 0B1h, 4, 0D2h, 0E8h, 0E8h, 4, 0	;@04EBB
	db	8Ah, 0C4h, 24h, 0Fh, 3Ch, 0Ah, 73h, 4, 4, 30h, 0AAh, 0C3h, 4, 37h, 0AAh, 0C3h
	db	6, 57h, 9Ah
	dd	L101E0
	db	0E8h, 0ECh, 0B5h, 6, 1Fh, 8Bh, 0F7h, 5Fh, 7, 0F3h, 0A4h, 16h, 1Fh, 0C3h, 0ACh, 22h
	db	0C0h, 74h, 3, 0AAh, 0EBh, 0F8h, 0C3h
@@2:	mov	ax, bx	;@04EF9
	mul	si	;@04EFB
	mov	word ptr ds:[53DEh], ax	;@04EFD
	mov	word ptr ds:[53E0h], dx	;@04F00
	mov	byte ptr ds:[53E2h], 0	;@04F04
	jcxz	@@4	;@04F09
	and	di, di	;@04F0B
	je	@@5	;@04F0D
@@3:	stc	;@04F0F
	ret	;@04F10
@@4:	mov	ax, bx	;@04F11
	mul	di	;@04F13
	add	word ptr ds:[53E0h], ax	;@04F15
	adc	dx, 0	;@04F19
	and	dx, dx	;@04F1C
	jne	@@3	;@04F1E
	ret	;@04F20
@@5:	mov	ax, cx	;@04F21
	mul	si	;@04F23
	add	word ptr ds:[53E0h], ax	;@04F25
	adc	dx, 0	;@04F29
	and	dx, dx	;@04F2C
	jne	@@3	;@04F2E
	ret	;@04F30
	db	3, 0F9h, 26h, 8Ah, 45h, 0FFh, 2Bh, 0F9h, 49h, 3Ch, 42h, 75h, 5, 0E8h, 29h, 4	;@04F31
	db	0EBh, 40h, 3Ch, 51h, 74h, 4, 3Ch, 4Fh, 75h, 5, 0E8h, 0EDh, 3, 0EBh, 33h, 3Ch
	db	44h, 75h, 5, 0E8h, 56h, 3, 0EBh, 2Ah, 3Ch, 48h, 75h, 5, 0E8h, 0Ch, 3, 0EBh
	db	21h, 3Ch, 52h, 75h, 5, 0E8h, 0DDh, 4, 0EBh, 18h, 41h, 0A0h, 86h, 51h, 24h, 0Fh
	db	74h, 0E1h, 0FEh, 0C0h, 3Ch, 2, 74h, 0C5h, 3Ch, 8, 74h, 0CEh, 3Ch, 10h, 74h, 0DCh
	db	0EBh, 0D1h, 0C3h, 26h, 8Ah, 5, 3Ch, 30h, 75h, 2, 0FEh, 0C3h, 3Ah, 0CBh, 75h, 41h
	db	0BBh, 0DEh, 53h, 0E8h, 3, 5, 26h, 8Ah, 5, 2Ch, 30h, 72h, 34h, 3Ch, 0Ah, 72h
	db	0Ch, 4, 30h, 2Ch, 41h, 72h, 2Ah, 4, 0Ah, 3Ch, 10h, 73h, 24h, 0BBh, 0DEh, 53h
	db	0E8h, 18h, 5, 72h, 19h, 0E8h, 13h, 5, 72h, 14h, 0E8h, 0Eh, 5, 72h, 0Fh, 0E8h
	db	9, 5, 72h, 0Ah, 0, 6, 0DEh, 53h, 47h, 0E2h, 0CBh, 0E9h, 0ADh, 4, 0E9h, 6Fh
	db	4, 0E9h, 74h, 4, 0BBh, 0DEh, 53h, 0E8h, 0BFh, 4, 26h, 8Ah, 5, 2Ch, 30h, 72h
	db	3Dh, 3Ch, 0Ah, 73h, 39h, 50h, 0BBh, 0DEh, 53h, 0B8h, 0E2h, 55h, 0E8h, 0C7h, 4, 0E8h
	db	0D9h, 4, 72h, 26h, 0E8h, 0D4h, 4, 72h, 21h, 8Bh, 0C3h, 0BBh, 0E2h, 55h, 0E8h, 0D8h
	db	4, 72h, 17h, 0BBh, 0DEh, 53h, 0E8h, 0C2h, 4, 72h, 0Fh, 58h, 0BBh, 0DEh, 53h, 0E8h
	db	0DBh, 4, 72h, 7, 47h, 0E2h, 0C3h, 0E9h, 61h, 4, 58h, 0E9h, 22h, 4, 0E9h, 27h
	db	4, 0BBh, 0DEh, 53h, 0E8h, 72h, 4, 26h, 8Ah, 5, 2Ch, 30h, 72h, 28h, 3Ch, 0Ah
	db	73h, 24h, 0BBh, 0DEh, 53h, 0E8h, 93h, 4, 72h, 19h, 0E8h, 8Eh, 4, 72h, 14h, 0E8h
	db	89h, 4, 72h, 0Fh, 0E8h, 84h, 4, 72h, 0Ah, 0, 6, 0DEh, 53h, 47h, 0E2h, 0D7h
	db	0E9h, 15h, 4, 0E9h, 0EAh, 3, 0E9h, 0EFh, 3, 0BBh, 0DEh, 53h, 0E8h, 3Ah, 4, 26h
	db	8Ah, 5, 2Ch, 30h, 72h, 23h, 3Ch, 8, 73h, 1Fh, 0BBh, 0DEh, 53h, 0E8h, 5Bh, 4
	db	72h, 14h, 0E8h, 56h, 4, 72h, 0Fh, 0E8h, 51h, 4, 72h, 0Ah, 0, 6, 0DEh, 53h
	db	47h, 0E2h, 0DCh, 0E9h, 0F5h, 3, 0E9h, 0B7h, 3, 0E9h, 0BCh, 3, 0BBh, 0DEh, 53h, 0E8h
	db	7, 4, 26h, 8Ah, 5, 2Ch, 30h, 72h, 19h, 3Ch, 2, 73h, 15h, 0BBh, 0DEh, 53h
	db	0E8h, 28h, 4, 72h, 0Ah, 0, 6, 0DEh, 53h, 47h, 0E2h, 0E6h, 0E9h, 0CCh, 3, 0E9h
	db	8Eh, 3, 0E9h, 93h, 3, 0E8h, 65h, 0, 56h, 8Bh, 0F3h, 0B9h, 4, 0, 0B8h, 0
	db	2, 0E8h, 3Ah, 5, 5Eh, 8Bh, 47h, 1, 89h, 7, 8Bh, 47h, 3, 89h, 47h, 2
	db	8Bh, 47h, 5, 89h, 47h, 4, 8Ah, 47h, 7, 88h, 47h, 6, 0B9h, 3, 0, 0D0h
	db	6Fh, 6, 0D1h, 5Fh, 4, 0D1h, 5Fh, 2, 0D1h, 1Fh, 0E2h, 0F3h, 83h, 67h, 6, 0Fh
	db	8Bh, 47h, 8, 25h, 0FFh, 7Fh, 74h, 11h, 2Dh, 0FFh, 3Fh, 5, 0FFh, 3, 0F6h, 0C4h
	db	0F8h, 74h, 6, 0BAh, 8, 0, 0E9h, 37h, 3, 0D1h, 0E0h, 0D1h, 0E0h, 0D1h, 0E0h, 0D1h
	db	0E0h, 9, 47h, 6, 8Ah, 47h, 9, 24h, 80h, 8, 47h, 7, 0C3h, 0BAh, 4, 0
	db	0BBh, 0DEh, 53h, 0E8h, 73h, 3, 0C7h, 6, 0E6h, 53h, 3Eh, 40h, 33h, 0D2h, 26h, 8Ah
	db	5, 3Ch, 45h, 74h, 6Dh, 3Ch, 2Eh, 75h, 4, 0B2h, 0FFh, 0EBh, 53h, 2Ch, 30h, 72h
	db	5Eh, 3Ch, 0Ah, 73h, 5Ah, 22h, 0D2h, 74h, 4, 0FFh, 0Eh, 0E6h, 53h, 22h, 0F6h, 75h
	db	48h, 52h, 50h, 0BBh, 0DEh, 53h, 0B8h, 0E2h, 55h, 0BAh, 4, 0, 0E8h, 57h, 3, 0BBh
	db	0E2h, 55h, 0E8h, 66h, 3, 72h, 2Eh, 0E8h, 61h, 3, 72h, 29h, 8Bh, 0C3h, 0BBh, 0DEh
	db	53h, 0E8h, 65h, 3, 72h, 1Fh, 0BBh, 0E2h, 55h, 0E8h, 4Fh, 3, 72h, 17h, 58h, 50h
	db	0E8h, 6Ah, 3, 72h, 10h, 0B8h, 0DEh, 53h, 0BBh, 0E2h, 55h, 0E8h, 28h, 3, 58h, 5Ah
	db	47h, 0E2h, 9Bh, 0EBh, 5Dh, 58h, 5Ah, 0B6h, 0FFh, 0FFh, 6, 0E6h, 53h, 0EBh, 0F1h, 0E9h
	db	82h, 0, 47h, 49h, 74h, 4Ch, 26h, 8Ah, 5, 3Ch, 2Dh, 0B2h, 0FFh, 74h, 6, 32h
	db	0D2h, 3Ch, 2Bh, 75h, 4, 47h, 49h, 74h, 39h, 33h, 0DBh, 26h, 8Ah, 5, 2Ch, 30h
	db	72h, 62h, 3Ch, 0Ah, 73h, 5Eh, 8Bh, 0EBh, 0D1h, 0E3h, 72h, 52h, 0D1h, 0E3h, 72h, 4Eh
	db	3, 0DDh, 72h, 4Ah, 0D1h, 0E3h, 72h, 46h, 32h, 0E4h, 3, 0D8h, 72h, 40h, 47h, 0E2h
	db	0DAh, 22h, 0D2h, 74h, 2, 0F7h, 0DBh, 1, 1Eh, 0E6h, 53h, 0F6h, 6, 0E7h, 53h, 80h
	db	75h, 2Ch, 8Bh, 16h, 0E6h, 53h, 81h, 0EAh, 3Eh, 40h, 52h, 0BBh, 0DEh, 53h, 0E8h, 75h
	db	3, 5Ah, 72h, 1Ah, 80h, 3Eh, 0EDh, 55h, 0, 74h, 5, 80h, 0Eh, 0E7h, 53h, 80h
	db	56h, 0BBh, 0DEh, 53h, 0E8h, 18h, 3, 5Eh, 72h, 4, 0BBh, 0DEh, 53h, 0C3h, 0BAh, 5
	db	0, 0E9h, 1Ch, 2, 0BAh, 5, 0, 0E9h, 1Eh, 2, 0BBh, 0DEh, 53h, 0E8h, 69h, 2
	db	26h, 8Ah, 25h, 47h, 49h, 0E3h, 1Ah, 26h, 8Ah, 5, 47h, 49h, 3Ah, 0C4h, 75h, 4
	db	0E3h, 17h, 47h, 49h, 0BBh, 0DEh, 53h, 0E8h, 5Fh, 2, 22h, 0C0h, 74h, 0E7h, 0E9h, 0EFh
	db	1, 0B9h, 62h, 80h, 52h, 0E8h, 0D3h, 0E2h, 5Ah, 0E9h, 0Ch, 2, 0B3h, 8, 26h, 8Ah
	db	5, 3Ch, 30h, 75h, 2, 0FEh, 0C3h, 3Ah, 0CBh, 75h, 3Eh, 33h, 0D2h, 33h, 0DBh, 26h
	db	8Ah, 5, 2Ch, 30h, 72h, 33h, 3Ch, 0Ah, 72h, 0Ch, 4, 30h, 2Ch, 41h, 72h, 29h
	db	4, 0Ah, 3Ch, 10h, 73h, 23h, 0D1h, 0E3h, 0D1h, 0D2h, 72h, 1Ah, 0D1h, 0E3h, 0D1h, 0D2h
	db	72h, 14h, 0D1h, 0E3h, 0D1h, 0D2h, 72h, 0Eh, 0D1h, 0E3h, 0D1h, 0D2h, 72h, 8, 2, 0D8h
	db	47h, 0E2h, 0CCh, 0E9h, 59h, 2, 0E9h, 94h, 1, 0E9h, 99h, 1, 33h, 0DBh, 33h, 0D2h
	db	26h, 8Ah, 5, 2Ch, 30h, 72h, 39h, 3Ch, 0Ah, 73h, 35h, 0D1h, 0E3h, 0D1h, 0D2h, 72h
	db	2Ch, 89h, 1Eh, 0DEh, 53h, 89h, 16h, 0E0h, 53h, 0D1h, 0E3h, 0D1h, 0D2h, 72h, 1Eh, 0D1h
	db	0E3h, 0D1h, 0D2h, 72h, 18h, 3, 1Eh, 0DEh, 53h, 13h, 16h, 0E0h, 53h, 72h, 0Eh, 98h
	db	3, 0D8h, 83h, 0D2h, 0, 72h, 6, 47h, 0E2h, 0C6h, 0E9h, 12h, 2, 0E9h, 4Dh, 1
	db	0E9h, 52h, 1, 0E8h, 27h, 0FEh, 56h, 8Bh, 0F3h, 83h, 0C6h, 4, 0B9h, 2, 0, 0B8h
	db	80h, 0, 0E8h, 0F9h, 2, 5Eh, 8Bh, 47h, 6, 89h, 47h, 1, 8Ah, 47h, 5, 88h
	db	7, 83h, 67h, 2, 7Fh, 8Bh, 47h, 8, 25h, 0FFh, 7Fh, 74h, 0Dh, 2Dh, 0FFh, 3Fh
	db	5, 7Fh, 0, 22h, 0E4h, 74h, 3, 0E9h, 13h, 1, 0B1h, 7, 0D3h, 0E0h, 9, 47h
	db	2, 8Ah, 47h, 9, 24h, 80h, 8, 47h, 3, 0C3h, 33h, 0DBh, 33h, 0D2h, 26h, 8Ah
	db	5, 2Ch, 30h, 72h, 21h, 3Ch, 8, 73h, 1Dh, 0D1h, 0E3h, 0D1h, 0D2h, 72h, 14h, 0D1h
	db	0E3h, 0D1h, 0D2h, 72h, 0Eh, 0D1h, 0E3h, 0D1h, 0D2h, 72h, 8, 2, 0D8h, 47h, 0E2h, 0DEh
	db	0E9h, 9Ch, 1, 0E9h, 0D7h, 0, 0E9h, 0DCh, 0, 33h, 0DBh, 33h, 0D2h, 26h, 8Ah, 5
	db	2Ch, 30h, 72h, 15h, 3Ch, 2, 73h, 11h, 0D1h, 0E3h, 0D1h, 0D2h, 72h, 8, 2, 0D8h
	db	47h, 0E2h, 0EAh, 0E9h, 79h, 1, 0E9h, 0B4h, 0, 0E9h, 0B9h, 0, 33h, 0D2h, 89h, 16h
	db	0DEh, 53h, 89h, 16h, 0E0h, 53h, 88h, 16h, 0E2h, 53h, 26h, 8Ah, 25h, 47h, 49h, 0E3h
	db	28h, 26h, 8Ah, 5, 47h, 49h, 3Ah, 0C4h, 75h, 4, 0E3h, 25h, 47h, 49h, 80h, 3Eh
	db	0DFh, 53h, 0, 75h, 1Fh, 8Bh, 1Eh, 0DFh, 53h, 89h, 1Eh, 0E0h, 53h, 8Ah, 0D8h, 8Ah
	db	3Eh, 0DEh, 53h, 89h, 1Eh, 0DEh, 53h, 0EBh, 0D6h, 52h, 0B9h, 62h, 80h, 0E8h, 5Bh, 0E1h
	db	5Ah, 0E9h, 38h, 1, 0F7h, 6, 7Ch, 51h, 8, 10h, 74h, 61h, 80h, 3Eh, 0E1h, 53h
	db	0, 74h, 0D2h, 0EBh, 58h, 33h, 0D2h, 89h, 16h, 0DEh, 53h, 89h, 16h, 0E0h, 53h, 88h
	db	16h, 0E2h, 53h, 26h, 8Ah, 25h, 33h, 0DBh, 49h, 47h, 0E3h, 14h, 26h, 8Ah, 5, 47h
	db	49h, 3Ah, 0C4h, 75h, 4, 0E3h, 11h, 47h, 49h, 88h, 87h, 0DEh, 53h, 43h, 0EBh, 0EAh
	db	53h, 0B9h, 62h, 80h, 0E8h, 14h, 0E1h, 5Bh, 8Bh, 0CBh, 80h, 3Eh, 0EDh, 55h, 0, 74h
	db	12h, 83h, 0F9h, 5, 72h, 7, 0E8h, 14h, 0, 0B9h, 1, 0, 0C3h, 0E8h, 0DCh, 0
	db	0B9h, 1, 0, 0C3h, 57h, 51h, 0B0h, 2Eh, 0F2h, 0AEh, 59h, 5Fh, 0C3h, 0BAh, 2, 0
	db	0B9h, 14h, 0, 0EBh, 6, 0BAh, 2, 0, 0B9h, 4, 0, 0BBh, 0DEh, 53h, 0E8h, 48h
	db	0, 80h, 3Eh, 0CBh, 38h, 0, 75h, 0Ah, 80h, 3Eh, 0CCh, 38h, 0, 75h, 8, 0E9h
	db	0C9h, 0E0h, 0F9h, 8Bh, 26h, 0AEh, 38h, 0C3h, 80h, 3Eh, 0EDh, 55h, 0, 74h, 0Bh, 0BBh
	db	0DEh, 53h, 3, 0DAh, 3, 0DAh, 80h, 77h, 0FFh, 80h, 0C3h, 80h, 3Eh, 0EDh, 55h, 0
	db	74h, 16h, 0BBh, 0DEh, 53h, 51h, 8Bh, 0CAh, 0F9h, 8Bh, 7, 0F7h, 0D0h, 15h, 0, 0
	db	89h, 7, 83h, 0C3h, 2, 0E2h, 0F2h, 59h, 0C3h, 51h, 8Bh, 0CAh, 33h, 0C0h, 89h, 7
	db	83h, 0C3h, 2, 0E2h, 0F9h, 88h, 7, 59h, 0C3h, 51h, 8Bh, 0CAh, 86h, 7, 43h, 86h
	db	7, 43h, 0E2h, 0F8h, 59h, 0C3h, 6, 56h, 57h, 51h, 8Bh, 0F3h, 8Bh, 0F8h, 8Bh, 0CAh
	db	8Ch, 0D0h, 8Eh, 0C0h, 0F3h, 0A5h, 59h, 5Fh, 5Eh, 7, 0C3h, 51h, 53h, 8Bh, 0CAh, 0F8h
	db	0D1h, 17h, 43h, 43h, 0E2h, 0FAh, 5Bh, 59h, 0C3h, 51h, 57h, 8Bh, 0CAh, 8Bh, 0F8h, 0F8h
	db	8Bh, 7, 11h, 5, 43h, 43h, 47h, 47h, 0E2h, 0F6h, 5Fh, 59h, 0C3h, 51h, 8Bh, 0CAh
	db	98h, 0F8h, 11h, 7, 73h, 7, 43h, 43h, 0B8h, 0, 0, 0E2h, 0F5h, 59h, 0C3h, 89h
	db	1Eh, 0DEh, 53h, 89h, 16h, 0E0h, 53h, 0C6h, 6, 0E2h, 53h, 0, 80h, 3Eh, 0EDh, 55h
	db	0, 74h, 1Bh, 0F7h, 16h, 0DEh, 53h, 0F7h, 16h, 0E0h, 53h, 0F6h, 16h, 0E2h, 53h, 83h
	db	6, 0DEh, 53h, 1, 83h, 16h, 0E0h, 53h, 0, 80h, 16h, 0E2h, 53h, 0, 0C3h, 0F6h
	db	0C6h, 80h, 74h, 10h, 0F7h, 0DAh, 0BEh, 94h, 1Bh, 0B9h, 0Dh, 0, 81h, 0FAh, 0, 40h
	db	72h, 10h, 0F9h, 0C3h, 0BEh, 16h, 1Ch, 0B9h, 0Eh, 0, 81h, 0FAh, 0, 80h, 72h, 2
	db	0F9h, 0C3h, 0D1h, 0EAh, 73h, 19h, 0B8h, 0E2h, 55h, 52h, 53h, 0BAh, 5, 0, 0E8h, 55h
	db	0FFh, 5Fh, 0BBh, 0E2h, 55h, 51h, 0E8h, 30h, 0, 59h, 5Ah, 8Bh, 0DFh, 72h, 6, 83h
	db	0C6h, 0Ah, 0E2h, 0DEh, 0F8h, 0C3h, 0BAh, 4, 0, 0B9h, 40h, 0, 0F6h, 47h, 7, 80h
	db	75h, 0Fh, 0E8h, 46h, 0FFh, 0FFh, 4Fh, 8, 0E2h, 0F2h, 0C7h, 47h, 8, 0, 0, 0F8h
	db	0C3h, 0F6h, 47h, 9, 80h, 74h, 1, 0F9h, 0C3h, 53h, 56h, 57h, 0B9h, 4, 0, 0E8h
	db	7Eh, 0, 5Fh, 5Eh, 5Bh, 8Bh, 47h, 8, 25h, 0FFh, 7Fh, 8Bh, 54h, 8, 81h, 0E2h
	db	0FFh, 7Fh, 3, 0C2h, 2Dh, 0FEh, 3Fh, 53h, 56h, 57h, 50h, 8Bh, 0F7h, 0F6h, 44h, 0Fh
	db	80h, 75h, 0Eh, 8Bh, 0DEh, 83h, 0C3h, 6, 0BAh, 5, 0, 0E8h, 0FDh, 0FEh, 58h, 48h
	db	50h, 8Bh, 0C6h, 8Bh, 0DEh, 83h, 0C3h, 8, 0BAh, 4, 0, 0E8h, 0D8h, 0FEh, 58h, 5Fh
	db	5Eh, 5Bh, 89h, 45h, 8, 53h, 56h, 57h, 8Bh, 0DFh, 0E8h, 89h, 0FFh, 5Fh, 5Eh, 5Bh
	db	72h, 0Bh, 8Ah, 47h, 9, 32h, 44h, 9, 24h, 80h, 8, 45h, 9, 0C3h, 1, 4
	db	73h, 1Dh, 49h, 0E3h, 8, 83h, 0C6h, 2, 83h, 4, 1, 0EBh, 0F3h, 0D1h, 6Fh, 6
	db	0D1h, 5Fh, 4, 0D1h, 5Fh, 2, 0D1h, 1Fh, 80h, 4Fh, 7, 80h, 0FFh, 47h, 8, 0C3h
	db	8Bh, 0D1h, 57h, 33h, 0C0h, 89h, 5, 83h, 0C7h, 2, 89h, 5, 83h, 0C7h, 2, 0E2h
	db	0F4h, 5Fh, 8Bh, 0CAh, 52h, 51h, 53h, 57h, 8Bh, 0CAh, 8Bh, 4, 8Bh, 17h, 23h, 0C0h
	db	74h, 1Ah, 23h, 0D2h, 74h, 16h, 0F7h, 0E2h, 57h, 83h, 0C7h, 2, 1, 45h, 0FEh, 11h
	db	15h, 73h, 8, 83h, 0C7h, 2, 83h, 5, 1, 72h, 0F8h, 5Fh, 83h, 0C3h, 2, 83h
	db	0C7h, 2, 0E2h, 0D6h, 5Fh, 5Bh, 59h, 5Ah, 83h, 0C6h, 2, 83h, 0C7h, 2, 0E2h, 0C4h
	db	0C3h, 23h, 0FFh, 75h, 12h, 33h, 0F9h, 0C6h, 6, 0ECh, 55h, 0, 0F7h, 0F1h, 90h, 90h
	db	0D0h, 26h, 0ECh, 55h, 72h, 1, 0C3h, 33h, 0C0h, 0B9h, 76h, 0, 0E8h, 9Ch, 0DEh, 8Bh
	db	0D0h, 0C3h, 1Eh, 0B8h
	dw	SEG5
	db	8Eh, 0D8h, 0C6h, 6, 0ECh, 55h, 0FFh, 1Fh, 0FBh, 58h, 5, 2, 0, 50h, 0CFh
L056A6:	xor	ax, ax	;@056A6
	mov	word ptr ds:[5604h], ax	;@056A8
	ret	;@056AB
L056AC:	xor	ax, ax	;@056AC
	mov	word ptr ds:[5606h], ax	;@056AE
	mov	word ptr ds:[560Ah], ax	;@056B1
	mov	di, 569Ch	;@056B4
	push	ds	;@056B7
	pop	es	;@056B8
	mov	cx, 0Dh	;@056B9
	rep stosw	;@056BC
	mov	bx, 3544h	;@056BE
	mov	cx, 2Ch	;@056C1
	call	L00457	;@056C4
	mov	word ptr ds:[55FEh], ax	;@056C7
	mov	bx, 35DEh	;@056CA
	mov	cx, 0Ah	;@056CD
	call	L00457	;@056D0
	mov	word ptr ds:[5600h], ax	;@056D3
	mov	di, 560Eh	;@056D6
	mov	bx, 3544h	;@056D9
	mov	cx, 2Ch	;@056DC
	xor	al, al	;@056DF
	call	L00490	;@056E1
	mov	di, 5666h	;@056E4
	mov	bx, 3611h	;@056E7
	mov	cx, 1Bh	;@056EA
	xor	al, al	;@056ED
	call	L00490	;@056EF
	call	L075B9	;@056F2
	mov	si, 1CA8h	;@056F5
	mov	bx, 1CA2h	;@056F8
	mov	cx, 1	;@056FB
@@1:	push	cx	;@056FE
	mov	cl, byte ptr [bx]	;@056FF
	inc	bx	;@05701
	push	bx	;@05702
	xor	ch, ch	;@05703
	push	cx	;@05705
	call	L0040F	;@05706
	pop	cx	;@05709
	pop	bx	;@0570A
	add	bx, cx	;@0570B
	push	ax	;@0570D
	call	L0599C	;@0570E
	pop	dx	;@05711
	lodsb	;@05712
	cbw	;@05713
	mov	word ptr es:[bp+0Ah], ax	;@05714
	call	far ptr L101F7	;@05718
	push	ax	;@0571D
	mov	ax, dx	;@0571E
	call	far ptr L101E0	;@05720
	pop	ax	;@05725
	push	si	;@05726
	push	bx	;@05727
	call	L01ABC	;@05728
	pop	bx	;@0572B
	pop	si	;@0572C
	pop	cx	;@0572D
	loop	@@1	;@0572E
	mov	ax, word ptr ds:[5660h]	;@05730
	mov	word ptr ds:[55FCh], ax	;@05733
	ret	;@05736
L05737:	mov	dx, word ptr ds:[5604h]	;@05737
	and	dx, dx	;@0573B
	je	@@1	;@0573D
	mov	word ptr ds:[5604h], 0	;@0573F
	mov	ax, word ptr ds:[5602h]	;@05745
	call	far ptr L1015C	;@05748
	clc	;@0574D
	ret	;@0574E
@@1:	stc	;@0574F
	ret	;@05750
L05751:	mov	cx, word ptr ds:[5606h]	;@05751
	jcxz	@@1	;@05755
	mov	ax, cx	;@05757
	call	far ptr L101E0	;@05759
	mov	ax, word ptr es:[bp]	;@0575E
	and	ax, ax	;@05762
	jne	@@2	;@05764
	mov	ax, cx	;@05766
	inc	ax	;@05768
	mov	word ptr ds:[5608h], ax	;@05769
	mov	ax, word ptr es:[bp+2]	;@0576C
	dec	ax	;@05770
	mov	word ptr ds:[560Ah], ax	;@05771
@@1:	ret	;@05774
@@2:	mov	word ptr ds:[5606h], ax	;@05775
	mov	ax, cx	;@05778
	mov	dx, word ptr es:[bp+2]	;@0577A
	call	far ptr L1015C	;@0577E
	jmp	L05751	;@05783
	db	0A1h, 5Ch, 56h, 9Ah	;@05785
	dd	L101E0
	db	0E8h, 0F4h, 0C2h, 9Ah
	dd	L101E0
	db	26h, 0F6h, 46h, 4, 4, 74h, 4Ch, 26h, 8Ah, 46h, 1, 3Ch, 4, 75h, 44h, 0F7h
	db	6, 7Ch, 51h, 0, 10h, 75h, 31h, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 2Ch, 26h, 3Bh
	db	46h, 1Ah, 74h, 26h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 96h, 0BEh, 5Dh, 7, 26h, 3Bh, 46h, 1Ah, 74h, 14h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 6Bh, 0BEh, 5Dh, 7, 26h, 3Bh, 46h, 1Ah, 0EBh, 2, 32h, 0C0h, 26h, 8Bh, 46h
	db	1Ah, 26h, 8Bh, 5Eh, 16h, 0C3h, 0A1h, 7Eh, 51h, 33h, 0DBh, 0C3h
L057EE:	test	byte ptr es:[bp+5], 10h	;@057EE
	je	@@1	;@057F3
	push	es	;@057F5
	push	bp	;@057F6
	mov	ax, word ptr ds:[58BAh]	;@057F7
	call	far ptr L101E0	;@057FA
	call	L004D1	;@057FF
	call	far ptr L10782	;@05802
	mov	al, 20h	;@05807
	call	far ptr L10775	;@05809
	pop	bp	;@0580E
	pop	es	;@0580F
@@1:	test	word ptr es:[bp+4], 8080h	;@05810
	je	@@2	;@05816
	push	es	;@05818
	push	bp	;@05819
	mov	al, 5Bh	;@0581A
	call	far ptr L10775	;@0581C
	pop	bp	;@05821
	pop	es	;@05822
	call	@@2	;@05823
	push	es	;@05826
	push	bp	;@05827
	mov	al, 5Dh	;@05828
	call	far ptr L10775	;@0582A
	pop	bp	;@0582F
	pop	es	;@05830
	ret	;@05831
@@2:	mov	al, byte ptr es:[bp+1]	;@05832
	and	al, 7	;@05836
	xor	ah, ah	;@05838
	shl	ax, 1	;@0583A
	mov	bx, ax	;@0583C
	jmp	word ptr [bx+1D1Ch]	;@0583E
	db	0E8h, 9, 1, 6, 55h, 0B0h, 3Ah, 9Ah	;@05842
	dd	L10775
	db	5Dh, 7, 26h, 0F6h, 46h, 4, 40h, 74h, 20h, 0E8h, 94h, 0, 26h, 8Bh, 46h, 0Ah
	db	26h, 0Bh, 46h, 0Ch, 74h, 33h, 26h, 80h, 3Eh, 24h, 0, 0, 75h, 0Bh, 6, 55h
	db	0B0h, 2Bh, 9Ah
	dd	L10775
	db	5Dh, 7, 26h, 0F6h, 46h, 4, 1, 75h, 1Ah, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 56h
	db	0Ch, 26h, 8Ah, 4Eh, 24h, 26h, 8Ah, 6Eh, 1, 6, 55h, 9Ah
	dd	L10796
	db	5Dh, 7, 0C3h, 6, 55h, 26h, 8Bh, 46h, 8, 9Ah
	dd	L101E0
	db	0E8h, 2Bh, 0ACh, 9Ah
	dd	L10782
	db	5Dh, 7, 0C3h, 26h, 8Bh, 46h, 18h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 15h, 0ACh, 9Ah
	dd	L10782
	db	5Dh, 7, 26h, 8Bh, 46h, 0Ah, 26h, 0Bh, 46h, 0Ch, 74h, 20h, 6, 55h, 0B0h, 2Bh
	db	9Ah
	dd	L10775
	db	5Dh, 7, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 56h, 0Ch, 26h, 8Ah, 4Eh, 24h, 6, 55h
	db	9Ah
	dd	L10796
	db	5Dh, 7, 0C3h, 6, 55h, 26h, 8Bh, 46h, 0Eh, 9Ah
	dd	L101E0
	db	0E8h, 0D5h, 0ABh, 9Ah
	dd	L10782
	db	5Dh, 7, 26h, 0F6h, 46h, 4, 20h, 74h, 1Ch, 6, 55h, 0B0h, 2Ah, 9Ah
	dd	L10775
	db	5Dh, 7, 26h, 8Bh, 46h, 10h, 33h, 0D2h, 8Bh, 0CAh, 6, 55h, 9Ah
	dd	L10796
	db	5Dh, 7, 26h, 0F6h, 46h, 4, 10h, 74h, 20h, 6, 55h, 0B0h, 2Bh, 9Ah
	dd	L10775
	db	5Dh, 7, 6, 55h, 26h, 8Bh, 46h, 12h, 9Ah
	dd	L101E0
	db	0E8h, 8Bh, 0ABh, 9Ah
	dd	L10782
	db	5Dh, 7, 0C3h, 26h, 8Bh, 46h, 14h, 23h, 0C0h, 75h, 4, 26h, 8Bh, 46h, 18h, 6
	db	55h, 9Ah
	dd	L101E0
	db	0E8h, 6Dh, 0ABh, 9Ah
	dd	L10782
	db	5Dh, 7, 26h, 83h, 7Eh, 16h, 0, 74h, 1Bh, 6, 55h, 0B0h, 2Bh, 9Ah
	dd	L10775
	db	5Dh, 7, 26h, 8Bh, 46h, 16h, 99h, 8Ah, 0CAh, 6, 55h, 9Ah
	dd	L10796
	db	5Dh, 7, 0C3h, 0A1h, 5Ah, 56h, 0A3h, 0FCh, 55h, 0C3h, 0A1h, 60h, 56h, 0A3h, 0FCh, 55h
	db	0C3h
L0599C:	cmp	word ptr ds:[560Ah], 0	;@0599C
	je	@@2	;@059A1
@@1:	mov	ax, word ptr ds:[5608h]	;@059A3
	call	far ptr L101E0	;@059A6
	mov	ax, 3	;@059AB
	add	word ptr ds:[5608h], ax	;@059AE
	sub	word ptr ds:[560Ah], ax	;@059B2
	xor	ax, ax	;@059B6
	mov	di, bp	;@059B8
	mov	cx, 14h	;@059BA
	rep stosw	;@059BD
	mov	byte ptr es:[bp+10h], 1	;@059BF
	ret	;@059C4
@@2:	mov	ax, 61h	;@059C5
	mov	cx, ax	;@059C8
	call	far ptr L100B0	;@059CA
	call	far ptr L101E0	;@059CF
	mov	word ptr es:[bp+2], cx	;@059D4
	dec	cx	;@059D8
	mov	word ptr ds:[560Ah], cx	;@059D9
	mov	cx, word ptr ds:[5606h]	;@059DD
	mov	word ptr es:[bp], cx	;@059E1
	mov	word ptr ds:[5606h], ax	;@059E5
	inc	ax	;@059E8
	mov	word ptr ds:[5608h], ax	;@059E9
	jmp	@@1	;@059EC
	db	0E8h, 0ABh, 0FFh, 0E8h, 0A2h, 17h, 0E8h, 2Eh, 18h, 32h, 0C0h, 0C3h	;@059EE
	db	8Bh, 0D8h, 0E8h, 9Dh, 0FFh, 26h, 89h, 5Eh, 0Ah, 26h, 89h, 56h
	db	0Ch, 0C3h
L05A08:	mov	dx, si	;@05A08
	push	es	;@05A0A
	call	far ptr L101E0	;@05A0B
	mov	si, bp	;@05A10
	push	es	;@05A12
	pop	ds	;@05A13
	pop	es	;@05A14
	cmp	word ptr [si+6], 0	;@05A15
	jne	@@2	;@05A19
	cmp	byte ptr es:[di], 0	;@05A1B
	je	@@1	;@05A1F
	cmp	word ptr es:[di+6], 0	;@05A21
	jne	@@2	;@05A26
	cmp	word ptr [si+4], 0	;@05A28
	jne	@@3	;@05A2C
	mov	ax, word ptr [si+0Ah]	;@05A2E
	cmp	ax, word ptr es:[di+2]	;@05A31
	jne	@@3	;@05A35
	mov	ax, word ptr [si+0Ch]	;@05A37
	cmp	ax, word ptr es:[di+4]	;@05A3A
	jne	@@3	;@05A3E
	mov	al, byte ptr [si+24h]	;@05A40
	cmp	al, byte ptr es:[di+1]	;@05A43
	jmp	short @@3	;@05A47
@@1:	mov	ax, word ptr es:[di+2]	;@05A49
	call	far ptr L101E0	;@05A4D
	mov	di, bp	;@05A52
	cmp	word ptr es:[di+6], 0	;@05A54
	jne	@@2	;@05A59
	mov	cx, 28h	;@05A5B
	repe cmpsb	;@05A5E
	mov	si, dx	;@05A60
	mov	ax, ss	;@05A62
	mov	ds, ax	;@05A64
	ret	;@05A66
@@2:	xor	al, al	;@05A67
@@3:	mov	si, dx	;@05A69
	push	ss	;@05A6B
	pop	ds	;@05A6C
	ret	;@05A6D
L05A6E:	cmp	byte ptr es:[di], 0	;@05A6E
	jne	L05AD6	;@05A72
	push	ax	;@05A74
	mov	ax, word ptr es:[di+2]	;@05A75
	call	far ptr L101E0	;@05A79
	mov	di, bp	;@05A7E
	pop	ax	;@05A80
L05A81:	mov	dx, si	;@05A81
	push	es	;@05A83
	call	far ptr L101E0	;@05A84
	mov	si, bp	;@05A89
	push	es	;@05A8B
	pop	ds	;@05A8C
	pop	es	;@05A8D
	mov	cx, 14h	;@05A8E
	rep movsw	;@05A91
	mov	si, dx	;@05A93
	push	ss	;@05A95
	pop	ds	;@05A96
	ret	;@05A97
	db	26h, 80h, 3Dh, 0, 74h, 5, 26h, 8Bh, 45h, 6, 0C3h, 6, 55h, 26h, 8Bh, 45h	;@05A98
	db	2, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 6, 5Dh, 7, 0C3h, 26h, 80h, 3Dh, 0, 74h, 7, 26h, 0C7h, 45h
	db	6, 0, 0, 0C3h, 6, 55h, 26h, 8Bh, 45h, 2, 9Ah
	dd	L101E0
	db	26h, 0C7h, 46h, 6, 0, 0, 5Dh, 7, 0C3h
L05AD6:	push	es	;@05AD6
	call	far ptr L101E0	;@05AD7
	push	es	;@05ADC
	pop	ds	;@05ADD
	pop	es	;@05ADE
	cmp	word ptr ds:[bp+4], 0	;@05ADF
	jne	@@1	;@05AE4
	mov	ax, word ptr ds:[bp+6]	;@05AE6
	mov	word ptr es:[di+6], ax	;@05AEA
	mov	ax, word ptr ds:[bp+0Ah]	;@05AEE
	mov	word ptr es:[di+2], ax	;@05AF2
	mov	ax, word ptr ds:[bp+0Ch]	;@05AF6
	mov	word ptr es:[di+4], ax	;@05AFA
	mov	al, byte ptr ds:[bp+24h]	;@05AFE
	mov	byte ptr es:[di+1], al	;@05B02
	mov	byte ptr es:[di], 1	;@05B06
	push	ss	;@05B0A
	pop	ds	;@05B0B
	ret	;@05B0C
@@1:	push	ss	;@05B0D
	pop	ds	;@05B0E
	mov	dx, ax	;@05B0F
	cmp	word ptr ds:[5604h], 0	;@05B11
	jne	@@2	;@05B16
	mov	ax, 3	;@05B18
	mov	cx, 0C0h	;@05B1B
	call	far ptr L100B0	;@05B1E
	mov	word ptr ds:[5604h], cx	;@05B23
	mov	word ptr ds:[5602h], ax	;@05B27
@@2:	push	es	;@05B2A
	push	di	;@05B2B
	mov	ax, word ptr ds:[5602h]	;@05B2C
	push	ax	;@05B2F
	call	far ptr L101E0	;@05B30
	mov	di, bp	;@05B35
	mov	ax, 3	;@05B37
	add	word ptr ds:[5602h], ax	;@05B3A
	sub	word ptr ds:[5604h], ax	;@05B3E
	mov	ax, dx	;@05B42
	call	L05A81	;@05B44
	pop	ax	;@05B47
	pop	di	;@05B48
	pop	es	;@05B49
	mov	word ptr es:[di+2], ax	;@05B4A
	mov	byte ptr es:[di], 0	;@05B4E
	ret	;@05B52
L05B53:	mov	dx, si	;@05B53
	push	es	;@05B55
	push	di	;@05B56
	call	L0599C	;@05B57
	pop	si	;@05B5A
	pop	ds	;@05B5B
	cmp	byte ptr [si], 0	;@05B5C
	je	@@1	;@05B5F
	mov	ax, word ptr [si+6]	;@05B61
	mov	word ptr es:[bp+6], ax	;@05B64
	mov	ax, word ptr [si+2]	;@05B68
	mov	word ptr es:[bp+0Ah], ax	;@05B6B
	mov	ax, word ptr [si+4]	;@05B6F
	mov	word ptr es:[bp+0Ch], ax	;@05B72
	mov	al, byte ptr [si+1]	;@05B76
	mov	byte ptr es:[bp+24h], al	;@05B79
	jmp	short @@2	;@05B7D
@@1:	mov	di, bp	;@05B7F
	push	bp	;@05B81
	push	es	;@05B82
	mov	ax, word ptr [si+2]	;@05B83
	call	far ptr L101E0	;@05B86
	mov	si, bp	;@05B8B
	push	es	;@05B8D
	pop	ds	;@05B8E
	pop	es	;@05B8F
	pop	bp	;@05B90
	mov	cx, 14h	;@05B91
	rep movsw	;@05B94
@@2:	push	ss	;@05B96
	pop	ds	;@05B97
	call	far ptr L101F7	;@05B98
	mov	si, dx	;@05B9D
	ret	;@05B9F
L05BA0:	sub	ax, word ptr ds:[55FEh]	;@05BA0
	jb	@@1	;@05BA4
	cmp	ax, 58h	;@05BA6
	jae	@@1	;@05BA9
	test	word ptr ds:[517Ch], 8	;@05BAB
	jne	@@3	;@05BB1
	cmp	ax, 3Ch	;@05BB3
	jb	@@2	;@05BB6
	cmp	ax, 54h	;@05BB8
	jb	@@3	;@05BBB
@@1:	stc	;@05BBD
	ret	;@05BBE
@@2:	cmp	ax, 10h	;@05BBF
	jae	@@1	;@05BC2
@@3:	clc	;@05BC4
	ret	;@05BC5
	db	0E8h, 6Bh, 4Fh, 26h, 0F6h, 46h, 4, 0C0h, 0C3h, 26h, 83h, 7Eh, 6, 0, 75h, 1	;@05BC6
	db	0C3h, 0E9h, 1Fh, 17h, 0FFh, 0FFh, 0FEh, 0E8h, 0C5h, 14h, 0E8h, 0B3h, 15h, 0E8h, 3Fh, 16h
	db	26h, 8Ah, 5Eh, 0, 26h, 8Bh, 4Eh, 2, 80h, 0FBh, 80h, 75h, 15h, 26h, 0F6h, 46h
	db	5, 40h, 74h, 0Eh, 26h, 8Ah, 5Eh, 25h, 80h, 0E3h, 7Fh, 80h, 0CBh, 20h, 26h, 8Bh
	db	4Eh, 1Ch, 80h, 0EBh, 60h, 80h, 0FBh, 27h, 72h, 21h, 80h, 0FBh, 2Ah, 73h, 1Ch, 80h
	db	0EBh, 27h, 32h, 0FFh, 2Eh, 8Ah, 87h, 0DAh, 5Bh, 98h, 99h, 26h, 89h, 46h, 0Ah, 26h
	db	89h, 56h, 0Ch, 26h, 88h, 66h, 24h, 33h, 0C0h, 0EBh, 11h, 0E8h, 60h, 0A4h, 26h, 89h
	db	46h, 0Ah, 26h, 89h, 56h, 0Ch, 33h, 0C0h, 26h, 88h, 46h, 24h, 26h, 0C6h, 46h, 0
	db	0, 26h, 89h, 46h, 4, 26h, 89h, 46h, 2, 26h, 89h, 46h, 18h, 26h, 89h, 46h
	db	1Ah, 26h, 88h, 46h, 1, 26h, 89h, 46h, 14h, 26h, 88h, 46h, 25h, 26h, 89h, 46h
	db	1Ch, 0E9h, 46h, 14h, 26h, 80h, 4Eh, 5, 80h, 32h, 0C0h, 0C3h, 26h, 8Ah, 46h, 5
	db	0A8h, 10h, 75h, 34h, 0A8h, 20h, 75h, 48h, 26h, 8Bh, 46h, 4, 25h, 40h, 80h, 3Dh
	db	40h, 80h, 75h, 21h, 0E8h, 4Ch, 0, 26h, 0F6h, 46h, 5, 40h, 74h, 19h, 26h, 80h
	db	66h, 5, 0BFh, 26h, 8Ah, 46h, 25h, 24h, 7Fh, 26h, 88h, 46h, 0, 26h, 8Bh, 46h
	db	1Ch, 26h, 89h, 46h, 2, 32h, 0C0h, 0C3h, 0E8h, 63h, 0Dh, 33h, 0C0h, 26h, 89h, 46h
	db	1Ch, 26h, 88h, 46h, 25h, 26h, 8Bh, 46h, 4, 26h, 80h, 66h, 5, 2Fh, 0EBh, 0BCh
	db	0E8h, 0C5h, 17h, 0EBh, 0B3h, 26h, 0F6h, 46h, 5, 20h, 75h, 1, 0C3h, 0E8h, 0B8h, 17h
	db	32h, 0C0h, 0C3h, 0E8h, 0C9h, 13h, 0E8h, 0B7h, 14h, 0E8h, 43h, 15h, 0E8h, 3, 0, 0E9h
	db	0C8h, 13h, 26h, 80h, 66h, 0, 7Fh, 26h, 80h, 4Eh, 4, 80h, 26h, 8Ah, 46h, 5
	db	24h, 3, 0D0h, 0E0h, 0D0h, 0E0h, 26h, 80h, 66h, 5, 0F0h, 26h, 8, 46h, 5, 0C3h
	db	26h, 0F6h, 46h, 5, 80h, 74h, 3, 0E8h, 0C9h, 0FFh, 26h, 80h, 66h, 5, 0FCh, 26h
	db	80h, 4Eh, 5, 1, 32h, 0C0h, 0C3h, 26h, 0F6h, 46h, 5, 80h, 74h, 3, 0E8h, 0B2h
	db	0FFh, 26h, 80h, 66h, 5, 0FCh, 26h, 80h, 4Eh, 5, 2, 32h, 0C0h, 0C3h, 0E8h, 6Eh
	db	13h, 26h, 0C6h, 46h, 0, 87h, 0E9h, 71h, 13h, 0E8h, 63h, 13h, 26h, 0F6h, 46h, 0
	db	80h, 75h, 15h, 26h, 0F6h, 46h, 4, 40h, 74h, 44h, 26h, 0F6h, 46h, 5, 80h, 74h
	db	3Dh, 26h, 0F6h, 46h, 4, 4, 74h, 36h, 26h, 0F6h, 46h, 5, 40h, 74h, 2Fh, 0E8h
	db	2Eh, 14h, 0E8h, 0BAh, 14h, 26h, 0F6h, 46h, 5, 40h, 74h, 22h, 26h, 8Ah, 46h, 25h
	db	26h, 8Bh, 7Eh, 1Ch, 0E8h, 1Ah, 0, 26h, 88h, 46h, 0, 26h, 89h, 7Eh, 2, 33h
	db	0C0h, 26h, 89h, 46h, 1Ch, 26h, 88h, 46h, 25h, 26h, 80h, 66h, 5, 0BFh, 0E9h, 19h
	db	13h, 3Ch, 8Ah, 75h, 28h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 20h, 53h, 8Ah, 0D8h
	db	8Bh, 0CFh, 53h, 57h, 0E8h, 0E7h, 0A2h, 5Fh, 5Bh, 23h, 0D2h, 75h, 0Eh, 0E8h, 15h, 4Ch
	db	5Bh, 22h, 0C0h, 74h, 6, 0Ch, 80h, 33h, 0FFh, 0EBh, 2, 0B0h, 8Ah, 0C3h, 80h, 3Eh
	db	0CBh, 38h, 0, 74h, 0Eh, 0F7h, 6, 7Ch, 51h, 0, 20h, 75h, 6, 0F9h, 8Bh, 26h
	db	0AEh, 38h, 0C3h, 0E8h, 0DBh, 12h, 26h, 80h, 66h, 5, 0EFh, 26h, 0F6h, 46h, 0, 80h
	db	75h, 37h, 0E8h, 6Ah, 16h, 0C4h, 2Eh, 0F6h, 55h, 26h, 8Bh, 4Eh, 4, 81h, 0E1h, 40h
	db	80h, 83h, 0F9h, 40h, 74h, 20h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Bh, 46h, 0Ah, 0E8h, 0C4h
	db	4Bh, 0Ch, 80h, 0C4h, 2Eh, 0F6h, 55h, 26h, 80h, 4Eh, 5, 40h, 26h, 88h, 46h, 25h
	db	26h, 0C7h, 46h, 1Ch, 0, 0, 0E9h, 0CFh, 12h, 26h, 0F6h, 46h, 5, 20h, 74h, 2Fh
	db	26h, 8Ah, 46h, 0, 3Ch, 87h, 72h, 27h, 3Ch, 8Ah, 73h, 23h, 0C4h, 2Eh, 0EEh, 55h
	db	26h, 0F7h, 46h, 0Ah, 0, 80h, 0C4h, 2Eh, 0F6h, 55h, 75h, 13h, 26h, 80h, 66h, 5
	db	0DFh, 33h, 0C0h, 26h, 89h, 46h, 22h, 26h, 89h, 46h, 1Eh, 26h, 89h, 46h, 20h, 0E8h
	db	0FDh, 15h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Bh, 46h, 0Ah, 0E8h, 68h, 4Bh, 0Ch, 80h, 0C4h
	db	2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 33h, 0C0h, 26h, 88h, 46h, 25h, 26h, 89h, 46h
	db	1Ch, 26h, 89h, 46h, 2, 26h, 80h, 66h, 5, 0BFh, 0C4h, 2Eh, 0EEh, 55h, 26h, 0F6h
	db	46h, 0, 80h, 75h, 3, 0E9h, 60h, 12h, 26h, 8Bh, 46h, 14h, 26h, 8Bh, 4Eh, 18h
	db	0C4h, 2Eh, 0F6h, 55h, 26h, 89h, 46h, 14h, 26h, 89h, 4Eh, 18h, 0E9h, 49h, 12h, 0E8h
	db	0Fh, 12h, 0E8h, 0EBh, 12h, 0E8h, 77h, 13h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 0
	db	26h, 8Bh, 4Eh, 2, 0C4h, 2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 26h, 89h, 4Eh, 2
	db	33h, 0C0h, 26h, 88h, 46h, 25h, 26h, 89h, 46h, 1Ch, 0E9h, 1Bh, 12h, 0E8h, 0E1h, 11h
	db	0E8h, 0FBh, 12h, 0E8h, 49h, 13h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0F1h, 12h, 0C4h, 2Eh, 0EEh
	db	55h, 26h, 8Ah, 5Eh, 0, 80h, 0EBh, 80h, 26h, 8Bh, 4Eh, 2, 0E8h, 9Fh, 0A1h, 50h
	db	52h, 0C4h, 2Eh, 0F6h, 55h, 26h, 8Ah, 5Eh, 0, 80h, 0EBh, 80h, 26h, 8Bh, 4Eh, 2
	db	0E8h, 8Bh, 0A1h, 59h, 5Bh, 2Bh, 0C3h, 1Bh, 0D1h, 72h, 10h, 26h, 1, 46h, 0Ah, 26h
	db	11h, 56h, 0Ch, 26h, 80h, 56h, 24h, 0, 0E8h, 0F6h, 4Bh, 0EBh, 8Bh, 0E8h, 91h, 11h
	db	0E8h, 0ABh, 12h, 0E8h, 0F9h, 12h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0A1h, 12h, 0E9h, 78h, 0FFh
	db	0B3h, 80h, 0EBh, 39h, 0B3h, 81h, 0EBh, 35h, 0F6h, 6, 87h, 51h, 2, 75h, 0Dh, 0EBh
	db	7, 0F6h, 6, 87h, 51h, 8, 75h, 4, 0B3h, 82h, 0EBh, 21h, 0B3h, 83h, 0EBh, 1Dh
	db	0B3h, 84h, 0EBh, 19h, 0B3h, 85h, 0EBh, 15h, 0B3h, 86h, 0EBh, 11h, 0B3h, 87h, 0EBh, 0Dh
	db	0F6h, 6, 87h, 51h, 2, 75h, 4, 0B3h, 88h, 0EBh, 2, 0B3h, 89h, 0E8h, 26h, 0FAh
	db	26h, 88h, 5Eh, 0, 32h, 0C0h, 0C3h, 50h, 0E8h, 1Bh, 0FAh, 58h, 26h, 0C6h, 46h, 0
	db	8Ah, 26h, 89h, 46h, 2, 8Bh, 0D8h, 0E8h, 0AFh, 0D9h, 32h, 0C0h, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 5Dh, 0ADh, 53h, 0E8h, 0FDh, 0F9h, 5Bh, 80h, 0EBh, 0A0h, 26h, 88h, 5Eh, 0, 32h
	db	0C0h, 0C3h, 8Bh, 0D8h, 0E8h, 0EDh, 0F9h, 26h, 89h, 5Eh, 6, 0F6h, 6, 0C9h, 38h, 0Bh
	db	75h, 5, 80h, 0Eh, 0CAh, 38h, 1, 32h, 0C0h, 0C3h, 0A3h, 0F2h, 55h, 0E8h, 0DDh, 10h
	db	0E8h, 0ECh, 11h, 0E8h, 57h, 12h, 26h, 80h, 7Eh, 0, 8Ah, 75h, 2Bh, 26h, 8Bh, 46h
	db	2, 9Ah
	dd	L101E0
	db	0A1h, 0F2h, 55h, 0E8h, 99h, 0AEh, 74h, 1Dh, 0C4h, 2Eh, 0EEh, 55h, 80h, 0EBh, 0A0h, 26h
	db	88h, 5Eh, 0, 26h, 89h, 4Eh, 2, 26h, 1, 46h, 0Ah, 26h, 11h, 56h, 0Ch, 0E8h
	db	17h, 4Bh, 0E9h, 0ADh, 10h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Bh, 46h, 2, 26h, 89h, 46h
	db	6, 0E8h, 0E7h, 12h, 0E9h, 9Bh, 10h, 80h, 3Eh, 0CBh, 38h, 0, 74h, 0Eh, 0F7h, 6
	db	7Ch, 51h, 0, 20h, 75h, 6, 0F9h, 8Bh, 26h, 0AEh, 38h, 0C3h, 0E8h, 8Ah, 10h, 26h
	db	0F6h, 46h, 5, 10h, 74h, 8, 0E8h, 0DDh, 9, 26h, 80h, 66h, 5, 0EFh, 0C4h, 2Eh
	db	0EEh, 55h, 0E8h, 0AEh, 11h, 0E8h, 75h, 12h, 0C4h, 2Eh, 0F6h, 55h, 26h, 0F6h, 46h, 0
	db	80h, 75h, 2Fh, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 27h, 26h, 0F6h, 46h, 4, 4
	db	75h, 20h, 0E8h, 1Dh, 0, 26h, 80h, 66h, 4, 0FBh, 26h, 80h, 66h, 0, 7Fh, 33h
	db	0C0h, 26h, 89h, 46h, 14h, 26h, 89h, 46h, 18h, 26h, 89h, 46h, 1Ah, 26h, 88h, 46h
	db	1, 0C3h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 4, 0A8h, 4, 74h, 0Eh, 0A8h, 40h
	db	75h, 27h, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 4, 75h, 1Dh, 0C4h, 2Eh, 0F6h, 55h
	db	26h, 0F6h, 46h, 4, 4, 74h, 18h, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 4, 72h
	db	0Eh, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 31h, 0B9h, 69h, 0, 0E8h, 0DBh, 49h, 0C4h
	db	2Eh, 0F6h, 55h, 0E8h, 0D2h, 10h, 0C4h, 2Eh, 0EEh, 55h, 26h, 0F6h, 46h, 4, 40h, 74h
	db	1Ch, 26h, 8Bh, 46h, 0Eh, 0E8h, 0A9h, 0A7h, 74h, 1Fh, 0C4h, 2Eh, 0F6h, 55h, 26h, 0C7h
	db	46h, 14h, 0, 0, 0B9h, 1Fh, 0, 0E8h, 71h, 14h, 0E9h, 3, 10h, 0C4h, 2Eh, 0F6h
	db	55h, 26h, 0C7h, 46h, 14h, 0, 0, 0EBh, 75h, 0C4h, 2Eh, 0F6h, 55h, 26h, 89h, 46h
	db	14h, 26h, 89h, 46h, 1Eh, 9Ah
	dd	L101E0
	db	0E8h, 79h, 0B9h, 9Ah
	dd	L101E0
	db	8Bh, 0FDh, 6, 1Fh, 36h, 0C4h, 2Eh, 0EEh, 55h, 8Bh, 45h, 6, 26h, 89h, 46h, 6
	db	23h, 0C0h, 74h, 9, 1Eh, 57h, 16h, 1Fh, 0E8h, 0CEh, 11h, 5Fh, 1Fh, 8Bh, 45h, 0Ah
	db	26h, 1, 46h, 0Ah, 8Bh, 45h, 0Ch, 26h, 11h, 46h, 0Ch, 8Ah, 45h, 24h, 26h, 10h
	db	46h, 24h, 8Ah, 45h, 4, 24h, 4, 26h, 8, 46h, 4, 8Ah, 45h, 1, 26h, 88h
	db	46h, 1, 8Bh, 45h, 26h, 26h, 89h, 46h, 26h, 8Bh, 45h, 18h, 26h, 89h, 46h, 18h
	db	8Bh, 45h, 1Ah, 26h, 89h, 46h, 1Ah, 16h, 1Fh, 0E8h, 0ABh, 49h, 8Bh, 3Eh, 0EEh, 55h
	db	0A1h, 0F0h, 55h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 5Eh, 13h, 0E8h, 71h, 48h, 0E9h, 6Eh, 0Fh
	db	0E8h, 22h, 0Fh, 26h, 0FFh, 76h, 6, 0E8h, 10h, 0, 26h, 8Fh, 46h, 6, 0E9h, 1Fh
	db	0Fh, 0E8h, 11h, 0Fh, 0E8h, 3, 0, 0E9h, 16h, 0Fh, 32h, 0C9h, 26h, 83h, 7Eh, 6
	db	0, 75h, 77h, 26h, 0F6h, 46h, 4, 4, 74h, 0Ch, 26h, 8Bh, 46h, 1Ah, 0E8h, 0C9h
	db	0A5h, 74h, 3, 80h, 0C9h, 80h, 26h, 8Ah, 46h, 0, 0A8h, 80h, 74h, 2Fh, 3Ch, 87h
	db	72h, 13h, 3Ch, 8Ah, 73h, 0Fh, 26h, 0F6h, 46h, 5, 10h, 74h, 3, 80h, 0C9h, 4
	db	80h, 0C9h, 21h, 0EBh, 45h, 26h, 0F6h, 46h, 4, 40h, 75h, 1Bh, 26h, 0F6h, 46h, 5
	db	10h, 75h, 5, 80h, 0C9h, 2Ah, 0EBh, 32h, 80h, 0C9h, 26h, 0EBh, 2Dh, 26h, 8Ah, 46h
	db	1, 24h, 7, 3Ch, 4, 75h, 5, 80h, 0C9h, 20h, 0EBh, 1Eh, 26h, 0F6h, 46h, 4
	db	40h, 75h, 0Ch, 26h, 0F6h, 46h, 4, 4, 75h, 10h, 80h, 0C9h, 24h, 0EBh, 0Bh, 26h
	db	0F7h, 46h, 4, 80h, 80h, 75h, 0E0h, 80h, 0C9h, 30h, 51h, 0E8h, 98h, 0F7h, 59h, 26h
	db	88h, 4Eh, 0Ah, 0E9h, 8Ah, 0Eh, 0E8h, 0CCh, 0Eh, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Bh, 46h
	db	0Ah, 26h, 8Bh, 5Eh, 0Ch, 26h, 8Ah, 56h, 24h, 0C4h, 2Eh, 0F6h, 55h, 26h, 9, 46h
	db	0Ah, 26h, 9, 5Eh, 0Ch, 26h, 8, 56h, 24h, 0E9h, 9Fh, 0Eh, 0E8h, 0A6h, 0Eh, 0C4h
	db	2Eh, 0EEh, 55h, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 5Eh, 0Ch, 26h, 8Ah, 56h, 24h, 0C4h
	db	2Eh, 0F6h, 55h, 26h, 31h, 46h, 0Ah, 26h, 31h, 5Eh, 0Ch, 26h, 30h, 56h, 24h, 0E9h
	db	79h, 0Eh, 0E8h, 80h, 0Eh, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 5Eh
	db	0Ch, 26h, 8Ah, 56h, 24h, 0C4h, 2Eh, 0F6h, 55h, 26h, 21h, 46h, 0Ah, 26h, 21h, 5Eh
	db	0Ch, 26h, 20h, 56h, 24h, 0E9h, 53h, 0Eh, 0E8h, 0Ah, 0Eh, 0E8h, 53h, 0Fh, 0E8h, 9Dh
	db	32h, 0E8h, 13h, 3Bh, 26h, 0F7h, 56h, 0Ah, 26h, 0F7h, 56h, 0Ch, 26h, 0F6h, 56h, 24h
	db	0E9h, 0FDh, 0Dh, 0E8h, 0B3h, 1, 0E8h, 76h, 0Eh, 0E8h, 72h, 0, 0B8h, 0FFh, 0FFh, 74h
	db	2, 33h, 0C0h, 0EBh, 5Ah, 0E8h, 0A1h, 1, 0E8h, 64h, 0Eh, 0E8h, 60h, 0, 0B8h, 0FFh
	db	0FFh, 75h, 2, 33h, 0C0h, 0EBh, 48h, 0E8h, 8Fh, 1, 0E8h, 42h, 0Eh, 0E8h, 4Eh, 0
	db	0B8h, 0FFh, 0FFh, 72h, 2, 33h, 0C0h, 0EBh, 36h, 0E8h, 7Dh, 1, 0E8h, 40h, 0Eh, 0E8h
	db	3Ch, 0, 0B8h, 0FFh, 0FFh, 76h, 2, 33h, 0C0h, 0EBh, 24h, 0E8h, 6Bh, 1, 0E8h, 1Eh
	db	0Eh, 0E8h, 2Ah, 0, 0B8h, 0FFh, 0FFh, 77h, 2, 33h, 0C0h, 0EBh, 12h, 0E8h, 59h, 1
	db	0E8h, 1Ch, 0Eh, 0E8h, 18h, 0, 0B8h, 0FFh, 0FFh, 73h, 2, 33h, 0C0h, 0EBh, 0, 26h
	db	89h, 46h, 0Ah, 26h, 89h, 46h, 0Ch, 26h, 88h, 46h, 24h, 0E9h, 82h, 0Dh, 26h, 8Bh
	db	46h, 0Ah, 0F7h, 6, 7Ch, 51h, 8, 10h, 75h, 4, 23h, 0C0h, 0EBh, 4, 26h, 0Bh
	db	46h, 0Ch, 74h, 7, 26h, 8Ah, 46h, 24h, 0D0h, 0D8h, 0C3h, 26h, 8Ah, 46h, 4, 26h
	db	80h, 66h, 4, 8Fh, 0A8h, 20h, 75h, 16h, 0A8h, 40h, 74h, 12h, 0A8h, 10h, 74h, 0Ah
	db	26h, 8Bh, 46h, 0Eh, 26h, 3Bh, 46h, 12h, 0F8h, 0C3h, 32h, 0C0h, 0FEh, 0C8h, 0F8h, 0C3h
	db	0E8h, 44h, 0Dh, 0C4h, 2Eh, 0EEh, 55h, 26h, 0F6h, 46h, 0, 80h, 75h, 1Ch, 0E8h, 70h
	db	0Eh, 0E8h, 24h, 0Fh, 0C4h, 2Eh, 0F6h, 55h, 26h, 0F6h, 46h, 0, 80h, 75h, 49h, 0E8h
	db	5Fh, 0Eh, 0E8h, 13h, 0Fh, 0E8h, 0E1h, 36h, 0EBh, 41h, 0C4h, 2Eh, 0F6h, 55h, 26h, 0F6h
	db	46h, 0, 80h, 75h, 29h, 0E8h, 49h, 0Eh, 0E8h, 93h, 31h, 0E8h, 0FAh, 0Eh, 0C4h, 2Eh
	db	0EEh, 55h, 26h, 8Ah, 46h, 0, 26h, 8Bh, 56h, 2, 0C4h, 2Eh, 0F6h, 55h, 26h, 88h
	db	46h, 0, 26h, 89h, 56h, 2, 0E8h, 98h, 10h, 0E8h, 64h, 10h, 0EBh, 13h, 0F7h, 6
	db	7Ch, 51h, 0, 10h, 75h, 0CFh, 0EBh, 3, 0E8h, 0CDh, 0Eh, 0E8h, 77h, 10h, 0E8h, 3Ch
	db	10h, 0E8h, 59h, 0Fh, 0C4h, 2Eh, 0F6h, 55h, 26h, 0F6h, 46h, 4, 4, 0C4h, 2Eh, 0EEh
	db	55h, 74h, 0Dh, 26h, 0F6h, 46h, 4, 4, 74h, 6, 0B9h, 6Ah, 0, 0E8h, 98h, 46h
	db	0C4h, 2Eh, 0F6h, 55h, 0C5h, 3Eh, 0EEh, 55h, 0F6h, 45h, 4, 4, 74h, 28h, 26h, 80h
	db	4Eh, 4, 4, 8Ah, 45h, 1, 26h, 88h, 46h, 1, 8Bh, 45h, 26h, 26h, 89h, 46h
	db	26h, 8Bh, 45h, 18h, 26h, 89h, 46h, 18h, 8Bh, 45h, 1Ah, 26h, 89h, 46h, 1Ah, 8Bh
	db	45h, 16h, 26h, 89h, 46h, 16h, 8Bh, 45h, 14h, 23h, 0C0h, 74h, 4, 26h, 89h, 46h
	db	14h, 8Bh, 45h, 0Ah, 26h, 1, 46h, 0Ah, 8Bh, 45h, 0Ch, 26h, 11h, 46h, 0Ch, 8Ah
	db	45h, 24h, 26h, 10h, 46h, 24h, 8Ah, 45h, 5, 24h, 3, 26h, 8, 46h, 5, 8Ch
	db	0D0h, 8Eh, 0D8h, 0E8h, 0B1h, 46h, 0E9h, 85h, 0Ch, 0E8h, 4Bh, 0Ch, 0C4h, 2Eh, 0EEh, 55h
	db	26h, 0F6h, 46h, 0, 80h, 75h, 3Bh, 0E8h, 77h, 0Dh, 0E8h, 0C1h, 30h, 0E8h, 28h, 0Eh
	db	0E8h, 0D2h, 0Fh, 0E8h, 97h, 0Fh, 0C4h, 2Eh, 0F6h, 55h, 0F7h, 6, 7Ch, 51h, 0, 10h
	db	75h, 7, 26h, 0F6h, 46h, 0, 80h, 75h, 6Fh, 0E8h, 55h, 0Dh, 0E8h, 9Fh, 30h, 0E8h
	db	6, 0Eh, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 6, 0E8h, 32h, 39h, 0E8h, 0C9h, 35h
	db	0EBh, 72h, 0E8h, 0F3h, 0Dh, 0C4h, 2Eh, 0F6h, 55h, 26h, 0F6h, 46h, 0, 80h, 75h, 31h
	db	0E8h, 2Eh, 0Dh, 0E8h, 78h, 30h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 3, 0E8h, 0Eh
	db	39h, 0E8h, 8Dh, 0Fh, 0E8h, 59h, 0Fh, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 0, 26h
	db	8Bh, 56h, 2, 0C4h, 2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 26h, 89h, 56h, 2, 0EBh
	db	33h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 0Fh, 26h, 8Ah, 46h, 0, 0C4h, 2Eh, 0F6h
	db	55h, 26h, 88h, 46h, 0, 0E8h, 0D6h, 37h, 26h, 80h, 66h, 5, 0DFh, 33h, 0C0h, 26h
	db	89h, 46h, 22h, 26h, 89h, 46h, 20h, 26h, 89h, 46h, 1Eh, 26h, 89h, 46h, 2, 26h
	db	0C6h, 46h, 0, 0, 0E8h, 16h, 0Eh, 0C4h, 2Eh, 0F6h, 55h, 26h, 8Ah, 46h, 1, 24h
	db	7, 74h, 66h, 26h, 83h, 7Eh, 6, 0, 75h, 51h, 26h, 8Bh, 5Eh, 1Ah, 26h, 8Bh
	db	4Eh, 18h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 66h, 1, 80h, 0E4h, 7, 74h, 3Eh, 26h
	db	3Bh, 4Eh, 18h, 75h, 38h, 26h, 3Bh, 5Eh, 1Ah, 75h, 70h, 0F7h, 6, 7Ch, 51h, 0
	db	10h, 74h, 28h, 3Ah, 0C4h, 74h, 24h, 80h, 0FCh, 3, 75h, 21h, 3Ch, 1, 75h, 1Dh
	db	0E8h, 0FCh, 0, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0F5h, 0, 26h, 80h, 66h, 1, 0F8h, 26h
	db	80h, 4Eh, 1, 2, 8Eh, 1Eh, 0EEh, 55h, 0E9h, 0A5h, 0, 0EBh, 6Fh, 0C4h, 2Eh, 0F6h
	db	55h, 0B9h, 6Bh, 0, 0E8h, 1, 45h, 0EBh, 72h, 0C5h, 3Eh, 0EEh, 55h, 8Ah, 45h, 4
	db	24h, 4, 26h, 8, 46h, 4, 8Ah, 45h, 1, 26h, 88h, 46h, 1, 8Bh, 45h, 26h
	db	26h, 89h, 46h, 26h, 8Bh, 45h, 1Ah, 26h, 89h, 46h, 1Ah, 8Bh, 45h, 18h, 26h, 89h
	db	46h, 18h, 8Bh, 45h, 16h, 26h, 89h, 46h, 16h, 0EBh, 65h, 3Ah, 0C4h, 75h, 0BEh, 8Bh
	db	0C3h, 0E8h, 0A6h, 0A1h, 75h, 0B7h, 26h, 8Bh, 46h, 1Ah, 0E8h, 9Dh, 0A1h, 74h, 0AEh, 0C4h
	db	2Eh, 0F6h, 55h, 26h, 89h, 46h, 18h, 26h, 89h, 46h, 1Ah, 26h, 0C6h, 46h, 0, 0
	db	26h, 0C7h, 46h, 2, 0, 0, 0C5h, 3Eh, 0EEh, 55h, 0EBh, 34h, 0C4h, 2Eh, 0F6h, 55h
	db	26h, 0C6h, 46h, 0, 0, 26h, 0C7h, 46h, 2, 0, 0, 0C4h, 2Eh, 0EEh, 55h, 0E8h
	db	5Dh, 0, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 56h, 0, 33h, 0C0h, 26h, 80h, 66h, 4, 0FBh
	db	26h, 88h, 46h, 1, 26h, 89h, 46h, 18h, 26h, 89h, 46h, 1Ah, 0C5h, 3Eh, 0EEh, 55h
	db	8Bh, 45h, 14h, 23h, 0C0h, 74h, 4, 26h, 89h, 46h, 14h, 8Bh, 45h, 0Ah, 26h, 2Bh
	db	46h, 0Ah, 26h, 89h, 46h, 0Ah, 8Bh, 45h, 0Ch, 26h, 1Bh, 46h, 0Ch, 26h, 89h, 46h
	db	0Ch, 8Ah, 45h, 24h, 26h, 1Ah, 46h, 24h, 26h, 88h, 46h, 24h, 8Ah, 45h, 5, 24h
	db	3, 26h, 8, 46h, 5, 8Ch, 0D0h, 8Eh, 0D8h, 0E8h, 0ABh, 44h, 0E9h, 7Fh, 0Ah, 26h
	db	8Bh, 46h, 16h, 99h, 8Ah, 0CAh, 0D1h, 0E0h, 0D1h, 0D2h, 0D1h, 0E0h, 0D1h, 0D2h, 0D1h, 0E0h
	db	0D1h, 0D2h, 0D1h, 0E0h, 0D1h, 0D2h, 26h, 1, 46h, 0Ah, 26h, 11h, 56h, 0Ch, 26h, 10h
	db	4Eh, 24h, 26h, 0C7h, 46h, 16h, 0, 0, 0E9h, 7Ch, 44h, 0E8h, 19h, 0Ah, 0E8h, 0B4h
	db	0Dh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 49h, 0Bh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 42h, 0Bh, 0E8h
	db	0C7h, 33h, 0C4h, 2Eh, 0EEh, 55h, 26h, 0F6h, 46h, 4, 40h, 74h, 0Dh, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 0F3h, 36h, 0C4h, 2Eh, 0EEh, 55h, 0EBh, 7, 0E8h, 0EAh, 36h, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 9Ah, 0Bh, 0F7h, 6, 7Ch, 51h, 8, 10h, 75h, 39h, 0C4h, 2Eh, 0F6h, 55h
	db	0E8h, 0DAh, 43h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0D3h, 43h, 0C4h, 2Eh, 0F6h, 55h, 0C5h, 3Eh
	db	0EEh, 55h, 0F6h, 45h, 4, 40h, 74h, 2Dh, 8Bh, 45h, 0Eh, 26h, 89h, 46h, 0Eh, 26h
	db	80h, 4Eh, 4, 40h, 8Bh, 45h, 10h, 26h, 8Bh, 4Eh, 0Ah, 26h, 8Bh, 7Eh, 0Ch, 26h
	db	8Ah, 5Eh, 24h, 0EBh, 24h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0B4h, 43h, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 0ADh, 43h, 0EBh, 0C5h, 26h, 0F6h, 46h, 4, 40h, 74h, 49h, 26h, 8Bh, 46h, 10h
	db	8Bh, 4Dh, 0Ah, 8Bh, 7Dh, 0Ch, 8Ah, 5Dh, 24h, 99h, 8Ah, 0FAh, 16h, 1Fh, 26h, 0F6h
	db	46h, 5, 80h, 75h, 1Eh, 0E8h, 16h, 0E7h, 8Ah, 47h, 4, 98h, 3Bh, 47h, 2, 75h
	db	9, 32h, 47h, 1, 24h, 80h, 8Bh, 7, 74h, 9, 0B9h, 2Ch, 0, 0E8h, 0F9h, 0Dh
	db	0B8h, 1, 0, 26h, 89h, 46h, 10h, 3Dh, 1, 0, 74h, 5, 26h, 80h, 4Eh, 4
	db	20h, 0C5h, 3Eh, 0EEh, 55h, 8Ah, 45h, 5, 24h, 3, 26h, 8, 46h, 5, 8Bh, 45h
	db	0Ah, 8Bh, 55h, 0Ch, 8Ah, 7Dh, 24h, 26h, 8Bh, 4Eh, 0Ah, 26h, 8Bh, 7Eh, 0Ch, 26h
	db	8Ah, 5Eh, 24h, 16h, 1Fh, 0E8h, 0C6h, 0E6h, 0EBh, 62h, 0E8h, 58h, 9, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 2Ch, 43h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 25h, 43h, 26h, 8Bh, 46h, 0Ah, 26h
	db	8Bh, 56h, 0Ch, 26h, 8Ah, 7Eh, 24h, 0C4h, 2Eh, 0F6h, 55h, 26h, 8Bh, 4Eh, 0Ah, 26h
	db	8Bh, 7Eh, 0Ch, 26h, 8Ah, 5Eh, 24h, 0E8h, 0, 0E6h, 0EBh, 30h, 0E8h, 26h, 9, 0C4h
	db	2Eh, 0F6h, 55h, 0E8h, 0FAh, 42h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0F3h, 42h, 26h, 8Bh, 46h
	db	0Ah, 26h, 8Bh, 56h, 0Ch, 26h, 8Ah, 7Eh, 24h, 0C4h, 2Eh, 0F6h, 55h, 26h, 8Bh, 4Eh
	db	0Ah, 26h, 8Bh, 7Eh, 0Ch, 26h, 8Ah, 5Eh, 24h, 0E8h, 17h, 0E6h, 0C4h, 2Eh, 0F6h, 55h
	db	8Bh, 7, 26h, 89h, 46h, 0Ah, 8Bh, 47h, 2, 26h, 89h, 46h, 0Ch, 8Ah, 47h, 4
	db	26h, 88h, 46h, 24h, 0E8h, 0, 43h, 0E9h, 0D1h, 8, 0E8h, 0D8h, 8, 0C4h, 2Eh, 0F6h
	db	55h, 26h, 0F6h, 46h, 24h, 1, 74h, 19h, 33h, 0C0h, 26h, 0F7h, 56h, 0Ah, 26h, 0F7h
	db	56h, 0Ch, 26h, 83h, 46h, 0Ah, 1, 26h, 11h, 46h, 0Ch, 26h, 10h, 46h, 24h, 0EBh
	db	75h, 26h, 83h, 7Eh, 0Ch, 0, 75h, 24h, 26h, 8Bh, 4Eh, 0Ah, 83h, 0F9h, 20h, 73h
	db	1Bh, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 5Eh, 0Ch, 0E3h, 19h, 26h
	db	8Ah, 76h, 24h, 0D0h, 0EEh, 0D1h, 0DBh, 0D1h, 0D8h, 49h, 0EBh, 0F1h, 0C4h, 2Eh, 0EEh, 55h
	db	26h, 8Ah, 46h, 24h, 8Ah, 0E0h, 8Bh, 0D8h, 26h, 8Ah, 4Eh, 24h, 0C4h, 2Eh, 0F6h, 55h
	db	26h, 89h, 46h, 0Ah, 26h, 89h, 5Eh, 0Ch, 26h, 88h, 4Eh, 24h, 0E9h, 5Ch, 8, 0E8h
	db	63h, 8, 0C4h, 2Eh, 0F6h, 55h, 26h, 0F6h, 46h, 24h, 1, 74h, 19h, 33h, 0C0h, 26h
	db	0F7h, 56h, 0Ah, 26h, 0F7h, 56h, 0Ch, 26h, 83h, 46h, 0Ah, 1, 26h, 11h, 46h, 0Ch
	db	26h, 10h, 46h, 24h, 0EBh, 8Bh, 26h, 83h, 7Eh, 0Ch, 0, 75h, 1Eh, 26h, 8Bh, 4Eh
	db	0Ah, 83h, 0F9h, 20h, 73h, 15h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh
	db	5Eh, 0Ch, 0E3h, 13h, 0D1h, 0E0h, 0D1h, 0D3h, 49h, 0EBh, 0F7h, 0C4h, 2Eh, 0EEh, 55h, 33h
	db	0C0h, 8Bh, 0D8h, 26h, 88h, 46h, 24h, 0F7h, 6, 7Ch, 51h, 8, 10h, 75h, 4, 26h
	db	8Bh, 5Eh, 0Ch, 26h, 8Ah, 4Eh, 24h, 0C4h, 2Eh, 0F6h, 55h, 26h, 89h, 46h, 0Ah, 0F7h
	db	6, 7Ch, 51h, 0, 20h, 75h, 0Ch, 32h, 0C9h, 0F7h, 6, 7Ch, 51h, 8, 0, 75h
	db	2, 33h, 0DBh, 26h, 89h, 5Eh, 0Ch, 26h, 88h, 4Eh, 24h, 0E9h, 0CDh, 7, 89h, 2Eh
	db	0EEh, 55h, 8Ch, 6, 0F0h, 55h, 0E8h, 0C8h, 8, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h
	db	8, 0E8h, 83h, 34h, 26h, 0C6h, 46h, 0, 0, 26h, 0F6h, 46h, 4, 1, 74h, 8
	db	26h, 80h, 76h, 4, 2, 0E9h, 68h, 7, 26h, 0F7h, 56h, 0Ah, 26h, 0F7h, 56h, 0Ch
	db	26h, 83h, 46h, 0Ah, 1, 26h, 83h, 56h, 0Ch, 0, 26h, 0F6h, 56h, 24h, 0E8h, 0B6h
	db	41h, 0E9h, 4Ch, 7, 0E8h, 0ADh, 0, 0E8h, 0DDh, 7, 26h, 0F6h, 46h, 4, 4, 74h
	db	2Eh, 26h, 8Bh, 46h, 0Ah, 26h, 0Ah, 46h, 24h, 26h, 0Bh, 46h, 0Ch, 74h, 6, 0B9h
	db	23h, 0, 0E8h, 81h, 41h, 26h, 80h, 46h, 1, 5, 0F6h, 6, 86h, 51h, 80h, 74h
	db	0Eh, 0F7h, 6, 82h, 51h, 0, 40h, 74h, 6, 0B9h, 7Fh, 80h, 0E8h, 0BAh, 0Bh, 26h
	db	8Ah, 46h, 0Bh, 32h, 0E4h, 26h, 89h, 46h, 0Ah, 33h, 0C0h, 26h, 89h, 46h, 0Ch, 26h
	db	88h, 66h, 24h, 0E9h, 0FAh, 6, 0E8h, 5Bh, 0, 0E8h, 8Bh, 7, 26h, 0F6h, 46h, 4
	db	4, 74h, 1Ah, 26h, 80h, 46h, 1, 4, 0F6h, 6, 86h, 51h, 80h, 74h, 0Eh, 0F7h
	db	6, 82h, 51h, 0, 40h, 74h, 6, 0B9h, 7Fh, 80h, 0E8h, 7Ch, 0Bh, 33h, 0C0h, 26h
	db	88h, 46h, 0Bh, 26h, 89h, 46h, 0Ch, 26h, 88h, 46h, 24h, 0E9h, 0C2h, 6, 0E8h, 7Fh
	db	7, 0E8h, 70h, 0, 0E9h, 0B9h, 6, 26h, 80h, 4Eh, 5, 10h, 80h, 3Eh, 0CBh, 38h
	db	0, 74h, 0Eh, 0F7h, 6, 7Ch, 51h, 0, 20h, 75h, 6, 0F9h, 8Bh, 26h, 0AEh, 38h
	db	0C3h, 32h, 0C0h, 0C3h, 26h, 0F6h, 46h, 0, 80h, 75h, 29h, 26h, 8Ah, 46h, 1, 24h
	db	7, 3Ch, 4, 75h, 1Eh, 26h, 8Bh, 46h, 18h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 4Ch, 0ACh, 5Dh, 7, 26h, 89h, 4Eh, 18h, 26h, 80h, 66h, 1, 0F8h, 26h, 80h
	db	4Eh, 1, 1, 0C3h, 26h, 8Ah, 46h, 0, 26h, 8Bh, 4Eh, 2, 26h, 88h, 46h, 25h
	db	26h, 89h, 4Eh, 1Ch, 26h, 80h, 4Eh, 5, 40h, 26h, 0C6h, 46h, 0, 0, 26h, 0C7h
	db	46h, 2, 0, 0, 26h, 80h, 66h, 5, 0DFh, 33h, 0C0h, 26h, 89h, 46h, 22h, 26h
	db	89h, 46h, 1Eh, 26h, 89h, 46h, 20h, 26h, 0F6h, 46h, 4, 4, 74h, 25h, 3Ch, 2
	db	75h, 15h, 26h, 80h, 66h, 4, 0FBh, 33h, 0C0h, 26h, 88h, 46h, 1, 26h, 89h, 46h
	db	18h, 26h, 89h, 46h, 1Ah, 0EBh, 0Ch, 3Ch, 3, 75h, 8, 26h, 80h, 6Eh, 1, 2
	db	0E8h, 4Bh, 3Fh, 33h, 0C0h, 26h, 89h, 46h, 14h, 26h, 89h, 46h, 16h, 0C3h, 26h, 0F6h
	db	46h, 4, 4, 74h, 0Bh, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 4, 75h, 1, 0C3h
	db	0E8h, 0ADh, 6, 26h, 0F6h, 46h, 4, 4, 74h, 0Ah, 26h, 80h, 66h, 1, 0F8h, 26h
	db	80h, 4Eh, 1, 4, 26h, 8Bh, 46h, 16h, 99h, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h
	db	0Ch, 26h, 88h, 56h, 24h, 33h, 0C0h, 26h, 89h, 46h, 14h, 26h, 89h, 46h, 16h, 26h
	db	80h, 66h, 4, 8Fh, 26h, 80h, 66h, 5, 9Ch, 26h, 80h, 4Eh, 5, 1, 26h, 89h
	db	46h, 22h, 26h, 89h, 46h, 1Eh, 26h, 89h, 46h, 20h, 26h, 89h, 46h, 0Eh, 26h, 89h
	db	46h, 12h, 26h, 0C7h, 46h, 10h, 1, 0, 26h, 88h, 46h, 25h, 26h, 89h, 46h, 1Ch
	db	0E9h, 8Dh, 5, 8Bh, 0D8h, 0E8h, 74h, 0EEh, 0E8h, 14h, 0CEh, 6, 55h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	53h, 0E8h, 0B1h, 95h, 5Bh, 5Dh, 7, 74h, 0Bh, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h
	db	0Ch, 32h, 0C0h, 0C3h, 26h, 89h, 5Eh, 6, 0E8h, 0AAh, 7, 0EBh, 0F4h, 8Bh, 0D8h, 0E8h
	db	46h, 0EEh, 0E8h, 0E6h, 0CDh, 6, 55h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	53h, 0E8h, 55h, 95h, 5Bh, 5Dh, 7, 74h, 0Bh, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h
	db	0Ch, 32h, 0C0h, 0C3h, 26h, 89h, 5Eh, 6, 0E8h, 7Ch, 7, 0B8h, 1, 0, 33h, 0D2h
	db	0EBh, 0E7h, 8Bh, 0D8h, 0E8h, 13h, 0EEh, 0E8h, 0B3h, 0CDh, 6, 55h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	53h, 0E8h, 29h, 96h, 5Bh, 5Dh, 7, 74h, 0Bh, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h
	db	0Ch, 32h, 0C0h, 0C3h, 26h, 89h, 5Eh, 6, 0E8h, 49h, 7, 33h, 0C0h, 8Bh, 0D0h, 0EBh
	db	0E8h, 8Bh, 0D8h, 0E8h, 0E1h, 0EDh, 0E8h, 81h, 0CDh, 6, 55h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	53h, 0E8h, 6Eh, 96h, 5Bh, 5Dh, 7, 74h, 0Bh, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h
	db	0Ch, 32h, 0C0h, 0C3h, 26h, 89h, 5Eh, 6, 0E8h, 17h, 7, 33h, 0C0h, 8Bh, 0D0h, 0EBh
	db	0E8h, 0E8h, 6, 6, 0E8h, 0C9h, 31h, 26h, 8Bh, 46h, 0Ah, 0E8h, 0D6h, 3Dh, 0Ch, 80h
	db	26h, 88h, 46h, 0, 33h, 0C0h, 26h, 89h, 46h, 2, 26h, 89h, 46h, 0Ah, 26h, 89h
	db	46h, 0Ch, 26h, 88h, 46h, 24h, 0EBh, 8, 0E8h, 8Ah, 0EDh, 26h, 0C6h, 46h, 0, 88h
	db	6, 55h, 0E8h, 0AEh, 0CDh, 5Dh, 7, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h, 0Ch, 83h
	db	3Eh, 0B0h, 51h, 0, 74h, 7, 26h, 0C6h, 46h, 0, 0, 0EBh, 43h, 8Bh, 0Eh, 7Eh
	db	51h, 0E3h, 0F3h, 26h, 0C6h, 46h, 1, 3, 26h, 0C6h, 46h, 4, 4, 6, 55h, 8Bh
	db	0C1h, 9Ah
	dd	L101E0
	db	0E8h, 2Fh, 0AAh, 5Dh, 7, 26h, 89h, 46h, 1Ah, 26h, 89h, 4Eh, 18h, 0E8h, 43h, 9Bh
	db	0B2h, 1, 74h, 2, 0B2h, 2, 26h, 8, 56h, 5, 3Bh, 0C1h, 75h, 0Ch, 8Bh, 0C1h
	db	0E8h, 53h, 9Bh, 75h, 5, 26h, 80h, 6Eh, 1, 1, 32h, 0C0h, 0C3h, 0B8h, 61h, 0
	db	8Bh, 0C8h, 9Ah
	dd	L100B0
	db	9Ah
	dd	L101E0
	db	26h, 89h, 4Eh, 2, 49h, 89h, 0Eh, 0Ah, 56h, 8Bh, 0Eh, 6, 56h, 26h, 89h, 4Eh
	db	0, 0A3h, 6, 56h, 40h, 0A3h, 8, 56h, 0EBh, 0Ah, 90h, 8Bh, 0D8h, 83h, 3Eh, 0Ah
	db	56h, 0, 74h, 0CDh, 53h, 8Bh, 1Eh, 8, 56h, 0C1h, 0C3h, 4, 8Bh, 0EBh, 83h, 0E5h
	db	0F0h, 83h, 0E3h, 0Fh, 0D1h, 0E3h, 36h, 8Eh, 87h, 0D2h, 38h, 5Bh, 0B8h, 3, 0, 1
	db	6, 8, 56h, 29h, 6, 0Ah, 56h, 33h, 0C0h, 8Bh, 0FDh, 0B9h, 14h, 0, 0F3h, 0ABh
	db	26h, 0C6h, 46h, 10h, 1, 8Bh, 0C3h, 2Bh, 6, 0FEh, 55h, 72h, 6Ch, 3Dh, 58h, 0
	db	73h, 67h, 26h, 0C6h, 46h, 4, 40h, 26h, 89h, 5Eh, 0Eh, 3Dh, 3Ch, 0, 72h, 12h
	db	3Dh, 54h, 0, 73h, 27h, 26h, 0C6h, 46h, 0, 2, 26h, 80h, 4Eh, 5, 1, 32h
	db	0C0h, 0C3h, 3Dh, 10h, 0, 72h, 29h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 15h, 26h
	db	0C6h, 46h, 0, 3, 26h, 80h, 4Eh, 5, 2, 32h, 0C0h, 0C3h, 0F7h, 6, 7Ch, 51h
	db	8, 0, 75h, 0D1h, 33h, 0C0h, 26h, 88h, 46h, 4, 26h, 89h, 46h, 0Eh, 0EBh, 19h
	db	26h, 0C6h, 46h, 0, 1, 32h, 0C0h, 0C3h, 8Bh, 0CBh, 8Bh, 0DAh, 8Ah, 0F0h, 25h, 1Fh
	db	0, 0D1h, 0E0h, 8Bh, 0F8h, 0FFh, 0A5h, 2Ah, 1Dh, 8Bh, 0C2h, 6, 55h, 0E8h, 9Ah, 97h
	db	5Dh, 7, 0A8h, 20h, 74h, 0E2h, 8Bh, 0DAh, 24h, 0Fh, 2Ch, 80h, 0E8h, 2Fh, 0F0h, 26h
	db	88h, 46h, 0, 26h, 89h, 7Eh, 2, 26h, 0C6h, 46h, 1, 3, 26h, 0C6h, 46h, 4
	db	4, 3Ch, 89h, 75h, 9, 26h, 80h, 4Eh, 1, 10h, 26h, 89h, 5Eh, 26h, 0E8h, 0B5h
	db	0CBh, 56h, 6, 55h, 53h, 0C1h, 0C3h, 4, 8Bh, 0EBh, 83h, 0E5h, 0F0h, 83h, 0E3h, 0Fh
	db	0D1h, 0E3h, 36h, 8Eh, 87h, 0D2h, 38h, 5Bh, 0E8h, 0Fh, 0A6h, 89h, 2Eh, 0Ch, 56h, 5Dh
	db	7, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h, 0Ch, 26h, 89h, 76h, 1Ah, 26h, 89h, 7Eh
	db	18h, 72h, 10h, 26h, 0C6h, 46h, 5, 20h, 26h, 89h, 4Eh, 22h, 0A1h, 0Ch, 56h, 26h
	db	89h, 46h, 20h, 26h, 8, 5Eh, 5, 8Bh, 0C6h, 5Eh, 3Bh, 0C7h, 75h, 0Eh, 23h, 0C0h
	db	74h, 0Ah, 0E8h, 0E5h, 99h, 75h, 5, 26h, 80h, 6Eh, 1, 1, 32h, 0C0h, 0C3h, 0E8h
	db	54h, 0CBh, 56h, 53h, 6, 55h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 0C7h, 0A2h, 89h, 2Eh, 0Ch, 56h, 5Dh, 7, 74h, 9, 5Bh, 5Eh, 26h, 89h, 5Eh
	db	6, 0E9h, 70h, 1, 26h, 0C6h, 46h, 0, 88h, 26h, 0C6h, 46h, 1, 3, 26h, 0C6h
	db	46h, 4, 4, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h, 0Ch, 26h, 89h, 76h, 1Ah, 26h
	db	89h, 7Eh, 18h, 80h, 0CBh, 20h, 26h, 88h, 5Eh, 5, 26h, 89h, 4Eh, 22h, 0A1h, 0Ch
	db	56h, 26h, 89h, 46h, 20h, 8Bh, 0C6h, 5Bh, 5Eh, 3Bh, 0C7h, 75h, 0Eh, 23h, 0C0h, 74h
	db	0Ah, 0E8h, 79h, 99h, 75h, 5, 26h, 80h, 6Eh, 1, 1, 32h, 0C0h, 0C3h, 8Bh, 0C1h
	db	2Bh, 6, 0, 56h, 72h, 12h, 3Dh, 14h, 0, 73h, 0Dh, 8Bh, 0D8h, 8Bh, 87h, 0B6h
	db	1Ch, 26h, 89h, 46h, 0Ah, 32h, 0C0h, 0C3h, 0E8h, 0CEh, 0CAh, 8Bh, 0FBh, 0B9h, 4Eh, 10h
	db	0E8h, 0E0h, 6, 32h, 0C0h, 0C3h, 8Bh, 0C1h, 0F6h, 6, 87h, 51h, 1, 74h, 12h, 3Bh
	db	6, 82h, 58h, 74h, 24h, 3Bh, 6, 84h, 58h, 74h, 2Dh, 3Bh, 6, 86h, 58h, 74h
	db	36h, 2Bh, 6, 0, 56h, 72h, 3Fh, 3Dh, 14h, 0, 73h, 3Ah, 8Bh, 0D8h, 8Bh, 87h
	db	0B6h, 1Ch, 26h, 89h, 46h, 0Ah, 32h, 0C0h, 0C3h, 0F6h, 6, 87h, 51h, 2, 0B8h, 0FFh
	db	0FFh, 74h, 0EFh, 0B8h, 0FEh, 0FFh, 0EBh, 0EAh, 0F6h, 6, 87h, 51h, 8, 0B8h, 2, 0
	db	74h, 0E0h, 0B8h, 4, 0, 0EBh, 0DBh, 0F6h, 6, 87h, 51h, 2, 0B8h, 2, 0, 74h
	db	0D1h, 0B8h, 4, 0, 0EBh, 0CCh, 0F7h, 6, 7Ch, 51h, 0, 60h, 75h, 0Ch, 3Bh, 0Eh
	db	7Eh, 57h, 74h, 6Ch, 3Bh, 0Eh, 7Ch, 57h, 74h, 6Bh, 0E8h, 4Ch, 0CAh, 26h, 89h, 5Eh
	db	6, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 0Bh, 3Bh, 1Eh, 5Ah, 58h, 75h, 5, 80h
	db	0Eh, 0CAh, 38h, 2, 6, 55h, 53h, 0C1h, 0C3h, 4, 8Bh, 0EBh, 83h, 0E5h, 0F0h, 83h
	db	0E3h, 0Fh, 0D1h, 0E3h, 36h, 8Eh, 87h, 0D2h, 38h, 5Bh, 0E8h, 30h, 9Ah, 5Dh, 7, 0F6h
	db	0C3h, 20h, 74h, 66h, 80h, 0EBh, 0A0h, 50h, 53h, 51h, 0E8h, 47h, 0, 59h, 5Bh, 26h
	db	88h, 5Eh, 0, 26h, 88h, 7Eh, 5, 0E3h, 12h, 26h, 89h, 4Eh, 1Ah, 26h, 89h, 4Eh
	db	18h, 26h, 0C6h, 46h, 1, 3, 26h, 0C6h, 46h, 4, 4, 26h, 8Fh, 46h, 2, 0C3h
	db	0A1h, 0B6h, 51h, 0EBh, 8, 0A1h, 0B6h, 51h, 23h, 0C0h, 74h, 0Fh, 48h, 56h, 6, 55h
	db	0E8h, 56h, 0AEh, 5Dh, 7, 5Eh, 8Bh, 0D8h, 0E9h, 6Dh, 0FDh, 8Bh, 1Eh, 7Ah, 57h, 8Bh
	db	0D3h, 0E9h, 64h, 0FDh, 0E8h, 7Ch, 3, 0E8h, 0A5h, 2, 26h, 80h, 66h, 5, 0DFh, 33h
	db	0C0h, 26h, 89h, 46h, 22h, 26h, 89h, 46h, 20h, 0C3h, 0E8h, 66h, 3, 32h, 0C0h, 0C3h
	db	0E8h, 0A6h, 0C9h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 0Ch, 26h, 89h, 5Eh, 2, 26h
	db	0C6h, 46h, 0, 8Ah, 32h, 0C0h, 0C3h, 26h, 0C6h, 46h, 25h, 8Ah, 26h, 89h, 5Eh, 1Ch
	db	26h, 0C6h, 46h, 5, 40h, 0C3h, 0E8h, 80h, 0C9h, 6, 55h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 5Ah, 9Bh, 5Dh, 7, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h, 0Ch, 80h, 0EBh, 0A0h
	db	26h, 88h, 5Eh, 25h, 26h, 89h, 4Eh, 1Ch, 26h, 0C6h, 46h, 5, 40h, 32h, 0C0h, 0C3h
	db	0E8h, 54h, 0C9h, 26h, 0C6h, 46h, 1, 4, 26h, 0C6h, 46h, 4, 4, 26h, 0C6h, 46h
	db	5, 1, 26h, 89h, 5Eh, 18h, 26h, 89h, 5Eh, 1Ah, 32h, 0C0h, 0C3h, 0E8h, 37h, 0C9h
	db	26h, 89h, 5Eh, 6, 0E8h, 0EAh, 2, 32h, 0C0h, 0C3h, 0E8h, 2Ah, 0C9h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 8Fh, 0A7h, 0EBh, 0Dh, 0E8h, 1Bh, 0C9h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 56h, 0AAh, 9Ah
	dd	L101E0
	db	26h, 83h, 7Eh, 6, 0, 74h, 3, 0E8h, 0BCh, 2, 32h, 0C0h, 0C3h, 0E8h, 0FCh, 0C8h
	db	26h, 0C6h, 46h, 1, 1, 26h, 0C6h, 46h, 4, 4, 26h, 89h, 5Eh, 18h, 26h, 89h
	db	5Eh, 1Ah, 32h, 0C0h, 0C3h, 0E8h, 0E4h, 0C8h, 8Bh, 0C3h, 6, 55h, 53h, 0E8h, 55h, 43h
	db	5Bh, 74h, 0Ah, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 52h, 91h, 5Dh, 7, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h, 0Ch, 32h, 0C0h, 0C3h
	db	0E8h, 0BFh, 0C8h, 6, 55h, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 1, 9Bh, 5Dh, 7, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h, 0Ch, 32h, 0C0h, 0C3h
	db	26h, 0C6h, 46h, 4, 1, 26h, 89h, 5Eh, 8, 32h, 0C0h, 0C3h, 89h, 2Eh, 0EEh, 55h
	db	8Ch, 6, 0F0h, 55h, 0E9h, 84h, 3Ah, 0C4h, 2Eh, 0EEh, 55h, 32h, 0C0h, 0C3h, 89h, 3Eh
	db	0EEh, 55h, 0A3h, 0F0h, 55h, 89h, 2Eh, 0F6h, 55h, 8Ch, 6, 0F8h, 55h, 8Eh, 0C0h, 8Bh
	db	0EFh, 0E8h, 67h, 3Ah, 26h, 8Bh, 46h, 6, 26h, 8Ah, 5Eh, 5, 80h, 0E3h, 90h, 0C4h
	db	2Eh, 0F6h, 55h, 26h, 8, 5Eh, 5, 23h, 0C0h, 74h, 4, 26h, 89h, 46h, 6, 0E9h
	db	49h, 3Ah, 0E8h, 2Fh, 3, 0C4h, 2Eh, 0F6h, 55h, 32h, 0C0h, 0C3h, 0E8h, 0BFh, 0FFh, 0E8h
	db	5Ah, 3, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0EFh, 0, 0E8h, 39h, 24h, 0E8h, 0AFh, 2Ch, 26h
	db	8Ah, 46h, 5, 24h, 3, 0C4h, 2Eh, 0F6h, 55h, 26h, 8, 46h, 5, 0E8h, 0D8h, 0
	db	0E8h, 22h, 24h, 0E9h, 98h, 2Ch, 0E8h, 83h, 0FFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0C8h, 0
	db	0E8h, 12h, 24h, 0E9h, 88h, 2Ch, 0E8h, 73h, 0FFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0B8h, 0
	db	0E8h, 2, 24h, 26h, 0F6h, 46h, 4, 40h, 75h, 3, 0E9h, 71h, 2Ch, 0C3h, 0E8h, 5Bh
	db	0FFh, 0E8h, 0A4h, 0, 0E8h, 0EEh, 23h, 0E8h, 8Ch, 2Ch, 26h, 0C6h, 46h, 0, 1, 26h
	db	0F6h, 46h, 4, 4, 74h, 0Ah, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 1, 75h, 1
	db	0C3h, 0B9h, 6Ch, 0, 0E9h, 28h, 39h, 0E8h, 32h, 0FFh, 0E8h, 20h, 0, 0E8h, 0ACh, 0
	db	26h, 0C6h, 46h, 0, 0, 26h, 0F6h, 46h, 4, 4, 74h, 0Ah, 26h, 8Ah, 46h, 1
	db	24h, 7, 3Ch, 4, 73h, 1, 0C3h, 0B9h, 6Dh, 0, 0E9h, 2, 39h, 26h, 8Ah, 46h
	db	0, 0A8h, 80h, 74h, 1, 0C3h, 3Ch, 2, 74h, 0Eh, 3Ch, 3, 74h, 0Ah, 3Ch, 0
	db	74h, 6, 0B9h, 1Ah, 0, 0E8h, 0A8h, 3, 26h, 0C6h, 46h, 0, 0, 0C3h, 26h, 8Ah
	db	46h, 0, 0A8h, 80h, 74h, 5, 3Ch, 8Ah, 75h, 6, 0C3h, 0E8h, 0D8h, 0FFh, 0EBh, 0F6h
	db	26h, 0C6h, 46h, 0, 80h, 0B9h, 16h, 0, 0E9h, 85h, 3, 26h, 8Ah, 46h, 0, 0A8h
	db	80h, 74h, 5, 3Ch, 87h, 73h, 6, 0C3h, 0E8h, 0BBh, 0FFh, 0EBh, 0F6h, 26h, 0C6h, 46h
	db	0, 80h, 0B9h, 16h, 0, 0E9h, 68h, 3, 26h, 0F6h, 46h, 5, 10h, 75h, 8, 26h
	db	0F6h, 46h, 0, 80h, 75h, 4, 0C3h, 0E9h, 11h, 0F8h, 26h, 80h, 66h, 0, 7Fh, 26h
	db	80h, 66h, 4, 0FBh, 33h, 0C0h, 26h, 88h, 46h, 1, 26h, 89h, 46h, 1Ah, 26h, 89h
	db	46h, 18h, 26h, 89h, 46h, 14h, 0B9h, 15h, 0, 0E9h, 34h, 3, 26h, 0F6h, 46h, 0
	db	80h, 74h, 1, 0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 14h, 26h, 0F6h, 46h, 4
	db	80h, 74h, 17h, 0B9h, 1Eh, 0, 0E8h, 17h, 3, 26h, 80h, 66h, 4, 7Fh, 0EBh, 0Ah
	db	26h, 0F6h, 46h, 5, 20h, 74h, 3, 0E9h, 3Bh, 2, 0E8h, 0D4h, 1Eh, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 24h, 0A8h, 9Ah
	dd	L101E0
	db	8Bh, 0FDh, 8Ch, 0C0h, 5Dh, 7, 0E9h, 6Ah, 2, 26h, 8Ah, 46h, 4, 0A8h, 94h, 75h
	db	1, 0C3h, 0A8h, 80h, 74h, 8, 0B9h, 1Eh, 0, 0E8h, 0D8h, 2, 24h, 7Fh, 0A8h, 10h
	db	74h, 0Eh, 0B9h, 1Ch, 0, 0E8h, 0CCh, 2, 24h, 0EFh, 26h, 0C7h, 46h, 12h, 0, 0
	db	0A8h, 4, 74h, 0Ah, 26h, 88h, 46h, 4, 0B9h, 6Eh, 0, 0E9h, 0F5h, 37h, 26h, 88h
	db	46h, 4, 0C3h, 26h, 0F6h, 46h, 4, 80h, 75h, 1, 0C3h, 26h, 80h, 66h, 4, 7Fh
	db	0B9h, 1Eh, 0, 0E9h, 9Eh, 2, 26h, 8Ah, 46h, 4, 0A8h, 0B0h, 75h, 1, 0C3h, 0A8h
	db	80h, 74h, 8, 0B9h, 1Eh, 0, 0E8h, 8Bh, 2, 24h, 7Fh, 0A8h, 10h, 74h, 0Eh, 0B9h
	db	1Ch, 0, 0E8h, 7Fh, 2, 24h, 0EFh, 26h, 0C7h, 46h, 12h, 0, 0, 0A8h, 20h, 74h
	db	0Eh, 0B9h, 1Dh, 0, 0E8h, 6Dh, 2, 24h, 0DFh, 26h, 0C7h, 46h, 10h, 1, 0, 26h
	db	88h, 46h, 4, 0C3h, 0F6h, 6, 0C9h, 38h, 0Bh, 75h, 1Eh, 80h, 3Eh, 0CCh, 38h, 0
	db	75h, 6, 80h, 0Eh, 0CAh, 38h, 1, 0C3h, 6, 55h, 26h, 8Bh, 46h, 6, 9Ah
	dd	L101E0
	db	0E8h, 7Fh, 93h, 5Dh, 7, 0C3h, 0F6h, 6, 0C9h, 38h, 8, 75h, 7, 80h, 3Eh, 0CFh
	db	38h, 0, 75h, 0E0h, 80h, 3Eh, 0CBh, 38h, 0, 75h, 0D9h, 0B9h, 2Bh, 10h, 26h, 8Bh
	db	7Eh, 6, 0E9h, 1Ch, 2, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 4, 0C4h, 2Eh, 0F6h
	db	55h, 26h, 8Ah, 66h, 4, 0A8h, 40h, 74h, 4Ah, 0F6h, 0C4h, 40h, 74h, 45h, 0A8h, 20h
	db	74h, 16h, 0F6h, 0C4h, 20h, 74h, 11h, 26h, 80h, 66h, 4, 0DFh, 26h, 0C7h, 46h, 10h
	db	1, 0, 0B9h, 1Bh, 0, 0E8h, 0E9h, 1, 0A8h, 10h, 75h, 5, 0F6h, 0C4h, 10h, 74h
	db	22h, 33h, 0C9h, 0C4h, 2Eh, 0EEh, 55h, 26h, 89h, 4Eh, 12h, 26h, 80h, 66h, 4, 0EFh
	db	0C4h, 2Eh, 0F6h, 55h, 26h, 89h, 4Eh, 12h, 26h, 80h, 66h, 4, 0EFh, 0B9h, 1Ch, 0
	db	0E8h, 0BEh, 1, 0C5h, 3Eh, 0EEh, 55h, 0F6h, 45h, 4, 20h, 74h, 3Bh, 26h, 0F6h, 46h
	db	4, 40h, 74h, 0Dh, 26h, 80h, 4Eh, 4, 10h, 26h, 8Bh, 46h, 0Eh, 26h, 89h, 46h
	db	12h, 26h, 80h, 4Eh, 4, 60h, 8Bh, 45h, 0Eh, 26h, 89h, 46h, 0Eh, 8Bh, 45h, 10h
	db	26h, 89h, 46h, 10h, 0F6h, 45h, 4, 10h, 74h, 46h, 26h, 80h, 4Eh, 4, 10h, 8Bh
	db	45h, 12h, 26h, 89h, 46h, 12h, 0EBh, 38h, 0F6h, 45h, 4, 40h, 74h, 32h, 26h, 0F6h
	db	46h, 4, 40h, 75h, 1Fh, 8Ah, 45h, 4, 24h, 70h, 26h, 8, 46h, 4, 8Bh, 45h
	db	0Eh, 26h, 89h, 46h, 0Eh, 8Bh, 45h, 12h, 26h, 89h, 46h, 12h, 26h, 0C7h, 46h, 10h
	db	1, 0, 0EBh, 0Ch, 26h, 80h, 4Eh, 4, 10h, 8Bh, 45h, 0Eh, 26h, 89h, 46h, 12h
	db	8Ch, 0D0h, 8Eh, 0D8h, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 26h, 0F6h, 46h, 0, 80h, 75h, 2Ch
	db	26h, 0F6h, 46h, 5, 40h, 74h, 1, 0C3h, 0C4h, 2Eh, 0EEh, 55h, 26h, 0F6h, 46h, 5
	db	40h, 74h, 19h, 26h, 8Ah, 5Eh, 25h, 26h, 8Bh, 46h, 1Ch, 0C4h, 2Eh, 0F6h, 55h, 26h
	db	89h, 46h, 1Ch, 26h, 88h, 5Eh, 25h, 26h, 80h, 4Eh, 5, 40h, 0C3h, 0C4h, 2Eh, 0F6h
	db	55h, 26h, 0F6h, 46h, 5, 20h, 74h, 1, 0C3h, 0C4h, 2Eh, 0EEh, 55h, 26h, 0F6h, 46h
	db	5, 20h, 74h, 21h, 26h, 8Bh, 46h, 1Eh, 26h, 8Bh, 5Eh, 20h, 26h, 8Bh, 56h, 22h
	db	0C4h, 2Eh, 0F6h, 55h, 26h, 80h, 4Eh, 5, 20h, 26h, 89h, 46h, 1Eh, 26h, 89h, 5Eh
	db	20h, 26h, 89h, 56h, 22h, 0C3h, 26h, 8Bh, 46h, 1Eh, 26h, 89h, 46h, 14h, 26h, 8Bh
	db	46h, 20h, 26h, 89h, 46h, 16h, 26h, 0F6h, 46h, 0, 80h, 75h, 5, 26h, 0C6h, 46h
	db	0, 80h, 26h, 8Bh, 46h, 22h, 23h, 0C0h, 74h, 25h, 26h, 89h, 46h, 18h, 8Bh, 0D8h
	db	26h, 0F6h, 46h, 4, 4, 75h, 4, 26h, 89h, 5Eh, 1Ah, 26h, 8Ah, 46h, 1, 24h
	db	7, 3Ch, 2, 73h, 5, 26h, 80h, 46h, 1, 2, 26h, 80h, 4Eh, 4, 4, 0C3h
	db	8Bh, 0D8h, 26h, 80h, 4Eh, 0, 80h, 26h, 0F6h, 46h, 4, 4, 74h, 1Ah, 0F7h, 6
	db	7Ch, 51h, 0, 10h, 74h, 12h, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 4, 72h, 8
	db	53h, 0B9h, 6Dh, 0, 0E8h, 99h, 35h, 5Bh, 8Eh, 0DBh, 0F6h, 45h, 4, 4, 74h, 30h
	db	83h, 7Dh, 6, 0, 75h, 2Ah, 8Bh, 5Dh, 1Ah, 26h, 0F6h, 46h, 4, 4, 75h, 4
	db	26h, 89h, 5Eh, 1Ah, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 2, 73h, 5, 26h, 80h
	db	46h, 1, 2, 26h, 89h, 5Eh, 18h, 26h, 89h, 5Eh, 22h, 26h, 80h, 4Eh, 4, 4
	db	6, 55h, 8Ch, 0D8h, 8Eh, 0C0h, 8Bh, 0EFh, 16h, 1Fh, 0E8h, 69h, 35h, 26h, 8Bh, 46h
	db	0Ah, 5Dh, 7, 26h, 89h, 46h, 16h, 26h, 89h, 46h, 20h, 26h, 80h, 4Eh, 5, 20h
	db	0C3h, 80h, 3Eh, 0CCh, 38h, 0, 75h, 3, 0E9h, 0C9h, 0BFh, 0C3h, 26h, 0F6h, 46h, 0
	db	80h, 75h, 7, 26h, 0F6h, 46h, 4, 0C0h, 74h, 8, 0E8h, 84h, 1Fh, 0E8h, 9Fh, 21h
	db	0EBh, 6, 0E8h, 69h, 1Fh, 0E8h, 66h, 21h, 26h, 8Ah, 5Eh, 0, 80h, 0E3h, 7Fh, 0B8h
	db	2, 0, 80h, 0FBh, 2, 74h, 12h, 0B8h, 4, 0, 80h, 0FBh, 3, 74h, 0Ah, 0B8h
	db	6, 0, 80h, 0FBh, 5, 74h, 2, 33h, 0C0h, 0C3h, 0A1h, 0FEh, 55h, 5, 54h, 0
	db	0B9h, 2, 0, 0E8h, 0D1h, 92h, 74h, 3, 0E8h, 23h, 0, 5, 2, 0, 0E2h, 0F3h
	db	0C3h
L075B9:	mov	ax, word ptr ds:[55FEh]	;@075B9
	add	ax, 4Ch	;@075BC
	mov	cx, 6	;@075BF
	test	word ptr ds:[517Ch], 8	;@075C2
	jne	@@1	;@075C8
	sub	cx, 2	;@075CA
@@1:	call	@@2	;@075CD
	add	ax, 2	;@075D0
	loop	@@1	;@075D3
	ret	;@075D5
@@2:	push	cx	;@075D6
	push	ax	;@075D7
	call	L0599C	;@075D8
	call	far ptr L101F7	;@075DB
	mov	cx, ax	;@075E0
	pop	ax	;@075E2
	push	ax	;@075E3
	call	far ptr L101E0	;@075E4
	mov	ax, cx	;@075E9
	call	L01A09	;@075EB
	jne	@@3	;@075EE
	call	L01A25	;@075F0
@@3:	pop	ax	;@075F3
	pop	cx	;@075F4
	ret	;@075F5
L075F6:	test	byte ptr ds:[38C9h], 1	;@075F6
	je	@@1	;@075FB
	test	word ptr ds:[51B4h], 8	;@075FD
	je	@@1	;@07603
	call	far ptr L106E1	;@07605
@@1:	push	ss	;@0760A
	pop	es	;@0760B
	mov	di, 1D4Ch	;@0760C
	mov	cx, 9	;@0760F
	call	far ptr L11BEA	;@07612
	test	byte ptr ds:[51BFh], 10h	;@07617
	jne	@@2	;@0761C
	mov	bx, 3A24h	;@0761E
	call	far ptr L11C48	;@07621
	call	far ptr L11CA8	;@07626
	ret	;@0762B
@@2:	mov	al, byte ptr ds:[51BFh]	;@0762C
	and	ax, 7	;@0762F
	shl	ax, 1	;@07632
	mov	bx, ax	;@07634
	jmp	word ptr [bx+1EF8h]	;@07636
	db	0F6h, 6, 86h, 51h, 10h, 74h, 20h, 0BBh, 0A0h, 1Eh, 0E8h, 0, 2, 0EBh, 37h, 0F6h	;@0763A
	db	6, 86h, 51h, 10h, 75h, 22h, 0EBh, 7, 0F6h, 6, 86h, 51h, 10h, 74h, 19h, 0BBh
	db	0B2h, 1Eh, 0E8h, 0E8h, 1, 0EBh, 1Fh, 0A1h, 9Ch, 51h, 0Bh, 6, 9Eh, 51h, 0Bh, 6
	db	0A0h, 51h, 0Bh, 6, 0A2h, 51h, 74h, 3Fh, 0F7h, 6, 7Ch, 51h, 2, 0, 75h, 24h
	db	0BBh, 9Ah, 1Eh, 0E8h, 0C7h, 1, 0A1h, 0A0h, 51h, 0Bh, 6, 0A2h, 51h, 74h, 28h, 0A1h
	db	0A0h, 51h, 16h, 7, 0BFh, 0CCh, 1Dh, 0E8h, 27h, 0D8h, 0BBh, 0C4h, 1Dh, 9Ah
	dd	L11C48
	db	0EBh, 13h, 0A1h, 0A0h, 51h, 16h, 7, 0BFh, 0DAh, 1Dh, 0E8h, 12h, 0D8h, 0BBh, 0D2h, 1Dh
	db	9Ah
	dd	L11C48
	db	0BBh, 8Ch, 51h, 8Ah, 0Eh, 0BAh, 51h, 32h, 0EDh, 0E3h, 23h, 51h, 16h, 7, 0BFh, 0DEh
	db	52h, 0BEh, 0E2h, 1Dh, 0E8h, 28h, 0D8h, 8Bh, 7, 53h, 0E8h, 0Dh, 0D8h, 0B0h, 0Dh, 0AAh
	db	0BBh, 0DEh, 52h, 9Ah
	dd	L11C48
	db	5Bh, 59h, 43h, 43h, 0E2h, 0DDh, 0E9h, 3Ch, 0FFh, 0F6h, 6, 0C9h, 38h, 1, 74h, 0Dh
	db	0F7h, 6, 0B4h, 51h, 8, 0, 74h, 5, 9Ah
	dd	L106E1
	db	16h, 7, 0BFh, 55h, 1Dh, 0B9h, 7, 0, 9Ah
	dd	L11BEA
	db	0BBh, 8Ch, 51h, 8Ah, 0Eh, 0BAh, 51h, 32h, 0EDh, 0E3h, 27h, 3, 0D9h, 3, 0D9h, 4Bh
	db	4Bh, 51h, 16h, 7, 0BFh, 0DEh, 52h, 0BEh, 0E9h, 1Dh, 0E8h, 0D0h, 0D7h, 8Bh, 7, 53h
	db	0E8h, 0B5h, 0D7h, 0B0h, 0Dh, 0AAh, 0BBh, 0DEh, 52h, 9Ah
	dd	L11C48
	db	5Bh, 59h, 0E2h, 0DDh, 0A0h, 0BFh, 51h, 25h, 7, 0, 0D1h, 0E0h, 8Bh, 0D8h, 0FFh, 0A7h
	db	0, 1Fh, 0F6h, 6, 86h, 51h, 10h, 74h, 40h, 0A1h, 0A0h, 51h, 0Bh, 6, 0A2h, 51h
	db	74h, 6, 0BBh, 0BAh, 1Eh, 0E8h, 0EEh, 0, 0BBh, 0C0h, 1Eh, 0E8h, 0E8h, 0, 0EBh, 64h
	db	0F6h, 6, 86h, 51h, 10h, 75h, 33h, 0EBh, 7, 0F6h, 6, 86h, 51h, 10h, 74h, 2Ah
	db	0A1h, 0A0h, 51h, 0Bh, 6, 0A2h, 51h, 74h, 8, 0BBh, 0EFh, 1Dh, 9Ah
	dd	L11C48
	db	0BBh, 0C2h, 1Eh, 0E8h, 0BFh, 0, 0EBh, 3Bh, 0A1h, 9Ch, 51h, 0Bh, 6, 9Eh, 51h, 0Bh
	db	6, 0A0h, 51h, 0Bh, 6, 0A2h, 51h, 74h, 2Ah, 0F6h, 6, 7Ch, 51h, 2, 75h, 1Bh
	db	0A1h, 0A0h, 51h, 0Bh, 6, 0A2h, 51h, 74h, 8, 0BBh, 0EFh, 1Dh, 9Ah
	dd	L11C48
	db	0BBh, 0FAh, 1Dh, 9Ah
	dd	L11C48
	db	0EBh, 8, 0BBh, 2, 1Eh, 9Ah
	dd	L11C48
	db	33h, 0C0h, 0F6h, 6, 0BFh, 51h, 20h, 74h, 3, 0A1h, 9Ch, 51h, 16h, 7, 0BFh, 0Fh
	db	1Eh, 0E8h, 0E2h, 0D6h, 0BBh, 0Ah, 1Eh, 9Ah
	dd	L11C48
	db	9Ah
	dd	L11CA8
	db	0C3h, 16h, 7, 0BFh, 5Ch, 1Dh, 0B9h, 7, 0, 9Ah
	dd	L11BEA
	db	0F6h, 6, 87h, 51h, 4, 0BBh, 0C8h, 1Eh, 75h, 25h, 0F6h, 6, 87h, 51h, 80h, 0BBh
	db	0CAh, 1Eh, 75h, 1Bh, 0BBh, 0CEh, 1Eh, 0E8h, 39h, 0, 0F6h, 6, 86h, 51h, 40h, 75h
	db	11h, 0BBh, 0D6h, 1Eh, 0F7h, 6, 7Ch, 51h, 2, 0, 74h, 3, 0BBh, 0ECh, 1Eh, 0E8h
	db	21h, 0, 9Ah
	dd	L11CA8
	db	0C3h, 16h, 7, 0BFh, 63h, 1Dh, 0B9h, 3, 0, 9Ah
	dd	L11BEA
	db	0BBh, 1Fh, 1Eh, 9Ah
	dd	L11C48
	db	9Ah
	dd	L11CA8
	db	0C3h, 8Bh, 0Fh, 0E3h, 0Eh, 83h, 0C3h, 2, 53h, 8Bh, 0D9h, 9Ah
	dd	L11C48
	db	5Bh, 0EBh, 0EEh, 0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 7, 0F6h, 6, 0C9h, 38h
	db	0Bh, 74h, 19h, 8Bh, 0DAh, 8Bh, 0D0h, 0E8h, 0CFh, 0C0h, 8Bh, 0C3h, 0E8h, 7Eh, 8Ch, 24h
	db	3Fh, 3Ch, 0, 75h, 0Dh, 0F6h, 6, 0C9h, 38h, 0Bh, 75h, 5Fh, 80h, 0Eh, 0CAh, 38h
	db	1, 0C3h, 0A8h, 20h, 74h, 5Dh, 0A8h, 10h, 75h, 59h, 0F7h, 6, 7Ch, 51h, 0, 10h
	db	74h, 0Eh, 0F6h, 6, 0C9h, 38h, 1, 75h, 13h, 8Bh, 0C2h, 8Bh, 0D3h, 0E9h, 8Ah, 0
	db	8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 0D0h, 89h, 32h, 0C0h, 0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 7, 0F6h, 6
	db	0C9h, 38h, 0Bh, 74h, 19h, 8Bh, 0DAh, 8Bh, 0D0h, 0E8h, 76h, 0C0h, 8Bh, 0C3h, 0E8h, 25h
	db	8Ch, 24h, 3Fh, 3Ch, 0, 75h, 1Dh, 0F6h, 6, 0C9h, 38h, 0Bh, 75h, 6, 80h, 0Eh
	db	0CAh, 38h, 1, 0C3h, 0B9h, 2Bh, 10h, 8Bh, 0FBh, 0E9h, 43h, 0BCh, 8Bh, 0FBh, 0B9h, 13h
	db	10h, 0E9h, 3Bh, 0BCh, 0A8h, 20h, 74h, 6, 0A8h, 10h, 75h, 0F0h, 0EBh, 0Ah, 24h, 1Fh
	db	3Ch, 1, 74h, 0E8h, 3Ch, 9, 74h, 0E4h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 0Dh
	db	0F6h, 6, 0C9h, 38h, 1, 75h, 12h, 8Bh, 0C2h, 8Bh, 0D3h, 0EBh, 0Dh, 8Bh, 0C3h, 9Ah
	dd	L101E0
	db	0E8h, 62h, 89h, 32h, 0C0h, 0C3h, 0E8h, 18h, 0, 0E8h, 66h, 89h, 32h, 0C0h, 0C3h, 0E8h
	db	0Fh, 0, 0E8h, 70h, 89h, 32h, 0C0h, 0C3h, 0E8h, 6, 0, 0E8h, 7Ah, 89h, 32h, 0C0h
	db	0C3h, 52h, 0E8h, 5Eh, 0F3h, 59h, 0E8h, 48h, 2, 26h, 0F6h, 46h, 0, 80h, 74h, 25h
	db	0E8h, 8Ah, 23h, 26h, 0F6h, 46h, 4, 4, 74h, 21h, 26h, 8Bh, 46h, 1Ah, 51h, 23h
	db	0C0h, 74h, 8, 9Ah
	dd	L101E0
	db	0E8h, 49h, 9Dh, 8Bh, 0D9h, 8Bh, 0C8h, 0C4h, 2Eh, 0EEh, 55h, 0EBh, 0Bh, 0E8h, 78h, 0F8h
	db	0E8h, 3Bh, 24h, 51h, 33h, 0C9h, 33h, 0DBh, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 56h, 0Ch
	db	5Fh, 50h, 8Bh, 0C7h, 9Ah
	dd	L101E0
	db	58h, 0C3h, 50h, 52h, 51h, 57h, 0E8h, 1, 0E0h, 5Fh, 59h, 5Ah, 58h, 26h, 89h, 46h
	db	0Ah, 26h, 89h, 56h, 0Ch, 8Ah, 0C6h, 98h, 26h, 88h, 66h, 24h, 0B8h, 46h, 0, 3
	db	6, 0FEh, 55h, 26h, 89h, 46h, 0Eh, 26h, 0C7h, 46h, 4, 40h, 80h, 53h, 57h, 51h
	db	0E8h, 60h, 0F8h, 59h, 5Fh, 5Bh, 8Ah, 0D3h, 0F6h, 0C3h, 20h, 74h, 0Bh, 80h, 0EBh, 0A0h
	db	26h, 88h, 5Eh, 0, 26h, 89h, 7Eh, 2, 9Ah
	dd	L101F7
	db	50h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0E8h, 0B6h, 0A0h, 58h, 75h, 3, 0E8h, 0CCh, 0A0h, 32h, 0C0h, 0C3h, 50h, 52h, 51h, 0E8h
	db	0A3h, 0DFh, 59h, 5Ah, 58h, 26h, 89h, 46h, 0Ah, 26h, 89h, 56h, 0Ch, 0E8h, 8Bh, 1
	db	9Ah
	dd	L101F7
	db	50h, 0E8h, 4Bh, 0, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0E8h, 86h, 0A0h, 58h, 75h, 6, 0E8h, 0D1h, 0BEh, 0E8h, 99h, 0A0h, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 54h, 0BFh, 32h, 0C0h, 0C3h, 89h, 2Eh, 0EEh, 55h, 8Ch, 6, 0F0h, 55h, 9Ah
	dd	L101F7
	db	50h, 0E8h, 1Dh, 0, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	0E8h, 0E0h, 9Ch, 58h, 75h, 6, 0E8h, 0A3h, 0BEh, 0E8h, 0F3h, 9Ch, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 26h, 0BFh, 32h, 0C0h, 0C3h, 0F7h, 6, 7Ch, 51h, 0, 20h, 74h, 1, 0C3h, 33h
	db	0C0h, 26h, 80h, 66h, 5, 8Fh, 26h, 89h, 46h, 22h, 26h, 89h, 46h, 1Eh, 26h, 89h
	db	46h, 20h, 26h, 88h, 46h, 25h, 26h, 89h, 46h, 1Ch, 0C3h, 0E8h, 0Fh, 1, 8Bh, 0C1h
	db	9Ah
	dd	L101E0
	db	0E8h, 7Ch, 9Fh, 75h, 13h, 6, 55h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 8, 1, 9Ah
	dd	L101F7
	db	5Dh, 7, 0E8h, 83h, 9Fh, 32h, 0C0h, 0C3h, 0E8h, 0EAh, 0, 0E8h, 21h, 1Ah, 0E8h, 30h
	db	22h, 26h, 83h, 7Eh, 6, 0, 75h, 15h, 26h, 8Bh, 5Eh, 18h, 26h, 8Bh, 7Eh, 1Ah
	db	26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 56h, 0Ch, 0B1h, 0FFh, 0E9h, 0D3h, 0C0h, 32h, 0C9h, 0E9h
	db	0CEh, 0C0h, 0E8h, 42h, 0EFh, 0E8h, 0BDh, 0, 0E8h, 21h, 1Ah, 0E8h, 4, 23h, 26h, 83h
	db	7Eh, 6, 0, 75h, 28h, 26h, 0F6h, 46h, 4, 4, 74h, 30h, 0A1h, 7Eh, 51h, 26h
	db	39h, 46h, 1Ah, 74h, 27h, 0B9h, 53h, 0, 0E8h, 34h, 0BAh, 0EBh, 1Fh, 0E8h, 95h, 0
	db	0E8h, 0F1h, 0F6h, 0E8h, 0B4h, 22h, 26h, 83h, 7Eh, 6, 0, 74h, 0Fh, 80h, 26h, 0CAh
	db	38h, 0FEh, 26h, 8Bh, 7Eh, 6, 0B9h, 2Dh, 10h, 0E8h, 13h, 0BAh, 26h, 8Bh, 46h, 0Ah
	db	26h, 8Bh, 4Eh, 0Ch, 0F7h, 6, 7Ch, 51h, 8, 10h, 75h, 14h, 50h, 26h, 8Ah, 46h
	db	24h, 98h, 3Bh, 0C1h, 74h, 6, 0B9h, 8Fh, 80h, 0E8h, 0F3h, 0B9h, 33h, 0C9h, 58h, 0C3h
	db	32h, 0DBh, 0C3h, 0E8h, 0B7h, 0FFh, 26h, 80h, 7Eh, 24h, 0, 75h, 7, 8Bh, 0D8h, 0Bh
	db	0D9h, 74h, 1, 0C3h, 0B9h, 0Fh, 0, 0E8h, 0D5h, 0B9h, 0B8h, 1, 0, 33h, 0C9h, 0C3h
	db	0E8h, 32h, 0, 26h, 83h, 7Eh, 6, 0, 75h, 13h, 26h, 8Bh, 7Eh, 2, 26h, 8Ah
	db	5Eh, 0, 0F6h, 0C3h, 80h, 74h, 3, 80h, 0EBh, 60h, 33h, 0C0h, 0C3h, 0F6h, 6, 0C9h
	db	38h, 0Bh, 26h, 8Bh, 46h, 6, 74h, 8, 8Bh, 0F8h, 0B9h, 7, 10h, 0E8h, 9Fh, 0B9h
	db	32h, 0DBh, 33h, 0FFh, 0C3h, 89h, 2Eh, 0EEh, 55h, 8Ch, 6, 0F0h, 55h, 51h, 0E8h, 96h
	db	2Fh, 59h, 0C3h, 26h, 0F6h, 46h, 4, 44h, 75h, 1, 0C3h, 26h, 0F6h, 46h, 4, 40h
	db	74h, 6, 0B9h, 19h, 0, 0E8h, 0CBh, 2Eh, 26h, 0F6h, 46h, 4, 4, 74h, 17h, 26h
	db	83h, 7Eh, 6, 0, 75h, 10h, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 4, 74h, 6
	db	0B9h, 69h, 0, 0E9h, 0C5h, 2Eh, 0C3h, 0E8h, 0E2h, 17h, 0E8h, 17h, 0F6h, 26h, 0F6h, 46h
	db	4, 1, 74h, 43h, 0E8h, 0D3h, 21h, 26h, 8Ah, 66h, 4, 80h, 0E4h, 2, 50h, 26h
	db	8Bh, 46h, 8, 9Ah
	dd	L101E0
	db	58h, 0E8h, 0D8h, 88h, 0E8h, 6Ch, 0D1h, 51h, 0E3h, 1Eh, 0FCh, 8Ah, 7, 43h, 53h, 0E8h
	db	0E7h, 0C8h, 5Bh, 83h, 3Eh, 0B0h, 51h, 0, 74h, 0Ch, 53h, 51h, 0E8h, 0F4h, 0BDh, 59h
	db	5Bh, 53h, 0E8h, 0D6h, 0BDh, 5Bh, 0E2h, 0E3h, 0E8h, 0E8h, 0BDh, 58h, 32h, 0FFh, 0C3h, 0E8h
	db	5, 22h, 0E8h, 70h, 29h, 0E8h, 0DBh, 0BDh, 0B8h, 1, 0, 32h, 0FFh, 0C3h, 0E8h, 93h
	db	17h, 26h, 0F6h, 46h, 0, 80h, 75h, 22h, 0E8h, 0B1h, 0F5h, 0E8h, 0D3h, 21h, 0E8h, 76h
	db	29h, 6, 55h, 0E8h, 0BDh, 0BDh, 5Dh, 7, 0B8h, 2, 0, 26h, 0F6h, 46h, 5, 40h
	db	75h, 3, 32h, 0FFh, 0C3h, 0B7h, 1, 0E9h, 0BCh, 1, 0E8h, 0D7h, 20h, 0E8h, 57h, 29h
	db	6, 55h, 0E8h, 9Eh, 0BDh, 5Dh, 7, 0B8h, 2, 0, 0B7h, 1, 0E9h, 0B3h, 1, 0E8h
	db	42h, 17h, 26h, 0F6h, 46h, 5, 10h, 75h, 7, 26h, 0F6h, 46h, 0, 80h, 75h, 5Eh
	db	0E8h, 69h, 0F5h, 26h, 0F6h, 46h, 4, 1, 74h, 2Bh, 0E8h, 25h, 21h, 26h, 8Ah, 66h
	db	4, 80h, 0E4h, 2, 50h, 26h, 8Bh, 46h, 8, 9Ah
	dd	L101E0
	db	58h, 0E8h, 2Ah, 88h, 0E8h, 48h, 0D0h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 90h, 29h, 0E8h, 54h
	db	0BDh, 0B8h, 4, 0, 32h, 0FFh, 0C3h, 0E8h, 22h, 21h, 0E8h, 8, 29h, 6, 55h, 0E8h
	db	43h, 0BDh, 5Dh, 7, 26h, 0F6h, 46h, 5, 40h, 75h, 6, 0B8h, 4, 0, 32h, 0FFh
	db	0C3h, 0E8h, 89h, 25h, 0B7h, 2, 73h, 2, 0B7h, 3, 0B8h, 4, 0, 0E9h, 38h, 1
	db	0E8h, 4Eh, 2Eh, 0E8h, 0D4h, 25h, 73h, 15h, 0E8h, 93h, 20h, 0E8h, 0D7h, 28h, 6, 55h
	db	0E8h, 12h, 0BDh, 5Dh, 7, 0B8h, 4, 0, 0B7h, 3, 0E9h, 27h, 1, 0E8h, 18h, 20h
	db	0E8h, 0D2h, 28h, 6, 55h, 0E8h, 0FDh, 0BCh, 5Dh, 7, 0B8h, 4, 0, 0B7h, 2, 0E9h
	db	12h, 1, 0E8h, 0A1h, 16h, 0E8h, 0D6h, 0F4h, 26h, 0F6h, 46h, 4, 1, 74h, 2Bh, 0E8h
	db	92h, 20h, 26h, 8Ah, 66h, 4, 80h, 0E4h, 2, 50h, 26h, 8Bh, 46h, 8, 9Ah
	dd	L101E0
	db	58h, 0E8h, 97h, 87h, 0E8h, 6, 0CFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 9, 29h, 0E8h, 0C1h
	db	0BCh, 0B8h, 8, 0, 32h, 0FFh, 0C3h, 0E8h, 8Fh, 20h, 0E8h, 95h, 28h, 0E8h, 0B2h, 0BCh
	db	0B8h, 8, 0, 32h, 0FFh, 0C3h, 0E8h, 5Ah, 16h, 26h, 0F6h, 46h, 5, 10h, 75h, 7
	db	26h, 0F6h, 46h, 0, 80h, 75h, 53h, 0E8h, 81h, 0F4h, 26h, 0F6h, 46h, 4, 1, 74h
	db	2Bh, 0E8h, 3Dh, 20h, 26h, 8Ah, 66h, 4, 80h, 0E4h, 2, 50h, 26h, 8Bh, 46h, 8
	db	9Ah
	dd	L101E0
	db	58h, 0E8h, 42h, 87h, 0E8h, 11h, 0CFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0AEh, 28h, 0E8h, 6Ch
	db	0BCh, 0B8h, 6, 0, 32h, 0FFh, 0C3h, 0E8h, 3Ah, 20h, 0E8h, 57h, 28h, 6, 55h, 0E8h
	db	5Bh, 0BCh, 5Dh, 7, 0B8h, 6, 0, 26h, 0F6h, 46h, 5, 40h, 75h, 3, 32h, 0FFh
	db	0C3h, 0B7h, 4, 0EBh, 5Bh, 0E8h, 1Bh, 1Fh, 0E8h, 50h, 28h, 6, 55h, 0E8h, 3Dh, 0BCh
	db	5Dh, 7, 0B8h, 6, 0, 0B7h, 4, 0EBh, 53h, 0E8h, 0E2h, 15h, 0E8h, 17h, 0F4h, 26h
	db	0F6h, 46h, 4, 1, 74h, 2Bh, 0E8h, 0D3h, 1Fh, 26h, 8Ah, 66h, 4, 80h, 0E4h, 2
	db	50h, 26h, 8Bh, 46h, 8, 9Ah
	dd	L101E0
	db	58h, 0E8h, 0D8h, 86h, 0E8h, 0E2h, 0CDh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 50h, 28h, 0E8h, 2
	db	0BCh, 0B8h, 0Ah, 0, 32h, 0FFh, 0C3h, 0E8h, 0D0h, 1Fh, 0E8h, 18h, 28h, 0E8h, 0F3h, 0BBh
	db	0B8h, 0Ah, 0, 32h, 0FFh, 0C3h, 26h, 8Ah, 5Eh, 25h, 80h, 0EBh, 60h, 26h, 8Bh, 7Eh
	db	1Ch, 0C3h, 26h, 8Ah, 5Eh, 0, 80h, 0EBh, 60h, 26h, 8Bh, 7Eh, 2, 0C3h, 0B8h, 1
	db	0, 33h, 0C9h, 50h, 0E8h, 0ACh, 0C7h, 58h, 0B9h, 0, 0, 0C3h, 0B8h, 2, 0, 33h
	db	0C9h, 50h, 0E8h, 9Eh, 0C7h, 58h, 0B9h, 0, 0, 0C3h, 0B8h, 4, 0, 33h, 0C9h, 50h
	db	0E8h, 90h, 0C7h, 58h, 0B9h, 0, 0, 0C3h, 0B8h, 6, 0, 33h, 0C9h, 50h, 0E8h, 82h
	db	0C7h, 58h, 0B9h, 0, 0, 0C3h, 0B8h, 8, 0, 33h, 0C9h, 50h, 0E8h, 74h, 0C7h, 58h
	db	0B9h, 0, 0, 0C3h, 0B8h, 0Ah, 0, 33h, 0C9h, 50h, 0E8h, 66h, 0C7h, 58h, 0B9h, 0
	db	0, 0C3h, 0E8h, 66h, 0BBh, 8Ah, 0C1h, 0E8h, 5Fh, 0C6h, 0E9h, 76h, 0BBh, 0E8h, 5Bh, 0BBh
	db	0F7h, 6, 7Ch, 51h, 40h, 0, 75h, 8, 0B0h, 9Bh, 0E8h, 4Ch, 0C6h, 0E9h, 85h, 0BBh
	db	0BFh, 72h, 56h, 0E8h, 0A5h, 2Ah, 0B0h, 90h, 0E8h, 3Eh, 0C6h, 0B0h, 9Bh, 0E8h, 39h, 0C6h
	db	0E9h, 72h, 0BBh, 0E8h, 0Eh, 15h, 0E8h, 3Bh, 16h, 0E8h, 2Dh, 17h, 0E8h, 60h, 1Dh, 0E8h
	db	1Ch, 14h, 0E9h, 60h, 0BBh, 0E8h, 0FCh, 14h, 0E8h, 29h, 16h, 0E8h, 51h, 1Dh, 0F6h, 0C1h
	db	10h, 74h, 3, 0E8h, 25h, 2, 0E8h, 5, 14h, 0E9h, 49h, 0BBh, 0E8h, 0E5h, 14h, 0E8h
	db	12h, 16h, 0E8h, 3Ah, 1Dh, 0E8h, 4, 2, 0E8h, 77h, 14h, 0E9h, 37h, 0BBh, 0E8h, 0D3h
	db	14h, 0E8h, 0, 16h, 0E8h, 88h, 16h, 0E8h, 0F2h, 1, 0F7h, 6, 7Ch, 51h, 0, 4
	db	74h, 24h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 1Ah, 26h, 8Bh, 46h, 0Eh
	db	3Bh, 6, 4Ah, 56h, 75h, 10h, 0E8h, 23h, 1Dh, 0B0h, 0DFh, 0E8h, 0CBh, 0C5h, 0B0h, 0E0h
	db	0E8h, 0C6h, 0C5h, 0E9h, 0FFh, 0BAh, 0E8h, 0F6h, 1Ch, 0E8h, 36h, 14h, 0E9h, 0F6h, 0BAh, 0E8h
	db	92h, 14h, 0E8h, 0BFh, 15h, 0E8h, 47h, 16h, 0F7h, 6, 7Ch, 51h, 0, 4, 74h, 44h
	db	26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 2Dh, 26h, 8Bh, 46h, 0Eh, 3Bh, 6
	db	4Ah, 56h, 75h, 2Bh, 0E8h, 0E5h, 1Ch, 0F7h, 6, 7Ch, 51h, 40h, 0, 74h, 6, 0BFh
	db	74h, 56h, 0E8h, 0E6h, 29h, 0B0h, 9Bh, 0E8h, 7Fh, 0C5h, 0B0h, 0DFh, 0E8h, 7Ah, 0C5h, 0B0h
	db	0E0h, 0E8h, 75h, 0C5h, 0E9h, 0AEh, 0BAh, 0F7h, 6, 7Ch, 51h, 40h, 0, 75h, 5, 0B0h
	db	9Bh, 0E8h, 65h, 0C5h, 0E8h, 98h, 1Ch, 0E8h, 54h, 13h, 0E9h, 98h, 0BAh, 0E8h, 34h, 14h
	db	0E8h, 61h, 15h, 0E8h, 0E9h, 15h, 0E8h, 86h, 1Ch, 0F6h, 0C1h, 10h, 74h, 3, 0E8h, 5Ah
	db	1, 0E8h, 3Ah, 13h, 0E9h, 7Eh, 0BAh, 0E8h, 1Ah, 14h, 0E8h, 47h, 15h, 0E8h, 0CFh, 15h
	db	0E8h, 6Ch, 1Ch, 0E8h, 36h, 1, 0E8h, 0A9h, 13h, 0E9h, 69h, 0BAh, 0E8h, 5, 14h, 0E8h
	db	32h, 15h, 0E8h, 29h, 16h, 0E8h, 57h, 1Ch, 0E8h, 9, 13h, 0E9h, 57h, 0BAh, 0E8h, 0F3h
	db	13h, 0E8h, 20h, 15h, 0E8h, 3Dh, 16h, 0E8h, 45h, 1Ch, 26h, 80h, 7Eh, 0, 6, 75h
	db	8, 0B5h, 0DBh, 0E8h, 0F8h, 12h, 0E9h, 3Ch, 0BAh, 8Ah, 0CDh, 0B5h, 0D9h, 0E8h, 0E4h, 12h
	db	0E9h, 32h, 0BAh, 0E8h, 0CEh, 13h, 0E8h, 0FBh, 14h, 0E8h, 38h, 16h, 0E8h, 20h, 1Ch, 26h
	db	80h, 7Eh, 0, 4, 75h, 8, 0B5h, 0DBh, 0E8h, 0C9h, 12h, 0E9h, 17h, 0BAh, 8Ah, 0CDh
	db	0B5h, 0DBh, 0E8h, 0BFh, 12h, 0E9h, 0Dh, 0BAh, 0E8h, 0A9h, 13h, 0E8h, 0D6h, 14h, 0E8h, 33h
	db	16h, 0E8h, 0FBh, 1Bh, 0E8h, 0ADh, 12h, 0E9h, 0FBh, 0B9h, 0E8h, 0BEh, 0B9h, 0F7h, 6, 7Ch
	db	51h, 40h, 0, 74h, 8, 0BFh, 74h, 56h, 0E8h, 10h, 29h, 0EBh, 0Dh, 80h, 0FDh, 0DBh
	db	74h, 8, 0F7h, 6, 7Ch, 51h, 0, 4, 75h, 5, 0B0h, 9Bh, 0E8h, 9Ah, 0C4h, 8Ah
	db	0C5h, 0E8h, 95h, 0C4h, 8Ah, 0C1h, 0E8h, 90h, 0C4h, 0E9h, 0C9h, 0B9h, 0E8h, 8Ch, 0B9h, 8Ah
	db	0C5h, 0E8h, 85h, 0C4h, 8Ah, 0C1h, 0E8h, 80h, 0C4h, 0E9h, 0B9h, 0B9h, 0E8h, 55h, 13h, 0E8h
	db	6Fh, 14h, 0E8h, 28h, 1Eh, 0E8h, 0F5h, 12h, 0E9h, 0AAh, 0B9h, 0E8h, 60h, 13h, 0E8h, 60h
	db	14h, 0E8h, 19h, 1Eh, 8Ah, 0F1h, 52h, 26h, 80h, 7Eh, 0Ah, 0, 74h, 17h, 0B8h, 22h
	db	0, 0E8h, 0A9h, 13h, 26h, 0C6h, 46h, 0Ah, 0, 0EBh, 0Ah, 52h, 0E8h, 3Fh, 13h, 0E8h
	db	3Fh, 14h, 0E8h, 0F8h, 1Dh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 35h, 14h, 0E8h, 0EEh, 1Dh, 5Ah
	db	26h, 80h, 7Eh, 0Ah, 0, 74h, 20h, 0C4h, 2Eh, 0F6h, 55h, 26h, 80h, 7Eh, 0Ah, 0
	db	75h, 21h, 80h, 0CDh, 4, 8Ah, 0F1h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 0Ah, 0C4h
	db	2Eh, 0F6h, 55h, 26h, 88h, 46h, 0Ah, 8Ah, 0CEh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 8Dh, 12h
	db	0E9h, 42h, 0B9h, 0B8h, 22h, 0, 0E8h, 54h, 13h, 0E9h, 39h, 0B9h, 0F7h, 6, 7Ch, 51h
	db	40h, 0, 75h, 1, 0C3h, 0B8h, 55h, 0, 0E9h, 42h, 13h, 0F7h, 6, 7Ch, 51h, 0
	db	4, 74h, 0Dh, 0F7h, 6, 7Ch, 51h, 40h, 0, 75h, 5, 0B0h, 9Bh, 0E9h, 0D9h, 0C3h
	db	0C3h, 0E8h, 0B0h, 12h, 0E8h, 0FFh, 13h, 0EBh, 14h, 0E8h, 0A8h, 12h, 0E8h, 0F7h, 13h, 0E8h
	db	2, 22h, 0EBh, 9, 0E8h, 9Dh, 12h, 0E8h, 0ECh, 13h, 0E8h, 9, 22h, 0F7h, 6, 7Ch
	db	51h, 1, 0, 74h, 54h, 26h, 8Ah, 46h, 0, 3Ch, 87h, 74h, 4Ch, 3Ch, 89h, 75h
	db	24h, 0E8h, 0F7h, 1Fh, 73h, 1Fh, 8Ah, 0C1h, 0E8h, 9Eh, 0C3h, 0B0h, 2, 0E8h, 99h, 0C3h
	db	0B0h, 0EBh, 0E8h, 94h, 0C3h, 0E8h, 26h, 21h, 4, 3, 0E8h, 8Ch, 0C3h, 0B1h, 0EAh, 0E8h
	db	0ABh, 10h, 0E9h, 0C0h, 0B8h, 0E8h, 54h, 20h, 73h, 1Fh, 8Ah, 0C1h, 0E8h, 7Ah, 0C3h, 0B0h
	db	2, 0E8h, 75h, 0C3h, 0B0h, 0EBh, 0E8h, 70h, 0C3h, 0E8h, 2, 21h, 0FEh, 0C0h, 0E8h, 68h
	db	0C3h, 0B1h, 0E9h, 0E8h, 4Bh, 10h, 0E9h, 9Ch, 0B8h, 0E8h, 0A2h, 10h, 0E9h, 96h, 0B8h, 0E8h
	db	32h, 12h, 0E8h, 81h, 13h, 0F7h, 6, 7Ch, 51h, 9, 0, 74h, 28h, 26h, 8Ah, 46h
	db	0, 3Ch, 87h, 74h, 20h, 3Ch, 89h, 75h, 22h, 0E8h, 8Fh, 1Fh, 73h, 1Dh, 8Ah, 0C1h
	db	34h, 1, 0E8h, 34h, 0C3h, 0E8h, 0C6h, 20h, 4, 3, 0E8h, 2Ch, 0C3h, 0B1h, 0EAh, 0E8h
	db	4Bh, 10h, 0E9h, 60h, 0B8h, 0E8h, 66h, 10h, 0E9h, 5Ah, 0B8h, 0E8h, 0EEh, 1Fh, 73h, 0F5h
	db	0F7h, 6, 7Ch, 51h, 8, 0, 75h, 17h, 8Ah, 0C1h, 34h, 1, 0E8h, 0Ah, 0C3h, 0E8h
	db	9Ch, 20h, 0FEh, 0C0h, 0E8h, 2, 0C3h, 0B1h, 0E9h, 0E8h, 0E5h, 0Fh, 0E9h, 36h, 0B8h, 0B0h
	db	0Fh, 0E8h, 0F5h, 0C2h, 80h, 0F1h, 0F0h, 0E8h, 0D7h, 0Fh, 0E9h, 28h, 0B8h, 0E8h, 0C4h, 11h
	db	26h, 0F6h, 46h, 4, 80h, 75h, 5, 0E8h, 73h, 12h, 73h, 11h, 0E8h, 0E5h, 12h, 0E8h
	db	64h, 14h, 0E8h, 1Dh, 1Ah, 0B1h, 20h, 0E8h, 75h, 0Fh, 0E9h, 8, 0B8h, 26h, 8Ah, 46h
	db	0, 3Ch, 87h, 74h, 2Bh, 3Ch, 89h, 75h, 1Ah, 0F7h, 6, 7Ch, 51h, 0, 20h, 0BBh
	db	48h, 0A1h, 74h, 3, 0BBh, 40h, 0A1h, 0FFh, 0D3h, 73h, 8, 0B1h, 0EAh, 0E8h, 0CDh, 0Fh
	db	0E9h, 0E2h, 0B7h, 0E8h, 76h, 1Fh, 73h, 8, 0B1h, 0E9h, 0E8h, 84h, 0Fh, 0E9h, 0D5h, 0B7h
	db	0B1h, 0EBh, 0E8h, 0D9h, 0Fh, 0E9h, 0CDh, 0B7h, 0E8h, 69h, 11h, 26h, 0F6h, 46h, 4, 80h
	db	75h, 5, 0E8h, 3Fh, 12h, 73h, 11h, 0E8h, 8Ah, 12h, 0E8h, 9, 14h, 0E8h, 0C2h, 19h
	db	0B1h, 10h, 0E8h, 1Ah, 0Fh, 0E9h, 0ADh, 0B7h, 26h, 80h, 7Eh, 0, 89h, 75h, 12h, 0E8h
	db	0B9h, 1Eh, 73h, 8, 0B1h, 9Ah, 0E8h, 84h, 0Fh, 0E9h, 99h, 0B7h, 0B0h, 0Eh, 0E8h, 58h
	db	0C2h, 0B1h, 0E8h, 0E8h, 3Bh, 0Fh, 0E9h, 8Ch, 0B7h, 0E8h, 42h, 11h, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 3Eh, 12h, 0E8h, 1Eh, 13h, 0E8h, 93h, 19h, 26h, 0F6h, 46h, 4, 40h, 74h, 58h
	db	26h, 8Bh, 46h, 0Eh, 0E8h, 57h, 0Eh, 22h, 0C0h, 75h, 45h, 0C4h, 2Eh, 0F6h, 55h, 0E8h
	db	1Fh, 12h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 1Dh, 0E8h, 6Dh, 19h, 26h
	db	8Bh, 46h, 0Eh, 3Bh, 6, 4Eh, 56h, 75h, 2Ch, 80h, 0C9h, 8, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 66h, 20h, 0E8h, 0DFh, 0Fh, 0E9h, 3Ch, 0B7h, 0E8h, 3Bh, 1Bh, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 56h, 20h, 0E8h, 0CFh, 0Fh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 98h, 22h, 0E9h, 25h, 0B7h
	db	0B8h, 64h, 0, 0EBh, 3, 0B8h, 65h, 0, 0E8h, 32h, 11h, 0E9h, 17h, 0B7h, 0E8h, 0DAh
	db	0B6h, 0E8h, 42h, 20h, 8Ah, 0C1h, 0E8h, 0D0h, 0C1h, 0E9h, 9, 0B7h, 0E8h, 0CCh, 0B6h, 8Ah
	db	0C1h, 0E8h, 0C5h, 0C1h, 0E9h, 0FEh, 0B6h, 0E8h, 0C1h, 0B6h, 8Ah, 0C1h, 0E8h, 63h, 0C1h, 0E9h
	db	0F3h, 0B6h, 0E8h, 0B6h, 0B6h, 8Ah, 0C1h, 0E8h, 2Dh, 0C1h, 0E9h, 0E8h, 0B6h, 0E8h, 0ABh, 0B6h
	db	8Ah, 0C1h, 0E8h, 0A4h, 0C1h, 8Ah, 0C5h, 0E8h, 9Fh, 0C1h, 0E9h, 0D8h, 0B6h, 0E8h, 8Eh, 10h
	db	0C4h, 2Eh, 0EEh, 55h, 0E8h, 9Dh, 11h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 96h, 11h, 0E8h, 5Bh
	db	14h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0B7h, 18h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0B0h, 18h, 0E8h
	db	0D7h, 1Fh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 10h, 0D6h, 0E8h, 40h, 20h, 0E8h, 11h, 0D6h, 0C4h
	db	2Eh, 0F6h, 55h, 0E8h, 3Ch, 0Fh, 0E9h, 9Ch, 0B6h, 0E8h, 38h, 10h, 0E8h, 65h, 11h, 0E8h
	db	32h, 12h, 0E8h, 8Ah, 18h, 0E8h, 0B1h, 1Fh, 0E8h, 27h, 0Fh, 0E9h, 87h, 0B6h, 0E8h, 23h
	db	10h, 0E8h, 50h, 11h, 0E8h, 0A5h, 11h, 0E8h, 75h, 18h, 0B1h, 0D7h, 0E8h, 13h, 0Fh, 0E9h
	db	73h, 0B6h, 0E8h, 29h, 10h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 38h, 11h, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 1Eh, 11h, 0E8h, 0F8h, 15h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 6Fh, 18h, 8Ah, 0E9h, 0E8h
	db	9Fh, 0Dh, 0E8h, 74h, 1Fh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 43h, 18h, 0E8h, 83h, 0Fh, 0E9h
	db	43h, 0B6h, 0E8h, 0F9h, 0Fh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 8, 11h, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 0EEh, 10h, 0E8h, 8Dh, 11h, 0E8h, 43h, 18h, 0E8h, 75h, 0Dh, 0E8h, 4Ah, 1Fh, 0C4h
	db	2Eh, 0F6h, 55h, 0E8h, 19h, 18h, 0E8h, 0E9h, 1Fh, 0F7h, 6, 7Ch, 51h, 20h, 0, 74h
	db	22h, 0E8h, 0A4h, 1Eh, 0C4h, 2Eh, 0EEh, 55h, 72h, 7, 26h, 80h, 7Eh, 0, 2, 0EBh
	db	5, 26h, 80h, 7Eh, 0, 3, 0C4h, 2Eh, 0F6h, 55h, 75h, 7, 26h, 0F6h, 46h, 4
	db	40h, 74h, 0Bh, 0E8h, 0E9h, 1Eh, 0B5h, 8Dh, 0E8h, 2Ah, 0Fh, 0E9h, 0E7h, 0B5h, 8Ah, 0C1h
	db	0B1h, 3, 0D2h, 0E8h, 0Ch, 0B8h, 0E8h, 0A0h, 0C0h, 0E8h, 55h, 21h, 0E9h, 0D6h, 0B5h, 0E8h
	db	72h, 0Fh, 0E8h, 8Ch, 10h, 0E8h, 0B9h, 19h, 33h, 0C0h, 0E8h, 81h, 1Ch, 73h, 0Bh, 8Ah
	db	0C1h, 0E8h, 85h, 0C0h, 0E8h, 50h, 21h, 0E9h, 0BBh, 0B5h, 8Ah, 0C1h, 0Ch, 1, 0E8h, 78h
	db	0C0h, 0E9h, 0B1h, 0B5h, 0E8h, 4Dh, 0Fh, 0E8h, 67h, 10h, 0E8h, 0AAh, 19h, 8Ah, 0C1h, 0E8h
	db	67h, 0C0h, 0E8h, 10h, 21h, 0E9h, 9Dh, 0B5h, 0E8h, 39h, 0Fh, 0F6h, 0C1h, 20h, 75h, 5
	db	0C6h, 6, 0FAh, 55h, 0FFh, 0E8h, 5Ch, 10h, 0E8h, 29h, 11h, 0E8h, 94h, 17h, 0E8h, 0A8h
	db	1Eh, 0B5h, 0F6h, 0E8h, 0B2h, 0Eh, 0E9h, 7Ch, 0B5h, 0E8h, 32h, 0Fh, 0C6h, 6, 0FAh, 55h
	db	0FFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 3Ch, 10h, 0E8h, 9, 11h, 0E8h, 74h, 17h, 0E8h, 88h
	db	1Eh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 19h, 10h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h
	db	75h, 19h, 0E8h, 67h, 17h, 26h, 8Bh, 46h, 0Eh, 3Bh, 6, 10h, 56h, 75h, 4Ah, 0C4h
	db	2Eh, 0EEh, 55h, 0B5h, 0D2h, 0E8h, 70h, 0Eh, 0E9h, 3Ah, 0B5h, 0E8h, 39h, 19h, 0B8h, 1
	db	0, 0E8h, 0EAh, 1Bh, 73h, 1Bh, 0F7h, 6, 7Ch, 51h, 2, 0, 74h, 1Fh, 0B5h, 0C0h
	db	0C4h, 2Eh, 0EEh, 55h, 0E8h, 51h, 0Eh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 87h, 20h, 0E9h, 14h
	db	0B5h, 0C4h, 2Eh, 0EEh, 55h, 0B5h, 0D0h, 0E8h, 3Eh, 0Eh, 0E9h, 8, 0B5h, 26h, 83h, 7Eh
	db	6, 0, 75h, 0EDh, 0B8h, 66h, 0, 0EBh, 3, 0B8h, 67h, 0, 0E8h, 0Eh, 0Fh, 0E9h
	db	0F3h, 0B4h, 0E8h, 8Fh, 0Eh, 0E8h, 0A9h, 0Fh, 0E8h, 0ECh, 18h, 0B8h, 3, 0, 0E8h, 9Dh
	db	1Bh, 72h, 8, 0B0h, 0CCh, 0E8h, 0A1h, 0BFh, 0E9h, 0DAh, 0B4h, 0B0h, 0CDh, 0E8h, 99h, 0BFh
	db	0E8h, 42h, 20h, 0E9h, 0CFh, 0B4h, 0E8h, 85h, 0Eh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 81h, 0Fh
	db	0E8h, 3, 19h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 8Ah, 0Fh, 0E8h, 0C5h, 16h, 0C4h, 2Eh, 0EEh
	db	55h, 26h, 8Ah, 46h, 0Ah, 8Ah, 0E8h, 0D0h, 0EDh, 0D0h, 0EDh, 0D0h, 0EDh, 80h, 0CDh, 0D8h
	db	24h, 7, 0D0h, 0E0h, 0D0h, 0E0h, 0D0h, 0E0h, 8Ah, 0C8h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0D1h
	db	0Dh, 0E9h, 91h, 0B4h, 0E8h, 2Dh, 0Eh, 0C6h, 6, 0FAh, 55h, 0FFh, 0E8h, 55h, 0Fh, 0E8h
	db	22h, 10h, 0E8h, 8Dh, 16h, 0E8h, 0A1h, 1Dh, 26h, 80h, 7Eh, 0, 1, 74h, 17h, 26h
	db	8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 0Dh, 0E8h, 99h, 0Bh, 0Ch, 40h, 0Ah, 0C1h
	db	0E8h, 26h, 0BFh, 0E9h, 5Fh, 0B4h, 0B5h, 0FEh, 0E8h, 8Dh, 0Dh, 0E9h, 57h, 0B4h, 0E8h, 0Dh
	db	0Eh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 1Ch, 0Fh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 15h, 0Fh, 0E8h
	db	0DAh, 11h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 20h
	db	0C4h, 2Eh, 0F6h, 55h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 28h, 26h, 80h
	db	7Eh, 0, 1, 74h, 21h, 26h, 8Bh, 46h, 0Eh, 0E8h, 2, 0Bh, 22h, 0C0h, 75h, 16h
	db	8Bh, 3Eh, 0EEh, 55h, 0A1h, 0F0h, 55h, 87h, 3Eh, 0F6h, 55h, 87h, 6, 0F8h, 55h, 89h
	db	3Eh, 0EEh, 55h, 0A3h, 0F0h, 55h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0Fh, 16h, 0E8h, 19h, 1Dh
	db	0C4h, 2Eh, 0F6h, 55h, 0E8h, 0FBh, 15h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h
	db	25h, 0C4h, 2Eh, 0EEh, 55h, 26h, 80h, 7Eh, 0, 1, 74h, 1Ah, 26h, 8Bh, 46h, 0Eh
	db	0E8h, 0BBh, 0Ah, 22h, 0C0h, 75h, 0Fh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0F7h, 0Ah, 0Ch, 90h
	db	0E8h, 86h, 0BEh, 0E9h, 0BFh, 0B3h, 0C6h, 6, 0FAh, 55h, 0FFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h
	db	0FFh, 0Ah, 0B5h, 86h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0DDh, 0Ch, 0E9h, 0A7h, 0B3h, 0E8h, 5Dh
	db	0Dh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 6Ch, 0Eh, 0E8h, 8Bh, 1Bh, 72h, 3Ch, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 4Dh, 0Eh, 0E8h, 0D8h, 10h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 30h, 17h, 0C4h, 2Eh
	db	0EEh, 55h, 0E8h, 8Dh, 15h, 0E8h, 0A1h, 1Ch, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h
	db	75h, 61h, 26h, 8Bh, 46h, 0Eh, 0E8h, 55h, 0Ah, 22h, 0C0h, 75h, 56h, 0C4h, 2Eh, 0F6h
	db	55h, 0B1h, 0A8h, 0E8h, 0B7h, 0Ah, 0E9h, 5Ch, 0B3h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 24h, 0Eh
	db	0E8h, 0E9h, 10h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 74h
	db	16h, 8Bh, 3Eh, 0EEh, 55h, 0A1h, 0F0h, 55h, 87h, 3Eh, 0F6h, 55h, 87h, 6, 0F8h, 55h
	db	89h, 3Eh, 0EEh, 55h, 0A3h, 0F0h, 55h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 3Eh, 15h, 0E8h, 70h
	db	0Ah, 0E8h, 45h, 1Ch, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 27h, 15h, 0B5h, 84h, 0E8h, 48h, 0Ch
	db	0E9h, 12h, 0B3h, 32h, 0C9h, 0B5h, 0F6h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 3Ah, 0Ch, 0C4h, 2Eh
	db	0F6h, 55h, 0E8h, 64h, 1Eh, 0E9h, 0FDh, 0B2h, 0E8h, 0B3h, 0Ch, 0C4h, 2Eh, 0EEh, 55h, 0E8h
	db	0C2h, 0Dh, 0E8h, 0E1h, 1Ah, 0C4h, 2Eh, 0F6h, 55h, 73h, 2, 0EBh, 5Bh, 0E8h, 0A1h, 0Dh
	db	0E8h, 2Ch, 10h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 84h, 16h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0E1h
	db	14h, 0E8h, 0F5h, 1Bh, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 20h, 0E8h, 0F4h
	db	9, 0Ch, 0B0h, 8Ah, 0C8h, 0C4h, 2Eh, 0F6h, 55h, 26h, 80h, 7Eh, 0, 1, 74h, 3
	db	80h, 0C9h, 8, 8Ah, 0C1h, 0E8h, 71h, 0BDh, 0E8h, 0Eh, 1Eh, 0E9h, 0A7h, 0B2h, 0C6h, 6
	db	0FAh, 55h, 0FFh, 32h, 0C9h, 0B5h, 0C6h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0CAh, 0Bh, 0C4h, 2Eh
	db	0F6h, 55h, 0E8h, 0F4h, 1Dh, 0E9h, 8Dh, 0B2h, 0E8h, 59h, 0Dh, 0C4h, 2Eh, 0EEh, 55h, 32h
	db	0C9h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 19h, 0C4h, 2Eh, 0F6h, 55h, 26h
	db	8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 28h, 26h, 8Bh, 46h, 0Eh, 0E8h, 4Eh, 9
	db	3Ch, 8, 72h, 1Dh, 0C6h, 6, 0FAh, 55h, 0FFh, 0B1h, 2, 8Bh, 3Eh, 0EEh, 55h, 0A1h
	db	0F0h, 55h, 87h, 3Eh, 0F6h, 55h, 87h, 6, 0F8h, 55h, 89h, 3Eh, 0EEh, 55h, 0A3h, 0F0h
	db	55h, 80h, 0F1h, 2, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 47h, 14h, 0C4h, 2Eh, 0EEh, 55h, 0E8h
	db	4Ah, 14h, 26h, 8Bh, 46h, 0Eh, 0E8h, 15h, 9, 22h, 0C0h, 74h, 20h, 2Ch, 8, 73h
	db	52h, 0E8h, 0B8h, 0Fh, 0C4h, 2Eh, 0EEh, 55h, 8Ah, 0E9h, 80h, 0CDh, 88h, 0E8h, 61h, 9
	db	0E8h, 36h, 1Bh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 3Eh, 0Bh, 0E9h, 8, 0B2h, 0C4h, 2Eh, 0F6h
	db	55h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 80h, 75h, 0D6h, 0E8h, 8Eh, 0Fh, 0C4h, 2Eh
	db	0F6h, 55h, 0E8h, 14h, 1Bh, 0E8h, 42h, 1Bh, 80h, 0F1h, 2, 80h, 0C9h, 0A0h, 26h, 80h
	db	7Eh, 0, 1, 74h, 3, 80h, 0C9h, 1, 8Ah, 0C1h, 0E8h, 9Ch, 0BCh, 0E8h, 51h, 1Dh
	db	0E9h, 0D2h, 0B1h, 26h, 80h, 7Eh, 0, 3, 74h, 59h, 3Ch, 1, 74h, 45h, 8Ah, 0E9h
	db	0B1h, 3, 0D2h, 0E0h, 80h, 0CDh, 8Ch, 8Ah, 0C8h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0Fh, 0Dh
	db	0C4h, 2Eh, 0F6h, 55h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 14h, 80h, 3Eh
	db	0FAh, 55h, 0, 75h, 5, 0E8h, 0C3h, 0Eh, 0EBh, 13h, 0E8h, 0F6h, 0Ch, 0E8h, 0B9h, 1Ah
	db	0EBh, 0Bh, 0F7h, 6, 7Ch, 51h, 0, 20h, 74h, 3, 0E8h, 0E2h, 0Ch, 0E8h, 0C2h, 0Ah
	db	0E9h, 82h, 0B1h, 80h, 3Eh, 0FAh, 55h, 0, 75h, 0B4h, 0B9h, 22h, 0, 0E8h, 77h, 0ACh
	db	0E9h, 72h, 0B1h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 26h, 0F7h, 6, 7Ch, 51h, 80h
	db	0, 74h, 1Eh, 50h, 0E8h, 0F5h, 0Eh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 6Eh, 13h, 5Bh, 32h
	db	0FFh, 0D1h, 0E3h, 8Ah, 0E9h, 32h, 0C9h, 0Bh, 8Fh, 0CAh, 1Ch, 0E8h, 0C6h, 0Ah, 0E9h, 44h
	db	0B1h, 0B8h, 68h, 0, 0E8h, 56h, 0Bh, 0E9h, 3Bh, 0B1h, 0E8h, 0F1h, 0Ah, 0C4h, 2Eh, 0EEh
	db	55h, 0E8h, 0, 0Ch, 0E8h, 1Fh, 19h, 0C4h, 2Eh, 0F6h, 55h, 73h, 57h, 0E8h, 0F4h, 0Bh
	db	0E8h, 0B9h, 0Eh, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 74h
	db	20h, 8Ah, 0C1h, 34h, 38h, 0A2h, 0FAh, 55h, 80h, 0C9h, 2, 8Bh, 3Eh, 0EEh, 55h, 0A1h
	db	0F0h, 55h, 87h, 3Eh, 0F6h, 55h, 87h, 6, 0F8h, 55h, 89h, 3Eh, 0EEh, 55h, 0A3h, 0F0h
	db	55h, 80h, 0F1h, 2, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0F7h, 12h, 0C4h, 2Eh, 0EEh, 55h, 0E8h
	db	0FAh, 12h, 8Ah, 0E9h, 0E8h, 2Ah, 8, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0FBh, 19h, 0E8h, 7
	db	0Ah, 0E9h, 0D1h, 0B0h, 0E8h, 8Ah, 0Bh, 0E8h, 15h, 0Eh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 6Dh
	db	14h, 0E8h, 0E5h, 19h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0C7h, 12h, 26h, 8Ah, 46h, 4, 24h
	db	0C0h, 34h, 40h, 75h, 2Bh, 26h, 8Bh, 46h, 0Eh, 0E8h, 92h, 7, 22h, 0C0h, 75h, 20h
	db	26h, 8Bh, 46h, 0Eh, 3Bh, 6, 1Eh, 56h, 75h, 9, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 7Eh
	db	17h, 73h, 0Dh, 0C4h, 2Eh, 0F6h, 55h, 80h, 0C9h, 4, 0E8h, 0E0h, 7, 0E9h, 85h, 0B0h
	db	8Ah, 0C1h, 34h, 38h, 0A2h, 0FAh, 55h, 0C4h, 2Eh, 0F6h, 55h, 0B5h, 80h, 26h, 80h, 7Eh
	db	0, 1, 74h, 35h, 80h, 0CDh, 1, 0F7h, 6, 7Ch, 51h, 20h, 0, 75h, 0Fh, 80h
	db	0F9h, 20h, 74h, 14h, 80h, 0F9h, 8, 74h, 0Fh, 80h, 0F9h, 30h, 74h, 0Ah, 0E8h, 3Eh
	db	17h, 72h, 5, 80h, 0CDh, 2, 0EBh, 11h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 83h, 9, 0C4h
	db	2Eh, 0F6h, 55h, 0E8h, 0A3h, 1Bh, 0E9h, 3Ch, 0B0h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 72h, 9
	db	0C4h, 2Eh, 0F6h, 55h, 0E8h, 9Eh, 1Bh, 0E9h, 2Bh, 0B0h, 0E8h, 0C7h, 9, 26h, 0F6h, 46h
	db	0, 80h, 75h, 7, 26h, 0F6h, 46h, 4, 0C0h, 74h, 5Ch, 26h, 8Ah, 46h, 4, 24h
	db	0C0h, 34h, 40h, 75h, 4Fh, 0E8h, 0DCh, 0Ah, 0E8h, 68h, 0Bh, 0E8h, 1Eh, 12h, 26h, 8Bh
	db	46h, 0Eh, 0E8h, 0E9h, 6, 2Ch, 8, 73h, 11h, 8Ah, 0C8h, 0E8h, 1Bh, 19h, 8Ah, 0C1h
	db	4, 8, 0Ch, 50h, 0E8h, 0B2h, 0BAh, 0E9h, 0EBh, 0AFh, 8Ah, 0C8h, 0E8h, 40h, 0Bh, 8Ah
	db	0C1h, 0D0h, 0E0h, 0D0h, 0E0h, 0D0h, 0E0h, 3Ch, 20h, 73h, 8, 0Ch, 6, 0E8h, 99h, 0BAh
	db	0E9h, 0D2h, 0AFh, 8Ah, 0C8h, 0B0h, 0Fh, 0E8h, 8Fh, 0BAh, 8Ah, 0C1h, 0Ch, 80h, 0E8h, 88h
	db	0BAh, 0E9h, 0C1h, 0AFh, 0E9h, 86h, 0, 0C4h, 2Eh, 0EEh, 55h, 26h, 0F6h, 46h, 5, 80h
	db	74h, 0Eh, 0F7h, 6, 82h, 51h, 0, 80h, 74h, 6, 0B8h, 80h, 80h, 0E8h, 0BDh, 9
	db	0E8h, 5Eh, 0Ah, 0E8h, 5Bh, 0Ch, 0F7h, 6, 7Ch, 51h, 2, 0, 74h, 26h, 0E8h, 0B8h
	db	18h, 0B1h, 68h, 0E8h, 38h, 13h, 0E8h, 76h, 16h, 72h, 0Eh, 80h, 0C9h, 2, 8Ah, 0C1h
	db	0E8h, 46h, 0BAh, 0E8h, 0EFh, 1Ah, 0E9h, 7Ch, 0AFh, 8Ah, 0C1h, 0E8h, 3Bh, 0BAh, 0E8h, 0D8h
	db	1Ah, 0E9h, 71h, 0AFh, 0F7h, 6, 7Ch, 51h, 20h, 0, 74h, 6Bh, 0E8h, 52h, 13h, 0B0h
	db	50h, 0E8h, 25h, 0BAh, 0B0h, 55h, 0E8h, 20h, 0BAh, 0B0h, 8Bh, 0E8h, 1Bh, 0BAh, 0B0h, 0ECh
	db	0E8h, 16h, 0BAh, 0B0h, 0C7h, 0E8h, 11h, 0BAh, 0B0h, 46h, 0E8h, 0Ch, 0BAh, 0B0h, 2, 0E8h
	db	7, 0BAh, 0E8h, 0D2h, 1Ah, 0B0h, 5Dh, 0E8h, 0FFh, 0B9h, 0E9h, 38h, 0AFh, 0E8h, 4, 0Ah
	db	0E8h, 1Fh, 0Ch, 26h, 8Ah, 46h, 0, 0F7h, 6, 7Ch, 51h, 8, 0, 75h, 0Eh, 3Ch
	db	3, 75h, 18h, 0B8h, 2, 0, 26h, 0C6h, 46h, 0, 2, 0EBh, 23h, 3Ch, 5, 75h
	db	0Ah, 0B8h, 4, 0, 26h, 0C6h, 46h, 0, 3, 0EBh, 15h, 0E8h, 2Bh, 18h, 0B9h, 30h
	db	0FFh, 0E8h, 3Eh, 8, 0E9h, 0FEh, 0AEh, 0B9h, 8Ch, 0, 0E8h, 0FAh, 0A9h, 0E9h, 0F5h, 0AEh
	db	0F7h, 6, 7Ch, 51h, 20h, 0, 74h, 0EFh, 56h, 50h, 6, 55h, 0E8h, 58h, 0CEh, 5Eh
	db	1Fh, 58h, 1Eh, 56h, 83h, 0C6h, 0, 8Bh, 0FDh, 83h, 0C7h, 0, 0B9h, 28h, 0, 0F3h
	db	0A4h, 16h, 1Fh, 26h, 0C6h, 46h, 0, 2, 26h, 1, 46h, 0Ah, 26h, 83h, 56h, 0Ch
	db	0, 26h, 80h, 56h, 24h, 0, 0E8h, 0E0h, 17h, 0B9h, 30h, 0FFh, 0E8h, 0F3h, 7, 0E8h
	db	0B3h, 0AEh, 0E8h, 76h, 0AEh, 5Dh, 7, 0E8h, 0CFh, 17h, 0B9h, 30h, 0FFh, 0E8h, 0E2h, 7
	db	5Eh, 0E9h, 0A1h, 0AEh, 0E8h, 3Dh, 8, 0E8h, 6Ah, 9, 0E8h, 85h, 0Bh, 26h, 8Ah, 46h
	db	4, 24h, 0C0h, 34h, 40h, 75h, 67h, 0E8h, 0A2h, 10h, 26h, 8Bh, 46h, 0Eh, 0E8h, 6Dh
	db	5, 2Ch, 8, 73h, 11h, 4, 8, 8Ah, 0C8h, 0E8h, 9Dh, 17h, 8Ah, 0C1h, 0Ch, 58h
	db	0E8h, 36h, 0B9h, 0E9h, 6Fh, 0AEh, 8Ah, 0C8h, 0E8h, 0C4h, 9, 8Ah, 0C1h, 3Ch, 1, 74h
	db	12h, 0D0h, 0E0h, 0D0h, 0E0h, 0D0h, 0E0h, 3Ch, 20h, 73h, 11h, 0Ch, 7, 0E8h, 19h, 0B9h
	db	0E9h, 52h, 0AEh, 0B9h, 22h, 0, 0E8h, 4Eh, 0A9h, 0E9h, 49h, 0AEh, 0F7h, 6, 7Ch, 51h
	db	8, 0, 74h, 11h, 8Ah, 0C8h, 0B0h, 0Fh, 0E8h, 0FEh, 0B8h, 8Ah, 0C1h, 0Ch, 81h, 0E8h
	db	0F7h, 0B8h, 0E9h, 30h, 0AEh, 0B9h, 68h, 0, 0E8h, 2Ch, 0A9h, 0E9h, 27h, 0AEh, 0C6h, 6
	db	0FAh, 55h, 0FFh, 0E8h, 2Ch, 10h, 26h, 8Ah, 46h, 0, 0F7h, 6, 7Ch, 51h, 8, 0
	db	75h, 0Eh, 3Ch, 3, 75h, 18h, 26h, 0C6h, 46h, 0, 2, 0B8h, 2, 0, 0EBh, 23h
	db	3Ch, 5, 75h, 0Ah, 26h, 0C6h, 46h, 0, 3, 0B8h, 4, 0, 0EBh, 15h, 0E8h, 18h
	db	17h, 0B9h, 0, 8Fh, 0E8h, 2Bh, 7, 0E9h, 0EBh, 0ADh, 0B9h, 8Ch, 0, 0E8h, 0E7h, 0A8h
	db	0E9h, 0E2h, 0ADh, 0F7h, 6, 7Ch, 51h, 20h, 0, 74h, 0EFh, 56h, 50h, 6, 55h, 0E8h
	db	45h, 0CDh, 5Eh, 1Fh, 58h, 1Eh, 56h, 83h, 0C6h, 0, 8Bh, 0FDh, 83h, 0C7h, 0, 0B9h
	db	28h, 0, 0F3h, 0A4h, 26h, 0C6h, 46h, 0, 2, 26h, 1, 46h, 0Ah, 26h, 83h, 56h
	db	0Ch, 0, 26h, 80h, 56h, 24h, 0, 8Ch, 0C0h, 8Bh, 0FDh, 5Dh, 7, 50h, 57h, 16h
	db	1Fh, 0E8h, 0C5h, 16h, 0B9h, 0, 8Fh, 0E8h, 0D8h, 6, 0E8h, 98h, 0ADh, 0E8h, 5Bh, 0ADh
	db	5Dh, 7, 0E8h, 0B4h, 16h, 0B9h, 0, 8Fh, 0E8h, 0C7h, 6, 5Eh, 0E9h, 86h, 0ADh, 0E8h
	db	3Ch, 7, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 38h, 8, 0E8h, 7Bh, 11h, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 2Eh, 8, 0E8h, 5Bh, 11h, 0B0h, 0C8h, 0E8h, 2Eh, 0B8h, 0E8h, 0F9h, 18h, 0C4h, 2Eh
	db	0F6h, 55h, 0E8h, 0D0h, 18h, 0E9h, 5Dh, 0ADh, 0E8h, 13h, 7, 0E8h, 88h, 16h, 0EBh, 0D2h
	db	0E8h, 0Bh, 7, 0E8h, 92h, 16h, 0EBh, 0CAh, 0E8h, 2Bh, 7, 0C6h, 6, 0FAh, 55h, 0FFh
	db	0C4h, 2Eh, 0EEh, 55h, 0E8h, 0Dh, 8, 0E8h, 52h, 0Fh, 0C4h, 2Eh, 0F2h, 55h, 0E8h, 3
	db	8, 0E8h, 3Eh, 0Fh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0E6h, 7, 0E8h, 4Ah, 0Eh, 0C4h, 2Eh
	db	0F6h, 55h, 0E8h, 0C9h, 10h, 0E8h, 41h, 16h, 0B5h, 69h, 0E8h, 2, 14h, 72h, 1Bh, 80h
	db	0CDh, 2, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 58h, 4, 0C4h, 2Eh, 0F2h, 55h, 0E8h, 42h, 6
	db	0C4h, 2Eh, 0F6h, 55h, 0E8h, 6Eh, 18h, 0E9h, 0FBh, 0ACh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 40h
	db	4, 0C4h, 2Eh, 0F2h, 55h, 0E8h, 2Ah, 6, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 4Ah, 18h, 0E9h
	db	0E3h, 0ACh, 0E8h, 99h, 6, 0C6h, 6, 0FAh, 55h, 0FFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0A3h
	db	7, 0E8h, 0C2h, 14h, 0C4h, 2Eh, 0F6h, 55h, 72h, 49h, 0E8h, 84h, 7, 0E8h, 0CCh, 0Ah
	db	0C4h, 2Eh, 0EEh, 55h, 0E8h, 0D5h, 0Eh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 60h, 10h, 0E8h, 0D8h
	db	15h, 0B5h, 69h, 0E8h, 99h, 13h, 72h, 17h, 80h, 0CDh, 2, 0C4h, 2Eh, 0EEh, 55h, 0E8h
	db	0EFh, 3, 0E8h, 0DDh, 5, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 9, 18h, 0E9h, 96h, 0ACh, 0C4h
	db	2Eh, 0EEh, 55h, 0E8h, 0DBh, 3, 0E8h, 0C9h, 5, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0E9h, 17h
	db	0E9h, 82h, 0ACh, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 1Ch, 0E8h, 46h, 7, 0E8h, 8Dh
	db	0Bh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 91h, 15h, 0E8h, 0B6h, 3, 0B5h, 0AFh, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 0E0h, 5, 0E9h, 5Eh, 0ACh, 0B9h, 68h, 0, 0E8h, 5Ah, 0A7h, 0E9h, 55h, 0ACh
	db	0E8h, 0Bh, 6, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 7, 7, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 13h
	db	7, 0E8h, 0E0h, 7, 0E8h, 38h, 0Eh, 0E8h, 5Fh, 15h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 4Bh
	db	0Eh, 26h, 0F6h, 46h, 4, 40h, 74h, 14h, 26h, 8Bh, 46h, 0Eh, 3Bh, 6, 4Eh, 56h
	db	75h, 0Ah, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0B9h, 4, 0E9h, 19h, 0ACh, 0B8h, 65h, 0, 0E8h
	db	2Bh, 6, 0E9h, 10h, 0ACh, 0E8h, 0ACh, 5, 0E8h, 0D9h, 6, 0E8h, 93h, 8, 0E8h, 0FEh
	db	0Dh, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 18h, 26h, 8Ah, 46h, 5, 0A8h, 2, 75h
	db	15h, 0A8h, 1, 75h, 0Ch, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 5, 0E8h, 5Ch, 79h, 75h
	db	5, 0E8h, 12h, 15h, 0EBh, 3, 0E8h, 1Fh, 15h, 0E8h, 58h, 5, 0E9h, 0D6h, 0ABh, 0E8h
	db	72h, 5, 0E8h, 9Fh, 6, 0E8h, 27h, 7, 0E8h, 0D7h, 0Dh, 0E8h, 46h, 5, 0E9h, 0C4h
	db	0ABh, 0E8h, 7Ah, 5, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 89h, 6, 0C4h, 2Eh, 0F6h, 55h, 0E8h
	db	82h, 6, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 5, 0E8h, 1Fh, 0Ah, 0EBh, 3, 0E8h
	db	0BCh, 0Ah, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0A9h, 0Dh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0ACh, 0Dh
	db	8Ah, 0E9h, 0E8h, 0DCh, 2, 0E8h, 0B1h, 14h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0C3h, 4, 0E9h
	db	83h, 0ABh, 0E8h, 39h, 5, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 48h, 6, 0E8h, 0D0h, 6, 0C4h
	db	2Eh, 0F6h, 55h, 0E8h, 3Eh, 6, 0E8h, 0C6h, 6, 0E8h, 76h, 0Dh, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 79h, 0Dh, 8Ah, 0E9h, 0E8h, 0A9h, 2, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 93h, 4, 0E9h
	db	53h, 0ABh, 0E8h, 9, 5, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 18h, 6, 0C4h, 2Eh, 0F6h, 55h
	db	0E8h, 11h, 6, 0E8h, 58h, 0Ah, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 45h, 0Dh, 0C4h, 2Eh, 0EEh
	db	55h, 0E8h, 48h, 0Dh, 8Ah, 0E9h, 0E8h, 78h, 2, 0E8h, 4Dh, 14h, 0C4h, 2Eh, 0F6h, 55h
	db	0E8h, 0A1h, 4, 0E9h, 1Fh, 0ABh, 0E8h, 0D5h, 4, 0F6h, 0C1h, 18h, 74h, 5, 0C6h, 6
	db	0FAh, 55h, 0FFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0DAh, 5, 0E8h, 15h, 0Dh, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 0BDh, 5, 26h, 0F6h, 46h, 4, 40h, 75h, 1Ch, 0E8h, 0F9h, 0Eh, 0B5h, 0BAh
	db	0C4h, 2Eh, 0EEh, 55h, 0E8h, 4Ch, 6, 0E8h, 0Fh, 14h, 0E8h, 67h, 4, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 51h, 16h, 0E9h, 0DEh, 0AAh, 0E8h, 0F4h, 9, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0EBh
	db	0Ch, 8Ah, 0E9h, 80h, 0CDh, 83h, 0E8h, 18h, 2, 0E8h, 0EDh, 13h, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 41h, 4, 0E9h, 0BFh, 0AAh, 0E8h, 75h, 4, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 84h, 5
	db	0E8h, 0BFh, 0Ch, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 67h, 5, 0E8h, 0BFh, 0Ch, 0E8h, 0BEh, 9
	db	0C4h, 2Eh, 0EEh, 55h, 8Ah, 0E9h, 0E8h, 0E8h, 1, 0E8h, 0BDh, 13h, 0C4h, 2Eh, 0F6h, 55h
	db	0E8h, 11h, 4, 0E9h, 8Fh, 0AAh, 0E8h, 45h, 4, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 54h, 5
	db	0E8h, 8Fh, 0Ch, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 37h, 5, 0E8h, 8Fh, 0Ch, 0E8h, 18h, 0Bh
	db	0C4h, 2Eh, 0EEh, 55h, 8Ah, 0E9h, 0E8h, 0B8h, 1, 0E8h, 8Dh, 13h, 0C4h, 2Eh, 0F6h, 55h
	db	0E8h, 0D7h, 3, 0E9h, 5Fh, 0AAh, 0E8h, 0FBh, 3, 0C6h, 6, 0FAh, 55h, 0FFh, 0E8h, 23h
	db	5, 0E8h, 78h, 5, 0E8h, 5Bh, 0Ch, 8Ah, 0E9h, 32h, 0C9h, 0E8h, 0C6h, 3, 0E9h, 44h
	db	0AAh, 6, 55h, 8Eh, 0C0h, 8Bh, 0EFh, 5Fh, 58h, 0E8h, 1Ah, 4, 0C6h, 6, 0FAh, 55h
	db	0FFh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0FCh, 4, 0E8h, 37h, 0Ch, 0C4h, 2Eh, 0F6h, 55h, 0E8h
	db	0DFh, 4, 0E8h, 37h, 0Ch, 0E8h, 36h, 9, 8Ah, 0E9h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 60h
	db	1, 0E8h, 35h, 13h, 0C4h, 2Eh, 0F2h, 55h, 0E8h, 0C6h, 4, 26h, 8Ah, 46h, 4, 24h
	db	0C0h, 34h, 40h, 75h, 1Ah, 0E8h, 14h, 0Ch, 26h, 8Bh, 46h, 0Eh, 3Bh, 6, 10h, 56h
	db	75h, 21h, 80h, 0CDh, 1, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 68h, 3, 0E9h, 0E6h, 0A9h, 0E8h
	db	0E5h, 0Dh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 5Bh, 3, 0C4h, 2Eh, 0F2h, 55h, 0E8h, 45h, 15h
	db	0E9h, 0D2h, 0A9h, 0B8h, 67h, 0, 0E8h, 0E4h, 3, 0E9h, 0C9h, 0A9h, 0E8h, 8Ch, 0A9h, 0E8h
	db	6, 13h, 8Ah, 0C1h, 0E8h, 82h, 0B4h, 0E9h, 0BBh, 0A9h, 0E8h, 71h, 3, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 80h, 4, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 66h, 4, 0E8h, 40h, 9, 0C4h, 2Eh
	db	0EEh, 55h, 0E8h, 0B7h, 0Bh, 8Ah, 0E9h, 0E8h, 0E7h, 0, 0E8h, 0BCh, 12h, 0C4h, 2Eh, 0F6h
	db	55h, 0E8h, 8Bh, 0Bh, 0E8h, 0Dh, 3, 0E9h, 8Bh, 0A9h, 0E8h, 27h, 3, 0E8h, 54h, 4
	db	0E8h, 0E0h, 4, 0E8h, 96h, 0Bh, 0E8h, 0A0h, 12h, 0E8h, 0A9h, 0, 8Ah, 0C8h, 80h, 0C9h
	db	0C8h, 0B0h, 0Fh, 0E8h, 33h, 0B4h, 8Ah, 0C1h, 0E8h, 2Eh, 0B4h, 0E9h, 67h, 0A9h, 0E8h, 1Dh
	db	3, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 2Ch, 4, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 25h, 4, 0E8h
	db	0EAh, 6, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 59h, 0Bh, 0E8h, 6Dh, 12h, 0C4h, 2Eh, 0F6h, 55h
	db	0E8h, 59h, 0Bh, 0C6h, 6, 0FAh, 55h, 0FFh, 8Ah, 0E9h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 80h
	db	0, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0A2h, 2, 0E9h, 2Ah, 0A9h, 0E8h, 0C6h, 2, 0E8h, 0F3h
	db	3, 0E8h, 1Bh, 0Bh, 0B5h, 1, 0B1h, 38h, 0E8h, 99h, 2, 0E9h, 17h, 0A9h, 2Bh, 6
	db	0FEh, 55h, 0D1h, 0E8h, 3Dh, 8, 0, 72h, 0Bh, 2Dh, 8, 0, 3Dh, 16h, 0, 72h
	db	3, 2Dh, 16h, 0, 0C3h, 26h, 0F6h, 46h, 4, 40h, 74h, 21h, 26h, 8Bh, 46h, 0Eh
	db	0E8h, 0DBh, 0FFh, 24h, 6, 3Ch, 4, 74h, 18h, 26h, 0F6h, 46h, 4, 10h, 74h, 0Dh
	db	26h, 8Bh, 46h, 12h, 0E8h, 0C7h, 0FFh, 24h, 6, 3Ch, 4, 74h, 4, 0A1h, 0FCh, 55h
	db	0C3h, 0A1h, 5Eh, 56h, 0C3h, 26h, 0F6h, 46h, 4, 40h, 74h, 0Bh, 26h, 8Bh, 46h, 0Eh
	db	0E8h, 0ABh, 0FFh, 3Ch, 8, 73h, 1, 0C3h, 0B8h, 3Eh, 0, 0E8h, 0CFh, 2, 32h, 0C0h
	db	0C3h, 0E8h, 0E1h, 0FFh, 0D0h, 0E0h, 0D0h, 0E0h, 0D0h, 0E0h, 8Ah, 0C8h, 0C3h, 26h, 80h, 7Eh
	db	0, 1, 74h, 3, 80h, 0C9h, 1, 8Ah, 0C1h, 0E8h, 5Dh, 0B3h, 0E9h, 0FAh, 13h, 26h
	db	8Ah, 46h, 0, 3Ch, 2, 74h, 27h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 1Ch, 3Ch
	db	5, 74h, 23h, 26h, 8Ah, 46h, 5, 0A8h, 2, 75h, 1Eh, 0A8h, 1, 75h, 0Ch, 0A1h
	db	7Eh, 51h, 23h, 0C0h, 74h, 5, 0E8h, 0E2h, 75h, 75h, 0Eh, 80h, 0C9h, 8, 0E8h, 95h
	db	11h, 0B5h, 0FFh, 0E9h, 9Ch, 1, 80h, 0C9h, 8, 0E8h, 9Ch, 11h, 0B5h, 0FFh, 0E9h, 91h
	db	1, 0E8h, 7Ah, 0, 0E8h, 0E5h, 0Eh, 0E8h, 0A4h, 10h, 0FEh, 0C0h, 32h, 0E4h, 26h, 29h
	db	46h, 0Ah, 26h, 83h, 5Eh, 0Ch, 0, 26h, 80h, 5Eh, 24h, 0, 0E8h, 6Ch, 10h, 73h
	db	0Eh, 0E8h, 0B4h, 0Dh, 0E8h, 71h, 11h, 8Ah, 0C1h, 0E8h, 0EDh, 0B2h, 0E9h, 0C4h, 13h, 0E8h
	db	46h, 0Dh, 0E8h, 51h, 11h, 8Ah, 0C1h, 0E8h, 0DFh, 0B2h, 0E9h, 0AAh, 13h, 0E8h, 4Bh, 10h
	db	73h, 0Eh, 0E8h, 0C4h, 0Ah, 0E8h, 50h, 11h, 8Ah, 0C1h, 0E8h, 0CCh, 0B2h, 0E9h, 0F1h, 13h
	db	0E8h, 0F3h, 0Ah, 0E8h, 30h, 11h, 8Ah, 0C1h, 0E8h, 0BEh, 0B2h, 0E9h, 0A5h, 13h, 0E8h, 1Dh
	db	0, 0E8h, 88h, 0Eh, 26h, 83h, 6Eh, 0Ah, 2, 26h, 83h, 5Eh, 0Ch, 0, 26h, 80h
	db	5Eh, 24h, 0, 0E8h, 8Eh, 0Ch, 8Ah, 0C1h, 0E8h, 9Eh, 0B2h, 0E9h, 47h, 13h, 0A1h, 7Eh
	db	51h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 28h, 6, 55h, 0A1h, 5Ch, 56h, 9Ah
	dd	L101E0
	db	51h, 0E8h, 18h, 88h, 59h, 9Ah
	dd	L101E0
	db	26h, 83h, 7Eh, 6, 0, 75h, 42h, 26h, 8Bh, 46h, 1Ah, 26h, 0F6h, 46h, 4, 4
	db	5Dh, 7, 74h, 38h, 23h, 0C0h, 74h, 34h, 8Bh, 0D0h, 26h, 8Bh, 46h, 18h, 23h, 0C0h
	db	74h, 2Ah, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 0BBh, 83h, 0E8h, 9Fh, 83h, 92h, 9Ah
	dd	L101E0
	db	0E8h, 0AFh, 83h, 0E8h, 93h, 83h, 5Dh, 7, 3Bh, 0C2h, 74h, 7, 8Bh, 0C2h, 0E8h, 0C2h
	db	74h, 74h, 4, 0C3h, 5Dh, 7, 0C3h, 51h, 0B9h, 88h, 0, 0E8h, 67h, 0A2h, 59h, 0C3h
	db	0E8h, 0B5h, 10h, 26h, 80h, 7Eh, 0, 1, 74h, 3, 80h, 0C9h, 1, 8Ah, 0C1h, 0E9h
	db	15h, 0B2h, 26h, 80h, 7Eh, 0, 3, 74h, 3, 80h, 0CDh, 4, 0F7h, 6, 7Ch, 51h
	db	40h, 0, 74h, 63h, 26h, 83h, 7Eh, 6, 0, 75h, 64h, 0E8h, 0CCh, 10h, 74h, 41h
	db	0E8h, 19h, 0FEh, 2Ch, 8, 98h, 0D1h, 0E0h, 8Bh, 0D8h, 8Bh, 0BFh, 0ECh, 1Ch, 23h, 0FFh
	db	74h, 5, 53h, 0E8h, 43h, 16h, 5Bh, 53h, 0B0h, 9Bh, 0E8h, 0DAh, 0B1h, 5Bh, 8Bh, 0BFh
	db	0F8h, 1Ch, 23h, 0FFh, 74h, 5, 53h, 0E8h, 2Fh, 16h, 5Bh, 8Ah, 0C3h, 0D0h, 0E8h, 0BBh
	db	0E6h, 1Ch, 0D7h, 0E8h, 3Fh, 0B1h, 0E8h, 0F4h, 0Fh, 8Ah, 0C5h, 0E8h, 0B9h, 0B1h, 0E9h, 22h
	db	13h, 0BFh, 74h, 56h, 0E8h, 12h, 16h, 0B0h, 9Bh, 0E8h, 0ABh, 0B1h, 0E8h, 0DEh, 0Fh, 8Ah
	db	0C5h, 0E8h, 0A3h, 0B1h, 0E9h, 0Ch, 13h, 0F7h, 6, 7Ch, 51h, 0, 4, 75h, 11h, 0B0h
	db	9Bh, 0E8h, 93h, 0B1h, 0EBh, 0Ah, 26h, 80h, 7Eh, 0, 1, 74h, 3, 80h, 0CDh, 1
	db	0E8h, 15h, 10h, 8Ah, 0C5h, 0E8h, 7Fh, 0B1h, 0E9h, 0E8h, 12h, 0F7h, 6, 7Ch, 51h, 40h
	db	0, 74h, 8, 0BFh, 74h, 56h, 0E8h, 0D0h, 15h, 0EBh, 8, 0F7h, 6, 7Ch, 51h, 0
	db	4, 75h, 5, 0B0h, 9Bh, 0E8h, 5Fh, 0B1h, 8Ah, 0C5h, 0E8h, 5Ah, 0B1h, 8Ah, 0C1h, 0Ch
	db	0C0h, 26h, 0Ah, 46h, 0Ah, 0E9h, 4Fh, 0B1h, 26h, 80h, 7Eh, 0, 1, 74h, 3, 80h
	db	0CDh, 1, 0E8h, 0D3h, 0Fh, 0B0h, 0Fh, 0E8h, 3Dh, 0B1h, 8Ah, 0C5h, 0E8h, 38h, 0B1h, 0E9h
	db	0A1h, 12h, 89h, 2Eh, 0EEh, 55h, 8Ch, 6, 0F0h, 55h, 6, 55h, 0E8h, 2Ah, 0A6h, 5Dh
	db	7, 0C3h, 0C6h, 6, 0FAh, 55h, 0, 89h, 2Eh, 0EEh, 55h, 8Ch, 6, 0F0h, 55h, 0E8h
	db	17h, 0A6h, 0C4h, 2Eh, 0EEh, 55h, 51h, 0E8h, 53h, 17h, 59h, 0C3h, 0C6h, 6, 0FAh, 55h
	db	0, 89h, 3Eh, 0EEh, 55h, 0A3h, 0F0h, 55h, 89h, 2Eh, 0F6h, 55h, 8Ch, 6, 0F8h, 55h
	db	0E8h, 0F6h, 0A5h, 0C4h, 2Eh, 0EEh, 55h, 51h, 0E8h, 32h, 17h, 0C4h, 2Eh, 0F6h, 55h, 0E8h
	db	2Bh, 17h, 59h, 0C3h, 0C6h, 6, 0FAh, 55h, 0, 89h, 1Eh, 0EEh, 55h, 89h, 16h, 0F0h
	db	55h, 89h, 3Eh, 0F2h, 55h, 0A3h, 0F4h, 55h, 89h, 2Eh, 0F6h, 55h, 8Ch, 6, 0F8h, 55h
	db	0E8h, 0C6h, 0A5h, 0C4h, 2Eh, 0EEh, 55h, 51h, 0E8h, 2, 17h, 0C4h, 2Eh, 0F2h, 55h, 0E8h
	db	0FBh, 16h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 0F4h, 16h, 59h, 0C3h, 51h, 8Bh, 0C8h, 0E8h, 0E4h
	db	0A0h, 59h, 0C3h, 51h, 8Bh, 0C8h, 0E8h, 48h, 16h, 59h, 0C3h, 26h, 0F6h, 46h, 24h, 80h
	db	74h, 11h, 0BAh, 0FFh, 0FFh, 33h, 0C2h, 8Bh, 0F8h, 26h, 2Bh, 7Eh, 0Ah, 26h, 1Bh, 56h
	db	0Ch, 0EBh, 0Dh, 26h, 8Bh, 7Eh, 0Ah, 2Bh, 0F8h, 26h, 8Bh, 56h, 0Ch, 83h, 0DAh, 0
	db	0B8h, 33h, 8, 51h, 8Bh, 0C8h, 0E8h, 86h, 16h, 59h, 0C3h, 26h, 8Ah, 46h, 0, 3Ch
	db	80h, 74h, 0Eh, 3Ch, 87h, 74h, 9, 3Ch, 88h, 74h, 5, 3Ch, 89h, 74h, 1, 0F9h
	db	0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 0F7h, 26h, 83h, 7Eh, 14h, 0, 74h, 0F0h
	db	0F9h, 0C3h, 26h, 8Ah, 46h, 0, 3Ch, 80h, 74h, 0Ah, 3Ch, 88h, 74h, 5, 3Ch, 89h
	db	74h, 1, 0F9h, 0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 0F7h, 26h, 83h, 7Eh, 14h
	db	0, 74h, 0F0h, 0F9h, 0C3h, 26h, 8Ah, 46h, 0, 0A8h, 80h, 74h, 1, 0C3h, 26h, 0C6h
	db	46h, 0, 0, 0E8h, 0B9h, 0DCh, 0E8h, 45h, 0DDh, 0B8h, 42h, 0, 0E9h, 5Ch, 0FFh, 26h
	db	0F6h, 46h, 0, 80h, 75h, 1, 0C3h, 51h, 0E8h, 22h, 0D5h, 59h, 0B8h, 15h, 0, 0E9h
	db	49h, 0FFh, 26h, 0F6h, 46h, 0, 80h, 75h, 1, 0C3h, 0E8h, 0E4h, 0C7h, 0F7h, 6, 7Ch
	db	51h, 0, 10h, 75h, 1, 0C3h, 0F7h, 6, 82h, 51h, 1, 0, 74h, 0F7h, 0B8h, 40h
	db	80h, 0E9h, 27h, 0FFh, 0E8h, 0AEh, 0FFh, 26h, 8Ah, 46h, 0, 3Ch, 80h, 74h, 0Ch, 3Ch
	db	87h, 74h, 8, 3Ch, 88h, 74h, 4, 3Ch, 89h, 75h, 1, 0C3h, 26h, 0C6h, 46h, 0
	db	80h, 0B8h, 16h, 0, 0E9h, 4, 0FFh, 26h, 80h, 7Eh, 0, 4, 73h, 1, 0C3h, 26h
	db	0C6h, 46h, 0, 0, 0B8h, 16h, 0, 0E9h, 0F1h, 0FEh, 0B0h, 1, 26h, 80h, 7Eh, 0
	db	0, 74h, 4, 26h, 38h, 46h, 0, 26h, 88h, 46h, 0, 75h, 1, 0C3h, 0B8h, 16h
	db	0, 0E9h, 0D7h, 0FEh, 0E8h, 0CBh, 0Ah, 72h, 9, 26h, 8Ah, 46h, 0, 3Ch, 3, 73h
	db	0CEh, 0C3h, 26h, 0C6h, 46h, 0, 2, 0B8h, 20h, 80h, 0E9h, 0BEh, 0FEh, 0B0h, 2, 0EBh
	db	0CBh, 0E8h, 0AEh, 0Ah, 72h, 1Ah, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 25h, 3Ch, 4
	db	73h, 21h, 3Ch, 3, 74h, 1, 0C3h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 14h, 0C3h
	db	0F7h, 6, 7Ch, 51h, 8, 0, 74h, 5, 0B8h, 20h, 80h, 0EBh, 9, 26h, 0C6h, 46h
	db	0, 2, 0C3h, 0B8h, 16h, 0, 50h, 0E8h, 51h, 0Dh, 26h, 88h, 46h, 0, 58h, 0E9h
	db	79h, 0FEh, 0E8h, 6Dh, 0Ah, 72h, 16h, 26h, 8Ah, 46h, 0, 3Ch, 4, 73h, 13h, 3Ch
	db	3, 74h, 1, 0C3h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 6, 0C3h, 0B8h, 20h, 80h
	db	0EBh, 0D4h, 0B8h, 16h, 0, 0EBh, 0CFh, 0B0h, 6, 0E9h, 60h, 0FFh, 0E8h, 43h, 0Ah, 72h
	db	11h, 26h, 8Ah, 46h, 0, 3Ch, 3, 72h, 0Eh, 3Ch, 5, 73h, 0Ah, 3Ch, 5, 74h
	db	6, 0C3h, 0B8h, 20h, 80h, 0EBh, 3, 0B8h, 16h, 0, 26h, 0C6h, 46h, 0, 4, 0E9h
	db	29h, 0FEh, 0E8h, 1Dh, 0Ah, 72h, 11h, 26h, 8Ah, 46h, 0, 3Ch, 3, 72h, 0Eh, 3Ch
	db	7, 73h, 0Ah, 3Ch, 5, 74h, 6, 0C3h, 0B8h, 20h, 80h, 0EBh, 0DDh, 0B8h, 16h, 0
	db	0EBh, 0D8h, 0E8h, 0FDh, 9, 72h, 11h, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 0Eh, 3Ch
	db	5, 73h, 0Ah, 3Ch, 5, 74h, 6, 0C3h, 0B8h, 20h, 80h, 0EBh, 0BDh, 0B8h, 16h, 0
	db	0EBh, 0B8h, 0E8h, 0DDh, 9, 72h, 0Dh, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 0Ah, 3Ch
	db	4, 73h, 6, 0C3h, 0B8h, 20h, 80h, 0EBh, 3, 0B8h, 16h, 0, 26h, 0C6h, 46h, 0
	db	3, 0E9h, 0C7h, 0FDh, 0E8h, 0BBh, 9, 72h, 1Ah, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h
	db	28h, 3Ch, 6, 73h, 24h, 3Ch, 5, 74h, 1, 0C3h, 0F7h, 6, 7Ch, 51h, 8, 0
	db	74h, 17h, 0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 8, 0E8h, 6Dh, 0Ch, 26h, 88h
	db	46h, 0, 0C3h, 0B8h, 20h, 80h, 0E9h, 0Dh, 0FFh, 0B8h, 16h, 0, 0E9h, 7, 0FFh, 0E8h
	db	80h, 9, 72h, 0Dh, 26h, 8Ah, 46h, 0, 3Ch, 4, 72h, 18h, 3Ch, 6, 73h, 14h
	db	0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 6, 26h, 0C6h, 46h, 0, 5, 0C3h, 0B8h
	db	20h, 80h, 0EBh, 3, 0B8h, 16h, 0, 26h, 0C6h, 46h, 0, 5, 0E9h, 5Ch, 0FDh, 0E8h
	db	81h, 9, 72h, 16h, 26h, 8Ah, 46h, 0, 3Ch, 4, 73h, 1Eh, 3Ch, 3, 74h, 1
	db	0C3h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 11h, 0C3h, 0E8h, 5Ch, 0Bh, 26h, 0C6h, 46h
	db	0, 2, 73h, 5, 26h, 0C6h, 46h, 0, 3, 0C3h, 0B8h, 16h, 0, 0E9h, 0A6h, 0FEh
	db	0E8h, 1Fh, 9, 72h, 1Ah, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 26h, 3Ch, 5, 74h
	db	5, 3Ch, 4, 73h, 1Eh, 0C3h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 15h, 0C3h, 0F7h
	db	6, 7Ch, 51h, 8, 0, 74h, 6, 0B8h, 20h, 80h, 0E9h, 79h, 0FEh, 26h, 0C6h, 46h
	db	0, 2, 0C3h, 0B8h, 16h, 0, 0E9h, 6Dh, 0FEh, 0E8h, 0E6h, 8, 72h, 18h, 26h, 8Ah
	db	46h, 0, 3Ch, 2, 72h, 11h, 3Ch, 4, 73h, 0Dh, 0F7h, 6, 7Ch, 51h, 8, 0
	db	75h, 4, 3Ch, 3, 74h, 1, 0C3h, 0B8h, 16h, 0, 0E9h, 49h, 0FEh, 0C4h, 2Eh, 0EEh
	db	55h, 0E8h, 0BEh, 8, 72h, 15h, 26h, 8Ah, 46h, 0, 3Ch, 4, 73h, 32h, 0C4h, 2Eh
	db	0F6h, 55h, 26h, 88h, 46h, 0, 3Ch, 3, 74h, 18h, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 0E8h
	db	0D1h, 8, 72h, 21h, 26h, 8Ah, 46h, 0, 3Ch, 4, 73h, 14h, 0C4h, 2Eh, 0EEh, 55h
	db	0EBh, 0E0h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 6, 0C3h, 0B8h, 41h, 0, 0EBh, 62h
	db	0B8h, 16h, 0, 0EBh, 5Dh, 0B8h, 20h, 80h, 0EBh, 58h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 71h
	db	8, 72h, 22h, 26h, 8Ah, 46h, 0, 3Ch, 4, 73h, 3Fh, 0C4h, 2Eh, 0F6h, 55h, 50h
	db	0E8h, 5Fh, 8, 58h, 72h, 6, 26h, 3Ah, 46h, 0, 75h, 29h, 26h, 88h, 46h, 0
	db	3Ch, 3, 74h, 18h, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 46h, 8, 72h, 21h, 26h, 8Ah
	db	46h, 0, 3Ch, 4, 73h, 14h, 0C4h, 2Eh, 0EEh, 55h, 0EBh, 0E0h, 0F7h, 6, 7Ch, 51h
	db	8, 0, 74h, 6, 0C3h, 0B8h, 41h, 0, 0EBh, 8, 0B8h, 16h, 0, 0EBh, 3, 0B8h
	db	20h, 80h, 50h, 0E8h, 0F5h, 0Ah, 0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 0C4h, 2Eh
	db	0F6h, 55h, 26h, 88h, 46h, 0, 58h, 0E9h, 11h, 0FCh, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 1
	db	8, 72h, 19h, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 3Ah, 3Ch, 4, 73h, 36h, 0C4h
	db	2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 3Ch, 3, 74h, 1Ch, 0C3h, 0C4h, 2Eh, 0F6h, 55h
	db	0E8h, 10h, 8, 72h, 25h, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 18h, 3Ch, 4, 73h
	db	14h, 0C4h, 2Eh, 0EEh, 55h, 0EBh, 0DCh, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 6, 0C3h
	db	0B8h, 20h, 0, 0EBh, 9Dh, 0B8h, 16h, 0, 0EBh, 98h, 0F7h, 6, 7Ch, 51h, 8, 0
	db	74h, 5, 0B8h, 20h, 80h, 0EBh, 8Bh, 0C4h, 2Eh, 0EEh, 55h, 26h, 0C6h, 46h, 0, 2
	db	0C4h, 2Eh, 0F6h, 55h, 26h, 0C6h, 46h, 0, 2, 0C3h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 91h
	db	7, 72h, 28h, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 52h, 3Ch, 4, 73h, 4Eh, 0FEh
	db	0C0h, 0C4h, 2Eh, 0F6h, 55h, 50h, 0E8h, 79h, 7, 58h, 72h, 6, 26h, 3Ah, 46h, 0
	db	75h, 36h, 26h, 88h, 46h, 0, 3Ch, 4, 74h, 25h, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 0E8h
	db	60h, 7, 72h, 2Eh, 26h, 8Ah, 46h, 0, 3Ch, 3, 72h, 21h, 3Ch, 5, 73h, 1Dh
	db	0FEh, 0C8h, 0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 3Ch, 3, 74h, 1, 0C3h, 0F7h
	db	6, 7Ch, 51h, 8, 0, 74h, 6, 0C3h, 0B8h, 20h, 0, 0EBh, 25h, 0B8h, 16h, 0
	db	0EBh, 20h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 5, 0B8h, 20h, 80h, 0EBh, 13h, 0C4h
	db	2Eh, 0EEh, 55h, 26h, 0C6h, 46h, 0, 2, 0C4h, 2Eh, 0F6h, 55h, 26h, 0C6h, 46h, 0
	db	3, 0C3h, 50h, 0E8h, 0E5h, 9, 0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 0FEh, 0C0h
	db	0C4h, 2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 58h, 0E9h, 0FFh, 0FAh, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 0EFh, 6, 72h, 26h, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 48h, 3Ch, 4, 73h
	db	44h, 0C4h, 2Eh, 0F6h, 55h, 50h, 0E8h, 0D9h, 6, 58h, 72h, 6, 26h, 3Ah, 46h, 0
	db	75h, 2Dh, 26h, 88h, 46h, 0, 3Ch, 3, 74h, 1Ch, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 0E8h
	db	0C0h, 6, 72h, 27h, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 19h, 3Ch, 4, 73h, 15h
	db	0C4h, 2Eh, 0EEh, 55h, 0EBh, 0DCh, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 7, 0C3h, 0B8h
	db	20h, 0, 0E9h, 7Dh, 0FEh, 0B8h, 16h, 0, 0E9h, 77h, 0FEh, 0F7h, 6, 7Ch, 51h, 8
	db	0, 74h, 6, 0B8h, 20h, 80h, 0E9h, 69h, 0FEh, 0C4h, 2Eh, 0EEh, 55h, 26h, 0C6h, 46h
	db	0, 2, 0C4h, 2Eh, 0F6h, 55h, 26h, 0C6h, 46h, 0, 2, 0C3h, 0C4h, 2Eh, 0EEh, 55h
	db	0E8h, 6Fh, 6, 72h, 2Eh, 26h, 8Ah, 46h, 0, 3Ch, 2, 72h, 64h, 3Ch, 4, 73h
	db	60h, 0FEh, 0C0h, 3Ch, 4, 75h, 2, 0FEh, 0C0h, 0C4h, 2Eh, 0F6h, 55h, 50h, 0E8h, 51h
	db	6, 58h, 72h, 6, 26h, 3Ah, 46h, 0, 75h, 35h, 26h, 88h, 46h, 0, 3Ch, 5
	db	74h, 44h, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 38h, 6, 72h, 28h, 26h, 8Ah, 46h, 0
	db	3Ch, 3, 72h, 2Dh, 3Ch, 6, 73h, 29h, 3Ch, 4, 74h, 25h, 72h, 2, 0FEh, 0C8h
	db	0FEh, 0C8h, 0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 3Ch, 3, 74h, 18h, 0C3h, 0B8h
	db	41h, 0, 0EBh, 2Eh, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 13h, 0B8h, 20h, 80h, 0EBh
	db	21h, 0B8h, 16h, 0, 0EBh, 1Ch, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 0F3h, 0C3h, 0C4h
	db	2Eh, 0EEh, 55h, 26h, 0C6h, 46h, 0, 2, 0C4h, 2Eh, 0F6h, 55h, 26h, 0C6h, 46h, 0
	db	3, 0C3h, 50h, 0E8h, 0B5h, 8, 0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 0FEh, 0C0h
	db	3Ch, 4, 75h, 2, 0FEh, 0C0h, 0C4h, 2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 58h, 0E9h
	db	0C9h, 0F9h, 0C4h, 2Eh, 0EEh, 55h, 26h, 8Ah, 46h, 0, 3Ch, 0, 74h, 16h, 3Ch, 4
	db	73h, 27h, 0C4h, 2Eh, 0F6h, 55h, 26h, 80h, 7Eh, 0, 0, 74h, 17h, 26h, 3Ah, 46h
	db	0, 75h, 1Bh, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 26h, 8Ah, 46h, 0, 3Ch, 4, 73h, 9
	db	0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 0C3h, 0B8h, 16h, 0, 0EBh, 3, 0B8h, 41h
	db	0, 0C4h, 2Eh, 0EEh, 55h, 26h, 0C6h, 46h, 0, 0, 0C4h, 2Eh, 0F6h, 55h, 26h, 0C6h
	db	46h, 0, 0, 0E9h, 75h, 0F9h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 65h, 5, 72h, 2Ah, 26h
	db	8Ah, 46h, 0, 3Ch, 2, 72h, 4Bh, 3Ch, 4, 73h, 47h, 0C4h, 2Eh, 0F6h, 55h, 50h
	db	0E8h, 4Fh, 5, 58h, 72h, 32h, 26h, 8Ah, 66h, 0, 80h, 0FCh, 1, 74h, 9, 80h
	db	0FCh, 2, 75h, 2Eh, 3Ch, 3, 75h, 2Fh, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 32h, 5
	db	72h, 2Ah, 26h, 8Ah, 46h, 0, 3Ch, 3, 73h, 18h, 3Ch, 1, 74h, 1Eh, 0C4h, 2Eh
	db	0EEh, 55h, 26h, 0C6h, 46h, 0, 3, 0C3h, 3Ch, 3, 74h, 1Fh, 26h, 0C6h, 46h, 0
	db	1, 0C3h, 0B8h, 16h, 0, 0EBh, 8Ah, 0B8h, 41h, 0, 0EBh, 85h, 0E8h, 0DCh, 7, 0C4h
	db	2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 0C4h, 2Eh, 0F6h, 55h, 26h, 0C6h, 46h, 0, 1
	db	0B8h, 20h, 80h, 0E9h, 0F5h, 0F8h, 0C4h, 2Eh, 0EEh, 55h, 0E8h, 0E5h, 4, 72h, 45h, 26h
	db	8Ah, 46h, 0, 3Ch, 2, 72h, 26h, 3Ch, 4, 73h, 22h, 0C4h, 2Eh, 0F2h, 55h, 50h
	db	0E8h, 0CFh, 4, 58h, 73h, 4, 26h, 88h, 46h, 0, 26h, 3Ah, 46h, 0, 75h, 12h
	db	0C4h, 2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 3Ch, 3, 74h, 5Ch, 0C3h, 0B8h, 16h, 0
	db	0EBh, 7Bh, 0B8h, 41h, 0, 0EBh, 76h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 52h, 0B8h
	db	20h, 80h, 0EBh, 69h, 0C4h, 2Eh, 0F2h, 55h, 0E8h, 97h, 4, 72h, 16h, 26h, 8Ah, 46h
	db	0, 3Ch, 2, 72h, 0D8h, 3Ch, 4, 73h, 0D4h, 0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h
	db	0, 0EBh, 0BDh, 0C4h, 2Eh, 0F6h, 55h, 0E8h, 78h, 4, 72h, 0CBh, 26h, 8Ah, 46h, 0
	db	3Ch, 2, 72h, 0B9h, 3Ch, 4, 73h, 0B5h, 0C4h, 2Eh, 0F2h, 55h, 26h, 88h, 46h, 0
	db	0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 9Dh
	db	0C3h, 0E8h, 27h, 7, 0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 0C4h, 2Eh, 0F2h, 55h
	db	26h, 88h, 46h, 0, 0C4h, 2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 0C3h, 50h, 0E8h, 0Ah
	db	7, 0C4h, 2Eh, 0EEh, 55h, 26h, 88h, 46h, 0, 0C4h, 2Eh, 0F2h, 55h, 26h, 88h, 46h
	db	0, 0C4h, 2Eh, 0F6h, 55h, 26h, 88h, 46h, 0, 58h, 0E9h, 1Eh, 0F8h, 26h, 0F6h, 46h
	db	4, 80h, 74h, 1, 0C3h, 26h, 80h, 4Eh, 4, 80h, 0B8h, 18h, 0, 0E9h, 0Bh, 0F8h
	db	26h, 8Ah, 46h, 4, 24h, 0C0h, 34h, 40h, 75h, 0E3h, 26h, 8Ah, 46h, 4, 34h, 40h
	db	75h, 0Bh, 26h, 8Bh, 46h, 0Ah, 26h, 0Bh, 46h, 0Ch, 75h, 61h, 0C3h, 26h, 0F6h, 46h
	db	4, 80h, 74h, 0Bh, 0B8h, 1Eh, 0, 0E8h, 0E1h, 0F7h, 26h, 80h, 66h, 4, 7Fh, 26h
	db	0F6h, 46h, 4, 20h, 74h, 11h, 0B8h, 1Dh, 0, 0E8h, 0CFh, 0F7h, 26h, 0C7h, 46h, 10h
	db	1, 0, 26h, 80h, 66h, 4, 0DFh, 26h, 0F6h, 46h, 4, 40h, 75h, 6, 0B8h, 3Dh
	db	0, 0E8h, 0B7h, 0F7h, 26h, 0F6h, 46h, 4, 10h, 74h, 11h, 0B8h, 1Ch, 0, 0E8h, 0AAh
	db	0F7h, 26h, 0C7h, 46h, 12h, 0, 0, 26h, 80h, 66h, 4, 0EFh, 26h, 0F6h, 46h, 4
	db	5, 75h, 0Ah, 26h, 8Bh, 46h, 0Ah, 26h, 0Bh, 46h, 0Ch, 74h, 29h, 0B8h, 23h, 0
	db	0E8h, 88h, 0F7h, 26h, 80h, 66h, 4, 0F8h, 33h, 0C0h, 26h, 89h, 46h, 8, 26h, 89h
	db	46h, 0Ah, 26h, 89h, 46h, 0Ch, 26h, 88h, 46h, 24h, 26h, 88h, 46h, 1, 26h, 89h
	db	46h, 1Ah, 26h, 89h, 46h, 18h, 0C3h, 26h, 0F6h, 46h, 4, 0F8h, 75h, 1, 0C3h, 26h
	db	0F6h, 46h, 4, 80h, 74h, 0Bh, 26h, 80h, 66h, 4, 7Fh, 0B8h, 1Eh, 0, 0E8h, 4Ah
	db	0F7h, 26h, 0F6h, 46h, 4, 40h, 74h, 1Bh, 0B8h, 19h, 0, 0E8h, 3Dh, 0F7h, 26h, 80h
	db	66h, 4, 8Fh, 33h, 0C0h, 26h, 89h, 46h, 0Eh, 26h, 89h, 46h, 12h, 26h, 0C7h, 46h
	db	10h, 1, 0, 0C3h, 26h, 0F6h, 46h, 4, 0F8h, 75h, 0Ch, 26h, 8Ah, 46h, 24h, 98h
	db	26h, 3Bh, 46h, 0Ch, 75h, 6, 0C3h, 0E8h, 0B5h, 0FFh, 0EBh, 0EFh, 0B8h, 3Fh, 0, 0E9h
	db	41h, 0F7h, 26h, 0F6h, 46h, 4, 0F8h, 75h, 36h, 26h, 8Ah, 46h, 1, 24h, 7, 74h
	db	22h, 3Ch, 2, 74h, 0Bh, 3Ch, 3, 75h, 1Ah, 26h, 80h, 6Eh, 1, 2, 0EBh, 13h
	db	26h, 80h, 66h, 4, 0FBh, 33h, 0C0h, 26h, 88h, 46h, 1, 26h, 89h, 46h, 1Ah, 26h
	db	89h, 46h, 18h, 26h, 8Ah, 46h, 24h, 98h, 26h, 3Bh, 46h, 0Ch, 75h, 6, 0C3h, 0E8h
	db	6Dh, 0FFh, 0EBh, 0C5h, 0B8h, 3Fh, 0, 0E9h, 0F9h, 0F6h, 26h, 0F6h, 46h, 4, 0F8h, 75h
	db	2Ah, 26h, 8Ah, 46h, 1, 24h, 7, 74h, 0Dh, 3Ch, 2, 74h, 0Ah, 3Ch, 3, 75h
	db	5, 26h, 80h, 6Eh, 1, 2, 0C3h, 26h, 80h, 66h, 4, 0FBh, 33h, 0C0h, 26h, 88h
	db	46h, 1, 26h, 89h, 46h, 1Ah, 26h, 89h, 46h, 18h, 0C3h, 0E8h, 31h, 0FFh, 0EBh, 0D1h
	db	26h, 0F6h, 46h, 4, 0F8h, 75h, 8, 26h, 0F6h, 46h, 4, 4, 75h, 6, 0C3h, 0E8h
	db	1Dh, 0FFh, 0EBh, 0F3h, 0B8h, 6Eh, 0, 0E8h, 71h, 0F6h, 0EBh, 2Ah, 26h, 8Ah, 46h, 0
	db	3Ch, 2, 74h, 3Bh, 3Ch, 1, 74h, 4Dh, 26h, 0F6h, 46h, 4, 0F8h, 75h, 2Bh, 26h
	db	8Ah, 46h, 1, 24h, 7, 74h, 22h, 3Ch, 2, 74h, 0Bh, 3Ch, 3, 75h, 1Ah, 26h
	db	80h, 6Eh, 1, 2, 0EBh, 13h, 26h, 80h, 66h, 4, 0FBh, 33h, 0C0h, 26h, 88h, 46h
	db	1, 26h, 89h, 46h, 1Ah, 26h, 89h, 46h, 18h, 0C3h, 0E8h, 0D2h, 0FEh, 0EBh, 0D0h, 0E8h
	db	0C6h, 0FFh, 26h, 83h, 7Eh, 6, 0, 75h, 0Bh, 26h, 8Ah, 46h, 24h, 98h, 26h, 3Bh
	db	46h, 0Ch, 75h, 39h, 0C3h, 0E8h, 0B0h, 0FFh, 26h, 8Ah, 46h, 1, 24h, 7, 74h, 15h
	db	3Ch, 4, 74h, 0Bh, 3Ch, 1, 75h, 0Dh, 26h, 80h, 6Eh, 1, 0FCh, 0EBh, 6, 0B8h
	db	71h, 0, 0E8h, 0FEh, 0F5h, 26h, 83h, 7Eh, 6, 0, 75h, 17h, 26h, 8Ah, 46h, 24h
	db	98h, 26h, 3Bh, 46h, 0Ch, 75h, 6, 26h, 3Ah, 46h, 0Bh, 74h, 6, 0B8h, 3Fh, 0
	db	0E9h, 10h, 0F6h, 0C3h, 0E8h, 71h, 0FFh, 26h, 0F6h, 46h, 4, 4, 74h, 6, 0B8h, 6Eh
	db	0, 0E8h, 0CFh, 0F5h, 26h, 83h, 7Eh, 6, 0, 75h, 1Fh, 26h, 8Ah, 46h, 24h, 98h
	db	26h, 3Bh, 46h, 0Ch, 75h, 0Eh, 26h, 3Ah, 46h, 0Bh, 75h, 8, 26h, 32h, 46h, 0Ah
	db	24h, 0C0h, 74h, 6, 0B8h, 3Fh, 0, 0E9h, 0D9h, 0F5h, 0C3h, 0E8h, 3Ah, 0FFh, 26h, 0F6h
	db	46h, 4, 4, 74h, 6, 0B8h, 6Eh, 0, 0E8h, 98h, 0F5h, 26h, 83h, 7Eh, 6, 0
	db	75h, 1Fh, 26h, 8Ah, 46h, 24h, 98h, 26h, 3Bh, 46h, 0Ch, 75h, 0Eh, 26h, 3Ah, 46h
	db	0Bh, 75h, 8, 26h, 32h, 46h, 0Ah, 24h, 0F8h, 74h, 6, 0B8h, 3Fh, 0, 0E9h, 0A2h
	db	0F5h, 0C3h, 0E8h, 2, 0FEh, 26h, 8Ah, 46h, 1, 24h, 7, 74h, 12h, 26h, 0C6h, 46h
	db	1, 0Dh, 0E8h, 0F6h, 0, 0E8h, 0FFh, 0Ah, 26h, 0F6h, 46h, 1, 8, 75h, 26h, 26h
	db	83h, 7Eh, 6, 0, 75h, 18h, 26h, 8Ah, 46h, 0Ah, 98h, 99h, 26h, 3Ah, 66h, 0Bh
	db	75h, 0Dh, 26h, 3Bh, 56h, 0Ch, 75h, 7, 26h, 32h, 66h, 24h, 75h, 1, 0C3h, 0B8h
	db	7Fh, 0, 0E9h, 36h, 0F5h, 0E8h, 0B3h, 1, 33h, 0C0h, 26h, 83h, 46h, 0Ah, 2, 26h
	db	11h, 46h, 0Ch, 26h, 10h, 46h, 24h, 26h, 39h, 46h, 6, 75h, 0E1h, 26h, 38h, 46h
	db	0Bh, 75h, 0Dh, 26h, 39h, 46h, 0Ch, 75h, 7, 26h, 38h, 46h, 24h, 75h, 1, 0C3h
	db	0B8h, 33h, 0, 0E9h, 0F5h, 0F4h, 0E8h, 8Eh, 0FDh, 26h, 8Ah, 46h, 1, 24h, 7, 74h
	db	17h, 26h, 80h, 66h, 1, 0F8h, 26h, 80h, 4Eh, 1, 9, 0E8h, 7Dh, 0, 0E8h, 86h
	db	0Ah, 26h, 0F6h, 46h, 1, 8, 75h, 19h, 26h, 83h, 7Eh, 6, 0, 75h, 0Bh, 26h
	db	8Ah, 46h, 24h, 98h, 26h, 3Bh, 46h, 0Ch, 75h, 1, 0C3h, 0B8h, 0FFh, 7Fh, 0E9h, 0CAh
	db	0F4h, 0E8h, 47h, 1, 33h, 0C0h, 26h, 83h, 46h, 0Ah, 3, 26h, 11h, 46h, 0Ch, 26h
	db	10h, 46h, 24h, 26h, 39h, 46h, 0Ch, 75h, 7, 26h, 38h, 46h, 24h, 75h, 1, 0C3h
	db	0B8h, 33h, 0, 0E9h, 95h, 0F4h, 0E8h, 2Eh, 0FDh, 26h, 8Ah, 46h, 1, 24h, 7, 74h
	db	29h, 26h, 80h, 66h, 1, 0F8h, 26h, 80h, 4Eh, 1, 9, 0E8h, 1Dh, 0, 0E8h, 26h
	db	0Ah, 26h, 0F6h, 46h, 1, 8, 74h, 12h, 0E8h, 0, 1, 26h, 83h, 46h, 0Ah, 5
	db	26h, 83h, 56h, 0Ch, 0, 26h, 80h, 56h, 24h, 0, 0C3h, 51h, 6, 55h, 0A1h, 5Ch
	db	56h, 9Ah
	dd	L101E0
	db	0E8h, 94h, 7Ah, 9Ah
	dd	L101E0
	db	26h, 8Bh, 5Eh, 6, 23h, 0DBh, 74h, 0Ch, 5Dh, 7, 26h, 89h, 5Eh, 6, 0E8h, 0F3h
	db	0D2h, 59h, 0EBh, 1Ch, 26h, 0F6h, 46h, 4, 4, 74h, 0Ch, 26h, 8Bh, 46h, 1Ah, 5Dh
	db	7, 59h, 26h, 89h, 46h, 18h, 0C3h, 5Dh, 7, 0B9h, 54h, 0, 0E8h, 8, 95h, 59h
	db	26h, 80h, 66h, 4, 0FBh, 33h, 0C0h, 26h, 89h, 46h, 18h, 26h, 89h, 46h, 1Ah, 26h
	db	88h, 46h, 1, 0C3h, 26h, 80h, 7Eh, 0, 0, 75h, 29h, 0F7h, 6, 7Ch, 51h, 0
	db	10h, 75h, 20h, 26h, 0F6h, 46h, 5, 40h, 74h, 19h, 26h, 80h, 66h, 5, 0BFh, 26h
	db	8Ah, 46h, 25h, 24h, 7Fh, 26h, 88h, 46h, 0, 26h, 8Bh, 46h, 1Ch, 26h, 89h, 46h
	db	2, 75h, 1, 0F9h, 0C3h, 0E8h, 0CCh, 0FFh, 73h, 4Eh, 0F7h, 6, 7Ch, 51h, 0, 10h
	db	75h, 48h, 26h, 0F6h, 46h, 4, 40h, 75h, 41h, 26h, 83h, 7Eh, 6, 0, 75h, 3Ah
	db	26h, 8Ah, 46h, 24h, 98h, 26h, 3Bh, 46h, 0Ch, 0B4h, 3, 75h, 27h, 0F7h, 6, 7Ch
	db	51h, 8, 0, 75h, 25h, 26h, 3Ah, 46h, 0Bh, 0B4h, 2, 75h, 17h, 26h, 0F6h, 46h
	db	4, 4, 74h, 16h, 0B4h, 1, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 5, 74h, 4
	db	3Ch, 6, 75h, 6, 26h, 88h, 66h, 0, 0F8h, 0C3h, 0F9h, 0C3h, 0E8h, 35h, 99h, 26h
	db	29h, 46h, 0Ah, 26h, 19h, 56h, 0Ch, 26h, 80h, 5Eh, 24h, 0, 0C3h, 0E8h, 24h, 99h
	db	26h, 1, 46h, 0Ah, 26h, 11h, 56h, 0Ch, 26h, 80h, 56h, 24h, 0, 0C3h, 26h, 83h
	db	7Eh, 6, 0, 75h, 0Eh, 26h, 0F6h, 46h, 4, 4, 75h, 7, 26h, 3Bh, 46h, 0Ah
	db	75h, 1, 0C3h, 0F9h, 0C3h, 26h, 83h, 7Eh, 6, 0, 75h, 3Dh, 26h, 0F6h, 46h, 4
	db	4, 75h, 36h, 26h, 8Ah, 46h, 0Ah, 98h, 26h, 3Ah, 66h, 0Bh, 75h, 2Bh, 0C3h, 26h
	db	83h, 7Eh, 6, 0, 75h, 23h, 26h, 0F6h, 46h, 4, 4, 75h, 1Ch, 26h, 8Ah, 46h
	db	0Ah, 98h, 26h, 3Ah, 66h, 0Bh, 75h, 11h, 0F7h, 6, 7Ch, 51h, 8, 0, 75h, 1
	db	0C3h, 99h, 26h, 3Bh, 56h, 0Ch, 75h, 1, 0C3h, 0F9h, 0C3h, 0F7h, 6, 7Ch, 51h, 20h
	db	0, 74h, 49h, 26h, 83h, 7Eh, 6, 0, 75h, 42h, 0A1h, 7Eh, 51h, 0F7h, 6, 7Ch
	db	51h, 0, 10h, 75h, 39h, 26h, 0F6h, 46h, 4, 4, 74h, 30h, 6, 55h, 51h, 0A1h
	db	5Ch, 56h, 9Ah
	dd	L101E0
	db	0E8h, 15h, 79h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 46h, 1Ah, 26h, 0F6h, 46h, 4, 4, 59h, 5Dh, 7, 74h, 0Fh, 8Bh, 0D0h
	db	26h, 8Bh, 46h, 18h, 23h, 0C0h, 74h, 5, 3Bh, 0C2h, 75h, 1, 0C3h, 0F9h, 0C3h, 23h
	db	0C0h, 74h, 0FAh, 8Bh, 0D0h, 26h, 8Bh, 46h, 18h, 23h, 0C0h, 74h, 0F0h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 0AEh, 74h, 0E8h, 92h, 74h, 92h, 9Ah
	dd	L101E0
	db	0E8h, 0A2h, 74h, 0E8h, 86h, 74h, 5Dh, 7, 3Bh, 0C2h, 75h, 0D1h, 0C3h, 26h, 83h, 7Eh
	db	6, 0, 75h, 51h, 26h, 0F6h, 46h, 4, 4, 74h, 1Bh, 26h, 8Ah, 46h, 1, 24h
	db	7, 3Ch, 3, 74h, 8, 3Ch, 2, 74h, 4, 3Ch, 1, 75h, 38h, 0A1h, 7Eh, 51h
	db	26h, 3Bh, 46h, 1Ah, 75h, 2Fh, 0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 26h, 8Bh, 5Eh
	db	0Ah, 2Bh, 0D8h, 8Bh, 0C3h, 26h, 8Bh, 5Eh, 0Ch, 1Bh, 0DAh, 2Dh, 2, 0, 83h, 0DBh
	db	0, 23h, 0DBh, 74h, 5, 83h, 0FBh, 0FFh, 75h, 0Bh, 3Ah, 0E3h, 75h, 7, 32h, 0D8h
	db	80h, 0E3h, 80h, 74h, 1, 0F9h, 0C3h, 0C4h, 2Eh, 0F6h, 55h, 26h, 8Ah, 46h, 4, 0A8h
	db	0C0h, 75h, 20h, 26h, 0F6h, 46h, 0, 80h, 74h, 1Bh, 26h, 80h, 7Eh, 0, 80h, 75h
	db	12h, 26h, 83h, 7Eh, 6, 0, 74h, 0Bh, 0C4h, 2Eh, 0EEh, 55h, 26h, 0F6h, 46h, 4
	db	80h, 75h, 1, 0F9h, 0C3h, 26h, 0F6h, 46h, 5, 80h, 74h, 0F8h, 0F7h, 6, 82h, 51h
	db	0, 80h, 74h, 0F0h, 0B8h, 80h, 80h, 0E8h, 0E4h, 0F1h, 0F8h, 0C3h, 0F7h, 6, 7Ch, 51h
	db	8, 0, 75h, 1, 0C3h, 26h, 8Ah, 46h, 5, 0A8h, 2, 75h, 10h, 0A8h, 1, 75h
	db	0Dh, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 6, 0E8h, 21h, 65h, 74h, 1, 0F9h, 0C3h, 0F7h
	db	6, 7Ch, 51h, 8, 0, 74h, 28h, 26h, 8Ah, 46h, 5, 0A8h, 2, 75h, 16h, 0A8h
	db	1, 75h, 1Ch, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 8, 0E8h, 0FFh, 64h, 74h, 3, 0B0h
	db	4, 0C3h, 0B0h, 2, 0C3h, 0E8h, 0EBh, 0FFh, 3Ch, 4, 74h, 0Ch, 0B0h, 5, 0C3h, 0E8h
	db	0E1h, 0FFh, 3Ch, 2, 74h, 2, 0B0h, 3, 0C3h, 0F7h, 6, 7Ch, 51h, 8, 0, 75h
	db	1, 0C3h, 26h, 8Ah, 46h, 5, 24h, 0Ch, 74h, 1Ch, 0A8h, 4, 74h, 3Eh, 0A8h, 8
	db	74h, 3Bh, 26h, 8Ah, 46h, 4, 0A8h, 40h, 74h, 32h, 26h, 8Bh, 5Eh, 0Eh, 2Bh, 1Eh
	db	0FEh, 55h, 83h, 0FBh, 3Ch, 0C3h, 26h, 0F6h, 46h, 4, 80h, 74h, 13h, 26h, 83h, 7Eh
	db	6, 0, 75h, 0Ch, 26h, 8Ah, 46h, 24h, 98h, 26h, 39h, 46h, 0Ch, 75h, 0Dh, 0C3h
	db	0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 6, 0E8h, 92h, 64h, 74h, 1, 0F9h, 0C3h, 0A1h, 7Eh
	db	51h, 23h, 0C0h, 74h, 8, 0E8h, 84h, 64h, 74h, 3, 0B0h, 3, 0C3h, 0B0h, 2, 0C3h
	db	0E8h, 96h, 0FFh, 72h, 12h, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 0Ah, 0E8h, 6Dh, 64h, 74h
	db	5, 0B0h, 67h, 0E9h, 88h, 0A1h, 0C3h, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 5, 0E8h, 5Bh
	db	64h, 75h, 5, 0B0h, 67h, 0E9h, 76h, 0A1h, 0C3h, 90h, 26h, 8Ah, 46h, 0, 3Ch, 3
	db	74h, 17h, 3Ch, 2, 74h, 1, 0C3h, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 0Ah, 0E8h, 3Bh
	db	64h, 74h, 5, 0B0h, 66h, 0E9h, 56h, 0A1h, 0C3h, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 6
	db	0E8h, 29h, 64h, 74h, 1, 0C3h, 0B0h, 66h, 0E9h, 43h, 0A1h, 0E8h, 3Fh, 0, 75h, 0Ah
	db	26h, 0F6h, 46h, 4, 80h, 74h, 2, 0EBh, 97h, 0C3h, 0E8h, 82h, 0EDh, 2Ch, 8, 3Ch
	db	1, 74h, 9, 0BBh, 0E6h, 1Ch, 0D7h, 0E8h, 0CEh, 0A0h, 0EBh, 84h, 0F7h, 6, 82h, 51h
	db	4, 0, 74h, 0EFh, 80h, 3Eh, 0FAh, 55h, 0, 74h, 0E8h, 0F7h, 6, 7Ch, 51h, 80h
	db	0, 74h, 0E0h, 51h, 0B9h, 60h, 80h, 0E8h, 6Eh, 91h, 59h, 0EBh, 0D6h, 26h, 0F6h, 46h
	db	4, 80h, 75h, 1, 0C3h, 0E8h, 2Bh, 0, 23h, 0C0h, 74h, 1Eh, 50h, 0E8h, 56h, 0EDh
	db	5Bh, 93h, 3Bh, 0C3h, 74h, 1Ah, 8Bh, 1Eh, 0FCh, 55h, 3Bh, 1Eh, 5Ah, 56h, 74h, 1
	db	0C3h, 0B8h, 3Ch, 0, 0E8h, 57h, 0F0h, 33h, 0C0h, 0C3h, 0B8h, 31h, 0, 0E8h, 4Eh, 0F0h
	db	33h, 0C0h, 0C3h, 51h, 26h, 8Bh, 5Eh, 14h, 23h, 0DBh, 74h, 2Ch, 6, 55h, 8Bh, 0C3h
	db	9Ah
	dd	L101E0
	db	0E8h, 78h, 76h, 9Ah
	dd	L101E0
	db	26h, 83h, 7Eh, 6, 0, 5Dh, 7, 75h, 3, 0E8h, 8Dh, 4, 26h, 8Bh, 5Eh, 14h
	db	0E9h, 35h, 1, 0E8h, 3, 0EDh, 8Bh, 0D8h, 0E9h, 2Dh, 1, 26h, 8Bh, 46h, 18h, 23h
	db	0C0h, 74h, 0F0h, 0E8h, 43h, 63h, 75h, 0EBh, 0E8h, 0EEh, 0ECh, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 3Eh, 76h, 8Bh, 0F8h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 5Eh, 6, 5Dh, 7, 23h, 0DBh, 74h, 3, 0E9h, 8Bh, 0, 0E8h, 4Dh, 4
	db	74h, 0C5h, 26h, 83h, 7Eh, 6, 0, 75h, 79h, 33h, 0FFh, 0B9h, 6, 0, 0F7h, 6
	db	7Ch, 51h, 8, 0, 75h, 3, 0B9h, 4, 0, 0BBh, 66h, 56h, 8Bh, 7, 0E8h, 1
	db	64h, 75h, 34h, 53h, 51h, 57h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 0F7h, 75h, 50h, 9Ah
	dd	L101F7
	db	8Bh, 0F8h, 58h, 9Ah
	dd	L101E0
	db	26h, 83h, 7Eh, 6, 0, 5Dh, 7, 75h, 0Dh, 0E8h, 3, 4, 5Fh, 75h, 8, 59h
	db	5Bh, 8Bh, 1Fh, 0E9h, 0A8h, 0, 58h, 59h, 5Bh, 83h, 0C3h, 2, 0E2h, 0C0h, 23h, 0FFh
	db	74h, 79h, 0F6h, 6, 0C9h, 38h, 0Bh, 75h, 72h, 26h, 89h, 7Eh, 6, 80h, 0Eh, 0CAh
	db	38h, 1, 33h, 0DBh, 0A1h, 0FCh, 55h, 3Bh, 6, 5Ah, 56h, 75h, 3, 0E9h, 7Eh, 0
	db	8Bh, 0DFh, 0EBh, 7Ah, 8Bh, 3Eh, 5Ch, 56h, 0EBh, 0E8h, 0F6h, 6, 0C9h, 38h, 0Bh, 75h
	db	4Ah, 8Bh, 0C3h, 33h, 0DBh, 26h, 3Bh, 46h, 1Ah, 74h, 5Ah, 57h, 0B9h, 6, 0, 0F7h
	db	6, 7Ch, 51h, 8, 0, 75h, 3, 0B9h, 4, 0, 0BBh, 66h, 56h, 8Bh, 7, 0E8h
	db	72h, 63h, 75h, 39h, 53h, 51h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 69h, 75h, 9Ah
	dd	L101E0
	db	26h, 8Bh, 5Eh, 6, 5Dh, 7, 23h, 0DBh, 75h, 10h, 0E8h, 7Dh, 3, 75h, 17h, 59h
	db	5Bh, 8Bh, 1Fh, 5Fh, 0EBh, 23h, 33h, 0DBh, 0EBh, 1Fh, 26h, 3Bh, 5Eh, 1Ah, 75h, 6
	db	59h, 5Bh, 8Bh, 1Fh, 0EBh, 9, 59h, 5Bh, 83h, 0C3h, 2, 0E2h, 0BBh, 33h, 0DBh, 5Fh
	db	26h, 89h, 7Eh, 6, 80h, 0Eh, 0CAh, 38h, 1, 8Bh, 0CBh, 26h, 8Ah, 46h, 1, 24h
	db	7, 3Ch, 3, 74h, 4, 3Ch, 2, 75h, 1Fh, 26h, 80h, 6Eh, 1, 2, 75h, 15h
	db	26h, 80h, 66h, 4, 0FBh, 33h, 0C0h, 26h, 89h, 46h, 18h, 26h, 89h, 46h, 1Ah, 8Bh
	db	0C1h, 59h, 23h, 0C0h, 0C3h, 0E8h, 66h, 4, 8Bh, 0C1h, 59h, 23h, 0C0h, 0C3h, 26h, 8Ah
	db	46h, 0, 3Ch, 2, 74h, 26h, 3Ch, 1, 75h, 2Eh, 0B6h, 2, 0E8h, 0E3h, 3, 26h
	db	8Ah, 46h, 0Ah, 0E9h, 48h, 9Fh, 0E8h, 14h, 0FDh, 72h, 1Dh, 26h, 8Ah, 46h, 24h, 98h
	db	26h, 3Bh, 46h, 0Ch, 74h, 6, 0B8h, 21h, 0, 0E9h, 86h, 0EEh, 0B6h, 2, 0E8h, 0C1h
	db	3, 26h, 8Bh, 46h, 0Ah, 0E9h, 44h, 9Fh, 0B6h, 4, 0E8h, 0B5h, 3, 26h, 8Bh, 46h
	db	0Ah, 26h, 8Bh, 4Eh, 0Ch, 0E9h, 50h, 9Fh, 0B6h, 2, 0E8h, 0A5h, 3, 26h, 8Bh, 46h
	db	0Ah, 26h, 8Bh, 4Eh, 16h, 0E9h, 40h, 9Fh, 0B6h, 4, 0E8h, 95h, 3, 26h, 8Bh, 46h
	db	0Ah, 26h, 8Bh, 5Eh, 0Ch, 26h, 8Ah, 76h, 24h, 0B9h, 8, 0, 0E9h, 91h, 9Fh, 0B6h
	db	4, 0E8h, 7Eh, 3, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 5Eh, 0Ch, 26h, 8Ah, 76h, 24h
	db	0B9h, 6, 0, 0E9h, 7Ah, 9Fh, 0B6h, 4, 0E8h, 67h, 3, 26h, 8Bh, 46h, 0Ah, 26h
	db	8Bh, 4Eh, 0Ch, 26h, 8Bh, 7Eh, 16h, 0E9h, 1Dh, 9Fh, 0B6h, 4, 0E8h, 53h, 3, 26h
	db	8Bh, 46h, 0Ah, 26h, 8Bh, 5Eh, 0Ch, 26h, 8Ah, 76h, 24h, 0B9h, 0Ah, 0, 0E9h, 4Fh
	db	9Fh, 0B9h, 4, 0, 0E9h, 23h, 9Fh, 0B9h, 6, 0, 0E9h, 1Dh, 9Fh, 0B9h, 8, 0
	db	0E9h, 17h, 9Fh, 0B9h, 0Ah, 0, 0E9h, 11h, 9Fh, 90h, 26h, 0F6h, 46h, 4, 80h, 75h
	db	2Bh, 26h, 0F6h, 46h, 4, 40h, 74h, 18h, 26h, 8Bh, 46h, 0Eh, 0E8h, 0A4h, 0EAh, 3Ch
	db	8, 73h, 7, 0Ah, 0C1h, 0Ch, 0C0h, 0E9h, 74h, 9Eh, 0B8h, 3Eh, 0, 0E9h, 0C2h, 0EDh
	db	0B8h, 3Dh, 0, 0E9h, 0BCh, 0EDh, 0B8h, 21h, 0, 0E9h, 0B6h, 0EDh, 0E8h, 2Eh, 0FCh, 73h
	db	3, 0E9h, 0CEh, 0, 26h, 8Ah, 46h, 24h, 98h, 26h, 3Bh, 46h, 0Ch, 75h, 0E7h, 26h
	db	8Ah, 46h, 4, 0A8h, 40h, 75h, 26h, 0B0h, 6, 0Ah, 0C1h, 0E8h, 40h, 9Eh, 0B6h, 2
	db	0E8h, 0CFh, 2, 26h, 8Bh, 46h, 0Ah, 0E9h, 52h, 9Eh, 8Ah, 0C1h, 0Ch, 80h, 0E8h, 2Dh
	db	9Eh, 0B6h, 2, 0E8h, 0BCh, 2, 26h, 8Bh, 46h, 0Ah, 0E9h, 3Fh, 9Eh, 26h, 83h, 7Eh
	db	6, 0, 75h, 0E6h, 0A8h, 20h, 75h, 0AEh, 26h, 8Bh, 46h, 0Eh, 2Bh, 6, 0FEh, 55h
	db	0D1h, 0E8h, 2Dh, 1Eh, 0, 72h, 9Fh, 3Ch, 8, 73h, 9Bh, 0BBh, 4, 1Dh, 0D7h, 0A8h
	db	80h, 75h, 93h, 8Ah, 0F0h, 26h, 0F6h, 46h, 4, 10h, 74h, 2Bh, 26h, 8Bh, 46h, 12h
	db	2Bh, 6, 0FEh, 55h, 0D1h, 0E8h, 2Dh, 1Eh, 0, 72h, 54h, 3Ch, 8, 73h, 50h, 0BBh
	db	4, 1Dh, 0D7h, 0A8h, 80h, 75h, 48h, 0D0h, 0E0h, 0D0h, 0E0h, 0Ah, 0C6h, 0BBh, 0Ch, 1Dh
	db	0D7h, 0A8h, 80h, 75h, 3Ah, 8Ah, 0F0h, 80h, 0F6h, 4, 0Ah, 0CEh, 0E8h, 0CBh, 0F9h, 72h
	db	89h, 26h, 8Bh, 46h, 0Eh, 3Bh, 6, 54h, 56h, 75h, 7, 26h, 0F6h, 46h, 4, 10h
	db	74h, 0Ah, 26h, 8Bh, 46h, 0Ah, 26h, 0Bh, 46h, 0Ch, 74h, 0Eh, 8Ah, 0C1h, 0Ch, 40h
	db	0E8h, 9Bh, 9Dh, 26h, 8Ah, 46h, 0Ah, 0E9h, 94h, 9Dh, 8Ah, 0C1h, 0E9h, 8Fh, 9Dh, 0E9h
	db	24h, 0FFh, 26h, 8Ah, 46h, 4, 0A8h, 40h, 75h, 17h, 0B0h, 5, 0Ah, 0C1h, 0E8h, 7Dh
	db	9Dh, 0B6h, 4, 0E8h, 0Ch, 2, 26h, 8Bh, 46h, 0Ah, 26h, 8Bh, 4Eh, 0Ch, 0E9h, 0A7h
	db	9Dh, 0A8h, 30h, 75h, 59h, 26h, 8Bh, 46h, 0Eh, 2Bh, 6, 0FEh, 55h, 0D1h, 0E8h, 2Dh
	db	8, 0, 72h, 0CBh, 3Ch, 8, 73h, 0C7h, 0Ah, 0C8h, 0E8h, 77h, 0F9h, 72h, 0Fh, 26h
	db	8Bh, 46h, 0Ah, 26h, 0Bh, 46h, 0Ch, 74h, 8, 80h, 0C9h, 40h, 0EBh, 3, 80h, 0C9h
	db	80h, 8Ah, 0C1h, 24h, 0C7h, 3Ch, 5, 75h, 3, 80h, 0C9h, 40h, 8Ah, 0C1h, 0E8h, 2Dh
	db	9Dh, 24h, 7, 3Ch, 4, 75h, 5, 0B0h, 24h, 0E8h, 22h, 9Dh, 0F6h, 0C1h, 40h, 75h
	db	6, 0F6h, 0C1h, 80h, 75h, 9Bh, 0C3h, 26h, 8Ah, 46h, 0Ah, 0E9h, 10h, 9Dh, 80h, 0C9h
	db	4, 26h, 8Bh, 5Eh, 10h, 32h, 0EDh, 83h, 0FBh, 1, 74h, 15h, 0B5h, 40h, 83h, 0FBh
	db	2, 74h, 0Eh, 0B5h, 80h, 83h, 0FBh, 4, 74h, 7, 0B5h, 0C0h, 83h, 0FBh, 8, 75h
	db	32h, 0A8h, 10h, 75h, 31h, 26h, 8Bh, 46h, 0Eh, 2Bh, 6, 0FEh, 55h, 0D1h, 0E8h, 2Dh
	db	8, 0, 72h, 1Fh, 3Ch, 8, 73h, 1Bh, 3Ch, 4, 74h, 17h, 0D0h, 0E0h, 0D0h, 0E0h
	db	0D0h, 0E0h, 0Ch, 5, 0Ah, 0E8h, 8Ah, 0C1h, 0E8h, 0C3h, 9Ch, 8Ah, 0C5h, 0E8h, 0BEh, 9Ch
	db	0E9h, 3Eh, 0FFh, 0E9h, 50h, 0FEh, 0E8h, 0DBh, 0F8h, 72h, 0Fh, 26h, 8Bh, 46h, 0Ah, 26h
	db	0Bh, 46h, 0Ch, 74h, 8, 80h, 0C9h, 40h, 0EBh, 3, 80h, 0C9h, 80h, 26h, 8Bh, 46h
	db	12h, 2Bh, 6, 0FEh, 55h, 0D1h, 0E8h, 2Dh, 8, 0, 72h, 0D7h, 3Ch, 8, 73h, 0D3h
	db	8Ah, 0D0h, 26h, 8Bh, 46h, 0Eh, 2Bh, 6, 0FEh, 55h, 0D1h, 0E8h, 2Dh, 8, 0, 72h
	db	0C2h, 3Ch, 8, 73h, 0BEh, 26h, 0F6h, 46h, 4, 20h, 75h, 6, 3Ch, 4, 75h, 2
	db	86h, 0C2h, 0Ah, 0EAh, 3Ch, 4, 74h, 0ABh, 0D0h, 0E0h, 0D0h, 0E0h, 0D0h, 0E0h, 0Ah, 0E8h
	db	8Bh, 0C1h, 25h, 0C0h, 7, 3Dh, 0, 5, 75h, 3, 80h, 0C1h, 40h, 8Ah, 0C1h, 0E8h
	db	4Ch, 9Ch, 8Ah, 0C5h, 0E8h, 47h, 9Ch, 0E9h, 22h, 0FFh, 57h, 6, 55h, 9Ah
	dd	L101E0
	db	8Bh, 0FDh, 6, 1Fh, 5Dh, 7, 26h, 8Bh, 46h, 16h, 99h, 90h, 3Bh, 45h, 0Ah, 75h
	db	77h, 3Bh, 55h, 0Ch, 75h, 72h, 3Ah, 55h, 24h, 75h, 6Dh, 0F6h, 45h, 4, 4, 74h
	db	6Bh, 26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 3, 74h, 4, 3Ch, 2, 75h, 59h, 26h
	db	8Bh, 46h, 18h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 6Ah, 6Dh, 5Dh, 7, 3Bh, 45h, 1Ah, 74h, 44h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 40h, 6Dh, 5Dh, 7, 3Bh, 45h, 1Ah, 74h, 26h, 36h, 0F7h, 6, 7Ch, 51h, 0
	db	10h, 75h, 2Ah, 36h, 0F6h, 6, 87h, 51h, 1, 74h, 1Eh, 8Bh, 45h, 1Ah, 6, 55h
	db	9Ah
	dd	L101E0
	db	0E8h, 1Bh, 6Dh, 5Dh, 7, 26h, 3Bh, 46h, 18h, 75h, 0Dh, 8Bh, 45h, 1Ah, 26h, 89h
	db	46h, 18h, 0EBh, 4, 32h, 0C0h, 0FEh, 0C8h, 16h, 1Fh, 5Fh, 0C3h, 26h, 8Ah, 46h, 1
	db	24h, 7, 3Ch, 3, 74h, 0EEh, 3Ch, 2, 74h, 0EAh, 32h, 0C0h, 0EBh, 0EAh, 8Bh, 45h
	db	2Ah, 23h, 0C0h, 75h, 23h, 6, 55h, 51h, 56h, 57h, 8Bh, 5, 9Ah
	dd	L101E0
	db	0E8h, 6Bh, 5Bh, 9Ah
	dd	L10375
	db	33h, 0EDh, 9Ah
	dd	L12F1D
	db	5Fh, 5Eh, 59h, 5Dh, 7, 89h, 45h, 2Ah, 6, 55h, 0E8h, 53h, 92h, 5Dh, 7, 0C3h
	db	26h, 0F6h, 46h, 4, 4, 75h, 1, 0C3h, 0F6h, 6, 0CAh, 38h, 1, 75h, 0F8h, 26h
	db	8Bh, 5Eh, 18h, 26h, 8Bh, 7Eh, 1Ah, 26h, 8Ah, 46h, 1, 0F7h, 6, 0B6h, 38h, 0
	db	8, 75h, 0Ah, 24h, 0EFh, 6, 55h, 0E8h, 3Ah, 92h, 5Dh, 7, 0C3h, 3Ch, 11h, 74h
	db	4, 3Ch, 13h, 75h, 0F0h, 6, 55h, 50h, 26h, 8Bh, 46h, 26h, 9Ah
	dd	L101E0
	db	58h, 0E8h, 0C5h, 58h, 5Dh, 7, 0EBh, 0DCh, 0F6h, 0C4h, 80h, 75h, 0Ch, 3Dh, 0Bh, 0
	db	73h, 15h, 8Bh, 0D8h, 8Ah, 87h, 0A9h, 1Ch, 0C3h, 0F7h, 0D0h, 3Dh, 3, 0, 73h, 7
	db	8Bh, 0D8h, 8Ah, 87h, 0B4h, 1Ch, 0C3h, 0B0h, 0, 0C3h, 90h, 26h, 0F6h, 46h, 4, 4
	db	74h, 3Fh, 26h, 83h, 7Eh, 6, 0, 75h, 70h, 26h, 8Bh, 5Eh, 18h, 26h, 0F6h, 46h
	db	1, 8, 74h, 2Eh, 0A1h, 7Eh, 51h, 26h, 3Bh, 46h, 1Ah, 75h, 24h, 3Bh, 0C3h, 74h
	db	27h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 3Bh, 6Ch, 5Dh, 7, 3Bh, 0C3h, 74h, 17h, 6, 55h, 9Ah
	dd	L101E0
	db	0E8h, 12h, 6Ch, 5Dh, 7, 3Bh, 0C3h, 74h, 7, 0C3h, 26h, 3Bh, 5Eh, 1Ah, 75h, 44h
	db	26h, 8Ah, 46h, 1, 24h, 7, 3Ch, 1, 74h, 0Ch, 3Ch, 5, 74h, 8, 3Ch, 6
	db	74h, 4, 3Ch, 3, 75h, 2Eh, 8Bh, 0C3h, 0E8h, 6Dh, 5Dh, 74h, 7, 26h, 0F6h, 46h
	db	1, 8, 74h, 20h, 26h, 80h, 7Eh, 1, 3, 75h, 6, 26h, 80h, 6Eh, 1, 1
	db	0C3h, 26h, 80h, 66h, 4, 0FBh, 33h, 0C0h, 26h, 88h, 46h, 1, 26h, 89h, 46h, 1Ah
	db	26h, 89h, 46h, 18h, 0C3h, 26h, 80h, 66h, 4, 8Fh, 33h, 0C0h, 26h, 89h, 46h, 0Eh
	db	26h, 89h, 46h, 12h, 26h, 0C7h, 46h, 10h, 1, 0, 0E9h, 94h, 8Ah, 26h, 80h, 66h
	db	4, 0FBh, 33h, 0C0h, 26h, 88h, 46h, 1, 26h, 89h, 46h, 18h, 26h, 89h, 46h, 1Ah
	db	0E9h, 7Eh, 8Ah, 33h, 0C0h, 26h, 39h, 46h, 0Ch, 75h, 4Dh, 26h, 38h, 46h, 24h, 75h
	db	47h, 0C3h, 26h, 8Ah, 46h, 0Bh, 98h, 99h, 26h, 3Bh, 56h, 0Ch, 75h, 3Ah, 26h, 32h
	db	66h, 24h, 75h, 34h, 0C3h, 26h, 8Ah, 46h, 0Dh, 98h, 26h, 32h, 66h, 24h, 75h, 28h
	db	0C3h, 26h, 8Ah, 46h, 24h, 98h, 26h, 88h, 66h, 24h, 0F7h, 6, 7Ch, 51h, 8, 10h
	db	75h, 7, 8Ah, 0C4h, 98h, 26h, 89h, 46h, 0Ch, 0F7h, 6, 82h, 51h, 0, 10h, 74h
	db	6, 0B9h, 2Ch, 80h, 0E9h, 2Ah, 8Ah, 0C3h, 0B9h, 14h, 0, 33h, 0C0h, 26h, 89h, 46h
	db	0Ah, 26h, 89h, 46h, 0Ch, 26h, 88h, 46h, 24h, 0E9h, 15h, 8Ah, 26h, 8Ah, 46h, 24h
	db	22h, 0C0h, 74h, 4, 3Ch, 0FFh, 75h, 0B9h, 0F7h, 6, 7Ch, 51h, 8, 10h, 75h, 7
	db	98h, 26h, 3Bh, 46h, 0Ch, 75h, 0AAh, 0C3h, 90h, 26h, 0F6h, 46h, 4, 1, 74h, 3Bh
	db	26h, 8Ah, 66h, 4, 80h, 0E4h, 2, 6, 55h, 50h, 26h, 8Bh, 46h, 8, 9Ah
	dd	L101E0
	db	58h, 0E8h, 7Fh, 59h, 0E8h, 0F8h, 0A1h, 5Dh, 7, 8Bh, 7, 26h, 89h, 46h, 0Ah, 8Ah
	db	47h, 4, 26h, 88h, 46h, 24h, 8Bh, 47h, 2, 26h, 89h, 46h, 0Ch, 26h, 0C7h, 46h
	db	8, 0, 0, 26h, 80h, 66h, 4, 0FEh, 0C3h, 0, 0C6h, 6, 0CBh, 38h, 0FFh, 56h
	db	0E8h, 2Ah, 0, 72h, 1Ah, 75h, 18h, 0E8h, 3Eh, 0B0h, 72h, 13h, 75h, 11h, 0E8h, 95h
	db	7Dh, 74h, 0Ch, 0C6h, 6, 0CBh, 38h, 0, 0E8h, 36h, 0B0h, 32h, 0C0h, 5Ah, 0C3h, 80h
	db	26h, 0CAh, 38h, 0FEh, 5Eh, 32h, 0C0h, 0A2h, 0CBh, 38h, 0FEh, 0C8h, 0C3h, 89h, 26h, 0AEh
	db	38h, 0E9h, 43h, 5, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 19h, 0E8h, 38h, 5, 75h
	db	13h, 0E9h, 9, 0B1h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 9, 0E8h, 28h, 5, 75h
	db	3, 0E9h, 0A0h, 0B0h, 0C3h, 0E8h, 4Eh, 7Dh, 75h, 65h, 22h, 0E4h, 74h, 29h, 83h, 0C6h
	db	2, 50h, 52h, 0E8h, 40h, 7Dh, 75h, 12h, 3Bh, 6, 5Eh, 58h, 74h, 0Ch, 3Bh, 6
	db	56h, 58h, 74h, 6, 3Bh, 6, 5Ch, 58h, 75h, 8, 83h, 0EEh, 2, 5Ah, 58h, 0E9h
	db	0FDh, 3, 83h, 0EEh, 2, 5Ah, 58h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 0Ch, 3Bh
	db	6, 8Ch, 58h, 74h, 0Eh, 3Bh, 6, 8Eh, 58h, 74h, 16h, 0E8h, 0A9h, 0, 74h, 20h
	db	0E9h, 0F8h, 0, 83h, 0C6h, 2, 0E8h, 0ACh, 0FFh, 74h, 3, 0E8h, 52h, 7, 0E9h, 0D7h
	db	0B0h, 83h, 0C6h, 2, 0E8h, 9Eh, 0FFh, 74h, 3, 0E8h, 44h, 7, 0E9h, 0E0h, 0B0h, 0C3h
	db	0E8h, 0E3h, 7Ch, 75h, 9, 3Bh, 6, 6Ah, 58h, 75h, 12h, 83h, 0C6h, 2, 6, 55h
	db	0E8h, 82h, 0FFh, 5Fh, 58h, 74h, 3, 0E8h, 34h, 7, 0E9h, 4Ah, 0B2h, 3Bh, 6, 0B6h
	db	58h, 75h, 12h, 83h, 0C6h, 2, 6, 55h, 0E8h, 6Ah, 0FFh, 5Fh, 58h, 74h, 3, 0E8h
	db	1Ch, 7, 0E9h, 60h, 0B2h, 3Bh, 6, 0B8h, 58h, 75h, 0D3h, 83h, 0C6h, 2, 6, 55h
	db	0E8h, 52h, 0FFh, 5Fh, 58h, 74h, 3, 0E8h, 4, 7, 0E9h, 98h, 0B2h, 0E8h, 96h, 7Ch
	db	75h, 0Eh, 3Bh, 6, 66h, 58h, 75h, 8, 83h, 0C6h, 2, 0E8h, 16h, 0FFh, 75h, 1
	db	0C3h, 0E8h, 0FAh, 0ACh, 32h, 0C0h, 0C3h, 0E8h, 7Ch, 7Ch, 75h, 15h, 0E8h, 18h, 0, 75h
	db	1, 0C3h, 0E8h, 0F4h, 59h, 74h, 6, 83h, 0C6h, 2, 0E9h, 0EFh, 0B2h, 32h, 0C0h, 0FEh
	db	0C8h, 0C3h, 0E8h, 61h, 7Ch, 75h, 0FAh, 16h, 7, 0BFh, 6Ch, 58h, 0B9h, 0Eh, 0, 0F2h
	db	0AFh, 75h, 0Eh, 83h, 0C6h, 2, 0BBh, 0Dh, 0, 2Bh, 0D9h, 0D1h, 0E3h, 0FFh, 0A7h, 48h
	db	1Fh, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 14h, 3Bh, 6, 0B4h, 58h, 75h, 0Eh, 83h
	db	0C6h, 2, 0E8h, 0E0h, 0FEh, 74h, 3, 0E8h, 94h, 6, 32h, 0C0h, 0C3h, 22h, 0F6h, 74h
	db	15h, 8Bh, 0C2h, 0E8h, 0CFh, 5Bh, 75h, 12h, 83h, 0C6h, 2, 0E8h, 87h, 5Bh, 74h, 3
	db	0E9h, 6Ch, 0B2h, 0E9h, 7Fh, 0B2h, 32h, 0C0h, 0FEh, 0C8h, 0C3h, 0E8h, 8, 7Ch, 75h, 2Fh
	db	0E8h, 32h, 0, 75h, 2Ah, 0E8h, 0FEh, 7Bh, 75h, 23h, 3Bh, 6, 5Ah, 58h, 75h, 1Dh
	db	83h, 0C6h, 2, 0E8h, 0F0h, 7Bh, 75h, 0Fh, 8Bh, 0C2h, 0E8h, 6Ch, 59h, 74h, 8, 83h
	db	0C6h, 2, 0E8h, 7Fh, 0B2h, 0EBh, 0DEh, 0B9h, 0Ch, 0, 0E8h, 0E1h, 87h, 32h, 0C0h, 0C3h
	db	0E8h, 0D3h, 7Bh, 75h, 24h, 0E8h, 27h, 0, 75h, 1Fh, 0E8h, 0C9h, 7Bh, 75h, 18h, 3Bh
	db	6, 2Eh, 58h, 75h, 12h, 83h, 0C6h, 2, 6, 55h, 0E8h, 0E3h, 0FFh, 5Fh, 58h, 74h
	db	3, 0E8h, 1Ah, 6, 0E9h, 0A0h, 0B2h, 32h, 0C0h, 0C3h, 0E8h, 0A9h, 7Bh, 75h, 14h, 3Bh
	db	6, 90h, 58h, 75h, 0Fh, 83h, 0C6h, 2, 0E8h, 0EFh, 0FFh, 74h, 3, 0E8h, 0F0h, 5
	db	0E9h, 0EFh, 0B3h, 0C3h, 0E8h, 43h, 0, 75h, 3Bh, 0E8h, 8Ah, 7Bh, 75h, 34h, 3Bh, 6
	db	92h, 58h, 75h, 14h, 83h, 0C6h, 2, 6, 55h, 0E8h, 29h, 0, 5Fh, 58h, 74h, 3
	db	0E8h, 0CDh, 5, 0E8h, 72h, 0B4h, 0EBh, 0E1h, 3Bh, 6, 94h, 58h, 75h, 14h, 83h, 0C6h
	db	2, 6, 55h, 0E8h, 0Fh, 0, 5Fh, 58h, 74h, 3, 0E8h, 0B3h, 5, 0E8h, 7Eh, 0B4h
	db	0EBh, 0C7h, 32h, 0C0h, 0C3h, 0E8h, 4Eh, 7Bh, 75h, 26h, 0E8h, 29h, 0, 75h, 21h, 0E8h
	db	44h, 7Bh, 75h, 1Ah, 3Bh, 6, 96h, 58h, 75h, 14h, 83h, 0C6h, 2, 6, 55h, 0E8h
	db	0Fh, 0, 5Fh, 58h, 74h, 3, 0E8h, 87h, 5, 0E8h, 78h, 0B4h, 0EBh, 0E1h, 32h, 0C0h
	db	0C3h, 0E8h, 22h, 7Bh, 75h, 14h, 3Bh, 6, 98h, 58h, 75h, 0Fh, 83h, 0C6h, 2, 0E8h
	db	0EFh, 0FFh, 74h, 3, 0E8h, 69h, 5, 0E9h, 80h, 0B4h, 0C3h, 0E8h, 94h, 0, 75h, 17h
	db	0E8h, 3, 7Bh, 75h, 10h, 8Ch, 0C3h, 16h, 7, 0BFh, 9Ah, 58h, 0B9h, 6, 0, 0F2h
	db	0AFh, 8Eh, 0C3h, 74h, 3, 32h, 0C0h, 0C3h, 83h, 0C6h, 2, 0BBh, 5, 0, 2Bh, 0D9h
	db	0D1h, 0E3h, 0FFh, 0A7h, 3Ch, 1Fh, 6, 55h, 0E8h, 62h, 0, 5Fh, 58h, 74h, 3, 0E8h
	db	2Eh, 5, 0E8h, 60h, 0B4h, 0EBh, 0C9h, 6, 55h, 0E8h, 51h, 0, 5Fh, 58h, 74h, 3
	db	0E8h, 1Dh, 5, 0E8h, 61h, 0B4h, 0EBh, 0B8h, 6, 55h, 0E8h, 40h, 0, 5Fh, 58h, 74h
	db	3, 0E8h, 0Ch, 5, 0E8h, 62h, 0B4h, 0EBh, 0A7h, 6, 55h, 0E8h, 2Fh, 0, 5Fh, 58h
	db	74h, 3, 0E8h, 0FBh, 4, 0E8h, 63h, 0B4h, 0EBh, 96h, 6, 55h, 0E8h, 1Eh, 0, 5Fh
	db	58h, 74h, 3, 0E8h, 0EAh, 4, 0E8h, 64h, 0B4h, 0EBh, 85h, 6, 55h, 0E8h, 0Dh, 0
	db	5Fh, 58h, 74h, 3, 0E8h, 0D9h, 4, 0E8h, 65h, 0B4h, 0E9h, 73h, 0FFh, 0E8h, 76h, 7Ah
	db	75h, 40h, 0E8h, 43h, 0, 75h, 3Bh, 0E8h, 6Ch, 7Ah, 75h, 34h, 3Bh, 6, 0A6h, 58h
	db	75h, 14h, 83h, 0C6h, 2, 6, 55h, 0E8h, 29h, 0, 5Fh, 58h, 74h, 3, 0E8h, 0AFh
	db	4, 0E8h, 9Eh, 0B4h, 0EBh, 0E1h, 3Bh, 6, 0A8h, 58h, 75h, 14h, 83h, 0C6h, 2, 6
	db	55h, 0E8h, 0Fh, 0, 5Fh, 58h, 74h, 3, 0E8h, 95h, 4, 0E8h, 7Dh, 0B5h, 0EBh, 0C7h
	db	32h, 0C0h, 0C3h, 0E8h, 30h, 7Ah, 75h, 1Ch, 0E8h, 89h, 0, 75h, 48h, 0E8h, 26h, 7Ah
	db	75h, 10h, 8Ch, 0C3h, 16h, 7, 0BFh, 0AAh, 58h, 0B9h, 5, 0, 0F2h, 0AFh, 8Eh, 0C3h
	db	74h, 3, 32h, 0C0h, 0C3h, 83h, 0C6h, 2, 0BBh, 4, 0, 2Bh, 0D9h, 0D1h, 0E3h, 0FFh
	db	0A7h, 32h, 1Fh, 6, 55h, 0E8h, 51h, 0, 5Fh, 58h, 74h, 3, 0E8h, 51h, 4, 0E8h
	db	6Bh, 0B7h, 0EBh, 0C9h, 6, 55h, 0E8h, 40h, 0, 5Fh, 58h, 74h, 3, 0E8h, 40h, 4
	db	0E8h, 59h, 0B8h, 0EBh, 0B8h, 0C3h, 6, 55h, 0E8h, 2Eh, 0, 5Fh, 58h, 74h, 3, 0E8h
	db	2Eh, 4, 0E8h, 79h, 0B8h, 0EBh, 0A6h, 6, 55h, 0E8h, 1Dh, 0, 5Fh, 58h, 74h, 3
	db	0E8h, 1Dh, 4, 0E8h, 0B6h, 0B8h, 0EBh, 95h, 6, 55h, 0E8h, 0Ch, 0, 5Fh, 58h, 74h
	db	3, 0E8h, 0Ch, 4, 0E8h, 1Ah, 0B9h, 0EBh, 84h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h
	db	0Eh, 0E9h, 10h, 2, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 8, 0E9h, 0Ah, 2, 0E8h
	db	94h, 79h, 75h, 11h, 3Bh, 6, 0A6h, 58h, 75h, 0Ch, 83h, 0C6h, 2, 0E8h, 0EFh, 0FFh
	db	74h, 3, 0E9h, 0DBh, 3, 0C3h, 3Bh, 6, 0A8h, 58h, 75h, 0Eh, 83h, 0C6h, 2, 0E8h
	db	0DDh, 0FFh, 74h, 3, 0E8h, 0C9h, 3, 0E9h, 66h, 0B9h, 0F7h, 6, 7Ch, 51h, 0, 10h
	db	75h, 8, 0E9h, 0B3h, 2, 0E8h, 5Eh, 79h, 75h, 28h, 3Bh, 6, 0B6h, 58h, 75h, 0Eh
	db	83h, 0C6h, 2, 0E8h, 0EFh, 0FFh, 74h, 3, 0E8h, 0A5h, 3, 0E9h, 8Bh, 0B9h, 3Bh, 6
	db	0B8h, 58h, 75h, 0Fh, 83h, 0C6h, 2, 0E8h, 0DBh, 0FFh, 74h, 3, 0E8h, 91h, 3, 0E9h
	db	0C9h, 0B9h, 0C3h, 16h, 7, 0BFh, 0BAh, 58h, 0B9h, 9, 0, 0F2h, 0AFh, 74h, 21h, 22h
	db	0E4h, 74h, 18h, 83h, 0C6h, 2, 3Bh, 6, 60h, 58h, 74h, 9, 3Bh, 6, 68h, 58h
	db	74h, 6, 0E9h, 91h, 0BCh, 0E9h, 0F9h, 0BBh, 0E9h, 83h, 0A9h, 32h, 0C0h, 0FEh, 0C8h, 0C3h
	db	83h, 0C6h, 2, 0BBh, 8, 0, 2Bh, 0D9h, 0D1h, 0E3h, 0FFh, 0A7h, 20h, 1Fh, 0E8h, 0A4h
	db	0FBh, 74h, 3, 0E8h, 58h, 3, 0E9h, 0B7h, 0B9h, 0E8h, 99h, 0FBh, 74h, 3, 0E8h, 4Dh
	db	3, 0E9h, 7Eh, 0BAh, 0E8h, 0DFh, 78h, 75h, 1Fh, 8Bh, 0C2h, 0E8h, 5Bh, 56h, 74h, 18h
	db	83h, 0C6h, 2, 0E9h, 0CFh, 0BAh, 0E8h, 0CDh, 78h, 75h, 0Dh, 8Bh, 0C2h, 0E8h, 49h, 56h
	db	74h, 6, 83h, 0C6h, 2, 0E9h, 0EBh, 0BAh, 83h, 0EEh, 2, 0E8h, 0B8h, 78h, 83h, 0C6h
	db	2, 0E9h, 32h, 0BCh, 0E8h, 0AFh, 78h, 75h, 0EFh, 8Bh, 0C2h, 0E8h, 2Bh, 56h, 74h, 0E8h
	db	83h, 0C6h, 2, 0E9h, 0, 0BBh, 0E8h, 9Dh, 78h, 75h, 0DDh, 8Bh, 0C2h, 0E8h, 19h, 56h
	db	74h, 0D6h, 83h, 0C6h, 2, 0E9h, 20h, 0BBh, 0E8h, 27h, 0FCh, 74h, 9, 0B9h, 7, 0
	db	0E8h, 1, 3, 0E8h, 4Ah, 0A9h, 0E9h, 70h, 0BBh, 3Bh, 26h, 0C6h, 38h, 72h, 42h, 0E8h
	db	23h, 0FBh, 74h, 3, 0E8h, 0D7h, 2, 0E8h, 6Ch, 78h, 75h, 0Bh, 3Bh, 6, 56h, 58h
	db	75h, 5, 83h, 0C6h, 2, 0EBh, 3, 0E8h, 0D2h, 2, 0E9h, 0Eh, 0ACh, 3Bh, 26h, 0C6h
	db	38h, 72h, 1Eh, 0E8h, 0FFh, 0FAh, 74h, 3, 0E8h, 0A5h, 2, 0E8h, 48h, 78h, 75h, 0Bh
	db	3Bh, 6, 5Ch, 58h, 75h, 5, 83h, 0C6h, 2, 0EBh, 3, 0E8h, 0B3h, 2, 32h, 0C0h
	db	0C3h, 0B9h, 75h, 40h, 0E9h, 37h, 84h, 0E8h, 2Ch, 78h, 75h, 50h, 22h, 0E4h, 74h, 29h
	db	83h, 0C6h, 2, 50h, 52h, 0E8h, 1Eh, 78h, 75h, 12h, 3Bh, 6, 5Eh, 58h, 74h, 0Ch
	db	3Bh, 6, 56h, 58h, 74h, 6, 3Bh, 6, 5Ch, 58h, 75h, 8, 83h, 0EEh, 2, 5Ah
	db	58h, 0E9h, 0DBh, 0FEh, 83h, 0EEh, 2, 5Ah, 58h, 3Bh, 6, 8Ah, 58h, 74h, 1Eh, 3Bh
	db	6, 88h, 58h, 74h, 26h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 0Ch, 3Bh, 6, 8Ch
	db	58h, 74h, 35h, 3Bh, 6, 8Eh, 58h, 74h, 3Dh, 0E9h, 48h, 0FCh, 0C3h, 83h, 0C6h, 2
	db	0E8h, 0A4h, 0FFh, 74h, 3, 0E8h, 28h, 2, 0E9h, 0DBh, 0ABh, 83h, 0C6h, 2, 0A0h, 0CCh
	db	38h, 50h, 0C6h, 6, 0CCh, 38h, 0FFh, 0E8h, 8Dh, 0FFh, 58h, 0C6h, 6, 0CCh, 38h, 0
	db	74h, 3, 0E8h, 0Bh, 2, 0E9h, 1Bh, 0B0h, 83h, 0C6h, 2, 0E8h, 79h, 0FFh, 74h, 3
	db	0E8h, 0FDh, 1, 0E9h, 82h, 0ABh, 83h, 0C6h, 2, 0E8h, 6Bh, 0FFh, 74h, 3, 0E8h, 0EFh
	db	1, 0E9h, 8Bh, 0ABh, 0E8h, 8Fh, 77h, 75h, 1Eh, 16h, 7, 0BFh, 0B4h, 58h, 0B9h, 6
	db	0, 0F2h, 0AFh, 74h, 13h, 0E8h, 0A8h, 0, 75h, 0Dh, 0E8h, 79h, 77h, 75h, 6, 3Bh
	db	6, 6Ah, 58h, 74h, 11h, 32h, 0C0h, 0C3h, 83h, 0C6h, 2, 0BBh, 5, 0, 2Bh, 0D9h
	db	0D1h, 0E3h, 0FFh, 0A7h, 14h, 1Fh, 83h, 0C6h, 2, 6, 55h, 0E8h, 4Ch, 0, 5Fh, 58h
	db	74h, 3, 0E8h, 0ABh, 1, 0E9h, 0EEh, 0ABh, 0E8h, 3Fh, 0, 74h, 3, 0E8h, 0A0h, 1
	db	0E9h, 83h, 0B7h, 0E8h, 34h, 0, 74h, 3, 0E8h, 95h, 1, 0E9h, 0CAh, 0B7h, 0E8h, 29h
	db	0, 74h, 3, 0E8h, 8Ah, 1, 0E9h, 0, 0B8h, 0E8h, 1Eh, 0, 74h, 3, 0E8h, 7Fh
	db	1, 0E9h, 0ACh, 0B8h, 0E8h, 13h, 0, 74h, 3, 0E8h, 74h, 1, 0E9h, 0DBh, 0B9h, 0E8h
	db	8, 0, 74h, 3, 0E8h, 69h, 1, 0E9h, 0C5h, 0A9h, 0E8h, 9, 77h, 75h, 30h, 22h
	db	0E4h, 74h, 29h, 83h, 0C6h, 2, 50h, 52h, 0E8h, 0FBh, 76h, 75h, 12h, 3Bh, 6, 5Eh
	db	58h, 74h, 0Ch, 3Bh, 6, 56h, 58h, 74h, 6, 3Bh, 6, 5Ch, 58h, 75h, 8, 83h
	db	0EEh, 2, 5Ah, 58h, 0E9h, 0B8h, 0FDh, 83h, 0EEh, 2, 5Ah, 58h, 0E9h, 4Ah, 0FFh, 0C3h
	db	0E8h, 41h, 0FDh, 75h, 22h, 0E8h, 0CEh, 76h, 75h, 6, 3Bh, 6, 2Eh, 58h, 74h, 3
	db	32h, 0C0h, 0C3h, 83h, 0C6h, 2, 6, 55h, 0E8h, 24h, 0FDh, 5Fh, 58h, 74h, 3, 0E8h
	db	0Eh, 1, 0E8h, 0A2h, 0ADh, 0EBh, 0DEh, 0C3h, 0E8h, 46h, 0, 75h, 43h, 0E8h, 0A6h, 76h
	db	75h, 12h, 3Bh, 6, 5Ah, 58h, 74h, 23h, 3Bh, 6, 0C0h, 58h, 74h, 9, 3Bh, 6
	db	0C2h, 58h, 74h, 3, 32h, 0C0h, 0C3h, 6, 55h, 0E8h, 25h, 0, 5Fh, 58h, 74h, 6
	db	8Eh, 0C0h, 8Bh, 0EFh, 0EBh, 0EEh, 0E8h, 0C9h, 0B0h, 0EBh, 0D2h, 83h, 0C6h, 2, 6, 55h
	db	0E8h, 67h, 0FFh, 5Fh, 58h, 74h, 3, 0E8h, 0C6h, 0, 0E8h, 0B5h, 0B0h, 0E9h, 81h, 0AAh
	db	0C3h, 16h, 7, 0BFh, 0C0h, 58h, 0B9h, 6, 0, 0F2h, 0AFh, 74h, 3, 0E9h, 2Fh, 0FDh
	db	83h, 0C6h, 2, 0BBh, 5, 0, 2Bh, 0D9h, 0D1h, 0E3h, 0FFh, 0A7h, 8, 1Fh, 3Bh, 26h
	db	0C6h, 38h, 72h, 1Eh, 0E8h, 10h, 0FEh, 74h, 3, 0E8h, 94h, 0, 0E8h, 37h, 76h, 75h
	db	0Bh, 3Bh, 6, 56h, 58h, 75h, 5, 83h, 0C6h, 2, 0EBh, 3, 0E8h, 9Dh, 0, 0E9h
	db	6Ah, 0A9h, 0B9h, 75h, 40h, 0E9h, 26h, 82h, 3Bh, 26h, 0C6h, 38h, 72h, 0F4h, 0E8h, 0E6h
	db	0FDh, 74h, 3, 0E8h, 6Ah, 0, 0E8h, 0Dh, 76h, 75h, 0Bh, 3Bh, 6, 5Ch, 58h, 75h
	db	5, 83h, 0C6h, 2, 0EBh, 3, 0E8h, 78h, 0, 32h, 0C0h, 0C3h, 0E8h, 0F7h, 75h, 75h
	db	0Dh, 8Bh, 0C2h, 0E8h, 73h, 53h, 74h, 6, 83h, 0C6h, 2, 0E9h, 15h, 0B8h, 83h, 0EEh
	db	2, 0E8h, 0E2h, 75h, 83h, 0C6h, 2, 0E9h, 5Ch, 0B9h, 0E8h, 0D9h, 75h, 75h, 0EFh, 8Bh
	db	0C2h, 0E8h, 55h, 53h, 74h, 0E8h, 83h, 0C6h, 2, 0E9h, 5Ch, 0B8h, 0E8h, 0C7h, 75h, 75h
	db	0DDh, 8Bh, 0C2h, 0E8h, 43h, 53h, 74h, 0D6h, 83h, 0C6h, 2, 0E9h, 0B7h, 0B7h, 0E8h, 0B5h
	db	75h, 75h, 0CBh, 8Bh, 0C2h, 0E8h, 31h, 53h, 74h, 0C4h, 83h, 0C6h, 2, 0E9h, 6, 0B8h
	db	0B9h, 2, 0, 0E8h, 1Eh, 0, 50h, 57h, 0E8h, 13h, 0A6h, 5Fh, 58h, 0C3h, 0B9h, 3
	db	0, 0E8h, 10h, 0, 50h, 57h, 0E8h, 57h, 0A6h, 5Fh, 58h, 0C3h, 0B9h, 1, 0, 0EBh
	db	3, 0B9h, 0, 0, 80h, 3Eh, 0CBh, 38h, 0, 75h, 3, 0E9h, 80h, 81h, 80h, 26h
	db	0CAh, 38h, 0FEh, 0F9h, 8Bh, 26h, 0AEh, 38h, 0C3h, 0, 9Ah
	dd	L101E0
	db	0E8h, 64h, 75h, 75h, 6, 3Bh, 6, 64h, 57h, 74h, 1, 0C3h, 83h, 0C6h, 2, 0FFh
	db	36h, 0C2h, 56h, 89h, 36h, 0C2h, 56h, 0BEh, 0FFh, 0B8h, 0E8h, 0C6h, 58h, 8Bh, 36h, 0C2h
	db	56h, 8Fh, 6, 0C2h, 56h, 50h, 52h, 0E8h, 3Dh, 75h, 75h, 0Eh, 3Bh, 6, 66h, 57h
	db	75h, 0Dh, 83h, 0C6h, 2, 32h, 0C0h, 5Ah, 58h, 0C3h, 0B9h, 9, 0, 0EBh, 3, 0B9h
	db	52h, 0, 0E8h, 2Ah, 81h, 32h, 0C0h, 0EBh, 0EEh, 33h, 0D2h, 0A3h, 0CCh, 56h, 0A3h, 0B8h
	db	56h, 50h, 0E8h, 67h, 4Ah, 5Bh, 75h, 37h, 0E8h, 27h, 85h, 8Bh, 0C3h, 0C7h, 6, 0D0h
	db	56h, 24h, 29h, 0E8h, 70h, 54h, 74h, 2Ah, 3Bh, 6, 0B0h, 51h, 75h, 0Ah, 23h, 0C0h
	db	74h, 6, 0B9h, 49h, 0, 0E9h, 0F7h, 80h, 0C7h, 6, 0CEh, 56h, 91h, 0B8h, 0C7h, 6
	db	0D2h, 56h, 9Fh, 0B7h, 0C7h, 6, 0D8h, 56h, 0, 0, 0B0h, 0Ah, 0E9h, 98h, 0, 0E9h
	db	79h, 74h, 0C7h, 6, 0CCh, 56h, 0, 0, 9Ah
	dd	L101E0
	db	52h, 0E8h, 9Ah, 58h, 5Ah, 89h, 2Eh, 0D8h, 56h, 0C7h, 6, 0CEh, 56h, 24h, 0B8h, 0C7h
	db	6, 0D2h, 56h, 90h, 0B7h, 8Ah, 0C3h, 24h, 0Fh, 0EBh, 6Fh, 33h, 0D2h, 0B0h, 1, 0EBh
	db	1Eh, 33h, 0D2h, 0B0h, 2, 0EBh, 18h, 33h, 0D2h, 0B0h, 3, 0EBh, 30h, 33h, 0D2h, 0B0h
	db	4, 0EBh, 2Ah, 33h, 0D2h, 0B0h, 5, 0EBh, 6, 33h, 0D2h, 0B0h, 6, 0EBh, 1Eh, 33h
	db	0C9h, 89h, 0Eh, 0CCh, 56h, 89h, 0Eh, 0D8h, 56h, 0C7h, 6, 0D0h, 56h, 24h, 29h, 0C7h
	db	6, 0CEh, 56h, 0C0h, 0B7h, 0C7h, 6, 0D2h, 56h, 90h, 0B7h, 0EBh, 2Dh, 33h, 0C9h, 89h
	db	0Eh, 0CCh, 56h, 89h, 0Eh, 0D8h, 56h, 23h, 0D2h, 75h, 0Dh, 0F7h, 6, 7Ch, 51h, 0
	db	10h, 75h, 5, 50h, 0E8h, 27h, 49h, 58h, 0C7h, 6, 0D0h, 56h, 6Bh, 0B7h, 0C7h, 6
	db	0CEh, 56h, 0C0h, 0B7h, 0C7h, 6, 0D2h, 56h, 90h, 0B7h, 80h, 0Eh, 0CAh, 38h, 8, 0Ch
	db	20h, 0A2h, 0DAh, 56h, 23h, 0D2h, 74h, 3, 0E8h, 0DCh, 51h, 89h, 16h, 0B6h, 56h, 0E8h
	db	7Dh, 49h, 75h, 4Fh, 83h, 3Eh, 0B0h, 51h, 0, 75h, 4Bh, 83h, 3Eh, 0B6h, 56h, 0
	db	74h, 3Bh, 0A1h, 0B6h, 56h, 9Ah
	dd	L101E0
	db	0A1h, 0CCh, 56h, 8Ah, 1Eh, 0DAh, 56h, 0E8h, 0A7h, 5Ch, 75h, 21h, 0E8h, 0C5h, 5Dh, 0FFh
	db	36h, 70h, 51h, 0FFh, 36h, 72h, 51h, 0E8h, 9Ch, 0, 0E8h, 0C2h, 1, 0A1h, 0B6h, 56h
	db	9Ah
	dd	L101E0
	db	5Ah, 58h, 0E8h, 0DBh, 82h, 0E9h, 9Bh, 48h, 0C7h, 6, 0B6h, 56h, 0, 0, 0E8h, 80h
	db	0, 0E9h, 8Fh, 48h, 0E9h, 78h, 73h, 83h, 3Eh, 0B6h, 56h, 0, 74h, 39h, 0A1h, 0B0h
	db	51h, 9Ah
	dd	L101E0
	db	8Bh, 16h, 0CCh, 56h, 0A1h, 0B6h, 56h, 8Ah, 1Eh, 0DAh, 56h, 0E8h, 8Ah, 58h, 0F7h, 6
	db	7Ch, 51h, 0, 10h, 75h, 1Bh, 0A1h, 0B6h, 56h, 9Ah
	dd	L101E0
	db	0E8h, 3Ah, 55h, 75h, 0Eh, 0E8h, 6Ch, 83h, 8Ah, 1Eh, 0DAh, 56h, 8Bh, 0Eh, 0CCh, 56h
	db	0E8h, 41h, 55h, 0FFh, 36h, 70h, 51h, 0FFh, 36h, 72h, 51h, 0B8h, 1, 0, 33h, 0C9h
	db	0E8h, 0D0h, 89h, 0E8h, 27h, 0, 0E8h, 5Fh, 8Ah, 0E8h, 84h, 88h, 0E8h, 47h, 1, 8Bh
	db	0Eh, 0B6h, 56h, 5Ah, 58h, 0E8h, 0Ah, 82h, 0A0h, 0CAh, 38h, 0A8h, 1, 74h, 0Bh, 80h
	db	26h, 0CAh, 38h, 0FEh, 0B9h, 2Dh, 0, 0E8h, 65h, 7Fh, 0E9h, 12h, 48h, 0E8h, 1Fh, 0
	db	0A1h, 0B6h, 56h, 23h, 0C0h, 74h, 17h, 9Ah
	dd	L101E0
	db	0A1h, 0BAh, 56h, 8Bh, 16h, 0BCh, 56h, 8Bh, 0Eh, 0BEh, 56h, 8Bh, 3Eh, 0C0h, 56h, 0E9h
	db	0A6h, 5Dh, 0C3h, 0E8h, 46h, 0, 0FFh, 36h, 0BAh, 56h, 0FFh, 36h, 0BCh, 56h, 0FFh, 36h
	db	0BEh, 56h, 0FFh, 36h, 0C0h, 56h, 0FFh, 36h, 0D6h, 56h, 0FFh, 36h, 0D4h, 56h, 0E8h, 1Ah
	db	73h, 75h, 0Eh, 3Bh, 6, 5Eh, 58h, 75h, 8, 83h, 0C6h, 2, 0E8h, 1Dh, 0, 0EBh
	db	0EDh, 32h, 0C0h, 8Fh, 6, 0D4h, 56h, 8Fh, 6, 0D6h, 56h, 8Fh, 6, 0C0h, 56h, 8Fh
	db	6, 0BEh, 56h, 8Fh, 6, 0BCh, 56h, 8Fh, 6, 0BAh, 56h, 0C3h, 0FFh, 16h, 0D0h, 56h
	db	75h, 25h, 3Bh, 6, 68h, 57h, 75h, 2Ah, 83h, 0C6h, 2, 0E8h, 0DDh, 72h, 75h, 0Ch
	db	3Bh, 6, 5Eh, 58h, 74h, 6, 3Bh, 6, 5Ch, 58h, 75h, 13h, 0FFh, 16h, 0D2h, 56h
	db	0C6h, 6, 0D7h, 56h, 0, 0EBh, 12h, 0B9h, 84h, 80h, 0E8h, 0C6h, 7Eh, 0EBh, 0EDh, 83h
	db	0EEh, 2, 0FFh, 16h, 0CEh, 56h, 75h, 0E4h, 0C3h, 0A3h, 0BAh, 56h, 89h, 0Eh, 0BCh, 56h
	db	0C7h, 6, 0BEh, 56h, 1, 0, 0C7h, 6, 0C0h, 56h, 0, 0, 0C3h, 3Bh, 26h, 0C6h
	db	38h, 72h, 20h, 83h, 0C6h, 2, 0E8h, 0AEh, 0C4h, 0A3h, 0BEh, 56h, 89h, 0Eh, 0C0h, 56h
	db	0E8h, 0D4h, 88h, 0E8h, 85h, 72h, 75h, 11h, 3Bh, 6, 0C2h, 58h, 75h, 0Bh, 83h, 0C6h
	db	2, 0EBh, 0Ch, 0B9h, 75h, 40h, 0E9h, 7Ah, 7Eh, 0B9h, 5, 0, 0E8h, 74h, 7Eh, 0FFh
	db	36h, 0BEh, 56h, 0FFh, 36h, 0C0h, 56h, 0E8h, 29h, 0FFh, 8Fh, 6, 0C0h, 56h, 8Fh, 6
	db	0BEh, 56h, 0E8h, 56h, 72h, 75h, 0Bh, 3Bh, 6, 5Ch, 58h, 75h, 5, 83h, 0C6h, 2
	db	0EBh, 6, 0B9h, 0, 0, 0E8h, 4Bh, 7Eh, 0A1h, 70h, 51h, 0A3h, 0BAh, 56h, 0A1h, 72h
	db	51h, 0A3h, 0BCh, 56h, 0E8h, 15h, 89h, 32h, 0C0h, 0C3h, 8Ah, 1Eh, 0D7h, 56h, 32h, 0FFh
	db	0D1h, 0E3h, 0FFh, 97h, 92h, 1Fh, 0A1h, 0BEh, 56h, 8Bh, 16h, 0C0h, 56h, 3Dh, 1, 0
	db	75h, 1Bh, 23h, 0D2h, 75h, 17h, 80h, 3Eh, 0DAh, 56h, 21h, 74h, 1, 0C3h, 83h, 3Eh
	db	0BAh, 56h, 1, 75h, 8, 83h, 3Eh, 0BCh, 56h, 0, 75h, 1, 0C3h, 8Bh, 2Eh, 0BAh
	db	56h, 8Bh, 0Eh, 0BCh, 56h, 0E9h, 26h, 82h, 8Bh, 1Eh, 0D8h, 56h, 23h, 0DBh, 75h, 0ECh
	db	8Ah, 1Eh, 0DAh, 56h, 0A1h, 0CCh, 56h, 0E9h, 0BEh, 4Dh, 8Ah, 1Eh, 0D6h, 56h, 0A1h, 0D4h
	db	56h, 0E9h, 17h, 4Eh, 8Ah, 1Eh, 0D6h, 56h, 0A1h, 0D4h, 56h, 0E9h, 54h, 4Eh, 8Ah, 1Eh
	db	0D6h, 56h, 0A1h, 0D4h, 56h, 0E9h, 91h, 4Eh, 8Ah, 1Eh, 0D6h, 56h, 0A1h, 0D4h, 56h, 0E9h
	db	0CEh, 4Eh, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 3, 0E9h, 0AEh, 71h, 0E8h, 40h, 68h
	db	75h, 14h, 56h, 50h, 22h, 0E4h, 75h, 0Ah, 0E8h, 35h, 68h, 75h, 7, 83h, 0C6h, 2
	db	0EBh, 0F2h, 32h, 0C0h, 58h, 5Eh, 0C3h, 8Ah, 1Eh, 0DAh, 56h, 80h, 0EBh, 21h, 32h, 0FFh
	db	0D1h, 0E3h, 0FFh, 0A7h, 70h, 1Fh, 0A1h, 0B8h, 56h, 9Ah
	dd	L101E0
	db	0E8h, 0E2h, 55h, 0E8h, 89h, 7Dh, 8Bh, 0CAh, 50h, 51h, 0E8h, 0BCh, 87h, 0B8h, 1, 0
	db	0E8h, 2Eh, 8Eh, 0E8h, 48h, 88h, 59h, 58h, 0C3h, 0FFh, 36h, 7Ch, 51h, 83h, 0Eh, 7Ch
	db	51h, 8, 0E8h, 0E6h, 0F3h, 8Fh, 6, 7Ch, 51h, 75h, 2Eh, 0E8h, 4Fh, 71h, 75h, 6
	db	3Bh, 6, 58h, 58h, 74h, 44h, 0F6h, 6, 86h, 51h, 80h, 75h, 1Dh, 8Ah, 1Eh, 0DAh
	db	56h, 80h, 0EBh, 21h, 32h, 0FFh, 0D1h, 0E3h, 0FFh, 97h, 64h, 1Fh, 33h, 0C9h, 89h, 1Eh
	db	0D6h, 56h, 89h, 3Eh, 0D4h, 56h, 0E9h, 72h, 0FEh, 0C3h, 83h, 3Eh, 0B0h, 51h, 0, 75h
	db	0DCh, 0A1h, 7Eh, 51h, 3Bh, 6, 98h, 57h, 75h, 0D3h, 0F7h, 6, 82h, 51h, 0, 40h
	db	74h, 0CBh, 0B9h, 7Fh, 80h, 0E8h, 0Dh, 7Dh, 0EBh, 0C3h, 0E9h, 62h, 0FEh, 0C6h, 6, 0D7h
	db	56h, 0, 0E8h, 0F8h, 70h, 75h, 35h, 3Bh, 6, 64h, 57h, 75h, 3Dh, 83h, 0C6h, 2
	db	89h, 36h, 0C2h, 56h, 0BEh, 0FFh, 0B8h, 0A1h, 0B8h, 56h, 9Ah
	dd	L101E0
	db	0E8h, 57h, 54h, 0E8h, 0AEh, 0A1h, 8Bh, 36h, 0C2h, 56h, 0E8h, 0D1h, 70h, 75h, 14h, 3Bh
	db	6, 66h, 57h, 75h, 9, 83h, 0C6h, 2, 0E8h, 7Ch, 0FFh, 32h, 0C0h, 0C3h, 0B9h, 52h
	db	0, 0EBh, 3, 0B9h, 9, 0, 0E8h, 0BDh, 7Ch, 0EBh, 0EDh, 0E8h, 3Eh, 0F3h, 75h, 0EDh
	db	0E8h, 0ABh, 70h, 75h, 9, 3Bh, 6, 58h, 58h, 75h, 3, 0E9h, 2, 0FEh, 0B9h, 4Dh
	db	0, 0E8h, 0A2h, 7Ch, 33h, 0C0h, 33h, 0C9h, 0E9h, 0E1h, 0FDh, 0C6h, 6, 0D7h, 56h, 0
	db	0E8h, 8Bh, 70h, 75h, 63h, 3Bh, 6, 64h, 57h, 75h, 0D0h, 83h, 0C6h, 2, 89h, 36h
	db	0C2h, 56h, 0A1h, 0B8h, 56h, 9Ah
	dd	L101E0
	db	0A1h, 70h, 51h, 0A3h, 0BEh, 56h, 0A1h, 72h, 51h, 0A3h, 0C0h, 56h, 0E8h, 31h, 81h, 0E8h
	db	0CAh, 54h, 0BEh, 9Ch, 1Fh, 9Ah
	dd	L101E0
	db	0E8h, 1, 7Dh, 0A3h, 0BAh, 56h, 89h, 16h, 0BCh, 56h, 0E8h, 6Fh, 0, 8Bh, 36h, 0C2h
	db	56h, 0E8h, 46h, 70h, 75h, 13h, 3Bh, 6, 66h, 57h, 75h, 8, 83h, 0C6h, 2, 32h
	db	0C0h, 0E9h, 8Bh, 0FDh, 0B9h, 52h, 0, 0EBh, 3, 0B9h, 9, 0, 0E8h, 33h, 7Ch, 32h
	db	0C0h, 0E9h, 7Bh, 0FDh, 0C3h, 50h, 52h, 8Bh, 36h, 0C2h, 56h, 0E8h, 1Ch, 70h, 75h, 2Eh
	db	3Bh, 6, 66h, 57h, 74h, 28h, 3Bh, 6, 5Eh, 58h, 74h, 2Ch, 3Bh, 6, 68h, 57h
	db	74h, 23h, 0E8h, 93h, 0F2h, 75h, 17h, 0E8h, 0D6h, 0C1h, 8Bh, 0D1h, 59h, 59h, 50h, 52h
	db	0E8h, 0F7h, 6Fh, 75h, 9, 3Bh, 6, 5Eh, 58h, 75h, 3, 83h, 0C6h, 2, 5Ah, 58h
	db	89h, 36h, 0C2h, 56h, 0C3h, 83h, 0C6h, 2, 5Ah, 58h, 0EBh, 0E2h, 3, 6, 0BEh, 56h
	db	3, 16h, 0C0h, 56h, 2Bh, 6, 70h, 51h, 1Bh, 16h, 72h, 51h, 8Bh, 0C8h, 0Bh, 0CAh
	db	75h, 1, 0C3h, 8Bh, 0CAh, 0E8h, 0Eh, 86h, 0B8h, 1, 0, 0E8h, 80h, 8Ch, 0E9h, 9Ah
	db	86h, 0A1h, 0BAh, 56h, 8Bh, 0Eh, 0BCh, 56h, 2Bh, 6, 70h, 51h, 1Bh, 0Eh, 72h, 51h
	db	72h, 1Ah, 8Bh, 0D8h, 0Bh, 0D9h, 75h, 1, 0C3h, 6, 55h, 0E8h, 0E8h, 85h, 0B8h, 1
	db	0, 0E8h, 5Ah, 8Ch, 0E8h, 74h, 86h, 5Dh, 7, 32h, 0C0h, 0C3h, 0B9h, 4Fh, 0, 0E8h
	db	90h, 7Bh, 32h, 0C0h, 0FEh, 0C8h, 0C3h, 50h, 51h, 8Bh, 36h, 0C2h, 56h, 0E8h, 8, 0F2h
	db	89h, 36h, 0C2h, 56h, 74h, 9, 0B9h, 2, 0, 0E8h, 76h, 7Bh, 0E8h, 0E3h, 9Fh, 59h
	db	58h, 0C3h, 0F9h, 0C3h, 3, 1Eh, 0BEh, 56h, 13h, 16h, 0C0h, 56h, 89h, 1Eh, 0BAh, 56h
	db	89h, 16h, 0BCh, 56h, 8Bh, 36h, 0C2h, 56h, 0E8h, 4Fh, 6Fh, 75h, 63h, 3Bh, 6, 66h
	db	57h, 74h, 5Dh, 3Bh, 6, 5Eh, 58h, 74h, 57h, 3Bh, 6, 68h, 57h, 74h, 4Ch, 3Bh
	db	6, 64h, 57h, 75h, 9, 83h, 0C6h, 2, 89h, 36h, 0C2h, 56h, 0EBh, 6, 0B9h, 4Dh
	db	0, 0E8h, 2Eh, 7Bh, 0E8h, 6Ah, 0FFh, 75h, 0Bh, 0BEh, 9Ch, 1Fh, 0E8h, 0C5h, 7Bh, 0E8h
	db	3Ah, 0FFh, 0EBh, 6, 0BEh, 0D8h, 1Fh, 0E8h, 0BAh, 7Bh, 8Bh, 36h, 0C2h, 56h, 0E8h, 9
	db	6Fh, 75h, 10h, 3Bh, 6, 66h, 57h, 75h, 5, 83h, 0C6h, 2, 0EBh, 38h, 0B9h, 52h
	db	0, 0EBh, 3, 0B9h, 9, 0, 0E8h, 0F9h, 7Ah, 0EBh, 2Bh, 83h, 0C6h, 2, 0EBh, 26h
	db	6, 55h, 0BEh, 0E2h, 1Fh, 0E8h, 8Ch, 7Bh, 5Dh, 7, 73h, 16h, 0E8h, 22h, 0FFh, 75h
	db	0Bh, 0BEh, 0C4h, 1Fh, 0E8h, 7Dh, 7Bh, 0E8h, 0F2h, 0FEh, 0EBh, 6, 0BEh, 0D8h, 1Fh, 0E8h
	db	72h, 7Bh, 8Bh, 36h, 0C2h, 56h, 0E8h, 0C1h, 6Eh, 75h, 9, 3Bh, 6, 5Eh, 58h, 75h
	db	3, 83h, 0C6h, 2, 89h, 36h, 0C2h, 56h, 0F8h, 0C3h, 3, 1Eh, 0BEh, 56h, 13h, 16h
	db	0C0h, 56h, 89h, 1Eh, 0BAh, 56h, 89h, 16h, 0BCh, 56h, 8Bh, 36h, 0C2h, 56h, 0E8h, 99h
	db	6Eh, 75h, 55h, 3Bh, 6, 66h, 57h, 74h, 4Fh, 3Bh, 6, 5Eh, 58h, 74h, 49h, 3Bh
	db	6, 68h, 57h, 74h, 3Eh, 0E8h, 0C9h, 0FEh, 75h, 31h, 0FFh, 36h, 0C4h, 56h, 0FFh, 36h
	db	0C6h, 56h, 0C7h, 6, 0C4h, 56h, 0, 0, 0C7h, 6, 0C6h, 56h, 0, 0, 0BEh, 0A6h
	db	1Fh, 0E8h, 10h, 7Bh, 83h, 3Eh, 0C6h, 56h, 0, 74h, 6, 0B9h, 50h, 0, 0E8h, 61h
	db	7Ah, 8Fh, 6, 0C6h, 56h, 8Fh, 6, 0C4h, 56h, 0EBh, 24h, 0BEh, 0CEh, 1Fh, 0E8h, 0F3h
	db	7Ah, 0EBh, 1Ch, 83h, 0C6h, 2, 0EBh, 1Bh, 6, 55h, 0BEh, 0E2h, 1Fh, 0E8h, 0E4h, 7Ah
	db	5Dh, 7, 73h, 0Bh, 0E8h, 7Ah, 0FEh, 75h, 1Dh, 0BEh, 0BAh, 1Fh, 0E8h, 0D5h, 7Ah, 8Bh
	db	36h, 0C2h, 56h, 0E8h, 24h, 6Eh, 75h, 9, 3Bh, 6, 5Eh, 58h, 75h, 3, 83h, 0C6h
	db	2, 89h, 36h, 0C2h, 56h, 0F8h, 0C3h, 0FFh, 36h, 0C8h, 56h, 0FFh, 36h, 0CAh, 56h, 50h
	db	51h, 33h, 0C0h, 0A3h, 0C8h, 56h, 0A3h, 0CAh, 56h, 0BEh, 0B0h, 1Fh, 0E8h, 0A5h, 7Ah, 5Fh
	db	5Eh, 8Bh, 1Eh, 0C8h, 56h, 8Bh, 0Eh, 0CAh, 56h, 0E8h, 71h, 93h, 5Ah, 58h, 3, 0C3h
	db	13h, 0D1h, 0A3h, 0C8h, 56h, 89h, 16h, 0CAh, 56h, 0C3h, 1, 0Eh, 0C8h, 56h, 83h, 16h
	db	0C8h, 56h, 0, 0C3h, 83h, 3Eh, 0C6h, 56h, 0, 75h, 49h, 83h, 3Eh, 0C4h, 56h, 0
	db	75h, 50h, 50h, 51h, 6, 55h, 33h, 0C0h, 0A3h, 0C8h, 56h, 0A3h, 0CAh, 56h, 0BEh, 0B0h
	db	1Fh, 0E8h, 60h, 7Ah, 0E8h, 30h, 0FEh, 83h, 3Eh, 0CAh, 56h, 0, 75h, 22h, 83h, 3Eh
	db	0C8h, 56h, 1, 75h, 1Bh, 0E8h, 52h, 0C0h, 5Dh, 7, 8Bh, 0D0h, 59h, 58h, 2Bh, 0C2h
	db	83h, 0D9h, 0, 72h, 0Fh, 75h, 1Bh, 23h, 0C0h, 75h, 17h, 0FFh, 6, 0C4h, 56h, 0C3h
	db	5Dh, 7, 59h, 58h, 0C7h, 6, 0C6h, 56h, 0, 0, 51h, 0B9h, 50h, 0, 0E8h, 81h
	db	79h, 59h, 0FFh, 6, 0C4h, 56h, 0EBh, 57h, 0A1h, 0C6h, 56h, 23h, 0C0h, 75h, 1Dh, 83h
	db	3Eh, 0C4h, 56h, 0, 75h, 24h, 0E8h, 0DEh, 0FDh, 0FFh, 6, 0C4h, 56h, 83h, 0F9h, 0Bh
	db	73h, 10h, 8Bh, 0D9h, 0D1h, 0E3h, 51h, 0FFh, 97h, 7Ch, 1Fh, 59h, 2Bh, 0C1h, 0A3h, 0C6h
	db	56h, 0C3h, 51h, 0B9h, 50h, 0, 0E8h, 49h, 79h, 59h, 0FFh, 6, 0C4h, 56h, 83h, 0F9h
	db	1, 75h, 8, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 5, 0E8h, 1Bh, 7Fh, 0F8h, 0C3h
	db	16h, 7, 0BFh, 0ECh, 1Fh, 0EBh, 0F4h, 83h, 3Eh, 0C4h, 56h, 0, 75h, 1Ah, 0C3h, 6
	db	55h, 0E8h, 62h, 83h, 5Dh, 7, 0BEh, 0BAh, 1Fh, 0E8h, 0B8h, 79h, 0E8h, 0ECh, 83h, 0F8h
	db	0C3h, 8Bh, 0C1h, 0E8h, 0C8h, 89h, 0F8h, 0C3h, 3, 1Eh, 0BEh, 56h, 13h, 16h, 0C0h, 56h
	db	0E8h, 0Ah, 7Fh, 0F8h, 0C3h, 3, 1Eh, 0BEh, 56h, 13h, 16h, 0C0h, 56h, 89h, 1Eh, 0BAh
	db	56h, 89h, 16h, 0BCh, 56h, 6, 55h, 0BEh, 0E2h, 1Fh, 0E8h, 87h, 79h, 5Dh, 7, 73h
	db	38h, 0E8h, 1Dh, 0FDh, 75h, 33h, 0BEh, 0BAh, 1Fh, 0E8h, 78h, 79h, 0E8h, 0EDh, 0FCh, 0F8h
	db	0C3h, 3, 1Eh, 0BEh, 56h, 13h, 16h, 0C0h, 56h, 89h, 1Eh, 0BAh, 56h, 89h, 16h, 0BCh
	db	56h, 6, 55h, 0BEh, 0E2h, 1Fh, 0E8h, 5Bh, 79h, 5Dh, 7, 73h, 0Ch, 0E8h, 0F1h, 0FCh
	db	75h, 7, 0BEh, 0BAh, 1Fh, 0E8h, 4Ch, 79h, 0F8h, 0C3h, 8Bh, 36h, 0C2h, 56h, 0E8h, 27h
	db	0EFh, 75h, 4, 89h, 36h, 0C2h, 56h, 0C3h, 8Bh, 36h, 0C2h, 56h, 0E8h, 8Bh, 6Ch, 75h
	db	4Dh, 3Bh, 6, 66h, 57h, 74h, 47h, 3Bh, 6, 5Eh, 58h, 74h, 41h, 3Bh, 6, 68h
	db	57h, 74h, 38h, 3Bh, 6, 64h, 57h, 75h, 5, 83h, 0C6h, 2, 0EBh, 6, 0B9h, 4Dh
	db	0, 0E8h, 6Eh, 78h, 0BEh, 0CEh, 1Fh, 0E8h, 0Ah, 79h, 8Bh, 36h, 0C2h, 56h, 0E8h, 59h
	db	6Ch, 75h, 10h, 3Bh, 6, 66h, 57h, 75h, 5, 83h, 0C6h, 2, 0EBh, 10h, 0B9h, 52h
	db	0, 0EBh, 3, 0B9h, 9, 0, 0E8h, 49h, 78h, 0EBh, 3, 83h, 0C6h, 2, 0E8h, 39h
	db	6Ch, 75h, 9, 3Bh, 6, 5Eh, 58h, 75h, 3, 83h, 0C6h, 2, 89h, 36h, 0C2h, 56h
	db	0F8h, 0C3h, 8Bh, 36h, 0C2h, 56h, 0E8h, 21h, 6Ch, 75h, 34h, 3Bh, 6, 66h, 57h, 74h
	db	2Eh, 3Bh, 6, 5Eh, 58h, 74h, 28h, 3Bh, 6, 68h, 57h, 74h, 0Ch, 0BEh, 0CEh, 1Fh
	db	0E8h, 0B1h, 78h, 8Bh, 36h, 0C2h, 56h, 0EBh, 3, 83h, 0C6h, 2, 0E8h, 0FBh, 6Bh, 75h
	db	9, 3Bh, 6, 5Eh, 58h, 75h, 3, 83h, 0C6h, 2, 89h, 36h, 0C2h, 56h, 0F8h, 0C3h
	db	0BEh, 0E2h, 1Fh, 0E9h, 8Eh, 78h, 0F9h, 0C3h, 0F8h, 0C3h, 0B0h, 98h, 0EBh, 36h, 0B0h, 0A7h
	db	0EBh, 32h, 0B0h, 99h, 0EBh, 2Eh, 0B0h, 6Dh, 0EBh, 2Ah, 0B0h, 0CFh, 0EBh, 26h, 0B0h, 0ADh
	db	0EBh, 22h, 0B0h, 0A5h, 0EBh, 1Eh, 0B0h, 6Fh, 0EBh, 1Ah, 0B0h, 61h, 0EBh, 16h, 0B0h, 9Dh
	db	0EBh, 12h, 0B0h, 60h, 0EBh, 0Eh, 0B0h, 9Ch, 0EBh, 0Ah, 0B0h, 0AFh, 0EBh, 6, 0B0h, 0C9h
	db	0EBh, 2, 0B0h, 0ABh, 0A2h, 0DCh, 56h, 0E8h, 83h, 40h, 75h, 12h, 0F7h, 6, 7Ch, 51h
	db	8, 0, 74h, 0Dh, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 0CCh, 0D2h, 0E9h, 44h, 40h, 0E9h, 2Dh
	db	6Bh, 0E9h, 38h, 40h, 0B0h, 0B2h, 0EBh, 6, 0B0h, 0B4h, 0EBh, 2, 0B0h, 0B5h, 0A2h, 0DCh
	db	56h, 0E8h, 59h, 40h, 75h, 0E8h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 0E3h, 0E8h, 2
	db	41h, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 0ADh, 0D2h, 0E9h, 17h, 40h, 0B0h, 20h, 0EBh, 0Ah, 0B0h
	db	38h, 0EBh, 6, 0B0h, 30h, 0EBh, 2, 0B0h, 28h, 0A2h, 0DCh, 56h, 0E8h, 2Eh, 40h, 75h
	db	0BDh, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 0B8h, 0E8h, 0D7h, 40h, 8Ah, 0Eh, 0DCh, 56h
	db	0E8h, 1Eh, 0D1h, 0E9h, 0ECh, 3Fh, 0B0h, 0BCh, 0EBh, 2, 0B0h, 0BDh, 0A2h, 0DCh, 56h, 0E8h
	db	0Bh, 40h, 75h, 9Ah, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 95h, 0E8h, 0B4h, 40h, 8Ah
	db	0Eh, 0DCh, 56h, 0E8h, 5Bh, 0D1h, 0E9h, 0C9h, 3Fh, 0B0h, 0BEh, 0EBh, 2, 0B0h, 0B6h, 0A2h
	db	0DCh, 56h, 0E8h, 0E8h, 3Fh, 75h, 38h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 33h, 0E8h
	db	91h, 40h, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 68h, 0D1h, 0E9h, 0A6h, 3Fh, 0B0h, 0A4h, 0EBh, 2
	db	0B0h, 0ACh, 0A2h, 0DCh, 56h, 0E8h, 0C5h, 3Fh, 75h, 15h, 0F7h, 6, 7Ch, 51h, 8, 0
	db	74h, 10h, 0E8h, 0B7h, 40h, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 90h, 0D1h, 0E9h, 83h, 3Fh, 0E9h
	db	6Ch, 6Ah, 0E9h, 77h, 3Fh, 0B0h, 97h, 0EBh, 3Ah, 0B0h, 93h, 0EBh, 36h, 0B0h, 92h, 0EBh
	db	32h, 0B0h, 96h, 0EBh, 2Eh, 0B0h, 94h, 0EBh, 2Ah, 0B0h, 9Fh, 0EBh, 26h, 0B0h, 9Dh, 0EBh
	db	22h, 0B0h, 9Ch, 0EBh, 1Eh, 0B0h, 9Eh, 0EBh, 1Ah, 0B0h, 95h, 0EBh, 16h, 0B0h, 91h, 0EBh
	db	12h, 0B0h, 9Bh, 0EBh, 0Eh, 0B0h, 99h, 0EBh, 0Ah, 0B0h, 90h, 0EBh, 6, 0B0h, 9Ah, 0EBh
	db	2, 0B0h, 98h, 0A2h, 0DCh, 56h, 0E8h, 64h, 3Fh, 75h, 0B4h, 0F7h, 6, 7Ch, 51h, 8
	db	0, 74h, 0AFh, 0E8h, 0FEh, 3Fh, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 14h, 0D1h, 0E9h, 22h, 3Fh
	db	0B0h, 0E3h, 0EBh, 0Ah, 0B0h, 0E2h, 0EBh, 6, 0B0h, 0E1h, 0EBh, 2, 0B0h, 0E0h, 0A2h, 0DCh
	db	56h, 0E8h, 39h, 3Fh, 75h, 89h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 84h, 0E8h, 0D3h
	db	3Fh, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 47h, 0C2h, 0E9h, 0F7h, 3Eh, 0E8h, 1Fh, 3Fh, 75h, 6Ah
	db	0F7h, 6, 7Ch, 51h, 10h, 0, 74h, 65h, 0E8h, 0B9h, 3Fh, 0E8h, 0A7h, 0D1h, 0E9h, 0E1h
	db	3Eh, 0B0h, 0C0h, 0EBh, 2, 0B0h, 0A6h, 0A2h, 0DCh, 56h, 0E8h, 0, 3Fh, 75h, 4Bh, 0F7h
	db	6, 7Ch, 51h, 10h, 0, 74h, 46h, 0E8h, 0A9h, 3Fh, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 0A8h
	db	0D1h, 0E9h, 0BEh, 3Eh, 0E8h, 0E6h, 3Eh, 75h, 31h, 0F7h, 6, 7Ch, 51h, 80h, 0, 74h
	db	2Ch, 0E8h, 8Fh, 3Fh, 6, 55h, 8Eh, 0C0h, 8Bh, 0EFh, 5Fh, 58h, 0B1h, 63h, 0E8h, 6Ch
	db	0CFh, 0E9h, 9Eh, 3Eh, 0E8h, 0C6h, 3Eh, 75h, 11h, 0F7h, 6, 7Ch, 51h, 80h, 0, 74h
	db	0Ch, 0B9h, 0Fh, 6, 0E8h, 0F1h, 0C3h, 0E9h, 88h, 3Eh, 0E9h, 71h, 69h, 0E9h, 7Ch, 3Eh
	db	0B0h, 2, 0EBh, 2, 0B0h, 3, 0A2h, 0DCh, 56h, 0E8h, 0A1h, 3Eh, 75h, 0ECh, 0F7h, 6
	db	7Ch, 51h, 80h, 0, 74h, 0E7h, 0E8h, 4Ah, 3Fh, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 5Dh, 0CFh
	db	0E9h, 5Fh, 3Eh, 0B0h, 10h, 0EBh, 0Ah, 0B0h, 18h, 0EBh, 6, 0B0h, 0, 0EBh, 2, 0B0h
	db	8, 0B4h, 1, 0A3h, 0DCh, 56h, 0E8h, 74h, 3Eh, 75h, 0BFh, 0F7h, 6, 7Ch, 51h, 80h
	db	0, 74h, 0BAh, 0E8h, 0Eh, 3Fh, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 73h, 0CEh, 0E9h, 32h, 3Eh
	db	0B0h, 10h, 0EBh, 1Ah, 0B0h, 30h, 0EBh, 1Ah, 0B0h, 18h, 0EBh, 12h, 0B0h, 0, 0EBh, 0Eh
	db	0B0h, 20h, 0EBh, 0Eh, 0B0h, 8, 0EBh, 6, 0B0h, 20h, 0EBh, 2, 0B0h, 28h, 32h, 0E4h
	db	0EBh, 2, 0B4h, 1, 0A3h, 0DCh, 56h, 0E8h, 33h, 3Eh, 75h, 5Fh, 0F7h, 6, 7Ch, 51h
	db	80h, 0, 74h, 5Ah, 0E8h, 0CDh, 3Eh, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 6Ch, 0CEh, 0E9h, 0F1h
	db	3Dh, 0B0h, 8, 0EBh, 2, 0B0h, 9, 8Ah, 0E0h, 0B0h, 0Fh, 0A3h, 0DCh, 56h, 0E8h, 0Ch
	db	3Eh, 75h, 38h, 0F7h, 6, 7Ch, 51h, 10h, 0, 74h, 33h, 0F7h, 6, 7Ch, 51h, 80h
	db	0, 74h, 2Bh, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 2Eh, 0C3h, 0E9h, 0C5h, 3Dh, 0E8h, 0EDh, 3Dh
	db	75h, 19h, 0F7h, 6, 7Ch, 51h, 10h, 0, 74h, 14h, 0F7h, 6, 7Ch, 51h, 80h, 0
	db	74h, 0Ch, 0E8h, 7Fh, 3Eh, 0E8h, 0CEh, 0D0h, 0E9h, 0A7h, 3Dh, 0E9h, 90h, 68h, 0E9h, 9Bh
	db	3Dh, 0E8h, 0C9h, 3Dh, 75h, 0F5h, 0F7h, 6, 7Ch, 51h, 2, 0, 74h, 0F0h, 0E8h, 72h
	db	3Eh, 0B1h, 62h, 0E8h, 16h, 0CEh, 0E9h, 89h, 3Dh, 0E8h, 0B1h, 3Dh, 75h, 0DDh, 0F7h, 6
	db	7Ch, 51h, 2, 0, 74h, 0D8h, 0E8h, 5Ah, 3Eh, 0E8h, 3Eh, 0CCh, 0E9h, 73h, 3Dh, 0E8h
	db	9Bh, 3Dh, 75h, 0C7h, 0E8h, 4Ch, 3Eh, 0E8h, 59h, 0CCh, 0E9h, 65h, 3Dh, 0E8h, 8Dh, 3Dh
	db	75h, 0B9h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 0B4h, 0E8h, 36h, 3Eh, 0E8h, 4Bh, 0CCh
	db	0E9h, 4Fh, 3Dh, 0E8h, 77h, 3Dh, 75h, 0A3h, 0F7h, 6, 7Ch, 51h, 2, 0, 74h, 9Eh
	db	0E8h, 0F1h, 98h, 0E8h, 1Dh, 3Eh, 0B1h, 6Ch, 0E8h, 30h, 0CDh, 0E8h, 0EDh, 98h, 0E9h, 31h
	db	3Dh, 0E8h, 59h, 3Dh, 75h, 85h, 0F7h, 6, 7Ch, 51h, 2, 0, 74h, 80h, 0E8h, 2
	db	3Eh, 6, 55h, 8Eh, 0C0h, 8Bh, 0EFh, 5Fh, 58h, 0B1h, 6Eh, 0E8h, 0Dh, 0CDh, 0E9h, 11h
	db	3Dh, 0B0h, 6Ch, 0EBh, 6, 0B0h, 6Eh, 0EBh, 2, 0B0h, 0C9h, 0A2h, 0DCh, 56h, 0E8h, 2Ch
	db	3Dh, 75h, 5Fh, 0F7h, 6, 7Ch, 51h, 2, 0, 74h, 5Ah, 8Ah, 0Eh, 0DCh, 56h, 0E8h
	db	35h, 0C2h, 0E9h, 0EDh, 3Ch, 0B0h, 60h, 0EBh, 0Ah, 0B0h, 61h, 0EBh, 6, 0B0h, 6Dh, 0EBh
	db	2, 0B0h, 6Fh, 0A2h, 0DCh, 56h, 0E8h, 4, 3Dh, 75h, 37h, 0F7h, 6, 7Ch, 51h, 2
	db	0, 74h, 32h, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 0FFh, 0C1h, 0E9h, 0C5h, 3Ch, 0B0h, 20h, 0EBh
	db	2, 0B0h, 30h, 0A2h, 0DCh, 56h, 0E8h, 0E4h, 3Ch, 75h, 17h, 0F7h, 6, 7Ch, 51h, 0
	db	1, 74h, 12h, 0E8h, 7Eh, 3Dh, 8Ah, 0Eh, 0DCh, 56h, 0B5h, 0DFh, 0E8h, 7Fh, 0BDh, 0E9h
	db	0A0h, 3Ch, 0E9h, 89h, 67h, 0E9h, 94h, 3Ch, 0E8h, 0C2h, 3Ch, 75h, 0F5h, 0F7h, 6, 7Ch
	db	51h, 0, 1, 74h, 0F0h, 0E8h, 40h, 0BDh, 0E9h, 87h, 3Ch, 0B8h, 28h, 0, 0EBh, 3
	db	0B8h, 38h, 18h, 0A3h, 0DCh, 56h, 0E8h, 0A4h, 3Ch, 75h, 0D7h, 0F7h, 6, 7Ch, 51h, 0
	db	1, 74h, 0D2h, 0E8h, 1Bh, 0EBh, 74h, 0Fh, 0E8h, 4Dh, 0EAh, 75h, 1Dh, 8Bh, 0Eh, 0DCh
	db	56h, 0E8h, 55h, 0BEh, 0E9h, 5Bh, 3Ch, 0B5h, 0D9h, 8Ah, 0Eh, 0DDh, 56h, 22h, 0C9h, 74h
	db	3, 80h, 0CDh, 4, 0E8h, 0E0h, 0BEh, 0E9h, 48h, 3Ch, 8Ah, 0Eh, 0DDh, 56h, 0B5h, 0D9h
	db	22h, 0C9h, 74h, 3, 80h, 0CDh, 4, 80h, 0C9h, 0C1h, 0E8h, 88h, 0BEh, 0E9h, 32h, 3Ch
	db	0B8h, 28h, 0, 0EBh, 3, 0B8h, 38h, 18h, 0A3h, 0DCh, 56h, 0E8h, 4Fh, 3Ch, 75h, 15h
	db	0F7h, 6, 7Ch, 51h, 0, 1, 74h, 10h, 0E8h, 0E9h, 3Ch, 8Bh, 0Eh, 0DCh, 56h, 0E8h
	db	2Ch, 0BEh, 0E9h, 0Dh, 3Ch, 0E9h, 0F6h, 66h, 0E9h, 1, 3Ch, 0B8h, 20h, 0D9h, 0EBh, 0Dh
	db	0B8h, 20h, 0DDh, 0EBh, 8, 0B8h, 30h, 0DDh, 0EBh, 3, 0B8h, 30h, 0D9h, 0A3h, 0DCh, 56h
	db	0E8h, 1Ah, 3Ch, 75h, 0E0h, 0F7h, 6, 7Ch, 51h, 0, 1, 74h, 0DBh, 0E8h, 0B4h, 3Ch
	db	8Bh, 0Eh, 0DCh, 56h, 0E8h, 0C9h, 0BCh, 0E9h, 0D8h, 3Bh, 0B8h, 30h, 0DDh, 0EBh, 3, 0B8h
	db	30h, 0D9h, 0A3h, 0DCh, 56h, 0E8h, 0F5h, 3Bh, 75h, 0BBh, 0F7h, 6, 7Ch, 51h, 0, 1
	db	74h, 0B6h, 0E8h, 8Fh, 3Ch, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 0BBh, 0BCh, 0E9h, 0B3h, 3Bh, 0E8h
	db	0DBh, 3Bh, 75h, 0A1h, 0F7h, 6, 7Ch, 51h, 0, 1, 74h, 9Ch, 0E8h, 75h, 3Ch, 0B9h
	db	38h, 0DDh, 0E8h, 0F5h, 0BCh, 0E9h, 9Ah, 3Bh, 0B8h, 28h, 0D9h, 0EBh, 3, 0B8h, 38h, 0D9h
	db	0A3h, 0DCh, 56h, 0E8h, 0B7h, 3Bh, 75h, 4Eh, 0F7h, 6, 7Ch, 51h, 0, 1, 74h, 49h
	db	0E8h, 51h, 3Ch, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 2Eh, 0BDh, 0E9h, 75h, 3Bh, 0E8h, 9Dh, 3Bh
	db	75h, 34h, 0F7h, 6, 7Ch, 51h, 0, 1, 74h, 2Fh, 0E8h, 37h, 3Ch, 0B9h, 38h, 0DDh
	db	0E8h, 76h, 0BCh, 0E9h, 5Ch, 3Bh, 0B8h, 38h, 0D9h, 0A3h, 0DCh, 56h, 0E8h, 7Eh, 3Bh, 75h
	db	15h, 0F7h, 6, 7Ch, 51h, 0, 1, 74h, 10h, 0E8h, 18h, 3Ch, 8Bh, 0Eh, 0DCh, 56h
	db	0E8h, 0Fh, 0BDh, 0E9h, 3Ch, 3Bh, 0E9h, 25h, 66h, 0E9h, 30h, 3Bh, 0B8h, 0F0h, 0D9h, 0E9h
	db	86h, 0, 0B8h, 0E1h, 0D9h, 0E9h, 80h, 0, 0B8h, 0E0h, 0D9h, 0EBh, 7Bh, 0B8h, 0E2h, 0DBh
	db	0EBh, 76h, 0B8h, 0F6h, 0D9h, 0EBh, 71h, 0B8h, 0E1h, 0DBh, 0EBh, 6Ch, 0B8h, 0E0h, 0DBh, 0EBh
	db	67h, 0B8h, 0F7h, 0D9h, 0EBh, 62h, 0B8h, 0E3h, 0DBh, 0EBh, 5Dh, 0B8h, 0E8h, 0D9h, 0EBh, 58h
	db	0B8h, 0EAh, 0D9h, 0EBh, 53h, 0B8h, 0E9h, 0D9h, 0EBh, 4Eh, 0B8h, 0ECh, 0D9h, 0EBh, 49h, 0B8h
	db	0EDh, 0D9h, 0EBh, 44h, 0B8h, 0EBh, 0D9h, 0EBh, 3Fh, 0B8h, 0EEh, 0D9h, 0EBh, 3Ah, 0B8h, 0D0h
	db	0D9h, 0EBh, 35h, 0B8h, 0F3h, 0D9h, 0EBh, 30h, 0B8h, 0F8h, 0D9h, 0EBh, 2Bh, 0B8h, 0F2h, 0D9h
	db	0EBh, 26h, 0B8h, 0FCh, 0D9h, 0EBh, 21h, 0B8h, 0FDh, 0D9h, 0EBh, 1Ch, 0B8h, 0FAh, 0D9h, 0EBh
	db	17h, 0B8h, 0E4h, 0D9h, 0EBh, 12h, 0B8h, 0E5h, 0D9h, 0EBh, 0Dh, 0B8h, 0F4h, 0D9h, 0EBh, 8
	db	0B8h, 0F1h, 0D9h, 0EBh, 3, 0B8h, 0F9h, 0D9h, 0A3h, 0DCh, 56h, 0E8h, 0CFh, 3Ah, 75h, 4Ch
	db	0F7h, 6, 7Ch, 51h, 0, 1, 74h, 47h, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 0E6h, 0BCh, 0E9h
	db	90h, 3Ah, 0B8h, 0F5h, 0D9h, 0EBh, 12h, 0B8h, 0FFh, 0D9h, 0EBh, 0Dh, 0B8h, 0FEh, 0D9h, 0EBh
	db	8, 0B8h, 0FBh, 0D9h, 0EBh, 3, 0B8h, 0E9h, 0DAh, 0A3h, 0DCh, 56h, 0E8h, 9Eh, 3Ah, 75h
	db	1Bh, 0F7h, 6, 7Ch, 51h, 0, 8, 0EBh, 0CDh, 0C7h, 6, 0DCh, 56h, 0E4h, 0DBh, 0E8h
	db	8Bh, 3Ah, 75h, 8, 0F7h, 6, 7Ch, 51h, 0, 4, 0EBh, 0BAh, 0E9h, 3Fh, 65h, 0E9h
	db	4Ah, 3Ah, 0B8h, 0E2h, 0DBh, 0EBh, 0Dh, 0B8h, 0E1h, 0DBh, 0EBh, 8, 0B8h, 0E0h, 0DBh, 0EBh
	db	3, 0B8h, 0E3h, 0DBh, 0A3h, 0DCh, 56h, 0E8h, 63h, 3Ah, 75h, 0E0h, 0F7h, 6, 7Ch, 51h
	db	0, 1, 74h, 0DBh, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 0ACh, 0BCh, 0E9h, 24h, 3Ah, 0B0h, 0
	db	0EBh, 16h, 0B0h, 38h, 0EBh, 12h, 0B0h, 30h, 0EBh, 0Eh, 0B0h, 8, 0EBh, 0Ah, 0B0h, 28h
	db	0EBh, 6, 0B0h, 20h, 0EBh, 2, 0B0h, 18h, 0A2h, 0DCh, 56h, 0E8h, 2Fh, 3Ah, 75h, 0ACh
	db	0F7h, 6, 7Ch, 51h, 0, 1, 74h, 0A7h, 0E8h, 0A6h, 0E8h, 75h, 2Ah, 0E8h, 3Ah, 65h
	db	75h, 1Ch, 3Bh, 6, 5Eh, 58h, 75h, 16h, 83h, 0C6h, 2, 6, 55h, 0E8h, 91h, 0E8h
	db	5Fh, 58h, 8Ah, 0Eh, 0DCh, 56h, 0B5h, 0DEh, 0E8h, 7Bh, 0BCh, 0E9h, 0D4h, 39h, 6, 55h
	db	0E8h, 8Fh, 95h, 5Fh, 58h, 0EBh, 0EBh, 0B5h, 0DEh, 8Ah, 0Eh, 0DCh, 56h, 80h, 0C9h, 0C1h
	db	0E8h, 12h, 0BCh, 0E9h, 0BCh, 39h, 0B8h, 20h, 0DDh, 0EBh, 3, 0B8h, 28h, 0DDh, 0A3h, 0DCh
	db	56h, 0E8h, 0D9h, 39h, 75h, 3Ch, 0F7h, 6, 7Ch, 51h, 0, 8, 0EBh, 16h, 0B8h, 0
	db	0DDh, 0EBh, 3, 0B8h, 8, 0D9h, 0A3h, 0DCh, 56h, 0E8h, 0C1h, 39h, 75h, 24h, 0F7h, 6
	db	7Ch, 51h, 0, 1, 74h, 1Fh, 0E8h, 38h, 0E8h, 74h, 0Dh, 8Bh, 0Eh, 0DCh, 56h, 80h
	db	0C9h, 0C1h, 0E8h, 0D0h, 0BBh, 0E9h, 7Ah, 39h, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 8, 0BCh, 0E9h
	db	70h, 39h, 0E9h, 59h, 64h, 0E9h, 64h, 39h, 0B8h, 0, 0DAh, 0EBh, 26h, 0B8h, 10h, 0DAh
	db	0EBh, 21h, 0B8h, 18h, 0DAh, 0EBh, 1Ch, 0B8h, 30h, 0DAh, 0EBh, 17h, 0B8h, 38h, 0DAh, 0EBh
	db	12h, 0B8h, 8, 0DAh, 0EBh, 0Dh, 0B8h, 10h, 0DBh, 0EBh, 8, 0B8h, 20h, 0DAh, 0EBh, 3
	db	0B8h, 28h, 0DAh, 0A3h, 0DCh, 56h, 0E8h, 64h, 39h, 75h, 0C7h, 0F7h, 6, 7Ch, 51h, 0
	db	1, 74h, 0C2h, 0E8h, 0FEh, 39h, 8Bh, 0Eh, 0DCh, 56h, 0E8h, 66h, 0BBh, 0E9h, 22h, 39h
	db	0B8h, 0, 0, 0EBh, 19h, 0B8h, 8, 8, 0EBh, 14h, 0B8h, 38h, 30h, 0EBh, 0Fh, 0B8h
	db	30h, 38h, 0EBh, 0Ah, 0B8h, 28h, 20h, 0EBh, 5, 0B8h, 20h, 28h, 0EBh, 0, 0A3h, 0DCh
	db	56h, 0E8h, 29h, 39h, 75h, 8Ch, 0F7h, 6, 7Ch, 51h, 0, 1, 74h, 87h, 0E8h, 0A0h
	db	0E7h, 74h, 11h, 0E8h, 0D2h, 0E6h, 75h, 4Dh, 0B5h, 0D8h, 8Ah, 0Eh, 0DDh, 56h, 0E8h, 0C6h
	db	0BAh, 0E9h, 0DEh, 38h, 0E8h, 23h, 64h, 75h, 2Dh, 3Bh, 6, 5Eh, 58h, 75h, 27h, 83h
	db	0C6h, 2, 6, 55h, 0E8h, 7Ah, 0E7h, 5Fh, 58h, 74h, 0Dh, 0B9h, 12h, 0, 50h, 57h
	db	0E8h, 0Fh, 70h, 0E8h, 7Ch, 94h, 5Fh, 58h, 8Bh, 0Eh, 0DCh, 56h, 8Ah, 0F5h, 0B5h, 0D8h
	db	0E8h, 73h, 0BBh, 0E9h, 0ACh, 38h, 0B9h, 0Dh, 0, 0E8h, 0F6h, 6Fh, 6, 55h, 0E8h, 61h
	db	94h, 5Fh, 58h, 0EBh, 0E3h, 0B5h, 0DEh, 8Ah, 0Eh, 0DCh, 56h, 80h, 0C9h, 0C1h, 0E8h, 0E4h
	db	0BAh, 0E9h, 8Eh, 38h, 0B8h, 10h, 0D9h, 0EBh, 8, 0B8h, 10h, 0D8h, 0EBh, 3, 0B8h, 18h
	db	0D8h, 0A3h, 0DCh, 56h, 0E8h, 0A6h, 38h, 75h, 43h, 0F7h, 6, 7Ch, 51h, 0, 1, 74h
	db	3Eh, 0E8h, 1Dh, 0E7h, 74h, 0Fh, 0E8h, 4Fh, 0E6h, 75h, 1Ch, 8Bh, 0Eh, 0DCh, 56h, 0E8h
	db	45h, 0BAh, 0E9h, 5Dh, 38h, 8Bh, 0Eh, 0DCh, 56h, 0F6h, 0C5h, 1, 74h, 3, 80h, 0CDh
	db	4, 0E8h, 0E3h, 0BAh, 0E9h, 4Bh, 38h, 8Bh, 0Eh, 0DCh, 56h, 0F6h, 0C5h, 1, 74h, 3
	db	80h, 0CDh, 4, 80h, 0C9h, 0C1h, 0E8h, 8Ch, 0BAh, 0E9h, 36h, 38h, 0E9h, 1Fh, 63h, 0E9h
	db	2Ah, 38h, 0E8h, 58h, 38h, 75h, 0F5h, 0E8h, 9, 39h, 0E8h, 1Ch, 0C0h, 0E9h, 22h, 38h
	db	0E8h, 4Ah, 38h, 75h, 0E7h, 0E8h, 0FBh, 38h, 0E8h, 0BEh, 0C0h, 0E9h, 14h, 38h, 32h, 0C0h
	db	0EBh, 1Ah, 0B0h, 8, 0EBh, 16h, 0B0h, 10h, 0EBh, 12h, 0B0h, 18h, 0EBh, 0Eh, 0B0h, 20h
	db	0EBh, 0Ah, 0B0h, 28h, 0EBh, 6, 0B0h, 30h, 0EBh, 2, 0B0h, 38h, 0A2h, 0DCh, 56h, 0E8h
	db	1Bh, 38h, 75h, 0B8h, 0E8h, 0CCh, 38h, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 0F7h, 0C2h, 0E9h, 0E1h
	db	37h, 0E8h, 9, 38h, 75h, 0A6h, 0E8h, 0ABh, 38h, 0E8h, 31h, 0BFh, 0E9h, 0D3h, 37h, 0E8h
	db	0FBh, 37h, 75h, 4Ah, 0E8h, 0ACh, 38h, 0E8h, 47h, 0BFh, 0E9h, 0C5h, 37h, 32h, 0C0h, 0EBh
	db	2, 0B0h, 8, 0A2h, 0DCh, 56h, 0E8h, 0E4h, 37h, 75h, 33h, 0E8h, 86h, 38h, 8Ah, 0Eh
	db	0DCh, 56h, 0E8h, 6Ah, 0BFh, 0E9h, 0AAh, 37h, 0E8h, 0D2h, 37h, 75h, 21h, 0E8h, 74h, 38h
	db	0E8h, 0C2h, 0C3h, 0E8h, 82h, 0E5h, 74h, 0F8h, 0E9h, 97h, 37h, 0E8h, 0BFh, 37h, 75h, 0Eh
	db	0E8h, 61h, 38h, 0E8h, 39h, 0C5h, 0E8h, 6Fh, 0E5h, 74h, 0F8h, 0E9h, 84h, 37h, 0E9h, 6Dh
	db	62h, 0B0h, 0D5h, 0EBh, 2, 0B0h, 0D4h, 0A2h, 0DCh, 56h, 0E8h, 0A0h, 37h, 75h, 0EFh, 0E8h
	db	56h, 0E5h, 8Ah, 0Eh, 0DCh, 56h, 75h, 6, 0E8h, 4, 0BEh, 0E9h, 64h, 37h, 0B5h, 0Ah
	db	0E8h, 0C5h, 0BCh, 0E9h, 5Ch, 37h, 0E8h, 84h, 37h, 75h, 0D3h, 0E8h, 35h, 38h, 0B1h, 0E4h
	db	0E8h, 11h, 0BCh, 0E9h, 4Ch, 37h, 0E8h, 74h, 37h, 75h, 0C3h, 0E8h, 25h, 38h, 6, 55h
	db	8Eh, 0C0h, 8Bh, 0EFh, 5Fh, 58h, 0B1h, 0E6h, 0E8h, 0F9h, 0BBh, 0E9h, 34h, 37h, 0E8h, 5Ch
	db	37h, 75h, 7Ah, 0E8h, 0Dh, 38h, 0E8h, 34h, 0BDh, 0E9h, 26h, 37h, 0B0h, 0C5h, 0EBh, 2
	db	0B0h, 0C4h, 0A2h, 0DCh, 56h, 0E8h, 45h, 37h, 75h, 63h, 0E8h, 0F6h, 37h, 8Ah, 0Eh, 0DCh
	db	56h, 0E8h, 0E9h, 0BCh, 0E9h, 0Bh, 37h, 0E8h, 33h, 37h, 75h, 51h, 0E8h, 0D5h, 37h, 0F7h
	db	6, 7Ch, 51h, 2, 0, 74h, 3Eh, 0E8h, 40h, 62h, 75h, 39h, 3Bh, 6, 5Eh, 58h
	db	75h, 33h, 83h, 0C6h, 2, 6, 55h, 0E8h, 0BAh, 37h, 0E8h, 2Dh, 62h, 5Bh, 5Ah, 75h
	db	1Ah, 3Bh, 6, 5Eh, 58h, 75h, 14h, 83h, 0C6h, 2, 52h, 53h, 6, 55h, 0E8h, 0A3h
	db	37h, 5Fh, 58h, 5Bh, 5Ah, 0E8h, 0CBh, 0C5h, 0E9h, 0C7h, 36h, 8Bh, 0C2h, 8Bh, 0FBh, 0E8h
	db	2Bh, 0C6h, 0E9h, 0BDh, 36h, 0B1h, 28h, 0E8h, 69h, 0BDh, 0E9h, 0B5h, 36h, 0E9h, 9Eh, 61h
	db	0B0h, 30h, 0EBh, 0Eh, 0B0h, 20h, 0EBh, 0Ah, 0B0h, 38h, 0EBh, 6, 0B0h, 18h, 0EBh, 2
	db	0B0h, 10h, 0A2h, 0DCh, 56h, 0E8h, 0C5h, 36h, 75h, 0E3h, 0E8h, 67h, 37h, 8Ah, 0Eh, 0DCh
	db	56h, 0E8h, 3Fh, 0BDh, 0E9h, 8Bh, 36h, 0B0h, 0, 0EBh, 16h, 0B0h, 8, 0EBh, 12h, 0B0h
	db	20h, 0EBh, 0Eh, 0B0h, 38h, 0EBh, 0Ah, 0B0h, 28h, 0EBh, 6, 0B0h, 10h, 0EBh, 2, 0B0h
	db	18h, 0A2h, 0DCh, 56h, 0E8h, 96h, 36h, 75h, 0B4h, 0E8h, 47h, 37h, 8Ah, 0Eh, 0DCh, 56h
	db	0E8h, 31h, 0BDh, 0E9h, 5Ch, 36h, 0B1h, 0AAh, 0EBh, 2, 0B1h, 0AEh, 0E8h, 5, 92h, 0E8h
	db	5, 0, 0E9h, 6, 92h, 0B1h, 0ACh, 88h, 0Eh, 0DCh, 56h, 0E8h, 6Fh, 36h, 75h, 8Dh
	db	0E8h, 11h, 37h, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 0EAh, 0BBh, 0E9h, 35h, 36h, 0E8h, 5Dh, 36h
	db	75h, 4Dh, 0E8h, 13h, 0E4h, 74h, 8, 0B1h, 0D7h, 0E8h, 6Bh, 0BBh, 0E9h, 23h, 36h, 0E8h
	db	0E7h, 0BBh, 0E9h, 1Dh, 36h, 0E8h, 45h, 36h, 75h, 35h, 0E8h, 0C7h, 91h, 0E8h, 0F8h, 0E3h
	db	0E8h, 0C8h, 91h, 0E8h, 0F0h, 36h, 0B1h, 0A4h, 0E8h, 7Dh, 0BBh, 0E9h, 4, 36h, 0E8h, 2Ch
	db	36h, 75h, 1Ch, 0E8h, 0E2h, 0E3h, 0E8h, 0ABh, 91h, 0E8h, 0DAh, 36h, 50h, 57h, 0E8h, 0AAh
	db	91h, 8Ch, 0C0h, 8Bh, 0FDh, 5Dh, 7, 0B1h, 0A6h, 0E8h, 5Ch, 0BBh, 0E9h, 0E3h, 35h, 0E9h
	db	0CCh, 60h, 0B0h, 37h, 0EBh, 61h, 0B0h, 3Fh, 0EBh, 5Dh, 0B0h, 0F8h, 0EBh, 59h, 0B0h, 0FCh
	db	0EBh, 55h, 0B0h, 0FAh, 0EBh, 51h, 0B0h, 0F5h, 0EBh, 4Dh, 0B0h, 0A6h, 0EBh, 49h, 0B0h, 27h
	db	0EBh, 45h, 0B0h, 2Fh, 0EBh, 41h, 0B0h, 0F4h, 0EBh, 3Dh, 0B0h, 0CEh, 0EBh, 39h, 0B0h, 9Fh
	db	0EBh, 35h, 0B0h, 0ACh, 0EBh, 31h, 0B0h, 0A4h, 0EBh, 2Dh, 0B0h, 9Eh, 0EBh, 29h, 0B0h, 0AEh
	db	0EBh, 25h, 0B0h, 0F9h, 0EBh, 21h, 0B0h, 0FDh, 0EBh, 1Dh, 0B0h, 0FBh, 0EBh, 19h, 0B0h, 0AAh
	db	0EBh, 15h, 0B0h, 9Bh, 0EBh, 11h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 4, 0B0h, 0D7h
	db	0EBh, 5, 0E9h, 48h, 0FFh, 0B0h, 90h, 0A2h, 0DCh, 56h, 0E8h, 0A0h, 35h, 75h, 90h, 8Ah
	db	0Eh, 0DCh, 56h, 0E8h, 0B1h, 0BAh, 0E9h, 69h, 35h, 0B0h, 98h, 0EBh, 26h, 0B0h, 0A7h, 0EBh
	db	22h, 0B0h, 99h, 0EBh, 1Eh, 0B0h, 0ADh, 0EBh, 1Ah, 0B0h, 0A5h, 0EBh, 16h, 0B0h, 9Dh, 0EBh
	db	12h, 0B0h, 9Ch, 0EBh, 0Eh, 0B0h, 0CFh, 0EBh, 0Ah, 0B0h, 0AFh, 0EBh, 6, 0B0h, 0C9h, 0EBh
	db	2, 0B0h, 0ABh, 0A2h, 0DCh, 56h, 0E8h, 64h, 35h, 75h, 0Ah, 8Ah, 0Eh, 0DCh, 56h, 0E8h
	db	67h, 0BAh, 0E9h, 2Dh, 35h, 0E9h, 16h, 60h, 0B0h, 0F0h, 0EBh, 6, 0B0h, 0F3h, 0EBh, 2
	db	0B0h, 0F2h, 0A2h, 0DCh, 56h, 0E8h, 45h, 35h, 75h, 0Ch, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 61h
	db	0BAh, 0C6h, 6, 0C5h, 51h, 0FFh, 0FFh, 26h, 5Ah, 57h, 0B0h, 2Eh, 0EBh, 12h, 0B0h, 3Eh
	db	0EBh, 0Eh, 0B0h, 36h, 0EBh, 0Ah, 0B0h, 26h, 0EBh, 6, 0B0h, 64h, 0EBh, 2, 0B0h, 65h
	db	0A2h, 0DCh, 56h, 0E8h, 17h, 35h, 75h, 0Ch, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 3Eh, 0BAh, 0C6h
	db	6, 0C5h, 51h, 0FFh, 0FFh, 26h, 5Ah, 57h, 0E8h, 2, 35h, 75h, 3Fh, 0E8h, 0B8h, 0E2h
	db	75h, 13h, 0F6h, 6, 86h, 51h, 10h, 75h, 4, 0B1h, 0C2h, 0EBh, 2, 0B1h, 0CAh, 0E8h
	db	38h, 0BBh, 0E9h, 0BDh, 34h, 0F6h, 6, 86h, 51h, 20h, 74h, 0Dh, 0F6h, 6, 0BFh, 51h
	db	10h, 74h, 6, 0E8h, 0B2h, 0ADh, 0E9h, 0A9h, 34h, 0F6h, 6, 86h, 51h, 10h, 75h, 4
	db	0B1h, 0C3h, 0EBh, 2, 0B1h, 0CBh, 0E8h, 0DEh, 0B9h, 0E9h, 96h, 34h, 0E9h, 7Fh, 5Fh, 0F6h
	db	6, 87h, 51h, 2, 75h, 4, 0B0h, 0C2h, 0EBh, 2, 0B0h, 0CAh, 0A2h, 0DCh, 56h, 0E8h
	db	0ABh, 34h, 75h, 0E8h, 0E8h, 61h, 0E2h, 75h, 0Ah, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 0EAh, 0BAh
	db	0E9h, 6Fh, 34h, 8Ah, 0Eh, 0DCh, 56h, 80h, 0C9h, 1, 0E8h, 0AAh, 0B9h, 0E9h, 62h, 34h
	db	0E8h, 8Ah, 34h, 75h, 0C7h, 0E8h, 2Ch, 35h, 0E8h, 7Dh, 0B8h, 0E9h, 54h, 34h, 0B0h, 77h
	db	0EBh, 3Ah, 0B0h, 76h, 0EBh, 36h, 0B0h, 72h, 0EBh, 32h, 0B0h, 73h, 0EBh, 2Eh, 0B0h, 74h
	db	0EBh, 2Ah, 0B0h, 75h, 0EBh, 26h, 0B0h, 7Fh, 0EBh, 22h, 0B0h, 7Eh, 0EBh, 1Eh, 0B0h, 7Ch
	db	0EBh, 1Ah, 0B0h, 7Dh, 0EBh, 16h, 0B0h, 70h, 0EBh, 12h, 0B0h, 71h, 0EBh, 0Eh, 0B0h, 78h
	db	0EBh, 0Ah, 0B0h, 79h, 0EBh, 6, 0B0h, 7Bh, 0EBh, 2, 0B0h, 7Ah, 0A2h, 0DCh, 56h, 0E8h
	db	3Bh, 34h, 75h, 2Ch, 0E8h, 0DDh, 34h, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 0BCh, 0B7h, 0E9h, 1
	db	34h, 0B0h, 0E2h, 0EBh, 6, 0B0h, 0E1h, 0EBh, 2, 0B0h, 0E0h, 0A2h, 0DCh, 56h, 0E8h, 1Ch
	db	34h, 75h, 0Dh, 0E8h, 0BEh, 34h, 8Ah, 0Eh, 0DCh, 56h, 0E8h, 1Fh, 0B7h, 0E9h, 0E2h, 33h
	db	0E9h, 0CBh, 5Eh, 0B0h, 0E3h, 0EBh, 0Ah, 0B0h, 0E2h, 0EBh, 6, 0B0h, 0E1h, 0EBh, 2, 0B0h
	db	0E0h, 0A2h, 0DCh, 56h, 0E8h, 0F6h, 33h, 75h, 0E7h, 0E8h, 98h, 34h, 8Ah, 0Eh, 0DCh, 56h
	db	0E8h, 1, 0B7h, 0E9h, 0BCh, 33h, 0E8h, 0E4h, 33h, 75h, 0D5h, 0E8h, 95h, 34h, 0E8h, 2
	db	0BDh, 0E9h, 0AEh, 33h, 0E8h, 19h, 34h, 75h, 3Bh, 56h, 9Ah
	dd	L1063A
	db	5Eh, 0E9h, 9Fh, 33h, 0E8h, 0Ah, 34h, 75h, 2Ch, 0E8h, 0DFh, 5Eh, 75h, 1Dh, 3Bh, 6
	db	0A6h, 58h, 75h, 29h, 83h, 0C6h, 2, 0E8h, 0D1h, 5Eh, 75h, 5, 83h, 0EEh, 2, 0EBh
	db	1Ch, 56h, 9Ah
	dd	L10630
	db	5Eh, 0E9h, 78h, 33h, 56h, 9Ah
	dd	L1063A
	db	5Eh, 0E9h, 6Eh, 33h, 0E9h, 57h, 5Eh, 0E8h, 0D6h, 33h, 75h, 0F8h, 0E8h, 49h, 0E1h, 75h
	db	0Ch, 0E8h, 7Ch, 0B0h, 56h, 8Bh, 0C8h, 9Ah
	dd	L1060B
	db	5Eh, 0E8h, 9Ah, 5Eh, 75h, 0E2h, 3Bh, 6, 5Eh, 58h, 75h, 14h, 83h, 0C6h, 2, 0E8h
	db	2Ah, 0E1h, 75h, 0Ch, 0E8h, 5Dh, 0B0h, 56h, 8Bh, 0C8h, 9Ah
	dd	L10603
	db	5Eh, 0E9h, 33h, 33h, 0E8h, 88h, 33h, 75h, 4Ch, 0E8h, 47h, 33h, 0E8h, 53h, 53h, 74h
	db	23h, 33h, 0C9h, 0EBh, 1Fh, 0E8h, 77h, 33h, 75h, 0AFh, 0E8h, 62h, 5Eh, 75h, 2Dh, 0E8h
	db	0F4h, 3Bh, 75h, 28h, 83h, 0C6h, 2, 9Ah
	dd	L101E0
	db	0E8h, 0FDh, 39h, 32h, 0E4h, 0E8h, 8Fh, 82h, 56h, 8Bh, 0F3h, 16h, 7, 0BFh, 0C7h, 51h
	db	89h, 0Eh, 0B8h, 51h, 0D1h, 0E9h, 0F3h, 0A5h, 0D1h, 0D1h, 0F3h, 0A4h, 5Eh, 0E9h, 0EBh, 32h
	db	0B9h, 7Ch, 0, 0E8h, 35h, 6Ah, 0E9h, 0E2h, 32h, 0C3h, 0E8h, 4Ch, 33h, 75h, 0FAh, 0E8h
	db	0F5h, 32h, 0E8h, 1, 53h, 74h, 26h, 33h, 0C9h, 0EBh, 22h, 0E8h, 3Bh, 33h, 74h, 3
	db	0E9h, 82h, 0, 0E8h, 0Dh, 5Eh, 75h, 0D8h, 0E8h, 9Fh, 3Bh, 75h, 0D3h, 83h, 0C6h, 2
	db	9Ah
	dd	L101E0
	db	0E8h, 0A8h, 39h, 32h, 0E4h, 0E8h, 3Ah, 82h, 8Bh, 0FBh, 16h, 7, 9Ah
	dd	L1062B
	db	0E9h, 0A2h, 32h, 0E8h, 0Dh, 33h, 75h, 57h, 0E8h, 6Ch, 33h, 0E8h, 0B5h, 0AFh, 56h, 8Bh
	db	0C8h, 9Ah
	dd	L10830
	db	5Eh, 0E9h, 8Bh, 32h, 0E8h, 0F6h, 32h, 75h, 40h, 0E8h, 55h, 33h, 0E8h, 9Eh, 0AFh, 56h
	db	8Bh, 0C8h, 9Ah
	dd	L10839
	db	5Eh, 0E9h, 74h, 32h, 0E8h, 0DFh, 32h, 75h, 29h, 0E8h, 3Eh, 33h, 0E8h, 87h, 0AFh, 56h
	db	8Bh, 0C8h, 9Ah
	dd	L1083E
	db	5Eh, 0E9h, 5Dh, 32h, 0E8h, 0C8h, 32h, 75h, 12h, 0E8h, 27h, 33h, 0E8h, 70h, 0AFh, 56h
	db	8Bh, 0C8h, 9Ah
	dd	L10843
	db	5Eh, 0E9h, 46h, 32h, 0E9h, 2Fh, 5Dh, 0E8h, 0AEh, 32h, 75h, 0F8h, 0E8h, 0Dh, 33h, 0E8h
	db	56h, 0AFh, 56h, 8Bh, 0C8h, 9Ah
	dd	L10848
	db	5Eh, 0E9h, 2Ch, 32h, 0E8h, 97h, 32h, 75h, 0E1h, 0E8h, 0F6h, 32h, 0E8h, 3Fh, 0AFh, 56h
	db	8Bh, 0C8h, 9Ah
	dd	L1084D
	db	5Eh, 0E9h, 15h, 32h, 0E8h, 6Ah, 32h, 75h, 0CAh, 83h, 0Eh, 0B4h, 51h, 40h, 0E9h, 8
	db	32h, 0E8h, 5Dh, 32h, 75h, 0BDh, 83h, 26h, 0B4h, 51h, 0BFh, 0E9h, 0FBh, 31h, 0E8h, 50h
	db	32h, 75h, 4Dh, 81h, 0Eh, 0B4h, 51h, 80h, 0, 0E9h, 0EDh, 31h, 0E8h, 42h, 32h, 75h
	db	3Fh, 81h, 26h, 0B4h, 51h, 7Fh, 0FFh, 0E9h, 0DFh, 31h, 0E8h, 34h, 32h, 75h, 31h, 81h
	db	26h, 0B4h, 51h, 0FFh, 0FCh, 0E9h, 0D1h, 31h, 0E8h, 26h, 32h, 75h, 23h, 81h, 26h, 0B4h
	db	51h, 0FFh, 0FEh, 81h, 0Eh, 0B4h, 51h, 0, 2, 0E9h, 0BDh, 31h, 0E8h, 12h, 32h, 75h
	db	0Fh, 81h, 26h, 0B4h, 51h, 0FFh, 0FDh, 81h, 0Eh, 0B4h, 51h, 0, 1, 0E9h, 0A9h, 31h
	db	0E9h, 92h, 5Ch, 0E8h, 0FBh, 31h, 75h, 0F8h, 81h, 0Eh, 0B4h, 51h, 0, 0Ch, 0E9h, 98h
	db	31h, 0E8h, 0EDh, 31h, 75h, 0EAh, 0E8h, 5Ah, 53h, 75h, 1Ah, 0E8h, 56h, 3Ah, 74h, 15h
	db	0F6h, 6, 0C9h, 38h, 1, 74h, 0D9h, 0BBh, 71h, 0CCh, 0E8h, 59h, 25h, 0E9h, 79h, 31h
	db	32h, 0C0h, 0FEh, 0C8h, 0C3h, 81h, 26h, 0B4h, 51h, 0FFh, 0FBh, 0E9h, 6Bh, 31h, 0E8h, 32h
	db	53h, 75h, 0F1h, 8Bh, 0C2h, 0E8h, 2Ch, 3Ah, 74h, 0E6h, 83h, 0C6h, 2, 56h, 9Ah
	dd	L10822
	db	5Eh, 32h, 0C0h, 0C3h, 0E8h, 0A7h, 31h, 75h, 37h, 81h, 0Eh, 0B4h, 51h, 0, 10h, 0E9h
	db	44h, 31h, 0E8h, 99h, 31h, 75h, 29h, 81h, 26h, 0B4h, 51h, 0FFh, 0EFh, 0E9h, 36h, 31h
	db	0E8h, 0A1h, 31h, 75h, 1Bh, 0A0h, 0BEh, 51h, 3Ch, 10h, 74h, 11h, 32h, 0E4h, 0D1h, 0E0h
	db	8Bh, 0D8h, 0A1h, 0B4h, 51h, 89h, 87h, 30h, 57h, 0FEh, 6, 0BEh, 51h, 0E9h, 16h, 31h
	db	0E9h, 0FFh, 5Bh, 0E8h, 7Eh, 31h, 75h, 0F8h, 0A0h, 0BEh, 51h, 22h, 0C0h, 74h, 0EEh, 0FEh
	db	0C8h, 32h, 0E4h, 0D1h, 0E0h, 8Bh, 0D8h, 8Bh, 87h, 30h, 57h, 0A3h, 0B4h, 51h, 0FEh, 0Eh
	db	0BEh, 51h, 0E9h, 0F1h, 30h, 0E8h, 46h, 31h, 75h, 0D6h, 83h, 0Eh, 0B4h, 51h, 8, 83h
	db	26h, 0B4h, 51h, 0DFh, 0E9h, 0DFh, 30h, 0E8h, 34h, 31h, 75h, 0C4h, 83h, 0Eh, 0B4h, 51h
	db	28h, 0E9h, 0D2h, 30h, 0E8h, 27h, 31h, 75h, 0B7h, 83h, 26h, 0B4h, 51h, 0F7h, 0E9h, 0C5h
	db	30h, 0E8h, 1Ah, 31h, 75h, 0AAh, 83h, 0Eh, 0B4h, 51h, 2, 0E9h, 0B8h, 30h, 0E8h, 0Dh
	db	31h, 75h, 9Dh, 83h, 26h, 0B4h, 51h, 0FDh, 0E9h, 0ABh, 30h, 0E8h, 0, 31h, 75h, 3Ch
	db	83h, 0Eh, 0B4h, 51h, 10h, 0E9h, 9Eh, 30h, 0E8h, 0F3h, 30h, 75h, 2Fh, 83h, 26h, 0B4h
	db	51h, 0EFh, 0E9h, 91h, 30h, 0E8h, 0E6h, 30h, 75h, 22h, 83h, 36h, 0B4h, 51h, 10h, 0E9h
	db	84h, 30h, 0E8h, 0D9h, 30h, 75h, 15h, 83h, 0Eh, 0B4h, 51h, 4, 0E9h, 77h, 30h, 0E8h
	db	0CCh, 30h, 75h, 8, 83h, 26h, 0B4h, 51h, 0FBh, 0E9h, 6Ah, 30h, 0E9h, 53h, 5Bh, 0E8h
	db	0BCh, 30h, 75h, 0F8h, 83h, 0Eh, 0B4h, 51h, 1, 0E9h, 5Ah, 30h, 0E8h, 0AFh, 30h, 75h
	db	0EBh, 83h, 26h, 0B4h, 51h, 0FEh, 0E9h, 4Dh, 30h, 0E8h, 0E7h, 30h, 75h, 0DEh, 0E8h, 0ECh
	db	70h, 0E9h, 42h, 30h, 0E8h, 0DCh, 30h, 75h, 0D3h, 80h, 3Eh, 0C1h, 51h, 0, 75h, 0Bh
	db	0E8h, 3Eh, 0AAh, 0C6h, 6, 0C1h, 51h, 0FFh, 0E9h, 2Bh, 30h, 0B9h, 86h, 0, 0E8h, 75h
	db	67h, 0E9h, 22h, 30h, 0E8h, 0BCh, 30h, 75h, 0B3h, 83h, 3Eh, 0B0h, 51h, 0, 74h, 6
	db	0B9h, 49h, 0, 0E9h, 60h, 67h, 0C6h, 6, 87h, 51h, 0, 0C6h, 6, 0C0h, 51h, 0
	db	80h, 26h, 86h, 51h, 3Fh, 0E8h, 46h, 5Bh, 75h, 1Ah, 83h, 0C6h, 2, 16h, 7, 0BFh
	db	0D2h, 57h, 0B9h, 0Ah, 0, 0F2h, 0AFh, 75h, 0Bh, 0BBh, 9, 0, 2Bh, 0D9h, 0D1h, 0E3h
	db	0FFh, 0A7h, 54h, 20h, 0B9h, 5Bh, 0, 0E9h, 2Ch, 67h, 80h, 0Eh, 86h, 51h, 40h, 0EBh
	db	0D4h, 80h, 26h, 86h, 51h, 0BFh, 0EBh, 0CDh, 0C6h, 6, 87h, 51h, 5, 0C6h, 6, 0E8h
	db	56h, 30h, 0C6h, 6, 0E9h, 56h, 30h, 0C6h, 6, 0EBh, 56h, 31h, 0E9h, 82h, 0, 0C6h
	db	6, 87h, 51h, 1, 0C6h, 6, 0E8h, 56h, 30h, 0C6h, 6, 0E9h, 56h, 30h, 0C6h, 6
	db	0EBh, 56h, 32h, 0EBh, 6Ch, 0C6h, 6, 87h, 51h, 3, 0C6h, 6, 0E8h, 56h, 31h, 0C6h
	db	6, 0E9h, 56h, 30h, 0C6h, 6, 0EBh, 56h, 34h, 0EBh, 56h, 0C6h, 6, 87h, 51h, 9
	db	0C6h, 6, 0E8h, 56h, 30h, 0C6h, 6, 0E9h, 56h, 31h, 0C6h, 6, 0EBh, 56h, 33h, 0EBh
	db	40h, 0C6h, 6, 87h, 51h, 0Bh, 0C6h, 6, 0E8h, 56h, 31h, 0C6h, 6, 0E9h, 56h, 31h
	db	0C6h, 6, 0EBh, 56h, 35h, 0EBh, 2Ah, 0C6h, 6, 87h, 51h, 0Bh, 0C6h, 6, 0E8h, 56h
	db	31h, 0C6h, 6, 0E9h, 56h, 32h, 0C6h, 6, 0EBh, 56h, 36h, 0EBh, 14h, 0C6h, 6, 87h
	db	51h, 8Bh, 0C6h, 6, 0E8h, 56h, 31h, 0C6h, 6, 0E9h, 56h, 32h, 0C6h, 6, 0EBh, 56h
	db	37h, 0E8h, 6Ah, 1, 0F6h, 6, 87h, 51h, 80h, 75h, 21h, 0A1h, 0AAh, 57h, 9Ah
	dd	L101E0
	db	0E8h, 94h, 45h, 75h, 2Eh, 0E8h, 30h, 6Ah, 0E8h, 0A3h, 45h, 0A1h, 90h, 57h, 9Ah
	dd	L101E0
	db	0A1h, 0AAh, 57h, 0E8h, 0E7h, 2Bh, 0A1h, 8Eh, 57h, 9Ah
	dd	L101E0
	db	0A1h, 0AAh, 57h, 0E8h, 0D9h, 2Bh, 0E8h, 6Bh, 2, 0E8h, 0B8h, 3, 0E8h, 56h, 2, 0E8h
	db	93h, 22h, 0E8h, 35h, 5Ah, 75h, 6Ch, 3Bh, 6, 5Eh, 58h, 75h, 66h, 83h, 0C6h, 2
	db	0E8h, 0E5h, 22h, 0E8h, 0Ch, 23h, 75h, 43h, 0A0h, 4, 57h, 0A2h, 0C0h, 51h, 0A0h, 3
	db	57h, 8, 6, 87h, 51h, 24h, 30h, 0Ah, 6, 0C0h, 51h, 0A2h, 0BFh, 51h, 0E8h, 9
	db	5Ah, 75h, 40h, 3Bh, 6, 5Eh, 58h, 75h, 3Ah, 83h, 0C6h, 2, 0E8h, 0FBh, 59h, 75h
	db	20h, 16h, 7, 0BFh, 0D2h, 57h, 0B9h, 2, 0, 0F2h, 0AFh, 75h, 14h, 83h, 0C6h, 2
	db	0BBh, 1, 0, 2Bh, 0D9h, 0D1h, 0E3h, 0FFh, 0A7h, 68h, 20h, 0B9h, 77h, 0, 0E9h, 0E1h
	db	65h, 0B9h, 5Bh, 0, 0E9h, 0DBh, 65h, 80h, 26h, 86h, 51h, 0BFh, 0EBh, 5, 80h, 0Eh
	db	86h, 51h, 40h, 0F6h, 6, 87h, 51h, 80h, 75h, 46h, 0A1h, 0AAh, 57h, 8Bh, 0D0h, 0E8h
	db	38h, 9Dh, 6, 55h, 8Bh, 0Eh, 60h, 56h, 0E8h, 0Bh, 0ABh, 5Dh, 7, 0F6h, 6, 86h
	db	51h, 40h, 75h, 0Dh, 6, 55h, 8Bh, 0Eh, 5Eh, 56h, 0E8h, 0F9h, 0AAh, 5Dh, 7, 0EBh
	db	0Eh, 6, 55h, 0E8h, 0Ch, 8Ah, 8Bh, 0Eh, 5Eh, 56h, 0E8h, 0E9h, 0AAh, 5Dh, 7, 0F6h
	db	6, 87h, 51h, 4, 74h, 7, 8Bh, 0Eh, 5Ch, 56h, 0E8h, 0D9h, 0AAh, 0E9h, 32h, 2Eh
	db	0E8h, 0EFh, 89h, 8Bh, 0Eh, 60h, 56h, 6, 55h, 0E8h, 0CAh, 0AAh, 5Dh, 7, 8Bh, 0Eh
	db	5Eh, 56h, 0E8h, 0C1h, 0AAh, 0E9h, 1Ah, 2Eh, 0C6h, 6, 87h, 51h, 33h, 80h, 0Eh, 86h
	db	51h, 80h, 0C6h, 6, 0BFh, 51h, 30h, 0C6h, 6, 0C0h, 51h, 0, 0C6h, 6, 0E8h, 56h
	db	30h, 0C6h, 6, 0E9h, 56h, 31h, 0C6h, 6, 0EBh, 56h, 30h, 0E8h, 2Ch, 0, 0E8h, 63h
	db	1, 0E8h, 0B0h, 2, 0E8h, 4Eh, 1, 0E8h, 8Bh, 21h, 0A1h, 90h, 57h, 9Ah
	dd	L101E0
	db	0A1h, 98h, 57h, 0E8h, 0B7h, 2Ah, 0A1h, 98h, 57h, 8Bh, 0D0h, 0E8h, 9Ah, 9Ch, 8Bh, 0Eh
	db	60h, 56h, 0E8h, 6Fh, 0AAh, 0E9h, 0C8h, 2Dh, 0BBh, 0E8h, 56h, 0B9h, 1, 0, 0E8h, 0E2h
	db	33h, 50h, 0A1h, 80h, 57h, 9Ah
	dd	L101E0
	db	58h, 0E8h, 8Fh, 2Ah, 0BBh, 0E9h, 56h, 0B9h, 1, 0, 0E8h, 0CCh, 33h, 50h, 0A1h, 82h
	db	57h, 9Ah
	dd	L101E0
	db	58h, 0E8h, 79h, 2Ah, 0BBh, 0EBh, 56h, 0B9h, 1, 0, 0E8h, 0B6h, 33h, 50h, 0A1h, 8Ah
	db	57h, 9Ah
	dd	L101E0
	db	58h, 0E9h, 63h, 2Ah, 0E8h, 20h, 2Eh, 75h, 71h, 83h, 3Eh, 0B0h, 51h, 0, 75h, 64h
	db	0F6h, 6, 87h, 51h, 1, 74h, 57h, 0E8h, 0E2h, 0, 0E8h, 10h, 21h, 0E9h, 6Ah, 2Dh
	db	0E8h, 4, 2Eh, 75h, 55h, 83h, 3Eh, 0B0h, 51h, 0, 75h, 48h, 0F6h, 6, 87h, 51h
	db	1, 74h, 3Bh, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 3, 0E8h, 0AFh, 0, 0E8h, 41h
	db	1, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 3, 0E8h, 0A1h, 0, 0E8h, 0DEh, 20h, 0E9h
	db	38h, 2Dh, 0E8h, 0D2h, 2Dh, 75h, 23h, 83h, 3Eh, 0B0h, 51h, 0, 75h, 16h, 0F6h, 6
	db	87h, 51h, 1, 74h, 9, 0E8h, 78h, 1, 0E8h, 0C2h, 20h, 0E9h, 1Ch, 2Dh, 0B9h, 70h
	db	0, 0E9h, 66h, 64h, 0B9h, 49h, 0, 0E9h, 60h, 64h, 0E9h, 0F9h, 57h, 0E8h, 0A7h, 2Dh
	db	75h, 0F8h, 83h, 3Eh, 0B0h, 51h, 0, 75h, 0EBh, 0F6h, 6, 87h, 51h, 1, 74h, 0DEh
	db	0E8h, 62h, 1, 0E8h, 97h, 20h, 0E9h, 0F1h, 2Ch, 0E8h, 8Bh, 2Dh, 75h, 0DCh, 83h, 3Eh
	db	0B0h, 51h, 0, 75h, 0CFh, 0F6h, 6, 87h, 51h, 1, 74h, 0C2h, 0E8h, 9Dh, 1, 0E8h
	db	7Bh, 20h, 0E9h, 0D5h, 2Ch, 0E8h, 6Fh, 2Dh, 75h, 0C0h, 83h, 3Eh, 0B0h, 51h, 0, 75h
	db	0B3h, 0F6h, 6, 87h, 51h, 1, 74h, 0A6h, 0E8h, 0A7h, 1, 0E8h, 5Fh, 20h, 0E9h, 0B9h
	db	2Ch, 0E8h, 53h, 2Dh, 75h, 0A4h, 83h, 3Eh, 0B0h, 51h, 0, 75h, 97h, 0F6h, 6, 87h
	db	51h, 1, 74h, 8Ah, 0E8h, 0A5h, 1, 0E8h, 43h, 20h, 0E9h, 9Dh, 2Ch, 80h, 3Eh, 0C6h
	db	51h, 0, 74h, 7, 0FEh, 0Eh, 0C6h, 51h, 0E9h, 83h, 72h, 0C3h, 0E8h, 0EEh, 0FFh, 0F6h
	db	6, 86h, 51h, 80h, 75h, 50h, 0E8h, 0C9h, 57h, 75h, 1Ch, 0E8h, 47h, 35h, 74h, 17h
	db	83h, 0C6h, 2, 0F6h, 6, 87h, 51h, 2, 75h, 1Ah, 0B9h, 81h, 80h, 0E8h, 0BAh, 63h
	db	0A1h, 0A4h, 57h, 8Bh, 0D0h, 0EBh, 0Dh, 0F6h, 6, 87h, 51h, 2, 74h, 0F2h, 0A1h, 0A4h
	db	57h, 0E8h, 0Bh, 2, 8Bh, 0Eh, 96h, 57h, 0B3h, 48h, 0F6h, 6, 7Ch, 51h, 8, 74h
	db	6, 80h, 0E3h, 1Fh, 80h, 0CBh, 0A0h, 0F6h, 6, 87h, 51h, 4, 74h, 11h, 8Bh, 0C2h
	db	0BFh, 2, 0, 0E9h, 86h, 1, 0A1h, 96h, 57h, 8Bh, 0D0h, 33h, 0C9h, 0B3h, 28h, 50h
	db	52h, 8Bh, 0C2h, 0BFh, 2, 0, 0E8h, 86h, 1, 0A1h, 8Eh, 57h, 9Ah
	dd	L101E0
	db	58h, 50h, 0E8h, 0F1h, 28h, 5Ah, 58h, 0E8h, 0D7h, 9Ah, 8Bh, 0Eh, 5Ch, 56h, 0E9h, 0ACh
	db	0A8h, 0F6h, 6, 86h, 51h, 80h, 75h, 55h, 0FFh, 36h, 82h, 51h, 81h, 26h, 82h, 51h
	db	0FFh, 0DFh, 0A1h, 9Eh, 57h, 8Bh, 0C8h, 0B3h, 74h, 0F6h, 6, 86h, 51h, 40h, 0BAh, 41h
	db	0D3h, 75h, 0Ah, 0F6h, 6, 87h, 51h, 80h, 75h, 3, 0BAh, 2Eh, 0D3h, 0BFh, 3, 0
	db	0FFh, 0D2h, 8Fh, 6, 82h, 51h, 0E8h, 0B6h, 0D9h, 74h, 3, 0E8h, 8Bh, 87h, 0E8h, 0E6h
	db	0A8h, 8Bh, 0D1h, 0Bh, 0C8h, 75h, 3, 0B8h, 0, 4, 2Bh, 6, 70h, 51h, 1Bh, 16h
	db	72h, 51h, 72h, 8, 1, 6, 70h, 51h, 11h, 16h, 72h, 51h, 0C3h, 0EBh, 5Dh, 0F6h
	db	6, 86h, 51h, 80h, 75h, 56h, 0E8h, 3, 0FFh, 0A1h, 0A0h, 57h, 8Bh, 0C8h, 8Bh, 3Eh
	db	92h, 57h, 0EBh, 13h, 0F6h, 6, 86h, 51h, 80h, 75h, 41h, 0E8h, 0EEh, 0FEh, 0A1h, 0A2h
	db	57h, 8Bh, 0C8h, 8Bh, 3Eh, 94h, 57h, 0B3h, 60h, 50h, 53h, 51h, 57h, 0E8h, 0C1h, 56h
	db	5Fh, 59h, 5Bh, 58h, 75h, 0Eh, 50h, 8Bh, 0C2h, 0E8h, 38h, 34h, 58h, 74h, 5, 83h
	db	0C6h, 2, 8Bh, 0C2h, 50h, 53h, 51h, 50h, 8Bh, 0C7h, 9Ah
	dd	L101E0
	db	58h, 0E8h, 33h, 28h, 59h, 5Bh, 58h, 0BFh, 3, 0, 0E9h, 0B2h, 0, 0F7h, 6, 82h
	db	51h, 0, 40h, 74h, 6, 0B9h, 7Fh, 80h, 0E8h, 8Fh, 62h, 0C3h, 0E8h, 9Eh, 0FEh, 0F6h
	db	6, 86h, 51h, 80h, 75h, 10h, 0F6h, 6, 87h, 51h, 80h, 75h, 59h, 0A1h, 0A6h, 57h
	db	8Bh, 0Eh, 98h, 57h, 0EBh, 63h, 0B3h, 48h, 0A1h, 98h, 57h, 33h, 0C9h, 0BFh, 3, 0
	db	0EBh, 7Dh, 0F6h, 6, 86h, 51h, 80h, 75h, 0C4h, 0E8h, 71h, 0FEh, 0F6h, 6, 87h, 51h
	db	80h, 75h, 33h, 0A1h, 0A8h, 57h, 8Bh, 0Eh, 9Ch, 57h, 0EBh, 3Dh, 0F6h, 6, 86h, 51h
	db	80h, 75h, 0AAh, 0E8h, 57h, 0FEh, 0F6h, 6, 87h, 51h, 80h, 75h, 19h, 0FFh, 36h, 82h
	db	51h, 81h, 26h, 82h, 51h, 0FFh, 0DFh, 0A1h, 9Ah, 57h, 8Bh, 0Eh, 98h, 57h, 0E8h, 18h
	db	0, 8Fh, 6, 82h, 51h, 0C3h, 0A1h, 0A6h, 57h, 0E8h, 83h, 0, 8Bh, 0C2h, 8Bh, 0Eh
	db	98h, 57h, 8Bh, 3Eh, 90h, 57h, 0E9h, 3Fh, 0FFh, 0B3h, 48h, 0F7h, 6, 7Ch, 51h, 8
	db	0, 74h, 6, 80h, 0E3h, 1Fh, 80h, 0CBh, 0A0h, 0BFh, 3, 0, 9Ah
	dd	L101E0
	db	50h, 53h, 51h, 57h, 0A1h, 0AAh, 57h, 0E8h, 93h, 42h, 5Fh, 59h, 5Bh, 58h, 0A3h, 0DEh
	db	56h, 89h, 0Eh, 0Eh, 57h, 0E8h, 64h, 34h, 75h, 16h, 9Ah
	dd	L101E0
	db	0E8h, 4Fh, 43h, 88h, 0Eh, 13h, 57h, 0A3h, 10h, 57h, 0C6h, 6, 12h, 57h, 0FFh, 0EBh
	db	27h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 0Eh, 0F7h, 6, 7Ch, 51h, 8, 0, 74h
	db	6, 80h, 0CBh, 1, 83h, 0CFh, 4, 89h, 0Eh, 0Eh, 57h, 88h, 1Eh, 13h, 57h, 89h
	db	3Eh, 10h, 57h, 0C6h, 6, 12h, 57h, 0, 0FEh, 6, 0C6h, 51h, 0E9h, 28h, 1Bh, 50h
	db	8Bh, 16h, 84h, 57h, 0E8h, 38h, 33h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0E8h, 2Eh, 31h, 9Ah
	dd	L10375
	db	9Ah
	dd	L1035F
	db	33h, 0DBh, 0E8h, 0EEh, 79h, 8Bh, 0D9h, 58h, 9Ah
	dd	L101E0
	db	0E8h, 14h, 31h, 0E8h, 0E0h, 79h, 0E9h, 4Ch, 30h, 8Bh, 0D0h, 0E8h, 0B1h, 2Ah, 75h, 70h
	db	0C6h, 6, 0CDh, 38h, 0FFh, 52h, 0E8h, 0CFh, 0A1h, 5Ah, 0EBh, 2Fh, 8Bh, 0D0h, 53h, 0E8h
	db	9Dh, 2Ah, 5Bh, 75h, 5Bh, 85h, 1Eh, 7Ch, 51h, 75h, 11h, 52h, 0B9h, 8Dh, 80h, 0E8h
	db	40h, 61h, 5Ah, 0EBh, 7, 8Bh, 0D0h, 0E8h, 85h, 2Ah, 75h, 44h, 0A1h, 7Ch, 51h, 25h
	db	0FFh, 0F2h, 0EBh, 0Dh, 8Bh, 0D0h, 0E8h, 76h, 2Ah, 75h, 35h, 0A1h, 7Ch, 51h, 25h, 61h
	db	0F2h, 0Bh, 0C2h, 0A3h, 7Ch, 51h, 0E8h, 83h, 26h, 0F7h, 6, 7Ch, 51h, 8, 0, 0BBh
	db	0EAh, 56h, 0C6h, 7, 32h, 74h, 3, 0C6h, 7, 34h, 0B9h, 1, 0, 0E8h, 0D5h, 2Fh
	db	50h, 0A1h, 88h, 57h, 9Ah
	dd	L101E0
	db	58h, 0E8h, 82h, 26h, 0E9h, 0A2h, 29h, 0E9h, 8Bh, 54h, 0B8h, 0, 1, 0EBh, 0BCh, 0B8h
	db	2, 1, 0EBh, 0B7h, 0B8h, 6, 5, 0EBh, 0B2h, 0B8h, 86h, 5, 0EBh, 0ADh, 0B8h, 0Eh
	db	0Dh, 0E9h, 6Ch, 0FFh, 0B8h, 8Eh, 0Dh, 0E9h, 66h, 0FFh, 0B8h, 1Eh, 0Dh, 0E9h, 60h, 0FFh
	db	0B8h, 9Eh, 0Dh, 0E9h, 5Ah, 0FFh, 33h, 0C0h, 0EBh, 82h, 0B8h, 0, 1, 0E9h, 7Ch, 0FFh
	db	0B8h, 0, 5, 0BBh, 4, 0, 0E9h, 5Ah, 0FFh, 0B8h, 0, 0Dh, 0BBh, 8, 0, 0E9h
	db	51h, 0FFh, 0E8h, 0F1h, 29h, 75h, 0B0h, 0E8h, 0C3h, 1Ch, 9, 6, 82h, 51h, 0E9h, 48h
	db	29h, 0E8h, 0E2h, 29h, 75h, 0A1h, 0E8h, 0B4h, 1Ch, 0F7h, 0D0h, 21h, 6, 82h, 51h, 0E9h
	db	37h, 29h, 0E8h, 0D1h, 29h, 75h, 90h, 81h, 26h, 7Ch, 51h, 0FFh, 0BFh, 0E8h, 0B6h, 24h
	db	0E9h, 26h, 29h, 0E8h, 0C0h, 29h, 74h, 3, 0E9h, 7Ch, 0FFh, 81h, 0Eh, 7Ch, 51h, 0
	db	40h, 0E8h, 0A2h, 24h, 0E9h, 12h, 29h, 0E8h, 0ACh, 29h, 75h, 6Dh, 81h, 0Eh, 7Ch, 51h
	db	0, 2, 0E9h, 4, 29h, 0E8h, 9Eh, 29h, 75h, 5Fh, 81h, 26h, 7Ch, 51h, 0FFh, 0FDh
	db	0E9h, 0F6h, 28h, 0E8h, 90h, 29h, 75h, 51h, 83h, 0Eh, 7Ch, 51h, 40h, 0E9h, 0E9h, 28h
	db	0E8h, 83h, 29h, 75h, 44h, 83h, 26h, 7Ch, 51h, 0BFh, 0E9h, 0DCh, 28h, 0E8h, 76h, 29h
	db	75h, 37h, 81h, 0Eh, 7Ch, 51h, 0, 0B0h, 0E8h, 5Bh, 24h, 0E9h, 0CBh, 28h, 0E9h, 0B4h
	db	53h, 0E8h, 62h, 29h, 75h, 23h, 81h, 26h, 7Ch, 51h, 0FFh, 6Fh, 81h, 0Eh, 7Ch, 51h
	db	0, 20h, 0E8h, 41h, 24h, 0E9h, 0B1h, 28h, 0E8h, 4Bh, 29h, 75h, 0Ch, 81h, 26h, 7Ch
	db	51h, 0FFh, 4Fh, 0E8h, 30h, 24h, 0E9h, 0A0h, 28h, 0E9h, 89h, 53h, 0E8h, 37h, 29h, 75h
	db	0F8h, 83h, 0Eh, 7Ch, 51h, 1, 0E9h, 90h, 28h, 0E8h, 2Ah, 29h, 75h, 0EBh, 83h, 26h
	db	7Ch, 51h, 0FEh, 0E9h, 83h, 28h, 0E8h, 1Dh, 29h, 75h, 0DEh, 83h, 0Eh, 7Ch, 51h, 20h
	db	0E9h, 76h, 28h, 0E8h, 10h, 29h, 75h, 0D1h, 83h, 26h, 7Ch, 51h, 0DFh, 0E9h, 69h, 28h
	db	0E8h, 3, 29h, 75h, 0C4h, 81h, 0Eh, 7Ch, 51h, 0, 80h, 0E8h, 0A3h, 53h, 75h, 26h
	db	8Bh, 0C2h, 0E8h, 1Fh, 31h, 74h, 19h, 83h, 0C6h, 2, 9Ah
	dd	L101E0
	db	0E8h, 3Ch, 2Fh, 80h, 0F9h, 2, 75h, 9, 26h, 8Bh, 5, 0A3h, 80h, 51h, 0E9h, 39h
	db	28h, 0B9h, 29h, 0, 0E8h, 83h, 5Fh, 0E9h, 30h, 28h, 0E8h, 0CAh, 28h, 75h, 8Bh, 81h
	db	26h, 7Ch, 51h, 0FFh, 7Fh, 0E9h, 22h, 28h, 0E8h, 0BCh, 28h, 75h, 8, 0E8h, 36h, 28h
	db	0E8h, 42h, 48h, 0EBh, 20h, 0C3h, 0E8h, 0AEh, 28h, 75h, 3Ch, 0E8h, 54h, 53h, 75h, 2Eh
	db	0E8h, 0E6h, 30h, 75h, 29h, 83h, 0C6h, 2, 9Ah
	dd	L101E0
	db	0E8h, 0EFh, 2Eh, 32h, 0E4h, 0E8h, 81h, 77h, 0F6h, 6, 0C9h, 38h, 3, 75h, 1Bh, 56h
	db	8Bh, 0F3h, 3, 0F1h, 0C6h, 4, 0, 8Bh, 0F9h, 47h, 0E8h, 4, 2Ah, 5Eh, 0E9h, 0DCh
	db	27h, 0B9h, 7Ch, 0, 0E8h, 26h, 5Fh, 0E9h, 0D3h, 27h, 0E9h, 0BCh, 52h, 0E8h, 6Ah, 28h
	db	75h, 0F8h, 80h, 26h, 86h, 51h, 0F0h, 0E8h, 15h, 1Bh, 23h, 0C9h, 75h, 1Eh, 3Dh, 11h
	db	0, 73h, 19h, 3Ch, 10h, 74h, 0Ch, 3Ch, 0Ah, 74h, 8, 3Ch, 8, 74h, 4, 3Ch
	db	2, 75h, 9, 0FEh, 0C8h, 8, 6, 86h, 51h, 0E9h, 0A1h, 27h, 0B9h, 3Ah, 0, 0E8h
	db	0EBh, 5Eh, 0E9h, 98h, 27h, 0E8h, 0B1h, 27h, 0E8h, 0FBh, 47h, 0E3h, 1Ch, 8Ah, 7, 43h
	db	49h, 23h, 0C9h, 75h, 0Ch, 50h, 0E8h, 8Fh, 24h, 58h, 50h, 0E8h, 0E8h, 47h, 58h, 0EBh
	db	0F0h, 3Ah, 7, 74h, 4, 43h, 49h, 0EBh, 0E8h, 0C3h, 0E8h, 0Dh, 28h, 75h, 6Bh, 0E8h
	db	51h, 0D5h, 75h, 5, 0E8h, 84h, 0A4h, 0E3h, 0Eh, 0F7h, 6, 7Ch, 51h, 8, 0, 0B8h
	db	4, 0, 75h, 3, 0B8h, 2, 0, 83h, 3Eh, 0B0h, 51h, 0, 75h, 43h, 8Bh, 0Eh
	db	7Eh, 51h, 0E3h, 38h, 50h, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	58h, 8Bh, 0C8h, 49h, 33h, 0DBh, 0D1h, 0E8h, 72h, 16h, 0FEh, 0C3h, 80h, 0FBh, 10h, 75h
	db	0F5h, 0F7h, 6, 82h, 51h, 2, 0, 75h, 1, 0C3h, 0B9h, 59h, 80h, 0E9h, 71h, 5Eh
	db	23h, 0C0h, 75h, 0EDh, 51h, 80h, 0FBh, 5, 73h, 2Ah, 0D1h, 0E3h, 0FFh, 0A7h, 0EEh, 1Fh
	db	0B9h, 30h, 0, 0EBh, 3, 0B9h, 49h, 0, 0E8h, 56h, 5Eh, 0E9h, 3, 27h, 0E9h, 0ECh
	db	51h, 59h, 0E9h, 0FCh, 26h, 0E8h, 59h, 30h, 0EBh, 0Dh, 0E8h, 5Dh, 30h, 0EBh, 8, 0E8h
	db	65h, 30h, 0EBh, 3, 0E8h, 71h, 30h, 75h, 3, 0E8h, 0B5h, 0FFh, 59h, 0A1h, 70h, 51h
	db	85h, 0C1h, 74h, 0DEh, 50h, 0A1h, 7Eh, 51h, 9Ah
	dd	L101E0
	db	0E8h, 2Bh, 30h, 58h, 75h, 15h, 0F6h, 6, 0C9h, 38h, 0Bh, 75h, 5, 80h, 0Eh, 0CAh
	db	38h, 1, 51h, 32h, 0C9h, 0E8h, 67h, 0A7h, 59h, 0EBh, 0D5h, 40h, 85h, 0C1h, 74h, 0Eh
	db	51h, 0B1h, 87h, 0E8h, 0F3h, 0ABh, 0B1h, 0DBh, 0E8h, 0EEh, 0ABh, 59h, 0EBh, 0C2h, 51h, 0B1h
	db	90h, 0E8h, 0E5h, 0ABh, 59h, 0EBh, 0B9h, 0E8h, 37h, 27h, 75h, 95h, 0B8h, 2, 0, 0E9h
	db	3Ch, 0FFh, 0E8h, 2Ch, 27h, 75h, 8Ah, 83h, 3Eh, 0B0h, 51h, 0, 74h, 3, 0E9h, 77h
	db	0FFh, 8Bh, 0Eh, 7Eh, 51h, 0E3h, 10h, 0F6h, 6, 70h, 51h, 1, 74h, 6, 0B8h, 1
	db	0, 0E8h, 7Ch, 6Eh, 0E9h, 6Dh, 26h, 0E9h, 59h, 0FFh, 0E8h, 4, 27h, 75h, 4Bh, 56h
	db	9Ah
	dd	L11CBD
	db	5Eh, 0E9h, 5Bh, 26h, 0E8h, 0F5h, 26h, 75h, 3Ch, 0B9h, 28h, 0, 0E8h, 0A0h, 5Dh, 0E9h
	db	4Dh, 26h, 0E8h, 0E7h, 26h, 75h, 2Eh, 0E8h, 8Dh, 51h, 75h, 20h, 8Bh, 0C2h, 0E8h, 9
	db	2Fh, 74h, 19h, 83h, 0C6h, 2, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 0Bh, 9Ah
	dd	L101E0
	db	0E8h, 1Eh, 2Dh, 0E8h, 30h, 6Bh, 0E9h, 23h, 26h, 0B9h, 74h, 0, 0E8h, 6Dh, 5Dh, 0E9h
	db	1Ah, 26h, 0E9h, 3, 51h, 0E8h, 0B1h, 26h, 75h, 0F8h, 83h, 3Eh, 0B0h, 51h, 0, 74h
	db	6, 0B9h, 49h, 0, 0E9h, 55h, 5Dh, 0E8h, 0E8h, 0D3h, 75h, 0Bh, 0E8h, 0F0h, 0A2h, 8Bh
	db	0D1h, 0E8h, 16h, 6Bh, 0E9h, 0F5h, 25h, 0B9h, 2, 0, 0E9h, 3Fh, 5Dh, 0E8h, 89h, 26h
	db	75h, 0D0h, 0B9h, 3Bh, 0, 0E8h, 34h, 5Dh, 0E9h, 0E1h, 25h, 0E8h, 7Bh, 26h, 75h, 5Eh
	db	0E8h, 0B9h, 1, 75h, 0EDh, 0E9h, 0D4h, 25h, 0E8h, 6Eh, 26h, 75h, 51h, 0E8h, 0ACh, 1
	db	74h, 0E0h, 0E9h, 0C7h, 25h, 0E8h, 61h, 26h, 75h, 44h, 0F6h, 6, 0C9h, 38h, 8, 74h
	db	0D1h, 0E9h, 0B8h, 25h, 0E8h, 52h, 26h, 75h, 35h, 0F6h, 6, 0C9h, 38h, 8, 75h, 0C2h
	db	83h, 3Eh, 0B8h, 38h, 0, 74h, 7, 0C6h, 6, 0D0h, 38h, 0FFh, 0EBh, 0Eh, 0F7h, 6
	db	82h, 51h, 10h, 0, 74h, 6, 0B9h, 5Ch, 80h, 0E8h, 0E0h, 5Ch, 0E9h, 8Dh, 25h, 0E8h
	db	27h, 26h, 75h, 0Ah, 0E8h, 73h, 1, 74h, 2, 0EBh, 97h, 0E9h, 7Eh, 25h, 0E9h, 67h
	db	50h, 0E8h, 15h, 26h, 75h, 0F8h, 0E8h, 61h, 1, 75h, 2, 0EBh, 85h, 0E9h, 6Ch, 25h
	db	0E8h, 6, 26h, 75h, 1Bh, 0E8h, 7Ah, 1, 74h, 3, 0E9h, 75h, 0FFh, 0E9h, 5Ch, 25h
	db	0E8h, 0F6h, 25h, 75h, 0Bh, 0E8h, 6Ah, 1, 75h, 3, 0E9h, 65h, 0FFh, 0E9h, 4Ch, 25h
	db	0C3h, 0E8h, 0E5h, 25h, 75h, 0FAh, 0E8h, 61h, 1, 74h, 3, 0E9h, 54h, 0FFh, 0E9h, 3Bh
	db	25h, 0E8h, 0D5h, 25h, 75h, 0EAh, 0E8h, 51h, 1, 75h, 3, 0E9h, 44h, 0FFh, 0E9h, 2Bh
	db	25h, 0E8h, 0C5h, 25h, 75h, 0DAh, 0E8h, 0A2h, 1, 75h, 0D5h, 0B9h, 3Bh, 0, 0E9h, 6Bh
	db	5Ch, 0E8h, 0B5h, 25h, 75h, 0CAh, 0E8h, 92h, 1, 74h, 0C5h, 0B9h, 3Bh, 0, 0E9h, 5Bh
	db	5Ch, 0E8h, 91h, 25h, 75h, 5Ah, 0E8h, 0E3h, 0, 75h, 5Ah, 0EBh, 38h, 0E8h, 85h, 25h
	db	75h, 4Eh, 0E8h, 0D7h, 0, 74h, 4Eh, 0EBh, 2Ch, 0E8h, 79h, 25h, 75h, 42h, 0F6h, 6
	db	0C9h, 38h, 8, 75h, 20h, 0E8h, 0A9h, 0, 0EBh, 3Bh, 0E8h, 68h, 25h, 75h, 31h, 0F6h
	db	6, 0C9h, 38h, 8, 75h, 2Fh, 0E8h, 98h, 0, 0EBh, 0Ah, 0E8h, 57h, 25h, 75h, 20h
	db	0E8h, 0B7h, 0, 75h, 20h, 0A0h, 0C2h, 51h, 0FEh, 0C0h, 0A2h, 0C2h, 51h, 0A2h, 0C3h, 51h
	db	0C6h, 6, 0C4h, 51h, 0, 0F7h, 6, 7Ch, 51h, 0, 20h, 74h, 1Eh, 0E9h, 0ACh, 24h
	db	0FEh, 6, 0C2h, 51h, 0C3h, 0A0h, 0C2h, 51h, 0FEh, 0C0h, 0A2h, 0C2h, 51h, 0A2h, 0C4h, 51h
	db	0F7h, 6, 7Ch, 51h, 0, 20h, 74h, 3, 0E9h, 91h, 24h, 0C3h, 0E8h, 16h, 25h, 75h
	db	0DFh, 0E8h, 76h, 0, 74h, 0DFh, 0EBh, 0BDh, 0E8h, 0Ah, 25h, 75h, 0D3h, 0E8h, 92h, 0
	db	75h, 0D3h, 0EBh, 0B1h, 0E8h, 0FEh, 24h, 75h, 0C7h, 0E8h, 86h, 0, 74h, 0C7h, 0EBh, 0A5h
	db	0E8h, 0F2h, 24h, 75h, 0BBh, 0E8h, 82h, 0, 75h, 0BBh, 0EBh, 99h, 0E8h, 0E6h, 24h, 75h
	db	0AFh, 0E8h, 76h, 0, 74h, 0AFh, 0EBh, 8Dh, 0E8h, 0DAh, 24h, 75h, 0A3h, 0E8h, 0CBh, 0
	db	74h, 0A3h, 0EBh, 81h, 0E8h, 0CEh, 24h, 75h, 97h, 0E8h, 0BFh, 0, 75h, 97h, 0E9h, 74h
	db	0FFh, 83h, 3Eh, 0B8h, 38h, 0, 74h, 6, 0C6h, 6, 0D0h, 38h, 0FFh, 0C3h, 0F7h, 6
	db	82h, 51h, 10h, 0, 74h, 0F7h, 0B9h, 5Ch, 80h, 0E9h, 70h, 5Bh, 0E8h, 3, 0D2h, 75h
	db	6, 0E8h, 36h, 0A1h, 0Bh, 0C1h, 0C3h, 33h, 0C0h, 0C3h, 0E8h, 0D9h, 45h, 75h, 12h, 83h
	db	0C6h, 2, 52h, 0E8h, 0CAh, 81h, 58h, 73h, 3, 0E9h, 27h, 2Eh, 32h, 0C0h, 0FEh, 0C8h
	db	0C3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 74h, 0F7h, 0B9h, 0Dh, 0, 0E8h, 3Dh, 5Bh, 32h
	db	0C0h, 0C3h, 0E8h, 2Fh, 0, 75h, 2, 0F3h, 0A6h, 0C3h, 0E8h, 27h, 0, 75h, 0FAh, 0E3h
	db	0F8h, 0ACh, 3Ch, 61h, 72h, 6, 3Ch, 7Bh, 73h, 2, 2Ch, 20h, 26h, 8Ah, 25h, 47h
	db	80h, 0FCh, 61h, 72h, 8, 80h, 0FCh, 7Bh, 73h, 3, 80h, 0ECh, 20h, 3Ah, 0C4h, 75h
	db	0D8h, 0E2h, 0DEh, 0C3h, 0E8h, 0D1h, 23h, 0E8h, 4Ah, 44h, 75h, 0Fh, 53h, 51h, 0E8h, 0F3h
	db	4Eh, 59h, 5Bh, 75h, 6, 3Bh, 6, 5Eh, 58h, 74h, 0Bh, 0B9h, 83h, 0, 0E8h, 0EBh
	db	5Ah, 32h, 0C0h, 0FEh, 0C8h, 0C3h, 83h, 0C6h, 2, 51h, 53h, 0E8h, 26h, 44h, 5Eh, 58h
	db	75h, 0E9h, 33h, 0C1h, 75h, 4, 8Bh, 0FBh, 16h, 7, 0C3h, 0E8h, 9Ah, 23h, 0E8h, 13h
	db	44h, 75h, 3, 23h, 0C9h, 0C3h, 0B9h, 83h, 0, 0E8h, 0C0h, 5Ah, 32h, 0C0h, 0C3h, 0BBh
	db	0D1h, 0D8h, 0EBh, 35h, 0BBh, 0DDh, 0D8h, 0EBh, 30h, 0BBh, 0E9h, 0D8h, 0EBh, 2Bh, 0BBh, 0FAh
	db	0D8h, 0EBh, 26h, 0BBh, 0Bh, 0D9h, 0EBh, 21h, 0BBh, 4Ch, 0D9h, 0EBh, 1Ch, 0BBh, 58h, 0D9h
	db	0EBh, 17h, 0BBh, 64h, 0D9h, 0EBh, 12h, 0BBh, 70h, 0D9h, 0EBh, 0Dh, 0BBh, 7Ch, 0D9h, 0EBh
	db	8, 0BBh, 88h, 0D9h, 0EBh, 3, 0BBh, 94h, 0D9h, 53h, 0E8h, 0B8h, 23h, 5Bh, 0A0h, 0C2h
	db	51h, 22h, 0C0h, 74h, 3Dh, 3Ah, 6, 0C4h, 51h, 74h, 33h, 3Ah, 6, 0C3h, 51h, 75h
	db	30h, 0C6h, 6, 0C3h, 51h, 0, 0FEh, 0Eh, 0C2h, 51h, 0FFh, 0E3h, 0E8h, 96h, 23h, 0A0h
	db	0C2h, 51h, 22h, 0C0h, 74h, 1Ch, 3Ah, 6, 0C4h, 51h, 74h, 12h, 3Ah, 6, 0C3h, 51h
	db	74h, 1, 0C3h, 0A2h, 0C4h, 51h, 0C6h, 6, 0C3h, 51h, 0, 0E9h, 0EEh, 22h, 0A2h, 0C3h
	db	51h, 0C3h, 0B9h, 37h, 0, 0E9h, 34h, 5Ah, 0E8h, 6Ah, 23h, 0A0h, 0C2h, 51h, 22h, 0C0h
	db	74h, 0F0h, 0FEh, 0Eh, 0C2h, 51h, 3Ah, 6, 0C3h, 51h, 75h, 5, 0C6h, 6, 0C3h, 51h
	db	0, 80h, 3Eh, 0C3h, 51h, 0, 75h, 6, 0A0h, 0C2h, 51h, 0A2h, 0C4h, 51h, 0E9h, 0BBh
	db	22h, 0E8h, 55h, 23h, 75h, 14h, 0E8h, 30h, 0, 75h, 17h, 56h, 9Ah
	dd	L11A73
	db	9Ah
	dd	L11B65
	db	5Eh, 0E9h, 0A2h, 22h, 0E8h, 1Ch, 0, 75h, 9, 0E9h, 86h, 4Dh, 0B9h, 11h, 0, 0E8h
	db	0E4h, 59h, 0C3h, 0E8h, 2Dh, 23h, 75h, 0ECh, 0E8h, 8, 0, 75h, 0EFh, 0E8h, 3Ch, 63h
	db	0E9h, 83h, 22h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 9, 0E8h, 94h, 22h, 0E8h, 0FEh
	db	43h, 75h, 1Dh, 0C3h, 0E8h, 0B7h, 4Dh, 75h, 17h, 0E8h, 49h, 2Bh, 75h, 12h, 83h, 0C6h
	db	2, 9Ah
	dd	L101E0
	db	0E8h, 52h, 29h, 32h, 0E4h, 0E8h, 0E4h, 71h, 32h, 0C0h, 0C3h, 0E8h, 0EFh, 22h, 75h, 41h
	db	83h, 0Eh, 0B6h, 38h, 10h, 0E9h, 48h, 22h, 0E8h, 0E2h, 22h, 75h, 34h, 83h, 26h, 0B6h
	db	38h, 0EFh, 0E9h, 3Bh, 22h, 0E8h, 0D5h, 22h, 75h, 27h, 0F7h, 6, 0B6h, 38h, 8, 40h
	db	75h, 1Fh, 0E8h, 0F5h, 43h, 75h, 1Ah, 16h, 7, 0BFh, 0E6h, 57h, 0B9h, 6, 0, 0F2h
	db	0AFh, 75h, 0Eh, 83h, 0C6h, 2, 0BBh, 5, 0, 2Bh, 0D9h, 0D1h, 0E3h, 0FFh, 0A7h, 48h
	db	20h, 0E9h, 0F8h, 4Ch, 0E8h, 51h, 4Dh, 75h, 0F8h, 83h, 0C6h, 2, 9Ah
	dd	L101E0
	db	0E8h, 0F1h, 28h, 9Ah
	dd	L10375
	db	0E8h, 0C6h, 62h, 0E8h, 39h, 4Dh, 75h, 6, 3Bh, 6, 0A6h, 58h, 74h, 0DAh, 0E9h, 0C7h
	db	62h, 0E8h, 0C9h, 0CFh, 75h, 0D2h, 0E8h, 0FCh, 9Eh, 48h, 0E9h, 30h, 63h, 0E8h, 1Fh, 4Dh
	db	75h, 0C6h, 83h, 0C6h, 2, 9Ah
	dd	L101E0
	db	0E8h, 0BFh, 28h, 32h, 0E4h, 0E8h, 51h, 71h, 0E8h, 0DBh, 27h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0E8h, 0ADh, 28h, 0C6h, 6, 0CEh, 38h, 0FFh, 0E9h, 0BAh, 66h, 0E8h, 0F5h, 4Ch, 75h, 9Ch
	db	8Bh, 0C2h, 52h, 0E8h, 0BCh, 28h, 0A8h, 20h, 74h, 2Ch, 83h, 0C6h, 2, 0E8h, 81h, 0CFh
	db	75h, 24h, 0E8h, 0B4h, 9Eh, 50h, 0E8h, 78h, 0CFh, 75h, 1Ah, 0E8h, 0ABh, 9Eh, 8Ah, 0E8h
	db	5Bh, 58h, 9Ah
	dd	L101E0
	db	53h, 51h, 56h, 0E8h, 55h, 37h, 8Bh, 0FEh, 5Eh, 59h, 5Bh, 0E9h, 97h, 62h, 5Bh, 5Ah
	db	0C3h, 0E8h, 9Bh, 21h, 75h, 23h, 89h, 36h, 0ECh, 56h, 0E8h, 4Dh, 0CFh, 75h, 0Fh, 89h
	db	36h, 0EEh, 56h, 0E8h, 0A6h, 4Ch, 74h, 14h, 0E8h, 0DAh, 0A5h, 0E9h, 56h, 21h, 0B9h, 0Dh
	db	0, 0E8h, 0A0h, 58h, 0E8h, 0Dh, 7Dh, 0EBh, 0EFh, 0E9h, 34h, 4Ch, 6, 0E8h, 4Ah, 15h
	db	0E8h, 71h, 15h, 7, 0E8h, 85h, 4Ch, 75h, 0DFh, 0F6h, 6, 3, 57h, 10h, 74h, 0D8h
	db	3Bh, 6, 5Eh, 58h, 75h, 0D2h, 83h, 0C6h, 2, 56h, 0E8h, 13h, 4Ch, 16h, 7, 0BFh
	db	72h, 20h, 0B9h, 8, 0, 9Ah
	dd	L11BEA
	db	5Eh, 0C7h, 6, 8, 57h, 0, 0, 0BBh, 21h, 0DDh, 0F6h, 6, 3, 57h, 20h, 75h
	db	3, 0BBh, 27h, 0DDh, 0FFh, 0D3h, 16h, 7, 56h, 0BFh, 0DEh, 52h, 0BEh, 7Ah, 20h, 0E8h
	db	0Ch, 72h, 8Bh, 36h, 0ECh, 56h, 8Bh, 1Eh, 0EEh, 56h, 0E8h, 0B3h, 0, 0B0h, 0Dh, 0AAh
	db	0BBh, 0DEh, 52h, 9Ah
	dd	L11C48
	db	0F6h, 6, 3, 57h, 20h, 75h, 17h, 0A1h, 8, 57h, 23h, 0C0h, 74h, 10h, 16h, 7
	db	0BFh, 90h, 20h, 0E8h, 0ABh, 71h, 0BBh, 88h, 20h, 9Ah
	dd	L11C48
	db	9Ah
	dd	L11CA8
	db	5Eh, 0E9h, 0BBh, 20h, 0BBh, 55h, 0DDh, 0E9h, 92h, 14h, 56h, 0E8h, 0F9h, 4Bh, 74h, 8
	db	0B9h, 10h, 0, 0E8h, 0F9h, 57h, 58h, 0C3h, 83h, 0C6h, 2, 3Bh, 6, 5Eh, 58h, 74h
	db	0Bh, 0E8h, 0E3h, 4Bh, 74h, 0F2h, 89h, 36h, 0F2h, 56h, 0EBh, 3, 0E8h, 0DBh, 0FFh, 5Eh
	db	0E8h, 5, 0, 8Bh, 36h, 0F2h, 56h, 0C3h, 56h, 16h, 7, 0BFh, 0DEh, 52h, 0BEh, 81h
	db	20h, 0E8h, 8Fh, 71h, 5Eh, 6, 57h, 56h, 0E8h, 5Ah, 0CEh, 74h, 4, 58h, 58h, 58h
	db	0C3h, 80h, 0Eh, 0CAh, 38h, 1, 0E8h, 0EEh, 97h, 0C6h, 6, 0CAh, 38h, 0, 1, 6
	db	8, 57h, 8Bh, 0DEh, 5Eh, 5Fh, 7, 0E8h, 1Bh, 0, 6, 57h, 56h, 0E8h, 35h, 0CEh
	db	74h, 0DFh, 58h, 5Fh, 7, 0B0h, 0Dh, 0AAh, 56h, 0BBh, 0DEh, 52h, 9Ah
	dd	L11C48
	db	5Eh, 32h, 0C0h, 0C3h, 6, 57h, 53h, 0E8h, 7Ch, 4Bh, 5Bh, 8Bh, 0C2h, 5Fh, 7, 22h
	db	0E4h, 74h, 0Ch, 53h, 56h, 0E8h, 25h, 71h, 5Eh, 5Bh, 0B0h, 20h, 0AAh, 0EBh, 1, 0AAh
	db	83h, 0C6h, 2, 3Bh, 0F3h, 75h, 0DDh, 0C3h, 0E8h, 0B0h, 20h, 75h, 43h, 0E8h, 0A6h, 17h
	db	0E8h, 0D0h, 0, 0F6h, 6, 0BFh, 51h, 80h, 74h, 8, 2Bh, 6, 0A0h, 51h, 1Bh, 16h
	db	0A2h, 51h, 0A3h, 8, 57h, 89h, 16h, 0Ah, 57h, 0F6h, 6, 0BFh, 51h, 20h, 74h, 23h
	db	56h, 0BBh, 69h, 0DEh, 0E8h, 0C4h, 13h, 5Eh, 0FFh, 36h, 8, 57h, 0FFh, 36h, 0Ah, 57h
	db	0BBh, 83h, 0DEh, 0E8h, 0B5h, 13h, 8Fh, 6, 0Ah, 57h, 8Fh, 6, 8, 57h, 0EBh, 9
	db	0E9h, 0B7h, 4Ah, 0BBh, 92h, 0DEh, 0E8h, 0A2h, 13h, 0F6h, 6, 0BFh, 51h, 80h, 74h, 12h
	db	0E8h, 80h, 0, 2Bh, 6, 8, 57h, 1Bh, 16h, 0Ah, 57h, 0A3h, 0A0h, 51h, 89h, 16h
	db	0A2h, 51h, 0E8h, 0F1h, 4Ah, 75h, 28h, 3Bh, 6, 30h, 58h, 75h, 22h, 83h, 0C6h, 2
	db	0E8h, 0E3h, 4Ah, 75h, 1Dh, 8Bh, 0C2h, 0E8h, 5Fh, 28h, 74h, 16h, 83h, 0C6h, 2, 8Bh
	db	0C8h, 0E8h, 4Fh, 0, 2Bh, 6, 8, 57h, 1Bh, 16h, 0Ah, 57h, 0E8h, 96h, 9Bh, 0E9h
	db	7Ch, 1Fh, 0B9h, 5Ah, 0, 0E8h, 0C6h, 56h, 0E9h, 73h, 1Fh, 0E8h, 4Ah, 14h, 75h, 11h
	db	83h, 3Eh, 0F0h, 56h, 0, 75h, 0Bh, 29h, 1Eh, 8, 57h, 19h, 0Eh, 0Ah, 57h, 32h
	db	0C0h, 0C3h, 0E9h, 21h, 14h, 0E8h, 30h, 14h, 75h, 0F7h, 83h, 3Eh, 0F0h, 56h, 0, 75h
	db	0EEh, 0E9h, 56h, 1, 0E8h, 21h, 14h, 75h, 0E8h, 83h, 3Eh, 0F0h, 56h, 0, 75h, 0E2h
	db	0E9h, 2Dh, 1, 33h, 0C0h, 8Bh, 0D0h, 80h, 3Eh, 0C0h, 51h, 1, 75h, 4, 0B8h, 0FEh
	db	0FFh, 99h, 0C3h, 0E8h, 0C5h, 1Fh, 74h, 3, 0E9h, 7Dh, 0, 0E8h, 0B8h, 16h, 0BAh, 2
	db	0, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 8, 0E8h, 0D7h, 28h, 0B8h, 4, 0, 75h, 3
	db	0B8h, 2, 0, 0F6h, 6, 86h, 51h, 10h, 74h, 2, 0D1h, 0E0h, 3, 0C2h, 0A3h, 6
	db	57h, 0A3h, 8, 57h, 0C7h, 6, 0Ah, 57h, 0, 0, 0F6h, 6, 0BFh, 51h, 80h, 74h
	db	15h, 0A1h, 9Ch, 51h, 8Bh, 0Eh, 9Eh, 51h, 8Bh, 0D8h, 0Bh, 0D9h, 74h, 8, 1, 6
	db	8, 57h, 11h, 0Eh, 0Ah, 57h, 0E8h, 1Dh, 4Ah, 75h, 6, 3Bh, 6, 78h, 57h, 74h
	db	7Ch, 0F6h, 6, 0BFh, 51h, 20h, 74h, 23h, 56h, 0BBh, 0ABh, 0DFh, 0E8h, 9Ch, 12h, 5Eh
	db	0FFh, 36h, 8, 57h, 0FFh, 36h, 0Ah, 57h, 0BBh, 0C2h, 0DFh, 0E8h, 8Dh, 12h, 8Fh, 6
	db	0Ah, 57h, 8Fh, 6, 8, 57h, 0EBh, 9, 0E9h, 8Fh, 49h, 0BBh, 0DCh, 0DFh, 0E8h, 7Ah
	db	12h, 0F6h, 6, 0BFh, 51h, 80h, 74h, 15h, 0A1h, 8, 57h, 8Bh, 16h, 0Ah, 57h, 2Bh
	db	6, 6, 57h, 83h, 0DAh, 0, 0A3h, 9Ch, 51h, 89h, 16h, 9Eh, 51h, 0E8h, 0C6h, 49h
	db	75h, 3Fh, 3Bh, 6, 30h, 58h, 75h, 25h, 83h, 0C6h, 2, 0E8h, 0B8h, 49h, 75h, 34h
	db	8Bh, 0C2h, 0E8h, 34h, 27h, 74h, 2Dh, 83h, 0C6h, 2, 8Bh, 0C8h, 0A1h, 8, 57h, 8Bh
	db	16h, 0Ah, 57h, 2Bh, 6, 6, 57h, 83h, 0DAh, 0, 0E8h, 68h, 9Ah, 0E8h, 96h, 49h
	db	75h, 0Fh, 3Bh, 6, 78h, 57h, 75h, 9, 83h, 0C6h, 2, 0BBh, 0DCh, 0DFh, 0E8h, 1Ah
	db	12h, 0E9h, 3Ah, 1Eh, 0B9h, 5Ah, 0, 0E8h, 84h, 55h, 0E9h, 31h, 1Eh, 0E8h, 8, 13h
	db	75h, 49h, 83h, 3Eh, 0F0h, 56h, 0, 75h, 43h, 1, 1Eh, 8, 57h, 11h, 0Eh, 0Ah
	db	57h, 32h, 0C0h, 0C3h, 0E8h, 0F1h, 12h, 75h, 32h, 83h, 3Eh, 0F0h, 56h, 0, 75h, 29h
	db	29h, 1Eh, 8, 57h, 19h, 0Eh, 0Ah, 57h, 0E8h, 15h, 13h, 32h, 0C0h, 0C3h, 0E8h, 0D7h
	db	12h, 75h, 18h, 83h, 3Eh, 0F0h, 56h, 0, 75h, 12h, 53h, 51h, 0E8h, 1, 13h, 59h
	db	5Bh, 1, 1Eh, 8, 57h, 11h, 0Eh, 0Ah, 57h, 32h, 0C0h, 0C3h, 0E9h, 0A7h, 12h, 0E8h
	db	79h, 1Eh, 75h, 25h, 0E8h, 6Fh, 15h, 0F6h, 6, 0BFh, 51h, 10h, 75h, 6, 0B9h, 85h
	db	80h, 0E8h, 1Ah, 55h, 0F6h, 6, 0BFh, 51h, 80h, 75h, 5, 0C6h, 6, 0BAh, 51h, 0
	db	0BBh, 2Ah, 0E0h, 0E8h, 95h, 11h, 0E9h, 0B5h, 1Dh, 0E9h, 9Eh, 48h, 0E8h, 0F7h, 48h, 75h
	db	2Fh, 0E8h, 75h, 26h, 74h, 26h, 83h, 0C6h, 2, 8Bh, 0C2h, 8Ah, 1Eh, 0BAh, 51h, 80h
	db	0FBh, 8, 74h, 0Fh, 0FEh, 6, 0BAh, 51h, 32h, 0FFh, 0D1h, 0E3h, 89h, 87h, 8Ch, 51h
	db	32h, 0C0h, 0C3h, 0B9h, 82h, 0, 0E8h, 0D5h, 54h, 32h, 0C0h, 0C3h, 32h, 0C0h, 0FEh, 0C8h
	db	0C3h, 0E8h, 17h, 1Eh, 75h, 0Ch, 0E8h, 91h, 1Dh, 0BBh, 73h, 0E0h, 0E8h, 4Ch, 11h, 0E9h
	db	6Ch, 1Dh, 0E9h, 55h, 48h, 0E8h, 22h, 13h, 75h, 52h, 83h, 3Eh, 0F0h, 56h, 0, 75h
	db	20h, 0A1h, 0ECh, 56h, 9Ah
	dd	L101E0
	db	8Ah, 1Eh, 2, 57h, 8Bh, 3Eh, 0F2h, 56h, 0F6h, 0C3h, 20h, 75h, 0Eh, 0E8h, 4Bh, 36h
	db	75h, 6, 0E8h, 55h, 58h, 0E8h, 5Ah, 36h, 32h, 0C0h, 0C3h, 8Bh, 0C7h, 80h, 0CBh, 10h
	db	0E8h, 1Bh, 31h, 75h, 0F3h, 0E8h, 42h, 58h, 0E8h, 0CBh, 31h, 8Ah, 1Eh, 2, 57h, 8Bh
	db	0Eh, 0F2h, 56h, 0E8h, 0D7h, 1Fh, 8Bh, 0Eh, 0F8h, 56h, 8Bh, 3Eh, 0FAh, 56h, 0E8h, 0C9h
	db	32h, 32h, 0C0h, 0C3h, 0E8h, 0ABh, 1Dh, 75h, 0Ch, 0E8h, 25h, 1Dh, 0BBh, 0DFh, 0E0h, 0E8h
	db	0E0h, 10h, 0E9h, 0, 1Dh, 0E9h, 0E9h, 47h, 0FFh, 36h, 7Ch, 51h, 83h, 0Eh, 7Ch, 51h
	db	8, 0E8h, 0D7h, 12h, 8Fh, 6, 7Ch, 51h, 75h, 5Ch, 83h, 3Eh, 0F0h, 56h, 0, 75h
	db	53h, 8Bh, 0Eh, 0ECh, 56h, 0E3h, 4Dh, 8Bh, 0C1h, 9Ah
	dd	L101E0
	db	8Ah, 1Eh, 2, 57h, 8Bh, 3Eh, 0F2h, 56h, 0F6h, 0C3h, 20h, 75h, 2, 0EBh, 80h, 8Bh
	db	0C7h, 80h, 0CBh, 10h, 0E8h, 0A9h, 30h, 75h, 2Dh, 0E8h, 0D0h, 57h, 56h, 50h, 53h, 8Bh
	db	0C8h, 0E8h, 6Bh, 1Fh, 8Bh, 0Eh, 0FCh, 56h, 8Bh, 3Eh, 0FEh, 56h, 0E8h, 5Fh, 6Dh, 8Bh
	db	17h, 8Bh, 77h, 2, 5Bh, 58h, 8Bh, 0Eh, 0F8h, 56h, 8Bh, 3Eh, 0FAh, 56h, 8Ah, 3Eh
	db	1, 57h, 0E8h, 0A4h, 30h, 5Eh, 32h, 0C0h, 0C3h, 0E8h, 28h, 1Dh, 75h, 0Ch, 0E8h, 0A2h
	db	1Ch, 0BBh, 62h, 0E1h, 0E8h, 5Dh, 10h, 0E9h, 7Dh, 1Ch, 0E9h, 66h, 47h, 0E8h, 33h, 12h
	db	75h, 37h, 0A1h, 0ECh, 56h, 0E8h, 86h, 23h, 8Ah, 0F8h, 80h, 0E7h, 3Fh, 80h, 0FFh, 0
	db	75h, 33h, 0F6h, 6, 0C9h, 38h, 0Bh, 75h, 21h, 83h, 3Eh, 0F0h, 56h, 0, 75h, 12h
	db	0A1h, 0ECh, 56h, 9Ah
	dd	L101E0
	db	8Ah, 1Eh, 2, 57h, 0A1h, 0F2h, 56h, 0E8h, 0A7h, 27h, 80h, 0Eh, 0CAh, 38h, 1, 32h
	db	0C0h, 0C3h, 0A1h, 0ECh, 56h, 0E8h, 68h, 25h, 74h, 71h, 0E9h, 0CEh, 0FEh, 0F6h, 0C7h, 20h
	db	74h, 2Eh, 0F6h, 0C7h, 10h, 75h, 0F3h, 22h, 0FFh, 74h, 55h, 3Ah, 3Eh, 2, 57h, 75h
	db	3Dh, 3Bh, 3Eh, 0F2h, 56h, 75h, 37h, 0A1h, 0ECh, 56h, 9Ah
	dd	L101E0
	db	0E8h, 0ECh, 1Eh, 3Bh, 6, 0F8h, 56h, 75h, 26h, 3Bh, 16h, 0FAh, 56h, 75h, 20h, 0EBh
	db	30h, 80h, 0E7h, 1Fh, 80h, 0FFh, 1, 74h, 36h, 80h, 0FFh, 9, 74h, 2Eh, 80h, 0FFh
	db	8, 74h, 5, 80h, 0FFh, 0Ch, 75h, 19h, 80h, 3Eh, 2, 57h, 0, 74h, 12h, 0F7h
	db	6, 82h, 51h, 20h, 0, 74h, 0Ah, 8Bh, 3Eh, 0ECh, 56h, 0B9h, 8Ah, 90h, 0E8h, 1Fh
	db	53h, 0A1h, 0ECh, 56h, 9Ah
	dd	L101E0
	db	0E8h, 6Eh, 20h, 32h, 0C0h, 0C3h, 8Bh, 3Eh, 0ECh, 56h, 0B9h, 13h, 10h, 0E8h, 7, 53h
	db	32h, 0C0h, 0C3h, 0E8h, 4Eh, 1Ch, 75h, 0Ch, 0E8h, 0C8h, 1Bh, 0BBh, 3Ch, 0E2h, 0E8h, 83h
	db	0Fh, 0E9h, 0A3h, 1Bh, 0E9h, 8Ch, 46h, 0E8h, 4, 10h, 75h, 0Ch, 0A1h, 0EEh, 56h, 8Bh
	db	16h, 0ECh, 56h, 0E8h, 68h, 96h, 32h, 0C0h, 0C3h, 0E8h, 28h, 1Ch, 75h, 0Ch, 0E8h, 0A2h
	db	1Bh, 0BBh, 62h, 0E2h, 0E8h, 5Dh, 0Fh, 0E9h, 7Dh, 1Bh, 0E9h, 66h, 46h, 0E8h, 0DEh, 0Fh
	db	75h, 0Ch, 0A1h, 0EEh, 56h, 8Bh, 16h, 0ECh, 56h, 0E8h, 0E9h, 95h, 32h, 0C0h, 0C3h, 0E8h
	db	2, 1Ch, 75h, 9, 0BBh, 85h, 0E2h, 0E8h, 3Ah, 0Fh, 0E9h, 5Ah, 1Bh, 0E9h, 43h, 46h
	db	0E8h, 9Ch, 46h, 75h, 5Bh, 3Bh, 6, 68h, 58h, 74h, 0Ah, 0E8h, 14h, 24h, 75h, 0Eh
	db	32h, 0C0h, 0FEh, 0C8h, 0C3h, 0E8h, 1Ch, 93h, 83h, 0C6h, 2, 32h, 0C0h, 0C3h, 83h, 0C6h
	db	2, 50h, 0E8h, 7Ah, 46h, 5Bh, 75h, 38h, 3Bh, 6, 2Eh, 58h, 8Bh, 0C3h, 74h, 8
	db	0B9h, 0Bh, 0, 0E8h, 71h, 52h, 0EBh, 3, 83h, 0C6h, 2, 50h, 0E8h, 0FEh, 0C8h, 58h
	db	74h, 0Bh, 0B9h, 2, 0, 0E8h, 5Fh, 52h, 50h, 0E8h, 0CBh, 76h, 58h, 0E8h, 0AAh, 25h
	db	74h, 9, 0B9h, 63h, 0, 0E8h, 4Fh, 52h, 32h, 0C0h, 0C3h, 8Bh, 0C8h, 0E9h, 9Bh, 97h
	db	0C3h, 0E8h, 90h, 1Bh, 75h, 1Eh, 0E8h, 1Eh, 0, 74h, 6, 0B9h, 10h, 0, 0E8h, 36h
	db	52h, 0E8h, 2Bh, 46h, 75h, 0Bh, 3Bh, 6, 5Eh, 58h, 75h, 5, 83h, 0C6h, 2, 0EBh
	db	0E5h, 0E9h, 0D3h, 1Ah, 0E9h, 0BCh, 45h, 0E8h, 97h, 3Ch, 75h, 25h, 0E8h, 93h, 23h, 74h
	db	1Ch, 83h, 0C6h, 2, 9Ah
	dd	L101E0
	db	6, 55h, 0E8h, 0DCh, 25h, 5Dh, 7, 75h, 8, 0E8h, 55h, 26h, 75h, 3, 0E8h, 99h
	db	26h, 32h, 0C0h, 0C3h, 32h, 0C0h, 0FEh, 0C8h, 0C3h, 0E8h, 0BEh, 1Ah, 0E8h, 59h, 26h, 0E8h
	db	5Ch, 3Ch, 51h, 0E8h, 5Dh, 3Ch, 5Eh, 6, 55h, 0E8h, 0EFh, 26h, 5Dh, 7, 0A1h, 6Ah
	db	57h, 6, 55h, 0E8h, 5Fh, 3Dh, 5Dh, 7, 0E9h, 61h, 26h, 0E8h, 1Dh, 1Bh, 75h, 4Ah
	db	0E8h, 61h, 0C8h, 74h, 11h, 0F7h, 6, 7Ch, 51h, 0, 20h, 75h, 6, 0B9h, 2, 0
	db	0E8h, 0BBh, 51h, 0E8h, 28h, 76h, 0E8h, 83h, 97h, 0A3h, 16h, 57h, 89h, 0Eh, 18h, 57h
	db	0E8h, 5Bh, 1Ah, 0E8h, 12h, 26h, 89h, 2Eh, 0E0h, 56h, 8Ch, 6, 0E2h, 56h, 0E8h, 51h
	db	1, 8Bh, 1Eh, 16h, 57h, 8Bh, 16h, 18h, 57h, 0A1h, 6Ch, 57h, 0C4h, 2Eh, 0E0h, 56h
	db	0E8h, 2Ah, 3Dh, 0C4h, 2Eh, 0E0h, 56h, 0E9h, 12h, 26h, 0E9h, 1Ch, 2, 0E8h, 0CBh, 1Ah
	db	75h, 56h, 0E8h, 0E3h, 25h, 89h, 2Eh, 0E0h, 56h, 8Ch, 6, 0E2h, 56h, 0E8h, 0E8h, 3Bh
	db	75h, 3Eh, 8Bh, 0C2h, 0E8h, 0E2h, 22h, 74h, 37h, 0C4h, 2Eh, 0E0h, 56h, 0E8h, 1Fh, 26h
	db	83h, 0C6h, 2, 0E8h, 50h, 45h, 75h, 20h, 3Bh, 6, 5Eh, 58h, 75h, 1Ah, 83h, 0C6h
	db	2, 0E8h, 11h, 3Dh, 0E8h, 0FBh, 0, 0C4h, 2Eh, 0E0h, 56h, 0A1h, 6Eh, 57h, 0E8h, 1Dh
	db	3Eh, 0C4h, 2Eh, 0E0h, 56h, 0E9h, 0C4h, 25h, 0B9h, 48h, 0, 0E8h, 30h, 51h, 0EBh, 0F1h
	db	0B9h, 47h, 0, 0E8h, 28h, 51h, 0EBh, 0E9h, 0E9h, 0BEh, 1, 0E8h, 6Dh, 1Ah, 75h, 56h
	db	0E8h, 85h, 25h, 89h, 2Eh, 0E0h, 56h, 8Ch, 6, 0E2h, 56h, 0E8h, 8Ah, 3Bh, 75h, 3Eh
	db	8Bh, 0C2h, 0E8h, 84h, 22h, 74h, 37h, 0C4h, 2Eh, 0E0h, 56h, 0E8h, 0C1h, 25h, 83h, 0C6h
	db	2, 0E8h, 0F2h, 44h, 75h, 20h, 3Bh, 6, 5Eh, 58h, 75h, 1Ah, 83h, 0C6h, 2, 0E8h
	db	58h, 3Dh, 0E8h, 9Dh, 0, 0C4h, 2Eh, 0E0h, 56h, 0A1h, 70h, 57h, 0E8h, 0CCh, 3Eh, 0C4h
	db	2Eh, 0E0h, 56h, 0E9h, 66h, 25h, 0B9h, 48h, 0, 0E8h, 0D2h, 50h, 0EBh, 0F1h, 0B9h, 47h
	db	0, 0E8h, 0CAh, 50h, 0EBh, 0E9h, 0E9h, 60h, 1, 0E8h, 0Fh, 1Ah, 75h, 71h, 0E8h, 62h
	db	22h, 83h, 0EEh, 2, 8Bh, 0C2h, 0EBh, 1Dh, 0E8h, 0, 1Ah, 75h, 62h, 0E8h, 28h, 3Bh
	db	75h, 57h, 0E8h, 24h, 22h, 74h, 52h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 6, 0B9h
	db	6Fh, 0, 0E9h, 99h, 50h, 9Ah
	dd	L101E0
	db	0E8h, 0E4h, 24h, 75h, 40h, 0E8h, 51h, 54h, 0E8h, 41h, 25h, 89h, 2Eh, 0E0h, 56h, 8Ch
	db	6, 0E2h, 56h, 83h, 0C6h, 2, 0E8h, 0F5h, 3Ah, 75h, 2Dh, 8Bh, 0C2h, 0E8h, 0EFh, 21h
	db	74h, 15h, 83h, 0C6h, 2, 0C4h, 2Eh, 0E0h, 56h, 0E8h, 29h, 25h, 0E8h, 0DFh, 3Ah, 75h
	db	17h, 3Bh, 6, 5Eh, 58h, 74h, 0DCh, 0B9h, 43h, 0, 0E8h, 57h, 50h, 0EBh, 9, 0B9h
	db	45h, 0, 0E8h, 4Fh, 50h, 0E9h, 0E7h, 0, 0C7h, 6, 14h, 57h, 1, 0, 0E8h, 0FEh
	db	15h, 89h, 36h, 1Ah, 57h, 33h, 0F6h, 0E8h, 0AAh, 3Ah, 51h, 0E8h, 0ABh, 3Ah, 59h, 75h
	db	33h, 3Bh, 6, 76h, 57h, 75h, 4Bh, 83h, 0C6h, 2, 0E8h, 0A1h, 3Ah, 75h, 0DFh, 8Bh
	db	0C2h, 0E8h, 9Bh, 21h, 74h, 15h, 83h, 0C6h, 2, 0C4h, 2Eh, 0E0h, 56h, 0E8h, 0D9h, 24h
	db	0E8h, 8Bh, 3Ah, 75h, 0C9h, 3Bh, 6, 5Eh, 58h, 74h, 0DCh, 0B9h, 44h, 0, 0E8h, 3
	db	50h, 0EBh, 0BBh, 0C3h, 0C4h, 2Eh, 0E0h, 56h, 8Bh, 36h, 1Ah, 57h, 0E8h, 2, 25h, 0E8h
	db	0ADh, 15h, 89h, 36h, 1Ah, 57h, 33h, 0F6h, 0E8h, 59h, 3Ah, 51h, 0E8h, 5Ah, 3Ah, 59h
	db	75h, 0E2h, 89h, 0Eh, 1Ch, 57h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 1Dh, 50h, 83h
	db	0C6h, 2, 0E8h, 44h, 3Ah, 8Bh, 0D0h, 58h, 75h, 11h, 3Bh, 16h, 6Ah, 57h, 74h, 58h
	db	3Bh, 16h, 2Eh, 58h, 75h, 5, 83h, 0C6h, 2, 0EBh, 0CDh, 3Bh, 6, 72h, 57h, 75h
	db	2, 8Bh, 0C2h, 3Bh, 6, 6Ah, 57h, 74h, 3Fh, 3Bh, 6, 6Ch, 57h, 74h, 39h, 3Bh
	db	6, 6Eh, 57h, 74h, 33h, 3Bh, 6, 70h, 57h, 74h, 2Dh, 3Bh, 6, 74h, 57h, 75h
	db	93h, 0FFh, 0Eh, 14h, 57h, 75h, 8Dh, 8Bh, 36h, 1Ah, 57h, 8Bh, 1Eh, 1Ch, 57h, 3Bh
	db	0F3h, 74h, 80h, 8Ah, 7, 50h, 53h, 0C6h, 7, 0Dh, 0C4h, 2Eh, 0E0h, 56h, 0E8h, 80h
	db	24h, 5Bh, 58h, 88h, 7, 0E9h, 6Bh, 0FFh, 0FFh, 6, 14h, 57h, 0E9h, 65h, 0FFh, 0C7h
	db	6, 14h, 57h, 1, 0, 0E8h, 17h, 15h, 0E8h, 0A6h, 18h, 33h, 0F6h, 0E8h, 0C9h, 39h
	db	75h, 0F3h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 1Dh, 50h, 83h, 0C6h, 2, 0E8h, 0B8h
	db	39h, 8Bh, 0D0h, 58h, 75h, 11h, 3Bh, 16h, 6Ah, 57h, 74h, 2Bh, 3Bh, 16h, 2Eh, 58h
	db	75h, 5, 83h, 0C6h, 2, 0EBh, 0D6h, 3Bh, 6, 72h, 57h, 75h, 2, 8Bh, 0C2h, 3Bh
	db	6, 6Ah, 57h, 74h, 12h, 3Bh, 6, 6Ch, 57h, 74h, 0Ch, 3Bh, 6, 6Eh, 57h, 74h
	db	6, 3Bh, 6, 70h, 57h, 75h, 6, 0FFh, 6, 14h, 57h, 0EBh, 0A8h, 3Bh, 6, 74h
	db	57h, 75h, 0A2h, 0FFh, 0Eh, 14h, 57h, 75h, 9Ch, 0C3h, 0E8h, 44h, 18h, 75h, 21h, 0E8h
	db	88h, 0C5h, 74h, 0Ch, 80h, 3Eh, 0C1h, 51h, 0, 74h, 0Ah, 0E8h, 0E6h, 91h, 0EBh, 0Dh
	db	0E8h, 5Ah, 94h, 0EBh, 3, 0E8h, 7Ah, 94h, 0C6h, 6, 0BCh, 51h, 0FFh, 0E9h, 84h, 17h
	db	0E9h, 6Dh, 42h, 0E8h, 1Bh, 18h, 75h, 1Ch, 0E8h, 95h, 17h, 0E8h, 0DDh, 0Bh, 75h, 0Bh
	db	0E8h, 55h, 0C6h, 74h, 3, 0E8h, 0F6h, 78h, 0E9h, 82h, 0, 0B9h, 4Ah, 0, 0E8h, 0B3h
	db	4Eh, 0E9h, 60h, 17h, 0E9h, 49h, 42h, 0E8h, 0F7h, 17h, 75h, 66h, 52h, 0E8h, 5Ah, 0Bh
	db	0E8h, 81h, 0Bh, 0E8h, 32h, 0C6h, 75h, 20h, 0F7h, 6, 7Ch, 51h, 0, 60h, 75h, 1Bh
	db	6, 55h, 0A0h, 3, 57h, 50h, 0E8h, 6Bh, 0Bh, 58h, 5Dh, 7, 86h, 6, 3, 57h
	db	75h, 9, 86h, 6, 3, 57h, 0EBh, 3, 0E8h, 0B3h, 78h, 5Ah, 6, 55h, 0F6h, 6
	db	3, 57h, 10h, 74h, 1Fh, 0F7h, 6, 7Ch, 51h, 0, 60h, 75h, 17h, 0A0h, 87h, 51h
	db	50h, 80h, 26h, 87h, 51h, 8Fh, 0A0h, 3, 57h, 8, 6, 87h, 51h, 0E8h, 13h, 17h
	db	58h, 0A2h, 87h, 51h, 0E8h, 0F2h, 1Fh, 5Dh, 7, 89h, 16h, 0ECh, 56h, 0A3h, 0EEh, 56h
	db	0EBh, 0Bh, 0E9h, 0DBh, 41h, 0B9h, 42h, 0, 0E8h, 39h, 4Eh, 0EBh, 36h, 83h, 3Eh, 0B0h
	db	51h, 0, 75h, 73h, 0E8h, 5Eh, 94h, 23h, 0C0h, 75h, 28h, 0F6h, 0C3h, 20h, 74h, 0E5h
	db	0A1h, 0ECh, 56h, 9Ah
	dd	L101E0
	db	8Bh, 0C7h, 0E8h, 0B0h, 2Ah, 75h, 14h, 0E8h, 0CEh, 2Bh, 0F6h, 6, 0C9h, 38h, 1, 74h
	db	0Ah, 0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 0E8h, 0EEh, 50h, 0A1h, 0ECh, 56h, 0E8h, 74h
	db	59h, 80h, 26h, 0BFh, 51h, 0C8h, 0A0h, 4, 57h, 8, 6, 0BFh, 51h, 0A0h, 3, 57h
	db	24h, 30h, 8, 6, 0BFh, 51h, 0A8h, 10h, 74h, 12h, 0F7h, 6, 7Ch, 51h, 0, 60h
	db	75h, 0Ah, 0A1h, 0EEh, 56h, 8Bh, 16h, 0ECh, 56h, 0E8h, 57h, 91h, 0E8h, 0C5h, 41h, 75h
	db	3Dh, 3Bh, 6, 64h, 58h, 74h, 0Eh, 3Bh, 6, 5Eh, 58h, 75h, 2Eh, 0EBh, 29h, 0B9h
	db	49h, 0, 0E9h, 0B7h, 4Dh, 0E8h, 0FCh, 0Dh, 83h, 0C6h, 2, 0F6h, 6, 0BFh, 51h, 10h
	db	75h, 6, 0B9h, 85h, 80h, 0E8h, 0A4h, 4Dh, 0E8h, 9Fh, 0F8h, 74h, 0FBh, 0E8h, 94h, 41h
	db	75h, 16h, 3Bh, 6, 5Eh, 58h, 75h, 10h, 83h, 0C6h, 2, 0E9h, 1Bh, 0F7h, 0F6h, 6
	db	0BFh, 51h, 7, 74h, 3, 0E8h, 0CCh, 0Dh, 0E9h, 31h, 16h, 0E8h, 0CBh, 16h, 75h, 3Ah
	db	83h, 3Eh, 0B0h, 51h, 0, 75h, 0B8h, 0E8h, 6Ah, 41h, 75h, 22h, 83h, 0C6h, 2, 0EBh
	db	0Fh, 0E8h, 0B5h, 16h, 75h, 24h, 0E8h, 8, 1Fh, 83h, 3Eh, 0B0h, 51h, 0, 75h, 14h
	db	3Bh, 16h, 0B2h, 51h, 74h, 8, 0B9h, 39h, 10h, 8Bh, 0FAh, 0E8h, 4Eh, 4Dh, 0E8h, 0A8h
	db	59h, 0E9h, 0F8h, 15h, 0B9h, 49h, 0, 0E9h, 42h, 4Dh, 0E9h, 0DBh, 40h, 0E8h, 89h, 16h
	db	75h, 54h, 0E8h, 2Fh, 41h, 75h, 0Ah, 0E8h, 0ADh, 1Eh, 74h, 5, 83h, 0C6h, 2, 0EBh
	db	11h, 0B9h, 4Ah, 0, 0E8h, 25h, 4Dh, 0E9h, 0D2h, 15h, 0E8h, 6Ch, 16h, 75h, 37h, 0E8h
	db	0BFh, 1Eh, 0F6h, 6, 86h, 51h, 80h, 75h, 1Bh, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0E8h, 2Dh, 2Ch, 75h, 21h, 0E8h, 0C9h, 50h, 0E8h, 3Ch, 2Ch, 0BBh, 49h, 0E8h, 0E8h, 88h
	db	9, 0E9h, 0A8h, 15h, 0F7h, 6, 82h, 51h, 0, 40h, 74h, 0DDh, 0B9h, 7Fh, 80h, 52h
	db	0E8h, 0E9h, 4Ch, 5Ah, 0EBh, 0D3h, 0E9h, 7Fh, 40h, 0E8h, 0D8h, 40h, 75h, 28h, 0E8h, 56h
	db	1Eh, 74h, 24h, 83h, 0C6h, 2, 8Bh, 0DAh, 0E8h, 0E4h, 50h, 6, 55h, 52h, 9Ah
	dd	L101F7
	db	50h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	58h, 0E8h, 61h, 2Dh, 5Ah, 5Dh, 7, 74h, 8, 32h, 0C0h, 0C3h, 32h, 0C0h, 0FEh, 0C8h
	db	0C3h, 0F6h, 6, 0C9h, 38h, 0Bh, 75h, 8, 80h, 0Eh, 0CAh, 38h, 1, 32h, 0C0h, 0C3h
	db	8Bh, 0FAh, 0B9h, 2Bh, 10h, 0E8h, 99h, 4Ch, 32h, 0C0h, 0C3h, 0B9h, 49h, 0, 0E9h, 90h
	db	4Ch, 0F7h, 6, 7Ch, 51h, 0, 60h, 75h, 0Eh, 0E8h, 0FFh, 36h, 75h, 9, 3Bh, 6
	db	2Eh, 58h, 75h, 3, 83h, 0C6h, 2, 0FFh, 26h, 5Ah, 57h, 0E8h, 0C0h, 15h, 75h, 0E1h
	db	83h, 3Eh, 0B0h, 51h, 0, 75h, 0D4h, 0E8h, 47h, 15h, 75h, 0CEh, 0E8h, 7, 1Eh, 3Bh
	db	6, 7Ah, 57h, 74h, 58h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0F7h, 6, 7Ch, 51h, 0, 60h, 75h, 5Fh, 0E8h, 0BAh, 36h, 51h, 0E8h, 0C0h, 36h, 59h
	db	75h, 10h, 3Bh, 6, 2Eh, 58h, 75h, 5, 83h, 0C6h, 2, 0EBh, 63h, 8Bh, 0C1h, 0E8h
	db	94h, 37h, 0F6h, 6, 87h, 51h, 10h, 74h, 3Eh, 0F6h, 6, 86h, 51h, 20h, 74h, 37h
	db	0E8h, 35h, 26h, 75h, 68h, 6, 55h, 0E8h, 45h, 26h, 5Dh, 7, 33h, 0C0h, 0B3h, 28h
	db	0E8h, 0E7h, 1Bh, 0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 0E8h, 0CAh, 4Eh, 0FFh, 26h, 5Ah
	db	57h, 0F7h, 6, 7Ch, 51h, 0, 60h, 75h, 0Ch, 0A1h, 0B6h, 51h, 56h, 0E8h, 88h, 34h
	db	5Eh, 0FFh, 6, 0B6h, 51h, 0EBh, 92h, 9Ah
	dd	L101F7
	db	0E8h, 1Bh, 1Fh, 75h, 0Fh, 0F6h, 6, 86h, 51h, 20h, 75h, 8, 50h, 0E8h, 0EBh, 58h
	db	58h, 0E8h, 1, 58h, 0B3h, 28h, 33h, 0C0h, 0E8h, 67h, 28h, 75h, 14h, 0E8h, 85h, 29h
	db	0B3h, 28h, 33h, 0C0h, 0E8h, 97h, 1Bh, 0A1h, 70h, 51h, 8Bh, 16h, 72h, 51h, 0E8h, 0A5h
	db	4Eh, 0FFh, 26h, 5Ah, 57h, 0E8h, 0FEh, 14h, 75h, 51h, 52h, 0F7h, 6, 7Ch, 51h, 0
	db	10h, 75h, 52h, 0E8h, 13h, 36h, 89h, 0Eh, 0E4h, 56h, 0E8h, 94h, 3Fh, 75h, 46h, 0E8h
	db	12h, 1Dh, 74h, 38h, 3Bh, 6, 60h, 58h, 74h, 32h, 56h, 52h, 83h, 0C6h, 2, 0E8h
	db	7Fh, 3Fh, 58h, 5Eh, 74h, 26h, 0F7h, 6, 7Ch, 51h, 0, 40h, 75h, 5, 0E8h, 0BCh
	db	1Eh, 75h, 22h, 83h, 0C6h, 2, 5Ah, 50h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	58h, 0E8h, 0F0h, 2Dh, 75h, 6, 0E8h, 26h, 4Fh, 0E9h, 0FFh, 2Dh, 0C3h, 0E8h, 0A6h, 0C1h
	db	75h, 4, 59h, 0E9h, 55h, 90h, 5Ah, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0E8h, 55h, 2Eh, 75h, 0E9h, 0E8h, 9, 4Fh, 0F6h, 6, 0C9h, 38h, 2, 75h, 0DFh, 0F7h
	db	6, 7Ch, 51h, 0, 10h, 75h, 6, 0A1h, 0E4h, 56h, 0E8h, 90h, 36h, 0E8h, 74h, 34h
	db	75h, 17h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 12h, 53h, 51h, 0E8h, 97h, 35h, 59h
	db	5Bh, 75h, 9, 0A1h, 0E4h, 56h, 0E8h, 74h, 36h, 0E8h, 0EBh, 33h, 0E8h, 7Fh, 4Fh, 0E9h
	db	46h, 2Eh, 0E8h, 54h, 14h, 75h, 1Ah, 52h, 0E8h, 87h, 0C1h, 58h, 74h, 0Bh, 0B9h, 2
	db	0, 0E8h, 0F8h, 4Ah, 50h, 0E8h, 64h, 6Fh, 58h, 8Bh, 0C8h, 0E8h, 0C6h, 8Fh, 0E9h, 9Bh
	db	13h, 0E9h, 84h, 3Eh, 0E8h, 32h, 14h, 75h, 20h, 0E8h, 85h, 1Ch, 89h, 16h, 0DEh, 56h
	db	0E8h, 21h, 34h, 75h, 0Eh, 8Bh, 0C1h, 33h, 0D2h, 8Bh, 0Eh, 0DEh, 56h, 0E8h, 93h, 8Fh
	db	0E9h, 79h, 13h, 0B9h, 7Ah, 0, 0E9h, 0C3h, 4Ah, 0E8h, 8, 34h, 0E9h, 59h, 3Eh, 0E8h
	db	7, 14h, 75h, 39h, 89h, 16h, 0DEh, 56h, 0F6h, 6, 0C9h, 38h, 2, 75h, 3Bh, 0C7h
	db	6, 2Eh, 57h, 0, 0, 0E8h, 0ECh, 33h, 75h, 24h, 8Bh, 0FBh, 16h, 7, 8Bh, 1Eh
	db	2Eh, 57h, 0E8h, 0Bh, 63h, 89h, 1Eh, 2Ch, 57h, 89h, 0Eh, 2Eh, 57h, 0E8h, 84h, 3Eh
	db	75h, 18h, 3Bh, 6, 5Eh, 58h, 75h, 12h, 83h, 0C6h, 2, 0EBh, 0D8h, 0C3h, 0B9h, 7Ah
	db	0, 0E8h, 78h, 4Ah, 0C7h, 6, 2Eh, 57h, 0, 0, 0A1h, 0DEh, 56h, 9Ah
	dd	L101E0
	db	0E8h, 73h, 2Dh, 75h, 0E6h, 0E8h, 27h, 4Eh, 0F6h, 6, 0C9h, 38h, 2, 75h, 0DCh, 8Bh
	db	1Eh, 2Ch, 57h, 8Bh, 0Eh, 2Eh, 57h, 0E8h, 0C2h, 4Eh, 0E9h, 89h, 2Dh, 0E8h, 97h, 13h
	db	75h, 0C9h, 89h, 16h, 0DEh, 56h, 0F6h, 6, 0C9h, 38h, 2, 75h, 65h, 0E8h, 82h, 33h
	db	75h, 54h, 89h, 1Eh, 2Ah, 57h, 0C7h, 6, 2Ch, 57h, 0, 0, 89h, 0Eh, 2Eh, 57h
	db	0E8h, 1Fh, 3Eh, 75h, 4Dh, 3Bh, 6, 5Eh, 58h, 75h, 47h, 83h, 0C6h, 2, 0E8h, 2Ch
	db	6, 23h, 0C9h, 75h, 7, 48h, 3Bh, 6, 2Eh, 57h, 72h, 3, 0A1h, 2Eh, 57h, 0A3h
	db	2Ch, 57h, 29h, 6, 2Eh, 57h, 0E8h, 0F9h, 3Dh, 75h, 27h, 3Bh, 6, 5Eh, 58h, 75h
	db	21h, 83h, 0C6h, 2, 0E8h, 0F5h, 5, 23h, 0C9h, 75h, 17h, 3Bh, 6, 2Eh, 57h, 73h
	db	11h, 0A3h, 2Eh, 57h, 0EBh, 0Ch, 0B9h, 7Ah, 0, 0E8h, 0DEh, 49h, 0C7h, 6, 2Eh, 57h
	db	0, 0, 0A1h, 0DEh, 56h, 9Ah
	dd	L101E0
	db	0E8h, 0D9h, 2Ch, 75h, 1Ch, 0E8h, 8Dh, 4Dh, 0F6h, 6, 0C9h, 38h, 2, 75h, 12h, 8Bh
	db	1Eh, 2Ah, 57h, 3, 1Eh, 2Ch, 57h, 8Bh, 0Eh, 2Eh, 57h, 0E8h, 24h, 4Eh, 0E9h, 0EBh
	db	2Ch, 0C3h, 0E8h, 0F8h, 12h, 75h, 0FAh, 0E8h, 4Bh, 1Bh, 89h, 16h, 0DEh, 56h, 0C7h, 6
	db	2Ch, 57h, 0, 0, 0E8h, 0E1h, 32h, 74h, 1Dh, 0E8h, 0A7h, 5, 48h, 0A3h, 2Ch, 57h
	db	0E8h, 85h, 3Dh, 75h, 0Eh, 3Bh, 6, 5Eh, 58h, 75h, 8, 83h, 0C6h, 2, 0E8h, 0C7h
	db	32h, 74h, 3, 0E9h, 0B1h, 0FEh, 8Ch, 0D0h, 8Eh, 0C0h, 8Bh, 0FBh, 33h, 0DBh, 0E8h, 0E3h
	db	61h, 89h, 1Eh, 2Ah, 57h, 39h, 0Eh, 2Ch, 57h, 72h, 4, 89h, 0Eh, 2Ch, 57h, 2Bh
	db	0Eh, 2Ch, 57h, 41h, 89h, 0Eh, 2Eh, 57h, 1, 1Eh, 2Ch, 57h, 0E8h, 49h, 3Dh, 75h
	db	0D2h, 3Bh, 6, 5Eh, 58h, 75h, 0CCh, 83h, 0C6h, 2, 0E8h, 8Bh, 32h, 75h, 0C4h, 56h
	db	0E3h, 2Fh, 29h, 0Eh, 2Eh, 57h, 72h, 29h, 51h, 8Bh, 0F3h, 8Bh, 0Eh, 2Eh, 57h, 0ACh
	db	8Bh, 3Eh, 2Ch, 57h, 0F2h, 0AEh, 89h, 0Eh, 2Eh, 57h, 89h, 3Eh, 2Ch, 57h, 59h, 75h
	db	10h, 51h, 49h, 0F3h, 0A6h, 59h, 75h, 0E0h, 0A1h, 2Ch, 57h, 2Bh, 6, 2Ah, 57h, 0EBh
	db	2, 33h, 0C0h, 5Eh, 33h, 0D2h, 8Bh, 0Eh, 0DEh, 56h, 0E8h, 0CAh, 8Dh, 0E9h, 0B0h, 11h
	db	0E8h, 4Ah, 12h, 75h, 18h, 0E8h, 0F0h, 3Ch, 75h, 0Ah, 0E8h, 6Eh, 1Ah, 74h, 5, 83h
	db	0C6h, 2, 0EBh, 14h, 0B9h, 4Ah, 0, 0E8h, 0E6h, 48h, 0E9h, 93h, 11h, 0E9h, 7Ch, 3Ch
	db	0E8h, 2Ah, 12h, 75h, 0F8h, 0E8h, 7Dh, 1Ah, 83h, 3Eh, 0B0h, 51h, 0, 75h, 50h, 52h
	db	0E8h, 46h, 0C0h, 58h, 74h, 0Bh, 0B9h, 7, 0, 0E8h, 0C4h, 48h, 50h, 0E8h, 82h, 6Dh
	db	58h, 50h, 0E8h, 0ECh, 8Eh, 5Ah, 50h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	58h, 23h, 0C0h, 75h, 20h, 0F6h, 0C3h, 20h, 74h, 1Eh, 8Bh, 0C7h, 0E8h, 3Ch, 25h, 75h
	db	14h, 50h, 53h, 0E8h, 58h, 26h, 5Bh, 58h, 0E8h, 6Ch, 18h, 0A1h, 70h, 51h, 8Bh, 16h
	db	72h, 51h, 0E8h, 7Ah, 4Bh, 0E9h, 3Ah, 11h, 0B9h, 42h, 0, 0E8h, 84h, 48h, 0E9h, 31h
	db	11h, 0B9h, 49h, 0, 0E9h, 7Bh, 48h, 0E8h, 0C5h, 11h, 75h, 18h, 0E8h, 6Bh, 3Ch, 75h
	db	0Ah, 0E8h, 0E9h, 19h, 74h, 5, 83h, 0C6h, 2, 0EBh, 26h, 0B9h, 4Ah, 0, 0E8h, 61h
	db	48h, 0E9h, 0Eh, 11h, 0E9h, 0F7h, 3Bh, 0F7h, 6, 82h, 51h, 0, 40h, 74h, 19h, 0B9h
	db	7Fh, 80h, 52h, 0E8h, 4Ch, 48h, 5Ah, 0EBh, 0Fh, 0E8h, 93h, 11h, 75h, 0E6h, 0E8h, 0E6h
	db	19h, 0F6h, 6, 86h, 51h, 80h, 75h, 0DFh, 83h, 3Eh, 0B0h, 51h, 0, 74h, 6, 0B9h
	db	49h, 0, 0E9h, 2Dh, 48h, 89h, 16h, 0DEh, 56h, 8Bh, 0C2h, 0E8h, 0A7h, 1Ah, 75h, 1Ch
	db	8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0E8h, 90h, 29h, 0C6h, 6, 12h, 57h, 0FFh, 89h, 3Eh, 0Eh, 57h, 88h, 0Eh, 13h, 57h
	db	0A3h, 10h, 57h, 0EBh, 28h, 33h, 0C0h, 0A2h, 12h, 57h, 0A3h, 0Eh, 57h, 0C6h, 6, 13h
	db	57h, 60h, 0C7h, 6, 10h, 57h, 0, 0, 0F7h, 6, 7Ch, 51h, 8, 0, 74h, 0Dh
	db	0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 5, 80h, 0Eh, 13h, 57h, 1, 0E8h, 55h, 32h
	db	75h, 6Ah, 0E8h, 65h, 19h, 75h, 3Bh, 83h, 0C6h, 2, 9Ah
	dd	L101E0
	db	0E8h, 6Eh, 17h, 32h, 0E4h, 0E8h, 0, 60h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 0Fh
	db	3, 0D9h, 0E3h, 19h, 80h, 7Fh, 0FFh, 20h, 77h, 3, 4Bh, 0E2h, 0F7h, 2Bh, 0D9h, 0E3h
	db	0Ch, 0E8h, 71h, 16h, 0E8h, 4Ah, 19h, 89h, 16h, 0Eh, 57h, 0EBh, 0C1h, 89h, 0Eh, 0Eh
	db	57h, 0EBh, 0BBh, 16h, 7, 0BFh, 0ACh, 57h, 0B9h, 13h, 0, 0F2h, 0AFh, 75h, 11h, 41h
	db	0BBh, 13h, 0, 2Bh, 0D9h, 83h, 0C6h, 2, 0D1h, 0E3h, 0FFh, 97h, 22h, 20h, 0EBh, 9Eh
	db	0B9h, 2Fh, 10h, 8Bh, 0F8h, 0E8h, 74h, 47h, 83h, 0C6h, 2, 0EBh, 91h, 0E8h, 0F9h, 0
	db	0E9h, 0BCh, 3, 0B0h, 20h, 0EBh, 12h, 0B0h, 40h, 0EBh, 0Eh, 0B0h, 0A0h, 0EBh, 0Ah, 0B0h
	db	60h, 0EBh, 6, 0B0h, 80h, 0EBh, 2, 0B0h, 0C0h, 0F6h, 6, 13h, 57h, 0E0h, 75h, 6
	db	0C7h, 6, 10h, 57h, 0, 0, 80h, 26h, 13h, 57h, 1Fh, 8, 6, 13h, 57h, 0C3h
	db	80h, 26h, 13h, 57h, 0E3h, 0C3h, 80h, 26h, 13h, 57h, 0E3h, 80h, 0Eh, 13h, 57h, 4
	db	0C3h, 80h, 26h, 13h, 57h, 0E3h, 80h, 0Eh, 13h, 57h, 8, 0C3h, 80h, 26h, 13h, 57h
	db	0E3h, 80h, 0Eh, 13h, 57h, 14h, 0C3h, 80h, 26h, 13h, 57h, 0E3h, 80h, 0Eh, 13h, 57h
	db	18h, 0C3h, 80h, 26h, 13h, 57h, 3, 0E8h, 4, 3, 23h, 0C9h, 75h, 0Dh, 0F6h, 6
	db	13h, 57h, 2, 75h, 3, 0A3h, 10h, 57h, 32h, 0C0h, 0C3h, 0B9h, 87h, 0, 0E8h, 0EBh
	db	46h, 0EBh, 0F5h, 0C6h, 6, 12h, 57h, 0FFh, 80h, 26h, 13h, 57h, 0FEh, 0C3h, 0F7h, 6
	db	7Ch, 51h, 8, 0, 74h, 22h, 0C6h, 6, 12h, 57h, 0FFh, 80h, 0Eh, 13h, 57h, 1
	db	0F6h, 6, 13h, 57h, 0E0h, 75h, 0Bh, 80h, 0Eh, 13h, 57h, 60h, 0C7h, 6, 10h, 57h
	db	0, 0, 83h, 0Eh, 10h, 57h, 4, 0C3h, 0B9h, 7Eh, 0, 0E9h, 0AEh, 46h, 0A1h, 7Eh
	db	51h, 0A3h, 10h, 57h, 80h, 0Eh, 13h, 57h, 2, 0C3h, 0B0h, 0, 0EBh, 0Ah, 0B0h, 1
	db	0EBh, 6, 0B0h, 2, 0EBh, 2, 0B0h, 3, 0F6h, 6, 13h, 57h, 0E0h, 75h, 0Bh, 80h
	db	0Eh, 13h, 57h, 60h, 0C7h, 6, 10h, 57h, 0, 0, 32h, 0E4h, 83h, 26h, 10h, 57h
	db	0FCh, 0Dh, 4, 0, 9, 6, 10h, 57h, 0C3h, 0F7h, 6, 7Ch, 51h, 8, 0, 74h
	db	1Dh, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 15h, 80h, 3Eh, 12h, 57h, 0, 75h, 0Eh
	db	0F7h, 6, 82h, 51h, 40h, 0, 74h, 6, 0B9h, 73h, 80h, 0E8h, 4Eh, 46h, 0A1h, 0DEh
	db	56h, 9Ah
	dd	L101E0
	db	0E8h, 0A9h, 25h, 75h, 1Bh, 0A1h, 0Eh, 57h, 0E8h, 0, 4Ah, 8Ah, 1Eh, 13h, 57h, 8Ah
	db	3Eh, 12h, 57h, 8Bh, 3Eh, 10h, 57h, 0E8h, 0AEh, 25h, 0A1h, 0DEh, 56h, 0E9h, 6Ah, 54h
	db	0C3h, 0E8h, 6Fh, 0Fh, 75h, 4Dh, 0E8h, 15h, 3Ah, 75h, 5, 83h, 0C6h, 2, 0EBh, 11h
	db	83h, 3Eh, 0B0h, 51h, 0, 74h, 1Fh, 0EBh, 34h, 0E8h, 57h, 0Fh, 75h, 35h, 0E8h, 0AAh
	db	17h, 83h, 3Eh, 0B0h, 51h, 0, 75h, 17h, 3Bh, 16h, 7Eh, 51h, 74h, 8, 0B9h, 2Eh
	db	90h, 8Bh, 0FAh, 0E8h, 0F0h, 45h, 0E8h, 91h, 54h, 0E8h, 3Dh, 2, 0E9h, 97h, 0Eh, 3Bh
	db	16h, 0B0h, 51h, 74h, 8, 0B9h, 2Eh, 90h, 8Bh, 0FAh, 0E8h, 0D9h, 45h, 0E8h, 9Dh, 4Dh
	db	0E9h, 83h, 0Eh, 0E9h, 6Ch, 39h, 0E8h, 1Ah, 0Fh, 75h, 20h, 0E8h, 0C0h, 39h, 75h, 5Dh
	db	0E8h, 3Eh, 17h, 74h, 58h, 8Bh, 0D0h, 83h, 0C6h, 2, 0F7h, 6, 7Ch, 51h, 0, 10h
	db	75h, 11h, 0B9h, 6Fh, 0, 0E8h, 0AEh, 45h, 0E9h, 5Bh, 0Eh, 0E9h, 44h, 39h, 0E8h, 0F2h
	db	0Eh, 75h, 0F8h, 0E8h, 45h, 17h, 52h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0E8h, 14h, 1Ch, 75h, 28h, 0E8h, 55h, 49h, 0E8h, 4Eh, 1Ch, 89h, 2Eh, 0E0h, 56h, 8Ch
	db	6, 0E2h, 56h, 0C7h, 6, 1Eh, 57h, 0, 0, 6, 55h, 0BBh, 0CCh, 0EFh, 0E8h, 4
	db	2, 5Dh, 7, 0A1h, 1Eh, 57h, 5Ah, 0E8h, 38h, 1Ch, 0E9h, 1Bh, 0Eh, 5Ah, 0C3h, 0B9h
	db	4Ah, 0, 0E8h, 63h, 45h, 0E9h, 10h, 0Eh, 0E8h, 55h, 39h, 75h, 27h, 8Bh, 0C2h, 0E8h
	db	0D1h, 16h, 74h, 1Ch, 83h, 0C6h, 2, 0A3h, 20h, 57h, 0A1h, 1Eh, 57h, 0A3h, 22h, 57h
	db	0E8h, 3Dh, 39h, 75h, 10h, 3Bh, 6, 2Eh, 58h, 75h, 0Ah, 83h, 0C6h, 2, 0EBh, 0Bh
	db	32h, 0C0h, 0FEh, 0C8h, 0C3h, 0B9h, 0Bh, 0, 0E8h, 2Dh, 45h, 0E8h, 2Ch, 1, 23h, 0C9h
	db	75h, 16h, 8Bh, 0Eh, 1Eh, 57h, 3, 0C8h, 72h, 0Eh, 83h, 0F9h, 21h, 73h, 9, 89h
	db	0Eh, 1Eh, 57h, 0A3h, 24h, 57h, 0EBh, 10h, 0C7h, 6, 24h, 57h, 0, 0, 8Bh, 3Eh
	db	20h, 57h, 0B9h, 57h, 10h, 0E8h, 0, 45h, 33h, 0C0h, 0A3h, 26h, 57h, 0A3h, 28h, 57h
	db	0E8h, 0EDh, 38h, 75h, 13h, 3Bh, 6, 30h, 58h, 75h, 0Dh, 83h, 0C6h, 2, 0E8h, 0E9h
	db	0, 0A3h, 26h, 57h, 89h, 0Eh, 28h, 57h, 0A1h, 20h, 57h, 9Ah
	dd	L101E0
	db	0E8h, 0DFh, 1Ah, 75h, 38h, 0E8h, 95h, 48h, 8Ah, 16h, 22h, 57h, 8Ah, 36h, 24h, 57h
	db	8Bh, 3Eh, 0E0h, 56h, 0A1h, 0E2h, 56h, 6, 55h, 8Bh, 0EFh, 8Eh, 0C0h, 9Ah
	dd	L101F7
	db	5Dh, 7, 0E8h, 0D2h, 1Ah, 0C4h, 2Eh, 0E0h, 56h, 8Bh, 0Eh, 26h, 57h, 8Bh, 3Eh, 28h
	db	57h, 0A1h, 20h, 57h, 8Ah, 1Eh, 24h, 57h, 0E8h, 0Dh, 1Dh, 32h, 0C0h, 0C3h, 32h, 0C0h
	db	0EBh, 2, 0B0h, 1, 0A2h, 0Ch, 57h, 0E8h, 0D9h, 0Dh, 75h, 6Fh, 0E8h, 2Ch, 16h, 0EBh
	db	2Ch, 32h, 0C0h, 0EBh, 2, 0B0h, 1, 0A2h, 0Ch, 57h, 0E8h, 0C6h, 0Dh, 75h, 5Ch, 0E8h
	db	6Ch, 38h, 75h, 5Ah, 0E8h, 0EAh, 15h, 74h, 55h, 83h, 0C6h, 2, 0F7h, 6, 7Ch, 51h
	db	0, 10h, 75h, 9, 0B9h, 6Fh, 0, 0E8h, 5Ch, 44h, 0E9h, 9, 0Dh, 83h, 3Eh, 0B0h
	db	51h, 0, 74h, 8, 0B9h, 49h, 0, 0E8h, 4Ch, 44h, 0EBh, 42h, 52h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0E8h, 27h, 1Ch, 58h, 75h, 21h, 0A3h, 0B0h, 51h, 0E8h, 0FBh, 47h, 0E8h, 5Dh, 1Ch, 8Ah
	db	1Eh, 0Ch, 57h, 0E8h, 83h, 4Bh, 33h, 0C0h, 0A3h, 70h, 51h, 0A3h, 72h, 51h, 0A3h, 0A6h
	db	51h, 0A3h, 0A8h, 51h, 0E9h, 0CBh, 0Ch, 0E9h, 0B4h, 37h, 83h, 3Eh, 0B0h, 51h, 0, 75h
	db	9, 0B9h, 4Ah, 0, 0E8h, 0Bh, 44h, 0E9h, 0B8h, 0Ch, 8Ah, 1Eh, 0Ch, 57h, 0E8h, 44h
	db	4Bh, 0E9h, 0AEh, 0Ch, 0E8h, 91h, 0BAh, 74h, 9, 0B9h, 2, 0, 0E8h, 0F3h, 43h, 0E8h
	db	60h, 68h, 0E9h, 0BBh, 89h, 0E8h, 80h, 0BAh, 74h, 9, 0B9h, 2, 0, 0E8h, 0E2h, 43h
	db	0E8h, 4Fh, 68h, 0E9h, 0F0h, 89h, 0E8h, 0D1h, 37h, 75h, 1Dh, 83h, 0C6h, 2, 8Ch, 0D1h
	db	8Eh, 0C1h, 0BFh, 0F2h, 57h, 0B9h, 10h, 0, 0F2h, 0AFh, 75h, 10h, 0BBh, 0Fh, 0, 2Bh
	db	0D9h, 0D1h, 0E3h, 8Bh, 87h, 2, 20h, 0C3h, 0B8h, 0FFh, 0FFh, 0C3h, 0B9h, 72h, 0, 0E8h
	db	0B0h, 43h, 33h, 0C0h, 0C3h, 0A1h, 7Eh, 51h, 23h, 0C0h, 74h, 32h, 0C6h, 6, 0EAh, 56h
	db	32h, 0E8h, 12h, 16h, 74h, 5, 0C6h, 6, 0EAh, 56h, 34h, 50h, 0A1h, 8Ch, 57h, 9Ah
	dd	L101E0
	db	58h, 0E8h, 17h, 9, 0BBh, 0EAh, 56h, 0B9h, 1, 0, 0E8h, 54h, 12h, 50h, 0A1h, 88h
	db	57h, 9Ah
	dd	L101E0
	db	58h, 0E9h, 1, 9, 0C3h, 89h, 1Eh, 0E6h, 56h, 0FFh, 16h, 0E6h, 56h, 74h, 0Eh, 0F7h
	db	6, 7Ch, 51h, 0, 10h, 74h, 16h, 0B9h, 10h, 0, 0E9h, 5Bh, 43h, 0E8h, 50h, 37h
	db	75h, 0Bh, 3Bh, 6, 5Eh, 58h, 75h, 5, 83h, 0C6h, 2, 0EBh, 0DCh, 0C3h, 0BFh, 24h
	db	29h, 0A0h, 0C0h, 51h, 0A2h, 4, 57h, 0FFh, 0D7h, 75h, 1Ch, 1Eh, 7, 0B9h, 4, 0
	db	0BFh, 1Eh, 58h, 0F2h, 0AFh, 75h, 10h, 0F7h, 0D9h, 81h, 0C1h, 4, 0, 49h, 88h, 0Eh
	db	4, 57h, 83h, 0C6h, 2, 32h, 0C0h, 0C3h, 0BFh, 24h, 29h, 0A0h, 87h, 51h, 24h, 70h
	db	0A2h, 3, 57h, 0FFh, 0D7h, 75h, 27h, 1Eh, 7, 0B9h, 6, 0, 0BFh, 12h, 58h, 0F2h
	db	0AFh, 75h, 1Bh, 0F7h, 0D9h, 81h, 0C1h, 6, 0, 49h, 8Bh, 0D9h, 8Ah, 87h, 6Ch, 20h
	db	80h, 26h, 3, 57h, 8Fh, 8, 6, 3, 57h, 83h, 0C6h, 2, 32h, 0C0h, 0C3h, 56h
	db	0BFh, 0ABh, 1Fh, 0E8h, 52h, 2Dh, 51h, 57h, 0E8h, 96h, 0FFh, 5Fh, 59h, 75h, 3, 0E8h
	db	46h, 2Dh, 51h, 57h, 0E8h, 0B4h, 0FFh, 5Fh, 59h, 75h, 3, 0E8h, 3Ah, 2Dh, 51h, 0FFh
	db	0D7h, 59h, 5Fh, 75h, 2Ch, 0E8h, 3Bh, 14h, 74h, 27h, 8Ah, 1Eh, 87h, 51h, 53h, 8Ah
	db	1Eh, 3, 57h, 80h, 26h, 87h, 51h, 8Fh, 8, 1Eh, 87h, 51h, 0E8h, 44h, 2Dh, 5Bh
	db	88h, 1Eh, 87h, 51h, 83h, 0C6h, 2, 0A3h, 0EEh, 56h, 89h, 16h, 0ECh, 56h, 32h, 0C0h
	db	0C3h, 8Bh, 0F7h, 0E8h, 0Ch, 2Dh, 0E8h, 0Ah, 14h, 75h, 0E9h, 32h, 0C0h, 0FEh, 0C8h, 0C3h
	db	0C6h, 6, 0CAh, 38h, 0, 8Bh, 3Eh, 0F0h, 56h, 0B9h, 2Dh, 10h, 0E8h, 79h, 42h, 32h
	db	0C0h, 0C3h, 0E8h, 0C4h, 0, 75h, 32h, 8Ah, 1Eh, 2, 57h, 8Bh, 0Eh, 0F2h, 56h, 80h
	db	0E3h, 0Fh, 80h, 3Eh, 0, 57h, 0, 75h, 9, 80h, 0FBh, 1, 75h, 4, 0FEh, 6
	db	0F8h, 56h, 0E8h, 0BBh, 0Dh, 8Bh, 0CAh, 8Bh, 0D8h, 0A1h, 0F8h, 56h, 8Bh, 3Eh, 0FAh, 56h
	db	56h, 8Bh, 0F0h, 0E8h, 0BDh, 5Bh, 5Eh, 32h, 0C0h, 0C3h, 0E8h, 26h, 0, 8Bh, 0Eh, 8
	db	57h, 8Bh, 16h, 0Ah, 57h, 51h, 52h, 0A1h, 0ECh, 56h, 50h, 9Ah
	dd	L101E0
	db	8Bh, 0C1h, 0E8h, 91h, 45h, 59h, 5Ah, 58h, 8Ah, 1Eh, 2, 57h, 8Bh, 3Eh, 0F2h, 56h
	db	0E9h, 7Dh, 86h, 8Ah, 1Eh, 0F5h, 56h, 32h, 0FFh, 0D1h, 0E3h, 0FFh, 97h, 0F8h, 1Fh, 0A1h
	db	0F8h, 56h, 8Bh, 16h, 0FAh, 56h, 3Dh, 1, 0, 75h, 5, 23h, 0D2h, 75h, 1, 0C3h
	db	50h, 53h, 52h, 8Ah, 1Eh, 2, 57h, 8Bh, 0Eh, 0F2h, 56h, 80h, 0E3h, 0Fh, 0E8h, 4Fh
	db	0Dh, 59h, 5Bh, 5Dh, 0E9h, 0Ch, 46h, 8Ah, 1Eh, 2, 57h, 0A1h, 0F2h, 56h, 0E9h, 0ACh
	db	11h, 8Ah, 1Eh, 0F4h, 56h, 0A1h, 0F6h, 56h, 0E9h, 5, 12h, 8Ah, 1Eh, 0F4h, 56h, 0A1h
	db	0F6h, 56h, 0E9h, 42h, 12h, 8Ah, 1Eh, 0F4h, 56h, 0A1h, 0F6h, 56h, 0E9h, 7Fh, 12h, 8Ah
	db	1Eh, 0F4h, 56h, 0A1h, 0F6h, 56h, 0E9h, 0BCh, 12h, 0E8h, 26h, 2Ch, 75h, 3Fh, 0E8h, 22h
	db	13h, 74h, 0Ch, 83h, 0C6h, 2, 0A3h, 0EEh, 56h, 89h, 16h, 0ECh, 56h, 0EBh, 0Ah, 32h
	db	0C0h, 0FEh, 0C8h, 0C3h, 0E8h, 0A8h, 0FEh, 75h, 24h, 0E8h, 5Eh, 0, 75h, 1Fh, 8Bh, 0Eh
	db	0FCh, 56h, 8Bh, 3Eh, 0FEh, 56h, 0A1h, 0F8h, 56h, 8Bh, 16h, 0FAh, 56h, 0E8h, 0DFh, 5Ah
	db	8Bh, 7, 0A3h, 0F8h, 56h, 8Bh, 47h, 2, 0A3h, 0FAh, 56h, 32h, 0C0h, 0C3h, 32h, 0C0h
	db	0A2h, 1, 57h, 0E8h, 79h, 0FEh, 75h, 0F5h, 0A1h, 0EEh, 56h, 3Bh, 6, 7Eh, 58h, 74h
	db	18h, 0C6h, 6, 1, 57h, 8, 3Bh, 6, 80h, 58h, 74h, 0Dh, 8Ah, 1Eh, 87h, 51h
	db	80h, 0E3h, 8, 88h, 1Eh, 1, 57h, 0EBh, 11h, 0E8h, 53h, 0FEh, 74h, 0Ch, 0B9h, 0Eh
	db	0, 0E8h, 34h, 41h, 0C7h, 6, 0ECh, 56h, 0, 0, 0B8h, 1, 0, 0A3h, 0F8h, 56h
	db	0A3h, 0FCh, 56h, 33h, 0C0h, 0A3h, 0FAh, 56h, 0A3h, 0FEh, 56h, 0A2h, 0F5h, 56h, 0A2h, 0
	db	57h, 0E8h, 0Ch, 35h, 75h, 4Ch, 3Bh, 6, 0C0h, 58h, 75h, 3Bh, 83h, 0C6h, 2, 0E8h
	db	9Ch, 0B7h, 74h, 9, 0B9h, 2, 0, 0E8h, 0FEh, 40h, 0E8h, 6Bh, 65h, 0E8h, 0C6h, 86h
	db	0C6h, 6, 0, 57h, 0FFh, 0A3h, 0FCh, 56h, 89h, 0Eh, 0FEh, 56h, 0E8h, 0E1h, 34h, 75h
	db	6, 3Bh, 6, 56h, 58h, 74h, 8, 0B9h, 9, 0, 0E8h, 0DBh, 40h, 0EBh, 8, 83h
	db	0C6h, 2, 0E8h, 0CBh, 34h, 75h, 0Bh, 3Bh, 6, 2Eh, 58h, 75h, 5, 83h, 0C6h, 2
	db	0EBh, 15h, 0F7h, 6, 7Ch, 51h, 0, 10h, 75h, 7, 0E8h, 0EBh, 0, 33h, 0C0h, 0EBh
	db	34h, 0B9h, 0Bh, 0, 0E8h, 0B1h, 40h, 0E8h, 2Eh, 0, 0E8h, 0A3h, 34h, 75h, 26h, 3Bh
	db	6, 2Eh, 58h, 75h, 20h, 83h, 0C6h, 2, 0E8h, 33h, 0B7h, 74h, 9, 0B9h, 2, 0
	db	0E8h, 95h, 40h, 0E8h, 2, 65h, 0E8h, 5Dh, 86h, 0A3h, 0F8h, 56h, 89h, 0Eh, 0FAh, 56h
	db	0C6h, 6, 0, 57h, 0FFh, 32h, 0C0h, 0C3h, 0E8h, 75h, 34h, 75h, 59h, 3Bh, 6, 7Eh
	db	58h, 74h, 26h, 3Bh, 6, 80h, 58h, 74h, 24h, 3Bh, 6, 62h, 58h, 74h, 38h, 3Bh
	db	6, 6Ah, 58h, 74h, 49h, 0E8h, 0D9h, 0B7h, 75h, 3Ch, 0E8h, 8Ch, 86h, 88h, 1Eh, 2
	db	57h, 0A3h, 0F0h, 56h, 89h, 3Eh, 0F2h, 56h, 0C3h, 32h, 0C0h, 0EBh, 2, 0B0h, 8, 50h
	db	83h, 0C6h, 2, 0E8h, 3Ah, 34h, 75h, 9, 3Bh, 6, 6Ah, 58h, 75h, 3, 58h, 0EBh
	db	22h, 58h, 83h, 0EEh, 2, 0EBh, 0CEh, 83h, 0C6h, 2, 33h, 0C0h, 0A2h, 2, 57h, 0A3h
	db	0F0h, 56h, 0A3h, 0F2h, 56h, 0C3h, 0B9h, 7, 0, 0E8h, 1Ch, 40h, 0EBh, 4Ah, 0A0h, 87h
	db	51h, 24h, 8, 83h, 0C6h, 2, 0F7h, 6, 7Ch, 51h, 8, 0, 75h, 0Ch, 0BBh, 22h
	db	1, 22h, 0C0h, 74h, 0Fh, 0BBh, 23h, 2, 0EBh, 0Ah, 0BBh, 23h, 3, 22h, 0C0h, 74h
	db	3, 0BBh, 29h, 4, 88h, 1Eh, 2, 57h, 88h, 3Eh, 0F5h, 56h, 33h, 0C0h, 0A3h, 0F0h
	db	56h, 0A3h, 0F2h, 56h, 0E8h, 5Ah, 0B7h, 75h, 0BCh, 0E8h, 0Dh, 86h, 88h, 1Eh, 0F4h, 56h
	db	89h, 3Eh, 0F6h, 56h, 0A3h, 0F0h, 56h, 0C3h, 0B0h, 22h, 0F7h, 6, 7Ch, 51h, 8, 0
	db	74h, 2, 0B0h, 23h, 0A2h, 2, 57h, 33h, 0C0h, 0A3h, 0F0h, 56h, 0A3h, 0F2h, 56h, 0C3h
	db	0F6h, 6, 0BFh, 51h, 10h, 74h, 24h, 0F6h, 6, 86h, 51h, 20h, 74h, 1Dh, 0A1h, 9Ch
	db	51h, 0Bh, 6, 9Eh, 51h, 0Bh, 6, 0A0h, 51h, 0Bh, 6, 0A2h, 51h, 75h, 0Ch, 80h
	db	3Eh, 0BAh, 51h, 0, 75h, 5, 80h, 0Eh, 0BFh, 51h, 80h, 0C3h
L0F5A0:	mov	word ptr ds:[58D0h], ax	;@0F5A0
	mov	byte ptr ds:[58DCh], dh	;@0F5A3
	mov	byte ptr ds:[38C9h], 0	;@0F5A7
	mov	word ptr ds:[58CCh], bx	;@0F5AC
	xor	ax, ax	;@0F5B0
	mov	byte ptr ds:[58DDh], al	;@0F5B2
	mov	byte ptr ds:[58DEh], al	;@0F5B5
	mov	byte ptr ds:[38C8h], al	;@0F5B8
	mov	byte ptr ds:[38C9h], al	;@0F5BB
	mov	byte ptr ds:[38CBh], al	;@0F5BE
	mov	byte ptr ds:[38CCh], al	;@0F5C1
	mov	word ptr ds:[5750h], di	;@0F5C4
	mov	byte ptr ds:[38CDh], al	;@0F5C8
	mov	byte ptr ds:[38CEh], al	;@0F5CB
	call	far ptr L11A0A	;@0F5CE
	call	far ptr L11B14	;@0F5D3
	call	far ptr L1181D	;@0F5D8
	call	L0469C	;@0F5DD
	call	L01DB6	;@0F5E0
	call	L03674	;@0F5E3
	call	far ptr L12B86	;@0F5E6
	call	far ptr L10394	;@0F5EB
	call	far ptr L12611	;@0F5F0
	call	L04BB4	;@0F5F5
	call	L056A6	;@0F5F8
	mov	ax, word ptr ds:[58CCh]	;@0F5FB
	call	far ptr L11872	;@0F5FE
	mov	bx, 2566h	;@0F603
	mov	cx, 212h	;@0F606
	call	L00457	;@0F609
	mov	word ptr ds:[5754h], ax	;@0F60C
	add	ax, 22h	;@0F60F
	mov	word ptr ds:[5752h], ax	;@0F612
	call	L056AC	;@0F615
	mov	di, 5764h	;@0F618
	mov	bx, 3196h	;@0F61B
	mov	cx, 61h	;@0F61E
	xor	al, al	;@0F621
	call	L00490	;@0F623
	mov	di, 5826h	;@0F626
	mov	bx, 33C7h	;@0F629
	mov	cx, 53h	;@0F62C
	mov	al, 0FFh	;@0F62F
	call	L00490	;@0F631
	ret	;@0F634
L0F635:	call	L04BCE	;@0F635
	call	far ptr L11861	;@0F638
	call	far ptr L11D30	;@0F63D
	ret	;@0F642
L0F643:	stc	;@0F643
	retf	;@0F644
L0F645:	push	ax	;@0F645
	push	cx	;@0F646
	push	si	;@0F647
	push	di	;@0F648
	push	bp	;@0F649
	call	far ptr L11CEB	;@0F64A
	jae	@@1	;@0F64F
	call	far ptr L11D17	;@0F651
	jae	@@1	;@0F656
	call	far ptr L118C2	;@0F658
	jae	@@1	;@0F65D
	call	L046B2	;@0F65F
	jae	@@1	;@0F662
	call	L05737	;@0F664
	jae	@@1	;@0F667
	call	far ptr L1360D	;@0F669
	jae	@@1	;@0F66E
	call	far ptr L1039B	;@0F670
@@1:	pop	bp	;@0F675
	pop	di	;@0F676
	pop	si	;@0F677
	pop	cx	;@0F678
	pop	ax	;@0F679
	retf	;@0F67A
L0F67B:	xor	al, al	;@0F67B
	mov	byte ptr ds:[58DEh], al	;@0F67D
	mov	byte ptr ds:[58DDh], al	;@0F680
	mov	byte ptr ds:[58DFh], al	;@0F683
	mov	word ptr ds:[58D2h], cx	;@0F686
	mov	word ptr ds:[58D4h], bx	;@0F68A
	mov	word ptr ds:[58D6h], dx	;@0F68E
	mov	word ptr ds:[58D8h], si	;@0F692
	mov	word ptr ds:[58DAh], di	;@0F696
	push	word ptr ds:[38ACh]	;@0F69A
	push	cs	;@0F69E
	call	@@5	;@0F69F
	pop	word ptr ds:[38ACh]	;@0F6A2
	jb	@@1	;@0F6A6
	ret	;@0F6A8
@@1:	cmp	byte ptr ds:[58DEh], 0	;@0F6A9
	je	@@2	;@0F6AE
	call	far ptr L13712	;@0F6B0
@@2:	cmp	byte ptr ds:[58DDh], 0	;@0F6B5
	je	@@3	;@0F6BA
	call	far ptr L1051E	;@0F6BC
@@3:	cmp	byte ptr ds:[58DFh], 0	;@0F6C1
	je	@@4	;@0F6C6
	mov	dx, word ptr ds:[58D6h]	;@0F6C8
	call	far ptr L119D0	;@0F6CC
@@4:	mov	sp, word ptr ds:[38ACh]	;@0F6D1
	stc	;@0F6D5
	retf	;@0F6D6
@@5:	mov	word ptr ds:[38ACh], sp	;@0F6D7
	mov	word ptr ds:[58CEh], 0	;@0F6DB
	mov	ax, word ptr ds:[517Ch]	;@0F6E1
	mov	word ptr ds:[38BCh], ax	;@0F6E4
	mov	ax, word ptr ds:[5182h]	;@0F6E7
	mov	word ptr ds:[38BEh], ax	;@0F6EA
	mov	ax, word ptr ds:[51B4h]	;@0F6ED
	mov	word ptr ds:[38C0h], ax	;@0F6F0
	call	L036FE	;@0F6F3
	call	L03674	;@0F6F6
	mov	ax, word ptr ds:[38BCh]	;@0F6F9
	mov	word ptr ds:[517Ch], ax	;@0F6FC
	call	L0F969	;@0F6FF
	mov	ax, word ptr ds:[38BEh]	;@0F702
	mov	word ptr ds:[5182h], ax	;@0F705
	mov	ax, word ptr ds:[38C0h]	;@0F708
	mov	word ptr ds:[51B4h], ax	;@0F70B
	call	L0F9D9	;@0F70E
	mov	bx, word ptr ds:[58D4h]	;@0F711
	call	far ptr L11B65	;@0F715
	mov	word ptr ds:[58CEh], ax	;@0F71A
	xor	ax, ax	;@0F71D
	mov	byte ptr ds:[38CFh], al	;@0F71F
	mov	byte ptr ds:[38D0h], al	;@0F722
	dec	word ptr ds:[38B8h]	;@0F725
@@6:	call	L028AC	;@0F729
	mov	ax, word ptr ds:[5170h]	;@0F72C
	mov	word ptr ds:[5174h], ax	;@0F72F
	mov	ax, word ptr ds:[5172h]	;@0F732
	mov	word ptr ds:[5176h], ax	;@0F735
	mov	ax, word ptr ds:[51B6h]	;@0F738
	mov	word ptr ds:[5184h], ax	;@0F73B
	xor	ax, ax	;@0F73E
	mov	byte ptr ds:[38CAh], al	;@0F740
	mov	si, ax	;@0F743
	call	word ptr ds:[575Ah]	;@0F745
	test	byte ptr ds:[38CAh], 1	;@0F749
	jne	@@9	;@0F74E
@@7:	cmp	byte ptr ds:[51BCh], 0	;@0F750
	je	@@6	;@0F755
	call	L03750	;@0F757
@@8:	or	byte ptr ds:[38C9h], 2	;@0F75A
	call	L0036B	;@0F75F
	call	far ptr L12FEA	;@0F762
	call	far ptr L12864	;@0F767
	mov	byte ptr ds:[38CAh], 0	;@0F76C
	cmp	byte ptr ds:[38D0h], 0	;@0F771
	jne	@@11	;@0F776
	mov	si, 0FB84h	;@0F778
	push	word ptr ds:[516Eh]	;@0F77B
	push	word ptr ds:[517Ah]	;@0F77F
	call	L046E6	;@0F783
	pop	word ptr ds:[517Ah]	;@0F786
	pop	word ptr ds:[516Eh]	;@0F78A
	call	far ptr L12FF9	;@0F78E
	cmp	byte ptr ds:[38CFh], 0	;@0F793
	je	@@10	;@0F798
	call	far ptr L13576	;@0F79A
	call	far ptr L12626	;@0F79F
	call	L00331	;@0F7A4
	and	byte ptr ds:[38C9h], 0FDh	;@0F7A7
	or	byte ptr ds:[38C9h], 4	;@0F7AC
	mov	byte ptr ds:[38CFh], 0	;@0F7B1
	dec	word ptr ds:[38B8h]	;@0F7B6
	mov	dx, word ptr ds:[58CEh]	;@0F7BA
	mov	si, 0F90Ah	;@0F7BE
	mov	di, 0F910h	;@0F7C1
	call	L04732	;@0F7C4
	jmp	@@8	;@0F7C7
@@9:	call	L046CC	;@0F7C9
	jmp	@@7	;@0F7CC
@@10:	and	byte ptr ds:[38C9h], 0E3h	;@0F7CE
	call	L002DE	;@0F7D3
	call	L00305	;@0F7D6
	and	byte ptr ds:[38C9h], 0FDh	;@0F7D9
	jmp	@@16	;@0F7DE
@@11:	call	far ptr L12FF9	;@0F7E1
	test	word ptr ds:[5182h], 80h	;@0F7E6
	je	@@12	;@0F7EC
	mov	cx, 808Bh	;@0F7EE
	call	L0352C	;@0F7F1
@@12:	call	L00331	;@0F7F4
	call	far ptr L13576	;@0F7F7
	call	far ptr L12626	;@0F7FC
	mov	byte ptr ds:[38C9h], 8	;@0F801
	dec	word ptr ds:[38B8h]	;@0F806
	mov	si, word ptr ds:[58D8h]	;@0F80A
	cmp	byte ptr [si], 0	;@0F80E
	je	@@13	;@0F811
	or	byte ptr ds:[38C9h], 10h	;@0F813
	mov	di, word ptr ds:[58D4h]	;@0F818
	mov	dx, word ptr ds:[58D8h]	;@0F81C
	mov	bx, word ptr ds:[5750h]	;@0F820
	mov	byte ptr ds:[58DDh], 0FFh	;@0F824
	call	far ptr L103B4	;@0F829
	mov	si, 0FB75h	;@0F82E
	mov	di, 0FB8Fh	;@0F831
	jmp	short @@14	;@0F834
@@13:	mov	si, 0FB78h	;@0F836
	mov	di, 0F910h	;@0F839
@@14:	mov	dx, word ptr ds:[58CEh]	;@0F83C
	call	L048BC	;@0F840
	or	byte ptr ds:[38C9h], 2	;@0F843
	call	far ptr L12FEA	;@0F848
	mov	byte ptr ds:[38CAh], 0	;@0F84D
	call	far ptr L12FF9	;@0F852
	test	byte ptr ds:[38C9h], 10h	;@0F857
	je	@@15	;@0F85C
	call	far ptr L10547	;@0F85E
	xor	al, al	;@0F863
	mov	byte ptr ds:[38C9h], al	;@0F865
	mov	byte ptr ds:[58DDh], al	;@0F868
	mov	si, word ptr ds:[58D8h]	;@0F86B
	mov	byte ptr [si], al	;@0F86F
@@15:	jmp	@@10	;@0F871
@@16:	mov	si, word ptr ds:[58D6h]	;@0F874
	cmp	byte ptr [si], 0	;@0F878
	je	@@17	;@0F87B
	mov	dx, si	;@0F87D
	mov	si, word ptr ds:[58D4h]	;@0F87F
	mov	bx, word ptr ds:[5750h]	;@0F883
	mov	byte ptr ds:[58DEh], 0FFh	;@0F887
	call	far ptr L13626	;@0F88C
	mov	byte ptr ds:[58DEh], 0	;@0F891
	mov	byte ptr ds:[58DFh], 0FFh	;@0F896
@@17:	mov	si, word ptr ds:[58D8h]	;@0F89B
	cmp	byte ptr [si], 0	;@0F89F
	je	@@18	;@0F8A2
	call	far ptr L13542	;@0F8A4
	mov	byte ptr ds:[38C9h], 11h	;@0F8A9
	mov	di, word ptr ds:[58D4h]	;@0F8AE
	mov	dx, word ptr ds:[58D8h]	;@0F8B2
	mov	bx, word ptr ds:[5750h]	;@0F8B6
	mov	byte ptr ds:[58DDh], 0FFh	;@0F8BA
	call	far ptr L103B4	;@0F8BF
	call	L0036B	;@0F8C4
	call	far ptr L12864	;@0F8C7
	mov	dx, word ptr ds:[58CEh]	;@0F8CC
	mov	si, 0FB75h	;@0F8D0
	mov	di, 0FB8Fh	;@0F8D3
	call	L048BC	;@0F8D6
	call	far ptr L10547	;@0F8D9
	xor	al, al	;@0F8DE
	mov	byte ptr ds:[38C9h], al	;@0F8E0
	mov	byte ptr ds:[58DDh], al	;@0F8E3
@@18:	mov	si, word ptr ds:[58DAh]	;@0F8E6
	cmp	byte ptr [si], 0	;@0F8EA
	je	@@19	;@0F8ED
	mov	dx, si	;@0F8EF
	mov	si, word ptr ds:[58D2h]	;@0F8F1
	mov	bx, word ptr ds:[5750h]	;@0F8F5
	mov	byte ptr ds:[58DDh], 0FFh	;@0F8F9
	call	far ptr L105D5	;@0F8FE
	mov	byte ptr ds:[58DDh], 0	;@0F903
@@19:	clc	;@0F908
	retf	;@0F909
	db	33h, 0F6h, 0FFh, '&ZW', 80h, 3Eh, 0BCh, 51h, 0, 0C3h	;@0F90A
L0F916:	mov	bx, dx	;@0F916
	call	far ptr L11A13	;@0F918
	ret	;@0F91D
L0F91E:	call	L0288E	;@0F91E
	call	L0FB78	;@0F921
	test	byte ptr ds:[38CAh], 1	;@0F924
	je	@@1	;@0F929
	mov	cx, 2Dh	;@0F92B
	jmp	L0352C	;@0F92E
@@1:	ret	;@0F931
	db	9Ah	;@0F932
	dd	L11D9C
	db	9Ah
	dd	L11DBF
	db	0C3h
L0F93D:	call	far ptr L11CEB	;@0F93D
	jae	L0F93D	;@0F942
@@1:	call	far ptr L11D17	;@0F944
	jae	@@1	;@0F949
@@2:	call	far ptr L118C2	;@0F94B
	jae	@@2	;@0F950
@@3:	call	L046B2	;@0F952
	jae	@@3	;@0F955
@@4:	call	L05737	;@0F957
	jae	@@4	;@0F95A
@@5:	call	far ptr L1360D	;@0F95C
	jae	@@5	;@0F961
	call	far ptr L10017	;@0F963
	ret	;@0F968
L0F969:	mov	ax, word ptr ds:[517Ch]	;@0F969
	test	ax, 1000h	;@0F96C
	jne	@@4	;@0F96F
	mov	word ptr ds:[575Ah], 0FBC3h	;@0F971
	test	ax, 2000h	;@0F977
	jne	@@2	;@0F97A
	mov	word ptr ds:[5762h], 60h	;@0F97C
	mov	word ptr ds:[5760h], 16h	;@0F982
	test	ax, 4000h	;@0F988
	je	@@1	;@0F98B
	mov	word ptr ds:[575Ch], 582Eh	;@0F98D
	mov	word ptr ds:[575Eh], 13h	;@0F993
	ret	;@0F999
@@1:	mov	word ptr ds:[575Ch], 5826h	;@0F99A
	mov	word ptr ds:[575Eh], 17h	;@0F9A0
	ret	;@0F9A6
@@2:	mov	word ptr ds:[5762h], 64h	;@0F9A7
	mov	word ptr ds:[5760h], 17h	;@0F9AD
	test	ax, 4000h	;@0F9B3
	je	@@3	;@0F9B6
	mov	word ptr ds:[575Ch], 582Eh	;@0F9B8
	mov	word ptr ds:[575Eh], 14h	;@0F9BE
	ret	;@0F9C4
@@3:	mov	word ptr ds:[575Ch], 5826h	;@0F9C5
	mov	word ptr ds:[575Eh], 18h	;@0F9CB
	ret	;@0F9D1
@@4:	mov	word ptr ds:[575Ah], 0FD17h	;@0F9D2
	ret	;@0F9D8
L0F9D9:	call	far ptr L11962	;@0F9D9
	mov	byte ptr ds:[20BCh], al	;@0F9DE
	mov	byte ptr ds:[20BFh], al	;@0F9E1
	mov	al, ch	;@0F9E4
	call	@@5	;@0F9E6
	mov	word ptr ds:[20BAh], ax	;@0F9E9
	mov	al, cl	;@0F9EC
	call	@@5	;@0F9EE
	mov	word ptr ds:[20BDh], ax	;@0F9F1
	mov	al, dh	;@0F9F4
	call	@@5	;@0F9F6
	mov	word ptr ds:[20C0h], ax	;@0F9F9
	call	far ptr L11959	;@0F9FC
	mov	byte ptr ds:[20D2h], al	;@0FA01
	mov	byte ptr ds:[20D5h], al	;@0FA04
	mov	al, ch	;@0FA07
	call	@@5	;@0FA09
	mov	word ptr ds:[20D0h], ax	;@0FA0C
	mov	al, cl	;@0FA0F
	call	@@5	;@0FA11
	mov	word ptr ds:[20D3h], ax	;@0FA14
	mov	al, dh	;@0FA17
	call	@@5	;@0FA19
	mov	word ptr ds:[20D6h], ax	;@0FA1C
	mov	di, 20EAh	;@0FA1F
	mov	si, word ptr ds:[58D2h]	;@0FA22
	mov	cx, 8	;@0FA26
	xor	dx, dx	;@0FA29
	push	ss	;@0FA2B
	pop	es	;@0FA2C
@@1:	lodsb	;@0FA2D
	and	al, al	;@0FA2E
	je	@@2	;@0FA30
	stosb	;@0FA32
	inc	dx	;@0FA33
	loop	@@1	;@0FA34
	jmp	short @@3	;@0FA36
@@2:	mov	al, 20h	;@0FA38
	rep stosb	;@0FA3A
@@3:	mov	bx, word ptr ds:[58D2h]	;@0FA3C
	mov	cx, dx	;@0FA40
	jcxz	@@4	;@0FA42
	call	L003F5	;@0FA44
	mov	ax, word ptr ds:[5784h]	;@0FA47
	call	far ptr L101E0	;@0FA4A
	mov	ax, dx	;@0FA4F
	call	@@8	;@0FA51
@@4:	call	@@7	;@0FA54
	mov	al, byte ptr ds:[58D0h]	;@0FA57
	call	@@5	;@0FA5A
	mov	word ptr ds:[2109h], ax	;@0FA5D
	mov	al, byte ptr ds:[58D1h]	;@0FA60
	call	@@5	;@0FA63
	mov	word ptr ds:[2102h], ax	;@0FA66
	push	ds	;@0FA69
	pop	es	;@0FA6A
	mov	di, 20AEh	;@0FA6B
	call	L0F91E	;@0FA6E
	push	ds	;@0FA71
	pop	es	;@0FA72
	mov	di, 20C4h	;@0FA73
	call	L0F91E	;@0FA76
	push	ds	;@0FA79
	pop	es	;@0FA7A
	mov	di, 20DAh	;@0FA7B
	call	L0F91E	;@0FA7E
	push	ds	;@0FA81
	pop	es	;@0FA82
	mov	di, 20F4h	;@0FA83
	jmp	L0F91E	;@0FA86
@@5:	mov	ah, 2Fh	;@0FA89
@@6:	inc	ah	;@0FA8B
	sub	al, 0Ah	;@0FA8D
	jae	@@6	;@0FA8F
	add	al, 3Ah	;@0FA91
	xchg	al, ah	;@0FA93
	ret	;@0FA95
@@7:	mov	ax, word ptr ds:[517Ch]	;@0FA96
	mov	cx, ax	;@0FA99
	and	ax, 0D9Eh	;@0FA9B
	or	al, 1	;@0FA9E
	mov	bx, 210Ch	;@0FAA0
	call	@@10	;@0FAA3
	mov	bx, 210Ch	;@0FAA6
	mov	cx, 5	;@0FAA9
	call	L003FF	;@0FAAC
	push	ax	;@0FAAF
	mov	ax, word ptr ds:[5786h]	;@0FAB0
	call	far ptr L101E0	;@0FAB3
	pop	ax	;@0FAB8
@@8:	push	ax	;@0FAB9
	call	L01838	;@0FABA
	pop	ax	;@0FABD
	jne	@@9	;@0FABE
	call	L038F1	;@0FAC0
	jmp	L01950	;@0FAC3
@@9:	ret	;@0FAC6
@@10:	push	ax	;@0FAC7
	mov	al, ah	;@0FAC8
	call	@@11	;@0FACA
	pop	ax	;@0FACD
@@11:	mov	ah, al	;@0FACE
	mov	cl, 4	;@0FAD0
	shr	al, cl	;@0FAD2
	call	@@12	;@0FAD4
	mov	al, ah	;@0FAD7
	and	al, 0Fh	;@0FAD9
@@12:	add	al, 30h	;@0FADB
	cmp	al, 39h	;@0FADD
	jbe	@@13	;@0FADF
	add	al, 7	;@0FAE1
@@13:	mov	byte ptr [bx], al	;@0FAE3
	inc	bx	;@0FAE5
	ret	;@0FAE6
	db	0F6h, 6, 0C9h, 38h, 10h, 75h, 3, 0E9h, 0BBh, 2Dh, 0E8h, 9Bh, 0, 0E8h, 0B5h, 2Dh	;@0FAE7
	db	56h, 0E8h, 0Fh, 0, 5Eh, 0F7h, 6, 0B4h, 51h, 1, 0, 75h, 5, 9Ah
	dd	L106D9
	db	0C3h, 0C6h, 6, 0BBh, 51h, 0, 56h, 0A1h, 6Eh, 51h, 8Bh, 16h, 7Ah, 51h, 9Ah
	dd	L11D9C
	db	50h, 9Ah
	dd	L11DBF
	db	58h, 9Ah
	dd	L106AA
	db	8Bh, 16h, 7Ah, 51h, 9Ah
	dd	L11DBF
	db	5Bh, 80h, 0FAh, 1, 75h, 1Dh, 9Ah
	dd	L10664
	db	9Ah
	dd	L11D8C
	db	9Ah
	dd	L106BF
	db	0F7h, 6, 0B4h, 51h, 8, 0, 75h, 26h, 9Ah
	dd	L106D9
	db	0C3h, 9Ah
	dd	L10664
	db	9Ah
	dd	L11D8C
	db	23h, 0C0h, 74h, 12h, 9Ah
	dd	L106BF
	db	0F7h, 6, 0B4h, 51h, 4, 0, 75h, 5, 9Ah
	dd	L106D9
	db	0C3h, 0E8h, 92h, 0FFh
L0FB78:	xor	ax, ax	;@0FB78
	mov	byte ptr ds:[38CAh], al	;@0FB7A
	mov	si, ax	;@0FB7D
	jmp	word ptr ds:[575Ah]	;@0FB7F
	db	90h, 33h, 0C0h, 0A2h, 0CAh, 38h, 8Bh, 0F0h, 0FFh, 26h, 5Ah, 57h, 9Ah	;@0FB83
	dd	L1286E
	db	80h, 3Eh, 0BBh, 51h, 0, 74h, 0Bh, 9Ah
	dd	L107F9
	db	80h, 3Eh, 0BCh, 51h, 0, 0C3h, 0F7h, 6, 0B4h, 51h, 20h, 0, 75h, 0EDh, 8Bh, 16h
	db	7Ah, 51h, 9Ah
	dd	L11DBF
	db	0F6h, 0C2h, 1, 74h, 0DFh, 9Ah
	dd	L106D9
	db	0EBh, 0D8h, 0E8h, 8Bh, 5Bh, 0E8h, 0D3h, 23h, 51h, 0E8h, 0D4h, 23h, 59h, 75h, 47h, 8Bh
	db	0D8h, 83h, 0C6h, 2, 22h, 0E4h, 74h, 3Bh, 89h, 0Eh, 56h, 57h, 53h, 52h, 0E8h, 0BAh
	db	23h, 89h, 0Eh, 58h, 57h, 0E8h, 0B8h, 23h, 8Bh, 0C8h, 8Bh, 0FAh, 5Ah, 5Bh, 75h, 32h
	db	83h, 3Eh, 0B0h, 51h, 0, 75h, 5Eh, 8Bh, 0C3h, 2Bh, 6, 54h, 57h, 72h, 4Fh, 3Bh
	db	6, 62h, 57h, 73h, 49h, 3Bh, 0Eh, 2Eh, 58h, 74h, 4Ah, 3Bh, 0Eh, 30h, 58h, 74h
	db	44h, 0EBh, 2Ah, 0E9h, 0F4h, 0, 0E9h, 5Fh, 2, 83h, 0C6h, 2, 0E9h, 0E8h, 0B7h, 0E9h
	db	0E3h, 0B7h, 8Bh, 0C2h, 0E8h, 0D7h, 0Ch, 74h, 57h, 8Bh, 0C2h, 0E8h, 0A4h, 0Ch, 74h, 0EFh
	db	8Bh, 0C3h, 2Bh, 6, 54h, 57h, 72h, 6Ch, 3Dh, 24h, 4, 73h, 67h, 8Bh, 0F8h, 8Bh
	db	0C3h, 9Ah
	dd	L101E0
	db	0E8h, 36h, 0Ah, 0FFh, 0A5h, 42h, 21h, 0C3h, 8Bh, 0C2h, 0E8h, 0ABh, 0Ch, 74h, 2Bh, 8Bh
	db	0C7h, 22h, 0E4h, 74h, 5, 0E8h, 74h, 0Ch, 74h, 0B9h, 8Bh, 0C1h, 16h, 7, 8Bh, 3Eh
	db	5Ch, 57h, 8Bh, 0Eh, 5Eh, 57h, 0F2h, 0AFh, 75h, 0B9h, 83h, 0C6h, 2, 8Bh, 3Eh, 60h
	db	57h, 2Bh, 0F9h, 0D1h, 0E7h, 0FFh, 0A5h, 12h, 21h, 0C3h, 3Bh, 0Eh, 6Ah, 57h, 74h, 0CFh
	db	0F6h, 6, 0C9h, 38h, 2, 75h, 0F2h, 8Bh, 0DAh, 0E8h, 0E6h, 1, 75h, 0EBh, 0E8h, 0A7h
	db	3Ch, 0E8h, 5Dh, 1, 0C6h, 6, 0BBh, 51h, 0FFh, 8Bh, 0C2h, 0E9h, 0FCh, 23h, 0E8h, 0D1h
	db	1, 75h, 5Eh, 8Bh, 0C2h, 0E8h, 0F8h, 0Bh, 75h, 19h, 0E8h, 44h, 1, 83h, 0EEh, 2
	db	0E8h, 6Ah, 2Ch, 75h, 4Ch, 0E8h, 33h, 1, 0E8h, 0DAh, 22h, 51h, 0E8h, 5Eh, 2Ch, 59h
	db	0E9h, 6, 0FFh, 0E8h, 0D4h, 22h, 75h, 22h, 22h, 0E4h, 74h, 1Eh, 8Bh, 0C2h, 0E8h, 0E7h
	db	0Bh, 75h, 17h, 0E8h, 1Bh, 1, 0E8h, 44h, 2Ch, 83h, 0EEh, 2, 0E8h, 0Ch, 1, 0E8h
	db	0B3h, 22h, 51h, 0E8h, 0B9h, 22h, 59h, 0E9h, 0DFh, 0FEh, 50h, 83h, 0EEh, 2, 0E8h, 0A9h
	db	22h, 59h, 8Bh, 0C2h, 0E8h, 1, 0Ch, 74h, 81h, 9Ah
	dd	L101E0
	db	0E9h, 0B3h, 0, 0E9h, 0BDh, 2Bh, 0E8h, 6Bh, 1, 75h, 6, 0B9h, 61h, 0, 0E9h, 16h
	db	38h, 0C3h, 0E8h, 37h, 5Ah, 0E8h, 89h, 22h, 75h, 46h, 22h, 0E4h, 74h, 0E8h, 8Bh, 0D8h
	db	8Bh, 0C2h, 0E8h, 0D5h, 0Bh, 74h, 20h, 8Bh, 0C3h, 2Bh, 6, 52h, 57h, 72h, 35h, 3Dh
	db	0B8h, 3, 73h, 30h, 83h, 0C6h, 2, 8Bh, 0F8h, 8Bh, 0C2h, 9Ah
	dd	L101E0
	db	0E8h, 38h, 9, 0FFh, 0A5h, 64h, 21h, 8Bh, 0DAh, 0E8h, 28h, 1, 75h, 15h, 83h, 0C6h
	db	2, 0F6h, 6, 0C9h, 38h, 2, 75h, 0Bh, 0E8h, 0DFh, 3Bh, 8Bh, 0C2h, 0E9h, 3Ch, 23h
	db	0E9h, 11h, 1, 0C3h, 8Bh, 0C2h, 0E8h, 65h, 0Bh, 74h, 2Ah, 53h, 52h, 83h, 0C6h, 2
	db	0E8h, 2Eh, 22h, 59h, 5Bh, 75h, 33h, 52h, 8Bh, 0D1h, 16h, 7, 0BFh, 26h, 58h, 0B9h
	db	0Eh, 0, 0F2h, 0AFh, 58h, 75h, 14h, 83h, 0C6h, 2, 0BFh, 0Dh, 0, 2Bh, 0F9h, 0D1h
	db	0E7h, 0FFh, 0A5h, 12h, 21h, 83h, 0C6h, 2, 0E9h, 66h, 0B6h, 22h, 0E4h, 74h, 0Bh, 0E8h
	db	2Ch, 0Bh, 75h, 6, 83h, 0C6h, 2, 0E9h, 59h, 0B6h, 0E8h, 0C7h, 0, 75h, 16h, 8Bh
	db	0C2h, 9Ah
	dd	L101E0
	db	0E8h, 0C2h, 8, 0F6h, 6, 0C9h, 38h, 0Bh, 75h, 8, 80h, 0Eh, 0CAh, 38h, 3, 0E9h
	db	0FBh, 2Ah, 0B9h, 8, 0, 0E8h, 59h, 37h, 0E9h, 0F2h, 2Ah, 0B9h, 68h, 0, 0E9h, 50h
	db	37h, 0E8h, 45h, 2Bh, 75h, 9, 0E8h, 0E4h, 2Ah, 0B9h, 6, 0, 0E9h, 42h, 37h, 0C3h
	db	8Bh, 0Eh, 56h, 57h, 0E9h, 0D5h, 21h, 0A1h, 56h, 57h, 0E9h, 95h, 22h, 0F7h, 6, 7Ch
	db	51h, 0, 10h, 75h, 6, 0A1h, 58h, 57h, 0E9h, 87h, 22h, 0C3h
L0FE07:	call	@@4	;@0FE07
	jne	@@1	;@0FE0A
	test	byte ptr ds:[51BFh], 80h	;@0FE0C
	jne	@@2	;@0FE11
@@1:	ret	;@0FE13
@@2:	cmp	word ptr ds:[51B0h], 0	;@0FE14
	jne	@@3	;@0FE19
	and	byte ptr ds:[51BFh], 7Fh	;@0FE1B
	push	bx	;@0FE20
	push	cx	;@0FE21
	push	dx	;@0FE22
	call	L028C8	;@0FE23
	call	L075F6	;@0FE26
	pop	dx	;@0FE29
	pop	cx	;@0FE2A
	pop	bx	;@0FE2B
	xor	al, al	;@0FE2C
	dec	al	;@0FE2E
	ret	;@0FE30
@@3:	xor	al, al	;@0FE31
	ret	;@0FE33
	db	0F6h, 6, 0C9h, 38h, 1, 74h, 52h, 0F7h, 6, 0B4h, 51h, 2, 0, 75h, 4Ah, 9Ah	;@0FE34
	dd	L106D9
	db	0EBh, 43h, 0F6h, 6, 0C9h, 38h, 1, 74h, 0Fh, 0F7h, 6, 0B4h, 51h, 2, 0, 75h
	db	34h, 9Ah
	dd	L106D9
	db	0EBh, 2Dh, 32h, 0C0h, 0FEh, 0C8h, 0C3h, 0F6h, 6, 0C9h, 38h, 1, 74h, 21h, 0F7h, 6
	db	0B4h, 51h, 10h, 0, 75h, 5, 9Ah
	dd	L106D9
@@4:	test	byte ptr ds:[38C9h], 1	;@0FE79
	je	@@5	;@0FE7E
	test	word ptr ds:[51B4h], 1	;@0FE80
	jne	@@5	;@0FE86
	call	far ptr L106D9	;@0FE88
@@5:	cmp	byte ptr ds:[51C3h], 0	;@0FE8D
	jne	@@6	;@0FE92
	ret	;@0FE94
@@6:	test	byte ptr ds:[38C9h], 1	;@0FE95
	je	@@7	;@0FE9A
	test	word ptr ds:[51B4h], 10h	;@0FE9C
	jne	@@8	;@0FEA2
	call	far ptr L106D9	;@0FEA4
@@7:	xor	al, al	;@0FEA9
	dec	al	;@0FEAB
@@8:	ret	;@0FEAD
	db	0E8h, 11h, 0ADh, 75h, 1, 0C3h, 0E8h, 0E5h, 5Ah, 0B9h, 0Dh, 0, 0E9h	;@0FEAE
	db	6Fh, 36h, 0E8h, 2, 0ADh, 75h, 18h, 0E8h, '_*u', 16h, 3Bh, 6, '^Xu'
	db	10h, 83h, 0C6h, 2, 6, 55h, 0E8h, 0EDh, 0ACh, '_Xu', 11h, 0C3h
	db	0E8h, 0BFh, 5Ah, 6, 55h, 0E8h, 0BAh, 'Z_X', 0B9h, 0Dh, 0, 0E9h
	db	'B6PW', 0E8h, 0ADh, 'Z_X', 0B9h, 0Ah, 0, 0F7h, 6, 7Ch, 51h, 0
	db	20h, 75h, 4, 81h, 0C9h, 0, 80h, 57h, 0E8h, '(6_', 0C3h, 0E8h, 0B9h
	db	0ACh, 75h, 37h, 0E8h, 16h, '*u5;', 6, '^Xu/', 83h, 0C6h, 2, 6
	db	55h, 0E8h, 0A4h, 0ACh, '_XuBPW', 0E8h, 0FDh, ')[Zu!;', 6, '^Xu'
	db	1Bh, 83h, 0C6h, 2, 6, 'URS', 0E8h, 87h, 0ACh, '[Z_Xu.', 0C3h, 0E8h
	db	57h, 5Ah, 6, 55h, 0E8h, 'RZ_XPW', 6, 55h, 0E8h, 'IZ_X[Z', 0B9h
	db	0Dh, 0, 'RSW', 0E8h, 0CCh, '5_[Z', 0C3h, 50h, 57h, 0E8h, '3Z[Z'
	db	8Ch, 0C0h, 8Bh, 0FDh, 52h, 53h, 0E8h, 76h, 0FFh, 5Bh, 5Ah, 0C3h
SEG1	ends

SEG2	segment para public 'CODE'
	assume	cs:SEG2
L0FF80:	mov	si, 0Dh	;@0FF80
	mov	word ptr ds:[38ACh], sp	;@0FF83
	push	cs	;@0FF87
	call	L128AB	;@0FF88
	clc	;@0FF8B
	retf	;@0FF8C
	db	9Ah	;@0FF8D
	dd	L1527B
	db	0C3h, 0
L0FF94:	push	ds	;@0FF94
	pop	es	;@0FF95
	xor	ax, ax	;@0FF96
	mov	di, 38D2h	;@0FF98
	mov	cx, 10h	;@0FF9B
	rep stosw	;@0FF9E
	mov	di, 38F2h	;@0FFA0
	mov	cx, 4	;@0FFA3
	rep stosw	;@0FFA6
	mov	ax, 0FFFh	;@0FFA8
	push	cs	;@0FFAB
	call	L10039	;@0FFAC
	mov	word ptr ds:[38D2h], 0	;@0FFAF
	mov	word ptr ds:[38D4h], ax	;@0FFB5
	mov	word ptr ds:[38FEh], 2	;@0FFB8
	mov	word ptr ds:[38FAh], 1000h	;@0FFBE
	mov	es, ax	;@0FFC4
	mov	word ptr es:[0], 0	;@0FFC6
	mov	word ptr es:[2], 0FFFh	;@0FFCD
	mov	ax, 1000h	;@0FFD4
	push	cs	;@0FFD7
	call	L10039	;@0FFD8
	mov	word ptr ds:[38F2h], ax	;@0FFDB
	mov	es, ax	;@0FFDE
	mov	ax, 1	;@0FFE0
	mov	word ptr ds:[3900h], ax	;@0FFE3
	mov	word ptr ds:[38FCh], ax	;@0FFE6
	mov	word ptr es:[4], 0	;@0FFE9
	mov	word ptr es:[6], 3FFFh	;@0FFF0
	retf	;@0FFF7
L0FFF8:	mov	si, 38D4h	;@0FFF8
	mov	cx, word ptr ds:[38FEh]	;@0FFFB
	dec	cx	;@0FFFF
	call	@@1	;@10000
	mov	si, 38F2h	;@10003
	mov	cx, word ptr ds:[3900h]	;@10006
	call	@@1	;@1000A
	retf	;@1000D
@@1:	lodsw	;@1000E
	push	cs	;@1000F
	call	L10064	;@10010
	cld	;@10013
	loop	@@1	;@10014
	ret	;@10016
L10017:	mov	cx, 10h	;@10017
	sub	cx, word ptr ds:[38FEh]	;@1001A
	shl	cx, 0Ch	;@1001E
	mov	ax, word ptr ds:[38FAh]	;@10021
@@1:	and	ax, ax	;@10024
	je	@@2	;@10026
	push	cs	;@10028
	call	L101E0	;@10029
	add	cx, word ptr es:[bp+2]	;@1002C
	mov	ax, word ptr es:[bp]	;@10030
	jmp	@@1	;@10034
@@2:	mov	ax, cx	;@10036
	retf	;@10038
L10039:	push	bx	;@10039
@@1:	push	ax	;@1003A
	mov	bx, ax	;@1003B
	mov	ax, 4800h	;@1003D
	int	21h	;@10040
	cld	;@10042
	jb	@@2	;@10043
	pop	bx	;@10045
	pop	bx	;@10046
	retf	;@10047
@@2:	push	cx	;@10048
	push	dx	;@10049
	push	es	;@1004A
	push	si	;@1004B
	push	di	;@1004C
	call	far ptr L0F643	;@1004D
	pop	di	;@10052
	pop	si	;@10053
	pop	es	;@10054
	pop	dx	;@10055
	pop	cx	;@10056
	pop	ax	;@10057
	jae	@@1	;@10058
	mov	byte ptr ds:[38C8h], 1	;@1005A
	mov	sp, word ptr ds:[38ACh]	;@1005F
	retf	;@10063
L10064:	mov	es, ax	;@10064
	mov	ax, 4900h	;@10066
	int	21h	;@10069
	retf	;@1006B
L1006C:	push	bx	;@1006C
	push	ax	;@1006D
	mov	es, ax	;@1006E
	mov	bx, cx	;@10070
	mov	ah, 4Ah	;@10072
	int	21h	;@10074
	pop	ax	;@10076
	pop	bx	;@10077
	retf	;@10078
L10079:	mov	ax, 4800h	;@10079
	mov	bx, 0FFFFh	;@1007C
	int	21h	;@1007F
	cld	;@10081
	mov	ax, bx	;@10082
	retf	;@10084
L10085:	cmp	word ptr ds:[38FEh], 10h	;@10085
	jne	@@4	;@1008A
	xor	cx, cx	;@1008C
	mov	ax, word ptr ds:[38FAh]	;@1008E
@@1:	and	ax, ax	;@10091
	je	@@3	;@10093
	push	cs	;@10095
	call	L101E0	;@10096
	mov	ax, word ptr es:[bp+2]	;@10099
	cmp	cx, ax	;@1009D
	jae	@@2	;@1009F
	mov	cx, ax	;@100A1
@@2:	mov	ax, word ptr es:[bp]	;@100A3
	jmp	@@1	;@100A7
@@3:	mov	ax, cx	;@100A9
	retf	;@100AB
@@4:	mov	ax, 1000h	;@100AC
	retf	;@100AF
L100B0:	push	bx	;@100B0
	push	dx	;@100B1
	push	si	;@100B2
	push	bp	;@100B3
	push	es	;@100B4
	push	ds	;@100B5
@@1:	mov	bx, 38FAh	;@100B6
@@2:	mov	dx, word ptr [bx]	;@100B9
	and	dx, dx	;@100BB
	je	@@3	;@100BD
	mov	si, dx	;@100BF
	rol	si, 4	;@100C1
	mov	bp, si	;@100C4
	and	bp, -10h	;@100C6
	and	si, 0Fh	;@100C9
	shl	si, 1	;@100CC
	mov	si, word ptr ss:[si+38D2h]	;@100CE
	mov	es, si	;@100D3
	cmp	word ptr es:[bp+2], ax	;@100D5
	je	@@5	;@100D9
	jae	@@7	;@100DB
	mov	ds, si	;@100DD
	mov	bx, bp	;@100DF
	jmp	@@2	;@100E1
@@3:	mov	si, word ptr ss:[38FEh]	;@100E3
	cmp	si, 10h	;@100E8
	je	@@4	;@100EB
	mov	dx, ds	;@100ED
	pop	ds	;@100EF
	push	ax	;@100F0
	mov	ax, 0FFFh	;@100F1
	push	cs	;@100F4
	call	L10039	;@100F5
	push	es	;@100F8
	mov	es, ax	;@100F9
	mov	word ptr es:[0], 0	;@100FB
	mov	word ptr es:[2], 0FFFh	;@10102
	mov	es, dx	;@10109
	mov	word ptr es:[bx], si	;@1010B
	ror	word ptr es:[bx], 4	;@1010E
	pop	es	;@10112
	shl	si, 1	;@10113
	mov	word ptr [si+38D2h], ax	;@10115
	inc	word ptr ds:[38FEh]	;@10119
	pop	ax	;@1011D
	push	ds	;@1011E
	jmp	@@1	;@1011F
@@4:	pop	ds	;@10121
	push	ds	;@10122
	call	far ptr L0F645	;@10123
	jae	@@1	;@10128
	mov	sp, word ptr ds:[38ACh]	;@1012A
	mov	byte ptr ds:[38C8h], 1	;@1012E
	stc	;@10133
	retf	;@10134
@@5:	mov	cx, ax	;@10135
@@6:	mov	ax, word ptr es:[bp]	;@10137
	mov	word ptr [bx], ax	;@1013B
	mov	ax, dx	;@1013D
	jmp	short @@9	;@1013F
@@7:	cmp	word ptr es:[bp+2], cx	;@10141
	je	@@6	;@10145
	jae	@@8	;@10147
	mov	cx, ax	;@10149
@@8:	sub	word ptr es:[bp+2], cx	;@1014B
	mov	ax, dx	;@1014F
	add	ax, word ptr es:[bp+2]	;@10151
@@9:	pop	ds	;@10155
	pop	es	;@10156
	pop	bp	;@10157
	pop	si	;@10158
	pop	dx	;@10159
	pop	bx	;@1015A
	retf	;@1015B
L1015C:	pusha	;@1015C
	push	es	;@1015D
	push	ds	;@1015E
	add	dx, ax	;@1015F
	mov	bx, 38FAh	;@10161
@@1:	mov	cx, word ptr [bx]	;@10164
@@2:	mov	di, cx	;@10166
	jcxz	@@5	;@10168
	mov	si, cx	;@1016A
	rol	si, 4	;@1016C
	mov	bp, si	;@1016F
	and	bp, -10h	;@10171
	and	si, 0Fh	;@10174
	shl	si, 1	;@10177
	mov	si, word ptr ss:[si+38D2h]	;@10179
	mov	es, si	;@1017E
	cmp	dx, cx	;@10180
	jb	@@5	;@10182
	je	@@4	;@10184
	add	cx, word ptr es:[bp+2]	;@10186
	cmp	cx, ax	;@1018A
	je	@@3	;@1018C
	mov	cx, es	;@1018E
	mov	ds, cx	;@10190
	mov	bx, bp	;@10192
	jmp	@@1	;@10194
@@3:	xor	ch, ah	;@10196
	and	ch, 0F0h	;@10198
	jne	@@5	;@1019B
	mov	ax, di	;@1019D
	mov	cx, word ptr es:[bp]	;@1019F
	mov	word ptr [bx], cx	;@101A3
	jmp	@@2	;@101A5
@@4:	xor	ch, dh	;@101A7
	and	ch, 0F0h	;@101A9
	jne	@@5	;@101AC
	add	dx, word ptr es:[bp+2]	;@101AE
	mov	cx, word ptr es:[bp]	;@101B2
	mov	word ptr [bx], cx	;@101B6
	jmp	@@2	;@101B8
@@5:	mov	word ptr [bx], ax	;@101BA
	sub	dx, ax	;@101BC
	mov	si, ax	;@101BE
	rol	si, 4	;@101C0
	mov	bp, si	;@101C3
	and	bp, -10h	;@101C5
	and	si, 0Fh	;@101C8
	shl	si, 1	;@101CB
	mov	si, word ptr ss:[si+38D2h]	;@101CD
	mov	es, si	;@101D2
	mov	word ptr es:[bp+2], dx	;@101D4
	mov	word ptr es:[bp], di	;@101D8
	pop	ds	;@101DC
	pop	es	;@101DD
	popa	;@101DE
	retf	;@101DF
L101E0:	push	bx	;@101E0
	mov	bx, ax	;@101E1
	rol	bx, 4	;@101E3
	mov	bp, bx	;@101E6
	and	bp, -10h	;@101E8
	and	bx, 0Fh	;@101EB
	shl	bx, 1	;@101EE
	mov	es, word ptr ss:[bx+38D2h]	;@101F0
	pop	bx	;@101F5
	retf	;@101F6
L101F7:	push	bx	;@101F7
	push	cx	;@101F8
	xor	cx, cx	;@101F9
	mov	bx, 38D2h	;@101FB
	mov	ax, es	;@101FE
@@1:	cmp	ax, word ptr ss:[bx]	;@10200
	je	@@2	;@10203
	add	bx, 2	;@10205
	inc	cx	;@10208
	jmp	@@1	;@10209
@@2:	mov	ax, cx	;@1020B
	or	ax, bp	;@1020D
	ror	ax, 4	;@1020F
	pop	cx	;@10212
	pop	bx	;@10213
	retf	;@10214
L10215:	push	bx	;@10215
	push	cx	;@10216
	push	dx	;@10217
	push	si	;@10218
	push	ds	;@10219
	add	ax, 3	;@1021A
	shr	ax, 2	;@1021D
@@1:	mov	bx, 38FCh	;@10220
@@2:	mov	dx, word ptr [bx]	;@10223
	and	dx, dx	;@10225
	je	@@3	;@10227
	mov	si, dx	;@10229
	rol	si, 2	;@1022B
	mov	di, si	;@1022E
	and	di, -4	;@10230
	and	si, 3	;@10233
	shl	si, 1	;@10236
	mov	si, word ptr ss:[si+38F2h]	;@10238
	mov	es, si	;@1023D
	cmp	word ptr es:[di+2], ax	;@1023F
	je	@@5	;@10243
	jae	@@6	;@10245
	mov	ds, si	;@10247
	mov	bx, di	;@10249
	jmp	@@2	;@1024B
@@3:	mov	si, word ptr ss:[3900h]	;@1024D
	cmp	si, 4	;@10252
	je	@@4	;@10255
	mov	dx, ds	;@10257
	pop	ds	;@10259
	push	ax	;@1025A
	mov	ax, 1000h	;@1025B
	push	cs	;@1025E
	call	L10039	;@1025F
	push	es	;@10262
	mov	es, ax	;@10263
	mov	word ptr es:[0], 0	;@10265
	mov	word ptr es:[2], 3FFFh	;@1026C
	mov	es, dx	;@10273
	mov	word ptr es:[bx], si	;@10275
	ror	word ptr es:[bx], 2	;@10278
	pop	es	;@1027C
	shl	si, 1	;@1027D
	mov	word ptr [si+38F2h], ax	;@1027F
	inc	word ptr ds:[3900h]	;@10283
	pop	ax	;@10287
	push	ds	;@10288
	jmp	@@1	;@10289
@@4:	push	ss	;@1028B
	pop	ds	;@1028C
	mov	sp, word ptr ds:[38ACh]	;@1028D
	mov	byte ptr ds:[38C8h], 2	;@10291
	stc	;@10296
	retf	;@10297
@@5:	mov	cx, ax	;@10298
	mov	ax, word ptr es:[di]	;@1029A
	mov	word ptr [bx], ax	;@1029D
	mov	ax, dx	;@1029F
	jmp	short @@7	;@102A1
@@6:	sub	word ptr es:[di+2], ax	;@102A3
	mov	ax, dx	;@102A7
	add	ax, word ptr es:[di+2]	;@102A9
	mov	si, ax	;@102AD
	rol	si, 2	;@102AF
	mov	di, si	;@102B2
	and	di, -4	;@102B4
	and	si, 3	;@102B7
	shl	si, 1	;@102BA
	mov	si, word ptr ss:[si+38F2h]	;@102BC
	mov	es, si	;@102C1
@@7:	pop	ds	;@102C3
	pop	si	;@102C4
	pop	dx	;@102C5
	pop	cx	;@102C6
	pop	bx	;@102C7
	retf	;@102C8
L102C9:	push	ax	;@102C9
	push	bx	;@102CA
	push	cx	;@102CB
	push	dx	;@102CC
	push	si	;@102CD
	push	di	;@102CE
	push	bp	;@102CF
	push	es	;@102D0
	push	ds	;@102D1
	add	dx, 3	;@102D2
	shr	dx, 2	;@102D5
	add	dx, ax	;@102D8
	mov	bx, 38FCh	;@102DA
@@1:	mov	cx, word ptr [bx]	;@102DD
@@2:	mov	di, cx	;@102DF
	jcxz	@@5	;@102E1
	mov	si, cx	;@102E3
	rol	si, 2	;@102E5
	mov	bp, si	;@102E8
	and	bp, -4	;@102EA
	and	si, 3	;@102ED
	shl	si, 1	;@102F0
	mov	si, word ptr ss:[si+38F2h]	;@102F2
	mov	es, si	;@102F7
	cmp	dx, cx	;@102F9
	jb	@@5	;@102FB
	je	@@4	;@102FD
	add	cx, word ptr es:[bp+2]	;@102FF
	cmp	cx, ax	;@10303
	je	@@3	;@10305
	mov	cx, es	;@10307
	mov	ds, cx	;@10309
	mov	bx, bp	;@1030B
	jmp	@@1	;@1030D
@@3:	xor	ch, ah	;@1030F
	and	ch, 0C0h	;@10311
	jne	@@5	;@10314
	mov	ax, di	;@10316
	mov	cx, word ptr es:[bp]	;@10318
	mov	word ptr [bx], cx	;@1031C
	jmp	@@2	;@1031E
@@4:	xor	ch, dh	;@10320
	and	ch, 0C0h	;@10322
	jne	@@5	;@10325
	add	dx, word ptr es:[bp+2]	;@10327
	mov	cx, word ptr es:[bp]	;@1032B
	mov	word ptr [bx], cx	;@1032F
	jmp	@@2	;@10331
@@5:	mov	word ptr [bx], ax	;@10333
	sub	dx, ax	;@10335
	mov	si, ax	;@10337
	rol	si, 2	;@10339
	mov	bp, si	;@1033C
	and	bp, -4	;@1033E
	and	si, 3	;@10341
	shl	si, 1	;@10344
	mov	si, word ptr ss:[si+38F2h]	;@10346
	mov	es, si	;@1034B
	mov	word ptr es:[bp+2], dx	;@1034D
	mov	word ptr es:[bp], di	;@10351
	pop	ds	;@10355
	pop	es	;@10356
	pop	bp	;@10357
	pop	di	;@10358
	pop	si	;@10359
	pop	dx	;@1035A
	pop	cx	;@1035B
	pop	bx	;@1035C
	pop	ax	;@1035D
	retf	;@1035E
L1035F:	push	bx	;@1035F
	mov	bx, ax	;@10360
	rol	bx, 2	;@10362
	mov	di, bx	;@10365
	and	di, -4	;@10367
	and	bx, 3	;@1036A
	shl	bx, 1	;@1036D
	mov	es, word ptr [bx+38F2h]	;@1036F
	pop	bx	;@10373
	retf	;@10374
L10375:	push	bx	;@10375
	push	cx	;@10376
	xor	cx, cx	;@10377
	mov	bx, 38F2h	;@10379
	mov	ax, es	;@1037C
@@1:	cmp	ax, word ptr [bx]	;@1037E
	je	@@2	;@10380
	add	bx, 2	;@10382
	inc	cx	;@10385
	jmp	@@1	;@10386
@@2:	mov	ax, cx	;@10388
	or	ax, di	;@1038A
	ror	ax, 2	;@1038C
	pop	cx	;@1038F
	pop	bx	;@10390
	retf	;@10391
	db	0CBh, 0	;@10392
L10394:	mov	word ptr ds:[3904h], 0	;@10394
	retf	;@1039A
L1039B:	mov	dx, word ptr ds:[3904h]	;@1039B
	and	dx, dx	;@1039F
	je	@@1	;@103A1
	mov	word ptr ds:[3904h], 0	;@103A3
	mov	ax, word ptr ds:[3902h]	;@103A9
	push	cs	;@103AC
	call	L1015C	;@103AD
	clc	;@103B0
	retf	;@103B1
@@1:	stc	;@103B2
	retf	;@103B3
L103B4:	mov	word ptr ds:[3908h], di	;@103B4
	mov	word ptr ds:[3906h], bx	;@103B8
	xor	ax, ax	;@103BC
	mov	cx, 3Bh	;@103BE
	push	ds	;@103C1
	pop	es	;@103C2
	mov	di, 397Ah	;@103C3
	rep stosb	;@103C6
	mov	word ptr ds:[3994h], 3Eh	;@103C8
	mov	word ptr ds:[3996h], 84h	;@103CE
	mov	byte ptr ds:[39B1h], 1	;@103D4
	mov	word ptr ds:[39B5h], 8	;@103D9
	call	L10465	;@103DF
	push	cs	;@103E2
	call	L119A0	;@103E3
	jae	@@1	;@103E6
	jmp	L105CA	;@103E8
@@1:	mov	word ptr ds:[3986h], bx	;@103EB
	mov	word ptr ds:[397Ah], 0	;@103EF
	mov	byte ptr ds:[374h], 4	;@103F5
	mov	byte ptr ds:[380h], 60h	;@103FA
	cmp	byte ptr ds:[38CDh], 0	;@103FF
	je	@@2	;@10404
	add	byte ptr ds:[374h], 4	;@10406
	sub	byte ptr ds:[380h], 4	;@1040B
@@2:	mov	si, 34Ah	;@10410
	call	L1049F	;@10413
	mov	si, 364h	;@10416
	call	L1049F	;@10419
	mov	ax, word ptr ds:[3940h]	;@1041C
	push	cs	;@1041F
	call	L101E0	;@10420
	mov	di, bp	;@10423
	add	di, 6	;@10425
	mov	si, word ptr ds:[3906h]	;@10428
	call	L1090B	;@1042C
	mov	al, 20h	;@1042F
	mov	cx, 8	;@10431
	rep stosb	;@10434
	call	L10958	;@10436
	mov	al, 20h	;@10439
	stosb	;@1043B
	call	L10971	;@1043C
	sub	di, bp	;@1043F
	sub	di, 6	;@10441
	mov	word ptr es:[bp+2], di	;@10444
	mov	ax, word ptr ds:[394Ah]	;@10448
	push	cs	;@1044B
	call	L101E0	;@1044C
	mov	di, bp	;@1044F
	add	di, 6	;@10451
	mov	si, word ptr ds:[3908h]	;@10454
	call	L1090B	;@10458
	sub	di, bp	;@1045B
	sub	di, 6	;@1045D
	mov	word ptr es:[bp+2], di	;@10460
	retf	;@10464
L10465:	push	cs	;@10465
	call	L10079	;@10466
	cmp	ax, 800h	;@10469
	jae	@@1	;@1046C
	cmp	ax, 40h	;@1046E
	jae	@@2	;@10471
	mov	ax, 40h	;@10473
	jmp	short @@2	;@10476
@@1:	mov	ax, 800h	;@10478
@@2:	mov	cx, ax	;@1047B
	push	cs	;@1047D
	call	L10039	;@1047E
	mov	word ptr ds:[397Ch], ax	;@10481
	mov	es, ax	;@10484
	xor	ax, ax	;@10486
	xor	di, di	;@10488
	mov	word ptr ds:[3982h], cx	;@1048A
	shl	cx, 1	;@1048E
	shl	cx, 1	;@10490
	shl	cx, 1	;@10492
	push	cx	;@10494
	shl	cx, 1	;@10495
	mov	word ptr ds:[397Eh], cx	;@10497
	pop	cx	;@1049B
	rep stosw	;@1049C
	ret	;@1049E
L1049F:	mov	bx, word ptr [si]	;@1049F
	cmp	bx, -1	;@104A1
	je	@@1	;@104A4
	xor	ah, ah	;@104A6
	mov	al, byte ptr [si+4]	;@104A8
	mov	word ptr [bx+6], ax	;@104AB
	mov	al, byte ptr [si+5]	;@104AE
	mov	word ptr [bx+4], ax	;@104B1
	mov	ax, word ptr [si+2]	;@104B4
	mov	word ptr [bx+8], ax	;@104B7
	push	si	;@104BA
	call	L104F6	;@104BB
	pop	si	;@104BE
	mov	word ptr [bx], ax	;@104BF
	mov	word ptr [bx+2], ax	;@104C1
	add	si, 6	;@104C4
	jmp	L1049F	;@104C7
@@1:	ret	;@104C9
L104CA:	mov	bx, word ptr [si]	;@104CA
	cmp	bx, -1	;@104CC
	je	@@3	;@104CF
	mov	cx, word ptr [bx]	;@104D1
@@1:	jcxz	@@2	;@104D3
	mov	ax, cx	;@104D5
	push	cs	;@104D7
	call	L101E0	;@104D8
	push	word ptr es:[bp]	;@104DB
	mov	dx, word ptr [bx+8]	;@104DF
	add	dx, 15h	;@104E2
	mov	cl, 4	;@104E5
	shr	dx, cl	;@104E7
	push	cs	;@104E9
	call	L1015C	;@104EA
	pop	cx	;@104ED
	jmp	@@1	;@104EE
@@2:	add	si, 6	;@104F0
	jmp	L104CA	;@104F3
@@3:	ret	;@104F5
L104F6:	mov	ax, word ptr [bx+8]	;@104F6
	add	ax, 15h	;@104F9
	mov	cl, 4	;@104FC
	shr	ax, cl	;@104FE
	mov	cx, ax	;@10500
	push	cs	;@10502
	call	L100B0	;@10503
	push	cs	;@10506
	call	L101E0	;@10507
	xor	cx, cx	;@1050A
	mov	word ptr es:[bp], cx	;@1050C
	mov	word ptr es:[bp+2], cx	;@10510
	mov	cx, bp	;@10514
	add	cx, 6	;@10516
	mov	word ptr es:[bp+4], cx	;@10519
	ret	;@1051D
L1051E:	mov	ax, word ptr ds:[397Ch]	;@1051E
	and	ax, ax	;@10521
	je	@@1	;@10523
	mov	dx, word ptr ds:[3982h]	;@10525
	push	cs	;@10529
	call	L10064	;@1052A
	mov	word ptr ds:[397Ch], 0	;@1052D
@@1:	mov	bx, word ptr ds:[3986h]	;@10533
	and	bx, bx	;@10537
	jne	@@2	;@10539
	retf	;@1053B
@@2:	push	cs	;@1053C
	call	L119AC	;@1053D
	mov	word ptr ds:[3986h], 0	;@10540
	retf	;@10546
L10547:	call	L10657	;@10547
	mov	si, 364h	;@1054A
	call	L104CA	;@1054D
	mov	bx, 395Ch	;@10550
	call	L10C8E	;@10553
	test	word ptr ds:[51B4h], 80h	;@10556
	je	@@2	;@1055C
	mov	si, 38Ah	;@1055E
	call	L1049F	;@10561
	call	L10C0E	;@10564
	mov	si, 560h	;@10567
	call	@@4	;@1056A
	test	word ptr ds:[51B4h], 400h	;@1056D
	jne	@@1	;@10573
	and	word ptr ds:[51B4h], 0FCFFh	;@10575
@@1:	and	word ptr ds:[51B4h], -41h	;@1057B
	call	L10F88	;@10580
	call	L10657	;@10583
	mov	si, 38Ah	;@10586
	call	L104CA	;@10589
@@2:	mov	ax, word ptr ds:[3996h]	;@1058C
	mov	byte ptr ds:[3A2h], al	;@1058F
	mov	si, 39Eh	;@10592
	call	L1049F	;@10595
	mov	si, 56Dh	;@10598
	call	@@4	;@1059B
	call	L11614	;@1059E
	cmp	byte ptr ds:[39B4h], 0	;@105A1
	je	@@3	;@105A6
	call	L10657	;@105A8
@@3:	mov	si, 39Eh	;@105AB
	call	L104CA	;@105AE
	mov	si, 34Ah	;@105B1
	call	L104CA	;@105B4
	push	cs	;@105B7
	call	L1051E	;@105B8
	jb	L105CA	;@105BB
	retf	;@105BD
@@4:	mov	bx, 3948h	;@105BE
	call	L10C6C	;@105C1
	call	L1090B	;@105C4
	jmp	L10C78	;@105C7
L105CA:	mov	byte ptr ds:[38C8h], 7	;@105CA
	stc	;@105CF
	mov	sp, word ptr ds:[38ACh]	;@105D0
	retf	;@105D4
L105D5:	push	si	;@105D5
	push	dx	;@105D6
	call	L10465	;@105D7
	pop	dx	;@105DA
	push	cs	;@105DB
	call	L119A0	;@105DC
	pop	si	;@105DF
	jb	L105F8	;@105E0
	mov	word ptr ds:[3986h], bx	;@105E2
	xor	ax, ax	;@105E6
	mov	word ptr ds:[397Ah], ax	;@105E8
	mov	word ptr ds:[3984h], ax	;@105EB
	call	L11656	;@105EE
	push	cs	;@105F1
	call	L1051E	;@105F2
	jb	L105F8	;@105F5
	retf	;@105F7
L105F8:	mov	byte ptr ds:[38C8h], 0Dh	;@105F8
	stc	;@105FD
	mov	sp, word ptr ds:[38ACh]	;@105FE
	retf	;@10602
L10603:	mov	byte ptr ds:[3996h], cl	;@10603
	call	L10BEC	;@10607
	retf	;@1060A
L1060B:	mov	byte ptr ds:[3994h], cl	;@1060B
	retf	;@1060F
L10610:	mov	bx, 3952h	;@10610
L10613:	cmp	cx, 100h	;@10613
	jb	@@1	;@10617
	mov	cx, 100h	;@10619
@@1:	mov	si, di	;@1061C
	push	es	;@1061E
	call	L10C6C	;@1061F
	pop	ds	;@10622
	rep movsb	;@10623
	push	ss	;@10625
	pop	ds	;@10626
	call	L10C78	;@10627
	retf	;@1062A
L1062B:	mov	bx, 395Ch	;@1062B
	jmp	L10613	;@1062E
L10630:	inc	word ptr ds:[398Ah]	;@10630
	mov	word ptr ds:[3988h], 0	;@10634
L1063A:	cmp	byte ptr ds:[39B1h], 1	;@1063A
	je	@@1	;@1063F
	call	L10645	;@10641
@@1:	retf	;@10644
L10645:	mov	cx, 2	;@10645
	call	L10D01	;@10648
	mov	al, 0Ch	;@1064B
	stosb	;@1064D
	call	L10CF1	;@1064E
	mov	byte ptr ds:[39B1h], 1	;@10651
	ret	;@10656
L10657:	cmp	byte ptr ds:[39B1h], 0	;@10657
	jne	@@1	;@1065C
	call	L10645	;@1065E
@@1:	jmp	L10D49	;@10661
L10664:	mov	si, bx	;@10664
	mov	bx, 3934h	;@10666
	mov	cx, word ptr [bx+8]	;@10669
	call	L10C6C	;@1066C
	call	L10914	;@1066F
	call	L10C78	;@10672
L10675:	mov	ax, word ptr es:[bp]	;@10675
	and	ax, ax	;@10679
	jne	@@1	;@1067B
	push	es	;@1067D
	push	bp	;@1067E
	call	L104F6	;@1067F
	pop	bp	;@10682
	pop	es	;@10683
	mov	word ptr es:[bp], ax	;@10684
@@1:	mov	word ptr [bx+2], ax	;@10688
	retf	;@1068B
L1068C:	mov	word ptr ds:[3990h], ax	;@1068C
	mov	word ptr ds:[3992h], dx	;@1068F
	mov	bx, 3920h	;@10693
	call	L10C6C	;@10696
	cmp	word ptr es:[bp+2], 0	;@10699
	jne	@@1	;@1069E
	mov	si, 3990h	;@106A0
	call	L10DCC	;@106A3
	call	L10C78	;@106A6
@@1:	retf	;@106A9
L106AA:	retf	;@106AA
L106AB:	mov	bx, 3970h	;@106AB
	call	L10C6C	;@106AE
	push	es	;@106B1
	push	bp	;@106B2
	call	far ptr L14F20	;@106B3
	pop	bp	;@106B8
	pop	es	;@106B9
	call	L10C78	;@106BA
	jmp	L10675	;@106BD
L106BF:	mov	bx, 390Ch	;@106BF
	push	ax	;@106C2
	call	L10C6C	;@106C3
	pop	ax	;@106C6
	or	ax, ax	;@106C7
	je	@@2	;@106C9
	mov	cx, ax	;@106CB
	call	L10D6A	;@106CD
@@1:	call	L10C78	;@106D0
	retf	;@106D3
@@2:	mov	al, 20h	;@106D4
	stosb	;@106D6
	jmp	@@1	;@106D7
L106D9:	test	word ptr ds:[38B6h], 8000h	;@106D9
	jne	L106E6	;@106DF
L106E1:	mov	byte ptr ds:[39B2h], 1	;@106E1
L106E6:	retf	;@106E6
L106E7:	mov	bx, 392Ah	;@106E7
	call	L10C6C	;@106EA
	call	L10DCC	;@106ED
	call	@@1	;@106F0
	call	L10C81	;@106F3
	retf	;@106F6
@@1:	mov	si, 3A6h	;@106F7
@@2:	cmp	dl, 0	;@106FA
	je	@@3	;@106FD
	mov	al, byte ptr [si]	;@106FF
	mov	ah, 0	;@10701
	inc	ax	;@10703
	add	si, ax	;@10704
	dec	dl	;@10706
	jmp	@@2	;@10708
@@3:	lodsb	;@1070A
	mov	cl, al	;@1070B
	mov	ch, 0	;@1070D
	rep movsb	;@1070F
	mov	al, 20h	;@10711
	stosb	;@10713
	ret	;@10714
L10715:	mov	bx, 392Ah	;@10715
	call	L10C6C	;@10718
	mov	ax, 3F3Fh	;@1071B
	rep stosw	;@1071E
	mov	al, 20h	;@10720
	stosb	;@10722
	call	L10C81	;@10723
	retf	;@10726
L10727:	mov	word ptr ds:[3990h], ax	;@10727
	mov	bx, 392Ah	;@1072A
	call	L10C6C	;@1072D
	mov	si, 3990h	;@10730
	mov	cx, 1	;@10733
	call	L10DCC	;@10736
	mov	ax, 203Ah	;@10739
	stosw	;@1073C
	call	L10C81	;@1073D
	retf	;@10740
L10741:	mov	word ptr ds:[3990h], ax	;@10741
	mov	bx, 392Ah	;@10744
	call	L10C6C	;@10747
	mov	si, 3990h	;@1074A
	mov	cx, 1	;@1074D
	call	L10DCC	;@10750
	mov	ax, 207Ch	;@10753
	stosw	;@10756
	call	L10C81	;@10757
	retf	;@1075A
L1075B:	mov	word ptr ds:[3990h], ax	;@1075B
	mov	bx, 392Ah	;@1075E
	call	L10C6C	;@10761
	mov	si, 3990h	;@10764
	mov	cx, 1	;@10767
	call	L10DCC	;@1076A
	mov	ax, 203Eh	;@1076D
	stosw	;@10770
	call	L10C81	;@10771
	retf	;@10774
L10775:	mov	bx, 392Ah	;@10775
	push	ax	;@10778
	call	L10C6C	;@10779
	pop	ax	;@1077C
	stosb	;@1077D
	call	L10C81	;@1077E
	retf	;@10781
L10782:	push	ds	;@10782
	mov	si, di	;@10783
	push	es	;@10785
	push	cx	;@10786
	mov	bx, 392Ah	;@10787
	call	L10C6C	;@1078A
	pop	cx	;@1078D
	pop	ds	;@1078E
	rep movsb	;@1078F
	pop	ds	;@10791
	call	L10C81	;@10792
	retf	;@10795
L10796:	mov	bx, 392Ah	;@10796
	push	ax	;@10799
	call	L10C6C	;@1079A
	pop	ax	;@1079D
	cmp	cl, 0FFh	;@1079E
	jne	@@1	;@107A1
	not	ax	;@107A3
	not	dx	;@107A5
	add	ax, 1	;@107A7
	adc	dx, 0	;@107AA
	push	ax	;@107AD
	mov	al, 2Dh	;@107AE
	stosb	;@107B0
	pop	ax	;@107B1
@@1:	mov	word ptr ds:[3990h], ax	;@107B2
	mov	cx, 2	;@107B5
	or	dx, dx	;@107B8
	je	@@2	;@107BA
	mov	word ptr ds:[3992h], dx	;@107BC
	add	cx, cx	;@107C0
@@2:	mov	si, 3990h	;@107C2
	call	L10DCC	;@107C5
	call	L10C81	;@107C8
	retf	;@107CB
L107CC:	mov	word ptr ds:[3990h], ax	;@107CC
	mov	word ptr ds:[3992h], dx	;@107CF
	mov	bx, 392Ah	;@107D3
	call	L10C6C	;@107D6
	mov	si, 3990h	;@107D9
	mov	cx, 4	;@107DC
	call	L10DBF	;@107DF
	mov	ax, 282Ah	;@107E2
	stosw	;@107E5
	call	L10C81	;@107E6
	retf	;@107E9
L107EA:	mov	bx, 392Ah	;@107EA
	call	L10C6C	;@107ED
	dec	di	;@107F0
	mov	ax, 2029h	;@107F1
	stosw	;@107F4
	call	L10C81	;@107F5
	retf	;@107F8
L107F9:	call	L109C5	;@107F9
	retf	;@107FC
L107FD:	test	word ptr ds:[51B4h], 400h	;@107FD
	je	@@1	;@10803
	mov	bx, ax	;@10805
	call	L10DF3	;@10807
	mov	byte ptr es:[bp+6], 1	;@1080A
	call	L10E41	;@1080F
@@1:	retf	;@10812
L10813:	test	word ptr ds:[51B4h], 400h	;@10813
	je	@@1	;@10819
	call	L10DF3	;@1081B
	call	L10E41	;@1081E
@@1:	retf	;@10821
L10822:	mov	bx, ax	;@10822
	call	L10DF3	;@10824
	mov	byte ptr es:[bp+6], 2	;@10827
	call	L10E41	;@1082C
	retf	;@1082F
L10830:	mov	bx, 390Ch	;@10830
L10833:	xor	ch, ch	;@10833
	mov	word ptr [bx+6], cx	;@10835
	retf	;@10838
L10839:	mov	bx, 3916h	;@10839
	jmp	L10833	;@1083C
L1083E:	mov	bx, 3920h	;@1083E
	jmp	L10833	;@10841
L10843:	mov	bx, 392Ah	;@10843
	jmp	L10833	;@10846
L10848:	mov	bx, 3934h	;@10848
	jmp	L10833	;@1084B
L1084D:	jcxz	@@1	;@1084D
	cmp	cx, 10h	;@1084F
	jb	@@2	;@10852
@@1:	mov	cx, 8	;@10854
@@2:	mov	word ptr ds:[39B5h], cx	;@10857
	retf	;@1085B
L1085C:	cmp	byte ptr ds:[39B1h], 0	;@1085C
	je	@@1	;@10861
	push	si	;@10863
	mov	byte ptr ds:[39B1h], 0	;@10864
	mov	word ptr ds:[398Ch], 0	;@10869
	inc	word ptr ds:[3988h]	;@1086F
	mov	cx, word ptr ds:[3944h]	;@10873
	add	cx, 14h	;@10877
	call	L10CF6	;@1087A
	mov	bx, 393Eh	;@1087D
	call	@@2	;@10880
	mov	si, 44Eh	;@10883
	call	L1090B	;@10886
	call	L1097B	;@10889
	call	L10CAF	;@1088C
	mov	cx, word ptr ds:[394Eh]	;@1088F
	call	L10CF6	;@10893
	mov	bx, 3948h	;@10896
	call	@@3	;@10899
	call	L10CAF	;@1089C
	push	ss	;@1089F
	pop	es	;@108A0
	mov	di, 51C7h	;@108A1
	mov	cx, word ptr ds:[51B8h]	;@108A4
	push	cs	;@108A8
	call	L10610	;@108A9
	mov	cx, word ptr ds:[3958h]	;@108AC
	call	L10CF6	;@108B0
	mov	bx, 3952h	;@108B3
	call	@@3	;@108B6
	call	L10CAF	;@108B9
	mov	cx, word ptr ds:[3962h]	;@108BC
	call	L10CF6	;@108C0
	mov	bx, 395Ch	;@108C3
	call	@@3	;@108C6
	call	L10CAF	;@108C9
	xor	cx, cx	;@108CC
	call	L10CF6	;@108CE
	call	L10CAF	;@108D1
	add	word ptr ds:[398Ch], 5	;@108D4
	pop	si	;@108D9
@@1:	ret	;@108DA
@@2:	call	@@3	;@108DB
	mov	cx, dx	;@108DE
	mov	al, 20h	;@108E0
	rep stosb	;@108E2
	ret	;@108E4
@@3:	push	ds	;@108E5
	mov	dx, word ptr [bx+6]	;@108E6
	mov	ax, word ptr [bx]	;@108E9
	push	es	;@108EB
	push	cs	;@108EC
	call	L101E0	;@108ED
	push	es	;@108F0
	pop	ds	;@108F1
	pop	es	;@108F2
	mov	cx, word ptr ds:[bp+2]	;@108F3
	jcxz	@@5	;@108F7
	mov	si, word ptr ds:[bp+4]	;@108F9
	cmp	cx, dx	;@108FD
	jb	@@4	;@108FF
	mov	cx, word ptr ss:[bx+6]	;@10901
@@4:	sub	dx, cx	;@10905
	rep movsb	;@10907
@@5:	pop	ds	;@10909
	ret	;@1090A
L1090B:	lodsb	;@1090B
	or	al, al	;@1090C
	je	@@1	;@1090E
	stosb	;@10910
	jmp	L1090B	;@10911
@@1:	ret	;@10913
L10914:	push	bx	;@10914
	mov	dx, di	;@10915
	mov	bx, cx	;@10917
@@1:	lodsb	;@10919
	cmp	al, 9	;@1091A
	je	@@2	;@1091C
	cmp	al, 0Ah	;@1091E
	je	@@1	;@10920
	cmp	al, 1Ah	;@10922
	je	@@1	;@10924
	cmp	al, 0Dh	;@10926
	je	@@4	;@10928
	mov	cx, di	;@1092A
	sub	cx, dx	;@1092C
	cmp	cx, bx	;@1092E
	jae	@@4	;@10930
	stosb	;@10932
	jmp	@@1	;@10933
@@2:	mov	cx, di	;@10935
	sub	cx, dx	;@10937
	mov	ax, word ptr ds:[39B5h]	;@10939
@@3:	sub	cx, ax	;@1093C
	jae	@@3	;@1093E
	add	cx, ax	;@10940
	neg	cx	;@10942
	add	cx, ax	;@10944
	mov	ax, di	;@10946
	sub	ax, dx	;@10948
	add	ax, cx	;@1094A
	cmp	ax, bx	;@1094C
	ja	@@4	;@1094E
	mov	al, 20h	;@10950
	rep stosb	;@10952
	jmp	@@1	;@10954
@@4:	pop	bx	;@10956
	ret	;@10957
L10958:	push	es	;@10958
	push	di	;@10959
	push	cs	;@1095A
	call	L11962	;@1095B
	pop	di	;@1095E
	pop	es	;@1095F
L10960:	push	cx	;@10960
	mov	cl, ch	;@10961
	call	L10DA3	;@10963
	stosb	;@10966
	pop	cx	;@10967
	call	L10DA3	;@10968
	stosb	;@1096B
	mov	cl, dh	;@1096C
	jmp	L10DA3	;@1096E
L10971:	push	es	;@10971
	push	di	;@10972
	push	cs	;@10973
	call	L11959	;@10974
	pop	di	;@10977
	pop	es	;@10978
	jmp	L10960	;@10979
L1097B:	mov	cx, word ptr ds:[398Ah]	;@1097B
	jcxz	@@1	;@1097F
	call	L10D6A	;@10981
	mov	al, 2Dh	;@10984
	stosb	;@10986
@@1:	mov	cx, word ptr ds:[3988h]	;@10987
	jmp	L10D6A	;@1098B
L1098E:	cmp	byte ptr ds:[39B2h], 0	;@1098E
	jne	@@2	;@10993
	call	L1085C	;@10995
	push	si	;@10998
	call	si	;@10999
	pop	si	;@1099B
	inc	word ptr ds:[398Ch]	;@1099C
	mov	ax, word ptr ds:[398Ch]	;@109A0
	cmp	ax, word ptr ds:[3994h]	;@109A3
	jb	@@1	;@109A7
	push	si	;@109A9
	call	L10645	;@109AA
	pop	si	;@109AD
@@1:	test	word ptr ds:[51B4h], 40h	;@109AE
	jne	@@2	;@109B4
	cmp	byte ptr ds:[39B3h], 0	;@109B6
	je	@@2	;@109BB
	mov	byte ptr ds:[39B3h], 0	;@109BD
	jmp	L1098E	;@109C2
@@2:	ret	;@109C4
L109C5:	mov	ax, word ptr ds:[3934h]	;@109C5
	mov	word ptr ds:[3936h], ax	;@109C8
	mov	ax, word ptr ds:[3970h]	;@109CB
	mov	word ptr ds:[3972h], ax	;@109CE
	mov	ax, word ptr ds:[392Ah]	;@109D1
	push	cs	;@109D4
	call	L101E0	;@109D5
	mov	ax, bp	;@109D8
	add	ax, 6	;@109DA
	mov	word ptr es:[bp+4], ax	;@109DD
	mov	si, 0ABCh	;@109E1
	call	L1098E	;@109E4
	mov	ax, word ptr ds:[3970h]	;@109E7
	push	cs	;@109EA
	call	L101E0	;@109EB
	cmp	word ptr es:[bp+2], 0	;@109EE
	je	@@1	;@109F3
	mov	si, 0AA5h	;@109F5
	call	L1098E	;@109F8
	mov	bx, 3970h	;@109FB
	call	L10C8E	;@109FE
@@1:	mov	byte ptr ds:[39B2h], 0	;@10A01
	mov	bx, 390Ch	;@10A06
	call	L10C8E	;@10A09
	mov	bx, 3916h	;@10A0C
	call	L10C8E	;@10A0F
	mov	bx, 3920h	;@10A12
	call	L10C8E	;@10A15
	mov	bx, 392Ah	;@10A18
	call	L10C8E	;@10A1B
	mov	bx, 3934h	;@10A1E
	call	L10C8E	;@10A21
	ret	;@10A24
	db	0A1h, 96h, 39h, 0A3h, 76h, 39h, 8Bh, 0C8h, 83h, 0C1h, 3, 0E8h	;@10A25
	db	0C3h, 2, 0BBh, 70h, 39h, 0E8h, 5Ah, 0, 0E9h, 73h, 2, 0A1h, 16h
	db	39h, 0A3h, 18h, 39h, 0BBh, 16h, 39h, 0E8h, 24h, 2, 0FFh, 6, 8Eh
	db	39h, 8Bh, 0Eh, 8Eh, 39h, 0E8h, 17h, 3, 0E8h, 22h, 2, 0E8h, 63h
	db	1, 0E8h, 9Ah, 2, 0BBh, 0Ch, 39h, 0E8h, 0CCh, 0, 0BBh, 16h, 39h
	db	0E8h, 0C6h, 0, 0BBh, 20h, 39h, 0E8h, 0C0h, 0, 0BBh, 2Ah, 39h, 0E8h
	db	0Ch, 0, 0BBh, 34h, 39h, 0E8h, 19h, 0, 0E8h, 29h, 1, 0E9h, 2Fh
	db	2
L10A80:	call	@@2	;@10A80
	cmp	word ptr [bx+6], 0	;@10A83
	je	@@1	;@10A87
	mov	cx, dx	;@10A89
	add	cx, word ptr [bx+4]	;@10A8B
	mov	al, 20h	;@10A8E
	rep stosb	;@10A90
@@1:	ret	;@10A92
@@2:	mov	ax, word ptr [bx+2]	;@10A93
	mov	dx, word ptr [bx+6]	;@10A96
	and	ax, ax	;@10A99
	je	@@4	;@10A9B
	push	es	;@10A9D
	push	cs	;@10A9E
	call	L101E0	;@10A9F
	push	es	;@10AA2
	pop	ds	;@10AA3
	pop	es	;@10AA4
	and	dx, dx	;@10AA5
	je	@@4	;@10AA7
	mov	si, word ptr ds:[bp+4]	;@10AA9
	mov	cx, word ptr ds:[bp+2]	;@10AAD
	cmp	cx, dx	;@10AB1
	ja	@@5	;@10AB3
	sub	dx, cx	;@10AB5
	rep movsb	;@10AB7
@@3:	call	@@14	;@10AB9
@@4:	push	ss	;@10ABC
	pop	ds	;@10ABD
	ret	;@10ABE
@@5:	mov	cx, dx	;@10ABF
	add	si, dx	;@10AC1
	dec	si	;@10AC3
	mov	al, byte ptr [si]	;@10AC4
	jmp	short @@7	;@10AC6
@@6:	dec	si	;@10AC8
	mov	al, byte ptr [si]	;@10AC9
	cmp	al, 2Ch	;@10ACB
	je	@@12	;@10ACD
@@7:	cmp	al, 20h	;@10ACF
	je	@@8	;@10AD1
	cmp	al, 28h	;@10AD3
	je	@@8	;@10AD5
	cmp	al, 5Bh	;@10AD7
	je	@@8	;@10AD9
	cmp	al, 2Bh	;@10ADB
	loopne	@@6	;@10ADD
	jcxz	@@13	;@10ADF
@@8:	mov	cx, si	;@10AE1
	mov	si, word ptr ds:[bp+4]	;@10AE3
	sub	cx, si	;@10AE7
	je	@@13	;@10AE9
	sub	dx, cx	;@10AEB
	mov	ax, cx	;@10AED
	rep movsb	;@10AEF
	mov	cx, word ptr ds:[bp+2]	;@10AF1
	sub	cx, ax	;@10AF5
@@9:	cmp	byte ptr [si], 20h	;@10AF7
	jne	@@10	;@10AFA
	inc	si	;@10AFC
	loop	@@9	;@10AFD
@@10:	sub	si, word ptr ds:[bp+4]	;@10AFF
	add	word ptr ds:[bp+4], si	;@10B03
	sub	word ptr ds:[bp+2], si	;@10B07
	je	@@3	;@10B0B
	mov	cx, dx	;@10B0D
	jcxz	@@11	;@10B0F
	dec	cx	;@10B11
	mov	al, 20h	;@10B12
	rep stosb	;@10B14
	mov	al, 2Bh	;@10B16
	stosb	;@10B18
	xor	dx, dx	;@10B19
@@11:	push	ss	;@10B1B
	pop	ds	;@10B1C
	mov	byte ptr ds:[39B3h], 1	;@10B1D
	ret	;@10B22
@@12:	inc	si	;@10B23
	jmp	@@8	;@10B24
@@13:	mov	cx, dx	;@10B26
	rep movsb	;@10B28
	xor	dx, dx	;@10B2A
	jmp	@@10	;@10B2C
	db	0E8h, 10h, 0, 83h, 7Fh, 6, 0, 74h, 9, 8Bh, 0CAh, 3, 4Fh, 4, 0B0h	;@10B2E
	db	20h, 0F3h, 0AAh, 0C3h, 8Bh, 47h, 2, 8Bh, 57h, 6, 23h, 0C0h, 74h
	db	29h, 6, 0Eh, 0E8h, 90h, 0F6h, 6, 1Fh, 7, 23h, 0D2h, 74h, 1Dh, 3Eh
	db	8Bh, 76h, 4, 3Eh, 8Bh, 4Eh, 2, 3Bh, 0CAh, 77h, 14h, 2Bh, 0D1h
	db	87h, 0D1h, 0B0h, 20h, 0F3h, 0AAh, 8Bh, 0CAh, 0F3h, 0A4h, 33h, 0D2h
	db	0E8h, 10h, 0, 16h, 1Fh, 0C3h, 2Bh, 0CAh, 3, 0F1h, 0C6h, 4, 2Ah
	db	8Bh, 0CAh, 0F3h, 0A4h, 0EBh, 0EBh
@@14:	mov	ax, word ptr ds:[bp]	;@10B84
	and	ax, ax	;@10B88
	je	@@15	;@10B8A
	push	es	;@10B8C
	push	cs	;@10B8D
	call	L101E0	;@10B8E
	push	es	;@10B91
	pop	ds	;@10B92
	pop	es	;@10B93
	cmp	word ptr ds:[bp+2], 0	;@10B94
	je	@@14	;@10B99
	mov	byte ptr ss:[39B3h], 1	;@10B9B
@@15:	mov	word ptr ss:[bx+2], ax	;@10BA1
	ret	;@10BA5
L10BA6:	mov	cx, di	;@10BA6
	jcxz	@@1	;@10BA8
	dec	di	;@10BAA
	std	;@10BAB
	mov	al, 20h	;@10BAC
	repe scasb	;@10BAE
	cld	;@10BB0
	inc	di	;@10BB1
	inc	di	;@10BB2
@@1:	ret	;@10BB3
	db	0E8h, 5, 0, 3, 0Eh, 6Ch, 39h, 0C3h	;@10BB4
L10BBC:	call	L10BC7	;@10BBC
	add	cx, word ptr ds:[393Ah]	;@10BBF
	add	cx, 3	;@10BC3
	ret	;@10BC6
L10BC7:	mov	cx, word ptr ds:[3912h]	;@10BC7
	add	cx, word ptr ds:[391Ch]	;@10BCB
	add	cx, word ptr ds:[3926h]	;@10BCF
	add	cx, word ptr ds:[3930h]	;@10BD3
	add	cx, word ptr ds:[3910h]	;@10BD7
	add	cx, word ptr ds:[391Ah]	;@10BDB
	add	cx, word ptr ds:[3924h]	;@10BDF
	add	cx, word ptr ds:[392Eh]	;@10BE3
	add	cx, word ptr ds:[3938h]	;@10BE7
	ret	;@10BEB
L10BEC:	call	L10BC7	;@10BEC
	mov	ax, word ptr ds:[3996h]	;@10BEF
	cmp	ax, 3Ch	;@10BF2
	jae	@@1	;@10BF5
	mov	ax, 4Fh	;@10BF7
@@1:	mov	word ptr ds:[3958h], ax	;@10BFA
	mov	word ptr ds:[3962h], ax	;@10BFD
	sub	ax, cx	;@10C00
	cmp	ax, 17h	;@10C02
	ja	@@2	;@10C05
	mov	ax, 17h	;@10C07
@@2:	mov	word ptr ds:[393Ah], ax	;@10C0A
	ret	;@10C0D
L10C0E:	test	word ptr ds:[51B4h], 800h	;@10C0E
	je	@@1	;@10C14
	mov	si, 3C6h	;@10C16
	jmp	short @@2	;@10C19
@@1:	mov	si, 3D8h	;@10C1B
@@2:	xor	di, di	;@10C1E
@@3:	cmp	word ptr [si+2], -1	;@10C20
	je	@@6	;@10C24
	mov	bx, 64h	;@10C26
	mov	ax, word ptr ds:[3996h]	;@10C29
	mul	bx	;@10C2C
	div	word ptr [si+2]	;@10C2E
	xor	bx, bx	;@10C31
	mov	bl, byte ptr [si+4]	;@10C33
	cmp	ax, bx	;@10C36
	ja	@@4	;@10C38
	mov	bl, byte ptr [si+5]	;@10C3A
	cmp	ax, bx	;@10C3D
	ja	@@5	;@10C3F
@@4:	mov	ax, bx	;@10C41
@@5:	mov	bx, word ptr [si]	;@10C43
	mov	word ptr [bx+6], ax	;@10C45
	add	di, ax	;@10C48
	add	si, 6	;@10C4A
	jmp	@@3	;@10C4D
@@6:	mov	cl, byte ptr [si+4]	;@10C4F
	xor	ch, ch	;@10C52
	add	di, cx	;@10C54
	mov	ax, word ptr ds:[3996h]	;@10C56
	sub	ax, di	;@10C59
	jb	@@7	;@10C5B
	mov	cl, byte ptr [si+5]	;@10C5D
	cmp	ax, cx	;@10C60
	ja	@@8	;@10C62
@@7:	mov	ax, cx	;@10C64
@@8:	mov	bx, word ptr [si]	;@10C66
	mov	word ptr [bx+6], ax	;@10C68
	ret	;@10C6B
L10C6C:	mov	ax, word ptr [bx+2]	;@10C6C
	push	cs	;@10C6F
	call	L101E0	;@10C70
	mov	di, word ptr es:[bp+4]	;@10C73
	ret	;@10C77
L10C78:	sub	di, word ptr es:[bp+4]	;@10C78
	mov	word ptr es:[bp+2], di	;@10C7C
	ret	;@10C80
L10C81:	sub	di, word ptr es:[bp+4]	;@10C81
	add	word ptr es:[bp+2], di	;@10C85
	add	word ptr es:[bp+4], di	;@10C89
	ret	;@10C8D
L10C8E:	mov	ax, word ptr [bx]	;@10C8E
	mov	word ptr [bx+2], ax	;@10C90
@@1:	push	cs	;@10C93
	call	L101E0	;@10C94
	mov	word ptr es:[bp+2], 0	;@10C97
	mov	ax, bp	;@10C9D
	add	ax, 6	;@10C9F
	mov	word ptr es:[bp+4], ax	;@10CA2
	mov	ax, word ptr es:[bp]	;@10CA6
	and	ax, ax	;@10CAA
	jne	@@1	;@10CAC
	ret	;@10CAE
L10CAF:	push	si	;@10CAF
	mov	si, word ptr ds:[3980h]	;@10CB0
	push	es	;@10CB4
	pop	ds	;@10CB5
	mov	cx, di	;@10CB6
	mov	di, si	;@10CB8
	sub	cx, si	;@10CBA
	xor	dx, dx	;@10CBC
	xor	bx, bx	;@10CBE
	jcxz	@@4	;@10CC0
@@1:	test	bl, 7	;@10CC2
	jne	@@2	;@10CC5
	and	dx, dx	;@10CC7
	je	@@2	;@10CC9
	mov	al, 9	;@10CCB
	stosb	;@10CCD
	xor	dx, dx	;@10CCE
@@2:	inc	bx	;@10CD0
	lodsb	;@10CD1
	cmp	al, 20h	;@10CD2
	je	@@3	;@10CD4
	push	cx	;@10CD6
	push	ax	;@10CD7
	mov	cx, dx	;@10CD8
	mov	al, 20h	;@10CDA
	rep stosb	;@10CDC
	pop	ax	;@10CDE
	pop	cx	;@10CDF
	xor	dx, dx	;@10CE0
	stosb	;@10CE2
	loop	@@1	;@10CE3
	jmp	short @@4	;@10CE5
@@3:	inc	dx	;@10CE7
	loop	@@1	;@10CE8
@@4:	pop	si	;@10CEA
	push	ss	;@10CEB
	pop	ds	;@10CEC
	mov	ax, 0A0Dh	;@10CED
	stosw	;@10CF0
L10CF1:	mov	word ptr ds:[397Ah], di	;@10CF1
	ret	;@10CF5
L10CF6:	add	cx, 2	;@10CF6
	call	L10D01	;@10CF9
	mov	word ptr ds:[3980h], di	;@10CFC
	ret	;@10D00
L10D01:	les	di, dword ptr ds:[397Ah]	;@10D01
	add	cx, di	;@10D05
	cmp	cx, word ptr ds:[397Eh]	;@10D07
	ja	@@1	;@10D0B
	ret	;@10D0D
@@1:	mov	ax, word ptr ds:[397Ah]	;@10D0E
	and	ax, 0F000h	;@10D11
	je	L10D49	;@10D14
	mov	cx, ax	;@10D16
	mov	ax, word ptr ds:[397Ch]	;@10D18
	xor	dx, dx	;@10D1B
	mov	bx, word ptr ds:[3986h]	;@10D1D
	push	cx	;@10D21
	push	cs	;@10D22
	call	L119BC	;@10D23
	pop	si	;@10D26
	jb	@@2	;@10D27
	xor	di, di	;@10D29
	mov	cx, word ptr ds:[397Ah]	;@10D2B
	sub	cx, si	;@10D2F
	mov	ds, word ptr ds:[397Ch]	;@10D31
	push	ds	;@10D35
	pop	es	;@10D36
	shr	cx, 1	;@10D37
	rep movsw	;@10D39
	rcl	cx, 1	;@10D3B
	rep movsb	;@10D3D
	push	ss	;@10D3F
	pop	ds	;@10D40
	mov	word ptr ds:[397Ah], di	;@10D41
	ret	;@10D45
@@2:	jmp	L105CA	;@10D46
L10D49:	mov	cx, word ptr ds:[397Ah]	;@10D49
	mov	ax, word ptr ds:[397Ch]	;@10D4D
	xor	dx, dx	;@10D50
	mov	bx, word ptr ds:[3986h]	;@10D52
	push	cs	;@10D56
	call	L119BC	;@10D57
	jb	@@1	;@10D5A
	mov	es, word ptr ds:[397Ch]	;@10D5C
	xor	di, di	;@10D60
	mov	word ptr ds:[397Ah], di	;@10D62
	ret	;@10D66
@@1:	jmp	L105CA	;@10D67
L10D6A:	push	ax	;@10D6A
	push	si	;@10D6B
	mov	ah, 30h	;@10D6C
	mov	si, 2710h	;@10D6E
	call	L10D91	;@10D71
	mov	si, 3E8h	;@10D74
	call	L10D91	;@10D77
	mov	si, 64h	;@10D7A
	call	L10D91	;@10D7D
	mov	si, 0Ah	;@10D80
	call	L10D91	;@10D83
	mov	si, 1	;@10D86
	mov	ah, 0FFh	;@10D89
	call	L10D91	;@10D8B
	pop	si	;@10D8E
	pop	ax	;@10D8F
	ret	;@10D90
L10D91:	mov	al, 2Fh	;@10D91
@@1:	inc	al	;@10D93
	sub	cx, si	;@10D95
	jae	@@1	;@10D97
	add	cx, si	;@10D99
	cmp	al, ah	;@10D9B
	je	@@2	;@10D9D
	mov	ah, 0FFh	;@10D9F
	stosb	;@10DA1
@@2:	ret	;@10DA2
L10DA3:	push	ax	;@10DA3
	push	si	;@10DA4
	mov	ah, 30h	;@10DA5
	cmp	cl, 63h	;@10DA7
	ja	@@1	;@10DAA
	mov	ch, 0	;@10DAC
	mov	ah, 0FFh	;@10DAE
	mov	si, 0Ah	;@10DB0
	call	L10D91	;@10DB3
	mov	si, 1	;@10DB6
	call	L10D91	;@10DB9
@@1:	pop	si	;@10DBC
	pop	ax	;@10DBD
	ret	;@10DBE
L10DBF:	add	si, cx	;@10DBF
	dec	si	;@10DC1
	std	;@10DC2
@@1:	lodsb	;@10DC3
	or	al, al	;@10DC4
	loope	@@1	;@10DC6
	inc	cx	;@10DC8
	inc	si	;@10DC9
	jmp	short L10DD0	;@10DCA
L10DCC:	add	si, cx	;@10DCC
	dec	si	;@10DCE
L10DCF:	std	;@10DCF
L10DD0:	lodsb	;@10DD0
	cld	;@10DD1
	push	ax	;@10DD2
	shr	al, 1	;@10DD3
	shr	al, 1	;@10DD5
	shr	al, 1	;@10DD7
	shr	al, 1	;@10DD9
	call	@@1	;@10DDB
	pop	ax	;@10DDE
	call	@@1	;@10DDF
	loop	L10DCF	;@10DE2
	ret	;@10DE4
@@1:	and	al, 0Fh	;@10DE5
	cmp	al, 0Ah	;@10DE7
	jae	@@2	;@10DE9
	add	al, 30h	;@10DEB
	stosb	;@10DED
	ret	;@10DEE
@@2:	add	al, 37h	;@10DEF
	stosb	;@10DF1
	ret	;@10DF2
L10DF3:	cmp	word ptr ds:[3904h], 0	;@10DF3
	jne	@@1	;@10DF8
	mov	ax, 1	;@10DFA
	mov	cx, 100h	;@10DFD
	push	cs	;@10E00
	call	L100B0	;@10E01
	mov	word ptr ds:[3902h], ax	;@10E04
	mov	word ptr ds:[3904h], cx	;@10E07
@@1:	mov	ax, word ptr ds:[3902h]	;@10E0B
	push	cs	;@10E0E
	call	L101E0	;@10E0F
	mov	ax, 1	;@10E12
	add	word ptr ds:[3902h], ax	;@10E15
	sub	word ptr ds:[3904h], ax	;@10E19
	xor	ax, ax	;@10E1D
	mov	di, bp	;@10E1F
	add	di, ax	;@10E21
	stosw	;@10E23
	stosw	;@10E24
	stosw	;@10E25
	stosw	;@10E26
	mov	word ptr es:[bp+8], bx	;@10E27
	mov	ax, word ptr ds:[398Eh]	;@10E2B
	mov	word ptr es:[bp+0Eh], ax	;@10E2E
	mov	ax, word ptr ds:[517Ah]	;@10E32
	mov	word ptr es:[bp+0Ah], ax	;@10E35
	mov	ax, word ptr ds:[516Eh]	;@10E39
	mov	word ptr es:[bp+0Ch], ax	;@10E3C
	ret	;@10E40
L10E41:	push	cs	;@10E41
	call	L101F7	;@10E42
	mov	bx, ax	;@10E45
	mov	cx, word ptr ds:[39AEh]	;@10E47
	jcxz	@@9	;@10E4B
@@1:	mov	dx, word ptr es:[bp+8]	;@10E4D
	mov	si, word ptr es:[bp+6]	;@10E51
	push	es	;@10E55
	push	bp	;@10E56
	mov	ax, cx	;@10E57
	push	cs	;@10E59
	call	L101E0	;@10E5A
	mov	ax, word ptr es:[bp+8]	;@10E5D
	cmp	ax, dx	;@10E61
	je	@@5	;@10E63
	push	es	;@10E65
	push	bp	;@10E66
	push	bx	;@10E67
	call	L10ECA	;@10E68
	pop	bx	;@10E6B
	pop	bp	;@10E6C
	pop	es	;@10E6D
	ja	@@3	;@10E6E
	mov	cx, word ptr es:[bp]	;@10E70
	jcxz	@@2	;@10E74
	pop	bp	;@10E76
	pop	es	;@10E77
	jmp	@@1	;@10E78
@@2:	pop	ax	;@10E7A
	pop	ax	;@10E7B
	mov	word ptr es:[bp], bx	;@10E7C
	ret	;@10E80
@@3:	mov	cx, word ptr es:[bp+2]	;@10E81
	jcxz	@@4	;@10E85
	pop	bp	;@10E87
	pop	es	;@10E88
	jmp	@@1	;@10E89
@@4:	pop	ax	;@10E8B
	pop	ax	;@10E8C
	mov	word ptr es:[bp+2], bx	;@10E8D
	ret	;@10E91
@@5:	pop	ax	;@10E92
	pop	ax	;@10E93
	test	byte ptr es:[bp+6], 2	;@10E94
	jne	@@8	;@10E99
	and	si, 2	;@10E9B
	or	word ptr es:[bp+6], si	;@10E9E
@@6:	mov	cx, word ptr es:[bp+4]	;@10EA2
	jcxz	@@7	;@10EA6
	mov	ax, cx	;@10EA8
	push	cs	;@10EAA
	call	L101E0	;@10EAB
	jmp	@@6	;@10EAE
@@7:	mov	word ptr es:[bp+4], bx	;@10EB0
	ret	;@10EB4
@@8:	test	si, 1	;@10EB5
	jne	@@6	;@10EB9
	mov	ax, bx	;@10EBB
	mov	dx, 1	;@10EBD
	push	cs	;@10EC0
	call	L1015C	;@10EC1
	ret	;@10EC4
@@9:	mov	word ptr ds:[39AEh], bx	;@10EC5
	ret	;@10EC9
L10ECA:	push	cs	;@10ECA
	call	L101E0	;@10ECB
	call	far ptr L0003E	;@10ECE
	push	es	;@10ED3
	mov	si, di	;@10ED4
	mov	bx, cx	;@10ED6
	mov	ax, dx	;@10ED8
	push	cs	;@10EDA
	call	L101E0	;@10EDB
	call	far ptr L0003E	;@10EDE
	pop	ds	;@10EE3
	cmp	cx, bx	;@10EE4
	mov	bh, cl	;@10EE6
	jb	@@1	;@10EE8
	mov	cl, bl	;@10EEA
@@1:	repe cmpsb	;@10EEC
	je	@@2	;@10EEE
	push	ss	;@10EF0
	pop	ds	;@10EF1
	ret	;@10EF2
@@2:	cmp	bl, bh	;@10EF3
	push	ss	;@10EF5
	pop	ds	;@10EF6
	ret	;@10EF7
L10EF8:	mov	si, 8Eh	;@10EF8
	call	far ptr L00076	;@10EFB
	ret	;@10F00
L10F01:	cmp	ax, word ptr ds:[5888h]	;@10F01
	je	@@2	;@10F05
	mov	bx, ax	;@10F07
	call	far ptr L00046	;@10F09
	and	al, 3Fh	;@10F0E
	je	@@2	;@10F10
	test	al, 20h	;@10F12
	jne	@@1	;@10F14
	cmp	al, 0Bh	;@10F16
	je	@@2	;@10F18
	cmp	al, 7	;@10F1A
	je	@@2	;@10F1C
@@1:	call	L10DF3	;@10F1E
	mov	byte ptr es:[bp+6], 4	;@10F21
	call	@@3	;@10F26
@@2:	retf	;@10F29
@@3:	push	cs	;@10F2A
	call	L101F7	;@10F2B
	mov	bx, ax	;@10F2E
	mov	cx, word ptr ds:[39AEh]	;@10F30
	jcxz	@@9	;@10F34
@@4:	mov	dx, word ptr es:[bp+8]	;@10F36
	push	es	;@10F3A
	push	bp	;@10F3B
	mov	ax, cx	;@10F3C
	push	cs	;@10F3E
	call	L101E0	;@10F3F
	mov	ax, word ptr es:[bp+8]	;@10F42
	cmp	ax, dx	;@10F46
	je	@@8	;@10F48
	push	es	;@10F4A
	push	bp	;@10F4B
	push	bx	;@10F4C
	call	L10ECA	;@10F4D
	pop	bx	;@10F50
	pop	bp	;@10F51
	pop	es	;@10F52
	ja	@@6	;@10F53
	mov	cx, word ptr es:[bp]	;@10F55
	jcxz	@@5	;@10F59
	pop	bp	;@10F5B
	pop	es	;@10F5C
	jmp	@@4	;@10F5D
@@5:	pop	ax	;@10F5F
	pop	ax	;@10F60
	mov	word ptr es:[bp], bx	;@10F61
	ret	;@10F65
@@6:	mov	cx, word ptr es:[bp+2]	;@10F66
	jcxz	@@7	;@10F6A
	pop	bp	;@10F6C
	pop	es	;@10F6D
	jmp	@@4	;@10F6E
@@7:	pop	ax	;@10F70
	pop	ax	;@10F71
	mov	word ptr es:[bp+2], bx	;@10F72
	ret	;@10F76
@@8:	pop	ax	;@10F77
	pop	ax	;@10F78
	mov	ax, bx	;@10F79
	mov	dx, 1	;@10F7B
	push	cs	;@10F7E
	call	L1015C	;@10F7F
	ret	;@10F82
@@9:	mov	word ptr ds:[39AEh], bx	;@10F83
	ret	;@10F87
L10F88:	call	L10EF8	;@10F88
	call	L114FC	;@10F8B
	call	L115A9	;@10F8E
	call	@@11	;@10F91
	jcxz	@@2	;@10F94
	mov	word ptr ds:[39ACh], cx	;@10F96
	mov	word ptr ds:[39AAh], cx	;@10F9A
	call	L11254	;@10F9E
@@1:	call	@@11	;@10FA1
	jcxz	@@2	;@10FA4
	mov	ax, word ptr ds:[39AAh]	;@10FA6
	push	cs	;@10FA9
	call	L101E0	;@10FAA
	mov	word ptr es:[bp], cx	;@10FAD
	mov	word ptr ds:[39AAh], cx	;@10FB1
	call	L11254	;@10FB5
	jmp	@@1	;@10FB8
@@2:	mov	word ptr ds:[390Ah], 3E4h	;@10FBA
@@3:	cmp	word ptr ds:[390Ah], 3FCh	;@10FC0
	je	@@6	;@10FC6
	mov	cx, word ptr ds:[39ACh]	;@10FC8
	mov	byte ptr ds:[39B4h], 1	;@10FCC
@@4:	jcxz	@@10	;@10FD1
	mov	ax, cx	;@10FD3
	push	cs	;@10FD5
	call	L101E0	;@10FD6
	push	es	;@10FD9
	push	bp	;@10FDA
	mov	word ptr ds:[39A6h], cx	;@10FDB
	mov	word ptr ds:[39AAh], cx	;@10FDF
	mov	ax, word ptr es:[bp+8]	;@10FE3
	mov	word ptr ds:[399Ch], ax	;@10FE7
	call	far ptr L00046	;@10FEA
	mov	word ptr ds:[39A0h], di	;@10FEF
	mov	byte ptr ds:[39B0h], al	;@10FF3
	test	al, 20h	;@10FF6
	jne	@@5	;@10FF8
	mov	bx, word ptr ds:[390Ah]	;@10FFA
	mov	ah, byte ptr [bx]	;@10FFE
	and	al, 1Fh	;@11000
	cmp	al, ah	;@11002
	je	@@8	;@11004
	cmp	ah, 6	;@11006
	je	@@7	;@11009
@@5:	pop	bp	;@1100B
	pop	es	;@1100C
	mov	cx, word ptr es:[bp]	;@1100D
	jmp	@@4	;@11011
@@6:	ret	;@11013
@@7:	cmp	al, 5	;@11014
	jne	@@5	;@11016
@@8:	cmp	byte ptr ds:[39B4h], 0	;@11018
	je	@@9	;@1101D
	mov	byte ptr ds:[39B4h], 0	;@1101F
	mov	bx, word ptr ds:[390Ah]	;@11024
	call	word ptr [bx+2]	;@11028
	call	L115A9	;@1102B
@@9:	mov	bx, word ptr ds:[390Ah]	;@1102E
	call	word ptr [bx+4]	;@11032
	jmp	@@5	;@11035
@@10:	add	word ptr ds:[390Ah], 6	;@11037
	jmp	@@3	;@1103C
@@11:	mov	ax, word ptr ds:[39A8h]	;@1103E
	or	ax, ax	;@11041
	je	@@15	;@11043
	push	cs	;@11045
	call	L101E0	;@11046
	mov	cx, word ptr es:[bp+2]	;@11049
	jcxz	@@15	;@1104D
@@12:	mov	dx, es	;@1104F
	mov	di, bp	;@11051
	mov	ax, cx	;@11053
	push	cs	;@11055
	call	L101E0	;@11056
	mov	cx, word ptr es:[bp+2]	;@11059
	jcxz	@@13	;@1105D
	jmp	@@12	;@1105F
@@13:	mov	bx, word ptr es:[bp]	;@11061
	push	cs	;@11065
	call	L101F7	;@11066
	mov	cx, ax	;@11069
	mov	es, dx	;@1106B
	mov	word ptr es:[di+2], bx	;@1106D
	mov	bp, di	;@11071
	push	cs	;@11073
	call	L101F7	;@11074
	mov	word ptr ds:[39A8h], ax	;@11077
@@14:	mov	word ptr ds:[39A6h], cx	;@1107A
	ret	;@1107E
@@15:	mov	cx, word ptr ds:[39AEh]	;@1107F
	jcxz	@@14	;@11083
	mov	ax, cx	;@11085
	push	cs	;@11087
	call	L101E0	;@11088
	mov	cx, word ptr es:[bp+2]	;@1108B
	or	cx, cx	;@1108F
	jne	@@12	;@11091
	mov	cx, ax	;@11093
	mov	ax, word ptr es:[bp]	;@11095
	mov	word ptr ds:[39AEh], ax	;@11099
	mov	word ptr ds:[39A8h], ax	;@1109C
	jmp	@@14	;@1109F
	db	0E9h, 38h, 2, 0A0h, 0B0h, 39h, 24h, 1Fh, 3Ch, 6, 74h, 1Dh, 0A1h, 9Ch, 39h, 0Eh	;@110A1
	db	0E8h, 2Ch, 0F1h, 9Ah
	dd	L00066
	db	0Bh, 0DBh, 75h, 22h, 0A1h, 9Ch, 39h, 0Eh, 0E8h, 1Ch, 0F1h, 0E8h, 79h, 0, 0E9h, 12h
	db	2, 0A1h, 9Ch, 39h, 0A3h, 9Eh, 39h, 0BBh, 2Ah, 39h, 0BEh, 0BEh, 4, 0E8h, 1Ah, 4
	db	0E8h, 0, 2, 0E8h, 1, 0, 0C3h, 8Bh, 0Eh, 0ACh, 39h, 0E3h, 59h, 8Bh, 0C1h, 0Eh
	db	0E8h, 0F4h, 0F0h, 89h, 0Eh, 0A6h, 39h, 26h, 8Bh, 46h, 8, 0A3h, 9Ch, 39h, 6, 55h
	db	9Ah
	dd	L00046
	db	5Dh, 7, 0A8h, 20h, 75h, 6, 24h, 1Fh, 3Ch, 5, 74h, 6, 26h, 8Bh, 4Eh, 0
	db	0EBh, 0D4h, 6, 55h, 0A1h, 9Ch, 39h, 0Eh, 0E8h, 0C7h, 0F0h, 9Ah
	dd	L00066
	db	3Bh, 1Eh, 9Eh, 39h, 75h, 17h, 0A1h, 9Ch, 39h, 0Eh, 0E8h, 0B5h, 0F0h, 0B8h, 2, 0
	db	6, 55h, 0E8h, 40h, 2, 5Dh, 7, 0E8h, 8, 0, 0E8h, 0ABh, 1, 5Dh, 7, 0EBh
	db	0CBh, 0C3h, 9Ah
	dd	L0006A
	db	0A3h, 90h, 39h, 89h, 16h, 92h, 39h, 9Ah
	dd	L00066
	db	89h, 0Eh, 0A4h, 39h, 57h, 50h, 0BBh, 2Ah, 39h, 0E8h, 0Fh, 0FBh, 0F7h, 6, 0A4h, 39h
	db	2, 0, 74h, 18h, 0BEh, 6Fh, 4, 0E8h, 0A0h, 0F7h, 0E8h, 0CBh, 1, 0BEh, 89h, 4
	db	0E8h, 97h, 0F7h, 59h, 58h, 0E3h, 58h, 0E8h, 59h, 2, 0EBh, 53h, 0F7h, 6, 0A4h, 39h
	db	1, 0, 0BEh, 65h, 4, 74h, 3, 0BEh, 6Ah, 4, 0E8h, 7Dh, 0F7h, 0E8h, 0A8h, 1
	db	0B1h, 4, 8Bh, 36h, 0A4h, 39h, 81h, 0E6h, 0E0h, 0, 56h, 0D3h, 0EEh, 81h, 0C6h, 0FCh
	db	3, 8Bh, 34h, 0E8h, 64h, 0F7h, 59h, 58h, 0E3h, 1Ah, 8Bh, 36h, 0A4h, 39h, 83h, 0E6h
	db	1Ch, 0D1h, 0EEh, 81h, 0C6h, 8, 4, 8Bh, 34h, 0E8h, 4Eh, 0F7h, 59h, 0E3h, 10h, 0E8h
	db	11h, 2, 0EBh, 0Bh, 5Eh, 0A3h, 90h, 39h, 89h, 0Eh, 92h, 39h, 0E8h, 69h, 1, 0E9h
	db	0A5h, 0FAh, 0E8h, 6, 1, 0A1h, 9Ch, 39h, 0Eh, 0E8h, 3, 0F0h, 0BEh, 82h, 0, 9Ah
	dd	L0006E
	db	0C3h
L111E6:	mov	word ptr ds:[3990h], ax	;@111E6
	mov	word ptr ds:[3992h], dx	;@111E9
	mov	byte ptr ds:[39B0h], bl	;@111ED
	mov	word ptr ds:[39A0h], cx	;@111F1
	mov	ax, 1	;@111F5
	call	L11373	;@111F8
	mov	bx, 392Ah	;@111FB
	call	L10C6C	;@111FE
	call	L1134F	;@11201
	call	L11339	;@11204
	call	L11361	;@11207
	call	L10C81	;@1120A
	call	L1155F	;@1120D
	retf	;@11210
	db	0E8h, 0C8h, 0, 0A1h, 9Ch, 39h, 0Eh, 0E8h, 0C5h, 0EFh, 0BEh, 88h, 0, 9Ah	;@11211
	dd	L00072
	db	0C3h
L11224:	mov	word ptr ds:[3990h], cx	;@11224
	mov	ax, 1	;@11228
	call	L11373	;@1122B
	mov	bx, 392Ah	;@1122E
	call	L10C6C	;@11231
	mov	si, 3990h	;@11234
	mov	cx, 1	;@11237
	call	L10DCC	;@1123A
	mov	al, 20h	;@1123D
	mov	cx, 4	;@1123F
	rep stosb	;@11242
	mov	cx, 1	;@11244
	mov	si, 3991h	;@11247
	call	L10DCC	;@1124A
	call	L10C81	;@1124D
	call	L1155F	;@11250
	retf	;@11253
L11254:	mov	ax, cx	;@11254
	push	cs	;@11256
	call	L101E0	;@11257
	mov	ax, word ptr ds:[51B4h]	;@1125A
	cmp	word ptr es:[bp+4], 0	;@1125D
	je	@@1	;@11262
	test	ax, 100h	;@11264
	je	@@2	;@11267
	ret	;@11269
@@1:	test	ax, 200h	;@1126A
	jne	@@3	;@1126D
@@2:	mov	ax, word ptr es:[bp+8]	;@1126F
	mov	word ptr ds:[399Ch], ax	;@11273
	call	far ptr L00046	;@11276
	mov	byte ptr ds:[39B0h], al	;@1127B
	test	al, 20h	;@1127E
	jne	@@4	;@11280
	and	al, 1Fh	;@11282
	mov	ah, 0	;@11284
	mov	si, 416h	;@11286
	add	si, ax	;@11289
	add	si, ax	;@1128B
	mov	bx, 392Ah	;@1128D
	call	L10C6C	;@11290
	cmp	word ptr [si], 0	;@11293
	je	@@3	;@11296
	call	word ptr [si]	;@11298
	jmp	short @@7	;@1129A
@@3:	ret	;@1129C
@@4:	mov	word ptr ds:[39A0h], di	;@1129D
	mov	ax, word ptr ds:[399Ch]	;@112A1
	push	cs	;@112A4
	call	L101E0	;@112A5
	call	far ptr L0004A	;@112A8
	mov	word ptr ds:[3990h], ax	;@112AD
	mov	word ptr ds:[3992h], dx	;@112B0
	mov	word ptr ds:[39A2h], di	;@112B4
	mov	bx, 392Ah	;@112B8
	call	L10C6C	;@112BB
	call	L1134F	;@112BE
	call	L113F0	;@112C1
	test	byte ptr ds:[39B0h], 10h	;@112C4
	je	@@5	;@112C9
	mov	si, 580h	;@112CB
	call	L1090B	;@112CE
	jmp	short @@6	;@112D1
@@5:	call	L11339	;@112D3
@@6:	call	L11361	;@112D6
	call	L10C81	;@112D9
@@7:	mov	ax, word ptr ds:[399Ch]	;@112DC
	push	cs	;@112DF
	call	L101E0	;@112E0
	call	L11371	;@112E3
	test	word ptr ds:[51B4h], 800h	;@112E6
	je	@@11	;@112EC
	mov	bx, 3966h	;@112EE
	call	L10C6C	;@112F1
@@8:	mov	ax, word ptr ds:[39A6h]	;@112F4
	or	ax, ax	;@112F7
	je	@@10	;@112F9
	mov	cx, di	;@112FB
	sub	cx, bp	;@112FD
	sub	cx, -2	;@112FF
	cmp	cx, word ptr [bx+8]	;@11302
	ja	@@10	;@11305
	push	es	;@11307
	push	bp	;@11308
	push	cs	;@11309
	call	L101E0	;@1130A
	mov	cx, word ptr es:[bp+0Eh]	;@1130D
	mov	ax, word ptr es:[bp+4]	;@11311
	mov	word ptr ds:[39A6h], ax	;@11315
	mov	al, byte ptr es:[bp+6]	;@11318
	pop	bp	;@1131C
	pop	es	;@1131D
	test	al, 4	;@1131E
	jne	@@10	;@11320
	test	al, 1	;@11322
	je	@@9	;@11324
	mov	al, 23h	;@11326
	stosb	;@11328
@@9:	inc	cx	;@11329
	call	L10D6A	;@1132A
	mov	ax, 2020h	;@1132D
	stosw	;@11330
	jmp	@@8	;@11331
@@10:	call	L10C78	;@11333
@@11:	jmp	L1155F	;@11336
L11339:	mov	si, 3990h	;@11339
	mov	cx, 2	;@1133C
	cmp	word ptr ds:[3992h], 0	;@1133F
	je	@@1	;@11344
	add	cx, cx	;@11346
@@1:	call	L10DCC	;@11348
	mov	al, 20h	;@1134B
	stosb	;@1134D
	ret	;@1134E
L1134F:	mov	al, byte ptr ds:[39B0h]	;@1134F
	and	ax, 0Fh	;@11352
	mov	si, 438h	;@11355
	add	si, ax	;@11358
	add	si, ax	;@1135A
	mov	si, word ptr [si]	;@1135C
	jmp	L1090B	;@1135E
L11361:	mov	al, byte ptr ds:[39B0h]	;@11361
	and	al, 0Fh	;@11364
	cmp	al, 0Ah	;@11366
	je	@@1	;@11368
	ret	;@1136A
@@1:	mov	cx, word ptr ds:[39A0h]	;@1136B
	jmp	short L113D4	;@1136F
L11371:	xor	ax, ax	;@11371
L11373:	push	es	;@11373
	push	bp	;@11374
	push	ax	;@11375
	mov	bx, 3934h	;@11376
	call	L10C6C	;@11379
	pop	cx	;@1137C
	mov	al, 20h	;@1137D
	rep stosb	;@1137F
	mov	ax, es	;@11381
	pop	bp	;@11383
	pop	es	;@11384
	push	es	;@11385
	push	bp	;@11386
	push	ax	;@11387
	push	di	;@11388
	call	far ptr L0003E	;@11389
	mov	si, di	;@1138E
	push	es	;@11390
	pop	ds	;@11391
	pop	di	;@11392
	pop	es	;@11393
	mov	bx, si	;@11394
	mov	dx, ds	;@11396
	rep movsb	;@11398
	push	ss	;@1139A
	pop	ds	;@1139B
	pop	bp	;@1139C
	pop	ax	;@1139D
	push	di	;@1139E
	push	es	;@1139F
	mov	es, ax	;@113A0
	push	bx	;@113A2
	push	dx	;@113A3
	call	far ptr L00042	;@113A4
	pop	dx	;@113A9
	pop	bx	;@113AA
	mov	ax, es	;@113AB
	cmp	ax, dx	;@113AD
	jne	@@1	;@113AF
	cmp	di, bx	;@113B1
	jne	@@1	;@113B3
	pop	es	;@113B5
	pop	di	;@113B6
	jmp	short @@2	;@113B7
@@1:	mov	si, di	;@113B9
	mov	ds, ax	;@113BB
	pop	es	;@113BD
	pop	di	;@113BE
	mov	ax, 2820h	;@113BF
	stosw	;@113C2
	rep movsb	;@113C3
	mov	al, 29h	;@113C5
	stosb	;@113C7
	push	ss	;@113C8
	pop	ds	;@113C9
@@2:	mov	ax, word ptr ds:[3936h]	;@113CA
	push	cs	;@113CD
	call	L101E0	;@113CE
	jmp	L10C78	;@113D1
L113D4:	push	bx	;@113D4
	push	es	;@113D5
	push	bp	;@113D6
	push	di	;@113D7
	mov	ax, cx	;@113D8
	push	cs	;@113DA
	call	L101E0	;@113DB
	call	far ptr L0003E	;@113DE
	mov	si, di	;@113E3
	push	es	;@113E5
	pop	ds	;@113E6
	pop	di	;@113E7
	pop	bp	;@113E8
	pop	es	;@113E9
	rep movsb	;@113EA
	push	ss	;@113EC
	pop	ds	;@113ED
	pop	bx	;@113EE
	ret	;@113EF
L113F0:	mov	ax, word ptr ds:[399Ch]	;@113F0
	mov	cx, word ptr ds:[39A2h]	;@113F3
	jcxz	@@2	;@113F7
	cmp	ax, cx	;@113F9
	je	@@2	;@113FB
	call	L113D4	;@113FD
@@1:	mov	al, 3Ah	;@11400
	stosb	;@11402
	ret	;@11403
@@2:	mov	si, 57Bh	;@11404
	call	L1090B	;@11407
	jmp	@@1	;@1140A
	db	0A1h, 9Ch, 39h, 0Eh, 0E8h, 0CDh, 0EDh, 9Ah	;@1140C
	dd	L0004E
	db	0A3h, 90h, 39h, 89h, 16h, 92h, 39h, 89h, 3Eh, 0A2h, 39h, 0BBh, 2Ah, 39h, 0E8h, 43h
	db	0F8h, 0BEh, 0E5h, 5, 0E8h, 0DCh, 0F4h, 0E8h, 0BEh, 0FFh, 0E8h, 4, 0FFh, 0E9h, 49h, 0F8h
	db	0BEh, 95h, 5, 0E8h, 0CDh, 0F4h, 0E8h, 40h, 0F8h, 0A1h, 9Ch, 39h, 0Eh, 0E8h, 98h, 0EDh
	db	9Ah
	dd	L0005E
	db	0Eh, 0E8h, 8Fh, 0EDh, 9Ah
	dd	L0003E
	db	8Bh, 0F7h, 8Ch, 0C2h, 0BBh, 2Ah, 39h, 0E8h, 0Ch, 0F8h, 1Eh, 8Eh, 0DAh, 0F3h, 0A4h, 1Fh
	db	0E9h, 18h, 0F8h, 0BEh, 8Dh, 5, 0E8h, 9Ch, 0F4h, 0E8h, 0Fh, 0F8h, 0A1h, 9Ch, 39h, 0Eh
	db	0E8h, 67h, 0EDh, 9Ah
	dd	L0005A
	db	0Eh, 0E8h, 0DDh, 0EEh, 8Bh, 0F7h, 8Ch, 0C2h, 0BBh, 2Ah, 39h, 0E8h, 0E0h, 0F7h, 1Eh, 8Eh
	db	0DAh, 0F3h, 0A4h, 1Fh, 0B0h, 20h, 0AAh, 0E8h, 0E9h, 0F7h, 0C3h, 0BEh, 9Dh, 5, 0E8h, 6Ch
	db	0F4h, 0BEh, 80h, 5, 0E8h, 66h, 0F4h, 0E8h, 0D9h, 0F7h, 0C3h, 0BEh, 0FDh, 5, 0E8h, 5Ch
	db	0F4h, 0E8h, 0CFh, 0F7h, 0A1h, 9Ch, 39h, 0Eh, 0E8h, 27h, 0EDh, 9Ah
	dd	L00052
	db	74h, 0Eh, 0Eh, 0E8h, 1Ch, 0EDh, 9Ah
	dd	L0007A
	db	9Ah
	dd	L0007E
	db	0C3h, 0BEh, 0FDh, 5, 0E8h, 36h, 0F4h, 0E8h, 0A9h, 0F7h, 0A1h, 9Ch, 39h, 0Eh, 0E8h, 1
	db	0EDh, 9Ah
	dd	L00056
	db	0Eh, 0E8h, 0F8h, 0ECh, 9Ah
	dd	L0007A
	db	9Ah
	dd	L0007E
	db	0C3h
L114F3:	call	L10C6C	;@114F3
	call	L1090B	;@114F6
	jmp	L10C78	;@114F9
L114FC:	mov	bx, 3934h	;@114FC
	mov	si, 4C4h	;@114FF
	call	L114F3	;@11502
	mov	bx, 392Ah	;@11505
	mov	si, 508h	;@11508
	call	L114F3	;@1150B
	mov	bx, 3966h	;@1150E
	mov	si, 54Ch	;@11511
	call	L114F3	;@11514
	ret	;@11517
	db	0BBh, 34h, 39h, 0BEh, 0D0h, 4, 0E8h, 0D2h, 0FFh, 0EBh, 0EBh, 0BBh	;@11518
	db	34h, 39h, 0BEh, 0EDh, 4, 0E8h, 0C7h, 0FFh, 0BBh, 2Ah, 39h, 0BEh
	db	15h, 5, 0E8h, 0BEh, 0FFh, 0EBh, 0D7h, 0BBh, 34h, 39h, 0BEh, 0FCh
	db	4, 0E8h, 0B3h, 0FFh, 0BBh, 2Ah, 39h, 0BEh, 22h, 5, 0E8h, 0AAh
	db	0FFh, 0EBh, 0C3h, 0BBh, 34h, 39h, 0BEh, 0DBh, 4, 0E8h, 9Fh, 0FFh
	db	0BBh, 2Ah, 39h, 0BEh, 2Eh, 5, 0E8h, 96h, 0FFh, 0EBh, 0AFh
L1155F:	mov	ax, word ptr ds:[392Ah]	;@1155F
	mov	word ptr ds:[392Ch], ax	;@11562
	push	cs	;@11565
	call	L101E0	;@11566
	mov	ax, bp	;@11569
	add	ax, 6	;@1156B
	mov	word ptr es:[bp+4], ax	;@1156E
	mov	si, 160Bh	;@11572
	call	L1098E	;@11575
	mov	bx, 3934h	;@11578
	call	L10C8E	;@1157B
	mov	bx, 392Ah	;@1157E
	call	L10C8E	;@11581
	mov	bx, 3966h	;@11584
	call	L10C8E	;@11587
	ret	;@1158A
	db	0E8h, 26h, 0F6h, 0E8h, 65h, 0F7h, 0BBh, 34h, 39h, 0E8h, 0E9h, 0F4h	;@1158B
	db	0BBh, 2Ah, 39h, 0E8h, 0E3h, 0F4h, 0BBh, 66h, 39h, 0E8h, 0F0h, 0F4h
	db	0E8h, 0, 0F6h, 0E9h, 6, 0F7h
L115A9:	mov	es, word ptr ds:[397Ch]	;@115A9
	cmp	byte ptr ds:[39B1h], 1	;@115AD
	je	@@1	;@115B2
	mov	ax, word ptr ds:[398Ch]	;@115B4
	add	ax, 6	;@115B7
	cmp	ax, word ptr ds:[3994h]	;@115BA
	jbe	@@1	;@115BE
	call	L10645	;@115C0
@@1:	call	L1085C	;@115C3
	xor	cx, cx	;@115C6
	call	L10CF6	;@115C8
	call	L10CAF	;@115CB
	call	L10BBC	;@115CE
	call	L10CF6	;@115D1
	mov	bx, 3934h	;@115D4
	call	L10A80	;@115D7
	mov	bx, 392Ah	;@115DA
	call	L10A80	;@115DD
	test	word ptr ds:[51B4h], 800h	;@115E0
	je	@@2	;@115E6
	mov	bx, 3966h	;@115E8
	call	L10A80	;@115EB
@@2:	call	L10BA6	;@115EE
	call	L10CAF	;@115F1
	xor	cx, cx	;@115F4
	call	L10CF6	;@115F6
	call	L10CAF	;@115F9
	add	word ptr ds:[398Ch], 3	;@115FC
	mov	bx, 3966h	;@11601
	call	L10C8E	;@11604
	mov	bx, 392Ah	;@11607
	call	L10C8E	;@1160A
	mov	bx, 3934h	;@1160D
	call	L10C8E	;@11610
	ret	;@11613
L11614:	mov	byte ptr ds:[39B4h], 0	;@11614
	mov	si, 16A1h	;@11619
	push	cs	;@1161C
	call	L128AB	;@1161D
	ret	;@11620
	db	0C6h, 6, 0B4h, 39h, 1, 8Bh, 0F3h, 0BBh, 34h, 39h, 0E8h, 3Eh, 0F6h, 6, 55h, 9Ah	;@11621
	dd	L14F20
	db	5Dh, 7, 0E8h, 3Eh, 0F6h, 0BEh, 0C6h, 16h, 0E8h, 4Eh, 0F3h, 0BBh, 34h, 39h, 0E9h, 48h
	db	0F6h, 8Bh, 0Eh, 96h, 39h, 0E8h, 0A9h, 0F6h, 0BBh, 34h, 39h, 0E8h, 40h, 0F4h, 0E9h, 59h
	db	0F6h
L11656:	mov	ax, ds	;@11656
	mov	es, ax	;@11658
	mov	di, si	;@1165A
	mov	cx, 0FFFFh	;@1165C
	xor	al, al	;@1165F
	repne scasb	;@11661
	neg	cx	;@11663
	sub	cx, 2	;@11665
	mov	al, 0	;@11668
	call	@@21	;@1166A
	mov	al, cl	;@1166D
	stosb	;@1166F
	rep movsb	;@11670
	call	@@16	;@11672
	mov	word ptr ds:[399Ah], 1	;@11675
	mov	si, 1713h	;@1167B
	mov	ax, cs	;@1167E
	push	cs	;@11680
	call	L11E7D	;@11681
	call	@@1	;@11684
	mov	al, 1	;@11687
	call	@@21	;@11689
	call	@@16	;@1168C
	call	@@19	;@1168F
	ret	;@11692
	db	0A1h, 9Ah, 39h, 0Eh, 0E8h, 0FDh, 6, 0Eh, 0E8h, 59h, 0EBh, 8Bh	;@11693
	db	0D0h, 0Eh, 0E8h, 1Bh, 7, 0E8h, 4Bh, 1, 0FFh, 6, 9Ah, 39h, 0CBh
@@1:	mov	ax, word ptr ds:[39ACh]	;@116AC
@@2:	or	ax, ax	;@116AF
	je	@@3	;@116B1
	push	cs	;@116B3
	call	L101E0	;@116B4
	push	es	;@116B7
	push	bp	;@116B8
	call	@@4	;@116B9
	pop	bp	;@116BC
	pop	es	;@116BD
	mov	ax, word ptr es:[bp]	;@116BE
	jmp	@@2	;@116C2
@@3:	ret	;@116C4
@@4:	mov	word ptr ds:[39A6h], ax	;@116C5
	test	byte ptr es:[bp+6], 4	;@116C8
	je	@@5	;@116CD
	ret	;@116CF
@@5:	push	word ptr es:[bp+8]	;@116D0
	mov	al, 3	;@116D4
	call	@@21	;@116D6
	pop	ax	;@116D9
	push	ax	;@116DA
	push	es	;@116DB
	push	di	;@116DC
	call	far ptr L00046	;@116DD
	pop	di	;@116E2
	pop	es	;@116E3
	test	al, 80h	;@116E4
	jne	@@9	;@116E6
	test	al, 20h	;@116E8
	jne	@@7	;@116EA
	and	al, 1Fh	;@116EC
	cmp	al, 9	;@116EE
	je	@@8	;@116F0
@@6:	xor	al, al	;@116F2
	jmp	short @@10	;@116F4
@@7:	test	al, 10h	;@116F6
	je	@@6	;@116F8
@@8:	mov	al, 40h	;@116FA
	jmp	short @@10	;@116FC
@@9:	mov	al, 80h	;@116FE
@@10:	mov	byte ptr ds:[39B2h], al	;@11700
	stosb	;@11703
	mov	bx, es	;@11704
	mov	si, di	;@11706
	pop	ax	;@11708
	push	cs	;@11709
	call	L101E0	;@1170A
	call	far ptr L00042	;@1170D
	xchg	si, di	;@11712
	push	ds	;@11714
	push	es	;@11715
	pop	ds	;@11716
	mov	es, bx	;@11717
	mov	al, cl	;@11719
	stosb	;@1171B
	rep movsb	;@1171C
	pop	ds	;@1171E
@@11:	mov	cx, word ptr ds:[39A6h]	;@1171F
	jcxz	@@15	;@11723
	push	ds	;@11725
	push	es	;@11726
	mov	ax, cx	;@11727
	push	cs	;@11729
	call	L101E0	;@1172A
	push	es	;@1172D
	pop	ds	;@1172E
	pop	es	;@1172F
	xor	al, al	;@11730
	test	byte ptr ss:[39B2h], 40h	;@11732
	jne	@@12	;@11738
	mov	al, byte ptr ds:[bp+6]	;@1173A
	and	al, 1	;@1173E
@@12:	stosb	;@11740
	mov	ax, word ptr ds:[bp+0Ch]	;@11741
	mov	bx, word ptr ds:[bp+0Eh]	;@11745
	mov	dx, word ptr ds:[bp+0Ah]	;@11749
	pop	ds	;@1174D
	push	di	;@1174E
	push	cs	;@1174F
	call	L11D9C	;@11750
	pop	di	;@11753
	xchg	ax, cx	;@11754
	mov	es, word ptr ds:[397Ch]	;@11755
	cmp	ax, 7Fh	;@11759
	ja	@@13	;@1175C
	stosb	;@1175E
	jmp	short @@14	;@1175F
@@13:	or	ah, 80h	;@11761
	xchg	ah, al	;@11764
	stosw	;@11766
@@14:	mov	ax, cx	;@11767
	inc	ax	;@11769
	stosw	;@1176A
	mov	ax, bx	;@1176B
	inc	ax	;@1176D
	stosw	;@1176E
	push	es	;@1176F
	mov	ax, word ptr ds:[39A6h]	;@11770
	push	cs	;@11773
	call	L101E0	;@11774
	mov	cx, word ptr es:[bp+4]	;@11777
	mov	word ptr ds:[39A6h], cx	;@1177B
	pop	es	;@1177F
	jcxz	@@15	;@11780
	mov	ax, di	;@11782
	sub	ax, word ptr ds:[3984h]	;@11784
	cmp	ax, 3FAh	;@11788
	jb	@@11	;@1178B
	call	@@16	;@1178D
	mov	ax, word ptr ds:[39A6h]	;@11790
	push	cs	;@11793
	call	L101E0	;@11794
	jmp	@@5	;@11797
@@15:	call	@@16	;@1179A
	ret	;@1179D
@@16:	push	bx	;@1179E
	mov	bx, word ptr ds:[3984h]	;@1179F
	mov	ax, di	;@117A3
	sub	ax, 3	;@117A5
	sub	ax, bx	;@117A8
	mov	word ptr es:[bx+1], ax	;@117AA
	pop	bx	;@117AE
	mov	ax, word ptr ds:[397Eh]	;@117AF
	sub	ax, 404h	;@117B2
	cmp	di, ax	;@117B5
	ja	@@17	;@117B7
	mov	word ptr ds:[3984h], di	;@117B9
	ret	;@117BD
@@17:	push	bx	;@117BE
	push	si	;@117BF
	push	dx	;@117C0
	xor	dx, dx	;@117C1
	mov	cx, di	;@117C3
	sub	cx, dx	;@117C5
	mov	ax, es	;@117C7
	mov	bx, word ptr ds:[3986h]	;@117C9
	push	cs	;@117CD
	call	L119BC	;@117CE
	pop	dx	;@117D1
	pop	si	;@117D2
	pop	bx	;@117D3
	jae	@@18	;@117D4
	jmp	L105F8	;@117D6
@@18:	mov	word ptr ds:[3984h], 0	;@117D9
	ret	;@117DF
@@19:	mov	di, word ptr ds:[3984h]	;@117E0
	mov	ax, di	;@117E4
	and	ax, ax	;@117E6
	je	@@20	;@117E8
	mov	es, word ptr ds:[397Ch]	;@117EA
	call	@@17	;@117EE
@@20:	ret	;@117F1
	db	8Bh, 0F7h, 0B9h, 0FFh, 0FFh, 32h, 0C0h, 0F2h, 0AEh, 0F7h, 0D9h	;@117F2
	db	83h, 0E9h, 2, 0B0h, 2, 1Eh, 6, 0E8h, 9, 0, 1Fh, 8Ah, 0C1h, 0AAh
	db	0F3h, 0A4h, 1Fh, 0EBh, 8Eh
@@21:	mov	es, word ptr ds:[397Ch]	;@11810
	mov	di, word ptr ds:[3984h]	;@11814
	stosb	;@11818
	add	di, 2	;@11819
	ret	;@1181C
L1181D:	xor	ax, ax	;@1181D
	mov	word ptr ds:[39C4h], ax	;@1181F
	mov	word ptr ds:[39C8h], ax	;@11822
	mov	word ptr ds:[39B8h], ax	;@11825
	mov	byte ptr ds:[39D2h], al	;@11828
	mov	bx, ax	;@1182B
	mov	cx, 0Ah	;@1182D
@@1:	mov	word ptr [bx+39D3h], ax	;@11830
	mov	word ptr [bx+39E7h], ax	;@11834
	mov	word ptr [bx+39FBh], ax	;@11838
	mov	word ptr [bx+3A0Fh], ax	;@1183C
	inc	bx	;@11840
	inc	bx	;@11841
	loop	@@1	;@11842
	mov	ax, word ptr ds:[38BAh]	;@11844
	cmp	ax, 0Fh	;@11847
	jae	@@2	;@1184A
	mov	ax, 0Fh	;@1184C
@@2:	cmp	ax, 100h	;@1184F
	jb	@@3	;@11852
	mov	ax, 0FFh	;@11854
@@3:	mov	word ptr ds:[38BAh], ax	;@11857
	add	ax, 3E26h	;@1185A
	mov	word ptr ds:[39D0h], ax	;@1185D
	retf	;@11860
L11861:	mov	ax, word ptr ds:[39B8h]	;@11861
	and	ax, ax	;@11864
	je	@@1	;@11866
	mov	dx, word ptr ds:[39BAh]	;@11868
	nosmart
	call	far ptr L10064	;@1186C
	smart
@@1:	retf	;@11871
L11872:	cmp	ax, 3E8h	;@11872
	jae	@@1	;@11875
	mov	ax, 3E8h	;@11877
@@1:	cmp	ax, 7FFFh	;@1187A
	jb	@@2	;@1187D
	mov	ax, 7FFFh	;@1187F
@@2:	mov	cl, 0FFh	;@11882
@@3:	inc	cl	;@11884
	shl	ax, 1	;@11886
	jae	@@3	;@11888
	mov	ax, 0FFFFh	;@1188A
	shr	ax, cl	;@1188D
	mov	word ptr ds:[39C0h], ax	;@1188F
	shl	word ptr ds:[39C0h], 1	;@11892
	inc	ax	;@11896
	mov	word ptr ds:[39BCh], ax	;@11897
	mov	word ptr ds:[39BEh], ax	;@1189A
	shr	ax, 1	;@1189D
	shr	ax, 1	;@1189F
	shr	ax, 1	;@118A1
	mov	word ptr ds:[39BAh], ax	;@118A3
	nosmart
	call	far ptr L10039	;@118A6
	smart
	mov	word ptr ds:[39B8h], ax	;@118AB
	mov	cx, word ptr ds:[39BCh]	;@118AE
	mov	es, word ptr ds:[39B8h]	;@118B2
	xor	ax, ax	;@118B6
	mov	bx, ax	;@118B8
@@4:	mov	word ptr es:[bx], ax	;@118BA
	inc	bx	;@118BD
	inc	bx	;@118BE
	loop	@@4	;@118BF
	retf	;@118C1
L118C2:	mov	dx, word ptr ds:[39C8h]	;@118C2
	and	dx, dx	;@118C6
	je	@@1	;@118C8
	mov	word ptr ds:[39C8h], 0	;@118CA
	mov	ax, word ptr ds:[39C6h]	;@118D0
	nosmart
	call	far ptr L1015C	;@118D3
	smart
	clc	;@118D8
	retf	;@118D9
@@1:	mov	dx, word ptr ds:[39C4h]	;@118DA
	and	dx, dx	;@118DE
	je	@@2	;@118E0
	mov	word ptr ds:[39C4h], 0	;@118E2
	mov	ax, word ptr ds:[39C2h]	;@118E8
	nosmart
	call	far ptr L1015C	;@118EB
	smart
	clc	;@118F0
	retf	;@118F1
@@2:	stc	;@118F2
	retf	;@118F3
L118F4:	push	ds	;@118F4
	pop	es	;@118F5
	mov	ah, 30h	;@118F6
	int	21h	;@118F8
	xchg	al, ah	;@118FA
	cmp	ax, 200h	;@118FC
	jb	@@5	;@118FF
	mov	di, 4E36h	;@11901
	mov	si, di	;@11904
	xor	cx, cx	;@11906
@@1:	mov	dx, 0A40h	;@11908
	mov	ax, 3D01h	;@1190B
	int	21h	;@1190E
	cld	;@11910
	jb	@@2	;@11911
	stosw	;@11913
	inc	cx	;@11914
	cmp	cx, 10h	;@11915
	jne	@@1	;@11918
@@2:	mov	word ptr ds:[4E34h], cx	;@1191A
	mov	dx, si	;@1191E
	jcxz	@@4	;@11920
@@3:	lodsw	;@11922
	mov	bx, ax	;@11923
	mov	ah, 3Eh	;@11925
	int	21h	;@11927
	cld	;@11929
	loop	@@3	;@1192A
@@4:	mov	di, dx	;@1192C
	mov	ax, 3800h	;@1192E
	int	21h	;@11931
	mov	ah, 30h	;@11933
	int	21h	;@11935
	xchg	al, ah	;@11937
	cld	;@11939
	cmp	ax, 20Bh	;@1193A
	cmc	;@1193D
	jae	@@5	;@1193E
	mov	byte ptr [di+0Bh], 2Fh	;@11940
	mov	byte ptr [di+0Dh], 3Ah	;@11944
	clc	;@11948
@@5:	retf	;@11949
L1194A:	mov	ah, 4Ch	;@1194A
	int	21h	;@1194C
L1194E:	mov	ax, word ptr ds:[4E34h]	;@1194E
	retf	;@11951
L11952:	mov	ax, 5700h	;@11952
	int	21h	;@11955
	cld	;@11957
	retf	;@11958
L11959:	mov	ah, 2Ch	;@11959
	int	21h	;@1195B
	cld	;@1195D
	mov	al, byte ptr ds:[4E43h]	;@1195E
	retf	;@11961
L11962:	mov	ah, 2Ah	;@11962
	int	21h	;@11964
	cld	;@11966
	sub	cx, 76Ch	;@11967
	cmp	cx, 64h	;@1196B
	jb	@@1	;@1196E
	sub	cx, 64h	;@11970
@@1:	mov	ch, cl	;@11973
	mov	cl, dh	;@11975
	mov	dh, dl	;@11977
	mov	ax, word ptr ds:[4E36h]	;@11979
	cmp	ax, 2	;@1197C
	je	@@3	;@1197F
	cmp	ax, 1	;@11981
	je	@@2	;@11984
	mov	dl, ch	;@11986
	mov	ch, cl	;@11988
	mov	cl, dh	;@1198A
	mov	dh, dl	;@1198C
	jmp	short @@3	;@1198E
@@2:	xchg	ch, dh	;@11990
@@3:	mov	al, byte ptr ds:[4E41h]	;@11992
	retf	;@11995
L11996:	mov	ah, 3Dh	;@11996
	int	21h	;@11998
	cld	;@1199A
	jb	@@1	;@1199B
	mov	bx, ax	;@1199D
@@1:	retf	;@1199F
L119A0:	xor	cx, cx	;@119A0
	mov	ah, 3Ch	;@119A2
	int	21h	;@119A4
	cld	;@119A6
	jb	@@1	;@119A7
	mov	bx, ax	;@119A9
@@1:	retf	;@119AB
L119AC:	mov	ah, 3Eh	;@119AC
	int	21h	;@119AE
	cld	;@119B0
	retf	;@119B1
L119B2:	push	ds	;@119B2
	mov	ds, ax	;@119B3
	mov	ah, 3Fh	;@119B5
	int	21h	;@119B7
	cld	;@119B9
	pop	ds	;@119BA
	retf	;@119BB
L119BC:	push	ds	;@119BC
	mov	ds, ax	;@119BD
	mov	ah, 40h	;@119BF
	int	21h	;@119C1
	cld	;@119C3
	pop	ds	;@119C4
	jb	@@1	;@119C5
	cmp	ax, cx	;@119C7
@@1:	retf	;@119C9
L119CA:	mov	ah, 42h	;@119CA
	int	21h	;@119CC
	cld	;@119CE
	retf	;@119CF
L119D0:	mov	ah, 41h	;@119D0
	int	21h	;@119D2
	cld	;@119D4
	retf	;@119D5
L119D6:	push	di	;@119D6
	push	dx	;@119D7
	push	ds	;@119D8
	push	ss	;@119D9
	pop	ds	;@119DA
	mov	dx, di	;@119DB
	mov	ah, 1Ah	;@119DD
	int	21h	;@119DF
	pop	ds	;@119E1
	pop	dx	;@119E2
	mov	ah, 4Eh	;@119E3
	jmp	short L119F2	;@119E5
L119E7:	push	di	;@119E7
	mov	dx, di	;@119E8
	push	ss	;@119EA
	pop	ds	;@119EB
	mov	ah, 1Ah	;@119EC
	int	21h	;@119EE
	mov	ah, 4Fh	;@119F0
L119F2:	int	21h	;@119F2
	cld	;@119F4
	pop	si	;@119F5
	mov	di, si	;@119F6
	push	ss	;@119F8
	pop	ds	;@119F9
	push	ds	;@119FA
	pop	es	;@119FB
	pushf	;@119FC
	add	di, 17h	;@119FD
	add	si, 1Eh	;@11A00
	mov	cx, 7	;@11A03
	rep movsw	;@11A06
	popf	;@11A08
	retf	;@11A09
L11A0A:	xor	ax, ax	;@11A0A
	mov	word ptr ds:[4E56h], ax	;@11A0C
	mov	word ptr ds:[4E58h], ax	;@11A0F
	retf	;@11A12
L11A13:	mov	ax, 1	;@11A13
	mov	cx, ax	;@11A16
	nosmart
	call	far ptr L100B0	;@11A18
	smart
	nosmart
	call	far ptr L101E0	;@11A1D
	smart
	mov	si, bx	;@11A22
	xor	cx, cx	;@11A24
@@1:	inc	cx	;@11A26
	inc	bx	;@11A27
	cmp	byte ptr [bx-1], 0	;@11A28
	jne	@@1	;@11A2C
	mov	word ptr es:[bp+6], cx	;@11A2E
	mov	ax, cx	;@11A32
	mov	dx, es	;@11A34
	nosmart
	call	far ptr L10215	;@11A36
	smart
	rep movsb	;@11A3B
	mov	es, dx	;@11A3D
	mov	word ptr es:[bp+4], ax	;@11A3F
	mov	cx, word ptr ds:[4E58h]	;@11A43
	mov	word ptr es:[bp], cx	;@11A47
	mov	word ptr es:[bp+2], 0	;@11A4B
	nosmart
	call	far ptr L101F7	;@11A51
	smart
	mov	dx, ax	;@11A56
	mov	word ptr ds:[4E58h], dx	;@11A58
	jcxz	@@2	;@11A5C
	push	ds	;@11A5E
	mov	ax, cx	;@11A5F
	nosmart
	call	far ptr L101E0	;@11A61
	smart
	push	es	;@11A66
	pop	ds	;@11A67
	mov	word ptr ds:[bp+2], dx	;@11A68
	pop	ds	;@11A6C
	retf	;@11A6D
@@2:	mov	word ptr ds:[4E56h], dx	;@11A6E
	retf	;@11A72
L11A73:	push	bx	;@11A73
	push	cx	;@11A74
	push	ss	;@11A75
	pop	es	;@11A76
	mov	di, 4E5Ah	;@11A77
	mov	si, bx	;@11A7A
	rep movsb	;@11A7C
	mov	byte ptr [di], 0	;@11A7E
	mov	bx, di	;@11A81
	mov	cx, word ptr ds:[4E56h]	;@11A83
@@1:	cmp	bx, 4E5Ah	;@11A87
	je	@@2	;@11A8B
	mov	al, byte ptr [bx-1]	;@11A8D
	cmp	al, 3Ah	;@11A90
	je	@@3	;@11A92
	cmp	al, 5Ch	;@11A94
	je	@@3	;@11A96
	cmp	al, 2Fh	;@11A98
	je	@@3	;@11A9A
	dec	bx	;@11A9C
	jmp	@@1	;@11A9D
@@2:	call	@@11	;@11A9F
	jmp	short @@5	;@11AA2
@@3:	call	@@11	;@11AA4
@@4:	push	cx	;@11AA7
	mov	dx, 4E5Ah	;@11AA8
	mov	di, 4EA7h	;@11AAB
	xor	cx, cx	;@11AAE
	nosmart
	call	far ptr L119D6	;@11AB0
	smart
	pop	cx	;@11AB5
	jae	@@9	;@11AB6
@@5:	jcxz	@@10	;@11AB8
	mov	ax, cx	;@11ABA
	nosmart
	call	far ptr L101E0	;@11ABC
	smart
	mov	ax, word ptr es:[bp+4]	;@11AC1
	push	es	;@11AC5
	push	bp	;@11AC6
	nosmart
	call	far ptr L1035F	;@11AC7
	smart
	mov	bx, 4E5Ah	;@11ACC
@@6:	mov	al, byte ptr es:[di]	;@11ACF
	and	al, al	;@11AD2
	je	@@7	;@11AD4
	mov	byte ptr [bx], al	;@11AD6
	inc	bx	;@11AD8
	inc	di	;@11AD9
	jmp	@@6	;@11ADA
@@7:	mov	di, 4E9Ah	;@11ADC
@@8:	mov	al, byte ptr [di]	;@11ADF
	mov	byte ptr [bx], al	;@11AE1
	inc	bx	;@11AE3
	inc	di	;@11AE4
	and	al, al	;@11AE5
	jne	@@8	;@11AE7
	pop	bp	;@11AE9
	pop	es	;@11AEA
	mov	cx, word ptr es:[bp+2]	;@11AEB
	jmp	@@4	;@11AEF
@@9:	pop	ax	;@11AF1
	pop	ax	;@11AF2
	mov	bx, 4E5Ah	;@11AF3
	retf	;@11AF6
@@10:	pop	cx	;@11AF7
	pop	si	;@11AF8
	push	ss	;@11AF9
	pop	es	;@11AFA
	mov	di, 4E5Ah	;@11AFB
	mov	bx, di	;@11AFE
	rep movsb	;@11B00
	xor	al, al	;@11B02
	stosb	;@11B04
	retf	;@11B05
@@11:	mov	di, 4E9Ah	;@11B06
@@12:	mov	al, byte ptr [bx]	;@11B09
	mov	byte ptr [di], al	;@11B0B
	inc	bx	;@11B0D
	inc	di	;@11B0E
	and	al, al	;@11B0F
	jne	@@12	;@11B11
	ret	;@11B13
L11B14:	xor	ax, ax	;@11B14
	mov	word ptr ds:[38B4h], ax	;@11B16
	mov	word ptr ds:[4ED2h], ax	;@11B19
	mov	word ptr ds:[4ED6h], ax	;@11B1C
	mov	word ptr ds:[4ED8h], ax	;@11B1F
	mov	word ptr ds:[4EF0h], ax	;@11B22
	xor	ax, ax	;@11B25
	mov	word ptr ds:[4EDAh], ax	;@11B27
	mov	word ptr ds:[4EDCh], ax	;@11B2A
	xor	ax, ax	;@11B2D
	mov	word ptr ds:[4EDEh], ax	;@11B2F
	mov	word ptr ds:[4EE0h], ax	;@11B32
	push	cs	;@11B35
	call	L1194E	;@11B36
	sub	ax, 2	;@11B39
	mov	word ptr ds:[4EE4h], ax	;@11B3C
	push	cs	;@11B3F
	call	L10017	;@11B40
	shr	ax, 1	;@11B43
	shr	ax, 1	;@11B45
	cmp	ax, 1200h	;@11B47
	jb	@@1	;@11B4A
	mov	ax, 1200h	;@11B4C
@@1:	mov	word ptr ds:[4EE2h], ax	;@11B4F
	cmp	ax, 0FF1h	;@11B52
	jb	@@2	;@11B55
	mov	ax, 0FF1h	;@11B57
@@2:	mov	cl, 4	;@11B5A
	shl	ax, cl	;@11B5C
	sub	ax, 6	;@11B5E
	mov	word ptr ds:[4EE6h], ax	;@11B61
	retf	;@11B64
L11B65:	call	L125D2	;@11B65
	jb	@@1	;@11B68
	mov	word ptr ds:[4ED2h], cx	;@11B6A
	mov	word ptr ds:[4ED8h], cx	;@11B6E
	xor	ax, ax	;@11B72
	mov	cx, ax	;@11B74
	mov	dx, ax	;@11B76
	call	L123F5	;@11B78
	jmp	short @@2	;@11B7B
@@1:	mov	di, bx	;@11B7D
	push	ds	;@11B7F
	pop	es	;@11B80
	xor	ax, ax	;@11B81
	mov	cx, 100h	;@11B83
	repne scasb	;@11B86
	neg	cx	;@11B88
	add	cx, 100h	;@11B8A
	mov	ax, cx	;@11B8E
	push	cs	;@11B90
	call	L10215	;@11B91
	mov	dx, cx	;@11B94
	mov	si, bx	;@11B96
	rep movsb	;@11B98
	mov	di, ax	;@11B9A
	mov	bp, 3	;@11B9C
	call	L12599	;@11B9F
	xor	bl, bl	;@11BA2
	call	L1234B	;@11BA4
	mov	word ptr ds:[4ED2h], dx	;@11BA7
	xor	ax, ax	;@11BAB
	mov	cx, ax	;@11BAD
	mov	dx, ax	;@11BAF
	call	L123F5	;@11BB1
	mov	bx, word ptr es:[bp+26h]	;@11BB4
	push	cs	;@11BB8
	call	L11952	;@11BB9
	jb	@@3	;@11BBC
	mov	bx, cx	;@11BBE
	mov	ax, word ptr es:[bp]	;@11BC0
	mov	cl, byte ptr es:[bp+2]	;@11BC4
	dec	cl	;@11BC8
	push	es	;@11BCA
	push	bp	;@11BCB
	call	far ptr L03524	;@11BCC
	pop	bp	;@11BD1
	pop	es	;@11BD2
	mov	word ptr es:[bp+16h], ax	;@11BD3
@@2:	call	L123BF	;@11BD7
	push	cs	;@11BDA
	call	L101F7	;@11BDB
	retf	;@11BDE
@@3:	mov	byte ptr ds:[38C8h], 5	;@11BDF
	stc	;@11BE4
	mov	sp, word ptr ds:[38ACh]	;@11BE5
	retf	;@11BE9
L11BEA:	mov	bx, es	;@11BEA
	mov	si, cx	;@11BEC
	call	L125D2	;@11BEE
	jb	@@1	;@11BF1
	mov	word ptr ds:[4ED4h], cx	;@11BF3
	mov	word ptr ds:[4ED8h], cx	;@11BF7
	call	L121D1	;@11BFB
	mov	byte ptr es:[bp+3], 1	;@11BFE
	mov	word ptr es:[bp+0Eh], 0	;@11C03
	jmp	short @@2	;@11C09
@@1:	mov	ax, si	;@11C0B
	mov	cx, ax	;@11C0D
	mov	si, di	;@11C0F
	inc	ax	;@11C11
	mov	dx, ax	;@11C12
	push	cs	;@11C14
	call	L10215	;@11C15
	push	ds	;@11C18
	mov	ds, bx	;@11C19
	rep movsb	;@11C1B
	pop	ds	;@11C1D
	mov	byte ptr es:[di], 0	;@11C1E
	mov	di, ax	;@11C22
	mov	bp, 2	;@11C24
	call	L12599	;@11C27
	mov	bl, 1	;@11C2A
	call	L1234B	;@11C2C
	mov	word ptr ds:[4ED4h], dx	;@11C2F
@@2:	call	L1212B	;@11C33
	call	L123BF	;@11C36
	mov	al, byte ptr ds:[51C2h]	;@11C39
	mov	byte ptr es:[bp+16h], al	;@11C3C
	mov	al, byte ptr ds:[51C4h]	;@11C40
	mov	byte ptr es:[bp+17h], al	;@11C43
	retf	;@11C47
L11C48:	mov	cx, 0FFFFh	;@11C48
	mov	di, bx	;@11C4B
	mov	al, 0Dh	;@11C4D
	push	ds	;@11C4F
	pop	es	;@11C50
	repne scasb	;@11C51
	neg	cx	;@11C53
	mov	si, bx	;@11C55
@@1:	mov	ax, word ptr ds:[4EE8h]	;@11C57
	and	ax, ax	;@11C5A
	je	@@2	;@11C5C
	push	cs	;@11C5E
	call	L101E0	;@11C5F
	mov	di, word ptr es:[bp+4]	;@11C62
	mov	ax, word ptr es:[bp+2]	;@11C66
	sub	ax, di	;@11C6A
	add	di, bp	;@11C6C
	cmp	ax, cx	;@11C6E
	jae	@@3	;@11C70
	sub	cx, ax	;@11C72
	add	word ptr es:[bp+4], ax	;@11C74
	push	cx	;@11C78
	mov	cx, ax	;@11C79
	shr	cx, 1	;@11C7B
	rep movsw	;@11C7D
	rcl	cx, 1	;@11C7F
	rep movsb	;@11C81
	pop	cx	;@11C83
	push	cx	;@11C84
	push	si	;@11C85
	call	L1213F	;@11C86
	pop	si	;@11C89
	pop	cx	;@11C8A
@@2:	push	cx	;@11C8B
	push	si	;@11C8C
	mov	ax, 800h	;@11C8D
	call	L12198	;@11C90
	pop	si	;@11C93
	pop	cx	;@11C94
	jmp	@@1	;@11C95
@@3:	add	word ptr es:[bp+4], cx	;@11C97
	dec	cx	;@11C9B
	shr	cx, 1	;@11C9C
	rep movsw	;@11C9E
	rcl	cx, 1	;@11CA0
	rep movsb	;@11CA2
	mov	al, 0Ah	;@11CA4
	stosb	;@11CA6
	retf	;@11CA7
L11CA8:	mov	ax, word ptr ds:[4ED4h]	;@11CA8
	mov	word ptr ds:[4ED2h], ax	;@11CAB
	push	cs	;@11CAE
	call	L101E0	;@11CAF
	push	es	;@11CB2
	push	bp	;@11CB3
	call	L1215F	;@11CB4
	pop	bp	;@11CB7
	pop	es	;@11CB8
	call	L121FB	;@11CB9
	retf	;@11CBC
L11CBD:	mov	ax, word ptr ds:[4ED2h]	;@11CBD
	push	cs	;@11CC0
	call	L101E0	;@11CC1
	test	byte ptr es:[bp+3], 1	;@11CC4
	je	@@1	;@11CC9
	mov	al, byte ptr es:[bp+16h]	;@11CCB
	mov	byte ptr ds:[51C2h], al	;@11CCF
	mov	al, byte ptr es:[bp+17h]	;@11CD2
	mov	byte ptr ds:[51C4h], al	;@11CD6
	call	L121D1	;@11CD9
	mov	cx, word ptr es:[bp+0Ch]	;@11CDC
	mov	word ptr ds:[4ED2h], cx	;@11CE0
	retf	;@11CE4
@@1:	mov	cx, 28h	;@11CE5
	jmp	L126B7	;@11CE8
L11CEB:	mov	cx, word ptr ds:[4EDAh]	;@11CEB
	jcxz	@@3	;@11CEF
	mov	ax, cx	;@11CF1
	push	cs	;@11CF3
	call	L101E0	;@11CF4
	cmp	cx, word ptr ds:[4ED2h]	;@11CF7
	je	@@2	;@11CFB
@@1:	call	L1228A	;@11CFD
	clc	;@11D00
	retf	;@11D01
@@2:	push	es	;@11D02
	push	bp	;@11D03
	mov	ax, word ptr es:[bp+10h]	;@11D04
	push	cs	;@11D08
	call	L101E0	;@11D09
	cmp	word ptr es:[bp+2], 20h	;@11D0C
	pop	bp	;@11D11
	pop	es	;@11D12
	ja	@@1	;@11D13
@@3:	stc	;@11D15
	retf	;@11D16
L11D17:	mov	dx, word ptr ds:[4EF0h]	;@11D17
	and	dx, dx	;@11D1B
	je	@@1	;@11D1D
	mov	word ptr ds:[4EF0h], 0	;@11D1F
	mov	ax, word ptr ds:[4EEEh]	;@11D25
	push	cs	;@11D28
	call	L1015C	;@11D29
	clc	;@11D2C
	retf	;@11D2D
@@1:	stc	;@11D2E
	retf	;@11D2F
L11D30:	cmp	word ptr ds:[4EDEh], 0	;@11D30
	je	@@1	;@11D35
	call	L122F8	;@11D37
	jmp	L11D30	;@11D3A
@@1:	mov	cx, word ptr ds:[4ED6h]	;@11D3C
@@2:	jcxz	@@3	;@11D40
	mov	ax, cx	;@11D42
	push	cs	;@11D44
	call	L101E0	;@11D45
	call	L121D1	;@11D48
	mov	cx, word ptr es:[bp+0Ah]	;@11D4B
	jmp	@@2	;@11D4F
@@3:	retf	;@11D51
L11D52:	mov	ax, word ptr ds:[4ED2h]	;@11D52
	push	cs	;@11D55
	call	L101E0	;@11D56
	mov	ax, word ptr es:[bp+0Eh]	;@11D59
	call	L11F39	;@11D5D
	jb	L11D52	;@11D60
	retf	;@11D62
L11D63:	mov	ax, word ptr ds:[4ED2h]	;@11D63
	push	bx	;@11D66
	mov	bx, ax	;@11D67
	rol	bx, 4	;@11D69
	mov	bp, bx	;@11D6C
	and	bp, -10h	;@11D6E
	and	bx, 0Fh	;@11D71
	shl	bx, 1	;@11D74
	mov	es, word ptr ss:[bx+38D2h]	;@11D76
	pop	bx	;@11D7B
	mov	word ptr ds:[517Ah], ax	;@11D7C
	mov	ax, word ptr es:[bp+0Eh]	;@11D7F
	mov	word ptr ds:[516Eh], ax	;@11D83
	call	L11F39	;@11D86
	jb	L11D63	;@11D89
	retf	;@11D8B
L11D8C:	mov	ax, word ptr ds:[4ED2h]	;@11D8C
	push	cs	;@11D8F
	call	L101E0	;@11D90
	call	L12115	;@11D93
	retf	;@11D96
	db	26h, 89h, 46h, 16h, 0CBh	;@11D97
L11D9C:	push	ax	;@11D9C
	mov	ax, dx	;@11D9D
	push	cs	;@11D9F
	call	L101E0	;@11DA0
	pop	ax	;@11DA3
	mov	cx, dx	;@11DA4
	jcxz	@@1	;@11DA6
	test	byte ptr es:[bp+3], 1	;@11DA8
	jne	@@2	;@11DAD
	mov	cx, word ptr es:[bp+16h]	;@11DAF
@@1:	retf	;@11DB3
@@2:	mov	ax, word ptr es:[bp+18h]	;@11DB4
	dec	ax	;@11DB8
	mov	dx, word ptr es:[bp+0Ch]	;@11DB9
	jmp	L11D9C	;@11DBD
L11DBF:	mov	cx, dx	;@11DBF
	jcxz	@@1	;@11DC1
	mov	ax, cx	;@11DC3
	push	cs	;@11DC5
	call	L101E0	;@11DC6
	mov	ax, word ptr es:[bp]	;@11DC9
	mov	cl, byte ptr es:[bp+2]	;@11DCD
	xor	ch, ch	;@11DD1
	mov	dl, byte ptr es:[bp+3]	;@11DD3
	and	dl, 1	;@11DD7
	jmp	L1035F	;@11DDA
@@1:	push	ss	;@11DDD
	pop	es	;@11DDE
	mov	di, 0A44h	;@11DDF
	xor	dl, dl	;@11DE2
	retf	;@11DE4
L11DE5:	push	ax	;@11DE5
	mov	ax, dx	;@11DE6
	push	cs	;@11DE8
	call	L101E0	;@11DE9
	pop	ax	;@11DEC
	cmp	ax, word ptr es:[bp+0Eh]	;@11DED
	jb	@@4	;@11DF1
	sub	ax, word ptr es:[bp+0Eh]	;@11DF3
	push	ax	;@11DF7
	mov	ax, word ptr es:[bp+0Eh]	;@11DF8
	mov	dx, word ptr es:[bp+1Ah]	;@11DFC
	mov	cx, word ptr es:[bp+1Ch]	;@11E00
	add	dx, word ptr es:[bp+12h]	;@11E04
	adc	cx, 0	;@11E08
@@1:	call	L123F5	;@11E0B
	pop	cx	;@11E0E
	push	cs	;@11E0F
	call	L101F7	;@11E10
	mov	word ptr ds:[4ED2h], ax	;@11E13
	mov	word ptr ds:[4ED8h], ax	;@11E16
	mov	si, word ptr es:[bp+12h]	;@11E19
	mov	ax, word ptr es:[bp+14h]	;@11E1D
	push	cs	;@11E21
	call	L101E0	;@11E22
	push	es	;@11E25
	pop	ds	;@11E26
	add	si, bp	;@11E27
	add	si, 6	;@11E29
	mov	dx, cx	;@11E2C
	jcxz	@@3	;@11E2E
	push	dx	;@11E30
@@2:	push	cx	;@11E31
	call	L120B8	;@11E32
	pop	cx	;@11E35
	loop	@@2	;@11E36
	pop	dx	;@11E38
@@3:	sub	si, bp	;@11E39
	sub	si, 6	;@11E3B
	push	ss	;@11E3E
	pop	ds	;@11E3F
	mov	ax, word ptr ds:[4ED2h]	;@11E40
	push	cs	;@11E43
	call	L101E0	;@11E44
	add	word ptr es:[bp+0Eh], dx	;@11E47
	mov	word ptr es:[bp+12h], si	;@11E4B
	xor	di, di	;@11E4F
	add	si, word ptr es:[bp+1Ah]	;@11E51
	adc	di, word ptr es:[bp+1Ch]	;@11E55
	retf	;@11E59
@@4:	push	ax	;@11E5A
	xor	ax, ax	;@11E5B
	mov	cx, ax	;@11E5D
	mov	dx, ax	;@11E5F
	jmp	@@1	;@11E61
L11E63:	push	ax	;@11E63
	mov	ax, dx	;@11E64
	push	cs	;@11E66
	call	L101E0	;@11E67
	pop	ax	;@11E6A
	mov	dx, cx	;@11E6B
	mov	cx, di	;@11E6D
	call	L123F5	;@11E6F
	push	cs	;@11E72
	call	L101F7	;@11E73
	mov	word ptr ds:[4ED2h], ax	;@11E76
	mov	word ptr ds:[4ED8h], ax	;@11E79
	retf	;@11E7C
L11E7D:	mov	word ptr ds:[4EF2h], si	;@11E7D
	mov	word ptr ds:[4EF4h], ax	;@11E81
	mov	cx, word ptr ds:[4ED6h]	;@11E84
@@1:	jcxz	@@3	;@11E88
	mov	ax, cx	;@11E8A
	push	cs	;@11E8C
	call	L101E0	;@11E8D
	test	byte ptr es:[bp+3], 1	;@11E90
	jne	@@2	;@11E95
	push	es	;@11E97
	push	bp	;@11E98
	call	dword ptr ds:[4EF2h]	;@11E99
	pop	bp	;@11E9D
	pop	es	;@11E9E
@@2:	mov	cx, word ptr es:[bp+0Ah]	;@11E9F
	jmp	@@1	;@11EA3
@@3:	retf	;@11EA5
L11EA6:	cmp	dx, di	;@11EA6
	jne	@@2	;@11EA8
	cmp	ax, cx	;@11EAA
	retf	;@11EAC
@@1:	cmp	dx, di	;@11EAD
	retf	;@11EAF
@@2:	or	dx, dx	;@11EB0
	je	@@1	;@11EB2
	or	di, di	;@11EB4
	je	@@1	;@11EB6
	push	es	;@11EB8
	push	bp	;@11EB9
	push	si	;@11EBA
	push	dx	;@11EBB
	push	bx	;@11EBC
	push	ax	;@11EBD
	mov	si, dx	;@11EBE
	mov	dx, ax	;@11EC0
	mov	ax, si	;@11EC2
	push	cs	;@11EC4
	call	L101E0	;@11EC5
	call	L12115	;@11EC8
	push	ax	;@11ECB
	mov	ax, di	;@11ECC
	push	cs	;@11ECE
	call	L101E0	;@11ECF
	call	L12115	;@11ED2
	pop	bx	;@11ED5
	push	ax	;@11ED6
	push	bx	;@11ED7
@@3:	cmp	ax, bx	;@11ED8
	je	@@5	;@11EDA
	ja	@@4	;@11EDC
	push	ax	;@11EDE
	mov	ax, si	;@11EDF
	push	cs	;@11EE1
	call	L101E0	;@11EE2
	pop	ax	;@11EE5
	mov	si, word ptr es:[bp+0Ch]	;@11EE6
	mov	dx, word ptr es:[bp+4]	;@11EEA
	dec	dx	;@11EEE
	dec	bx	;@11EEF
	jmp	@@3	;@11EF0
@@4:	push	ax	;@11EF2
	mov	ax, di	;@11EF3
	push	cs	;@11EF5
	call	L101E0	;@11EF6
	pop	ax	;@11EF9
	mov	di, word ptr es:[bp+0Ch]	;@11EFA
	mov	cx, word ptr es:[bp+4]	;@11EFE
	dec	cx	;@11F02
	dec	ax	;@11F03
	jmp	@@3	;@11F04
@@5:	cmp	si, di	;@11F06
	je	@@6	;@11F08
	mov	ax, si	;@11F0A
	push	cs	;@11F0C
	call	L101E0	;@11F0D
	mov	si, word ptr es:[bp+0Ch]	;@11F10
	mov	dx, word ptr es:[bp+4]	;@11F14
	dec	dx	;@11F18
	mov	ax, di	;@11F19
	push	cs	;@11F1B
	call	L101E0	;@11F1C
	mov	di, word ptr es:[bp+0Ch]	;@11F1F
	mov	cx, word ptr es:[bp+4]	;@11F23
	dec	cx	;@11F27
	jmp	@@5	;@11F28
@@6:	pop	bx	;@11F2A
	pop	ax	;@11F2B
	cmp	dx, cx	;@11F2C
	jne	@@7	;@11F2E
	cmp	bx, ax	;@11F30
@@7:	pop	ax	;@11F32
	pop	bx	;@11F33
	pop	dx	;@11F34
	pop	si	;@11F35
	pop	bp	;@11F36
	pop	es	;@11F37
	retf	;@11F38
L11F39:	mov	ax, word ptr es:[bp+14h]	;@11F39
	and	ax, ax	;@11F3D
	jne	@@1	;@11F3F
	jmp	@@6	;@11F41
@@1:	mov	si, word ptr es:[bp+12h]	;@11F44
	push	bx	;@11F48
	mov	bx, ax	;@11F49
	rol	bx, 4	;@11F4B
	mov	bp, bx	;@11F4E
	and	bp, -10h	;@11F50
	and	bx, 0Fh	;@11F53
	shl	bx, 1	;@11F56
	mov	ds, word ptr ss:[bx+38D2h]	;@11F58
	pop	bx	;@11F5D
	push	ss	;@11F5E
	pop	es	;@11F5F
	mov	dx, di	;@11F60
	add	si, bp	;@11F62
	add	si, 6	;@11F64
@@2:	mov	bx, word ptr ds:[bp+4]	;@11F67
	add	bx, bp	;@11F6B
	sub	bx, si	;@11F6D
	cmp	bx, cx	;@11F6F
	jb	@@10	;@11F71
	mov	ah, 0Ah	;@11F73
@@3:	lodsb	;@11F75
	stosb	;@11F76
	cmp	al, ah	;@11F77
	loopne	@@3	;@11F79
	je	@@4	;@11F7B
	jmp	@@13	;@11F7D
@@4:	mov	byte ptr es:[di-1], 0Dh	;@11F80
	cmp	word ptr es:[di-3], 0D5Ch	;@11F85
	je	@@9	;@11F8B
	cmp	byte ptr es:[di-2], 5Ch	;@11F8D
	je	@@8	;@11F92
@@5:	sub	si, bp	;@11F94
	sub	si, 6	;@11F96
	push	ds	;@11F99
	pop	es	;@11F9A
	push	cs	;@11F9B
	call	L101F7	;@11F9C
	push	ss	;@11F9F
	pop	ds	;@11FA0
	push	bx	;@11FA1
	mov	bx, word ptr ds:[4ED2h]	;@11FA2
	rol	bx, 4	;@11FA6
	mov	bp, bx	;@11FA9
	and	bp, -10h	;@11FAB
	and	bx, 0Fh	;@11FAE
	shl	bx, 1	;@11FB1
	mov	es, word ptr ss:[bx+38D2h]	;@11FB3
	pop	bx	;@11FB8
	mov	word ptr es:[bp+14h], ax	;@11FB9
	mov	word ptr es:[bp+12h], si	;@11FBD
	inc	word ptr es:[bp+0Eh]	;@11FC1
	clc	;@11FC5
	ret	;@11FC6
@@6:	push	cx	;@11FC7
	push	di	;@11FC8
	call	L1243E	;@11FC9
	pop	di	;@11FCC
	pop	cx	;@11FCD
	jb	@@7	;@11FCE
	jmp	L11F39	;@11FD0
@@7:	jmp	short @@16	;@11FD3
@@8:	inc	di	;@11FD5
	dec	cx	;@11FD6
@@9:	test	word ptr ss:[517Ch], 4000h	;@11FD7
	jne	@@5	;@11FDE
	sub	di, 3	;@11FE0
	cmp	di, dx	;@11FE3
	jb	@@5	;@11FE5
	jmp	short @@14	;@11FE7
@@10:	and	bx, bx	;@11FE9
	je	@@12	;@11FEB
	xchg	cx, bx	;@11FED
	mov	ah, 0Ah	;@11FEF
@@11:	lodsb	;@11FF1
	stosb	;@11FF2
	dec	bx	;@11FF3
	cmp	al, ah	;@11FF4
	loopne	@@11	;@11FF6
	mov	cx, bx	;@11FF8
	je	@@4	;@11FFA
@@12:	push	cx	;@11FFC
	push	dx	;@11FFD
	call	L120D1	;@11FFE
	pop	dx	;@12001
	pop	cx	;@12002
	jb	@@15	;@12003
	jcxz	@@13	;@12005
	jmp	@@2	;@12007
@@13:	push	cx	;@1200A
	push	dx	;@1200B
	call	@@21	;@1200C
	pop	dx	;@1200F
	pop	cx	;@12010
	jb	@@15	;@12011
	jmp	@@4	;@12013
@@14:	call	@@5	;@12016
	add	cx, 3	;@12019
	mov	ax, word ptr es:[bp+0Eh]	;@1201C
	jmp	L11F39	;@12020
@@15:	push	ss	;@12023
	pop	ds	;@12024
@@16:	push	cx	;@12025
	push	di	;@12026
	mov	ax, word ptr ds:[4ED2h]	;@12027
	push	cs	;@1202A
	call	L101E0	;@1202B
	test	byte ptr es:[bp+3], 1	;@1202E
	je	@@17	;@12033
	call	L121D1	;@12035
	jmp	short @@19	;@12038
@@17:	call	L122BD	;@1203A
	mov	cx, word ptr ds:[4EDAh]	;@1203D
	push	cs	;@12041
	call	L101F7	;@12042
	mov	dx, ax	;@12045
	mov	word ptr ds:[4EDAh], dx	;@12047
	mov	word ptr es:[bp+20h], cx	;@1204B
	mov	word ptr es:[bp+1Eh], 0	;@1204F
	jcxz	@@18	;@12055
	push	ds	;@12057
	push	bp	;@12058
	push	es	;@12059
	mov	ax, cx	;@1205A
	push	cs	;@1205C
	call	L101E0	;@1205D
	push	es	;@12060
	pop	ds	;@12061
	mov	word ptr ds:[bp+1Eh], dx	;@12062
	pop	es	;@12066
	pop	bp	;@12067
	pop	ds	;@12068
	jmp	short @@19	;@12069
@@18:	mov	word ptr ds:[4EDCh], dx	;@1206B
@@19:	mov	bx, word ptr es:[bp+0Ch]	;@1206F
	or	bx, bx	;@12073
	je	@@20	;@12075
	mov	ax, word ptr es:[bp+4]	;@12077
	mov	dx, word ptr es:[bp+6]	;@1207B
	mov	cx, word ptr es:[bp+8]	;@1207F
	mov	word ptr ds:[4ED2h], bx	;@12083
	push	ax	;@12087
	mov	ax, bx	;@12088
	push	cs	;@1208A
	call	L101E0	;@1208B
	pop	ax	;@1208E
	call	L123F5	;@1208F
	pop	di	;@12092
	pop	cx	;@12093
	stc	;@12094
	ret	;@12095
@@20:	call	far ptr L03520	;@12096
	mov	cx, 4026h	;@1209B
	jmp	L126B7	;@1209E
@@21:	mov	al, 0Ah	;@120A1
	dec	di	;@120A3
	stosb	;@120A4
	mov	cx, 25h	;@120A5
	push	ds	;@120A8
	push	bp	;@120A9
	push	si	;@120AA
	push	es	;@120AB
	push	di	;@120AC
	push	ss	;@120AD
	pop	ds	;@120AE
	push	cs	;@120AF
	call	L126B7	;@120B0
	pop	di	;@120B3
	pop	es	;@120B4
	pop	si	;@120B5
	pop	bp	;@120B6
	pop	ds	;@120B7
L120B8:	mov	cx, word ptr ds:[bp+4]	;@120B8
	add	cx, bp	;@120BC
	sub	cx, si	;@120BE
	je	@@2	;@120C0
	mov	ah, 0Ah	;@120C2
@@1:	lodsb	;@120C4
	cmp	al, ah	;@120C5
	loopne	@@1	;@120C7
	je	@@3	;@120C9
@@2:	call	L120D1	;@120CB
	jae	L120B8	;@120CE
@@3:	ret	;@120D0
L120D1:	mov	cx, word ptr ds:[bp]	;@120D1
	jcxz	@@1	;@120D5
	push	es	;@120D7
	mov	ax, cx	;@120D8
	push	cs	;@120DA
	call	L101E0	;@120DB
	push	es	;@120DE
	pop	ds	;@120DF
	pop	es	;@120E0
	mov	si, bp	;@120E1
	add	si, 6	;@120E3
	clc	;@120E6
	ret	;@120E7
@@1:	sub	si, bp	;@120E8
	sub	si, 6	;@120EA
	push	ss	;@120ED
	pop	ds	;@120EE
	push	es	;@120EF
	push	di	;@120F0
	mov	ax, word ptr ss:[4ED2h]	;@120F1
	push	cs	;@120F5
	call	L101E0	;@120F6
	mov	word ptr es:[bp+12h], si	;@120F9
	call	L1243E	;@120FD
	jb	@@2	;@12100
	mov	ax, word ptr es:[bp+10h]	;@12102
	push	cs	;@12106
	call	L101E0	;@12107
	push	es	;@1210A
	pop	ds	;@1210B
	mov	si, bp	;@1210C
	add	si, 6	;@1210E
	clc	;@12111
@@2:	pop	di	;@12112
	pop	es	;@12113
	ret	;@12114
L12115:	xor	ax, ax	;@12115
@@1:	mov	bx, word ptr es:[bp+0Ch]	;@12117
	and	bx, bx	;@1211B
	je	@@2	;@1211D
	push	ax	;@1211F
	mov	ax, bx	;@12120
	push	cs	;@12122
	call	L101E0	;@12123
	pop	ax	;@12126
	inc	ax	;@12127
	jmp	@@1	;@12128
@@2:	ret	;@1212A
L1212B:	mov	word ptr ds:[4EE8h], 0	;@1212B
	mov	word ptr ds:[4EEAh], bp	;@12131
	add	word ptr ds:[4EEAh], 10h	;@12135
	mov	word ptr ds:[4EECh], es	;@1213A
	ret	;@1213E
L1213F:	les	di, dword ptr ds:[4EEAh]	;@1213F
	mov	ax, word ptr ds:[4EE8h]	;@12143
	stosw	;@12146
	push	cs	;@12147
	call	L101E0	;@12148
	mov	word ptr ds:[4EECh], es	;@1214B
	mov	word ptr ds:[4EEAh], bp	;@1214F
	add	word ptr ds:[4EEAh], 0	;@12153
	mov	word ptr ds:[4EE8h], 0	;@12158
	ret	;@1215E
L1215F:	mov	ax, word ptr ds:[4EE8h]	;@1215F
	and	ax, ax	;@12162
	je	@@2	;@12164
	push	cs	;@12166
	call	L101E0	;@12167
	mov	ax, word ptr es:[bp+4]	;@1216A
	add	ax, 0Fh	;@1216E
	mov	cl, 4	;@12171
	shr	ax, cl	;@12173
	mov	dx, word ptr es:[bp+2]	;@12175
	shr	dx, cl	;@12179
	sub	dx, ax	;@1217B
	je	@@1	;@1217D
	add	ax, word ptr ds:[4EE8h]	;@1217F
	push	cs	;@12183
	call	L1015C	;@12184
	shl	dx, cl	;@12187
	sub	word ptr es:[bp+2], dx	;@12189
@@1:	call	L1213F	;@1218D
@@2:	les	di, dword ptr ds:[4EEAh]	;@12190
	xor	ax, ax	;@12194
	stosw	;@12196
	ret	;@12197
L12198:	add	ax, 15h	;@12198
	mov	cl, 4	;@1219B
	shr	ax, cl	;@1219D
	push	ax	;@1219F
	push	cs	;@121A0
	call	L10085	;@121A1
	pop	cx	;@121A4
	cmp	ax, cx	;@121A5
	jb	@@1	;@121A7
	mov	ax, cx	;@121A9
@@1:	cmp	ax, 2	;@121AB
	jae	@@2	;@121AE
	mov	ax, 2	;@121B0
@@2:	mov	cx, ax	;@121B3
	push	cs	;@121B5
	call	L100B0	;@121B6
	mov	word ptr ds:[4EE8h], ax	;@121B9
	push	cs	;@121BC
	call	L101E0	;@121BD
	mov	ax, cx	;@121C0
	mov	cl, 4	;@121C2
	shl	ax, cl	;@121C4
	mov	word ptr es:[bp+2], ax	;@121C6
	mov	word ptr es:[bp+4], 6	;@121CA
	ret	;@121D0
L121D1:	xor	ax, ax	;@121D1
	mov	word ptr es:[bp+14h], ax	;@121D3
	xchg	word ptr es:[bp+10h], ax	;@121D7
	push	es	;@121DB
	push	bp	;@121DC
@@1:	and	ax, ax	;@121DD
	je	@@2	;@121DF
	push	cs	;@121E1
	call	L101E0	;@121E2
	push	word ptr es:[bp]	;@121E5
	mov	dx, word ptr es:[bp+2]	;@121E9
	mov	cl, 4	;@121ED
	shr	dx, cl	;@121EF
	push	cs	;@121F1
	call	L1015C	;@121F2
	pop	ax	;@121F5
	jmp	@@1	;@121F6
@@2:	pop	bp	;@121F8
	pop	es	;@121F9
	ret	;@121FA
L121FB:	mov	ax, word ptr es:[bp+10h]	;@121FB
	mov	word ptr es:[bp+14h], ax	;@121FF
	mov	word ptr es:[bp+12h], 0	;@12203
	ret	;@12209
L1220A:	test	byte ptr es:[bp+3], 80h	;@1220A
	jne	@@2	;@1220F
	cmp	word ptr ds:[4EE4h], 0	;@12211
	jne	@@1	;@12216
	push	es	;@12218
	push	bp	;@12219
	call	L122F8	;@1221A
	pop	bp	;@1221D
	pop	es	;@1221E
@@1:	push	es	;@1221F
	push	bp	;@12220
	mov	ax, word ptr es:[bp]	;@12221
	push	cs	;@12225
	call	L1035F	;@12226
	push	ds	;@12229
	push	es	;@1222A
	pop	ds	;@1222B
	mov	dx, di	;@1222C
	mov	al, 0	;@1222E
	push	cs	;@12230
	call	L11996	;@12231
	pop	ds	;@12234
	pop	bp	;@12235
	pop	es	;@12236
	jb	@@6	;@12237
	mov	word ptr es:[bp+26h], bx	;@12239
	or	byte ptr es:[bp+3], 80h	;@1223D
	dec	word ptr ds:[4EE4h]	;@12242
	jmp	short @@3	;@12246
@@2:	call	L12310	;@12248
@@3:	mov	cx, word ptr ds:[4EE0h]	;@1224B
	push	cs	;@1224F
	call	L101F7	;@12250
	mov	dx, ax	;@12253
	mov	word ptr ds:[4EE0h], dx	;@12255
	mov	word ptr es:[bp+22h], cx	;@12259
	mov	word ptr es:[bp+24h], 0	;@1225D
	jcxz	@@4	;@12263
	push	ds	;@12265
	push	bp	;@12266
	push	es	;@12267
	mov	ax, cx	;@12268
	push	cs	;@1226A
	call	L101E0	;@1226B
	push	es	;@1226E
	pop	ds	;@1226F
	mov	word ptr ds:[bp+24h], dx	;@12270
	pop	es	;@12274
	pop	bp	;@12275
	pop	ds	;@12276
	jmp	short @@5	;@12277
@@4:	mov	word ptr ds:[4EDEh], dx	;@12279
@@5:	ret	;@1227D
@@6:	push	cs	;@1227E
	call	L101F7	;@1227F
	mov	di, ax	;@12282
	mov	cx, 6024h	;@12284
	jmp	L126B7	;@12287
L1228A:	mov	ax, word ptr es:[bp+12h]	;@1228A
	add	word ptr es:[bp+1Ah], ax	;@1228E
	adc	word ptr es:[bp+1Ch], 0	;@12292
	mov	word ptr es:[bp+12h], 0	;@12297
	and	byte ptr es:[bp+3], 0BFh	;@1229D
	push	es	;@122A2
	push	bp	;@122A3
	mov	ax, word ptr es:[bp+10h]	;@122A4
	push	cs	;@122A8
	call	L101E0	;@122A9
	mov	dx, word ptr es:[bp+2]	;@122AC
	pop	bp	;@122B0
	pop	es	;@122B1
	mov	cl, 4	;@122B2
	shr	dx, cl	;@122B4
	add	word ptr ds:[4EE2h], dx	;@122B6
	call	L121D1	;@122BA
L122BD:	push	bp	;@122BD
	push	es	;@122BE
	mov	dx, word ptr es:[bp+1Eh]	;@122BF
	mov	cx, word ptr es:[bp+20h]	;@122C3
	jcxz	@@1	;@122C7
	push	ds	;@122C9
	mov	ax, cx	;@122CA
	push	cs	;@122CC
	call	L101E0	;@122CD
	push	es	;@122D0
	pop	ds	;@122D1
	mov	word ptr ds:[bp+1Eh], dx	;@122D2
	pop	ds	;@122D6
	jmp	short @@2	;@122D7
@@1:	mov	word ptr ds:[4EDCh], dx	;@122D9
@@2:	and	dx, dx	;@122DD
	je	@@3	;@122DF
	push	ds	;@122E1
	mov	ax, dx	;@122E2
	push	cs	;@122E4
	call	L101E0	;@122E5
	push	es	;@122E8
	pop	ds	;@122E9
	mov	word ptr ds:[bp+20h], cx	;@122EA
	pop	ds	;@122EE
	jmp	short @@4	;@122EF
@@3:	mov	word ptr ds:[4EDAh], cx	;@122F1
@@4:	pop	es	;@122F5
	pop	bp	;@122F6
	ret	;@122F7
L122F8:	mov	ax, word ptr ds:[4EDEh]	;@122F8
	push	cs	;@122FB
	call	L101E0	;@122FC
	inc	word ptr ds:[4EE4h]	;@122FF
	and	byte ptr es:[bp+3], 7Fh	;@12303
	mov	bx, word ptr es:[bp+26h]	;@12308
	push	cs	;@1230C
	call	L119AC	;@1230D
L12310:	push	bp	;@12310
	push	es	;@12311
	mov	dx, word ptr es:[bp+22h]	;@12312
	mov	cx, word ptr es:[bp+24h]	;@12316
	jcxz	@@1	;@1231A
	push	ds	;@1231C
	mov	ax, cx	;@1231D
	push	cs	;@1231F
	call	L101E0	;@12320
	push	es	;@12323
	pop	ds	;@12324
	mov	word ptr ds:[bp+22h], dx	;@12325
	pop	ds	;@12329
	jmp	short @@2	;@1232A
@@1:	mov	word ptr ds:[4EE0h], dx	;@1232C
@@2:	and	dx, dx	;@12330
	je	@@3	;@12332
	push	ds	;@12334
	mov	ax, dx	;@12335
	push	cs	;@12337
	call	L101E0	;@12338
	push	es	;@1233B
	pop	ds	;@1233C
	mov	word ptr ds:[bp+24h], cx	;@1233D
	pop	ds	;@12341
	jmp	short @@4	;@12342
@@3:	mov	word ptr ds:[4EDEh], cx	;@12344
@@4:	pop	es	;@12348
	pop	bp	;@12349
	ret	;@1234A
L1234B:	push	di	;@1234B
	push	cs	;@1234C
	call	L101E0	;@1234D
	mov	di, bp	;@12350
	push	es	;@12352
	pop	ds	;@12353
	mov	byte ptr [di+2], dl	;@12354
	pop	word ptr [di]	;@12357
	mov	byte ptr [di+3], bl	;@12359
	mov	dx, ax	;@1235C
	xor	ax, ax	;@1235E
	mov	word ptr [di+0Eh], ax	;@12360
	mov	word ptr [di+10h], ax	;@12363
	mov	word ptr [di+4], ax	;@12366
	mov	cx, word ptr ss:[4ED2h]	;@12369
	mov	word ptr [di+0Ch], cx	;@1236E
	jcxz	@@1	;@12371
	mov	ax, cx	;@12373
	push	cs	;@12375
	call	L101E0	;@12376
	mov	ax, word ptr es:[bp+0Eh]	;@12379
	mov	word ptr [di+4], ax	;@1237D
	mov	ax, word ptr ss:[516Eh]	;@12380
	inc	ax	;@12384
	mov	word ptr [di+18h], ax	;@12385
@@1:	mov	ax, ds	;@12388
	mov	es, ax	;@1238A
	mov	bp, di	;@1238C
	push	ss	;@1238E
	pop	ds	;@1238F
	mov	cx, word ptr ds:[4ED8h]	;@12390
	jcxz	@@2	;@12394
	push	ds	;@12396
	push	bp	;@12397
	push	es	;@12398
	mov	ax, cx	;@12399
	push	cs	;@1239B
	call	L101E0	;@1239C
	mov	di, bp	;@1239F
	push	es	;@123A1
	pop	ds	;@123A2
	pop	es	;@123A3
	pop	bp	;@123A4
	mov	cx, word ptr [di+0Ah]	;@123A5
	mov	word ptr [di+0Ah], dx	;@123A8
	pop	ds	;@123AB
	jmp	short @@3	;@123AC
@@2:	mov	cx, word ptr ds:[4ED6h]	;@123AE
	mov	word ptr ds:[4ED6h], dx	;@123B2
@@3:	mov	word ptr es:[bp+0Ah], cx	;@123B6
	mov	word ptr ds:[4ED8h], dx	;@123BA
	ret	;@123BE
L123BF:	mov	cx, word ptr es:[bp+0Ch]	;@123BF
	xor	ax, ax	;@123C3
	jcxz	@@3	;@123C5
	push	es	;@123C7
	push	bp	;@123C8
	mov	ax, cx	;@123C9
	push	cs	;@123CB
	call	L101E0	;@123CC
	mov	ax, word ptr es:[bp+12h]	;@123CF
	test	byte ptr es:[bp+3], 1	;@123D3
	je	@@1	;@123D8
	mov	cx, word ptr es:[bp+14h]	;@123DA
	jmp	short @@2	;@123DE
@@1:	xor	cx, cx	;@123E0
	add	ax, word ptr es:[bp+1Ah]	;@123E2
	adc	cx, word ptr es:[bp+1Ch]	;@123E6
@@2:	pop	bp	;@123EA
	pop	es	;@123EB
@@3:	mov	word ptr es:[bp+6], ax	;@123EC
	mov	word ptr es:[bp+8], cx	;@123F0
	ret	;@123F4
L123F5:	mov	word ptr es:[bp+0Eh], ax	;@123F5
	test	byte ptr es:[bp+3], 1	;@123F9
	jne	@@1	;@123FE
	cmp	word ptr es:[bp+10h], 0	;@12400
	je	L12469	;@12405
	mov	si, dx	;@12407
	mov	di, cx	;@12409
	sub	si, word ptr es:[bp+1Ah]	;@1240B
	sbb	di, word ptr es:[bp+1Ch]	;@1240F
	jb	L12462	;@12413
	and	di, di	;@12415
	jne	L12462	;@12417
	push	es	;@12419
	push	bp	;@1241A
	mov	ax, word ptr es:[bp+10h]	;@1241B
	push	cs	;@1241F
	call	L101E0	;@12420
	mov	ax, word ptr es:[bp+4]	;@12423
	sub	ax, 6	;@12427
	cmp	si, ax	;@1242A
	pop	bp	;@1242C
	pop	es	;@1242D
	jae	L12462	;@1242E
	mov	word ptr es:[bp+12h], si	;@12430
	ret	;@12434
@@1:	mov	word ptr es:[bp+14h], cx	;@12435
	mov	word ptr es:[bp+12h], dx	;@12439
	ret	;@1243D
L1243E:	test	byte ptr es:[bp+3], 41h	;@1243E
	jne	@@1	;@12443
	mov	dx, word ptr es:[bp+1Ah]	;@12445
	mov	cx, word ptr es:[bp+1Ch]	;@12449
	add	dx, word ptr es:[bp+12h]	;@1244D
	adc	cx, 0	;@12451
	call	@@2	;@12454
	clc	;@12457
	ret	;@12458
@@1:	stc	;@12459
	ret	;@1245A
@@2:	cmp	word ptr es:[bp+10h], 0	;@1245B
	je	L12469	;@12460
L12462:	push	cx	;@12462
	push	dx	;@12463
	call	L1228A	;@12464
	pop	dx	;@12467
	pop	cx	;@12468
L12469:	mov	word ptr es:[bp+1Ah], dx	;@12469
	mov	word ptr es:[bp+1Ch], cx	;@1246D
	call	L1212B	;@12471
	call	L1220A	;@12474
	xor	al, al	;@12477
	mov	bx, word ptr es:[bp+26h]	;@12479
	mov	dx, word ptr es:[bp+1Ah]	;@1247D
	mov	cx, word ptr es:[bp+1Ch]	;@12481
	push	cs	;@12485
	call	L119CA	;@12486
	jb	@@2	;@12489
	mov	bx, word ptr es:[bp+26h]	;@1248B
	mov	si, word ptr es:[bp+1Ah]	;@1248F
	push	es	;@12493
	push	bp	;@12494
	mov	ax, word ptr ds:[4EE6h]	;@12495
	push	bx	;@12498
	push	si	;@12499
	call	L12198	;@1249A
	pop	si	;@1249D
	pop	bx	;@1249E
	mov	ax, word ptr ds:[4EE8h]	;@1249F
	push	cs	;@124A2
	call	L101E0	;@124A3
	mov	cx, word ptr es:[bp+2]	;@124A6
	sub	cx, 6	;@124AA
	mov	ax, es	;@124AD
	mov	dx, bp	;@124AF
	add	dx, 6	;@124B1
	cmp	cx, 1000h	;@124B4
	jb	@@1	;@124B8
	add	cx, si	;@124BA
	and	cx, 0F000h	;@124BC
	sub	cx, si	;@124C0
@@1:	push	cs	;@124C2
	call	L119B2	;@124C3
	jae	@@3	;@124C6
@@2:	mov	byte ptr ds:[38C8h], 5	;@124C8
	mov	sp, word ptr ds:[38ACh]	;@124CD
	retf	;@124D1
@@3:	mov	si, ax	;@124D2
	add	si, 6	;@124D4
	mov	word ptr es:[bp+4], si	;@124D7
	or	ax, ax	;@124DB
	je	@@4	;@124DD
	cmp	ax, cx	;@124DF
	je	@@7	;@124E1
@@4:	mov	byte ptr es:[bp+si], 0Ah	;@124E3
	inc	word ptr es:[bp+4]	;@124E7
	pop	bp	;@124EB
	pop	es	;@124EC
	or	byte ptr es:[bp+3], 40h	;@124ED
	call	L12310	;@124F2
	mov	cx, word ptr ds:[4EDEh]	;@124F5
	push	cs	;@124F9
	call	L101F7	;@124FA
	mov	dx, ax	;@124FD
	mov	word ptr ds:[4EDEh], dx	;@124FF
	mov	word ptr es:[bp+24h], cx	;@12503
	mov	word ptr es:[bp+22h], 0	;@12507
	jcxz	@@5	;@1250D
	push	ds	;@1250F
	push	bp	;@12510
	push	es	;@12511
	mov	ax, cx	;@12512
	push	cs	;@12514
	call	L101E0	;@12515
	push	es	;@12518
	pop	ds	;@12519
	mov	word ptr ds:[bp+22h], dx	;@1251A
	pop	es	;@1251E
	pop	bp	;@1251F
	pop	ds	;@12520
	jmp	short @@6	;@12521
@@5:	mov	word ptr ds:[4EE0h], dx	;@12523
@@6:	jmp	short @@8	;@12527
@@7:	pop	bp	;@12529
	pop	es	;@1252A
	and	byte ptr es:[bp+3], 0BFh	;@1252B
@@8:	push	es	;@12530
	push	bp	;@12531
	call	L1215F	;@12532
	pop	bp	;@12535
	pop	es	;@12536
	call	L121FB	;@12537
	push	es	;@1253A
	push	bp	;@1253B
	mov	ax, word ptr es:[bp+10h]	;@1253C
	push	cs	;@12540
	call	L101E0	;@12541
	mov	ax, word ptr es:[bp+2]	;@12544
	mov	cl, 4	;@12548
	shr	ax, cl	;@1254A
@@9:	cmp	word ptr ds:[4EE2h], ax	;@1254C
	jb	@@12	;@12550
	sub	word ptr ds:[4EE2h], ax	;@12552
	pop	bp	;@12556
	pop	es	;@12557
	mov	cx, word ptr ds:[4EDCh]	;@12558
	push	cs	;@1255C
	call	L101F7	;@1255D
	mov	dx, ax	;@12560
	mov	word ptr ds:[4EDCh], dx	;@12562
	mov	word ptr es:[bp+1Eh], cx	;@12566
	mov	word ptr es:[bp+20h], 0	;@1256A
	jcxz	@@10	;@12570
	push	ds	;@12572
	push	bp	;@12573
	push	es	;@12574
	mov	ax, cx	;@12575
	push	cs	;@12577
	call	L101E0	;@12578
	push	es	;@1257B
	pop	ds	;@1257C
	mov	word ptr ds:[bp+20h], dx	;@1257D
	pop	es	;@12581
	pop	bp	;@12582
	pop	ds	;@12583
	jmp	short @@11	;@12584
@@10:	mov	word ptr ds:[4EDAh], dx	;@12586
@@11:	ret	;@1258A
@@12:	push	ax	;@1258B
	mov	ax, word ptr ds:[4EDAh]	;@1258C
	push	cs	;@1258F
	call	L101E0	;@12590
	call	L1228A	;@12593
	pop	ax	;@12596
	jmp	@@9	;@12597
L12599:	cmp	word ptr ds:[4EF0h], bp	;@12599
	jae	@@2	;@1259D
	push	dx	;@1259F
	mov	dx, word ptr ds:[4EF0h]	;@125A0
	and	dx, dx	;@125A4
	je	@@1	;@125A6
	mov	word ptr ds:[4EF0h], 0	;@125A8
	mov	ax, word ptr ds:[4EEEh]	;@125AE
	push	cs	;@125B1
	call	L1015C	;@125B2
@@1:	pop	dx	;@125B5
	mov	ax, bp	;@125B6
	mov	cx, 200h	;@125B8
	push	cs	;@125BB
	call	L100B0	;@125BC
	mov	word ptr ds:[4EF0h], cx	;@125BF
	mov	word ptr ds:[4EEEh], ax	;@125C3
@@2:	mov	ax, word ptr ds:[4EEEh]	;@125C6
	add	word ptr ds:[4EEEh], bp	;@125C9
	sub	word ptr ds:[4EF0h], bp	;@125CD
	ret	;@125D1
L125D2:	test	byte ptr ds:[38C9h], 0Fh	;@125D2
	je	@@2	;@125D7
	mov	cx, word ptr ds:[4ED2h]	;@125D9
	jcxz	@@2	;@125DD
	mov	ax, cx	;@125DF
	push	cs	;@125E1
	call	L101E0	;@125E2
	mov	dx, cx	;@125E5
	mov	ax, word ptr es:[bp+0Eh]	;@125E7
	push	ax	;@125EB
	mov	ax, word ptr ds:[4ED8h]	;@125EC
	push	cs	;@125EF
	call	L101E0	;@125F0
	pop	ax	;@125F3
@@1:	mov	cx, word ptr es:[bp+0Ah]	;@125F4
	jcxz	@@2	;@125F8
	push	ax	;@125FA
	mov	ax, cx	;@125FB
	push	cs	;@125FD
	call	L101E0	;@125FE
	pop	ax	;@12601
	cmp	ax, word ptr es:[bp+4]	;@12602
	jne	@@1	;@12606
	cmp	dx, word ptr es:[bp+0Ch]	;@12608
	jne	@@1	;@1260C
	ret	;@1260E
@@2:	stc	;@1260F
	ret	;@12610
L12611:	xor	ax, ax	;@12611
	mov	word ptr ds:[4EF6h], ax	;@12613
	mov	word ptr ds:[4EF8h], ax	;@12616
	mov	word ptr ds:[4EFAh], ax	;@12619
	mov	word ptr ds:[4EFCh], ax	;@1261C
	mov	word ptr ds:[38B0h], ax	;@1261F
	mov	word ptr ds:[38B2h], ax	;@12622
	retf	;@12625
L12626:	mov	ax, word ptr ds:[4EF6h]	;@12626
@@1:	and	ax, ax	;@12629
	jne	@@2	;@1262B
	jmp	L12864	;@1262D
@@2:	push	cs	;@12630
	call	L101E0	;@12631
	push	word ptr es:[bp]	;@12634
	mov	cx, word ptr es:[bp+4]	;@12638
	test	cx, 4000h	;@1263C
	jne	@@7	;@12640
	and	cx, 7FFh	;@12642
	cmp	cx, 8Bh	;@12646
	je	@@7	;@1264A
	cmp	cx, 73h	;@1264C
	je	@@7	;@1264F
	cmp	cx, 79h	;@12651
	je	@@7	;@12654
	cmp	cx, 2Ah	;@12656
	je	@@7	;@12659
	cmp	cx, 17h	;@1265B
	je	@@7	;@1265E
	cmp	cx, 3Bh	;@12660
	je	@@7	;@12663
	cmp	word ptr es:[bp+6], 0	;@12665
	je	@@7	;@1266A
	push	ax	;@1266C
	push	bp	;@1266D
	push	es	;@1266E
	mov	dx, word ptr es:[bp+2]	;@1266F
	mov	cx, word ptr es:[bp]	;@12673
	jcxz	@@3	;@12677
	push	ds	;@12679
	mov	ax, cx	;@1267A
	push	cs	;@1267C
	call	L101E0	;@1267D
	push	es	;@12680
	pop	ds	;@12681
	mov	word ptr ds:[bp+2], dx	;@12682
	pop	ds	;@12686
	jmp	short @@4	;@12687
@@3:	mov	word ptr ds:[4EF8h], dx	;@12689
@@4:	and	dx, dx	;@1268D
	je	@@5	;@1268F
	push	ds	;@12691
	mov	ax, dx	;@12692
	push	cs	;@12694
	call	L101E0	;@12695
	push	es	;@12698
	pop	ds	;@12699
	mov	word ptr ds:[bp], cx	;@1269A
	pop	ds	;@1269E
	jmp	short @@6	;@1269F
@@5:	mov	word ptr ds:[4EF6h], cx	;@126A1
@@6:	pop	es	;@126A5
	pop	bp	;@126A6
	pop	ax	;@126A7
	mov	dx, 1	;@126A8
	push	cs	;@126AB
	call	L1015C	;@126AC
	dec	word ptr ds:[38B0h]	;@126AF
@@7:	pop	ax	;@126B3
	jmp	@@1	;@126B4
L126B7:	test	cx, 4000h	;@126B7
	jne	@@3	;@126BB
	test	cx, 8000h	;@126BD
	jne	@@1	;@126C1
	test	word ptr ds:[517Ch], 200h	;@126C3
	jne	@@1	;@126C9
	test	byte ptr ds:[38CAh], 4	;@126CB
	je	@@1	;@126D0
	retf	;@126D2
@@1:	test	byte ptr ds:[38CAh], 1	;@126D3
	je	@@2	;@126D8
	retf	;@126DA
@@2:	test	cx, 8000h	;@126DB
	jne	@@3	;@126DF
	or	byte ptr ds:[38CAh], 4	;@126E1
@@3:	push	es	;@126E6
	push	bp	;@126E7
	push	ax	;@126E8
	push	di	;@126E9
	push	si	;@126EA
	mov	ax, 1	;@126EB
	push	cx	;@126EE
	mov	cx, ax	;@126EF
	push	cs	;@126F1
	call	L100B0	;@126F2
	pop	cx	;@126F5
	push	cs	;@126F6
	call	L101E0	;@126F7
	mov	si, bp	;@126FA
	mov	word ptr es:[si+4], cx	;@126FC
	mov	word ptr es:[si+0Ah], di	;@12700
	mov	word ptr es:[si+0Ch], dx	;@12704
	mov	ax, word ptr ds:[516Eh]	;@12708
	mov	word ptr es:[si+8], ax	;@1270B
	mov	ax, word ptr ds:[517Ah]	;@1270F
	mov	word ptr es:[si+6], ax	;@12712
	test	byte ptr ds:[38C9h], 0Fh	;@12716
	jne	@@6	;@1271B
	mov	bp, si	;@1271D
	mov	cx, word ptr ds:[4EF8h]	;@1271F
	push	cs	;@12723
	call	L101F7	;@12724
	mov	dx, ax	;@12727
	mov	word ptr ds:[4EF8h], dx	;@12729
	mov	word ptr es:[bp+2], cx	;@1272D
	mov	word ptr es:[bp], 0	;@12731
	jcxz	@@4	;@12737
	push	ds	;@12739
	push	bp	;@1273A
	push	es	;@1273B
	mov	ax, cx	;@1273C
	push	cs	;@1273E
	call	L101E0	;@1273F
	push	es	;@12742
	pop	ds	;@12743
	mov	word ptr ds:[bp], dx	;@12744
	pop	es	;@12748
	pop	bp	;@12749
	pop	ds	;@1274A
	jmp	short @@5	;@1274B
@@4:	mov	word ptr ds:[4EF6h], dx	;@1274D
@@5:	call	L12B21	;@12751
	jmp	@@20	;@12754
@@6:	mov	bx, es	;@12757
	mov	bp, si	;@12759
@@7:	mov	ax, word ptr ds:[4EFAh]	;@1275B
@@8:	and	ax, ax	;@1275E
	jne	@@9	;@12760
	jmp	@@15	;@12762
@@9:	mov	es, bx	;@12765
	mov	cx, word ptr es:[bp+8]	;@12767
	mov	di, word ptr es:[bp+6]	;@1276B
	push	bp	;@1276F
	push	cs	;@12770
	call	L101E0	;@12771
	mov	si, bp	;@12774
	pop	bp	;@12776
	mov	ax, word ptr es:[si+8]	;@12777
	mov	dx, word ptr es:[si+6]	;@1277B
	push	cs	;@1277F
	call	L11EA6	;@12780
	ja	@@15	;@12783
	mov	ax, word ptr es:[si]	;@12785
	mov	word ptr ds:[4EFAh], ax	;@12788
	jne	@@8	;@1278B
	mov	ax, word ptr es:[si+4]	;@1278D
	mov	dx, word ptr es:[si+0Ah]	;@12791
	mov	cx, es	;@12795
	mov	es, bx	;@12797
	cmp	ax, word ptr es:[bp+4]	;@12799
	jne	@@7	;@1279D
	test	ax, 1800h	;@1279F
	je	@@10	;@127A2
	cmp	dx, word ptr es:[bp+0Ah]	;@127A4
	jne	@@7	;@127A8
@@10:	push	bp	;@127AA
	mov	es, cx	;@127AB
	mov	bp, si	;@127AD
	push	bp	;@127AF
	push	es	;@127B0
	mov	dx, word ptr es:[bp+2]	;@127B1
	mov	cx, word ptr es:[bp]	;@127B5
	jcxz	@@11	;@127B9
	push	ds	;@127BB
	mov	ax, cx	;@127BC
	push	cs	;@127BE
	call	L101E0	;@127BF
	push	es	;@127C2
	pop	ds	;@127C3
	mov	word ptr ds:[bp+2], dx	;@127C4
	pop	ds	;@127C8
	jmp	short @@12	;@127C9
@@11:	mov	word ptr ds:[4EF8h], dx	;@127CB
@@12:	and	dx, dx	;@127CF
	je	@@13	;@127D1
	push	ds	;@127D3
	mov	ax, dx	;@127D4
	push	cs	;@127D6
	call	L101E0	;@127D7
	push	es	;@127DA
	pop	ds	;@127DB
	mov	word ptr ds:[bp], cx	;@127DC
	pop	ds	;@127E0
	jmp	short @@14	;@127E1
@@13:	mov	word ptr ds:[4EF6h], cx	;@127E3
@@14:	pop	es	;@127E7
	pop	bp	;@127E8
	push	cs	;@127E9
	call	L101F7	;@127EA
	pop	bp	;@127ED
	mov	dx, 1	;@127EE
	push	cs	;@127F1
	call	L1015C	;@127F2
@@15:	mov	cx, word ptr ds:[4EFAh]	;@127F5
	mov	es, bx	;@127F9
	mov	si, bp	;@127FB
	push	bp	;@127FD
	push	es	;@127FE
	push	cs	;@127FF
	call	L101F7	;@12800
	mov	dx, ax	;@12803
	jcxz	@@16	;@12805
	push	ds	;@12807
	mov	ax, cx	;@12808
	push	cs	;@1280A
	call	L101E0	;@1280B
	push	es	;@1280E
	pop	ds	;@1280F
	mov	ax, word ptr ds:[bp+2]	;@12810
	mov	word ptr ds:[bp+2], dx	;@12814
	pop	ds	;@12818
	jmp	short @@17	;@12819
@@16:	mov	ax, word ptr ds:[4EF8h]	;@1281B
	mov	word ptr ds:[4EF8h], dx	;@1281E
@@17:	and	ax, ax	;@12822
	je	@@18	;@12824
	push	ds	;@12826
	push	cs	;@12827
	call	L101E0	;@12828
	push	es	;@1282B
	pop	ds	;@1282C
	mov	word ptr ds:[bp], dx	;@1282D
	pop	ds	;@12831
	jmp	short @@19	;@12832
@@18:	mov	word ptr ds:[4EF6h], dx	;@12834
@@19:	pop	es	;@12838
	pop	bp	;@12839
	mov	word ptr es:[bp+2], ax	;@1283A
	mov	word ptr es:[bp], cx	;@1283E
	call	L12B21	;@12842
@@20:	mov	ax, word ptr ds:[4EF6h]	;@12845
	mov	word ptr ds:[4EFCh], ax	;@12848
	test	word ptr es:[si+4], 4000h	;@1284B
	je	@@21	;@12851
	mov	byte ptr ds:[38C8h], 0Ah	;@12853
	mov	sp, word ptr ds:[38ACh]	;@12858
	stc	;@1285C
	retf	;@1285D
@@21:	pop	si	;@1285E
	pop	di	;@1285F
	pop	ax	;@12860
	pop	bp	;@12861
	pop	es	;@12862
	retf	;@12863
L12864:	mov	ax, word ptr ds:[4EF6h]	;@12864
	mov	word ptr ds:[4EFAh], ax	;@12867
	mov	word ptr ds:[4EFCh], ax	;@1286A
	retf	;@1286D
L1286E:	mov	cx, word ptr ds:[4EFCh]	;@1286E
@@1:	jcxz	@@3	;@12872
	mov	ax, cx	;@12874
	push	cs	;@12876
	call	L101E0	;@12877
	mov	si, bp	;@1287A
	mov	ax, word ptr ds:[516Eh]	;@1287C
	mov	dx, word ptr ds:[517Ah]	;@1287F
	mov	cx, word ptr es:[si+8]	;@12883
	mov	di, word ptr es:[si+6]	;@12887
	push	cs	;@1288B
	call	L11EA6	;@1288C
	jb	@@3	;@1288F
	jne	@@2	;@12891
	push	es	;@12893
	push	si	;@12894
	call	L12995	;@12895
	mov	si, 4F04h	;@12898
	push	cs	;@1289B
	call	L106AB	;@1289C
	pop	si	;@1289F
	pop	es	;@128A0
@@2:	mov	cx, word ptr es:[si]	;@128A1
	mov	word ptr ds:[4EFCh], cx	;@128A4
	jmp	@@1	;@128A8
@@3:	retf	;@128AA
L128AB:	mov	word ptr ds:[4EFEh], si	;@128AB
	mov	ax, word ptr ds:[38C2h]	;@128AF
	mov	word ptr ds:[4F00h], ax	;@128B2
	mov	ax, word ptr ds:[38C4h]	;@128B5
	mov	word ptr ds:[4F02h], ax	;@128B8
	mov	cx, word ptr ds:[4EF6h]	;@128BB
@@1:	jcxz	@@3	;@128BF
	mov	ax, cx	;@128C1
	push	cs	;@128C3
	call	L101E0	;@128C4
	mov	si, bp	;@128C7
	cmp	word ptr ds:[4F00h], 0	;@128C9
	je	@@4	;@128CE
	test	word ptr es:[si+4], 8000h	;@128D0
	jne	@@2	;@128D6
	cmp	word ptr ds:[4F02h], 0	;@128D8
	je	@@4	;@128DD
	dec	word ptr ds:[4F02h]	;@128DF
@@2:	dec	word ptr ds:[4F00h]	;@128E3
	push	es	;@128E7
	push	si	;@128E8
	call	L12B4A	;@128E9
	pop	si	;@128EC
	pop	es	;@128ED
	mov	cx, word ptr es:[si]	;@128EE
	jmp	@@1	;@128F1
@@3:	retf	;@128F3
@@4:	push	es	;@128F4
	push	si	;@128F5
	mov	ax, 1	;@128F6
	mov	cx, ax	;@128F9
	push	cs	;@128FB
	call	L100B0	;@128FC
	push	cs	;@128FF
	call	L101E0	;@12900
	mov	si, bp	;@12903
	mov	word ptr es:[si+4], 56h	;@12905
	pop	bx	;@1290B
	pop	ds	;@1290C
	mov	ax, word ptr [bx+8]	;@1290D
	mov	word ptr es:[si+8], ax	;@12910
	mov	ax, word ptr [bx+6]	;@12914
	mov	word ptr es:[si+6], ax	;@12917
	push	ds	;@1291B
	push	bx	;@1291C
	push	ss	;@1291D
	pop	ds	;@1291E
	push	es	;@1291F
	push	si	;@12920
	call	L12B4A	;@12921
	pop	si	;@12924
	pop	es	;@12925
	mov	bp, si	;@12926
	push	cs	;@12928
	call	L101F7	;@12929
	mov	dx, 1	;@1292C
	push	cs	;@1292F
	call	L1015C	;@12930
	pop	si	;@12933
	pop	es	;@12934
@@5:	test	word ptr es:[si+4], 4000h	;@12935
	je	@@6	;@1293B
	push	es	;@1293D
	push	si	;@1293E
	call	L12B4A	;@1293F
	pop	si	;@12942
	pop	es	;@12943
@@6:	mov	ax, word ptr es:[si]	;@12944
	and	ax, ax	;@12947
	je	@@3	;@12949
	push	cs	;@1294B
	call	L101E0	;@1294C
	mov	si, bp	;@1294F
	jmp	@@5	;@12951
L12953:	push	es	;@12953
	push	si	;@12954
	mov	dx, word ptr es:[si+6]	;@12955
	mov	ax, word ptr es:[si+8]	;@12959
	push	cs	;@1295D
	call	L11D9C	;@1295E
	and	dx, dx	;@12961
	je	@@3	;@12963
	push	cs	;@12965
	call	L11DE5	;@12966
	mov	di, 4F04h	;@12969
	mov	cx, 100h	;@1296C
	push	cs	;@1296F
	call	L11D63	;@12970
	push	ds	;@12973
	pop	es	;@12974
	mov	si, 4F04h	;@12975
	mov	di, si	;@12978
@@1:	lodsb	;@1297A
	cmp	al, 0Dh	;@1297B
	je	@@4	;@1297D
	cmp	al, 9	;@1297F
	je	@@2	;@12981
	cmp	al, 20h	;@12983
	jb	@@1	;@12985
@@2:	stosb	;@12987
	jmp	@@1	;@12988
@@3:	push	ds	;@1298A
	pop	es	;@1298B
	mov	di, 4F04h	;@1298C
@@4:	xor	al, al	;@1298F
	stosb	;@12991
	pop	si	;@12992
	pop	es	;@12993
	ret	;@12994
L12995:	mov	bp, si	;@12995
	mov	bx, 4F04h	;@12997
	test	word ptr es:[bp+4], 4000h	;@1299A
	mov	si, 1A5Ah	;@129A0
	jne	@@1	;@129A3
	test	word ptr es:[bp+4], 8000h	;@129A5
	mov	si, 1A57h	;@129AB
	je	@@1	;@129AE
	mov	si, 1A54h	;@129B0
@@1:	call	@@18	;@129B3
	push	es	;@129B6
	push	bp	;@129B7
	mov	ax, word ptr es:[bp+8]	;@129B8
	mov	dx, word ptr es:[bp+6]	;@129BC
	push	cs	;@129C0
	call	L11D9C	;@129C1
	push	ax	;@129C4
	push	cs	;@129C5
	call	L11DBF	;@129C6
	pop	ax	;@129C9
	call	@@7	;@129CA
	pop	bp	;@129CD
	pop	es	;@129CE
	push	es	;@129CF
	push	bp	;@129D0
	mov	ax, word ptr es:[bp+8]	;@129D1
	mov	dx, word ptr es:[bp+6]	;@129D5
	push	ax	;@129D9
	push	cs	;@129DA
	call	L11DBF	;@129DB
	pop	ax	;@129DE
	and	dl, dl	;@129DF
	je	@@2	;@129E1
	call	@@7	;@129E3
@@2:	pop	bp	;@129E6
	pop	es	;@129E7
	mov	ax, word ptr es:[bp+4]	;@129E8
	and	ax, 7FFh	;@129EC
	shl	ax, 1	;@129EF
	mov	si, ax	;@129F1
	mov	si, word ptr [si+0A70h]	;@129F3
	mov	byte ptr [bx], 1	;@129F7
	inc	bx	;@129FA
	mov	word ptr [bx], si	;@129FB
	add	bx, 2	;@129FD
	test	word ptr es:[bp+4], 1000h	;@12A00
	je	@@3	;@12A06
	mov	si, 1A5Dh	;@12A08
	call	@@18	;@12A0B
	push	es	;@12A0E
	push	bp	;@12A0F
	mov	ax, word ptr es:[bp+0Ah]	;@12A10
	push	cs	;@12A14
	call	L101E0	;@12A15
	call	far ptr L03528	;@12A18
	call	@@20	;@12A1D
	pop	bp	;@12A20
	pop	es	;@12A21
	jmp	short @@6	;@12A22
@@3:	test	word ptr es:[bp+4], 2000h	;@12A24
	je	@@4	;@12A2A
	mov	si, 1A5Dh	;@12A2C
	call	@@18	;@12A2F
	push	es	;@12A32
	push	bp	;@12A33
	mov	dx, word ptr es:[bp+0Ah]	;@12A34
	push	cs	;@12A38
	call	L11DBF	;@12A39
	mov	si, di	;@12A3C
	call	@@17	;@12A3E
	pop	bp	;@12A41
	pop	es	;@12A42
	jmp	short @@6	;@12A43
@@4:	test	word ptr es:[bp+4], 800h	;@12A45
	je	@@6	;@12A4B
	mov	si, 1A60h	;@12A4D
	call	@@18	;@12A50
	mov	cx, word ptr es:[bp+0Ch]	;@12A53
	jcxz	@@5	;@12A57
	mov	ax, cx	;@12A59
	call	@@9	;@12A5B
@@5:	mov	ax, word ptr es:[bp+0Ah]	;@12A5E
	call	@@9	;@12A62
	mov	si, 1A65h	;@12A65
	call	@@18	;@12A68
@@6:	mov	byte ptr [bx], 0	;@12A6B
	inc	bx	;@12A6E
	mov	di, bx	;@12A6F
	ret	;@12A71
@@7:	mov	cx, ax	;@12A72
	mov	si, di	;@12A74
	call	@@17	;@12A76
	mov	ax, es	;@12A79
	mov	si, ds	;@12A7B
	cmp	ax, si	;@12A7D
	mov	al, 3Ah	;@12A7F
	je	@@8	;@12A81
	mov	byte ptr [bx], 28h	;@12A83
	inc	bx	;@12A86
	mov	ax, cx	;@12A87
	inc	ax	;@12A89
	call	@@13	;@12A8A
	mov	al, 29h	;@12A8D
@@8:	mov	byte ptr [bx], al	;@12A8F
	inc	bx	;@12A91
	mov	byte ptr [bx], 20h	;@12A92
	inc	bx	;@12A95
	ret	;@12A96
@@9:	xchg	al, ah	;@12A97
	call	@@10	;@12A99
	mov	al, ah	;@12A9C
@@10:	mov	ch, al	;@12A9E
	mov	cl, 4	;@12AA0
	shr	al, cl	;@12AA2
	call	@@11	;@12AA4
	mov	al, ch	;@12AA7
	and	al, 0Fh	;@12AA9
@@11:	add	al, 30h	;@12AAB
	cmp	al, 39h	;@12AAD
	jbe	@@12	;@12AAF
	add	al, 7	;@12AB1
@@12:	mov	byte ptr [bx], al	;@12AB3
	inc	bx	;@12AB5
	ret	;@12AB6
@@13:	mov	ch, 30h	;@12AB7
	mov	si, 2710h	;@12AB9
	call	@@14	;@12ABC
	mov	si, 3E8h	;@12ABF
	call	@@14	;@12AC2
	mov	si, 64h	;@12AC5
	call	@@14	;@12AC8
	mov	si, 0Ah	;@12ACB
	call	@@14	;@12ACE
	mov	si, 1	;@12AD1
	mov	ch, 0FFh	;@12AD4
@@14:	mov	cl, 2Fh	;@12AD6
@@15:	inc	cl	;@12AD8
	sub	ax, si	;@12ADA
	jae	@@15	;@12ADC
	add	ax, si	;@12ADE
	cmp	cl, ch	;@12AE0
	je	@@16	;@12AE2
	mov	ch, 0FFh	;@12AE4
	mov	byte ptr [bx], cl	;@12AE6
	inc	bx	;@12AE8
@@16:	ret	;@12AE9
@@17:	mov	al, byte ptr es:[si]	;@12AEA
	and	al, al	;@12AED
	je	@@19	;@12AEF
	mov	byte ptr [bx], al	;@12AF1
	inc	bx	;@12AF3
	inc	si	;@12AF4
	jmp	@@17	;@12AF5
@@18:	mov	al, byte ptr [si]	;@12AF7
	and	al, al	;@12AF9
	je	@@19	;@12AFB
	mov	byte ptr [bx], al	;@12AFD
	inc	bx	;@12AFF
	inc	si	;@12B00
	jmp	@@18	;@12B01
@@19:	ret	;@12B03
@@20:	jcxz	@@24	;@12B04
@@21:	mov	al, byte ptr es:[di]	;@12B06
	cmp	al, 21h	;@12B09
	jae	@@23	;@12B0B
	inc	di	;@12B0D
	loop	@@21	;@12B0E
	ret	;@12B10
@@22:	mov	al, byte ptr es:[di]	;@12B11
	cmp	al, 20h	;@12B14
	jae	@@23	;@12B16
	mov	al, 20h	;@12B18
@@23:	mov	byte ptr [bx], al	;@12B1A
	inc	bx	;@12B1C
	inc	di	;@12B1D
	loop	@@22	;@12B1E
@@24:	ret	;@12B20
L12B21:	inc	word ptr ds:[38B2h]	;@12B21
	mov	ax, word ptr ds:[38C2h]	;@12B25
	cmp	ax, word ptr ds:[38B2h]	;@12B28
	jae	@@1	;@12B2C
	mov	word ptr ds:[38B2h], ax	;@12B2E
@@1:	test	word ptr es:[si+4], 8000h	;@12B31
	jne	@@2	;@12B37
	inc	word ptr ds:[38B0h]	;@12B39
	mov	ax, word ptr ds:[38C4h]	;@12B3D
	cmp	ax, word ptr ds:[38B0h]	;@12B40
	jae	@@2	;@12B44
	mov	word ptr ds:[38B0h], ax	;@12B46
@@2:	ret	;@12B49
L12B4A:	test	word ptr ds:[38B6h], 2000h	;@12B4A
	je	@@1	;@12B50
	call	L12953	;@12B52
	mov	bx, 4F04h	;@12B55
	mov	cx, 0FFFFh	;@12B58
	sub	di, bx	;@12B5B
	push	es	;@12B5D
	push	si	;@12B5E
	call	word ptr ds:[4EFEh]	;@12B5F
	pop	si	;@12B63
	pop	es	;@12B64
@@1:	push	si	;@12B65
	call	L12995	;@12B66
	pop	si	;@12B69
	push	di	;@12B6A
	push	word ptr es:[si+4]	;@12B6B
	mov	ax, word ptr es:[si+8]	;@12B6F
	mov	dx, word ptr es:[si+6]	;@12B73
	push	cs	;@12B77
	call	L11D9C	;@12B78
	pop	cx	;@12B7B
	pop	di	;@12B7C
	mov	bx, 4F04h	;@12B7D
	sub	di, bx	;@12B80
	jmp	word ptr ds:[4EFEh]	;@12B82
L12B86:	xor	ax, ax	;@12B86
	mov	word ptr ds:[5010h], ax	;@12B88
	mov	word ptr ds:[5004h], ax	;@12B8B
	mov	word ptr ds:[5006h], ax	;@12B8E
	mov	word ptr ds:[5012h], ax	;@12B91
	mov	word ptr ds:[5014h], ax	;@12B94
	mov	word ptr ds:[5018h], ax	;@12B97
	mov	word ptr ds:[500Ch], 1Fh	;@12B9A
	retf	;@12BA0
L12BA1:	push	bp	;@12BA1
	call	L1375C	;@12BA2
	mov	byte ptr es:[bp+4], 18h	;@12BA5
	mov	byte ptr es:[bp+0Ch], bl	;@12BAA
	pop	word ptr es:[bp+8]	;@12BAE
	retf	;@12BB2
L12BB3:	push	bp	;@12BB3
	call	L1375C	;@12BB4
	mov	byte ptr es:[bp+4], 17h	;@12BB7
	mov	word ptr es:[bp+0Ch], si	;@12BBC
	mov	word ptr es:[bp+0Eh], di	;@12BC0
	pop	word ptr es:[bp+8]	;@12BC4
	retf	;@12BC8
L12BC9:	push	bp	;@12BC9
	call	L1375C	;@12BCA
	mov	byte ptr es:[bp+4], 19h	;@12BCD
	mov	word ptr es:[bp+0Ch], si	;@12BD2
	mov	word ptr es:[bp+0Eh], di	;@12BD6
	pop	word ptr es:[bp+8]	;@12BDA
	retf	;@12BDE
L12BDF:	push	bp	;@12BDF
	call	L1375C	;@12BE0
	mov	byte ptr es:[bp+4], 1Ah	;@12BE3
	mov	word ptr es:[bp+0Ch], si	;@12BE8
	mov	word ptr es:[bp+0Eh], di	;@12BEC
	pop	word ptr es:[bp+8]	;@12BF0
	retf	;@12BF4
L12BF5:	cmp	word ptr ds:[5014h], 0	;@12BF5
	je	@@5	;@12BFA
@@1:	cmp	cx, word ptr ds:[5018h]	;@12BFC
	jne	@@8	;@12C00
	cmp	bp, word ptr ds:[501Ah]	;@12C02
	jne	@@8	;@12C06
	cmp	ax, word ptr ds:[5016h]	;@12C08
	jne	@@8	;@12C0C
	sub	di, word ptr ds:[5020h]	;@12C0E
	je	@@4	;@12C12
	cmp	di, 0Fh	;@12C14
	ja	@@7	;@12C17
	sub	bx, word ptr ds:[501Ch]	;@12C19
	sbb	dx, word ptr ds:[501Eh]	;@12C1D
	jne	@@6	;@12C21
	cmp	bx, 0Fh	;@12C23
	ja	@@6	;@12C26
	add	word ptr ds:[5020h], di	;@12C28
	add	word ptr ds:[501Ch], bx	;@12C2C
	adc	word ptr ds:[501Eh], dx	;@12C30
	mov	ax, di	;@12C34
	mov	cl, 4	;@12C36
	shl	al, cl	;@12C38
	or	al, bl	;@12C3A
@@2:	push	ax	;@12C3C
	mov	ax, word ptr ds:[5014h]	;@12C3D
	push	cs	;@12C40
	call	L101E0	;@12C41
	pop	ax	;@12C44
	mov	di, word ptr es:[bp+6]	;@12C45
	cmp	di, 3FFh	;@12C49
	ja	@@10	;@12C4D
	add	di, bp	;@12C4F
	stosb	;@12C51
@@3:	sub	di, bp	;@12C52
	mov	word ptr es:[bp+6], di	;@12C54
@@4:	retf	;@12C58
@@5:	push	ax	;@12C59
	call	@@12	;@12C5A
	pop	ax	;@12C5D
	jmp	@@1	;@12C5E
@@6:	add	bx, word ptr ds:[501Ch]	;@12C60
	adc	dx, word ptr ds:[501Eh]	;@12C64
@@7:	add	di, word ptr ds:[5020h]	;@12C68
@@8:	mov	word ptr ds:[5016h], ax	;@12C6C
	mov	word ptr ds:[5018h], cx	;@12C6F
	mov	word ptr ds:[501Ah], bp	;@12C73
	mov	word ptr ds:[501Ch], bx	;@12C77
	mov	word ptr ds:[501Eh], dx	;@12C7B
	mov	word ptr ds:[5020h], di	;@12C7F
@@9:	push	di	;@12C83
	push	bp	;@12C84
	push	ax	;@12C85
	mov	ax, word ptr ds:[5014h]	;@12C86
	push	cs	;@12C89
	call	L101E0	;@12C8A
	mov	di, word ptr es:[bp+6]	;@12C8D
	cmp	di, 3F3h	;@12C91
	ja	@@11	;@12C95
	add	di, bp	;@12C97
	xor	al, al	;@12C99
	stosb	;@12C9B
	pop	ax	;@12C9C
	stosw	;@12C9D
	mov	ax, cx	;@12C9E
	stosw	;@12CA0
	pop	ax	;@12CA1
	stosw	;@12CA2
	mov	ax, bx	;@12CA3
	stosw	;@12CA5
	mov	ax, dx	;@12CA6
	stosw	;@12CA8
	pop	ax	;@12CA9
	stosw	;@12CAA
	jmp	@@3	;@12CAB
@@10:	push	ax	;@12CAD
	call	L12E44	;@12CAE
	call	@@12	;@12CB1
	pop	ax	;@12CB4
	jmp	@@2	;@12CB5
@@11:	push	cx	;@12CB7
	push	dx	;@12CB8
	call	L12E44	;@12CB9
	pop	dx	;@12CBC
	pop	cx	;@12CBD
	call	@@12	;@12CBE
	pop	ax	;@12CC1
	pop	bp	;@12CC2
	pop	di	;@12CC3
	jmp	@@9	;@12CC4
@@12:	push	cx	;@12CC6
	push	dx	;@12CC7
	mov	dx, 40h	;@12CC8
	call	L13827	;@12CCB
	pop	dx	;@12CCE
	pop	cx	;@12CCF
	mov	word ptr ds:[5014h], ax	;@12CD0
	push	es	;@12CD3
	push	bp	;@12CD4
	push	cs	;@12CD5
	call	L101E0	;@12CD6
	mov	byte ptr es:[bp+4], 4	;@12CD9
	mov	byte ptr es:[bp+5], 40h	;@12CDE
	mov	word ptr es:[bp+6], 8	;@12CE3
	pop	bp	;@12CE9
	pop	es	;@12CEA
	ret	;@12CEB
L12CEC:	push	ax	;@12CEC
	push	cx	;@12CED
	mov	cx, 4	;@12CEE
	call	L12DF8	;@12CF1
	pop	cx	;@12CF4
	pop	bx	;@12CF5
	mov	al, 0	;@12CF6
	stosb	;@12CF8
	mov	ax, bx	;@12CF9
	stosw	;@12CFB
	mov	al, cl	;@12CFC
	stosb	;@12CFE
	retf	;@12CFF
L12D00:	push	di	;@12D00
	push	cx	;@12D01
	push	ax	;@12D02
	mov	cx, 0Fh	;@12D03
	call	L12DF8	;@12D06
	mov	al, 6	;@12D09
	stosb	;@12D0B
	pop	ax	;@12D0C
	stosw	;@12D0D
	pop	ax	;@12D0E
	stosw	;@12D0F
	mov	ax, bp	;@12D10
	stosw	;@12D12
	mov	ax, dx	;@12D13
	stosw	;@12D15
	mov	ax, bx	;@12D16
	stosw	;@12D18
	mov	ax, si	;@12D19
	stosw	;@12D1B
	pop	ax	;@12D1C
	stosw	;@12D1D
	retf	;@12D1E
L12D1F:	push	di	;@12D1F
	push	cx	;@12D20
	push	ax	;@12D21
	mov	cx, 0Ah	;@12D22
	call	L12DF8	;@12D25
	mov	al, 7	;@12D28
	stosb	;@12D2A
	pop	ax	;@12D2B
	stosw	;@12D2C
	pop	ax	;@12D2D
	stosb	;@12D2E
	mov	ax, bp	;@12D2F
	stosw	;@12D31
	mov	ax, si	;@12D32
	stosw	;@12D34
	pop	ax	;@12D35
	stosw	;@12D36
	retf	;@12D37
L12D38:	push	cx	;@12D38
	push	ax	;@12D39
	mov	cx, 6	;@12D3A
	call	L12DF8	;@12D3D
	mov	al, 8	;@12D40
	stosb	;@12D42
	pop	ax	;@12D43
	stosw	;@12D44
	pop	ax	;@12D45
	stosb	;@12D46
	mov	ax, bp	;@12D47
	stosw	;@12D49
	retf	;@12D4A
L12D4B:	push	ax	;@12D4B
	mov	cx, 7	;@12D4C
	call	L12DF8	;@12D4F
	pop	cx	;@12D52
	mov	al, 4	;@12D53
	stosb	;@12D55
	mov	ax, cx	;@12D56
	stosw	;@12D58
	mov	ax, bx	;@12D59
	stosw	;@12D5B
	mov	ax, dx	;@12D5C
	stosw	;@12D5E
	retf	;@12D5F
L12D60:	mov	cx, 5	;@12D60
	call	L12DF8	;@12D63
	mov	al, 5	;@12D66
	stosb	;@12D68
	mov	ax, bx	;@12D69
	stosw	;@12D6B
	mov	ax, dx	;@12D6C
	stosw	;@12D6E
	retf	;@12D6F
L12D70:	mov	cx, 1	;@12D70
	call	L12DF8	;@12D73
	mov	al, 1	;@12D76
	stosb	;@12D78
	retf	;@12D79
L12D7A:	cmp	cx, word ptr ds:[5018h]	;@12D7A
	jne	@@2	;@12D7E
	cmp	bp, word ptr ds:[501Ah]	;@12D80
	jne	@@2	;@12D84
	mov	ax, di	;@12D86
	sub	ax, word ptr ds:[5020h]	;@12D88
	cmp	ax, 100h	;@12D8C
	jae	@@2	;@12D8F
	sub	bx, word ptr ds:[501Ch]	;@12D91
	sbb	dx, word ptr ds:[501Eh]	;@12D95
	jne	@@1	;@12D99
	cmp	bx, 100h	;@12D9B
	jae	@@1	;@12D9F
	add	word ptr ds:[5020h], ax	;@12DA1
	add	word ptr ds:[501Ch], bx	;@12DA5
	adc	word ptr ds:[501Eh], dx	;@12DA9
	mov	ah, bl	;@12DAD
	mov	bx, ax	;@12DAF
	mov	cx, 3	;@12DB1
	call	L12DF8	;@12DB4
	mov	al, 3	;@12DB7
	stosb	;@12DB9
	mov	al, bl	;@12DBA
	stosb	;@12DBC
	mov	al, bh	;@12DBD
	stosb	;@12DBF
	retf	;@12DC0
@@1:	add	bx, word ptr ds:[501Ch]	;@12DC1
	adc	dx, word ptr ds:[501Eh]	;@12DC5
@@2:	mov	word ptr ds:[5020h], di	;@12DC9
	mov	word ptr ds:[501Ch], bx	;@12DCD
	mov	word ptr ds:[501Eh], dx	;@12DD1
	mov	word ptr ds:[5018h], cx	;@12DD5
	mov	word ptr ds:[501Ah], bp	;@12DD9
	mov	cx, 0Bh	;@12DDD
	call	L12DF8	;@12DE0
	mov	al, 2	;@12DE3
	stosb	;@12DE5
	mov	ax, bp	;@12DE6
	stosw	;@12DE8
	mov	ax, word ptr ds:[5018h]	;@12DE9
	stosw	;@12DEC
	mov	ax, word ptr ds:[5020h]	;@12DED
	stosw	;@12DF0
	mov	ax, bx	;@12DF1
	stosw	;@12DF3
	mov	ax, dx	;@12DF4
	stosw	;@12DF6
	retf	;@12DF7
L12DF8:	push	bp	;@12DF8
	mov	ax, word ptr ds:[5012h]	;@12DF9
	and	ax, ax	;@12DFC
	je	@@2	;@12DFE
	push	cs	;@12E00
	call	L101E0	;@12E01
	mov	ax, word ptr es:[bp+6]	;@12E04
	mov	di, bp	;@12E08
	add	di, ax	;@12E0A
	add	ax, cx	;@12E0C
	cmp	ax, 400h	;@12E0E
	ja	@@1	;@12E11
	mov	word ptr es:[bp+6], ax	;@12E13
	pop	bp	;@12E17
	ret	;@12E18
@@1:	push	cx	;@12E19
	push	dx	;@12E1A
	call	L12E52	;@12E1B
	pop	dx	;@12E1E
	pop	cx	;@12E1F
@@2:	push	cx	;@12E20
	push	dx	;@12E21
	mov	dx, 40h	;@12E22
	call	L13827	;@12E25
	pop	dx	;@12E28
	pop	cx	;@12E29
	mov	word ptr ds:[5012h], ax	;@12E2A
	push	cs	;@12E2D
	call	L101E0	;@12E2E
	mov	byte ptr es:[bp+4], 5	;@12E31
	mov	byte ptr es:[bp+5], 40h	;@12E36
	mov	word ptr es:[bp+6], 8	;@12E3B
	pop	bp	;@12E41
	jmp	L12DF8	;@12E42
L12E44:	mov	cx, word ptr ds:[5014h]	;@12E44
	jcxz	L12E96	;@12E48
	mov	word ptr ds:[5014h], 0	;@12E4A
	jmp	short L12E5E	;@12E50
L12E52:	mov	cx, word ptr ds:[5012h]	;@12E52
	jcxz	L12E96	;@12E56
	mov	word ptr ds:[5012h], 0	;@12E58
L12E5E:	mov	ax, cx	;@12E5E
	push	cs	;@12E60
	call	L101E0	;@12E61
	mov	cx, word ptr ds:[5006h]	;@12E64
	push	cs	;@12E68
	call	L101F7	;@12E69
	mov	dx, ax	;@12E6C
	mov	word ptr ds:[5006h], dx	;@12E6E
	mov	word ptr es:[bp], cx	;@12E72
	mov	word ptr es:[bp+2], 0	;@12E76
	jcxz	@@1	;@12E7C
	push	ds	;@12E7E
	push	bp	;@12E7F
	push	es	;@12E80
	mov	ax, cx	;@12E81
	push	cs	;@12E83
	call	L101E0	;@12E84
	push	es	;@12E87
	pop	ds	;@12E88
	mov	word ptr ds:[bp+2], dx	;@12E89
	pop	es	;@12E8D
	pop	bp	;@12E8E
	pop	ds	;@12E8F
	jmp	short L12E96	;@12E90
@@1:	mov	word ptr ds:[5004h], dx	;@12E92
L12E96:	ret	;@12E96
L12E97:	call	L1375C	;@12E97
	mov	byte ptr es:[bp+4], 10h	;@12E9A
	retf	;@12E9F
L12EA0:	call	L1375C	;@12EA0
	mov	byte ptr es:[bp+4], 11h	;@12EA3
	retf	;@12EA8
L12EA9:	call	L1375C	;@12EA9
	mov	byte ptr es:[bp+4], 8	;@12EAC
	mov	word ptr es:[bp+0Ah], bx	;@12EB1
	mov	word ptr es:[bp+0Ch], dx	;@12EB5
	push	cs	;@12EB9
	call	L101F7	;@12EBA
	retf	;@12EBD
L12EBE:	call	L1375C	;@12EBE
	mov	byte ptr es:[bp+4], 9	;@12EC1
	push	cs	;@12EC6
	call	L101F7	;@12EC7
	retf	;@12ECA
L12ECB:	call	L1375C	;@12ECB
	mov	byte ptr es:[bp+4], 0Ah	;@12ECE
	mov	word ptr es:[bp+0Ah], 0	;@12ED3
	push	cs	;@12ED9
	call	L101F7	;@12EDA
	retf	;@12EDD
L12EDE:	call	L1375C	;@12EDE
	mov	byte ptr es:[bp+4], 0	;@12EE1
	mov	byte ptr es:[bp+19h], dl	;@12EE6
	mov	word ptr es:[bp+14h], bx	;@12EEA
	mov	word ptr es:[bp+16h], si	;@12EEE
	mov	byte ptr es:[bp+18h], ch	;@12EF2
	xor	ax, ax	;@12EF6
	mov	word ptr es:[bp+0Ah], ax	;@12EF8
	mov	word ptr es:[bp+0Ch], ax	;@12EFC
	mov	word ptr es:[bp+0Eh], ax	;@12F00
	mov	word ptr es:[bp+10h], ax	;@12F04
	mov	word ptr es:[bp+12h], ax	;@12F08
	mov	word ptr es:[bp+1Eh], ax	;@12F0C
	mov	word ptr es:[bp+1Ch], ax	;@12F10
	mov	word ptr es:[bp+1Ah], ax	;@12F14
	push	cs	;@12F18
	call	L101F7	;@12F19
	retf	;@12F1C
L12F1D:	push	bp	;@12F1D
	call	L1375C	;@12F1E
	mov	byte ptr es:[bp+4], 0Ch	;@12F21
	pop	word ptr es:[bp+0Ah]	;@12F26
	push	cs	;@12F2A
	call	L101F7	;@12F2B
	retf	;@12F2E
L12F2F:	push	bp	;@12F2F
	call	L1375C	;@12F30
	mov	byte ptr es:[bp+4], 0Dh	;@12F33
	pop	word ptr es:[bp+0Ah]	;@12F38
	mov	word ptr es:[bp+0Ch], bx	;@12F3C
	mov	word ptr es:[bp+0Eh], dx	;@12F40
	mov	word ptr es:[bp+10h], si	;@12F44
	mov	word ptr es:[bp+12h], di	;@12F48
	mov	byte ptr es:[bp+14h], ch	;@12F4C
	push	cs	;@12F50
	call	L101F7	;@12F51
	retf	;@12F54
L12F55:	push	bp	;@12F55
	call	L1375C	;@12F56
	mov	byte ptr es:[bp+4], 0Bh	;@12F59
L12F5E:	mov	word ptr es:[bp+10h], dx	;@12F5E
	mov	word ptr es:[bp+0Ah], bx	;@12F62
	mov	word ptr es:[bp+0Ch], si	;@12F66
	mov	word ptr es:[bp+0Eh], di	;@12F6A
	pop	word ptr es:[bp+12h]	;@12F6E
	retf	;@12F72
L12F73:	push	bp	;@12F73
	call	L1375C	;@12F74
	mov	byte ptr es:[bp+4], 13h	;@12F77
	jmp	L12F5E	;@12F7C
L12F7E:	push	bp	;@12F7E
	call	L1375C	;@12F7F
	mov	byte ptr es:[bp+4], 12h	;@12F82
	jmp	L12F5E	;@12F87
L12F89:	push	bp	;@12F89
	call	L1375C	;@12F8A
	mov	byte ptr es:[bp+4], 14h	;@12F8D
	mov	word ptr es:[bp+0Ah], bx	;@12F92
	mov	word ptr es:[bp+10h], dx	;@12F96
	mov	word ptr es:[bp+0Ch], si	;@12F9A
	mov	word ptr es:[bp+0Eh], di	;@12F9E
	pop	word ptr es:[bp+8]	;@12FA2
	retf	;@12FA6
L12FA7:	push	bp	;@12FA7
	call	L1375C	;@12FA8
	mov	byte ptr es:[bp+4], 15h	;@12FAB
	mov	word ptr es:[bp+0Ch], si	;@12FB0
	mov	word ptr es:[bp+0Eh], di	;@12FB4
	pop	word ptr es:[bp+8]	;@12FB8
	retf	;@12FBC
L12FBD:	push	bp	;@12FBD
	call	L1375C	;@12FBE
	mov	byte ptr es:[bp+4], 16h	;@12FC1
	pop	word ptr es:[bp+8]	;@12FC6
	retf	;@12FCA
L12FCB:	mov	cx, ax	;@12FCB
	call	L1375C	;@12FCD
	mov	byte ptr es:[bp+4], 0Eh	;@12FD0
	mov	word ptr es:[bp+6], bx	;@12FD5
	mov	word ptr es:[bp+8], dx	;@12FD9
	mov	word ptr es:[bp+0Ah], si	;@12FDD
	mov	word ptr es:[bp+0Ch], di	;@12FE1
	mov	byte ptr es:[bp+5], cl	;@12FE5
	retf	;@12FE9
L12FEA:	call	L12E52	;@12FEA
	call	L12E44	;@12FED
	mov	al, 0	;@12FF0
	mov	bx, 392Bh	;@12FF2
	call	L1391E	;@12FF5
	retf	;@12FF8
L12FF9:	mov	al, 0	;@12FF9
	mov	bx, 38E0h	;@12FFB
	call	L1391E	;@12FFE
	retf	;@13001
L13002:	push	cs	;@13002
	call	L101E0	;@13003
	test	byte ptr ds:[38C9h], 2	;@13006
	jne	@@2	;@1300B
	cmp	dx, di	;@1300D
	jne	@@1	;@1300F
	cmp	bx, si	;@13011
	je	@@2	;@13013
@@1:	push	di	;@13015
	call	L138AB	;@13016
	pop	di	;@13019
@@2:	mov	ax, word ptr es:[bp+10h]	;@1301A
	sub	ax, si	;@1301E
	mov	ax, word ptr es:[bp+12h]	;@13020
	sbb	ax, di	;@13024
	jae	@@3	;@13026
	mov	word ptr es:[bp+10h], si	;@13028
	mov	word ptr es:[bp+12h], di	;@1302C
@@3:	retf	;@13030
L13031:	push	cs	;@13031
	call	L101E0	;@13032
	test	byte ptr ds:[38C9h], 2	;@13035
	jne	@@1	;@1303A
	call	L138AB	;@1303C
	call	L13716	;@1303F
	mov	byte ptr es:[bp+4], 0Fh	;@13042
	mov	word ptr es:[bp+6], bx	;@13047
	mov	word ptr es:[bp+8], dx	;@1304B
	retf	;@1304F
@@1:	push	es	;@13050
	push	bp	;@13051
	call	L13860	;@13052
	mov	ax, word ptr es:[bp+1Ch]	;@13055
	or	ax, ax	;@13059
	jne	@@2	;@1305B
	mov	ax, word ptr es:[bp+0Ch]	;@1305D
	jmp	short @@4	;@13061
@@2:	push	cs	;@13063
	call	L101E0	;@13064
@@3:	mov	ax, word ptr es:[bp+2]	;@13067
@@4:	or	ax, ax	;@1306B
	je	@@5	;@1306D
	push	cs	;@1306F
	call	L101E0	;@13070
	cmp	byte ptr es:[bp+4], 0Fh	;@13073
	jne	@@3	;@13078
	cmp	dx, word ptr es:[bp+8]	;@1307A
	jne	@@3	;@1307E
	cmp	bx, word ptr es:[bp+6]	;@13080
	jne	@@3	;@13084
	push	cs	;@13086
	call	L101F7	;@13087
	pop	bp	;@1308A
	pop	es	;@1308B
	mov	word ptr es:[bp+1Ch], ax	;@1308C
	mov	word ptr es:[bp+1Ah], ax	;@13090
@@5:	retf	;@13094
L13095:	push	cs	;@13095
	call	L101E0	;@13096
	test	byte ptr ds:[38C9h], 2	;@13099
	jne	@@1	;@1309E
	push	di	;@130A0
	call	L138AB	;@130A1
	pop	di	;@130A4
	call	L13716	;@130A5
	mov	byte ptr es:[bp+4], 2	;@130A8
	mov	word ptr es:[bp+14h], si	;@130AD
	mov	word ptr es:[bp+16h], di	;@130B1
	mov	word ptr es:[bp+6], bx	;@130B5
	mov	word ptr es:[bp+8], dx	;@130B9
	xor	ax, ax	;@130BD
	mov	word ptr es:[bp+0Ch], ax	;@130BF
	mov	word ptr es:[bp+0Eh], ax	;@130C3
	mov	word ptr es:[bp+10h], ax	;@130C7
	mov	word ptr es:[bp+12h], ax	;@130CB
	mov	word ptr es:[bp+1Ch], ax	;@130CF
	mov	word ptr es:[bp+1Eh], ax	;@130D3
	mov	word ptr es:[bp+1Ah], ax	;@130D7
	push	cs	;@130DB
	call	L101F7	;@130DC
	retf	;@130DF
@@1:	push	es	;@130E0
	push	bp	;@130E1
	call	L13860	;@130E2
	mov	ax, word ptr es:[bp+1Ch]	;@130E5
	or	ax, ax	;@130E9
	jne	@@4	;@130EB
	mov	ax, word ptr es:[bp+0Ch]	;@130ED
	jmp	short @@3	;@130F1
@@2:	mov	ax, word ptr es:[bp+2]	;@130F3
@@3:	or	ax, ax	;@130F7
	je	@@5	;@130F9
@@4:	push	cs	;@130FB
	call	L101E0	;@130FC
	cmp	byte ptr es:[bp+4], 2	;@130FF
	jne	@@2	;@13104
	cmp	dx, word ptr es:[bp+8]	;@13106
	jne	@@2	;@1310A
	cmp	bx, word ptr es:[bp+6]	;@1310C
	jne	@@2	;@13110
	push	cs	;@13112
	call	L101F7	;@13113
	pop	bp	;@13116
	pop	es	;@13117
	mov	word ptr es:[bp+1Ch], ax	;@13118
	mov	word ptr es:[bp+1Ah], ax	;@1311C
	retf	;@13120
@@5:	pop	bp	;@13121
	pop	es	;@13122
	retf	;@13123
L13124:	or	ax, ax	;@13124
	je	@@1	;@13126
	push	cs	;@13128
	call	L101E0	;@13129
	call	L13716	;@1312C
	jmp	short @@2	;@1312F
@@1:	mov	dx, 2	;@13131
	call	L13827	;@13134
	push	cs	;@13137
	call	L101E0	;@13138
@@2:	mov	byte ptr es:[bp+4], 1	;@1313B
	mov	word ptr es:[bp+6], bx	;@13140
	mov	word ptr es:[bp+8], dx	;@13144
	xor	ax, ax	;@13148
	mov	word ptr es:[bp+0Ch], ax	;@1314A
	mov	word ptr es:[bp+0Eh], ax	;@1314E
	mov	word ptr es:[bp+10h], ax	;@13152
	mov	word ptr es:[bp+12h], ax	;@13156
	mov	word ptr es:[bp+1Ch], ax	;@1315A
	mov	word ptr es:[bp+1Eh], ax	;@1315E
	mov	word ptr es:[bp+16h], ax	;@13162
	mov	word ptr es:[bp+18h], ax	;@13166
	mov	word ptr es:[bp+0Ah], ax	;@1316A
	mov	word ptr es:[bp+1Ah], ax	;@1316E
	mov	ax, word ptr ds:[500Ch]	;@13172
	add	word ptr ds:[500Ch], 2	;@13175
	mov	word ptr es:[bp+14h], ax	;@1317A
	push	cs	;@1317E
	call	L101F7	;@1317F
	retf	;@13182
L13183:	call	L1375C	;@13183
	mov	byte ptr es:[bp+4], 1Fh	;@13186
	mov	word ptr es:[bp+6], ax	;@1318B
	mov	word ptr es:[bp+8], dx	;@1318F
	and	dx, dx	;@13193
	je	L131B1	;@13195
	mov	word ptr es:[bp+16h], bx	;@13197
	mov	bx, word ptr ds:[500Ch]	;@1319B
	mov	word ptr es:[bp+14h], bx	;@1319F
	add	word ptr ds:[500Ch], 2	;@131A3
	retf	;@131A8
L131A9:	call	L1375C	;@131A9
	mov	byte ptr es:[bp+4], 1Bh	;@131AC
L131B1:	mov	word ptr es:[bp+16h], bx	;@131B1
	mov	bx, word ptr ds:[500Ch]	;@131B5
	mov	word ptr es:[bp+14h], bx	;@131B9
	inc	word ptr ds:[500Ch]	;@131BD
	retf	;@131C1
L131C2:	call	L1375C	;@131C2
	mov	byte ptr es:[bp+4], 1Ch	;@131C5
	jmp	L131B1	;@131CA
	db	0CBh	;@131CC
L131CD:	call	L1375C	;@131CD
	mov	byte ptr es:[bp+4], 1Dh	;@131D0
	jmp	L131B1	;@131D5
L131D7:	call	L1375C	;@131D7
	mov	byte ptr es:[bp+4], 1Eh	;@131DA
	jmp	L131B1	;@131DF
L131E1:	mov	bx, word ptr ds:[500Ch]	;@131E1
	add	word ptr ds:[500Ch], 2	;@131E5
	retf	;@131EA
L131EB:	test	byte ptr ds:[38C9h], 2	;@131EB
	jne	@@1	;@131F0
	push	cs	;@131F2
	call	L101E0	;@131F3
	push	es	;@131F6
	push	bp	;@131F7
	call	L138AB	;@131F8
	push	dx	;@131FB
	mov	dx, 1	;@131FC
	push	cx	;@131FF
	call	L13827	;@13200
	pop	cx	;@13203
	push	cs	;@13204
	call	L101E0	;@13205
	mov	byte ptr es:[bp+4], 7	;@13208
	mov	byte ptr es:[bp+5], dl	;@1320D
	mov	di, bp	;@13211
	add	di, 8	;@13213
	mov	ax, bx	;@13216
	stosw	;@13218
	pop	ax	;@13219
	stosw	;@1321A
	mov	ax, cx	;@1321B
	stosw	;@1321D
	sub	di, bp	;@1321E
	mov	word ptr es:[bp+6], di	;@13220
	push	cs	;@13224
	call	L101F7	;@13225
	pop	bp	;@13228
	pop	es	;@13229
	mov	word ptr es:[bp+1Ch], ax	;@1322A
	call	L138AB	;@1322E
@@1:	retf	;@13231
L13232:	mov	ax, word ptr es:[bp+1Ch]	;@13232
	and	ax, ax	;@13236
	jne	@@1	;@13238
	mov	ax, word ptr es:[bp+0Ch]	;@1323A
	jmp	short @@6	;@1323E
@@1:	push	es	;@13240
	push	bp	;@13241
	push	cs	;@13242
	call	L101E0	;@13243
	cmp	byte ptr es:[bp+4], 3	;@13246
	jne	@@5	;@1324B
	sub	bx, word ptr es:[bp+8]	;@1324D
	sbb	dx, word ptr es:[bp+0Ah]	;@13251
	jb	@@2	;@13255
	jne	@@4	;@13257
	cmp	bx, word ptr es:[bp+0Ch]	;@13259
	jae	@@4	;@1325D
	mov	di, bp	;@1325F
	add	di, bx	;@13261
	add	di, 0Eh	;@13263
	add	bx, cx	;@13266
	cmp	word ptr es:[bp+0Ch], bx	;@13268
	jb	@@2	;@1326C
	shr	cx, 1	;@1326E
	rep movsw	;@13270
	rcl	cx, 1	;@13272
	rep movsb	;@13274
@@2:	pop	bp	;@13276
	pop	es	;@13277
@@3:	retf	;@13278
@@4:	add	bx, word ptr es:[bp+8]	;@13279
	adc	dx, word ptr es:[bp+0Ah]	;@1327D
@@5:	mov	ax, word ptr es:[bp+2]	;@13281
	pop	bp	;@13285
	pop	es	;@13286
@@6:	and	ax, ax	;@13287
	je	@@3	;@13289
	mov	word ptr es:[bp+1Ch], ax	;@1328B
	jmp	@@1	;@1328F
	db	90h	;@13291
L13292:	push	cs	;@13292
	call	L101E0	;@13293
	test	byte ptr ds:[38C9h], 2	;@13296
	jne	L13232	;@1329B
	cmp	byte ptr es:[bp+4], 0	;@1329D
	jne	@@1	;@132A2
	mov	ax, word ptr es:[bp+1Ch]	;@132A4
	or	ax, ax	;@132A8
	je	@@3	;@132AA
	push	es	;@132AC
	push	bp	;@132AD
	push	cs	;@132AE
	call	L101E0	;@132AF
	sub	bx, word ptr es:[bp+8]	;@132B2
	mov	di, bp	;@132B6
	add	di, bx	;@132B8
	add	bx, cx	;@132BA
	cmp	bx, 1F2h	;@132BC
	ja	@@2	;@132C0
	add	di, 0Eh	;@132C2
	shr	cx, 1	;@132C5
	rep movsw	;@132C7
	rcl	cx, 1	;@132C9
	rep movsb	;@132CB
	sub	di, bp	;@132CD
	mov	word ptr es:[bp+0Ch], bx	;@132CF
	mov	word ptr es:[bp+6], di	;@132D3
	pop	bp	;@132D7
	pop	es	;@132D8
	retf	;@132D9
@@1:	mov	di, dx	;@132DA
	mov	dx, cx	;@132DC
	add	dx, 1Dh	;@132DE
	shr	dx, 1	;@132E1
	shr	dx, 1	;@132E3
	shr	dx, 1	;@132E5
	shr	dx, 1	;@132E7
	call	@@4	;@132E9
	call	L138AB	;@132EC
	retf	;@132EF
@@2:	add	bx, word ptr es:[bp+8]	;@132F0
	sub	bx, cx	;@132F4
	pop	bp	;@132F6
	pop	es	;@132F7
	call	L138AB	;@132F8
@@3:	mov	di, dx	;@132FB
	mov	dx, 20h	;@132FD
	call	@@4	;@13300
	retf	;@13303
@@4:	push	es	;@13304
	push	bp	;@13305
	push	cx	;@13306
	call	L13827	;@13307
	pop	cx	;@1330A
	push	cs	;@1330B
	call	L101E0	;@1330C
	mov	byte ptr es:[bp+4], 3	;@1330F
	mov	byte ptr es:[bp+5], dl	;@13314
	push	di	;@13318
	mov	di, bp	;@13319
	add	di, 8	;@1331B
	mov	ax, bx	;@1331E
	stosw	;@13320
	pop	ax	;@13321
	stosw	;@13322
	mov	ax, cx	;@13323
	stosw	;@13325
	shr	cx, 1	;@13326
	rep movsw	;@13328
	rcl	cx, 1	;@1332A
	rep movsb	;@1332C
	sub	di, bp	;@1332E
	mov	word ptr es:[bp+6], di	;@13330
	push	cs	;@13334
	call	L101F7	;@13335
	pop	bp	;@13338
	pop	es	;@13339
	mov	word ptr es:[bp+1Ch], ax	;@1333A
	ret	;@1333E
L1333F:	push	cs	;@1333F
	call	L101E0	;@13340
	cmp	byte ptr es:[bp+4], 0	;@13343
	jne	@@1	;@13348
	mov	ax, word ptr es:[bp+1Ch]	;@1334A
	or	ax, ax	;@1334E
	je	@@1	;@13350
	push	cs	;@13352
	call	L101E0	;@13353
	sub	bx, word ptr es:[bp+8]	;@13356
	mov	di, bx	;@1335A
	add	di, 0Eh	;@1335C
	mov	word ptr es:[bp+0Ch], bx	;@1335F
	mov	word ptr es:[bp+6], di	;@13363
@@1:	retf	;@13367
L13368:	mov	word ptr es:[bp+8], di	;@13368
	pop	di	;@1336C
L1336D:	pop	bp	;@1336D
	pop	es	;@1336E
	cmp	byte ptr es:[bp+4], 0	;@1336F
	jne	@@1	;@13374
	mov	ax, word ptr es:[bp+1Eh]	;@13376
	and	ax, ax	;@1337A
	je	@@3	;@1337C
	push	es	;@1337E
	push	bp	;@1337F
	push	cs	;@13380
	call	L101E0	;@13381
	push	di	;@13384
	mov	ax, word ptr es:[bp+6]	;@13385
	mov	di, bp	;@13389
	add	di, ax	;@1338B
	add	ax, 9	;@1338D
	cmp	ax, 0D0h	;@13390
	ja	@@2	;@13393
	jmp	L134B2	;@13395
@@1:	mov	ax, dx	;@13398
	mov	dx, 2	;@1339A
	call	L134EA	;@1339D
	call	L13860	;@133A0
	retf	;@133A3
@@2:	pop	di	;@133A4
	pop	bp	;@133A5
	pop	es	;@133A6
	call	L13860	;@133A7
@@3:	jmp	L134E1	;@133AA
L133AD:	push	di	;@133AD
	mov	di, word ptr es:[bp+6]	;@133AE
	sub	di, 9	;@133B2
	mov	ax, word ptr es:[bp+di+1]	;@133B5
	sub	ax, bx	;@133B9
	mov	ax, word ptr es:[bp+di+3]	;@133BB
	sbb	ax, dx	;@133BF
	jb	@@3	;@133C1
	mov	di, word ptr es:[bp+8]	;@133C3
@@1:	cmp	bx, word ptr es:[bp+di+1]	;@133C7
	mov	ax, dx	;@133CB
	sbb	ax, word ptr es:[bp+di+3]	;@133CD
	jb	L13368	;@133D1
	jne	@@2	;@133D3
	cmp	bx, word ptr es:[bp+di+1]	;@133D5
	je	@@4	;@133D9
@@2:	add	di, 9	;@133DB
	jmp	@@1	;@133DE
@@3:	pop	di	;@133E0
	jmp	short L1341C	;@133E1
@@4:	mov	word ptr es:[bp+8], di	;@133E3
	add	di, bp	;@133E7
	mov	al, cl	;@133E9
	stosb	;@133EB
	mov	ax, bx	;@133EC
	stosw	;@133EE
	mov	ax, dx	;@133EF
	stosw	;@133F1
	mov	ax, si	;@133F2
	stosw	;@133F4
	pop	ax	;@133F5
	stosw	;@133F6
L133F7:	pop	bp	;@133F7
	pop	es	;@133F8
L133F9:	retf	;@133F9
L133FA:	mov	ax, word ptr es:[bp+1Ah]	;@133FA
	and	ax, ax	;@133FE
	jne	L13408	;@13400
	mov	ax, word ptr es:[bp+0Ch]	;@13402
	jmp	short L13422	;@13406
L13408:	push	es	;@13408
	push	bp	;@13409
	push	cs	;@1340A
	call	L101E0	;@1340B
	cmp	byte ptr es:[bp+4], 6	;@1340E
	je	L133AD	;@13413
	cmp	byte ptr es:[bp+4], 3	;@13415
	je	L1342C	;@1341A
L1341C:	mov	ax, word ptr es:[bp+2]	;@1341C
	pop	bp	;@13420
	pop	es	;@13421
L13422:	and	ax, ax	;@13422
	je	L133F9	;@13424
	mov	word ptr es:[bp+1Ah], ax	;@13426
	jmp	L13408	;@1342A
L1342C:	sub	bx, word ptr es:[bp+8]	;@1342C
	sbb	dx, word ptr es:[bp+0Ah]	;@13430
	jb	L133F7	;@13434
	jne	@@1	;@13436
	cmp	bx, word ptr es:[bp+0Ch]	;@13438
	jae	@@1	;@1343C
	add	bx, word ptr es:[bp+8]	;@1343E
	adc	dx, word ptr es:[bp+0Ah]	;@13442
	jmp	L1336D	;@13446
@@1:	add	bx, word ptr es:[bp+8]	;@13449
	adc	dx, word ptr es:[bp+0Ah]	;@1344D
	push	cs	;@13451
	call	L101F7	;@13452
	pop	bp	;@13455
	pop	es	;@13456
	push	ax	;@13457
	call	L13860	;@13458
	pop	ax	;@1345B
	push	es	;@1345C
	push	bp	;@1345D
	push	cs	;@1345E
	call	L101E0	;@1345F
	jmp	L1341C	;@13462
L13464:	push	cs	;@13464
	call	L101E0	;@13465
	test	byte ptr ds:[38C9h], 2	;@13468
	jne	L133FA	;@1346D
	cmp	byte ptr es:[bp+4], 0	;@1346F
	jne	L134C7	;@13474
	mov	ax, word ptr es:[bp+1Ch]	;@13476
	or	ax, ax	;@1347A
	je	@@1	;@1347C
	push	es	;@1347E
	push	bp	;@1347F
	push	cs	;@13480
	call	L101E0	;@13481
	cmp	word ptr es:[bp+6], 1F0h	;@13484
	pop	bp	;@1348A
	pop	es	;@1348B
	jbe	@@1	;@1348C
	push	di	;@1348E
	call	L138AB	;@1348F
	pop	di	;@13492
@@1:	mov	ax, word ptr es:[bp+1Eh]	;@13493
	or	ax, ax	;@13497
	je	L134E1	;@13499
	push	es	;@1349B
	push	bp	;@1349C
	push	cs	;@1349D
	call	L101E0	;@1349E
	mov	ax, word ptr es:[bp+6]	;@134A1
	push	di	;@134A5
	mov	di, bp	;@134A6
	add	di, ax	;@134A8
	add	ax, 9	;@134AA
	cmp	ax, 0D0h	;@134AD
	ja	L134D6	;@134B0
L134B2:	mov	word ptr es:[bp+6], ax	;@134B2
	mov	al, cl	;@134B6
	stosb	;@134B8
	mov	ax, bx	;@134B9
	stosw	;@134BB
	mov	ax, dx	;@134BC
	stosw	;@134BE
	mov	ax, si	;@134BF
	stosw	;@134C1
	pop	ax	;@134C2
	stosw	;@134C3
	pop	bp	;@134C4
	pop	es	;@134C5
	retf	;@134C6
L134C7:	mov	ax, dx	;@134C7
	mov	dx, 2	;@134C9
	call	L134EA	;@134CC
	mov	di, 1Eh	;@134CF
	call	L138B4	;@134D2
	retf	;@134D5
L134D6:	pop	ax	;@134D6
	pop	bp	;@134D7
	pop	es	;@134D8
	push	ax	;@134D9
	mov	di, 1Eh	;@134DA
	call	L138B4	;@134DD
	pop	di	;@134E0
L134E1:	mov	ax, dx	;@134E1
	mov	dx, 0Dh	;@134E3
	call	L134EA	;@134E6
	retf	;@134E9
L134EA:	push	es	;@134EA
	push	bp	;@134EB
	push	ax	;@134EC
	push	cx	;@134ED
	call	L13827	;@134EE
	pop	cx	;@134F1
	push	cs	;@134F2
	call	L101E0	;@134F3
	mov	byte ptr es:[bp+4], 6	;@134F6
	mov	byte ptr es:[bp+5], dl	;@134FB
	mov	dx, di	;@134FF
	mov	di, bp	;@13501
	add	di, 8	;@13503
	mov	ax, 0Ah	;@13506
	stosw	;@13509
	mov	al, cl	;@1350A
	stosb	;@1350C
	mov	ax, bx	;@1350D
	stosw	;@1350F
	pop	ax	;@13510
	stosw	;@13511
	mov	ax, si	;@13512
	stosw	;@13514
	mov	ax, dx	;@13515
	stosw	;@13517
	sub	di, bp	;@13518
	mov	word ptr es:[bp+6], di	;@1351A
	push	cs	;@1351E
	call	L101F7	;@1351F
	pop	bp	;@13522
	pop	es	;@13523
	mov	word ptr es:[bp+1Eh], ax	;@13524
	ret	;@13528
L13529:	push	cs	;@13529
	call	L101E0	;@1352A
	mov	ax, word ptr es:[bp+0Ah]	;@1352D
	mov	word ptr es:[bp+0Ah], cx	;@13531
	push	ax	;@13535
	mov	ax, cx	;@13536
	push	cs	;@13538
	call	L101E0	;@13539
	pop	ax	;@1353C
	mov	word ptr es:[bp+0Ah], ax	;@1353D
	retf	;@13541
L13542:	mov	cx, word ptr ds:[5004h]	;@13542
@@1:	jcxz	@@2	;@13546
	mov	ax, cx	;@13548
	push	cs	;@1354A
	call	L101E0	;@1354B
	push	word ptr es:[bp+2]	;@1354E
	call	L137E6	;@13552
	pop	cx	;@13555
	jmp	@@1	;@13556
@@2:	mov	ax, word ptr ds:[500Eh]	;@13558
	mov	dx, word ptr ds:[5010h]	;@1355B
	and	dx, dx	;@1355F
	je	@@3	;@13561
	mov	word ptr ds:[5010h], 0	;@13563
	push	cs	;@13569
	call	L1015C	;@1356A
@@3:	retf	;@1356D
L1356E:	push	cs	;@1356E
	call	L101E0	;@1356F
	call	L137B1	;@13572
	retf	;@13575
L13576:	xor	ax, ax	;@13576
	mov	word ptr ds:[5012h], ax	;@13578
	mov	word ptr ds:[5014h], ax	;@1357B
	mov	word ptr ds:[5018h], ax	;@1357E
	mov	cx, word ptr ds:[5004h]	;@13581
@@1:	jcxz	@@6	;@13585
	mov	ax, cx	;@13587
	push	cs	;@13589
	call	L101E0	;@1358A
	mov	al, byte ptr es:[bp+4]	;@1358D
	cmp	al, 0	;@13591
	je	@@8	;@13593
	cmp	al, 0Ah	;@13595
	je	@@7	;@13597
	cmp	al, 0Ch	;@13599
	je	@@7	;@1359B
	cmp	al, 0Dh	;@1359D
	je	@@7	;@1359F
	cmp	al, 8	;@135A1
	je	@@7	;@135A3
	cmp	al, 1Bh	;@135A5
	je	@@7	;@135A7
	cmp	al, 1Ch	;@135A9
	je	@@7	;@135AB
	cmp	al, 1Dh	;@135AD
	je	@@7	;@135AF
	cmp	al, 1Eh	;@135B1
	je	@@7	;@135B3
	cmp	al, 1Fh	;@135B5
	je	@@7	;@135B7
	push	word ptr es:[bp+2]	;@135B9
	push	bp	;@135BD
	push	es	;@135BE
	mov	dx, word ptr es:[bp]	;@135BF
	mov	cx, word ptr es:[bp+2]	;@135C3
	jcxz	@@2	;@135C7
	push	ds	;@135C9
	mov	ax, cx	;@135CA
	push	cs	;@135CC
	call	L101E0	;@135CD
	push	es	;@135D0
	pop	ds	;@135D1
	mov	word ptr ds:[bp], dx	;@135D2
	pop	ds	;@135D6
	jmp	short @@3	;@135D7
@@2:	mov	word ptr ds:[5006h], dx	;@135D9
@@3:	and	dx, dx	;@135DD
	je	@@4	;@135DF
	push	ds	;@135E1
	mov	ax, dx	;@135E2
	push	cs	;@135E4
	call	L101E0	;@135E5
	push	es	;@135E8
	pop	ds	;@135E9
	mov	word ptr ds:[bp+2], cx	;@135EA
	pop	ds	;@135EE
	jmp	short @@5	;@135EF
@@4:	mov	word ptr ds:[5004h], cx	;@135F1
@@5:	pop	es	;@135F5
	pop	bp	;@135F6
	call	L137E6	;@135F7
	pop	cx	;@135FA
	jmp	@@1	;@135FB
@@6:	retf	;@135FD
@@7:	mov	cx, word ptr es:[bp+2]	;@135FE
	jmp	@@1	;@13602
@@8:	call	L137B1	;@13604
	mov	word ptr es:[bp+1Ah], ax	;@13607
	jmp	@@7	;@1360B
L1360D:	mov	dx, word ptr ds:[5010h]	;@1360D
	and	dx, dx	;@13611
	je	@@1	;@13613
	mov	word ptr ds:[5010h], 0	;@13615
	mov	ax, word ptr ds:[500Eh]	;@1361B
	push	cs	;@1361E
	call	L1015C	;@1361F
	clc	;@13622
	retf	;@13623
@@1:	stc	;@13624
	retf	;@13625
L13626:	xor	ax, ax	;@13626
	mov	word ptr ds:[5008h], ax	;@13628
	mov	word ptr ds:[500Ah], ax	;@1362B
	mov	word ptr ds:[5023h], si	;@1362E
	call	L1448E	;@13632
	test	word ptr ds:[38B6h], 10h	;@13635
	je	@@1	;@1363B
	call	L13E48	;@1363D
@@1:	mov	byte ptr ds:[5025h], 0	;@13640
	mov	al, 9	;@13645
	mov	bx, 4005h	;@13647
	call	L1446B	;@1364A
	cmp	byte ptr ds:[5025h], 0	;@1364D
	jne	@@2	;@13652
	mov	si, word ptr ds:[5023h]	;@13654
	call	L1454C	;@13658
@@2:	cmp	byte ptr ds:[38CEh], 0	;@1365B
	jne	@@3	;@13660
	mov	al, 8	;@13662
	mov	bx, 39C0h	;@13664
	call	L1446B	;@13667
@@3:	xor	ax, ax	;@1366A
	xor	cl, cl	;@1366C
	call	L145BB	;@1366E
	call	L1453D	;@13671
	call	L14566	;@13674
	mov	al, 10h	;@13677
	mov	bx, 4605h	;@13679
	call	L1446B	;@1367C
	mov	al, 11h	;@1367F
	mov	bx, 39D9h	;@13681
	call	L1446B	;@13684
	mov	al, 0	;@13687
	mov	bx, 4015h	;@13689
	call	L1446B	;@1368C
	mov	al, 0Ah	;@1368F
	mov	bx, 4046h	;@13691
	call	L1446B	;@13694
	call	L14B3C	;@13697
	mov	al, 0Ch	;@1369A
	mov	bx, 40DBh	;@1369C
	call	L1446B	;@1369F
	call	L146DE	;@136A2
	call	L14B86	;@136A5
	mov	al, 0	;@136A8
	mov	bx, 40A7h	;@136AA
	call	L1446B	;@136AD
	mov	al, 0Dh	;@136B0
	mov	bx, 4079h	;@136B2
	call	L1446B	;@136B5
	call	L146DE	;@136B8
	mov	al, 0Bh	;@136BB
	mov	bx, 411Ah	;@136BD
	call	L1446B	;@136C0
	mov	al, 13h	;@136C3
	mov	bx, 416Bh	;@136C5
	call	L1446B	;@136C8
	mov	al, 12h	;@136CB
	mov	bx, 4108h	;@136CD
	call	L1446B	;@136D0
	cmp	byte ptr ds:[38CEh], 0	;@136D3
	jne	@@4	;@136D8
	call	L14574	;@136DA
@@4:	call	L13CDB	;@136DD
	call	L13A6F	;@136E0
	call	L13964	;@136E3
	mov	al, 15h	;@136E6
	mov	bx, 3EA2h	;@136E8
	call	L1446B	;@136EB
	mov	al, 16h	;@136EE
	mov	bx, 3EB9h	;@136F0
	call	L1446B	;@136F3
	mov	al, 14h	;@136F6
	mov	bx, 3E5Fh	;@136F8
	call	L1446B	;@136FB
	mov	al, 0	;@136FE
	mov	bx, 41EDh	;@13700
	call	L1446B	;@13703
	mov	al, 0Eh	;@13706
	mov	bx, 41A8h	;@13708
	call	L1446B	;@1370B
	call	L14502	;@1370E
	retf	;@13711
L13712:	call	L144E0	;@13712
	retf	;@13715
L13716:	push	cx	;@13716
	push	dx	;@13717
	mov	dx, 2	;@13718
	call	L13827	;@1371B
	pop	dx	;@1371E
	push	si	;@1371F
	mov	cx, es	;@13720
	mov	ds, cx	;@13722
	mov	si, bp	;@13724
	mov	cx, word ptr [si+0Eh]	;@13726
	jcxz	@@1	;@13729
	push	ax	;@1372B
	mov	ax, cx	;@1372C
	push	cs	;@1372E
	call	L101E0	;@1372F
	pop	ax	;@13732
	mov	word ptr es:[bp+2], ax	;@13733
	jmp	short @@2	;@13737
@@1:	mov	word ptr [si+0Ch], ax	;@13739
@@2:	mov	word ptr [si+0Eh], ax	;@1373C
	push	cs	;@1373F
	call	L101E0	;@13740
	mov	word ptr es:[bp], cx	;@13743
	xor	cx, cx	;@13747
	mov	word ptr es:[bp+2], cx	;@13749
	mov	word ptr es:[bp+1Ch], cx	;@1374D
	mov	word ptr es:[bp+1Eh], cx	;@13751
	mov	cx, ss	;@13755
	mov	ds, cx	;@13757
	pop	si	;@13759
	pop	cx	;@1375A
	ret	;@1375B
L1375C:	push	ax	;@1375C
	push	cx	;@1375D
	push	dx	;@1375E
	mov	dx, 2	;@1375F
	call	L13827	;@13762
	push	cs	;@13765
	call	L101E0	;@13766
	mov	cx, word ptr ds:[5006h]	;@13769
	push	cs	;@1376D
	call	L101F7	;@1376E
	mov	dx, ax	;@13771
	mov	word ptr ds:[5006h], dx	;@13773
	mov	word ptr es:[bp], cx	;@13777
	mov	word ptr es:[bp+2], 0	;@1377B
	jcxz	@@1	;@13781
	push	ds	;@13783
	push	bp	;@13784
	push	es	;@13785
	mov	ax, cx	;@13786
	push	cs	;@13788
	call	L101E0	;@13789
	push	es	;@1378C
	pop	ds	;@1378D
	mov	word ptr ds:[bp+2], dx	;@1378E
	pop	es	;@13792
	pop	bp	;@13793
	pop	ds	;@13794
	jmp	short @@2	;@13795
@@1:	mov	word ptr ds:[5004h], dx	;@13797
@@2:	pop	dx	;@1379B
	xor	ax, ax	;@1379C
	mov	word ptr es:[bp+1Ch], ax	;@1379E
	mov	word ptr es:[bp+1Eh], ax	;@137A2
	pop	cx	;@137A6
	pop	ax	;@137A7
	mov	word ptr es:[bp+6], ax	;@137A8
	mov	byte ptr es:[bp+5], cl	;@137AC
	ret	;@137B0
L137B1:	mov	cx, word ptr es:[bp+0Ch]	;@137B1
	push	es	;@137B5
	push	bp	;@137B6
@@1:	jcxz	@@2	;@137B7
	mov	ax, cx	;@137B9
	push	cs	;@137BB
	call	L101E0	;@137BC
	push	word ptr es:[bp+2]	;@137BF
	call	L137E6	;@137C3
	pop	cx	;@137C6
	jmp	@@1	;@137C7
@@2:	pop	bp	;@137C9
	pop	es	;@137CA
	xor	ax, ax	;@137CB
	mov	word ptr es:[bp+0Ch], ax	;@137CD
	mov	word ptr es:[bp+0Eh], ax	;@137D1
	mov	word ptr es:[bp+10h], ax	;@137D5
	mov	word ptr es:[bp+12h], ax	;@137D9
	mov	word ptr es:[bp+1Eh], ax	;@137DD
	mov	word ptr es:[bp+1Ch], ax	;@137E1
	ret	;@137E5
L137E6:	mov	al, byte ptr es:[bp+4]	;@137E6
	cmp	al, 3	;@137EA
	jb	@@3	;@137EC
	cmp	al, 8	;@137EE
	jb	@@2	;@137F0
@@1:	push	cs	;@137F2
	call	L101F7	;@137F3
	mov	dx, 2	;@137F6
	push	cs	;@137F9
	call	L1015C	;@137FA
	ret	;@137FD
@@2:	push	cs	;@137FE
	call	L101F7	;@137FF
	mov	dl, byte ptr es:[bp+5]	;@13802
	xor	dh, dh	;@13806
	push	cs	;@13808
	call	L1015C	;@13809
	ret	;@1380C
@@3:	mov	cx, word ptr es:[bp+0Ch]	;@1380D
@@4:	jcxz	@@1	;@13811
	push	es	;@13813
	push	bp	;@13814
	mov	ax, cx	;@13815
	push	cs	;@13817
	call	L101E0	;@13818
	push	word ptr es:[bp+2]	;@1381B
	call	L137E6	;@1381F
	pop	cx	;@13822
	pop	bp	;@13823
	pop	es	;@13824
	jmp	@@4	;@13825
L13827:	cmp	word ptr ds:[5010h], dx	;@13827
	jae	@@2	;@1382B
	push	dx	;@1382D
	mov	dx, word ptr ds:[5010h]	;@1382E
	and	dx, dx	;@13832
	je	@@1	;@13834
	mov	ax, word ptr ds:[500Eh]	;@13836
	push	cs	;@13839
	call	L1015C	;@1383A
	mov	word ptr ds:[5010h], 0	;@1383D
@@1:	pop	dx	;@13843
	mov	ax, dx	;@13844
	mov	cx, 100h	;@13846
	push	cs	;@13849
	call	L100B0	;@1384A
	mov	word ptr ds:[5010h], cx	;@1384D
	mov	word ptr ds:[500Eh], ax	;@13851
@@2:	mov	ax, word ptr ds:[500Eh]	;@13854
	add	word ptr ds:[500Eh], dx	;@13857
	sub	word ptr ds:[5010h], dx	;@1385B
	ret	;@1385F
L13860:	xor	ax, ax	;@13860
	xchg	word ptr es:[bp+1Eh], ax	;@13862
	or	ax, ax	;@13866
	je	@@3	;@13868
	push	si	;@1386A
	push	cx	;@1386B
	mov	cx, es	;@1386C
	mov	ds, cx	;@1386E
	mov	si, bp	;@13870
	push	cs	;@13872
	call	L101E0	;@13873
	mov	cx, word ptr [si+1Ah]	;@13876
	mov	word ptr es:[bp+2], cx	;@13879
	push	ax	;@1387D
	mov	ax, cx	;@1387E
	push	cs	;@13880
	call	L101E0	;@13881
	pop	ax	;@13884
	mov	cx, word ptr es:[bp]	;@13885
	mov	word ptr es:[bp], ax	;@13889
	jcxz	@@1	;@1388D
	push	ax	;@1388F
	mov	ax, cx	;@13890
	push	cs	;@13892
	call	L101E0	;@13893
	pop	ax	;@13896
	mov	word ptr es:[bp+2], ax	;@13897
	jmp	short @@2	;@1389B
@@1:	mov	word ptr [si+0Ch], ax	;@1389D
@@2:	push	cs	;@138A0
	call	L101E0	;@138A1
	mov	word ptr es:[bp], cx	;@138A4
	jmp	short L138EC	;@138A8
@@3:	ret	;@138AA
L138AB:	mov	di, 1Eh	;@138AB
	call	L138B4	;@138AE
	mov	di, 1Ch	;@138B1
L138B4:	xor	ax, ax	;@138B4
	xchg	word ptr es:[bp+di], ax	;@138B6
	or	ax, ax	;@138B9
	je	L1391D	;@138BB
	push	si	;@138BD
	push	cx	;@138BE
	mov	cx, es	;@138BF
	mov	ds, cx	;@138C1
	mov	si, bp	;@138C3
	mov	cx, word ptr [si+0Eh]	;@138C5
	jcxz	@@1	;@138C8
	push	ax	;@138CA
	mov	ax, cx	;@138CB
	push	cs	;@138CD
	call	L101E0	;@138CE
	pop	ax	;@138D1
	mov	word ptr es:[bp+2], ax	;@138D2
	jmp	short @@2	;@138D6
@@1:	mov	word ptr [si+0Ch], ax	;@138D8
@@2:	mov	word ptr [si+0Eh], ax	;@138DB
	push	cs	;@138DE
	call	L101E0	;@138DF
	mov	word ptr es:[bp], cx	;@138E2
	mov	word ptr es:[bp+2], 0	;@138E6
L138EC:	mov	ax, word ptr es:[bp+6]	;@138EC
	add	ax, 0Fh	;@138F0
	mov	cl, 4	;@138F3
	shr	ax, cl	;@138F5
	push	dx	;@138F7
	mov	dx, ax	;@138F8
	xchg	byte ptr es:[bp+5], dl	;@138FA
	push	ax	;@138FE
	push	cs	;@138FF
	call	L101F7	;@13900
	mov	cx, ax	;@13903
	mov	ax, ds	;@13905
	mov	es, ax	;@13907
	mov	bp, si	;@13909
	mov	ax, ss	;@1390B
	mov	ds, ax	;@1390D
	pop	ax	;@1390F
	sub	dx, ax	;@13910
	je	@@1	;@13912
	add	ax, cx	;@13914
	push	cs	;@13916
	call	L1015C	;@13917
@@1:	pop	dx	;@1391A
	pop	cx	;@1391B
	pop	si	;@1391C
L1391D:	ret	;@1391D
L1391E:	mov	cx, word ptr ds:[5004h]	;@1391E
@@1:	jcxz	@@3	;@13922
	push	ax	;@13924
	mov	ax, cx	;@13925
	push	cs	;@13927
	call	L101E0	;@13928
	pop	ax	;@1392B
	push	word ptr es:[bp+2]	;@1392C
	cmp	byte ptr es:[bp+4], al	;@13930
	jne	@@2	;@13934
	push	ax	;@13936
	push	bx	;@13937
	call	bx	;@13938
	pop	bx	;@1393A
	pop	ax	;@1393B
@@2:	pop	cx	;@1393C
	jmp	@@1	;@1393D
@@3:	ret	;@1393F
	db	26h, 8Bh, 46h, 6, 26h, 8Ah, 4Eh, 5, 26h, 8Bh, 5Eh, 0Ah, 26h, 8Bh	;@13940
	db	56h, 0Ch, 26h, 0C7h, 46h, 8, 0, 0, 0E9h, 62h, 0Ch, 26h, 8Bh, 46h
	db	6, 26h, 8Ah, 4Eh, 5, 0E9h, 2Fh, 0Ch
L13964:	mov	word ptr ds:[5016h], 0	;@13964
	call	L1464D	;@1396A
	mov	byte ptr ds:[5025h], 0	;@1396D
	mov	bx, 3A46h	;@13972
	mov	al, 4	;@13975
	call	L1446B	;@13977
	call	L146DE	;@1397A
	cmp	byte ptr ds:[5025h], 0	;@1397D
	je	@@1	;@13982
	ret	;@13984
@@1:	test	word ptr ds:[38B6h], 4000h	;@13985
	je	@@4	;@1398B
	mov	cx, word ptr ds:[5004h]	;@1398D
@@2:	jcxz	@@4	;@13991
	mov	ax, cx	;@13993
	push	cs	;@13995
	call	L101E0	;@13996
	cmp	byte ptr es:[bp+4], 8	;@13999
	je	@@3	;@1399E
	mov	cx, word ptr es:[bp+2]	;@139A0
	jmp	@@2	;@139A4
@@3:	push	es	;@139A6
	push	bp	;@139A7
	mov	ax, word ptr es:[bp+6]	;@139A8
	mov	cl, byte ptr es:[bp+5]	;@139AC
	mov	bx, word ptr es:[bp+0Ah]	;@139B0
	mov	dx, word ptr es:[bp+0Ch]	;@139B4
	mov	bp, word ptr es:[bp+8]	;@139B8
	call	L145E3	;@139BC
	pop	bp	;@139BF
	pop	es	;@139C0
	mov	word ptr es:[bp+8], ax	;@139C1
@@4:	ret	;@139C5
	db	0C6h, 6, 25h, 50h, 0FFh, 8Bh, 0F5h, 83h, 0C6h, 8, 26h, 8Bh, 4Eh	;@139C6
	db	6, 3, 0CDh, 3Bh, 0CEh, 't$Q&', 8Ah, 4, 46h, 22h, 0C0h, 74h, 1Ch
	db	8Ah, 0D8h, 25h, 0Fh, 0, 1, 6, 1Ch, 50h, 83h, 16h, 1Eh, 50h, 0
	db	0B1h, 4, 0D2h, 0EBh, 83h, 0E3h, 0Fh, 1, 1Eh, 20h, 50h, 0EBh, 65h
	db	0C3h, 26h, 8Bh, 4, 3Bh, 6, 16h, 'Pt5', 0A3h, 16h, 50h, 6, 55h
	db	56h, 0E8h, 0CDh, 0Ch, 0A1h, 16h, 50h, 0Eh, 0E8h, 0C8h, 0C7h, 6
	db	55h, 26h, 8Bh, 46h, 6, 26h, 8Ah, 4Eh, 5, 26h, 8Bh, 5Eh, 0Ah, 26h
	db	8Bh, 56h, 0Ch, 26h, 8Bh, 6Eh, 8, 0E8h, 0B2h, 0Bh, 5Dh, 7, 26h
	db	89h, 46h, 8, 0E8h, 13h, 0Ch, 5Eh, 5Dh, 7, 26h, 8Bh, 44h, 2, 0A3h
	db	18h, 50h, 26h, 8Bh, 44h, 4, 0A3h, 1Ah, 50h, 26h, 8Bh, 44h, 6, 0A3h
	db	1Ch, 50h, 26h, 8Bh, 44h, 8, 0A3h, 1Eh, 50h, 26h, 8Bh, 44h, 0Ah
	db	0A3h, 20h, 50h, 83h, 0C6h, 0Ch, 0E8h, 3Ah, 2, 59h, 3Bh, 0F1h, 74h
	db	3, 0E9h, 6Ch, 0FFh, 0C3h
L13A6F:	call	L1464D	;@13A6F
	mov	byte ptr ds:[5022h], 0	;@13A72
	mov	cx, word ptr ds:[5004h]	;@13A77
@@1:	jcxz	@@3	;@13A7B
	mov	ax, cx	;@13A7D
	push	cs	;@13A7F
	call	L101E0	;@13A80
	cmp	byte ptr es:[bp+4], 5	;@13A83
	je	@@4	;@13A88
@@2:	mov	cx, word ptr es:[bp+2]	;@13A8A
	jmp	@@1	;@13A8E
@@3:	jmp	@@6	;@13A90
@@4:	mov	si, bp	;@13A93
	add	si, 8	;@13A95
@@5:	mov	cx, word ptr es:[bp+6]	;@13A98
	add	cx, bp	;@13A9C
	cmp	si, cx	;@13A9E
	je	@@2	;@13AA0
	mov	bl, byte ptr es:[si]	;@13AA2
	xor	bh, bh	;@13AA5
	shl	bx, 1	;@13AA7
	call	word ptr [bx+1A6Eh]	;@13AA9
	jmp	@@5	;@13AAD
	db	0E8h, 0BCh, 1, 26h, 8Bh, 44h, 1, 26h, 8Ah, 4Ch, 3, 83h, 0C6h, 4	;@13AAF
	db	56h, 6, 55h, 0E8h, 2Ah, 0Ch, 5Dh, 7, 5Eh, 0C3h, 56h, 6, 55h, 0E8h
	db	11h, 0Ch, 5Dh, 7, 5Eh, 83h, 0C6h, 1, 0E9h, 77h, 0Bh, 6, 'UV3'
	db	0C9h, 26h, 8Ah, 4, 3Ch, 4, 't2<', 5, 't4^]', 7, 0E8h, 6Ch, 1, 26h
	db	8Bh, 44h, 1, 26h, 8Bh, 5Ch, 3, 26h, 8Bh, 54h, 5, 83h, 0C6h, 7
	db	6, 55h, 56h, 0Eh, 0E8h, 0DEh, 0C6h, 26h, 8Bh, 46h, 8, 0E8h, 47h
	db	0Ch, 5Eh, 5Dh, 7, 0C6h, 6, 22h, 50h, 0, 0E9h, 39h, 0Bh, 83h, 0C6h
	db	7, 41h, 0EBh, 0Ah, 83h, 0C6h, 5, 49h, 75h, 4, 'XXX', 0C3h, 26h
	db	8Bh, 46h, 6, 3, 0C5h, 3Bh, 0F0h, 75h, 0ADh, 26h, 8Bh, 46h, 2, 23h
	db	0C0h, 74h, 0B0h, 0Eh, 0E8h, 0A6h, 0C6h, 26h, 80h, 7Eh, 4, 5, 75h
	db	0EDh, 8Bh, 0F5h, 83h, 0C6h, 8, 0EBh, 93h, 0E8h, 0Dh, 1, 26h, 8Bh
	db	5Ch, 1, 26h, 8Bh, 54h, 3, 83h, 0C6h, 5, 6, 55h, 56h, 0E8h, 19h
	db	0Ch, 5Eh, 5Dh, 7, 0C6h, 6, 22h, 50h, 0, 0E9h, 0E6h, 0Ah, 0E8h
	db	0EEh, 0, 33h, 0FFh, 26h, 8Bh, 4Ch, 7, '&;L', 9, 74h, 0Eh, 6, 55h
	db	8Bh, 0C1h, 0Eh, 0E8h, 62h, 0C6h, 26h, 8Bh, 7Eh, 8, 5Dh, 7, 6, 'UV&'
	db	8Bh, 5Ch, 0Bh, 26h, 8Bh, 54h, 0Dh, 26h, 8Bh, 6Ch, 5, 26h, 8Bh
	db	44h, 1, 26h, 8Ah, 4Ch, 3, 26h, 8Ah, 6Ch, 4, 'PU&', 8Bh, 44h, 9
	db	0Eh, 0E8h, 37h, 0C6h, 26h, 8Bh, 76h, 8, 5Dh, 58h, 0E8h, 0D6h, 0Bh
	db	5Eh, 5Dh, 7, 83h, 0C6h, 0Fh, 0C6h, 6, 22h, 50h, 0, 0E9h, 8Dh, 0Ah
	db	0E8h, 95h, 0, 6, 55h, 26h, 8Bh, 5Ch, 6, 26h, 8Bh, 54h, 8, 26h
	db	8Bh, 6Ch, 4, 26h, 8Bh, 44h, 1, 26h, 8Ah, 4Ch, 3, 83h, 0C6h, 0Ah
	db	56h, 0E8h, 0E8h, 0Bh, 5Eh, 5Dh, 7, 0C6h, 6, 22h, 50h, 0, 0E9h
	db	62h, 0Ah, 0E8h, 6Ah, 0, 6, 55h, 26h, 8Bh, 6Ch, 4, 26h, 8Bh, 44h
	db	1, 26h, 8Ah, 4Ch, 3, 83h, 0C6h, 6, 56h, 0E8h, 0E6h, 0Bh, 5Eh, 5Dh
	db	7, 0C6h, 6, 22h, 50h, 0, 0E9h, 3Fh, 0Ah, 0E8h, 76h, 0, 26h, 8Bh
	db	44h, 1, 0A3h, 1Ah, 50h, 26h, 8Bh, 44h, 3, 0A3h, 18h, 50h, 26h
	db	8Bh, 44h, 5, 0A3h, ' P&', 8Bh, 44h, 7, 0A3h, 1Ch, 50h, 26h, 8Bh
	db	44h, 9, 0A3h, 1Eh, 50h, 83h, 0C6h, 0Bh, 0EBh, 67h, 0E8h, 4Bh, 0
	db	26h, 8Ah, 44h, 1, 32h, 0E4h, 1, 6, ' P&', 8Ah, 44h, 2, 1, 6, 1Ch
	db	50h, 83h, 16h, 1Eh, 50h, 0, 83h, 0C6h, 3, 0EBh, 48h
@@6:	push	si	;@13C58
	push	es	;@13C59
	push	bp	;@13C5A
	cmp	byte ptr ds:[5022h], 0	;@13C5B
	je	@@7	;@13C60
	call	L146DE	;@13C62
	jmp	short @@8	;@13C65
@@7:	call	L146DE	;@13C67
@@8:	pop	bp	;@13C6A
	pop	es	;@13C6B
	pop	si	;@13C6C
	ret	;@13C6D
	db	80h, '>"P', 0, 74h, 11h, 56h, 6, 55h, 0E8h, 63h, 0Ah, 5Dh, 7, 5Eh	;@13C6E
	db	0C6h, 6, 22h, 50h, 0, 0E9h, 0C7h, 9, 0C3h, 80h, '>"P', 0, 75h
	db	11h, 56h, 6, 55h, 0E8h, 4Ah, 0Ah, 5Dh, 7, 5Eh, 0C6h, 6, 22h, 50h
	db	0FFh, 0E9h, 0AEh, 9, 0C3h, 6, 55h, 56h, 8Bh, 1Eh, 1Ch, 50h, 8Bh
	db	16h, 1Eh, 50h, 0A1h, 20h, 50h, 8Bh, 36h, 18h, 50h, 8Bh, 3Eh, 1Ah
	db	50h, 3Bh, 0F7h, 50h, 74h, 0Ch, 8Bh, 0C7h, 0Eh, 0E8h, 1Fh, 0C5h
	db	26h, 8Bh, 7Eh, 8, 0EBh, 2, 33h, 0FFh, 8Bh, 0C6h, 0Eh, 0E8h, 11h
	db	0C5h, 26h, 8Bh, 76h, 8, 58h, 0E8h, 7Ch, 9, 5Eh, 5Dh, 7, 0C3h
L13CDB:	test	word ptr ds:[38B6h], 4000h	;@13CDB
	je	@@1	;@13CE1
	call	L14807	;@13CE3
@@1:	mov	cx, word ptr ds:[5004h]	;@13CE6
	mov	word ptr ds:[5020h], cx	;@13CEA
@@2:	jcxz	@@4	;@13CEE
	mov	ax, cx	;@13CF0
	push	cs	;@13CF2
	call	L101E0	;@13CF3
	mov	al, byte ptr es:[bp+4]	;@13CF6
	push	es	;@13CFA
	push	bp	;@13CFB
	cmp	al, 1Fh	;@13CFC
	je	@@5	;@13CFE
	cmp	al, 1Bh	;@13D00
	je	@@6	;@13D02
	cmp	al, 1Ch	;@13D04
	je	@@7	;@13D06
	cmp	al, 1Dh	;@13D08
	je	@@8	;@13D0A
	cmp	al, 1Eh	;@13D0C
	je	@@9	;@13D0E
	cmp	al, 19h	;@13D10
	je	@@11	;@13D12
	cmp	al, 1Ah	;@13D14
	je	@@12	;@13D16
@@3:	pop	bp	;@13D18
	pop	es	;@13D19
	mov	cx, word ptr es:[bp+2]	;@13D1A
	jmp	@@2	;@13D1E
@@4:	ret	;@13D20
@@5:	mov	bx, word ptr es:[bp+16h]	;@13D21
	mov	ax, word ptr es:[bp+6]	;@13D25
	mov	dx, word ptr es:[bp+8]	;@13D29
	mov	bp, word ptr es:[bp+14h]	;@13D2D
	call	L1492A	;@13D31
	jmp	@@3	;@13D34
@@6:	mov	si, 490Ah	;@13D36
	jmp	short @@10	;@13D39
@@7:	mov	si, 4932h	;@13D3B
	jmp	short @@10	;@13D3E
@@8:	mov	si, 495Ah	;@13D40
	jmp	short @@10	;@13D43
@@9:	mov	si, 4982h	;@13D45
@@10:	mov	bx, word ptr es:[bp+16h]	;@13D48
	mov	bp, word ptr es:[bp+14h]	;@13D4C
	call	si	;@13D50
	jmp	@@3	;@13D52
@@11:	mov	si, 48C8h	;@13D54
	jmp	short @@13	;@13D57
@@12:	mov	si, 48E9h	;@13D59
@@13:	push	si	;@13D5C
	call	L1464D	;@13D5D
	push	cs	;@13D60
	call	L101F7	;@13D61
@@14:	mov	cx, word ptr ds:[5020h]	;@13D64
	push	ax	;@13D68
	mov	ax, cx	;@13D69
	push	cs	;@13D6B
	call	L101E0	;@13D6C
	pop	ax	;@13D6F
	mov	dx, word ptr es:[bp+2]	;@13D70
	mov	word ptr ds:[5020h], dx	;@13D74
	cmp	ax, cx	;@13D78
	je	@@16	;@13D7A
	cmp	byte ptr es:[bp+4], 18h	;@13D7C
	jne	@@15	;@13D81
	push	ax	;@13D83
	mov	ax, word ptr es:[bp+6]	;@13D84
	mov	cl, byte ptr es:[bp+5]	;@13D88
	mov	bl, byte ptr es:[bp+0Ch]	;@13D8C
	mov	bp, word ptr es:[bp+8]	;@13D90
	call	L14963	;@13D94
	pop	ax	;@13D97
	jmp	@@14	;@13D98
@@15:	cmp	byte ptr es:[bp+4], 17h	;@13D9A
	jne	@@14	;@13D9F
	push	ax	;@13DA1
	mov	ax, word ptr es:[bp+6]	;@13DA2
	mov	cl, byte ptr es:[bp+5]	;@13DA6
	mov	bx, word ptr es:[bp+0Ch]	;@13DAA
	mov	dx, word ptr es:[bp+0Eh]	;@13DAE
	mov	bp, word ptr es:[bp+8]	;@13DB2
	call	L149B8	;@13DB6
	pop	ax	;@13DB9
	jmp	@@14	;@13DBA
@@16:	push	ax	;@13DBC
	call	L14A16	;@13DBD
	pop	ax	;@13DC0
	push	cs	;@13DC1
	call	L101E0	;@13DC2
	mov	ax, word ptr es:[bp+6]	;@13DC5
	mov	cl, byte ptr es:[bp+5]	;@13DC9
	mov	bx, word ptr es:[bp+0Ch]	;@13DCD
	mov	dx, word ptr es:[bp+0Eh]	;@13DD1
	mov	bp, word ptr es:[bp+8]	;@13DD5
	pop	si	;@13DD9
	call	si	;@13DDA
	jmp	@@3	;@13DDC
	db	33h, 0FFh, 26h, 8Bh, 4Eh, 10h, '&;N', 0Ah, 74h, 0Eh, 6, 55h, 8Bh	;@13DDF
	db	0C1h, 0Eh, 0E8h, 0EDh, 0C3h, 26h, 8Bh, 7Eh, 8, 5Dh, 7, 26h, 8Bh
	db	5Eh, 0Ch, 26h, 8Bh, 56h, 0Eh, 6, 55h, 26h, 8Bh, 46h, 0Ah, 0Eh
	db	0E8h, 0D5h, 0C3h, 26h, 8Bh, 76h, 8, 5Dh, 7, 26h, 8Bh, 46h, 6, 26h
	db	8Ah, 4Eh, 5, 32h, 0EDh, 26h, 8Bh, 6Eh, 8, 0E9h, 66h, 9, 26h, 8Bh
	db	5Eh, 0Ch, 26h, 8Bh, 56h, 0Eh, 26h, 8Bh, 46h, 6, 26h, 8Ah, 4Eh
	db	5, 26h, 8Bh, 6Eh, 8, 0E9h, 8Fh, 9, 26h, 8Bh, 46h, 6, 26h, 8Ah
	db	4Eh, 5, 26h, 8Bh, 6Eh, 8, 0E9h, 0A1h, 9
L13E48:	mov	cx, word ptr ds:[5004h]	;@13E48
	jcxz	@@6	;@13E4C
@@1:	mov	ax, cx	;@13E4E
	push	cs	;@13E50
	call	L101E0	;@13E51
	cmp	byte ptr es:[bp+4], 0	;@13E54
	je	@@4	;@13E59
@@2:	mov	cx, word ptr es:[bp+2]	;@13E5B
@@3:	jcxz	@@5	;@13E5F
	jmp	@@1	;@13E61
@@4:	test	byte ptr es:[bp+19h], 2	;@13E63
	jne	@@2	;@13E68
	call	@@19	;@13E6A
	push	cs	;@13E6D
	call	L101F7	;@13E6E
	mov	dx, ax	;@13E71
	push	cx	;@13E73
	call	@@7	;@13E74
	pop	cx	;@13E77
	jmp	@@3	;@13E78
@@5:	mov	ax, word ptr ds:[5008h]	;@13E7A
	and	ax, ax	;@13E7D
	je	@@6	;@13E7F
	xchg	word ptr ds:[5004h], ax	;@13E81
	push	ax	;@13E85
	mov	ax, word ptr ds:[500Ah]	;@13E86
	push	cs	;@13E89
	call	L101E0	;@13E8A
	pop	ax	;@13E8D
	mov	word ptr es:[bp+2], ax	;@13E8E
	and	ax, ax	;@13E92
	je	@@6	;@13E94
	push	ax	;@13E96
	push	cs	;@13E97
	call	L101F7	;@13E98
	mov	cx, ax	;@13E9B
	pop	ax	;@13E9D
	push	cs	;@13E9E
	call	L101E0	;@13E9F
	mov	word ptr es:[bp], cx	;@13EA2
@@6:	ret	;@13EA6
@@7:	mov	cx, word ptr ds:[5008h]	;@13EA7
@@8:	jcxz	@@9	;@13EAB
	push	cx	;@13EAD
	push	dx	;@13EAE
	mov	ax, cx	;@13EAF
	call	@@14	;@13EB1
	pop	dx	;@13EB4
	pop	cx	;@13EB5
	jae	@@9	;@13EB6
	mov	ax, cx	;@13EB8
	push	cs	;@13EBA
	call	L101E0	;@13EBB
	mov	cx, word ptr es:[bp+2]	;@13EBE
	jmp	@@8	;@13EC2
@@9:	mov	ax, dx	;@13EC4
	push	cs	;@13EC6
	call	L101E0	;@13EC7
	push	bp	;@13ECA
	push	es	;@13ECB
	push	cs	;@13ECC
	call	L101F7	;@13ECD
	mov	dx, ax	;@13ED0
	jcxz	@@10	;@13ED2
	push	ds	;@13ED4
	mov	ax, cx	;@13ED5
	push	cs	;@13ED7
	call	L101E0	;@13ED8
	push	es	;@13EDB
	pop	ds	;@13EDC
	mov	ax, word ptr ds:[bp]	;@13EDD
	mov	word ptr ds:[bp], dx	;@13EE1
	pop	ds	;@13EE5
	jmp	short @@11	;@13EE6
@@10:	mov	ax, word ptr ds:[500Ah]	;@13EE8
	mov	word ptr ds:[500Ah], dx	;@13EEB
@@11:	and	ax, ax	;@13EEF
	je	@@12	;@13EF1
	push	ds	;@13EF3
	push	cs	;@13EF4
	call	L101E0	;@13EF5
	push	es	;@13EF8
	pop	ds	;@13EF9
	mov	word ptr ds:[bp+2], dx	;@13EFA
	pop	ds	;@13EFE
	jmp	short @@13	;@13EFF
@@12:	mov	word ptr ds:[5008h], dx	;@13F01
@@13:	pop	es	;@13F05
	pop	bp	;@13F06
	mov	word ptr es:[bp], ax	;@13F07
	mov	word ptr es:[bp+2], cx	;@13F0B
	ret	;@13F0F
@@14:	push	cs	;@13F10
	call	L101E0	;@13F11
	call	@@18	;@13F14
	push	es	;@13F17
	mov	si, di	;@13F18
	mov	bx, cx	;@13F1A
	mov	ax, dx	;@13F1C
	push	cs	;@13F1E
	call	L101E0	;@13F1F
	call	@@18	;@13F22
	pop	ds	;@13F25
	cmp	cx, bx	;@13F26
	mov	bh, cl	;@13F28
	jb	@@15	;@13F2A
	mov	cl, bl	;@13F2C
@@15:	repe cmpsb	;@13F2E
	je	@@17	;@13F30
@@16:	mov	ax, ss	;@13F32
	mov	ds, ax	;@13F34
	ret	;@13F36
@@17:	cmp	bl, bh	;@13F37
	jmp	@@16	;@13F39
@@18:	mov	ax, word ptr es:[bp+6]	;@13F3B
	mov	cl, byte ptr es:[bp+5]	;@13F3F
	mov	ch, 0	;@13F43
	push	cs	;@13F45
	call	L1035F	;@13F46
	ret	;@13F49
@@19:	push	bp	;@13F4A
	push	es	;@13F4B
	mov	dx, word ptr es:[bp]	;@13F4C
	mov	cx, word ptr es:[bp+2]	;@13F50
	jcxz	@@20	;@13F54
	push	ds	;@13F56
	mov	ax, cx	;@13F57
	push	cs	;@13F59
	call	L101E0	;@13F5A
	push	es	;@13F5D
	pop	ds	;@13F5E
	mov	word ptr ds:[bp], dx	;@13F5F
	pop	ds	;@13F63
	jmp	short @@21	;@13F64
@@20:	mov	word ptr ds:[5006h], dx	;@13F66
@@21:	and	dx, dx	;@13F6A
	je	@@22	;@13F6C
	push	ds	;@13F6E
	mov	ax, dx	;@13F6F
	push	cs	;@13F71
	call	L101E0	;@13F72
	push	es	;@13F75
	pop	ds	;@13F76
	mov	word ptr ds:[bp+2], cx	;@13F77
	pop	ds	;@13F7B
	jmp	short @@23	;@13F7C
@@22:	mov	word ptr ds:[5004h], cx	;@13F7E
@@23:	pop	es	;@13F82
	pop	bp	;@13F83
	ret	;@13F84
	db	0C6h, 6, 25h, 50h, 0FFh, 26h, 8Bh, 56h, 6, 26h, 8Ah, 4Eh, 5, 0E9h, 85h, 5	;@13F85
	db	26h, 8Ah, 56h, 19h, 0F6h, 0C2h, 2, 75h, 27h, 6, 55h, 26h, 8Bh, 46h, 6, 26h
	db	8Ah, 4Eh, 5, 26h, 8Bh, 5Eh, 14h, 26h, 8Bh, 76h, 16h, 26h, 8Ah, 76h, 18h, 26h
	db	8Bh, 7Eh, 10h, 26h, 8Bh, 6Eh, 12h, 0E8h, 0CBh, 0Ah, 5Dh, 7, 26h, 89h, 46h, 8
	db	0C3h, 6, 55h, 26h, 8Bh, 46h, 6, 26h, 8Ah, 4Eh, 5, 0E8h, 75h, 0Ah, 5Dh, 7
	db	26h, 89h, 46h, 8, 26h, 8Bh, 4Eh, 0Ah, 0E3h, 17h, 8Bh, 0C1h, 0Eh, 0E8h, 0FBh, 0C1h
	db	6, 55h, 26h, 8Bh, 46h, 8, 0E8h, 82h, 0Ah, 5Dh, 7, 26h, 8Bh, 4Eh, 0Ah, 0EBh
	db	0E7h, 0E9h, 8Ah, 0Ah, 6, 55h, 26h, 8Bh, 46h, 6, 26h, 8Ah, 4Eh, 5, 26h, 8Ah
	db	6Eh, 14h, 22h, 0EDh, 74h, 2, 0B5h, 1, 26h, 8Bh, 5Eh, 0Ch, 26h, 8Bh, 56h, 0Eh
	db	26h, 8Bh, 76h, 10h, 26h, 8Bh, 7Eh, 12h, 0E8h, 6Ch, 0Bh, 5Dh, 7, 26h, 89h, 46h
	db	8, 0C3h, 26h, 0F6h, 46h, 19h, 2, 74h, 2Ch, 6, 55h, 26h, 8Bh, 46h, 6, 26h
	db	8Ah, 4Eh, 5, 0B5h, 2, 26h, 8Bh, 76h, 10h, 26h, 8Bh, 7Eh, 12h, 26h, 8Bh, 46h
	db	14h, 0Eh, 0E8h, 96h, 0C1h, 26h, 8Bh, 5Eh, 8, 0E8h, 3Bh, 0Bh, 5Dh, 7, 0Dh, 0
	db	40h, 26h, 89h, 46h, 8, 0C3h, 6, 55h, 26h, 8Bh, 46h, 6, 26h, 8Ah, 4Eh, 5
	db	0E8h, 0DAh, 0Ah, 5Dh, 7, 26h, 89h, 46h, 8, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h
	db	1, 0C3h, 6, 55h, 0E8h, 62h, 6, 5Dh, 7, 26h, 8Bh, 46h, 0Ah, 0E8h, 8Eh, 5
	db	0E9h, 0B4h, 0Ah, 6, 55h, 0E8h, 0Dh, 0, 5Dh, 7, 26h, 8Bh, 46h, 6, 26h, 8Ah
	db	4Eh, 5, 0E9h, 0B5h, 0Bh, 33h, 0F6h, 33h, 0FFh, 26h, 8Bh, 4Eh, 0Ah, 0E3h, 20h, 26h
	db	8Bh, 56h, 10h, 6, 55h, 8Bh, 0C1h, 0Eh, 0E8h, 30h, 0C1h, 26h, 8Bh, 76h, 8, 3Bh
	db	0D1h, 74h, 0Ah, 8Bh, 0C2h, 0Eh, 0E8h, 22h, 0C1h, 26h, 8Bh, 7Eh, 8, 5Dh, 7, 26h
	db	8Bh, 5Eh, 0Ch, 26h, 8Bh, 56h, 0Eh, 26h, 8Bh, 46h, 6, 26h, 8Ah, 4Eh, 5, 6
	db	55h, 0E8h, 90h, 0Bh, 5Dh, 7, 0F7h, 6, 0B6h, 38h, 0, 40h, 75h, 1, 0C3h, 26h
	db	8Bh, 46h, 12h, 0E9h, 40h, 5, 33h, 0F6h, 33h, 0FFh, 26h, 8Bh, 4Eh, 0Ah, 0E3h, 20h
	db	26h, 8Bh, 56h, 10h, 6, 55h, 8Bh, 0C1h, 0Eh, 0E8h, 0DFh, 0C0h, 26h, 8Bh, 76h, 8
	db	3Bh, 0D1h, 74h, 0Ah, 8Bh, 0C2h, 0Eh, 0E8h, 0D1h, 0C0h, 26h, 8Bh, 7Eh, 8, 5Dh, 7
	db	26h, 8Bh, 5Eh, 0Ch, 26h, 8Bh, 56h, 0Eh, 26h, 8Bh, 46h, 6, 26h, 8Ah, 4Eh, 5
	db	0E9h, 70h, 0Bh, 26h, 80h, 7Eh, 5, 0, 74h, 37h, 0BBh, 80h, 1Ah, 26h, 8Bh, 46h
	db	0Ah, 26h, 8Bh, 56h, 0Ch, 6, 55h, 0Eh, 0E8h, 0A0h, 0C0h, 26h, 8Bh, 76h, 8, 26h
	db	8Ah, 46h, 4, 0D7h, 8Ah, 0C8h, 8Bh, 0C2h, 0Eh, 0E8h, 8Fh, 0C0h, 26h, 8Bh, 7Eh, 8
	db	26h, 8Ah, 46h, 4, 0D7h, 8Ah, 0E8h, 5Dh, 7, 26h, 8Bh, 5Eh, 6, 26h, 8Bh, 56h
	db	8, 26h, 8Ah, 46h, 5, 0E9h, 0BCh, 0Ch, 26h, 8Bh, 46h, 8, 0A3h, 28h, 50h, 26h
	db	8Bh, 46h, 0Ch, 23h, 0C0h, 74h, 1Fh, 0Eh, 0E8h, 60h, 0C0h, 26h, 8Ah, 46h, 4, 3Ch
	db	6, 74h, 14h, 3Ch, 3, 74h, 10h, 3Ch, 2, 75h, 3, 0E9h, 0DAh, 0, 26h, 8Bh
	db	46h, 2, 23h, 0C0h, 75h, 0E1h, 0C3h, 0Eh, 0E8h, 57h, 0C0h, 0A3h, 2Eh, 50h, 26h, 80h
	db	7Eh, 4, 3, 74h, 0Ah, 26h, 8Bh, 46h, 2, 0Eh, 0E8h, 2Eh, 0C0h, 0EBh, 0EFh, 26h
	db	8Bh, 5Eh, 8, 26h, 8Bh, 46h, 0Ah, 89h, 1Eh, 2Ah, 50h, 0A3h, 2Ch, 50h, 8Bh, 16h
	db	28h, 50h, 6, 55h, 0E8h, 6Dh, 0Bh, 5Dh, 1Fh, 33h, 0D2h, 8Bh, 0F5h, 83h, 0C6h, 0Eh
	db	3Eh, 8Bh, 4Eh, 0Ch, 8Bh, 0FAh, 3, 0D1h, 0E8h, 84h, 0Bh, 6, 1Eh, 7, 0Eh, 0E8h
	db	10h, 0C0h, 36h, 0A3h, 30h, 50h, 7, 3Eh, 8Bh, 46h, 2, 23h, 0C0h, 74h, 1Fh, 6
	db	0Eh, 0E8h, 0E7h, 0BFh, 6, 1Fh, 7, 3Eh, 8Ah, 46h, 4, 3Ch, 6, 74h, 0E8h, 3Ch
	db	3, 75h, 0Bh, 3Eh, 8Bh, 46h, 0Ch, 3, 0C2h, 3Dh, 0, 4, 72h, 0BDh, 8Bh, 0FAh
	db	8Ch, 0D0h, 8Eh, 0D8h, 0E8h, 50h, 0Bh, 0E8h, 2Eh, 4, 0A1h, 2Eh, 50h, 3Bh, 6, 30h
	db	50h, 74h, 38h, 0Eh, 0E8h, 0B4h, 0BFh, 26h, 80h, 7Eh, 4, 6, 74h, 6, 26h, 8Bh
	db	46h, 2, 0EBh, 0E9h, 0BFh, 0Ah, 0, 3, 0FDh, 26h, 8Bh, 45h, 1, 2Bh, 6, 2Ah
	db	50h, 6, 55h, 57h, 0E8h, 0EAh, 1, 5Fh, 5Dh, 7, 2Bh, 0FDh, 83h, 0C7h, 9, 26h
	db	3Bh, 7Eh, 6, 72h, 0E2h, 26h, 8Bh, 46h, 2, 0EBh, 0C2h, 0E8h, 7Bh, 4, 0A1h, 30h
	db	50h, 0Eh, 0E8h, 76h, 0BFh, 0E9h, 26h, 0FFh, 0Eh, 0E8h, 86h, 0BFh, 0A3h, 30h, 50h, 26h
	db	83h, 7Eh, 0Ch, 0, 74h, 5Ah, 0E8h, 58h, 0, 8Bh, 16h, 28h, 50h, 26h, 8Bh, 5Eh
	db	6, 26h, 8Bh, 46h, 8, 89h, 1Eh, 2Ah, 50h, 0A3h, 2Ch, 50h, 0E8h, 0Ah, 0Ah, 0C6h
	db	6, 26h, 50h, 0, 0E8h, 7Bh, 0, 80h, 3Eh, 26h, 50h, 0, 74h, 3, 0E8h, 89h
	db	0Ah, 26h, 8Bh, 46h, 10h, 1, 6, 2Ah, 50h, 26h, 8Bh, 46h, 12h, 11h, 6, 2Ch
	db	50h, 0E8h, 94h, 3, 0E8h, 0B7h, 0Ah, 0A3h, 32h, 50h, 89h, 1Eh, 34h, 50h, 33h, 0D2h
	db	0E8h, 0E0h, 0, 0E8h, 13h, 4, 0A1h, 30h, 50h, 0Eh, 0E8h, 0Eh, 0BFh, 0E9h, 0BEh, 0FEh
	db	0C3h, 32h, 0C9h, 26h, 83h, 7Eh, 8, 0, 75h, 35h, 26h, 83h, 7Eh, 16h, 0, 75h
	db	2Eh, 6, 55h, 26h, 8Bh, 46h, 0Ch, 0Eh, 0E8h, 0F0h, 0BEh, 26h, 80h, 7Eh, 4, 2
	db	75h, 0Ch, 26h, 83h, 7Eh, 16h, 0, 74h, 2, 0B1h, 1, 0E8h, 0E3h, 0FFh, 26h, 8Bh
	db	46h, 2, 0Bh, 0C0h, 74h, 6, 0Eh, 0E8h, 0D1h, 0BEh, 0EBh, 0DFh, 5Dh, 7, 0C3h, 0B1h
	db	1, 0C3h, 0E8h, 5Dh, 0, 0E3h, 5, 0C6h, 6, 26h, 50h, 1, 3, 0CBh, 26h, 8Bh
	db	46h, 14h, 26h, 8Bh, 56h, 16h, 0E8h, 9Bh, 9, 6, 55h, 26h, 8Bh, 46h, 0Ch, 0Eh
	db	0E8h, 0A8h, 0BEh, 0EBh, 0Ch, 26h, 8Bh, 46h, 2, 0Bh, 0C0h, 74h, 32h, 0Eh, 0E8h, 9Ah
	db	0BEh, 26h, 8Ah, 46h, 4, 3Ch, 3, 74h, 0Ah, 3Ch, 7, 74h, 14h, 3Ch, 2, 74h
	db	19h, 0EBh, 0E2h, 26h, 8Bh, 4Eh, 0Ch, 8Bh, 0F5h, 83h, 0C6h, 0Eh, 0E8h, 80h, 9, 0EBh
	db	0D4h, 26h, 8Bh, 4Eh, 0Ch, 0E8h, 9Fh, 9, 0EBh, 0CBh, 0E8h, 0A5h, 0FFh, 0EBh, 0C6h, 5Dh
	db	7, 0C3h, 6, 55h, 33h, 0DBh, 33h, 0C9h, 26h, 8Bh, 46h, 0Ch, 0Bh, 0C0h, 74h, 20h
	db	0Eh, 0E8h, 57h, 0BEh, 26h, 8Ah, 46h, 4, 3Ch, 3, 74h, 0Bh, 3Ch, 2, 74h, 7
	db	3Ch, 7, 75h, 4, 43h, 0EBh, 1, 41h, 26h, 8Bh, 46h, 2, 0Bh, 0C0h, 75h, 0E0h
	db	5Dh, 7, 0C3h, 3, 16h, 32h, 50h, 33h, 0C9h, 33h, 0DBh, 6, 55h, 26h, 8Bh, 46h
	db	0Ch, 0Eh, 0E8h, 26h, 0BEh, 0EBh, 0Ch, 26h, 8Bh, 46h, 2, 0Bh, 0C0h, 74h, 6Fh, 0Eh
	db	0E8h, 18h, 0BEh, 26h, 8Ah, 46h, 4, 3Ch, 3, 74h, 0Eh, 3Ch, 7, 74h, 0Ah, 3Ch
	db	6, 74h, 3Bh, 3Ch, 2, 74h, 13h, 0EBh, 0DEh, 3, 16h, 34h, 50h, 26h, 8Bh, 46h
	db	0Ch, 3, 0D0h, 3, 0D8h, 83h, 0D1h, 0, 0EBh, 0CDh, 0E8h, 0B6h, 0FFh, 52h, 26h, 8Bh
	db	76h, 10h, 26h, 8Bh, 7Eh, 12h, 26h, 8Bh, 5Eh, 14h, 26h, 8Bh, 4Eh, 16h, 9Ah
	dd	L03532
	db	26h, 3, 5Eh, 6, 26h, 13h, 4Eh, 8, 5Ah, 0EBh, 0A9h, 53h, 51h, 52h, 8Bh, 0FDh
	db	83h, 0C7h, 0Ah, 26h, 8Bh, 45h, 1, 2Bh, 0C3h, 3, 0C2h, 3, 6, 34h, 50h, 6
	db	55h, 0E8h, 0Ah, 0, 5Dh, 7, 5Ah, 59h, 5Bh, 0EBh, 89h, 5Dh, 7, 0C3h, 50h, 26h
	db	8Bh, 45h, 5, 26h, 8Bh, 55h, 7, 26h, 8Ah, 2Dh, 0BBh, 80h, 1Ah, 0Eh, 0E8h, 97h
	db	0BDh, 26h, 8Bh, 76h, 8, 26h, 8Ah, 46h, 4, 0D7h, 8Ah, 0C8h, 8Bh, 0C2h, 0Eh, 0E8h
	db	86h, 0BDh, 26h, 8Bh, 7Eh, 8, 26h, 8Ah, 46h, 4, 0D7h, 8Ah, 0D5h, 8Ah, 0E8h, 5Bh
	db	0E9h, 1Dh, 9
L1446B:	mov	cx, word ptr ds:[5004h]	;@1446B
@@1:	jcxz	@@3	;@1446F
	push	ax	;@14471
	mov	ax, cx	;@14472
	push	cs	;@14474
	call	L101E0	;@14475
	pop	ax	;@14478
	push	word ptr es:[bp+2]	;@14479
	cmp	byte ptr es:[bp+4], al	;@1447D
	jne	@@2	;@14481
	push	ax	;@14483
	push	bx	;@14484
	call	bx	;@14485
	pop	bx	;@14487
	pop	ax	;@14488
@@2:	pop	cx	;@14489
	jmp	@@1	;@1448A
@@3:	ret	;@1448C
	db	0	;@1448D
L1448E:	xor	ax, ax	;@1448E
	mov	cx, 1Fh	;@14490
	push	ss	;@14493
	pop	es	;@14494
	mov	di, 5042h	;@14495
	rep stosb	;@14498
	mov	word ptr ds:[5048h], bx	;@1449A
	push	dx	;@1449E
@@1:	push	cs	;@1449F
	call	L10079	;@144A0
	cmp	ax, 400h	;@144A3
	jae	@@2	;@144A6
	call	far ptr L0F643	;@144A8
	jae	@@1	;@144AD
	cmp	ax, 41h	;@144AF
	jae	@@3	;@144B2
	mov	ax, 41h	;@144B4
	jmp	short @@3	;@144B7
@@2:	mov	ax, 400h	;@144B9
@@3:	pop	dx	;@144BC
	mov	cx, ax	;@144BD
	push	cs	;@144BF
	call	L10039	;@144C0
	mov	word ptr ds:[5044h], ax	;@144C3
	shl	cx, 1	;@144C6
	shl	cx, 1	;@144C8
	shl	cx, 1	;@144CA
	shl	cx, 1	;@144CC
	mov	word ptr ds:[5036h], cx	;@144CE
	push	cs	;@144D2
	call	L119A0	;@144D3
	jae	@@4	;@144D6
	jmp	L14E70	;@144D8
@@4:	mov	word ptr ds:[505Ch], bx	;@144DB
	ret	;@144DF
L144E0:	mov	ax, word ptr ds:[5044h]	;@144E0
	mov	dx, word ptr ds:[5036h]	;@144E3
	mov	cl, 4	;@144E7
	shr	dx, cl	;@144E9
	push	cs	;@144EB
	call	L10064	;@144EC
	mov	bx, word ptr ds:[505Ch]	;@144EF
	and	bx, bx	;@144F3
	je	@@1	;@144F5
	push	cs	;@144F7
	call	L119AC	;@144F8
	mov	word ptr ds:[505Ch], 0	;@144FB
@@1:	ret	;@14501
L14502:	mov	di, word ptr ds:[5046h]	;@14502
	and	di, di	;@14506
	je	@@1	;@14508
	mov	es, word ptr ds:[5044h]	;@1450A
	call	L14EB9	;@1450E
@@1:	call	L144E0	;@14511
	jb	@@2	;@14514
	ret	;@14516
@@2:	jmp	L14E70	;@14517
	db	0B0h, 80h, 0E8h, 0E6h, 9, 8Bh, 0C2h, 0E8h, 0C2h, 9	;@1451A
L14524:	call	L14E7B	;@14524
	test	word ptr ds:[38B6h], 4	;@14527
	jne	@@1	;@1452D
	mov	si, word ptr ds:[5048h]	;@1452F
	mov	al, byte ptr [si]	;@14533
	or	al, al	;@14535
	je	@@1	;@14537
	jmp	L14E17	;@14539
@@1:	ret	;@1453C
L1453D:	mov	al, 96h	;@1453D
	call	L14F05	;@1453F
	xor	al, al	;@14542
	stosb	;@14544
	inc	word ptr ds:[504Ah]	;@14545
	jmp	L14E7B	;@14549
L1454C:	mov	al, 80h	;@1454C
	call	L14F05	;@1454E
	mov	bx, di	;@14551
	inc	di	;@14553
@@1:	lodsb	;@14554
	or	al, al	;@14555
	je	@@2	;@14557
	stosb	;@14559
	jmp	@@1	;@1455A
@@2:	mov	ax, di	;@1455C
	sub	ax, bx	;@1455E
	dec	ax	;@14560
	mov	byte ptr es:[bx], al	;@14561
	jmp	L14524	;@14564
L14566:	mov	al, 88h	;@14566
	call	L14F05	;@14568
	mov	al, 40h	;@1456B
	stosb	;@1456D
	mov	al, 0A1h	;@1456E
	stosb	;@14570
	jmp	L14E7B	;@14571
L14574:	mov	al, 88h	;@14574
	call	L14F05	;@14576
	mov	al, 40h	;@14579
	stosb	;@1457B
	mov	al, 0A2h	;@1457C
	stosb	;@1457E
	mov	al, 1	;@1457F
	stosb	;@14581
	jmp	L14E7B	;@14582
	db	0B0h, 88h, 0E8h, 7Bh, 9, 0B0h, 0C0h, 0AAh, 0B0h, 9Eh, 0AAh, 0E9h	;@14585
	db	0E8h, 8, 8Bh, 0D0h, 0B0h, 88h, 0E8h, 6Bh, 9, 0B0h, 0C0h, 0AAh
	db	0B0h, 9Fh, 0AAh, 8Bh, 0C2h, 32h, 0EDh, 6, 57h, 0Eh, 0E8h, 0B5h
	db	0BDh, 8Bh, 0F7h, 8Ch, 0C0h, 8Eh, 0D8h, 5Fh, 7, 0F3h, 0A4h, 8Ch
	db	0D0h, 8Eh, 0D8h, 0E9h, 0C0h, 8
L145BB:	test	word ptr ds:[38B6h], 4	;@145BB
	jne	@@2	;@145C1
	push	ax	;@145C3
	mov	al, 88h	;@145C4
	call	L14F05	;@145C6
	mov	al, 40h	;@145C9
	stosb	;@145CB
	mov	al, 0E9h	;@145CC
	stosb	;@145CE
	pop	ax	;@145CF
	and	cl, cl	;@145D0
	je	@@1	;@145D2
	push	ax	;@145D4
	mov	ax, bx	;@145D5
	stosw	;@145D7
	mov	ax, dx	;@145D8
	stosw	;@145DA
	pop	ax	;@145DB
	call	L14EE6	;@145DC
@@1:	jmp	L14E7B	;@145DF
@@2:	ret	;@145E2
L145E3:	push	ax	;@145E3
	mov	al, 88h	;@145E4
	call	L14F05	;@145E6
	mov	al, 40h	;@145E9
	stosb	;@145EB
	mov	al, 0E8h	;@145EC
	stosb	;@145EE
	mov	ax, bp	;@145EF
	call	L14ED8	;@145F1
	pop	ax	;@145F4
	and	bp, bp	;@145F5
	jne	@@1	;@145F7
	call	L14EE6	;@145F9
	mov	ax, bx	;@145FC
	stosw	;@145FE
	mov	ax, dx	;@145FF
	stosw	;@14601
	call	L14E7B	;@14602
	inc	word ptr ds:[5052h]	;@14605
	mov	ax, word ptr ds:[5052h]	;@14609
	ret	;@1460C
@@1:	call	L14E7B	;@1460D
	mov	ax, bp	;@14610
	ret	;@14612
	db	8Bh, 0D0h, 0B0h, 88h, 0E8h, 0EBh, 8, 0B0h, 40h, 0AAh, 0B0h, 0E0h	;@14613
	db	0AAh, 8Bh, 0C2h, 80h, 0E4h, 0Fh, 0E8h, 0B0h, 8, 0E9h, 50h, 8, 8Bh
	db	0D0h, 0B0h, 88h, 0E8h, 0D3h, 8, 0B0h, 40h, 0AAh, 0B0h, 0E1h, 0AAh
	db	8Bh, 0C2h, 80h, 0E4h, 0Fh, 0E8h, 98h, 8, 32h, 0C0h, 0F6h, 0C6h
	db	40h, 74h, 2, 0B0h, 28h, 0AAh, 0E9h, 2Eh, 8
L1464D:	mov	byte ptr ds:[503Dh], 0	;@1464D
	ret	;@14652
	db	40h, 80h, '>=P', 0, 'tZ;6>PuM;>@PuG', 8Bh, 0Eh, 'FP#', 0D2h, 74h	;@14653
	db	1Fh, 0F6h, 6, 3Dh, 50h, 1, 74h, 38h, 0C4h, '>BP', 81h, 0C1h, 0FAh
	db	3, 3Bh, 0F9h, 77h, 2Ch, 0ABh, 8Bh, 0C3h, 0ABh, 8Bh, 0C2h, 0ABh
	db	89h, '>BP', 0C3h, 0F6h, 6, 3Dh, 50h, 1, 75h, 19h, 0C4h, '>BP'
	db	81h, 0C1h, 0FCh, 3, 3Bh, 0F9h, 77h, 9, 0ABh, 8Bh, 0C3h, 0ABh, 89h
	db	'>BP', 0C3h, 8Bh, '>@PPW', 0E8h, 2Bh, 0, 5Fh, 58h, 89h, '6>P'
	db	89h, '>@PP', 0B0h, 94h, 23h, 0D2h, 74h, 2, 0Ch, 1, 0A2h, 3Dh, 50h
	db	0E8h, 39h, 8, 0A1h, 40h, 50h, 0E8h, 6, 8, 8Bh, 0C6h, 0E8h, 1, 8
	db	89h, '>BPX', 0EBh, 89h
L146DE:	cmp	byte ptr ds:[503Dh], 0	;@146DE
	je	@@1	;@146E3
	les	di, dword ptr ds:[5042h]	;@146E5
	jmp	L14E7B	;@146E9
@@1:	ret	;@146EC
	db	0E8h, 2Fh, 0, 0E8h, 1Bh, 0, 0D0h, 0E0h, 0D0h, 0E0h, 0D0h, 0E0h	;@146ED
	db	0D0h, 0E0h, 8Ah, 0E0h, 0E8h, 0Eh, 0, 0Ah, 0C4h, 0AAh, 0E2h, 0EBh
	db	8Ch, 0D0h, 8Eh, 0D8h, 89h, '>BP', 0C3h, 0ACh, '<9w', 3, 2Ch, 30h
	db	0C3h, '<ar', 2, ', ,7', 0C3h, 32h, 0EDh, 0D1h, 0E9h, 0E3h, 19h
	db	80h, '>=P', 0, 74h, 13h, 0C4h, '>BP', 6, 57h, 0Eh, 0E8h, 29h, 0BCh
	db	8Bh, 0F7h, 8Ch, 0C0h, 8Eh, 0D8h, 5Fh, 7, 0C3h, 50h, 51h, 0B0h
	db	88h, 0A2h, 3Dh, 50h, 0E8h, 0BCh, 7, 0B0h, 40h, 0AAh, 59h, 58h
	db	0EBh, 0E0h, 8Bh, 0C8h, 0B0h, 88h, 0E8h, 0AEh, 7, 0B0h, 40h, 0AAh
	db	0B0h, 0E5h, 23h, 0D2h, 74h, 2, 0Ch, 10h, 0AAh, 8Bh, 0C1h, 0E8h
	db	70h, 7, 8Bh, 0C3h, 0ABh, 8Bh, 0C2h, 23h, 0C0h, 74h, 1, 0ABh, 0E9h
	db	6, 7, 0B0h, 88h, 0E8h, 8Bh, 7, 0B0h, 40h, 0AAh, 0B0h, 0E7h, 23h
	db	0D2h, 74h, 2, 0Ch, 10h, 0AAh, 0EBh, 0E0h, 57h, 50h, 0B0h, 88h
	db	0E8h, 76h, 7, 0B0h, 40h, 0AAh, 0B0h, 0E6h, 23h, 0D2h, 74h, 2, 0Ch
	db	10h, 0AAh, 58h, 0E8h, 47h, 7, 8Bh, 0C5h, 80h, 0E4h, 0Fh, 0E8h
	db	31h, 7, 32h, 0C0h, 0F7h, 0C5h, 0, 10h, 74h, 2, 0B0h, 28h, 0AAh
	db	58h, 0E8h, 22h, 7, 8Bh, 0C6h, 0E8h, 1Dh, 7, 8Bh, 0C3h, 0ABh, 8Bh
	db	0C2h, 23h, 0C0h, 74h, 1, 0ABh, 0E9h, 0B3h, 6, 50h, 0B0h, 88h, 0E8h
	db	37h, 7, 0B0h, 40h, 0AAh, 0B0h, 0E6h, 0AAh, 58h, 0E8h, 0Eh, 7, 8Bh
	db	0C5h, 80h, 0E4h, 0Fh, 0E8h, 0F8h, 6, 0B0h, 2, 0AAh, 8Bh, 0C3h
	db	0ABh, 0E9h, 92h, 6, 50h, 0B0h, 88h, 0E8h, 16h, 7, 0B0h, 40h, 0AAh
	db	0B0h, 0E6h, 0AAh, 58h, 0E8h, 0EDh, 6, 8Bh, 0C5h, 80h, 0E4h, 0Fh
	db	0E8h, 0D7h, 6, 0B0h, 7, 0AAh, 0E9h, 74h, 6
L14807:	mov	al, 88h	;@14807
	call	L14F05	;@14809
	mov	al, 40h	;@1480C
	stosb	;@1480E
	mov	al, 0EAh	;@1480F
	stosb	;@14811
	mov	ax, 4	;@14812
	stosw	;@14815
	call	L14E7B	;@14816
	xor	bx, bx	;@14819
@@1:	mov	al, 88h	;@1481B
	call	L14F05	;@1481D
	mov	al, 40h	;@14820
	stosb	;@14822
	mov	al, 0E3h	;@14823
	stosb	;@14825
	mov	ax, bx	;@14826
	add	ax, 18h	;@14828
	call	L14ED8	;@1482B
	push	bx	;@1482E
	shl	bx, 1	;@1482F
	shl	bx, 1	;@14831
	mov	si, word ptr [bx+1A8Eh]	;@14833
	mov	cx, word ptr [bx+1A90h]	;@14837
	rep movsb	;@1483B
	call	L14E7B	;@1483D
	pop	bx	;@14840
	inc	bx	;@14841
	cmp	bx, 7	;@14842
	jne	@@1	;@14845
	ret	;@14847
	db	50h, 0B0h, 88h, 0E8h, 0B7h, 6, 0B0h, 40h, 0AAh, 0B0h, 0E3h, 0AAh	;@14848
	db	8Bh, 0C5h, 0E8h, 7Fh, 6, 58h, 0E8h, 89h, 6, 8Bh, 0C3h, 0ABh, 0B0h
	db	20h, 0AAh, 8Bh, 0C2h, 0ABh, 0E9h, 12h, 6, 50h, 0B0h, 88h, 0E8h
	db	96h, 6, 0B0h, 40h, 0AAh, 0B0h, 0E3h, 0AAh, 8Bh, 0C5h, 0E8h, 5Eh
	db	6, 58h, 0E8h, 68h, 6, 8Bh, 0C3h, 0ABh, 0B0h, 21h, 0AAh, 8Bh, 0C2h
	db	0ABh, 0E9h, 0F1h, 5, 0B0h, 88h, 0E8h, 76h, 6, 0B0h, 40h, 0AAh
	db	0B0h, 0E3h, 0AAh, 8Bh, 0C5h, 0E8h, 3Eh, 6, 32h, 0C0h, 0AAh, 0B8h
	db	2, 0, 0ABh, 0B0h, 15h, 0AAh, 8Bh, 0C3h, 80h, 0E4h, 0Fh, 0E8h, 2Ch
	db	6, 32h, 0C0h, 0AAh, 0E9h, 0C9h, 5, 0B0h, 88h, 0E8h, 4Eh, 6, 0B0h
	db	40h, 0AAh, 0B0h, 0E3h, 0AAh, 8Bh, 0C5h, 0E8h, 16h, 6, 32h, 0C0h
	db	0AAh, 0B8h, 4, 0, 0ABh, 0B0h, 16h, 0AAh, 8Bh, 0C3h, 80h, 0E4h
	db	0Fh, 0E8h, 4, 6, 32h, 0C0h, 0AAh, 0E9h, 0A1h, 5, 0B0h, 88h, 0E8h
	db	26h, 6, 0B0h, 40h, 0AAh, 0B0h, 0E3h, 0AAh, 8Bh, 0C5h, 0E8h, 0EEh
	db	5, 32h, 0C0h, 0AAh, 0B8h, 4, 0, 0ABh, 0B0h, 18h, 0AAh, 8Bh, 0C3h
	db	80h, 0E4h, 0Fh, 0E8h, 0DCh, 5, 32h, 0C0h, 0AAh, 0E9h, 79h, 5, 0B0h
	db	88h, 0E8h, 0FEh, 5, 0B0h, 40h, 0AAh, 0B0h, 0E3h, 0AAh, 8Bh, 0C5h
	db	0E8h, 0C6h, 5, 32h, 0C0h, 0AAh, 0B8h, 6, 0, 0ABh, 0B0h, 19h, 0AAh
	db	8Bh, 0C3h, 80h, 0E4h, 0Fh, 0E8h, 0B4h, 5, 32h, 0C0h, 0AAh, 0E9h
	db	51h, 5
L1492A:	push	ax	;@1492A
	mov	al, 88h	;@1492B
	call	L14F05	;@1492D
	mov	al, 40h	;@14930
	stosb	;@14932
	mov	al, 0E3h	;@14933
	stosb	;@14935
	mov	ax, bp	;@14936
	call	L14ED8	;@14938
	xor	al, al	;@1493B
	stosb	;@1493D
	pop	ax	;@1493E
	stosw	;@1493F
	and	dx, dx	;@14940
	jne	@@1	;@14942
	mov	al, 1Ah	;@14944
	stosb	;@14946
	mov	ax, bx	;@14947
	and	ah, 0Fh	;@14949
	call	L14ED8	;@1494C
	jmp	L14E7B	;@1494F
@@1:	mov	al, 1Bh	;@14952
	stosb	;@14954
	mov	ax, dx	;@14955
	stosw	;@14957
	mov	ax, bx	;@14958
	and	ah, 0Fh	;@1495A
	call	L14ED8	;@1495D
	jmp	L14E7B	;@14960
L14963:	cmp	byte ptr ds:[503Dh], 0	;@14963
	je	@@3	;@14968
@@1:	les	di, dword ptr ds:[5042h]	;@1496A
	mov	si, word ptr ds:[5046h]	;@1496E
	xor	ch, ch	;@14972
	sub	si, cx	;@14974
	add	si, 3FCh	;@14976
	cmp	di, si	;@1497A
	ja	@@2	;@1497C
	push	ax	;@1497E
	mov	al, bl	;@1497F
	mov	word ptr ds:[503Eh], di	;@14981
	stosb	;@14985
	pop	ax	;@14986
	call	L14EE6	;@14987
	mov	ax, bp	;@1498A
	and	ah, 0Fh	;@1498C
	call	L14ED8	;@1498F
	mov	word ptr ds:[5042h], di	;@14992
	ret	;@14996
@@2:	les	di, dword ptr ds:[5042h]	;@14997
	push	ax	;@1499B
	push	cx	;@1499C
	call	L14E7B	;@1499D
	pop	cx	;@149A0
	pop	ax	;@149A1
@@3:	push	ax	;@149A2
	mov	al, 88h	;@149A3
	call	L14F05	;@149A5
	mov	al, 40h	;@149A8
	stosb	;@149AA
	mov	al, 0E2h	;@149AB
	mov	byte ptr ds:[503Dh], al	;@149AD
	stosb	;@149B0
	pop	ax	;@149B1
	mov	word ptr ds:[5042h], di	;@149B2
	jmp	@@1	;@149B6
L149B8:	cmp	byte ptr ds:[503Dh], 0	;@149B8
	je	@@3	;@149BD
@@1:	les	di, dword ptr ds:[5042h]	;@149BF
	mov	si, word ptr ds:[5046h]	;@149C3
	xor	ch, ch	;@149C7
	sub	si, cx	;@149C9
	add	si, 3F6h	;@149CB
	cmp	di, si	;@149CF
	ja	@@2	;@149D1
	push	ax	;@149D3
	mov	al, 40h	;@149D4
	stosb	;@149D6
	mov	ax, bx	;@149D7
	stosw	;@149D9
	mov	ax, dx	;@149DA
	stosw	;@149DC
	mov	word ptr ds:[503Eh], di	;@149DD
	xor	al, al	;@149E1
	stosb	;@149E3
	pop	ax	;@149E4
	call	L14EE6	;@149E5
	mov	ax, bp	;@149E8
	and	ah, 0Fh	;@149EA
	call	L14ED8	;@149ED
	mov	word ptr ds:[5042h], di	;@149F0
	ret	;@149F4
@@2:	les	di, dword ptr ds:[5042h]	;@149F5
	push	ax	;@149F9
	push	cx	;@149FA
	call	L14E7B	;@149FB
	pop	cx	;@149FE
	pop	ax	;@149FF
@@3:	push	ax	;@14A00
	mov	al, 88h	;@14A01
	call	L14F05	;@14A03
	mov	al, 40h	;@14A06
	stosb	;@14A08
	mov	al, 0E2h	;@14A09
	mov	byte ptr ds:[503Dh], al	;@14A0B
	stosb	;@14A0E
	pop	ax	;@14A0F
	mov	word ptr ds:[5042h], di	;@14A10
	jmp	@@1	;@14A14
L14A16:	cmp	byte ptr ds:[503Dh], 0	;@14A16
	je	@@2	;@14A1B
@@1:	les	di, dword ptr ds:[5042h]	;@14A1D
	mov	si, word ptr ds:[503Eh]	;@14A21
	or	byte ptr es:[si], 80h	;@14A25
	jmp	L14E7B	;@14A29
@@2:	mov	al, 88h	;@14A2C
	call	L14F05	;@14A2E
	mov	al, 40h	;@14A31
	stosb	;@14A33
	mov	al, 0E2h	;@14A34
	stosb	;@14A36
	mov	word ptr ds:[503Eh], di	;@14A37
	mov	al, 40h	;@14A3B
	stosb	;@14A3D
	xor	ax, ax	;@14A3E
	stosw	;@14A40
	stosw	;@14A41
	mov	word ptr ds:[5042h], di	;@14A42
	jmp	@@1	;@14A46
	db	50h, 0B0h, 96h, 0E8h, 0B7h, 4, 58h, 0E8h, 94h, 4, 0FFh, 6, 4Ah	;@14A48
	db	50h, 0E8h, 22h, 4, 0B0h, 9Ah, 0E8h, 0A7h, 4, 0A1h, 4Ah, 50h, 0E8h
	db	74h, 4, 89h, '>BP', 0FFh, 6, 4Ch, 50h, 0A1h, 4Ch, 50h, 0C3h, 0C4h
	db	'>BP', 8Bh, 0C8h, 0B0h, 0FFh, 0AAh, 8Bh, 0C1h, 0E8h, 5Ah, 4, 89h
	db	'>BP', 0C3h, 0C4h, '>BP', 0E9h, 0F1h, 3, 89h, '>^PP', 0B0h, 96h
	db	0E8h, 71h, 4, 58h, 0E8h, 4Eh, 4, 0FFh, 6, 4Ah, 50h, 0A1h, 4Ah
	db	50h, 0A3h, 54h, 50h, 8Bh, 0C6h, 0Ah, 0F6h, 75h, 5, 0B8h, 1, 0
	db	0EBh, 0Eh, 8Ah, 0CEh, 32h, 0EDh, 0E8h, 32h, 4, 0FFh, 6, 4Ah, 50h
	db	0A1h, 4Ah, 50h, 0A3h, 56h, 50h, 0E8h, 0BAh, 3, 32h, 0F6h, 8Bh
	db	'6^P', 0Bh, 0F6h, 75h, 0Ah, 83h, 0FDh, 1, 75h, 5, 80h, 0CAh, 2
	db	0EBh, 6, 0Bh, 0EDh, 74h, 2, 0B6h, 1, 0B0h, 98h, 0Ah, 0C6h, 0E8h
	db	23h, 4, 8Ah, 0C2h, 0A8h, 0E0h, 75h, 0Bh, 0AAh, 8Bh, 0C3h, 0ABh
	db	32h, 0C0h, 0AAh, 32h, 0DBh, 0EBh, 0Bh, 0F7h, 6, 0B6h, 38h, 0, 1
	db	74h, 2, 24h, 0FEh, 0AAh, 8Bh, 0C6h, 0ABh, 0Ah, 0F6h, 74h, 3, 8Bh
	db	0C5h, 0ABh, 0A1h, 54h, 50h, 0E8h, 0CAh, 3, 0A1h, 56h, 50h, 0E8h
	db	0C4h, 3, 0B8h, 1, 0, 0E8h, 0BEh, 3, 0F7h, 6, 0B6h, 38h, 0, 1, 74h
	db	0Fh, 0F6h, 0C3h, 4, 74h, 0Ah, 8Ah, 0C3h, 0F6h, 0C2h, 1, 75h, 2
	db	24h, 0FBh, 0AAh, 0E8h, 47h, 3, 0FFh, 6, 4Eh, 50h, 0A1h, 4Eh, 50h
	db	0C3h
L14B3C:	mov	byte ptr ds:[503Dh], 0	;@14B3C
	ret	;@14B41
	db	80h, '>=P', 0, 74h, 2Dh, 0C4h, '>BP2', 0EDh, 8Bh, '6FP+', 0F1h	;@14B42
	db	81h, 0C6h, 0FEh, 3, 3Bh, 0FEh, 77h, 12h, 0E8h, 86h, 3, 32h, 0C0h
	db	0AAh, 89h, '>BP', 0FFh, 6, 50h, 50h, 0A1h, 50h, 50h, 0C3h, 50h
	db	51h, 0E8h, 7, 3, 'YXP', 0B0h, 8Ch, 0A2h, 3Dh, 50h, 0E8h, 86h, 3
	db	58h, 89h, '>BP', 0EBh, 0C3h
L14B86:	mov	byte ptr ds:[503Dh], 0	;@14B86
	ret	;@14B8B
	db	88h, 2Eh, 3Ch, 50h, 89h, 36h, 38h, 50h, 89h, 3Eh, 3Ah, 50h, 80h, 3Eh, 3Dh, 50h	;@14B8C
	db	0, 74h, 5Eh, 0C4h, 3Eh, 42h, 50h, 32h, 0EDh, 8Bh, 36h, 46h, 50h, 2Bh, 0F1h, 81h
	db	0C6h, 0F3h, 3, 3Bh, 0FEh, 77h, 43h, 0E8h, 30h, 3, 32h, 0C0h, 0AAh, 80h, 3Eh, 3Ch
	db	50h, 0, 0B0h, 62h, 74h, 0Bh, 0FEh, 0C8h, 80h, 3Eh, 3Ch, 50h, 1, 74h, 2, 8Ah
	db	0C3h, 0AAh, 80h, 3Eh, 3Ch, 50h, 0, 74h, 38h, 80h, 3Eh, 3Ch, 50h, 1, 74h, 9
	db	0A1h, 38h, 50h, 8Bh, 16h, 3Ah, 50h, 0EBh, 3Dh, 8Bh, 0C3h, 0E8h, 47h, 0, 0A1h, 38h
	db	50h, 8Bh, 16h, 3Ah, 50h, 0E8h, 3Dh, 0, 0EBh, 2Fh, 50h, 51h, 0E8h, 80h, 2, 59h
	db	58h, 50h, 0B0h, 0B0h, 0A2h, 3Dh, 50h, 0E8h, 0FFh, 2, 58h, 89h, 3Eh, 42h, 50h, 0EBh
	db	92h, 57h, 8Bh, 36h, 38h, 50h, 8Bh, 3Eh, 3Ah, 50h, 8Bh, 0CAh, 9Ah
	dd	L03670
	db	5Fh, 8Bh, 0D1h, 8Bh, 0C3h, 0E8h, 0Ch, 0, 89h, 3Eh, 42h, 50h, 0FFh, 6, 50h, 50h
	db	0A1h, 50h, 50h, 0C3h, 23h, 0D2h, 75h, 10h, 3Dh, 80h, 0, 77h, 2, 0AAh, 0C3h, 8Bh
	db	0D0h, 0B0h, 81h, 0AAh, 8Bh, 0C2h, 0ABh, 0C3h, 50h, 0B0h, 88h, 0AAh, 58h, 0ABh, 8Bh, 0C2h
	db	0ABh, 0C3h, 50h, 0B0h, 88h, 0E8h, 0B0h, 2, 0B0h, 40h, 0AAh, 0B0h, 0A0h, 0AAh, 0B8h, 2
	db	0, 0ABh, 58h, 0E8h, 83h, 2, 32h, 0C0h, 0AAh, 0E9h, 12h, 2, 50h, 57h, 0B0h, 90h
	db	0Bh, 0D2h, 74h, 2, 0Ch, 1, 0E8h, 8Fh, 2, 58h, 0E8h, 5Eh, 2, 8Bh, 0C6h, 0E8h
	db	59h, 2, 0Bh, 0C0h, 75h, 1, 0ABh, 58h, 0E8h, 5Eh, 2, 8Bh, 0C3h, 0ABh, 0Bh, 0D2h
	db	74h, 3, 8Bh, 0C2h, 0ABh, 32h, 0C0h, 0AAh, 0E9h, 0E3h, 1, 50h, 57h, 0B0h, 0B6h, 0EBh
	db	0CFh, 88h, 0Eh, 60h, 50h, 8Bh, 0F0h, 6, 89h, 16h, 58h, 50h, 0B0h, 0A2h, 0Ah, 0C1h
	db	0E8h, 55h, 2, 8Bh, 0C2h, 0E8h, 23h, 2, 8Bh, 0C3h, 0ABh, 22h, 0C9h, 74h, 3, 8Bh
	db	0C6h, 0ABh, 89h, 3Eh, 5Ah, 50h, 89h, 3Eh, 42h, 50h, 7, 0C3h, 8Ch, 0C3h, 0C4h, 3Eh
	db	42h, 50h, 0ABh, 80h, 3Eh, 60h, 50h, 0, 74h, 3, 8Bh, 0C2h, 0ABh, 8Bh, 0C1h, 0ABh
	db	89h, 3Eh, 42h, 50h, 8Eh, 0C3h, 0C3h, 8Ch, 0DAh, 8Ch, 0C3h, 0C4h, 3Eh, 42h, 50h, 8Eh
	db	0DBh, 0B8h, 1, 0, 0ABh, 33h, 0C0h, 36h, 80h, 3Eh, 60h, 50h, 0, 74h, 1, 0ABh
	db	0ABh, 8Ah, 0C1h, 0AAh, 0F3h, 0A4h, 8Eh, 0DAh, 89h, 3Eh, 42h, 50h, 8Eh, 0C3h, 0C3h, 8Ch
	db	0C3h, 0C4h, 3Eh, 42h, 50h, 0B8h, 1, 0, 0ABh, 33h, 0C0h, 80h, 3Eh, 60h, 50h, 0
	db	74h, 1, 0ABh, 0ABh, 8Ah, 0C1h, 0AAh, 32h, 0C0h, 0F3h, 0AAh, 89h, 3Eh, 42h, 50h, 8Eh
	db	0C3h, 0C3h, 6, 0C4h, 3Eh, 42h, 50h, 0E8h, 44h, 1, 7, 0C3h, 89h, 16h, 58h, 50h
	db	8Bh, 0F0h, 32h, 0C9h, 23h, 0F6h, 74h, 3, 80h, 0C9h, 1, 0B0h, 0A0h, 0Ah, 0C1h, 0E8h
	db	0B6h, 1, 0A1h, 58h, 50h, 0E8h, 83h, 1, 8Bh, 0C3h, 0ABh, 22h, 0C9h, 74h, 3, 8Bh
	db	0C6h, 0ABh, 89h, 3Eh, 5Ah, 50h, 0C3h, 36h, 3, 3Eh, 5Ah, 50h, 0F3h, 0A4h, 0C3h, 3
	db	3Eh, 5Ah, 50h, 0E9h, 8, 1, 80h, 3Eh, 60h, 50h, 0, 75h, 7, 0BBh, 5, 0
	db	0B8h, 4, 0, 0C3h, 0BBh, 7, 0, 0B8h, 6, 0, 0C3h, 57h, 80h, 3Eh, 3Dh, 50h
	db	0, 74h, 76h, 8Ah, 0C2h, 32h, 6, 3Dh, 50h, 24h, 1, 75h, 61h, 0C4h, 3Eh, 42h
	db	50h, 80h, 0E2h, 0FEh, 80h, 0CFh, 80h, 0Ah, 0FAh, 8Bh, 0C3h, 86h, 0C4h, 0ABh, 5Bh, 3Ah
	db	0CDh, 75h, 4, 3Bh, 0F3h, 74h, 1Dh, 8Ah, 0C1h, 0B1h, 4, 0D2h, 0E0h, 0Ah, 0C5h, 0Ch
	db	4, 0AAh, 8Bh, 0C6h, 3Dh, 7Fh, 0, 77h, 3, 0AAh, 0EBh, 6, 80h, 0CCh, 80h, 86h
	db	0E0h, 0ABh, 0EBh, 5, 8Ah, 0C5h, 0Ch, 54h, 0AAh, 8Bh, 0C3h, 3Dh, 7Fh, 0, 77h, 3
	db	0AAh, 0EBh, 6, 80h, 0CCh, 80h, 86h, 0E0h, 0ABh, 89h, 3Eh, 42h, 50h, 0A1h, 46h, 50h
	db	5, 0F6h, 3, 3Bh, 0F8h, 77h, 1, 0C3h, 0E8h, 0E6h, 0F8h, 0E9h, 52h, 0F8h, 51h, 56h
	db	53h, 52h, 0E8h, 0DCh, 0F8h, 5Ah, 5Bh, 5Eh, 59h, 0B0h, 9Ch, 8Ah, 0E2h, 80h, 0E4h, 1
	db	0Ah, 0C4h, 0A2h, 3Dh, 50h, 0E8h, 0F0h, 0, 0EBh, 87h
L14E17:	mov	al, 88h	;@14E17
	call	L14F05	;@14E19
	xor	ax, ax	;@14E1C
	stosw	;@14E1E
@@1:	lodsb	;@14E1F
	or	al, al	;@14E20
	je	@@2	;@14E22
	stosb	;@14E24
	jmp	@@1	;@14E25
@@2:	jmp	short L14E7B	;@14E27
	db	57h, 50h, 0C6h, 6, 60h, 50h, 0, 0Ah, 0C0h, 74h, 9, 0Bh, 0D2h, 74h	;@14E29
	db	5, 0C6h, 6, 60h, 50h, 1, 0B0h, 8Ah, 0Ah, 6, 60h, 50h, 0E8h, 0BFh
	db	0, 58h, 0Ah, 0C0h, 0AAh, 74h, 21h, 8Ah, 0C1h, 0B1h, 4, 0D2h, 0E0h
	db	0Ah, 0C5h, 0AAh, 8Bh, 0C6h, 0E8h, 7Eh, 0, 58h, 0E8h, 7Ah, 0, 8Bh
	db	0C3h, 0ABh, 80h, '>`P', 0, 74h, 6, 8Bh, 0C2h, 0ABh, 0EBh, 1, 58h
	db	0EBh, 0Bh
L14E70:	mov	byte ptr ds:[38C8h], 6	;@14E70
	stc	;@14E75
	mov	sp, word ptr ds:[38ACh]	;@14E76
	retf	;@14E7A
L14E7B:	push	bx	;@14E7B
	push	si	;@14E7C
	mov	bx, word ptr ds:[5046h]	;@14E7D
	mov	ax, di	;@14E81
	sub	ax, 2	;@14E83
	sub	ax, bx	;@14E86
	mov	word ptr es:[bx+1], ax	;@14E88
	mov	cx, di	;@14E8C
	mov	si, word ptr ds:[5046h]	;@14E8E
	sub	cx, si	;@14E92
	mov	bx, ds	;@14E94
	mov	ax, es	;@14E96
	mov	ds, ax	;@14E98
	xor	ax, ax	;@14E9A
@@1:	lodsb	;@14E9C
	add	ah, al	;@14E9D
	loop	@@1	;@14E9F
	mov	ds, bx	;@14EA1
	mov	al, ah	;@14EA3
	neg	al	;@14EA5
	stosb	;@14EA7
	pop	si	;@14EA8
	pop	bx	;@14EA9
	mov	ax, word ptr ds:[5036h]	;@14EAA
	sub	ax, 404h	;@14EAD
	cmp	di, ax	;@14EB0
	ja	L14EB9	;@14EB2
	mov	word ptr ds:[5046h], di	;@14EB4
	ret	;@14EB8
L14EB9:	push	bx	;@14EB9
	push	si	;@14EBA
	push	dx	;@14EBB
	mov	cx, di	;@14EBC
	mov	ax, es	;@14EBE
	xor	dx, dx	;@14EC0
	mov	bx, word ptr ds:[505Ch]	;@14EC2
	push	cs	;@14EC6
	call	L119BC	;@14EC7
	pop	dx	;@14ECA
	pop	si	;@14ECB
	pop	bx	;@14ECC
	jae	@@1	;@14ECD
	jmp	L14E70	;@14ECF
@@1:	mov	word ptr ds:[5046h], 0	;@14ED1
	ret	;@14ED7
L14ED8:	cmp	ax, 7Fh	;@14ED8
	ja	@@1	;@14EDB
	stosb	;@14EDD
	ret	;@14EDE
@@1:	or	ah, 80h	;@14EDF
	xchg	ah, al	;@14EE2
	stosw	;@14EE4
	ret	;@14EE5
L14EE6:	push	si	;@14EE6
	push	ds	;@14EE7
	push	es	;@14EE8
	xchg	si, di	;@14EE9
	cmp	cl, 3Fh	;@14EEB
	jb	@@1	;@14EEE
	mov	cl, 3Fh	;@14EF0
@@1:	push	cs	;@14EF2
	call	L1035F	;@14EF3
	push	es	;@14EF6
	pop	ds	;@14EF7
	pop	es	;@14EF8
	xchg	di, si	;@14EF9
	xor	ch, ch	;@14EFB
	mov	al, cl	;@14EFD
	stosb	;@14EFF
	rep movsb	;@14F00
	pop	ds	;@14F02
	pop	si	;@14F03
	ret	;@14F04
L14F05:	mov	es, word ptr ds:[5044h]	;@14F05
	mov	di, word ptr ds:[5046h]	;@14F09
	stosb	;@14F0D
	add	di, 2	;@14F0E
	ret	;@14F11
SEG2	ends

SEG3	segment para public 'CODE'
	assume	cs:SEG3
L14F20:	lodsb	;@14F20
	cmp	al, 2	;@14F21
	jbe	@@1	;@14F23
	stosb	;@14F25
	jmp	L14F20	;@14F26
@@1:	cmp	al, 1	;@14F28
	je	@@2	;@14F2A
	cmp	al, 2	;@14F2C
	je	@@3	;@14F2E
	retf	;@14F30
@@2:	lodsw	;@14F31
	push	si	;@14F32
	push	ds	;@14F33
	mov	si, ax	;@14F34
	push	ss	;@14F36
	pop	ds	;@14F37
	push	cs	;@14F38
	call	L14F20	;@14F39
	pop	ds	;@14F3C
	pop	si	;@14F3D
	jmp	L14F20	;@14F3E
@@3:	lodsb	;@14F40
	xor	ah, ah	;@14F41
	push	si	;@14F43
	push	ds	;@14F44
	push	ss	;@14F45
	pop	ds	;@14F46
	xor	si, si	;@14F47
	cmp	al, 0Fh	;@14F49
	jae	@@4	;@14F4B
	mov	si, ax	;@14F4D
	shl	si, 1	;@14F4F
	mov	si, word ptr [si+0A52h]	;@14F51
	push	cs	;@14F55
	call	L14F20	;@14F56
@@4:	pop	ds	;@14F59
	pop	si	;@14F5A
	jmp	L14F20	;@14F5B
SEG3	ends

SEG4	segment para public 'CODE'
	assume	cs:SEG4
L14F60:	call	L14FCC	;@14F60
	cmp	word ptr ds:[96h], 1	;@14F63
	jbe	L14FC4	;@14F68
	test	word ptr ds:[94h], 1	;@14F6A
	je	L14FC4	;@14F70
	push	ds	;@14F72
	pop	es	;@14F73
	mov	di, 4628h	;@14F74
	mov	dx, 10Eh	;@14F77
	mov	cx, word ptr ds:[96h]	;@14F7A
	call	@@1	;@14F7E
	mov	dx, 121h	;@14F81
	mov	cx, word ptr ds:[9Ch]	;@14F84
	call	@@1	;@14F88
	mov	dx, 134h	;@14F8B
	mov	cx, word ptr ds:[98h]	;@14F8E
	call	@@1	;@14F92
	mov	dx, 141h	;@14F95
	mov	cx, word ptr ds:[9Ah]	;@14F98
	call	@@1	;@14F9C
	mov	dx, 0F0h	;@14F9F
	call	L1538A	;@14FA2
	jmp	short L14FC4	;@14FA5
@@1:	push	cx	;@14FA7
	call	L1538A	;@14FA8
	mov	di, 4628h	;@14FAB
	pop	cx	;@14FAE
	call	L15314	;@14FAF
	mov	dx, 4628h	;@14FB2
	call	L1538A	;@14FB5
	ret	;@14FB8
L14FB9:	mov	dx, 320h	;@14FB9
L14FBC:	call	L1538A	;@14FBC
L14FBF:	mov	byte ptr ds:[1Bh], 2	;@14FBF
L14FC4:	mov	al, byte ptr ds:[1Bh]	;@14FC4
	jmp	far ptr L1194A	;@14FC7
L14FCC:	les	di, dword ptr ds:[36DAh]	;@14FCC
@@1:	cmp	word ptr es:[di], 1	;@14FD0
	jne	@@3	;@14FD4
	mov	si, word ptr es:[di+0Eh]	;@14FD6
@@2:	call	@@4	;@14FDA
	jb	@@3	;@14FDD
	cmp	byte ptr es:[si], 0FFh	;@14FDF
	jne	@@2	;@14FE3
	inc	si	;@14FE5
	mov	di, si	;@14FE6
	jmp	@@1	;@14FE8
@@3:	ret	;@14FEA
@@4:	cmp	byte ptr es:[si], 0FFh	;@14FEB
	jne	@@5	;@14FEF
	ret	;@14FF1
@@5:	push	di	;@14FF2
	push	es	;@14FF3
	push	di	;@14FF4
	push	es	;@14FF5
	push	si	;@14FF6
	mov	word ptr ds:[36F2h], 0	;@14FF7
	mov	word ptr ds:[36F4h], 0	;@14FFD
	mov	word ptr ds:[9Eh], 36FFh	;@15003
	mov	byte ptr ds:[36D6h], 0	;@15009
	and	word ptr ds:[94h], -3	;@1500E
	call	far ptr L00006	;@15013
	jae	@@6	;@15018
	pop	si	;@1501A
	pop	es	;@1501B
	pop	di	;@1501C
	push	si	;@1501D
	call	L153B6	;@1501E
	mov	al, 2	;@15021
	call	L153AC	;@15023
	stc	;@15026
	jmp	@@22	;@15027
@@6:	pop	si	;@1502A
	pop	ds	;@1502B
	push	ss	;@1502C
	pop	es	;@1502D
	mov	di, 36FFh	;@1502E
	call	L152E2	;@15031
	mov	di, 374Fh	;@15034
	call	L152E2	;@15037
	mov	di, 379Fh	;@1503A
	call	L152E2	;@1503D
	mov	di, 37EFh	;@15040
	call	L152E2	;@15043
	push	ds	;@15046
	push	si	;@15047
	push	ss	;@15048
	pop	ds	;@15049
	mov	si, 36FFh	;@1504A
	call	L15359	;@1504D
	mov	cx, 4	;@15050
	mov	di, 383Fh	;@15053
	rep movsw	;@15056
	xor	al, al	;@15058
	stosb	;@1505A
	mov	si, 383Fh	;@1505B
	call	L1537F	;@1505E
	mov	byte ptr [si], 0	;@15061
	pop	si	;@15064
	pop	es	;@15065
	pop	di	;@15066
	push	si	;@15067
	mov	bx, word ptr es:[di+0Ah]	;@15068
	mov	ax, word ptr es:[di+2]	;@1506C
	mov	word ptr ds:[38B6h], ax	;@15070
	mov	ax, word ptr es:[di+4]	;@15073
	mov	word ptr ds:[38B8h], ax	;@15077
	mov	word ptr ds:[36F6h], ax	;@1507A
	mov	ax, word ptr es:[di+6]	;@1507D
	mov	word ptr ds:[38BAh], ax	;@15081
	mov	word ptr ds:[38C4h], 64h	;@15084
	mov	word ptr ds:[38C2h], 0FFFFh	;@1508A
	push	ss	;@15090
	pop	es	;@15091
	mov	di, 65h	;@15092
	xor	dh, dh	;@15095
	dec	word ptr ds:[1Dh]	;@15097
	jne	@@7	;@1509B
	or	dh, 2	;@1509D
@@7:	cmp	word ptr ds:[1Fh], 0	;@150A0
	jne	@@8	;@150A5
	or	dh, 1	;@150A7
@@8:	cmp	byte ptr ds:[379Fh], 0	;@150AA
	je	@@9	;@150AF
	dec	word ptr ds:[1Fh]	;@150B1
@@9:	push	es	;@150B5
	mov	ax, 5920h	;@150B6
	mov	word ptr ds:[38C6h], ax	;@150B9
	mov	ax, 205h	;@150BC
	call	far ptr L00011	;@150BF
	pop	es	;@150C4
	mov	byte ptr ds:[36D5h], 1	;@150C5
	jae	@@10	;@150CA
	call	L153B6	;@150CC
	mov	al, 2	;@150CF
	call	L153AC	;@150D1
	stc	;@150D4
	jmp	@@20	;@150D5
@@10:	test	word ptr ds:[38B6h], 400h	;@150D8
	jne	@@11	;@150DE
	call	L153D6	;@150E0
@@11:	pop	si	;@150E3
	pop	es	;@150E4
	pop	di	;@150E5
	push	di	;@150E6
	push	es	;@150E7
	push	si	;@150E8
	lea	si, [di+10h]	;@150E9
	push	es	;@150EC
	pop	ds	;@150ED
@@12:	cmp	si, word ptr es:[di+0Eh]	;@150EE
	jae	@@15	;@150F2
	lodsb	;@150F4
	push	ds	;@150F5
	push	es	;@150F6
	push	di	;@150F7
	push	ax	;@150F8
	push	ss	;@150F9
	pop	es	;@150FA
	mov	di, 3A24h	;@150FB
	mov	dx, di	;@150FE
	call	L152E2	;@15100
	push	ss	;@15103
	pop	ds	;@15104
	pop	ax	;@15105
	push	si	;@15106
	cmp	al, 1	;@15107
	je	@@13	;@15109
	mov	byte ptr ds:[36FBh], 49h	;@1510B
	call	far ptr L00023	;@15110
	jmp	short @@14	;@15115
@@13:	mov	byte ptr ds:[36FBh], 44h	;@15117
	mov	di, dx	;@1511C
	call	far ptr L0002C	;@1511E
@@14:	pop	si	;@15123
	pop	di	;@15124
	pop	es	;@15125
	pop	ds	;@15126
	jae	@@12	;@15127
	mov	ax, ss	;@15129
	mov	ds, ax	;@1512B
	mov	es, ax	;@1512D
	call	@@23	;@1512F
	mov	dx, 0D3h	;@15132
	call	L1538A	;@15135
	mov	al, byte ptr ds:[36D3h]	;@15138
	mov	byte ptr ds:[36FAh], al	;@1513B
	mov	byte ptr ds:[36FCh], 0	;@1513E
	mov	dx, 36FAh	;@15143
	call	L1538A	;@15146
	mov	dx, 379Fh	;@15149
	call	L1538A	;@1514C
	mov	dx, 1B8h	;@1514F
	call	L1538A	;@15152
	call	L153B6	;@15155
	mov	dx, 0F0h	;@15158
	call	L1538A	;@1515B
	stc	;@1515E
	jmp	short @@20	;@1515F
@@15:	mov	ax, ss	;@15161
	mov	ds, ax	;@15163
	mov	es, ax	;@15165
	mov	byte ptr ds:[36D4h], 0	;@15167
	mov	bx, 36FFh	;@1516C
	mov	dx, 374Fh	;@1516F
	mov	si, 379Fh	;@15172
	mov	di, 37EFh	;@15175
	cmp	byte ptr [si], 0	;@15178
	jne	@@16	;@1517B
	mov	byte ptr [di], 0	;@1517D
@@16:	mov	cx, 383Fh	;@15180
	call	far ptr L0001A	;@15183
	jae	@@17	;@15188
	mov	byte ptr ds:[36D4h], 1	;@1518A
	mov	byte ptr ds:[1Ch], 1	;@1518F
@@17:	call	@@23	;@15194
	cmp	byte ptr ds:[36D4h], 1	;@15197
	jne	@@18	;@1519C
	call	L153D6	;@1519E
	call	L153B6	;@151A1
	inc	word ptr ds:[9Ch]	;@151A4
@@18:	test	word ptr ds:[94h], 2	;@151A8
	je	@@19	;@151AE
	mov	dx, 0F0h	;@151B0
	call	L1538A	;@151B3
@@19:	inc	word ptr ds:[96h]	;@151B6
	mov	ax, word ptr ds:[36F2h]	;@151BA
	add	word ptr ds:[98h], ax	;@151BD
	mov	ax, word ptr ds:[36F4h]	;@151C1
	add	word ptr ds:[9Ah], ax	;@151C4
	clc	;@151C8
@@20:	pushf	;@151C9
	call	far ptr L00035	;@151CA
	mov	byte ptr ds:[36D5h], 0	;@151CF
	call	far ptr L0FFF8	;@151D4
	cmp	byte ptr ds:[36D6h], 1	;@151D9
	jne	@@21	;@151DE
	mov	dx, 374Fh	;@151E0
	call	far ptr L119D0	;@151E3
@@21:	popf	;@151E8
@@22:	pop	si	;@151E9
	pop	es	;@151EA
	pop	di	;@151EB
	mov	word ptr ds:[9Eh], 0	;@151EC
	ret	;@151F2
@@23:	call	far ptr L0FF80	;@151F3
	test	word ptr ds:[94h], 2	;@151F8
	je	@@26	;@151FE
	mov	dx, 150h	;@15200
	call	L1538A	;@15203
	mov	cx, word ptr ds:[36F2h]	;@15206
	call	@@27	;@1520A
	mov	dx, 164h	;@1520D
	call	L1538A	;@15210
	mov	cx, word ptr ds:[36F4h]	;@15213
	call	@@27	;@15217
	mov	dx, 17Ah	;@1521A
	call	L1538A	;@1521D
	mov	cx, word ptr ds:[36F6h]	;@15220
	sub	cx, word ptr ds:[38B8h]	;@15224
	call	@@27	;@15228
	mov	dx, 190h	;@1522B
	call	L1538A	;@1522E
	call	far ptr L00039	;@15231
	cmp	ax, 0FFFh	;@15236
	ja	@@24	;@15239
	mov	cl, 4	;@1523B
	shl	ax, cl	;@1523D
	mov	dx, 1A6h	;@1523F
	jmp	short @@25	;@15242
@@24:	mov	cl, 6	;@15244
	shr	ax, cl	;@15246
	mov	dx, 1AFh	;@15248
@@25:	push	dx	;@1524B
	mov	cx, ax	;@1524C
	mov	di, ds	;@1524E
	mov	es, di	;@15250
	mov	di, 379Fh	;@15252
	mov	dx, di	;@15255
	call	L15314	;@15257
	call	L1538A	;@1525A
	pop	dx	;@1525D
	call	L1538A	;@1525E
@@26:	ret	;@15261
@@27:	jcxz	@@28	;@15262
	mov	dx, ds	;@15264
	mov	es, dx	;@15266
	mov	di, 379Fh	;@15268
	mov	dx, di	;@1526B
	call	L15314	;@1526D
	call	L1538A	;@15270
	ret	;@15273
@@28:	mov	dx, 1B3h	;@15274
	call	L1538A	;@15277
	ret	;@1527A
L1527B:	push	es	;@1527B
	push	ds	;@1527C
	pop	es	;@1527D
	push	cx	;@1527E
	push	bx	;@1527F
	call	L153D6	;@15280
	pop	si	;@15283
	mov	di, 4628h	;@15284
	push	di	;@15287
	call	far ptr L14F20	;@15288
	xor	al, al	;@1528D
	stosb	;@1528F
	pop	dx	;@15290
	call	L1538A	;@15291
	mov	dx, 0F0h	;@15294
	call	L1538A	;@15297
	pop	cx	;@1529A
	cmp	cx, -1	;@1529B
	je	@@1	;@1529E
	test	cx, 8000h	;@152A0
	je	@@2	;@152A4
	inc	word ptr ds:[36F4h]	;@152A6
@@1:	clc	;@152AA
	pop	es	;@152AB
	retf	;@152AC
@@2:	mov	al, 1	;@152AD
	call	L153AC	;@152AF
	inc	word ptr ds:[36F2h]	;@152B2
	and	cx, 7FFh	;@152B6
	cmp	cx, 24h	;@152BA
	je	@@1	;@152BD
	mov	byte ptr ds:[36D6h], 1	;@152BF
	jmp	@@1	;@152C4
L152C6:	cmp	al, 61h	;@152C6
	jb	@@1	;@152C8
	cmp	al, 7Ah	;@152CA
	ja	@@1	;@152CC
	sub	al, 20h	;@152CE
@@1:	ret	;@152D0
L152D1:	push	di	;@152D1
	push	di	;@152D2
	xor	al, al	;@152D3
	mov	cx, 0FFFFh	;@152D5
	repne scasb	;@152D8
	dec	di	;@152DA
	pop	ax	;@152DB
	sub	di, ax	;@152DC
	mov	cx, di	;@152DE
	pop	di	;@152E0
	ret	;@152E1
L152E2:	lodsb	;@152E2
	stosb	;@152E3
	or	al, al	;@152E4
	jne	L152E2	;@152E6
	ret	;@152E8
L152E9:	push	ax	;@152E9
	push	si	;@152EA
	mov	ah, al	;@152EB
@@1:	lodsb	;@152ED
	cmp	al, ah	;@152EE
	je	@@2	;@152F0
	or	al, al	;@152F2
	jne	@@1	;@152F4
	pop	si	;@152F6
	pop	ax	;@152F7
	ret	;@152F8
@@2:	dec	si	;@152F9
	pop	ax	;@152FA
	pop	ax	;@152FB
	ret	;@152FC
L152FD:	mov	ah, al	;@152FD
@@1:	lodsb	;@152FF
	or	al, al	;@15300
	je	@@2	;@15302
	cmp	al, ah	;@15304
	je	@@2	;@15306
	cmp	al, byte ptr es:[di]	;@15308
	jne	@@2	;@1530B
	inc	di	;@1530D
	jmp	@@1	;@1530E
@@2:	cmp	al, byte ptr es:[di]	;@15310
	ret	;@15313
L15314:	push	ax	;@15314
	push	si	;@15315
	push	di	;@15316
	mov	ah, 30h	;@15317
	mov	si, 2710h	;@15319
	call	@@1	;@1531C
	mov	si, 3E8h	;@1531F
	call	@@1	;@15322
	mov	si, 64h	;@15325
	call	@@1	;@15328
	mov	si, 0Ah	;@1532B
	call	@@1	;@1532E
	mov	si, 1	;@15331
	mov	ah, 0FFh	;@15334
	call	@@1	;@15336
	xor	al, al	;@15339
	stosb	;@1533B
	pop	di	;@1533C
	pop	si	;@1533D
	pop	ax	;@1533E
	ret	;@1533F
@@1:	mov	al, 2Fh	;@15340
@@2:	inc	al	;@15342
	sub	cx, si	;@15344
	jae	@@2	;@15346
	add	cx, si	;@15348
	cmp	al, ah	;@1534A
	je	@@3	;@1534C
	mov	ah, 0FFh	;@1534E
	stosb	;@15350
@@3:	ret	;@15351
L15352:	cmp	al, 5Ch	;@15352
	je	@@1	;@15354
	cmp	al, 3Ah	;@15356
@@1:	ret	;@15358
L15359:	push	cx	;@15359
	push	di	;@1535A
	push	es	;@1535B
	mov	ax, ds	;@1535C
	mov	es, ax	;@1535E
	mov	di, si	;@15360
	xor	al, al	;@15362
	mov	cx, 0FFFFh	;@15364
	repne scasb	;@15367
	dec	di	;@15369
	std	;@1536A
	xchg	si, di	;@1536B
@@1:	lodsb	;@1536D
	call	L15352	;@1536E
	je	@@2	;@15371
	cmp	si, di	;@15373
	jae	@@1	;@15375
	dec	si	;@15377
@@2:	inc	si	;@15378
	inc	si	;@15379
	cld	;@1537A
	pop	es	;@1537B
	pop	di	;@1537C
	pop	cx	;@1537D
	ret	;@1537E
L1537F:	lodsb	;@1537F
	or	al, al	;@15380
	je	@@1	;@15382
	cmp	al, 2Eh	;@15384
	jne	L1537F	;@15386
@@1:	dec	si	;@15388
	ret	;@15389
L1538A:	push	es	;@1538A
	push	ds	;@1538B
	pop	es	;@1538C
	call	L1539A	;@1538D
	pop	es	;@15390
	ret	;@15391
L15392:	push	es	;@15392
	push	cs	;@15393
	pop	es	;@15394
	call	L1539A	;@15395
	pop	es	;@15398
	ret	;@15399
L1539A:	push	di	;@1539A
	mov	di, dx	;@1539B
	call	L152D1	;@1539D
	mov	bx, 1	;@153A0
	mov	ax, es	;@153A3
	call	far ptr L119BC	;@153A5
	pop	di	;@153AA
	ret	;@153AB
L153AC:	cmp	al, byte ptr ds:[1Bh]	;@153AC
	jbe	@@1	;@153B0
	mov	byte ptr ds:[1Bh], al	;@153B2
@@1:	ret	;@153B5
L153B6:	push	ss	;@153B6
	pop	es	;@153B7
	mov	al, byte ptr ss:[38C8h]	;@153B8
	cmp	al, 0Eh	;@153BC
	jb	@@1	;@153BE
	xor	al, al	;@153C0
@@1:	mov	bl, al	;@153C2
	xor	bh, bh	;@153C4
	shl	bx, 1	;@153C6
	mov	dx, word ptr [bx+1BCh]	;@153C8
	call	L1538A	;@153CC
	mov	al, 2	;@153CF
	call	L153AC	;@153D1
	stc	;@153D4
	ret	;@153D5
L153D6:	push	ds	;@153D6
	pop	es	;@153D7
	test	word ptr ds:[94h], 1	;@153D8
	jne	@@1	;@153DE
	or	word ptr ds:[94h], 1	;@153E0
	mov	dx, 65h	;@153E5
	call	L1538A	;@153E8
	mov	dx, 0A0h	;@153EB
	call	L1538A	;@153EE
@@1:	cmp	word ptr ds:[9Eh], 0	;@153F1
	je	@@3	;@153F6
	test	word ptr ds:[94h], 2	;@153F8
	jne	@@3	;@153FE
	or	word ptr ds:[94h], 2	;@15400
	mov	dx, 0F0h	;@15405
	call	L1538A	;@15408
	mov	dx, 0FAh	;@1540B
	call	L1538A	;@1540E
	mov	dx, word ptr ds:[9Eh]	;@15411
	call	L1538A	;@15415
	mov	si, word ptr ds:[9Eh]	;@15418
	mov	di, 374Fh	;@1541C
	mov	al, 2Eh	;@1541F
	call	L152FD	;@15421
	je	@@2	;@15424
	cmp	byte ptr ds:[374Fh], 0	;@15426
	je	@@2	;@1542B
	mov	dx, 0F3h	;@1542D
	call	L1538A	;@15430
	mov	dx, 374Fh	;@15433
	call	L1538A	;@15436
@@2:	mov	dx, 0F0h	;@15439
	call	L1538A	;@1543C
@@3:	ret	;@1543F
L15440:	mov	dx, bx	;@15440
	mov	bx, 1	;@15442
	mov	ax, ds	;@15445
	mov	cx, di	;@15447
	dec	cx	;@15449
	call	far ptr L119BC	;@1544A
	mov	dx, 0F0h	;@1544F
	call	L1538A	;@15452
	retf	;@15455
	db	'**Fatal** Invalid command line', 0Dh, 0Ah, 0, '**Fatal** Bad switch: '	;@15456
	db	0, 0Dh, 0Ah, 0, '**Fatal** Missing switch character', 0Dh, 0Ah
	db	0, '**Fatal** Invalid number after ', 0, '**Fatal** Invalid argument after '
	db	0, '**Fatal** Can', 27h, 't find @file ', 0, 'Syntax:  TASM [options] source [,object] [,listing'
	db	'] [,xref]', 0Dh, 0Ah, '/a,/s         Alphabetic or Source-code segment or'
	db	'dering', 0Dh, 0Ah, '/c            Generate cross-reference in listing'
	db	0Dh, 0Ah, '/dSYM[=VAL]   Define symbol SYM = 0, or = value VA'
	db	4Ch, 0Dh, 0Ah, '/e,/r         Emulated or Real floating-point inst'
	db	'ructions', 0Dh, 0Ah, '/h,/?         Display this help screen'
	db	0Dh, 0Ah, '/iPATH        Search PATH for include files', 0Dh, 0Ah
	db	'/jCMD         Jam in an assembler directive CMD (e', 'g. /jIDEAL)'
	db	0Dh, 0Ah, '/kh#          Hash table capacity # symbols', 0Dh, 0Ah
	db	'/l,/la        Generate listing: l=normal listing, ', 'la=expanded listing'
	db	0Dh, 0Ah, '/ml,/mx,/mu   Case sensitivity on symbols: ml=all,'
	db	' mx=globals, mu=none', 0Dh, 0Ah, '/mv#          Set maximum valid length for symbols'
	db	0Dh, 0Ah, '/m#           Allow # multiple passes to resolve f'
	db	'orward references', 0Dh, 0Ah, '/n            Suppress symbol tables in listing'
	db	0Dh, 0Ah, '/o,/op        Generate overlay object code, Phar L'
	db	'ap-style 32-bit fixups', 0Dh, 0Ah, '/p            Check for code segment overrides in '
	db	'protected mode', 0Dh, 0Ah, '/q            Suppress OBJ records not needed for '
	db	'linking', 0Dh, 0Ah, '/t            Suppress messages if successful asse'
	db	'mbly', 0Dh, 0Ah, '/w0,/w1,/w2   Set warning level: w0=none, w1=w2=wa'
	db	'rnings on', 0Dh, 0Ah, '/w-xxx,/w+xxx Disable (-) or enable (+) warning xx'
	db	78h, 0Dh, 0Ah, '/x            Include false conditionals in listin'
	db	67h, 0Dh, 0Ah, '/z            Display source line with error messa'
	db	67h, 65h, 0Dh, 0Ah, '/zi,/zd       Debug info: zi=full, zd=line numbers'
	db	' only', 0
start:	cld	;@15A3D
	mov	ax, SEG5	;@15A3E
	mov	ds, ax	;@15A41
	cli	;@15A43
	mov	ss, ax	;@15A44
	mov	sp, 5CE0h	;@15A46
	sti	;@15A49
	mov	bx, 81h	;@15A4A
	mov	word ptr ds:[36A0h], bx	;@15A4D
	mov	word ptr ds:[36A2h], es	;@15A51
	add	bl, byte ptr es:[80h]	;@15A55
	mov	byte ptr es:[bx], 0	;@15A5A
	mov	word ptr ds:[36A6h], 0	;@15A5E
	mov	ah, 30h	;@15A64
	int	21h	;@15A66
	cmp	al, 3	;@15A68
	jb	@@2	;@15A6A
	mov	ax, word ptr es:[2Ch]	;@15A6C
	mov	word ptr ds:[36A6h], ax	;@15A70
	push	ds	;@15A73
	mov	ds, ax	;@15A74
	xor	si, si	;@15A76
@@1:	xor	al, al	;@15A78
	call	L152E9	;@15A7A
	inc	si	;@15A7D
	cmp	byte ptr [si], 0	;@15A7E
	jne	@@1	;@15A81
	inc	si	;@15A83
	inc	si	;@15A84
	inc	si	;@15A85
	pop	ds	;@15A86
	mov	word ptr ds:[36A4h], si	;@15A87
@@2:	push	ss	;@15A8B
	pop	es	;@15A8C
	push	es	;@15A8D
	call	far ptr L118F4	;@15A8E
	pop	es	;@15A93
	call	@@109	;@15A94
	call	@@54	;@15A97
	jmp	short @@3	;@15A9A
@@3:	call	@@67	;@15A9C
	jb	@@5	;@15A9F
	cmp	word ptr ds:[1Dh], 0	;@15AA1
	je	@@4	;@15AA6
	mov	cl, 4	;@15AA8
	mov	ax, word ptr ds:[36E2h]	;@15AAA
	sub	ax, word ptr ds:[36DAh]	;@15AAD
	add	ax, 12h	;@15AB1
	shr	ax, cl	;@15AB4
	mov	cx, ax	;@15AB6
	mov	ax, word ptr ds:[36DCh]	;@15AB8
	push	es	;@15ABB
	call	far ptr L1006C	;@15ABC
	pop	es	;@15AC1
	jmp	L14F60	;@15AC2
@@4:	call	L153D6	;@15AC5
	mov	dx, 5B4h	;@15AC8
	call	L15392	;@15ACB
	jmp	L14FC4	;@15ACE
@@5:	call	L153D6	;@15AD1
	mov	dx, 4F6h	;@15AD4
	call	L15392	;@15AD7
	jmp	L14FBF	;@15ADA
@@6:	cmp	al, 41h	;@15ADD
	jb	@@7	;@15ADF
	cmp	al, 5Ah	;@15AE1
	ja	@@7	;@15AE3
	add	al, 20h	;@15AE5
@@7:	ret	;@15AE7
@@8:	push	si	;@15AE8
	push	di	;@15AE9
@@9:	lodsb	;@15AEA
	stosb	;@15AEB
	or	al, al	;@15AEC
	jne	@@9	;@15AEE
	pop	di	;@15AF0
	pop	si	;@15AF1
	ret	;@15AF2
	db	'PVW', 87h, 0F7h, 32h, 0C0h, 0E8h, 0ECh, 0F7h, 87h, 0F7h, 0E8h	;@15AF3
	db	0E6h, 0FFh, '_^X', 0C3h
@@10:	cmp	al, 2Dh	;@15B06
	je	@@11	;@15B08
	cmp	al, 2Fh	;@15B0A
	je	@@11	;@15B0C
	ret	;@15B0E
@@11:	mov	byte ptr ds:[36D3h], al	;@15B0F
	ret	;@15B12
@@12:	push	si	;@15B13
@@13:	lodsb	;@15B14
	or	al, al	;@15B15
	je	@@15	;@15B17
	cmp	al, 3Fh	;@15B19
	je	@@14	;@15B1B
	cmp	al, 2Ah	;@15B1D
	jne	@@13	;@15B1F
@@14:	pop	si	;@15B21
	ret	;@15B22
@@15:	inc	al	;@15B23
	pop	si	;@15B25
	ret	;@15B26
@@16:	cmp	byte ptr [si], 0	;@15B27
	je	@@20	;@15B2A
	push	dx	;@15B2C
	push	si	;@15B2D
@@17:	lodsb	;@15B2E
	or	al, al	;@15B2F
	jne	@@17	;@15B31
	dec	si	;@15B33
	dec	si	;@15B34
	lodsb	;@15B35
	pop	si	;@15B36
	call	L15352	;@15B37
	je	@@19	;@15B3A
	mov	dx, si	;@15B3C
	call	far ptr L11996	;@15B3E
	jb	@@18	;@15B43
	call	far ptr L119AC	;@15B45
	xor	ax, ax	;@15B4A
@@18:	cmp	ax, 5	;@15B4C
@@19:	pop	dx	;@15B4F
	ret	;@15B50
@@20:	xor	al, al	;@15B51
	inc	al	;@15B53
	stc	;@15B55
	ret	;@15B56
@@21:	cmp	byte ptr [si], 0	;@15B57
	je	@@22	;@15B5A
	cmp	byte ptr [si+1], 3Ah	;@15B5C
	jne	@@22	;@15B60
	movsb	;@15B62
	movsb	;@15B63
@@22:	lodsb	;@15B64
	or	al, al	;@15B65
	je	@@27	;@15B67
	cmp	al, 3Fh	;@15B69
	je	@@23	;@15B6B
	cmp	al, 2Ah	;@15B6D
	je	@@24	;@15B6F
	stosb	;@15B71
	cmp	byte ptr [bx], 0	;@15B72
	je	@@22	;@15B75
	inc	bx	;@15B77
	jmp	@@22	;@15B78
@@23:	mov	al, byte ptr [bx]	;@15B7A
	inc	bx	;@15B7C
	stosb	;@15B7D
	jmp	@@22	;@15B7E
@@24:	xchg	si, bx	;@15B80
@@25:	lodsb	;@15B82
	or	al, al	;@15B83
	je	@@26	;@15B85
	cmp	al, 2Eh	;@15B87
	je	@@26	;@15B89
	stosb	;@15B8B
	jmp	@@25	;@15B8C
@@26:	xchg	si, bx	;@15B8E
	dec	bx	;@15B90
	jmp	@@22	;@15B91
@@27:	xor	al, al	;@15B93
	stosb	;@15B95
	ret	;@15B96
@@28:	push	si	;@15B97
	push	di	;@15B98
@@29:	lodsb	;@15B99
	stosb	;@15B9A
	or	al, al	;@15B9B
	jne	@@29	;@15B9D
	pop	di	;@15B9F
	pop	si	;@15BA0
	call	L15359	;@15BA1
	push	si	;@15BA4
	mov	si, di	;@15BA5
	call	L15359	;@15BA7
	mov	di, si	;@15BAA
	mov	si, bx	;@15BAC
	call	L15359	;@15BAE
	mov	bx, si	;@15BB1
	pop	si	;@15BB3
	call	@@21	;@15BB4
	ret	;@15BB7
@@30:	cmp	byte ptr [di], 0	;@15BB8
	je	@@33	;@15BBB
	push	si	;@15BBD
	push	di	;@15BBE
	xchg	si, di	;@15BBF
	call	L15359	;@15BC1
	call	L1537F	;@15BC4
	cmp	byte ptr [si], 0	;@15BC7
	jne	@@32	;@15BCA
	xchg	si, di	;@15BCC
@@31:	lodsb	;@15BCE
	stosb	;@15BCF
	or	al, al	;@15BD0
	jne	@@31	;@15BD2
@@32:	pop	di	;@15BD4
	pop	si	;@15BD5
@@33:	ret	;@15BD6
@@34:	call	@@110	;@15BD7
	mov	si, 35h	;@15BDA
	mov	di, 3E26h	;@15BDD
	call	@@8	;@15BE0
	mov	si, 42h	;@15BE3
	mov	di, 4226h	;@15BE6
	call	@@8	;@15BE9
	mov	si, 42h	;@15BEC
	mov	di, 53DEh	;@15BEF
	call	@@8	;@15BF2
	ret	;@15BF5
@@35:	cmp	al, 20h	;@15BF6
	ja	@@36	;@15BF8
	cmp	al, al	;@15BFA
	ret	;@15BFC
@@36:	push	cx	;@15BFD
	push	di	;@15BFE
	mov	di, 33Ah	;@15BFF
	mov	cx, 5	;@15C02
	repne scasb	;@15C05
	je	@@37	;@15C07
	call	@@10	;@15C09
@@37:	pop	di	;@15C0C
	pop	cx	;@15C0D
	ret	;@15C0E
@@38:	cmp	al, 20h	;@15C0F
	jbe	@@39	;@15C11
	push	cx	;@15C13
	push	di	;@15C14
	mov	di, 33Fh	;@15C15
	mov	cx, 0Ah	;@15C18
	repne scasb	;@15C1B
	pop	di	;@15C1D
	pop	cx	;@15C1E
	ret	;@15C1F
@@39:	cmp	al, al	;@15C20
	ret	;@15C22
@@40:	mov	di, word ptr ds:[36F0h]	;@15C23
@@41:	call	@@136	;@15C27
	call	@@38	;@15C2A
	je	@@42	;@15C2D
	call	@@130	;@15C2F
	stosb	;@15C32
	jmp	@@41	;@15C33
@@42:	cmp	di, word ptr ds:[36F0h]	;@15C35
	je	@@43	;@15C39
	mov	byte ptr es:[di], 0	;@15C3B
	xor	al, al	;@15C3F
	ret	;@15C41
@@43:	xor	al, al	;@15C42
	inc	al	;@15C44
	ret	;@15C46
	db	8Bh, 3Eh, 0F0h, 36h, 0E8h, 3Ch, 7, '< v', 0Ah, '<,t', 6, 0E8h	;@15C47
	db	0E2h, 6, 0AAh, 0EBh, 0EFh, 3Bh, 3Eh, 0F0h, 36h, 74h, 7, 26h, 0C6h
	db	5, 0, 32h, 0C0h, 0C3h, 32h, 0C0h, 0FEh, 0C0h, 0C3h
@@44:	call	@@136	;@15C6E
	or	al, al	;@15C71
	je	@@46	;@15C73
	cmp	al, 20h	;@15C75
	ja	@@45	;@15C77
	call	@@130	;@15C79
	jmp	@@44	;@15C7C
@@45:	call	@@10	;@15C7E
	je	@@47	;@15C81
	call	@@40	;@15C83
	je	@@48	;@15C86
	call	@@130	;@15C88
	mov	byte ptr ds:[36EFh], al	;@15C8B
	mov	ax, 3	;@15C8E
	ret	;@15C91
@@46:	mov	ax, 0	;@15C92
	ret	;@15C95
@@47:	call	@@130	;@15C96
	push	word ptr ds:[36F0h]	;@15C99
	call	@@141	;@15C9D
	pop	word ptr ds:[36F0h]	;@15CA0
	jmp	@@44	;@15CA4
@@48:	mov	ax, 1	;@15CA6
	ret	;@15CA9
@@49:	call	@@136	;@15CAA
	or	al, al	;@15CAD
	je	@@52	;@15CAF
	cmp	al, 20h	;@15CB1
	ja	@@50	;@15CB3
	call	@@130	;@15CB5
	jmp	@@49	;@15CB8
@@50:	call	@@10	;@15CBA
	je	@@51	;@15CBD
	call	@@38	;@15CBF
	jne	@@53	;@15CC2
	call	@@136	;@15CC4
	mov	byte ptr ds:[36EFh], al	;@15CC7
	mov	ax, 3	;@15CCA
	ret	;@15CCD
@@51:	call	@@130	;@15CCE
	push	word ptr ds:[36F0h]	;@15CD1
	call	@@141	;@15CD5
	pop	word ptr ds:[36F0h]	;@15CD8
	jmp	@@49	;@15CDC
@@52:	mov	ax, 0	;@15CDE
	ret	;@15CE1
@@53:	mov	ax, 1	;@15CE2
	ret	;@15CE5
	db	55h, 83h, 0ECh, 20h, 8Bh, 0ECh, 56h, 0E8h, 9Ah, 6, '<0rt<9wp'	;@15CE6
	db	0B3h, 0Ah, 33h, 0F6h, 56h, 0E8h, 8Ah, 6, 0E8h, 0DAh, 0FDh, 0E8h
	db	0F0h, 0FEh, '^t%', 83h, 0FEh, ' sZ<0r', 1Ch, '<9v', 0Ch, '<ar'
	db	14h, '<fw', 10h, 0B3h, 10h, 2Ch, 27h, 2Ch, 30h, 88h, 2, 56h, 0E8h
	db	11h, 6, 5Eh, 46h, 0EBh, 0CEh, 0C6h, 2, 0FFh, 0E8h, 56h, 6, 0E8h
	db	0A6h, 0FDh, '<hu', 7, 0E8h, 0FDh, 5, 0B3h, 10h, 0EBh, 5, 80h, 0FBh
	db	10h, 74h, 21h, 0E8h, 40h, 6, 0E8h, 0A9h, 0FEh, 75h, 19h, 33h, 0F6h
	db	32h, 0FFh, 33h, 0C0h, 80h, 3Ah, 0FFh, 74h, 0Ah, 0F7h, 0E3h, 2
	db	2, 80h, 0D4h, 0, 46h, 0EBh, 0F1h, 0Bh, 0F6h, 75h, 5, 33h, 0C0h
	db	0F9h, 0EBh, 1, 0F8h, 5Eh, 9Ch, 5Dh, 83h, 0C4h, 20h, 55h, 9Dh, 5Dh
	db	0C3h
@@54:	mov	ax, 1000h	;@15D78
	call	far ptr L10039	;@15D7B
	mov	word ptr ds:[36E0h], ax	;@15D80
	mov	word ptr ds:[36DCh], ax	;@15D83
	xor	ax, ax	;@15D86
	mov	word ptr ds:[36DEh], ax	;@15D88
	mov	word ptr ds:[36DAh], ax	;@15D8B
	mov	word ptr ds:[36D8h], 0FFFFh	;@15D8E
	ret	;@15D94
@@55:	push	es	;@15D95
	les	di, dword ptr ds:[36DEh]	;@15D96
	lea	ax, [di+10h]	;@15D9A
	cmp	ax, word ptr ds:[36D8h]	;@15D9D
	jae	@@56	;@15DA1
	mov	word ptr es:[di], 1	;@15DA3
	mov	word ptr es:[di+2], 40h	;@15DA8
	mov	word ptr es:[di+4], 1	;@15DAE
	mov	word ptr es:[di+6], 0FFh	;@15DB4
	mov	word ptr es:[di+8], 0	;@15DBA
	mov	word ptr es:[di+0Ah], 1FFFh	;@15DC0
	mov	word ptr es:[di+0Ch], ax	;@15DC6
	mov	word ptr es:[di+0Eh], ax	;@15DCA
	mov	word ptr ds:[36E2h], ax	;@15DCE
	pop	es	;@15DD1
	ret	;@15DD2
@@56:	jmp	L14FB9	;@15DD3
@@57:	push	es	;@15DD6
	mov	es, word ptr ds:[36E0h]	;@15DD7
	mov	ax, word ptr ds:[36E2h]	;@15DDB
	mov	di, ax	;@15DDE
	add	ax, 3	;@15DE0
	jb	@@58	;@15DE3
	cmp	ax, word ptr ds:[36D8h]	;@15DE5
	jae	@@58	;@15DE9
	mov	al, 0FFh	;@15DEB
	stosb	;@15DED
	mov	word ptr ds:[36DEh], di	;@15DEE
	mov	ax, 0	;@15DF2
	stosw	;@15DF5
	pop	es	;@15DF6
	ret	;@15DF7
@@58:	jmp	L14FB9	;@15DF8
@@59:	cmp	byte ptr ds:[36FFh], 0	;@15DFB
	je	@@60	;@15E00
	mov	di, 36FFh	;@15E02
	mov	si, di	;@15E05
	call	L152D1	;@15E07
	inc	cx	;@15E0A
	push	es	;@15E0B
	mov	es, word ptr ds:[36E0h]	;@15E0C
	mov	di, word ptr ds:[36E2h]	;@15E10
	add	cx, di	;@15E14
	jb	@@61	;@15E16
	cmp	cx, word ptr ds:[36D8h]	;@15E18
	jae	@@61	;@15E1C
	call	L152E2	;@15E1E
	pop	es	;@15E21
	mov	word ptr ds:[36E2h], di	;@15E22
	inc	word ptr ds:[1Dh]	;@15E26
@@60:	ret	;@15E2A
@@61:	jmp	L14FB9	;@15E2B
@@62:	mov	si, di	;@15E2E
	mov	di, 374Fh	;@15E30
	call	L152D1	;@15E33
	mov	dx, cx	;@15E36
	mov	di, 379Fh	;@15E38
	call	L152D1	;@15E3B
	add	dx, cx	;@15E3E
	mov	di, 37EFh	;@15E40
	call	L152D1	;@15E43
	add	cx, dx	;@15E46
	add	cx, 3	;@15E48
	mov	es, word ptr ds:[36E0h]	;@15E4B
	push	si	;@15E4F
	call	@@64	;@15E50
	pop	di	;@15E53
	mov	si, 374Fh	;@15E54
	call	L152E2	;@15E57
	mov	si, 379Fh	;@15E5A
	call	L152E2	;@15E5D
	mov	si, 37EFh	;@15E60
	call	L152E2	;@15E63
	cmp	byte ptr ds:[379Fh], 0	;@15E66
	je	@@63	;@15E6B
	inc	word ptr ds:[1Fh]	;@15E6D
@@63:	ret	;@15E71
	db	6, 56h, 50h, 8Bh, 0FEh, 0E8h, 57h, 0F4h, 41h, 41h, 0C4h, 3Eh, 0DEh	;@15E72
	db	36h, 26h, 8Bh, 75h, 0Ch, 56h, 51h, 0E8h, 3Eh, 0, 'Y_X^', 0FCh
	db	0AAh, 0E8h, 50h, 0F4h, 8Bh, 36h, 0DEh, 36h, 26h, 89h, 7Ch, 0Ch
	db	26h, 1, 4Ch, 0Eh, 7, 0C3h, 6, 56h, 50h, 8Bh, 0FEh, 0E8h, 29h, 0F4h
	db	41h, 41h, 0C4h, 3Eh, 0DEh, 36h, 26h, 8Bh, 75h, 0Eh, 56h, 0E8h
	db	11h, 0, '_X^', 0AAh, 0E8h, 25h, 0F4h, 8Bh, 36h, 0DEh, 36h, 26h
	db	89h, 7Ch, 0Eh, 7, 0C3h
@@64:	mov	di, word ptr ds:[36E2h]	;@15EC7
	add	word ptr ds:[36E2h], cx	;@15ECB
	mov	ax, di	;@15ECF
	sub	ax, si	;@15ED1
	mov	si, di	;@15ED3
	add	di, cx	;@15ED5
	jb	@@66	;@15ED7
	cmp	di, word ptr ds:[36D8h]	;@15ED9
	jae	@@66	;@15EDD
	and	ax, ax	;@15EDF
	je	@@65	;@15EE1
	dec	si	;@15EE3
	dec	di	;@15EE4
	push	ds	;@15EE5
	mov	cx, ax	;@15EE6
	mov	ax, es	;@15EE8
	mov	ds, ax	;@15EEA
	std	;@15EEC
	rep movsb	;@15EED
	cld	;@15EEF
	pop	ds	;@15EF0
@@65:	ret	;@15EF1
@@66:	jmp	L14FB9	;@15EF2
@@67:	mov	byte ptr ds:[3A24h], 0	;@15EF5
	call	@@55	;@15EFA
	call	@@34	;@15EFD
@@68:	call	@@49	;@15F00
	cmp	ax, 0	;@15F03
	je	@@70	;@15F06
	call	@@71	;@15F08
	jb	@@69	;@15F0B
	call	@@49	;@15F0D
	cmp	ax, 0	;@15F10
	je	@@70	;@15F13
	cmp	ax, 3	;@15F15
	jne	@@69	;@15F18
	cmp	byte ptr ds:[36EFh], 3Bh	;@15F1A
	jne	@@69	;@15F1F
	call	@@44	;@15F21
	call	@@57	;@15F24
	call	@@55	;@15F27
	call	@@34	;@15F2A
	jmp	@@68	;@15F2D
@@69:	stc	;@15F2F
	ret	;@15F30
@@70:	call	@@57	;@15F31
	clc	;@15F34
	ret	;@15F35
@@71:	call	@@76	;@15F36
	jb	@@75	;@15F39
	call	@@49	;@15F3B
	cmp	ax, 3	;@15F3E
	jne	@@72	;@15F41
	cmp	byte ptr ds:[36EFh], 2Bh	;@15F43
	jne	@@72	;@15F48
	call	@@44	;@15F4A
	jmp	@@71	;@15F4D
@@72:	call	@@78	;@15F4F
	call	@@81	;@15F52
	call	@@85	;@15F55
	les	di, dword ptr ds:[36DEh]	;@15F58
	mov	di, word ptr ds:[36E2h]	;@15F5C
	lds	si, dword ptr ds:[36DEh]	;@15F60
	mov	si, word ptr [si+0Eh]	;@15F64
@@73:	push	ss	;@15F67
	pop	es	;@15F68
	mov	di, 36FFh	;@15F69
	call	L152E2	;@15F6C
	push	si	;@15F6F
	push	ss	;@15F70
	pop	ds	;@15F71
	call	@@99	;@15F72
	pop	di	;@15F75
	call	@@62	;@15F76
	cmp	di, word ptr ds:[36E2h]	;@15F79
	jae	@@74	;@15F7D
	mov	ds, word ptr ds:[36E0h]	;@15F7F
	mov	si, di	;@15F83
	jmp	@@73	;@15F85
@@74:	mov	ax, ss	;@15F87
	mov	ds, ax	;@15F89
	mov	es, ax	;@15F8B
	clc	;@15F8D
@@75:	ret	;@15F8E
@@76:	call	@@49	;@15F8F
	cmp	ax, 1	;@15F92
	jne	@@77	;@15F95
	mov	word ptr ds:[36F0h], 3A24h	;@15F97
	call	@@44	;@15F9D
	mov	si, 21h	;@15FA0
	mov	di, 3A24h	;@15FA3
	call	@@30	;@15FA6
	call	@@92	;@15FA9
	clc	;@15FAC
	ret	;@15FAD
@@77:	stc	;@15FAE
	ret	;@15FAF
@@78:	mov	word ptr ds:[36F0h], 3E26h	;@15FB0
	call	@@49	;@15FB6
	cmp	ax, 3	;@15FB9
	jne	@@79	;@15FBC
	cmp	byte ptr ds:[36EFh], 2Ch	;@15FBE
	jne	@@79	;@15FC3
	call	@@44	;@15FC5
@@79:	call	@@90	;@15FC8
	cmp	byte ptr ds:[3E26h], 0	;@15FCB
	jne	@@80	;@15FD0
	mov	si, 35h	;@15FD2
	mov	di, 3E26h	;@15FD5
	call	@@8	;@15FD8
	clc	;@15FDB
	ret	;@15FDC
@@80:	clc	;@15FDD
	ret	;@15FDE
@@81:	mov	word ptr ds:[36F8h], 0	;@15FDF
	mov	word ptr ds:[36F0h], 4226h	;@15FE5
	call	@@49	;@15FEB
	cmp	ax, 3	;@15FEE
	jne	@@82	;@15FF1
	cmp	byte ptr ds:[36EFh], 2Ch	;@15FF3
	jne	@@82	;@15FF8
	call	@@44	;@15FFA
	mov	word ptr ds:[36F8h], 5Fh	;@15FFD
@@82:	call	@@49	;@16003
	cmp	ax, 1	;@16006
	jne	@@83	;@16009
	call	@@90	;@1600B
	clc	;@1600E
	ret	;@1600F
@@83:	mov	si, word ptr ds:[36F8h]	;@16010
	or	si, si	;@16014
	je	@@84	;@16016
	mov	di, 4226h	;@16018
	call	@@8	;@1601B
@@84:	clc	;@1601E
	ret	;@1601F
@@85:	mov	word ptr ds:[36F8h], 0	;@16020
	mov	word ptr ds:[36F0h], 53DEh	;@16026
	call	@@49	;@1602C
	cmp	ax, 3	;@1602F
	jne	@@86	;@16032
	cmp	byte ptr ds:[36EFh], 2Ch	;@16034
	jne	@@86	;@16039
	call	@@44	;@1603B
	call	@@88	;@1603E
	mov	word ptr ds:[36F8h], 3Ch	;@16041
@@86:	call	@@49	;@16047
	cmp	ax, 1	;@1604A
	je	@@87	;@1604D
	mov	si, word ptr ds:[36F8h]	;@1604F
	or	si, si	;@16053
	je	@@89	;@16055
	mov	di, 53DEh	;@16057
	call	@@8	;@1605A
	jmp	short @@88	;@1605D
@@87:	call	@@90	;@1605F
@@88:	push	es	;@16062
	les	di, dword ptr ds:[36DEh]	;@16063
	or	word ptr es:[di+2], 20h	;@16067
	pop	es	;@1606C
@@89:	clc	;@1606D
	ret	;@1606E
@@90:	call	@@49	;@1606F
	cmp	ax, 1	;@16072
	jne	@@91	;@16075
	call	@@44	;@16077
	clc	;@1607A
	ret	;@1607B
@@91:	mov	di, word ptr ds:[36F0h]	;@1607C
	mov	byte ptr [di], 0	;@16080
	clc	;@16083
	ret	;@16084
@@92:	mov	si, 3A24h	;@16085
	call	@@12	;@16088
	jne	@@93	;@1608B
	call	@@95	;@1608D
	mov	byte ptr ds:[3A24h], 0	;@16090
	ret	;@16095
@@93:	cmp	byte ptr [si], 0	;@16096
	je	@@94	;@16099
	mov	si, 3A24h	;@1609B
	mov	di, 36FFh	;@1609E
	call	@@8	;@160A1
	call	@@98	;@160A4
@@94:	mov	byte ptr ds:[3A24h], 0	;@160A7
	ret	;@160AC
@@95:	mov	si, 3A24h	;@160AD
	mov	di, 36FFh	;@160B0
	call	@@8	;@160B3
	mov	dx, 3A24h	;@160B6
	mov	di, 36A8h	;@160B9
	xor	cx, cx	;@160BC
	call	far ptr L119D6	;@160BE
	jb	@@97	;@160C3
@@96:	push	si	;@160C5
	mov	si, 36FFh	;@160C6
	call	L15359	;@160C9
	mov	di, si	;@160CC
	mov	si, 36BFh	;@160CE
	call	@@8	;@160D1
	call	@@98	;@160D4
	pop	si	;@160D7
	jb	@@97	;@160D8
	mov	di, 36A8h	;@160DA
	call	far ptr L119E7	;@160DD
	jae	@@96	;@160E2
@@97:	clc	;@160E4
	ret	;@160E5
@@98:	mov	byte ptr ds:[374Fh], 0	;@160E6
	mov	byte ptr ds:[379Fh], 0	;@160EB
	mov	byte ptr ds:[37EFh], 0	;@160F0
	call	@@59	;@160F5
	ret	;@160F8
@@99:	mov	si, 3E26h	;@160F9
	call	@@102	;@160FC
	mov	si, 3E26h	;@160FF
	mov	di, 374Fh	;@16102
	mov	bx, 36FFh	;@16105
	call	@@28	;@16108
	mov	si, 26h	;@1610B
	mov	di, 374Fh	;@1610E
	call	@@30	;@16111
	mov	si, 374Fh	;@16114
	call	@@105	;@16117
	jne	@@100	;@1611A
	mov	byte ptr ds:[374Fh], 0	;@1611C
@@100:	mov	si, 4226h	;@16121
	call	@@102	;@16124
	mov	si, 4226h	;@16127
	mov	di, 379Fh	;@1612A
	mov	bx, 36FFh	;@1612D
	call	@@28	;@16130
	mov	si, 43h	;@16133
	mov	di, 379Fh	;@16136
	call	@@30	;@16139
	mov	si, 379Fh	;@1613C
	call	@@105	;@1613F
	mov	si, 53DEh	;@16142
	call	@@102	;@16145
	mov	si, 53DEh	;@16148
	mov	di, 37EFh	;@1614B
	mov	bx, 36FFh	;@1614E
	call	@@28	;@16151
	mov	si, 48h	;@16154
	mov	di, 37EFh	;@16157
	call	@@30	;@1615A
	mov	si, 37EFh	;@1615D
	call	@@105	;@16160
	jne	@@101	;@16163
	mov	byte ptr ds:[37EFh], 0	;@16165
@@101:	ret	;@1616A
@@102:	push	si	;@1616B
	call	@@16	;@1616C
	pop	si	;@1616F
	jne	@@104	;@16170
	xor	al, al	;@16172
	call	L152E9	;@16174
	dec	si	;@16177
	lodsb	;@16178
	call	L15352	;@16179
	je	@@103	;@1617C
	mov	byte ptr [si], 5Ch	;@1617E
	inc	si	;@16181
@@103:	mov	byte ptr [si], 2Ah	;@16182
	inc	si	;@16185
	mov	byte ptr [si], 0	;@16186
@@104:	ret	;@16189
@@105:	push	si	;@1618A
	mov	di, 30h	;@1618B
@@106:	lodsb	;@1618E
	cmp	byte ptr [di], 0	;@1618F
	je	@@107	;@16192
	call	L152C6	;@16194
	cmp	al, byte ptr [di]	;@16197
	jne	@@108	;@16199
	inc	di	;@1619B
	jmp	@@106	;@1619C
@@107:	and	al, al	;@1619E
	je	@@108	;@161A0
	cmp	al, 2Eh	;@161A2
@@108:	pop	si	;@161A4
	ret	;@161A5
@@109:	mov	ax, word ptr ds:[36A0h]	;@161A6
	mov	word ptr ds:[36E4h], ax	;@161A9
	mov	ax, word ptr ds:[36A2h]	;@161AC
	mov	word ptr ds:[36E6h], ax	;@161AF
	xor	ax, ax	;@161B2
	mov	word ptr ds:[36E8h], ax	;@161B4
	mov	byte ptr ds:[36EEh], al	;@161B7
	mov	word ptr ds:[36EAh], 384Bh	;@161BA
	ret	;@161C0
	db	'TASM.CFG', 0	;@161C1
@@110:	push	ds	;@161CA
	push	es	;@161CB
	push	di	;@161CC
	push	cs	;@161CD
	push	ds	;@161CE
	pop	es	;@161CF
	pop	ds	;@161D0
	mov	di, 36FFh	;@161D1
	mov	si, 1261h	;@161D4
	call	L152E2	;@161D7
	pop	di	;@161DA
	pop	es	;@161DB
	pop	ds	;@161DC
	mov	byte ptr ds:[34h], 1	;@161DD
	call	@@113	;@161E2
	je	@@112	;@161E5
	mov	ax, word ptr ds:[36A6h]	;@161E7
	and	ax, ax	;@161EA
	je	@@111	;@161EC
	push	ds	;@161EE
	push	es	;@161EF
	push	di	;@161F0
	mov	si, word ptr ds:[36A4h]	;@161F1
	mov	ds, ax	;@161F5
	push	ss	;@161F7
	pop	es	;@161F8
	mov	di, 36FFh	;@161F9
	call	L152E2	;@161FC
	push	es	;@161FF
	pop	ds	;@16200
	mov	si, 36FFh	;@16201
	call	L15359	;@16204
	mov	di, si	;@16207
	push	cs	;@16209
	pop	ds	;@1620A
	mov	si, 1261h	;@1620B
	call	L152E2	;@1620E
	pop	di	;@16211
	pop	es	;@16212
	pop	ds	;@16213
	call	@@113	;@16214
	je	@@112	;@16217
@@111:	mov	byte ptr ds:[34h], 0	;@16219
@@112:	ret	;@1621E
@@113:	cmp	word ptr ds:[36EAh], 38ABh	;@1621F
	je	@@118	;@16225
	mov	dx, 36FFh	;@16227
	xor	al, al	;@1622A
	call	far ptr L11996	;@1622C
	jb	@@117	;@16231
	mov	si, word ptr ds:[36EAh]	;@16233
	add	word ptr ds:[36EAh], 6	;@16237
	mov	ax, word ptr ds:[36E8h]	;@1623C
	mov	word ptr [si], ax	;@1623F
	and	ax, ax	;@16241
	je	@@114	;@16243
	push	bx	;@16245
	mov	bx, ax	;@16246
	mov	al, 1	;@16248
	xor	cx, cx	;@1624A
	xor	dx, dx	;@1624C
	call	far ptr L119CA	;@1624E
	mov	bx, word ptr ds:[36ECh]	;@16253
	sub	bx, word ptr ds:[36E4h]	;@16257
	sub	ax, bx	;@1625B
	sbb	dx, 0	;@1625D
	mov	word ptr [si+2], ax	;@16260
	mov	word ptr [si+4], dx	;@16263
	pop	bx	;@16266
	jmp	short @@115	;@16267
@@114:	mov	ax, word ptr ds:[36E4h]	;@16269
	mov	word ptr [si+2], ax	;@1626C
	mov	ax, word ptr ds:[36E6h]	;@1626F
	mov	word ptr [si+4], ax	;@16272
@@115:	mov	word ptr ds:[36E8h], bx	;@16275
	mov	word ptr ds:[36E6h], ds	;@16279
	call	@@119	;@1627D
	xor	al, al	;@16280
@@116:	ret	;@16282
@@117:	cmp	byte ptr ds:[34h], 0	;@16283
	jne	@@116	;@16288
@@118:	push	ds	;@1628A
	pop	es	;@1628B
	mov	dx, 598h	;@1628C
	call	L15392	;@1628F
	mov	dx, 36FFh	;@16292
	call	L1538A	;@16295
	mov	dx, 0F0h	;@16298
	jmp	L14FBC	;@1629B
@@119:	mov	dx, 4628h	;@1629E
	mov	word ptr ds:[36E4h], dx	;@162A1
	mov	bx, word ptr ds:[36E8h]	;@162A5
	mov	cx, 200h	;@162A9
	mov	ax, ds	;@162AC
	call	far ptr L119B2	;@162AE
	jb	@@121	;@162B3
	add	dx, ax	;@162B5
	mov	word ptr ds:[36ECh], dx	;@162B7
	cmp	ax, cx	;@162BB
	je	@@120	;@162BD
	mov	bx, dx	;@162BF
	mov	byte ptr [bx], 0	;@162C1
@@120:	ret	;@162C4
@@121:	call	far ptr L119AC	;@162C5
	jmp	@@118	;@162CA
@@122:	mov	bx, word ptr ds:[36E8h]	;@162CC
	and	bx, bx	;@162D0
	je	@@124	;@162D2
	call	far ptr L119AC	;@162D4
	mov	byte ptr ds:[34h], 0	;@162D9
	mov	si, word ptr ds:[36EAh]	;@162DE
	sub	si, 6	;@162E2
	mov	word ptr ds:[36EAh], si	;@162E5
	mov	ax, word ptr [si]	;@162E9
	mov	word ptr ds:[36E8h], ax	;@162EB
	mov	dx, word ptr [si+2]	;@162EE
	mov	cx, word ptr [si+4]	;@162F1
	and	ax, ax	;@162F4
	je	@@123	;@162F6
	mov	bx, ax	;@162F8
	xor	al, al	;@162FA
	call	far ptr L119CA	;@162FC
	jmp	@@119	;@16301
@@123:	mov	word ptr ds:[36E4h], dx	;@16303
	mov	word ptr ds:[36E6h], cx	;@16307
	and	cx, cx	;@1630B
@@124:	ret	;@1630D
@@125:	push	di	;@1630E
	push	es	;@1630F
	push	ds	;@16310
	pop	es	;@16311
	mov	di, 36FFh	;@16312
@@126:	push	ds	;@16315
	lds	si, dword ptr ds:[36E4h]	;@16316
@@127:	cmp	si, 4828h	;@1631A
	je	@@128	;@1631E
	mov	al, byte ptr [si]	;@16320
	call	@@35	;@16322
	je	@@129	;@16325
	movsb	;@16327
	jmp	@@127	;@16328
@@128:	pop	ds	;@1632A
	call	@@119	;@1632B
	jmp	@@126	;@1632E
@@129:	xor	al, al	;@16330
	stosb	;@16332
	pop	ds	;@16333
	mov	word ptr ds:[36E4h], si	;@16334
	pop	es	;@16338
	pop	di	;@16339
	ret	;@1633A
@@130:	mov	al, byte ptr ds:[36EEh]	;@1633B
	and	al, al	;@1633E
	jne	@@132	;@16340
@@131:	push	ds	;@16342
	lds	si, dword ptr ds:[36E4h]	;@16343
	cmp	si, 4828h	;@16347
	je	@@135	;@1634B
	lodsb	;@1634D
	pop	ds	;@1634E
	or	al, al	;@1634F
	je	@@133	;@16351
	mov	word ptr ds:[36E4h], si	;@16353
	cmp	al, 40h	;@16357
	je	@@134	;@16359
	ret	;@1635B
@@132:	mov	byte ptr ds:[36EEh], 0	;@1635C
	ret	;@16361
@@133:	push	bx	;@16362
	push	cx	;@16363
	push	dx	;@16364
	call	@@122	;@16365
	pop	dx	;@16368
	pop	cx	;@16369
	pop	bx	;@1636A
	jne	@@130	;@1636B
	xor	al, al	;@1636D
	ret	;@1636F
@@134:	push	bx	;@16370
	push	cx	;@16371
	push	dx	;@16372
	call	@@125	;@16373
	call	@@113	;@16376
	pop	dx	;@16379
	pop	cx	;@1637A
	pop	bx	;@1637B
	jmp	@@130	;@1637C
@@135:	pop	ds	;@1637E
	push	bx	;@1637F
	push	cx	;@16380
	push	dx	;@16381
	call	@@119	;@16382
	pop	dx	;@16385
	pop	cx	;@16386
	pop	bx	;@16387
	jmp	@@131	;@16388
@@136:	mov	al, byte ptr ds:[36EEh]	;@1638A
	and	al, al	;@1638D
	je	@@137	;@1638F
	ret	;@16391
@@137:	call	@@130	;@16392
	mov	byte ptr ds:[36EEh], al	;@16395
	ret	;@16398
@@138:	mov	bx, word ptr cs:[si]	;@16399
	mov	cl, byte ptr cs:[si+2]	;@1639C
	xor	ch, ch	;@163A0
@@139:	add	si, 3	;@163A2
	cmp	al, byte ptr cs:[si]	;@163A5
	je	@@140	;@163A8
	loop	@@139	;@163AA
	jmp	bx	;@163AC
@@140:	mov	bx, word ptr cs:[si+1]	;@163AE
	clc	;@163B2
	jmp	bx	;@163B3
	db	56h, 0E8h, 0D9h, 0EFh, 5Ah, 0E8h, 0CDh, 0EFh, 0BAh, 0F0h, 0, 0E8h	;@163B5
	db	0C7h, 0EFh, 0F9h, 0C3h
@@141:	mov	al, byte ptr ds:[36D3h]	;@163C5
	mov	byte ptr ds:[36FAh], al	;@163C8
	push	es	;@163CB
	call	@@130	;@163CC
	call	@@6	;@163CF
	mov	byte ptr ds:[36FBh], al	;@163D2
	mov	si, 1487h	;@163D5
	call	@@138	;@163D8
	pop	es	;@163DB
	jb	@@142	;@163DC
	ret	;@163DE
@@142:	mov	byte ptr ds:[1Bh], 1	;@163DF
	jmp	L14FC4	;@163E4
	db	0D2h, 14h, 18h, 0, 0E0h, 14h, 61h, 0E8h, 14h, 62h, 0EEh, 14h, 63h	;@163E7
	db	0FDh, 14h, 64h, 3, 15h, 65h, 8, 15h, 68h, 0Eh, 15h, 69h, 19h, 15h
	db	6Ah, 1Ch, 15h, 6Bh, 21h, 15h, 6Ch, 68h, 15h, 6Dh, 8Ah, 15h, 6Eh
	db	0F8h, 15h, 6Fh, 0FEh, 15h, 70h, 15h, 16h, 71h, 21h, 16h, 72h, 26h
	db	16h, 73h, 2Eh, 16h, 74h, 35h, 16h, 76h, 3Ah, 16h, 77h, 3Ch, 16h
	db	78h, 3Fh, 16h, 7Ah, 44h, 16h, 3Fh, 0Eh, 15h, 0C6h, 6, 0FCh, 36h
	db	0, 0BAh, 17h, 5, 0BEh, 0FAh, 36h, 0E9h, 75h, 0FFh, 0BAh, 31h, 5
	db	0E8h, 4Ch, 0EFh, 0F9h, 0C3h, 0B8h, 10h, 0, 0E9h, 9Dh, 1, 0C7h
	db	6, 0F0h, 36h, 9Fh, 37h, 0E8h, 8Fh, 0F8h, 72h, 1, 0C3h, 0E9h, 7Ch
	db	1, 0B8h, 20h, 0, 0E9h, 88h, 1, 0B0h, 1, 0E9h, 0CDh, 1, 0B8h, 40h
	db	2, 0E9h, 7Dh, 1, 0E8h, 65h, 0EFh, 0BAh, 0B4h, 5, 0E8h, 1Bh, 0EFh
	db	0F9h, 0C3h, 0E9h, 80h, 1, 0B0h, 0, 0E9h, 0B4h, 1, 0E8h, 0B7h, 0FEh
	db	32h, 0E4h, 0A3h, 0FCh, 36h, 0C7h, 6, 0F0h, 36h, 9Fh, 37h, 8Bh
	db	0D8h, 0A0h, 0FCh, 36h, 0E8h, 46h, 0F6h, '<ht', 7, '<st', 12h, 0E9h
	db	40h, 1, 0E8h, 41h, 0F8h, 72h, 1Eh, 0C4h, 3Eh, 0DEh, 36h, 26h, 89h
	db	45h, 0Ah, 0F8h, 0C3h, 0E8h, 32h, 0F8h, 72h, 0Fh, 0BBh, 40h, 0
	db	0F7h, 0E3h, 0C4h, 3Eh, 0DEh, 36h, 26h, 89h, 45h, 8, 0F8h, 0C3h
	db	0E9h, 11h, 1, 0E8h, 0BFh, 0FEh, 0E8h, 0Fh, 0F6h, '<au', 0Dh, 0E8h
	db	66h, 0FEh, 0B8h, 0, 80h, 0E8h, 10h, 1, 8Ch, 0D8h, 8Eh, 0C0h, 0BEh
	db	5Fh, 0, 0BFh, 26h, 42h, 0E8h, 0, 0F6h, 0F8h, 0C3h, 0E8h, 9Dh, 0FEh
	db	0E8h, 0EDh, 0F5h, '<lt#<ut-<xt9<vtC', 0E8h, 0E3h, 0F7h, 73h, 3
	db	0B8h, 5, 0, 23h, 0C0h, 75h, 1, 40h, 0C4h, 3Eh, 0DEh, 36h, 26h
	db	89h, 45h, 4, 0F8h, 0C3h, 0E8h, 21h, 0FEh, 32h, 0E4h, 0A3h, 0FCh
	db	36h, 0B8h, 2, 0, 0E9h, 0C6h, 0, 0E8h, 13h, 0FEh, 32h, 0E4h, 0A3h
	db	0FCh, 36h, 0BBh, 0FCh, 0FFh, 33h, 0C0h, 0E9h, 0B9h, 0, 0E8h, 3
	db	0FEh, 32h, 0E4h, 0A3h, 0FCh, 36h, 0B8h, 1, 0, 0E9h, 0A8h, 0, 0E8h
	db	0F5h, 0FDh, 0E8h, 9Dh, 0F7h, 73h, 3, 0B8h, 20h, 0, 0C4h, 3Eh, 0DEh
	db	36h, 26h, 89h, 45h, 6, 0F8h, 0C3h, 0B8h, 80h, 0, 0E9h, 8Dh, 0
	db	0E8h, 29h, 0FEh, 0E8h, 79h, 0F5h, '<pt', 5, 0B8h, 0, 8, 0EBh, 7Eh
	db	0E8h, 0CBh, 0FDh, 0B8h, 0, 1, 0EBh, 76h, 0BBh, 4Fh, 0, 0BEh, 5Ch
	db	0, 0B9h, 3, 0, 0E9h, 6Fh, 1, 0B8h, 4, 0, 0EBh, 65h, 0BBh, 0FFh
	db	0FDh, 0B8h, 40h, 0, 0EBh, 60h, 0BBh, 0EFh, 0FFh, 33h, 0C0h, 0EBh
	db	59h, 0B8h, 0, 4, 0EBh, 51h, 0F8h, 0C3h, 0E9h, 0FBh, 0, 0B8h, 0
	db	10h, 0EBh, 47h, 0E8h, 0E3h, 0FDh, 0E8h, 4Ch, 0F6h, 75h, 5, 0B8h
	db	0, 20h, 0EBh, 3Ah, 0E8h, 87h, 0FDh, 32h, 0E4h, 0A3h, 0FCh, 36h
	db	0E8h, 21h, 0F5h, '<dt', 0Ah, '<it', 0Bh, '<zt', 0Ch, 0EBh, 18h
	db	0B8h, 8, 0, 0EBh, 1Ch, 0B8h, 8, 40h, 0EBh, 17h, 0B8h, 0, 40h, 0EBh
	db	12h, 0BAh, 56h, 5, 0BEh, 0FAh, 36h, 0E9h, 0D3h, 0FDh, 0BAh, 17h
	db	5, 0BEh, 0FAh, 36h, 0E9h, 0CAh, 0FDh, 0BBh, 0FFh, 0FFh, 0C4h, 3Eh
	db	0DEh, '6&!]', 2, 26h, 9, 45h, 2, 0F8h, 0C3h, 0C7h, 6, 0F0h, 36h
	db	9Fh, 37h, 0FFh, 36h, 34h, 0, 0E8h, 1Ah, 0F6h, 32h, 0C0h, 0BEh
	db	9Fh, 37h, 0E8h, 0D8h, 0ECh, 81h, 0FEh, 9Fh, 37h, 74h, 8, 8Ah, 44h
	db	0FFh, 0E8h, 35h, 0EDh, 74h, 4, 0C7h, 4, 5Ch, 0, 0BEh, 9Fh, '7X<'
	db	0, 75h, 5, 32h, 0C0h, 0E9h, 42h, 0F8h, 32h, 0C0h, 0E9h, 6Bh, 0F8h
	db	50h, 0C6h, 6, 9Fh, 37h, 0, 0C7h, 6, 0F0h, 36h, 9Fh, 37h, 0E8h
	db	0DFh, 0F5h, 58h, 0Ah, 0C0h, 74h, 3Ch, 80h, 3Eh, 9Fh, 37h, 0, 74h
	db	49h, 0E8h, 37h, 0FDh, '<=u%', 0E8h, 0E1h, 0FCh, 0BEh, 83h, 0, 0BFh
	db	9Fh, 37h, 0E8h, 90h, 0F4h, 32h, 0C0h, 8Bh, 0F7h, 0E8h, 7Fh, 0ECh
	db	89h, 36h, 0F0h, 36h, 0E8h, 0D6h, 0F5h, 0BEh, 8Ah, 0, 0BFh, 9Fh
	db	37h, 0E8h, 79h, 0F4h, 0EBh, 9, 0BEh, 8Ch, 0, 0BFh, 9Fh, 37h, 0E8h
	db	6Eh, 0F4h, 0BEh, 9Fh, 37h, 32h, 0C0h, 0E8h, 5Ch, 0ECh, 0C7h, 4
	db	0Dh, 0, 0BEh, 9Fh, 37h, 0B0h, 1, 0E9h, 0D9h, 0F7h, 0C3h, 0E8h
	db	0EDh, 0FCh, 0BEh, 4Dh, 0, '<-t"<+t', 1Bh, 0E8h, 4Bh, 0F5h, 74h
	db	9, 0E8h, 36h, 0F6h, 'r5#', 0C0h, 74h, 15h, 83h, 0C6h, 2, 8Bh, 0DEh
	db	0BEh, 59h, 0, 0B9h, 3, 0, 0EBh, 2Dh, 83h, 0C6h, 2, 56h, 0E8h, 71h
	db	0FCh, 5Eh, 0BFh, 54h, 0, 56h, 0E8h, 0B8h, 0FCh, 0E8h, 21h, 0F5h
	db	74h, 0Dh, 0E8h, 61h, 0FCh, 5Eh, 81h, 0FFh, 57h, 0, 74h, 6, 0AAh
	db	0EBh, 0EAh, 5Eh, 0EBh, 10h, 0BAh, 76h, 5, 0BEh, 0FAh, 36h, 0E9h
	db	0C5h, 0FCh, 0BFh, 54h, 0, 0F3h, 0A4h, 8Bh, 0F3h, 0B8h, 0Dh, 0
	db	0ABh, 0B0h, 1, 0E8h, 72h, 0F7h, 0F8h, 0C3h
SEG4	ends

SEG5	segment para public 'DATA'
	db	0, 0, 24h, 2Ah, 24h, 2Ah, 24h, 2Ah, 4, 12h, 5, 2, 54h, 55h, 52h, 42h	;@16710
	db	4Fh, 41h, 53h, 53h, 45h, 4Dh, 42h, 4Ch, 45h, 52h, 0, 0, 0, 0, 0, 0
	db	0, 2Eh, 41h, 53h, 4Dh, 0, 2Eh, 4Fh, 42h, 4Ah, 0, 2Eh, 45h, 58h, 45h, 0
	db	4Eh, 55h, 4Ch, 0, 0, 2Ah, 0, 2Eh, 4Fh, 42h, 4Ah, 0, 2Ah, 2Eh, 58h, 52h
	db	46h, 0, 0, 2Eh, 4Ch, 53h, 54h, 0, 2Eh, 58h, 52h, 46h, 0, 4Eh, 4Fh, 57h
	db	41h, 52h, 4Eh, 20h, 20h, 20h, 20h, 0, 0, 49h, 43h, 47h, 50h, 52h, 4Fh, 2Ah
	db	2Eh, 4Ch, 53h, 54h, 0, 54h, 75h, 72h, 62h, 6Fh, 20h, 41h, 73h, 73h, 65h, 6Dh
	db	62h, 6Ch, 65h, 72h, 20h, 20h, 56h, 65h, 72h, 73h, 69h, 6Fh, 6Eh, 20h, 32h, 2Eh
	db	35h, 31h, 0, 20h, 65h, 71h, 75h, 20h, 3Ch, 0, 3Eh, 0, 20h, 65h, 71h, 75h
	db	20h, 3Ch, 3Eh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	20h, 20h, 43h, 6Fh, 70h, 79h, 72h, 69h, 67h, 68h, 74h, 20h, 28h, 63h, 29h, 20h
	db	31h, 39h, 38h, 38h, 2Ch, 20h, 31h, 39h, 39h, 31h, 20h, 42h, 6Fh, 72h, 6Ch, 61h
	db	6Eh, 64h, 20h, 49h, 6Eh, 74h, 65h, 72h, 6Eh, 61h, 74h, 69h, 6Fh, 6Eh, 61h, 6Ch
	db	0Dh, 0Ah, 0, 2Ah, 2Ah, 46h, 61h, 74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 45h, 72h, 72h
	db	6Fh, 72h, 20h, 6Fh, 63h, 63h, 75h, 72h, 72h, 65h, 64h, 20h, 69h, 6Eh, 20h, 0
	db	0Dh, 0Ah, 0, 20h, 20h, 74h, 6Fh, 20h, 20h, 0, 41h, 73h, 73h, 65h, 6Dh, 62h
	db	6Ch, 69h, 6Eh, 67h, 20h, 66h, 69h, 6Ch, 65h, 3Ah, 20h, 20h, 20h, 0, 46h, 69h
	db	6Ch, 65h, 73h, 20h, 61h, 73h, 73h, 65h, 6Dh, 62h, 6Ch, 65h, 64h, 3Ah, 20h, 20h
	db	0, 20h, 20h, 20h, 46h, 61h, 74h, 61h, 6Ch, 20h, 65h, 72h, 72h, 6Fh, 72h, 73h
	db	3Ah, 20h, 20h, 0, 20h, 20h, 20h, 45h, 72h, 72h, 6Fh, 72h, 73h, 3Ah, 20h, 20h
	db	0, 20h, 20h, 20h, 57h, 61h, 72h, 6Eh, 69h, 6Eh, 67h, 73h, 3Ah, 20h, 20h, 0
	db	45h, 72h, 72h, 6Fh, 72h, 20h, 6Dh, 65h, 73h, 73h, 61h, 67h, 65h, 73h, 3Ah, 20h
	db	20h, 20h, 20h, 0, 0Dh, 0Ah, 57h, 61h, 72h, 6Eh, 69h, 6Eh, 67h, 20h, 6Dh, 65h
	db	73h, 73h, 61h, 67h, 65h, 73h, 3Ah, 20h, 20h, 0, 0Dh, 0Ah, 50h, 61h, 73h, 73h
	db	65h, 73h, 3Ah, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h, 0
	db	0Dh, 0Ah, 52h, 65h, 6Dh, 61h, 69h, 6Eh, 69h, 6Eh, 67h, 20h, 6Dh, 65h, 6Dh, 6Fh
	db	72h, 79h, 3Ah, 20h, 20h, 0, 20h, 62h, 79h, 74h, 65h, 73h, 0Dh, 0Ah, 0, 6Bh
	db	0Dh, 0Ah, 0, 4Eh, 6Fh, 6Eh, 65h, 0, 3Ah, 20h, 20h, 0, 0D8h, 1, 20h, 3
	db	0FDh, 1, 1Dh, 2, 1Eh, 2, 1Fh, 2, 62h, 2, 88h, 2, 0D8h, 1, 0ACh, 2
	db	0CDh, 2, 0CEh, 2, 0ECh, 2, 0F1h, 2, 2Ah, 2Ah, 46h, 61h, 74h, 61h, 6Ch, 2Ah
	db	2Ah, 20h, 49h, 6Eh, 74h, 65h, 72h, 6Eh, 61h, 6Ch, 20h, 75h, 6Eh, 64h, 65h, 66h
	db	69h, 6Eh, 65h, 64h, 20h, 65h, 72h, 72h, 6Fh, 72h, 0Dh, 0Ah, 0, 2Ah, 2Ah, 46h
	db	61h, 74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 4Fh, 75h, 74h, 20h, 6Fh, 66h, 20h, 73h, 74h
	db	72h, 69h, 6Eh, 67h, 20h, 73h, 70h, 61h, 63h, 65h, 0Dh, 0Ah, 0, 0, 0, 2Ah
	db	2Ah, 46h, 61h, 74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 46h, 69h, 6Ch, 65h, 20h, 77h, 61h
	db	73h, 20h, 63h, 68h, 61h, 6Eh, 67h, 65h, 64h, 20h, 6Fh, 72h, 20h, 64h, 65h, 6Ch
	db	65h, 74h, 65h, 64h, 20h, 77h, 68h, 69h, 6Ch, 65h, 20h, 61h, 73h, 73h, 65h, 6Dh
	db	62h, 6Ch, 79h, 20h, 69h, 6Eh, 20h, 70h, 72h, 6Fh, 67h, 72h, 65h, 73h, 73h, 0Dh
	db	0Ah, 0, 2Ah, 2Ah, 46h, 61h, 74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 45h, 72h, 72h, 6Fh
	db	72h, 20h, 77h, 72h, 69h, 74h, 69h, 6Eh, 67h, 20h, 6Fh, 62h, 6Ah, 65h, 63h, 74h
	db	20h, 66h, 69h, 6Ch, 65h, 0Dh, 0Ah, 0, 2Ah, 2Ah, 46h, 61h, 74h, 61h, 6Ch, 2Ah
	db	2Ah, 20h, 45h, 72h, 72h, 6Fh, 72h, 20h, 77h, 72h, 69h, 74h, 69h, 6Eh, 67h, 20h
	db	6Ch, 69h, 73h, 74h, 20h, 66h, 69h, 6Ch, 65h, 0Dh, 0Ah, 0, 2Ah, 2Ah, 46h, 61h
	db	74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 54h, 6Fh, 6Fh, 20h, 6Dh, 61h, 6Eh, 79h, 20h, 65h
	db	72h, 72h, 6Fh, 72h, 73h, 20h, 66h, 6Fh, 75h, 6Eh, 64h, 0Dh, 0Ah, 0, 2Ah, 2Ah
	db	46h, 61h, 74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 4Fh, 75h, 74h, 20h, 6Fh, 66h, 20h, 68h
	db	61h, 73h, 68h, 20h, 73h, 70h, 61h, 63h, 65h, 0Dh, 0Ah, 0, 5Eh, 43h, 0Dh, 0Ah
	db	0, 2Ah, 2Ah, 46h, 61h, 74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 45h, 72h, 72h, 6Fh, 72h
	db	20h, 77h, 72h, 69h, 74h, 69h, 6Eh, 67h, 20h, 63h, 72h, 6Fh, 73h, 73h, 2Dh, 72h
	db	65h, 66h, 65h, 72h, 65h, 6Eh, 63h, 65h, 20h, 66h, 69h, 6Ch, 65h, 0Dh, 0Ah, 0
	db	2Ah, 2Ah, 46h, 61h, 74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 4Fh, 75h, 74h, 20h, 6Fh, 66h
	db	20h, 6Dh, 65h, 6Dh, 6Fh, 72h, 79h, 0Dh, 0Ah, 0, 20h, 2Ch, 3Bh, 3Dh, 2Bh, 2Fh
	db	2Bh, 3Bh, 5Bh, 5Dh, 7Ch, 3Ch, 3Eh, 3Dh, 2Ch, 0, 3Eh, 39h, 0, 1, 3Ch, 2
	db	52h, 39h, 0, 1, 60h, 0, 5Ch, 39h, 0, 1, 60h, 0, 48h, 39h, 0, 1
	db	50h, 2, 0FFh, 0FFh, 0Ch, 39h, 6, 0, 1, 1, 16h, 39h, 6, 0, 5, 1
	db	20h, 39h, 8, 0, 0, 2, 2Ah, 39h, 0, 14h, 15h, 2, 34h, 39h, 80h, 2
	db	0, 0, 70h, 39h, 0, 1, 60h, 0, 0FFh, 0FFh, 2Ah, 39h, 0, 14h, 15h, 2
	db	34h, 39h, 80h, 2, 60h, 2, 66h, 39h, 0, 4, 0, 1, 0FFh, 0FFh, 34h, 39h
	db	80h, 2, 60h, 2, 0FFh, 0FFh, 0, 1, 72h, 2, 73h, 6Fh, 2, 73h, 72h, 1
	db	73h, 1, 72h, 1, 72h, 0, 0, 1, 65h, 2, 73h, 6Fh, 2, 73h, 65h, 1
	db	73h, 1, 65h, 1, 65h, 0, 34h, 39h, 4Ch, 2, 20h, 11h, 2Ah, 39h, 90h, 1
	db	28h, 1Eh, 66h, 39h, 0FFh, 0FFh, 5, 14h, 34h, 39h, 0FAh, 0, 20h, 14h, 2Ah, 39h
	db	0FFh, 0FFh, 4, 20h, 2, 0, 98h, 15h, 21h, 11h, 3, 0, 0A3h, 15h, 53h, 12h
	db	0Dh, 0, 0B7h, 15h, 91h, 12h, 6, 0, 0CBh, 15h, 24h, 11h, 74h, 4, 0ADh, 5
	db	0B5h, 5, 79h, 4, 81h, 4, 0BDh, 5, 91h, 4, 9Ah, 4, 0A3h, 4, 91h, 4
	db	91h, 4, 0ACh, 4, 0B5h, 4, 0, 0, 0E9h, 14h, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 29h, 15h, 19h, 15h, 0, 0, 0, 0, 4Fh, 15h
	db	0, 0, 0B8h, 14h, 8Ch, 14h, 0, 0, 0A5h, 5, 0ADh, 5, 0B5h, 5, 0BDh, 5
	db	0C5h, 5, 0CDh, 5, 0D5h, 5, 0DDh, 5, 0E5h, 5, 0EDh, 5, 0F5h, 5, 50h, 61h
	db	67h, 65h, 20h, 0, 28h, 4Dh, 6Fh, 72h, 65h, 20h, 45h, 72h, 72h, 6Fh, 72h, 73h
	db	2Eh, 2Eh, 2Eh, 29h, 0, 31h, 36h, 20h, 20h, 0, 33h, 32h, 20h, 20h, 0, 20h
	db	20h, 20h, 20h, 0, 20h, 41h, 54h, 20h, 0, 50h, 61h, 72h, 61h, 20h, 20h, 20h
	db	0, 50h, 61h, 67h, 65h, 20h, 20h, 20h, 0, 56h, 69h, 72h, 74h, 20h, 20h, 20h
	db	0, 6Eh, 6Fh, 6Eh, 65h, 20h, 20h, 20h, 20h, 0, 4Dh, 65h, 6Dh, 6Fh, 72h, 79h
	db	20h, 20h, 0, 50h, 75h, 62h, 6Ch, 69h, 63h, 20h, 20h, 0, 53h, 74h, 61h, 63h
	db	6Bh, 20h, 20h, 20h, 0, 43h, 6Fh, 6Dh, 6Dh, 6Fh, 6Eh, 20h, 20h, 0, 47h, 72h
	db	6Fh, 75h, 70h, 0, 53h, 79h, 6Dh, 62h, 6Fh, 6Ch, 20h, 4Eh, 61h, 6Dh, 65h, 0
	db	4Dh, 61h, 63h, 72h, 6Fh, 20h, 4Eh, 61h, 6Dh, 65h, 0, 47h, 72h, 6Fh, 75h, 70h
	db	73h, 20h, 26h, 20h, 53h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 73h, 0, 53h, 74h, 72h
	db	75h, 63h, 74h, 75h, 72h, 65h, 20h, 4Eh, 61h, 6Dh, 65h, 0, 52h, 65h, 63h, 6Fh
	db	72h, 64h, 20h, 4Eh, 61h, 6Dh, 65h, 0, 54h, 79h, 70h, 65h, 20h, 20h, 20h, 56h
	db	61h, 6Ch, 75h, 65h, 0, 54h, 79h, 70h, 65h, 20h, 20h, 4Fh, 66h, 66h, 73h, 65h
	db	74h, 0, 57h, 69h, 64h, 74h, 68h, 20h, 53h, 68h, 69h, 66h, 74h, 0, 42h, 69h
	db	74h, 20h, 53h, 69h, 7Ah, 65h, 20h, 41h, 6Ch, 69h, 67h, 6Eh, 20h, 20h, 43h, 6Fh
	db	6Dh, 62h, 69h, 6Eh, 65h, 20h, 43h, 6Ch, 61h, 73h, 73h, 0, 43h, 72h, 65h, 66h
	db	20h, 28h, 64h, 65h, 66h, 69h, 6Eh, 65h, 64h, 20h, 61h, 74h, 20h, 23h, 29h, 0
	db	53h, 79h, 6Dh, 62h, 6Fh, 6Ch, 20h, 54h, 61h, 62h, 6Ch, 65h, 0, 45h, 72h, 72h
	db	6Fh, 72h, 20h, 53h, 75h, 6Dh, 6Dh, 61h, 72h, 79h, 0, 2Dh, 2Dh, 2Dh, 2Dh, 0
	db	2Dh, 2Dh, 2Dh, 2Dh, 20h, 45h, 78h, 74h, 65h, 72h, 6Eh, 20h, 0, 54h, 65h, 78h
	db	74h, 20h, 20h, 20h, 0, 41h, 6Ch, 69h, 61h, 73h, 20h, 20h, 0, 41h, 62h, 73h
	db	20h, 20h, 20h, 20h, 0, 4Eh, 6Fh, 54h, 79h, 70h, 65h, 20h, 0, 42h, 79h, 74h
	db	65h, 20h, 20h, 20h, 0, 57h, 6Fh, 72h, 64h, 20h, 20h, 20h, 0, 44h, 77h, 6Fh
	db	72h, 64h, 20h, 20h, 0, 51h, 77h, 6Fh, 72h, 64h, 20h, 20h, 0, 50h, 77h, 6Fh
	db	72h, 64h, 20h, 20h, 0, 54h, 62h, 79h, 74h, 65h, 20h, 20h, 0, 53h, 68h, 6Fh
	db	72h, 74h, 20h, 20h, 0, 4Eh, 65h, 61h, 72h, 20h, 20h, 20h, 0, 46h, 61h, 72h
	db	20h, 20h, 20h, 20h, 0, 53h, 74h, 72h, 75h, 63h, 74h, 20h, 0, 4Eh, 75h, 6Dh
	db	62h, 65h, 72h, 20h, 0, 0, 0, 1, 2, 4, 8, 6, 0Ah, 1, 2, 4
	db	1, 0, 8, 0, 0Ah, 0, 0Ch, 0, 16h, 0, 18h, 0, 17h, 0, 19h, 0
	db	19h, 0, 1Ah, 0, 1, 0, 8, 0, 0Ah, 0, 0Ch, 0, 16h, 0, 18h, 0
	db	17h, 0, 1Bh, 0, 1Bh, 0, 1Ch, 0, 1, 0, 8, 0, 0Ah, 0, 0Ch, 0
	db	16h, 0, 18h, 0, 17h, 0, 1Dh, 0, 1Dh, 0, 1Eh, 0, 0, 0CAh, 9Ah, 3Bh
	db	0, 0E1h, 0F5h, 5, 80h, 96h, 98h, 0, 40h, 42h, 0Fh, 0, 0A0h, 86h, 1, 0
	db	10h, 27h, 0, 0, 0E8h, 3, 0, 0, 64h, 0, 0, 0, 0Ah, 0, 0, 0
	db	1, 0, 0, 0, 0, 0, 0, 10h, 0, 0, 0, 1, 0, 0, 10h, 0
	db	0, 0, 1, 0, 0, 10h, 0, 0, 0, 1, 0, 0, 10h, 0, 0, 0
	db	1, 0, 0, 0, 0, 0, 0, 40h, 0, 0, 0, 8, 0, 0, 0, 1
	db	0, 0, 20h, 0, 0, 0, 4, 0, 0, 80h, 0, 0, 0, 10h, 0, 0
	db	0, 2, 0, 0, 40h, 0, 0, 0, 8, 0, 0, 0, 1, 0, 0, 0
	db	0, 0, 0, 80h, 0, 0, 0, 40h, 0, 0, 0, 20h, 0, 0, 0, 10h
	db	0, 0, 0, 8, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 1
	db	0, 0, 80h, 0, 0, 0, 40h, 0, 0, 0, 20h, 0, 0, 0, 10h, 0
	db	0, 0, 8, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 1, 0
	db	0, 80h, 0, 0, 0, 40h, 0, 0, 0, 20h, 0, 0, 0, 10h, 0, 0
	db	0, 8, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0
	db	80h, 0, 0, 0, 40h, 0, 0, 0, 20h, 0, 0, 0, 10h, 0, 0, 0
	db	8, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 8, 40h, 8, 80h, 80h, 80h, 40h, 8, 8, 8, 8, 8, 8, 4, 8
	db	10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h, 8, 1, 8, 8, 8, 80h
	db	80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	db	80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h, 8, 0, 8, 8, 80h
	db	8, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h
	db	0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 0A0h, 8, 8, 8, 8, 8
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 96h, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 0A6h, 29h, 51h, 2Ah, 0A6h, 29h, 0C3h, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh, 51h, 2Ah
	db	0A6h, 29h, 0A6h, 29h, 0A6h, 29h, 0A6h, 29h, 0A6h, 29h, 0A6h, 29h, 0CFh, 29h, 0A6h, 29h
	db	79h, 2Ah, 79h, 2Ah, 79h, 2Ah, 79h, 2Ah, 79h, 2Ah, 79h, 2Ah, 79h, 2Ah, 79h, 2Ah
	db	79h, 2Ah, 79h, 2Ah, 0A6h, 29h, 96h, 29h, 0A6h, 29h, 0A6h, 29h, 0A6h, 29h, 0C3h, 2Fh
	db	0C3h, 2Fh, 27h, 2Ch, 8Dh, 2Ch, 0F4h, 2Ch, 85h, 2Dh, 58h, 2Eh, 0C3h, 2Fh, 0C3h, 2Fh
	db	0C3h, 2Fh, 0C3h, 2Fh, 80h, 2Eh, 0C3h, 2Fh, 0C3h, 2Fh, 0B3h, 2Eh, 0C3h, 2Fh, 0C3h, 2Fh
	db	0ECh, 2Eh, 0C3h, 2Fh, 0C3h, 2Fh, 55h, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh
	db	0C3h, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh, 0A6h, 29h, 0BAh, 29h, 0A6h, 29h, 0A6h, 29h, 0C3h, 2Fh
	db	0A6h, 29h, 1Fh, 2Ch, 85h, 2Ch, 0ECh, 2Ch, 7Dh, 2Dh, 50h, 2Eh, 0C3h, 2Fh, 0C3h, 2Fh
	db	0C3h, 2Fh, 0C3h, 2Fh, 78h, 2Eh, 0C3h, 2Fh, 0C3h, 2Fh, 0ABh, 2Eh, 0C3h, 2Fh, 0C3h, 2Fh
	db	0E4h, 2Eh, 0C3h, 2Fh, 0C3h, 2Fh, 4Dh, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh
	db	0C3h, 2Fh, 0C3h, 2Fh, 0C3h, 2Fh, 0A6h, 29h, 0A6h, 29h, 0A6h, 29h, 0A6h, 29h, 0A6h, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h, 8Bh, 29h
	db	4Eh, 55h, 4Ch, 0, 43h, 6Fh, 6Dh, 6Dh, 61h, 6Eh, 64h, 20h, 6Ch, 69h, 6Eh, 65h
	db	0, 0, 0, 0, 0, 0, 0, 0, 0EFh, 19h, 0FAh, 19h, 0, 0, 0, 0
	db	5, 1Ah, 10h, 1Ah, 19h, 1Ah, 22h, 1Ah, 28h, 1Ah, 33h, 1Ah, 3Dh, 1Ah, 49h, 1Ah
	db	90h, 0Bh, 0A4h, 0Bh, 0BBh, 0Bh, 0C0h, 0Bh, 0CDh, 0Bh, 0D6h, 0Bh, 0E9h, 0Bh, 2, 0Ch
	db	1Eh, 0Ch, 23h, 0Ch, 39h, 0Ch, 48h, 0Ch, 50h, 0Ch, 68h, 0Ch, 7Fh, 0Ch, 45h, 14h
	db	89h, 0Ch, 98h, 0Ch, 0B2h, 0Ch, 0EFh, 0Ch, 5Bh, 14h, 0Ah, 0Dh, 18h, 0Dh, 96h, 0Fh
	db	45h, 0Dh, 6Fh, 0Dh, 7Ah, 0Dh, 93h, 0Dh, 0B0h, 0Dh, 0C2h, 0Dh, 0D8h, 0Dh, 0EBh, 0Dh
	db	0F8h, 0Dh, 15h, 0Eh, 25h, 0Eh, 3Eh, 0Eh, 13h, 0Fh, 25h, 0Fh, 40h, 0Fh, 6Eh, 14h
	db	63h, 0Fh, 80h, 0Fh, 51h, 0Dh, 0B7h, 0Fh, 0C8h, 0Fh, 0DCh, 0Fh, 0F0h, 0Fh, 0FFh, 0Fh
	db	20h, 10h, 4Ch, 10h, 7Ch, 10h, 9Dh, 10h, 0B8h, 10h, 0E1h, 10h, 0EEh, 10h, 0FDh, 10h
	db	16h, 11h, 27h, 11h, 36h, 11h, 3Eh, 11h, 53h, 11h, 50h, 0Eh, 61h, 0Eh, 74h, 0Eh
	db	87h, 0Eh, 0A1h, 0Eh, 0BCh, 0Eh, 6Dh, 11h, 7Eh, 11h, 8Fh, 11h, 9Ah, 11h, 0B3h, 11h
	db	0C4h, 11h, 0D4h, 11h, 6, 12h, 1Dh, 12h, 0CBh, 0Eh, 37h, 12h, 5Bh, 12h, 76h, 12h
	db	0A5h, 12h, 0BDh, 12h, 9Fh, 14h, 0E6h, 0Eh, 0E4h, 12h, 0FDh, 12h, 13h, 13h, 2Fh, 13h
	db	0F7h, 0Eh, 46h, 13h, 6Ah, 13h, 83h, 13h, 96h, 13h, 0BEh, 13h, 0E2h, 13h, 0FCh, 13h
	db	27h, 14h, 0C3h, 0Ch, 0D5h, 0Ch, 0B7h, 14h, 0D0h, 14h, 0EAh, 14h, 0FEh, 14h, 18h, 15h
	db	3Ch, 15h, 65h, 15h, 81h, 15h, 9Fh, 15h, 0CDh, 15h, 0DFh, 15h, 0FCh, 15h, 16h, 16h
	db	2Bh, 16h, 49h, 16h, 71h, 16h, 7Eh, 16h, 0E1h, 0Ch, 99h, 16h, 0B0h, 16h, 0BCh, 16h
	db	0D5h, 16h, 0FBh, 16h, 18h, 17h, 25h, 17h, 35h, 17h, 45h, 17h, 70h, 17h, 8Fh, 17h
	db	0B7h, 17h, 0E5h, 17h, 1, 18h, 12h, 18h, 22h, 18h, 41h, 18h, 65h, 18h, 87h, 18h
	db	99h, 18h, 0BBh, 18h, 0ECh, 18h, 12h, 19h, 49h, 19h, 6Fh, 19h, 0A4h, 19h, 0CDh, 19h
	db	2, 0Ah, 72h, 69h, 67h, 68h, 74h, 20h, 70h, 61h, 72h, 65h, 6Eh, 74h, 68h, 65h
	db	73h, 69h, 73h, 0, 2, 0Ah, 72h, 69h, 67h, 68h, 74h, 20h, 73h, 71h, 75h, 61h
	db	72h, 65h, 20h, 62h, 72h, 61h, 63h, 6Bh, 65h, 74h, 0, 2, 0Ah, 2, 0Eh, 0
	db	2, 0Ah, 70h, 6Fh, 69h, 6Eh, 74h, 65h, 72h, 20h, 2, 0Eh, 0, 2, 8, 6Eh
	db	75h, 6Dh, 62h, 65h, 72h, 0, 2, 0Ah, 6Ch, 65h, 66h, 74h, 20h, 70h, 61h, 72h
	db	65h, 6Eh, 74h, 68h, 65h, 73h, 69h, 73h, 0, 45h, 78h, 74h, 72h, 61h, 20h, 63h
	db	68h, 61h, 72h, 61h, 63h, 74h, 65h, 72h, 73h, 20h, 6Fh, 6Eh, 20h, 6Ch, 69h, 6Eh
	db	65h, 0, 2, 9, 6Fh, 72h, 20h, 69h, 6Ch, 6Ch, 65h, 67h, 61h, 6Ch, 20h, 74h
	db	79h, 70h, 65h, 20h, 73h, 70h, 65h, 63h, 69h, 66h, 69h, 65h, 72h, 0, 2, 8
	db	2, 0Dh, 0, 2, 0Ah, 72h, 69h, 67h, 68h, 74h, 20h, 61h, 6Eh, 67h, 6Ch, 65h
	db	20h, 62h, 72h, 61h, 63h, 6Bh, 65h, 74h, 0, 2, 0Ah, 61h, 64h, 64h, 72h, 65h
	db	73h, 73h, 20h, 6Fh, 72h, 2, 0Ch, 0, 2, 0Ah, 63h, 6Fh, 6Ch, 6Fh, 6Eh, 0
	db	2, 0Ah, 73h, 74h, 72h, 75h, 63h, 74h, 75h, 72h, 65h, 20h, 6Dh, 65h, 6Dh, 62h
	db	65h, 72h, 20h, 6Eh, 61h, 6Dh, 65h, 0, 54h, 6Fh, 6Fh, 20h, 66h, 65h, 77h, 20h
	db	6Fh, 70h, 65h, 72h, 61h, 6Eh, 64h, 73h, 20h, 74h, 6Fh, 20h, 2, 0Dh, 0, 2
	db	9, 43h, 4Fh, 4Dh, 4Dh, 20h, 49h, 44h, 0, 2, 9, 74h, 65h, 72h, 6Dh, 20h
	db	69h, 6Eh, 20h, 6Ch, 69h, 73h, 74h, 0, 2, 0Ah, 66h, 69h, 6Ch, 65h, 20h, 6Eh
	db	61h, 6Dh, 65h, 20h, 61h, 66h, 74h, 65h, 72h, 20h, 49h, 4Eh, 43h, 4Ch, 55h, 44h
	db	45h, 0, 2, 0Ah, 73h, 74h, 61h, 63h, 6Bh, 20h, 61h, 72h, 67h, 75h, 6Dh, 65h
	db	6Eh, 74h, 0, 55h, 6Eh, 6Bh, 6Eh, 6Fh, 77h, 6Eh, 20h, 63h, 68h, 61h, 72h, 61h
	db	63h, 74h, 65h, 72h, 0, 2, 9, 65h, 6Eh, 64h, 20h, 71h, 75h, 6Fh, 74h, 65h
	db	0, 2, 9, 6Dh, 6Fh, 64h, 75h, 6Ch, 65h, 20h, 6Eh, 61h, 6Dh, 65h, 0, 43h
	db	61h, 6Eh, 27h, 74h, 20h, 6Dh, 61h, 6Bh, 65h, 20h, 76h, 61h, 72h, 69h, 61h, 62h
	db	6Ch, 65h, 20h, 70h, 75h, 62h, 6Ch, 69h, 63h, 0, 2, 0Bh, 73h, 63h, 61h, 6Ch
	db	61h, 72h, 20h, 74h, 79h, 70h, 65h, 0, 41h, 72h, 67h, 75h, 6Dh, 65h, 6Eh, 74h
	db	20h, 74h, 6Fh, 20h, 6Fh, 70h, 65h, 72h, 61h, 74h, 69h, 6Fh, 6Eh, 20h, 6Fh, 72h
	db	20h, 2, 0Dh, 20h, 68h, 61h, 73h, 20h, 69h, 6Ch, 6Ch, 65h, 67h, 61h, 6Ch, 20h
	db	73h, 69h, 7Ah, 65h, 0, 2, 8, 69h, 6Dh, 6Dh, 65h, 64h, 69h, 61h, 74h, 65h
	db	0, 53h, 79h, 6Dh, 62h, 6Fh, 6Ch, 20h, 61h, 6Ch, 72h, 65h, 61h, 64h, 79h, 20h
	db	64h, 69h, 66h, 66h, 65h, 72h, 65h, 6Eh, 74h, 20h, 6Bh, 69h, 6Eh, 64h, 0, 2
	db	8, 75h, 73h, 65h, 20h, 6Fh, 66h, 2, 0Ch, 0, 43h, 61h, 6Eh, 27h, 74h, 20h
	db	63h, 6Fh, 6Eh, 76h, 65h, 72h, 74h, 20h, 74h, 6Fh, 20h, 70h, 6Fh, 69h, 6Eh, 74h
	db	65h, 72h, 0, 54h, 6Fh, 6Fh, 20h, 6Dh, 61h, 6Eh, 79h, 2, 0Ch, 20h, 6Dh, 75h
	db	6Ch, 74h, 69h, 70h, 6Ch, 69h, 65h, 72h, 73h, 20h, 69h, 6Eh, 20h, 2, 0Eh, 0
	db	54h, 6Fh, 6Fh, 20h, 6Dh, 61h, 6Eh, 79h, 2, 0Ch, 73h, 20h, 69h, 6Eh, 20h, 2
	db	0Eh, 0, 2, 8, 72h, 65h, 67h, 69h, 73h, 74h, 65h, 72h, 20h, 6Dh, 75h, 6Ch
	db	74h, 69h, 70h, 6Ch, 69h, 65h, 72h, 0, 2, 8, 6Dh, 65h, 6Dh, 6Fh, 72h, 79h
	db	20h, 72h, 65h, 66h, 65h, 72h, 65h, 6Eh, 63h, 65h, 0, 2, 8, 6Fh, 76h, 65h
	db	72h, 72h, 69h, 64h, 65h, 2, 0Ch, 0, 41h, 72h, 67h, 75h, 6Dh, 65h, 6Eh, 74h
	db	20h, 6Eh, 65h, 65h, 64h, 73h, 20h, 74h, 79h, 70h, 65h, 20h, 6Fh, 76h, 65h, 72h
	db	72h, 69h, 64h, 65h, 0, 2, 8, 69h, 6Eh, 64h, 65h, 78h, 69h, 6Eh, 67h, 20h
	db	6Dh, 6Fh, 64h, 65h, 0, 49h, 6Eh, 76h, 61h, 6Ch, 69h, 64h, 20h, 6Fh, 70h, 65h
	db	72h, 61h, 6Eh, 64h, 28h, 73h, 29h, 20h, 74h, 6Fh, 20h, 2, 0Dh, 0, 2, 8
	db	75h, 73h, 65h, 20h, 6Fh, 66h, 20h, 63h, 6Fh, 6Eh, 73h, 74h, 61h, 6Eh, 74h, 0
	db	2, 0Ah, 72h, 65h, 67h, 69h, 73h, 74h, 65h, 72h, 20h, 69h, 6Eh, 20h, 2, 0Eh
	db	0, 2, 8, 75h, 73h, 65h, 20h, 6Fh, 66h, 20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh
	db	74h, 2, 0Ch, 0, 43h, 6Fh, 6Eh, 73h, 74h, 61h, 6Eh, 74h, 20h, 74h, 6Fh, 6Fh
	db	20h, 6Ch, 61h, 72h, 67h, 65h, 0, 50h, 6Fh, 69h, 6Eh, 74h, 65h, 72h, 20h, 2
	db	0Eh, 20h, 6Eh, 65h, 65h, 64h, 73h, 20h, 62h, 72h, 61h, 63h, 6Bh, 65h, 74h, 73h
	db	0, 4Fh, 70h, 65h, 72h, 61h, 6Eh, 64h, 20h, 74h, 79h, 70h, 65h, 73h, 20h, 64h
	db	6Fh, 20h, 6Eh, 6Fh, 74h, 20h, 6Dh, 61h, 74h, 63h, 68h, 0, 2, 0Bh, 70h, 6Fh
	db	69h, 6Eh, 74h, 65h, 72h, 20h, 74h, 79h, 70h, 65h, 0, 49h, 44h, 20h, 6Eh, 6Fh
	db	74h, 20h, 6Dh, 65h, 6Dh, 62h, 65h, 72h, 20h, 6Fh, 66h, 20h, 73h, 74h, 72h, 75h
	db	63h, 74h, 75h, 72h, 65h, 0, 2, 8, 6Fh, 72h, 69h, 67h, 69h, 6Eh, 20h, 61h
	db	64h, 64h, 72h, 65h, 73h, 73h, 0, 53h, 79h, 6Dh, 62h, 6Fh, 6Ch, 20h, 68h, 61h
	db	73h, 20h, 6Eh, 6Fh, 20h, 77h, 69h, 64h, 74h, 68h, 20h, 6Fh, 72h, 20h, 6Dh, 61h
	db	73h, 6Bh, 0, 43h, 61h, 6Eh, 27h, 74h, 20h, 6Ch, 6Fh, 63h, 61h, 74h, 65h, 20h
	db	66h, 69h, 6Ch, 65h, 0, 4Ch, 69h, 6Eh, 65h, 20h, 74h, 6Fh, 6Fh, 20h, 6Ch, 6Fh
	db	6Eh, 67h, 20h, 2Dh, 20h, 74h, 72h, 75h, 6Eh, 63h, 61h, 74h, 69h, 6Eh, 67h, 0
	db	55h, 6Eh, 65h, 78h, 70h, 65h, 63h, 74h, 65h, 64h, 20h, 65h, 6Eh, 64h, 20h, 6Fh
	db	66h, 20h, 66h, 69h, 6Ch, 65h, 20h, 65h, 6Eh, 63h, 6Fh, 75h, 6Eh, 74h, 65h, 72h
	db	65h, 64h, 0, 43h, 61h, 6Eh, 27h, 74h, 20h, 75h, 73h, 65h, 20h, 74h, 68h, 69h
	db	73h, 20h, 6Fh, 75h, 74h, 73h, 69h, 64h, 65h, 20h, 6Dh, 61h, 63h, 72h, 6Fh, 0
	db	2, 8, 6Ch, 6Fh, 63h, 61h, 6Ch, 20h, 73h, 79h, 6Dh, 62h, 6Fh, 6Ch, 20h, 70h
	db	72h, 65h, 66h, 69h, 78h, 0, 53h, 79h, 6Dh, 62h, 6Fh, 6Ch, 20h, 61h, 6Ch, 72h
	db	65h, 61h, 64h, 79h, 20h, 64h, 65h, 66h, 69h, 6Eh, 65h, 64h, 20h, 65h, 6Ch, 73h
	db	65h, 77h, 68h, 65h, 72h, 65h, 0, 55h, 6Eh, 64h, 65h, 66h, 69h, 6Eh, 65h, 64h
	db	20h, 73h, 79h, 6Dh, 62h, 6Fh, 6Ch, 0, 41h, 72h, 69h, 74h, 68h, 6Dh, 65h, 74h
	db	69h, 63h, 20h, 6Fh, 76h, 65h, 72h, 66h, 6Ch, 6Fh, 77h, 0, 2, 8, 66h, 6Fh
	db	72h, 77h, 61h, 72h, 64h, 20h, 72h, 65h, 66h, 65h, 72h, 65h, 6Eh, 63h, 65h, 0
	db	55h, 6Eh, 6Dh, 61h, 74h, 63h, 68h, 65h, 64h, 20h, 45h, 4Eh, 44h, 53h, 0, 42h
	db	61h, 64h, 20h, 6Bh, 65h, 79h, 77h, 6Fh, 72h, 64h, 20h, 69h, 6Eh, 20h, 53h, 45h
	db	47h, 4Dh, 45h, 4Eh, 54h, 20h, 73h, 74h, 61h, 74h, 65h, 6Dh, 65h, 6Eh, 74h, 0
	db	43h, 6Fh, 64h, 65h, 20h, 6Fh, 72h, 20h, 64h, 61h, 74h, 61h, 20h, 65h, 6Dh, 69h
	db	73h, 73h, 69h, 6Fh, 6Eh, 20h, 74h, 6Fh, 20h, 75h, 6Eh, 64h, 65h, 63h, 6Ch, 61h
	db	72h, 65h, 64h, 20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 0, 43h, 61h, 6Eh, 27h
	db	74h, 20h, 61h, 64h, 64h, 72h, 65h, 73h, 73h, 20h, 77h, 69h, 74h, 68h, 20h, 63h
	db	75h, 72h, 72h, 65h, 6Eh, 74h, 6Ch, 79h, 20h, 41h, 53h, 53h, 55h, 4Dh, 45h, 64h
	db	20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 2, 0Ch, 73h, 0, 46h, 6Fh, 72h, 77h
	db	61h, 72h, 64h, 20h, 72h, 65h, 66h, 65h, 72h, 65h, 6Eh, 63h, 65h, 20h, 6Eh, 65h
	db	65h, 64h, 73h, 20h, 6Fh, 76h, 65h, 72h, 72h, 69h, 64h, 65h, 0, 52h, 65h, 6Ch
	db	61h, 74h, 69h, 76h, 65h, 20h, 6Ah, 75h, 6Dh, 70h, 20h, 6Fh, 75h, 74h, 20h, 6Fh
	db	66h, 20h, 72h, 61h, 6Eh, 67h, 65h, 0, 52h, 65h, 63h, 75h, 72h, 73h, 69h, 76h
	db	65h, 20h, 64h, 65h, 66h, 69h, 6Eh, 69h, 74h, 69h, 6Fh, 6Eh, 20h, 6Eh, 6Fh, 74h
	db	20h, 61h, 6Ch, 6Ch, 6Fh, 77h, 65h, 64h, 20h, 66h, 6Fh, 72h, 20h, 45h, 51h, 55h
	db	0, 4Fh, 70h, 65h, 6Eh, 20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 0, 4Fh, 70h
	db	65h, 6Eh, 20h, 70h, 72h, 6Fh, 63h, 65h, 64h, 75h, 72h, 65h, 0, 45h, 4Ch, 53h
	db	45h, 20h, 6Fh, 72h, 20h, 45h, 4Eh, 44h, 49h, 46h, 20h, 77h, 69h, 74h, 68h, 6Fh
	db	75h, 74h, 20h, 49h, 46h, 0, 4Fh, 70h, 65h, 6Eh, 20h, 63h, 6Fh, 6Eh, 64h, 69h
	db	74h, 69h, 6Fh, 6Eh, 61h, 6Ch, 0, 55h, 6Eh, 6Dh, 61h, 74h, 63h, 68h, 65h, 64h
	db	20h, 45h, 4Eh, 44h, 50h, 0, 2, 8, 72h, 61h, 64h, 69h, 78h, 0, 55h, 73h
	db	65h, 72h, 20h, 67h, 65h, 6Eh, 65h, 72h, 61h, 74h, 65h, 64h, 20h, 65h, 72h, 72h
	db	6Fh, 72h, 0, 43h, 61h, 6Eh, 27h, 74h, 20h, 6Fh, 76h, 65h, 72h, 72h, 69h, 64h
	db	65h, 20h, 45h, 53h, 20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 0, 2, 8, 6Dh
	db	61h, 63h, 72h, 6Fh, 20h, 61h, 72h, 67h, 75h, 6Dh, 65h, 6Eh, 74h, 0, 2, 8
	db	6Ch, 6Fh, 63h, 61h, 6Ch, 20h, 61h, 72h, 67h, 75h, 6Dh, 65h, 6Eh, 74h, 0, 2
	db	9, 6Dh, 61h, 63h, 72h, 6Fh, 20h, 49h, 44h, 0, 44h, 75h, 70h, 6Ch, 69h, 63h
	db	61h, 74h, 65h, 20h, 64h, 75h, 6Dh, 6Dh, 79h, 20h, 61h, 72h, 67h, 75h, 6Dh, 65h
	db	6Eh, 74h, 0, 2, 9, 64h, 75h, 6Dh, 6Dh, 79h, 20h, 61h, 72h, 67h, 75h, 6Dh
	db	65h, 6Eh, 74h, 0, 2, 9, 61h, 72h, 67h, 75h, 6Dh, 65h, 6Eh, 74h, 20h, 6Ch
	db	69h, 73h, 74h, 0, 44h, 69h, 72h, 65h, 63h, 74h, 69h, 76h, 65h, 20h, 6Eh, 6Fh
	db	74h, 20h, 61h, 6Ch, 6Ch, 6Fh, 77h, 65h, 64h, 20h, 69h, 6Eh, 73h, 69h, 64h, 65h
	db	20h, 73h, 74h, 72h, 75h, 63h, 74h, 75h, 72h, 65h, 20h, 64h, 65h, 66h, 69h, 6Eh
	db	69h, 74h, 69h, 6Fh, 6Eh, 0, 44h, 65h, 63h, 6Ch, 61h, 72h, 61h, 74h, 69h, 6Fh
	db	6Eh, 20h, 6Eh, 65h, 65h, 64h, 73h, 20h, 6Eh, 61h, 6Dh, 65h, 0, 4Fh, 70h, 65h
	db	6Eh, 20h, 73h, 74h, 72h, 75h, 63h, 74h, 75h, 72h, 65h, 20h, 64h, 65h, 66h, 69h
	db	6Eh, 69h, 74h, 69h, 6Fh, 6Eh, 0, 2, 0Ah, 61h, 6Eh, 67h, 6Ch, 65h, 20h, 62h
	db	72h, 61h, 63h, 6Bh, 65h, 74h, 73h, 20h, 66h, 6Fh, 72h, 20h, 73h, 74h, 72h, 75h
	db	63h, 74h, 75h, 72h, 65h, 20h, 66h, 69h, 6Ch, 6Ch, 0, 43h, 61h, 6Eh, 27h, 74h
	db	20h, 75h, 73h, 65h, 20h, 6Dh, 61h, 63h, 72h, 6Fh, 20h, 6Eh, 61h, 6Dh, 65h, 20h
	db	69h, 6Eh, 20h, 2, 0Eh, 0, 4Fh, 6Eh, 65h, 20h, 6Eh, 6Fh, 6Eh, 2Dh, 6Eh, 75h
	db	6Ch, 6Ch, 20h, 66h, 69h, 65h, 6Ch, 64h, 20h, 61h, 6Ch, 6Ch, 6Fh, 77h, 65h, 64h
	db	20h, 70h, 65h, 72h, 20h, 75h, 6Eh, 69h, 6Fh, 6Eh, 20h, 65h, 78h, 70h, 61h, 6Eh
	db	73h, 69h, 6Fh, 6Eh, 0, 2, 8, 6Fh, 76h, 65h, 72h, 72h, 69h, 64h, 65h, 20h
	db	69h, 6Eh, 20h, 73h, 74h, 72h, 75h, 63h, 74h, 75h, 72h, 65h, 0, 53h, 65h, 67h
	db	6Dh, 65h, 6Eh, 74h, 20h, 61h, 74h, 74h, 72h, 69h, 62h, 75h, 74h, 65h, 73h, 20h
	db	69h, 6Ch, 6Ch, 65h, 67h, 61h, 6Ch, 6Ch, 79h, 20h, 72h, 65h, 64h, 65h, 66h, 69h
	db	6Eh, 65h, 64h, 0, 43h, 53h, 20h, 6Eh, 6Fh, 74h, 20h, 63h, 6Fh, 72h, 72h, 65h
	db	63h, 74h, 6Ch, 79h, 20h, 61h, 73h, 73h, 75h, 6Dh, 65h, 64h, 0, 43h, 61h, 6Eh
	db	27h, 74h, 20h, 65h, 6Dh, 75h, 6Ch, 61h, 74h, 65h, 20h, 38h, 30h, 38h, 37h, 20h
	db	2, 0Dh, 0, 54h, 6Fh, 6Fh, 20h, 6Dh, 61h, 6Eh, 79h, 20h, 65h, 72h, 72h, 6Fh
	db	72h, 73h, 20h, 6Fh, 72h, 20h, 77h, 61h, 72h, 6Eh, 69h, 6Eh, 67h, 73h, 0, 52h
	db	65h, 63h, 6Fh, 72h, 64h, 20h, 66h, 69h, 65h, 6Ch, 64h, 20h, 74h, 6Fh, 6Fh, 20h
	db	6Ch, 61h, 72h, 67h, 65h, 0, 53h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 20h, 61h, 6Ch
	db	69h, 67h, 6Eh, 6Dh, 65h, 6Eh, 74h, 20h, 6Eh, 6Fh, 74h, 20h, 73h, 74h, 72h, 69h
	db	63h, 74h, 20h, 65h, 6Eh, 6Fh, 75h, 67h, 68h, 0, 2, 9, 61h, 72h, 67h, 75h
	db	6Dh, 65h, 6Eh, 74h, 20h, 73h, 69h, 7Ah, 65h, 20h, 76h, 61h, 72h, 69h, 61h, 62h
	db	6Ch, 65h, 0, 49h, 6Eh, 76h, 61h, 6Ch, 69h, 64h, 20h, 6Dh, 6Fh, 64h, 65h, 6Ch
	db	20h, 74h, 79h, 70h, 65h, 0, 50h, 61h, 73h, 73h, 2Dh, 64h, 65h, 70h, 65h, 6Eh
	db	64h, 65h, 6Eh, 74h, 20h, 63h, 6Fh, 6Eh, 73h, 74h, 72h, 75h, 63h, 74h, 69h, 6Fh
	db	6Eh, 20h, 65h, 6Eh, 63h, 6Fh, 75h, 6Eh, 74h, 65h, 72h, 65h, 64h, 0, 43h, 53h
	db	20h, 75h, 6Eh, 72h, 65h, 61h, 63h, 68h, 61h, 62h, 6Ch, 65h, 20h, 66h, 72h, 6Fh
	db	6Dh, 20h, 63h, 75h, 72h, 72h, 65h, 6Eh, 74h, 20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh
	db	74h, 0, 4Ch, 6Fh, 63h, 61h, 74h, 69h, 6Fh, 6Eh, 20h, 63h, 6Fh, 75h, 6Eh, 74h
	db	65h, 72h, 20h, 6Fh, 76h, 65h, 72h, 66h, 6Ch, 6Fh, 77h, 0, 49h, 6Eh, 73h, 74h
	db	72h, 75h, 63h, 74h, 69h, 6Fh, 6Eh, 20h, 63h, 61h, 6Eh, 20h, 62h, 65h, 20h, 63h
	db	6Fh, 6Dh, 70h, 61h, 63h, 74h, 65h, 64h, 20h, 77h, 69h, 74h, 68h, 20h, 6Fh, 76h
	db	65h, 72h, 72h, 69h, 64h, 65h, 0, 43h, 53h, 20h, 6Fh, 76h, 65h, 72h, 72h, 69h
	db	64h, 65h, 20h, 69h, 6Eh, 20h, 70h, 72h, 6Fh, 74h, 65h, 63h, 74h, 65h, 64h, 20h
	db	6Dh, 6Fh, 64h, 65h, 0, 50h, 6Fh, 73h, 69h, 74h, 69h, 76h, 65h, 20h, 63h, 6Fh
	db	75h, 6Eh, 74h, 20h, 6Eh, 65h, 65h, 64h, 65h, 64h, 0, 56h, 61h, 6Ch, 75h, 65h
	db	20h, 6Fh, 75h, 74h, 20h, 6Fh, 66h, 20h, 72h, 61h, 6Eh, 67h, 65h, 0, 53h, 79h
	db	6Dh, 62h, 6Fh, 6Ch, 20h, 69h, 73h, 20h, 6Eh, 6Fh, 74h, 20h, 61h, 20h, 73h, 65h
	db	67h, 6Dh, 65h, 6Eh, 74h, 20h, 6Fh, 72h, 20h, 61h, 6Ch, 72h, 65h, 61h, 64h, 79h
	db	20h, 70h, 61h, 72h, 74h, 20h, 6Fh, 66h, 20h, 67h, 72h, 6Fh, 75h, 70h, 0, 54h
	db	6Fh, 6Fh, 20h, 6Dh, 61h, 6Eh, 79h, 20h, 69h, 6Eh, 69h, 74h, 69h, 61h, 6Ch, 20h
	db	76h, 61h, 6Ch, 75h, 65h, 73h, 0, 41h, 53h, 53h, 55h, 4Dh, 45h, 20h, 6Dh, 75h
	db	73h, 74h, 20h, 62h, 65h, 20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 2, 0Ch, 0
	db	52h, 65h, 67h, 69h, 73h, 74h, 65h, 72h, 20h, 6Dh, 75h, 73h, 74h, 20h, 62h, 65h
	db	20h, 41h, 4Ch, 20h, 6Fh, 72h, 20h, 41h, 58h, 0, 52h, 65h, 67h, 69h, 73h, 74h
	db	65h, 72h, 20h, 6Dh, 75h, 73h, 74h, 20h, 62h, 65h, 20h, 44h, 58h, 0, 52h, 6Fh
	db	74h, 61h, 74h, 65h, 20h, 63h, 6Fh, 75h, 6Eh, 74h, 20h, 6Fh, 75h, 74h, 20h, 6Fh
	db	66h, 20h, 72h, 61h, 6Eh, 67h, 65h, 0, 52h, 6Fh, 74h, 61h, 74h, 65h, 20h, 63h
	db	6Fh, 75h, 6Eh, 74h, 20h, 6Dh, 75h, 73h, 74h, 20h, 62h, 65h, 20h, 63h, 6Fh, 6Eh
	db	73h, 74h, 61h, 6Eh, 74h, 20h, 6Fh, 72h, 20h, 43h, 4Ch, 0, 2, 8, 2, 0Dh
	db	20h, 66h, 6Fh, 72h, 20h, 63h, 75h, 72h, 72h, 65h, 6Eh, 74h, 6Ch, 79h, 20h, 73h
	db	65h, 6Ch, 65h, 63h, 74h, 65h, 64h, 20h, 70h, 72h, 6Fh, 63h, 65h, 73h, 73h, 6Fh
	db	72h, 28h, 73h, 29h, 0, 2, 0Bh, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 20h, 6Fh
	db	72h, 20h, 67h, 72h, 6Fh, 75h, 70h, 20h, 71h, 75h, 61h, 6Eh, 74h, 69h, 74h, 79h
	db	0, 43h, 61h, 6Eh, 27h, 74h, 20h, 61h, 64h, 64h, 20h, 72h, 65h, 6Ch, 61h, 74h
	db	69h, 76h, 65h, 20h, 71h, 75h, 61h, 6Eh, 74h, 69h, 74h, 69h, 65h, 73h, 0, 43h
	db	61h, 6Eh, 27h, 74h, 20h, 73h, 75h, 62h, 74h, 72h, 61h, 63h, 74h, 20h, 64h, 69h
	db	73h, 73h, 69h, 6Dh, 69h, 6Ch, 61h, 72h, 20h, 72h, 65h, 6Ch, 61h, 74h, 69h, 76h
	db	65h, 20h, 71h, 75h, 61h, 6Eh, 74h, 69h, 74h, 69h, 65h, 73h, 0, 2, 0Bh, 6Fh
	db	66h, 66h, 73h, 65h, 74h, 20h, 71h, 75h, 61h, 6Eh, 74h, 69h, 74h, 79h, 0, 2
	db	0Bh, 6Fh, 66h, 66h, 73h, 65h, 74h, 20h, 6Fh, 72h, 20h, 70h, 6Fh, 69h, 6Eh, 74h
	db	65h, 72h, 20h, 71h, 75h, 61h, 6Eh, 74h, 69h, 74h, 79h, 0, 52h, 65h, 6Ch, 61h
	db	74h, 69h, 76h, 65h, 20h, 71h, 75h, 61h, 6Eh, 74h, 69h, 74h, 79h, 20h, 69h, 6Ch
	db	6Ch, 65h, 67h, 61h, 6Ch, 0, 4Eh, 61h, 6Dh, 65h, 20h, 6Dh, 75h, 73h, 74h, 20h
	db	63h, 6Fh, 6Dh, 65h, 20h, 66h, 69h, 72h, 73h, 74h, 0, 4Dh, 6Fh, 64h, 65h, 6Ch
	db	20h, 6Dh, 75h, 73h, 74h, 20h, 62h, 65h, 20h, 73h, 70h, 65h, 63h, 69h, 66h, 69h
	db	65h, 64h, 20h, 66h, 69h, 72h, 73h, 74h, 0, 4Eh, 6Fh, 74h, 20h, 65h, 78h, 70h
	db	65h, 63h, 74h, 69h, 6Eh, 67h, 20h, 67h, 72h, 6Fh, 75h, 70h, 20h, 6Fh, 72h, 20h
	db	73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 20h, 71h, 75h, 61h, 6Eh, 74h, 69h, 74h, 79h
	db	0, 2, 8, 77h, 61h, 72h, 6Eh, 69h, 6Eh, 67h, 20h, 49h, 44h, 0, 41h, 73h
	db	73h, 75h, 6Dh, 69h, 6Eh, 67h, 20h, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 20h, 69h
	db	73h, 20h, 33h, 32h, 2Dh, 62h, 69h, 74h, 0, 45h, 78h, 70h, 72h, 65h, 73h, 73h
	db	69h, 6Fh, 6Eh, 20h, 74h, 6Fh, 6Fh, 20h, 63h, 6Fh, 6Dh, 70h, 6Ch, 65h, 78h, 0
	db	44h, 69h, 76h, 69h, 64h, 65h, 20h, 62h, 79h, 20h, 30h, 0, 2, 9, 6Fh, 72h
	db	20h, 69h, 6Ch, 6Ch, 65h, 67h, 61h, 6Ch, 20h, 6Ch, 61h, 6Eh, 67h, 75h, 61h, 67h
	db	65h, 20h, 49h, 44h, 0, 4Dh, 61h, 78h, 69h, 6Dh, 75h, 6Dh, 20h, 6Dh, 61h, 63h
	db	72h, 6Fh, 20h, 65h, 78h, 70h, 61h, 6Eh, 73h, 69h, 6Fh, 6Eh, 20h, 73h, 69h, 7Ah
	db	65h, 20h, 65h, 78h, 63h, 65h, 65h, 64h, 65h, 64h, 0, 52h, 65h, 73h, 65h, 72h
	db	76h, 65h, 64h, 20h, 77h, 6Fh, 72h, 64h, 20h, 75h, 73h, 65h, 64h, 20h, 61h, 73h
	db	20h, 73h, 79h, 6Dh, 62h, 6Fh, 6Ch, 0, 2, 9, 74h, 65h, 78h, 74h, 20h, 6Dh
	db	61h, 63h, 72h, 6Fh, 0, 53h, 74h, 72h, 69h, 6Eh, 67h, 20h, 74h, 6Fh, 6Fh, 20h
	db	6Ch, 6Fh, 6Eh, 67h, 0, 2, 0Ah, 71h, 75h, 6Fh, 74h, 65h, 64h, 20h, 73h, 74h
	db	72h, 69h, 6Eh, 67h, 0, 4Ch, 61h, 62h, 65h, 6Ch, 73h, 20h, 63h, 61h, 6Eh, 27h
	db	74h, 20h, 73h, 74h, 61h, 72h, 74h, 20h, 77h, 69h, 74h, 68h, 20h, 6Eh, 75h, 6Dh
	db	65h, 72h, 69h, 63h, 20h, 63h, 68h, 61h, 72h, 61h, 63h, 74h, 65h, 72h, 73h, 0
	db	55h, 53h, 45h, 33h, 32h, 20h, 6Eh, 6Fh, 74h, 20h, 61h, 6Ch, 6Ch, 6Fh, 77h, 65h
	db	64h, 20h, 77h, 69h, 74h, 68h, 6Fh, 75h, 74h, 20h, 2Eh, 33h, 38h, 36h, 0, 44h
	db	69h, 72h, 65h, 63h, 74h, 69h, 76h, 65h, 20h, 69h, 67h, 6Eh, 6Fh, 72h, 65h, 64h
	db	20h, 69h, 6Eh, 20h, 54h, 75h, 72h, 62h, 6Fh, 20h, 50h, 61h, 73h, 63h, 61h, 6Ch
	db	20h, 6Dh, 6Fh, 64h, 65h, 6Ch, 0, 5Bh, 43h, 6Fh, 6Eh, 73h, 74h, 61h, 6Eh, 74h
	db	5Dh, 20h, 61h, 73h, 73h, 75h, 6Dh, 65h, 64h, 20h, 74h, 6Fh, 20h, 6Dh, 65h, 61h
	db	6Eh, 20h, 69h, 6Dh, 6Dh, 65h, 64h, 69h, 61h, 74h, 65h, 20h, 63h, 6Fh, 6Eh, 73h
	db	74h, 61h, 6Eh, 74h, 0, 53h, 65h, 67h, 6Dh, 65h, 6Eh, 74h, 20h, 6Eh, 61h, 6Dh
	db	65h, 20h, 69h, 73h, 20h, 73h, 75h, 70h, 65h, 72h, 66h, 6Ch, 75h, 6Fh, 75h, 73h
	db	0, 54h, 6Fh, 6Fh, 20h, 6Dh, 61h, 6Eh, 79h, 20h, 55h, 53h, 45h, 53h, 2, 0Ch
	db	73h, 0, 2, 9, 61h, 72h, 67h, 75h, 6Dh, 65h, 6Eh, 74h, 20h, 6Fh, 72h, 20h
	db	3Ch, 0, 2, 9, 6Fh, 70h, 65h, 72h, 61h, 6Eh, 64h, 20h, 2Dh, 20h, 74h, 72h
	db	61h, 69h, 6Ch, 69h, 6Eh, 67h, 20h, 3Fh, 20h, 61h, 73h, 73h, 75h, 6Dh, 65h, 64h
	db	0, 55h, 53h, 45h, 53h, 20h, 68h, 61h, 73h, 20h, 6Eh, 6Fh, 20h, 65h, 66h, 66h
	db	65h, 63h, 74h, 20h, 77h, 69h, 74h, 68h, 6Fh, 75h, 74h, 20h, 6Ch, 61h, 6Eh, 67h
	db	75h, 61h, 67h, 65h, 0, 4Fh, 6Eh, 6Ch, 79h, 20h, 6Fh, 6Eh, 65h, 20h, 73h, 74h
	db	61h, 72h, 74h, 75h, 70h, 20h, 73h, 65h, 71h, 75h, 65h, 6Eh, 63h, 65h, 20h, 61h
	db	6Ch, 6Ch, 6Fh, 77h, 65h, 64h, 0, 2, 8, 73h, 65h, 67h, 6Dh, 65h, 6Eh, 74h
	db	20h, 61h, 64h, 64h, 72h, 65h, 73h, 73h, 0, 4Eh, 65h, 61h, 72h, 20h, 6Ah, 75h
	db	6Dh, 70h, 20h, 6Fh, 72h, 20h, 63h, 61h, 6Ch, 6Ch, 20h, 74h, 6Fh, 20h, 64h, 69h
	db	66h, 66h, 65h, 72h, 65h, 6Eh, 74h, 20h, 43h, 53h, 0, 54h, 65h, 78h, 74h, 20h
	db	6Dh, 61h, 63h, 72h, 6Fh, 20h, 65h, 78h, 70h, 61h, 6Eh, 73h, 69h, 6Fh, 6Eh, 20h
	db	65h, 78h, 63h, 65h, 65h, 64h, 73h, 20h, 6Dh, 61h, 78h, 69h, 6Dh, 75h, 6Dh, 20h
	db	6Ch, 69h, 6Eh, 65h, 20h, 6Ch, 65h, 6Eh, 67h, 74h, 68h, 0, 47h, 6Ch, 6Fh, 62h
	db	61h, 6Ch, 20h, 74h, 79h, 70h, 65h, 20h, 64h, 6Fh, 65h, 73h, 6Eh, 27h, 74h, 20h
	db	6Dh, 61h, 74h, 63h, 68h, 20h, 73h, 79h, 6Dh, 62h, 6Fh, 6Ch, 20h, 74h, 79h, 70h
	db	65h, 0, 4Dh, 6Fh, 64h, 75h, 6Ch, 65h, 20h, 69h, 73h, 20h, 70h, 61h, 73h, 73h
	db	20h, 64h, 65h, 70h, 65h, 6Eh, 64h, 65h, 6Eh, 74h, 20h, 2Dh, 20h, 63h, 6Fh, 6Dh
	db	70h, 61h, 74h, 69h, 62h, 69h, 6Ch, 69h, 74h, 79h, 20h, 70h, 61h, 73h, 73h, 20h
	db	77h, 61h, 73h, 20h, 64h, 6Fh, 6Eh, 65h, 0, 53h, 6Dh, 61h, 72h, 74h, 20h, 63h
	db	6Fh, 64h, 65h, 20h, 67h, 65h, 6Eh, 65h, 72h, 61h, 74h, 69h, 6Fh, 6Eh, 20h, 6Dh
	db	75h, 73h, 74h, 20h, 62h, 65h, 20h, 65h, 6Eh, 61h, 62h, 6Ch, 65h, 64h, 0, 41h
	db	75h, 78h, 69h, 6Ch, 69h, 61h, 72h, 79h, 20h, 70h, 72h, 6Fh, 63h, 65h, 73h, 73h
	db	6Fh, 72h, 20h, 69h, 6Eh, 63h, 6Fh, 6Dh, 70h, 61h, 74h, 69h, 62h, 6Ch, 65h, 20h
	db	77h, 69h, 74h, 68h, 20h, 6Dh, 61h, 69h, 6Eh, 20h, 70h, 72h, 6Fh, 63h, 65h, 73h
	db	73h, 6Fh, 72h, 0, 53h, 79h, 6Dh, 62h, 6Fh, 6Ch, 20h, 72h, 65h, 64h, 65h, 66h
	db	69h, 6Eh, 65h, 64h, 20h, 6Fh, 72h, 20h, 6Dh, 6Fh, 76h, 65h, 64h, 20h, 62h, 65h
	db	74h, 77h, 65h, 65h, 6Eh, 20h, 70h, 61h, 73h, 73h, 65h, 73h, 0, 33h, 32h, 2Dh
	db	62h, 69h, 74h, 20h, 76h, 61h, 6Ch, 75h, 65h, 20h, 74h, 72h, 75h, 6Eh, 63h, 61h
	db	74h, 65h, 64h, 20h, 74h, 6Fh, 20h, 31h, 36h, 20h, 62h, 69h, 74h, 73h, 0, 2Ah
	db	2Ah, 45h, 72h, 72h, 6Fh, 72h, 2Ah, 2Ah, 20h, 0, 2Ah, 57h, 61h, 72h, 6Eh, 69h
	db	6Eh, 67h, 2Ah, 20h, 0, 2Ah, 2Ah, 46h, 61h, 74h, 61h, 6Ch, 2Ah, 2Ah, 20h, 0
	db	49h, 6Ch, 6Ch, 65h, 67h, 61h, 6Ch, 20h, 0, 4Dh, 69h, 73h, 73h, 69h, 6Eh, 67h
	db	20h, 0, 4Eh, 65h, 65h, 64h, 20h, 0, 45h, 78h, 70h, 65h, 63h, 74h, 69h, 6Eh
	db	67h, 20h, 0, 20h, 72h, 65h, 67h, 69h, 73h, 74h, 65h, 72h, 0, 69h, 6Eh, 73h
	db	74h, 72h, 75h, 63h, 74h, 69h, 6Fh, 6Eh, 0, 65h, 78h, 70h, 72h, 65h, 73h, 73h
	db	69h, 6Fh, 6Eh, 0, 2, 4, 0, 2, 3, 0, 2, 7, 0, 3Ah, 20h, 0
	db	20h, 62h, 79h, 20h, 0, 68h, 20h, 62h, 79h, 74h, 65h, 73h, 0, 0, 2Fh, 3Bh
	db	47h, 3Bh, 8Eh, 3Ch, 0B9h, 3Ch, 56h, 3Bh, 0C8h, 3Bh, 0E7h, 3Bh, 40h, 3Ch, 6Bh, 3Ch
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2, 2, 0AAh, 1Ah
	db	4, 0, 0AEh, 1Ah, 5, 0, 0B3h, 1Ah, 5, 0, 0B8h, 1Ah, 7, 0, 0BFh, 1Ah
	db	7, 0, 0C6h, 1Ah, 7, 0, 0CDh, 1Ah, 7, 0, 0, 6, 0, 2Ah, 0, 0
	db	0, 24h, 0, 0, 0, 0, 24h, 1, 0, 0, 0, 23h, 0, 0, 0, 0
	db	0, 0, 23h, 0, 4, 0, 0, 0, 0, 23h, 0, 1, 0, 0, 0, 0
	db	23h, 0, 5, 0, 0, 0, 44h, 0, 48h, 2, 4Ch, 0, 48h, 0, 40h, 0
	db	50h, 0, 0, 0, 0, 0, 4, 0, 8, 2, 0Ch, 0, 8, 0, 0, 0
	db	10h, 0, 0, 0, 0, 0, 54h, 0, 48h, 2, 4Ch, 0, 48h, 0, 40h, 0
	db	50h, 0, 0, 0, 0, 0, 4, 0, 8, 2, 0Ch, 0, 8, 0, 0, 0
	db	10h, 0, 0, 0, 0, 0, 45h, 0, 48h, 4, 4Dh, 0, 48h, 0, 40h, 0
	db	50h, 0, 0, 0, 0, 0, 5, 0, 8, 4, 0Dh, 0, 8, 0, 0, 0
	db	10h, 0, 0, 0, 0, 0, 55h, 0, 48h, 4, 4Dh, 0, 48h, 0, 40h, 0
	db	50h, 0, 0, 0, 0, 0, 5, 0, 8, 4, 0Dh, 0, 8, 0, 0, 0
	db	10h, 0, 0, 0, 0, 0, 54h, 0, 48h, 4, 58h, 0, 48h, 0, 40h, 0
	db	50h, 0, 0, 0, 0, 0, 14h, 0, 8, 4, 18h, 0, 8, 0, 0, 0
	db	10h, 0, 0, 0, 0, 0, 54h, 0, 48h, 4, 58h, 0, 48h, 0, 40h, 0
	db	50h, 0, 0, 0, 0, 0, 14h, 0, 8, 4, 18h, 0, 8, 0, 0, 0
	db	10h, 0, 0, 0, 0CDh, 0CCh, 0CCh, 0CCh, 0CCh, 0CCh, 0CCh, 0CCh, 0FCh, 3Fh, 0Bh, 0D7h
	db	0A3h, 70h, 3Dh, 0Ah, 0D7h, 0A3h, 0FAh, 3Fh, 2Ch, 65h, 19h, 0E2h, 58h, 17h, 0B7h, 0D1h
	db	0F5h, 3Fh, 0FDh, 0CEh, 61h, 84h, 11h, 77h, 0CCh, 0ABh, 0ECh, 3Fh, 5Ch, 0E1h, 4Dh, 0C4h
	db	0BEh, 94h, 95h, 0E6h, 0D9h, 3Fh, 0BAh, 94h, 39h, 45h, 0ADh, 1Eh, 0B1h, 0CFh, 0B4h, 3Fh
	db	0A5h, 0E9h, 39h, 0A5h, 27h, 0EAh, 7Fh, 0A8h, 6Ah, 3Fh, 0A1h, 0E4h, 0BCh, 64h, 7Ch, 46h
	db	0D0h, 0DDh, 0D5h, 3Eh, 3Ah, 19h, 7Ah, 63h, 25h, 43h, 31h, 0C0h, 0ACh, 3Dh, 1Ch, 0D2h
	db	23h, 0DBh, 32h, 0EEh, 49h, 90h, 5Ah, 3Bh, 0BEh, 0C0h, 57h, 0DAh, 0A5h, 82h, 0A6h, 0A2h
	db	0B5h, 36h, 0E4h, 2Dh, 36h, 34h, 4Fh, 53h, 0AEh, 0CEh, 6Bh, 2Dh, 0DEh, 9Fh, 0CEh, 0D2h
	db	0C8h, 4, 0DDh, 0A6h, 0D8h, 1Ah, 0, 0, 0, 0, 0, 0, 0, 0A0h, 1, 40h
	db	0, 0, 0, 0, 0, 0, 0, 0C8h, 3, 40h, 0, 0, 0, 0, 0, 0
	db	40h, 9Ch, 8, 40h, 0, 0, 0, 0, 0, 20h, 0BCh, 0BEh, 11h, 40h, 0, 0
	db	0, 4, 0BFh, 0C9h, 1Bh, 8Eh, 24h, 40h, 9Eh, 0B5h, 70h, 2Bh, 0A8h, 0ADh, 0C5h, 9Dh
	db	49h, 40h, 0D5h, 0A6h, 0CFh, 0FFh, 49h, 1Fh, 78h, 0C2h, 93h, 40h, 0E0h, 8Ch, 0E9h, 80h
	db	0C9h, 47h, 0BAh, 93h, 28h, 41h, 8Eh, 0DEh, 0F9h, 9Dh, 0FBh, 0EBh, 7Eh, 0AAh, 51h, 42h
	db	0C7h, 91h, 0Eh, 0A6h, 0AEh, 0A0h, 19h, 0E3h, 0A3h, 44h, 17h, 0Ch, 75h, 81h, 86h, 75h
	db	76h, 0C9h, 48h, 49h, 0E5h, 5Dh, 3Dh, 0C5h, 5Dh, 3Bh, 8Bh, 9Eh, 92h, 52h, 9Bh, 97h
	db	20h, 8Ah, 2, 52h, 60h, 0C4h, 25h, 65h, 1Ah, 21h, 0AFh, 7Fh, 0D1h, 0A1h, 0A3h, 96h
	db	4Ch, 8Ah, 5, 2Eh, 54h, 59h, 50h, 45h, 0, 0, 1, 2, 0, 3, 0, 5
	db	0, 4, 0, 6, 8, 9, 1, 0, 2, 0, 4, 0, 8, 0, 6, 0
	db	6, 0, 0Ah, 0, 0FFh, 0FFh, 0FEh, 0FFh, 0, 0, 0, 20h, 10h, 20h, 18h, 20h
	db	0, 21h, 8, 21h, 10h, 21h, 18h, 21h, 30h, 21h, 38h, 21h, 18h, 24h, 20h, 24h
	db	28h, 24h, 30h, 24h, 38h, 24h, 26h, 2Eh, 36h, 3Eh, 64h, 65h, 7Ah, 56h, 78h, 56h
	db	7Ch, 56h, 76h, 56h, 0, 0, 0, 0, 0, 0, 84h, 56h, 86h, 56h, 82h, 56h
	db	0, 0, 0, 0, 80h, 80h, 80h, 3, 80h, 2, 0, 1, 80h, 80h, 6, 4
	db	80h, 80h, 7, 5, 6, 7, 80h, 80h, 4, 5, 80h, 80h, 50h, 58h, 50h, 58h
	db	42h, 58h, 42h, 58h, 0AEh, 58h, 50h, 58h, 50h, 58h, 7Ch, 6Eh, 54h, 6Eh, 54h, 6Eh
	db	96h, 6Fh, 0BCh, 6Fh, 0E8h, 6Fh, 0E8h, 6Fh, 54h, 6Eh, 21h, 70h, 40h, 70h, 7Dh, 70h
	db	99h, 70h, 12h, 70h, 58h, 70h, 54h, 6Eh, 0E8h, 6Dh, 5, 70h, 50h, 52h, 4Fh, 43h
	db	42h, 45h, 47h, 49h, 4Eh, 50h, 52h, 4Fh, 43h, 45h, 4Eh, 44h, 53h, 54h, 41h, 52h
	db	54h, 55h, 50h, 45h, 4Eh, 44h, 9, 50h, 55h, 53h, 48h, 9, 42h, 50h, 0Dh, 9
	db	4Dh, 4Fh, 56h, 9, 42h, 50h, 2Ch, 53h, 50h, 0Dh, 9, 50h, 55h, 53h, 48h, 9
	db	44h, 53h, 0Dh, 9, 50h, 4Fh, 50h, 9, 41h, 58h, 0Dh, 9, 58h, 43h, 48h, 47h
	db	9, 41h, 58h, 2Ch, 41h, 58h, 0Dh, 9, 49h, 4Eh, 43h, 9, 42h, 50h, 0Dh, 9
	db	4Dh, 4Fh, 56h, 9, 44h, 53h, 2Ch, 41h, 58h, 0Dh, 9, 53h, 55h, 42h, 9, 42h
	db	50h, 2Ch, 32h, 0Dh, 9, 50h, 4Fh, 50h, 9, 44h, 53h, 0Dh, 9, 44h, 45h, 43h
	db	9, 42h, 50h, 0Dh, 9, 53h, 55h, 42h, 9, 53h, 50h, 2Ch, 30h, 30h, 30h, 30h
	db	68h, 0Dh, 9, 45h, 4Eh, 54h, 45h, 52h, 57h, 9, 30h, 30h, 30h, 30h, 68h, 2Ch
	db	30h, 0Dh, 9, 50h, 55h, 53h, 48h, 9, 0, 9, 50h, 4Fh, 50h, 9, 0, 9
	db	4Dh, 4Fh, 56h, 9, 53h, 50h, 2Ch, 42h, 50h, 0Dh, 9, 50h, 4Fh, 50h, 9, 42h
	db	50h, 0Dh, 9, 4Ch, 45h, 41h, 56h, 45h, 57h, 0Dh, 9, 52h, 45h, 54h, 9, 30h
	db	30h, 30h, 30h, 68h, 0Dh, 9, 4Fh, 52h, 47h, 9, 31h, 30h, 30h, 68h, 0Dh, 9
	db	45h, 4Eh, 44h, 20h, 40h, 53h, 74h, 61h, 72h, 74h, 75h, 70h, 0Dh, 40h, 53h, 74h
	db	61h, 72h, 74h, 75h, 70h, 3Ah, 0Dh, 9, 4Dh, 4Fh, 56h, 9, 44h, 58h, 2Ch, 40h
	db	64h, 61h, 74h, 61h, 0Dh, 9, 4Dh, 4Fh, 56h, 9, 44h, 53h, 2Ch, 44h, 58h, 0Dh
	db	9, 4Dh, 4Fh, 56h, 9, 42h, 58h, 2Ch, 53h, 53h, 0Dh, 9, 53h, 55h, 42h, 9
	db	42h, 58h, 2Ch, 44h, 58h, 0Dh, 9, 53h, 48h, 4Ch, 9, 42h, 58h, 2Ch, 31h, 0Dh
	db	9, 53h, 48h, 4Ch, 9, 42h, 58h, 2Ch, 34h, 0Dh, 9, 43h, 4Ch, 49h, 0Dh, 9
	db	4Dh, 4Fh, 56h, 9, 53h, 53h, 2Ch, 44h, 58h, 0Dh, 9, 41h, 44h, 44h, 9, 53h
	db	50h, 2Ch, 42h, 58h, 0Dh, 9, 53h, 54h, 49h, 0Dh, 66h, 1Dh, 6Fh, 1Dh, 0, 0
	db	7Ah, 1Dh, 83h, 1Dh, 8Bh, 1Dh, 97h, 1Dh, 66h, 1Dh, 6Fh, 1Dh, 7Ah, 1Dh, 9Fh, 1Dh
	db	0, 0, 97h, 1Dh, 66h, 1Dh, 6Fh, 1Dh, 0, 0, 0AAh, 1Dh, 0EFh, 1Dh, 0, 0
	db	0B4h, 1Dh, 0FAh, 1Dh, 0BCh, 1Dh, 0, 0, 15h, 1Eh, 2Dh, 1Eh, 0, 0, 2Dh, 1Eh
	db	37h, 1Eh, 45h, 1Eh, 0, 0, 50h, 1Eh, 5Bh, 1Eh, 66h, 1Eh, 66h, 1Eh, 66h, 1Eh
	db	66h, 1Eh, 7Ah, 1Eh, 7Fh, 1Eh, 8Ah, 1Eh, 95h, 1Eh, 0, 0, 50h, 1Eh, 5Bh, 1Eh
	db	70h, 1Eh, 7Fh, 1Eh, 8Ah, 1Eh, 0, 0, 61h, 76h, 3Ah, 76h, 49h, 76h, 52h, 76h
	db	8Ah, 77h, 43h, 77h, 61h, 77h, 6Ah, 77h, 0DCh, 0B2h, 6, 0B3h, 2Ah, 0B3h, 5Ah, 0B3h
	db	6Ch, 0B3h, 48h, 0B3h, 0Dh, 0B2h, 0D6h, 0B1h, 0E1h, 0B1h, 0ECh, 0B1h, 0F7h, 0B1h, 2, 0B2h
	db	2Ch, 0B0h, 37h, 0B0h, 96h, 0B0h, 0A7h, 0B0h, 0CBh, 0B0h, 54h, 0B0h, 42h, 0B0h, 72h, 0B0h
	db	84h, 0B0h, 21h, 0AFh, 32h, 0AFh, 44h, 0AFh, 66h, 0AFh, 55h, 0AFh, 44h, 0AEh, 55h, 0AEh
	db	66h, 0AEh, 77h, 0AEh, 88h, 0AEh, 99h, 0AEh, 36h, 5Fh, 3Ah, 5Fh, 4Eh, 5Fh, 52h, 5Fh
	db	56h, 5Fh, 5Ah, 5Fh, 5Ah, 5Fh, 5Eh, 5Fh, 62h, 5Fh, 6Dh, 5Fh, 71h, 5Fh, 66h, 5Fh
	db	47h, 5Fh, 3Eh, 5Fh, 0D4h, 7Bh, 33h, 7Ch, 74h, 7Ch, 15h, 7Dh, 5Ch, 7Dh, 0D4h, 7Dh
	db	33h, 7Eh, 41h, 7Eh, 4Fh, 7Eh, 6Bh, 7Eh, 5Dh, 7Eh, 79h, 7Eh, 0DCh, 0BBh, 0D4h, 7Bh
	db	33h, 7Ch, 0DCh, 0BBh, 74h, 7Ch, 0DCh, 0BBh, 5Ch, 7Dh, 0DCh, 0BBh, 15h, 7Dh, 0DCh, 0BBh
	db	0D4h, 7Dh, 31h, 0B7h, 43h, 0B7h, 4Dh, 0B7h, 57h, 0B7h, 61h, 0B7h, 74h, 0BAh, 13h, 3Bh
	db	1Bh, 0BCh, 22h, 0BCh, 0BEh, 0B9h, 4Eh, 0BBh, 0B2h, 0BBh, 0B2h, 0BBh, 1, 0BCh, 0BCh, 0B9h
	db	11h, 0BBh, 44h, 0BBh, 44h, 0BBh, 4Dh, 0BBh, 0BCh, 0B9h, 9, 0BCh, 13h, 3Bh, 1Bh, 0BCh
	db	22h, 0BCh, 0BCh, 0B9h, 5Bh, 0BCh, 13h, 3Bh, 1Bh, 0BCh, 22h, 0BCh, 2Fh, 0BCh, 84h, 0BCh
	db	84h, 0BCh, 84h, 0BCh, 1, 0BCh, 0BCh, 0B9h, 0FCh, 0BCh, 0FAh, 0BCh, 0FAh, 0BCh, 0FAh, 0BCh
	db	92h, 0BCh, 3Ah, 0BDh, 40h, 0BDh, 42h, 0BDh, 40h, 0BDh, 3Ah, 0BDh, 20h, 0, 0DCh, 0D6h
	db	0E0h, 0D6h, 0E5h, 0D6h, 0EAh, 0D6h, 0EAh, 0D6h, 4Bh, 0F3h, 55h, 0F3h, 5Fh, 0F3h, 69h, 0F3h
	db	73h, 0F3h, 1, 0, 4, 0, 8, 0, 10h, 0, 40h, 0, 0, 1, 0, 2
	db	0, 4, 0, 8, 0, 10h, 0, 20h, 0, 40h, 0, 80h, 2, 0, 20h, 0
	db	80h, 0, 0C3h, 0EDh, 0C7h, 0EDh, 0CBh, 0EDh, 0CFh, 0EDh, 0D3h, 0EDh, 0F0h, 0EDh, 1, 0EEh
	db	0Ch, 0EEh, 17h, 0EEh, 0F6h, 0EDh, 22h, 0EEh, 43h, 0EEh, 4Eh, 0EEh, 7Eh, 0EEh, 0D7h, 0EDh
	db	8Ah, 0EEh, 8Eh, 0EEh, 92h, 0EEh, 96h, 0EEh, 0D0h, 0DBh, 0CCh, 3Eh, 0E6h, 3Eh, 0F6h, 0DBh
	db	2, 0DCh, 2Ch, 0DCh, 0, 0CEh, 7, 0CEh, 0Eh, 0CEh, 25h, 0CEh, 3Bh, 0CEh, 51h, 0CEh
	db	67h, 0CEh, 7Dh, 0CEh, 93h, 0CEh, 0C2h, 0CFh, 58h, 0CFh, 51h, 0CFh, 50h, 30h, 30h, 30h
	db	0, 10h, 43h, 41h, 4Ch, 4Ch, 50h, 52h, 4Fh, 43h, 9, 43h, 41h, 4Ch, 4Ch, 9
	db	0, 9, 50h, 55h, 53h, 48h, 9, 0, 9, 41h, 44h, 44h, 9, 53h, 50h, 2Ch
	db	30h, 30h, 30h, 30h, 68h, 0Dh, 4Ah, 3
	dw	SEG5
	db	5, 6
	dw	SEG5
	dd	L103B4
	dd	L1181D
	db	66h, 25h
	dw	SEG5
	db	0A0h, 36h
	dw	SEG5
	db	3Fh, 3Fh, 64h, 61h, 74h, 65h, 20h, 65h, 71h, 75h, 20h, 22h, 6Dh, 6Dh, 2Fh, 64h
	db	64h, 2Fh, 79h, 79h, 22h, 0Dh, 3Fh, 3Fh, 74h, 69h, 6Dh, 65h, 20h, 65h, 71h, 75h
	db	20h, 22h, 68h, 68h, 3Ah, 6Dh, 6Dh, 3Ah, 73h, 73h, 22h, 0Dh, 3Fh, 3Fh, 66h, 69h
	db	6Ch, 65h, 6Eh, 61h, 6Dh, 65h, 20h, 65h, 71h, 75h, 20h, 22h, 6Eh, 6Eh, 6Eh, 6Eh
	db	6Eh, 6Eh, 6Eh, 6Eh, 22h, 0Dh, 3Fh, 3Fh, 76h, 65h, 72h, 73h, 69h, 6Fh, 6Eh, 20h
	db	65h, 71h, 75h, 20h, 78h, 78h, 2Ah, 32h, 35h, 36h, 2Bh, 79h, 79h, 0Dh, 30h, 31h
	db	30h, 31h, 48h, 0, 44h, 0EAh, 6Fh, 0EAh, 0DFh, 0EAh, 7Eh, 0EBh, 0B6h, 0E8h, 22h, 0EAh
	db	77h, 0B4h, 7Dh, 0B4h, 83h, 0B4h, 78h, 0E9h, 89h, 0B4h, 8Fh, 0B4h, 8Fh, 0B4h, 95h, 0B4h
	db	7Fh, 0E6h, 0C1h, 0E7h, 4Ch, 0ECh, 0E3h, 0ECh, 1Fh, 0EFh, 0Ah, 0E8h, 67h, 0E4h, 94h, 0F0h
	db	84h, 0EFh, 98h, 0F0h, 44h, 0D6h, 0EDh, 0D7h, 0FBh, 0D7h, 8, 0D8h, 15h, 0D8h, 24h, 0D8h
	db	0B1h, 0D8h, 4Fh, 0D8h, 70h, 0D8h, 80h, 0D8h, 0C1h, 0D8h, 61h, 0D8h, 91h, 0D8h, 0A1h, 0D8h
	db	0BAh, 0D5h, 0A9h, 0CAh, 0FBh, 0CAh, 37h, 0E3h, 0D1h, 0D8h, 0DDh, 0D8h, 0E9h, 0D8h, 0FAh, 0D8h
	db	88h, 0D9h, 0Bh, 0D9h, 58h, 0D9h, 64h, 0D9h, 94h, 0D9h, 4Ch, 0D9h, 70h, 0D9h, 7Ch, 0D9h
	db	6Fh, 0DAh, 74h, 0DAh, 79h, 0DAh, 7Eh, 0DAh, 0A1h, 0DAh, 83h, 0DAh, 8Dh, 0DAh, 92h, 0DAh
	db	0A6h, 0DAh, 88h, 0DAh, 97h, 0DAh, 9Ch, 0DAh, 21h, 0DBh, 49h, 0DBh, 8Fh, 0D7h, 5Fh, 0E0h
	db	28h, 0E2h, 0CBh, 0E0h, 4Eh, 0E1h, 4Eh, 0E2h, 75h, 0B4h, 7Bh, 0B4h, 81h, 0B4h, 87h, 0B4h
	db	8Dh, 0B4h, 8Dh, 0B4h, 93h, 0B4h, 0C8h, 0C5h, 0CCh, 0C5h, 0D0h, 0C5h, 0D4h, 0C5h, 0D8h, 0C5h
	db	0DCh, 0C5h, 0E0h, 0C5h, 0E4h, 0C5h, 0ACh, 0C5h, 0BAh, 0C5h, 20h, 0CAh, 9, 0C6h, 7Ah, 0C9h
	db	69h, 0DCh, 0FBh, 0C5h, 17h, 0C6h, 1Bh, 0C6h, 32h, 0C6h, 45h, 0C6h, 5Bh, 0C6h, 5Fh, 0C6h
	db	80h, 0C6h, 90h, 0C6h, 0A8h, 0C6h, 0B6h, 0C6h, 0BAh, 0C6h, 2Ah, 0C7h, 2Eh, 0C7h, 32h, 0C7h
	db	0D1h, 0C6h, 36h, 0C7h, 3Ah, 0C7h, 51h, 0C7h, 55h, 0C7h, 59h, 0C7h, 59h, 0C7h, 5Dh, 0C7h
	db	61h, 0C7h, 65h, 0C7h, 69h, 0C7h, 0FCh, 0C7h, 0, 0C8h, 73h, 0C8h, 4, 0C8h, 8, 0C8h
	db	0Ch, 0C8h, 10h, 0C8h, 14h, 0C8h, 77h, 0C8h, 7Bh, 0C8h, 18h, 0C8h, 1Ch, 0C8h, 20h, 0C8h
	db	24h, 0C8h, 8Fh, 0C8h, 28h, 0C8h, 2Ch, 0C8h, 7Fh, 0C8h, 30h, 0C8h, 83h, 0C8h, 5Fh, 0C8h
	db	87h, 0C8h, 8Bh, 0C8h, 34h, 0C8h, 38h, 0C8h, 93h, 0C8h, 3Ch, 0C8h, 40h, 0C8h, 44h, 0C8h
	db	48h, 0C8h, 9Bh, 0C8h, 4Ch, 0C8h, 50h, 0C8h, 80h, 0C7h, 84h, 0C7h, 8Fh, 0C7h, 0A7h, 0C7h
	db	0BFh, 0C7h, 0D8h, 0C7h, 0B2h, 0C8h, 0B6h, 0C8h, 0B6h, 0C8h, 0B6h, 0C8h, 0BAh, 0C8h, 0BAh, 0C8h
	db	0D4h, 0C8h, 0D8h, 0C8h, 0DCh, 0C8h, 0E0h, 0C8h, 0E4h, 0C8h, 0E8h, 0C8h, 2, 0C9h, 50h, 0C9h
	db	54h, 0C9h, 49h, 0C9h, 88h, 0C9h, 88h, 0C9h, 94h, 0C9h, 94h, 0C9h, 94h, 0C9h, 90h, 0C9h
	db	90h, 0C9h, 90h, 0C9h, 8Ch, 0C9h, 8Ch, 0C9h, 0FDh, 0C9h, 98h, 0C9h, 98h, 0C9h, 0A0h, 0C9h
	db	0A0h, 0C9h, 0ACh, 0C9h, 0ACh, 0C9h, 0A8h, 0C9h, 0A8h, 0C9h, 0A4h, 0C9h, 0A4h, 0C9h, 9Ch, 0C9h
	db	9Ch, 0C9h, 0B4h, 0C9h, 0BCh, 0C9h, 0C0h, 0C9h, 0C0h, 0C9h, 0B0h, 0C9h, 0C4h, 0C9h, 0C4h, 0C9h
	db	0B8h, 0C9h, 0DBh, 0C9h, 0DFh, 0C9h, 0DFh, 0C9h, 0E3h, 0C9h, 0E3h, 0C9h, 1, 0CAh, 5, 0CAh
	db	5, 0CAh, 9, 0CAh, 9, 0CAh, 0BAh, 0C4h, 0C4h, 0C4h, 0C9h, 0C4h, 0BFh, 0C4h, 0CEh, 0C4h
	db	0D3h, 0C4h, 53h, 0C5h, 58h, 0C5h, 4Eh, 0C5h, 0A6h, 0C2h, 0ACh, 0C2h, 0B2h, 0C2h, 0B7h, 0C2h
	db	0BCh, 0C2h, 0C1h, 0C2h, 0C6h, 0C2h, 0CBh, 0C2h, 0D0h, 0C2h, 0D5h, 0C2h, 0DAh, 0C2h, 0DFh, 0C2h
	db	0E4h, 0C2h, 0E9h, 0C2h, 0EEh, 0C2h, 0F3h, 0C2h, 0F8h, 0C2h, 0FDh, 0C2h, 2, 0C3h, 7, 0C3h
	db	0Ch, 0C3h, 11h, 0C3h, 16h, 0C3h, 1Bh, 0C3h, 20h, 0C3h, 25h, 0C3h, 2Ah, 0C3h, 2Fh, 0C3h
	db	8Ch, 0C3h, 91h, 0C3h, 96h, 0C3h, 9Bh, 0C3h, 0B8h, 0C3h, 0BCh, 0C3h, 0C0h, 0C3h, 0C4h, 0C3h
	db	0C8h, 0C3h, 0CCh, 0C3h, 3Dh, 0C4h, 0D0h, 0C3h, 38h, 0C4h, 72h, 0C4h, 77h, 0C4h, 7Ch, 0C4h
	db	81h, 0C4h, 86h, 0C4h, 8Bh, 0C4h, 90h, 0C4h, 95h, 0C4h, 9Ah, 0C4h, 42h, 0C2h, 47h, 0C2h
	db	29h, 0C2h, 80h, 0C2h, 67h, 0C2h, 0D5h, 0C1h, 0DAh, 0C1h, 0DFh, 0C1h, 0E4h, 0C1h, 4, 0C2h
	db	9, 0C2h, 55h, 0C1h, 5Ah, 0C1h, 0AAh, 0C1h, 0AFh, 0C1h, 17h, 0C1h, 1Bh, 0C1h, 42h, 0C1h
	db	73h, 0C3h, 20h, 0C4h, 25h, 0C4h, 60h, 0C3h, 4Ch, 0C3h, 51h, 0C3h, 56h, 0C3h, 5Bh, 0C3h
	db	0EFh, 0C0h, 0F3h, 0C0h, 0D3h, 0C0h, 0CBh, 0C0h, 0F7h, 0C0h, 0CFh, 0C0h, 0FBh, 0C0h, 8Dh, 0C0h
	db	0ABh, 0C0h, 3Bh, 0C0h, 53h, 0C0h, 1Eh, 0BFh, 3Eh, 0BFh, 0AAh, 0BFh, 0AEh, 0BFh, 0B2h, 0BFh
	db	0B6h, 0BFh, 0BAh, 0BFh, 0BEh, 0BFh, 0C2h, 0BFh, 0C6h, 0BFh, 7Dh, 0BFh, 81h, 0BFh, 85h, 0BFh
	db	89h, 0BFh, 5Ah, 0BFh, 5Eh, 0BFh, 0EBh, 0BFh, 0EFh, 0BFh, 17h, 0C0h, 0C5h, 0BDh, 0C9h, 0BDh
	db	0CDh, 0BDh, 0D1h, 0BDh, 0F0h, 0BDh, 0F4h, 0BDh, 13h, 0BEh, 17h, 0BEh, 36h, 0BEh, 3Ah, 0BEh
	db	5Fh, 0BEh, 63h, 0BEh, 67h, 0BEh, 6Bh, 0BEh, 67h, 0BEh, 6Fh, 0BEh, 73h, 0BEh, 77h, 0BEh
	db	7Bh, 0BEh, 7Fh, 0BEh, 6Bh, 0BEh, 67h, 0BEh, 63h, 0BEh, 5Fh, 0BEh, 63h, 0BEh, 83h, 0BEh
	db	7Fh, 0BEh, 7Bh, 0BEh, 77h, 0BEh, 73h, 0BEh, 87h, 0BEh, 8Bh, 0BEh, 8Fh, 0BEh, 83h, 0BEh
	db	93h, 0BEh, 97h, 0BEh, 97h, 0BEh, 8Bh, 0BEh, 9Bh, 0BEh, 6Fh, 0BEh, 44h, 0BDh, 48h, 0BDh
	db	4Ch, 0BDh, 50h, 0BDh, 54h, 0BDh, 58h, 0BDh, 5Ch, 0BDh, 60h, 0BDh, 64h, 0BDh, 68h, 0BDh
	db	6Ch, 0BDh, 70h, 0BDh, 74h, 0BDh, 7Ch, 0BDh, 9Eh, 0BDh, 0A2h, 0BDh, 0A6h, 0BDh, 0BEh, 0BEh
	db	0C2h, 0BEh, 0C2h, 0BEh, 0C6h, 0BEh, 0C6h, 0BEh, 0BAh, 0BEh, 69h, 0C0h, 77h, 0C0h, 97h, 0C8h
	db	78h, 0BDh, 0E5h, 0BEh, 0FBh, 0BEh, 0FFh, 0BEh, 0A1h, 0DBh, 0C6h, 0DDh, 0B1h, 0DEh, 0FDh, 0DFh
	db	74h, 0E2h, 69h, 0D6h, 0C8h, 0D5h, 8Fh, 0CDh, 0BAh, 0CDh, 56h, 0D0h, 72h, 0D0h, 23h, 0D1h
	db	0EBh, 0D0h, 7, 0D1h, 0A4h, 0D0h, 0CFh, 0D0h, 9Ah, 0CDh, 3Fh, 0D7h, 4Ah, 0D7h, 72h, 0D7h
	db	81h, 0D7h, 0EDh, 0D7h, 0FBh, 0D7h, 8, 0D8h, 15h, 0D8h, 24h, 0D8h, 0B1h, 0D8h, 4Fh, 0D8h
	db	70h, 0D8h, 80h, 0D8h, 0C1h, 0D8h, 61h, 0D8h, 91h, 0D8h, 0A1h, 0D8h, 0CCh, 0DAh, 0F8h, 0DAh
	db	0C5h, 0D7h, 0Ch, 0D6h, 3Dh, 0D4h, 42h, 0D4h, 47h, 0D4h, 4Ch, 0D4h, 51h, 0D4h, 57h, 0D4h
	db	5Dh, 0D4h, 63h, 0D4h, 69h, 0D4h, 6Dh, 0D4h, 73h, 0D4h, 7Ch, 0D4h, 0CAh, 0D4h, 0D8h, 0D4h
	db	85h, 0D4h, 94h, 0D4h, 0A5h, 0D4h, 0B6h, 0D4h, 0E6h, 0D4h, 0F3h, 0D4h, 0, 0D5h, 14h, 0D5h
	db	2Bh, 0D5h, 3Fh, 0D5h, 4Ch, 0D5h, 59h, 0D5h, 66h, 0D5h, 73h, 0D5h, 0ACh, 0D5h, 76h, 0E4h
	db	59h, 0E3h, 0ABh, 0E3h, 9, 0E4h, 0E6h, 0E2h, 0A7h, 0F0h, 0ABh, 0F0h, 5Ch, 0EFh, 0B1h, 0ECh
	db	7, 0EFh, 5Bh, 0E6h, 0ABh, 0E7h, 2Ch, 0ECh, 0EDh, 0E7h, 32h, 0E6h, 0B0h, 0CBh, 36h, 0CCh
	db	75h, 0CDh, 44h, 0CCh, 82h, 0CDh, 0FDh, 0CCh, 31h, 0CDh, 0Ah, 0CDh, 3Eh, 0CDh, 58h, 0CDh
	db	65h, 0CDh, 0FDh, 0CBh, 0Bh, 0CCh, 1Fh, 0CCh, 8Ah, 0CCh, 98h, 0CCh, 0E1h, 0CBh, 0EFh, 0CBh
	db	17h, 0CDh, 24h, 0CDh, 0C7h, 0CBh, 0D4h, 0CBh, 0A6h, 0CCh, 0C9h, 0CCh, 2Eh, 0CAh, 71h, 0CAh
	db	0BAh, 0CAh, 0Ch, 0CBh, 3Ah, 0CBh, 51h, 0CBh, 68h, 0CBh, 7Fh, 0CBh, 99h, 0CBh, 3Dh, 0D4h
	db	42h, 0D4h, 47h, 0D4h, 4Ch, 0D4h, 47h, 0D4h, 51h, 0D4h, 57h, 0D4h, 51h, 0D4h, 5Dh, 0D4h
	db	63h, 0D4h, 5Dh, 0D4h, 6Dh, 0D4h, 73h, 0D4h, 7Ch, 0D4h, 3Dh, 0CAh, 75h, 0CDh, 82h, 0CDh
	db	36h, 0CCh, 44h, 0CCh, 0FDh, 0CCh, 0EBh, 0CCh, 0Ah, 0CDh, 31h, 0CDh, 3Eh, 0CDh, 4Bh, 0CDh
	db	0Ch, 0D6h, 0BAh, 0CDh, 72h, 0D0h, 56h, 0D0h, 0EBh, 0D0h, 7, 0D1h, 0A4h, 0D0h, 0CFh, 0D0h
	db	9Ah, 0CDh, 23h, 0D1h, 87h, 0DBh, 94h, 0DBh, 7, 43h, 4Fh, 4Dh, 4Dh, 45h, 4Eh, 54h
	db	4, 2Eh, 45h, 52h, 52h, 6, 2Eh, 45h, 52h, 52h, 4Eh, 5Ah, 5, 2Eh, 45h, 52h
	db	52h, 45h, 5, 2Eh, 45h, 52h, 52h, 31h, 5, 2Eh, 45h, 52h, 52h, 32h, 5, 2Eh
	db	45h, 52h, 52h, 42h, 7, 2Eh, 45h, 52h, 52h, 44h, 45h, 46h, 7, 2Eh, 45h, 52h
	db	52h, 44h, 49h, 46h, 7, 2Eh, 45h, 52h, 52h, 49h, 44h, 4Eh, 6, 2Eh, 45h, 52h
	db	52h, 4Eh, 42h, 8, 2Eh, 45h, 52h, 52h, 4Eh, 44h, 45h, 46h, 8, 2Eh, 45h, 52h
	db	52h, 44h, 49h, 46h, 49h, 8, 2Eh, 45h, 52h, 52h, 49h, 44h, 4Eh, 49h, 4, 25h
	db	4Fh, 55h, 54h, 5, 54h, 49h, 54h, 4Ch, 45h, 6, 53h, 55h, 42h, 54h, 54h, 4Ch
	db	1, 25h, 2, 49h, 46h, 3, 49h, 46h, 45h, 3, 49h, 46h, 31h, 3, 49h, 46h
	db	32h, 3, 49h, 46h, 42h, 5, 49h, 46h, 44h, 45h, 46h, 5, 49h, 46h, 44h, 49h
	db	46h, 5, 49h, 46h, 49h, 44h, 4Eh, 4, 49h, 46h, 4Eh, 42h, 6, 49h, 46h, 4Eh
	db	44h, 45h, 46h, 6, 49h, 46h, 44h, 49h, 46h, 49h, 6, 49h, 46h, 49h, 44h, 4Eh
	db	49h, 6, 45h, 4Ch, 53h, 45h, 49h, 46h, 7, 45h, 4Ch, 53h, 45h, 49h, 46h, 45h
	db	7, 45h, 4Ch, 53h, 45h, 49h, 46h, 31h, 7, 45h, 4Ch, 53h, 45h, 49h, 46h, 32h
	db	7, 45h, 4Ch, 53h, 45h, 49h, 46h, 42h, 9, 45h, 4Ch, 53h, 45h, 49h, 46h, 44h
	db	45h, 46h, 9, 45h, 4Ch, 53h, 45h, 49h, 46h, 44h, 49h, 46h, 9, 45h, 4Ch, 53h
	db	45h, 49h, 46h, 49h, 44h, 4Eh, 8, 45h, 4Ch, 53h, 45h, 49h, 46h, 4Eh, 42h, 0Ah
	db	45h, 4Ch, 53h, 45h, 49h, 46h, 4Eh, 44h, 45h, 46h, 0Ah, 45h, 4Ch, 53h, 45h, 49h
	db	46h, 44h, 49h, 46h, 49h, 0Ah, 45h, 4Ch, 53h, 45h, 49h, 46h, 49h, 44h, 4Eh, 49h
	db	7, 49h, 4Eh, 43h, 4Ch, 55h, 44h, 45h, 0Ah, 49h, 4Eh, 43h, 4Ch, 55h, 44h, 45h
	db	4Ch, 49h, 42h, 4, 4Eh, 41h, 4Dh, 45h, 5, 45h, 58h, 54h, 52h, 4Eh, 6, 50h
	db	55h, 42h, 4Ch, 49h, 43h, 4, 43h, 4Fh, 4Dh, 4Dh, 6, 47h, 4Ch, 4Fh, 42h, 41h
	db	4Ch, 9, 50h, 55h, 42h, 4Ch, 49h, 43h, 44h, 4Ch, 4Ch, 2, 44h, 42h, 2, 44h
	db	57h, 2, 44h, 44h, 2, 44h, 51h, 2, 44h, 50h, 2, 44h, 46h, 2, 44h, 54h
	db	3, 41h, 44h, 44h, 2, 4Fh, 52h, 3, 41h, 44h, 43h, 3, 53h, 42h, 42h, 3
	db	41h, 4Eh, 44h, 3, 53h, 55h, 42h, 3, 58h, 4Fh, 52h, 3, 43h, 4Dh, 50h, 4
	db	58h, 43h, 48h, 47h, 4, 54h, 45h, 53h, 54h, 3, 4Dh, 4Fh, 56h, 3, 45h, 53h
	db	43h, 3, 4Ah, 4Dh, 50h, 4, 43h, 41h, 4Ch, 4Ch, 3, 49h, 4Eh, 54h, 3, 49h
	db	4Eh, 43h, 3, 44h, 45h, 43h, 4, 50h, 55h, 53h, 48h, 3, 50h, 4Fh, 50h, 3
	db	41h, 41h, 44h, 3, 41h, 41h, 4Dh, 2, 49h, 4Eh, 3, 4Fh, 55h, 54h, 3, 4Ch
	db	45h, 41h, 3, 4Ch, 44h, 53h, 3, 4Ch, 45h, 53h, 3, 44h, 49h, 56h, 3, 4Dh
	db	55h, 4Ch, 4, 49h, 44h, 49h, 56h, 4, 49h, 4Dh, 55h, 4Ch, 3, 4Eh, 45h, 47h
	db	3, 4Eh, 4Fh, 54h, 3, 52h, 4Fh, 4Ch, 3, 52h, 4Fh, 52h, 3, 53h, 41h, 4Ch
	db	3, 53h, 48h, 4Ch, 3, 53h, 41h, 52h, 3, 53h, 48h, 52h, 3, 52h, 43h, 4Ch
	db	3, 52h, 43h, 52h, 3, 41h, 41h, 41h, 3, 41h, 41h, 53h, 3, 43h, 42h, 57h
	db	3, 43h, 4Ch, 43h, 3, 43h, 4Ch, 44h, 3, 43h, 4Ch, 49h, 3, 43h, 4Dh, 43h
	db	5, 43h, 4Dh, 50h, 53h, 42h, 5, 43h, 4Dh, 50h, 53h, 57h, 3, 43h, 57h, 44h
	db	3, 44h, 41h, 41h, 3, 44h, 41h, 53h, 3, 48h, 4Ch, 54h, 4, 49h, 4Eh, 54h
	db	4Fh, 4, 49h, 52h, 45h, 54h, 4, 4Ch, 41h, 48h, 46h, 5, 4Ch, 4Fh, 44h, 53h
	db	42h, 5, 4Ch, 4Fh, 44h, 53h, 57h, 5, 4Dh, 4Fh, 56h, 53h, 42h, 5, 4Dh, 4Fh
	db	56h, 53h, 57h, 3, 4Eh, 4Fh, 50h, 4, 50h, 4Fh, 50h, 46h, 5, 50h, 55h, 53h
	db	48h, 46h, 4, 53h, 41h, 48h, 46h, 5, 53h, 43h, 41h, 53h, 42h, 5, 53h, 43h
	db	41h, 53h, 57h, 3, 53h, 54h, 43h, 3, 53h, 54h, 44h, 3, 53h, 54h, 49h, 5
	db	53h, 54h, 4Fh, 53h, 42h, 5, 53h, 54h, 4Fh, 53h, 57h, 4, 57h, 41h, 49h, 54h
	db	5, 58h, 4Ch, 41h, 54h, 42h, 4, 53h, 54h, 4Fh, 53h, 4, 53h, 43h, 41h, 53h
	db	4, 4Ch, 4Fh, 44h, 53h, 4, 58h, 4Ch, 41h, 54h, 4, 4Dh, 4Fh, 56h, 53h, 4
	db	43h, 4Dh, 50h, 53h, 4, 4Ch, 4Fh, 43h, 4Bh, 3, 52h, 45h, 50h, 4, 52h, 45h
	db	50h, 45h, 4, 52h, 45h, 50h, 5Ah, 5, 52h, 45h, 50h, 4Eh, 45h, 5, 52h, 45h
	db	50h, 4Eh, 5Ah, 5, 53h, 45h, 47h, 43h, 53h, 5, 53h, 45h, 47h, 44h, 53h, 5
	db	53h, 45h, 47h, 53h, 53h, 5, 53h, 45h, 47h, 45h, 53h, 5, 53h, 45h, 47h, 46h
	db	53h, 5, 53h, 45h, 47h, 47h, 53h, 3, 52h, 45h, 54h, 4, 52h, 45h, 54h, 4Eh
	db	4, 52h, 45h, 54h, 46h, 7, 52h, 45h, 54h, 43h, 4Fh, 44h, 45h, 2, 4Ah, 41h
	db	4, 4Ah, 4Eh, 42h, 45h, 3, 4Ah, 41h, 45h, 3, 4Ah, 4Eh, 42h, 3, 4Ah, 4Eh
	db	43h, 2, 4Ah, 42h, 4, 4Ah, 4Eh, 41h, 45h, 2, 4Ah, 43h, 3, 4Ah, 42h, 45h
	db	3, 4Ah, 4Eh, 41h, 4, 4Ah, 43h, 58h, 5Ah, 2, 4Ah, 45h, 2, 4Ah, 5Ah, 2
	db	4Ah, 47h, 4, 4Ah, 4Eh, 4Ch, 45h, 3, 4Ah, 47h, 45h, 3, 4Ah, 4Eh, 4Ch, 2
	db	4Ah, 4Ch, 4, 4Ah, 4Eh, 47h, 45h, 3, 4Ah, 4Ch, 45h, 3, 4Ah, 4Eh, 47h, 3
	db	4Ah, 4Eh, 45h, 3, 4Ah, 4Eh, 5Ah, 3, 4Ah, 4Eh, 4Fh, 3, 4Ah, 4Eh, 53h, 3
	db	4Ah, 4Eh, 50h, 3, 4Ah, 50h, 4Fh, 2, 4Ah, 4Fh, 2, 4Ah, 50h, 3, 4Ah, 50h
	db	45h, 2, 4Ah, 53h, 4, 4Ch, 4Fh, 4Fh, 50h, 5, 4Ch, 4Fh, 4Fh, 50h, 45h, 5
	db	4Ch, 4Fh, 4Fh, 50h, 5Ah, 6, 4Ch, 4Fh, 4Fh, 50h, 4Eh, 45h, 6, 4Ch, 4Fh, 4Fh
	db	50h, 4Eh, 5Ah, 5, 4Ch, 4Fh, 4Fh, 50h, 57h, 6, 4Ch, 4Fh, 4Fh, 50h, 57h, 45h
	db	6, 4Ch, 4Fh, 4Fh, 50h, 57h, 5Ah, 7, 4Ch, 4Fh, 4Fh, 50h, 57h, 4Eh, 45h, 7
	db	4Ch, 4Fh, 4Fh, 50h, 57h, 4Eh, 5Ah, 4, 46h, 41h, 44h, 44h, 4, 46h, 44h, 49h
	db	56h, 5, 46h, 44h, 49h, 56h, 52h, 4, 46h, 4Dh, 55h, 4Ch, 4, 46h, 53h, 55h
	db	42h, 5, 46h, 53h, 55h, 42h, 52h, 4, 46h, 43h, 4Fh, 4Dh, 5, 46h, 43h, 4Fh
	db	4Dh, 50h, 3, 46h, 53h, 54h, 5, 46h, 32h, 58h, 4Dh, 31h, 4, 46h, 41h, 42h
	db	53h, 4, 46h, 43h, 48h, 53h, 5, 46h, 43h, 4Ch, 45h, 58h, 7, 46h, 44h, 45h
	db	43h, 53h, 54h, 50h, 5, 46h, 44h, 49h, 53h, 49h, 4, 46h, 45h, 4Eh, 49h, 7
	db	46h, 49h, 4Eh, 43h, 53h, 54h, 50h, 5, 46h, 49h, 4Eh, 49h, 54h, 4, 46h, 4Ch
	db	44h, 31h, 6, 46h, 4Ch, 44h, 4Ch, 32h, 45h, 6, 46h, 4Ch, 44h, 4Ch, 32h, 54h
	db	6, 46h, 4Ch, 44h, 4Ch, 47h, 32h, 6, 46h, 4Ch, 44h, 4Ch, 4Eh, 32h, 5, 46h
	db	4Ch, 44h, 50h, 49h, 4, 46h, 4Ch, 44h, 5Ah, 4, 46h, 4Eh, 4Fh, 50h, 6, 46h
	db	50h, 41h, 54h, 41h, 4Eh, 5, 46h, 50h, 52h, 45h, 4Dh, 5, 46h, 50h, 54h, 41h
	db	4Eh, 7, 46h, 52h, 4Eh, 44h, 49h, 4Eh, 54h, 6, 46h, 53h, 43h, 41h, 4Ch, 45h
	db	5, 46h, 53h, 51h, 52h, 54h, 4, 46h, 54h, 53h, 54h, 4, 46h, 58h, 41h, 4Dh
	db	7, 46h, 58h, 54h, 52h, 41h, 43h, 54h, 5, 46h, 59h, 4Ch, 32h, 58h, 7, 46h
	db	59h, 4Ch, 32h, 58h, 50h, 31h, 6, 46h, 4Eh, 43h, 4Ch, 45h, 58h, 6, 46h, 4Eh
	db	44h, 49h, 53h, 49h, 5, 46h, 4Eh, 45h, 4Eh, 49h, 6, 46h, 4Eh, 49h, 4Eh, 49h
	db	54h, 5, 46h, 41h, 44h, 44h, 50h, 5, 46h, 44h, 49h, 56h, 50h, 6, 46h, 44h
	db	49h, 56h, 52h, 50h, 5, 46h, 4Dh, 55h, 4Ch, 50h, 5, 46h, 53h, 55h, 42h, 50h
	db	6, 46h, 53h, 55h, 42h, 52h, 50h, 4, 46h, 58h, 43h, 48h, 6, 46h, 43h, 4Fh
	db	4Dh, 50h, 50h, 5, 46h, 46h, 52h, 45h, 45h, 5, 46h, 49h, 41h, 44h, 44h, 5
	db	46h, 49h, 43h, 4Fh, 4Dh, 6, 46h, 49h, 43h, 4Fh, 4Dh, 50h, 5, 46h, 49h, 44h
	db	49h, 56h, 6, 46h, 49h, 44h, 49h, 56h, 52h, 5, 46h, 49h, 4Dh, 55h, 4Ch, 4
	db	46h, 49h, 53h, 54h, 5, 46h, 49h, 53h, 55h, 42h, 6, 46h, 49h, 53h, 55h, 42h
	db	52h, 5, 46h, 4Ch, 44h, 43h, 57h, 5, 46h, 53h, 54h, 43h, 57h, 5, 46h, 53h
	db	54h, 53h, 57h, 6, 46h, 4Eh, 53h, 54h, 43h, 57h, 6, 46h, 4Eh, 53h, 54h, 53h
	db	57h, 6, 46h, 4Ch, 44h, 45h, 4Eh, 56h, 6, 46h, 52h, 53h, 54h, 4Fh, 52h, 5
	db	46h, 53h, 41h, 56h, 45h, 6, 46h, 53h, 54h, 45h, 4Eh, 56h, 6, 46h, 4Eh, 53h
	db	41h, 56h, 45h, 7, 46h, 4Eh, 53h, 54h, 45h, 4Eh, 56h, 3, 46h, 4Ch, 44h, 4
	db	46h, 53h, 54h, 50h, 4, 46h, 49h, 4Ch, 44h, 5, 46h, 49h, 53h, 54h, 50h, 4
	db	46h, 42h, 4Ch, 44h, 5, 46h, 42h, 53h, 54h, 50h, 5, 46h, 57h, 41h, 49h, 54h
	db	6, 46h, 53h, 45h, 54h, 50h, 4Dh, 5, 46h, 55h, 43h, 4Fh, 4Dh, 6, 46h, 55h
	db	43h, 4Fh, 4Dh, 50h, 7, 46h, 55h, 43h, 4Fh, 4Dh, 50h, 50h, 6, 46h, 50h, 52h
	db	45h, 4Dh, 31h, 4, 46h, 43h, 4Fh, 53h, 4, 46h, 53h, 49h, 4Eh, 7, 46h, 53h
	db	49h, 4Eh, 43h, 4Fh, 53h, 5, 50h, 55h, 53h, 48h, 41h, 4, 50h, 4Fh, 50h, 41h
	db	5, 4Ch, 45h, 41h, 56h, 45h, 4, 49h, 4Eh, 53h, 42h, 4, 49h, 4Eh, 53h, 57h
	db	5, 4Fh, 55h, 54h, 53h, 42h, 5, 4Fh, 55h, 54h, 53h, 57h, 3, 49h, 4Eh, 53h
	db	4, 4Fh, 55h, 54h, 53h, 5, 42h, 4Fh, 55h, 4Eh, 44h, 5, 45h, 4Eh, 54h, 45h
	db	52h, 4, 41h, 52h, 50h, 4Ch, 4, 43h, 4Ch, 54h, 53h, 4, 4Ch, 4Ch, 44h, 54h
	db	4, 4Ch, 4Dh, 53h, 57h, 3, 4Ch, 54h, 52h, 4, 53h, 4Ch, 44h, 54h, 4, 53h
	db	4Dh, 53h, 57h, 3, 53h, 54h, 52h, 4, 56h, 45h, 52h, 52h, 4, 56h, 45h, 52h
	db	57h, 4, 4Ch, 47h, 44h, 54h, 4, 4Ch, 49h, 44h, 54h, 4, 53h, 47h, 44h, 54h
	db	4, 53h, 49h, 44h, 54h, 3, 4Ch, 41h, 52h, 3, 4Ch, 53h, 4Ch, 4, 49h, 4Eh
	db	56h, 44h, 6, 57h, 42h, 49h, 4Eh, 56h, 44h, 6, 49h, 4Eh, 56h, 4Ch, 50h, 47h
	db	2, 42h, 54h, 3, 42h, 54h, 43h, 3, 42h, 54h, 52h, 3, 42h, 54h, 53h, 3
	db	42h, 53h, 46h, 3, 42h, 53h, 52h, 5, 4Dh, 4Fh, 56h, 53h, 58h, 5, 4Dh, 4Fh
	db	56h, 5Ah, 58h, 4, 53h, 48h, 4Ch, 44h, 4, 53h, 48h, 52h, 44h, 4, 53h, 45h
	db	54h, 41h, 5, 53h, 45h, 54h, 41h, 45h, 4, 53h, 45h, 54h, 42h, 5, 53h, 45h
	db	54h, 42h, 45h, 4, 53h, 45h, 54h, 43h, 4, 53h, 45h, 54h, 45h, 4, 53h, 45h
	db	54h, 47h, 5, 53h, 45h, 54h, 47h, 45h, 4, 53h, 45h, 54h, 4Ch, 5, 53h, 45h
	db	54h, 4Ch, 45h, 5, 53h, 45h, 54h, 4Eh, 41h, 6, 53h, 45h, 54h, 4Eh, 41h, 45h
	db	5, 53h, 45h, 54h, 4Eh, 42h, 6, 53h, 45h, 54h, 4Eh, 42h, 45h, 5, 53h, 45h
	db	54h, 4Eh, 43h, 5, 53h, 45h, 54h, 4Eh, 45h, 5, 53h, 45h, 54h, 4Eh, 47h, 6
	db	53h, 45h, 54h, 4Eh, 47h, 45h, 5, 53h, 45h, 54h, 4Eh, 4Ch, 6, 53h, 45h, 54h
	db	4Eh, 4Ch, 45h, 5, 53h, 45h, 54h, 4Eh, 4Fh, 5, 53h, 45h, 54h, 4Eh, 50h, 5
	db	53h, 45h, 54h, 4Eh, 53h, 5, 53h, 45h, 54h, 4Eh, 5Ah, 4, 53h, 45h, 54h, 4Fh
	db	4, 53h, 45h, 54h, 50h, 5, 53h, 45h, 54h, 50h, 45h, 5, 53h, 45h, 54h, 50h
	db	4Fh, 4, 53h, 45h, 54h, 53h, 4, 53h, 45h, 54h, 5Ah, 4, 43h, 57h, 44h, 45h
	db	5, 43h, 4Dh, 50h, 53h, 44h, 3, 43h, 44h, 51h, 4, 49h, 4Eh, 53h, 44h, 5
	db	49h, 52h, 45h, 54h, 44h, 5, 4Ch, 4Fh, 44h, 53h, 44h, 5, 4Dh, 4Fh, 56h, 53h
	db	44h, 5, 4Fh, 55h, 54h, 53h, 44h, 5, 50h, 4Fh, 50h, 41h, 44h, 5, 50h, 4Fh
	db	50h, 46h, 44h, 6, 50h, 55h, 53h, 48h, 41h, 44h, 6, 50h, 55h, 53h, 48h, 46h
	db	44h, 5, 53h, 43h, 41h, 53h, 44h, 5, 53h, 54h, 4Fh, 53h, 44h, 3, 4Ch, 53h
	db	53h, 3, 4Ch, 46h, 53h, 3, 4Ch, 47h, 53h, 5, 4Ch, 4Fh, 4Fh, 50h, 44h, 6
	db	4Ch, 4Fh, 4Fh, 50h, 44h, 45h, 6, 4Ch, 4Fh, 4Fh, 50h, 44h, 5Ah, 7, 4Ch, 4Fh
	db	4Fh, 50h, 44h, 4Eh, 45h, 7, 4Ch, 4Fh, 4Fh, 50h, 44h, 4Eh, 5Ah, 5, 4Ah, 45h
	db	43h, 58h, 5Ah, 6, 45h, 4Eh, 54h, 45h, 52h, 57h, 6, 45h, 4Eh, 54h, 45h, 52h
	db	44h, 6, 4Ch, 45h, 41h, 56h, 45h, 57h, 6, 4Ch, 45h, 41h, 56h, 45h, 44h, 5
	db	42h, 53h, 57h, 41h, 50h, 4, 58h, 41h, 44h, 44h, 7, 43h, 4Dh, 50h, 58h, 43h
	db	48h, 47h, 6, 3Fh, 44h, 45h, 42h, 55h, 47h, 5, 4Ch, 4Fh, 43h, 41h, 4Ch, 3
	db	41h, 52h, 47h, 4, 55h, 53h, 45h, 53h, 6, 41h, 53h, 53h, 55h, 4Dh, 45h, 5
	db	41h, 4Ch, 49h, 47h, 4Eh, 7, 44h, 49h, 53h, 50h, 4Ch, 41h, 59h, 6, 44h, 4Fh
	db	53h, 53h, 45h, 47h, 5, 4Dh, 4Fh, 44h, 45h, 4Ch, 7, 43h, 4Fh, 44h, 45h, 53h
	db	45h, 47h, 5, 53h, 54h, 41h, 43h, 4Bh, 5, 43h, 4Fh, 4Eh, 53h, 54h, 7, 44h
	db	41h, 54h, 41h, 53h, 45h, 47h, 8, 55h, 44h, 41h, 54h, 41h, 53h, 45h, 47h, 7
	db	46h, 41h, 52h, 44h, 41h, 54h, 41h, 8, 55h, 46h, 41h, 52h, 44h, 41h, 54h, 41h
	db	0Bh, 53h, 54h, 41h, 52h, 54h, 55h, 50h, 43h, 4Fh, 44h, 45h, 4, 45h, 56h, 45h
	db	4Eh, 8, 45h, 56h, 45h, 4Eh, 44h, 41h, 54h, 41h, 5, 45h, 58h, 49h, 54h, 4Dh
	db	4, 45h, 4Eh, 44h, 4Dh, 3, 45h, 52h, 52h, 5, 45h, 52h, 52h, 49h, 46h, 6
	db	45h, 52h, 52h, 49h, 46h, 45h, 6, 45h, 52h, 52h, 49h, 46h, 31h, 6, 45h, 52h
	db	52h, 49h, 46h, 32h, 6, 45h, 52h, 52h, 49h, 46h, 42h, 8, 45h, 52h, 52h, 49h
	db	46h, 44h, 45h, 46h, 8, 45h, 52h, 52h, 49h, 46h, 44h, 49h, 46h, 8, 45h, 52h
	db	52h, 49h, 46h, 49h, 44h, 4Eh, 7, 45h, 52h, 52h, 49h, 46h, 4Eh, 42h, 9, 45h
	db	52h, 52h, 49h, 46h, 4Eh, 44h, 45h, 46h, 9, 45h, 52h, 52h, 49h, 46h, 44h, 49h
	db	46h, 49h, 9, 45h, 52h, 52h, 49h, 46h, 49h, 44h, 4Eh, 49h, 4, 45h, 4Ch, 53h
	db	45h, 5, 45h, 4Eh, 44h, 49h, 46h, 3, 4Fh, 52h, 47h, 5, 52h, 41h, 44h, 49h
	db	58h, 5, 50h, 38h, 30h, 38h, 36h, 4, 50h, 31h, 38h, 36h, 5, 50h, 32h, 38h
	db	36h, 4Eh, 4, 50h, 32h, 38h, 36h, 5, 50h, 33h, 38h, 36h, 4Eh, 4, 50h, 33h
	db	38h, 36h, 5, 50h, 34h, 38h, 36h, 4Eh, 4, 50h, 34h, 38h, 36h, 5, 50h, 4Eh
	db	4Fh, 38h, 37h, 5, 50h, 38h, 30h, 38h, 37h, 4, 50h, 32h, 38h, 37h, 4, 50h
	db	33h, 38h, 37h, 8, 4Dh, 55h, 4Ch, 54h, 45h, 52h, 52h, 53h, 0Ah, 4Eh, 4Fh, 4Dh
	db	55h, 4Ch, 54h, 45h, 52h, 52h, 53h, 4, 57h, 41h, 52h, 4Eh, 6, 4Eh, 4Fh, 57h
	db	41h, 52h, 4Eh, 6, 4Dh, 41h, 53h, 4Dh, 35h, 31h, 8, 4Eh, 4Fh, 4Dh, 41h, 53h
	db	4Dh, 35h, 31h, 4, 45h, 4Dh, 55h, 4Ch, 6, 4Eh, 4Fh, 45h, 4Dh, 55h, 4Ch, 5
	db	49h, 44h, 45h, 41h, 4Ch, 4, 4Dh, 41h, 53h, 4Dh, 6, 51h, 55h, 49h, 52h, 4Bh
	db	53h, 5, 4Ah, 55h, 4Dh, 50h, 53h, 7, 4Eh, 4Fh, 4Ah, 55h, 4Dh, 50h, 53h, 5
	db	53h, 4Dh, 41h, 52h, 54h, 7, 4Eh, 4Fh, 53h, 4Dh, 41h, 52h, 54h, 6, 4Ch, 4Fh
	db	43h, 41h, 4Ch, 53h, 8, 4Eh, 4Fh, 4Ch, 4Fh, 43h, 41h, 4Ch, 53h, 5, 4Dh, 41h
	db	43h, 52h, 4Fh, 4, 52h, 45h, 50h, 54h, 3, 49h, 52h, 50h, 4, 49h, 52h, 50h
	db	43h, 5, 50h, 55h, 52h, 47h, 45h, 5, 53h, 54h, 52h, 55h, 43h, 5, 55h, 4Eh
	db	49h, 4Fh, 4Eh, 6, 52h, 45h, 43h, 4Fh, 52h, 44h, 7, 53h, 45h, 47h, 4Dh, 45h
	db	4Eh, 54h, 4, 45h, 4Eh, 44h, 53h, 4, 50h, 52h, 4Fh, 43h, 4, 45h, 4Eh, 44h
	db	50h, 5, 4Ch, 41h, 42h, 45h, 4Ch, 5, 47h, 52h, 4Fh, 55h, 50h, 3, 45h, 4Eh
	db	44h, 8, 25h, 54h, 41h, 42h, 53h, 49h, 5Ah, 45h, 5, 25h, 43h, 52h, 45h, 46h
	db	5, 25h, 4Ch, 49h, 53h, 54h, 7, 25h, 4Eh, 4Fh, 43h, 52h, 45h, 46h, 7, 25h
	db	4Eh, 4Fh, 4Ch, 49h, 53h, 54h, 5, 25h, 4Dh, 41h, 43h, 53h, 6, 25h, 43h, 4Fh
	db	4Eh, 44h, 53h, 7, 25h, 4Eh, 4Fh, 4Dh, 41h, 43h, 53h, 8, 25h, 4Eh, 4Fh, 43h
	db	4Fh, 4Eh, 44h, 53h, 5, 25h, 49h, 4Eh, 43h, 4Ch, 7, 25h, 4Eh, 4Fh, 49h, 4Eh
	db	43h, 4Ch, 8, 25h, 43h, 52h, 45h, 46h, 41h, 4Ch, 4Ch, 8, 25h, 43h, 52h, 45h
	db	46h, 52h, 45h, 46h, 9, 25h, 43h, 52h, 45h, 46h, 55h, 52h, 45h, 46h, 4, 25h
	db	54h, 4Fh, 43h, 6, 25h, 4Eh, 4Fh, 54h, 4Fh, 43h, 5, 25h, 53h, 59h, 4Dh, 53h
	db	7, 25h, 4Eh, 4Fh, 53h, 59h, 4Dh, 53h, 5, 25h, 43h, 54h, 4Ch, 53h, 7, 25h
	db	4Eh, 4Fh, 43h, 54h, 4Ch, 53h, 6, 25h, 54h, 52h, 55h, 4Eh, 43h, 8, 25h, 4Eh
	db	4Fh, 54h, 52h, 55h, 4Eh, 43h, 9, 25h, 50h, 55h, 53h, 48h, 4Ch, 43h, 54h, 4Ch
	db	8, 25h, 50h, 4Fh, 50h, 4Ch, 43h, 54h, 4Ch, 8, 25h, 4Eh, 45h, 57h, 50h, 41h
	db	47h, 45h, 9, 25h, 50h, 41h, 47h, 45h, 53h, 49h, 5Ah, 45h, 6, 25h, 54h, 49h
	db	54h, 4Ch, 45h, 7, 25h, 53h, 55h, 42h, 54h, 54h, 4Ch, 6, 25h, 44h, 45h, 50h
	db	54h, 48h, 6, 25h, 4Ch, 49h, 4Eh, 55h, 4Dh, 5, 25h, 50h, 43h, 4Eh, 54h, 4
	db	25h, 42h, 49h, 4Eh, 5, 25h, 54h, 45h, 58h, 54h, 5, 2Eh, 38h, 30h, 38h, 36h
	db	4, 2Eh, 31h, 38h, 36h, 4, 2Eh, 32h, 38h, 36h, 5, 2Eh, 32h, 38h, 36h, 50h
	db	5, 2Eh, 32h, 38h, 36h, 43h, 4, 2Eh, 33h, 38h, 36h, 5, 2Eh, 33h, 38h, 36h
	db	50h, 5, 2Eh, 33h, 38h, 36h, 43h, 4, 2Eh, 34h, 38h, 36h, 5, 2Eh, 34h, 38h
	db	36h, 50h, 5, 2Eh, 34h, 38h, 36h, 43h, 5, 2Eh, 38h, 30h, 38h, 37h, 4, 2Eh
	db	32h, 38h, 37h, 4, 2Eh, 33h, 38h, 37h, 4, 50h, 41h, 47h, 45h, 5, 2Eh, 4Ch
	db	49h, 53h, 54h, 6, 2Eh, 58h, 4Ch, 49h, 53h, 54h, 5, 2Eh, 43h, 52h, 45h, 46h
	db	6, 2Eh, 58h, 43h, 52h, 45h, 46h, 5, 2Eh, 4Ch, 41h, 4Ch, 4Ch, 5, 2Eh, 58h
	db	41h, 4Ch, 4Ch, 5, 2Eh, 53h, 41h, 4Ch, 4Ch, 7, 2Eh, 4Ch, 46h, 43h, 4Fh, 4Eh
	db	44h, 7, 2Eh, 53h, 46h, 43h, 4Fh, 4Eh, 44h, 7, 2Eh, 54h, 46h, 43h, 4Fh, 4Eh
	db	44h, 6, 2Eh, 52h, 41h, 44h, 49h, 58h, 6, 2Eh, 4Dh, 4Fh, 44h, 45h, 4Ch, 6
	db	2Eh, 53h, 54h, 41h, 43h, 4Bh, 5, 2Eh, 43h, 4Fh, 44h, 45h, 5, 2Eh, 44h, 41h
	db	54h, 41h, 6, 2Eh, 44h, 41h, 54h, 41h, 3Fh, 8, 2Eh, 46h, 41h, 52h, 44h, 41h
	db	54h, 41h, 9, 2Eh, 46h, 41h, 52h, 44h, 41h, 54h, 41h, 3Fh, 8, 2Eh, 53h, 54h
	db	41h, 52h, 54h, 55h, 50h, 6, 2Eh, 43h, 4Fh, 4Eh, 53h, 54h, 6, 2Eh, 41h, 4Ch
	db	50h, 48h, 41h, 4, 2Eh, 53h, 45h, 51h, 81h, 3Ch, 81h, 3Eh, 1, 3Fh, 5, 4Dh
	db	41h, 43h, 52h, 4Fh, 4, 52h, 45h, 50h, 54h, 3, 49h, 52h, 50h, 4, 49h, 52h
	db	50h, 43h, 1, 25h, 4, 45h, 4Eh, 44h, 4Dh, 5, 4Ch, 4Fh, 43h, 41h, 4Ch, 7
	db	52h, 45h, 54h, 55h, 52h, 4Eh, 53h, 2, 40h, 40h, 2, 40h, 42h, 2, 40h, 46h
	db	9, 40h, 43h, 6Fh, 64h, 65h, 53h, 69h, 7Ah, 65h, 9, 40h, 44h, 61h, 74h, 61h
	db	53h, 69h, 7Ah, 65h, 9, 40h, 46h, 69h, 6Ch, 65h, 4Eh, 61h, 6Dh, 65h, 4, 40h
	db	43h, 70h, 75h, 9, 40h, 57h, 6Fh, 72h, 64h, 53h, 69h, 7Ah, 65h, 6, 40h, 4Dh
	db	6Fh, 64h, 65h, 6Ch, 7, 40h, 63h, 75h, 72h, 73h, 65h, 67h, 5, 40h, 63h, 6Fh
	db	64h, 65h, 5, 40h, 64h, 61h, 74h, 61h, 8, 40h, 66h, 61h, 72h, 64h, 61h, 74h
	db	61h, 9, 40h, 66h, 61h, 72h, 64h, 61h, 74h, 61h, 3Fh, 4, 43h, 4Fh, 44h, 45h
	db	4, 44h, 41h, 54h, 41h, 5, 43h, 4Fh, 4Eh, 53h, 54h, 3, 42h, 53h, 53h, 5
	db	53h, 54h, 41h, 43h, 4Bh, 8, 46h, 41h, 52h, 5Fh, 44h, 41h, 54h, 41h, 7, 46h
	db	41h, 52h, 5Fh, 42h, 53h, 53h, 5, 5Fh, 54h, 45h, 58h, 54h, 5, 5Fh, 44h, 41h
	db	54h, 41h, 4, 5Fh, 42h, 53h, 53h, 6, 44h, 47h, 52h, 4Fh, 55h, 50h, 4, 42h
	db	59h, 54h, 45h, 4, 57h, 4Fh, 52h, 44h, 5, 44h, 57h, 4Fh, 52h, 44h, 4, 50h
	db	41h, 52h, 41h, 4, 50h, 41h, 47h, 45h, 7, 50h, 52h, 49h, 56h, 41h, 54h, 45h
	db	6, 50h, 55h, 42h, 4Ch, 49h, 43h, 5, 53h, 54h, 41h, 43h, 4Bh, 6, 43h, 4Fh
	db	4Dh, 4Dh, 4Fh, 4Eh, 6, 4Dh, 45h, 4Dh, 4Fh, 52h, 59h, 2, 41h, 54h, 5, 55h
	db	53h, 45h, 31h, 36h, 5, 55h, 53h, 45h, 33h, 32h, 7, 56h, 49h, 52h, 54h, 55h
	db	41h, 4Ch, 7, 4Dh, 45h, 4Dh, 50h, 41h, 47h, 45h, 8, 52h, 45h, 41h, 44h, 4Fh
	db	4Eh, 4Ch, 59h, 8, 45h, 58h, 45h, 43h, 4Fh, 4Eh, 4Ch, 59h, 8, 45h, 58h, 45h
	db	43h, 52h, 45h, 41h, 44h, 9, 52h, 45h, 41h, 44h, 57h, 52h, 49h, 54h, 45h, 8
	db	46h, 41h, 52h, 53h, 54h, 41h, 43h, 4Bh, 9, 4Eh, 45h, 41h, 52h, 53h, 54h, 41h
	db	43h, 4Bh, 4, 54h, 49h, 4Eh, 59h, 5, 53h, 4Dh, 41h, 4Ch, 4Ch, 6, 4Dh, 45h
	db	44h, 49h, 55h, 4Dh, 7, 43h, 4Fh, 4Dh, 50h, 41h, 43h, 54h, 5, 4Ch, 41h, 52h
	db	47h, 45h, 4, 48h, 55h, 47h, 45h, 6, 54h, 43h, 48h, 55h, 47h, 45h, 7, 54h
	db	50h, 41h, 53h, 43h, 41h, 4Ch, 1, 43h, 1, 42h, 1, 45h, 1, 4Ch, 1, 53h
	db	1, 46h, 3, 42h, 52h, 4Bh, 3, 50h, 52h, 4Fh, 3, 49h, 43h, 47h, 3, 50h
	db	44h, 43h, 3, 41h, 53h, 53h, 3, 4Fh, 50h, 53h, 3, 4Fh, 50h, 50h, 3, 4Fh
	db	50h, 49h, 3, 4Ch, 43h, 4Fh, 3, 4Fh, 56h, 46h, 3, 52h, 45h, 53h, 3, 54h
	db	50h, 49h, 3, 50h, 51h, 4Bh, 3, 41h, 4Ch, 4Eh, 3, 47h, 54h, 50h, 3, 4Dh
	db	43h, 50h, 1, 43h, 5, 42h, 41h, 53h, 49h, 43h, 7, 46h, 4Fh, 52h, 54h, 52h
	db	41h, 4Eh, 6, 50h, 41h, 53h, 43h, 41h, 4Ch, 0Ah, 4Eh, 4Fh, 4Ch, 41h, 4Eh, 47h
	db	55h, 41h, 47h, 45h, 6, 50h, 52h, 4Fh, 4Ch, 4Fh, 47h, 6, 4Eh, 4Fh, 52h, 4Dh
	db	41h, 4Ch, 7, 57h, 49h, 4Eh, 44h, 4Fh, 57h, 53h, 7, 4Fh, 44h, 44h, 4Eh, 45h
	db	41h, 52h, 6, 4Fh, 44h, 44h, 46h, 41h, 52h, 7, 53h, 49h, 5Ah, 45h, 53h, 54h
	db	52h, 6, 43h, 41h, 54h, 53h, 54h, 52h, 6, 53h, 55h, 42h, 53h, 54h, 52h, 5
	db	49h, 4Eh, 53h, 54h, 52h, 81h, 3Ah, 81h, 3Dh, 2, 44h, 42h, 2, 44h, 57h, 2
	db	44h, 44h, 3, 45h, 51h, 55h, 2, 44h, 51h, 2, 44h, 50h, 2, 44h, 46h, 2
	db	44h, 54h, 4, 50h, 52h, 4Fh, 43h, 4, 45h, 4Eh, 44h, 50h, 5, 4Ch, 41h, 42h
	db	45h, 4Ch, 7, 53h, 45h, 47h, 4Dh, 45h, 4Eh, 54h, 4, 45h, 4Eh, 44h, 53h, 5
	db	47h, 52h, 4Fh, 55h, 50h, 5, 4Dh, 41h, 43h, 52h, 4Fh, 5, 53h, 54h, 52h, 55h
	db	43h, 6, 52h, 45h, 43h, 4Fh, 52h, 44h, 5, 55h, 4Eh, 49h, 4Fh, 4Eh, 81h, 5Dh
	db	3, 44h, 55h, 50h, 1, 2Eh, 81h, 29h, 81h, 2Ch, 1, 24h, 3, 41h, 42h, 53h
	db	4, 55h, 53h, 45h, 53h, 2, 53h, 54h, 7, 4Eh, 4Fh, 54h, 48h, 49h, 4Eh, 47h
	db	3, 50h, 54h, 52h, 7, 55h, 4Eh, 4Bh, 4Eh, 4Fh, 57h, 4Eh, 4, 42h, 59h, 54h
	db	45h, 4, 57h, 4Fh, 52h, 44h, 5, 44h, 57h, 4Fh, 52h, 44h, 5, 51h, 57h, 4Fh
	db	52h, 44h, 5, 50h, 57h, 4Fh, 52h, 44h, 5, 46h, 57h, 4Fh, 52h, 44h, 5, 54h
	db	42h, 59h, 54h, 45h, 5, 53h, 48h, 4Fh, 52h, 54h, 4, 4Eh, 45h, 41h, 52h, 3
	db	46h, 41h, 52h, 4, 50h, 52h, 4Fh, 43h, 7, 44h, 41h, 54h, 41h, 50h, 54h, 52h
	db	7, 43h, 4Fh, 44h, 45h, 50h, 54h, 52h, 5, 2Eh, 54h, 59h, 50h, 45h, 5, 53h
	db	48h, 4Fh, 52h, 54h, 5, 53h, 4Dh, 41h, 4Ch, 4Ch, 5, 4Ch, 41h, 52h, 47h, 45h
	db	7, 53h, 59h, 4Dh, 54h, 59h, 50h, 45h, 2, 4Fh, 52h, 3, 58h, 4Fh, 52h, 3
	db	41h, 4Eh, 44h, 3, 4Eh, 4Fh, 54h, 2, 45h, 51h, 2, 4Eh, 45h, 2, 4Ch, 54h
	db	2, 4Ch, 45h, 2, 47h, 54h, 2, 47h, 45h, 81h, 2Bh, 81h, 2Dh, 81h, 2Ah, 81h
	db	2Fh, 3, 4Dh, 4Fh, 44h, 3, 53h, 48h, 4Ch, 3, 53h, 48h, 52h, 4, 54h, 59h
	db	50h, 45h, 4, 48h, 49h, 47h, 48h, 3, 4Ch, 4Fh, 57h, 6, 4Fh, 46h, 46h, 53h
	db	45h, 54h, 3, 53h, 45h, 47h, 4, 54h, 48h, 49h, 53h, 81h, 5Bh, 81h, 28h, 6
	db	4Ch, 45h, 4Eh, 47h, 54h, 48h, 4, 53h, 49h, 5Ah, 45h, 4, 4Dh, 41h, 53h, 4Bh
	db	5, 57h, 49h, 44h, 54h, 48h, 2, 41h, 4Ch, 2, 43h, 4Ch, 2, 44h, 4Ch, 2
	db	42h, 4Ch, 2, 41h, 48h, 2, 43h, 48h, 2, 44h, 48h, 2, 42h, 48h, 3, 45h
	db	41h, 58h, 3, 45h, 43h, 58h, 3, 45h, 44h, 58h, 3, 45h, 42h, 58h, 3, 45h
	db	53h, 50h, 3, 45h, 42h, 50h, 3, 45h, 53h, 49h, 3, 45h, 44h, 49h, 3, 43h
	db	52h, 30h, 3, 43h, 52h, 32h, 3, 43h, 52h, 33h, 3, 44h, 52h, 30h, 3, 44h
	db	52h, 31h, 3, 44h, 52h, 32h, 3, 44h, 52h, 33h, 3, 44h, 52h, 36h, 3, 44h
	db	52h, 37h, 3, 54h, 52h, 33h, 3, 54h, 52h, 34h, 3, 54h, 52h, 35h, 3, 54h
	db	52h, 36h, 3, 54h, 52h, 37h, 2, 41h, 58h, 2, 43h, 58h, 2, 44h, 58h, 2
	db	42h, 58h, 2, 53h, 50h, 2, 42h, 50h, 2, 53h, 49h, 2, 44h, 49h, 2, 45h
	db	53h, 2, 43h, 53h, 2, 53h, 53h, 2, 44h, 53h, 2, 46h, 53h, 2, 47h, 53h
	db	4, 42h, 59h, 54h, 45h, 4, 57h, 4Fh, 52h, 44h, 5, 44h, 57h, 4Fh, 52h, 44h
	db	5, 51h, 57h, 4Fh, 52h, 44h, 5, 50h, 57h, 4Fh, 52h, 44h, 5, 46h, 57h, 4Fh
	db	52h, 44h, 5, 54h, 42h, 59h, 54h, 45h, 4, 4Eh, 45h, 41h, 52h, 3, 46h, 41h
	db	52h, 1, 3Fh, 2, 44h, 53h, 2, 53h, 53h, 2, 45h, 53h, 2, 43h, 53h, 2
	db	46h, 53h, 2, 47h, 53h, 6, 46h, 49h, 57h, 52h, 51h, 51h, 6, 46h, 49h, 44h
	db	52h, 51h, 51h, 6, 46h, 49h, 41h, 52h, 51h, 51h, 6, 46h, 49h, 43h, 52h, 51h
	db	51h, 6, 46h, 49h, 45h, 52h, 51h, 51h, 6, 46h, 49h, 53h, 52h, 51h, 51h, 6
	db	46h, 49h, 46h, 52h, 51h, 51h, 6, 46h, 49h, 47h, 52h, 51h, 51h, 6, 46h, 4Ah
	db	41h, 52h, 51h, 51h, 6, 46h, 4Ah, 43h, 52h, 51h, 51h, 6, 46h, 4Ah, 53h, 52h
	db	51h, 51h, 6, 46h, 4Ah, 46h, 52h, 51h, 51h, 6, 46h, 4Ah, 47h, 52h, 51h, 51h
	db	3, 41h, 44h, 44h, 3, 53h, 55h, 42h, 3, 43h, 4Dh, 50h, 3, 4Dh, 4Fh, 56h
	db	3, 4Ah, 4Dh, 50h, 4, 43h, 41h, 4Ch, 4Ch, 4, 50h, 55h, 53h, 48h, 3, 50h
	db	4Fh, 50h
SEG5	ends

SEG5	segment para public 'DATA'
	db	2640h dup (?)	;@19DB0
SEG5	ends
	end	start
