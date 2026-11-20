	.286
	locals
CODE0	segment byte public 'CODE'
CODE0	ends
DATA	segment byte public 'DATA'
DATA	ends
BSS	segment byte public 'BSS'
BSS	ends
DGROUP	group	DATA,BSS
	public	L00000
	public	L0003E
	public	L00042
	public	L00046
	public	L0004A
	public	L0004E
	public	L00052
	public	L00056
	public	L0005A
	public	L0005E
	public	L00066
	public	L0006A
	public	L0006E
	public	L00072
	public	L00076
	public	L0007A
	public	L0007E
	public	L0F9B0
	public	L0F9E5
	public	L14551
	public	L1455E
	extrn	L003A8:near
	extrn	L004A1:near
	extrn	L004AE:near
	extrn	L004C7:near
	extrn	L00E05:near
	extrn	L00E38:near
	extrn	L00FC6:near
	extrn	L01282:near
	extrn	L0154B:near
	extrn	L0157F:near
	extrn	L01647:near
	extrn	L016B5:near
	extrn	L01873:near
	extrn	L018F9:near
	extrn	L05333:near
	extrn	L053C0:near
	extrn	L0EFDE:near
	extrn	L0F093:near
	extrn	L0F0D7:near
	extrn	L0F372:near
	extrn	L0F37A:near
	extrn	L0F399:near
	extrn	L0FAA6:far
	extrn	L1122D:far
	extrn	L11285:far
	extrn	L112D0:far
	extrn	L112E6:far
	extrn	L112EC:far
	extrn	L112F6:far
	extrn	L11304:far
	extrn	L1130A:far
	extrn	L11310:far
	extrn	L11321:far
	extrn	L12051:near
	extrn	DATA_START:byte
	extrn	L1B810:byte

CODE0	segment byte public 'CODE'
	assume	cs:CODE0
L00000:	call	far ptr L14BEF	;@00000
	ret	;@00005
L00006:	mov	word ptr ds:[38BAh], sp	;@00006
	call	far ptr L0F9CA	;@0000A
	clc	;@0000F
	retf	;@00010
L00011:	mov	word ptr ds:[38BAh], sp	;@00011
	call	L0EFDE	;@00015
	clc	;@00018
	retf	;@00019
L0001A:	mov	word ptr ds:[38BAh], sp	;@0001A
	call	L0F0D7	;@0001E
	clc	;@00021
	retf	;@00022
L00023:	mov	word ptr ds:[38BAh], sp	;@00023
	call	L0F372	;@00027
	clc	;@0002A
	retf	;@0002B
L0002C:	mov	word ptr ds:[38BAh], sp	;@0002C
	call	L0F37A	;@00030
	clc	;@00033
	retf	;@00034
L00035:	call	L0F093	;@00035
	retf	;@00038
L00039:	call	L0F399	;@00039
	retf	;@0003C
	db	0	;@0003D
L0003E:	call	L004A1	;@0003E
	retf	;@00041
L00042:	call	L004AE	;@00042
	retf	;@00045
L00046:	call	L004C7	;@00046
	retf	;@00049
L0004A:	call	L01282	;@0004A
	retf	;@0004D
L0004E:	call	L00FC6	;@0004E
	retf	;@00051
L00052:	call	L018F9	;@00052
	retf	;@00055
L00056:	call	L01647	;@00056
	retf	;@00059
L0005A:	call	L01873	;@0005A
	retf	;@0005D
L0005E:	call	L016B5	;@0005E
	retf	;@00061
	db	0E8h, 0A9h, 14h, 0CBh	;@00062
L00066:	call	L0154B	;@00066
	retf	;@00069
L0006A:	call	L0157F	;@0006A
	retf	;@0006D
L0006E:	call	L00E05	;@0006E
	retf	;@00071
L00072:	call	L00E38	;@00072
	retf	;@00075
L00076:	call	L003A8	;@00076
	retf	;@00079
L0007A:	call	L053C0	;@0007A
	retf	;@0007D
L0007E:	call	L05333	;@0007E
	retf	;@00081
CODE0	ends

C0F9B	segment byte public 'CODE'
	assume	cs:C0F9B
L0F9B0:	db	0E8h, 91h, 0FFh	; call L1B810+16692	;@0F9B0
	pop	dx	;@0F9B3
	ret	;@0F9B4
	db	0	;@0F9B5
L0F9B6:	mov	si, 13h	;@0F9B6
	mov	word ptr ds:[38BAh], sp	;@0F9B9
	push	cs	;@0F9BD
	call	L12051	;@0F9BE
	clc	;@0F9C1
	retf	;@0F9C2
	db	9Ah	;@0F9C3
	dd	L148D1
	db	0C3h, 0
L0F9CA:	mov	word ptr ds:[38E0h], ax	;@0F9CA
	mov	es, ax	;@0F9CD
	xor	ax, ax	;@0F9CF
	mov	word ptr es:[0], ax	;@0F9D1
	mov	word ptr es:[2], cx	;@0F9D5
	mov	word ptr ds:[38E2h], ax	;@0F9DA
	mov	word ptr ds:[38E4h], ax	;@0F9DD
	mov	word ptr ds:[38E6h], ax	;@0F9E0
	retf	;@0F9E3
L0F9E4:	retf	;@0F9E4
L0F9E5:	xor	ax, ax	;@0F9E5
	mov	cx, word ptr ds:[38E2h]	;@0F9E7
@@1:	jcxz	@@4	;@0F9EB
	mov	di, cx	;@0F9ED
	mov	es, word ptr ds:[38E4h]	;@0F9EF
@@2:	sub	di, word ptr es:[4]	;@0F9F3
	jb	@@3	;@0F9F8
	mov	es, word ptr es:[2]	;@0F9FA
	jmp	@@2	;@0F9FF
@@3:	add	di, word ptr es:[4]	;@0FA01
	shl	di, 1	;@0FA06
	shl	di, 1	;@0FA08
	add	ax, word ptr es:[di+2]	;@0FA0A
	mov	cx, word ptr es:[di]	;@0FA0E
	jmp	@@1	;@0FA11
@@4:	mov	cx, word ptr ds:[38E6h]	;@0FA13
	jcxz	@@5	;@0FA17
	mov	es, cx	;@0FA19
	mov	cx, word ptr es:[6]	;@0FA1B
	shl	cx, 1	;@0FA20
	shl	cx, 1	;@0FA22
	sub	cx, word ptr es:[4]	;@0FA24
	add	ax, cx	;@0FA29
@@5:	shr	ax, 1	;@0FA2B
	shr	ax, 1	;@0FA2D
	mov	cx, word ptr ds:[38E0h]	;@0FA2F
@@6:	jcxz	@@7	;@0FA33
	mov	es, cx	;@0FA35
	add	ax, word ptr es:[2]	;@0FA37
	mov	cx, word ptr es:[0]	;@0FA3C
	jmp	@@6	;@0FA41
@@7:	retf	;@0FA43
C0F9B	ends

C1455	segment byte public 'CODE'
	assume	cs:C1455
	db	0C3h	;@14550
L14551:	mov	es, word ptr ds:[5028h]	;@14551
	mov	di, word ptr ds:[502Ah]	;@14555
	stosb	;@14559
	add	di, 2	;@1455A
	ret	;@1455D
L1455E:	lodsb	;@1455E
	cmp	al, 2	;@1455F
	jbe	@@1	;@14561
	stosb	;@14563
	jmp	L1455E	;@14564
@@1:	cmp	al, 1	;@14566
	je	@@2	;@14568
	cmp	al, 2	;@1456A
	je	@@3	;@1456C
	retf	;@1456E
@@2:	lodsw	;@1456F
	push	si	;@14570
	push	ds	;@14571
	mov	si, ax	;@14572
	push	ss	;@14574
	pop	ds	;@14575
	push	cs	;@14576
	call	L1455E	;@14577
	pop	ds	;@1457A
	pop	si	;@1457B
	jmp	L1455E	;@1457C
@@3:	lodsb	;@1457E
	xor	ah, ah	;@1457F
	push	si	;@14581
	push	ds	;@14582
	push	ss	;@14583
	pop	ds	;@14584
	xor	si, si	;@14585
	cmp	al, 0Fh	;@14587
	jae	@@4	;@14589
	mov	si, ax	;@1458B
	shl	si, 1	;@1458D
	mov	si, word ptr [si+0A54h]	;@1458F
	push	cs	;@14593
	call	L1455E	;@14594
@@4:	pop	ds	;@14597
	pop	si	;@14598
	jmp	L1455E	;@14599
C1455	ends

C1459	segment word public 'CODE'
	assume	cs:C1459
L1459C:	call	L1460B	;@1459C
	cmp	word ptr ds:[98h], 1	;@1459F
	jbe	L14600	;@145A4
	test	word ptr ds:[96h], 1	;@145A6
	je	L14600	;@145AC
	push	ds	;@145AE
	pop	es	;@145AF
	mov	di, 460Eh	;@145B0
	mov	dx, 110h	;@145B3
	mov	cx, word ptr ds:[98h]	;@145B6
	call	@@1	;@145BA
	mov	dx, 123h	;@145BD
	mov	cx, word ptr ds:[9Eh]	;@145C0
	call	@@1	;@145C4
	mov	dx, 136h	;@145C7
	mov	cx, word ptr ds:[9Ah]	;@145CA
	call	@@1	;@145CE
	mov	dx, 143h	;@145D1
	mov	cx, word ptr ds:[9Ch]	;@145D4
	call	@@1	;@145D8
	mov	dx, 0F2h	;@145DB
	call	L149E0	;@145DE
	jmp	short L14600	;@145E1
@@1:	push	cx	;@145E3
	call	L149E0	;@145E4
	mov	di, 460Eh	;@145E7
	pop	cx	;@145EA
	call	L1496A	;@145EB
	mov	dx, 460Eh	;@145EE
	call	L149E0	;@145F1
	ret	;@145F4
L145F5:	mov	dx, 322h	;@145F5
L145F8:	call	L149E0	;@145F8
L145FB:	mov	byte ptr ds:[1Dh], 2	;@145FB
L14600:	call	L14A96	;@14600
	mov	al, byte ptr ds:[1Dh]	;@14603
	jmp	far ptr L11285	;@14606
L1460B:	les	di, dword ptr ds:[36E0h]	;@1460B
@@1:	cmp	word ptr es:[di], 1	;@1460F
	jne	@@3	;@14613
	mov	si, word ptr es:[di+0Eh]	;@14615
@@2:	call	@@4	;@14619
	jb	@@3	;@1461C
	cmp	byte ptr es:[si], 0FFh	;@1461E
	jne	@@2	;@14622
	inc	si	;@14624
	mov	di, si	;@14625
	jmp	@@1	;@14627
@@3:	ret	;@14629
@@4:	cmp	byte ptr es:[si], 0FFh	;@1462A
	jne	@@5	;@1462E
	ret	;@14630
@@5:	push	di	;@14631
	push	es	;@14632
	push	di	;@14633
	push	es	;@14634
	push	si	;@14635
	mov	word ptr ds:[3700h], 0	;@14636
	mov	word ptr ds:[3702h], 0	;@1463C
	mov	word ptr ds:[0A0h], 370Dh	;@14642
	mov	byte ptr ds:[36DCh], 0	;@14648
	and	word ptr ds:[96h], -3	;@1464D
	mov	ax, word ptr ds:[36EAh]	;@14652
	mov	cx, word ptr ds:[36ECh]	;@14655
	mov	dx, word ptr es:[di+8]	;@14659
	call	far ptr L00006	;@1465D
	jae	@@6	;@14662
	pop	si	;@14664
	pop	es	;@14665
	pop	di	;@14666
	push	si	;@14667
	call	L14A0C	;@14668
	mov	al, 2	;@1466B
	call	L14A02	;@1466D
	stc	;@14670
	jmp	@@22	;@14671
@@6:	mov	ax, word ptr ds:[36EEh]	;@14674
	mov	dx, word ptr ds:[36F0h]	;@14677
	call	far ptr L0FAA6	;@1467B
	pop	si	;@14680
	pop	ds	;@14681
	push	ss	;@14682
	pop	es	;@14683
	mov	di, 370Dh	;@14684
	call	L14938	;@14687
	mov	di, 375Dh	;@1468A
	call	L14938	;@1468D
	mov	di, 37ADh	;@14690
	call	L14938	;@14693
	mov	di, 37FDh	;@14696
	call	L14938	;@14699
	push	ds	;@1469C
	push	si	;@1469D
	push	ss	;@1469E
	pop	ds	;@1469F
	mov	si, 370Dh	;@146A0
	call	L149AF	;@146A3
	mov	cx, 4	;@146A6
	mov	di, 384Dh	;@146A9
	rep movsw	;@146AC
	xor	al, al	;@146AE
	stosb	;@146B0
	mov	si, 384Dh	;@146B1
	call	L149D5	;@146B4
	mov	byte ptr [si], 0	;@146B7
	pop	si	;@146BA
	pop	es	;@146BB
	pop	di	;@146BC
	push	si	;@146BD
	mov	bx, word ptr es:[di+0Ah]	;@146BE
	mov	ax, word ptr es:[di+2]	;@146C2
	mov	word ptr ds:[38C4h], ax	;@146C6
	mov	ax, word ptr es:[di+4]	;@146C9
	mov	word ptr ds:[38C6h], ax	;@146CD
	mov	word ptr ds:[3704h], ax	;@146D0
	mov	ax, word ptr es:[di+6]	;@146D3
	mov	word ptr ds:[38C8h], ax	;@146D7
	mov	word ptr ds:[38D2h], 64h	;@146DA
	mov	word ptr ds:[38D0h], 0FFFFh	;@146E0
	push	ss	;@146E6
	pop	es	;@146E7
	mov	di, 67h	;@146E8
	xor	dh, dh	;@146EB
	dec	word ptr ds:[1Fh]	;@146ED
	jne	@@7	;@146F1
	or	dh, 2	;@146F3
@@7:	cmp	word ptr ds:[21h], 0	;@146F6
	jne	@@8	;@146FB
	or	dh, 1	;@146FD
@@8:	cmp	byte ptr ds:[37ADh], 0	;@14700
	je	@@9	;@14705
	dec	word ptr ds:[21h]	;@14707
@@9:	push	es	;@1470B
	mov	ax, 58FAh	;@1470C
	mov	word ptr ds:[38D4h], ax	;@1470F
	mov	ax, 205h	;@14712
	call	far ptr L00011	;@14715
	pop	es	;@1471A
	mov	byte ptr ds:[36DBh], 1	;@1471B
	jae	@@10	;@14720
	call	L14A0C	;@14722
	mov	al, 2	;@14725
	call	L14A02	;@14727
	stc	;@1472A
	jmp	@@20	;@1472B
@@10:	test	word ptr ds:[38C4h], 400h	;@1472E
	jne	@@11	;@14734
	call	L14A2C	;@14736
@@11:	pop	si	;@14739
	pop	es	;@1473A
	pop	di	;@1473B
	push	di	;@1473C
	push	es	;@1473D
	push	si	;@1473E
	lea	si, [di+10h]	;@1473F
	push	es	;@14742
	pop	ds	;@14743
@@12:	cmp	si, word ptr es:[di+0Eh]	;@14744
	jae	@@15	;@14748
	lodsb	;@1474A
	push	ds	;@1474B
	push	es	;@1474C
	push	di	;@1474D
	push	ax	;@1474E
	push	ss	;@1474F
	pop	es	;@14750
	mov	di, 3A0Ah	;@14751
	mov	dx, di	;@14754
	call	L14938	;@14756
	push	ss	;@14759
	pop	ds	;@1475A
	pop	ax	;@1475B
	push	si	;@1475C
	cmp	al, 1	;@1475D
	je	@@13	;@1475F
	mov	byte ptr ds:[3709h], 49h	;@14761
	call	far ptr L00023	;@14766
	jmp	short @@14	;@1476B
@@13:	mov	byte ptr ds:[3709h], 44h	;@1476D
	mov	di, dx	;@14772
	call	far ptr L0002C	;@14774
@@14:	pop	si	;@14779
	pop	di	;@1477A
	pop	es	;@1477B
	pop	ds	;@1477C
	jae	@@12	;@1477D
	mov	ax, ss	;@1477F
	mov	ds, ax	;@14781
	mov	es, ax	;@14783
	call	@@23	;@14785
	mov	dx, 0D5h	;@14788
	call	L149E0	;@1478B
	mov	al, byte ptr ds:[36D9h]	;@1478E
	mov	byte ptr ds:[3708h], al	;@14791
	mov	byte ptr ds:[370Ah], 0	;@14794
	mov	dx, 3708h	;@14799
	call	L149E0	;@1479C
	mov	dx, 37ADh	;@1479F
	call	L149E0	;@147A2
	mov	dx, 1BAh	;@147A5
	call	L149E0	;@147A8
	call	L14A0C	;@147AB
	mov	dx, 0F2h	;@147AE
	call	L149E0	;@147B1
	stc	;@147B4
	jmp	short @@20	;@147B5
@@15:	mov	ax, ss	;@147B7
	mov	ds, ax	;@147B9
	mov	es, ax	;@147BB
	mov	byte ptr ds:[36DAh], 0	;@147BD
	mov	bx, 370Dh	;@147C2
	mov	dx, 375Dh	;@147C5
	mov	si, 37ADh	;@147C8
	mov	di, 37FDh	;@147CB
	cmp	byte ptr [si], 0	;@147CE
	jne	@@16	;@147D1
	mov	byte ptr [di], 0	;@147D3
@@16:	mov	cx, 384Dh	;@147D6
	call	far ptr L0001A	;@147D9
	jae	@@17	;@147DE
	mov	byte ptr ds:[36DAh], 1	;@147E0
	mov	byte ptr ds:[1Eh], 1	;@147E5
@@17:	call	@@23	;@147EA
	cmp	byte ptr ds:[36DAh], 1	;@147ED
	jne	@@18	;@147F2
	call	L14A2C	;@147F4
	call	L14A0C	;@147F7
	inc	word ptr ds:[9Eh]	;@147FA
@@18:	test	word ptr ds:[96h], 2	;@147FE
	je	@@19	;@14804
	mov	dx, 0F2h	;@14806
	call	L149E0	;@14809
@@19:	inc	word ptr ds:[98h]	;@1480C
	mov	ax, word ptr ds:[3700h]	;@14810
	add	word ptr ds:[9Ah], ax	;@14813
	mov	ax, word ptr ds:[3702h]	;@14817
	add	word ptr ds:[9Ch], ax	;@1481A
	clc	;@1481E
@@20:	pushf	;@1481F
	call	far ptr L00035	;@14820
	mov	byte ptr ds:[36DBh], 0	;@14825
	call	far ptr L0F9E4	;@1482A
	cmp	byte ptr ds:[36DCh], 1	;@1482F
	jne	@@21	;@14834
	mov	dx, 375Dh	;@14836
	call	far ptr L1130A	;@14839
@@21:	popf	;@1483E
@@22:	pop	si	;@1483F
	pop	es	;@14840
	pop	di	;@14841
	mov	word ptr ds:[0A0h], 0	;@14842
	ret	;@14848
@@23:	call	far ptr L0F9B6	;@14849
	test	word ptr ds:[96h], 2	;@1484E
	je	@@26	;@14854
	mov	dx, 152h	;@14856
	call	L149E0	;@14859
	mov	cx, word ptr ds:[3700h]	;@1485C
	call	@@27	;@14860
	mov	dx, 166h	;@14863
	call	L149E0	;@14866
	mov	cx, word ptr ds:[3702h]	;@14869
	call	@@27	;@1486D
	mov	dx, 17Ch	;@14870
	call	L149E0	;@14873
	mov	cx, word ptr ds:[3704h]	;@14876
	sub	cx, word ptr ds:[38C6h]	;@1487A
	call	@@27	;@1487E
	mov	dx, 192h	;@14881
	call	L149E0	;@14884
	call	far ptr L00039	;@14887
	cmp	ax, 0FFFh	;@1488C
	ja	@@24	;@1488F
	mov	cl, 4	;@14891
	shl	ax, cl	;@14893
	mov	dx, 1A8h	;@14895
	jmp	short @@25	;@14898
@@24:	mov	cl, 6	;@1489A
	shr	ax, cl	;@1489C
	mov	dx, 1B1h	;@1489E
@@25:	push	dx	;@148A1
	mov	cx, ax	;@148A2
	mov	di, ds	;@148A4
	mov	es, di	;@148A6
	mov	di, 37ADh	;@148A8
	mov	dx, di	;@148AB
	call	L1496A	;@148AD
	call	L149E0	;@148B0
	pop	dx	;@148B3
	call	L149E0	;@148B4
@@26:	ret	;@148B7
@@27:	jcxz	@@28	;@148B8
	mov	dx, ds	;@148BA
	mov	es, dx	;@148BC
	mov	di, 37ADh	;@148BE
	mov	dx, di	;@148C1
	call	L1496A	;@148C3
	call	L149E0	;@148C6
	ret	;@148C9
@@28:	mov	dx, 1B5h	;@148CA
	call	L149E0	;@148CD
	ret	;@148D0
L148D1:	push	es	;@148D1
	push	ds	;@148D2
	pop	es	;@148D3
	push	cx	;@148D4
	push	bx	;@148D5
	call	L14A2C	;@148D6
	pop	si	;@148D9
	mov	di, 460Eh	;@148DA
	push	di	;@148DD
	call	far ptr L1455E	;@148DE
	xor	al, al	;@148E3
	stosb	;@148E5
	pop	dx	;@148E6
	call	L149E0	;@148E7
	mov	dx, 0F2h	;@148EA
	call	L149E0	;@148ED
	pop	cx	;@148F0
	cmp	cx, -1	;@148F1
	je	@@1	;@148F4
	test	cx, 8000h	;@148F6
	je	@@2	;@148FA
	inc	word ptr ds:[3702h]	;@148FC
@@1:	clc	;@14900
	pop	es	;@14901
	retf	;@14902
@@2:	mov	al, 1	;@14903
	call	L14A02	;@14905
	inc	word ptr ds:[3700h]	;@14908
	and	cx, 7FFh	;@1490C
	cmp	cx, 24h	;@14910
	je	@@1	;@14913
	mov	byte ptr ds:[36DCh], 1	;@14915
	jmp	@@1	;@1491A
L1491C:	cmp	al, 61h	;@1491C
	jb	@@1	;@1491E
	cmp	al, 7Ah	;@14920
	ja	@@1	;@14922
	sub	al, 20h	;@14924
@@1:	ret	;@14926
L14927:	push	di	;@14927
	push	di	;@14928
	xor	al, al	;@14929
	mov	cx, 0FFFFh	;@1492B
	repne scasb	;@1492E
	dec	di	;@14930
	pop	ax	;@14931
	sub	di, ax	;@14932
	mov	cx, di	;@14934
	pop	di	;@14936
	ret	;@14937
L14938:	lodsb	;@14938
	stosb	;@14939
	or	al, al	;@1493A
	jne	L14938	;@1493C
	ret	;@1493E
L1493F:	push	ax	;@1493F
	push	si	;@14940
	mov	ah, al	;@14941
@@1:	lodsb	;@14943
	cmp	al, ah	;@14944
	je	@@2	;@14946
	or	al, al	;@14948
	jne	@@1	;@1494A
	pop	si	;@1494C
	pop	ax	;@1494D
	ret	;@1494E
@@2:	dec	si	;@1494F
	pop	ax	;@14950
	pop	ax	;@14951
	ret	;@14952
L14953:	mov	ah, al	;@14953
@@1:	lodsb	;@14955
	or	al, al	;@14956
	je	@@2	;@14958
	cmp	al, ah	;@1495A
	je	@@2	;@1495C
	cmp	al, byte ptr es:[di]	;@1495E
	jne	@@2	;@14961
	inc	di	;@14963
	jmp	@@1	;@14964
@@2:	cmp	al, byte ptr es:[di]	;@14966
	ret	;@14969
L1496A:	push	ax	;@1496A
	push	si	;@1496B
	push	di	;@1496C
	mov	ah, 30h	;@1496D
	mov	si, 2710h	;@1496F
	call	@@1	;@14972
	mov	si, 3E8h	;@14975
	call	@@1	;@14978
	mov	si, 64h	;@1497B
	call	@@1	;@1497E
	mov	si, 0Ah	;@14981
	call	@@1	;@14984
	mov	si, 1	;@14987
	mov	ah, 0FFh	;@1498A
	call	@@1	;@1498C
	xor	al, al	;@1498F
	stosb	;@14991
	pop	di	;@14992
	pop	si	;@14993
	pop	ax	;@14994
	ret	;@14995
@@1:	mov	al, 2Fh	;@14996
@@2:	inc	al	;@14998
	sub	cx, si	;@1499A
	jae	@@2	;@1499C
	add	cx, si	;@1499E
	cmp	al, ah	;@149A0
	je	@@3	;@149A2
	mov	ah, 0FFh	;@149A4
	stosb	;@149A6
@@3:	ret	;@149A7
L149A8:	cmp	al, 5Ch	;@149A8
	je	@@1	;@149AA
	cmp	al, 3Ah	;@149AC
@@1:	ret	;@149AE
L149AF:	push	cx	;@149AF
	push	di	;@149B0
	push	es	;@149B1
	mov	ax, ds	;@149B2
	mov	es, ax	;@149B4
	mov	di, si	;@149B6
	xor	al, al	;@149B8
	mov	cx, 0FFFFh	;@149BA
	repne scasb	;@149BD
	dec	di	;@149BF
	std	;@149C0
	xchg	si, di	;@149C1
@@1:	lodsb	;@149C3
	call	L149A8	;@149C4
	je	@@2	;@149C7
	cmp	si, di	;@149C9
	jae	@@1	;@149CB
	dec	si	;@149CD
@@2:	inc	si	;@149CE
	inc	si	;@149CF
	cld	;@149D0
	pop	es	;@149D1
	pop	di	;@149D2
	pop	cx	;@149D3
	ret	;@149D4
L149D5:	lodsb	;@149D5
	or	al, al	;@149D6
	je	@@1	;@149D8
	cmp	al, 2Eh	;@149DA
	jne	L149D5	;@149DC
@@1:	dec	si	;@149DE
	ret	;@149DF
L149E0:	push	es	;@149E0
	push	ds	;@149E1
	pop	es	;@149E2
	call	L149F0	;@149E3
	pop	es	;@149E6
	ret	;@149E7
L149E8:	push	es	;@149E8
	push	cs	;@149E9
	pop	es	;@149EA
	call	L149F0	;@149EB
	pop	es	;@149EE
	ret	;@149EF
L149F0:	push	di	;@149F0
	mov	di, dx	;@149F1
	call	L14927	;@149F3
	mov	bx, 1	;@149F6
	mov	ax, es	;@149F9
	call	far ptr L112F6	;@149FB
	pop	di	;@14A00
	ret	;@14A01
L14A02:	cmp	al, byte ptr ds:[1Dh]	;@14A02
	jbe	@@1	;@14A06
	mov	byte ptr ds:[1Dh], al	;@14A08
@@1:	ret	;@14A0B
L14A0C:	push	ss	;@14A0C
	pop	es	;@14A0D
	mov	al, byte ptr ss:[38D6h]	;@14A0E
	cmp	al, 0Eh	;@14A12
	jb	@@1	;@14A14
	xor	al, al	;@14A16
@@1:	mov	bl, al	;@14A18
	xor	bh, bh	;@14A1A
	shl	bx, 1	;@14A1C
	mov	dx, word ptr [bx+1BEh]	;@14A1E
	call	L149E0	;@14A22
	mov	al, 2	;@14A25
	call	L14A02	;@14A27
	stc	;@14A2A
	ret	;@14A2B
L14A2C:	push	ds	;@14A2C
	pop	es	;@14A2D
	test	word ptr ds:[96h], 1	;@14A2E
	jne	@@1	;@14A34
	or	word ptr ds:[96h], 1	;@14A36
	mov	dx, 67h	;@14A3B
	call	L149E0	;@14A3E
	mov	dx, 0A2h	;@14A41
	call	L149E0	;@14A44
@@1:	cmp	word ptr ds:[0A0h], 0	;@14A47
	je	@@3	;@14A4C
	test	word ptr ds:[96h], 2	;@14A4E
	jne	@@3	;@14A54
	or	word ptr ds:[96h], 2	;@14A56
	mov	dx, 0F2h	;@14A5B
	call	L149E0	;@14A5E
	mov	dx, 0FCh	;@14A61
	call	L149E0	;@14A64
	mov	dx, word ptr ds:[0A0h]	;@14A67
	call	L149E0	;@14A6B
	mov	si, word ptr ds:[0A0h]	;@14A6E
	mov	di, 375Dh	;@14A72
	mov	al, 2Eh	;@14A75
	call	L14953	;@14A77
	je	@@2	;@14A7A
	cmp	byte ptr ds:[375Dh], 0	;@14A7C
	je	@@2	;@14A81
	mov	dx, 0F5h	;@14A83
	call	L149E0	;@14A86
	mov	dx, 375Dh	;@14A89
	call	L149E0	;@14A8C
@@2:	mov	dx, 0F2h	;@14A8F
	call	L149E0	;@14A92
@@3:	ret	;@14A95
L14A96:	push	ds	;@14A96
	lds	dx, dword ptr ds:[36AAh]	;@14A97
	mov	al, 18h	;@14A9B
	mov	ah, 25h	;@14A9D
	int	21h	;@14A9F
	cld	;@14AA1
	pop	ds	;@14AA2
	ret	;@14AA3
	db	0FBh, 53h, 55h, 8Bh, 0ECh, 6, 8Bh, 5Eh, 4, 87h, 5Eh, 6, 87h, 5Eh, 8, 87h	;@14AA4
	db	5Eh, 2, 89h, 5Eh, 4, 0C4h, 5Eh, 6, 0FFh, 46h, 6, 26h, 8Ah, 1Fh, 0B7h, 0
	db	0D1h, 0E3h, 0F7h, 0DBh, 2Eh, 8Bh, 9Fh, 42h, 6, 87h, 5Eh, 4, 7, 5Dh, 9Dh, 0C3h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h, 90h
	db	50h, 1Eh, 0B8h
	dw	seg DATA_START
	db	8Eh, 0D8h, 80h, 3Eh, 0DBh, 36h, 1, 75h, 5, 9Ah
	dd	L00035
	db	0C6h, 6, 1Dh, 0, 3, 0E9h, 11h, 0FAh
L14BEF:	mov	dx, bx	;@14BEF
	mov	bx, 1	;@14BF1
	mov	ax, ds	;@14BF4
	mov	cx, di	;@14BF6
	dec	cx	;@14BF8
	call	far ptr L112F6	;@14BF9
	mov	dx, 0F2h	;@14BFE
	call	L149E0	;@14C01
	retf	;@14C04
	db	'**Fatal** Need DOS version 2.0 or higher', 0Dh, 0Ah, '$**Fatal** Invalid command line'	;@14C05
	db	0Dh, 0Ah, 0, '**Fatal** Bad switch: ', 0, 0Dh, 0Ah, 0, '**Fatal** Missing switch character'
	db	0Dh, 0Ah, 0, '**Fatal** Invalid number after ', 0, '**Fatal** Invalid argument after '
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
start:	cld	;@15217
	mov	ax, seg DATA_START	;@15218
	mov	ds, ax	;@1521B
	cli	;@1521D
	mov	ss, ax	;@1521E
	mov	sp, 5CBAh	;@15220
	sti	;@15223
	mov	ax, 5CBAh	;@15224
	add	ax, 0Fh	;@15227
	mov	cl, 4	;@1522A
	shr	ax, cl	;@1522C
	mov	cx, ds	;@1522E
	add	ax, cx	;@15230
	mov	word ptr ds:[36EAh], ax	;@15232
	mov	ax, word ptr es:[2]	;@15235
	sub	ax, word ptr ds:[36EAh]	;@15239
	mov	word ptr ds:[36ECh], ax	;@1523D
	mov	bx, 81h	;@15240
	mov	word ptr ds:[36A2h], bx	;@15243
	mov	word ptr ds:[36A4h], es	;@15247
	add	bl, byte ptr es:[80h]	;@1524B
	mov	byte ptr es:[bx], 0	;@15250
	mov	word ptr ds:[36A8h], 0	;@15254
	mov	ah, 30h	;@1525A
	int	21h	;@1525C
	cmp	al, 3	;@1525E
	jb	@@2	;@15260
	mov	ax, word ptr es:[2Ch]	;@15262
	mov	word ptr ds:[36A8h], ax	;@15266
	push	ds	;@15269
	mov	ds, ax	;@1526A
	xor	si, si	;@1526C
@@1:	xor	al, al	;@1526E
	call	L1493F	;@15270
	inc	si	;@15273
	cmp	byte ptr [si], 0	;@15274
	jne	@@1	;@15277
	inc	si	;@15279
	inc	si	;@1527A
	inc	si	;@1527B
	pop	ds	;@1527C
	mov	word ptr ds:[36A6h], si	;@1527D
@@2:	push	ss	;@15281
	pop	es	;@15282
	push	es	;@15283
	call	far ptr L1122D	;@15284
	pop	es	;@15289
	jb	@@3	;@1528A
	call	L159D5	;@1528C
	call	L15BF4	;@1528F
	call	L15C11	;@15292
	call	L1559D	;@15295
	jmp	short @@4	;@15298
@@3:	push	word ptr ds:[36A4h]	;@1529A
	xor	ax, ax	;@1529E
	push	ax	;@152A0
	push	cs	;@152A1
	pop	ds	;@152A2
	mov	dx, 675h	;@152A3
	mov	ah, 9	;@152A6
	int	21h	;@152A8
	retf	;@152AA
@@4:	call	L15724	;@152AB
	jb	@@6	;@152AE
	cmp	word ptr ds:[1Fh], 0	;@152B0
	je	@@5	;@152B5
	mov	cl, 4	;@152B7
	mov	ax, word ptr ds:[36E8h]	;@152B9
	sub	ax, word ptr ds:[36E0h]	;@152BC
	add	ax, 12h	;@152C0
	shr	ax, cl	;@152C3
	add	word ptr ds:[36EAh], ax	;@152C5
	sub	word ptr ds:[36ECh], ax	;@152C9
	mov	ax, 675h	;@152CD
	add	ax, 0Fh	;@152D0
	shr	ax, cl	;@152D3
	mov	bx, 19D1h	;@152D5
	shr	bx, cl	;@152D8
	sub	bx, ax	;@152DA
	mov	cx, cs	;@152DC
	add	ax, cx	;@152DE
	mov	word ptr ds:[36EEh], ax	;@152E0
	mov	word ptr ds:[36F0h], bx	;@152E3
	jmp	L1459C	;@152E7
@@5:	call	L14A2C	;@152EA
	mov	dx, 75Eh	;@152ED
	call	L149E8	;@152F0
	jmp	L14600	;@152F3
@@6:	call	L14A2C	;@152F6
	mov	dx, 6A0h	;@152F9
	call	L149E8	;@152FC
	jmp	L145FB	;@152FF
L15302:	cmp	al, 41h	;@15302
	jb	@@1	;@15304
	cmp	al, 5Ah	;@15306
	ja	@@1	;@15308
	add	al, 20h	;@1530A
@@1:	ret	;@1530C
L1530D:	push	si	;@1530D
	push	di	;@1530E
@@1:	lodsb	;@1530F
	stosb	;@15310
	or	al, al	;@15311
	jne	@@1	;@15313
	pop	di	;@15315
	pop	si	;@15316
	ret	;@15317
L15318:	push	ax	;@15318
	push	si	;@15319
	push	di	;@1531A
	xchg	si, di	;@1531B
	xor	al, al	;@1531D
	call	L1493F	;@1531F
	xchg	si, di	;@15322
	call	L1530D	;@15324
	pop	di	;@15327
	pop	si	;@15328
	pop	ax	;@15329
	ret	;@1532A
L1532B:	cmp	al, 2Dh	;@1532B
	je	@@1	;@1532D
	cmp	al, 2Fh	;@1532F
	je	@@1	;@15331
	ret	;@15333
@@1:	mov	byte ptr ds:[36D9h], al	;@15334
	ret	;@15337
L15338:	push	si	;@15338
@@1:	lodsb	;@15339
	or	al, al	;@1533A
	je	@@3	;@1533C
	cmp	al, 3Fh	;@1533E
	je	@@2	;@15340
	cmp	al, 2Ah	;@15342
	jne	@@1	;@15344
@@2:	pop	si	;@15346
	ret	;@15347
@@3:	inc	al	;@15348
	pop	si	;@1534A
	ret	;@1534B
L1534C:	cmp	byte ptr [si], 0	;@1534C
	je	@@4	;@1534F
	push	dx	;@15351
	push	si	;@15352
@@1:	lodsb	;@15353
	or	al, al	;@15354
	jne	@@1	;@15356
	dec	si	;@15358
	dec	si	;@15359
	lodsb	;@1535A
	pop	si	;@1535B
	call	L149A8	;@1535C
	je	@@3	;@1535F
	mov	dx, si	;@15361
	call	far ptr L112D0	;@15363
	jb	@@2	;@15368
	call	far ptr L112E6	;@1536A
	xor	ax, ax	;@1536F
@@2:	cmp	ax, 5	;@15371
@@3:	pop	dx	;@15374
	ret	;@15375
@@4:	xor	al, al	;@15376
	inc	al	;@15378
	stc	;@1537A
	ret	;@1537B
L1537C:	cmp	byte ptr [si], 0	;@1537C
	je	@@1	;@1537F
	cmp	byte ptr [si+1], 3Ah	;@15381
	jne	@@1	;@15385
	movsb	;@15387
	movsb	;@15388
@@1:	lodsb	;@15389
	or	al, al	;@1538A
	je	@@6	;@1538C
	cmp	al, 3Fh	;@1538E
	je	@@2	;@15390
	cmp	al, 2Ah	;@15392
	je	@@3	;@15394
	stosb	;@15396
	cmp	byte ptr [bx], 0	;@15397
	je	@@1	;@1539A
	inc	bx	;@1539C
	jmp	@@1	;@1539D
@@2:	mov	al, byte ptr [bx]	;@1539F
	inc	bx	;@153A1
	stosb	;@153A2
	jmp	@@1	;@153A3
@@3:	xchg	si, bx	;@153A5
@@4:	lodsb	;@153A7
	or	al, al	;@153A8
	je	@@5	;@153AA
	cmp	al, 2Eh	;@153AC
	je	@@5	;@153AE
	stosb	;@153B0
	jmp	@@4	;@153B1
@@5:	xchg	si, bx	;@153B3
	dec	bx	;@153B5
	jmp	@@1	;@153B6
@@6:	xor	al, al	;@153B8
	stosb	;@153BA
	ret	;@153BB
L153BC:	push	si	;@153BC
	push	di	;@153BD
@@1:	lodsb	;@153BE
	stosb	;@153BF
	or	al, al	;@153C0
	jne	@@1	;@153C2
	pop	di	;@153C4
	pop	si	;@153C5
	call	L149AF	;@153C6
	push	si	;@153C9
	mov	si, di	;@153CA
	call	L149AF	;@153CC
	mov	di, si	;@153CF
	mov	si, bx	;@153D1
	call	L149AF	;@153D3
	mov	bx, si	;@153D6
	pop	si	;@153D8
	call	L1537C	;@153D9
	ret	;@153DC
L153DD:	cmp	byte ptr [di], 0	;@153DD
	je	@@3	;@153E0
	push	si	;@153E2
	push	di	;@153E3
	xchg	si, di	;@153E4
	call	L149AF	;@153E6
	call	L149D5	;@153E9
	cmp	byte ptr [si], 0	;@153EC
	jne	@@2	;@153EF
	xchg	si, di	;@153F1
@@1:	lodsb	;@153F3
	stosb	;@153F4
	or	al, al	;@153F5
	jne	@@1	;@153F7
@@2:	pop	di	;@153F9
	pop	si	;@153FA
@@3:	ret	;@153FB
L153FC:	call	L159F9	;@153FC
	mov	si, 37h	;@153FF
	mov	di, 3E0Ch	;@15402
	call	L1530D	;@15405
	mov	si, 44h	;@15408
	mov	di, 420Ch	;@1540B
	call	L1530D	;@1540E
	mov	si, 44h	;@15411
	mov	di, 53C2h	;@15414
	call	L1530D	;@15417
	ret	;@1541A
L1541B:	cmp	al, 20h	;@1541B
	ja	@@1	;@1541D
	cmp	al, al	;@1541F
	ret	;@15421
@@1:	push	cx	;@15422
	push	di	;@15423
	mov	di, 33Ch	;@15424
	mov	cx, 5	;@15427
	repne scasb	;@1542A
	je	@@2	;@1542C
	call	L1532B	;@1542E
@@2:	pop	di	;@15431
	pop	cx	;@15432
	ret	;@15433
L15434:	cmp	al, 20h	;@15434
	jbe	@@1	;@15436
	push	cx	;@15438
	push	di	;@15439
	mov	di, 341h	;@1543A
	mov	cx, 0Ah	;@1543D
	repne scasb	;@15440
	pop	di	;@15442
	pop	cx	;@15443
	ret	;@15444
@@1:	cmp	al, al	;@15445
	ret	;@15447
L15448:	mov	di, word ptr ds:[36FEh]	;@15448
@@1:	call	L15BB9	;@1544C
	call	L15434	;@1544F
	je	@@2	;@15452
	call	L15B6A	;@15454
	stosb	;@15457
	jmp	@@1	;@15458
@@2:	cmp	di, word ptr ds:[36FEh]	;@1545A
	je	@@3	;@1545E
	mov	byte ptr es:[di], 0	;@15460
	xor	al, al	;@15464
	ret	;@15466
@@3:	xor	al, al	;@15467
	inc	al	;@15469
	ret	;@1546B
	db	8Bh, 3Eh, 0FEh, 36h, 0E8h, 46h, 7, '< v', 0Ah, '<,t', 6, 0E8h	;@1546C
	db	0ECh, 6, 0AAh, 0EBh, 0EFh, 3Bh, 3Eh, 0FEh, 36h, 74h, 7, 26h, 0C6h
	db	5, 0, 32h, 0C0h, 0C3h, 32h, 0C0h, 0FEh, 0C0h, 0C3h
L15493:	call	L15BB9	;@15493
	or	al, al	;@15496
	je	@@2	;@15498
	cmp	al, 20h	;@1549A
	ja	@@1	;@1549C
	call	L15B6A	;@1549E
	jmp	L15493	;@154A1
@@1:	call	L1532B	;@154A3
	je	@@3	;@154A6
	call	L15448	;@154A8
	je	@@4	;@154AB
	call	L15B6A	;@154AD
	mov	byte ptr ds:[36FDh], al	;@154B0
	mov	ax, 3	;@154B3
	ret	;@154B6
@@2:	mov	ax, 0	;@154B7
	ret	;@154BA
@@3:	call	L15B6A	;@154BB
	push	word ptr ds:[36FEh]	;@154BE
	call	L15C24	;@154C2
	pop	word ptr ds:[36FEh]	;@154C5
	jmp	L15493	;@154C9
@@4:	mov	ax, 1	;@154CB
	ret	;@154CE
L154CF:	call	L15BB9	;@154CF
	or	al, al	;@154D2
	je	@@3	;@154D4
	cmp	al, 20h	;@154D6
	ja	@@1	;@154D8
	call	L15B6A	;@154DA
	jmp	L154CF	;@154DD
@@1:	call	L1532B	;@154DF
	je	@@2	;@154E2
	call	L15434	;@154E4
	jne	@@4	;@154E7
	call	L15BB9	;@154E9
	mov	byte ptr ds:[36FDh], al	;@154EC
	mov	ax, 3	;@154EF
	ret	;@154F2
@@2:	call	L15B6A	;@154F3
	push	word ptr ds:[36FEh]	;@154F6
	call	L15C24	;@154FA
	pop	word ptr ds:[36FEh]	;@154FD
	jmp	L154CF	;@15501
@@3:	mov	ax, 0	;@15503
	ret	;@15506
@@4:	mov	ax, 1	;@15507
	ret	;@1550A
L1550B:	push	bp	;@1550B
	sub	sp, 20h	;@1550C
	mov	bp, sp	;@1550F
	push	si	;@15511
	call	L15BB9	;@15512
	cmp	al, 30h	;@15515
	jb	@@8	;@15517
	cmp	al, 39h	;@15519
	ja	@@8	;@1551B
	mov	bl, 0Ah	;@1551D
	xor	si, si	;@1551F
@@1:	push	si	;@15521
	call	L15BB9	;@15522
	call	L15302	;@15525
	call	L1541B	;@15528
	pop	si	;@1552B
	je	@@3	;@1552C
	cmp	si, 20h	;@1552E
	jae	@@8	;@15531
	cmp	al, 30h	;@15533
	jb	@@3	;@15535
	cmp	al, 39h	;@15537
	jbe	@@2	;@15539
	cmp	al, 61h	;@1553B
	jb	@@3	;@1553D
	cmp	al, 66h	;@1553F
	ja	@@3	;@15541
	mov	bl, 10h	;@15543
	sub	al, 27h	;@15545
@@2:	sub	al, 30h	;@15547
	mov	byte ptr [bp+si], al	;@15549
	push	si	;@1554B
	call	L15B6A	;@1554C
	pop	si	;@1554F
	inc	si	;@15550
	jmp	@@1	;@15551
@@3:	mov	byte ptr [bp+si], 0FFh	;@15553
	call	L15BB9	;@15556
	call	L15302	;@15559
	cmp	al, 68h	;@1555C
	jne	@@4	;@1555E
	call	L15B6A	;@15560
	mov	bl, 10h	;@15563
	jmp	short @@5	;@15565
@@4:	cmp	bl, 10h	;@15567
	je	@@8	;@1556A
@@5:	call	L15BB9	;@1556C
	call	L1541B	;@1556F
	jne	@@8	;@15572
	xor	si, si	;@15574
	xor	bh, bh	;@15576
	xor	ax, ax	;@15578
@@6:	cmp	byte ptr [bp+si], 0FFh	;@1557A
	je	@@7	;@1557D
	mul	bx	;@1557F
	add	al, byte ptr [bp+si]	;@15581
	adc	ah, 0	;@15583
	inc	si	;@15586
	jmp	@@6	;@15587
@@7:	or	si, si	;@15589
	jne	@@9	;@1558B
@@8:	xor	ax, ax	;@1558D
	stc	;@1558F
	jmp	short @@10	;@15590
@@9:	clc	;@15592
@@10:	pop	si	;@15593
	pushf	;@15594
	pop	bp	;@15595
	add	sp, 20h	;@15596
	push	bp	;@15599
	popf	;@1559A
	pop	bp	;@1559B
	ret	;@1559C
L1559D:	mov	ax, word ptr ds:[36EAh]	;@1559D
	mov	word ptr ds:[36E6h], ax	;@155A0
	mov	word ptr ds:[36E2h], ax	;@155A3
	xor	ax, ax	;@155A6
	mov	word ptr ds:[36E4h], ax	;@155A8
	mov	word ptr ds:[36E0h], ax	;@155AB
	mov	word ptr ds:[36DEh], 0FFFFh	;@155AE
	mov	ax, word ptr ds:[36ECh]	;@155B4
	cmp	ax, 1000h	;@155B7
	jae	@@1	;@155BA
	mov	cl, 4	;@155BC
	shl	ax, cl	;@155BE
	mov	word ptr ds:[36DEh], ax	;@155C0
@@1:	ret	;@155C3
L155C4:	push	es	;@155C4
	les	di, dword ptr ds:[36E4h]	;@155C5
	lea	ax, [di+10h]	;@155C9
	cmp	ax, word ptr ds:[36DEh]	;@155CC
	jae	@@1	;@155D0
	mov	word ptr es:[di], 1	;@155D2
	mov	word ptr es:[di+2], 40h	;@155D7
	mov	word ptr es:[di+4], 1	;@155DD
	mov	word ptr es:[di+6], 0FFh	;@155E3
	mov	word ptr es:[di+8], 0	;@155E9
	mov	word ptr es:[di+0Ah], 1FFFh	;@155EF
	mov	word ptr es:[di+0Ch], ax	;@155F5
	mov	word ptr es:[di+0Eh], ax	;@155F9
	mov	word ptr ds:[36E8h], ax	;@155FD
	pop	es	;@15600
	ret	;@15601
@@1:	jmp	L145F5	;@15602
L15605:	push	es	;@15605
	mov	es, word ptr ds:[36E6h]	;@15606
	mov	ax, word ptr ds:[36E8h]	;@1560A
	mov	di, ax	;@1560D
	add	ax, 3	;@1560F
	jb	@@1	;@15612
	cmp	ax, word ptr ds:[36DEh]	;@15614
	jae	@@1	;@15618
	mov	al, 0FFh	;@1561A
	stosb	;@1561C
	mov	word ptr ds:[36E4h], di	;@1561D
	mov	ax, 0	;@15621
	stosw	;@15624
	pop	es	;@15625
	ret	;@15626
@@1:	jmp	L145F5	;@15627
L1562A:	cmp	byte ptr ds:[370Dh], 0	;@1562A
	je	@@1	;@1562F
	mov	di, 370Dh	;@15631
	mov	si, di	;@15634
	call	L14927	;@15636
	inc	cx	;@15639
	push	es	;@1563A
	mov	es, word ptr ds:[36E6h]	;@1563B
	mov	di, word ptr ds:[36E8h]	;@1563F
	add	cx, di	;@15643
	jb	@@2	;@15645
	cmp	cx, word ptr ds:[36DEh]	;@15647
	jae	@@2	;@1564B
	call	L14938	;@1564D
	pop	es	;@15650
	mov	word ptr ds:[36E8h], di	;@15651
	inc	word ptr ds:[1Fh]	;@15655
@@1:	ret	;@15659
@@2:	jmp	L145F5	;@1565A
L1565D:	mov	si, di	;@1565D
	mov	di, 375Dh	;@1565F
	call	L14927	;@15662
	mov	dx, cx	;@15665
	mov	di, 37ADh	;@15667
	call	L14927	;@1566A
	add	dx, cx	;@1566D
	mov	di, 37FDh	;@1566F
	call	L14927	;@15672
	add	cx, dx	;@15675
	add	cx, 3	;@15677
	mov	es, word ptr ds:[36E6h]	;@1567A
	push	si	;@1567E
	call	L156F6	;@1567F
	pop	di	;@15682
	mov	si, 375Dh	;@15683
	call	L14938	;@15686
	mov	si, 37ADh	;@15689
	call	L14938	;@1568C
	mov	si, 37FDh	;@1568F
	call	L14938	;@15692
	cmp	byte ptr ds:[37ADh], 0	;@15695
	je	@@1	;@1569A
	inc	word ptr ds:[21h]	;@1569C
@@1:	ret	;@156A0
L156A1:	push	es	;@156A1
	push	si	;@156A2
	push	ax	;@156A3
	mov	di, si	;@156A4
	call	L14927	;@156A6
	inc	cx	;@156A9
	inc	cx	;@156AA
	les	di, dword ptr ds:[36E4h]	;@156AB
	mov	si, word ptr es:[di+0Ch]	;@156AF
	push	si	;@156B3
	push	cx	;@156B4
	call	L156F6	;@156B5
	pop	cx	;@156B8
	pop	di	;@156B9
	pop	ax	;@156BA
	pop	si	;@156BB
	cld	;@156BC
	stosb	;@156BD
	call	L14938	;@156BE
	mov	si, word ptr ds:[36E4h]	;@156C1
	mov	word ptr es:[si+0Ch], di	;@156C5
	add	word ptr es:[si+0Eh], cx	;@156C9
	pop	es	;@156CD
	ret	;@156CE
	db	6, 56h, 50h, 8Bh, 0FEh, 0E8h, 50h, 0F2h, 41h, 41h, 0C4h, 3Eh, 0E4h	;@156CF
	db	36h, 26h, 8Bh, 75h, 0Eh, 56h, 0E8h, 11h, 0, '_X^', 0AAh, 0E8h
	db	4Ch, 0F2h, 8Bh, 36h, 0E4h, 36h, 26h, 89h, 7Ch, 0Eh, 7, 0C3h
L156F6:	mov	di, word ptr ds:[36E8h]	;@156F6
	add	word ptr ds:[36E8h], cx	;@156FA
	mov	ax, di	;@156FE
	sub	ax, si	;@15700
	mov	si, di	;@15702
	add	di, cx	;@15704
	jb	@@2	;@15706
	cmp	di, word ptr ds:[36DEh]	;@15708
	jae	@@2	;@1570C
	and	ax, ax	;@1570E
	je	@@1	;@15710
	dec	si	;@15712
	dec	di	;@15713
	push	ds	;@15714
	mov	cx, ax	;@15715
	mov	ax, es	;@15717
	mov	ds, ax	;@15719
	std	;@1571B
	rep movsb	;@1571C
	cld	;@1571E
	pop	ds	;@1571F
@@1:	ret	;@15720
@@2:	jmp	L145F5	;@15721
L15724:	mov	byte ptr ds:[3A0Ah], 0	;@15724
	call	L155C4	;@15729
	call	L153FC	;@1572C
@@1:	call	L154CF	;@1572F
	cmp	ax, 0	;@15732
	je	@@3	;@15735
	call	@@4	;@15737
	jb	@@2	;@1573A
	call	L154CF	;@1573C
	cmp	ax, 0	;@1573F
	je	@@3	;@15742
	cmp	ax, 3	;@15744
	jne	@@2	;@15747
	cmp	byte ptr ds:[36FDh], 3Bh	;@15749
	jne	@@2	;@1574E
	call	L15493	;@15750
	call	L15605	;@15753
	call	L155C4	;@15756
	call	L153FC	;@15759
	jmp	@@1	;@1575C
@@2:	stc	;@1575E
	ret	;@1575F
@@3:	call	L15605	;@15760
	clc	;@15763
	ret	;@15764
@@4:	call	@@9	;@15765
	jb	@@8	;@15768
	call	L154CF	;@1576A
	cmp	ax, 3	;@1576D
	jne	@@5	;@15770
	cmp	byte ptr ds:[36FDh], 2Bh	;@15772
	jne	@@5	;@15777
	call	L15493	;@15779
	jmp	@@4	;@1577C
@@5:	call	@@11	;@1577E
	call	@@14	;@15781
	call	@@18	;@15784
	les	di, dword ptr ds:[36E4h]	;@15787
	mov	di, word ptr ds:[36E8h]	;@1578B
	lds	si, dword ptr ds:[36E4h]	;@1578F
	mov	si, word ptr [si+0Eh]	;@15793
@@6:	push	ss	;@15796
	pop	es	;@15797
	mov	di, 370Dh	;@15798
	call	L14938	;@1579B
	push	si	;@1579E
	push	ss	;@1579F
	pop	ds	;@157A0
	call	@@32	;@157A1
	pop	di	;@157A4
	call	L1565D	;@157A5
	cmp	di, word ptr ds:[36E8h]	;@157A8
	jae	@@7	;@157AC
	mov	ds, word ptr ds:[36E6h]	;@157AE
	mov	si, di	;@157B2
	jmp	@@6	;@157B4
@@7:	mov	ax, ss	;@157B6
	mov	ds, ax	;@157B8
	mov	es, ax	;@157BA
	clc	;@157BC
@@8:	ret	;@157BD
@@9:	call	L154CF	;@157BE
	cmp	ax, 1	;@157C1
	jne	@@10	;@157C4
	mov	word ptr ds:[36FEh], 3A0Ah	;@157C6
	call	L15493	;@157CC
	mov	si, 23h	;@157CF
	mov	di, 3A0Ah	;@157D2
	call	L153DD	;@157D5
	call	@@25	;@157D8
	clc	;@157DB
	ret	;@157DC
@@10:	stc	;@157DD
	ret	;@157DE
@@11:	mov	word ptr ds:[36FEh], 3E0Ch	;@157DF
	call	L154CF	;@157E5
	cmp	ax, 3	;@157E8
	jne	@@12	;@157EB
	cmp	byte ptr ds:[36FDh], 2Ch	;@157ED
	jne	@@12	;@157F2
	call	L15493	;@157F4
@@12:	call	@@23	;@157F7
	cmp	byte ptr ds:[3E0Ch], 0	;@157FA
	jne	@@13	;@157FF
	mov	si, 37h	;@15801
	mov	di, 3E0Ch	;@15804
	call	L1530D	;@15807
	clc	;@1580A
	ret	;@1580B
@@13:	clc	;@1580C
	ret	;@1580D
@@14:	mov	word ptr ds:[3706h], 0	;@1580E
	mov	word ptr ds:[36FEh], 420Ch	;@15814
	call	L154CF	;@1581A
	cmp	ax, 3	;@1581D
	jne	@@15	;@15820
	cmp	byte ptr ds:[36FDh], 2Ch	;@15822
	jne	@@15	;@15827
	call	L15493	;@15829
	mov	word ptr ds:[3706h], 61h	;@1582C
@@15:	call	L154CF	;@15832
	cmp	ax, 1	;@15835
	jne	@@16	;@15838
	call	@@23	;@1583A
	clc	;@1583D
	ret	;@1583E
@@16:	mov	si, word ptr ds:[3706h]	;@1583F
	or	si, si	;@15843
	je	@@17	;@15845
	mov	di, 420Ch	;@15847
	call	L1530D	;@1584A
@@17:	clc	;@1584D
	ret	;@1584E
@@18:	mov	word ptr ds:[3706h], 0	;@1584F
	mov	word ptr ds:[36FEh], 53C2h	;@15855
	call	L154CF	;@1585B
	cmp	ax, 3	;@1585E
	jne	@@19	;@15861
	cmp	byte ptr ds:[36FDh], 2Ch	;@15863
	jne	@@19	;@15868
	call	L15493	;@1586A
	call	@@21	;@1586D
	mov	word ptr ds:[3706h], 3Eh	;@15870
@@19:	call	L154CF	;@15876
	cmp	ax, 1	;@15879
	je	@@20	;@1587C
	mov	si, word ptr ds:[3706h]	;@1587E
	or	si, si	;@15882
	je	@@22	;@15884
	mov	di, 53C2h	;@15886
	call	L1530D	;@15889
	jmp	short @@21	;@1588C
@@20:	call	@@23	;@1588E
@@21:	push	es	;@15891
	les	di, dword ptr ds:[36E4h]	;@15892
	or	word ptr es:[di+2], 20h	;@15896
	pop	es	;@1589B
@@22:	clc	;@1589C
	ret	;@1589D
@@23:	call	L154CF	;@1589E
	cmp	ax, 1	;@158A1
	jne	@@24	;@158A4
	call	L15493	;@158A6
	clc	;@158A9
	ret	;@158AA
@@24:	mov	di, word ptr ds:[36FEh]	;@158AB
	mov	byte ptr [di], 0	;@158AF
	clc	;@158B2
	ret	;@158B3
@@25:	mov	si, 3A0Ah	;@158B4
	call	L15338	;@158B7
	jne	@@26	;@158BA
	call	@@28	;@158BC
	mov	byte ptr ds:[3A0Ah], 0	;@158BF
	ret	;@158C4
@@26:	cmp	byte ptr [si], 0	;@158C5
	je	@@27	;@158C8
	mov	si, 3A0Ah	;@158CA
	mov	di, 370Dh	;@158CD
	call	L1530D	;@158D0
	call	@@31	;@158D3
@@27:	mov	byte ptr ds:[3A0Ah], 0	;@158D6
	ret	;@158DB
@@28:	mov	si, 3A0Ah	;@158DC
	mov	di, 370Dh	;@158DF
	call	L1530D	;@158E2
	mov	dx, 3A0Ah	;@158E5
	mov	di, 36AEh	;@158E8
	xor	cx, cx	;@158EB
	call	far ptr L11310	;@158ED
	jb	@@30	;@158F2
@@29:	push	si	;@158F4
	mov	si, 370Dh	;@158F5
	call	L149AF	;@158F8
	mov	di, si	;@158FB
	mov	si, 36C5h	;@158FD
	call	L1530D	;@15900
	call	@@31	;@15903
	pop	si	;@15906
	jb	@@30	;@15907
	mov	di, 36AEh	;@15909
	call	far ptr L11321	;@1590C
	jae	@@29	;@15911
@@30:	clc	;@15913
	ret	;@15914
@@31:	mov	byte ptr ds:[375Dh], 0	;@15915
	mov	byte ptr ds:[37ADh], 0	;@1591A
	mov	byte ptr ds:[37FDh], 0	;@1591F
	call	L1562A	;@15924
	ret	;@15927
@@32:	mov	si, 3E0Ch	;@15928
	call	@@35	;@1592B
	mov	si, 3E0Ch	;@1592E
	mov	di, 375Dh	;@15931
	mov	bx, 370Dh	;@15934
	call	L153BC	;@15937
	mov	si, 28h	;@1593A
	mov	di, 375Dh	;@1593D
	call	L153DD	;@15940
	mov	si, 375Dh	;@15943
	call	@@38	;@15946
	jne	@@33	;@15949
	mov	byte ptr ds:[375Dh], 0	;@1594B
@@33:	mov	si, 420Ch	;@15950
	call	@@35	;@15953
	mov	si, 420Ch	;@15956
	mov	di, 37ADh	;@15959
	mov	bx, 370Dh	;@1595C
	call	L153BC	;@1595F
	mov	si, 45h	;@15962
	mov	di, 37ADh	;@15965
	call	L153DD	;@15968
	mov	si, 37ADh	;@1596B
	call	@@38	;@1596E
	mov	si, 53C2h	;@15971
	call	@@35	;@15974
	mov	si, 53C2h	;@15977
	mov	di, 37FDh	;@1597A
	mov	bx, 370Dh	;@1597D
	call	L153BC	;@15980
	mov	si, 4Ah	;@15983
	mov	di, 37FDh	;@15986
	call	L153DD	;@15989
	mov	si, 37FDh	;@1598C
	call	@@38	;@1598F
	jne	@@34	;@15992
	mov	byte ptr ds:[37FDh], 0	;@15994
@@34:	ret	;@15999
@@35:	push	si	;@1599A
	call	L1534C	;@1599B
	pop	si	;@1599E
	jne	@@37	;@1599F
	xor	al, al	;@159A1
	call	L1493F	;@159A3
	dec	si	;@159A6
	lodsb	;@159A7
	call	L149A8	;@159A8
	je	@@36	;@159AB
	mov	byte ptr [si], 5Ch	;@159AD
	inc	si	;@159B0
@@36:	mov	byte ptr [si], 2Ah	;@159B1
	inc	si	;@159B4
	mov	byte ptr [si], 0	;@159B5
@@37:	ret	;@159B8
@@38:	push	si	;@159B9
	mov	di, 32h	;@159BA
@@39:	lodsb	;@159BD
	cmp	byte ptr [di], 0	;@159BE
	je	@@40	;@159C1
	call	L1491C	;@159C3
	cmp	al, byte ptr [di]	;@159C6
	jne	@@41	;@159C8
	inc	di	;@159CA
	jmp	@@39	;@159CB
@@40:	and	al, al	;@159CD
	je	@@41	;@159CF
	cmp	al, 2Eh	;@159D1
@@41:	pop	si	;@159D3
	ret	;@159D4
L159D5:	mov	ax, word ptr ds:[36A2h]	;@159D5
	mov	word ptr ds:[36F2h], ax	;@159D8
	mov	ax, word ptr ds:[36A4h]	;@159DB
	mov	word ptr ds:[36F4h], ax	;@159DE
	xor	ax, ax	;@159E1
	mov	word ptr ds:[36F6h], ax	;@159E3
	mov	byte ptr ds:[36FCh], al	;@159E6
	mov	word ptr ds:[36F8h], 3859h	;@159E9
	ret	;@159EF
	db	'TASM.CFG', 0	;@159F0
L159F9:	push	ds	;@159F9
	push	es	;@159FA
	push	di	;@159FB
	push	cs	;@159FC
	push	ds	;@159FD
	pop	es	;@159FE
	pop	ds	;@159FF
	mov	di, 370Dh	;@15A00
	mov	si, 1460h	;@15A03
	call	L14938	;@15A06
	pop	di	;@15A09
	pop	es	;@15A0A
	pop	ds	;@15A0B
	mov	byte ptr ds:[36h], 1	;@15A0C
	call	L15A4E	;@15A11
	je	@@2	;@15A14
	mov	ax, word ptr ds:[36A8h]	;@15A16
	and	ax, ax	;@15A19
	je	@@1	;@15A1B
	push	ds	;@15A1D
	push	es	;@15A1E
	push	di	;@15A1F
	mov	si, word ptr ds:[36A6h]	;@15A20
	mov	ds, ax	;@15A24
	push	ss	;@15A26
	pop	es	;@15A27
	mov	di, 370Dh	;@15A28
	call	L14938	;@15A2B
	push	es	;@15A2E
	pop	ds	;@15A2F
	mov	si, 370Dh	;@15A30
	call	L149AF	;@15A33
	mov	di, si	;@15A36
	push	cs	;@15A38
	pop	ds	;@15A39
	mov	si, 1460h	;@15A3A
	call	L14938	;@15A3D
	pop	di	;@15A40
	pop	es	;@15A41
	pop	ds	;@15A42
	call	L15A4E	;@15A43
	je	@@2	;@15A46
@@1:	mov	byte ptr ds:[36h], 0	;@15A48
@@2:	ret	;@15A4D
L15A4E:	cmp	word ptr ds:[36F8h], 38B9h	;@15A4E
	je	L15AB9	;@15A54
	mov	dx, 370Dh	;@15A56
	xor	al, al	;@15A59
	call	far ptr L112D0	;@15A5B
	jb	@@4	;@15A60
	mov	si, word ptr ds:[36F8h]	;@15A62
	add	word ptr ds:[36F8h], 6	;@15A66
	mov	ax, word ptr ds:[36F6h]	;@15A6B
	mov	word ptr [si], ax	;@15A6E
	and	ax, ax	;@15A70
	je	@@1	;@15A72
	push	bx	;@15A74
	mov	bx, ax	;@15A75
	mov	al, 1	;@15A77
	xor	cx, cx	;@15A79
	xor	dx, dx	;@15A7B
	call	far ptr L11304	;@15A7D
	mov	bx, word ptr ds:[36FAh]	;@15A82
	sub	bx, word ptr ds:[36F2h]	;@15A86
	sub	ax, bx	;@15A8A
	sbb	dx, 0	;@15A8C
	mov	word ptr [si+2], ax	;@15A8F
	mov	word ptr [si+4], dx	;@15A92
	pop	bx	;@15A95
	jmp	short @@2	;@15A96
@@1:	mov	ax, word ptr ds:[36F2h]	;@15A98
	mov	word ptr [si+2], ax	;@15A9B
	mov	ax, word ptr ds:[36F4h]	;@15A9E
	mov	word ptr [si+4], ax	;@15AA1
@@2:	mov	word ptr ds:[36F6h], bx	;@15AA4
	mov	word ptr ds:[36F4h], ds	;@15AA8
	call	L15ACD	;@15AAC
	xor	al, al	;@15AAF
@@3:	ret	;@15AB1
@@4:	cmp	byte ptr ds:[36h], 0	;@15AB2
	jne	@@3	;@15AB7
L15AB9:	push	ds	;@15AB9
	pop	es	;@15ABA
	mov	dx, 742h	;@15ABB
	call	L149E8	;@15ABE
	mov	dx, 370Dh	;@15AC1
	call	L149E0	;@15AC4
	mov	dx, 0F2h	;@15AC7
	jmp	L145F8	;@15ACA
L15ACD:	mov	dx, 460Eh	;@15ACD
	mov	word ptr ds:[36F2h], dx	;@15AD0
	mov	bx, word ptr ds:[36F6h]	;@15AD4
	mov	cx, 200h	;@15AD8
	mov	ax, ds	;@15ADB
	call	far ptr L112EC	;@15ADD
	jb	@@2	;@15AE2
	add	dx, ax	;@15AE4
	mov	word ptr ds:[36FAh], dx	;@15AE6
	cmp	ax, cx	;@15AEA
	je	@@1	;@15AEC
	mov	bx, dx	;@15AEE
	mov	byte ptr [bx], 0	;@15AF0
@@1:	ret	;@15AF3
@@2:	call	far ptr L112E6	;@15AF4
	jmp	L15AB9	;@15AF9
L15AFB:	mov	bx, word ptr ds:[36F6h]	;@15AFB
	and	bx, bx	;@15AFF
	je	@@2	;@15B01
	call	far ptr L112E6	;@15B03
	mov	byte ptr ds:[36h], 0	;@15B08
	mov	si, word ptr ds:[36F8h]	;@15B0D
	sub	si, 6	;@15B11
	mov	word ptr ds:[36F8h], si	;@15B14
	mov	ax, word ptr [si]	;@15B18
	mov	word ptr ds:[36F6h], ax	;@15B1A
	mov	dx, word ptr [si+2]	;@15B1D
	mov	cx, word ptr [si+4]	;@15B20
	and	ax, ax	;@15B23
	je	@@1	;@15B25
	mov	bx, ax	;@15B27
	xor	al, al	;@15B29
	call	far ptr L11304	;@15B2B
	jmp	L15ACD	;@15B30
@@1:	mov	word ptr ds:[36F2h], dx	;@15B32
	mov	word ptr ds:[36F4h], cx	;@15B36
	and	cx, cx	;@15B3A
@@2:	ret	;@15B3C
L15B3D:	push	di	;@15B3D
	push	es	;@15B3E
	push	ds	;@15B3F
	pop	es	;@15B40
	mov	di, 370Dh	;@15B41
@@1:	push	ds	;@15B44
	lds	si, dword ptr ds:[36F2h]	;@15B45
@@2:	cmp	si, 480Eh	;@15B49
	je	@@3	;@15B4D
	mov	al, byte ptr [si]	;@15B4F
	call	L1541B	;@15B51
	je	@@4	;@15B54
	movsb	;@15B56
	jmp	@@2	;@15B57
@@3:	pop	ds	;@15B59
	call	L15ACD	;@15B5A
	jmp	@@1	;@15B5D
@@4:	xor	al, al	;@15B5F
	stosb	;@15B61
	pop	ds	;@15B62
	mov	word ptr ds:[36F2h], si	;@15B63
	pop	es	;@15B67
	pop	di	;@15B68
	ret	;@15B69
L15B6A:	mov	al, byte ptr ds:[36FCh]	;@15B6A
	and	al, al	;@15B6D
	jne	@@2	;@15B6F
@@1:	push	ds	;@15B71
	lds	si, dword ptr ds:[36F2h]	;@15B72
	cmp	si, 480Eh	;@15B76
	je	@@5	;@15B7A
	lodsb	;@15B7C
	pop	ds	;@15B7D
	or	al, al	;@15B7E
	je	@@3	;@15B80
	mov	word ptr ds:[36F2h], si	;@15B82
	cmp	al, 40h	;@15B86
	je	@@4	;@15B88
	ret	;@15B8A
@@2:	mov	byte ptr ds:[36FCh], 0	;@15B8B
	ret	;@15B90
@@3:	push	bx	;@15B91
	push	cx	;@15B92
	push	dx	;@15B93
	call	L15AFB	;@15B94
	pop	dx	;@15B97
	pop	cx	;@15B98
	pop	bx	;@15B99
	jne	L15B6A	;@15B9A
	xor	al, al	;@15B9C
	ret	;@15B9E
@@4:	push	bx	;@15B9F
	push	cx	;@15BA0
	push	dx	;@15BA1
	call	L15B3D	;@15BA2
	call	L15A4E	;@15BA5
	pop	dx	;@15BA8
	pop	cx	;@15BA9
	pop	bx	;@15BAA
	jmp	L15B6A	;@15BAB
@@5:	pop	ds	;@15BAD
	push	bx	;@15BAE
	push	cx	;@15BAF
	push	dx	;@15BB0
	call	L15ACD	;@15BB1
	pop	dx	;@15BB4
	pop	cx	;@15BB5
	pop	bx	;@15BB6
	jmp	@@1	;@15BB7
L15BB9:	mov	al, byte ptr ds:[36FCh]	;@15BB9
	and	al, al	;@15BBC
	je	@@1	;@15BBE
	ret	;@15BC0
@@1:	call	L15B6A	;@15BC1
	mov	byte ptr ds:[36FCh], al	;@15BC4
	ret	;@15BC7
L15BC8:	mov	bx, word ptr cs:[si]	;@15BC8
	mov	cl, byte ptr cs:[si+2]	;@15BCB
	xor	ch, ch	;@15BCF
@@1:	add	si, 3	;@15BD1
	cmp	al, byte ptr cs:[si]	;@15BD4
	je	@@2	;@15BD7
	loop	@@1	;@15BD9
	jmp	bx	;@15BDB
@@2:	mov	bx, word ptr cs:[si+1]	;@15BDD
	clc	;@15BE1
	jmp	bx	;@15BE2
L15BE4:	push	si	;@15BE4
	call	L149E8	;@15BE5
	pop	dx	;@15BE8
	call	L149E0	;@15BE9
	mov	dx, 0F2h	;@15BEC
	call	L149E0	;@15BEF
	stc	;@15BF2
	ret	;@15BF3
L15BF4:	push	es	;@15BF4
	mov	ax, 3518h	;@15BF5
	int	21h	;@15BF8
	mov	word ptr ds:[36AAh], bx	;@15BFA
	mov	word ptr ds:[36ACh], es	;@15BFE
	push	ds	;@15C02
	push	cs	;@15C03
	pop	ds	;@15C04
	mov	dx, 514h	;@15C05
	mov	ax, 2518h	;@15C08
	int	21h	;@15C0B
	cld	;@15C0D
	pop	ds	;@15C0E
	pop	es	;@15C0F
	ret	;@15C10
L15C11:	push	ds	;@15C11
	push	cs	;@15C12
	pop	ds	;@15C13
	mov	dx, 644h	;@15C14
	mov	ax, 2523h	;@15C17
	int	21h	;@15C1A
	cld	;@15C1C
	pop	ds	;@15C1D
	mov	byte ptr ds:[36DBh], 0	;@15C1E
	ret	;@15C23
L15C24:	mov	al, byte ptr ds:[36D9h]	;@15C24
	mov	byte ptr ds:[3708h], al	;@15C27
	push	es	;@15C2A
	call	L15B6A	;@15C2B
	call	L15302	;@15C2E
	mov	byte ptr ds:[3709h], al	;@15C31
	mov	si, 16B6h	;@15C34
	call	L15BC8	;@15C37
	pop	es	;@15C3A
	jb	@@1	;@15C3B
	ret	;@15C3D
@@1:	mov	byte ptr ds:[1Dh], 1	;@15C3E
	jmp	L14600	;@15C43
	db	1, 17h, 18h, 0, 0Fh, 17h, 61h, 17h, 17h, 62h, 1Dh, 17h, 63h, 2Ch	;@15C46
	db	17h, 64h, 32h, 17h, 65h, 37h, 17h, 68h, 3Dh, 17h, 69h, 48h, 17h
	db	6Ah, 4Bh, 17h, 6Bh, 50h, 17h, 6Ch, 97h, 17h, 6Dh, 0B9h, 17h, 6Eh
	db	27h, 18h, 6Fh, 2Dh, 18h, 70h, 44h, 18h, 71h, 50h, 18h, 72h, 55h
	db	18h, 73h, 5Dh, 18h, 74h, 64h, 18h, 76h, 69h, 18h, 77h, 6Bh, 18h
	db	78h, 6Eh, 18h, 7Ah, 73h, 18h, 3Fh, 3Dh, 17h, 0C6h, 6, 0Ah, 37h
	db	0, 0BAh, 0C1h, 6, 0BEh, 8, 37h, 0E9h, 45h, 0FFh, 0BAh, 0DBh, 6
	db	0E8h, 43h, 0EDh, 0F9h, 0C3h, 0B8h, 10h, 0, 0E9h, 9Dh, 1, 0C7h
	db	6, 0FEh, 36h, 0ADh, 37h, 0E8h, 55h, 0F8h, 72h, 1, 0C3h, 0E9h, 7Ch
	db	1, 0B8h, 20h, 0, 0E9h, 88h, 1, 0B0h, 1, 0E9h, 0CDh, 1
L15CC7:	mov	ax, 240h	;@15CC7
	jmp	L15E4A	;@15CCA
	db	0E8h, 5Ch, 0EDh, 0BAh, 5Eh, 7, 0E8h, 12h, 0EDh, 0F9h, 0C3h, 0E9h	;@15CCD
	db	80h, 1, 0B0h, 0, 0E9h, 0B4h, 1, 0E8h, 87h, 0FEh, 32h, 0E4h, 0A3h
	db	0Ah, 37h, 0C7h, 6, 0FEh, 36h, 0ADh, 37h, 8Bh, 0D8h, 0A0h, 0Ah
	db	37h, 0E8h, 0Ch, 0F6h, '<ht', 7, '<st', 12h, 0E9h, 40h, 1, 0E8h
	db	7, 0F8h, 72h, 1Eh, 0C4h, 3Eh, 0E4h, 36h, 26h, 89h, 45h, 0Ah, 0F8h
	db	0C3h, 0E8h, 0F8h, 0F7h, 72h, 0Fh, 0BBh, 40h, 0, 0F7h, 0E3h, 0C4h
	db	3Eh, 0E4h, 36h, 26h, 89h, 45h, 8, 0F8h, 0C3h, 0E9h, 11h, 1, 0E8h
	db	8Fh, 0FEh, 0E8h, 0D5h, 0F5h, '<au', 0Dh, 0E8h, 36h, 0FEh, 0B8h
	db	0, 80h, 0E8h, 10h, 1, 8Ch, 0D8h, 8Eh, 0C0h, 0BEh, 61h, 0, 0BFh
	db	0Ch, 42h, 0E8h, 0C6h, 0F5h, 0F8h, 0C3h
L15D49:	call	L15BB9	;@15D49
	call	L15302	;@15D4C
	cmp	al, 6Ch	;@15D4F
	je	@@3	;@15D51
	cmp	al, 75h	;@15D53
	je	@@4	;@15D55
	cmp	al, 78h	;@15D57
	je	@@5	;@15D59
	cmp	al, 76h	;@15D5B
	je	@@6	;@15D5D
	call	L1550B	;@15D5F
	jae	@@1	;@15D62
	mov	ax, 5	;@15D64
@@1:	and	ax, ax	;@15D67
	jne	@@2	;@15D69
	inc	ax	;@15D6B
@@2:	les	di, dword ptr ds:[36E4h]	;@15D6C
	mov	word ptr es:[di+4], ax	;@15D70
	clc	;@15D74
	ret	;@15D75
@@3:	call	L15B6A	;@15D76
	xor	ah, ah	;@15D79
	mov	word ptr ds:[370Ah], ax	;@15D7B
	mov	ax, 2	;@15D7E
	jmp	L15E4A	;@15D81
@@4:	call	L15B6A	;@15D84
	xor	ah, ah	;@15D87
	mov	word ptr ds:[370Ah], ax	;@15D89
	mov	bx, 0FFFCh	;@15D8C
	xor	ax, ax	;@15D8F
	jmp	L15E4D	;@15D91
@@5:	call	L15B6A	;@15D94
	xor	ah, ah	;@15D97
	mov	word ptr ds:[370Ah], ax	;@15D99
	mov	ax, 1	;@15D9C
	jmp	L15E4A	;@15D9F
@@6:	call	L15B6A	;@15DA2
	call	L1550B	;@15DA5
	jae	@@7	;@15DA8
	mov	ax, 20h	;@15DAA
@@7:	les	di, dword ptr ds:[36E4h]	;@15DAD
	mov	word ptr es:[di+6], ax	;@15DB1
	clc	;@15DB5
	ret	;@15DB6
L15DB7:	mov	ax, 80h	;@15DB7
	jmp	L15E4A	;@15DBA
	db	0E8h, 0F9h, 0FDh, 0E8h, 3Fh, 0F5h, '<pt', 5, 0B8h, 0, 8, 0EBh	;@15DBD
	db	7Eh, 0E8h, 9Bh, 0FDh, 0B8h, 0, 1, 0EBh, 76h, 0BBh, 51h, 0, 0BEh
	db	5Eh, 0, 0B9h, 3, 0, 0E9h, 6Fh, 1, 0B8h, 4, 0, 0EBh, 65h, 0BBh
	db	0FFh, 0FDh, 0B8h, 40h, 0, 0EBh, 60h, 0BBh, 0EFh, 0FFh, 33h, 0C0h
	db	0EBh, 59h, 0B8h, 0, 4, 0EBh, 51h, 0F8h, 0C3h, 0E9h, 0FBh, 0, 0B8h
	db	0, 10h, 0EBh, 47h, 0E8h, 0B3h, 0FDh, 0E8h, 12h, 0F6h, 75h, 5, 0B8h
	db	0, 20h, 0EBh, 3Ah
L15E10:	call	L15B6A	;@15E10
	xor	ah, ah	;@15E13
	mov	word ptr ds:[370Ah], ax	;@15E15
	call	L15302	;@15E18
	cmp	al, 64h	;@15E1B
	je	@@1	;@15E1D
	cmp	al, 69h	;@15E1F
	je	@@2	;@15E21
	cmp	al, 7Ah	;@15E23
	je	@@3	;@15E25
	jmp	short @@4	;@15E27
@@1:	mov	ax, 8	;@15E29
	jmp	short L15E4A	;@15E2C
@@2:	mov	ax, 4008h	;@15E2E
	jmp	short L15E4A	;@15E31
@@3:	mov	ax, 4000h	;@15E33
	jmp	short L15E4A	;@15E36
	db	0BAh, 0, 7, 0BEh, 8, 37h, 0E9h, 0A3h, 0FDh	;@15E38
@@4:	mov	dx, 6C1h	;@15E41
	mov	si, 3708h	;@15E44
	jmp	L15BE4	;@15E47
L15E4A:	mov	bx, 0FFFFh	;@15E4A
L15E4D:	les	di, dword ptr ds:[36E4h]	;@15E4D
	and	word ptr es:[di+2], bx	;@15E51
	or	word ptr es:[di+2], ax	;@15E55
	clc	;@15E59
	ret	;@15E5A
	db	0C7h, 6, 0FEh, 36h, 0ADh, 37h, 0FFh, 36h, 36h, 0, 0E8h, 0E0h, 0F5h	;@15E5B
	db	32h, 0C0h, 0BEh, 0ADh, 37h, 0E8h, 0CFh, 0EAh, 81h, 0FEh, 0ADh
	db	37h, 74h, 8, 8Ah, 44h, 0FFh, 0E8h, 2Ch, 0EBh, 74h, 4, 0C7h, 4
	db	5Ch, 0, 0BEh, 0ADh, '7X<', 0, 75h, 5, 32h, 0C0h, 0E9h, 12h, 0F8h
	db	32h, 0C0h, 0E9h, 3Bh, 0F8h, 50h, 0C6h, 6, 0ADh, 37h, 0, 0C7h, 6
	db	0FEh, 36h, 0ADh, 37h, 0E8h, 0A5h, 0F5h, 58h, 0Ah, 0C0h, 74h, 3Ch
	db	80h, 3Eh, 0ADh, 37h, 0, 74h, 49h, 0E8h, 7, 0FDh, '<=u%', 0E8h
	db	0B1h, 0FCh, 0BEh, 85h, 0, 0BFh, 0ADh, 37h, 0E8h, 56h, 0F4h, 32h
	db	0C0h, 8Bh, 0F7h, 0E8h, 76h, 0EAh, 89h, 36h, 0FEh, 36h, 0E8h, 9Ch
	db	0F5h, 0BEh, 8Ch, 0, 0BFh, 0ADh, 37h, 0E8h, 3Fh, 0F4h, 0EBh, 9
L15EDB:	mov	si, 8Eh	;@15EDB
	mov	di, 37ADh	;@15EDE
	call	L15318	;@15EE1
	mov	si, 37ADh	;@15EE4
	xor	al, al	;@15EE7
	call	L1493F	;@15EE9
	mov	word ptr [si], 0Dh	;@15EEC
	mov	si, 37ADh	;@15EF0
	mov	al, 1	;@15EF3
	jmp	L156A1	;@15EF5
	db	0C3h, 0E8h, 0BDh, 0FCh, 0BEh, 4Fh, 0, '<-t"<+t', 1Bh, 0E8h, 11h	;@15EF8
	db	0F5h, 74h, 9, 0E8h, 0FCh, 0F5h, 'r5#', 0C0h, 74h, 15h, 83h, 0C6h
	db	2, 8Bh, 0DEh, 0BEh, 5Bh, 0, 0B9h, 3, 0, 0EBh, 2Dh, 83h, 0C6h, 2
	db	56h, 0E8h, 41h, 0FCh, 5Eh, 0BFh, 56h, 0, 56h, 0E8h, 88h, 0FCh
	db	0E8h, 0E7h, 0F4h, 74h, 0Dh, 0E8h, 31h, 0FCh, 5Eh, 81h, 0FFh, 59h
	db	0, 74h, 6, 0AAh, 0EBh, 0EAh, 5Eh, 0EBh, 10h, 0BAh, 20h, 7, 0BEh
	db	8, 37h, 0E9h, 95h, 0FCh
L15F4F:	mov	di, 56h	;@15F4F
	rep movsb	;@15F52
	mov	si, bx	;@15F54
	mov	ax, 0Dh	;@15F56
	stosw	;@15F59
	mov	al, 1	;@15F5A
	call	L156A1	;@15F5C
	clc	;@15F5F
	ret	;@15F60
C1459	ends
	end	start
