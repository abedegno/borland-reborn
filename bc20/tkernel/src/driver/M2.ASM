	.286p
	locals
S000	segment byte public 'CODE'
S000	ends
S50A	segment para public 'CODE'
S50A	ends
S589	segment para public 'CODE'
S589	ends
S59F	segment para public 'CODE'
S59F	ends
S5AD	segment para public 'CODE'
S5AD	ends
S5ED	segment para public 'CODE'
S5ED	ends
S5FD	segment para public 'CODE'
S5FD	ends
S8EF	segment para public 'CODE'
S8EF	ends
S8F6	segment para public 'CODE'
S8F6	ends
S908	segment para public 'CODE'
S908	ends
S9CF	segment para public 'CODE'
S9CF	ends
S9D2	segment para stack 'CODE'
S9D2	ends
S9F3	segment para public 'CODE'
S9F3	ends
S9FA	segment byte public 'CODE'
S9FA	ends
SBB9	segment para public 'CODE'
SBB9	ends
SD33	segment para public 'BSS'
SD33	ends

	public	L00000
	public	L003A7
	public	L01690
	public	L02737
	public	L04394
	public	L04437
	public	L04640
	public	L04677
	public	L046D3
	public	L047F0
	public	L0A7E4
	public	L0B739
	extrn	L048E0:far
	extrn	L04992:near
	extrn	L049DA:near
	extrn	L04AEF:near
	extrn	L04B40:near
	extrn	L04B8F:near
	extrn	L04D3D:near
	extrn	L050A0:byte
	extrn	L054E8:far
	extrn	S589_START:byte
	extrn	S59F_START:byte
	extrn	S5FD_START:byte
	extrn	L09CF0:far
	extrn	L0A471:byte
	extrn	L0B7DD:far
	extrn	L0BA72:far

S000	segment byte public 'CODE'
	assume	cs:S000
L00000	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45h, 4Dh, 4Dh, 58h, 58h, 58h	;@00000
	db	58h, 30h, 80h, 0FCh, 44h, 74h, 28h, 80h, 0FCh, 45h, 74h, 23h, 80h, 0FCh, 48h, 74h
	db	1Eh, 80h, 0FCh, 4Eh, 74h, 19h, 80h, 0FCh, 4Fh, 74h, 14h, 80h, 0FCh, 50h, 74h, 0Fh
	db	80h, 0FCh, 55h, 74h, 0Ah, 80h, 0FCh, 56h, 74h, 5, 2Eh, 0FFh, 2Eh, 0, 0, 2Eh
	db	0C6h, 6, 4, 0, 1, 2Eh, 0FFh, 2Eh, 0, 0, 0, 0, 0, 0, 0, 0
	db	0FFh, 0FFh, 0FFh, 0FFh, 0, 0C8h, 44h, 0, 53h, 0, 41h, 49h, 41h, 5Fh, 4Fh, 53h
	db	20h, 20h, 0, 49h, 41h, 42h, 48h, 50h, 55h, 48h, 55h, 4Dh, 4Dh, 49h, 4Eh, 47h
	db	42h, 0, 0E0h, 0, 0E0h, 0, 0E0h, 0, 0E0h, 0, 65h, 2, 0E0h, 0, 0E0h, 0
	db	0E0h, 0, 0E0h, 0, 0E0h, 0, 23h, 2, 0E0h, 0, 0E3h, 0, 27h, 2, 27h, 2
	db	0E0h, 0, 0E0h, 0, 2Eh, 89h, 1Eh, 9Fh, 0, 2Eh, 8Ch, 6, 0A1h, 0, 0CBh, 0
	db	0, 0, 0, 53h, 51h, 52h, 56h, 57h, 1Eh, 6, 0Eh, 1Fh, 2Eh, 0C4h, 3Eh, 9Fh
	db	0, 26h, 8Ah, 5Dh, 2, 32h, 0FFh, 83h, 0FBh, 10h, 76h, 9, 26h, 0C7h, 45h, 3
	db	3, 81h, 0EBh, 14h, 90h, 0D1h, 0E3h, 2Eh, 0FFh, 97h, 72h, 0, 2Eh, 0C4h, 3Eh, 9Fh
	db	0, 0Dh, 0, 1, 26h, 89h, 45h, 3, 7, 1Fh, 5Fh, 5Eh, 5Ah, 59h, 5Bh, 0CBh
	db	33h, 0C0h, 0C3h, 6, 57h, 1Eh, 56h, 26h, 0C4h, 7Dh, 0Eh, 26h, 8Ah, 25h, 26h, 0C7h
	db	5, 49h, 41h, 26h, 0C7h, 45h, 2, 42h, 48h, 80h, 0FCh, 81h, 75h, 3, 0EBh, 23h
	db	90h, 80h, 0FCh, 82h, 75h, 0Fh, 26h, 0C7h, 45h, 4, 88h, 0Eh, 26h, 0C7h, 45h, 6
	dw	seg L00000
	db	0EBh, 0Fh, 90h, 80h, 0FCh, 84h, 75h, 6, 0E8h, 15h, 0, 0EBh, 4, 90h, 0EBh, 8
	db	90h, 33h, 0C0h, 5Eh, 1Fh, 5Fh, 7, 0C3h, 0B8h, 0Ch, 0, 5Eh, 1Fh, 5Fh, 7, 0C3h
	db	50h, 1Eh, 6, 52h, 56h, 57h, 2Eh, 0A1h, 21h, 2, 26h, 89h, 45h, 8, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 33h, 0C0h, 83h, 3Eh, 9, 1, 0, 74h, 3, 0A1h, 7, 1, 26h, 89h
	db	45h, 0Ah, 33h, 0C0h, 6, 0B8h
	dw	seg S5FD_START
	db	8Eh, 0C0h, 26h, 83h, 3Eh, 4Dh, 0, 0, 7, 74h, 6, 0E8h, 7, 4Eh, 0EBh, 35h
	db	90h, 2Eh, 83h, 3Eh, 0E5h, 0Eh, 0, 74h, 1Dh, 0B4h, 0Dh, 2Eh, 8Bh, 16h, 0E5h, 0Eh
	db	2Eh, 0FFh, 1Eh, 0E1h, 0Eh, 0B4h, 0Ah, 2Eh, 8Bh, 16h, 0E5h, 0Eh, 2Eh, 0FFh, 1Eh, 0E1h
	db	0Eh, 33h, 0C0h, 0EBh, 10h, 90h, 80h, 3Eh, 4Dh, 0, 0, 74h, 6, 0E8h, 4Ah, 0
	db	0EBh, 3, 90h, 33h, 0C0h, 26h, 89h, 45h, 4, 2Eh, 0A1h, 1Fh, 2, 26h, 89h, 45h
	db	6, 0B8h, 0, 62h, 0CDh, 21h, 53h, 2Eh, 8Bh, 1Eh, 1Fh, 2, 0B8h, 0, 50h, 0CDh
	db	21h, 0BBh, 0, 0, 0B8h, 0, 3Eh, 0CDh, 21h, 0BBh, 1, 0, 0B8h, 0, 3Eh, 0CDh
	db	21h, 0BBh, 2, 0, 0B8h, 0, 3Eh, 0CDh, 21h, 5Bh, 0B8h, 0, 50h, 0CDh, 21h, 2Eh
	db	0A1h, 1Fh, 2, 5Fh, 5Eh, 5Ah, 7, 1Fh, 58h, 0C3h, 6, 53h, 51h, 1Eh, 52h, 33h
	db	0C0h, 8Eh, 0D8h, 8Bh, 0Eh, 54h, 0, 8Bh, 16h, 56h, 0, 81h, 0FAh
	dw	seg L00000
	db	75h, 1Ah, 81h, 0F9h, 7Fh, 12h, 75h, 14h, 2Eh, 0A1h, 79h, 12h, 0A3h, 54h, 0, 2Eh
	db	0A1h, 7Bh, 12h, 0A3h, 56h, 0, 0B8h, 0, 0, 0EBh, 4, 90h, 0B8h, 1, 0, 5Ah
	db	1Fh, 59h, 5Bh, 7, 0C3h, 0, 0, 0, 0, 0B8h, 0, 0, 0C3h, 33h, 0C0h, 0C3h
	db	2Eh, 2
	dw	seg L00000
	db	41h, 2Eh, 49h, 2Eh, 41h, 72h, 63h, 68h, 69h, 74h, 65h, 63h, 74h, 73h, 20h, 50h
	db	72h, 6Fh, 74h, 65h, 63h, 74h, 65h, 64h, 20h, 4Dh, 6Fh, 64h, 65h, 20h, 44h, 72h
	db	69h, 76h, 65h, 72h, 20h, 20h, 76h, 65h, 72h, 73h, 69h, 6Fh, 6Eh, 20h, 32h, 2Eh
	db	30h, 2Eh, 33h, 34h, 0Ah, 0Dh, 1Ah, 6, 57h, 1Eh, 56h, 51h, 2Eh, 81h, 3Eh, 2Ah
	db	2, 65h, 2, 72h, 7, 2Eh, 0C7h, 6, 2Ah, 2, 2Eh, 2, 26h, 8Bh, 4Dh, 12h
	db	26h, 0C4h, 7Dh, 0Eh, 2Eh, 0C5h, 36h, 2Ah, 2, 2Eh, 1, 0Eh, 2Ah, 2, 0FCh, 0F3h
	db	0A4h, 33h, 0C0h, 59h, 5Eh, 1Fh, 5Fh, 7, 0C3h, 0, 0, 0, 0, 3Dh, 0A1h, 0FBh
	db	74h, 5, 2Eh, 0FFh, 2Eh, 97h, 2, 55h, 8Bh, 0ECh, 26h, 0C7h, 5, 49h, 41h, 26h
	db	0C7h, 45h, 2, 42h, 48h, 81h, 0FBh, 81h, 0, 75h, 3, 0EBh, 4Dh, 90h, 81h, 0FBh
	db	82h, 0, 75h, 0Fh, 26h, 0C7h, 45h, 4, 88h, 0Eh, 26h, 0C7h, 45h, 6
	dw	seg L00000
	db	0EBh, 38h, 90h, 81h, 0FBh, 84h, 0, 75h, 31h, 50h, 52h, 1Eh, 6, 53h, 33h, 0C0h
	db	8Eh, 0D8h, 8Ch, 0C8h, 3Bh, 6, 0BEh, 0, 74h, 9, 26h, 0C7h, 45h, 4, 1, 0
	db	0EBh, 13h, 90h, 0E8h, 3Eh, 0FEh, 2Eh, 8Bh, 16h, 97h, 2, 2Eh, 8Eh, 1Eh, 99h, 2
	db	0B8h, 2Fh, 25h, 0CDh, 21h, 5Bh, 7, 1Fh, 5Ah, 58h, 80h, 66h, 6, 0FEh, 5Dh, 0CFh
	db	0, 0, 0FFh, 0FFh, 0FFh, 0FFh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0FFh, 0FFh
L003A7:	mov	ax, seg L00000	;@003A7
	mov	bx, 0E88h	;@003AA
	mov	word ptr cs:L00000+859, bx	;@003AD
	mov	word ptr cs:L00000+861, ax	;@003B2
	mov	byte ptr cs:L00000+784, 0	;@003B6
	mov	ds, ax	;@003BC
	db	0E8h, 0B4h, 5	; call L00975	;@003BE
	db	73h, 35h	; jae @@2	;@003C1
	push	cs	;@003C3
	pop	ds	;@003C4
	db	0EBh, 2Bh	; jmp @@1	;@003C5
	db	90h, 'hb: panic - kernel is not bound to driver$'	;@003C7
@@1:	db	0BAh, 0C8h, 3	; mov dx, 3C8h	;@003F2
	db	0E9h, 0D2h, 0	; jmp L004CA	;@003F5
@@2:	db	0E8h, 0D1h, 3	; call L007CC	;@003F8
	mov	ax, 2	;@003FB
	push	ax	;@003FE
	mov	ax, 0	;@003FF
	or	ax, 8000h	;@00402
	call	dword ptr cs:L00000+859	;@00405
	add	sp, 2	;@0040A
	retf	;@0040D
L0040E:	push	ds	;@0040E
	push	es	;@0040F
	push	si	;@00410
	push	di	;@00411
	push	cs	;@00412
	pop	ds	;@00413
	db	0E8h, 5Eh, 5	; call L00975	;@00414
	jae	@@1	;@00417
	pop	di	;@00419
	pop	si	;@0041A
	pop	es	;@0041B
	pop	ds	;@0041C
	ret	;@0041D
@@1:	db	0E8h, 97h, 4	; call L008B8	;@0041E
	mov	ax, word ptr ds:[39Dh]	;@00421
	mov	word ptr cs:L00000+796, ax	;@00424
	clc	;@00428
	pop	di	;@00429
	pop	si	;@0042A
	pop	es	;@0042B
	pop	ds	;@0042C
	ret	;@0042D
L0042E:	push	es	;@0042E
	push	ds	;@0042F
	push	si	;@00430
	mov	word ptr ds:[363h], bx	;@00431
	mov	word ptr ds:[365h], ax	;@00435
	mov	cx, ax	;@00438
	mov	dx, bx	;@0043A
	mov	bx, word ptr ds:[3A5h]	;@0043C
	xor	al, al	;@00440
	mov	ah, 42h	;@00442
	int	21h	;@00444
	db	73h, 16h	; jae @@2	;@00446
	push	cs	;@00448
	pop	ds	;@00449
	db	0EBh, 0Ch	; jmp @@1	;@0044A
	db	90h, 'seek error$'	;@0044C
@@1:	db	0BAh, 4Dh, 4	; mov dx, 44Dh	;@00458
	db	0EBh, 6Dh	; jmp L004CA	;@0045B
	db	90h	;@0045D
@@2:	mov	cx, 24h	;@0045E
	mov	dx, 377h	;@00461
	mov	ah, 3Fh	;@00464
	int	21h	;@00466
	db	73h, 21h	; jae @@4	;@00468
	push	cs	;@0046A
	pop	ds	;@0046B
	db	0EBh, 17h	; jmp @@3	;@0046C
	db	90h, 'Failed reading header$'	;@0046E
@@3:	db	0BAh, 6Fh, 4	; mov dx, 46Fh	;@00485
	db	0EBh, 40h	; jmp L004CA	;@00488
	db	90h	;@0048A
@@4:	mov	ax, word ptr ds:[377h]	;@0048B
	cmp	ax, 5A4Dh	;@0048E
	db	74h, 25h	; je @@6	;@00491
	push	cs	;@00493
	pop	ds	;@00494
	db	0EBh, 1Bh	; jmp @@5	;@00495
	db	90h, 'Not an exe file signature$'	;@00497
@@5:	db	0BAh, 98h, 4	; mov dx, 498h	;@004B2
	jmp	L004CA	;@004B5
@@6:	call	L004D3	;@004B8
	mov	ax, word ptr ds:[38Dh]	;@004BB
	add	ax, word ptr ds:[39Dh]	;@004BE
	mov	bx, word ptr ds:[38Bh]	;@004C2
	pop	si	;@004C6
	pop	ds	;@004C7
	pop	es	;@004C8
	ret	;@004C9
L004CA:	mov	ah, 9	;@004CA
	int	21h	;@004CC
	mov	ah, 4Ch	;@004CE
	int	21h	;@004D0
	hlt	;@004D2
L004D3:	call	@@4	;@004D3
	db	0E8h, 0Fh, 1	; call @@14	;@004D6
	db	0E8h, 29h, 2	; call @@25	;@004D9
	ret	;@004DC
@@1:	mov	bx, word ptr ds:[37Fh]	;@004DD
	mov	al, 4	;@004E1
	db	0E8h, 0EAh, 8	; call L00DD0	;@004E3
	push	ax	;@004E6
	push	bx	;@004E7
	mov	bx, word ptr ds:[37Bh]	;@004E8
	cmp	word ptr ds:[379h], 0	;@004EC
	jne	@@2	;@004F1
	mov	al, 9	;@004F3
	db	0E8h, 0D8h, 8	; call L00DD0	;@004F5
	jmp	@@3	;@004F8
@@2:	dec	bx	;@004FB
	mov	al, 9	;@004FC
	db	0E8h, 0CFh, 8	; call L00DD0	;@004FE
	add	bx, word ptr ds:[379h]	;@00501
	adc	ax, 0	;@00505
@@3:	pop	dx	;@00508
	pop	cx	;@00509
	sub	bx, dx	;@0050A
	sbb	ax, cx	;@0050C
	ret	;@0050E
@@4:	push	es	;@0050F
	call	@@1	;@00510
	mov	word ptr ds:[34Ch], bx	;@00513
	mov	word ptr ds:[34Eh], ax	;@00517
	push	ax	;@0051A
	push	bx	;@0051B
	mov	bx, word ptr ds:[381h]	;@0051C
	mov	al, 4	;@00520
	db	0E8h, 0ABh, 8	; call L00DD0	;@00522
	pop	dx	;@00525
	pop	cx	;@00526
	add	bx, dx	;@00527
	adc	ax, cx	;@00529
	add	bx, 0Fh	;@0052B
	adc	ax, 0	;@0052E
	push	cx	;@00531
	mov	cl, 4	;@00532
	db	0E8h, 8Ah, 8	; call L00DC1	;@00534
	pop	cx	;@00537
	mov	word ptr ds:[39Fh], bx	;@00538
	add	bx, word ptr ds:[39Bh]	;@0053C
	mov	cx, bx	;@00540
	cmp	byte ptr ds:[35Ah], 0	;@00542
	jne	@@5	;@00547
	db	0EBh, 4Bh	; jmp @@9	;@00549
	db	90h	;@0054B
@@5:	mov	ax, word ptr ds:[358h]	;@0054C
	cmp	ax, 0	;@0054F
	jne	@@6	;@00552
	db	0EBh, 40h	; jmp @@9	;@00554
	db	90h	;@00556
@@6:	sub	ax, bx	;@00557
	db	75h, 9	; jne @@7	;@00559
	mov	ax, word ptr ds:[356h]	;@0055B
	db	0EBh, 72h	; jmp @@12	;@0055E
	db	90h, 0EBh, 33h, 90h	;@00560
@@7:	db	0A1h, 56h, 3	; mov ax, word ptr ds:[356h]	;@00564
	mov	es, ax	;@00567
	mov	ah, 49h	;@00569
	nosmart
	nosmart
	call	far ptr L00ED3	;@0056B
	smart
	smart
	db	73h, 24h	; jae @@9	;@00570
	push	cs	;@00572
	pop	ds	;@00573
	db	0EBh, 1Ah	; jmp @@8	;@00574
	db	90h, 'Problem releasing memory$'	;@00576
@@8:	db	0BAh, 77h, 5	; mov dx, 577h	;@00590
	jmp	L004CA	;@00593
@@9:	mov	ah, 48h	;@00596
	nosmart
	nosmart
	call	far ptr L00ED0	;@00598
	smart
	smart
	db	73h, 2Fh	; jae @@11	;@0059D
	push	cs	;@0059F
	pop	ds	;@005A0
	db	0EBh, 25h	; jmp @@10	;@005A1
	db	90h, 'Insufficient memory to load overlay$'	;@005A3
@@10:	db	0BAh, 0A4h, 5	; mov dx, 5A4h	;@005C8
	jmp	L004CA	;@005CB
@@11:	mov	word ptr cs:L00000+545, ax	;@005CE
@@12:	cmp	byte ptr ds:[35Ah], 0	;@005D2
	je	@@13	;@005D7
	mov	word ptr ds:[356h], ax	;@005D9
	mov	word ptr ds:[358h], cx	;@005DC
@@13:	mov	word ptr ds:[39Dh], ax	;@005E0
	mov	word ptr ds:[354h], ax	;@005E3
	pop	es	;@005E6
	ret	;@005E7
@@14:	push	ds	;@005E8
	mov	bx, word ptr ds:[363h]	;@005E9
	mov	ax, word ptr ds:[365h]	;@005ED
	push	ax	;@005F0
	push	bx	;@005F1
	mov	bx, word ptr ds:[37Fh]	;@005F2
	xor	ax, ax	;@005F6
	mov	al, 4	;@005F8
	db	0E8h, 0D3h, 7	; call L00DD0	;@005FA
	pop	dx	;@005FD
	pop	cx	;@005FE
	add	bx, dx	;@005FF
	adc	ax, cx	;@00601
	mov	cx, ax	;@00603
	mov	dx, bx	;@00605
	xor	al, al	;@00607
	mov	bx, word ptr ds:[3A5h]	;@00609
	mov	ah, 42h	;@0060D
	int	21h	;@0060F
	db	73h, 26h	; jae @@16	;@00611
	push	cs	;@00613
	pop	ds	;@00614
	db	0EBh, 1Ch	; jmp @@15	;@00615
	db	90h, 'Cannot load kernel overlay$'	;@00617
@@15:	db	0BAh, 18h, 6	; mov dx, 618h	;@00633
	jmp	L004CA	;@00636
@@16:	mov	ax, word ptr ds:[39Dh]	;@00639
	mov	ds, ax	;@0063C
	mov	bx, word ptr cs:L00000+844	;@0063E
	mov	ax, word ptr cs:L00000+846	;@00643
	mov	word ptr cs:L00000+840, bx	;@00647
	mov	word ptr cs:L00000+842, ax	;@0064C
@@17:	mov	bx, word ptr cs:L00000+840	;@00650
	mov	ax, word ptr cs:L00000+842	;@00655
	push	ax	;@00659
	push	bx	;@0065A
	mov	bx, 2000h	;@0065B
	xor	ax, ax	;@0065E
	pop	dx	;@00660
	pop	cx	;@00661
	cmp	cx, ax	;@00662
	jne	@@18	;@00664
	cmp	dx, bx	;@00666
	jae	@@19	;@00668
	mov	bx, dx	;@0066A
	jmp	short @@19	;@0066C
@@18:	ja	@@19	;@0066E
	mov	ax, cx	;@00670
	mov	bx, dx	;@00672
@@19:	xor	cx, cx	;@00674
	mov	cx, bx	;@00676
	mov	bx, word ptr cs:L00000+933	;@00678
	xor	dx, dx	;@0067D
	mov	ah, 3Fh	;@0067F
	int	21h	;@00681
	db	73h, 26h	; jae @@21	;@00683
	push	cs	;@00685
	pop	ds	;@00686
	db	0EBh, 1Ch	; jmp @@20	;@00687
	db	90h, 'Cannot read kernel overlay$'	;@00689
@@20:	db	0BAh, 8Ah, 6	; mov dx, 68Ah	;@006A5
	jmp	L004CA	;@006A8
@@21:	cmp	ax, cx	;@006AB
	db	74h, 28h	; je @@23	;@006AD
	push	cs	;@006AF
	pop	ds	;@006B0
	db	0EBh, 1Eh	; jmp @@22	;@006B1
	db	90h, 'Error reading kernel overlay$'	;@006B3
@@22:	db	0BAh, 0B4h, 6	; mov dx, 6B4h	;@006D1
	jmp	L004CA	;@006D4
@@23:	mov	bx, cx	;@006D7
	xor	ax, ax	;@006D9
	push	ax	;@006DB
	push	bx	;@006DC
	mov	ax, ds	;@006DD
	add	ax, 200h	;@006DF
	mov	ds, ax	;@006E2
	mov	bx, word ptr cs:L00000+840	;@006E4
	mov	ax, word ptr cs:L00000+842	;@006E9
	pop	dx	;@006ED
	pop	cx	;@006EE
	sub	bx, dx	;@006EF
	sbb	ax, cx	;@006F1
	mov	word ptr cs:L00000+840, bx	;@006F3
	mov	word ptr cs:L00000+842, ax	;@006F8
	or	ax, bx	;@006FC
	je	@@24	;@006FE
	jmp	@@17	;@00700
@@24:	pop	ds	;@00703
	ret	;@00704
@@25:	mov	bx, word ptr ds:[363h]	;@00705
	mov	ax, word ptr ds:[365h]	;@00709
	push	ax	;@0070C
	push	bx	;@0070D
	xor	ax, ax	;@0070E
	mov	bx, word ptr ds:[38Fh]	;@00710
	pop	dx	;@00714
	pop	cx	;@00715
	add	bx, dx	;@00716
	adc	ax, cx	;@00718
	mov	cx, ax	;@0071A
	mov	dx, bx	;@0071C
	mov	bx, word ptr ds:[3A5h]	;@0071E
	xor	ax, ax	;@00722
	mov	ah, 42h	;@00724
	int	21h	;@00726
@@26:	mov	dx, word ptr ds:[37Dh]	;@00728
	cmp	dx, 0	;@0072C
	jne	@@27	;@0072F
	ret	;@00731
@@27:	xor	cx, cx	;@00732
	mov	cx, 1	;@00734
	cmp	dx, cx	;@00737
	jge	@@28	;@00739
	mov	cx, dx	;@0073B
@@28:	sub	word ptr ds:[37Dh], cx	;@0073D
	shl	cx, 1	;@00741
	shl	cx, 1	;@00743
	mov	dx, 350h	;@00745
	mov	bx, word ptr ds:[3A5h]	;@00748
	mov	ah, 3Fh	;@0074C
	int	21h	;@0074E
	db	73h, 29h	; jae @@30	;@00750
	push	cs	;@00752
	pop	ds	;@00753
	db	0EBh, 1Fh	; jmp @@29	;@00754
	db	90h, 'Error reading relocation data$'	;@00756
@@29:	db	0BAh, 57h, 7	; mov dx, 757h	;@00775
	jmp	L004CA	;@00778
@@30:	cmp	ax, cx	;@0077B
	db	7Dh, 29h	; jge @@32	;@0077D
	push	cs	;@0077F
	pop	ds	;@00780
	db	0EBh, 1Fh	; jmp @@31	;@00781
	db	90h, 'Error reading relocation data$'	;@00783
@@31:	db	0BAh, 84h, 7	; mov dx, 784h	;@007A2
	jmp	L004CA	;@007A5
@@32:	shr	cx, 1	;@007A8
	shr	cx, 1	;@007AA
	xor	bx, bx	;@007AC
	mov	dx, word ptr ds:[354h]	;@007AE
@@33:	mov	si, word ptr [bx+350h]	;@007B2
	mov	ax, word ptr [bx+352h]	;@007B6
	add	ax, dx	;@007BA
	mov	es, ax	;@007BC
	add	word ptr es:[si], dx	;@007BE
	add	bx, 4	;@007C1
	sub	cx, 1	;@007C4
	jne	@@33	;@007C7
	jmp	@@26	;@007C9
L007CC:	push	ds	;@007CC
	push	es	;@007CD
	push	si	;@007CE
	push	cs	;@007CF
	pop	ds	;@007D0
	cmp	word ptr ds:[3A5h], -1	;@007D1
	jne	@@1	;@007D6
	call	L00984	;@007D8
@@1:	nosmart	;@007DB
	call	far ptr L00A77
	smart
	mov	si, ax	;@007E0
	mov	es, dx	;@007E2
	cmp	byte ptr es:[si+35h], 0	;@007E4
	jne	@@2	;@007E9
	call	@@4	;@007EB
	db	0E8h, 0CAh, 1	; call L009BB	;@007EE
	jmp	@@3	;@007F1
@@2:	mov	ax, word ptr ds:[3A5h]	;@007F4
	mov	word ptr es:[si+1Bh], ax	;@007F7
	mov	bx, word ptr ds:[36Bh]	;@007FB
	mov	ax, word ptr ds:[36Dh]	;@007FF
	mov	word ptr es:[si+1Dh], bx	;@00802
	mov	word ptr es:[si+1Fh], ax	;@00806
	mov	word ptr ds:[3A5h], 0FFFFh	;@0080A
@@3:	pop	si	;@00810
	pop	es	;@00811
	pop	ds	;@00812
	ret	;@00813
@@4:	mov	bx, word ptr ds:[36Bh]	;@00814
	mov	ax, word ptr ds:[36Dh]	;@00818
	mov	byte ptr cs:L00000+858, 1	;@0081B
	call	L0042E	;@00821
	mov	byte ptr cs:L00000+858, 0	;@00824
	mov	word ptr ds:[35Fh], bx	;@0082A
	mov	word ptr ds:[361h], ax	;@0082E
	mov	word ptr es:[si+13h], bx	;@00831
	mov	word ptr es:[si+15h], ax	;@00835
	mov	ax, word ptr cs:L00000+925	;@00839
	mov	word ptr es:[si+17h], ax	;@0083D
	mov	word ptr cs:L00000+798, ax	;@00841
	mov	ax, word ptr cs:L00000+927	;@00845
	mov	word ptr es:[si+19h], ax	;@00849
	ret	;@0084D
L0084E:	mov	dx, 324h	;@0084E
	mov	cx, 24h	;@00851
	mov	bx, word ptr ds:[3A5h]	;@00854
	mov	ah, 3Fh	;@00858
	int	21h	;@0085A
	jae	@@1	;@0085C
	jmp	@@7	;@0085E
@@1:	mov	bx, dx	;@00861
	mov	ax, word ptr [bx]	;@00863
	cmp	ax, 5A4Dh	;@00865
	je	@@2	;@00868
	jmp	@@7	;@0086A
@@2:	mov	bx, word ptr ds:[32Ch]	;@0086D
	cmp	bx, 20h	;@00871
	jg	@@3	;@00874
	jmp	@@7	;@00876
@@3:	sub	bx, 20h	;@00879
	mov	al, 4	;@0087C
	db	0E8h, 4Fh, 5	; call L00DD0	;@0087E
	mov	cx, ax	;@00881
	mov	dx, bx	;@00883
	xor	al, al	;@00885
	mov	bx, word ptr ds:[3A5h]	;@00887
	mov	ah, 42h	;@0088B
	int	21h	;@0088D
	jae	@@4	;@0088F
	jmp	@@7	;@00891
@@4:	mov	cx, 10h	;@00894
	mov	dx, 367h	;@00897
	mov	ah, 3Fh	;@0089A
	int	21h	;@0089C
	jae	@@5	;@0089E
	jmp	@@7	;@008A0
@@5:	cmp	word ptr ds:[367h], 4941h	;@008A3
	je	@@6	;@008A9
	jmp	@@7	;@008AB
@@6:	mov	ax, 0	;@008AE
	jmp	@@8	;@008B1
@@7:	mov	ax, 0FFFFh	;@008B4
@@8:	ret	;@008B7
L008B8:	mov	word ptr ds:[39Bh], 0	;@008B8
	mov	bx, word ptr ds:[36Fh]	;@008BE
	mov	ax, word ptr ds:[371h]	;@008C2
	call	L0042E	;@008C5
	xor	bx, bx	;@008C8
	mov	word ptr ds:[35Bh], bx	;@008CA
	mov	word ptr ds:[35Dh], ax	;@008CE
	mov	byte ptr ds:[310h], 0	;@008D1
	ret	;@008D6
L008D7:	push	es	;@008D7
	mov	ah, 62h	;@008D8
	int	21h	;@008DA
	mov	es, bx	;@008DC
	mov	ax, word ptr es:[2Ch]	;@008DE
	mov	es, ax	;@008E2
	xor	di, di	;@008E4
	xor	al, al	;@008E6
@@1:	mov	cx, 0FFFFh	;@008E8
	repne scasb	;@008EB
	cmp	al, byte ptr es:[di]	;@008ED
	je	@@2	;@008F0
	jmp	@@1	;@008F2
@@2:	add	di, 3	;@008F4
	mov	ax, es	;@008F7
	mov	bx, di	;@008F9
	pop	es	;@008FB
	ret	;@008FC
L008FD:	call	L008D7	;@008FD
	mov	word ptr ds:[3A1h], bx	;@00900
	mov	word ptr ds:[3A3h], ax	;@00904
	call	@@1	;@00907
	ret	;@0090A
@@1:	mov	bx, word ptr ds:[3A1h]	;@0090B
	mov	ax, word ptr ds:[3A3h]	;@0090F
	push	ds	;@00912
	mov	ds, ax	;@00913
	mov	dx, bx	;@00915
	xor	al, al	;@00917
	mov	ah, 3Dh	;@00919
	int	21h	;@0091B
	pop	ds	;@0091D
	jae	@@2	;@0091E
	mov	ax, 0FFFFh	;@00920
	jmp	@@7	;@00923
@@2:	mov	word ptr ds:[3A5h], ax	;@00926
	mov	bx, ax	;@00929
	call	L0084E	;@0092B
	cmp	ax, 0FFFFh	;@0092E
	jne	@@3	;@00931
	jmp	@@5	;@00933
@@3:	mov	bx, word ptr ds:[36Bh]	;@00936
	mov	ax, word ptr ds:[36Dh]	;@0093A
	cmp	ax, 0FFFFh	;@0093D
	jne	@@4	;@00940
	jmp	@@5	;@00942
@@4:	jmp	@@6	;@00945
@@5:	mov	bx, word ptr ds:[3A5h]	;@00948
	mov	ah, 3Eh	;@0094C
	int	21h	;@0094E
	mov	ax, 0FFFFh	;@00950
	jmp	@@7	;@00953
@@6:	mov	ax, word ptr ds:[3A5h]	;@00956
@@7:	pop	es	;@00959
	ret	;@0095A
L0095B:	push	ax	;@0095B
	push	bx	;@0095C
	push	cx	;@0095D
	push	dx	;@0095E
	mov	cx, 4149h	;@0095F
	mov	dx, 413Fh	;@00962
	mov	ah, 2Bh	;@00965
	int	21h	;@00967
	cmp	al, 0FFh	;@00969
	jne	@@1	;@0096B
	jmp	@@1	;@0096D
@@1:	pop	dx	;@00970
	pop	cx	;@00971
	pop	bx	;@00972
	pop	ax	;@00973
	ret	;@00974
L00975:	call	L0095B	;@00975
	call	L008FD	;@00978
	cmp	ax, 0FFFFh	;@0097B
	je	@@1	;@0097E
	clc	;@00980
	ret	;@00981
@@1:	stc	;@00982
	ret	;@00983
L00984:	mov	bx, word ptr ds:[3A1h]	;@00984
	mov	ax, word ptr ds:[3A3h]	;@00988
	push	ds	;@0098B
	mov	ds, ax	;@0098C
	mov	dx, bx	;@0098E
	xor	al, al	;@00990
	mov	ah, 3Dh	;@00992
	int	21h	;@00994
	db	73h, 1Eh	; jae @@2	;@00996
	push	cs	;@00998
	pop	ds	;@00999
	db	0EBh, 14h	; jmp @@1	;@0099A
	db	90h, 'Cannot open kernel$'	;@0099C
@@1:	db	0BAh, 9Dh, 9	; mov dx, 99Dh	;@009B0
	jmp	L004CA	;@009B3
@@2:	pop	ds	;@009B6
	mov	word ptr ds:[3A5h], ax	;@009B7
	ret	;@009BA
L009BB:	mov	bx, word ptr ds:[3A5h]	;@009BB
	cmp	bx, -1	;@009BF
	db	74h, 2Ah	; je @@3	;@009C2
	mov	ah, 3Eh	;@009C4
	int	21h	;@009C6
	db	73h, 1Eh	; jae @@2	;@009C8
	push	cs	;@009CA
	pop	ds	;@009CB
	db	0EBh, 14h	; jmp @@1	;@009CC
	db	90h, 'Error closing file$'	;@009CE
@@1:	db	0BAh, 0CFh, 9	; mov dx, 9CFh	;@009E2
	jmp	L004CA	;@009E5
@@2:	mov	word ptr ds:[3A5h], 0FFFFh	;@009E8
@@3:	ret	;@009EE
	db	56h, 51h, 50h, 0FCh, 83h, 0F9h, 0, 7Eh, 12h, 8Ah, 4, 3Ch, 61h, 72h, 6, 3Ch	;@009EF
	db	7Ah, 77h, 2, 2Ch, 20h, 88h, 4, 46h, 49h, 0EBh, 0E9h, 58h, 59h, 5Eh, 0C3h, 0Eh
	db	1Fh, 0EBh, 2Dh, 90h, 4Fh, 53h, 2Fh, 78h, 38h, 36h, 3Ah, 20h, 43h, 61h, 6Eh, 6Eh
	db	6Fh, 74h, 20h, 66h, 69h, 6Eh, 64h, 20h, 6Fh, 70h, 65h, 72h, 61h, 74h, 69h, 6Eh
	db	67h, 20h, 73h, 79h, 73h, 74h, 65h, 6Dh, 20h, 6Bh, 65h, 72h, 6Eh, 65h, 6Ch, 24h
	db	0BAh, 13h, 0Ah, 0E9h, 85h, 0FAh, 2Eh, 80h, 3Eh, 11h, 3, 0, 75h, 7, 0E8h, 12h
	db	0, 0B8h, 0, 0, 0CBh, 0E8h, 75h, 0FDh, 0E8h, 8, 0, 0B8h, 0, 0, 2Eh, 0FFh
	db	2Eh, 5Bh, 3, 0BBh
	dw	seg L00000
	db	0B9h
	dw	seg L00000
	db	0BEh, 0D0h, 0Eh, 0BFh, 0D3h, 0Eh, 0B8h, 0FFh, 0FFh, 2Eh, 0FFh, 1Eh, 5Bh, 3, 0C3h
L00A77:	cmp	byte ptr cs:L00000+784, 0	;@00A77
	je	@@1	;@00A7D
	call	L0040E	;@00A7F
	jae	@@1	;@00A82
	xor	dx, dx	;@00A84
	xor	ax, ax	;@00A86
	retf	;@00A88
@@1:	mov	ax, 19h	;@00A89
	jmp	dword ptr cs:L00000+859	;@00A8C
	db	2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 72h, 0F9h, 73h, 3, 0E8h	;@00A91
	db	6Dh, 0FFh, 0B8h, 1, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h
	db	3, 0, 74h, 8, 0E8h, 5Ah, 0F9h, 73h, 3, 0E8h, 55h, 0FFh, 0B8h, 2
	db	0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h
	db	42h, 0F9h, 73h, 3, 0E8h, 3Dh, 0FFh, 0B8h, 3, 0, 2Eh, 0FFh, 2Eh
	db	5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 2Ah, 0F9h, 73h
	db	3, 0E8h, 25h, 0FFh, 0B8h, 4, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h
	db	3Eh, 10h, 3, 0, 74h, 8, 0E8h, 12h, 0F9h, 73h, 3, 0E8h, 0Dh, 0FFh
	db	0B8h, 5, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h
	db	8, 0E8h, 0FAh, 0F8h, 73h, 3, 0E8h, 0F5h, 0FEh, 0B8h, 6, 0, 2Eh
	db	0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0E2h
	db	0F8h, 73h, 3, 0E8h, 0DDh, 0FEh, 0B8h, 8, 0, 2Eh, 0FFh, 2Eh, 5Bh
	db	3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0CAh, 0F8h, 73h, 3
	db	0E8h, 0C5h, 0FEh, 0B8h, 9, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h
	db	3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0B2h, 0F8h, 73h, 3, 0E8h, 0ADh, 0FEh
	db	0B8h, 0Ah, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0
	db	74h, 8, 0E8h, 9Ah, 0F8h, 73h, 3, 0E8h, 95h, 0FEh, 0B8h, 0Bh, 0
	db	2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h
	db	82h, 0F8h, 73h, 3, 0E8h, 7Dh, 0FEh, 0B8h, 0Ch, 0, 2Eh, 0FFh, 2Eh
	db	5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 6Ah, 0F8h, 73h
	db	3, 0E8h, 65h, 0FEh, 0B8h, 0Dh, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh
	db	80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 52h, 0F8h, 73h, 3, 0E8h, 4Dh
	db	0FEh, 0B8h, 0Eh, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h
	db	3, 0, 74h, 8, 0E8h, 3Ah, 0F8h, 73h, 3, 0E8h, 35h, 0FEh, 0B8h, 0Fh
	db	0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h
	db	22h, 0F8h, 73h, 3, 0E8h, 1Dh, 0FEh, 0B8h, 10h, 0, 2Eh, 0FFh, 2Eh
	db	5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0Ah, 0F8h, 73h
	db	3, 0E8h, 5, 0FEh, 0B8h, 11h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h
	db	3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0F2h, 0F7h, 73h, 3, 0E8h, 0EDh, 0FDh
	db	0B8h, 12h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0
	db	74h, 8, 0E8h, 0DAh, 0F7h, 73h, 3, 0E8h, 0D5h, 0FDh, 0B8h, 13h
	db	0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h
	db	0C2h, 0F7h, 73h, 3, 0E8h, 0BDh, 0FDh, 0B8h, 14h, 0, 2Eh, 0FFh
	db	2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0AAh, 0F7h
	db	73h, 3, 0E8h, 0A5h, 0FDh, 0B8h, 15h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3
	db	2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 92h, 0F7h, 73h, 3, 0E8h
	db	8Dh, 0FDh, 0B8h, 16h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh
	db	10h, 3, 0, 74h, 8, 0E8h, 7Ah, 0F7h, 73h, 3, 0E8h, 75h, 0FDh, 0B8h
	db	17h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h
	db	8, 0E8h, 62h, 0F7h, 73h, 3, 0E8h, 5Dh, 0FDh, 0B8h, 1Ah, 0, 2Eh
	db	0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 4Ah
	db	0F7h, 73h, 3, 0E8h, 45h, 0FDh, 0B8h, 1Bh, 0, 2Eh, 0FFh, 2Eh, 5Bh
	db	3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 32h, 0F7h, 73h, 3, 0E8h
	db	2Dh, 0FDh, 0B8h, 1Ch, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh
	db	10h, 3, 0, 74h, 8, 0E8h, 1Ah, 0F7h, 73h, 3, 0E8h, 15h, 0FDh, 0B8h
	db	1Dh, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h
	db	8, 0E8h, 2, 0F7h, 73h, 3, 0E8h, 0FDh, 0FCh, 0B8h, 1Eh, 0, 2Eh
	db	0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0EAh
	db	0F6h, 73h, 3, 0E8h, 0E5h, 0FCh, 0B8h, 1Fh, 0, 2Eh, 0FFh, 2Eh, 5Bh
	db	3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0D2h, 0F6h, 73h, 3
	db	0E8h, 0CDh, 0FCh, 0B8h, 20h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h
	db	3Eh, 10h, 3, 0, 74h, 8, 0E8h, 0BAh, 0F6h, 73h, 3, 0E8h, 0B5h, 0FCh
	db	0B8h, 21h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0
	db	74h, 8, 0E8h, 0A2h, 0F6h, 73h, 3, 0E8h, 9Dh, 0FCh, 0B8h, 22h, 0
	db	2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h
	db	8Ah, 0F6h, 73h, 3, 0E8h, 85h, 0FCh, 0B8h, 23h, 0, 2Eh, 0FFh, 2Eh
	db	5Bh, 3, 2Eh, 80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 72h, 0F6h, 73h
	db	3, 0E8h, 6Dh, 0FCh, 0B8h, 24h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3, 2Eh
	db	80h, 3Eh, 10h, 3, 0, 74h, 8, 0E8h, 5Ah, 0F6h, 73h, 3, 0E8h, 55h
	db	0FCh, 0B8h, 25h, 0, 2Eh, 0FFh, 2Eh, 5Bh, 3
L00DC1:	mov	ch, cl	;@00DC1
	shr	bx, cl	;@00DC3
	mov	cl, 10h	;@00DC5
	sub	cl, ch	;@00DC7
	shl	ax, cl	;@00DC9
	or	bx, ax	;@00DCB
	xor	ax, ax	;@00DCD
	ret	;@00DCF
L00DD0:	push	cx	;@00DD0
	mov	cl, al	;@00DD1
	mov	ch, al	;@00DD3
	mov	ax, bx	;@00DD5
	shl	bx, cl	;@00DD7
	mov	cl, 10h	;@00DD9
	sub	cl, ch	;@00DDB
	shr	ax, cl	;@00DDD
	pop	cx	;@00DDF
	ret	;@00DE0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0FDh	;@00DE1
	db	22h
	dw	seg L00000
	db	0C1h, 22h
	dw	seg L00000
	db	0D6h, 22h
	dw	seg L00000
	db	29h, 23h
	dw	seg L00000
	db	0B0h, 24h
	dw	seg L00000
	db	0DAh, 24h
	dw	seg L00000
	db	0E2h, 25h
	dw	seg L00000
	db	0BEh, 21h
	dw	seg L00000
	db	0BEh, 21h
	dw	seg L00000
	db	0C1h, 26h
	dw	seg L00000
	db	0FCh, 26h
	dw	seg L00000
	db	0D7h, 27h
	dw	seg L00000
	db	28h, 28h
	dw	seg L00000
	db	77h, 28h
	dw	seg L00000
	db	1Dh, 29h
	dw	seg L00000
	db	0C9h, 29h
	dw	seg L00000
	db	0E3h, 29h
	dw	seg L00000
	db	19h, 2Ah
	dw	seg L00000
	db	41h, 2Ah
	dw	seg L00000
	db	98h, 2Bh
	dw	seg L00000
	db	37h, 27h
	dw	seg L00000
	db	87h, 27h
	dw	seg L00000
	db	86h, 26h
	dw	seg L00000
	db	2Ch, 26h
	dw	seg L00000
	db	0BEh, 21h
	dw	seg L00000
	db	0D3h, 21h
	dw	seg L00000
	db	0FFh, 29h
	dw	seg L00000
	db	6Bh, 26h
	dw	seg L00000
	db	0EBh, 21h
	dw	seg L00000
	db	60h, 22h
	dw	seg L00000
	db	14h, 22h
	dw	seg L00000
	db	73h, 2Ah
	dw	seg L00000
	db	96h, 2Ah
	dw	seg L00000
	db	0C1h, 2Ah
	dw	seg L00000
	db	0FAh, 2Ah
	dw	seg L00000
	db	38h, 2Bh
	dw	seg L00000
	db	0A8h, 22h
	dw	seg L00000
	db	92h, 22h
	dw	seg L00000
	db	3Dh, 0FFh, 0FFh, 75h, 4, 0E8h, 1Ah, 0, 0CBh, 8Bh, 0D8h, 81h, 0E3h, 0FFh, 7Fh, 0D1h
	db	0E3h, 0D1h, 0E3h, 81h, 0FBh, 98h, 0, 77h, 5, 2Eh, 0FFh, 0AFh, 0F0h, 0Dh, 0B8h, 1
	db	0, 0CBh, 2Eh, 89h, 1Eh, 74h, 21h, 2Eh, 89h, 0Eh, 78h, 21h, 2Eh, 89h, 36h, 72h
	db	21h, 2Eh, 89h, 3Eh, 76h, 21h, 0E8h, 88h, 34h, 0C3h, 0C3h, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0
L00ED0:	int	21h	;@00ED0
	retf	;@00ED2
L00ED3:	int	21h	;@00ED3
	retf	;@00ED5
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	;@00ED6
	db	0, 0BBh
	dw	seg S5FD_START
	db	8Eh, 0C3h, 89h, 1Eh, 90h, 0, 0E8h, 3Fh, 6, 2Eh, 0C6h, 6, 0E0h, 0Eh, 1, 0C3h
	db	0BBh, 0FFh, 0FFh, 0B4h, 48h, 2Eh, 0FFh, 1Eh, 72h, 21h, 0D1h, 0EBh, 8Bh, 0C3h, 0D1h, 0E8h
	db	3, 0D8h, 53h, 33h, 0C0h, 0B4h, 48h, 2Eh, 0FFh, 1Eh, 72h, 21h, 8Bh, 0D8h, 0B0h, 4
	db	0E8h, 0D3h, 38h, 89h, 1Eh, 0F8h, 0, 0A3h, 0FAh, 0, 89h, 1Eh, 0E7h, 0, 0A3h, 0E9h
	db	0, 5Bh, 0B0h, 4, 0E8h, 0BFh, 38h, 89h, 1Eh, 0FCh, 0, 0A3h, 0FEh, 0, 0C3h, 80h
	db	3Eh, 0D5h, 0, 0, 74h, 6, 0E8h, 0B7h, 0FFh, 0EBh, 2Fh, 90h, 0E8h, 0B4h, 2, 8Bh
	db	1Eh, 0FCh, 0, 0A1h, 0FEh, 0, 0Bh, 0C3h, 75h, 20h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh
	db	0C7h, 46h, 4, 0, 0, 0C7h, 46h, 2, 5Bh, 0, 5Dh, 9Ah, 0E0h, 48h
	dw	seg L00000
	db	83h, 0C4h, 4, 0E8h, 8Ah, 0FFh, 0FEh, 6, 0D5h, 0, 0C3h, 0C7h, 6, 9, 1, 0
	db	0, 8Bh, 16h, 3, 1, 83h, 0FAh, 0, 74h, 3Ah, 0BBh, 0FFh, 0FFh, 0B4h, 48h, 2Eh
	db	0FFh, 1Eh, 72h, 21h, 0B1h, 6, 0D3h, 0EBh, 2Bh, 1Eh, 5, 1, 83h, 0FBh, 0, 7Eh
	db	23h, 3Bh, 0DAh, 76h, 2, 8Bh, 0DAh, 89h, 1Eh, 9, 1, 0B1h, 6, 0D3h, 0E3h, 0B4h
	db	48h, 2Eh, 0FFh, 1Eh, 72h, 21h, 72h, 6, 0A3h, 7, 1, 0EBh, 7, 90h, 0C7h, 6
	db	9, 1, 0, 0, 0C3h, 6, 56h, 50h, 53h, 51h, 8Bh, 1Eh, 90h, 0, 0B0h, 4
	db	0E8h, 23h, 38h, 0A2h, 1Ch, 0, 89h, 1Eh, 1Ah, 0, 0B9h, 80h, 0, 0B8h
	dw	seg S589_START
	db	8Eh, 0C0h, 0BEh, 0, 0, 0E8h, 86h, 3, 59h, 5Bh, 58h, 5Eh, 7, 0C3h, 6, 56h
	db	57h, 0F7h, 6, 0A8h, 0, 64h, 0, 74h, 3, 0E9h, 0CAh, 0, 33h, 0C0h, 33h, 0DBh
	db	89h, 1Eh, 40h, 0, 0A3h, 42h, 0, 0E8h, 0BBh, 0FFh, 72h, 43h, 0BFh, 3, 0, 8Eh
	db	6, 90h, 0, 0BEh, 3Ah, 0, 0B9h, 4, 0, 33h, 0C0h, 33h, 0DBh, 0F3h, 0A6h, 75h
	db	0Ah, 26h, 8Bh, 1Eh, 1Eh, 0, 0B0h, 0Ah, 0E8h, 0CBh, 37h, 50h, 53h, 8Bh, 1Eh, 40h
	db	0, 0A1h, 42h, 0, 5Ah, 59h, 3Bh, 0C8h, 75h, 8, 3Bh, 0D3h, 76h, 0Ah, 8Bh, 0DAh
	db	0EBh, 6, 7Ch, 4, 8Bh, 0C1h, 8Bh, 0DAh, 89h, 1Eh, 40h, 0, 0A3h, 42h, 0, 33h
	db	0C0h, 8Eh, 0C0h, 26h, 8Eh, 6, 66h, 0, 0BFh, 12h, 0, 0BEh, 3Ah, 0, 0B9h, 4
	db	0, 33h, 0C0h, 33h, 0DBh, 0F3h, 0A6h, 75h, 9, 26h, 0A0h, 2Eh, 0, 26h, 8Bh, 1Eh
	db	2Ch, 0, 50h, 53h, 8Bh, 1Eh, 40h, 0, 0A1h, 42h, 0, 5Ah, 59h, 3Bh, 0C8h, 75h
	db	8, 3Bh, 0D3h, 76h, 0Ah, 8Bh, 0DAh, 0EBh, 6, 7Ch, 4, 8Bh, 0C1h, 8Bh, 0DAh, 89h
	db	1Eh, 40h, 0, 0A3h, 42h, 0, 0Bh, 0C3h, 3Dh, 0, 0, 74h, 29h, 8Bh, 1Eh, 40h
	db	0, 0A1h, 42h, 0, 89h, 1Eh, 44h, 0, 0A3h, 46h, 0, 2Ch, 10h, 50h, 53h, 8Bh
	db	1Eh, 48h, 0, 0A1h, 4Ah, 0, 5Ah, 59h, 2Bh, 0DAh, 1Bh, 0C1h, 89h, 1Eh, 48h, 0
	db	0A3h, 4Ah, 0, 0EBh, 3Dh, 90h, 8Eh, 6, 90h, 0, 33h, 0FFh, 0E8h, 44h, 0, 73h
	db	0Fh, 0B8h, 10h, 0, 33h, 0DBh, 89h, 1Eh, 44h, 0, 0A3h, 46h, 0, 0EBh, 23h, 90h
	db	89h, 1Eh, 44h, 0, 0A3h, 46h, 0, 8Bh, 1Eh, 48h, 0, 0A1h, 4Ah, 0, 2Bh, 1Eh
	db	44h, 0, 1Bh, 6, 46h, 0, 89h, 1Eh, 48h, 0, 0A3h, 4Ah, 0, 83h, 6, 4Ah
	db	0, 10h, 33h, 0FFh, 8Eh, 6, 90h, 0, 0B9h, 0, 1, 33h, 0C0h, 0F3h, 0AAh, 5Fh
	db	5Eh, 7, 0C3h, 56h, 51h, 57h, 0BEh, 30h, 0, 0B9h, 9, 0, 0FCh, 0F3h, 0A6h, 75h
	db	27h, 0BFh, 40h, 0, 26h, 83h, 7Dh, 8, 0, 74h, 5, 83h, 0C7h, 0Ah, 0EBh, 0F4h
	db	83h, 0EFh, 0Ah, 26h, 8Bh, 5Dh, 8, 0B0h, 0Ah, 0E8h, 0BAh, 36h, 26h, 3, 5Dh, 4
	db	26h, 13h, 45h, 6, 0F8h, 0EBh, 2, 90h, 0F9h, 5Fh, 59h, 5Eh, 0C3h, 0F7h, 6, 0A8h
	db	0, 10h, 0, 74h, 11h, 0B4h, 8, 2Eh, 0FFh, 1Eh, 0E1h, 0Eh, 8Bh, 0D8h, 0B0h, 0Ah
	db	0E8h, 93h, 36h, 0EBh, 36h, 90h, 0F7h, 6, 0A8h, 0, 4, 0, 74h, 13h, 1Eh, 0B8h
	db	40h, 0, 8Eh, 0D8h, 0A0h, 1, 0, 32h, 0E4h, 0D1h, 0E0h, 33h, 0DBh, 1Fh, 0EBh, 1Bh
	db	90h, 0F7h, 6, 0A8h, 0, 60h, 0, 74h, 7, 33h, 0C0h, 33h, 0DBh, 0EBh, 0Ch, 90h
	db	0B4h, 88h, 0CDh, 15h, 8Bh, 0D8h, 0B0h, 0Ah, 0E8h, 5Bh, 36h, 89h, 1Eh, 48h, 0, 0A3h
	db	4Ah, 0, 0C3h, 0B8h
	dw	seg S5FD_START
	db	8Eh, 0C0h, 26h, 83h, 3Eh, 4Dh, 0, 0, 74h, 20h, 9Ah
	dd	L0B7DD
	db	50h, 53h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 5Bh, 58h, 89h, 1Eh, 44h, 0, 0A3h, 46h, 0, 89h, 16h, 48h, 0, 89h
	db	0Eh, 4Ah, 0, 0EBh, 33h, 90h, 0F7h, 6, 0A8h, 0, 10h, 0, 74h, 0Fh, 0B8h, 10h
	db	43h, 0CDh, 2Fh, 2Eh, 89h, 1Eh, 0E1h, 0Eh, 2Eh, 8Ch, 6, 0E3h, 0Eh, 0E8h, 63h, 0FFh
	db	3Dh, 0, 0, 75h, 8, 83h, 0FBh, 0, 75h, 3, 0EBh, 0Ch, 90h, 0F7h, 6, 0A8h
	db	0, 10h, 0, 75h, 3, 0E8h, 0ECh, 0FDh, 0C3h, 0E8h, 9Dh, 0FFh, 8Bh, 1Eh, 0F8h, 0
	db	0A1h, 0FAh, 0, 3Dh, 0, 0, 75h, 0Ch, 83h, 0FBh, 0, 75h, 7, 8Bh, 1Eh, 44h
	db	0, 0A1h, 46h, 0, 89h, 1Eh, 0F8h, 0, 0A3h, 0FAh, 0, 89h, 1Eh, 0E7h, 0, 0A3h
	db	0E9h, 0, 8Bh, 1Eh, 0FCh, 0, 0A1h, 0FEh, 0, 3Dh, 0, 0, 75h, 0Ch, 83h, 0FBh
	db	0, 75h, 7, 8Bh, 1Eh, 48h, 0, 0A1h, 4Ah, 0, 89h, 1Eh, 0FCh, 0, 0A3h, 0FEh
	db	0, 0F7h, 6, 0A8h, 0, 60h, 0, 74h, 1, 0C3h, 8Bh, 1Eh, 44h, 0, 0A1h, 46h
	db	0, 3, 1Eh, 48h, 0, 13h, 6, 4Ah, 0, 2Bh, 1Eh, 0F8h, 0, 1Bh, 6, 0FAh
	db	0, 3Bh, 6, 0FEh, 0, 75h, 4, 3Bh, 1Eh, 0FCh, 0, 73h, 7, 89h, 1Eh, 0FCh
	db	0, 0A3h, 0FEh, 0, 0C3h, 0, 0, 0, 0, 0, 0, 80h, 0FCh, 88h, 75h, 5
	db	2Eh, 0A1h, 7Dh, 12h, 0CFh, 2Eh, 0FFh, 2Eh, 79h, 12h, 50h, 53h, 51h, 52h, 1Eh, 6
	db	0F7h, 6, 0A8h, 0, 10h, 0, 74h, 4Eh, 8Bh, 1Eh, 0FCh, 0, 0A1h, 0FEh, 0, 51h
	db	0B1h, 0Ah, 0E8h, 7Ah, 35h, 59h, 83h, 0EBh, 40h, 8Bh, 0D3h, 51h, 0B1h, 0Ah, 0E8h, 4Ch
	db	35h, 59h, 89h, 1Eh, 0FCh, 0, 0A3h, 0FEh, 0, 0B4h, 9, 2Eh, 0FFh, 1Eh, 0E1h, 0Eh
	db	2Eh, 89h, 16h, 0E5h, 0Eh, 0B4h, 0Ch, 2Eh, 0FFh, 1Eh, 0E1h, 0Eh, 8Bh, 0C2h, 89h, 1Eh
	db	44h, 0, 0A3h, 46h, 0, 89h, 1Eh, 0F8h, 0, 0A3h, 0FAh, 0, 89h, 1Eh, 0E7h, 0
	db	0A3h, 0E9h, 0, 0EBh, 78h, 90h, 0F7h, 6, 0A8h, 0, 4, 0, 74h, 2Ah, 1Eh, 0B8h
	db	40h, 0, 8Eh, 0D8h, 0A0h, 1, 0, 32h, 0E4h, 0D1h, 0E0h, 33h, 0DBh, 0B9h
	dw	seg S589_START
	db	8Eh, 0D9h, 2Bh, 1Eh, 0FCh, 0, 1Bh, 6, 0FEh, 0, 0B9h, 40h, 0, 8Eh, 0D9h, 0D1h
	db	0E8h, 0A2h, 1, 0, 1Fh, 0EBh, 46h, 90h, 0F7h, 6, 0A8h, 0, 60h, 0, 74h, 3
	db	0EBh, 3Bh, 90h, 0B8h, 0, 88h, 0CDh, 15h, 8Bh, 0C8h, 8Bh, 1Eh, 0FCh, 0, 0A1h, 0FEh
	db	0, 51h, 0B1h, 0Ah, 0E8h, 0E8h, 34h, 59h, 2Bh, 0CBh, 2Eh, 89h, 0Eh, 7Dh, 12h, 0B8h
	db	15h, 35h, 0CDh, 21h, 2Eh, 89h, 1Eh, 79h, 12h, 2Eh, 8Ch, 6, 7Bh, 12h, 0C6h, 6
	db	4Dh, 0, 1, 0Eh, 1Fh, 0BAh, 7Fh, 12h, 0B8h, 15h, 25h, 0CDh, 21h, 7, 1Fh, 5Ah
	db	59h, 5Bh, 58h, 0C3h, 50h, 0B4h, 87h, 9Ch, 0FAh, 0CDh, 15h, 0Ah, 0E4h, 74h, 1, 0F9h
	db	9Fh, 9Dh, 9Eh, 58h, 0C3h, 1Eh, 6, 8Bh, 1Eh, 0BAh, 0, 0B0h, 4, 0E8h, 6Ch, 34h
	db	3Bh, 6, 0FEh, 0, 75h, 4, 3Bh, 1Eh, 0FCh, 0, 7Eh, 4, 0F9h, 0E9h, 5Dh, 1
	db	8Eh, 6, 90h, 0, 26h, 83h, 3Eh, 4Dh, 0, 0, 74h, 8, 9Ah
	dd	L0BA72
	db	0E9h, 0Ah, 1, 0F7h, 6, 0A8h, 0, 10h, 0, 74h, 4Fh, 1Eh, 55h, 83h, 0ECh, 10h
	db	8Bh, 0ECh, 8Bh, 1Eh, 0BAh, 0, 0A1h, 0BCh, 0, 51h, 0B1h, 4, 0E8h, 3Dh, 34h, 59h
	db	89h, 5Eh, 0, 89h, 46h, 2, 0C7h, 46h, 4, 0, 0, 0C7h, 46h, 6, 0, 0
	db	0A1h, 0B8h, 0, 89h, 46h, 8, 2Eh, 0A1h, 0E5h, 0Eh, 89h, 46h, 0Ah, 0C7h, 46h, 0Ch
	db	0, 0, 0C7h, 46h, 0Eh, 0, 0, 16h, 1Fh, 8Bh, 0F5h, 0B4h, 0Bh, 2Eh, 0FFh, 1Eh
	db	0E1h, 0Eh, 83h, 0C4h, 10h, 5Dh, 1Fh, 0E9h, 0B3h, 0, 51h, 0B1h, 1, 0E8h, 1Eh, 34h
	db	59h, 50h, 53h, 8Bh, 1Eh, 0B8h, 0, 0B0h, 4, 0E8h, 0DFh, 33h, 0A2h, 14h, 0, 89h
	db	1Eh, 12h, 0, 8Bh, 1Eh, 0F8h, 0, 0A1h, 0FAh, 0, 0A2h, 1Ch, 0, 89h, 1Eh, 1Ah
	db	0, 0B9h
	dw	seg S589_START
	db	8Eh, 0C1h, 0BEh, 0, 0, 5Bh, 58h, 3Dh, 0, 0, 74h, 6, 0B9h, 0FFh, 7Fh, 0EBh
	db	0Fh, 90h, 81h, 0FBh, 0FFh, 7Fh, 76h, 6, 0B9h, 0FFh, 7Fh, 0EBh, 3, 90h, 8Bh, 0CBh
	db	50h, 53h, 51h, 0F7h, 6, 0A8h, 0, 60h, 0, 74h, 0Bh, 52h, 0BAh, 0, 0, 0E8h
	db	78h, 32h, 5Ah, 0E9h, 92h, 0, 0F7h, 6, 0A8h, 0, 4, 0, 74h, 13h, 0BBh, 0
	db	0, 0D1h, 0E1h, 33h, 0F6h, 33h, 0FFh, 0FCh, 0B4h, 90h, 0FAh, 0CDh, 1Fh, 0FBh, 0EBh, 4
	db	90h, 0E8h, 0EBh, 0FEh, 59h, 5Bh, 58h, 73h, 3, 0EBh, 6Dh, 90h, 2Bh, 0D9h, 1Dh, 0
	db	0, 3Dh, 0, 0, 75h, 8, 83h, 0FBh, 0, 75h, 3, 0EBh, 1Ch, 90h, 50h, 53h
	db	0D1h, 0E1h, 1, 0Eh, 12h, 0, 80h, 16h, 14h, 0, 0, 1, 0Eh, 1Ah, 0, 80h
	db	16h, 1Ch, 0, 0, 5Bh, 58h, 0E9h, 7Eh, 0FFh, 8Eh, 6, 0B8h, 0, 0B4h, 49h, 2Eh
	db	0FFh, 1Eh, 76h, 21h, 33h, 0C0h, 2Eh, 0A3h, 21h, 2, 8Bh, 1Eh, 0BAh, 0, 0B0h, 4
	db	0E8h, 24h, 33h, 3, 1Eh, 0F8h, 0, 13h, 6, 0FAh, 0, 89h, 1Eh, 0E7h, 0, 0A3h
	db	0E9h, 0, 0B8h
	dw	seg L050A0
	db	8Eh, 0C0h, 8Bh, 1Eh, 0F8h, 0, 0A1h, 0FAh, 0, 26h, 89h, 1Eh, 26h, 0, 26h, 0A3h
	db	28h, 0, 0F8h, 7, 1Fh, 0C3h, 6, 1Eh, 50h, 53h, 56h, 57h, 8Bh, 1Eh, 0B4h, 0
	db	0A1h, 0B6h, 0, 8Eh, 0D8h, 8Bh, 0F3h, 0B8h
	dw	seg L050A0
	db	8Eh, 0C0h, 0BFh, 26h, 0, 0B9h, 9, 0, 0FCh, 0F3h, 0A5h, 33h, 0C0h, 26h, 0A3h, 26h
	db	0, 26h, 0A3h, 28h, 0, 5Fh, 5Eh, 5Bh, 58h, 1Fh, 7, 0C3h, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9Ch, 58h, 25h, 0FFh, 0Fh, 50h
	db	9Dh, 8Bh, 1Eh, 0B4h, 0, 0A1h, 0B6h, 0, 0E8h, 6Ch, 37h, 0E8h, 0AEh, 0FFh, 0E8h, 0F0h
	db	0F9h, 80h, 3Eh, 0D5h, 0, 0, 75h, 2Ch, 0F7h, 6, 0A8h, 0, 10h, 0, 74h, 12h
	db	8Eh, 6, 90h, 0, 26h, 83h, 3Eh, 4Dh, 0, 0, 75h, 3, 0E8h, 27h, 0FDh, 0EBh
	db	13h, 90h, 8Eh, 6, 90h, 0, 26h, 83h, 3Eh, 4Dh, 0, 0, 75h, 6, 0E8h, 15h
	db	0FDh, 0E8h, 0B2h, 0, 80h, 3Eh, 0D5h, 0, 0, 75h, 12h, 80h, 3Eh, 0D4h, 0, 0
	db	74h, 0Bh, 0E8h, 0ECh, 0FDh, 73h, 6, 0B8h, 0Ah, 0, 0E9h, 98h, 0, 0E8h, 0DDh, 0F9h
	db	8Eh, 6, 90h, 0, 0B9h, 92h, 0, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0BEh, 0A1h, 0, 0BFh, 58h, 0, 51h, 83h, 0E1h, 1, 0FCh, 0F3h, 0A4h, 59h
	db	0D1h, 0E9h, 0F3h, 0A5h, 0E8h, 47h, 30h, 0BEh, 0A1h, 0, 8Ch, 0C3h, 9Ah
	dd	L054E8
	db	6, 8Eh, 6, 90h, 0, 0E8h, 0A2h, 0, 73h, 15h, 26h, 0C6h, 6, 4Fh, 0, 1
	db	9Bh, 0DBh, 0E3h, 9Bh, 0D9h, 0F7h, 9Bh, 2Eh, 0D9h, 36h, 24h, 15h, 0EBh, 0Dh, 90h, 2Eh
	db	0C6h, 6, 27h, 15h, 0, 26h, 0C6h, 6, 4Fh, 0, 0, 7, 0E8h, 65h, 35h, 2Eh
	db	80h, 3Eh, 27h, 15h, 0Ch, 75h, 27h, 9Bh, 2Eh, 0D9h, 36h, 24h, 15h, 2Eh, 80h, 3Eh
	db	27h, 15h, 0Ch, 74h, 19h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0
	db	0C7h, 46h, 2, 5Ch, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0BBh, 2, 0, 0E8h, 19h, 35h, 0E8h, 46h, 1, 0B8h, 0, 0, 0C3h
	db	8Bh, 1Eh, 48h, 0, 0A1h, 4Ah, 0, 2Bh, 1Eh, 0FCh, 0, 1Bh, 6, 0FEh, 0, 74h
	db	2Dh, 50h, 53h, 8Bh, 1Eh, 0F8h, 0, 0A1h, 0FAh, 0, 3Bh, 6, 46h, 0, 75h, 4
	db	3Bh, 1Eh, 44h, 0, 5Bh, 58h, 75h, 16h, 3, 1Eh, 0F8h, 0, 13h, 6, 0FAh, 0
	db	89h, 1Eh, 0F8h, 0, 0A3h, 0FAh, 0, 89h, 1Eh, 0E7h, 0, 0A3h, 0E9h, 0, 0C3h, 50h
	db	0F7h, 6, 0A8h, 0, 64h, 0, 74h, 4, 0F8h, 0EBh, 0Dh, 90h, 0CDh, 11h, 0A9h, 2
	db	0, 74h, 4, 0F9h, 0EBh, 2, 90h, 0F8h, 58h, 0C3h, 0, 0, 0, 0, 0, 0
	db	0, 0
L01690:	push	ds	;@01690
	push	di	;@01691
	push	si	;@01692
	push	cx	;@01693
	push	cx	;@01694
	push	ax	;@01695
	push	bx	;@01696
	push	cx	;@01697
	mov	cl, 4	;@01698
	db	0E8h, 86h, 31h	; call L04823	;@0169A
	pop	cx	;@0169D
	cmp	ax, 0	;@0169E
	jne	@@1	;@016A1
	mov	ds, bx	;@016A3
	pop	bx	;@016A5
	pop	ax	;@016A6
	pop	cx	;@016A7
	mov	si, bx	;@016A8
	and	si, 0Fh	;@016AA
	push	cx	;@016AD
	and	cx, 1	;@016AE
	cld	;@016B1
	rep movsb	;@016B2
	pop	cx	;@016B4
	shr	cx, 1	;@016B5
	rep movsw	;@016B7
	jmp	@@2	;@016B9
@@1:	mov	ax, seg S589_START	;@016BC
	mov	ds, ax	;@016BF
	mov	ds, word ptr ds:[90h]	;@016C1
	pop	bx	;@016C5
	pop	ax	;@016C6
	mov	word ptr ds:[79h], bx	;@016C7
	mov	word ptr ds:[7Bh], ax	;@016CB
	mov	word ptr ds:[0FFh], es	;@016CE
	mov	word ptr ds:[101h], di	;@016D2
	pop	word ptr ds:[103h]	;@016D6
	push	ds	;@016DA
	push	es	;@016DB
	pop	ds	;@016DC
	pop	es	;@016DD
	mov	bx, 6	;@016DE
	db	0E8h, 5Ch, 34h	; call L04B40	;@016E1
	call	@@3	;@016E4
	push	ds	;@016E7
	push	es	;@016E8
	pop	ds	;@016E9
	pop	es	;@016EA
@@2:	pop	cx	;@016EB
	pop	si	;@016EC
	pop	di	;@016ED
	pop	ds	;@016EE
	ret	;@016EF
	db	6, 1Eh, 57h, 56h, 50h, 53h, 51h, 52h, 51h, 50h, 53h, 51h, 0B1h, 4, 0E8h, 22h	;@016F0
	db	31h, 59h, 3Dh, 0, 0, 75h, 23h, 8Eh, 0DBh, 5Bh, 58h, 59h, 8Bh, 0F3h, 83h, 0E6h
	db	0Fh, 1Eh, 6, 1Fh, 7, 87h, 0F7h, 51h, 83h, 0E1h, 1, 0FCh, 0F3h, 0A4h, 59h, 0D1h
	db	0E9h, 0F3h, 0A5h, 1Eh, 6, 1Fh, 7, 0EBh, 39h, 90h, 8Ch, 0C1h, 8Bh, 0D7h, 0B8h
	dw	seg S589_START
	db	8Eh, 0C0h, 8Eh, 6, 90h, 0, 0B0h, 1, 0E8h, 0FBh, 2Ch, 26h, 0C7h, 45h, 6, 1Ah
	db	0, 26h, 0C7h, 45h, 8, 7, 0, 26h, 89h, 4Dh, 0Ah, 26h, 89h, 55h, 0Ch, 26h
	db	8Fh, 45h, 10h, 26h, 8Fh, 45h, 0Eh, 26h, 8Fh, 45h, 12h, 0E8h, 35h, 2Ch, 0E8h, 2Eh
	db	0, 5Ah, 59h, 5Bh, 58h, 5Eh, 5Fh, 1Fh, 7, 0C3h, 0, 0, 0, 0, 0, 1Eh
	db	51h, 50h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0C7h, 6, 50h, 0, 0, 0, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0C7h, 6, 60h, 0, 4, 0, 0E8h, 4, 0, 58h, 59h, 1Fh, 0C3h
@@3:	push	ds	;@01790
	push	ax	;@01791
	push	bx	;@01792
	push	cx	;@01793
	push	dx	;@01794
	push	si	;@01795
	push	di	;@01796
	pushf	;@01797
	mov	ax, seg S589_START	;@01798
	mov	ds, ax	;@0179B
	mov	bx, word ptr ds:[50h]	;@0179D
	cmp	bx, 0	;@017A1
	je	@@4	;@017A4
	mov	ah, 50h	;@017A6
	int	21h	;@017A8
@@4:	mov	al, byte ptr ds:[66h]	;@017AA
	db	0E8h, 0B3h, 1Fh	; call L03763	;@017AD
	cmp	ah, 1	;@017B0
	je	@@5	;@017B3
	mov	word ptr ds:[60h], 2	;@017B5
	mov	word ptr ds:[50h], 0	;@017BB
	jmp	@@6	;@017C1
@@5:	mov	ah, 51h	;@017C4
	int	21h	;@017C6
	mov	word ptr ds:[50h], bx	;@017C8
@@6:	db	0E8h, 6Eh, 35h	; call L04D3D	;@017CC
	popf	;@017CF
	pop	di	;@017D0
	pop	si	;@017D1
	pop	dx	;@017D2
	pop	cx	;@017D3
	pop	bx	;@017D4
	pop	ax	;@017D5
	pop	ds	;@017D6
	ret	;@017D7
	db	6, 53h, 50h, 0A1h, 90h, 0, 8Eh, 0C0h, 83h, 3Eh, 60h, 0, 0, 74h, 3, 0E8h	;@017D8
	db	3Ah, 1Eh, 83h, 3Eh, 60h, 0, 2, 75h, 12h, 58h, 50h, 26h, 0A3h, 81h, 1, 0C7h
	db	6, 60h, 0, 0, 0, 0BBh, 4, 0, 0E8h, 3Dh, 33h, 58h, 26h, 0A3h, 81h, 1
	db	0E8h, 85h, 0FFh, 83h, 3Eh, 60h, 0, 0, 74h, 3, 0E8h, 40h, 1Dh, 26h, 0A1h, 7Dh
	db	0, 5Bh, 7, 0C3h, 6, 53h, 55h, 8Bh, 0ECh, 83h, 0ECh, 2, 89h, 46h, 0FEh, 0A1h
	db	90h, 0, 8Eh, 0C0h, 51h, 0E8h, 0F4h, 1Dh, 59h, 51h, 8Bh, 46h, 0FEh, 26h, 0A3h, 81h
	db	1, 0C7h, 6, 60h, 0, 0, 0, 0BBh, 5, 0, 0E8h, 0FBh, 32h, 0E8h, 48h, 0FFh
	db	59h, 49h, 26h, 0A1h, 7Dh, 0, 3Dh, 1, 1, 74h, 3, 0EBh, 10h, 90h, 8Bh, 46h
	db	0FEh, 26h, 3Bh, 6, 81h, 1, 75h, 5, 83h, 0F9h, 0, 75h, 0CCh, 51h, 83h, 3Eh
	db	60h, 0, 0, 74h, 3, 0E8h, 0E5h, 1Ch, 26h, 0A1h, 7Dh, 0, 3Dh, 1, 1, 75h
	db	3, 0B8h, 0, 0, 59h, 8Bh, 0E5h, 5Dh, 5Bh, 7, 0C3h, 8Eh, 6, 90h, 0, 83h
	db	3Eh, 60h, 0, 4, 75h, 3, 0EBh, 59h, 90h, 83h, 3Eh, 60h, 0, 2, 75h, 1Ch
	db	26h, 0A3h, 81h, 1, 0C7h, 6, 60h, 0, 0, 0, 0E8h, 7Fh, 1Dh, 0BBh, 9, 0
	db	0E8h, 95h, 32h, 0E8h, 0E2h, 0FEh, 0E8h, 0A4h, 1Ch, 0EBh, 36h, 90h, 9Ch, 0FAh, 50h, 0B0h
	db	5, 0E8h, 7Bh, 2Bh, 73h, 19h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0
	db	0, 0C7h, 46h, 2, 21h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 26h, 0C7h, 45h, 6, 1Ch, 0, 58h, 26h, 89h, 45h, 0Ah, 0E8h, 9Dh
	db	2Ah, 0E8h, 0E1h, 2Bh, 9Dh, 0C7h, 6, 60h, 0, 4, 0, 0C3h, 0B8h, 2, 0, 0CDh
	db	10h, 0D1h, 0EBh, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h
	db	2, 27h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 89h, 1Eh, 64h, 0, 0C7h, 6, 60h, 0, 4, 0, 0B8h, 23h, 0
	db	8Bh, 0E5h, 0C3h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 50h, 0B3h, 19h, 0F6h, 0E3h, 8Bh, 0D8h, 81h, 0C3h
	db	20h, 19h, 58h, 0C3h, 6, 1Eh, 56h, 57h, 53h, 51h, 52h, 8Eh, 0D8h, 8Bh, 0CBh, 33h
	db	0D2h, 0BBh, 20h, 19h, 83h, 0FAh, 20h, 7Fh, 4Ch, 2Eh, 0F6h, 47h, 14h, 1, 74h, 3Fh
	db	2Eh, 0F6h, 47h, 14h, 2, 74h, 38h, 8Bh, 0F1h, 2Eh, 8Bh, 7Fh, 10h, 2Eh, 8Eh, 47h
	db	12h, 8Ah, 4, 26h, 8Ah, 25h, 3Dh, 0, 0, 75h, 5, 8Bh, 0C2h, 0EBh, 29h, 90h
	db	3Ch, 61h, 72h, 6, 3Ch, 7Ah, 77h, 2, 2Ch, 20h, 80h, 0FCh, 61h, 72h, 8, 80h
	db	0FCh, 7Ah, 77h, 3, 80h, 0ECh, 20h, 3Ah, 0C4h, 75h, 4, 46h, 47h, 0EBh, 0D2h, 42h
	db	83h, 0C3h, 19h, 0EBh, 0AFh, 0B8h, 0FFh, 0FFh, 5Ah, 59h, 5Bh, 5Fh, 5Eh, 1Fh, 7, 0C3h
	db	50h, 53h, 0E8h, 8Fh, 0FFh, 3Dh, 0FFh, 0FFh, 75h, 3, 0EBh, 4, 90h, 0E8h, 2Ah, 0
	db	5Bh, 58h, 0C3h, 50h, 53h, 51h, 8Bh, 0CBh, 0BBh, 20h, 19h, 3Dh, 20h, 0, 7Fh, 16h
	db	2Eh, 83h, 7Fh, 17h, 0, 75h, 9, 2Eh, 39h, 4Fh, 15h, 75h, 3, 0E8h, 0Ah, 0
	db	83h, 0C3h, 19h, 40h, 0EBh, 0E5h, 59h, 5Bh, 58h, 0C3h, 50h, 53h, 51h, 6, 57h, 0E8h
	db	45h, 0FFh, 2Eh, 0F6h, 47h, 14h, 1, 75h, 38h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h
	db	46h, 4, 0, 0, 0C7h, 46h, 2, 52h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h
	db	2, 53h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0B0h, 1, 0B4h, 4Ch, 0CDh, 21h, 2Eh, 0F6h, 47h, 14h, 8, 74h, 45h
	db	2Eh, 8Eh, 47h, 6, 0B4h, 49h, 2Eh, 0FFh, 1Eh, 76h, 21h, 73h, 38h, 83h, 0ECh, 4
	db	55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h, 2, 52h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h
	db	2, 53h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0B0h, 1, 0B4h, 4Ch, 0CDh, 21h, 33h, 0C0h, 0Eh, 7, 0B9h, 19h, 0
	db	8Bh, 0FBh, 0FCh, 0F3h, 0AAh, 5Fh, 7, 59h, 5Bh, 58h, 0C3h, 26h, 8Ah, 45h, 4, 0E8h
	db	3Eh, 27h, 26h, 0C7h, 45h, 0Ch, 0, 0, 8Ch, 0C0h, 8Bh, 0DEh, 0E8h, 0A1h, 0FEh, 3Dh
	db	0FFh, 0FFh, 75h, 15h, 8Ch, 0C0h, 8Bh, 0DEh, 0E8h, 0DCh, 1, 3Dh, 0FFh, 0FFh, 75h, 9
	db	26h, 0C7h, 45h, 0Ch, 2, 0, 0EBh, 1Dh, 90h, 26h, 89h, 45h, 0Ah, 50h, 0E8h, 7Eh
	db	1, 58h, 0E8h, 6Eh, 0FEh, 2Eh, 8Bh, 7, 2Eh, 0Bh, 47h, 2, 75h, 7, 2Eh, 89h
	db	17h, 2Eh, 89h, 4Fh, 2, 0C3h, 55h, 8Bh, 0ECh, 56h, 8Bh, 46h, 16h, 8Bh, 5Eh, 18h
	db	0E8h, 5Dh, 0FEh, 3Dh, 0FFh, 0FFh, 74h, 6, 0B8h, 32h, 0, 0EBh, 6Ch, 90h, 0E8h, 72h
	db	1, 3Dh, 0FFh, 0FFh, 75h, 6, 0B8h, 33h, 0, 0EBh, 5Eh, 90h, 0E8h, 34h, 0FEh, 2Eh
	db	80h, 4Fh, 14h, 2, 2Eh, 80h, 4Fh, 14h, 4, 8Bh, 46h, 0Eh, 2Eh, 89h, 7, 8Bh
	db	4Eh, 0Ch, 2Eh, 89h, 4Fh, 2, 8Bh, 46h, 10h, 2Eh, 89h, 47h, 4, 8Bh, 46h, 14h
	db	2Eh, 89h, 47h, 8, 8Bh, 46h, 12h, 2Eh, 89h, 47h, 0Ah, 8Bh, 46h, 18h, 2Eh, 89h
	db	47h, 10h, 8Bh, 46h, 16h, 2Eh, 89h, 47h, 12h, 8Bh, 46h, 8, 2Eh, 89h, 47h, 0Ch
	db	8Bh, 46h, 0Ah, 2Eh, 89h, 47h, 0Eh, 8Bh, 46h, 6, 2Eh, 89h, 47h, 15h, 8Bh, 46h
	db	4, 2Eh, 89h, 47h, 17h, 8Bh, 0D0h, 33h, 0C0h, 5Eh, 8Bh, 0E5h, 5Dh, 0C3h, 53h, 50h
	db	8Bh, 0C3h, 0E8h, 0CEh, 0FDh, 58h, 2Eh, 89h, 77h, 4, 2Eh, 89h, 17h, 2Eh, 89h, 47h
	db	2, 5Bh, 0C3h, 26h, 8Bh, 45h, 8, 3Dh, 1, 0, 75h, 6, 0E8h, 4Bh, 0, 0EBh
	db	48h, 90h, 3Dh, 2, 0, 75h, 0Ah, 26h, 8Bh, 45h, 0Ah, 0E8h, 58h, 0FEh, 0EBh, 39h
	db	90h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h, 2, 52h
	db	0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h
	db	2, 53h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0B0h, 1, 0B4h, 4Ch, 0CDh, 21h, 0C3h, 26h, 8Bh, 45h, 0Ah, 32h, 0E4h
	db	3Dh, 20h, 0, 7Eh, 9, 26h, 0C7h, 45h, 0Ah, 6, 0, 0EBh, 61h, 90h, 0E8h, 52h
	db	0FDh, 2Eh, 0F6h, 47h, 14h, 1, 75h, 9, 26h, 0C7h, 45h, 0Ah, 6, 0, 0EBh, 4Eh
	db	90h, 26h, 8Ah, 45h, 4, 0E8h, 0D8h, 25h, 26h, 8Bh, 45h, 0Ch, 8Bh, 0D8h, 26h, 8Bh
	db	4Dh, 0Eh, 57h, 6, 8Bh, 0D6h, 6, 1Fh, 9Ch, 0FBh, 53h, 51h, 1Eh, 52h, 53h, 26h
	db	8Bh, 45h, 0Ah, 0E8h, 1Dh, 0FDh, 8Bh, 0FBh, 5Bh, 2Eh, 0F6h, 45h, 14h, 4, 74h, 8
	db	2Eh, 8Eh, 45h, 0Ch, 2Eh, 8Eh, 5Dh, 0Eh, 8Bh, 0C3h, 0FCh, 2Eh, 0FFh, 1Dh, 83h, 0C4h
	db	8, 9Dh, 7, 5Fh, 26h, 89h, 45h, 0Ch, 26h, 0C7h, 45h, 0Ah, 0, 0, 0C3h, 1Eh
	db	6, 56h, 0E8h, 0EEh, 0FCh, 2Eh, 8Bh, 47h, 8, 2Eh, 0Bh, 47h, 0Ah, 75h, 3, 0EBh
	db	0Eh, 90h, 8Bh, 0F3h, 0Eh, 7, 0BBh, 11h, 21h, 2Eh, 0FFh, 5Ch, 8, 8Ch, 0D9h, 5Eh
	db	7, 1Fh, 0C3h, 53h, 33h, 0C0h, 0BBh, 20h, 19h, 3Dh, 20h, 0, 7Fh, 14h, 2Eh, 0F6h
	db	47h, 14h, 1, 75h, 7, 2Eh, 0C6h, 47h, 14h, 1, 0EBh, 9, 83h, 0C3h, 19h, 40h
	db	0EBh, 0E7h, 0B8h, 0FFh, 0FFh, 5Bh, 0C3h, 1Eh, 57h, 6, 55h, 8Bh, 0ECh, 83h, 0ECh, 0Ah
	db	8Eh, 0D8h, 8Bh, 0D3h, 0E8h, 0CCh, 0FFh, 89h, 46h, 0FEh, 3Dh, 0FFh, 0FFh, 75h, 3, 0E9h
	db	34h, 1, 33h, 0C0h, 0B4h, 3Dh, 0CDh, 21h, 73h, 7, 26h, 89h, 45h, 0Ah, 0E9h, 16h
	db	1, 0Eh, 1Fh, 8Bh, 0D8h, 0BAh, 40h, 1Ch, 0B9h, 20h, 0, 0B4h, 3Fh, 0CDh, 21h, 73h
	db	0Bh, 0B4h, 3Eh, 0CDh, 21h, 26h, 89h, 45h, 0Ah, 0E9h, 0FBh, 0, 0B0h, 2, 33h, 0C9h
	db	33h, 0D2h, 0B4h, 42h, 0CDh, 21h, 73h, 0Bh, 0B4h, 3Eh, 0CDh, 21h, 26h, 89h, 45h, 0Ah
	db	0E9h, 0E4h, 0, 53h, 8Bh, 0D8h, 8Bh, 0C2h, 89h, 5Eh, 0F6h, 89h, 46h, 0F8h, 5Bh, 0B4h
	db	3Eh, 0CDh, 21h, 0A1h, 40h, 1Ch, 3Dh, 4Dh, 5Ah, 74h, 9, 26h, 0C7h, 45h, 0Ah, 5
	db	0, 0E9h, 0C3h, 0, 8Bh, 1Eh, 48h, 1Ch, 0B0h, 4, 0E8h, 0B2h, 27h, 50h, 53h, 50h
	db	53h, 57h, 8Bh, 3Eh, 42h, 1Ch, 8Bh, 1Eh, 44h, 1Ch, 83h, 0FFh, 0, 74h, 1, 4Bh
	db	0B0h, 9, 0E8h, 9Ah, 27h, 3, 0DFh, 15h, 0, 0, 5Fh, 5Ah, 59h, 2Bh, 0DAh, 1Bh
	db	0C1h, 89h, 5Eh, 0FAh, 89h, 46h, 0FCh, 8Bh, 5Eh, 0F6h, 8Bh, 46h, 0F8h, 5Ah, 59h, 2Bh
	db	0DAh, 1Bh, 0C1h, 83h, 0C3h, 0Fh, 15h, 0, 0, 51h, 0B1h, 4, 0E8h, 94h, 27h, 59h
	db	43h, 0B4h, 48h, 2Eh, 0FFh, 1Eh, 72h, 21h, 73h, 7, 26h, 89h, 45h, 0Ah, 0EBh, 67h
	db	90h, 0A3h, 60h, 1Ch, 0A3h, 62h, 1Ch, 1, 6, 56h, 1Ch, 0BBh, 60h, 1Ch, 26h, 8Ah
	db	45h, 4, 0E8h, 5Bh, 24h, 1Eh, 6, 1Fh, 7, 8Bh, 0D6h, 0B0h, 3, 0B4h, 4Bh, 0CDh
	db	21h, 1Eh, 6, 1Fh, 7, 8Bh, 5Eh, 0FAh, 8Bh, 46h, 0FCh, 83h, 0C3h, 0Fh, 15h, 0
	db	0, 51h, 0B1h, 4, 0E8h, 4Ch, 27h, 59h, 43h, 8Eh, 6, 60h, 1Ch, 0B4h, 4Ah, 0CDh
	db	21h, 8Bh, 46h, 0FEh, 0E8h, 8Ch, 0FBh, 0A1h, 54h, 1Ch, 89h, 47h, 8, 0A1h, 56h, 1Ch
	db	89h, 47h, 0Ah, 8Ch, 47h, 6, 0C7h, 47h, 15h, 0, 0, 0C7h, 47h, 17h, 0, 0
	db	80h, 4Fh, 14h, 8, 0EBh, 10h, 90h, 8Bh, 46h, 0FEh, 0E8h, 66h, 0FBh, 80h, 67h, 14h
	db	0FEh, 0C7h, 46h, 0FEh, 0FFh, 0FFh, 8Bh, 46h, 0FEh, 8Bh, 0E5h, 5Dh, 7, 5Fh, 1Fh, 0C3h
L02111:	push	es	;@02111
	push	ds	;@02112
	push	di	;@02113
	push	ax	;@02114
	mov	ax, seg S589_START	;@02115
	mov	ds, ax	;@02118
	mov	es, word ptr ds:[90h]	;@0211A
	mov	al, 5	;@0211E
	db	0E8h, 14h, 23h	; call L04437	;@02120
	mov	word ptr es:[di+6], 22h	;@02123
	pop	ax	;@02129
	xor	ah, ah	;@0212A
	mov	word ptr es:[di+8], ax	;@0212C
	mov	word ptr es:[di+0Ah], ax	;@02130
	mov	word ptr es:[di+0Ch], bx	;@02134
	mov	word ptr es:[di+0Eh], cx	;@02138
	mov	word ptr es:[di+10h], dx	;@0213C
	pop	word ptr es:[di+14h]	;@02140
	mov	word ptr es:[di+12h], si	;@02144
	db	0E8h, 37h, 22h	; call L04382	;@02148
	mov	ax, word ptr es:[di+0Ah]	;@0214B
	mov	bx, word ptr es:[di+0Ch]	;@0214F
	mov	cx, word ptr es:[di+0Eh]	;@02153
	mov	dx, word ptr es:[di+10h]	;@02157
	mov	si, word ptr es:[di+12h]	;@0215B
	push	word ptr es:[di+14h]	;@0215F
	db	0E8h, 63h, 23h	; call L044C9	;@02163
	pop	di	;@02166
	pop	ds	;@02167
	pop	es	;@02168
	retf	;@02169
L0216A	db	0, 0, 0, 0, 0, 0, 0, 0	;@0216A
	dd	L00ED0
	dd	L00ED3
	db	0, 0, 0, 0, 0, 0, 1, 1Eh, 6, 2Eh, 89h, 1Eh, 7Ah, 21h, 0B0h, 23h
	db	0B4h, 35h, 0CDh, 21h, 2Eh, 8Ch, 6, 7Eh, 21h, 2Eh, 89h, 1Eh, 7Ch, 21h, 0BAh, 5Fh
	db	42h, 8Ch, 0C8h, 8Eh, 0D8h, 0B0h, 23h, 0B4h, 25h, 0CDh, 21h, 7, 1Fh, 0C3h, 50h, 52h
	db	1Eh, 0B4h, 50h, 0CDh, 21h, 2Eh, 0C5h, 16h, 7Ch, 21h, 0B0h, 23h, 0B4h, 25h, 0CDh, 21h
	db	1Fh, 5Ah, 58h, 0C3h, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0B8h, 1, 0, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh
L021D3:	push	bp	;@021D3
	mov	bp, sp	;@021D4
	push	ds	;@021D6
	push	es	;@021D7
	push	si	;@021D8
	push	di	;@021D9
	mov	ax, seg S589_START	;@021DA
	mov	ds, ax	;@021DD
	db	0BAh	;@021DF
	dw	seg S589_START
	db	0B8h, 0A1h, 0	; mov ax, 0A1h	;@021E2
	pop	di	;@021E5
	pop	si	;@021E6
	pop	es	;@021E7
	pop	ds	;@021E8
	pop	bp	;@021E9
	retf	;@021EA
	db	55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h	;@021EB
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 26h, 0A0h, 67h, 2, 26h, 3Ah, 6, 66h, 2, 75h
	db	5, 33h, 0C0h, 0EBh, 4, 90h, 0B8h, 1, 0, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h
	db	8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Bh, 46h, 6, 8Eh, 46h, 0Ah, 8Bh, 7Eh, 8, 6, 57h, 26h, 8Bh, 5Dh
	db	2, 26h, 8Bh, 4Dh, 4, 26h, 8Bh, 55h, 6, 26h, 8Bh, 75h, 0Ah, 26h, 8Bh, 7Dh
	db	0Ch, 9Ah
	dd	L02111
	db	5Fh, 7, 26h, 89h, 5Dh, 2, 26h, 89h, 4Dh, 4, 26h, 89h, 55h, 6, 26h, 89h
	db	75h, 0Ah, 26h, 89h, 7Dh, 0Ch, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh
	db	6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Bh, 46h, 8, 8Bh, 5Eh, 6, 0A3h, 82h, 0, 89h, 1Eh, 80h, 0, 0Bh
	db	0C3h, 75h, 8, 0C6h, 6, 84h, 0, 0, 0EBh, 6, 90h, 0C6h, 6, 84h, 0, 1
	db	5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 0, 0, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 2Eh, 0A1h, 90h, 22h, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh
	db	6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Bh, 46h, 6, 2Eh, 0A3h, 90h, 22h, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h
	db	8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0B8h, 0, 2, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6
	db	56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 26h, 80h, 3Eh, 16h, 1, 0, 75h, 6, 0B8h, 1Eh
	db	1, 0EBh, 4, 90h, 0B8h, 82h, 1, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh
	db	1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 8Bh, 46h, 6, 0E8h, 0D4h, 0EBh, 0A3h, 62h, 0, 26h
	db	0A0h, 16h, 1, 0A2h, 0C2h, 0, 0A2h, 0C6h, 0, 0A1h, 62h, 0, 5Fh, 5Eh, 7, 1Fh
	db	5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0B4h, 51h, 0CDh, 21h, 53h, 0E8h, 44h, 0FEh, 8Eh, 6, 90h, 0, 0B0h, 5
	db	0E8h, 0F1h, 20h, 26h, 0C7h, 45h, 6, 1Dh, 0, 26h, 0C7h, 45h, 8, 1, 0, 26h
	db	89h, 5Dh, 0Ch, 0E8h, 29h, 20h, 26h, 8Bh, 45h, 0Ah, 0E8h, 69h, 21h, 3Dh, 0, 0
	db	74h, 9, 0B8h, 14h, 0, 0A3h, 62h, 0, 0E9h, 35h, 1, 1Eh, 0E8h, 98h, 11h, 8Eh
	db	5Eh, 8, 8Bh, 76h, 6, 0BFh, 0ADh, 1, 0FCh, 0ACh, 0AAh, 3Ch, 0, 75h, 0FAh, 8Bh
	db	46h, 0Ch, 8Bh, 5Eh, 0Ah, 26h, 89h, 1Eh, 23h, 2, 26h, 0A3h, 25h, 2, 8Eh, 5Eh
	db	10h, 8Bh, 76h, 0Eh, 0BFh, 7Fh, 0, 8Ah, 0Ch, 32h, 0EDh, 83h, 0C1h, 2, 51h, 0F3h
	db	0A4h, 59h, 83h, 0F9h, 0, 75h, 9, 0B0h, 20h, 0AAh, 0B0h, 0Dh, 0AAh, 0B0h, 0, 0AAh
	db	1Fh, 0E8h, 0C9h, 12h, 75h, 6, 50h, 50h, 50h, 0EBh, 0Dh, 90h, 0B8h, 1, 0, 0A2h
	db	70h, 0, 50h, 0E8h, 0CCh, 12h, 6, 57h, 8Eh, 6, 90h, 0, 26h, 8Fh, 6, 2Dh
	db	2, 26h, 8Fh, 6, 2Fh, 2, 58h, 26h, 0A2h, 2Ch, 2, 26h, 8Bh, 1Eh, 2Fh, 2
	db	0B0h, 4, 0E8h, 8, 24h, 26h, 3, 1Eh, 2Dh, 2, 15h, 0, 0, 26h, 89h, 1Eh
	db	31h, 2, 26h, 0A3h, 33h, 2, 0B0h, 1, 0E8h, 39h, 20h, 26h, 0C7h, 45h, 6, 1Ah
	db	0, 26h, 0C7h, 45h, 8, 3, 0, 0B4h, 51h, 0CDh, 21h, 26h, 89h, 5Dh, 0Ch, 0E8h
	db	88h, 7, 26h, 89h, 4Dh, 0Eh, 0E8h, 78h, 1Fh, 0E8h, 71h, 0F3h, 26h, 0A1h, 7Dh, 0
	db	3Dh, 0, 0, 74h, 9, 0C7h, 6, 60h, 0, 4, 0, 0EBh, 5Fh, 90h, 0C7h, 6
	db	60h, 0, 2, 0, 0B0h, 1, 0E8h, 0FBh, 1Fh, 26h, 0C7h, 45h, 6, 1Ah, 0, 26h
	db	0C7h, 45h, 8, 8, 0, 0E8h, 52h, 7, 81h, 0F9h, 0, 10h, 76h, 1Ch, 83h, 0ECh
	db	4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h, 2, 16h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0B9h, 0, 10h, 0E8h, 0A9h, 20h, 26h, 89h, 4Dh, 0Eh, 57h, 6, 1Eh
	db	8Bh, 0FEh, 8Eh, 5Eh, 14h, 8Bh, 76h, 12h, 0E8h, 41h, 7, 1Fh, 7, 5Fh, 0E8h, 0Ch
	db	1Fh, 0E8h, 5, 0F3h, 26h, 0A1h, 7Dh, 0, 0A3h, 62h, 0, 26h, 8Bh, 1Eh, 81h, 1
	db	1Eh, 56h, 8Eh, 5Eh, 18h, 8Bh, 76h, 16h, 89h, 1Ch, 5Eh, 1Fh, 5Bh, 0E8h, 1, 0FDh
	db	0A1h, 62h, 0, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h
	db	0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 8Bh, 46h, 6, 0E8h, 26h, 7, 72h, 0Ch, 8Bh, 76h
	db	8, 8Eh, 5Eh, 0Ch, 8Bh, 5Eh, 0Ah, 0E8h, 6, 25h, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh
	db	55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0B4h, 51h, 0CDh, 21h, 53h, 0E8h, 93h, 0FCh, 8Bh, 5Eh, 8, 83h, 0FBh, 1
	db	75h, 9, 2Eh, 0C6h, 6, 80h, 21h, 0, 0EBh, 15h, 90h, 83h, 0FBh, 5, 75h, 9
	db	2Eh, 0C6h, 6, 80h, 21h, 0, 0EBh, 7, 90h, 2Eh, 0C6h, 6, 80h, 21h, 1, 8Bh
	db	46h, 6, 0E8h, 0D3h, 6, 73h, 6, 0B8h, 3, 0, 0EBh, 64h, 90h, 8Bh, 5Eh, 8
	db	83h, 0FBh, 0, 75h, 0Bh, 0C6h, 6, 66h, 0, 0, 0E8h, 0A7h, 0F2h, 0EBh, 4Eh, 90h
	db	83h, 0FBh, 3, 75h, 0Eh, 0B9h, 1, 0, 0C6h, 6, 66h, 0, 0, 0E8h, 0D8h, 0F2h
	db	0EBh, 3Bh, 90h, 83h, 0FBh, 1, 75h, 13h, 0C6h, 6, 66h, 0, 1, 8Bh, 1Eh, 71h
	db	0, 89h, 1Eh, 52h, 0, 0E8h, 7Ch, 0F2h, 0EBh, 23h, 90h, 83h, 0FBh, 5, 75h, 13h
	db	0C6h, 6, 66h, 0, 2, 8Bh, 1Eh, 71h, 0, 89h, 1Eh, 52h, 0, 0E8h, 64h, 0F2h
	db	0EBh, 0Bh, 90h, 83h, 0FBh, 4, 75h, 5, 0E8h, 4, 0F3h, 33h, 0C0h, 0A3h, 62h, 0
	db	80h, 3Eh, 66h, 0, 0, 75h, 45h, 80h, 3Eh, 4Ch, 0, 0, 74h, 3Eh, 8Eh, 6
	db	90h, 0, 3Dh, 0, 1, 73h, 35h, 26h, 83h, 3Eh, 4Dh, 0, 0, 74h, 3, 0E8h
	db	0CAh, 29h, 2Eh, 83h, 3Eh, 0E5h, 0Eh, 0, 74h, 18h, 0B4h, 0Dh, 2Eh, 8Bh, 16h, 0E5h
	db	0Eh, 2Eh, 0FFh, 1Eh, 0E1h, 0Eh, 0B4h, 0Ah, 2Eh, 8Bh, 16h, 0E5h, 0Eh, 2Eh, 0FFh, 1Eh
	db	0E1h, 0Eh, 80h, 3Eh, 4Dh, 0, 0, 74h, 3, 0E8h, 15h, 0DCh, 0C6h, 6, 66h, 0
	db	0, 5Bh, 0E8h, 0CFh, 0FBh, 0A1h, 62h, 0, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh
	db	0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0B4h, 51h, 0CDh, 21h, 53h, 0E8h, 8Bh, 0FBh, 8Bh, 46h, 6, 0E8h, 0F0h, 5
	db	73h, 6, 0B8h, 3, 0, 0EBh, 1Ch, 90h, 1Eh, 56h, 8Eh, 5Eh, 0Ah, 8Bh, 76h, 8
	db	8Bh, 0Ch, 5Eh, 1Fh, 0E8h, 9, 0F2h, 1Eh, 56h, 8Eh, 5Eh, 0Ah, 8Bh, 76h, 8, 89h
	db	0Ch, 5Eh, 1Fh, 0A3h, 62h, 0, 5Bh, 0E8h, 82h, 0FBh, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh
	db	55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Bh, 46h, 8, 8Bh, 5Eh, 6, 53h, 50h, 8Bh, 46h, 0Ch, 8Bh, 5Eh, 0Ah
	db	53h, 50h, 8Bh, 46h, 10h, 8Bh, 5Eh, 0Eh, 33h, 0C9h, 51h, 53h, 50h, 8Bh, 46h, 0FEh
	db	50h, 8Bh, 46h, 0FCh, 50h, 33h, 0C0h, 50h, 50h, 0E8h, 0A5h, 0F7h, 83h, 0C4h, 16h, 5Fh
	db	5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Bh, 46h, 8, 8Bh, 5Eh, 6, 0E8h, 5Dh, 0F6h, 5Fh, 5Eh, 7, 1Fh, 5Dh
	db	0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 8Bh, 46h, 0Ah, 8Bh, 5Eh, 8, 0A3h, 5Eh, 0, 89h
	db	1Eh, 5Ch, 0, 8Bh, 0C8h, 0Bh, 0CBh, 75h, 8, 0C6h, 6, 55h, 0, 0, 0EBh, 6
	db	90h, 0C6h, 6, 55h, 0, 1, 33h, 0C0h, 0A3h, 62h, 0, 5Fh, 5Eh, 7, 1Fh, 5Dh
	db	0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Bh, 46h, 6, 0E8h, 19h, 5, 73h, 6, 0B8h, 3, 0, 0EBh, 19h, 90h
	db	8Bh, 46h, 0Ch, 8Bh, 5Eh, 0Ah, 8Bh, 4Eh, 0Eh, 8Bh, 56h, 6, 8Bh, 76h, 8, 8Eh
	db	46h, 12h, 8Bh, 7Eh, 10h, 0E8h, 0FCh, 23h, 0A3h, 62h, 0, 5Fh, 5Eh, 7, 1Fh, 5Dh
	db	0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Bh, 46h, 6, 0E8h, 0DEh, 4, 73h, 6, 0B8h, 3, 0, 0EBh, 19h, 90h
	db	8Bh, 46h, 0Ch, 8Bh, 5Eh, 0Ah, 8Bh, 4Eh, 0Eh, 8Bh, 56h, 6, 8Bh, 76h, 8, 8Eh
	db	46h, 12h, 8Bh, 7Eh, 10h, 0E8h, 0E2h, 23h, 0A3h, 62h, 0, 5Fh, 5Eh, 7, 1Fh, 5Dh
	db	0CBh
L02737:	push	bp	;@02737
	mov	bp, sp	;@02738
	push	ds	;@0273A
	push	es	;@0273B
	push	si	;@0273C
	push	di	;@0273D
	mov	ax, seg S589_START	;@0273E
	mov	ds, ax	;@02741
	mov	es, word ptr ds:[90h]	;@02743
	xor	ax, ax	;@02747
	xchg	word ptr es:[187h], ax	;@02749
	push	ax	;@0274E
	mov	ax, word ptr [bp+6]	;@0274F
	call	L02BEC	;@02752
	jae	@@1	;@02755
	mov	ax, 3	;@02757
	jmp	@@2	;@0275A
@@1:	mov	ax, word ptr [bp+0Ch]	;@0275D
	mov	bx, word ptr [bp+0Ah]	;@02760
	mov	cx, word ptr [bp+0Eh]	;@02763
	mov	dx, word ptr [bp+6]	;@02766
	mov	si, word ptr [bp+8]	;@02769
	mov	es, word ptr [bp+12h]	;@0276C
	mov	di, word ptr [bp+10h]	;@0276F
	call	L04AEF	;@02772
@@2:	mov	word ptr ds:[62h], ax	;@02775
	mov	es, word ptr ds:[90h]	;@02778
	pop	word ptr es:[187h]	;@0277C
	pop	di	;@02781
	pop	si	;@02782
	pop	es	;@02783
	pop	ds	;@02784
	pop	bp	;@02785
	retf	;@02786
	db	55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h	;@02787
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 33h, 0C0h, 26h, 87h, 6, 87h, 1, 50h, 8Bh, 46h
	db	6, 0E8h, 47h, 4, 73h, 6, 0B8h, 3, 0, 0EBh, 19h, 90h, 8Bh, 46h, 0Ch, 8Bh
	db	5Eh, 0Ah, 8Bh, 4Eh, 0Eh, 8Bh, 56h, 6, 8Bh, 76h, 8, 8Eh, 46h, 12h, 8Bh, 7Eh
	db	10h, 0E8h, 4Bh, 23h, 0A3h, 62h, 0, 8Eh, 6, 90h, 0, 26h, 8Fh, 6, 87h, 1
	db	5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 8Bh, 46h, 6, 3Dh, 0, 0, 75h, 0Ch, 26h, 0A1h
	db	3Ch, 1, 26h, 8Bh, 16h, 3Eh, 1, 0EBh, 28h, 90h, 3Dh, 2, 0, 75h, 0Ch, 26h
	db	0A1h, 44h, 1, 26h, 8Bh, 16h, 46h, 1, 0EBh, 17h, 90h, 3Dh, 3, 0, 75h, 0Ch
	db	26h, 0A1h, 48h, 1, 26h, 8Bh, 16h, 4Ah, 1, 0EBh, 6, 90h, 0B8h, 0FFh, 0FFh, 8Bh
	db	0D0h, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 8Bh, 46h, 0Ah, 8Bh, 5Eh, 8, 8Bh, 4Eh, 6, 83h
	db	0F9h, 0, 75h, 0Ch, 26h, 89h, 1Eh, 3Ch, 1, 26h, 0A3h, 3Eh, 1, 0EBh, 20h, 90h
	db	83h, 0F9h, 2, 75h, 0Ch, 26h, 89h, 1Eh, 44h, 1, 26h, 0A3h, 46h, 1, 0EBh, 0Fh
	db	90h, 83h, 0F9h, 3, 75h, 9, 26h, 89h, 1Eh, 48h, 1, 26h, 0A3h, 4Ah, 1, 5Fh
	db	5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 8Bh, 46h, 6, 3Dh, 0, 0, 75h, 0Ch, 26h, 0A1h
	db	1Ch, 1, 26h, 8Bh, 16h, 1Eh, 1, 0EBh, 7Dh, 90h, 3Dh, 1, 0, 75h, 0Ch, 26h
	db	0A1h, 20h, 1, 26h, 8Bh, 16h, 22h, 1, 0EBh, 6Ch, 90h, 3Dh, 2, 0, 75h, 0Ch
	db	26h, 0A1h, 24h, 1, 26h, 8Bh, 16h, 26h, 1, 0EBh, 5Bh, 90h, 3Dh, 3, 0, 75h
	db	0Ch, 26h, 0A1h, 28h, 1, 26h, 8Bh, 16h, 2Ah, 1, 0EBh, 4Ah, 90h, 3Dh, 4, 0
	db	75h, 0Ch, 26h, 0A1h, 2Ch, 1, 26h, 8Bh, 16h, 2Eh, 1, 0EBh, 39h, 90h, 3Dh, 5
	db	0, 75h, 0Ch, 26h, 0A1h, 30h, 1, 26h, 8Bh, 16h, 32h, 1, 0EBh, 28h, 90h, 3Dh
	db	6, 0, 75h, 0Ch, 26h, 0A1h, 34h, 1, 26h, 8Bh, 16h, 36h, 1, 0EBh, 17h, 90h
	db	3Dh, 7, 0, 75h, 0Ch, 26h, 0A1h, 38h, 1, 26h, 8Bh, 16h, 3Ah, 1, 0EBh, 6
	db	90h, 0B8h, 0FFh, 0FFh, 8Bh, 0D0h, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh
	db	6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 8Bh, 46h, 0Ah, 8Bh, 5Eh, 8, 8Bh, 4Eh, 6, 83h
	db	0F9h, 0, 75h, 0Ch, 26h, 89h, 1Eh, 1Ch, 1, 26h, 0A3h, 1Eh, 1, 0EBh, 7Dh, 90h
	db	83h, 0F9h, 1, 75h, 0Ch, 26h, 89h, 1Eh, 20h, 1, 26h, 0A3h, 22h, 1, 0EBh, 6Ch
	db	90h, 83h, 0F9h, 2, 75h, 0Ch, 26h, 89h, 1Eh, 24h, 1, 26h, 0A3h, 26h, 1, 0EBh
	db	5Bh, 90h, 83h, 0F9h, 3, 75h, 0Ch, 26h, 89h, 1Eh, 28h, 1, 26h, 0A3h, 2Ah, 1
	db	0EBh, 4Ah, 90h, 83h, 0F9h, 4, 75h, 0Ch, 26h, 89h, 1Eh, 2Ch, 1, 26h, 0A3h, 2Eh
	db	1, 0EBh, 39h, 90h, 83h, 0F9h, 5, 75h, 0Ch, 26h, 89h, 1Eh, 30h, 1, 26h, 0A3h
	db	32h, 1, 0EBh, 28h, 90h, 83h, 0F9h, 6, 75h, 0Ch, 26h, 89h, 1Eh, 34h, 1, 26h
	db	0A3h, 36h, 1, 0EBh, 17h, 90h, 83h, 0F9h, 7, 75h, 0Ch, 26h, 89h, 1Eh, 38h, 1
	db	26h, 0A3h, 3Ah, 1, 0EBh, 6, 90h, 0B8h, 0FFh, 0FFh, 8Bh, 0D0h, 5Fh, 5Eh, 7, 1Fh
	db	5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 26h, 0A1h, 7Bh, 1, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh
	db	55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 26h, 0A0h, 4Dh, 1, 32h, 0E4h, 5Fh, 5Eh, 7, 1Fh
	db	5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 26h, 0A1h, 81h, 1, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh
	db	55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 6, 8Eh, 6, 90h, 0, 8Bh, 46h, 6, 0E8h, 0BCh, 1, 72h, 6, 8Bh
	db	46h, 6, 0EBh, 3, 90h, 33h, 0C0h, 7, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh
L02A41:	push	bp	;@02A41
	mov	bp, sp	;@02A42
	push	ds	;@02A44
	push	es	;@02A45
	push	si	;@02A46
	push	di	;@02A47
	mov	ax, seg S589_START	;@02A48
	mov	ds, ax	;@02A4B
	mov	es, word ptr ds:[90h]	;@02A4D
	mov	si, word ptr [bp+8]	;@02A51
	mov	ax, word ptr [bp+0Ch]	;@02A54
	mov	bx, word ptr [bp+0Ah]	;@02A57
	mov	cx, word ptr [bp+6]	;@02A5A
	call	L04992	;@02A5D
	jne	@@1	;@02A60
	xor	ax, ax	;@02A62
	mov	dx, ax	;@02A64
	jmp	@@2	;@02A66
@@1:	mov	dx, ax	;@02A69
	mov	ax, bx	;@02A6B
@@2:	pop	di	;@02A6D
	pop	si	;@02A6E
	pop	es	;@02A6F
	pop	ds	;@02A70
	pop	bp	;@02A71
	retf	;@02A72
L02A73	db	55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h	;@02A73
	dw	seg S589_START
	db	8Eh, 0D8h, 83h, 7Eh, 6, 0, 75h, 5, 0C7h, 46h, 6, 1, 0, 8Bh, 46h, 6
	db	0A3h, 71h, 0, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h
	db	0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 5Eh, 8, 8Bh, 76h, 6, 0E8h, 0B8h, 0, 26h, 0C7h, 45h, 8, 0
	db	0, 0E8h, 0CEh, 18h, 26h, 8Bh, 45h, 0Ah, 0E8h, 0Eh, 1Ah, 5Fh, 5Eh, 7, 1Fh, 5Dh
	db	0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 5Eh, 8, 8Bh, 76h, 6, 0E8h, 8Dh, 0, 26h, 0C7h, 45h, 8, 1
	db	0, 8Bh, 46h, 0Ch, 26h, 89h, 45h, 0Eh, 8Bh, 46h, 0Ah, 26h, 89h, 45h, 10h, 0E8h
	db	95h, 18h, 26h, 8Bh, 45h, 0Ah, 0E8h, 0D5h, 19h, 5Fh, 5Eh, 7, 1Fh, 5Dh, 0CBh, 55h
	db	8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 5Eh, 8, 8Bh, 76h, 6, 0E8h, 54h, 0, 26h, 0C7h, 45h, 8, 2
	db	0, 0E8h, 6Ah, 18h, 8Eh, 5Eh, 0Ch, 8Bh, 76h, 0Ah, 26h, 8Bh, 45h, 10h, 89h, 4
	db	26h, 8Bh, 45h, 0Eh, 89h, 44h, 2, 26h, 8Bh, 45h, 0Ah, 0E8h, 97h, 19h, 5Fh, 5Eh
	db	7, 1Fh, 5Dh, 0CBh, 55h, 8Bh, 0ECh, 1Eh, 6, 56h, 57h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 5Eh, 8, 8Bh, 76h, 6, 0E8h, 16h, 0, 26h, 0C7h, 45h, 8, 0
	db	0, 0E8h, 2Ch, 18h, 26h, 8Bh, 45h, 0Ah, 0E8h, 6Ch, 19h, 5Fh, 5Eh, 7, 1Fh, 5Dh
	db	0CBh, 50h, 53h, 51h, 56h, 1Eh, 8Bh, 0DEh, 1Eh, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 8Eh, 6, 90h, 0, 1Fh, 0B0h, 5, 0E8h, 0BDh, 18h, 26h, 0C7h, 45h, 6
	db	8, 0, 0B9h, 8, 0, 0E8h, 93h, 19h, 87h, 0FBh, 87h, 0F7h, 0B9h, 8, 0, 0FCh
	db	0F3h, 0A4h, 8Bh, 0FBh, 1Fh, 5Eh, 59h, 5Bh, 58h, 0C3h, 0EAh
	dd	L02A41
	db	50h, 53h, 6, 0B4h, 62h, 0CDh, 21h, 8Eh, 0C3h, 26h, 8Bh, 1Eh, 2Ch, 0, 4Bh, 8Eh
	db	0C3h, 26h, 8Bh, 0Eh, 3, 0, 83h, 0C1h, 5, 0D1h, 0E1h, 0D1h, 0E1h, 0D1h, 0E1h, 0D1h
	db	0E1h, 7, 5Bh, 58h, 0C3h, 0, 53h, 0FCh, 0B4h, 1, 0BBh, 0DCh, 2Bh, 0ACh, 0AAh, 0Ah
	db	0E0h, 75h, 6, 0EBh, 8, 90h, 0EBh, 5, 90h, 8Ah, 0E0h, 0EBh, 0F0h, 5Bh, 0C3h, 50h
	db	52h, 4Fh, 4Dh, 50h, 54h, 3Dh, 0, 0, 0, 0, 0, 0, 0, 0, 0
L02BEC:	cmp	byte ptr cs:L0216A+22, 0	;@02BEC
	jne	@@1	;@02BF2
	clc	;@02BF4
	ret	;@02BF5
@@1:	push	ax	;@02BF6
	push	bx	;@02BF7
	push	cx	;@02BF8
	push	si	;@02BF9
	push	ds	;@02BFA
	push	es	;@02BFB
	mov	es, word ptr ds:[90h]	;@02BFC
	xor	bx, bx	;@02C00
	xchg	word ptr es:[187h], bx	;@02C02
	push	bx	;@02C07
	test	ax, 4	;@02C08
	jne	@@3	;@02C0B
	mov	si, ax	;@02C0D
	push	cs	;@02C0F
	pop	ds	;@02C10
	mov	bx, 2BE4h	;@02C11
	call	L049DA	;@02C14
	mov	al, byte ptr cs:L02A73+374	;@02C17
	and	al, 5	;@02C1B
	cmp	al, 1	;@02C1D
	jne	@@3	;@02C1F
	clc	;@02C21
@@2:	pop	word ptr es:[187h]	;@02C22
	pop	es	;@02C27
	pop	ds	;@02C28
	pop	si	;@02C29
	pop	cx	;@02C2A
	pop	bx	;@02C2B
	pop	ax	;@02C2C
	ret	;@02C2D
@@3:	stc	;@02C2E
	jmp	@@2	;@02C2F
L02C31	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90h	;@02C31
	db	0E8h, 0FCh, 3, 90h, 0E8h, 0F8h, 3, 90h, 0E8h, 0F4h, 3, 90h, 0E8h, 0F0h, 3, 90h
	db	0E8h, 0ECh, 3, 90h, 0E8h, 0E8h, 3, 90h, 0E8h, 0E4h, 3, 90h, 0E8h, 0E0h, 3, 90h
	db	0E8h, 0DCh, 3, 90h, 0E8h, 0D8h, 3, 90h, 0E8h, 0D4h, 3, 90h, 0E8h, 0D0h, 3, 90h
	db	0E8h, 0CCh, 3, 90h, 0E8h, 0C8h, 3, 90h, 0E8h, 0C4h, 3, 90h, 0E8h, 0C0h, 3, 90h
	db	0E8h, 0BCh, 3, 90h, 0E8h, 0B8h, 3, 90h, 0E8h, 0B4h, 3, 90h, 0E8h, 0B0h, 3, 90h
	db	0E8h, 0ACh, 3, 90h, 0E8h, 0A8h, 3, 90h, 0E8h, 0A4h, 3, 90h, 0E8h, 0A0h, 3, 90h
	db	0E8h, 9Ch, 3, 90h, 0E8h, 98h, 3, 90h, 0E8h, 94h, 3, 90h, 0E8h, 90h, 3, 90h
	db	0E8h, 8Ch, 3, 90h, 0E8h, 88h, 3, 90h, 0E8h, 84h, 3, 90h, 0E8h, 80h, 3, 90h
	db	0E8h, 7Ch, 3, 90h, 0E8h, 78h, 3, 90h, 0E8h, 74h, 3, 90h, 0E8h, 70h, 3, 90h
	db	0E8h, 6Ch, 3, 90h, 0E8h, 68h, 3, 90h, 0E8h, 64h, 3, 90h, 0E8h, 60h, 3, 90h
	db	0E8h, 5Ch, 3, 90h, 0E8h, 58h, 3, 90h, 0E8h, 54h, 3, 90h, 0E8h, 50h, 3, 90h
	db	0E8h, 4Ch, 3, 90h, 0E8h, 48h, 3, 90h, 0E8h, 44h, 3, 90h, 0E8h, 40h, 3, 90h
	db	0E8h, 3Ch, 3, 90h, 0E8h, 38h, 3, 90h, 0E8h, 34h, 3, 90h, 0E8h, 30h, 3, 90h
	db	0E8h, 2Ch, 3, 90h, 0E8h, 28h, 3, 90h, 0E8h, 24h, 3, 90h, 0E8h, 20h, 3, 90h
	db	0E8h, 1Ch, 3, 90h, 0E8h, 18h, 3, 90h, 0E8h, 14h, 3, 90h, 0E8h, 10h, 3, 90h
	db	0E8h, 0Ch, 3, 90h, 0E8h, 8, 3, 90h, 0E8h, 4, 3, 90h, 0E8h, 0, 3, 90h
	db	0E8h, 0FCh, 2, 90h, 0E8h, 0F8h, 2, 90h, 0E8h, 0F4h, 2, 90h, 0E8h, 0F0h, 2, 90h
	db	0E8h, 0ECh, 2, 90h, 0E8h, 0E8h, 2, 90h, 0E8h, 0E4h, 2, 90h, 0E8h, 0E0h, 2, 90h
	db	0E8h, 0DCh, 2, 90h, 0E8h, 0D8h, 2, 90h, 0E8h, 0D4h, 2, 90h, 0E8h, 0D0h, 2, 90h
	db	0E8h, 0CCh, 2, 90h, 0E8h, 0C8h, 2, 90h, 0E8h, 0C4h, 2, 90h, 0E8h, 0C0h, 2, 90h
	db	0E8h, 0BCh, 2, 90h, 0E8h, 0B8h, 2, 90h, 0E8h, 0B4h, 2, 90h, 0E8h, 0B0h, 2, 90h
	db	0E8h, 0ACh, 2, 90h, 0E8h, 0A8h, 2, 90h, 0E8h, 0A4h, 2, 90h, 0E8h, 0A0h, 2, 90h
	db	0E8h, 9Ch, 2, 90h, 0E8h, 98h, 2, 90h, 0E8h, 94h, 2, 90h, 0E8h, 90h, 2, 90h
	db	0E8h, 8Ch, 2, 90h, 0E8h, 88h, 2, 90h, 0E8h, 84h, 2, 90h, 0E8h, 80h, 2, 90h
	db	0E8h, 7Ch, 2, 90h, 0E8h, 78h, 2, 90h, 0E8h, 74h, 2, 90h, 0E8h, 70h, 2, 90h
	db	0E8h, 6Ch, 2, 90h, 0E8h, 68h, 2, 90h, 0E8h, 64h, 2, 90h, 0E8h, 60h, 2, 90h
	db	0E8h, 5Ch, 2, 90h, 0E8h, 58h, 2, 90h, 0E8h, 54h, 2, 90h, 0E8h, 50h, 2, 90h
	db	0E8h, 4Ch, 2, 90h, 0E8h, 48h, 2, 90h, 0E8h, 44h, 2, 90h, 0E8h, 40h, 2, 90h
	db	0E8h, 3Ch, 2, 90h, 0E8h, 38h, 2, 90h, 0E8h, 34h, 2, 90h, 0E8h, 30h, 2, 90h
	db	0E8h, 2Ch, 2, 90h, 0E8h, 28h, 2, 90h, 0E8h, 24h, 2, 90h, 0E8h, 20h, 2, 90h
	db	0E8h, 1Ch, 2, 90h, 0E8h, 18h, 2, 90h, 0E8h, 14h, 2, 90h, 0E8h, 10h, 2, 90h
	db	0E8h, 0Ch, 2, 90h, 0E8h, 8, 2, 90h, 0E8h, 4, 2, 90h, 0E8h, 0, 2, 90h
	db	0E8h, 0FCh, 1, 90h, 0E8h, 0F8h, 1, 90h, 0E8h, 0F4h, 1, 90h, 0E8h, 0F0h, 1, 90h
	db	0E8h, 0ECh, 1, 90h, 0E8h, 0E8h, 1, 90h, 0E8h, 0E4h, 1, 90h, 0E8h, 0E0h, 1, 90h
	db	0E8h, 0DCh, 1, 90h, 0E8h, 0D8h, 1, 90h, 0E8h, 0D4h, 1, 90h, 0E8h, 0D0h, 1, 90h
	db	0E8h, 0CCh, 1, 90h, 0E8h, 0C8h, 1, 90h, 0E8h, 0C4h, 1, 90h, 0E8h, 0C0h, 1, 90h
	db	0E8h, 0BCh, 1, 90h, 0E8h, 0B8h, 1, 90h, 0E8h, 0B4h, 1, 90h, 0E8h, 0B0h, 1, 90h
	db	0E8h, 0ACh, 1, 90h, 0E8h, 0A8h, 1, 90h, 0E8h, 0A4h, 1, 90h, 0E8h, 0A0h, 1, 90h
	db	0E8h, 9Ch, 1, 90h, 0E8h, 98h, 1, 90h, 0E8h, 94h, 1, 90h, 0E8h, 90h, 1, 90h
	db	0E8h, 8Ch, 1, 90h, 0E8h, 88h, 1, 90h, 0E8h, 84h, 1, 90h, 0E8h, 80h, 1, 90h
	db	0E8h, 7Ch, 1, 90h, 0E8h, 78h, 1, 90h, 0E8h, 74h, 1, 90h, 0E8h, 70h, 1, 90h
	db	0E8h, 6Ch, 1, 90h, 0E8h, 68h, 1, 90h, 0E8h, 64h, 1, 90h, 0E8h, 60h, 1, 90h
	db	0E8h, 5Ch, 1, 90h, 0E8h, 58h, 1, 90h, 0E8h, 54h, 1, 90h, 0E8h, 50h, 1, 90h
	db	0E8h, 4Ch, 1, 90h, 0E8h, 48h, 1, 90h, 0E8h, 44h, 1, 90h, 0E8h, 40h, 1, 90h
	db	0E8h, 3Ch, 1, 90h, 0E8h, 38h, 1, 90h, 0E8h, 34h, 1, 90h, 0E8h, 30h, 1, 90h
	db	0E8h, 2Ch, 1, 90h, 0E8h, 28h, 1, 90h, 0E8h, 24h, 1, 90h, 0E8h, 20h, 1, 90h
	db	0E8h, 1Ch, 1, 90h, 0E8h, 18h, 1, 90h, 0E8h, 14h, 1, 90h, 0E8h, 10h, 1, 90h
	db	0E8h, 0Ch, 1, 90h, 0E8h, 8, 1, 90h, 0E8h, 4, 1, 90h, 0E8h, 0, 1, 90h
	db	0E8h, 0FCh, 0, 90h, 0E8h, 0F8h, 0, 90h, 0E8h, 0F4h, 0, 90h, 0E8h, 0F0h, 0, 90h
	db	0E8h, 0ECh, 0, 90h, 0E8h, 0E8h, 0, 90h, 0E8h, 0E4h, 0, 90h, 0E8h, 0E0h, 0, 90h
	db	0E8h, 0DCh, 0, 90h, 0E8h, 0D8h, 0, 90h, 0E8h, 0D4h, 0, 90h, 0E8h, 0D0h, 0, 90h
	db	0E8h, 0CCh, 0, 90h, 0E8h, 0C8h, 0, 90h, 0E8h, 0C4h, 0, 90h, 0E8h, 0C0h, 0, 90h
	db	0E8h, 0BCh, 0, 90h, 0E8h, 0B8h, 0, 90h, 0E8h, 0B4h, 0, 90h, 0E8h, 0B0h, 0, 90h
	db	0E8h, 0ACh, 0, 90h, 0E8h, 0A8h, 0, 90h, 0E8h, 0A4h, 0, 90h, 0E8h, 0A0h, 0, 90h
	db	0E8h, 9Ch, 0, 90h, 0E8h, 98h, 0, 90h, 0E8h, 94h, 0, 90h, 0E8h, 90h, 0, 90h
	db	0E8h, 8Ch, 0, 90h, 0E8h, 88h, 0, 90h, 0E8h, 84h, 0, 90h, 0E8h, 80h, 0, 90h
	db	0E8h, 7Ch, 0, 90h, 0E8h, 78h, 0, 90h, 0E8h, 74h, 0, 90h, 0E8h, 70h, 0, 90h
	db	0E8h, 6Ch, 0, 90h, 0E8h, 68h, 0, 90h, 0E8h, 64h, 0, 90h, 0E8h, 60h, 0, 90h
	db	0E8h, 5Ch, 0, 90h, 0E8h, 58h, 0, 90h, 0E8h, 54h, 0, 90h, 0E8h, 50h, 0, 90h
	db	0E8h, 4Ch, 0, 90h, 0E8h, 48h, 0, 90h, 0E8h, 44h, 0, 90h, 0E8h, 40h, 0, 90h
	db	0E8h, 3Ch, 0, 90h, 0E8h, 38h, 0, 90h, 0E8h, 34h, 0, 90h, 0E8h, 30h, 0, 90h
	db	0E8h, 2Ch, 0, 90h, 0E8h, 28h, 0, 90h, 0E8h, 24h, 0, 90h, 0E8h, 20h, 0, 90h
	db	0E8h, 1Ch, 0, 90h, 0E8h, 18h, 0, 90h, 0E8h, 14h, 0, 90h, 0E8h, 10h, 0, 90h
	db	0E8h, 0Ch, 0, 90h, 0E8h, 8, 0, 90h, 0E8h, 4, 0, 90h, 0E8h, 0, 0, 50h
	db	55h, 8Bh, 0ECh, 87h, 46h, 2, 87h, 5Eh, 4, 81h, 0EBh, 44h, 2Ch, 5Dh, 6, 57h
	db	50h, 0B8h
	dw	seg S589_START
	db	8Eh, 0C0h, 26h, 83h, 3Eh, 60h, 0, 0, 74h, 0Dh, 58h, 5Fh, 7, 55h, 8Bh, 0ECh
	db	87h, 46h, 2, 5Dh, 58h, 5Bh, 0CFh, 26h, 8Eh, 6, 90h, 0, 0B0h, 5, 0E8h, 0C1h
	db	13h, 26h, 0C7h, 45h, 6, 5, 0, 26h, 89h, 5Dh, 8, 26h, 89h, 6Dh, 2, 26h
	db	8Fh, 45h, 0Ah, 26h, 8Fh, 45h, 14h, 58h, 5Bh, 26h, 8Fh, 45h, 0Ch, 53h, 50h, 26h
	db	89h, 4Dh, 0Eh, 26h, 89h, 55h, 10h, 26h, 89h, 75h, 12h, 2Eh, 0FEh, 6, 0C0h, 36h
	db	0E8h, 0DAh, 12h, 2Eh, 0FEh, 0Eh, 0C0h, 36h, 26h, 0FFh, 75h, 0Ah, 26h, 0FFh, 75h, 0Ch
	db	26h, 0FFh, 75h, 0Eh, 26h, 0FFh, 75h, 10h, 26h, 0FFh, 75h, 12h, 26h, 0FFh, 75h, 14h
	db	0F8h, 26h, 83h, 7Dh, 8, 0, 74h, 1, 0F9h, 9Ch, 0E8h, 0F7h, 13h, 9Dh, 5Fh, 5Eh
	db	5Ah, 59h, 5Bh, 58h, 7, 9Ch, 55h, 8Bh, 0ECh, 87h, 46h, 4, 5Dh, 9Dh, 58h, 73h
	db	1, 0CBh, 0CFh, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 6, 51h, 50h, 57h, 8Ch, 0C8h, 8Eh, 0C0h, 0BFh, 0Ah, 31h
	db	0B9h, 0, 2, 0FCh, 33h, 0C0h, 0F3h, 0ABh, 5Fh, 58h, 59h, 7, 0C3h, 6, 50h, 53h
	db	56h, 32h, 0E4h, 8Bh, 0F0h, 0D1h, 0E6h, 0D1h, 0E6h, 2Eh, 8Bh, 9Ch, 0Ah, 31h, 2Eh, 0Bh
	db	9Ch, 0Ch, 31h, 75h, 16h, 2Eh, 8Eh, 6, 8, 31h, 26h, 8Bh, 4, 2Eh, 89h, 84h
	db	0Ah, 31h, 26h, 8Bh, 44h, 2, 2Eh, 89h, 84h, 0Ch, 31h, 5Eh, 5Bh, 58h, 7, 0C3h
	db	1Eh, 50h, 53h, 51h, 52h, 56h, 6, 9Ch, 0FAh, 8Ch, 0C8h, 8Eh, 0D8h, 2Eh, 8Eh, 6
	db	8, 31h, 32h, 0C0h, 33h, 0DBh, 2Eh, 8Bh, 97h, 0Ah, 31h, 2Eh, 8Bh, 8Fh, 0Ch, 31h
	db	8Bh, 0F1h, 0Bh, 0F2h, 74h, 7, 26h, 89h, 17h, 26h, 89h, 4Fh, 2, 0FEh, 0C0h, 83h
	db	0C3h, 4, 3Ch, 0, 75h, 0E0h, 9Dh, 7, 5Eh, 5Ah, 59h, 5Bh, 58h, 1Fh, 0C3h, 1Eh
	db	50h, 53h, 52h, 56h, 8Ch, 0CBh, 8Eh, 0DBh, 33h, 0DBh, 8Ah, 0D8h, 0D1h, 0E3h, 0D1h, 0E3h
	db	2Eh, 8Bh, 97h, 0Ah, 31h, 2Eh, 8Bh, 8Fh, 0Ch, 31h, 8Bh, 0F2h, 0Bh, 0F1h, 74h, 19h
	db	0C7h, 87h, 0Ah, 31h, 0, 0, 0C7h, 87h, 0Ch, 31h, 0, 0, 2Eh, 8Eh, 1Eh, 8
	db	31h, 9Ch, 0FAh, 89h, 17h, 89h, 4Fh, 2, 9Dh, 5Eh, 5Ah, 5Bh, 58h, 1Fh, 0C3h, 1Eh
	db	50h, 52h, 0Eh, 1Fh, 9Ch, 0FAh, 3Ch, 41h, 75h, 12h, 33h, 0D2h, 8Eh, 0DAh, 0BAh, 0E8h
	db	30h, 89h, 16h, 4, 1, 8Ch, 0Eh, 6, 1, 0EBh, 2Fh, 90h, 3Ch, 46h, 75h, 12h
	db	33h, 0D2h, 8Eh, 0DAh, 0BAh, 0F8h, 30h, 89h, 16h, 18h, 1, 8Ch, 0Eh, 1Ah, 1, 0EBh
	db	19h, 90h, 8Ah, 0D0h, 32h, 0F6h, 0D1h, 0E2h, 0D1h, 0E2h, 8Bh, 0DAh, 81h, 0C2h, 40h, 2Ch
	db	2Eh, 8Eh, 1Eh, 8, 31h, 89h, 17h, 8Ch, 4Fh, 2, 9Dh, 5Ah, 58h, 1Fh, 0C3h, 6
	db	1Eh, 50h, 53h, 51h, 56h, 9Ch, 0FAh, 8Ch, 0C8h, 8Eh, 0D8h, 32h, 0C0h, 0BEh, 0Ah, 31h
	db	8Bh, 0Ch, 0Bh, 4Ch, 2, 74h, 6, 0E8h, 0E3h, 0FEh, 0E8h, 92h, 0FFh, 0FEh, 0C0h, 83h
	db	0C6h, 4, 3Ch, 0, 75h, 0EAh, 9Dh, 5Eh, 59h, 5Bh, 58h, 1Fh, 7, 0C3h, 26h, 8Bh
	db	5Dh, 8, 2Eh, 8Bh, 87h, 0Ah, 31h, 2Eh, 0Bh, 87h, 0Ch, 31h, 74h, 9, 9Ch, 2Eh
	db	0FFh, 9Fh, 0Ah, 31h, 0EBh, 9, 90h, 33h, 0C0h, 8Eh, 0C0h, 9Ch, 26h, 0FFh, 1Fh, 0C3h
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0B9h, 45h, 44h, 0BAh, 51h
	db	53h, 0B8h, 1, 2Bh, 0CDh, 21h, 3Ch, 0FFh, 74h, 3, 8Bh, 0C3h, 0C3h, 33h, 0C0h, 0C3h
	db	0B3h, 1, 0B8h, 11h, 11h, 0CDh, 15h, 0CDh, 11h, 0BBh, 0, 0B0h, 24h, 30h, 3Ch, 30h
	db	74h, 3, 0BBh, 0, 0B8h, 8Eh, 0C3h, 33h, 0FFh, 0B4h, 0FEh, 0CDh, 10h, 0C3h, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 94h, 38h
	db	0B8h, 38h, 94h, 38h, 0B7h, 38h, 5Ah, 3Ch, 94h, 38h, 94h, 38h, 94h, 38h, 94h, 38h
	db	88h, 39h, 94h, 38h, 53h, 36h, 94h, 38h, 0B0h, 3Bh, 0C5h, 3Bh, 0F8h, 39h, 0A6h, 39h
	db	0CFh, 39h, 3, 3Ch, 2, 3Bh, 94h, 38h, 94h, 38h, 94h, 38h, 94h, 38h, 94h, 38h
	db	0A4h, 1Eh, 94h, 38h, 94h, 38h, 94h, 38h, 94h, 38h, 0EAh, 3Bh, 2Ah, 40h, 0BFh, 38h
	db	0Eh, 41h, 94h, 38h, 0D3h, 3Bh, 94h, 38h, 29h, 3Ch, 46h, 3Ch, 94h, 38h, 3Dh, 40h
	db	8, 42h, 93h, 42h, 0B6h, 3Ch, 0BDh, 3Ch, 0A6h, 3Fh, 3Dh, 3Dh, 79h, 3Fh, 0C2h, 3Eh
	db	0E6h, 3Eh, 64h, 3Fh, 42h, 3Fh, 0CEh, 3Ch, 47h, 3Dh, 5Ah, 3Dh, 89h, 3Dh, 0B2h, 3Dh
	db	2Ah, 3Dh, 0F3h, 3Ch, 8, 3Dh, 0BEh, 3Dh, 0E3h, 3Dh, 0FFh, 3Dh, 18h, 3Eh, 41h, 3Eh
	db	6Ah, 3Eh, 7Ah, 3Eh, 0ADh, 3Fh, 0BCh, 1Dh, 0B6h, 3Ch, 0B6h, 3Ch, 0E5h, 3Ch
L03763:	push	ds	;@03763
	push	bp	;@03764
	mov	bp, sp	;@03765
	sub	sp, 2	;@03767
	mov	byte ptr [bp-2], al	;@0376A
	mov	ax, seg S589_START	;@0376D
	mov	ds, ax	;@03770
@@1:	call	@@8	;@03772
	jae	@@2	;@03775
	mov	ah, 0	;@03777
	jmp	short @@3	;@03779
@@2:	cmp	ax, 0	;@0377B
	je	@@1	;@0377E
	cmp	byte ptr [bp-2], 2	;@03780
	jne	@@1	;@03784
	mov	ah, 1	;@03786
@@3:	mov	sp, bp	;@03788
	pop	bp	;@0378A
	pop	ds	;@0378B
	ret	;@0378C
@@4:	push	ax	;@0378D
	push	bx	;@0378E
	push	cx	;@0378F
	push	dx	;@03790
	push	bp	;@03791
	push	si	;@03792
	push	di	;@03793
	push	es	;@03794
	push	ds	;@03795
	push	word ptr cs:L02C31+2713	;@03796
	push	word ptr cs:L02C31+2715	;@0379B
	mov	word ptr cs:L02C31+2713, es	;@037A0
	mov	word ptr cs:L02C31+2715, di	;@037A5
	mov	bx, word ptr es:[di+6]	;@037AA
	shl	bx, 1	;@037AE
	cmp	bx, 56h	;@037B0
	jb	@@5	;@037B3
	shr	bx, 1	;@037B5
	push	bx	;@037B7
	sub	sp, 4	;@037B8
	push	bp	;@037BB
	mov	bp, sp	;@037BC
	mov	word ptr [bp+4], 2	;@037BE
	mov	word ptr [bp+2], 19h	;@037C3
	pop	bp	;@037C8
	nosmart
	call	far ptr L048E0	;@037C9
	smart
	add	sp, 6	;@037CE
	mov	al, 1	;@037D1
	mov	ah, 4Ch	;@037D3
	int	21h	;@037D5
@@5:	xor	ah, ah	;@037D7
	mov	al, byte ptr ds:[84h]	;@037D9
	cmp	ax, 0	;@037DC
	je	@@6	;@037DF
	push	bx	;@037E1
	mov	al, byte ptr es:[di+5]	;@037E2
	call	L04501	;@037E6
	mov	bx, si	;@037E9
	mov	al, byte ptr es:[di+4]	;@037EB
	call	L04501	;@037EF
	mov	ax, si	;@037F2
	push	es	;@037F4
	push	di	;@037F5
	push	es	;@037F6
	push	ax	;@037F7
	push	es	;@037F8
	push	dx	;@037F9
	call	dword ptr ds:[80h]	;@037FA
	add	sp, 0Ch	;@037FE
	pop	bx	;@03801
@@6:	cmp	ax, 0	;@03802
	jne	@@7	;@03805
	call	word ptr cs:[bx+36D3h]	;@03807
@@7:	pop	word ptr cs:L02C31+2715	;@0380C
	pop	word ptr cs:L02C31+2713	;@03811
	pop	ds	;@03816
	pop	es	;@03817
	pop	di	;@03818
	pop	si	;@03819
	pop	bp	;@0381A
	pop	dx	;@0381B
	pop	cx	;@0381C
	pop	bx	;@0381D
	pop	ax	;@0381E
	ret	;@0381F
@@8:	push	di	;@03820
	call	L043FA	;@03821
	jae	@@9	;@03824
	sub	sp, 4	;@03826
	push	bp	;@03829
	mov	bp, sp	;@0382A
	mov	word ptr [bp+4], 0	;@0382C
	mov	word ptr [bp+2], 54h	;@03831
	pop	bp	;@03836
	nosmart
	call	far ptr L048E0	;@03837
	smart
	add	sp, 4	;@0383C
	mov	al, 1	;@0383F
	mov	ah, 4Ch	;@03841
	int	21h	;@03843
@@9:	mov	al, byte ptr es:[di+1]	;@03845
	test	al, 2	;@03849
	je	@@11	;@0384B
	test	al, 4	;@0384D
	jne	@@10	;@0384F
	call	L044C9	;@03851
@@10:	mov	ax, 1	;@03854
	jmp	@@13	;@03857
@@11:	test	al, 1	;@0385A
	je	@@12	;@0385C
	call	@@4	;@0385E
	or	byte ptr es:[di+1], 2	;@03861
	call	L04394	;@03866
	mov	ax, 1	;@03869
	jmp	@@14	;@0386C
@@12:	sub	sp, 4	;@0386F
	push	bp	;@03872
	mov	bp, sp	;@03873
	mov	word ptr [bp+4], 0	;@03875
	mov	word ptr [bp+2], 23h	;@0387A
	pop	bp	;@0387F
	nosmart
	call	far ptr L048E0	;@03880
	smart
	add	sp, 4	;@03885
	call	L04635	;@03888
	jmp	@@14	;@0388B
@@13:	stc	;@0388E
	jmp	short @@15	;@0388F
@@14:	clc	;@03891
@@15:	pop	di	;@03892
	ret	;@03893
	db	0D1h, 0EBh, 53h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 2, 0, 0C7h, 46h	;@03894
	db	2, 19h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 6, 26h, 0C7h, 45h, 6, 3, 0, 0C3h, 0C3h, 26h, 0C7h, 45h, 6, 3
	db	0, 0C3h, 26h, 8Bh, 45h, 8, 3Ch, 1, 75h, 6, 0E8h, 30h, 0, 0EBh, 2Dh, 90h
	db	3Ch, 2, 75h, 6, 0E8h, 53h, 0, 0EBh, 23h, 90h, 0D1h, 0EBh, 53h, 83h, 0ECh, 4
	db	55h, 8Bh, 0ECh, 0C7h, 46h, 4, 2, 0, 0C7h, 46h, 2, 18h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 6, 0B0h, 1, 0B4h, 4Ch, 0CDh, 21h, 0C3h, 26h, 8Bh, 4Dh, 0Ah, 0BBh, 10h
	db	0, 0B4h, 48h, 2Eh, 0FFh, 1Eh, 72h, 21h, 73h, 7, 26h, 0C7h, 45h, 0Ah, 0, 0
	db	0C3h, 26h, 89h, 45h, 0Ah, 8Bh, 0D0h, 0B4h, 55h, 0CDh, 21h, 83h, 0F9h, 0, 74h, 6
	db	8Bh, 0DAh, 0B4h, 50h, 0CDh, 21h, 0C3h, 26h, 8Bh, 5Dh, 0Ah, 0E8h, 0C2h, 0E3h, 8Eh, 0DBh
	db	0B4h, 50h, 0CDh, 21h, 26h, 8Eh, 5Dh, 0Ah, 0C7h, 6, 0Ah, 0, 70h, 39h, 8Ch, 0Eh
	db	0Ch, 0, 4Bh, 8Eh, 0C3h, 43h, 26h, 3Bh, 1Eh, 1, 0, 75h, 2, 33h, 0DBh, 53h
	db	2Eh, 8Ch, 16h, 0C2h, 36h, 2Eh, 89h, 26h, 0C4h, 36h, 83h, 0ECh, 50h, 8Eh, 6, 16h
	db	0, 26h, 8Ch, 16h, 30h, 0, 26h, 89h, 26h, 2Eh, 0, 0B4h, 4Ch, 0E8h, 0B3h, 8
	db	2Eh, 8Eh, 16h, 0C2h, 36h, 2Eh, 8Bh, 26h, 0C4h, 36h, 5Bh, 83h, 0FBh, 0, 74h, 7
	db	8Eh, 0C3h, 0B4h, 49h, 0E8h, 9Ch, 8, 0C3h, 33h, 0C0h, 8Eh, 0D8h, 26h, 8Bh, 5Dh, 8
	db	8Bh, 7, 2Eh, 0A3h, 0A1h, 39h, 8Bh, 47h, 2, 2Eh, 0A3h, 0A3h, 39h, 0EBh, 1, 90h
	db	9Ah, 0, 0, 0, 0, 0C3h, 26h, 8Ah, 45h, 4, 0E8h, 54h, 0Bh, 56h, 26h, 8Bh
	db	45h, 0Ah, 26h, 8Bh, 5Dh, 0Ch, 0E8h, 7Dh, 0Eh, 8Eh, 0D8h, 8Bh, 0F3h, 26h, 8Bh, 4Dh
	db	0Eh, 5Fh, 51h, 83h, 0E1h, 1, 0FCh, 0F3h, 0A4h, 59h, 0D1h, 0E9h, 0F3h, 0A5h, 0C3h, 26h
	db	8Ah, 45h, 4, 0E8h, 2Bh, 0Bh, 26h, 8Bh, 45h, 0Ah, 26h, 8Bh, 5Dh, 0Ch, 0E8h, 55h
	db	0Eh, 26h, 8Bh, 4Dh, 0Eh, 6, 1Fh, 8Eh, 0C0h, 8Bh, 0FBh, 51h, 83h, 0E1h, 1, 0FCh
	db	0F3h, 0A4h, 59h, 0D1h, 0E9h, 0F3h, 0A5h, 0C3h, 26h, 8Bh, 5Dh, 0Ah, 80h, 0FFh, 2, 75h
	db	10h, 9Ch, 58h, 25h, 0, 2, 26h, 89h, 45h, 0Ah, 0FAh, 0EBh, 34h, 90h, 0EBh, 0Ah
	db	90h, 80h, 0FFh, 3, 75h, 4, 0FBh, 0EBh, 28h, 90h, 26h, 8Bh, 45h, 0Ch, 26h, 8Bh
	db	55h, 10h, 80h, 0FFh, 0, 75h, 10h, 80h, 0FBh, 0, 75h, 4, 0ECh, 0EBh, 2, 90h
	db	0EDh, 26h, 89h, 45h, 0Ch, 0EBh, 0Ah, 80h, 0FBh, 0, 75h, 4, 0EEh, 0EBh, 2, 90h
	db	0EFh, 0C3h, 50h, 53h, 51h, 52h, 26h, 8Bh, 45h, 0Ah, 26h, 8Bh, 5Dh, 0Ch, 0E8h, 0E5h
	db	0Dh, 50h, 53h, 26h, 8Bh, 45h, 0Eh, 26h, 8Bh, 5Dh, 10h, 0E8h, 0D8h, 0Dh, 8Eh, 0C0h
	db	8Bh, 0FBh, 5Eh, 1Fh, 5Ah, 59h, 5Bh, 58h, 0C3h, 50h, 53h, 51h, 52h, 33h, 0C0h, 0BBh
	db	0F0h, 0FFh, 50h, 53h, 26h, 8Bh, 45h, 0Ah, 26h, 8Bh, 5Dh, 0Ch, 5Ah, 59h, 3Bh, 0C8h
	db	75h, 8, 3Bh, 0D3h, 73h, 0Ah, 8Bh, 0DAh, 0EBh, 6, 77h, 4, 8Bh, 0C1h, 8Bh, 0DAh
	db	8Bh, 0D3h, 52h, 26h, 8Bh, 45h, 0Ah, 26h, 8Bh, 5Dh, 0Ch, 2Bh, 0DAh, 1Dh, 0, 0
	db	51h, 0B1h, 4, 0E8h, 7Dh, 0Dh, 59h, 26h, 8Bh, 45h, 0Ch, 25h, 0Fh, 0, 5Ah, 0Bh
	db	0C2h, 50h, 53h, 33h, 0C0h, 0BBh, 0F0h, 0FFh, 50h, 53h, 26h, 8Bh, 45h, 0Eh, 26h, 8Bh
	db	5Dh, 10h, 5Ah, 59h, 3Bh, 0C8h, 75h, 8, 3Bh, 0D3h, 73h, 0Ah, 8Bh, 0DAh, 0EBh, 6
	db	77h, 4, 8Bh, 0C1h, 8Bh, 0DAh, 8Bh, 0D3h, 52h, 26h, 8Bh, 45h, 0Eh, 26h, 8Bh, 5Dh
	db	10h, 2Bh, 0DAh, 1Dh, 0, 0, 51h, 0B1h, 4, 0E8h, 37h, 0Dh, 59h, 26h, 8Bh, 45h
	db	10h, 25h, 0Fh, 0, 5Ah, 0Bh, 0C2h, 8Eh, 0C3h, 8Bh, 0F8h, 1Fh, 5Eh, 5Ah, 59h, 5Bh
	db	58h, 0C3h, 26h, 8Bh, 45h, 8, 3Ch, 0, 75h, 4Dh, 26h, 8Bh, 45h, 0Eh, 26h, 8Bh
	db	5Dh, 10h, 50h, 53h, 26h, 8Bh, 45h, 0Ah, 26h, 8Bh, 5Dh, 0Ch, 5Ah, 59h, 3Bh, 0C1h
	db	75h, 2, 3Bh, 0DAh, 26h, 8Bh, 4Dh, 12h, 73h, 1Bh, 0E8h, 3Ch, 0FFh, 3, 0F1h, 3
	db	0F9h, 4Eh, 4Fh, 51h, 83h, 0E1h, 1, 0FDh, 0F3h, 0A4h, 59h, 4Eh, 4Fh, 0D1h, 0E9h, 0F3h
	db	0A5h, 0FCh, 0EBh, 6Bh, 90h, 0E8h, 0FAh, 0FEh, 51h, 83h, 0E1h, 1, 0FCh, 0F3h, 0A4h, 59h
	db	0D1h, 0E9h, 0F3h, 0A5h, 0EBh, 59h, 90h, 0FCh, 26h, 8Bh, 4Dh, 12h, 3Ch, 1, 75h, 8
	db	0E8h, 0DFh, 0FEh, 0F3h, 0A4h, 0EBh, 48h, 90h, 3Ch, 2, 75h, 0Ah, 0E8h, 0FAh, 0FEh, 0FDh
	db	0F3h, 0A4h, 0FCh, 0EBh, 3Ah, 90h, 3Ch, 3, 75h, 8, 0E8h, 0C5h, 0FEh, 0F3h, 0A5h, 0EBh
	db	2Eh, 90h, 3Ch, 4, 75h, 0Ah, 0E8h, 0E0h, 0FEh, 0FDh, 0F3h, 0A5h, 0FCh, 0EBh, 20h, 90h
	db	83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h, 2, 1Dh, 0
	db	5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0B0h, 1, 0B4h, 4Ch, 0CDh, 21h, 0C3h, 6, 57h, 26h, 8Bh, 45h, 8
	db	2Eh, 0A2h, 0BEh, 3Bh, 0E8h, 0CDh, 0, 0CDh, 7Fh, 5Fh, 7, 0E8h, 0DCh, 0, 0C3h, 26h
	db	8Bh, 45h, 8, 2Eh, 0A2h, 0D1h, 3Bh, 0E8h, 0BAh, 0, 0CDh, 7Fh, 0C3h, 26h, 8Bh, 45h
	db	8, 2Eh, 0A2h, 0E8h, 3Bh, 26h, 8Ah, 45h, 4, 0E8h, 1Fh, 9, 0E8h, 0A5h, 0, 8Bh
	db	0D6h, 0CDh, 7Fh, 0C3h, 55h, 26h, 8Bh, 45h, 8, 2Eh, 0A2h, 0, 3Ch, 26h, 8Ah, 45h
	db	4, 0E8h, 7, 9, 8Bh, 0EEh, 0E8h, 8Bh, 0, 0CDh, 7Fh, 5Dh, 0C3h, 6, 1Eh, 57h
	db	80h, 3Eh, 55h, 0, 0, 75h, 8, 0E8h, 7Ah, 0, 0CDh, 16h, 0EBh, 0Eh, 90h, 0E8h
	db	72h, 0, 50h, 0FFh, 1Eh, 5Ch, 0, 83h, 0C4h, 2, 0Bh, 0C0h, 5Fh, 1Fh, 7, 0E8h
	db	78h, 0, 0C3h, 26h, 8Bh, 45h, 8, 2Eh, 0A2h, 36h, 3Ch, 0E8h, 56h, 0, 6, 0CDh
	db	7Fh, 8Ch, 0C6h, 7, 0E8h, 63h, 0, 26h, 89h, 75h, 12h, 26h, 89h, 6Dh, 14h, 0C3h
	db	26h, 8Ah, 45h, 4, 0E8h, 0B4h, 8, 0E8h, 3Ah, 0, 53h, 8Bh, 0DEh, 0CDh, 13h, 5Bh
	db	0E8h, 47h, 0, 0C3h, 26h, 8Bh, 5Dh, 8, 0D1h, 0E3h, 83h, 0FBh, 3Ah, 72h, 1Fh, 0D1h
	db	0EBh, 53h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 2, 0, 0C7h, 46h, 2
	db	1Bh, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 6, 0EBh, 6, 90h, 2Eh, 0FFh, 97h, 29h, 37h, 0C3h, 26h, 8Ah, 65h, 16h
	db	9Eh, 26h, 8Bh, 45h, 0Ah, 26h, 8Bh, 5Dh, 0Ch, 26h, 8Bh, 4Dh, 0Eh, 26h, 8Bh, 55h
	db	10h, 0C3h, 26h, 89h, 45h, 0Ah, 26h, 89h, 5Dh, 0Ch, 26h, 89h, 4Dh, 0Eh, 26h, 89h
	db	55h, 10h, 9Fh, 26h, 88h, 65h, 16h, 0C3h, 26h, 0C7h, 45h, 6, 3, 0, 0C3h, 26h
	db	8Ah, 45h, 4, 0E8h, 3Dh, 8, 6, 1Fh, 8Bh, 0D6h, 0B4h, 9, 0E8h, 56h, 5, 0C3h
	db	26h, 8Ah, 45h, 4, 0E8h, 2Ch, 8, 6, 1Fh, 0E8h, 0B0h, 0FFh, 87h, 0F2h, 0E8h, 44h
	db	5, 87h, 0F2h, 0E8h, 0BCh, 0FFh, 0C3h, 0E8h, 0A2h, 0FFh, 26h, 8Eh, 5Dh, 12h, 0E8h, 34h
	db	5, 0E8h, 0AEh, 0FFh, 0C3h, 26h, 8Ah, 45h, 4, 0E8h, 7, 8, 0E8h, 8Dh, 0FFh, 57h
	db	8Bh, 0FEh, 0E8h, 20h, 5, 5Fh, 0E8h, 99h, 0FFh, 0C3h, 57h, 55h, 26h, 8Ah, 45h, 5
	db	0E8h, 0F0h, 7, 56h, 26h, 8Ah, 45h, 4, 0E8h, 0E8h, 7, 56h, 0E8h, 6Dh, 0FFh, 6
	db	1Fh, 5Eh, 5Fh, 0E8h, 0FFh, 4, 5Dh, 5Fh, 0E8h, 77h, 0FFh, 0C3h, 26h, 8Ah, 45h, 4
	db	0E8h, 0D0h, 7, 6, 1Fh, 0E8h, 54h, 0FFh, 0E8h, 0EAh, 4, 0E8h, 64h, 0FFh, 0C3h, 0E8h
	db	4Ah, 0FFh, 0E8h, 0E0h, 4, 0E8h, 5Ah, 0FFh, 0C3h, 26h, 8Ah, 45h, 4, 0E8h, 0B3h, 7
	db	0E8h, 39h, 0FFh, 6, 1Fh, 0E8h, 0CDh, 4, 0E8h, 47h, 0FFh, 0C3h, 57h, 26h, 8Ah, 45h
	db	4, 0E8h, 9Fh, 7, 8Ch, 0C2h, 8Eh, 0DAh, 8Bh, 0D6h, 56h, 26h, 8Ah, 45h, 5, 0E8h
	db	91h, 7, 26h, 8Bh, 45h, 0Ah, 8Bh, 0FEh, 5Eh, 0E8h, 0A9h, 4, 5Fh, 50h, 8Ch, 0C0h
	db	9Fh, 26h, 88h, 65h, 16h, 58h, 26h, 89h, 45h, 0Ah, 0C3h, 26h, 8Ah, 45h, 4, 0E8h
	db	71h, 7, 6, 1Fh, 0E8h, 0F5h, 0FEh, 87h, 0F2h, 0E8h, 89h, 4, 87h, 0F2h, 0E8h, 1
	db	0FFh, 8Bh, 44h, 14h, 2Eh, 0A3h, 0B0h, 3Dh, 8Bh, 44h, 12h, 2Eh, 0A3h, 0AEh, 3Dh, 0C3h
	db	0, 0, 0, 0, 0E8h, 0D5h, 0FEh, 2Eh, 0FFh, 1Eh, 0AEh, 3Dh, 0E8h, 0E3h, 0FEh, 0C3h
	db	26h, 8Ah, 45h, 4, 0E8h, 3Ch, 7, 0E8h, 0C2h, 0FEh, 8Bh, 0D6h, 6, 1Fh, 26h, 8Ah
	db	45h, 5, 0E8h, 2Eh, 7, 0E8h, 0BEh, 0, 0E8h, 0AFh, 0, 0E8h, 47h, 4, 0E8h, 0C1h
	db	0FEh, 0E8h, 0C9h, 0, 0C3h, 26h, 8Ah, 45h, 5, 0E8h, 17h, 7, 0E8h, 9Dh, 0FEh, 6
	db	1Fh, 0E8h, 0A2h, 0, 0E8h, 93h, 0, 0E8h, 2Bh, 4, 0E8h, 0A5h, 0FEh, 0E8h, 0ADh, 0
	db	0C3h, 26h, 8Ah, 45h, 4, 0E8h, 0FBh, 6, 8Ch, 0C0h, 8Eh, 0D8h, 0E8h, 7Dh, 0FEh, 52h
	db	8Bh, 0D6h, 0E8h, 10h, 4, 5Ah, 0E8h, 89h, 0FEh, 0C3h, 26h, 8Ah, 45h, 5, 0E8h, 0E2h
	db	6, 8Ch, 0C0h, 8Eh, 0D8h, 0E8h, 6Eh, 0, 0E8h, 5Fh, 0, 26h, 8Ah, 45h, 4, 0E8h
	db	0D1h, 6, 0E8h, 57h, 0FEh, 52h, 8Bh, 0D6h, 0E8h, 0EAh, 3, 5Ah, 0E8h, 63h, 0FEh, 0E8h
	db	6Bh, 0, 0C3h, 57h, 26h, 8Ah, 45h, 5, 0E8h, 0B8h, 6, 56h, 8Ch, 0C0h, 8Eh, 0D8h
	db	26h, 8Ah, 45h, 4, 0E8h, 0ACh, 6, 8Bh, 0FEh, 5Eh, 56h, 0B4h, 29h, 0CDh, 21h, 5Bh
	db	2Bh, 0F3h, 5Fh, 26h, 89h, 45h, 0Ah, 26h, 89h, 75h, 12h, 0C3h, 0E8h, 1Dh, 0FEh, 0E8h
	db	0B3h, 3, 0E8h, 2Dh, 0FEh, 8Bh, 7, 26h, 89h, 45h, 12h, 0C3h, 6, 0E8h, 0Ch, 0FEh
	db	8Eh, 0C1h, 0E8h, 0A0h, 3, 7, 0E8h, 19h, 0FEh, 0C3h, 50h, 52h, 8Bh, 0D6h, 0B4h, 1Ah
	db	0E8h, 92h, 3, 5Ah, 58h, 0C3h, 6, 53h, 50h, 0B8h, 0, 2Fh, 0E8h, 86h, 3, 2Eh
	db	8Ch, 6, 0C6h, 36h, 2Eh, 89h, 1Eh, 0C8h, 36h, 58h, 5Bh, 7, 0C3h, 50h, 53h, 6
	db	2Eh, 8Eh, 6, 0C6h, 36h, 2Eh, 8Bh, 1Eh, 0C8h, 36h, 0B8h, 0, 1Ah, 0E8h, 65h, 3
	db	7, 5Bh, 58h, 0C3h, 1Eh, 56h, 55h, 83h, 0ECh, 4, 8Bh, 0ECh, 89h, 7Eh, 0, 8Ch
	db	46h, 2, 0E8h, 0B7h, 0FDh, 0E8h, 4Dh, 3, 8Bh, 7Eh, 0, 8Eh, 46h, 2, 0E8h, 0C1h
	db	0FDh, 83h, 0C4h, 4, 5Dh, 5Eh, 1Fh, 0C3h, 80h, 3Eh, 0D0h, 0, 0, 74h, 1, 0C3h
	db	26h, 8Bh, 45h, 0Ah, 80h, 0FCh, 0, 74h, 4, 0E8h, 9Ah, 0F6h, 0C3h, 3Ch, 41h, 75h
	db	9, 0BBh, 0E8h, 30h, 0E8h, 14h, 0, 0EBh, 0Bh, 90h, 3Ch, 46h, 75h, 6, 0BBh, 0F8h
	db	30h, 0E8h, 7, 0, 0E8h, 0Dh, 0F6h, 0E8h, 0BCh, 0F6h, 0C3h, 50h, 56h, 57h, 1Eh, 6
	db	51h, 26h, 8Ah, 45h, 4, 0E8h, 0DBh, 5, 6, 1Fh, 0Eh, 7, 8Bh, 0FBh, 0B9h, 10h
	db	0, 51h, 83h, 0E1h, 1, 0FCh, 0F3h, 0A4h, 59h, 0D1h, 0E9h, 0F3h, 0A5h, 59h, 7, 1Fh
	db	5Fh, 5Eh, 58h, 0C3h, 26h, 8Ah, 45h, 4, 0E8h, 0B8h, 5, 56h, 26h, 8Ah, 45h, 5
	db	0E8h, 0B0h, 5, 8Eh, 0DEh, 5Eh, 0E8h, 33h, 0FDh, 57h, 8Ch, 0DFh, 6, 1Fh, 0E8h, 0C4h
	db	2, 5Fh, 0E8h, 3Dh, 0FDh, 0C3h, 26h, 8Ah, 45h, 4, 0E8h, 96h, 5, 0E8h, 1Ch, 0FDh
	db	87h, 0FEh, 0E8h, 0B0h, 2, 87h, 0FEh, 0E8h, 28h, 0FDh, 0C3h, 55h, 8Bh, 0ECh, 83h, 0ECh
	db	2, 89h, 7Eh, 0FEh, 0E8h, 5, 0FDh, 26h, 8Bh, 75h, 12h, 26h, 8Bh, 7Dh, 14h, 0E8h
	db	93h, 2, 50h, 8Bh, 0C7h, 8Bh, 7Eh, 0FEh, 26h, 89h, 75h, 12h, 26h, 89h, 45h, 14h
	db	58h, 0E8h, 0FEh, 0FCh, 8Bh, 0E5h, 5Dh, 0C3h, 0E8h, 0E1h, 0FCh, 0E8h, 77h, 2, 0C3h, 55h
	db	8Bh, 0ECh, 83h, 0ECh, 6, 26h, 8Bh, 45h, 0Ah, 2Eh, 0A2h, 0F8h, 3Fh, 26h, 8Ah, 45h
	db	4, 0E8h, 3Fh, 5, 8Ch, 46h, 0FEh, 89h, 76h, 0FCh, 89h, 7Eh, 0FAh, 26h, 8Bh, 4
	db	26h, 8Bh, 5Ch, 2, 26h, 8Bh, 4Ch, 4, 26h, 8Bh, 54h, 6, 26h, 81h, 64h, 8
	db	0FFh, 0FEh, 26h, 0FFh, 74h, 8, 9Dh, 26h, 0FFh, 74h, 0Ah, 26h, 8Bh, 7Ch, 0Ch, 26h
	db	8Eh, 5Ch, 0Eh, 26h, 8Eh, 44h, 10h, 5Eh, 55h, 0CDh, 7Fh, 5Dh, 9Ch, 6, 56h, 0C4h
	db	76h, 0FCh, 26h, 89h, 4, 26h, 89h, 5Ch, 2, 26h, 89h, 4Ch, 4, 26h, 89h, 54h
	db	6, 26h, 8Fh, 44h, 0Ah, 26h, 89h, 7Ch, 0Ch, 26h, 8Ch, 5Ch, 0Eh, 26h, 8Fh, 44h
	db	10h, 26h, 8Fh, 44h, 8, 8Bh, 7Eh, 0FAh, 8Bh, 0E5h, 5Dh, 0C3h, 26h, 8Bh, 45h, 8
	db	3Dh, 0, 0, 75h, 6, 0E8h, 0EEh, 0F5h, 0EBh, 4, 90h, 0E8h, 19h, 0F5h, 0C3h, 26h
	db	8Bh, 4Dh, 0Ah, 8Bh, 0D1h, 83h, 0F9h, 0, 74h, 16h, 26h, 8Ah, 45h, 4, 0E8h, 0B2h
	db	4, 3, 0F1h, 83h, 0EEh, 2, 0D1h, 0E9h, 26h, 0FFh, 34h, 83h, 0EEh, 2, 0E2h, 0F8h
	db	52h, 26h, 0FFh, 75h, 8, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 3, 0E2h, 0C3h, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8Fh, 41h, 2Fh, 41h
	db	7Fh, 41h, 1Fh, 41h, 66h, 41h, 26h, 8Bh, 5Dh, 8, 0D1h, 0E3h, 83h, 0FBh, 0Ah, 73h
	db	5, 2Eh, 0FFh, 97h, 4, 41h, 0C3h, 57h, 0E8h, 67h, 0FBh, 26h, 8Bh, 75h, 12h, 26h
	db	8Bh, 7Dh, 14h, 0CDh, 33h, 5Fh, 0C3h, 1Eh, 6, 57h, 26h, 8Ah, 45h, 4, 0E8h, 0C8h
	db	3, 26h, 8Bh, 4Dh, 0Eh, 6, 1Fh, 0Eh, 7, 8Dh, 3Eh, 6Eh, 40h, 51h, 83h, 0E1h
	db	1, 0FCh, 0F3h, 0A4h, 59h, 0D1h, 0E9h, 0F3h, 0A5h, 5Fh, 7, 1Fh, 6, 0E8h, 32h, 0FBh
	db	0Eh, 7, 8Dh, 16h, 6Eh, 40h, 0CDh, 33h, 7, 26h, 89h, 45h, 0Ah, 0C3h, 0E8h, 21h
	db	0FBh, 50h, 26h, 8Ah, 45h, 4, 0E8h, 90h, 3, 58h, 8Bh, 0D6h, 6, 57h, 0CDh, 33h
	db	5Fh, 7, 26h, 89h, 45h, 0Ah, 0C3h, 6, 0B8h, 0Ch, 0, 33h, 0C9h, 0Eh, 7, 8Dh
	db	16h, 7, 42h, 0CDh, 33h, 7, 0C3h, 6, 57h, 0E8h, 0F6h, 0FAh, 0Bh, 0DBh, 74h, 0Eh
	db	2Eh, 89h, 16h, 0FEh, 40h, 0Eh, 7, 8Dh, 16h, 0C5h, 41h, 0EBh, 6, 90h, 2Eh, 0C4h
	db	16h, 0, 41h, 0CDh, 33h, 2Eh, 83h, 3Eh, 2, 41h, 0, 75h, 0Ah, 2Eh, 89h, 16h
	db	0, 41h, 2Eh, 8Ch, 6, 2, 41h, 5Fh, 7, 0E8h, 0DCh, 0FAh, 0C3h, 6, 57h, 57h
	db	50h, 0B8h
	dw	seg S589_START
	db	8Eh, 0C0h, 26h, 8Eh, 6, 90h, 0, 0B0h, 5, 0E8h, 5Fh, 2, 26h, 0C7h, 45h, 6
	db	22h, 0, 2Eh, 0A1h, 0FEh, 40h, 26h, 89h, 45h, 8, 58h, 26h, 89h, 45h, 0Ah, 26h
	db	89h, 5Dh, 0Ch, 26h, 89h, 4Dh, 0Eh, 26h, 89h, 55h, 10h, 26h, 89h, 75h, 12h, 26h
	db	8Fh, 45h, 14h, 0E8h, 80h, 1, 0E8h, 0C4h, 2, 5Fh, 7, 0CBh, 0B4h, 32h, 26h, 8Bh
	db	55h, 0Ah, 0FEh, 0C2h, 0E8h, 10h, 0, 26h, 89h, 45h, 0Ah, 3Ch, 0FFh, 74h, 7, 8Bh
	db	47h, 2, 26h, 89h, 45h, 0Ch, 0C3h, 2Eh, 0C6h, 6, 0CEh, 36h, 1, 2Eh, 8Ch, 16h
	db	0CFh, 36h, 2Eh, 89h, 26h, 0D1h, 36h, 80h, 0FCh, 48h, 74h, 19h, 80h, 0FCh, 49h, 74h
	db	1Bh, 0F8h, 0CDh, 21h, 2Eh, 8Eh, 16h, 0CFh, 36h, 2Eh, 8Bh, 26h, 0D1h, 36h, 2Eh, 0C6h
	db	6, 0CEh, 36h, 0, 0C3h, 2Eh, 0FFh, 1Eh, 72h, 21h, 0EBh, 0E8h, 2Eh, 0FFh, 1Eh, 76h
	db	21h, 0EBh, 0E1h, 2Eh, 80h, 3Eh, 0CEh, 36h, 0, 74h, 2Ah, 6, 57h, 2Eh, 8Eh, 6
	db	0CAh, 36h, 2Eh, 8Bh, 3Eh, 0CCh, 36h, 26h, 0C6h, 6, 61h, 0, 1, 26h, 0F6h, 45h
	db	1, 8, 74h, 0Ch, 26h, 80h, 4Dh, 1, 10h, 5Fh, 7, 0EBh, 0B7h, 0EBh, 3, 90h
	db	5Fh, 7, 0EBh, 2, 90h, 90h, 0CFh, 83h, 0ECh, 10h, 55h, 8Bh, 0ECh, 26h, 8Ah, 45h
	db	4, 0E8h, 61h, 2, 26h, 8Bh, 5Dh, 0Ah, 0B1h, 4, 0D3h, 0EBh, 43h, 0B4h, 48h, 0E8h
	db	75h, 0FFh, 73h, 0Eh, 26h, 0C7h, 45h, 0Ah, 8, 0, 26h, 83h, 4Dh, 16h, 1, 0E9h
	db	86h, 0, 55h, 57h, 6, 26h, 8Bh, 4Dh, 0Ah, 6, 8Eh, 0C0h, 1Fh, 0BFh, 0, 0
	db	0FCh, 0F3h, 0A4h, 33h, 0F6h, 0B4h, 1, 26h, 8Ah, 4, 46h, 0Ah, 0E0h, 74h, 4, 8Ah
	db	0E0h, 0EBh, 0F4h, 8Bh, 0D6h, 26h, 8Ah, 4, 46h, 3Ch, 0, 75h, 0F8h, 46h, 89h, 76h
	db	4, 8Bh, 0DDh, 83h, 0C3h, 2, 8Ch, 46h, 2, 8Ch, 46h, 6, 8Ch, 46h, 0Ah, 8Ch
	db	46h, 0Eh, 6, 1Fh, 16h, 7, 53h, 0B4h, 62h, 0E8h, 1Bh, 0FFh, 0C7h, 46h, 8, 5Ch
	db	0, 89h, 5Eh, 0Ah, 0C7h, 46h, 0Ch, 6Ch, 0, 89h, 5Eh, 0Eh, 5Bh, 0B8h, 0, 4Bh
	db	0E8h, 4, 0FFh, 7, 5Fh, 72h, 0Dh, 0B4h, 4Dh, 0E8h, 0FBh, 0FEh, 26h, 83h, 65h, 16h
	db	0FEh, 0EBh, 6, 90h, 26h, 83h, 4Dh, 16h, 1, 26h, 89h, 45h, 0Ah, 5Dh, 6, 8Eh
	db	46h, 2, 0B4h, 49h, 0E8h, 0E0h, 0FEh, 7, 5Dh, 83h, 0C4h, 10h, 0C3h, 1Eh, 50h, 0B8h
	dw	seg S589_START
	db	8Eh, 0D8h, 0C6h, 6, 55h, 0, 0, 0C6h, 6, 84h, 0, 0, 58h, 1Fh, 0C3h, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db	0, 0, 0, 0
L04382:	pushf	;@04382
	pop	word ptr es:[di+16h]	;@04383
	call	@@1	;@04387
	ret	;@0438A
@@1:	call	L04394	;@0438B
	xor	al, al	;@0438E
	call	L03763	;@04390
	ret	;@04393
L04394:	push	ax	;@04394
	push	bx	;@04395
	cli	;@04396
	xor	bx, bx	;@04397
	mov	bl, byte ptr es:[254h]	;@04399
	mov	al, byte ptr es:[di]	;@0439E
	mov	byte ptr es:[bx+256h], al	;@043A1
	inc	bl	;@043A6
	cmp	bx, 10h	;@043A8
	jb	@@1	;@043AB
	xor	bx, bx	;@043AD
@@1:	mov	byte ptr es:[254h], bl	;@043AF
	call	L04B8F	;@043B4
	cmp	byte ptr es:[64h], 2	;@043B7
	jne	@@2	;@043BD
	sub	sp, 4	;@043BF
	push	bp	;@043C2
	mov	bp, sp	;@043C3
	mov	word ptr [bp+4], 0	;@043C5
	mov	word ptr [bp+2], 5Fh	;@043CA
	pop	bp	;@043CF
	nosmart
	call	far ptr L048E0	;@043D0
	smart
	add	sp, 4	;@043D5
	sub	sp, 4	;@043D8
	push	bp	;@043DB
	mov	bp, sp	;@043DC
	mov	word ptr [bp+4], 0	;@043DE
	mov	word ptr [bp+2], 53h	;@043E3
	pop	bp	;@043E8
	nosmart
	call	far ptr L048E0	;@043E9
	smart
	add	sp, 4	;@043EE
	mov	al, 1	;@043F1
	mov	ah, 4Ch	;@043F3
	int	21h	;@043F5
@@2:	pop	bx	;@043F7
	pop	ax	;@043F8
	ret	;@043F9
L043FA:	push	ax	;@043FA
	push	bx	;@043FB
	mov	al, 0FFh	;@043FC
	pushf	;@043FE
	cli	;@043FF
	xor	bx, bx	;@04400
	mov	bl, byte ptr es:[267h]	;@04402
	cmp	bl, byte ptr es:[266h]	;@04407
	je	@@3	;@0440C
	xchg	byte ptr es:[bx+268h], al	;@0440E
	inc	bl	;@04413
	cmp	bl, 10h	;@04415
	jae	@@4	;@04418
@@1:	mov	byte ptr es:[267h], bl	;@0441A
	popf	;@0441F
	xor	bh, bh	;@04420
	mov	bl, al	;@04422
	shl	bx, 1	;@04424
	mov	di, word ptr cs:[bx+4364h]	;@04426
	clc	;@0442B
@@2:	pop	bx	;@0442C
	pop	ax	;@0442D
	ret	;@0442E
@@3:	popf	;@0442F
	stc	;@04430
	jmp	@@2	;@04431
@@4:	xor	bl, bl	;@04433
	jmp	@@1	;@04435
L04437:	push	bx	;@04437
	push	cx	;@04438
	mov	cl, 4	;@04439
	mov	bl, byte ptr es:[62h]	;@0443B
	test	al, 1	;@04440
	jne	@@1	;@04442
	mov	byte ptr es:[62h], 0	;@04444
	jmp	@@3	;@0444A
@@1:	mov	bh, bl	;@0444D
	inc	bh	;@0444F
	cmp	bh, 1	;@04451
	nop	;@04454
	jbe	@@2	;@04455
	mov	bh, 0	;@04457
@@2:	mov	byte ptr es:[62h], bh	;@04459
@@3:	xor	bh, bh	;@0445E
	push	cx	;@04460
	xor	cx, cx	;@04461
@@4:	dec	cx	;@04463
	cmp	cx, 0	;@04464
	jne	@@5	;@04467
	pop	cx	;@04469
	sub	sp, 4	;@0446A
	push	bp	;@0446D
	mov	bp, sp	;@0446E
	mov	word ptr [bp+4], 0	;@04470
	mov	word ptr [bp+2], 21h	;@04475
	pop	bp	;@0447A
	nosmart
	call	far ptr L048E0	;@0447B
	smart
	add	sp, 4	;@04480
	sub	sp, 4	;@04483
	push	bp	;@04486
	mov	bp, sp	;@04487
	mov	word ptr [bp+4], 0	;@04489
	mov	word ptr [bp+2], 53h	;@0448E
	pop	bp	;@04493
	nosmart
	call	far ptr L048E0	;@04494
	smart
	add	sp, 4	;@04499
	mov	al, 1	;@0449C
	mov	ah, 4Ch	;@0449E
	int	21h	;@044A0
@@5:	cmp	byte ptr es:[bx+243h], 0	;@044A2
	je	@@6	;@044A8
	inc	bl	;@044AA
	cmp	bl, cl	;@044AC
	jbe	@@4	;@044AE
	mov	bl, 0	;@044B0
	jmp	@@4	;@044B2
@@6:	pop	cx	;@044B4
	mov	byte ptr es:[bx+243h], 1	;@044B5
	shl	bx, 1	;@044BB
	mov	di, word ptr cs:[bx+4364h]	;@044BD
	mov	byte ptr es:[di+1], al	;@044C2
	pop	cx	;@044C6
	pop	bx	;@044C7
	ret	;@044C8
L044C9:	push	bx	;@044C9
	xor	bx, bx	;@044CA
	mov	bl, byte ptr es:[di]	;@044CC
	call	@@1	;@044CF
	mov	byte ptr es:[bx+243h], 0	;@044D2
	pop	bx	;@044D8
	ret	;@044D9
@@1:	push	bx	;@044DA
	mov	bx, 0FFh	;@044DB
	xchg	byte ptr es:[di+4], bl	;@044DE
	test	bl, 80h	;@044E2
	jne	@@2	;@044E5
	mov	byte ptr es:[bx+252h], 0	;@044E7
@@2:	mov	bx, 0FFh	;@044ED
	xchg	byte ptr es:[di+5], bl	;@044F0
	test	bl, 80h	;@044F4
	jne	@@3	;@044F7
	mov	byte ptr es:[bx+252h], 0	;@044F9
@@3:	pop	bx	;@044FF
	ret	;@04500
L04501:	push	bx	;@04501
	test	al, 80h	;@04502
	je	@@1	;@04504
	lea	si, [di+18h]	;@04506
	jmp	@@2	;@04509
@@1:	xor	bx, bx	;@0450C
	mov	bl, al	;@0450E
	shl	bx, 1	;@04510
	mov	si, word ptr cs:[bx+4360h]	;@04512
@@2:	pop	bx	;@04517
	ret	;@04518
	db	50h, 0E8h, 10h, 0, 26h, 88h, 45h, 4, 58h, 0C3h, 50h, 0E8h, 6, 0, 26h, 88h	;@04519
	db	45h, 5, 58h, 0C3h, 53h, 26h, 8Ah, 5Dh, 4, 0F6h, 0C3h, 80h, 74h, 5, 80h, 0FBh
	db	0FFh, 75h, 1Eh, 26h, 8Ah, 5Dh, 5, 0F6h, 0C3h, 80h, 74h, 5, 80h, 0FBh, 0FFh, 75h
	db	10h, 0BAh, 0C0h, 0, 3Bh, 0CAh, 77h, 9, 33h, 0F6h, 8Dh, 75h, 18h, 0B0h, 80h, 0EBh
	db	46h, 0BAh, 0, 10h, 3Bh, 0CAh, 76h, 3Ch, 51h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h
	db	46h, 4, 2, 0, 0C7h, 46h, 2, 22h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 6, 0E8h, 0D7h, 0EFh, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0
	db	0, 0C7h, 46h, 2, 53h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0B0h, 1, 0B4h, 4Ch, 0CDh, 21h, 0E8h, 2, 0, 5Bh, 0C3h, 53h, 57h
	db	0BBh, 1, 0, 0B0h, 1, 26h, 86h, 87h, 52h, 2, 3Ch, 1, 75h, 40h, 83h, 0EBh
	db	1, 7Dh, 0F0h, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0, 0, 0C7h, 46h
	db	2, 21h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0E8h, 82h, 0EFh, 83h, 0ECh, 4, 55h, 8Bh, 0ECh, 0C7h, 46h, 4, 0
	db	0, 0C7h, 46h, 2, 53h, 0, 5Dh, 9Ah
	dd	L048E0
	db	83h, 0C4h, 4, 0B0h, 1, 0B4h, 4Ch, 0CDh, 21h, 8Ah, 0C3h, 0D1h, 0E3h, 33h, 0F6h, 2Eh
	db	8Bh, 0B7h, 60h, 43h, 5Fh, 5Bh, 0C3h, 57h, 50h, 53h, 51h, 0B9h, 0Fh, 0, 33h, 0DBh
	db	0BFh, 78h, 2, 2Eh, 89h, 0BFh, 64h, 43h, 81h, 0C7h, 0D8h, 0, 83h, 0C3h, 2, 0E2h
	db	0F2h, 0B9h, 2, 0, 33h, 0DBh, 0BFh, 20h, 0Fh, 2Eh, 89h, 0BFh, 60h, 43h, 81h, 0C7h
	db	0, 10h, 83h, 0C3h, 2, 0E2h, 0F2h, 59h, 5Bh, 58h, 5Fh, 0C3h
L04635:	ret	;@04635
	db	0Ah dup (0)	;@04636
L04640:	push	ax	;@04640
	push	bx	;@04641
	push	cx	;@04642
	push	dx	;@04643
	push	ds	;@04644
	mov	ax, cx	;@04645
	mov	cx, 0FFFFh	;@04647
	push	cx	;@0464A
	mov	cx, 0Ah	;@0464B
@@1:	cmp	ax, cx	;@0464E
	jae	@@2	;@04650
	add	ax, 30h	;@04652
	push	ax	;@04655
	jmp	@@3	;@04656
@@2:	xor	dx, dx	;@04659
	div	cx	;@0465B
	add	dx, 30h	;@0465D
	push	dx	;@04660
	jmp	@@1	;@04661
@@3:	pop	ax	;@04663
	cmp	ax, 0FFFFh	;@04664
	jne	@@4	;@04667
	jmp	@@5	;@04669
@@4:	call	L046C2	;@0466C
	jmp	@@3	;@0466F
@@5:	pop	ds	;@04671
	pop	dx	;@04672
	pop	cx	;@04673
	pop	bx	;@04674
	pop	ax	;@04675
	ret	;@04676
L04677:	push	ax	;@04677
	push	bx	;@04678
	push	cx	;@04679
	push	dx	;@0467A
	push	ds	;@0467B
	mov	al, ch	;@0467C
	shr	al, 1	;@0467E
	shr	al, 1	;@04680
	shr	al, 1	;@04682
	shr	al, 1	;@04684
	call	@@1	;@04686
	mov	al, ch	;@04689
	call	@@1	;@0468B
	mov	al, cl	;@0468E
	shr	al, 1	;@04690
	shr	al, 1	;@04692
	shr	al, 1	;@04694
	shr	al, 1	;@04696
	call	@@1	;@04698
	mov	al, cl	;@0469B
	call	@@1	;@0469D
	mov	al, 20h	;@046A0
	call	L046C2	;@046A2
	pop	ds	;@046A5
	pop	dx	;@046A6
	pop	cx	;@046A7
	pop	bx	;@046A8
	pop	ax	;@046A9
	ret	;@046AA
@@1:	push	cx	;@046AB
	push	ax	;@046AC
	and	al, 0Fh	;@046AD
	cmp	al, 9	;@046AF
	jg	@@2	;@046B1
	add	al, 30h	;@046B3
	jmp	@@3	;@046B5
@@2:	sub	al, 0Ah	;@046B8
	add	al, 41h	;@046BA
@@3:	call	L046C2	;@046BC
	pop	ax	;@046BF
	pop	cx	;@046C0
	ret	;@046C1
L046C2:	push	ax	;@046C2
	push	bx	;@046C3
	push	cx	;@046C4
	push	dx	;@046C5
	push	ds	;@046C6
	mov	dl, al	;@046C7
	mov	ah, 2	;@046C9
	int	21h	;@046CB
	pop	ds	;@046CD
	pop	dx	;@046CE
	pop	cx	;@046CF
	pop	bx	;@046D0
	pop	ax	;@046D1
	ret	;@046D2
L046D3:	push	ds	;@046D3
	push	ax	;@046D4
	mov	ax, seg S59F_START	;@046D5
	mov	ds, ax	;@046D8
	mov	ah, 9	;@046DA
	int	21h	;@046DC
	pop	ax	;@046DE
	pop	ds	;@046DF
	ret	;@046E0
	db	50h, 53h, 1Eh, 52h, 0BAh, 33h, 0, 0E8h, 0E8h, 0FFh, 5Ah, 0B8h	;@046E1
	dw	seg S59F_START
	db	8Eh, 0D8h, 0A1h, 31h, 0, 3Dh, 0FFh, 0FFh, 74h, 0Bh, 52h, 0BAh, 48h, 0, 0E8h, 0D3h
	db	0FFh, 5Ah, 0EBh, 2Ch, 90h, 0B8h, 0, 3Ch, 0CDh, 21h, 73h, 19h, 51h, 52h, 0BAh, 5Eh
	db	0, 0E8h, 0C0h, 0FFh, 5Ah, 8Bh, 0C8h, 0E8h, 5Eh, 0FFh, 52h, 0BAh, 6Ch, 0, 0E8h, 0B3h
	db	0FFh, 5Ah, 59h, 33h, 0DBh, 0A3h, 31h, 0, 52h, 0BAh, 70h, 0, 0E8h, 0A5h, 0FFh, 5Ah
	db	1Fh, 5Bh, 58h, 0C3h, 50h, 53h, 51h, 52h, 1Eh, 8Ah, 0C5h, 0D0h, 0E8h, 0D0h, 0E8h, 0D0h
	db	0E8h, 0D0h, 0E8h, 0E8h, 22h, 0, 8Ah, 0C5h, 0E8h, 1Dh, 0, 8Ah, 0C1h, 0D0h, 0E8h, 0D0h
	db	0E8h, 0D0h, 0E8h, 0D0h, 0E8h, 0E8h, 10h, 0, 8Ah, 0C1h, 0E8h, 0Bh, 0, 0B0h, 20h, 0E8h
	db	33h, 0, 1Fh, 5Ah, 59h, 5Bh, 58h, 0C3h, 51h, 50h, 24h, 0Fh, 3Ch, 9, 7Fh, 5
	db	4, 30h, 0EBh, 5, 90h, 2Ch, 0Ah, 4, 41h, 0E8h, 19h, 0, 58h, 59h, 0C3h, 1Eh
	db	50h, 53h, 51h, 0B8h
	dw	seg S59F_START
	db	8Eh, 0D8h, 8Bh, 1Eh, 31h, 0, 0B4h, 40h, 0CDh, 21h, 59h, 5Bh, 58h, 1Fh, 0C3h, 50h
	db	51h, 52h, 1Eh, 0BAh
	dw	seg S59F_START
	db	8Eh, 0DAh, 0A2h, 30h, 0, 0BAh, 30h, 0, 0B9h, 1, 0, 0E8h, 0D5h, 0FFh, 1Fh, 5Ah
	db	59h, 58h, 0C3h, 50h, 53h, 1Eh, 0B8h
	dw	seg S59F_START
	db	8Eh, 0D8h, 8Bh, 1Eh, 31h, 0, 0B4h, 45h, 0CDh, 21h, 8Bh, 0D8h, 0B4h, 3Eh, 0CDh, 21h
	db	1Fh, 5Bh, 58h, 0C3h, 0, 0, 0, 0, 0, 0, 0, 0, 24h, 2Ah, 24h, 2Ah
	db	24h, 2Ah, 4, 34h, 0, 2, 50h, 52h, 4Fh, 54h, 20h, 4Bh, 45h, 52h, 4Eh, 45h
	db	4Ch, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
L047F0:	push	cx	;@047F0
	mov	cl, al	;@047F1
	mov	ch, al	;@047F3
	mov	ax, bx	;@047F5
	shl	bx, cl	;@047F7
	mov	cl, 10h	;@047F9
	sub	cl, ch	;@047FB
	shr	ax, cl	;@047FD
	pop	cx	;@047FF
	ret	;@04800
	db	52h, 8Ah, 0E9h, 0D3h, 0E0h, 8Bh, 0D3h, 0D3h, 0E3h, 0B1h, 10h, 2Ah	;@04801
	db	0CDh, 0D3h, 0EAh, 0Bh, 0C2h, 5Ah, 0C3h, 8Ah, 0E9h, 0D3h, 0EBh
	db	0B1h, 10h, 2Ah, 0CDh, 0D3h, 0E0h, 0Bh, 0D8h, 33h, 0C0h, 0C3h
L04823:	push	dx	;@04823
	mov	ch, cl	;@04824
	shr	bx, cl	;@04826
	mov	dx, ax	;@04828
	shr	ax, cl	;@0482A
	mov	cl, 10h	;@0482C
	sub	cl, ch	;@0482E
	shl	dx, cl	;@04830
	or	bx, dx	;@04832
	pop	dx	;@04834
	ret	;@04835
	db	51h, 0B1h, 4, 0D3h, 0C8h, 25h, 0, 0F0h, 53h, 0D3h, 0EBh, 0Bh, 0C3h, 5Bh, 83h, 0E3h	;@04836
	db	0Fh, 59h, 0C3h, 0C3h, 0C3h, 50h, 51h, 32h, 0E4h, 8Ah, 0C5h, 0D0h, 0E8h, 0D0h, 0E8h, 0D0h
	db	0E8h, 0D0h, 0E8h, 0E8h, 2Bh, 0, 0E8h, 36h, 0, 8Ah, 0C5h, 0E8h, 23h, 0, 0E8h, 2Eh
	db	0, 8Ah, 0C1h, 0D0h, 0E8h, 0D0h, 0E8h, 0D0h, 0E8h, 0D0h, 0E8h, 0E8h, 13h, 0, 0E8h, 1Eh
	db	0, 8Ah, 0C1h, 0E8h, 0Bh, 0, 0E8h, 16h, 0, 0B0h, 20h, 0E8h, 11h, 0, 59h, 58h
	db	0C3h, 24h, 0Fh, 3Ch, 9, 7Fh, 5, 4, 30h, 0EBh, 3, 90h, 4, 37h, 0C3h, 9Ch
	db	1Eh, 6, 57h, 53h, 0BBh
	dw	seg S589_START
	db	8Eh, 0C3h, 26h, 8Eh, 1Eh, 2Ch, 1, 26h, 8Bh, 1Eh, 30h, 1, 26h, 8Eh, 6, 90h
	db	0, 26h, 8Bh, 3Eh, 4Fh, 1, 50h, 0B4h, 7, 89h, 5, 83h, 0C7h, 2, 3Bh, 0FBh
	db	76h, 2, 33h, 0FFh, 26h, 89h, 3Eh, 4Fh, 1, 58h, 80h, 0FCh, 1, 75h, 8, 0E8h
	db	7Ch, 0FFh, 26h, 8Bh, 3Eh, 4Fh, 1, 0C7h, 5, 0DBh, 7, 5Bh, 5Fh, 7, 1Fh, 9Dh
	db	0C3h, 0, 0
S000	ends

S9FA	segment byte public 'CODE'
	assume	cs:S9FA
L0A7E4:	push	es	;@0A7E4
	push	ds	;@0A7E5
	push	si	;@0A7E6
	push	ax	;@0A7E7
	call	far ptr L021D3	;@0A7E8
	mov	word ptr cs:L0A471+70, dx	;@0A7ED
	mov	word ptr cs:L0A471+68, ax	;@0A7F2
	pop	ax	;@0A7F6
	mov	byte ptr cs:L0A471+79, al	;@0A7F7
	cmp	al, 0	;@0A7FB
	jne	@@1	;@0A7FD
	db	0EBh, 7Dh	; jmp @@8	;@0A7FF
	db	90h	;@0A801
@@1:	les	si, dword ptr cs:L0A471+68	;@0A802
	db	0E8h, 47h, 1	; call @@25	;@0A807
	jae	@@2	;@0A80A
	mov	ax, 0Ah	;@0A80C
	db	0E9h, 93h, 0	; jmp @@12	;@0A80F
@@2:	lds	si, dword ptr cs:L0A471+68	;@0A812
	test	word ptr [si+7], 64h	;@0A817
	jne	@@3	;@0A81C
	db	0E8h, 53h, 3	; call @@64	;@0A81E
@@3:	db	0E8h, 7Dh, 0Ch	; call @@229	;@0A821
	db	72h, 3Fh	; jb @@5	;@0A824
	db	0EBh, 28h	; jmp @@4	;@0A826
	db	90h, 'Incompatible program loaded - Vcache', 0Dh, 0Ah, 24h	;@0A828
@@4:	db	1Eh	; push ds	;@0A850
	push	dx	;@0A851
	push	ax	;@0A852
	mov	dx, 889h	;@0A853
	push	cs	;@0A856
	pop	ds	;@0A857
	mov	ah, 9	;@0A858
	int	21h	;@0A85A
	pop	ax	;@0A85C
	pop	dx	;@0A85D
	pop	ds	;@0A85E
	mov	ax, 0Ah	;@0A85F
	jmp	@@12	;@0A862
@@5:	call	@@79	;@0A865
	jae	@@6	;@0A868
	mov	ax, 0Ah	;@0A86A
	jmp	@@12	;@0A86D
@@6:	cmp	byte ptr cs:L0A471+79, 2	;@0A870
	jne	@@7	;@0A876
	jmp	@@10	;@0A878
@@7:	mov	ax, 1	;@0A87B
@@8:	db	0E8h, 0Ch, 5	; call @@98	;@0A87E
	cmp	ax, 0	;@0A881
	je	@@9	;@0A884
	jmp	short @@12	;@0A886
	db	0EBh, 0Bh, 90h	;@0A888
@@9:	cmp	byte ptr cs:L0A471+79, 0	;@0A88B
	jne	@@10	;@0A891
	jmp	short @@12	;@0A893
@@10:	call	@@13	;@0A895
	jae	@@11	;@0A898
	mov	ax, 0Ah	;@0A89A
	jmp	@@12	;@0A89D
@@11:	xor	ax, ax	;@0A8A0
	db	0E8h, 0F3h, 5	; call @@114	;@0A8A2
@@12:	push	ax	;@0A8A5
	lds	si, dword ptr cs:L0A471+68	;@0A8A6
	mov	al, byte ptr [si+91h]	;@0A8AB
	mov	byte ptr cs:L0A471+88, al	;@0A8AF
	pop	ax	;@0A8B3
	or	ax, ax	;@0A8B4
	pop	si	;@0A8B6
	pop	ds	;@0A8B7
	pop	es	;@0A8B8
	ret	;@0A8B9
@@13:	push	ax	;@0A8BA
	push	es	;@0A8BB
	push	si	;@0A8BC
	les	si, dword ptr cs:L0A471+68	;@0A8BD
	call	@@18	;@0A8C2
	jb	@@16	;@0A8C5
	push	es	;@0A8C7
	mov	ax, seg S5FD_START	;@0A8C8
	mov	es, ax	;@0A8CB
	mov	ax, word ptr es:[4Dh]	;@0A8CD
	pop	es	;@0A8D1
	cmp	ax, 0	;@0A8D2
	jne	@@14	;@0A8D5
	call	@@59	;@0A8D7
	jb	@@16	;@0A8DA
	call	@@57	;@0A8DC
	call	@@17	;@0A8DF
	test	word ptr es:[si+7], 64h	;@0A8E2
	jne	@@14	;@0A8E8
	call	@@62	;@0A8EA
@@14:	clc	;@0A8ED
@@15:	pop	si	;@0A8EE
	pop	es	;@0A8EF
	pop	ax	;@0A8F0
	ret	;@0A8F1
@@16:	stc	;@0A8F2
	jmp	@@15	;@0A8F3
@@17:	ret	;@0A8F5
@@18:	push	ds	;@0A8F6
	push	cs	;@0A8F7
	pop	ds	;@0A8F8
	push	sp	;@0A8F9
	pop	ax	;@0A8FA
	cmp	ax, sp	;@0A8FB
	je	@@19	;@0A8FD
	jmp	@@23	;@0A8FF
@@19:	db	0E8h, 0DBh, 0Dh	; call @@268	;@0A902
	cmp	ah, 0	;@0A905
	jne	@@20	;@0A908
	mov	byte ptr es:[si+22h], 1	;@0A90A
	push	es	;@0A90F
	mov	ax, seg S5FD_START	;@0A910
	mov	es, ax	;@0A913
	mov	word ptr es:[4Dh], 128h	;@0A915
	pop	es	;@0A91C
	jmp	@@22	;@0A91D
@@20:	push	es	;@0A920
	mov	ax, seg S5FD_START	;@0A921
	mov	es, ax	;@0A924
	mov	word ptr es:[4Dh], 0	;@0A926
	pop	es	;@0A92D
	db	2Eh, 0Fh, 1, 0Eh, 21h, 5	; sidt fword ptr cs:L0A471+80	;@0A92E
	mov	al, byte ptr cs:L0A471+85	;@0A934
	cbw	;@0A938
	cmp	ax, 0	;@0A939
	jne	@@21	;@0A93C
	mov	byte ptr es:[si+22h], 1	;@0A93E
	jmp	@@22	;@0A943
@@21:	mov	byte ptr es:[si+22h], 0	;@0A946
@@22:	clc	;@0A94B
	jmp	short @@24	;@0A94C
@@23:	stc	;@0A94E
@@24:	pop	ds	;@0A94F
	ret	;@0A950
@@25:	push	bx	;@0A951
	push	dx	;@0A952
	push	si	;@0A953
	push	di	;@0A954
	call	@@55	;@0A955
	lea	si, [si+2]	;@0A958
	cmp	dx, word ptr es:[si+7]	;@0A95B
	je	@@26	;@0A95F
	jmp	@@28	;@0A961
@@26:	cmp	bx, word ptr es:[si+9]	;@0A964
	je	@@27	;@0A968
	jmp	@@28	;@0A96A
@@27:	clc	;@0A96D
	jmp	short @@30	;@0A96E
@@28:	mov	di, si	;@0A970
	call	far ptr L09CF0	;@0A972
	cmc	;@0A977
	jae	@@30	;@0A978
	db	0E8h, 63h, 0Dh	; call @@268	;@0A97A
	cmp	ah, 0	;@0A97D
	jne	@@29	;@0A980
	mov	byte ptr es:[si], 7	;@0A982
	mov	byte ptr es:[si+1], 7	;@0A986
	mov	byte ptr es:[si+2], 4	;@0A98B
	mov	word ptr es:[si+3], 0	;@0A990
	mov	word ptr es:[si+5], 0	;@0A996
	clc	;@0A99C
	jmp	@@30	;@0A99D
@@29:	call	@@31	;@0A9A0
	cmc	;@0A9A3
	jae	@@30	;@0A9A4
	sub	sp, 4	;@0A9A6
	push	bp	;@0A9A9
	mov	bp, sp	;@0A9AA
	mov	word ptr [bp+4], 0	;@0A9AC
	mov	word ptr [bp+2], 5Ah	;@0A9B1
	pop	bp	;@0A9B6
	call	far ptr L048E0	;@0A9B7
	add	sp, 4	;@0A9BC
	stc	;@0A9BF
@@30:	pop	di	;@0A9C0
	pop	si	;@0A9C1
	pop	dx	;@0A9C2
	pop	bx	;@0A9C3
	ret	;@0A9C4
@@31:	push	dx	;@0A9C5
	push	bx	;@0A9C6
	call	@@46	;@0A9C7
	jae	@@34	;@0A9CA
	mov	byte ptr es:[si], 3	;@0A9CC
	mov	byte ptr es:[si+1], 3	;@0A9D0
	call	@@41	;@0A9D5
	jae	@@32	;@0A9D8
	mov	byte ptr es:[si+2], 4	;@0A9DA
	jmp	@@33	;@0A9DF
@@32:	mov	byte ptr es:[si+2], 2	;@0A9E2
@@33:	jmp	@@37	;@0A9E7
@@34:	call	@@51	;@0A9EA
	jae	@@35	;@0A9ED
	mov	byte ptr es:[si], 2	;@0A9EF
	mov	byte ptr es:[si+1], 2	;@0A9F3
	mov	byte ptr es:[si+2], 3	;@0A9F8
	or	word ptr es:[si+5], 8	;@0A9FD
	jmp	@@39	;@0AA02
@@35:	call	@@47	;@0AA05
	jae	@@36	;@0AA08
	mov	byte ptr es:[si], 1	;@0AA0A
	mov	byte ptr es:[si+1], 1	;@0AA0E
	mov	byte ptr es:[si+2], 3	;@0AA13
	jmp	@@39	;@0AA18
@@36:	call	@@41	;@0AA1B
	jae	@@38	;@0AA1E
	mov	byte ptr es:[si], 2	;@0AA20
	mov	byte ptr es:[si+1], 2	;@0AA24
	mov	byte ptr es:[si+2], 4	;@0AA29
	mov	word ptr es:[si+3], 0	;@0AA2E
	mov	word ptr es:[si+5], 0	;@0AA34
@@37:	pop	bx	;@0AA3A
	pop	dx	;@0AA3B
	mov	word ptr es:[si+7], dx	;@0AA3C
	mov	word ptr es:[si+9], bx	;@0AA40
	stc	;@0AA44
	ret	;@0AA45
@@38:	pop	dx	;@0AA46
	pop	bx	;@0AA47
	clc	;@0AA48
	ret	;@0AA49
@@39:	call	@@41	;@0AA4A
	jae	@@40	;@0AA4D
	mov	byte ptr es:[si+2], 4	;@0AA4F
@@40:	stc	;@0AA54
	jmp	@@37	;@0AA55
@@41:	push	ax	;@0AA57
	db	2Eh, 0Fh, 1, 0Eh, 21h, 5	; sidt fword ptr cs:L0A471+80	;@0AA58
	mov	al, byte ptr cs:L0A471+85	;@0AA5E
	cbw	;@0AA62
	cmp	ax, 0	;@0AA63
	jne	@@42	;@0AA66
	jmp	short @@43	;@0AA68
	db	0EBh, 3, 90h	;@0AA6A
@@42:	jmp	short @@44	;@0AA6D
@@43:	stc	;@0AA6F
	jmp	short @@45	;@0AA70
@@44:	clc	;@0AA72
@@45:	pop	ax	;@0AA73
	ret	;@0AA74
	db	'TX;', 0C4h, 74h, 4, 0F9h, 0EBh, 2, 90h, 0F8h, 0C3h	;@0AA75
@@46:	push	ax	;@0AA81
	mov	ax, 0C300h	;@0AA82
	stc	;@0AA85
	int	15h	;@0AA86
	cmc	;@0AA88
	pop	ax	;@0AA89
	ret	;@0AA8A
@@47:	push	es	;@0AA8B
	push	ax	;@0AA8C
	mov	ax, 0F000h	;@0AA8D
	mov	es, ax	;@0AA90
	mov	ax, word ptr es:[0F8h]	;@0AA92
	cmp	ax, 5048h	;@0AA96
	je	@@48	;@0AA99
	clc	;@0AA9B
	jmp	@@50	;@0AA9C
@@48:	mov	al, byte ptr es:[63h]	;@0AA9F
	cmp	al, 41h	;@0AAA3
	jbe	@@49	;@0AAA5
	stc	;@0AAA7
	jmp	@@50	;@0AAA8
@@49:	clc	;@0AAAB
@@50:	pop	ax	;@0AAAC
	pop	es	;@0AAAD
	ret	;@0AAAE
@@51:	push	es	;@0AAAF
	push	ax	;@0AAB0
	mov	ax, 0F000h	;@0AAB1
	mov	es, ax	;@0AAB4
	mov	ax, word ptr es:[0F8h]	;@0AAB6
	cmp	ax, 5048h	;@0AABA
	je	@@52	;@0AABD
	clc	;@0AABF
	jmp	@@54	;@0AAC0
@@52:	mov	al, byte ptr es:[63h]	;@0AAC3
	cmp	al, 41h	;@0AAC7
	jne	@@53	;@0AAC9
	stc	;@0AACB
	jmp	@@54	;@0AACC
@@53:	clc	;@0AACF
@@54:	pop	ax	;@0AAD0
	pop	es	;@0AAD1
	ret	;@0AAD2
@@55:	push	ax	;@0AAD3
	push	cx	;@0AAD4
	push	ds	;@0AAD5
	push	si	;@0AAD6
	mov	cx, 4000h	;@0AAD7
	mov	ax, 0F000h	;@0AADA
	mov	ds, ax	;@0AADD
	mov	si, 8000h	;@0AADF
	xor	bx, bx	;@0AAE2
	xor	dx, dx	;@0AAE4
	cld	;@0AAE6
@@56:	lodsw	;@0AAE7
	rol	dx, 1	;@0AAE8
	rcl	bx, 1	;@0AAEA
	add	dx, ax	;@0AAEC
	adc	bx, 0	;@0AAEE
	loop	@@56	;@0AAF1
	pop	si	;@0AAF3
	pop	ds	;@0AAF4
	pop	cx	;@0AAF5
	pop	ax	;@0AAF6
	ret	;@0AAF7
@@57:	push	ax	;@0AAF8
	mov	ax, 4300h	;@0AAF9
	int	2Fh	;@0AAFC
	cmp	al, 80h	;@0AAFE
	jne	@@58	;@0AB00
	mov	byte ptr es:[si+2], 5	;@0AB02
	mov	byte ptr es:[si+3], 5	;@0AB07
	or	word ptr es:[si+7], 10h	;@0AB0C
@@58:	pop	ax	;@0AB11
	ret	;@0AB12
@@59:	smsw	ax	;@0AB13
	test	ax, 1	;@0AB16
	je	@@60	;@0AB19
	sub	sp, 4	;@0AB1B
	push	bp	;@0AB1E
	mov	bp, sp	;@0AB1F
	mov	word ptr [bp+4], 0	;@0AB21
	mov	word ptr [bp+2], 5Dh	;@0AB26
	pop	bp	;@0AB2B
	call	far ptr L048E0	;@0AB2C
	add	sp, 4	;@0AB31
	stc	;@0AB34
	jmp	@@61	;@0AB35
@@60:	clc	;@0AB38
@@61:	ret	;@0AB39
@@62:	push	es	;@0AB3A
	push	ax	;@0AB3B
	push	bx	;@0AB3C
	push	cx	;@0AB3D
	push	si	;@0AB3E
	pushf	;@0AB3F
	cli	;@0AB40
	mov	ax, 0F000h	;@0AB41
	mov	es, ax	;@0AB44
	mov	bx, word ptr es:[0FFF4h]	;@0AB46
	mov	ax, word ptr es:[8000h]	;@0AB4B
	mov	ax, word ptr es:[0E000h]	;@0AB4F
	mov	ax, word ptr es:[8000h]	;@0AB53
	mov	ax, word ptr es:[0E000h]	;@0AB57
	mov	ax, word ptr es:[0FFF4h]	;@0AB5B
	cmp	ax, bx	;@0AB5F
	je	@@63	;@0AB61
	les	si, dword ptr cs:L0A471+68	;@0AB63
	mov	byte ptr es:[si+4], 5	;@0AB68
@@63:	popf	;@0AB6D
	pop	si	;@0AB6E
	pop	cx	;@0AB6F
	pop	bx	;@0AB70
	pop	ax	;@0AB71
	pop	es	;@0AB72
	ret	;@0AB73
@@64:	push	ax	;@0AB74
	push	bx	;@0AB75
	push	ds	;@0AB76
	push	si	;@0AB77
	int	11h	;@0AB78
	and	al, 30h	;@0AB7A
	lds	si, dword ptr cs:L0A471+68	;@0AB7C
	cmp	al, 30h	;@0AB81
	jne	@@65	;@0AB83
	mov	word ptr [si+4Dh], 1	;@0AB85
	mov	word ptr [si+8Bh], 0B000h	;@0AB8A
	mov	word ptr [si+8Dh], 0B0h	;@0AB90
	mov	word ptr [si+8Fh], 3FFh	;@0AB96
	jmp	@@66	;@0AB9C
@@65:	mov	word ptr [si+4Dh], 2	;@0AB9F
	mov	word ptr [si+8Bh], 0B800h	;@0ABA4
	mov	word ptr [si+8Dh], 0B8h	;@0ABAA
	mov	word ptr [si+8Fh], 0FFFh	;@0ABB0
@@66:	mov	ah, 12h	;@0ABB6
	mov	bl, 10h	;@0ABB8
	int	10h	;@0ABBA
	cmp	bl, 10h	;@0ABBC
	je	@@67	;@0ABBF
	or	word ptr [si+4Dh], 4	;@0ABC1
@@67:	call	@@69	;@0ABC5
	cmp	ax, 0	;@0ABC8
	je	@@68	;@0ABCB
	or	word ptr [si+4Dh], 8	;@0ABCD
@@68:	pop	si	;@0ABD1
	pop	ds	;@0ABD2
	pop	bx	;@0ABD3
	pop	ax	;@0ABD4
	ret	;@0ABD5
@@69:	push	si	;@0ABD6
	push	di	;@0ABD7
	mov	ah, 0Fh	;@0ABD8
	int	10h	;@0ABDA
	cmp	al, 7	;@0ABDC
	je	@@70	;@0ABDE
	jmp	@@77	;@0ABE0
@@70:	mov	dx, 3BAh	;@0ABE3
	mov	cx, 64h	;@0ABE6
@@71:	in	al, dx	;@0ABE9
	and	al, 70h	;@0ABEA
	cmp	al, 50h	;@0ABEC
	jne	@@72	;@0ABEE
	loop	@@71	;@0ABF0
	mov	ax, 0DEh	;@0ABF2
	jmp	@@78	;@0ABF5
@@72:	mov	cx, 64h	;@0ABF8
@@73:	in	al, dx	;@0ABFB
	and	al, 70h	;@0ABFC
	cmp	al, 10h	;@0ABFE
	jne	@@74	;@0AC00
	loop	@@73	;@0AC02
	mov	ax, 70h	;@0AC04
	jmp	@@78	;@0AC07
@@74:	xor	bl, bl	;@0AC0A
	in	al, dx	;@0AC0C
	and	al, 80h	;@0AC0D
	mov	ah, al	;@0AC0F
	mov	cx, 8000h	;@0AC11
@@75:	in	al, dx	;@0AC14
	and	al, 80h	;@0AC15
	cmp	ah, al	;@0AC17
	je	@@76	;@0AC19
	inc	bl	;@0AC1B
	cmp	bl, 14h	;@0AC1D
	jbe	@@76	;@0AC20
	mov	ax, 66h	;@0AC22
	jmp	@@78	;@0AC25
@@76:	loop	@@75	;@0AC28
@@77:	xor	ax, ax	;@0AC2A
@@78:	pop	di	;@0AC2C
	pop	si	;@0AC2D
	ret	;@0AC2E
@@79:	push	ax	;@0AC2F
	push	bx	;@0AC30
	call	@@82	;@0AC31
	jae	@@80	;@0AC34
	clc	;@0AC36
	jmp	@@81	;@0AC37
@@80:	db	0E8h, 98h, 0	; call @@87	;@0AC3A
	pushf	;@0AC3D
	mov	bx, ax	;@0AC3E
	mov	ah, 3Eh	;@0AC40
	int	21h	;@0AC42
	popf	;@0AC44
@@81:	pop	bx	;@0AC45
	pop	ax	;@0AC46
	ret	;@0AC47
@@82:	push	ds	;@0AC48
	push	es	;@0AC49
	push	di	;@0AC4A
	push	si	;@0AC4B
	push	bx	;@0AC4C
	push	cx	;@0AC4D
	push	dx	;@0AC4E
	mov	ah, 62h	;@0AC4F
	int	21h	;@0AC51
	mov	es, bx	;@0AC53
	mov	ax, word ptr es:[2Ch]	;@0AC55
	mov	es, ax	;@0AC59
	xor	di, di	;@0AC5B
	push	cs	;@0AC5D
	pop	ds	;@0AC5E
@@83:	push	di	;@0AC5F
	mov	cx, 4	;@0AC60
	mov	si, 510h	;@0AC63
	repe cmpsb	;@0AC66
	pop	ax	;@0AC68
	cmp	cx, 0	;@0AC69
	jne	@@84	;@0AC6C
	push	es	;@0AC6E
	pop	ds	;@0AC6F
	mov	dx, di	;@0AC70
	mov	al, 0	;@0AC72
	mov	ah, 3Dh	;@0AC74
	int	21h	;@0AC76
	db	0EBh, 20h	; jmp @@86	;@0AC78
	db	90h	;@0AC7A
@@84:	mov	di, ax	;@0AC7B
	xor	al, al	;@0AC7D
	mov	cx, 0FFFFh	;@0AC7F
	repne scasb	;@0AC82
	mov	al, byte ptr es:[di]	;@0AC84
	cmp	al, 0	;@0AC87
	je	@@85	;@0AC89
	jmp	@@83	;@0AC8B
@@85:	push	cs	;@0AC8D
	pop	ds	;@0AC8E
	mov	dx, 0D02h	;@0AC8F
	mov	ah, 3Dh	;@0AC92
	int	21h	;@0AC94
	db	0EBh, 2	; jmp @@86	;@0AC96
	db	90h, 0F8h	;@0AC98
@@86:	db	5Ah	; pop dx	;@0AC9A
	pop	cx	;@0AC9B
	pop	bx	;@0AC9C
	pop	si	;@0AC9D
	pop	di	;@0AC9E
	pop	es	;@0AC9F
	pop	ds	;@0ACA0
	ret	;@0ACA1
	db	'\CONFIG.286', 0, 'PSQR', 0BAh, 1Fh, 5, 0B9h, 1, 0, 0B4h, 3Fh	;@0ACA2
	db	0CDh, 21h, 73h, 8, 0C6h, 6, 1Fh, 5, 0FEh, 0EBh, 0Bh, 90h, 3Dh
	db	0, 0, 75h, 5, 0C6h, 6, 1Fh, 5, 0FFh, 'ZY[X', 0C3h
@@87:	push	ax	;@0ACD5
	push	bx	;@0ACD6
	push	cx	;@0ACD7
	push	dx	;@0ACD8
	push	si	;@0ACD9
	push	di	;@0ACDA
	push	es	;@0ACDB
	push	ds	;@0ACDC
	mov	di, 0D0Eh	;@0ACDD
	mov	bx, ax	;@0ACE0
	push	cs	;@0ACE2
	pop	ds	;@0ACE3
	mov	byte ptr cs:L0A471+78, 0	;@0ACE4
@@88:	call	di	;@0ACEA
	cmp	byte ptr cs:L0A471+78, 0FEh	;@0ACEC
	jb	@@89	;@0ACF2
	jmp	@@96	;@0ACF4
@@89:	mov	si, 52Ah	;@0ACF7
	db	0E8h, 0FEh, 1	; call @@118	;@0ACFA
	cmp	byte ptr cs:L0A471+78, 0FEh	;@0ACFD
	jb	@@90	;@0AD03
	jmp	@@96	;@0AD05
@@90:	cmp	byte ptr cs:L0A471+89, 23h	;@0AD08
	je	@@93	;@0AD0E
	cmp	byte ptr cs:L0A471+78, 0FFh	;@0AD10
	jne	@@91	;@0AD16
	push	ax	;@0AD18
	mov	ax, 52Ah	;@0AD19
	push	ds	;@0AD1C
	push	ax	;@0AD1D
	sub	sp, 4	;@0AD1E
	push	bp	;@0AD21
	mov	bp, sp	;@0AD22
	mov	word ptr [bp+4], 4	;@0AD24
	mov	word ptr [bp+2], 5	;@0AD29
	pop	bp	;@0AD2E
	call	far ptr L048E0	;@0AD2F
	add	sp, 8	;@0AD34
	pop	ax	;@0AD37
	mov	byte ptr cs:L0A471+78, 0FEh	;@0AD38
	jmp	@@96	;@0AD3E
@@91:	mov	si, 5F3h	;@0AD41
	db	0E8h, 0B4h, 1	; call @@118	;@0AD44
	cmp	byte ptr cs:L0A471+78, 0FEh	;@0AD47
	jne	@@92	;@0AD4D
	jmp	@@96	;@0AD4F
@@92:	db	0E8h, 0DAh, 4	; call @@186	;@0AD52
	jae	@@93	;@0AD55
	mov	byte ptr cs:L0A471+78, 0FEh	;@0AD57
	jmp	@@96	;@0AD5D
@@93:	cmp	byte ptr cs:L0A471+78, 0Ah	;@0AD60
	je	@@95	;@0AD66
	call	di	;@0AD68
	cmp	byte ptr cs:L0A471+78, 0FEh	;@0AD6A
	jb	@@94	;@0AD70
	jmp	@@96	;@0AD72
@@94:	jmp	@@93	;@0AD75
@@95:	jmp	@@88	;@0AD77
@@96:	clc	;@0AD7A
	cmp	byte ptr cs:L0A471+78, 0FEh	;@0AD7B
	jne	@@97	;@0AD81
	stc	;@0AD83
@@97:	pop	ds	;@0AD84
	pop	es	;@0AD85
	pop	di	;@0AD86
	pop	si	;@0AD87
	pop	dx	;@0AD88
	pop	cx	;@0AD89
	pop	bx	;@0AD8A
	pop	ax	;@0AD8B
	ret	;@0AD8C
@@98:	push	ds	;@0AD8D
	push	si	;@0AD8E
	push	di	;@0AD8F
	push	cs	;@0AD90
	pop	ds	;@0AD91
	db	0E8h, 0DAh, 0	; call @@113	;@0AD92
	mov	di, 0F28h	;@0AD95
@@99:	call	di	;@0AD98
	cmp	byte ptr cs:L0A471+78, 0FEh	;@0AD9A
	jne	@@100	;@0ADA0
	mov	ax, 1	;@0ADA2
	db	0E9h, 0C3h, 0	; jmp @@112	;@0ADA5
@@100:	cmp	byte ptr cs:L0A471+78, 0FFh	;@0ADA8
	jne	@@101	;@0ADAE
	xor	ax, ax	;@0ADB0
	db	0E9h, 0B6h, 0	; jmp @@112	;@0ADB2
@@101:	mov	si, 52Ah	;@0ADB5
	db	0E8h, 40h, 1	; call @@118	;@0ADB8
	cmp	byte ptr cs:L0A471+89, 0	;@0ADBB
	jne	@@102	;@0ADC1
	xor	ax, ax	;@0ADC3
	db	0E9h, 0A3h, 0	; jmp @@112	;@0ADC5
@@102:	cmp	byte ptr cs:L0A471+78, 0FEh	;@0ADC8
	jne	@@103	;@0ADCE
	mov	ax, 1	;@0ADD0
	db	0E9h, 95h, 0	; jmp @@112	;@0ADD3
@@103:	mov	si, 7A2h	;@0ADD6
	db	0E8h, 0AAh, 5	; call @@208	;@0ADD9
	cmp	bx, 1	;@0ADDC
	db	75h, 22h	; jne @@106	;@0ADDF
	cmp	byte ptr [si+2], 0Ch	;@0ADE1
	db	75h, 9	; jne @@104	;@0ADE5
	mov	ax, 0FFFFh	;@0ADE7
	db	0EBh, 7Fh	; jmp @@112	;@0ADEA
	db	90h, 0EBh, 14h, 90h	;@0ADEC
@@104:	db	80h, 7Ch, 2, 0Dh	; cmp byte ptr [si+2], 0Dh	;@0ADF0
	db	75h, 0Ch	; jne @@105	;@0ADF4
	db	0E8h, 0B1h, 7	; call @@248	;@0ADF6
	mov	ax, 2	;@0ADF9
	db	0EBh, 6Dh	; jmp @@112	;@0ADFC
	db	90h, 0EBh, 2, 90h	;@0ADFE
@@105:	db	90h	; nop	;@0AE02
@@106:	cmp	bx, -1	;@0AE03
	jne	@@107	;@0AE06
	mov	ax, 1	;@0AE08
	jmp	@@112	;@0AE0B
@@107:	cmp	byte ptr cs:L0A471+78, 0FFh	;@0AE0E
	jne	@@109	;@0AE14
	mov	al, byte ptr cs:L0A471+89	;@0AE16
	cmp	al, 0	;@0AE1A
	jne	@@108	;@0AE1C
	xor	ax, ax	;@0AE1E
	jmp	@@112	;@0AE20
@@108:	push	ax	;@0AE23
	mov	ax, 52Ah	;@0AE24
	push	ds	;@0AE27
	push	ax	;@0AE28
	sub	sp, 4	;@0AE29
	push	bp	;@0AE2C
	mov	bp, sp	;@0AE2D
	mov	word ptr [bp+4], 4	;@0AE2F
	mov	word ptr [bp+2], 5	;@0AE34
	pop	bp	;@0AE39
	call	far ptr L048E0	;@0AE3A
	add	sp, 8	;@0AE3F
	pop	ax	;@0AE42
	mov	ax, 1	;@0AE43
	jmp	@@112	;@0AE46
@@109:	mov	si, 5F3h	;@0AE49
	call	@@118	;@0AE4C
	cmp	byte ptr cs:L0A471+78, 0FEh	;@0AE4F
	jne	@@110	;@0AE55
	mov	ax, 1	;@0AE57
	jmp	@@112	;@0AE5A
@@110:	call	@@186	;@0AE5D
	jae	@@111	;@0AE60
	mov	ax, 1	;@0AE62
	jmp	@@112	;@0AE65
@@111:	jmp	@@99	;@0AE68
@@112:	pop	di	;@0AE6B
	pop	si	;@0AE6C
	pop	ds	;@0AE6D
	ret	;@0AE6E
@@113:	push	ds	;@0AE6F
	push	es	;@0AE70
	push	ax	;@0AE71
	push	bx	;@0AE72
	push	cx	;@0AE73
	mov	ah, 62h	;@0AE74
	int	21h	;@0AE76
	mov	es, bx	;@0AE78
	mov	word ptr cs:L0A471+72, bx	;@0AE7A
	mov	word ptr cs:L0A471+74, 81h	;@0AE7F
	xor	ch, ch	;@0AE86
	mov	cl, byte ptr es:[80h]	;@0AE88
	mov	word ptr cs:L0A471+76, cx	;@0AE8D
	pop	cx	;@0AE92
	pop	bx	;@0AE93
	pop	ax	;@0AE94
	pop	es	;@0AE95
	pop	ds	;@0AE96
	ret	;@0AE97
@@114:	push	es	;@0AE98
	push	si	;@0AE99
	les	si, dword ptr cs:L0A471+68	;@0AE9A
	cmp	word ptr es:[si+6Ah], 1FFFh	;@0AE9F
	jbe	@@115	;@0AEA5
	mov	word ptr es:[si+6Ah], 1FFFh	;@0AEA7
@@115:	cmp	word ptr es:[si+62h], 0	;@0AEAD
	jbe	@@116	;@0AEB2
	mov	byte ptr es:[si+33h], 1	;@0AEB4
@@116:	cmp	byte ptr es:[si+22h], 1	;@0AEB9
	jne	@@117	;@0AEBE
	mov	byte ptr es:[si+4], 4	;@0AEC0
@@117:	pop	si	;@0AEC5
	pop	es	;@0AEC6
	ret	;@0AEC7
	db	6, 'PS.', 83h, 3Eh, 1Dh, 5, 0, 75h, 9, 2Eh, 0C6h, 6, 1Fh, 5, 0FFh	;@0AEC8
	db	0EBh, 1Ch, 90h, 2Eh, 0FFh, 0Eh, 1Dh, 5, 2Eh, 8Eh, 6, 19h, 5, 2Eh
	db	8Bh, 1Eh, 1Bh, 5, 26h, 8Ah, 7, 2Eh, 0A2h, 1Fh, 5, 2Eh, 0FFh, 6
	db	1Bh, 5, 5Bh, 58h, 7, 0C3h
@@118:	push	ax	;@0AEFB
	push	bx	;@0AEFC
	push	cx	;@0AEFD
	push	dx	;@0AEFE
	push	si	;@0AEFF
	mov	cx, 0C8h	;@0AF00
@@119:	cmp	byte ptr cs:L0A471+78, 20h	;@0AF03
	ja	@@120	;@0AF09
	call	di	;@0AF0B
	jmp	@@119	;@0AF0D
@@120:	cmp	byte ptr cs:L0A471+78, 3Dh	;@0AF0F
	jne	@@121	;@0AF15
	call	di	;@0AF17
	jmp	@@119	;@0AF19
@@121:	cmp	byte ptr cs:L0A471+78, 2Dh	;@0AF1B
	jne	@@122	;@0AF21
	call	di	;@0AF23
	jmp	@@119	;@0AF25
@@122:	cmp	byte ptr cs:L0A471+78, 2Fh	;@0AF27
	jne	@@123	;@0AF2D
	call	di	;@0AF2F
	jmp	@@119	;@0AF31
@@123:	mov	al, byte ptr cs:L0A471+78	;@0AF33
	cmp	al, 0FEh	;@0AF37
	jae	@@128	;@0AF39
	cmp	al, 3Dh	;@0AF3B
	jne	@@124	;@0AF3D
	jmp	@@128	;@0AF3F
@@124:	cmp	al, 20h	;@0AF42
	ja	@@125	;@0AF44
	jmp	@@128	;@0AF46
@@125:	cmp	al, 61h	;@0AF49
	jb	@@126	;@0AF4B
	cmp	al, 7Ah	;@0AF4D
	ja	@@126	;@0AF4F
	sub	al, 20h	;@0AF51
@@126:	mov	byte ptr [si], al	;@0AF53
	inc	si	;@0AF55
	dec	cx	;@0AF56
	cmp	cx, 0	;@0AF57
	jne	@@127	;@0AF5A
	mov	byte ptr cs:L0A471+78, 0FEh	;@0AF5C
	jmp	@@128	;@0AF62
@@127:	call	di	;@0AF65
	jmp	@@123	;@0AF67
@@128:	mov	byte ptr [si], 0	;@0AF69
	pop	si	;@0AF6C
	pop	dx	;@0AF6D
	pop	cx	;@0AF6E
	pop	bx	;@0AF6F
	pop	ax	;@0AF70
	ret	;@0AF71
@@129:	push	si	;@0AF72
	push	ax	;@0AF73
@@130:	mov	al, byte ptr [si]	;@0AF74
	inc	si	;@0AF76
	mov	ah, al	;@0AF77
	mov	al, byte ptr [di]	;@0AF79
	inc	di	;@0AF7B
	cmp	ah, al	;@0AF7C
	jne	@@131	;@0AF7E
	cmp	al, 0	;@0AF80
	jne	@@130	;@0AF82
@@131:	pop	ax	;@0AF84
	pop	si	;@0AF85
	ret	;@0AF86
@@132:	push	si	;@0AF87
	push	ax	;@0AF88
	push	dx	;@0AF89
	push	cx	;@0AF8A
	mov	si, 5F3h	;@0AF8B
	xor	bx, bx	;@0AF8E
	xor	dx, dx	;@0AF90
	mov	cx, 0Ah	;@0AF92
	cld	;@0AF95
@@133:	lodsb	;@0AF96
	cmp	al, 0	;@0AF97
	jne	@@135	;@0AF99
	clc	;@0AF9B
	cmp	dx, 0	;@0AF9C
	je	@@134	;@0AF9F
	push	ax	;@0AFA1
	mov	ax, 52Ah	;@0AFA2
	push	ds	;@0AFA5
	push	ax	;@0AFA6
	sub	sp, 4	;@0AFA7
	push	bp	;@0AFAA
	mov	bp, sp	;@0AFAB
	mov	word ptr [bp+4], 4	;@0AFAD
	mov	word ptr [bp+2], 7	;@0AFB2
	pop	bp	;@0AFB7
	call	far ptr L048E0	;@0AFB8
	add	sp, 8	;@0AFBD
	pop	ax	;@0AFC0
	stc	;@0AFC1
@@134:	jmp	@@137	;@0AFC2
@@135:	sub	al, 30h	;@0AFC5
	xor	ah, ah	;@0AFC7
	cmp	al, 9	;@0AFC9
	jbe	@@136	;@0AFCB
	push	ax	;@0AFCD
	mov	ax, 52Ah	;@0AFCE
	push	ds	;@0AFD1
	push	ax	;@0AFD2
	sub	sp, 4	;@0AFD3
	push	bp	;@0AFD6
	mov	bp, sp	;@0AFD7
	mov	word ptr [bp+4], 4	;@0AFD9
	mov	word ptr [bp+2], 0Bh	;@0AFDE
	pop	bp	;@0AFE3
	call	far ptr L048E0	;@0AFE4
	add	sp, 8	;@0AFE9
	pop	ax	;@0AFEC
	stc	;@0AFED
	jmp	@@137	;@0AFEE
@@136:	xchg	ax, bx	;@0AFF1
	mul	cx	;@0AFF2
	add	ax, bx	;@0AFF4
	adc	dx, 0	;@0AFF6
	xchg	ax, bx	;@0AFF9
	jmp	@@133	;@0AFFA
@@137:	pop	cx	;@0AFFC
	pop	dx	;@0AFFD
	pop	ax	;@0AFFE
	pop	si	;@0AFFF
	ret	;@0B000
@@138:	push	si	;@0B001
	push	ax	;@0B002
	push	dx	;@0B003
	push	cx	;@0B004
	mov	si, 5F3h	;@0B005
	mov	cx, 10h	;@0B008
	xor	bx, bx	;@0B00B
	xor	dx, dx	;@0B00D
	cld	;@0B00F
@@139:	lodsb	;@0B010
	cmp	al, 0	;@0B011
	jne	@@141	;@0B013
	clc	;@0B015
	cmp	dx, 0	;@0B016
	je	@@140	;@0B019
	push	ax	;@0B01B
	mov	ax, 52Ah	;@0B01C
	push	ds	;@0B01F
	push	ax	;@0B020
	sub	sp, 4	;@0B021
	push	bp	;@0B024
	mov	bp, sp	;@0B025
	mov	word ptr [bp+4], 4	;@0B027
	mov	word ptr [bp+2], 6	;@0B02C
	pop	bp	;@0B031
	call	far ptr L048E0	;@0B032
	add	sp, 8	;@0B037
	pop	ax	;@0B03A
	stc	;@0B03B
@@140:	jmp	@@145	;@0B03C
@@141:	cmp	al, 41h	;@0B03F
	jb	@@142	;@0B041
	sub	al, 37h	;@0B043
	jmp	@@143	;@0B045
@@142:	cmp	al, 39h	;@0B048
	ja	@@143	;@0B04A
	sub	al, 30h	;@0B04C
@@143:	xor	ah, ah	;@0B04E
	cmp	al, 0Fh	;@0B050
	jbe	@@144	;@0B052
	push	ax	;@0B054
	mov	ax, 52Ah	;@0B055
	push	ds	;@0B058
	push	ax	;@0B059
	sub	sp, 4	;@0B05A
	push	bp	;@0B05D
	mov	bp, sp	;@0B05E
	mov	word ptr [bp+4], 4	;@0B060
	mov	word ptr [bp+2], 0Bh	;@0B065
	pop	bp	;@0B06A
	call	far ptr L048E0	;@0B06B
	add	sp, 8	;@0B070
	pop	ax	;@0B073
	stc	;@0B074
	jmp	@@145	;@0B075
@@144:	xchg	ax, bx	;@0B078
	mul	cx	;@0B079
	add	ax, bx	;@0B07B
	adc	dx, 0	;@0B07D
	xchg	ax, bx	;@0B080
	jmp	@@139	;@0B081
@@145:	pop	cx	;@0B083
	pop	dx	;@0B084
	pop	ax	;@0B085
	pop	si	;@0B086
	ret	;@0B087
@@146:	push	si	;@0B088
	push	di	;@0B089
	push	cx	;@0B08A
	push	ax	;@0B08B
	push	bx	;@0B08C
	mov	si, 5F3h	;@0B08D
	mov	cx, 10h	;@0B090
	shl	cx, 1	;@0B093
	add	di, 2	;@0B095
	cld	;@0B098
@@147:	lodsb	;@0B099
	cmp	al, 0	;@0B09A
	jne	@@148	;@0B09C
	jcxz	@@153	;@0B09E
	jmp	@@154	;@0B0A0
@@148:	cmp	al, 41h	;@0B0A3
	jb	@@149	;@0B0A5
	sub	al, 37h	;@0B0A7
	jmp	@@150	;@0B0A9
@@149:	cmp	al, 39h	;@0B0AC
	ja	@@150	;@0B0AE
	sub	al, 30h	;@0B0B0
@@150:	xor	ah, ah	;@0B0B2
	cmp	al, 0Fh	;@0B0B4
	jbe	@@151	;@0B0B6
	mov	ax, 52Ah	;@0B0B8
	push	ds	;@0B0BB
	push	ax	;@0B0BC
	sub	sp, 4	;@0B0BD
	push	bp	;@0B0C0
	mov	bp, sp	;@0B0C1
	mov	word ptr [bp+4], 4	;@0B0C3
	mov	word ptr [bp+2], 0Bh	;@0B0C8
	pop	bp	;@0B0CD
	call	far ptr L048E0	;@0B0CE
	add	sp, 8	;@0B0D3
	jmp	@@154	;@0B0D6
@@151:	shl	bx, 4	;@0B0D9
	add	bl, al	;@0B0DC
	test	cx, 1	;@0B0DE
	je	@@152	;@0B0E2
	mov	al, bl	;@0B0E4
	cld	;@0B0E6
	stosb	;@0B0E7
@@152:	dec	cx	;@0B0E8
	jmp	@@147	;@0B0E9
@@153:	clc	;@0B0EB
	jmp	short @@155	;@0B0EC
@@154:	stc	;@0B0EE
@@155:	pop	bx	;@0B0EF
	pop	ax	;@0B0F0
	pop	cx	;@0B0F1
	pop	di	;@0B0F2
	pop	si	;@0B0F3
	ret	;@0B0F4
@@156:	push	si	;@0B0F5
	push	di	;@0B0F6
	mov	si, 5F3h	;@0B0F7
	mov	bx, 1	;@0B0FA
	push	di	;@0B0FD
	mov	di, 1163h	;@0B0FE
	jmp	short @@157	;@0B101
	db	'YES', 0	;@0B103
@@157:	call	@@129	;@0B107
	pop	di	;@0B10A
	jne	@@158	;@0B10B
	jmp	@@177	;@0B10D
@@158:	push	di	;@0B110
	mov	di, 1176h	;@0B111
	jmp	short @@159	;@0B114
	db	'TRUE', 0	;@0B116
@@159:	call	@@129	;@0B11B
	pop	di	;@0B11E
	jne	@@160	;@0B11F
	jmp	@@177	;@0B121
@@160:	push	di	;@0B124
	mov	di, 118Ah	;@0B125
	jmp	short @@161	;@0B128
	db	4Fh, 4Eh, 0	;@0B12A
@@161:	call	@@129	;@0B12D
	pop	di	;@0B130
	jne	@@162	;@0B131
	jmp	@@177	;@0B133
@@162:	push	di	;@0B136
	mov	di, 119Ch	;@0B137
	jmp	short @@163	;@0B13A
	db	31h, 0	;@0B13C
@@163:	call	@@129	;@0B13E
	pop	di	;@0B141
	jne	@@164	;@0B142
	jmp	@@177	;@0B144
@@164:	push	di	;@0B147
	mov	di, 11ADh	;@0B148
	jmp	short @@165	;@0B14B
	db	59h, 0	;@0B14D
@@165:	call	@@129	;@0B14F
	pop	di	;@0B152
	jne	@@166	;@0B153
	jmp	@@177	;@0B155
@@166:	mov	bx, 0	;@0B158
	push	di	;@0B15B
	mov	di, 11C1h	;@0B15C
	jmp	short @@167	;@0B15F
	db	4Eh, 4Fh, 0	;@0B161
@@167:	call	@@129	;@0B164
	pop	di	;@0B167
	jne	@@168	;@0B168
	jmp	@@177	;@0B16A
@@168:	push	di	;@0B16D
	mov	di, 11D3h	;@0B16E
	jmp	short @@169	;@0B171
	db	'FALSE', 0	;@0B173
@@169:	call	@@129	;@0B179
	pop	di	;@0B17C
	jne	@@170	;@0B17D
	jmp	@@177	;@0B17F
@@170:	push	di	;@0B182
	mov	di, 11E8h	;@0B183
	jmp	short @@171	;@0B186
	db	'OFF', 0	;@0B188
@@171:	call	@@129	;@0B18C
	pop	di	;@0B18F
	jne	@@172	;@0B190
	jmp	@@177	;@0B192
@@172:	push	di	;@0B195
	mov	di, 11FBh	;@0B196
	jmp	short @@173	;@0B199
	db	30h, 0	;@0B19B
@@173:	call	@@129	;@0B19D
	pop	di	;@0B1A0
	jne	@@174	;@0B1A1
	jmp	@@177	;@0B1A3
@@174:	push	di	;@0B1A6
	mov	di, 120Ch	;@0B1A7
	jmp	short @@175	;@0B1AA
	db	4Eh, 0	;@0B1AC
@@175:	call	@@129	;@0B1AE
	pop	di	;@0B1B1
	jne	@@176	;@0B1B2
	jmp	@@177	;@0B1B4
@@176:	push	ax	;@0B1B7
	mov	ax, 52Ah	;@0B1B8
	push	ds	;@0B1BB
	push	ax	;@0B1BC
	sub	sp, 4	;@0B1BD
	push	bp	;@0B1C0
	mov	bp, sp	;@0B1C1
	mov	word ptr [bp+4], 4	;@0B1C3
	mov	word ptr [bp+2], 9	;@0B1C8
	pop	bp	;@0B1CD
	call	far ptr L048E0	;@0B1CE
	add	sp, 8	;@0B1D3
	pop	ax	;@0B1D6
	stc	;@0B1D7
	jmp	@@178	;@0B1D8
@@177:	clc	;@0B1DB
@@178:	pop	di	;@0B1DC
	pop	si	;@0B1DD
	ret	;@0B1DE
@@179:	push	si	;@0B1DF
	push	es	;@0B1E0
	push	di	;@0B1E1
	mov	si, word ptr [si]	;@0B1E2
	mov	ax, cs	;@0B1E4
	mov	es, ax	;@0B1E6
	mov	di, 52Ah	;@0B1E8
	cmpsb	;@0B1EB
	je	@@180	;@0B1EC
	mov	bx, 0	;@0B1EE
	jmp	@@185	;@0B1F1
@@180:	cmp	byte ptr es:[di], 0	;@0B1F4
	je	@@182	;@0B1F8
	cmp	byte ptr [si], 0	;@0B1FA
	je	@@182	;@0B1FD
	cmpsb	;@0B1FF
	je	@@181	;@0B200
	mov	bx, 0	;@0B202
	jmp	@@185	;@0B205
@@181:	jmp	@@180	;@0B208
@@182:	mov	bx, 0	;@0B20A
	mov	bl, byte ptr es:[di]	;@0B20D
	or	bl, byte ptr [si]	;@0B210
	jne	@@183	;@0B212
	mov	bx, 1	;@0B214
	jmp	@@185	;@0B217
@@183:	mov	bl, byte ptr es:[di]	;@0B21A
	cmp	bl, 0	;@0B21D
	jne	@@184	;@0B220
	mov	bx, 2	;@0B222
	jmp	@@185	;@0B225
@@184:	mov	bx, 0	;@0B228
@@185:	pop	di	;@0B22B
	pop	es	;@0B22C
	pop	si	;@0B22D
	ret	;@0B22E
@@186:	push	ax	;@0B22F
	push	bx	;@0B230
	push	cx	;@0B231
	push	dx	;@0B232
	push	es	;@0B233
	push	ds	;@0B234
	push	si	;@0B235
	push	di	;@0B236
	push	cs	;@0B237
	pop	ds	;@0B238
	mov	si, 7A2h	;@0B239
	call	@@208	;@0B23C
	cmp	bx, 1	;@0B23F
	je	@@187	;@0B242
	jmp	@@204	;@0B244
@@187:	mov	es, word ptr cs:L0A471+70	;@0B247
	mov	di, word ptr cs:L0A471+68	;@0B24C
	cmp	byte ptr [si+2], 1	;@0B251
	jne	@@189	;@0B255
	add	di, word ptr [si+3]	;@0B257
	call	@@156	;@0B25A
	jae	@@188	;@0B25D
	jmp	@@205	;@0B25F
@@188:	mov	byte ptr es:[di], bl	;@0B262
	jmp	@@206	;@0B265
@@189:	cmp	byte ptr [si+2], 2	;@0B268
	jne	@@191	;@0B26C
	add	di, word ptr [si+3]	;@0B26E
	call	@@138	;@0B271
	jae	@@190	;@0B274
	jmp	@@205	;@0B276
@@190:	mov	word ptr es:[di], bx	;@0B279
	jmp	@@206	;@0B27C
@@191:	cmp	byte ptr [si+2], 4	;@0B27F
	jne	@@193	;@0B283
	add	di, word ptr [si+3]	;@0B285
	call	@@138	;@0B288
	jae	@@192	;@0B28B
	jmp	@@205	;@0B28D
@@192:	push	cx	;@0B290
	shl	bx, 1	;@0B291
	shl	bx, 1	;@0B293
	shl	bx, 1	;@0B295
	shl	bx, 1	;@0B297
	pop	cx	;@0B299
	mov	word ptr es:[di], bx	;@0B29A
	jmp	@@206	;@0B29D
@@193:	cmp	byte ptr [si+2], 7	;@0B2A0
	jne	@@195	;@0B2A4
	call	@@146	;@0B2A6
	jae	@@194	;@0B2A9
	jmp	@@205	;@0B2AB
@@194:	jmp	@@206	;@0B2AE
@@195:	cmp	byte ptr [si+2], 3	;@0B2B1
	jne	@@197	;@0B2B5
	add	di, word ptr [si+3]	;@0B2B7
	call	@@132	;@0B2BA
	jae	@@196	;@0B2BD
	jmp	@@205	;@0B2BF
@@196:	mov	word ptr es:[di], bx	;@0B2C2
	jmp	@@206	;@0B2C5
@@197:	cmp	byte ptr [si+2], 6	;@0B2C8
	jne	@@199	;@0B2CC
	add	di, word ptr [si+3]	;@0B2CE
	call	@@132	;@0B2D1
	jae	@@198	;@0B2D4
	jmp	@@205	;@0B2D6
@@198:	mov	cl, 0Ah	;@0B2D9
	mov	ax, bx	;@0B2DB
	shl	bx, cl	;@0B2DD
	mov	cl, 6	;@0B2DF
	shr	ax, cl	;@0B2E1
	mov	word ptr es:[di], bx	;@0B2E3
	mov	word ptr es:[di+2], ax	;@0B2E6
	jmp	@@206	;@0B2EA
@@199:	cmp	byte ptr [si+2], 5	;@0B2ED
	jne	@@201	;@0B2F1
	add	di, word ptr [si+3]	;@0B2F3
	call	@@132	;@0B2F6
	jae	@@200	;@0B2F9
	jmp	@@205	;@0B2FB
@@200:	mov	ax, bx	;@0B2FE
	xor	bx, bx	;@0B300
	shl	ax, 1	;@0B302
	shl	ax, 1	;@0B304
	shl	ax, 1	;@0B306
	shl	ax, 1	;@0B308
	mov	word ptr es:[di], bx	;@0B30A
	mov	word ptr es:[di+2], ax	;@0B30D
	jmp	@@206	;@0B311
@@201:	cmp	byte ptr [si+2], 0Ah	;@0B314
	jne	@@203	;@0B318
	db	0E8h, 8, 1	; call @@220	;@0B31A
	jae	@@202	;@0B31D
	jmp	@@205	;@0B31F
@@202:	jmp	@@206	;@0B322
@@203:	cmp	byte ptr [si+2], 0Bh	;@0B325
	jne	@@204	;@0B329
	mov	si, word ptr [si]	;@0B32B
	push	ds	;@0B32D
	push	si	;@0B32E
	sub	sp, 4	;@0B32F
	push	bp	;@0B332
	mov	bp, sp	;@0B333
	mov	word ptr [bp+4], 4	;@0B335
	mov	word ptr [bp+2], 3	;@0B33A
	pop	bp	;@0B33F
	call	far ptr L048E0	;@0B340
	add	sp, 8	;@0B345
	jmp	@@206	;@0B348
@@204:	mov	si, 52Ah	;@0B34B
	push	ds	;@0B34E
	push	si	;@0B34F
	sub	sp, 4	;@0B350
	push	bp	;@0B353
	mov	bp, sp	;@0B354
	mov	word ptr [bp+4], 4	;@0B356
	mov	word ptr [bp+2], 0Ah	;@0B35B
	pop	bp	;@0B360
	call	far ptr L048E0	;@0B361
	add	sp, 8	;@0B366
	stc	;@0B369
	jmp	short @@207	;@0B36A
@@205:	jmp	short @@207	;@0B36C
@@206:	clc	;@0B36E
@@207:	pop	di	;@0B36F
	pop	si	;@0B370
	pop	ds	;@0B371
	pop	es	;@0B372
	pop	dx	;@0B373
	pop	cx	;@0B374
	pop	bx	;@0B375
	pop	ax	;@0B376
	ret	;@0B377
	db	'        $', 0Dh, 0Ah, 24h, 0Bh, 24h	;@0B378
@@208:	call	@@179	;@0B386
	cmp	bx, 1	;@0B389
	jne	@@209	;@0B38C
	db	0EBh, 38h	; jmp @@214	;@0B38E
	db	90h	;@0B390
@@209:	cmp	bx, 2	;@0B391
	db	75h, 1Fh	; jne @@211	;@0B394
	add	si, 6	;@0B396
	call	@@179	;@0B399
	cmp	bx, 0	;@0B39C
	db	74h, 0Eh	; je @@210	;@0B39F
	sub	si, 6	;@0B3A1
	push	si	;@0B3A4
	db	0E8h, 24h, 0	; call @@215	;@0B3A5
	pop	si	;@0B3A8
	db	0EBh, 15h	; jmp @@212	;@0B3A9
	db	90h, 0EBh, 7, 90h	;@0B3AB
@@210:	db	83h, 0EEh, 6	; sub si, 6	;@0B3AF
	jmp	@@214	;@0B3B2
@@211:	cmp	si, 844h	;@0B3B5
	jge	@@213	;@0B3B9
	add	si, 6	;@0B3BB
	jmp	@@208	;@0B3BE
@@212:	mov	bx, 0FFFFh	;@0B3C0
	ret	;@0B3C3
@@213:	mov	bx, 0	;@0B3C4
	ret	;@0B3C7
@@214:	mov	bx, 1	;@0B3C8
	ret	;@0B3CB
@@215:	push	dx	;@0B3CC
	push	ax	;@0B3CD
	sub	sp, 4	;@0B3CE
	push	bp	;@0B3D1
	mov	bp, sp	;@0B3D2
	mov	word ptr [bp+4], 0	;@0B3D4
	mov	word ptr [bp+2], 0Dh	;@0B3D9
	pop	bp	;@0B3DE
	call	far ptr L048E0	;@0B3DF
	add	sp, 4	;@0B3E4
	call	@@179	;@0B3E7
@@216:	cmp	bx, 0	;@0B3EA
	je	@@219	;@0B3ED
	push	ds	;@0B3EF
	push	cs	;@0B3F0
	pop	ds	;@0B3F1
	mov	dx, 13D8h	;@0B3F2
	mov	ah, 9	;@0B3F5
	int	21h	;@0B3F7
	pop	ds	;@0B3F9
	mov	dx, word ptr [si]	;@0B3FA
	mov	di, dx	;@0B3FC
@@217:	cmp	byte ptr [di], 0	;@0B3FE
	je	@@218	;@0B401
	add	di, 1	;@0B403
	jmp	@@217	;@0B406
@@218:	mov	byte ptr [di], 24h	;@0B408
	mov	ah, 9	;@0B40B
	int	21h	;@0B40D
	push	ds	;@0B40F
	push	cs	;@0B410
	pop	ds	;@0B411
	mov	dx, 13E1h	;@0B412
	mov	ah, 9	;@0B415
	int	21h	;@0B417
	pop	ds	;@0B419
	add	si, 6	;@0B41A
	call	@@179	;@0B41D
	jmp	@@216	;@0B420
@@219:	pop	ax	;@0B422
	pop	dx	;@0B423
	ret	;@0B424
@@220:	push	ax	;@0B425
	push	bx	;@0B426
	push	cx	;@0B427
	push	dx	;@0B428
	xor	al, al	;@0B429
	mov	dx, 5F3h	;@0B42B
	mov	ah, 3Dh	;@0B42E
	int	21h	;@0B430
	jae	@@221	;@0B432
	push	ds	;@0B434
	push	dx	;@0B435
	sub	sp, 4	;@0B436
	push	bp	;@0B439
	mov	bp, sp	;@0B43A
	mov	word ptr [bp+4], 4	;@0B43C
	mov	word ptr [bp+2], 8	;@0B441
	pop	bp	;@0B446
	call	far ptr L048E0	;@0B447
	add	sp, 8	;@0B44C
	jmp	@@222	;@0B44F
@@221:	mov	cl, byte ptr cs:L0A471+78	;@0B452
	push	cx	;@0B457
	call	@@87	;@0B458
	pop	cx	;@0B45B
	pushf	;@0B45C
	mov	bx, ax	;@0B45D
	mov	ah, 3Eh	;@0B45F
	int	21h	;@0B461
	mov	byte ptr cs:L0A471+78, cl	;@0B463
	popf	;@0B468
@@222:	pop	dx	;@0B469
	pop	cx	;@0B46A
	pop	bx	;@0B46B
	pop	ax	;@0B46C
	ret	;@0B46D
@@223:	push	si	;@0B46E
	push	ax	;@0B46F
	push	cx	;@0B470
	mov	al, byte ptr [si]	;@0B471
	dec	di	;@0B473
@@224:	inc	di	;@0B474
	cmp	al, byte ptr es:[di]	;@0B475
	loopne	@@224	;@0B478
	jcxz	@@228	;@0B47A
	push	cx	;@0B47C
	push	di	;@0B47D
	push	si	;@0B47E
@@225:	cmpsb	;@0B47F
	jne	@@226	;@0B480
	cmp	byte ptr [si], 0	;@0B482
	jne	@@225	;@0B485
	pop	si	;@0B487
	pop	di	;@0B488
	pop	cx	;@0B489
	clc	;@0B48A
	jmp	@@227	;@0B48B
@@226:	pop	si	;@0B48E
	pop	di	;@0B48F
	pop	cx	;@0B490
	jmp	@@224	;@0B491
@@227:	pop	cx	;@0B493
	pop	ax	;@0B494
	pop	si	;@0B495
	ret	;@0B496
@@228:	stc	;@0B497
	jmp	@@227	;@0B498
	db	'Vcache', 0	;@0B49A
@@229:	push	ds	;@0B4A1
	push	es	;@0B4A2
	push	si	;@0B4A3
	push	di	;@0B4A4
	push	ax	;@0B4A5
	push	cx	;@0B4A6
	xor	ax, ax	;@0B4A7
	mov	ds, ax	;@0B4A9
	mov	es, word ptr ds:[102h]	;@0B4AB
	xor	di, di	;@0B4AF
	mov	ax, cs	;@0B4B1
	mov	ds, ax	;@0B4B3
	mov	si, 14FAh	;@0B4B5
	mov	cx, 100h	;@0B4B8
	call	@@223	;@0B4BB
	jb	@@231	;@0B4BE
	mov	ax, 0FFFFh	;@0B4C0
	clc	;@0B4C3
@@230:	pop	cx	;@0B4C4
	pop	ax	;@0B4C5
	pop	di	;@0B4C6
	pop	si	;@0B4C7
	pop	es	;@0B4C8
	pop	ds	;@0B4C9
	ret	;@0B4CA
@@231:	stc	;@0B4CB
	jmp	@@230	;@0B4CC
@@232:	push	ax	;@0B4CE
	push	bx	;@0B4CF
	push	cx	;@0B4D0
	push	dx	;@0B4D1
	push	ds	;@0B4D2
	mov	al, ch	;@0B4D3
	shr	al, 1	;@0B4D5
	shr	al, 1	;@0B4D7
	shr	al, 1	;@0B4D9
	shr	al, 1	;@0B4DB
	call	@@233	;@0B4DD
	mov	al, ch	;@0B4E0
	call	@@233	;@0B4E2
	mov	al, cl	;@0B4E5
	shr	al, 1	;@0B4E7
	shr	al, 1	;@0B4E9
	shr	al, 1	;@0B4EB
	shr	al, 1	;@0B4ED
	call	@@233	;@0B4EF
	mov	al, cl	;@0B4F2
	call	@@233	;@0B4F4
	mov	al, 20h	;@0B4F7
	call	@@236	;@0B4F9
	pop	ds	;@0B4FC
	pop	dx	;@0B4FD
	pop	cx	;@0B4FE
	pop	bx	;@0B4FF
	pop	ax	;@0B500
	ret	;@0B501
@@233:	push	cx	;@0B502
	push	ax	;@0B503
	and	al, 0Fh	;@0B504
	cmp	al, 9	;@0B506
	jg	@@234	;@0B508
	add	al, 30h	;@0B50A
	jmp	@@235	;@0B50C
@@234:	sub	al, 0Ah	;@0B50F
	add	al, 41h	;@0B511
@@235:	call	@@236	;@0B513
	pop	ax	;@0B516
	pop	cx	;@0B517
	ret	;@0B518
@@236:	push	ax	;@0B519
	push	bx	;@0B51A
	push	cx	;@0B51B
	push	dx	;@0B51C
	push	ds	;@0B51D
	mov	dl, al	;@0B51E
	mov	ah, 2	;@0B520
	int	21h	;@0B522
	pop	ds	;@0B524
	pop	dx	;@0B525
	pop	cx	;@0B526
	pop	bx	;@0B527
	pop	ax	;@0B528
	ret	;@0B529
@@237:	push	ax	;@0B52A
	push	bx	;@0B52B
	push	cx	;@0B52C
	push	dx	;@0B52D
	push	ds	;@0B52E
	mov	ax, cx	;@0B52F
	mov	cx, 0FFFFh	;@0B531
	push	cx	;@0B534
	mov	cx, 0Ah	;@0B535
@@238:	cmp	ax, cx	;@0B538
	jae	@@239	;@0B53A
	add	ax, 30h	;@0B53C
	push	ax	;@0B53F
	mov	ah, 2	;@0B540
	jmp	@@240	;@0B542
@@239:	xor	dx, dx	;@0B545
	div	cx	;@0B547
	add	dx, 30h	;@0B549
	push	dx	;@0B54C
	jmp	@@238	;@0B54D
@@240:	pop	dx	;@0B54F
	cmp	dx, -1	;@0B550
	jne	@@241	;@0B553
	jmp	@@242	;@0B555
@@241:	int	21h	;@0B558
	jmp	@@240	;@0B55A
@@242:	pop	ds	;@0B55C
	pop	dx	;@0B55D
	pop	cx	;@0B55E
	pop	bx	;@0B55F
	pop	ax	;@0B560
	ret	;@0B561
	db	'YES$NO$'	;@0B562
@@243:	cmp	cl, 0	;@0B569
	jne	@@244	;@0B56C
	push	ds	;@0B56E
	push	cs	;@0B56F
	pop	ds	;@0B570
	mov	dx, 15C6h	;@0B571
	mov	ah, 9	;@0B574
	int	21h	;@0B576
	pop	ds	;@0B578
	jmp	@@245	;@0B579
@@244:	push	ds	;@0B57C
	push	cs	;@0B57D
	pop	ds	;@0B57E
	mov	dx, 15C2h	;@0B57F
	mov	ah, 9	;@0B582
	int	21h	;@0B584
	pop	ds	;@0B586
@@245:	ret	;@0B587
@@246:	push	di	;@0B588
	push	ax	;@0B589
	push	bx	;@0B58A
	push	cx	;@0B58B
	add	di, 2	;@0B58C
	mov	cx, 10h	;@0B58F
@@247:	mov	bx, word ptr es:[di]	;@0B592
	inc	di	;@0B595
	mov	al, bl	;@0B596
	shr	al, 4	;@0B598
	call	@@233	;@0B59B
	mov	al, bl	;@0B59E
	call	@@233	;@0B5A0
	loop	@@247	;@0B5A3
	pop	cx	;@0B5A5
	pop	bx	;@0B5A6
	pop	ax	;@0B5A7
	pop	di	;@0B5A8
	ret	;@0B5A9
@@248:	db	0EBh, 26h	; jmp @@249	;@0B5AA
	db	90h, 'The current settings are as follows:$'	;@0B5AC
@@249:	db	1Eh	; push ds	;@0B5D2
	push	dx	;@0B5D3
	push	ax	;@0B5D4
	mov	dx, 160Dh	;@0B5D5
	push	cs	;@0B5D8
	pop	ds	;@0B5D9
	mov	ah, 9	;@0B5DA
	int	21h	;@0B5DC
	pop	ax	;@0B5DE
	pop	dx	;@0B5DF
	pop	ds	;@0B5E0
	mov	es, word ptr cs:L0A471+70	;@0B5E1
	push	cs	;@0B5E6
	pop	ds	;@0B5E7
	mov	si, 7A2h	;@0B5E8
@@250:	push	ds	;@0B5EB
	push	cs	;@0B5EC
	pop	ds	;@0B5ED
	mov	dx, 13E1h	;@0B5EE
	mov	ah, 9	;@0B5F1
	int	21h	;@0B5F3
	pop	ds	;@0B5F5
	mov	dx, 844h	;@0B5F6
	cmp	si, dx	;@0B5F9
	jl	@@251	;@0B5FB
	jmp	@@267	;@0B5FD
@@251:	cmp	byte ptr [si+2], 8	;@0B600
	jbe	@@254	;@0B604
@@252:	add	si, 6	;@0B606
	cmp	si, 844h	;@0B609
	jne	@@253	;@0B60D
	jmp	@@267	;@0B60F
@@253:	jmp	@@251	;@0B612
@@254:	cmp	byte ptr [si+5], 0	;@0B614
	jne	@@255	;@0B618
	jmp	@@252	;@0B61A
@@255:	push	ds	;@0B61C
	push	cs	;@0B61D
	pop	ds	;@0B61E
	mov	dx, 13D8h	;@0B61F
	mov	ah, 9	;@0B622
	int	21h	;@0B624
	pop	ds	;@0B626
	mov	di, word ptr [si]	;@0B627
	mov	dx, di	;@0B629
	mov	cx, 14h	;@0B62B
@@256:	cmp	byte ptr [di], 0	;@0B62E
	je	@@257	;@0B631
	dec	cx	;@0B633
	inc	di	;@0B634
	jmp	@@256	;@0B635
@@257:	mov	byte ptr [di], 24h	;@0B637
	mov	ah, 9	;@0B63A
	int	21h	;@0B63C
	mov	ah, 2	;@0B63E
	mov	dl, 20h	;@0B640
@@258:	int	21h	;@0B642
	loop	@@258	;@0B644
	mov	di, word ptr cs:L0A471+68	;@0B646
	add	di, word ptr [si+3]	;@0B64B
	mov	cx, word ptr es:[di]	;@0B64E
	mov	bl, byte ptr [si+2]	;@0B651
	mov	bh, 0	;@0B654
	cmp	bx, 2	;@0B656
	jne	@@259	;@0B659
	call	@@232	;@0B65B
	jmp	@@266	;@0B65E
@@259:	cmp	bx, 3	;@0B661
	jne	@@260	;@0B664
	call	@@237	;@0B666
	jmp	@@266	;@0B669
@@260:	cmp	bx, 4	;@0B66C
	jne	@@261	;@0B66F
	shr	cx, 1	;@0B671
	shr	cx, 1	;@0B673
	shr	cx, 1	;@0B675
	shr	cx, 1	;@0B677
	call	@@232	;@0B679
	jmp	@@266	;@0B67C
@@261:	cmp	bx, 5	;@0B67F
	jne	@@262	;@0B682
	mov	bx, word ptr es:[di]	;@0B684
	mov	ax, word ptr es:[di+2]	;@0B687
	mov	cx, ax	;@0B68B
	shr	cx, 1	;@0B68D
	shr	cx, 1	;@0B68F
	shr	cx, 1	;@0B691
	shr	cx, 1	;@0B693
	call	@@237	;@0B695
	jmp	@@266	;@0B698
@@262:	cmp	bx, 6	;@0B69B
	jne	@@263	;@0B69E
	mov	bx, word ptr es:[di]	;@0B6A0
	mov	ax, word ptr es:[di+2]	;@0B6A3
	mov	cl, 0Ah	;@0B6A7
	shr	bx, cl	;@0B6A9
	mov	cl, 6	;@0B6AB
	shl	ax, cl	;@0B6AD
	or	bx, ax	;@0B6AF
	mov	cx, bx	;@0B6B1
	call	@@237	;@0B6B3
	jmp	@@266	;@0B6B6
@@263:	cmp	bx, 7	;@0B6B9
	jne	@@264	;@0B6BC
	call	@@246	;@0B6BE
	jmp	@@266	;@0B6C1
@@264:	cmp	bx, 1	;@0B6C4
	jne	@@265	;@0B6C7
	call	@@243	;@0B6C9
	jmp	@@266	;@0B6CC
@@265:	cmp	bx, 8	;@0B6CF
	jne	@@266	;@0B6D2
	call	@@232	;@0B6D4
@@266:	add	si, 6	;@0B6D7
	jmp	@@250	;@0B6DA
@@267:	ret	;@0B6DD
	db	0, 0	;@0B6DE
@@268:	push	bx	;@0B6E0
	push	cx	;@0B6E1
	push	dx	;@0B6E2
	push	ds	;@0B6E3
	push	es	;@0B6E4
	push	cs	;@0B6E5
	pop	ds	;@0B6E6
	mov	dx, 1834h	;@0B6E7
	xor	al, al	;@0B6EA
	xor	bx, bx	;@0B6EC
	mov	ah, 3Dh	;@0B6EE
	int	21h	;@0B6F0
	jae	@@269	;@0B6F2
	mov	ah, 0FFh	;@0B6F4
	jmp	@@270	;@0B6F6
@@269:	mov	bx, ax	;@0B6F9
	mov	al, 0	;@0B6FB
	mov	ah, 44h	;@0B6FD
	int	21h	;@0B6FF
	jb	@@271	;@0B701
	test	dx, 80h	;@0B703
	je	@@271	;@0B707
	mov	ah, 3Eh	;@0B709
	int	21h	;@0B70B
	mov	al, 67h	;@0B70D
	mov	ah, 35h	;@0B70F
	int	21h	;@0B711
	mov	ax, es	;@0B713
	or	ax, bx	;@0B715
	je	@@271	;@0B717
	mov	ah, 43h	;@0B719
	mov	bx, 1	;@0B71B
	int	67h	;@0B71E
	mov	ax, 0DE00h	;@0B720
	int	67h	;@0B723
	push	ax	;@0B725
	mov	ah, 45h	;@0B726
	int	67h	;@0B728
	pop	ax	;@0B72A
@@270:	pop	es	;@0B72B
	pop	ds	;@0B72C
	pop	dx	;@0B72D
	pop	cx	;@0B72E
	pop	bx	;@0B72F
	ret	;@0B730
@@271:	mov	ah, 3Eh	;@0B731
	int	21h	;@0B733
	mov	ah, 0FFh	;@0B735
	db	0EBh, 0F2h	; jmp @@270	;@0B737
L0B739	db	16h dup (0)	;@0B739
S9FA	ends
	end
