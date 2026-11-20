	.286
	locals
CODE0	segment byte public 'CODE'
CODE0	ends
DATA	segment byte public 'DATA'
DATA	ends
BSS	segment byte public 'BSS'
BSS	ends
DGROUP	group	DATA,BSS
	public	L03424
	public	L035C9
	public	L035F0
	public	L03BCE
	public	L04A81
	public	L04A95
	public	L05333
	public	L05363
	public	L053C0
	public	L05542
	public	L055AC
	public	L05609
	public	L05625
	public	L0563B
	public	L05656
	public	L056C3
	public	L05702
	public	L0752A
	public	L07533
	public	L0753C
	public	L076DE
	public	L0A7C0
	public	L0EFDE
	public	L0F093
	public	L0F0A1
	public	L0F0D7
	public	L0F372
	public	L0F37A
	public	L0F399
	public	L0F3C5
	extrn	L00000:near
	extrn	L00094:near
	extrn	L000B4:near
	extrn	L000E5:near
	extrn	L001B8:near
	extrn	L00225:near
	extrn	L00263:near
	extrn	L0026A:near
	extrn	L00271:near
	extrn	L00279:near
	extrn	L0028D:near
	extrn	L002A1:near
	extrn	L002C8:near
	extrn	L002EE:near
	extrn	L00319:far
	extrn	L00351:far
	extrn	L003D0:near
	extrn	L003DA:near
	extrn	L003E8:near
	extrn	L0042B:near
	extrn	L00462:near
	extrn	L00494:near
	extrn	L004A1:near
	extrn	L004C7:near
	extrn	L004D3:near
	extrn	L004FF:near
	extrn	L00529:near
	extrn	L00531:near
	extrn	L00575:near
	extrn	L005B9:near
	extrn	L005FD:near
	extrn	L0065F:near
	extrn	L0066E:near
	extrn	L0067F:near
	extrn	L00692:near
	extrn	L006C2:near
	extrn	L006CE:near
	extrn	L006DE:near
	extrn	L006E5:near
	extrn	L006EC:near
	extrn	L006F5:near
	extrn	L00713:near
	extrn	L0072A:near
	extrn	L00752:near
	extrn	L0075E:near
	extrn	L0076E:near
	extrn	L007A1:near
	extrn	L007F7:near
	extrn	L0080F:near
	extrn	L0081F:near
	extrn	L00853:near
	extrn	L00877:near
	extrn	L008AD:near
	extrn	L008C4:near
	extrn	L008ED:near
	extrn	L00905:near
	extrn	L00928:near
	extrn	L00933:near
	extrn	L0094E:near
	extrn	L00958:near
	extrn	L0095C:near
	extrn	L0099B:near
	extrn	L00A11:near
	extrn	L00A29:near
	extrn	L00A81:near
	extrn	L00A95:near
	extrn	L00AAD:near
	extrn	L00AEF:near
	extrn	L00B09:near
	extrn	L00B4C:near
	extrn	L00B56:near
	extrn	L00BF4:near
	extrn	L00C46:near
	extrn	L00C62:near
	extrn	L00CA5:near
	extrn	L00CD9:near
	extrn	L00CE9:near
	extrn	L00D3D:near
	extrn	L00DBC:near
	extrn	L00FC6:near
	extrn	L0109C:near
	extrn	L01151:near
	extrn	L011AE:near
	extrn	L0125C:near
	extrn	L01282:near
	extrn	L0130D:near
	extrn	L01312:near
	extrn	L0132A:near
	extrn	L01357:near
	extrn	L01374:near
	extrn	L0148E:near
	extrn	L014F8:near
	extrn	L0150E:near
	extrn	L0152F:near
	extrn	L0154B:near
	extrn	L0155F:near
	extrn	L01575:near
	extrn	L0157F:near
	extrn	L01589:near
	extrn	L015A1:near
	extrn	L01647:near
	extrn	L016C5:near
	extrn	L016F6:near
	extrn	L017DC:near
	extrn	L0188A:near
	extrn	L018A8:near
	extrn	L018F9:near
	extrn	L01911:near
	extrn	L0192E:near
	extrn	L0199D:near
	extrn	L01B94:near
	extrn	L01B9D:near
	extrn	L01BE5:near
	extrn	L01C23:near
	extrn	L01C52:near
	extrn	L01D39:near
	extrn	L01D70:near
	extrn	L01D75:near
	extrn	L01D7A:near
	extrn	L01D9B:near
	extrn	L01E4F:near
	extrn	L01E75:near
	extrn	L01E8D:near
	extrn	L01EB5:near
	extrn	L01F5A:near
	extrn	L01FCE:near
	extrn	L020DB:near
	extrn	L02622:near
	extrn	L02640:near
	extrn	L0265C:near
	extrn	L026B8:near
	extrn	L02F73:near
	extrn	L02FA3:near
	extrn	L03208:near
	extrn	L0321E:near
	extrn	L0329E:near
	extrn	L0334C:near
	extrn	L0F9B0:byte
	extrn	L0F9E5:far
	extrn	L0FAA6:far
	extrn	L0FB18:far
	extrn	L0FB8D:far
	extrn	L0FC4F:far
	extrn	L0FCE0:far
	extrn	L0FCFE:far
	extrn	L0FD9E:far
	extrn	L0FDA5:far
	extrn	L0FDBE:far
	extrn	L0FF1A:far
	extrn	L0FF43:far
	extrn	L0FFD1:far
	extrn	L0FFFF:far
	extrn	L10007:far
	extrn	L10027:far
	extrn	L1002C:far
	extrn	L10036:far
	extrn	L10060:far
	extrn	L10086:far
	extrn	L100A5:far
	extrn	L100B8:far
	extrn	L100D0:far
	extrn	L100D8:far
	extrn	L100DE:far
	extrn	L1010C:far
	extrn	L1011E:far
	extrn	L10138:far
	extrn	L10152:far
	extrn	L1016C:far
	extrn	L10177:far
	extrn	L1018B:far
	extrn	L101BF:far
	extrn	L101DD:far
	extrn	L101EC:far
	extrn	L101F0:far
	extrn	L10207:far
	extrn	L10216:far
	extrn	L10225:far
	extrn	L1022E:far
	extrn	L10233:far
	extrn	L10238:far
	extrn	L1023D:far
	extrn	L10242:far
	extrn	L11156:far
	extrn	L1119A:far
	extrn	L111AB:far
	extrn	L111FB:far
	extrn	L11293:far
	extrn	L1129C:far
	extrn	L1130A:far
	extrn	L11344:far
	extrn	L1134D:far
	extrn	L113A1:far
	extrn	L1143C:far
	extrn	L1148D:far
	extrn	L11510:far
	extrn	L11570:far
	extrn	L115CF:far
	extrn	L115E0:far
	extrn	L1160D:far
	extrn	L11631:far
	extrn	L1164A:far
	extrn	L1168C:far
	extrn	L11699:far
	extrn	L116B9:far
	extrn	L11751:far
	extrn	L11788:far
	extrn	L11E07:far
	extrn	L11E1C:far
	extrn	L1200E:far
	extrn	L12018:far
	extrn	L12310:far
	extrn	L1233F:far
	extrn	L12358:far
	extrn	L12371:far
	extrn	L1238A:far
	extrn	L12474:far
	extrn	L12488:far
	extrn	L124A7:far
	extrn	L124C0:far
	extrn	L124D3:far
	extrn	L124E8:far
	extrn	L124F8:far
	extrn	L12502:far
	extrn	L12609:far
	extrn	L12613:far
	extrn	L1261D:far
	extrn	L12633:far
	extrn	L12694:far
	extrn	L12708:far
	extrn	L1272B:far
	extrn	L12744:far
	extrn	L12753:far
	extrn	L12778:far
	extrn	L12787:far
	extrn	L12790:far
	extrn	L127BF:far
	extrn	L1281F:far
	extrn	L128AB:far
	extrn	L12907:far
	extrn	L12979:far
	extrn	L12A16:far
	extrn	L12AB6:far
	extrn	L12BD6:far
	extrn	L12C9B:far
	extrn	L12CCA:far
	extrn	L12D51:far
	extrn	L12D6A:far
	extrn	L12E56:far
	extrn	DATA_START:byte

CODE0	segment byte public 'CODE'
	assume	cs:CODE0
L033D6:	mov	ax, word ptr ds:[5046h]	;@033D6
	mov	word ptr ds:[5046h], 0	;@033D9
	call	@@2	;@033DF
	mov	ax, word ptr ds:[5048h]	;@033E2
	mov	word ptr ds:[5048h], 0	;@033E5
	call	@@2	;@033EB
	mov	ax, word ptr ds:[504Ah]	;@033EE
	mov	word ptr ds:[504Ah], 0	;@033F1
@@1:	and	ax, ax	;@033F7
	je	@@3	;@033F9
	mov	es, ax	;@033FB
	push	word ptr es:[0]	;@033FD
	mov	dx, 2	;@03402
	call	far ptr L0FAA6	;@03405
	pop	ax	;@0340A
	jmp	@@1	;@0340B
@@2:	and	ax, ax	;@0340D
	je	@@3	;@0340F
	mov	es, ax	;@03411
	push	word ptr es:[0]	;@03413
	mov	dx, 1	;@03418
	call	far ptr L0FAA6	;@0341B
	pop	ax	;@03420
	jmp	@@2	;@03421
@@3:	ret	;@03423
L03424:	mov	di, word ptr ds:[5196h]	;@03424
	and	di, di	;@03428
	je	@@2	;@0342A
	test	word ptr ds:[5166h], 200h	;@0342C
	je	@@1	;@03432
	mov	cx, 9036h	;@03434
	call	L03208	;@03437
@@1:	call	L03DEC	;@0343A
	jmp	L03424	;@0343D
@@2:	call	L03E95	;@0343F
@@3:	mov	di, word ptr ds:[5162h]	;@03442
	and	di, di	;@03446
	je	@@6	;@03448
	cmp	byte ptr ds:[51AAh], 0	;@0344A
	jne	@@5	;@0344F
	test	word ptr ds:[5166h], 100h	;@03451
	je	@@4	;@03457
	mov	cx, 9035h	;@03459
	call	L03208	;@0345C
@@4:	call	L0400B	;@0345F
	jmp	@@3	;@03462
@@5:	dec	byte ptr ds:[51AAh]	;@03464
	jmp	@@4	;@03468
@@6:	cmp	byte ptr ds:[51A6h], 0	;@0346A
	je	@@7	;@0346F
	test	word ptr ds:[5166h], 400h	;@03471
	je	@@7	;@03477
	mov	cx, 8038h	;@03479
	call	L03208	;@0347C
@@7:	mov	di, word ptr ds:[5194h]	;@0347F
	and	di, di	;@03483
	je	@@8	;@03485
	mov	cx, 104Bh	;@03487
	call	L03208	;@0348A
	call	L0397B	;@0348D
	jmp	@@7	;@03490
@@8:	ret	;@03492
L03493:	test	byte ptr ds:[38D7h], 3	;@03493
	jne	@@1	;@03498
	test	word ptr ds:[38C4h], 4000h	;@0349A
	jne	@@2	;@034A0
@@1:	ret	;@034A2
@@2:	push	si	;@034A3
	mov	si, ax	;@034A4
	jcxz	@@3	;@034A6
	mov	es, cx	;@034A8
	call	L004A1	;@034AA
	call	far ptr L0FCFE	;@034AD
@@3:	mov	di, dx	;@034B2
	mov	bp, bx	;@034B4
	call	far ptr L1233F	;@034B6
	pop	si	;@034BB
	ret	;@034BC
	db	0F6h, 6, 0D7h, 38h, 10h, 75h, 9, 0F7h, 6, 0C4h, 38h, 0, 40h, 75h	;@034BD
	db	0Ch, 0C3h, 0E8h, 0E4h, 0, 0F6h, 6, 0D7h, 38h, 1, 74h, 0EDh, 0C3h
	db	0F6h, 6, 0D7h, 38h, 2, 75h, 0F8h, 0E8h, 0B2h, 0CFh, 56h, 8Bh, 0F0h
	db	52h, 0EBh, 36h
L034E8:	test	byte ptr ds:[38D7h], 10h	;@034E8
	jne	@@2	;@034ED
@@1:	test	word ptr ds:[38C4h], 4000h	;@034EF
	jne	@@4	;@034F5
	ret	;@034F7
@@2:	call	L035B4	;@034F8
	test	byte ptr ds:[38D7h], 1	;@034FB
	je	@@1	;@03500
@@3:	ret	;@03502
@@4:	test	byte ptr ds:[38D7h], 2	;@03503
	jne	@@3	;@03508
	call	L00494	;@0350A
	mov	cx, word ptr ds:[5162h]	;@0350D
	jcxz	@@3	;@03511
	push	si	;@03513
	mov	si, ax	;@03514
	push	dx	;@03516
	mov	ax, es	;@03517
	call	L007F7	;@03519
	je	@@5	;@0351C
	push	es	;@0351E
	mov	es, cx	;@0351F
	call	L0155F	;@03521
	pop	es	;@03524
	push	bx	;@03525
	mov	bx, ax	;@03526
	mov	dx, cx	;@03528
	call	L004A1	;@0352A
	call	far ptr L0FCFE	;@0352D
	pop	bp	;@03532
	pop	di	;@03533
	call	far ptr L12488	;@03534
	pop	si	;@03539
	ret	;@0353A
@@5:	push	es	;@0353B
	mov	es, cx	;@0353C
	call	L0155F	;@0353E
	pop	es	;@03541
	push	bx	;@03542
	mov	bx, ax	;@03543
	mov	dx, cx	;@03545
	call	L004A1	;@03547
	call	far ptr L0FCFE	;@0354A
	pop	bp	;@0354F
	pop	di	;@03550
	call	far ptr L12708	;@03551
	pop	si	;@03556
	ret	;@03557
L03558:	test	byte ptr ds:[38D7h], 10h	;@03558
	jne	@@2	;@0355D
@@1:	test	word ptr ds:[38C4h], 4000h	;@0355F
	jne	@@4	;@03565
	ret	;@03567
@@2:	call	L035B9	;@03568
	test	byte ptr ds:[38D7h], 1	;@0356B
	je	@@1	;@03570
@@3:	ret	;@03572
@@4:	test	byte ptr ds:[38D7h], 2	;@03573
	jne	@@3	;@03578
	call	L00494	;@0357A
	push	si	;@0357D
	mov	si, ax	;@0357E
	push	dx	;@03580
	mov	ax, es	;@03581
	call	L007F7	;@03583
	je	@@5	;@03586
	call	L004A1	;@03588
	call	far ptr L0FCFE	;@0358B
	pop	di	;@03590
	mov	bp, bx	;@03591
	call	far ptr L124A7	;@03593
	pop	si	;@03598
	ret	;@03599
@@5:	call	L004A1	;@0359A
	call	far ptr L0FCFE	;@0359D
	pop	di	;@035A2
	mov	bp, bx	;@035A3
	call	far ptr L1272B	;@035A5
	pop	si	;@035AA
	ret	;@035AB
L035AC:	test	byte ptr ds:[38D7h], 10h	;@035AC
	jne	L035B9	;@035B1
	ret	;@035B3
L035B4:	push	es	;@035B4
	call	L0425C	;@035B5
	pop	es	;@035B8
L035B9:	push	si	;@035B9
	push	es	;@035BA
	push	ax	;@035BB
	push	bx	;@035BC
	mov	ax, es	;@035BD
	call	far ptr L101F0	;@035BF
	pop	bx	;@035C4
	pop	ax	;@035C5
	pop	es	;@035C6
	pop	si	;@035C7
	ret	;@035C8
L035C9:	mov	ax, es	;@035C9
	call	L007F7	;@035CB
	je	@@1	;@035CE
	call	L004A1	;@035D0
	call	far ptr L0FCFE	;@035D3
	mov	bp, bx	;@035D8
	call	far ptr L124C0	;@035DA
	ret	;@035DF
@@1:	call	L004A1	;@035E0
	call	far ptr L0FCFE	;@035E3
	mov	bp, bx	;@035E8
	call	far ptr L12744	;@035EA
	ret	;@035EF
L035F0:	test	byte ptr ds:[38D7h], 10h	;@035F0
	jne	@@1	;@035F5
	ret	;@035F7
@@1:	push	si	;@035F8
	push	es	;@035F9
	push	bx	;@035FA
	push	dx	;@035FB
	call	far ptr L10207	;@035FC
	pop	dx	;@03601
	pop	bx	;@03602
	pop	es	;@03603
	pop	si	;@03604
	ret	;@03605
L03606:	test	byte ptr ds:[38D7h], 1	;@03606
	jne	@@1	;@0360B
	test	word ptr ds:[38C4h], 4000h	;@0360D
	jne	@@2	;@03613
@@1:	ret	;@03615
@@2:	push	si	;@03616
	mov	si, ax	;@03617
	mov	di, dx	;@03619
	xchg	bx, bp	;@0361B
	call	L04A95	;@0361D
	mov	ax, bx	;@03620
	mov	dx, cx	;@03622
	mov	bx, bp	;@03624
	call	far ptr L12907	;@03626
	pop	si	;@0362B
	ret	;@0362C
L0362D:	test	byte ptr ds:[38D7h], 10h	;@0362D
	jne	L03635	;@03632
	ret	;@03634
L03635:	push	si	;@03635
	push	es	;@03636
	mov	al, 3Dh	;@03637
	call	far ptr L1016C	;@03639
	mov	al, 20h	;@0363E
	call	far ptr L1016C	;@03640
	pop	es	;@03645
	call	L053C0	;@03646
	pop	si	;@03649
	ret	;@0364A
L0364B:	test	byte ptr ds:[38D7h], 10h	;@0364B
	jne	@@1	;@03650
	ret	;@03652
@@1:	push	si	;@03653
	push	es	;@03654
	push	bx	;@03655
	push	cx	;@03656
	mov	al, 3Dh	;@03657
	call	far ptr L1016C	;@03659
	mov	al, 20h	;@0365E
	call	far ptr L1016C	;@03660
	pop	cx	;@03665
	pop	di	;@03666
	push	di	;@03667
	push	cx	;@03668
	push	ss	;@03669
	pop	es	;@0366A
	call	far ptr L10177	;@0366B
	pop	cx	;@03670
	pop	bx	;@03671
	pop	es	;@03672
	pop	si	;@03673
	ret	;@03674
L03675:	mov	cx, word ptr ds:[5048h]	;@03675
	jcxz	@@2	;@03679
@@1:	mov	es, cx	;@0367B
	mov	cx, word ptr es:[0]	;@0367D
	and	cx, cx	;@03682
	jne	@@1	;@03684
	mov	ax, word ptr es:[4]	;@03686
	mov	dx, word ptr es:[6]	;@0368A
	ret	;@0368F
@@2:	mov	ax, word ptr ds:[5154h]	;@03690
	mov	dx, word ptr ds:[5156h]	;@03693
	ret	;@03697
L03698:	xor	ax, ax	;@03698
	mov	byte ptr ds:[5150h], al	;@0369A
	mov	word ptr ds:[504Eh], ax	;@0369D
	ret	;@036A0
L036A1:	mov	ax, word ptr ds:[5154h]	;@036A1
	mov	dx, word ptr ds:[5156h]	;@036A4
	add	ax, word ptr ds:[504Eh]	;@036A8
	adc	dx, 0	;@036AC
	ret	;@036AF
L036B0:	mov	cx, word ptr ds:[504Eh]	;@036B0
	jcxz	L03727	;@036B4
	mov	ax, word ptr ds:[5188h]	;@036B6
	and	ax, ax	;@036B9
	je	L03733	;@036BB
	test	byte ptr ds:[38D7h], 10h	;@036BD
	je	L03708	;@036C2
	push	ax	;@036C4
	call	L0425C	;@036C5
	pop	ax	;@036C8
	test	byte ptr ds:[38D7h], 1	;@036C9
	jne	L0371E	;@036CE
	jmp	short L03708	;@036D0
L036D2:	mov	cx, word ptr ds:[504Eh]	;@036D2
	jcxz	L03727	;@036D6
	cmp	word ptr ds:[5194h], 0	;@036D8
	jne	L03728	;@036DD
	mov	ax, word ptr ds:[5188h]	;@036DF
	and	ax, ax	;@036E2
	je	L03733	;@036E4
	test	byte ptr ds:[38D7h], 10h	;@036E6
	je	@@1	;@036EB
	push	ax	;@036ED
	call	L0425C	;@036EE
	pop	ax	;@036F1
	test	byte ptr ds:[38D7h], 1	;@036F2
	jne	L0371E	;@036F7
@@1:	mov	es, word ptr ds:[5162h]	;@036F9
	call	L006DE	;@036FD
	test	word ptr ds:[38C4h], 8	;@03700
	jne	L03747	;@03706
L03708:	push	si	;@03708
	mov	si, 5050h	;@03709
	mov	cx, word ptr ds:[504Eh]	;@0370C
	mov	bx, word ptr ds:[5154h]	;@03710
	mov	dx, word ptr ds:[5156h]	;@03714
	call	far ptr L12A16	;@03718
	pop	si	;@0371D
L0371E:	mov	ax, word ptr ds:[504Eh]	;@0371E
	add	word ptr ds:[5154h], ax	;@03721
	jb	L03739	;@03725
L03727:	ret	;@03727
L03728:	and	byte ptr ds:[38D8h], 0FEh	;@03728
	mov	cx, 49h	;@0372D
	jmp	L03208	;@03730
L03733:	mov	cx, 30h	;@03733
	jmp	L03208	;@03736
L03739:	inc	word ptr ds:[5156h]	;@03739
	je	@@1	;@0373D
	call	L04297	;@0373F
	jne	L03727	;@03742
@@1:	jmp	L042AD	;@03744
L03747:	test	byte ptr ds:[38D7h], 3	;@03747
	jne	L03708	;@0374C
	xor	cx, cx	;@0374E
	cmp	word ptr ds:[5194h], cx	;@03750
	jne	L03708	;@03754
	cmp	word ptr ds:[5048h], cx	;@03756
	jne	L03708	;@0375A
	cmp	byte ptr ds:[51A9h], cl	;@0375C
	mov	byte ptr ds:[51A9h], cl	;@03760
	jne	L03708	;@03764
	mov	dx, word ptr ds:[515Eh]	;@03766
	mov	ax, word ptr ds:[5152h]	;@0376A
	push	si	;@0376D
	call	far ptr L11699	;@0376E
	pop	si	;@03773
	mov	dx, cx	;@03774
	push	ax	;@03776
	mov	es, word ptr ds:[5162h]	;@03777
	call	L0155F	;@0377B
	mov	bp, cx	;@0377E
	mov	cx, ax	;@03780
	pop	di	;@03782
	mov	ax, dx	;@03783
	mov	bx, word ptr ds:[5154h]	;@03785
	mov	dx, word ptr ds:[5156h]	;@03789
	push	si	;@0378D
	call	far ptr L1238A	;@0378E
	pop	si	;@03793
	mov	ax, word ptr ds:[5188h]	;@03794
	jmp	L03708	;@03797
L0379A:	mov	ax, word ptr ds:[5188h]	;@0379A
	and	ax, ax	;@0379D
	je	@@1	;@0379F
	mov	bx, word ptr ds:[5154h]	;@037A1
	mov	dx, word ptr ds:[5156h]	;@037A5
	push	si	;@037A9
	call	far ptr L12AB6	;@037AA
	pop	si	;@037AF
@@1:	ret	;@037B0
L037B1:	push	es	;@037B1
	pop	ds	;@037B2
	push	ss	;@037B3
	pop	es	;@037B4
	mov	si, di	;@037B5
	mov	di, 5050h	;@037B7
	mov	bx, di	;@037BA
	push	cx	;@037BC
	rep movsb	;@037BD
	pop	cx	;@037BF
	push	ss	;@037C0
	pop	ds	;@037C1
	mov	word ptr ds:[504Eh], cx	;@037C2
	test	byte ptr ds:[38D7h], 10h	;@037C6
	je	@@1	;@037CB
	mov	ax, cx	;@037CD
	call	L0427E	;@037CF
@@1:	jmp	L036B0	;@037D2
L037D5:	cmp	word ptr ds:[5188h], 0	;@037D5
	je	@@4	;@037DA
	test	byte ptr ds:[38D7h], 10h	;@037DC
	jne	@@2	;@037E1
@@1:	push	si	;@037E3
	mov	si, ax	;@037E4
	mov	ax, word ptr ds:[5188h]	;@037E6
	call	far ptr L12BD6	;@037E9
	pop	si	;@037EE
	ret	;@037EF
@@2:	sub	bx, word ptr ds:[5154h]	;@037F0
	sbb	dx, word ptr ds:[5156h]	;@037F4
	or	bx, dx	;@037F8
	mov	al, 2	;@037FA
	jne	@@3	;@037FC
	and	cl, 1Ch	;@037FE
	mov	al, 5	;@03801
	je	@@3	;@03803
	sub	cl, 4	;@03805
	mov	al, 1	;@03808
	je	@@3	;@0380A
	sub	cl, 4	;@0380C
	mov	al, 4	;@0380F
	je	@@3	;@03811
	sub	cl, 4	;@03813
	mov	al, 3	;@03816
	je	@@3	;@03818
	sub	cl, 4	;@0381A
	mov	al, 6	;@0381D
	je	@@3	;@0381F
	sub	cl, 4	;@03821
	mov	al, 1	;@03824
	je	@@3	;@03826
	mov	al, 3	;@03828
@@3:	mov	byte ptr ds:[5150h], al	;@0382A
	test	byte ptr ds:[38D7h], 1	;@0382D
	je	@@1	;@03832
	ret	;@03834
@@4:	mov	cx, 30h	;@03835
	jmp	L03208	;@03838
L0383B:	test	byte ptr ds:[38D7h], 3	;@0383B
	jne	L03865	;@03840
	push	si	;@03842
	push	cx	;@03843
	and	cl, cl	;@03844
	jne	@@1	;@03846
	xor	al, al	;@03848
	jmp	short L0385E	;@0384A
@@1:	push	ax	;@0384C
	mov	es, bx	;@0384D
L0384F:	pop	bx	;@0384F
	call	L0199D	;@03850
	mov	si, ax	;@03853
	mov	es, di	;@03855
	call	L0199D	;@03857
	mov	di, ax	;@0385A
	mov	al, 0C1h	;@0385C
L0385E:	call	far ptr L12753	;@0385E
	pop	cx	;@03863
	pop	si	;@03864
L03865:	ret	;@03865
L03866:	test	byte ptr ds:[38D7h], 1	;@03866
	jne	@@1	;@0386B
	push	cx	;@0386D
	push	si	;@0386E
	mov	cl, 44h	;@0386F
	mov	si, ax	;@03871
	mov	di, ax	;@03873
	xor	ch, ch	;@03875
	jmp	short L038B0	;@03877
@@1:	ret	;@03879
L0387A:	test	byte ptr ds:[38D7h], 10h	;@0387A
	jne	L038D5	;@0387F
L03881:	push	cx	;@03881
	push	si	;@03882
	mov	cl, al	;@03883
	mov	es, bx	;@03885
L03887:	call	L0199D	;@03887
	mov	si, ax	;@0388A
	mov	es, di	;@0388C
	call	L0199D	;@0388E
	mov	di, ax	;@03891
	xor	ch, ch	;@03893
	mov	bx, cx	;@03895
	shl	bx, 1	;@03897
	cmp	dh, 2	;@03899
	je	@@1	;@0389C
	add	bx, 40h	;@0389E
	test	word ptr ds:[38C4h], 100h	;@038A1
	je	@@1	;@038A7
	add	bx, 40h	;@038A9
@@1:	mov	cx, word ptr [bx+1AD6h]	;@038AC
L038B0:	xor	ax, ax	;@038B0
	mov	bx, word ptr ds:[5154h]	;@038B2
	mov	dx, word ptr ds:[5156h]	;@038B6
	add	bx, word ptr ds:[504Eh]	;@038BA
	adc	dx, ax	;@038BE
	add	bl, ch	;@038C0
	adc	bh, al	;@038C2
	adc	dx, ax	;@038C4
	mov	ax, word ptr ds:[5188h]	;@038C6
	and	ax, ax	;@038C9
	je	L038F0	;@038CB
	call	far ptr L12BD6	;@038CD
	pop	si	;@038D2
	pop	cx	;@038D3
	ret	;@038D4
L038D5:	push	ax	;@038D5
	and	al, 7	;@038D6
	mov	byte ptr ds:[5150h], al	;@038D8
	mov	ax, di	;@038DB
	call	L0072A	;@038DD
	pop	ax	;@038E0
	je	@@1	;@038E1
	or	byte ptr ds:[5150h], 8	;@038E3
@@1:	test	byte ptr ds:[38D7h], 1	;@038E8
	je	L03881	;@038ED
	ret	;@038EF
L038F0:	mov	cx, 30h	;@038F0
	call	L03208	;@038F3
	pop	si	;@038F6
	pop	cx	;@038F7
	ret	;@038F8
L038F9:	push	si	;@038F9
	push	bx	;@038FA
	mov	ax, word ptr ds:[5188h]	;@038FB
	mov	bx, word ptr ds:[5154h]	;@038FE
	mov	dx, word ptr ds:[5156h]	;@03902
	call	far ptr L128AB	;@03906
	pop	bx	;@0390B
	pop	si	;@0390C
L0390D:	push	si	;@0390D
	mov	dx, ax	;@0390E
	mov	ax, 1	;@03910
	mov	cx, ax	;@03913
	call	far ptr L0FB18	;@03915
	mov	es, ax	;@0391A
	mov	cx, word ptr ds:[504Ch]	;@0391C
	mov	word ptr es:[0], cx	;@03920
	mov	word ptr ds:[504Ch], ax	;@03925
	mov	ax, word ptr ds:[5188h]	;@03928
	mov	word ptr es:[2], ax	;@0392B
	mov	ax, word ptr ds:[5154h]	;@0392F
	mov	word ptr es:[4], ax	;@03932
	mov	ax, word ptr ds:[5156h]	;@03936
	mov	word ptr es:[6], ax	;@03939
	mov	ax, word ptr ds:[518Eh]	;@0393D
	mov	word ptr es:[8], ax	;@03940
	mov	ax, word ptr ds:[5190h]	;@03944
	mov	word ptr es:[0Ah], ax	;@03947
	mov	al, byte ptr ds:[51A1h]	;@0394B
	mov	byte ptr es:[0Ch], al	;@0394E
	mov	byte ptr ds:[51A1h], bl	;@03952
	mov	word ptr ds:[5188h], dx	;@03956
	xor	ax, ax	;@0395A
	mov	word ptr ds:[518Eh], ax	;@0395C
	mov	word ptr ds:[5190h], ax	;@0395F
	mov	ax, word ptr ds:[5154h]	;@03962
	mov	word ptr ds:[518Ah], ax	;@03965
	mov	ax, word ptr ds:[5156h]	;@03968
	mov	word ptr ds:[518Ch], ax	;@0396B
	pop	si	;@0396E
	test	byte ptr ds:[38D7h], 10h	;@0396F
	jne	@@1	;@03974
	ret	;@03976
@@1:	jmp	L0425C	;@03977
L0397A:	ret	;@0397A
L0397B:	mov	cx, word ptr ds:[504Ch]	;@0397B
	jcxz	L0397A	;@0397F
	test	byte ptr ds:[38D7h], 1	;@03981
	je	@@2	;@03986
	push	word ptr ds:[5154h]	;@03988
	push	word ptr ds:[5156h]	;@0398C
	cmp	byte ptr ds:[51A1h], 0	;@03990
	je	@@1	;@03995
	mov	ax, word ptr ds:[518Eh]	;@03997
	add	word ptr ds:[5154h], ax	;@0399A
	mov	ax, word ptr ds:[5190h]	;@0399E
	add	word ptr ds:[5156h], ax	;@039A1
@@1:	call	L0425C	;@039A5
	pop	word ptr ds:[5156h]	;@039A8
	pop	word ptr ds:[5154h]	;@039AC
@@2:	mov	bx, word ptr ds:[5154h]	;@039B0
	mov	dx, word ptr ds:[5156h]	;@039B4
	mov	ax, word ptr ds:[5188h]	;@039B8
	push	si	;@039BB
	mov	si, bx	;@039BC
	mov	di, dx	;@039BE
	call	far ptr L12790	;@039C0
	pop	si	;@039C5
	mov	es, word ptr ds:[504Ch]	;@039C6
	mov	ax, word ptr es:[0]	;@039CA
	mov	word ptr ds:[504Ch], ax	;@039CE
	and	ax, ax	;@039D1
	jne	@@6	;@039D3
	test	byte ptr ds:[38D7h], 1	;@039D5
	jne	@@5	;@039DA
	test	word ptr ds:[38C4h], 4000h	;@039DC
	je	@@5	;@039E2
	push	es	;@039E4
	push	si	;@039E5
	mov	es, word ptr ds:[5194h]	;@039E6
	call	L00CD9	;@039EA
	call	L0321E	;@039ED
	push	bx	;@039F0
	mov	es, word ptr ds:[5194h]	;@039F1
	push	es	;@039F5
	call	L004A1	;@039F6
	call	far ptr L0FCFE	;@039F9
	mov	bp, bx	;@039FE
	mov	si, word ptr ds:[518Eh]	;@03A00
	mov	di, word ptr ds:[5190h]	;@03A04
	cmp	byte ptr ds:[51A1h], 0	;@03A08
	je	@@3	;@03A0D
	call	far ptr L12371	;@03A0F
	jmp	short @@4	;@03A14
@@3:	call	far ptr L12358	;@03A16
@@4:	pop	es	;@03A1B
	pop	bx	;@03A1C
	call	L035C9	;@03A1D
	pop	si	;@03A20
	pop	es	;@03A21
	xor	ax, ax	;@03A22
@@5:	mov	word ptr ds:[5194h], ax	;@03A24
@@6:	mov	ax, word ptr es:[2]	;@03A27
	mov	word ptr ds:[5188h], ax	;@03A2B
	mov	al, byte ptr es:[0Ch]	;@03A2E
	mov	byte ptr ds:[51A1h], al	;@03A32
	and	al, al	;@03A35
	jne	@@7	;@03A37
	mov	ax, word ptr es:[4]	;@03A39
	sub	ax, word ptr es:[8]	;@03A3D
	mov	word ptr ds:[518Ah], ax	;@03A42
	mov	ax, word ptr es:[6]	;@03A45
	sbb	ax, word ptr es:[0Ah]	;@03A49
	mov	word ptr ds:[518Ch], ax	;@03A4E
	jmp	short @@8	;@03A51
@@7:	mov	ax, word ptr es:[4]	;@03A53
	mov	word ptr ds:[518Ah], ax	;@03A57
	mov	ax, word ptr es:[6]	;@03A5A
	mov	word ptr ds:[518Ch], ax	;@03A5E
@@8:	mov	ax, word ptr es:[4]	;@03A61
	mov	word ptr ds:[5154h], ax	;@03A65
	mov	ax, word ptr es:[6]	;@03A68
	mov	word ptr ds:[5156h], ax	;@03A6C
	cmp	word ptr ds:[5194h], 0	;@03A6F
	je	@@9	;@03A74
	mov	ax, word ptr ds:[518Eh]	;@03A76
	add	word ptr ds:[5154h], ax	;@03A79
	mov	ax, word ptr ds:[5190h]	;@03A7D
	adc	word ptr ds:[5156h], ax	;@03A80
	jae	@@9	;@03A84
	mov	cx, 5Eh	;@03A86
	call	L03208	;@03A89
@@9:	mov	ax, word ptr es:[8]	;@03A8C
	mov	word ptr ds:[518Eh], ax	;@03A90
	mov	ax, word ptr es:[0Ah]	;@03A93
	mov	word ptr ds:[5190h], ax	;@03A97
	mov	ax, es	;@03A9A
	mov	dx, 1	;@03A9C
	call	far ptr L0FAA6	;@03A9F
L03AA4:	mov	ax, word ptr ds:[5154h]	;@03AA4
	mov	dx, word ptr ds:[5156h]	;@03AA7
	sub	ax, word ptr ds:[518Ah]	;@03AAB
	sbb	dx, word ptr ds:[518Ch]	;@03AAF
	mov	cx, word ptr ds:[518Eh]	;@03AB3
	sub	cx, ax	;@03AB7
	mov	cx, word ptr ds:[5190h]	;@03AB9
	sbb	cx, dx	;@03ABD
	jae	@@1	;@03ABF
	mov	word ptr ds:[518Eh], ax	;@03AC1
	mov	word ptr ds:[5190h], dx	;@03AC4
@@1:	cmp	byte ptr ds:[51A1h], 0	;@03AC8
	jne	@@2	;@03ACD
	ret	;@03ACF
@@2:	mov	ax, word ptr ds:[518Ah]	;@03AD0
	mov	dx, word ptr ds:[518Ch]	;@03AD3
	mov	bx, word ptr ds:[5154h]	;@03AD7
	mov	dx, word ptr ds:[5156h]	;@03ADB
	mov	ax, word ptr ds:[5188h]	;@03ADF
	push	si	;@03AE2
	mov	si, bx	;@03AE3
	mov	di, dx	;@03AE5
	call	far ptr L12790	;@03AE7
	pop	si	;@03AEC
	mov	ax, word ptr ds:[518Ah]	;@03AED
	mov	word ptr ds:[5154h], ax	;@03AF0
	mov	ax, word ptr ds:[518Ch]	;@03AF3
	mov	word ptr ds:[5156h], ax	;@03AF6
	ret	;@03AF9
L03AFA:	test	byte ptr ds:[38D7h], 3	;@03AFA
	jne	@@1	;@03AFF
	push	si	;@03B01
	call	far ptr L12609	;@03B02
	pop	si	;@03B07
@@1:	ret	;@03B08
L03B09:	test	byte ptr ds:[38D7h], 3	;@03B09
	jne	@@1	;@03B0E
	mov	ax, cx	;@03B10
	call	far ptr L0FB8D	;@03B12
	push	si	;@03B17
	mov	si, bx	;@03B18
	push	cx	;@03B1A
	rep movsb	;@03B1B
	pop	cx	;@03B1D
	call	far ptr L12613	;@03B1E
	pop	si	;@03B23
@@1:	ret	;@03B24
L03B25:	test	byte ptr ds:[38D7h], 3	;@03B25
	jne	@@1	;@03B2A
	push	si	;@03B2C
	call	far ptr L12474	;@03B2D
	pop	si	;@03B32
@@1:	ret	;@03B33
L03B34:	test	byte ptr ds:[38D7h], 3	;@03B34
	jne	@@1	;@03B39
	push	si	;@03B3B
	call	far ptr L124F8	;@03B3C
	pop	si	;@03B41
@@1:	ret	;@03B42
L03B43:	test	byte ptr ds:[38D7h], 3	;@03B43
	jne	@@1	;@03B48
	push	si	;@03B4A
	mov	ax, word ptr ds:[5188h]	;@03B4B
	mov	bx, word ptr ds:[5154h]	;@03B4E
	mov	dx, word ptr ds:[5156h]	;@03B52
	call	far ptr L124D3	;@03B56
	pop	si	;@03B5B
@@1:	ret	;@03B5C
L03B5D:	test	byte ptr ds:[38D7h], 3	;@03B5D
	jne	@@1	;@03B62
	push	si	;@03B64
	mov	bx, word ptr ds:[5154h]	;@03B65
	mov	dx, word ptr ds:[5156h]	;@03B69
	call	far ptr L124E8	;@03B6D
	pop	si	;@03B72
@@1:	ret	;@03B73
L03B74:	test	byte ptr ds:[38D7h], 3	;@03B74
	jne	@@1	;@03B79
	push	si	;@03B7B
	push	ax	;@03B7C
	push	dx	;@03B7D
	push	cx	;@03B7E
	push	di	;@03B7F
	call	L004A1	;@03B80
	mov	bp, bx	;@03B83
	call	far ptr L0FCFE	;@03B85
	pop	di	;@03B8A
	pop	dx	;@03B8B
	mov	ch, dh	;@03B8C
	push	ax	;@03B8E
	push	cx	;@03B8F
	mov	es, di	;@03B90
	call	L0155F	;@03B92
	mov	dx, cx	;@03B95
	mov	bx, ax	;@03B97
	pop	cx	;@03B99
	pop	ax	;@03B9A
	pop	di	;@03B9B
	pop	si	;@03B9C
	call	far ptr L12488	;@03B9D
	pop	si	;@03BA2
@@1:	ret	;@03BA3
L03BA4:	test	byte ptr ds:[38D7h], 3	;@03BA4
	jne	@@1	;@03BA9
	mov	cx, word ptr ds:[5162h]	;@03BAB
	jcxz	@@1	;@03BAF
	push	ax	;@03BB1
	mov	es, cx	;@03BB2
	call	L0155F	;@03BB4
	mov	bp, cx	;@03BB7
	mov	cx, ax	;@03BB9
	pop	di	;@03BBB
	mov	ax, dx	;@03BBC
	mov	bx, word ptr ds:[5154h]	;@03BBE
	mov	dx, word ptr ds:[5156h]	;@03BC2
	push	si	;@03BC6
	call	far ptr L12502	;@03BC7
	pop	si	;@03BCC
@@1:	ret	;@03BCD
L03BCE:	test	byte ptr ds:[38D7h], 3	;@03BCE
	jne	@@1	;@03BD3
	push	si	;@03BD5
	call	far ptr L1261D	;@03BD6
	pop	si	;@03BDB
@@1:	ret	;@03BDC
L03BDD:	push	si	;@03BDD
	mov	si, ax	;@03BDE
	mov	di, cx	;@03BE0
	mov	bx, word ptr ds:[5154h]	;@03BE2
	mov	dx, word ptr ds:[5156h]	;@03BE6
	mov	ax, word ptr ds:[5188h]	;@03BEA
	and	ax, ax	;@03BED
	jne	@@1	;@03BEF
	mov	cx, 30h	;@03BF1
	call	L03208	;@03BF4
	jmp	short @@4	;@03BF7
@@1:	push	si	;@03BF9
	push	di	;@03BFA
	test	byte ptr ds:[38D7h], 10h	;@03BFB
	je	@@2	;@03C00
	push	ax	;@03C02
	push	bx	;@03C03
	push	dx	;@03C04
	push	si	;@03C05
	push	di	;@03C06
	call	L0425C	;@03C07
	pop	dx	;@03C0A
	pop	ax	;@03C0B
	push	ax	;@03C0C
	push	dx	;@03C0D
	call	far ptr L101BF	;@03C0E
	pop	di	;@03C13
	pop	si	;@03C14
	pop	dx	;@03C15
	pop	bx	;@03C16
	pop	cx	;@03C17
	mov	ax, 0FFFFh	;@03C18
	test	byte ptr ds:[38D7h], 1	;@03C1B
	jne	@@3	;@03C20
	mov	ax, cx	;@03C22
@@2:	call	far ptr L1281F	;@03C24
@@3:	pop	di	;@03C29
	pop	si	;@03C2A
	mov	bx, ax	;@03C2B
	mov	ax, 1	;@03C2D
	mov	cx, ax	;@03C30
	call	far ptr L0FB18	;@03C32
	mov	es, ax	;@03C37
	mov	cx, word ptr ds:[5048h]	;@03C39
	mov	word ptr es:[0], cx	;@03C3D
	mov	word ptr ds:[5048h], ax	;@03C42
	mov	word ptr es:[8], si	;@03C45
	mov	word ptr es:[0Ah], di	;@03C4A
	mov	ax, word ptr ds:[5188h]	;@03C4F
	mov	word ptr es:[2], ax	;@03C52
	mov	ax, word ptr ds:[5154h]	;@03C56
	mov	word ptr es:[4], ax	;@03C59
	mov	ax, word ptr ds:[5156h]	;@03C5D
	mov	word ptr es:[6], ax	;@03C60
	mov	word ptr ds:[5188h], bx	;@03C64
	xor	ax, ax	;@03C68
	mov	word ptr ds:[5154h], ax	;@03C6A
	mov	word ptr ds:[5156h], ax	;@03C6D
@@4:	pop	si	;@03C70
	ret	;@03C71
L03C72:	push	si	;@03C72
	cmp	word ptr ds:[5188h], 0	;@03C73
	jne	@@1	;@03C78
	mov	cx, 30h	;@03C7A
	call	L03208	;@03C7D
	pop	si	;@03C80
	ret	;@03C81
@@1:	test	byte ptr ds:[38D7h], 10h	;@03C82
	je	@@2	;@03C87
	call	far ptr L101DD	;@03C89
@@2:	mov	cx, word ptr ds:[5048h]	;@03C8E
	jcxz	@@6	;@03C92
	mov	es, cx	;@03C94
	mov	ax, word ptr es:[0]	;@03C96
	mov	word ptr ds:[5048h], ax	;@03C9A
	mov	ax, word ptr es:[2]	;@03C9D
	mov	word ptr ds:[5188h], ax	;@03CA1
	mov	bx, word ptr es:[8]	;@03CA4
	mov	cx, word ptr es:[0Ah]	;@03CA9
	mov	si, word ptr ds:[5154h]	;@03CAE
	mov	di, word ptr ds:[5156h]	;@03CB2
	call	L04A95	;@03CB6
	jb	@@3	;@03CB9
	and	cx, cx	;@03CBB
	jne	@@4	;@03CBD
	add	bx, word ptr es:[4]	;@03CBF
	mov	cx, word ptr es:[6]	;@03CC4
	jae	@@5	;@03CC9
	inc	cx	;@03CCB
	je	@@3	;@03CCC
	call	L04297	;@03CCE
	jne	@@5	;@03CD1
@@3:	push	bx	;@03CD3
	push	cx	;@03CD4
	call	L042AD	;@03CD5
	pop	cx	;@03CD8
	pop	bx	;@03CD9
	jmp	short @@5	;@03CDA
@@4:	add	bx, word ptr es:[4]	;@03CDC
	adc	cx, word ptr es:[6]	;@03CE1
	jb	@@3	;@03CE6
	call	L04297	;@03CE8
	je	@@3	;@03CEB
@@5:	mov	word ptr ds:[5154h], bx	;@03CED
	mov	word ptr ds:[5156h], cx	;@03CF1
	mov	ax, es	;@03CF5
	mov	dx, 1	;@03CF7
	call	far ptr L0FAA6	;@03CFA
	jmp	short @@7	;@03CFF
@@6:	mov	ax, cx	;@03D01
	mov	word ptr ds:[5154h], ax	;@03D03
	mov	word ptr ds:[5156h], ax	;@03D06
	mov	word ptr ds:[5188h], ax	;@03D09
@@7:	pop	si	;@03D0C
	ret	;@03D0D
L03D0E:	mov	bx, ax	;@03D0E
	mov	ax, word ptr ds:[515Eh]	;@03D10
	mov	word ptr ds:[516Ch], ax	;@03D13
	mov	ax, word ptr ds:[5152h]	;@03D16
	mov	word ptr ds:[516Eh], ax	;@03D19
	mov	cx, word ptr ds:[5196h]	;@03D1C
	jcxz	@@1	;@03D20
	mov	ax, 2	;@03D22
	mov	cx, ax	;@03D25
	call	far ptr L0FB18	;@03D27
	mov	es, ax	;@03D2C
	mov	cx, word ptr ds:[504Ah]	;@03D2E
	mov	word ptr es:[0], cx	;@03D32
	mov	word ptr ds:[504Ah], ax	;@03D37
	mov	ax, word ptr ds:[5196h]	;@03D3A
	mov	word ptr es:[2], ax	;@03D3D
	mov	ax, word ptr ds:[515Ch]	;@03D41
	mov	word ptr es:[4], ax	;@03D44
	mov	al, byte ptr ds:[519Eh]	;@03D48
	mov	byte ptr es:[0Fh], al	;@03D4B
	xor	ah, ah	;@03D4F
	push	si	;@03D51
	mov	si, 5170h	;@03D52
	mov	di, 10h	;@03D55
	mov	cx, ax	;@03D58
	rep movsw	;@03D5A
	pop	si	;@03D5C
	mov	ax, word ptr ds:[5184h]	;@03D5D
	mov	word ptr es:[6], ax	;@03D60
	mov	ax, word ptr ds:[5186h]	;@03D64
	mov	word ptr es:[8], ax	;@03D67
	mov	ax, word ptr ds:[5180h]	;@03D6B
	mov	word ptr es:[0Ah], ax	;@03D6E
	mov	ax, word ptr ds:[5182h]	;@03D72
	mov	word ptr es:[0Ch], ax	;@03D75
	mov	al, byte ptr ds:[51A3h]	;@03D79
	mov	byte ptr es:[0Eh], al	;@03D7C
	jmp	short @@2	;@03D80
@@1:	push	bx	;@03D82
	call	L03E95	;@03D83
	pop	bx	;@03D86
@@2:	xor	ax, ax	;@03D87
	mov	byte ptr ds:[519Eh], al	;@03D89
	mov	word ptr ds:[5180h], ax	;@03D8C
	mov	word ptr ds:[5182h], ax	;@03D8F
	mov	word ptr ds:[5184h], ax	;@03D92
	mov	word ptr ds:[5186h], ax	;@03D95
	mov	al, byte ptr ds:[516Bh]	;@03D98
	and	al, 30h	;@03D9B
	or	al, byte ptr ds:[51A4h]	;@03D9D
	mov	byte ptr ds:[51A3h], al	;@03DA1
	or	byte ptr ds:[516Ah], 20h	;@03DA4
	mov	ax, bx	;@03DA9
L03DAB:	mov	word ptr ds:[5196h], ax	;@03DAB
	and	byte ptr ds:[516Ah], 0EFh	;@03DAE
	call	L006CE	;@03DB3
	jne	@@1	;@03DB6
	or	byte ptr ds:[516Ah], 10h	;@03DB8
@@1:	mov	word ptr ds:[515Ch], ax	;@03DBD
	test	byte ptr ds:[38D7h], 1	;@03DC0
	jne	@@2	;@03DC5
	test	word ptr ds:[38C4h], 4000h	;@03DC7
	jne	@@3	;@03DCD
@@2:	ret	;@03DCF
@@3:	test	byte ptr ds:[38D7h], 2	;@03DD0
	jne	@@2	;@03DD5
	push	si	;@03DD7
	push	es	;@03DD8
	mov	ax, word ptr ds:[5188h]	;@03DD9
	mov	bx, word ptr ds:[5154h]	;@03DDC
	mov	dx, word ptr ds:[5156h]	;@03DE0
	call	far ptr L124D3	;@03DE4
	pop	es	;@03DE9
	pop	si	;@03DEA
	ret	;@03DEB
L03DEC:	call	L03E95	;@03DEC
	push	si	;@03DEF
	call	L03EE0	;@03DF0
	pop	si	;@03DF3
	mov	cx, word ptr ds:[504Ah]	;@03DF4
	jcxz	@@2	;@03DF8
	push	cx	;@03DFA
	mov	es, cx	;@03DFB
	mov	ax, word ptr es:[0]	;@03DFD
	mov	word ptr ds:[504Ah], ax	;@03E01
	mov	ax, word ptr es:[2]	;@03E04
	mov	word ptr ds:[5196h], ax	;@03E08
	and	byte ptr ds:[516Ah], 0EFh	;@03E0B
	and	ax, ax	;@03E10
	je	@@1	;@03E12
	call	L006CE	;@03E14
	jne	@@1	;@03E17
	or	byte ptr ds:[516Ah], 10h	;@03E19
@@1:	mov	ax, word ptr es:[4]	;@03E1E
	mov	word ptr ds:[515Ch], ax	;@03E22
	mov	al, byte ptr es:[0Fh]	;@03E25
	mov	byte ptr ds:[519Eh], al	;@03E29
	xor	ah, ah	;@03E2C
	push	si	;@03E2E
	push	es	;@03E2F
	pop	ds	;@03E30
	push	ss	;@03E31
	pop	es	;@03E32
	mov	si, 10h	;@03E33
	mov	di, 5170h	;@03E36
	mov	cx, ax	;@03E39
	rep movsw	;@03E3B
	push	ds	;@03E3D
	pop	es	;@03E3E
	push	ss	;@03E3F
	pop	ds	;@03E40
	pop	si	;@03E41
	mov	ax, word ptr es:[6]	;@03E42
	mov	word ptr ds:[5184h], ax	;@03E46
	mov	ax, word ptr es:[8]	;@03E49
	mov	word ptr ds:[5186h], ax	;@03E4D
	mov	ax, word ptr es:[0Ah]	;@03E50
	mov	word ptr ds:[5180h], ax	;@03E54
	mov	ax, word ptr es:[0Ch]	;@03E57
	mov	word ptr ds:[5182h], ax	;@03E5B
	mov	al, byte ptr es:[0Eh]	;@03E5E
	mov	byte ptr ds:[51A3h], al	;@03E62
	pop	ax	;@03E65
	mov	dx, 2	;@03E66
	call	far ptr L0FAA6	;@03E69
	ret	;@03E6E
@@2:	xor	ax, ax	;@03E6F
	mov	word ptr ds:[5196h], ax	;@03E71
	mov	byte ptr ds:[519Eh], al	;@03E74
	mov	word ptr ds:[5180h], ax	;@03E77
	mov	word ptr ds:[5182h], ax	;@03E7A
	mov	word ptr ds:[5184h], ax	;@03E7D
	mov	word ptr ds:[5186h], ax	;@03E80
	mov	al, byte ptr ds:[516Bh]	;@03E83
	and	al, 30h	;@03E86
	or	al, byte ptr ds:[51A4h]	;@03E88
	mov	byte ptr ds:[51A3h], al	;@03E8C
	and	byte ptr ds:[516Ah], 0CFh	;@03E8F
	ret	;@03E94
L03E95:	cmp	word ptr ds:[515Ch], 0	;@03E95
	je	@@3	;@03E9A
	test	word ptr ds:[38C4h], 4000h	;@03E9C
	je	@@3	;@03EA2
	test	byte ptr ds:[38D7h], 3	;@03EA4
	jne	@@3	;@03EA9
	push	si	;@03EAB
	push	es	;@03EAC
	mov	es, word ptr ds:[515Ch]	;@03EAD
	call	L0130D	;@03EB1
	cmp	ax, word ptr ds:[5162h]	;@03EB4
	je	@@1	;@03EB8
	mov	es, ax	;@03EBA
	push	es	;@03EBC
	call	L0155F	;@03EBD
	pop	es	;@03EC0
	push	ax	;@03EC1
	call	L0157F	;@03EC2
	mov	bx, ax	;@03EC5
	pop	ax	;@03EC7
	jmp	short @@2	;@03EC8
@@1:	mov	bx, word ptr ds:[5154h]	;@03ECA
	mov	dx, word ptr ds:[5156h]	;@03ECE
@@2:	call	far ptr L124E8	;@03ED2
	pop	es	;@03ED7
	pop	si	;@03ED8
@@3:	mov	word ptr ds:[515Ch], 0	;@03ED9
	ret	;@03EDF
L03EE0:	test	byte ptr ds:[38D7h], 10h	;@03EE0
	je	@@1	;@03EE5
	call	L0425C	;@03EE7
@@1:	test	byte ptr ds:[38D7h], 3	;@03EEA
	jne	@@2	;@03EEF
	mov	ax, word ptr ds:[5196h]	;@03EF1
	and	ax, ax	;@03EF4
	je	@@2	;@03EF6
	mov	es, ax	;@03EF8
	call	L004C7	;@03EFA
	mov	bl, al	;@03EFD
	mov	ax, di	;@03EFF
	test	byte ptr ds:[51A3h], 10h	;@03F01
	jne	@@3	;@03F06
	jmp	short @@4	;@03F08
@@2:	ret	;@03F0A
@@3:	mov	cx, word ptr ds:[5180h]	;@03F0B
	or	cx, word ptr ds:[5182h]	;@03F0F
	or	cx, word ptr ds:[5184h]	;@03F13
	or	cx, word ptr ds:[5186h]	;@03F17
	je	@@4	;@03F1B
	call	L00529	;@03F1D
	jmp	short @@5	;@03F20
@@4:	call	L004FF	;@03F22
@@5:	push	bx	;@03F25
	call	L01282	;@03F26
	pop	bx	;@03F29
	jmp	L034E8	;@03F2A
L03F2D:	test	byte ptr ds:[38D7h], 1	;@03F2D
	jne	@@1	;@03F32
	push	si	;@03F34
	call	far ptr L0FCFE	;@03F35
	call	far ptr L12633	;@03F3A
	pop	si	;@03F3F
@@1:	ret	;@03F40
L03F41:	mov	cx, word ptr ds:[5188h]	;@03F41
	jcxz	@@4	;@03F45
	test	byte ptr ds:[38D7h], 1	;@03F47
	jne	@@1	;@03F4C
	cmp	word ptr ds:[5194h], 0	;@03F4E
	jne	@@1	;@03F53
	push	si	;@03F55
	push	ax	;@03F56
	push	dx	;@03F57
	mov	bx, ax	;@03F58
	mov	ax, cx	;@03F5A
	call	far ptr L127BF	;@03F5C
	pop	dx	;@03F61
	pop	ax	;@03F62
	pop	si	;@03F63
	test	byte ptr ds:[38D7h], 0Ah	;@03F64
	jne	@@1	;@03F69
	or	byte ptr ds:[38D8h], 9	;@03F6B
@@1:	push	si	;@03F70
	mov	si, word ptr ds:[5154h]	;@03F71
	mov	di, word ptr ds:[5156h]	;@03F75
	mov	word ptr ds:[5154h], ax	;@03F79
	mov	word ptr ds:[5156h], dx	;@03F7C
	and	dx, dx	;@03F80
	je	@@2	;@03F82
	mov	bx, ax	;@03F84
	call	L04297	;@03F86
	mov	ax, bx	;@03F89
	jne	@@2	;@03F8B
	push	dx	;@03F8D
	mov	cx, 5Eh	;@03F8E
	call	L03208	;@03F91
	pop	dx	;@03F94
@@2:	test	byte ptr ds:[38D7h], 1	;@03F95
	jne	@@3	;@03F9A
	mov	bx, ax	;@03F9C
	mov	ax, word ptr ds:[5188h]	;@03F9E
	call	far ptr L12790	;@03FA1
@@3:	pop	si	;@03FA6
	ret	;@03FA7
@@4:	test	word ptr ds:[5160h], 1000h	;@03FA8
	jne	@@5	;@03FAE
	ret	;@03FB0
@@5:	mov	cx, 30h	;@03FB1
	jmp	L03208	;@03FB4
L03FB7:	mov	bx, ax	;@03FB7
	mov	cx, word ptr ds:[5162h]	;@03FB9
	jcxz	@@1	;@03FBD
	mov	es, cx	;@03FBF
	mov	ax, word ptr ds:[5154h]	;@03FC1
	mov	dx, word ptr ds:[5156h]	;@03FC4
	call	L01575	;@03FC8
	mov	ax, 1	;@03FCB
	mov	cx, ax	;@03FCE
	call	far ptr L0FB18	;@03FD0
	mov	es, ax	;@03FD5
	mov	cx, word ptr ds:[5046h]	;@03FD7
	mov	word ptr es:[0], cx	;@03FDB
	mov	word ptr ds:[5046h], ax	;@03FE0
	mov	ax, word ptr ds:[5162h]	;@03FE3
	mov	word ptr es:[2], ax	;@03FE6
@@1:	mov	word ptr ds:[5162h], bx	;@03FEA
	mov	es, bx	;@03FEE
	call	L0157F	;@03FF0
	mov	word ptr ds:[5154h], ax	;@03FF3
	mov	word ptr ds:[5156h], dx	;@03FF6
	call	L0155F	;@03FFA
	mov	word ptr ds:[5188h], ax	;@03FFD
	test	byte ptr ds:[38D7h], 10h	;@04000
	jne	L04008	;@04005
	ret	;@04007
L04008:	jmp	L0425C	;@04008
L0400B:	mov	cx, word ptr ds:[5162h]	;@0400B
	jcxz	@@3	;@0400F
	mov	es, word ptr ds:[5162h]	;@04011
	mov	ax, word ptr ds:[5154h]	;@04015
	mov	dx, word ptr ds:[5156h]	;@04018
	call	L01575	;@0401C
	test	byte ptr ds:[38D7h], 10h	;@0401F
	je	@@1	;@04024
	call	L0425C	;@04026
@@1:	mov	cx, word ptr ds:[5188h]	;@04029
	jcxz	@@5	;@0402D
	test	byte ptr ds:[38D7h], 1	;@0402F
	jne	@@2	;@04034
	push	si	;@04036
	mov	bx, word ptr ds:[5154h]	;@04037
	mov	dx, word ptr ds:[5156h]	;@0403B
	mov	ax, cx	;@0403F
	mov	si, bx	;@04041
	mov	di, dx	;@04043
	call	far ptr L12790	;@04045
	pop	si	;@0404A
@@2:	mov	cx, word ptr ds:[5046h]	;@0404B
	jcxz	@@4	;@0404F
	mov	es, cx	;@04051
	mov	ax, word ptr es:[0]	;@04053
	mov	word ptr ds:[5046h], ax	;@04057
	mov	ax, word ptr es:[2]	;@0405A
	mov	word ptr ds:[5162h], ax	;@0405E
	mov	ax, cx	;@04061
	mov	dx, 1	;@04063
	call	far ptr L0FAA6	;@04066
	mov	es, word ptr ds:[5162h]	;@0406B
	call	L0157F	;@0406F
	mov	word ptr ds:[5154h], ax	;@04072
	mov	word ptr ds:[5156h], dx	;@04075
	call	L0155F	;@04079
	mov	word ptr ds:[5188h], ax	;@0407C
@@3:	ret	;@0407F
@@4:	mov	ax, cx	;@04080
	mov	word ptr ds:[5188h], ax	;@04082
	mov	word ptr ds:[5162h], ax	;@04085
	mov	word ptr ds:[5154h], ax	;@04088
	mov	word ptr ds:[5156h], ax	;@0408B
	ret	;@0408E
@@5:	mov	cx, 30h	;@0408F
	jmp	L03208	;@04092
L04095:	mov	bx, word ptr ds:[504Eh]	;@04095
	mov	byte ptr [bx+5050h], al	;@04099
	inc	word ptr ds:[504Eh]	;@0409D
	test	byte ptr ds:[38D7h], 10h	;@040A1
	jne	@@1	;@040A6
	ret	;@040A8
@@1:	push	es	;@040A9
	push	si	;@040AA
	push	cx	;@040AB
	mov	al, byte ptr [bx+5050h]	;@040AC
	mov	byte ptr ds:[5150h], 0	;@040B0
	call	far ptr L1011E	;@040B5
	pop	cx	;@040BA
	pop	si	;@040BB
	pop	es	;@040BC
	ret	;@040BD
L040BE:	mov	bx, word ptr ds:[504Eh]	;@040BE
	mov	byte ptr [bx+5050h], al	;@040C2
	inc	word ptr ds:[504Eh]	;@040C6
	test	byte ptr ds:[38D7h], 10h	;@040CA
	jne	@@1	;@040CF
	ret	;@040D1
@@1:	push	es	;@040D2
	push	si	;@040D3
	push	cx	;@040D4
	mov	al, byte ptr [bx+5050h]	;@040D5
	mov	byte ptr ds:[5150h], 0	;@040D9
	call	far ptr L10152	;@040DE
	pop	cx	;@040E3
	pop	si	;@040E4
	pop	es	;@040E5
	ret	;@040E6
L040E7:	mov	bx, word ptr ds:[504Eh]	;@040E7
	mov	byte ptr [bx+5050h], al	;@040EB
	inc	word ptr ds:[504Eh]	;@040EF
	test	byte ptr ds:[38D7h], 10h	;@040F3
	jne	@@1	;@040F8
	ret	;@040FA
@@1:	push	es	;@040FB
	push	si	;@040FC
	push	cx	;@040FD
	mov	al, byte ptr [bx+5050h]	;@040FE
	mov	byte ptr ds:[5150h], 0	;@04102
	call	far ptr L10138	;@04107
	pop	cx	;@0410C
	pop	si	;@0410D
	pop	es	;@0410E
	ret	;@0410F
L04110:	mov	bx, word ptr ds:[504Eh]	;@04110
	mov	byte ptr [bx+5050h], al	;@04114
	inc	word ptr ds:[504Eh]	;@04118
	test	byte ptr ds:[38D7h], 10h	;@0411C
	jne	@@1	;@04121
	ret	;@04123
@@1:	push	ax	;@04124
	mov	ax, 1	;@04125
	call	L0427A	;@04128
	pop	ax	;@0412B
	ret	;@0412C
	db	90h	;@0412D
L0412E:	mov	bx, word ptr ds:[504Eh]	;@0412E
	mov	word ptr [bx+5050h], ax	;@04132
	add	word ptr ds:[504Eh], 2	;@04136
	test	byte ptr ds:[38D7h], 10h	;@0413B
	jne	L04143	;@04140
	ret	;@04142
L04143:	mov	ax, 2	;@04143
	jmp	L0427A	;@04146
	db	90h	;@04149
L0414A:	mov	bx, word ptr ds:[504Eh]	;@0414A
	mov	word ptr [bx+5050h], ax	;@0414E
	mov	word ptr [bx+5052h], cx	;@04152
	add	word ptr ds:[504Eh], 4	;@04156
	test	byte ptr ds:[38D7h], 10h	;@0415B
	jne	@@1	;@04160
	ret	;@04162
@@1:	mov	ax, 4	;@04163
	jmp	L0427A	;@04166
L04169:	mov	bx, word ptr ds:[504Eh]	;@04169
	mov	word ptr [bx+5050h], ax	;@0416D
	mov	word ptr [bx+5052h], cx	;@04171
	mov	word ptr [bx+5054h], di	;@04175
	add	word ptr ds:[504Eh], 6	;@04179
	test	byte ptr ds:[38D7h], 10h	;@0417E
	jne	@@1	;@04183
	ret	;@04185
@@1:	mov	ax, 6	;@04186
	jmp	L0427A	;@04189
L0418C:	push	es	;@0418C
	push	ss	;@0418D
	pop	es	;@0418E
	mov	di, 5050h	;@0418F
	add	di, word ptr ds:[504Eh]	;@04192
	add	word ptr ds:[504Eh], cx	;@04196
	mov	ax, cx	;@0419A
	push	si	;@0419C
	mov	si, bx	;@0419D
	rep movsb	;@0419F
	pop	si	;@041A1
	pop	es	;@041A2
	test	byte ptr ds:[38D7h], 10h	;@041A3
	jne	@@1	;@041A8
	ret	;@041AA
@@1:	mov	bx, di	;@041AB
	sub	bx, ax	;@041AD
	jmp	L0427E	;@041AF
L041B2:	push	es	;@041B2
	push	ss	;@041B3
	pop	es	;@041B4
	mov	di, 5050h	;@041B5
	add	di, word ptr ds:[504Eh]	;@041B8
	add	word ptr ds:[504Eh], cx	;@041BC
	mov	word ptr [di], ax	;@041C0
	mov	word ptr [di+2], bx	;@041C2
	mov	dx, cx	;@041C5
	add	di, 4	;@041C7
	sub	cx, 4	;@041CA
	je	@@2	;@041CD
	mov	al, dh	;@041CF
@@1:	stosb	;@041D1
	loop	@@1	;@041D2
@@2:	pop	es	;@041D4
	test	byte ptr ds:[38D7h], 10h	;@041D5
	jne	@@3	;@041DA
	ret	;@041DC
@@3:	mov	ax, dx	;@041DD
	mov	bx, di	;@041DF
	sub	bx, ax	;@041E1
	jmp	L0427E	;@041E3
	db	6, 16h, 7, 0BFh, 50h, 50h, 3, '>NP', 1, 0Eh, 4Eh, 50h, 8Bh, 0D1h	;@041E6
	db	0AAh, 0E2h, 0FDh, 7, 0F6h, 6, 0D7h, 38h, 10h, 75h, 1, 0C3h
L04202:	mov	ax, dx	;@04202
L04204:	mov	bx, di	;@04204
	sub	bx, ax	;@04206
	jmp	short L0427E	;@04208
L0420A:	mov	cx, ax	;@0420A
	mov	bx, word ptr ds:[5154h]	;@0420C
	mov	dx, word ptr ds:[5156h]	;@04210
	mov	ax, word ptr ds:[5188h]	;@04214
	and	ax, ax	;@04217
	jne	@@1	;@04219
	mov	cx, 30h	;@0421B
	jmp	L03208	;@0421E
@@1:	push	cx	;@04221
	push	si	;@04222
	test	byte ptr ds:[38D7h], 10h	;@04223
	je	@@2	;@04228
	push	ax	;@0422A
	push	bx	;@0422B
	push	cx	;@0422C
	push	dx	;@0422D
	call	far ptr L1010C	;@0422E
	call	L0425C	;@04233
	pop	dx	;@04236
	pop	cx	;@04237
	pop	bx	;@04238
	pop	ax	;@04239
	test	byte ptr ds:[38D7h], 1	;@0423A
	jne	@@3	;@0423F
@@2:	call	far ptr L12979	;@04241
@@3:	pop	si	;@04246
	pop	cx	;@04247
	add	word ptr ds:[5154h], cx	;@04248
	jb	@@5	;@0424C
@@4:	ret	;@0424E
@@5:	inc	word ptr ds:[5156h]	;@0424F
	je	@@6	;@04253
	call	L04297	;@04255
	jne	@@4	;@04258
@@6:	jmp	short L042AD	;@0425A
L0425C:	call	L04297	;@0425C
	mov	cx, 2	;@0425F
	je	@@1	;@04262
	shl	cx, 1	;@04264
@@1:	mov	ax, word ptr ds:[5154h]	;@04266
	mov	dx, word ptr ds:[5156h]	;@04269
	push	si	;@0426D
	call	far ptr L10086	;@0426E
	mov	byte ptr ds:[519Fh], 0FFh	;@04273
	pop	si	;@04278
	ret	;@04279
L0427A:	add	bx, 5050h	;@0427A
L0427E:	push	es	;@0427E
	push	si	;@0427F
	push	cx	;@04280
	mov	cx, ax	;@04281
	mov	si, bx	;@04283
	mov	dl, byte ptr ds:[5150h]	;@04285
	mov	byte ptr ds:[5150h], 0	;@04289
	call	far ptr L100DE	;@0428E
	pop	cx	;@04293
	pop	si	;@04294
	pop	es	;@04295
	ret	;@04296
L04297:	cmp	word ptr ds:[5194h], 0	;@04297
	jne	@@2	;@0429C
	mov	ax, word ptr ds:[5162h]	;@0429E
	and	ax, ax	;@042A1
	je	@@1	;@042A3
	jmp	L00752	;@042A5
@@1:	xor	al, al	;@042A8
	dec	al	;@042AA
@@2:	ret	;@042AC
L042AD:	test	word ptr ds:[5166h], 800h	;@042AD
	je	@@1	;@042B3
	mov	cx, 805Eh	;@042B5
	jmp	L03208	;@042B8
@@1:	ret	;@042BB
L042BC:	xor	ax, ax	;@042BC
	mov	word ptr ds:[52ACh], ax	;@042BE
	mov	word ptr ds:[52B6h], 52ACh	;@042C1
	mov	word ptr ds:[52B8h], ds	;@042C7
	mov	word ptr ds:[52BAh], ax	;@042CB
	mov	word ptr ds:[52B0h], ax	;@042CE
	ret	;@042D1
L042D2:	mov	dx, word ptr ds:[52B0h]	;@042D2
	and	dx, dx	;@042D6
	je	@@1	;@042D8
	mov	word ptr ds:[52B0h], 0	;@042DA
	mov	ax, word ptr ds:[52AEh]	;@042E0
	call	far ptr L0FAA6	;@042E3
	clc	;@042E8
	ret	;@042E9
@@1:	stc	;@042EA
	ret	;@042EB
L042EC:	call	L04750	;@042EC
	jb	@@1	;@042EF
	call	L0469A	;@042F1
	jmp	short @@2	;@042F4
@@1:	call	L046CA	;@042F6
@@2:	mov	ax, 0	;@042F9
	mov	word ptr ds:[52B6h], ax	;@042FC
	mov	word ptr ds:[52B8h], es	;@042FF
	ret	;@04303
L04304:	cmp	word ptr ds:[52ACh], 0	;@04304
	je	@@2	;@04309
	mov	word ptr ds:[52B2h], si	;@0430B
	mov	word ptr ds:[52B4h], 434Ah	;@0430F
	call	L04676	;@04315
	mov	cx, word ptr ds:[52ACh]	;@04318
@@1:	jcxz	@@2	;@0431C
	mov	es, cx	;@0431E
	call	L04559	;@04320
	push	es	;@04323
	mov	cx, word ptr es:[4]	;@04324
	mov	dl, ch	;@04329
	and	cx, 1FFFh	;@0432B
	and	dl, 40h	;@0432F
	mov	ax, word ptr es:[2]	;@04332
	call	L02FA3	;@04336
	mov	si, bx	;@04339
	call	word ptr ds:[52B2h]	;@0433B
	pop	es	;@0433F
	call	L045DC	;@04340
	mov	cx, word ptr es:[0]	;@04343
	jmp	@@1	;@04348
@@2:	ret	;@0434A
L0434B:	mov	word ptr ds:[52B2h], si	;@0434B
	mov	word ptr ds:[52B4h], di	;@0434F
	xor	ax, ax	;@04353
	mov	cx, ax	;@04355
	mov	di, ax	;@04357
	call	far ptr L11751	;@04359
	call	L04676	;@0435E
	xor	ax, ax	;@04361
	mov	word ptr ds:[52BAh], ax	;@04363
	mov	word ptr ds:[52B6h], 52ACh	;@04366
	mov	word ptr ds:[52B8h], ds	;@0436C
@@1:	call	L02640	;@04370
@@2:	les	bx, dword ptr ds:[52B6h]	;@04373
	mov	cx, word ptr es:[bx]	;@04377
	jcxz	@@3	;@0437A
	mov	es, cx	;@0437C
	mov	ax, word ptr ds:[5152h]	;@0437E
	mov	dx, word ptr ds:[515Eh]	;@04381
	test	byte ptr es:[5], 80h	;@04385
	je	@@8	;@0438B
	mov	cx, word ptr es:[6]	;@0438D
	mov	di, word ptr ds:[52BCh]	;@04392
	call	far ptr L11788	;@04396
	je	@@10	;@0439B
	jb	@@3	;@0439D
	mov	dx, 1	;@0439F
	jmp	short @@9	;@043A2
@@3:	mov	byte ptr ds:[38D8h], 0	;@043A4
	mov	ax, word ptr ds:[5154h]	;@043A9
	mov	word ptr ds:[5158h], ax	;@043AC
	mov	ax, word ptr ds:[5156h]	;@043AF
	mov	word ptr ds:[515Ah], ax	;@043B2
	mov	ax, word ptr ds:[519Ah]	;@043B5
	mov	word ptr ds:[5168h], ax	;@043B8
	call	word ptr ds:[52B2h]	;@043BB
	test	byte ptr ds:[38D8h], 1	;@043BF
	je	@@6	;@043C4
	call	L04750	;@043C6
	jb	@@4	;@043C9
	call	L0469A	;@043CB
	jmp	short @@5	;@043CE
@@4:	call	L046CA	;@043D0
@@5:	mov	ax, 0	;@043D3
	mov	word ptr ds:[52B6h], ax	;@043D6
	mov	word ptr ds:[52B8h], es	;@043D9
@@6:	call	word ptr ds:[52B4h]	;@043DD
	je	@@1	;@043E1
@@7:	jmp	L03424	;@043E3
@@8:	mov	cx, word ptr es:[6]	;@043E6
	mov	di, word ptr es:[12h]	;@043EB
	mov	word ptr ds:[52BCh], di	;@043F0
	call	far ptr L11788	;@043F4
	je	@@10	;@043F9
	jb	@@3	;@043FB
	mov	dx, 2	;@043FD
@@9:	call	L04779	;@04400
	jmp	@@2	;@04403
@@10:	mov	byte ptr ds:[38D8h], 1	;@04406
	mov	ax, word ptr ds:[5154h]	;@0440B
	mov	word ptr ds:[5158h], ax	;@0440E
	push	ax	;@04411
	mov	ax, word ptr ds:[5156h]	;@04412
	mov	word ptr ds:[515Ah], ax	;@04415
	push	ax	;@04418
	mov	ax, word ptr ds:[519Ah]	;@04419
	mov	word ptr ds:[5168h], ax	;@0441C
	push	es	;@0441F
	call	word ptr ds:[52B2h]	;@04420
	pop	es	;@04424
	test	byte ptr es:[5], 20h	;@04425
	jne	@@12	;@0442B
	pop	word ptr ds:[5156h]	;@0442D
	pop	word ptr ds:[5154h]	;@04431
	test	byte ptr es:[5], 80h	;@04435
	je	@@14	;@0443B
	mov	ax, word ptr es:[0Ch]	;@0443D
	add	word ptr ds:[5154h], ax	;@04441
	adc	word ptr ds:[5156h], 0	;@04445
@@11:	push	es	;@0444A
	call	L04750	;@0444B
	pop	es	;@0444E
	jb	@@13	;@0444F
	mov	word ptr es:[0Ch], dx	;@04451
	mov	ax, word ptr ds:[5158h]	;@04456
	mov	word ptr es:[8], ax	;@04459
	mov	ax, word ptr ds:[515Ah]	;@0445D
	mov	word ptr es:[0Ah], ax	;@04460
	mov	ax, word ptr ds:[515Ch]	;@04464
	mov	word ptr es:[0Eh], ax	;@04467
	jmp	short @@16	;@0446B
@@12:	pop	ax	;@0446D
	pop	ax	;@0446E
	test	byte ptr es:[5], 80h	;@0446F
	jne	@@11	;@04475
	jmp	short @@15	;@04477
@@13:	call	L04779	;@04479
	call	L046CA	;@0447C
	jmp	short @@16	;@0447F
@@14:	mov	ax, word ptr es:[8]	;@04481
	sub	ax, word ptr es:[0Ch]	;@04485
	mov	cx, word ptr es:[0Ah]	;@0448A
	sbb	cx, word ptr es:[0Eh]	;@0448F
	add	word ptr ds:[5154h], ax	;@04494
	adc	word ptr ds:[5156h], cx	;@04498
@@15:	mov	cx, 0Dh	;@0449C
	mov	di, 6	;@0449F
	mov	si, 5152h	;@044A2
	rep movsw	;@044A5
	mov	word ptr ds:[52BAh], es	;@044A7
@@16:	mov	byte ptr ds:[38D8h], 0	;@044AB
	push	es	;@044B0
	call	L0379A	;@044B1
	call	word ptr ds:[52B4h]	;@044B4
	pop	es	;@044B8
	jne	@@17	;@044B9
	mov	ax, 0	;@044BB
	mov	word ptr ds:[52B6h], ax	;@044BE
	mov	word ptr ds:[52B8h], es	;@044C1
	jmp	@@1	;@044C5
@@17:	jmp	@@7	;@044C8
L044CB:	mov	word ptr ds:[52B2h], si	;@044CB
	mov	word ptr ds:[52B4h], di	;@044CF
	xor	ax, ax	;@044D3
	mov	cx, ax	;@044D5
	mov	di, ax	;@044D7
	call	far ptr L11751	;@044D9
	call	L04676	;@044DE
	mov	ax, word ptr ds:[52ACh]	;@044E1
	mov	word ptr ds:[52B6h], ax	;@044E4
@@1:	call	L02640	;@044E7
	mov	cx, word ptr ds:[52B6h]	;@044EA
	jcxz	@@4	;@044EE
	mov	es, cx	;@044F0
	mov	ax, word ptr ds:[5152h]	;@044F2
	test	byte ptr es:[5], 80h	;@044F5
	je	@@2	;@044FB
	cmp	ax, word ptr es:[6]	;@044FD
	jne	@@4	;@04502
	mov	ax, word ptr ds:[515Eh]	;@04504
	cmp	ax, word ptr ds:[52BCh]	;@04507
	jne	@@4	;@0450B
	jmp	short @@3	;@0450D
@@2:	cmp	ax, word ptr es:[6]	;@0450F
	jne	@@4	;@04514
	mov	ax, word ptr ds:[515Eh]	;@04516
	cmp	ax, word ptr es:[12h]	;@04519
	jne	@@4	;@0451E
	mov	word ptr ds:[52BCh], ax	;@04520
@@3:	push	word ptr ds:[5154h]	;@04523
	push	word ptr ds:[5156h]	;@04527
	push	si	;@0452B
	call	L04559	;@0452C
	pop	si	;@0452F
	pop	word ptr ds:[5156h]	;@04530
	pop	word ptr ds:[5154h]	;@04534
	push	es	;@04538
	call	word ptr ds:[52B2h]	;@04539
	pop	es	;@0453D
	call	L045DC	;@0453E
	mov	ax, word ptr es:[0]	;@04541
	mov	word ptr ds:[52B6h], ax	;@04545
	je	@@1	;@04548
	jmp	short @@5	;@0454A
@@4:	call	word ptr ds:[52B2h]	;@0454C
	call	word ptr ds:[52B4h]	;@04550
	je	@@1	;@04554
@@5:	jmp	L03424	;@04556
L04559:	mov	bx, si	;@04559
	test	byte ptr es:[5], 80h	;@0455B
	je	@@1	;@04561
	mov	ax, word ptr es:[0Eh]	;@04563
	mov	word ptr ds:[515Ch], ax	;@04567
	mov	ax, word ptr es:[6]	;@0456A
	mov	word ptr ds:[5152h], ax	;@0456E
	mov	ax, word ptr es:[8]	;@04571
	mov	cx, word ptr es:[0Ah]	;@04575
	mov	word ptr ds:[5154h], ax	;@0457A
	mov	word ptr ds:[5156h], cx	;@0457D
	mov	word ptr ds:[5158h], ax	;@04581
	mov	word ptr ds:[515Ah], cx	;@04584
	add	ax, word ptr es:[0Ch]	;@04588
	adc	cx, 0	;@0458D
	mov	word ptr ds:[52BEh], ax	;@04590
	mov	word ptr ds:[52C0h], cx	;@04593
	ret	;@04597
@@1:	push	es	;@04598
	pop	ds	;@04599
	push	ss	;@0459A
	pop	es	;@0459B
	mov	si, 6	;@0459C
	mov	di, 5152h	;@0459F
	mov	cx, 0Dh	;@045A2
	rep movsw	;@045A5
	push	ds	;@045A7
	push	ss	;@045A8
	pop	ds	;@045A9
	db	0E8h, 18h, 0AEh	; call L0F3C5	;@045AA
	mov	ax, word ptr ds:[5162h]	;@045AD
	and	ax, ax	;@045B0
	je	@@2	;@045B2
	mov	es, ax	;@045B4
	call	L0199D	;@045B6
@@2:	pop	es	;@045B9
	mov	word ptr ds:[5188h], ax	;@045BA
	mov	ax, word ptr ds:[5154h]	;@045BD
	mov	word ptr ds:[52BEh], ax	;@045C0
	mov	ax, word ptr ds:[5156h]	;@045C3
	mov	word ptr ds:[52C0h], ax	;@045C6
	mov	ax, word ptr ds:[5158h]	;@045C9
	mov	word ptr ds:[5154h], ax	;@045CC
	mov	ax, word ptr ds:[515Ah]	;@045CF
	mov	word ptr ds:[5156h], ax	;@045D2
	mov	ax, word ptr ds:[5168h]	;@045D5
	mov	word ptr ds:[519Ah], ax	;@045D8
	ret	;@045DB
L045DC:	mov	ax, word ptr ds:[52BEh]	;@045DC
	mov	dx, word ptr ds:[52C0h]	;@045DF
	mov	bx, ax	;@045E3
	mov	cx, dx	;@045E5
	sub	ax, word ptr ds:[5154h]	;@045E7
	sbb	dx, word ptr ds:[5156h]	;@045EB
	jb	@@6	;@045EF
	and	ax, ax	;@045F1
	je	@@5	;@045F3
	cmp	word ptr ds:[38C6h], 0	;@045F5
	je	@@2	;@045FA
	test	byte ptr ds:[38D7h], 8	;@045FC
	jne	@@1	;@04601
	call	@@8	;@04603
	jmp	short @@3	;@04606
@@1:	push	ax	;@04608
	db	0E8h, 59h, 0B2h	; call L0F865	;@04609
	pop	ax	;@0460C
	jne	@@5	;@0460D
@@2:	test	word ptr ds:[5166h], 8	;@0460F
	je	@@3	;@04615
	mov	cx, 805Fh	;@04617
	call	L03208	;@0461A
@@3:	mov	cx, ax	;@0461D
	push	es	;@0461F
	call	L03698	;@04620
@@4:	mov	al, 90h	;@04623
	call	L04110	;@04625
	loop	@@4	;@04628
	call	L036D2	;@0462A
	pop	es	;@0462D
@@5:	push	es	;@0462E
	call	word ptr ds:[52B4h]	;@0462F
	pop	es	;@04633
	ret	;@04634
@@6:	mov	word ptr ds:[5154h], bx	;@04635
	mov	word ptr ds:[5156h], cx	;@04639
	cmp	word ptr ds:[38C6h], 0	;@0463D
	je	@@7	;@04642
	test	byte ptr ds:[38D7h], 8	;@04644
	jne	@@7	;@04649
	call	@@8	;@0464B
	jmp	@@5	;@0464E
@@7:	mov	cx, 32h	;@04650
	call	L03208	;@04653
	jmp	@@5	;@04656
@@8:	mov	byte ptr ds:[38DDh], 0FFh	;@04658
	test	byte ptr es:[5], 80h	;@0465D
	je	@@9	;@04663
	sub	word ptr es:[0Ch], ax	;@04665
	ret	;@0466A
@@9:	sub	word ptr es:[8], ax	;@0466B
	sbb	word ptr es:[0Ah], dx	;@04670
	ret	;@04675
L04676:	push	word ptr ds:[519Ch]	;@04676
	call	L033D6	;@0467A
	call	L0334C	;@0467D
	pop	word ptr ds:[519Ch]	;@04680
	mov	ax, word ptr ds:[38CAh]	;@04684
	mov	word ptr ds:[5160h], ax	;@04687
	db	0E8h, 38h, 0ADh	; call L0F3C5	;@0468A
	mov	ax, word ptr ds:[38CCh]	;@0468D
	mov	word ptr ds:[5166h], ax	;@04690
	mov	ax, word ptr ds:[38CEh]	;@04693
	mov	word ptr ds:[5198h], ax	;@04696
	ret	;@04699
L0469A:	mov	bp, 1	;@0469A
	push	dx	;@0469D
	call	L046E0	;@0469E
	pop	dx	;@046A1
	or	byte ptr es:[5], 80h	;@046A2
	mov	word ptr es:[0Ch], dx	;@046A8
	mov	ax, word ptr ds:[5158h]	;@046AD
	mov	word ptr es:[8], ax	;@046B0
	mov	ax, word ptr ds:[515Ah]	;@046B4
	mov	word ptr es:[0Ah], ax	;@046B7
	mov	ax, word ptr ds:[5152h]	;@046BB
	mov	word ptr es:[6], ax	;@046BE
	mov	ax, word ptr ds:[515Ch]	;@046C2
	mov	word ptr es:[0Eh], ax	;@046C5
	ret	;@046C9
L046CA:	mov	bp, 2	;@046CA
	call	L046E0	;@046CD
	mov	cx, 0Dh	;@046D0
	mov	di, 6	;@046D3
	mov	si, 5152h	;@046D6
	rep movsw	;@046D9
	mov	word ptr ds:[52BAh], es	;@046DB
	ret	;@046DF
L046E0:	cmp	word ptr ds:[52B0h], bp	;@046E0
	jae	@@2	;@046E4
	mov	dx, word ptr ds:[52B0h]	;@046E6
	and	dx, dx	;@046EA
	je	@@1	;@046EC
	mov	ax, word ptr ds:[52AEh]	;@046EE
	call	far ptr L0FAA6	;@046F1
	mov	word ptr ds:[52B0h], 0	;@046F6
@@1:	mov	cx, 100h	;@046FC
	mov	ax, bp	;@046FF
	call	far ptr L0FB18	;@04701
	mov	word ptr ds:[52B0h], cx	;@04706
	mov	word ptr ds:[52AEh], ax	;@0470A
@@2:	mov	es, word ptr ds:[52AEh]	;@0470D
	add	word ptr ds:[52AEh], bp	;@04711
	sub	word ptr ds:[52B0h], bp	;@04715
	test	byte ptr ds:[38D8h], 2	;@04719
	mov	ax, 4000h	;@0471E
	jne	@@3	;@04721
	xor	ax, ax	;@04723
@@3:	push	ax	;@04725
	push	es	;@04726
	call	L02F73	;@04727
	pop	es	;@0472A
	mov	word ptr es:[2], ax	;@0472B
	pop	ax	;@0472F
	test	byte ptr ds:[38D8h], 8	;@04730
	je	@@4	;@04735
	or	ah, 20h	;@04737
@@4:	or	ax, cx	;@0473A
	mov	word ptr es:[4], ax	;@0473C
	mov	ax, es	;@04740
	push	es	;@04742
	les	bx, dword ptr ds:[52B6h]	;@04743
	xchg	word ptr es:[bx], ax	;@04747
	pop	es	;@0474A
	mov	word ptr es:[0], ax	;@0474B
	ret	;@0474F
L04750:	mov	cx, word ptr ds:[52BAh]	;@04750
	jcxz	@@1	;@04754
	mov	es, cx	;@04756
	mov	si, 515Eh	;@04758
	mov	cx, 7	;@0475B
	mov	di, 12h	;@0475E
	repe cmpsw	;@04761
	jne	@@1	;@04763
	mov	dx, word ptr ds:[5154h]	;@04765
	sub	dx, word ptr ds:[5158h]	;@04769
	mov	ax, word ptr ds:[5156h]	;@0476D
	sbb	ax, word ptr ds:[515Ah]	;@04770
	jne	@@1	;@04774
	ret	;@04776
@@1:	stc	;@04777
	ret	;@04778
L04779:	mov	ax, word ptr es:[0]	;@04779
	push	es	;@0477D
	les	bx, dword ptr ds:[52B6h]	;@0477E
	xchg	word ptr es:[bx], ax	;@04782
	pop	es	;@04785
	push	ax	;@04786
	push	dx	;@04787
	mov	ax, word ptr es:[2]	;@04788
	mov	dx, word ptr es:[4]	;@0478C
	and	dx, 1FFFh	;@04791
	call	far ptr L0FC4F	;@04795
	pop	dx	;@0479A
	pop	ax	;@0479B
	call	far ptr L0FAA6	;@0479C
	ret	;@047A1
L047A2:	mov	ax, 3500h	;@047A2
	int	21h	;@047A5
	mov	word ptr ds:[55C2h], bx	;@047A7
	mov	word ptr ds:[55C4h], es	;@047AB
	push	ds	;@047AF
	push	cs	;@047B0
	pop	ds	;@047B1
	mov	dx, 527Eh	;@047B2
	mov	ax, 2500h	;@047B5
	int	21h	;@047B8
	pop	ds	;@047BA
	ret	;@047BB
L047BC:	push	ds	;@047BC
	mov	dx, word ptr ds:[55C2h]	;@047BD
	mov	ds, word ptr ds:[55C4h]	;@047C1
	mov	ax, 2500h	;@047C5
	int	21h	;@047C8
	pop	ds	;@047CA
	ret	;@047CB
L047CC:	mov	byte ptr ds:[55D1h], ah	;@047CC
	mov	dx, 5	;@047D0
	mov	al, byte ptr es:[di]	;@047D3
	cmp	al, 30h	;@047D6
	jb	@@1	;@047D8
	cmp	al, 3Ah	;@047DA
	jb	@@2	;@047DC
@@1:	call	L04E16	;@047DE
	jmp	short @@10	;@047E1
@@2:	add	di, cx	;@047E3
	mov	al, byte ptr es:[di-1]	;@047E5
	sub	di, cx	;@047E9
	dec	cx	;@047EB
	cmp	al, 42h	;@047EC
	jne	@@3	;@047EE
	call	L04C78	;@047F0
	jmp	short @@10	;@047F3
@@3:	cmp	al, 51h	;@047F5
	je	@@4	;@047F7
	cmp	al, 4Fh	;@047F9
	jne	@@5	;@047FB
@@4:	call	L04C45	;@047FD
	jmp	short @@10	;@04800
@@5:	cmp	al, 44h	;@04802
	jne	@@6	;@04804
	call	L04BC0	;@04806
	jmp	short @@10	;@04809
@@6:	cmp	al, 48h	;@0480B
	jne	@@7	;@0480D
	call	L04B7C	;@0480F
	jmp	short @@10	;@04812
@@7:	cmp	al, 52h	;@04814
	jne	@@8	;@04816
	mov	bl, 14h	;@04818
	call	L04B6F	;@0481A
	jmp	short @@10	;@0481D
@@8:	inc	cx	;@0481F
	call	L05020	;@04820
	jne	@@9	;@04823
	call	L04D09	;@04825
	jmp	short @@10	;@04828
@@9:	call	L04C0D	;@0482A
@@10:	mov	bx, 53C2h	;@0482D
	ret	;@04830
L04831:	mov	byte ptr ds:[55D1h], ah	;@04831
	mov	dx, 4	;@04835
	mov	al, byte ptr es:[di]	;@04838
	cmp	al, 30h	;@0483B
	jb	@@1	;@0483D
	cmp	al, 3Ah	;@0483F
	jb	@@2	;@04841
@@1:	call	L04E16	;@04843
	jmp	short @@10	;@04846
@@2:	add	di, cx	;@04848
	mov	al, byte ptr es:[di-1]	;@0484A
	sub	di, cx	;@0484E
	dec	cx	;@04850
	cmp	al, 42h	;@04851
	jne	@@3	;@04853
	call	L04C78	;@04855
	jmp	short @@10	;@04858
@@3:	cmp	al, 51h	;@0485A
	je	@@4	;@0485C
	cmp	al, 4Fh	;@0485E
	jne	@@5	;@04860
@@4:	call	L04C45	;@04862
	jmp	short @@10	;@04865
@@5:	cmp	al, 44h	;@04867
	jne	@@7	;@04869
@@6:	call	L04BC0	;@0486B
	jmp	short @@10	;@0486E
@@7:	cmp	al, 48h	;@04870
	jne	@@8	;@04872
	call	L04B7C	;@04874
	jmp	short @@10	;@04877
@@8:	cmp	al, 52h	;@04879
	jne	@@9	;@0487B
	mov	bl, 10h	;@0487D
	call	L04B6F	;@0487F
	jmp	short @@10	;@04882
@@9:	inc	cx	;@04884
	call	L05020	;@04885
	jne	@@6	;@04888
	call	L04CA1	;@0488A
@@10:	mov	bx, 53C2h	;@0488D
	ret	;@04890
L04891:	mov	byte ptr ds:[55D1h], ah	;@04891
	mov	dx, 3	;@04895
	mov	al, byte ptr es:[di]	;@04898
	cmp	al, 30h	;@0489B
	jb	@@1	;@0489D
	cmp	al, 3Ah	;@0489F
	jb	@@2	;@048A1
@@1:	call	L04E16	;@048A3
	jmp	short @@9	;@048A6
@@2:	add	di, cx	;@048A8
	mov	al, byte ptr es:[di-1]	;@048AA
	sub	di, cx	;@048AE
	dec	cx	;@048B0
	cmp	al, 42h	;@048B1
	jne	@@3	;@048B3
	call	L04C78	;@048B5
	jmp	short @@9	;@048B8
@@3:	cmp	al, 51h	;@048BA
	je	@@4	;@048BC
	cmp	al, 4Fh	;@048BE
	jne	@@5	;@048C0
@@4:	call	L04C45	;@048C2
	jmp	short @@9	;@048C5
@@5:	cmp	al, 44h	;@048C7
	jne	@@7	;@048C9
@@6:	call	L04BC0	;@048CB
	jmp	short @@9	;@048CE
@@7:	cmp	al, 48h	;@048D0
	jne	@@8	;@048D2
	call	L04B7C	;@048D4
	jmp	short @@9	;@048D7
@@8:	inc	cx	;@048D9
	jmp	@@6	;@048DA
@@9:	mov	bx, 53C2h	;@048DC
	ret	;@048DF
L048E0:	mov	byte ptr ds:[55D1h], ah	;@048E0
	mov	al, byte ptr es:[di]	;@048E4
	cmp	al, 30h	;@048E7
	jb	@@1	;@048E9
	cmp	al, 3Ah	;@048EB
	jb	@@2	;@048ED
@@1:	call	L04F78	;@048EF
	jmp	short @@10	;@048F2
@@2:	add	di, cx	;@048F4
	mov	al, byte ptr es:[di-1]	;@048F6
	sub	di, cx	;@048FA
	dec	cx	;@048FC
	cmp	al, 42h	;@048FD
	jne	@@3	;@048FF
	call	L04F55	;@04901
	jmp	short @@10	;@04904
@@3:	cmp	al, 51h	;@04906
	je	@@4	;@04908
	cmp	al, 4Fh	;@0490A
	jne	@@5	;@0490C
@@4:	call	L04F26	;@0490E
	jmp	short @@10	;@04911
@@5:	cmp	al, 44h	;@04913
	jne	@@7	;@04915
@@6:	call	L04E98	;@04917
	jmp	short @@10	;@0491A
@@7:	cmp	al, 48h	;@0491C
	jne	@@8	;@0491E
	call	L04E57	;@04920
	jmp	short @@10	;@04923
@@8:	cmp	al, 52h	;@04925
	jne	@@9	;@04927
	call	L04E48	;@04929
	jmp	short @@10	;@0492C
@@9:	inc	cx	;@0492E
	call	L05020	;@0492F
	jne	@@6	;@04932
	call	L04EDF	;@04934
@@10:	mov	bx, 53C2h	;@04937
	ret	;@0493A
L0493B:	mov	byte ptr ds:[55D1h], ah	;@0493B
	mov	al, byte ptr es:[di]	;@0493F
	cmp	al, 30h	;@04942
	jb	@@1	;@04944
	cmp	al, 3Ah	;@04946
	jb	@@2	;@04948
@@1:	call	L04F78	;@0494A
	jmp	short @@3	;@0494D
@@2:	call	L04B1C	;@0494F
@@3:	mov	bx, 53C2h	;@04952
	ret	;@04955
L04956:	mov	byte ptr ds:[55D1h], ah	;@04956
	mov	al, byte ptr es:[di]	;@0495A
	cmp	al, 30h	;@0495D
	jb	@@1	;@0495F
	cmp	al, 3Ah	;@04961
	jb	@@2	;@04963
@@1:	call	L04FD1	;@04965
	cmp	cx, 1	;@04968
	je	@@3	;@0496B
	jmp	short @@5	;@0496D
@@2:	call	L04B1C	;@0496F
	mov	cx, 1	;@04972
@@3:	mov	al, byte ptr ds:[53C6h]	;@04975
	cbw	;@04978
	cmp	ax, word ptr ds:[53C4h]	;@04979
	jne	@@4	;@0497D
	cmp	al, byte ptr ds:[53C3h]	;@0497F
	je	@@5	;@04983
@@4:	push	cx	;@04985
	call	L05029	;@04986
	pop	cx	;@04989
@@5:	mov	bx, 53C2h	;@0498A
	ret	;@0498D
L0498E:	mov	ax, bx	;@0498E
	add	bx, 54C2h	;@04990
	add	ax, cx	;@04994
	cmp	ax, 100h	;@04996
	jb	@@1	;@04999
	push	bx	;@0499B
	mov	cx, 7Bh	;@0499C
	call	L03208	;@0499F
	pop	bx	;@049A2
	jmp	short @@3	;@049A3
@@1:	jcxz	@@3	;@049A5
@@2:	mov	al, byte ptr es:[di]	;@049A7
	mov	byte ptr [bx], al	;@049AA
	inc	bx	;@049AC
	inc	di	;@049AD
	loop	@@2	;@049AE
@@3:	mov	cx, bx	;@049B0
	mov	bx, 54C2h	;@049B2
	sub	cx, bx	;@049B5
	ret	;@049B7
L049B8:	and	bh, bh	;@049B8
	je	@@1	;@049BA
	not	ax	;@049BC
	not	dx	;@049BE
	add	ax, 1	;@049C0
	adc	dx, 0	;@049C3
	and	bl, bl	;@049C6
	je	@@2	;@049C8
	not	cx	;@049CA
	not	di	;@049CC
	add	cx, 1	;@049CE
	adc	di, 0	;@049D1
	jmp	short @@3	;@049D4
@@1:	and	bl, bl	;@049D6
	je	@@3	;@049D8
	not	cx	;@049DA
	not	di	;@049DC
	add	cx, 1	;@049DE
	adc	di, 0	;@049E1
@@2:	call	@@3	;@049E4
	push	bx	;@049E7
	call	L050FF	;@049E8
	pop	bx	;@049EB
	ret	;@049EC
@@3:	call	L0525D	;@049ED
	mov	word ptr ds:[53C2h], ax	;@049F0
	xor	dx, dx	;@049F3
	mov	word ptr ds:[53C4h], dx	;@049F5
	mov	byte ptr ds:[53C6h], dl	;@049F9
	mov	bx, 53C2h	;@049FD
	ret	;@04A00
L04A01:	and	bh, bh	;@04A01
	je	@@1	;@04A03
	not	ax	;@04A05
	not	dx	;@04A07
	add	ax, 1	;@04A09
	adc	dx, 0	;@04A0C
	and	bl, bl	;@04A0F
	je	@@2	;@04A11
	not	cx	;@04A13
	not	di	;@04A15
	add	cx, 1	;@04A17
	adc	di, 0	;@04A1A
	jmp	short @@3	;@04A1D
@@1:	and	bl, bl	;@04A1F
	je	@@3	;@04A21
	not	cx	;@04A23
	not	di	;@04A25
	add	cx, 1	;@04A27
	adc	di, 0	;@04A2A
@@2:	call	@@3	;@04A2D
	push	bx	;@04A30
	call	L050FF	;@04A31
	pop	bx	;@04A34
	ret	;@04A35
@@3:	call	L0525D	;@04A36
	mov	ax, dx	;@04A39
	mov	word ptr ds:[53C2h], ax	;@04A3B
	xor	dx, dx	;@04A3E
	mov	word ptr ds:[53C4h], dx	;@04A40
	mov	byte ptr ds:[53C6h], dl	;@04A44
	mov	bx, 53C2h	;@04A48
	ret	;@04A4B
L04A4C:	and	bh, bh	;@04A4C
	je	@@1	;@04A4E
	not	ax	;@04A50
	not	dx	;@04A52
	add	ax, 1	;@04A54
	adc	dx, 0	;@04A57
	and	bl, bl	;@04A5A
	je	@@2	;@04A5C
	not	cx	;@04A5E
	not	di	;@04A60
	add	cx, 1	;@04A62
	adc	di, 0	;@04A65
	jmp	short L04A81	;@04A68
@@1:	and	bl, bl	;@04A6A
	je	L04A81	;@04A6C
	not	cx	;@04A6E
	not	di	;@04A70
	add	cx, 1	;@04A72
	adc	di, 0	;@04A75
@@2:	call	L04A81	;@04A78
	push	bx	;@04A7B
	call	L050FF	;@04A7C
	pop	bx	;@04A7F
	ret	;@04A80
L04A81:	push	si	;@04A81
	mov	si, cx	;@04A82
	mov	bx, ax	;@04A84
	mov	cx, dx	;@04A86
	call	L04AE4	;@04A88
	jae	@@1	;@04A8B
	call	L05029	;@04A8D
@@1:	mov	bx, 53C2h	;@04A90
	pop	si	;@04A93
	ret	;@04A94
L04A95:	call	L04AE4	;@04A95
	jb	@@1	;@04A98
	mov	bx, word ptr ds:[53C2h]	;@04A9A
	mov	cx, word ptr ds:[53C4h]	;@04A9E
	ret	;@04AA2
@@1:	xor	bx, bx	;@04AA3
	xor	cx, cx	;@04AA5
	stc	;@04AA7
	ret	;@04AA8
L04AA9:	push	ax	;@04AA9
	mov	al, ah	;@04AAA
	call	@@1	;@04AAC
	pop	ax	;@04AAF
@@1:	mov	ah, al	;@04AB0
	mov	cl, 4	;@04AB2
	shr	al, cl	;@04AB4
	call	@@2	;@04AB6
	mov	al, ah	;@04AB9
	and	al, 0Fh	;@04ABB
@@2:	cmp	al, 0Ah	;@04ABD
	jae	@@3	;@04ABF
	add	al, 30h	;@04AC1
	stosb	;@04AC3
	ret	;@04AC4
@@3:	add	al, 37h	;@04AC5
	stosb	;@04AC7
	ret	;@04AC8
L04AC9:	push	es	;@04AC9
	push	di	;@04ACA
	mov	es, ax	;@04ACB
	call	L004A1	;@04ACD
	push	es	;@04AD0
	pop	ds	;@04AD1
	mov	si, di	;@04AD2
	pop	di	;@04AD4
	pop	es	;@04AD5
	rep movsb	;@04AD6
	push	ss	;@04AD8
	pop	ds	;@04AD9
	ret	;@04ADA
L04ADB:	lodsb	;@04ADB
	and	al, al	;@04ADC
	je	@@1	;@04ADE
	stosb	;@04AE0
	jmp	L04ADB	;@04AE1
@@1:	ret	;@04AE3
L04AE4:	mov	ax, bx	;@04AE4
	mul	si	;@04AE6
	mov	word ptr ds:[53C2h], ax	;@04AE8
	mov	word ptr ds:[53C4h], dx	;@04AEB
	mov	byte ptr ds:[53C6h], 0	;@04AEF
	jcxz	@@2	;@04AF4
	and	di, di	;@04AF6
	je	@@3	;@04AF8
@@1:	stc	;@04AFA
	ret	;@04AFB
@@2:	mov	ax, bx	;@04AFC
	mul	di	;@04AFE
	add	word ptr ds:[53C4h], ax	;@04B00
	adc	dx, 0	;@04B04
	and	dx, dx	;@04B07
	jne	@@1	;@04B09
	ret	;@04B0B
@@3:	mov	ax, cx	;@04B0C
	mul	si	;@04B0E
	add	word ptr ds:[53C4h], ax	;@04B10
	adc	dx, 0	;@04B14
	and	dx, dx	;@04B17
	jne	@@1	;@04B19
	ret	;@04B1B
L04B1C:	add	di, cx	;@04B1C
	mov	al, byte ptr es:[di-1]	;@04B1E
	sub	di, cx	;@04B22
	dec	cx	;@04B24
	cmp	al, 42h	;@04B25
	jne	@@2	;@04B27
@@1:	call	L04F55	;@04B29
	jmp	short @@10	;@04B2C
@@2:	cmp	al, 51h	;@04B2E
	je	@@3	;@04B30
	cmp	al, 4Fh	;@04B32
	jne	@@4	;@04B34
@@3:	call	L04F26	;@04B36
	jmp	short @@10	;@04B39
@@4:	cmp	al, 44h	;@04B3B
	jne	@@6	;@04B3D
@@5:	call	L04E98	;@04B3F
	jmp	short @@10	;@04B42
@@6:	cmp	al, 48h	;@04B44
	jne	@@8	;@04B46
@@7:	call	L04E57	;@04B48
	jmp	short @@10	;@04B4B
@@8:	cmp	al, 52h	;@04B4D
	jne	@@9	;@04B4F
	call	L05031	;@04B51
	jmp	short @@10	;@04B54
@@9:	inc	cx	;@04B56
	mov	al, byte ptr ds:[516Ah]	;@04B57
	and	al, 0Fh	;@04B5A
	je	@@5	;@04B5C
	inc	al	;@04B5E
	cmp	al, 2	;@04B60
	je	@@1	;@04B62
	cmp	al, 8	;@04B64
	je	@@3	;@04B66
	cmp	al, 10h	;@04B68
	je	@@7	;@04B6A
	jmp	@@5	;@04B6C
@@10:	ret	;@04B6E
L04B6F:	mov	al, byte ptr es:[di]	;@04B6F
	cmp	al, 30h	;@04B72
	jne	@@1	;@04B74
	inc	bl	;@04B76
@@1:	cmp	cl, bl	;@04B78
	jne	L04BBD	;@04B7A
L04B7C:	mov	bx, 53C2h	;@04B7C
	call	L05085	;@04B7F
@@1:	mov	al, byte ptr es:[di]	;@04B82
	sub	al, 30h	;@04B85
	jb	L04BBD	;@04B87
	cmp	al, 0Ah	;@04B89
	jb	@@2	;@04B8B
	add	al, 30h	;@04B8D
	sub	al, 41h	;@04B8F
	jb	L04BBD	;@04B91
	add	al, 0Ah	;@04B93
	cmp	al, 10h	;@04B95
	jae	L04BBD	;@04B97
@@2:	mov	bx, 53C2h	;@04B99
	call	L050B7	;@04B9C
	jb	@@3	;@04B9F
	call	L050B7	;@04BA1
	jb	@@3	;@04BA4
	call	L050B7	;@04BA6
	jb	@@3	;@04BA9
	call	L050B7	;@04BAB
	jb	@@3	;@04BAE
	add	byte ptr ds:[53C2h], al	;@04BB0
	inc	di	;@04BB4
	loop	@@1	;@04BB5
	jmp	L05067	;@04BB7
@@3:	jmp	L0502C	;@04BBA
L04BBD:	jmp	L05034	;@04BBD
L04BC0:	mov	bx, 53C2h	;@04BC0
	call	L05085	;@04BC3
@@1:	mov	al, byte ptr es:[di]	;@04BC6
	sub	al, 30h	;@04BC9
	jb	L04C0A	;@04BCB
	cmp	al, 0Ah	;@04BCD
	jae	L04C0A	;@04BCF
	push	ax	;@04BD1
	mov	bx, 53C2h	;@04BD2
	mov	ax, 55C6h	;@04BD5
	call	L050A2	;@04BD8
	call	L050B7	;@04BDB
	jb	L04C06	;@04BDE
	call	L050B7	;@04BE0
	jb	L04C06	;@04BE3
	mov	ax, bx	;@04BE5
	mov	bx, 55C6h	;@04BE7
	call	L050C5	;@04BEA
	jb	L04C06	;@04BED
	mov	bx, 53C2h	;@04BEF
	call	L050B7	;@04BF2
	jb	L04C06	;@04BF5
	pop	ax	;@04BF7
	mov	bx, 53C2h	;@04BF8
	call	L050D9	;@04BFB
	jb	L04C07	;@04BFE
	inc	di	;@04C00
	loop	@@1	;@04C01
L04C03:	jmp	L05067	;@04C03
L04C06:	pop	ax	;@04C06
L04C07:	jmp	L0502C	;@04C07
L04C0A:	jmp	L05034	;@04C0A
L04C0D:	mov	bx, 53C2h	;@04C0D
	call	L05085	;@04C10
@@1:	mov	al, byte ptr es:[di]	;@04C13
	sub	al, 30h	;@04C16
	jb	@@3	;@04C18
	cmp	al, 0Ah	;@04C1A
	jae	@@3	;@04C1C
	mov	bx, 53C2h	;@04C1E
	call	L050B7	;@04C21
	jb	@@2	;@04C24
	call	L050B7	;@04C26
	jb	@@2	;@04C29
	call	L050B7	;@04C2B
	jb	@@2	;@04C2E
	call	L050B7	;@04C30
	jb	@@2	;@04C33
	add	byte ptr ds:[53C2h], al	;@04C35
	inc	di	;@04C39
	loop	@@1	;@04C3A
	jmp	L05054	;@04C3C
@@2:	jmp	L0502C	;@04C3F
@@3:	jmp	L05034	;@04C42
L04C45:	mov	bx, 53C2h	;@04C45
	call	L05085	;@04C48
@@1:	mov	al, byte ptr es:[di]	;@04C4B
	sub	al, 30h	;@04C4E
	jb	@@3	;@04C50
	cmp	al, 8	;@04C52
	jae	@@3	;@04C54
	mov	bx, 53C2h	;@04C56
	call	L050B7	;@04C59
	jb	@@2	;@04C5C
	call	L050B7	;@04C5E
	jb	@@2	;@04C61
	call	L050B7	;@04C63
	jb	@@2	;@04C66
	add	byte ptr ds:[53C2h], al	;@04C68
	inc	di	;@04C6C
	loop	@@1	;@04C6D
	jmp	L05067	;@04C6F
@@2:	jmp	L0502C	;@04C72
@@3:	jmp	L05034	;@04C75
L04C78:	mov	bx, 53C2h	;@04C78
	call	L05085	;@04C7B
@@1:	mov	al, byte ptr es:[di]	;@04C7E
	sub	al, 30h	;@04C81
	jb	@@3	;@04C83
	cmp	al, 2	;@04C85
	jae	@@3	;@04C87
	mov	bx, 53C2h	;@04C89
	call	L050B7	;@04C8C
	jb	@@2	;@04C8F
	add	byte ptr ds:[53C2h], al	;@04C91
	inc	di	;@04C95
	loop	@@1	;@04C96
	jmp	L05067	;@04C98
@@2:	jmp	L0502C	;@04C9B
@@3:	jmp	L05034	;@04C9E
L04CA1:	call	L04D09	;@04CA1
	push	si	;@04CA4
	mov	si, bx	;@04CA5
	mov	cx, 4	;@04CA7
	mov	ax, 200h	;@04CAA
	call	L051EA	;@04CAD
	pop	si	;@04CB0
	mov	ax, word ptr [bx+1]	;@04CB1
	mov	word ptr [bx], ax	;@04CB4
	mov	ax, word ptr [bx+3]	;@04CB6
	mov	word ptr [bx+2], ax	;@04CB9
	mov	ax, word ptr [bx+5]	;@04CBC
	mov	word ptr [bx+4], ax	;@04CBF
	mov	al, byte ptr [bx+7]	;@04CC2
	mov	byte ptr [bx+6], al	;@04CC5
	mov	cx, 3	;@04CC8
@@1:	shr	byte ptr [bx+6], 1	;@04CCB
	rcr	word ptr [bx+4], 1	;@04CCE
	rcr	word ptr [bx+2], 1	;@04CD1
	rcr	word ptr [bx], 1	;@04CD4
	loop	@@1	;@04CD6
	and	word ptr [bx+6], 0Fh	;@04CD8
	mov	ax, word ptr [bx+8]	;@04CDC
	and	ax, 7FFFh	;@04CDF
	je	@@2	;@04CE2
	sub	ax, 3FFFh	;@04CE4
	add	ax, 3FFh	;@04CE7
	test	ah, 0F8h	;@04CEA
	je	@@2	;@04CED
	mov	dx, 8	;@04CEF
	jmp	L0502C	;@04CF2
@@2:	shl	ax, 1	;@04CF5
	shl	ax, 1	;@04CF7
	shl	ax, 1	;@04CF9
	shl	ax, 1	;@04CFB
	or	word ptr [bx+6], ax	;@04CFD
	mov	al, byte ptr [bx+9]	;@04D00
	and	al, 80h	;@04D03
	or	byte ptr [bx+7], al	;@04D05
	ret	;@04D08
L04D09:	mov	dx, 4	;@04D09
	mov	bx, 53C2h	;@04D0C
	call	L05085	;@04D0F
	mov	word ptr ds:[53CAh], 403Eh	;@04D12
	xor	dx, dx	;@04D18
@@1:	mov	al, byte ptr es:[di]	;@04D1A
	cmp	al, 45h	;@04D1D
	je	@@8	;@04D1F
	cmp	al, 2Eh	;@04D21
	jne	@@2	;@04D23
	mov	dl, 0FFh	;@04D25
	jmp	short @@4	;@04D27
@@2:	sub	al, 30h	;@04D29
	jb	@@7	;@04D2B
	cmp	al, 0Ah	;@04D2D
	jae	@@7	;@04D2F
	and	dl, dl	;@04D31
	je	@@3	;@04D33
	dec	word ptr ds:[53CAh]	;@04D35
@@3:	and	dh, dh	;@04D39
	jne	@@6	;@04D3B
	push	dx	;@04D3D
	push	ax	;@04D3E
	mov	bx, 53C2h	;@04D3F
	mov	ax, 55C6h	;@04D42
	mov	dx, 4	;@04D45
	call	L050A2	;@04D48
	mov	bx, 55C6h	;@04D4B
	call	L050B7	;@04D4E
	jb	@@5	;@04D51
	call	L050B7	;@04D53
	jb	@@5	;@04D56
	mov	ax, bx	;@04D58
	mov	bx, 53C2h	;@04D5A
	call	L050C5	;@04D5D
	jb	@@5	;@04D60
	mov	bx, 55C6h	;@04D62
	call	L050B7	;@04D65
	jb	@@5	;@04D68
	pop	ax	;@04D6A
	push	ax	;@04D6B
	call	L050D9	;@04D6C
	jb	@@5	;@04D6F
	mov	ax, 53C2h	;@04D71
	mov	bx, 55C6h	;@04D74
	call	L050A2	;@04D77
	pop	ax	;@04D7A
	pop	dx	;@04D7B
@@4:	inc	di	;@04D7C
	loop	@@1	;@04D7D
	jmp	short @@13	;@04D7F
@@5:	pop	ax	;@04D81
	pop	dx	;@04D82
	mov	dh, 0FFh	;@04D83
@@6:	inc	word ptr ds:[53CAh]	;@04D85
	jmp	@@4	;@04D89
@@7:	jmp	L04E10	;@04D8B
@@8:	inc	di	;@04D8E
	dec	cx	;@04D8F
	je	@@13	;@04D90
	mov	al, byte ptr es:[di]	;@04D92
	cmp	al, 2Dh	;@04D95
	mov	dl, 0FFh	;@04D97
	je	@@9	;@04D99
	xor	dl, dl	;@04D9B
	cmp	al, 2Bh	;@04D9D
	jne	@@10	;@04D9F
@@9:	inc	di	;@04DA1
	dec	cx	;@04DA2
	je	@@13	;@04DA3
@@10:	xor	bx, bx	;@04DA5
@@11:	mov	al, byte ptr es:[di]	;@04DA7
	sub	al, 30h	;@04DAA
	jb	L04E10	;@04DAC
	cmp	al, 0Ah	;@04DAE
	jae	L04E10	;@04DB0
	mov	bp, bx	;@04DB2
	shl	bx, 1	;@04DB4
	jb	L04E0A	;@04DB6
	shl	bx, 1	;@04DB8
	jb	L04E0A	;@04DBA
	add	bx, bp	;@04DBC
	jb	L04E0A	;@04DBE
	shl	bx, 1	;@04DC0
	jb	L04E0A	;@04DC2
	xor	ah, ah	;@04DC4
	add	bx, ax	;@04DC6
	jb	L04E0A	;@04DC8
	inc	di	;@04DCA
	loop	@@11	;@04DCB
	and	dl, dl	;@04DCD
	je	@@12	;@04DCF
	neg	bx	;@04DD1
@@12:	add	word ptr ds:[53CAh], bx	;@04DD3
	test	byte ptr ds:[53CBh], 80h	;@04DD7
	jne	L04E0A	;@04DDC
@@13:	mov	dx, word ptr ds:[53CAh]	;@04DDE
	sub	dx, 403Eh	;@04DE2
	push	dx	;@04DE6
	mov	bx, 53C2h	;@04DE7
	call	L05162	;@04DEA
	pop	dx	;@04DED
	jb	L04E0A	;@04DEE
	cmp	byte ptr ds:[55D1h], 0	;@04DF0
	je	@@14	;@04DF5
	or	byte ptr ds:[53CBh], 80h	;@04DF7
@@14:	push	si	;@04DFC
	mov	bx, 53C2h	;@04DFD
	call	L0511B	;@04E00
	pop	si	;@04E03
	jb	L04E0A	;@04E04
	mov	bx, 53C2h	;@04E06
	ret	;@04E09
L04E0A:	mov	dx, 5	;@04E0A
	jmp	L0502C	;@04E0D
L04E10:	mov	dx, 5	;@04E10
	jmp	L05034	;@04E13
L04E16:	mov	bx, 53C2h	;@04E16
	call	L05085	;@04E19
	mov	ah, byte ptr es:[di]	;@04E1C
	inc	di	;@04E1F
	dec	cx	;@04E20
@@1:	jcxz	@@3	;@04E21
	mov	al, byte ptr es:[di]	;@04E23
	inc	di	;@04E26
	dec	cx	;@04E27
	cmp	al, ah	;@04E28
	jne	@@2	;@04E2A
	jcxz	@@4	;@04E2C
	inc	di	;@04E2E
	dec	cx	;@04E2F
@@2:	mov	bx, 53C2h	;@04E30
	call	L05095	;@04E33
	and	al, al	;@04E36
	je	@@1	;@04E38
	jmp	L0502C	;@04E3A
@@3:	mov	cx, 8062h	;@04E3D
	push	dx	;@04E40
	call	L03208	;@04E41
	pop	dx	;@04E44
@@4:	jmp	L05054	;@04E45
L04E48:	mov	bl, 8	;@04E48
	mov	al, byte ptr es:[di]	;@04E4A
	cmp	al, 30h	;@04E4D
	jne	@@1	;@04E4F
	inc	bl	;@04E51
@@1:	cmp	cl, bl	;@04E53
L04E55:	jne	L04E95	;@04E55
L04E57:	xor	dx, dx	;@04E57
	xor	bx, bx	;@04E59
@@1:	mov	al, byte ptr es:[di]	;@04E5B
	sub	al, 30h	;@04E5E
	jb	L04E95	;@04E60
	cmp	al, 0Ah	;@04E62
	jb	@@2	;@04E64
	add	al, 30h	;@04E66
	sub	al, 41h	;@04E68
	jb	L04E95	;@04E6A
	add	al, 0Ah	;@04E6C
	cmp	al, 10h	;@04E6E
	jae	L04E95	;@04E70
@@2:	shl	bx, 1	;@04E72
	rcl	dx, 1	;@04E74
	jb	@@3	;@04E76
	shl	bx, 1	;@04E78
	rcl	dx, 1	;@04E7A
	jb	@@3	;@04E7C
	shl	bx, 1	;@04E7E
	rcl	dx, 1	;@04E80
	jb	@@3	;@04E82
	shl	bx, 1	;@04E84
	rcl	dx, 1	;@04E86
	jb	@@3	;@04E88
	add	bl, al	;@04E8A
	inc	di	;@04E8C
	loop	@@1	;@04E8D
	jmp	L050EB	;@04E8F
@@3:	jmp	L05029	;@04E92
L04E95:	jmp	L05031	;@04E95
L04E98:	xor	bx, bx	;@04E98
	xor	dx, dx	;@04E9A
@@1:	mov	al, byte ptr es:[di]	;@04E9C
	sub	al, 30h	;@04E9F
	jb	@@3	;@04EA1
	cmp	al, 0Ah	;@04EA3
	jae	@@3	;@04EA5
	shl	bx, 1	;@04EA7
	rcl	dx, 1	;@04EA9
	jb	@@2	;@04EAB
	mov	word ptr ds:[53C2h], bx	;@04EAD
	mov	word ptr ds:[53C4h], dx	;@04EB1
	shl	bx, 1	;@04EB5
	rcl	dx, 1	;@04EB7
	jb	@@2	;@04EB9
	shl	bx, 1	;@04EBB
	rcl	dx, 1	;@04EBD
	jb	@@2	;@04EBF
	add	bx, word ptr ds:[53C2h]	;@04EC1
	adc	dx, word ptr ds:[53C4h]	;@04EC5
	jb	@@2	;@04EC9
	cbw	;@04ECB
	add	bx, ax	;@04ECC
	adc	dx, 0	;@04ECE
	jb	@@2	;@04ED1
	inc	di	;@04ED3
	loop	@@1	;@04ED4
	jmp	L050EB	;@04ED6
@@2:	jmp	L05029	;@04ED9
@@3:	jmp	L05031	;@04EDC
L04EDF:	call	L04D09	;@04EDF
	push	si	;@04EE2
	mov	si, bx	;@04EE3
	add	si, 4	;@04EE5
	mov	cx, 2	;@04EE8
	mov	ax, 80h	;@04EEB
	call	L051EA	;@04EEE
	pop	si	;@04EF1
	mov	ax, word ptr [bx+6]	;@04EF2
	mov	word ptr [bx+1], ax	;@04EF5
	mov	al, byte ptr [bx+5]	;@04EF8
	mov	byte ptr [bx], al	;@04EFB
	and	word ptr [bx+2], 7Fh	;@04EFD
	mov	ax, word ptr [bx+8]	;@04F01
	and	ax, 7FFFh	;@04F04
	je	@@1	;@04F07
	sub	ax, 3FFFh	;@04F09
	add	ax, 7Fh	;@04F0C
	and	ah, ah	;@04F0F
	je	@@1	;@04F11
	jmp	L05029	;@04F13
@@1:	mov	cl, 7	;@04F16
	shl	ax, cl	;@04F18
	or	word ptr [bx+2], ax	;@04F1A
	mov	al, byte ptr [bx+9]	;@04F1D
	and	al, 80h	;@04F20
	or	byte ptr [bx+3], al	;@04F22
	ret	;@04F25
L04F26:	xor	bx, bx	;@04F26
	xor	dx, dx	;@04F28
@@1:	mov	al, byte ptr es:[di]	;@04F2A
	sub	al, 30h	;@04F2D
	jb	@@3	;@04F2F
	cmp	al, 8	;@04F31
	jae	@@3	;@04F33
	shl	bx, 1	;@04F35
	rcl	dx, 1	;@04F37
	jb	@@2	;@04F39
	shl	bx, 1	;@04F3B
	rcl	dx, 1	;@04F3D
	jb	@@2	;@04F3F
	shl	bx, 1	;@04F41
	rcl	dx, 1	;@04F43
	jb	@@2	;@04F45
	add	bl, al	;@04F47
	inc	di	;@04F49
	loop	@@1	;@04F4A
	jmp	L050EB	;@04F4C
@@2:	jmp	L05029	;@04F4F
@@3:	jmp	L05031	;@04F52
L04F55:	xor	bx, bx	;@04F55
	xor	dx, dx	;@04F57
@@1:	mov	al, byte ptr es:[di]	;@04F59
	sub	al, 30h	;@04F5C
	jb	@@3	;@04F5E
	cmp	al, 2	;@04F60
	jae	@@3	;@04F62
	shl	bx, 1	;@04F64
	rcl	dx, 1	;@04F66
	jb	@@2	;@04F68
	add	bl, al	;@04F6A
	inc	di	;@04F6C
	loop	@@1	;@04F6D
	jmp	L050EB	;@04F6F
@@2:	jmp	L05029	;@04F72
@@3:	jmp	L05031	;@04F75
L04F78:	xor	dx, dx	;@04F78
	mov	word ptr ds:[53C2h], dx	;@04F7A
	mov	word ptr ds:[53C4h], dx	;@04F7E
	mov	byte ptr ds:[53C6h], dl	;@04F82
	mov	ah, byte ptr es:[di]	;@04F86
	inc	di	;@04F89
	dec	cx	;@04F8A
@@1:	jcxz	@@4	;@04F8B
	mov	al, byte ptr es:[di]	;@04F8D
	inc	di	;@04F90
	dec	cx	;@04F91
	cmp	al, ah	;@04F92
	jne	@@2	;@04F94
	jcxz	@@5	;@04F96
	inc	di	;@04F98
	dec	cx	;@04F99
@@2:	cmp	byte ptr ds:[53C3h], 0	;@04F9A
	jne	@@6	;@04F9F
@@3:	mov	bx, word ptr ds:[53C3h]	;@04FA1
	mov	word ptr ds:[53C4h], bx	;@04FA5
	mov	bl, al	;@04FA9
	mov	bh, byte ptr ds:[53C2h]	;@04FAB
	mov	word ptr ds:[53C2h], bx	;@04FAF
	jmp	@@1	;@04FB3
@@4:	push	dx	;@04FB5
	mov	cx, 8062h	;@04FB6
	call	L03208	;@04FB9
	pop	dx	;@04FBC
@@5:	jmp	L050F8	;@04FBD
@@6:	test	word ptr ds:[5160h], 1008h	;@04FC0
	je	L05029	;@04FC6
	cmp	byte ptr ds:[53C5h], 0	;@04FC8
	je	@@3	;@04FCD
	jmp	short L05029	;@04FCF
L04FD1:	xor	dx, dx	;@04FD1
	mov	word ptr ds:[53C2h], dx	;@04FD3
	mov	word ptr ds:[53C4h], dx	;@04FD7
	mov	byte ptr ds:[53C6h], dl	;@04FDB
	mov	ah, byte ptr es:[di]	;@04FDF
	xor	bx, bx	;@04FE2
	dec	cx	;@04FE4
	inc	di	;@04FE5
@@1:	jcxz	@@3	;@04FE6
	mov	al, byte ptr es:[di]	;@04FE8
	inc	di	;@04FEB
	dec	cx	;@04FEC
	cmp	al, ah	;@04FED
	jne	@@2	;@04FEF
	jcxz	@@4	;@04FF1
	inc	di	;@04FF3
	dec	cx	;@04FF4
@@2:	mov	byte ptr [bx+53C2h], al	;@04FF5
	inc	bx	;@04FF9
	jmp	@@1	;@04FFA
@@3:	push	bx	;@04FFC
	mov	cx, 8062h	;@04FFD
	call	L03208	;@05000
	pop	bx	;@05003
@@4:	mov	cx, bx	;@05004
L05006:	cmp	byte ptr ds:[55D1h], 0	;@05006
	je	@@2	;@0500B
	cmp	cx, 5	;@0500D
	jb	@@1	;@05010
	call	L05029	;@05012
	mov	cx, 1	;@05015
	ret	;@05018
@@1:	call	L050F8	;@05019
	mov	cx, 1	;@0501C
@@2:	ret	;@0501F
L05020:	push	di	;@05020
	push	cx	;@05021
	mov	al, 2Eh	;@05022
	repne scasb	;@05024
	pop	cx	;@05026
	pop	di	;@05027
	ret	;@05028
L05029:	mov	dx, 2	;@05029
L0502C:	mov	cx, 14h	;@0502C
	jmp	short L05037	;@0502F
L05031:	mov	dx, 2	;@05031
L05034:	mov	cx, 4	;@05034
L05037:	mov	bx, 53C2h	;@05037
	call	L05085	;@0503A
	cmp	byte ptr ds:[38D9h], 0	;@0503D
	jne	@@1	;@05042
	cmp	byte ptr ds:[38DAh], 0	;@05044
	jne	@@2	;@05049
	jmp	L03208	;@0504B
@@1:	stc	;@0504E
	mov	sp, word ptr ds:[38BCh]	;@0504F
@@2:	ret	;@05053
L05054:	cmp	byte ptr ds:[55D1h], 0	;@05054
	je	@@1	;@05059
	mov	bx, 53C2h	;@0505B
	add	bx, dx	;@0505E
	add	bx, dx	;@05060
	xor	byte ptr [bx-1], 80h	;@05062
@@1:	ret	;@05066
L05067:	cmp	byte ptr ds:[55D1h], 0	;@05067
	je	@@2	;@0506C
	mov	bx, 53C2h	;@0506E
	push	cx	;@05071
	mov	cx, dx	;@05072
	stc	;@05074
@@1:	mov	ax, word ptr [bx]	;@05075
	not	ax	;@05077
	adc	ax, 0	;@05079
	mov	word ptr [bx], ax	;@0507C
	add	bx, 2	;@0507E
	loop	@@1	;@05081
	pop	cx	;@05083
@@2:	ret	;@05084
L05085:	push	cx	;@05085
	mov	cx, dx	;@05086
	xor	ax, ax	;@05088
@@1:	mov	word ptr [bx], ax	;@0508A
	add	bx, 2	;@0508C
	loop	@@1	;@0508F
	mov	byte ptr [bx], al	;@05091
	pop	cx	;@05093
	ret	;@05094
L05095:	push	cx	;@05095
	mov	cx, dx	;@05096
@@1:	xchg	byte ptr [bx], al	;@05098
	inc	bx	;@0509A
	xchg	byte ptr [bx], al	;@0509B
	inc	bx	;@0509D
	loop	@@1	;@0509E
	pop	cx	;@050A0
	ret	;@050A1
L050A2:	push	es	;@050A2
	push	si	;@050A3
	push	di	;@050A4
	push	cx	;@050A5
	mov	si, bx	;@050A6
	mov	di, ax	;@050A8
	mov	cx, dx	;@050AA
	mov	ax, ss	;@050AC
	mov	es, ax	;@050AE
	rep movsw	;@050B0
	pop	cx	;@050B2
	pop	di	;@050B3
	pop	si	;@050B4
	pop	es	;@050B5
	ret	;@050B6
L050B7:	push	cx	;@050B7
	push	bx	;@050B8
	mov	cx, dx	;@050B9
	clc	;@050BB
@@1:	rcl	word ptr [bx], 1	;@050BC
	inc	bx	;@050BE
	inc	bx	;@050BF
	loop	@@1	;@050C0
	pop	bx	;@050C2
	pop	cx	;@050C3
	ret	;@050C4
L050C5:	push	cx	;@050C5
	push	di	;@050C6
	mov	cx, dx	;@050C7
	mov	di, ax	;@050C9
	clc	;@050CB
@@1:	mov	ax, word ptr [bx]	;@050CC
	adc	word ptr [di], ax	;@050CE
	inc	bx	;@050D0
	inc	bx	;@050D1
	inc	di	;@050D2
	inc	di	;@050D3
	loop	@@1	;@050D4
	pop	di	;@050D6
	pop	cx	;@050D7
	ret	;@050D8
L050D9:	push	cx	;@050D9
	mov	cx, dx	;@050DA
	cbw	;@050DC
	clc	;@050DD
@@1:	adc	word ptr [bx], ax	;@050DE
	jae	@@2	;@050E0
	inc	bx	;@050E2
	inc	bx	;@050E3
	mov	ax, 0	;@050E4
	loop	@@1	;@050E7
@@2:	pop	cx	;@050E9
	ret	;@050EA
L050EB:	mov	word ptr ds:[53C2h], bx	;@050EB
	mov	word ptr ds:[53C4h], dx	;@050EF
	mov	byte ptr ds:[53C6h], 0	;@050F3
L050F8:	cmp	byte ptr ds:[55D1h], 0	;@050F8
	je	L0511A	;@050FD
L050FF:	not	word ptr ds:[53C2h]	;@050FF
	not	word ptr ds:[53C4h]	;@05103
	not	byte ptr ds:[53C6h]	;@05107
	add	word ptr ds:[53C2h], 1	;@0510B
	adc	word ptr ds:[53C4h], 0	;@05110
	adc	byte ptr ds:[53C6h], 0	;@05115
L0511A:	ret	;@0511A
L0511B:	test	dh, 80h	;@0511B
	je	@@1	;@0511E
	neg	dx	;@05120
	mov	si, 1B96h	;@05122
	mov	cx, 0Dh	;@05125
	cmp	dx, 4000h	;@05128
	jb	@@2	;@0512C
	stc	;@0512E
	ret	;@0512F
@@1:	mov	si, 1C18h	;@05130
	mov	cx, 0Eh	;@05133
	cmp	dx, 8000h	;@05136
	jb	@@2	;@0513A
	stc	;@0513C
	ret	;@0513D
@@2:	shr	dx, 1	;@0513E
	jae	@@3	;@05140
	mov	ax, 55C6h	;@05142
	push	dx	;@05145
	push	bx	;@05146
	mov	dx, 5	;@05147
	call	L050A2	;@0514A
	pop	di	;@0514D
	mov	bx, 55C6h	;@0514E
	push	cx	;@05151
	call	L05185	;@05152
	pop	cx	;@05155
	pop	dx	;@05156
	mov	bx, di	;@05157
	jb	@@4	;@05159
@@3:	add	si, 0Ah	;@0515B
	loop	@@2	;@0515E
	clc	;@05160
@@4:	ret	;@05161
L05162:	mov	dx, 4	;@05162
	mov	cx, 40h	;@05165
@@1:	test	byte ptr [bx+7], 80h	;@05168
	jne	@@2	;@0516C
	call	L050B7	;@0516E
	dec	word ptr [bx+8]	;@05171
	loop	@@1	;@05174
	mov	word ptr [bx+8], 0	;@05176
	clc	;@0517B
	ret	;@0517C
@@2:	test	byte ptr [bx+9], 80h	;@0517D
	je	@@3	;@05181
	stc	;@05183
@@3:	ret	;@05184
L05185:	push	bx	;@05185
	push	si	;@05186
	push	di	;@05187
	mov	cx, 4	;@05188
	call	L0520C	;@0518B
	pop	di	;@0518E
	pop	si	;@0518F
	pop	bx	;@05190
	mov	ax, word ptr [bx+8]	;@05191
	and	ax, 7FFFh	;@05194
	mov	dx, word ptr [si+8]	;@05197
	and	dx, 7FFFh	;@0519A
	add	ax, dx	;@0519E
	sub	ax, 3FFEh	;@051A0
	push	bx	;@051A3
	push	si	;@051A4
	push	di	;@051A5
	push	ax	;@051A6
	mov	si, di	;@051A7
	test	byte ptr [si+0Fh], 80h	;@051A9
	jne	@@1	;@051AD
	mov	bx, si	;@051AF
	add	bx, 6	;@051B1
	mov	dx, 5	;@051B4
	call	L050B7	;@051B7
	pop	ax	;@051BA
	dec	ax	;@051BB
	push	ax	;@051BC
@@1:	mov	ax, si	;@051BD
	mov	bx, si	;@051BF
	add	bx, 8	;@051C1
	mov	dx, 4	;@051C4
	call	L050A2	;@051C7
	pop	ax	;@051CA
	pop	di	;@051CB
	pop	si	;@051CC
	pop	bx	;@051CD
	mov	word ptr [di+8], ax	;@051CE
	push	bx	;@051D1
	push	si	;@051D2
	push	di	;@051D3
	mov	bx, di	;@051D4
	call	L05162	;@051D6
	pop	di	;@051D9
	pop	si	;@051DA
	pop	bx	;@051DB
	jb	@@2	;@051DC
	mov	al, byte ptr [bx+9]	;@051DE
	xor	al, byte ptr [si+9]	;@051E1
	and	al, 80h	;@051E4
	or	byte ptr [di+9], al	;@051E6
@@2:	ret	;@051E9
L051EA:	add	word ptr [si], ax	;@051EA
@@1:	jae	@@3	;@051EC
	dec	cx	;@051EE
	jcxz	@@2	;@051EF
	add	si, 2	;@051F1
	add	word ptr [si], 1	;@051F4
	jmp	@@1	;@051F7
@@2:	shr	word ptr [bx+6], 1	;@051F9
	rcr	word ptr [bx+4], 1	;@051FC
	rcr	word ptr [bx+2], 1	;@051FF
	rcr	word ptr [bx], 1	;@05202
	or	byte ptr [bx+7], 80h	;@05204
	inc	word ptr [bx+8]	;@05208
@@3:	ret	;@0520B
L0520C:	mov	dx, cx	;@0520C
	push	di	;@0520E
	xor	ax, ax	;@0520F
@@1:	mov	word ptr [di], ax	;@05211
	add	di, 2	;@05213
	mov	word ptr [di], ax	;@05216
	add	di, 2	;@05218
	loop	@@1	;@0521B
	pop	di	;@0521D
	mov	cx, dx	;@0521E
@@2:	push	dx	;@05220
	push	cx	;@05221
	push	bx	;@05222
	push	di	;@05223
	mov	cx, dx	;@05224
@@3:	mov	ax, word ptr [si]	;@05226
	mov	dx, word ptr [bx]	;@05228
	and	ax, ax	;@0522A
	je	@@6	;@0522C
	and	dx, dx	;@0522E
	je	@@6	;@05230
	mul	dx	;@05232
	push	di	;@05234
	add	di, 2	;@05235
	add	word ptr [di-2], ax	;@05238
	adc	word ptr [di], dx	;@0523B
	jae	@@5	;@0523D
@@4:	add	di, 2	;@0523F
	add	word ptr [di], 1	;@05242
	jb	@@4	;@05245
@@5:	pop	di	;@05247
@@6:	add	bx, 2	;@05248
	add	di, 2	;@0524B
	loop	@@3	;@0524E
	pop	di	;@05250
	pop	bx	;@05251
	pop	cx	;@05252
	pop	dx	;@05253
	add	si, 2	;@05254
	add	di, 2	;@05257
	loop	@@2	;@0525A
	ret	;@0525C
L0525D:	and	di, di	;@0525D
	jne	@@1	;@0525F
	xor	di, cx	;@05261
	mov	byte ptr ds:[55D0h], 0	;@05263
	div	cx	;@05268
	nop	;@0526A
	nop	;@0526B
	shl	byte ptr ds:[55D0h], 1	;@0526C
	jb	@@1	;@05270
	ret	;@05272
@@1:	xor	ax, ax	;@05273
	mov	cx, 76h	;@05275
	call	L03208	;@05278
	mov	dx, ax	;@0527B
	ret	;@0527D
L0527E:	push	ds	;@0527E
	mov	ax, seg DATA_START	;@0527F
	mov	ds, ax	;@05282
	mov	byte ptr ds:[55D0h], 0FFh	;@05284
	pop	ds	;@05289
	sti	;@0528A
	pop	ax	;@0528B
	add	ax, 2	;@0528C
	push	ax	;@0528F
	iret	;@05290
	db	0	;@05291
L05292:	xor	ax, ax	;@05292
	mov	word ptr ds:[55E2h], ax	;@05294
	ret	;@05297
L05298:	xor	ax, ax	;@05298
	mov	word ptr ds:[55E4h], ax	;@0529A
	mov	word ptr ds:[55E8h], ax	;@0529D
	mov	di, 5678h	;@052A0
	push	ds	;@052A3
	pop	es	;@052A4
	mov	cx, 0Dh	;@052A5
	rep stosw	;@052A8
	mov	bx, 3546h	;@052AA
	mov	cx, 2Ch	;@052AD
	call	L0042B	;@052B0
	mov	word ptr ds:[55DCh], ax	;@052B3
	mov	bx, 35E0h	;@052B6
	mov	cx, 0Ah	;@052B9
	call	L0042B	;@052BC
	mov	word ptr ds:[55DEh], ax	;@052BF
	mov	di, 55EAh	;@052C2
	mov	bx, 3546h	;@052C5
	mov	cx, 2Ch	;@052C8
	xor	al, al	;@052CB
	call	L00462	;@052CD
	mov	di, 5642h	;@052D0
	mov	bx, 3613h	;@052D3
	mov	cx, 1Bh	;@052D6
	xor	al, al	;@052D9
	call	L00462	;@052DB
	call	L071CE	;@052DE
	mov	si, 1CAAh	;@052E1
	mov	bx, 1CA4h	;@052E4
	mov	cx, 1	;@052E7
@@1:	push	cx	;@052EA
	mov	cl, byte ptr [bx]	;@052EB
	inc	bx	;@052ED
	push	bx	;@052EE
	xor	ch, ch	;@052EF
	push	cx	;@052F1
	call	L003E8	;@052F2
	pop	cx	;@052F5
	pop	bx	;@052F6
	add	bx, cx	;@052F7
	push	ax	;@052F9
	call	L05542	;@052FA
	pop	dx	;@052FD
	lodsb	;@052FE
	cbw	;@052FF
	mov	word ptr es:[0Ah], ax	;@05300
	mov	ax, es	;@05304
	mov	es, dx	;@05306
	push	si	;@05308
	push	bx	;@05309
	call	L0192E	;@0530A
	pop	bx	;@0530D
	pop	si	;@0530E
	pop	cx	;@0530F
	loop	@@1	;@05310
	mov	ax, word ptr ds:[563Ch]	;@05312
	mov	word ptr ds:[55DAh], ax	;@05315
	ret	;@05318
L05319:	mov	dx, word ptr ds:[55E2h]	;@05319
	and	dx, dx	;@0531D
	je	@@1	;@0531F
	mov	word ptr ds:[55E2h], 0	;@05321
	mov	ax, word ptr ds:[55E0h]	;@05327
	call	far ptr L0FAA6	;@0532A
	clc	;@0532F
	ret	;@05330
@@1:	stc	;@05331
	ret	;@05332
L05333:	mov	cx, word ptr ds:[55E4h]	;@05333
	jcxz	@@1	;@05337
	mov	es, cx	;@05339
	mov	ax, word ptr es:[0]	;@0533B
	and	ax, ax	;@0533F
	jne	@@2	;@05341
	mov	ax, cx	;@05343
	inc	ax	;@05345
	mov	word ptr ds:[55E6h], ax	;@05346
	mov	ax, word ptr es:[2]	;@05349
	dec	ax	;@0534D
	mov	word ptr ds:[55E8h], ax	;@0534E
@@1:	ret	;@05351
@@2:	mov	word ptr ds:[55E4h], ax	;@05352
	mov	ax, cx	;@05355
	mov	dx, word ptr es:[2]	;@05357
	call	far ptr L0FAA6	;@0535C
	jmp	L05333	;@05361
L05363:	mov	es, word ptr ds:[5638h]	;@05363
	call	L018F9	;@05367
	mov	es, ax	;@0536A
	test	byte ptr es:[4], 4	;@0536C
	je	@@3	;@05372
	mov	al, byte ptr es:[1]	;@05374
	cmp	al, 4	;@05378
	jne	@@3	;@0537A
	test	word ptr ds:[5160h], 1000h	;@0537C
	jne	@@1	;@05382
	mov	ax, word ptr ds:[5162h]	;@05384
	and	ax, ax	;@05387
	je	@@2	;@05389
	cmp	ax, word ptr es:[1Ah]	;@0538B
	je	@@2	;@05390
	push	es	;@05392
	mov	es, ax	;@05393
	call	L0150E	;@05395
	pop	es	;@05398
	cmp	ax, word ptr es:[1Ah]	;@05399
	je	@@2	;@0539E
	push	es	;@053A0
	mov	es, ax	;@053A1
	call	L014F8	;@053A3
	pop	es	;@053A6
	cmp	ax, word ptr es:[1Ah]	;@053A7
	jmp	short @@2	;@053AC
@@1:	xor	al, al	;@053AE
@@2:	mov	ax, word ptr es:[1Ah]	;@053B0
	mov	bx, word ptr es:[16h]	;@053B4
	ret	;@053B9
@@3:	mov	ax, word ptr ds:[5162h]	;@053BA
	xor	bx, bx	;@053BD
	ret	;@053BF
L053C0:	test	byte ptr es:[5], 10h	;@053C0
	je	@@1	;@053C6
	push	es	;@053C8
	mov	es, word ptr ds:[5894h]	;@053C9
	call	L004A1	;@053CD
	call	far ptr L10177	;@053D0
	mov	al, 20h	;@053D5
	call	far ptr L1016C	;@053D7
	pop	es	;@053DC
@@1:	test	word ptr es:[4], 8080h	;@053DD
	je	@@2	;@053E4
	push	es	;@053E6
	mov	al, 5Bh	;@053E7
	call	far ptr L1016C	;@053E9
	pop	es	;@053EE
	call	@@2	;@053EF
	push	es	;@053F2
	mov	al, 5Dh	;@053F3
	call	far ptr L1016C	;@053F5
	pop	es	;@053FA
	ret	;@053FB
@@2:	mov	al, byte ptr es:[1]	;@053FC
	and	al, 7	;@05400
	xor	ah, ah	;@05402
	shl	ax, 1	;@05404
	mov	bx, ax	;@05406
	jmp	word ptr [bx+1D1Eh]	;@05408
L0540C:	call	L054FC	;@0540C
	push	es	;@0540F
	mov	al, 3Ah	;@05410
	call	far ptr L1016C	;@05412
	pop	es	;@05417
	test	byte ptr es:[4], 40h	;@05418
	je	@@1	;@0541E
	call	L054AC	;@05420
	mov	ax, word ptr es:[0Ah]	;@05423
	or	ax, word ptr es:[0Ch]	;@05427
	je	@@2	;@0542C
	cmp	byte ptr es:[24h], 0	;@0542E
	jne	@@1	;@05434
	push	es	;@05436
	mov	al, 2Bh	;@05437
	call	far ptr L1016C	;@05439
	pop	es	;@0543E
@@1:	test	byte ptr es:[4], 1	;@0543F
	jne	@@3	;@05445
	mov	ax, word ptr es:[0Ah]	;@05447
	mov	dx, word ptr es:[0Ch]	;@0544B
	mov	cl, byte ptr es:[24h]	;@05450
	mov	ch, byte ptr es:[1]	;@05455
	push	es	;@0545A
	call	far ptr L1018B	;@0545B
	pop	es	;@05460
@@2:	ret	;@05461
@@3:	push	es	;@05462
	mov	es, word ptr es:[8]	;@05463
	call	L004A1	;@05468
	call	far ptr L10177	;@0546B
	pop	es	;@05470
	ret	;@05471
L05472:	mov	ax, word ptr es:[18h]	;@05472
	push	es	;@05476
	mov	es, ax	;@05477
	call	L004A1	;@05479
	call	far ptr L10177	;@0547C
	pop	es	;@05481
	mov	ax, word ptr es:[0Ah]	;@05482
	or	ax, word ptr es:[0Ch]	;@05486
	je	@@1	;@0548B
	push	es	;@0548D
	mov	al, 2Bh	;@0548E
	call	far ptr L1016C	;@05490
	pop	es	;@05495
	mov	ax, word ptr es:[0Ah]	;@05496
	mov	dx, word ptr es:[0Ch]	;@0549A
	mov	cl, byte ptr es:[24h]	;@0549F
	push	es	;@054A4
	call	far ptr L1018B	;@054A5
	pop	es	;@054AA
@@1:	ret	;@054AB
L054AC:	push	es	;@054AC
	mov	es, word ptr es:[0Eh]	;@054AD
	call	L004A1	;@054B2
	call	far ptr L10177	;@054B5
	pop	es	;@054BA
	test	byte ptr es:[4], 20h	;@054BB
	je	@@1	;@054C1
	push	es	;@054C3
	mov	al, 2Ah	;@054C4
	call	far ptr L1016C	;@054C6
	pop	es	;@054CB
	mov	ax, word ptr es:[10h]	;@054CC
	xor	dx, dx	;@054D0
	mov	cx, dx	;@054D2
	push	es	;@054D4
	call	far ptr L1018B	;@054D5
	pop	es	;@054DA
@@1:	test	byte ptr es:[4], 10h	;@054DB
	je	@@2	;@054E1
	push	es	;@054E3
	mov	al, 2Bh	;@054E4
	call	far ptr L1016C	;@054E6
	pop	es	;@054EB
	push	es	;@054EC
	mov	es, word ptr es:[12h]	;@054ED
	call	L004A1	;@054F2
	call	far ptr L10177	;@054F5
	pop	es	;@054FA
@@2:	ret	;@054FB
L054FC:	mov	ax, word ptr es:[14h]	;@054FC
	and	ax, ax	;@05500
	jne	@@1	;@05502
	mov	ax, word ptr es:[18h]	;@05504
@@1:	push	es	;@05508
	mov	es, ax	;@05509
	call	L004A1	;@0550B
	call	far ptr L10177	;@0550E
	pop	es	;@05513
	cmp	word ptr es:[16h], 0	;@05514
	je	@@2	;@0551A
	push	es	;@0551C
	mov	al, 2Bh	;@0551D
	call	far ptr L1016C	;@0551F
	pop	es	;@05524
	mov	ax, word ptr es:[16h]	;@05525
	cwd	;@05529
	mov	cl, dl	;@0552A
	push	es	;@0552C
	call	far ptr L1018B	;@0552D
	pop	es	;@05532
@@2:	ret	;@05533
L05534:	mov	ax, word ptr ds:[5636h]	;@05534
	mov	word ptr ds:[55DAh], ax	;@05537
	ret	;@0553A
L0553B:	mov	ax, word ptr ds:[563Ch]	;@0553B
	mov	word ptr ds:[55DAh], ax	;@0553E
	ret	;@05541
L05542:	cmp	word ptr ds:[55E8h], 0	;@05542
	je	L05568	;@05547
L05549:	mov	es, word ptr ds:[55E6h]	;@05549
	mov	ax, 3	;@0554D
	add	word ptr ds:[55E6h], ax	;@05550
	sub	word ptr ds:[55E8h], ax	;@05554
L05558:	xor	ax, ax	;@05558
	mov	di, ax	;@0555A
	mov	cx, 14h	;@0555C
	rep stosw	;@0555F
	mov	byte ptr es:[10h], 1	;@05561
	ret	;@05567
L05568:	mov	ax, 61h	;@05568
	mov	cx, ax	;@0556B
	call	far ptr L0FB18	;@0556D
	mov	es, ax	;@05572
	mov	word ptr es:[2], cx	;@05574
	dec	cx	;@05579
	mov	word ptr ds:[55E8h], cx	;@0557A
	mov	cx, word ptr ds:[55E4h]	;@0557E
	mov	word ptr es:[0], cx	;@05582
	mov	word ptr ds:[55E4h], ax	;@05587
	inc	ax	;@0558A
	mov	word ptr ds:[55E6h], ax	;@0558B
	jmp	L05549	;@0558E
L05590:	call	L05542	;@05590
	call	L06D7E	;@05593
	call	L06E14	;@05596
	xor	al, al	;@05599
	ret	;@0559B
	db	8Bh, 0D8h, 0E8h, 0A1h, 0FFh, 26h, 89h, 1Eh, 0Ah, 0, 26h, 89h, 16h	;@0559C
	db	0Ch, 0, 0C3h
L055AC:	mov	dx, si	;@055AC
	mov	ds, ax	;@055AE
	cmp	word ptr ds:[6], 0	;@055B0
	jne	@@2	;@055B5
	cmp	byte ptr es:[di], 0	;@055B7
	je	@@1	;@055BB
	cmp	word ptr es:[di+6], 0	;@055BD
	jne	@@2	;@055C2
	cmp	word ptr ds:[4], 0	;@055C4
	jne	@@3	;@055C9
	mov	ax, word ptr ds:[0Ah]	;@055CB
	cmp	ax, word ptr es:[di+2]	;@055CE
	jne	@@3	;@055D2
	mov	ax, word ptr ds:[0Ch]	;@055D4
	cmp	ax, word ptr es:[di+4]	;@055D7
	jne	@@3	;@055DB
	mov	al, byte ptr ds:[24h]	;@055DD
	cmp	al, byte ptr es:[di+1]	;@055E0
	jmp	short @@3	;@055E4
@@1:	mov	es, word ptr es:[di+2]	;@055E6
	cmp	word ptr es:[6], 0	;@055EA
	jne	@@2	;@055F0
	xor	si, si	;@055F2
	xor	di, di	;@055F4
	mov	cx, 28h	;@055F6
	repe cmpsb	;@055F9
	mov	si, dx	;@055FB
	mov	ax, ss	;@055FD
	mov	ds, ax	;@055FF
	ret	;@05601
@@2:	xor	al, al	;@05602
@@3:	mov	si, dx	;@05604
	push	ss	;@05606
	pop	ds	;@05607
	ret	;@05608
L05609:	cmp	byte ptr es:[di], 0	;@05609
	jne	L05656	;@0560D
	mov	es, word ptr es:[di+2]	;@0560F
L05613:	mov	dx, si	;@05613
	mov	ds, ax	;@05615
	xor	si, si	;@05617
	xor	di, di	;@05619
	mov	cx, 14h	;@0561B
	rep movsw	;@0561E
	mov	si, dx	;@05620
	push	ss	;@05622
	pop	ds	;@05623
	ret	;@05624
L05625:	cmp	byte ptr es:[di], 0	;@05625
	je	@@1	;@05629
	mov	ax, word ptr es:[di+6]	;@0562B
	ret	;@0562F
@@1:	push	es	;@05630
	mov	es, word ptr es:[di+2]	;@05631
	mov	ax, word ptr es:[6]	;@05635
	pop	es	;@05639
	ret	;@0563A
L0563B:	cmp	byte ptr es:[di], 0	;@0563B
	je	@@1	;@0563F
	mov	word ptr es:[di+6], 0	;@05641
	ret	;@05647
@@1:	push	es	;@05648
	mov	es, word ptr es:[di+2]	;@05649
	mov	word ptr es:[6], 0	;@0564D
	pop	es	;@05654
	ret	;@05655
L05656:	mov	ds, ax	;@05656
	cmp	word ptr ds:[4], 0	;@05658
	jne	@@1	;@0565D
	mov	ax, word ptr ds:[6]	;@0565F
	mov	word ptr es:[di+6], ax	;@05662
	mov	ax, word ptr ds:[0Ah]	;@05666
	mov	word ptr es:[di+2], ax	;@05669
	mov	ax, word ptr ds:[0Ch]	;@0566D
	mov	word ptr es:[di+4], ax	;@05670
	mov	al, byte ptr ds:[24h]	;@05674
	mov	byte ptr es:[di+1], al	;@05677
	mov	byte ptr es:[di], 1	;@0567B
	push	ss	;@0567F
	pop	ds	;@05680
	ret	;@05681
@@1:	push	ss	;@05682
	pop	ds	;@05683
	mov	dx, ax	;@05684
	cmp	word ptr ds:[55E2h], 0	;@05686
	jne	@@2	;@0568B
	mov	ax, 3	;@0568D
	mov	cx, 0C0h	;@05690
	call	far ptr L0FB18	;@05693
	mov	word ptr ds:[55E2h], cx	;@05698
	mov	word ptr ds:[55E0h], ax	;@0569C
@@2:	push	es	;@0569F
	push	di	;@056A0
	mov	ax, word ptr ds:[55E0h]	;@056A1
	mov	es, ax	;@056A4
	mov	ax, 3	;@056A6
	add	word ptr ds:[55E0h], ax	;@056A9
	sub	word ptr ds:[55E2h], ax	;@056AD
	mov	ax, dx	;@056B1
	call	L05613	;@056B3
	mov	ax, es	;@056B6
	pop	di	;@056B8
	pop	es	;@056B9
	mov	word ptr es:[di+2], ax	;@056BA
	mov	byte ptr es:[di], 0	;@056BE
	ret	;@056C2
L056C3:	mov	dx, si	;@056C3
	push	es	;@056C5
	push	di	;@056C6
	call	L05542	;@056C7
	pop	si	;@056CA
	pop	ds	;@056CB
	cmp	byte ptr [si], 0	;@056CC
	je	@@1	;@056CF
	mov	ax, word ptr [si+6]	;@056D1
	mov	word ptr es:[6], ax	;@056D4
	mov	ax, word ptr [si+2]	;@056D8
	mov	word ptr es:[0Ah], ax	;@056DB
	mov	ax, word ptr [si+4]	;@056DF
	mov	word ptr es:[0Ch], ax	;@056E2
	mov	al, byte ptr [si+1]	;@056E6
	mov	byte ptr es:[24h], al	;@056E9
	jmp	short @@2	;@056ED
@@1:	mov	ds, word ptr [si+2]	;@056EF
	xor	si, si	;@056F2
	xor	di, di	;@056F4
	mov	cx, 14h	;@056F6
	rep movsw	;@056F9
@@2:	push	ss	;@056FB
	pop	ds	;@056FC
	mov	ax, es	;@056FD
	mov	si, dx	;@056FF
	ret	;@05701
L05702:	sub	ax, word ptr ds:[55DCh]	;@05702
	jb	@@1	;@05706
	cmp	ax, 58h	;@05708
	jae	@@1	;@0570B
	test	word ptr ds:[5160h], 8	;@0570D
	jne	@@3	;@05713
	cmp	ax, 3Ch	;@05715
	jb	@@2	;@05718
	cmp	ax, 54h	;@0571A
	jb	@@3	;@0571D
@@1:	stc	;@0571F
	ret	;@05720
@@2:	cmp	ax, 10h	;@05721
	jae	@@1	;@05724
@@3:	clc	;@05726
	ret	;@05727
	db	0E8h, 0Bh, 50h, 26h, 0F6h, 6, 4, 0, 0C0h, 0C3h, 26h, 83h, 3Eh	;@05728
	db	6, 0, 0, 75h, 1, 0C3h, 0E9h, 0A5h, 17h, 0FFh, 0FFh, 0FEh
L05741:	call	L06C93	;@05741
	call	L06D7E	;@05744
	call	L06E14	;@05747
	mov	bl, byte ptr es:[0]	;@0574A
	mov	cx, word ptr es:[2]	;@0574F
	cmp	bl, 80h	;@05754
	jne	@@1	;@05757
	test	byte ptr es:[5], 40h	;@05759
	je	@@1	;@0575F
	mov	bl, byte ptr es:[25h]	;@05761
	and	bl, 7Fh	;@05766
	or	bl, 20h	;@05769
	mov	cx, word ptr es:[1Ch]	;@0576C
@@1:	sub	bl, 60h	;@05771
	cmp	bl, 27h	;@05774
	jb	@@2	;@05777
	cmp	bl, 2Ah	;@05779
	jae	@@2	;@0577C
	sub	bl, 27h	;@0577E
	xor	bh, bh	;@05781
	mov	al, byte ptr cs:[bx+573Eh]	;@05783
	cbw	;@05788
	cwd	;@05789
	mov	word ptr es:[0Ah], ax	;@0578A
	mov	word ptr es:[0Ch], dx	;@0578E
	mov	byte ptr es:[24h], ah	;@05793
	xor	ax, ax	;@05798
	jmp	short @@3	;@0579A
@@2:	call	L00094	;@0579C
	mov	word ptr es:[0Ah], ax	;@0579F
	mov	word ptr es:[0Ch], dx	;@057A3
	xor	ax, ax	;@057A8
	mov	byte ptr es:[24h], al	;@057AA
@@3:	mov	byte ptr es:[0], 0	;@057AE
	mov	word ptr es:[4], ax	;@057B4
	mov	word ptr es:[2], ax	;@057B8
	mov	word ptr es:[18h], ax	;@057BC
	mov	word ptr es:[1Ah], ax	;@057C0
	mov	byte ptr es:[1], al	;@057C4
	mov	word ptr es:[14h], ax	;@057C8
	mov	byte ptr es:[25h], al	;@057CC
	mov	word ptr es:[1Ch], ax	;@057D0
	jmp	L06C9A	;@057D4
	db	26h, 80h, 0Eh, 5, 0, 80h, 32h, 0C0h, 0C3h	;@057D7
L057E0:	mov	al, byte ptr es:[5]	;@057E0
	test	al, 10h	;@057E4
	jne	@@5	;@057E6
	test	al, 20h	;@057E8
	jne	@@6	;@057EA
@@1:	mov	ax, word ptr es:[4]	;@057EC
@@2:	and	ax, 8040h	;@057F0
	cmp	ax, 8040h	;@057F3
	jne	@@3	;@057F6
	call	L0584B	;@057F8
	test	byte ptr es:[5], 40h	;@057FB
	je	@@4	;@05801
	and	byte ptr es:[5], 0BFh	;@05803
	mov	al, byte ptr es:[25h]	;@05809
	and	al, 7Fh	;@0580D
	mov	byte ptr es:[0], al	;@0580F
	mov	ax, word ptr es:[1Ch]	;@05813
	mov	word ptr es:[2], ax	;@05817
@@3:	xor	al, al	;@0581B
@@4:	ret	;@0581D
@@5:	call	L0663D	;@0581E
	xor	ax, ax	;@05821
	mov	word ptr es:[1Ch], ax	;@05823
	mov	byte ptr es:[25h], al	;@05827
	mov	ax, word ptr es:[4]	;@0582B
	and	byte ptr es:[5], 2Fh	;@0582F
	jmp	@@2	;@05835
@@6:	call	L07092	;@05837
	jmp	@@1	;@0583A
L0583C:	test	byte ptr es:[5], 20h	;@0583C
	jne	L05845	;@05842
	ret	;@05844
L05845:	call	L07092	;@05845
	xor	al, al	;@05848
	ret	;@0584A
L0584B:	call	L06C93	;@0584B
	call	L06D7E	;@0584E
	call	L06E14	;@05851
	call	L0585A	;@05854
	jmp	L06C9A	;@05857
L0585A:	and	byte ptr es:[0], 7Fh	;@0585A
	or	byte ptr es:[4], 80h	;@05860
	mov	al, byte ptr es:[5]	;@05866
	and	al, 3	;@0586A
	shl	al, 1	;@0586C
	shl	al, 1	;@0586E
	and	byte ptr es:[5], 0F0h	;@05870
	or	byte ptr es:[5], al	;@05876
	ret	;@0587B
L0587C:	test	byte ptr es:[5], 80h	;@0587C
	je	@@1	;@05882
	call	L0584B	;@05884
@@1:	and	byte ptr es:[5], 0FCh	;@05887
	or	byte ptr es:[5], 1	;@0588D
	xor	al, al	;@05893
	ret	;@05895
L05896:	test	byte ptr es:[5], 80h	;@05896
	je	@@1	;@0589C
	call	L0584B	;@0589E
@@1:	and	byte ptr es:[5], 0FCh	;@058A1
	or	byte ptr es:[5], 2	;@058A7
	xor	al, al	;@058AD
	ret	;@058AF
L058B0:	call	L06C93	;@058B0
	mov	byte ptr es:[0], 87h	;@058B3
	jmp	L06C9A	;@058B9
L058BC:	call	L06C93	;@058BC
	test	byte ptr es:[0], 80h	;@058BF
	jne	@@1	;@058C5
	test	byte ptr es:[4], 40h	;@058C7
	je	@@2	;@058CD
	test	byte ptr es:[5], 80h	;@058CF
	je	@@2	;@058D5
	test	byte ptr es:[4], 4	;@058D7
	je	@@2	;@058DD
@@1:	test	byte ptr es:[5], 40h	;@058DF
	je	@@2	;@058E5
	call	L06D7E	;@058E7
	call	L06E14	;@058EA
	test	byte ptr es:[5], 40h	;@058ED
	je	@@2	;@058F3
	mov	al, byte ptr es:[25h]	;@058F5
	mov	di, word ptr es:[1Ch]	;@058F9
	call	L0591D	;@058FE
	mov	byte ptr es:[0], al	;@05901
	mov	word ptr es:[2], di	;@05905
	xor	ax, ax	;@0590A
	mov	word ptr es:[1Ch], ax	;@0590C
	mov	byte ptr es:[25h], al	;@05910
	and	byte ptr es:[5], 0BFh	;@05914
@@2:	jmp	L06C9A	;@0591A
L0591D:	cmp	al, 8Ah	;@0591D
	jne	@@2	;@0591F
	test	word ptr ds:[5160h], 1000h	;@05921
	jne	@@2	;@05927
	push	bx	;@05929
	mov	bl, al	;@0592A
	mov	cx, di	;@0592C
	push	bx	;@0592E
	push	di	;@0592F
	call	L00094	;@05930
	pop	di	;@05933
	pop	bx	;@05934
	and	dx, dx	;@05935
	jne	@@1	;@05937
	call	L0A5C4	;@05939
	pop	bx	;@0593C
	and	al, al	;@0593D
	je	@@1	;@0593F
	or	al, 80h	;@05941
	xor	di, di	;@05943
	jmp	short @@2	;@05945
@@1:	mov	al, 8Ah	;@05947
@@2:	ret	;@05949
L0594A:	cmp	byte ptr ds:[38D9h], 0	;@0594A
	je	@@1	;@0594F
	test	word ptr ds:[5160h], 2000h	;@05951
	jne	@@1	;@05957
	stc	;@05959
	mov	sp, word ptr ds:[38BCh]	;@0595A
	ret	;@0595E
@@1:	call	L06CA1	;@0595F
	and	byte ptr es:[5], 0EFh	;@05962
	test	byte ptr es:[0], 80h	;@05968
	jne	@@3	;@0596E
	call	L07052	;@05970
	mov	es, word ptr ds:[55D6h]	;@05973
	mov	cx, word ptr es:[4]	;@05977
	and	cx, 8040h	;@0597C
	cmp	cx, 40h	;@05980
	je	@@2	;@05983
	mov	es, word ptr ds:[55D2h]	;@05985
	mov	ax, word ptr es:[0Ah]	;@05989
	call	L0A5C4	;@0598D
	or	al, 80h	;@05990
	mov	es, word ptr ds:[55D6h]	;@05992
	or	byte ptr es:[5], 40h	;@05996
	mov	byte ptr es:[25h], al	;@0599C
	mov	word ptr es:[1Ch], 0	;@059A0
@@2:	jmp	L06CD0	;@059A7
@@3:	test	byte ptr es:[5], 20h	;@059AA
	je	@@4	;@059B0
	mov	al, byte ptr es:[0]	;@059B2
	cmp	al, 87h	;@059B6
	jb	@@4	;@059B8
	cmp	al, 8Ah	;@059BA
	jae	@@4	;@059BC
	mov	es, word ptr ds:[55D2h]	;@059BE
	test	word ptr es:[0Ah], 8000h	;@059C2
	mov	es, word ptr ds:[55D6h]	;@059C9
	jne	@@4	;@059CD
	and	byte ptr es:[5], 0DFh	;@059CF
	xor	ax, ax	;@059D5
	mov	word ptr es:[22h], ax	;@059D7
	mov	word ptr es:[1Eh], ax	;@059DB
	mov	word ptr es:[20h], ax	;@059DF
@@4:	call	L07052	;@059E3
	mov	es, word ptr ds:[55D2h]	;@059E6
	mov	ax, word ptr es:[0Ah]	;@059EA
	call	L0A5C4	;@059EE
	or	al, 80h	;@059F1
	mov	es, word ptr ds:[55D6h]	;@059F3
	mov	byte ptr es:[0], al	;@059F7
	xor	ax, ax	;@059FB
	mov	byte ptr es:[25h], al	;@059FD
	mov	word ptr es:[1Ch], ax	;@05A01
	mov	word ptr es:[2], ax	;@05A05
	and	byte ptr es:[5], 0BFh	;@05A09
	mov	es, word ptr ds:[55D2h]	;@05A0F
	test	byte ptr es:[0], 80h	;@05A13
	jne	@@5	;@05A19
	jmp	L06CD0	;@05A1B
@@5:	mov	ax, word ptr es:[14h]	;@05A1E
	mov	cx, word ptr es:[18h]	;@05A22
	mov	es, word ptr ds:[55D6h]	;@05A27
	mov	word ptr es:[14h], ax	;@05A2B
	mov	word ptr es:[18h], cx	;@05A2F
	jmp	L06CD0	;@05A34
L05A37:	call	L06CA1	;@05A37
	call	L06D7E	;@05A3A
	call	L06E14	;@05A3D
L05A40:	mov	es, word ptr ds:[55D2h]	;@05A40
	mov	al, byte ptr es:[0]	;@05A44
	mov	cx, word ptr es:[2]	;@05A48
	mov	es, word ptr ds:[55D6h]	;@05A4D
	mov	byte ptr es:[0], al	;@05A51
	mov	word ptr es:[2], cx	;@05A55
	xor	ax, ax	;@05A5A
	mov	byte ptr es:[25h], al	;@05A5C
	mov	word ptr es:[1Ch], ax	;@05A60
	jmp	L06CD0	;@05A64
L05A67:	call	L06CA1	;@05A67
	call	L06DBE	;@05A6A
	call	L06E14	;@05A6D
	mov	es, word ptr ds:[55D2h]	;@05A70
	call	L06DBE	;@05A74
	mov	es, word ptr ds:[55D2h]	;@05A77
	mov	bl, byte ptr es:[0]	;@05A7B
	sub	bl, 80h	;@05A80
	mov	cx, word ptr es:[2]	;@05A83
	call	L00094	;@05A88
	push	ax	;@05A8B
	push	dx	;@05A8C
	mov	es, word ptr ds:[55D6h]	;@05A8D
	mov	bl, byte ptr es:[0]	;@05A91
	sub	bl, 80h	;@05A96
	mov	cx, word ptr es:[2]	;@05A99
	call	L00094	;@05A9E
	pop	cx	;@05AA1
	pop	bx	;@05AA2
	sub	ax, bx	;@05AA3
	sbb	dx, cx	;@05AA5
	jb	@@1	;@05AA7
	add	word ptr es:[0Ah], ax	;@05AA9
	adc	word ptr es:[0Ch], dx	;@05AAE
	adc	byte ptr es:[24h], 0	;@05AB3
	call	L0A718	;@05AB9
@@1:	jmp	L05A40	;@05ABC
L05ABE:	call	L06CA1	;@05ABE
	call	L06DBE	;@05AC1
	call	L06E14	;@05AC4
	mov	es, word ptr ds:[55D2h]	;@05AC7
	call	L06DBE	;@05ACB
	jmp	L05A40	;@05ACE
L05AD1:	mov	bl, 80h	;@05AD1
	jmp	short L05B0E	;@05AD3
L05AD5:	mov	bl, 81h	;@05AD5
	jmp	short L05B0E	;@05AD7
L05AD9:	test	byte ptr ds:[516Bh], 2	;@05AD9
	jne	L05AED	;@05ADE
	jmp	short L05AE9	;@05AE0
L05AE2:	test	byte ptr ds:[516Bh], 8	;@05AE2
	jne	L05AED	;@05AE7
L05AE9:	mov	bl, 82h	;@05AE9
	jmp	short L05B0E	;@05AEB
L05AED:	mov	bl, 83h	;@05AED
	jmp	short L05B0E	;@05AEF
L05AF1:	mov	bl, 84h	;@05AF1
	jmp	short L05B0E	;@05AF3
L05AF5:	mov	bl, 85h	;@05AF5
	jmp	short L05B0E	;@05AF7
L05AF9:	mov	bl, 86h	;@05AF9
	jmp	short L05B0E	;@05AFB
L05AFD:	mov	bl, 87h	;@05AFD
	jmp	short L05B0E	;@05AFF
L05B01:	test	byte ptr ds:[516Bh], 2	;@05B01
	jne	@@1	;@05B06
	mov	bl, 88h	;@05B08
	jmp	short L05B0E	;@05B0A
@@1:	mov	bl, 89h	;@05B0C
L05B0E:	call	L05542	;@05B0E
	mov	byte ptr es:[0], bl	;@05B11
	xor	al, al	;@05B16
	ret	;@05B18
L05B19:	push	ax	;@05B19
	call	L05542	;@05B1A
	pop	ax	;@05B1D
	mov	byte ptr es:[0], 8Ah	;@05B1E
	mov	word ptr es:[2], ax	;@05B24
	mov	bx, ax	;@05B28
	call	L035F0	;@05B2A
	xor	al, al	;@05B2D
	ret	;@05B2F
L05B30:	mov	es, ax	;@05B30
	call	L00C46	;@05B32
	push	bx	;@05B35
	call	L05542	;@05B36
	pop	bx	;@05B39
	sub	bl, 0A0h	;@05B3A
	mov	byte ptr es:[0], bl	;@05B3D
	xor	al, al	;@05B42
	ret	;@05B44
L05B45:	mov	bx, ax	;@05B45
	call	L05542	;@05B47
	mov	word ptr es:[6], bx	;@05B4A
	test	byte ptr ds:[38D7h], 0Bh	;@05B4F
	jne	@@1	;@05B54
	or	byte ptr ds:[38D8h], 1	;@05B56
@@1:	xor	al, al	;@05B5B
	ret	;@05B5D
L05B5E:	mov	word ptr ds:[55D4h], ax	;@05B5E
	call	L06C93	;@05B61
	call	L06DA0	;@05B64
	call	L06E14	;@05B67
	cmp	byte ptr es:[0], 8Ah	;@05B6A
	jne	@@1	;@05B70
	mov	es, word ptr es:[2]	;@05B72
	mov	ax, word ptr ds:[55D4h]	;@05B77
	call	L00DBC	;@05B7A
	je	@@2	;@05B7D
	mov	es, word ptr ds:[55D2h]	;@05B7F
	sub	bl, 0A0h	;@05B83
	mov	byte ptr es:[0], bl	;@05B86
	mov	word ptr es:[2], cx	;@05B8B
	add	word ptr es:[0Ah], ax	;@05B90
	adc	word ptr es:[0Ch], dx	;@05B95
	call	L0A718	;@05B9A
@@1:	jmp	L06C9A	;@05B9D
@@2:	mov	es, word ptr ds:[55D2h]	;@05BA0
	mov	ax, word ptr es:[2]	;@05BA4
	mov	word ptr es:[6], ax	;@05BA8
	call	L06EE3	;@05BAC
	jmp	L06C9A	;@05BAF
L05BB2:	cmp	byte ptr ds:[38D9h], 0	;@05BB2
	je	@@1	;@05BB7
	test	word ptr ds:[5160h], 2000h	;@05BB9
	jne	@@1	;@05BBF
	stc	;@05BC1
	mov	sp, word ptr ds:[38BCh]	;@05BC2
	ret	;@05BC6
@@1:	call	L06CA1	;@05BC7
	test	byte ptr es:[5], 10h	;@05BCA
	je	@@2	;@05BD0
	call	L0663D	;@05BD2
	and	byte ptr es:[5], 0EFh	;@05BD5
@@2:	mov	es, word ptr ds:[55D2h]	;@05BDB
	call	L06DDC	;@05BDF
	call	L06EA3	;@05BE2
	mov	es, word ptr ds:[55D6h]	;@05BE5
	test	byte ptr es:[0], 80h	;@05BE9
	jne	@@3	;@05BEF
	test	word ptr ds:[5160h], 1000h	;@05BF1
	jne	@@3	;@05BF7
	test	byte ptr es:[4], 4	;@05BF9
	jne	@@3	;@05BFF
	call	@@3	;@05C01
	and	byte ptr es:[4], 0FBh	;@05C04
	and	byte ptr es:[0], 7Fh	;@05C0A
	xor	ax, ax	;@05C10
	mov	word ptr es:[14h], ax	;@05C12
	mov	word ptr es:[18h], ax	;@05C16
	mov	word ptr es:[1Ah], ax	;@05C1A
	mov	byte ptr es:[1], al	;@05C1E
	ret	;@05C22
@@3:	mov	es, word ptr ds:[55D2h]	;@05C23
	mov	al, byte ptr es:[4]	;@05C27
	test	al, 4	;@05C2B
	je	@@4	;@05C2D
	test	al, 40h	;@05C2F
	jne	@@5	;@05C31
	mov	al, byte ptr es:[1]	;@05C33
	and	al, 7	;@05C37
	cmp	al, 4	;@05C39
	jne	@@5	;@05C3B
@@4:	mov	es, word ptr ds:[55D6h]	;@05C3D
	test	byte ptr es:[4], 4	;@05C41
	je	@@6	;@05C47
	mov	al, byte ptr es:[1]	;@05C49
	and	al, 7	;@05C4D
	cmp	al, 4	;@05C4F
	jb	@@6	;@05C51
	test	word ptr ds:[5160h], 1000h	;@05C53
	je	@@7	;@05C59
@@5:	mov	cx, 69h	;@05C5B
	call	L0A692	;@05C5E
@@6:	mov	es, word ptr ds:[55D6h]	;@05C61
	call	L06D7E	;@05C65
	mov	es, word ptr ds:[55D2h]	;@05C68
	test	byte ptr es:[4], 40h	;@05C6C
	je	@@8	;@05C72
	mov	ax, word ptr es:[0Eh]	;@05C74
	call	L0080F	;@05C78
	je	@@9	;@05C7B
	mov	es, word ptr ds:[55D6h]	;@05C7D
	mov	word ptr es:[14h], 0	;@05C81
	mov	cx, 1Fh	;@05C88
	call	L0716B	;@05C8B
@@7:	jmp	L06CD0	;@05C8E
@@8:	mov	es, word ptr ds:[55D6h]	;@05C91
	mov	word ptr es:[14h], 0	;@05C95
	jmp	short @@11	;@05C9C
@@9:	mov	es, word ptr ds:[55D6h]	;@05C9E
	mov	word ptr es:[14h], ax	;@05CA2
	mov	word ptr es:[1Eh], ax	;@05CA6
	mov	es, ax	;@05CAA
	call	L018F9	;@05CAC
	mov	ds, ax	;@05CAF
	mov	es, word ptr ss:[55D2h]	;@05CB1
	mov	ax, word ptr ds:[6]	;@05CB6
	mov	word ptr es:[6], ax	;@05CB9
	and	ax, ax	;@05CBD
	je	@@10	;@05CBF
	push	ds	;@05CC1
	push	ss	;@05CC2
	pop	ds	;@05CC3
	call	L06EE3	;@05CC4
	pop	ds	;@05CC7
@@10:	mov	ax, word ptr ds:[0Ah]	;@05CC8
	add	word ptr es:[0Ah], ax	;@05CCB
	mov	ax, word ptr ds:[0Ch]	;@05CD0
	adc	word ptr es:[0Ch], ax	;@05CD3
	mov	al, byte ptr ds:[24h]	;@05CD8
	adc	byte ptr es:[24h], al	;@05CDB
	mov	al, byte ptr ds:[4]	;@05CE0
	and	al, 4	;@05CE3
	or	byte ptr es:[4], al	;@05CE5
	mov	al, byte ptr ds:[1]	;@05CEA
	mov	byte ptr es:[1], al	;@05CED
	mov	ax, word ptr ds:[26h]	;@05CF1
	mov	word ptr es:[26h], ax	;@05CF4
	mov	ax, word ptr ds:[18h]	;@05CF8
	mov	word ptr es:[18h], ax	;@05CFB
	mov	ax, word ptr ds:[1Ah]	;@05CFF
	mov	word ptr es:[1Ah], ax	;@05D02
	push	ss	;@05D06
	pop	ds	;@05D07
	call	L0A718	;@05D08
@@11:	mov	ax, word ptr ds:[55D2h]	;@05D0B
	mov	es, word ptr ds:[55D6h]	;@05D0E
	call	L070E2	;@05D12
	call	L0A5E6	;@05D15
	jmp	L06CD0	;@05D18
L05D1B:	call	L06C93	;@05D1B
	push	word ptr es:[6]	;@05D1E
	call	L05D37	;@05D23
	pop	word ptr es:[6]	;@05D26
	jmp	L06C9A	;@05D2B
L05D2E:	call	L06C93	;@05D2E
	call	L05D37	;@05D31
	jmp	L06C9A	;@05D34
L05D37:	xor	cl, cl	;@05D37
	cmp	word ptr es:[6], 0	;@05D39
	jne	@@9	;@05D3F
	test	byte ptr es:[4], 4	;@05D41
	je	@@1	;@05D47
	mov	ax, word ptr es:[1Ah]	;@05D49
	call	L0072A	;@05D4D
	je	@@1	;@05D50
	or	cl, 80h	;@05D52
@@1:	mov	al, byte ptr es:[0]	;@05D55
	test	al, 80h	;@05D59
	je	@@5	;@05D5B
	cmp	al, 87h	;@05D5D
	jb	@@3	;@05D5F
	cmp	al, 8Ah	;@05D61
	jae	@@3	;@05D63
	test	byte ptr es:[5], 10h	;@05D65
	je	@@2	;@05D6B
	or	cl, 4	;@05D6D
@@2:	or	cl, 21h	;@05D70
	jmp	short @@9	;@05D73
@@3:	test	byte ptr es:[4], 40h	;@05D75
	jne	@@6	;@05D7B
	test	byte ptr es:[5], 10h	;@05D7D
	jne	@@4	;@05D83
	or	cl, 2Ah	;@05D85
	jmp	short @@9	;@05D88
@@4:	or	cl, 26h	;@05D8A
	jmp	short @@9	;@05D8D
@@5:	mov	al, byte ptr es:[1]	;@05D8F
	and	al, 7	;@05D93
	cmp	al, 4	;@05D95
	jne	@@7	;@05D97
@@6:	or	cl, 20h	;@05D99
	jmp	short @@9	;@05D9C
@@7:	test	byte ptr es:[4], 40h	;@05D9E
	jne	@@8	;@05DA4
	test	byte ptr es:[4], 4	;@05DA6
	jne	@@9	;@05DAC
	or	cl, 24h	;@05DAE
	jmp	short @@9	;@05DB1
@@8:	test	word ptr es:[4], 8080h	;@05DB3
	jne	@@6	;@05DBA
	or	cl, 30h	;@05DBC
@@9:	push	cx	;@05DBF
	call	L05558	;@05DC0
	pop	cx	;@05DC3
	mov	byte ptr es:[0Ah], cl	;@05DC4
	jmp	L06C9A	;@05DC9
L05DCC:	call	L06CD7	;@05DCC
	mov	es, word ptr ds:[55D2h]	;@05DCF
	mov	ax, word ptr es:[0Ah]	;@05DD3
	mov	bx, word ptr es:[0Ch]	;@05DD7
	mov	dl, byte ptr es:[24h]	;@05DDC
	mov	es, word ptr ds:[55D6h]	;@05DE1
	or	word ptr es:[0Ah], ax	;@05DE5
	or	word ptr es:[0Ch], bx	;@05DEA
	or	byte ptr es:[24h], dl	;@05DEF
	jmp	L06CCD	;@05DF4
L05DF7:	call	L06CD7	;@05DF7
	mov	es, word ptr ds:[55D2h]	;@05DFA
	mov	ax, word ptr es:[0Ah]	;@05DFE
	mov	bx, word ptr es:[0Ch]	;@05E02
	mov	dl, byte ptr es:[24h]	;@05E07
	mov	es, word ptr ds:[55D6h]	;@05E0C
	xor	word ptr es:[0Ah], ax	;@05E10
	xor	word ptr es:[0Ch], bx	;@05E15
	xor	byte ptr es:[24h], dl	;@05E1A
	jmp	L06CCD	;@05E1F
L05E22:	call	L06CD7	;@05E22
	mov	es, word ptr ds:[55D2h]	;@05E25
	mov	ax, word ptr es:[0Ah]	;@05E29
	mov	bx, word ptr es:[0Ch]	;@05E2D
	mov	dl, byte ptr es:[24h]	;@05E32
	mov	es, word ptr ds:[55D6h]	;@05E37
	and	word ptr es:[0Ah], ax	;@05E3B
	and	word ptr es:[0Ch], bx	;@05E40
	and	byte ptr es:[24h], dl	;@05E45
	jmp	L06CCD	;@05E4A
L05E4D:	call	L06C93	;@05E4D
	call	L06DDC	;@05E50
	call	L090E2	;@05E53
	call	L0999B	;@05E56
	not	word ptr es:[0Ah]	;@05E59
	not	word ptr es:[0Ch]	;@05E5E
	not	byte ptr es:[24h]	;@05E63
	jmp	L06C9A	;@05E68
L05E6B:	call	L06031	;@05E6B
	call	L06D12	;@05E6E
	call	L05EE6	;@05E71
	mov	ax, 0FFFFh	;@05E74
	je	@@1	;@05E77
	xor	ax, ax	;@05E79
@@1:	jmp	short L05ED7	;@05E7B
L05E7D:	call	L06031	;@05E7D
	call	L06D12	;@05E80
	call	L05EE6	;@05E83
	mov	ax, 0FFFFh	;@05E86
	jne	@@1	;@05E89
	xor	ax, ax	;@05E8B
@@1:	jmp	short L05ED7	;@05E8D
L05E8F:	call	L06031	;@05E8F
	call	L06D02	;@05E92
	call	L05EE6	;@05E95
	mov	ax, 0FFFFh	;@05E98
	jb	@@1	;@05E9B
	xor	ax, ax	;@05E9D
@@1:	jmp	short L05ED7	;@05E9F
L05EA1:	call	L06031	;@05EA1
	call	L06D12	;@05EA4
	call	L05EE6	;@05EA7
	mov	ax, 0FFFFh	;@05EAA
	jbe	@@1	;@05EAD
	xor	ax, ax	;@05EAF
@@1:	jmp	short L05ED7	;@05EB1
L05EB3:	call	L06031	;@05EB3
	call	L06D02	;@05EB6
	call	L05EE6	;@05EB9
	mov	ax, 0FFFFh	;@05EBC
	ja	@@1	;@05EBF
	xor	ax, ax	;@05EC1
@@1:	jmp	short L05ED7	;@05EC3
L05EC5:	call	L06031	;@05EC5
	call	L06D12	;@05EC8
	call	L05EE6	;@05ECB
	mov	ax, 0FFFFh	;@05ECE
	jae	@@1	;@05ED1
	xor	ax, ax	;@05ED3
@@1:	jmp	short L05ED7	;@05ED5
L05ED7:	mov	word ptr es:[0Ah], ax	;@05ED7
	mov	word ptr es:[0Ch], ax	;@05EDB
	mov	byte ptr es:[24h], al	;@05EDF
	jmp	L06C9A	;@05EE3
L05EE6:	mov	ax, word ptr es:[0Ah]	;@05EE6
	test	word ptr ds:[5160h], 1008h	;@05EEA
	jne	@@1	;@05EF0
	and	ax, ax	;@05EF2
	jmp	short @@2	;@05EF4
@@1:	or	ax, word ptr es:[0Ch]	;@05EF6
@@2:	je	L05F04	;@05EFB
	mov	al, byte ptr es:[24h]	;@05EFD
	rcr	al, 1	;@05F01
	ret	;@05F03
L05F04:	mov	al, byte ptr es:[4]	;@05F04
	and	byte ptr es:[4], 8Fh	;@05F08
	test	al, 20h	;@05F0E
	jne	@@2	;@05F10
	test	al, 40h	;@05F12
	je	@@2	;@05F14
	test	al, 10h	;@05F16
	je	@@1	;@05F18
	mov	ax, word ptr es:[0Eh]	;@05F1A
	cmp	ax, word ptr es:[12h]	;@05F1E
	clc	;@05F23
	ret	;@05F24
@@1:	xor	al, al	;@05F25
	dec	al	;@05F27
@@2:	clc	;@05F29
	ret	;@05F2A
L05F2B:	call	L06CA1	;@05F2B
	mov	es, word ptr ds:[55D2h]	;@05F2E
	test	byte ptr es:[0], 80h	;@05F32
	jne	@@1	;@05F38
	call	L06DDC	;@05F3A
	call	L06E8E	;@05F3D
	mov	es, word ptr ds:[55D6h]	;@05F40
	test	byte ptr es:[0], 80h	;@05F44
	jne	@@4	;@05F4A
	call	L06DDC	;@05F4C
	call	L06E8E	;@05F4F
	call	L09636	;@05F52
	jmp	short @@5	;@05F55
@@1:	mov	es, word ptr ds:[55D6h]	;@05F57
	test	byte ptr es:[0], 80h	;@05F5B
	jne	@@3	;@05F61
@@2:	call	L06DDC	;@05F63
	call	L090E2	;@05F66
	call	L06E8E	;@05F69
	mov	es, word ptr ds:[55D2h]	;@05F6C
	mov	al, byte ptr es:[0]	;@05F70
	mov	dx, word ptr es:[2]	;@05F74
	mov	es, word ptr ds:[55D6h]	;@05F79
	mov	byte ptr es:[0], al	;@05F7D
	mov	word ptr es:[2], dx	;@05F81
	call	L0705F	;@05F86
	call	L07029	;@05F89
	jmp	short @@6	;@05F8C
@@3:	test	word ptr ds:[5160h], 1000h	;@05F8E
	jne	@@2	;@05F94
	jmp	short @@5	;@05F96
@@4:	call	L06E8E	;@05F98
@@5:	call	L07052	;@05F9B
	call	L07014	;@05F9E
@@6:	call	L06F22	;@05FA1
	mov	es, word ptr ds:[55D6h]	;@05FA4
	test	byte ptr es:[4], 4	;@05FA8
	mov	es, word ptr ds:[55D2h]	;@05FAE
	je	@@7	;@05FB2
	test	byte ptr es:[4], 4	;@05FB4
	je	@@7	;@05FBA
	mov	cx, 6Ah	;@05FBC
	call	L0A692	;@05FBF
@@7:	mov	es, word ptr ds:[55D6h]	;@05FC2
	mov	ds, word ptr ds:[55D2h]	;@05FC6
	test	byte ptr ds:[4], 4	;@05FCA
	je	@@8	;@05FCF
	or	byte ptr es:[4], 4	;@05FD1
	mov	al, byte ptr ds:[1]	;@05FD7
	mov	byte ptr es:[1], al	;@05FDA
	mov	ax, word ptr ds:[26h]	;@05FDE
	mov	word ptr es:[26h], ax	;@05FE1
	mov	ax, word ptr ds:[18h]	;@05FE5
	mov	word ptr es:[18h], ax	;@05FE8
	mov	ax, word ptr ds:[1Ah]	;@05FEC
	mov	word ptr es:[1Ah], ax	;@05FEF
	mov	ax, word ptr ds:[16h]	;@05FF3
	mov	word ptr es:[16h], ax	;@05FF6
@@8:	mov	ax, word ptr ds:[14h]	;@05FFA
	and	ax, ax	;@05FFD
	je	@@9	;@05FFF
	mov	word ptr es:[14h], ax	;@06001
@@9:	mov	ax, word ptr ds:[0Ah]	;@06005
	add	word ptr es:[0Ah], ax	;@06008
	mov	ax, word ptr ds:[0Ch]	;@0600D
	adc	word ptr es:[0Ch], ax	;@06010
	mov	al, byte ptr ds:[24h]	;@06015
	adc	byte ptr es:[24h], al	;@06018
	mov	al, byte ptr ds:[5]	;@0601D
	and	al, 3	;@06020
	or	byte ptr es:[5], al	;@06022
	mov	ax, ss	;@06027
	mov	ds, ax	;@06029
	call	L0A718	;@0602B
	jmp	L06CD0	;@0602E
L06031:	call	L06CA1	;@06031
	mov	es, word ptr ds:[55D2h]	;@06034
	test	byte ptr es:[0], 80h	;@06038
	jne	@@3	;@0603E
	call	L06DDC	;@06040
	call	L090E2	;@06043
	call	L06E8E	;@06046
	call	L07052	;@06049
	call	L07014	;@0604C
	mov	es, word ptr ds:[55D6h]	;@0604F
	test	word ptr ds:[5160h], 1000h	;@06053
	jne	@@1	;@06059
	test	byte ptr es:[0], 80h	;@0605B
	jne	@@6	;@06061
@@1:	call	L06DDC	;@06063
	call	L090E2	;@06066
	call	L06E8E	;@06069
	test	word ptr ds:[5160h], 1000h	;@0606C
	je	@@2	;@06072
	call	L099C5	;@06074
	call	L09636	;@06077
@@2:	jmp	short @@7	;@0607A
@@3:	call	L06E8E	;@0607C
	mov	es, word ptr ds:[55D6h]	;@0607F
	test	byte ptr es:[0], 80h	;@06083
	jne	@@5	;@06089
	call	L06DDC	;@0608B
	call	L090E2	;@0608E
	test	word ptr ds:[5160h], 1000h	;@06091
	je	@@4	;@06097
	call	L099C5	;@06099
@@4:	call	L0705F	;@0609C
	call	L07029	;@0609F
	mov	es, word ptr ds:[55D2h]	;@060A2
	mov	al, byte ptr es:[0]	;@060A6
	mov	dx, word ptr es:[2]	;@060AA
	mov	es, word ptr ds:[55D6h]	;@060AF
	mov	byte ptr es:[0], al	;@060B3
	mov	word ptr es:[2], dx	;@060B7
	jmp	short @@7	;@060BC
@@5:	test	word ptr ds:[5160h], 1000h	;@060BE
	je	@@6	;@060C4
	mov	al, byte ptr es:[0]	;@060C6
	mov	es, word ptr ds:[55D6h]	;@060CA
	mov	byte ptr es:[0], al	;@060CE
	call	L098B3	;@060D2
@@6:	and	byte ptr es:[5], 0DFh	;@060D5
	xor	ax, ax	;@060DB
	mov	word ptr es:[22h], ax	;@060DD
	mov	word ptr es:[20h], ax	;@060E1
	mov	word ptr es:[1Eh], ax	;@060E5
	mov	word ptr es:[2], ax	;@060E9
	mov	byte ptr es:[0], 0	;@060ED
@@7:	call	L06F22	;@060F3
	mov	es, word ptr ds:[55D6h]	;@060F6
	mov	al, byte ptr es:[1]	;@060FA
	and	al, 7	;@060FE
	je	@@10	;@06100
	cmp	word ptr es:[6], 0	;@06102
	jne	@@8	;@06108
	mov	bx, word ptr es:[1Ah]	;@0610A
	mov	cx, word ptr es:[18h]	;@0610F
	mov	es, word ptr ds:[55D2h]	;@06114
	mov	ah, byte ptr es:[1]	;@06118
	and	ah, 7	;@0611D
	je	@@9	;@06120
	cmp	cx, word ptr es:[18h]	;@06122
	jne	@@9	;@06127
	cmp	bx, word ptr es:[1Ah]	;@06129
	jne	@@11	;@0612E
	test	word ptr ds:[5160h], 1000h	;@06130
	je	@@8	;@06136
	cmp	al, ah	;@06138
	je	@@8	;@0613A
	cmp	ah, 3	;@0613C
	jne	@@9	;@0613F
	cmp	al, 1	;@06141
	jne	@@9	;@06143
	call	@@16	;@06145
	mov	es, word ptr ds:[55D6h]	;@06148
	call	@@16	;@0614C
	and	byte ptr es:[1], 0F8h	;@0614F
	or	byte ptr es:[1], 2	;@06155
	mov	ds, word ptr ds:[55D2h]	;@0615B
	jmp	@@14	;@0615F
@@8:	jmp	short @@12	;@06162
@@9:	mov	es, word ptr ds:[55D6h]	;@06164
	mov	cx, 6Bh	;@06168
	call	L0A692	;@0616B
	jmp	short @@13	;@0616E
@@10:	mov	ds, word ptr ds:[55D2h]	;@06170
	mov	al, byte ptr ds:[4]	;@06174
	and	al, 4	;@06177
	or	byte ptr es:[4], al	;@06179
	mov	al, byte ptr ds:[1]	;@0617E
	mov	byte ptr es:[1], al	;@06181
	mov	ax, word ptr ds:[26h]	;@06185
	mov	word ptr es:[26h], ax	;@06188
	mov	ax, word ptr ds:[1Ah]	;@0618C
	mov	word ptr es:[1Ah], ax	;@0618F
	mov	ax, word ptr ds:[18h]	;@06193
	mov	word ptr es:[18h], ax	;@06196
	mov	ax, word ptr ds:[16h]	;@0619A
	mov	word ptr es:[16h], ax	;@0619D
	jmp	short @@14	;@061A1
@@11:	cmp	al, ah	;@061A3
	jne	@@9	;@061A5
	mov	ax, bx	;@061A7
	call	L0072A	;@061A9
	jne	@@9	;@061AC
	mov	ax, word ptr es:[1Ah]	;@061AE
	call	L0072A	;@061B2
	je	@@9	;@061B5
	mov	es, word ptr ds:[55D6h]	;@061B7
	mov	word ptr es:[18h], ax	;@061BB
	mov	word ptr es:[1Ah], ax	;@061BF
	mov	byte ptr es:[0], 0	;@061C3
	mov	word ptr es:[2], 0	;@061C9
	mov	ds, word ptr ds:[55D2h]	;@061D0
	jmp	short @@14	;@061D4
@@12:	mov	es, word ptr ds:[55D6h]	;@061D6
	mov	byte ptr es:[0], 0	;@061DA
	mov	word ptr es:[2], 0	;@061E0
@@13:	mov	es, word ptr ds:[55D2h]	;@061E7
	call	@@16	;@061EB
	mov	es, word ptr ds:[55D6h]	;@061EE
	call	@@16	;@061F2
	xor	ax, ax	;@061F5
	and	byte ptr es:[4], 0FBh	;@061F7
	mov	byte ptr es:[1], al	;@061FD
	mov	word ptr es:[18h], ax	;@06201
	mov	word ptr es:[1Ah], ax	;@06205
	mov	ds, word ptr ds:[55D2h]	;@06209
@@14:	mov	ax, word ptr ds:[14h]	;@0620D
	and	ax, ax	;@06210
	je	@@15	;@06212
	mov	word ptr es:[14h], ax	;@06214
@@15:	mov	ax, word ptr ds:[0Ah]	;@06218
	sub	ax, word ptr es:[0Ah]	;@0621B
	mov	word ptr es:[0Ah], ax	;@06220
	mov	ax, word ptr ds:[0Ch]	;@06224
	sbb	ax, word ptr es:[0Ch]	;@06227
	mov	word ptr es:[0Ch], ax	;@0622C
	mov	al, byte ptr ds:[24h]	;@06230
	sbb	al, byte ptr es:[24h]	;@06233
	mov	byte ptr es:[24h], al	;@06238
	mov	al, byte ptr ds:[5]	;@0623C
	and	al, 3	;@0623F
	or	byte ptr es:[5], al	;@06241
	mov	ax, ss	;@06246
	mov	ds, ax	;@06248
	call	L0A718	;@0624A
	jmp	L06CD0	;@0624D
@@16:	mov	ax, word ptr es:[16h]	;@06250
	cwd	;@06254
	mov	cl, dl	;@06255
	shl	ax, 1	;@06257
	rcl	dx, 1	;@06259
	shl	ax, 1	;@0625B
	rcl	dx, 1	;@0625D
	shl	ax, 1	;@0625F
	rcl	dx, 1	;@06261
	shl	ax, 1	;@06263
	rcl	dx, 1	;@06265
	add	word ptr es:[0Ah], ax	;@06267
	adc	word ptr es:[0Ch], dx	;@0626C
	adc	byte ptr es:[24h], cl	;@06271
	mov	word ptr es:[16h], 0	;@06276
	jmp	L0A718	;@0627D
L06280:	call	L06CA1	;@06280
	call	L07052	;@06283
	mov	es, word ptr ds:[55D2h]	;@06286
	call	L06DDC	;@0628A
	mov	es, word ptr ds:[55D6h]	;@0628D
	call	L06DDC	;@06291
	call	L09636	;@06294
	mov	es, word ptr ds:[55D2h]	;@06297
	test	byte ptr es:[4], 40h	;@0629B
	je	@@1	;@062A1
	mov	es, word ptr ds:[55D6h]	;@062A3
	call	L0999B	;@062A7
	mov	es, word ptr ds:[55D2h]	;@062AA
	jmp	short @@2	;@062AE
@@1:	call	L0999B	;@062B0
	mov	es, word ptr ds:[55D6h]	;@062B3
@@2:	call	L06E53	;@062B7
	test	word ptr ds:[5160h], 1008h	;@062BA
	jne	@@4	;@062C0
	mov	es, word ptr ds:[55D6h]	;@062C2
	call	L0A6BA	;@062C6
	mov	es, word ptr ds:[55D2h]	;@062C9
	call	L0A6BA	;@062CD
@@3:	mov	es, word ptr ds:[55D6h]	;@062D0
	mov	ds, word ptr ds:[55D2h]	;@062D4
	test	byte ptr ds:[4], 40h	;@062D8
	je	@@5	;@062DD
	mov	ax, word ptr ds:[0Eh]	;@062DF
	mov	word ptr es:[0Eh], ax	;@062E2
	or	byte ptr es:[4], 40h	;@062E6
	mov	ax, word ptr ds:[10h]	;@062EC
	mov	cx, word ptr es:[0Ah]	;@062EF
	mov	di, word ptr es:[0Ch]	;@062F4
	mov	bl, byte ptr es:[24h]	;@062F9
	jmp	short @@6	;@062FE
@@4:	mov	es, word ptr ds:[55D6h]	;@06300
	call	L0A6CF	;@06304
	mov	es, word ptr ds:[55D2h]	;@06307
	call	L0A6CF	;@0630B
	jmp	@@3	;@0630E
@@5:	test	byte ptr es:[4], 40h	;@06310
	je	@@10	;@06316
	mov	ax, word ptr es:[10h]	;@06318
	mov	cx, word ptr ds:[0Ah]	;@0631C
	mov	di, word ptr ds:[0Ch]	;@06320
	mov	bl, byte ptr ds:[24h]	;@06324
@@6:	cwd	;@06328
	mov	bh, dl	;@06329
	push	ss	;@0632B
	pop	ds	;@0632C
	test	byte ptr es:[5], 80h	;@0632D
	jne	@@8	;@06333
	call	L04A4C	;@06335
	mov	al, byte ptr [bx+4]	;@06338
	cbw	;@0633B
	cmp	ax, word ptr [bx+2]	;@0633C
	jne	@@7	;@0633F
	xor	al, byte ptr [bx+1]	;@06341
	and	al, 80h	;@06344
	mov	ax, word ptr [bx]	;@06346
	je	@@8	;@06348
@@7:	mov	cx, 2Ch	;@0634A
	call	L0716B	;@0634D
	mov	ax, 1	;@06350
@@8:	mov	word ptr es:[10h], ax	;@06353
	cmp	ax, 1	;@06357
	je	@@9	;@0635A
	or	byte ptr es:[4], 20h	;@0635C
@@9:	mov	ds, word ptr ds:[55D2h]	;@06362
@@10:	mov	al, byte ptr ds:[5]	;@06366
	and	al, 3	;@06369
	or	byte ptr es:[5], al	;@0636B
	mov	ax, word ptr ds:[0Ah]	;@06370
	mov	dx, word ptr ds:[0Ch]	;@06373
	mov	bh, byte ptr ds:[24h]	;@06377
	mov	cx, word ptr es:[0Ah]	;@0637B
	mov	di, word ptr es:[0Ch]	;@06380
	mov	bl, byte ptr es:[24h]	;@06385
	push	ss	;@0638A
	pop	ds	;@0638B
	call	L04A4C	;@0638C
	jmp	short L063FD	;@0638F
L06391:	call	L06CD7	;@06391
	mov	es, word ptr ds:[55D6h]	;@06394
	call	L0A6CF	;@06398
	mov	es, word ptr ds:[55D2h]	;@0639B
	call	L0A6CF	;@0639F
	mov	ax, word ptr es:[0Ah]	;@063A2
	mov	dx, word ptr es:[0Ch]	;@063A6
	mov	bh, byte ptr es:[24h]	;@063AB
	mov	es, word ptr ds:[55D6h]	;@063B0
	mov	cx, word ptr es:[0Ah]	;@063B4
	mov	di, word ptr es:[0Ch]	;@063B9
	mov	bl, byte ptr es:[24h]	;@063BE
	call	L049B8	;@063C3
	jmp	short L063FD	;@063C6
L063C8:	call	L06CD7	;@063C8
	mov	es, word ptr ds:[55D6h]	;@063CB
	call	L0A6CF	;@063CF
	mov	es, word ptr ds:[55D2h]	;@063D2
	call	L0A6CF	;@063D6
	mov	ax, word ptr es:[0Ah]	;@063D9
	mov	dx, word ptr es:[0Ch]	;@063DD
	mov	bh, byte ptr es:[24h]	;@063E2
	mov	es, word ptr ds:[55D6h]	;@063E7
	mov	cx, word ptr es:[0Ah]	;@063EB
	mov	di, word ptr es:[0Ch]	;@063F0
	mov	bl, byte ptr es:[24h]	;@063F5
	call	L04A01	;@063FA
L063FD:	mov	es, word ptr ds:[55D6h]	;@063FD
	mov	ax, word ptr [bx]	;@06401
	mov	word ptr es:[0Ah], ax	;@06403
	mov	ax, word ptr [bx+2]	;@06407
	mov	word ptr es:[0Ch], ax	;@0640A
	mov	al, byte ptr [bx+4]	;@0640E
	mov	byte ptr es:[24h], al	;@06411
	call	L0A718	;@06415
	jmp	L06CCD	;@06418
L0641B:	call	L06CD7	;@0641B
	mov	es, word ptr ds:[55D6h]	;@0641E
	test	byte ptr es:[24h], 1	;@06422
	je	L06449	;@06428
	xor	ax, ax	;@0642A
	not	word ptr es:[0Ah]	;@0642C
	not	word ptr es:[0Ch]	;@06431
	add	word ptr es:[0Ah], 1	;@06436
	adc	word ptr es:[0Ch], ax	;@0643C
	adc	byte ptr es:[24h], al	;@06441
	jmp	L064CC	;@06446
L06449:	cmp	word ptr es:[0Ch], 0	;@06449
	jne	@@2	;@0644F
	mov	cx, word ptr es:[0Ah]	;@06451
	cmp	cx, 20h	;@06456
	jae	@@2	;@06459
	mov	es, word ptr ds:[55D2h]	;@0645B
	mov	ax, word ptr es:[0Ah]	;@0645F
	mov	bx, word ptr es:[0Ch]	;@06463
@@1:	jcxz	@@3	;@06468
	mov	dh, byte ptr es:[24h]	;@0646A
	shr	dh, 1	;@0646F
	rcr	bx, 1	;@06471
	rcr	ax, 1	;@06473
	dec	cx	;@06475
	jmp	@@1	;@06476
@@2:	mov	es, word ptr ds:[55D2h]	;@06478
	mov	al, byte ptr es:[24h]	;@0647C
	mov	ah, al	;@06480
	mov	bx, ax	;@06482
@@3:	mov	cl, byte ptr es:[24h]	;@06484
	mov	es, word ptr ds:[55D6h]	;@06489
	mov	word ptr es:[0Ah], ax	;@0648D
	mov	word ptr es:[0Ch], bx	;@06491
	mov	byte ptr es:[24h], cl	;@06496
	jmp	L06CCD	;@0649B
L0649E:	call	L06CD7	;@0649E
	mov	es, word ptr ds:[55D6h]	;@064A1
	test	byte ptr es:[24h], 1	;@064A5
	je	L064CC	;@064AB
	xor	ax, ax	;@064AD
	not	word ptr es:[0Ah]	;@064AF
	not	word ptr es:[0Ch]	;@064B4
	add	word ptr es:[0Ah], 1	;@064B9
	adc	word ptr es:[0Ch], ax	;@064BF
	adc	byte ptr es:[24h], al	;@064C4
	jmp	L06449	;@064C9
L064CC:	cmp	word ptr es:[0Ch], 0	;@064CC
	jne	@@2	;@064D2
	mov	cx, word ptr es:[0Ah]	;@064D4
	cmp	cx, 20h	;@064D9
	jae	@@2	;@064DC
	mov	es, word ptr ds:[55D2h]	;@064DE
	mov	ax, word ptr es:[0Ah]	;@064E2
	mov	bx, word ptr es:[0Ch]	;@064E6
@@1:	jcxz	@@3	;@064EB
	shl	ax, 1	;@064ED
	rcl	bx, 1	;@064EF
	dec	cx	;@064F1
	jmp	@@1	;@064F2
@@2:	mov	es, word ptr ds:[55D2h]	;@064F4
	xor	ax, ax	;@064F8
	mov	bx, ax	;@064FA
	mov	byte ptr es:[24h], al	;@064FC
@@3:	test	word ptr ds:[5160h], 1008h	;@06500
	jne	@@4	;@06506
	mov	bx, word ptr es:[0Ch]	;@06508
@@4:	mov	cl, byte ptr es:[24h]	;@0650D
	mov	es, word ptr ds:[55D6h]	;@06512
	mov	word ptr es:[0Ah], ax	;@06516
	test	word ptr ds:[5160h], 2000h	;@0651A
	jne	@@5	;@06520
	xor	cl, cl	;@06522
	test	word ptr ds:[5160h], 8	;@06524
	jne	@@5	;@0652A
	xor	bx, bx	;@0652C
@@5:	mov	word ptr es:[0Ch], bx	;@0652E
	mov	byte ptr es:[24h], cl	;@06533
	jmp	L06CCD	;@06538
L0653B:	mov	word ptr ds:[55D2h], es	;@0653B
	call	L06DDC	;@0653F
	test	word ptr ds:[5160h], 1000h	;@06542
	je	@@1	;@06548
	call	L0999B	;@0654A
	mov	byte ptr es:[0], 0	;@0654D
@@1:	test	byte ptr es:[4], 1	;@06553
	je	@@2	;@06559
	xor	byte ptr es:[4], 2	;@0655B
	jmp	L06C9A	;@06561
@@2:	not	word ptr es:[0Ah]	;@06564
	not	word ptr es:[0Ch]	;@06569
	add	word ptr es:[0Ah], 1	;@0656E
	adc	word ptr es:[0Ch], 0	;@06574
	not	byte ptr es:[24h]	;@0657A
	call	L0A718	;@0657F
	jmp	L06C9A	;@06582
L06585:	call	L0663D	;@06585
L06588:	call	L06D2B	;@06588
	test	byte ptr es:[4], 4	;@0658B
	je	@@2	;@06591
	mov	ax, word ptr es:[0Ah]	;@06593
	or	al, byte ptr es:[24h]	;@06597
	or	ax, word ptr es:[0Ch]	;@0659C
	je	@@1	;@065A1
	mov	cx, 23h	;@065A3
	call	L0A707	;@065A6
@@1:	add	byte ptr es:[1], 5	;@065A9
	test	byte ptr ds:[516Ah], 80h	;@065AF
	je	@@2	;@065B4
	test	word ptr ds:[5166h], 4000h	;@065B6
	je	@@2	;@065BC
	mov	cx, 807Fh	;@065BE
	call	L0716B	;@065C1
@@2:	mov	al, byte ptr es:[0Bh]	;@065C4
	xor	ah, ah	;@065C8
	mov	word ptr es:[0Ah], ax	;@065CA
	xor	ax, ax	;@065CE
	mov	word ptr es:[0Ch], ax	;@065D0
	mov	byte ptr es:[24h], ah	;@065D4
	jmp	L06C9A	;@065D9
L065DC:	call	L0663D	;@065DC
L065DF:	call	L06D2B	;@065DF
	test	byte ptr es:[4], 4	;@065E2
	je	@@1	;@065E8
	add	byte ptr es:[1], 4	;@065EA
	test	byte ptr ds:[516Ah], 80h	;@065F0
	je	@@1	;@065F5
	test	word ptr ds:[5166h], 4000h	;@065F7
	je	@@1	;@065FD
	mov	cx, 807Fh	;@065FF
	call	L0716B	;@06602
@@1:	xor	ax, ax	;@06605
	mov	byte ptr es:[0Bh], al	;@06607
	mov	word ptr es:[0Ch], ax	;@0660B
	mov	byte ptr es:[24h], al	;@0660F
	jmp	L06C9A	;@06613
L06616:	call	L06D56	;@06616
	call	L06691	;@06619
	jmp	L06C9A	;@0661C
L0661F:	or	byte ptr es:[5], 10h	;@0661F
	cmp	byte ptr ds:[38D9h], 0	;@06625
	je	@@1	;@0662A
	test	word ptr ds:[5160h], 2000h	;@0662C
	jne	@@1	;@06632
	stc	;@06634
	mov	sp, word ptr ds:[38BCh]	;@06635
	ret	;@06639
@@1:	xor	al, al	;@0663A
	ret	;@0663C
L0663D:	test	byte ptr es:[0], 80h	;@0663D
	jne	@@2	;@06643
	mov	al, byte ptr es:[1]	;@06645
	and	al, 7	;@06649
	cmp	al, 4	;@0664B
	jne	@@1	;@0664D
	mov	ax, word ptr es:[18h]	;@0664F
	push	es	;@06653
	mov	es, ax	;@06654
	call	L0152F	;@06656
	pop	es	;@06659
	mov	word ptr es:[18h], cx	;@0665A
	and	byte ptr es:[1], 0F8h	;@0665F
	or	byte ptr es:[1], 1	;@06665
@@1:	ret	;@0666B
@@2:	mov	al, byte ptr es:[0]	;@0666C
	mov	cx, word ptr es:[2]	;@06670
	mov	byte ptr es:[25h], al	;@06675
	mov	word ptr es:[1Ch], cx	;@06679
	or	byte ptr es:[5], 40h	;@0667E
	mov	byte ptr es:[0], 0	;@06684
	mov	word ptr es:[2], 0	;@0668A
L06691:	and	byte ptr es:[5], 0DFh	;@06691
	xor	ax, ax	;@06697
	mov	word ptr es:[22h], ax	;@06699
	mov	word ptr es:[1Eh], ax	;@0669D
	mov	word ptr es:[20h], ax	;@066A1
	test	byte ptr es:[4], 4	;@066A5
	je	@@2	;@066AB
	cmp	al, 2	;@066AD
	jne	@@1	;@066AF
	and	byte ptr es:[4], 0FBh	;@066B1
	xor	ax, ax	;@066B7
	mov	byte ptr es:[1], al	;@066B9
	mov	word ptr es:[18h], ax	;@066BD
	mov	word ptr es:[1Ah], ax	;@066C1
	jmp	short @@2	;@066C5
@@1:	cmp	al, 3	;@066C7
	jne	@@2	;@066C9
	sub	byte ptr es:[1], 2	;@066CB
	call	L0A5E6	;@066D1
@@2:	xor	ax, ax	;@066D4
	mov	word ptr es:[14h], ax	;@066D6
	mov	word ptr es:[16h], ax	;@066DA
	ret	;@066DE
L066DF:	test	byte ptr es:[4], 4	;@066DF
	je	L066F2	;@066E5
	mov	al, byte ptr es:[1]	;@066E7
	and	al, 7	;@066EB
	cmp	al, 4	;@066ED
	jne	L066F2	;@066EF
	ret	;@066F1
L066F2:	call	L06D56	;@066F2
	test	byte ptr es:[4], 4	;@066F5
	je	@@1	;@066FB
	and	byte ptr es:[1], 0F8h	;@066FD
	or	byte ptr es:[1], 4	;@06703
@@1:	mov	ax, word ptr es:[16h]	;@06709
	cwd	;@0670D
	mov	word ptr es:[0Ah], ax	;@0670E
	mov	word ptr es:[0Ch], dx	;@06712
	mov	byte ptr es:[24h], dl	;@06717
	xor	ax, ax	;@0671C
	mov	word ptr es:[14h], ax	;@0671E
	mov	word ptr es:[16h], ax	;@06722
	and	byte ptr es:[4], 8Fh	;@06726
	and	byte ptr es:[5], 9Ch	;@0672C
	or	byte ptr es:[5], 1	;@06732
	mov	word ptr es:[22h], ax	;@06738
	mov	word ptr es:[1Eh], ax	;@0673C
	mov	word ptr es:[20h], ax	;@06740
	mov	word ptr es:[0Eh], ax	;@06744
	mov	word ptr es:[12h], ax	;@06748
	mov	word ptr es:[10h], 1	;@0674C
	mov	byte ptr es:[25h], al	;@06753
	mov	word ptr es:[1Ch], ax	;@06757
	jmp	L06C9A	;@0675B
L0675E:	mov	bx, ax	;@0675E
	call	L05542	;@06760
	call	L035F0	;@06763
	push	es	;@06766
	mov	es, bx	;@06767
L06769:	push	bx	;@06769
	call	L000E5	;@0676A
	pop	bx	;@0676D
	pop	es	;@0676E
	je	@@2	;@0676F
	mov	word ptr es:[0Ah], ax	;@06771
	mov	word ptr es:[0Ch], dx	;@06775
@@1:	xor	al, al	;@0677A
	ret	;@0677C
@@2:	mov	word ptr es:[6], bx	;@0677D
	call	L06EE3	;@06782
	jmp	@@1	;@06785
L06787:	mov	bx, ax	;@06787
	call	L05542	;@06789
	call	L035F0	;@0678C
	push	es	;@0678F
	mov	es, bx	;@06790
	push	bx	;@06792
	call	L000B4	;@06793
	pop	bx	;@06796
	pop	es	;@06797
	je	@@2	;@06798
@@1:	mov	word ptr es:[0Ah], ax	;@0679A
	mov	word ptr es:[0Ch], dx	;@0679E
	xor	al, al	;@067A3
	ret	;@067A5
@@2:	mov	word ptr es:[6], bx	;@067A6
	call	L06EE3	;@067AB
	mov	ax, 1	;@067AE
	xor	dx, dx	;@067B1
	jmp	@@1	;@067B3
L067B5:	mov	bx, ax	;@067B5
	call	L05542	;@067B7
	call	L035F0	;@067BA
	push	es	;@067BD
	mov	es, bx	;@067BE
	push	bx	;@067C0
	call	L001B8	;@067C1
	pop	bx	;@067C4
	pop	es	;@067C5
	je	@@2	;@067C6
@@1:	mov	word ptr es:[0Ah], ax	;@067C8
	mov	word ptr es:[0Ch], dx	;@067CC
	xor	al, al	;@067D1
	ret	;@067D3
@@2:	mov	word ptr es:[6], bx	;@067D4
	call	L06EE3	;@067D9
	xor	ax, ax	;@067DC
	mov	dx, ax	;@067DE
	jmp	@@1	;@067E0
L067E2:	mov	bx, ax	;@067E2
	call	L05542	;@067E4
	call	L035F0	;@067E7
	push	es	;@067EA
	mov	es, bx	;@067EB
	push	bx	;@067ED
	call	L00225	;@067EE
	pop	bx	;@067F1
	pop	es	;@067F2
	je	@@2	;@067F3
@@1:	mov	word ptr es:[0Ah], ax	;@067F5
	mov	word ptr es:[0Ch], dx	;@067F9
	xor	al, al	;@067FE
	ret	;@06800
@@2:	mov	word ptr es:[6], bx	;@06801
	call	L06EE3	;@06806
	xor	ax, ax	;@06809
	mov	dx, ax	;@0680B
	jmp	@@1	;@0680D
L0680F:	call	L06DDC	;@0680F
	call	L0999B	;@06812
	mov	ax, word ptr es:[0Ah]	;@06815
	call	L0A5C4	;@06819
	or	al, 80h	;@0681C
	mov	byte ptr es:[0], al	;@0681E
	xor	ax, ax	;@06822
	mov	word ptr es:[2], ax	;@06824
	mov	word ptr es:[0Ah], ax	;@06828
	mov	word ptr es:[0Ch], ax	;@0682C
	mov	byte ptr es:[24h], al	;@06830
	jmp	short L0683F	;@06834
L06836:	call	L05542	;@06836
	mov	byte ptr es:[0], 88h	;@06839
L0683F:	push	es	;@0683F
	call	L03675	;@06840
	pop	es	;@06843
	mov	word ptr es:[0Ah], ax	;@06844
	mov	word ptr es:[0Ch], dx	;@06848
	cmp	word ptr ds:[5194h], 0	;@0684D
	je	@@2	;@06852
@@1:	mov	byte ptr es:[0], 0	;@06854
	jmp	short @@4	;@0685A
@@2:	mov	cx, word ptr ds:[5162h]	;@0685C
	jcxz	@@1	;@06860
	mov	byte ptr es:[1], 3	;@06862
	mov	byte ptr es:[4], 4	;@06868
	push	es	;@0686E
	mov	es, cx	;@0686F
	call	L0152F	;@06871
	pop	es	;@06874
	mov	word ptr es:[1Ah], ax	;@06875
	mov	word ptr es:[18h], cx	;@06879
	call	L00752	;@0687E
	mov	dl, 1	;@06881
	je	@@3	;@06883
	mov	dl, 2	;@06885
@@3:	or	byte ptr es:[5], dl	;@06887
	cmp	ax, cx	;@0688C
	jne	@@4	;@0688E
	mov	ax, cx	;@06890
	call	L0076E	;@06892
	jne	@@4	;@06895
	sub	byte ptr es:[1], 1	;@06897
@@4:	xor	al, al	;@0689D
	ret	;@0689F
L068A0:	mov	ax, 61h	;@068A0
	mov	cx, ax	;@068A3
	call	far ptr L0FB18	;@068A5
	mov	es, ax	;@068AA
	mov	word ptr es:[2], cx	;@068AC
	dec	cx	;@068B1
	mov	word ptr ds:[55E8h], cx	;@068B2
	mov	cx, word ptr ds:[55E4h]	;@068B6
	mov	word ptr es:[0], cx	;@068BA
	mov	word ptr ds:[55E4h], ax	;@068BF
	inc	ax	;@068C2
	mov	word ptr ds:[55E6h], ax	;@068C3
	jmp	short L068D1	;@068C6
L068C8:	mov	bx, ax	;@068C8
	cmp	word ptr ds:[55E8h], 0	;@068CA
	je	L068A0	;@068CF
L068D1:	mov	es, word ptr ds:[55E6h]	;@068D1
	mov	ax, 3	;@068D5
	add	word ptr ds:[55E6h], ax	;@068D8
	sub	word ptr ds:[55E8h], ax	;@068DC
	xor	ax, ax	;@068E0
	mov	di, ax	;@068E2
	mov	cx, 14h	;@068E4
	rep stosw	;@068E7
	mov	byte ptr es:[10h], 1	;@068E9
L068EF:	mov	ax, bx	;@068EF
	sub	ax, word ptr ds:[55DCh]	;@068F1
	jb	L0696A	;@068F5
	cmp	ax, 58h	;@068F7
	jae	L0696A	;@068FA
	mov	byte ptr es:[4], 40h	;@068FC
	mov	word ptr es:[0Eh], bx	;@06902
	cmp	ax, 3Ch	;@06907
	jb	L06920	;@0690A
	cmp	ax, 54h	;@0690C
	jae	L0693C	;@0690F
L06911:	mov	byte ptr es:[0], 2	;@06911
	or	byte ptr es:[5], 1	;@06917
	xor	al, al	;@0691D
	ret	;@0691F
L06920:	cmp	ax, 10h	;@06920
	jb	L06950	;@06923
	test	word ptr ds:[5160h], 8	;@06925
	je	L06944	;@0692B
	mov	byte ptr es:[0], 3	;@0692D
	or	byte ptr es:[5], 2	;@06933
	xor	al, al	;@06939
	ret	;@0693B
L0693C:	test	word ptr ds:[5160h], 8	;@0693C
	jne	L06911	;@06942
L06944:	xor	ax, ax	;@06944
	mov	byte ptr es:[4], al	;@06946
	mov	word ptr es:[0Eh], ax	;@0694A
	jmp	short L0696A	;@0694E
L06950:	mov	byte ptr es:[0], 1	;@06950
	xor	al, al	;@06956
	ret	;@06958
L06959:	mov	cx, bx	;@06959
	mov	bx, dx	;@0695B
	mov	dh, al	;@0695D
	and	ax, 1Fh	;@0695F
	shl	ax, 1	;@06962
	mov	di, ax	;@06964
	jmp	word ptr [di+1D2Ch]	;@06966
L0696A:	mov	ax, dx	;@0696A
L0696C:	push	es	;@0696C
	call	L004C7	;@0696D
	pop	es	;@06970
	test	al, 20h	;@06971
	je	L06959	;@06973
	mov	bx, dx	;@06975
	and	al, 0Fh	;@06977
	sub	al, 80h	;@06979
	call	L0591D	;@0697B
	mov	byte ptr es:[0], al	;@0697E
	mov	word ptr es:[2], di	;@06982
	mov	byte ptr es:[1], 3	;@06987
	mov	byte ptr es:[4], 4	;@0698D
	cmp	al, 89h	;@06993
	jne	@@1	;@06995
	or	byte ptr es:[1], 10h	;@06997
	mov	word ptr es:[26h], bx	;@0699D
@@1:	call	L035F0	;@069A2
	push	si	;@069A5
	push	es	;@069A6
	mov	es, bx	;@069A7
	call	L01282	;@069A9
	pop	es	;@069AC
	mov	word ptr es:[0Ah], ax	;@069AD
	mov	word ptr es:[0Ch], dx	;@069B1
	mov	word ptr es:[1Ah], si	;@069B6
	mov	word ptr es:[18h], di	;@069BB
	jb	@@2	;@069C0
	mov	byte ptr es:[5], 20h	;@069C2
	mov	word ptr es:[22h], cx	;@069C8
	mov	word ptr es:[20h], bp	;@069CD
@@2:	or	byte ptr es:[5], bl	;@069D2
	mov	ax, si	;@069D7
	pop	si	;@069D9
	cmp	ax, di	;@069DA
	jne	@@3	;@069DC
	and	ax, ax	;@069DE
	je	@@3	;@069E0
	call	L0076E	;@069E2
	jne	@@3	;@069E5
	sub	byte ptr es:[1], 1	;@069E7
@@3:	xor	al, al	;@069ED
	ret	;@069EF
L069F0:	call	L035F0	;@069F0
	push	si	;@069F3
	push	bx	;@069F4
	push	es	;@069F5
	mov	es, bx	;@069F6
	call	L00FC6	;@069F8
	pop	es	;@069FB
	je	@@1	;@069FC
	pop	bx	;@069FE
	pop	si	;@069FF
	mov	word ptr es:[6], bx	;@06A00
	jmp	L06B71	;@06A05
@@1:	mov	byte ptr es:[0], 88h	;@06A08
	mov	byte ptr es:[1], 3	;@06A0E
	mov	byte ptr es:[4], 4	;@06A14
	mov	word ptr es:[0Ah], ax	;@06A1A
	mov	word ptr es:[0Ch], dx	;@06A1E
	mov	word ptr es:[1Ah], si	;@06A23
	mov	word ptr es:[18h], di	;@06A28
	or	bl, 20h	;@06A2D
	mov	byte ptr es:[5], bl	;@06A30
	mov	word ptr es:[22h], cx	;@06A35
	mov	word ptr es:[20h], bp	;@06A3A
	mov	ax, si	;@06A3F
	pop	bx	;@06A41
	pop	si	;@06A42
	cmp	ax, di	;@06A43
	jne	@@2	;@06A45
	and	ax, ax	;@06A47
	je	@@2	;@06A49
	call	L0076E	;@06A4B
	jne	@@2	;@06A4E
	sub	byte ptr es:[1], 1	;@06A50
@@2:	xor	al, al	;@06A56
	ret	;@06A58
L06A59:	mov	ax, cx	;@06A59
	sub	ax, word ptr ds:[55DEh]	;@06A5B
	jb	@@1	;@06A5F
	cmp	ax, 14h	;@06A61
	jae	@@1	;@06A64
	mov	bx, ax	;@06A66
	mov	ax, word ptr [bx+1CB8h]	;@06A68
	mov	word ptr es:[0Ah], ax	;@06A6C
	xor	al, al	;@06A70
	ret	;@06A72
@@1:	call	L035F0	;@06A73
	mov	di, bx	;@06A76
	mov	cx, 104Eh	;@06A78
	call	L0716B	;@06A7B
	xor	al, al	;@06A7E
	ret	;@06A80
L06A81:	mov	ax, cx	;@06A81
	test	byte ptr ds:[516Bh], 1	;@06A83
	je	@@1	;@06A88
	cmp	ax, word ptr ds:[585Ch]	;@06A8A
	je	@@3	;@06A8E
	cmp	ax, word ptr ds:[585Eh]	;@06A90
	je	@@4	;@06A94
	cmp	ax, word ptr ds:[5860h]	;@06A96
	je	@@5	;@06A9A
@@1:	sub	ax, word ptr ds:[55DEh]	;@06A9C
	jb	@@6	;@06AA0
	cmp	ax, 14h	;@06AA2
	jae	@@6	;@06AA5
	mov	bx, ax	;@06AA7
	mov	ax, word ptr [bx+1CB8h]	;@06AA9
@@2:	mov	word ptr es:[0Ah], ax	;@06AAD
	xor	al, al	;@06AB1
	ret	;@06AB3
@@3:	test	byte ptr ds:[516Bh], 2	;@06AB4
	mov	ax, 0FFFFh	;@06AB9
	je	@@2	;@06ABC
	mov	ax, 0FFFEh	;@06ABE
	jmp	@@2	;@06AC1
@@4:	test	byte ptr ds:[516Bh], 8	;@06AC3
	mov	ax, 2	;@06AC8
	je	@@2	;@06ACB
	mov	ax, 4	;@06ACD
	jmp	@@2	;@06AD0
@@5:	test	byte ptr ds:[516Bh], 2	;@06AD2
	mov	ax, 2	;@06AD7
	je	@@2	;@06ADA
	mov	ax, 4	;@06ADC
	jmp	@@2	;@06ADF
@@6:	test	word ptr ds:[5160h], 6000h	;@06AE1
	jne	@@7	;@06AE7
	cmp	cx, word ptr ds:[5758h]	;@06AE9
	je	@@10	;@06AED
	cmp	cx, word ptr ds:[5756h]	;@06AEF
	je	@@11	;@06AF3
@@7:	call	L035F0	;@06AF5
	mov	word ptr es:[6], bx	;@06AF8
	test	word ptr ds:[5160h], 1000h	;@06AFD
	jne	@@8	;@06B03
	cmp	bx, word ptr ds:[5834h]	;@06B05
	jne	@@8	;@06B09
	or	byte ptr ds:[38D8h], 2	;@06B0B
@@8:	push	es	;@06B10
	mov	es, bx	;@06B11
	call	L008C4	;@06B13
	pop	es	;@06B16
	test	bl, 20h	;@06B17
	je	L06B88	;@06B1A
	sub	bl, 0A0h	;@06B1C
	push	ax	;@06B1F
	push	bx	;@06B20
	push	cx	;@06B21
	call	L06B71	;@06B22
	pop	cx	;@06B25
	pop	bx	;@06B26
	mov	byte ptr es:[0], bl	;@06B27
	mov	byte ptr es:[5], bh	;@06B2C
	jcxz	@@9	;@06B31
	mov	word ptr es:[1Ah], cx	;@06B33
	mov	word ptr es:[18h], cx	;@06B38
	mov	byte ptr es:[1], 3	;@06B3D
	mov	byte ptr es:[4], 4	;@06B43
@@9:	pop	word ptr es:[2]	;@06B49
	ret	;@06B4E
@@10:	mov	ax, word ptr ds:[519Ah]	;@06B4F
	jmp	short @@12	;@06B52
@@11:	mov	ax, word ptr ds:[519Ah]	;@06B54
	and	ax, ax	;@06B57
	je	@@13	;@06B59
	dec	ax	;@06B5B
@@12:	push	si	;@06B5C
	push	es	;@06B5D
	call	L01B9D	;@06B5E
	pop	es	;@06B61
	pop	si	;@06B62
	mov	bx, ax	;@06B63
	jmp	L068EF	;@06B65
@@13:	mov	bx, word ptr ds:[5754h]	;@06B68
	mov	dx, bx	;@06B6C
	jmp	L068EF	;@06B6E
L06B71:	call	L06EE3	;@06B71
	call	L06E14	;@06B74
	and	byte ptr es:[5], 0DFh	;@06B77
	xor	ax, ax	;@06B7D
	mov	word ptr es:[22h], ax	;@06B7F
	mov	word ptr es:[20h], ax	;@06B83
	ret	;@06B87
L06B88:	call	L06EE3	;@06B88
	xor	al, al	;@06B8B
	ret	;@06B8D
L06B8E:	call	L035F0	;@06B8E
	test	word ptr ds:[5160h], 1000h	;@06B91
	je	@@1	;@06B97
	mov	word ptr es:[2], bx	;@06B99
	mov	byte ptr es:[0], 8Ah	;@06B9E
	xor	al, al	;@06BA4
	ret	;@06BA6
@@1:	mov	byte ptr es:[25h], 8Ah	;@06BA7
	mov	word ptr es:[1Ch], bx	;@06BAD
	mov	byte ptr es:[5], 40h	;@06BB2
	ret	;@06BB8
L06BB9:	call	L035F0	;@06BB9
	push	es	;@06BBC
	mov	es, bx	;@06BBD
	call	L00A81	;@06BBF
	pop	es	;@06BC2
	mov	word ptr es:[0Ah], ax	;@06BC3
	mov	word ptr es:[0Ch], dx	;@06BC7
	sub	bl, 0A0h	;@06BCC
	mov	byte ptr es:[25h], bl	;@06BCF
	mov	word ptr es:[1Ch], cx	;@06BD4
	mov	byte ptr es:[5], 40h	;@06BD9
	xor	al, al	;@06BDF
	ret	;@06BE1
L06BE2:	call	L035F0	;@06BE2
	mov	byte ptr es:[1], 4	;@06BE5
	mov	byte ptr es:[4], 4	;@06BEB
	mov	byte ptr es:[5], 1	;@06BF1
	mov	word ptr es:[18h], bx	;@06BF7
	mov	word ptr es:[1Ah], bx	;@06BFC
	xor	al, al	;@06C01
	ret	;@06C03
L06C04:	call	L035F0	;@06C04
	mov	word ptr es:[6], bx	;@06C07
	call	L06EE3	;@06C0C
	xor	al, al	;@06C0F
	ret	;@06C11
L06C12:	call	L035F0	;@06C12
	mov	es, bx	;@06C15
	call	L01647	;@06C17
	jmp	short L06C24	;@06C1A
L06C1C:	call	L035F0	;@06C1C
	mov	es, bx	;@06C1F
	call	L018F9	;@06C21
L06C24:	mov	es, ax	;@06C24
	cmp	word ptr es:[6], 0	;@06C26
	je	@@1	;@06C2C
	call	L06EE3	;@06C2E
@@1:	xor	al, al	;@06C31
	ret	;@06C33
L06C34:	call	L035F0	;@06C34
	mov	byte ptr es:[1], 1	;@06C37
	mov	byte ptr es:[4], 4	;@06C3D
	mov	word ptr es:[18h], bx	;@06C43
	mov	word ptr es:[1Ah], bx	;@06C48
	xor	al, al	;@06C4D
	ret	;@06C4F
L06C50:	call	L035F0	;@06C50
	mov	ax, bx	;@06C53
	push	es	;@06C55
	push	bx	;@06C56
	call	L0AF7E	;@06C57
	pop	bx	;@06C5A
	je	@@1	;@06C5B
	mov	es, bx	;@06C5D
	call	L001B8	;@06C5F
@@1:	pop	es	;@06C62
	mov	word ptr es:[0Ah], ax	;@06C63
	mov	word ptr es:[0Ch], dx	;@06C67
	xor	al, al	;@06C6C
	ret	;@06C6E
L06C6F:	call	L035F0	;@06C6F
	push	es	;@06C72
	mov	es, bx	;@06C73
L06C75:	call	L00AEF	;@06C75
	pop	es	;@06C78
	mov	word ptr es:[0Ah], ax	;@06C79
	mov	word ptr es:[0Ch], dx	;@06C7D
	xor	al, al	;@06C82
	ret	;@06C84
L06C85:	mov	byte ptr es:[4], 1	;@06C85
	mov	word ptr es:[8], bx	;@06C8B
	xor	al, al	;@06C90
	ret	;@06C92
L06C93:	mov	word ptr ds:[55D2h], es	;@06C93
	jmp	L0A736	;@06C97
L06C9A:	mov	es, word ptr ds:[55D2h]	;@06C9A
	xor	al, al	;@06C9E
	ret	;@06CA0
L06CA1:	mov	word ptr ds:[55D2h], ax	;@06CA1
	mov	word ptr ds:[55D6h], es	;@06CA4
	mov	es, ax	;@06CA8
	call	L0A736	;@06CAA
	mov	ax, word ptr es:[6]	;@06CAD
	mov	bl, byte ptr es:[5]	;@06CB1
	and	bl, 90h	;@06CB6
	mov	es, word ptr ds:[55D6h]	;@06CB9
	or	byte ptr es:[5], bl	;@06CBD
	and	ax, ax	;@06CC2
	je	@@1	;@06CC4
	mov	word ptr es:[6], ax	;@06CC6
@@1:	jmp	L0A736	;@06CCA
L06CCD:	call	L07014	;@06CCD
L06CD0:	mov	es, word ptr ds:[55D6h]	;@06CD0
	xor	al, al	;@06CD4
	ret	;@06CD6
L06CD7:	call	L06CA1	;@06CD7
	call	L07052	;@06CDA
	mov	es, word ptr ds:[55D2h]	;@06CDD
	call	L06DDC	;@06CE1
	call	L090E2	;@06CE4
	call	L0999B	;@06CE7
	mov	al, byte ptr es:[5]	;@06CEA
	and	al, 3	;@06CEE
	mov	es, word ptr ds:[55D6h]	;@06CF0
	or	byte ptr es:[5], al	;@06CF4
	call	L06DDC	;@06CF9
	call	L090E2	;@06CFC
	jmp	L0999B	;@06CFF
L06D02:	call	L06C93	;@06D02
	mov	es, word ptr ds:[55D2h]	;@06D05
	call	L06DDC	;@06D09
	call	L090E2	;@06D0C
	jmp	L0999B	;@06D0F
L06D12:	call	L06C93	;@06D12
	mov	es, word ptr ds:[55D2h]	;@06D15
	call	L06DDC	;@06D19
	call	L090E2	;@06D1C
	test	byte ptr es:[4], 40h	;@06D1F
	jne	@@1	;@06D25
	jmp	L0999B	;@06D27
@@1:	ret	;@06D2A
L06D2B:	call	L06C93	;@06D2B
	call	L06DDC	;@06D2E
	call	L090E2	;@06D31
	call	L099C5	;@06D34
	mov	byte ptr es:[0], 1	;@06D37
	test	byte ptr es:[4], 4	;@06D3D
	je	@@1	;@06D43
	mov	al, byte ptr es:[1]	;@06D45
	and	al, 7	;@06D49
	cmp	al, 1	;@06D4B
	jne	@@2	;@06D4D
@@1:	ret	;@06D4F
@@2:	mov	cx, 6Ch	;@06D50
	jmp	L0A692	;@06D53
L06D56:	call	L06C93	;@06D56
	call	L06D7E	;@06D59
	call	L06E14	;@06D5C
	mov	byte ptr es:[0], 0	;@06D5F
	test	byte ptr es:[4], 4	;@06D65
	je	@@1	;@06D6B
	mov	al, byte ptr es:[1]	;@06D6D
	and	al, 7	;@06D71
	cmp	al, 4	;@06D73
	jae	@@2	;@06D75
@@1:	ret	;@06D77
@@2:	mov	cx, 6Dh	;@06D78
	jmp	L0A692	;@06D7B
L06D7E:	mov	al, byte ptr es:[0]	;@06D7E
	test	al, 80h	;@06D82
	je	L06D87	;@06D84
	ret	;@06D86
L06D87:	cmp	al, 2	;@06D87
	je	@@1	;@06D89
	cmp	al, 3	;@06D8B
	je	@@1	;@06D8D
	cmp	al, 0	;@06D8F
	je	@@1	;@06D91
	mov	cx, 1Ah	;@06D93
	call	L0716B	;@06D96
@@1:	mov	byte ptr es:[0], 0	;@06D99
	ret	;@06D9F
L06DA0:	mov	al, byte ptr es:[0]	;@06DA0
	test	al, 80h	;@06DA4
	je	@@2	;@06DA6
@@1:	cmp	al, 8Ah	;@06DA8
	jne	@@3	;@06DAA
	ret	;@06DAC
@@2:	call	L06D87	;@06DAD
	jmp	@@1	;@06DB0
@@3:	mov	byte ptr es:[0], 80h	;@06DB2
	mov	cx, 16h	;@06DB8
	jmp	L0716B	;@06DBB
L06DBE:	mov	al, byte ptr es:[0]	;@06DBE
	test	al, 80h	;@06DC2
	je	@@2	;@06DC4
@@1:	cmp	al, 87h	;@06DC6
	jae	@@3	;@06DC8
	ret	;@06DCA
@@2:	call	L06D87	;@06DCB
	jmp	@@1	;@06DCE
@@3:	mov	byte ptr es:[0], 80h	;@06DD0
	mov	cx, 16h	;@06DD6
	jmp	L0716B	;@06DD9
L06DDC:	test	byte ptr es:[5], 10h	;@06DDC
	jne	@@1	;@06DE2
	test	byte ptr es:[0], 80h	;@06DE4
	jne	@@2	;@06DEA
	ret	;@06DEC
@@1:	jmp	L0663D	;@06DED
@@2:	and	byte ptr es:[0], 7Fh	;@06DF0
	and	byte ptr es:[4], 0FBh	;@06DF6
	xor	ax, ax	;@06DFC
	mov	byte ptr es:[1], al	;@06DFE
	mov	word ptr es:[1Ah], ax	;@06E02
	mov	word ptr es:[18h], ax	;@06E06
	mov	word ptr es:[14h], ax	;@06E0A
	mov	cx, 15h	;@06E0E
	jmp	L0716B	;@06E11
L06E14:	test	byte ptr es:[0], 80h	;@06E14
	je	@@1	;@06E1A
	ret	;@06E1C
@@1:	test	word ptr ds:[5160h], 1000h	;@06E1D
	je	@@2	;@06E23
	test	byte ptr es:[4], 80h	;@06E25
	je	@@3	;@06E2B
	mov	cx, 1Eh	;@06E2D
	call	L0716B	;@06E30
	and	byte ptr es:[4], 7Fh	;@06E33
	jmp	short @@3	;@06E39
@@2:	test	byte ptr es:[5], 20h	;@06E3B
	je	@@3	;@06E41
	jmp	L07092	;@06E43
@@3:	call	L08CE1	;@06E46
	push	es	;@06E49
	mov	es, ax	;@06E4A
	call	L018F9	;@06E4C
	pop	es	;@06E4F
	jmp	L070E2	;@06E50
L06E53:	mov	al, byte ptr es:[4]	;@06E53
	test	al, 94h	;@06E57
	jne	@@1	;@06E59
	ret	;@06E5B
@@1:	test	al, 80h	;@06E5C
	je	@@2	;@06E5E
	mov	cx, 1Eh	;@06E60
	call	L0716B	;@06E63
	and	al, 7Fh	;@06E66
@@2:	test	al, 10h	;@06E68
	je	@@3	;@06E6A
	mov	cx, 1Ch	;@06E6C
	call	L0716B	;@06E6F
	and	al, 0EFh	;@06E72
	mov	word ptr es:[12h], 0	;@06E74
@@3:	test	al, 4	;@06E7B
	je	@@4	;@06E7D
	mov	byte ptr es:[4], al	;@06E7F
	mov	cx, 6Eh	;@06E83
	jmp	L0A692	;@06E86
@@4:	mov	byte ptr es:[4], al	;@06E89
	ret	;@06E8D
L06E8E:	test	byte ptr es:[4], 80h	;@06E8E
	jne	@@1	;@06E94
	ret	;@06E96
@@1:	and	byte ptr es:[4], 7Fh	;@06E97
	mov	cx, 1Eh	;@06E9D
	jmp	L0716B	;@06EA0
L06EA3:	mov	al, byte ptr es:[4]	;@06EA3
	test	al, 0B0h	;@06EA7
	jne	@@1	;@06EA9
	ret	;@06EAB
@@1:	test	al, 80h	;@06EAC
	je	@@2	;@06EAE
	mov	cx, 1Eh	;@06EB0
	call	L0716B	;@06EB3
	and	al, 7Fh	;@06EB6
@@2:	test	al, 10h	;@06EB8
	je	@@3	;@06EBA
	mov	cx, 1Ch	;@06EBC
	call	L0716B	;@06EBF
	and	al, 0EFh	;@06EC2
	mov	word ptr es:[12h], 0	;@06EC4
@@3:	test	al, 20h	;@06ECB
	je	@@4	;@06ECD
	mov	cx, 1Dh	;@06ECF
	call	L0716B	;@06ED2
	and	al, 0DFh	;@06ED5
	mov	word ptr es:[10h], 1	;@06ED7
@@4:	mov	byte ptr es:[4], al	;@06EDE
	ret	;@06EE2
L06EE3:	test	byte ptr ds:[38D7h], 0Bh	;@06EE3
	jne	@@3	;@06EE8
	cmp	byte ptr ds:[38DAh], 0	;@06EEA
	jne	@@2	;@06EEF
	or	byte ptr ds:[38D8h], 1	;@06EF1
@@1:	ret	;@06EF6
@@2:	push	es	;@06EF7
	mov	es, word ptr es:[6]	;@06EF8
	call	L0065F	;@06EFD
	pop	es	;@06F00
	ret	;@06F01
@@3:	test	byte ptr ds:[38D7h], 8	;@06F02
	jne	@@4	;@06F07
	cmp	byte ptr ds:[38DDh], 0	;@06F09
	jne	@@1	;@06F0E
@@4:	cmp	byte ptr ds:[38D9h], 0	;@06F10
	jne	@@1	;@06F15
	mov	cx, 102Bh	;@06F17
	mov	di, word ptr es:[6]	;@06F1A
	jmp	L0716B	;@06F1F
L06F22:	mov	es, word ptr ds:[55D2h]	;@06F22
	mov	al, byte ptr es:[4]	;@06F26
	mov	es, word ptr ds:[55D6h]	;@06F2A
	mov	ah, byte ptr es:[4]	;@06F2E
	test	al, 40h	;@06F33
	je	@@3	;@06F35
	test	ah, 40h	;@06F37
	je	@@3	;@06F3A
	test	al, 20h	;@06F3C
	je	@@1	;@06F3E
	test	ah, 20h	;@06F40
	je	@@1	;@06F43
	and	byte ptr es:[4], 0DFh	;@06F45
	mov	word ptr es:[10h], 1	;@06F4B
	mov	cx, 1Bh	;@06F52
	call	L0716B	;@06F55
@@1:	test	al, 10h	;@06F58
	jne	@@2	;@06F5A
	test	ah, 10h	;@06F5C
	je	@@3	;@06F5F
@@2:	xor	cx, cx	;@06F61
	mov	es, word ptr ds:[55D2h]	;@06F63
	mov	word ptr es:[12h], cx	;@06F67
	and	byte ptr es:[4], 0EFh	;@06F6C
	mov	es, word ptr ds:[55D6h]	;@06F72
	mov	word ptr es:[12h], cx	;@06F76
	and	byte ptr es:[4], 0EFh	;@06F7B
	mov	cx, 1Ch	;@06F81
	call	L0716B	;@06F84
@@3:	mov	ds, word ptr ds:[55D2h]	;@06F87
	test	byte ptr ds:[4], 20h	;@06F8B
	je	@@5	;@06F90
	test	byte ptr es:[4], 40h	;@06F92
	je	@@4	;@06F98
	or	byte ptr es:[4], 10h	;@06F9A
	mov	ax, word ptr es:[0Eh]	;@06FA0
	mov	word ptr es:[12h], ax	;@06FA4
@@4:	or	byte ptr es:[4], 60h	;@06FA8
	mov	ax, word ptr ds:[0Eh]	;@06FAE
	mov	word ptr es:[0Eh], ax	;@06FB1
	mov	ax, word ptr ds:[10h]	;@06FB5
	mov	word ptr es:[10h], ax	;@06FB8
	test	byte ptr ds:[4], 10h	;@06FBC
	je	@@7	;@06FC1
	or	byte ptr es:[4], 10h	;@06FC3
	mov	ax, word ptr ds:[12h]	;@06FC9
	mov	word ptr es:[12h], ax	;@06FCC
	jmp	short @@7	;@06FD0
@@5:	test	byte ptr ds:[4], 40h	;@06FD2
	je	@@7	;@06FD7
	test	byte ptr es:[4], 40h	;@06FD9
	jne	@@6	;@06FDF
	mov	al, byte ptr ds:[4]	;@06FE1
	and	al, 70h	;@06FE4
	or	byte ptr es:[4], al	;@06FE6
	mov	ax, word ptr ds:[0Eh]	;@06FEB
	mov	word ptr es:[0Eh], ax	;@06FEE
	mov	ax, word ptr ds:[12h]	;@06FF2
	mov	word ptr es:[12h], ax	;@06FF5
	mov	word ptr es:[10h], 1	;@06FF9
	jmp	short @@7	;@07000
@@6:	or	byte ptr es:[4], 10h	;@07002
	mov	ax, word ptr ds:[0Eh]	;@07008
	mov	word ptr es:[12h], ax	;@0700B
@@7:	mov	ax, ss	;@0700F
	mov	ds, ax	;@07011
	ret	;@07013
L07014:	mov	es, word ptr ds:[55D6h]	;@07014
	test	byte ptr es:[0], 80h	;@07018
	jne	L07051	;@0701E
	test	byte ptr es:[5], 40h	;@07020
	je	L07029	;@07026
	ret	;@07028
L07029:	mov	es, word ptr ds:[55D2h]	;@07029
	test	byte ptr es:[5], 40h	;@0702D
	je	L07051	;@07033
	mov	bl, byte ptr es:[25h]	;@07035
	mov	ax, word ptr es:[1Ch]	;@0703A
	mov	es, word ptr ds:[55D6h]	;@0703E
	mov	word ptr es:[1Ch], ax	;@07042
	mov	byte ptr es:[25h], bl	;@07046
	or	byte ptr es:[5], 40h	;@0704B
L07051:	ret	;@07051
L07052:	mov	es, word ptr ds:[55D6h]	;@07052
	test	byte ptr es:[5], 20h	;@07056
	je	L0705F	;@0705C
	ret	;@0705E
L0705F:	mov	es, word ptr ds:[55D2h]	;@0705F
	test	byte ptr es:[5], 20h	;@07063
	je	@@1	;@07069
	mov	ax, word ptr es:[1Eh]	;@0706B
	mov	bx, word ptr es:[20h]	;@0706F
	mov	dx, word ptr es:[22h]	;@07074
	mov	es, word ptr ds:[55D6h]	;@07079
	or	byte ptr es:[5], 20h	;@0707D
	mov	word ptr es:[1Eh], ax	;@07083
	mov	word ptr es:[20h], bx	;@07087
	mov	word ptr es:[22h], dx	;@0708C
@@1:	ret	;@07091
L07092:	mov	ax, word ptr es:[1Eh]	;@07092
	mov	word ptr es:[14h], ax	;@07096
	mov	ax, word ptr es:[20h]	;@0709A
	mov	word ptr es:[16h], ax	;@0709E
	test	byte ptr es:[0], 80h	;@070A2
	jne	@@1	;@070A8
	mov	byte ptr es:[0], 80h	;@070AA
@@1:	mov	ax, word ptr es:[22h]	;@070B0
	and	ax, ax	;@070B4
	je	@@4	;@070B6
	mov	word ptr es:[18h], ax	;@070B8
	mov	bx, ax	;@070BC
	test	byte ptr es:[4], 4	;@070BE
	jne	@@2	;@070C4
	mov	word ptr es:[1Ah], bx	;@070C6
@@2:	mov	al, byte ptr es:[1]	;@070CB
	and	al, 7	;@070CF
	cmp	al, 2	;@070D1
	jae	@@3	;@070D3
	add	byte ptr es:[1], 2	;@070D5
@@3:	or	byte ptr es:[4], 4	;@070DB
@@4:	ret	;@070E1
L070E2:	mov	bx, ax	;@070E2
	or	byte ptr es:[0], 80h	;@070E4
	test	byte ptr es:[4], 4	;@070EA
	je	@@1	;@070F0
	test	word ptr ds:[5160h], 1000h	;@070F2
	je	@@1	;@070F8
	mov	al, byte ptr es:[1]	;@070FA
	and	al, 7	;@070FE
	cmp	al, 4	;@07100
	jb	@@1	;@07102
	push	bx	;@07104
	mov	cx, 6Dh	;@07105
	call	L0A692	;@07108
	pop	bx	;@0710B
@@1:	mov	ds, bx	;@0710C
	test	byte ptr ds:[4], 4	;@0710E
	je	@@4	;@07113
	cmp	word ptr ds:[6], 0	;@07115
	jne	@@4	;@0711A
	mov	bx, word ptr ds:[1Ah]	;@0711C
	test	byte ptr es:[4], 4	;@07120
	jne	@@2	;@07126
	mov	word ptr es:[1Ah], bx	;@07128
@@2:	mov	al, byte ptr es:[1]	;@0712D
	and	al, 7	;@07131
	cmp	al, 2	;@07133
	jae	@@3	;@07135
	add	byte ptr es:[1], 2	;@07137
@@3:	mov	word ptr es:[18h], bx	;@0713D
	mov	word ptr es:[22h], bx	;@07142
	or	byte ptr es:[4], 4	;@07147
@@4:	push	es	;@0714D
	mov	ax, ds	;@0714E
	mov	es, ax	;@07150
	push	ss	;@07152
	pop	ds	;@07153
	call	L0A6A9	;@07154
	mov	ax, word ptr es:[0Ah]	;@07157
	pop	es	;@0715B
	mov	word ptr es:[16h], ax	;@0715C
	mov	word ptr es:[20h], ax	;@07160
	or	byte ptr es:[5], 20h	;@07164
	ret	;@0716A
L0716B:	cmp	byte ptr ds:[38DAh], 0	;@0716B
	jne	@@1	;@07170
	jmp	L03208	;@07172
@@1:	ret	;@07175
L07176:	test	byte ptr es:[0], 80h	;@07176
	jne	@@1	;@0717C
	test	byte ptr es:[4], 0C0h	;@0717E
	je	@@2	;@07184
@@1:	call	L0909B	;@07186
	call	L092C7	;@07189
	jmp	short @@3	;@0718C
@@2:	call	L09087	;@0718E
	call	L09294	;@07191
@@3:	mov	bl, byte ptr es:[0]	;@07194
	and	bl, 7Fh	;@07199
	mov	ax, 2	;@0719C
	cmp	bl, 2	;@0719F
	je	@@4	;@071A2
	mov	ax, 4	;@071A4
	cmp	bl, 3	;@071A7
	je	@@4	;@071AA
	mov	ax, 6	;@071AC
	cmp	bl, 5	;@071AF
	je	@@4	;@071B2
	xor	ax, ax	;@071B4
@@4:	ret	;@071B6
L071B7:	mov	ax, word ptr ds:[55DCh]	;@071B7
	add	ax, 54h	;@071BA
	mov	cx, 2	;@071BD
@@1:	call	L0080F	;@071C0
	je	@@2	;@071C3
	call	L071EB	;@071C5
@@2:	add	ax, 2	;@071C8
	loop	@@1	;@071CB
	ret	;@071CD
L071CE:	mov	ax, word ptr ds:[55DCh]	;@071CE
	add	ax, 4Ch	;@071D1
	mov	cx, 6	;@071D4
	test	word ptr ds:[5160h], 8	;@071D7
	jne	@@1	;@071DD
	sub	cx, 2	;@071DF
@@1:	call	L071EB	;@071E2
	add	ax, 2	;@071E5
	loop	@@1	;@071E8
	ret	;@071EA
L071EB:	push	cx	;@071EB
	push	ax	;@071EC
	call	L05542	;@071ED
	mov	cx, es	;@071F0
	pop	ax	;@071F2
	push	ax	;@071F3
	mov	es, ax	;@071F4
	mov	ax, cx	;@071F6
	call	L0188A	;@071F8
	jne	@@1	;@071FB
	call	L018A8	;@071FD
@@1:	pop	ax	;@07200
	pop	cx	;@07201
	ret	;@07202
L07203:	test	byte ptr ds:[38D7h], 1	;@07203
	je	@@1	;@07208
	test	word ptr ds:[5198h], 8	;@0720A
	je	@@1	;@07210
	call	far ptr L100D8	;@07212
@@1:	push	ss	;@07217
	pop	es	;@07218
	mov	di, 1D4Eh	;@07219
	mov	cx, 9	;@0721C
	call	far ptr L11510	;@0721F
	test	byte ptr ds:[51A3h], 10h	;@07224
	jne	L07239	;@07229
L0722B:	mov	bx, 3A0Ah	;@0722B
	call	far ptr L11570	;@0722E
	call	far ptr L115CF	;@07233
	ret	;@07238
L07239:	mov	al, byte ptr ds:[51A3h]	;@07239
	and	ax, 7	;@0723C
	shl	ax, 1	;@0723F
	mov	bx, ax	;@07241
	jmp	word ptr [bx+1EFAh]	;@07243
L07247:	test	byte ptr ds:[516Ah], 10h	;@07247
	je	L0726E	;@0724C
	mov	bx, 1EA2h	;@0724E
	call	L07454	;@07251
	jmp	short L0728D	;@07254
L07256:	test	byte ptr ds:[516Ah], 10h	;@07256
	jne	L0727F	;@0725B
	jmp	short L07266	;@0725D
L0725F:	test	byte ptr ds:[516Ah], 10h	;@0725F
	je	L0727F	;@07264
L07266:	mov	bx, 1EB4h	;@07266
	call	L07454	;@07269
	jmp	short L0728D	;@0726C
L0726E:	mov	ax, word ptr ds:[5180h]	;@0726E
	or	ax, word ptr ds:[5182h]	;@07271
	or	ax, word ptr ds:[5184h]	;@07275
	or	ax, word ptr ds:[5186h]	;@07279
	je	L072BE	;@0727D
L0727F:	test	word ptr ds:[5160h], 2	;@0727F
	jne	L072AB	;@07285
	mov	bx, 1E9Ch	;@07287
	call	L07454	;@0728A
L0728D:	mov	ax, word ptr ds:[5184h]	;@0728D
	or	ax, word ptr ds:[5186h]	;@07290
	je	L072BE	;@07294
	mov	ax, word ptr ds:[5184h]	;@07296
	push	ss	;@07299
	pop	es	;@0729A
	mov	di, 1DCEh	;@0729B
	call	L04AA9	;@0729E
	mov	bx, 1DC6h	;@072A1
	call	far ptr L11570	;@072A4
	jmp	short L072BE	;@072A9
L072AB:	mov	ax, word ptr ds:[5184h]	;@072AB
	push	ss	;@072AE
	pop	es	;@072AF
	mov	di, 1DDCh	;@072B0
	call	L04AA9	;@072B3
	mov	bx, 1DD4h	;@072B6
	call	far ptr L11570	;@072B9
L072BE:	mov	bx, 5170h	;@072BE
	mov	cl, byte ptr ds:[519Eh]	;@072C1
	xor	ch, ch	;@072C5
	jcxz	@@2	;@072C7
@@1:	push	cx	;@072C9
	push	ss	;@072CA
	pop	es	;@072CB
	mov	di, 52C2h	;@072CC
	mov	si, 1DE4h	;@072CF
	call	L04ADB	;@072D2
	mov	ax, word ptr [bx]	;@072D5
	push	bx	;@072D7
	call	L04AC9	;@072D8
	mov	al, 0Dh	;@072DB
	stosb	;@072DD
	mov	bx, 52C2h	;@072DE
	call	far ptr L11570	;@072E1
	pop	bx	;@072E6
	pop	cx	;@072E7
	inc	bx	;@072E8
	inc	bx	;@072E9
	loop	@@1	;@072EA
@@2:	jmp	L0722B	;@072EC
L072EF:	test	byte ptr ds:[38D7h], 1	;@072EF
	je	@@1	;@072F4
	test	word ptr ds:[5198h], 8	;@072F6
	je	@@1	;@072FC
	call	far ptr L100D8	;@072FE
@@1:	push	ss	;@07303
	pop	es	;@07304
	mov	di, 1D57h	;@07305
	mov	cx, 7	;@07308
	call	far ptr L11510	;@0730B
	mov	bx, 5170h	;@07310
	mov	cl, byte ptr ds:[519Eh]	;@07313
	xor	ch, ch	;@07317
	jcxz	@@3	;@07319
	add	bx, cx	;@0731B
	add	bx, cx	;@0731D
@@2:	dec	bx	;@0731F
	dec	bx	;@07320
	push	cx	;@07321
	push	ss	;@07322
	pop	es	;@07323
	mov	di, 52C2h	;@07324
	mov	si, 1DEBh	;@07327
	call	L04ADB	;@0732A
	mov	ax, word ptr [bx]	;@0732D
	push	bx	;@0732F
	call	L04AC9	;@07330
	mov	al, 0Dh	;@07333
	stosb	;@07335
	mov	bx, 52C2h	;@07336
	call	far ptr L11570	;@07339
	pop	bx	;@0733E
	pop	cx	;@0733F
	loop	@@2	;@07340
@@3:	mov	al, byte ptr ds:[51A3h]	;@07342
	and	ax, 7	;@07345
	shl	ax, 1	;@07348
	mov	bx, ax	;@0734A
	jmp	word ptr [bx+1F02h]	;@0734C
	test	byte ptr ds:[516Ah], 10h	;@07350
	je	L07397	;@07355
	mov	ax, word ptr ds:[5184h]	;@07357
	or	ax, word ptr ds:[5186h]	;@0735A
	je	@@4	;@0735E
	mov	bx, 1EBCh	;@07360
	call	L07454	;@07363
@@4:	mov	bx, 1EC2h	;@07366
	call	L07454	;@07369
	jmp	short L073D2	;@0736C
L0736E:	test	byte ptr ds:[516Ah], 10h	;@0736E
	jne	L073A8	;@07373
	jmp	short L0737E	;@07375
L07377:	test	byte ptr ds:[516Ah], 10h	;@07377
	je	L073A8	;@0737C
L0737E:	mov	ax, word ptr ds:[5184h]	;@0737E
	or	ax, word ptr ds:[5186h]	;@07381
	je	@@1	;@07385
	mov	bx, 1DF1h	;@07387
	call	far ptr L11570	;@0738A
@@1:	mov	bx, 1EC4h	;@0738F
	call	L07454	;@07392
	jmp	short L073D2	;@07395
L07397:	mov	ax, word ptr ds:[5180h]	;@07397
	or	ax, word ptr ds:[5182h]	;@0739A
	or	ax, word ptr ds:[5184h]	;@0739E
	or	ax, word ptr ds:[5186h]	;@073A2
	je	L073D2	;@073A6
L073A8:	test	byte ptr ds:[5160h], 2	;@073A8
	jne	@@2	;@073AD
	mov	ax, word ptr ds:[5184h]	;@073AF
	or	ax, word ptr ds:[5186h]	;@073B2
	je	@@1	;@073B6
	mov	bx, 1DF1h	;@073B8
	call	far ptr L11570	;@073BB
@@1:	mov	bx, 1DFCh	;@073C0
	call	far ptr L11570	;@073C3
	jmp	short L073D2	;@073C8
@@2:	mov	bx, 1E04h	;@073CA
	call	far ptr L11570	;@073CD
L073D2:	xor	ax, ax	;@073D2
	test	byte ptr ds:[51A3h], 20h	;@073D4
	je	@@1	;@073D9
	mov	ax, word ptr ds:[5180h]	;@073DB
@@1:	push	ss	;@073DE
	pop	es	;@073DF
	mov	di, 1E11h	;@073E0
	call	L04AA9	;@073E3
	mov	bx, 1E0Ch	;@073E6
	call	far ptr L11570	;@073E9
	call	far ptr L115CF	;@073EE
	ret	;@073F3
L073F4:	push	ss	;@073F4
	pop	es	;@073F5
	mov	di, 1D5Eh	;@073F6
	mov	cx, 7	;@073F9
	call	far ptr L11510	;@073FC
	test	byte ptr ds:[516Bh], 4	;@07401
	mov	bx, 1ECAh	;@07406
	jne	@@1	;@07409
	test	byte ptr ds:[516Bh], 80h	;@0740B
	mov	bx, 1ECCh	;@07410
	jne	@@1	;@07413
	mov	bx, 1ED0h	;@07415
	call	L07454	;@07418
	test	byte ptr ds:[516Ah], 40h	;@0741B
	jne	@@2	;@07420
	mov	bx, 1ED8h	;@07422
	test	word ptr ds:[5160h], 2	;@07425
	je	@@1	;@0742B
	mov	bx, 1EEEh	;@0742D
@@1:	call	L07454	;@07430
@@2:	call	far ptr L115CF	;@07433
	ret	;@07438
L07439:	push	ss	;@07439
	pop	es	;@0743A
	mov	di, 1D65h	;@0743B
	mov	cx, 3	;@0743E
	call	far ptr L11510	;@07441
	mov	bx, 1E21h	;@07446
	call	far ptr L11570	;@07449
	call	far ptr L115CF	;@0744E
	ret	;@07453
L07454:	mov	cx, word ptr [bx]	;@07454
	jcxz	@@1	;@07456
	add	bx, 2	;@07458
	push	bx	;@0745B
	mov	bx, cx	;@0745C
	call	far ptr L11570	;@0745E
	pop	bx	;@07463
	jmp	L07454	;@07464
@@1:	ret	;@07466
L07467:	test	word ptr ds:[5160h], 1000h	;@07467
	je	@@1	;@0746D
	test	byte ptr ds:[38D7h], 0Bh	;@0746F
	je	@@2	;@07474
@@1:	mov	bx, dx	;@07476
	mov	dx, ax	;@07478
	call	L035F0	;@0747A
	mov	ax, bx	;@0747D
	call	L004C7	;@0747F
	and	al, 3Fh	;@07482
	cmp	al, 0	;@07484
	jne	@@3	;@07486
	test	byte ptr ds:[38D7h], 0Bh	;@07488
	jne	L074E9	;@0748D
@@2:	or	byte ptr ds:[38D8h], 1	;@0748F
	ret	;@07494
@@3:	test	al, 20h	;@07495
	je	L074F1	;@07497
	test	al, 10h	;@07499
	jne	L074F1	;@0749B
	test	word ptr ds:[5160h], 1000h	;@0749D
	je	@@4	;@074A3
	test	byte ptr ds:[38D7h], 1	;@074A5
	jne	@@5	;@074AA
	mov	ax, dx	;@074AC
	mov	dx, bx	;@074AE
	jmp	L07533	;@074B0
@@4:	mov	es, bx	;@074B3
	call	L00263	;@074B5
	xor	al, al	;@074B8
@@5:	ret	;@074BA
L074BB:	test	word ptr ds:[5160h], 1000h	;@074BB
	je	@@1	;@074C1
	test	byte ptr ds:[38D7h], 0Bh	;@074C3
	je	@@2	;@074C8
@@1:	mov	bx, dx	;@074CA
	mov	dx, ax	;@074CC
	call	L035F0	;@074CE
	mov	ax, bx	;@074D1
	call	L004C7	;@074D3
	and	al, 3Fh	;@074D6
	cmp	al, 0	;@074D8
	jne	L074F9	;@074DA
	test	byte ptr ds:[38D7h], 0Bh	;@074DC
	jne	L074E9	;@074E1
@@2:	or	byte ptr ds:[38D8h], 1	;@074E3
	ret	;@074E8
L074E9:	mov	cx, 102Bh	;@074E9
	mov	di, bx	;@074EC
	jmp	L03208	;@074EE
L074F1:	mov	di, bx	;@074F1
	mov	cx, 1013h	;@074F3
	jmp	L03208	;@074F6
L074F9:	test	al, 20h	;@074F9
	je	@@1	;@074FB
	test	al, 10h	;@074FD
	jne	L074F1	;@074FF
	jmp	short @@2	;@07501
@@1:	and	al, 1Fh	;@07503
	cmp	al, 1	;@07505
	je	L074F1	;@07507
	cmp	al, 9	;@07509
	je	L074F1	;@0750B
@@2:	test	word ptr ds:[5160h], 1000h	;@0750D
	je	@@3	;@07513
	test	byte ptr ds:[38D7h], 1	;@07515
	jne	@@4	;@0751A
	mov	ax, dx	;@0751C
	mov	dx, bx	;@0751E
	jmp	short L0752A	;@07520
@@3:	mov	es, bx	;@07522
	call	L0026A	;@07524
	xor	al, al	;@07527
@@4:	ret	;@07529
L0752A:	call	L07545	;@0752A
	call	L00279	;@0752D
	xor	al, al	;@07530
	ret	;@07532
L07533:	call	L07545	;@07533
	call	L0028D	;@07536
	xor	al, al	;@07539
	ret	;@0753B
L0753C:	call	L07545	;@0753C
	call	L002A1	;@0753F
	xor	al, al	;@07542
	ret	;@07544
L07545:	push	dx	;@07545
	call	L068C8	;@07546
	pop	cx	;@07549
	call	L0777D	;@0754A
	test	byte ptr es:[0], 80h	;@0754D
	je	@@2	;@07553
	call	L098B3	;@07555
	test	byte ptr es:[4], 4	;@07558
	je	@@3	;@0755E
	mov	ax, word ptr es:[1Ah]	;@07560
	push	cx	;@07564
	and	ax, ax	;@07565
	je	@@1	;@07567
	mov	es, ax	;@07569
	call	L0155F	;@0756B
@@1:	mov	bx, cx	;@0756E
	mov	cx, ax	;@07570
	mov	es, word ptr ds:[55D2h]	;@07572
	jmp	short @@4	;@07576
@@2:	call	L06DDC	;@07578
	call	L0999B	;@0757B
@@3:	push	cx	;@0757E
	xor	cx, cx	;@0757F
	xor	bx, bx	;@07581
@@4:	mov	ax, word ptr es:[0Ah]	;@07583
	mov	dx, word ptr es:[0Ch]	;@07587
	pop	di	;@0758C
	mov	es, di	;@0758D
	ret	;@0758F
L07590:	push	ax	;@07590
	push	dx	;@07591
	push	cx	;@07592
	push	di	;@07593
	call	L05542	;@07594
	pop	di	;@07597
	pop	cx	;@07598
	pop	dx	;@07599
	pop	ax	;@0759A
	mov	word ptr es:[0Ah], ax	;@0759B
	mov	word ptr es:[0Ch], dx	;@0759F
	mov	al, dh	;@075A4
	cbw	;@075A6
	mov	byte ptr es:[24h], ah	;@075A7
	mov	ax, 46h	;@075AC
	add	ax, word ptr ds:[55DCh]	;@075AF
	mov	word ptr es:[0Eh], ax	;@075B3
	mov	word ptr es:[4], 8040h	;@075B7
	push	bx	;@075BE
	push	di	;@075BF
	push	cx	;@075C0
	call	L06E14	;@075C1
	pop	cx	;@075C4
	pop	di	;@075C5
	pop	bx	;@075C6
	mov	dl, bl	;@075C7
	test	bl, 20h	;@075C9
	je	@@1	;@075CC
	sub	bl, 0A0h	;@075CE
	mov	byte ptr es:[0], bl	;@075D1
	mov	word ptr es:[2], di	;@075D6
@@1:	mov	ax, es	;@075DB
	push	ax	;@075DD
	mov	es, cx	;@075DE
	call	L01911	;@075E0
	pop	ax	;@075E3
	jne	@@2	;@075E4
	call	L0192E	;@075E6
@@2:	xor	al, al	;@075E9
	ret	;@075EB
L075EC:	push	ax	;@075EC
	push	dx	;@075ED
	push	cx	;@075EE
	call	L05542	;@075EF
	pop	cx	;@075F2
	pop	dx	;@075F3
	pop	ax	;@075F4
	mov	word ptr es:[0Ah], ax	;@075F5
	mov	word ptr es:[0Ch], dx	;@075F9
L075FE:	call	L0777D	;@075FE
	mov	ax, es	;@07601
	push	ax	;@07603
	call	@@2	;@07604
	mov	es, cx	;@07607
	call	L01911	;@07609
	pop	ax	;@0760C
	jne	@@1	;@0760D
	call	L035AC	;@0760F
	call	L0192E	;@07612
@@1:	mov	es, word ptr ds:[55D2h]	;@07615
	call	L0362D	;@07619
	xor	al, al	;@0761C
	ret	;@0761E
	db	8Ch, 6, 0D2h, 55h, 8Ch, 0C0h, 50h, 0E8h, 18h, 0, 8Eh, 0C1h, 0E8h	;@0761F
	db	0A4h, 9Fh, 58h, 75h, 6, 0E8h, 78h, 0BFh, 0E8h, 0B8h, 9Fh, 8Eh
	db	6, 0D2h, 55h, 0E8h, 0EFh, 0BFh, 32h, 0C0h, 0C3h
@@2:	test	word ptr ds:[5160h], 2000h	;@07641
	je	@@3	;@07647
	ret	;@07649
@@3:	xor	ax, ax	;@0764A
	and	byte ptr es:[5], 8Fh	;@0764C
	mov	word ptr es:[22h], ax	;@07652
	mov	word ptr es:[1Eh], ax	;@07656
	mov	word ptr es:[20h], ax	;@0765A
	mov	byte ptr es:[25h], al	;@0765E
	mov	word ptr es:[1Ch], ax	;@07662
	ret	;@07666
L07667:	call	L0777D	;@07667
	mov	es, cx	;@0766A
	call	L0188A	;@0766C
	jne	@@1	;@0766F
	push	es	;@07671
	mov	es, word ptr ds:[55D2h]	;@07672
	call	L07787	;@07676
	mov	ax, es	;@07679
	pop	es	;@0767B
	call	L018A8	;@0767C
@@1:	xor	al, al	;@0767F
	ret	;@07681
L07682:	call	L0777D	;@07682
	call	L0906C	;@07685
	call	L098B3	;@07688
	cmp	word ptr es:[6], 0	;@0768B
	jne	L076AB	;@07691
	mov	bx, word ptr es:[18h]	;@07693
	mov	di, word ptr es:[1Ah]	;@07698
	mov	ax, word ptr es:[0Ah]	;@0769D
	mov	dx, word ptr es:[0Ch]	;@076A1
	mov	cl, 0FFh	;@076A6
	jmp	L0383B	;@076A8
L076AB:	xor	cl, cl	;@076AB
	jmp	L0383B	;@076AD
L076B0:	call	L0663D	;@076B0
	call	L0777D	;@076B3
	call	L0909B	;@076B6
	call	L099C5	;@076B9
	cmp	word ptr es:[6], 0	;@076BC
	jne	L076EF	;@076C2
	test	byte ptr es:[4], 4	;@076C4
	je	L076FF	;@076CA
	mov	ax, word ptr ds:[5162h]	;@076CC
	cmp	word ptr es:[1Ah], ax	;@076CF
	je	L076FF	;@076D4
	mov	cx, 53h	;@076D6
	call	L03208	;@076D9
	jmp	short L076FF	;@076DC
L076DE:	call	L0777D	;@076DE
	call	L06DDC	;@076E1
	call	L0999B	;@076E4
	cmp	word ptr es:[6], 0	;@076E7
	je	L076FF	;@076ED
L076EF:	and	byte ptr ds:[38D8h], 0FEh	;@076EF
	mov	di, word ptr es:[6]	;@076F4
	mov	cx, 102Dh	;@076F9
	call	L03208	;@076FC
L076FF:	mov	ax, word ptr es:[0Ah]	;@076FF
	mov	cx, word ptr es:[0Ch]	;@07703
	test	word ptr ds:[5160h], 1008h	;@07708
	jne	@@2	;@0770E
	push	ax	;@07710
	mov	al, byte ptr es:[24h]	;@07711
	cbw	;@07715
	cmp	ax, cx	;@07716
	je	@@1	;@07718
	mov	cx, 808Fh	;@0771A
	call	L03208	;@0771D
@@1:	xor	cx, cx	;@07720
	pop	ax	;@07722
	ret	;@07723
@@2:	xor	bl, bl	;@07724
	ret	;@07726
L07727:	call	L076DE	;@07727
	cmp	byte ptr es:[24h], 0	;@0772A
	jne	@@1	;@07730
	mov	bx, ax	;@07732
	or	bx, cx	;@07734
	je	@@1	;@07736
	ret	;@07738
@@1:	mov	cx, 0Fh	;@07739
	call	L03208	;@0773C
	mov	ax, 1	;@0773F
	xor	cx, cx	;@07742
	ret	;@07744
L07745:	call	L0777D	;@07745
	cmp	word ptr es:[6], 0	;@07748
	jne	L07765	;@0774E
	mov	di, word ptr es:[2]	;@07750
	mov	bl, byte ptr es:[0]	;@07755
	test	bl, 80h	;@0775A
	je	@@1	;@0775D
	sub	bl, 60h	;@0775F
@@1:	xor	ax, ax	;@07762
	ret	;@07764
L07765:	test	byte ptr ds:[38D7h], 0Bh	;@07765
	mov	ax, word ptr es:[6]	;@0776A
	je	@@1	;@0776E
	mov	di, ax	;@07770
	mov	cx, 1007h	;@07772
	call	L03208	;@07775
@@1:	xor	bl, bl	;@07778
	xor	di, di	;@0777A
	ret	;@0777C
L0777D:	mov	word ptr ds:[55D2h], es	;@0777D
	push	cx	;@07781
	call	L0A736	;@07782
	pop	cx	;@07785
	ret	;@07786
L07787:	test	byte ptr es:[4], 44h	;@07787
	jne	@@1	;@0778D
	ret	;@0778F
@@1:	test	byte ptr es:[4], 40h	;@07790
	je	@@2	;@07796
	mov	cx, 19h	;@07798
	call	L0A678	;@0779B
@@2:	test	byte ptr es:[4], 4	;@0779E
	je	@@3	;@077A4
	cmp	word ptr es:[6], 0	;@077A6
	jne	@@3	;@077AC
	mov	al, byte ptr es:[1]	;@077AE
	and	al, 7	;@077B2
	cmp	al, 4	;@077B4
	je	@@3	;@077B6
	mov	cx, 69h	;@077B8
	jmp	L0A692	;@077BB
@@3:	ret	;@077BE
L077BF:	call	L08F70	;@077BF
	call	L06DDC	;@077C2
	test	byte ptr es:[4], 1	;@077C5
	je	@@4	;@077CB
	call	L0999B	;@077CD
	mov	ah, byte ptr es:[4]	;@077D0
	and	ah, 2	;@077D5
	mov	es, word ptr es:[8]	;@077D8
	call	L004A1	;@077DD
	call	L04956	;@077E0
	push	cx	;@077E3
	jcxz	@@3	;@077E4
	cld	;@077E6
@@1:	mov	al, byte ptr [bx]	;@077E7
	inc	bx	;@077E9
	push	bx	;@077EA
	call	L04110	;@077EB
	pop	bx	;@077EE
	cmp	word ptr ds:[5194h], 0	;@077EF
	je	@@2	;@077F4
	push	bx	;@077F6
	push	cx	;@077F7
	call	L036B0	;@077F8
	pop	cx	;@077FB
	pop	bx	;@077FC
	push	bx	;@077FD
	call	L03698	;@077FE
	pop	bx	;@07801
@@2:	loop	@@1	;@07802
@@3:	call	L036B0	;@07804
	pop	ax	;@07807
	xor	bh, bh	;@07808
	ret	;@0780A
@@4:	call	L09A17	;@0780B
	call	L0A1A2	;@0780E
	call	L036B0	;@07811
	mov	ax, 1	;@07814
	xor	bh, bh	;@07817
	ret	;@07819
L0781A:	call	L08F7A	;@0781A
	test	byte ptr es:[0], 80h	;@0781D
	jne	@@2	;@07823
	call	L06DDC	;@07825
	call	L099FF	;@07828
	call	L0A1C5	;@0782B
	push	es	;@0782E
	call	L036B0	;@0782F
	pop	es	;@07832
	mov	ax, 2	;@07833
	test	byte ptr es:[5], 40h	;@07836
	jne	@@1	;@0783C
	xor	bh, bh	;@0783E
	ret	;@07840
@@1:	mov	bh, 1	;@07841
	jmp	L079EC	;@07843
@@2:	call	L09916	;@07846
	call	L0A1C5	;@07849
	push	es	;@0784C
	call	L036B0	;@0784D
	pop	es	;@07850
	mov	ax, 2	;@07851
	mov	bh, 1	;@07854
	jmp	L079FA	;@07856
L07859:	call	L08F70	;@07859
	test	byte ptr es:[5], 10h	;@0785C
	jne	@@1	;@07862
	test	byte ptr es:[0], 80h	;@07864
	jne	@@5	;@0786A
@@1:	call	L06DDC	;@0786C
	test	byte ptr es:[4], 1	;@0786F
	je	@@2	;@07875
	call	L0999B	;@07877
	mov	ah, byte ptr es:[4]	;@0787A
	and	ah, 2	;@0787F
	mov	es, word ptr es:[8]	;@07882
	call	L004A1	;@07887
	call	L048E0	;@0788A
	mov	es, word ptr ds:[55D2h]	;@0788D
	call	L0A254	;@07891
	call	L036B0	;@07894
	mov	ax, 4	;@07897
	xor	bh, bh	;@0789A
	ret	;@0789C
@@2:	call	L099C5	;@0789D
	call	L0A1D1	;@078A0
	push	es	;@078A3
	call	L036B0	;@078A4
	pop	es	;@078A7
	test	byte ptr es:[5], 40h	;@078A8
	jne	@@3	;@078AE
	mov	ax, 4	;@078B0
	xor	bh, bh	;@078B3
	ret	;@078B5
@@3:	call	L09E84	;@078B6
	mov	bh, 2	;@078B9
	jae	@@4	;@078BB
	mov	bh, 3	;@078BD
@@4:	mov	ax, 4	;@078BF
	jmp	L079EC	;@078C2
@@5:	call	L0A736	;@078C5
	call	L09EE1	;@078C8
	jae	@@6	;@078CB
	call	L09962	;@078CD
	call	L0A1D1	;@078D0
	push	es	;@078D3
	call	L036B0	;@078D4
	pop	es	;@078D7
	mov	ax, 4	;@078D8
	mov	bh, 3	;@078DB
	jmp	L079FA	;@078DD
@@6:	call	L098F6	;@078E0
	call	L0A1E2	;@078E3
	push	es	;@078E6
	call	L036B0	;@078E7
	pop	es	;@078EA
	mov	ax, 4	;@078EB
	mov	bh, 2	;@078EE
	jmp	L079FA	;@078F0
L078F3:	call	L08F70	;@078F3
	call	L06DDC	;@078F6
	test	byte ptr es:[4], 1	;@078F9
	je	@@1	;@078FF
	call	L0999B	;@07901
	mov	ah, byte ptr es:[4]	;@07904
	and	ah, 2	;@07909
	mov	es, word ptr es:[8]	;@0790C
	call	L004A1	;@07911
	call	L04831	;@07914
	mov	es, word ptr ds:[55D2h]	;@07917
	call	L0A260	;@0791B
	call	L036B0	;@0791E
	mov	ax, 8	;@07921
	xor	bh, bh	;@07924
	ret	;@07926
@@1:	call	L099C5	;@07927
	call	L0A1F3	;@0792A
	call	L036B0	;@0792D
	mov	ax, 8	;@07930
	xor	bh, bh	;@07933
	ret	;@07935
L07936:	call	L08F70	;@07936
	test	byte ptr es:[5], 10h	;@07939
	jne	@@1	;@0793F
	test	byte ptr es:[0], 80h	;@07941
	jne	@@4	;@07947
@@1:	call	L06DDC	;@07949
	test	byte ptr es:[4], 1	;@0794C
	je	@@2	;@07952
	call	L0999B	;@07954
	mov	ah, byte ptr es:[4]	;@07957
	and	ah, 2	;@0795C
	mov	es, word ptr es:[8]	;@0795F
	call	L004A1	;@07964
	call	L04891	;@07967
	mov	es, word ptr ds:[55D2h]	;@0796A
	call	L0A25A	;@0796E
	call	L036B0	;@07971
	mov	ax, 6	;@07974
	xor	bh, bh	;@07977
	ret	;@07979
@@2:	call	L099C5	;@0797A
	call	L0A20C	;@0797D
	push	es	;@07980
	call	L036B0	;@07981
	pop	es	;@07984
	mov	ax, 6	;@07985
	test	byte ptr es:[5], 40h	;@07988
	jne	@@3	;@0798E
	xor	bh, bh	;@07990
	ret	;@07992
@@3:	mov	bh, 4	;@07993
	jmp	short L079EC	;@07995
@@4:	call	L098B3	;@07997
	call	L0A225	;@0799A
	push	es	;@0799D
	call	L036B0	;@0799E
	pop	es	;@079A1
	mov	ax, 6	;@079A2
	mov	bh, 4	;@079A5
	jmp	short L079FA	;@079A7
L079A9:	call	L08F70	;@079A9
	call	L06DDC	;@079AC
	test	byte ptr es:[4], 1	;@079AF
	je	@@1	;@079B5
	call	L0999B	;@079B7
	mov	ah, byte ptr es:[4]	;@079BA
	and	ah, 2	;@079BF
	mov	es, word ptr es:[8]	;@079C2
	call	L004A1	;@079C7
	call	L047CC	;@079CA
	mov	es, word ptr ds:[55D2h]	;@079CD
	call	L0A266	;@079D1
	call	L036B0	;@079D4
	mov	ax, 0Ah	;@079D7
	xor	bh, bh	;@079DA
	ret	;@079DC
@@1:	call	L099C5	;@079DD
	call	L0A23B	;@079E0
	call	L036B0	;@079E3
	mov	ax, 0Ah	;@079E6
	xor	bh, bh	;@079E9
	ret	;@079EB
L079EC:	mov	bl, byte ptr es:[25h]	;@079EC
	sub	bl, 60h	;@079F1
	mov	di, word ptr es:[1Ch]	;@079F4
	ret	;@079F9
L079FA:	mov	bl, byte ptr es:[0]	;@079FA
	sub	bl, 60h	;@079FF
	mov	di, word ptr es:[2]	;@07A02
	ret	;@07A07
L07A08:	mov	ax, 1	;@07A08
	xor	cx, cx	;@07A0B
	push	ax	;@07A0D
	call	L0420A	;@07A0E
	pop	ax	;@07A11
	mov	cx, 0	;@07A12
	ret	;@07A15
L07A16:	mov	ax, 2	;@07A16
	xor	cx, cx	;@07A19
	push	ax	;@07A1B
	call	L0420A	;@07A1C
	pop	ax	;@07A1F
	mov	cx, 0	;@07A20
	ret	;@07A23
L07A24:	mov	ax, 4	;@07A24
	xor	cx, cx	;@07A27
	push	ax	;@07A29
	call	L0420A	;@07A2A
	pop	ax	;@07A2D
	mov	cx, 0	;@07A2E
	ret	;@07A31
L07A32:	mov	ax, 6	;@07A32
	xor	cx, cx	;@07A35
	push	ax	;@07A37
	call	L0420A	;@07A38
	pop	ax	;@07A3B
	mov	cx, 0	;@07A3C
	ret	;@07A3F
L07A40:	mov	ax, 8	;@07A40
	xor	cx, cx	;@07A43
	push	ax	;@07A45
	call	L0420A	;@07A46
	pop	ax	;@07A49
	mov	cx, 0	;@07A4A
	ret	;@07A4D
L07A4E:	mov	ax, 0Ah	;@07A4E
	xor	cx, cx	;@07A51
	push	ax	;@07A53
	call	L0420A	;@07A54
	pop	ax	;@07A57
	mov	cx, 0	;@07A58
	ret	;@07A5B
L07A5C:	call	L03698	;@07A5C
	mov	al, cl	;@07A5F
	call	L04110	;@07A61
	jmp	L036B0	;@07A64
L07A67:	call	L03698	;@07A67
	test	word ptr ds:[5160h], 40h	;@07A6A
	jne	@@1	;@07A70
	mov	al, 9Bh	;@07A72
	call	L04110	;@07A74
	jmp	L036D2	;@07A77
@@1:	mov	di, 564Eh	;@07A7A
	call	L0A559	;@07A7D
	mov	al, 90h	;@07A80
	call	L04110	;@07A82
	mov	al, 9Bh	;@07A85
	call	L04110	;@07A87
	jmp	L036D2	;@07A8A
L07A8D:	call	L08F7A	;@07A8D
	call	L0909B	;@07A90
	call	L09198	;@07A93
	call	L097EA	;@07A96
	call	L08E96	;@07A99
	jmp	L036D2	;@07A9C
L07A9F:	call	L08F7A	;@07A9F
	call	L0909B	;@07AA2
	call	L097EA	;@07AA5
	test	cl, 10h	;@07AA8
	je	@@1	;@07AAB
	call	L07CDB	;@07AAD
@@1:	call	L08E96	;@07AB0
	jmp	L036D2	;@07AB3
L07AB6:	call	L08F7A	;@07AB6
	call	L0909B	;@07AB9
	call	L097EA	;@07ABC
	call	L07CCC	;@07ABF
	call	L08F1C	;@07AC2
	jmp	L036D2	;@07AC5
L07AC8:	call	L08F7A	;@07AC8
	call	L0909B	;@07ACB
	call	L0912D	;@07ACE
	call	L07CCC	;@07AD1
	test	word ptr ds:[5160h], 400h	;@07AD4
	je	@@1	;@07ADA
	mov	al, byte ptr es:[4]	;@07ADC
	and	al, 0C0h	;@07AE0
	xor	al, 40h	;@07AE2
	jne	@@1	;@07AE4
	mov	ax, word ptr es:[0Eh]	;@07AE6
	cmp	ax, word ptr ds:[5626h]	;@07AEA
	jne	@@1	;@07AEE
	call	L09809	;@07AF0
	mov	al, 0DFh	;@07AF3
	call	L04110	;@07AF5
	mov	al, 0E0h	;@07AF8
	call	L04110	;@07AFA
	jmp	L036D2	;@07AFD
@@1:	call	L097EA	;@07B00
	call	L08F1C	;@07B03
	jmp	L036D2	;@07B06
L07B09:	call	L08F7A	;@07B09
	call	L0909B	;@07B0C
	call	L0912D	;@07B0F
	test	word ptr ds:[5160h], 400h	;@07B12
	je	@@4	;@07B18
	mov	al, byte ptr es:[4]	;@07B1A
	and	al, 0C0h	;@07B1E
	xor	al, 40h	;@07B20
	jne	@@2	;@07B22
	mov	ax, word ptr es:[0Eh]	;@07B24
	cmp	ax, word ptr ds:[5626h]	;@07B28
	jne	@@3	;@07B2C
	call	L09809	;@07B2E
	test	word ptr ds:[5160h], 40h	;@07B31
	je	@@1	;@07B37
	mov	di, 5650h	;@07B39
	call	L0A559	;@07B3C
@@1:	mov	al, 9Bh	;@07B3F
	call	L04110	;@07B41
	mov	al, 0DFh	;@07B44
	call	L04110	;@07B46
	mov	al, 0E0h	;@07B49
	call	L04110	;@07B4B
	jmp	L036D2	;@07B4E
@@2:	test	word ptr ds:[5160h], 40h	;@07B51
	jne	@@4	;@07B57
@@3:	mov	al, 9Bh	;@07B59
	call	L04110	;@07B5B
@@4:	call	L097EA	;@07B5E
	call	L08E96	;@07B61
	jmp	L036D2	;@07B64
L07B67:	call	L08F7A	;@07B67
	call	L0909B	;@07B6A
	call	L0912D	;@07B6D
	call	L097EA	;@07B70
	test	cl, 10h	;@07B73
	je	@@1	;@07B76
	call	L07CDB	;@07B78
@@1:	call	L08E96	;@07B7B
	jmp	L036D2	;@07B7E
L07B81:	call	L08F7A	;@07B81
	call	L0909B	;@07B84
	call	L0912D	;@07B87
	call	L097EA	;@07B8A
	call	L07CCC	;@07B8D
	call	L08F1C	;@07B90
	jmp	L036D2	;@07B93
L07B96:	call	L08F7A	;@07B96
	call	L0909B	;@07B99
	call	L0919D	;@07B9C
	call	L097EA	;@07B9F
	call	L08E8B	;@07BA2
	jmp	L036D2	;@07BA5
L07BA8:	call	L08F7A	;@07BA8
	call	L0909B	;@07BAB
	call	L091C4	;@07BAE
	call	L097EA	;@07BB1
	cmp	byte ptr es:[0], 6	;@07BB4
	jne	@@1	;@07BBA
	mov	ch, 0DBh	;@07BBC
	call	L08E96	;@07BBE
	jmp	L036D2	;@07BC1
@@1:	mov	cl, ch	;@07BC4
	mov	ch, 0D9h	;@07BC6
	call	L08E8B	;@07BC8
	jmp	L036D2	;@07BCB
L07BCE:	call	L08F7A	;@07BCE
	call	L0909B	;@07BD1
	call	L091E4	;@07BD4
	call	L097EA	;@07BD7
	cmp	byte ptr es:[0], 4	;@07BDA
	jne	@@1	;@07BE0
	mov	ch, 0DBh	;@07BE2
	call	L08E8B	;@07BE4
	jmp	L036D2	;@07BE7
@@1:	mov	cl, ch	;@07BEA
	mov	ch, 0DBh	;@07BEC
	call	L08E8B	;@07BEE
	jmp	L036D2	;@07BF1
L07BF4:	call	L08F7A	;@07BF4
	call	L0909B	;@07BF7
	call	L09204	;@07BFA
	call	L097EA	;@07BFD
	call	L08E8B	;@07C00
	jmp	L036D2	;@07C03
L07C06:	call	L03698	;@07C06
	test	word ptr ds:[5160h], 40h	;@07C09
	je	@@1	;@07C0F
	mov	di, 5650h	;@07C11
	call	L0A559	;@07C14
	jmp	short @@2	;@07C17
@@1:	cmp	ch, 0DBh	;@07C19
	je	@@2	;@07C1C
	test	word ptr ds:[5160h], 400h	;@07C1E
	jne	@@3	;@07C24
@@2:	mov	al, 9Bh	;@07C26
	call	L04110	;@07C28
@@3:	mov	al, ch	;@07C2B
	call	L04110	;@07C2D
	mov	al, cl	;@07C30
	call	L04110	;@07C32
	jmp	L036D2	;@07C35
L07C38:	call	L03698	;@07C38
	mov	al, ch	;@07C3B
	call	L04110	;@07C3D
	mov	al, cl	;@07C40
	call	L04110	;@07C42
	jmp	L036D2	;@07C45
L07C48:	call	L08F7A	;@07C48
	call	L09087	;@07C4B
	call	L09A96	;@07C4E
	call	L08F27	;@07C51
	jmp	L036D2	;@07C54
L07C57:	call	L08F90	;@07C57
	call	L09087	;@07C5A
	call	L09A96	;@07C5D
	mov	dh, cl	;@07C60
	push	dx	;@07C62
	cmp	byte ptr es:[0Ah], 0	;@07C63
	je	L07C83	;@07C69
	mov	ax, 22h	;@07C6B
	call	L08FDB	;@07C6E
	mov	byte ptr es:[0Ah], 0	;@07C71
	jmp	short L07C83	;@07C77
L07C79:	push	dx	;@07C79
	call	L08F90	;@07C7A
	call	L09087	;@07C7D
	call	L09A96	;@07C80
L07C83:	mov	es, word ptr ds:[55D2h]	;@07C83
	call	L09087	;@07C87
	call	L09A96	;@07C8A
	pop	dx	;@07C8D
	cmp	byte ptr es:[0Ah], 0	;@07C8E
	je	@@1	;@07C94
	mov	es, word ptr ds:[55D6h]	;@07C96
	cmp	byte ptr es:[0Ah], 0	;@07C9A
	jne	@@2	;@07CA0
	or	ch, 4	;@07CA2
	mov	dh, cl	;@07CA5
	mov	es, word ptr ds:[55D2h]	;@07CA7
	mov	al, byte ptr es:[0Ah]	;@07CAB
	mov	es, word ptr ds:[55D6h]	;@07CAF
	mov	byte ptr es:[0Ah], al	;@07CB3
@@1:	mov	cl, dh	;@07CB7
	mov	es, word ptr ds:[55D6h]	;@07CB9
	call	L08F27	;@07CBD
	jmp	L036D2	;@07CC0
@@2:	mov	ax, 22h	;@07CC3
	call	L08FDB	;@07CC6
	jmp	L036D2	;@07CC9
L07CCC:	test	word ptr ds:[5160h], 40h	;@07CCC
	jne	@@1	;@07CD2
	ret	;@07CD4
@@1:	mov	ax, 55h	;@07CD5
	jmp	L08FDB	;@07CD8
L07CDB:	test	word ptr ds:[5160h], 400h	;@07CDB
	je	@@1	;@07CE1
	test	word ptr ds:[5160h], 40h	;@07CE3
	jne	@@1	;@07CE9
	mov	al, 9Bh	;@07CEB
	jmp	L04110	;@07CED
@@1:	ret	;@07CF0
L07CF1:	call	L08F7A	;@07CF1
	call	L090BE	;@07CF4
	jmp	short L07D0D	;@07CF7
L07CF9:	call	L08F7A	;@07CF9
	call	L090BE	;@07CFC
	call	L09F51	;@07CFF
	jmp	short L07D0D	;@07D02
L07D04:	call	L08F7A	;@07D04
	call	L090BE	;@07D07
	call	L09F63	;@07D0A
L07D0D:	test	word ptr ds:[5160h], 1	;@07D0D
	je	@@2	;@07D13
	mov	al, byte ptr es:[0]	;@07D15
	cmp	al, 87h	;@07D19
	je	@@2	;@07D1B
	cmp	al, 89h	;@07D1D
	jne	@@1	;@07D1F
	call	L09D68	;@07D21
	jae	@@1	;@07D24
	mov	al, cl	;@07D26
	call	L04110	;@07D28
	mov	al, 2	;@07D2B
	call	L04110	;@07D2D
	mov	al, 0EBh	;@07D30
	call	L04110	;@07D32
	call	L09EA7	;@07D35
	add	al, 3	;@07D38
	call	L04110	;@07D3A
	mov	cl, 0EAh	;@07D3D
	call	L08DD0	;@07D3F
	jmp	L036D2	;@07D42
@@1:	call	L09DDB	;@07D45
	jae	@@2	;@07D48
	mov	al, cl	;@07D4A
	call	L04110	;@07D4C
	mov	al, 2	;@07D4F
	call	L04110	;@07D51
	mov	al, 0EBh	;@07D54
	call	L04110	;@07D56
	call	L09EA7	;@07D59
	inc	al	;@07D5C
	call	L04110	;@07D5E
	mov	cl, 0E9h	;@07D61
	call	L08D91	;@07D63
	jmp	L036D2	;@07D66
@@2:	call	L08DF1	;@07D69
	jmp	L036D2	;@07D6C
L07D6F:	call	L08F7A	;@07D6F
	call	L090BE	;@07D72
	test	word ptr ds:[5160h], 9	;@07D75
	je	@@1	;@07D7B
	mov	al, byte ptr es:[0]	;@07D7D
	cmp	al, 87h	;@07D81
	je	@@1	;@07D83
	cmp	al, 89h	;@07D85
	jne	@@2	;@07D87
	call	L09D68	;@07D89
	jae	@@2	;@07D8C
	mov	al, cl	;@07D8E
	xor	al, 1	;@07D90
	call	L04110	;@07D92
	call	L09EA7	;@07D95
	add	al, 3	;@07D98
	call	L04110	;@07D9A
	mov	cl, 0EAh	;@07D9D
	call	L08DD0	;@07D9F
	jmp	L036D2	;@07DA2
@@1:	call	L08DF1	;@07DA5
	jmp	L036D2	;@07DA8
@@2:	call	L09DDB	;@07DAB
	jae	@@1	;@07DAE
	test	word ptr ds:[5160h], 8	;@07DB0
	jne	@@3	;@07DB6
	mov	al, cl	;@07DB8
	xor	al, 1	;@07DBA
	call	L04110	;@07DBC
	call	L09EA7	;@07DBF
	inc	al	;@07DC2
	call	L04110	;@07DC4
	mov	cl, 0E9h	;@07DC7
	call	L08D91	;@07DC9
	jmp	L036D2	;@07DCC
@@3:	mov	al, 0Fh	;@07DCF
	call	L04110	;@07DD1
L07DD4:	xor	cl, 0F0h	;@07DD4
	call	L08D91	;@07DD7
	jmp	L036D2	;@07DDA
L07DDD:	call	L08F7A	;@07DDD
	test	byte ptr es:[4], 80h	;@07DE0
	jne	@@1	;@07DE6
	call	L09020	;@07DE8
	jae	@@2	;@07DEB
@@1:	call	L0909B	;@07DED
	call	L09227	;@07DF0
	call	L097FF	;@07DF3
	mov	cl, 20h	;@07DF6
	call	L08D4F	;@07DF8
	jmp	L036D2	;@07DFB
@@2:	mov	al, byte ptr es:[0]	;@07DFE
	cmp	al, 87h	;@07E02
	je	@@5	;@07E04
	cmp	al, 89h	;@07E06
	jne	@@4	;@07E08
	test	word ptr ds:[5160h], 2000h	;@07E0A
	mov	bx, 9D70h	;@07E10
	je	@@3	;@07E13
	mov	bx, 9D68h	;@07E15
@@3:	call	bx	;@07E18
	jae	@@4	;@07E1A
	mov	cl, 0EAh	;@07E1C
	call	L08DD0	;@07E1E
	jmp	L036D2	;@07E21
@@4:	call	L09DDB	;@07E24
	jae	@@5	;@07E27
	mov	cl, 0E9h	;@07E29
	call	L08D91	;@07E2B
	jmp	L036D2	;@07E2E
@@5:	mov	cl, 0EBh	;@07E31
	call	L08DF1	;@07E33
	jmp	L036D2	;@07E36
L07E39:	call	L08F7A	;@07E39
	test	byte ptr es:[4], 80h	;@07E3C
	jne	@@1	;@07E42
	call	L09048	;@07E44
	jae	@@2	;@07E47
@@1:	call	L0909B	;@07E49
	call	L09227	;@07E4C
	call	L097FF	;@07E4F
	mov	cl, 10h	;@07E52
	call	L08D4F	;@07E54
	jmp	L036D2	;@07E57
@@2:	cmp	byte ptr es:[0], 89h	;@07E5A
	jne	@@4	;@07E60
	call	L09D68	;@07E62
	jae	@@3	;@07E65
	mov	cl, 9Ah	;@07E67
	call	L08DD0	;@07E69
	jmp	L036D2	;@07E6C
@@3:	mov	al, 0Eh	;@07E6F
	call	L04110	;@07E71
@@4:	mov	cl, 0E8h	;@07E74
	call	L08D91	;@07E76
	jmp	L036D2	;@07E79
L07E7C:	call	L08F90	;@07E7C
	mov	es, word ptr ds:[55D2h]	;@07E7F
	call	L09087	;@07E83
	call	L09173	;@07E86
	call	L09809	;@07E89
	test	byte ptr es:[4], 40h	;@07E8C
	je	@@4	;@07E92
	mov	ax, word ptr es:[0Eh]	;@07E94
	call	L08CCA	;@07E98
	and	al, al	;@07E9B
	jne	@@2	;@07E9D
	mov	es, word ptr ds:[55D6h]	;@07E9F
	call	L09087	;@07EA3
	mov	al, byte ptr es:[4]	;@07EA6
	and	al, 0C0h	;@07EAA
	xor	al, 40h	;@07EAC
	jne	@@1	;@07EAE
	call	L09809	;@07EB0
	mov	ax, word ptr es:[0Eh]	;@07EB3
	cmp	ax, word ptr ds:[562Ah]	;@07EB7
	jne	@@3	;@07EBB
	or	cl, 8	;@07EBD
	mov	es, word ptr ds:[55D2h]	;@07EC0
	call	L09F76	;@07EC4
	call	L08E7B	;@07EC7
	jmp	L036D2	;@07ECA
@@1:	call	L09A17	;@07ECD
	mov	es, word ptr ds:[55D2h]	;@07ED0
	call	L09F76	;@07ED4
	call	L08E7B	;@07ED7
	mov	es, word ptr ds:[55D6h]	;@07EDA
	call	L0A1A2	;@07EDE
	jmp	L036D2	;@07EE1
@@2:	mov	ax, 64h	;@07EE4
	jmp	short @@4	;@07EE7
@@3:	mov	ax, 65h	;@07EE9
@@4:	call	L08FDB	;@07EEC
	jmp	L036D2	;@07EEF
L07EF2:	call	L03698	;@07EF2
	call	L09F83	;@07EF5
	mov	al, cl	;@07EF8
	call	L04110	;@07EFA
	jmp	L036D2	;@07EFD
L07F00:	call	L03698	;@07F00
	mov	al, cl	;@07F03
	call	L04110	;@07F05
	jmp	L036D2	;@07F08
L07F0B:	call	L03698	;@07F0B
	mov	al, cl	;@07F0E
	call	L040BE	;@07F10
	jmp	L036D2	;@07F13
L07F16:	call	L03698	;@07F16
	mov	al, cl	;@07F19
	call	L04095	;@07F1B
	jmp	L036D2	;@07F1E
L07F21:	call	L03698	;@07F21
	mov	al, cl	;@07F24
	call	L04110	;@07F26
	mov	al, ch	;@07F29
	call	L04110	;@07F2B
	jmp	L036D2	;@07F2E
L07F31:	call	L08F90	;@07F31
	mov	es, word ptr ds:[55D2h]	;@07F34
	call	L0909B	;@07F38
	mov	es, word ptr ds:[55D6h]	;@07F3B
	call	L0909B	;@07F3F
	call	L09372	;@07F42
	mov	es, word ptr ds:[55D2h]	;@07F45
	call	L097EA	;@07F49
	mov	es, word ptr ds:[55D6h]	;@07F4C
	call	L097EA	;@07F50
	call	L09F76	;@07F53
	mov	es, word ptr ds:[55D2h]	;@07F56
	call	L05534	;@07F5A
	call	L09FEA	;@07F5D
	call	L0553B	;@07F60
	mov	es, word ptr ds:[55D6h]	;@07F63
	call	L08E78	;@07F67
	jmp	L036D2	;@07F6A
L07F6D:	call	L08F7A	;@07F6D
	call	L0909B	;@07F70
	call	L09173	;@07F73
	call	L097EA	;@07F76
	call	L09F76	;@07F79
	call	L08E78	;@07F7C
	jmp	L036D2	;@07F7F
L07F82:	call	L08F7A	;@07F82
	call	L0909B	;@07F85
	call	L090F7	;@07F88
	call	L097EA	;@07F8B
	mov	cl, 0D7h	;@07F8E
	call	L08E78	;@07F90
	jmp	L036D2	;@07F93
L07F96:	call	L08F90	;@07F96
	mov	es, word ptr ds:[55D6h]	;@07F99
	call	L0909B	;@07F9D
	mov	es, word ptr ds:[55D2h]	;@07FA0
	call	L09087	;@07FA4
	call	L0957D	;@07FA7
	mov	es, word ptr ds:[55D2h]	;@07FAA
	call	L09809	;@07FAE
	mov	ch, cl	;@07FB1
	call	L08D30	;@07FB3
	call	L09F76	;@07FB6
	mov	es, word ptr ds:[55D6h]	;@07FB9
	call	L097EA	;@07FBD
	call	L08F1C	;@07FC0
	jmp	L036D2	;@07FC3
L07FC6:	call	L08F90	;@07FC6
	mov	es, word ptr ds:[55D6h]	;@07FC9
	call	L0909B	;@07FCD
	mov	es, word ptr ds:[55D2h]	;@07FD0
	call	L09087	;@07FD4
	call	L09131	;@07FD7
	call	L09809	;@07FDA
	call	L08D30	;@07FDD
	call	L09F76	;@07FE0
	mov	es, word ptr ds:[55D6h]	;@07FE3
	call	L097EA	;@07FE7
	call	L0A021	;@07FEA
	test	word ptr ds:[5160h], 20h	;@07FED
	je	@@3	;@07FF3
	call	L09EE1	;@07FF5
	mov	es, word ptr ds:[55D2h]	;@07FF8
	jb	@@1	;@07FFC
	cmp	byte ptr es:[0], 2	;@07FFE
	jmp	short @@2	;@08004
@@1:	cmp	byte ptr es:[0], 3	;@08006
@@2:	mov	es, word ptr ds:[55D6h]	;@0800C
	jne	@@3	;@08010
	test	byte ptr es:[4], 40h	;@08012
	je	@@4	;@08018
@@3:	call	L09F4C	;@0801A
	mov	ch, 8Dh	;@0801D
	call	L08F1F	;@0801F
	jmp	L036D2	;@08022
@@4:	mov	al, cl	;@08025
	mov	cl, 3	;@08027
	shr	al, cl	;@08029
	or	al, 0B8h	;@0802B
	call	L04110	;@0802D
	call	L0A1AE	;@08030
	jmp	L036D2	;@08033
L08036:	call	L08F7A	;@08036
	call	L09087	;@08039
	call	L099FF	;@0803C
	xor	ax, ax	;@0803F
	call	L09D01	;@08041
	jae	@@1	;@08044
	mov	al, cl	;@08046
	call	L04110	;@08048
	call	L0A1C5	;@0804B
	jmp	L036D2	;@0804E
@@1:	mov	al, cl	;@08051
	or	al, 1	;@08053
	call	L04110	;@08055
	jmp	L036D2	;@08058
L0805B:	call	L08F7A	;@0805B
	call	L09087	;@0805E
	call	L09A17	;@08061
	mov	al, cl	;@08064
	call	L04110	;@08066
	call	L0A1A2	;@08069
	jmp	L036D2	;@0806C
L0806F:	call	L08F7A	;@0806F
	test	cl, 20h	;@08072
	jne	@@1	;@08075
	mov	byte ptr ds:[55D8h], 0FFh	;@08077
@@1:	call	L0909B	;@0807C
	call	L09173	;@0807F
	call	L097FF	;@08082
	call	L09F76	;@08085
	mov	ch, 0F6h	;@08088
	call	L08F11	;@0808A
	jmp	L036D2	;@0808D
L08090:	call	L08F90	;@08090
	mov	byte ptr ds:[55D8h], 0FFh	;@08093
	mov	es, word ptr ds:[55D2h]	;@08098
	call	L0909B	;@0809C
	call	L09173	;@0809F
	call	L097FF	;@080A2
	call	L09F76	;@080A5
	mov	es, word ptr ds:[55D6h]	;@080A8
	call	L09087	;@080AC
	mov	al, byte ptr es:[4]	;@080AF
	and	al, 0C0h	;@080B3
	xor	al, 40h	;@080B5
	jne	@@1	;@080B7
	call	L09809	;@080B9
	mov	ax, word ptr es:[0Eh]	;@080BC
	cmp	ax, word ptr ds:[55ECh]	;@080C0
	jne	@@4	;@080C4
	mov	es, word ptr ds:[55D2h]	;@080C6
	mov	ch, 0D2h	;@080CA
	call	L08F11	;@080CC
	jmp	L036D2	;@080CF
@@1:	call	L09A17	;@080D2
	mov	ax, 1	;@080D5
	call	L09D01	;@080D8
	jae	@@2	;@080DB
	test	word ptr ds:[5160h], 2	;@080DD
	je	@@3	;@080E3
	mov	ch, 0C0h	;@080E5
	mov	es, word ptr ds:[55D2h]	;@080E7
	call	L08F11	;@080EB
	mov	es, word ptr ds:[55D6h]	;@080EE
	call	L0A1A2	;@080F2
	jmp	L036D2	;@080F5
@@2:	mov	es, word ptr ds:[55D2h]	;@080F8
	mov	ch, 0D0h	;@080FC
	call	L08F11	;@080FE
	jmp	L036D2	;@08101
@@3:	cmp	word ptr es:[6], 0	;@08104
	jne	@@2	;@0810A
	mov	ax, 66h	;@0810C
	jmp	short @@5	;@0810F
@@4:	mov	ax, 67h	;@08111
@@5:	call	L08FDB	;@08114
	jmp	L036D2	;@08117
L0811A:	call	L08F7A	;@0811A
	call	L09087	;@0811D
	call	L09A17	;@08120
	mov	ax, 3	;@08123
	call	L09D01	;@08126
	jb	@@1	;@08129
	mov	al, 0CCh	;@0812B
	call	L04110	;@0812D
	jmp	L036D2	;@08130
@@1:	mov	al, 0CDh	;@08133
	call	L04110	;@08135
	call	L0A1A2	;@08138
	jmp	L036D2	;@0813B
L0813E:	call	L08F90	;@0813E
	mov	es, word ptr ds:[55D2h]	;@08141
	call	L09087	;@08145
	call	L09A5A	;@08148
	mov	es, word ptr ds:[55D6h]	;@0814B
	call	L0909B	;@0814F
	call	L097FF	;@08152
	mov	es, word ptr ds:[55D2h]	;@08155
	mov	al, byte ptr es:[0Ah]	;@08159
	mov	ch, al	;@0815D
	shr	ch, 1	;@0815F
	shr	ch, 1	;@08161
	shr	ch, 1	;@08163
	or	ch, 0D8h	;@08165
	and	al, 7	;@08168
	shl	al, 1	;@0816A
	shl	al, 1	;@0816C
	shl	al, 1	;@0816E
	mov	cl, al	;@08170
	mov	es, word ptr ds:[55D6h]	;@08172
	call	L08F1C	;@08176
	jmp	L036D2	;@08179
L0817C:	call	L08F7A	;@0817C
	mov	byte ptr ds:[55D8h], 0FFh	;@0817F
	call	L0909B	;@08184
	call	L09173	;@08187
	call	L097FF	;@0818A
	call	L09F76	;@0818D
	cmp	byte ptr es:[0], 1	;@08190
	je	@@1	;@08196
	mov	al, byte ptr es:[4]	;@08198
	and	al, 0C0h	;@0819C
	xor	al, 40h	;@0819E
	jne	@@1	;@081A0
	call	L08D13	;@081A2
	or	al, 40h	;@081A5
	or	al, cl	;@081A7
	call	L04110	;@081A9
	jmp	L036D2	;@081AC
@@1:	mov	ch, 0FEh	;@081AF
	call	L08F11	;@081B1
	jmp	L036D2	;@081B4
L081B7:	call	L08F90	;@081B7
	mov	es, word ptr ds:[55D2h]	;@081BA
	call	L0909B	;@081BE
	mov	es, word ptr ds:[55D6h]	;@081C1
	call	L0909B	;@081C5
	call	L09372	;@081C8
	mov	es, word ptr ds:[55D2h]	;@081CB
	mov	al, byte ptr es:[4]	;@081CF
	and	al, 0C0h	;@081D3
	xor	al, 40h	;@081D5
	jne	@@1	;@081D7
	mov	es, word ptr ds:[55D6h]	;@081D9
	mov	al, byte ptr es:[4]	;@081DD
	and	al, 0C0h	;@081E1
	xor	al, 40h	;@081E3
	jne	@@2	;@081E5
	cmp	byte ptr es:[0], 1	;@081E7
	je	@@2	;@081ED
	mov	ax, word ptr es:[0Eh]	;@081EF
	call	L08CCA	;@081F3
	and	al, al	;@081F6
	jne	@@2	;@081F8
@@1:	mov	ax, word ptr ds:[55D2h]	;@081FA
	xchg	word ptr ds:[55D6h], ax	;@081FD
	mov	word ptr ds:[55D2h], ax	;@08201
@@2:	mov	es, word ptr ds:[55D2h]	;@08204
	call	L09809	;@08208
	call	L09F76	;@0820B
	mov	es, word ptr ds:[55D6h]	;@0820E
	call	L097FF	;@08212
	mov	al, byte ptr es:[4]	;@08215
	and	al, 0C0h	;@08219
	xor	al, 40h	;@0821B
	jne	@@3	;@0821D
	mov	es, word ptr ds:[55D2h]	;@0821F
	cmp	byte ptr es:[0], 1	;@08223
	je	@@3	;@08229
	mov	ax, word ptr es:[0Eh]	;@0822B
	call	L08CCA	;@0822F
	and	al, al	;@08232
	jne	@@3	;@08234
	mov	es, word ptr ds:[55D6h]	;@08236
	call	L08D13	;@0823A
	or	al, 90h	;@0823D
	call	L04110	;@0823F
	jmp	L036D2	;@08242
@@3:	mov	byte ptr ds:[55D8h], 0FFh	;@08245
	mov	es, word ptr ds:[55D2h]	;@0824A
	call	L08D30	;@0824E
	mov	ch, 86h	;@08251
	mov	es, word ptr ds:[55D6h]	;@08253
	call	L08F11	;@08257
	jmp	L036D2	;@0825A
L0825D:	call	L08F90	;@0825D
	mov	es, word ptr ds:[55D2h]	;@08260
	call	L0909B	;@08264
	call	L09E3A	;@08267
	jb	@@1	;@0826A
	mov	es, word ptr ds:[55D6h]	;@0826C
	call	L09087	;@08270
	call	L09325	;@08273
	mov	es, word ptr ds:[55D6h]	;@08276
	call	L099B9	;@0827A
	mov	es, word ptr ds:[55D2h]	;@0827D
	call	L097FF	;@08281
	call	L09F76	;@08284
	mov	al, byte ptr es:[4]	;@08287
	and	al, 0C0h	;@0828B
	xor	al, 40h	;@0828D
	jne	@@3	;@0828F
	mov	ax, word ptr es:[0Eh]	;@08291
	call	L08CCA	;@08295
	and	al, al	;@08298
	jne	@@3	;@0829A
	mov	es, word ptr ds:[55D6h]	;@0829C
	mov	cl, 0A8h	;@082A0
	call	L08D3C	;@082A2
	jmp	L036D2	;@082A5
@@1:	mov	es, word ptr ds:[55D6h]	;@082A8
	call	L0909B	;@082AC
	call	L09372	;@082AF
	mov	es, word ptr ds:[55D2h]	;@082B2
	mov	al, byte ptr es:[4]	;@082B6
	and	al, 0C0h	;@082BA
	xor	al, 40h	;@082BC
	je	@@2	;@082BE
	mov	ax, word ptr ds:[55D2h]	;@082C0
	xchg	word ptr ds:[55D6h], ax	;@082C3
	mov	word ptr ds:[55D2h], ax	;@082C7
@@2:	mov	es, word ptr ds:[55D2h]	;@082CA
	call	L09809	;@082CE
	call	L08D30	;@082D1
	call	L09F76	;@082D4
	mov	es, word ptr ds:[55D6h]	;@082D7
	call	L097FF	;@082DB
	mov	ch, 84h	;@082DE
	call	L08F11	;@082E0
	jmp	L036D2	;@082E3
@@3:	xor	cl, cl	;@082E6
	mov	ch, 0F6h	;@082E8
	mov	es, word ptr ds:[55D2h]	;@082EA
	call	L08F11	;@082EE
	mov	es, word ptr ds:[55D6h]	;@082F1
	call	L0A196	;@082F5
	jmp	L036D2	;@082F8
L082FB:	call	L08F90	;@082FB
	mov	es, word ptr ds:[55D2h]	;@082FE
	call	L0909B	;@08302
	call	L09E3A	;@08305
	mov	es, word ptr ds:[55D6h]	;@08308
	jae	@@1	;@0830C
	jmp	short @@4	;@0830E
@@1:	call	L09087	;@08310
	call	L09325	;@08313
	mov	es, word ptr ds:[55D6h]	;@08316
	call	L099B9	;@0831A
	mov	es, word ptr ds:[55D2h]	;@0831D
	call	L097FF	;@08321
	call	L09F76	;@08324
	mov	al, byte ptr es:[4]	;@08327
	and	al, 0C0h	;@0832B
	xor	al, 40h	;@0832D
	jne	@@3	;@0832F
	call	L08D13	;@08331
	or	al, 0B0h	;@08334
	mov	cl, al	;@08336
	mov	es, word ptr ds:[55D6h]	;@08338
	cmp	byte ptr es:[0], 1	;@0833C
	je	@@2	;@08342
	or	cl, 8	;@08344
@@2:	mov	al, cl	;@08347
	call	L04110	;@08349
	call	L0A196	;@0834C
	jmp	L036D2	;@0834F
@@3:	mov	byte ptr ds:[55D8h], 0FFh	;@08352
	xor	cl, cl	;@08357
	mov	ch, 0C6h	;@08359
	mov	es, word ptr ds:[55D2h]	;@0835B
	call	L08F11	;@0835F
	mov	es, word ptr ds:[55D6h]	;@08362
	call	L0A196	;@08366
	jmp	L036D2	;@08369
@@4:	call	L0909B	;@0836C
	mov	es, word ptr ds:[55D2h]	;@0836F
	xor	cl, cl	;@08373
	mov	al, byte ptr es:[4]	;@08375
	and	al, 0C0h	;@08379
	xor	al, 40h	;@0837B
	jne	@@5	;@0837D
	mov	es, word ptr ds:[55D6h]	;@0837F
	mov	al, byte ptr es:[4]	;@08383
	and	al, 0C0h	;@08387
	xor	al, 40h	;@08389
	jne	@@6	;@0838B
	mov	ax, word ptr es:[0Eh]	;@0838D
	call	L08CCA	;@08391
	cmp	al, 8	;@08394
	jb	@@6	;@08396
@@5:	mov	byte ptr ds:[55D8h], 0FFh	;@08398
	mov	cl, 2	;@0839D
	mov	ax, word ptr ds:[55D2h]	;@0839F
	xchg	word ptr ds:[55D6h], ax	;@083A2
	mov	word ptr ds:[55D2h], ax	;@083A6
@@6:	xor	cl, 2	;@083A9
	mov	es, word ptr ds:[55D6h]	;@083AC
	call	L097FF	;@083B0
	mov	es, word ptr ds:[55D2h]	;@083B3
	call	L09809	;@083B7
	mov	ax, word ptr es:[0Eh]	;@083BA
	call	L08CCA	;@083BE
	and	al, al	;@083C1
	je	@@8	;@083C3
	sub	al, 8	;@083C5
	jae	@@10	;@083C7
@@7:	call	L09372	;@083C9
	mov	es, word ptr ds:[55D2h]	;@083CC
	mov	ch, cl	;@083D0
	or	ch, 88h	;@083D2
	call	L08D30	;@083D5
	call	L09F76	;@083D8
	mov	es, word ptr ds:[55D6h]	;@083DB
	call	L08F11	;@083DF
	jmp	L036D2	;@083E2
@@8:	mov	es, word ptr ds:[55D6h]	;@083E5
	mov	al, byte ptr es:[4]	;@083E9
	and	al, 0C0h	;@083ED
	xor	al, 80h	;@083EF
	jne	@@7	;@083F1
	call	L09372	;@083F3
	mov	es, word ptr ds:[55D6h]	;@083F6
	call	L09F76	;@083FA
	call	L09FA7	;@083FD
	xor	cl, 2	;@08400
	or	cl, 0A0h	;@08403
	cmp	byte ptr es:[0], 1	;@08406
	je	@@9	;@0840C
	or	cl, 1	;@0840E
@@9:	mov	al, cl	;@08411
	call	L04110	;@08413
	call	L0A1AE	;@08416
	jmp	L036D2	;@08419
@@10:	cmp	byte ptr es:[0], 3	;@0841C
	je	@@16	;@08422
	cmp	al, 1	;@08424
	je	@@15	;@08426
@@11:	mov	ch, cl	;@08428
	mov	cl, 3	;@0842A
	shl	al, cl	;@0842C
	or	ch, 8Ch	;@0842E
	mov	cl, al	;@08431
	mov	es, word ptr ds:[55D2h]	;@08433
	call	L0912D	;@08437
	mov	es, word ptr ds:[55D6h]	;@0843A
	mov	al, byte ptr es:[4]	;@0843E
	and	al, 0C0h	;@08442
	xor	al, 40h	;@08444
	jne	@@13	;@08446
	cmp	byte ptr ds:[55D8h], 0	;@08448
	jne	@@12	;@0844D
	call	L09301	;@0844F
	jmp	short @@14	;@08452
@@12:	call	L09131	;@08454
	call	L09F76	;@08457
	jmp	short @@14	;@0845A
@@13:	test	word ptr ds:[5160h], 2000h	;@0845C
	je	@@14	;@08462
	call	L0912D	;@08464
@@14:	call	L08F1C	;@08467
	jmp	L036D2	;@0846A
@@15:	cmp	byte ptr ds:[55D8h], 0	;@0846D
	jne	@@11	;@08472
	mov	cx, 22h	;@08474
	call	L03208	;@08477
	jmp	L036D2	;@0847A
@@16:	test	word ptr ds:[5160h], 8	;@0847D
	je	@@17	;@08483
	test	word ptr ds:[5160h], 80h	;@08485
	je	@@17	;@0848B
	push	ax	;@0848D
	call	L09372	;@0848E
	mov	es, word ptr ds:[55D6h]	;@08491
	call	L09809	;@08495
	pop	bx	;@08498
	xor	bh, bh	;@08499
	shl	bx, 1	;@0849B
	mov	ch, cl	;@0849D
	xor	cl, cl	;@0849F
	or	cx, word ptr [bx+1CCCh]	;@084A1
	call	L08F60	;@084A5
	jmp	L036D2	;@084A8
@@17:	mov	ax, 68h	;@084AB
	call	L08FDB	;@084AE
	jmp	L036D2	;@084B1
L084B4:	call	L08F90	;@084B4
	mov	es, word ptr ds:[55D2h]	;@084B7
	call	L0909B	;@084BB
	call	L09E3A	;@084BE
	mov	es, word ptr ds:[55D6h]	;@084C1
	jae	@@2	;@084C5
	call	L0909B	;@084C7
	call	L09372	;@084CA
	mov	es, word ptr ds:[55D2h]	;@084CD
	mov	al, byte ptr es:[4]	;@084D1
	and	al, 0C0h	;@084D5
	xor	al, 40h	;@084D7
	je	@@1	;@084D9
	mov	al, cl	;@084DB
	xor	al, 38h	;@084DD
	mov	byte ptr ds:[55D8h], al	;@084DF
	or	cl, 2	;@084E2
	mov	ax, word ptr ds:[55D2h]	;@084E5
	xchg	word ptr ds:[55D6h], ax	;@084E8
	mov	word ptr ds:[55D2h], ax	;@084EC
@@1:	xor	cl, 2	;@084EF
	mov	es, word ptr ds:[55D6h]	;@084F2
	call	L097FF	;@084F6
	mov	es, word ptr ds:[55D2h]	;@084F9
	call	L09809	;@084FD
	mov	ch, cl	;@08500
	call	L08D30	;@08502
	mov	es, word ptr ds:[55D6h]	;@08505
	call	L09F76	;@08509
	call	L08F11	;@0850C
	jmp	L036D2	;@0850F
@@2:	call	L09087	;@08512
	call	L09325	;@08515
	mov	es, word ptr ds:[55D6h]	;@08518
	call	L099B9	;@0851C
	call	L09F76	;@0851F
	mov	es, word ptr ds:[55D2h]	;@08522
	call	L097FF	;@08526
	mov	al, byte ptr es:[4]	;@08529
	and	al, 0C0h	;@0852D
	xor	al, 40h	;@0852F
	jne	@@4	;@08531
	mov	ax, word ptr es:[0Eh]	;@08533
	call	L08CCA	;@08537
	and	al, al	;@0853A
	jne	@@4	;@0853C
	mov	ax, word ptr es:[0Eh]	;@0853E
	cmp	ax, word ptr ds:[55FAh]	;@08542
	jne	@@3	;@08546
	mov	es, word ptr ds:[55D6h]	;@08548
	call	L09D38	;@0854C
	jae	@@4	;@0854F
@@3:	mov	es, word ptr ds:[55D6h]	;@08551
	or	cl, 4	;@08555
	call	L08D3C	;@08558
	jmp	L036D2	;@0855B
@@4:	mov	al, cl	;@0855E
	xor	al, 38h	;@08560
	mov	byte ptr ds:[55D8h], al	;@08562
	mov	es, word ptr ds:[55D6h]	;@08565
	mov	ch, 80h	;@08569
	cmp	byte ptr es:[0], 1	;@0856B
	je	@@7	;@08571
	or	ch, 1	;@08573
	test	word ptr ds:[5160h], 20h	;@08576
	jne	@@5	;@0857C
	cmp	cl, 20h	;@0857E
	je	@@6	;@08581
	cmp	cl, 8	;@08583
	je	@@6	;@08586
	cmp	cl, 30h	;@08588
	je	@@6	;@0858B
@@5:	call	L09D38	;@0858D
	jb	@@6	;@08590
	or	ch, 2	;@08592
	jmp	short @@7	;@08595
@@6:	mov	es, word ptr ds:[55D2h]	;@08597
	call	L08F1C	;@0859B
	mov	es, word ptr ds:[55D6h]	;@0859E
	call	L0A196	;@085A2
	jmp	L036D2	;@085A5
@@7:	mov	es, word ptr ds:[55D2h]	;@085A8
	call	L08F1C	;@085AC
	mov	es, word ptr ds:[55D6h]	;@085AF
	call	L0A1A2	;@085B3
	jmp	L036D2	;@085B6
L085B9:	call	L08F7A	;@085B9
	test	byte ptr es:[0], 80h	;@085BC
	jne	@@1	;@085C2
	test	byte ptr es:[4], 0C0h	;@085C4
	je	@@5	;@085CA
@@1:	mov	al, byte ptr es:[4]	;@085CC
	and	al, 0C0h	;@085D0
	xor	al, 40h	;@085D2
	jne	@@4	;@085D4
	call	L0909B	;@085D6
	call	L09131	;@085D9
	call	L09809	;@085DC
	mov	ax, word ptr es:[0Eh]	;@085DF
	call	L08CCA	;@085E3
	sub	al, 8	;@085E6
	jae	@@2	;@085E8
	mov	cl, al	;@085EA
	call	L09F76	;@085EC
	mov	al, cl	;@085EF
	add	al, 8	;@085F1
	or	al, 50h	;@085F3
	call	L04110	;@085F5
	jmp	L036D2	;@085F8
@@2:	mov	cl, al	;@085FB
	call	L0912D	;@085FD
	mov	al, cl	;@08600
	shl	al, 1	;@08602
	shl	al, 1	;@08604
	shl	al, 1	;@08606
	cmp	al, 20h	;@08608
	jae	@@3	;@0860A
	or	al, 6	;@0860C
	call	L04110	;@0860E
	jmp	L036D2	;@08611
@@3:	mov	cl, al	;@08614
	mov	al, 0Fh	;@08616
	call	L04110	;@08618
	mov	al, cl	;@0861B
	or	al, 80h	;@0861D
	call	L04110	;@0861F
	jmp	L036D2	;@08622
@@4:	jmp	@@9	;@08625
@@5:	mov	es, word ptr ds:[55D2h]	;@08628
	test	byte ptr es:[5], 80h	;@0862C
	je	@@6	;@08632
	test	word ptr ds:[5166h], 8000h	;@08634
	je	@@6	;@0863A
	mov	ax, 8080h	;@0863C
	call	L08FDB	;@0863F
@@6:	call	L09087	;@08642
	call	L09294	;@08645
	test	word ptr ds:[5160h], 2	;@08648
	je	@@8	;@0864E
	call	L09F76	;@08650
	mov	cl, 68h	;@08653
	call	L099B9	;@08655
	call	L09D38	;@08658
	jb	@@7	;@0865B
	or	cl, 2	;@0865D
	mov	al, cl	;@08660
	call	L04110	;@08662
	call	L0A1A2	;@08665
	jmp	L036D2	;@08668
@@7:	mov	al, cl	;@0866B
	call	L04110	;@0866D
	call	L0A196	;@08670
	jmp	L036D2	;@08673
@@8:	test	word ptr ds:[5160h], 20h	;@08676
	je	@@12	;@0867C
	call	L099FF	;@0867E
	mov	al, 50h	;@08681
	call	L04110	;@08683
	mov	al, 55h	;@08686
	call	L04110	;@08688
	mov	al, 8Bh	;@0868B
	call	L04110	;@0868D
	mov	al, 0ECh	;@08690
	call	L04110	;@08692
	mov	al, 0C7h	;@08695
	call	L04110	;@08697
	mov	al, 46h	;@0869A
	call	L04110	;@0869C
	mov	al, 2	;@0869F
	call	L04110	;@086A1
	call	L0A1C5	;@086A4
	mov	al, 5Dh	;@086A7
	call	L04110	;@086A9
	jmp	L036D2	;@086AC
@@9:	call	L0909B	;@086AF
	call	L092C7	;@086B2
	mov	al, byte ptr es:[0]	;@086B5
	test	word ptr ds:[5160h], 8	;@086B9
	jne	@@10	;@086BF
	cmp	al, 3	;@086C1
	jne	@@11	;@086C3
	mov	ax, 2	;@086C5
	mov	byte ptr es:[0], 2	;@086C8
	jmp	short @@13	;@086CE
@@10:	cmp	al, 5	;@086D0
	jne	@@11	;@086D2
	mov	ax, 4	;@086D4
	mov	byte ptr es:[0], 3	;@086D7
	jmp	short @@13	;@086DD
@@11:	call	L09F76	;@086DF
	mov	cx, 0FF30h	;@086E2
	call	L08F1C	;@086E5
	jmp	L036D2	;@086E8
@@12:	mov	cx, 8Ch	;@086EB
	call	L03208	;@086EE
	jmp	L036D2	;@086F1
@@13:	test	word ptr ds:[5160h], 20h	;@086F4
	je	@@12	;@086FA
	push	si	;@086FC
	push	ax	;@086FD
	push	es	;@086FE
	call	L05542	;@086FF
	pop	ds	;@08702
	pop	ax	;@08703
	push	ds	;@08704
	mov	si, 0	;@08705
	mov	di, 0	;@08708
	mov	cx, 28h	;@0870B
	rep movsb	;@0870E
	push	ss	;@08710
	pop	ds	;@08711
	mov	byte ptr es:[0], 2	;@08712
	add	word ptr es:[0Ah], ax	;@08718
	adc	word ptr es:[0Ch], 0	;@0871D
	adc	byte ptr es:[24h], 0	;@08723
	call	L09F76	;@08729
	mov	cx, 0FF30h	;@0872C
	call	L08F1C	;@0872F
	call	L036D2	;@08732
	call	L03698	;@08735
	pop	es	;@08738
	call	L09F76	;@08739
	mov	cx, 0FF30h	;@0873C
	call	L08F1C	;@0873F
	pop	si	;@08742
	jmp	L036D2	;@08743
L08746:	call	L08F7A	;@08746
	call	L0909B	;@08749
	call	L092C7	;@0874C
	mov	al, byte ptr es:[4]	;@0874F
	and	al, 0C0h	;@08753
	xor	al, 40h	;@08755
	jne	@@5	;@08757
	call	L09809	;@08759
	mov	ax, word ptr es:[0Eh]	;@0875C
	call	L08CCA	;@08760
	sub	al, 8	;@08763
	jae	@@1	;@08765
	add	al, 8	;@08767
	mov	cl, al	;@08769
	call	L09F76	;@0876B
	mov	al, cl	;@0876E
	or	al, 58h	;@08770
	call	L04110	;@08772
	jmp	L036D2	;@08775
@@1:	mov	cl, al	;@08778
	call	L0912D	;@0877A
	mov	al, cl	;@0877D
	cmp	al, 1	;@0877F
	je	@@2	;@08781
	shl	al, 1	;@08783
	shl	al, 1	;@08785
	shl	al, 1	;@08787
	cmp	al, 20h	;@08789
	jae	@@3	;@0878B
	or	al, 7	;@0878D
	call	L04110	;@0878F
	jmp	L036D2	;@08792
@@2:	mov	cx, 22h	;@08795
	call	L03208	;@08798
	jmp	L036D2	;@0879B
@@3:	test	word ptr ds:[5160h], 8	;@0879E
	je	@@4	;@087A4
	mov	cl, al	;@087A6
	mov	al, 0Fh	;@087A8
	call	L04110	;@087AA
	mov	al, cl	;@087AD
	or	al, 81h	;@087AF
	call	L04110	;@087B1
	jmp	L036D2	;@087B4
@@4:	mov	cx, 68h	;@087B7
	call	L03208	;@087BA
	jmp	L036D2	;@087BD
@@5:	mov	byte ptr ds:[55D8h], 0FFh	;@087C0
	call	L097FF	;@087C5
	mov	al, byte ptr es:[0]	;@087C8
	test	word ptr ds:[5160h], 8	;@087CC
	jne	@@6	;@087D2
	cmp	al, 3	;@087D4
	jne	@@7	;@087D6
	mov	byte ptr es:[0], 2	;@087D8
	mov	ax, 2	;@087DE
	jmp	short @@9	;@087E1
@@6:	cmp	al, 5	;@087E3
	jne	@@7	;@087E5
	mov	byte ptr es:[0], 3	;@087E7
	mov	ax, 4	;@087ED
	jmp	short @@9	;@087F0
@@7:	call	L09F76	;@087F2
	mov	cx, 8F00h	;@087F5
	call	L08F1C	;@087F8
	jmp	L036D2	;@087FB
@@8:	mov	cx, 8Ch	;@087FE
	call	L03208	;@08801
	jmp	L036D2	;@08804
@@9:	test	word ptr ds:[5160h], 20h	;@08807
	je	@@8	;@0880D
	push	si	;@0880F
	push	ax	;@08810
	push	es	;@08811
	call	L05542	;@08812
	pop	ds	;@08815
	pop	ax	;@08816
	push	ds	;@08817
	mov	si, 0	;@08818
	mov	di, 0	;@0881B
	mov	cx, 28h	;@0881E
	rep movsb	;@08821
	mov	byte ptr es:[0], 2	;@08823
	add	word ptr es:[0Ah], ax	;@08829
	adc	word ptr es:[0Ch], 0	;@0882E
	adc	byte ptr es:[24h], 0	;@08834
	mov	ax, es	;@0883A
	pop	es	;@0883C
	push	ax	;@0883D
	push	ss	;@0883E
	pop	ds	;@0883F
	call	L09F76	;@08840
	mov	cx, 8F00h	;@08843
	call	L08F1C	;@08846
	call	L036D2	;@08849
	call	L03698	;@0884C
	pop	es	;@0884F
	call	L09F76	;@08850
	mov	cx, 8F00h	;@08853
	call	L08F1C	;@08856
	pop	si	;@08859
	jmp	L036D2	;@0885A
L0885D:	call	L08F90	;@0885D
L08860:	mov	es, word ptr ds:[55D6h]	;@08860
	call	L09087	;@08864
	call	L09A17	;@08867
	mov	es, word ptr ds:[55D2h]	;@0886A
	call	L09087	;@0886E
	call	L099FF	;@08871
	mov	al, 0C8h	;@08874
	call	L04110	;@08876
	call	L0A1C5	;@08879
	mov	es, word ptr ds:[55D6h]	;@0887C
	call	L0A1A2	;@08880
	jmp	L036D2	;@08883
L08886:	call	L08F90	;@08886
	call	L09F83	;@08889
	jmp	L08860	;@0888C
L0888E:	call	L08F90	;@0888E
	call	L09F95	;@08891
	jmp	L08860	;@08894
L08896:	call	L08FB0	;@08896
	mov	byte ptr ds:[55D8h], 0FFh	;@08899
	mov	es, word ptr ds:[55D2h]	;@0889E
	call	L0909B	;@088A2
	call	L09809	;@088A5
	mov	es, word ptr ds:[55D4h]	;@088A8
	call	L0909B	;@088AC
	call	L097FF	;@088AF
	mov	es, word ptr ds:[55D6h]	;@088B2
	call	L09087	;@088B6
	call	L09712	;@088B9
	mov	es, word ptr ds:[55D6h]	;@088BC
	call	L099B9	;@088C0
	call	L09F76	;@088C3
	mov	ch, 69h	;@088C6
	call	L09D38	;@088C8
	jb	@@1	;@088CB
	or	ch, 2	;@088CD
	mov	es, word ptr ds:[55D2h]	;@088D0
	call	L08D30	;@088D4
	mov	es, word ptr ds:[55D4h]	;@088D7
	call	L08F1C	;@088DB
	mov	es, word ptr ds:[55D6h]	;@088DE
	call	L0A1A2	;@088E2
	jmp	L036D2	;@088E5
@@1:	mov	es, word ptr ds:[55D2h]	;@088E8
	call	L08D30	;@088EC
	mov	es, word ptr ds:[55D4h]	;@088EF
	call	L08F1C	;@088F3
	mov	es, word ptr ds:[55D6h]	;@088F6
	call	L0A196	;@088FA
	jmp	L036D2	;@088FD
L08900:	call	L08F90	;@08900
	mov	byte ptr ds:[55D8h], 0FFh	;@08903
	mov	es, word ptr ds:[55D2h]	;@08908
	call	L0909B	;@0890C
	call	L09E3A	;@0890F
	mov	es, word ptr ds:[55D6h]	;@08912
	jb	@@2	;@08916
	call	L09087	;@08918
	call	L093E3	;@0891B
	mov	es, word ptr ds:[55D2h]	;@0891E
	call	L09809	;@08922
	mov	es, word ptr ds:[55D6h]	;@08925
	call	L099B9	;@08929
	call	L09F76	;@0892C
	mov	ch, 69h	;@0892F
	call	L09D38	;@08931
	jb	@@1	;@08934
	or	ch, 2	;@08936
	mov	es, word ptr ds:[55D2h]	;@08939
	call	L08D30	;@0893D
	call	L08F1C	;@08940
	mov	es, word ptr ds:[55D6h]	;@08943
	call	L0A1A2	;@08947
	jmp	L036D2	;@0894A
@@1:	mov	es, word ptr ds:[55D2h]	;@0894D
	call	L08D30	;@08951
	call	L08F1C	;@08954
	mov	es, word ptr ds:[55D6h]	;@08957
	call	L0A196	;@0895B
	jmp	L036D2	;@0895E
@@2:	test	word ptr ds:[5160h], 8	;@08961
	je	@@3	;@08967
	call	L0909B	;@08969
	call	L094FA	;@0896C
	mov	es, word ptr ds:[55D2h]	;@0896F
	call	L09F76	;@08973
	call	L08D30	;@08976
	mov	ch, 0AFh	;@08979
	mov	es, word ptr ds:[55D6h]	;@0897B
	call	L08F60	;@0897F
	jmp	L036D2	;@08982
@@3:	mov	cx, 68h	;@08985
	call	L03208	;@08988
	jmp	L036D2	;@0898B
L0898E:	call	L08F90	;@0898E
	mov	es, word ptr ds:[55D6h]	;@08991
	call	L09087	;@08995
	mov	es, word ptr ds:[55D2h]	;@08998
	call	L0909B	;@0899C
	call	L09173	;@0899F
	call	L097EA	;@089A2
	call	L09F76	;@089A5
	mov	es, word ptr ds:[55D6h]	;@089A8
	call	L09809	;@089AC
	test	byte ptr es:[4], 40h	;@089AF
	je	@@1	;@089B5
	mov	ax, word ptr es:[0Eh]	;@089B7
	cmp	ax, word ptr ds:[562Ah]	;@089BB
	jne	@@1	;@089BF
	mov	es, word ptr ds:[55D2h]	;@089C1
	call	L08E78	;@089C5
	jmp	L036D2	;@089C8
@@1:	mov	ax, 65h	;@089CB
	call	L08FDB	;@089CE
	jmp	L036D2	;@089D1
L089D4:	call	L08F7A	;@089D4
	call	L0909B	;@089D7
	call	L09262	;@089DA
	call	L097EA	;@089DD
	test	word ptr ds:[5160h], 8	;@089E0
	je	@@1	;@089E6
	mov	al, byte ptr es:[5]	;@089E8
	test	al, 2	;@089EC
	jne	@@2	;@089EE
	test	al, 1	;@089F0
	jne	@@1	;@089F2
	mov	ax, word ptr ds:[5162h]	;@089F4
	and	ax, ax	;@089F7
	je	@@1	;@089F9
	call	L00752	;@089FB
	jne	@@2	;@089FE
@@1:	call	L09F83	;@08A00
	jmp	short @@3	;@08A03
@@2:	call	L09F95	;@08A05
@@3:	call	L08F60	;@08A08
	jmp	L036D2	;@08A0B
L08A0E:	call	L08F7A	;@08A0E
	call	L0909B	;@08A11
	call	L0912D	;@08A14
	call	L097FF	;@08A17
	call	L08F60	;@08A1A
	jmp	L036D2	;@08A1D
L08A20:	call	L08F90	;@08A20
	mov	es, word ptr ds:[55D2h]	;@08A23
	call	L0909B	;@08A27
	mov	es, word ptr ds:[55D6h]	;@08A2A
	call	L0909B	;@08A2E
	test	word ptr ds:[5160h], 1000h	;@08A31
	jne	@@1	;@08A37
	call	L09455	;@08A39
	jmp	short @@2	;@08A3C
@@1:	call	L094FA	;@08A3E
@@2:	mov	es, word ptr ds:[55D6h]	;@08A41
	call	L097FF	;@08A45
	mov	es, word ptr ds:[55D2h]	;@08A48
	call	L09809	;@08A4C
	mov	ch, cl	;@08A4F
	call	L08D30	;@08A51
	call	L09F76	;@08A54
	mov	es, word ptr ds:[55D6h]	;@08A57
	call	L08F1C	;@08A5B
	jmp	L036D2	;@08A5E
L08A61:	call	L08F90	;@08A61
	mov	es, word ptr ds:[55D2h]	;@08A64
	call	L0909B	;@08A68
	call	L0912D	;@08A6B
	mov	es, word ptr ds:[55D6h]	;@08A6E
	call	L0909B	;@08A72
	call	L0912D	;@08A75
	call	L097FF	;@08A78
	mov	es, word ptr ds:[55D2h]	;@08A7B
	call	L09809	;@08A7F
	mov	ch, cl	;@08A82
	call	L08D30	;@08A84
	mov	es, word ptr ds:[55D6h]	;@08A87
	call	L08F1C	;@08A8B
	jmp	L036D2	;@08A8E
L08A91:	call	L08F90	;@08A91
	mov	es, word ptr ds:[55D2h]	;@08A94
	call	L0909B	;@08A98
	mov	es, word ptr ds:[55D6h]	;@08A9B
	call	L0909B	;@08A9F
	call	L094FA	;@08AA2
	mov	es, word ptr ds:[55D6h]	;@08AA5
	call	L097FF	;@08AA9
	mov	es, word ptr ds:[55D2h]	;@08AAC
	call	L09809	;@08AB0
	mov	ch, cl	;@08AB3
	call	L08D30	;@08AB5
	call	L09F76	;@08AB8
	mov	es, word ptr ds:[55D6h]	;@08ABB
	call	L08F60	;@08ABF
	jmp	L036D2	;@08AC2
L08AC5:	call	L08F90	;@08AC5
	test	cl, 18h	;@08AC8
	je	@@1	;@08ACB
	mov	byte ptr ds:[55D8h], 0FFh	;@08ACD
@@1:	mov	es, word ptr ds:[55D2h]	;@08AD2
	call	L0909B	;@08AD6
	call	L097FF	;@08AD9
	mov	es, word ptr ds:[55D6h]	;@08ADC
	call	L09087	;@08AE0
	test	byte ptr es:[4], 40h	;@08AE3
	jne	@@2	;@08AE9
	call	L09A17	;@08AEB
	mov	ch, 0BAh	;@08AEE
	mov	es, word ptr ds:[55D2h]	;@08AF0
	call	L09131	;@08AF4
	call	L09F76	;@08AF7
	call	L08F60	;@08AFA
	mov	es, word ptr ds:[55D6h]	;@08AFD
	call	L0A1A2	;@08B01
	jmp	L036D2	;@08B04
@@2:	call	L094FA	;@08B07
	mov	es, word ptr ds:[55D6h]	;@08B0A
	call	L09809	;@08B0E
	mov	ch, cl	;@08B11
	or	ch, 83h	;@08B13
	call	L08D30	;@08B16
	call	L09F76	;@08B19
	mov	es, word ptr ds:[55D2h]	;@08B1C
	call	L08F60	;@08B20
	jmp	L036D2	;@08B23
L08B26:	call	L08F90	;@08B26
	mov	es, word ptr ds:[55D6h]	;@08B29
	call	L0909B	;@08B2D
	call	L097FF	;@08B30
	mov	es, word ptr ds:[55D2h]	;@08B33
	call	L09087	;@08B37
	call	L09809	;@08B3A
	call	L094FA	;@08B3D
	mov	es, word ptr ds:[55D2h]	;@08B40
	mov	ch, cl	;@08B44
	call	L08D30	;@08B46
	call	L09F76	;@08B49
	mov	es, word ptr ds:[55D6h]	;@08B4C
	call	L08F60	;@08B50
	jmp	L036D2	;@08B53
L08B56:	call	L08F90	;@08B56
	mov	es, word ptr ds:[55D6h]	;@08B59
	call	L0909B	;@08B5D
	call	L097FF	;@08B60
	mov	es, word ptr ds:[55D2h]	;@08B63
	call	L09087	;@08B67
	call	L09809	;@08B6A
	call	L0968E	;@08B6D
	mov	es, word ptr ds:[55D2h]	;@08B70
	mov	ch, cl	;@08B74
	call	L08D30	;@08B76
	call	L09F76	;@08B79
	mov	es, word ptr ds:[55D6h]	;@08B7C
	call	L08F55	;@08B80
	jmp	L036D2	;@08B83
L08B86:	call	L08F7A	;@08B86
	mov	byte ptr ds:[55D8h], 0FFh	;@08B89
	call	L0909B	;@08B8E
	call	L090F7	;@08B91
	call	L097FF	;@08B94
	mov	ch, cl	;@08B97
	xor	cl, cl	;@08B99
	call	L08F60	;@08B9B
	jmp	L036D2	;@08B9E
L08BA1:	push	es	;@08BA1
	mov	es, ax	;@08BA2
	pop	ax	;@08BA4
	call	L08FB0	;@08BA5
	mov	byte ptr ds:[55D8h], 0FFh	;@08BA8
	mov	es, word ptr ds:[55D2h]	;@08BAD
	call	L0909B	;@08BB1
	call	L097FF	;@08BB4
	mov	es, word ptr ds:[55D6h]	;@08BB7
	call	L09087	;@08BBB
	call	L09809	;@08BBE
	call	L094FA	;@08BC1
	mov	ch, cl	;@08BC4
	mov	es, word ptr ds:[55D6h]	;@08BC6
	call	L08D30	;@08BCA
	call	L09F76	;@08BCD
	mov	es, word ptr ds:[55D4h]	;@08BD0
	call	L09087	;@08BD4
	mov	al, byte ptr es:[4]	;@08BD7
	and	al, 0C0h	;@08BDB
	xor	al, 40h	;@08BDD
	jne	@@1	;@08BDF
	call	L09809	;@08BE1
	mov	ax, word ptr es:[0Eh]	;@08BE4
	cmp	ax, word ptr ds:[55ECh]	;@08BE8
	jne	@@2	;@08BEC
	or	ch, 1	;@08BEE
	mov	es, word ptr ds:[55D2h]	;@08BF1
	call	L08F60	;@08BF5
	jmp	L036D2	;@08BF8
@@1:	call	L09A17	;@08BFB
	mov	es, word ptr ds:[55D2h]	;@08BFE
	call	L08F60	;@08C02
	mov	es, word ptr ds:[55D4h]	;@08C05
	call	L0A1A2	;@08C09
	jmp	L036D2	;@08C0C
@@2:	mov	ax, 67h	;@08C0F
	call	L08FDB	;@08C12
	jmp	L036D2	;@08C15
L08C18:	call	L03698	;@08C18
	call	L09F95	;@08C1B
	mov	al, cl	;@08C1E
	call	L04110	;@08C20
	jmp	L036D2	;@08C23
L08C26:	call	L08F90	;@08C26
	mov	es, word ptr ds:[55D6h]	;@08C29
	call	L0909B	;@08C2D
	mov	es, word ptr ds:[55D2h]	;@08C30
	call	L09087	;@08C34
	call	L0957D	;@08C37
	mov	es, word ptr ds:[55D2h]	;@08C3A
	call	L09809	;@08C3E
	mov	ch, cl	;@08C41
	call	L08D30	;@08C43
	call	L09F76	;@08C46
	mov	es, word ptr ds:[55D6h]	;@08C49
	call	L097EA	;@08C4D
	call	L08F60	;@08C50
	jmp	L036D2	;@08C53
L08C56:	call	L08F7A	;@08C56
	call	L0909B	;@08C59
	call	L09131	;@08C5C
	call	L09809	;@08C5F
	call	L09F76	;@08C62
	call	L08D13	;@08C65
	mov	cl, al	;@08C68
	or	cl, 0C8h	;@08C6A
	mov	al, 0Fh	;@08C6D
	call	L04110	;@08C6F
	mov	al, cl	;@08C72
	call	L04110	;@08C74
	jmp	L036D2	;@08C77
L08C7A:	call	L08F90	;@08C7A
	mov	es, word ptr ds:[55D2h]	;@08C7D
	call	L0909B	;@08C81
	mov	es, word ptr ds:[55D6h]	;@08C84
	call	L0909B	;@08C88
	call	L09372	;@08C8B
	mov	es, word ptr ds:[55D2h]	;@08C8E
	call	L097FF	;@08C92
	call	L09F76	;@08C95
	mov	es, word ptr ds:[55D6h]	;@08C98
	call	L09809	;@08C9C
	mov	byte ptr ds:[55D8h], 0FFh	;@08C9F
	mov	ch, cl	;@08CA4
	mov	es, word ptr ds:[55D6h]	;@08CA6
	call	L08D30	;@08CAA
	mov	es, word ptr ds:[55D2h]	;@08CAD
	call	L08F55	;@08CB1
	jmp	L036D2	;@08CB4
L08CB7:	call	L08F7A	;@08CB7
	call	L0909B	;@08CBA
	call	L097EA	;@08CBD
	mov	ch, 1	;@08CC0
	mov	cl, 38h	;@08CC2
	call	L08F60	;@08CC4
	jmp	L036D2	;@08CC7
L08CCA:	sub	ax, word ptr ds:[55DCh]	;@08CCA
	shr	ax, 1	;@08CCE
	cmp	ax, 8	;@08CD0
	jb	@@1	;@08CD3
	sub	ax, 8	;@08CD5
	cmp	ax, 16h	;@08CD8
	jb	@@1	;@08CDB
	sub	ax, 16h	;@08CDD
@@1:	ret	;@08CE0
L08CE1:	test	byte ptr es:[4], 40h	;@08CE1
	je	@@1	;@08CE7
	mov	ax, word ptr es:[0Eh]	;@08CE9
	call	L08CCA	;@08CED
	and	al, 6	;@08CF0
	cmp	al, 4	;@08CF2
	je	@@2	;@08CF4
	test	byte ptr es:[4], 10h	;@08CF6
	je	@@1	;@08CFC
	mov	ax, word ptr es:[12h]	;@08CFE
	call	L08CCA	;@08D02
	and	al, 6	;@08D05
	cmp	al, 4	;@08D07
	je	@@2	;@08D09
@@1:	mov	ax, word ptr ds:[55DAh]	;@08D0B
	ret	;@08D0E
@@2:	mov	ax, word ptr ds:[563Ah]	;@08D0F
	ret	;@08D12
L08D13:	test	byte ptr es:[4], 40h	;@08D13
	je	@@1	;@08D19
	mov	ax, word ptr es:[0Eh]	;@08D1B
	call	L08CCA	;@08D1F
	cmp	al, 8	;@08D22
	jae	@@2	;@08D24
@@1:	ret	;@08D26
@@2:	mov	ax, 3Eh	;@08D27
	call	L08FDB	;@08D2A
	xor	al, al	;@08D2D
	ret	;@08D2F
L08D30:	call	L08D13	;@08D30
	shl	al, 1	;@08D33
	shl	al, 1	;@08D35
	shl	al, 1	;@08D37
	mov	cl, al	;@08D39
	ret	;@08D3B
L08D3C:	cmp	byte ptr es:[0], 1	;@08D3C
	je	@@1	;@08D42
	or	cl, 1	;@08D44
@@1:	mov	al, cl	;@08D47
	call	L04110	;@08D49
	jmp	L0A196	;@08D4C
L08D4F:	mov	al, byte ptr es:[0]	;@08D4F
	cmp	al, 2	;@08D53
	je	@@2	;@08D55
	test	word ptr ds:[5160h], 8	;@08D57
	je	@@1	;@08D5D
	cmp	al, 5	;@08D5F
	je	@@3	;@08D61
	mov	al, byte ptr es:[5]	;@08D63
	test	al, 2	;@08D67
	jne	@@4	;@08D69
	test	al, 1	;@08D6B
	jne	@@1	;@08D6D
	mov	ax, word ptr ds:[5162h]	;@08D6F
	and	ax, ax	;@08D72
	je	@@1	;@08D74
	call	L00752	;@08D76
	jne	@@4	;@08D79
@@1:	or	cl, 8	;@08D7B
@@2:	call	L09F83	;@08D7E
	mov	ch, 0FFh	;@08D81
	jmp	L08F1C	;@08D83
@@3:	or	cl, 8	;@08D86
@@4:	call	L09F95	;@08D89
	mov	ch, 0FFh	;@08D8C
	jmp	L08F1C	;@08D8E
L08D91:	call	L08E14	;@08D91
	call	L09CD9	;@08D94
	call	L09EA7	;@08D97
	inc	al	;@08D9A
	xor	ah, ah	;@08D9C
	sub	word ptr es:[0Ah], ax	;@08D9E
	sbb	word ptr es:[0Ch], 0	;@08DA3
	sbb	byte ptr es:[24h], 0	;@08DA9
	call	L09E84	;@08DAF
	jae	@@1	;@08DB2
	call	L09BBD	;@08DB4
	call	L09F95	;@08DB7
	mov	al, cl	;@08DBA
	call	L04110	;@08DBC
	jmp	L0A1D1	;@08DBF
@@1:	call	L09B53	;@08DC2
	call	L09F83	;@08DC5
	mov	al, cl	;@08DC8
	call	L04110	;@08DCA
	jmp	L0A1C5	;@08DCD
L08DD0:	call	L09E84	;@08DD0
	jae	@@1	;@08DD3
	call	L098B3	;@08DD5
	call	L09F95	;@08DD8
	mov	al, cl	;@08DDB
	call	L04110	;@08DDD
	jmp	L0A225	;@08DE0
@@1:	call	L098F6	;@08DE3
	call	L09F83	;@08DE6
	mov	al, cl	;@08DE9
	call	L04110	;@08DEB
	jmp	L0A1E2	;@08DEE
L08DF1:	call	L08E14	;@08DF1
	call	L09CD9	;@08DF4
	sub	word ptr es:[0Ah], 2	;@08DF7
	sbb	word ptr es:[0Ch], 0	;@08DFD
	sbb	byte ptr es:[24h], 0	;@08E03
	call	L09AD2	;@08E09
	mov	al, cl	;@08E0C
	call	L04110	;@08E0E
	jmp	L0A1A2	;@08E11
L08E14:	mov	ax, word ptr ds:[5162h]	;@08E14
	test	word ptr ds:[5160h], 1000h	;@08E17
	jne	@@1	;@08E1D
	push	es	;@08E1F
	mov	es, word ptr ds:[5638h]	;@08E20
	push	cx	;@08E24
	call	L018F9	;@08E25
	pop	cx	;@08E28
	mov	es, ax	;@08E29
	cmp	word ptr es:[6], 0	;@08E2B
	jne	@@3	;@08E31
	mov	ax, word ptr es:[1Ah]	;@08E33
	test	byte ptr es:[4], 4	;@08E37
	pop	es	;@08E3D
	je	@@4	;@08E3E
@@1:	and	ax, ax	;@08E40
	je	@@4	;@08E42
	mov	dx, ax	;@08E44
	mov	ax, word ptr es:[18h]	;@08E46
	and	ax, ax	;@08E4A
	je	@@4	;@08E4C
	push	es	;@08E4E
	mov	es, ax	;@08E4F
	call	L0150E	;@08E51
	call	L014F8	;@08E54
	xchg	ax, dx	;@08E57
	mov	es, ax	;@08E58
	call	L0150E	;@08E5A
	call	L014F8	;@08E5D
	pop	es	;@08E60
	cmp	ax, dx	;@08E61
	je	@@2	;@08E63
	mov	ax, dx	;@08E65
	call	L0072A	;@08E67
	je	@@4	;@08E6A
@@2:	ret	;@08E6C
@@3:	pop	es	;@08E6D
	ret	;@08E6E
@@4:	push	cx	;@08E6F
	mov	cx, 88h	;@08E70
	call	L03208	;@08E73
	pop	cx	;@08E76
	ret	;@08E77
L08E78:	call	L09FA7	;@08E78
L08E7B:	cmp	byte ptr es:[0], 1	;@08E7B
	je	@@1	;@08E81
	or	cl, 1	;@08E83
@@1:	mov	al, cl	;@08E86
	jmp	L04110	;@08E88
L08E8B:	cmp	byte ptr es:[0], 3	;@08E8B
	je	L08E96	;@08E91
	or	ch, 4	;@08E93
L08E96:	test	word ptr ds:[5160h], 40h	;@08E96
	je	@@4	;@08E9C
	cmp	word ptr es:[6], 0	;@08E9E
	jne	@@5	;@08EA4
	call	L09FEA	;@08EA6
	je	@@3	;@08EA9
	call	L08CCA	;@08EAB
	sub	al, 8	;@08EAE
	cbw	;@08EB0
	shl	ax, 1	;@08EB1
	mov	bx, ax	;@08EB3
	mov	di, word ptr [bx+1CEEh]	;@08EB5
	and	di, di	;@08EB9
	je	@@1	;@08EBB
	push	bx	;@08EBD
	call	L0A559	;@08EBE
	pop	bx	;@08EC1
@@1:	push	bx	;@08EC2
	mov	al, 9Bh	;@08EC3
	call	L04110	;@08EC5
	pop	bx	;@08EC8
	mov	di, word ptr [bx+1CFAh]	;@08EC9
	and	di, di	;@08ECD
	je	@@2	;@08ECF
	push	bx	;@08ED1
	call	L0A559	;@08ED2
	pop	bx	;@08ED5
@@2:	mov	al, bl	;@08ED6
	shr	al, 1	;@08ED8
	mov	bx, 1CE8h	;@08EDA
	xlat	;@08EDD
	call	L04095	;@08EDE
	call	L09F4C	;@08EE1
	mov	al, ch	;@08EE4
	call	L04110	;@08EE6
	jmp	L0A26C	;@08EE9
@@3:	mov	di, 5650h	;@08EEC
	call	L0A559	;@08EEF
	mov	al, 9Bh	;@08EF2
	call	L04110	;@08EF4
	call	L09F4C	;@08EF7
	mov	al, ch	;@08EFA
	call	L04110	;@08EFC
	jmp	L0A26C	;@08EFF
@@4:	test	word ptr ds:[5160h], 400h	;@08F02
	jne	L08F1C	;@08F08
@@5:	mov	al, 9Bh	;@08F0A
	call	L04110	;@08F0C
	jmp	short L08F1C	;@08F0F
L08F11:	cmp	byte ptr es:[0], 1	;@08F11
	je	L08F1C	;@08F17
	or	ch, 1	;@08F19
L08F1C:	call	L09FA7	;@08F1C
L08F1F:	mov	al, ch	;@08F1F
	call	L04110	;@08F21
	jmp	L0A26C	;@08F24
L08F27:	test	word ptr ds:[5160h], 40h	;@08F27
	je	@@1	;@08F2D
	mov	di, 5650h	;@08F2F
	call	L0A559	;@08F32
	jmp	short @@2	;@08F35
@@1:	test	word ptr ds:[5160h], 400h	;@08F37
	jne	@@3	;@08F3D
@@2:	mov	al, 9Bh	;@08F3F
	call	L04110	;@08F41
@@3:	mov	al, ch	;@08F44
	call	L04110	;@08F46
	mov	al, cl	;@08F49
	or	al, 0C0h	;@08F4B
	or	al, byte ptr es:[0Ah]	;@08F4D
	jmp	L04110	;@08F52
L08F55:	cmp	byte ptr es:[0], 1	;@08F55
	je	L08F60	;@08F5B
	or	ch, 1	;@08F5D
L08F60:	call	L09FA7	;@08F60
	mov	al, 0Fh	;@08F63
	call	L04110	;@08F65
	mov	al, ch	;@08F68
	call	L04110	;@08F6A
	jmp	L0A26C	;@08F6D
L08F70:	mov	word ptr ds:[55D2h], es	;@08F70
	push	es	;@08F74
	call	L03698	;@08F75
	pop	es	;@08F78
	ret	;@08F79
L08F7A:	mov	byte ptr ds:[55D8h], 0	;@08F7A
	mov	word ptr ds:[55D2h], es	;@08F7F
	call	L03698	;@08F83
	mov	es, word ptr ds:[55D2h]	;@08F86
	push	cx	;@08F8A
	call	L0A736	;@08F8B
	pop	cx	;@08F8E
	ret	;@08F8F
L08F90:	mov	byte ptr ds:[55D8h], 0	;@08F90
	mov	word ptr ds:[55D2h], ax	;@08F95
	mov	word ptr ds:[55D6h], es	;@08F98
	call	L03698	;@08F9C
	mov	es, word ptr ds:[55D2h]	;@08F9F
	push	cx	;@08FA3
	call	L0A736	;@08FA4
	mov	es, word ptr ds:[55D6h]	;@08FA7
	call	L0A736	;@08FAB
	pop	cx	;@08FAE
	ret	;@08FAF
L08FB0:	mov	byte ptr ds:[55D8h], 0	;@08FB0
	mov	word ptr ds:[55D2h], dx	;@08FB5
	mov	word ptr ds:[55D4h], ax	;@08FB9
	mov	word ptr ds:[55D6h], es	;@08FBC
	call	L03698	;@08FC0
	mov	es, word ptr ds:[55D2h]	;@08FC3
	push	cx	;@08FC7
	call	L0A736	;@08FC8
	mov	es, word ptr ds:[55D4h]	;@08FCB
	call	L0A736	;@08FCF
	mov	es, word ptr ds:[55D6h]	;@08FD2
	call	L0A736	;@08FD6
	pop	cx	;@08FD9
	ret	;@08FDA
L08FDB:	push	cx	;@08FDB
	mov	cx, ax	;@08FDC
	call	L03208	;@08FDE
	pop	cx	;@08FE1
	ret	;@08FE2
L08FE3:	push	cx	;@08FE3
	mov	cx, ax	;@08FE4
	call	L0A692	;@08FE6
	pop	cx	;@08FE9
	ret	;@08FEA
L08FEB:	test	byte ptr es:[24h], 80h	;@08FEB
	je	@@1	;@08FF1
	mov	dx, 0FFFFh	;@08FF3
	xor	ax, dx	;@08FF6
	mov	di, ax	;@08FF8
	sub	di, word ptr es:[0Ah]	;@08FFA
	sbb	dx, word ptr es:[0Ch]	;@08FFF
	jmp	short @@2	;@09004
@@1:	mov	di, word ptr es:[0Ah]	;@09006
	sub	di, ax	;@0900B
	mov	dx, word ptr es:[0Ch]	;@0900D
	sbb	dx, 0	;@09012
@@2:	mov	ax, 833h	;@09015
L09018:	push	cx	;@09018
	mov	cx, ax	;@09019
	call	L0A707	;@0901B
	pop	cx	;@0901E
	ret	;@0901F
L09020:	mov	al, byte ptr es:[0]	;@09020
	cmp	al, 80h	;@09024
	je	L09036	;@09026
	cmp	al, 87h	;@09028
	je	L09035	;@0902A
	cmp	al, 88h	;@0902C
	je	L09035	;@0902E
	cmp	al, 89h	;@09030
	je	L09035	;@09032
	stc	;@09034
L09035:	ret	;@09035
L09036:	test	word ptr ds:[5160h], 1000h	;@09036
	jne	L09035	;@0903C
	cmp	word ptr es:[14h], 0	;@0903E
	je	L09035	;@09044
	stc	;@09046
	ret	;@09047
L09048:	mov	al, byte ptr es:[0]	;@09048
	cmp	al, 80h	;@0904C
	je	@@2	;@0904E
	cmp	al, 88h	;@09050
	je	@@1	;@09052
	cmp	al, 89h	;@09054
	je	@@1	;@09056
	stc	;@09058
@@1:	ret	;@09059
@@2:	test	word ptr ds:[5160h], 1000h	;@0905A
	jne	@@1	;@09060
	cmp	word ptr es:[14h], 0	;@09062
	je	@@1	;@09068
	stc	;@0906A
	ret	;@0906B
L0906C:	mov	al, byte ptr es:[0]	;@0906C
	test	al, 80h	;@09070
	je	@@1	;@09072
	ret	;@09074
@@1:	mov	byte ptr es:[0], 0	;@09075
	call	L06D7E	;@0907B
	call	L06E14	;@0907E
	mov	ax, 42h	;@09081
	jmp	L08FDB	;@09084
L09087:	test	byte ptr es:[0], 80h	;@09087
	jne	@@1	;@0908D
	ret	;@0908F
@@1:	push	cx	;@09090
	call	L0663D	;@09091
	pop	cx	;@09094
	mov	ax, 15h	;@09095
	jmp	L08FDB	;@09098
L0909B:	test	byte ptr es:[0], 80h	;@0909B
	jne	@@1	;@090A1
	ret	;@090A3
@@1:	call	L0585A	;@090A4
	test	word ptr ds:[5160h], 1000h	;@090A7
	jne	@@3	;@090AD
@@2:	ret	;@090AF
@@3:	test	word ptr ds:[5166h], 1	;@090B0
	je	@@2	;@090B6
	mov	ax, 8040h	;@090B8
	jmp	L08FDB	;@090BB
L090BE:	call	L0906C	;@090BE
	mov	al, byte ptr es:[0]	;@090C1
	cmp	al, 80h	;@090C5
	je	@@1	;@090C7
	cmp	al, 87h	;@090C9
	je	@@1	;@090CB
	cmp	al, 88h	;@090CD
	je	@@1	;@090CF
	cmp	al, 89h	;@090D1
	jne	@@2	;@090D3
@@1:	ret	;@090D5
@@2:	mov	byte ptr es:[0], 80h	;@090D6
	mov	ax, 16h	;@090DC
	jmp	L08FDB	;@090DF
L090E2:	cmp	byte ptr es:[0], 4	;@090E2
	jae	@@1	;@090E8
	ret	;@090EA
@@1:	mov	byte ptr es:[0], 0	;@090EB
	mov	ax, 16h	;@090F1
	jmp	L08FDB	;@090F4
L090F7:	mov	al, 1	;@090F7
L090F9:	cmp	byte ptr es:[0], 0	;@090F9
	je	@@1	;@090FF
	cmp	byte ptr es:[0], al	;@09101
@@1:	mov	byte ptr es:[0], al	;@09106
	jne	@@2	;@0910A
	ret	;@0910C
@@2:	mov	ax, 16h	;@0910D
	jmp	L08FDB	;@09110
	db	0E8h, 32h, 0Bh, 72h, 9, 26h, 0A0h, 0, 0, 3Ch, 3, 73h, 0CBh, 0C3h	;@09113
	db	26h, 0C6h, 6, 0, 0, 2, 0B8h, 20h, 80h, 0E9h, 0AEh, 0FEh
L0912D:	mov	al, 2	;@0912D
	jmp	L090F9	;@0912F
L09131:	call	L09C48	;@09131
	jb	@@2	;@09134
	mov	al, byte ptr es:[0]	;@09136
	cmp	al, 2	;@0913A
	jb	@@4	;@0913C
	cmp	al, 4	;@0913E
	jae	@@4	;@09140
	cmp	al, 3	;@09142
	je	@@1	;@09144
	ret	;@09146
@@1:	test	word ptr ds:[5160h], 8	;@09147
	je	@@4	;@0914D
	ret	;@0914F
@@2:	test	word ptr ds:[5160h], 8	;@09150
	je	@@3	;@09156
	mov	ax, 8020h	;@09158
	jmp	short L09167	;@0915B
@@3:	mov	byte ptr es:[0], 2	;@0915D
	ret	;@09163
@@4:	mov	ax, 16h	;@09164
L09167:	push	ax	;@09167
	call	L09F3A	;@09168
	mov	byte ptr es:[0], al	;@0916B
	pop	ax	;@0916F
	jmp	L08FDB	;@09170
L09173:	call	L09C48	;@09173
	jb	@@2	;@09176
	mov	al, byte ptr es:[0]	;@09178
	cmp	al, 4	;@0917C
	jae	@@3	;@0917E
	cmp	al, 3	;@09180
	je	@@1	;@09182
	ret	;@09184
@@1:	test	word ptr ds:[5160h], 8	;@09185
	je	@@3	;@0918B
	ret	;@0918D
@@2:	mov	ax, 8020h	;@0918E
	jmp	L09167	;@09191
@@3:	mov	ax, 16h	;@09193
	jmp	L09167	;@09196
L09198:	mov	al, 6	;@09198
	jmp	L090F9	;@0919A
L0919D:	call	L09C48	;@0919D
	jb	@@1	;@091A0
	mov	al, byte ptr es:[0]	;@091A2
	cmp	al, 3	;@091A6
	jb	@@2	;@091A8
	cmp	al, 5	;@091AA
	jae	@@2	;@091AC
	cmp	al, 5	;@091AE
	je	@@2	;@091B0
	ret	;@091B2
@@1:	mov	ax, 8020h	;@091B3
	jmp	short L091BB	;@091B6
@@2:	mov	ax, 16h	;@091B8
L091BB:	mov	byte ptr es:[0], 4	;@091BB
	jmp	L08FDB	;@091C1
L091C4:	call	L09C48	;@091C4
	jb	@@1	;@091C7
	mov	al, byte ptr es:[0]	;@091C9
	cmp	al, 3	;@091CD
	jb	@@2	;@091CF
	cmp	al, 7	;@091D1
	jae	@@2	;@091D3
	cmp	al, 5	;@091D5
	je	@@2	;@091D7
	ret	;@091D9
@@1:	mov	ax, 8020h	;@091DA
	jmp	L091BB	;@091DD
@@2:	mov	ax, 16h	;@091DF
	jmp	L091BB	;@091E2
L091E4:	call	L09C48	;@091E4
	jb	@@1	;@091E7
	mov	al, byte ptr es:[0]	;@091E9
	cmp	al, 2	;@091ED
	jb	@@2	;@091EF
	cmp	al, 5	;@091F1
	jae	@@2	;@091F3
	cmp	al, 5	;@091F5
	je	@@2	;@091F7
	ret	;@091F9
@@1:	mov	ax, 8020h	;@091FA
	jmp	L091BB	;@091FD
@@2:	mov	ax, 16h	;@091FF
	jmp	L091BB	;@09202
L09204:	call	L09C48	;@09204
	jb	@@1	;@09207
	mov	al, byte ptr es:[0]	;@09209
	cmp	al, 2	;@0920D
	jb	@@2	;@0920F
	cmp	al, 4	;@09211
	jae	@@2	;@09213
	ret	;@09215
@@1:	mov	ax, 8020h	;@09216
	jmp	short @@3	;@09219
@@2:	mov	ax, 16h	;@0921B
@@3:	mov	byte ptr es:[0], 3	;@0921E
	jmp	L08FDB	;@09224
L09227:	call	L09C48	;@09227
	jb	@@2	;@0922A
	mov	al, byte ptr es:[0]	;@0922C
	cmp	al, 2	;@09230
	jb	@@4	;@09232
	cmp	al, 6	;@09234
	jae	@@4	;@09236
	cmp	al, 5	;@09238
	je	@@1	;@0923A
	ret	;@0923C
@@1:	test	word ptr ds:[5160h], 8	;@0923D
	je	@@4	;@09243
	ret	;@09245
@@2:	test	word ptr ds:[5160h], 1000h	;@09246
	jne	@@3	;@0924C
	call	L09F3A	;@0924E
	mov	byte ptr es:[0], al	;@09251
	ret	;@09255
@@3:	mov	ax, 8020h	;@09256
	jmp	L09167	;@09259
@@4:	mov	ax, 16h	;@0925C
	jmp	L09167	;@0925F
L09262:	call	L09C48	;@09262
	jb	@@1	;@09265
	mov	al, byte ptr es:[0]	;@09267
	cmp	al, 4	;@0926B
	jb	@@3	;@0926D
	cmp	al, 6	;@0926F
	jae	@@3	;@09271
	ret	;@09273
@@1:	test	word ptr ds:[5160h], 1000h	;@09274
	jne	@@2	;@0927A
	mov	byte ptr es:[0], 5	;@0927C
	ret	;@09282
@@2:	mov	ax, 8020h	;@09283
	jmp	short @@4	;@09286
@@3:	mov	ax, 16h	;@09288
@@4:	mov	byte ptr es:[0], 5	;@0928B
	jmp	L08FDB	;@09291
L09294:	call	L09C7C	;@09294
	jb	@@2	;@09297
	mov	al, byte ptr es:[0]	;@09299
	cmp	al, 4	;@0929D
	jae	@@4	;@0929F
	cmp	al, 3	;@092A1
	je	@@1	;@092A3
	ret	;@092A5
@@1:	test	word ptr ds:[5160h], 8	;@092A6
	je	@@4	;@092AC
	ret	;@092AE
@@2:	call	L09E84	;@092AF
	mov	byte ptr es:[0], 2	;@092B2
	jae	@@3	;@092B8
	mov	byte ptr es:[0], 3	;@092BA
@@3:	ret	;@092C0
@@4:	mov	ax, 16h	;@092C1
	jmp	L09167	;@092C4
L092C7:	call	L09C48	;@092C7
	jb	@@2	;@092CA
	mov	al, byte ptr es:[0]	;@092CC
	cmp	al, 2	;@092D0
	jb	@@4	;@092D2
	cmp	al, 5	;@092D4
	je	@@1	;@092D6
	cmp	al, 4	;@092D8
	jae	@@4	;@092DA
	ret	;@092DC
@@1:	test	word ptr ds:[5160h], 8	;@092DD
	je	@@4	;@092E3
	ret	;@092E5
@@2:	test	word ptr ds:[5160h], 8	;@092E6
	je	@@3	;@092EC
	mov	ax, 8020h	;@092EE
	jmp	L09167	;@092F1
@@3:	mov	byte ptr es:[0], 2	;@092F4
	ret	;@092FA
@@4:	mov	ax, 16h	;@092FB
	jmp	L09167	;@092FE
L09301:	call	L09C48	;@09301
	jb	@@1	;@09304
	mov	al, byte ptr es:[0]	;@09306
	cmp	al, 2	;@0930A
	jb	@@2	;@0930C
	cmp	al, 4	;@0930E
	jae	@@2	;@09310
	test	word ptr ds:[5160h], 8	;@09312
	jne	@@1	;@09318
	cmp	al, 3	;@0931A
	je	@@2	;@0931C
@@1:	ret	;@0931E
@@2:	mov	ax, 16h	;@0931F
	jmp	L09167	;@09322
L09325:	mov	es, word ptr ds:[55D2h]	;@09325
	call	L09C48	;@09329
	jb	@@2	;@0932C
	mov	al, byte ptr es:[0]	;@0932E
	cmp	al, 4	;@09332
	jae	@@4	;@09334
	mov	es, word ptr ds:[55D6h]	;@09336
@@1:	mov	byte ptr es:[0], al	;@0933A
	cmp	al, 3	;@0933E
	je	@@3	;@09340
	ret	;@09342
@@2:	mov	es, word ptr ds:[55D6h]	;@09343
	call	L09C7C	;@09347
	jb	@@5	;@0934A
	mov	al, byte ptr es:[0]	;@0934C
	cmp	al, 4	;@09350
	jae	@@4	;@09352
	mov	es, word ptr ds:[55D2h]	;@09354
	jmp	@@1	;@09358
@@3:	test	word ptr ds:[5160h], 8	;@0935A
	je	@@4	;@09360
	ret	;@09362
	db	0B8h, 41h, 0, 0EBh, 63h	;@09363
@@4:	mov	ax, 16h	;@09368
	jmp	short L093CB	;@0936B
@@5:	mov	ax, 8020h	;@0936D
	jmp	short L093CB	;@09370
L09372:	mov	es, word ptr ds:[55D2h]	;@09372
	call	L09C48	;@09376
	jb	@@2	;@09379
	mov	al, byte ptr es:[0]	;@0937B
	cmp	al, 4	;@0937F
	jae	@@5	;@09381
	mov	es, word ptr ds:[55D6h]	;@09383
	push	ax	;@09387
	call	L09C48	;@09388
	pop	ax	;@0938B
	jb	@@1	;@0938C
	cmp	al, byte ptr es:[0]	;@0938E
	jne	@@4	;@09393
@@1:	mov	byte ptr es:[0], al	;@09395
	cmp	al, 3	;@09399
	je	@@3	;@0939B
	ret	;@0939D
@@2:	mov	es, word ptr ds:[55D6h]	;@0939E
	call	L09C48	;@093A2
	jb	@@6	;@093A5
	mov	al, byte ptr es:[0]	;@093A7
	cmp	al, 4	;@093AB
	jae	@@5	;@093AD
	mov	es, word ptr ds:[55D2h]	;@093AF
	jmp	@@1	;@093B3
@@3:	test	word ptr ds:[5160h], 8	;@093B5
	je	@@5	;@093BB
	ret	;@093BD
@@4:	mov	ax, 41h	;@093BE
	jmp	short L093CB	;@093C1
@@5:	mov	ax, 16h	;@093C3
	jmp	short L093CB	;@093C6
@@6:	mov	ax, 8020h	;@093C8
L093CB:	push	ax	;@093CB
	call	L09F3A	;@093CC
	mov	es, word ptr ds:[55D2h]	;@093CF
	mov	byte ptr es:[0], al	;@093D3
	mov	es, word ptr ds:[55D6h]	;@093D7
	mov	byte ptr es:[0], al	;@093DB
	pop	ax	;@093DF
	jmp	L08FDB	;@093E0
L093E3:	mov	es, word ptr ds:[55D2h]	;@093E3
	call	L09C48	;@093E7
	jb	@@2	;@093EA
	mov	al, byte ptr es:[0]	;@093EC
	cmp	al, 2	;@093F0
	jb	@@4	;@093F2
	cmp	al, 4	;@093F4
	jae	@@4	;@093F6
	mov	es, word ptr ds:[55D6h]	;@093F8
@@1:	mov	byte ptr es:[0], al	;@093FC
	cmp	al, 3	;@09400
	je	@@3	;@09402
	ret	;@09404
@@2:	mov	es, word ptr ds:[55D6h]	;@09405
	call	L09C7C	;@09409
	jb	@@5	;@0940C
	mov	al, byte ptr es:[0]	;@0940E
	cmp	al, 2	;@09412
	jb	@@4	;@09414
	cmp	al, 4	;@09416
	jae	@@4	;@09418
	mov	es, word ptr ds:[55D2h]	;@0941A
	jmp	@@1	;@0941E
@@3:	test	word ptr ds:[5160h], 8	;@09420
	je	@@4	;@09426
	ret	;@09428
	db	0B8h, 20h, 0, 0EBh, 9Dh	;@09429
@@4:	mov	ax, 16h	;@0942E
	jmp	L093CB	;@09431
@@5:	test	word ptr ds:[5160h], 8	;@09433
	je	@@6	;@09439
	mov	ax, 8020h	;@0943B
	jmp	L093CB	;@0943E
@@6:	mov	es, word ptr ds:[55D2h]	;@09440
	mov	byte ptr es:[0], 2	;@09444
	mov	es, word ptr ds:[55D6h]	;@0944A
	mov	byte ptr es:[0], 2	;@0944E
	ret	;@09454
L09455:	mov	es, word ptr ds:[55D2h]	;@09455
	call	L09C48	;@09459
	jb	@@2	;@0945C
	mov	al, byte ptr es:[0]	;@0945E
	cmp	al, 2	;@09462
	jb	@@5	;@09464
	cmp	al, 4	;@09466
	jae	@@5	;@09468
	inc	al	;@0946A
	mov	es, word ptr ds:[55D6h]	;@0946C
	push	ax	;@09470
	call	L09C48	;@09471
	pop	ax	;@09474
	jb	@@1	;@09475
	cmp	al, byte ptr es:[0]	;@09477
	jne	@@4	;@0947C
@@1:	mov	byte ptr es:[0], al	;@0947E
	cmp	al, 4	;@09482
	je	@@3	;@09484
	ret	;@09486
@@2:	mov	es, word ptr ds:[55D6h]	;@09487
	call	L09C48	;@0948B
	jb	L094BE	;@0948E
	mov	al, byte ptr es:[0]	;@09490
	cmp	al, 3	;@09494
	jb	@@5	;@09496
	cmp	al, 5	;@09498
	jae	@@5	;@0949A
	dec	al	;@0949C
	mov	es, word ptr ds:[55D2h]	;@0949E
	mov	byte ptr es:[0], al	;@094A2
	cmp	al, 3	;@094A6
	je	@@3	;@094A8
	ret	;@094AA
@@3:	test	word ptr ds:[5160h], 8	;@094AB
	je	@@5	;@094B1
	ret	;@094B3
@@4:	mov	ax, 20h	;@094B4
	jmp	short L094E0	;@094B7
@@5:	mov	ax, 16h	;@094B9
	jmp	short L094E0	;@094BC
L094BE:	test	word ptr ds:[5160h], 8	;@094BE
	je	@@1	;@094C4
	mov	ax, 8020h	;@094C6
	jmp	short L094E0	;@094C9
@@1:	mov	es, word ptr ds:[55D2h]	;@094CB
	mov	byte ptr es:[0], 2	;@094CF
	mov	es, word ptr ds:[55D6h]	;@094D5
	mov	byte ptr es:[0], 3	;@094D9
	ret	;@094DF
L094E0:	push	ax	;@094E0
	call	L09F3A	;@094E1
	mov	es, word ptr ds:[55D2h]	;@094E4
	mov	byte ptr es:[0], al	;@094E8
	inc	al	;@094EC
	mov	es, word ptr ds:[55D6h]	;@094EE
	mov	byte ptr es:[0], al	;@094F2
	pop	ax	;@094F6
	jmp	L08FDB	;@094F7
L094FA:	mov	es, word ptr ds:[55D2h]	;@094FA
	call	L09C48	;@094FE
	jb	@@2	;@09501
	mov	al, byte ptr es:[0]	;@09503
	cmp	al, 2	;@09507
	jb	@@5	;@09509
	cmp	al, 4	;@0950B
	jae	@@5	;@0950D
	mov	es, word ptr ds:[55D6h]	;@0950F
	push	ax	;@09513
	call	L09C48	;@09514
	pop	ax	;@09517
	jb	@@1	;@09518
	cmp	al, byte ptr es:[0]	;@0951A
	jne	@@4	;@0951F
@@1:	mov	byte ptr es:[0], al	;@09521
	cmp	al, 3	;@09525
	je	@@3	;@09527
	ret	;@09529
@@2:	mov	es, word ptr ds:[55D6h]	;@0952A
	call	L09C48	;@0952E
	jb	@@6	;@09531
	mov	al, byte ptr es:[0]	;@09533
	cmp	al, 2	;@09537
	jb	@@5	;@09539
	cmp	al, 4	;@0953B
	jae	@@5	;@0953D
	mov	es, word ptr ds:[55D2h]	;@0953F
	jmp	@@1	;@09543
@@3:	test	word ptr ds:[5160h], 8	;@09545
	je	@@5	;@0954B
	ret	;@0954D
@@4:	mov	ax, 20h	;@0954E
	jmp	L093CB	;@09551
@@5:	mov	ax, 16h	;@09554
	jmp	L093CB	;@09557
@@6:	test	word ptr ds:[5160h], 8	;@0955A
	je	@@7	;@09560
	mov	ax, 8020h	;@09562
	jmp	L093CB	;@09565
@@7:	mov	es, word ptr ds:[55D2h]	;@09568
	mov	byte ptr es:[0], 2	;@0956C
	mov	es, word ptr ds:[55D6h]	;@09572
	mov	byte ptr es:[0], 2	;@09576
	ret	;@0957C
L0957D:	mov	es, word ptr ds:[55D2h]	;@0957D
	call	L09C48	;@09581
	jb	@@3	;@09584
	mov	al, byte ptr es:[0]	;@09586
	cmp	al, 2	;@0958A
	jb	@@7	;@0958C
	cmp	al, 4	;@0958E
	jae	@@7	;@09590
	inc	al	;@09592
	cmp	al, 4	;@09594
	jne	@@1	;@09596
	inc	al	;@09598
@@1:	mov	es, word ptr ds:[55D6h]	;@0959A
	push	ax	;@0959E
	call	L09C48	;@0959F
	pop	ax	;@095A2
	jb	@@2	;@095A3
	cmp	al, byte ptr es:[0]	;@095A5
	jne	@@5	;@095AA
@@2:	mov	byte ptr es:[0], al	;@095AC
	cmp	al, 5	;@095B0
	je	@@8	;@095B2
	ret	;@095B4
@@3:	mov	es, word ptr ds:[55D6h]	;@095B5
	call	L09C48	;@095B9
	jb	@@6	;@095BC
	mov	al, byte ptr es:[0]	;@095BE
	cmp	al, 3	;@095C2
	jb	@@7	;@095C4
	cmp	al, 6	;@095C6
	jae	@@7	;@095C8
	cmp	al, 4	;@095CA
	je	@@7	;@095CC
	jb	@@4	;@095CE
	dec	al	;@095D0
@@4:	dec	al	;@095D2
	mov	es, word ptr ds:[55D2h]	;@095D4
	mov	byte ptr es:[0], al	;@095D8
	cmp	al, 3	;@095DC
	je	@@8	;@095DE
	ret	;@095E0
@@5:	mov	ax, 41h	;@095E1
	jmp	short @@10	;@095E4
@@6:	test	word ptr ds:[5160h], 8	;@095E6
	je	@@9	;@095EC
	mov	ax, 8020h	;@095EE
	jmp	short @@10	;@095F1
@@7:	mov	ax, 16h	;@095F3
	jmp	short @@10	;@095F6
@@8:	test	word ptr ds:[5160h], 8	;@095F8
	je	@@7	;@095FE
	ret	;@09600
@@9:	mov	es, word ptr ds:[55D2h]	;@09601
	mov	byte ptr es:[0], 2	;@09605
	mov	es, word ptr ds:[55D6h]	;@0960B
	mov	byte ptr es:[0], 3	;@0960F
	ret	;@09615
@@10:	push	ax	;@09616
	call	L09F3A	;@09617
	mov	es, word ptr ds:[55D2h]	;@0961A
	mov	byte ptr es:[0], al	;@0961E
	inc	al	;@09622
	cmp	al, 4	;@09624
	jne	@@11	;@09626
	inc	al	;@09628
@@11:	mov	es, word ptr ds:[55D6h]	;@0962A
	mov	byte ptr es:[0], al	;@0962E
	pop	ax	;@09632
	jmp	L08FDB	;@09633
L09636:	mov	es, word ptr ds:[55D2h]	;@09636
	mov	al, byte ptr es:[0]	;@0963A
	cmp	al, 0	;@0963E
	je	@@1	;@09640
	cmp	al, 4	;@09642
	jae	@@3	;@09644
	mov	es, word ptr ds:[55D6h]	;@09646
	cmp	byte ptr es:[0], 0	;@0964A
	je	@@2	;@09650
	cmp	al, byte ptr es:[0]	;@09652
	jne	@@4	;@09657
	ret	;@09659
@@1:	mov	es, word ptr ds:[55D6h]	;@0965A
	mov	al, byte ptr es:[0]	;@0965E
	cmp	al, 4	;@09662
	jae	@@3	;@09664
	mov	es, word ptr ds:[55D2h]	;@09666
@@2:	mov	byte ptr es:[0], al	;@0966A
	ret	;@0966E
@@3:	mov	ax, 16h	;@0966F
	jmp	short L09677	;@09672
@@4:	mov	ax, 41h	;@09674
L09677:	mov	es, word ptr ds:[55D2h]	;@09677
	mov	byte ptr es:[0], 0	;@0967B
	mov	es, word ptr ds:[55D6h]	;@09681
	mov	byte ptr es:[0], 0	;@09685
	jmp	L08FDB	;@0968B
L0968E:	mov	es, word ptr ds:[55D2h]	;@0968E
	call	L09C48	;@09692
	jb	@@2	;@09695
	mov	al, byte ptr es:[0]	;@09697
	cmp	al, 2	;@0969B
	jb	@@4	;@0969D
	cmp	al, 4	;@0969F
	jae	@@4	;@096A1
	mov	es, word ptr ds:[55D6h]	;@096A3
	push	ax	;@096A7
	call	L09C48	;@096A8
	pop	ax	;@096AB
	jb	@@3	;@096AC
	mov	ah, byte ptr es:[0]	;@096AE
	cmp	ah, 1	;@096B3
	je	@@1	;@096B6
	cmp	ah, 2	;@096B8
	jne	@@4	;@096BB
	cmp	al, 3	;@096BD
	jne	@@5	;@096BF
@@1:	ret	;@096C1
@@2:	mov	es, word ptr ds:[55D6h]	;@096C2
	call	L09C48	;@096C6
	jb	@@6	;@096C9
	mov	al, byte ptr es:[0]	;@096CB
	cmp	al, 3	;@096CF
	jae	@@4	;@096D1
	cmp	al, 1	;@096D3
	je	@@6	;@096D5
	mov	es, word ptr ds:[55D2h]	;@096D7
	mov	byte ptr es:[0], 3	;@096DB
	ret	;@096E1
@@3:	cmp	al, 3	;@096E2
	je	@@7	;@096E4
	mov	byte ptr es:[0], 1	;@096E6
	ret	;@096EC
@@4:	mov	ax, 16h	;@096ED
	jmp	L09677	;@096F0
@@5:	mov	ax, 41h	;@096F2
	jmp	L09677	;@096F5
@@6:	call	L09F3A	;@096F7
	mov	es, word ptr ds:[55D2h]	;@096FA
	mov	byte ptr es:[0], al	;@096FE
	mov	es, word ptr ds:[55D6h]	;@09702
@@7:	mov	byte ptr es:[0], 1	;@09706
	mov	ax, 8020h	;@0970C
	jmp	L08FDB	;@0970F
L09712:	mov	es, word ptr ds:[55D2h]	;@09712
	call	L09C48	;@09716
	jb	@@6	;@09719
	mov	al, byte ptr es:[0]	;@0971B
	cmp	al, 2	;@0971F
	jb	@@3	;@09721
	cmp	al, 4	;@09723
	jae	@@3	;@09725
	mov	es, word ptr ds:[55D4h]	;@09727
	push	ax	;@0972B
	call	L09C48	;@0972C
	pop	ax	;@0972F
	jae	@@1	;@09730
	mov	byte ptr es:[0], al	;@09732
@@1:	cmp	al, byte ptr es:[0]	;@09736
	jne	@@4	;@0973B
@@2:	mov	es, word ptr ds:[55D6h]	;@0973D
	mov	byte ptr es:[0], al	;@09741
	cmp	al, 3	;@09745
	je	@@8	;@09747
	ret	;@09749
@@3:	mov	ax, 16h	;@0974A
	jmp	short @@10	;@0974D
@@4:	mov	ax, 41h	;@0974F
	jmp	short @@10	;@09752
@@5:	test	word ptr ds:[5160h], 8	;@09754
	je	@@9	;@0975A
	mov	ax, 8020h	;@0975C
	jmp	short @@10	;@0975F
@@6:	mov	es, word ptr ds:[55D4h]	;@09761
	call	L09C48	;@09765
	jb	@@7	;@09768
	mov	al, byte ptr es:[0]	;@0976A
	cmp	al, 2	;@0976E
	jb	@@3	;@09770
	cmp	al, 4	;@09772
	jae	@@3	;@09774
	mov	es, word ptr ds:[55D2h]	;@09776
	mov	byte ptr es:[0], al	;@0977A
	jmp	@@2	;@0977E
@@7:	mov	es, word ptr ds:[55D6h]	;@09780
	call	L09C48	;@09784
	jb	@@5	;@09787
	mov	al, byte ptr es:[0]	;@09789
	cmp	al, 2	;@0978D
	jb	@@3	;@0978F
	cmp	al, 4	;@09791
	jae	@@3	;@09793
	mov	es, word ptr ds:[55D4h]	;@09795
	mov	byte ptr es:[0], al	;@09799
	mov	es, word ptr ds:[55D2h]	;@0979D
	mov	byte ptr es:[0], al	;@097A1
@@8:	test	word ptr ds:[5160h], 8	;@097A5
	je	@@3	;@097AB
	ret	;@097AD
@@9:	call	L09F3A	;@097AE
	mov	es, word ptr ds:[55D2h]	;@097B1
	mov	byte ptr es:[0], al	;@097B5
	mov	es, word ptr ds:[55D4h]	;@097B9
	mov	byte ptr es:[0], al	;@097BD
	mov	es, word ptr ds:[55D6h]	;@097C1
	mov	byte ptr es:[0], al	;@097C5
	ret	;@097C9
@@10:	push	ax	;@097CA
	call	L09F3A	;@097CB
	mov	es, word ptr ds:[55D2h]	;@097CE
	mov	byte ptr es:[0], al	;@097D2
	mov	es, word ptr ds:[55D4h]	;@097D6
	mov	byte ptr es:[0], al	;@097DA
	mov	es, word ptr ds:[55D6h]	;@097DE
	mov	byte ptr es:[0], al	;@097E2
	pop	ax	;@097E6
	jmp	L08FDB	;@097E7
L097EA:	test	byte ptr es:[4], 80h	;@097EA
	je	@@1	;@097F0
	ret	;@097F2
@@1:	or	byte ptr es:[4], 80h	;@097F3
	mov	ax, 18h	;@097F9
	jmp	L08FDB	;@097FC
L097FF:	mov	al, byte ptr es:[4]	;@097FF
	and	al, 0C0h	;@09803
	xor	al, 40h	;@09805
	jne	L097EA	;@09807
L09809:	mov	al, byte ptr es:[4]	;@09809
	xor	al, 40h	;@0980D
	jne	@@1	;@0980F
	mov	ax, word ptr es:[0Ah]	;@09811
	or	ax, word ptr es:[0Ch]	;@09815
	jne	@@6	;@0981A
	ret	;@0981C
@@1:	test	byte ptr es:[4], 80h	;@0981D
	je	@@2	;@09823
	mov	ax, 1Eh	;@09825
	call	L08FDB	;@09828
	and	byte ptr es:[4], 7Fh	;@0982B
@@2:	test	byte ptr es:[4], 20h	;@09831
	je	@@3	;@09837
	mov	ax, 1Dh	;@09839
	call	L08FDB	;@0983C
	mov	word ptr es:[10h], 1	;@0983F
	and	byte ptr es:[4], 0DFh	;@09846
@@3:	test	byte ptr es:[4], 40h	;@0984C
	jne	@@4	;@09852
	mov	ax, 3Dh	;@09854
	call	L08FDB	;@09857
@@4:	test	byte ptr es:[4], 10h	;@0985A
	je	@@5	;@09860
	mov	ax, 1Ch	;@09862
	call	L08FDB	;@09865
	mov	word ptr es:[12h], 0	;@09868
	and	byte ptr es:[4], 0EFh	;@0986F
@@5:	test	byte ptr es:[4], 5	;@09875
	jne	@@6	;@0987B
	mov	ax, word ptr es:[0Ah]	;@0987D
	or	ax, word ptr es:[0Ch]	;@09881
	je	@@7	;@09886
@@6:	mov	ax, 23h	;@09888
	call	L08FDB	;@0988B
	and	byte ptr es:[4], 0F8h	;@0988E
	xor	ax, ax	;@09894
	mov	word ptr es:[8], ax	;@09896
	mov	word ptr es:[0Ah], ax	;@0989A
	mov	word ptr es:[0Ch], ax	;@0989E
	mov	byte ptr es:[24h], al	;@098A2
	mov	byte ptr es:[1], al	;@098A6
	mov	word ptr es:[1Ah], ax	;@098AA
	mov	word ptr es:[18h], ax	;@098AE
@@7:	ret	;@098B2
L098B3:	test	byte ptr es:[4], 0F8h	;@098B3
	jne	L098BC	;@098B9
	ret	;@098BB
L098BC:	test	byte ptr es:[4], 80h	;@098BC
	je	@@1	;@098C2
	and	byte ptr es:[4], 7Fh	;@098C4
	mov	ax, 1Eh	;@098CA
	call	L08FDB	;@098CD
@@1:	test	byte ptr es:[4], 40h	;@098D0
	je	@@2	;@098D6
	mov	ax, 19h	;@098D8
	call	L08FDB	;@098DB
	and	byte ptr es:[4], 8Fh	;@098DE
	xor	ax, ax	;@098E4
	mov	word ptr es:[0Eh], ax	;@098E6
	mov	word ptr es:[12h], ax	;@098EA
	mov	word ptr es:[10h], 1	;@098EE
@@2:	ret	;@098F5
L098F6:	test	byte ptr es:[4], 0F8h	;@098F6
	jne	@@2	;@098FC
@@1:	mov	al, byte ptr es:[24h]	;@098FE
	cbw	;@09902
	cmp	ax, word ptr es:[0Ch]	;@09903
	jne	@@3	;@09908
	ret	;@0990A
@@2:	call	L098BC	;@0990B
	jmp	@@1	;@0990E
@@3:	mov	ax, 3Fh	;@09910
	jmp	L09018	;@09913
L09916:	test	byte ptr es:[4], 0F8h	;@09916
	jne	@@4	;@0991C
@@1:	mov	al, byte ptr es:[1]	;@0991E
	and	al, 7	;@09922
	je	@@3	;@09924
	cmp	al, 2	;@09926
	je	@@2	;@09928
	cmp	al, 3	;@0992A
	jne	@@3	;@0992C
	sub	byte ptr es:[1], 2	;@0992E
	jmp	short @@3	;@09934
@@2:	and	byte ptr es:[4], 0FBh	;@09936
	xor	ax, ax	;@0993C
	mov	byte ptr es:[1], al	;@0993E
	mov	word ptr es:[1Ah], ax	;@09942
	mov	word ptr es:[18h], ax	;@09946
@@3:	mov	al, byte ptr es:[24h]	;@0994A
	cbw	;@0994E
	cmp	ax, word ptr es:[0Ch]	;@0994F
	jne	@@5	;@09954
	ret	;@09956
@@4:	call	L098BC	;@09957
	jmp	@@1	;@0995A
@@5:	mov	ax, 3Fh	;@0995C
	jmp	L09018	;@0995F
L09962:	test	byte ptr es:[4], 0F8h	;@09962
	jne	@@4	;@09968
@@1:	mov	al, byte ptr es:[1]	;@0996A
	and	al, 7	;@0996E
	je	@@2	;@09970
	cmp	al, 2	;@09972
	je	@@3	;@09974
	cmp	al, 3	;@09976
	jne	@@2	;@09978
	sub	byte ptr es:[1], 2	;@0997A
@@2:	ret	;@09980
@@3:	and	byte ptr es:[4], 0FBh	;@09981
	xor	ax, ax	;@09987
	mov	byte ptr es:[1], al	;@09989
	mov	word ptr es:[1Ah], ax	;@0998D
	mov	word ptr es:[18h], ax	;@09991
	ret	;@09995
@@4:	call	L098BC	;@09996
	jmp	@@1	;@09999
L0999B:	test	byte ptr es:[4], 0F8h	;@0999B
	jne	@@2	;@099A1
@@1:	test	byte ptr es:[4], 4	;@099A3
	jne	@@3	;@099A9
	ret	;@099AB
@@2:	call	L098BC	;@099AC
	jmp	@@1	;@099AF
@@3:	mov	ax, 6Eh	;@099B1
	call	L08FDB	;@099B4
	jmp	short L099E5	;@099B7
L099B9:	mov	al, byte ptr es:[0]	;@099B9
	cmp	al, 2	;@099BD
	je	L099FF	;@099BF
	cmp	al, 1	;@099C1
	je	L09A17	;@099C3
L099C5:	test	byte ptr es:[4], 0F8h	;@099C5
	jne	L099FA	;@099CB
L099CD:	mov	al, byte ptr es:[1]	;@099CD
	and	al, 7	;@099D1
	je	L099F9	;@099D3
	cmp	al, 2	;@099D5
	je	L099E5	;@099D7
	cmp	al, 3	;@099D9
	jne	L099F9	;@099DB
	sub	byte ptr es:[1], 2	;@099DD
	jmp	short L099F9	;@099E3
L099E5:	and	byte ptr es:[4], 0FBh	;@099E5
	xor	ax, ax	;@099EB
	mov	byte ptr es:[1], al	;@099ED
	mov	word ptr es:[1Ah], ax	;@099F1
	mov	word ptr es:[18h], ax	;@099F5
L099F9:	ret	;@099F9
L099FA:	call	L098BC	;@099FA
	jmp	L099CD	;@099FD
L099FF:	call	L099C5	;@099FF
	cmp	word ptr es:[6], 0	;@09A02
	jne	@@1	;@09A08
	mov	al, byte ptr es:[24h]	;@09A0A
	cbw	;@09A0E
	cmp	ax, word ptr es:[0Ch]	;@09A0F
	jne	L09A53	;@09A14
@@1:	ret	;@09A16
L09A17:	call	L099C5	;@09A17
	mov	al, byte ptr es:[1]	;@09A1A
	and	al, 7	;@09A1E
	je	@@2	;@09A20
	cmp	al, 4	;@09A22
	je	@@1	;@09A24
	cmp	al, 1	;@09A26
	jne	@@2	;@09A28
	sub	byte ptr es:[1], 0FCh	;@09A2A
	jmp	short @@2	;@09A30
@@1:	mov	ax, 71h	;@09A32
	call	L08FE3	;@09A35
@@2:	cmp	word ptr es:[6], 0	;@09A38
	jne	L09A59	;@09A3E
	mov	al, byte ptr es:[24h]	;@09A40
	cbw	;@09A44
	cmp	ax, word ptr es:[0Ch]	;@09A45
	jne	L09A53	;@09A4A
	cmp	al, byte ptr es:[0Bh]	;@09A4C
	je	L09A59	;@09A51
L09A53:	mov	ax, 3Fh	;@09A53
	jmp	L09018	;@09A56
L09A59:	ret	;@09A59
L09A5A:	call	L099C5	;@09A5A
	test	byte ptr es:[4], 4	;@09A5D
	je	@@1	;@09A63
	mov	ax, 6Eh	;@09A65
	call	L08FE3	;@09A68
@@1:	cmp	word ptr es:[6], 0	;@09A6B
	jne	@@3	;@09A71
	mov	al, byte ptr es:[24h]	;@09A73
	cbw	;@09A77
	cmp	ax, word ptr es:[0Ch]	;@09A78
	jne	@@2	;@09A7D
	cmp	al, byte ptr es:[0Bh]	;@09A7F
	jne	@@2	;@09A84
	xor	al, byte ptr es:[0Ah]	;@09A86
	and	al, 0C0h	;@09A8B
	je	@@3	;@09A8D
@@2:	mov	ax, 3Fh	;@09A8F
	jmp	L09018	;@09A92
@@3:	ret	;@09A95
L09A96:	call	L099C5	;@09A96
	test	byte ptr es:[4], 4	;@09A99
	je	@@1	;@09A9F
	mov	ax, 6Eh	;@09AA1
	call	L08FE3	;@09AA4
@@1:	cmp	word ptr es:[6], 0	;@09AA7
	jne	@@3	;@09AAD
	mov	al, byte ptr es:[24h]	;@09AAF
	cbw	;@09AB3
	cmp	ax, word ptr es:[0Ch]	;@09AB4
	jne	@@2	;@09AB9
	cmp	al, byte ptr es:[0Bh]	;@09ABB
	jne	@@2	;@09AC0
	xor	al, byte ptr es:[0Ah]	;@09AC2
	and	al, 0F8h	;@09AC7
	je	@@3	;@09AC9
@@2:	mov	ax, 3Fh	;@09ACB
	jmp	L09018	;@09ACE
@@3:	ret	;@09AD1
L09AD2:	call	L098B3	;@09AD2
	mov	al, byte ptr es:[1]	;@09AD5
	and	al, 7	;@09AD9
	je	@@1	;@09ADB
	mov	byte ptr es:[1], 0Dh	;@09ADD
	call	L09BF8	;@09AE3
	call	L0A5E6	;@09AE6
	test	byte ptr es:[1], 8	;@09AE9
	jne	@@4	;@09AEF
@@1:	cmp	word ptr es:[6], 0	;@09AF1
	jne	@@2	;@09AF7
	mov	al, byte ptr es:[0Ah]	;@09AF9
	cbw	;@09AFD
	cwd	;@09AFE
	cmp	ah, byte ptr es:[0Bh]	;@09AFF
	jne	@@3	;@09B04
	cmp	dx, word ptr es:[0Ch]	;@09B06
	jne	@@3	;@09B0B
	xor	ah, byte ptr es:[24h]	;@09B0D
	jne	@@3	;@09B12
@@2:	ret	;@09B14
@@3:	mov	ax, 7Fh	;@09B15
	jmp	L08FEB	;@09B18
@@4:	call	L09CED	;@09B1B
	xor	ax, ax	;@09B1E
	add	word ptr es:[0Ah], 2	;@09B20
	adc	word ptr es:[0Ch], ax	;@09B26
	adc	byte ptr es:[24h], al	;@09B2B
	cmp	word ptr es:[6], ax	;@09B30
	jne	@@2	;@09B35
	cmp	byte ptr es:[0Bh], al	;@09B37
	jne	@@5	;@09B3C
	cmp	word ptr es:[0Ch], ax	;@09B3E
	jne	@@5	;@09B43
	cmp	byte ptr es:[24h], al	;@09B45
	jne	@@5	;@09B4A
	ret	;@09B4C
@@5:	mov	ax, 33h	;@09B4D
	jmp	L08FDB	;@09B50
L09B53:	call	L098B3	;@09B53
	mov	al, byte ptr es:[1]	;@09B56
	and	al, 7	;@09B5A
	je	@@1	;@09B5C
	and	byte ptr es:[1], 0F8h	;@09B5E
	or	byte ptr es:[1], 9	;@09B64
	call	L09BF8	;@09B6A
	call	L0A5E6	;@09B6D
	test	byte ptr es:[1], 8	;@09B70
	jne	@@4	;@09B76
@@1:	cmp	word ptr es:[6], 0	;@09B78
	jne	@@2	;@09B7E
	mov	al, byte ptr es:[24h]	;@09B80
	cbw	;@09B84
	cmp	ax, word ptr es:[0Ch]	;@09B85
	jne	@@3	;@09B8A
@@2:	ret	;@09B8C
@@3:	mov	ax, 7FFFh	;@09B8D
	jmp	L08FEB	;@09B90
@@4:	call	L09CED	;@09B93
	xor	ax, ax	;@09B96
	add	word ptr es:[0Ah], 3	;@09B98
	adc	word ptr es:[0Ch], ax	;@09B9E
	adc	byte ptr es:[24h], al	;@09BA3
	cmp	word ptr es:[0Ch], ax	;@09BA8
	jne	@@5	;@09BAD
	cmp	byte ptr es:[24h], al	;@09BAF
	jne	@@5	;@09BB4
	ret	;@09BB6
@@5:	mov	ax, 33h	;@09BB7
	jmp	L08FDB	;@09BBA
L09BBD:	call	L098B3	;@09BBD
	mov	al, byte ptr es:[1]	;@09BC0
	and	al, 7	;@09BC4
	je	@@1	;@09BC6
	and	byte ptr es:[1], 0F8h	;@09BC8
	or	byte ptr es:[1], 9	;@09BCE
	call	L09BF8	;@09BD4
	call	L0A5E6	;@09BD7
	test	byte ptr es:[1], 8	;@09BDA
	je	@@1	;@09BE0
	call	L09CED	;@09BE2
	add	word ptr es:[0Ah], 5	;@09BE5
	adc	word ptr es:[0Ch], 0	;@09BEB
	adc	byte ptr es:[24h], 0	;@09BF1
@@1:	ret	;@09BF7
L09BF8:	push	cx	;@09BF8
	push	es	;@09BF9
	mov	es, word ptr ds:[5638h]	;@09BFA
	call	L018F9	;@09BFE
	mov	es, ax	;@09C01
	mov	bx, word ptr es:[6]	;@09C03
	and	bx, bx	;@09C08
	je	@@1	;@09C0A
	pop	es	;@09C0C
	mov	word ptr es:[6], bx	;@09C0D
	call	L06EE3	;@09C12
	pop	cx	;@09C15
	jmp	short @@3	;@09C16
@@1:	test	byte ptr es:[4], 4	;@09C18
	je	@@2	;@09C1E
	mov	ax, word ptr es:[1Ah]	;@09C20
	pop	es	;@09C24
	pop	cx	;@09C25
	mov	word ptr es:[18h], ax	;@09C26
	ret	;@09C2A
@@2:	pop	es	;@09C2B
	mov	cx, 54h	;@09C2C
	call	L03208	;@09C2F
	pop	cx	;@09C32
@@3:	and	byte ptr es:[4], 0FBh	;@09C33
	xor	ax, ax	;@09C39
	mov	word ptr es:[18h], ax	;@09C3B
	mov	word ptr es:[1Ah], ax	;@09C3F
	mov	byte ptr es:[1], al	;@09C43
	ret	;@09C47
L09C48:	cmp	byte ptr es:[0], 0	;@09C48
	jne	@@2	;@09C4E
	test	word ptr ds:[5160h], 1000h	;@09C50
	jne	@@1	;@09C56
	test	byte ptr es:[5], 40h	;@09C58
	je	@@1	;@09C5E
	and	byte ptr es:[5], 0BFh	;@09C60
	mov	al, byte ptr es:[25h]	;@09C66
	and	al, 7Fh	;@09C6A
	mov	byte ptr es:[0], al	;@09C6C
	mov	ax, word ptr es:[1Ch]	;@09C70
	mov	word ptr es:[2], ax	;@09C74
	jne	@@2	;@09C78
@@1:	stc	;@09C7A
@@2:	ret	;@09C7B
L09C7C:	call	L09C48	;@09C7C
	jae	@@2	;@09C7F
	test	word ptr ds:[5160h], 1000h	;@09C81
	jne	@@3	;@09C87
	test	byte ptr es:[4], 40h	;@09C89
	jne	@@3	;@09C8F
	cmp	word ptr es:[6], 0	;@09C91
	jne	@@3	;@09C97
	mov	al, byte ptr es:[24h]	;@09C99
	cbw	;@09C9D
	cmp	ax, word ptr es:[0Ch]	;@09C9E
	mov	ah, 3	;@09CA3
	jne	@@1	;@09CA5
	test	word ptr ds:[5160h], 8	;@09CA7
	jne	@@3	;@09CAD
	cmp	al, byte ptr es:[0Bh]	;@09CAF
	mov	ah, 2	;@09CB4
	jne	@@1	;@09CB6
	test	byte ptr es:[4], 4	;@09CB8
	je	@@3	;@09CBE
	mov	ah, 1	;@09CC0
	mov	al, byte ptr es:[1]	;@09CC2
	and	al, 7	;@09CC6
	cmp	al, 5	;@09CC8
	je	@@1	;@09CCA
	cmp	al, 6	;@09CCC
	jne	@@3	;@09CCE
@@1:	mov	byte ptr es:[0], ah	;@09CD0
@@2:	clc	;@09CD5
	ret	;@09CD6
@@3:	stc	;@09CD7
	ret	;@09CD8
L09CD9:	call	L036A1	;@09CD9
	sub	word ptr es:[0Ah], ax	;@09CDC
	sbb	word ptr es:[0Ch], dx	;@09CE1
	sbb	byte ptr es:[24h], 0	;@09CE6
	ret	;@09CEC
L09CED:	call	L036A1	;@09CED
	add	word ptr es:[0Ah], ax	;@09CF0
	adc	word ptr es:[0Ch], dx	;@09CF5
	adc	byte ptr es:[24h], 0	;@09CFA
	ret	;@09D00
L09D01:	cmp	word ptr es:[6], 0	;@09D01
	jne	@@1	;@09D07
	test	byte ptr es:[4], 4	;@09D09
	jne	@@1	;@09D0F
	cmp	ax, word ptr es:[0Ah]	;@09D11
	jne	@@1	;@09D16
	ret	;@09D18
@@1:	stc	;@09D19
	ret	;@09D1A
L09D1B:	cmp	word ptr es:[6], 0	;@09D1B
	jne	L09D66	;@09D21
	test	byte ptr es:[4], 4	;@09D23
	jne	L09D66	;@09D29
	mov	al, byte ptr es:[0Ah]	;@09D2B
	cbw	;@09D2F
	cmp	ah, byte ptr es:[0Bh]	;@09D30
	jne	L09D66	;@09D35
	ret	;@09D37
L09D38:	cmp	word ptr es:[6], 0	;@09D38
	jne	L09D66	;@09D3E
	test	byte ptr es:[4], 4	;@09D40
	jne	L09D66	;@09D46
	mov	al, byte ptr es:[0Ah]	;@09D48
	cbw	;@09D4C
	cmp	ah, byte ptr es:[0Bh]	;@09D4D
	jne	L09D66	;@09D52
	test	word ptr ds:[5160h], 8	;@09D54
	jne	@@1	;@09D5A
	ret	;@09D5C
@@1:	cwd	;@09D5D
	cmp	dx, word ptr es:[0Ch]	;@09D5E
	jne	L09D66	;@09D63
	ret	;@09D65
L09D66:	stc	;@09D66
	ret	;@09D67
L09D68:	test	word ptr ds:[5160h], 20h	;@09D68
	je	@@1	;@09D6E
	cmp	word ptr es:[6], 0	;@09D70
	jne	@@1	;@09D76
	mov	ax, word ptr ds:[5162h]	;@09D78
	test	word ptr ds:[5160h], 1000h	;@09D7B
	jne	@@2	;@09D81
	test	byte ptr es:[4], 4	;@09D83
	je	@@1	;@09D89
	push	es	;@09D8B
	push	cx	;@09D8C
	mov	es, word ptr ds:[5638h]	;@09D8D
	call	L018F9	;@09D91
	mov	es, ax	;@09D94
	mov	ax, word ptr es:[1Ah]	;@09D96
	test	byte ptr es:[4], 4	;@09D9A
	pop	cx	;@09DA0
	pop	es	;@09DA1
	je	@@1	;@09DA2
	mov	dx, ax	;@09DA4
	mov	ax, word ptr es:[18h]	;@09DA6
	and	ax, ax	;@09DAA
	je	@@1	;@09DAC
	cmp	ax, dx	;@09DAE
	jne	@@1	;@09DB0
	ret	;@09DB2
@@1:	stc	;@09DB3
	ret	;@09DB4
@@2:	and	ax, ax	;@09DB5
	je	@@1	;@09DB7
	mov	dx, ax	;@09DB9
	mov	ax, word ptr es:[18h]	;@09DBB
	and	ax, ax	;@09DBF
	je	@@1	;@09DC1
	push	es	;@09DC3
	mov	es, ax	;@09DC4
	call	L0150E	;@09DC6
	call	L014F8	;@09DC9
	xchg	ax, dx	;@09DCC
	mov	es, ax	;@09DCD
	call	L0150E	;@09DCF
	call	L014F8	;@09DD2
	pop	es	;@09DD5
	cmp	ax, dx	;@09DD6
	jne	@@1	;@09DD8
	ret	;@09DDA
L09DDB:	cmp	word ptr es:[6], 0	;@09DDB
	jne	@@4	;@09DE1
	test	byte ptr es:[4], 4	;@09DE3
	je	@@2	;@09DE9
	mov	al, byte ptr es:[1]	;@09DEB
	and	al, 7	;@09DEF
	cmp	al, 3	;@09DF1
	je	@@1	;@09DF3
	cmp	al, 2	;@09DF5
	je	@@1	;@09DF7
	cmp	al, 1	;@09DF9
	jne	@@4	;@09DFB
@@1:	mov	ax, word ptr ds:[5162h]	;@09DFD
	cmp	ax, word ptr es:[1Ah]	;@09E00
	jne	@@4	;@09E05
@@2:	mov	ax, word ptr ds:[5154h]	;@09E07
	mov	dx, word ptr ds:[5156h]	;@09E0A
	mov	bx, word ptr es:[0Ah]	;@09E0E
	sub	bx, ax	;@09E13
	mov	ax, bx	;@09E15
	mov	bx, word ptr es:[0Ch]	;@09E17
	sbb	bx, dx	;@09E1C
	sub	ax, 2	;@09E1E
	sbb	bx, 0	;@09E21
	and	bx, bx	;@09E24
	je	@@3	;@09E26
	cmp	bx, -1	;@09E28
	jne	@@4	;@09E2B
@@3:	cmp	ah, bl	;@09E2D
	jne	@@4	;@09E2F
	xor	bl, al	;@09E31
	and	bl, 80h	;@09E33
	je	@@5	;@09E36
@@4:	stc	;@09E38
@@5:	ret	;@09E39
L09E3A:	mov	es, word ptr ds:[55D6h]	;@09E3A
	mov	al, byte ptr es:[4]	;@09E3E
	test	al, 0C0h	;@09E42
	jne	@@1	;@09E44
	test	byte ptr es:[0], 80h	;@09E46
	je	@@3	;@09E4C
	cmp	byte ptr es:[0], 80h	;@09E4E
	jne	@@1	;@09E54
	cmp	word ptr es:[6], 0	;@09E56
	je	@@1	;@09E5C
	mov	es, word ptr ds:[55D2h]	;@09E5E
	test	byte ptr es:[4], 80h	;@09E62
	jne	@@2	;@09E68
@@1:	stc	;@09E6A
@@2:	ret	;@09E6B
@@3:	test	byte ptr es:[5], 80h	;@09E6C
	je	@@2	;@09E72
	test	word ptr ds:[5166h], 8000h	;@09E74
	je	@@2	;@09E7A
	mov	ax, 8080h	;@09E7C
	call	L08FDB	;@09E7F
	clc	;@09E82
	ret	;@09E83
L09E84:	test	word ptr ds:[5160h], 8	;@09E84
	jne	@@1	;@09E8A
	ret	;@09E8C
@@1:	mov	al, byte ptr es:[5]	;@09E8D
	test	al, 2	;@09E91
	jne	@@2	;@09E93
	test	al, 1	;@09E95
	jne	@@3	;@09E97
	mov	ax, word ptr ds:[5162h]	;@09E99
	and	ax, ax	;@09E9C
	je	@@3	;@09E9E
	call	L00752	;@09EA0
	je	@@3	;@09EA3
@@2:	stc	;@09EA5
@@3:	ret	;@09EA6
L09EA7:	test	word ptr ds:[5160h], 8	;@09EA7
	je	@@4	;@09EAD
	mov	al, byte ptr es:[5]	;@09EAF
	test	al, 2	;@09EB3
	jne	@@3	;@09EB5
	test	al, 1	;@09EB7
	jne	@@4	;@09EB9
@@1:	mov	ax, word ptr ds:[5162h]	;@09EBB
	and	ax, ax	;@09EBE
	je	@@2	;@09EC0
	call	L00752	;@09EC2
	je	@@2	;@09EC5
	mov	al, 4	;@09EC7
	ret	;@09EC9
@@2:	mov	al, 2	;@09ECA
	ret	;@09ECC
@@3:	call	@@1	;@09ECD
	cmp	al, 4	;@09ED0
	je	@@5	;@09ED2
	mov	al, 5	;@09ED4
	ret	;@09ED6
@@4:	call	@@1	;@09ED7
	cmp	al, 2	;@09EDA
	je	@@5	;@09EDC
	mov	al, 3	;@09EDE
@@5:	ret	;@09EE0
L09EE1:	test	word ptr ds:[5160h], 8	;@09EE1
	jne	@@1	;@09EE7
	ret	;@09EE9
@@1:	mov	al, byte ptr es:[5]	;@09EEA
	and	al, 0Ch	;@09EEE
	je	@@2	;@09EF0
	test	al, 4	;@09EF2
	je	@@4	;@09EF4
	test	al, 8	;@09EF6
	je	@@5	;@09EF8
	mov	al, byte ptr es:[4]	;@09EFA
	test	al, 40h	;@09EFE
	je	@@4	;@09F00
	mov	bx, word ptr es:[0Eh]	;@09F02
	sub	bx, word ptr ds:[55DCh]	;@09F07
	cmp	bx, 3Ch	;@09F0B
	ret	;@09F0E
@@2:	test	byte ptr es:[4], 80h	;@09F0F
	je	@@3	;@09F15
	cmp	word ptr es:[6], 0	;@09F17
	jne	@@3	;@09F1D
	mov	al, byte ptr es:[24h]	;@09F1F
	cbw	;@09F23
	cmp	word ptr es:[0Ch], ax	;@09F24
	jne	@@4	;@09F29
	ret	;@09F2B
@@3:	mov	ax, word ptr ds:[5162h]	;@09F2C
	and	ax, ax	;@09F2F
	je	@@5	;@09F31
	call	L00752	;@09F33
	je	@@5	;@09F36
@@4:	stc	;@09F38
@@5:	ret	;@09F39
L09F3A:	mov	ax, word ptr ds:[5162h]	;@09F3A
	and	ax, ax	;@09F3D
	je	@@1	;@09F3F
	call	L00752	;@09F41
	je	@@1	;@09F44
	mov	al, 3	;@09F46
	ret	;@09F48
@@1:	mov	al, 2	;@09F49
	ret	;@09F4B
L09F4C:	call	L09EE1	;@09F4C
	jb	L09F63	;@09F4F
L09F51:	mov	ax, word ptr ds:[5162h]	;@09F51
	and	ax, ax	;@09F54
	je	@@1	;@09F56
	call	L00752	;@09F58
	je	@@1	;@09F5B
	mov	al, 67h	;@09F5D
	jmp	L040E7	;@09F5F
@@1:	ret	;@09F62
L09F63:	mov	ax, word ptr ds:[5162h]	;@09F63
	and	ax, ax	;@09F66
	je	@@1	;@09F68
	call	L00752	;@09F6A
	jne	@@2	;@09F6D
@@1:	mov	al, 67h	;@09F6F
	jmp	L040E7	;@09F71
@@2:	ret	;@09F74
	db	90h	;@09F75
L09F76:	mov	al, byte ptr es:[0]	;@09F76
	cmp	al, 3	;@09F7A
	je	L09F95	;@09F7C
	cmp	al, 2	;@09F7E
	je	L09F83	;@09F80
	ret	;@09F82
L09F83:	mov	ax, word ptr ds:[5162h]	;@09F83
	and	ax, ax	;@09F86
	je	@@1	;@09F88
	call	L00752	;@09F8A
	je	@@1	;@09F8D
	mov	al, 66h	;@09F8F
	jmp	L040E7	;@09F91
@@1:	ret	;@09F94
L09F95:	mov	ax, word ptr ds:[5162h]	;@09F95
	and	ax, ax	;@09F98
	je	@@1	;@09F9A
	call	L00752	;@09F9C
	je	@@1	;@09F9F
	ret	;@09FA1
@@1:	mov	al, 66h	;@09FA2
	jmp	L040E7	;@09FA4
L09FA7:	call	L09FEA	;@09FA7
	jne	@@2	;@09FAA
	test	byte ptr es:[4], 80h	;@09FAC
	je	@@1	;@09FB2
	jmp	L09F4C	;@09FB4
@@1:	ret	;@09FB6
@@2:	call	L08CCA	;@09FB7
	sub	al, 8	;@09FBA
	cmp	al, 1	;@09FBC
	je	@@4	;@09FBE
@@3:	mov	bx, 1CE8h	;@09FC0
	xlat	;@09FC3
	call	L04095	;@09FC4
	jmp	L09F4C	;@09FC7
@@4:	test	word ptr ds:[5166h], 4	;@09FC9
	je	@@3	;@09FCF
	cmp	byte ptr ds:[55D8h], 0	;@09FD1
	je	@@3	;@09FD6
	test	word ptr ds:[5160h], 80h	;@09FD8
	je	@@3	;@09FDE
	push	cx	;@09FE0
	mov	cx, 8060h	;@09FE1
	call	L03208	;@09FE4
	pop	cx	;@09FE7
	jmp	@@3	;@09FE8
L09FEA:	test	byte ptr es:[4], 80h	;@09FEA
	jne	@@1	;@09FF0
	ret	;@09FF2
@@1:	call	L0A021	;@09FF3
	and	ax, ax	;@09FF6
	je	@@3	;@09FF8
	push	ax	;@09FFA
	call	L08CE1	;@09FFB
	pop	bx	;@09FFE
	xchg	ax, bx	;@09FFF
	cmp	ax, bx	;@0A000
	je	@@4	;@0A002
	mov	bx, word ptr ds:[55DAh]	;@0A004
	cmp	bx, word ptr ds:[5636h]	;@0A008
	je	@@2	;@0A00C
	ret	;@0A00E
@@2:	mov	ax, 3Ch	;@0A00F
	call	L08FDB	;@0A012
	xor	ax, ax	;@0A015
	ret	;@0A017
@@3:	mov	ax, 31h	;@0A018
	call	L08FDB	;@0A01B
@@4:	xor	ax, ax	;@0A01E
	ret	;@0A020
L0A021:	push	cx	;@0A021
	mov	bx, word ptr es:[14h]	;@0A022
	and	bx, bx	;@0A027
	je	@@3	;@0A029
	push	es	;@0A02B
	mov	es, bx	;@0A02C
	call	L018F9	;@0A02E
	mov	es, ax	;@0A031
	cmp	word ptr es:[6], 0	;@0A033
	pop	es	;@0A039
	jne	@@1	;@0A03A
	call	L0A4C8	;@0A03C
@@1:	mov	bx, word ptr es:[14h]	;@0A03F
	jmp	@@20	;@0A044
@@2:	call	L08CE1	;@0A047
	mov	bx, ax	;@0A04A
	jmp	@@20	;@0A04C
@@3:	mov	ax, word ptr es:[18h]	;@0A04F
	and	ax, ax	;@0A053
	je	@@2	;@0A055
	call	L0072A	;@0A057
	jne	@@2	;@0A05A
	call	L08CE1	;@0A05C
	push	es	;@0A05F
	mov	es, ax	;@0A060
	call	L018F9	;@0A062
	mov	di, ax	;@0A065
	mov	es, ax	;@0A067
	mov	bx, word ptr es:[6]	;@0A069
	pop	es	;@0A06E
	and	bx, bx	;@0A06F
	jne	@@11	;@0A071
	call	L0A4C8	;@0A073
	je	@@2	;@0A076
	cmp	word ptr es:[6], 0	;@0A078
	jne	@@10	;@0A07E
	xor	di, di	;@0A080
	mov	cx, 6	;@0A082
	test	word ptr ds:[5160h], 8	;@0A085
	jne	@@4	;@0A08B
	mov	cx, 4	;@0A08D
@@4:	mov	bx, 5642h	;@0A090
@@5:	mov	ax, word ptr [bx]	;@0A093
	call	L0080F	;@0A095
	jne	@@8	;@0A098
	push	bx	;@0A09A
	push	cx	;@0A09B
	push	di	;@0A09C
	push	es	;@0A09D
	mov	es, ax	;@0A09E
	call	L018F9	;@0A0A0
	mov	di, es	;@0A0A3
	mov	es, ax	;@0A0A5
	cmp	word ptr es:[6], 0	;@0A0A7
	pop	es	;@0A0AD
	jne	@@6	;@0A0AE
	call	L0A4C8	;@0A0B0
	pop	di	;@0A0B3
	jne	@@7	;@0A0B4
	pop	cx	;@0A0B6
	pop	bx	;@0A0B7
	mov	bx, word ptr [bx]	;@0A0B8
	jmp	@@20	;@0A0BA
@@6:	pop	ax	;@0A0BD
@@7:	pop	cx	;@0A0BE
	pop	bx	;@0A0BF
@@8:	add	bx, 2	;@0A0C0
	loop	@@5	;@0A0C3
	and	di, di	;@0A0C5
	je	@@14	;@0A0C7
	test	byte ptr ds:[38D7h], 0Bh	;@0A0C9
	jne	@@14	;@0A0CE
	mov	word ptr es:[6], di	;@0A0D0
	or	byte ptr ds:[38D8h], 1	;@0A0D5
@@9:	xor	bx, bx	;@0A0DA
	mov	ax, word ptr ds:[55DAh]	;@0A0DC
	cmp	ax, word ptr ds:[5636h]	;@0A0DF
	je	@@20	;@0A0E3
	mov	bx, di	;@0A0E5
	jmp	short @@20	;@0A0E7
@@10:	mov	di, word ptr ds:[5638h]	;@0A0E9
	jmp	@@9	;@0A0ED
@@11:	test	byte ptr ds:[38D7h], 0Bh	;@0A0EF
	jne	@@14	;@0A0F4
	mov	ax, bx	;@0A0F6
	xor	bx, bx	;@0A0F8
	cmp	ax, word ptr es:[1Ah]	;@0A0FA
	je	@@19	;@0A0FF
	push	di	;@0A101
	mov	cx, 6	;@0A102
	test	word ptr ds:[5160h], 8	;@0A105
	jne	@@12	;@0A10B
	mov	cx, 4	;@0A10D
@@12:	mov	bx, 5642h	;@0A110
@@13:	mov	ax, word ptr [bx]	;@0A113
	call	L0080F	;@0A115
	jne	@@17	;@0A118
	push	bx	;@0A11A
	push	cx	;@0A11B
	push	es	;@0A11C
	mov	es, ax	;@0A11D
	call	L018F9	;@0A11F
	mov	es, ax	;@0A122
	mov	bx, word ptr es:[6]	;@0A124
	pop	es	;@0A129
	and	bx, bx	;@0A12A
	jne	@@15	;@0A12C
	call	L0A4C8	;@0A12E
	jne	@@16	;@0A131
	pop	cx	;@0A133
	pop	bx	;@0A134
	mov	bx, word ptr [bx]	;@0A135
	pop	di	;@0A137
	jmp	short @@20	;@0A138
@@14:	xor	bx, bx	;@0A13A
	jmp	short @@20	;@0A13C
@@15:	cmp	bx, word ptr es:[1Ah]	;@0A13E
	jne	@@16	;@0A143
	pop	cx	;@0A145
	pop	bx	;@0A146
	mov	bx, word ptr [bx]	;@0A147
	jmp	short @@18	;@0A149
@@16:	pop	cx	;@0A14B
	pop	bx	;@0A14C
@@17:	add	bx, 2	;@0A14D
	loop	@@13	;@0A150
	xor	bx, bx	;@0A152
@@18:	pop	di	;@0A154
@@19:	mov	word ptr es:[6], di	;@0A155
	or	byte ptr ds:[38D8h], 1	;@0A15A
@@20:	mov	cx, bx	;@0A15F
	mov	al, byte ptr es:[1]	;@0A161
	and	al, 7	;@0A165
	cmp	al, 3	;@0A167
	je	@@21	;@0A169
	cmp	al, 2	;@0A16B
	jne	@@23	;@0A16D
@@21:	sub	byte ptr es:[1], 2	;@0A16F
	jne	@@22	;@0A175
	and	byte ptr es:[4], 0FBh	;@0A177
	xor	ax, ax	;@0A17D
	mov	word ptr es:[18h], ax	;@0A17F
	mov	word ptr es:[1Ah], ax	;@0A183
	mov	ax, cx	;@0A187
	pop	cx	;@0A189
	and	ax, ax	;@0A18A
	ret	;@0A18C
@@22:	call	L0A5E6	;@0A18D
@@23:	mov	ax, cx	;@0A190
	pop	cx	;@0A192
	and	ax, ax	;@0A193
	ret	;@0A195
L0A196:	mov	al, byte ptr es:[0]	;@0A196
	cmp	al, 2	;@0A19A
	je	L0A1C5	;@0A19C
	cmp	al, 1	;@0A19E
	jne	L0A1D1	;@0A1A0
L0A1A2:	mov	dh, 2	;@0A1A2
	call	L0A582	;@0A1A4
	mov	al, byte ptr es:[0Ah]	;@0A1A7
	jmp	L04110	;@0A1AB
L0A1AE:	call	L09EE1	;@0A1AE
	jb	L0A1D1	;@0A1B1
	mov	al, byte ptr es:[24h]	;@0A1B3
	cbw	;@0A1B7
	cmp	ax, word ptr es:[0Ch]	;@0A1B8
	je	L0A1C5	;@0A1BD
	mov	ax, 21h	;@0A1BF
	jmp	L08FDB	;@0A1C2
L0A1C5:	mov	dh, 2	;@0A1C5
	call	L0A582	;@0A1C7
	mov	ax, word ptr es:[0Ah]	;@0A1CA
	jmp	L0412E	;@0A1CE
L0A1D1:	mov	dh, 4	;@0A1D1
	call	L0A582	;@0A1D3
	mov	ax, word ptr es:[0Ah]	;@0A1D6
	mov	cx, word ptr es:[0Ch]	;@0A1DA
	jmp	L0414A	;@0A1DF
L0A1E2:	mov	dh, 2	;@0A1E2
	call	L0A582	;@0A1E4
	mov	ax, word ptr es:[0Ah]	;@0A1E7
	mov	cx, word ptr es:[16h]	;@0A1EB
	jmp	L0414A	;@0A1F0
L0A1F3:	mov	dh, 4	;@0A1F3
	call	L0A582	;@0A1F5
	mov	ax, word ptr es:[0Ah]	;@0A1F8
	mov	bx, word ptr es:[0Ch]	;@0A1FC
	mov	dh, byte ptr es:[24h]	;@0A201
	mov	cx, 8	;@0A206
	jmp	L041B2	;@0A209
L0A20C:	mov	dh, 4	;@0A20C
	call	L0A582	;@0A20E
	mov	ax, word ptr es:[0Ah]	;@0A211
	mov	bx, word ptr es:[0Ch]	;@0A215
	mov	dh, byte ptr es:[24h]	;@0A21A
	mov	cx, 6	;@0A21F
	jmp	L041B2	;@0A222
L0A225:	mov	dh, 4	;@0A225
	call	L0A582	;@0A227
	mov	ax, word ptr es:[0Ah]	;@0A22A
	mov	cx, word ptr es:[0Ch]	;@0A22E
	mov	di, word ptr es:[16h]	;@0A233
	jmp	L04169	;@0A238
L0A23B:	mov	dh, 4	;@0A23B
	call	L0A582	;@0A23D
	mov	ax, word ptr es:[0Ah]	;@0A240
	mov	bx, word ptr es:[0Ch]	;@0A244
	mov	dh, byte ptr es:[24h]	;@0A249
	mov	cx, 0Ah	;@0A24E
	jmp	L041B2	;@0A251
L0A254:	mov	cx, 4	;@0A254
	jmp	L0418C	;@0A257
L0A25A:	mov	cx, 6	;@0A25A
	jmp	L0418C	;@0A25D
L0A260:	mov	cx, 8	;@0A260
	jmp	L0418C	;@0A263
L0A266:	mov	cx, 0Ah	;@0A266
	jmp	L0418C	;@0A269
L0A26C:	test	byte ptr es:[4], 80h	;@0A26C
	jne	@@4	;@0A272
	test	byte ptr es:[4], 40h	;@0A274
	je	@@2	;@0A27A
	mov	ax, word ptr es:[0Eh]	;@0A27C
	call	L08CCA	;@0A280
	cmp	al, 8	;@0A283
	jae	@@1	;@0A285
	or	al, cl	;@0A287
	or	al, 0C0h	;@0A289
	jmp	L04110	;@0A28B
@@1:	mov	ax, 3Eh	;@0A28E
	jmp	L08FDB	;@0A291
@@2:	mov	ax, 3Dh	;@0A294
	jmp	L08FDB	;@0A297
@@3:	mov	ax, 21h	;@0A29A
	jmp	L08FDB	;@0A29D
@@4:	call	L09EE1	;@0A2A0
	jae	@@5	;@0A2A3
	jmp	@@13	;@0A2A5
@@5:	mov	al, byte ptr es:[24h]	;@0A2A8
	cbw	;@0A2AC
	cmp	ax, word ptr es:[0Ch]	;@0A2AD
	jne	@@3	;@0A2B2
	mov	al, byte ptr es:[4]	;@0A2B4
	test	al, 40h	;@0A2B8
	jne	@@7	;@0A2BA
	mov	al, 6	;@0A2BC
	or	al, cl	;@0A2BE
	call	L04110	;@0A2C0
	mov	dh, 2	;@0A2C3
	call	L0A582	;@0A2C5
	mov	ax, word ptr es:[0Ah]	;@0A2C8
	jmp	L0412E	;@0A2CC
@@6:	mov	al, cl	;@0A2CF
	or	al, 80h	;@0A2D1
	call	L04110	;@0A2D3
	mov	dh, 2	;@0A2D6
	call	L0A582	;@0A2D8
	mov	ax, word ptr es:[0Ah]	;@0A2DB
	jmp	L0412E	;@0A2DF
@@7:	cmp	word ptr es:[6], 0	;@0A2E2
	jne	@@6	;@0A2E8
	test	al, 20h	;@0A2EA
	jne	@@3	;@0A2EC
	mov	ax, word ptr es:[0Eh]	;@0A2EE
	sub	ax, word ptr ds:[55DCh]	;@0A2F2
	shr	ax, 1	;@0A2F6
	sub	ax, 1Eh	;@0A2F8
	jb	@@3	;@0A2FB
	cmp	al, 8	;@0A2FD
	jae	@@3	;@0A2FF
	mov	bx, 1D06h	;@0A301
	xlat	;@0A304
	test	al, 80h	;@0A305
	jne	@@3	;@0A307
	mov	dh, al	;@0A309
	test	byte ptr es:[4], 10h	;@0A30B
	je	@@8	;@0A311
	mov	ax, word ptr es:[12h]	;@0A313
	sub	ax, word ptr ds:[55DCh]	;@0A317
	shr	ax, 1	;@0A31B
	sub	ax, 1Eh	;@0A31D
	jb	@@12	;@0A320
	cmp	al, 8	;@0A322
	jae	@@12	;@0A324
	mov	bx, 1D06h	;@0A326
	xlat	;@0A329
	test	al, 80h	;@0A32A
	jne	@@12	;@0A32C
	shl	al, 1	;@0A32E
	shl	al, 1	;@0A330
	or	al, dh	;@0A332
	mov	bx, 1D0Eh	;@0A334
	xlat	;@0A337
	test	al, 80h	;@0A338
	jne	@@12	;@0A33A
	mov	dh, al	;@0A33C
@@8:	xor	dh, 4	;@0A33E
	or	cl, dh	;@0A341
	call	L09D1B	;@0A343
	jb	@@6	;@0A346
	mov	ax, word ptr es:[0Eh]	;@0A348
	cmp	ax, word ptr ds:[5630h]	;@0A34C
	jne	@@9	;@0A350
	test	byte ptr es:[4], 10h	;@0A352
	je	@@10	;@0A358
@@9:	mov	ax, word ptr es:[0Ah]	;@0A35A
	or	ax, word ptr es:[0Ch]	;@0A35E
	je	@@11	;@0A363
@@10:	mov	al, cl	;@0A365
	or	al, 40h	;@0A367
	call	L04110	;@0A369
	mov	al, byte ptr es:[0Ah]	;@0A36C
	jmp	L04110	;@0A370
@@11:	mov	al, cl	;@0A373
	jmp	L04110	;@0A375
@@12:	jmp	@@3	;@0A378
@@13:	mov	al, byte ptr es:[4]	;@0A37B
	test	al, 40h	;@0A37F
	jne	@@15	;@0A381
	mov	al, 5	;@0A383
	or	al, cl	;@0A385
	call	L04110	;@0A387
@@14:	mov	dh, 4	;@0A38A
	call	L0A582	;@0A38C
	mov	ax, word ptr es:[0Ah]	;@0A38F
	mov	cx, word ptr es:[0Ch]	;@0A393
	jmp	L0414A	;@0A398
@@15:	test	al, 30h	;@0A39B
	jne	@@21	;@0A39D
	mov	ax, word ptr es:[0Eh]	;@0A39F
	sub	ax, word ptr ds:[55DCh]	;@0A3A3
	shr	ax, 1	;@0A3A7
	sub	ax, 8	;@0A3A9
	jb	@@12	;@0A3AC
	cmp	al, 8	;@0A3AE
	jae	@@12	;@0A3B0
	or	cl, al	;@0A3B2
	call	L09D38	;@0A3B4
	jb	@@16	;@0A3B7
	mov	ax, word ptr es:[0Ah]	;@0A3B9
	or	ax, word ptr es:[0Ch]	;@0A3BD
	je	@@17	;@0A3C2
	or	cl, 40h	;@0A3C4
	jmp	short @@17	;@0A3C7
@@16:	or	cl, 80h	;@0A3C9
@@17:	mov	al, cl	;@0A3CC
	and	al, 0C7h	;@0A3CE
	cmp	al, 5	;@0A3D0
	jne	@@18	;@0A3D2
	or	cl, 40h	;@0A3D4
@@18:	mov	al, cl	;@0A3D7
	call	L04110	;@0A3D9
	and	al, 7	;@0A3DC
	cmp	al, 4	;@0A3DE
	jne	@@19	;@0A3E0
	mov	al, 24h	;@0A3E2
	call	L04110	;@0A3E4
@@19:	test	cl, 40h	;@0A3E7
	jne	@@20	;@0A3EA
	test	cl, 80h	;@0A3EC
	jne	@@14	;@0A3EF
	ret	;@0A3F1
@@20:	mov	al, byte ptr es:[0Ah]	;@0A3F2
	jmp	L04110	;@0A3F6
@@21:	or	cl, 4	;@0A3F9
	mov	bx, word ptr es:[10h]	;@0A3FC
	xor	ch, ch	;@0A401
	cmp	bx, 1	;@0A403
	je	@@22	;@0A406
	mov	ch, 40h	;@0A408
	cmp	bx, 2	;@0A40A
	je	@@22	;@0A40D
	mov	ch, 80h	;@0A40F
	cmp	bx, 4	;@0A411
	je	@@22	;@0A414
	mov	ch, 0C0h	;@0A416
	cmp	bx, 8	;@0A418
	jne	@@23	;@0A41B
@@22:	test	al, 10h	;@0A41D
	jne	@@24	;@0A41F
	mov	ax, word ptr es:[0Eh]	;@0A421
	sub	ax, word ptr ds:[55DCh]	;@0A425
	shr	ax, 1	;@0A429
	sub	ax, 8	;@0A42B
	jb	@@23	;@0A42E
	cmp	al, 8	;@0A430
	jae	@@23	;@0A432
	cmp	al, 4	;@0A434
	je	@@23	;@0A436
	shl	al, 1	;@0A438
	shl	al, 1	;@0A43A
	shl	al, 1	;@0A43C
	or	al, 5	;@0A43E
	or	ch, al	;@0A440
	mov	al, cl	;@0A442
	call	L04110	;@0A444
	mov	al, ch	;@0A447
	call	L04110	;@0A449
	jmp	@@14	;@0A44C
@@23:	jmp	@@3	;@0A44F
@@24:	call	L09D38	;@0A452
	jb	@@25	;@0A455
	mov	ax, word ptr es:[0Ah]	;@0A457
	or	ax, word ptr es:[0Ch]	;@0A45B
	je	@@26	;@0A460
	or	cl, 40h	;@0A462
	jmp	short @@26	;@0A465
@@25:	or	cl, 80h	;@0A467
@@26:	mov	ax, word ptr es:[12h]	;@0A46A
	sub	ax, word ptr ds:[55DCh]	;@0A46E
	shr	ax, 1	;@0A472
	sub	ax, 8	;@0A474
	jb	@@23	;@0A477
	cmp	al, 8	;@0A479
	jae	@@23	;@0A47B
	mov	dl, al	;@0A47D
	mov	ax, word ptr es:[0Eh]	;@0A47F
	sub	ax, word ptr ds:[55DCh]	;@0A483
	shr	ax, 1	;@0A487
	sub	ax, 8	;@0A489
	jb	@@23	;@0A48C
	cmp	al, 8	;@0A48E
	jae	@@23	;@0A490
	test	byte ptr es:[4], 20h	;@0A492
	jne	@@27	;@0A498
	cmp	al, 4	;@0A49A
	jne	@@27	;@0A49C
	xchg	al, dl	;@0A49E
@@27:	or	ch, dl	;@0A4A0
	cmp	al, 4	;@0A4A2
	je	@@23	;@0A4A4
	shl	al, 1	;@0A4A6
	shl	al, 1	;@0A4A8
	shl	al, 1	;@0A4AA
	or	ch, al	;@0A4AC
	mov	ax, cx	;@0A4AE
	and	ax, 7C0h	;@0A4B0
	cmp	ax, 500h	;@0A4B3
	jne	@@28	;@0A4B6
	add	cl, 40h	;@0A4B8
@@28:	mov	al, cl	;@0A4BB
	call	L04110	;@0A4BD
	mov	al, ch	;@0A4C0
	call	L04110	;@0A4C2
	jmp	@@19	;@0A4C5
L0A4C8:	mov	ds, ax	;@0A4C8
	mov	ax, word ptr es:[16h]	;@0A4CA
	cwd	;@0A4CE
	nop	;@0A4CF
	cmp	ax, word ptr ds:[0Ah]	;@0A4D0
	jne	@@4	;@0A4D4
	cmp	dx, word ptr ds:[0Ch]	;@0A4D6
	jne	@@4	;@0A4DA
	cmp	dl, byte ptr ds:[24h]	;@0A4DC
	jne	@@4	;@0A4E0
	test	byte ptr ds:[4], 4	;@0A4E2
	je	@@5	;@0A4E7
	mov	al, byte ptr es:[1]	;@0A4E9
	and	al, 7	;@0A4ED
	cmp	al, 3	;@0A4EF
	je	@@1	;@0A4F1
	cmp	al, 2	;@0A4F3
	jne	@@4	;@0A4F5
@@1:	mov	ax, word ptr es:[18h]	;@0A4F7
	push	es	;@0A4FB
	mov	es, ax	;@0A4FC
	call	L0150E	;@0A4FE
	pop	es	;@0A501
	cmp	ax, word ptr ds:[1Ah]	;@0A502
	je	@@4	;@0A506
	push	es	;@0A508
	mov	es, ax	;@0A509
	call	L014F8	;@0A50B
	pop	es	;@0A50E
	cmp	ax, word ptr ds:[1Ah]	;@0A50F
	je	@@2	;@0A513
	test	word ptr ss:[5160h], 1000h	;@0A515
	jne	@@4	;@0A51C
	test	byte ptr ss:[516Bh], 1	;@0A51E
	je	@@3	;@0A524
	mov	ax, word ptr ds:[1Ah]	;@0A526
	push	es	;@0A529
	mov	es, ax	;@0A52A
	call	L014F8	;@0A52C
	pop	es	;@0A52F
	cmp	ax, word ptr es:[18h]	;@0A530
	jne	@@4	;@0A535
@@2:	mov	ax, word ptr ds:[1Ah]	;@0A537
	mov	word ptr es:[18h], ax	;@0A53A
	jmp	short @@4	;@0A53E
@@3:	xor	al, al	;@0A540
	dec	al	;@0A542
@@4:	push	ss	;@0A544
	pop	ds	;@0A545
	ret	;@0A546
@@5:	mov	al, byte ptr es:[1]	;@0A547
	and	al, 7	;@0A54B
	cmp	al, 3	;@0A54D
	je	@@3	;@0A54F
	cmp	al, 2	;@0A551
	je	@@3	;@0A553
	xor	al, al	;@0A555
	jmp	@@4	;@0A557
L0A559:	mov	ax, word ptr [di+2Ah]	;@0A559
	and	ax, ax	;@0A55C
	jne	@@1	;@0A55E
	push	es	;@0A560
	push	cx	;@0A561
	push	si	;@0A562
	push	di	;@0A563
	mov	es, word ptr [di]	;@0A564
	call	L004A1	;@0A566
	call	far ptr L0FCFE	;@0A569
	xor	bp, bp	;@0A56E
	call	far ptr L12694	;@0A570
	pop	di	;@0A575
	pop	si	;@0A576
	pop	cx	;@0A577
	pop	es	;@0A578
	mov	word ptr [di+2Ah], ax	;@0A579
@@1:	push	es	;@0A57C
	call	L03866	;@0A57D
	pop	es	;@0A580
	ret	;@0A581
L0A582:	test	byte ptr es:[4], 4	;@0A582
	jne	@@2	;@0A588
@@1:	ret	;@0A58A
@@2:	test	byte ptr ds:[38D8h], 1	;@0A58B
	jne	@@1	;@0A590
	mov	bx, word ptr es:[18h]	;@0A592
	mov	di, word ptr es:[1Ah]	;@0A597
	mov	al, byte ptr es:[1]	;@0A59C
	test	word ptr ds:[38C4h], 800h	;@0A5A0
	jne	@@4	;@0A5A6
	and	al, 0EFh	;@0A5A8
@@3:	push	es	;@0A5AA
	call	L0387A	;@0A5AB
	pop	es	;@0A5AE
	ret	;@0A5AF
@@4:	cmp	al, 11h	;@0A5B0
	je	@@5	;@0A5B2
	cmp	al, 13h	;@0A5B4
	jne	@@3	;@0A5B6
@@5:	push	es	;@0A5B8
	mov	es, word ptr es:[26h]	;@0A5B9
	call	L00271	;@0A5BE
	pop	es	;@0A5C1
	jmp	@@3	;@0A5C2
L0A5C4:	test	ah, 80h	;@0A5C4
	jne	@@1	;@0A5C7
	cmp	ax, 0Bh	;@0A5C9
	jae	@@2	;@0A5CC
	mov	bx, ax	;@0A5CE
	mov	al, byte ptr [bx+1CABh]	;@0A5D0
	ret	;@0A5D4
@@1:	not	ax	;@0A5D5
	cmp	ax, 3	;@0A5D7
	jae	@@2	;@0A5DA
	mov	bx, ax	;@0A5DC
	mov	al, byte ptr [bx+1CB6h]	;@0A5DE
	ret	;@0A5E2
@@2:	mov	al, 0	;@0A5E3
	ret	;@0A5E5
L0A5E6:	test	byte ptr es:[4], 4	;@0A5E6
	je	L0A627	;@0A5EC
	cmp	word ptr es:[6], 0	;@0A5EE
	jne	L0A663	;@0A5F4
	mov	bx, word ptr es:[18h]	;@0A5F6
	test	byte ptr es:[1], 8	;@0A5FB
	je	L0A628	;@0A601
	mov	ax, word ptr ds:[5162h]	;@0A603
	cmp	ax, word ptr es:[1Ah]	;@0A606
	jne	L0A627	;@0A60B
	cmp	ax, bx	;@0A60D
L0A60F:	je	L0A62F	;@0A60F
	push	es	;@0A611
	mov	es, ax	;@0A612
	call	L0150E	;@0A614
	pop	es	;@0A617
	cmp	ax, bx	;@0A618
	je	L0A62F	;@0A61A
	push	es	;@0A61C
	mov	es, ax	;@0A61D
	call	L014F8	;@0A61F
	pop	es	;@0A622
	cmp	ax, bx	;@0A623
	je	L0A62F	;@0A625
L0A627:	ret	;@0A627
L0A628:	cmp	bx, word ptr es:[1Ah]	;@0A628
	jne	L0A677	;@0A62D
L0A62F:	mov	al, byte ptr es:[1]	;@0A62F
	and	al, 7	;@0A633
	cmp	al, 1	;@0A635
	je	@@1	;@0A637
	cmp	al, 5	;@0A639
	je	@@1	;@0A63B
	cmp	al, 6	;@0A63D
	je	@@1	;@0A63F
	cmp	al, 3	;@0A641
	jne	L0A677	;@0A643
@@1:	mov	ax, bx	;@0A645
	call	L0076E	;@0A647
	je	@@2	;@0A64A
	test	byte ptr es:[1], 8	;@0A64C
	je	L0A677	;@0A652
@@2:	cmp	byte ptr es:[1], 3	;@0A654
	jne	L0A663	;@0A65A
	sub	byte ptr es:[1], 1	;@0A65C
	ret	;@0A662
L0A663:	and	byte ptr es:[4], 0FBh	;@0A663
	xor	ax, ax	;@0A669
	mov	byte ptr es:[1], al	;@0A66B
	mov	word ptr es:[1Ah], ax	;@0A66F
	mov	word ptr es:[18h], ax	;@0A673
L0A677:	ret	;@0A677
L0A678:	and	byte ptr es:[4], 8Fh	;@0A678
	xor	ax, ax	;@0A67E
	mov	word ptr es:[0Eh], ax	;@0A680
	mov	word ptr es:[12h], ax	;@0A684
	mov	word ptr es:[10h], 1	;@0A688
	jmp	L03208	;@0A68F
L0A692:	and	byte ptr es:[4], 0FBh	;@0A692
	xor	ax, ax	;@0A698
	mov	byte ptr es:[1], al	;@0A69A
	mov	word ptr es:[18h], ax	;@0A69E
	mov	word ptr es:[1Ah], ax	;@0A6A2
	jmp	L03208	;@0A6A6
L0A6A9:	xor	ax, ax	;@0A6A9
	cmp	word ptr es:[0Ch], ax	;@0A6AB
	jne	L0A704	;@0A6B0
	cmp	byte ptr es:[24h], al	;@0A6B2
	jne	L0A704	;@0A6B7
	ret	;@0A6B9
L0A6BA:	mov	al, byte ptr es:[0Bh]	;@0A6BA
	cbw	;@0A6BE
	cwd	;@0A6BF
	cmp	dx, word ptr es:[0Ch]	;@0A6C0
	jne	L0A704	;@0A6C5
	xor	ah, byte ptr es:[24h]	;@0A6C7
	jne	L0A704	;@0A6CC
	ret	;@0A6CE
L0A6CF:	mov	al, byte ptr es:[0Dh]	;@0A6CF
	cbw	;@0A6D3
	xor	ah, byte ptr es:[24h]	;@0A6D4
	jne	L0A704	;@0A6D9
	ret	;@0A6DB
L0A6DC:	mov	al, byte ptr es:[24h]	;@0A6DC
	cbw	;@0A6E0
	mov	byte ptr es:[24h], ah	;@0A6E1
	test	word ptr ds:[5160h], 1008h	;@0A6E6
	jne	@@1	;@0A6EC
	mov	al, ah	;@0A6EE
	cbw	;@0A6F0
	mov	word ptr es:[0Ch], ax	;@0A6F1
@@1:	test	word ptr ds:[5166h], 1000h	;@0A6F5
	je	@@2	;@0A6FB
	mov	cx, 802Ch	;@0A6FD
	jmp	L03208	;@0A700
@@2:	ret	;@0A703
L0A704:	mov	cx, 14h	;@0A704
L0A707:	xor	ax, ax	;@0A707
	mov	word ptr es:[0Ah], ax	;@0A709
	mov	word ptr es:[0Ch], ax	;@0A70D
	mov	byte ptr es:[24h], al	;@0A711
	jmp	L03208	;@0A715
L0A718:	mov	al, byte ptr es:[24h]	;@0A718
	and	al, al	;@0A71C
	je	@@1	;@0A71E
	cmp	al, 0FFh	;@0A720
	jne	L0A6DC	;@0A722
@@1:	test	word ptr ds:[5160h], 1008h	;@0A724
	jne	@@2	;@0A72A
	cbw	;@0A72C
	cmp	ax, word ptr es:[0Ch]	;@0A72D
	jne	L0A6DC	;@0A732
@@2:	ret	;@0A734
	db	90h	;@0A735
L0A736:	test	byte ptr es:[4], 1	;@0A736
	je	@@1	;@0A73C
	mov	ah, byte ptr es:[4]	;@0A73E
	and	ah, 2	;@0A743
	push	es	;@0A746
	mov	es, word ptr es:[8]	;@0A747
	call	L004A1	;@0A74C
	call	L0493B	;@0A74F
	pop	es	;@0A752
	mov	ax, word ptr [bx]	;@0A753
	mov	word ptr es:[0Ah], ax	;@0A755
	mov	al, byte ptr [bx+4]	;@0A759
	mov	byte ptr es:[24h], al	;@0A75C
	mov	ax, word ptr [bx+2]	;@0A760
	mov	word ptr es:[0Ch], ax	;@0A763
	mov	word ptr es:[8], 0	;@0A767
	and	byte ptr es:[4], 0FEh	;@0A76E
@@1:	ret	;@0A774
	db	0, 0C6h, 6, 0D9h, 38h, 0FFh, 56h, 0E8h, 2Ah, 0, 72h, 1Ah, 75h	;@0A775
	db	18h, 0E8h, 0A2h, 0AFh, 72h, 13h, 75h, 11h, 0E8h, 2Bh, 7Fh, 74h
	db	0Ch, 0C6h, 6, 0D9h, 38h, 0, 0E8h, 9Bh, 0AFh, 32h, 0C0h, 5Ah, 0C3h
	db	80h, 26h, 0D8h, 38h, 0FEh, 5Eh, 32h, 0C0h, 0A2h, 0D9h, 38h, 0FEh
	db	0C8h, 0C3h, 89h, 26h, 0BCh, 38h, 0E9h, 1Ah, 5
L0A7B0:	test	word ptr ds:[5160h], 1000h	;@0A7B0
	jne	L0A7D1	;@0A7B6
	call	L0ACCA	;@0A7B8
	jne	L0A7D0	;@0A7BB
	jmp	L0583C	;@0A7BD
L0A7C0:	test	word ptr ds:[5160h], 1000h	;@0A7C0
	jne	L0A7D1	;@0A7C6
	call	L0ACCA	;@0A7C8
	jne	L0A7D0	;@0A7CB
	jmp	L057E0	;@0A7CD
L0A7D0:	ret	;@0A7D0
L0A7D1:	call	L026B8	;@0A7D1
	jne	@@9	;@0A7D4
	and	ah, ah	;@0A7D6
	je	@@3	;@0A7D8
	add	si, 2	;@0A7DA
	push	ax	;@0A7DD
	push	dx	;@0A7DE
	call	L026B8	;@0A7DF
	jne	@@1	;@0A7E2
	cmp	ax, word ptr ds:[5838h]	;@0A7E4
	je	@@1	;@0A7E8
	cmp	ax, word ptr ds:[5830h]	;@0A7EA
	je	@@1	;@0A7EE
	cmp	ax, word ptr ds:[5836h]	;@0A7F0
	jne	@@2	;@0A7F4
@@1:	sub	si, 2	;@0A7F6
	pop	dx	;@0A7F9
	pop	ax	;@0A7FA
	jmp	L0ABD2	;@0A7FB
@@2:	sub	si, 2	;@0A7FE
	pop	dx	;@0A801
	pop	ax	;@0A802
@@3:	test	word ptr ds:[5160h], 8	;@0A803
	je	@@4	;@0A809
	cmp	ax, word ptr ds:[5866h]	;@0A80B
	je	@@5	;@0A80F
	cmp	ax, word ptr ds:[5868h]	;@0A811
	je	@@7	;@0A815
@@4:	call	L0A8BD	;@0A817
	je	@@10	;@0A81A
	jmp	L0A911	;@0A81C
@@5:	add	si, 2	;@0A81F
	call	L0A7D1	;@0A822
	je	@@6	;@0A825
	call	L0AF49	;@0A827
@@6:	jmp	L0587C	;@0A82A
@@7:	add	si, 2	;@0A82D
	call	L0A7D1	;@0A830
	je	@@8	;@0A833
	call	L0AF49	;@0A835
@@8:	jmp	L05896	;@0A838
@@9:	ret	;@0A83B
@@10:	call	L026B8	;@0A83C
	jne	@@11	;@0A83F
	cmp	ax, word ptr ds:[5844h]	;@0A841
	jne	@@13	;@0A845
	add	si, 2	;@0A847
@@11:	push	es	;@0A84A
	call	L0A7D1	;@0A84B
	pop	ax	;@0A84E
	je	@@12	;@0A84F
	call	L0AF55	;@0A851
@@12:	jmp	L05A37	;@0A854
@@13:	cmp	ax, word ptr ds:[5890h]	;@0A857
	jne	@@15	;@0A85B
	add	si, 2	;@0A85D
	push	es	;@0A860
	call	L0A7D1	;@0A861
	pop	ax	;@0A864
	je	@@14	;@0A865
	call	L0AF55	;@0A867
@@14:	jmp	L05A67	;@0A86A
@@15:	cmp	ax, word ptr ds:[5892h]	;@0A86D
	jne	@@11	;@0A871
	add	si, 2	;@0A873
	push	es	;@0A876
	call	L0A7D1	;@0A877
	pop	ax	;@0A87A
	je	@@16	;@0A87B
	call	L0AF55	;@0A87D
@@16:	jmp	L05ABE	;@0A880
L0A883:	call	L026B8	;@0A883
	jne	@@1	;@0A886
	cmp	ax, word ptr ds:[5840h]	;@0A888
	jne	@@1	;@0A88C
	add	si, 2	;@0A88E
	call	L0A7B0	;@0A891
	jne	@@2	;@0A894
@@1:	ret	;@0A896
@@2:	call	L05542	;@0A897
	xor	al, al	;@0A89A
	ret	;@0A89C
L0A89D:	call	L026B8	;@0A89D
	jne	L0A8B7	;@0A8A0
	call	L0A8BD	;@0A8A2
	jne	@@1	;@0A8A5
	ret	;@0A8A7
@@1:	call	L0066E	;@0A8A8
	je	@@2	;@0A8AB
	add	si, 2	;@0A8AD
	jmp	L05B45	;@0A8B0
@@2:	xor	al, al	;@0A8B3
	dec	al	;@0A8B5
L0A8B7:	ret	;@0A8B7
L0A8B8:	call	L026B8	;@0A8B8
	jne	L0A8B7	;@0A8BB
L0A8BD:	push	ss	;@0A8BD
	pop	es	;@0A8BE
	mov	di, 5846h	;@0A8BF
	mov	cx, 0Eh	;@0A8C2
	repne scasw	;@0A8C5
	jne	@@1	;@0A8C7
	add	si, 2	;@0A8C9
	mov	bx, 0Dh	;@0A8CC
	sub	bx, cx	;@0A8CF
	shl	bx, 1	;@0A8D1
	jmp	word ptr [bx+1F4Ah]	;@0A8D3
@@1:	test	word ptr ds:[5160h], 1000h	;@0A8D7
	je	@@3	;@0A8DD
	cmp	ax, word ptr ds:[588Eh]	;@0A8DF
	jne	@@3	;@0A8E3
	add	si, 2	;@0A8E5
	call	L0A7D1	;@0A8E8
	je	@@2	;@0A8EB
	call	L0AF55	;@0A8ED
@@2:	xor	al, al	;@0A8F0
	ret	;@0A8F2
@@3:	and	dh, dh	;@0A8F3
	je	@@5	;@0A8F5
	mov	ax, dx	;@0A8F7
	call	L00853	;@0A8F9
	jne	@@6	;@0A8FC
	add	si, 2	;@0A8FE
	call	L0081F	;@0A901
	je	@@4	;@0A904
	jmp	L05B19	;@0A906
@@4:	jmp	L05B30	;@0A909
@@5:	xor	al, al	;@0A90C
	dec	al	;@0A90E
@@6:	ret	;@0A910
L0A911:	call	L026B8	;@0A911
	jne	@@4	;@0A914
	call	@@6	;@0A916
	jne	@@4	;@0A919
@@1:	call	L026B8	;@0A91B
	jne	@@3	;@0A91E
	cmp	ax, word ptr ds:[5834h]	;@0A920
	jne	@@3	;@0A924
	add	si, 2	;@0A926
	call	L026B8	;@0A929
	jne	@@2	;@0A92C
	mov	ax, dx	;@0A92E
	call	L0066E	;@0A930
	je	@@2	;@0A933
	add	si, 2	;@0A935
	call	L05B5E	;@0A938
	jmp	@@1	;@0A93B
@@2:	mov	cx, 0Ch	;@0A93D
	call	L03208	;@0A940
@@3:	xor	al, al	;@0A943
@@4:	ret	;@0A945
@@5:	call	L026B8	;@0A946
	jne	@@9	;@0A949
@@6:	call	@@11	;@0A94B
	jne	@@9	;@0A94E
	call	L026B8	;@0A950
	jne	@@8	;@0A953
	cmp	ax, word ptr ds:[5808h]	;@0A955
	jne	@@8	;@0A959
	add	si, 2	;@0A95B
	push	es	;@0A95E
	call	@@5	;@0A95F
	pop	ax	;@0A962
	je	@@7	;@0A963
	call	L0AF55	;@0A965
@@7:	jmp	L05BB2	;@0A968
@@8:	xor	al, al	;@0A96B
@@9:	ret	;@0A96D
@@10:	call	L026B8	;@0A96E
	jne	@@13	;@0A971
@@11:	cmp	ax, word ptr ds:[586Ah]	;@0A973
	jne	L0A988	;@0A977
	add	si, 2	;@0A979
	call	@@10	;@0A97C
	je	@@12	;@0A97F
	call	L0AF49	;@0A981
@@12:	jmp	L05D1B	;@0A984
@@13:	ret	;@0A987
L0A988:	call	@@8	;@0A988
	jne	@@6	;@0A98B
@@1:	call	L026B8	;@0A98D
	jne	@@5	;@0A990
	cmp	ax, word ptr ds:[586Ch]	;@0A992
	jne	@@3	;@0A996
	add	si, 2	;@0A998
	push	es	;@0A99B
	call	@@7	;@0A99C
	pop	ax	;@0A99F
	je	@@2	;@0A9A0
	call	L0AF49	;@0A9A2
@@2:	call	L05DCC	;@0A9A5
	jmp	@@1	;@0A9A8
@@3:	cmp	ax, word ptr ds:[586Eh]	;@0A9AA
	jne	@@5	;@0A9AE
	add	si, 2	;@0A9B0
	push	es	;@0A9B3
	call	@@7	;@0A9B4
	pop	ax	;@0A9B7
	je	@@4	;@0A9B8
	call	L0AF49	;@0A9BA
@@4:	call	L05DF7	;@0A9BD
	jmp	@@1	;@0A9C0
@@5:	xor	al, al	;@0A9C2
@@6:	ret	;@0A9C4
@@7:	call	L026B8	;@0A9C5
	jne	@@12	;@0A9C8
@@8:	call	@@14	;@0A9CA
	jne	@@12	;@0A9CD
@@9:	call	L026B8	;@0A9CF
	jne	@@11	;@0A9D2
	cmp	ax, word ptr ds:[5870h]	;@0A9D4
	jne	@@11	;@0A9D8
	add	si, 2	;@0A9DA
	push	es	;@0A9DD
	call	@@13	;@0A9DE
	pop	ax	;@0A9E1
	je	@@10	;@0A9E2
	call	L0AF49	;@0A9E4
@@10:	call	L05E22	;@0A9E7
	jmp	@@9	;@0A9EA
@@11:	xor	al, al	;@0A9EC
@@12:	ret	;@0A9EE
@@13:	call	L026B8	;@0A9EF
	jne	@@16	;@0A9F2
@@14:	cmp	ax, word ptr ds:[5872h]	;@0A9F4
	jne	@@17	;@0A9F8
	add	si, 2	;@0A9FA
	call	@@13	;@0A9FD
	je	@@15	;@0AA00
	call	L0AF49	;@0AA02
@@15:	jmp	L05E4D	;@0AA05
@@16:	ret	;@0AA08
@@17:	call	L0AA93	;@0AA09
	jne	L0AA25	;@0AA0C
L0AA0E:	call	L026B8	;@0AA0E
	jne	@@1	;@0AA11
	mov	bx, es	;@0AA13
	push	ss	;@0AA15
	pop	es	;@0AA16
	mov	di, 5874h	;@0AA17
	mov	cx, 6	;@0AA1A
	repne scasw	;@0AA1D
	mov	es, bx	;@0AA1F
	je	L0AA26	;@0AA21
@@1:	xor	al, al	;@0AA23
L0AA25:	ret	;@0AA25
L0AA26:	add	si, 2	;@0AA26
	mov	bx, 5	;@0AA29
	sub	bx, cx	;@0AA2C
	shl	bx, 1	;@0AA2E
	jmp	word ptr [bx+1F3Eh]	;@0AA30
L0AA34:	push	es	;@0AA34
	call	L0AA8E	;@0AA35
	pop	ax	;@0AA38
	je	@@1	;@0AA39
	call	L0AF49	;@0AA3B
@@1:	call	L05E6B	;@0AA3E
	jmp	L0AA0E	;@0AA41
L0AA43:	push	es	;@0AA43
	call	L0AA8E	;@0AA44
	pop	ax	;@0AA47
	je	@@1	;@0AA48
	call	L0AF49	;@0AA4A
@@1:	call	L05E7D	;@0AA4D
	jmp	L0AA0E	;@0AA50
L0AA52:	push	es	;@0AA52
	call	L0AA8E	;@0AA53
	pop	ax	;@0AA56
	je	@@1	;@0AA57
	call	L0AF49	;@0AA59
@@1:	call	L05E8F	;@0AA5C
	jmp	L0AA0E	;@0AA5F
L0AA61:	push	es	;@0AA61
	call	L0AA8E	;@0AA62
	pop	ax	;@0AA65
	je	@@1	;@0AA66
	call	L0AF49	;@0AA68
@@1:	call	L05EA1	;@0AA6B
	jmp	L0AA0E	;@0AA6E
L0AA70:	push	es	;@0AA70
	call	L0AA8E	;@0AA71
	pop	ax	;@0AA74
	je	@@1	;@0AA75
	call	L0AF49	;@0AA77
@@1:	call	L05EB3	;@0AA7A
	jmp	L0AA0E	;@0AA7D
L0AA7F:	push	es	;@0AA7F
	call	L0AA8E	;@0AA80
	pop	ax	;@0AA83
	je	@@1	;@0AA84
	call	L0AF49	;@0AA86
@@1:	call	L05EC5	;@0AA89
	jmp	L0AA0E	;@0AA8C
L0AA8E:	call	L026B8	;@0AA8E
	jne	L0AACF	;@0AA91
L0AA93:	call	L0AAD5	;@0AA93
	jne	L0AACF	;@0AA96
@@1:	call	L026B8	;@0AA98
	jne	@@5	;@0AA9B
	cmp	ax, word ptr ds:[5880h]	;@0AA9D
	jne	@@3	;@0AAA1
	add	si, 2	;@0AAA3
	push	es	;@0AAA6
	call	L0AAD0	;@0AAA7
	pop	ax	;@0AAAA
	je	@@2	;@0AAAB
	call	L0AF49	;@0AAAD
@@2:	call	L05F2B	;@0AAB0
	jmp	@@1	;@0AAB3
@@3:	cmp	ax, word ptr ds:[5882h]	;@0AAB5
	jne	@@5	;@0AAB9
	add	si, 2	;@0AABB
	push	es	;@0AABE
	call	L0AAD0	;@0AABF
	pop	ax	;@0AAC2
	je	@@4	;@0AAC3
	call	L0AF49	;@0AAC5
@@4:	call	L06031	;@0AAC8
	jmp	@@1	;@0AACB
@@5:	xor	al, al	;@0AACD
L0AACF:	ret	;@0AACF
L0AAD0:	call	L026B8	;@0AAD0
	jne	L0AAF1	;@0AAD3
L0AAD5:	call	L0AB57	;@0AAD5
	jne	L0AB1E	;@0AAD8
L0AADA:	call	L026B8	;@0AADA
	jne	@@1	;@0AADD
	mov	bx, es	;@0AADF
	push	ss	;@0AAE1
	pop	es	;@0AAE2
	mov	di, 5884h	;@0AAE3
	mov	cx, 5	;@0AAE6
	repne scasw	;@0AAE9
	mov	es, bx	;@0AAEB
	je	L0AAF2	;@0AAED
@@1:	xor	al, al	;@0AAEF
L0AAF1:	ret	;@0AAF1
L0AAF2:	add	si, 2	;@0AAF2
	mov	bx, 4	;@0AAF5
	sub	bx, cx	;@0AAF8
	shl	bx, 1	;@0AAFA
	jmp	word ptr [bx+1F34h]	;@0AAFC
L0AB00:	push	es	;@0AB00
	call	L0AB4C	;@0AB01
	pop	ax	;@0AB04
	je	@@1	;@0AB05
	call	L0AF49	;@0AB07
@@1:	call	L06280	;@0AB0A
	jmp	L0AADA	;@0AB0D
L0AB0F:	push	es	;@0AB0F
	call	L0AB4C	;@0AB10
	pop	ax	;@0AB13
	je	@@1	;@0AB14
	call	L0AF49	;@0AB16
@@1:	call	L06391	;@0AB19
	jmp	L0AADA	;@0AB1C
L0AB1E:	ret	;@0AB1E
L0AB1F:	push	es	;@0AB1F
	call	L0AB4C	;@0AB20
	pop	ax	;@0AB23
	je	@@1	;@0AB24
	call	L0AF49	;@0AB26
@@1:	call	L063C8	;@0AB29
	jmp	L0AADA	;@0AB2C
L0AB2E:	push	es	;@0AB2E
	call	L0AB4C	;@0AB2F
	pop	ax	;@0AB32
	je	@@1	;@0AB33
	call	L0AF49	;@0AB35
@@1:	call	L0641B	;@0AB38
	jmp	L0AADA	;@0AB3B
L0AB3D:	push	es	;@0AB3D
	call	L0AB4C	;@0AB3E
	pop	ax	;@0AB41
	je	@@1	;@0AB42
	call	L0AF49	;@0AB44
@@1:	call	L0649E	;@0AB47
	jmp	L0AADA	;@0AB4A
L0AB4C:	test	word ptr ds:[5160h], 1000h	;@0AB4C
	jne	L0AB62	;@0AB52
	jmp	L0AD67	;@0AB54
L0AB57:	test	word ptr ds:[5160h], 1000h	;@0AB57
	jne	L0AB67	;@0AB5D
	jmp	L0AD6C	;@0AB5F
L0AB62:	call	L026B8	;@0AB62
	jne	L0AB78	;@0AB65
L0AB67:	cmp	ax, word ptr ds:[5880h]	;@0AB67
	jne	L0AB79	;@0AB6B
	add	si, 2	;@0AB6D
	call	L0AB62	;@0AB70
	je	L0AB78	;@0AB73
	jmp	L0AF49	;@0AB75
L0AB78:	ret	;@0AB78
L0AB79:	cmp	ax, word ptr ds:[5882h]	;@0AB79
	jne	@@2	;@0AB7D
	add	si, 2	;@0AB7F
	call	L0AB62	;@0AB82
	je	@@1	;@0AB85
	call	L0AF49	;@0AB87
@@1:	jmp	L0653B	;@0AB8A
@@2:	test	word ptr ds:[5160h], 1000h	;@0AB8D
	jne	@@4	;@0AB93
	jmp	L0AE47	;@0AB95
@@3:	call	L026B8	;@0AB98
	jne	@@8	;@0AB9B
@@4:	cmp	ax, word ptr ds:[5890h]	;@0AB9D
	jne	@@6	;@0ABA1
	add	si, 2	;@0ABA3
	call	@@3	;@0ABA6
	je	@@5	;@0ABA9
	call	L0AF49	;@0ABAB
@@5:	jmp	L06588	;@0ABAE
@@6:	cmp	ax, word ptr ds:[5892h]	;@0ABB1
	jne	@@9	;@0ABB5
	add	si, 2	;@0ABB7
	call	@@3	;@0ABBA
	je	@@7	;@0ABBD
	call	L0AF49	;@0ABBF
@@7:	jmp	L065DF	;@0ABC2
@@8:	ret	;@0ABC5
@@9:	push	ss	;@0ABC6
	pop	es	;@0ABC7
	mov	di, 5894h	;@0ABC8
	mov	cx, 9	;@0ABCB
	repne scasw	;@0ABCE
	je	L0ABF3	;@0ABD0
L0ABD2:	and	ah, ah	;@0ABD2
	je	@@3	;@0ABD4
	add	si, 2	;@0ABD6
	cmp	ax, word ptr ds:[583Ah]	;@0ABD9
	je	@@1	;@0ABDD
	cmp	ax, word ptr ds:[5842h]	;@0ABDF
	je	@@2	;@0ABE3
	jmp	L068C8	;@0ABE5
@@1:	jmp	L06836	;@0ABE8
@@2:	jmp	L05542	;@0ABEB
@@3:	xor	al, al	;@0ABEE
	dec	al	;@0ABF0
	ret	;@0ABF2
L0ABF3:	add	si, 2	;@0ABF3
	mov	bx, 8	;@0ABF6
	sub	bx, cx	;@0ABF9
	shl	bx, 1	;@0ABFB
	jmp	word ptr [bx+1F22h]	;@0ABFD
L0AC01:	call	L0A7D1	;@0AC01
	je	@@1	;@0AC04
	call	L0AF55	;@0AC06
@@1:	jmp	L06616	;@0AC09
L0AC0C:	call	L0A7D1	;@0AC0C
	je	@@1	;@0AC0F
	call	L0AF55	;@0AC11
@@1:	jmp	L066F2	;@0AC14
L0AC17:	call	L026B8	;@0AC17
	jne	L0AC3B	;@0AC1A
	mov	ax, dx	;@0AC1C
	call	L0066E	;@0AC1E
	je	L0AC3B	;@0AC21
	add	si, 2	;@0AC23
	jmp	L0675E	;@0AC26
L0AC29:	call	L026B8	;@0AC29
	jne	L0AC3B	;@0AC2C
	mov	ax, dx	;@0AC2E
	call	L0066E	;@0AC30
	je	L0AC3B	;@0AC33
	add	si, 2	;@0AC35
	jmp	L06787	;@0AC38
L0AC3B:	sub	si, 2	;@0AC3B
	call	L026B8	;@0AC3E
	add	si, 2	;@0AC41
	jmp	L068C8	;@0AC44
L0AC47:	call	L026B8	;@0AC47
	jne	L0AC3B	;@0AC4A
	mov	ax, dx	;@0AC4C
	call	L0066E	;@0AC4E
	je	L0AC3B	;@0AC51
	add	si, 2	;@0AC53
	jmp	L067B5	;@0AC56
L0AC59:	call	L026B8	;@0AC59
	jne	L0AC3B	;@0AC5C
	mov	ax, dx	;@0AC5E
	call	L0066E	;@0AC60
	je	L0AC3B	;@0AC63
	add	si, 2	;@0AC65
	jmp	L067E2	;@0AC68
L0AC6B:	call	L0A8B8	;@0AC6B
	je	@@1	;@0AC6E
	mov	cx, 7	;@0AC70
	call	L0AF69	;@0AC73
	call	L05590	;@0AC76
@@1:	jmp	L0683F	;@0AC79
	db	3Bh, 26h, 0D4h, '8rB', 0E8h, 4Ch, 0FBh, 74h, 3, 0E8h, 0CBh, 2	;@0AC7C
	db	0E8h, '+zu', 0Bh, 3Bh, 6, '0Xu', 5, 83h, 0C6h, 2, 0EBh, 3, 0E8h
	db	0C4h, 2, 0E9h, 0ABh, 0ABh, 3Bh, 26h, 0D4h, 38h, 72h, 1Eh, 0E8h
	db	28h, 0FBh, 74h, 3, 0E8h, 9Bh, 2, 0E8h, 7, 7Ah, 75h, 0Bh, 3Bh, 6
	db	'6Xu', 5, 83h, 0C6h, 2, 0EBh, 3, 0E8h, 0A5h, 2, 32h, 0C0h, 0C3h
	db	0B9h, 75h, 40h, 0E9h, 3Eh, 85h
L0ACCA:	call	L026B8	;@0ACCA
	jne	@@5	;@0ACCD
	and	ah, ah	;@0ACCF
	je	@@3	;@0ACD1
	add	si, 2	;@0ACD3
	push	ax	;@0ACD6
	push	dx	;@0ACD7
	call	L026B8	;@0ACD8
	jne	@@1	;@0ACDB
	cmp	ax, word ptr ds:[5838h]	;@0ACDD
	je	@@1	;@0ACE1
	cmp	ax, word ptr ds:[5830h]	;@0ACE3
	je	@@1	;@0ACE7
	cmp	ax, word ptr ds:[5836h]	;@0ACE9
	jne	@@2	;@0ACED
@@1:	sub	si, 2	;@0ACEF
	pop	dx	;@0ACF2
	pop	ax	;@0ACF3
	jmp	L0ABD2	;@0ACF4
@@2:	sub	si, 2	;@0ACF7
	pop	dx	;@0ACFA
	pop	ax	;@0ACFB
@@3:	cmp	ax, word ptr ds:[5864h]	;@0ACFC
	je	@@6	;@0AD00
	cmp	ax, word ptr ds:[5862h]	;@0AD02
	je	@@8	;@0AD06
	test	word ptr ds:[5160h], 8	;@0AD08
	je	@@4	;@0AD0E
	cmp	ax, word ptr ds:[5866h]	;@0AD10
	je	@@10	;@0AD14
	cmp	ax, word ptr ds:[5868h]	;@0AD16
	je	@@12	;@0AD1A
@@4:	jmp	L0A988	;@0AD1C
@@5:	ret	;@0AD1F
@@6:	add	si, 2	;@0AD20
	call	L0ACCA	;@0AD23
	je	@@7	;@0AD26
	call	L0AF49	;@0AD28
@@7:	jmp	L058B0	;@0AD2B
@@8:	add	si, 2	;@0AD2E
	mov	al, byte ptr ds:[38DAh]	;@0AD31
	push	ax	;@0AD34
	mov	byte ptr ds:[38DAh], 0FFh	;@0AD35
	call	L0ACCA	;@0AD3A
	pop	ax	;@0AD3D
	mov	byte ptr ds:[38DAh], 0	;@0AD3E
	je	@@9	;@0AD43
	call	L0AF49	;@0AD45
@@9:	jmp	L05D2E	;@0AD48
@@10:	add	si, 2	;@0AD4B
	call	L0ACCA	;@0AD4E
	je	@@11	;@0AD51
	call	L0AF49	;@0AD53
@@11:	jmp	L0587C	;@0AD56
@@12:	add	si, 2	;@0AD59
	call	L0ACCA	;@0AD5C
	je	@@13	;@0AD5F
	call	L0AF49	;@0AD61
@@13:	jmp	L05896	;@0AD64
L0AD67:	call	L026B8	;@0AD67
	jne	L0AD8A	;@0AD6A
L0AD6C:	push	ss	;@0AD6C
	pop	es	;@0AD6D
	mov	di, 588Eh	;@0AD6E
	mov	cx, 6	;@0AD71
	repne scasw	;@0AD74
	je	L0AD8B	;@0AD76
	call	L0AE21	;@0AD78
	jne	L0AD8A	;@0AD7B
	call	L026B8	;@0AD7D
	jne	@@1	;@0AD80
	cmp	ax, word ptr ds:[5844h]	;@0AD82
	je	L0AD99	;@0AD86
@@1:	xor	al, al	;@0AD88
L0AD8A:	ret	;@0AD8A
L0AD8B:	add	si, 2	;@0AD8B
	mov	bx, 5	;@0AD8E
	sub	bx, cx	;@0AD91
	shl	bx, 1	;@0AD93
	jmp	word ptr [bx+1F16h]	;@0AD95
L0AD99:	add	si, 2	;@0AD99
	push	es	;@0AD9C
	call	L0ADEB	;@0AD9D
	pop	ax	;@0ADA0
	je	@@1	;@0ADA1
	call	L0AF49	;@0ADA3
@@1:	jmp	L0594A	;@0ADA6
L0ADA9:	call	L0ADEB	;@0ADA9
	je	@@1	;@0ADAC
	call	L0AF49	;@0ADAE
@@1:	jmp	L06585	;@0ADB1
L0ADB4:	call	L0ADEB	;@0ADB4
	je	@@1	;@0ADB7
	call	L0AF49	;@0ADB9
@@1:	jmp	L065DC	;@0ADBC
L0ADBF:	call	L0ADEB	;@0ADBF
	je	@@1	;@0ADC2
	call	L0AF49	;@0ADC4
@@1:	jmp	L0661F	;@0ADC7
L0ADCA:	call	L0ADEB	;@0ADCA
	je	@@1	;@0ADCD
	call	L0AF49	;@0ADCF
@@1:	jmp	L066DF	;@0ADD2
L0ADD5:	call	L0ADEB	;@0ADD5
	je	@@1	;@0ADD8
	call	L0AF49	;@0ADDA
@@1:	jmp	L0680F	;@0ADDD
L0ADE0:	call	L0ADEB	;@0ADE0
	je	@@1	;@0ADE3
	call	L0AF49	;@0ADE5
@@1:	jmp	L05741	;@0ADE8
L0ADEB:	call	L026B8	;@0ADEB
	jne	@@4	;@0ADEE
	and	ah, ah	;@0ADF0
	je	@@3	;@0ADF2
	add	si, 2	;@0ADF4
	push	ax	;@0ADF7
	push	dx	;@0ADF8
	call	L026B8	;@0ADF9
	jne	@@1	;@0ADFC
	cmp	ax, word ptr ds:[5838h]	;@0ADFE
	je	@@1	;@0AE02
	cmp	ax, word ptr ds:[5830h]	;@0AE04
	je	@@1	;@0AE08
	cmp	ax, word ptr ds:[5836h]	;@0AE0A
	jne	@@2	;@0AE0E
@@1:	sub	si, 2	;@0AE10
	pop	dx	;@0AE13
	pop	ax	;@0AE14
	jmp	L0ABD2	;@0AE15
@@2:	sub	si, 2	;@0AE18
	pop	dx	;@0AE1B
	pop	ax	;@0AE1C
@@3:	jmp	L0AD6C	;@0AE1D
@@4:	ret	;@0AE20
L0AE21:	call	L0AB67	;@0AE21
	jne	@@5	;@0AE24
@@1:	call	L026B8	;@0AE26
	jne	@@2	;@0AE29
	cmp	ax, word ptr ds:[5808h]	;@0AE2B
	je	@@3	;@0AE2F
@@2:	xor	al, al	;@0AE31
	ret	;@0AE33
@@3:	add	si, 2	;@0AE34
	push	es	;@0AE37
	call	L0AB62	;@0AE38
	pop	ax	;@0AE3B
	je	@@4	;@0AE3C
	call	L0AF49	;@0AE3E
@@4:	call	L05BB2	;@0AE41
	jmp	@@1	;@0AE44
@@5:	ret	;@0AE46
L0AE47:	call	@@8	;@0AE47
	jne	@@7	;@0AE4A
@@1:	call	L026B8	;@0AE4C
	jne	@@2	;@0AE4F
	cmp	ax, word ptr ds:[5834h]	;@0AE51
	je	@@5	;@0AE55
	cmp	ax, word ptr ds:[589Ah]	;@0AE57
	je	@@3	;@0AE5B
	cmp	ax, word ptr ds:[589Ch]	;@0AE5D
	je	@@3	;@0AE61
@@2:	xor	al, al	;@0AE63
	ret	;@0AE65
@@3:	push	es	;@0AE66
	call	@@8	;@0AE67
	pop	ax	;@0AE6A
	je	@@4	;@0AE6B
	mov	es, ax	;@0AE6D
	jmp	@@2	;@0AE6F
@@4:	call	L05F2B	;@0AE71
	jmp	@@1	;@0AE74
@@5:	add	si, 2	;@0AE76
	push	es	;@0AE79
	call	L0ADEB	;@0AE7A
	pop	ax	;@0AE7D
	je	@@6	;@0AE7E
	call	L0AF49	;@0AE80
@@6:	call	L05F2B	;@0AE83
	jmp	L058BC	;@0AE86
@@7:	ret	;@0AE89
@@8:	push	ss	;@0AE8A
	pop	es	;@0AE8B
	mov	di, 589Ah	;@0AE8C
	mov	cx, 6	;@0AE8F
	repne scasw	;@0AE92
	je	@@9	;@0AE94
	jmp	L0ABD2	;@0AE96
@@9:	add	si, 2	;@0AE99
	mov	bx, 5	;@0AE9C
	sub	bx, cx	;@0AE9F
	shl	bx, 1	;@0AEA1
	jmp	word ptr [bx+1F0Ah]	;@0AEA3
	db	3Bh, 26h, 0D4h, 38h, 72h, 1Eh, 0E8h, 1Ah, 0FEh, 74h, 3, 0E8h, 94h	;@0AEA7
	db	0, 0E8h, 0, 78h, 75h, 0Bh, 3Bh, 6, '0Xu', 5, 83h, 0C6h, 2, 0EBh
	db	3, 0E8h, 99h, 0, 0E9h, 0Ch, 0A9h, 0B9h, 75h, 40h, 0E9h, 37h, 83h
	db	3Bh, 26h, 0D4h, 38h, 72h, 0F4h, 0E8h, 0F0h, 0FDh, 74h, 3, 0E8h
	db	6Ah, 0, 0E8h, 0D6h, 77h, 75h, 0Bh, 3Bh, 6, '6Xu', 5, 83h, 0C6h
	db	2, 0EBh, 3, 0E8h, 74h, 0, 32h, 0C0h, 0C3h
L0AEF5:	call	L026B8	;@0AEF5
	jne	L0AF07	;@0AEF8
	mov	ax, dx	;@0AEFA
	call	L0066E	;@0AEFC
	je	L0AF07	;@0AEFF
	add	si, 2	;@0AF01
	jmp	L06787	;@0AF04
L0AF07:	sub	si, 2	;@0AF07
	call	L026B8	;@0AF0A
	add	si, 2	;@0AF0D
	jmp	L068C8	;@0AF10
L0AF13:	call	L026B8	;@0AF13
	jne	L0AF07	;@0AF16
	mov	ax, dx	;@0AF18
	call	L0066E	;@0AF1A
	je	L0AF07	;@0AF1D
	add	si, 2	;@0AF1F
	jmp	L067E2	;@0AF22
L0AF25:	call	L026B8	;@0AF25
	jne	L0AF07	;@0AF28
	mov	ax, dx	;@0AF2A
	call	L0066E	;@0AF2C
	je	L0AF07	;@0AF2F
	add	si, 2	;@0AF31
	jmp	L0675E	;@0AF34
L0AF37:	call	L026B8	;@0AF37
	jne	L0AF07	;@0AF3A
	mov	ax, dx	;@0AF3C
	call	L0066E	;@0AF3E
	je	L0AF07	;@0AF41
	add	si, 2	;@0AF43
	jmp	L067B5	;@0AF46
L0AF49:	mov	cx, 2	;@0AF49
	call	L0AF69	;@0AF4C
	push	ax	;@0AF4F
	call	L05542	;@0AF50
	pop	ax	;@0AF53
	ret	;@0AF54
L0AF55:	mov	cx, 3	;@0AF55
	call	L0AF69	;@0AF58
	push	ax	;@0AF5B
	call	L05590	;@0AF5C
	pop	ax	;@0AF5F
	ret	;@0AF60
	db	0B9h, 1, 0, 0EBh, 3, 0B9h, 0, 0	;@0AF61
L0AF69:	cmp	byte ptr ds:[38D9h], 0	;@0AF69
	jne	@@1	;@0AF6E
	jmp	L03208	;@0AF70
@@1:	and	byte ptr ds:[38D8h], 0FEh	;@0AF73
	stc	;@0AF78
	mov	sp, word ptr ds:[38BCh]	;@0AF79
	ret	;@0AF7D
L0AF7E:	mov	es, ax	;@0AF7E
	call	L026B8	;@0AF80
	jne	@@1	;@0AF83
	cmp	ax, word ptr ds:[573Eh]	;@0AF85
	je	@@2	;@0AF89
@@1:	ret	;@0AF8B
@@2:	add	si, 2	;@0AF8C
	push	word ptr ds:[569Eh]	;@0AF8F
	mov	word ptr ds:[569Eh], si	;@0AF93
	mov	si, 0B49Dh	;@0AF97
	call	L00BF4	;@0AF9A
	mov	si, word ptr ds:[569Eh]	;@0AF9D
	pop	word ptr ds:[569Eh]	;@0AFA1
	push	ax	;@0AFA5
	push	dx	;@0AFA6
	call	L026B8	;@0AFA7
	jne	@@4	;@0AFAA
	cmp	ax, word ptr ds:[5740h]	;@0AFAC
	jne	@@5	;@0AFB0
	add	si, 2	;@0AFB2
	xor	al, al	;@0AFB5
@@3:	pop	dx	;@0AFB7
	pop	ax	;@0AFB8
	ret	;@0AFB9
@@4:	mov	cx, 9	;@0AFBA
	jmp	short @@6	;@0AFBD
@@5:	mov	cx, 52h	;@0AFBF
@@6:	call	L03208	;@0AFC2
	xor	al, al	;@0AFC5
	jmp	@@3	;@0AFC7
	db	33h, 0D2h, 0A3h, 0A8h, 56h, 0A3h, 94h, 56h, 50h, 0E8h, 2, 'I[u7'	;@0AFC9
	db	0E8h, 15h, 86h, 8Bh, 0C3h, 0C7h, 6, 0ACh, 56h, 0B8h, 26h, 0E8h
	db	'9Xt*;', 6, 94h, 51h, 75h, 0Ah, 23h, 0C0h, 74h, 6, 0B9h, 49h, 0
	db	0E9h, 10h, 82h, 0C7h, 6, 0AAh, 56h, 36h, 0B4h, 0C7h, 6, 0AEh, 56h
	db	4Ch, 0B3h, 0C7h, 6, 0B4h, 56h, 0, 0, 0B0h, 0Ah, 0E9h, 95h, 0, 0E9h
	db	4Ah, 76h, 0C7h, 6, 0A8h, 56h, 0, 0, 8Eh, 0C0h, 52h, 0E8h, '(\Z'
	db	89h, 2Eh, 0B4h, 56h, 0C7h, 6, 0AAh, 56h, 0CDh, 0B3h, 0C7h, 6, 0AEh
	db	56h, 3Dh, 0B3h, 8Ah, 0C3h, 24h, 0Fh, 0EBh, 6Fh
L0B035:	xor	dx, dx	;@0B035
	mov	al, 1	;@0B037
	jmp	short L0B059	;@0B039
L0B03B:	xor	dx, dx	;@0B03B
	mov	al, 2	;@0B03D
	jmp	short L0B059	;@0B03F
L0B041:	xor	dx, dx	;@0B041
	mov	al, 3	;@0B043
	jmp	short L0B077	;@0B045
L0B047:	xor	dx, dx	;@0B047
	mov	al, 4	;@0B049
	jmp	short L0B077	;@0B04B
L0B04D:	xor	dx, dx	;@0B04D
	mov	al, 5	;@0B04F
	jmp	short L0B059	;@0B051
L0B053:	xor	dx, dx	;@0B053
	mov	al, 6	;@0B055
	jmp	short L0B077	;@0B057
L0B059:	xor	cx, cx	;@0B059
	mov	word ptr ds:[56A8h], cx	;@0B05B
	mov	word ptr ds:[56B4h], cx	;@0B05F
	mov	word ptr ds:[56ACh], 26B8h	;@0B063
	mov	word ptr ds:[56AAh], 0B369h	;@0B069
	mov	word ptr ds:[56AEh], 0B33Dh	;@0B06F
	jmp	short L0B0A4	;@0B075
L0B077:	xor	cx, cx	;@0B077
	mov	word ptr ds:[56A8h], cx	;@0B079
	mov	word ptr ds:[56B4h], cx	;@0B07D
	and	dx, dx	;@0B081
	jne	@@1	;@0B083
	test	word ptr ds:[5160h], 1000h	;@0B085
	jne	@@1	;@0B08B
	push	ax	;@0B08D
	call	L0F856	;@0B08E
	pop	ax	;@0B091
@@1:	mov	word ptr ds:[56ACh], 0B318h	;@0B092
	mov	word ptr ds:[56AAh], 0B369h	;@0B098
	mov	word ptr ds:[56AEh], 0B33Dh	;@0B09E
L0B0A4:	or	byte ptr ds:[38D8h], 8	;@0B0A4
	or	al, 20h	;@0B0A9
	mov	byte ptr ds:[56B6h], al	;@0B0AB
	and	dx, dx	;@0B0AE
	je	@@1	;@0B0B0
	call	L00692	;@0B0B2
@@1:	mov	word ptr ds:[5692h], dx	;@0B0B5
	call	L0F8D7	;@0B0B9
	jne	@@4	;@0B0BC
	cmp	word ptr ds:[5194h], 0	;@0B0BE
	jne	@@5	;@0B0C3
	cmp	word ptr ds:[5692h], 0	;@0B0C5
	je	@@3	;@0B0CA
	mov	es, word ptr ds:[5692h]	;@0B0CC
	mov	ax, word ptr ds:[56A8h]	;@0B0D0
	mov	bl, byte ptr ds:[56B6h]	;@0B0D3
	call	L0109C	;@0B0D7
	jne	@@2	;@0B0DA
	call	L011AE	;@0B0DC
	push	word ptr ds:[5154h]	;@0B0DF
	push	word ptr ds:[5156h]	;@0B0E3
	call	@@8	;@0B0E7
	call	L0B2A0	;@0B0EA
	mov	es, word ptr ds:[5692h]	;@0B0ED
	pop	dx	;@0B0F1
	pop	ax	;@0B0F2
	call	L034E8	;@0B0F3
	jmp	L0F83A	;@0B0F6
@@2:	mov	word ptr ds:[5692h], 0	;@0B0F9
@@3:	call	@@8	;@0B0FF
	jmp	L0F83A	;@0B102
@@4:	jmp	L0265C	;@0B105
@@5:	cmp	word ptr ds:[5692h], 0	;@0B108
	je	@@6	;@0B10D
	mov	es, word ptr ds:[5194h]	;@0B10F
	mov	dx, word ptr ds:[56A8h]	;@0B113
	mov	ax, word ptr ds:[5692h]	;@0B117
	mov	bl, byte ptr ds:[56B6h]	;@0B11A
	call	L00D3D	;@0B11E
	test	word ptr ds:[5160h], 1000h	;@0B121
	jne	@@6	;@0B127
	mov	es, word ptr ds:[5692h]	;@0B129
	call	L00A11	;@0B12D
	jne	@@6	;@0B130
	call	L035AC	;@0B132
	mov	bl, byte ptr ds:[56B6h]	;@0B135
	mov	cx, word ptr ds:[56A8h]	;@0B139
	call	L00A29	;@0B13D
@@6:	push	word ptr ds:[5154h]	;@0B140
	push	word ptr ds:[5156h]	;@0B144
	mov	ax, 1	;@0B148
	xor	cx, cx	;@0B14B
	call	L03BDD	;@0B14D
	call	@@8	;@0B150
	call	L03C72	;@0B153
	call	L03AA4	;@0B156
	call	L0B2A0	;@0B159
	mov	cx, word ptr ds:[5692h]	;@0B15C
	pop	dx	;@0B160
	pop	ax	;@0B161
	call	L03493	;@0B162
	mov	al, byte ptr ds:[38D8h]	;@0B165
	test	al, 1	;@0B168
	je	@@7	;@0B16A
	and	byte ptr ds:[38D8h], 0FEh	;@0B16C
	mov	cx, 2Dh	;@0B171
	call	L03208	;@0B174
@@7:	jmp	L0F83A	;@0B177
@@8:	call	@@10	;@0B17A
	mov	ax, word ptr ds:[5692h]	;@0B17D
	and	ax, ax	;@0B180
	je	@@9	;@0B182
	mov	es, ax	;@0B184
	mov	ax, word ptr ds:[5696h]	;@0B186
	mov	dx, word ptr ds:[5698h]	;@0B189
	mov	cx, word ptr ds:[569Ah]	;@0B18D
	mov	di, word ptr ds:[569Ch]	;@0B191
	jmp	L0125C	;@0B195
@@9:	ret	;@0B198
@@10:	call	@@13	;@0B199
	push	word ptr ds:[5696h]	;@0B19C
	push	word ptr ds:[5698h]	;@0B1A0
	push	word ptr ds:[569Ah]	;@0B1A4
	push	word ptr ds:[569Ch]	;@0B1A8
	push	word ptr ds:[56B2h]	;@0B1AC
	push	word ptr ds:[56B0h]	;@0B1B0
@@11:	call	L026B8	;@0B1B4
	jne	@@12	;@0B1B7
	cmp	ax, word ptr ds:[5838h]	;@0B1B9
	jne	@@12	;@0B1BD
	add	si, 2	;@0B1BF
	call	@@13	;@0B1C2
	jmp	@@11	;@0B1C5
@@12:	xor	al, al	;@0B1C7
	pop	word ptr ds:[56B0h]	;@0B1C9
	pop	word ptr ds:[56B2h]	;@0B1CD
	pop	word ptr ds:[569Ch]	;@0B1D1
	pop	word ptr ds:[569Ah]	;@0B1D5
	pop	word ptr ds:[5698h]	;@0B1D9
	pop	word ptr ds:[5696h]	;@0B1DD
	ret	;@0B1E1
@@13:	call	word ptr ds:[56ACh]	;@0B1E2
	jne	L0B20D	;@0B1E6
	cmp	ax, word ptr ds:[5742h]	;@0B1E8
	jne	L0B218	;@0B1EC
	add	si, 2	;@0B1EE
	call	L026B8	;@0B1F1
	jne	L0B202	;@0B1F4
	cmp	ax, word ptr ds:[5838h]	;@0B1F6
	je	L0B202	;@0B1FA
	cmp	ax, word ptr ds:[5836h]	;@0B1FC
	jne	L0B215	;@0B200
L0B202:	call	word ptr ds:[56AEh]	;@0B202
	mov	byte ptr ds:[56B3h], 0	;@0B206
	jmp	short L0B21F	;@0B20B
L0B20D:	mov	cx, 8084h	;@0B20D
	call	L03208	;@0B210
	jmp	L0B202	;@0B213
L0B215:	sub	si, 2	;@0B215
L0B218:	call	word ptr ds:[56AAh]	;@0B218
	jne	L0B202	;@0B21C
	ret	;@0B21E
L0B21F:	mov	word ptr ds:[5696h], ax	;@0B21F
	mov	word ptr ds:[5698h], cx	;@0B222
	mov	word ptr ds:[569Ah], 1	;@0B226
	mov	word ptr ds:[569Ch], 0	;@0B22C
	ret	;@0B232
	db	3Bh, 26h, 0D4h, '8r ', 83h, 0C6h, 2, 0E8h, 0E8h, 0C4h, 0A3h, 9Ah	;@0B233
	db	56h, 89h, 0Eh, 9Ch, 56h, 0E8h, 94h, 89h, 0E8h, 'ltu', 11h, 3Bh
	db	6, 9Ch, 58h, 75h, 0Bh, 83h, 0C6h, 2, 0EBh, 0Ch, 0B9h, 75h, 40h
	db	0E9h, 0A9h, 7Fh, 0B9h, 5, 0, 0E8h, 0A3h, 7Fh, 0FFh, 36h, 9Ah, 56h
	db	0FFh, 36h, 9Ch, 56h, 0E8h, 29h, 0FFh, 8Fh, 6, 9Ch, 56h, 8Fh, 6
	db	9Ah, 56h, 0E8h, '=tu', 0Bh, 3Bh, 6, '6Xu', 5, 83h, 0C6h, 2, 0EBh
	db	6, 0B9h, 0, 0, 0E8h, 7Ah, 7Fh, 0A1h, 54h, 51h, 0A3h, 96h, 56h
	db	0A1h, 56h, 51h, 0A3h, 98h, 56h, 0E8h, 0D5h, 89h, 32h, 0C0h, 0C3h
L0B2A0:	mov	bl, byte ptr ds:[56B3h]	;@0B2A0
	xor	bh, bh	;@0B2A4
	shl	bx, 1	;@0B2A6
	call	word ptr [bx+1F94h]	;@0B2A8
	mov	ax, word ptr ds:[569Ah]	;@0B2AC
	mov	dx, word ptr ds:[569Ch]	;@0B2AF
	cmp	ax, 1	;@0B2B3
	jne	L0B2D3	;@0B2B6
	and	dx, dx	;@0B2B8
	jne	L0B2D3	;@0B2BA
	cmp	byte ptr ds:[56B6h], 21h	;@0B2BC
	je	@@1	;@0B2C1
	ret	;@0B2C3
@@1:	cmp	word ptr ds:[5696h], 1	;@0B2C4
	jne	L0B2D3	;@0B2C9
	cmp	word ptr ds:[5698h], 0	;@0B2CB
	jne	L0B2D3	;@0B2D0
L0B2D2:	ret	;@0B2D2
L0B2D3:	mov	bp, word ptr ds:[5696h]	;@0B2D3
	mov	cx, word ptr ds:[5698h]	;@0B2D7
	jmp	L03606	;@0B2DB
L0B2DE:	mov	bx, word ptr ds:[56B4h]	;@0B2DE
	and	bx, bx	;@0B2E2
	jne	L0B2D2	;@0B2E4
	mov	bl, byte ptr ds:[56B6h]	;@0B2E6
	mov	ax, word ptr ds:[56A8h]	;@0B2EA
	jmp	L004D3	;@0B2ED
L0B2F0:	mov	bl, byte ptr ds:[56B2h]	;@0B2F0
	mov	ax, word ptr ds:[56B0h]	;@0B2F4
	jmp	L00531	;@0B2F7
L0B2FA:	mov	bl, byte ptr ds:[56B2h]	;@0B2FA
	mov	ax, word ptr ds:[56B0h]	;@0B2FE
	jmp	L00575	;@0B301
L0B304:	mov	bl, byte ptr ds:[56B2h]	;@0B304
	mov	ax, word ptr ds:[56B0h]	;@0B308
	jmp	L005B9	;@0B30B
L0B30E:	mov	bl, byte ptr ds:[56B2h]	;@0B30E
	mov	ax, word ptr ds:[56B0h]	;@0B312
	jmp	L005FD	;@0B315
	db	0F7h, 6, 60h, 51h, 0, 10h, 74h, 3, 0E9h, 95h, 73h, 0E8h, 'gju'	;@0B318
	db	14h, 'VP"', 0E4h, 75h, 0Ah, 0E8h, '\ju', 7, 83h, 0C6h, 2, 0EBh
	db	0F2h, 32h, 0C0h, 58h, 5Eh, 0C3h, 8Ah, 1Eh, 0B6h, 56h, 80h, 0EBh
	db	21h, 32h, 0FFh, 0D1h, 0E3h, 0FFh, 0A7h, 72h, 1Fh, 8Eh, 6, 94h
	db	56h, 0E8h, 86h, 59h, 0E8h, 0BCh, 7Eh, 8Bh, 0CAh, 50h, 51h, 0E8h
	db	80h, 88h, 0B8h, 1, 0, 0E8h, 0A7h, 8Eh, 0E8h, 0Ch, 89h, 59h, 58h
	db	0C3h, 0FFh, '6`Q', 83h, 0Eh, 60h, 51h, 8, 0E8h, 3Bh, 0F4h, 8Fh
	db	6, '`Qu.', 0E8h, ':su', 6, 3Bh, 6, '2XtD', 0F6h, 6, 6Ah, 51h, 80h
	db	75h, 1Dh, 8Ah, 1Eh, 0B6h, 56h, 80h, 0EBh, 21h, 32h, 0FFh, 0D1h
	db	0E3h, 0FFh, 97h, 66h, 1Fh, 33h, 0C9h, 89h, 1Eh, 0B2h, 56h, 89h
	db	3Eh, 0B0h, 56h, 0E9h, 76h, 0FEh, 0C3h, 83h, 3Eh, 94h, 51h, 0, 75h
	db	0DCh, 0A1h, 'bQ;', 6, 'rWu', 0D3h, 0F7h, 6, 66h, 51h, 0, 40h, 74h
	db	0CBh, 0B9h, 7Fh, 80h, 0E8h, 40h, 7Eh, 0EBh, 0C3h, 0E9h, 66h, 0FEh
	db	0C6h, 6, 0B3h, 56h, 0, 0E8h, 0E3h, 'ru1;', 6, '>Wu9', 83h, 0C6h
	db	2, 89h, 36h, 9Eh, 56h, 0BEh, 9Dh, 0B4h, 8Eh, 6, 94h, 56h, 0E8h
	db	6, 58h, 0E8h, 0ABh, 0A1h, 8Bh, 36h, 9Eh, 56h, 0E8h, 0C0h, 72h
	db	75h, 14h, 3Bh, 6, '@Wu', 9, 83h, 0C6h, 2, 0E8h, 80h, 0FFh, 32h
	db	0C0h, 0C3h, 0B9h, 52h, 0, 0EBh, 3, 0B9h, 9, 0, 0E8h, 0F4h, 7Dh
	db	0EBh, 0EDh, 0E8h, 97h, 0F3h, 75h, 0EDh, 0E8h, 9Ah, 72h, 75h, 9
	db	3Bh, 6, '2Xu', 3, 0E9h, 0Ah, 0FEh, 0B9h, 4Dh, 0, 0E8h, 0D9h, 7Dh
	db	33h, 0C0h, 33h, 0C9h, 0E9h, 0E9h, 0FDh, 0C6h, 6, 0B3h, 56h, 0
	db	0E8h, 'zru\;', 6, '>Wu', 0D0h, 83h, 0C6h, 2, 89h, 36h, 9Eh, 56h
	db	8Eh, 6, 94h, 56h, 0A1h, 54h, 51h, 0A3h, 9Ah, 56h, 0A1h, 56h, 51h
	db	0A3h, 9Ch, 56h, 0E8h, 38h, 82h, 0E8h, 76h, 58h, 0BEh, 9Eh, 1Fh
	db	8Eh, 0C0h, 0E8h, 33h, 7Eh, 0A3h, 96h, 56h, 89h, 16h, 98h, 56h
	db	0E8h, 6Fh, 0, 8Bh, 36h, 9Eh, 56h, 0E8h, '<ru', 13h, 3Bh, 6, '@Wu'
	db	8, 83h, 0C6h, 2, 32h, 0C0h, 0E9h, 9Ah, 0FDh, 0B9h, 52h, 0, 0EBh
	db	3, 0B9h, 9, 0, 0E8h, 'q}2', 0C0h, 0E9h, 8Ah, 0FDh, 0C3h
L0B49D:	push	ax	;@0B49D
	push	dx	;@0B49E
	mov	si, word ptr ds:[569Eh]	;@0B49F
	call	L026B8	;@0B4A3
	jne	L0B4D6	;@0B4A6
	cmp	ax, word ptr ds:[5740h]	;@0B4A8
	je	L0B4D6	;@0B4AC
	cmp	ax, word ptr ds:[5838h]	;@0B4AE
	je	L0B4E0	;@0B4B2
	cmp	ax, word ptr ds:[5742h]	;@0B4B4
	je	L0B4DD	;@0B4B8
	call	L0A7B0	;@0B4BA
	jne	L0B4D6	;@0B4BD
	call	L076DE	;@0B4BF
	mov	dx, cx	;@0B4C2
	pop	cx	;@0B4C4
	pop	cx	;@0B4C5
L0B4C6:	push	ax	;@0B4C6
	push	dx	;@0B4C7
	call	L026B8	;@0B4C8
	jne	L0B4D6	;@0B4CB
	cmp	ax, word ptr ds:[5838h]	;@0B4CD
	jne	L0B4D6	;@0B4D1
	add	si, 2	;@0B4D3
L0B4D6:	pop	dx	;@0B4D6
	pop	ax	;@0B4D7
	mov	word ptr ds:[569Eh], si	;@0B4D8
	ret	;@0B4DC
L0B4DD:	add	si, 2	;@0B4DD
L0B4E0:	pop	dx	;@0B4E0
	pop	ax	;@0B4E1
	jmp	L0B4C6	;@0B4E2
L0B4E4:	add	ax, word ptr ds:[569Ah]	;@0B4E4
	add	dx, word ptr ds:[569Ch]	;@0B4E8
	sub	ax, word ptr ds:[5154h]	;@0B4EC
	sbb	dx, word ptr ds:[5156h]	;@0B4F0
	mov	cx, ax	;@0B4F4
	or	cx, dx	;@0B4F6
	jne	@@1	;@0B4F8
	ret	;@0B4FA
@@1:	mov	cx, dx	;@0B4FB
	call	L03BDD	;@0B4FD
	mov	ax, 1	;@0B500
	call	L0420A	;@0B503
	jmp	L03C72	;@0B506
L0B509:	mov	ax, word ptr ds:[5696h]	;@0B509
	mov	cx, word ptr ds:[5698h]	;@0B50C
	sub	ax, word ptr ds:[5154h]	;@0B510
	sbb	cx, word ptr ds:[5156h]	;@0B514
	jb	@@2	;@0B518
	mov	bx, ax	;@0B51A
	or	bx, cx	;@0B51C
	jne	@@1	;@0B51E
	ret	;@0B520
@@1:	push	es	;@0B521
	call	L03BDD	;@0B522
	mov	ax, 1	;@0B525
	call	L0420A	;@0B528
	call	L03C72	;@0B52B
	pop	es	;@0B52E
	xor	al, al	;@0B52F
	ret	;@0B531
@@2:	mov	cx, 4Fh	;@0B532
	call	L03208	;@0B535
	xor	al, al	;@0B538
	dec	al	;@0B53A
	ret	;@0B53C
L0B53D:	push	ax	;@0B53D
	push	cx	;@0B53E
	mov	si, word ptr ds:[569Eh]	;@0B53F
	call	L0A7B0	;@0B543
	mov	word ptr ds:[569Eh], si	;@0B546
	je	@@1	;@0B54A
	mov	cx, 2	;@0B54C
	call	L03208	;@0B54F
	call	L05542	;@0B552
@@1:	pop	cx	;@0B555
	pop	ax	;@0B556
	ret	;@0B557
	db	0F9h, 0C3h	;@0B558
L0B55A:	add	bx, word ptr ds:[569Ah]	;@0B55A
	adc	dx, word ptr ds:[569Ch]	;@0B55E
	mov	word ptr ds:[5696h], bx	;@0B562
	mov	word ptr ds:[5698h], dx	;@0B566
	mov	si, word ptr ds:[569Eh]	;@0B56A
	call	L026B8	;@0B56E
	jne	@@9	;@0B571
	cmp	ax, word ptr ds:[5740h]	;@0B573
	je	@@9	;@0B577
	cmp	ax, word ptr ds:[5838h]	;@0B579
	je	@@9	;@0B57D
	cmp	ax, word ptr ds:[5742h]	;@0B57F
	je	@@8	;@0B583
	cmp	ax, word ptr ds:[573Eh]	;@0B585
	jne	@@1	;@0B589
	add	si, 2	;@0B58B
	mov	word ptr ds:[569Eh], si	;@0B58E
	jmp	short @@2	;@0B592
@@1:	mov	cx, 4Dh	;@0B594
	call	L03208	;@0B597
@@2:	call	L0B509	;@0B59A
	jne	@@3	;@0B59D
	mov	si, 1F9Eh	;@0B59F
	call	L0329E	;@0B5A2
	call	L0B4E4	;@0B5A5
	jmp	short @@4	;@0B5A8
@@3:	mov	si, 1FDAh	;@0B5AA
	call	L0329E	;@0B5AD
@@4:	mov	si, word ptr ds:[569Eh]	;@0B5B0
	call	L026B8	;@0B5B4
	jne	@@6	;@0B5B7
	cmp	ax, word ptr ds:[5740h]	;@0B5B9
	jne	@@5	;@0B5BD
	add	si, 2	;@0B5BF
	jmp	short @@12	;@0B5C2
@@5:	mov	cx, 52h	;@0B5C4
	jmp	short @@7	;@0B5C7
@@6:	mov	cx, 9	;@0B5C9
@@7:	call	L03208	;@0B5CC
	jmp	short @@12	;@0B5CF
@@8:	add	si, 2	;@0B5D1
	jmp	short @@12	;@0B5D4
@@9:	push	es	;@0B5D6
	mov	si, 1FE4h	;@0B5D7
	call	L0329E	;@0B5DA
	pop	es	;@0B5DD
	jae	@@11	;@0B5DE
	call	L0B509	;@0B5E0
	jne	@@10	;@0B5E3
	mov	si, 1FC6h	;@0B5E5
	call	L0329E	;@0B5E8
	call	L0B4E4	;@0B5EB
	jmp	short @@11	;@0B5EE
@@10:	mov	si, 1FDAh	;@0B5F0
	call	L0329E	;@0B5F3
@@11:	mov	si, word ptr ds:[569Eh]	;@0B5F6
@@12:	call	L026B8	;@0B5FA
	jne	@@13	;@0B5FD
	cmp	ax, word ptr ds:[5838h]	;@0B5FF
	jne	@@13	;@0B603
	add	si, 2	;@0B605
@@13:	mov	word ptr ds:[569Eh], si	;@0B608
	clc	;@0B60C
	ret	;@0B60D
L0B60E:	add	bx, word ptr ds:[569Ah]	;@0B60E
	adc	dx, word ptr ds:[569Ch]	;@0B612
	mov	word ptr ds:[5696h], bx	;@0B616
	mov	word ptr ds:[5698h], dx	;@0B61A
	mov	si, word ptr ds:[569Eh]	;@0B61E
	call	L026B8	;@0B622
	jne	@@4	;@0B625
	cmp	ax, word ptr ds:[5740h]	;@0B627
	je	@@4	;@0B62B
	cmp	ax, word ptr ds:[5838h]	;@0B62D
	je	@@4	;@0B631
	cmp	ax, word ptr ds:[5742h]	;@0B633
	je	@@3	;@0B637
	call	L0B509	;@0B639
	jne	@@2	;@0B63C
	push	word ptr ds:[56A0h]	;@0B63E
	push	word ptr ds:[56A2h]	;@0B642
	mov	word ptr ds:[56A0h], 0	;@0B646
	mov	word ptr ds:[56A2h], 0	;@0B64C
	mov	si, 1FA8h	;@0B652
	call	L0329E	;@0B655
	cmp	word ptr ds:[56A2h], 0	;@0B658
	je	@@1	;@0B65D
	mov	cx, 50h	;@0B65F
	call	L03208	;@0B662
@@1:	pop	word ptr ds:[56A2h]	;@0B665
	pop	word ptr ds:[56A0h]	;@0B669
	jmp	short @@5	;@0B66D
@@2:	mov	si, 1FD0h	;@0B66F
	call	L0329E	;@0B672
	jmp	short @@5	;@0B675
@@3:	add	si, 2	;@0B677
	jmp	short @@6	;@0B67A
@@4:	push	es	;@0B67C
	mov	si, 1FE4h	;@0B67D
	call	L0329E	;@0B680
	pop	es	;@0B683
	jae	@@5	;@0B684
	call	L0B509	;@0B686
	jne	@@8	;@0B689
	mov	si, 1FBCh	;@0B68B
	call	L0329E	;@0B68E
@@5:	mov	si, word ptr ds:[569Eh]	;@0B691
@@6:	call	L026B8	;@0B695
	jne	@@7	;@0B698
	cmp	ax, word ptr ds:[5838h]	;@0B69A
	jne	@@7	;@0B69E
	add	si, 2	;@0B6A0
@@7:	mov	word ptr ds:[569Eh], si	;@0B6A3
	clc	;@0B6A7
@@8:	ret	;@0B6A8
	db	0FFh, 36h, 0A4h, 56h, 0FFh, 36h, 0A6h, 'VPQ3', 0C0h, 0A3h, 0A4h	;@0B6A9
	db	56h, 0A3h, 0A6h, 56h, 0BEh, 0B2h, 1Fh, 0E8h, 0DDh, '{_^', 8Bh
	db	1Eh, 0A4h, 56h, 8Bh, 0Eh, 0A6h, 56h, 0E8h, 0C7h, 93h, 5Ah, 58h
	db	3, 0C3h, 13h, 0D1h, 0A3h, 0A4h, 56h, 89h, 16h, 0A6h, 56h, 0C3h
	db	1, 0Eh, 0A4h, 56h, 83h, 16h, 0A4h, 56h, 0, 0C3h
L0B6E6:	cmp	word ptr ds:[56A2h], 0	;@0B6E6
	jne	@@2	;@0B6EB
	cmp	word ptr ds:[56A0h], 0	;@0B6ED
	jne	@@3	;@0B6F2
	push	ax	;@0B6F4
	push	cx	;@0B6F5
	push	es	;@0B6F6
	xor	ax, ax	;@0B6F7
	mov	word ptr ds:[56A4h], ax	;@0B6F9
	mov	word ptr ds:[56A6h], ax	;@0B6FC
	mov	si, 1FB2h	;@0B6FF
	call	L0329E	;@0B702
	call	L0B53D	;@0B705
	cmp	word ptr ds:[56A6h], 0	;@0B708
	jne	@@1	;@0B70D
	cmp	word ptr ds:[56A4h], 1	;@0B70F
	jne	@@1	;@0B714
	call	L077BF	;@0B716
	pop	es	;@0B719
	mov	dx, ax	;@0B71A
	pop	cx	;@0B71C
	pop	ax	;@0B71D
	sub	ax, dx	;@0B71E
	sbb	cx, 0	;@0B720
	jb	@@2	;@0B723
	jne	@@3	;@0B725
	and	ax, ax	;@0B727
	jne	@@3	;@0B729
	inc	word ptr ds:[56A0h]	;@0B72B
	ret	;@0B72F
@@1:	pop	es	;@0B730
	pop	cx	;@0B731
	pop	ax	;@0B732
@@2:	mov	word ptr ds:[56A2h], 0	;@0B733
	push	cx	;@0B739
	mov	cx, 50h	;@0B73A
	call	L03208	;@0B73D
	pop	cx	;@0B740
@@3:	inc	word ptr ds:[56A0h]	;@0B741
	jmp	short L0B79E	;@0B745
L0B747:	mov	ax, word ptr ds:[56A2h]	;@0B747
	and	ax, ax	;@0B74A
	jne	@@1	;@0B74C
	cmp	word ptr ds:[56A0h], 0	;@0B74E
	jne	L0B779	;@0B753
	call	L0B53D	;@0B755
	inc	word ptr ds:[56A0h]	;@0B758
	cmp	cx, 0Bh	;@0B75C
	jae	L0B771	;@0B75F
	mov	bx, cx	;@0B761
	shl	bx, 1	;@0B763
	push	cx	;@0B765
	call	word ptr [bx+1F7Eh]	;@0B766
	pop	cx	;@0B76A
@@1:	sub	ax, cx	;@0B76B
	mov	word ptr ds:[56A2h], ax	;@0B76D
	ret	;@0B770
L0B771:	push	cx	;@0B771
	mov	cx, 50h	;@0B772
	call	L03208	;@0B775
	pop	cx	;@0B778
L0B779:	inc	word ptr ds:[56A0h]	;@0B779
	cmp	cx, 1	;@0B77D
	jne	@@1	;@0B780
	test	word ptr ds:[5160h], 1000h	;@0B782
	je	@@2	;@0B788
@@1:	call	L037B1	;@0B78A
	clc	;@0B78D
	ret	;@0B78E
@@2:	push	ss	;@0B78F
	pop	es	;@0B790
	mov	di, 1FEEh	;@0B791
	jmp	@@1	;@0B794
L0B796:	cmp	word ptr ds:[56A0h], 0	;@0B796
	jne	L0B7B5	;@0B79B
	ret	;@0B79D
L0B79E:	push	es	;@0B79E
	call	L03BDD	;@0B79F
	pop	es	;@0B7A2
	mov	si, 1FBCh	;@0B7A3
	call	L0329E	;@0B7A6
	call	L03C72	;@0B7A9
	clc	;@0B7AC
	ret	;@0B7AD
L0B7AE:	mov	ax, cx	;@0B7AE
	call	L0420A	;@0B7B0
	clc	;@0B7B3
	ret	;@0B7B4
L0B7B5:	add	bx, word ptr ds:[569Ah]	;@0B7B5
	adc	dx, word ptr ds:[569Ch]	;@0B7B9
	call	L037D5	;@0B7BD
	clc	;@0B7C0
	ret	;@0B7C1
L0B7C2:	add	bx, word ptr ds:[569Ah]	;@0B7C2
	adc	dx, word ptr ds:[569Ch]	;@0B7C6
	mov	word ptr ds:[5696h], bx	;@0B7CA
	mov	word ptr ds:[5698h], dx	;@0B7CE
	push	es	;@0B7D2
	mov	si, 1FE4h	;@0B7D3
	call	L0329E	;@0B7D6
	pop	es	;@0B7D9
	jae	L0B812	;@0B7DA
	call	L0B509	;@0B7DC
	jne	L0B812	;@0B7DF
	mov	si, 1FBCh	;@0B7E1
	call	L0329E	;@0B7E4
	call	L0B4E4	;@0B7E7
	clc	;@0B7EA
	ret	;@0B7EB
L0B7EC:	add	bx, word ptr ds:[569Ah]	;@0B7EC
	adc	dx, word ptr ds:[569Ch]	;@0B7F0
	mov	word ptr ds:[5696h], bx	;@0B7F4
	mov	word ptr ds:[5698h], dx	;@0B7F8
	push	es	;@0B7FC
	mov	si, 1FE4h	;@0B7FD
	call	L0329E	;@0B800
	pop	es	;@0B803
	jae	L0B812	;@0B804
	call	L0B509	;@0B806
	jne	L0B812	;@0B809
	mov	si, 1FBCh	;@0B80B
	call	L0329E	;@0B80E
	clc	;@0B811
L0B812:	ret	;@0B812
L0B813:	mov	si, word ptr ds:[569Eh]	;@0B813
	call	L0A7B0	;@0B817
	jne	@@1	;@0B81A
	mov	word ptr ds:[569Eh], si	;@0B81C
@@1:	ret	;@0B820
L0B821:	mov	si, word ptr ds:[569Eh]	;@0B821
	call	L026B8	;@0B825
	jne	@@7	;@0B828
	cmp	ax, word ptr ds:[5740h]	;@0B82A
	je	@@7	;@0B82E
	cmp	ax, word ptr ds:[5838h]	;@0B830
	je	@@7	;@0B834
	cmp	ax, word ptr ds:[5742h]	;@0B836
	je	@@6	;@0B83A
	cmp	ax, word ptr ds:[573Eh]	;@0B83C
	jne	@@1	;@0B840
	add	si, 2	;@0B842
	jmp	short @@2	;@0B845
@@1:	mov	cx, 4Dh	;@0B847
	call	L03208	;@0B84A
@@2:	mov	si, 1FD0h	;@0B84D
	call	L0329E	;@0B850
	mov	si, word ptr ds:[569Eh]	;@0B853
	call	L026B8	;@0B857
	jne	@@4	;@0B85A
	cmp	ax, word ptr ds:[5740h]	;@0B85C
	jne	@@3	;@0B860
	add	si, 2	;@0B862
	jmp	short @@7	;@0B865
@@3:	mov	cx, 52h	;@0B867
	jmp	short @@5	;@0B86A
@@4:	mov	cx, 9	;@0B86C
@@5:	call	L03208	;@0B86F
	jmp	short @@7	;@0B872
@@6:	add	si, 2	;@0B874
@@7:	call	L026B8	;@0B877
	jne	@@8	;@0B87A
	cmp	ax, word ptr ds:[5838h]	;@0B87C
	jne	@@8	;@0B880
	add	si, 2	;@0B882
@@8:	mov	word ptr ds:[569Eh], si	;@0B885
	clc	;@0B889
	ret	;@0B88A
L0B88B:	mov	si, word ptr ds:[569Eh]	;@0B88B
	call	L026B8	;@0B88F
	jne	@@4	;@0B892
	cmp	ax, word ptr ds:[5740h]	;@0B894
	je	@@4	;@0B898
	cmp	ax, word ptr ds:[5838h]	;@0B89A
	je	@@4	;@0B89E
	cmp	ax, word ptr ds:[5742h]	;@0B8A0
	je	@@1	;@0B8A4
	mov	si, 1FD0h	;@0B8A6
	call	L0329E	;@0B8A9
	mov	si, word ptr ds:[569Eh]	;@0B8AC
	jmp	short @@2	;@0B8B0
@@1:	add	si, 2	;@0B8B2
@@2:	call	L026B8	;@0B8B5
	jne	@@3	;@0B8B8
	cmp	ax, word ptr ds:[5838h]	;@0B8BA
	jne	@@3	;@0B8BE
	add	si, 2	;@0B8C0
@@3:	mov	word ptr ds:[569Eh], si	;@0B8C3
	clc	;@0B8C7
@@4:	ret	;@0B8C8
L0B8C9:	mov	si, 1FE4h	;@0B8C9
	jmp	L0329E	;@0B8CC
	db	0F9h, 0C3h, 0F8h, 0C3h, 0, 0B0h, 98h, 0EBh, 36h	;@0B8CF
L0B8D8:	mov	al, 0A7h	;@0B8D8
	jmp	short L0B90E	;@0B8DA
L0B8DC:	mov	al, 99h	;@0B8DC
	jmp	short L0B90E	;@0B8DE
L0B8E0:	mov	al, 6Dh	;@0B8E0
	jmp	short L0B90E	;@0B8E2
L0B8E4:	mov	al, 0CFh	;@0B8E4
	jmp	short L0B90E	;@0B8E6
L0B8E8:	mov	al, 0ADh	;@0B8E8
	jmp	short L0B90E	;@0B8EA
L0B8EC:	mov	al, 0A5h	;@0B8EC
	jmp	short L0B90E	;@0B8EE
L0B8F0:	mov	al, 6Fh	;@0B8F0
	jmp	short L0B90E	;@0B8F2
L0B8F4:	mov	al, 61h	;@0B8F4
	jmp	short L0B90E	;@0B8F6
L0B8F8:	mov	al, 9Dh	;@0B8F8
	jmp	short L0B90E	;@0B8FA
L0B8FC:	mov	al, 60h	;@0B8FC
	jmp	short L0B90E	;@0B8FE
L0B900:	mov	al, 9Ch	;@0B900
	jmp	short L0B90E	;@0B902
L0B904:	mov	al, 0AFh	;@0B904
	jmp	short L0B90E	;@0B906
L0B908:	mov	al, 0C9h	;@0B908
	jmp	short L0B90E	;@0B90A
L0B90C:	mov	al, 0ABh	;@0B90C
L0B90E:	mov	byte ptr ds:[56B8h], al	;@0B90E
	call	L0F865	;@0B911
	jne	L0B928	;@0B914
	test	word ptr ds:[5160h], 8	;@0B916
	je	L0B92B	;@0B91C
	mov	cl, byte ptr ds:[56B8h]	;@0B91E
	call	L08C18	;@0B922
	jmp	L0F83A	;@0B925
L0B928:	jmp	L0265C	;@0B928
L0B92B:	jmp	L0F834	;@0B92B
L0B92E:	mov	al, 0B2h	;@0B92E
	jmp	short L0B938	;@0B930
L0B932:	mov	al, 0B4h	;@0B932
	jmp	short L0B938	;@0B934
L0B936:	mov	al, 0B5h	;@0B936
L0B938:	mov	byte ptr ds:[56B8h], al	;@0B938
	call	L0F865	;@0B93B
	jne	L0B928	;@0B93E
	test	word ptr ds:[5160h], 8	;@0B940
	je	L0B92B	;@0B946
	call	L0F91B	;@0B948
	mov	cl, byte ptr ds:[56B8h]	;@0B94B
	call	L08C26	;@0B94F
	jmp	L0F83A	;@0B952
L0B955:	mov	al, 20h	;@0B955
	jmp	short L0B963	;@0B957
L0B959:	mov	al, 38h	;@0B959
	jmp	short L0B963	;@0B95B
L0B95D:	mov	al, 30h	;@0B95D
	jmp	short L0B963	;@0B95F
L0B961:	mov	al, 28h	;@0B961
L0B963:	mov	byte ptr ds:[56B8h], al	;@0B963
	call	L0F865	;@0B966
	jne	L0B928	;@0B969
	test	word ptr ds:[5160h], 8	;@0B96B
	je	L0B92B	;@0B971
	call	L0F91B	;@0B973
	mov	cl, byte ptr ds:[56B8h]	;@0B976
	call	L08AC5	;@0B97A
	jmp	L0F83A	;@0B97D
L0B980:	mov	al, 0BCh	;@0B980
	jmp	short L0B986	;@0B982
L0B984:	mov	al, 0BDh	;@0B984
L0B986:	mov	byte ptr ds:[56B8h], al	;@0B986
	call	L0F865	;@0B989
	jne	L0B928	;@0B98C
	test	word ptr ds:[5160h], 8	;@0B98E
	je	L0B92B	;@0B994
	call	L0F91B	;@0B996
	mov	cl, byte ptr ds:[56B8h]	;@0B999
	call	L08B26	;@0B99D
	jmp	L0F83A	;@0B9A0
L0B9A3:	mov	al, 0BEh	;@0B9A3
	jmp	short L0B9A9	;@0B9A5
L0B9A7:	mov	al, 0B6h	;@0B9A7
L0B9A9:	mov	byte ptr ds:[56B8h], al	;@0B9A9
	call	L0F865	;@0B9AC
	jne	L0B9E9	;@0B9AF
	test	word ptr ds:[5160h], 8	;@0B9B1
	je	L0B9EC	;@0B9B7
	call	L0F91B	;@0B9B9
	mov	cl, byte ptr ds:[56B8h]	;@0B9BC
	call	L08B56	;@0B9C0
	jmp	L0F83A	;@0B9C3
L0B9C6:	mov	al, 0A4h	;@0B9C6
	jmp	short L0B9CC	;@0B9C8
L0B9CA:	mov	al, 0ACh	;@0B9CA
L0B9CC:	mov	byte ptr ds:[56B8h], al	;@0B9CC
	call	L0F865	;@0B9CF
	jne	L0B9E9	;@0B9D2
	test	word ptr ds:[5160h], 8	;@0B9D4
	je	L0B9EC	;@0B9DA
	call	L0F95C	;@0B9DC
	mov	cl, byte ptr ds:[56B8h]	;@0B9DF
	call	L08BA1	;@0B9E3
	jmp	L0F83A	;@0B9E6
L0B9E9:	jmp	L0265C	;@0B9E9
L0B9EC:	jmp	L0F834	;@0B9EC
L0B9EF:	mov	al, 97h	;@0B9EF
	jmp	short L0BA2D	;@0B9F1
L0B9F3:	mov	al, 93h	;@0B9F3
	jmp	short L0BA2D	;@0B9F5
L0B9F7:	mov	al, 92h	;@0B9F7
	jmp	short L0BA2D	;@0B9F9
L0B9FB:	mov	al, 96h	;@0B9FB
	jmp	short L0BA2D	;@0B9FD
L0B9FF:	mov	al, 94h	;@0B9FF
	jmp	short L0BA2D	;@0BA01
L0BA03:	mov	al, 9Fh	;@0BA03
	jmp	short L0BA2D	;@0BA05
L0BA07:	mov	al, 9Dh	;@0BA07
	jmp	short L0BA2D	;@0BA09
L0BA0B:	mov	al, 9Ch	;@0BA0B
	jmp	short L0BA2D	;@0BA0D
L0BA0F:	mov	al, 9Eh	;@0BA0F
	jmp	short L0BA2D	;@0BA11
L0BA13:	mov	al, 95h	;@0BA13
	jmp	short L0BA2D	;@0BA15
L0BA17:	mov	al, 91h	;@0BA17
	jmp	short L0BA2D	;@0BA19
L0BA1B:	mov	al, 9Bh	;@0BA1B
	jmp	short L0BA2D	;@0BA1D
L0BA1F:	mov	al, 99h	;@0BA1F
	jmp	short L0BA2D	;@0BA21
L0BA23:	mov	al, 90h	;@0BA23
	jmp	short L0BA2D	;@0BA25
L0BA27:	mov	al, 9Ah	;@0BA27
	jmp	short L0BA2D	;@0BA29
L0BA2B:	mov	al, 98h	;@0BA2B
L0BA2D:	mov	byte ptr ds:[56B8h], al	;@0BA2D
	call	L0F865	;@0BA30
	jne	L0B9E9	;@0BA33
	test	word ptr ds:[5160h], 8	;@0BA35
	je	L0B9EC	;@0BA3B
	call	L0F90C	;@0BA3D
	mov	cl, byte ptr ds:[56B8h]	;@0BA40
	call	L08B86	;@0BA44
	jmp	L0F83A	;@0BA47
L0BA4A:	mov	al, 0E3h	;@0BA4A
	jmp	short L0BA58	;@0BA4C
L0BA4E:	mov	al, 0E2h	;@0BA4E
	jmp	short L0BA58	;@0BA50
L0BA52:	mov	al, 0E1h	;@0BA52
	jmp	short L0BA58	;@0BA54
L0BA56:	mov	al, 0E0h	;@0BA56
L0BA58:	mov	byte ptr ds:[56B8h], al	;@0BA58
	call	L0F865	;@0BA5B
	jne	L0B9E9	;@0BA5E
	test	word ptr ds:[5160h], 8	;@0BA60
	je	L0B9EC	;@0BA66
	call	L0F90C	;@0BA68
	mov	cl, byte ptr ds:[56B8h]	;@0BA6B
	call	L07D04	;@0BA6F
	jmp	L0F83A	;@0BA72
L0BA75:	call	L0F865	;@0BA75
	jne	L0BAE0	;@0BA78
	test	word ptr ds:[5160h], 10h	;@0BA7A
	je	L0BAE3	;@0BA80
	call	L0F90C	;@0BA82
	call	L08C56	;@0BA85
	jmp	L0F83A	;@0BA88
L0BA8B:	mov	al, 0C0h	;@0BA8B
	jmp	short L0BA91	;@0BA8D
L0BA8F:	mov	al, 0A6h	;@0BA8F
L0BA91:	mov	byte ptr ds:[56B8h], al	;@0BA91
	call	L0F865	;@0BA94
	jne	L0BAE0	;@0BA97
	test	word ptr ds:[5160h], 10h	;@0BA99
	je	L0BAE3	;@0BA9F
	call	L0F91B	;@0BAA1
	mov	cl, byte ptr ds:[56B8h]	;@0BAA4
	call	L08C7A	;@0BAA8
	jmp	L0F83A	;@0BAAB
L0BAAE:	call	L0F865	;@0BAAE
	jne	L0BAE0	;@0BAB1
	test	word ptr ds:[5160h], 80h	;@0BAB3
	je	L0BAE3	;@0BAB9
	call	L0F91B	;@0BABB
	push	es	;@0BABE
	mov	es, ax	;@0BABF
	pop	ax	;@0BAC1
	mov	cl, 63h	;@0BAC2
	call	L08A61	;@0BAC4
	jmp	L0F83A	;@0BAC7
L0BACA:	call	L0F865	;@0BACA
	jne	L0BAE0	;@0BACD
	test	word ptr ds:[5160h], 80h	;@0BACF
	je	L0BAE3	;@0BAD5
	mov	cx, 60Fh	;@0BAD7
	call	L07F21	;@0BADA
	jmp	L0F83A	;@0BADD
L0BAE0:	jmp	L0265C	;@0BAE0
L0BAE3:	jmp	L0F834	;@0BAE3
L0BAE6:	mov	al, 2	;@0BAE6
	jmp	short L0BAEC	;@0BAE8
L0BAEA:	mov	al, 3	;@0BAEA
L0BAEC:	mov	byte ptr ds:[56B8h], al	;@0BAEC
	call	L0F865	;@0BAEF
	jne	L0BAE0	;@0BAF2
	test	word ptr ds:[5160h], 80h	;@0BAF4
	je	L0BAE3	;@0BAFA
	call	L0F91B	;@0BAFC
	mov	cl, byte ptr ds:[56B8h]	;@0BAFF
	call	L08A91	;@0BB03
	jmp	L0F83A	;@0BB06
L0BB09:	mov	al, 10h	;@0BB09
	jmp	short L0BB17	;@0BB0B
L0BB0D:	mov	al, 18h	;@0BB0D
	jmp	short L0BB17	;@0BB0F
L0BB11:	mov	al, 0	;@0BB11
	jmp	short L0BB17	;@0BB13
L0BB15:	mov	al, 8	;@0BB15
L0BB17:	mov	ah, 1	;@0BB17
	mov	word ptr ds:[56B8h], ax	;@0BB19
	call	L0F865	;@0BB1C
	jne	L0BAE0	;@0BB1F
	test	word ptr ds:[5160h], 80h	;@0BB21
	je	L0BAE3	;@0BB27
	call	L0F90C	;@0BB29
	mov	cx, word ptr ds:[56B8h]	;@0BB2C
	call	L089D4	;@0BB30
	jmp	L0F83A	;@0BB33
L0BB36:	mov	al, 10h	;@0BB36
	jmp	short L0BB54	;@0BB38
L0BB3A:	mov	al, 30h	;@0BB3A
	jmp	short L0BB58	;@0BB3C
L0BB3E:	mov	al, 18h	;@0BB3E
	jmp	short L0BB54	;@0BB40
L0BB42:	mov	al, 0	;@0BB42
	jmp	short L0BB54	;@0BB44
L0BB46:	mov	al, 20h	;@0BB46
	jmp	short L0BB58	;@0BB48
L0BB4A:	mov	al, 8	;@0BB4A
	jmp	short L0BB54	;@0BB4C
L0BB4E:	mov	al, 20h	;@0BB4E
	jmp	short L0BB54	;@0BB50
L0BB52:	mov	al, 28h	;@0BB52
L0BB54:	xor	ah, ah	;@0BB54
	jmp	short L0BB5A	;@0BB56
L0BB58:	mov	ah, 1	;@0BB58
L0BB5A:	mov	word ptr ds:[56B8h], ax	;@0BB5A
	call	L0F865	;@0BB5D
	jne	L0BBC1	;@0BB60
	test	word ptr ds:[5160h], 80h	;@0BB62
	je	L0BBC4	;@0BB68
	call	L0F90C	;@0BB6A
	mov	cx, word ptr ds:[56B8h]	;@0BB6D
	call	L08A0E	;@0BB71
	jmp	L0F83A	;@0BB74
L0BB77:	mov	al, 8	;@0BB77
	jmp	short L0BB7D	;@0BB79
L0BB7B:	mov	al, 9	;@0BB7B
L0BB7D:	mov	ah, al	;@0BB7D
	mov	al, 0Fh	;@0BB7F
	mov	word ptr ds:[56B8h], ax	;@0BB81
	call	L0F865	;@0BB84
	jne	L0BBC1	;@0BB87
	test	word ptr ds:[5160h], 10h	;@0BB89
	je	L0BBC4	;@0BB8F
	test	word ptr ds:[5160h], 80h	;@0BB91
	je	L0BBC4	;@0BB97
	mov	cx, word ptr ds:[56B8h]	;@0BB99
	call	L07F21	;@0BB9D
	jmp	L0F83A	;@0BBA0
L0BBA3:	call	L0F865	;@0BBA3
	jne	L0BBC1	;@0BBA6
	test	word ptr ds:[5160h], 10h	;@0BBA8
	je	L0BBC4	;@0BBAE
	test	word ptr ds:[5160h], 80h	;@0BBB0
	je	L0BBC4	;@0BBB6
	call	L0F90C	;@0BBB8
	call	L08CB7	;@0BBBB
	jmp	L0F83A	;@0BBBE
L0BBC1:	jmp	L0265C	;@0BBC1
L0BBC4:	jmp	L0F834	;@0BBC4
L0BBC7:	call	L0F865	;@0BBC7
	jne	L0BBC1	;@0BBCA
	test	word ptr ds:[5160h], 2	;@0BBCC
	je	L0BBC4	;@0BBD2
	call	L0F91B	;@0BBD4
	mov	cl, 62h	;@0BBD7
	call	L08A20	;@0BBD9
	jmp	L0F83A	;@0BBDC
L0BBDF:	call	L0F865	;@0BBDF
	jne	L0BBC1	;@0BBE2
	test	word ptr ds:[5160h], 2	;@0BBE4
	je	L0BBC4	;@0BBEA
	call	L0F91B	;@0BBEC
	call	L0885D	;@0BBEF
	jmp	L0F83A	;@0BBF2
L0BBF5:	call	L0F865	;@0BBF5
	jne	L0BBC1	;@0BBF8
	call	L0F91B	;@0BBFA
	call	L08886	;@0BBFD
	jmp	L0F83A	;@0BC00
L0BC03:	call	L0F865	;@0BC03
	jne	L0BBC1	;@0BC06
	test	word ptr ds:[5160h], 8	;@0BC08
	je	L0BBC4	;@0BC0E
	call	L0F91B	;@0BC10
	call	L0888E	;@0BC13
	jmp	L0F83A	;@0BC16
L0BC19:	call	L0F865	;@0BC19
	jne	L0BBC1	;@0BC1C
	test	word ptr ds:[5160h], 2	;@0BC1E
	je	L0BBC4	;@0BC24
	call	L05534	;@0BC26
	call	L0F91B	;@0BC29
	mov	cl, 6Ch	;@0BC2C
	call	L0898E	;@0BC2E
	call	L0553B	;@0BC31
	jmp	L0F83A	;@0BC34
L0BC37:	call	L0F865	;@0BC37
	jne	L0BBC1	;@0BC3A
	test	word ptr ds:[5160h], 2	;@0BC3C
	je	L0BBC4	;@0BC42
	call	L0F91B	;@0BC44
	push	es	;@0BC47
	mov	es, ax	;@0BC48
	pop	ax	;@0BC4A
	mov	cl, 6Eh	;@0BC4B
	call	L0898E	;@0BC4D
	jmp	L0F83A	;@0BC50
L0BC53:	mov	al, 6Ch	;@0BC53
	jmp	short L0BC5D	;@0BC55
L0BC57:	mov	al, 6Eh	;@0BC57
	jmp	short L0BC5D	;@0BC59
L0BC5B:	mov	al, 0C9h	;@0BC5B
L0BC5D:	mov	byte ptr ds:[56B8h], al	;@0BC5D
	call	L0F865	;@0BC60
	jne	L0BCC4	;@0BC63
	test	word ptr ds:[5160h], 2	;@0BC65
	je	L0BCC7	;@0BC6B
	mov	cl, byte ptr ds:[56B8h]	;@0BC6D
	call	L07F00	;@0BC71
	jmp	L0F83A	;@0BC74
L0BC77:	mov	al, 60h	;@0BC77
	jmp	short L0BC85	;@0BC79
L0BC7B:	mov	al, 61h	;@0BC7B
	jmp	short L0BC85	;@0BC7D
L0BC7F:	mov	al, 6Dh	;@0BC7F
	jmp	short L0BC85	;@0BC81
L0BC83:	mov	al, 6Fh	;@0BC83
L0BC85:	mov	byte ptr ds:[56B8h], al	;@0BC85
	call	L0F865	;@0BC88
	jne	L0BCC4	;@0BC8B
	test	word ptr ds:[5160h], 2	;@0BC8D
	je	L0BCC7	;@0BC93
	mov	cl, byte ptr ds:[56B8h]	;@0BC95
	call	L07EF2	;@0BC99
	jmp	L0F83A	;@0BC9C
L0BC9F:	mov	al, 20h	;@0BC9F
	jmp	short L0BCA5	;@0BCA1
L0BCA3:	mov	al, 30h	;@0BCA3
L0BCA5:	mov	byte ptr ds:[56B8h], al	;@0BCA5
	call	L0F865	;@0BCA8
	jne	L0BCC4	;@0BCAB
	test	word ptr ds:[5160h], 100h	;@0BCAD
	je	L0BCC7	;@0BCB3
	call	L0F90C	;@0BCB5
	mov	cl, byte ptr ds:[56B8h]	;@0BCB8
	mov	ch, 0DFh	;@0BCBC
	call	L07A8D	;@0BCBE
	jmp	L0F83A	;@0BCC1
L0BCC4:	jmp	L0265C	;@0BCC4
L0BCC7:	jmp	L0F834	;@0BCC7
L0BCCA:	call	L0F865	;@0BCCA
	jne	L0BCC4	;@0BCCD
	test	word ptr ds:[5160h], 100h	;@0BCCF
	je	L0BCC7	;@0BCD5
	call	L07A67	;@0BCD7
	jmp	L0F83A	;@0BCDA
L0BCDD:	mov	ax, 28h	;@0BCDD
	jmp	short L0BCE5	;@0BCE0
L0BCE2:	mov	ax, 1838h	;@0BCE2
L0BCE5:	mov	word ptr ds:[56B8h], ax	;@0BCE5
	call	L0F865	;@0BCE8
	jne	L0BCC4	;@0BCEB
	test	word ptr ds:[5160h], 100h	;@0BCED
	je	L0BCC7	;@0BCF3
	call	L0A883	;@0BCF5
	je	@@1	;@0BCF8
	call	L0A7C0	;@0BCFA
	jne	@@3	;@0BCFD
	mov	cx, word ptr ds:[56B8h]	;@0BCFF
	call	L07BA8	;@0BD03
	jmp	L0F83A	;@0BD06
@@1:	mov	ch, 0D9h	;@0BD09
	mov	cl, byte ptr ds:[56B9h]	;@0BD0B
	and	cl, cl	;@0BD0F
	je	@@2	;@0BD11
	or	ch, 4	;@0BD13
@@2:	call	L07C48	;@0BD16
	jmp	L0F83A	;@0BD19
@@3:	mov	cl, byte ptr ds:[56B9h]	;@0BD1C
	mov	ch, 0D9h	;@0BD20
	and	cl, cl	;@0BD22
	je	@@4	;@0BD24
	or	ch, 4	;@0BD26
@@4:	or	cl, 0C1h	;@0BD29
	call	L07C06	;@0BD2C
	jmp	L0F83A	;@0BD2F
L0BD32:	mov	ax, 28h	;@0BD32
	jmp	short L0BD3A	;@0BD35
L0BD37:	mov	ax, 1838h	;@0BD37
L0BD3A:	mov	word ptr ds:[56B8h], ax	;@0BD3A
	call	L0F865	;@0BD3D
	jne	L0BD57	;@0BD40
	test	word ptr ds:[5160h], 100h	;@0BD42
	je	L0BD5A	;@0BD48
	call	L0F90C	;@0BD4A
	mov	cx, word ptr ds:[56B8h]	;@0BD4D
	call	L07BCE	;@0BD51
	jmp	L0F83A	;@0BD54
L0BD57:	jmp	L0265C	;@0BD57
L0BD5A:	jmp	L0F834	;@0BD5A
L0BD5D:	mov	ax, 0D920h	;@0BD5D
	jmp	short L0BD6F	;@0BD60
L0BD62:	mov	ax, 0DD20h	;@0BD62
	jmp	short L0BD6F	;@0BD65
L0BD67:	mov	ax, 0DD30h	;@0BD67
	jmp	short L0BD6F	;@0BD6A
L0BD6C:	mov	ax, 0D930h	;@0BD6C
L0BD6F:	mov	word ptr ds:[56B8h], ax	;@0BD6F
	call	L0F865	;@0BD72
	jne	L0BD57	;@0BD75
	test	word ptr ds:[5160h], 100h	;@0BD77
	je	L0BD5A	;@0BD7D
	call	L0F90C	;@0BD7F
	mov	cx, word ptr ds:[56B8h]	;@0BD82
	call	L07A9F	;@0BD86
	jmp	L0F83A	;@0BD89
L0BD8C:	mov	ax, 0DD30h	;@0BD8C
	jmp	short L0BD94	;@0BD8F
L0BD91:	mov	ax, 0D930h	;@0BD91
L0BD94:	mov	word ptr ds:[56B8h], ax	;@0BD94
	call	L0F865	;@0BD97
	jne	L0BD57	;@0BD9A
	test	word ptr ds:[5160h], 100h	;@0BD9C
	je	L0BD5A	;@0BDA2
	call	L0F90C	;@0BDA4
	mov	cx, word ptr ds:[56B8h]	;@0BDA7
	call	L07AB6	;@0BDAB
	jmp	L0F83A	;@0BDAE
L0BDB1:	call	L0F865	;@0BDB1
	jne	L0BD57	;@0BDB4
	test	word ptr ds:[5160h], 100h	;@0BDB6
	je	L0BD5A	;@0BDBC
	call	L0F90C	;@0BDBE
	mov	cx, 0DD38h	;@0BDC1
	call	L07B09	;@0BDC4
	jmp	L0F83A	;@0BDC7
L0BDCA:	mov	ax, 0D928h	;@0BDCA
	jmp	short L0BDD2	;@0BDCD
L0BDCF:	mov	ax, 0D938h	;@0BDCF
L0BDD2:	mov	word ptr ds:[56B8h], ax	;@0BDD2
	call	L0F865	;@0BDD5
	jne	L0BE28	;@0BDD8
	test	word ptr ds:[5160h], 100h	;@0BDDA
	je	L0BE2B	;@0BDE0
	call	L0F90C	;@0BDE2
	mov	cx, word ptr ds:[56B8h]	;@0BDE5
	call	L07B67	;@0BDE9
	jmp	L0F83A	;@0BDEC
L0BDEF:	call	L0F865	;@0BDEF
	jne	L0BE28	;@0BDF2
	test	word ptr ds:[5160h], 100h	;@0BDF4
	je	L0BE2B	;@0BDFA
	call	L0F90C	;@0BDFC
	mov	cx, 0DD38h	;@0BDFF
	call	L07AC8	;@0BE02
	jmp	L0F83A	;@0BE05
L0BE08:	mov	ax, 0D938h	;@0BE08
	mov	word ptr ds:[56B8h], ax	;@0BE0B
	call	L0F865	;@0BE0E
	jne	L0BE28	;@0BE11
	test	word ptr ds:[5160h], 100h	;@0BE13
	je	L0BE2B	;@0BE19
	call	L0F90C	;@0BE1B
	mov	cx, word ptr ds:[56B8h]	;@0BE1E
	call	L07B81	;@0BE22
	jmp	L0F83A	;@0BE25
L0BE28:	jmp	L0265C	;@0BE28
L0BE2B:	jmp	L0F834	;@0BE2B
L0BE2E:	mov	ax, 0D9F0h	;@0BE2E
	jmp	L0BEBA	;@0BE31
L0BE34:	mov	ax, 0D9E1h	;@0BE34
	jmp	L0BEBA	;@0BE37
L0BE3A:	mov	ax, 0D9E0h	;@0BE3A
	jmp	short L0BEBA	;@0BE3D
L0BE3F:	mov	ax, 0DBE2h	;@0BE3F
	jmp	short L0BEBA	;@0BE42
L0BE44:	mov	ax, 0D9F6h	;@0BE44
	jmp	short L0BEBA	;@0BE47
L0BE49:	mov	ax, 0DBE1h	;@0BE49
	jmp	short L0BEBA	;@0BE4C
L0BE4E:	mov	ax, 0DBE0h	;@0BE4E
	jmp	short L0BEBA	;@0BE51
L0BE53:	mov	ax, 0D9F7h	;@0BE53
	jmp	short L0BEBA	;@0BE56
L0BE58:	mov	ax, 0DBE3h	;@0BE58
	jmp	short L0BEBA	;@0BE5B
L0BE5D:	mov	ax, 0D9E8h	;@0BE5D
	jmp	short L0BEBA	;@0BE60
L0BE62:	mov	ax, 0D9EAh	;@0BE62
	jmp	short L0BEBA	;@0BE65
L0BE67:	mov	ax, 0D9E9h	;@0BE67
	jmp	short L0BEBA	;@0BE6A
L0BE6C:	mov	ax, 0D9ECh	;@0BE6C
	jmp	short L0BEBA	;@0BE6F
L0BE71:	mov	ax, 0D9EDh	;@0BE71
	jmp	short L0BEBA	;@0BE74
L0BE76:	mov	ax, 0D9EBh	;@0BE76
	jmp	short L0BEBA	;@0BE79
L0BE7B:	mov	ax, 0D9EEh	;@0BE7B
	jmp	short L0BEBA	;@0BE7E
L0BE80:	mov	ax, 0D9D0h	;@0BE80
	jmp	short L0BEBA	;@0BE83
L0BE85:	mov	ax, 0D9F3h	;@0BE85
	jmp	short L0BEBA	;@0BE88
L0BE8A:	mov	ax, 0D9F8h	;@0BE8A
	jmp	short L0BEBA	;@0BE8D
L0BE8F:	mov	ax, 0D9F2h	;@0BE8F
	jmp	short L0BEBA	;@0BE92
L0BE94:	mov	ax, 0D9FCh	;@0BE94
	jmp	short L0BEBA	;@0BE97
L0BE99:	mov	ax, 0D9FDh	;@0BE99
	jmp	short L0BEBA	;@0BE9C
L0BE9E:	mov	ax, 0D9FAh	;@0BE9E
	jmp	short L0BEBA	;@0BEA1
L0BEA3:	mov	ax, 0D9E4h	;@0BEA3
	jmp	short L0BEBA	;@0BEA6
L0BEA8:	mov	ax, 0D9E5h	;@0BEA8
	jmp	short L0BEBA	;@0BEAB
L0BEAD:	mov	ax, 0D9F4h	;@0BEAD
	jmp	short L0BEBA	;@0BEB0
L0BEB2:	mov	ax, 0D9F1h	;@0BEB2
	jmp	short L0BEBA	;@0BEB5
L0BEB7:	mov	ax, 0D9F9h	;@0BEB7
L0BEBA:	mov	word ptr ds:[56B8h], ax	;@0BEBA
	call	L0F865	;@0BEBD
	jne	L0BF0E	;@0BEC0
	test	word ptr ds:[5160h], 100h	;@0BEC2
L0BEC8:	je	L0BF11	;@0BEC8
	mov	cx, word ptr ds:[56B8h]	;@0BECA
	call	L07C06	;@0BECE
	jmp	L0F83A	;@0BED1
L0BED4:	mov	ax, 0D9F5h	;@0BED4
	jmp	short L0BEEB	;@0BED7
L0BED9:	mov	ax, 0D9FFh	;@0BED9
	jmp	short L0BEEB	;@0BEDC
L0BEDE:	mov	ax, 0D9FEh	;@0BEDE
	jmp	short L0BEEB	;@0BEE1
L0BEE3:	mov	ax, 0D9FBh	;@0BEE3
	jmp	short L0BEEB	;@0BEE6
L0BEE8:	mov	ax, 0DAE9h	;@0BEE8
L0BEEB:	mov	word ptr ds:[56B8h], ax	;@0BEEB
	call	L0F865	;@0BEEE
	jne	L0BF0E	;@0BEF1
	test	word ptr ds:[5160h], 800h	;@0BEF3
	jmp	L0BEC8	;@0BEF9
L0BEFB:	mov	word ptr ds:[56B8h], 0DBE4h	;@0BEFB
	call	L0F865	;@0BF01
	jne	L0BF0E	;@0BF04
	test	word ptr ds:[5160h], 400h	;@0BF06
	jmp	L0BEC8	;@0BF0C
L0BF0E:	jmp	L0265C	;@0BF0E
L0BF11:	jmp	L0F834	;@0BF11
L0BF14:	mov	ax, 0DBE2h	;@0BF14
	jmp	short L0BF26	;@0BF17
L0BF19:	mov	ax, 0DBE1h	;@0BF19
	jmp	short L0BF26	;@0BF1C
L0BF1E:	mov	ax, 0DBE0h	;@0BF1E
	jmp	short L0BF26	;@0BF21
L0BF23:	mov	ax, 0DBE3h	;@0BF23
L0BF26:	mov	word ptr ds:[56B8h], ax	;@0BF26
	call	L0F865	;@0BF29
	jne	L0BF0E	;@0BF2C
	test	word ptr ds:[5160h], 100h	;@0BF2E
	je	L0BF11	;@0BF34
	mov	cx, word ptr ds:[56B8h]	;@0BF36
	call	L07C38	;@0BF3A
	jmp	L0F83A	;@0BF3D
L0BF40:	mov	al, 0	;@0BF40
	jmp	short L0BF5A	;@0BF42
L0BF44:	mov	al, 38h	;@0BF44
	jmp	short L0BF5A	;@0BF46
L0BF48:	mov	al, 30h	;@0BF48
	jmp	short L0BF5A	;@0BF4A
L0BF4C:	mov	al, 8	;@0BF4C
	jmp	short L0BF5A	;@0BF4E
L0BF50:	mov	al, 28h	;@0BF50
	jmp	short L0BF5A	;@0BF52
L0BF54:	mov	al, 20h	;@0BF54
	jmp	short L0BF5A	;@0BF56
L0BF58:	mov	al, 18h	;@0BF58
L0BF5A:	mov	byte ptr ds:[56B8h], al	;@0BF5A
	call	L0F865	;@0BF5D
	jne	L0BF0E	;@0BF60
	test	word ptr ds:[5160h], 100h	;@0BF62
	je	L0BF11	;@0BF68
	call	L0A883	;@0BF6A
	jne	@@3	;@0BF6D
	call	L026B8	;@0BF6F
	jne	@@2	;@0BF72
	cmp	ax, word ptr ds:[5838h]	;@0BF74
	jne	@@2	;@0BF78
	add	si, 2	;@0BF7A
	push	es	;@0BF7D
	call	L0A883	;@0BF7E
	pop	ax	;@0BF81
@@1:	mov	cl, byte ptr ds:[56B8h]	;@0BF82
	mov	ch, 0DEh	;@0BF86
	call	L07C57	;@0BF88
	jmp	L0F83A	;@0BF8B
@@2:	push	es	;@0BF8E
	call	L05542	;@0BF8F
	pop	ax	;@0BF92
	jmp	@@1	;@0BF93
@@3:	mov	ch, 0DEh	;@0BF95
	mov	cl, byte ptr ds:[56B8h]	;@0BF97
	or	cl, 0C1h	;@0BF9B
	call	L07C06	;@0BF9E
	jmp	L0F83A	;@0BFA1
L0BFA4:	mov	ax, 0DD20h	;@0BFA4
	jmp	short L0BFAC	;@0BFA7
L0BFA9:	mov	ax, 0DD28h	;@0BFA9
L0BFAC:	mov	word ptr ds:[56B8h], ax	;@0BFAC
	call	L0F865	;@0BFAF
	jne	L0BFF0	;@0BFB2
	test	word ptr ds:[5160h], 800h	;@0BFB4
	jmp	short L0BFD2	;@0BFBA
L0BFBC:	mov	ax, 0DD00h	;@0BFBC
	jmp	short L0BFC4	;@0BFBF
L0BFC1:	mov	ax, 0D908h	;@0BFC1
L0BFC4:	mov	word ptr ds:[56B8h], ax	;@0BFC4
	call	L0F865	;@0BFC7
	jne	L0BFF0	;@0BFCA
	test	word ptr ds:[5160h], 100h	;@0BFCC
L0BFD2:	je	L0BFF3	;@0BFD2
	call	L0A883	;@0BFD4
	je	@@1	;@0BFD7
	mov	cx, word ptr ds:[56B8h]	;@0BFD9
	or	cl, 0C1h	;@0BFDD
	call	L07C06	;@0BFE0
	jmp	L0F83A	;@0BFE3
@@1:	mov	cx, word ptr ds:[56B8h]	;@0BFE6
	call	L07C48	;@0BFEA
	jmp	L0F83A	;@0BFED
L0BFF0:	jmp	L0265C	;@0BFF0
L0BFF3:	jmp	L0F834	;@0BFF3
L0BFF6:	mov	ax, 0DA00h	;@0BFF6
	jmp	short L0C021	;@0BFF9
L0BFFB:	mov	ax, 0DA10h	;@0BFFB
	jmp	short L0C021	;@0BFFE
L0C000:	mov	ax, 0DA18h	;@0C000
	jmp	short L0C021	;@0C003
L0C005:	mov	ax, 0DA30h	;@0C005
	jmp	short L0C021	;@0C008
L0C00A:	mov	ax, 0DA38h	;@0C00A
	jmp	short L0C021	;@0C00D
L0C00F:	mov	ax, 0DA08h	;@0C00F
	jmp	short L0C021	;@0C012
L0C014:	mov	ax, 0DB10h	;@0C014
	jmp	short L0C021	;@0C017
L0C019:	mov	ax, 0DA20h	;@0C019
	jmp	short L0C021	;@0C01C
L0C01E:	mov	ax, 0DA28h	;@0C01E
L0C021:	mov	word ptr ds:[56B8h], ax	;@0C021
	call	L0F865	;@0C024
	jne	L0BFF0	;@0C027
	test	word ptr ds:[5160h], 100h	;@0C029
	je	L0BFF3	;@0C02F
L0C031:	db	0E8h, 0D8h, 38h	; call L0F90C	;@0C031
	mov	cx, word ptr ds:[56B8h]	;@0C034
	call	L07BF4	;@0C038
	db	0E9h, 0FCh, 37h	; jmp L0F83A	;@0C03B
L0C03E:	mov	ax, 0	;@0C03E
	jmp	short L0C05C	;@0C041
L0C043:	mov	ax, 808h	;@0C043
	jmp	short L0C05C	;@0C046
L0C048:	mov	ax, 3038h	;@0C048
	jmp	short L0C05C	;@0C04B
L0C04D:	mov	ax, 3830h	;@0C04D
	jmp	short L0C05C	;@0C050
L0C052:	mov	ax, 2028h	;@0C052
	jmp	short L0C05C	;@0C055
L0C057:	mov	ax, 2820h	;@0C057
	jmp	short L0C05C	;@0C05A
L0C05C:	mov	word ptr ds:[56B8h], ax	;@0C05C
	call	L0F865	;@0C05F
	jne	L0BFF0	;@0C062
	test	word ptr ds:[5160h], 100h	;@0C064
	je	L0BFF3	;@0C06A
	call	L0A883	;@0C06C
	je	@@1	;@0C06F
	call	L0A7C0	;@0C071
	jne	@@4	;@0C074
	mov	ch, 0D8h	;@0C076
	mov	cl, byte ptr ds:[56B9h]	;@0C078
	call	L07B96	;@0C07C
	jmp	L0F83A	;@0C07F
@@1:	call	L026B8	;@0C082
	jne	@@3	;@0C085
	cmp	ax, word ptr ds:[5838h]	;@0C087
	jne	@@3	;@0C08B
	add	si, 2	;@0C08D
	push	es	;@0C090
	call	L0A883	;@0C091
	pop	ax	;@0C094
	je	@@2	;@0C095
	mov	cx, 12h	;@0C097
	push	ax	;@0C09A
	call	L03208	;@0C09B
	call	L05542	;@0C09E
	pop	ax	;@0C0A1
@@2:	mov	cx, word ptr ds:[56B8h]	;@0C0A2
	mov	dh, ch	;@0C0A6
	mov	ch, 0D8h	;@0C0A8
	call	L07C79	;@0C0AA
	jmp	L0F83A	;@0C0AD
@@3:	mov	cx, 0Dh	;@0C0B0
	call	L03208	;@0C0B3
	push	es	;@0C0B6
	call	L05542	;@0C0B7
	pop	ax	;@0C0BA
	jmp	@@2	;@0C0BB
@@4:	mov	ch, 0DEh	;@0C0BD
	mov	cl, byte ptr ds:[56B8h]	;@0C0BF
	or	cl, 0C1h	;@0C0C3
	call	L07C06	;@0C0C6
	jmp	L0F83A	;@0C0C9
L0C0CC:	mov	ax, 0D910h	;@0C0CC
	jmp	short L0C0D9	;@0C0CF
L0C0D1:	mov	ax, 0D810h	;@0C0D1
	jmp	short L0C0D9	;@0C0D4
	db	0B8h, 18h, 0D8h	;@0C0D6
L0C0D9:	mov	word ptr ds:[56B8h], ax	;@0C0D9
	call	L0F865	;@0C0DC
	jne	L0C124	;@0C0DF
	test	word ptr ds:[5160h], 100h	;@0C0E1
	je	L0C127	;@0C0E7
	call	L0A883	;@0C0E9
	je	@@1	;@0C0EC
	call	L0A7C0	;@0C0EE
	jne	@@3	;@0C0F1
	mov	cx, word ptr ds:[56B8h]	;@0C0F3
	call	L07B96	;@0C0F7
	jmp	L0F83A	;@0C0FA
@@1:	mov	cx, word ptr ds:[56B8h]	;@0C0FD
	test	ch, 1	;@0C101
	je	@@2	;@0C104
	or	ch, 4	;@0C106
@@2:	call	L07C48	;@0C109
	jmp	L0F83A	;@0C10C
@@3:	mov	cx, word ptr ds:[56B8h]	;@0C10F
	test	ch, 1	;@0C113
	je	@@4	;@0C116
	or	ch, 4	;@0C118
@@4:	or	cl, 0C1h	;@0C11B
	call	L07C06	;@0C11E
	jmp	L0F83A	;@0C121
L0C124:	jmp	L0265C	;@0C124
L0C127:	jmp	L0F834	;@0C127
L0C12A:	call	L0F865	;@0C12A
	jne	L0C124	;@0C12D
	call	L0F91B	;@0C12F
	call	L081B7	;@0C132
	jmp	L0F83A	;@0C135
L0C138:	call	L0F865	;@0C138
	jne	L0C124	;@0C13B
	call	L0F91B	;@0C13D
	call	L0825D	;@0C140
	jmp	L0F83A	;@0C143
L0C146:	xor	al, al	;@0C146
	jmp	short L0C164	;@0C148
L0C14A:	mov	al, 8	;@0C14A
	jmp	short L0C164	;@0C14C
L0C14E:	mov	al, 10h	;@0C14E
	jmp	short L0C164	;@0C150
L0C152:	mov	al, 18h	;@0C152
	jmp	short L0C164	;@0C154
L0C156:	mov	al, 20h	;@0C156
	jmp	short L0C164	;@0C158
L0C15A:	mov	al, 28h	;@0C15A
	jmp	short L0C164	;@0C15C
L0C15E:	mov	al, 30h	;@0C15E
	jmp	short L0C164	;@0C160
L0C162:	mov	al, 38h	;@0C162
L0C164:	mov	byte ptr ds:[56B8h], al	;@0C164
	call	L0F865	;@0C167
	jne	L0C124	;@0C16A
	call	L0F91B	;@0C16C
	mov	cl, byte ptr ds:[56B8h]	;@0C16F
	call	L084B4	;@0C173
	jmp	L0F83A	;@0C176
L0C179:	call	L0F865	;@0C179
	jne	L0C124	;@0C17C
	call	L0F90C	;@0C17E
	call	L0811A	;@0C181
	jmp	L0F83A	;@0C184
L0C187:	call	L0F865	;@0C187
	jne	L0C1D6	;@0C18A
	call	L0F91B	;@0C18C
	call	L0813E	;@0C18F
	jmp	L0F83A	;@0C192
L0C195:	xor	al, al	;@0C195
	jmp	short L0C19B	;@0C197
L0C199:	mov	al, 8	;@0C199
L0C19B:	mov	byte ptr ds:[56B8h], al	;@0C19B
	call	L0F865	;@0C19E
	jne	L0C1D6	;@0C1A1
	call	L0F90C	;@0C1A3
	mov	cl, byte ptr ds:[56B8h]	;@0C1A6
	call	L0817C	;@0C1AA
	jmp	L0F83A	;@0C1AD
L0C1B0:	call	L0F865	;@0C1B0
	jne	L0C1D6	;@0C1B3
	call	L0F90C	;@0C1B5
@@1:	call	L085B9	;@0C1B8
	call	L0A7C0	;@0C1BB
	je	@@1	;@0C1BE
	jmp	L0F83A	;@0C1C0
L0C1C3:	call	L0F865	;@0C1C3
	jne	L0C1D6	;@0C1C6
	call	L0F90C	;@0C1C8
@@1:	call	L08746	;@0C1CB
	call	L0A7C0	;@0C1CE
	je	@@1	;@0C1D1
	jmp	L0F83A	;@0C1D3
L0C1D6:	jmp	L0265C	;@0C1D6
L0C1D9:	mov	al, 0D5h	;@0C1D9
	jmp	short L0C1DF	;@0C1DB
L0C1DD:	mov	al, 0D4h	;@0C1DD
L0C1DF:	mov	byte ptr ds:[56B8h], al	;@0C1DF
	call	L0F865	;@0C1E2
	jne	L0C1D6	;@0C1E5
	call	L0A7C0	;@0C1E7
	mov	cl, byte ptr ds:[56B8h]	;@0C1EA
	jne	@@1	;@0C1EE
	call	L0805B	;@0C1F0
	jmp	L0F83A	;@0C1F3
@@1:	mov	ch, 0Ah	;@0C1F6
	call	L07F21	;@0C1F8
	jmp	L0F83A	;@0C1FB
L0C1FE:	call	L0F865	;@0C1FE
	jne	L0C1D6	;@0C201
	call	L0F91B	;@0C203
	mov	cl, 0E4h	;@0C206
	call	L07E7C	;@0C208
	jmp	L0F83A	;@0C20B
L0C20E:	call	L0F865	;@0C20E
	jne	L0C1D6	;@0C211
	call	L0F91B	;@0C213
	push	es	;@0C216
	mov	es, ax	;@0C217
	pop	ax	;@0C219
	mov	cl, 0E6h	;@0C21A
	call	L07E7C	;@0C21C
	jmp	L0F83A	;@0C21F
L0C222:	call	L0F865	;@0C222
	jne	L0C299	;@0C225
	call	L0F91B	;@0C227
	call	L07FC6	;@0C22A
	jmp	L0F83A	;@0C22D
L0C230:	mov	al, 0C5h	;@0C230
	jmp	short L0C236	;@0C232
L0C234:	mov	al, 0C4h	;@0C234
L0C236:	mov	byte ptr ds:[56B8h], al	;@0C236
	call	L0F865	;@0C239
	jne	L0C299	;@0C23C
	call	L0F91B	;@0C23E
	mov	cl, byte ptr ds:[56B8h]	;@0C241
	call	L07F96	;@0C245
	jmp	L0F83A	;@0C248
L0C24B:	call	L0F865	;@0C24B
	jne	L0C299	;@0C24E
	call	L0F90C	;@0C250
	test	word ptr ds:[5160h], 2	;@0C253
	je	@@2	;@0C259
	call	L026B8	;@0C25B
	jne	@@2	;@0C25E
	cmp	ax, word ptr ds:[5838h]	;@0C260
	jne	@@2	;@0C264
	add	si, 2	;@0C266
	push	es	;@0C269
	call	L0F90C	;@0C26A
	call	L026B8	;@0C26D
	pop	dx	;@0C270
	jne	@@1	;@0C271
	cmp	ax, word ptr ds:[5838h]	;@0C273
	jne	@@1	;@0C277
	add	si, 2	;@0C279
	push	dx	;@0C27C
	push	es	;@0C27D
	call	L0F90C	;@0C27E
	pop	ax	;@0C281
	pop	dx	;@0C282
	call	L08896	;@0C283
	jmp	L0F83A	;@0C286
@@1:	mov	ax, dx	;@0C289
	call	L08900	;@0C28B
	jmp	L0F83A	;@0C28E
@@2:	mov	cl, 28h	;@0C291
	call	L0806F	;@0C293
	jmp	L0F83A	;@0C296
L0C299:	jmp	L0265C	;@0C299
L0C29C:	mov	al, 30h	;@0C29C
	jmp	short L0C2AE	;@0C29E
L0C2A0:	mov	al, 20h	;@0C2A0
	jmp	short L0C2AE	;@0C2A2
L0C2A4:	mov	al, 38h	;@0C2A4
	jmp	short L0C2AE	;@0C2A6
L0C2A8:	mov	al, 18h	;@0C2A8
	jmp	short L0C2AE	;@0C2AA
L0C2AC:	mov	al, 10h	;@0C2AC
L0C2AE:	mov	byte ptr ds:[56B8h], al	;@0C2AE
	call	L0F865	;@0C2B1
	jne	L0C299	;@0C2B4
	call	L0F90C	;@0C2B6
	mov	cl, byte ptr ds:[56B8h]	;@0C2B9
	call	L0806F	;@0C2BD
	jmp	L0F83A	;@0C2C0
L0C2C3:	mov	al, 0	;@0C2C3
	jmp	short L0C2DD	;@0C2C5
L0C2C7:	mov	al, 8	;@0C2C7
	jmp	short L0C2DD	;@0C2C9
L0C2CB:	mov	al, 20h	;@0C2CB
	jmp	short L0C2DD	;@0C2CD
L0C2CF:	mov	al, 38h	;@0C2CF
	jmp	short L0C2DD	;@0C2D1
L0C2D3:	mov	al, 28h	;@0C2D3
	jmp	short L0C2DD	;@0C2D5
L0C2D7:	mov	al, 10h	;@0C2D7
	jmp	short L0C2DD	;@0C2D9
L0C2DB:	mov	al, 18h	;@0C2DB
L0C2DD:	mov	byte ptr ds:[56B8h], al	;@0C2DD
	call	L0F865	;@0C2E0
	jne	L0C299	;@0C2E3
	call	L0F91B	;@0C2E5
	mov	cl, byte ptr ds:[56B8h]	;@0C2E8
	call	L08090	;@0C2EC
	jmp	L0F83A	;@0C2EF
L0C2F2:	mov	cl, 0AAh	;@0C2F2
	jmp	short L0C2F8	;@0C2F4
L0C2F6:	mov	cl, 0AEh	;@0C2F6
L0C2F8:	call	L05534	;@0C2F8
	call	L0C303	;@0C2FB
	jmp	L0553B	;@0C2FE
L0C301:	mov	cl, 0ACh	;@0C301
L0C303:	mov	byte ptr ds:[56B8h], cl	;@0C303
	call	L0F865	;@0C307
	jne	L0C299	;@0C30A
	call	L0F90C	;@0C30C
	mov	cl, byte ptr ds:[56B8h]	;@0C30F
	call	L07F6D	;@0C313
	jmp	L0F83A	;@0C316
L0C319:	call	L0F865	;@0C319
	jne	L0C367	;@0C31C
	call	L0A7C0	;@0C31E
	je	@@1	;@0C321
	mov	cl, 0D7h	;@0C323
	call	L07F00	;@0C325
	jmp	L0F83A	;@0C328
@@1:	call	L07F82	;@0C32B
	jmp	L0F83A	;@0C32E
L0C331:	call	L0F865	;@0C331
	jne	L0C367	;@0C334
	call	L05534	;@0C336
	call	L0A7C0	;@0C339
	call	L0553B	;@0C33C
	call	L0F91E	;@0C33F
	mov	cl, 0A4h	;@0C342
	call	L07F31	;@0C344
	jmp	L0F83A	;@0C347
L0C34A:	call	L0F865	;@0C34A
	jne	L0C367	;@0C34D
	call	L0A7C0	;@0C34F
	call	L05534	;@0C352
	call	L0F91E	;@0C355
	push	ax	;@0C358
	call	L0553B	;@0C359
	mov	ax, es	;@0C35C
	pop	es	;@0C35E
	mov	cl, 0A6h	;@0C35F
	call	L07F31	;@0C361
	jmp	L0F83A	;@0C364
L0C367:	jmp	L0265C	;@0C367
L0C36A:	mov	al, 37h	;@0C36A
	jmp	short L0C3CF	;@0C36C
L0C36E:	mov	al, 3Fh	;@0C36E
	jmp	short L0C3CF	;@0C370
L0C372:	mov	al, 0F8h	;@0C372
	jmp	short L0C3CF	;@0C374
L0C376:	mov	al, 0FCh	;@0C376
	jmp	short L0C3CF	;@0C378
L0C37A:	mov	al, 0FAh	;@0C37A
	jmp	short L0C3CF	;@0C37C
L0C37E:	mov	al, 0F5h	;@0C37E
	jmp	short L0C3CF	;@0C380
L0C382:	mov	al, 0A6h	;@0C382
	jmp	short L0C3CF	;@0C384
L0C386:	mov	al, 27h	;@0C386
	jmp	short L0C3CF	;@0C388
L0C38A:	mov	al, 2Fh	;@0C38A
	jmp	short L0C3CF	;@0C38C
L0C38E:	mov	al, 0F4h	;@0C38E
	jmp	short L0C3CF	;@0C390
L0C392:	mov	al, 0CEh	;@0C392
	jmp	short L0C3CF	;@0C394
L0C396:	mov	al, 9Fh	;@0C396
	jmp	short L0C3CF	;@0C398
L0C39A:	mov	al, 0ACh	;@0C39A
	jmp	short L0C3CF	;@0C39C
L0C39E:	mov	al, 0A4h	;@0C39E
	jmp	short L0C3CF	;@0C3A0
L0C3A2:	mov	al, 9Eh	;@0C3A2
	jmp	short L0C3CF	;@0C3A4
L0C3A6:	mov	al, 0AEh	;@0C3A6
	jmp	short L0C3CF	;@0C3A8
L0C3AA:	mov	al, 0F9h	;@0C3AA
	jmp	short L0C3CF	;@0C3AC
L0C3AE:	mov	al, 0FDh	; "Assembling file:   "	;@0C3AE
	jmp	short L0C3CF	;@0C3B0
L0C3B2:	mov	al, 0FBh	;@0C3B2
	jmp	short L0C3CF	;@0C3B4
L0C3B6:	mov	al, 0AAh	;@0C3B6
	jmp	short L0C3CF	;@0C3B8
L0C3BA:	mov	al, 9Bh	;@0C3BA
	jmp	short L0C3CF	;@0C3BC
L0C3BE:	test	word ptr ds:[5160h], 1000h	;@0C3BE
	je	@@1	;@0C3C4
	mov	al, 0D7h	;@0C3C6
	jmp	short L0C3CF	;@0C3C8
@@1:	jmp	L0C319	;@0C3CA
L0C3CD:	mov	al, 90h	;@0C3CD
L0C3CF:	mov	byte ptr ds:[56B8h], al	;@0C3CF
	call	L0F865	;@0C3D2
	jne	L0C367	;@0C3D5
	mov	cl, byte ptr ds:[56B8h]	;@0C3D7
	call	L07F00	;@0C3DB
	jmp	L0F83A	;@0C3DE
L0C3E1:	mov	al, 98h	;@0C3E1
	jmp	short L0C40B	;@0C3E3
L0C3E5:	mov	al, 0A7h	;@0C3E5
	jmp	short L0C40B	;@0C3E7
L0C3E9:	mov	al, 99h	;@0C3E9
	jmp	short L0C40B	;@0C3EB
L0C3ED:	mov	al, 0ADh	;@0C3ED
	jmp	short L0C40B	;@0C3EF
L0C3F1:	mov	al, 0A5h	;@0C3F1
	jmp	short L0C40B	;@0C3F3
L0C3F5:	mov	al, 9Dh	;@0C3F5
	jmp	short L0C40B	;@0C3F7
L0C3F9:	mov	al, 9Ch	;@0C3F9
	jmp	short L0C40B	;@0C3FB
L0C3FD:	mov	al, 0CFh	;@0C3FD
	jmp	short L0C40B	;@0C3FF
L0C401:	mov	al, 0AFh	;@0C401
	jmp	short L0C40B	;@0C403
L0C405:	mov	al, 0C9h	;@0C405
	jmp	short L0C40B	;@0C407
L0C409:	mov	al, 0ABh	;@0C409
L0C40B:	mov	byte ptr ds:[56B8h], al	;@0C40B
	call	L0F865	;@0C40E
	jne	@@1	;@0C411
	mov	cl, byte ptr ds:[56B8h]	;@0C413
	call	L07EF2	;@0C417
	jmp	L0F83A	;@0C41A
@@1:	jmp	L0265C	;@0C41D
L0C420:	mov	al, 0F0h	;@0C420
	jmp	short L0C42A	;@0C422
L0C424:	mov	al, 0F3h	;@0C424
	jmp	short L0C42A	;@0C426
L0C428:	mov	al, 0F2h	;@0C428
L0C42A:	mov	byte ptr ds:[56B8h], al	;@0C42A
	call	L0F865	;@0C42D
	jne	@@1	;@0C430
	mov	cl, byte ptr ds:[56B8h]	;@0C432
	call	L07F0B	;@0C436
	mov	byte ptr ds:[51A9h], 0FFh	;@0C439
@@1:	jmp	word ptr ds:[5734h]	;@0C43E
	db	0B0h, 2Eh, 0EBh, 12h	;@0C442
L0C446:	mov	al, 3Eh	;@0C446
	jmp	short L0C458	;@0C448
L0C44A:	mov	al, 36h	;@0C44A
	jmp	short L0C458	;@0C44C
L0C44E:	mov	al, 26h	;@0C44E
	jmp	short L0C458	;@0C450
L0C452:	mov	al, 64h	;@0C452
	jmp	short L0C458	;@0C454
L0C456:	mov	al, 65h	;@0C456
L0C458:	mov	byte ptr ds:[56B8h], al	;@0C458
	call	L0F865	;@0C45B
	jne	@@1	;@0C45E
	mov	cl, byte ptr ds:[56B8h]	;@0C460
	call	L07F16	;@0C464
	mov	byte ptr ds:[51A9h], 0FFh	;@0C467
@@1:	jmp	word ptr ds:[5734h]	;@0C46C
L0C470:	call	L0F865	;@0C470
	jne	L0C4B4	;@0C473
	call	L0A7C0	;@0C475
	jne	@@3	;@0C478
	test	byte ptr ds:[516Ah], 10h	;@0C47A
	jne	@@1	;@0C47F
	mov	cl, 0C2h	;@0C481
	jmp	short @@2	;@0C483
@@1:	mov	cl, 0CAh	;@0C485
@@2:	call	L08036	;@0C487
	jmp	L0F83A	;@0C48A
@@3:	test	byte ptr ds:[516Ah], 20h	;@0C48D
	je	@@4	;@0C492
	test	byte ptr ds:[51A3h], 10h	;@0C494
	je	@@4	;@0C499
	call	L072EF	;@0C49B
	jmp	L0F83A	;@0C49E
@@4:	test	byte ptr ds:[516Ah], 10h	;@0C4A1
	jne	@@5	;@0C4A6
	mov	cl, 0C3h	;@0C4A8
	jmp	short @@6	;@0C4AA
@@5:	mov	cl, 0CBh	;@0C4AC
@@6:	call	L07F00	;@0C4AE
	jmp	L0F83A	;@0C4B1
L0C4B4:	jmp	L0265C	;@0C4B4
L0C4B7:	test	byte ptr ds:[516Bh], 2	;@0C4B7
	jne	L0C4C2	;@0C4BC
	mov	al, 0C2h	;@0C4BE
	jmp	short L0C4C4	;@0C4C0
L0C4C2:	mov	al, 0CAh	;@0C4C2
L0C4C4:	mov	byte ptr ds:[56B8h], al	;@0C4C4
	call	L0F865	;@0C4C7
	jne	L0C4B4	;@0C4CA
	call	L0A7C0	;@0C4CC
	jne	@@1	;@0C4CF
	mov	cl, byte ptr ds:[56B8h]	;@0C4D1
	call	L08036	;@0C4D5
	jmp	L0F83A	;@0C4D8
@@1:	mov	cl, byte ptr ds:[56B8h]	;@0C4DB
	or	cl, 1	;@0C4DF
	call	L07F00	;@0C4E2
	jmp	L0F83A	;@0C4E5
L0C4E8:	call	L0F865	;@0C4E8
	jne	L0C4B4	;@0C4EB
	call	L0F90C	;@0C4ED
	call	L07DDD	;@0C4F0
	jmp	L0F83A	;@0C4F3
L0C4F6:	mov	al, 77h	;@0C4F6
	jmp	short L0C534	;@0C4F8
L0C4FA:	mov	al, 76h	;@0C4FA
	jmp	short L0C534	;@0C4FC
L0C4FE:	mov	al, 72h	;@0C4FE
	jmp	short L0C534	;@0C500
L0C502:	mov	al, 73h	;@0C502
	jmp	short L0C534	;@0C504
L0C506:	mov	al, 74h	;@0C506
	jmp	short L0C534	;@0C508
L0C50A:	mov	al, 75h	;@0C50A
	jmp	short L0C534	;@0C50C
L0C50E:	mov	al, 7Fh	;@0C50E
	jmp	short L0C534	;@0C510
L0C512:	mov	al, 7Eh	;@0C512
	jmp	short L0C534	;@0C514
L0C516:	mov	al, 7Ch	;@0C516
	jmp	short L0C534	;@0C518
L0C51A:	mov	al, 7Dh	;@0C51A
	jmp	short L0C534	;@0C51C
L0C51E:	mov	al, 70h	;@0C51E
	jmp	short L0C534	;@0C520
L0C522:	mov	al, 71h	;@0C522
	jmp	short L0C534	;@0C524
L0C526:	mov	al, 78h	;@0C526
	jmp	short L0C534	;@0C528
L0C52A:	mov	al, 79h	;@0C52A
	jmp	short L0C534	;@0C52C
L0C52E:	mov	al, 7Bh	;@0C52E
	jmp	short L0C534	;@0C530
L0C532:	mov	al, 7Ah	;@0C532
L0C534:	mov	byte ptr ds:[56B8h], al	;@0C534
	call	L0F865	;@0C537
	jne	L0C568	;@0C53A
	call	L0F90C	;@0C53C
	mov	cl, byte ptr ds:[56B8h]	;@0C53F
	call	L07D6F	;@0C543
	jmp	L0F83A	;@0C546
L0C549:	mov	al, 0E2h	;@0C549
	jmp	short L0C553	;@0C54B
L0C54D:	mov	al, 0E1h	;@0C54D
	jmp	short L0C553	;@0C54F
L0C551:	mov	al, 0E0h	;@0C551
L0C553:	mov	byte ptr ds:[56B8h], al	;@0C553
	call	L0F865	;@0C556
	jne	L0C568	;@0C559
	call	L0F90C	;@0C55B
	mov	cl, byte ptr ds:[56B8h]	;@0C55E
	call	L07CF1	;@0C562
	jmp	L0F83A	;@0C565
L0C568:	jmp	L0265C	;@0C568
L0C56B:	mov	al, 0E3h	;@0C56B
	jmp	short L0C579	;@0C56D
L0C56F:	mov	al, 0E2h	;@0C56F
	jmp	short L0C579	;@0C571
L0C573:	mov	al, 0E1h	;@0C573
	jmp	short L0C579	;@0C575
L0C577:	mov	al, 0E0h	;@0C577
L0C579:	mov	byte ptr ds:[56B8h], al	;@0C579
	call	L0F865	;@0C57C
	jne	L0C568	;@0C57F
	call	L0F90C	;@0C581
	mov	cl, byte ptr ds:[56B8h]	;@0C584
	call	L07CF9	;@0C588
	jmp	L0F83A	;@0C58B
L0C58E:	call	L0F865	;@0C58E
	jne	L0C568	;@0C591
	call	L0F91B	;@0C593
	call	L082FB	;@0C596
	jmp	L0F83A	;@0C599
L0C59C:	call	L0F8A8	;@0C59C
	jne	L0C5DC	;@0C59F
	push	si	;@0C5A1
	call	far ptr L10036	;@0C5A2
	pop	si	;@0C5A7
	jmp	L0F83A	;@0C5A8
L0C5AB:	call	L0F8A8	;@0C5AB
	jne	L0C5DC	;@0C5AE
	call	L026B8	;@0C5B0
	jne	@@2	;@0C5B3
	cmp	ax, word ptr ds:[5880h]	;@0C5B5
	jne	L0C5E4	;@0C5B9
	add	si, 2	;@0C5BB
	call	L026B8	;@0C5BE
	jne	@@1	;@0C5C1
	sub	si, 2	;@0C5C3
	jmp	short L0C5E4	;@0C5C6
@@1:	push	si	;@0C5C8
	call	far ptr L1002C	;@0C5C9
	pop	si	;@0C5CE
	jmp	L0F83A	;@0C5CF
@@2:	push	si	;@0C5D2
	call	far ptr L10036	;@0C5D3
	pop	si	;@0C5D8
	jmp	L0F83A	;@0C5D9
L0C5DC:	jmp	L0265C	;@0C5DC
L0C5DF:	call	L0F8A8	;@0C5DF
	jne	L0C5DC	;@0C5E2
L0C5E4:	call	L0A7C0	;@0C5E4
	jne	@@1	;@0C5E7
	call	L076DE	;@0C5E9
	push	si	;@0C5EC
	mov	cx, ax	;@0C5ED
	call	far ptr L10007	;@0C5EF
	pop	si	;@0C5F4
@@1:	call	L026B8	;@0C5F5
	jne	L0C5DC	;@0C5F8
	cmp	ax, word ptr ds:[5838h]	;@0C5FA
	jne	@@2	;@0C5FE
	add	si, 2	;@0C600
	call	L0A7C0	;@0C603
	jne	@@2	;@0C606
	call	L076DE	;@0C608
	push	si	;@0C60B
	mov	cx, ax	;@0C60C
	call	far ptr L0FFFF	;@0C60E
	pop	si	;@0C613
@@2:	jmp	L0F83A	;@0C614
L0C617:	call	L0F892	;@0C617
	jne	L0C665	;@0C61A
	call	L0F856	;@0C61C
	call	L01BE5	;@0C61F
	je	L0C644	;@0C622
	xor	cx, cx	;@0C624
	jmp	short L0C644	;@0C626
L0C628:	call	L0F892	;@0C628
	jne	L0C5DC	;@0C62B
	call	L026B8	;@0C62D
	jne	L0C65C	;@0C630
	call	L0067F	;@0C632
	jne	L0C65C	;@0C635
	add	si, 2	;@0C637
	mov	es, ax	;@0C63A
	call	L004A1	;@0C63C
	xor	ah, ah	;@0C63F
	call	L04956	;@0C641
L0C644:	push	si	;@0C644
	mov	si, bx	;@0C645
	push	ss	;@0C647
	pop	es	;@0C648
	mov	di, 51ABh	;@0C649
	mov	word ptr ds:[519Ch], cx	;@0C64C
	shr	cx, 1	;@0C650
	rep movsw	;@0C652
	rcl	cx, 1	;@0C654
	rep movsb	;@0C656
	pop	si	;@0C658
	jmp	L0F83A	;@0C659
L0C65C:	mov	cx, 7Ch	;@0C65C
	call	L03208	;@0C65F
	jmp	L0F83A	;@0C662
L0C665:	ret	;@0C665
L0C666:	db	0E8h, 3Fh, 32h	; call L0F8A8	;@0C666
	jne	L0C665	;@0C669
	db	0E8h, 0E8h, 31h	; call L0F856	;@0C66B
	call	L01BE5	;@0C66E
	je	L0C693	;@0C671
	xor	cx, cx	;@0C673
	jmp	short L0C693	;@0C675
L0C677:	call	L0F8A8	;@0C677
	jne	L0C6FB	;@0C67A
	call	L026B8	;@0C67C
	jne	L0C65C	;@0C67F
	call	L0067F	;@0C681
	jne	L0C65C	;@0C684
	add	si, 2	;@0C686
	mov	es, ax	;@0C689
	call	L004A1	;@0C68B
	xor	ah, ah	;@0C68E
	call	L04956	;@0C690
L0C693:	mov	di, bx	;@0C693
	push	ss	;@0C695
	pop	es	;@0C696
	call	far ptr L10027	;@0C697
	db	0E9h, 9Bh, 31h	; jmp L0F83A	;@0C69C
L0C69F:	call	L0F8A8	;@0C69F
	jne	L0C6FB	;@0C6A2
	call	L0F90C	;@0C6A4
	call	L076DE	;@0C6A7
	push	si	;@0C6AA
	mov	cx, ax	;@0C6AB
	call	far ptr L10225	;@0C6AD
	pop	si	;@0C6B2
	jmp	L0F83A	;@0C6B3
L0C6B6:	call	L0F8A8	;@0C6B6
	jne	L0C6FB	;@0C6B9
	call	L0F90C	;@0C6BB
	call	L076DE	;@0C6BE
	push	si	;@0C6C1
	mov	cx, ax	;@0C6C2
	call	far ptr L1022E	;@0C6C4
	pop	si	;@0C6C9
	jmp	L0F83A	;@0C6CA
L0C6CD:	call	L0F8A8	;@0C6CD
	jne	L0C6FB	;@0C6D0
	call	L0F90C	;@0C6D2
	call	L076DE	;@0C6D5
	push	si	;@0C6D8
	mov	cx, ax	;@0C6D9
	call	far ptr L10233	;@0C6DB
	pop	si	;@0C6E0
	jmp	L0F83A	;@0C6E1
L0C6E4:	call	L0F8A8	;@0C6E4
	jne	L0C6FB	;@0C6E7
	call	L0F90C	;@0C6E9
	call	L076DE	;@0C6EC
	push	si	;@0C6EF
	mov	cx, ax	;@0C6F0
	call	far ptr L10238	;@0C6F2
	pop	si	;@0C6F7
	jmp	L0F83A	;@0C6F8
L0C6FB:	jmp	L0265C	;@0C6FB
L0C6FE:	call	L0F8A8	;@0C6FE
	jne	L0C6FB	;@0C701
	call	L0F90C	;@0C703
	call	L076DE	;@0C706
	push	si	;@0C709
	mov	cx, ax	;@0C70A
	call	far ptr L1023D	;@0C70C
	pop	si	;@0C711
	jmp	L0F83A	;@0C712
L0C715:	call	L0F8A8	;@0C715
	jne	L0C6FB	;@0C718
	call	L0F90C	;@0C71A
	call	L076DE	;@0C71D
	push	si	;@0C720
	mov	cx, ax	;@0C721
	call	far ptr L10242	;@0C723
	pop	si	;@0C728
	jmp	L0F83A	;@0C729
L0C72C:	call	L0F892	;@0C72C
	jne	L0C6FB	;@0C72F
	or	word ptr ds:[5198h], 40h	;@0C731
	jmp	L0F83A	;@0C736
L0C739:	call	L0F892	;@0C739
	jne	L0C6FB	;@0C73C
	and	word ptr ds:[5198h], -41h	;@0C73E
	jmp	L0F83A	;@0C743
L0C746:	call	L0F892	;@0C746
	jne	L0C798	;@0C749
	or	word ptr ds:[5198h], 80h	;@0C74B
	jmp	L0F83A	;@0C751
L0C754:	call	L0F892	;@0C754
	jne	L0C798	;@0C757
	and	word ptr ds:[5198h], 0FF7Fh	;@0C759
	jmp	L0F83A	;@0C75F
L0C762:	call	L0F892	;@0C762
	jne	L0C798	;@0C765
	and	word ptr ds:[5198h], 0FCFFh	;@0C767
	jmp	L0F83A	;@0C76D
L0C770:	call	L0F892	;@0C770
	jne	L0C798	;@0C773
	and	word ptr ds:[5198h], 0FEFFh	;@0C775
	or	word ptr ds:[5198h], 200h	;@0C77B
	jmp	L0F83A	;@0C781
L0C784:	call	L0F892	;@0C784
	jne	L0C798	;@0C787
	and	word ptr ds:[5198h], 0FDFFh	;@0C789
	or	word ptr ds:[5198h], 100h	;@0C78F
	jmp	L0F83A	;@0C795
L0C798:	jmp	L0265C	;@0C798
L0C79B:	call	L0F892	;@0C79B
	jne	L0C798	;@0C79E
	or	word ptr ds:[5198h], 0C00h	;@0C7A0
	jmp	L0F83A	;@0C7A6
L0C7A9:	call	L0F892	;@0C7A9
	jne	L0C798	;@0C7AC
	call	L01D7A	;@0C7AE
	jne	L0C7CD	;@0C7B1
	call	L0066E	;@0C7B3
	je	L0C7CD	;@0C7B6
	test	byte ptr ds:[38D7h], 1	;@0C7B8
	je	L0C798	;@0C7BD
	mov	bx, 0C7D6h	;@0C7BF
	call	L0EBF9	;@0C7C2
	jmp	L0F83A	;@0C7C5
L0C7C8:	xor	al, al	;@0C7C8
	dec	al	;@0C7CA
L0C7CC:	ret	;@0C7CC
L0C7CD:	and	word ptr ds:[5198h], 0FBFFh	;@0C7CD
	jmp	L0F83A	;@0C7D3
L0C7D6:	call	L01D7A	;@0C7D6
	jne	L0C7CC	;@0C7D9
	mov	ax, dx	;@0C7DB
	call	L0066E	;@0C7DD
	je	L0C7C8	;@0C7E0
	add	si, 2	;@0C7E2
	push	si	;@0C7E5
	call	far ptr L10216	;@0C7E6
	pop	si	;@0C7EB
	xor	al, al	;@0C7EC
	ret	;@0C7EE
L0C7EF:	db	0E8h, 0A0h, 30h	; call L0F892	;@0C7EF
	jne	L0C82B	;@0C7F2
	or	word ptr ds:[5198h], 1000h	;@0C7F4
	db	0E9h, 3Dh, 30h	; jmp L0F83A	;@0C7FA
L0C7FD:	call	L0F892	;@0C7FD
	jne	L0C82B	;@0C800
	and	word ptr ds:[5198h], 0EFFFh	;@0C802
	jmp	L0F83A	;@0C808
L0C80B:	call	L0F8A8	;@0C80B
	jne	L0C82B	;@0C80E
	mov	al, byte ptr ds:[51A2h]	;@0C810
	cmp	al, 10h	;@0C813
	je	L0C828	;@0C815
	xor	ah, ah	;@0C817
	shl	ax, 1	;@0C819
	mov	bx, ax	;@0C81B
	mov	ax, word ptr ds:[5198h]	;@0C81D
	mov	word ptr [bx+570Ah], ax	;@0C820
	inc	byte ptr ds:[51A2h]	;@0C824
L0C828:	jmp	L0F83A	;@0C828
L0C82B:	jmp	L0265C	;@0C82B
L0C82E:	call	L0F8A8	;@0C82E
	jne	L0C82B	;@0C831
	mov	al, byte ptr ds:[51A2h]	;@0C833
	and	al, al	;@0C836
	je	L0C828	;@0C838
	dec	al	;@0C83A
	xor	ah, ah	;@0C83C
	shl	ax, 1	;@0C83E
	mov	bx, ax	;@0C840
	mov	ax, word ptr [bx+570Ah]	;@0C842
	mov	word ptr ds:[5198h], ax	;@0C846
	dec	byte ptr ds:[51A2h]	;@0C849
	jmp	L0F83A	;@0C84D
L0C850:	call	L0F892	;@0C850
	jne	L0C82B	;@0C853
	or	word ptr ds:[5198h], 8	;@0C855
	and	word ptr ds:[5198h], -21h	;@0C85A
	jmp	L0F83A	;@0C85F
L0C862:	call	L0F892	;@0C862
	jne	L0C82B	;@0C865
	or	word ptr ds:[5198h], 28h	;@0C867
	jmp	L0F83A	;@0C86C
L0C86F:	call	L0F892	;@0C86F
	jne	L0C82B	;@0C872
	and	word ptr ds:[5198h], -9	;@0C874
	jmp	L0F83A	;@0C879
L0C87C:	call	L0F892	;@0C87C
	jne	L0C82B	;@0C87F
	or	word ptr ds:[5198h], 2	;@0C881
	jmp	L0F83A	;@0C886
L0C889:	call	L0F892	;@0C889
	jne	L0C82B	;@0C88C
	and	word ptr ds:[5198h], -3	;@0C88E
	jmp	L0F83A	;@0C893
L0C896:	call	L0F892	;@0C896
	jne	L0C8D7	;@0C899
	or	word ptr ds:[5198h], 10h	;@0C89B
	jmp	L0F83A	;@0C8A0
L0C8A3:	call	L0F892	;@0C8A3
	jne	L0C8D7	;@0C8A6
	and	word ptr ds:[5198h], -11h	;@0C8A8
	jmp	L0F83A	;@0C8AD
L0C8B0:	call	L0F892	;@0C8B0
	jne	L0C8D7	;@0C8B3
	xor	word ptr ds:[5198h], 10h	;@0C8B5
	jmp	L0F83A	;@0C8BA
L0C8BD:	call	L0F892	;@0C8BD
	jne	L0C8D7	;@0C8C0
	or	word ptr ds:[5198h], 4	;@0C8C2
	jmp	L0F83A	;@0C8C7
L0C8CA:	call	L0F892	;@0C8CA
	jne	L0C8D7	;@0C8CD
	and	word ptr ds:[5198h], -5	;@0C8CF
	jmp	L0F83A	;@0C8D4
L0C8D7:	jmp	L0265C	;@0C8D7
L0C8DA:	call	L0F892	;@0C8DA
	jne	L0C8D7	;@0C8DD
	or	word ptr ds:[5198h], 1	;@0C8DF
	jmp	L0F83A	;@0C8E4
L0C8E7:	call	L0F892	;@0C8E7
	jne	L0C8D7	;@0C8EA
	and	word ptr ds:[5198h], -2	;@0C8EC
	jmp	L0F83A	;@0C8F1
L0C8F4:	call	L0F8D7	;@0C8F4
	jne	L0C8D7	;@0C8F7
	call	L03AFA	;@0C8F9
	jmp	L0F83A	;@0C8FC
L0C8FF:	call	L0F8D7	;@0C8FF
	jne	L0C8D7	;@0C902
	cmp	byte ptr ds:[51A5h], 0	;@0C904
	jne	@@1	;@0C909
	call	L073F4	;@0C90B
	mov	byte ptr ds:[51A5h], 0FFh	;@0C90E
	jmp	L0F83A	;@0C913
@@1:	mov	cx, 86h	;@0C916
	call	L03208	;@0C919
	jmp	L0F83A	;@0C91C
L0C91F:	call	L0F8D7	;@0C91F
	jne	L0C8D7	;@0C922
	cmp	word ptr ds:[5194h], 0	;@0C924
	je	@@1	;@0C929
	mov	cx, 49h	;@0C92B
	jmp	L03208	;@0C92E
@@1:	mov	byte ptr ds:[516Bh], 0	;@0C931
	mov	byte ptr ds:[51A4h], 0	;@0C936
	and	byte ptr ds:[516Ah], 3Fh	;@0C93B
L0C940:	call	L026B8	;@0C940
	jne	@@1	;@0C943
	add	si, 2	;@0C945
	push	ss	;@0C948
	pop	es	;@0C949
	mov	di, 57ACh	;@0C94A
	mov	cx, 0Ah	;@0C94D
	repne scasw	;@0C950
	jne	@@1	;@0C952
	mov	bx, 9	;@0C954
	sub	bx, cx	;@0C957
	shl	bx, 1	;@0C959
	jmp	word ptr [bx+2056h]	;@0C95B
@@1:	mov	cx, 5Bh	;@0C95F
	jmp	L03208	;@0C962
L0C965:	or	byte ptr ds:[516Ah], 40h	;@0C965
	jmp	L0C940	;@0C96A
L0C96C:	and	byte ptr ds:[516Ah], 0BFh	;@0C96C
	jmp	L0C940	;@0C971
L0C973:	mov	byte ptr ds:[516Bh], 5	;@0C973
	mov	byte ptr ds:[56C2h], 30h	;@0C978
	mov	byte ptr ds:[56C3h], 30h	;@0C97D
	mov	byte ptr ds:[56C5h], 31h	;@0C982
	jmp	L0CA0C	;@0C987
L0C98A:	mov	byte ptr ds:[516Bh], 1	;@0C98A
	mov	byte ptr ds:[56C2h], 30h	;@0C98F
	mov	byte ptr ds:[56C3h], 30h	;@0C994
	mov	byte ptr ds:[56C5h], 32h	;@0C999
	jmp	short L0CA0C	;@0C99E
L0C9A0:	mov	byte ptr ds:[516Bh], 3	;@0C9A0
	mov	byte ptr ds:[56C2h], 31h	;@0C9A5
	mov	byte ptr ds:[56C3h], 30h	;@0C9AA
	mov	byte ptr ds:[56C5h], 34h	;@0C9AF
	jmp	short L0CA0C	;@0C9B4
L0C9B6:	mov	byte ptr ds:[516Bh], 9	;@0C9B6
	mov	byte ptr ds:[56C2h], 30h	;@0C9BB
	mov	byte ptr ds:[56C3h], 31h	;@0C9C0
	mov	byte ptr ds:[56C5h], 33h	;@0C9C5
	jmp	short L0CA0C	;@0C9CA
L0C9CC:	mov	byte ptr ds:[516Bh], 0Bh	;@0C9CC
	mov	byte ptr ds:[56C2h], 31h	;@0C9D1
	mov	byte ptr ds:[56C3h], 31h	;@0C9D6
	mov	byte ptr ds:[56C5h], 35h	;@0C9DB
	jmp	short L0CA0C	;@0C9E0
L0C9E2:	mov	byte ptr ds:[516Bh], 0Bh	;@0C9E2
	mov	byte ptr ds:[56C2h], 31h	;@0C9E7
	mov	byte ptr ds:[56C3h], 32h	;@0C9EC
	mov	byte ptr ds:[56C5h], 36h	;@0C9F1
	jmp	short L0CA0C	;@0C9F6
L0C9F8:	mov	byte ptr ds:[516Bh], 8Bh	;@0C9F8
	mov	byte ptr ds:[56C2h], 31h	;@0C9FD
	mov	byte ptr ds:[56C3h], 32h	;@0CA02
	mov	byte ptr ds:[56C5h], 37h	;@0CA07
L0CA0C:	call	L0CB61	;@0CA0C
	test	byte ptr ds:[516Bh], 80h	;@0CA0F
	jne	@@1	;@0CA14
	mov	es, word ptr ds:[5784h]	;@0CA16
	call	L01312	;@0CA1A
	jne	@@2	;@0CA1D
	call	L035AC	;@0CA1F
	call	L0132A	;@0CA22
	mov	es, word ptr ds:[576Ah]	;@0CA25
	mov	ax, word ptr ds:[5784h]	;@0CA29
	db	0E8h, 0FAh, 2Ah	; call L0F529	;@0CA2C
@@1:	mov	es, word ptr ds:[5768h]	;@0CA2F
	mov	ax, word ptr ds:[5784h]	;@0CA33
	db	0E8h, 0F0h, 2Ah	; call L0F529	;@0CA36
	call	L0CC89	;@0CA39
	call	L0CDCE	;@0CA3C
	call	L0CC7A	;@0CA3F
	call	L0EBCB	;@0CA42
@@2:	call	L026B8	;@0CA45
	jne	L0CAB6	;@0CA48
	cmp	ax, word ptr ds:[5838h]	;@0CA4A
	jne	L0CAB6	;@0CA4E
	add	si, 2	;@0CA50
	call	L0EC22	;@0CA53
	db	0E8h, 0F3h, 21h	; call L0EC4C	;@0CA56
	jne	@@3	;@0CA59
	mov	al, byte ptr ds:[56DEh]	;@0CA5B
	mov	byte ptr ds:[51A4h], al	;@0CA5E
	mov	al, byte ptr ds:[56DDh]	;@0CA61
	or	byte ptr ds:[516Bh], al	;@0CA64
	and	al, 30h	;@0CA68
	or	al, byte ptr ds:[51A4h]	;@0CA6A
	mov	byte ptr ds:[51A3h], al	;@0CA6E
	call	L026B8	;@0CA71
	jne	L0CAB6	;@0CA74
	cmp	ax, word ptr ds:[5838h]	;@0CA76
	jne	L0CAB6	;@0CA7A
	add	si, 2	;@0CA7C
	call	L026B8	;@0CA7F
	jne	@@4	;@0CA82
	push	ss	;@0CA84
	pop	es	;@0CA85
	mov	di, 57ACh	;@0CA86
	mov	cx, 2	;@0CA89
	repne scasw	;@0CA8C
	jne	@@4	;@0CA8E
	add	si, 2	;@0CA90
	mov	bx, 1	;@0CA93
	sub	bx, cx	;@0CA96
	shl	bx, 1	;@0CA98
	jmp	word ptr [bx+206Ah]	;@0CA9A
@@3:	mov	cx, 77h	;@0CA9E
	jmp	L03208	;@0CAA1
@@4:	mov	cx, 5Bh	;@0CAA4
	jmp	L03208	;@0CAA7
L0CAAA:	and	byte ptr ds:[516Ah], 0BFh	;@0CAAA
	jmp	short L0CAB6	;@0CAAF
	db	80h, 0Eh, 'jQ@'	;@0CAB1
L0CAB6:	test	byte ptr ds:[516Bh], 80h	;@0CAB6
	jne	@@4	;@0CABB
	mov	ax, word ptr ds:[5784h]	;@0CABD
	mov	dx, ax	;@0CAC0
	call	L068C8	;@0CAC2
	push	es	;@0CAC5
	mov	cx, word ptr ds:[563Ch]	;@0CAC6
	call	L07667	;@0CACA
	pop	es	;@0CACD
	test	byte ptr ds:[516Ah], 40h	;@0CACE
	jne	@@1	;@0CAD3
	push	es	;@0CAD5
	mov	cx, word ptr ds:[563Ah]	;@0CAD6
	call	L07667	;@0CADA
	pop	es	;@0CADD
	jmp	short @@2	;@0CADE
@@1:	push	es	;@0CAE0
	call	L05542	;@0CAE1
	mov	cx, word ptr ds:[563Ah]	;@0CAE4
	call	L07667	;@0CAE8
	pop	es	;@0CAEB
@@2:	test	byte ptr ds:[516Bh], 4	;@0CAEC
	je	@@3	;@0CAF1
	mov	cx, word ptr ds:[5638h]	;@0CAF3
	call	L07667	;@0CAF7
@@3:	db	0E9h, 3Dh, 2Dh	; jmp L0F83A	;@0CAFA
@@4:	call	L05542	;@0CAFD
	mov	cx, word ptr ds:[563Ch]	;@0CB00
	push	es	;@0CB04
	call	L07667	;@0CB05
	pop	es	;@0CB08
	mov	cx, word ptr ds:[563Ah]	;@0CB09
	call	L07667	;@0CB0D
	db	0E9h, 27h, 2Dh	; jmp L0F83A	;@0CB10
L0CB13:	mov	byte ptr ds:[516Bh], 33h	;@0CB13
	or	byte ptr ds:[516Ah], 80h	;@0CB18
	mov	byte ptr ds:[51A3h], 30h	;@0CB1D
	mov	byte ptr ds:[51A4h], 0	;@0CB22
	mov	byte ptr ds:[56C2h], 30h	;@0CB27
	mov	byte ptr ds:[56C3h], 31h	;@0CB2C
	mov	byte ptr ds:[56C5h], 30h	;@0CB31
	call	L0CB61	;@0CB36
	call	L0CC89	;@0CB39
	call	L0CDCE	;@0CB3C
	call	L0CC7A	;@0CB3F
	call	L0EBCB	;@0CB42
	mov	es, word ptr ds:[576Ah]	;@0CB45
	mov	ax, word ptr ds:[5772h]	;@0CB49
	call	L0F529	;@0CB4C
	mov	ax, word ptr ds:[5772h]	;@0CB4F
	mov	dx, ax	;@0CB52
	call	L068C8	;@0CB54
	mov	cx, word ptr ds:[563Ch]	;@0CB57
	call	L07667	;@0CB5B
	jmp	L0F83A	;@0CB5E
L0CB61:	mov	bx, 56C2h	;@0CB61
	mov	cx, 1	;@0CB64
	call	L003DA	;@0CB67
	mov	es, word ptr ds:[575Ah]	;@0CB6A
	db	0E8h, 0B8h, 29h	; call L0F529	;@0CB6E
	mov	bx, 56C3h	;@0CB71
	mov	cx, 1	;@0CB74
	call	L003DA	;@0CB77
	mov	es, word ptr ds:[575Ch]	;@0CB7A
	db	0E8h, 0A8h, 29h	; call L0F529	;@0CB7E
	mov	bx, 56C5h	;@0CB81
	mov	cx, 1	;@0CB84
	call	L003DA	;@0CB87
	mov	es, word ptr ds:[5764h]	;@0CB8A
	db	0E9h, 98h, 29h	; jmp L0F529	;@0CB8E
L0CB91:	call	L0F8D7	;@0CB91
	jne	L0CC07	;@0CB94
	cmp	word ptr ds:[5194h], 0	;@0CB96
	jne	L0CC01	;@0CB9B
	test	byte ptr ds:[516Bh], 1	;@0CB9D
	je	L0CBFB	;@0CBA2
	call	L0CC89	;@0CBA4
	call	L0EBCB	;@0CBA7
	jmp	L0F83A	;@0CBAA
L0CBAD:	call	L0F8D7	;@0CBAD
	jne	L0CC07	;@0CBB0
	cmp	word ptr ds:[5194h], 0	;@0CBB2
	jne	L0CC01	;@0CBB7
	test	byte ptr ds:[516Bh], 1	;@0CBB9
	je	L0CBFB	;@0CBBE
	test	word ptr ds:[5160h], 1000h	;@0CBC0
	je	@@1	;@0CBC6
	call	L0CC7A	;@0CBC8
@@1:	call	L0CD0B	;@0CBCB
	test	word ptr ds:[5160h], 1000h	;@0CBCE
	jne	@@2	;@0CBD4
	call	L0CC7A	;@0CBD6
@@2:	call	L0EBCB	;@0CBD9
	jmp	L0F83A	;@0CBDC
L0CBDF:	call	L0F8D7	;@0CBDF
	jne	L0CC07	;@0CBE2
	cmp	word ptr ds:[5194h], 0	;@0CBE4
	jne	L0CC01	;@0CBE9
	test	byte ptr ds:[516Bh], 1	;@0CBEB
	je	L0CBFB	;@0CBF0
	call	L0CD69	;@0CBF2
	call	L0EBCB	;@0CBF5
	jmp	L0F83A	;@0CBF8
L0CBFB:	mov	cx, 70h	;@0CBFB
	jmp	L03208	;@0CBFE
L0CC01:	mov	cx, 49h	;@0CC01
	jmp	L03208	;@0CC04
L0CC07:	jmp	L0265C	;@0CC07
L0CC0A:	call	L0F8D7	;@0CC0A
	jne	L0CC07	;@0CC0D
	cmp	word ptr ds:[5194h], 0	;@0CC0F
	jne	L0CC01	;@0CC14
	test	byte ptr ds:[516Bh], 1	;@0CC16
	je	L0CBFB	;@0CC1B
	call	L0CD7E	;@0CC1D
	call	L0EBCB	;@0CC20
	jmp	L0F83A	;@0CC23
L0CC26:	call	L0F8D7	;@0CC26
	jne	L0CC07	;@0CC29
	cmp	word ptr ds:[5194h], 0	;@0CC2B
	jne	L0CC01	;@0CC30
	test	byte ptr ds:[516Bh], 1	;@0CC32
	je	L0CBFB	;@0CC37
	call	L0CDCE	;@0CC39
	call	L0EBCB	;@0CC3C
	jmp	L0F83A	;@0CC3F
L0CC42:	call	L0F8D7	;@0CC42
	jne	L0CC07	;@0CC45
	cmp	word ptr ds:[5194h], 0	;@0CC47
	jne	L0CC01	;@0CC4C
	test	byte ptr ds:[516Bh], 1	;@0CC4E
	je	L0CBFB	;@0CC53
	call	L0CDF4	;@0CC55
	call	L0EBCB	;@0CC58
	jmp	L0F83A	;@0CC5B
L0CC5E:	call	L0F8D7	;@0CC5E
	jne	L0CC07	;@0CC61
	cmp	word ptr ds:[5194h], 0	;@0CC63
	jne	L0CC01	;@0CC68
	test	byte ptr ds:[516Bh], 1	;@0CC6A
	je	L0CBFB	;@0CC6F
	call	L0CE0E	;@0CC71
	call	L0EBCB	;@0CC74
	jmp	L0F83A	;@0CC77
L0CC7A:	cmp	byte ptr ds:[51AAh], 0	;@0CC7A
	je	@@1	;@0CC7F
	dec	byte ptr ds:[51AAh]	;@0CC81
	jmp	L0400B	;@0CC85
@@1:	ret	;@0CC88
L0CC89:	call	L0CC7A	;@0CC89
	test	byte ptr ds:[516Ah], 80h	;@0CC8C
	jne	@@5	;@0CC91
	call	L026B8	;@0CC93
	jne	@@2	;@0CC96
	call	L0066E	;@0CC98
	je	@@2	;@0CC9B
	add	si, 2	;@0CC9D
	test	byte ptr ds:[516Bh], 2	;@0CCA0
	jne	@@3	;@0CCA5
	mov	cx, 8081h	;@0CCA7
	call	L03208	;@0CCAA
@@1:	mov	ax, word ptr ds:[577Eh]	;@0CCAD
	mov	dx, ax	;@0CCB0
	jmp	short @@3	;@0CCB2
@@2:	test	byte ptr ds:[516Bh], 2	;@0CCB4
	je	@@1	;@0CCB9
	mov	ax, word ptr ds:[577Eh]	;@0CCBB
	call	L0CEBB	;@0CCBE
@@3:	mov	cx, word ptr ds:[5770h]	;@0CCC1
	mov	bl, 48h	;@0CCC5
	test	byte ptr ds:[5160h], 8	;@0CCC7
	je	@@4	;@0CCCC
	and	bl, 1Fh	;@0CCCE
	or	bl, 0A0h	;@0CCD1
@@4:	test	byte ptr ds:[516Bh], 4	;@0CCD4
	je	@@6	;@0CCD9
	mov	ax, dx	;@0CCDB
	mov	di, 2	;@0CCDD
	jmp	L0CE5E	;@0CCE0
@@5:	mov	ax, word ptr ds:[5770h]	;@0CCE3
	mov	dx, ax	;@0CCE6
	xor	cx, cx	;@0CCE8
	mov	bl, 28h	;@0CCEA
@@6:	push	ax	;@0CCEC
	push	dx	;@0CCED
	mov	ax, dx	;@0CCEE
	mov	di, 2	;@0CCF0
	call	L0CE6E	;@0CCF3
	mov	es, word ptr ds:[5768h]	;@0CCF6
	pop	ax	;@0CCFA
	push	ax	;@0CCFB
	db	0E8h, 2Ah, 28h	; call L0F529	;@0CCFC
	pop	dx	;@0CCFF
	pop	ax	;@0CD00
	call	L068C8	;@0CD01
	mov	cx, word ptr ds:[5638h]	;@0CD04
	jmp	L07667	;@0CD08
L0CD0B:	test	byte ptr ds:[516Ah], 80h	;@0CD0B
	jne	@@5	;@0CD10
	push	word ptr ds:[5166h]	;@0CD12
	and	word ptr ds:[5166h], 0DFFFh	;@0CD16
	mov	ax, word ptr ds:[5778h]	;@0CD1C
	mov	cx, ax	;@0CD1F
	mov	bl, 74h	;@0CD21
	test	byte ptr ds:[516Ah], 40h	;@0CD23
	mov	dx, 0CE6Eh	;@0CD28
	jne	@@1	;@0CD2B
	test	byte ptr ds:[516Bh], 80h	;@0CD2D
	jne	@@1	;@0CD32
	mov	dx, 0CE5Eh	;@0CD34
@@1:	mov	di, 3	;@0CD37
	call	dx	;@0CD3A
	pop	word ptr ds:[5166h]	;@0CD3C
	call	L0A7C0	;@0CD40
	je	@@2	;@0CD43
	call	L05542	;@0CD45
@@2:	call	L076DE	;@0CD48
	mov	dx, cx	;@0CD4B
	or	cx, ax	;@0CD4D
	jne	@@3	;@0CD4F
	mov	ax, 400h	;@0CD51
@@3:	sub	ax, word ptr ds:[5154h]	;@0CD54
	sbb	dx, word ptr ds:[5156h]	;@0CD58
	jb	@@4	;@0CD5C
	add	word ptr ds:[5154h], ax	;@0CD5E
	adc	word ptr ds:[5156h], dx	;@0CD62
@@4:	ret	;@0CD66
@@5:	jmp	short L0CDBF	;@0CD67
L0CD69:	test	byte ptr ds:[516Ah], 80h	;@0CD69
	jne	L0CDBF	;@0CD6E
	call	L0CC7A	;@0CD70
	mov	ax, word ptr ds:[577Ah]	;@0CD73
	mov	cx, ax	;@0CD76
	mov	di, word ptr ds:[576Ch]	;@0CD78
	jmp	short L0CD91	;@0CD7C
L0CD7E:	test	byte ptr ds:[516Ah], 80h	;@0CD7E
	jne	L0CDBF	;@0CD83
	call	L0CC7A	;@0CD85
	mov	ax, word ptr ds:[577Ch]	;@0CD88
	mov	cx, ax	;@0CD8B
	mov	di, word ptr ds:[576Eh]	;@0CD8D
L0CD91:	mov	bl, 60h	;@0CD91
	push	ax	;@0CD93
	push	bx	;@0CD94
	push	cx	;@0CD95
	push	di	;@0CD96
	call	L026B8	;@0CD97
	pop	di	;@0CD9A
	pop	cx	;@0CD9B
	pop	bx	;@0CD9C
	pop	ax	;@0CD9D
	jne	@@1	;@0CD9E
	push	ax	;@0CDA0
	mov	ax, dx	;@0CDA1
	call	L0066E	;@0CDA3
	pop	ax	;@0CDA6
	je	@@1	;@0CDA7
	add	si, 2	;@0CDA9
	mov	ax, dx	;@0CDAC
@@1:	push	ax	;@0CDAE
	push	bx	;@0CDAF
	push	cx	;@0CDB0
	mov	es, di	;@0CDB1
	db	0E8h, 73h, 27h	; call L0F529	;@0CDB3
	pop	cx	;@0CDB6
	pop	bx	;@0CDB7
	pop	ax	;@0CDB8
	mov	di, 3	;@0CDB9
	jmp	L0CE6E	;@0CDBC
L0CDBF:	test	word ptr ds:[5166h], 4000h	;@0CDBF
	je	@@1	;@0CDC5
	mov	cx, 807Fh	;@0CDC7
	call	L03208	;@0CDCA
@@1:	ret	;@0CDCD
L0CDCE:	call	L0CC7A	;@0CDCE
	test	byte ptr ds:[516Ah], 80h	;@0CDD1
	jne	@@1	;@0CDD6
	test	byte ptr ds:[516Bh], 80h	;@0CDD8
	jne	L0CE38	;@0CDDD
	mov	ax, word ptr ds:[5780h]	;@0CDDF
	mov	cx, word ptr ds:[5772h]	;@0CDE2
	jmp	short L0CE4B	;@0CDE6
@@1:	mov	bl, 48h	;@0CDE8
	mov	ax, word ptr ds:[5772h]	;@0CDEA
	xor	cx, cx	;@0CDED
	mov	di, 3	;@0CDEF
	jmp	short L0CE6E	;@0CDF2
L0CDF4:	test	byte ptr ds:[516Ah], 80h	;@0CDF4
	jne	L0CDBF	;@0CDF9
	call	L0CC7A	;@0CDFB
	test	byte ptr ds:[516Bh], 80h	;@0CDFE
	jne	L0CE38	;@0CE03
	mov	ax, word ptr ds:[5782h]	;@0CE05
	mov	cx, word ptr ds:[5776h]	;@0CE08
	jmp	short L0CE4B	;@0CE0C
L0CE0E:	test	byte ptr ds:[516Ah], 80h	;@0CE0E
	jne	L0CDBF	;@0CE13
	call	L0CC7A	;@0CE15
	test	byte ptr ds:[516Bh], 80h	;@0CE18
	jne	L0CE38	;@0CE1D
	push	word ptr ds:[5166h]	;@0CE1F
	and	word ptr ds:[5166h], 0DFFFh	;@0CE23
	mov	ax, word ptr ds:[5774h]	;@0CE29
	mov	cx, word ptr ds:[5772h]	;@0CE2C
	call	L0CE4B	;@0CE30
	pop	word ptr ds:[5166h]	;@0CE33
	ret	;@0CE37
L0CE38:	mov	ax, word ptr ds:[5780h]	;@0CE38
	call	L0CEBB	;@0CE3B
	mov	ax, dx	;@0CE3E
	mov	cx, word ptr ds:[5772h]	;@0CE40
	mov	di, word ptr ds:[576Ah]	;@0CE44
	jmp	L0CD91	;@0CE48
L0CE4B:	mov	bl, 48h	;@0CE4B
	test	word ptr ds:[5160h], 8	;@0CE4D
	je	@@1	;@0CE53
	and	bl, 1Fh	;@0CE55
	or	bl, 0A0h	;@0CE58
@@1:	mov	di, 3	;@0CE5B
L0CE5E:	mov	es, ax	;@0CE5E
	push	ax	;@0CE60
	push	bx	;@0CE61
	push	cx	;@0CE62
	push	di	;@0CE63
	mov	ax, word ptr ds:[5784h]	;@0CE64
	call	L0148E	;@0CE67
	pop	di	;@0CE6A
	pop	cx	;@0CE6B
	pop	bx	;@0CE6C
	pop	ax	;@0CE6D
L0CE6E:	mov	word ptr ds:[56BAh], ax	;@0CE6E
	mov	word ptr ds:[56E8h], cx	;@0CE71
	call	L0075E	;@0CE75
	jne	@@1	;@0CE78
	mov	es, ax	;@0CE7A
	call	L0154B	;@0CE7C
	mov	byte ptr ds:[56EDh], cl	;@0CE7F
	mov	word ptr ds:[56EAh], ax	;@0CE83
	mov	byte ptr ds:[56ECh], 0FFh	;@0CE86
	jmp	short @@3	;@0CE8B
@@1:	test	word ptr ds:[5160h], 1000h	;@0CE8D
	jne	@@2	;@0CE93
	test	word ptr ds:[5160h], 8	;@0CE95
	je	@@2	;@0CE9B
	or	bl, 1	;@0CE9D
	or	di, 4	;@0CEA0
@@2:	mov	word ptr ds:[56E8h], cx	;@0CEA3
	mov	byte ptr ds:[56EDh], bl	;@0CEA7
	mov	word ptr ds:[56EAh], di	;@0CEAB
	mov	byte ptr ds:[56ECh], 0	;@0CEAF
@@3:	inc	byte ptr ds:[51AAh]	;@0CEB4
	jmp	L0E92E	;@0CEB8
L0CEBB:	push	ax	;@0CEBB
	mov	dx, word ptr ds:[575Eh]	;@0CEBC
	call	L00692	;@0CEC0
	mov	ax, dx	;@0CEC3
	mov	es, ax	;@0CEC5
	call	L004A1	;@0CEC7
	call	far ptr L0FCFE	;@0CECA
	call	far ptr L0FCE0	;@0CECF
	xor	bx, bx	;@0CED4
	call	L0498E	;@0CED6
	mov	bx, cx	;@0CED9
	pop	ax	;@0CEDB
	mov	es, ax	;@0CEDC
	call	L004A1	;@0CEDE
	call	L0498E	;@0CEE1
	jmp	L003E8	;@0CEE4
L0CEE7:	mov	dx, ax	;@0CEE7
	call	L0F8D7	;@0CEE9
	jne	L0CF58	;@0CEEC
	mov	byte ptr ds:[38DBh], 0FFh	;@0CEEE
	push	dx	;@0CEF3
	call	L071B7	;@0CEF4
	pop	dx	;@0CEF7
	jmp	short L0CF29	;@0CEF8
L0CEFA:	mov	dx, ax	;@0CEFA
	push	bx	;@0CEFC
	call	L0F8D7	;@0CEFD
	pop	bx	;@0CF00
	jne	L0CF58	;@0CF01
	test	word ptr ds:[5160h], bx	;@0CF03
	jne	L0CF1A	;@0CF07
	push	dx	;@0CF09
	mov	cx, 808Dh	;@0CF0A
	call	L03208	;@0CF0D
	pop	dx	;@0CF10
	jmp	short L0CF1A	;@0CF11
L0CF13:	mov	dx, ax	;@0CF13
	call	L0F8D7	;@0CF15
	jne	L0CF58	;@0CF18
L0CF1A:	mov	ax, word ptr ds:[5160h]	;@0CF1A
	and	ax, 0F2FFh	;@0CF1D
	jmp	short L0CF2F	;@0CF20
L0CF22:	mov	dx, ax	;@0CF22
	db	0E8h, 0B0h, 29h	; call L0F8D7	;@0CF24
	jne	L0CF58	;@0CF27
L0CF29:	mov	ax, word ptr ds:[5160h]	;@0CF29
	and	ax, 0F261h	;@0CF2C
L0CF2F:	or	ax, dx	;@0CF2F
	mov	word ptr ds:[5160h], ax	;@0CF31
	db	0E8h, 0D5h, 25h	; call L0F50C	;@0CF34
	test	word ptr ds:[5160h], 8	;@0CF37
	mov	bx, 56C4h	;@0CF3D
	mov	byte ptr [bx], 32h	;@0CF40
	je	@@1	;@0CF43
	mov	byte ptr [bx], 34h	;@0CF45
@@1:	mov	cx, 1	;@0CF48
	call	L003DA	;@0CF4B
	mov	es, word ptr ds:[5762h]	;@0CF4E
	db	0E8h, 0D4h, 25h	; call L0F529	;@0CF52
	db	0E9h, 0E2h, 28h	; jmp L0F83A	;@0CF55
L0CF58:	jmp	L0265C	;@0CF58
	db	0B8h, 0, 1, 0EBh, 0C2h	;@0CF5B
L0CF60:	mov	ax, 102h	;@0CF60
	jmp	L0CF22	;@0CF63
L0CF65:	mov	ax, 506h	;@0CF65
	jmp	L0CF22	;@0CF68
L0CF6A:	mov	ax, 586h	;@0CF6A
	jmp	L0CF22	;@0CF6D
L0CF6F:	mov	ax, 0D0Eh	;@0CF6F
	jmp	L0CEE7	;@0CF72
L0CF75:	mov	ax, 0D8Eh	;@0CF75
	jmp	L0CEE7	;@0CF78
L0CF7B:	mov	ax, 0D1Eh	;@0CF7B
	jmp	L0CEE7	;@0CF7E
L0CF81:	mov	ax, 0D9Eh	;@0CF81
	jmp	L0CEE7	;@0CF84
L0CF87:	xor	ax, ax	;@0CF87
	jmp	L0CF13	;@0CF89
L0CF8B:	mov	ax, 100h	;@0CF8B
	jmp	L0CF13	;@0CF8E
L0CF90:	mov	ax, 500h	;@0CF90
	mov	bx, 4	;@0CF93
	jmp	L0CEFA	;@0CF96
L0CF99:	mov	ax, 0D00h	;@0CF99
	mov	bx, 8	;@0CF9C
	jmp	L0CEFA	;@0CF9F
L0CFA2:	call	L0F8D7	;@0CFA2
	jne	L0CF58	;@0CFA5
	call	L0EB9C	;@0CFA7
	or	word ptr ds:[5166h], ax	;@0CFAA
	jmp	L0F83A	;@0CFAE
L0CFB1:	call	L0F8D7	;@0CFB1
	jne	L0CF58	;@0CFB4
	call	L0EB9C	;@0CFB6
	not	ax	;@0CFB9
	and	word ptr ds:[5166h], ax	;@0CFBB
	jmp	L0F83A	;@0CFBF
L0CFC2:	call	L0F8D7	;@0CFC2
	jne	L0CF58	;@0CFC5
	and	word ptr ds:[5160h], 0BFFFh	;@0CFC7
	call	L0F3C5	;@0CFCD
	jmp	L0F83A	;@0CFD0
L0CFD3:	call	L0F8D7	;@0CFD3
	jne	L0CF58	;@0CFD6
	or	word ptr ds:[5160h], 4000h	;@0CFD8
	call	L0F3C5	;@0CFDE
	jmp	L0F83A	;@0CFE1
L0CFE4:	call	L0F8D7	;@0CFE4
	jne	L0D056	;@0CFE7
	or	word ptr ds:[5160h], 200h	;@0CFE9
	jmp	L0F83A	;@0CFEF
L0CFF2:	call	L0F8D7	;@0CFF2
	jne	L0D056	;@0CFF5
	and	word ptr ds:[5160h], 0FDFFh	;@0CFF7
	jmp	L0F83A	;@0CFFD
L0D000:	call	L0F8D7	;@0D000
	jne	L0D056	;@0D003
	or	word ptr ds:[5160h], 40h	;@0D005
	jmp	L0F83A	;@0D00A
L0D00D:	call	L0F8D7	;@0D00D
	jne	L0D056	;@0D010
	and	word ptr ds:[5160h], -41h	;@0D012
	jmp	L0F83A	;@0D017
L0D01A:	call	L0F8D7	;@0D01A
	jne	L0D056	;@0D01D
	or	word ptr ds:[5160h], 0B000h	;@0D01F
	call	L0F3C5	;@0D025
	jmp	L0F83A	;@0D028
	db	0E9h, 2Eh, 56h	;@0D02B
L0D02E:	call	L0F8D7	;@0D02E
	jne	L0D056	;@0D031
	and	word ptr ds:[5160h], 6FFFh	;@0D033
	or	word ptr ds:[5160h], 2000h	;@0D039
	call	L0F3C5	;@0D03F
	jmp	L0F83A	;@0D042
L0D045:	call	L0F8D7	;@0D045
	jne	L0D056	;@0D048
	and	word ptr ds:[5160h], 4FFFh	;@0D04A
	call	L0F3C5	;@0D050
	jmp	L0F83A	;@0D053
L0D056:	jmp	L0265C	;@0D056
L0D059:	call	L0F8D7	;@0D059
	jne	L0D056	;@0D05C
	or	word ptr ds:[5160h], 1	;@0D05E
	jmp	L0F83A	;@0D063
L0D066:	call	L0F8D7	;@0D066
	jne	L0D056	;@0D069
	and	word ptr ds:[5160h], -2	;@0D06B
	jmp	L0F83A	;@0D070
L0D073:	call	L0F8D7	;@0D073
	jne	L0D056	;@0D076
	or	word ptr ds:[5160h], 20h	;@0D078
	jmp	L0F83A	;@0D07D
L0D080:	call	L0F8D7	;@0D080
	jne	L0D056	;@0D083
	and	word ptr ds:[5160h], -21h	;@0D085
	jmp	L0F83A	;@0D08A
L0D08D:	call	L0F8D7	;@0D08D
	jne	L0D056	;@0D090
	or	word ptr ds:[5160h], 8000h	;@0D092
	call	L026B8	;@0D098
	jne	@@2	;@0D09B
	mov	ax, dx	;@0D09D
	call	L0066E	;@0D09F
	je	@@1	;@0D0A2
	add	si, 2	;@0D0A4
	mov	es, ax	;@0D0A7
	call	L004A1	;@0D0A9
	cmp	cl, 2	;@0D0AC
	jne	@@1	;@0D0AF
	mov	ax, word ptr es:[di]	;@0D0B1
	mov	word ptr ds:[5164h], ax	;@0D0B4
	jmp	L0F83A	;@0D0B7
@@1:	mov	cx, 29h	;@0D0BA
	call	L03208	;@0D0BD
@@2:	jmp	L0F83A	;@0D0C0
L0D0C3:	call	L0F8D7	;@0D0C3
	jne	L0D056	;@0D0C6
	and	word ptr ds:[5160h], 7FFFh	;@0D0C8
	jmp	L0F83A	;@0D0CE
L0D0D1:	call	L0F8D7	;@0D0D1
	jne	@@1	;@0D0D4
	call	L0F856	;@0D0D6
	call	L01BE5	;@0D0D9
	jmp	short L0D0FB	;@0D0DC
@@1:	ret	;@0D0DE
L0D0DF:	db	0E8h, 0F5h, 27h	; call L0F8D7	;@0D0DF
	jne	L0D11D	;@0D0E2
	call	L026B8	;@0D0E4
	jne	L0D114	;@0D0E7
	call	L0067F	;@0D0E9
	jne	L0D114	;@0D0EC
	add	si, 2	;@0D0EE
	mov	es, ax	;@0D0F1
	call	L004A1	;@0D0F3
	xor	ah, ah	;@0D0F6
	call	L04956	;@0D0F8
L0D0FB:	test	byte ptr ds:[38D7h], 3	;@0D0FB
	jne	L0D11D	;@0D100
	push	si	;@0D102
	mov	si, bx	;@0D103
	add	si, cx	;@0D105
	mov	byte ptr [si], 0	;@0D107
	mov	di, cx	;@0D10A
	inc	di	;@0D10C
	call	L00000	;@0D10D
	pop	si	;@0D110
	db	0E9h, 26h, 27h	; jmp L0F83A	;@0D111
L0D114:	mov	cx, 7Ch	;@0D114
	call	L03208	;@0D117
	db	0E9h, 1Dh, 27h	; jmp L0F83A	;@0D11A
L0D11D:	jmp	L0265C	;@0D11D
L0D120:	call	L0F8D7	;@0D120
	jne	L0D11D	;@0D123
	and	byte ptr ds:[516Ah], 0F0h	;@0D125
	call	L0EB7A	;@0D12A
	and	cx, cx	;@0D12D
	jne	@@2	;@0D12F
	cmp	ax, 11h	;@0D131
	jae	@@2	;@0D134
	cmp	al, 10h	;@0D136
	je	@@1	;@0D138
	cmp	al, 0Ah	;@0D13A
	je	@@1	;@0D13C
	cmp	al, 8	;@0D13E
	je	@@1	;@0D140
	cmp	al, 2	;@0D142
	jne	@@2	;@0D144
@@1:	dec	al	;@0D146
	or	byte ptr ds:[516Ah], al	;@0D148
	jmp	L0F83A	;@0D14C
@@2:	mov	cx, 3Ah	;@0D14F
	call	L03208	;@0D152
	jmp	L0F83A	;@0D155
L0D158:	call	L0F856	;@0D158
	call	L01C23	;@0D15B
	jcxz	@@3	;@0D15E
	mov	al, byte ptr [bx]	;@0D160
	inc	bx	;@0D162
	dec	cx	;@0D163
@@1:	and	cx, cx	;@0D164
	jne	@@2	;@0D166
	push	ax	;@0D168
	call	L0F557	;@0D169
	pop	ax	;@0D16C
	push	ax	;@0D16D
	call	L01C23	;@0D16E
	pop	ax	;@0D171
	jmp	@@1	;@0D172
@@2:	cmp	al, byte ptr [bx]	;@0D174
	je	@@3	;@0D176
	inc	bx	;@0D178
	dec	cx	;@0D179
	jmp	@@1	;@0D17A
@@3:	ret	;@0D17C
L0D17D:	db	0E8h, 57h, 27h	; call L0F8D7	;@0D17D
	jne	L0D1E6	;@0D180
	call	L0A7C0	;@0D182
	jne	@@1	;@0D185
	call	L076DE	;@0D187
	jcxz	L0D19A	;@0D18A
@@1:	test	word ptr ds:[5160h], 8	;@0D18C
	mov	ax, 4	;@0D192
	jne	L0D19A	;@0D195
	mov	ax, 2	;@0D197
L0D19A:	cmp	word ptr ds:[5194h], 0	;@0D19A
	jne	L0D1DD	;@0D19F
	mov	cx, word ptr ds:[5162h]	;@0D1A1
	jcxz	L0D1D8	;@0D1A5
	mov	es, cx	;@0D1A7
	mov	cx, ax	;@0D1A9
	dec	cx	;@0D1AB
	xor	bx, bx	;@0D1AC
@@1:	shr	ax, 1	;@0D1AE
	jb	L0D1C8	;@0D1B0
	inc	bl	;@0D1B2
	cmp	bl, 10h	;@0D1B4
	jne	@@1	;@0D1B7
L0D1B9:	test	word ptr ds:[5166h], 2	;@0D1B9
	jne	@@1	;@0D1BF
	ret	;@0D1C1
@@1:	mov	cx, 8059h	;@0D1C2
	jmp	L03208	;@0D1C5
L0D1C8:	and	ax, ax	;@0D1C8
	jne	L0D1B9	;@0D1CA
	push	cx	;@0D1CC
	cmp	bl, 5	;@0D1CD
	jae	L0D1FC	;@0D1D0
	shl	bx, 1	;@0D1D2
	jmp	word ptr [bx+1FF0h]	;@0D1D4
L0D1D8:	mov	cx, 30h	;@0D1D8
	jmp	short L0D1E0	;@0D1DB
L0D1DD:	mov	cx, 49h	;@0D1DD
L0D1E0:	call	L03208	;@0D1E0
	db	0E9h, 54h, 26h	; jmp L0F83A	;@0D1E3
L0D1E6:	jmp	L0265C	;@0D1E6
	db	59h	;@0D1E9
L0D1EA:	db	0E9h, 4Dh, 26h	; jmp L0F83A	;@0D1EA
L0D1ED:	call	L006EC	;@0D1ED
	jmp	short L0D1FF	;@0D1F0
L0D1F2:	call	L006F5	;@0D1F2
	jmp	short L0D1FF	;@0D1F5
	db	0E8h, 8, 35h, 0EBh, 3	;@0D1F7
L0D1FC:	call	L00713	;@0D1FC
L0D1FF:	jne	@@1	;@0D1FF
	call	L0D1B9	;@0D201
@@1:	pop	cx	;@0D204
@@2:	mov	ax, word ptr ds:[5154h]	;@0D205
	test	ax, cx	;@0D208
	je	L0D1EA	;@0D20A
	mov	es, word ptr ds:[5162h]	;@0D20C
	call	L006E5	;@0D210
	jne	@@4	;@0D213
	test	byte ptr ds:[38D7h], 0Bh	;@0D215
	jne	@@3	;@0D21A
	or	byte ptr ds:[38D8h], 1	;@0D21C
@@3:	push	cx	;@0D221
	xor	cl, cl	;@0D222
	call	L07A5C	;@0D224
	pop	cx	;@0D227
	jmp	@@2	;@0D228
@@4:	inc	ax	;@0D22A
	test	ax, cx	;@0D22B
	je	@@5	;@0D22D
	push	cx	;@0D22F
	mov	cl, 87h	;@0D230
	call	L07F00	;@0D232
	mov	cl, 0DBh	;@0D235
	call	L07F00	;@0D237
	pop	cx	;@0D23A
	jmp	@@2	;@0D23B
@@5:	push	cx	;@0D23D
	mov	cl, 90h	;@0D23E
	call	L07F00	;@0D240
	pop	cx	;@0D243
	jmp	@@2	;@0D244
L0D246:	call	L0F8D7	;@0D246
	jne	L0D1E6	;@0D249
	mov	ax, 2	;@0D24B
	jmp	L0D19A	;@0D24E
L0D251:	call	L0F8D7	;@0D251
	jne	L0D1E6	;@0D254
	cmp	word ptr ds:[5194h], 0	;@0D256
	jne	L0D1DD	;@0D25B
	mov	cx, word ptr ds:[5162h]	;@0D25D
	jcxz	@@2	;@0D261
	test	byte ptr ds:[5154h], 1	;@0D263
	je	@@1	;@0D268
	mov	ax, 1	;@0D26A
	call	L0420A	;@0D26D
@@1:	jmp	L0F83A	;@0D270
@@2:	jmp	L0D1D8	;@0D273
L0D276:	call	L0F8D7	;@0D276
	jne	L0D2C3	;@0D279
	push	si	;@0D27B
	call	far ptr L115E0	;@0D27C
	pop	si	;@0D281
	jmp	L0F83A	;@0D282
L0D285:	call	L0F8D7	;@0D285
	jne	L0D2C3	;@0D288
	mov	cx, 28h	;@0D28A
	call	L03208	;@0D28D
	jmp	L0F83A	;@0D290
L0D293:	call	L0F8D7	;@0D293
	jne	L0D2C3	;@0D296
	call	L026B8	;@0D298
	jne	@@2	;@0D29B
	mov	ax, dx	;@0D29D
	call	L0066E	;@0D29F
	je	@@2	;@0D2A2
	add	si, 2	;@0D2A4
	test	word ptr ds:[5160h], 1000h	;@0D2A7
	je	@@1	;@0D2AD
	mov	es, ax	;@0D2AF
	call	L004A1	;@0D2B1
	call	L03F2D	;@0D2B4
@@1:	jmp	L0F83A	;@0D2B7
@@2:	mov	cx, 74h	;@0D2BA
	call	L03208	;@0D2BD
	jmp	L0F83A	;@0D2C0
L0D2C3:	jmp	L0265C	;@0D2C3
L0D2C6:	call	L0F8D7	;@0D2C6
	jne	L0D2C3	;@0D2C9
	cmp	word ptr ds:[5194h], 0	;@0D2CB
	je	@@1	;@0D2D0
	mov	cx, 49h	;@0D2D2
	jmp	L03208	;@0D2D5
@@1:	call	L0A7C0	;@0D2D8
	jne	@@2	;@0D2DB
	call	L076B0	;@0D2DD
	mov	dx, cx	;@0D2E0
	call	L03F41	;@0D2E2
	jmp	L0F83A	;@0D2E5
@@2:	mov	cx, 2	;@0D2E8
	jmp	L03208	;@0D2EB
L0D2EE:	call	L0F8D7	;@0D2EE
	jne	L0D2C3	;@0D2F1
L0D2F3:	mov	cx, 3Bh	;@0D2F3
	call	L03208	;@0D2F6
	db	0E9h, 3Eh, 25h	; jmp L0F83A	;@0D2F9
L0D2FC:	call	L0F8D7	;@0D2FC
	jne	L0D35F	;@0D2FF
	call	L0D4BD	;@0D301
	jne	L0D2F3	;@0D304
	jmp	L0F83A	;@0D306
L0D309:	call	L0F8D7	;@0D309
	jne	L0D35F	;@0D30C
	call	L0D4BD	;@0D30E
	je	L0D2F3	;@0D311
	jmp	L0F83A	;@0D313
L0D316:	call	L0F8D7	;@0D316
	jne	L0D35F	;@0D319
	test	byte ptr ds:[38D7h], 8	;@0D31B
	je	L0D2F3	;@0D320
	jmp	L0F83A	;@0D322
L0D325:	call	L0F8D7	;@0D325
	jne	L0D35F	;@0D328
	test	byte ptr ds:[38D7h], 8	;@0D32A
	jne	L0D2F3	;@0D32F
	cmp	word ptr ds:[38C6h], 0	;@0D331
	je	@@1	;@0D336
	mov	byte ptr ds:[38DEh], 0FFh	;@0D338
	jmp	short @@2	;@0D33D
@@1:	test	word ptr ds:[5166h], 10h	;@0D33F
	je	@@2	;@0D345
	mov	cx, 805Ch	;@0D347
	call	L03208	;@0D34A
@@2:	jmp	L0F83A	;@0D34D
L0D350:	call	L0F8D7	;@0D350
	jne	L0D35F	;@0D353
	call	L0D4CB	;@0D355
	je	@@1	;@0D358
	jmp	L0D2F3	;@0D35A
@@1:	jmp	L0F83A	;@0D35C
L0D35F:	jmp	L0265C	;@0D35F
L0D362:	call	L0F8D7	;@0D362
	jne	L0D35F	;@0D365
	call	L0D4CB	;@0D367
	jne	@@1	;@0D36A
	jmp	L0D2F3	;@0D36C
@@1:	jmp	L0F83A	;@0D36E
L0D371:	call	L0F8D7	;@0D371
	jne	L0D391	;@0D374
	call	L0D4F3	;@0D376
	je	@@1	;@0D379
	jmp	L0D2F3	;@0D37B
@@1:	jmp	L0F83A	;@0D37E
L0D381:	call	L0F8D7	;@0D381
	jne	L0D391	;@0D384
	call	L0D4F3	;@0D386
	jne	@@1	;@0D389
	jmp	L0D2F3	;@0D38B
@@1:	jmp	L0F83A	;@0D38E
L0D391:	ret	;@0D391
L0D392:	db	0E8h, 42h, 25h	; call L0F8D7	;@0D392
	jne	L0D391	;@0D395
	call	L0D4FB	;@0D397
	je	@@1	;@0D39A
	jmp	L0D2F3	;@0D39C
@@1:	db	0E9h, 98h, 24h	; jmp L0F83A	;@0D39F
L0D3A2:	call	L0F8D7	;@0D3A2
	jne	L0D391	;@0D3A5
	call	L0D4FB	;@0D3A7
	jne	@@1	;@0D3AA
	jmp	L0D2F3	;@0D3AC
@@1:	jmp	L0F83A	;@0D3AF
L0D3B2:	call	L0F8D7	;@0D3B2
	jne	L0D391	;@0D3B5
	call	L0D55C	;@0D3B7
	jne	L0D391	;@0D3BA
	mov	cx, 3Bh	;@0D3BC
	jmp	L03208	;@0D3BF
L0D3C2:	call	L0F8D7	;@0D3C2
	jne	L0D391	;@0D3C5
	call	L0D55C	;@0D3C7
	je	L0D391	;@0D3CA
	mov	cx, 3Bh	;@0D3CC
	jmp	L03208	;@0D3CF
L0D3D2:	call	L0F8C3	;@0D3D2
	jne	L0D431	;@0D3D5
	call	L0D4BD	;@0D3D7
	jne	L0D436	;@0D3DA
	jmp	short L0D416	;@0D3DC
L0D3DE:	call	L0F8C3	;@0D3DE
	jne	L0D431	;@0D3E1
	call	L0D4BD	;@0D3E3
	je	L0D436	;@0D3E6
	jmp	short L0D416	;@0D3E8
L0D3EA:	call	L0F8C3	;@0D3EA
	jne	L0D431	;@0D3ED
	test	byte ptr ds:[38D7h], 8	;@0D3EF
	jne	L0D416	;@0D3F4
	call	L0D4A2	;@0D3F6
	jmp	short L0D436	;@0D3F9
L0D3FB:	call	L0F8C3	;@0D3FB
	jne	L0D431	;@0D3FE
	test	byte ptr ds:[38D7h], 8	;@0D400
	jne	L0D436	;@0D405
	call	L0D4A2	;@0D407
	jmp	short L0D416	;@0D40A
L0D40C:	call	L0F8C3	;@0D40C
	jne	L0D431	;@0D40F
	call	L0D4CB	;@0D411
	jne	L0D436	;@0D414
L0D416:	mov	al, byte ptr ds:[51A6h]	;@0D416
	inc	al	;@0D419
	mov	byte ptr ds:[51A6h], al	;@0D41B
	mov	byte ptr ds:[51A7h], al	;@0D41E
	mov	byte ptr ds:[51A8h], 0	;@0D421
	test	word ptr ds:[5160h], 2000h	;@0D426
	je	L0D44C	;@0D42C
	db	0E9h, 9, 24h	; jmp L0F83A	;@0D42E
L0D431:	inc	byte ptr ds:[51A6h]	;@0D431
	ret	;@0D435
L0D436:	mov	al, byte ptr ds:[51A6h]	;@0D436
	inc	al	;@0D439
	mov	byte ptr ds:[51A6h], al	;@0D43B
	mov	byte ptr ds:[51A8h], al	;@0D43E
	test	word ptr ds:[5160h], 2000h	;@0D441
	je	L0D44C	;@0D447
	db	0E9h, 0EEh, 23h	; jmp L0F83A	;@0D449
L0D44C:	ret	;@0D44C
L0D44D:	db	0E8h, 73h, 24h	; call L0F8C3	;@0D44D
	jne	L0D431	;@0D450
	call	L0D4CB	;@0D452
	je	L0D436	;@0D455
	jmp	L0D416	;@0D457
L0D459:	call	L0F8C3	;@0D459
	jne	L0D431	;@0D45C
	call	L0D4F3	;@0D45E
	jne	L0D436	;@0D461
	jmp	L0D416	;@0D463
L0D465:	call	L0F8C3	;@0D465
	jne	L0D431	;@0D468
	call	L0D4F3	;@0D46A
	je	L0D436	;@0D46D
	jmp	L0D416	;@0D46F
L0D471:	call	L0F8C3	;@0D471
	jne	L0D431	;@0D474
	call	L0D4FB	;@0D476
	jne	L0D436	;@0D479
	jmp	L0D416	;@0D47B
L0D47D:	call	L0F8C3	;@0D47D
	jne	L0D431	;@0D480
	call	L0D4FB	;@0D482
	je	L0D436	;@0D485
	jmp	L0D416	;@0D487
L0D489:	call	L0F8C3	;@0D489
	jne	L0D431	;@0D48C
	call	L0D55C	;@0D48E
	je	L0D436	;@0D491
	jmp	L0D416	;@0D493
L0D495:	call	L0F8C3	;@0D495
	jne	L0D431	;@0D498
	call	L0D55C	;@0D49A
	jne	L0D436	;@0D49D
	jmp	L0D416	;@0D49F
L0D4A2:	cmp	word ptr ds:[38C6h], 0	;@0D4A2
	je	@@2	;@0D4A7
	mov	byte ptr ds:[38DEh], 0FFh	;@0D4A9
@@1:	ret	;@0D4AE
@@2:	test	word ptr ds:[5166h], 10h	;@0D4AF
	je	@@1	;@0D4B5
	mov	cx, 805Ch	;@0D4B7
	jmp	L03208	;@0D4BA
L0D4BD:	call	L0A7C0	;@0D4BD
	jne	@@1	;@0D4C0
	call	L076DE	;@0D4C2
	or	ax, cx	;@0D4C5
	ret	;@0D4C7
@@1:	xor	ax, ax	;@0D4C8
	ret	;@0D4CA
L0D4CB:	call	L01D7A	;@0D4CB
	jne	@@3	;@0D4CE
	add	si, 2	;@0D4D0
	push	dx	;@0D4D3
	call	L05702	;@0D4D4
	pop	ax	;@0D4D7
	jae	@@1	;@0D4D8
	jmp	L007A1	;@0D4DA
@@1:	xor	al, al	;@0D4DD
	dec	al	;@0D4DF
@@2:	ret	;@0D4E1
@@3:	test	word ptr ds:[5160h], 1000h	;@0D4E2
	je	@@2	;@0D4E8
	mov	cx, 0Dh	;@0D4EA
	call	L03208	;@0D4ED
	xor	al, al	;@0D4F0
	ret	;@0D4F2
L0D4F3:	call	L0D525	;@0D4F3
	jne	L0D4FA	;@0D4F6
	repe cmpsb	;@0D4F8
L0D4FA:	ret	;@0D4FA
L0D4FB:	call	L0D525	;@0D4FB
	jne	L0D4FA	;@0D4FE
	jcxz	L0D4FA	;@0D500
@@1:	lodsb	;@0D502
	cmp	al, 61h	;@0D503
	jb	@@2	;@0D505
	cmp	al, 7Bh	;@0D507
	jae	@@2	;@0D509
	sub	al, 20h	;@0D50B
@@2:	mov	ah, byte ptr es:[di]	;@0D50D
	inc	di	;@0D510
	cmp	ah, 61h	;@0D511
	jb	@@3	;@0D514
	cmp	ah, 7Bh	;@0D516
	jae	@@3	;@0D519
	sub	ah, 20h	;@0D51B
@@3:	cmp	al, ah	;@0D51E
	jne	L0D4FA	;@0D520
	loop	@@1	;@0D522
	ret	;@0D524
L0D525:	db	0E8h, 2Eh, 23h	; call L0F856	;@0D525
	call	L01C52	;@0D528
	jne	@@1	;@0D52B
	push	bx	;@0D52D
	push	cx	;@0D52E
	call	L026B8	;@0D52F
	pop	cx	;@0D532
	pop	bx	;@0D533
	jne	@@1	;@0D534
	cmp	ax, word ptr ds:[5838h]	;@0D536
	je	@@2	;@0D53A
@@1:	mov	cx, 83h	;@0D53C
	call	L03208	;@0D53F
	xor	al, al	;@0D542
	dec	al	;@0D544
	ret	;@0D546
@@2:	add	si, 2	;@0D547
	push	cx	;@0D54A
	push	bx	;@0D54B
	call	L01C52	;@0D54C
	pop	si	;@0D54F
	pop	ax	;@0D550
	jne	@@1	;@0D551
	xor	ax, cx	;@0D553
	jne	@@3	;@0D555
	mov	di, bx	;@0D557
	push	ss	;@0D559
	pop	es	;@0D55A
@@3:	ret	;@0D55B
L0D55C:	call	L0F856	;@0D55C
	call	L01C52	;@0D55F
	jne	@@1	;@0D562
	and	cx, cx	;@0D564
	ret	;@0D566
@@1:	mov	cx, 83h	;@0D567
	call	L03208	;@0D56A
	xor	al, al	;@0D56D
	ret	;@0D56F
L0D570:	mov	bx, 0D3D2h	;@0D570
	jmp	short L0D5AA	;@0D573
L0D575:	mov	bx, 0D3DEh	;@0D575
	jmp	short L0D5AA	;@0D578
L0D57A:	mov	bx, 0D3EAh	;@0D57A
	jmp	short L0D5AA	;@0D57D
L0D57F:	mov	bx, 0D3FBh	;@0D57F
	jmp	short L0D5AA	;@0D582
L0D584:	mov	bx, 0D40Ch	;@0D584
	jmp	short L0D5AA	;@0D587
L0D589:	mov	bx, 0D44Dh	;@0D589
	jmp	short L0D5AA	;@0D58C
L0D58E:	mov	bx, 0D459h	;@0D58E
	jmp	short L0D5AA	;@0D591
L0D593:	mov	bx, 0D465h	;@0D593
	jmp	short L0D5AA	;@0D596
L0D598:	mov	bx, 0D471h	;@0D598
	jmp	short L0D5AA	;@0D59B
L0D59D:	mov	bx, 0D47Dh	;@0D59D
	jmp	short L0D5AA	;@0D5A0
L0D5A2:	mov	bx, 0D489h	;@0D5A2
	jmp	short L0D5AA	;@0D5A5
L0D5A7:	mov	bx, 0D495h	;@0D5A7
L0D5AA:	push	bx	;@0D5AA
	db	0E8h, 15h, 23h	; call L0F8C3	;@0D5AB
	pop	bx	;@0D5AE
	mov	al, byte ptr ds:[51A6h]	;@0D5AF
	and	al, al	;@0D5B2
	je	L0D5F3	;@0D5B4
	cmp	al, byte ptr ds:[51A8h]	;@0D5B6
	je	L0D5EF	;@0D5BA
	cmp	al, byte ptr ds:[51A7h]	;@0D5BC
	jne	L0D5F2	;@0D5C0
	mov	byte ptr ds:[51A7h], 0	;@0D5C2
	dec	byte ptr ds:[51A6h]	;@0D5C7
	jmp	bx	;@0D5CB
L0D5CD:	call	L0F8C3	;@0D5CD
	mov	al, byte ptr ds:[51A6h]	;@0D5D0
	and	al, al	;@0D5D3
	je	L0D5F3	;@0D5D5
	cmp	al, byte ptr ds:[51A8h]	;@0D5D7
	je	L0D5EF	;@0D5DB
	cmp	al, byte ptr ds:[51A7h]	;@0D5DD
	je	@@1	;@0D5E1
	ret	;@0D5E3
@@1:	mov	byte ptr ds:[51A8h], al	;@0D5E4
	mov	byte ptr ds:[51A7h], 0	;@0D5E7
	jmp	L0F83A	;@0D5EC
L0D5EF:	mov	byte ptr ds:[51A7h], al	;@0D5EF
L0D5F2:	ret	;@0D5F2
L0D5F3:	mov	cx, 37h	;@0D5F3
	jmp	L03208	;@0D5F6
L0D5F9:	call	L0F8C3	;@0D5F9
	mov	al, byte ptr ds:[51A6h]	;@0D5FC
	and	al, al	;@0D5FF
	je	L0D5F3	;@0D601
	dec	byte ptr ds:[51A6h]	;@0D603
	cmp	al, byte ptr ds:[51A7h]	;@0D607
	jne	@@1	;@0D60B
	mov	byte ptr ds:[51A7h], 0	;@0D60D
@@1:	cmp	byte ptr ds:[51A7h], 0	;@0D612
	jne	@@2	;@0D617
	mov	al, byte ptr ds:[51A6h]	;@0D619
	mov	byte ptr ds:[51A8h], al	;@0D61C
@@2:	jmp	L0F83A	;@0D61F
L0D622:	call	L0F8D7	;@0D622
	jne	L0D63B	;@0D625
	call	L0D65A	;@0D627
	jne	L0D643	;@0D62A
	push	si	;@0D62C
	call	far ptr L113A1	;@0D62D
	call	far ptr L1148D	;@0D632
	pop	si	;@0D637
	jmp	L0F83A	;@0D638
L0D63B:	call	L0D65A	;@0D63B
	jne	L0D649	;@0D63E
	jmp	L0265C	;@0D640
L0D643:	mov	cx, 11h	;@0D643
	call	L03208	;@0D646
L0D649:	ret	;@0D649
L0D64A:	db	0E8h, 8Ah, 22h	; call L0F8D7	;@0D64A
	jne	L0D63B	;@0D64D
	call	L0D65A	;@0D64F
	jne	L0D643	;@0D652
	call	L03B09	;@0D654
	db	0E9h, 0E0h, 21h	; jmp L0F83A	;@0D657
L0D65A:	test	word ptr ds:[5160h], 1000h	;@0D65A
	jne	@@1	;@0D660
	db	0E8h, 0F1h, 21h	; call L0F856	;@0D662
	call	L01D39	;@0D665
	jne	@@2	;@0D668
	ret	;@0D66A
@@1:	call	L026B8	;@0D66B
	jne	@@2	;@0D66E
	call	L0067F	;@0D670
	jne	@@2	;@0D673
	add	si, 2	;@0D675
	mov	es, ax	;@0D678
	call	L004A1	;@0D67A
	xor	ah, ah	;@0D67D
	call	L04956	;@0D67F
	xor	al, al	;@0D682
@@2:	ret	;@0D684
L0D685:	db	0E8h, 4Fh, 22h	; call L0F8D7	;@0D685
	jne	L0D6CB	;@0D688
	or	word ptr ds:[38C4h], 10h	;@0D68A
	db	0E9h, 0A8h, 21h	; jmp L0F83A	;@0D68F
L0D692:	call	L0F8D7	;@0D692
	jne	L0D6CB	;@0D695
	and	word ptr ds:[38C4h], -11h	;@0D697
	jmp	L0F83A	;@0D69C
L0D69F:	call	L0F8D7	;@0D69F
	jne	L0D6CB	;@0D6A2
	test	word ptr ds:[38C4h], 4008h	;@0D6A4
	jne	L0D6CB	;@0D6AA
	call	L01D7A	;@0D6AC
	jne	L0D6CB	;@0D6AF
	push	ss	;@0D6B1
	pop	es	;@0D6B2
	mov	di, 57C0h	;@0D6B3
	mov	cx, 6	;@0D6B6
	repne scasw	;@0D6B9
	jne	L0D6CB	;@0D6BB
	add	si, 2	;@0D6BD
	mov	bx, 5	;@0D6C0
	sub	bx, cx	;@0D6C3
	shl	bx, 1	;@0D6C5
	jmp	word ptr [bx+204Ah]	;@0D6C7
L0D6CB:	jmp	L0265C	;@0D6CB
L0D6CE:	call	L026B8	;@0D6CE
	jne	L0D6CB	;@0D6D1
	add	si, 2	;@0D6D3
	mov	es, ax	;@0D6D6
	call	L004A1	;@0D6D8
	call	far ptr L0FCFE	;@0D6DB
	call	L03B25	;@0D6E0
	call	L026B8	;@0D6E3
	jne	@@1	;@0D6E6
	cmp	ax, word ptr ds:[5880h]	;@0D6E8
	je	L0D6CB	;@0D6EC
@@1:	jmp	L03B34	;@0D6EE
L0D6F1:	call	L0A7C0	;@0D6F1
	jne	L0D6CB	;@0D6F4
	call	L076DE	;@0D6F6
	dec	ax	;@0D6F9
	jmp	L03BA4	;@0D6FA
L0D6FD:	call	L026B8	;@0D6FD
	jne	L0D6CB	;@0D700
	add	si, 2	;@0D702
	mov	es, ax	;@0D705
	call	L004A1	;@0D707
	xor	ah, ah	;@0D70A
	call	L04956	;@0D70C
	call	L003D0	;@0D70F
	mov	es, dx	;@0D712
	call	L004A1	;@0D714
	mov	byte ptr ds:[38DCh], 0FFh	;@0D717
	jmp	L03F2D	;@0D71C
L0D71F:	call	L026B8	;@0D71F
	jne	L0D6CB	;@0D722
	mov	ax, dx	;@0D724
	push	dx	;@0D726
	call	L004C7	;@0D727
	test	al, 20h	;@0D72A
	je	@@2	;@0D72C
	add	si, 2	;@0D72E
	call	L0A7C0	;@0D731
	jne	@@2	;@0D734
	call	L076DE	;@0D736
	push	ax	;@0D739
	call	L0A7C0	;@0D73A
	jne	@@1	;@0D73D
	call	L076DE	;@0D73F
	mov	ch, al	;@0D742
	pop	bx	;@0D744
	pop	ax	;@0D745
	mov	es, ax	;@0D746
	push	bx	;@0D748
	push	cx	;@0D749
	push	si	;@0D74A
	call	L01282	;@0D74B
	mov	di, si	;@0D74E
	pop	si	;@0D750
	pop	cx	;@0D751
	pop	bx	;@0D752
	jmp	L03B74	;@0D753
@@1:	pop	bx	;@0D756
@@2:	pop	dx	;@0D757
	ret	;@0D758
L0D759:	db	0E8h, 9, 21h	; call L0F865	;@0D759
	jne	@@3	;@0D75C
	mov	word ptr ds:[56C6h], si	;@0D75E
	call	L0A7C0	;@0D762
	jne	@@2	;@0D765
	mov	word ptr ds:[56C8h], si	;@0D767
	call	L026B8	;@0D76B
	je	@@4	;@0D76E
@@1:	call	L07E39	;@0D770
	db	0E9h, 0C4h, 20h	; jmp L0F83A	;@0D773
@@2:	mov	cx, 0Dh	;@0D776
	call	L03208	;@0D779
	call	L05542	;@0D77C
	jmp	@@1	;@0D77F
@@3:	jmp	L0265C	;@0D781
@@4:	push	es	;@0D784
	call	L0EC22	;@0D785
	db	0E8h, 0C1h, 14h	; call L0EC4C	;@0D788
	pop	es	;@0D78B
	call	L026B8	;@0D78C
	jne	@@1	;@0D78F
	test	byte ptr ds:[56DDh], 10h	;@0D791
	je	@@1	;@0D796
	cmp	ax, word ptr ds:[5838h]	;@0D798
	jne	@@1	;@0D79C
	add	si, 2	;@0D79E
	push	si	;@0D7A1
	call	L0265C	;@0D7A2
	push	ss	;@0D7A5
	pop	es	;@0D7A6
	mov	di, 2074h	;@0D7A7
	mov	cx, 8	;@0D7AA
	call	far ptr L11510	;@0D7AD
	pop	si	;@0D7B2
	mov	word ptr ds:[56E2h], 0	;@0D7B3
	mov	bx, 0D811h	;@0D7B9
	test	byte ptr ds:[56DDh], 20h	;@0D7BC
	jne	@@5	;@0D7C1
	mov	bx, 0D817h	;@0D7C3
@@5:	call	bx	;@0D7C6
	push	ss	;@0D7C8
	pop	es	;@0D7C9
	push	si	;@0D7CA
	mov	di, 52C2h	;@0D7CB
	mov	si, 207Ch	;@0D7CE
	call	L04ADB	;@0D7D1
	mov	si, word ptr ds:[56C6h]	;@0D7D4
	mov	bx, word ptr ds:[56C8h]	;@0D7D8
	call	L0D892	;@0D7DC
	mov	al, 0Dh	;@0D7DF
	stosb	;@0D7E1
	mov	bx, 52C2h	;@0D7E2
	call	far ptr L11570	;@0D7E5
	test	byte ptr ds:[56DDh], 20h	;@0D7EA
	jne	@@6	;@0D7EF
	mov	ax, word ptr ds:[56E2h]	;@0D7F1
	and	ax, ax	;@0D7F4
	je	@@6	;@0D7F6
	push	ss	;@0D7F8
	pop	es	;@0D7F9
	mov	di, 2092h	;@0D7FA
	call	L04AA9	;@0D7FD
	mov	bx, 208Ah	;@0D800
	call	far ptr L11570	;@0D803
@@6:	call	far ptr L115CF	;@0D808
	pop	si	;@0D80D
	db	0E9h, 29h, 20h	; jmp L0F83A	;@0D80E
L0D811:	mov	bx, 0D845h	;@0D811
	jmp	L0EBF9	;@0D814
L0D817:	push	si	;@0D817
	call	L026B8	;@0D818
	je	@@1	;@0D81B
	mov	cx, 10h	;@0D81D
	call	L03208	;@0D820
	pop	ax	;@0D823
	ret	;@0D824
@@1:	add	si, 2	;@0D825
	cmp	ax, word ptr ds:[5838h]	;@0D828
	je	@@2	;@0D82C
	call	L026B8	;@0D82E
	je	@@1	;@0D831
	mov	word ptr ds:[56CCh], si	;@0D833
	jmp	short @@3	;@0D837
@@2:	call	L0D817	;@0D839
@@3:	pop	si	;@0D83C
	call	L0D845	;@0D83D
	mov	si, word ptr ds:[56CCh]	;@0D840
	ret	;@0D844
L0D845:	push	si	;@0D845
	push	ss	;@0D846
	pop	es	;@0D847
	mov	di, 52C2h	;@0D848
	mov	si, 2083h	;@0D84B
	call	L04ADB	;@0D84E
	pop	si	;@0D851
	push	es	;@0D852
	push	di	;@0D853
	push	si	;@0D854
	call	L0A7C0	;@0D855
	je	@@1	;@0D858
	pop	ax	;@0D85A
	pop	ax	;@0D85B
	pop	ax	;@0D85C
	ret	;@0D85D
@@1:	or	byte ptr ds:[38D8h], 1	;@0D85E
	call	L07176	;@0D863
	mov	byte ptr ds:[38D8h], 0	;@0D866
	add	word ptr ds:[56E2h], ax	;@0D86B
	mov	bx, si	;@0D86F
	pop	si	;@0D871
	pop	di	;@0D872
	pop	es	;@0D873
	call	L0D892	;@0D874
	push	es	;@0D877
	push	di	;@0D878
	push	si	;@0D879
	call	L0A7C0	;@0D87A
	je	@@1	;@0D87D
	pop	ax	;@0D87F
	pop	di	;@0D880
	pop	es	;@0D881
	mov	al, 0Dh	;@0D882
	stosb	;@0D884
	push	si	;@0D885
	mov	bx, 52C2h	;@0D886
	call	far ptr L11570	;@0D889
	pop	si	;@0D88E
	xor	al, al	;@0D88F
	ret	;@0D891
L0D892:	push	es	;@0D892
	push	di	;@0D893
	push	bx	;@0D894
	call	L026B8	;@0D895
	pop	bx	;@0D898
	mov	ax, dx	;@0D899
	pop	di	;@0D89B
	pop	es	;@0D89C
	and	ah, ah	;@0D89D
	je	@@1	;@0D89F
	push	bx	;@0D8A1
	push	si	;@0D8A2
	call	L04AC9	;@0D8A3
	pop	si	;@0D8A6
	pop	bx	;@0D8A7
	mov	al, 20h	;@0D8A8
	stosb	;@0D8AA
	jmp	short @@2	;@0D8AB
@@1:	stosb	;@0D8AD
@@2:	add	si, 2	;@0D8AE
	cmp	si, bx	;@0D8B1
	jne	L0D892	;@0D8B3
	ret	;@0D8B5
L0D8B6:	db	0E8h, 1Eh, 20h	; call L0F8D7	;@0D8B6
	jne	@@2	;@0D8B9
	db	0E8h, 0F3h, 16h	; call L0EFB1	;@0D8BB
	call	L0D991	;@0D8BE
	test	byte ptr ds:[51A3h], 80h	;@0D8C1
	je	@@1	;@0D8C6
	sub	ax, word ptr ds:[5184h]	;@0D8C8
	sbb	dx, word ptr ds:[5186h]	;@0D8CC
@@1:	mov	word ptr ds:[56E2h], ax	;@0D8D0
	mov	word ptr ds:[56E4h], dx	;@0D8D3
	test	byte ptr ds:[51A3h], 20h	;@0D8D7
	je	@@3	;@0D8DC
	push	si	;@0D8DE
	mov	bx, 0D959h	;@0D8DF
	call	L0EBF9	;@0D8E2
	pop	si	;@0D8E5
	push	word ptr ds:[56E2h]	;@0D8E6
	push	word ptr ds:[56E4h]	;@0D8EA
	mov	bx, 0D973h	;@0D8EE
	call	L0EBF9	;@0D8F1
	pop	word ptr ds:[56E4h]	;@0D8F4
	pop	word ptr ds:[56E2h]	;@0D8F8
	jmp	short @@4	;@0D8FC
@@2:	jmp	L0265C	;@0D8FE
@@3:	mov	bx, 0D982h	;@0D901
	call	L0EBF9	;@0D904
@@4:	test	byte ptr ds:[51A3h], 80h	;@0D907
	je	@@5	;@0D90C
	call	L0D991	;@0D90E
	sub	ax, word ptr ds:[56E2h]	;@0D911
	sbb	dx, word ptr ds:[56E4h]	;@0D915
	mov	word ptr ds:[5184h], ax	;@0D919
	mov	word ptr ds:[5186h], dx	;@0D91C
@@5:	call	L026B8	;@0D920
	jne	@@6	;@0D923
	cmp	ax, word ptr ds:[580Ah]	;@0D925
	jne	@@6	;@0D929
	add	si, 2	;@0D92B
	call	L026B8	;@0D92E
	jne	@@7	;@0D931
	mov	ax, dx	;@0D933
	call	L0066E	;@0D935
	je	@@7	;@0D938
	add	si, 2	;@0D93A
	mov	cx, ax	;@0D93D
	call	L0D991	;@0D93F
	sub	ax, word ptr ds:[56E2h]	;@0D942
	sbb	dx, word ptr ds:[56E4h]	;@0D946
	call	L075EC	;@0D94A
@@6:	db	0E9h, 0EAh, 1Eh	; jmp L0F83A	;@0D94D
@@7:	mov	cx, 5Ah	;@0D950
	call	L03208	;@0D953
	db	0E9h, 0E1h, 1Eh	; jmp L0F83A	;@0D956
L0D959:	call	L0ECF6	;@0D959
	jne	L0D96F	;@0D95C
	cmp	word ptr ds:[56CAh], 0	;@0D95E
	jne	L0D970	;@0D963
	sub	word ptr ds:[56E2h], bx	;@0D965
	sbb	word ptr ds:[56E4h], cx	;@0D969
L0D96D:	xor	al, al	;@0D96D
L0D96F:	ret	;@0D96F
L0D970:	jmp	L0ECE4	;@0D970
L0D973:	call	L0ECF6	;@0D973
	jne	L0D96F	;@0D976
	cmp	word ptr ds:[56CAh], 0	;@0D978
	jne	L0D96D	;@0D97D
	jmp	L0DAD5	;@0D97F
L0D982:	call	L0ECF6	;@0D982
	jne	L0D96F	;@0D985
	cmp	word ptr ds:[56CAh], 0	;@0D987
	jne	L0D970	;@0D98C
	jmp	L0DABB	;@0D98E
L0D991:	xor	ax, ax	;@0D991
	mov	dx, ax	;@0D993
	cmp	byte ptr ds:[51A4h], 1	;@0D995
	jne	@@1	;@0D99A
	mov	ax, 0FFFEh	;@0D99C
	cwd	;@0D99F
@@1:	ret	;@0D9A0
L0D9A1:	db	0E8h, 33h, 1Fh	; call L0F8D7	;@0D9A1
	jne	L0DA23	;@0D9A4
L0D9A6:	db	0E8h, 8, 16h	; call L0EFB1	;@0D9A6
	mov	dx, 2	;@0D9A9
	mov	ax, word ptr ds:[5162h]	;@0D9AC
	and	ax, ax	;@0D9AF
	je	@@1	;@0D9B1
	call	L00752	;@0D9B3
	mov	ax, 4	;@0D9B6
	jne	@@2	;@0D9B9
@@1:	mov	ax, 2	;@0D9BB
@@2:	test	byte ptr ds:[516Ah], 10h	;@0D9BE
	je	@@3	;@0D9C3
	shl	ax, 1	;@0D9C5
@@3:	add	ax, dx	;@0D9C7
	mov	word ptr ds:[56E0h], ax	;@0D9C9
	mov	word ptr ds:[56E2h], ax	;@0D9CC
	mov	word ptr ds:[56E4h], 0	;@0D9CF
	test	byte ptr ds:[51A3h], 80h	;@0D9D5
	je	@@4	;@0D9DA
	mov	ax, word ptr ds:[5180h]	;@0D9DC
	mov	cx, word ptr ds:[5182h]	;@0D9DF
	mov	bx, ax	;@0D9E3
	or	bx, cx	;@0D9E5
	je	@@4	;@0D9E7
	add	word ptr ds:[56E2h], ax	;@0D9E9
	adc	word ptr ds:[56E4h], cx	;@0D9ED
@@4:	call	L026B8	;@0D9F1
	jne	@@5	;@0D9F4
	cmp	ax, word ptr ds:[5752h]	;@0D9F6
	je	L0DA78	;@0D9FA
@@5:	test	byte ptr ds:[51A3h], 20h	;@0D9FC
	je	L0DA26	;@0DA01
	push	si	;@0DA03
	mov	bx, 0DA98h	;@0DA04
	call	L0EBF9	;@0DA07
	pop	si	;@0DA0A
	push	word ptr ds:[56E2h]	;@0DA0B
	push	word ptr ds:[56E4h]	;@0DA0F
	mov	bx, 0DAAFh	;@0DA13
	call	L0EBF9	;@0DA16
	pop	word ptr ds:[56E4h]	;@0DA19
	pop	word ptr ds:[56E2h]	;@0DA1D
	jmp	short L0DA2C	;@0DA21
L0DA23:	jmp	L0265C	;@0DA23
L0DA26:	mov	bx, 0DAC9h	;@0DA26
	call	L0EBF9	;@0DA29
L0DA2C:	test	byte ptr ds:[51A3h], 80h	;@0DA2C
	je	@@1	;@0DA31
	mov	ax, word ptr ds:[56E2h]	;@0DA33
	mov	dx, word ptr ds:[56E4h]	;@0DA36
	sub	ax, word ptr ds:[56E0h]	;@0DA3A
	sbb	dx, 0	;@0DA3E
	mov	word ptr ds:[5180h], ax	;@0DA41
	mov	word ptr ds:[5182h], dx	;@0DA44
@@1:	call	L026B8	;@0DA48
	jne	L0DA8C	;@0DA4B
	cmp	ax, word ptr ds:[580Ah]	;@0DA4D
	jne	L0DA78	;@0DA51
	add	si, 2	;@0DA53
	call	L026B8	;@0DA56
	jne	L0DA8F	;@0DA59
	mov	ax, dx	;@0DA5B
	call	L0066E	;@0DA5D
	je	L0DA8F	;@0DA60
	add	si, 2	;@0DA62
	mov	cx, ax	;@0DA65
	mov	ax, word ptr ds:[56E2h]	;@0DA67
	mov	dx, word ptr ds:[56E4h]	;@0DA6A
	sub	ax, word ptr ds:[56E0h]	;@0DA6E
	sbb	dx, 0	;@0DA72
	call	L075EC	;@0DA75
L0DA78:	call	L026B8	;@0DA78
	jne	L0DA8C	;@0DA7B
	cmp	ax, word ptr ds:[5752h]	;@0DA7D
	jne	L0DA8C	;@0DA81
	add	si, 2	;@0DA83
	mov	bx, 0DAC9h	;@0DA86
	call	L0EBF9	;@0DA89
L0DA8C:	db	0E9h, 0ABh, 1Dh	; jmp L0F83A	;@0DA8C
L0DA8F:	mov	cx, 5Ah	;@0DA8F
	call	L03208	;@0DA92
	db	0E9h, 0A2h, 1Dh	; jmp L0F83A	;@0DA95
L0DA98:	call	L0ECF6	;@0DA98
	jne	L0DAE6	;@0DA9B
	cmp	word ptr ds:[56CAh], 0	;@0DA9D
	jne	L0DAE7	;@0DAA2
	add	word ptr ds:[56E2h], bx	;@0DAA4
	adc	word ptr ds:[56E4h], cx	;@0DAA8
	xor	al, al	;@0DAAC
	ret	;@0DAAE
L0DAAF:	call	L0ECF6	;@0DAAF
	jne	L0DAE6	;@0DAB2
	cmp	word ptr ds:[56CAh], 0	;@0DAB4
	jne	L0DAE4	;@0DAB9
L0DABB:	sub	word ptr ds:[56E2h], bx	;@0DABB
	sbb	word ptr ds:[56E4h], cx	;@0DABF
	call	L0ED2E	;@0DAC3
	xor	al, al	;@0DAC6
	ret	;@0DAC8
L0DAC9:	call	L0ECF6	;@0DAC9
	jne	L0DAE6	;@0DACC
	cmp	word ptr ds:[56CAh], 0	;@0DACE
	jne	L0DAE7	;@0DAD3
L0DAD5:	push	bx	;@0DAD5
	push	cx	;@0DAD6
	call	L0ED2E	;@0DAD7
	pop	cx	;@0DADA
	pop	bx	;@0DADB
	add	word ptr ds:[56E2h], bx	;@0DADC
	adc	word ptr ds:[56E4h], cx	;@0DAE0
L0DAE4:	xor	al, al	;@0DAE4
L0DAE6:	ret	;@0DAE6
L0DAE7:	jmp	L0ECE4	;@0DAE7
L0DAEA:	call	L0F8D7	;@0DAEA
	jne	@@3	;@0DAED
	call	L0EFB1	;@0DAEF
	test	byte ptr ds:[51A3h], 10h	;@0DAF2
	jne	@@1	;@0DAF7
	mov	cx, 8085h	;@0DAF9
	call	L03208	;@0DAFC
@@1:	test	byte ptr ds:[51A3h], 80h	;@0DAFF
	jne	@@2	;@0DB04
	mov	byte ptr ds:[519Eh], 0	;@0DB06
@@2:	mov	bx, 0DB17h	;@0DB0B
	call	L0EBF9	;@0DB0E
	jmp	L0F83A	;@0DB11
@@3:	jmp	L0265C	;@0DB14
L0DB17:	call	L026B8	;@0DB17
	jne	@@3	;@0DB1A
	call	L0066E	;@0DB1C
	je	@@2	;@0DB1F
	add	si, 2	;@0DB21
	mov	ax, dx	;@0DB24
	mov	bl, byte ptr ds:[519Eh]	;@0DB26
	cmp	bl, 8	;@0DB2A
	je	@@1	;@0DB2D
	inc	byte ptr ds:[519Eh]	;@0DB2F
	xor	bh, bh	;@0DB33
	shl	bx, 1	;@0DB35
	mov	word ptr [bx+5170h], ax	;@0DB37
	xor	al, al	;@0DB3B
	ret	;@0DB3D
@@1:	mov	cx, 82h	;@0DB3E
	call	L03208	;@0DB41
	xor	al, al	;@0DB44
	ret	;@0DB46
@@2:	xor	al, al	;@0DB47
	dec	al	;@0DB49
@@3:	ret	;@0DB4B
L0DB4C:	db	0E8h, 88h, 1Dh	; call L0F8D7	;@0DB4C
	jne	@@1	;@0DB4F
	db	0E8h, 2, 1Dh	; call L0F856	;@0DB51
	mov	bx, 0DB60h	;@0DB54
	call	L0EBF9	;@0DB57
	db	0E9h, 0DDh, 1Ch	; jmp L0F83A	;@0DB5A
@@1:	jmp	L0265C	;@0DB5D
L0DB60:	call	L0EDD5	;@0DB60
	jne	L0DBB3	;@0DB63
L0DB65:	cmp	word ptr ds:[56CAh], 0	;@0DB65
	jne	@@1	;@0DB6A
	mov	es, word ptr ds:[56C6h]	;@0DB6C
	mov	bl, byte ptr ds:[56DCh]	;@0DB70
	mov	di, word ptr ds:[56CCh]	;@0DB74
	test	bl, 20h	;@0DB78
	jne	@@2	;@0DB7B
	call	L01589	;@0DB7D
	jne	@@1	;@0DB80
	call	L035AC	;@0DB82
	call	L015A1	;@0DB85
@@1:	xor	al, al	;@0DB88
	ret	;@0DB8A
@@2:	mov	ax, di	;@0DB8B
	or	bl, 10h	;@0DB8D
	call	L0109C	;@0DB90
	jne	@@1	;@0DB93
	call	L035AC	;@0DB95
	call	L01151	;@0DB98
	mov	bl, byte ptr ds:[56DCh]	;@0DB9B
	mov	cx, word ptr ds:[56CCh]	;@0DB9F
	call	L00094	;@0DBA3
	mov	cx, word ptr ds:[56D2h]	;@0DBA6
	mov	di, word ptr ds:[56D4h]	;@0DBAA
	call	L0125C	;@0DBAE
	xor	al, al	;@0DBB1
L0DBB3:	ret	;@0DBB3
L0DBB4:	db	0E8h, 20h, 1Dh	; call L0F8D7	;@0DBB4
	jne	@@1	;@0DBB7
	db	0E8h, 9Ah, 1Ch	; call L0F856	;@0DBB9
	mov	bx, 0DBC8h	;@0DBBC
	call	L0EBF9	;@0DBBF
	db	0E9h, 75h, 1Ch	; jmp L0F83A	;@0DBC2
@@1:	jmp	L0265C	;@0DBC5
	db	0FFh, '6`Q', 83h, 0Eh, 60h, 51h, 8, 0E8h, 2Bh, 12h, 8Fh, 6, '`QuW'	;@0DBC8
	db	83h, 3Eh, 0CAh, 56h, 0, 75h, 4Eh, 8Bh, 0Eh, 0C6h, 56h, 0E3h, 48h
	db	8Eh, 0C1h, 8Ah, 1Eh, 0DCh, 56h, 8Bh, 3Eh, 0CCh, 56h, 0F6h, 0C3h
	db	20h, 75h, 2, 0EBh, 85h, 8Bh, 0C7h, 80h, 0CBh, 10h, 0E8h, 9Ch, '4u-'
	db	0E8h, 0A7h, 'YVPS', 8Bh, 0C8h, 0E8h, 87h, 24h, 8Bh, 0Eh, 0D6h
	db	56h, 8Bh, 3Eh, 0D8h, 56h, 0E8h, 69h, 6Eh, 8Bh, 17h, 8Bh, 77h, 2
	db	5Bh, 58h, 8Bh, 0Eh, 0D2h, 56h, 8Bh, 3Eh, 0D4h, 56h, 8Ah, 3Eh, 0DBh
	db	56h, 0E8h, 99h, '4^2', 0C0h, 0C3h
L0DC32:	db	0E8h, 0A2h, 1Ch	; call L0F8D7	;@0DC32
	jne	@@1	;@0DC35
	db	0E8h, 1Ch, 1Ch	; call L0F856	;@0DC37
	mov	bx, 0DC46h	;@0DC3A
	call	L0EBF9	;@0DC3D
	db	0E9h, 0F7h, 1Bh	; jmp L0F83A	;@0DC40
@@1:	jmp	L0265C	;@0DC43
L0DC46:	call	L0EDD5	;@0DC46
	jne	@@2	;@0DC49
	mov	ax, word ptr ds:[56C6h]	;@0DC4B
	call	L004C7	;@0DC4E
	mov	bh, al	;@0DC51
	and	bh, 3Fh	;@0DC53
	cmp	bh, 0	;@0DC56
	jne	@@5	;@0DC59
	test	byte ptr ds:[38D7h], 0Bh	;@0DC5B
	jne	@@3	;@0DC60
	cmp	word ptr ds:[56CAh], 0	;@0DC62
	jne	@@1	;@0DC67
	mov	es, word ptr ds:[56C6h]	;@0DC69
	mov	bl, byte ptr ds:[56DCh]	;@0DC6D
	mov	ax, word ptr ds:[56CCh]	;@0DC71
	call	L008AD	;@0DC74
@@1:	or	byte ptr ds:[38D8h], 1	;@0DC77
	xor	al, al	;@0DC7C
@@2:	ret	;@0DC7E
@@3:	mov	ax, word ptr ds:[56C6h]	;@0DC7F
	call	L006C2	;@0DC82
	je	@@10	;@0DC85
@@4:	jmp	L0DB65	;@0DC87
@@5:	test	bh, 20h	;@0DC8A
	je	@@6	;@0DC8D
	test	bh, 10h	;@0DC8F
	jne	@@4	;@0DC92
	and	bh, bh	;@0DC94
	je	@@9	;@0DC96
	cmp	bh, byte ptr ds:[56DCh]	;@0DC98
	jne	@@8	;@0DC9C
	cmp	di, word ptr ds:[56CCh]	;@0DC9E
	jne	@@8	;@0DCA2
	mov	es, word ptr ds:[56C6h]	;@0DCA4
	call	L000B4	;@0DCA8
	cmp	ax, word ptr ds:[56D2h]	;@0DCAB
	jne	@@8	;@0DCAF
	cmp	dx, word ptr ds:[56D4h]	;@0DCB1
	jne	@@8	;@0DCB5
	jmp	short @@9	;@0DCB7
@@6:	and	bh, 1Fh	;@0DCB9
	cmp	bh, 1	;@0DCBC
	je	@@11	;@0DCBF
	cmp	bh, 9	;@0DCC1
	je	@@10	;@0DCC4
	cmp	bh, 8	;@0DCC6
	je	@@7	;@0DCC9
	cmp	bh, 0Ch	;@0DCCB
	jne	@@9	;@0DCCE
@@7:	cmp	byte ptr ds:[56DCh], 0	;@0DCD0
	je	@@9	;@0DCD5
@@8:	test	word ptr ds:[5166h], 20h	;@0DCD7
	je	@@9	;@0DCDD
	mov	di, word ptr ds:[56C6h]	;@0DCDF
	mov	cx, 908Ah	;@0DCE3
	call	L03208	;@0DCE6
@@9:	mov	es, word ptr ds:[56C6h]	;@0DCE9
	call	L0026A	;@0DCED
@@10:	xor	al, al	;@0DCF0
	ret	;@0DCF2
@@11:	mov	di, word ptr ds:[56C6h]	;@0DCF3
	mov	cx, 1013h	;@0DCF7
	call	L03208	;@0DCFA
	xor	al, al	;@0DCFD
	ret	;@0DCFF
L0DD00:	db	0E8h, 0D4h, 1Bh	; call L0F8D7	;@0DD00
	jne	@@1	;@0DD03
	db	0E8h, 4Eh, 1Bh	; call L0F856	;@0DD05
	mov	bx, 0DD14h	;@0DD08
	call	L0EBF9	;@0DD0B
	db	0E9h, 29h, 1Bh	; jmp L0F83A	;@0DD0E
@@1:	jmp	L0265C	;@0DD11
L0DD14:	call	L0EC83	;@0DD14
	jne	@@1	;@0DD17
	mov	ax, word ptr ds:[56C8h]	;@0DD19
	mov	dx, word ptr ds:[56C6h]	;@0DD1C
	call	L074BB	;@0DD20
	xor	al, al	;@0DD23
@@1:	ret	;@0DD25
L0DD26:	db	0E8h, 0AEh, 1Bh	; call L0F8D7	;@0DD26
	jne	@@1	;@0DD29
	db	0E8h, 28h, 1Bh	; call L0F856	;@0DD2B
	mov	bx, 0DD3Ah	;@0DD2E
	call	L0EBF9	;@0DD31
	db	0E9h, 3, 1Bh	; jmp L0F83A	;@0DD34
@@1:	jmp	L0265C	;@0DD37
L0DD3A:	call	L0EC83	;@0DD3A
	jne	@@1	;@0DD3D
	mov	ax, word ptr ds:[56C8h]	;@0DD3F
	mov	dx, word ptr ds:[56C6h]	;@0DD42
	call	L07467	;@0DD46
	xor	al, al	;@0DD49
@@1:	ret	;@0DD4B
L0DD4C:	db	0E8h, 88h, 1Bh	; call L0F8D7	;@0DD4C
	jne	@@1	;@0DD4F
	mov	bx, 0DD5Dh	;@0DD51
	call	L0EBF9	;@0DD54
	db	0E9h, 0E0h, 1Ah	; jmp L0F83A	;@0DD57
@@1:	jmp	L0265C	;@0DD5A
L0DD5D:	call	L026B8	;@0DD5D
	jne	@@7	;@0DD60
	cmp	ax, word ptr ds:[5842h]	;@0DD62
	je	@@1	;@0DD66
	call	L0066E	;@0DD68
	jne	@@2	;@0DD6B
	xor	al, al	;@0DD6D
	dec	al	;@0DD6F
	ret	;@0DD71
@@1:	call	L071CE	;@0DD72
	add	si, 2	;@0DD75
	xor	al, al	;@0DD78
	ret	;@0DD7A
@@2:	add	si, 2	;@0DD7B
	push	ax	;@0DD7E
	call	L026B8	;@0DD7F
	pop	bx	;@0DD82
	jne	@@7	;@0DD83
	cmp	ax, word ptr ds:[5808h]	;@0DD85
	mov	ax, bx	;@0DD89
	je	@@3	;@0DD8B
	mov	cx, 0Bh	;@0DD8D
	call	L03208	;@0DD90
	jmp	short @@4	;@0DD93
@@3:	add	si, 2	;@0DD95
@@4:	push	ax	;@0DD98
	call	L0A7C0	;@0DD99
	pop	ax	;@0DD9C
	je	@@5	;@0DD9D
	mov	cx, 2	;@0DD9F
	call	L03208	;@0DDA2
	push	ax	;@0DDA5
	call	L05542	;@0DDA6
	pop	ax	;@0DDA9
@@5:	call	L0080F	;@0DDAA
	je	@@6	;@0DDAD
	mov	cx, 63h	;@0DDAF
	call	L03208	;@0DDB2
	xor	al, al	;@0DDB5
	ret	;@0DDB7
@@6:	mov	cx, ax	;@0DDB8
	jmp	L07667	;@0DDBA
@@7:	ret	;@0DDBD
L0DDBE:	db	0E8h, 16h, 1Bh	; call L0F8D7	;@0DDBE
	jne	@@4	;@0DDC1
@@1:	call	@@5	;@0DDC3
	je	@@2	;@0DDC6
	mov	cx, 10h	;@0DDC8
	call	L03208	;@0DDCB
@@2:	call	L026B8	;@0DDCE
	jne	@@3	;@0DDD1
	cmp	ax, word ptr ds:[5838h]	;@0DDD3
	jne	@@3	;@0DDD7
	add	si, 2	;@0DDD9
	jmp	@@1	;@0DDDC
@@3:	db	0E9h, 59h, 1Ah	; jmp L0F83A	;@0DDDE
@@4:	jmp	L0265C	;@0DDE1
@@5:	call	L01D7A	;@0DDE4
	jne	@@8	;@0DDE7
	call	L0066E	;@0DDE9
	je	@@7	;@0DDEC
	add	si, 2	;@0DDEE
	mov	es, ax	;@0DDF1
	push	es	;@0DDF3
	call	L00877	;@0DDF4
	pop	es	;@0DDF7
	jne	@@6	;@0DDF8
	call	L008ED	;@0DDFA
	jne	@@6	;@0DDFD
	call	L00933	;@0DDFF
@@6:	xor	al, al	;@0DE02
	ret	;@0DE04
@@7:	xor	al, al	;@0DE05
	dec	al	;@0DE07
@@8:	ret	;@0DE09
L0DE0A:	db	0E8h, 49h, 1Ah	; call L0F856	;@0DE0A
	call	L00905	;@0DE0D
	call	L01D70	;@0DE10
	push	cx	;@0DE13
	call	L01D75	;@0DE14
	pop	si	;@0DE17
	push	es	;@0DE18
	call	L0099B	;@0DE19
	pop	es	;@0DE1C
	mov	ax, word ptr ds:[5744h]	;@0DE1D
	push	es	;@0DE20
	call	L01E75	;@0DE21
	pop	es	;@0DE24
	jmp	L00928	;@0DE25
L0DE28:	call	L0F8D7	;@0DE28
	jne	@@3	;@0DE2B
	call	L0A7C0	;@0DE2D
	je	@@2	;@0DE30
	test	word ptr ds:[5160h], 2000h	;@0DE32
	jne	@@1	;@0DE38
	mov	cx, 2	;@0DE3A
	call	L03208	;@0DE3D
@@1:	call	L05542	;@0DE40
@@2:	call	L076DE	;@0DE43
	mov	word ptr ds:[56F0h], ax	;@0DE46
	mov	word ptr ds:[56F2h], cx	;@0DE49
	call	L0F83A	;@0DE4D
	call	L00905	;@0DE50
	mov	word ptr ds:[56BCh], es	;@0DE53
	call	L0DF9C	;@0DE57
	mov	bx, word ptr ds:[56F0h]	;@0DE5A
	mov	dx, word ptr ds:[56F2h]	;@0DE5E
	mov	ax, word ptr ds:[5746h]	;@0DE62
	mov	es, word ptr ds:[56BCh]	;@0DE65
	call	L01E8D	;@0DE69
	mov	es, word ptr ds:[56BCh]	;@0DE6C
	jmp	L00928	;@0DE70
@@3:	jmp	L0E083	;@0DE73
L0DE76:	call	L0F8D7	;@0DE76
	jne	@@4	;@0DE79
	call	L00905	;@0DE7B
	mov	word ptr ds:[56BCh], es	;@0DE7E
	call	L01D7A	;@0DE82
	jne	@@3	;@0DE85
	mov	ax, dx	;@0DE87
	call	L0066E	;@0DE89
	je	@@3	;@0DE8C
	mov	es, word ptr ds:[56BCh]	;@0DE8E
	call	L00958	;@0DE92
	add	si, 2	;@0DE95
	call	L026B8	;@0DE98
	jne	@@2	;@0DE9B
	cmp	ax, word ptr ds:[5838h]	;@0DE9D
	jne	@@2	;@0DEA1
	add	si, 2	;@0DEA3
	call	L01EB5	;@0DEA6
	call	L0DF9C	;@0DEA9
	mov	es, word ptr ds:[56BCh]	;@0DEAC
	mov	ax, word ptr ds:[5748h]	;@0DEB0
	call	L01FCE	;@0DEB3
@@1:	mov	es, word ptr ds:[56BCh]	;@0DEB6
	jmp	L00928	;@0DEBA
@@2:	mov	cx, 48h	;@0DEBD
	call	L03208	;@0DEC0
	jmp	@@1	;@0DEC3
@@3:	mov	cx, 47h	;@0DEC5
	call	L03208	;@0DEC8
	jmp	@@1	;@0DECB
@@4:	jmp	L0E083	;@0DECD
L0DED0:	call	L0F8D7	;@0DED0
	jne	@@4	;@0DED3
	call	L00905	;@0DED5
	mov	word ptr ds:[56BCh], es	;@0DED8
	call	L01D7A	;@0DEDC
	jne	@@3	;@0DEDF
	mov	ax, dx	;@0DEE1
	call	L0066E	;@0DEE3
	je	@@3	;@0DEE6
	mov	es, word ptr ds:[56BCh]	;@0DEE8
	call	L00958	;@0DEEC
	add	si, 2	;@0DEEF
	call	L026B8	;@0DEF2
	jne	@@2	;@0DEF5
	cmp	ax, word ptr ds:[5838h]	;@0DEF7
	jne	@@2	;@0DEFB
	add	si, 2	;@0DEFD
	call	L01F5A	;@0DF00
	call	L0DF9C	;@0DF03
	mov	es, word ptr ds:[56BCh]	;@0DF06
	mov	ax, word ptr ds:[574Ah]	;@0DF0A
	call	L020DB	;@0DF0D
@@1:	mov	es, word ptr ds:[56BCh]	;@0DF10
	jmp	L00928	;@0DF14
@@2:	mov	cx, 48h	;@0DF17
	call	L03208	;@0DF1A
	jmp	@@1	;@0DF1D
@@3:	mov	cx, 47h	;@0DF1F
	call	L03208	;@0DF22
	jmp	@@1	;@0DF25
@@4:	jmp	L0E083	;@0DF27
L0DF2A:	call	L0F8D7	;@0DF2A
	jne	L0DF99	;@0DF2D
	call	L00692	;@0DF2F
	sub	si, 2	;@0DF32
	mov	ax, dx	;@0DF35
	jmp	short L0DF56	;@0DF37
L0DF39:	call	L0F8D7	;@0DF39
	jne	L0DF99	;@0DF3C
	call	L01D7A	;@0DF3E
	jne	L0DF93	;@0DF41
	call	L0066E	;@0DF43
	je	L0DF93	;@0DF46
	test	word ptr ds:[5160h], 1000h	;@0DF48
	jne	L0DF56	;@0DF4E
	mov	cx, 6Fh	;@0DF50
	jmp	L03208	;@0DF53
L0DF56:	mov	es, ax	;@0DF56
	call	L008ED	;@0DF58
	jne	L0DF99	;@0DF5B
	call	L035AC	;@0DF5D
	call	L0094E	;@0DF60
	mov	word ptr ds:[56BCh], es	;@0DF63
@@1:	add	si, 2	;@0DF67
	call	L01D7A	;@0DF6A
	jne	L0DF9C	;@0DF6D
	mov	ax, dx	;@0DF6F
	call	L0066E	;@0DF71
	je	@@2	;@0DF74
	add	si, 2	;@0DF76
	mov	es, word ptr ds:[56BCh]	;@0DF79
	call	L00958	;@0DF7D
	call	L01D7A	;@0DF80
	jne	L0DF9C	;@0DF83
	cmp	ax, word ptr ds:[5838h]	;@0DF85
	je	@@1	;@0DF89
@@2:	mov	cx, 43h	;@0DF8B
	call	L03208	;@0DF8E
	jmp	short L0DF9C	;@0DF91
L0DF93:	mov	cx, 45h	;@0DF93
	call	L03208	;@0DF96
L0DF99:	jmp	L0E083	;@0DF99
L0DF9C:	mov	word ptr ds:[56EEh], 1	;@0DF9C
L0DFA2:	db	0E8h, 0B2h, 15h	; call L0F557	;@0DFA2
	mov	word ptr ds:[56F4h], si	;@0DFA5
	xor	si, si	;@0DFA9
	call	L01D70	;@0DFAB
	push	cx	;@0DFAE
	call	L01D75	;@0DFAF
	pop	cx	;@0DFB2
	jne	L0DFE8	;@0DFB3
	cmp	ax, word ptr ds:[5750h]	;@0DFB5
	jne	L0E006	;@0DFB9
L0DFBB:	add	si, 2	;@0DFBB
	call	L01D7A	;@0DFBE
	jne	L0DFA2	;@0DFC1
	mov	ax, dx	;@0DFC3
L0DFC5:	call	L0066E	;@0DFC5
	je	@@1	;@0DFC8
	add	si, 2	;@0DFCA
	mov	es, word ptr ds:[56BCh]	;@0DFCD
	call	L0095C	;@0DFD1
	call	L01D7A	;@0DFD4
	jne	L0DFA2	;@0DFD7
	cmp	ax, word ptr ds:[5838h]	;@0DFD9
	je	L0DFBB	;@0DFDD
@@1:	mov	cx, 44h	;@0DFDF
	call	L03208	;@0DFE2
	jmp	L0DFA2	;@0DFE5
L0DFE7:	ret	;@0DFE7
L0DFE8:	mov	es, word ptr ds:[56BCh]	;@0DFE8
	mov	si, word ptr ds:[56F4h]	;@0DFEC
	call	L0099B	;@0DFF0
	db	0E8h, 61h, 15h	; call L0F557	;@0DFF3
	mov	word ptr ds:[56F4h], si	;@0DFF6
	xor	si, si	;@0DFFA
L0DFFC:	call	L01D70	;@0DFFC
	push	cx	;@0DFFF
	call	L01D75	;@0E000
	pop	cx	;@0E003
	jne	L0DFE8	;@0E004
L0E006:	mov	word ptr ds:[56F6h], cx	;@0E006
	test	word ptr ds:[5160h], 1000h	;@0E00A
	jne	@@1	;@0E010
	push	ax	;@0E012
	add	si, 2	;@0E013
	call	L01D75	;@0E016
	mov	dx, ax	;@0E019
	pop	ax	;@0E01B
	jne	@@1	;@0E01C
	cmp	dx, word ptr ds:[5744h]	;@0E01E
	je	@@3	;@0E022
	cmp	dx, word ptr ds:[5808h]	;@0E024
	jne	@@1	;@0E028
	add	si, 2	;@0E02A
	jmp	L0DFFC	;@0E02D
@@1:	cmp	ax, word ptr ds:[574Ch]	;@0E02F
	jne	@@2	;@0E033
	mov	ax, dx	;@0E035
@@2:	cmp	ax, word ptr ds:[5744h]	;@0E037
	je	@@3	;@0E03B
	cmp	ax, word ptr ds:[5746h]	;@0E03D
	je	@@3	;@0E041
	cmp	ax, word ptr ds:[5748h]	;@0E043
	je	@@3	;@0E047
	cmp	ax, word ptr ds:[574Ah]	;@0E049
	je	@@3	;@0E04D
	cmp	ax, word ptr ds:[574Eh]	;@0E04F
	jne	L0DFE8	;@0E053
	dec	word ptr ds:[56EEh]	;@0E055
	jne	L0DFE8	;@0E059
	mov	si, word ptr ds:[56F4h]	;@0E05B
	mov	bx, word ptr ds:[56F6h]	;@0E05F
	cmp	si, bx	;@0E063
	je	L0DFE7	;@0E065
	mov	al, byte ptr [bx]	;@0E067
	push	ax	;@0E069
	push	bx	;@0E06A
	mov	byte ptr [bx], 0Dh	;@0E06B
	mov	es, word ptr ds:[56BCh]	;@0E06E
	call	L0099B	;@0E072
	pop	bx	;@0E075
	pop	ax	;@0E076
	mov	byte ptr [bx], al	;@0E077
	jmp	L0DFE7	;@0E079
@@3:	inc	word ptr ds:[56EEh]	;@0E07C
	jmp	L0DFE8	;@0E080
L0E083:	mov	word ptr ds:[56EEh], 1	;@0E083
@@1:	call	L0F557	;@0E089
	call	L0F8D7	;@0E08C
	xor	si, si	;@0E08F
@@2:	call	L01D75	;@0E091
	jne	@@1	;@0E094
	test	word ptr ds:[5160h], 1000h	;@0E096
	jne	@@3	;@0E09C
	push	ax	;@0E09E
	add	si, 2	;@0E09F
	call	L01D75	;@0E0A2
	mov	dx, ax	;@0E0A5
	pop	ax	;@0E0A7
	jne	@@3	;@0E0A8
	cmp	dx, word ptr ds:[5744h]	;@0E0AA
	je	@@5	;@0E0AE
	cmp	dx, word ptr ds:[5808h]	;@0E0B0
	jne	@@3	;@0E0B4
	add	si, 2	;@0E0B6
	jmp	@@2	;@0E0B9
@@3:	cmp	ax, word ptr ds:[574Ch]	;@0E0BB
	jne	@@4	;@0E0BF
	mov	ax, dx	;@0E0C1
@@4:	cmp	ax, word ptr ds:[5744h]	;@0E0C3
	je	@@5	;@0E0C7
	cmp	ax, word ptr ds:[5746h]	;@0E0C9
	je	@@5	;@0E0CD
	cmp	ax, word ptr ds:[5748h]	;@0E0CF
	je	@@5	;@0E0D3
	cmp	ax, word ptr ds:[574Ah]	;@0E0D5
	jne	@@6	;@0E0D9
@@5:	inc	word ptr ds:[56EEh]	;@0E0DB
	jmp	@@1	;@0E0DF
@@6:	cmp	ax, word ptr ds:[574Eh]	;@0E0E1
	jne	@@1	;@0E0E5
	dec	word ptr ds:[56EEh]	;@0E0E7
	jne	@@1	;@0E0EB
	ret	;@0E0ED
L0E0EE:	db	0E8h, 0E6h, 17h	; call L0F8D7	;@0E0EE
	jne	@@5	;@0E0F1
	call	L0A7C0	;@0E0F3
	je	@@1	;@0E0F6
	cmp	byte ptr ds:[51A5h], 0	;@0E0F8
	je	@@2	;@0E0FD
	call	L07439	;@0E0FF
	jmp	short @@4	;@0E102
@@1:	call	L07682	;@0E104
	jmp	short @@3	;@0E107
@@2:	call	L076AB	;@0E109
@@3:	mov	byte ptr ds:[51A0h], 0FFh	;@0E10C
@@4:	db	0E9h, 26h, 17h	; jmp L0F83A	;@0E111
@@5:	jmp	L0265C	;@0E114
L0E117:	call	L0F8D7	;@0E117
	jne	@@3	;@0E11A
	call	L0F856	;@0E11C
	call	L0EC83	;@0E11F
	jne	@@2	;@0E122
	call	L0A8B8	;@0E124
	je	@@1	;@0E127
	call	L05B01	;@0E129
@@1:	jmp	short L0E1AC	;@0E12C
@@2:	mov	cx, 4Ah	;@0E12E
	call	L03208	;@0E131
	jmp	L0F83A	;@0E134
@@3:	jmp	L0265C	;@0E137
L0E13A:	call	L0F8D7	;@0E13A
	jne	@@4	;@0E13D
	push	dx	;@0E13F
	call	L0EC22	;@0E140
	call	L0EC4C	;@0E143
	call	L0A8B8	;@0E146
	jne	@@1	;@0E149
	test	word ptr ds:[5160h], 6000h	;@0E14B
	jne	@@2	;@0E151
	push	es	;@0E153
	mov	al, byte ptr ds:[56DDh]	;@0E154
	push	ax	;@0E157
	call	L0EC4C	;@0E158
	pop	ax	;@0E15B
	pop	es	;@0E15C
	xchg	byte ptr ds:[56DDh], al	;@0E15D
	jne	@@2	;@0E161
	xchg	byte ptr ds:[56DDh], al	;@0E163
	jmp	short @@2	;@0E167
@@1:	call	L05B01	;@0E169
@@2:	pop	dx	;@0E16C
	push	es	;@0E16D
	test	byte ptr ds:[56DDh], 10h	;@0E16E
	je	@@3	;@0E173
	test	word ptr ds:[5160h], 6000h	;@0E175
	jne	@@3	;@0E17B
	mov	al, byte ptr ds:[516Bh]	;@0E17D
	push	ax	;@0E180
	and	byte ptr ds:[516Bh], 8Fh	;@0E181
	mov	al, byte ptr ds:[56DDh]	;@0E186
	or	byte ptr ds:[516Bh], al	;@0E189
	call	L0F849	;@0E18D
	pop	ax	;@0E190
	mov	byte ptr ds:[516Bh], al	;@0E191
@@3:	call	L00692	;@0E194
	pop	es	;@0E197
	mov	word ptr ds:[56C6h], dx	;@0E198
	mov	word ptr ds:[56C8h], ax	;@0E19C
	jmp	short L0E1AC	;@0E19F
@@4:	jmp	L0265C	;@0E1A1
L0E1A4:	mov	cx, 42h	;@0E1A4
	call	L03208	;@0E1A7
	jmp	short L0E1DE	;@0E1AA
L0E1AC:	cmp	word ptr ds:[5194h], 0	;@0E1AC
	jne	L0E222	;@0E1B1
	call	L07745	;@0E1B3
	and	ax, ax	;@0E1B6
	jne	L0E1DE	;@0E1B8
	test	bl, 20h	;@0E1BA
	je	L0E1A4	;@0E1BD
	mov	es, word ptr ds:[56C6h]	;@0E1BF
	mov	ax, di	;@0E1C3
	call	L0109C	;@0E1C5
	jne	L0E1DE	;@0E1C8
	call	L011AE	;@0E1CA
	test	byte ptr ds:[38D7h], 1	;@0E1CD
	je	L0E1DE	;@0E1D2
	mov	ax, word ptr ds:[5154h]	;@0E1D4
	mov	dx, word ptr ds:[5156h]	;@0E1D7
	call	L034E8	;@0E1DB
L0E1DE:	mov	ax, word ptr ds:[56C6h]	;@0E1DE
	call	L03D0E	;@0E1E1
	and	byte ptr ds:[51A3h], 0C8h	;@0E1E4
	mov	al, byte ptr ds:[56DEh]	;@0E1E9
	or	byte ptr ds:[51A3h], al	;@0E1EC
	mov	al, byte ptr ds:[56DDh]	;@0E1F0
	and	al, 30h	;@0E1F3
	or	byte ptr ds:[51A3h], al	;@0E1F5
	test	al, 10h	;@0E1F9
	je	@@1	;@0E1FB
	test	word ptr ds:[5160h], 6000h	;@0E1FD
	jne	@@1	;@0E203
	mov	ax, word ptr ds:[56C8h]	;@0E205
	mov	dx, word ptr ds:[56C6h]	;@0E208
	call	L074BB	;@0E20C
@@1:	call	L026B8	;@0E20F
	jne	L0E251	;@0E212
	cmp	ax, word ptr ds:[583Eh]	;@0E214
	je	L0E228	;@0E218
	cmp	ax, word ptr ds:[5838h]	;@0E21A
	jne	L0E24E	;@0E21E
	jmp	short L0E24B	;@0E220
L0E222:	mov	cx, 49h	;@0E222
	jmp	L03208	;@0E225
L0E228:	call	L0EFB1	;@0E228
	add	si, 2	;@0E22B
	test	byte ptr ds:[51A3h], 10h	;@0E22E
	jne	@@1	;@0E233
	mov	cx, 8085h	;@0E235
	call	L03208	;@0E238
@@1:	call	L0DB17	;@0E23B
	je	@@1	;@0E23E
	call	L026B8	;@0E240
	jne	L0E25B	;@0E243
	cmp	ax, word ptr ds:[5838h]	;@0E245
	jne	L0E25B	;@0E249
L0E24B:	add	si, 2	;@0E24B
L0E24E:	jmp	L0D9A6	;@0E24E
L0E251:	test	byte ptr ds:[51A3h], 7	;@0E251
	je	L0E25B	;@0E256
	call	L0EFB1	;@0E258
L0E25B:	jmp	L0F83A	;@0E25B
L0E25E:	call	L0F8D7	;@0E25E
	jne	L0E29D	;@0E261
	cmp	word ptr ds:[5194h], 0	;@0E263
	jne	L0E222	;@0E268
	call	L026B8	;@0E26A
	jne	L0E291	;@0E26D
	add	si, 2	;@0E26F
	jmp	short L0E283	;@0E272
L0E274:	call	L0F8D7	;@0E274
	jne	L0E29D	;@0E277
	call	L00692	;@0E279
	cmp	word ptr ds:[5194h], 0	;@0E27C
	jne	L0E297	;@0E281
L0E283:	cmp	dx, word ptr ds:[5196h]	;@0E283
	je	L0E291	;@0E287
	mov	cx, 1039h	;@0E289
	mov	di, dx	;@0E28C
	call	L03208	;@0E28E
L0E291:	call	L03DEC	;@0E291
	jmp	L0F83A	;@0E294
L0E297:	mov	cx, 49h	;@0E297
	jmp	L03208	;@0E29A
L0E29D:	jmp	L0265C	;@0E29D
L0E2A0:	call	L0F8D7	;@0E2A0
	jne	L0E2F4	;@0E2A3
	call	L026B8	;@0E2A5
	jne	@@1	;@0E2A8
	call	L0066E	;@0E2AA
	je	@@1	;@0E2AD
	add	si, 2	;@0E2AF
	jmp	short L0E2C5	;@0E2B2
@@1:	mov	cx, 4Ah	;@0E2B4
	call	L03208	;@0E2B7
	jmp	L0F83A	;@0E2BA
L0E2BD:	call	L0F8D7	;@0E2BD
	jne	L0E2F4	;@0E2C0
	call	L00692	;@0E2C2
L0E2C5:	test	byte ptr ds:[516Ah], 80h	;@0E2C5
	jne	@@2	;@0E2CA
@@1:	mov	es, dx	;@0E2CC
	call	L01312	;@0E2CE
	jne	L0E2F4	;@0E2D1
	call	L035AC	;@0E2D3
	call	L0132A	;@0E2D6
	mov	bx, 0E2F7h	;@0E2D9
	call	L0EBF9	;@0E2DC
	jmp	L0F83A	;@0E2DF
@@2:	test	word ptr ds:[5166h], 4000h	;@0E2E2
	je	@@1	;@0E2E8
	mov	cx, 807Fh	;@0E2EA
	push	dx	;@0E2ED
	call	L03208	;@0E2EE
	pop	dx	;@0E2F1
	jmp	@@1	;@0E2F2
L0E2F4:	jmp	L0265C	;@0E2F4
L0E2F7:	call	L026B8	;@0E2F7
	jne	@@1	;@0E2FA
	call	L0066E	;@0E2FC
	je	L0E319	;@0E2FF
	add	si, 2	;@0E301
	mov	bx, dx	;@0E304
	call	L035F0	;@0E306
	push	es	;@0E309
	push	dx	;@0E30A
	mov	ax, es	;@0E30B
	mov	es, dx	;@0E30D
	call	L0148E	;@0E30F
	pop	dx	;@0E312
	pop	es	;@0E313
	je	L0E31E	;@0E314
	xor	al, al	;@0E316
@@1:	ret	;@0E318
L0E319:	xor	al, al	;@0E319
	dec	al	;@0E31B
	ret	;@0E31D
L0E31E:	test	byte ptr ds:[38D7h], 0Bh	;@0E31E
	jne	@@1	;@0E323
	or	byte ptr ds:[38D8h], 1	;@0E325
	xor	al, al	;@0E32A
	ret	;@0E32C
@@1:	mov	di, dx	;@0E32D
	mov	cx, 102Bh	;@0E32F
	call	L03208	;@0E332
	xor	al, al	;@0E335
	ret	;@0E337
	db	0B9h, 49h, 0, 0E9h, 0CAh, 4Eh, 0F7h, 6, 60h, 51h, 0, 60h, 75h	;@0E338
	db	0Eh, 0E8h, '1:u', 9, 3Bh, 6, 8, 58h, 75h, 3, 83h, 0C6h, 2, 0FFh
	db	'&4W', 0E8h, 7Ch, 15h, 75h, 0E1h, 83h, 3Eh, 94h, 51h, 0, 75h, 0D4h
	db	0E8h, 3, 15h, 75h, 0CEh, 0E8h, '&#;', 6, 'TWtQ', 8Eh, 0C2h, 0F7h
	db	6, 60h, 51h, 0, '`u]', 0E8h, 0F1h, 39h, 51h, 0E8h, 0F7h, '9Yu'
	db	10h, 3Bh, 6, 8, 58h, 75h, 5, 83h, 0C6h, 2, 0EBh, 5Eh, 8Bh, 0C1h
	db	0E8h, 0B9h, 3Ah, 0F6h, 6, 6Bh, 51h, 10h, 74h, 3Ch, 0F6h, 6, 'jQ t5'
	db	0E8h, 0C6h, '*uc', 6, 0E8h, 0D8h, 2Ah, 7, 33h, 0C0h, 0B3h, 28h
	db	0E8h, 1Eh, 21h, 0A1h, 54h, 51h, 8Bh, 16h, 56h, 51h, 0E8h, 0FEh
	db	50h, 0FFh, '&4W', 0F7h, 6, 60h, 51h, 0, 60h, 75h, 0Ch, 0A1h, 9Ah
	db	51h, 56h, 0E8h, 0CBh, 37h, 5Eh, 0FFh, 6, 9Ah, 51h, 0EBh, 99h, 8Ch
	db	0C0h, 0E8h, 19h, 24h, 75h, 0Fh, 0F6h, 6, 'jQ u', 8, 50h, 0E8h
	db	0AAh, 5Ah, 58h, 0E8h, 0CEh, 59h, 0B3h, 28h, 33h, 0C0h, 0E8h, 0A6h
	db	2Ch, 75h, 14h, 0E8h, 0B3h, 2Dh, 0B3h, 28h, 33h, 0C0h, 0E8h, 0D1h
	db	20h, 0A1h, 54h, 51h, 8Bh, 16h, 56h, 51h, 0E8h, 0DCh, 50h, 0FFh
	db	'&4W', 0E8h, 0C4h, 14h, 'uJR', 0F7h, 6, 60h, 51h, 0, 10h, 75h
	db	4Bh, 0E8h, 4Fh, 39h, 89h, 0Eh, 0BEh, 56h, 0E8h, 90h, 'Bu?', 0E8h
	db	'A"t1;', 6, ':Xt+VR', 83h, 0C6h, 2, 0E8h, '{BX^t', 1Fh, 0F7h, 6
	db	60h, 51h, 0, 40h, 75h, 5, 0E8h, 0B7h, 23h, 75h, 1Bh, 83h, 0C6h
	db	2, 5Ah, 8Eh, 0C2h, 0E8h, 0F6h, 31h, 75h, 6, 0E8h, 50h, 51h, 0E9h
	db	6, 32h, 0C3h, 0E8h, 13h, 0C3h, 75h, 4, 59h, 0E9h, 0B6h, 91h, 5Ah
	db	8Eh, 0C2h, 0E8h, 'V2u', 0EEh, 0E8h, 38h, 51h, 0F6h, 6, 0D7h, 38h
	db	2, 75h, 0E4h, 0F7h, 6, 60h, 51h, 0, 10h, 75h, 6, 0A1h, 0BEh, 56h
	db	0E8h, 0C6h, 39h, 0E8h, 0C6h, 37h, 75h, 17h, 0F7h, 6, 60h, 51h
	db	0, 10h, 75h, 12h, 53h, 51h, 0E8h, 0DFh, '8Y[u', 9, 0A1h, 0BEh
	db	56h, 0E8h, 0AAh, 39h, 0E8h, 3Dh, 37h, 0E8h, 0A0h, 51h, 0E9h, 48h
	db	32h
L0E4AE:	call	L0F8D7	;@0E4AE
	jne	@@2	;@0E4B1
	push	dx	;@0E4B3
	call	L0A7B0	;@0E4B4
	pop	ax	;@0E4B7
	je	@@1	;@0E4B8
	mov	cx, 2	;@0E4BA
	call	L03208	;@0E4BD
	push	ax	;@0E4C0
	call	L05542	;@0E4C1
	pop	ax	;@0E4C4
@@1:	mov	cx, ax	;@0E4C5
	call	L075FE	;@0E4C7
	jmp	L0F83A	;@0E4CA
@@2:	jmp	L0265C	;@0E4CD
L0E4D0:	call	L0F8D7	;@0E4D0
	jne	L0E4F5	;@0E4D3
	call	L00692	;@0E4D5
	mov	word ptr ds:[56BAh], dx	;@0E4D8
	call	L01C52	;@0E4DC
	jne	L0E4EF	;@0E4DF
	mov	ax, cx	;@0E4E1
	xor	dx, dx	;@0E4E3
	mov	cx, word ptr ds:[56BAh]	;@0E4E5
	call	L075EC	;@0E4E9
	jmp	L0F83A	;@0E4EC
L0E4EF:	mov	cx, 7Ah	;@0E4EF
	jmp	L03208	;@0E4F2
L0E4F5:	call	L01C52	;@0E4F5
	jmp	L0265C	;@0E4F8
L0E4FB:	call	L0F8D7	;@0E4FB
	jne	L0E539	;@0E4FE
	mov	word ptr ds:[56BAh], dx	;@0E500
	test	byte ptr ds:[38D7h], 2	;@0E504
	jne	L0E546	;@0E509
	mov	word ptr ds:[5708h], 0	;@0E50B
@@1:	call	L01C52	;@0E511
	jne	L0E53A	;@0E514
	mov	di, bx	;@0E516
	push	ss	;@0E518
	pop	es	;@0E519
	mov	bx, word ptr ds:[5708h]	;@0E51A
	call	L0498E	;@0E51E
	mov	word ptr ds:[5706h], bx	;@0E521
	mov	word ptr ds:[5708h], cx	;@0E525
	call	L026B8	;@0E529
	jne	L0E546	;@0E52C
	cmp	ax, word ptr ds:[5838h]	;@0E52E
	jne	L0E546	;@0E532
	add	si, 2	;@0E534
	jmp	@@1	;@0E537
L0E539:	ret	;@0E539
L0E53A:	mov	cx, 7Ah	;@0E53A
	call	L03208	;@0E53D
	mov	word ptr ds:[5708h], 0	;@0E540
L0E546:	mov	es, word ptr ds:[56BAh]	;@0E546
	call	L016C5	;@0E54A
	jne	L0E539	;@0E54D
	call	L035AC	;@0E54F
	test	byte ptr ds:[38D7h], 2	;@0E552
	jne	L0E539	;@0E557
	mov	bx, word ptr ds:[5706h]	;@0E559
	mov	cx, word ptr ds:[5708h]	;@0E55D
	call	L0364B	;@0E561
	jmp	L016F6	;@0E564
L0E567:	call	L0F8D7	;@0E567
	jne	L0E539	;@0E56A
	mov	word ptr ds:[56BAh], dx	;@0E56C
	test	byte ptr ds:[38D7h], 2	;@0E570
	jne	@@4	;@0E575
	call	L01C52	;@0E577
	jne	@@3	;@0E57A
	mov	word ptr ds:[5704h], bx	;@0E57C
	mov	word ptr ds:[5706h], 0	;@0E580
	mov	word ptr ds:[5708h], cx	;@0E586
	call	L026B8	;@0E58A
	jne	@@4	;@0E58D
	cmp	ax, word ptr ds:[5838h]	;@0E58F
	jne	@@4	;@0E593
	add	si, 2	;@0E595
	call	L0EB8B	;@0E598
	and	cx, cx	;@0E59B
	jne	@@1	;@0E59D
	dec	ax	;@0E59F
	cmp	ax, word ptr ds:[5708h]	;@0E5A0
	jb	@@2	;@0E5A4
@@1:	mov	ax, word ptr ds:[5708h]	;@0E5A6
@@2:	mov	word ptr ds:[5706h], ax	;@0E5A9
	sub	word ptr ds:[5708h], ax	;@0E5AC
	call	L026B8	;@0E5B0
	jne	@@4	;@0E5B3
	cmp	ax, word ptr ds:[5838h]	;@0E5B5
	jne	@@4	;@0E5B9
	add	si, 2	;@0E5BB
	call	L0EB7A	;@0E5BE
	and	cx, cx	;@0E5C1
	jne	@@4	;@0E5C3
	cmp	ax, word ptr ds:[5708h]	;@0E5C5
	jae	@@4	;@0E5C9
	mov	word ptr ds:[5708h], ax	;@0E5CB
	jmp	short @@4	;@0E5CE
@@3:	mov	cx, 7Ah	;@0E5D0
	call	L03208	;@0E5D3
	mov	word ptr ds:[5708h], 0	;@0E5D6
@@4:	mov	es, word ptr ds:[56BAh]	;@0E5DC
	call	L016C5	;@0E5E0
	jne	L0E601	;@0E5E3
	call	L035AC	;@0E5E5
	test	byte ptr ds:[38D7h], 2	;@0E5E8
	jne	L0E601	;@0E5ED
	mov	bx, word ptr ds:[5704h]	;@0E5EF
	add	bx, word ptr ds:[5706h]	;@0E5F3
	mov	cx, word ptr ds:[5708h]	;@0E5F7
	call	L0364B	;@0E5FB
	jmp	L016F6	;@0E5FE
L0E601:	ret	;@0E601
L0E602:	db	0E8h, 0D2h, 12h	; call L0F8D7	;@0E602
	jne	L0E601	;@0E605
	call	L00692	;@0E607
	mov	word ptr ds:[56BAh], dx	;@0E60A
	mov	word ptr ds:[5706h], 0	;@0E60E
	call	L01C52	;@0E614
	je	@@2	;@0E617
	call	L0EB8B	;@0E619
	dec	ax	;@0E61C
	mov	word ptr ds:[5706h], ax	;@0E61D
	call	L026B8	;@0E620
	jne	@@1	;@0E623
	cmp	ax, word ptr ds:[5838h]	;@0E625
	jne	@@1	;@0E629
	add	si, 2	;@0E62B
	call	L01C52	;@0E62E
	je	@@2	;@0E631
@@1:	jmp	L0E4EF	;@0E633
@@2:	mov	ax, ss	;@0E636
	mov	es, ax	;@0E638
	mov	di, bx	;@0E63A
	xor	bx, bx	;@0E63C
	call	L0498E	;@0E63E
	mov	word ptr ds:[5704h], bx	;@0E641
	cmp	word ptr ds:[5706h], cx	;@0E645
	jb	@@3	;@0E649
	mov	word ptr ds:[5706h], cx	;@0E64B
@@3:	sub	cx, word ptr ds:[5706h]	;@0E64F
	inc	cx	;@0E653
	mov	word ptr ds:[5708h], cx	;@0E654
	add	word ptr ds:[5706h], bx	;@0E658
	call	L026B8	;@0E65C
	jne	@@1	;@0E65F
	cmp	ax, word ptr ds:[5838h]	;@0E661
	jne	@@1	;@0E665
	add	si, 2	;@0E667
	call	L01C52	;@0E66A
	jne	@@1	;@0E66D
	push	si	;@0E66F
	jcxz	@@5	;@0E670
	sub	word ptr ds:[5708h], cx	;@0E672
	jb	@@5	;@0E676
@@4:	push	cx	;@0E678
	mov	si, bx	;@0E679
	mov	cx, word ptr ds:[5708h]	;@0E67B
	lodsb	;@0E67F
	mov	di, word ptr ds:[5706h]	;@0E680
	repne scasb	;@0E684
	mov	word ptr ds:[5708h], cx	;@0E686
	mov	word ptr ds:[5706h], di	;@0E68A
	pop	cx	;@0E68E
	jne	@@5	;@0E68F
	push	cx	;@0E691
	dec	cx	;@0E692
	repe cmpsb	;@0E693
	pop	cx	;@0E695
	jne	@@4	;@0E696
	mov	ax, word ptr ds:[5706h]	;@0E698
	sub	ax, word ptr ds:[5704h]	;@0E69B
	jmp	short @@6	;@0E69F
@@5:	xor	ax, ax	;@0E6A1
@@6:	pop	si	;@0E6A3
	xor	dx, dx	;@0E6A4
	mov	cx, word ptr ds:[56BAh]	;@0E6A6
	call	L075EC	;@0E6AA
	db	0E9h, 8Ah, 11h	; jmp L0F83A	;@0E6AD
L0E6B0:	call	L0F8D7	;@0E6B0
	jne	L0E6CD	;@0E6B3
	call	L026B8	;@0E6B5
	jne	@@1	;@0E6B8
	call	L0066E	;@0E6BA
	je	@@1	;@0E6BD
	add	si, 2	;@0E6BF
	jmp	short L0E6D8	;@0E6C2
@@1:	mov	cx, 4Ah	;@0E6C4
	call	L03208	;@0E6C7
	jmp	L0F83A	;@0E6CA
L0E6CD:	jmp	L0265C	;@0E6CD
L0E6D0:	call	L0F8D7	;@0E6D0
	jne	L0E6CD	;@0E6D3
	call	L00692	;@0E6D5
L0E6D8:	cmp	word ptr ds:[5194h], 0	;@0E6D8
	jne	@@4	;@0E6DD
	push	dx	;@0E6DF
	call	L0A89D	;@0E6E0
	pop	ax	;@0E6E3
	je	@@1	;@0E6E4
	mov	cx, 7	;@0E6E6
	call	L03208	;@0E6E9
	push	ax	;@0E6EC
	call	L05590	;@0E6ED
	pop	ax	;@0E6F0
@@1:	push	ax	;@0E6F1
	call	L07745	;@0E6F2
	pop	dx	;@0E6F5
	mov	es, dx	;@0E6F6
	and	ax, ax	;@0E6F8
	jne	@@2	;@0E6FA
	test	bl, 20h	;@0E6FC
	je	@@3	;@0E6FF
	mov	ax, di	;@0E701
	call	L0109C	;@0E703
	jne	@@2	;@0E706
	push	ax	;@0E708
	push	bx	;@0E709
	call	L011AE	;@0E70A
	pop	bx	;@0E70D
	pop	ax	;@0E70E
	call	L004D3	;@0E70F
	mov	ax, word ptr ds:[5154h]	;@0E712
	mov	dx, word ptr ds:[5156h]	;@0E715
	call	L034E8	;@0E719
@@2:	jmp	L0F83A	;@0E71C
@@3:	mov	cx, 42h	;@0E71F
	call	L03208	;@0E722
	jmp	L0F83A	;@0E725
@@4:	mov	cx, 49h	;@0E728
	jmp	L03208	;@0E72B
L0E72E:	call	L0F8D7	;@0E72E
	jne	L0E74B	;@0E731
	call	L026B8	;@0E733
	jne	@@1	;@0E736
	call	L0066E	;@0E738
	je	@@1	;@0E73B
	add	si, 2	;@0E73D
	jmp	short L0E768	;@0E740
@@1:	mov	cx, 4Ah	;@0E742
	call	L03208	;@0E745
	jmp	L0F83A	;@0E748
L0E74B:	jmp	L0265C	;@0E74B
L0E74E:	test	word ptr ds:[5166h], 4000h	;@0E74E
	je	L0E76F	;@0E754
	mov	cx, 807Fh	;@0E756
	push	dx	;@0E759
	call	L03208	;@0E75A
	pop	dx	;@0E75D
	jmp	short L0E76F	;@0E75E
L0E760:	call	L0F8D7	;@0E760
	jne	L0E74B	;@0E763
	call	L00692	;@0E765
L0E768:	test	byte ptr ds:[516Ah], 80h	;@0E768
	jne	L0E74E	;@0E76D
L0E76F:	cmp	word ptr ds:[5194h], 0	;@0E76F
	je	@@1	;@0E774
	mov	cx, 49h	;@0E776
	jmp	L03208	;@0E779
@@1:	mov	word ptr ds:[56BAh], dx	;@0E77C
	mov	ax, dx	;@0E780
	call	L0075E	;@0E782
	jne	@@2	;@0E785
	mov	es, dx	;@0E787
	call	L0154B	;@0E789
	mov	byte ptr ds:[56ECh], 0FFh	;@0E78C
	mov	word ptr ds:[56E8h], di	;@0E791
	mov	byte ptr ds:[56EDh], cl	;@0E795
	mov	word ptr ds:[56EAh], ax	;@0E799
	jmp	short @@3	;@0E79C
@@2:	xor	ax, ax	;@0E79E
	mov	byte ptr ds:[56ECh], al	;@0E7A0
	mov	word ptr ds:[56E8h], ax	;@0E7A3
	mov	byte ptr ds:[56EDh], 60h	;@0E7A6
	mov	word ptr ds:[56EAh], 0	;@0E7AB
	test	word ptr ds:[5160h], 8	;@0E7B1
	je	@@3	;@0E7B7
	test	word ptr ds:[5160h], 1000h	;@0E7B9
	jne	@@3	;@0E7BF
	or	byte ptr ds:[56EDh], 1	;@0E7C1
@@3:	call	L01D7A	;@0E7C6
	jne	@@10	;@0E7C9
	call	L0067F	;@0E7CB
	jne	@@8	;@0E7CE
	add	si, 2	;@0E7D0
	mov	es, ax	;@0E7D3
	call	L004A1	;@0E7D5
	xor	ah, ah	;@0E7D8
	call	L04956	;@0E7DA
	test	word ptr ds:[5160h], 1000h	;@0E7DD
	jne	@@6	;@0E7E3
	add	bx, cx	;@0E7E5
	jcxz	@@7	;@0E7E7
@@4:	cmp	byte ptr [bx-1], 20h	;@0E7E9
	ja	@@5	;@0E7ED
	dec	bx	;@0E7EF
	loop	@@4	;@0E7F0
@@5:	sub	bx, cx	;@0E7F2
@@6:	jcxz	@@7	;@0E7F4
	call	L003D0	;@0E7F6
	call	L00692	;@0E7F9
	mov	word ptr ds:[56E8h], dx	;@0E7FC
	jmp	@@3	;@0E800
@@7:	mov	word ptr ds:[56E8h], cx	;@0E802
	jmp	@@3	;@0E806
@@8:	push	ss	;@0E808
	pop	es	;@0E809
	mov	di, 5786h	;@0E80A
	mov	cx, 13h	;@0E80D
	repne scasw	;@0E810
	jne	@@9	;@0E812
	inc	cx	;@0E814
	mov	bx, 13h	;@0E815
	sub	bx, cx	;@0E818
	add	si, 2	;@0E81A
	shl	bx, 1	;@0E81D
	call	word ptr [bx+2024h]	;@0E81F
	jmp	@@3	;@0E823
@@9:	mov	cx, 102Fh	;@0E825
	mov	di, ax	;@0E828
	call	L03208	;@0E82A
	add	si, 2	;@0E82D
	jmp	@@3	;@0E830
@@10:	call	L0E92E	;@0E832
	jmp	L0EBCB	;@0E835
L0E838:	mov	al, 20h	;@0E838
	jmp	short L0E84E	;@0E83A
L0E83C:	mov	al, 40h	;@0E83C
	jmp	short L0E84E	;@0E83E
L0E840:	mov	al, 0A0h	;@0E840
	jmp	short L0E84E	;@0E842
L0E844:	mov	al, 60h	;@0E844
	jmp	short L0E84E	;@0E846
L0E848:	mov	al, 80h	;@0E848
	jmp	short L0E84E	;@0E84A
L0E84C:	mov	al, 0C0h	;@0E84C
L0E84E:	test	byte ptr ds:[56EDh], 0E0h	;@0E84E
	jne	@@1	;@0E853
	mov	word ptr ds:[56EAh], 0	;@0E855
@@1:	and	byte ptr ds:[56EDh], 1Fh	;@0E85B
	or	byte ptr ds:[56EDh], al	;@0E860
	ret	;@0E864
L0E865:	and	byte ptr ds:[56EDh], 0E3h	;@0E865
	ret	;@0E86A
L0E86B:	and	byte ptr ds:[56EDh], 0E3h	;@0E86B
	or	byte ptr ds:[56EDh], 4	;@0E870
	ret	;@0E875
L0E876:	and	byte ptr ds:[56EDh], 0E3h	;@0E876
	or	byte ptr ds:[56EDh], 8	;@0E87B
	ret	;@0E880
L0E881:	and	byte ptr ds:[56EDh], 0E3h	;@0E881
	or	byte ptr ds:[56EDh], 14h	;@0E886
	ret	;@0E88B
L0E88C:	and	byte ptr ds:[56EDh], 0E3h	;@0E88C
	or	byte ptr ds:[56EDh], 18h	;@0E891
	ret	;@0E896
L0E897:	and	byte ptr ds:[56EDh], 3	;@0E897
	call	L0EB7A	;@0E89C
	and	cx, cx	;@0E89F
	jne	@@2	;@0E8A1
	test	byte ptr ds:[56EDh], 2	;@0E8A3
	jne	@@1	;@0E8A8
	mov	word ptr ds:[56EAh], ax	;@0E8AA
@@1:	xor	al, al	;@0E8AD
	ret	;@0E8AF
@@2:	mov	cx, 87h	;@0E8B0
	call	L03208	;@0E8B3
	jmp	@@1	;@0E8B6
L0E8B8:	mov	byte ptr ds:[56ECh], 0FFh	;@0E8B8
	and	byte ptr ds:[56EDh], 0FEh	;@0E8BD
	ret	;@0E8C2
L0E8C3:	test	word ptr ds:[5160h], 8	;@0E8C3
	je	@@2	;@0E8C9
	mov	byte ptr ds:[56ECh], 0FFh	;@0E8CB
	or	byte ptr ds:[56EDh], 1	;@0E8D0
	test	byte ptr ds:[56EDh], 0E0h	;@0E8D5
	jne	@@1	;@0E8DA
	or	byte ptr ds:[56EDh], 60h	;@0E8DC
	mov	word ptr ds:[56EAh], 0	;@0E8E1
@@1:	or	word ptr ds:[56EAh], 4	;@0E8E7
	ret	;@0E8EC
@@2:	mov	cx, 7Eh	;@0E8ED
	jmp	L03208	;@0E8F0
L0E8F3:	mov	ax, word ptr ds:[5162h]	;@0E8F3
	mov	word ptr ds:[56EAh], ax	;@0E8F6
	or	byte ptr ds:[56EDh], 2	;@0E8F9
	ret	;@0E8FE
L0E8FF:	mov	al, 0	;@0E8FF
	jmp	short L0E90D	;@0E901
L0E903:	mov	al, 1	;@0E903
	jmp	short L0E90D	;@0E905
L0E907:	mov	al, 2	;@0E907
	jmp	short L0E90D	;@0E909
	db	0B0h, 3	;@0E90B
L0E90D:	test	byte ptr ds:[56EDh], 0E0h	;@0E90D
	jne	@@1	;@0E912
	or	byte ptr ds:[56EDh], 60h	;@0E914
	mov	word ptr ds:[56EAh], 0	;@0E919
@@1:	xor	ah, ah	;@0E91F
	and	word ptr ds:[56EAh], -4	;@0E921
	or	ax, 4	;@0E926
	or	word ptr ds:[56EAh], ax	;@0E929
	ret	;@0E92D
L0E92E:	test	word ptr ds:[5160h], 8	;@0E92E
	je	@@1	;@0E934
	test	word ptr ds:[5160h], 1000h	;@0E936
	jne	@@1	;@0E93C
	cmp	byte ptr ds:[56ECh], 0	;@0E93E
	jne	@@1	;@0E943
	test	word ptr ds:[5166h], 40h	;@0E945
	je	@@1	;@0E94B
	mov	cx, 8073h	;@0E94D
	call	L03208	;@0E950
@@1:	mov	es, word ptr ds:[56BAh]	;@0E953
	call	L01357	;@0E957
	jne	@@2	;@0E95A
	mov	ax, word ptr ds:[56E8h]	;@0E95C
	call	L035AC	;@0E95F
	mov	bl, byte ptr ds:[56EDh]	;@0E962
	mov	bh, byte ptr ds:[56ECh]	;@0E966
	mov	di, word ptr ds:[56EAh]	;@0E96A
	call	L01374	;@0E96E
	mov	ax, word ptr ds:[56BAh]	;@0E971
	jmp	L03FB7	;@0E974
@@2:	ret	;@0E977
L0E978:	db	0E8h, 5Ch, 0Fh	; call L0F8D7	;@0E978
	jne	L0E9CA	;@0E97B
	call	L026B8	;@0E97D
	jne	@@1	;@0E980
	add	si, 2	;@0E982
	jmp	short L0E998	;@0E985
@@1:	cmp	word ptr ds:[5194h], 0	;@0E987
	je	L0E9AD	;@0E98C
	jmp	short L0E9C4	;@0E98E
L0E990:	call	L0F8D7	;@0E990
	jne	L0E9CA	;@0E993
	call	L00692	;@0E995
L0E998:	cmp	word ptr ds:[5194h], 0	;@0E998
	jne	L0E9B6	;@0E99D
	cmp	dx, word ptr ds:[5162h]	;@0E99F
	je	L0E9AD	;@0E9A3
	mov	cx, 902Eh	;@0E9A5
	mov	di, dx	;@0E9A8
	call	L03208	;@0E9AA
L0E9AD:	call	L0400B	;@0E9AD
	call	L0EBCB	;@0E9B0
	db	0E9h, 84h, 0Eh	; jmp L0F83A	;@0E9B3
L0E9B6:	cmp	dx, word ptr ds:[5194h]	;@0E9B6
	je	L0E9C4	;@0E9BA
	mov	cx, 902Eh	;@0E9BC
	mov	di, dx	;@0E9BF
	call	L03208	;@0E9C1
L0E9C4:	call	L0397B	;@0E9C4
	db	0E9h, 70h, 0Eh	; jmp L0F83A	;@0E9C7
L0E9CA:	jmp	L0265C	;@0E9CA
L0E9CD:	call	L0F8D7	;@0E9CD
	jne	@@1	;@0E9D0
	call	L026B8	;@0E9D2
	jne	@@4	;@0E9D5
	call	L0066E	;@0E9D7
	je	@@4	;@0E9DA
	mov	dx, ax	;@0E9DC
	add	si, 2	;@0E9DE
	test	word ptr ds:[5160h], 1000h	;@0E9E1
	jne	@@2	;@0E9E7
	mov	cx, 6Fh	;@0E9E9
	call	L03208	;@0E9EC
	jmp	L0F83A	;@0E9EF
@@1:	jmp	L0265C	;@0E9F2
	db	0E8h, 0DFh, 0Eh, 75h, 0F8h	;@0E9F5
@@2:	call	L00692	;@0E9FA
	push	dx	;@0E9FD
	mov	es, dx	;@0E9FE
	call	L00B09	;@0EA00
	jne	@@3	;@0EA03
	call	L035AC	;@0EA05
	call	L00B4C	;@0EA08
	mov	word ptr ds:[56BCh], es	;@0EA0B
	mov	word ptr ds:[56F8h], 0	;@0EA0F
	push	es	;@0EA15
	mov	bx, 0EA32h	;@0EA16
	call	L0EBF9	;@0EA19
	pop	es	;@0EA1C
	mov	ax, word ptr ds:[56F8h]	;@0EA1D
	pop	dx	;@0EA20
	call	L00B56	;@0EA21
	jmp	L0F83A	;@0EA24
@@3:	pop	dx	;@0EA27
	ret	;@0EA28
@@4:	mov	cx, 4Ah	;@0EA29
	call	L03208	;@0EA2C
	jmp	L0F83A	;@0EA2F
L0EA32:	call	L026B8	;@0EA32
	jne	@@2	;@0EA35
	mov	ax, dx	;@0EA37
	call	L0066E	;@0EA39
	je	@@1	;@0EA3C
	add	si, 2	;@0EA3E
	mov	word ptr ds:[56FAh], ax	;@0EA41
	mov	ax, word ptr ds:[56F8h]	;@0EA44
	mov	word ptr ds:[56FCh], ax	;@0EA47
	call	L026B8	;@0EA4A
	jne	@@3	;@0EA4D
	cmp	ax, word ptr ds:[5808h]	;@0EA4F
	jne	@@3	;@0EA53
	add	si, 2	;@0EA55
	jmp	short @@4	;@0EA58
@@1:	xor	al, al	;@0EA5A
	dec	al	;@0EA5C
@@2:	ret	;@0EA5E
@@3:	mov	cx, 0Bh	;@0EA5F
	call	L03208	;@0EA62
@@4:	call	L0EB7A	;@0EA65
	and	cx, cx	;@0EA68
	jne	@@5	;@0EA6A
	mov	cx, word ptr ds:[56F8h]	;@0EA6C
	add	cx, ax	;@0EA70
	jb	@@5	;@0EA72
	cmp	cx, 21h	;@0EA74
	jae	@@5	;@0EA77
	mov	word ptr ds:[56F8h], cx	;@0EA79
	mov	word ptr ds:[56FEh], ax	;@0EA7D
	jmp	short @@6	;@0EA80
@@5:	mov	word ptr ds:[56FEh], 0	;@0EA82
	mov	di, word ptr ds:[56FAh]	;@0EA88
	mov	cx, 1057h	;@0EA8C
	call	L03208	;@0EA8F
@@6:	xor	ax, ax	;@0EA92
	mov	word ptr ds:[5700h], ax	;@0EA94
	mov	word ptr ds:[5702h], ax	;@0EA97
	call	L026B8	;@0EA9A
	jne	@@7	;@0EA9D
	cmp	ax, word ptr ds:[580Ah]	;@0EA9F
	jne	@@7	;@0EAA3
	add	si, 2	;@0EAA5
	call	L0EB7A	;@0EAA8
	mov	word ptr ds:[5700h], ax	;@0EAAB
	mov	word ptr ds:[5702h], cx	;@0EAAE
@@7:	mov	es, word ptr ds:[56FAh]	;@0EAB2
	call	L00A95	;@0EAB6
	jne	@@8	;@0EAB9
	call	L035AC	;@0EABB
	mov	dl, byte ptr ds:[56FCh]	;@0EABE
	mov	dh, byte ptr ds:[56FEh]	;@0EAC2
	mov	ax, word ptr ds:[56BCh]	;@0EAC6
	call	L00AAD	;@0EAC9
	mov	es, word ptr ds:[56BCh]	;@0EACC
	mov	cx, word ptr ds:[5700h]	;@0EAD0
	mov	di, word ptr ds:[5702h]	;@0EAD4
	mov	ax, word ptr ds:[56FAh]	;@0EAD8
	mov	bl, byte ptr ds:[56FEh]	;@0EADB
	call	L00CE9	;@0EADF
@@8:	xor	al, al	;@0EAE2
	ret	;@0EAE4
L0EAE5:	xor	al, al	;@0EAE5
	jmp	short @@1	;@0EAE7
	db	0B0h, 1	;@0EAE9
@@1:	mov	byte ptr ds:[56E6h], al	;@0EAEB
	db	0E8h, 0E6h, 0Dh	; call L0F8D7	;@0EAEE
	jne	L0EB5D	;@0EAF1
	call	L00692	;@0EAF3
	jmp	short L0EB24	;@0EAF6
L0EAF8:	xor	al, al	;@0EAF8
	jmp	short @@1	;@0EAFA
	db	0B0h, 1	;@0EAFC
@@1:	mov	byte ptr ds:[56E6h], al	;@0EAFE
	call	L0F8D7	;@0EB01
	jne	L0EB5D	;@0EB04
	call	L026B8	;@0EB06
	jne	L0EB60	;@0EB09
	call	L0066E	;@0EB0B
	je	L0EB60	;@0EB0E
	add	si, 2	;@0EB10
	test	word ptr ds:[5160h], 1000h	;@0EB13
	jne	L0EB24	;@0EB19
	mov	cx, 6Fh	;@0EB1B
	call	L03208	;@0EB1E
	jmp	L0F83A	;@0EB21
L0EB24:	cmp	word ptr ds:[5194h], 0	;@0EB24
	je	@@1	;@0EB29
	mov	cx, 49h	;@0EB2B
	call	L03208	;@0EB2E
	jmp	short L0EB70	;@0EB31
@@1:	push	dx	;@0EB33
	mov	es, dx	;@0EB34
	call	L00C62	;@0EB36
	pop	ax	;@0EB39
	jne	L0EB5D	;@0EB3A
	mov	word ptr ds:[5194h], ax	;@0EB3C
	call	L035AC	;@0EB3F
	call	L00CA5	;@0EB42
	mov	bl, byte ptr ds:[56E6h]	;@0EB45
	call	L0390D	;@0EB49
	xor	ax, ax	;@0EB4C
	mov	word ptr ds:[5154h], ax	;@0EB4E
	mov	word ptr ds:[5156h], ax	;@0EB51
	mov	word ptr ds:[518Ah], ax	;@0EB54
	mov	word ptr ds:[518Ch], ax	;@0EB57
	db	0E9h, 0DDh, 0Ch	; jmp L0F83A	;@0EB5A
L0EB5D:	jmp	L0265C	;@0EB5D
L0EB60:	cmp	word ptr ds:[5194h], 0	;@0EB60
	jne	L0EB70	;@0EB65
	mov	cx, 4Ah	;@0EB67
	call	L03208	;@0EB6A
	jmp	L0F83A	;@0EB6D
L0EB70:	mov	bl, byte ptr ds:[56E6h]	;@0EB70
	call	L038F9	;@0EB74
	db	0E9h, 0C0h, 0Ch	; jmp L0F83A	;@0EB77
L0EB7A:	call	L0A7C0	;@0EB7A
	je	@@1	;@0EB7D
	mov	cx, 2	;@0EB7F
	call	L03208	;@0EB82
	call	L05542	;@0EB85
@@1:	jmp	L076DE	;@0EB88
L0EB8B:	call	L0A7C0	;@0EB8B
	je	@@1	;@0EB8E
	mov	cx, 2	;@0EB90
	call	L03208	;@0EB93
	call	L05542	;@0EB96
@@1:	jmp	L07727	;@0EB99
L0EB9C:	call	L026B8	;@0EB9C
	jne	@@1	;@0EB9F
	add	si, 2	;@0EBA1
	mov	cx, ss	;@0EBA4
	mov	es, cx	;@0EBA6
	mov	di, 57CCh	;@0EBA8
	mov	cx, 10h	;@0EBAB
	repne scasw	;@0EBAE
	jne	@@2	;@0EBB0
	mov	bx, 0Fh	;@0EBB2
	sub	bx, cx	;@0EBB5
	shl	bx, 1	;@0EBB7
	mov	ax, word ptr [bx+2004h]	;@0EBB9
	ret	;@0EBBD
@@1:	mov	ax, 0FFFFh	;@0EBBE
	ret	;@0EBC1
@@2:	mov	cx, 72h	;@0EBC2
	call	L03208	;@0EBC5
	xor	ax, ax	;@0EBC8
	ret	;@0EBCA
L0EBCB:	mov	ax, word ptr ds:[5162h]	;@0EBCB
	and	ax, ax	;@0EBCE
	je	@@2	;@0EBD0
	mov	byte ptr ds:[56C4h], 32h	;@0EBD2
	call	L00752	;@0EBD7
	je	@@1	;@0EBDA
	mov	byte ptr ds:[56C4h], 34h	;@0EBDC
@@1:	mov	es, word ptr ds:[5766h]	;@0EBE1
	db	0E8h, 41h, 9	; call L0F529	;@0EBE5
	mov	bx, 56C4h	;@0EBE8
	mov	cx, 1	;@0EBEB
	call	L003DA	;@0EBEE
	mov	es, word ptr ds:[5762h]	;@0EBF1
	db	0E9h, 31h, 9	; jmp L0F529	;@0EBF5
@@2:	ret	;@0EBF8
L0EBF9:	mov	word ptr ds:[56C0h], bx	;@0EBF9
@@1:	call	word ptr ds:[56C0h]	;@0EBFD
	je	@@2	;@0EC01
	test	word ptr ds:[5160h], 1000h	;@0EC03
	je	@@3	;@0EC09
	mov	cx, 10h	;@0EC0B
	jmp	L03208	;@0EC0E
@@2:	call	L026B8	;@0EC11
	jne	@@3	;@0EC14
	cmp	ax, word ptr ds:[5838h]	;@0EC16
	jne	@@3	;@0EC1A
	add	si, 2	;@0EC1C
	jmp	@@1	;@0EC1F
@@3:	ret	;@0EC21
L0EC22:	mov	di, 26B8h	;@0EC22
L0EC25:	mov	al, byte ptr ds:[51A4h]	;@0EC25
	mov	byte ptr ds:[56DEh], al	;@0EC28
	call	di	;@0EC2B
	db	75h, 1Ch	; jne @@1	;@0EC2D
	push	ds	;@0EC2F
	pop	es	;@0EC30
	mov	cx, 4	;@0EC31
	mov	di, 57F8h	;@0EC34
	repne scasw	;@0EC37
	db	75h, 10h	; jne @@1	;@0EC39
	neg	cx	;@0EC3B
	db	81h, 0C1h, 4, 0	; add cx, 4	;@0EC3D
	db	49h	; dec cx	;@0EC41
	mov	byte ptr ds:[56DEh], cl	;@0EC42
	add	si, 2	;@0EC46
	xor	al, al	;@0EC49
@@1:	ret	;@0EC4B
L0EC4C:	mov	di, 26B8h	;@0EC4C
L0EC4F:	mov	al, byte ptr ds:[516Bh]	;@0EC4F
	and	al, 70h	;@0EC52
	mov	byte ptr ds:[56DDh], al	;@0EC54
	call	di	;@0EC57
	db	75h, 27h	; jne @@1	;@0EC59
	push	ds	;@0EC5B
	pop	es	;@0EC5C
	mov	cx, 6	;@0EC5D
	mov	di, 57ECh	;@0EC60
	repne scasw	;@0EC63
	db	75h, 1Bh	; jne @@1	;@0EC65
	neg	cx	;@0EC67
	db	81h, 0C1h, 6, 0	; add cx, 6	;@0EC69
	db	49h	; dec cx	;@0EC6D
	mov	bx, cx	;@0EC6E
	mov	al, byte ptr [bx+206Eh]	;@0EC70
	and	byte ptr ds:[56DDh], 8Fh	;@0EC74
	or	byte ptr ds:[56DDh], al	;@0EC79
	add	si, 2	;@0EC7D
	xor	al, al	;@0EC80
@@1:	ret	;@0EC82
L0EC83:	push	si	;@0EC83
	mov	di, 1D7Fh	;@0EC84
	call	L01D70	;@0EC87
	push	cx	;@0EC8A
	push	di	;@0EC8B
	call	L0EC25	;@0EC8C
	pop	di	;@0EC8F
	pop	cx	;@0EC90
	jne	@@1	;@0EC91
	call	L01D70	;@0EC93
@@1:	push	cx	;@0EC96
	push	di	;@0EC97
	call	L0EC4F	;@0EC98
	pop	di	;@0EC9B
	pop	cx	;@0EC9C
	jne	@@2	;@0EC9D
	call	L01D70	;@0EC9F
@@2:	push	cx	;@0ECA2
	call	di	;@0ECA3
	pop	cx	;@0ECA5
	pop	di	;@0ECA6
	jne	@@4	;@0ECA7
	call	L0066E	;@0ECA9
	je	@@4	;@0ECAC
	mov	bl, byte ptr ds:[516Bh]	;@0ECAE
	push	bx	;@0ECB2
	mov	bl, byte ptr ds:[56DDh]	;@0ECB3
	and	byte ptr ds:[516Bh], 8Fh	;@0ECB7
	or	byte ptr ds:[516Bh], bl	;@0ECBC
	call	L01D9B	;@0ECC0
	pop	bx	;@0ECC3
	mov	byte ptr ds:[516Bh], bl	;@0ECC4
@@3:	add	si, 2	;@0ECC8
	mov	word ptr ds:[56C8h], ax	;@0ECCB
	mov	word ptr ds:[56C6h], dx	;@0ECCE
	xor	al, al	;@0ECD2
	ret	;@0ECD4
@@4:	mov	si, di	;@0ECD5
	call	L01D7A	;@0ECD7
	call	L0066E	;@0ECDA
	jne	@@3	;@0ECDD
	xor	al, al	;@0ECDF
	dec	al	;@0ECE1
	ret	;@0ECE3
L0ECE4:	mov	byte ptr ds:[38D8h], 0	;@0ECE4
	mov	di, word ptr ds:[56CAh]	;@0ECE9
	mov	cx, 102Dh	;@0ECED
	call	L03208	;@0ECF0
	xor	al, al	;@0ECF3
	ret	;@0ECF5
L0ECF6:	call	L0EDBA	;@0ECF6
	jne	@@2	;@0ECF9
	mov	bl, byte ptr ds:[56DCh]	;@0ECFB
	mov	cx, word ptr ds:[56CCh]	;@0ECFF
	and	bl, 0Fh	;@0ED03
	cmp	byte ptr ds:[56DAh], 0	;@0ED06
	jne	@@1	;@0ED0B
	cmp	bl, 1	;@0ED0D
	jne	@@1	;@0ED10
	inc	byte ptr ds:[56D2h]	;@0ED12
@@1:	call	L00094	;@0ED16
	mov	cx, dx	;@0ED19
	mov	bx, ax	;@0ED1B
	mov	ax, word ptr ds:[56D2h]	;@0ED1D
	mov	di, word ptr ds:[56D4h]	;@0ED20
	push	si	;@0ED24
	mov	si, ax	;@0ED25
	call	L04A95	;@0ED27
	pop	si	;@0ED2A
	xor	al, al	;@0ED2B
@@2:	ret	;@0ED2D
L0ED2E:	call	@@1	;@0ED2E
	mov	cx, word ptr ds:[56E2h]	;@0ED31
	mov	dx, word ptr ds:[56E4h]	;@0ED35
	push	cx	;@0ED39
	push	dx	;@0ED3A
	mov	ax, word ptr ds:[56C6h]	;@0ED3B
	push	ax	;@0ED3E
	mov	es, ax	;@0ED3F
	mov	ax, cx	;@0ED41
	call	L03558	;@0ED43
	pop	cx	;@0ED46
	pop	dx	;@0ED47
	pop	ax	;@0ED48
	mov	bl, byte ptr ds:[56DCh]	;@0ED49
	mov	di, word ptr ds:[56CCh]	;@0ED4D
	jmp	L07590	;@0ED51
@@1:	mov	bl, byte ptr ds:[56CFh]	;@0ED54
	xor	bh, bh	;@0ED58
	shl	bx, 1	;@0ED5A
	call	word ptr [bx+1FFAh]	;@0ED5C
	mov	ax, word ptr ds:[56D2h]	;@0ED60
	mov	dx, word ptr ds:[56D4h]	;@0ED63
	cmp	ax, 1	;@0ED67
	jne	@@2	;@0ED6A
	and	dx, dx	;@0ED6C
	jne	@@2	;@0ED6E
	ret	;@0ED70
@@2:	push	ax	;@0ED71
	push	bx	;@0ED72
	push	dx	;@0ED73
	mov	bl, byte ptr ds:[56DCh]	;@0ED74
	mov	cx, word ptr ds:[56CCh]	;@0ED78
	and	bl, 0Fh	;@0ED7C
	call	L00094	;@0ED7F
	pop	cx	;@0ED82
	pop	bx	;@0ED83
	pop	bp	;@0ED84
	jmp	L03606	;@0ED85
L0ED88:	mov	bl, byte ptr ds:[56DCh]	;@0ED88
	mov	ax, word ptr ds:[56CCh]	;@0ED8C
	jmp	L004D3	;@0ED8F
L0ED92:	mov	bl, byte ptr ds:[56CEh]	;@0ED92
	mov	ax, word ptr ds:[56D0h]	;@0ED96
	jmp	L00531	;@0ED99
L0ED9C:	mov	bl, byte ptr ds:[56CEh]	;@0ED9C
	mov	ax, word ptr ds:[56D0h]	;@0EDA0
	jmp	L00575	;@0EDA3
L0EDA6:	mov	bl, byte ptr ds:[56CEh]	;@0EDA6
	mov	ax, word ptr ds:[56D0h]	;@0EDAA
	jmp	L005B9	;@0EDAD
L0EDB0:	mov	bl, byte ptr ds:[56CEh]	;@0EDB0
	mov	ax, word ptr ds:[56D0h]	;@0EDB4
	jmp	L005FD	;@0EDB7
L0EDBA:	call	L01D7A	;@0EDBA
	jne	L0EDFE	;@0EDBD
	call	L0066E	;@0EDBF
	je	@@1	;@0EDC2
	add	si, 2	;@0EDC4
	mov	word ptr ds:[56C8h], ax	;@0EDC7
	mov	word ptr ds:[56C6h], dx	;@0EDCA
	jmp	short L0EDDA	;@0EDCE
@@1:	xor	al, al	;@0EDD0
	dec	al	;@0EDD2
	ret	;@0EDD4
L0EDD5:	call	L0EC83	;@0EDD5
	jne	L0EDFE	;@0EDD8
L0EDDA:	call	L0EE3B	;@0EDDA
	jne	L0EDFE	;@0EDDD
	mov	cx, word ptr ds:[56D6h]	;@0EDDF
	mov	di, word ptr ds:[56D8h]	;@0EDE3
	mov	ax, word ptr ds:[56D2h]	;@0EDE7
	mov	dx, word ptr ds:[56D4h]	;@0EDEA
	call	L04A81	;@0EDEE
	mov	ax, word ptr [bx]	;@0EDF1
	mov	word ptr ds:[56D2h], ax	;@0EDF3
	mov	ax, word ptr [bx+2]	;@0EDF6
	mov	word ptr ds:[56D4h], ax	;@0EDF9
	xor	al, al	;@0EDFC
L0EDFE:	ret	;@0EDFE
	db	32h, 0C0h, 0A2h, 0DBh, 56h, 0E8h, 7Ch, 0FEh, 75h, 0F5h, 0A1h, 0C8h	;@0EDFF
	db	56h, 3Bh, 6, 'XXt', 18h, 0C6h, 6, 0DBh, 56h, 8, 3Bh, 6, 'ZXt'
	db	0Dh, 8Ah, 1Eh, 6Bh, 51h, 80h, 0E3h, 8, 88h, 1Eh, 0DBh, 56h, 0EBh
	db	11h, 0E8h, 56h, 0FEh, 74h, 0Ch, 0B9h, 0Eh, 0, 0E8h, 0D3h, 43h
	db	0C7h, 6, 0C6h, 56h, 0, 0
L0EE3B:	mov	ax, 1	;@0EE3B
	mov	word ptr ds:[56D2h], ax	;@0EE3E
	mov	word ptr ds:[56D6h], ax	;@0EE41
	xor	ax, ax	;@0EE44
	mov	word ptr ds:[56D4h], ax	;@0EE46
	mov	word ptr ds:[56D8h], ax	;@0EE49
	mov	byte ptr ds:[56CFh], al	;@0EE4C
	mov	byte ptr ds:[56DAh], al	;@0EE4F
	call	L026B8	;@0EE52
	jne	@@5	;@0EE55
	cmp	ax, word ptr ds:[589Ah]	;@0EE57
	jne	@@4	;@0EE5B
	add	si, 2	;@0EE5D
	call	L0A7C0	;@0EE60
	je	@@1	;@0EE63
	mov	cx, 2	;@0EE65
	call	L03208	;@0EE68
	call	L05542	;@0EE6B
@@1:	call	L076DE	;@0EE6E
	mov	byte ptr ds:[56DAh], 0FFh	;@0EE71
	mov	word ptr ds:[56D6h], ax	;@0EE76
	mov	word ptr ds:[56D8h], cx	;@0EE79
	call	L026B8	;@0EE7D
	jne	@@2	;@0EE80
	cmp	ax, word ptr ds:[5830h]	;@0EE82
	je	@@3	;@0EE86
@@2:	mov	cx, 9	;@0EE88
	call	L03208	;@0EE8B
	jmp	short @@4	;@0EE8E
@@3:	add	si, 2	;@0EE90
	call	L026B8	;@0EE93
	jne	@@5	;@0EE96
@@4:	cmp	ax, word ptr ds:[5808h]	;@0EE98
	jne	@@5	;@0EE9C
	add	si, 2	;@0EE9E
	jmp	short @@7	;@0EEA1
@@5:	test	word ptr ds:[5160h], 1000h	;@0EEA3
	jne	@@6	;@0EEA9
	call	@@23	;@0EEAB
	xor	ax, ax	;@0EEAE
	jmp	short @@9	;@0EEB0
@@6:	mov	cx, 0Bh	;@0EEB2
	call	L03208	;@0EEB5
@@7:	call	@@10	;@0EEB8
	call	L026B8	;@0EEBB
	jne	@@9	;@0EEBE
	cmp	ax, word ptr ds:[5808h]	;@0EEC0
	jne	@@9	;@0EEC4
	add	si, 2	;@0EEC6
	call	L0A7C0	;@0EEC9
	je	@@8	;@0EECC
	mov	cx, 2	;@0EECE
	call	L03208	;@0EED1
	call	L05542	;@0EED4
@@8:	call	L076DE	;@0EED7
	mov	word ptr ds:[56D2h], ax	;@0EEDA
	mov	word ptr ds:[56D4h], cx	;@0EEDD
	mov	byte ptr ds:[56DAh], 0FFh	;@0EEE1
@@9:	xor	al, al	;@0EEE6
	ret	;@0EEE8
@@10:	call	L026B8	;@0EEE9
	jne	@@18	;@0EEEC
	cmp	ax, word ptr ds:[5858h]	;@0EEEE
	je	@@12	;@0EEF2
	cmp	ax, word ptr ds:[585Ah]	;@0EEF4
	je	@@13	;@0EEF8
	cmp	ax, word ptr ds:[583Ch]	;@0EEFA
	je	@@16	;@0EEFE
	cmp	ax, word ptr ds:[5844h]	;@0EF00
	je	@@19	;@0EF04
@@11:	call	L0A89D	;@0EF06
	jne	@@18	;@0EF09
	call	L07745	;@0EF0B
	mov	byte ptr ds:[56DCh], bl	;@0EF0E
	mov	word ptr ds:[56CAh], ax	;@0EF12
	mov	word ptr ds:[56CCh], di	;@0EF15
	ret	;@0EF19
@@12:	xor	al, al	;@0EF1A
	jmp	short @@14	;@0EF1C
@@13:	mov	al, 8	;@0EF1E
@@14:	push	ax	;@0EF20
	add	si, 2	;@0EF21
	call	L026B8	;@0EF24
	jne	@@15	;@0EF27
	cmp	ax, word ptr ds:[5844h]	;@0EF29
	jne	@@15	;@0EF2D
	pop	ax	;@0EF2F
	jmp	short @@20	;@0EF30
@@15:	pop	ax	;@0EF32
	sub	si, 2	;@0EF33
	jmp	@@11	;@0EF36
@@16:	add	si, 2	;@0EF38
	xor	ax, ax	;@0EF3B
	mov	byte ptr ds:[56DCh], al	;@0EF3D
	mov	word ptr ds:[56CAh], ax	;@0EF40
	mov	word ptr ds:[56CCh], ax	;@0EF43
@@17:	ret	;@0EF46
@@18:	mov	cx, 7	;@0EF47
	call	L03208	;@0EF4A
	jmp	short @@23	;@0EF4D
@@19:	mov	al, byte ptr ds:[516Bh]	;@0EF4F
	and	al, 8	;@0EF52
@@20:	add	si, 2	;@0EF54
	test	word ptr ds:[5160h], 8	;@0EF57
	jne	@@21	;@0EF5D
	mov	bx, 122h	;@0EF5F
	and	al, al	;@0EF62
	je	@@22	;@0EF64
	mov	bx, 223h	;@0EF66
	jmp	short @@22	;@0EF69
@@21:	mov	bx, 323h	;@0EF6B
	and	al, al	;@0EF6E
	je	@@22	;@0EF70
	mov	bx, 429h	;@0EF72
@@22:	mov	byte ptr ds:[56DCh], bl	;@0EF75
	mov	byte ptr ds:[56CFh], bh	;@0EF79
	xor	ax, ax	;@0EF7D
	mov	word ptr ds:[56CAh], ax	;@0EF7F
	mov	word ptr ds:[56CCh], ax	;@0EF82
	call	L0A89D	;@0EF85
	jne	@@17	;@0EF88
	call	L07745	;@0EF8A
	mov	byte ptr ds:[56CEh], bl	;@0EF8D
	mov	word ptr ds:[56D0h], di	;@0EF91
	mov	word ptr ds:[56CAh], ax	;@0EF95
	ret	;@0EF98
@@23:	mov	al, 22h	;@0EF99
	test	word ptr ds:[5160h], 8	;@0EF9B
	je	@@24	;@0EFA1
	mov	al, 23h	;@0EFA3
@@24:	mov	byte ptr ds:[56DCh], al	;@0EFA5
	xor	ax, ax	;@0EFA8
	mov	word ptr ds:[56CAh], ax	;@0EFAA
	mov	word ptr ds:[56CCh], ax	;@0EFAD
	ret	;@0EFB0
L0EFB1:	test	byte ptr ds:[51A3h], 10h	;@0EFB1
	je	@@1	;@0EFB6
	test	byte ptr ds:[516Ah], 20h	;@0EFB8
	je	@@1	;@0EFBD
	mov	ax, word ptr ds:[5180h]	;@0EFBF
	or	ax, word ptr ds:[5182h]	;@0EFC2
	or	ax, word ptr ds:[5184h]	;@0EFC6
	or	ax, word ptr ds:[5186h]	;@0EFCA
	jne	@@1	;@0EFCE
	cmp	byte ptr ds:[519Eh], 0	;@0EFD0
	jne	@@1	;@0EFD5
	or	byte ptr ds:[51A3h], 80h	;@0EFD7
@@1:	ret	;@0EFDC
	db	0	;@0EFDD
L0EFDE:	mov	word ptr ds:[58AAh], ax	;@0EFDE
	mov	byte ptr ds:[58B6h], dh	;@0EFE1
	mov	byte ptr ds:[38D7h], 0	;@0EFE5
	mov	word ptr ds:[58A6h], bx	;@0EFEA
	xor	ax, ax	;@0EFEE
	mov	byte ptr ds:[58B7h], al	;@0EFF0
	mov	byte ptr ds:[58B8h], al	;@0EFF3
	mov	byte ptr ds:[38D6h], al	;@0EFF6
	mov	byte ptr ds:[38D7h], al	;@0EFF9
	mov	byte ptr ds:[38D9h], al	;@0EFFC
	mov	byte ptr ds:[38DAh], al	;@0EFFF
	mov	word ptr ds:[572Ah], di	;@0F002
	mov	byte ptr ds:[38DBh], al	;@0F006
	mov	byte ptr ds:[38DCh], al	;@0F009
	test	byte ptr ds:[58B6h], 1	;@0F00C
	je	@@1	;@0F011
	mov	si, 2098h	;@0F013
	db	0E8h, 1Ch, 4	; call L0F435	;@0F016
	mov	si, 20A0h	;@0F019
	db	0E8h, 16h, 4	; call L0F435	;@0F01C
@@1:	call	far ptr L11344	;@0F01F
	call	far ptr L1143C	;@0F024
	call	far ptr L11156	;@0F029
	call	L042BC	;@0F02E
	call	L01B94	;@0F031
	call	L0334C	;@0F034
	call	far ptr L12310	;@0F037
	call	far ptr L0FD9E	;@0F03C
	call	far ptr L11E07	;@0F041
	call	L047A2	;@0F046
	call	L05292	;@0F049
	mov	ax, word ptr ds:[58A6h]	;@0F04C
	call	far ptr L111AB	;@0F04F
	mov	bx, 2568h	;@0F054
	mov	cx, 212h	;@0F057
	call	L0042B	;@0F05A
	mov	word ptr ds:[572Eh], ax	;@0F05D
	add	ax, 22h	;@0F060
	mov	word ptr ds:[572Ch], ax	;@0F063
	call	L05298	;@0F066
	mov	di, 573Eh	;@0F069
	mov	bx, 3198h	;@0F06C
	mov	cx, 61h	;@0F06F
	xor	al, al	;@0F072
	call	L00462	;@0F074
	mov	di, 5800h	;@0F077
	mov	bx, 33C9h	;@0F07A
	mov	cx, 53h	;@0F07D
	mov	al, 0FFh	;@0F080
	call	L00462	;@0F082
	test	byte ptr ds:[58B6h], 2	;@0F085
	je	@@2	;@0F08A
	mov	si, 20A8h	;@0F08C
	db	0E9h, 0A3h, 3	; jmp L0F435	;@0F08F
@@2:	ret	;@0F092
L0F093:	call	L047BC	;@0F093
	call	far ptr L1119A	;@0F096
	call	far ptr L1164A	;@0F09B
	ret	;@0F0A0
L0F0A1:	push	ax	;@0F0A1
	push	cx	;@0F0A2
	push	si	;@0F0A3
	push	di	;@0F0A4
	push	bp	;@0F0A5
	call	far ptr L1160D	;@0F0A6
	jae	@@1	;@0F0AB
	call	far ptr L11631	;@0F0AD
	jae	@@1	;@0F0B2
	call	far ptr L111FB	;@0F0B4
	jae	@@1	;@0F0B9
	call	L042D2	;@0F0BB
	jae	@@1	;@0F0BE
	call	L05319	;@0F0C0
	jae	@@1	;@0F0C3
	call	far ptr L12D51	;@0F0C5
	jae	@@1	;@0F0CA
	call	far ptr L0FDA5	;@0F0CC
@@1:	pop	bp	;@0F0D1
	pop	di	;@0F0D2
	pop	si	;@0F0D3
	pop	cx	;@0F0D4
	pop	ax	;@0F0D5
	retf	;@0F0D6
L0F0D7:	xor	al, al	;@0F0D7
	mov	byte ptr ds:[58B8h], al	;@0F0D9
	mov	byte ptr ds:[58B7h], al	;@0F0DC
	mov	byte ptr ds:[58B9h], al	;@0F0DF
	mov	word ptr ds:[58ACh], cx	;@0F0E2
	mov	word ptr ds:[58AEh], bx	;@0F0E6
	mov	word ptr ds:[58B0h], dx	;@0F0EA
	mov	word ptr ds:[58B2h], si	;@0F0EE
	mov	word ptr ds:[58B4h], di	;@0F0F2
	push	word ptr ds:[38BAh]	;@0F0F6
	push	cs	;@0F0FA
	call	@@5	;@0F0FB
	pop	word ptr ds:[38BAh]	;@0F0FE
	jb	@@1	;@0F102
	ret	;@0F104
@@1:	cmp	byte ptr ds:[58B8h], 0	;@0F105
	je	@@2	;@0F10A
	call	far ptr L12E56	;@0F10C
@@2:	cmp	byte ptr ds:[58B7h], 0	;@0F111
	je	@@3	;@0F116
	call	far ptr L0FF1A	;@0F118
@@3:	cmp	byte ptr ds:[58B9h], 0	;@0F11D
	je	@@4	;@0F122
	mov	dx, word ptr ds:[58B0h]	;@0F124
	call	far ptr L1130A	;@0F128
@@4:	mov	sp, word ptr ds:[38BAh]	;@0F12D
	stc	;@0F131
	retf	;@0F132
@@5:	mov	word ptr ds:[38BAh], sp	;@0F133
	mov	word ptr ds:[58A8h], 0	;@0F137
	mov	ax, word ptr ds:[5160h]	;@0F13D
	mov	word ptr ds:[38CAh], ax	;@0F140
	mov	ax, word ptr ds:[5166h]	;@0F143
	mov	word ptr ds:[38CCh], ax	;@0F146
	mov	ax, word ptr ds:[5198h]	;@0F149
	mov	word ptr ds:[38CEh], ax	;@0F14C
	call	L033D6	;@0F14F
	call	L0334C	;@0F152
	mov	ax, word ptr ds:[38CAh]	;@0F155
	mov	word ptr ds:[5160h], ax	;@0F158
	db	0E8h, 67h, 2	; call L0F3C5	;@0F15B
	mov	ax, word ptr ds:[38CCh]	;@0F15E
	mov	word ptr ds:[5166h], ax	;@0F161
	mov	ax, word ptr ds:[38CEh]	;@0F164
	mov	word ptr ds:[5198h], ax	;@0F167
	db	0E8h, 0E6h, 2	; call L0F453	;@0F16A
	mov	bx, word ptr ds:[58AEh]	;@0F16D
	call	far ptr L1148D	;@0F171
	mov	word ptr ds:[58A8h], ax	;@0F176
	xor	ax, ax	;@0F179
	mov	byte ptr ds:[38DDh], al	;@0F17B
	mov	byte ptr ds:[38DEh], al	;@0F17E
	dec	word ptr ds:[38C6h]	;@0F181
@@6:	call	L02640	;@0F185
	mov	ax, word ptr ds:[5154h]	;@0F188
	mov	word ptr ds:[5158h], ax	;@0F18B
	mov	ax, word ptr ds:[5156h]	;@0F18E
	mov	word ptr ds:[515Ah], ax	;@0F191
	mov	ax, word ptr ds:[519Ah]	;@0F194
	mov	word ptr ds:[5168h], ax	;@0F197
	xor	ax, ax	;@0F19A
	mov	byte ptr ds:[38D8h], al	;@0F19C
	mov	si, ax	;@0F19F
	call	word ptr ds:[5734h]	;@0F1A1
	test	byte ptr ds:[38D8h], 1	;@0F1A5
	db	75h, 79h	; jne @@9	;@0F1AA
@@7:	cmp	byte ptr ds:[51A0h], 0	;@0F1AC
	je	@@6	;@0F1B1
	call	L03424	;@0F1B3
@@8:	or	byte ptr ds:[38D7h], 2	;@0F1B6
	db	0E8h, 93h, 11h	; call L00351	;@0F1BB
	db	9Ah, 0C8h, 2Dh	;@0F1BE
	dw	seg L0F9B0
	call	far ptr L1200E	;@0F1C3
	mov	byte ptr ds:[38D8h], 0	;@0F1C8
	cmp	byte ptr ds:[38DEh], 0	;@0F1CD
	db	75h, 69h	; jne @@11	;@0F1D2
	mov	si, 0F5F4h	;@0F1D4
	push	word ptr ds:[5152h]	;@0F1D7
	push	word ptr ds:[515Eh]	;@0F1DB
	call	L04304	;@0F1DF
	pop	word ptr ds:[515Eh]	;@0F1E2
	pop	word ptr ds:[5152h]	;@0F1E6
	call	far ptr L12787	;@0F1EA
	cmp	byte ptr ds:[38DDh], 0	;@0F1EF
	db	74h, 34h	; je @@10	;@0F1F4
	call	far ptr L12CCA	;@0F1F6
	call	far ptr L11E1C	;@0F1FB
	db	0E8h, 16h, 11h	; call L00319	;@0F200
	db	80h, 26h, 0D7h, 38h, 0FDh	; and byte ptr ds:[38D7h], 0FDh	;@0F203
	or	byte ptr ds:[38D7h], 4	;@0F208
	mov	byte ptr ds:[38DDh], 0	;@0F20D
	dec	word ptr ds:[38C6h]	;@0F212
	mov	dx, word ptr ds:[58A8h]	;@0F216
	mov	si, 0F366h	;@0F21A
	mov	di, 0F36Ch	;@0F21D
	call	L0434B	;@0F220
	jmp	@@8	;@0F223
@@9:	call	L042EC	;@0F225
	jmp	@@7	;@0F228
@@10:	and	byte ptr ds:[38D7h], 0E3h	;@0F22A
	call	L002C8	;@0F22F
	call	L002EE	;@0F232
	and	byte ptr ds:[38D7h], 0FDh	;@0F235
	db	0E9h, 93h, 0	; jmp @@16	;@0F23A
@@11:	call	far ptr L12787	;@0F23D
	test	word ptr ds:[5166h], 80h	;@0F242
	je	@@12	;@0F248
	mov	cx, 808Bh	;@0F24A
	call	L03208	;@0F24D
@@12:	db	0E8h, 0C6h, 10h	; call L00319	;@0F250
	db	9Ah, 1Ah, 33h	;@0F253
	dw	seg L0F9B0
	call	far ptr L11E1C	;@0F258
	mov	byte ptr ds:[38D7h], 8	;@0F25D
	dec	word ptr ds:[38C6h]	;@0F262
	mov	si, word ptr ds:[58B2h]	;@0F266
	cmp	byte ptr [si], 0	;@0F26A
	je	@@13	;@0F26D
	or	byte ptr ds:[38D7h], 10h	;@0F26F
	mov	di, word ptr ds:[58AEh]	;@0F274
	mov	dx, word ptr ds:[58B2h]	;@0F278
	mov	bx, word ptr ds:[572Ah]	;@0F27C
	mov	byte ptr ds:[58B7h], 0FFh	;@0F280
	call	far ptr L0FDBE	;@0F285
	mov	si, 0F5E5h	;@0F28A
	mov	di, 0F5FFh	;@0F28D
	jmp	short @@14	;@0F290
@@13:	mov	si, 0F5E8h	;@0F292
	mov	di, 0F36Ch	;@0F295
@@14:	mov	dx, word ptr ds:[58A8h]	;@0F298
	call	L044CB	;@0F29C
	or	byte ptr ds:[38D7h], 2	;@0F29F
	call	far ptr L12778	;@0F2A4
	mov	byte ptr ds:[38D8h], 0	;@0F2A9
	call	far ptr L12787	;@0F2AE
	test	byte ptr ds:[38D7h], 10h	;@0F2B3
	je	@@15	;@0F2B8
	call	far ptr L0FF43	;@0F2BA
	xor	al, al	;@0F2BF
	mov	byte ptr ds:[38D7h], al	;@0F2C1
	mov	byte ptr ds:[58B7h], al	;@0F2C4
	mov	si, word ptr ds:[58B2h]	;@0F2C7
	mov	byte ptr [si], al	;@0F2CB
@@15:	jmp	@@10	;@0F2CD
@@16:	mov	si, word ptr ds:[58B0h]	;@0F2D0
	cmp	byte ptr [si], 0	;@0F2D4
	je	@@17	;@0F2D7
	mov	dx, si	;@0F2D9
	mov	si, word ptr ds:[58AEh]	;@0F2DB
	mov	bx, word ptr ds:[572Ah]	;@0F2DF
	mov	byte ptr ds:[58B8h], 0FFh	;@0F2E3
	call	far ptr L12D6A	;@0F2E8
	mov	byte ptr ds:[58B8h], 0	;@0F2ED
	mov	byte ptr ds:[58B9h], 0FFh	;@0F2F2
@@17:	mov	si, word ptr ds:[58B2h]	;@0F2F7
	cmp	byte ptr [si], 0	;@0F2FB
	db	74h, 42h	; je @@18	;@0F2FE
	call	far ptr L12C9B	;@0F300
	mov	byte ptr ds:[38D7h], 11h	;@0F305
	mov	di, word ptr ds:[58AEh]	;@0F30A
	mov	dx, word ptr ds:[58B2h]	;@0F30E
	mov	bx, word ptr ds:[572Ah]	;@0F312
	mov	byte ptr ds:[58B7h], 0FFh	;@0F316
	call	far ptr L0FDBE	;@0F31B
	db	0E8h, 2Eh, 10h	; call L00351	;@0F320
	db	9Ah, 5Eh, 26h	;@0F323
	dw	seg L0F9B0
	mov	dx, word ptr ds:[58A8h]	;@0F328
	mov	si, 0F5E5h	;@0F32C
	mov	di, 0F5FFh	;@0F32F
	call	L044CB	;@0F332
	call	far ptr L0FF43	;@0F335
	xor	al, al	;@0F33A
	mov	byte ptr ds:[38D7h], al	;@0F33C
	mov	byte ptr ds:[58B7h], al	;@0F33F
@@18:	mov	si, word ptr ds:[58B4h]	;@0F342
	cmp	byte ptr [si], 0	;@0F346
	je	@@19	;@0F349
	mov	dx, si	;@0F34B
	mov	si, word ptr ds:[58ACh]	;@0F34D
	mov	bx, word ptr ds:[572Ah]	;@0F351
	mov	byte ptr ds:[58B7h], 0FFh	;@0F355
	call	far ptr L0FFD1	;@0F35A
	mov	byte ptr ds:[58B7h], 0	;@0F35F
@@19:	clc	;@0F364
	retf	;@0F365
L0F366:	xor	si, si	;@0F366
	jmp	word ptr ds:[5734h]	;@0F368
L0F36C:	cmp	byte ptr ds:[51A0h], 0	;@0F36C
	ret	;@0F371
L0F372:	mov	bx, dx	;@0F372
	call	far ptr L1134D	;@0F374
	ret	;@0F379
L0F37A:	call	L02622	;@0F37A
	call	L0F5E8	;@0F37D
	test	byte ptr ds:[38D8h], 1	;@0F380
	je	@@1	;@0F385
	mov	cx, 2Dh	;@0F387
	jmp	L03208	;@0F38A
@@1:	ret	;@0F38D
	db	9Ah	;@0F38E
	dd	L11699
	db	9Ah
	dd	L116B9
	db	0C3h
L0F399:	call	far ptr L1160D	;@0F399
	jae	L0F399	;@0F39E
@@1:	call	far ptr L11631	;@0F3A0
	jae	@@1	;@0F3A5
@@2:	call	far ptr L111FB	;@0F3A7
	jae	@@2	;@0F3AC
@@3:	call	L042D2	;@0F3AE
	jae	@@3	;@0F3B1
@@4:	call	L05319	;@0F3B3
	jae	@@4	;@0F3B6
@@5:	call	far ptr L12D51	;@0F3B8
	jae	@@5	;@0F3BD
	call	far ptr L0F9E5	;@0F3BF
	ret	;@0F3C4
L0F3C5:	mov	ax, word ptr ds:[5160h]	;@0F3C5
	test	ax, 1000h	;@0F3C8
	jne	@@4	;@0F3CB
	mov	word ptr ds:[5734h], 0F633h	;@0F3CD
	test	ax, 2000h	;@0F3D3
	jne	@@2	;@0F3D6
	mov	word ptr ds:[573Ch], 60h	;@0F3D8
	mov	word ptr ds:[573Ah], 16h	;@0F3DE
	test	ax, 4000h	;@0F3E4
	je	@@1	;@0F3E7
	mov	word ptr ds:[5736h], 5808h	;@0F3E9
	mov	word ptr ds:[5738h], 13h	;@0F3EF
	ret	;@0F3F5
@@1:	mov	word ptr ds:[5736h], 5800h	;@0F3F6
	mov	word ptr ds:[5738h], 17h	;@0F3FC
	ret	;@0F402
@@2:	mov	word ptr ds:[573Ch], 64h	;@0F403
	mov	word ptr ds:[573Ah], 17h	;@0F409
	test	ax, 4000h	;@0F40F
	je	@@3	;@0F412
	mov	word ptr ds:[5736h], 5808h	;@0F414
	mov	word ptr ds:[5738h], 14h	;@0F41A
	ret	;@0F420
@@3:	mov	word ptr ds:[5736h], 5800h	;@0F421
	mov	word ptr ds:[5738h], 18h	;@0F427
	ret	;@0F42D
@@4:	mov	word ptr ds:[5734h], 0F77Fh	;@0F42E
	ret	;@0F434
L0F435:	mov	cl, 4	;@0F435
	mov	ax, word ptr [si]	;@0F437
	add	ax, 0Fh	;@0F439
	shr	ax, cl	;@0F43C
	add	ax, word ptr [si+2]	;@0F43E
	mov	dx, word ptr [si+4]	;@0F441
	shr	dx, cl	;@0F444
	add	dx, word ptr [si+6]	;@0F446
	sub	dx, ax	;@0F449
	jbe	@@1	;@0F44B
	call	far ptr L0FAA6	;@0F44D
@@1:	ret	;@0F452
L0F453:	call	far ptr L1129C	;@0F453
	mov	byte ptr ds:[20BEh], al	;@0F458
	mov	byte ptr ds:[20C1h], al	;@0F45B
	mov	al, ch	;@0F45E
	call	@@5	;@0F460
	mov	word ptr ds:[20BCh], ax	;@0F463
	mov	al, cl	;@0F466
	call	@@5	;@0F468
	mov	word ptr ds:[20BFh], ax	;@0F46B
	mov	al, dh	;@0F46E
	call	@@5	;@0F470
	mov	word ptr ds:[20C2h], ax	;@0F473
	call	far ptr L11293	;@0F476
	mov	byte ptr ds:[20D4h], al	;@0F47B
	mov	byte ptr ds:[20D7h], al	;@0F47E
	mov	al, ch	;@0F481
	call	@@5	;@0F483
	mov	word ptr ds:[20D2h], ax	;@0F486
	mov	al, cl	;@0F489
	call	@@5	;@0F48B
	mov	word ptr ds:[20D5h], ax	;@0F48E
	mov	al, dh	;@0F491
	call	@@5	;@0F493
	mov	word ptr ds:[20D8h], ax	;@0F496
	mov	di, 20ECh	;@0F499
	mov	si, word ptr ds:[58ACh]	;@0F49C
	mov	cx, 8	;@0F4A0
	xor	dx, dx	;@0F4A3
	push	ss	;@0F4A5
	pop	es	;@0F4A6
@@1:	lodsb	;@0F4A7
	and	al, al	;@0F4A8
	je	@@2	;@0F4AA
	stosb	;@0F4AC
	inc	dx	;@0F4AD
	loop	@@1	;@0F4AE
	jmp	short @@3	;@0F4B0
@@2:	mov	al, 20h	;@0F4B2
	rep stosb	;@0F4B4
@@3:	mov	bx, word ptr ds:[58ACh]	;@0F4B6
	mov	cx, dx	;@0F4BA
	jcxz	@@4	;@0F4BC
	call	L003D0	;@0F4BE
	mov	es, word ptr ds:[575Eh]	;@0F4C1
	mov	ax, dx	;@0F4C5
	call	L0F529	;@0F4C7
@@4:	call	L0F50C	;@0F4CA
	mov	al, byte ptr ds:[58AAh]	;@0F4CD
	call	@@5	;@0F4D0
	mov	word ptr ds:[210Bh], ax	;@0F4D3
	mov	al, byte ptr ds:[58ABh]	;@0F4D6
	call	@@5	;@0F4D9
	mov	word ptr ds:[2104h], ax	;@0F4DC
	push	ds	;@0F4DF
	pop	es	;@0F4E0
	mov	di, 20B0h	;@0F4E1
	call	L0F37A	;@0F4E4
	push	ds	;@0F4E7
	pop	es	;@0F4E8
	mov	di, 20C6h	;@0F4E9
	call	L0F37A	;@0F4EC
	push	ds	;@0F4EF
	pop	es	;@0F4F0
	mov	di, 20DCh	;@0F4F1
	call	L0F37A	;@0F4F4
	push	ds	;@0F4F7
	pop	es	;@0F4F8
	mov	di, 20F6h	;@0F4F9
	jmp	L0F37A	;@0F4FC
@@5:	mov	ah, 2Fh	;@0F4FF
@@6:	inc	ah	;@0F501
	sub	al, 0Ah	;@0F503
	jae	@@6	;@0F505
	add	al, 3Ah	;@0F507
	xchg	al, ah	;@0F509
	ret	;@0F50B
L0F50C:	mov	ax, word ptr ds:[5160h]	;@0F50C
	mov	cx, ax	;@0F50F
	and	ax, 0D9Eh	;@0F511
	or	al, 1	;@0F514
	mov	bx, 210Eh	;@0F516
	call	L0F537	;@0F519
	mov	bx, 210Eh	;@0F51C
	mov	cx, 5	;@0F51F
	call	L003DA	;@0F522
	mov	es, word ptr ds:[5760h]	;@0F525
L0F529:	push	ax	;@0F529
	call	L016C5	;@0F52A
	pop	ax	;@0F52D
	jne	@@1	;@0F52E
	call	L035AC	;@0F530
	jmp	L017DC	;@0F533
@@1:	ret	;@0F536
L0F537:	push	ax	;@0F537
	mov	al, ah	;@0F538
	call	@@1	;@0F53A
	pop	ax	;@0F53D
@@1:	mov	ah, al	;@0F53E
	mov	cl, 4	;@0F540
	shr	al, cl	;@0F542
	call	@@2	;@0F544
	mov	al, ah	;@0F547
	and	al, 0Fh	;@0F549
@@2:	add	al, 30h	;@0F54B
	cmp	al, 39h	;@0F54D
	jbe	@@3	;@0F54F
	add	al, 7	;@0F551
@@3:	mov	byte ptr [bx], al	;@0F553
	inc	bx	;@0F555
	ret	;@0F556
L0F557:	test	byte ptr ds:[38D7h], 10h	;@0F557
	jne	@@1	;@0F55C
	jmp	L02640	;@0F55E
@@1:	call	L0F5FF	;@0F561
	call	L02640	;@0F564
	push	si	;@0F567
	call	@@3	;@0F568
	pop	si	;@0F56B
	test	word ptr ds:[5198h], 1	;@0F56C
	jne	@@2	;@0F572
	call	far ptr L100D0	;@0F574
@@2:	ret	;@0F579
@@3:	mov	byte ptr ds:[519Fh], 0	;@0F57A
	push	si	;@0F57F
	mov	ax, word ptr ds:[5152h]	;@0F580
	mov	dx, word ptr ds:[515Eh]	;@0F583
	call	far ptr L11699	;@0F587
	push	ax	;@0F58C
	call	far ptr L116B9	;@0F58D
	pop	ax	;@0F592
	call	far ptr L100A5	;@0F593
	mov	dx, word ptr ds:[515Eh]	;@0F598
	call	far ptr L116B9	;@0F59C
	pop	bx	;@0F5A1
	cmp	dl, 1	;@0F5A2
	jne	@@4	;@0F5A5
	call	far ptr L10060	;@0F5A7
	call	far ptr L1168C	;@0F5AC
	call	far ptr L100B8	;@0F5B1
	test	word ptr ds:[5198h], 8	;@0F5B6
	jne	@@5	;@0F5BC
	call	far ptr L100D0	;@0F5BE
	ret	;@0F5C3
@@4:	call	far ptr L10060	;@0F5C4
	call	far ptr L1168C	;@0F5C9
	and	ax, ax	;@0F5CE
	je	@@5	;@0F5D0
	call	far ptr L100B8	;@0F5D2
	test	word ptr ds:[5198h], 4	;@0F5D7
	jne	@@5	;@0F5DD
	call	far ptr L100D0	;@0F5DF
@@5:	ret	;@0F5E4
	db	0E8h, 92h, 0FFh	;@0F5E5
L0F5E8:	xor	ax, ax	;@0F5E8
	mov	byte ptr ds:[38D8h], al	;@0F5EA
	mov	si, ax	;@0F5ED
	jmp	word ptr ds:[5734h]	;@0F5EF
	db	90h, 33h, 0C0h, 0A2h, 0D8h, 38h, 8Bh, 0F0h, 0FFh, '&4W'	;@0F5F3
L0F5FF:	call	far ptr L12018	;@0F5FF
	cmp	byte ptr ds:[519Fh], 0	;@0F604
	je	@@2	;@0F609
@@1:	call	far ptr L101EC	;@0F60B
	cmp	byte ptr ds:[51A0h], 0	;@0F610
	ret	;@0F615
@@2:	test	word ptr ds:[5198h], 20h	;@0F616
	jne	@@1	;@0F61C
	mov	dx, word ptr ds:[515Eh]	;@0F61E
	call	far ptr L116B9	;@0F622
	test	dl, 1	;@0F627
	je	@@1	;@0F62A
	call	far ptr L100D0	;@0F62C
	jmp	@@1	;@0F631
	db	0E8h, 0FDh, 5Ch, 0E8h, 37h, 27h, 51h, 0E8h, 38h, 27h, 'YuG', 8Bh	;@0F633
	db	0D8h, 83h, 0C6h, 2, 22h, 0E4h, 74h, 3Bh, 89h, 0Eh, '0WSR', 0E8h
	db	1Eh, 27h, 89h, 0Eh, 32h, 57h, 0E8h, 1Ch, 27h, 8Bh, 0C8h, 8Bh, 0FAh
	db	'Z[u2', 83h, 3Eh, 94h, 51h, 0, 75h, 59h, 8Bh, 0C3h, 2Bh, 6, '.WrJ;'
	db	6, '<WsD;', 0Eh, 8, 'XtE;', 0Eh, 0Ah, 'Xt?', 0EBh, 2Ah, 0E9h, 0ECh
	db	0, 0E9h, 4Dh, 2, 83h, 0C6h, 2, 0E9h, 3Bh, 0B9h, 0E9h, 36h, 0B9h
	db	8Bh, 0C2h, 0E8h, 0DFh, 11h, 74h, 52h, 8Bh, 0C2h, 0E8h, 0B4h, 11h
	db	74h, 0EFh, 8Bh, 0C3h, 2Bh, 6, '.Wrg=$', 4, 73h, 62h, 8Bh, 0F8h
	db	8Eh, 0C3h, 0E8h, 8Ch, 0Fh, 0FFh, 0A5h, 44h, 21h, 0C3h, 8Bh, 0C2h
	db	0E8h, 0B8h, 11h, 74h, 2Bh, 8Bh, 0C7h, 22h, 0E4h, 74h, 5, 0E8h
	db	89h, 11h, 74h, 0BEh, 8Bh, 0C1h, 16h, 7, 8Bh, '>6W', 8Bh, 0Eh, 38h
	db	57h, 0F2h, 0AFh, 75h, 0BEh, 83h, 0C6h, 2, 8Bh, '>:W+', 0F9h, 0D1h
	db	0E7h, 0FFh, 0A5h, 14h, 21h, 0C3h, 3Bh, 0Eh, 'DWt', 0CFh, 0F6h
	db	6, 0D7h, 38h, 2, 75h, 0F2h, 8Bh, 0DAh, 0E8h, 0D9h, 1, 75h, 0EBh
	db	0E8h, 0EDh, 3Eh, 0E8h, 50h, 1, 0C6h, 6, 9Fh, 51h, 0FFh, 8Bh, 0C2h
	db	0E9h, 53h, 27h, 0E8h, 0C4h, 1, 75h, 5Bh, 8Bh, 0C2h, 0E8h, 15h
	db	11h, 75h, 19h, 0E8h, 37h, 1, 83h, 0EEh, 2, 0E8h, 93h, '/uI', 0E8h
	db	26h, 1, 0E8h, 'C&Q', 0E8h, 87h, 2Fh, 59h, 0E9h, 0Bh, 0FFh, 0E8h
	db	'=&u""', 0E4h, 74h, 1Eh, 8Bh, 0C2h, 0E8h, 0, 11h, 75h, 17h, 0E8h
	db	0Eh, 1, 0E8h, 6Dh, 2Fh, 83h, 0EEh, 2, 0E8h, 0FFh, 0, 0E8h, 1Ch
	db	26h, 51h, 0E8h, '"&Y', 0E9h, 0E4h, 0FEh, 50h, 83h, 0EEh, 2, 0E8h
	db	12h, 26h, 59h, 8Bh, 0C2h, 0E8h, 0Eh, 11h, 74h, 81h, 8Eh, 0C0h
	db	0E9h, 0A9h, 0, 0E9h, 0E9h, 2Eh, 0E8h, 61h, 1, 75h, 6, 0B9h, 61h
	db	0, 0E9h, 8Ah, 3Ah, 0C3h, 0E8h, 0B1h, 5Bh, 0E8h, 0F5h, '%uA"', 0E4h
	db	74h, 0E8h, 8Bh, 0D8h, 8Bh, 0C2h, 0E8h, 0E5h, 10h, 74h, 1Bh, 8Bh
	db	0C3h, 2Bh, 6, ',Wr0=', 0B8h, 3, 73h, 2Bh, 83h, 0C6h, 2, 8Bh, 0F8h
	db	8Eh, 0C2h, 0E8h, 96h, 0Eh, 0FFh, 0A5h, 66h, 21h, 8Bh, 0DAh, 0E8h
	db	23h, 1, 75h, 15h, 83h, 0C6h, 2, 0F6h, 6, 0D7h, 38h, 2, 75h, 0Bh
	db	0E8h, 2Dh, 3Eh, 8Bh, 0C2h, 0E9h, 9Bh, 26h, 0E9h, 0Ch, 1, 0C3h
	db	8Bh, 0C2h, 0E8h, 82h, 10h, 't*SR', 83h, 0C6h, 2, 0E8h, 9Fh, '%Y[u3R'
	db	8Bh, 0D1h, 16h, 7, 0BFh, 0, 58h, 0B9h, 0Eh, 0, 0F2h, 0AFh, 58h
	db	75h, 14h, 83h, 0C6h, 2, 0BFh, 0Dh, 0, 2Bh, 0F9h, 0D1h, 0E7h, 0FFh
	db	0A5h, 14h, 21h, 83h, 0C6h, 2, 0E9h, 0C6h, 0B7h, 22h, 0E4h, 74h
	db	0Bh, 0E8h, 49h, 10h, 75h, 6, 83h, 0C6h, 2, 0E9h, 0B9h, 0B7h, 0E8h
	db	0C2h, 0, 75h, 11h, 8Eh, 0C2h, 0E8h, 25h, 0Eh, 0F6h, 6, 0D7h, 38h
	db	0Bh, 75h, 8, 80h, 0Eh, 0D8h, 38h, 3, 0E9h, 31h, 2Eh, 0B9h, 8, 0
	db	0E8h, 0D7h, 39h, 0E9h, 28h, 2Eh
L0F834:	mov	cx, 68h	;@0F834
	jmp	L03208	;@0F837
L0F83A:	call	L026B8	;@0F83A
	jne	@@1	;@0F83D
	call	L0265C	;@0F83F
	mov	cx, 6	;@0F842
	jmp	L03208	;@0F845
@@1:	ret	;@0F848
L0F849:	mov	cx, word ptr ds:[5730h]	;@0F849
	jmp	L01D9B	;@0F84D
	db	0A1h, 30h, 57h, 0E9h, 0F9h, 25h	;@0F850
L0F856:	test	word ptr ds:[5160h], 1000h	;@0F856
	jne	@@1	;@0F85C
	mov	ax, word ptr ds:[5732h]	;@0F85E
	jmp	L01E4F	;@0F861
@@1:	ret	;@0F864
L0F865:	call	L0F8D7	;@0F865
	jne	@@1	;@0F868
	test	byte ptr ds:[51A3h], 80h	;@0F86A
	jne	@@2	;@0F86F
@@1:	ret	;@0F871
@@2:	cmp	word ptr ds:[5194h], 0	;@0F872
	jne	@@3	;@0F877
	and	byte ptr ds:[51A3h], 7Fh	;@0F879
	push	bx	;@0F87E
	push	cx	;@0F87F
	push	dx	;@0F880
	call	L0265C	;@0F881
	call	L07203	;@0F884
	pop	dx	;@0F887
	pop	cx	;@0F888
	pop	bx	;@0F889
	xor	al, al	;@0F88A
	dec	al	;@0F88C
	ret	;@0F88E
@@3:	xor	al, al	;@0F88F
	ret	;@0F891
L0F892:	test	byte ptr ds:[38D7h], 1	;@0F892
	je	L0F8EB	;@0F897
	test	word ptr ds:[5198h], 2	;@0F899
	jne	L0F8EB	;@0F89F
	call	far ptr L100D0	;@0F8A1
	jmp	short L0F8EB	;@0F8A6
L0F8A8:	test	byte ptr ds:[38D7h], 1	;@0F8A8
	je	@@1	;@0F8AD
	test	word ptr ds:[5198h], 2	;@0F8AF
	jne	L0F8EB	;@0F8B5
	call	far ptr L100D0	;@0F8B7
	jmp	short L0F8EB	;@0F8BC
@@1:	xor	al, al	;@0F8BE
	dec	al	;@0F8C0
	ret	;@0F8C2
L0F8C3:	test	byte ptr ds:[38D7h], 1	;@0F8C3
	je	L0F8EB	;@0F8C8
	test	word ptr ds:[5198h], 10h	;@0F8CA
	jne	L0F8D7	;@0F8D0
	call	far ptr L100D0	;@0F8D2
L0F8D7:	test	byte ptr ds:[38D7h], 1	;@0F8D7
	je	L0F8EB	;@0F8DC
	test	word ptr ds:[5198h], 1	;@0F8DE
	jne	L0F8EB	;@0F8E4
	call	far ptr L100D0	;@0F8E6
L0F8EB:	cmp	byte ptr ds:[51A7h], 0	;@0F8EB
	jne	@@1	;@0F8F0
	ret	;@0F8F2
@@1:	test	byte ptr ds:[38D7h], 1	;@0F8F3
	je	@@2	;@0F8F8
	test	word ptr ds:[5198h], 10h	;@0F8FA
	jne	@@3	;@0F900
	call	far ptr L100D0	;@0F902
@@2:	xor	al, al	;@0F907
	dec	al	;@0F909
@@3:	ret	;@0F90B
L0F90C:	call	L0A7C0	;@0F90C
	jne	@@1	;@0F90F
	ret	;@0F911
@@1:	call	L05542	;@0F912
	mov	cx, 0Dh	;@0F915
	jmp	L03208	;@0F918
L0F91B:	call	L0A7C0	;@0F91B
L0F91E:	jne	@@1	;@0F91E
	call	L026B8	;@0F920
	jne	@@2	;@0F923
	cmp	ax, word ptr ds:[5838h]	;@0F925
	jne	@@2	;@0F929
	add	si, 2	;@0F92B
	push	es	;@0F92E
	call	L0A7C0	;@0F92F
	pop	ax	;@0F932
	jne	@@3	;@0F933
	ret	;@0F935
@@1:	call	L05542	;@0F936
@@2:	push	es	;@0F939
	call	L05542	;@0F93A
	pop	ax	;@0F93D
	mov	cx, 0Dh	;@0F93E
	jmp	L03208	;@0F941
@@3:	push	ax	;@0F944
	call	L05542	;@0F945
	pop	ax	;@0F948
	mov	cx, 0Ah	;@0F949
	test	word ptr ds:[5160h], 2000h	;@0F94C
	jne	@@4	;@0F952
	or	cx, 8000h	;@0F954
@@4:	call	L03208	;@0F958
	ret	;@0F95B
L0F95C:	call	L0A7C0	;@0F95C
	jne	@@1	;@0F95F
	call	L026B8	;@0F961
	jne	@@2	;@0F964
	cmp	ax, word ptr ds:[5838h]	;@0F966
	jne	@@2	;@0F96A
	add	si, 2	;@0F96C
	push	es	;@0F96F
	call	L0A7C0	;@0F970
	pop	ax	;@0F973
	jne	@@4	;@0F974
	push	ax	;@0F976
	call	L026B8	;@0F977
	pop	dx	;@0F97A
	jne	@@3	;@0F97B
	cmp	ax, word ptr ds:[5838h]	;@0F97D
	jne	@@3	;@0F981
	add	si, 2	;@0F983
	push	es	;@0F986
	push	dx	;@0F987
	call	L0A7C0	;@0F988
	pop	dx	;@0F98B
	pop	ax	;@0F98C
	jne	@@5	;@0F98D
	ret	;@0F98F
@@1:	call	L05542	;@0F990
@@2:	push	es	;@0F993
	call	L05542	;@0F994
	pop	ax	;@0F997
@@3:	push	ax	;@0F998
	push	es	;@0F999
	call	L05542	;@0F99A
	pop	ax	;@0F99D
	pop	dx	;@0F99E
	mov	cx, 0Dh	;@0F99F
	push	dx	;@0F9A2
	call	L03208	;@0F9A3
	pop	dx	;@0F9A6
	ret	;@0F9A7
@@4:	push	ax	;@0F9A8
	call	L05542	;@0F9A9
	pop	dx	;@0F9AC
	mov	ax, es	;@0F9AD
@@5:	push	dx	;@0F9AF
CODE0	ends
	end
